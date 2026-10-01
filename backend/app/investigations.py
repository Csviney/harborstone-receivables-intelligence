import asyncio
import hashlib
import json
import logging
import re
import time
from datetime import date
from decimal import Decimal

import psycopg
from psycopg_pool import AsyncConnectionPool, PoolTimeout

from . import app_queries
from .agent import AgentRun, AssessmentFailed
from .config import ANALYSIS_VERSION, Settings
from .invoices import load_invoice_detail
from .receivables import ALLOWED_ACTIONS
from .schemas import (
    Assessment,
    AssessmentOutput,
    Investigation,
    InvestigationResult,
    InvestigationState,
    InvoiceDetail,
    Recipient,
    SuggestedEmail,
)

log = logging.getLogger(__name__)

PLACEHOLDER = re.compile(r"\{\{\s*([a-z_]+)\s*\}\}")
LATER_PLACEHOLDERS = {"project_name": "get_project_context", "contact_first_name": "get_customer_context"}
STANDALONE_BALANCE = re.compile(r"^[ \t]*\{\{\s*balance_statement\s*\}\}[ \t]*$", re.MULTILINE)
# "one", "first", and "second" are left out; they appear in ordinary sentences.
NUMBER_WORDS = re.compile(
    r"\b(two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|(thir|four|fif|six|seven|eigh|nine)teen(th)?"
    r"|(twen|thir|for|fif|six|seven|eigh|nine)(ty|tieth)|(hundred|thousand|million|billion)(th)?"
    r"|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth|eleventh|twelfth)\b",
    re.IGNORECASE,
)
RELATIVE_TIME = re.compile(
    r"\b(today|tonight|yesterday|tomorrow|right now|as of now"
    r"|(this|last|next) (week|month|year|morning|afternoon|evening))\b",
    re.IGNORECASE,
)

# Shown to users; the technical detail stays in the database for troubleshooting.
USER_MESSAGES = {
    "provider_error": "The assessment service isn't available right now. Try again shortly.",
    "timeout": "The assessment took too long. Try again.",
    "cancelled": "The assessment was stopped before it finished. Try again.",
    "interrupted": "The assessment was interrupted. Try again.",
    "save_failed": "The assessment couldn't be saved. Try again.",
}
UNRELIABLE = "The assessment couldn't produce a reliable result. Try again."


class InvestigationError(Exception):
    def __init__(self, status: int, code: str, message: str, investigation_id: str | None = None):
        super().__init__(message)
        self.status = status
        self.code = code
        self.message = message
        self.investigation_id = investigation_id


class InvalidOutput(Exception):
    pass


def build_bundle(detail: InvoiceDetail) -> dict:
    """Everything the assessment may see for one invoice. Facts are always sent; the rest only via tools."""
    d = detail.model_dump(mode="json", exclude={"investigation"})
    p = d["position"]
    contacts = (d["customer"] or {}).get("contacts", [])
    job = d["job"]
    allowed = [
        action for action in ALLOWED_ACTIONS[p["category"]]
        # A customer follow-up needs a contact with an email address.
        if action != "customer_followup" or any(c["email"] for c in contacts)
    ]
    return {
        "facts": {
            "as_of": d["as_of"],
            "invoice": {
                "ref": d["ref"],
                "invoice_date": d["invoice_date"],
                "invoice_notes": d["invoice_notes"],
                **{k: p[k] for k in ("invoice_number", "status", "customer_name", "total", "due_date", "sent_date")},
            },
            "position": {
                **{k: p[k] for k in ("paid_to_date", "remaining_balance", "payment_position", "overdue_days",
                                     "category", "reason")},
                "latest_payment_date": d["latest_payment_date"],
                "calculation": {
                    **d["calculation"],
                    "as_of": d["as_of"],
                    "invoice_total": p["total"],
                    "paid_to_date": p["paid_to_date"],
                    "remaining_balance": p["remaining_balance"],
                },
            },
            "payments": d["payments"],
            "invoice_notes": d["notes"],
            "warnings": d["warnings"],
            "allowed_actions": allowed,
        },
        "project_context": {
            "job": d["job"],
            "project": job and job["project_ref"] and {
                "ref": job["project_ref"],
                "project_number": job["project_number"],
                "status": job["project_status"],
                "completed_on": job["completed_on"],
            },
            "assignments": d["assignments"],
            "project_notes": d["project_notes"],
        },
        "customer_context": {"customer": d["customer"]},
    }


