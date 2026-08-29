$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"

function Start-OriginalBat($name, $bat, $workdir) {
  if (!(Test-Path $bat)) {
    Write-Host "MISSING $name => $bat"
    return
  }
  Write-Host "START_ORIGINAL $name"
  Start-Process -FilePath "cmd.exe" -ArgumentList "/k `"$bat`"" -WorkingDirectory $workdir
  Start-Sleep -Seconds 20
}

Start-OriginalBat "3Q-CROSS" "$root\3 - Cross.lnk" "$root"
Start-OriginalBat "3Q-S1" "$root\4 - S1.lnk" "$root"
Start-OriginalBat "3Q-WEB" "$root\99.Web.lnk" "$root"

Write-Host "=== PROCESS/PORT ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysqld|httpd|phpStudy" } |
  Select-Object Name,ProcessId,CommandLine |
  Format-Table -AutoSize

Get-NetTCPConnection -State Listen |
  Where-Object { @(80,81,8080,8088,9001,6001,8001,8806,14001,20004,23701,23702,23703,23799) -contains $_.LocalPort } |
  Sort-Object LocalPort |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Format-Table -AutoSize
