import pytest
from fastapi.testclient import TestClient

from app.config import Settings
from app.main import create_app
from support import delete_test_rows


@pytest.fixture
def settings() -> Settings:
    # Keep tests off the OpenAI API.
    return Settings(openai_api_key=None, openai_model=None)


@pytest.fixture
def client(settings: Settings):
    with TestClient(create_app(settings)) as test_client:
        yield test_client


@pytest.fixture
def clean_rows():
    delete_test_rows()
    yield
    delete_test_rows()
