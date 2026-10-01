// Keep in sync with backend/app/schemas.py.

export type DatabaseStatus = {
  ready: boolean;
  dataset_as_of: string | null;
  error: "database_unavailable" | "source_not_restored" | "app_schema_missing" | "permission_denied" | null;
};

export type ModelStatus = {
  assessment_available: boolean;
  model: string | null;
};

export type Health = {
  status: "ok" | "unavailable";
  database: DatabaseStatus;
  model: ModelStatus;
};
