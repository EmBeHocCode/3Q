<?php
/**
 * Refresh 3Q web event rewards with extra hero packs.
 *
 * Usage:
 *   php scripts/refresh_event_rewards_20260811.php --config=/opt/3q-test/home/web/api/config.php --apply
 *   php scripts/refresh_event_rewards_20260811.php --config=/opt/3q-test/home/web/api/config.php --apply --reset-claims
 */

$args = array_flip(array_slice($argv, 1));
$apply = isset($args['--apply']);
$resetClaims = isset($args['--reset-claims']);
$configPath = null;
foreach (array_slice($argv, 1) as $arg) {
  if (strpos($arg, '--config=') === 0) {
    $configPath = substr($arg, strlen('--config='));
  }
}

if (!$configPath) {
  $configPath = dirname(__DIR__) . '/home/web/api/config.php';
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

$eventTypes = array(
  'pay_day', 'pay_week', 'pay_month', 'pay_all',
  'spend_day', 'spend_week', 'spend_month', 'spend_all'
);

$packs = array(
  '3:400022' => array('name' => 'Gói ngẫu nhiên tướng Tam Điện', 'icon' => '10077', 'quality' => 5),
  '3:400023' => array('name' => 'Gói ngẫu nhiên tướng Âm-Dương', 'icon' => '10077', 'quality' => 5),
  '3:500054' => array('name' => 'Gói tự chọn anh hùng Tam Quốc', 'icon' => '10077', 'quality' => 5),
  '3:500077' => array('name' => 'Gói tự chọn anh hùng Tam Quốc', 'icon' => '50043', 'quality' => 5),
  '3:500095' => array('name' => 'Tam tộc anh hùng tự do', 'icon' => '10077', 'quality' => 5),
  '3:500053' => array('name' => 'Gói chọn anh hùng Thánh-Thần', 'icon' => '50029', 'quality' => 5),
);

function desiredPacks($type, $need) {
  $need = (int)$need;
  $isPay = strpos($type, 'pay_') === 0;
  $isAll = substr($type, -4) === '_all';
  $isMonth = substr($type, -6) === '_month';
  $isWeek = substr($type, -5) === '_week';
  $result = array();

  if ($need >= 100000) $result['3:400022'] = $isPay ? 1 : 1;
  if ($need >= 500000) $result['3:400023'] = $isPay ? 1 : 1;
  if ($need >= 1000000) $result['3:500095'] = $isPay ? 1 : 1;
  if ($need >= 3000000) $result['3:500054'] = $isPay ? 1 : 1;
  if ($need >= 5000000) $result['3:500077'] = $isPay ? 2 : 1;
  if ($need >= 10000000) $result['3:500053'] = $isPay ? 1 : 1;

  if ($isWeek && $need >= 20000000) {
    $result['3:400023'] = max($result['3:400023'] ?? 0, 2);
    $result['3:500054'] = max($result['3:500054'] ?? 0, 2);
  }
  if ($isMonth && $need >= 20000000) {
    $result['3:400023'] = max($result['3:400023'] ?? 0, 3);
    $result['3:500054'] = max($result['3:500054'] ?? 0, 3);
    $result['3:500053'] = max($result['3:500053'] ?? 0, 2);
  }
  if ($isAll && $need >= 10000000) {
    $result['3:400022'] = max($result['3:400022'] ?? 0, 3);
    $result['3:400023'] = max($result['3:400023'] ?? 0, 3);
    $result['3:500095'] = max($result['3:500095'] ?? 0, 3);
    $result['3:500054'] = max($result['3:500054'] ?? 0, 3);
  }
  if ($isAll && $need >= 50000000) {
    $result['3:500077'] = max($result['3:500077'] ?? 0, 5);
    $result['3:500053'] = max($result['3:500053'] ?? 0, 3);
  }

  return $result;
}

function upsertGift(&$gifts, $id, $amount, $meta) {
  foreach ($gifts as &$gift) {
    if (($gift['id'] ?? '') === $id) {
      $gift['amount'] = (string)max((int)($gift['amount'] ?? 0), (int)$amount);
      $gift['name'] = $meta['name'];
      $gift['icon'] = $meta['icon'];
      $gift['quality'] = $meta['quality'];
      return false;
    }
  }
  $gifts[] = array(
    'id' => $id,
    'name' => $meta['name'],
    'amount' => (string)$amount,
    'icon' => $meta['icon'],
    'quality' => $meta['quality']
  );
  return true;
}

$placeholders = implode(',', array_fill(0, count($eventTypes), '?'));
$stmt = $pdo->prepare(
  "SELECT e.type, e.name event_name, m.id, m.need, m.gifts
   FROM ny_event e
   JOIN ny_event_milestone m ON m.event_id=e.id
   WHERE e.type IN ($placeholders)
   ORDER BY e.id, m.need"
);
$stmt->execute($eventTypes);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$updates = array();
foreach ($rows as $row) {
  $gifts = json_decode($row['gifts'], true);
  if (!is_array($gifts)) $gifts = array();

  $added = array();
  foreach (desiredPacks($row['type'], $row['need']) as $id => $amount) {
    if (!isset($packs[$id])) continue;
    $wasAdded = upsertGift($gifts, $id, $amount, $packs[$id]);
    $added[] = $id . 'x' . $amount . ($wasAdded ? '' : '(đã có/cập nhật)');
  }

  if (!$added) continue;
  $newJson = json_encode($gifts, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
  if ($newJson !== $row['gifts']) {
    $updates[] = array(
      'id' => (int)$row['id'],
      'type' => $row['type'],
      'event_name' => $row['event_name'],
      'need' => (int)$row['need'],
      'gifts' => $newJson,
      'added' => implode(', ', $added),
    );
  }
}

echo "Event reward refresh " . ($apply ? "APPLY" : "DRY-RUN") . "\n";
echo "Milestones changed: " . count($updates) . "\n";
foreach ($updates as $u) {
  echo "{$u['type']} | {$u['need']} | {$u['added']}\n";
}

if ($apply && count($updates)) {
  $stamp = date('Ymd_His');
  $backupTable = "ny_event_milestone_backup_meow_{$stamp}";
  $pdo->exec("CREATE TABLE {$backupTable} LIKE ny_event_milestone");
  $pdo->exec(
    "INSERT INTO {$backupTable}
     SELECT m.* FROM ny_event_milestone m
     JOIN ny_event e ON e.id=m.event_id
     WHERE e.type IN ('" . implode("','", $eventTypes) . "')"
  );

  $updateStmt = $pdo->prepare("UPDATE ny_event_milestone SET gifts=:gifts WHERE id=:id");
  foreach ($updates as $u) {
    $updateStmt->execute(array('gifts' => $u['gifts'], 'id' => $u['id']));
  }
  echo "Backup table: {$backupTable}\n";
}

if ($resetClaims) {
  $stamp = date('Ymd_His');
  $backupLog = "ny_log_event_backup_meow_{$stamp}";
  if ($apply) {
    $pdo->exec(
      "CREATE TABLE {$backupLog} AS
       SELECT l.* FROM ny_log_event l
       JOIN ny_event e ON e.id=l.event_id
       WHERE e.type IN ('" . implode("','", $eventTypes) . "')"
    );
    $deleted = $pdo->exec(
      "DELETE l FROM ny_log_event l
       JOIN ny_event e ON e.id=l.event_id
       WHERE e.type IN ('" . implode("','", $eventTypes) . "')"
    );
    echo "Reset claim logs deleted: {$deleted}\n";
    echo "Claim-log backup table: {$backupLog}\n";
  } else {
    $count = $pdo->query(
      "SELECT COUNT(*) FROM ny_log_event l
       JOIN ny_event e ON e.id=l.event_id
       WHERE e.type IN ('" . implode("','", $eventTypes) . "')"
    )->fetchColumn();
    echo "Reset claim logs would delete: {$count}\n";
  }
}

