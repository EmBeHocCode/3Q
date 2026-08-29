$ErrorActionPreference = "Stop"

$src = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
$dst = "C:\xampp\htdocs\langla"

if (!(Test-Path -LiteralPath $src)) {
  throw "Missing source: $src"
}

New-Item -ItemType Directory -Force -Path $dst | Out-Null

Get-ChildItem -LiteralPath $src -Force | ForEach-Object {
  Copy-Item -LiteralPath $_.FullName -Destination $dst -Recurse -Force
}

$serverlist = "id=Lang La`r`nLangLa VPS=100:104.248.157.207:2907:2907|0|131|0|"
Set-Content -LiteralPath (Join-Path $dst "serverlist.txt") -Value $serverlist -Encoding ASCII

Write-Host "=== REQUIRED FILES ==="
foreach ($name in @("serverlist.txt","checkpc.txt","checkandroid.txt","checkios.txt","arr_data_game.bin","arr_data_game2.bin","core.jar","gdx.jar","jasr.dll")) {
  $f = Join-Path $dst $name
  if (Test-Path -LiteralPath $f) {
    Get-Item -LiteralPath $f | Select-Object Name,Length,LastWriteTime | Format-Table -AutoSize
  } else {
    Write-Host "MISSING $name"
  }
}

Write-Host "=== HTTP TEST ==="
foreach ($url in @(
  "http://127.0.0.1/langla/serverlist.txt",
  "http://127.0.0.1/langla/checkpc.txt",
  "http://127.0.0.1/langla/arr_data_game.bin",
  "http://127.0.0.1/langla/core.jar"
)) {
  Write-Host "--- $url"
  $r = Invoke-WebRequest -UseBasicParsing $url -TimeoutSec 8
  Write-Host "OK status=$($r.StatusCode) len=$($r.RawContentLength)"
}
