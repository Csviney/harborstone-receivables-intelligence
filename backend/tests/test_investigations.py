import asyncio
import json

import psycopg
import pytest
from agents import Model, ModelResponse, Usage as ModelUsage
from openai.types.responses import ResponseFunctionToolCall, ResponseOutputMessage, ResponseOutputText

from app import app_queries, investigations
from app.agent import AssessmentFailed, RunState, ToolLimitExceeded, _expose, run_assessment
from app.investigations import InvalidOutput, InvestigationError, build_bundle, render, validate
from app.schemas import AssessmentOutput, InvoiceDetail
from support import (
    TEST_MODEL,
    FakeAssessor,
    assess,
    invoice,
    make_client,
    output,
    published_by_test,
    stored_run,
)

pytestmark = pytest.mark.usefixtures("clean_rows")


def assert_rejected(response, reason: str):
    """Users get a plain message; the exact reason is kept with the failed run."""
    assert response.status_code == 502
    detail = response.json()["detail"]
    assert (detail["code"], detail["message"]) == ("invalid_output", investigations.UNRELIABLE)
    assert reason in stored_run(detail["investigation_id"])["error"]


def test_partial_payment_can_get_a_customer_follow_up_citing_the_payment():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0502")
        payment = detail["payments"][0]["ref"]
        client.app.state.assessor = FakeAssessor(output("customer_followup", [detail["ref"], payment]))
        response = assess(client, detail)

    assert response.status_code == 200
    body = response.json()
    assert body["reused"] is False
    assert body["investigation"]["output"]["action"] == "customer_followup"
    assert body["investigation"]["cited_records"][payment]["amount"] == "129900.00"


def test_unsent_billing_gets_internal_review_and_cannot_be_a_customer_follow_up():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0596")
        client.app.state.assessor = FakeAssessor(output("internal_billing_review", [detail["ref"]]))
        accepted = assess(client, detail)
        client.app.state.assessor = FakeAssessor(output("customer_followup", [detail["ref"]]))
        rejected = assess(client, detail, refresh=True)

    assert accepted.json()["investigation"]["output"]["action"] == "internal_billing_review"
    assert rejected.status_code == 502
    assert rejected.json()["detail"]["code"] == "invalid_output"


def test_paid_invoice_with_later_note_is_verified_internally_not_chased():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        note = detail["notes"][0]["ref"]
        client.app.state.assessor = FakeAssessor(output("internal_verification", [detail["ref"], note]))
        accepted = assess(client, detail)
        client.app.state.assessor = FakeAssessor(output("customer_followup", [note]))
        rejected = assess(client, detail, refresh=True)
        after = invoice(client, "INV-2026-0455")

    assert accepted.json()["investigation"]["output"]["action"] == "internal_verification"
    assert rejected.status_code == 502
    # The failed refresh is recorded but the earlier completed assessment is kept.
    state = after["investigation"]
    assert state["assessment"]["id"] == accepted.json()["investigation"]["id"]
    assert state["latest_attempt"]["status"] == "failed"
    assert after["position"]["category"] == "verify"


@pytest.mark.parametrize("number", ["INV-2026-0491", "INV-2026-0571"])
def test_paid_and_not_yet_due_invoices_are_not_assessed(number):
    fake = FakeAssessor(output("no_outreach", []))
    with make_client(fake) as client:
        detail = invoice(client, number)
        response = assess(client, detail)

    assert detail["investigation"]["applicable"] is False
    assert response.status_code == 422
    assert response.json()["detail"]["code"] == "assessment_not_needed"
    assert fake.calls == 0


def test_saved_assessment_is_reused_without_calling_the_model():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        fake = FakeAssessor(output("no_outreach", [detail["ref"]]))
        client.app.state.assessor = fake
        first = assess(client, detail)
        second = assess(client, detail)
        state = invoice(client, "INV-2026-0455")["investigation"]

    assert fake.calls == 1
    assert second.json()["reused"] is True
    assert second.json()["investigation"]["id"] == first.json()["investigation"]["id"]
    assert state["current"] is True


def test_changing_the_model_marks_the_saved_assessment_outdated():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        client.app.state.assessor = FakeAssessor(output("no_outreach", [detail["ref"]]))
        assess(client, detail)
    with make_client(None, model="another-model") as client:
        state = invoice(client, "INV-2026-0455")["investigation"]

    assert state["assessment"] is not None
    assert state["current"] is False


