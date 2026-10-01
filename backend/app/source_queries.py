from datetime import date

from psycopg import AsyncConnection


async def fetch_dataset_as_of(conn: AsyncConnection) -> date | None:
    cur = await conn.execute(
        "SELECT value::date AS as_of FROM source_company.dataset_metadata WHERE key = %s",
        ("dataset_as_of",),
    )
    row = await cur.fetchone()
    return row["as_of"] if row else None
