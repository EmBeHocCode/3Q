/*
 Navicat Premium Data Transfer

 Source Server         : H5
 Source Server Type    : MySQL
 Source Server Version : 50744
 Source Host           : localhost:3306
 Source Schema         : tcg

 Target Server Type    : MySQL
 Target Server Version : 50744
 File Encoding         : 65001

 Date: 08/04/2025 11:51:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '全局唯一ID',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `open_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台openid',
  `platform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `channel_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道编码',
  `reg_IMEI` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册时的IMEI',
  `IMEI` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前IMEI',
  `balance` double NULL DEFAULT NULL COMMENT '账户余额（元）',
  `sa` tinyint(1) NULL DEFAULT 0 COMMENT '是否是超级账户',
  `last_active_time` timestamp NULL DEFAULT NULL COMMENT '最近活跃时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '账号创建时间',
  `device_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最近登录的设备码',
  `device_code_type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最近登录的设备码类型',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE INDEX `account_UN`(`username`) USING BTREE,
  INDEX `account_open_id_IDX`(`open_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('102b34e4-fdcf-4848-b5a8-a9cf465f67a6', '123123', '123123', '123123', '123123@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-03-29 08:36:55', '2025-03-28 20:36:55', '人造c7cf9344-ec22-4c5f-8a3f-a9f61ac6cf7e', 'IMEI');
INSERT INTO `account` VALUES ('15913be0-0ea5-40d2-81cb-71926ce75eed', 'lak000', 'lak000', 'lak000', 'lak000@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-05 10:02:25', '2025-03-26 20:37:32', '人造b43ffff2-dce5-41ac-b954-7565065aca8f', 'IMEI');
INSERT INTO `account` VALUES ('3f763f00-49fb-4d5a-8f17-7f93d4b0e22f', 'toan300', 'toan300', 'toan300', 'toan300@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-03-29 20:01:15', '2025-03-28 08:00:45', '人造c2583a37-773c-40b7-86a5-ee7ba914a4d9', 'IMEI');
INSERT INTO `account` VALUES ('466d444d-816b-49e9-a7c4-b0dd70c606cf', 'hoanghung', 'hoanghung', 'hoanghung', 'hoanghung@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-05 06:22:15', '2025-03-27 10:38:11', '人造1e873664-16b1-4585-9ae2-51f61694dfc0', 'IMEI');
INSERT INTO `account` VALUES ('46d0d847-7e07-4c41-96ed-ad34396dc9f3', '12345678h', '12345678h', '12345678h', '12345678h@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-05 09:45:38', '2025-04-04 21:45:38', '人造7a99ba53-7dd6-4582-a0a2-48816968204e', 'IMEI');
INSERT INTO `account` VALUES ('54e56d80-ee84-4a70-940b-d6187be9e442', 'admin', 'admin', 'admin', 'admin@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-03-25 17:48:37', '2025-03-22 04:05:18', '人造d216fc12-c56f-4779-9de8-08e31234338b', 'IMEI');
INSERT INTO `account` VALUES ('5cf5d7cf-9ddb-4457-9229-e267976bf76c', 'phucbaby', 'phucbaby', 'phucbaby', 'phucbaby@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-01 06:38:58', '2025-03-31 18:38:58', '人造f01c46c1-9ccc-4c97-ac87-ccc2cb01ae97', 'IMEI');
INSERT INTO `account` VALUES ('5d30f992-4e96-4315-bcd5-f35c0b9916a9', 'toan95', 'toan95', 'toan95', 'toan95@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-07 07:13:22', '2025-04-06 07:07:15', '人造956fee73-e4fe-4750-9eea-250589762c80', 'IMEI');
INSERT INTO `account` VALUES ('600eabab-692c-408d-92e4-606feca2e5c7', '234234', '234234', '234234', '234234@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-08 00:40:21', '2025-03-23 21:15:42', '人造89405978-5aac-4e61-901f-0c36c026bf15', 'IMEI');
INSERT INTO `account` VALUES ('657e8cf5-0346-42a8-9728-c5a8a91206d2', 'test13', 'test13', 'test13', 'test13@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-04 00:26:19', '2025-01-21 09:26:32', '人造11fc2f20-612d-4065-8baf-0029909757d3', 'IMEI');
INSERT INTO `account` VALUES ('6b56c0d1-83e0-4426-9254-5601702b4aab', 'thmodz', 'thmodz', 'thmodz', 'thmodz@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-04 04:19:29', '2025-04-03 16:19:29', '人造1c5f6503-da42-4961-9981-7cfe5f1737fe', 'IMEI');
INSERT INTO `account` VALUES ('6e9ab3d4-f808-4b1c-93da-f37c7890e197', 'test12', 'test12', 'test12', 'test12@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-03-29 12:26:10', '2025-03-21 19:56:25', '人造de1b45b8-ed3b-4928-8771-e12b5ed345a7', 'IMEI');
INSERT INTO `account` VALUES ('6edbdec7-c8a7-4111-a2fa-6c668b9b0025', 'hihihi', 'hihihi', 'hihihi', 'hihihi@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-05 04:02:25', '2025-04-04 16:02:25', '人造c2d00c82-e45e-4f3f-9489-29d42fa3e55e', 'IMEI');
INSERT INTO `account` VALUES ('7bdfd8ce-906c-4ebf-8117-286b2b4fb7a6', 'oiconga123', 'oiconga123', 'oiconga123', 'oiconga123@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-05 11:10:26', '2025-04-04 23:10:26', '人造68517c52-9ab4-498f-a124-c68d89b1d5f3', 'IMEI');
INSERT INTO `account` VALUES ('8425af68-ef25-4a73-9a4d-6ab7f6c17654', 'test111', 'test111', 'test111', 'test111@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-03-25 08:51:48', '2025-03-24 03:31:09', '人造5a5488be-265c-4d29-97bd-caca1e8ce1f7', 'IMEI');
INSERT INTO `account` VALUES ('95dae621-683e-4b23-a14f-203ebc2fc2a5', 'tungpuskin', 'tungpuskin', 'tungpuskin', 'tungpuskin@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-03-29 08:48:21', '2025-03-28 08:48:00', '人造7db53f29-410a-40bb-a52c-635b06b57331', 'IMEI');
INSERT INTO `account` VALUES ('9b8a69d0-f123-4c0c-97d0-d1d2aeec2d0e', 'alex123', 'alex123', 'alex123', 'alex123@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-02 03:46:40', '2025-03-30 08:12:06', '人造cf35d3c3-35bb-4374-8a9a-449734d87295', 'IMEI');
INSERT INTO `account` VALUES ('abe224c9-4cf4-415f-acd8-75a74e3cae4a', 'test11', 'test11', 'test11', 'test11@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-03-29 12:18:01', '2025-03-10 05:50:57', '人造bd46d3eb-dcfc-4e21-b284-ecd77f4aa50b', 'IMEI');
INSERT INTO `account` VALUES ('cd4966cc-fafb-4808-86e9-b34ccda84b88', 'khanhlam', 'khanhlam', 'khanhlam', 'khanhlam@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-03-30 03:21:11', '2025-03-29 02:15:17', '人造ee8bf7af-27fd-4b5b-b931-48e8a9cdc750', 'IMEI');
INSERT INTO `account` VALUES ('dfe7477a-18e6-4c3d-8b06-4a14edf17461', 'shuichi', 'shuichi', 'shuichi', 'shuichi@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-01 06:47:58', '2025-03-28 08:58:47', '人造4f30311a-35a8-432b-a5cf-06003e6372bb', 'IMEI');
INSERT INTO `account` VALUES ('ec65135d-2733-49d3-8ba4-ac6d5984215a', 'phucok', 'phucok', 'phucok', 'phucok@develop', 'develop', NULL, NULL, NULL, 0, 0, '2025-04-01 06:36:22', '2025-03-28 10:46:25', '人造03d98332-dfc1-4241-acdc-cf4f233fe0f0', 'IMEI');

-- ----------------------------
-- Table structure for account_master
-- ----------------------------
DROP TABLE IF EXISTS `account_master`;
CREATE TABLE `account_master`  (
  `account_uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号唯一ID',
  `srv_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏区服编码',
  `master_id_hex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主角的唯一ID',
  `master_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主角名称',
  `master_level` int(11) NULL DEFAULT NULL COMMENT '主角等级',
  `last_active_time` datetime NULL DEFAULT NULL COMMENT '最近活跃时间',
  PRIMARY KEY (`account_uid`, `master_id_hex`) USING BTREE,
  INDEX `account_master_account_uid_IDX`(`account_uid`) USING BTREE,
  INDEX `account_master_master_id_hex_IDX`(`master_id_hex`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账号下拥有的主角简单数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of account_master
-- ----------------------------
INSERT INTO `account_master` VALUES ('102b34e4-fdcf-4848-b5a8-a9cf465f67a6', 's1', '67e7e97190073674998a8b2e', 'Long0', 2, '2025-03-29 08:37:31');
INSERT INTO `account_master` VALUES ('15913be0-0ea5-40d2-81cb-71926ce75eed', 's1', '67e7e99090073674998a8b66', 'By6', 3, '2025-04-05 10:02:37');
INSERT INTO `account_master` VALUES ('466d444d-816b-49e9-a7c4-b0dd70c606cf', 's1', '67e8068590073674998a8c15', 'Thuy3', 57, '2025-04-05 06:22:19');
INSERT INTO `account_master` VALUES ('54e56d80-ee84-4a70-940b-d6187be9e442', 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 200, '2025-03-25 17:58:21');
INSERT INTO `account_master` VALUES ('5cf5d7cf-9ddb-4457-9229-e267976bf76c', 's1', '67ebc24ec261ae5c5a1568a2', 'Khanh0', 3, '2025-04-01 06:40:23');
INSERT INTO `account_master` VALUES ('5d30f992-4e96-4315-bcd5-f35c0b9916a9', 's1', '67f3b1e8c261ae5c5a1574cb', 'Vong8', 11, '2025-04-07 07:21:20');
INSERT INTO `account_master` VALUES ('600eabab-692c-408d-92e4-606feca2e5c7', 's1', '67e0ce62e36ade3322b1f37d', 'Higiu', 200, '2025-03-24 10:16:21');
INSERT INTO `account_master` VALUES ('600eabab-692c-408d-92e4-606feca2e5c7', 's1', '67f4a8b9c261ae5c5a15772b', 'Bua9', 1, '2025-04-08 00:40:33');
INSERT INTO `account_master` VALUES ('657e8cf5-0346-42a8-9728-c5a8a91206d2', 's1', '67e81f41682ed105c6bee271', 'DLGAME', 200, '2025-04-04 00:26:24');
INSERT INTO `account_master` VALUES ('6b56c0d1-83e0-4426-9254-5601702b4aab', 's1', '67ef9615c261ae5c5a156f7f', 'Ly7', 4, '2025-04-04 04:22:21');
INSERT INTO `account_master` VALUES ('6e9ab3d4-f808-4b1c-93da-f37c7890e197', 's1', '67e7dfecc9a3d57a8519855d', 'Lieu8', 2, '2025-03-29 12:25:59');
INSERT INTO `account_master` VALUES ('6e9ab3d4-f808-4b1c-93da-f37c7890e197', 's2', '67e7e37af078e635ca6bf84d', 'Heo8', 2, '2025-03-29 08:12:05');
INSERT INTO `account_master` VALUES ('6edbdec7-c8a7-4111-a2fa-6c668b9b0025', 's1', '67f0e396c261ae5c5a157142', 'Huc6', 2, '2025-04-05 04:02:49');
INSERT INTO `account_master` VALUES ('7bdfd8ce-906c-4ebf-8117-286b2b4fb7a6', 's1', '67f147ecc261ae5c5a15724b', 'Du0', 2, '2025-04-05 11:11:17');
INSERT INTO `account_master` VALUES ('8425af68-ef25-4a73-9a4d-6ab7f6c17654', 's1', '67e0d20be36ade3322b1f403', 'Tào', 2, '2025-03-25 08:52:18');
INSERT INTO `account_master` VALUES ('9b8a69d0-f123-4c0c-97d0-d1d2aeec2d0e', 's1', '67ebd85fc261ae5c5a156971', 'Mai7', 9, '2025-04-01 08:22:40');
INSERT INTO `account_master` VALUES ('abe224c9-4cf4-415f-acd8-75a74e3cae4a', 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 57, '2025-03-25 01:44:25');
INSERT INTO `account_master` VALUES ('abe224c9-4cf4-415f-acd8-75a74e3cae4a', 's1', '67e7dd11ba7f185f7d8029c5', 'Nhac0', 2, '2025-03-29 12:17:39');
INSERT INTO `account_master` VALUES ('cd4966cc-fafb-4808-86e9-b34ccda84b88', 's1', '67e8e17cc261ae5c5a156391', 'Thuy1', 9, '2025-03-30 02:22:25');
INSERT INTO `account_master` VALUES ('dfe7477a-18e6-4c3d-8b06-4a14edf17461', 's1', '67e7ee8b90073674998a8bb2', 'Tram2', 2, '2025-04-01 06:48:01');
INSERT INTO `account_master` VALUES ('ec65135d-2733-49d3-8ba4-ac6d5984215a', 's1', '67e807d790073674998a8c45', 'Dung2', 2, '2025-04-01 06:36:28');

-- ----------------------------
-- Table structure for account_master_migrate
-- ----------------------------
DROP TABLE IF EXISTS `account_master_migrate`;
CREATE TABLE `account_master_migrate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号唯一ID',
  `master_id_hex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主角的唯一ID',
  `master_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主角名称',
  `master_level` int(11) NULL DEFAULT NULL COMMENT '主角等级',
  `from_srv_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '从哪个游戏服',
  `to_srv_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '迁移到哪个游戏服',
  `merge_id` int(11) NULL DEFAULT NULL COMMENT '隶属于哪次合并操作ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账号角色迁移记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of account_master_migrate
-- ----------------------------

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `platform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `game_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `game_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `secret_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `client_path` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户端路径',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `associated_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '游戏应用配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES (1, '测试', 'develop', '10091', '7d08b21f87ac48f78e00bfe6e9caa362', '8c2c11186d39406b92ecfca7f18a0fb5', NULL, 'H5', NULL);

-- ----------------------------
-- Table structure for beta_record
-- ----------------------------
DROP TABLE IF EXISTS `beta_record`;
CREATE TABLE `beta_record`  (
  `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '平台OpenID',
  `pay_amount` double NULL DEFAULT NULL COMMENT '封测期间的充值总金额',
  `m1_done` tinyint(1) NULL DEFAULT NULL COMMENT '元宝返还完成',
  `m1_time` timestamp NULL DEFAULT NULL COMMENT '元宝领取时间',
  PRIMARY KEY (`open_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '封测记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of beta_record
-- ----------------------------

-- ----------------------------
-- Table structure for cloud_device
-- ----------------------------
DROP TABLE IF EXISTS `cloud_device`;
CREATE TABLE `cloud_device`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器设备编码',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器名',
  `host_WAN` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主机外网地址',
  `host_LAN` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主机内网地址',
  `host_domain` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主机域名',
  `ssh_user` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ssh_password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ssh_port` int(11) NULL DEFAULT NULL COMMENT 'ssh端口',
  `note` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '云服务器设备' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cloud_device
-- ----------------------------
INSERT INTO `cloud_device` VALUES (1, 'd1', NULL, '160.191.50.225', '127.0.0.1', '127.0.0.1', '', '', 22, NULL);
INSERT INTO `cloud_device` VALUES (2, 'yzxkfs1', NULL, '127.0.0.1', '127.0.0.1', NULL, '', '', 22, NULL);
INSERT INTO `cloud_device` VALUES (3, 'group', NULL, '127.0.0.1', '127.0.0.1', NULL, '', '', 22, NULL);
INSERT INTO `cloud_device` VALUES (4, 'cross-mq', NULL, '127.0.0.1', '127.0.0.1', NULL, '', '', 22, NULL);
INSERT INTO `cloud_device` VALUES (5, 'mysql-yzxdb1', NULL, NULL, '127.0.0.1', NULL, '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (6, 'mongo-yzxdb1', NULL, NULL, '127.0.0.1', NULL, '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (7, 'cross-yzx1', NULL, NULL, '127.0.0.1', NULL, '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (8, 'mongo-group', NULL, NULL, '127.0.0.1', NULL, '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (9, 'mysql-yzxdb1', '', '', '127.0.0.1', '', '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (10, 'mysql-yzxdb2', '', '', '127.0.0.1', '', '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (11, 'mysql-yzxdb3', '', '', '127.0.0.1', '', '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (12, 'mysql-yzxdb4', '', '', '127.0.0.1', '', '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (13, 'mysql-yzxdb5', '', '', '127.0.0.1', '', '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (14, 'mongo-yzxdb1', '', '', '127.0.0.1', '', '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (15, 'mongo-yzxdb2', '', '', '127.0.0.1', '', '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (16, 'mongo-yzxdb3', '', '', '127.0.0.1', '', '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (17, 'mongo-yzxdb4', '', '', '127.0.0.1', '', '', '', 0, NULL);
INSERT INTO `cloud_device` VALUES (18, 'mongo-yzxdb5', '', '', '127.0.0.1', '', '', '', 0, NULL);

-- ----------------------------
-- Table structure for cloud_mongo
-- ----------------------------
DROP TABLE IF EXISTS `cloud_mongo`;
CREATE TABLE `cloud_mongo`  (
  `id` int(11) NULL DEFAULT NULL,
  `code` varchar(48) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_mode` tinyint(4) NULL DEFAULT NULL,
  `conf_host` varchar(192) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_port` int(11) NULL DEFAULT NULL,
  `conf_username` varchar(48) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_password` varchar(192) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_source` varchar(48) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_database` varchar(96) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_url` varchar(900) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `note` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_url_public` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '连接url公网',
  `server_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联物理服务器编码',
  `conf_host_public` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公网host'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cloud_mongo
-- ----------------------------
INSERT INTO `cloud_mongo` VALUES (1, 'mongo-yzxdb1', 0, '127.0.0.1', 27017, 'abc123', 'Abc123321123', 'admin', NULL, NULL, NULL, NULL, 'mongo-yzxdb1', NULL);
INSERT INTO `cloud_mongo` VALUES (5, 'cross-yzx1', 0, '127.0.0.1', 27017, 'abc123', 'Abc123321123', 'admin', NULL, NULL, NULL, NULL, 'cross-yzx1', NULL);
INSERT INTO `cloud_mongo` VALUES (6, 'mongo-group', 0, '127.0.0.1', 27017, 'abc123', 'Abc123321123', 'admin', NULL, NULL, NULL, NULL, 'mongo-group', NULL);
INSERT INTO `cloud_mongo` VALUES (2, 'mongo-yzxdb2', 0, '127.0.0.1', 27017, 'abc123', 'Abc123321123', 'admin', NULL, NULL, NULL, NULL, 'mongo-yzxdb2', NULL);
INSERT INTO `cloud_mongo` VALUES (3, 'mongo-yzxdb3', 0, '127.0.0.1', 27017, 'abc123', 'Abc123321123', 'admin', '', '', '', '', 'mongo-yzxdb3', NULL);
INSERT INTO `cloud_mongo` VALUES (4, 'mongo-yzxdb4', 0, '127.0.0.1', 27017, 'abc123', 'Abc123321123', 'admin', '', '', '', '', 'mongo-yzxdb4', NULL);
INSERT INTO `cloud_mongo` VALUES (5, 'mongo-yzxdb5', 0, '127.0.0.1', 27017, 'abc123', 'Abc123321123', 'admin', '', '', '', '', 'mongo-yzxdb5', NULL);

-- ----------------------------
-- Table structure for cloud_mq
-- ----------------------------
DROP TABLE IF EXISTS `cloud_mq`;
CREATE TABLE `cloud_mq`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_host` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_username` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `server_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联物理服务器编码',
  `conf_port` int(11) NULL DEFAULT NULL COMMENT '端口',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '云mq服务配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cloud_mq
-- ----------------------------
INSERT INTO `cloud_mq` VALUES (1, 'yzx-mq1', '127.0.0.1', 'admin', 'Abc123456...a', NULL, 'cross-mq', 0);
INSERT INTO `cloud_mq` VALUES (4, 'group-mq', '127.0.0.1', 'admin', 'Abc123456...a', NULL, 'group', NULL);

-- ----------------------------
-- Table structure for cloud_mysql
-- ----------------------------
DROP TABLE IF EXISTS `cloud_mysql`;
CREATE TABLE `cloud_mysql`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_host` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_port` int(11) NULL DEFAULT NULL,
  `conf_username` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conf_database` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `server_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联物理服务器编码',
  `conf_host_public` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公网host',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '云mysql服务配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cloud_mysql
-- ----------------------------
INSERT INTO `cloud_mysql` VALUES (1, 'mysql-yzxdb1', '127.0.0.1', 3306, 'root', 'EHrWXkpA30e6f7CQx2cx', NULL, NULL, 'mysql-yzxdb1', NULL);
INSERT INTO `cloud_mysql` VALUES (2, 'mysql-yzxdb2', '127.0.0.1', 3306, 'root', 'EHrWXkpA30e6f7CQx2cx', '', '', 'mysql-yzxdb2', NULL);
INSERT INTO `cloud_mysql` VALUES (3, 'mysql-yzxdb3', '127.0.0.1', 3306, 'root', 'EHrWXkpA30e6f7CQx2cx', '', '', 'mysql-yzxdb3', NULL);
INSERT INTO `cloud_mysql` VALUES (4, 'mysql-yzxdb4', '127.0.0.1', 3306, 'root', 'EHrWXkpA30e6f7CQx2cx', '', '', 'mysql-yzxdb4', NULL);
INSERT INTO `cloud_mysql` VALUES (5, 'mysql-yzxdb5', '127.0.0.1', 3306, 'root', 'EHrWXkpA30e6f7CQx2cx', '', '', 'mysql-yzxdb5', NULL);

-- ----------------------------
-- Table structure for demo
-- ----------------------------
DROP TABLE IF EXISTS `demo`;
CREATE TABLE `demo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `val_double` double NULL DEFAULT NULL,
  `val_int` int(11) NULL DEFAULT NULL,
  `val_float` float NULL DEFAULT NULL,
  `val_boolean` tinyint(1) NULL DEFAULT NULL,
  `val_long` bigint(20) NULL DEFAULT NULL,
  `val_short` smallint(6) NULL DEFAULT NULL,
  `val_byte` tinyint(4) NULL DEFAULT NULL,
  `val_decimal` decimal(16, 6) NULL DEFAULT NULL,
  `val_datetime` datetime(3) NULL DEFAULT NULL,
  `val_timestamp` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '演示' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo
-- ----------------------------

-- ----------------------------
-- Table structure for dynamic_conf
-- ----------------------------
DROP TABLE IF EXISTS `dynamic_conf`;
CREATE TABLE `dynamic_conf`  (
  `key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一key',
  `value` varchar(4196) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'json 值',
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '动态配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dynamic_conf
-- ----------------------------
INSERT INTO `dynamic_conf` VALUES ('openbox', '{\"boxMap\":{\"10350\":590018,\"10343\":590018}}');
INSERT INTO `dynamic_conf` VALUES ('pay3m1', '10342');
INSERT INTO `dynamic_conf` VALUES ('pf', '{\"gameIds\":[\"10350\"]}');

-- ----------------------------
-- Table structure for game_rt
-- ----------------------------
DROP TABLE IF EXISTS `game_rt`;
CREATE TABLE `game_rt`  (
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '数据更新时间',
  `online` int(11) NULL DEFAULT NULL COMMENT '当前在线人数',
  `version` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '版本信息',
  `role_num` int(11) NULL DEFAULT NULL COMMENT '角色数量',
  `level_max` int(11) NULL DEFAULT NULL COMMENT '角色最高等级',
  `vip_max` int(11) NULL DEFAULT NULL COMMENT 'VIP最高等级',
  `power_max` bigint(20) NULL DEFAULT NULL COMMENT '最高等级',
  `power_avg_50` bigint(20) NULL DEFAULT NULL COMMENT '战力前50均值',
  `world_level` int(11) NULL DEFAULT NULL COMMENT '世界等级',
  `heap_memory_init` bigint(20) NULL DEFAULT NULL COMMENT '堆内存初始化',
  `heap_memory_max` bigint(20) NULL DEFAULT NULL COMMENT '堆内存最大(上限)',
  `heap_memory_used` bigint(20) NULL DEFAULT NULL COMMENT '堆内存当前(已使用)',
  `heap_memory_committed` bigint(20) NULL DEFAULT NULL COMMENT '堆内存提交的内存(已申请)',
  `heap_memory_use_rate` int(11) NULL DEFAULT NULL COMMENT '堆内存使用率',
  `non_heap_memory_init` bigint(20) NULL DEFAULT NULL COMMENT '非堆内存初始化',
  `non_heap_memory_max` bigint(20) NULL DEFAULT NULL COMMENT '非堆内存最大(上限)',
  `non_heap_memory_used` bigint(20) NULL DEFAULT NULL COMMENT '非堆内存当前(已使用)',
  `non_heap_memory_committed` bigint(20) NULL DEFAULT NULL COMMENT '非堆内存提交的内存(已申请)',
  `non_heap_memory_use_rate` int(11) NULL DEFAULT NULL COMMENT '非堆内存使用率',
  `thread_count` int(11) NULL DEFAULT NULL COMMENT '仍活动的线程总数',
  `thread_count_peak` int(11) NULL DEFAULT NULL COMMENT '自从java虚拟机启动或峰值重置以来峰值活动线程计数',
  `thread_count_total_started` bigint(20) NULL DEFAULT NULL COMMENT '线程总数（被创建并执行过的线程总数）',
  `thread_count_daemon` int(11) NULL DEFAULT NULL COMMENT '活动守护线程的当前数目',
  `thread_count_deadlocked` int(11) NULL DEFAULT NULL COMMENT '死锁线程数',
  `batch_cmd_code` int(11) NULL DEFAULT NULL COMMENT '批量命令结果码',
  `batch_cmd_msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '批量命令结果消息',
  `batch_cmd_time` timestamp NULL DEFAULT NULL COMMENT '批量命令时间',
  PRIMARY KEY (`srv_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '游戏实时数据' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of game_rt
-- ----------------------------
INSERT INTO `game_rt` VALUES ('s1', '2025-04-08 12:51:29', 0, 'tcg-game-server 版本: 1.5.0-SNAPSHOT 构建时间: 2022-03-30 15:57 仓库版本: d14b3ae0621b6b83b78d9b219bc7d58ba3352419 仓库分支: release/sf-2022-03-30 有无未提交: true, TcgCommon: 1.5.0 @ 2022-03-17 11:30 特性(YzxCommonResp YzxCommonReq bt重定向 easy-mysql)', 16, 200, 18, 144512, 5770, 12, 128, 1820, 574, 825, 69, 2, 0, 175, 184, 94, 79, 79, 82, 31, 0, 0, NULL, NULL);
INSERT INTO `game_rt` VALUES ('s2', '2025-03-29 20:13:21', 1, 'tcg-game-server 版本: 1.5.0-SNAPSHOT 构建时间: 2022-03-30 15:57 仓库版本: d14b3ae0621b6b83b78d9b219bc7d58ba3352419 仓库分支: release/sf-2022-03-30 有无未提交: true, TcgCommon: 1.5.0 @ 2022-03-17 11:30 特性(YzxCommonResp YzxCommonReq bt重定向 easy-mysql)', 0, 2, 14, 1298, 25, 0, 128, 1820, 548, 1088, 50, 2, 0, 132, 137, 96, 68, 68, 71, 29, 0, 0, NULL, NULL);

-- ----------------------------
-- Table structure for gm_announce
-- ----------------------------
DROP TABLE IF EXISTS `gm_announce`;
CREATE TABLE `gm_announce`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器编码',
  `platform_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `channel_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道代码',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `begin_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `content2` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容2',
  `title2` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题2',
  `content3` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容3',
  `title3` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '全服公告' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gm_announce
-- ----------------------------
INSERT INTO `gm_announce` VALUES (1, NULL, NULL, NULL, '10091', '尊敬的上仙：', '尊敬的上仙：\n我们预计将于2022年3月31日（本周四）上午08：30进行例行维护，维护时间约2小时，部分服务器将视实际情况提前开启；如有意外，维护时间将可能顺延，请见谅！维护期间游戏将无法登陆，请上仙们提前安排好自己的游戏时间，以防造成不必要的损失，以下为本次维护更新内容：\n\n【运营活动】\n1.《铸印大师》：2022年4月1日至4月7日，开服大于15天开启，持续7天。活动期间内，全跨服组内进行玺印重铸消耗的鎏金粉全部打9折，且重铸消耗的鎏金粉数量会被记录至排行榜，活动结束后根据排行榜发放超强奖励。\n2.《印玺礼包》：2022年4月1日至4月7日，持续7天。限时特惠印玺材料商品限时出售，诸多好礼等你选购。\n3.《会武商城》：2022年4月1日至4月7日，持续7天。战力提升精选礼包限时出售，一期一会，备战攀升大比拼。\n4.《英雄继承》：2022年4月1日至4月7日，持续7天。活动期间内，玩家可以通过消耗元神、金丹元神进行英雄继承。\n5.《仙器继承》：2022年4月1日至4月7日，持续7天。活动期间内，玩家可以通过消耗补天残片进行仙器继承。\n6.《英雄祈愿》：2022年4月1日至4月7日，开服达到第8天开启，持续7天。活动期间内，玩家可指定某个英雄进行召唤，指定英雄被召唤的几率会大大提升。\n7.《多多益善》：2022年4月1日至4月7日，开服达到第8天开启，持续7天。活动期间内，玩家进行高级/精英/祈愿召唤达到指定次数可领取丰厚奖励。\n8.《藏品封印》：2022年4月1日至4月7日，持续7天。活动期间内，玩家可以将英雄专属藏品进行封印，封印后返还藏品珍藏宝盒。\n9.《神龙契约》：2022年4月1日至4月14日，持续14天，主角达到90级开启，活动期间玩家可以免费领取幼年龙宝宝。另有神龙契约获得超值奖励，解锁“初级契约”后可直接获得青年龙，积分全部达成可以获得壮年龙；解锁“高级契约”后即可直接获得壮年龙，积分全部达成可以获得龙王。\n10.《皮肤上新-魔道至尊》：2022年4月1日至4月14日，开服大于7天开启，持续14天。活动时间内购买“魔道至尊”后即解锁进阶版特权，可立即获得“万古魔皇·玉帝（永久）”皮肤和其他超值奖励（战令特权持续14天）。\n11.《天降福袋》：2022年4月8日至4月9日、4月10日至4月11日、4月12日至4月13日，共3期，持续6天。活动期间内，购买礼包即可获得奖券，抽取高额奖励。\n12.《元宝消耗排行》：2022年4月8日至4月14日，世界等级达到70级开启，持续7天。活动时间内，玩家消耗的元宝将会被记录到排行榜，活动结束后可获得超值奖励。\n13.《幸运盲盒》：2022年4月8日至4月14日，持续7天。活动期间内，挂机有概率获得“幸运盲盒”，打开盲盒有几率获得惊喜大奖。（幸运盲盒可用“幸运秘钥”打开）\n14.《皮肤返厂》：本期返厂英雄：潘达-灵媒魔女、星空莲华-混天大圣。2022年4月8日至4月14日，持续7天。活动期间内，玩家可用元宝进行召唤，有概率召唤出专属仙器或仙器碎片；召唤达到指定次数，可以获得皮肤碎片等超值奖励。\n15.《魔术戏法》：2022年4月8日至4月14日开启，持续7天。活动期间内：挂机和“BOSS大作战”中都可以获得“糖果”道具；使用糖果道具可在“魔法召唤”中召唤各种奖励，包括“糖人”道具等；使用糖人道具将可在“礼物兑换”中进行高级道具兑换；另有“糖果礼包”等超值奖励等你来拿！~\n\n\n\n\n', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for gm_chat_forbid
-- ----------------------------
DROP TABLE IF EXISTS `gm_chat_forbid`;
CREATE TABLE `gm_chat_forbid`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器编码',
  `master_id_hex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角唯一ID',
  `master_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角名字',
  `until` bigint(20) NULL DEFAULT NULL COMMENT '禁言时间戳',
  `reason` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '禁言原因',
  `el_username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行人用户名',
  `el_nickname` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行人昵称',
  `el_time` datetime NULL DEFAULT NULL COMMENT '执行时间',
  `el_errorcode` int(11) NULL DEFAULT NULL COMMENT '操作结果码',
  `el_errormsg` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gm_chat_forbid
-- ----------------------------

-- ----------------------------
-- Table structure for gm_freeze
-- ----------------------------
DROP TABLE IF EXISTS `gm_freeze`;
CREATE TABLE `gm_freeze`  (
  `master_id_hex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主角唯一ID',
  `master_mid` int(11) NULL DEFAULT NULL COMMENT '主角mid',
  `master_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角名',
  `srv_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器编码',
  `srv_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器名',
  `reason` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '冻结原因',
  `until` datetime NULL DEFAULT NULL COMMENT '冻结截止日期',
  `el_username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `el_nickname` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `el_time` datetime NULL DEFAULT NULL,
  `el_errorcode` int(11) NULL DEFAULT NULL,
  `el_errormsg` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`master_id_hex`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'GM冻结角色' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gm_freeze
-- ----------------------------

-- ----------------------------
-- Table structure for gm_lamp
-- ----------------------------
DROP TABLE IF EXISTS `gm_lamp`;
CREATE TABLE `gm_lamp`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '指定GameId才能看到',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '指定服务器组ID',
  `srv_index_beg` int(11) NULL DEFAULT NULL COMMENT '服务器开始序号',
  `srv_index_end` int(11) NULL DEFAULT NULL COMMENT '服务器结束序号',
  `srv_codes` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '指定游戏服编码列表',
  `content` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '内容',
  `style` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式类型',
  `begin_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `interval` bigint(20) NULL DEFAULT NULL COMMENT '间隔时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'GM跑马灯' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gm_lamp
-- ----------------------------

-- ----------------------------
-- Table structure for gm_mail_approval
-- ----------------------------
DROP TABLE IF EXISTS `gm_mail_approval`;
CREATE TABLE `gm_mail_approval`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '审核时间',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮件标题',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮件内容',
  `reward` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮件奖励',
  `operation` int(11) NULL DEFAULT NULL COMMENT '邮件操作原因',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '邮件状态',
  `submit_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提交人的昵称',
  `submit_nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提交人昵称',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `approve_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人的用户名',
  `approve_nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批人昵称',
  `approve_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `invalid_time` datetime NULL DEFAULT NULL COMMENT '失效时间',
  `schedule_time` datetime NULL DEFAULT NULL COMMENT '定时时间',
  `mail_type` tinyint(4) NULL DEFAULT NULL COMMENT '邮件类型',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_mtype_stime`(`mail_type`, `schedule_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gm_mail_approval
-- ----------------------------
INSERT INTO `gm_mail_approval` VALUES (1, 2, '111111', '111111', '0:1:10000', 11, 2, 'admin', '芸豆超管', '2022-04-06 23:09:18', 'admin', '芸豆超管', '2022-04-06 23:09:25', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (2, 2, '11', '1111', '0:0:10000', 12, 2, 'ceshi', '测试', '2022-04-06 23:09:41', 'ceshi', '测试', '2022-04-06 23:09:45', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (3, 1, 'GM给你发奖金了，大佬们，狂欢吧。', 'GM给你发奖金了，大佬们，狂欢吧。大声喊出6666.', '0:0:1000000000#0:1:99999999#0:4:2999999999#0:3:299999999#1:400610:1#1:400710:1#1:400910:1#1:401210:1#1:401410:1#3:100001:100000#2:20000416:5#2:20000316:5#2:20000216:5#2:20000116:5#3:999999:9999999', 11, 2, 'admin', '芸豆超管', '2022-04-06 23:11:10', 'admin', '芸豆超管', '2022-04-06 23:11:16', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (4, 2, '1', '22', '0:1:9999000#0:3:999999999', 11, 2, 'ceshi', '测试', '2022-04-06 23:12:30', 'ceshi', '测试', '2022-04-06 23:13:09', '2022-04-06 23:12:27', NULL, 1);
INSERT INTO `gm_mail_approval` VALUES (5, 2, 'a', '1', '1:600601:1#1:600501:1#1:600401:1#1:600301:1#1:600201:1#1:600101:1', 12, 2, 'admin', '超管', '2025-03-23 03:33:22', 'admin', '超管', '2025-03-23 03:33:23', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (6, 2, '1', '1', '0:3:9999999', 12, 2, 'admin', '超管', '2025-03-23 03:38:42', 'admin', '超管', '2025-03-23 03:38:43', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (7, 2, 'â', 'a', '0:3:99999999999', 12, 2, 'admin', '超管', '2025-03-23 03:39:09', 'admin', '超管', '2025-03-23 03:39:10', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (8, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', '3:999999:200000', 12, 2, 'admin', '超管', '2025-03-23 12:52:01', 'admin', '超管', '2025-03-23 12:52:03', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (9, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '0:3:9999999', 12, 2, 'admin', '超管', '2025-03-23 13:56:41', 'admin', '超管', '2025-03-23 13:56:42', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (10, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Viêm 14*] số lượng [x1] với giá [900000 Xu] tại máy chủ [1]', '1:600210:1', 12, 2, 'admin', '超管', '2025-03-23 13:57:01', 'admin', '超管', '2025-03-23 13:57:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (11, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '3:999999:99999999', 12, 2, 'admin', '超管', '2025-03-24 02:07:17', 'admin', '超管', '2025-03-24 02:07:18', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (12, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '2:20000116:9', 12, 2, 'admin', '超管', '2025-03-24 02:30:21', 'admin', '超管', '2025-03-24 02:30:22', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (13, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Viêm 14*] số lượng [x1] với giá [900000 Xu] tại máy chủ [1]', '1:600210:1', 12, 2, 'admin', '超管', '2025-03-24 02:58:01', 'admin', '超管', '2025-03-24 02:58:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (14, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Nghề Nghiệp Tiên Khí Hộp Quà] số lượng [x1] với giá [350000 Xu] tại máy chủ [1]', '3:500094:1', 12, 2, 'admin', '超管', '2025-03-24 03:27:01', 'admin', '超管', '2025-03-24 03:27:01', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (15, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 1000k] số lượng [x1000000] với giá [1000000 Xu] tại máy chủ [1]', '3:999999:1000000', 12, 2, 'admin', '超管', '2025-03-24 13:11:01', 'admin', '超管', '2025-03-24 13:11:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (16, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:101401:1:1', 12, 2, 'admin', '超管', '2025-03-25 09:49:41', 'admin', '超管', '2025-03-25 09:49:46', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (17, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:202001:1', 12, 2, 'admin', '超管', '2025-03-25 09:55:41', 'admin', '超管', '2025-03-25 09:55:41', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (18, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', '3:999999:100000', 12, 2, 'admin', '超管', '2025-03-25 11:49:01', 'admin', '超管', '2025-03-25 11:49:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (19, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Quang 14*] số lượng [x1] với giá [900000 Xu] tại máy chủ [1]', '1:600310:1', 12, 2, 'admin', '超管', '2025-03-25 12:08:02', 'admin', '超管', '2025-03-25 12:08:03', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (20, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', '3:999999:100000', 12, 2, 'admin', '超管', '2025-03-25 12:13:01', 'admin', '超管', '2025-03-25 12:13:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (21, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', '3:999999:100000', 12, 2, 'admin', '超管', '2025-03-25 12:13:01', 'admin', '超管', '2025-03-25 12:13:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (22, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', '3:999999:500000', 12, 2, 'admin', '超管', '2025-03-25 12:14:02', 'admin', '超管', '2025-03-25 12:14:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (23, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', '3:999999:500000', 12, 2, 'admin', '超管', '2025-03-25 12:21:02', 'admin', '超管', '2025-03-25 12:21:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (24, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', '3:999999:500000', 12, 2, 'admin', '超管', '2025-03-25 12:21:02', 'admin', '超管', '2025-03-25 12:21:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (25, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', '3:999999:500000', 12, 2, 'admin', '超管', '2025-03-25 12:22:01', 'admin', '超管', '2025-03-25 12:22:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (26, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', '3:999999:200000', 12, 2, 'admin', '超管', '2025-03-25 12:22:02', 'admin', '超管', '2025-03-25 12:22:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (27, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', '3:999999:500000', 12, 2, 'admin', '超管', '2025-03-25 12:22:02', 'admin', '超管', '2025-03-25 12:22:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (28, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', '3:999999:500000', 12, 2, 'admin', '超管', '2025-03-25 12:24:01', 'admin', '超管', '2025-03-25 12:24:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (29, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', '3:999999:200000', 12, 2, 'admin', '超管', '2025-03-25 12:29:01', 'admin', '超管', '2025-03-25 12:29:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (30, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', '3:999999:100000', 12, 2, 'admin', '超管', '2025-03-25 12:31:02', 'admin', '超管', '2025-03-25 12:31:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (31, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', '3:999999:200000', 12, 2, 'admin', '超管', '2025-03-25 12:32:01', 'admin', '超管', '2025-03-25 12:32:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (32, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', '3:999999:200000', 12, 2, 'admin', '超管', '2025-03-25 12:32:01', 'admin', '超管', '2025-03-25 12:32:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (33, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', '3:999999:100000', 12, 2, 'admin', '超管', '2025-03-25 12:48:01', 'admin', '超管', '2025-03-25 12:48:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (34, 2, 'Mua vật phẩm thành công', 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', '3:999999:500000', 12, 2, 'admin', '超管', '2025-03-25 12:48:02', 'admin', '超管', '2025-03-25 12:48:02', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (35, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:802801:1', 12, 2, 'admin', '超管', '2025-03-25 17:01:16', 'admin', '超管', '2025-03-25 17:01:16', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (36, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:802401:1', 12, 2, 'admin', '超管', '2025-03-25 17:01:16', 'admin', '超管', '2025-03-25 17:01:17', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (37, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:802301:1', 12, 2, 'admin', '超管', '2025-03-25 17:01:16', 'admin', '超管', '2025-03-25 17:01:17', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (38, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:803501:1', 12, 2, 'admin', '超管', '2025-03-25 17:01:17', 'admin', '超管', '2025-03-25 17:01:17', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (39, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:802801:1', 12, 2, 'admin', '超管', '2025-03-25 17:12:02', 'admin', '超管', '2025-03-25 17:12:03', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (40, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:802401:1', 12, 2, 'admin', '超管', '2025-03-25 17:12:03', 'admin', '超管', '2025-03-25 17:12:03', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (41, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:802301:1', 12, 2, 'admin', '超管', '2025-03-25 17:12:03', 'admin', '超管', '2025-03-25 17:12:03', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (42, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:803501:1', 12, 2, 'admin', '超管', '2025-03-25 17:12:03', 'admin', '超管', '2025-03-25 17:12:04', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (43, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:802001:1', 12, 2, 'admin', '超管', '2025-03-25 17:12:48', 'admin', '超管', '2025-03-25 17:12:49', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (44, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:801901:1', 12, 2, 'admin', '超管', '2025-03-25 17:12:48', 'admin', '超管', '2025-03-25 17:12:49', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (45, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:804701:1', 12, 2, 'admin', '超管', '2025-03-25 17:12:49', 'admin', '超管', '2025-03-25 17:12:49', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (46, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '0:16:10000000', 12, 2, 'admin', '超管', '2025-03-30 00:16:39', 'admin', '超管', '2025-03-30 00:16:40', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (47, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '0:16:10000000', 12, 2, 'admin', '超管', '2025-03-30 00:17:11', 'admin', '超管', '2025-03-30 00:17:11', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (48, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '0:16:10000000', 12, 2, 'admin', '超管', '2025-03-30 00:17:45', 'admin', '超管', '2025-03-30 00:17:45', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (49, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '0:16:10000000', 12, 2, 'admin', '超管', '2025-03-30 00:18:53', 'admin', '超管', '2025-03-30 00:18:54', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (50, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600601:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:16', 'admin', '超管', '2025-03-30 13:39:17', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (51, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600701:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:16', 'admin', '超管', '2025-03-30 13:39:17', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (52, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600801:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:17', 'admin', '超管', '2025-03-30 13:39:17', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (53, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600901:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:17', 'admin', '超管', '2025-03-30 13:39:17', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (54, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601001:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:17', 'admin', '超管', '2025-03-30 13:39:18', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (55, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601101:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:17', 'admin', '超管', '2025-03-30 13:39:18', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (56, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601201:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:17', 'admin', '超管', '2025-03-30 13:39:18', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (57, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:6001301:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:18', 'admin', '超管', '2025-03-30 13:39:18', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (58, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601401:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:18', 'admin', '超管', '2025-03-30 13:39:18', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (59, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601501:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:18', 'admin', '超管', '2025-03-30 13:39:18', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (60, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601601:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:18', 'admin', '超管', '2025-03-30 13:39:19', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (61, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601701:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:18', 'admin', '超管', '2025-03-30 13:39:19', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (62, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601801:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:19', 'admin', '超管', '2025-03-30 13:39:19', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (63, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601901:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:19', 'admin', '超管', '2025-03-30 13:39:19', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (64, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:602001:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:19', 'admin', '超管', '2025-03-30 13:39:19', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (65, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600601:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:33', 'admin', '超管', '2025-03-30 13:39:34', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (66, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600701:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:34', 'admin', '超管', '2025-03-30 13:39:34', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (67, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600801:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:34', 'admin', '超管', '2025-03-30 13:39:34', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (68, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600901:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:34', 'admin', '超管', '2025-03-30 13:39:34', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (69, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601001:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:34', 'admin', '超管', '2025-03-30 13:39:35', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (70, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601101:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:34', 'admin', '超管', '2025-03-30 13:39:35', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (71, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601201:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:34', 'admin', '超管', '2025-03-30 13:39:35', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (72, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:6001301:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:35', 'admin', '超管', '2025-03-30 13:39:35', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (73, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601401:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:35', 'admin', '超管', '2025-03-30 13:39:35', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (74, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601501:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:36', 'admin', '超管', '2025-03-30 13:39:36', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (75, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601601:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:36', 'admin', '超管', '2025-03-30 13:39:36', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (76, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601701:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:36', 'admin', '超管', '2025-03-30 13:39:37', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (77, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601801:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:36', 'admin', '超管', '2025-03-30 13:39:37', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (78, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601901:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:36', 'admin', '超管', '2025-03-30 13:39:37', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (79, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:602001:1', 12, 2, 'admin', '超管', '2025-03-30 13:39:36', 'admin', '超管', '2025-03-30 13:39:37', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (80, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600601:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:45', 'admin', '超管', '2025-03-30 13:47:46', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (81, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600701:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:46', 'admin', '超管', '2025-03-30 13:47:46', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (82, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600801:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:48', 'admin', '超管', '2025-03-30 13:47:48', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (83, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:600901:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:48', 'admin', '超管', '2025-03-30 13:47:48', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (84, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601001:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:48', 'admin', '超管', '2025-03-30 13:47:49', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (85, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601101:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:48', 'admin', '超管', '2025-03-30 13:47:49', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (86, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601201:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:48', 'admin', '超管', '2025-03-30 13:47:49', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (87, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:6001301:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:48', 'admin', '超管', '2025-03-30 13:47:49', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (88, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601401:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:48', 'admin', '超管', '2025-03-30 13:47:49', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (89, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601501:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:50', 'admin', '超管', '2025-03-30 13:47:50', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (90, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601601:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:51', 'admin', '超管', '2025-03-30 13:47:51', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (91, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601701:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:51', 'admin', '超管', '2025-03-30 13:47:51', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (92, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601801:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:51', 'admin', '超管', '2025-03-30 13:47:52', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (93, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601901:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:51', 'admin', '超管', '2025-03-30 13:47:52', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (94, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:602001:1', 12, 2, 'admin', '超管', '2025-03-30 13:47:51', 'admin', '超管', '2025-03-30 13:47:52', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (95, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '0:0:10000000000', 12, 2, 'admin', '超管', '2025-03-30 13:47:51', 'admin', '超管', '2025-03-30 13:47:52', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (96, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '0:4:10000000000', 12, 2, 'admin', '超管', '2025-03-30 13:47:51', 'admin', '超管', '2025-03-30 13:47:52', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (97, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '3:100001:10000000', 12, 2, 'admin', '超管', '2025-03-30 13:47:52', 'admin', '超管', '2025-03-30 13:47:52', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (98, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '0:3:9999999999', 12, 2, 'admin', '超管', '2025-03-30 13:49:45', 'admin', '超管', '2025-03-30 13:49:45', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (99, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601301:1', 12, 2, 'admin', '超管', '2025-03-31 01:57:55', 'admin', '超管', '2025-03-31 01:57:55', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (100, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601301:1', 12, 2, 'admin', '超管', '2025-03-31 01:58:27', 'admin', '超管', '2025-03-31 01:58:27', NULL, NULL, 0);
INSERT INTO `gm_mail_approval` VALUES (101, 2, '[Hệ Thống]', 'Vật phẩm được gửi từ hệ thống', '1:601601:1', 12, 2, 'admin', '超管', '2025-03-31 01:58:59', 'admin', '超管', '2025-03-31 01:59:00', NULL, NULL, 0);

-- ----------------------------
-- Table structure for gm_mail_tar
-- ----------------------------
DROP TABLE IF EXISTS `gm_mail_tar`;
CREATE TABLE `gm_mail_tar`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `mail_id` int(11) NOT NULL COMMENT '邮件id',
  `type` tinyint(4) NOT NULL COMMENT '邮件类型',
  `srv_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `master_id_hex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角唯一ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标姓名',
  `platform_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_mail_id`(`mail_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gm_mail_tar
-- ----------------------------
INSERT INTO `gm_mail_tar` VALUES (1, 1, 2, 's1', '624dace0e87f7533576c9782', '888888', 'develop');
INSERT INTO `gm_mail_tar` VALUES (2, 2, 2, 's1', '624dab50e87f7533576c96e9', '柯大开', 'develop');
INSERT INTO `gm_mail_tar` VALUES (3, 3, 1, 's1', NULL, '测试1服', 'develop');
INSERT INTO `gm_mail_tar` VALUES (5, 4, 2, 's1', '624dabede87f7533576c9741', '李三问', 'develop');
INSERT INTO `gm_mail_tar` VALUES (6, 5, 2, 's1', '67df0ecf6e5dc971faecb456', 'Thuy1', 'develop');
INSERT INTO `gm_mail_tar` VALUES (7, 6, 2, 's1', '67df0ecf6e5dc971faecb456', 'Thuy1', 'develop');
INSERT INTO `gm_mail_tar` VALUES (8, 7, 2, 's1', '67df0ecf6e5dc971faecb456', 'Thuy1', 'develop');
INSERT INTO `gm_mail_tar` VALUES (9, 8, 2, 's1', '67df9335e7717c2e18b7de9f', 'Thien2', 'develop');
INSERT INTO `gm_mail_tar` VALUES (10, 9, 2, 's1', '67df9335e7717c2e18b7de9f', 'Thien2', 'develop');
INSERT INTO `gm_mail_tar` VALUES (11, 10, 2, 's1', '67df9335e7717c2e18b7de9f', 'Thien2', 'develop');
INSERT INTO `gm_mail_tar` VALUES (12, 11, 2, 's1', '67e04d63cdb87869e6fdb5f6', '贺追命', 'develop');
INSERT INTO `gm_mail_tar` VALUES (13, 12, 2, 's1', '67e04d63cdb87869e6fdb5f6', '贺追命', 'develop');
INSERT INTO `gm_mail_tar` VALUES (14, 13, 2, 's1', '67e04d63cdb87869e6fdb5f6', '贺追命', 'develop');
INSERT INTO `gm_mail_tar` VALUES (15, 14, 2, 's1', '67df9335e7717c2e18b7de9f', 'Thien2', 'develop');
INSERT INTO `gm_mail_tar` VALUES (16, 15, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (17, 16, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (18, 17, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (19, 18, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (20, 19, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (21, 20, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (22, 21, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (23, 22, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (24, 23, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (25, 24, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (26, 25, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (27, 26, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (28, 27, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (29, 28, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (30, 29, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (31, 30, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (32, 31, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (33, 32, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (34, 33, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (35, 34, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (36, 35, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (37, 36, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (38, 37, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (39, 38, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (40, 39, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (41, 40, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (42, 41, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (43, 42, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (44, 43, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (45, 44, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (46, 45, 2, 's1', '67e04d63cdb87869e6fdb5f6', 'Tháo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (47, 46, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (48, 47, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (49, 48, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (50, 49, 2, 's1', '67e7dfecc9a3d57a8519855d', 'Lieu8', 'develop');
INSERT INTO `gm_mail_tar` VALUES (51, 50, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (52, 51, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (53, 52, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (54, 53, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (55, 54, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (56, 55, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (57, 56, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (58, 57, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (59, 58, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (60, 59, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (61, 60, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (62, 61, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (63, 62, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (64, 63, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (65, 64, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (66, 65, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (67, 66, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (68, 67, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (69, 68, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (70, 69, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (71, 70, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (72, 71, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (73, 72, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (74, 73, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (75, 74, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (76, 75, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (77, 76, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (78, 77, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (79, 78, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (80, 79, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (81, 80, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (82, 81, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (83, 82, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (84, 83, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (85, 84, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (86, 85, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (87, 86, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (88, 87, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (89, 88, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (90, 89, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (91, 90, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (92, 91, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (93, 92, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (94, 93, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (95, 94, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (96, 95, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (97, 96, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (98, 97, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (99, 98, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (100, 99, 2, 's1', '67df9335e7717c2e18b7de9f', 'Tháooo', 'develop');
INSERT INTO `gm_mail_tar` VALUES (101, 100, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');
INSERT INTO `gm_mail_tar` VALUES (102, 101, 2, 's1', '67e81f41682ed105c6bee271', 'Gum4', 'develop');

-- ----------------------------
-- Table structure for gm_notice
-- ----------------------------
DROP TABLE IF EXISTS `gm_notice`;
CREATE TABLE `gm_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` int(11) NULL DEFAULT NULL COMMENT '通知类型',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标服务器编码',
  `el_username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行人用户名',
  `el_nickname` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行人昵称',
  `el_time` datetime NULL DEFAULT NULL COMMENT '执行时间',
  `el_errorcode` int(11) NULL DEFAULT NULL COMMENT '操作结果码',
  `el_errormsg` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'GM通知表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gm_notice
-- ----------------------------

-- ----------------------------
-- Table structure for gm_rebate_approval
-- ----------------------------
DROP TABLE IF EXISTS `gm_rebate_approval`;
CREATE TABLE `gm_rebate_approval`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮件标题',
  `content` varchar(2800) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮件内容',
  `submit_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提交人的昵称',
  `submit_nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提交人昵称',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `approve_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人的用户名',
  `approve_nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批人昵称',
  `approve_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '审核状态',
  `query_date` datetime NULL DEFAULT NULL COMMENT '查询日期',
  `reward_desc` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '奖励详情',
  `type` tinyint(4) NULL DEFAULT NULL,
  `reward_id` int(11) NULL DEFAULT NULL COMMENT '奖励id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_status`(`status`) USING BTREE,
  INDEX `index_submit_time`(`submit_time`) USING BTREE,
  INDEX `idx_type_date_status`(`type`, `query_date`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gm_rebate_approval
-- ----------------------------

-- ----------------------------
-- Table structure for gm_rebate_tar
-- ----------------------------
DROP TABLE IF EXISTS `gm_rebate_tar`;
CREATE TABLE `gm_rebate_tar`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `rebate_id` int(11) NOT NULL COMMENT '返利邮件id',
  `srv_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `master_id_hex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主角唯一ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标姓名',
  `platform_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_rebate_id`(`rebate_id`) USING BTREE,
  INDEX `idx_master_id_hex`(`master_id_hex`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gm_rebate_tar
-- ----------------------------

-- ----------------------------
-- Table structure for merge_map
-- ----------------------------
DROP TABLE IF EXISTS `merge_map`;
CREATE TABLE `merge_map`  (
  `srv_code_origin` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '原始服务器编码',
  `srv_code_current` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前目标主服务器编码',
  `srv_name_origin` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原始服务器名',
  `srv_name_current` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前目标服务器名',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '映射更新时间',
  `note` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`srv_code_origin`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '合服映射' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of merge_map
-- ----------------------------

-- ----------------------------
-- Table structure for pay_approval
-- ----------------------------
DROP TABLE IF EXISTS `pay_approval`;
CREATE TABLE `pay_approval`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_type` tinyint(4) NULL DEFAULT NULL COMMENT '订单类型',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '审核状态 1待审核 2同意 3拒绝',
  `platform_order_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台订单号',
  `item_tid` int(11) NULL DEFAULT NULL COMMENT '支付项模板ID',
  `item_count` int(11) NULL DEFAULT NULL COMMENT '支付项数量',
  `item_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付项名称',
  `pay_amount` double NULL DEFAULT NULL COMMENT '付款总金额(元)',
  `srv_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服务器代码',
  `platform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `channel_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道编码',
  `platform_open_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台openId',
  `account_uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角所属账号的唯一ID',
  `master_id_hex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角唯一ID',
  `master_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角姓名',
  `submit_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提交人用户名',
  `submit_nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提交人昵称',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `approve_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人用户名',
  `approve_nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人昵称',
  `approve_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `currency_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付币种代码',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sub_uname`(`submit_username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_approval
-- ----------------------------

-- ----------------------------
-- Table structure for pay_indirect
-- ----------------------------
DROP TABLE IF EXISTS `pay_indirect`;
CREATE TABLE `pay_indirect`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `platform_order_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台订单ID',
  `pay_num_fen` bigint(20) NULL DEFAULT NULL COMMENT '支付金额（分）',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `srv_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器编码',
  `srv_index` int(11) NULL DEFAULT NULL COMMENT '服务器序号',
  `game_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `channel_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `platform_open_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台OpenID',
  `reward_conf` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '奖励配置',
  `reward_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '奖励描述',
  `step` tinyint(4) NULL DEFAULT NULL COMMENT '步骤',
  `other_info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其他信息',
  `error_info` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '错误信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '间接支付' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_indirect
-- ----------------------------

-- ----------------------------
-- Table structure for pay_record
-- ----------------------------
DROP TABLE IF EXISTS `pay_record`;
CREATE TABLE `pay_record`  (
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一ID',
  `order_type` tinyint(4) NULL DEFAULT NULL COMMENT '订单类型',
  `platform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `channel_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道编码',
  `platform_order_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台订单号',
  `platform_open_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台openId',
  `platform_pay_status` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台支付状态',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `context_str` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单上下文',
  `step` tinyint(4) NULL DEFAULT NULL COMMENT '步骤',
  `retry_times` int(11) NULL DEFAULT 0 COMMENT '重试次数',
  `note` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一些备注',
  `srv_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服务器代码',
  `item_tid` int(11) NULL DEFAULT NULL COMMENT '支付项模板ID',
  `item_count` int(11) NULL DEFAULT NULL COMMENT '支付项数量',
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付项名称',
  `pay_amount` double NULL DEFAULT NULL COMMENT '付款总金额(元)',
  `account_uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角所属账号的唯一ID',
  `master_id_hex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角唯一ID',
  `master_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角姓名',
  `el_username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行人用户名',
  `el_nickname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行人昵称',
  `currency_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付币种代码',
  `trade_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计费点',
  `plugin` int(11) NULL DEFAULT 0 COMMENT '插件逻辑',
  `plugin_attachment` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '插件逻辑附件信息',
  `lang_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语言编码',
  `activity_extra` int(11) NULL DEFAULT NULL COMMENT '活动额外赠予',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `item_name_cn` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付项名称(中文)',
  `raw_order_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原始订单号',
  `third_gift_stone` int(255) NULL DEFAULT NULL,
  `third_ware_count` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `record_platform_order_id_IDX`(`platform_order_id`) USING BTREE,
  INDEX `pay_record_pay_time_IDX`(`pay_time`) USING BTREE,
  INDEX `pay_record_create_time_IDX`(`create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '充值记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_record
-- ----------------------------
INSERT INTO `pay_record` VALUES ('015de8a9-c29f-4505-9e94-77dc0b3be79b', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:41', NULL, 1, 0, NULL, 's1', 18004, 1, '充值-128元', 100000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.128', 0, NULL, 'zh_CN', 0, '10091', '充值-128元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('02fd91a2-b8ce-4017-b9bb-205ccdbfcf24', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:30', NULL, 1, 0, NULL, 's1', 19008, 1, '每日礼包', 50000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.12', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('063ce260-3a6b-4514-886a-c759d2c0923b', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:13', NULL, 1, 0, NULL, 's1', 18001, 1, '充值-6元', 6, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '充值-6元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('16196104-f603-48da-a1de-6ae85d7f54a4', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:08', NULL, 1, 0, NULL, 's1', 18008, 1, '充值-99999元', 99999, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, '#N/A', 0, NULL, 'zh_CN', 0, '10091', '充值-99999元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('1797c0f0-3165-4ca0-ac66-7ee733358ceb', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:08', NULL, 1, 0, NULL, 's1', 18008, 1, '充值-99999元', 99999, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, '#N/A', 0, NULL, 'zh_CN', 0, '10091', '充值-99999元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('17d5c3cc-3209-4fdb-a9e0-b1fdfcb11718', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:37', NULL, 1, 0, NULL, 's1', 18005, 1, '充值-198元', 200000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.198', 0, NULL, 'zh_CN', 0, '10091', '充值-198元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('1c3b7450-4a3b-4091-af89-9d554a6d8409', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:01', NULL, 1, 0, NULL, 's1', 18003, 1, '充值-68元', 68, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '充值-68元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('1d586ad6-14c7-4085-9262-d09004f1e848', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:32', NULL, 1, 0, NULL, 's1', 19007, 1, '每日礼包', 20000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('1e0e10cc-a263-483a-87bd-bab49b37116b', 1, 'develop', NULL, NULL, '234234@develop', NULL, NULL, '2025-03-24 11:17:08', NULL, 1, 0, NULL, 's1', 18008, 1, '充值-99999元', 99999, '600eabab-692c-408d-92e4-606feca2e5c7', '67e0ce62e36ade3322b1f37d', 'Higiu', NULL, NULL, NULL, '#N/A', 0, NULL, 'zh_CN', 0, '10091', '充值-99999元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('1e857d7d-2a40-4be5-be7f-da750ef9a02a', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:42', NULL, 1, 0, NULL, 's1', 18001, 1, '充值-6元', 10000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '充值-6元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('247cc58e-ce89-48d7-8da3-038f6ff3ca6a', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:12', NULL, 1, 0, NULL, 's1', 18001, 1, '充值-6元', 6, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '充值-6元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('28ec4fd5-510d-4044-a970-2c6d38b10779', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:23:36', NULL, 1, 0, NULL, 's1', 11001, 1, '七天豪礼-限时追加-第一天', 20000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '七天豪礼-限时追加-第一天', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('29010b30-af99-4a67-a5dd-92a0a71cf3e5', 1, 'develop', NULL, NULL, 'test12@develop', NULL, NULL, '2025-03-29 20:06:18', NULL, 1, 0, NULL, 's1', 18001, 1, '充值-6元', 10000, '6e9ab3d4-f808-4b1c-93da-f37c7890e197', '67e7dfecc9a3d57a8519855d', 'Lieu8', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '充值-6元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('2ac85f83-2a2f-4837-8ba9-713aa7747777', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:40', NULL, 1, 0, NULL, 's1', 18005, 1, '充值-198元', 200000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.198', 0, NULL, 'zh_CN', 0, '10091', '充值-198元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('2ca0691c-a5ba-4ef9-b8ec-e02775b07509', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:05', NULL, 1, 0, NULL, 's1', 18006, 1, '充值-328元', 328, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.328', 0, NULL, 'zh_CN', 0, '10091', '充值-328元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('2e31b94a-ab0f-484c-8dce-40994bd7ad73', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:05', NULL, 1, 0, NULL, 's1', 18006, 1, '充值-328元', 328, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.328', 0, NULL, 'zh_CN', 0, '10091', '充值-328元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('2f65c04e-b4d6-4358-8341-ded3de8471d0', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:46', NULL, 1, 0, NULL, 's1', 18003, 1, '充值-68元', 68, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '充值-68元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('32e5cf5c-6617-4b20-97e9-271f4d4274f6', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:06', NULL, 1, 0, NULL, 's1', 18006, 1, '充值-328元', 328, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.328', 0, NULL, 'zh_CN', 0, '10091', '充值-328元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('3579e150-ad23-417b-b23e-538b4387bb33', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:05:39', NULL, 1, 0, NULL, 's1', 18003, 1, '充值-68元', 68, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '充值-68元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('3889f983-fd7a-4bdd-9917-44e631e75778', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:40', NULL, 1, 0, NULL, 's1', 18005, 1, '充值-198元', 200000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.198', 0, NULL, 'zh_CN', 0, '10091', '充值-198元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('3b167236-846f-42e3-92df-b1fdc74b3e8f', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:05:38', NULL, 1, 0, NULL, 's1', 18003, 1, '充值-68元', 68, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '充值-68元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('3bda4e15-3acd-4bb5-a1ed-c34696dce121', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:05', NULL, 1, 0, NULL, 's1', 18006, 1, '充值-328元', 328, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.328', 0, NULL, 'zh_CN', 0, '10091', '充值-328元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('3d0ae692-7ae1-482b-b186-6df3a5fc8c76', 1, 'develop', NULL, NULL, 'test12@develop', NULL, NULL, '2025-03-29 20:06:18', NULL, 1, 0, NULL, 's1', 18001, 1, '充值-6元', 10000, '6e9ab3d4-f808-4b1c-93da-f37c7890e197', '67e7dfecc9a3d57a8519855d', 'Lieu8', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '充值-6元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('497d8178-ef93-4b2d-a76b-7e25a1f03742', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:38', NULL, 1, 0, NULL, 's1', 31001, 1, '黑金特权', 40000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '黑金特权', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('4bd63a22-1c27-4d96-8dac-c7ce27e8b15d', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:42', NULL, 1, 0, NULL, 's1', 18001, 1, '充值-6元', 10000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '充值-6元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('4feedcb0-8d45-47f0-98b8-0382e6089fed', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:12', NULL, 1, 0, NULL, 's1', 18001, 1, '充值-6元', 6, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '充值-6元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('55c82094-1ea6-471e-b45d-1bd0c5a0fd24', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:31', NULL, 1, 0, NULL, 's1', 19007, 1, '每日礼包', 20000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('586ae5d5-637f-44b4-8c7a-6837543a1067', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:41', NULL, 1, 0, NULL, 's1', 18005, 1, '充值-198元', 200000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.198', 0, NULL, 'zh_CN', 0, '10091', '充值-198元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('58b11aa4-fb83-4ce0-8032-f8b39e02c9a3', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:50', NULL, 1, 0, NULL, 's1', 18003, 1, '充值-68元', 68, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '充值-68元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('58b72617-235d-4afe-9dd5-252721a7315b', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:08', NULL, 1, 0, NULL, 's1', 18008, 1, '充值-99999元', 99999, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, '#N/A', 0, NULL, 'zh_CN', 0, '10091', '充值-99999元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('6278fc67-2ec8-4854-9eed-463e011e7c06', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:49', NULL, 1, 0, NULL, 's1', 18003, 1, '充值-68元', 68, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '充值-68元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('65d6389a-5a4e-404c-a0a9-9ede836fbbee', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:12', NULL, 1, 0, NULL, 's1', 18001, 1, '充值-6元', 6, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '充值-6元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('89571f02-cf68-448b-ac9b-ee1fae2d0b0e', 1, 'develop', NULL, NULL, 'test13@develop', NULL, NULL, '2025-03-30 01:05:15', NULL, 1, 0, NULL, 's1', 20001, 1, '命签礼包', 15000, '657e8cf5-0346-42a8-9728-c5a8a91206d2', '67e81f41682ed105c6bee271', 'Gum4', NULL, NULL, NULL, 'com.xkd.yzx.tfun.30', 0, NULL, 'zh_CN', 0, '10091', '命签礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('91c40a20-25d3-44c8-bcaf-a9bec9e3eca5', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:32', NULL, 1, 0, NULL, 's1', 19008, 1, '每日礼包', 50000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.12', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('97bc9b2b-50ad-4057-9dfb-c0a26546127b', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:05:32', NULL, 1, 0, NULL, 's1', 18002, 1, '充值-30元', 30, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.30', 0, NULL, 'zh_CN', 0, '10091', '充值-30元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('9a52ff63-d3b2-49fe-8eb7-f9c4b5efdfb9', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:38', NULL, 1, 0, NULL, 's1', 31001, 1, '黑金特权', 40000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '黑金特权', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('a139baa8-9e01-46e9-8aee-a3d98ae610bb', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:07', NULL, 1, 0, NULL, 's1', 18008, 1, '充值-99999元', 99999, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, '#N/A', 0, NULL, 'zh_CN', 0, '10091', '充值-99999元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('a60ebbab-5a08-421e-aec0-29201f42503f', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:32', NULL, 1, 0, NULL, 's1', 19007, 1, '每日礼包', 20000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('a6f39f5b-0c1b-46b9-a297-d85a65693f01', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:50', NULL, 1, 0, NULL, 's1', 18003, 1, '充值-68元', 68, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '充值-68元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('a7646981-5e65-4a98-98ff-302fa692c71c', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:33', NULL, 1, 0, NULL, 's1', 19008, 1, '每日礼包', 50000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.12', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('b5e302bb-e7fe-47c4-b9d0-53c059deaa90', 1, 'develop', NULL, NULL, 'test13@develop', NULL, NULL, '2025-03-30 01:05:14', NULL, 1, 0, NULL, 's1', 20001, 1, '命签礼包', 15000, '657e8cf5-0346-42a8-9728-c5a8a91206d2', '67e81f41682ed105c6bee271', 'Gum4', NULL, NULL, NULL, 'com.xkd.yzx.tfun.30', 0, NULL, 'zh_CN', 0, '10091', '命签礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('b7c97a31-e626-4d32-bc8f-4d6d331cb014', 1, 'develop', NULL, NULL, '234234@develop', NULL, NULL, '2025-03-24 11:17:09', NULL, 1, 0, NULL, 's1', 18008, 1, '充值-99999元', 99999, '600eabab-692c-408d-92e4-606feca2e5c7', '67e0ce62e36ade3322b1f37d', 'Higiu', NULL, NULL, NULL, '#N/A', 0, NULL, 'zh_CN', 0, '10091', '充值-99999元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('ba0da760-dc30-4835-95d1-e1006651a377', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:13', NULL, 1, 0, NULL, 's1', 18001, 1, '充值-6元', 6, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '充值-6元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('be70d5d6-bcfc-4859-8da2-0e2cd6aceb9c', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:37', NULL, 1, 0, NULL, 's1', 31001, 1, '黑金特权', 40000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '黑金特权', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('c18dadee-639a-4c74-a43a-3c38c812af17', 1, 'develop', NULL, NULL, 'test13@develop', NULL, NULL, '2025-03-30 00:36:37', NULL, 1, 0, NULL, 's1', 18006, 1, '充值-328元', 500000, '657e8cf5-0346-42a8-9728-c5a8a91206d2', '67e81f41682ed105c6bee271', 'Gum4', NULL, NULL, NULL, 'com.xkd.yzx.tfun.328', 0, NULL, 'zh_CN', 0, '10091', '充值-328元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('cc4d836e-792e-4403-b6a1-f98b4fd3ab79', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:37', NULL, 1, 0, NULL, 's1', 31001, 1, '黑金特权', 40000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '黑金特权', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('cd25a397-6f2d-47dc-b4e9-352604bef1c5', 1, 'develop', NULL, NULL, 'test13@develop', NULL, NULL, '2025-04-04 10:26:32', NULL, 1, 0, NULL, 's1', 46101, 1, '挂机奖励礼包', 300000, '657e8cf5-0346-42a8-9728-c5a8a91206d2', '67e81f41682ed105c6bee271', 'DLGAME', NULL, NULL, NULL, 'com.xkd.yzx.tfun.648', 0, NULL, 'zh_CN', 0, '10091', '挂机奖励礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('d2dc2514-78db-41c2-b055-9716ee805e8f', 1, 'develop', NULL, NULL, 'test13@develop', NULL, NULL, '2025-03-30 09:49:23', NULL, 1, 0, NULL, 's1', 19007, 1, '每日礼包', 20000, '657e8cf5-0346-42a8-9728-c5a8a91206d2', '67e81f41682ed105c6bee271', 'Gum4', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('d974bc4e-32b5-4d14-89cc-b4b77606750b', 1, 'develop', NULL, NULL, '234234@develop', NULL, NULL, '2025-03-24 11:17:10', NULL, 1, 0, NULL, 's1', 18008, 1, '充值-99999元', 99999, '600eabab-692c-408d-92e4-606feca2e5c7', '67e0ce62e36ade3322b1f37d', 'Higiu', NULL, NULL, NULL, '#N/A', 0, NULL, 'zh_CN', 0, '10091', '充值-99999元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('de042277-9c61-4153-9f21-9fbf3f7c4c34', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:44', NULL, 1, 0, NULL, 's1', 18008, 1, '充值-998元', 2000000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.998', 0, NULL, 'zh_CN', 0, '10091', '充值-998元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('dee1b740-dbc7-4d45-96a7-2252c4d4362a', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:41', NULL, 1, 0, NULL, 's1', 18004, 1, '充值-128元', 100000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.128', 0, NULL, 'zh_CN', 0, '10091', '充值-128元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('e4416063-8b4e-4458-b528-5d3ef71a1abe', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:30', NULL, 1, 0, NULL, 's1', 19008, 1, '每日礼包', 50000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.12', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('e5a9006d-f64f-454f-921b-f0fd293116dc', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:32', NULL, 1, 0, NULL, 's1', 19007, 1, '每日礼包', 20000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('ea8b4257-62a3-4215-905a-3bda3513fc05', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:31', NULL, 1, 0, NULL, 's1', 19008, 1, '每日礼包', 50000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.12', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('ee5930d8-bd8a-46cf-8032-946abda571d2', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:42', NULL, 1, 0, NULL, 's1', 18002, 1, '充值-30元', 20000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.30', 0, NULL, 'zh_CN', 0, '10091', '充值-30元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('f18ca4ee-553a-44d9-9f81-bb467c01ab4e', 1, 'develop', NULL, NULL, 'admin@develop', NULL, NULL, '2025-03-24 02:06:50', NULL, 1, 0, NULL, 's1', 18003, 1, '充值-68元', 68, '54e56d80-ee84-4a70-940b-d6187be9e442', '67e04d63cdb87869e6fdb5f6', '贺追命', NULL, NULL, NULL, 'com.xkd.yzx.tfun.68', 0, NULL, 'zh_CN', 0, '10091', '充值-68元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('f473b066-58e8-4abe-af83-ce87c72bc4b5', 1, 'develop', NULL, NULL, 'test13@develop', NULL, NULL, '2025-03-30 00:36:37', NULL, 1, 0, NULL, 's1', 18006, 1, '充值-328元', 500000, '657e8cf5-0346-42a8-9728-c5a8a91206d2', '67e81f41682ed105c6bee271', 'Gum4', NULL, NULL, NULL, 'com.xkd.yzx.tfun.328', 0, NULL, 'zh_CN', 0, '10091', '充值-328元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('f500a82f-49f0-4f0d-9851-b7165fad32b5', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:31', NULL, 1, 0, NULL, 's1', 19008, 1, '每日礼包', 50000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.12', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('f5adc4cc-1623-41d3-8caa-308a3de98d23', 1, 'develop', NULL, NULL, 'khanhlam@develop', NULL, NULL, '2025-03-30 14:16:44', NULL, 1, 0, NULL, 's1', 18008, 1, '充值-998元', 2000000, 'cd4966cc-fafb-4808-86e9-b34ccda84b88', '67e8e17cc261ae5c5a156391', 'Thuy1', NULL, NULL, NULL, 'com.xkd.yzx.tfun.998', 0, NULL, 'zh_CN', 0, '10091', '充值-998元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('f5e52a32-3201-41bd-be99-fbe8a8d86f37', 1, 'develop', NULL, NULL, 'phucbaby@develop', NULL, NULL, '2025-04-01 18:41:33', NULL, 1, 0, NULL, 's1', 19008, 1, '每日礼包', 50000, '5cf5d7cf-9ddb-4457-9229-e267976bf76c', '67ebc24ec261ae5c5a1568a2', 'Khanh0', NULL, NULL, NULL, 'com.xkd.yzx.tfun.12', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);

-- ----------------------------
-- Table structure for pay_record_beta
-- ----------------------------
DROP TABLE IF EXISTS `pay_record_beta`;
CREATE TABLE `pay_record_beta`  (
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一ID',
  `order_type` tinyint(4) NULL DEFAULT NULL COMMENT '订单类型',
  `platform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `channel_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道编码',
  `platform_order_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台订单号',
  `platform_open_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台openId',
  `platform_pay_status` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台支付状态',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `context_str` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单上下文',
  `step` tinyint(4) NULL DEFAULT NULL COMMENT '步骤',
  `retry_times` int(11) NULL DEFAULT 0 COMMENT '重试次数',
  `note` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一些备注',
  `srv_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服务器代码',
  `item_tid` int(11) NULL DEFAULT NULL COMMENT '支付项模板ID',
  `item_count` int(11) NULL DEFAULT NULL COMMENT '支付项数量',
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付项名称',
  `pay_amount` double NULL DEFAULT NULL COMMENT '付款总金额(元)',
  `account_uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角所属账号的唯一ID',
  `master_id_hex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角唯一ID',
  `master_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角姓名',
  `el_username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行人用户名',
  `el_nickname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行人昵称',
  `currency_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付币种代码',
  `trade_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计费点',
  `plugin` int(11) NULL DEFAULT 0 COMMENT '插件逻辑',
  `plugin_attachment` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '插件逻辑附件信息',
  `lang_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语言编码',
  `activity_extra` int(11) NULL DEFAULT NULL COMMENT '活动额外赠予',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `item_name_cn` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付项名称(中文)',
  `raw_order_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原始订单号',
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `record_platform_order_id_IDX`(`platform_order_id`) USING BTREE,
  INDEX `idx_pay_time`(`pay_time`) USING BTREE,
  INDEX `idx_srv_code`(`srv_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '封测充值记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_record_beta
-- ----------------------------

-- ----------------------------
-- Table structure for pay_refund
-- ----------------------------
DROP TABLE IF EXISTS `pay_refund`;
CREATE TABLE `pay_refund`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `open_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台OpenID',
  `srv_code_delete` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删档收费区服编码',
  `amount` double NULL DEFAULT NULL COMMENT '充值金额',
  `srv_code_refund` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '返还区服编码',
  `stat_time` datetime NULL DEFAULT NULL COMMENT '统计时间',
  `refund_time` datetime NULL DEFAULT NULL COMMENT '返还时间',
  `done` tinyint(1) NULL DEFAULT NULL COMMENT '已兑现',
  `master_id_hex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角唯一ID',
  `master_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主角名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '删档充值返还' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_refund
-- ----------------------------

-- ----------------------------
-- Table structure for platform_yzx_param
-- ----------------------------
DROP TABLE IF EXISTS `platform_yzx_param`;
CREATE TABLE `platform_yzx_param`  (
  `client_type` int(11) NULL DEFAULT NULL COMMENT '客户端类型',
  `game_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `game_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameKey',
  `secret_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'SecretKey',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '平台配置之叶子戏' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of platform_yzx_param
-- ----------------------------
INSERT INTO `platform_yzx_param` VALUES (0, '10091', '7d08b21f87ac48f78e00bfe6e9caa362', '8c2c11186d39406b92ecfca7f18a0fb5', '主服H5');

-- ----------------------------
-- Table structure for player_imei_record
-- ----------------------------
DROP TABLE IF EXISTS `player_imei_record`;
CREATE TABLE `player_imei_record`  (
  `IMEI` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备码',
  `first_srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首次创角所在的游戏服编码',
  `first_time` datetime NULL DEFAULT NULL COMMENT '首次记录时间',
  `last_time` datetime NULL DEFAULT NULL COMMENT '最近记录时间',
  `update_times` int(11) NULL DEFAULT NULL COMMENT '该数据更新次数',
  `first_platform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首次登陆平台',
  `first_channel_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首次登陆渠道',
  PRIMARY KEY (`IMEI`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '关于设备码的统计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of player_imei_record
-- ----------------------------

-- ----------------------------
-- Table structure for player_ip_record
-- ----------------------------
DROP TABLE IF EXISTS `player_ip_record`;
CREATE TABLE `player_ip_record`  (
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首次创角所在的游戏服编码',
  `first_time` datetime NULL DEFAULT NULL COMMENT '首次记录时间',
  `last_time` datetime NULL DEFAULT NULL COMMENT '最近记录时间',
  `update_times` int(11) NULL DEFAULT NULL COMMENT '该数据更新次数',
  `first_platform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首次登陆平台',
  `first_channel_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首次登陆渠道',
  PRIMARY KEY (`ip`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of player_ip_record
-- ----------------------------

-- ----------------------------
-- Table structure for role_key_res_num
-- ----------------------------
DROP TABLE IF EXISTS `role_key_res_num`;
CREATE TABLE `role_key_res_num`  (
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  `role_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名字',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服编码',
  `srv_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服名',
  `srv_index` int(11) NULL DEFAULT NULL COMMENT '游戏服序号',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '数据更新时间',
  `i0` int(11) NULL DEFAULT NULL,
  `i1` int(11) NULL DEFAULT NULL,
  `i2` int(11) NULL DEFAULT NULL,
  `i3` int(11) NULL DEFAULT NULL,
  `i4` int(11) NULL DEFAULT NULL,
  `i5` int(11) NULL DEFAULT NULL,
  `i6` int(11) NULL DEFAULT NULL,
  `i7` int(11) NULL DEFAULT NULL,
  `i8` int(11) NULL DEFAULT NULL,
  `i9` int(11) NULL DEFAULT NULL,
  `i10` int(11) NULL DEFAULT NULL,
  `l0` bigint(20) NULL DEFAULT NULL,
  `l1` bigint(20) NULL DEFAULT NULL,
  `l2` bigint(20) NULL DEFAULT NULL,
  `l3` bigint(20) NULL DEFAULT NULL,
  `l4` bigint(20) NULL DEFAULT NULL,
  `l5` bigint(20) NULL DEFAULT NULL,
  `l6` bigint(20) NULL DEFAULT NULL,
  `l7` bigint(20) NULL DEFAULT NULL,
  `l8` bigint(20) NULL DEFAULT NULL,
  `l9` bigint(20) NULL DEFAULT NULL,
  `l10` bigint(20) NULL DEFAULT NULL,
  `l11` bigint(20) NULL DEFAULT NULL,
  `l12` bigint(20) NULL DEFAULT NULL,
  `l13` bigint(20) NULL DEFAULT NULL,
  `l14` bigint(20) NULL DEFAULT NULL,
  `l15` bigint(20) NULL DEFAULT NULL,
  `l16` bigint(20) NULL DEFAULT NULL,
  `l17` bigint(20) NULL DEFAULT NULL,
  `l18` bigint(20) NULL DEFAULT NULL,
  `l19` bigint(20) NULL DEFAULT NULL,
  `l20` bigint(20) NULL DEFAULT NULL,
  `d0` double NULL DEFAULT NULL,
  `d1` double NULL DEFAULT NULL,
  `d2` double NULL DEFAULT NULL,
  `d3` double NULL DEFAULT NULL,
  `d4` double NULL DEFAULT NULL,
  `d5` double NULL DEFAULT NULL,
  `d6` double NULL DEFAULT NULL,
  `d7` double NULL DEFAULT NULL,
  `d8` double NULL DEFAULT NULL,
  `d9` double NULL DEFAULT NULL,
  `d10` double NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE,
  INDEX `role_key_res_num_role_name_IDX`(`role_name`) USING BTREE,
  INDEX `role_key_res_num_srv_code_IDX`(`srv_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基于角色的关键数量统计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_key_res_num
-- ----------------------------

-- ----------------------------
-- Table structure for srv_cross
-- ----------------------------
DROP TABLE IF EXISTS `srv_cross`;
CREATE TABLE `srv_cross`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跨服编码',
  `leader_srv_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '领导服务器编码',
  `mongo_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mongo编码',
  `db_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跨服数据库名',
  `mq_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mq编码',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务的url',
  `device_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编码',
  `port` int(11) NULL DEFAULT NULL COMMENT 'web端口',
  `jvm_args` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JVM参数',
  `classify` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  `excel_mode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Excel模式',
  `program_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '程序路径',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `srv_cross_UN`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '跨服配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_cross
-- ----------------------------
INSERT INTO `srv_cross` VALUES (1, 'cross-yzx1', NULL, 'cross-yzx1', 'cross-yzx1', 'yzx-mq1', '叶子戏跨服组1', 'http://160.191.50.225:20001/', 'yzxkfs1', 20001, '-Xms128m -Xmx2048m', '官服', NULL, NULL);

-- ----------------------------
-- Table structure for srv_cross_plan
-- ----------------------------
DROP TABLE IF EXISTS `srv_cross_plan`;
CREATE TABLE `srv_cross_plan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `srv_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服编码',
  `cross_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跨服编码',
  `change_time` datetime NULL DEFAULT NULL COMMENT '改变时间',
  `changed` tinyint(1) NULL DEFAULT 0 COMMENT '是否已执行过改变',
  `srv_err` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服执行错误信息',
  `cross_err` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跨服执行错误信息',
  `enabled` tinyint(1) NULL DEFAULT 1 COMMENT '是否已执行过改变',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_cross_plan
-- ----------------------------

-- ----------------------------
-- Table structure for srv_game
-- ----------------------------
DROP TABLE IF EXISTS `srv_game`;
CREATE TABLE `srv_game`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区服编码',
  `index` int(11) NULL DEFAULT NULL COMMENT '序号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区服名',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '服务器状态',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '服务器组ID',
  `cross_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跨服组编码',
  `recommend` tinyint(1) NULL DEFAULT NULL COMMENT '是否推荐',
  `folder` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区服归类',
  `open_time` datetime NULL DEFAULT NULL COMMENT '开服时间',
  `platform_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `pay_scale` float NULL DEFAULT NULL COMMENT '支付倍数',
  `excel_mode` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Excel模式',
  `device_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编码',
  `mongo_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'MongoDB编码',
  `mysql_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'MySQL编码',
  `ws_scheme` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ws_port` int(11) NULL DEFAULT NULL,
  `jvm_args` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JVM启动参数',
  `creator` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `editor` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编辑人',
  `edit_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编辑时间',
  `cross_code_a` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '切换点之前の跨服编号',
  `cross_code_b` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '切换点之后の跨服编号',
  `cross_switch_time` datetime NULL DEFAULT NULL COMMENT '跨服切换点',
  `merge_time` datetime NULL DEFAULT NULL COMMENT '合服时间',
  `eaten` tinyint(1) NULL DEFAULT 0 COMMENT '被合服吞并',
  `player_max` int(11) NULL DEFAULT NULL COMMENT '最大玩家数量',
  `game_ver` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏版本',
  `vip_stat_tar` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'VIP统计对象',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `program_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '程序路径',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `srv_game_code_IDX`(`code`) USING BTREE,
  INDEX `srv_game_group_id_IDX`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工与应用关联' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_game
-- ----------------------------
INSERT INTO `srv_game` VALUES (1, 's1', 1, 'Meow 3Q', 2, 1, 'cross-yzx1', 1, 'Meow 3Q', '2024-04-07 00:00:05', 'develop', 1, 'release', 'd1', 'mongo-yzxdb1', 'mysql-yzxdb1', 'ws', 8001, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO `srv_game` VALUES (2, 's2', 2, 'DL - 2', 2, 1, 'cross-yzx1', 1, 'DLStudio', '2024-04-07 00:00:05', 'disabled', 1, 'release', 'd1', 'mongo-yzxdb2', 'mysql-yzxdb2', 'ws', 8002, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO `srv_game` VALUES (3, 's3', 3, 'DL - 3', 2, 1, 'cross-yzx1', 1, 'DLStudio', '2024-04-07 00:00:05', 'disabled', 1, 'release', 'd1', 'mongo-yzxdb3', 'mysql-yzxdb3', 'ws', 8003, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO `srv_game` VALUES (4, 's4', 4, 'DL - 4', 2, 1, 'cross-yzx1', 1, 'DLStudio', '2024-04-07 00:00:05', 'disabled', 1, 'release', 'd1', 'mongo-yzxdb4', 'mysql-yzxdb4', 'ws', 8004, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO `srv_game` VALUES (5, 's5', 5, 'DL - 5', 2, 1, 'cross-yzx1', 1, 'DLStudio', '2024-04-07 00:00:05', 'disabled', 1, 'release', 'd1', 'mongo-yzxdb5', 'mysql-yzxdb5', 'ws', 8005, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for srv_game_access
-- ----------------------------
DROP TABLE IF EXISTS `srv_game_access`;
CREATE TABLE `srv_game_access`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `srv_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服编码',
  `mode` tinyint(1) NULL DEFAULT NULL COMMENT '判断规则模式',
  `platform_limit` tinyint(1) NULL DEFAULT NULL COMMENT '是否平台限定',
  `platform_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `channel_limit` tinyint(1) NULL DEFAULT NULL COMMENT '是否渠道限定',
  `channel_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道编码',
  `game_id_limit` tinyint(4) NULL DEFAULT 1 COMMENT '是否GameID限定',
  `game_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `ext_limit` tinyint(1) NULL DEFAULT NULL COMMENT '是否扩展限定',
  `ext` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '游戏服进入规则' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_game_access
-- ----------------------------
INSERT INTO `srv_game_access` VALUES (1, 's1', 1, 1, 'develop', 0, NULL, 1, '10091', 0, NULL);
INSERT INTO `srv_game_access` VALUES (2, 's2', 1, 1, 'develop', 0, '', 1, '10091', 0, '');
INSERT INTO `srv_game_access` VALUES (3, 's3', 1, 1, 'develop', 0, '', 1, '10091', 0, '');
INSERT INTO `srv_game_access` VALUES (4, 's4', 1, 1, 'develop', 0, '', 1, '10091', 0, '');
INSERT INTO `srv_game_access` VALUES (5, 's5', 1, 1, 'develop', 0, '', 1, '10091', 0, '');

-- ----------------------------
-- Table structure for srv_game_ext
-- ----------------------------
DROP TABLE IF EXISTS `srv_game_ext`;
CREATE TABLE `srv_game_ext`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服编码',
  `pay_refund_enabled` tinyint(1) NULL DEFAULT NULL COMMENT '启用删档返代币',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `z10_gift_code` tinyint(1) NULL DEFAULT 0 COMMENT '专10礼包码特性',
  `wx_forbidden_word` tinyint(1) NULL DEFAULT 0 COMMENT '微信屏蔽词接入',
  `raffle_task` tinyint(1) NULL DEFAULT NULL COMMENT '菜菜版做任务抽奖红包',
  `longtu_game_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '龙图gameid',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `srv_game_ext_UN`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '游戏扩展配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_game_ext
-- ----------------------------

-- ----------------------------
-- Table structure for srv_game_status
-- ----------------------------
DROP TABLE IF EXISTS `srv_game_status`;
CREATE TABLE `srv_game_status`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `cross_code_cur` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前所属跨服编码',
  `cross_code_switch` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '切换跨服编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `srv_game_status_game_code_uindex`(`game_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '游戏服状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_game_status
-- ----------------------------

-- ----------------------------
-- Table structure for srv_group
-- ----------------------------
DROP TABLE IF EXISTS `srv_group`;
CREATE TABLE `srv_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组名',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器组编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '游戏服务器组' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_group
-- ----------------------------
INSERT INTO `srv_group` VALUES (1, '官服组', NULL, 'group-offical');

-- ----------------------------
-- Table structure for srv_group_device
-- ----------------------------
DROP TABLE IF EXISTS `srv_group_device`;
CREATE TABLE `srv_group_device`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服组编码',
  `leader_srv_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '领导服务器编码',
  `mongo_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mongo编码',
  `db_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服组数据库名',
  `mq_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'mq编码',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务的url',
  `device_code` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编码',
  `port` int(11) NULL DEFAULT NULL COMMENT 'web端口',
  `jvm_args` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JVM参数',
  `classify` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  `excel_mode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Excel模式',
  `program_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '程序路径',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_code_uni`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '游戏服组配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_group_device
-- ----------------------------
INSERT INTO `srv_group_device` VALUES (1, 'group-offical', NULL, 'mongo-group', 'group-offical', 'group-mq', '官服游戏服组', 'http://160.191.50.225:30001/', 'group', 30001, '-Xms512m -Xmx1024m', NULL, 'release', NULL);

-- ----------------------------
-- Table structure for srv_login
-- ----------------------------
DROP TABLE IF EXISTS `srv_login`;
CREATE TABLE `srv_login`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `np_scheme` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'scheme',
  `np_host_WAN` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外网地址',
  `np_host_LAN` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内网地址',
  `np_host_domain` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '域名',
  `np_port` int(11) NULL DEFAULT NULL COMMENT '端口',
  `np_ssl` tinyint(1) NULL DEFAULT NULL COMMENT '是否ssl安全',
  `np_enabled` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '登录服务器配置信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_login
-- ----------------------------
INSERT INTO `srv_login` VALUES (1, 'http', '160.191.50.225', '127.0.0.1', NULL, 9000, 0, 0, '最新的登录服');

-- ----------------------------
-- Table structure for srv_merge
-- ----------------------------
DROP TABLE IF EXISTS `srv_merge`;
CREATE TABLE `srv_merge`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `srv_code_origin` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原始游戏服编码',
  `srv_code_now` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前游戏服编码',
  `enabled` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `migrate_game_mongo_times` int(11) NULL DEFAULT NULL COMMENT '游戏服mongo迁移的执行次数',
  `migrate_game_mongo_last` timestamp NULL DEFAULT NULL COMMENT '游戏服mongo迁移的最近一次时间',
  `migrate_game_mongo_log` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服mongo迁移的最近一次日志',
  `migrate_am_times` int(11) NULL DEFAULT NULL COMMENT '账号主角区服迁移的执行次数',
  `migrate_am_last` timestamp NULL DEFAULT NULL COMMENT '账号主角区服迁移的最近一次执行时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '合服配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_merge
-- ----------------------------

-- ----------------------------
-- Table structure for srv_paid_delete
-- ----------------------------
DROP TABLE IF EXISTS `srv_paid_delete`;
CREATE TABLE `srv_paid_delete`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `srv_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区服编码',
  `enabled` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '删档收费服配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_paid_delete
-- ----------------------------

-- ----------------------------
-- Table structure for srv_status_plan
-- ----------------------------
DROP TABLE IF EXISTS `srv_status_plan`;
CREATE TABLE `srv_status_plan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `srv_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区服编码',
  `status` smallint(6) NULL DEFAULT NULL COMMENT '变更状态',
  `change_time` datetime NULL DEFAULT NULL COMMENT '变更时间',
  `changed` tinyint(1) NULL DEFAULT NULL COMMENT '是否已执行过变更',
  `enabled` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用',
  `cancel_recommend_srv_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '要取消推荐的游戏服编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '区服状态改变计划' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_status_plan
-- ----------------------------

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `admin` tinyint(1) NULL DEFAULT 0 COMMENT '管理员',
  `role_id` int(11) NOT NULL DEFAULT 0 COMMENT '角色ID',
  `dept` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '隶属部门',
  `company` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '隶属公司',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (1, 'admin', 'admin', '超管', '2020-06-21 22:20:59', 1, 5, NULL, NULL);

-- ----------------------------
-- Table structure for staff_app
-- ----------------------------
DROP TABLE IF EXISTS `staff_app`;
CREATE TABLE `staff_app`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NULL DEFAULT NULL,
  `app_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff_app
-- ----------------------------
INSERT INTO `staff_app` VALUES (1, 1, 1);
INSERT INTO `staff_app` VALUES (2, 2, 1);

-- ----------------------------
-- Table structure for staff_channel
-- ----------------------------
DROP TABLE IF EXISTS `staff_channel`;
CREATE TABLE `staff_channel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NULL DEFAULT NULL,
  `channel_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff_channel
-- ----------------------------
INSERT INTO `staff_channel` VALUES (1, 1, NULL);
INSERT INTO `staff_channel` VALUES (2, 2, NULL);

-- ----------------------------
-- Table structure for staff_platform
-- ----------------------------
DROP TABLE IF EXISTS `staff_platform`;
CREATE TABLE `staff_platform`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NULL DEFAULT NULL,
  `platform_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff_platform
-- ----------------------------
INSERT INTO `staff_platform` VALUES (1, 1, 'develop');
INSERT INTO `staff_platform` VALUES (2, 1, 'yezixi');
INSERT INTO `staff_platform` VALUES (3, 2, 'develop');
INSERT INTO `staff_platform` VALUES (4, 2, 'yezixi');

-- ----------------------------
-- Table structure for staff_role
-- ----------------------------
DROP TABLE IF EXISTS `staff_role`;
CREATE TABLE `staff_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff_role
-- ----------------------------
INSERT INTO `staff_role` VALUES (5, '超级管理', NULL);
INSERT INTO `staff_role` VALUES (7, '管理员', NULL);

-- ----------------------------
-- Table structure for staff_role_game_id
-- ----------------------------
DROP TABLE IF EXISTS `staff_role_game_id`;
CREATE TABLE `staff_role_game_id`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '员工角色ID',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工角色所限制的gameId' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff_role_game_id
-- ----------------------------
INSERT INTO `staff_role_game_id` VALUES (1, 5, '1');

-- ----------------------------
-- Table structure for staff_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `staff_role_permission`;
CREATE TABLE `staff_role_permission`  (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `p0` tinyint(1) NULL DEFAULT 0,
  `p1` tinyint(1) NULL DEFAULT 0,
  `p2` tinyint(1) NULL DEFAULT 0,
  `p3` tinyint(1) NULL DEFAULT 0,
  `p4` tinyint(1) NULL DEFAULT 0,
  `p5` tinyint(1) NULL DEFAULT 0,
  `p6` tinyint(1) NULL DEFAULT 0,
  `p7` tinyint(1) NULL DEFAULT 0,
  `p8` tinyint(1) NULL DEFAULT 0,
  `p9` tinyint(1) NULL DEFAULT 0,
  `p10` tinyint(1) NULL DEFAULT 0,
  `p11` tinyint(1) NULL DEFAULT 0,
  `p12` tinyint(1) NULL DEFAULT 0,
  `p13` tinyint(1) NULL DEFAULT 0,
  `p14` tinyint(1) NULL DEFAULT 0,
  `p15` tinyint(1) NULL DEFAULT 0,
  `p16` tinyint(1) NULL DEFAULT 0,
  `p17` tinyint(1) NULL DEFAULT 0,
  `p18` tinyint(1) NULL DEFAULT 0,
  `p19` tinyint(1) NULL DEFAULT 0,
  `p20` tinyint(1) NULL DEFAULT 0,
  `admin` tinyint(1) NULL DEFAULT 0,
  `p21` tinyint(1) NULL DEFAULT 0,
  `p22` tinyint(1) NULL DEFAULT 0,
  `p23` tinyint(1) NULL DEFAULT 0,
  `p24` tinyint(1) NULL DEFAULT 0,
  `p25` tinyint(1) NULL DEFAULT 0,
  `p26` tinyint(1) NULL DEFAULT 0,
  `p27` tinyint(1) NULL DEFAULT 0,
  `p28` tinyint(1) NULL DEFAULT 0,
  `p29` tinyint(1) NULL DEFAULT 0,
  `p30` tinyint(1) NULL DEFAULT 0,
  `p31` tinyint(1) NULL DEFAULT 0,
  `p32` tinyint(1) NULL DEFAULT 0,
  `p33` tinyint(1) NULL DEFAULT 0,
  `p34` tinyint(1) NULL DEFAULT 0,
  `p35` tinyint(1) NULL DEFAULT 0,
  `p36` tinyint(1) NULL DEFAULT 0,
  `p37` tinyint(1) NULL DEFAULT 0,
  `p38` tinyint(1) NULL DEFAULT 0,
  `p39` tinyint(1) NULL DEFAULT 0,
  `p40` tinyint(1) NULL DEFAULT 0,
  `p41` tinyint(1) NULL DEFAULT 0,
  `p42` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工角色权限配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff_role_permission
-- ----------------------------
INSERT INTO `staff_role_permission` VALUES (5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `staff_role_permission` VALUES (7, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- ----------------------------
-- Table structure for staff_role_srv
-- ----------------------------
DROP TABLE IF EXISTS `staff_role_srv`;
CREATE TABLE `staff_role_srv`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色ID',
  `srv_game_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工角色关联游戏服' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff_role_srv
-- ----------------------------
INSERT INTO `staff_role_srv` VALUES (1, 5, '1');

-- ----------------------------
-- Table structure for staff_role_srv_group
-- ----------------------------
DROP TABLE IF EXISTS `staff_role_srv_group`;
CREATE TABLE `staff_role_srv_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL COMMENT '员工角色ID',
  `srv_group_id` int(11) NULL DEFAULT NULL COMMENT '服务器组ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工角色与服务器组' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff_role_srv_group
-- ----------------------------
INSERT INTO `staff_role_srv_group` VALUES (1, 5, 1);
INSERT INTO `staff_role_srv_group` VALUES (2, 7, 1);

-- ----------------------------
-- Table structure for stat_sum
-- ----------------------------
DROP TABLE IF EXISTS `stat_sum`;
CREATE TABLE `stat_sum`  (
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区服编码',
  `srv_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` date NOT NULL COMMENT '日期',
  `update_time` datetime NULL DEFAULT NULL COMMENT '数据更新时间',
  `login_new_create` int(11) NULL DEFAULT NULL COMMENT '登录新增创角',
  `login_new_register` int(11) NULL DEFAULT NULL COMMENT '登录新增注册',
  `login_IMEI` int(11) NULL DEFAULT NULL,
  `login_new_IMEI` int(11) NULL DEFAULT NULL,
  `login_ip` int(11) NULL DEFAULT NULL,
  `login_new_ip` int(11) NULL DEFAULT NULL,
  `login_master` int(11) NULL DEFAULT NULL,
  `login_new_master` int(11) NULL DEFAULT NULL,
  `pay_rmb` double NULL DEFAULT NULL,
  `pay_count` int(11) NULL DEFAULT NULL,
  `pay_count_master` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`srv_code`, `date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '每日合计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stat_sum
-- ----------------------------

-- ----------------------------
-- Table structure for supervise_report
-- ----------------------------
DROP TABLE IF EXISTS `supervise_report`;
CREATE TABLE `supervise_report`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `srv_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器编码',
  `srv_index` int(11) NULL DEFAULT NULL COMMENT '服务器序号',
  `srv_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器名',
  `channel_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道编码',
  `role_create_time` timestamp NULL DEFAULT NULL COMMENT '创角时间',
  `open_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'OPEN ID',
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色唯一ID',
  `role_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `role_level` int(11) NULL DEFAULT NULL COMMENT '角色等级',
  `role_vip` int(11) NULL DEFAULT NULL COMMENT '角色VIP',
  `role_power` bigint(20) NULL DEFAULT NULL COMMENT '角色战力',
  `assess_value` double NULL DEFAULT NULL COMMENT '角色估值',
  `m0` bigint(20) NULL DEFAULT NULL COMMENT '金币数量',
  `m1` bigint(20) NULL DEFAULT NULL COMMENT '元宝数量',
  `hero_exp` bigint(20) NULL DEFAULT NULL COMMENT '英雄经验',
  `pay_sum` double NULL DEFAULT NULL COMMENT '累计充值金额(元)',
  `report_time` timestamp NULL DEFAULT NULL COMMENT '上报时间',
  `event` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上报事件类型',
  `detail` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上报详情',
  `assess_value_delta` double NULL DEFAULT NULL COMMENT '角色估值变化量',
  `pay_sum_delta` double NULL DEFAULT NULL COMMENT '充值变化量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '监控汇报' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of supervise_report
-- ----------------------------
INSERT INTO `supervise_report` VALUES (1, 's2', 2, '测试2服', NULL, '2022-04-07 03:45:55', '123456@develop', '624d533f1b3148132588641e', '姚紊', 137, 5, 1898, 20085518.2714784, 1051210000, 100026314, 3051000624, 0, '2022-04-07 04:07:11', 'assess-warn', NULL, 704.3380512171103, 0);
INSERT INTO `supervise_report` VALUES (2, 's2', 2, '测试2服', NULL, '2022-04-07 04:08:17', '111111@develop', '624d587ec2c8c37a18d7d02b', '宫浩轩', 137, 0, 1898, 20084224.857219204, 1000468900, 100021739, 3000002237, 0, '2022-04-07 04:18:25', 'assess-warn', NULL, 704.3544917824324, 0);
INSERT INTO `supervise_report` VALUES (3, 's1', 1, '测试1服', NULL, '2022-04-07 04:30:24', '111111@develop', '624d5dad43955307b3f74d8d', '狄擎', 137, 0, 1898, 20084114.0099784, 1000110000, 100020829, 2999999999, 0, '2022-04-07 04:32:08', 'assess-warn', NULL, 704.3506043656903, 0);
INSERT INTO `supervise_report` VALUES (4, 's2', 2, '测试2服', NULL, '2022-04-07 05:48:57', '1234561@develop', '624d7014c2c8c37a18d7d175', '浅吟花未央', 137, 5, 1898, 20149253.9099784, 1020010000, 100019709, 3019999999, 648, '2022-04-07 06:13:24', 'assess-warn', NULL, 690.8741114814702, 648);
INSERT INTO `supervise_report` VALUES (5, 's1', 1, '测试1服', NULL, '2022-04-07 10:08:24', '123456@develop', '624dace0e87f7533576c9782', '888888', 137, 5, 1898, 20086407.3099784, 1050010000, 100036189, 3049999999, 0, '2022-04-07 10:11:49', 'assess-warn', NULL, 704.369274839764, 0);
INSERT INTO `supervise_report` VALUES (6, 's1', 1, 'DL - 1', NULL, '2025-03-24 02:05:28', 'admin@develop', '67e04d63cdb87869e6fdb5f6', 'Tháo', 200, 50, 1898, 104408093.40224245, 2147843647, 10021278, 2147584272, 18500530, '2025-03-25 12:25:58', 'assess-warn', NULL, 105.11562579180479, 0);

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务类型',
  `detail` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务详情',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '任务创建时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '任务结束时间',
  `error_code` int(11) NULL DEFAULT NULL COMMENT '错误码',
  `error_msg` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '错误消息',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行操作的用户名',
  `status` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务状态',
  `tag1` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签1',
  `tag2` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签2',
  `tag3` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_task
-- ----------------------------

-- ----------------------------
-- Table structure for vip_service
-- ----------------------------
DROP TABLE IF EXISTS `vip_service`;
CREATE TABLE `vip_service`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道id',
  `main_show` tinyint(1) NULL DEFAULT 1 COMMENT '主界面是否显示',
  `system_show` tinyint(1) NULL DEFAULT 1 COMMENT '系统界面是否显示',
  `money` double NULL DEFAULT 0 COMMENT '金额',
  `contact_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '联系信息',
  `page_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '页面信息',
  `pic_id` int(11) NULL DEFAULT NULL COMMENT '头像图片id',
  `upsert_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_service
-- ----------------------------

-- ----------------------------
-- Table structure for vip_service_tar
-- ----------------------------
DROP TABLE IF EXISTS `vip_service_tar`;
CREATE TABLE `vip_service_tar`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NULL DEFAULT NULL COMMENT '关联的主表id',
  `srv_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服编码',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_code_id`(`srv_code`, `service_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vip_service_tar
-- ----------------------------

-- ----------------------------
-- Table structure for world_invite_record
-- ----------------------------
DROP TABLE IF EXISTS `world_invite_record`;
CREATE TABLE `world_invite_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `master_id_hex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `account_uid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `open_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邀请记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of world_invite_record
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
