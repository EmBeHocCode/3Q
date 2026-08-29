$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null

Write-Host "=== STATUS ==="
if (Test-Path "C:\Users\Administrator\Desktop\3q-status.ps1") {
  & "C:\Users\Administrator\Desktop\3q-status.ps1"
} else {
  Write-Host "missing Desktop\3q-status.ps1"
}

Write-Host "=== LATEST C:\3q-logs ==="
if (Test-Path "C:\3q-logs") {
  Get-ChildItem "C:\3q-logs" -File |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 20 Name,Length,LastWriteTime |
    Format-Table -AutoSize

  Write-Host "=== ERROR LOG TAILS ==="
  Get-ChildItem "C:\3q-logs" -File -Filter "*.err.log" |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 8 |
    ForEach-Object {
      Write-Host "--- $($_.FullName) ---"
      Get-Content -LiteralPath $_.FullName -Tail 50 -ErrorAction SilentlyContinue
    }

  Write-Host "=== OUTPUT LOG ERROR LINES ==="
  Get-ChildItem "C:\3q-logs" -File -Filter "*.out.log" |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 8 |
    ForEach-Object {
      Write-Host "--- $($_.FullName) ---"
      Select-String -LiteralPath $_.FullName -Pattern "Exception|ERROR|Error|Caused by|Bind|refused|denied|failed|Failed|NumberFormat|Unknown|Access denied|Communications link" -ErrorAction SilentlyContinue |
        Select-Object -Last 25 |
        ForEach-Object { Write-Host $_.Line }
      Write-Host "--- tail ---"
      Get-Content -LiteralPath $_.FullName -Tail 30 -ErrorAction SilentlyContinue
    }
} else {
  Write-Host "C:\3q-logs missing"
}

