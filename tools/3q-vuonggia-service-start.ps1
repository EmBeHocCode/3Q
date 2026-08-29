$ErrorActionPreference = "Continue"

$outer = "C:\Users\Administrator\Downloads\3QVuongGia"
$root = "D:\3QVuongGia"
$runDir = "C:\3q-run"
$logRoot = "C:\3q-logs"
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"

New-Item -ItemType Directory -Force -Path $runDir,$logRoot | Out-Null
$mainLog = Join-Path $logRoot "service-start-$stamp.log"

function Log($message) {
  $line = "[{0}] {1}" -f (Get-Date -Format "HH:mm:ss"), $message
  Write-Host $line
  Add-Content -LiteralPath $mainLog -Encoding UTF8 -Value $line
}

function Ensure-DDrive {
  if (Test-Path -LiteralPath $root) {
    Log "D: OK => $root"
    return
  }

  cmd /c "subst D: /D" 2>$null | Out-Null
  cmd /c "subst D: `"$outer`"" | Out-Null
  Start-Sleep -Seconds 1

  if (Test-Path -LiteralPath $root) {
    Log "Mapped D: => $outer"
  } else {
    throw "Cannot map D: to $outer"
  }
}

function Test-Listen($port) {
  return [bool](netstat -ano -p tcp | Select-String -Pattern (":$port\s+.*LISTENING"))
}

function Start-Wrapped($name, $workDir, $commandLine, $primaryPort, $waitSeconds) {
  if ($primaryPort -and (Test-Listen $primaryPort)) {
    Log "$name already listening on $primaryPort"
    return
  }

  $wrapper = Join-Path $runDir "$name.cmd"
  $out = Join-Path $logRoot "$name-$stamp.out.log"
  $err = Join-Path $logRoot "$name-$stamp.err.log"

  Set-Content -LiteralPath $wrapper -Encoding ASCII -Value @"
@echo off
cd /d "$workDir"
$commandLine >> "$out" 2>> "$err"
"@

  Log "Starting $name"
  Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$wrapper`"" -WorkingDirectory $workDir -WindowStyle Hidden | Out-Null
  Start-Sleep -Seconds $waitSeconds

  if ($primaryPort) {
    if (Test-Listen $primaryPort) { Log "$name OK port $primaryPort" }
    else { Log "$name not listening on $primaryPort yet" }
  }
}

Ensure-DDrive

Start-Wrapped "mysql3306" "$root\phpStudy\MySQL\bin" "`"$root\phpStudy\MySQL\bin\mysqld.exe`" --defaults-file=`"$root\phpStudy\MySQL\my.ini`" --console" 3306 8
Start-Wrapped "apache80" "$root\phpStudy\Apache\bin" "`"$root\phpStudy\Apache\bin\httpd.exe`" -d `"$root\phpStudy\Apache`"" 80 5
Start-Wrapped "gm8080" "$root" "`"$root\1 - GM.bat`"" 8080 18
Start-Wrapped "uc9001" "$root\data\usercenter_HD" "`"$root\data\usercenter_HD\start.bat`"" 9001 25
Start-Wrapped "cross20004" "$root\data\cross_android" "`"$root\data\cross_android\start.bat`"" 20004 60
Start-Wrapped "s114001" "$root\data\server_4001" "`"$root\data\server_4001\start.bat`"" 14001 90

Log "Done start request"
cmd /c subst | Add-Content -LiteralPath $mainLog -Encoding UTF8
netstat -ano -p tcp | Select-String -Pattern ":(80|8080|9001|14001|20004|3306)\s+.*LISTENING" | ForEach-Object {
  Add-Content -LiteralPath $mainLog -Encoding UTF8 -Value $_.Line
}

