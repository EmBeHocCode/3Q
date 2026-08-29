CREATE TABLE IF NOT EXISTS `ny_mission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `info` text,
  `type` varchar(50) NOT NULL,
  `need` double(50,0) unsigned NOT NULL,
  `icon` varchar(2000),
  `gifts` text,
  `expires_time` int(11) unsigned DEFAULT 0,
  `display` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `update_time` int(11) unsigned,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ny_log_mission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) NOT NULL,
  `server_id` varchar(100) NOT NULL,
  `mission_id` int(11) NOT NULL,
  `action` text,
  `create_time` int(11) unsigned,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
