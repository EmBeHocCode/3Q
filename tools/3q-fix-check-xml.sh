#!/usr/bin/env bash
set -euo pipefail

ROOT="/var/www/3q-vuonggia/3QVuongGia/www/update/R10"
cp "$ROOT/check.xml" "$ROOT/check.xml.bak-fixquote-$(date +%s)"
cat > "$ROOT/check.xml" <<'XML'
<?xml version="1.0" encoding="UTF-8" ?>
<version current="1.1.5">
    <c content="Cập nhật sửa đăng nhập !" date="" />
</version>
XML

echo "=== check.xml ==="
cat "$ROOT/check.xml"

echo "=== package ==="
curl -I -sS -m 8 "http://104.248.157.207/update/R10/zipsource/1.1.5/1.1.4-1.1.5.zip" | head -6
