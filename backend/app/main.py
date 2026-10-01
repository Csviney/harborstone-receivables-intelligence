from contextlib import asynccontextmanager

import psycopg
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from psycopg_pool import PoolTimeout

from .config import Settings
from .db import create_pool
from .routes import router


async def database_error(request: Request, exc: Exception) -> JSONResponse:
    return JSONResponse(
        status_code=503,
        content={"detail": {"code": "database_unavailable", "message": "Source data is unavailable."}},
    )


def create_app(settings: Settings | None = None) -> FastAPI:
    @asynccontextmanager
    async def lifespan(app: FastAPI):
        app.state.settings = settings or Settings()
        # Don't block startup on the database; /api/health reports its state.
        app.state.pool = create_pool(app.state.settings.database_url)
        await app.state.pool.open(wait=False)
        try:
            yield
        finally:
            await app.state.pool.close()

    app = FastAPI(title="Harborstone receivables review", lifespan=lifespan)
    app.add_exception_handler(psycopg.Error, database_error)
    app.add_exception_handler(PoolTimeout, database_error)
    app.include_router(router, prefix="/api")
    return app


app = create_app()
