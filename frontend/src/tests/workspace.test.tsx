import { fireEvent, render, screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { expect, test, vi } from "vitest";

import App from "../App";
import type { InvestigationResult, InvoiceDetail, InvoicePosition, Receivables, SuggestedEmail } from "../types";

const position = (overrides: Partial<InvoicePosition>): InvoicePosition => ({
  id: "a",
  invoice_number: "INV-A",
  status: "SENT",
  customer_name: "Acme Corp",
  job_number: "JOB-1",
  job_name: "Acme Roof",
  total: "1000.00",
  paid_to_date: "400.00",
  remaining_balance: "600.00",
  payment_position: "partially_paid",
  due_date: "2026-07-18",
  sent_date: "2026-06-18",
  overdue_days: 10,
  category: "collect",
  reason: "10 days past due",
  warnings: [],
  ...overrides,
});

const invoiceA = position({});
const invoiceB = position({
  id: "b",
  invoice_number: "INV-B",
  customer_name: "Beta LLC",
  total: "500.00",
  overdue_days: 3,
  reason: "3 days past due",
});
const invoiceC = position({ id: "c", invoice_number: "INV-C", category: "billing", reason: "Draft, not yet sent" });

const receivables: Receivables = {
  as_of: "2026-07-28",
  summary: {
    outstanding: { amount: "1100.00", count: 2 },
    overdue: { amount: "600.00", count: 1 },
    not_yet_due: { amount: "0.00", count: 0 },
    unsent_billing: { amount: "1000.00", count: 1 },
    sync_failed: { amount: "0.00", count: 0 },
    limitations: [],
  },
  invoices: [invoiceA, invoiceB, invoiceC],
};

const detail = (p: InvoicePosition): InvoiceDetail => ({
  as_of: "2026-07-28",
  ref: `source_company.ar_invoices:${p.id}`,
  position: p,
  invoice_date: "2026-06-18",
  posting_date: null,
  approval_date: null,
  subtotal: p.total,
  tax_amount: "0.00",
  invoice_notes: null,
  latest_payment_date: null,
  customer: { ref: "source_company.companies:1", name: p.customer_name, notes: null, contacts: [] },
  job: null,
  assignments: [],
  payments: [],
  notes: [],
  project_notes: [],
  document: null,
  calculation: { ref: `calc:invoice_position:${p.id}`, formula: "remaining balance = total - payments", source_refs: [], excluded_refs: [] },
  warnings: [{ code: "missing_assignment", message: "No Primary Ops Manager assignment" }],
  investigation: {
    available: true,
    applicable: p.category !== "monitor" && p.category !== "settled",
    current: false,
    assessment: null,
    latest_attempt: null,
  },
});

const assessment = (p: InvoicePosition, email: SuggestedEmail | null = null): InvestigationResult => ({
  reused: false,
  investigation: {
    id: `i-${p.id}`,
    status: "completed",
    started_at: "2026-10-01T00:00:00Z",
    finished_at: "2026-10-01T00:00:05Z",
    output: {
      action: "internal_verification",
      summary: `Summary for ${p.invoice_number}`,
      findings: [{ text: "Finding.", evidence_refs: [`source_company.ar_invoices:${p.id}`] }],
      warnings: [],
      recommendation: { text: "Verify.", evidence_refs: [`calc:invoice_position:${p.id}`] },
    },
    cited_records: {
      [`source_company.ar_invoices:${p.id}`]: {
        ref: `source_company.ar_invoices:${p.id}`,
        invoice_number: p.invoice_number,
        status: "SENT",
        total: "1000.00",
        due_date: "2026-07-18",
      },
      [`calc:invoice_position:${p.id}`]: {
        ref: `calc:invoice_position:${p.id}`,
        invoice_total: "1000.00",
        paid_to_date: "400.00",
        remaining_balance: "600.00",
        as_of: "2026-07-28",
        formula: "Remaining balance is the invoice total minus payments recorded on or before July 28, 2026.",
        source_refs: [`source_company.ar_invoices:${p.id}`],
      },
    },
    email,
    error_code: null,
    error_message: null,
  },
});

const json = (body: unknown, status = 200) =>
  Promise.resolve(new Response(JSON.stringify(body), { status, headers: { "Content-Type": "application/json" } }));

function mockApi(handlers: Record<string, () => Promise<Response>>) {
  vi.stubGlobal(
    "fetch",
    vi.fn((url: string) => handlers[url]?.() ?? json({ detail: { message: "Not found" } }, 404)),
  );
}

test("shows the summary and opens the first collection item", async () => {
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(detail(invoiceA)),
  });
  render(<App />);

  const summary = await screen.findByRole("region", { name: "Summary" });
  expect(within(summary).getByText("$1,100.00")).toBeInTheDocument();
  const worklist = screen.getByRole("region", { name: "Worklist" });
  expect(within(worklist).queryByText("INV-C")).not.toBeInTheDocument();
  const panel = await screen.findByRole("region", { name: "Invoice INV-A" });
  expect(within(panel).getByText("No Primary Ops Manager assignment")).toBeInTheDocument();
});

