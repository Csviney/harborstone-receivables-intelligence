from collections.abc import Iterable, Mapping
from dataclasses import dataclass
from datetime import date, timedelta
from decimal import Decimal

SENT, DRAFT, APPROVED, SYNC_FAILED = "SENT", "DRAFT", "APPROVED", "SYNC_FAILED"
UNSENT = (DRAFT, APPROVED)
CATEGORIES = ("verify", "collect", "billing", "monitor", "settled")
REQUIRED_CAPACITIES = ("Primary AE", "Primary Ops Manager")
ZERO = Decimal("0.00")

# Actions an assessment may suggest. Not-yet-due and paid invoices have nothing to interpret, so they aren't assessed.
ALLOWED_ACTIONS = {
    "verify": ("internal_verification", "no_outreach"),
    "billing": ("internal_billing_review", "internal_verification", "no_outreach"),
    "collect": ("customer_followup", "internal_verification", "no_outreach"),
}

# Verify-first ordering: data integrity problems, then note conflicts, then sync failures.
ISSUE_RANK = {"later_note": 1, "sync_failed": 2}


@dataclass(frozen=True)
class Payment:
    id: str
    payment_date: date | None
    amount: Decimal | None


@dataclass(frozen=True)
class Note:
    id: str
    note_date: date | None


@dataclass(frozen=True)
class Invoice:
    id: str
    invoice_number: str
    status: str | None
    total: Decimal | None
    due_date: date | None
    sent_date: date | None
    project_status: str | None
    payments: tuple[Payment, ...] = ()
    notes: tuple[Note, ...] = ()


@dataclass(frozen=True)
class Issue:
    code: str
    message: str


@dataclass(frozen=True)
class Position:
    invoice: Invoice
    paid_to_date: Decimal | None
    remaining_balance: Decimal | None
    latest_payment_date: date | None
    counted_payment_ids: tuple[str, ...]
    payment_position: str
    overdue_days: int | None
    category: str
    reason: str
    issues: tuple[Issue, ...]


@dataclass(frozen=True)
class Bucket:
    amount: Decimal
    count: int


@dataclass(frozen=True)
class Summary:
    outstanding: Bucket
    overdue: Bucket
    not_yet_due: Bucket
    unsent_billing: Bucket
    sync_failed: Bucket
    limitations: tuple[str, ...]


def invoice_from_rows(row: Mapping, payments: Iterable[Mapping], notes: Iterable[Mapping]) -> Invoice:
    return Invoice(
        id=row["id"],
        invoice_number=row["invoice_number"],
        status=row["status"],
        total=row["total"],
        due_date=row["due_date"],
        sent_date=row["sent_date"],
        project_status=row["project_status"],
        payments=tuple(Payment(p["id"], p["payment_date"], p["amount"]) for p in payments),
        notes=tuple(Note(n["id"], n["note_date"]) for n in notes),
    )


def position(invoice: Invoice, as_of: date) -> Position:
    received = [p for p in invoice.payments if p.payment_date is not None and p.payment_date <= as_of]
    # An undated payment might fall before the cutoff, so it makes the balance uncertain too.
    incomplete = any(p.payment_date is None for p in invoice.payments) or any(p.amount is None for p in received)
    if invoice.total is None or incomplete:
        paid = remaining = None
    else:
        paid = sum((p.amount for p in received), ZERO)
        remaining = invoice.total - paid
    latest_payment = max((p.payment_date for p in received), default=None)

    issues = _verify_issues(invoice, remaining, latest_payment, as_of)
    overdue_days = _overdue_days(invoice, remaining, as_of)
    category, reason = _triage(invoice, remaining, issues, as_of)
    return Position(
        invoice=invoice,
        paid_to_date=paid,
        remaining_balance=remaining,
        latest_payment_date=latest_payment,
        counted_payment_ids=tuple(p.id for p in received),
        payment_position=_payment_position(paid, remaining),
        overdue_days=overdue_days,
        category=category,
        reason=reason,
        issues=tuple(issues),
    )


def _payment_position(paid: Decimal | None, remaining: Decimal | None) -> str:
    if remaining is None:
        return "unknown"
    if remaining < 0:
        return "credit_or_inconsistent"
    if paid == 0:
        return "no_receipts"
    if remaining == 0:
        return "paid"
    return "partially_paid"


