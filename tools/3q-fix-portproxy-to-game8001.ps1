$ErrorActionPreference = "Continue"

cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== BEFORE PORTPROXY ==="
netsh interface portproxy show all

Write-Host "=== FIX 6001 -> 8001 ==="
netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=6001
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=6001 connectaddress=127.0.0.1 connectport=8001

Write-Host "=== FIREWALL 6001 ==="
netsh advfirewall firewall add rule name="3Q S1 proxy 6001" dir=in action=allow protocol=TCP localport=6001

Write-Host "=== AFTER PORTPROXY ==="
netsh interface portproxy show all

Write-Host "=== LISTEN PORTS ==="
netstat -ano -p tcp | Select-String ":6001 |:8001 |:14001 " | ForEach-Object { $_.Line }

Write-Host "=== DONE ==="