test("search with no matches shows an empty state", async () => {
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(detail(invoiceA)),
  });
  render(<App />);

  await userEvent.type(await screen.findByLabelText("Search invoices"), "zzz");
  expect(screen.getByText("No invoices match.")).toBeInTheDocument();
});

test("a slow response for a previous selection does not replace the current one", async () => {
  let resolveA: (response: Response) => void = () => {};
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => new Promise((resolve) => (resolveA = resolve)),
    "/api/invoices/b": () => json(detail(invoiceB)),
  });
  render(<App />);

  await userEvent.click(await screen.findByRole("button", { name: /INV-B/ }));
  expect(await screen.findByRole("region", { name: "Invoice INV-B" })).toBeInTheDocument();

  resolveA(new Response(JSON.stringify(detail(invoiceA)), { status: 200 }));
  await new Promise((resolve) => setTimeout(resolve, 0));
  expect(screen.queryByRole("region", { name: "Invoice INV-A" })).not.toBeInTheDocument();
});

test("source errors show a message and can be retried", async () => {
  mockApi({ "/api/receivables": () => json({ detail: { message: "Source data is unavailable." } }, 503) });
  render(<App />);

  expect(await screen.findByText(/Source data is unavailable/)).toBeInTheDocument();
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(detail(invoiceA)),
  });
  await userEvent.click(screen.getByRole("button", { name: "Retry" }));
  expect(await screen.findByRole("region", { name: "Worklist" })).toBeInTheDocument();
});

test("an invoice that fails to load keeps the worklist usable", async () => {
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json({ detail: { message: "Source data is unavailable." } }, 503),
  });
  render(<App />);

  expect(await screen.findByText(/Couldn't load this invoice/)).toBeInTheDocument();
  expect(screen.getByRole("button", { name: /INV-B/ })).toBeEnabled();
});

test("assessing an invoice shows the result with readable citations", async () => {
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(detail(invoiceA)),
    "/api/invoices/a/investigations": () => json(assessment(invoiceA)),
  });
  render(<App />);

  await userEvent.click(await screen.findByRole("button", { name: "Assess invoice" }));
  const panel = screen.getByRole("region", { name: "Assessment" });
  expect(await within(panel).findByText("Summary for INV-A")).toBeInTheDocument();
  expect(within(panel).getByText("Suggests internal verification")).toBeInTheDocument();
  expect(within(panel).getByText("Balance calculation")).toBeInTheDocument();

  await userEvent.click(within(panel).getByRole("button", { name: "Invoice INV-A" }));
  expect(within(panel).getByText("Invoice INV-A, as saved with this assessment")).toBeInTheDocument();
  expect(within(panel).getByText("Invoice total").nextSibling).toHaveTextContent("$1,000.00");
  expect(within(panel).getByText("Due date").nextSibling).toHaveTextContent("Jul 18, 2026");

  await userEvent.click(within(panel).getByRole("button", { name: "Balance calculation" }));
  expect(within(panel).getByText("Payments counted").nextSibling).toHaveTextContent("$400.00");
  expect(within(panel).getByText("Remaining balance").nextSibling).toHaveTextContent("$600.00");
});

test("a failed assessment shows the error and keeps the invoice facts", async () => {
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(detail(invoiceA)),
    "/api/invoices/a/investigations": () =>
      json({ detail: { code: "provider_error", message: "The model provider request failed." } }, 502),
  });
  render(<App />);

  await userEvent.click(await screen.findByRole("button", { name: "Assess invoice" }));
  expect(await screen.findByText(/The model provider request failed/)).toBeInTheDocument();
  expect(screen.getByRole("region", { name: "Invoice INV-A" })).toHaveTextContent("Remaining balance$600.00");
});