def test_refresh_creates_a_new_assessment():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0596")
        client.app.state.assessor = FakeAssessor(output("internal_billing_review", [detail["ref"]]))
        first = assess(client, detail).json()
        second = assess(client, detail, refresh=True).json()

    assert second["reused"] is False
    assert second["investigation"]["id"] != first["investigation"]["id"]


def test_duplicate_running_assessment_returns_conflict():
    statuses = []
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        invoice_id = detail["position"]["id"]
        done = FakeAssessor(output("no_outreach", [detail["ref"]]))

        async def slow_assessor(bundle, prompt_data, settings, check=None, tool_calls=None):
            try:
                await investigations.investigate(client.app.state.pool, settings, done, invoice_id, refresh=True)
            except InvestigationError as exc:
                statuses.append(exc.status)
            return await done(bundle, prompt_data, settings)

        client.app.state.assessor = slow_assessor
        response = assess(client, detail, refresh=True)

    assert response.status_code == 200
    assert statuses == [409]


@pytest.mark.parametrize(
    "error,status,code",
    [
        (AssessmentFailed("provider_error", "The model provider request failed (RateLimitError, HTTP 429)."), 502, "provider_error"),
        (AssessmentFailed("timeout", "The assessment took too long."), 504, "timeout"),
        (AssessmentFailed("turn_limit", "The assessment needed more steps than allowed."), 502, "turn_limit"),
    ],
)
def test_failures_are_recorded_and_leave_facts_available(error, status, code):
    with make_client(FakeAssessor(error)) as client:
        detail = invoice(client, "INV-2026-0502")
        response = assess(client, detail)
        after = invoice(client, "INV-2026-0502")

    assert response.status_code == status
    assert response.json()["detail"]["code"] == code
    attempt = after["investigation"]["latest_attempt"]
    assert (attempt["status"], attempt["error_code"]) == ("failed", code)
    assert not published_by_test(detail["position"]["id"])
    assert after["position"]["remaining_balance"] == "86600.00"


def test_assessment_unavailable_without_model_settings():
    with make_client(None, model=None) as client:
        detail = invoice(client, "INV-2026-0502")
        response = assess(client, detail)

    assert response.status_code == 503
    assert response.json()["detail"]["code"] == "model_unavailable"
    assert detail["investigation"]["available"] is False


@pytest.mark.parametrize(
    "case,reason",
    [
        ("unseen_ref", "cited records it was not given"),
        ("uncited_finding", "must cite evidence"),
        ("disallowed_action", "not allowed for this invoice"),
    ],
)
def test_invalid_model_output_is_rejected(case, reason):
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0502")
        contact = detail["customer"]["contacts"][0]["ref"]
        exposed = ("facts", "customer_context", "project_context")
        if case == "unseen_ref":
            exposed = ("facts",)
            result = output("internal_verification", [contact])
        elif case == "uncited_finding":
            result = {**output("internal_verification", [detail["ref"]]),
                      "findings": [{"text": "Unsupported claim.", "evidence_refs": []}]}
        else:
            result = output("internal_billing_review", [detail["ref"]])
        client.app.state.assessor = FakeAssessor(result, exposed)
        response = assess(client, detail)

    assert_rejected(response, reason)
    assert not published_by_test(detail["position"]["id"])


def test_unfinished_runs_are_marked_interrupted_on_startup(settings):
    with psycopg.connect(settings.database_url) as conn:
        conn.execute(
            "INSERT INTO app.investigations (invoice_id, snapshot_as_of, input_hash, analysis_version, model, status, input_json)"
            " VALUES ('interrupted-test', '2026-07-28', 'h', '1', %s, 'running', '{}')",
            (TEST_MODEL,),
        )
    with make_client(None):
        pass
    with psycopg.connect(settings.database_url) as conn:
        status, code = conn.execute(
            "SELECT status, error_code FROM app.investigations WHERE invoice_id = 'interrupted-test'"
        ).fetchone()

    assert (status, code) == ("failed", "interrupted")


def test_tool_calls_past_the_limit_end_the_run():
    state = RunState(bundle={"project_context": {"job": None}}, max_tool_attempts=2)
    assert _expose(state, "project_context") == {"job": None}
    assert "note" in _expose(state, "project_context")
    with pytest.raises(ToolLimitExceeded):
        _expose(state, "project_context")
    assert state.exposed_sections == ["facts", "project_context"]
    assert [c.get("rejected", False) for c in state.tool_calls] == [False, False, True]


