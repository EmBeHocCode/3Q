$ErrorActionPreference = "Continue"

Write-Host "TRIM_WINSERVER_BEGIN"

Write-Host "MEM_BEFORE"
Get-CimInstance Win32_OperatingSystem |
  Select-Object @{Name="TotalGB";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}},
                @{Name="FreeGB";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}} |
  Format-Table -AutoSize

$servicesToStop = @(
  "Apache2.4",
  "mysql",
  "MySQL",
  "mariadb",
  "WSearch",
  "SysMain",
  "wuauserv",
  "BITS"
)

foreach ($svcName in $servicesToStop) {
  $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
  if ($svc -and $svc.Status -eq "Running") {
    Write-Host ("Stopping service {0}" -f $svcName)
    Stop-Service -Name $svcName -Force -ErrorAction SilentlyContinue
  }
}

$processesToStop = @(
  "httpd",
  "mysqld",
  "mariadbd",
  "jusched",
  "MicrosoftEdgeUpdate",
  "SearchApp",
  "RuntimeBroker",
  "ApplicationFrameHost"
)

foreach ($procName in $processesToStop) {
  $procs = Get-Process -Name $procName -ErrorAction SilentlyContinue
  foreach ($proc in $procs) {
    Write-Host ("Stopping process {0} PID={1}" -f $proc.ProcessName, $proc.Id)
    Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
  }
}

Start-Sleep -Seconds 3

Write-Host "TOP_MEM_AFTER"
Get-Process |
  Sort-Object WorkingSet -Descending |
  Select-Object -First 12 ProcessName,Id,@{Name="MB";Expression={[math]::Round($_.WorkingSet/1MB,1)}},CPU |
  Format-Table -AutoSize

Write-Host "MEM_AFTER"
Get-CimInstance Win32_OperatingSystem |
  Select-Object @{Name="TotalGB";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}},
                @{Name="FreeGB";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}} |
  Format-Table -AutoSize

Write-Host "TRIM_WINSERVER_DONE"