test("an assessment that finishes after switching invoices is not shown on the new one", async () => {
  let finishA: (response: Response) => void = () => {};
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(detail(invoiceA)),
    "/api/invoices/b": () => json(detail(invoiceB)),
    "/api/invoices/a/investigations": () => new Promise((resolve) => (finishA = resolve)),
  });
  render(<App />);

  await userEvent.click(await screen.findByRole("button", { name: "Assess invoice" }));
  await userEvent.click(screen.getByRole("button", { name: /INV-B/ }));
  await screen.findByRole("region", { name: "Invoice INV-B" });

  finishA(new Response(JSON.stringify(assessment(invoiceA)), { status: 200 }));
  await new Promise((resolve) => setTimeout(resolve, 0));
  expect(screen.queryByText("Summary for INV-A")).not.toBeInTheDocument();
});

test("paid and not-yet-due invoices don't offer an assessment", async () => {
  const paid = position({ id: "p", invoice_number: "INV-P", category: "settled", reason: "Paid in export" });
  mockApi({
    "/api/receivables": () => json({ ...receivables, invoices: [invoiceA, paid] }),
    "/api/invoices/a": () => json(detail(invoiceA)),
    "/api/invoices/p": () => json(detail(paid)),
  });
  render(<App />);

  await userEvent.click(await screen.findByRole("tab", { name: /All/ }));
  await userEvent.click(screen.getByRole("button", { name: /INV-P/ }));
  const panel = await screen.findByRole("region", { name: "Assessment" });
  expect(within(panel).getByText(/No assessment needed/)).toBeInTheDocument();
  expect(within(panel).queryByRole("button", { name: "Assess invoice" })).not.toBeInTheDocument();
});

test("the summary shows the cards and any data limitations, without explanatory notes", async () => {
  const limitation = "1 invoice(s) with incomplete amounts are excluded.";
  mockApi({
    "/api/receivables": () =>
      json({
        ...receivables,
        summary: { ...receivables.summary, sync_failed: { amount: "57300.00", count: 1 }, limitations: [limitation] },
      }),
    "/api/invoices/a": () => json(detail(invoiceA)),
  });
  render(<App />);

  const summary = await screen.findByRole("region", { name: "Summary" });
  expect(within(summary).getByText(limitation)).toBeVisible();
  expect(summary.textContent).not.toMatch(/failed accounting sync|How these totals|USD assumed/);
  expect(summary.querySelector("details")).toBeNull();
});

const EMAIL: SuggestedEmail = {
  audience: "customer",
  recipient: { name: "Dana Lee", email: "dana@acme.test" },
  subject: "Invoice INV-A",
  body: "Hi Dana,\n\nAs of July 28, 2026, our records show $600.00 open on invoice INV-A.",
};

const withAssessment = (p: InvoicePosition, email: SuggestedEmail | null, current = true): InvoiceDetail => ({
  ...detail(p),
  investigation: { ...detail(p).investigation, current, assessment: assessment(p, email).investigation },
});

function mockClipboard(writeText: () => Promise<void>) {
  const spy = vi.fn(writeText);
  Object.defineProperty(navigator, "clipboard", { value: { writeText: spy }, configurable: true });
  return spy;
}

test("a suggested email shows its recipient and copies to the clipboard only", async () => {
  const writes = mockClipboard(() => Promise.resolve());
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(withAssessment(invoiceA, EMAIL)),
  });
  render(<App />);

  const email = await screen.findByRole("region", { name: "Suggested email" });
  expect(within(email).getByText("Dana Lee <dana@acme.test>")).toBeInTheDocument();
  expect(within(email).getByText(/our records show \$600\.00 open/)).toBeInTheDocument();
  expect(within(email).getByText(/check recent outreach in your CRM or email and confirm the contact/)).toBeInTheDocument();

  fireEvent.click(within(email).getByRole("button", { name: "Copy email" }));
  expect(await within(email).findByText("Copied. Review and send it from your email.")).toBeInTheDocument();
  expect(writes).toHaveBeenCalledWith(`Subject: Invoice INV-A\n\n${EMAIL.body}`);
  const posted = (fetch as ReturnType<typeof vi.fn>).mock.calls.some(([, init]) => init?.method === "POST");
  expect(posted).toBe(false);
});

test("a clipboard failure is reported", async () => {
  mockClipboard(() => Promise.reject(new Error("denied")));
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(withAssessment(invoiceA, EMAIL)),
  });
  render(<App />);

  fireEvent.click(await screen.findByRole("button", { name: "Copy email" }));
  expect(await screen.findByText(/Couldn't copy to the clipboard/)).toBeInTheDocument();
});