def test_agent_gets_a_validator_for_its_one_correction():
    problems = []
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        good = output("internal_verification", [detail["ref"]])
        bad = output("customer_followup", [detail["ref"]])

        async def correcting(bundle, prompt_data, settings, check=None, tool_calls=None):
            problems.append(check(AssessmentOutput(**bad), ["facts"]))
            assert check(AssessmentOutput(**good), ["facts"]) is None
            return await FakeAssessor(good)(bundle, prompt_data, settings)

        client.app.state.assessor = correcting
        response = assess(client, detail)

    assert response.status_code == 200
    assert problems == ["Action customer_followup is not allowed for this invoice."]


def test_customer_follow_up_needs_a_contact_email():
    with make_client(None) as client:
        detail = InvoiceDetail(**invoice(client, "INV-2026-0502"))
    for contact in detail.customer.contacts:
        contact.email = None
    bundle = build_bundle(detail)

    assert "customer_followup" not in bundle["facts"]["allowed_actions"]
    with pytest.raises(InvalidOutput, match="not allowed"):
        validate(AssessmentOutput(**output("customer_followup", [detail.ref])), bundle, ["facts"])


def test_cancelled_run_is_recorded_and_does_not_block_retries(settings):
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        invoice_id = detail["position"]["id"]

        async def cancelled(bundle, prompt_data, settings, check=None, tool_calls=None):
            raise asyncio.CancelledError

        state = client.app.state
        with pytest.raises(BaseException) as raised:
            client.portal.call(investigations.investigate, state.pool, state.settings, cancelled, invoice_id, True)
        attempt = invoice(client, "INV-2026-0455")["investigation"]["latest_attempt"]
        client.app.state.assessor = FakeAssessor(output("no_outreach", [detail["ref"]]))
        retry = assess(client, detail, refresh=True)

    assert raised.type.__name__ == "CancelledError"
    assert (attempt["status"], attempt["error_code"]) == ("failed", "cancelled")
    assert retry.status_code == 200


def test_failed_save_is_recorded_and_does_not_block_retries(monkeypatch):
    async def broken_complete(*args, **kwargs):
        raise psycopg.OperationalError("connection lost")

    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        client.app.state.assessor = FakeAssessor(output("no_outreach", [detail["ref"]]))
        with monkeypatch.context() as patch:
            patch.setattr(app_queries, "complete", broken_complete)
            failed = assess(client, detail, refresh=True)
        attempt = invoice(client, "INV-2026-0455")["investigation"]["latest_attempt"]
        retry = assess(client, detail, refresh=True)

    assert failed.status_code == 503
    assert (attempt["status"], attempt["error_code"]) == ("failed", "save_failed")
    assert retry.status_code == 200


class ScriptedModel(Model):
    """Offline stand-in for the OpenAI model: replays scripted turns through the real agent loop."""

    def __init__(self, turns):
        self.turns = list(turns)
        self.inputs = []

    async def get_response(self, system_instructions, input, *args, **kwargs):
        self.inputs.append(input)
        turn = self.turns.pop(0)
        if isinstance(turn, BaseException):
            raise turn
        return ModelResponse(response_id=None,
                             usage=ModelUsage(requests=1, input_tokens=10, output_tokens=5, total_tokens=15),
                             output=turn)

    def stream_response(self, *args, **kwargs):
        raise NotImplementedError


def tool_call(name: str, index: int = 0):
    call_id = f"call_{name}_{index}"
    return ResponseFunctionToolCall(type="function_call", name=name, arguments="{}", call_id=call_id, id=call_id,
                                    status="completed")


def answer(result: dict):
    text = ResponseOutputText(type="output_text", text=json.dumps(result), annotations=[])
    return ResponseOutputMessage(id="msg", type="message", role="assistant", status="completed", content=[text])


def scripted(*turns):
    model = ScriptedModel(turns)

    async def assessor(bundle, prompt_data, settings, check=None, tool_calls=None):
        return await run_assessment(bundle, prompt_data, settings, check=check, model=model, tool_calls=tool_calls)

    return assessor, model


