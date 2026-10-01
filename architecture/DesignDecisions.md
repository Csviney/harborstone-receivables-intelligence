# Design decisions

Living record. Entries below are accepted planning decisions, **not claims of implemented or tested functionality**. As work progresses, append the relevant change, alternative, rationale, consequence, and actual validation result. Update the authoritative guide in the same change when a contract changes; keep future possibilities in [FutureDirections.md](FutureDirections.md).

| ID | Decision | Rationale and tradeoff |
|---|---|---|
| D01 | One invoice-centered review/preparation journey. | A complete operator outcome is more useful than partial CRM, project, and accounting modules. Company-wide visibility is intentionally limited to this workflow. See Product.md. |
| D02 | Source records remain read-only, including verification cases. | Accounting/CRM/project systems retain authority. A targeted internal request is a legitimate endpoint; no local fixes, dismissals, or case-resolution state. |
| D03 | Deterministic triage; on-demand AI investigation. | Browsing stays immediate, explainable, and usable without model access. AI is reserved for contextual interpretation and wording, not arithmetic or repeated queue scoring. |
| D04 | One backend and PostgreSQL; direct Psycopg queries. | The small relational workflow benefits from visible joins and exact arithmetic. No ORM mapping of all source tables, service fleet, or queue infrastructure. |
| D05 | Fixed source cutoff and narrowly scoped AR reconstruction. | Prevents today's date, current statuses, or due months from being mistaken for a historical ledger/cash forecast. USD display and UTC dates are documented conventions. See Data.md. |
| D06 | A conservative later-note flag, not automatic textual reconciliation. | Zero balance plus a later note deserves review; it is not proof of contradiction. This can over-flag a benign note, but avoids hardcoded scenarios and an extra triage model. |
| D07 | Invoice-scoped prefetch, two read-only context tools, saved input hash. | Mandatory evidence cannot be missed; optional tools expose useful context without DB transactions across model latency. Hash reuse needs explicit version changes when behavior changes. |
| D08 | Backend action/ref validation and exact-value draft substitution. | A short allowlisted substitution function protects generated financial values without a general template framework. It cannot certify the model's prose or later human edits. |
| D09 | Three app tables: investigations, drafts, activity events. | Saves useful work and observed execution without building a task or email system. Source references are not cross-schema FKs, so source restore remains independent; validate IDs and bundle hashes at the application boundary. |
| D10 | Local awaited agent runs with bounded execution. | Simpler than durable background work for the single-user demo. Interrupted runs are marked failed; no guarantee of completion after process exit or distributed concurrency. |
| D11 | Preparation activity, not recovery attribution. | Copied text does not prove delivery, customer response, or causally recovered money. No fake savings/collections counter. |
| D12 | One screen with progressive disclosure. | A worklist, detail panel, small trend, and expandable evidence are sufficient. The focused mock is a reference, not a mandate for visual or framework complexity. |

## Implementation entries

**2026-09-30 — Runnable foundation**

- **Review works without the model.** Source review needs only the database; missing model settings disable assessment, not the app. If the database is down, the app still starts, reports it, and recovers without a restart. Validated by running without model settings and by stopping and restarting the database.
- **Source records and generated text are protected by the database, not only the UI.** The runtime role can read source data but not change it, cannot alter a draft's original generated text, and can only append activity events (supports D02, D09, D11). Validated by setup checks and tests.
- **The model must be constrained to permitted actions.** `gpt-4o-mini` handles tool calls and structured output. In an early unconstrained check it proposed billing review for a paid invoice with a conflicting note, where Data.md requires verification. Investigations will therefore supply the allowed actions and reject anything outside them.

Use a compact entry when a material choice changes or is validated:

```text
Date / commit — Decision or finding
Choice and alternative:
Reason / business consequence:
Validation actually performed:
Guides affected:
```

Do not invent precision to settle an ambiguity. A new financial interpretation needs explicit supporting evidence or a documented assumption, not a silent change to totals.
