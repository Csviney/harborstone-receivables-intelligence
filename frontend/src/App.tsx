import { useEffect, useState } from "react";

import { fetchHealth } from "./api";
import type { Health } from "./types";

const DATABASE_ERRORS: Record<NonNullable<Health["database"]["error"]>, string> = {
  database_unavailable: "Database unavailable",
  source_not_restored: "Source data not loaded",
  app_schema_missing: "Application tables missing",
  permission_denied: "Database permissions missing",
};

type State = { kind: "loading" } | { kind: "loaded"; health: Health } | { kind: "error" };

export default function App() {
  const [state, setState] = useState<State>({ kind: "loading" });

  useEffect(() => {
    let active = true;
    fetchHealth()
      .then((health) => active && setState({ kind: "loaded", health }))
      .catch(() => active && setState({ kind: "error" }));
    return () => {
      active = false;
    };
  }, []);

  return (
    <main className="shell">
      <header>
        <h1>Harborstone receivables review</h1>
        {state.kind === "loaded" && state.health.database.dataset_as_of && (
          <p className="snapshot">Source snapshot as of {formatDate(state.health.database.dataset_as_of)}</p>
        )}
      </header>

      {state.kind === "loading" && <p>Checking readiness…</p>}
      {state.kind === "error" && <p className="problem">Unable to reach the API</p>}
      {state.kind === "loaded" && (
        <dl className="readiness">
          <dt>Source data</dt>
          <dd className={state.health.database.ready ? "ok" : "problem"}>
            {state.health.database.ready ? "Ready" : DATABASE_ERRORS[state.health.database.error ?? "database_unavailable"]}
          </dd>
          <dt>Invoice assessment</dt>
          <dd className={state.health.model.assessment_available ? "ok" : "muted"}>
            {state.health.model.assessment_available
              ? `Available (${state.health.model.model})`
              : "Not configured"}
          </dd>
        </dl>
      )}
    </main>
  );
}

// Format in UTC so the date doesn't shift back a day in US time zones.
function formatDate(isoDate: string): string {
  const [year, month, day] = isoDate.split("-").map(Number);
  return new Date(Date.UTC(year, month - 1, day)).toLocaleDateString("en-US", {
    timeZone: "UTC",
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}
