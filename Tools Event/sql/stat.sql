/*
 Navicat Premium Data Transfer

 Source Server         : H5
 Source Server Type    : MySQL
 Source Server Version : 50744
 Source Host           : localhost:3306
 Source Schema         : stat

 Target Server Type    : MySQL
 Target Server Version : 50744
 File Encoding         : 65001

 Date: 08/04/2025 11:51:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for briefing_daily
-- ----------------------------
DROP TABLE IF EXISTS `briefing_daily`;
CREATE TABLE `briefing_daily`  (
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `srv_index` int(11) NULL DEFAULT NULL COMMENT '游戏服序号',
  `srv_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服名',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'GameID',
  `app_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用名称',
  `date` date NOT NULL COMMENT '日期',
  `pay_num` double NULL DEFAULT NULL COMMENT '充值数额',
  `pay_times` int(11) NULL DEFAULT NULL COMMENT '充值次数',
  `new_role_num` int(11) NULL DEFAULT NULL COMMENT '当日新增创角',
  `new_account_num` int(11) NULL DEFAULT NULL COMMENT '当日新导入账号',
  `new_device_num` int(11) NULL DEFAULT NULL COMMENT '当日新导入设备',
  `new_ip_num` int(11) NULL DEFAULT NULL COMMENT '当日新导入IP',
  `login_role_num` int(11) NULL DEFAULT NULL COMMENT '今日登陆角色数',
  `login_account_num` int(11) NULL DEFAULT NULL COMMENT '今日登陆账号数',
  `login_device_num` int(11) NULL DEFAULT NULL COMMENT '今日登陆设备数',
  `login_ip_num` int(11) NULL DEFAULT NULL COMMENT '今日登陆IP数',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '数据更新时间',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '所属服务器组ID',
  `pay_role_num` int(11) NULL DEFAULT NULL COMMENT '支付角色数',
  `pay_account_num` int(11) NULL DEFAULT NULL COMMENT '支付账户数',
  PRIMARY KEY (`srv_code`, `game_id`, `date`) USING BTREE,
  INDEX `briefing_daily_srv_code_IDX`(`srv_code`) USING BTREE,
  INDEX `briefing_daily_game_id_IDX`(`game_id`) USING BTREE,
  INDEX `briefing_daily_date_IDX`(`date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '每日简报' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of briefing_daily
-- ----------------------------

-- ----------------------------
-- Table structure for first_login_imei
-- ----------------------------
DROP TABLE IF EXISTS `first_login_imei`;
CREATE TABLE `first_login_imei`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imei` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设备号',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务器编号',
  `login_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_imei`(`imei`) USING BTREE,
  INDEX `idx_login_time_srv_code`(`srv_code`, `login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of first_login_imei
-- ----------------------------

-- ----------------------------
-- Table structure for first_login_ip
-- ----------------------------
DROP TABLE IF EXISTS `first_login_ip`;
CREATE TABLE `first_login_ip`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'ip',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务器编号',
  `login_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_ip`(`ip`) USING BTREE,
  INDEX `idx_login_time_srv_code`(`srv_code`, `login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of first_login_ip
-- ----------------------------

-- ----------------------------
-- Table structure for hero_lineup
-- ----------------------------
DROP TABLE IF EXISTS `hero_lineup`;
CREATE TABLE `hero_lineup`  (
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色唯一ID',
  `lineup_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阵容类型',
  `role_level` int(11) NULL DEFAULT NULL COMMENT '角色等级',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属服务器编码',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '数据更新时间',
  `hero_tid_1` int(11) NULL DEFAULT NULL COMMENT '1号英雄模板ID',
  `hero_lv_1` int(11) NULL DEFAULT NULL COMMENT '1号英雄等级',
  `hero_tid_2` int(11) NULL DEFAULT NULL COMMENT '2号英雄模板ID',
  `hero_lv_2` int(11) NULL DEFAULT NULL COMMENT '2号英雄等级',
  `hero_tid_3` int(11) NULL DEFAULT NULL COMMENT '3号英雄模板ID',
  `hero_lv_3` int(11) NULL DEFAULT NULL COMMENT '3号英雄等级',
  `hero_tid_4` int(11) NULL DEFAULT NULL COMMENT '4号英雄模板ID',
  `hero_lv_4` int(11) NULL DEFAULT NULL COMMENT '4号英雄等级',
  `hero_tid_5` int(11) NULL DEFAULT NULL COMMENT '5号英雄模板ID',
  `hero_lv_5` int(11) NULL DEFAULT NULL COMMENT '5号英雄等级',
  PRIMARY KEY (`role_id`, `lineup_type`) USING BTREE,
  INDEX `hero_lineup_update_time_IDX`(`update_time`) USING BTREE,
  INDEX `hero_lineup_srv_code_IDX`(`srv_code`) USING BTREE,
  INDEX `hero_lineup_role_level_IDX`(`role_level`) USING BTREE,
  INDEX `hero_lineup_role_id_IDX`(`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '英雄阵容使用情况统计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hero_lineup
-- ----------------------------
INSERT INTO `hero_lineup` VALUES ('67df0ecf6e5dc971faecb456', '1001', 3, 's1', '2025-03-23 03:33:46', 600301, 1, 600401, 1, 600601, 1, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67df9335e7717c2e18b7de9f', '1001', 57, 's1', '2025-03-25 02:22:01', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e04d63cdb87869e6fdb5f6', '1001', 200, 's1', '2025-03-25 17:14:04', 802301, 1, 802801, 1, 802401, 1, 803501, 1, 801901, 1);
INSERT INTO `hero_lineup` VALUES ('67e0ce62e36ade3322b1f37d', '1001', 1, 's1', '2025-03-24 11:15:56', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e0d20be36ade3322b1f403', '1001', 2, 's1', '2025-03-25 09:52:38', 100901, 1, 102001, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e7dd11ba7f185f7d8029c5', '1001', 1, 's1', '2025-03-29 19:44:26', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e7dfecc9a3d57a8519855d', '1001', 1, 's1', '2025-03-29 19:56:34', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e7e37af078e635ca6bf84d', '1001', 1, 's2', '2025-03-29 20:11:47', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e7e97190073674998a8b2e', '1001', 1, 's1', '2025-03-29 20:37:18', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e7e99090073674998a8b66', '1001', 1, 's1', '2025-03-29 20:37:41', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e7ee8b90073674998a8bb2', '1001', 1, 's1', '2025-03-29 20:58:56', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e8068590073674998a8c15', '1001', 11, 's1', '2025-03-31 09:58:48', 201801, 1, 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e807d790073674998a8c45', '1001', 1, 's1', '2025-03-29 22:46:54', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e81f41682ed105c6bee271', '1001', 200, 's1', '2025-04-04 12:25:08', 602001, 95, 601401, 60, 601901, 60, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67e8e17cc261ae5c5a156391', '1001', 2, 's1', '2025-03-30 14:20:16', 100901, 1, 501101, 1, 301801, 1, 201801, 1, 201701, 1);
INSERT INTO `hero_lineup` VALUES ('67ebc24ec261ae5c5a1568a2', '1001', 2, 's1', '2025-04-01 18:40:17', 100901, 1, 201301, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67ebd85fc261ae5c5a156971', '1001', 2, 's1', '2025-04-01 20:14:39', 100901, 1, 201301, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67ef9615c261ae5c5a156f7f', '1001', 2, 's1', '2025-04-04 16:20:59', 100901, 1, 201301, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67f0e396c261ae5c5a157142', '1001', 1, 's1', '2025-04-05 16:02:39', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67f147ecc261ae5c5a15724b', '1001', 1, 's1', '2025-04-05 23:11:04', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `hero_lineup` VALUES ('67f3b1e8c261ae5c5a1574cb', '1001', 4, 's1', '2025-04-07 19:19:07', 100901, 80, 201301, 80, 102002, 145, 101501, 100, 101601, 1);
INSERT INTO `hero_lineup` VALUES ('67f4a8b9c261ae5c5a15772b', '1001', 1, 's1', '2025-04-08 12:40:33', 100901, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for hero_record
-- ----------------------------
DROP TABLE IF EXISTS `hero_record`;
CREATE TABLE `hero_record`  (
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `srv_index` int(11) NULL DEFAULT NULL,
  `srv_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `owner_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hero_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `star` int(11) NULL DEFAULT NULL,
  `hero_tid` int(11) NULL DEFAULT NULL,
  `hero_pid` int(11) NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  INDEX `hero_record_srv_code_IDX`(`srv_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hero_record
-- ----------------------------

-- ----------------------------
-- Table structure for hero_record_v2
-- ----------------------------
DROP TABLE IF EXISTS `hero_record_v2`;
CREATE TABLE `hero_record_v2`  (
  `uid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '英雄唯一ID',
  `tid` int(11) NULL DEFAULT NULL COMMENT '英雄模板ID',
  `pid` int(11) NULL DEFAULT NULL COMMENT '英雄原型ID',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '英雄名称',
  `star` int(11) NULL DEFAULT NULL COMMENT '英雄星级',
  `level` int(11) NULL DEFAULT NULL COMMENT '英雄等级',
  `power` bigint(20) NULL DEFAULT NULL COMMENT '战力',
  `srv_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属游戏服编码',
  `role_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属角色ID',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '数据更新时间',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '所属服务器组',
  `game_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属GameID',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '英雄统计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of hero_record_v2
-- ----------------------------

-- ----------------------------
-- Table structure for login_account
-- ----------------------------
DROP TABLE IF EXISTS `login_account`;
CREATE TABLE `login_account`  (
  `account_uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号ID',
  `reg_date` date NOT NULL COMMENT '注册日期',
  `login_date` date NULL DEFAULT NULL COMMENT '登录日期',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `srv_group_id` int(11) NULL DEFAULT NULL COMMENT '所属服务器组ID',
  PRIMARY KEY (`account_uid`, `reg_date`) USING BTREE,
  INDEX `login_account_game_id_IDX`(`game_id`) USING BTREE,
  INDEX `login_account_srv_code_IDX`(`srv_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基于账号的登录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login_account
-- ----------------------------
INSERT INTO `login_account` VALUES ('102b34e4-fdcf-4848-b5a8-a9cf465f67a6', '2025-03-29', '2025-03-29', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('15913be0-0ea5-40d2-81cb-71926ce75eed', '2025-03-29', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('466d444d-816b-49e9-a7c4-b0dd70c606cf', '2025-03-29', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('54e56d80-ee84-4a70-940b-d6187be9e442', '2025-03-24', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('564e63ba-71da-4604-8aa2-4eeb8dd56196', '2025-03-23', '2025-03-23', '888088', 's1', 1);
INSERT INTO `login_account` VALUES ('5cf5d7cf-9ddb-4457-9229-e267976bf76c', '2025-04-01', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('5d30f992-4e96-4315-bcd5-f35c0b9916a9', '2025-04-07', '2025-04-07', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('600eabab-692c-408d-92e4-606feca2e5c7', '2025-03-24', '2025-03-24', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('600eabab-692c-408d-92e4-606feca2e5c7', '2025-04-08', '2025-04-08', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('657e8cf5-0346-42a8-9728-c5a8a91206d2', '2025-03-30', '2025-04-04', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('6b56c0d1-83e0-4426-9254-5601702b4aab', '2025-04-04', '2025-04-04', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('6e9ab3d4-f808-4b1c-93da-f37c7890e197', '2025-03-29', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('6edbdec7-c8a7-4111-a2fa-6c668b9b0025', '2025-04-05', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('7bdfd8ce-906c-4ebf-8117-286b2b4fb7a6', '2025-04-05', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('8425af68-ef25-4a73-9a4d-6ab7f6c17654', '2025-03-24', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('9b8a69d0-f123-4c0c-97d0-d1d2aeec2d0e', '2025-04-01', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('abe224c9-4cf4-415f-acd8-75a74e3cae4a', '2025-03-23', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('abe224c9-4cf4-415f-acd8-75a74e3cae4a', '2025-03-29', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('cd4966cc-fafb-4808-86e9-b34ccda84b88', '2025-03-30', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('dfe7477a-18e6-4c3d-8b06-4a14edf17461', '2025-03-29', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_account` VALUES ('ec65135d-2733-49d3-8ba4-ac6d5984215a', '2025-03-29', '2025-04-01', '10091', 's1', 1);

-- ----------------------------
-- Table structure for login_device
-- ----------------------------
DROP TABLE IF EXISTS `login_device`;
CREATE TABLE `login_device`  (
  `device_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备码',
  `reg_date` date NOT NULL COMMENT '注册日期',
  `login_date` date NULL DEFAULT NULL COMMENT '登录日期',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `srv_group_id` int(11) NULL DEFAULT NULL COMMENT '所属服务器组ID',
  PRIMARY KEY (`device_code`, `reg_date`) USING BTREE,
  INDEX `login_device_game_id_IDX`(`game_id`) USING BTREE,
  INDEX `login_device_srv_code_IDX`(`srv_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基于设备的登录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login_device
-- ----------------------------
INSERT INTO `login_device` VALUES ('人造03d98332-dfc1-4241-acdc-cf4f233fe0f0', '2025-03-29', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造11fc2f20-612d-4065-8baf-0029909757d3', '2025-03-30', '2025-04-04', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造1c5f6503-da42-4961-9981-7cfe5f1737fe', '2025-04-04', '2025-04-04', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造1e873664-16b1-4585-9ae2-51f61694dfc0', '2025-03-29', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造4f30311a-35a8-432b-a5cf-06003e6372bb', '2025-03-29', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造5a5488be-265c-4d29-97bd-caca1e8ce1f7', '2025-03-24', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造68517c52-9ab4-498f-a124-c68d89b1d5f3', '2025-04-05', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造89405978-5aac-4e61-901f-0c36c026bf15', '2025-03-24', '2025-03-24', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造89405978-5aac-4e61-901f-0c36c026bf15', '2025-04-08', '2025-04-08', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造956fee73-e4fe-4750-9eea-250589762c80', '2025-04-07', '2025-04-07', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造a440ee14-555f-42f3-b9ce-274c3f54741f', '2025-03-23', '2025-03-23', '888088', 's1', 1);
INSERT INTO `login_device` VALUES ('人造b43ffff2-dce5-41ac-b954-7565065aca8f', '2025-03-29', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造bd46d3eb-dcfc-4e21-b284-ecd77f4aa50b', '2025-03-23', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造bd46d3eb-dcfc-4e21-b284-ecd77f4aa50b', '2025-03-29', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造c2d00c82-e45e-4f3f-9489-29d42fa3e55e', '2025-04-05', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造c7cf9344-ec22-4c5f-8a3f-a9f61ac6cf7e', '2025-03-29', '2025-03-29', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造cf35d3c3-35bb-4374-8a9a-449734d87295', '2025-04-01', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造d216fc12-c56f-4779-9de8-08e31234338b', '2025-03-24', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造de1b45b8-ed3b-4928-8771-e12b5ed345a7', '2025-03-29', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造ee8bf7af-27fd-4b5b-b931-48e8a9cdc750', '2025-03-30', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_device` VALUES ('人造f01c46c1-9ccc-4c97-ac87-ccc2cb01ae97', '2025-04-01', '2025-04-01', '10091', 's1', 1);

-- ----------------------------
-- Table structure for login_flow
-- ----------------------------
DROP TABLE IF EXISTS `login_flow`;
CREATE TABLE `login_flow`  (
  `open_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'OPENID',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `sdk_login` int(11) NULL DEFAULT 0 COMMENT '叶子戏SDK登录完成次数',
  `meta_start` int(11) NULL DEFAULT 0 COMMENT '请求meta服facade/client/start接口次数',
  `login_account` int(11) NULL DEFAULT 0 COMMENT '请求login服account/login接口次数',
  `login_game_list` int(11) NULL DEFAULT 0 COMMENT '请求login服srv/game/list接口次数',
  `login_connect_target` int(11) NULL DEFAULT 0 COMMENT '向login服请求目标游戏服连接信息次数',
  `client_template` int(11) NULL DEFAULT 0 COMMENT '客户端下载并解析模板表次数',
  `game_ws` int(11) NULL DEFAULT 0 COMMENT '游戏服websocket连接成功次数',
  `game_enter` int(11) NULL DEFAULT 0 COMMENT '进入游戏主界面次数',
  `role_create` int(11) NULL DEFAULT 0 COMMENT '角色创建',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`open_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '登录流程打点' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login_flow
-- ----------------------------
INSERT INTO `login_flow` VALUES ('123123', '2025-03-29 08:37:18', 1, 0, 1, 1, 1, 1, 1, 1, 1, '10091', '2025-03-29 20:36:56');
INSERT INTO `login_flow` VALUES ('12345678h', '2025-04-05 09:45:45', 1, 0, 1, 1, 1, 0, 0, 0, 0, '10091', '2025-04-05 21:45:38');
INSERT INTO `login_flow` VALUES ('234234', '2025-04-08 00:40:33', 2, 0, 2, 2, 2, 2, 2, 2, 2, '10091', '2025-03-24 11:15:42');
INSERT INTO `login_flow` VALUES ('admin', '2025-03-25 17:58:22', 45, 0, 45, 45, 37, 37, 45, 45, 1, '10091', '2025-03-24 02:05:19');
INSERT INTO `login_flow` VALUES ('alex123', '2025-04-02 03:46:39', 4, 0, 4, 4, 3, 2, 3, 3, 1, '10091', '2025-04-01 20:12:07');
INSERT INTO `login_flow` VALUES ('hihihi', '2025-04-05 04:02:39', 1, 0, 1, 1, 1, 1, 1, 1, 1, '10091', '2025-04-05 16:02:25');
INSERT INTO `login_flow` VALUES ('hoanghung', '2025-04-05 06:22:21', 4, 0, 4, 4, 3, 3, 3, 3, 0, '10091', '2025-03-29 22:38:11');
INSERT INTO `login_flow` VALUES ('khanhlam', '2025-03-30 03:21:11', 2, 0, 2, 2, 1, 1, 1, 1, 1, '10091', '2025-03-30 14:15:17');
INSERT INTO `login_flow` VALUES ('lak000', '2025-04-05 10:02:40', 5, 0, 5, 5, 4, 4, 4, 4, 1, '10091', '2025-03-29 20:37:32');
INSERT INTO `login_flow` VALUES ('oiconga123', '2025-04-05 11:11:04', 1, 0, 1, 1, 1, 1, 1, 1, 1, '10091', '2025-04-05 23:10:26');
INSERT INTO `login_flow` VALUES ('phucbaby', '2025-04-01 06:39:26', 1, 0, 1, 1, 1, 1, 1, 1, 1, '10091', '2025-04-01 18:38:58');
INSERT INTO `login_flow` VALUES ('phucok', '2025-04-01 06:36:29', 2, 0, 2, 2, 2, 2, 2, 2, 1, '10091', '2025-03-29 22:46:25');
INSERT INTO `login_flow` VALUES ('shuichi', '2025-04-01 06:48:02', 2, 0, 2, 2, 2, 2, 2, 2, 1, '10091', '2025-03-29 20:58:47');
INSERT INTO `login_flow` VALUES ('test11', '2025-03-29 12:18:00', 122, 0, 122, 122, 88, 86, 91, 79, 3, '10091', '2025-03-23 03:26:06');
INSERT INTO `login_flow` VALUES ('test111', '2025-03-25 08:51:56', 7, 0, 7, 7, 5, 4, 4, 4, 1, '10091', '2025-03-24 11:31:09');
INSERT INTO `login_flow` VALUES ('test12', '2025-03-29 12:26:09', 15, 0, 15, 15, 11, 11, 7, 6, 2, '10091', '2025-03-29 19:56:25');
INSERT INTO `login_flow` VALUES ('test13', '2025-04-04 00:26:25', 127, 0, 127, 127, 101, 101, 112, 112, 1, '10091', '2025-03-30 00:26:32');
INSERT INTO `login_flow` VALUES ('thmodz', '2025-04-04 04:19:45', 1, 0, 1, 1, 1, 1, 1, 1, 1, '10091', '2025-04-04 16:19:29');
INSERT INTO `login_flow` VALUES ('toan300', '2025-03-29 20:01:19', 3, 0, 3, 3, 3, 3, 0, 0, 0, '10091', '2025-03-30 08:00:45');
INSERT INTO `login_flow` VALUES ('toan95', '2025-04-07 07:13:27', 2, 0, 2, 2, 2, 2, 2, 2, 1, '10091', '2025-04-07 19:07:15');
INSERT INTO `login_flow` VALUES ('tungpuskin', '2025-03-29 08:48:25', 2, 0, 2, 2, 2, 0, 0, 0, 0, '10091', '2025-03-29 20:48:00');

-- ----------------------------
-- Table structure for login_ip
-- ----------------------------
DROP TABLE IF EXISTS `login_ip`;
CREATE TABLE `login_ip`  (
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IP地址',
  `reg_date` date NOT NULL COMMENT '注册日期',
  `login_date` date NULL DEFAULT NULL COMMENT '登录日期',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `srv_group_id` int(11) NULL DEFAULT NULL COMMENT '所属服务器组ID',
  PRIMARY KEY (`ip`, `reg_date`) USING BTREE,
  INDEX `login_ip_game_id_IDX`(`game_id`) USING BTREE,
  INDEX `login_ip_srv_code_IDX`(`srv_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基于IP的登录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login_ip
-- ----------------------------
INSERT INTO `login_ip` VALUES ('1.53.240.32', '2025-03-29', '2025-03-29', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('103.53.170.145', '2025-03-23', '2025-03-24', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('113.23.102.52', '2025-03-29', '2025-03-29', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('115.75.161.198', '2025-04-04', '2025-04-04', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('118.70.144.69', '2025-03-23', '2025-03-24', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('118.70.144.69', '2025-03-24', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('118.70.144.69', '2025-03-30', '2025-04-04', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('118.70.98.15', '2025-03-29', '2025-03-29', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('118.71.18.80', '2025-03-24', '2025-03-24', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('118.71.92.3', '2025-03-30', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('123.21.250.95', '2025-03-29', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('123.27.3.155', '2025-03-29', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('125.212.159.192', '2025-04-01', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('125.235.121.2', '2025-04-07', '2025-04-07', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('14.177.45.193', '2025-04-01', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('14.186.237.207', '2025-04-08', '2025-04-08', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.225.184.83', '2025-04-05', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.237.167.213', '2025-03-29', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.241.25.59', '2025-03-30', '2025-04-02', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.241.51.28', '2025-03-29', '2025-03-29', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.241.58.35', '2025-03-23', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.241.58.35', '2025-03-24', '2025-03-24', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.241.87.23', '2025-03-29', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.241.87.23', '2025-03-30', '2025-03-31', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.244.120.68', '2025-03-29', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.244.84.159', '2025-03-29', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('171.255.127.36', '2025-03-29', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('42.113.240.67', '2025-03-29', '2025-03-31', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('42.114.249.194', '2025-03-29', '2025-03-29', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('58.187.54.180', '2025-04-05', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_ip` VALUES ('59.153.228.111', '2025-04-01', '2025-04-01', '10091', 's1', 1);

-- ----------------------------
-- Table structure for login_role
-- ----------------------------
DROP TABLE IF EXISTS `login_role`;
CREATE TABLE `login_role`  (
  `role_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  `reg_date` date NOT NULL COMMENT '注册日期',
  `login_date` date NULL DEFAULT NULL COMMENT '登录日期',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `srv_group_id` int(11) NULL DEFAULT NULL COMMENT '所属服务器组ID',
  PRIMARY KEY (`role_id`, `reg_date`) USING BTREE,
  INDEX `login_role_game_id_IDX`(`game_id`) USING BTREE,
  INDEX `login_role_srv_code_IDX`(`srv_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基于角色的登录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login_role
-- ----------------------------
INSERT INTO `login_role` VALUES ('67df0ecf6e5dc971faecb456', '2025-03-23', '2025-03-23', '888088', 's1', 1);
INSERT INTO `login_role` VALUES ('67df9335e7717c2e18b7de9f', '2025-03-23', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e04d63cdb87869e6fdb5f6', '2025-03-24', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e0ce62e36ade3322b1f37d', '2025-03-24', '2025-03-24', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e0d20be36ade3322b1f403', '2025-03-24', '2025-03-25', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e7dd11ba7f185f7d8029c5', '2025-03-29', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e7dfecc9a3d57a8519855d', '2025-03-29', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e7e37af078e635ca6bf84d', '2025-03-29', '2025-03-29', '10091', 's2', 1);
INSERT INTO `login_role` VALUES ('67e7e97190073674998a8b2e', '2025-03-29', '2025-03-29', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e7e99090073674998a8b66', '2025-03-29', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e7ee8b90073674998a8bb2', '2025-03-29', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e8068590073674998a8c15', '2025-03-29', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e807d790073674998a8c45', '2025-03-29', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e81f41682ed105c6bee271', '2025-03-30', '2025-04-04', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67e8e17cc261ae5c5a156391', '2025-03-30', '2025-03-30', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67ebc24ec261ae5c5a1568a2', '2025-04-01', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67ebd85fc261ae5c5a156971', '2025-04-01', '2025-04-01', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67ef9615c261ae5c5a156f7f', '2025-04-04', '2025-04-04', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67f0e396c261ae5c5a157142', '2025-04-05', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67f147ecc261ae5c5a15724b', '2025-04-05', '2025-04-05', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67f3b1e8c261ae5c5a1574cb', '2025-04-07', '2025-04-07', '10091', 's1', 1);
INSERT INTO `login_role` VALUES ('67f4a8b9c261ae5c5a15772b', '2025-04-08', '2025-04-08', '10091', 's1', 1);

-- ----------------------------
-- Table structure for online
-- ----------------------------
DROP TABLE IF EXISTS `online`;
CREATE TABLE `online`  (
  `srv_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '游戏服编码',
  `online_num` int(11) NULL DEFAULT NULL COMMENT '在线人数',
  `time` timestamp NULL DEFAULT NULL COMMENT '记录时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '在线统计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of online
-- ----------------------------

-- ----------------------------
-- Table structure for participate
-- ----------------------------
DROP TABLE IF EXISTS `participate`;
CREATE TABLE `participate`  (
  `srv_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '游戏区服编码',
  `func_id` int(11) NULL DEFAULT NULL COMMENT '功能ID',
  `times` int(11) NULL DEFAULT NULL COMMENT '参与人次',
  `num` int(11) NULL DEFAULT NULL COMMENT '参与人数',
  `begin_time` timestamp NULL DEFAULT NULL COMMENT '记录开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '记录结束时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '游戏功能参与统计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of participate
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
  `third_gift_stone` int(11) NULL DEFAULT NULL,
  `third_ware_count` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `record_platform_order_id_IDX`(`platform_order_id`) USING BTREE,
  INDEX `idx_pay_time`(`pay_time`) USING BTREE,
  INDEX `idx_srv_code`(`srv_code`) USING BTREE,
  INDEX `pay_record_create_time_IDX`(`create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '充值记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pay_record
-- ----------------------------
INSERT INTO `pay_record` VALUES ('035657c7-8d28-4a88-be3b-15365225e1c0', 1, 'develop', NULL, NULL, '111111@develop', NULL, NULL, '2022-04-06 23:06:06', NULL, 1, 0, NULL, 's1', 18002, 1, '充值-30元', 30, '1361b690-2c60-4678-b07c-572be4f93636', '624dabede87f7533576c9741', '李三问', NULL, NULL, NULL, 'com.xkd.yzx.tfun.30', 0, NULL, 'zh_CN', 0, '10091', '充值-30元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('13b71425-bfe9-4def-addc-b7311c9c8c48', 1, 'develop', NULL, NULL, '111111@develop', NULL, NULL, '2022-04-06 23:06:07', NULL, 1, 0, NULL, 's1', 18002, 1, '充值-30元', 30, '1361b690-2c60-4678-b07c-572be4f93636', '624dabede87f7533576c9741', '李三问', NULL, NULL, NULL, 'com.xkd.yzx.tfun.30', 0, NULL, 'zh_CN', 0, '10091', '充值-30元', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('47dc90ff-476e-4833-b3f7-3e45a6edb2cd', 1, 'develop', NULL, NULL, '111111@develop', NULL, NULL, '2022-04-06 23:06:09', NULL, 1, 0, NULL, 's1', 19001, 1, '每日礼包', 6, '1361b690-2c60-4678-b07c-572be4f93636', '624dabede87f7533576c9741', '李三问', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);
INSERT INTO `pay_record` VALUES ('c049ad42-96c4-44da-a67e-3f968d38efdf', 1, 'develop', NULL, NULL, '111111@develop', NULL, NULL, '2022-04-06 23:06:09', NULL, 1, 0, NULL, 's1', 19001, 1, '每日礼包', 6, '1361b690-2c60-4678-b07c-572be4f93636', '624dabede87f7533576c9741', '李三问', NULL, NULL, NULL, 'com.xkd.yzx.tfun.6', 0, NULL, 'zh_CN', 0, '10091', '每日礼包', NULL, 0, 0);

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
  `group_id` int(11) NULL DEFAULT NULL COMMENT '服务器组ID',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  PRIMARY KEY (`role_id`) USING BTREE,
  INDEX `role_key_res_num_role_name_IDX`(`role_name`) USING BTREE,
  INDEX `role_key_res_num_srv_code_IDX`(`srv_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '基于角色的关键数量统计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_key_res_num
-- ----------------------------
INSERT INTO `role_key_res_num` VALUES ('67df0ecf6e5dc971faecb456', 'Thuy1', 's1', 'DL - 1', 1, '2025-03-23 03:43:38', 200, 10, 2012, 0, 307, NULL, NULL, NULL, NULL, NULL, NULL, 346550, 141408, 8041, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 700, 0, 6909, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '888088');
INSERT INTO `role_key_res_num` VALUES ('67df9335e7717c2e18b7de9f', 'Tháooo', 's1', 'DL - 1', 1, '2025-03-25 02:45:09', 57, 10, 178121, 0, 11, NULL, NULL, NULL, NULL, NULL, NULL, 36001847, 224932, 7843708, 0, 90210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8180, 81044, 4661, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e04d63cdb87869e6fdb5f6', 'Tháo', 's1', 'DL - 1', 1, '2025-03-25 18:59:19', 200, 50, 174225, 0, 14, NULL, NULL, NULL, NULL, NULL, NULL, 2147856247, 10021288, 1992706723, 0, 172000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19440, 18500530, 19114, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e0ce62e36ade3322b1f37d', '', 's1', 'DL - 1', 1, '2025-03-24 11:16:21', 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e0d20be36ade3322b1f403', 'Tào', 's1', 'DL - 1', 1, '2025-03-25 09:52:14', 1, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1298, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e7dd11ba7f185f7d8029c5', 'Nhac0', 's1', 'DL - 1', 1, '2025-03-30 00:18:20', 2, 14, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 300000, 995004, 100625, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 500000, 1298, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e7dfecc9a3d57a8519855d', 'Lieu8', 's1', 'DL - 1', 1, '2025-03-30 00:26:31', 2, 18, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 1000001, 625, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 10500000, 1298, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e7e37af078e635ca6bf84d', '', 's2', 'DL - 2', 2, '2025-03-29 20:12:24', 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e7e97190073674998a8b2e', '', 's1', 'DL - 1', 1, '2025-03-29 20:38:02', 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e7e99090073674998a8b66', 'By6', 's1', 'DL - 1', 1, '2025-04-05 22:03:01', 3, 14, 9, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 208300, 1000010, 2163, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 300, 500000, 1298, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e7ee8b90073674998a8bb2', 'Tram2', 's1', 'DL - 1', 1, '2025-04-01 18:49:00', 2, 14, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 1000005, 625, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 500000, 1298, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e8068590073674998a8c15', 'Thuy3', 's1', 'DL - 1', 1, '2025-04-05 18:22:59', 57, 10, 100982, 0, 6, NULL, NULL, NULL, NULL, NULL, NULL, 13223910, 52676, 3264373, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4400, 4000, 2898, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e807d790073674998a8c45', 'Dung2', 's1', 'DL - 1', 1, '2025-04-01 18:37:00', 2, 10, 2, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, 200000, 5, 625, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 1298, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e81f41682ed105c6bee271', 'DLGAME', 's1', 'DL - 1', 1, '2025-04-04 12:26:42', 200, 14, 9995931, 0, 77, NULL, NULL, NULL, NULL, NULL, NULL, 9995220883, 1200517, 9993993857, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22000, 501000, 144512, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67e8e17cc261ae5c5a156391', '', 's1', 'DL - 1', 1, '2025-03-30 14:15:25', 1, 10, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67ebc24ec261ae5c5a1568a2', '', 's1', 'DL - 1', 1, '2025-04-01 18:40:00', 1, 10, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67ebd85fc261ae5c5a156971', 'Mai7', 's1', 'DL - 1', 1, '2025-04-01 20:22:01', 4, 11, 17, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 410652, 1000042, 2555, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 500000, 2620, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67ef9615c261ae5c5a156f7f', '', 's1', 'DL - 1', 1, '2025-04-04 16:19:44', 1, 10, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67f0e396c261ae5c5a157142', '', 's1', 'DL - 1', 1, '2025-04-05 16:02:57', 1, 10, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67f147ecc261ae5c5a15724b', '', 's1', 'DL - 1', 1, '2025-04-05 23:11:01', 1, 10, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67f3b1e8c261ae5c5a1574cb', 'Vong8', 's1', 'DL - 1', 1, '2025-04-07 19:13:27', 4, 11, 509, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, 63038825, 976456, 13252803, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 400, 500000, 4116, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');
INSERT INTO `role_key_res_num` VALUES ('67f4a8b9c261ae5c5a15772b', '', 's1', 'DL - 1', 1, '2025-04-08 12:40:41', 1, 10, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '10091');

-- ----------------------------
-- Table structure for role_record
-- ----------------------------
DROP TABLE IF EXISTS `role_record`;
CREATE TABLE `role_record`  (
  `role_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色唯一ID',
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器编码',
  `srv_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器名',
  `srv_index` int(11) NULL DEFAULT NULL COMMENT '服务器序号',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '数据更新时间',
  `level` int(11) NULL DEFAULT NULL COMMENT '角色等级',
  `vip_level` int(11) NULL DEFAULT NULL COMMENT 'VIP等级',
  `vip_points` bigint(20) NULL DEFAULT NULL COMMENT 'VIP积分',
  `power` bigint(20) NULL DEFAULT NULL COMMENT '战力',
  `pay_num` double NULL DEFAULT NULL COMMENT '累计充值数额',
  `pay_times` int(11) NULL DEFAULT NULL COMMENT '支付次数',
  `last_login_time` timestamp NULL DEFAULT NULL COMMENT '最近登录时间',
  `platform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `account_uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账户唯一ID',
  `open_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '平台openID',
  `open_id_raw` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原始平台openID',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `game_id_raw` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原始GameID',
  `channel_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道编码',
  `m0` bigint(20) NULL DEFAULT NULL COMMENT '数值资源0',
  `m1` bigint(20) NULL DEFAULT NULL COMMENT '数值资源1',
  `m2` bigint(20) NULL DEFAULT NULL COMMENT '数值资源2',
  `m3` bigint(20) NULL DEFAULT NULL COMMENT '数值资源3',
  `m4` bigint(20) NULL DEFAULT NULL COMMENT '数值资源4',
  `guild_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公会ID',
  `guild_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公会名称',
  `guild_level` int(11) NULL DEFAULT NULL COMMENT '公会等级',
  `guild_member_num` int(11) NULL DEFAULT NULL COMMENT '公会成员数量',
  `friend_num` int(11) NULL DEFAULT NULL COMMENT '好友数量',
  `mail_num` int(11) NULL DEFAULT NULL COMMENT '邮件数量',
  `assess_value` bigint(20) NULL DEFAULT NULL COMMENT '角色估值',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开发调试用的备注',
  `ext_str_a` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展varchar值A',
  `ext_str_b` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展varchar值B',
  `ext_str_c` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展varchar值C',
  `ext_text_a` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '扩展text值A',
  `ext_int_a` int(11) NULL DEFAULT NULL COMMENT '扩展int值A',
  `ext_long_a` bigint(20) NULL DEFAULT NULL COMMENT '扩展long值A',
  `ext_double_a` double NULL DEFAULT NULL COMMENT '扩展double值B',
  `role_create_time` datetime NULL DEFAULT NULL COMMENT '角色创建时间',
  `account_create_time` datetime NULL DEFAULT NULL COMMENT '账户创建时间',
  `hero_top_level` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英雄等级top信息',
  `hero_top_power` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英雄战力top信息',
  `beast_level_max` int(11) NULL DEFAULT NULL COMMENT '最高兽灵等级',
  `artifact_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法宝类型',
  `artifact_level` int(11) NULL DEFAULT NULL COMMENT '法宝等级',
  `adventure_combat_id` int(11) NULL DEFAULT NULL COMMENT '通过的冒险关卡ID',
  PRIMARY KEY (`role_id`) USING BTREE,
  INDEX `role_record_role_name_IDX`(`role_name`) USING BTREE,
  INDEX `role_record_account_uid_IDX`(`account_uid`) USING BTREE,
  INDEX `role_record_open_id_IDX`(`open_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色档案' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_record
-- ----------------------------
INSERT INTO `role_record` VALUES ('67e7dd11ba7f185f7d8029c5', 'Nhac0', 's1', 'DL - 1', 1, '2025-03-30 00:19:31', 2, 14, 500000, 1298, 0, 0, '2025-03-30 00:19:31', 'develop', 'abe224c9-4cf4-415f-acd8-75a74e3cae4a', 'test11@develop', 'test11@develop', '10091', '10091', NULL, 300000, 995004, 0, 0, 0, NULL, NULL, 0, 0, 0, 12, 201837, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-29 19:44:26', '2025-03-11 05:50:57', 'Tien-Super(1级, 4星, 1298战力) ', 'Tien-Super(1级, 4星, 1298战力) ', 0, NULL, 0, 1);
INSERT INTO `role_record` VALUES ('67e7dfecc9a3d57a8519855d', 'Lieu8', 's1', 'DL - 1', 1, '2025-03-30 00:27:40', 2, 18, 10500000, 1298, 0, 0, '2025-03-30 00:27:40', 'develop', '6e9ab3d4-f808-4b1c-93da-f37c7890e197', 'test12@develop', 'test12@develop', '10091', '10091', NULL, 200000, 1000001, 0, 0, 0, NULL, NULL, 0, 0, 0, 22, 202000, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-29 19:56:34', '2025-03-22 19:56:25', 'Tien-Super(1级, 4星, 1298战力) ', 'Tien-Super(1级, 4星, 1298战力) ', 0, NULL, 0, 1);
INSERT INTO `role_record` VALUES ('67e7e99090073674998a8b66', 'By6', 's1', 'DL - 1', 1, '2025-04-05 22:05:16', 3, 14, 500000, 1298, 0, 0, '2025-04-05 22:05:16', 'develop', '15913be0-0ea5-40d2-81cb-71926ce75eed', 'lak000@develop', 'lak000@develop', '10091', '10091', NULL, 208300, 1000010, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 204003, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-29 20:37:41', '2025-03-27 08:37:32', 'Sakuke(1级, 4星, 1298战力) ', 'Sakuke(1级, 4星, 1298战力) ', 0, NULL, 0, 3);
INSERT INTO `role_record` VALUES ('67e7ee8b90073674998a8bb2', 'Tram2', 's1', 'DL - 1', 1, '2025-04-01 18:52:49', 2, 14, 500000, 1298, 0, 0, '2025-04-01 18:52:49', 'develop', 'dfe7477a-18e6-4c3d-8b06-4a14edf17461', 'shuichi@develop', 'shuichi@develop', '10091', '10091', NULL, 200000, 1000005, 0, 0, 0, NULL, NULL, 0, 0, 0, 1, 202001, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-29 20:58:56', '2025-03-28 20:58:47', 'Sakuke(1级, 4星, 1298战力) ', 'Sakuke(1级, 4星, 1298战力) ', 0, NULL, 0, 1);
INSERT INTO `role_record` VALUES ('67e8068590073674998a8c15', 'Thuy3', 's1', 'DL - 1', 1, '2025-04-05 18:24:20', 57, 10, 4000, 2898, 0, 0, '2025-04-05 18:24:20', 'develop', '466d444d-816b-49e9-a7c4-b0dd70c606cf', 'hoanghung@develop', 'hoanghung@develop', '10091', '10091', NULL, 13223910, 52676, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 114853, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-29 22:41:20', '2025-03-27 22:38:11', 'Sakuke(1级, 4星, 1298战力) Gintoma(1级, 4星, 1322战力) Venonat(1级, 4星, 1322战力) Aegislash(1级, 3星, 1120战力) Kuchiki Byakuya(1级, 5星, 1600战力) ', 'Kuchiki Byakuya(1级, 5星, 1600战力) Gintoma(1级, 4星, 1322战力) Venonat(1级, 4星, 1322战力) Sakuke(1级, 4星, 1298战力) Graveler(1级, 3星, 1183战力) ', 0, NULL, 0, 8);
INSERT INTO `role_record` VALUES ('67e807d790073674998a8c45', 'Dung2', 's1', 'DL - 1', 1, '2025-04-01 18:38:15', 2, 10, 0, 1298, 0, 0, '2025-04-01 18:38:15', 'develop', 'ec65135d-2733-49d3-8ba4-ac6d5984215a', 'phucok@develop', 'phucok@develop', '10091', '10091', NULL, 200000, 5, 0, 0, 0, NULL, NULL, 0, 0, 0, 10, 2001, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-29 22:46:54', '2025-03-28 22:46:25', 'Sakuke(1级, 4星, 1298战力) ', 'Sakuke(1级, 4星, 1298战力) ', 0, NULL, 0, 1);
INSERT INTO `role_record` VALUES ('67e81f41682ed105c6bee271', 'DLGAME', 's1', 'DL - 1', 1, '2025-04-04 12:28:01', 200, 14, 501000, 144512, 0, 0, '2025-04-04 12:28:01', 'develop', '657e8cf5-0346-42a8-9728-c5a8a91206d2', 'test13@develop', 'test13@develop', '10091', '10091', NULL, 9995270883, 1200517, 0, 0, 0, NULL, NULL, 0, 0, 0, 1, 2369292, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-30 00:26:49', '2025-01-21 22:26:32', 'Inoue Orihime(95级, 5星, 30820战力) Tanjiro(80级, 5星, 25985战力) Lambada(80级, 5星, 24092战力) Sasuke Indra(80级, 5星, 24756战力) Yamamoto(75级, 5星, 21748战力) ', 'Meliodas(60级, 5星, 57637战力) Akkli(60级, 5星, 56887战力) Fusion Zamasu(60级, 5星, 56055战力) Orichi(60级, 5星, 55934战力) Gogeta SSJ Blue(60级, 5星, 46823战力) ', 1, NULL, 0, 34);
INSERT INTO `role_record` VALUES ('67e8e17cc261ae5c5a156391', 'Thuy1', 's1', 'DL - 1', 1, '2025-04-05 20:17:32', 9, 10, 0, 24920, 0, 0, '2025-04-05 20:17:32', 'develop', 'cd4966cc-fafb-4808-86e9-b34ccda84b88', 'khanhlam@develop', 'khanhlam@develop', '10091', '10091', NULL, 8150357, 24066, 0, 0, 0, NULL, NULL, 0, 0, 0, 11, 20622, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-30 14:15:40', NULL, 'Urahara Kisuke(58级, 5星, 11416战力) Kyo Kusanagi(29级, 5星, 5516战力) Kuchiki Byakuya(17级, 5星, 3842战力) Kuchiki Rukia(8级, 5星, 2616战力) Sakuke(3级, 4星, 1530战力) ', 'Urahara Kisuke(58级, 5星, 11416战力) Kyo Kusanagi(29级, 5星, 5516战力) Kuchiki Byakuya(17级, 5星, 3842战力) Kuchiki Rukia(8级, 5星, 2616战力) Sakuke(3级, 4星, 1530战力) ', 0, NULL, 0, 7);
INSERT INTO `role_record` VALUES ('67ebc24ec261ae5c5a1568a2', 'Khanh0', 's1', 'DL - 1', 1, '2025-04-01 18:45:36', 3, 11, 600000, 2620, 0, 0, '2025-04-01 18:45:36', 'develop', '5cf5d7cf-9ddb-4457-9229-e267976bf76c', 'phucbaby@develop', 'phucbaby@develop', '10091', '10091', NULL, 69604100, 1082537, 0, 0, 0, NULL, NULL, 0, 0, 0, 11, 116644, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-01 18:39:26', '2025-04-01 06:38:58', 'Sakuke(1级, 4星, 1298战力) Gintoma(1级, 4星, 1322战力) Luffy(1级, 5星, 1668战力) Luffy(1级, 5星, 1668战力) Luffy(1级, 5星, 1668战力) ', 'Luffy(1级, 5星, 1668战力) Luffy(1级, 5星, 1668战力) Luffy(1级, 5星, 1668战力) Luffy(1级, 5星, 1668战力) Luffy(1级, 5星, 1668战力) ', 0, NULL, 0, 2);
INSERT INTO `role_record` VALUES ('67ebd85fc261ae5c5a156971', 'Mai7', 's1', 'DL - 1', 1, '2025-04-05 20:17:32', 9, 11, 500000, 2620, 0, 0, '2025-04-05 20:17:32', 'develop', '9b8a69d0-f123-4c0c-97d0-d1d2aeec2d0e', 'alex123@develop', 'alex123@develop', '10091', '10091', NULL, 484878, 1000074, 0, 0, 0, NULL, NULL, 0, 0, 0, 12, 216253, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-01 20:13:33', NULL, 'Sakuke(1级, 4星, 1298战力) Gintoma(1级, 4星, 1322战力) ', 'Gintoma(1级, 4星, 1322战力) Sakuke(1级, 4星, 1298战力) ', 0, NULL, 0, 8);
INSERT INTO `role_record` VALUES ('67ef9615c261ae5c5a156f7f', 'Ly7', 's1', 'DL - 1', 1, '2025-04-04 16:24:28', 4, 11, 500000, 2620, 0, 0, '2025-04-04 16:24:28', 'develop', '6b56c0d1-83e0-4426-9254-5601702b4aab', 'thmodz@develop', 'thmodz@develop', '10091', '10091', NULL, 3508940, 1008841, 0, 0, 0, NULL, NULL, 0, 0, 0, 11, 205751, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-04 16:19:45', '2025-04-04 04:19:29', 'Sakuke(1级, 4星, 1298战力) Gintoma(1级, 4星, 1322战力) ', 'Gintoma(1级, 4星, 1322战力) Sakuke(1级, 4星, 1298战力) ', 0, NULL, 0, 3);
INSERT INTO `role_record` VALUES ('67f0e396c261ae5c5a157142', 'Huc6', 's1', 'DL - 1', 1, '2025-04-05 16:04:43', 2, 11, 500000, 1298, 0, 0, '2025-04-05 16:04:43', 'develop', '6edbdec7-c8a7-4111-a2fa-6c668b9b0025', 'hihihi@develop', 'hihihi@develop', '10091', '10091', NULL, 200000, 1000003, 0, 0, 0, NULL, NULL, 0, 0, 0, 11, 202002, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-05 16:02:40', '2025-04-05 04:02:25', 'Sakuke(1级, 4星, 1298战力) Gintoma(1级, 4星, 1322战力) ', 'Gintoma(1级, 4星, 1322战力) Sakuke(1级, 4星, 1298战力) ', 0, NULL, 0, 1);
INSERT INTO `role_record` VALUES ('67f147ecc261ae5c5a15724b', 'Du0', 's1', 'DL - 1', 1, '2025-04-05 23:12:52', 2, 10, 0, 1298, 0, 0, '2025-04-05 23:12:52', 'develop', '7bdfd8ce-906c-4ebf-8117-286b2b4fb7a6', 'oiconga123@develop', 'oiconga123@develop', '10091', '10091', NULL, 200000, 2, 0, 0, 0, NULL, NULL, 0, 0, 0, 10, 2000, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-05 23:11:05', '2025-04-05 11:10:26', 'Sakuke(1级, 4星, 1298战力) ', 'Sakuke(1级, 4星, 1298战力) ', 0, NULL, 0, 1);
INSERT INTO `role_record` VALUES ('67f3b1e8c261ae5c5a1574cb', 'Vong8', 's1', 'DL - 1', 1, '2025-04-07 19:22:54', 11, 11, 500000, 96637, 0, 0, '2025-04-07 19:22:54', 'develop', '5d30f992-4e96-4315-bcd5-f35c0b9916a9', 'toan95@develop', 'toan95@develop', '10091', '10091', NULL, 52143085, 8948, 0, 0, 0, NULL, NULL, 0, 0, 0, 11, 41216, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-07 19:07:30', '2025-04-06 19:07:15', 'Luffy(145级, 6星, 39634战力) Syaoran(100级, 5星, 20526战力) Sakuke(80级, 4星, 13508战力) Gintoma(80级, 4星, 21298战力) Clauncher(1级, 2星, 983战力) ', 'Luffy(145级, 6星, 39634战力) Gintoma(80级, 4星, 21298战力) Syaoran(100级, 5星, 20526战力) Sakuke(80级, 4星, 13508战力) Lucy(1级, 5星, 1671战力) ', 0, NULL, 0, 11);
INSERT INTO `role_record` VALUES ('67f4a8b9c261ae5c5a15772b', 'Bua9', 's1', 'DL - 1', 1, '2025-04-08 12:42:57', 1, 10, 0, 1298, 0, 0, '2025-04-08 12:42:57', 'develop', '600eabab-692c-408d-92e4-606feca2e5c7', '234234@develop', '234234@develop', '10091', '10091', NULL, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 10, 0, '为龙图增加扩展', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-08 12:40:33', '2025-03-24 09:15:42', 'Sakuke(1级, 4星, 1298战力) ', 'Sakuke(1级, 4星, 1298战力) ', 0, NULL, 0, 0);

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
  `group_id` int(11) NULL DEFAULT NULL COMMENT '服务器组ID',
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
  INDEX `idx_code`(`code`) USING BTREE,
  INDEX `idx_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '游戏服务器信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of srv_game
-- ----------------------------
INSERT INTO `srv_game` VALUES (1, 's1', 1, 'Meow 3Q', 2, 'cross-yzx1', 1, 'Meow 3Q', '2024-04-07 00:00:05', 'develop', 1, 'release', 'd1', 'mongo-yzxdb1', 'mysql-yzxdb1', 'ws', 8001, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO `srv_game` VALUES (2, 's2', 2, 'DL - 2', 2, 'cross-yzx1', 1, 'DLStudio', '2024-04-07 00:00:05', 'disabled', 1, 'release', 'd1', 'mongo-yzxdb2', 'mysql-yzxdb2', 'ws', 8002, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO `srv_game` VALUES (3, 's3', 3, 'DL - 3', 2, 'cross-yzx1', 1, 'DLStudio', '2024-04-07 00:00:05', 'disabled', 1, 'release', 'd1', 'mongo-yzxdb3', 'mysql-yzxdb3', 'ws', 8003, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO `srv_game` VALUES (4, 's4', 4, 'DL - 4', 2, 'cross-yzx1', 1, 'DLStudio', '2024-04-07 00:00:05', 'disabled', 1, 'release', 'd1', 'mongo-yzxdb4', 'mysql-yzxdb4', 'ws', 8004, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO `srv_game` VALUES (5, 's5', 5, 'DL - 5', 2, 'cross-yzx1', 1, 'DLStudio', '2024-04-07 00:00:05', 'disabled', 1, 'release', 'd1', 'mongo-yzxdb5', 'mysql-yzxdb5', 'ws', 8005, '-Xms128m -Xmx2048m', 'admin', '2022-04-03 13:02:37', NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for summary_daily
-- ----------------------------
DROP TABLE IF EXISTS `summary_daily`;
CREATE TABLE `summary_daily`  (
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一ID',
  `srv_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏服编码',
  `srv_index` int(11) NULL DEFAULT NULL COMMENT '游戏服序号',
  `srv_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '游戏服名',
  `game_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'GameID',
  `app_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用名称',
  `date` date NOT NULL COMMENT '日期',
  `pay_num` double NULL DEFAULT NULL COMMENT '充值数额',
  `pay_times` int(11) NULL DEFAULT NULL COMMENT '充值次数',
  `new_role_num` int(11) NULL DEFAULT NULL COMMENT '当日新增创角',
  `new_account_num` int(11) NULL DEFAULT NULL COMMENT '当日新导入账号',
  `new_device_num` int(11) NULL DEFAULT NULL COMMENT '当日新导入设备',
  `new_ip_num` int(11) NULL DEFAULT NULL COMMENT '当日新导入IP',
  `login_role_num` int(11) NULL DEFAULT NULL COMMENT '今日登陆角色数',
  `login_account_num` int(11) NULL DEFAULT NULL COMMENT '今日登陆账号数',
  `login_device_num` int(11) NULL DEFAULT NULL COMMENT '今日登陆设备数',
  `login_ip_num` int(11) NULL DEFAULT NULL COMMENT '今日登陆IP数',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '数据更新时间',
  `group_id` int(11) NULL DEFAULT NULL COMMENT '所属服务器组ID',
  `pay_role_num` int(11) NULL DEFAULT NULL COMMENT '支付角色数',
  `pay_account_num` int(11) NULL DEFAULT NULL COMMENT '支付账户数',
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `summary_daily_srv_code_IDX`(`srv_code`) USING BTREE,
  INDEX `summary_daily_game_id_IDX`(`game_id`) USING BTREE,
  INDEX `summary_daily_date_IDX`(`date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '每日汇总' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of summary_daily
-- ----------------------------

-- ----------------------------
-- Table structure for tpl_hero_base
-- ----------------------------
DROP TABLE IF EXISTS `tpl_hero_base`;
CREATE TABLE `tpl_hero_base`  (
  `tid` int(11) NULL DEFAULT NULL COMMENT '模板ID',
  `pid` int(11) NULL DEFAULT NULL COMMENT '原型ID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名字',
  `star` int(11) NULL DEFAULT NULL COMMENT '星级'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tpl_hero_base
-- ----------------------------

-- ----------------------------
-- Table structure for work
-- ----------------------------
DROP TABLE IF EXISTS `work`;
CREATE TABLE `work`  (
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作类型',
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作ID',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '工作状态',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `finish_time` timestamp NULL DEFAULT NULL COMMENT '完成时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '统计工作表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of work
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
