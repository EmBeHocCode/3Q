$ErrorActionPreference = "Continue"

$root = "C:\xampp\htdocs"
$langla = "C:\xampp\htdocs\langla"

foreach ($name in @("logo-main.png", "BG.jpg")) {
  Write-Host "=== $name ==="
  $target = Join-Path $langla $name
  if (Test-Path -LiteralPath $target) {
    Write-Host "EXISTS target $target"
    Get-Item -LiteralPath $target | Select-Object FullName,Length,LastWriteTime | Format-List
    continue
  }

  $found = Get-ChildItem -LiteralPath $root -Recurse -File -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -ieq $name } |
    Select-Object -First 1

  if ($found) {
    Copy-Item -LiteralPath $found.FullName -Destination $target -Force
    Write-Host "COPIED $($found.FullName) -> $target"
    Get-Item -LiteralPath $target | Select-Object FullName,Length,LastWriteTime | Format-List
  } else {
    Write-Host "NOT_FOUND $name"
  }
}

Write-Host "=== HTTP ==="
foreach ($url in @(
  "http://127.0.0.1/langla/serverlist.txt",
  "http://127.0.0.1/langla/logo-main.png",
  "http://127.0.0.1/langla/BG.jpg"
)) {
  Write-Host "--- $url"
  try {
    $r = Invoke-WebRequest -UseBasicParsing $url -TimeoutSec 5
    Write-Host "OK status=$($r.StatusCode) len=$($r.RawContentLength)"
  } catch {
    Write-Host "FAIL $($_.Exception.Message)"
  }
}
