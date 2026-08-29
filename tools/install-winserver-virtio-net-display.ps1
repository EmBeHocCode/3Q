$ErrorActionPreference = "Continue"

Write-Host "INSTALL_VIRTIO_NET_DISPLAY_BEGIN"

$drives = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty Root
$virtioRoot = $null
foreach ($root in $drives) {
  if (Test-Path (Join-Path $root "NetKVM")) {
    $virtioRoot = $root
    break
  }
}

if (-not $virtioRoot) {
  Write-Host "VIRTIO_ISO_NOT_FOUND"
  Get-PSDrive -PSProvider FileSystem | Format-Table -AutoSize
  exit 1
}

Write-Host ("VIRTIO_ROOT={0}" -f $virtioRoot)

$candidateDirs = @(
  "NetKVM\2k22\amd64",
  "NetKVM\w10\amd64",
  "NetKVM\w11\amd64",
  "qxldod\2k22\amd64",
  "qxldod\w10\amd64",
  "qxldod\w11\amd64",
  "Balloon\2k22\amd64",
  "Balloon\w10\amd64"
)

foreach ($rel in $candidateDirs) {
  $dir = Join-Path $virtioRoot $rel
  if (Test-Path $dir) {
    Write-Host ("ADDING_DRIVER_DIR={0}" -f $dir)
    pnputil /add-driver (Join-Path $dir "*.inf") /install
  } else {
    Write-Host ("MISSING_DRIVER_DIR={0}" -f $dir)
  }
}

Write-Host "DRIVERS_AFTER"
Get-CimInstance Win32_PnPSignedDriver |
  Where-Object {
    $_.DeviceName -match 'VirtIO|Red Hat|QXL|NetKVM|Balloon|Ethernet|Display' -or
    $_.DriverProviderName -match 'Red Hat|VirtIO'
  } |
  Select-Object DeviceName, DriverProviderName, DriverVersion, InfName |
  Sort-Object DeviceName |
  Format-Table -AutoSize

Write-Host "INSTALL_VIRTIO_NET_DISPLAY_DONE"
