$ErrorActionPreference = "Continue"
cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"

function Start-JavaBg($name, $workdir, $args) {
  $log = "C:\Users\Administrator\Desktop\$name.log"
  $bat = "C:\Users\Administrator\Desktop\run-$name.cmd"
  $java = "$root\Java\jdk1.8.0_121\bin\java.exe"
  Set-Content -Encoding ASCII $bat "@echo off`r`ncd /d `"$workdir`"`r`n`"$java`" $args > `"$log`" 2>&1`r`n"
  Write-Host "START $name"
  Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$bat`"" -WorkingDirectory $workdir -WindowStyle Minimized
  Start-Sleep -Seconds 15
  if (Test-Path $log) {
    Write-Host "TAIL $name"
    Get-Content $log -Tail 30
  }
}

$common = '-Xms1048m -Xmn512m -Xss256k -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./oom.hprof -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:GCPauseIntervalMillis=200 -XX:SurvivorRatio=6 -Xloggc:logs/gc.log -classpath "./;../Jar/lib/*;./config;../Jar/framework/*;./app/gameserver/*" com.playmore.net.netty.context.SpringContextLoader'

Start-JavaBg "3q-cross" "$root\data\cross_android" $common
Start-JavaBg "3q-s1" "$root\data\server_4001" $common

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
