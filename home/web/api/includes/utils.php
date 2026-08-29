<?php
/* Response API JSON */
function res ($code = 200, $msg = null, $data = null) {
  $return = array(
    'code' => $code,
    'msg' => $msg,
    'data' => $data
  );

  die(json_encode($return));
  exit();
}

/* Error Handler */
function errorHandler ($errno, $errstr) {
  res(500, '['.$errno.'] '.$errstr);
}

/* Get Client IP */
function getClientIP ($adv = true){
  $ip = null;

  if ($adv) {
    if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
      $arr = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
      $pos = array_search('unknown', $arr);
      if (false !== $pos) {
        unset($arr[$pos]);
      }
      $ip = trim($arr[0]);
    } 
    else if (isset($_SERVER['HTTP_CLIENT_IP'])) {
      $ip = $_SERVER['HTTP_CLIENT_IP'];
    } 
    else if (isset($_SERVER['REMOTE_ADDR'])) {
      $ip = $_SERVER['REMOTE_ADDR'];
    }
  }
  else if (isset($_SERVER['REMOTE_ADDR'])) {
    $ip = $_SERVER['REMOTE_ADDR'];
  }

  $long = sprintf('%u', ip2long($ip));
  if(empty($long)) return res(403, 'Vui lòng tuy cập bằng địa chỉ IP hợp lệ');
  return $ip;
}

/* Check Block IP */
function checkBlockIP () {
  $IP = getClientIP();
  $log = (new _PDO())->select("SELECT block, connect FROM ny_log_ip WHERE ip=:ip", array(
    'ip' => (string)$IP
  ));

  if(empty($log)){
    (new _PDO())->create('ny_log_ip', array(
      'ip' => (string)$IP,
      'update_time' => time()
    ));
    return;
  }
  else {
    (new _PDO())->update('ny_log_ip', array(
      'update_time' => time(),
      'connect' => array('+', 1)
    ), array(
      'ip' => (string)$IP
    ));

    if($log['block'] != 1) return;
    if($log['block'] == 1) return res('405', 'Bạn bị chặn quyền truy cập');
  }
}

/* Convert Time */
function convertTime ($time = null) {
  $time = isset($time) ? $time : time();

  $data = array(
    'date' => date('d', $time),
    'month' => date('m', $time),
    'year' => date('Y', $time),
    'week' => date('W', $time),
    'week_year' => date('o', $time),
    'hour' => date('H', $time),
    'minute' => date('i', $time),
    'second' => date('s', $time),
    'full_date' => date('dmY', $time),
    'full_time' => date('H:i:s', $time),
    'full' => date('d/m/Y - H:i:s', $time),
    'sql' => date('Y-m-d', $time),
    'timestamp' => $time
  );

  return $data;
}

/* Convert packed game descriptions into safe, readable plain text. */
function normalizeItemDescription ($text) {
  $text = html_entity_decode((string)$text, ENT_QUOTES | ENT_HTML5, 'UTF-8');
  $text = preg_replace('/<br\s*\/?>/iu', "\n", $text);
  $text = preg_replace('/<\d+\s+([^>]+)>/u', '$1', $text);
  $text = preg_replace('/<\/?(?:color|size|font)[^>]*>/iu', '', $text);
  $text = strip_tags($text);
  $text = preg_replace('/[ \t]+/u', ' ', $text);
  $text = preg_replace('/\n\s*/u', "\n", $text);
  return trim($text);
}

