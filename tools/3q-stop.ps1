$ErrorActionPreference = 'Continue'
$rootLike = 'D:\3QVuongGia'
$logRoot = 'C:\3q-logs'
New-Item -ItemType Directory -Force -Path $logRoot | Out-Null

Get-CimInstance Win32_Process |
  Where-Object {
    $_.CommandLine -and (
      $_.CommandLine -like "*$rootLike*" -or
      $_.CommandLine -like '*apache-tomcat-7.0.90*' -or
      $_.CommandLine -like '*apache-tomcat-8.5.40*' -or
      $_.CommandLine -like '*phpStudy*'
    )
  } |
  ForEach-Object {
    "{0} {1}" -f $_.ProcessId, $_.CommandLine | Add-Content -LiteralPath "$logRoot\3q-stop.log"
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
  }

Start-Sleep -Seconds 3
Write-Output '3Q stop requested.'
