$ErrorActionPreference = "Stop"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null

$ip = "104.248.157.207"
$serverDir = "D:\3QVuongGia\www\server"
$ts = Get-Date -Format "yyyyMMdd-HHmmss"
New-Item -ItemType Directory -Force -Path $serverDir | Out-Null

$json = @"
{
  "lastLoginServerId": 4001,
  "zone_list": [
    {
      "id": 14,
      "channel": "NAN",
      "zoneName": "Meow"
    }
  ],
  "zone_label_list": [
    {
      "labName": "S1",
      "labId": 8,
      "zoneId": 14
    }
  ],
  "server_list": [
    {
      "address": "${ip}:8001",
      "openServer": true,
      "name": "S1-Meow",
      "upkeepMessage": "Server dang bao tri",
      "mark": 8,
      "load": 0,
      "serverId": 4001,
      "labId": 8,
      "zoneId": 14
    }
  ]
}
"@

$php = "<?php`r`nheader(`"Content-type:text/html;charset=utf-8`");`r`necho '" + ($json -replace "'", "\'") + "';`r`n"

foreach ($name in @("lis.do","lis.php")) {
  $path = Join-Path $serverDir $name
  if (Test-Path -LiteralPath $path) {
    Copy-Item -LiteralPath $path -Destination "$path.bak.$ts" -Force
  }
  Set-Content -LiteralPath $path -Encoding UTF8 -Value $php
  Write-Host "patched $path"
}

foreach ($path in @((Join-Path $serverDir "lis.do"), (Join-Path $serverDir "lis.php"))) {
  Write-Host "--- $path ---"
  Get-Content -LiteralPath $path
}
