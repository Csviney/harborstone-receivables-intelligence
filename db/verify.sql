-- Run as the runtime role by scripts/setup_db.sh. All writes are rolled back.

\set ON_ERROR_STOP on
\pset footer off

\echo '== Source metadata'
SELECT key, value FROM source_company.dataset_metadata ORDER BY key;

\echo '== Source counts (expected 42 tables / 1075 rows; 21 invoices; 10 payments; 2 invoice notes)'
SELECT count(*) AS source_tables,
       sum((xpath('/row/n/text()',
                  query_to_xml(format('SELECT count(*) AS n FROM %I.%I', table_schema, table_name),
                               false, true, '')))[1]::text::int) AS source_rows
FROM information_schema.tables
WHERE table_schema = 'source_company' AND table_type = 'BASE TABLE';

DO $$
DECLARE
    n_tables int;
    n_rows   int;
BEGIN
    SELECT count(*),
           sum((xpath('/row/n/text()',
                      query_to_xml(format('SELECT count(*) AS n FROM %I.%I', table_schema, table_name),
                                   false, true, '')))[1]::text::int)
      INTO n_tables, n_rows
      FROM information_schema.tables
     WHERE table_schema = 'source_company' AND table_type = 'BASE TABLE';
    IF n_tables <> 42 OR n_rows <> 1075 THEN
        RAISE EXCEPTION 'source counts % tables / % rows, expected 42 / 1075', n_tables, n_rows;
    END IF;
    IF (SELECT value FROM source_company.dataset_metadata WHERE key = 'dataset_as_of') <> '2026-07-28' THEN
        RAISE EXCEPTION 'unexpected dataset_as_of';
    END IF;
    IF (SELECT count(*) FROM source_company.ar_invoices) <> 21
       OR (SELECT count(*) FROM source_company.ar_payments) <> 10
       OR (SELECT count(*) FROM source_company.ar_invoice_notes) <> 2 THEN
        RAISE EXCEPTION 'unexpected AR row counts';
    END IF;
END $$;

\echo '== Runtime role attributes'
SELECT current_user AS runtime_role, rolsuper, rolcreaterole, rolcreatedb,
       (SELECT nspowner::regrole::text FROM pg_namespace WHERE nspname = 'source_company') AS source_owner,
       (SELECT nspowner::regrole::text FROM pg_namespace WHERE nspname = 'app') AS app_owner
FROM pg_roles WHERE rolname = current_user;

\echo '== Denied: source writes, DDL, protected app columns, deleting investigations'
BEGIN;
DO $$
DECLARE
    stmt text;
BEGIN
    INSERT INTO app.investigations (invoice_id, snapshot_as_of, input_hash, analysis_version, model, status, input_json)
    VALUES ('verify', DATE '2026-07-28', 'verify', 'verify', 'verify', 'running', '{}');

    FOREACH stmt IN ARRAY ARRAY[
        'INSERT INTO source_company.dataset_metadata (key, value) VALUES (''verify'', ''x'')',
        'UPDATE source_company.ar_invoices SET status = status',
        'DELETE FROM source_company.ar_payments',
        'TRUNCATE source_company.ar_invoice_notes',
        'CREATE TABLE source_company.verify_tmp (x int)',
        'CREATE TABLE app.verify_tmp (x int)',
        'CREATE TABLE public.verify_tmp (x int)',
        'ALTER TABLE app.investigations ADD COLUMN verify_tmp int',
        'UPDATE app.investigations SET input_hash = ''changed''',
        'UPDATE app.investigations SET input_json = ''{}''',
        'DELETE FROM app.investigations'
    ] LOOP
        BEGIN
            EXECUTE stmt;
            RAISE EXCEPTION 'UNEXPECTEDLY ALLOWED: %', stmt USING ERRCODE = 'P0001';
        EXCEPTION
            WHEN insufficient_privilege THEN
                RAISE NOTICE 'denied as expected: %', stmt;
        END;
    END LOOP;
END $$;
ROLLBACK;

\echo '== Permitted: app inserts, workflow updates, reads'
BEGIN;
WITH inv AS (
    INSERT INTO app.investigations (invoice_id, snapshot_as_of, input_hash, analysis_version, model, status, input_json)
    VALUES ('verify', DATE '2026-07-28', 'verify', 'verify', 'verify', 'running', '{}')
    RETURNING id
)
SELECT id AS investigation_id FROM inv \gset
UPDATE app.investigations
   SET status = 'completed', output_json = '{}', finished_at = now()
 WHERE id = :'investigation_id';
SELECT status, finished_at IS NOT NULL AS finished FROM app.investigations WHERE id = :'investigation_id';
ROLLBACK;

\echo '== Verification passed (all writes rolled back)'
