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
        "UPDATE app.drafts SET original_body = 'x'",
        "DELETE FROM app.activity_events",
    ],
)
def test_runtime_role_cannot_write_source_or_protected_app_data(settings: Settings, statement: str):
    with psycopg.connect(settings.database_url) as conn:
        with pytest.raises(psycopg.errors.InsufficientPrivilege):
            conn.execute(statement)
        conn.rollback()


def test_runtime_role_can_write_app_workflow_rows(settings: Settings):
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
            (draft_id,) = conn.execute(
                "INSERT INTO app.drafts (investigation_id, audience, original_subject, original_body, subject, body)"
                " VALUES (%s, 'internal', 's', 'b', 's', 'b') RETURNING id",
                (investigation_id,),
            ).fetchone()
            conn.execute("UPDATE app.drafts SET subject = 'edited', updated_at = now() WHERE id = %s", (draft_id,))
            conn.execute(
                "INSERT INTO app.activity_events (investigation_id, draft_id, kind) VALUES (%s, %s, 'draft_saved')",
                (investigation_id, draft_id),
            )
            row = conn.execute("SELECT original_subject, subject FROM app.drafts WHERE id = %s", (draft_id,)).fetchone()
            assert row == ("s", "edited")
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
