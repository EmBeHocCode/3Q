$ErrorActionPreference = "Continue"

cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

$root = "D:\3QVuongGia"
$logRoot = "C:\3q-logs"
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
New-Item -ItemType Directory -Force -Path $logRoot | Out-Null

function Test-Listen($port) {
  return [bool](Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue)
}

function Start-Cmd($name, $workDir, $batPath) {
  Write-Host "START $name"
  $out = Join-Path $logRoot "$name-restore-$stamp.out.log"
  $err = Join-Path $logRoot "$name-restore-$stamp.err.log"
  $wrapper = Join-Path $logRoot "$name-restore-$stamp.cmd"
  Set-Content -LiteralPath $wrapper -Encoding ASCII -Value @"
@echo off
cd /d "$workDir"
"$batPath" >> "$out" 2>> "$err"
"@
  Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$wrapper`"" -WorkingDirectory $workDir -WindowStyle Hidden | Out-Null
}

Write-Host "=== BEFORE PORTS ==="
Get-NetTCPConnection -LocalPort 80,3306,6001,8001,9001,14001,20004 -State Listen -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Sort-Object LocalPort |
  Format-Table -AutoSize

if (!(Test-Listen 20004)) {
  Start-Cmd "cross20004" "$root\data\cross_android" "$root\data\cross_android\start.bat"
  Start-Sleep -Seconds 75
}

if (!(Test-Listen 8001) -or !(Test-Listen 14001)) {
  Start-Cmd "s1" "$root\data\server_4001" "$root\data\server_4001\start.bat"
}

Write-Host "=== WAIT PORTS ==="
$need = @(80,3306,6001,8001,9001,14001,20004)
$deadline = (Get-Date).AddSeconds(160)
while ((Get-Date) -lt $deadline) {
  $open = @()
  foreach ($port in $need) {
    if (Test-Listen $port) { $open += $port }
  }
  Write-Host ("OPEN: " + (($open | Sort-Object) -join ","))
  if (($need | Where-Object { $_ -notin $open }).Count -eq 0) { break }
  Start-Sleep -Seconds 10
}

Write-Host "=== AFTER PORTS ==="
Get-NetTCPConnection -LocalPort 80,3306,6001,8001,9001,14001,20004 -State Listen -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Sort-Object LocalPort |
  Format-Table -AutoSize

Write-Host "=== JAVA GAME ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -eq "java.exe" -and $_.CommandLine -like "*D:\3QVuongGia*" } |
  Select-Object ProcessId,CommandLine |
  Format-List
