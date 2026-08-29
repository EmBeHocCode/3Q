$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$client = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\Client_LangLaLau"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== SERVER CONFIG ==="
Get-Content -LiteralPath (Join-Path $server "config.properties") -TotalCount 80

Write-Host "=== BAT ==="
Get-Content -LiteralPath (Join-Path $server "run.bat") -TotalCount 20
Get-Content -LiteralPath (Join-Path $server "runServerCheck.bat") -TotalCount 20

Write-Host "=== JAVA MAIN JAR META ==="
cmd /c "cd /d C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server && jar tf out\artifacts\LangLaZ_jar\LangLaZ.jar | findstr /i ""Server Config Port Socket main properties"""

Write-Host "=== PORT HINTS SMALL ==="
$files = @()
$paths = @(
  (Join-Path $server "src"),
  (Join-Path $server "config.properties"),
  (Join-Path $server "dataserver.txt")
)
foreach ($p in $paths) {
  if (Test-Path $p) {
    if ((Get-Item $p).PSIsContainer) {
      $files += Get-ChildItem -LiteralPath $p -Recurse -File -Include *.java,*.properties,*.txt,*.xml | Select-Object -First 600
    } else {
      $files += Get-Item -LiteralPath $p
    }
  }
}
$files | Select-String -Pattern "ServerSocket|port|PORT|14444|19129|19130|8080|27017|3306|listen|bind" |
  Select-Object -First 120 Path,LineNumber,Line |
  Format-List

Write-Host "=== SQL HEADERS ==="
foreach ($f in @("langla.sql","langladata.sql","danhhieu.sql","shoprank.sql")) {
  $p = Join-Path $server $f
  Write-Host "--- $f ---"
  if (Test-Path $p) {
    Get-Content -LiteralPath $p -TotalCount 35
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== CLIENT SMALL HINTS ==="
foreach ($p in @(
  (Join-Path $client "src\beatdz\ArrayServer.java"),
  (Join-Path $client "src\beatdz\Server.java")
)) {
  Write-Host "--- $p ---"
  if (Test-Path $p) { Get-Content -LiteralPath $p -TotalCount 120 } else { Write-Host "MISSING" }
}
Get-ChildItem -LiteralPath $client -Recurse -File -Filter "arr_server.beatdz" -ErrorAction SilentlyContinue |
  Select-Object -First 10 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) ---"
    Get-Content -LiteralPath $_.FullName -TotalCount 80
  }
