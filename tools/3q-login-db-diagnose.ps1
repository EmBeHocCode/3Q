$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
Write-Host "=== MYSQL EXISTS ==="
Test-Path $mysql

Write-Host "=== DATABASES ==="
& $mysql -uroot -proot -e "show databases;" 2>&1

Write-Host "=== USERS TABLE SCHEMA ==="
& $mysql -uroot -proot -e "show create table nap_card_new.users\G" 2>&1

Write-Host "=== CHECK ACCOUNT meowad ==="
& $mysql -uroot -proot -e "select * from nap_card_new.users where user_name='meowad'\G" 2>&1

Write-Host "=== API ROUTE FILES ==="
Get-ChildItem "D:\3QVuongGia\www" -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match "\.php$|\.htaccess$|route|User|user" } |
  Select-String -Pattern "api/user/register|function.*register|register|user_name|password_game" -ErrorAction SilentlyContinue |
  Select-Object -First 80 Path,LineNumber,Line |
  Format-Table -AutoSize

Write-Host "=== LOGIN PHP TEST EXISTING / NEW ==="
$urls = @(
  "http://127.0.0.1/login/login.php?userName=meowad&password=123321&version=1.1.5",
  "http://127.0.0.1/login/login.php?userName=codextest&password=123321&version=1.1.5"
)
foreach ($u in $urls) {
  Write-Host "--- $u ---"
  try {
    $r = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 8
    Write-Host "HTTP $($r.StatusCode)"
    Write-Host $r.Content
  } catch {
    Write-Host "ERROR $($_.Exception.Message)"
  }
}
