$ErrorActionPreference = "Stop"

$apk = "E:\SourceGame add\3QVuongGia\3QVuongGia\app\3qdevuong.apk"
$out = "E:\SourceGame add\3QVuongGia\3QVuongGia\app\3qdevuong_104.248.157.207.apk"
$work = "E:\SourceGame add\3QVuongGia\3QVuongGia\app\apk_patch_work"
$unsigned = Join-Path $work "patched-unsigned.apk"
$keystore = Join-Path $work "debug-3q.keystore"
$ip = "104.248.157.207"

if (!(Test-Path -LiteralPath $apk)) {
  throw "APK not found: $apk"
}

Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $work | Out-Null
Remove-Item -LiteralPath $out -Force -ErrorAction SilentlyContinue

Add-Type -AssemblyName System.IO.Compression.FileSystem

$targets = @(
  "assets/TFFramework/Plugins/TFPlugins.lua",
  "assets/lua/logic/login/LoginLayer.lua",
  "assets/lua/uiconfig_mango_new/login/LoginLayer.lua"
)

$tmpFiles = @{}
$replacedReport = @()

$readZip = [IO.Compression.ZipFile]::OpenRead($apk)
try {
  foreach ($name in $targets) {
    $entry = $readZip.GetEntry($name)
    if ($null -eq $entry) {
      $replacedReport += "$name => missing"
      continue
    }

    $stream = $entry.Open()
    $reader = New-Object IO.StreamReader($stream, [Text.Encoding]::UTF8, $true)
    $text = $reader.ReadToEnd()
    $reader.Close()
    $stream.Close()

    $old = $text
    $text = $text -replace "192\.168\.1\.234", $ip
    $text = $text -replace "103\.92\.25\.91", $ip
    $text = $text -replace "103\.90\.225\.183", $ip

    $tmp = Join-Path $work (($name -replace "[/\\:]", "_") + ".patched")
    $utf8NoBom = New-Object Text.UTF8Encoding($false)
    [IO.File]::WriteAllText($tmp, $text, $utf8NoBom)
    $tmpFiles[$name] = $tmp

    $count = ([regex]::Matches($old, "192\.168\.1\.234|103\.92\.25\.91|103\.90\.225\.183")).Count
    $replacedReport += "$name => old-ip-hits=$count"
  }
}
finally {
  $readZip.Dispose()
}

$src = [IO.Compression.ZipFile]::OpenRead($apk)
$dst = [IO.Compression.ZipFile]::Open($unsigned, [IO.Compression.ZipArchiveMode]::Create)
try {
  foreach ($entry in $src.Entries) {
    if ($entry.FullName -like "META-INF/*") { continue }

    $newEntry = $dst.CreateEntry($entry.FullName, [IO.Compression.CompressionLevel]::Optimal)

    if ($tmpFiles.ContainsKey($entry.FullName)) {
      $in = [IO.File]::OpenRead($tmpFiles[$entry.FullName])
    } else {
      $in = $entry.Open()
    }

    try {
      $outStream = $newEntry.Open()
      try { $in.CopyTo($outStream) }
      finally { $outStream.Close() }
    }
    finally { $in.Close() }
  }
}
finally {
  $dst.Dispose()
  $src.Dispose()
}

if (!(Test-Path -LiteralPath $keystore)) {
  & keytool -genkeypair -v `
    -keystore $keystore `
    -storepass android `
    -keypass android `
    -alias androiddebugkey `
    -keyalg RSA `
    -keysize 2048 `
    -validity 10000 `
    -dname "CN=Android Debug,O=Android,C=US" | Out-Host
}

& jarsigner -verbose `
  -sigalg SHA1withRSA `
  -digestalg SHA1 `
  -keystore $keystore `
  -storepass android `
  -keypass android `
  -signedjar $out `
  $unsigned `
  androiddebugkey | Out-Host

Write-Host "=== PATCH REPORT ==="
$replacedReport | ForEach-Object { Write-Host $_ }
Write-Host "OUT=$out"
Get-Item -LiteralPath $out | Select-Object FullName,Length,LastWriteTime | Format-List
