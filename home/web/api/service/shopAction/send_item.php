<?php
require '../../config.php';
require API_DIR . '/includes/utils.php';
require API_DIR . '/includes/pdo.php';

echo "[Shop Send Item] Start send " . date('H:i:s d-m-Y') . PHP_EOL;
$sql = "SELECT * FROM ny_log_shop WHERE status='new' AND shop_type='item' LIMIT 100";
$gift_logs = (new _PDO('WEB'))->select($sql, [], true);

if ($gift_logs) {
	foreach ($gift_logs as $log) {
		$title = 'Mua vật phẩm thành công';
		$content = $log['action'];
		$response = sendMail($log, $title, $content);
		$body = isset($response['body']) ? (string)$response['body'] : '';

		$data_update = [
			'send_mail_at' => date('Y-m-d H:i:s'),
			'reason' => htmlspecialchars($body)
		];
		if((int)$response['http_code'] === 200){
			$data_update['status'] = 'sent';
		}else{
			echo "Send item fail to " . $log['account'] . PHP_EOL;
			$data_update['status'] = 'error';
			
		}

		$result = (new _PDO('WEB'))->update('ny_log_shop', $data_update, ['id' => $log['id']]);

	}
}

echo "[Shop Send Item] END send " . date('H:i:s d-m-Y') . PHP_EOL;
