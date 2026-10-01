# Future directions

Agreed longer-term direction, not implemented scope. The current application reviews a static export and prepares suggested emails; it does not send messages or assign tasks. [DesignDecisions.md](DesignDecisions.md) describes the current boundaries. Update the relevant contracts when future work enters implementation.

## Keep the workspace current

Connect directly to Harborstone's accounting, CRM, and project systems so the workspace reflects new invoices, receipts, project updates, and customer activity. Show when each source was last refreshed and flag missing or conflicting information. Match records through explicit source identifiers, preserve evidence for historical reporting, and mark assessments outdated when their inputs change.

Accounting remains authoritative for invoices and receipts, CRM for customer relationships and its recorded activity, and project systems for delivery status and assignments. Verified links should take staff to the relevant record when they need to act or correct information.

Tasks and communication history should live in Harborstone's existing systems. This platform brings them together and coordinates the next step without asking staff to maintain another manual log. Missing imported activity is not proof that nobody has contacted a customer.

## Help the team follow through

Let staff turn a supported recommendation into a task for a verified owner, with a due date and the evidence needed to act. Create the task in the existing work system and notify the person through Slack or Harborstone's preferred internal notification channel.

The task system records ownership, acknowledgment, completion, and escalation; a notification alone does not mean work was accepted or completed. Bring that status back into the invoice view so colleagues can see who is following up and avoid duplicate work. Missing assignments should prompt clarification rather than an invented owner.

## Support controlled customer outreach

Support email, SMS, or phone follow-up through Twilio or another suitable communication provider. Start with staff approving the recipient and message. Consider automatic reminders later for clearly eligible invoices, once source freshness and communication history are reliable.

Before sending, recheck the balance, recent outreach, contact preferences, and consent. Apply explicit timing and frequency rules, prevent duplicate sends, and stop or route the conversation to a person when there is a payment, reply, dispute, or unresolved evidence. Record actual delivery and replies in the agreed communication system; a generated or copied message is not a sent message.

AI can help tailor wording and interpret replies. Deterministic rules continue to control financial facts, outreach eligibility, timing, and stopping conditions. Broader write-back requires agreed ownership, permissions, and an audit trail.

## Show whether the work is helping

Build the analytics around the questions Harborstone's team needs answered:

- **Are overdue balances coming down?** Show outstanding and overdue AR, how long invoices have been overdue, and how those figures move over time. Separate new billings from receipts so a growing balance is not automatically read as poor collections.
- **Where is work getting stuck?** Show invoices waiting to be sent, how long approved invoices remain unsent, unresolved exceptions, and follow-ups that are still waiting for action. Allow useful comparisons by branch or customer where the data supports them.
- **Are people getting to the next step faster?** Measure time to first action and follow-up completion. Compare preparation time before and after adoption using observed work or staff feedback, rather than treating every assessment as time saved.
- **Are customers paying sooner?** Track payment timing and overdue balances across comparable periods or invoice groups. Pair receipts with actual outreach history to understand what happened, without assuming every payment was caused by the platform.
- **Is the workspace useful to the team?** Look at adoption and whether staff find the recommendations and suggested emails useful. Use that feedback to improve the workflow, not just increase model usage.

The planned snapshot-based AR trend is the first step. Ongoing measurement needs recurring source updates, retained history, and a baseline. A lower balance, a copied email, or a completed assessment alone does not establish recovered cash or product impact.

## Build in a practical order

Start with fresh data and shared activity history, then add internal delegation, approved customer outreach, and selective automation. Develop analytics alongside each step so the team can see what improves and where effort is still being spent.

Shared production use also needs authentication, permissions, provider and retention policies, reliable execution, backups, and clear operational ownership. Profitability analysis, cash forecasts, and project closeout are further possibilities once reconciled cost, budget, and remaining-work data is available.
