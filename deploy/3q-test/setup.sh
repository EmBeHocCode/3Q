#!/usr/bin/env bash
set -euo pipefail

BASE=/opt/3q-test
PUBLIC_IP=104.248.157.207
SECRETS="$BASE/.secrets"

if [[ ! -f "$SECRETS" ]]; then
  umask 077
  DB_USER=tcg_game
  DB_PASSWORD="$(openssl rand -hex 18)"
  cat >"$SECRETS" <<EOF
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
EOF
fi

# shellcheck disable=SC1090
source "$SECRETS"
python3 "$BASE/deploy/3q-test/configure.py" "$BASE" "$PUBLIC_IP" "$DB_USER" "$DB_PASSWORD"

mysql <<SQL
CREATE DATABASE IF NOT EXISTS tcg CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS stat CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS WEB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS cdks CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS game_s1 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS '$DB_USER'@'127.0.0.1' IDENTIFIED BY '$DB_PASSWORD';
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
ALTER USER '$DB_USER'@'127.0.0.1' IDENTIFIED BY '$DB_PASSWORD';
ALTER USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON tcg.* TO '$DB_USER'@'127.0.0.1';
GRANT ALL PRIVILEGES ON stat.* TO '$DB_USER'@'127.0.0.1';
GRANT ALL PRIVILEGES ON WEB.* TO '$DB_USER'@'127.0.0.1';
GRANT ALL PRIVILEGES ON cdks.* TO '$DB_USER'@'127.0.0.1';
GRANT ALL PRIVILEGES ON game_s1.* TO '$DB_USER'@'127.0.0.1';
GRANT ALL PRIVILEGES ON tcg.* TO '$DB_USER'@'localhost';
GRANT ALL PRIVILEGES ON stat.* TO '$DB_USER'@'localhost';
GRANT ALL PRIVILEGES ON WEB.* TO '$DB_USER'@'localhost';
GRANT ALL PRIVILEGES ON cdks.* TO '$DB_USER'@'localhost';
GRANT ALL PRIVILEGES ON game_s1.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
SQL

if [[ ! -f "$BASE/.database-imported" ]]; then
  mysql tcg <"$BASE/Tools Event/sql/tcg.sql"
  mysql stat <"$BASE/Tools Event/sql/stat.sql"
  mysql WEB <"$BASE/Tools Event/sql/WEB.sql"
  mysql cdks <"$BASE/Tools Event/sql/cdks.sql"
  touch "$BASE/.database-imported"
fi

if ! docker inspect 3q-test-mongo >/dev/null 2>&1; then
  docker run -d --name 3q-test-mongo --restart unless-stopped --memory 512m \
    -p 127.0.0.1:27018:27017 \
    -e MONGO_INITDB_ROOT_USERNAME=abc123 \
    -e MONGO_INITDB_ROOT_PASSWORD=Abc123321123 \
    mongo:5.0.6 --wiredTigerCacheSizeGB 0.25
fi

if ! docker inspect 3q-test-rabbit >/dev/null 2>&1; then
  docker run -d --name 3q-test-rabbit --restart unless-stopped --memory 384m \
    -p 127.0.0.1:5672:5672 \
    -e RABBITMQ_DEFAULT_USER=admin \
    -e RABBITMQ_DEFAULT_PASS=Abc123456...a \
    rabbitmq:3.9.14
fi

chmod -R u+rx "$BASE/usr/local/jdk/bin"
mkdir -p "$BASE/logs" "$BASE/run"

if [[ ! -d "$BASE/home/web/socket/node_modules" ]]; then
  cd "$BASE/home/web/socket"
  npm ci --omit=dev
fi

php -r "exit(extension_loaded('pdo_mysql') ? 0 : 1);"
php -r "exit(extension_loaded('curl') ? 0 : 1);"
echo "infrastructure ready"
