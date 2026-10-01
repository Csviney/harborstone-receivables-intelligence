# Implementation plan

Build [Product.md](Product.md)'s four stories as working slices. [Data.md](Data.md) owns calculations; [Architecture.md](Architecture.md) owns boundaries; [Agent.md](Agent.md) owns model behavior. Restore the reference SQL rather than parsing it or using the mock's embedded data/assessments as application truth. Keep the root README empty for now.

## 1. Runnable foundation

Create backend/frontend scaffolds, environment example, local PostgreSQL Compose service, explicit setup script, and the three app tables. Restore `architecture/reference/source_data.sql`; grant a restricted runtime role. Start FastAPI's async pool and readiness endpoint.

Select accessible model/package versions and run one isolated tool/structured-output smoke test. Missing model credentials should disable assessment, not read-only startup; never call the model automatically on startup.

**Complete / commit:** source metadata/counts load; runtime source writes fail while app writes succeed; both dev servers and `/api/health` work. Record tested versions and actual findings in DesignDecisions.md.

## 2. Source-backed review — S1/S2

Implement joins with payment aggregation before one-to-many context. Implement pure Decimal/date functions for balances, totals, categories, and ordering. Connect the summary/worklist/detail endpoints to a single screen with filters, search, warnings, assignments, and expandable evidence.

**Complete / commit:** all 21 invoices remain accessible; Data.md's amounts and 5/4/2/4/6 category partition reconcile; partial/paid/unsent labels are accurate; selection, empty search, and source errors work. No model calls.

## 3. Bounded investigation — S3

Implement the evidence bundle/hash, reuse, duplicate-run guard, two context tools, typed output, action/citation checks, exact-value draft rendering, and local trace capture. Wire Assess/refresh/retry; save successful output and draft atomically. Record failures without publishing partial drafts. Prevent a late response for one invoice appearing on another selected invoice.

**Complete / commit:** partial-payment, unsent-billing, and conflicting-note examples lead to different supported actions. Evidence opens saved records; cached results make no model calls; failures leave facts usable. Routine tests fake the provider; a separate live check verifies actual integration.

## 4. Saved draft handoff — S4

Add subject/body editing, explicit save, and copy with app-only activity records. Preserve originals and earlier edited drafts. Confirm before discarding unsaved text; label stale analysis. A full history browser is unnecessary.

**Complete / commit:** edits survive reload; revisit reuses analysis; copying uses current saved text; errors distinguish copy from activity persistence. No sending, dismissal, resolution, or source-change controls.

## 5. Compact history — S1

Implement daily step-series and monthly movements using Data.md's selected population and sent/payment dates, including now-paid invoices. Add one expandable chart and calculation scope; no separate analytics page.

**Complete / commit:** chart endpoint equals the summary; monthly reconciliation checks pass; receipt timing is correct; population/currency/timezone assumptions are visible. All financial arithmetic stays on the backend.

## 6. Validate the complete journey

Test fresh setup and application restart. Run backend tests, TypeScript checking, focused frontend tests, and the frontend build. Perform a small explicit live assessment check separately from normal tests. Prioritize correct behavior over extra screens or visual effects.

**Complete / commit:** another developer can reproduce the numerical checks and three demonstrations, and trace UI → route → calculation/query → optional model tools → validation → persistence → UI. Record actual test findings/tradeoffs in DesignDecisions.md and deferred work in FutureDirections.md. Do not claim intended tests were executed. Leave README empty until requested.

## Focused checks

| Area | Checks |
|---|---|
| Money | Source totals; partial/full payments; no GL duplication or join multiplication; missing/inconsistent evidence is not silently zero. |
| Time | Due today; July 26–28; Net 30/60/90 dates; later-month receipts; post-cutoff payments excluded. |
| Triage | Category counts; later note after full payment; unsent billing; absent Ops assignment never invents an owner/blocker. |
| Agent | Permitted actions/exposed citations; injection ignored; invalid placeholders/numeric literals rejected; no paid-invoice demand; bounded failures; browsing makes no model calls. |
| Persistence | Input-hash reuse; refresh preserves edits; concurrent duplicate conflict; atomic completion; source-write denial. |
| UI | Search/select, evidence, loading/errors, no wrong-invoice late response, persisted edits, unsaved warning, copy outcomes. |

## Target local commands

Implement `make db-up` (PostgreSQL), `make db-setup` (explicit restore/schema/grants), `make backend` (uv/Uvicorn, one worker), `make frontend` (Vite), and `make test` (no paid calls). These commands are planned, not included scripts. `.env.example` describes runtime/admin database URLs and model settings without secrets. Setup stops on SQL errors; app startup never restores or resets data.
