<?php
/**
 * Rebalance recharge-event hero packs and normalize display assets.
 *
 * Usage:
 *   php rebalance_pay_event_rewards_20260811.php --config=/opt/3q-test/home/web/api/config.php
 *   php rebalance_pay_event_rewards_20260811.php --config=/opt/3q-test/home/web/api/config.php --apply
 *   php rebalance_pay_event_rewards_20260811.php --config=/opt/3q-test/home/web/api/config.php --apply --reset-pay-claims
 */

$apply = in_array('--apply', $argv, true);
$resetPayClaims = in_array('--reset-pay-claims', $argv, true);
$configPath = dirname(__DIR__) . '/home/web/api/config.php';
foreach ($argv as $arg) {
  if (strpos($arg, '--config=') === 0) $configPath = substr($arg, 9);
}

if (!is_file($configPath)) {
  fwrite(STDERR, "Config not found: {$configPath}\n");
  exit(1);
}

require $configPath;

$pdo = new PDO(
  'mysql:host=' . MYSQL_HOST . ';dbname=WEB;charset=utf8mb4',
  MYSQL_USER,
  MYSQL_PWD,
  array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION)
);

$packIds = array('3:400022', '3:400023', '3:500054', '3:500077', '3:500095', '3:500053');

$fallbackMeta = array(
  '3:400022' => array('name' => 'Gói ngẫu nhiên tướng Tam Điện', 'icon' => '10077', 'quality' => 5),
  '3:400023' => array('name' => 'Gói ngẫu nhiên tướng Âm-Dương', 'icon' => '10077', 'quality' => 5),
  '3:500054' => array('name' => 'Gói tự chọn anh hùng Tam Quốc', 'icon' => '10077', 'quality' => 5),
  '3:500077' => array('name' => 'Gói tự chọn anh hùng Tam Quốc', 'icon' => '50043', 'quality' => 5),
  '3:500095' => array('name' => 'Tam tộc anh hùng tự do', 'icon' => '10077', 'quality' => 5),
  '3:500053' => array('name' => 'Gói chọn anh hùng Thánh-Thần', 'icon' => '50029', 'quality' => 5),
);

function catalogPathFromConfig($configPath) {
  $apiDir = dirname($configPath);
  return dirname($apiDir) . '/tool/data/item-catalog.json';
}

function loadCatalogMeta($configPath, $fallbackMeta) {
  $catalog = $fallbackMeta;
  $path = catalogPathFromConfig($configPath);
  if (!is_file($path)) return $catalog;
  $raw = json_decode(file_get_contents($path), true);
  if (!is_array($raw) || empty($raw['items'])) return $catalog;

  foreach ($raw['items'] as $item) {
    if (empty($item['reward'])) continue;
    $catalog[(string)$item['reward']] = array(
      'name' => (string)($item['name'] ?? $item['reward']),
      'icon' => (string)($item['icon'] ?? ''),
      'quality' => (int)($item['quality'] ?? 0),
      'description' => (string)($item['description'] ?? ''),
    );
  }
  return $catalog;
}

function targetPayPacks($type, $need) {
  $need = (int)$need;
  $t = array();

  if ($type === 'pay_day') {
    if ($need >= 100000) $t['3:400022'] = 1;
    if ($need >= 500000) $t['3:400023'] = 1;
    if ($need >= 1000000) $t['3:500095'] = 1;
    if ($need >= 2000000) $t['3:500054'] = 1;
    if ($need >= 3000000) $t['3:500077'] = 1;
    if ($need >= 5000000) $t['3:400022'] = 2;
    if ($need >= 10000000) {
      $t['3:400023'] = 2;
      $t['3:500095'] = 2;
      $t['3:500053'] = 1;
    }
    return $t;
  }

  if ($type === 'pay_week') {
    if ($need >= 100000) $t['3:400022'] = 1;
    if ($need >= 500000) $t['3:400023'] = 1;
    if ($need >= 1000000) $t['3:500095'] = 1;
    if ($need >= 2000000) $t['3:500054'] = 1;
    if ($need >= 5000000) $t['3:500077'] = 1;
    if ($need >= 10000000) $t['3:500053'] = 1;
    if ($need >= 20000000) {
      $t['3:400022'] = 2;
      $t['3:400023'] = 2;
      $t['3:500054'] = 2;
    }
    if ($need >= 50000000) {
      $t['3:400022'] = 3;
      $t['3:400023'] = 3;
      $t['3:500095'] = 2;
      $t['3:500077'] = 2;
    }
    return $t;
  }

  if ($type === 'pay_month') {
    if ($need >= 100000) $t['3:400022'] = 1;
    if ($need >= 500000) $t['3:400023'] = 1;
    if ($need >= 1000000) $t['3:500095'] = 1;
    if ($need >= 2000000) $t['3:500054'] = 1;
    if ($need >= 5000000) $t['3:500077'] = 1;
    if ($need >= 10000000) $t['3:500053'] = 1;
    if ($need >= 20000000) {
      $t['3:400022'] = 3;
      $t['3:400023'] = 3;
      $t['3:500054'] = 2;
      $t['3:500095'] = 2;
      $t['3:500053'] = 2;
    }
    if ($need >= 50000000) {
      $t['3:400022'] = 4;
      $t['3:400023'] = 4;
      $t['3:500054'] = 3;
      $t['3:500095'] = 3;
      $t['3:500077'] = 2;
    }
    return $t;
  }

  if ($type === 'pay_all') {
    if ($need >= 100000) $t['3:400022'] = 1;
    if ($need >= 500000) $t['3:400023'] = 1;
    if ($need >= 1000000) $t['3:500095'] = 1;
    if ($need >= 2000000) $t['3:500054'] = 1;
    if ($need >= 5000000) $t['3:500077'] = 1;
    if ($need >= 10000000) {
      $t['3:400022'] = 3;
      $t['3:400023'] = 3;
      $t['3:500095'] = 2;
      $t['3:500054'] = 2;
      $t['3:500053'] = 1;
    }
    if ($need >= 20000000) {
      $t['3:400022'] = 4;
      $t['3:400023'] = 4;
      $t['3:500095'] = 3;
      $t['3:500054'] = 3;
      $t['3:500077'] = 2;
    }
    if ($need >= 50000000) {
      $t['3:400022'] = 6;
      $t['3:400023'] = 6;
      $t['3:500095'] = 4;
      $t['3:500054'] = 4;
      $t['3:500077'] = 3;
      $t['3:500053'] = 2;
    }
    return $t;
  }

  return $t;
}

