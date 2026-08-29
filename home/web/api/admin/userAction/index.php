<?php
require 'utils.php';

class User extends UserUtils {
  /* Get All User */
  public function getAllUser () {
    return getTableList('ny_user', self::$PDO_GetAllUser);
  }

  /* Search User */
  public function searchUser () {
    $sqlCount = "SELECT 
      count(id) AS total 
      FROM ny_user 
      WHERE account LIKE :query
    ";

    $sqlSearch = "SELECT 
      user.*,
      auth.block, auth.phone, auth.type as type_user, auth.referraler
      FROM ny_user user
      LEFT JOIN ny_auth auth ON user.account = auth.account
      WHERE user.account LIKE :query
    ";

    return getTableSearch($sqlCount, $sqlSearch);
  }

  /* Get User IP */
  public function getLogUserIP () {
    if(empty($_POST['account'])) return res(400, 'Vui lòng chọn tài khoản trước');

    $account = $_POST['account'];
    $count = (new _PDO())->select("SELECT count(DISTINCT ip) AS total FROM ny_log_login WHERE account=:account", array(
      'account' => $account
    ));
    $count = $count['total'];

    return getTableList(null, "SELECT
      loglogin.ip, MAX(loglogin.create_time) AS create_time, 
      MAX(logip.block) AS block, 
      MAX(user.update_time) AS update_time
      FROM ny_log_login loglogin
      LEFT JOIN ny_log_ip logip ON logip.ip = loglogin.ip
      LEFT JOIN ny_user user ON user.account = loglogin.account
      WHERE loglogin.account='$account'
      GROUP BY loglogin.ip
    ", $count);
  }

  /* Get User Referral */
  public function getLogUserReferral () {
    if(empty($_POST['account'])) return res(400, 'Vui lòng chọn tài khoản trước');

    $account = $_POST['account'];
    $count = (new _PDO())->select("SELECT count(id) AS total FROM ny_log_referral WHERE account=:account", array(
      'account' => $account
    ));
    $count = $count['total'];

    return getTableList(null, "SELECT
      log.id, log.invitee, log.create_time,
      (SELECT SUM(money) FROM ny_pay WHERE status = 1 AND account = log.invitee) as pay_all
      FROM ny_log_referral log
      WHERE log.account='$account'
    ", $count);
  }

  /* Update User Auth */
  public function updateUserAuth () {
    if(
      empty($_POST['account'])
      || !is_numeric($_POST['type_user']) 
      || !is_numeric($_POST['block'])  
    ) return res(400, 'Dữ liệu đầu vào không đủ');
    
    // Check User
    $user = $this->getUser($_POST['account']);

    // Check Phone
    if(!empty($_POST['phone']) && $_POST['phone'] != $user['phone']){
      $check = (new Auth())->getAuthCheckByPhone($_POST['phone']);
      if(!empty($check)) return res(400, 'Số điện thoại đã tồn tại');
    }

    // Set Token
    if(!empty($_POST['password'])){
      $key = $user['account'].'-'.md5($_POST['password']).'-'.time();
      $token = md5($key);
    }
    else {
      $token = $user['token'];
    }
    
    // Update
    (new Auth())->updateAuth($user['account'], array(
      'password' => empty($_POST['password']) ? (string)$user['password'] : md5($_POST['password']),
      'phone' => empty($_POST['phone']) ? (string)$user['phone'] : (string)$_POST['phone'],
      'type' => (int)$_POST['type_user'],
      'block' => (int)$_POST['block'],
      'token' => (string)$token
    ));

    // Log
    logAdmin('Cập nhật thông tin tài khoản ['.$user['account'].']');
  }

  /* Update User Info */
  public function updateUserInfo () {
    if(
      empty($_POST['account']) 
      || empty($_POST['reason']) 
      || !is_numeric($_POST['coin'])
      || !is_numeric($_POST['coin_lock'])
      || !is_numeric($_POST['diamond'])
      || !is_numeric($_POST['wheel'])
    ) return res(400, 'Dữ liệu đầu vào không đủ');
    
    // Check User
    $user = $this->getUser($_POST['account']);

    $count_as_recharge = isset($_POST['count_as_recharge']) ? (int)$_POST['count_as_recharge'] : 0;
    if(!in_array($count_as_recharge, array(0, 1), true))
      return res(400, 'Tùy chọn tích nạp không hợp lệ');

    $coin = (int)$_POST['coin'];
    $coin_lock = (int)$_POST['coin_lock'];
    $diamond = (int)$_POST['diamond'];
    $wheel = (int)$_POST['wheel'];

    // Update
    $this->updateUser($user['account'], array(
      'coin' => array('+', $coin),
      'coin_lock' => array('+', $coin_lock),
      'diamond' => array('+', $diamond),
      'wheel' => array('+', $wheel),
    ));

    // Chỉ Xu dương được GM xác nhận mới tính như một lần nạp.
    if($count_as_recharge === 1 && $coin > 0){
      $this->updateUser($user['account'], array(
        'cash_coin' => array('+', $coin),
        'vip_exp' => array('+', $coin),
        'pay_day' => array('+', $coin),
        'pay_week' => array('+', $coin),
        'pay_month' => array('+', $coin),
        'pay_all' => array('+', $coin),
      ));
    }

    // Lưu thông báo riêng cho đúng tài khoản; client đang mở sẽ nhận trong vài giây.
    $changes = array();
    $labels = array('Xu', 'Xu Khóa', 'Kim Cương', 'Lượt Quay');
    foreach(array($coin, $coin_lock, $diamond, $wheel) as $index => $amount){
      if($amount == 0) continue;
      $changes[] = ($amount > 0 ? '+' : '').number_format($amount, 0, ',', '.').' '.$labels[$index];
    }
    $notify = 'GM vừa điều chỉnh số dư: ['.implode('] [', $changes).']';
    if($count_as_recharge === 1 && $coin > 0)
      $notify .= '. +'.number_format($coin, 0, ',', '.').' Xu được tính vào số dư nạp thực, tích nạp và VIP web.';
    (new Notify())->create($user['account'], $notify, 'gm');

    // Log
    logAdmin('Cập nhật tiền tệ cho tài khoản ['.$user['account'].'] với lý do ['.$_POST['reason'].']');
  }

  /* Update User Mission */
  public function updateUserMission () {
    if(
      empty($_POST['account']) 
      || !is_numeric($_POST['join_group'])
      || !is_numeric($_POST['join_zalo'])
      || !is_numeric($_POST['join_telegram'])
      || !is_numeric($_POST['share_web'])
    ) return res(400, 'Dữ liệu đầu vào không đủ');

    // Check User
    $user = $this->getUser($_POST['account']);

    // Update
    $this->updateUser($user['account'], array(
      'join_group' => (int)$_POST['join_group'],
      'join_zalo' => (int)$_POST['join_zalo'],
      'join_telegram' => (int)$_POST['join_telegram'],
      'share_web' => (int)$_POST['share_web'],
    ));

    // Log
    logAdmin('Cập nhật trạng thái nhiệm vụ cho tài khoản ['.$user['account'].']');
  }
  
  /* Send Item To User */
  public function checkInfo () {
    if(
      empty($_POST['tab']) 
      || empty($_POST['server_id'])
    )
      res(400, 'Dữ liệu đầu vào không đủ');

    // Set
    $tab = $_POST['tab'];
    $server_id = (string)$_POST['server_id'];
    
    // Is Account
    if($tab == 'account'){
      if(empty($_POST['account'])) return res(400, 'Dữ liệu đầu vào không đủ');
      $user = $this->getUser($_POST['account']);
      $account = $user['account'];  
    }

    // Is Role
    if($tab  == 'role'){
      if(empty($_POST['role'])) return res(400, 'Dữ liệu đầu vào không đủ');
      $account = (new Game())->getAccountByRole($_POST['role'], $server_id);
    }
	
	$role = (new Game())->getRoleByServer($account, $server_id);
	
	$response = [
		'account' => $account,
		'role_name' => $role['role_name'],
		'level' => $role['level'],
		'power' => $role['power']
	];
	
	$message = "Success";
	res(1368, $message, $response);
  }

  /* Send Item To User */
  public function sendItemToUser () {
    if(
      empty($_POST['tab']) 
      || empty($_POST['server_id']) 
      || empty($_POST['gifts'])
      || empty($_POST['reason'])
    )
      res(400, 'Dữ liệu đầu vào không đủ');

    // Set
    $tab = $_POST['tab'];
    $server_id = (string)$_POST['server_id'];
    
    // Is Account
    if($tab == 'account'){
      if(empty($_POST['account'])) return res(400, 'Dữ liệu đầu vào không đủ');
      $user = $this->getUser($_POST['account']);
      $account = $user['account'];
    }

    // Is Role
    if($tab  == 'role'){
      if(empty($_POST['role'])) return res(400, 'Dữ liệu đầu vào không đủ');
      $account = (new Game())->getAccountByRole($_POST['role'], $server_id);
    }

    // Check Item
    $items = (array)json_decode((string)$_POST['gifts']);
    if(!is_array($items))
      res(400, 'Vật phẩm đưa vào không hợp lệ');
    if(count($items) == 0)
      res(400, 'Vui lòng thêm ít nhất 1 vật phẩm');

    // Send
    (new Game())->sendItems($account, array(
      'server_id' => $server_id,
      'items' => $items
    ));

    // Log
    logAdmin('Gửi vật phẩm cho tài khoản ['.$account.'] tại máy chủ ['.$server_id.'] với lý do ['.$_POST['reason'].']');
  }
}
