$root = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server\src\main\java"
$files = @(
  "$root\com\sg188\server\Main.java",
  "$root\com\sg188\server\Session.java",
  "$root\com\sg188\server\lib\Client.java",
  "$root\Service\HanderMessage.java",
  "$root\Service\HandleController.java"
)
foreach ($p in $files) {
  Write-Host "=== $p ==="
  if (Test-Path $p) {
    $lines = Get-Content -LiteralPath $p
    for ($i=1; $i -le [Math]::Min($lines.Count,260); $i++) {
      "{0,4}: {1}" -f $i,$lines[$i-1]
    }
  } else {
    Write-Host "MISSING"
  }
}
Write-Host "=== FIND LOGIN MSG ==="
Get-ChildItem -LiteralPath $root -Recurse -File -Filter "*.java" |
  Select-String -Pattern "\-127|\-126|\-113|createSession|login|Login|keyApp|close\(" -CaseSensitive:$false |
  Select-Object -First 260 Path,LineNumber,Line |
  Format-List
