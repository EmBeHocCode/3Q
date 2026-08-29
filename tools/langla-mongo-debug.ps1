$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== PORT 27017 / 2907 ==="
cmd /c "netstat -ano -p tcp | findstr /R "":27017 :2907 :3306"""

Write-Host "=== MONGODB SOURCE ==="
$mongoFiles = Get-ChildItem -LiteralPath (Join-Path $server "src") -Recurse -File -Include *.java |
  Where-Object { $_.Name -match "Mongo|Clan|Main|Config" }
foreach ($f in $mongoFiles) {
  Write-Host "--- $($f.FullName) ---"
  Select-String -LiteralPath $f.FullName -Pattern "MongoDbConnection|connect|mongodb|27017|password|Credential|MongoClient|System.exit|Exception|catch|load\\(" -CaseSensitive:$false |
    Select-Object -First 80 LineNumber,Line |
    Format-Table -AutoSize
}

Write-Host "=== LAST TEST LOGS ==="
foreach ($f in @(
  "$logDir\langla-java8-test.out.log",
  "$logDir\langla-java8-test.err.log",
  "$logDir\langla-server-run.log",
  "$logDir\langla-server-err.log",
  "$server\langla.log"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content -LiteralPath $f -Tail 80 } else { Write-Host "MISSING" }
}
