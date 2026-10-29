#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

APP_VERSION="$(tr -d '[:space:]' < VERSION)"
if [ -z "$APP_VERSION" ]; then
    echo "VERSION is empty." >&2
    exit 1
fi
export APP_VERSION

exec docker compose "$@"
