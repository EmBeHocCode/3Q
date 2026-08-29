$ErrorActionPreference = "Stop"

$configs = @(
  "C:\xampp\htdocs\langla\in\config.php",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)\in\config.php"
)

foreach ($config in $configs) {
  if (!(Test-Path -LiteralPath $config)) {
    Write-Host "MISSING $config"
    continue
  }

  $txt = Get-Content -LiteralPath $config -Raw
  if ($txt -notmatch "error_reporting") {
    $txt = $txt -replace "<\?php", "<?php`r`nerror_reporting(E_ALL & ~E_WARNING & ~E_NOTICE & ~E_DEPRECATED);`r`nini_set('display_errors', '0');"
  }
  $txt = $txt -replace '\$passDB\s*=\s*"[^"]*";', '$passDB = "";'
  Set-Content -LiteralPath $config -Value $txt -Encoding UTF8
  Write-Host "UPDATED $config"
  Select-String -LiteralPath $config -Pattern "error_reporting|display_errors|userDB|passDB|DBase|new mysqli" |
    Select-Object LineNumber,Line |
    Format-Table -AutoSize
}

Write-Host "=== HTTP TEST ==="
$urls = @(
  "http://127.0.0.1/langla/",
  "http://127.0.0.1/langla/register/",
  "http://127.0.0.1/langla/login/"
)
foreach ($u in $urls) {
  Write-Host "--- $u"
  try {
    $r = Invoke-WebRequest -UseBasicParsing $u -TimeoutSec 8
    Write-Host "OK status=$($r.StatusCode) len=$($r.RawContentLength)"
    (($r.Content -split "`n") | Select-Object -First 8) -join "`n"
  } catch {
    Write-Host "FAIL $($_.Exception.Message)"
    if ($_.Exception.Response) {
      $sr = New-Object IO.StreamReader($_.Exception.Response.GetResponseStream())
      ($sr.ReadToEnd() -split "`n" | Select-Object -First 8) -join "`n"
    }
  }
}
