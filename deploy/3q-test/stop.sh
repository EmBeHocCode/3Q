#!/usr/bin/env bash
set -euo pipefail

BASE=/opt/3q-test
RUN="$BASE/run"

for name in web socket game cross group pay statistic meta world login console; do
  pid_file="$RUN/$name.pid"
  if [[ -f "$pid_file" ]]; then
    pid="$(cat "$pid_file")"
    if kill -0 "$pid" 2>/dev/null; then
      kill "$pid"
    fi
    rm -f "$pid_file"
  fi
done

echo "3Q test processes stopped"
