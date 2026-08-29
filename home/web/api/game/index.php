<?php
require 'utils.php';

class Game extends GameUtils {
  /* Get All Server */
  public function getAllServer () {
    $sql = "SELECT id AS server_id, name AS server_name FROM srv_game";
    $list = (new _PDO('stat'))->select($sql, [], true);
    return $list;
  }

  /* Get Role  */
  public function getRole ($user) {
    $role = $this->getRoleByServer($user['account'], $_POST['server_id']);
    return $role;
  }

  /* Login Game */
  public function loginGame ($user) {
    if(empty($_POST['server_id'])) return res(400, 'Chưa có thông tin máy chủ');

    $server_id = $_POST['server_id'];
    $account = $user['account'];
    $time = convertTime();
    $create_new_login = false;

    $sql = "SELECT id, create_time FROM ny_log_login_server WHERE server_id=:server_id AND account=:account ORDER BY create_time DESC LIMIT 1";
    $lastLogin = (new _PDO())->select($sql, array(
      'server_id' => (string)$server_id,
      'account' => (string)$account 
    ));

    if(empty($lastLogin)){
      $create_new_login = true;
    }
    else {
      $lastTimeLogin = convertTime($lastLogin['create_time']);
      if($lastTimeLogin['date'] != $time['date'])
        $create_new_login = true;
    }

    if($create_new_login){
      (new _PDO())->create('ny_log_login_server', array(
        'account' => (string)$account,
        'server_id' => (string)$server_id,
        'create_time' => (int)$time['timestamp']
      ));
    }
  }

  /* Get Rank Power */
  public function getRankPower ($server_id, $limit) {
    if(empty($server_id) || !is_numeric($limit)) return res(400, 'Dữ liệu đầu vào sai');

    // Check Server
    $server = $this->getServer($server_id);
    $dbgame = $server['db_name'];
    
    // Get
    $sql = "SELECT
      open_id as account,
      role_name,
      power,
      (SELECT @n := @n + 1 n FROM (SELECT @n := 0) m) AS rank
      FROM role_record
      WHERE srv_index=:server_id
      ORDER BY power DESC
      LIMIT $limit
    ";
    
    $list = (new _PDO($dbgame))->select($sql, array(
        'server_id' => $server_id
    ), true);
    $newList = [];
    
    foreach ($list as $item){
        $account = str_replace('@develop', '', $item['account']);
        $item['account'] = $account;
        $newList[] = $item;
    }
    
    return array(
      'list' => $newList,
      'total_page' => 1
    );
  }
  
  /* Get Rank Level */
  public function getRankLevel ($server_id, $limit) {
    if(empty($server_id) || !is_numeric($limit)) return res(400, 'Dữ liệu đầu vào sai');

    // Check Server
    $server = $this->getServer($server_id);
    $dbgame = $server['db_name'];
    
    // Get
    $sql = "SELECT
      open_id as account,
      role_name,
      level,
      (SELECT @n := @n + 1 n FROM (SELECT @n := 0) m) AS rank
      FROM role_record
      WHERE srv_index=:server_id
      ORDER BY level DESC
      LIMIT $limit
    ";
    
    $list = (new _PDO($dbgame))->select($sql, array(
        'server_id' => $server_id
    ), true);
    $newList = [];
    
    foreach ($list as $item){
        $account = str_replace('@develop', '', $item['account']);
        $item['account'] = $account;
        $newList[] = $item;
    }
    
    return array(
      'list' => $newList,
      'total_page' => 1
    );
  }
}