/* Add canonical name, icon, description and rarity to any web reward payload. */
function normalizeGiftItemsForView ($items) {
  static $catalog = null;
  static $nameOverrides = array(
    '3:999999' => 'Linh Ngọc',
    '3:100096' => 'Hộp Chọn Xà Phòng Ngũ Điện',
    '3:100146' => 'Xà Phòng Thần Điện',
    '3:100001' => 'Đá Tăng Bậc',
    '3:100342' => 'Long Hổ Đan',
    '3:100252' => 'Đan Linh Thú',
    '3:100253' => 'Sách Thú',
    '3:100258' => 'Hỏa Ngân',
    '3:500024' => 'Rương Tự Chọn Trang Bị Đỏ 3★',
    '3:500094' => 'Hộp Thánh Vật Nghề Nghiệp',
    '3:500059' => 'Hộp Thánh Vật Đa Dụng',
    '3:401001' => 'Hộp Thần Trang Tự Chọn',
    '3:400023' => 'Gói Tướng Âm–Dương Ngẫu Nhiên',
    '3:100216' => 'Kỳ Lân Tiên Ngọc',
    '3:100004' => 'Tàn Đan',
    '3:100231' => 'Rương Trân Tàng Ngũ Điện Nhỏ',
    '3:100232' => 'Rương Trân Tàng Ngũ Điện Trung',
    '3:100233' => 'Rương Trân Tàng Ngũ Điện Lớn',
    '3:100299' => 'Rương Tiên Phẩm Ngũ Điện Nhỏ',
    '3:100300' => 'Rương Tiên Phẩm Ngũ Điện Trung',
    '3:100301' => 'Rương Tiên Phẩm Ngũ Điện Lớn',
    '3:100302' => 'Rương Tiên Phẩm Thần Điện Nhỏ',
    '3:100303' => 'Rương Tiên Phẩm Thần Điện Trung',
    '3:100304' => 'Rương Tiên Phẩm Thần Điện Lớn',
    '3:100318' => 'Hộp Chọn Thủy Thú Trứng',
    '3:100319' => 'Hộp Chọn Hỏa Thú Trứng',
    '3:100320' => 'Hộp Thủy Thú Trứng Mạ Vàng',
    '3:100321' => 'Hộp Hỏa Thú Trứng Mạ Vàng',
    '3:100324' => 'Mật Hộp Thần Điện',
    '3:100326' => 'Hộp Vân Long Điển Tàng',
    '3:100506' => 'Hộp Thương Long Điển Tàng',
    '3:110112' => 'Rương Điển Tàng Thần Điện Nhỏ',
    '3:110113' => 'Rương Điển Tàng Thần Điện Trung',
    '3:110114' => 'Rương Điển Tàng Thần Điện Lớn'
  );
  static $iconOverrides = array(
    '3:999999' => 'wealth999999',
    '3:400022' => '10077',
    '3:400023' => '10077',
    '3:500054' => '10077',
    '3:500077' => '10077',
    '3:500095' => '10077',
    '3:500053' => '10077'
  );

  if($catalog === null){
    $catalog = array();
    $path = dirname(__DIR__, 2).'/tool/data/item-catalog.json';
    $payload = is_file($path) ? json_decode(file_get_contents($path), true) : null;
    if(is_array($payload) && !empty($payload['items'])){
      foreach($payload['items'] as $item){
        if(!empty($item['reward'])) $catalog[(string)$item['reward']] = $item;
      }
    }
  }

  if(!is_array($items)) return array();
  foreach($items as &$gift){
    if(is_object($gift)) $gift = (array)$gift;
    if(!is_array($gift)) continue;
    $raw = isset($gift['id']) ? (string)$gift['id'] : (isset($gift['item_id']) ? (string)$gift['item_id'] : '');
    if(preg_match('/^(\d+):(\d+)$/', trim($raw), $match))
      $reward = ((int)$match[1]).':'.((int)$match[2]);
    else
      $reward = trim($raw);
    if($reward !== '' && isset($gift['id'])) $gift['id'] = $reward;

    if($reward === '3:999999'){
      $gift['name'] = 'Linh Ngọc';
      $gift['icon'] = 'wealth999999';
      $gift['description'] = 'Tiền tệ nạp dùng để mua gói VIP, ưu đãi và vật phẩm đặc biệt.';
      $gift['quality'] = 5;
      $gift['type_description'] = 'Tiền tệ nạp';
      $gift['featured'] = 1;
      continue;
    }

    if(isset($catalog[$reward])){
      $meta = $catalog[$reward];
      $gift['name'] = isset($nameOverrides[$reward]) ? $nameOverrides[$reward] : (string)$meta['name'];
      $gift['icon'] = isset($iconOverrides[$reward]) ? $iconOverrides[$reward] : (string)$meta['icon'];
      $gift['description'] = normalizeItemDescription(isset($meta['description']) ? $meta['description'] : '');
      $gift['quality'] = isset($meta['quality']) ? (int)$meta['quality'] : 0;
      $gift['type_description'] = isset($meta['typeDescription']) ? (string)$meta['typeDescription'] : '';
    }
    else if($reward === '0:0'){
      $gift['name'] = 'Vàng Game'; $gift['icon'] = '2'; $gift['quality'] = 3;
      $gift['description'] = 'Tiền tệ cơ bản dùng để nâng cấp và phát triển đội hình.';
      $gift['type_description'] = 'Tài nguyên';
    }
    else if($reward === '0:4'){
      $gift['name'] = 'EXP Anh Hùng'; $gift['icon'] = '3'; $gift['quality'] = 3;
      $gift['description'] = 'Kinh nghiệm dùng để tăng cấp anh hùng.';
      $gift['type_description'] = 'Tài nguyên';
    }
    else if($reward === '5:20001'){
      $gift['name'] = 'Long Hồn'; $gift['icon'] = 'FW10117'; $gift['quality'] = 5;
      $gift['description'] = 'Nguyên liệu dùng để bồi dưỡng hệ thống Long Hồn.';
      $gift['type_description'] = 'Vật liệu hiếm';
    }
    else {
      $gift['description'] = normalizeItemDescription(isset($gift['description']) ? $gift['description'] : '');
      $gift['quality'] = isset($gift['quality']) ? (int)$gift['quality'] : 0;
    }

    $name = isset($gift['name']) ? (string)$gift['name'] : '';
    $gift['featured'] = ((int)$gift['quality'] >= 5 || preg_match('/Rương|Hộp|Gói|Điển Tàng|Thần Trang|Thánh Vật|Trứng/iu', $name)) ? 1 : 0;
  }
  unset($gift);
  return $items;
}

