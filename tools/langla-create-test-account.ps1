$ErrorActionPreference = "Continue"
$mysql = "C:\xampp\mysql\bin\mysql.exe"
$sql = @'
INSERT INTO users
(username,password,password2,QuantityChar,ArrSubName,isAdmin,luong,nap,otp,`lock`,total,tongthang,coin,activated,status,sodienthoai,admin_web,online,timeLogin,last_attendance_at,ip_address,role,amount_unpaid,level,passc2admin,ip,tokenlog,createkich,createtime,ip_web,topsm,is_daily)
SELECT
'gamepro2','1234567890','1234567890',0,'[]',0,0,0,'',0,0,0,0,0,0,'',0,0,0,NULL,'',0,0,0,'','','',0,NOW(),'',0,0
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username='gamepro2');
UPDATE users SET password='1234567890', password2='1234567890', QuantityChar=0, ArrSubName='[]', `lock`=0, activated=0 WHERE username='gamepro2';
SELECT id,username,password,QuantityChar,`lock`,activated FROM users WHERE username='gamepro2';
'@
$tmp = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs\langla-create-test-account.sql"
[System.IO.File]::WriteAllText($tmp, $sql, [System.Text.Encoding]::ASCII)
& $mysql -uroot langla --default-character-set=utf8mb4 -e "source $tmp"
