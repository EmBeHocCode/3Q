#!/usr/bin/env bash
set -euo pipefail

ROOT="/var/www/3q-vuonggia/3QVuongGia/www/update/R10"
cat > "$ROOT/check.xml" <<'XML'
<?xml version="1.0" encoding="UTF-8" ?>
<version current="1.1.7">
    <c content="Cập nhật lại tài nguyên sạch !" date="" />
</version>
XML

cat "$ROOT/check.xml"
