from datetime import date
from decimal import Decimal

import psycopg
import pytest
from fastapi.testclient import TestClient
from pydantic import SecretStr

from app.config import Settings
from app.main import create_app


def test_health_reports_ready_source_snapshot(client):
    response = client.get("/api/health")

    assert response.status_code == 200
    body = response.json()
    assert body["status"] == "ok"
    assert body["database"] == {"ready": True, "dataset_as_of": "2026-07-28", "error": None}
    assert body["model"] == {"assessment_available": False, "model": None}


def test_health_reports_model_configuration_without_exposing_key(settings):
    configured = settings.model_copy(update={"openai_api_key": SecretStr("sk-test-not-real"), "openai_model": "test-model"})
    with TestClient(create_app(configured)) as client:
        response = client.get("/api/health")

    assert response.json()["model"] == {"assessment_available": True, "model": "test-model"}
    assert "sk-test-not-real" not in response.text


def test_health_unavailable_when_database_down(settings):
    unreachable = settings.model_copy(update={"database_url": "postgresql://nobody:x@127.0.0.1:9/harborstone?connect_timeout=1"})
    with TestClient(create_app(unreachable)) as client:
        response = client.get("/api/health")

    assert response.status_code == 503
    assert response.json()["database"] == {"ready": False, "dataset_as_of": None, "error": "database_unavailable"}
    assert "nobody" not in response.text


@pytest.mark.parametrize(
    "statement",
    [
        "INSERT INTO source_company.dataset_metadata (key, value) VALUES ('test', 'x')",
        "UPDATE source_company.ar_invoices SET status = status",
        "DELETE FROM source_company.ar_payments",
        "CREATE TABLE app.test_tmp (x int)",
        "UPDATE app.investigations SET input_hash = 'x'",
        "DELETE FROM app.investigations",
    ],
)
def test_runtime_role_cannot_write_source_or_protected_app_data(settings: Settings, statement: str):
    with psycopg.connect(settings.database_url) as conn:
        with pytest.raises(psycopg.errors.InsufficientPrivilege):
            conn.execute(statement)
        conn.rollback()


def test_runtime_role_can_record_an_investigation_run(settings: Settings):
    with psycopg.connect(settings.database_url) as conn:
        try:
            (investigation_id,) = conn.execute(
                "INSERT INTO app.investigations"
                " (invoice_id, snapshot_as_of, input_hash, analysis_version, model, status, input_json)"
                " VALUES ('test', '2026-07-28', 'h', 'v', 'm', 'running', '{}') RETURNING id"
            ).fetchone()
            conn.execute(
                "UPDATE app.investigations SET status = 'completed', output_json = '{}', finished_at = now() WHERE id = %s",
                (investigation_id,),
            )
            row = conn.execute("SELECT status FROM app.investigations WHERE id = %s", (investigation_id,)).fetchone()
            assert row == ("completed",)
        finally:
            conn.rollback()


def test_duplicate_running_investigation_is_rejected(settings: Settings):
    insert = (
        "INSERT INTO app.investigations"
        " (invoice_id, snapshot_as_of, input_hash, analysis_version, model, status, input_json)"
        " VALUES ('test', '2026-07-28', 'same-hash', 'v', 'm', 'running', '{}')"
    )
    with psycopg.connect(settings.database_url) as conn:
        try:
            conn.execute(insert)
            with pytest.raises(psycopg.errors.UniqueViolation):
                conn.execute(insert)
        finally:
            conn.rollback()


def _invoices_by_number(client) -> dict:
    return {i["invoice_number"]: i for i in client.get("/api/receivables").json()["invoices"]}


def test_receivables_summary_reconciles_with_source(client):
    body = client.get("/api/receivables").json()
    summary = body["summary"]

    assert body["as_of"] == "2026-07-28"
    assert len(body["invoices"]) == 21
    assert summary["outstanding"] == {"amount": "1108464.00", "count": 9}
    assert summary["overdue"] == {"amount": "719004.00", "count": 5}
    assert summary["not_yet_due"] == {"amount": "389460.00", "count": 4}
    assert summary["unsent_billing"] == {"amount": "311800.00", "count": 4}
    assert summary["sync_failed"] == {"amount": "57300.00", "count": 1}
    assert summary["limitations"] == []


