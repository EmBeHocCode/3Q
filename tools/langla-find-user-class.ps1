$root = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server\src\main\java"
Get-ChildItem -LiteralPath $root -Recurse -File -Filter "*.java" |
  Select-String -SimpleMatch "class User" |
  Select-Object Path,LineNumber,Line |
  Format-List
