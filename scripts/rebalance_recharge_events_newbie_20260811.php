<?php
/**
 * Rebalance recharge packs, normalize hero-pack icon, and add newbie recharge event.
 *
 * Usage:
 *   php rebalance_recharge_events_newbie_20260811.php --config=/opt/3q-test/home/web/api/config.php
 *   php rebalance_recharge_events_newbie_20260811.php --config=/opt/3q-test/home/web/api/config.php --apply --reset-pay-claims
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

$heroPackMeta = array(
  '3:400022' => array('name' => 'Gói ngẫu nhiên tướng Tam Điện', 'icon' => '10077', 'quality' => 5),
  '3:400023' => array('name' => 'Gói ngẫu nhiên tướng Âm-Dương', 'icon' => '10077', 'quality' => 5),
  '3:500054' => array('name' => 'Gói tự chọn anh hùng Tam Quốc', 'icon' => '10077', 'quality' => 5),
  '3:500077' => array('name' => 'Gói tự chọn anh hùng Tam Quốc', 'icon' => '10077', 'quality' => 5),
  '3:500095' => array('name' => 'Tam tộc anh hùng tự do', 'icon' => '10077', 'quality' => 5),
  '3:500053' => array('name' => 'Gói chọn anh hùng Thánh-Thần', 'icon' => '10077', 'quality' => 5),
);
$heroPackIds = array_keys($heroPackMeta);

function payPackPlan($type, $need) {
  $need = (int)$need;
  $p = array();

  if ($type === 'pay_day') {
    if ($need >= 100000) $p['3:400022'] = 1;
    if ($need >= 500000) $p['3:400023'] = 1;
    if ($need >= 1000000) $p['3:500095'] = 1;
    if ($need >= 2000000) $p['3:500054'] = 1;
    if ($need >= 3000000) $p['3:500077'] = 1;
    if ($need >= 5000000) {
      $p['3:400022'] = 3;
      $p['3:400023'] = 2;
      $p['3:500095'] = 2;
    }
    if ($need >= 10000000) {
      $p['3:400022'] = 5;
      $p['3:400023'] = 4;
      $p['3:500095'] = 3;
      $p['3:500054'] = 3;
      $p['3:500077'] = 2;
      $p['3:500053'] = 1;
    }
  } else if ($type === 'pay_week') {
    if ($need >= 100000) $p['3:400022'] = 1;
    if ($need >= 500000) $p['3:400023'] = 1;
    if ($need >= 1000000) $p['3:500095'] = 1;
    if ($need >= 2000000) $p['3:500054'] = 1;
    if ($need >= 5000000) {
      $p['3:400022'] = 3;
      $p['3:400023'] = 2;
      $p['3:500095'] = 2;
      $p['3:500077'] = 1;
    }
    if ($need >= 10000000) {
      $p['3:400022'] = 5;
      $p['3:400023'] = 4;
      $p['3:500095'] = 3;
      $p['3:500054'] = 3;
      $p['3:500077'] = 2;
      $p['3:500053'] = 1;
    }
    if ($need >= 50000000) {
      $p['3:400022'] = 8;
      $p['3:400023'] = 7;
      $p['3:500095'] = 5;
      $p['3:500054'] = 5;
      $p['3:500077'] = 3;
      $p['3:500053'] = 2;
    }
  } else if ($type === 'pay_month') {
    if ($need >= 100000) $p['3:400022'] = 1;
    if ($need >= 500000) $p['3:400023'] = 1;
    if ($need >= 1000000) $p['3:500095'] = 1;
    if ($need >= 2000000) $p['3:500054'] = 1;
    if ($need >= 5000000) {
      $p['3:400022'] = 4;
      $p['3:400023'] = 3;
      $p['3:500095'] = 2;
      $p['3:500054'] = 2;
      $p['3:500077'] = 1;
    }
    if ($need >= 10000000) {
      $p['3:400022'] = 6;
      $p['3:400023'] = 5;
      $p['3:500095'] = 4;
      $p['3:500054'] = 4;
      $p['3:500077'] = 2;
      $p['3:500053'] = 1;
    }
    if ($need >= 50000000) {
      $p['3:400022'] = 12;
      $p['3:400023'] = 10;
      $p['3:500095'] = 8;
      $p['3:500054'] = 8;
      $p['3:500077'] = 5;
      $p['3:500053'] = 4;
    }
  } else if ($type === 'pay_all') {
    if ($need >= 100000) $p['3:400022'] = 1;
    if ($need >= 500000) $p['3:400023'] = 1;
    if ($need >= 1000000) $p['3:500095'] = 1;
    if ($need >= 2000000) $p['3:500054'] = 1;
    if ($need >= 5000000) {
      $p['3:400022'] = 4;
      $p['3:400023'] = 3;
      $p['3:500095'] = 2;
      $p['3:500054'] = 2;
      $p['3:500077'] = 1;
    }
    if ($need >= 10000000) {
      $p['3:400022'] = 7;
      $p['3:400023'] = 6;
      $p['3:500095'] = 4;
      $p['3:500054'] = 4;
      $p['3:500077'] = 2;
      $p['3:500053'] = 1;
    }
    if ($need >= 50000000) {
      $p['3:400022'] = 15;
      $p['3:400023'] = 12;
      $p['3:500095'] = 10;
      $p['3:500054'] = 10;
      $p['3:500077'] = 6;
      $p['3:500053'] = 4;
    }
  }

  return $p;
}

function stripHeroPacks($gifts, $heroPackIds) {
  $out = array();
  foreach ($gifts as $gift) {
    if (in_array((string)($gift['id'] ?? ''), $heroPackIds, true)) continue;
    $out[] = $gift;
  }
  return $out;
}

function appendHeroPacks($gifts, $plan, $meta) {
  foreach ($plan as $id => $amount) {
    $m = $meta[$id];
    $gifts[] = array(
      'id' => $id,
      'name' => $m['name'],
      'amount' => (string)$amount,
      'icon' => $m['icon'],
      'quality' => $m['quality'],
    );
  }
  return $gifts;
}

function simpleGift($id, $name, $amount, $icon, $quality = 4) {
  return array('id' => $id, 'name' => $name, 'amount' => (string)$amount, 'icon' => (string)$icon, 'quality' => $quality);
}

function newbieGifts($need, $meta) {
  $base = array(
    simpleGift('0:0', 'Vàng Game', max(300000, $need * 25), '2', 4),
    simpleGift('0:4', 'EXP Anh Hùng', max(300000, $need * 25), '2', 4),
    simpleGift('3:100216', 'Kỳ Lân Tiên Ngọc', max(1000, (int)($need / 20)), '100216', 4),
  );
  $plan = array();
  if ($need >= 20000) $plan['3:400022'] = 1;
  if ($need >= 50000) $plan['3:400023'] = 1;
  if ($need >= 100000) $plan['3:500095'] = 1;
  if ($need >= 200000) $plan['3:500054'] = 1;
  if ($need >= 500000) {
    $plan['3:400022'] = 2;
    $plan['3:400023'] = 2;
    $plan['3:500077'] = 1;
  }
  if ($need >= 1000000) {
    $plan['3:400022'] = 3;
    $plan['3:400023'] = 3;
    $plan['3:500095'] = 2;
    $plan['3:500054'] = 2;
    $plan['3:500077'] = 1;
    $plan['3:500053'] = 1;
  }
  return appendHeroPacks($base, $plan, $meta);
}

$updates = array();
$stmt = $pdo->query(
  "SELECT e.type, m.id, m.need, m.gifts
   FROM ny_event e JOIN ny_event_milestone m ON m.event_id=e.id
   WHERE e.type IN ('pay_day','pay_week','pay_month','pay_all')
   ORDER BY e.id, m.need"
);
foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
  $gifts = json_decode($row['gifts'], true);
  if (!is_array($gifts)) $gifts = array();
  $gifts = stripHeroPacks($gifts, $heroPackIds);
  $gifts = appendHeroPacks($gifts, payPackPlan($row['type'], $row['need']), $heroPackMeta);
  $newJson = json_encode($gifts, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
  if ($newJson !== $row['gifts']) {
    $updates[] = array('id' => (int)$row['id'], 'type' => $row['type'], 'need' => (int)$row['need'], 'gifts' => $newJson);
  }
}

$newbieName = 'Ưu Đãi Tân Thủ';
$newbieInfo = 'Sự kiện nạp một lần cho người chơi mới: mốc thấp vẫn có cơ hội nhận tướng và tài nguyên ngon.';
$newbieNeeds = array(20000, 50000, 100000, 200000, 500000, 1000000);
$newbieEvent = $pdo->prepare("SELECT * FROM ny_event WHERE name=:name LIMIT 1");
$newbieEvent->execute(array('name' => $newbieName));
$newbie = $newbieEvent->fetch(PDO::FETCH_ASSOC);

echo "Recharge rebalance/newbie " . ($apply ? "APPLY" : "DRY-RUN") . "\n";
echo "Pay milestones changed: " . count($updates) . "\n";
foreach ($updates as $u) echo "{$u['type']} | {$u['need']}\n";
echo $newbie ? "Newbie event: update id={$newbie['id']}\n" : "Newbie event: create\n";

if (!$apply) {
  $claimCount = $pdo->query(
    "SELECT COUNT(*) FROM ny_log_event l JOIN ny_event e ON e.id=l.event_id WHERE e.type LIKE 'pay_%'"
  )->fetchColumn();
  echo "Pay claim logs would reset: {$claimCount}\n";
  exit(0);
}

$stamp = date('Ymd_His');
$backupMilestone = "ny_event_milestone_backup_recharge_{$stamp}";
$backupEvent = "ny_event_backup_recharge_{$stamp}";
$pdo->exec("CREATE TABLE {$backupMilestone} LIKE ny_event_milestone");
$pdo->exec("INSERT INTO {$backupMilestone} SELECT * FROM ny_event_milestone");
$pdo->exec("CREATE TABLE {$backupEvent} LIKE ny_event");
$pdo->exec("INSERT INTO {$backupEvent} SELECT * FROM ny_event");

$update = $pdo->prepare("UPDATE ny_event_milestone SET gifts=:gifts WHERE id=:id");
foreach ($updates as $u) $update->execute(array('gifts' => $u['gifts'], 'id' => $u['id']));

if ($newbie) {
  $eventId = (int)$newbie['id'];
  $updEvent = $pdo->prepare(
    "UPDATE ny_event SET info=:info,type='pay_all',icon='pay_all',milestone_type='pay',comparison='>=',prefix='Nạp',suffix='VNĐ',display=1,update_time=:time WHERE id=:id"
  );
  $updEvent->execute(array('info' => $newbieInfo, 'time' => time(), 'id' => $eventId));
  $pdo->prepare("DELETE FROM ny_event_milestone WHERE event_id=:id")->execute(array('id' => $eventId));
} else {
  $insEvent = $pdo->prepare(
    "INSERT INTO ny_event (name,info,type,icon,milestone_type,comparison,prefix,suffix,expires_time,display,update_time)
     VALUES (:name,:info,'pay_all','pay_all','pay','>=','Nạp','VNĐ',0,1,:time)"
  );
  $insEvent->execute(array('name' => $newbieName, 'info' => $newbieInfo, 'time' => time()));
  $eventId = (int)$pdo->lastInsertId();
}

$insMilestone = $pdo->prepare("INSERT INTO ny_event_milestone (event_id,need,gifts) VALUES (:event_id,:need,:gifts)");
foreach ($newbieNeeds as $need) {
  $insMilestone->execute(array(
    'event_id' => $eventId,
    'need' => $need,
    'gifts' => json_encode(newbieGifts($need, $heroPackMeta), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
  ));
}

echo "Backup event table: {$backupEvent}\n";
echo "Backup milestone table: {$backupMilestone}\n";
echo "Newbie event id: {$eventId}\n";

if ($resetPayClaims) {
  $backupLog = "ny_log_event_backup_recharge_reset_{$stamp}";
  $pdo->exec(
    "CREATE TABLE {$backupLog} AS
     SELECT l.* FROM ny_log_event l JOIN ny_event e ON e.id=l.event_id
     WHERE e.type LIKE 'pay_%'"
  );
  $deleted = $pdo->exec(
    "DELETE l FROM ny_log_event l JOIN ny_event e ON e.id=l.event_id WHERE e.type LIKE 'pay_%'"
  );
  echo "Reset pay claim logs deleted: {$deleted}\n";
  echo "Backup claim-log table: {$backupLog}\n";
}

