import os
from pathlib import Path
import shutil
import subprocess
import sys

import pytest


ROOT = Path(__file__).resolve().parents[2]


@pytest.mark.parametrize("schema_exists,reset,restores", [(False, False, True), (True, False, False), (True, True, True)])
def test_restore_requires_reset_for_existing_schema(tmp_path, schema_exists, reset, restores):
    (tmp_path / "scripts").mkdir()
    shutil.copy(ROOT / "scripts/setup_db.sh", tmp_path / "scripts")
    shutil.copytree(ROOT / "db", tmp_path / "db")
    (tmp_path / ".env").write_text(
        "POSTGRES_DB=harborstone\nPOSTGRES_USER=admin\nPOSTGRES_PASSWORD=admin-secret\n"
        "DATABASE_URL=postgresql://runtime:runtime-secret@localhost/harborstone\n"
    )
    log = tmp_path / "calls"
    docker = tmp_path / "docker"
    docker.write_text(
        f"#!{sys.executable}\n"
        "import os, sys\n"
        "with open(os.environ['CALL_LOG'], 'a') as log: log.write(repr(sys.argv) + '\\n')\n"
        "if '-tA' in sys.argv: print('1')\n"
        "if '-tAc' in sys.argv:\n"
        "    assert 'pg_namespace' in sys.argv[-1]\n"
        "    print(os.environ['SCHEMA_EXISTS'])\n"
    )
    docker.chmod(0o755)
    # Also log python3 calls so a password passed as an argument gets caught.
    python3 = tmp_path / "python3"
    python3.write_text(
        f"#!{sys.executable}\n"
        "import os, sys\n"
        "with open(os.environ['CALL_LOG'], 'a') as log: log.write(repr(sys.argv) + '\\n')\n"
        "os.execv(sys.executable, [sys.executable, *sys.argv[1:]])\n"
    )
    python3.chmod(0o755)
    result = subprocess.run(
        ["bash", str(tmp_path / "scripts/setup_db.sh"), "--source", str(ROOT / "data/source_data.sql"),
         *(["--reset"] if reset else [])],
        env={**os.environ, "PATH": f"{tmp_path}:{os.environ['PATH']}", "CALL_LOG": str(log),
             "SCHEMA_EXISTS": "t" if schema_exists else "f"},
        capture_output=True, text=True,
    )
    assert result.returncode == 0, result.stderr
    calls = log.read_text()
    assert ("/restore/source_data.sql" in calls) == restores
    assert "runtime-secret" not in calls
    assert "admin-secret" not in calls
    if restores:
        assert "--single-transaction" in calls
        assert "ON_ERROR_STOP=1" in calls
        assert ":ro" in calls
