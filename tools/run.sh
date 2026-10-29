#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if [ ! -f .env ]; then
    echo "Missing .env: copy .env.example to .env and give every key a value." >&2
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running: start Docker and try again." >&2
    exit 1
fi

bash tools/compose.sh up --build --detach --wait "$@"
