# Design decisions

Accepted decisions for the current application. [Product.md](Product.md) defines the journey, [Data.md](Data.md) the financial rules and entities, [Architecture.md](Architecture.md) the implementation boundaries, and [Investigation.md](Investigation.md) the investigation contract. Future capabilities belong in [FutureDirections.md](FutureDirections.md).

## D01 — One invoice-centred workspace across three systems

Bring accounting, customer, and project context together around a specific receivables decision. Avoid recreating separate accounting, CRM, or project-management applications.

## D02 — Source systems retain ownership

Source records are read-only. Users investigate here and act in the existing systems; the app does not send messages, update balances, assign work, or mark issues resolved.

## D03 — Financial facts and triage are deterministic

Server-side Decimal/date calculations determine balances, aging, totals, categories, and the category behind the basic next step. AI cannot change those results. Missing or conflicting evidence remains explicit; a later note is a review trigger, not proof that payment records are wrong.

## D04 — Reporting has a defined snapshot and population

Calculations use the source cutoff, not today's date. Sent AR, unsent billing, and failed-sync exceptions remain distinct. The planned historical trend must reconcile receipts and new billings without implying a complete accounting ledger.

## D05 — AI investigation is optional and manually triggered

Normal review works without AI. Investigations interpret relevant notes and cross-system context when useful; ordinary paid and not-yet-due invoices do not need assessment. Browsing never triggers model calls.

## D06 — AI adds context rather than repeating the screen

Assessments give a concise conclusion and actionable guidance. Findings appear only when they qualify the next step. Missing assignments or outreach history must not become invented blockers or claims.

## D07 — Structured output is backed by server validation

Validate permitted actions, exposed citations, recipients, and email/prose boundaries. Allow one correction containing all detected problems within fixed execution limits. Citations establish provenance, not semantic correctness; model interpretation still requires review.

## D08 — Suggested emails are read-only preparation aids

Offer an email only when appropriate, with server-rendered financial wording. Users copy, edit, and send externally. There is no draft-management workflow, copy tracking, or implication that outreach occurred.

## D09 — Investigations preserve evidence and can be reused

Store each run's inputs, output, optional email template, and diagnostics in one application table. Reuse unchanged results; label stale results and require refresh before copying an outdated email. Citations show the evidence saved with the investigation. Refreshes preserve earlier records.

## D10 — The interface is for AR staff

Prioritise facts, the next step, concise findings, and useful warnings. Keep balance calculations and saved citations behind disclosures. Model names, token counts, costs, and execution traces stay off the user-facing screen.

## D11 — Keep the architecture small and enforce boundaries

Use one React frontend, one FastAPI backend, PostgreSQL, explicit SQL, and a bounded agent. Separate source reads, financial logic, and investigation persistence. Prefetch invoice-scoped evidence and expose it through two read-only context tools. Database permissions enforce read-only source access; no database connection stays borrowed during model calls. Local runs are awaited, with unfinished runs marked interrupted on restart; no background execution service is required.

Remove demonstrably unused code, but retain contract-backed source fields unless there is a deliberate reason to narrow the contract.

## D12 — Validate financial correctness separately from model quality

Regression tests protect calculations and workflows; scripted models test validation and failure handling. Live checks assess actual model behaviour. Neither passing tests nor copied emails establish recovered cash or business impact. Outcome measurement requires refreshed data and a baseline, and observed improvement alone does not establish causation.
