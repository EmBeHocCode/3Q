<?php
/**
 * Make "Ưu Đãi Tân Thủ" a balanced one-time starter recharge event.
 *
 * Usage:
 *   php update_newbie_event_rewards_20260811.php --config=/opt/3q-test/home/web/api/config.php
 *   php update_newbie_event_rewards_20260811.php --config=/opt/3q-test/home/web/api/config.php --apply --reset-newbie-claims
 */

$apply = in_array('--apply', $argv, true);
$resetClaims = in_array('--reset-newbie-claims', $argv, true);
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

function gift($id, $name, $amount, $icon, $quality = 4) {
  return array('id' => $id, 'name' => $name, 'amount' => (string)$amount, 'icon' => (string)$icon, 'quality' => $quality);
}

function heroGift($id, $name, $amount) {
  return gift($id, $name, $amount, '10077', 5);
}

$milestones = array(
  20000 => array(
    gift('0:0', 'Vàng Game', 1000000, '2', 3),
    gift('0:4', 'EXP Anh Hùng', 1000000, '3', 3),
    heroGift('3:400022', 'Gói ngẫu nhiên tướng Tam Điện', 1),
    gift('3:100001', 'Đá Tăng Bậc', 500, '100001', 4),
    gift('3:100342', 'Long Hổ Đan', 20, '100342', 4),
    gift('3:100252', 'Đan Linh Thú', 20, '100252', 4),
    gift('3:100253', 'Sách Thú', 50, '100253', 4),
    gift('3:100216', 'Kỳ Lân Tiên Ngọc', 1000, '100216', 4),
  ),
  50000 => array(
    gift('0:0', 'Vàng Game', 2500000, '2', 3),
    gift('0:4', 'EXP Anh Hùng', 2500000, '3', 3),
    heroGift('3:400022', 'Gói ngẫu nhiên tướng Tam Điện', 1),
    heroGift('3:400023', 'Gói ngẫu nhiên tướng Âm-Dương', 1),
    gift('3:100096', 'Hộp Chọn Xà Phòng Ngũ Điện', 10, '100096', 4),
    gift('3:100001', 'Đá Tăng Bậc', 1200, '100001', 4),
    gift('3:100342', 'Long Hổ Đan', 50, '100342', 4),
    gift('3:100252', 'Đan Linh Thú', 50, '100252', 4),
    gift('3:100253', 'Sách Thú', 120, '100253', 4),
  ),
  100000 => array(
    gift('0:0', 'Vàng Game', 5000000, '2', 3),
    gift('0:4', 'EXP Anh Hùng', 5000000, '3', 3),
    heroGift('3:400022', 'Gói ngẫu nhiên tướng Tam Điện', 1),
    heroGift('3:400023', 'Gói ngẫu nhiên tướng Âm-Dương', 1),
    heroGift('3:500095', 'Tam tộc anh hùng tự do', 1),
    gift('3:500024', 'Rương Tự Chọn Trang Bị Đỏ 3★', 1, '500024', 5),
    gift('3:100096', 'Hộp Chọn Xà Phòng Ngũ Điện', 20, '100096', 4),
    gift('3:100001', 'Đá Tăng Bậc', 2500, '100001', 4),
    gift('5:20001', 'Long Hồn', 1, 'FW10117', 5),
  ),
  200000 => array(
    gift('0:0', 'Vàng Game', 10000000, '2', 3),
    gift('0:4', 'EXP Anh Hùng', 10000000, '3', 3),
    heroGift('3:400022', 'Gói ngẫu nhiên tướng Tam Điện', 2),
    heroGift('3:400023', 'Gói ngẫu nhiên tướng Âm-Dương', 1),
    heroGift('3:500095', 'Tam tộc anh hùng tự do', 1),
    heroGift('3:500054', 'Gói tự chọn anh hùng Tam Quốc', 1),
    gift('3:500024', 'Rương Tự Chọn Trang Bị Đỏ 3★', 2, '500024', 5),
    gift('3:100231', 'Rương Trân Tàng Ngũ Điện Nhỏ', 5, '100231', 5),
    gift('3:100299', 'Rương Tiên Phẩm Ngũ Điện Nhỏ', 3, '100299', 5),
    gift('5:20001', 'Long Hồn', 2, 'FW10117', 5),
  ),
  500000 => array(
    gift('0:0', 'Vàng Game', 25000000, '2', 3),
    gift('0:4', 'EXP Anh Hùng', 25000000, '3', 3),
    heroGift('3:400022', 'Gói ngẫu nhiên tướng Tam Điện', 3),
    heroGift('3:400023', 'Gói ngẫu nhiên tướng Âm-Dương', 2),
    heroGift('3:500095', 'Tam tộc anh hùng tự do', 2),
    heroGift('3:500054', 'Gói tự chọn anh hùng Tam Quốc', 2),
    heroGift('3:500077', 'Gói tự chọn anh hùng Tam Quốc', 1),
    gift('3:401001', 'Hộp Thần Trang Tự Chọn', 1, '401001', 5),
    gift('3:500094', 'Hộp Thánh Vật Nghề Nghiệp', 1, '500094', 5),
    gift('3:100301', 'Rương Tiên Phẩm Ngũ Điện Lớn', 3, '100301', 5),
    gift('5:20001', 'Long Hồn', 5, 'FW10117', 5),
  ),
  1000000 => array(
    gift('0:0', 'Vàng Game', 50000000, '2', 3),
    gift('0:4', 'EXP Anh Hùng', 50000000, '3', 3),
    heroGift('3:400022', 'Gói ngẫu nhiên tướng Tam Điện', 5),
    heroGift('3:400023', 'Gói ngẫu nhiên tướng Âm-Dương', 4),
    heroGift('3:500095', 'Tam tộc anh hùng tự do', 3),
    heroGift('3:500054', 'Gói tự chọn anh hùng Tam Quốc', 3),
    heroGift('3:500077', 'Gói tự chọn anh hùng Tam Quốc', 2),
    heroGift('3:500053', 'Gói chọn anh hùng Thánh-Thần', 1),
    gift('3:401001', 'Hộp Thần Trang Tự Chọn', 2, '401001', 5),
    gift('3:500094', 'Hộp Thánh Vật Nghề Nghiệp', 2, '500094', 5),
    gift('3:100304', 'Rương Tiên Phẩm Thần Điện Lớn', 3, '100304', 5),
    gift('5:20001', 'Long Hồn', 10, 'FW10117', 5),
  ),
);