def test_category_partition_and_order(client):
    invoices = client.get("/api/receivables").json()["invoices"]
    by_category = {}
    for i in invoices:
        by_category.setdefault(i["category"], []).append(i["invoice_number"])

    assert {k: len(v) for k, v in by_category.items()} == {"verify": 2, "collect": 5, "billing": 4, "monitor": 4, "settled": 6}
    assert list(by_category) == ["verify", "collect", "billing", "monitor", "settled"]
    assert by_category["verify"] == ["INV-2026-0455", "INV-2026-0553"]
    assert by_category["collect"] == ["INV-2026-0515", "INV-2026-0502", "INV-2026-0526", "INV-2026-0538", "INV-2026-0549"]
    assert by_category["billing"][0] == "INV-2026-0596"


@pytest.mark.parametrize(
    "number,category,remaining,overdue_days,payment_position",
    [
        ("INV-2026-0515", "collect", "178100.00", 26, "no_receipts"),
        ("INV-2026-0502", "collect", "86600.00", 19, "partially_paid"),
        ("INV-2026-0526", "collect", "173500.00", 18, "no_receipts"),
        ("INV-2026-0538", "collect", "246300.00", 14, "no_receipts"),
        ("INV-2026-0549", "collect", "34504.00", 2, "partially_paid"),
        ("INV-2026-0596", "billing", "116700.00", None, "no_receipts"),
        ("INV-2026-0455", "verify", "0.00", 0, "paid"),
        ("INV-2026-0553", "verify", "57300.00", None, "no_receipts"),
        ("INV-2026-0571", "monitor", "67560.00", 0, "partially_paid"),
        ("INV-2026-0491", "settled", "0.00", 0, "paid"),
    ],
)
def test_reference_invoices(client, number, category, remaining, overdue_days, payment_position):
    invoice = _invoices_by_number(client)[number]
    assert (invoice["category"], invoice["remaining_balance"], invoice["overdue_days"], invoice["payment_position"]) == (
        category, remaining, overdue_days, payment_position
    )


def test_invoice_detail_shows_context_and_evidence(client):
    invoice = _invoices_by_number(client)["INV-2026-0502"]
    detail = client.get(f"/api/invoices/{invoice['id']}").json()

    assert detail["position"]["paid_to_date"] == "129900.00"
    assert [p["amount"] for p in detail["payments"]] == ["129900.00"]
    assert detail["notes"][0]["note_date"] == "2026-07-24"
    assert detail["job"]["project_status"] == "IN_PROGRESS"
    assert {a["capacity"] for a in detail["assignments"]} == {"Primary AE", "Primary Ops Manager"}
    assert detail["customer"]["contacts"][0]["role"] == "invoice_contact"
    assert detail["calculation"]["source_refs"] == [detail["ref"], detail["payments"][0]["ref"]]


def test_missing_ops_manager_is_shown_as_warning(client):
    invoice = _invoices_by_number(client)["INV-2026-0515"]
    detail = client.get(f"/api/invoices/{invoice['id']}").json()
    assert detail["position"]["category"] == "collect"
    assert {"code": "missing_assignment", "message": "No Primary Ops Manager assignment"} in detail["warnings"]


def test_unknown_invoice_returns_404(client):
    response = client.get("/api/invoices/does-not-exist")
    assert response.status_code == 404
    assert response.json()["detail"]["code"] == "invoice_not_found"


def test_source_errors_return_503_without_details(settings):
    unreachable = settings.model_copy(update={"database_url": "postgresql://nobody:x@127.0.0.1:9/harborstone?connect_timeout=1"})
    with TestClient(create_app(unreachable)) as client:
        response = client.get("/api/receivables")

    assert response.status_code == 503
    assert response.json() == {"detail": {"code": "database_unavailable", "message": "Source data is unavailable."}}


def test_evidence_separates_counted_and_excluded_payments(client, monkeypatch):
    from app import routes

    fetch_payments = routes.source_queries.fetch_payments

    async def with_future_payment(conn, invoice_id=None):
        rows = await fetch_payments(conn, invoice_id)
        future = {"id": "future-payment", "invoice_id": invoice_id, "payment_date": date(2026, 8, 1),
                  "amount": Decimal("1000.00"), "payment_method": None, "reference_number": None}
        return [*rows, future]

    monkeypatch.setattr(routes.source_queries, "fetch_payments", with_future_payment)
    invoice = _invoices_by_number(client)["INV-2026-0502"]
    detail = client.get(f"/api/invoices/{invoice['id']}").json()

    assert detail["position"]["remaining_balance"] == "86600.00"
    assert [p["counted"] for p in detail["payments"]] == [True, False]
    assert detail["calculation"]["source_refs"] == [detail["ref"], detail["payments"][0]["ref"]]
    assert detail["calculation"]["excluded_refs"] == ["source_company.ar_payments:future-payment"]
