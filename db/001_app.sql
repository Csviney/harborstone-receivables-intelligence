-- App schema, runtime role, and grants. Run by scripts/setup_db.sh; safe to re-run.

\set ON_ERROR_STOP on
\getenv runtime_role RUNTIME_DB_USER
\getenv runtime_password RUNTIME_DB_PASSWORD

SELECT format('CREATE ROLE %I LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT', :'runtime_role')
WHERE NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = :'runtime_role') \gexec
SELECT format('ALTER ROLE %I WITH LOGIN PASSWORD %L', :'runtime_role', :'runtime_password') \gexec

BEGIN;

CREATE SCHEMA IF NOT EXISTS app;

-- invoice_id has no FK to source_company so the source can be restored independently.
CREATE TABLE IF NOT EXISTS app.investigations (
    id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id       text NOT NULL,
    snapshot_as_of   date NOT NULL,
    input_hash       text NOT NULL,
    analysis_version text NOT NULL,
    model            text NOT NULL,
    status           text NOT NULL CHECK (status IN ('running', 'completed', 'failed')),
    input_json       jsonb NOT NULL,
    output_json      jsonb,
    trace_json       jsonb NOT NULL DEFAULT '[]'::jsonb,
    usage_json       jsonb,
    started_at       timestamptz NOT NULL DEFAULT now(),
    finished_at      timestamptz,
    error_code       text,
    error_message    text,
    CHECK (status = 'running' OR finished_at IS NOT NULL),
    CHECK (status <> 'completed' OR output_json IS NOT NULL)
);

CREATE INDEX IF NOT EXISTS investigations_invoice_started_idx
    ON app.investigations (invoice_id, started_at DESC);

-- One running investigation per invoice and input.
CREATE UNIQUE INDEX IF NOT EXISTS investigations_one_running_idx
    ON app.investigations (invoice_id, input_hash)
    WHERE status = 'running';

-- Restoring the source recreates its tables, so grants are reapplied on every run.
SELECT format('REVOKE ALL ON DATABASE %I FROM PUBLIC', current_database()) \gexec
SELECT format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), :'runtime_role') \gexec
REVOKE CREATE ON SCHEMA public FROM PUBLIC;

GRANT USAGE ON SCHEMA source_company TO :"runtime_role";
GRANT SELECT ON ALL TABLES IN SCHEMA source_company TO :"runtime_role";

GRANT USAGE ON SCHEMA app TO :"runtime_role";
GRANT SELECT, INSERT ON app.investigations TO :"runtime_role";
-- Only the run outcome can change; the saved inputs and identity are fixed once a run starts.
GRANT UPDATE (status, output_json, trace_json, usage_json, finished_at, error_code, error_message)
    ON app.investigations TO :"runtime_role";

COMMIT;
