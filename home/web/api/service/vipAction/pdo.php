<?php
class VipPDO {
  static $PDO_GetAllVip = "SELECT * FROM ny_vip";
  static $PDO_GetVip = "SELECT * FROM ny_vip WHERE number=:number";
  static $PDO_GetVipNew = "SELECT * FROM ny_vip WHERE need_exp >= :need_exp ORDER BY need_exp ASC LIMIT 1";
  static $PDO_GetMaxVip = "SELECT MAX(number) AS number FROM ny_vip";
}
