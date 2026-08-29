START TRANSACTION;

INSERT INTO `ny_event_milestone` (`event_id`, `need`, `gifts`)
SELECT 2, 10000000, '[{"id":"0:0","name":"Vàng Game","amount":"100000000","icon":"2"},{"id":"0:4","name":"EXP Anh Hùng","amount":"100000000","icon":"3"},{"id":"3:100231","name":"Ngũ điện cỡ nhỏ trân tàng","amount":"10","icon":"10330"},{"id":"3:100232","name":"Năm trong tộc hình trân tàng","amount":"5","icon":"10331"},{"id":"3:100233","name":"Ngũ điện cỡ lớn trân tàng","amount":"2","icon":"10332"},{"id":"3:100250","name":"Lệnh triệu hoán Truy Ảnh","amount":"1","icon":"10352"},{"id":"3:100251","name":"Lệnh triệu hoán Thần Ngưu","amount":"1","icon":"10351"},{"id":"3:100324","name":"Thần điện Mật Hộp","amount":"10","icon":"10514"}]'
WHERE NOT EXISTS (
  SELECT 1 FROM `ny_event_milestone` WHERE `event_id` = 2 AND `need` = 10000000
);

UPDATE `ny_event_milestone`
SET `gifts` = '[{"id":"0:0","name":"Vàng Game","amount":"100000000","icon":"2"},{"id":"0:4","name":"EXP Anh Hùng","amount":"100000000","icon":"3"},{"id":"3:100231","name":"Ngũ điện cỡ nhỏ trân tàng","amount":"10","icon":"10330"},{"id":"3:100232","name":"Năm trong tộc hình trân tàng","amount":"5","icon":"10331"},{"id":"3:100233","name":"Ngũ điện cỡ lớn trân tàng","amount":"2","icon":"10332"},{"id":"3:100250","name":"Lệnh triệu hoán Truy Ảnh","amount":"1","icon":"10352"},{"id":"3:100251","name":"Lệnh triệu hoán Thần Ngưu","amount":"1","icon":"10351"},{"id":"3:100324","name":"Thần điện Mật Hộp","amount":"10","icon":"10514"}]'
WHERE `event_id` = 2 AND `need` = 10000000;

INSERT INTO `ny_event_milestone` (`event_id`, `need`, `gifts`)
SELECT 2, 20000000, '[{"id":"0:0","name":"Vàng Game","amount":"200000000","icon":"2"},{"id":"0:4","name":"EXP Anh Hùng","amount":"200000000","icon":"3"},{"id":"3:100299","name":"Tiên phẩm ngũ điện - nhỏ","amount":"15","icon":"10330"},{"id":"3:100300","name":"Tiên phẩm ngũ điện - trung","amount":"8","icon":"10331"},{"id":"3:100301","name":"Tiên phẩm ngũ điện - lớn","amount":"3","icon":"10332"},{"id":"3:100273","name":"Triệu hồi Ma Sư","amount":"1","icon":"10355"},{"id":"3:100274","name":"Triệu hồi Tật Phong","amount":"1","icon":"10356"},{"id":"3:100324","name":"Thần điện Mật Hộp","amount":"20","icon":"10514"}]'
WHERE NOT EXISTS (
  SELECT 1 FROM `ny_event_milestone` WHERE `event_id` = 2 AND `need` = 20000000
);

UPDATE `ny_event_milestone`
SET `gifts` = '[{"id":"0:0","name":"Vàng Game","amount":"200000000","icon":"2"},{"id":"0:4","name":"EXP Anh Hùng","amount":"200000000","icon":"3"},{"id":"3:100299","name":"Tiên phẩm ngũ điện - nhỏ","amount":"15","icon":"10330"},{"id":"3:100300","name":"Tiên phẩm ngũ điện - trung","amount":"8","icon":"10331"},{"id":"3:100301","name":"Tiên phẩm ngũ điện - lớn","amount":"3","icon":"10332"},{"id":"3:100273","name":"Triệu hồi Ma Sư","amount":"1","icon":"10355"},{"id":"3:100274","name":"Triệu hồi Tật Phong","amount":"1","icon":"10356"},{"id":"3:100324","name":"Thần điện Mật Hộp","amount":"20","icon":"10514"}]'
WHERE `event_id` = 2 AND `need` = 20000000;