def input_hash(bundle: dict, settings: Settings) -> str:
    identity = {"bundle": bundle, "analysis_version": ANALYSIS_VERSION, "model": settings.openai_model}
    canonical = json.dumps(identity, sort_keys=True, separators=(",", ":"))
    return hashlib.sha256(canonical.encode()).hexdigest()


def collect_refs(value) -> set[str]:
    if isinstance(value, dict):
        refs = set()
        for key, item in value.items():
            if (key == "ref" or key.endswith("_ref")) and isinstance(item, str):
                refs.add(item)
            elif key.endswith("_refs") and isinstance(item, list):
                refs.update(r for r in item if isinstance(r, str))
            else:
                refs |= collect_refs(item)
        return refs
    if isinstance(value, list):
        return set().union(*(collect_refs(item) for item in value)) if value else set()
    return set()


def find_record(value, ref: str) -> dict | None:
    if isinstance(value, dict):
        if value.get("ref") == ref:
            return value
        value = list(value.values())
    if isinstance(value, list):
        for item in value:
            found = find_record(item, ref)
            if found:
                return found
    return None


def balance_statement(facts: dict) -> str | None:
    """The one sentence of financial wording in any email, written from calculated values."""
    position, invoice = facts["position"], facts["invoice"]
    as_of, number = _day(facts["as_of"]), invoice["invoice_number"]
    if position["category"] == "billing":
        state = "an unsent draft" if invoice["status"] == "DRAFT" else "approved but not yet sent"
        return f"As of {as_of}, invoice {number} for {_money(invoice['total'])} is {state}."
    remaining = _money(position["remaining_balance"])
    if remaining is None:
        return None
    paid = position["paid_to_date"]
    if any(p["counted"] for p in facts["payments"]):
        # Reversals can leave a zero or negative net, which is not the same as no payments.
        if Decimal(paid) > 0:
            text = f"{_money(paid)} received toward invoice {number}"
        else:
            text = f"net recorded payments of {_money(paid)} toward invoice {number}"
        if position["latest_payment_date"]:
            text += f" (most recently on {_day(position['latest_payment_date'])})"
        text += f" and {remaining} still open"
    else:
        text = f"{remaining} open on invoice {number} with no payments recorded"
    days = position["overdue_days"]
    if position["category"] == "collect" and days:
        text += f", {days} day{'s' if days != 1 else ''} past the {_day(invoice['due_date'])} due date"
    return f"As of {as_of}, our records show {text}."


def placeholder_values(bundle: dict, exposed: set[str], recipient_ref: str | None = None) -> dict[str, str]:
    facts = bundle["facts"]
    invoice = facts["invoice"]
    values = {
        "invoice_number": invoice["invoice_number"],
        "customer_name": invoice["customer_name"],
        "invoice_date": _day(invoice["invoice_date"]),
        "sent_date": _day(invoice["sent_date"]),
        "due_date": _day(invoice["due_date"]),
        "as_of_date": _day(facts["as_of"]),
        "balance_statement": balance_statement(facts),
    }
    if "project_context" in exposed and bundle["project_context"]["job"]:
        values["project_name"] = bundle["project_context"]["job"]["site_name"]
    if "customer_context" in exposed:
        values["contact_first_name"] = (_contact(bundle, recipient_ref) or {}).get("first_name")
    return {name: value for name, value in values.items() if value}


def validate(output: AssessmentOutput, bundle: dict, exposed_sections: list[str]) -> None:
    """Check the model's answer against what this invoice allows and what the model actually saw."""
    found = problems(output, bundle, exposed_sections)
    if found:
        raise InvalidOutput("\n".join(found))


