$ErrorActionPreference = "Continue"
$root = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc"
$paths = @(
  "$root\www (2)",
  "$root\www",
  "C:\xampp\htdocs",
  "C:\xampp\htdocs\dashboard"
)

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== WEB ROOT CANDIDATES ==="
foreach ($p in $paths) {
  Write-Host "--- $p ---"
  if (Test-Path $p) {
    Get-ChildItem -LiteralPath $p -Force | Select-Object Mode,Length,LastWriteTime,Name | Format-Table -AutoSize
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== IMPORTANT WEB FILES ==="
Get-ChildItem -LiteralPath "$root\www (2)" -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match "serverlist|logo|BG|check|version|apk|zip|txt|php|html|json" } |
  Select-Object -First 120 FullName,Length,LastWriteTime |
  Format-Table -AutoSize

Write-Host "=== SERVERLIST CONTENTS ==="
Get-ChildItem -LiteralPath "$root\www (2)" -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match "serverlist|server.*txt|check.*txt" } |
  Select-Object -First 20 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) ---"
    Get-Content -LiteralPath $_.FullName -TotalCount 80
  }
