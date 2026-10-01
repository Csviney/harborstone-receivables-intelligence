# Implementation plan

Build [Product.md](Product.md)'s four user stories (S1–S4) through the four delivery slices below. [Data.md](Data.md) owns calculations; [Architecture.md](Architecture.md) owns boundaries; [Investigation.md](Investigation.md) owns model behavior. Restore the reference SQL rather than parsing it or using mock data/assessments as application truth.

## 1. Runnable foundation

Create backend/frontend scaffolds, environment example, local PostgreSQL Compose service, explicit setup script, and the app investigations table. Restore `data/source_data.sql`; grant a restricted runtime role. Start FastAPI's async pool and readiness endpoint.

Select accessible model/package versions and run one isolated tool/structured-output smoke test. Missing model credentials should disable assessment, not read-only startup; never call the model automatically on startup.

**Complete / commit:** source metadata/counts load; runtime source writes fail while app writes succeed; both dev servers and `/api/health` work. Record tested versions and actual findings in DesignDecisions.md.

## 2. Source-backed review — S1/S2

Fetch payments separately and group them per invoice to avoid multiplying amounts through context joins. Implement pure Decimal/date functions for balances, totals, categories, and ordering. Connect the summary/worklist/detail endpoints to a single screen with filters, search, warnings, assignments, and expandable balance details.

**Complete / commit:** all 21 invoices remain accessible; Data.md's amounts and 5/4/2/4/6 category partition reconcile; partial/paid/unsent labels are accurate; selection, empty search, and source errors work. No model calls.

## 3. Bounded investigation — S3

Implement the evidence bundle/hash, reuse, duplicate-run guard, two context tools, typed output, action/citation checks, an optional suggested email with server-rendered financial wording, one bounded correction, and local trace capture kept on the backend. Offer Assess/refresh/retry only for collection, billing-review, and verify-first invoices. Save successful output; record failures and cancellations without leaving runs open. Prevent a late response for one invoice appearing on another selected invoice.

**Complete / commit:** partial-payment, unsent-billing, and conflicting-note examples lead to different supported actions; paid and not-yet-due invoices are not assessed. Cached results make no model calls; failures leave facts usable. Routine tests fake the provider; a separate live check verifies actual integration.

## 4. Review findings and act — S4

Show each assessment's findings, cautions, and recommendation with citations that open the evidence saved with that run, using readable labels. Show a suggested email only when present, read-only, with Copy email; an outdated assessment must be refreshed before copying. Label stale analysis. Keep developer diagnostics out of the interface. Pair it with the rule-based next step, which names where to act in the existing accounting, CRM, or project system without inventing links. Keep the summary snapshot and material data limitations visible.

**Complete / commit:** revisiting reuses analysis; citations show saved records after source changes; outdated results are labeled and their email can't be copied. Copy only writes to the clipboard. Nothing is editable, and there are no sending, outreach tracking, dismissal, resolution, or source-change controls.

## 5. Compact history — S1

Implement daily step-series and monthly movements using Data.md's selected population and sent/payment dates, including now-paid invoices. Add one expandable chart with monthly movements; no separate analytics page.

**Complete / commit:** chart endpoint equals the summary; monthly reconciliation checks pass; receipt timing is correct; population, currency, and timezone assumptions are documented in Data.md. All financial arithmetic stays on the backend.

## Validate the complete journey

Test fresh setup and application restart. Run backend tests, TypeScript checking, focused frontend tests, and the frontend build. Perform a small explicit live assessment check separately from normal tests. Prioritize correct behavior over extra screens or visual effects.

**Complete / commit:** another developer can reproduce the numerical checks and three demonstrations, and trace UI → route → calculation/query → optional model tools → validation → persistence → UI. Record actual test findings/tradeoffs in DesignDecisions.md and deferred work in FutureDirections.md. Do not claim intended tests were executed.

## Focused checks

| Area | Checks |
|---|---|
| Money | Source totals; partial/full payments; no GL duplication or join multiplication; missing/inconsistent evidence is not silently zero. |
| Time | Due today; July 26–28; Net 30/60/90 dates; later-month receipts; post-cutoff payments excluded. |
| Triage | Category counts; later note after full payment; unsent billing; absent Ops assignment never invents an owner/blocker. |
| Agent | Permitted actions/exposed citations; injection ignored; no paid or unsent customer follow-up; paid/not-yet-due not assessed; bounded failures and one correction; email eligibility, recipients, and server-rendered amounts; plain-prose assessment fields; all problems sent to the one correction; browsing makes no model calls. |
| Persistence | Input-hash reuse; refresh keeps earlier results; concurrent duplicate conflict; cancelled/failed runs recorded; source-write denial. |
| UI | Search/select, evidence, saved-record citations, loading/errors, no wrong-invoice late response, no assessment offered for paid/not-yet-due; suggested email and copy outcomes; no developer diagnostics shown. |

## Local commands

Use `make db-up` (PostgreSQL), `make db-setup SOURCE=data/source_data.sql` (restore/schema/grants), `make db-verify` (permissions), `make backend` (uv/Uvicorn, one worker), `make frontend` (Vite), and `make test` (no paid calls). `.env.example` describes the runtime database URL, setup-role credentials, and model settings without secrets. Setup stops on SQL errors; app startup never restores or resets data.
