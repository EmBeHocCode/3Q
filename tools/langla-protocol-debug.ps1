$client = "C:\Users\PC\Downloads\LanglaSrc\Client_LangLaLau\src"
$files = @(
  "$client\beatdz\RSendMessage.java",
  "$client\beatdz\Session.java",
  "$client\beatdz\mSocket.java",
  "$client\beatdz\LoginPCScreen.java",
  "$client\beatdz\DataCenter.java"
)
foreach ($p in $files) {
  Write-Host "=== $p ==="
  Select-String -LiteralPath $p -Pattern "connect|setServer|portCheck|LOGIN|login|1005|Message|Socket|start|clean|close|IOException|Exception|server.ip|server.port|aP" -CaseSensitive:$false |
    Select-Object -First 120 LineNumber,Line |
    Format-Table -AutoSize
}
