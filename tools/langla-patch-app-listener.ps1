$p = "C:\Users\PC\Downloads\LanglaSrc\Client_LangLaLau\src\beatdz\AppListener.java"
$s = Get-Content -Raw -LiteralPath $p
$s = [regex]::Replace(
  $s,
  'public String v = ".*?";',
  'public String v = "id=Lang La\r\nLangLa VPS=100:104.248.157.207:2907:2907|0|131|0|";',
  [System.Text.RegularExpressions.RegexOptions]::Singleline
)
[System.IO.File]::WriteAllText($p, $s, (New-Object System.Text.UTF8Encoding($false)))
Select-String -LiteralPath $p -Pattern "public String v"
