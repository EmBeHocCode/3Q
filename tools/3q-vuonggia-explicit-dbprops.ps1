$ErrorActionPreference = "Stop"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"
$ts = Get-Date -Format "yyyyMMdd-HHmmss"

function Ensure-Prop($file, $key, $value) {
  $lines = @(Get-Content $file)
  $found = $false
  $out = foreach ($line in $lines) {
    if ($line -match ("^\s*" + [regex]::Escape($key) + "\s*=")) {
      $found = $true
      "$key=$value"
    } else {
      $line
    }
  }
  if (-not $found) {
    $out += "$key=$value"
  }
  Set-Content -Encoding UTF8 $file $out
}

$targets = @(
  @{Dir="$root\data\cross_android\config"; GameDb="cross_android"; StaticDb="cross_android_data"},
  @{Dir="$root\data\server_4001\config"; GameDb="server_4001"; StaticDb="server_android_data_3k"}
)

foreach ($t in $targets) {
  $file = Join-Path $t.Dir "db.properties"
  Copy-Item $file "$file.bak.explicit.$ts" -Force
  Ensure-Prop $file "game.jdbcUrl" "jdbc:mysql://127.0.0.1:3306/$($t.GameDb)?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&useServerPrepStmts=true&rewriteBatchedStatements=true&allowMultiQueries=true"
  Ensure-Prop $file "game.username" "root"
  Ensure-Prop $file "game.password" "root"
  Ensure-Prop $file "static.bonecp.jdbcUrl" "jdbc:mysql://127.0.0.1:3306/$($t.StaticDb)?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8&useServerPrepStmts=true&rewriteBatchedStatements=true&allowMultiQueries=true"
  Ensure-Prop $file "static.bonecp.username" "root"
  Ensure-Prop $file "static.bonecp.password" "root"
  Write-Host "patched $file"
  Select-String -Path $file -Pattern "game\.jdbcUrl|game\.username|game\.password|static\.bonecp\.jdbcUrl|static\.bonecp\.username|static\.bonecp\.password" | ForEach-Object { Write-Host $_.Line }
}

Write-Host "OK_DBPROPS_PATCHED"
