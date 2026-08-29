$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$client = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\Client_LangLaLau"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== RUNNING PORTS BEFORE SETUP ==="
cmd /c "netstat -ano -p tcp | findstr /R "":80 :3306 :27017 :14444 :19129 :19130 :8080 :8088"""

Write-Host "=== SERVER PORT HINTS EXACT ==="
$serverFiles = Get-ChildItem -LiteralPath (Join-Path $server "src") -Recurse -File -Include *.java -ErrorAction SilentlyContinue
$serverFiles += Get-ChildItem -LiteralPath $server -File -Include *.properties,*.txt,*.bat -ErrorAction SilentlyContinue
$serverFiles |
  Select-String -Pattern "new\s+ServerSocket|ServerSocket\s*\(|InetSocketAddress|\.bind\s*\(|PORT\s*=|PORT\s+|port\s*=|14444|19129|19130|8080|8088" |
  Where-Object { $_.Line -notmatch "^\s*import\s" } |
  Select-Object -First 160 Path,LineNumber,Line |
  Format-List

Write-Host "=== CLIENT SERVER CONFIG FILES ==="
foreach ($p in @(
  (Join-Path $client "src\beatdz\ArrayServer.java"),
  (Join-Path $client "src\beatdz\Server.java")
)) {
  Write-Host "--- $p ---"
  if (Test-Path $p) { Get-Content -LiteralPath $p -TotalCount 180 } else { Write-Host "MISSING" }
}
Get-ChildItem -LiteralPath $client -Recurse -File -Filter "arr_server.beatdz" -ErrorAction SilentlyContinue |
  Select-Object -First 20 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) ---"
    Get-Content -LiteralPath $_.FullName -TotalCount 120
  }

Write-Host "=== DB DUMPS CREATE/USE/TABLE FIRST ==="
foreach ($f in @("langla.sql","langladata.sql","danhhieu.sql","shoprank.sql")) {
  $p = Join-Path $server $f
  Write-Host "--- $f ---"
  if (Test-Path $p) {
    Select-String -LiteralPath $p -Pattern "CREATE DATABASE|USE |CREATE TABLE|INSERT INTO" -CaseSensitive:$false |
      Select-Object -First 25 LineNumber,Line |
      Format-Table -AutoSize
  } else { Write-Host "MISSING" }
}
