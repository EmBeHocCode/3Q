<?php
require 'pdo.php';

class EventUtils extends EventPDO {
  /* Đồng bộ tên và icon hiển thị với mã vật phẩm thật trong templates.bin. */
  public function normalizeGiftsForView ($giftsJson) {
    return normalizeGiftsJsonForView($giftsJson);

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
      '3:100250' => 'Lệnh Triệu Hoán Truy Ảnh',
      '3:100251' => 'Lệnh Triệu Hoán Thần Ngưu',
      '3:100273' => 'Lệnh Triệu Hoán Ma Sư',
      '3:100274' => 'Lệnh Triệu Hoán Tật Phong',
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
      '3:110114' => 'Rương Điển Tàng Thần Điện Lớn',
      '5:20001' => 'Long Hồn'
    );

    if($catalog === null){
      $catalog = array();
      $catalogPath = dirname(__DIR__, 3).'/tool/data/item-catalog.json';
      $payload = is_file($catalogPath) ? json_decode(file_get_contents($catalogPath), true) : null;
      if(is_array($payload) && !empty($payload['items'])){
        foreach($payload['items'] as $item){
          if(empty($item['reward'])) continue;
          $catalog[(string)$item['reward']] = $item;
        }
      }
    }

    $gifts = json_decode((string)$giftsJson, true);
    if(!is_array($gifts)) return $giftsJson;
    foreach($gifts as &$gift){
      $reward = isset($gift['id']) ? (string)$gift['id'] : '';
      if(isset($catalog[$reward])){
        $gift['name'] = isset($nameOverrides[$reward]) ? $nameOverrides[$reward] : $catalog[$reward]['name'];
        $gift['icon'] = (string)$catalog[$reward]['icon'];
        $gift['description'] = isset($catalog[$reward]['description']) ? (string)$catalog[$reward]['description'] : '';
        $gift['quality'] = isset($catalog[$reward]['quality']) ? (int)$catalog[$reward]['quality'] : 0;
      }
      else if($reward === '5:20001'){
        $gift['name'] = $nameOverrides[$reward];
        $gift['icon'] = 'FW10117';
        $gift['description'] = 'Nguyên liệu dùng để bồi dưỡng hệ thống Long Hồn.';
        $gift['quality'] = 5;
      }
    }
    unset($gift);
    return json_encode($gifts, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
  }

  /* Return Actice */
  public function returnActive ($text, $type, $msg = null) {
    return array(
      'text' => $text,
      'type' => $type,
      'msg' => $msg
    );
  }

  /* Return Check Need */
  public function returnCheckNeed ($check, $need, $comparison) {
    if($comparison == '>='){
      return $check >= $need;
    }
    else if($comparison == '<='){
      return $check <= $need;
    }
    else if($comparison == '>'){
      return $check > $need;
    }
    else if($comparison == '<'){
      return $check < $need;
    }
    else if($comparison == '='){
      return $check == $need;
    }
    else {
      return false;
    }
  }