def problems(output: AssessmentOutput, bundle: dict, exposed_sections: list[str]) -> list[str]:
    """Every rule the answer breaks, so a correction can fix them all at once."""
    found = []
    if output.action not in bundle["facts"]["allowed_actions"]:
        found.append(f"Action {output.action} is not allowed for this invoice.")
    if any(not item.evidence_refs for item in (output.recommendation, *output.findings)):
        found.append("Every finding and the recommendation must cite evidence.")
    seen_refs = set().union(*(collect_refs(bundle[s]) for s in set(exposed_sections)))
    cited = [r for item in (output.recommendation, *output.findings, *output.warnings) for r in item.evidence_refs]
    unseen = [r for r in cited if r not in seen_refs]
    if unseen:
        found.append(f"The assessment cited records it was not given: {_quoted(unseen)}. Cite only refs from the input.")
    prose = [("summary", output.summary), ("recommendation", output.recommendation.text),
             *(("findings", f.text) for f in output.findings), *(("cautions", w.text) for w in output.warnings)]
    with_placeholders = [field for field, text in prose if "{{" in text or "}}" in text]
    if with_placeholders:
        found.append(f"Placeholders appear in the {_quoted(with_placeholders)}. Placeholders belong only in "
                     "email templates; write these as plain prose.")
    if output.email:
        found.extend(email_problems(output, bundle, exposed_sections))
    return found


def email_problems(output: AssessmentOutput, bundle: dict, exposed_sections: list[str]) -> list[str]:
    email, exposed, found = output.email, set(exposed_sections), []
    if output.action == "no_outreach":
        return ["A no-outreach assessment cannot suggest an email."]
    audience = "customer" if output.action == "customer_followup" else "internal"
    if email.audience != audience:
        found.append(f"A {output.action} email must be addressed to the {audience} audience.")
    if audience == "customer":
        contact = _contact(bundle, email.recipient_ref) if "customer_context" in exposed else None
        if contact is None:
            found.append("A customer email must go to a contact from the customer context.")
        elif not contact["email"]:
            found.append("A customer email needs a recipient with an email address.")
    elif email.recipient_ref is not None:
        found.append("Internal emails cannot name a recipient; the source has no team mailboxes.")
    if PLACEHOLDER.findall(email.body_template).count("balance_statement") != 1:
        found.append("An email must include {{balance_statement}} exactly once.")
    elif not STANDALONE_BALANCE.search(email.body_template):
        found.append("Put {{balance_statement}} on its own line; it is a complete sentence.")
    values = placeholder_values(bundle, exposed, email.recipient_ref)
    found.extend(wording_problems(email.subject_template, values, "email subject"))
    found.extend(wording_problems(email.body_template, values, "email body"))
    return found


def render_email(output: AssessmentOutput, bundle: dict, exposed_sections: list[str]) -> SuggestedEmail:
    """Fill a validated email template with source values."""
    found = email_problems(output, bundle, exposed_sections)
    if found:
        raise InvalidOutput("\n".join(found))
    email = output.email
    contact = _contact(bundle, email.recipient_ref)
    values = placeholder_values(bundle, set(exposed_sections), email.recipient_ref)
    return SuggestedEmail(
        audience=email.audience,
        recipient=contact and Recipient(name=contact["name"], email=contact["email"]),
        subject=render(email.subject_template, values),
        body=render(email.body_template, values),
    )


