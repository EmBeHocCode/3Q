$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"

Write-Host "=== PRECHECK ==="
foreach ($p in @(
  "$root\1 - GM.bat",
  "$root\data\usercenter_HD\start.bat",
  "$root\data\cross_android\start.bat",
  "$root\data\server_4001\start.bat",
  "$root\apache-tomcat-8.5.40\bin\startup.bat"
)) {
  Write-Host ("{0} => {1}" -f $p, (Test-Path $p))
}

Write-Host "=== EXISTING PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysqld|httpd|phpStudy" } |
  Select-Object Name,ProcessId,CommandLine |
  Format-Table -AutoSize

function Start-BatWindow($title, $path, $workdir) {
  if (!(Test-Path $path)) {
    Write-Host "MISSING $title => $path"
    return
  }
  Write-Host "START $title"
  Start-Process -FilePath "cmd.exe" -ArgumentList "/k title $title && cd /d `"$workdir`" && `"$path`"" -WorkingDirectory $workdir
  Start-Sleep -Seconds 8
}

Start-BatWindow "3Q-GM" "$root\1 - GM.bat" "$root"
Start-BatWindow "3Q-UC" "$root\data\usercenter_HD\start.bat" "$root\data\usercenter_HD"
Start-BatWindow "3Q-CROSS" "$root\data\cross_android\start.bat" "$root\data\cross_android"
Start-BatWindow "3Q-S1" "$root\data\server_4001\start.bat" "$root\data\server_4001"
Start-BatWindow "3Q-WEB" "$root\apache-tomcat-8.5.40\bin\startup.bat" "$root\apache-tomcat-8.5.40\bin"

Write-Host "=== AFTER PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysqld|httpd|phpStudy" } |
  Select-Object Name,ProcessId,CommandLine |
  Format-Table -AutoSize

Write-Host "OK_START_SCRIPT_DONE"
