from pathlib import Path

from pydantic import SecretStr, field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict

ROOT_DIR = Path(__file__).resolve().parents[2]


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=ROOT_DIR / ".env", extra="ignore")

    database_url: str
    openai_api_key: SecretStr | None = None
    openai_model: str | None = None

    # Agent run limits
    agent_max_turns: int = 4
    agent_max_tool_attempts: int = 6
    agent_timeout_seconds: float = 60.0

    @field_validator("openai_api_key", "openai_model", mode="before")
    @classmethod
    def _blank_is_unset(cls, value: object) -> object:
        return None if isinstance(value, str) and not value.strip() else value

    @property
    def assessment_available(self) -> bool:
        return self.openai_api_key is not None and self.openai_model is not None
