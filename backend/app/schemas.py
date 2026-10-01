from datetime import date
from typing import Literal

from pydantic import BaseModel


class DatabaseStatus(BaseModel):
    ready: bool
    dataset_as_of: date | None = None
    error: Literal["database_unavailable", "source_not_restored", "app_schema_missing", "permission_denied"] | None = None


class ModelStatus(BaseModel):
    # Key and model are set. Doesn't check the provider.
    assessment_available: bool
    model: str | None = None


class Health(BaseModel):
    status: Literal["ok", "unavailable"]
    database: DatabaseStatus
    model: ModelStatus
