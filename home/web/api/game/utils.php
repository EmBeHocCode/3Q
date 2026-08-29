<?php
class GameUtils {
  /* Get All Server Admin */
  public function getAllServerAdmin () {
    $sql = "SELECT id AS server_id, name AS server_name FROM srv_game";
    $list = (new _PDO('stat'))->select($sql, [], true);
    $newList = [];
    
    foreach ($list as $server) {
        $server['db_name'] = 'stat';
        $newList[] = $server;
    }
    
    return $newList;
  }

  /* Get Server */
  public function getServer ($server_id) {
    $sql = "SELECT id AS server_id, name AS server_name FROM srv_game WHERE id=:id";

    $server = (new _PDO('stat'))->select($sql, array('id' => $server_id));
    if(empty($server)) return res(400, 'Máy chủ không tồn tại');
    
    $server['db_name'] = 'stat';
    return $server;
  }

  /* Get Role By Server */
  public function getRoleByServer ($account, $server_id) {
    if(empty($server_id) || empty($account)) return res(400, 'Dữ liệu đầu vào sai');

    // Check Server
    $server = $this->getServer($server_id);

    // Get Role
    $open_id = $account.'@develop';
    $dbgame = $server['db_name'];
    $sql = "SELECT role_id, role_name, level, power FROM role_record WHERE open_id=:open_id AND srv_index=:server_id";
    $role = (new _PDO($dbgame))->select($sql, array('open_id' => $open_id, 'server_id' => $server_id));
    if(empty($role)) return res(400, 'Chưa có nhân vật ở máy chủ này');
    $role['server'] = $server;
    return $role;
  }

  /* Get Account By Role */
  public function getAccountByRole ($role_name, $server_id) {
    if(empty($server_id) || empty($role_name)) return res(400, 'Dữ liệu đầu vào sai');

    // Check Server
    $server = $this->getServer($server_id);

    // Get Role
    $dbgame = $server['db_name'];
    $sql = "SELECT role_id, role_name, open_id FROM role_record WHERE role_name=:role_name AND srv_index=:server_id";
    $role = (new _PDO($dbgame))->select($sql, array('role_name' => $role_name, 'server_id' => $server_id));
	
    if(empty($role)) return res(400, 'Không tìm thấy nhân vật ở máy chủ này');
    
    $account = str_replace("@develop", "", $role['open_id']);
    return $account;
  }

  /* Send Item */
  public function sendItems ($account, array $data) {
    // Check Role
    $role = $this->getRoleByServer($account, $data['server_id']);
	
	if(!$role)
		return res(400, 'Chưa tạo nhân vật');

    // Set Mail
    $title = '[Hệ Thống]';
    $content = 'Vật phẩm được gửi từ hệ thống';
    $role_id = $role['role_id'];
	if(empty($data['items']) || !is_array($data['items']))
		return res(400, 'Dữ liệu không hợp lệ');
	
	$server_id = (string)$data['server_id'];
	$sent = [];
	foreach($data['items'] as $item){
		$item = is_object($item) ? (array)$item : $item;
		if(!is_array($item))
			return res(400, 'Dữ liệu phần thưởng không hợp lệ');

		$rawId = isset($item['id']) ? trim((string)$item['id']) : '';
		if(strpos($rawId, ':') !== false){
			$parts = explode(':', $rawId, 2);
			$type = (int)$parts[0];
			$id = (int)$parts[1];
		}
		else {
			$type = isset($item['type']) ? (int)$item['type'] : 3;
			$id = (int)$rawId;
		}
		$amount = isset($item['amount']) ? (int)$item['amount'] : 0;

		// Reward chuẩn của game: loại:id:số lượng.
		// 0 = tài nguyên ví, 1 = tướng, 2 = trang bị, 3 = vật phẩm.
		if($type < 0 || $type > 9 || $id < 0 || $amount < 1 || $amount > 999999999999)
			return res(400, 'Mã phần thưởng hoặc số lượng không hợp lệ');

			if($type === 0 && in_array($id, array(97, 98, 99), true))
				return res(400, 'Tai nguyen BT/test '.$type.':'.$id.' khong the gui qua thu. Hay dung vat pham thuong hoac buff tien te rieng.');

			$mailData = [
			'account' => $account,
			'item_id' => $type.':'.$id,
			'quantity' => $amount,
			'server_id' => $server_id,
		];

		$result = sendMail($mailData, $title, $content);
		if(empty($result) || (int)$result['http_code'] !== 200)
			return res(502, 'Không thể kết nối dịch vụ thư trong game');
		$sent[] = $type.':'.$id.':'.$amount;
	}

	return $sent;
  }
  
  /* Send Recharge */
  public function sendRecharge ($account, array $data) {
    // Check Role
    $role = $this->getRoleByServer($account, $data['server_id']);
    $server = $role['server'];
    
    // Set Recharge
    $role_id = $role['role_id'];
  }
}
