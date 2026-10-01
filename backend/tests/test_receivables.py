from datetime import date, timedelta
from decimal import Decimal

import pytest

from app.receivables import Invoice, Note, Payment, context_issues, position, summarize, trend

AS_OF = date(2026, 7, 28)


def invoice(**overrides) -> Invoice:
    fields = dict(
        id="inv-1",
        invoice_number="INV-1",
        status="SENT",
        total=Decimal("1000.00"),
        due_date=AS_OF - timedelta(days=10),
        sent_date=AS_OF - timedelta(days=40),
        project_status="IN_PROGRESS",
    )
    return Invoice(**{**fields, **overrides})


def pay(amount: str, on: date, id: str = "p1") -> Payment:
    return Payment(id, on, Decimal(amount))


def test_partial_payment_leaves_remaining_balance():
    p = position(invoice(payments=(pay("400.00", AS_OF - timedelta(days=5)),)), AS_OF)
    assert (p.paid_to_date, p.remaining_balance) == (Decimal("400.00"), Decimal("600.00"))
    assert p.payment_position == "partially_paid"
    assert (p.category, p.overdue_days, p.reason) == ("collect", 10, "10 days past due")


def test_payment_after_cutoff_is_not_counted():
    p = position(invoice(payments=(pay("1000.00", AS_OF + timedelta(days=1)),)), AS_OF)
    assert p.remaining_balance == Decimal("1000.00")
    assert p.payment_position == "no_receipts"


def test_equal_payments_with_distinct_ids_both_count():
    payments = (pay("500.00", AS_OF, "p1"), pay("500.00", AS_OF, "p2"))
    assert position(invoice(payments=payments), AS_OF).remaining_balance == Decimal("0.00")


def test_due_today_is_not_overdue():
    p = position(invoice(due_date=AS_OF), AS_OF)
    assert (p.category, p.overdue_days, p.reason) == ("monitor", 0, "Due today")


def test_due_yesterday_is_one_day_overdue():
    p = position(invoice(due_date=AS_OF - timedelta(days=1)), AS_OF)
    assert (p.category, p.overdue_days, p.reason) == ("collect", 1, "1 day past due")


def test_overpayment_stays_negative_and_needs_verification():
    p = position(invoice(payments=(pay("1200.00", AS_OF),)), AS_OF)
    assert p.remaining_balance == Decimal("-200.00")
    assert (p.payment_position, p.category) == ("credit_or_inconsistent", "verify")


def test_missing_payment_amount_makes_balance_unknown():
    p = position(invoice(payments=(Payment("p1", AS_OF, None),)), AS_OF)
    assert (p.paid_to_date, p.remaining_balance, p.payment_position) == (None, None, "unknown")
    assert p.category == "verify"


def test_note_after_full_payment_needs_review():
    paid = (pay("1000.00", AS_OF - timedelta(days=30)),)
    later = position(invoice(payments=paid, notes=(Note("n1", AS_OF - timedelta(days=4)),)), AS_OF)
    earlier = position(invoice(payments=paid, notes=(Note("n1", AS_OF - timedelta(days=31)),)), AS_OF)
    assert (later.category, later.reason) == ("verify", "Later note needs review")
    assert (earlier.category, earlier.reason) == ("settled", "Paid in export")


def test_unsent_billing_has_no_aging():
    p = position(invoice(status="DRAFT", sent_date=None), AS_OF)
    assert (p.category, p.overdue_days, p.reason) == ("billing", None, "Draft, not yet sent")


def test_integrity_exceptions_route_to_verify():
    assert position(invoice(status="APPROVED"), AS_OF).reason == "Unsent invoice has a send date"
    assert position(invoice(sent_date=None), AS_OF).reason == "Sent invoice has no valid send date"
    assert position(invoice(due_date=None), AS_OF).reason == "Missing due date"
    assert position(invoice(status="VOID"), AS_OF).reason == "Unsupported status VOID"


