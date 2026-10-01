#!/usr/bin/env bash
# Restore the source dump and set up the app schema and runtime role.
#
#   scripts/setup_db.sh --source PATH [--reset]
#   scripts/setup_db.sh --verify-only
#
# The dump starts with DROP statements, so an existing source_company schema
# is left alone unless --reset is passed.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXPECTED_SHA256="776ddd451c21f5fa85696b2ad5b170e1a1358bb08db54d813a441ce9a9247906"

source_path=""
reset=0
verify_only=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --source) source_path="${2:?--source needs a path}"; shift 2 ;;
    --reset) reset=1; shift ;;
    --verify-only) verify_only=1; shift ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
done

die() { echo "setup_db: $*" >&2; exit 1; }

[[ -f "$ROOT/.env" ]] || die "missing .env (copy .env.example and set passwords)"
set -a; source "$ROOT/.env"; set +a
: "${POSTGRES_DB:?}" "${POSTGRES_USER:?}" "${POSTGRES_PASSWORD:?}" "${DATABASE_URL:?}"

compose() { docker compose --project-directory "$ROOT" -f "$ROOT/compose.yaml" "$@"; }

# Runtime role credentials come from DATABASE_URL.
url_part() { python3 -c 'import os, sys, urllib.parse as u; p = u.urlsplit(os.environ["DATABASE_URL"]); print(u.unquote(getattr(p, sys.argv[1]) or ""))' "$1"; }
RUNTIME_DB_USER="$(url_part username)"
RUNTIME_DB_PASSWORD="$(url_part password)"
runtime_db="$(url_part path)"; runtime_db="${runtime_db#/}"
[[ -n "$RUNTIME_DB_USER" && -n "$RUNTIME_DB_PASSWORD" ]] || die "DATABASE_URL must include runtime user and password"
[[ "$runtime_db" == "$POSTGRES_DB" ]] || die "DATABASE_URL database '$runtime_db' != POSTGRES_DB '$POSTGRES_DB'"
[[ "$RUNTIME_DB_USER" != "$POSTGRES_USER" ]] || die "runtime role must differ from the setup role"

compose exec -T db pg_isready -q -U "$POSTGRES_USER" -d postgres \
  || die "database container is not ready; run 'make db-up' first"

admin_psql() { compose exec -T db psql -X -q -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" "$@"; }

verify() {
  echo "== Verifying as runtime role '$RUNTIME_DB_USER'"
  PGPASSWORD="$RUNTIME_DB_PASSWORD" compose exec -T -e PGPASSWORD db \
    psql -X -v ON_ERROR_STOP=1 -h 127.0.0.1 -U "$RUNTIME_DB_USER" -d "$POSTGRES_DB" -f - < "$ROOT/db/verify.sql"
}

if [[ $verify_only -eq 1 ]]; then verify; exit 0; fi

[[ -n "$source_path" ]] || die "--source PATH is required (e.g. --source data/source_data.sql)"
[[ -f "$source_path" ]] || die "source dump not found: $source_path"
source_abs="$(cd "$(dirname "$source_path")" && pwd)/$(basename "$source_path")"

actual_sha="$(shasum -a 256 "$source_abs" | awk '{print $1}')"
[[ "$actual_sha" == "$EXPECTED_SHA256" ]] \
  || die "SHA-256 mismatch for $source_abs (got $actual_sha); expected the original source export"
echo "== Source dump $source_abs (SHA-256 verified)"

if [[ -z "$(admin_psql -d postgres -v database_name="$POSTGRES_DB" -tA <<'SQL'
SELECT 1 FROM pg_database WHERE datname = :'database_name';
SQL
)" ]]; then
  echo "== createdb $POSTGRES_DB"
  compose exec -T db createdb -U "$POSTGRES_USER" "$POSTGRES_DB"
fi

source_exists="$(admin_psql -d "$POSTGRES_DB" -tAc \
  "SELECT EXISTS (SELECT 1 FROM pg_namespace WHERE nspname = 'source_company')")"

if [[ "$source_exists" == t && $reset -eq 0 ]]; then
  echo "== source_company already exists; skipping restore (pass --reset to replace it)"
else
  [[ "$source_exists" == t ]] && echo "== --reset: replacing existing source_company schema"
  echo "== Restoring with psql -f (ON_ERROR_STOP, single transaction)"
  # Mount the dump read-only into a one-off client container.
  PGPASSWORD="$POSTGRES_PASSWORD" compose run --rm --no-deps -T \
    -v "$source_abs:/restore/source_data.sql:ro" \
    -e PGPASSWORD \
    db psql -X -q -v ON_ERROR_STOP=1 --single-transaction \
      -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /restore/source_data.sql
fi

echo "== Applying db/001_app.sql (app tables, runtime role, grants)"
RUNTIME_DB_USER="$RUNTIME_DB_USER" RUNTIME_DB_PASSWORD="$RUNTIME_DB_PASSWORD" \
  compose exec -T -e RUNTIME_DB_USER -e RUNTIME_DB_PASSWORD db \
  psql -X -q -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f - < "$ROOT/db/001_app.sql"

verify
