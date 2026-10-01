# Harborstone receivables review

## Purpose

Help an AR coordinator identify invoices needing attention, understand the evidence, and prepare the right follow-up. Connect customer, project, invoice, and payment records; leave their maintenance in the originating systems.

The [company brief](reference/Harborstone-Company-Brief.md), lines 15–37, describes manual reconstruction across disconnected systems. The business objective is less preparation work, fewer incorrect collection requests, and quicker action on overdue balances and unsent billing. Faster collection can release working capital; less administration can improve efficiency. Collecting an existing receivable is **not new revenue**. The prototype cannot prove recovered cash or profitability gains.

The [assignment](reference/Ciridae-Case-Study_.txt) calls for a narrow, working, interactive demo with defensible choices. The [focused mock](reference/Harborstone_AR_Focused_Mock.html) is the interaction reference, not application code or live AI output. Earlier broad mockups are superseded; pixel-perfect reproduction is unnecessary.

## Guide map

Read Product → [Data](Data.md) → [Architecture](Architecture.md) → [Agent](Agent.md) → [ImplementationPlan](ImplementationPlan.md). Each owns its respective contract; do not duplicate financial rules in UI or agent code. [DesignDecisions](DesignDecisions.md) records accepted choices and actual findings; [FutureDirections](FutureDirections.md) is not committed scope. The root README is intentionally empty for now.

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
| S3 — Prepare | Choose and word the next step. | Explicit **Assess invoice** produces a saved, cited assessment and optional customer/internal draft—or recommends no outreach. |
| S4 — Reuse | Retain useful work. | Reuse matching assessments; edit/save/copy draft subject/body. Copying never means sending or resolving. |

**Find → inspect → assess → review/edit → copy into the existing workflow.** Preparing a verification request completes this journey even when the source issue remains unresolved.

## Interface contract

A summary strip shows outstanding AR, its overdue portion, and unsent billing separately. A sparkline expands to one trend and its calculation scope. Below it, place one worklist and one detail panel. Default to Collections; offer Billing review, Verify first, and All. All includes not-yet-due and paid invoices. Use Data.md's amounts, labels, and ordering.

In detail, show facts and warnings before the assessment/draft. Keep source evidence and actual tool activity collapsed until requested. State where the recommended action belongs: customer communication, billing review, or finance verification. Do not invent external-system links.

Only draft subject/body is editable. No source corrections, warning dismissal, assignments, approval forms, or “mark resolved.” Preparing a message never changes source status/category. Preserve selection/search and saved drafts; confirm before discarding unsaved edits. A refresh produces a new draft without overwriting an earlier edited version.

Support loading, no results, source/model/save/clipboard failures, and ordinary laptop-width responsiveness. Model failure must leave source facts visible. No elaborate navigation or tracing dashboard.

## Demonstration and boundary

Use Data.md's fixtures: **Redbird 0502** acknowledges partial payment; **Brookline 0596** requests internal review of draft billing after completion; **Redbird 0455** surfaces a paid-invoice/note conflict without a payment demand. An ordinary paid or current invoice needs no reminder. These are outcomes of generic rules, not hardcoded invoice branches.

Always show the **July 28, 2026 snapshot**. CRM/project/accounting are logical categories in the export, not live integrations. Historical AR is a scoped reconstruction—not certified books, a cash forecast, or AI-recovery attribution.

Exclude sending/replies, reminders, task/case management, source edits, payment simulation, AP forecasts, full job-profitability analysis, CRM replacement, deployment, and authentication. Done means the four stories work locally from the supplied export with an actual model integration and the focused checks in ImplementationPlan.md. Long-term value still requires fresh source data and adoption; a static snapshot or copied draft does not demonstrate cash recovered.
