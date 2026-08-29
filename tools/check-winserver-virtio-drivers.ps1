$ErrorActionPreference = "Continue"

Write-Host "CHECK_VIRTIO_DRIVERS_BEGIN"

Get-CimInstance Win32_PnPSignedDriver |
  Where-Object {
    $_.DeviceName -match 'VirtIO|Red Hat|QXL|NetKVM|Balloon|VIO|Ethernet|Display' -or
    $_.DriverProviderName -match 'Red Hat|VirtIO'
  } |
  Select-Object DeviceName, DriverProviderName, DriverVersion, InfName |
  Sort-Object DeviceName |
  Format-Table -AutoSize

Write-Host "NETWORK_ADAPTERS"
Get-CimInstance Win32_NetworkAdapter |
  Where-Object { $_.NetEnabled -eq $true -or $_.Name -match 'Intel|VirtIO|Red Hat|Ethernet' } |
  Select-Object Name, Manufacturer, NetEnabled, Speed, AdapterType |
  Format-Table -AutoSize

Write-Host "VIDEO"
Get-CimInstance Win32_VideoController |
  Select-Object Name, AdapterCompatibility, DriverVersion, CurrentHorizontalResolution, CurrentVerticalResolution |
  Format-Table -AutoSize

Write-Host "CHECK_VIRTIO_DRIVERS_DONE"