INSERT INTO `ny_event_milestone` (`event_id`, `need`, `gifts`)
SELECT 2, 50000000, '[{"id":"0:0","name":"Vàng Game","amount":"500000000","icon":"2"},{"id":"0:4","name":"EXP Anh Hùng","amount":"500000000","icon":"3"},{"id":"3:100302","name":"Tiên phẩm thần điện - nhỏ","amount":"20","icon":"10377"},{"id":"3:100303","name":"Tiên phẩm thần điện - trung","amount":"10","icon":"10378"},{"id":"3:100304","name":"Tiên phẩm thần điện - lớn","amount":"5","icon":"10379"},{"id":"3:100318","name":"Thủy Thú Trứng  hộp quà","amount":"2","icon":"10509"},{"id":"3:100319","name":"Hỏa Thú Trứng hộp quà","amount":"2","icon":"10510"},{"id":"3:100324","name":"Thần điện Mật Hộp","amount":"50","icon":"10514"}]'
WHERE NOT EXISTS (
  SELECT 1 FROM `ny_event_milestone` WHERE `event_id` = 2 AND `need` = 50000000
);

UPDATE `ny_event_milestone`
SET `gifts` = '[{"id":"0:0","name":"Vàng Game","amount":"500000000","icon":"2"},{"id":"0:4","name":"EXP Anh Hùng","amount":"500000000","icon":"3"},{"id":"3:100302","name":"Tiên phẩm thần điện - nhỏ","amount":"20","icon":"10377"},{"id":"3:100303","name":"Tiên phẩm thần điện - trung","amount":"10","icon":"10378"},{"id":"3:100304","name":"Tiên phẩm thần điện - lớn","amount":"5","icon":"10379"},{"id":"3:100318","name":"Thủy Thú Trứng  hộp quà","amount":"2","icon":"10509"},{"id":"3:100319","name":"Hỏa Thú Trứng hộp quà","amount":"2","icon":"10510"},{"id":"3:100324","name":"Thần điện Mật Hộp","amount":"50","icon":"10514"}]'
WHERE `event_id` = 2 AND `need` = 50000000;

INSERT INTO `ny_event_milestone` (`event_id`, `need`, `gifts`)
SELECT 2, 100000000, '[{"id":"0:0","name":"Vàng Game","amount":"1000000000","icon":"2"},{"id":"0:4","name":"EXP Anh Hùng","amount":"1000000000","icon":"3"},{"id":"3:110112","name":"Điển tàng Thần điện cỡ nhỏ","amount":"20","icon":"10542"},{"id":"3:110113","name":"Điển tàng Thần điện cỡ trung","amount":"10","icon":"10543"},{"id":"3:110114","name":"Điển tàng Thần điện cỡ lớn","amount":"5","icon":"10544"},{"id":"3:100320","name":"Thủy Thú Trứng hộp quà - vàng","amount":"3","icon":"10505"},{"id":"3:100321","name":"Hỏa Thú Trứng hộp quà - vàng","amount":"3","icon":"10506"},{"id":"3:100326","name":"Vân long điển tàng hộp quà","amount":"3","icon":"10516"},{"id":"3:100506","name":"Thương Long điển tàng hộp quà","amount":"3","icon":"65018"},{"id":"3:100324","name":"Thần điện Mật Hộp","amount":"100","icon":"10514"}]'
WHERE NOT EXISTS (
  SELECT 1 FROM `ny_event_milestone` WHERE `event_id` = 2 AND `need` = 100000000
);

UPDATE `ny_event_milestone`
SET `gifts` = '[{"id":"0:0","name":"Vàng Game","amount":"1000000000","icon":"2"},{"id":"0:4","name":"EXP Anh Hùng","amount":"1000000000","icon":"3"},{"id":"3:110112","name":"Điển tàng Thần điện cỡ nhỏ","amount":"20","icon":"10542"},{"id":"3:110113","name":"Điển tàng Thần điện cỡ trung","amount":"10","icon":"10543"},{"id":"3:110114","name":"Điển tàng Thần điện cỡ lớn","amount":"5","icon":"10544"},{"id":"3:100320","name":"Thủy Thú Trứng hộp quà - vàng","amount":"3","icon":"10505"},{"id":"3:100321","name":"Hỏa Thú Trứng hộp quà - vàng","amount":"3","icon":"10506"},{"id":"3:100326","name":"Vân long điển tàng hộp quà","amount":"3","icon":"10516"},{"id":"3:100506","name":"Thương Long điển tàng hộp quà","amount":"3","icon":"65018"},{"id":"3:100324","name":"Thần điện Mật Hộp","amount":"100","icon":"10514"}]'
WHERE `event_id` = 2 AND `need` = 100000000;

COMMIT;
