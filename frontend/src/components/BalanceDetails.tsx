import { day, money } from "../format";
import type { InvoiceDetail } from "../types";

type Payment = InvoiceDetail["payments"][number];

export default function BalanceDetails({ detail }: { detail: InvoiceDetail }) {
  const { position, payments, as_of } = detail;
  const snapshot = day(as_of, "long");
  const counted = payments.filter((p) => p.counted);
  const excluded = payments.filter((p) => !p.counted);

  if (position.category === "billing") {
    return (
      <Disclosure>
        <Amounts rows={[["Face value", money(position.total)], ["Billing status", position.reason]]} />
        <p className="mt-2 text-muted-foreground">
          This invoice hasn't been sent, so it isn't counted in outstanding AR.
        </p>
      </Disclosure>
    );
  }

  return (
    <Disclosure>
      <Amounts
        rows={[
          ["Invoice total", money(position.total)],
          [`Payments counted through ${snapshot}`, money(position.paid_to_date)],
          ["Remaining balance", money(position.remaining_balance)],
        ]}
      />
      {position.payment_position === "unknown" && (
        <p className="mt-2 text-red-700">
          The balance can't be calculated because the invoice total or a payment's amount or date is missing.
        </p>
      )}
      {position.payment_position === "credit_or_inconsistent" && (
        <p className="mt-2 text-red-700">
          Recorded payments are more than the invoice total. Check the payment records with finance.
        </p>
      )}

      {counted.length > 0 ? (
        <table className="mt-3 w-full text-left text-sm tabular-nums">
          <thead className="text-xs text-muted-foreground">
            <tr className="border-b">
              <th className="py-1.5 font-medium">Payment date</th>
              <th className="py-1.5 font-medium">Amount</th>
              <th className="py-1.5 font-medium">Reference</th>
            </tr>
          </thead>
          <tbody>
            {counted.map((payment) => (
              <tr key={payment.ref} className="border-b">
                <td className="py-1.5">{day(payment.payment_date)}</td>
                <td className="py-1.5">{money(payment.amount)}</td>
                <td className="py-1.5">{payment.reference_number ?? "—"}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p className="mt-3 text-muted-foreground">No payments recorded through {snapshot}.</p>
      )}

      {excluded.map((payment) => (
        <p key={payment.ref} className="mt-2 text-muted-foreground">
          Not counted: {money(payment.amount)} {exclusionReason(payment, as_of, snapshot)}.
        </p>
      ))}
    </Disclosure>
  );
}

function exclusionReason(payment: Payment, asOf: string, snapshot: string): string {
  if (!payment.payment_date) return "has no payment date";
  if (payment.amount === null) return `dated ${day(payment.payment_date)} has no amount`;
  if (payment.payment_date > asOf) return `dated ${day(payment.payment_date)}, after the ${snapshot} snapshot`;
  return `dated ${day(payment.payment_date)}`;
}

function Disclosure({ children }: { children: React.ReactNode }) {
  return (
    <details className="mt-6 border-t pt-4">
      <summary className="cursor-pointer font-medium text-primary">Balance details</summary>
      <div className="mt-3">{children}</div>
    </details>
  );
}

function Amounts({ rows }: { rows: [string, string][] }) {
  return (
    <dl className="grid grid-cols-[1fr_auto] gap-x-4 gap-y-1 tabular-nums">
      {rows.map(([label, value]) => (
        <div key={label} className="contents">
          <dt className="text-muted-foreground">{label}</dt>
          <dd className="text-right font-medium">{value}</dd>
        </div>
      ))}
    </dl>
  );
}
