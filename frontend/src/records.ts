import { day, money } from "./format";

type Saved = Record<string, unknown>;
type Field = [label: string, value: string];

export type DescribedRecord = { label: string; fields: Field[] };

// Investigation citations are described from the record saved with that investigation, not the current source,
// so the wording still matches what the assessment saw. The record type comes from its reference prefix.
export function describeRecord(ref: string, record: Saved | undefined): DescribedRecord | null {
  if (!record) return null;
  const text = (key: string) => (record[key] == null || record[key] === "" ? "Not recorded" : String(record[key]));
  const amount = (key: string) => (record[key] == null ? "Not recorded" : money(String(record[key])));
  const date = (key: string) => (record[key] == null ? "Not recorded" : day(String(record[key])));
  const table = ref.startsWith("calc:") ? "calc" : ref.slice("source_company.".length, ref.indexOf(":"));

  switch (table) {
    case "calc":
      return {
        label: "Balance calculation",
        fields: [
          ["Invoice total", amount("invoice_total")],
          ["Payments counted", amount("paid_to_date")],
          ["Remaining balance", amount("remaining_balance")],
          ["As of", date("as_of")],
          ["How it's calculated", text("formula")],
        ],
      };
    case "ar_payments":
      return {
        label: `${record.counted ? "Payment received" : "Payment not counted"} · ${date("payment_date")}`,
        fields: [
          ["Date", date("payment_date")],
          ["Amount", amount("amount")],
          ["Reference", text("reference_number")],
          ["Counted in balance", record.counted ? "Yes" : "No"],
        ],
      };
    case "ar_invoice_notes":
    case "project_notes":
      return {
        label: `${table === "project_notes" ? "Project note" : "Invoice note"} · ${date("note_date")}`,
        fields: [
          ["Date", date("note_date")],
          ["Written by", text("author")],
          ["Note", text("content")],
        ],
      };
    case "ar_invoices":
      return {
        label: `Invoice ${text("invoice_number")}`,
        fields: [
          ["Status", text("status")],
          ["Invoice total", amount("total")],
          ["Invoice date", date("invoice_date")],
          ["Sent", date("sent_date")],
          ["Due date", date("due_date")],
        ],
      };
    case "contacts":
      return {
        label: `Contact · ${text("name")}`,
        fields: [
          ["Name", text("name")],
          ["Title", text("title")],
          ["Email", text("email")],
          ["Phone", text("phone")],
        ],
      };
    case "companies":
      return { label: `Customer · ${text("name")}`, fields: [["Name", text("name")], ["Notes", text("notes")]] };
    case "opportunities":
      return {
        label: `Job · ${text("job_number")}`,
        fields: [
          ["Job", text("job_number")],
          ["Site", text("site_name")],
          ["Opportunity status", text("opportunity_status")],
          ["Branch", text("reporting_branch")],
        ],
      };
    case "projects":
      return {
        label: `Project · ${text("project_number")}`,
        fields: [
          ["Project", text("project_number")],
          ["Status", text("status")],
          ["Completed", date("completed_on")],
        ],
      };
    case "engagement_assignments":
      return {
        label: `${text("capacity")} · ${text("employee_name")}`,
        fields: [
          ["Role", text("capacity")],
          ["Person", text("employee_name")],
          ["Job title", text("job_title")],
        ],
      };
    default:
      return { label: "Source record", fields: [] };
  }
}
