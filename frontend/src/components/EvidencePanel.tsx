import { day, money } from "../format";
import type { InvoiceDetail } from "../types";
import { Badge } from "./ui/badge";

export default function EvidencePanel({ detail }: { detail: InvoiceDetail }) {
  const records = [
    { label: "Invoice", ref: detail.ref },
    ...(detail.customer ? [{ label: "Customer", ref: detail.customer.ref }] : []),
    ...(detail.customer?.contacts.map((c) => ({ label: `Contact: ${c.name}`, ref: c.ref })) ?? []),
    ...detail.payments.map((p) => ({
      label: `Payment ${day(p.payment_date)}${p.counted ? "" : " (excluded)"}`,
      ref: p.ref,
    })),
    ...(detail.job ? [{ label: "Opportunity", ref: detail.job.ref }] : []),
    ...(detail.job?.project_ref ? [{ label: "Project", ref: detail.job.project_ref }] : []),
    ...detail.assignments.map((a) => ({ label: `Assignment: ${a.capacity}`, ref: a.ref })),
    ...detail.notes.map((n) => ({ label: `Invoice note ${day(n.note_date)}`, ref: n.ref })),
    ...detail.project_notes.map((n) => ({ label: `Project note ${day(n.note_date)}`, ref: n.ref })),
    ...(detail.document ? [{ label: `Document: ${detail.document.filename}`, ref: detail.document.ref }] : []),
  ];

  return (
    <details className="mt-6 border-t pt-4">
      <summary className="cursor-pointer font-medium text-primary">Source evidence</summary>
      <h4 className="mt-3 mb-1 font-medium">Calculation</h4>
      <p className="text-muted-foreground">{detail.calculation.formula}</p>
      <table className="mt-3 w-full text-left text-sm tabular-nums">
        <thead className="text-xs text-muted-foreground">
          <tr className="border-b">
            <th className="py-1.5 font-medium">Payment date</th>
            <th className="py-1.5 font-medium">Amount</th>
            <th className="py-1.5 font-medium">Method</th>
            <th className="py-1.5 font-medium">Reference</th>
            <th className="py-1.5 font-medium">In balance</th>
          </tr>
        </thead>
        <tbody>
          {detail.payments.length === 0 ? (
            <tr>
              <td colSpan={5} className="py-2 text-muted-foreground">
                No payment records
              </td>
            </tr>
          ) : (
            detail.payments.map((payment) => (
              <tr key={payment.ref} className="border-b">
                <td className="py-1.5">{day(payment.payment_date)}</td>
                <td className="py-1.5">{money(payment.amount)}</td>
                <td className="py-1.5">{payment.method ?? "—"}</td>
                <td className="py-1.5">{payment.reference_number ?? "—"}</td>
                <td className="py-1.5">
                  <Badge variant={payment.counted ? "secondary" : "outline"}>
                    {payment.counted ? "Counted" : "Excluded"}
                  </Badge>
                </td>
              </tr>
            ))
          )}
        </tbody>
      </table>
      <h4 className="mt-4 mb-1 font-medium">Records</h4>
      <ul className="space-y-1">
        {records.map((record) => (
          <li key={record.ref} className="flex flex-wrap gap-x-2">
            {record.label}
            <code className="text-xs break-all text-muted-foreground">{record.ref}</code>
          </li>
        ))}
      </ul>
    </details>
  );
}
