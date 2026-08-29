$ErrorActionPreference = "Continue"
cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"
$patterns = @("103.90.225.183","103.90.224.50","db.password","db.account.password","db.user","db.account.user","ro")
$files = Get-ChildItem "$root\data" -Recurse -File -Include *.properties,*.xml,*.conf,*.txt,*.ini -ErrorAction SilentlyContinue
foreach ($pat in $patterns) {
  Write-Host "=== PATTERN $pat ==="
  $files | Select-String -Pattern $pat -SimpleMatch -ErrorAction SilentlyContinue |
    Select-Object -First 80 |
    ForEach-Object { Write-Host "$($_.Path):$($_.LineNumber): $($_.Line)" }
}

Write-Host "=== MYSQL SERVER CONFIG ==="
$mysql = "$root\phpStudy\MySQL\bin\mysql.exe"
& $mysql -uroot -proot -e "use uc_hd; select * from t_s_server_config limit 20; select * from t_s_server_list limit 20;"