def wording_problems(template: str, values: dict[str, str], part: str = "email") -> list[str]:
    """Numbers, dates, and names in an email must come from placeholders, never typed by the model."""
    found = []
    unknown = [name for name in PLACEHOLDER.findall(template) if name not in values]
    if unknown:
        found.append(f"The {part} uses unavailable placeholders: {_quoted(unknown)}.")
    literal = PLACEHOLDER.sub("", template)
    if "{" in literal or "}" in literal:
        found.append(f"The {part} has a malformed placeholder.")
    if numbers := re.findall(r"\S*\d\S*", literal):
        found.append(f"The {part} contains numbers that are not placeholders: {_quoted(numbers)}. "
                     "Use a placeholder such as {{invoice_number}} or {{due_date}}, or leave it out.")
    if words := [m.group(0) for m in NUMBER_WORDS.finditer(literal)]:
        found.append(f"The {part} spells out numbers: {_quoted(words)}. Use a placeholder or leave it out.")
    if dates := [m.group(0) for m in RELATIVE_TIME.finditer(literal)]:
        found.append(f"The {part} uses relative dates: {_quoted(dates)}. Use {{{{as_of_date}}}} instead.")
    return found


def render(template: str, values: dict[str, str]) -> str:
    found = wording_problems(template, values)
    if found:
        raise InvalidOutput("\n".join(found))
    return PLACEHOLDER.sub(lambda m: values[m.group(1)], template)


async def investigate(
    pool: AsyncConnectionPool, settings: Settings, assessor, invoice_id: str, refresh: bool
) -> InvestigationResult:
    async with pool.connection() as conn:
        detail = await load_invoice_detail(conn, invoice_id)
        if detail is None:
            raise InvestigationError(404, "invoice_not_found", "Invoice not found.")
        if detail.position.category not in ALLOWED_ACTIONS:
            raise InvestigationError(422, "assessment_not_needed",
                                     "Paid and not-yet-due invoices don't need an assessment.")
        bundle = build_bundle(detail)
        current_hash = input_hash(bundle, settings)

        if not refresh:
            saved = await app_queries.latest_investigation(conn, invoice_id, status="completed", input_hash=current_hash)
            if saved:
                return InvestigationResult(investigation=_view(saved), reused=True)

        if not settings.assessment_available:
            raise InvestigationError(503, "model_unavailable", "Invoice assessment is not configured.")
        try:
            investigation_id = await app_queries.insert_running(
                conn, invoice_id=invoice_id, snapshot_as_of=detail.as_of, input_hash=current_hash,
                analysis_version=ANALYSIS_VERSION, model=settings.openai_model, input_json=bundle,
            )
        except psycopg.errors.UniqueViolation:
            raise InvestigationError(409, "already_running", "An assessment for this invoice is already running.")
    # The running row is committed and the connection released before the model call.

    started = time.monotonic()
    run: AgentRun | None = None
    tool_calls: list[dict] = []
    try:
        prompt_data = {
            "placeholders": placeholder_values(bundle, {"facts"}),
            "later_placeholders": {name: f"after {tool}" for name, tool in LATER_PLACEHOLDERS.items()},
        }
        run = await assessor(bundle, prompt_data, settings, tool_calls=tool_calls,
                             check=lambda output, exposed: _problem(output, bundle, exposed))
        validate(run.output, bundle, run.exposed_sections)
        trace = {"exposed_sections": run.exposed_sections, "tool_calls": tool_calls,
                 "corrections": run.corrections, "duration_ms": _elapsed(started)}
        async with pool.connection() as conn:
            await app_queries.complete(conn, investigation_id, output=run.output.model_dump(mode="json"),
                                       trace=trace, usage=run.usage)
            saved = await app_queries.get_investigation(conn, investigation_id)
    except AssessmentFailed as exc:
        await _record_failure(pool, investigation_id, exc.code, exc.message, tool_calls, None, started)
        raise InvestigationError(504 if exc.code == "timeout" else 502, exc.code, _user_message(exc.code),
                                 investigation_id)
    except InvalidOutput as exc:
        # Keep the rejected answer for review; it is never shown as a usable assessment.
        await _record_failure(pool, investigation_id, "invalid_output", str(exc), tool_calls, run.usage, started,
                              output=run.output.model_dump(mode="json"), corrections=run.corrections)
        raise InvestigationError(502, "invalid_output", UNRELIABLE, investigation_id)
    except BaseException as exc:
        # Cancellation, a failed save, or a bug: don't leave the row running, or retries get 409 until restart.
        if isinstance(exc, asyncio.CancelledError):
            code, message = "cancelled", "The assessment was cancelled before it finished."
        elif isinstance(exc, (psycopg.Error, PoolTimeout)):
            code, message = "save_failed", "The assessment could not be saved."
        else:
            code, message = "unexpected_error", "The assessment failed unexpectedly."
        await asyncio.shield(_record_failure(pool, investigation_id, code, message,
                                             tool_calls, run and run.usage, started))
        raise
    return InvestigationResult(investigation=_view(saved), reused=False)


