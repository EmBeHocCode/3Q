<?php
require 'pdo.php';
class WheelUtils extends WheelPDO {
	
	// GET 100 log type item & status = new
  public function getLogWheelItemNew () {
    $list = (new _PDO())->select(self::$PDO_GetLogWheelItemNew, [], true);
    return $list;
  }
  
  /* Get All Wheel Gift */
  public function getAllWheelGift () {
    $list = (new _PDO())->select(self::$PDO_GetAllWheelGift, [], true);
    if(empty($list) || count($list) < 10) return null;
    for($i = 0; $i < count($list); $i++){
      if($list[$i]['type'] !== 'item') continue;
      $view = normalizeGiftItemsForView(array(array(
        'id' => $list[$i]['item_id'], 'name' => $list[$i]['name'], 'amount' => $list[$i]['amount']
      )));
      if(!empty($view[0])){
        foreach(array('name','icon','description','quality','type_description','featured') as $field)
          if(isset($view[0][$field])) $list[$i][$field] = $view[0][$field];
      }
      if(empty($list[$i]['description']))
        $list[$i]['description'] = 'Phần thưởng vật phẩm nhận được từ Vòng Quay.';
      if(empty($list[$i]['quality']))
        $list[$i]['quality'] = ((float)$list[$i]['percent'] <= 0.001) ? 5 : 3;
    }
    return $list;
  }

  /* Get All Wheel Log */
  public function getAllWheelLog () {
    $authModel = new Auth();
    $user = $authModel->isLogin() ? $authModel->getAuth() : null;
    if(empty($user)) return null;
    
    $logs = (new _PDO())->select(self::$PDO_GetAllWheelLog, array('account' => $user['account']), true);
    return $logs;
  }

  /* Get All Wheel Log World */
  public function getAllWheelLogWorld () {
    $list = (new _PDO())->select(self::$PDO_GetAllWheelLogWorld, [], true);
    return $list;
  }
  
  /* Get Wheel Gift By ID */
  public function getWheelGift ($id) {
    if(!is_numeric($id)) return res(400, 'Không tìm thấy ID phần thưởng');

    $gift = (new _PDO())->select(self::$PDO_GetWheelGift, array('id' => $id));

    if(empty($gift)) return res(400, 'Phần thưởng không tồn tại');
    return $gift;
  }

  /* Get Random Gift */
  public function getRandomGift () {
    $list = $this->getAllWheelGift();

    if(empty($list))
      res(400, 'Vòng quay đang bảo trì, vui lòng quay lại sau');

    // Value Init
    $chances = [];
    $acc = 0;
    $index = 0;

    // Total Percent
    $sum = array_sum(array_column($list, 'percent'));
    $sum = (float)$sum * 100;
    $rand = (mt_rand() / mt_getrandmax()) * (float)$sum;

    // Set Chances
    foreach ($list as $gift) {
      $acc = (float)$acc + (float)$gift['percent'] * 100;
      $chances[] = $acc;
    }

    // Make Index
    foreach ($chances as $value) {
      if((float)$value <= (float)$rand){
        $index = (int)$index + 1;
      }
    }

    return $list[$index];
  }
}