def test_summary_scopes_ar_to_sent_invoices():
    positions = [
        position(invoice(id="a"), AS_OF),
        position(invoice(id="b", due_date=AS_OF + timedelta(days=5)), AS_OF),
        position(invoice(id="c", status="DRAFT", sent_date=None), AS_OF),
        position(invoice(id="d", status="SYNC_FAILED"), AS_OF),
        position(invoice(id="e", total=None), AS_OF),
    ]
    summary = summarize(positions, AS_OF)
    assert (summary.outstanding.amount, summary.outstanding.count) == (Decimal("2000.00"), 2)
    assert summary.overdue.amount == summary.not_yet_due.amount == Decimal("1000.00")
    assert summary.unsent_billing.amount == summary.sync_failed.amount == Decimal("1000.00")
    assert summary.limitations == ("1 invoice(s) with incomplete amounts are excluded.",)


def test_missing_ops_manager_is_a_warning_not_a_blocker():
    issues = context_issues(project_count=1, capacities={"Primary AE"}, has_contact=True,
                            contact_email="ap@example.com", contact_matches_company=True)
    assert [i.message for i in issues] == ["No Primary Ops Manager assignment"]


def test_unknown_amount_on_a_later_payment_does_not_affect_todays_balance():
    p = position(invoice(payments=(Payment("p1", AS_OF + timedelta(days=4), None),)), AS_OF)
    assert (p.remaining_balance, p.category) == (Decimal("1000.00"), "collect")


def test_undated_payment_makes_balance_unknown():
    p = position(invoice(payments=(Payment("p1", None, Decimal("100.00")),)), AS_OF)
    assert (p.remaining_balance, p.category) == (None, "verify")


def test_only_payments_on_or_before_cutoff_are_counted():
    payments = (pay("300.00", AS_OF - timedelta(days=1), "before"), pay("700.00", AS_OF + timedelta(days=1), "after"))
    p = position(invoice(payments=payments), AS_OF)
    assert (p.remaining_balance, p.counted_payment_ids) == (Decimal("700.00"), ("before",))


def test_missing_totals_stay_counted_and_are_flagged():
    positions = [
        position(invoice(id="a", status="DRAFT", sent_date=None, total=None), AS_OF),
        position(invoice(id="b", status="SYNC_FAILED", total=None), AS_OF),
    ]
    summary = summarize(positions, AS_OF)
    assert (summary.unsent_billing.amount, summary.unsent_billing.count) == (Decimal("0.00"), 1)
    assert (summary.sync_failed.amount, summary.sync_failed.count) == (Decimal("0.00"), 1)
    assert summary.limitations == (
        "Unsent billing total excludes 1 invoice(s) with no recorded total.",
        "Failed-sync total excludes 1 invoice(s) with no recorded total.",
    )


# Net 30/60/90 due dates for a July 20 invoice, taken as explicit source due dates.
@pytest.mark.parametrize("due", [date(2026, 8, 19), date(2026, 9, 18), date(2026, 10, 18)])
def test_aging_starts_the_day_after_the_due_date(due):
    sent = invoice(due_date=due, sent_date=date(2026, 7, 20))
    assert position(sent, due).overdue_days == 0
    assert position(sent, due + timedelta(days=1)).overdue_days == 1


def test_net_60_invoice_paid_after_due_date():
    paid_oct_2 = invoice(due_date=date(2026, 9, 18), sent_date=date(2026, 7, 20),
                         payments=(pay("1000.00", date(2026, 10, 2)),))
    before_payment = position(paid_oct_2, date(2026, 9, 30))
    assert (before_payment.category, before_payment.overdue_days) == ("collect", 12)
    assert position(paid_oct_2, date(2026, 10, 2)).category == "settled"


def test_trend_counts_invoices_from_their_send_date_and_payments_from_their_payment_date():
    sent = date(2026, 7, 10)
    paid_on = date(2026, 7, 20)
    inv = invoice(sent_date=sent, due_date=date(2026, 7, 15), payments=(pay("400.00", paid_on),))
    points = {p.day: p for p in trend([inv], AS_OF).points}

    assert points[sent - timedelta(days=1)].outstanding == Decimal("0.00")
    assert points[sent].outstanding == Decimal("1000.00")
    assert points[paid_on - timedelta(days=1)].outstanding == Decimal("1000.00")
    assert points[paid_on].outstanding == Decimal("600.00")


