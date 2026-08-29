$ErrorActionPreference = "Continue"
$content = "id=Lang La`r`nLangLa VPS=100:104.248.157.207:2907:2907|0|131|0|`r`n"
[System.IO.File]::WriteAllText("C:\xampp\htdocs\serverlist.txt", $content, [System.Text.Encoding]::ASCII)
Get-Content -LiteralPath "C:\xampp\htdocs\serverlist.txt"
