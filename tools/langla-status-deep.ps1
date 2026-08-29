$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== JAVA LANGLA PROCESSES ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck|LangLa"
} | Select-Object ProcessId,Name,CommandLine | Format-List

Write-Host "=== LISTENING TCP PORTS BY JAVA/MYSQL/HTTP ==="
$tcp = Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue
$procs = @{}
Get-Process | ForEach-Object { $procs[$_.Id] = $_.ProcessName }
$tcp | ForEach-Object {
  [PSCustomObject]@{
    Port = $_.LocalPort
    Address = $_.LocalAddress
    PID = $_.OwningProcess
    Process = $procs[$_.OwningProcess]
  }
} | Where-Object {
  $_.Process -match "java|mysql|httpd|mongod" -or $_.Port -in @(80,3306,27017,14444,19129,19130,8080,8088)
} | Sort-Object Port | Format-Table -AutoSize

Write-Host "=== LANGLA LOGS ==="
foreach ($f in @(
  (Join-Path $logDir "langla-server-run.log"),
  (Join-Path $logDir "langla-server-err.log")
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content $f -Tail 180 } else { Write-Host "MISSING" }
}

Write-Host "=== TARGET LOG FILES UNDER SERVER ==="
Get-ChildItem -LiteralPath $server -Recurse -File -Include *.log,*.txt -ErrorAction SilentlyContinue |
  Where-Object { $_.LastWriteTime -gt (Get-Date).AddHours(-2) } |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 20 FullName,Length,LastWriteTime |
  Format-Table -AutoSize

Write-Host "=== SOURCE PORT FINDSTR ==="
cmd /c "cd /d C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server\src && findstr /S /I /N /C:""ServerSocket"" /C:""InetSocketAddress"" /C:"".bind("" /C:""setPort"" /C:""14444"" /C:""19129"" /C:""19130"" *.java"

Write-Host "=== CLIENT PORT/IP FINDSTR ==="
cmd /c "cd /d C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\Client_LangLaLau && findstr /S /I /N /C:""127.0.0.1"" /C:""localhost"" /C:""104.248"" /C:""14444"" /C:""19129"" /C:""19130"" /C:""port"" ArrayServer.java Server.java arr_server.beatdz 2>NUL"