def test_agent_corrects_a_payment_demand_prompted_by_a_note():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        note = detail["notes"][0]["ref"]
        demand = output("customer_followup", [note])
        verify = output("internal_verification", [detail["ref"], note])
        client.app.state.assessor, model = scripted([answer(demand)], [answer(verify)])
        response = assess(client, detail)

    assert response.status_code == 200
    investigation = response.json()["investigation"]
    assert investigation["output"]["action"] == "internal_verification"
    assert stored_run(investigation["id"])["usage"]["requests"] == 2
    assert "Action customer_followup is not allowed" in json.dumps(model.inputs[1])


def test_agent_fails_when_the_correction_is_also_invalid():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        demand = output("customer_followup", [detail["ref"]])
        client.app.state.assessor, _ = scripted([answer(demand)], [answer(demand)])
        response = assess(client, detail)

    assert response.status_code == 502
    assert response.json()["detail"]["code"] == "invalid_output"


def test_correction_shares_the_turn_budget():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        demand = output("customer_followup", [detail["ref"]])
        # Three turns go to tools and a rejected answer, leaving one; the correction spends it on a tool call.
        client.app.state.assessor, _ = scripted(
            [tool_call("get_project_context")], [tool_call("get_customer_context")], [answer(demand)],
            [tool_call("get_project_context", 1)],
        )
        response = assess(client, detail)

    assert response.status_code == 502
    assert response.json()["detail"]["code"] == "turn_limit"


def test_a_batch_of_tool_calls_past_the_limit_ends_the_run():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        batch = [tool_call("get_project_context", i) for i in range(9)]
        client.app.state.assessor, _ = scripted(batch, [answer(output("no_outreach", [detail["ref"]]))])
        response = assess(client, detail)
        attempt = invoice(client, "INV-2026-0455")["investigation"]["latest_attempt"]

    assert response.status_code == 502
    assert response.json()["detail"]["code"] == "tool_limit"
    tool_calls = stored_run(attempt["id"])["trace"]["tool_calls"]
    assert len(tool_calls) == 9
    # The first call returns the section; repeats get a short note, and calls past six are refused.
    assert sum(1 for call in tool_calls if call["result"] and "note" not in call["result"]) == 1


def test_cancellation_keeps_the_lookups_that_already_ran():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        assessor, _ = scripted([tool_call("get_project_context")], asyncio.CancelledError())
        state = client.app.state
        with pytest.raises(BaseException):
            client.portal.call(investigations.investigate, state.pool, state.settings, assessor,
                               detail["position"]["id"], True)
        attempt = invoice(client, "INV-2026-0455")["investigation"]["latest_attempt"]

    assert (attempt["status"], attempt["error_code"]) == ("failed", "cancelled")
    tool_calls = stored_run(attempt["id"])["trace"]["tool_calls"]
    assert [call["tool"] for call in tool_calls] == ["get_project_context"]
    assert tool_calls[0]["result"]["job"]


def assess_citing_project_and_calculation(client, detail):
    refs = [detail["job"]["project_ref"], detail["calculation"]["ref"]]
    client.app.state.assessor = FakeAssessor(output("internal_verification", refs))
    return assess(client, detail).json()["investigation"]


def test_cited_project_and_calculation_have_saved_records():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        records = assess_citing_project_and_calculation(client, detail)["cited_records"]

    project = records[detail["job"]["project_ref"]]
    calculation = records[detail["calculation"]["ref"]]
    assert (project["project_number"], project["status"]) == (detail["job"]["project_number"], "CLOSED")
    assert (calculation["invoice_total"], calculation["paid_to_date"], calculation["remaining_balance"]) == (
        "122600.00", "122600.00", "0.00")
    assert calculation["source_refs"] == [detail["ref"], detail["payments"][0]["ref"]]


def test_citations_show_what_was_saved_after_the_source_changes(monkeypatch):
    from app import source_queries

    fetch_context = source_queries.fetch_invoice_context

    async def reopened_project(conn, invoice):
        context = await fetch_context(conn, invoice)
        context["projects"] = [{**project, "status": "IN_PROGRESS"} for project in context["projects"]]
        return context

    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0455")
        assess_citing_project_and_calculation(client, detail)
        monkeypatch.setattr(source_queries, "fetch_invoice_context", reopened_project)
        changed = invoice(client, "INV-2026-0455")

    state = changed["investigation"]
    assert changed["job"]["project_status"] == "IN_PROGRESS"
    assert state["current"] is False
    assert state["assessment"]["cited_records"][detail["job"]["project_ref"]]["status"] == "CLOSED"


