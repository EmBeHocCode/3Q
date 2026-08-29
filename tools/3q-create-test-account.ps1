$ErrorActionPreference = "Stop"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
$user = "meowad"
$pass = "123321"
$email = "$user@email.com"

$sql = @"
insert into nap_card_new.users
  (user_name,password,email,role_id,point,password_game,need_login)
values
  ('$user','$pass','$email',1,0,'$pass',0)
on duplicate key update
  password='$pass',
  password_game='$pass',
  email='$email',
  role_id=1,
  need_login=0;
select user_id,user_name,password_game,role_id,point,need_login from nap_card_new.users where user_name='$user';
"@

Write-Host "=== UPSERT ACCOUNT ==="
& $mysql -uroot -proot -e $sql

Write-Host "=== LOGIN PHP TEST ==="
$u = "http://127.0.0.1/login/login.php?userName=$user&password=$pass&version=1.1.5"
$r = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 8
Write-Host "HTTP $($r.StatusCode)"
Write-Host $r.Content
