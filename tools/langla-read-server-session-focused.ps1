$root = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server\src\main\java"
$files = @(
  "$root\com\sg188\server\Session.java",
  "$root\Service\HanderMessage.java",
  "$root\com\sg188\server\lib\Client.java"
)
foreach ($p in $files) {
  Write-Host "=== $p ==="
  if (Test-Path $p) {
    $lines = Get-Content -LiteralPath $p
    for ($i=1; $i -le [Math]::Min($lines.Count,420); $i++) {
      "{0,4}: {1}" -f $i,$lines[$i-1]
    }
  }
}
