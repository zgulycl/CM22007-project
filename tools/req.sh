#!/usr/bin/env bash
set -uo pipefail

missing=0

check() {
    local name="$1"
    shift
    local version
    version="$("$@" 2>/dev/null | head -n 1)"
    if [ -n "$version" ]; then
        printf '  [ok]      %-15s %s\n' "$name" "$version"
    else
        printf '  [missing] %s\n' "$name"
        missing=$((missing + 1))
    fi
}

echo "Backend"
check "docker" docker --version
check "docker compose" docker compose version
check "python3" python3 --version

echo
echo "Frontend"
check "flutter" flutter --version
check "dart" dart --version

echo
if [ "$missing" -eq 0 ]; then
    echo "All required tools are installed."
else
    echo "$missing required tool(s) missing."
fi
