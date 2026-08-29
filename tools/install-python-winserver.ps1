$ErrorActionPreference = "Stop"

Write-Host "INSTALL_PYTHON_BEGIN"

$installDir = "C:\Python313"
$installer = "C:\Users\Administrator\Downloads\python-3.13.7-amd64-codex.exe"
$url = "https://www.python.org/ftp/python/3.13.7/python-3.13.7-amd64.exe"

Write-Host "CHECK_EXISTING"
$existing = Get-Command python -ErrorAction SilentlyContinue
if ($existing) {
  python --version
  Write-Host "PYTHON_ALREADY_IN_PATH"
  exit 0
}

Get-Process curl, "python-3.13.7-amd64", "python-3.13.7-amd64-codex" -ErrorAction SilentlyContinue |
  Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "DOWNLOAD_INSTALLER"
if ((Test-Path $installer) -and ((Get-Item $installer).Length -lt 1000000)) {
  Remove-Item -LiteralPath $installer -Force
}
if (-not (Test-Path $installer)) {
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  $curl = "$env:SystemRoot\System32\curl.exe"
  if (Test-Path $curl) {
    & $curl -L --fail --retry 3 --connect-timeout 20 -o $installer $url
  } else {
    Invoke-WebRequest -Uri $url -OutFile $installer -UseBasicParsing
  }
}

if (-not (Test-Path $installer) -or ((Get-Item $installer).Length -lt 10000000)) {
  throw "Installer download failed or too small: $installer"
}

Write-Host "RUN_INSTALLER"
$args = @(
  "/quiet",
  "InstallAllUsers=1",
  "PrependPath=1",
  "Include_test=0",
  "TargetDir=$installDir"
)
$p = Start-Process -FilePath $installer -ArgumentList $args -Wait -PassThru
Write-Host ("INSTALLER_EXIT={0}" -f $p.ExitCode)
if ($p.ExitCode -ne 0) {
  throw "Python installer failed with exit code $($p.ExitCode)"
}

Write-Host "REFRESH_PATH"
$machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$env:Path = "$machinePath;$userPath"

Write-Host "VERIFY"
& "$installDir\python.exe" --version
& "$installDir\python.exe" -m pip --version

Write-Host "PATH_VERIFY"
where.exe python
python --version

Write-Host "INSTALL_PYTHON_DONE"
