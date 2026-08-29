$ErrorActionPreference = "Continue"

$src = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
$dst = "C:\xampp\htdocs\langla"
New-Item -ItemType Directory -Force -Path $dst | Out-Null

$required = @(
  "serverlist.txt",
  "checkpc.txt",
  "checkandroid.txt",
  "checkios.txt",
  "arr_data_game.bin",
  "arr_data_game2.bin",
  "core.jar",
  "gdx.jar",
  "jasr.dll",
  "md5.php",
  "call_back.php",
  "exit.php",
  "index.php"
)

foreach ($name in $required) {
  $from = Join-Path $src $name
  $to = Join-Path $dst $name
  if (Test-Path -LiteralPath $from) {
    Copy-Item -LiteralPath $from -Destination $to -Force
    Write-Host "COPIED $name"
  } else {
    Write-Host "MISSING_SRC $name"
  }
}

Set-Content -LiteralPath (Join-Path $dst "serverlist.txt") -Value "id=Lang La`r`nLangLa VPS=100:104.248.157.207:2907:2907|0|131|0|" -Encoding ASCII

Write-Host "=== HTTP TEST ==="
foreach ($url in @(
  "http://127.0.0.1/langla/serverlist.txt",
  "http://127.0.0.1/langla/checkpc.txt",
  "http://127.0.0.1/langla/arr_data_game.bin",
  "http://127.0.0.1/langla/core.jar",
  "http://127.0.0.1/langla/jasr.dll"
)) {
  Write-Host "--- $url"
  try {
    $r = Invoke-WebRequest -UseBasicParsing $url -TimeoutSec 8
    Write-Host "OK status=$($r.StatusCode) len=$($r.RawContentLength)"
  } catch {
    Write-Host "FAIL $($_.Exception.Message)"
  }
}
