import { lazy, Suspense, useState } from "react";

import { fetchTrend } from "../api";
import type { ARTrend as Trend } from "../types";
import { Button } from "./ui/button";

// Recharts is large; load it only when someone opens the section.
const TrendChart = lazy(() => import("./TrendChart"));

type State = { kind: "idle" } | { kind: "loading" } | { kind: "loaded"; trend: Trend } | { kind: "error"; message: string };

export default function ARTrend() {
  const [state, setState] = useState<State>({ kind: "idle" });

  function load() {
    setState({ kind: "loading" });
    fetchTrend()
      .then((trend) => setState({ kind: "loaded", trend }))
      .catch((error: Error) => setState({ kind: "error", message: error.message }));
  }

  return (
    <details
      className="mb-5 rounded-xl border bg-card px-4 py-3 shadow-sm"
      onToggle={(event) => {
        if ((event.target as HTMLDetailsElement).open && state.kind === "idle") load();
      }}
    >
      <summary className="cursor-pointer font-medium">AR over time</summary>
      <div className="mt-3">
        {state.kind === "loading" && <p className="text-muted-foreground">Loading the trend…</p>}
        {state.kind === "error" && (
          <div className="space-y-2">
            <p className="text-red-700">Couldn't load the trend. {state.message}</p>
            <Button size="sm" variant="outline" onClick={load}>
              Retry
            </Button>
          </div>
        )}
        {state.kind === "loaded" && (
          <Suspense fallback={<p className="text-muted-foreground">Loading the trend…</p>}>
            <TrendChart trend={state.trend} />
          </Suspense>
        )}
      </div>
    </details>
  );
}
