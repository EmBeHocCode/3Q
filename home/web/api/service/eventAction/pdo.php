<?php
class EventPDO {
  static $PDO_GetAllEvent = "SELECT * FROM ny_event WHERE display='1' ORDER BY CASE type WHEN 'pay_day' THEN 1 WHEN 'pay_week' THEN 2 WHEN 'pay_month' THEN 3 WHEN 'pay_all' THEN 4 WHEN 'spend_day' THEN 5 WHEN 'spend_week' THEN 6 WHEN 'spend_month' THEN 7 WHEN 'spend_all' THEN 8 WHEN 'online_day' THEN 9 ELSE 100 END, update_time DESC";
  static $PDO_GetEvent = "SELECT * FROM ny_event WHERE display='1' AND id=:id";

  static $PDO_GetAllMilestone = "SELECT * FROM ny_event_milestone WHERE event_id=:event_id ORDER BY need ASC";
  static $PDO_GetMilestone = "SELECT * FROM ny_event_milestone WHERE id=:id";
  
  static $PDO_GetLogEvent = "SELECT 
    id, create_time 
    FROM ny_log_event 
    WHERE account=:account 
    AND event_id=:event_id 
    AND milestone_id=:milestone_id 
    ORDER BY create_time DESC 
    LIMIT 1
  ";
}
