#!/usr/bin/env python3
import json
import re
import sys
from pathlib import Path


BASE = Path(sys.argv[1]).resolve()
PUBLIC_IP = sys.argv[2]
DB_USER = sys.argv[3]
DB_PASSWORD = sys.argv[4]
WEB_PORT = 8085
MONGO_PORT = 27018


def replace_text(relative_path, replacements):
    path = BASE / relative_path
    text = path.read_text(encoding="utf-8")
    for old, new in replacements:
        text = text.replace(old, new)
    path.write_text(text, encoding="utf-8")


def regex_text(relative_path, replacements):
    path = BASE / relative_path
    text = path.read_text(encoding="utf-8")
    for pattern, replacement in replacements:
        text = re.sub(pattern, replacement, text, flags=re.MULTILINE)
    path.write_text(text, encoding="utf-8")


# Public endpoints used by the pre-built H5 client.
regex_text("home/web/game/source/index.js", [
    (r'^ydwxConfig\.basePath\s*=.*$', f'ydwxConfig.basePath = "http://{PUBLIC_IP}:{WEB_PORT}/game/source/";'),
    (r'^ydwxConfig\.metaDataServer\s*=.*$', f'ydwxConfig.metaDataServer = "http://{PUBLIC_IP}:12345/";'),
    (r'^ydwxConfig\.statisticServer\s*=.*$', f'ydwxConfig.statisticServer = "http://{PUBLIC_IP}:7788/";'),
    (r'loadLib\("//chienma3q\.mobi/game/source/', f'loadLib("//{PUBLIC_IP}:{WEB_PORT}/game/source/'),
])

login_path = BASE / "home/web/game/source/srv/login.json"
login_data = json.loads(login_path.read_text(encoding="utf-8-sig"))
for server in login_data.get("serverList", []):
    server["host"] = PUBLIC_IP
    server["port"] = 9000
login_path.write_text(json.dumps(login_data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

replace_text("home/web/game/source/js/bundle.js", [
    ("http://chienma3q.mobi:", f"http://{PUBLIC_IP}:"),
    ("http://chienma3q.mobi/", f"http://{PUBLIC_IP}:{WEB_PORT}/"),
])
replace_text("home/web/game/source/libs/v4r510n-p4ck0o0.js", [
    ("http://chienma3q.mobi/api/", f"http://{PUBLIC_IP}:{WEB_PORT}/api/"),
])
replace_text("home/web/game/source/srv/yzx.out.js", [
    ("160.191.50.225", PUBLIC_IP),
])

# Web API and utility database credentials.
regex_text("home/web/api/config.php", [
    (r"define\('MYSQL_USER',\s*'[^']*'\);", f"define('MYSQL_USER', '{DB_USER}');"),
    (r"define\('MYSQL_PWD',\s*'[^']*'\);", f"define('MYSQL_PWD', '{DB_PASSWORD}');"),
    (r"define\('SOCKET_URL',\s*'[^']*'\);", f"define('SOCKET_URL', 'http://{PUBLIC_IP}:5000');"),
])

for relative in ["home/web/api/api.php", "home/web/api/getSession.php", "home/web/tool/user/function/common.php"]:
    path = BASE / relative
    text = path.read_text(encoding="utf-8-sig")
    text = text.replace('"root", "EHrWXkpA30e6f7CQx2cx"', f'"{DB_USER}", "{DB_PASSWORD}"')
    text = text.replace("'root', 'EHrWXkpA30e6f7CQx2cx'", f"'{DB_USER}', '{DB_PASSWORD}'")
    text = text.replace('"root","Frost2022"', f'"{DB_USER}","{DB_PASSWORD}"')
    text = text.replace("dbname=web", "dbname=WEB")
    path.write_text(text, encoding="utf-8")

replace_text("home/web/api/includes/utils.php", [
    ("http://chienma3q.mobi/tool/", f"http://{PUBLIC_IP}:{WEB_PORT}/tool/"),
])

admin_path = BASE / "home/web/game/source/admin/static/js/main.da770e7e.chunk.js"
if admin_path.exists():
    admin_text = admin_path.read_text(encoding="utf-8-sig")
    admin_text = admin_text.replace("http://160.191.50.225/srv/excel/", f"http://{PUBLIC_IP}:{WEB_PORT}/srv/excel/")
    admin_text = admin_text.replace("160.191.50.225", PUBLIC_IP)
    admin_path.write_text(admin_text, encoding="utf-8")

# Java YAML database user/password.
for relative in ["h5/server/console/config/env.yml", "h5/server/statistic/config/env.yml"]:
    regex_text(relative, [
        (r'^(\s*)username:\s*root\s*$', rf'\1username: {DB_USER}'),
        (r'^(\s*)password:\s*EHrWXkpA30e6f7CQx2cx\s*$', rf'\1password: {DB_PASSWORD}'),
    ])
    replace_text(relative, [("port: 27017", f"port: {MONGO_PORT}")])

# Runtime global config consumed by Console.
global_path = BASE / "h5/server/console/store/global.conf.json"
global_data = json.loads(global_path.read_text(encoding="utf-8-sig"))
mysql_conf = global_data.get("tcg_mysql_conf") or {}
mysql_conf["username"] = DB_USER
mysql_conf["password"] = DB_PASSWORD
mongo_conf = global_data.get("tcg_mongo_conf") or {}
mongo_conf["port"] = MONGO_PORT
for key in ["loginNP", "statNP", "payNP", "worldNP"]:
    endpoint = global_data.get(key) or {}
    hosts = endpoint.get("host") or {}
    hosts["WAN"] = PUBLIC_IP
    hosts["domain"] = PUBLIC_IP
global_path.write_text(json.dumps(global_data, ensure_ascii=False, separators=(",", ":")) + "\n", encoding="utf-8")

# SQL seed references for database credentials and the previous public IP.
sql_path = BASE / "Tools Event/sql/tcg.sql"
sql_text = sql_path.read_text(encoding="utf-8-sig")
sql_text = sql_text.replace("160.191.50.225", PUBLIC_IP)
sql_text = sql_text.replace("'root', 'EHrWXkpA30e6f7CQx2cx'", f"'{DB_USER}', '{DB_PASSWORD}'")
sql_text = sql_text.replace("'127.0.0.1', 27017", f"'127.0.0.1', {MONGO_PORT}")
sql_text = sql_text.replace("-Xms128m -Xmx2048m", "-Xms128m -Xmx768m")
sql_text = sql_text.replace("-Xms512m -Xmx1024m", "-Xms64m -Xmx384m")
sql_path.write_text(sql_text, encoding="utf-8")

# Remaining small text configs containing the old deployment IP/domain.
for relative in [
    "h5/server/world/config/env.yml",
    "home/web/game/source/gm/config/config.php",
]:
    path = BASE / relative
    if path.exists():
        text = path.read_text(encoding="utf-8-sig")
        text = text.replace("160.191.50.225", PUBLIC_IP)
        text = text.replace("chienma3q.mobi", f"{PUBLIC_IP}:{WEB_PORT}")
        path.write_text(text, encoding="utf-8")

print("configuration updated")
