#!/usr/bin/env bash
set -euo pipefail

BASE=/opt/3q-test
RUN="$BASE/run"

printf '%-12s %-8s %-8s\n' SERVICE PID STATUS
for name in console login world meta statistic pay group cross game socket web; do
  pid="-"
  status=stopped
  if [[ -f "$RUN/$name.pid" ]]; then
    pid="$(cat "$RUN/$name.pid")"
    if kill -0 "$pid" 2>/dev/null; then
      status=running
    fi
  fi
  printf '%-12s %-8s %-8s\n' "$name" "$pid" "$status"
done

docker ps --filter name=3q-test --format 'container={{.Names}} status={{.Status}}'
free -h
ss -lnt | grep -E ':(5000|7788|8001|8085|9000|9999|10010|10086|12345|20001|27018|30001|5672) ' || true