function normalizeGiftMeta($gift, $meta) {
  if (!isset($gift['id'])) return $gift;
  $id = (string)$gift['id'];
  if (!isset($meta[$id])) return $gift;
  $gift['name'] = $meta[$id]['name'];
  $gift['icon'] = $meta[$id]['icon'];
  $gift['quality'] = $meta[$id]['quality'];
  if (!empty($meta[$id]['description'])) $gift['description'] = $meta[$id]['description'];
  return $gift;
}

$meta = loadCatalogMeta($configPath, $fallbackMeta);
$stmt = $pdo->query(
  "SELECT e.type, e.name event_name, m.id, m.need, m.gifts
   FROM ny_event e
   JOIN ny_event_milestone m ON m.event_id=e.id
   WHERE e.type IN ('pay_day','pay_week','pay_month','pay_all')
   ORDER BY e.id, m.need"
);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$updates = array();
foreach ($rows as $row) {
  $gifts = json_decode($row['gifts'], true);
  if (!is_array($gifts)) $gifts = array();

  $clean = array();
  foreach ($gifts as $gift) {
    $id = (string)($gift['id'] ?? '');
    if (in_array($id, $packIds, true)) continue;
    $clean[] = normalizeGiftMeta($gift, $meta);
  }

  $target = targetPayPacks($row['type'], $row['need']);
  foreach ($target as $id => $amount) {
    $gift = array(
      'id' => $id,
      'name' => $meta[$id]['name'] ?? $id,
      'amount' => (string)$amount,
      'icon' => $meta[$id]['icon'] ?? '',
      'quality' => $meta[$id]['quality'] ?? 5,
    );
    if (!empty($meta[$id]['description'])) $gift['description'] = $meta[$id]['description'];
    $clean[] = $gift;
  }

  $newJson = json_encode($clean, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
  if ($newJson !== $row['gifts']) {
    $updates[] = array(
      'id' => (int)$row['id'],
      'type' => $row['type'],
      'need' => (int)$row['need'],
      'gifts' => $newJson,
      'packs' => $target,
    );
  }
}

echo "Pay event rebalance " . ($apply ? "APPLY" : "DRY-RUN") . "\n";
echo "Milestones changed: " . count($updates) . "\n";
foreach ($updates as $u) {
  $packText = array();
  foreach ($u['packs'] as $id => $amount) $packText[] = "{$id}x{$amount}";
  echo "{$u['type']} | {$u['need']} | " . implode(', ', $packText) . "\n";
}

if ($apply) {
  $stamp = date('Ymd_His');
  $backupTable = "ny_event_milestone_backup_rebalance_pay_{$stamp}";
  $pdo->exec("CREATE TABLE {$backupTable} LIKE ny_event_milestone");
  $pdo->exec(
    "INSERT INTO {$backupTable}
     SELECT m.* FROM ny_event_milestone m
     JOIN ny_event e ON e.id=m.event_id
     WHERE e.type IN ('pay_day','pay_week','pay_month','pay_all')"
  );

  $update = $pdo->prepare("UPDATE ny_event_milestone SET gifts=:gifts WHERE id=:id");
  foreach ($updates as $u) $update->execute(array('gifts' => $u['gifts'], 'id' => $u['id']));
  echo "Backup table: {$backupTable}\n";
}

if ($resetPayClaims) {
  if ($apply) {
    $stamp = date('Ymd_His');
    $backupLog = "ny_log_event_backup_reset_pay_{$stamp}";
    $pdo->exec(
      "CREATE TABLE {$backupLog} AS
       SELECT l.* FROM ny_log_event l
       JOIN ny_event e ON e.id=l.event_id
       WHERE e.type IN ('pay_day','pay_week','pay_month','pay_all')"
    );
    $deleted = $pdo->exec(
      "DELETE l FROM ny_log_event l
       JOIN ny_event e ON e.id=l.event_id
       WHERE e.type IN ('pay_day','pay_week','pay_month','pay_all')"
    );
    echo "Reset pay claim logs deleted: {$deleted}\n";
    echo "Claim-log backup table: {$backupLog}\n";
  } else {
    $count = $pdo->query(
      "SELECT COUNT(*) FROM ny_log_event l
       JOIN ny_event e ON e.id=l.event_id
       WHERE e.type IN ('pay_day','pay_week','pay_month','pay_all')"
    )->fetchColumn();
    echo "Reset pay claim logs would delete: {$count}\n";
  }
}

