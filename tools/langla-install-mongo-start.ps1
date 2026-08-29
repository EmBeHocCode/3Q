$ErrorActionPreference = "Continue"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"
$mongoRoot = "C:\tools\mongodb"
$mongoData = "C:\tools\mongodb-data"
$mongoLogDir = "C:\tools\mongodb-log"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
New-Item -ItemType Directory -Force -Path $logDir,$mongoRoot,$mongoData,$mongoLogDir | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== STOP OLD LANGLA JAVA ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck|LangLa"
} | ForEach-Object {
  Write-Host "KILL PID=$($_.ProcessId) CMD=$($_.CommandLine)"
  Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
}

Write-Host "=== INSTALL / START MONGODB ==="
$mongod = Get-ChildItem -Path $mongoRoot -Filter mongod.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
if (-not $mongod) {
  $zip = Join-Path $mongoRoot "mongodb-windows-x86_64-4.4.31.zip"
  $url = "https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-4.4.31.zip"
  if (-not (Test-Path $zip)) {
    Write-Host "Downloading $url"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $url -OutFile $zip
  }
  Write-Host "Extracting MongoDB"
  Expand-Archive -LiteralPath $zip -DestinationPath $mongoRoot -Force
  $mongod = Get-ChildItem -Path $mongoRoot -Filter mongod.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
}
Write-Host "MONGOD=$mongod"
if (-not $mongod) { throw "mongod.exe not found after install" }

$svc = Get-Service -Name "LangLaMongoDB" -ErrorAction SilentlyContinue
if (-not $svc) {
  & $mongod --dbpath $mongoData --bind_ip 127.0.0.1 --port 27017 --logpath (Join-Path $mongoLogDir "mongod.log") --logappend --serviceName "LangLaMongoDB" --serviceDisplayName "LangLa MongoDB" --install
}
Start-Service LangLaMongoDB -ErrorAction SilentlyContinue
Start-Sleep -Seconds 5
Get-Service LangLaMongoDB -ErrorAction SilentlyContinue | Format-List Status,Name,DisplayName

Write-Host "=== PORTS BEFORE LANGLA ==="
cmd /c "netstat -ano -p tcp | findstr /R "":27017 :2907 :3306 :80"""

Write-Host "=== START LANGLA SERVER ==="
$out = Join-Path $logDir "langla-server-run.log"
$err = Join-Path $logDir "langla-server-err.log"
Remove-Item $out,$err -Force -ErrorAction SilentlyContinue
$java = "C:\Program Files\Common Files\Oracle\Java\javapath\java.exe"
$p = Start-Process -FilePath $java -ArgumentList "-server -jar -Dfile.encoding=UTF-8 `"out/artifacts/LangLaZ_jar/LangLaZ.jar`"" -WorkingDirectory $server -RedirectStandardOutput $out -RedirectStandardError $err -PassThru -WindowStyle Hidden
Write-Host "LANGLA_PID=$($p.Id)"
Start-Sleep -Seconds 20

Write-Host "=== PROCESS AFTER 20S ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck|LangLa"
} | Select-Object ProcessId,Name,CommandLine | Format-List

Write-Host "=== PORTS AFTER LANGLA ==="
cmd /c "netstat -ano -p tcp | findstr /R "":27017 :2907 :3306 :80"""

Write-Host "=== LANGLA STDOUT ==="
if (Test-Path $out) { Get-Content $out -Tail 160 }
Write-Host "=== LANGLA STDERR ==="
if (Test-Path $err) { Get-Content $err -Tail 160 }
Write-Host "=== MONGO LOG TAIL ==="
$mlog = Join-Path $mongoLogDir "mongod.log"
if (Test-Path $mlog) { Get-Content $mlog -Tail 50 }
