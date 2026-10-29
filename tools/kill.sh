#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

bash tools/compose.sh down --remove-orphans