$stmt = $pdo->prepare("SELECT id FROM ny_event WHERE name LIKE '%Tân Thủ%' ORDER BY id DESC LIMIT 1");
$stmt->execute();
$event = $stmt->fetch(PDO::FETCH_ASSOC);

echo "Newbie starter event " . ($apply ? "APPLY" : "DRY-RUN") . "\n";
if(!$event) {
  echo "No newbie event found\n";
  exit($apply ? 1 : 0);
}

$eventId = (int)$event['id'];
foreach($milestones as $need => $gifts) {
  echo "event={$eventId} need={$need} gifts=".count($gifts)."\n";
}

if(!$apply) {
  $count = $pdo->query("SELECT COUNT(*) FROM ny_log_event WHERE event_id={$eventId}")->fetchColumn();
  echo "Newbie claim logs would reset: {$count}\n";
  exit(0);
}

$stamp = date('Ymd_His');
$backupMilestone = "ny_event_milestone_backup_newbie_{$stamp}";
$backupLog = "ny_log_event_backup_newbie_{$stamp}";
$pdo->exec("CREATE TABLE {$backupMilestone} LIKE ny_event_milestone");
$pdo->exec("INSERT INTO {$backupMilestone} SELECT * FROM ny_event_milestone WHERE event_id={$eventId}");
$pdo->exec("CREATE TABLE {$backupLog} AS SELECT * FROM ny_log_event WHERE event_id={$eventId}");

$pdo->prepare("UPDATE ny_event SET
  name='Ưu Đãi Tân Thủ',
  info='Gói nạp tân thủ nhận 1 lần duy nhất theo từng mốc. Ưu tiên tài nguyên đầu game, trang bị, vật liệu nâng cấp và gói tướng để khởi đầu ổn định.',
  type='pay_all',
  icon='pay_all',
  milestone_type='pay',
  comparison='>=',
  prefix='Nạp',
  suffix='VNĐ',
  display=1,
  update_time=:time
  WHERE id=:id")->execute(array('time' => time(), 'id' => $eventId));
$pdo->prepare("DELETE FROM ny_event_milestone WHERE event_id=:id")->execute(array('id' => $eventId));

$ins = $pdo->prepare("INSERT INTO ny_event_milestone (event_id,need,gifts) VALUES (:event_id,:need,:gifts)");
foreach($milestones as $need => $gifts) {
  $ins->execute(array(
    'event_id' => $eventId,
    'need' => $need,
    'gifts' => json_encode($gifts, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
  ));
}

$deleted = 0;
if($resetClaims) {
  $deleted = $pdo->exec("DELETE FROM ny_log_event WHERE event_id={$eventId}");
}
echo "Backup milestone table: {$backupMilestone}\n";
echo "Backup claim-log table: {$backupLog}\n";
echo "Newbie claim logs deleted: {$deleted}\n";