function normalizeGiftsJsonForView ($json) {
  $items = json_decode((string)$json, true);
  if(!is_array($items)) return $json;
  return json_encode(normalizeGiftItemsForView($items), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
}

function sendMail($data, $title, $content)
{
	$account = isset($data['account']) ? trim((string)$data['account']) : '';
	$serverId = isset($data['server_id']) ? (int)$data['server_id'] : 0;
	$quantity = isset($data['quantity']) ? (int)$data['quantity'] : 0;
	$rewardPrefix = isset($data['item_id']) ? trim((string)$data['item_id']) : '';
	if($account === '' || $serverId < 1 || $quantity < 1 || !preg_match('/^[0-9]:[0-9]{1,10}$/', $rewardPrefix))
		return array('http_code' => 400, 'body' => 'Invalid reward data');

	$reward = $rewardPrefix.':'.$quantity;
	$mailId = 0;
	try {
		$dsn = 'mysql:host='.MYSQL_HOST.';port='.MYSQL_PORT.';dbname=tcg;charset=utf8mb4';
		$conn = new PDO($dsn, MYSQL_USER, MYSQL_PWD, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
		$stmt = $conn->prepare("SELECT am.master_id_hex, am.master_name
			FROM account a
			INNER JOIN account_master am ON am.account_uid = a.uid
			WHERE a.username = :account AND am.srv_code = :srv_code
			ORDER BY am.last_active_time DESC LIMIT 1");
		$stmt->execute(array('account' => $account, 'srv_code' => 's'.$serverId));
		$master = $stmt->fetch(PDO::FETCH_ASSOC);
		if(empty($master)) return array('http_code' => 404, 'body' => 'Game character not found');

		$conn->beginTransaction();
		$stmt = $conn->prepare("INSERT INTO gm_mail_approval
			(type,title,content,reward,operation,status,submit_username,submit_nickname,submit_time,mail_type)
			VALUES (2,:title,:content,:reward,12,1,'admin','GM Center',NOW(),0)");
		$stmt->execute(array('title' => $title, 'content' => $content, 'reward' => $reward));
		$mailId = (int)$conn->lastInsertId();
		$stmt = $conn->prepare("INSERT INTO gm_mail_tar
			(mail_id,type,srv_code,master_id_hex,name,platform_code)
			VALUES (:mail_id,2,:srv_code,:master_id_hex,:name,'develop')");
		$stmt->execute(array(
			'mail_id' => $mailId,
			'srv_code' => 's'.$serverId,
			'master_id_hex' => $master['master_id_hex'],
			'name' => $master['master_name']
		));
		$conn->commit();
	}
	catch (Exception $e) {
		if(isset($conn) && $conn->inTransaction()) $conn->rollBack();
		return array('http_code' => 500, 'body' => 'Mail database error');
	}

	$loginToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdGFmZiI6IntcImlkXCI6MSxcInVzZXJuYW1lXCI6XCJhZG1pblwiLFwicGFzc3dvcmRcIjpcImExMjM0NTYuLi5hXCIsXCJuaWNrbmFtZVwiOlwi6LaF566hXCIsXCJjcmVhdGVUaW1lXCI6MTU5Mjc0OTI1OTAwMCxcImFkbWluXCI6dHJ1ZSxcInJvbGVJZFwiOjUsXCJkZXB0XCI6bnVsbCxcImNvbXBhbnlcIjpudWxsLFwic3lzXCI6ZmFsc2V9IiwicGVybWlzc2lvbiI6IntcInJvbGVJZFwiOjUsXCJhZG1pblwiOnRydWUsXCJwMFwiOnRydWUsXCJwMVwiOnRydWUsXCJwMlwiOnRydWUsXCJwM1wiOnRydWUsXCJwNFwiOnRydWUsXCJwNVwiOnRydWUsXCJwNlwiOnRydWUsXCJwN1wiOnRydWUsXCJwOFwiOnRydWUsXCJwOVwiOnRydWUsXCJwMTBcIjp0cnVlLFwicDExXCI6dHJ1ZSxcInAxMlwiOnRydWUsXCJwMTNcIjp0cnVlLFwicDE0XCI6dHJ1ZSxcInAxNVwiOnRydWUsXCJwMTZcIjp0cnVlLFwicDE3XCI6dHJ1ZSxcInAxOFwiOnRydWUsXCJwMTlcIjp0cnVlLFwicDIwXCI6dHJ1ZSxcInAyMVwiOnRydWUsXCJwMjJcIjp0cnVlLFwicDIzXCI6dHJ1ZSxcInAyNFwiOnRydWUsXCJwMjVcIjp0cnVlLFwicDI2XCI6dHJ1ZSxcInAyN1wiOnRydWUsXCJwMjhcIjp0cnVlLFwicDI5XCI6dHJ1ZSxcInAzMFwiOnRydWUsXCJwMzFcIjp0cnVlLFwicDMyXCI6dHJ1ZSxcInAzM1wiOnRydWUsXCJwMzRcIjpmYWxzZSxcInAzNVwiOmZhbHNlLFwicDM2XCI6ZmFsc2UsXCJwMzdcIjpmYWxzZSxcInAzOFwiOmZhbHNlLFwicDM5XCI6ZmFsc2UsXCJwNDBcIjpmYWxzZSxcInA0MVwiOmZhbHNlLFwicDQyXCI6ZmFsc2V9IiwiZXhwIjoxNjY1ODE3Mjk3LCJpYXQiOjE2NjMyMjUyOTd9.O5GVC5krVcMjZOlH40sbvhEHHxdZnKo_G0AbwFofx9k';
	$curl = curl_init('http://127.0.0.1:9999/gm/mail/x/complete');
	curl_setopt_array($curl, array(
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_CONNECTTIMEOUT => 3,
		CURLOPT_TIMEOUT => 10,
		CURLOPT_POST => true,
		CURLOPT_HTTPHEADER => array('Content-Type: application/json', 'Login-Token: '.$loginToken),
		CURLOPT_POSTFIELDS => json_encode(array('status' => 2, 'id' => $mailId))
	));
	$body = curl_exec($curl);
	$httpCode = (int)curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	$response = json_decode((string)$body, true);
	if($httpCode !== 200 || !is_array($response) || (int)$response['errorcode'] !== 0){
		try {
			$conn->prepare('DELETE FROM gm_mail_tar WHERE mail_id=:id')->execute(array('id' => $mailId));
			$conn->prepare('DELETE FROM gm_mail_approval WHERE id=:id AND status=1')->execute(array('id' => $mailId));
		}
		catch (Exception $e) {}
		return array('http_code' => 502, 'body' => !empty($response['errormsg']) ? $response['errormsg'] : 'Game mail delivery failed');
	}

	return array('http_code' => 200, 'body' => (string)$body);
}

/* Get Expires */
function isExpires ($time) {
  if((int)$time == 0) return false;

  $now = time();
  if((int)$now < (int)$time) return false;
  return true;
}

/* Get Count DB */
function getCountDB ($name) {
  $sql = "SELECT count(id) AS total FROM ".$name;
  $count = (new _PDO())->select($sql, null);
  return $count['total'];
}

/* Get Start Page */
function getPage ($count) {
  $page = !empty($_POST['page']) ? (int)$_POST['page'] : 1;
  $limit = !empty($_POST['limit']) ? (int)$_POST['limit'] : 10;
  $total = ceil((int)$count / $limit);

  if($page > $total){
    $page = $total;
  }
  else if ($page < 1){
    $page = 1;
  }

  $start = ($page - 1) * $limit;
  return array(
    'start' => (int)$start,
    'limit' => (int)$limit,
    'total' => (int)$total
  );
}

/* Get Table Search */
function getTableList ($table, $sql, $count = null) {
  if(!isset($count)){
    $count = getCountDB($table);
  }

  $page = getPage($count);
  $start = $page['start'];
  $limit = $page['limit'];
  $sort_by = empty($_POST['sort']) ? 'id' : $_POST['sort']['by'];
  $sort_type = empty($_POST['sort']) ? 'DESC' : $_POST['sort']['type'];

  $sql = $sql." ORDER BY $sort_by $sort_type LIMIT $start, $limit";
  $list = (new _PDO())->select($sql, [], true);
  
  return array(
    'list' => $list,
    'total_page' => $page['total']
  );
}

/* Get Table List */
function getTableSearch ($sqlCount, $sqlSearch) {
  if(empty($_POST['search'])) return res(400, 'Vui lòng nhập dữ liệu tìm kiếm');
  $query = $_POST['search'];
  $query = "%$query%";

  $countQuery = (new _PDO())->select($sqlCount, array('query' => $query));
  if(empty($countQuery) || $countQuery['total'] < 1)
    res(400, 'Không tìm thấy ghi chép nào hợp lệ');

  $count = (int)$countQuery['total'];
  $page = getPage($count);
  $start = $page['start'];
  $limit = $page['limit'];
  $sort_by = empty($_POST['sort']) ? 'id' : $_POST['sort']['by'];
  $sort_type = empty($_POST['sort']) ? 'DESC' : $_POST['sort']['type'];

  $sqlSearch = $sqlSearch." ORDER BY $sort_by $sort_type LIMIT $start, $limit";
  $list = (new _PDO())->select($sqlSearch, array(
    'query' => $query
  ), true);

  return array(
    'list' => $list,
    'total_page' => $page['total']
  );
}
