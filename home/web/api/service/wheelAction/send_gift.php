<?php

require '../../config.php';
require API_DIR . '/includes/utils.php';
require API_DIR . '/includes/pdo.php';

echo "[Wheel Send Gift] Start send " . date('H:i:s d-m-Y') . PHP_EOL;
$sql = "SELECT * FROM ny_log_wheel WHERE status='new' AND gift_type='item' LIMIT 100";
$gift_logs = (new _PDO('WEB'))->select($sql, [], true);

if ($gift_logs) {
	foreach ($gift_logs as $log) {
		$title = 'Trả thưởng vòng quay';
		$content = $log['action'];
		$response = sendMail($log, $title, $content);
		$data_update = [
			'send_mail_at' => date('Y-m-d H:i:s'),
			'reason' => $response['header']
		];
		if($response['http_code'] == 200 && strpos($response['header'], 'GM') === false){
			$data_update['status'] = 'sent';
		}else{
			echo "Send item fail to " . $log['account'] . PHP_EOL;
			$data_update['status'] = 'error';
			
		}

		$result = (new _PDO('WEB'))->update('ny_log_wheel', $data_update, ['id' => $log['id']]);

	}
}

echo "[Wheel Send Gift] END send " . date('H:i:s d-m-Y') . PHP_EOL;