async def investigation_state(conn, detail: InvoiceDetail, settings: Settings) -> InvestigationState:
    invoice_id = detail.position.id
    applicable = detail.position.category in ALLOWED_ACTIONS
    completed = await app_queries.latest_investigation(conn, invoice_id, status="completed")
    latest = await app_queries.latest_investigation(conn, invoice_id)
    return InvestigationState(
        available=settings.assessment_available,
        applicable=applicable,
        current=bool(completed) and applicable and completed["input_hash"] == input_hash(build_bundle(detail), settings),
        assessment=completed and _view(completed),
        latest_attempt=_view(latest) if latest and latest["id"] != (completed and completed["id"]) else None,
    )


def _problem(output: AssessmentOutput, bundle: dict, exposed_sections: list[str]) -> str | None:
    try:
        validate(output, bundle, exposed_sections)
    except InvalidOutput as exc:
        return str(exc)
    return None


async def _record_failure(
    pool, investigation_id, code, message, tool_calls, usage, started, output=None, corrections=None
) -> None:
    trace = {"tool_calls": tool_calls, "corrections": corrections or [], "duration_ms": _elapsed(started)}
    try:
        async with pool.connection() as conn:
            await app_queries.fail(conn, investigation_id, code=code, message=message, trace=trace, usage=usage,
                                   output=output)
    except (psycopg.Error, PoolTimeout):
        log.exception("Could not record failed assessment %s; it will be marked interrupted on restart",
                      investigation_id)


def _view(row: dict) -> Investigation:
    # Results saved before suggested emails existed have no email field.
    output = row["output_json"] and AssessmentOutput(**{"email": None, **row["output_json"]})
    cited = {r for item in (output.recommendation, *output.findings, *output.warnings) for r in item.evidence_refs} \
        if output else set()
    email = None
    if output and output.email and row["status"] == "completed":
        # Rendered from the evidence saved with this run, so it matches what the assessment saw.
        exposed = (row["trace_json"] or {}).get("exposed_sections", ["facts"])
        try:
            email = render_email(output, row["input_json"], exposed)
        except InvalidOutput:
            log.warning("Saved email for investigation %s no longer passes validation", row["id"])
    return Investigation(
        id=row["id"],
        status=row["status"],
        started_at=row["started_at"],
        finished_at=row["finished_at"],
        output=output and Assessment(**output.model_dump(exclude={"email"})),
        email=email,
        cited_records={ref: record for ref in sorted(cited) if (record := find_record(row["input_json"], ref))},
        error_code=row["error_code"],
        error_message=row["error_code"] and _user_message(row["error_code"]),
    )


def _user_message(code: str) -> str:
    return USER_MESSAGES.get(code, UNRELIABLE)


def _quoted(items: list[str]) -> str:
    return ", ".join(f'"{item}"' for item in dict.fromkeys(items))


def _contact(bundle: dict, ref: str | None) -> dict | None:
    contacts = (bundle["customer_context"]["customer"] or {}).get("contacts", [])
    return next((c for c in contacts if c["ref"] == ref), None)


def _money(value: str | None) -> str | None:
    if value is None:
        return None
    amount = Decimal(value)
    return f"-${-amount:,.2f}" if amount < 0 else f"${amount:,.2f}"


def _day(value: str | None) -> str | None:
    if value is None:
        return None
    d = date.fromisoformat(value)
    return f"{d:%B} {d.day}, {d.year}"


def _elapsed(started: float) -> int:
    return round((time.monotonic() - started) * 1000)
