// Keep in sync with backend/app/schemas.py. Money values are decimal strings.

export type Category = "verify" | "collect" | "billing" | "monitor" | "settled";
export type PaymentPosition = "no_receipts" | "partially_paid" | "paid" | "credit_or_inconsistent" | "unknown";

export type Issue = { code: string; message: string };

export type InvoicePosition = {
  id: string;
  invoice_number: string;
  status: string | null;
  customer_name: string | null;
  job_number: string | null;
  job_name: string | null;
  total: string | null;
  paid_to_date: string | null;
  remaining_balance: string | null;
  payment_position: PaymentPosition;
  due_date: string | null;
  sent_date: string | null;
  overdue_days: number | null;
  category: Category;
  reason: string;
  warnings: Issue[];
};

export type Bucket = { amount: string; count: number };

export type Receivables = {
  as_of: string;
  summary: {
    outstanding: Bucket;
    overdue: Bucket;
    not_yet_due: Bucket;
    unsent_billing: Bucket;
    sync_failed: Bucket;
    limitations: string[];
  };
  invoices: InvoicePosition[];
};

export type Contact = {
  ref: string;
  role: "invoice_contact" | "billing_contact";
  name: string;
  first_name: string | null;
  title: string | null;
  email: string | null;
  phone: string | null;
};

export type SourceNote = { ref: string; note_date: string | null; author: string | null; content: string | null };

export type InvoiceDetail = {
  as_of: string;
  ref: string;
  position: InvoicePosition;
  invoice_date: string | null;
  posting_date: string | null;
  approval_date: string | null;
  subtotal: string | null;
  tax_amount: string | null;
  invoice_notes: string | null;
  latest_payment_date: string | null;
  customer: { ref: string; name: string | null; notes: string | null; contacts: Contact[] } | null;
  job: {
    ref: string;
    job_number: string | null;
    site_name: string | null;
    opportunity_status: string | null;
    reporting_branch: string | null;
    operating_branch: string | null;
    project_ref: string | null;
    project_number: string | null;
    project_status: string | null;
    completed_on: string | null;
  } | null;
  assignments: { ref: string; capacity: string | null; employee_name: string | null; job_title: string | null }[];
  payments: {
    ref: string;
    payment_date: string | null;
    amount: string | null;
    method: string | null;
    reference_number: string | null;
    counted: boolean;
  }[];
  notes: SourceNote[];
  project_notes: SourceNote[];
  document: { ref: string; filename: string | null } | null;
  calculation: { ref: string; formula: string; source_refs: string[]; excluded_refs: string[] };
  warnings: Issue[];
  investigation: InvestigationState;
};

export type Action = "customer_followup" | "internal_billing_review" | "internal_verification" | "no_outreach";
export type Finding = { text: string; evidence_refs: string[] };

export type SuggestedEmail = {
  audience: "customer" | "internal";
  recipient: { name: string; email: string } | null;
  subject: string;
  body: string;
};

export type Investigation = {
  id: string;
  status: "running" | "completed" | "failed";
  started_at: string;
  finished_at: string | null;
  output: {
    action: Action;
    summary: string;
    findings: Finding[];
    warnings: Finding[];
    recommendation: Finding;
  } | null;
  email: SuggestedEmail | null;
  cited_records: Record<string, Record<string, unknown>>;
  error_code: string | null;
  error_message: string | null;
};

export type InvestigationState = {
  available: boolean;
  applicable: boolean;
  current: boolean;
  assessment: Investigation | null;
  latest_attempt: Investigation | null;
};

export type InvestigationResult = { investigation: Investigation; reused: boolean };

export type ARTrend = {
  as_of: string;
  invoice_count: number;
  points: { day: string; outstanding: string; overdue: string }[];
  movements: { start: string; end: string; opening: string; added: string; received: string; closing: string }[];
  limitations: string[];
};
