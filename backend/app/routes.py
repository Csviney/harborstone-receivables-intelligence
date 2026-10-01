import psycopg
from fastapi import APIRouter, Request, Response
from psycopg_pool import AsyncConnectionPool, PoolTimeout

from . import app_queries, source_queries
from .config import Settings
from .schemas import DatabaseStatus, Health, ModelStatus

router = APIRouter()


async def _database_status(pool: AsyncConnectionPool) -> DatabaseStatus:
    try:
        async with pool.connection(timeout=2) as conn:
            as_of = await source_queries.fetch_dataset_as_of(conn)
            if as_of is None:
                return DatabaseStatus(ready=False, error="source_not_restored")
            try:
                await app_queries.check_app_tables(conn)
            except psycopg.errors.UndefinedTable:
                return DatabaseStatus(ready=False, dataset_as_of=as_of, error="app_schema_missing")
            return DatabaseStatus(ready=True, dataset_as_of=as_of)
    except (psycopg.errors.UndefinedTable, psycopg.errors.InvalidSchemaName):
        return DatabaseStatus(ready=False, error="source_not_restored")
    except psycopg.errors.InsufficientPrivilege:
        return DatabaseStatus(ready=False, error="permission_denied")
    except (PoolTimeout, psycopg.OperationalError):
        return DatabaseStatus(ready=False, error="database_unavailable")


@router.get("/health", response_model=Health)
async def health(request: Request, response: Response) -> Health:
    settings: Settings = request.app.state.settings
    database = await _database_status(request.app.state.pool)
    model = ModelStatus(
        assessment_available=settings.assessment_available,
        model=settings.openai_model if settings.assessment_available else None,
    )
    if not database.ready:
        response.status_code = 503
    return Health(status="ok" if database.ready else "unavailable", database=database, model=model)
