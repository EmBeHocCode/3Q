<?php
require 'pdo.php';

class ServerUtils extends ServerPDO {
  /* Get All Server Rank Gift */
  public function getAllServerRankGift ($server_id, $type) {
    $list = (new _PDO())->select(self::$PDO_GetAllServerRankGift, array(
      'server_id' => (string)$server_id,
      'type' => (string)$type
    ), true);
    for($i = 0; $i < count($list); $i++)
      $list[$i]['gifts'] = normalizeGiftsJsonForView($list[$i]['gifts']);
    return $list;
  }
}
