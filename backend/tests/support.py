import psycopg
from fastapi.testclient import TestClient
from pydantic import SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict

from app.agent import AgentRun
from app.config import ROOT_DIR, Settings
from app.main import create_app
from app.schemas import AssessmentOutput

TEST_MODEL = "test-model"


class AdminSettings(BaseSettings):
    model_config = SettingsConfigDict(env_file=ROOT_DIR / ".env", extra="ignore")
    postgres_user: str
    postgres_password: str
    postgres_db: str
    postgres_host_port: int = 5433


def delete_test_rows():
    # The runtime role can't delete, so clean up with the setup role and only touch rows these tests created.
    admin = AdminSettings()
    with psycopg.connect(host="127.0.0.1", port=admin.postgres_host_port, user=admin.postgres_user,
                         password=admin.postgres_password, dbname=admin.postgres_db) as conn:
        conn.execute("DELETE FROM app.investigations WHERE model = %s", (TEST_MODEL,))


class FakeAssessor:
    """Stands in for the model: returns a fixed answer and records how often it was called."""

    def __init__(self, output: dict | Exception, exposed=("facts", "customer_context", "project_context")):
        self.output = output
        self.exposed = list(exposed)
        self.calls = 0

    async def __call__(self, bundle, prompt_data, settings, check=None, tool_calls=None):
        self.calls += 1
        if isinstance(self.output, Exception):
            raise self.output
        if tool_calls is not None:
            tool_calls.append({"tool": "get_customer_context", "result": bundle["customer_context"], "duration_ms": 0})
        return AgentRun(output=AssessmentOutput(**self.output), exposed_sections=self.exposed,
                        usage={"requests": 2, "input_tokens": 100, "output_tokens": 50, "total_tokens": 150})


def make_client(assessor, model: str | None = TEST_MODEL) -> TestClient:
    settings = Settings(openai_api_key=SecretStr("test-key") if model else None, openai_model=model)
    unexpected = FakeAssessor(AssertionError("this test should not reach the model"))
    return TestClient(create_app(settings, assessor=assessor or unexpected))


def invoice(client, number: str) -> dict:
    invoices = client.get("/api/receivables").json()["invoices"]
    summary = next(i for i in invoices if i["invoice_number"] == number)
    return client.get(f"/api/invoices/{summary['id']}").json()


def published_by_test(invoice_id: str) -> bool:
    # The dev database may hold real assessments; only results from these tests count.
    with psycopg.connect(Settings().database_url) as conn:
        return conn.execute(
            "SELECT EXISTS (SELECT 1 FROM app.investigations WHERE invoice_id = %s AND model = %s"
            " AND status = 'completed')",
            (invoice_id, TEST_MODEL),
        ).fetchone()[0]


def stored_run(investigation_id: str) -> dict:
    """Diagnostics kept in the database but not returned by the API."""
    with psycopg.connect(Settings().database_url) as conn:
        trace, usage, error = conn.execute(
            "SELECT trace_json, usage_json, error_message FROM app.investigations WHERE id = %s", (investigation_id,)
        ).fetchone()
    return {"trace": trace, "usage": usage, "error": error}


def output(action: str, refs: list[str], email: dict | None = None) -> dict:
    return {
        "action": action,
        "summary": "Summary.",
        "findings": [{"text": "Finding.", "evidence_refs": refs}],
        "warnings": [],
        "recommendation": {"text": "Recommendation.", "evidence_refs": refs},
        "email": email,
    }


def assess(client, detail: dict, refresh: bool = False):
    return client.post(f"/api/invoices/{detail['position']['id']}/investigations", json={"refresh": refresh})
