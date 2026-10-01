from contextlib import asynccontextmanager

from fastapi import FastAPI

from .config import Settings
from .db import create_pool
from .routes import router


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
    app.include_router(router, prefix="/api")
    return app


app = create_app()