def _verify_issues(invoice: Invoice, remaining: Decimal | None, latest_payment: date | None, as_of: date) -> list[Issue]:
    issues = []
    if invoice.status not in (SENT, *UNSENT, SYNC_FAILED):
        issues.append(Issue("unsupported_status", f"Unsupported status {invoice.status}"))
    if remaining is None:
        issues.append(Issue("incomplete_amounts", "Invoice total or payment details are missing"))
    elif remaining < 0:
        issues.append(Issue("negative_balance", "Recorded payments exceed the invoice total"))
    if invoice.due_date is None:
        issues.append(Issue("missing_due_date", "Missing due date"))
    if invoice.status == SENT and (invoice.sent_date is None or invoice.sent_date > as_of):
        issues.append(Issue("invalid_send_date", "Sent invoice has no valid send date"))
    if invoice.status in UNSENT and invoice.sent_date is not None:
        issues.append(Issue("unexpected_send_date", "Unsent invoice has a send date"))
    if remaining == 0 and latest_payment is not None and any(
        n.note_date is not None and latest_payment < n.note_date <= as_of for n in invoice.notes
    ):
        issues.append(Issue("later_note", "Later note needs review"))
    if invoice.status == SYNC_FAILED:
        issues.append(Issue("sync_failed", "Accounting sync failed"))
    return sorted(issues, key=lambda issue: ISSUE_RANK.get(issue.code, 0))


def _overdue_days(invoice: Invoice, remaining: Decimal | None, as_of: date) -> int | None:
    if invoice.status != SENT or invoice.due_date is None or remaining is None:
        return None
    if remaining <= 0:
        return 0
    return max(0, (as_of - invoice.due_date).days)


def _triage(invoice: Invoice, remaining: Decimal | None, issues: list[Issue], as_of: date) -> tuple[str, str]:
    if issues:
        return "verify", issues[0].message
    if invoice.status in UNSENT:
        return "billing", f"{invoice.status.capitalize()}, not yet sent"
    if remaining > 0 and invoice.due_date < as_of:
        days = (as_of - invoice.due_date).days
        return "collect", f"{days} day{'s' if days != 1 else ''} past due"
    if remaining > 0:
        days = (invoice.due_date - as_of).days
        return "monitor", "Due today" if days == 0 else f"Due in {days} day{'s' if days != 1 else ''}"
    return "settled", "Paid in export"


def sort_key(p: Position) -> tuple:
    inv = p.invoice
    if p.category == "verify":
        within = (min(ISSUE_RANK.get(i.code, 0) for i in p.issues),)
    elif p.category == "collect":
        within = (-p.overdue_days, -p.remaining_balance)
    elif p.category == "billing":
        within = (inv.project_status not in ("COMPLETED", "CLOSED"), -inv.total)
    elif p.category == "monitor":
        within = (inv.due_date,)
    else:
        within = ()
    return (CATEGORIES.index(p.category), *within, inv.invoice_number)


def summarize(positions: Iterable[Position], as_of: date) -> Summary:
    positions = list(positions)
    # Headline AR: currently SENT invoices sent by the cutoff, less recorded receipts.
    ar = [p for p in positions if p.invoice.status == SENT and p.invoice.sent_date and p.invoice.sent_date <= as_of]
    known = [p for p in ar if p.remaining_balance is not None]
    open_ = [p for p in known if p.remaining_balance > 0]
    overdue = [p for p in open_ if p.invoice.due_date and p.invoice.due_date < as_of]
    not_yet_due = [p for p in open_ if p.invoice.due_date and p.invoice.due_date >= as_of]

    limitations = []
    if len(known) < len(ar):
        limitations.append(f"{len(ar) - len(known)} invoice(s) with incomplete amounts are excluded.")
    if any(p.remaining_balance < 0 for p in known):
        limitations.append("Includes invoices where recorded payments exceed the invoice total.")
    if len(overdue) + len(not_yet_due) < len(open_):
        limitations.append("Open invoices without a due date are not split into overdue or not yet due.")

    unsent = [p for p in positions if p.invoice.status in UNSENT]
    sync_failed = [p for p in positions if p.invoice.status == SYNC_FAILED]
    for label, group in (("Unsent billing", unsent), ("Failed-sync", sync_failed)):
        missing = sum(p.invoice.total is None for p in group)
        if missing:
            limitations.append(f"{label} total excludes {missing} invoice(s) with no recorded total.")

    return Summary(
        outstanding=Bucket(sum((p.remaining_balance for p in known), ZERO), len(open_)),
        overdue=_balance_bucket(overdue),
        not_yet_due=_balance_bucket(not_yet_due),
        unsent_billing=_total_bucket(unsent),
        sync_failed=_total_bucket(sync_failed),
        limitations=tuple(limitations),
    )


def _balance_bucket(positions: list[Position]) -> Bucket:
    return Bucket(sum((p.remaining_balance for p in positions), ZERO), len(positions))


def _total_bucket(positions: list[Position]) -> Bucket:
    return Bucket(sum((p.invoice.total for p in positions if p.invoice.total is not None), ZERO), len(positions))


