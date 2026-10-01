import { useState } from "react";

import { assessInvoice } from "../api";
import { describeRecord, type DescribedRecord } from "../records";
import type { Action, Finding, InvestigationState, SuggestedEmail } from "../types";
import { Badge } from "./ui/badge";
import { Button } from "./ui/button";

const ACTION_LABELS: Record<Action, string> = {
  customer_followup: "Suggests customer follow-up",
  internal_billing_review: "Suggests internal billing review",
  internal_verification: "Suggests internal verification",
  no_outreach: "Suggests no outreach",
};

type Props = {
  invoiceId: string;
  initial: InvestigationState;
};

export default function InvestigationPanel({ invoiceId, initial }: Props) {
  const [state, setState] = useState(initial);
  const [running, setRunning] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function assess(refresh: boolean) {
    setRunning(true);
    setError(null);
    try {
      const result = await assessInvoice(invoiceId, refresh);
      setState((s) => ({ ...s, assessment: result.investigation, current: true, latest_attempt: null }));
    } catch (e) {
      setError((e as Error).message);
    } finally {
      setRunning(false);
    }
  }

  if (!state.applicable) {
    return (
      <section aria-label="Assessment" className="mt-6 rounded-lg border p-4 text-muted-foreground">
        No assessment needed. The facts above cover paid and not-yet-due invoices.
      </section>
    );
  }

  const { assessment, latest_attempt: lastAttempt } = state;
  const output = assessment?.output;

  return (
    <section aria-label="Assessment" className="mt-6 rounded-lg border p-4">
      <div className="flex flex-wrap items-center justify-between gap-2">
        <div>
          <h3 className="font-semibold">Assessment</h3>
          <p className="text-xs text-muted-foreground">
            AI reading of the customer and project records. It doesn't change the facts above. Review before acting.
          </p>
        </div>
        <Button size="sm" variant={assessment ? "outline" : "default"} disabled={running || !state.available}
                onClick={() => assess(Boolean(assessment))}>
          {running ? "Assessing…" : assessment ? "Re-assess" : "Assess invoice"}
        </Button>
      </div>

      {!state.available && <p className="mt-3 text-muted-foreground">Assessment isn't available right now.</p>}
      {running && <p className="mt-3 text-muted-foreground">This can take up to a minute.</p>}
      {error && (
        <p className="mt-3 text-red-700">
          {error}{" "}
          <button className="underline" onClick={() => assess(Boolean(assessment))}>
            Try again
          </button>
        </p>
      )}
      {!error && lastAttempt?.status === "failed" && (
        <p className="mt-3 text-xs text-muted-foreground">Last attempt failed: {lastAttempt.error_message}</p>
      )}

      {output && (
        <div className="mt-4 space-y-4">
          {!state.current && (
            <p className="rounded-md border border-amber-200 bg-amber-50 px-3 py-2 text-amber-900">
              The source data or assessment settings changed since this was prepared. Re-assess to update it.
            </p>
          )}
          <div>
            <Badge variant="outline">{ACTION_LABELS[output.action]}</Badge>
            <p className="mt-2">{output.summary}</p>
          </div>
          <Findings title="Findings" items={output.findings} records={assessment.cited_records} />
          <Findings title="Cautions" items={output.warnings} records={assessment.cited_records} />
          <Findings
            title="Recommendation"
            items={[output.recommendation]}
            records={assessment.cited_records}
          />

          {assessment.email && <EmailSuggestion email={assessment.email} current={state.current} />}
        </div>
      )}
    </section>
  );
}

type Records = Record<string, Record<string, unknown>>;

function Findings({ title, items, records }: { title: string; items: Finding[]; records: Records }) {
  const [open, setOpen] = useState<string | null>(null);
  if (items.length === 0) return null;
  return (
    <div>
      <h4 className="mb-1 text-xs font-semibold tracking-wide text-muted-foreground uppercase">{title}</h4>
      <ul className="space-y-2">
        {items.map((item, index) => {
          const openRef = open?.startsWith(`${index}:`) ? open.slice(open.indexOf(":") + 1) : null;
          return (
            <li key={index}>
              {item.text}
              <div className="mt-1 flex flex-wrap gap-1">
                {item.evidence_refs.map((ref) => {
                  const key = `${index}:${ref}`;
                  return (
                    <button key={ref} type="button" aria-expanded={open === key} onClick={() => setOpen(open === key ? null : key)}>
                      <Badge variant="secondary" className="hover:bg-border">
                        {describeRecord(ref, records[ref])?.label ?? "Source record"}
                      </Badge>
                    </button>
                  );
                })}
              </div>
              {openRef && <SavedRecord described={describeRecord(openRef, records[openRef])} />}
            </li>
          );
        })}
      </ul>
    </div>
  );
}

function SavedRecord({ described }: { described: DescribedRecord | null }) {
  if (!described) return <p className="mt-2 text-xs text-muted-foreground">This record wasn't saved with the assessment.</p>;
  return (
    <div className="mt-2 rounded-md border bg-card p-3 text-xs">
      <p className="mb-2 text-muted-foreground">{described.label}, as saved with this assessment</p>
      <dl className="grid grid-cols-[max-content_1fr] gap-x-4 gap-y-1">
        {described.fields.map(([label, value]) => (
          <div key={label} className="contents">
            <dt className="text-muted-foreground">{label}</dt>
            <dd className="whitespace-pre-wrap">{value}</dd>
          </div>
        ))}
      </dl>
    </div>
  );
}

function EmailSuggestion({ email, current }: { email: SuggestedEmail; current: boolean }) {
  const [status, setStatus] = useState<{ ok: boolean; text: string } | null>(null);

  async function copy() {
    try {
      await navigator.clipboard.writeText(`Subject: ${email.subject}\n\n${email.body}`);
      setStatus({ ok: true, text: "Copied. Review and send it from your email." });
    } catch {
      setStatus({ ok: false, text: "Couldn't copy to the clipboard. Select the text and copy it instead." });
    }
  }

  const to = email.recipient
    ? `${email.recipient.name} <${email.recipient.email}>`
    : "Your billing or finance team (no recipient on record)";

  return (
    <section aria-label="Suggested email">
      <h4 className="mb-1 text-xs font-semibold tracking-wide text-muted-foreground uppercase">Suggested email</h4>
      <div className="rounded-md bg-muted p-3">
        <dl className="grid grid-cols-[max-content_1fr] gap-x-3 gap-y-1 text-xs">
          <dt className="text-muted-foreground">For</dt>
          <dd>{email.audience === "customer" ? "Customer" : "Internal"}</dd>
          <dt className="text-muted-foreground">To</dt>
          <dd>{to}</dd>
          <dt className="text-muted-foreground">Subject</dt>
          <dd className="font-medium">{email.subject}</dd>
        </dl>
        <p className="mt-3 whitespace-pre-wrap">{email.body}</p>
      </div>
      <p className="mt-2 text-xs text-amber-800">
        Before sending, check recent outreach in your CRM or email and confirm the contact. These records don't
        include outreach history.
      </p>
      <div className="mt-2 flex flex-wrap items-center gap-2">
        <Button size="sm" variant="outline" disabled={!current} onClick={copy}>
          Copy email
        </Button>
        <span className={status && !status.ok ? "text-xs text-red-700" : "text-xs text-muted-foreground"}>
          {!current
            ? "Re-assess to update this email before copying it."
            : (status?.text ?? "Nothing is sent from here.")}
        </span>
      </div>
    </section>
  );
}
