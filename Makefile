UV ?= uv
API_PORT ?= 8001
SOURCE ?=

.PHONY: db-up db-down db-setup db-verify backend frontend test typecheck model-smoke

db-up:
	docker compose up -d --wait db

db-down:
	docker compose stop db

db-setup:
	@test -n "$(SOURCE)" || { echo "usage: make db-setup SOURCE=path/to/source_data.sql"; exit 2; }
	scripts/setup_db.sh --source "$(SOURCE)"

db-verify:
	scripts/setup_db.sh --verify-only

backend:
	cd backend && $(UV) run uvicorn app.main:app --host 127.0.0.1 --port $(API_PORT) --workers 1 --reload

frontend:
	cd frontend && API_PORT=$(API_PORT) npm run dev

test:
	cd backend && $(UV) run pytest -q
	cd frontend && npm run typecheck

typecheck:
	cd frontend && npm run typecheck

# Calls the OpenAI API.
model-smoke:
	cd backend && $(UV) run python -m app.model_smoke
