#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INIT_LUA="$ROOT_DIR/init.lua"
LOG_FILE="${TMPDIR:-/tmp}/nvim_startup_smoke.log"

ISOLATED=0
if [[ "${1:-}" == "--isolated" ]]; then
  ISOLATED=1
fi

CMD=(/usr/bin/nvim --headless -u "$INIT_LUA" '+lua assert(pcall(require, "devil.core"))' '+qa')

if [[ $ISOLATED -eq 1 ]]; then
  export XDG_DATA_HOME="${TMPDIR:-/tmp}/nvim-smoke-data"
  export XDG_STATE_HOME="${TMPDIR:-/tmp}/nvim-smoke-state"
  export XDG_CACHE_HOME="${TMPDIR:-/tmp}/nvim-smoke-cache"
fi

set +e
"${CMD[@]}" >"$LOG_FILE" 2>&1
STATUS=$?
set -e

if grep -Eq "Error detected while processing|Failed to load .*:|stack traceback:" "$LOG_FILE"; then
  echo "Startup smoke test: FAILED"
  echo "Detected startup errors:"
  sed -n '1,220p' "$LOG_FILE"
  exit 1
fi

if [[ $STATUS -ne 0 ]]; then
  echo "Startup smoke test: FAILED (exit code: $STATUS)"
  sed -n '1,220p' "$LOG_FILE"
  exit "$STATUS"
fi

echo "Startup smoke test: PASSED"
if [[ -s "$LOG_FILE" ]]; then
  echo "Output:"
  sed -n '1,120p' "$LOG_FILE"
fi
