$ErrorActionPreference = "Continue"

$urls = @(
  "http://104.248.157.207:82/langla/",
  "http://104.248.157.207:82/langla/register/",
  "http://104.248.157.207:82/langla/login/",
  "http://104.248.157.207:82/langla/serverlist.txt",
  "http://104.248.157.207:82/langla/checkpc.txt"
)

foreach ($u in $urls) {
  Write-Host "--- $u"
  try {
    $r = Invoke-WebRequest -UseBasicParsing $u -TimeoutSec 10
    Write-Host "OK status=$($r.StatusCode) len=$($r.RawContentLength)"
    if ($r.Content -match "Warning|Fatal error|Notice|Undefined|Failed") {
      Write-Host "HAS_ERROR_TEXT"
      ($r.Content -split "`n" | Select-String -Pattern "Warning|Fatal error|Notice|Undefined|Failed" | Select-Object -First 5) | ForEach-Object { $_.Line }
    } else {
      Write-Host "NO_ERROR_TEXT"
    }
  } catch {
    Write-Host "FAIL $($_.Exception.Message)"
  }
}
