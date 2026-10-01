import { useCallback, useEffect, useState } from "react";

import { fetchReceivables } from "./api";
import InvoiceDetail from "./components/InvoiceDetail";
import ReceivablesQueue, { type Filter } from "./components/ReceivablesQueue";
import { Badge } from "./components/ui/badge";
import { Button } from "./components/ui/button";
import { Card } from "./components/ui/card";
import { day, money } from "./format";
import { cn } from "./lib/utils";
import type { Bucket, Receivables } from "./types";

type State = { kind: "loading" } | { kind: "loaded"; data: Receivables } | { kind: "error"; message: string };

export default function App() {
  const [state, setState] = useState<State>({ kind: "loading" });
  const [filter, setFilter] = useState<Filter>("collect");
  const [search, setSearch] = useState("");
  const [selectedId, setSelectedId] = useState<string | null>(null);

  const load = useCallback(() => {
    setState({ kind: "loading" });
    fetchReceivables()
      .then((data) => {
        setState({ kind: "loaded", data });
        setSelectedId((current) => current ?? data.invoices.find((i) => i.category === "collect")?.id ?? null);
      })
      .catch((error: Error) => setState({ kind: "error", message: error.message }));
  }, []);

  useEffect(load, [load]);

  if (state.kind === "loading") return <Shell>Loading receivables…</Shell>;
  if (state.kind === "error") {
    return (
      <Shell>
        <div className="space-y-3">
          <p className="text-red-700">Couldn't load receivables. {state.message}</p>
          <Button variant="outline" size="sm" onClick={load}>
            Retry
          </Button>
        </div>
      </Shell>
    );
  }

  const { data } = state;
  const { summary } = data;

  return (
    <Shell>
      <header className="mb-5 flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-2xl font-semibold tracking-tight">Receivables review</h1>
        <Badge variant="outline" className="bg-card">
          Snapshot {day(data.as_of, "long")}
        </Badge>
      </header>

      <section aria-label="Summary" className="mb-5">
        <div className="grid gap-3 md:grid-cols-3">
          <SummaryCard label="Outstanding AR" bucket={summary.outstanding} accent="border-t-blue-600" />
          <SummaryCard label="Overdue" bucket={summary.overdue} accent="border-t-red-500" />
          <SummaryCard label="Unsent billing" bucket={summary.unsent_billing} accent="border-t-amber-500" />
        </div>
        <p className="mt-2 text-xs text-muted-foreground">
          {summary.scope}
          {summary.sync_failed.count > 0 &&
            ` Excludes ${summary.sync_failed.count} invoice(s) with a failed accounting sync (${money(summary.sync_failed.amount)}).`}
        </p>
        {summary.limitations.map((limitation) => (
          <p key={limitation} className="mt-1 text-xs text-red-700">
            {limitation}
          </p>
        ))}
      </section>

      <div className="grid items-start gap-4 lg:grid-cols-[minmax(340px,420px)_1fr]">
        <ReceivablesQueue
          invoices={data.invoices}
          filter={filter}
          search={search}
          selectedId={selectedId}
          onFilterChange={setFilter}
          onSearchChange={setSearch}
          onSelect={setSelectedId}
        />
        {selectedId ? (
          <InvoiceDetail invoiceId={selectedId} />
        ) : (
          <Card className="p-5 text-muted-foreground">Select an invoice to see its details.</Card>
        )}
      </div>
    </Shell>
  );
}

function Shell({ children }: { children: React.ReactNode }) {
  return <main className="mx-auto max-w-[1320px] px-4 py-6">{children}</main>;
}

function SummaryCard({ label, bucket, accent }: { label: string; bucket: Bucket; accent: string }) {
  return (
    <Card className={cn("border-t-4 px-4 py-3", accent)}>
      <div className="text-xs text-muted-foreground">{label}</div>
      <div className="text-2xl font-semibold tabular-nums">{money(bucket.amount)}</div>
      <div className="text-xs text-muted-foreground">
        {bucket.count} invoice{bucket.count === 1 ? "" : "s"}
      </div>
    </Card>
  );
}
