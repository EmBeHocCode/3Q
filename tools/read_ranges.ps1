$p = $args[0]
$ranges = $args[1..($args.Length-1)]
$lines = Get-Content -LiteralPath $p
foreach ($r in $ranges) {
  $parts = $r.Split("-")
  $start = [int]$parts[0]
  $end = [int]$parts[1]
  Write-Host "=== $p $start-$end ==="
  for ($i=$start; $i -le [Math]::Min($end,$lines.Count); $i++) {
    "{0,4}: {1}" -f $i,$lines[$i-1]
  }
}
