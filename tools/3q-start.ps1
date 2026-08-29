$ErrorActionPreference = 'Continue'

$outer = 'C:\Users\Administrator\Downloads\3QVuongGia'
$root = 'D:\3QVuongGia'
$logRoot = 'C:\3q-logs'
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'

New-Item -ItemType Directory -Force -Path $logRoot | Out-Null

function Write-Step($msg) {
  $line = "[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $msg
  Write-Output $line
  Add-Content -LiteralPath "$logRoot\3q-start-$stamp.log" -Value $line
}

function Ensure-DDrive {
  if (Test-Path -LiteralPath $root) {
    Write-Step "D: already mapped: $root"
    return
  }

  cmd /c "subst D: /D" 2>$null | Out-Null
  cmd /c "subst D: `"$outer`""
  Start-Sleep -Seconds 1

  if (-not (Test-Path -LiteralPath $root)) {
    throw "Cannot map D: to $outer"
  }

  Write-Step "Mapped D: to $outer"
}

function Test-Port($port) {
  $r = netstat -ano -p tcp | Select-String -Pattern (":$port\s+")
  return [bool]$r
}

function Start-CmdLogged($name, $workDir, $cmdLine) {
  $out = Join-Path $logRoot "$name-$stamp.out.log"
  $err = Join-Path $logRoot "$name-$stamp.err.log"
  Write-Step "Starting $name"
  Start-Process -FilePath 'cmd.exe' -WorkingDirectory $workDir -ArgumentList "/c $cmdLine" -RedirectStandardOutput $out -RedirectStandardError $err -WindowStyle Hidden | Out-Null
}

function Start-MySQL {
  if (Test-Port 3306) { Write-Step "MySQL already listening 3306"; return }
  $exe = Join-Path $root 'phpStudy\MySQL\bin\mysqld.exe'
  $ini = Join-Path $root 'phpStudy\MySQL\my.ini'
  Start-CmdLogged 'mysql' (Split-Path $exe) "`"$exe`" --defaults-file=`"$ini`" --console"
  Start-Sleep -Seconds 8
  if (Test-Port 3306) { Write-Step "MySQL OK 3306" } else { Write-Step "MySQL not listening yet, check log" }
}

function Start-Apache {
  if (Test-Port 81) { Write-Step "Apache/phpStudy already listening 81"; return }
  $exe = Join-Path $root 'phpStudy\Apache\bin\httpd.exe'
  $conf = Join-Path $root 'phpStudy\Apache\conf\httpd.conf'
  Start-CmdLogged 'apache81' (Split-Path $exe) "`"$exe`" -f `"$conf`" -DFOREGROUND"
  Start-Sleep -Seconds 5
  if (Test-Port 81) { Write-Step "Apache/phpStudy OK 81" } else { Write-Step "Apache/phpStudy not listening yet, check log" }
}

function Start-Tomcat7GM {
  if (Test-Port 8080) { Write-Step "Tomcat7 GM already listening 8080"; return }
  $java = Join-Path $root 'Java\jdk1.8.0_121'
  $bin = Join-Path $root 'apache-tomcat-7.0.90\bin'
  $cmd = "set JAVA_HOME=$java&& set JRE_HOME=$java&& set GAME_HOME=$root\tomcat\webapps\&& set TX_CONF_PATH=$root\tomcat\webapps\wolf&& catalina.bat run"
  Start-CmdLogged 'tomcat7-gm' $bin $cmd
  Start-Sleep -Seconds 12
  if (Test-Port 8080) { Write-Step "Tomcat7 GM OK 8080" } else { Write-Step "Tomcat7 GM not listening yet, check log" }
}

function Start-Tomcat8Web {
  if (Test-Port 80) { Write-Step "Tomcat8 web already listening 80"; return }
  $java = Join-Path $root 'Java\jdk1.8.0_121'
  $bin = Join-Path $root 'apache-tomcat-8.5.40\bin'
  $cmd = "set JAVA_HOME=$java&& set JRE_HOME=$java&& catalina.bat run"
  Start-CmdLogged 'tomcat8-web80' $bin $cmd
  Start-Sleep -Seconds 12
  if (Test-Port 80) { Write-Step "Tomcat8 web OK 80" } else { Write-Step "Tomcat8 web not listening yet, check log" }
}

function Start-JavaBatch($name, $dir, $port, $delaySeconds) {
  if (Test-Port $port) { Write-Step "$name already listening $port"; return }
  Start-CmdLogged $name $dir 'start.bat'
  Start-Sleep -Seconds $delaySeconds
  if (Test-Port $port) { Write-Step "$name OK $port" } else { Write-Step "$name not listening yet on $port, check log" }
}

Ensure-DDrive

if (-not (Test-Path -LiteralPath $root)) {
  throw "Game root missing: $root"
}

Start-MySQL
Start-Apache
Start-Tomcat7GM
Start-JavaBatch 'uc9001' "$root\data\usercenter_HD" 9001 12
Start-JavaBatch 'cross8806' "$root\data\cross_android" 8806 15
Start-JavaBatch 's1-6001' "$root\data\server_4001" 6001 20
Start-Tomcat8Web

Write-Step 'Done. Run C:\3q-status.ps1 to verify.'
