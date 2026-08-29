$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"

function Start-Capture($name, $workdir, $bat) {
  $log = "C:\Users\Administrator\Desktop\$name-capture.log"
  $runner = "C:\Users\Administrator\Desktop\$name-runner.cmd"
  Set-Content -Encoding ASCII $runner "@echo off`r`ncd /d `"$workdir`"`r`ncall `"$bat`" > `"$log`" 2>&1`r`n"
  Write-Host "START_CAPTURE $name"
  Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$runner`"" -WorkingDirectory $workdir -WindowStyle Minimized
  Start-Sleep -Seconds 35
  Write-Host "TAIL $name"
  if (Test-Path $log) {
    Get-Content $log -Tail 80
  } else {
    Write-Host "NO_LOG $log"
  }
}

Start-Capture "cross" "$root\data\cross_android" "$root\data\cross_android\start.bat"
Start-Capture "s1" "$root\data\server_4001" "$root\data\server_4001\start.bat"

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
