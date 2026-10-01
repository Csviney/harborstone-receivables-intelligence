# Harborstone receivables review

## Purpose

Help an AR coordinator identify invoices needing attention, understand the evidence, and decide where the next step belongs. Connect customer, project, invoice, and payment records; leave their maintenance in the originating systems.

The [company brief](Harborstone-Company-Brief.md) describes manual reconstruction across disconnected systems. The business objective is less preparation work, fewer incorrect collection requests, and quicker action on overdue balances and unsent billing. Faster collection can release working capital; less administration can improve efficiency. Collecting an existing receivable is **not new revenue**. The prototype cannot prove recovered cash or profitability gains.

Deliver a narrow, working, interactive demo with defensible choices; pixel-perfect reproduction of mockups is unnecessary.

## Guide map

Read Product → [Data](Data.md) → [Architecture](Architecture.md) → [Investigation](Investigation.md) → [ImplementationPlan](ImplementationPlan.md). Each owns its respective contract; do not duplicate financial rules in UI or agent code. [DesignDecisions](DesignDecisions.md) records accepted choices and actual findings; [FutureDirections](FutureDirections.md) is not committed scope. The root README is intentionally empty for now.

## User and stakeholder value

The daily user is an AR coordinator working with project teams, not an executive maintaining another dashboard.

| Stakeholder | Intended value |
|---|---|
| Rachel, VP of Finance | Source-backed balances, explicit assumptions, and financial exceptions separated from collection-ready items. |
| Tasha, Project Director; Luis, VP of Operations | Targeted billing questions with job context and known assignments; less administrative reconstruction. |
| Maya, COO | Shared visibility into recorded AR exposure and attention needed across supplied branches. |
| Devon, VP of Growth | Existing customer/relationship context without new CRM data entry. |

Source employee titles may differ from the brief's stakeholder titles. Display source assignment capacities, not inferred ownership.

## One screen, four stories

| ID | User need | Complete behavior |
|---|---|---|
| S1 — Triage | Find what deserves attention. | Rules-based worklist, search/category filters, recorded AR totals, and compact historical trend; no AI required. Each item has a reason. |
| S2 — Understand | Check the situation before contacting anyone. | Selected invoice shows calculation, dates, customer/contact, linked job/status, known assignments, warnings, and expandable evidence. |
| S3 — Investigate | Interpret context the rules can't. | For collection, billing, and verification items, an explicit **Assess invoice** produces a saved, cited assessment that interprets customer/project context, explains exceptions, and names missing evidence. When the findings support contact, it may include a suggested email. Paid and not-yet-due invoices are not assessed. |
| S4 — Act | Know where to act. | Review the findings with their saved evidence, see whether they are still current, and take the rule-based next step in the existing accounting, CRM, or project system. A current suggested email can be copied into the user's own email client. |

**Find → inspect → assess where useful → review findings → act in the existing system.** Identifying a needed verification completes this journey even when the source issue remains unresolved.

## Interface contract

A summary strip shows outstanding AR, its overdue portion, and unsent billing separately. A sparkline expands to one trend and its calculation scope. Below it, place one worklist and one detail panel. Default to Collections; offer Billing review, Verify first, and All. All includes not-yet-due and paid invoices. Use Data.md's amounts, labels, and ordering.

Keep the snapshot date and material limitations visible; put the detailed calculation scope behind a disclosure.

In detail, show facts, warnings, and the rule-based next step before any assessment; the normal view never calls a model. State where the next step belongs: customer follow-up, billing review in the accounting system, or finance verification. Do not invent external-system links. Keep balance details (total, payments counted through the snapshot, remaining balance, and any excluded payments or uncertainty, or face value and billing status for unsent invoices) collapsed until requested; each citation opens the record as it was saved with that assessment, with readable labels.

Show a **Suggested email** below the findings only when the assessment includes one: audience, the recipient from source records when known, subject, body, and **Copy email**. It is read-only; users edit and send it in their own email. Because the export has no outreach history, both the collection next step and the email remind users to check recent outreach and confirm the contact first. Copy only writes to the clipboard and reports success or failure; it is not recorded as outreach. An outdated assessment must be refreshed before its email can be copied.

Nothing is editable. No source corrections, warning dismissal, assignments, approval forms, sending, or “mark resolved.” An assessment never changes source status/category, overrides calculated facts, or implies that outreach happened; missing outreach history does not mean nobody contacted the customer. Preserve selection and search. A refresh produces a new assessment and keeps earlier ones on record.

The interface is for AR staff. Show evidence with readable labels, source dates, the snapshot, limitations, stale notices, and plain-language errors; keep model names, token counts, tool traces, versions, raw field names, and setup notes on the backend.

Support loading, no results, source/model/clipboard failures, and ordinary laptop-width responsiveness. Model failure must leave source facts visible. No elaborate navigation or tracing dashboard.

## Demonstration and boundary

Use Data.md's fixtures: **Redbird 0502** is a collection item with a recorded partial payment; **Brookline 0596** needs internal review of draft billing after completion; **Redbird 0455** surfaces a paid-invoice/note conflict that calls for verification, not a payment demand. An ordinary paid or current invoice needs no assessment. These are outcomes of generic rules, not hardcoded invoice branches.

Always show the **July 28, 2026 snapshot**. CRM/project/accounting are logical categories in the export, not live integrations. Historical AR is a scoped reconstruction—not certified books, a cash forecast, or AI-recovery attribution.

Exclude sending/replies, reminders, task/case management, source edits, payment simulation, AP forecasts, full job-profitability analysis, CRM replacement, deployment, and authentication. Done means the four stories work locally from the supplied export with an actual model integration and the focused checks in ImplementationPlan.md. Long-term value still requires fresh source data and adoption; a static snapshot or an assessment does not demonstrate cash recovered.
