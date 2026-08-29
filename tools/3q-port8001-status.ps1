$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null

Write-Host "=== GAME PORTS LISTENING ==="
foreach ($p in @(8001,9001,14001,20004,3306,80,8080)) {
  $hit = netstat -ano -p tcp | Select-String -Pattern (":$p\s+.*LISTENING")
  if ($hit) { Write-Host "OK   $p  $($hit.Line.Trim())" }
  else { Write-Host "MISS $p" }
}

Write-Host "=== LATEST START LOG ==="
Get-ChildItem "C:\3q-logs" -Filter "service-start-*.log" -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 1 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) ---"
    Get-Content -LiteralPath $_.FullName -Tail 80
  }

Write-Host "=== S1 LOG TAIL ==="
foreach ($f in @(
  "D:\3QVuongGia\data\server_4001\logs\work.log",
  "D:\3QVuongGia\data\server_4001\logs\error.log"
)) {
  if (Test-Path -LiteralPath $f) {
    Write-Host "--- $f ---"
    Get-Content -LiteralPath $f -Tail 60 -Encoding Default
  }
}
