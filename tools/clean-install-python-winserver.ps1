$ErrorActionPreference = "Continue"

Write-Host "CLEAN_INSTALL_PYTHON_BEGIN"

Write-Host "STOP_STALE_INSTALLERS"
Get-Process |
  Where-Object {
    $_.ProcessName -match '^python-3\.13\.7-amd64' -or
    $_.ProcessName -eq 'msiexec' -or
    ($_.ProcessName -eq 'python' -and $_.Path -like "*Temp*")
  } |
  ForEach-Object {
    Write-Host ("Killing {0} PID={1}" -f $_.ProcessName, $_.Id)
    Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
  }

Start-Sleep -Seconds 5

$installer = "C:\Users\Administrator\Downloads\python-3.13.7-amd64-codex.exe"
$url = "https://www.python.org/ftp/python/3.13.7/python-3.13.7-amd64.exe"
$installDir = "C:\Python313"
$log = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs\python-install.log"

if (-not (Test-Path $installer) -or ((Get-Item $installer).Length -lt 10000000)) {
  Write-Host "DOWNLOAD_INSTALLER"
  Remove-Item -LiteralPath $installer -Force -ErrorAction SilentlyContinue
  & "$env:SystemRoot\System32\curl.exe" -L --fail --retry 3 --connect-timeout 20 -o $installer $url
}

Write-Host "INSTALL_ONCE"
$args = @(
  "/quiet",
  "InstallAllUsers=1",
  "PrependPath=1",
  "Include_launcher=1",
  "InstallLauncherAllUsers=1",
  "Include_pip=1",
  "Include_test=0",
  "Shortcuts=0",
  "TargetDir=$installDir",
  "/log",
  $log
)
$p = Start-Process -FilePath $installer -ArgumentList $args -Wait -PassThru
Write-Host ("EXIT_CODE={0}" -f $p.ExitCode)

Write-Host "VERIFY_DIRECT"
if (Test-Path "$installDir\python.exe") {
  & "$installDir\python.exe" --version
  & "$installDir\python.exe" -m pip --version
}

Write-Host "FIX_MACHINE_PATH"
$machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$paths = $machinePath -split ';' | Where-Object { $_ -and $_.Trim() -ne "" }
foreach ($add in @($installDir, "$installDir\Scripts")) {
  if ($paths -notcontains $add) {
    $paths += $add
  }
}
[Environment]::SetEnvironmentVariable("Path", ($paths -join ';'), "Machine")
$env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")

Write-Host "VERIFY_PATH"
where.exe python
where.exe pip
python --version
pip --version

Write-Host "CLEAN_INSTALL_PYTHON_DONE"
