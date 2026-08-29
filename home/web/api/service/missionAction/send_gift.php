<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require '../../config.php';
require API_DIR . '/includes/utils.php';
require API_DIR . '/includes/pdo.php';

echo "[Mission Send Item] Start send " . date('H:i:s d-m-Y') . PHP_EOL;
$sql = "SELECT * FROM ny_log_mission WHERE status='new' LIMIT 100";
$gift_logs = (new _PDO('WEB'))->select($sql, [], true);

if ($gift_logs) {
	foreach ($gift_logs as $log) {
		$title = 'Trả thưởng sự kiện';
		$content = $log['action'];
		$gifts = $log['gifts'] ? json_decode($log['gifts'], true) : null;
		
		$reason = [];
		$is_error = false;
		if($gifts){
			foreach($gifts as $gift){
				$log['item_id'] = $gift['id'];
				$log['quantity'] = $gift['amount'];
				$response = sendMail($log, $title, $content);
				$reason[] = isset($response['body']) ? $response['body'] : '';
			}
			
			if((int)$response['http_code'] === 200){
				// Success
			}else{
				$is_error = true;
			}
		}
		
		$data_update = [
			'send_mail_at' => date('Y-m-d H:i:s'),
			'reason' => implode(' --|-- ', $reason),
			'status' => $is_error ? 'error' : 'sent'
		];
		
		$result = (new _PDO('WEB'))->update('ny_log_mission', $data_update, ['id' => $log['id']]);
	}
}

echo "[Mission Send Item] END send " . date('H:i:s d-m-Y') . PHP_EOL;
