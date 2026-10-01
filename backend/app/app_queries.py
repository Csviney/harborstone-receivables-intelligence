from datetime import date

from psycopg import AsyncConnection
from psycopg.types.json import Jsonb

INVESTIGATION_COLUMNS = (
    "id::text, input_hash, status, input_json, output_json, trace_json, started_at, finished_at, error_code,"
    " error_message"
)


async def check_app_table(conn: AsyncConnection) -> None:
    await conn.execute("SELECT 1 FROM app.investigations LIMIT 0")


async def latest_investigation(
    conn: AsyncConnection, invoice_id: str, *, status: str | None = None, input_hash: str | None = None
) -> dict | None:
    cur = await conn.execute(
        f"SELECT {INVESTIGATION_COLUMNS} FROM app.investigations"
        " WHERE invoice_id = %(invoice_id)s"
        " AND (%(status)s::text IS NULL OR status = %(status)s)"
        " AND (%(input_hash)s::text IS NULL OR input_hash = %(input_hash)s)"
        " ORDER BY started_at DESC LIMIT 1",
        {"invoice_id": invoice_id, "status": status, "input_hash": input_hash},
    )
    return await cur.fetchone()


async def get_investigation(conn: AsyncConnection, investigation_id: str) -> dict | None:
    cur = await conn.execute(f"SELECT {INVESTIGATION_COLUMNS} FROM app.investigations WHERE id = %s", (investigation_id,))
    return await cur.fetchone()


async def insert_running(
    conn: AsyncConnection, *, invoice_id: str, snapshot_as_of: date, input_hash: str,
    analysis_version: str, model: str, input_json: dict,
) -> str:
    cur = await conn.execute(
        "INSERT INTO app.investigations"
        " (invoice_id, snapshot_as_of, input_hash, analysis_version, model, status, input_json)"
        " VALUES (%s, %s, %s, %s, %s, 'running', %s) RETURNING id::text",
        (invoice_id, snapshot_as_of, input_hash, analysis_version, model, Jsonb(input_json)),
    )
    return (await cur.fetchone())["id"]


async def complete(conn: AsyncConnection, investigation_id: str, *, output: dict, trace: dict, usage: dict | None) -> None:
    await conn.execute(
        "UPDATE app.investigations SET status = 'completed', output_json = %s, trace_json = %s,"
        " usage_json = %s, finished_at = now() WHERE id = %s",
        (Jsonb(output), Jsonb(trace), usage and Jsonb(usage), investigation_id),
    )


async def fail(
    conn: AsyncConnection, investigation_id: str, *, code: str, message: str, trace: dict, usage: dict | None,
    output: dict | None = None,
) -> None:
    await conn.execute(
        "UPDATE app.investigations SET status = 'failed', error_code = %s, error_message = %s,"
        " output_json = %s, trace_json = %s, usage_json = %s, finished_at = now()"
        " WHERE id = %s AND status = 'running'",
        (code, message, output and Jsonb(output), Jsonb(trace), usage and Jsonb(usage), investigation_id),
    )


async def mark_interrupted(conn: AsyncConnection) -> int:
    cur = await conn.execute(
        "UPDATE app.investigations SET status = 'failed', error_code = 'interrupted',"
        " error_message = 'The server stopped before this assessment finished.', finished_at = now()"
        " WHERE status = 'running'"
    )
    return cur.rowcount
