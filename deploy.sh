#!/usr/bin/env bash
set -euo pipefail
APP_ENV="${APP_ENV:-staging}"
PORT="${PORT:-8080}"
if [[ "$APP_ENV" == "prod" ]]; then
    ./bin/app "$PORT"
else
    ./bin/app --dev --port "$PORT"
fi