def customer_email(contact_ref: str, body: str = "Hi {{contact_first_name}},\n\n{{balance_statement}}\n\nCould you let us know when the rest will be paid?") -> dict:
    return {"audience": "customer", "recipient_ref": contact_ref, "subject_template": "Invoice {{invoice_number}}",
            "body_template": body}


INTERNAL_EMAIL = {"audience": "internal", "recipient_ref": None, "subject_template": "Invoice {{invoice_number}}",
                  "body_template": "Could someone check this invoice?\n\n{{balance_statement}}"}


def test_customer_email_uses_exact_server_wording_for_payments_and_aging():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0502")
        contact = detail["customer"]["contacts"][0]
        result = output("customer_followup", [detail["ref"]], customer_email(contact["ref"]))
        client.app.state.assessor = FakeAssessor(result)
        email = assess(client, detail).json()["investigation"]["email"]
        reloaded = invoice(client, "INV-2026-0502")["investigation"]["assessment"]["email"]

    assert email["audience"] == "customer"
    assert email["recipient"] == {"name": "Victor Aldana", "email": contact["email"]}
    assert email["subject"] == "Invoice INV-2026-0502"
    assert email["body"] == (
        "Hi Victor,\n\nAs of July 28, 2026, our records show $129,900.00 received toward invoice INV-2026-0502 "
        "(most recently on June 29, 2026) and $86,600.00 still open, 19 days past the July 9, 2026 due date."
        "\n\nCould you let us know when the rest will be paid?"
    )
    assert reloaded == email


@pytest.mark.parametrize(
    "number,action,statement",
    [
        ("INV-2026-0596", "internal_billing_review",
         "As of July 28, 2026, invoice INV-2026-0596 for $116,700.00 is an unsent draft."),
        ("INV-2026-0455", "internal_verification",
         "As of July 28, 2026, our records show $122,600.00 received toward invoice INV-2026-0455 "
         "(most recently on June 16, 2026) and $0.00 still open."),
    ],
)
def test_internal_emails_carry_the_invoice_position_and_no_recipient(number, action, statement):
    with make_client(None) as client:
        detail = invoice(client, number)
        client.app.state.assessor = FakeAssessor(output(action, [detail["ref"]], INTERNAL_EMAIL))
        email = assess(client, detail).json()["investigation"]["email"]

    assert (email["audience"], email["recipient"]) == ("internal", None)
    assert email["body"] == f"Could someone check this invoice?\n\n{statement}"


def test_assessments_without_an_email_show_none():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0502")
        client.app.state.assessor = FakeAssessor(output("internal_verification", [detail["ref"]]))
        investigation = assess(client, detail).json()["investigation"]

    assert investigation["email"] is None
    assert investigation["output"]["action"] == "internal_verification"


@pytest.mark.parametrize(
    "case,reason",
    [
        ("customer_email_on_internal_action", "must be addressed to the internal audience"),
        ("internal_email_on_customer_action", "must be addressed to the customer audience"),
        ("email_on_no_outreach", "cannot suggest an email"),
        ("recipient_not_looked_up", "must go to a contact from the customer context"),
        ("internal_recipient_named", "cannot name a recipient"),
        ("made_up_amount", 'numbers that are not placeholders: "$5,000."'),
        ("spelled_number", 'spells out numbers: "nineteen"'),
        ("relative_date", 'relative dates: "today"'),
        ("unknown_placeholder", 'unavailable placeholders: "payment_link"'),
        ("no_balance_statement", "must include {{balance_statement}}"),
        ("inline_balance_statement", "on its own line"),
    ],
)
def test_ineligible_or_unsupported_emails_are_rejected(case, reason):
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0502")
        contact = detail["customer"]["contacts"][0]["ref"]
        refs, exposed = [detail["ref"]], ("facts", "customer_context", "project_context")
        bodies = {
            "made_up_amount": "{{balance_statement}}\nPlease pay $5,000.",
            "spelled_number": "{{balance_statement}}\nIt is nineteen days late.",
            "relative_date": "{{balance_statement}}\nAs of today it is still open.",
            "unknown_placeholder": "{{balance_statement}}\nSee {{payment_link}}.",
            "no_balance_statement": "Please pay the remaining balance.",
            "inline_balance_statement": "Your account shows {{balance_statement}}",
        }
        results = {
            "customer_email_on_internal_action": output("internal_verification", refs, customer_email(contact)),
            "internal_email_on_customer_action": output("customer_followup", refs, INTERNAL_EMAIL),
            "email_on_no_outreach": output("no_outreach", refs, INTERNAL_EMAIL),
            "recipient_not_looked_up": output("customer_followup", refs, customer_email(contact)),
            "internal_recipient_named": output("internal_verification", refs, {**INTERNAL_EMAIL, "recipient_ref": contact}),
        }
        if case == "recipient_not_looked_up":
            exposed = ("facts",)
        result = results.get(case) or output("customer_followup", refs, customer_email(contact, bodies[case]))
        client.app.state.assessor = FakeAssessor(result, exposed)
        response = assess(client, detail)

    assert_rejected(response, reason)
    assert not published_by_test(detail["position"]["id"])