def test_trend_overdue_starts_the_day_after_the_due_date():
    inv = invoice(sent_date=date(2026, 7, 1), due_date=date(2026, 7, 15))
    points = {p.day: p for p in trend([inv], AS_OF).points}

    assert points[date(2026, 7, 15)].overdue == Decimal("0.00")
    assert points[date(2026, 7, 16)].overdue == Decimal("1000.00")


def test_trend_keeps_paid_invoices_and_ignores_payments_after_the_cutoff():
    paid = invoice(id="paid", sent_date=date(2026, 6, 1), payments=(pay("1000.00", date(2026, 6, 20)),))
    late = invoice(id="late", sent_date=date(2026, 7, 1), payments=(pay("1000.00", AS_OF + timedelta(days=3)),))
    result = trend([paid, late], AS_OF)
    points = {p.day: p for p in result.points}

    assert result.invoice_count == 2
    assert points[date(2026, 6, 19)].outstanding == Decimal("1000.00")
    assert points[AS_OF].outstanding == Decimal("1000.00")
    assert sum(m.received for m in result.movements) == Decimal("1000.00")


def test_trend_months_reconcile_and_skip_unsent_and_unusable_invoices():
    invoices = [
        invoice(id="a", sent_date=date(2026, 6, 10), payments=(pay("300.00", date(2026, 7, 5)),)),
        invoice(id="draft", status="DRAFT", sent_date=None),
        invoice(id="early", sent_date=date(2026, 7, 1), payments=(pay("100.00", date(2026, 6, 30)),)),
    ]
    result = trend(invoices, AS_OF)

    assert result.invoice_count == 1
    assert [(m.start, m.opening, m.added, m.received, m.closing) for m in result.movements] == [
        (date(2026, 6, 1), Decimal("0.00"), Decimal("1000.00"), Decimal("0.00"), Decimal("1000.00")),
        (date(2026, 7, 1), Decimal("1000.00"), Decimal("0.00"), Decimal("300.00"), Decimal("700.00")),
    ]
    assert result.limitations == ("1 invoice(s) left out: a missing amount or date, or a payment recorded before "
                                  "the invoice was sent.",)


def test_trend_ignores_payments_after_the_cutoff_even_without_an_amount():
    inv = invoice(sent_date=date(2026, 7, 1), payments=(Payment("p1", AS_OF + timedelta(days=5), None),))
    result = trend([inv], AS_OF)

    assert (result.invoice_count, result.limitations) == (1, ())
    assert result.points[-1].outstanding == Decimal("1000.00")


def test_trend_reports_undated_payments_and_missing_send_dates():
    undated_payment = invoice(id="a", sent_date=date(2026, 7, 1), payments=(Payment("p1", None, Decimal("100.00")),))
    no_send_date = invoice(id="b", sent_date=None)
    kept = invoice(id="c", sent_date=date(2026, 7, 1))
    result = trend([undated_payment, no_send_date, kept], AS_OF)

    assert result.invoice_count == 1
    assert result.limitations == (
        "1 SENT invoice(s) left out: no send date.",
        "1 invoice(s) left out: a missing amount or date, or a payment recorded before the invoice was sent.",
    )


def test_trend_flags_an_overpayment_even_after_it_is_reversed():
    payments = (pay("1500.00", date(2026, 7, 5), "over"), pay("-500.00", date(2026, 7, 10), "reversal"))
    result = trend([invoice(sent_date=date(2026, 7, 1), payments=payments)], AS_OF)
    points = {p.day: p for p in result.points}

    assert points[date(2026, 7, 5)].outstanding == Decimal("-500.00")
    assert points[AS_OF].outstanding == Decimal("0.00")
    assert result.limitations == ("Includes invoices whose recorded payments exceeded the invoice total on some "
                                  "days, such as an overpayment later reversed.",)
