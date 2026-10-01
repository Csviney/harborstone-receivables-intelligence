import { render, screen, within } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { expect, test, vi } from "vitest";

import App from "../App";
import type { InvoiceDetail, InvoicePosition, Receivables } from "../types";

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
    scope: "Scope text.",
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
