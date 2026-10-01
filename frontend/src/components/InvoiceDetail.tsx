import { useEffect, useState, type ReactNode } from "react";

import { fetchInvoice } from "../api";
import { CATEGORY_TONE, NEXT_STEP } from "../categories";
import { day, money } from "../format";
import { cn } from "../lib/utils";
import type { InvoiceDetail as Detail, PaymentPosition, SourceNote } from "../types";
import BalanceDetails from "./BalanceDetails";
import InvestigationPanel from "./InvestigationPanel";
import { Badge } from "./ui/badge";
import { Button } from "./ui/button";
import { Card } from "./ui/card";

const PAYMENT_LABELS: Record<PaymentPosition, string> = {
  no_receipts: "No recorded payments",
  partially_paid: "Partially paid",
  paid: "Paid in export",
  credit_or_inconsistent: "Payments exceed total",
  unknown: "Unknown",
};

type State = { kind: "loading" } | { kind: "loaded"; detail: Detail } | { kind: "error"; message: string };

export default function InvoiceDetail({ invoiceId }: { invoiceId: string }) {
  const [state, setState] = useState<State>({ kind: "loading" });
  const [attempt, setAttempt] = useState(0);

  useEffect(() => {
    const controller = new AbortController();
    setState({ kind: "loading" });
    // Ignore responses for an invoice that is no longer selected.
    fetchInvoice(invoiceId, controller.signal)
      .then((detail) => {
        if (!controller.signal.aborted) setState({ kind: "loaded", detail });
      })
      .catch((error: Error) => {
        if (!controller.signal.aborted) setState({ kind: "error", message: error.message });
      });
    return () => controller.abort();
  }, [invoiceId, attempt]);

  if (state.kind === "loading") return <Panel className="text-muted-foreground">Loading invoice…</Panel>;
  if (state.kind === "error") {
    return (
      <Panel className="space-y-3">
        <p className="text-red-700">Couldn't load this invoice. {state.message}</p>
        <Button variant="outline" size="sm" onClick={() => setAttempt((n) => n + 1)}>
          Retry
        </Button>
      </Panel>
    );
  }

  const { detail } = state;
  const { position, customer, job } = detail;
  const unsent = position.category === "billing";

  return (
    <Panel aria-label={`Invoice ${position.invoice_number}`}>
      <header className="flex flex-wrap items-start justify-between gap-4">
        <div>
          <h2 className="flex items-center gap-2 text-xl font-semibold">
            {position.invoice_number}
            <Badge variant="secondary">{position.status ?? "No status"}</Badge>
          </h2>
          <p className="mt-1 text-muted-foreground">{customer?.name ?? "Unknown customer"}</p>
        </div>
        <div className={cn("rounded-lg border px-4 py-2.5", CATEGORY_TONE[position.category].soft)}>
          <div className="text-xs opacity-80">Next step</div>
          <div className="font-semibold">{NEXT_STEP[position.category]}</div>
          <div className="text-xs opacity-80">{position.reason}</div>
        </div>
      </header>

      {detail.warnings.length > 0 && (
        <ul
          aria-label="Warnings"
          className="mt-4 list-disc space-y-0.5 rounded-lg border border-amber-200 bg-amber-50 py-2.5 pr-4 pl-8 text-amber-900"
        >
          {detail.warnings.map((warning) => (
            <li key={warning.code + warning.message}>{warning.message}</li>
          ))}
        </ul>
      )}

      <dl className="mt-4 grid grid-cols-[repeat(auto-fill,minmax(150px,1fr))] gap-2">
        <Fact label="Invoice total" value={money(position.total)} />
        {!unsent && <Fact label="Paid to date" value={money(position.paid_to_date)} />}
        {!unsent && <Fact label="Remaining balance" value={money(position.remaining_balance)} />}
        <Fact label="Payment position" value={PAYMENT_LABELS[position.payment_position]} />
        <Fact label="Invoice date" value={day(detail.invoice_date)} />
        <Fact label="Due date" value={day(position.due_date)} />
        <Fact label="Sent" value={position.sent_date ? day(position.sent_date) : "Not sent"} />
        {position.overdue_days !== null && <Fact label="Days past due" value={String(position.overdue_days)} />}
        {detail.latest_payment_date && <Fact label="Latest payment" value={day(detail.latest_payment_date)} />}
      </dl>

      <InvestigationPanel
        key={position.id}
        invoiceId={position.id}
        initial={detail.investigation}
      />

      <div className="grid gap-6 md:grid-cols-2">
        <Section title="Customer">
          {customer && customer.contacts.length > 0 ? (
            <ul className="space-y-3">
              {customer.contacts.map((contact) => (
                <li key={contact.ref}>
                  <span className="font-medium">{contact.name}</span>
                  {contact.title && <span className="text-muted-foreground">, {contact.title}</span>}
                  <div className="text-xs text-muted-foreground">
                    {contact.role === "invoice_contact" ? "Invoice contact" : "Company billing contact"}
                  </div>
                  <div>{[contact.email, contact.phone].filter(Boolean).join(" · ") || "No email or phone"}</div>
                </li>
              ))}
            </ul>
          ) : (
            <p className="text-muted-foreground">No contact on record.</p>
          )}
          {customer?.notes && <p className="mt-3 whitespace-pre-wrap">{customer.notes}</p>}
        </Section>

        <Section title="Job">
          {job ? (
            <>
              <p>
                <span className="font-medium">{job.job_number}</span> {job.site_name}
              </p>
              <p className="text-muted-foreground">
                Project {job.project_status?.toLowerCase().replace("_", " ") ?? "unavailable"}
                {job.completed_on && `, completed ${day(job.completed_on)}`}
                {job.reporting_branch && ` · ${job.reporting_branch} branch`}
              </p>
            </>
          ) : (
            <p className="text-muted-foreground">No linked job.</p>
          )}
          <ul className="mt-2 space-y-1">
            {detail.assignments.map((assignment) => (
              <li key={assignment.ref}>
                <span className="text-muted-foreground">{assignment.capacity}:</span>{" "}
                {assignment.employee_name ?? "Unknown"}
              </li>
            ))}
          </ul>
        </Section>
      </div>

      <Notes title="Invoice notes" notes={detail.notes} />
      <Notes title="Project notes" notes={detail.project_notes} />
      {detail.invoice_notes && <p className="mt-3 whitespace-pre-wrap">{detail.invoice_notes}</p>}

      <BalanceDetails detail={detail} />
    </Panel>
  );
}

function Panel({ className, ...props }: { className?: string; children: ReactNode; "aria-label"?: string }) {
  return <Card role="region" className={cn("p-5 lg:sticky lg:top-4", className)} {...props} />;
}

function Section({ title, children }: { title: string; children: ReactNode }) {
  return (
    <section>
      <h3 className="mt-6 mb-2 text-xs font-semibold tracking-wide text-muted-foreground uppercase">{title}</h3>
      {children}
    </section>
  );
}

function Fact({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-lg bg-muted px-3 py-2">
      <dt className="text-xs text-muted-foreground">{label}</dt>
      <dd className="mt-0.5 font-semibold tabular-nums">{value}</dd>
    </div>
  );
}

function Notes({ title, notes }: { title: string; notes: SourceNote[] }) {
  if (notes.length === 0) return null;
  return (
    <Section title={title}>
      <ul className="space-y-3">
        {notes.map((note) => (
          <li key={note.ref} className="border-l-2 pl-3 whitespace-pre-wrap">
            <div className="text-xs text-muted-foreground">
              {day(note.note_date)} · {note.author ?? "Unknown author"}
            </div>
            {note.content}
          </li>
        ))}
      </ul>
    </Section>
  );
}
