$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$files = @(
  "src\main\java\SqlConnection\MongoDbConnection.java",
  "src\main\java\com\sg188\clan\ClanDAO.java",
  "src\main\java\com\sg188\server\Config.java",
  "src\main\java\com\sg188\server\Main.java"
)
foreach ($rel in $files) {
  $p = Join-Path $server $rel
  Write-Host "=== FILE $rel ==="
  if (Test-Path $p) {
    $lines = Get-Content -LiteralPath $p
    for ($i=1; $i -le $lines.Count; $i++) {
      if ($i -le 220) { "{0,4}: {1}" -f $i,$lines[$i-1] }
    }
  } else {
    Write-Host "MISSING $p"
  }
}

Write-Host "=== INSTALLED MONGO SEARCH QUICK ==="
cmd /c "where mongod"
cmd /c "where mongosh"
cmd /c "dir /s /b C:\mongod.exe C:\mongosh.exe C:\mongo.exe 2>NUL"
