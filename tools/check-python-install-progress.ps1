$ErrorActionPreference = "Continue"

Write-Host "PY_PROGRESS"
Get-Process |
  Where-Object { $_.ProcessName -match 'python|msiexec|installer|curl' } |
  Select-Object ProcessName,Id,CPU,@{Name="MB";Expression={[math]::Round($_.WorkingSet/1MB,1)}} |
  Format-Table -AutoSize

Write-Host "FILES"
Get-Item "C:\Users\Administrator\Downloads\python-3.13.7-amd64-codex.exe","C:\Python313\python.exe" -ErrorAction SilentlyContinue |
  Select-Object FullName,Length,LastWriteTime |
  Format-Table -AutoSize

Write-Host "COMMANDS"
where.exe python
where.exe py
if (Test-Path "C:\Python313\python.exe") { & "C:\Python313\python.exe" --version }
