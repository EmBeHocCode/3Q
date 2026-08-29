$ErrorActionPreference = "Continue"
Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== PROCESSES ==="
Get-Process | Where-Object { $_.ProcessName -match "powershell|msiexec|mongod|java|xampp|mysql|httpd" } |
  Select-Object Id,ProcessName,CPU,WorkingSet64 | Sort-Object ProcessName,Id | Format-Table -AutoSize

Write-Host "=== PORTS ==="
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { $_.LocalPort -in @(80,3306,27017,2907) } |
  Sort-Object LocalPort |
  Format-Table -AutoSize LocalAddress,LocalPort,OwningProcess

Write-Host "=== MONGO FILES ==="
foreach ($p in @("C:\tools\mongodb","C:\tools\mongodb-data","C:\tools\mongodb-log","C:\Program Files\MongoDB")) {
  Write-Host "--- $p ---"
  if (Test-Path $p) {
    Get-ChildItem -LiteralPath $p -Recurse -ErrorAction SilentlyContinue |
      Where-Object { $_.Name -match "mongod.exe|mongosh.exe|mongo.exe|\.zip$|\.msi$|mongod.log" } |
      Select-Object -First 40 FullName,Length,LastWriteTime |
      Format-Table -AutoSize
  } else { Write-Host "MISSING" }
}

Write-Host "=== SERVICES ==="
Get-Service | Where-Object { $_.Name -match "mongo|mysql|apache|xampp|LangLa" -or $_.DisplayName -match "mongo|mysql|apache|xampp|LangLa" } |
  Select-Object Status,Name,DisplayName | Format-Table -AutoSize
