from collections import defaultdict

from psycopg import AsyncConnection

from . import receivables, source_queries
from .schemas import (
    Assignment,
    Bucket,
    Calculation,
    Contact,
    Customer,
    Document,
    InvoiceDetail,
    InvoicePosition,
    Issue,
    Job,
    PaymentRecord,
    Receivables,
    SourceNote,
    Summary,
)

SUMMARY_SCOPE = (
    "Outstanding AR covers invoices currently marked SENT and sent on or before the snapshot date, "
    "less recorded payments. Unsent billing is invoice face value. USD assumed for this demo."
)


class SourceNotLoaded(Exception):
    pass


def ref(table: str, record_id: str) -> str:
    return f"source_company.{table}:{record_id}"


async def load_receivables(conn: AsyncConnection) -> Receivables:
    as_of = await _as_of(conn)
    rows = await source_queries.fetch_invoices(conn)
    payments = _group(await source_queries.fetch_payments(conn))
    notes = _group(await source_queries.fetch_invoice_notes(conn))

    positions = {
        row["id"]: receivables.position(receivables.invoice_from_rows(row, payments[row["id"]], notes[row["id"]]), as_of)
        for row in rows
    }
    ordered = sorted(rows, key=lambda row: receivables.sort_key(positions[row["id"]]))
    summary = receivables.summarize(positions.values(), as_of)
    return Receivables(
        as_of=as_of,
        summary=Summary(
            outstanding=Bucket(**vars(summary.outstanding)),
            overdue=Bucket(**vars(summary.overdue)),
            not_yet_due=Bucket(**vars(summary.not_yet_due)),
            unsent_billing=Bucket(**vars(summary.unsent_billing)),
            sync_failed=Bucket(**vars(summary.sync_failed)),
            scope=SUMMARY_SCOPE,
            limitations=list(summary.limitations),
        ),
        invoices=[_position_out(row, positions[row["id"]]) for row in ordered],
    )


async def load_invoice_detail(conn: AsyncConnection, invoice_id: str) -> InvoiceDetail | None:
    as_of = await _as_of(conn)
    row = await source_queries.fetch_invoice(conn, invoice_id)
    if row is None:
        return None
    payments = await source_queries.fetch_payments(conn, invoice_id)
    notes = await source_queries.fetch_invoice_notes(conn, invoice_id)
    context = await source_queries.fetch_invoice_context(conn, row)

    position = receivables.position(receivables.invoice_from_rows(row, payments, notes), as_of)
    company, opportunity = context["company"], context["opportunity"]
    projects = context["projects"]
    project = projects[0] if len(projects) == 1 else None

    contacts = []
    invoice_contact = context["contacts"].get(row["contact_id"])
    billing_contact = context["contacts"].get(company and company["billing_contact_id"])
    if invoice_contact:
        contacts.append(_contact_out(invoice_contact, "invoice_contact"))
    if billing_contact and billing_contact is not invoice_contact:
        contacts.append(_contact_out(billing_contact, "billing_contact"))
    primary = invoice_contact or billing_contact

    context_issues = receivables.context_issues(
        project_count=len(projects),
        capacities={a["capacity"] for a in context["assignments"]},
        has_contact=primary is not None,
        contact_email=primary and primary["email"],
        contact_matches_company=primary is None or primary["company_id"] == row["company_id"],
    )
    counted = set(position.counted_payment_ids)

    return InvoiceDetail(
        as_of=as_of,
        ref=ref("ar_invoices", row["id"]),
        position=_position_out(row, position),
        invoice_date=row["invoice_date"],
        posting_date=row["posting_date"],
        approval_date=row["approval_date"],
        subtotal=row["subtotal"],
        tax_amount=row["tax_amount"],
        invoice_notes=row["notes"],
        latest_payment_date=position.latest_payment_date,
        customer=company and Customer(
            ref=ref("companies", company["id"]), name=company["name"], notes=company["notes"], contacts=contacts
        ),
        job=opportunity and Job(
            ref=ref("opportunities", opportunity["id"]),
            job_number=opportunity["job_number"],
            site_name=opportunity["site_name"],
            opportunity_status=opportunity["status"],
            reporting_branch=opportunity["reporting_branch"],
            operating_branch=opportunity["operating_branch"],
            project_ref=project and ref("projects", project["id"]),
            project_number=project and project["project_number"],
            project_status=project and project["status"],
            completed_on=project and project["completed_on"],
        ),
        assignments=[
            Assignment(ref=ref("engagement_assignments", a["id"]), capacity=a["capacity"],
                       employee_name=a["employee_name"], job_title=a["job_title"])
            for a in context["assignments"]
        ],
        payments=[
            PaymentRecord(ref=ref("ar_payments", p["id"]), payment_date=p["payment_date"], amount=p["amount"],
                          method=p["payment_method"], reference_number=p["reference_number"],
                          counted=p["id"] in counted)
            for p in payments
        ],
        notes=[_note_out("ar_invoice_notes", n) for n in notes],
        project_notes=[_note_out("project_notes", n) for n in context["project_notes"]],
        document=context["document"] and Document(
            ref=ref("documents", context["document"]["id"]), filename=context["document"]["original_filename"]
        ),
        calculation=Calculation(
            ref=f"calc:invoice_position:{row['id']}",
            formula=(f"Remaining balance is the invoice total minus payments recorded on or before "
                     f"{as_of:%B} {as_of.day}, {as_of.year}."),
            source_refs=[ref("ar_invoices", row["id"]), *(ref("ar_payments", p["id"]) for p in payments if p["id"] in counted)],
            excluded_refs=[ref("ar_payments", p["id"]) for p in payments if p["id"] not in counted],
        ),
        warnings=[Issue(**vars(i)) for i in (*position.issues, *context_issues)],
    )


async def _as_of(conn: AsyncConnection):
    as_of = await source_queries.fetch_dataset_as_of(conn)
    if as_of is None:
        raise SourceNotLoaded
    return as_of


def _group(rows: list[dict]) -> defaultdict[str, list[dict]]:
    grouped = defaultdict(list)
    for row in rows:
        grouped[row["invoice_id"]].append(row)
    return grouped


def _position_out(row: dict, p: receivables.Position) -> InvoicePosition:
    return InvoicePosition(
        id=row["id"],
        invoice_number=row["invoice_number"],
        status=row["status"],
        customer_name=row["customer_name"],
        job_number=row["job_number"],
        job_name=row["job_name"],
        total=row["total"],
        paid_to_date=p.paid_to_date,
        remaining_balance=p.remaining_balance,
        payment_position=p.payment_position,
        due_date=row["due_date"],
        sent_date=row["sent_date"],
        overdue_days=p.overdue_days,
        category=p.category,
        reason=p.reason,
        warnings=[Issue(**vars(i)) for i in p.issues],
    )


def _contact_out(row: dict, role: str) -> Contact:
    name = " ".join(part for part in (row["first_name"], row["last_name"]) if part)
    return Contact(ref=ref("contacts", row["id"]), role=role, name=name, first_name=row["first_name"],
                   title=row["title"], email=row["email"], phone=row["phone"])


def _note_out(table: str, row: dict) -> SourceNote:
    return SourceNote(ref=ref(table, row["id"]), note_date=row["note_date"],
                      author=row["created_by_email"], content=row["content"])