def test_customer_email_needs_a_recipient_with_an_email_address():
    with make_client(None) as client:
        detail = InvoiceDetail(**invoice(client, "INV-2026-0502"))
    contact = detail.customer.contacts[0]
    contact.email = None
    bundle = build_bundle(detail)
    bundle["facts"]["allowed_actions"].append("customer_followup")
    result = AssessmentOutput(**output("customer_followup", [detail.ref], customer_email(contact.ref)))

    with pytest.raises(InvalidOutput, match="email address"):
        validate(result, bundle, ["facts", "customer_context"])


def test_wording_rules_allow_ordinary_words_and_reject_numbers_and_relative_dates():
    values = {"invoice_number": "INV-1"}
    assert render("This is our second note; one of us will follow up first on {{invoice_number}}.", values)
    for template in ("Pay 600 now", "It is nineteen days late", "Due as of today", "Paid this week", "{{due_date}}"):
        with pytest.raises(InvalidOutput):
            render(template, values)


def test_investigation_responses_leave_out_developer_diagnostics():
    with make_client(FakeAssessor(AssessmentFailed("provider_error", "RateLimitError, HTTP 429"))) as client:
        detail = invoice(client, "INV-2026-0502")
        failed = assess(client, detail)
        attempt = invoice(client, "INV-2026-0502")["investigation"]["latest_attempt"]
        client.app.state.assessor = FakeAssessor(output("internal_verification", [detail["ref"]]))
        investigation = assess(client, detail).json()["investigation"]

    assert not {"model", "usage", "tool_calls", "analysis_version", "trace"} & set(investigation)
    assert "RateLimitError" not in failed.text and "RateLimitError" not in attempt["error_message"]
    assert stored_run(investigation["id"])["usage"]["requests"] == 2


def collection_facts(paid: str, remaining: str, payments: list[dict]) -> dict:
    return {
        "as_of": "2026-07-28",
        "invoice": {"invoice_number": "INV-1", "status": "SENT", "total": "1000.00", "due_date": "2026-07-18"},
        "position": {"category": "collect", "paid_to_date": paid, "remaining_balance": remaining,
                     "overdue_days": 10, "latest_payment_date": "2026-07-01"},
        "payments": payments,
    }


@pytest.mark.parametrize(
    "paid,remaining,expected",
    [
        ("0.00", "1000.00", "net recorded payments of $0.00 toward invoice INV-1 (most recently on July 1, 2026) "
                            "and $1,000.00 still open"),
        ("-100.00", "1100.00", "net recorded payments of -$100.00 toward invoice INV-1 (most recently on July 1, 2026) "
                               "and $1,100.00 still open"),
    ],
)
def test_payment_reversals_are_not_described_as_no_payments(paid, remaining, expected):
    payments = [{"ref": "p1", "counted": True}, {"ref": "p2", "counted": True}]
    statement = investigations.balance_statement(collection_facts(paid, remaining, payments))

    assert expected in statement
    assert "no payments recorded" not in statement


def test_no_counted_payments_reads_as_none_recorded():
    statement = investigations.balance_statement(collection_facts("0.00", "1000.00", [{"ref": "p", "counted": False}]))
    assert "$1,000.00 open on invoice INV-1 with no payments recorded" in statement


@pytest.mark.parametrize(
    "text",
    ["Please pay next week.", "This is the fortieth day overdue.", "Paid this morning.", "The hundredth reminder.",
     "We expect it next month."],
)
def test_more_relative_dates_and_number_words_are_rejected(text):
    with pytest.raises(InvalidOutput):
        render(text, {})


