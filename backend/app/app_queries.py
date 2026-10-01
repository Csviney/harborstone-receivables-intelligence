from psycopg import AsyncConnection


async def check_app_tables(conn: AsyncConnection) -> None:
    await conn.execute(
        "SELECT"
        " (SELECT 1 FROM app.investigations LIMIT 0),"
        " (SELECT 1 FROM app.drafts LIMIT 0),"
        " (SELECT 1 FROM app.activity_events LIMIT 0)"
    )
