$ErrorActionPreference = "Continue"

$roots = @(
  "C:\xampp\htdocs\langla",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
)

$extensions = @("*.php","*.html","*.css","*.js")

foreach ($root in $roots) {
  if (!(Test-Path -LiteralPath $root)) {
    Write-Host "MISSING_ROOT $root"
    continue
  }

  Write-Host "=== PATCH ROOT $root ==="
  $files = foreach ($ext in $extensions) {
    Get-ChildItem -LiteralPath $root -Recurse -File -Filter $ext -ErrorAction SilentlyContinue
  }

  foreach ($file in $files) {
    $txt = Get-Content -LiteralPath $file.FullName -Raw
    $orig = $txt

    $txt = $txt -replace 'href="/(?!/|langla/|serverlist\.txt|checkpc\.txt|checkandroid\.txt|checkios\.txt)', 'href="/langla/'
    $txt = $txt -replace 'src="/(?!/|langla/)', 'src="/langla/'
    $txt = $txt -replace 'action="/(?!/|langla/)', 'action="/langla/'
    $txt = $txt -replace 'url\(/(?!/|langla/)', 'url(/langla/'
    $txt = $txt -replace "href='../assets/", "href='/langla/assets/"
    $txt = $txt -replace 'href="\.\./assets/', 'href="/langla/assets/'
    $txt = $txt -replace "src='../assets/", "src='/langla/assets/"
    $txt = $txt -replace 'src="\.\./assets/', 'src="/langla/assets/'

    if ($txt -ne $orig) {
      Set-Content -LiteralPath $file.FullName -Value $txt -Encoding UTF8
      Write-Host "PATCHED $($file.FullName)"
    }
  }
}

Write-Host "=== PUBLIC SMOKE ==="
foreach ($url in @(
  "http://127.0.0.1/langla/",
  "http://127.0.0.1/langla/login/",
  "http://127.0.0.1/langla/register/",
  "http://127.0.0.1/langla/images/logo.png",
  "http://127.0.0.1/langla/assets/css/bootstrap.min.css"
)) {
  Write-Host "--- $url"
  try {
    $r = Invoke-WebRequest -UseBasicParsing $url -TimeoutSec 8
    Write-Host "OK status=$($r.StatusCode) len=$($r.RawContentLength)"
  } catch {
    Write-Host "FAIL $($_.Exception.Message)"
  }
}