# Contract tests with a fake model: they show what is accepted, rejected, and corrected, not live wording quality.

def failed_0515_output(detail: dict) -> dict:
    """Shaped on the saved INV-2026-0515 failures: placeholders in prose, a warning code cited as a ref, and an
    email that types the invoice number and a date."""
    contact = detail["customer"]["contacts"][0]["ref"]
    return {
        **output("customer_followup", [detail["ref"]]),
        "findings": [{"text": "Invoice {{invoice_number}} is 26 days past the {{due_date}} due date.",
                      "evidence_refs": [detail["ref"]]}],
        "warnings": [{"text": "No Primary Ops Manager is assigned.", "evidence_refs": ["missing_assignment"]}],
        "email": customer_email(contact, "Dear Miguel,\n\nThis is a reminder about invoice INV-2026-0515 dated June 2, "
                                         "2026.\n\n{{balance_statement}}\n\nThank you."),
    }


def test_placeholders_in_assessment_prose_are_rejected():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0515")
        result = {**output("customer_followup", [detail["ref"]]),
                  "summary": "Invoice {{invoice_number}} needs a follow-up."}
        client.app.state.assessor = FakeAssessor(result)
        response = assess(client, detail)

    assert_rejected(response, 'Placeholders appear in the "summary"')
    assert not published_by_test(detail["position"]["id"])


def test_every_problem_is_reported_together():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0515")
    bundle = build_bundle(InvoiceDetail(**detail))
    found = investigations.problems(AssessmentOutput(**failed_0515_output(detail)), bundle,
                                    ["facts", "customer_context", "project_context"])

    assert len(found) == 3
    assert 'cited records it was not given: "missing_assignment"' in found[0]
    assert 'Placeholders appear in the "findings"' in found[1]
    assert '"INV-2026-0515", "2,", "2026."' in found[2]


def test_one_correction_receives_all_problems_and_fixes_the_0515_case():
    with make_client(None) as client:
        detail = invoice(client, "INV-2026-0515")
        contact = detail["customer"]["contacts"][0]["ref"]
        fixed = {**output("customer_followup", [detail["ref"]]), "findings": [],
                 "summary": "No customer or project context changes the standard follow-up.",
                 "email": customer_email(contact)}
        client.app.state.assessor, model = scripted(
            [tool_call("get_customer_context")], [answer(failed_0515_output(detail))], [answer(fixed)],
        )
        response = assess(client, detail)

    assert response.status_code == 200
    correction = json.dumps(model.inputs[2])
    for problem in ("missing_assignment", "Placeholders appear in the", "INV-2026-0515"):
        assert problem in correction
    published = response.json()["investigation"]
    assert "{{" not in json.dumps(published["output"])
    assert published["email"]["body"].startswith("Hi Miguel,")


@pytest.mark.parametrize(
    "number,action,summary,findings",
    [
        ("INV-2026-0515", "customer_followup",
         "No customer or project context changes the standard follow-up.", []),
        ("INV-2026-0592", "internal_billing_review",
         "Review the approved invoice in accounting and confirm whether it is ready to send. The available records "
         "do not explain why it remains unsent.", []),
        ("INV-2026-0455", "internal_verification",
         "A note written after the final payment refers to an overdue balance; confirm with finance before any "
         "customer contact.", ["note"]),
    ],
)
def test_concise_assessments_are_accepted_in_each_category(number, action, summary, findings):
    with make_client(None) as client:
        detail = invoice(client, number)
        refs = {"note": detail["notes"][0]["ref"] if detail["notes"] else None}
        result = {**output(action, [detail["ref"]]), "summary": summary, "warnings": [],
                  "findings": [{"text": "The later note conflicts with the payment record.", "evidence_refs": [refs[f]]}
                               for f in findings]}
        client.app.state.assessor = FakeAssessor(result)
        published = assess(client, detail).json()["investigation"]

    assert published["output"]["summary"] == summary
    assert len(published["output"]["findings"]) == len(findings)
    assert published["output"]["warnings"] == []


def test_prompt_states_the_placeholder_boundary_and_the_no_repetition_rule():
    from app.agent import INSTRUCTIONS

    assert "placeholders belong only in the email templates" in INSTRUCTIONS
    assert "An empty list is fine." in INSTRUCTIONS
    assert "Do not repeat those:" in INSTRUCTIONS