test("an outdated assessment's email can't be copied until it is refreshed", async () => {
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(withAssessment(invoiceA, EMAIL, false)),
  });
  render(<App />);

  expect(await screen.findByRole("button", { name: "Copy email" })).toBeDisabled();
  expect(screen.getByText("Re-assess to update this email before copying it.")).toBeInTheDocument();
});

test("no suggested email section when the assessment has none", async () => {
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(withAssessment(invoiceA, null)),
  });
  render(<App />);

  expect(await screen.findByText("Summary for INV-A")).toBeInTheDocument();
  expect(screen.queryByRole("region", { name: "Suggested email" })).not.toBeInTheDocument();
});

test("developer diagnostics and raw source references are not shown", async () => {
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(withAssessment(invoiceA, EMAIL)),
  });
  render(<App />);

  const panel = await screen.findByRole("region", { name: "Assessment" });
  await userEvent.click(within(panel).getByRole("button", { name: "Balance calculation" }));
  await userEvent.click(screen.getByText("Balance details"));

  const text = document.body.textContent ?? "";
  for (const hidden of ["test-model", "tokens", "requests", "source_company", "calc:", "_refs", "remaining_balance"]) {
    expect(text).not.toContain(hidden);
  }
});

type Payment = InvoiceDetail["payments"][number];
const payment = (overrides: Partial<Payment>): Payment => ({
  ref: "source_company.ar_payments:p1",
  payment_date: "2026-06-29",
  amount: "400.00",
  method: "ACH",
  reference_number: "ACH-77",
  counted: true,
  ...overrides,
});

async function openBalanceDetails(invoice: InvoicePosition, payments: Payment[]) {
  mockApi({
    "/api/receivables": () => json({ ...receivables, invoices: [invoice] }),
    [`/api/invoices/${invoice.id}`]: () => json({ ...detail(invoice), payments }),
  });
  render(<App />);
  if (invoice.category !== "collect") await userEvent.click(await screen.findByRole("tab", { name: /All/ }));
  await userEvent.click(await screen.findByRole("button", { name: new RegExp(invoice.invoice_number) }));
  const summary = await screen.findByText("Balance details");
  const section = summary.closest("details")!;
  expect(section).not.toHaveAttribute("open");
  await userEvent.click(summary);
  return section;
}

test("balance details show the total, counted payments, and remaining balance", async () => {
  const section = await openBalanceDetails(invoiceA, [payment({})]);

  expect(within(section).getByText("Invoice total").nextSibling).toHaveTextContent("$1,000.00");
  expect(within(section).getByText("Payments counted through July 28, 2026").nextSibling).toHaveTextContent("$400.00");
  expect(within(section).getByText("Remaining balance").nextSibling).toHaveTextContent("$600.00");
  expect(within(section).getByRole("row", { name: /Jun 29, 2026 \$400\.00 ACH-77/ })).toBeInTheDocument();
  expect(section.textContent).not.toMatch(/source_company|Records used/);
});

