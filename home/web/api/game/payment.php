<?php

class GamePayment {
  private $payBase = 'http://127.0.0.1:10010/yzx/';
  private $payAppSecret = '8c2c11186d39406b92ecfca7f18a0fb5';

  private function db () {
    $dsn = 'mysql:host='.MYSQL_HOST.';port='.MYSQL_PORT.';dbname='.MYSQL_NAME.';charset=utf8mb4';
    return new PDO($dsn, MYSQL_USER, MYSQL_PWD, array(
      PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
      PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
      PDO::ATTR_EMULATE_PREPARES => false
    ));
  }

  private function ensureLedger ($db) {
    $db->exec("CREATE TABLE IF NOT EXISTS ny_game_purchase (
      id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
      order_uid VARCHAR(64) NOT NULL,
      account VARCHAR(100) NOT NULL,
      server_id INT NOT NULL,
      item_tid INT NOT NULL,
      item_name VARCHAR(100) NOT NULL,
      price BIGINT UNSIGNED NOT NULL,
      paid_coin BIGINT UNSIGNED NOT NULL DEFAULT 0,
      paid_coin_lock BIGINT UNSIGNED NOT NULL DEFAULT 0,
      status VARCHAR(20) NOT NULL DEFAULT 'processing',
      attempts INT UNSIGNED NOT NULL DEFAULT 1,
      detail VARCHAR(500) DEFAULT NULL,
      create_time INT UNSIGNED NOT NULL,
      update_time INT UNSIGNED NOT NULL,
      PRIMARY KEY (id),
      UNIQUE KEY uniq_order_uid (order_uid),
      KEY idx_account_time (account, create_time)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");
  }

  private function cleanOrderInput () {
    $orderUid = isset($_POST['extstr']) ? trim((string)$_POST['extstr']) : '';
    if(!preg_match('/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i', $orderUid))
      return res(400, 'Mã đơn mua trong game không hợp lệ');

    $serverRaw = isset($_POST['serverid']) ? trim((string)$_POST['serverid']) : '';
    $serverId = (int)preg_replace('/\D+/', '', $serverRaw);
    $roleId = isset($_POST['roleid']) ? trim((string)$_POST['roleid']) : '';
    $payBill = isset($_POST['paybill']) ? (int)$_POST['paybill'] : 0;
    $count = isset($_POST['count']) ? (int)$_POST['count'] : 0;
    if($serverId < 1 || $roleId === '' || $payBill < 1 || $count < 1)
      return res(400, 'Dữ liệu đơn mua trong game chưa đầy đủ');

    return array(
      'uid' => $orderUid,
      'server_id' => $serverId,
      'role_id' => $roleId,
      'pay_bill' => $payBill,
      'count' => $count
    );
  }

  private function getOrder ($db, $account, $input, $lock = false) {
    $sql = "SELECT uid,item_tid,item_count,item_name,pay_amount,step,platform_open_id,
        srv_code,master_id_hex,master_name,create_time
      FROM tcg.pay_record WHERE uid=:uid LIMIT 1".($lock ? ' FOR UPDATE' : '');
    $stmt = $db->prepare($sql);
    $stmt->execute(array('uid' => $input['uid']));
    $order = $stmt->fetch();
    if(empty($order)) return res(404, 'Không tìm thấy đơn mua trong game');

    $expectedOpenId = $account.'@develop';
    $expectedServer = 's'.$input['server_id'];
    $expectedPayBill = (int)round((float)$order['pay_amount'] * 100);
    $createdAt = strtotime($order['create_time']);
    if($order['platform_open_id'] !== $expectedOpenId ||
      $order['srv_code'] !== $expectedServer ||
      $order['master_id_hex'] !== $input['role_id'])
      return res(403, 'Đơn mua không thuộc tài khoản đang đăng nhập');
    if((int)$order['item_count'] !== $input['count'] || $expectedPayBill !== $input['pay_bill'])
      return res(400, 'Giá hoặc số lượng của đơn mua không khớp máy chủ');
    if($createdAt === false || $createdAt < time() - 600)
      return res(410, 'Đơn mua đã hết hạn, vui lòng bấm mua lại trong game');
    if((float)$order['pay_amount'] <= 0 || (float)$order['pay_amount'] > 9000000000000000)
      return res(400, 'Giá gói mua không hợp lệ');

    $order['price'] = (int)round((float)$order['pay_amount']);
    $order['pay_bill'] = $expectedPayBill;
    $order['server_id'] = $input['server_id'];
    return $order;
  }

  private function walletData ($db, $account, $lock = false) {
    $sql = 'SELECT coin,cash_coin,coin_lock FROM ny_user WHERE account=:account LIMIT 1'.($lock ? ' FOR UPDATE' : '');
    $stmt = $db->prepare($sql);
    $stmt->execute(array('account' => $account));
    $wallet = $stmt->fetch();
    if(empty($wallet)) return res(404, 'Không tìm thấy ví người chơi');
    $wallet['coin'] = (int)$wallet['coin'];
    $wallet['cash_coin'] = (int)$wallet['cash_coin'];
    $wallet['coin_lock'] = (int)$wallet['coin_lock'];
    // Phải đồng thời còn Xu vàng và số dư nạp thực chưa tiêu cho gói VNĐ.
    $wallet['total'] = min($wallet['coin'], $wallet['cash_coin']);
    return $wallet;
  }

  public function quote ($user) {
    $input = $this->cleanOrderInput();
    try {
      $db = $this->db();
      $this->ensureLedger($db);
      $order = $this->getOrder($db, $user['account'], $input);
      $wallet = $this->walletData($db, $user['account']);
      $stmt = $db->prepare('SELECT status FROM ny_game_purchase WHERE order_uid=:uid LIMIT 1');
      $stmt->execute(array('uid' => $order['uid']));
      $ledger = $stmt->fetch();
      return array(
        'order_uid' => $order['uid'],
        'item_tid' => (int)$order['item_tid'],
        'item_name' => $order['item_name'],
        'price' => $order['price'],
        'coin' => $wallet['coin'],
        'cash_coin' => $wallet['cash_coin'],
        'coin_lock' => $wallet['coin_lock'],
        'total' => $wallet['total'],
        'can_afford' => $wallet['total'] >= $order['price'],
        'wallet_policy' => 'Chỉ tiền nạp thật đã được duyệt mới mua được gói hiển thị giá VNĐ.',
        'status' => !empty($ledger) ? $ledger['status'] : 'new'
      );
    }
    catch (Exception $e) {
      return res(500, 'Không thể kiểm tra đơn mua lúc này');
    }
  }

  private function reserve ($db, $user, $order) {
    $now = time();
    $db->beginTransaction();
    try {
      $stmt = $db->prepare('SELECT * FROM ny_game_purchase WHERE order_uid=:uid LIMIT 1 FOR UPDATE');
      $stmt->execute(array('uid' => $order['uid']));
      $ledger = $stmt->fetch();
      if(!empty($ledger) && $ledger['status'] === 'completed') {
        $db->commit();
        return array('completed' => true, 'ledger' => $ledger);
      }
      if(!empty($ledger) && $ledger['status'] === 'processing' && (int)$ledger['update_time'] > $now - 120) {
        $db->rollBack();
        return res(409, 'Đơn này đang được xử lý, vui lòng đợi vài giây');
      }

      $stmt = $db->prepare('SELECT step FROM tcg.pay_record WHERE uid=:uid LIMIT 1 FOR UPDATE');
      $stmt->execute(array('uid' => $order['uid']));
      $payRecord = $stmt->fetch();
      if(empty($payRecord)) {
        $db->rollBack();
        return res(404, 'Đơn mua không còn tồn tại');
      }
      if((int)$payRecord['step'] !== 1) {
        if(empty($ledger)) {
          $db->rollBack();
          return res(409, 'Đơn đã được xử lý ngoài ví web nên không thể cấp quà');
        }
        if(!empty($ledger)) {
          $stmt = $db->prepare("UPDATE ny_game_purchase SET status='completed',detail='Đã hoàn tất từ game server',update_time=:now WHERE order_uid=:uid");
          $stmt->execute(array('now' => $now, 'uid' => $order['uid']));
        }
        $db->commit();
        return array('completed' => true, 'ledger' => $ledger);
      }

      // Một tiến trình cũ có thể đã trừ ví rồi nhưng dừng trước callback.
      // Tái sử dụng khoản đã giữ, tuyệt đối không trừ người chơi lần hai.
      if(!empty($ledger) && $ledger['status'] === 'processing') {
        $stmt = $db->prepare('UPDATE ny_game_purchase SET attempts=attempts+1,update_time=:now WHERE order_uid=:uid');
        $stmt->execute(array('now' => $now, 'uid' => $order['uid']));
        $db->commit();
        return array(
          'completed' => false,
          'paid_coin' => (int)$ledger['paid_coin'],
          'paid_lock' => (int)$ledger['paid_coin_lock']
        );
      }

      $wallet = $this->walletData($db, $user['account'], true);
      if($wallet['total'] < $order['price']) {
        $db->rollBack();
        return res(400, 'Không đủ số dư nạp thực: cần '.number_format($order['price'], 0, ',', '.').' VNĐ');
      }

      $paidLock = 0;
      $paidCoin = $order['price'];
      $stmt = $db->prepare('UPDATE ny_user SET
        coin=coin-:paid_coin,cash_coin=cash_coin-:paid_cash,coin_lock=coin_lock-:paid_lock,
        spend_day=spend_day+:price_day,spend_week=spend_week+:price_week,spend_month=spend_month+:price_month,spend_all=spend_all+:price_all,
        update_time=:now WHERE account=:account AND coin>=:coin_guard AND cash_coin>=:cash_guard');
      $stmt->execute(array(
        'paid_coin' => $paidCoin,
        'paid_cash' => $order['price'],
        'paid_lock' => $paidLock,
        'price_day' => $order['price'],
        'price_week' => $order['price'],
        'price_month' => $order['price'],
        'price_all' => $order['price'],
        'now' => $now,
        'account' => $user['account'],
        'coin_guard' => $order['price'],
        'cash_guard' => $order['price']
      ));
      if($stmt->rowCount() !== 1) {
        $db->rollBack();
        return res(400, 'Không đủ số dư nạp thực để mua gói này');
      }

      if(empty($ledger)) {
        $stmt = $db->prepare("INSERT INTO ny_game_purchase
          (order_uid,account,server_id,item_tid,item_name,price,paid_coin,paid_coin_lock,status,attempts,create_time,update_time)
          VALUES (:uid,:account,:server_id,:item_tid,:item_name,:price,:paid_coin,:paid_lock,'processing',1,:create_time,:update_time)");
      }
      else {
        $stmt = $db->prepare("UPDATE ny_game_purchase SET
          paid_coin=:paid_coin,paid_coin_lock=:paid_lock,status='processing',attempts=attempts+1,
          detail=NULL,update_time=:now WHERE order_uid=:uid");
      }
      $params = array(
        'uid' => $order['uid'],
        'paid_coin' => $paidCoin,
        'paid_lock' => $paidLock,
        'now' => $now
      );
      if(empty($ledger)) {
        $params['account'] = $user['account'];
        $params['server_id'] = $order['server_id'];
        $params['item_tid'] = $order['item_tid'];
        $params['item_name'] = $order['item_name'];
        $params['price'] = $order['price'];
        $params['create_time'] = $now;
        $params['update_time'] = $now;
        unset($params['now']);
      }
      $stmt->execute($params);
      $db->commit();
      return array('completed' => false, 'paid_coin' => $paidCoin, 'paid_lock' => $paidLock);
    }
    catch (Exception $e) {
      if($db->inTransaction()) $db->rollBack();
      throw $e;
    }
  }

  private function postForm ($url, $data) {
    $curl = curl_init($url);
    curl_setopt_array($curl, array(
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_CONNECTTIMEOUT => 3,
      CURLOPT_TIMEOUT => 15,
      CURLOPT_POST => true,
      CURLOPT_HTTPHEADER => array('Content-Type: application/x-www-form-urlencoded'),
      CURLOPT_POSTFIELDS => http_build_query($data, '', '&')
    ));
    $body = curl_exec($curl);
    $httpCode = (int)curl_getinfo($curl, CURLINFO_HTTP_CODE);
    $error = curl_error($curl);
    curl_close($curl);
    if($body === false || $httpCode !== 200)
      throw new Exception($error !== '' ? $error : 'HTTP '.$httpCode);
    return (string)$body;
  }

  private function deliver ($order) {
    $mockBody = $this->postForm($this->payBase.'pay/mock', array(
      'warename' => $order['item_name'],
      'count' => (int)$order['item_count'],
      'paybill' => $order['pay_bill'],
      'serverid' => $order['srv_code'],
      'roleid' => $order['master_id_hex'],
      'extstr' => $order['uid']
    ));
    $mock = json_decode($mockBody, true);
    if(!is_array($mock) || (int)$mock['errorcode'] !== 0 || empty($mock['data']))
      throw new Exception(!empty($mock['errormsg']) ? $mock['errormsg'] : 'Pay mock failed');
    $cb = $mock['data'];

    // Pay server chạy production nên mock trả openid giả. Dùng danh tính đã
    // đối chiếu từ pay_record và ký lại theo đúng YzxPayCallback.genSign().
    $cb['openid'] = $order['platform_open_id'];
    $cb['serverid'] = '';
    $signText = '';
    if(!empty($cb['activityExtra']) && (int)$cb['activityExtra'] > 0)
      $signText .= 'activityExtra='.(int)$cb['activityExtra'].'&';
    $signText .= 'appid='.$cb['appid'].
      '&extstr='.$cb['extstr'].
      '&feemoney='.$cb['feemoney'].
      '&openid='.$cb['openid'].
      '&orderid='.$cb['orderid'].
      '&paystatus='.$cb['paystatus'].
      '&paytime='.$cb['paytime'].
      '&prover='.$cb['prover'].
      '&serverid='.$cb['serverid'];
    $cb['sign'] = md5($signText.$this->payAppSecret);

    $callbackBody = $this->postForm($this->payBase.'pay/callback', array(
      'appid' => $cb['appid'],
      'extstr' => $cb['extstr'],
      'feemoney' => $cb['feemoney'],
      'openid' => $cb['openid'],
      'orderid' => $cb['orderid'],
      'paystatus' => $cb['paystatus'],
      'paytime' => $cb['paytime'],
      'prover' => $cb['prover'],
      'serverid' => isset($cb['serverid']) ? $cb['serverid'] : '',
      'sign' => $cb['sign']
    ));
    if(strtoupper(trim($callbackBody)) !== 'OK')
      throw new Exception('Game callback: '.substr(trim($callbackBody), 0, 200));
    return $cb['orderid'];
  }

  private function refund ($db, $orderUid, $detail) {
    $db->beginTransaction();
    try {
      $stmt = $db->prepare('SELECT * FROM ny_game_purchase WHERE order_uid=:uid LIMIT 1 FOR UPDATE');
      $stmt->execute(array('uid' => $orderUid));
      $ledger = $stmt->fetch();
      if(!empty($ledger) && $ledger['status'] === 'processing') {
        $stmt = $db->prepare('UPDATE ny_user SET
          coin=coin+:refund_coin,cash_coin=cash_coin+:refund_cash,coin_lock=coin_lock+:refund_lock,
          spend_day=GREATEST(spend_day-:price_day,0),spend_week=GREATEST(spend_week-:price_week,0),spend_month=GREATEST(spend_month-:price_month,0),spend_all=GREATEST(spend_all-:price_all,0),
          update_time=:now WHERE account=:account');
        $stmt->execute(array(
          'refund_coin' => (int)$ledger['paid_coin'],
          'refund_cash' => (int)$ledger['paid_coin'],
          'refund_lock' => (int)$ledger['paid_coin_lock'],
          'price_day' => (int)$ledger['price'],
          'price_week' => (int)$ledger['price'],
          'price_month' => (int)$ledger['price'],
          'price_all' => (int)$ledger['price'],
          'now' => time(),
          'account' => $ledger['account']
        ));
        $stmt = $db->prepare("UPDATE ny_game_purchase SET status='refunded',detail=:detail,update_time=:now WHERE order_uid=:uid");
        $stmt->execute(array('detail' => substr($detail, 0, 500), 'now' => time(), 'uid' => $orderUid));
      }
      $db->commit();
    }
    catch (Exception $e) {
      if($db->inTransaction()) $db->rollBack();
      throw $e;
    }
  }

  private function logFailure ($orderUid, $detail) {
    $line = '['.date('Y-m-d H:i:s').'] order='.(string)$orderUid.' detail='.(string)$detail.PHP_EOL;
    @file_put_contents(API_DIR.'/game-payment-error.log', $line, FILE_APPEND);
  }

  public function purchase ($user) {
    $input = $this->cleanOrderInput();
    $db = null;
    $order = null;
    try {
      $db = $this->db();
      $this->ensureLedger($db);
      $order = $this->getOrder($db, $user['account'], $input);
      $reserved = $this->reserve($db, $user, $order);
      if(!empty($reserved['completed'])) {
        $wallet = $this->walletData($db, $user['account']);
        return array('already_completed' => true, 'price' => $order['price'], 'wallet' => $wallet);
      }

      $platformOrderId = $this->deliver($order);
      $stmt = $db->prepare("UPDATE ny_game_purchase SET status='completed',detail=:detail,update_time=:now WHERE order_uid=:uid AND status='processing'");
      $stmt->execute(array('detail' => 'Platform order '.$platformOrderId, 'now' => time(), 'uid' => $order['uid']));
      $stmt = $db->prepare("INSERT INTO ny_log_shop
        (account,server_id,shop_id,shop_type,price,action,create_time)
        VALUES (:account,:server_id,:shop_id,'game_vnd',:price,:action,:now)");
      $stmt->execute(array(
        'account' => $user['account'],
        'server_id' => (string)$order['server_id'],
        'shop_id' => (int)$order['item_tid'],
        'price' => $order['price'],
        'action' => 'Mua gói game ['.$order['item_name'].'] bằng '.$order['price'].' Xu vàng',
        'now' => time()
      ));
      $wallet = $this->walletData($db, $user['account']);
      return array(
        'order_uid' => $order['uid'],
        'item_name' => $order['item_name'],
        'price' => $order['price'],
        'paid_coin' => $reserved['paid_coin'],
        'paid_coin_lock' => $reserved['paid_lock'],
        'wallet' => $wallet
      );
    }
    catch (Exception $e) {
      $detail = $e->getMessage();
      $this->logFailure($order ? $order['uid'] : (isset($input['uid']) ? $input['uid'] : ''), $detail);
      if($db && $order) {
        try { $this->refund($db, $order['uid'], $detail); } catch (Exception $ignored) {}
      }
      return res(502, 'Không thể giao gói game; số Xu đã được hoàn lại. Chi tiết: '.substr($detail, 0, 180));
    }
  }
}
