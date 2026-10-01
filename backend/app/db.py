from psycopg.rows import dict_row
from psycopg_pool import AsyncConnectionPool


def create_pool(database_url: str) -> AsyncConnectionPool:
    return AsyncConnectionPool(
        database_url,
        min_size=1,
        max_size=5,
        open=False,
        timeout=5,
        kwargs={
            "row_factory": dict_row,
            "options": "-c timezone=UTC",
            "application_name": "harborstone-api",
        },
    )