test("excluded payments and uncertain balances are explained", async () => {
  const later = payment({ ref: "source_company.ar_payments:p2", payment_date: "2026-08-01", amount: "250.00", counted: false });
  const undated = payment({ ref: "source_company.ar_payments:p3", payment_date: null, counted: false });
  const unknown = position({ paid_to_date: null, remaining_balance: null, payment_position: "unknown" });
  const section = await openBalanceDetails(unknown, [later, undated]);

  expect(within(section).getByText("Not counted: $250.00 dated Aug 1, 2026, after the July 28, 2026 snapshot."))
    .toBeInTheDocument();
  expect(within(section).getByText("Not counted: $400.00 has no payment date.")).toBeInTheDocument();
  expect(within(section).getByText(/balance can't be calculated/)).toBeInTheDocument();
  expect(within(section).getByText("Remaining balance").nextSibling).toHaveTextContent("Unknown");
});

test("unsent invoices show face value and billing status, not a collectible balance", async () => {
  const section = await openBalanceDetails(invoiceC, []);

  expect(within(section).getByText("Face value").nextSibling).toHaveTextContent("$1,000.00");
  expect(within(section).getByText("Billing status").nextSibling).toHaveTextContent("Draft, not yet sent");
  expect(within(section).queryByText("Remaining balance")).not.toBeInTheDocument();
  expect(within(section).getByText(/isn't counted in outstanding AR/)).toBeInTheDocument();
});

test("citations are labeled and described from the saved evidence, not the current source", async () => {
  const saved = assessment(invoiceA);
  const paymentRef = "source_company.ar_payments:p1";
  const noteRef = "source_company.project_notes:n1";
  saved.investigation.output!.findings = [{ text: "Customer paid part of it.", evidence_refs: [paymentRef, noteRef] }];
  saved.investigation.cited_records = {
    [paymentRef]: { ref: paymentRef, payment_date: "2026-06-29", amount: "129900.00", reference_number: "CHK-1",
                    counted: true },
    [noteRef]: { ref: noteRef, note_date: "2026-07-12", author: "tasha@example.com", content: "Crane booked." },
  };
  mockApi({
    "/api/receivables": () => json(receivables),
    // The current invoice no longer shows the payment; the citation still uses what was saved.
    "/api/invoices/a": () =>
      json({ ...detail(invoiceA), payments: [], investigation: { ...detail(invoiceA).investigation, current: false,
                                                                  assessment: saved.investigation } }),
  });
  render(<App />);

  const panel = await screen.findByRole("region", { name: "Assessment" });
  await userEvent.click(within(panel).getByRole("button", { name: "Payment received · Jun 29, 2026" }));
  expect(within(panel).getByText("Amount").nextSibling).toHaveTextContent("$129,900.00");
  expect(within(panel).getByText("Reference").nextSibling).toHaveTextContent("CHK-1");

  await userEvent.click(within(panel).getByRole("button", { name: "Project note · Jul 12, 2026" }));
  expect(within(panel).getByText("Note").nextSibling).toHaveTextContent("Crane booked.");
  expect(within(panel).getByText("Written by").nextSibling).toHaveTextContent("tasha@example.com");
});

const trend = {
  as_of: "2026-07-28",
  invoice_count: 2,
  points: [
    { day: "2026-06-30", outstanding: "1000.00", overdue: "0.00" },
    { day: "2026-07-28", outstanding: "600.00", overdue: "600.00" },
  ],
  movements: [
    { start: "2026-06-01", end: "2026-06-30", opening: "0.00", added: "1000.00", received: "0.00", closing: "1000.00" },
    { start: "2026-07-01", end: "2026-07-28", opening: "1000.00", added: "0.00", received: "400.00", closing: "600.00" },
  ],
  limitations: [],
};

const trendCalls = () => (fetch as ReturnType<typeof vi.fn>).mock.calls.filter(([url]) => url === "/api/receivables/trend");

test("AR over time loads once when first opened and stays independent of worklist filters", async () => {
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(detail(invoiceA)),
    "/api/receivables/trend": () => json(trend),
  });
  render(<App />);

  const summary = await screen.findByText("AR over time");
  const section = summary.closest("details")!;
  expect(section).not.toHaveAttribute("open");
  expect(trendCalls()).toHaveLength(0);

  await userEvent.click(summary);
  expect(await within(section).findByRole("row", { name: /June 2026 \$0\.00 \$1,000\.00 \$0\.00 \$1,000\.00/ }))
    .toBeInTheDocument();
  expect(within(section).getByRole("row", { name: /Jul 1 – Jul 28, 2026 \$1,000\.00 \$0\.00 \$400\.00 \$600\.00/ }))
    .toBeInTheDocument();

  await userEvent.click(screen.getByRole("tab", { name: /Billing review/ }));
  await userEvent.click(summary);
  await userEvent.click(summary);
  expect(within(section).getByText(/June 2026/)).toBeInTheDocument();
  expect(trendCalls()).toHaveLength(1);
});

test("AR over time shows loading, then an error with a working retry", async () => {
  let fail = true;
  let finish: (response: Response) => void = () => {};
  mockApi({
    "/api/receivables": () => json(receivables),
    "/api/invoices/a": () => json(detail(invoiceA)),
    "/api/receivables/trend": () =>
      fail ? new Promise((resolve) => (finish = resolve)) : json(trend),
  });
  render(<App />);

  const summary = await screen.findByText("AR over time");
  await userEvent.click(summary);
  expect(screen.getByText("Loading the trend…")).toBeInTheDocument();

  finish(new Response(JSON.stringify({ detail: { message: "Source data is unavailable." } }), { status: 503 }));
  expect(await screen.findByText("Couldn't load the trend. Source data is unavailable.")).toBeInTheDocument();

  fail = false;
  await userEvent.click(screen.getByRole("button", { name: "Retry" }));
  expect(await screen.findByText(/June 2026/)).toBeInTheDocument();
});
