from datetime import date, datetime
from decimal import Decimal
from typing import Annotated, Literal

from pydantic import BaseModel, PlainSerializer

Money = Annotated[Decimal, PlainSerializer(lambda value: f"{value:.2f}", return_type=str)]

Category = Literal["verify", "collect", "billing", "monitor", "settled"]
PaymentPosition = Literal["no_receipts", "partially_paid", "paid", "credit_or_inconsistent", "unknown"]


class DatabaseStatus(BaseModel):
    ready: bool
    dataset_as_of: date | None = None
    error: Literal["database_unavailable", "source_not_restored", "app_schema_missing", "permission_denied"] | None = None


class ModelStatus(BaseModel):
    # Key and model are set. Doesn't check the provider.
    assessment_available: bool
    model: str | None = None


class Health(BaseModel):
    status: Literal["ok", "unavailable"]
    database: DatabaseStatus
    model: ModelStatus


class Issue(BaseModel):
    code: str
    message: str


class InvoicePosition(BaseModel):
    id: str
    invoice_number: str
    status: str | None
    customer_name: str | None
    job_number: str | None
    job_name: str | None
    total: Money | None
    paid_to_date: Money | None
    remaining_balance: Money | None
    payment_position: PaymentPosition
    due_date: date | None
    sent_date: date | None
    overdue_days: int | None
    category: Category
    reason: str
    warnings: list[Issue]


class Bucket(BaseModel):
    amount: Money
    count: int


class Summary(BaseModel):
    outstanding: Bucket
    overdue: Bucket
    not_yet_due: Bucket
    unsent_billing: Bucket
    sync_failed: Bucket
    limitations: list[str]


class Receivables(BaseModel):
    as_of: date
    summary: Summary
    invoices: list[InvoicePosition]


class TrendPoint(BaseModel):
    day: date
    outstanding: Money
    overdue: Money


class TrendMovement(BaseModel):
    start: date
    end: date
    opening: Money
    added: Money
    received: Money
    closing: Money


class ARTrend(BaseModel):
    as_of: date
    invoice_count: int
    points: list[TrendPoint]
    movements: list[TrendMovement]
    limitations: list[str]


class Contact(BaseModel):
    ref: str
    role: Literal["invoice_contact", "billing_contact"]
    name: str
    first_name: str | None
    title: str | None
    email: str | None
    phone: str | None


class Customer(BaseModel):
    ref: str
    name: str | None
    notes: str | None
    contacts: list[Contact]


class Job(BaseModel):
    ref: str
    job_number: str | None
    site_name: str | None
    opportunity_status: str | None
    reporting_branch: str | None
    operating_branch: str | None
    project_ref: str | None
    project_number: str | None
    project_status: str | None
    completed_on: date | None


class Assignment(BaseModel):
    ref: str
    capacity: str | None
    employee_name: str | None
    job_title: str | None


class PaymentRecord(BaseModel):
    ref: str
    payment_date: date | None
    amount: Money | None
    method: str | None
    reference_number: str | None
    counted: bool


class SourceNote(BaseModel):
    ref: str
    note_date: date | None
    author: str | None
    content: str | None


class Document(BaseModel):
    ref: str
    filename: str | None


class Calculation(BaseModel):
    ref: str
    formula: str
    source_refs: list[str]
    excluded_refs: list[str]


class InvoiceDetail(BaseModel):
    as_of: date
    ref: str
    position: InvoicePosition
    invoice_date: date | None
    posting_date: date | None
    approval_date: date | None
    subtotal: Money | None
    tax_amount: Money | None
    invoice_notes: str | None
    latest_payment_date: date | None
    customer: Customer | None
    job: Job | None
    assignments: list[Assignment]
    payments: list[PaymentRecord]
    notes: list[SourceNote]
    project_notes: list[SourceNote]
    document: Document | None
    calculation: Calculation
    warnings: list[Issue]
    investigation: "InvestigationState | None" = None


Action = Literal["customer_followup", "internal_billing_review", "internal_verification", "no_outreach"]


class Finding(BaseModel):
    text: str
    evidence_refs: list[str]


class Assessment(BaseModel):
    action: Action
    summary: str
    findings: list[Finding]
    warnings: list[Finding]
    recommendation: Finding


class EmailTemplate(BaseModel):
    audience: Literal["customer", "internal"]
    recipient_ref: str | None
    subject_template: str
    body_template: str


class AssessmentOutput(Assessment):
    """What the model returns. The email is a template; the server fills in names, amounts, and dates."""

    email: EmailTemplate | None


class Recipient(BaseModel):
    name: str
    email: str


class SuggestedEmail(BaseModel):
    audience: Literal["customer", "internal"]
    recipient: Recipient | None
    subject: str
    body: str


class Investigation(BaseModel):
    id: str
    status: Literal["running", "completed", "failed"]
    started_at: datetime
    finished_at: datetime | None
    output: Assessment | None
    email: SuggestedEmail | None
    # The cited records as they were when this assessment ran.
    cited_records: dict[str, dict]
    error_code: str | None
    error_message: str | None


class InvestigationState(BaseModel):
    available: bool
    # Only invoices with something to interpret (collect, billing, verify) are assessed.
    applicable: bool
    current: bool
    assessment: Investigation | None
    latest_attempt: Investigation | None


class InvestigationRequest(BaseModel):
    refresh: bool = False


class InvestigationResult(BaseModel):
    investigation: Investigation
    reused: bool


InvoiceDetail.model_rebuild()
