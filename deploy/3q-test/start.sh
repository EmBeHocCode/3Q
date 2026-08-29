#!/usr/bin/env bash
set -euo pipefail

BASE=/opt/3q-test
SERVER="$BASE/h5/server"
JAVA="$BASE/usr/local/jdk/bin/java"
LOG="$BASE/logs"
RUN="$BASE/run"

mkdir -p "$LOG" "$RUN"

is_running() {
  local name=$1
  [[ -f "$RUN/$name.pid" ]] && kill -0 "$(cat "$RUN/$name.pid")" 2>/dev/null
}

wait_port() {
  local name=$1 port=$2
  for _ in $(seq 1 300); do
    if ss -lnt | grep -q ":$port "; then
      echo "$name ready on $port"
      sleep 3
      return 0
    fi
    if ! is_running "$name"; then
      echo "$name stopped before port $port opened"
      tail -80 "$LOG/$name.log" || true
      return 1
    fi
    sleep 1
  done
  echo "$name timed out waiting for port $port"
  tail -80 "$LOG/$name.log" || true
  return 1
}

run_java() {
  local name=$1 dir=$2 xms=$3 xmx=$4 jar=$5 port=$6
  shift 6
  if is_running "$name"; then
    echo "$name already running"
  else
    (
      cd "$SERVER/$dir"
      nohup "$JAVA" -XX:+UseSerialGC "-Xms$xms" "-Xmx$xmx" -jar "$jar" "$@" >"$LOG/$name.log" 2>&1 &
      echo $! >"$RUN/$name.pid"
    )
  fi
  wait_port "$name" "$port"
}

docker start 3q-test-mongo 3q-test-rabbit >/dev/null
sleep 5

if ! is_running socket; then
  (
    cd "$BASE/home/web/socket"
    nohup /usr/bin/node src/index.js >"$LOG/socket.log" 2>&1 &
    echo $! >"$RUN/socket.pid"
  )
fi
wait_port socket 5000

if ! is_running web; then
  nohup /usr/bin/php -S 0.0.0.0:8085 -t "$BASE/home/web" >"$LOG/web.log" 2>&1 &
  echo $! >"$RUN/web.pid"
fi
wait_port web 8085

run_java console console 128m 384m tcg-console-server-0.0.1-SNAPSHOT.jar 9999
run_java login login 64m 256m tcg-login-server-0.0.1-SNAPSHOT.jar 9000
run_java world world 64m 256m tcg-world-server-0.0.1-SNAPSHOT.jar 10086
run_java meta meta 64m 256m tcg-meta-0.0.1-SNAPSHOT.jar 12345
run_java statistic statistic 64m 256m tcg-stat-server-0.0.1-SNAPSHOT.jar 7788
run_java pay pay 64m 256m tcg-pay-server-0.0.1-SNAPSHOT.jar 10010
run_java group group 128m 1024m tcg-group.jar 30001 --v=0 --gc=group-offical --p=30001
run_java cross cross 128m 1024m tcg-cross.jar 20001 --v=0 --cc=cross-yzx1 --p=20001
run_java game game 128m 1280m tcg-game.jar 8001 --v=0 --sc=s1

echo "3Q test stack started"
