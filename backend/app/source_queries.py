from datetime import date

from psycopg import AsyncConnection

# Source timestamps are reported as UTC calendar dates.
INVOICES = """
SELECT i.id, i.invoice_number, i.status, i.total, i.subtotal, i.tax_amount, i.notes,
       (i.invoice_date AT TIME ZONE 'UTC')::date AS invoice_date,
       (i.due_date AT TIME ZONE 'UTC')::date AS due_date,
       (i.posting_date AT TIME ZONE 'UTC')::date AS posting_date,
       (i.sent_date AT TIME ZONE 'UTC')::date AS sent_date,
       (i.approval_date AT TIME ZONE 'UTC')::date AS approval_date,
       i.company_id, c.name AS customer_name, i.contact_id, i.opportunity_id, i.document_id,
       o.legacy_opportunity_number AS job_number, o.site_name AS job_name,
       pr.project_count, pr.project_status
FROM source_company.ar_invoices i
LEFT JOIN source_company.companies c ON c.id = i.company_id
LEFT JOIN source_company.opportunities o ON o.id = i.opportunity_id
LEFT JOIN LATERAL (
    SELECT count(*) AS project_count,
           CASE WHEN count(*) = 1 THEN max(p.status) END AS project_status
    FROM source_company.projects p
    WHERE p.opportunity_id = i.opportunity_id
) pr ON true
"""

PAYMENTS = """
SELECT id, invoice_id, (payment_date AT TIME ZONE 'UTC')::date AS payment_date,
       amount, payment_method, reference_number
FROM source_company.ar_payments
"""

INVOICE_NOTES = """
SELECT id, invoice_id, (created_at AT TIME ZONE 'UTC')::date AS note_date, created_by_email, content
FROM source_company.ar_invoice_notes
"""


async def fetch_dataset_as_of(conn: AsyncConnection) -> date | None:
    cur = await conn.execute(
        "SELECT value::date AS as_of FROM source_company.dataset_metadata WHERE key = %s",
        ("dataset_as_of",),
    )
    row = await cur.fetchone()
    return row["as_of"] if row else None


async def fetch_invoices(conn: AsyncConnection) -> list[dict]:
    cur = await conn.execute(INVOICES)
    return await cur.fetchall()


async def fetch_invoice(conn: AsyncConnection, invoice_id: str) -> dict | None:
    cur = await conn.execute(INVOICES + " WHERE i.id = %s", (invoice_id,))
    return await cur.fetchone()


async def fetch_payments(conn: AsyncConnection, invoice_id: str | None = None) -> list[dict]:
    if invoice_id is None:
        cur = await conn.execute(PAYMENTS + " ORDER BY payment_date, id")
    else:
        cur = await conn.execute(PAYMENTS + " WHERE invoice_id = %s ORDER BY payment_date, id", (invoice_id,))
    return await cur.fetchall()


async def fetch_invoice_notes(conn: AsyncConnection, invoice_id: str | None = None) -> list[dict]:
    if invoice_id is None:
        cur = await conn.execute(INVOICE_NOTES + " ORDER BY created_at, id")
    else:
        cur = await conn.execute(INVOICE_NOTES + " WHERE invoice_id = %s ORDER BY created_at, id", (invoice_id,))
    return await cur.fetchall()


async def fetch_invoice_context(conn: AsyncConnection, invoice: dict) -> dict:
    """Customer, job, assignment, and document records linked to one invoice."""
    cur = await conn.execute(
        "SELECT id, name, notes, billing_contact_id FROM source_company.companies WHERE id = %s",
        (invoice["company_id"],),
    )
    company = await cur.fetchone()

    contact_ids = [i for i in (invoice["contact_id"], company and company["billing_contact_id"]) if i]
    cur = await conn.execute(
        "SELECT id, company_id, first_name, last_name, email, phone, title"
        " FROM source_company.contacts WHERE id = ANY(%s)",
        (contact_ids,),
    )
    contacts = {row["id"]: row for row in await cur.fetchall()}

    cur = await conn.execute(
        """
        SELECT o.id, o.legacy_opportunity_number AS job_number, o.site_name, o.status,
               rb.name AS reporting_branch, ob.name AS operating_branch
        FROM source_company.opportunities o
        LEFT JOIN source_company.branches rb ON rb.id = o.reporting_branch_id
        LEFT JOIN source_company.branches ob ON ob.id = o.operating_branch_id
        WHERE o.id = %s
        """,
        (invoice["opportunity_id"],),
    )
    opportunity = await cur.fetchone()

    cur = await conn.execute(
        "SELECT id, project_number, status, (actual_completion_date AT TIME ZONE 'UTC')::date AS completed_on"
        " FROM source_company.projects WHERE opportunity_id = %s ORDER BY project_number",
        (invoice["opportunity_id"],),
    )
    projects = await cur.fetchall()

    cur = await conn.execute(
        """
        SELECT ea.id, ea.capacity, e.display_name AS employee_name, e.job_title
        FROM source_company.engagement_assignments ea
        LEFT JOIN source_company.employees e ON e.id = ea.employee_id
        WHERE ea.opportunity_id = %s
        ORDER BY ea.capacity, e.display_name
        """,
        (invoice["opportunity_id"],),
    )
    assignments = await cur.fetchall()

    cur = await conn.execute(
        "SELECT id, project_id, (created_at AT TIME ZONE 'UTC')::date AS note_date, created_by_email, content"
        " FROM source_company.project_notes WHERE project_id = ANY(%s) ORDER BY created_at, id",
        ([p["id"] for p in projects],),
    )
    project_notes = await cur.fetchall()

    cur = await conn.execute(
        "SELECT id, original_filename FROM source_company.documents WHERE id = %s",
        (invoice["document_id"],),
    )
    document = await cur.fetchone()

    return {
        "company": company,
        "contacts": contacts,
        "opportunity": opportunity,
        "projects": projects,
        "assignments": assignments,
        "project_notes": project_notes,
        "document": document,
    }
