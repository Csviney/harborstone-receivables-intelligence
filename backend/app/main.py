import logging
from contextlib import asynccontextmanager

import psycopg
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from psycopg_pool import PoolTimeout

from . import agent, app_queries
from .config import Settings
from .db import create_pool
from .investigations import InvestigationError
from .invoices import SourceNotLoaded
from .routes import router

log = logging.getLogger(__name__)


def _error(status: int, code: str, message: str, investigation_id: str | None = None) -> JSONResponse:
    detail = {"code": code, "message": message}
    if investigation_id:
        detail["investigation_id"] = investigation_id
    return JSONResponse(status_code=status, content={"detail": detail})


async def database_error(request: Request, exc: Exception) -> JSONResponse:
    return _error(503, "database_unavailable", "Source data is unavailable.")


async def source_not_loaded(request: Request, exc: Exception) -> JSONResponse:
    return _error(503, "source_not_restored", "Source data is not loaded.")


async def investigation_error(request: Request, exc: InvestigationError) -> JSONResponse:
    return _error(exc.status, exc.code, exc.message, exc.investigation_id)


async def _mark_interrupted_runs(pool) -> None:
    try:
        async with pool.connection(timeout=2) as conn:
            count = await app_queries.mark_interrupted(conn)
        if count:
            log.warning("Marked %d unfinished assessment(s) as interrupted", count)
    except (psycopg.Error, PoolTimeout):
        log.warning("Could not check for unfinished assessments; database unavailable")


def create_app(settings: Settings | None = None, assessor=None) -> FastAPI:
    @asynccontextmanager
    async def lifespan(app: FastAPI):
        app.state.settings = settings or Settings()
        app.state.assessor = assessor or agent.run_assessment
        # Don't block startup on the database; /api/health reports its state.
        app.state.pool = create_pool(app.state.settings.database_url)
        await app.state.pool.open(wait=False)
        # Single worker: anything still marked running was cut off by a restart.
        await _mark_interrupted_runs(app.state.pool)
        try:
            yield
        finally:
            await app.state.pool.close()

    app = FastAPI(title="Harborstone receivables review", lifespan=lifespan)
    app.add_exception_handler(psycopg.Error, database_error)
    app.add_exception_handler(PoolTimeout, database_error)
    app.add_exception_handler(SourceNotLoaded, source_not_loaded)
    app.add_exception_handler(InvestigationError, investigation_error)
    app.include_router(router, prefix="/api")
    return app


app = create_app()
