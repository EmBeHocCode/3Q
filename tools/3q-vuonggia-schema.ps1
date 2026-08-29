$ErrorActionPreference = "Continue"
cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
& $mysql -uroot -proot -e "use uc_hd; desc t_s_server_list; select * from t_s_server_list limit 1; desc t_s_server_config; select * from t_s_server_config;"
