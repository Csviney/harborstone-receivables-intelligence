# Harborstone Receivables Intelligence

Harborstone’s core challenge is not a lack of data, but that the customer, project, and accounting context needed to act is fragmented across systems. I chose accounts receivable as a focused place to solve that broader integration problem because it has a clear operating outcome: help the team identify where cash is stuck, understand why an invoice needs attention, and prepare the right next step without creating another system of record. This directly supports Rachel’s need for traceable AR and working-capital visibility, Maya’s need to understand where cash is getting stuck, and Tasha’s need to spend less time reconstructing context and chasing answers.

That focus also reflects a broader risk across commercial restoration and reconstruction contractors: profitable work does not guarantee healthy cash flow if receivables are slow to convert into cash. C&R Magazine’s 2026 State of the Industry findings report that 40.8% of restoration respondents identify getting paid as their biggest challenge, ahead of hiring at 20.9%. The RIA’s 2025 Cost of Doing Business report puts median accounts receivable at roughly 16% of annual gross revenue. [C&R findings](https://www.linkedin.com/posts/c-r-magazine_restorationindustry-stateoftheindustry-activity-7462518837423423488-KzrD), [RIA report, p. 25 (hosted copy)](https://www.scribd.com/document/1072533320/RIA-Cost-of-Doing-Business-Report-Digital-1).

That means a meaningful portion of revenue can remain tied up in outstanding customer balances even for otherwise successful operators. The goal of this product is therefore deliberately narrow but commercially meaningful: connect existing records, triage the receivables that deserve attention, expose the supporting evidence, and use AI where it can reduce the manual work required to turn that information into action.

## What the application does

- Groups invoices into collection follow-up, billing review, verification, not yet due, and paid, using deterministic financial rules.
- Brings together customer contacts, project context, notes, payments, and inspectable balance calculations.
- Shows reconstructed outstanding and overdue AR over time, with monthly movements.
- Runs an optional investigation when requested, returning concise findings, saved source citations, and a suggested email when useful.
- Lets users copy a read-only email, then edit and send it in their existing communication system.

## Local setup

### Prerequisites

Use macOS, Linux, or WSL with:

- Docker and Docker Compose, with Docker running.
- Python 3.12 and [uv](https://docs.astral.sh/uv/getting-started/installation/) on your PATH.
- Node.js 22.12 or newer in the 22.x series, with npm. Checks have been run with Node 22.23.0.
- Git, Make, Bash, `python3`, and `shasum` for the setup script.

PostgreSQL and its client run inside Docker; no local PostgreSQL installation is needed.

### 1. Clone and install dependencies

```bash
git clone https://github.com/Csviney/harborstone-receivables-intelligence.git
cd harborstone-receivables-intelligence

uv sync --directory backend --locked
npm ci --prefix frontend
```

Run the remaining commands from the repository root unless stated otherwise.

### 2. Configure the environment

```bash
cp .env.example .env
```

Edit `.env`:

- Replace `POSTGRES_PASSWORD` with a local setup-role password.
- Replace `change-me-app` in `DATABASE_URL` with a different runtime-role password. Setup creates that restricted role from the URL.
- Keep the default database/user names and port `5433`, or change the corresponding values consistently. `DATABASE_URL` must match the database name and host port.
- Leave `OPENAI_API_KEY` and `OPENAI_MODEL` empty to use the queue, invoice details, and chart without model calls.

Long random hexadecimal passwords avoid shell and URL escaping issues in this local setup. `.env` is ignored by Git; never put real credentials in `.env.example` or frontend files.

To enable investigations, set both `OPENAI_API_KEY` and a model your API account can access in `.env`; `gpt-4o-mini` has been used for the live checks. Restart the backend after changing these settings. Model calls transmit the selected invoice evidence to the provider and incur API charges. Browsing does not call the model.

### 3. Start and prepare PostgreSQL

```bash
make db-up
make db-setup SOURCE=data/source_data.sql
```

Setup verifies the dump’s SHA-256, restores it with the container’s own `psql`, creates the application schema and runtime permissions, and runs database checks. Expect **42 source tables, 1,075 rows, 21 invoices, and 10 payments**.

The setup command is safe to repeat: it skips an existing source schema and reapplies application setup and verification. The explicit script option `--reset` replaces source data; it is not needed for normal startup. Application startup never restores the dump.

### 4. Run the application

In one terminal:

```bash
make backend
```

In a second terminal, from the repository root:

```bash
make frontend
```

Open **http://127.0.0.1:5173**. The frontend proxies `/api` to the backend at **http://127.0.0.1:8001**.

Check readiness:

```bash
curl http://127.0.0.1:8001/api/health
```

A ready database returns HTTP 200 even when investigations are not configured. If the database is unavailable, the API reports HTTP 503 and the interface shows an error.

### 5. Explore the workflow

Select an invoice to review its facts and Balance details, expand **AR over time**, or run an optional **Assess invoice** with model access configured. Try **0502** for partial payment, **0596** for unsent billing, and **0455** for a paid invoice with a later note needing verification.

The snapshot shows **$1,108,464 outstanding**, **$719,004 overdue**, and **$311,800 unsent billing**. Headline AR excludes failed-sync invoices; the chart reconstructs the 16 currently SENT invoices, not the full historical ledger. USD is assumed.

## Checks and shutdown

With the database running and setup complete:

```bash
make db-verify
make test
npm run build --prefix frontend
git diff --check
```

These check database permissions, backend/frontend behaviour, types, and the build without paid model calls. Tests clean up their own investigation rows; permission checks roll back their writes.

Run `make model-smoke` for an optional **paid** tool/structured-output check with model credentials. Stop dev servers with Ctrl-C, then run `make db-down`; database contents are retained.

## Troubleshooting

- **Tools:** ensure `uv` is on PATH and Node matches the prerequisite version. Make also accepts `UV=/path/to/uv`.
- **Ports:** change `POSTGRES_HOST_PORT` and `DATABASE_URL` together. Override the API port with `API_PORT=8002` on both `make backend` and `make frontend`.
- **Database:** start Docker, run `make db-up`, and rerun setup. Changing `.env` does not change the setup-role password in an existing database volume.

## Design and next steps

The application uses React/TypeScript, FastAPI, PostgreSQL, and the OpenAI Agents SDK. Financial calculations and triage are deterministic; AI interprets context within validated boundaries. Saved investigations preserve their evidence, while source systems remain authoritative. See [Design decisions](architecture/DesignDecisions.md) for the rationale and tradeoffs.

Future work centres on fresh source integrations, follow-up in existing task systems, controlled customer outreach, and analytics that show whether work is moving faster and overdue balances are improving. See [Future directions](architecture/FutureDirections.md).
