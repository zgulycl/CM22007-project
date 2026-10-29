#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

read -r -p "This deletes database/data and the locally built images. Type 'yes' to continue: " answer
if [ "$answer" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

bash tools/kill.sh
bash tools/compose.sh down --volumes --remove-orphans
docker images --quiet --filter 'reference=cm22007-*' | sort -u | xargs -r docker rmi --force
rm -rf database/data
