import psycopg
from fastapi import APIRouter, HTTPException, Request, Response
from psycopg_pool import AsyncConnectionPool, PoolTimeout

from . import app_queries, investigations, source_queries
from .config import Settings
from .invoices import load_invoice_detail, load_receivables, load_trend
from .schemas import (
    ARTrend,
    DatabaseStatus,
    Health,
    InvestigationRequest,
    InvestigationResult,
    InvoiceDetail,
    ModelStatus,
    Receivables,
)

router = APIRouter()


async def _database_status(pool: AsyncConnectionPool) -> DatabaseStatus:
    try:
        async with pool.connection(timeout=2) as conn:
            as_of = await source_queries.fetch_dataset_as_of(conn)
            if as_of is None:
                return DatabaseStatus(ready=False, error="source_not_restored")
            try:
                await app_queries.check_app_table(conn)
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


@router.get("/receivables", response_model=Receivables)
async def list_receivables(request: Request) -> Receivables:
    async with request.app.state.pool.connection() as conn:
        return await load_receivables(conn)


@router.get("/receivables/trend", response_model=ARTrend)
async def receivables_trend(request: Request) -> ARTrend:
    async with request.app.state.pool.connection() as conn:
        return await load_trend(conn)


@router.get("/invoices/{invoice_id}", response_model=InvoiceDetail)
async def get_invoice(request: Request, invoice_id: str) -> InvoiceDetail:
    async with request.app.state.pool.connection() as conn:
        detail = await load_invoice_detail(conn, invoice_id)
        if detail is None:
            raise HTTPException(404, {"code": "invoice_not_found", "message": "Invoice not found."})
        detail.investigation = await investigations.investigation_state(conn, detail, request.app.state.settings)
    return detail


@router.post("/invoices/{invoice_id}/investigations", response_model=InvestigationResult)
async def assess_invoice(request: Request, invoice_id: str, body: InvestigationRequest) -> InvestigationResult:
    app = request.app
    return await investigations.investigate(app.state.pool, app.state.settings, app.state.assessor, invoice_id, body.refresh)