  /* Get Active */
  public function getActive ($user, $event, $milestone){
    if(empty($user)) return $this->returnActive('Chưa đăng nhập', 0, 'Vui lòng đăng nhập trước');

    // Check Items
    $items = (array)json_decode($milestone['gifts']);
    if(count($items) == 0)
      return $this->returnActive('Chưa khả dụng', 0, 'Mốc chưa cập nhật phần thưởng, vui lòng quay lại sau');
    
    // Check Expires Time
    if(isExpires($event['expires_time']))
      return $this->returnActive('Hết hạn', 0, 'Sự kiện đã hết thời gian hiệu lực');

    // Check Event Type From User
    $event_type = $event['type'];
    $check = $user[$event_type];
    if(!isset($check)) 
      return $this->returnActive('Lỗi', 0, 'Mốc thưởng của sự kiện không chính xác');

    // Get Log
    $account = $user['account'];
    $event_id = $event['id'];
    $milestone_id = $milestone['id'];
    $log = (new _PDO())->select(self::$PDO_GetLogEvent, array(
      'account' => $account,
      'event_id' => $event_id,
      'milestone_id' => $milestone_id
    ));

    // Check Log
    if(!empty($log)){
      $old_time = convertTime($log['create_time']);
      $now_time = convertTime();
      
      if($event_type == 'pay_day' || $event_type == 'spend_day' || $event_type == 'online_day'){
        if(
          $now_time['date'] <= $old_time['date'] 
          && $now_time['month'] == $old_time['month']
          && $now_time['year'] == $old_time['year']
        ) return $this->returnActive('Đã nhận', 3, 'Bạn đã nhận mốc thưởng này rồi');
      }
      else if($event_type == 'pay_week' || $event_type == 'spend_week'){
        if(
          $now_time['week'] == $old_time['week']
          && $now_time['week_year'] == $old_time['week_year']
        ) return $this->returnActive('Đã nhận', 3, 'Bạn đã nhận mốc thưởng này rồi');
      }
      else if($event_type == 'login_day' || $event_type == 'pay_month' || $event_type == 'spend_month'){
        if(
          $now_time['month'] <= $old_time['month']
          && $now_time['year'] == $old_time['year']
        ) return $this->returnActive('Đã nhận', 3, 'Bạn đã nhận mốc thưởng này rồi');
      }
      else {
        return $this->returnActive('Đã nhận', 3, 'Bạn đã nhận mốc thưởng này rồi');
      }
    }
    
    // Check Need
    $checkNeed = $this->returnCheckNeed($check, (int)$milestone['need'], $event['comparison']);
    if(!$checkNeed)
      return $this->returnActive('Chưa đạt', 1, 'Bạn chưa đủ điều kiện nhận thưởng');

    // Active
    return $this->returnActive('Nhận ngay', 2);
  }

  /* Human-friendly progress label for non-currency milestones. */
  public function formatNeedForView ($event, $need) {
    if($event['type'] !== 'online_day') return null;
    $seconds = (int)$need;
    if($seconds < 3600) return 'Online '.floor($seconds / 60).' phút';
    $hours = $seconds / 3600;
    return 'Online '.((int)$hours == $hours ? (int)$hours : number_format($hours, 1, ',', '')).' giờ';
  }

  /* Human-friendly event reset/claim cycle label. */
  public function formatScheduleForView ($event) {
    $type = isset($event['type']) ? (string)$event['type'] : '';
    $name = isset($event['name']) ? (string)$event['name'] : '';
    if($type === 'pay_day' || $type === 'spend_day') return 'Reset 00:00 mỗi ngày';
    if($type === 'pay_week' || $type === 'spend_week') return 'Reset thứ 2 hằng tuần';
    if($type === 'pay_month' || $type === 'spend_month') return 'Reset ngày 1 hằng tháng';
    if($type === 'online_day') return 'Reset 00:00 mỗi ngày';
    if($type === 'pay_all' && preg_match('/tân thủ|tan thu/iu', $name)) return 'Tân thủ · nhận 1 lần';
    if($type === 'pay_all' || $type === 'spend_all') return 'Vĩnh viễn · nhận 1 lần/mốc';
    return null;
  }

  /* Get Milestone */
  public function getMilestone ($id) {
    if(!is_numeric($id)) return res(400, 'Dữ liệu đầu vào sai');

    $milestone = (new _PDO())->select(self::$PDO_GetMilestone, array('id' => $id));

    if(empty($milestone)) return res(400, 'Mốc thưởng không tồn tại');
    return $milestone;
  }

  /* Get Event  */
  public function getEvent ($id) {
    if(!is_numeric($id)) return res(400, 'Dữ liệu đầu vào sai');

    $event = (new _PDO())->select(self::$PDO_GetEvent, array('id' => $id));

    if(empty($event)) return res(400, 'Sự kiện không tồn tại');
    return $event;
  }
}