@dataclass(frozen=True)
class TrendPoint:
    day: date
    outstanding: Decimal
    overdue: Decimal


@dataclass(frozen=True)
class Movement:
    start: date
    end: date
    opening: Decimal
    added: Decimal
    received: Decimal
    closing: Decimal


@dataclass(frozen=True)
class Trend:
    invoice_count: int
    points: tuple[TrendPoint, ...]
    movements: tuple[Movement, ...]
    limitations: tuple[str, ...]


def trend(invoices: Iterable[Invoice], as_of: date) -> Trend:
    """Daily outstanding and overdue AR rebuilt from send and payment dates.

    Covers the invoices currently marked SENT, including ones now paid. Status is only known at the snapshot, so
    this reconstructs that population's history; it is not a historical accounting ledger.
    """
    sent = [i for i in invoices if i.status == SENT]
    population = [i for i in sent if i.sent_date and i.sent_date <= as_of]
    # Without trustworthy amounts and dates there is no way to place an invoice on a given day.
    usable = [i for i in population if _has_history(i, as_of)]
    limitations = []
    if undated := sum(1 for i in sent if i.sent_date is None):
        limitations.append(f"{undated} SENT invoice(s) left out: no send date.")
    if len(usable) < len(population):
        limitations.append(f"{len(population) - len(usable)} invoice(s) left out: a missing amount or date, "
                           "or a payment recorded before the invoice was sent.")
    # Balances only change on payment days, so checking those days covers the whole period.
    if any(_balance_on(i, p.payment_date) < 0 for i in usable for p in i.payments if p.payment_date <= as_of):
        limitations.append("Includes invoices whose recorded payments exceeded the invoice total on some days, "
                           "such as an overpayment later reversed.")
    if not usable:
        return Trend(0, (), (), tuple(limitations))

    start = min(i.sent_date for i in usable).replace(day=1)
    points = tuple(_trend_point(usable, start + timedelta(days=n)) for n in range((as_of - start).days + 1))

    movements = []
    month_start = start
    while month_start <= as_of:
        next_month = (month_start.replace(day=28) + timedelta(days=4)).replace(day=1)
        month_end = min(next_month - timedelta(days=1), as_of)
        movements.append(Movement(
            start=month_start,
            end=month_end,
            opening=_outstanding(usable, month_start - timedelta(days=1)),
            added=sum((i.total for i in usable if month_start <= i.sent_date <= month_end), ZERO),
            received=sum((p.amount for i in usable for p in i.payments if month_start <= p.payment_date <= month_end),
                         ZERO),
            closing=_outstanding(usable, month_end),
        ))
        month_start = next_month
    return Trend(len(usable), points, tuple(movements), tuple(limitations))


def _has_history(invoice: Invoice, as_of: date) -> bool:
    # Payments after the snapshot never enter the trend; an undated one might fall inside it.
    in_period = [p for p in invoice.payments if p.payment_date is None or p.payment_date <= as_of]
    return invoice.total is not None and invoice.due_date is not None and all(
        p.amount is not None and p.payment_date is not None and p.payment_date >= invoice.sent_date
        for p in in_period
    )


def _balance_on(invoice: Invoice, day: date) -> Decimal:
    return invoice.total - sum((p.amount for p in invoice.payments if p.payment_date <= day), ZERO)


def _outstanding(invoices: list[Invoice], day: date) -> Decimal:
    return sum((_balance_on(i, day) for i in invoices if i.sent_date <= day), ZERO)


def _trend_point(invoices: list[Invoice], day: date) -> TrendPoint:
    balances = [(i, _balance_on(i, day)) for i in invoices if i.sent_date <= day]
    overdue = sum((b for i, b in balances if b > 0 and i.due_date < day), ZERO)
    return TrendPoint(day, sum((b for _, b in balances), ZERO), overdue)


def context_issues(
    *,
    project_count: int,
    capacities: set[str],
    has_contact: bool,
    contact_email: str | None,
    contact_matches_company: bool,
) -> list[Issue]:
    issues = []
    if project_count == 0:
        issues.append(Issue("no_project", "No linked project"))
    elif project_count > 1:
        issues.append(Issue("multiple_projects", "Multiple linked projects"))
    for capacity in REQUIRED_CAPACITIES:
        if capacity not in capacities:
            issues.append(Issue("missing_assignment", f"No {capacity} assignment"))
    if not has_contact:
        issues.append(Issue("no_contact", "No customer contact on record"))
    else:
        if not contact_email:
            issues.append(Issue("no_contact_email", "No email for customer contact"))
        if not contact_matches_company:
            issues.append(Issue("contact_company_mismatch", "Contact is recorded under a different company"))
    return issues
