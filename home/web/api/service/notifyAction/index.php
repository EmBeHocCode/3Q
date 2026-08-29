<?php
require 'utils.php';

class Notify extends NotifyUtils {
  public function getNewGMNotify ($account) {
    $pdo = new _PDO();
    $list = $pdo->select(
      "SELECT id, content, create_time FROM ny_notify WHERE account=:account AND type='gm' AND view < '1' ORDER BY id ASC LIMIT 10",
      array('account' => (string)$account),
      true
    );

    if(!empty($list)){
      (new _PDO())->run(
        "UPDATE ny_notify SET view='1' WHERE account=:account AND type='gm' AND view < '1'",
        array('account' => (string)$account)
      );
    }

    return empty($list) ? array() : $list;
  }

  public function getAllNotify ($user) {
    $account = $user['account'];

    // Update View
    (new _PDO())->update('ny_notify', array('view'=>1), array('account'=>$account));

    // Get List
    $sqlCount = "SELECT count(id) AS total FROM ny_notify WHERE account=:account";
    $sql = "SELECT * FROM ny_notify WHERE account='$account'";

    if(empty($_POST['tab']) || $_POST['tab'] == 'all'){
      $count = (new _PDO())->select($sqlCount, array(
        'account' => $account
      ));
      $count = $count['total'];
      return getTableList(null, $sql, $count);
    }

    else if($_POST['tab'] == 'referral'){
      $sqlAdd = "AND type IN ('invitee', 'referral')";
      $count = (new _PDO())->select($sqlCount." ".$sqlAdd, array(
        'account' => $account
      ));

      $count = $count['total'];
      return getTableList(null, $sql." ".$sqlAdd, $count);
    }

    else {
      $type = (string)$_POST['tab'];
      $sqlAdd = "AND type=:type";
      $count = (new _PDO())->select($sqlCount." ".$sqlAdd, array(
        'account' => (string)$account,
        'type' => $type
      ));
      $count = $count['total'];
      return getTableList(null, $sql." AND type='$type'", $count);
    }
  }
}
