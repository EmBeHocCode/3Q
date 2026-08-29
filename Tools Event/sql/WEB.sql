/*
 Navicat Premium Data Transfer

 Source Server         : H5
 Source Server Type    : MySQL
 Source Server Version : 50744
 Source Host           : localhost:3306
 Source Schema         : WEB

 Target Server Type    : MySQL
 Target Server Version : 50744
 File Encoding         : 65001

 Date: 08/04/2025 11:52:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ny_ads
-- ----------------------------
DROP TABLE IF EXISTS `ny_ads`;
CREATE TABLE `ny_ads`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_ads
-- ----------------------------

-- ----------------------------
-- Table structure for ny_auth
-- ----------------------------
DROP TABLE IF EXISTS `ny_auth`;
CREATE TABLE `ny_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `block` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0: Unblock, 1: Block',
  `type` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0: Member, 1: Smod, 2: Admin',
  `token` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `referral_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `referraler` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bank_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bank_person` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bank_stk` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reg_from` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1253 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_auth
-- ----------------------------
INSERT INTO `ny_auth` VALUES (1, 'admin', '21232f297a57a5a743894a0e4a801fc3', '', 0, 2, 'b57ca0a1c9d0e4e9275df1fe477544ee', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1233, 'test11', '4297f44b13955235245b2497399d7a93', '0987584621', 0, 0, '37c9414dfd25c6f4d818112d82aaa1f3', 'R-TEST11', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1234, '234234', 'b51e8dbebd4ba8a8f342190a4b9f08d7', '2342342349', 0, 0, '5baf65bb5ac59127594d134b2a37bc30', 'R-234234', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1235, 'test111', '4297f44b13955235245b2497399d7a93', '0987468435', 0, 0, '2d9e34cd6c05883786a0694f88e9af54', 'R-TEST111', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1236, 'test12', '4297f44b13955235245b2497399d7a93', '0985486548', 0, 0, '13e9155141d3f9848975a219b11710cf', 'R-TEST12', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1237, '123123', '4297f44b13955235245b2497399d7a93', '0974987886', 0, 0, 'edb93085189977315012b21a545a4b59', 'R-123123', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1238, 'lak000', '670b14728ad9902aecba32e22fa4f6bd', '0966222333', 0, 0, '84a5266326f6c4de8da821946b7e4173', 'R-LAK000', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1239, 'tungpuskin', 'a46571f77f2c3d13238b805a285c6ef3', '0989312551', 0, 0, '41cf1d5d4cc264f71d05e7a41591e926', 'R-TUNGPUSKIN', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1240, 'shuichi', '4297f44b13955235245b2497399d7a93', '1231313234', 0, 0, 'e31b2d98e50a0edd107659b011e76855', 'R-SHUICHI', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1241, 'hoanghung', '4cddd6a1139f037f6f7dfc34a20e05e0', '0987789987', 0, 0, '3212a1e542bded2bd932dfb376dfa1f2', 'R-HOANGHUNG', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1242, 'phucok', '37b697fbab3a583e499104b0450641de', '0977666521', 0, 0, 'd6ce0336b086facb7930d2726c82d011', 'R-PHUCOK', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1243, 'test13', '4297f44b13955235245b2497399d7a93', '0985486485', 0, 0, '89bc891b79d92e1ac41dc3f4111ade37', 'R-TEST13', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1244, 'toan300', '25d55ad283aa400af464c76d713c07ad', '0942047648', 0, 0, '0e7f387258ac51fe3aa0a0ff1671f4c3', 'R-TOAN300', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1245, 'khanhlam', '28fc76b3b7c257c91673c3c56b6d49c2', '0855914446', 0, 0, 'a50f881c03b1fada2a3e671d56353e41', 'R-KHANHLAM', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1246, 'phucbaby', '4297f44b13955235245b2497399d7a93', '0987654321', 0, 0, '7f97aa1506d7369510a1fbe17c3d267d', 'R-PHUCBABY', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1247, 'alex123', '4297f44b13955235245b2497399d7a93', '0933443344', 0, 0, '84181172104a99c4ad1bd93e202e30c1', 'R-ALEX123', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1248, 'thmodz', 'dd6ecf42c670c4299654e0916125057b', '0345543130', 0, 0, '7cf64604be3459d960a351e00ae25090', 'R-THMODZ', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1249, 'hihihi', '4297f44b13955235245b2497399d7a93', '0978787881', 0, 0, 'b822cfe035d1eafce2b87501b7b50a61', 'R-HIHIHI', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1250, '12345678h', '25d55ad283aa400af464c76d713c07ad', '0586599669', 0, 0, 'da4fcdf7a1824ea8fc9f87f6427e4fc2', 'R-12345678H', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1251, 'oiconga123', 'e10adc3949ba59abbe56e057f20f883e', '0374112335', 0, 0, '96e906c2e58b74cad88a91502a3dfe30', 'R-OICONGA123', NULL, NULL, NULL, NULL, 0);
INSERT INTO `ny_auth` VALUES (1252, 'toan95', '25d55ad283aa400af464c76d713c07ad', '0941039172', 0, 0, '890037f2b396d3a9fcdb4ec2225558cd', 'R-TOAN95', NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for ny_config
-- ----------------------------
DROP TABLE IF EXISTS `ny_config`;
CREATE TABLE `ny_config`  (
  `game_name` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `game_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `game_icon_path` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `game_banner` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `game_logo` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `web_link` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `referral_link` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fanpage_link` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `group_link` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `messenger_link` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zalo_link` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `telegram_link` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone_support` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email_support` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `api_key_card` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url_callback_card` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/api/payment/card/callback.php',
  `api_key_momo` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url_callback_momo` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/api/payment/momo/callback.php',
  `api_key_banking` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url_callback_banking` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/api/payment/banking/callback.php',
  `prefix_pay` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `prefix_withdraw` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `prefix_referral` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_config
-- ----------------------------
INSERT INTO `ny_config` VALUES ('3Q Chiến Ma - AFK', NULL, '/client/images/icon', 'https://i.imgur.com/19nJVPh.png', NULL, 'http://chienma3q.mobi/client/home', NULL, 'https://www.facebook.com/gaming/phongthanafkk', 'https://www.facebook.com/groups/phongthanlucgioi', NULL, 'https://zalo.me/g/wyzjxk204', NULL, NULL, NULL, '28cb9d07-47ad-4df5-a01b-6a411a01bd8d', '/api/payment/card/callback.php', NULL, '/api/payment/momo/callback.php', NULL, '/api/payment/banking/callback.php', '', '', NULL);

-- ----------------------------
-- Table structure for ny_event
-- ----------------------------
DROP TABLE IF EXISTS `ny_event`;
CREATE TABLE `ny_event`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `milestone_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `comparison` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `prefix` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `suffix` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `expires_time` int(11) UNSIGNED NULL DEFAULT 0,
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_event
-- ----------------------------
INSERT INTO `ny_event` VALUES (1, 'Đăng nhập ngày', '', 'login_day', NULL, 'number', '>=', '1', '7', 1692464400, 1, 1691986276);
INSERT INTO `ny_event` VALUES (2, 'Tích Nạp Ngày', '', 'pay_day', NULL, 'money', '>=', 'Nạp', 'VNĐ', 1692464400, 1, 1691986269);
INSERT INTO `ny_event` VALUES (3, 'Tích nạp tháng', '', 'pay_month', NULL, 'money', '>=', 'Nạp', 'VNĐ', 1690703700, 0, 1690731671);
INSERT INTO `ny_event` VALUES (4, 'Tích Nạp Tổng', '', 'pay_all', NULL, 'number', '>', 'Nạp', 'VNĐ', 1703869200, 0, 1690727782);
INSERT INTO `ny_event` VALUES (5, 'Tiêu phí ngày', '', 'spend_day', NULL, 'money', '>=', 'Tiêu', 'Xu', 1692464400, 1, 1691986282);
INSERT INTO `ny_event` VALUES (6, 'Tiêu phí tháng', '', 'spend_month', NULL, 'money', '>=', 'Tiêu', 'Xu', 1703869200, 0, 1690727696);
INSERT INTO `ny_event` VALUES (7, 'Tiêu phí', '', 'spend_all', NULL, 'money', '>=', 'Tiêu', 'Xu', 1703869200, 0, 1690731677);

-- ----------------------------
-- Table structure for ny_event_milestone
-- ----------------------------
DROP TABLE IF EXISTS `ny_event_milestone`;
CREATE TABLE `ny_event_milestone`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `need` double(50, 0) UNSIGNED NOT NULL,
  `gifts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_event_milestone
-- ----------------------------
INSERT INTO `ny_event_milestone` VALUES (1, 1, 1, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"50000\",\"icon\":\"1\"}]');
INSERT INTO `ny_event_milestone` VALUES (2, 4, 100000, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"11111\",\"icon\":null},{\"id\":\"3:99999\",\"name\":\"Đan EXP\",\"amount\":\"11\",\"icon\":null}]');
INSERT INTO `ny_event_milestone` VALUES (3, 4, 200000, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"11111\",\"icon\":null},{\"id\":\"3:999999\",\"name\":\"Đá Cường Hóa\",\"amount\":\"111\",\"icon\":null}]');
INSERT INTO `ny_event_milestone` VALUES (4, 2, 100000, '[{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"2000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"2000000\",\"icon\":\"3\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"50\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"50\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Thú Bông\",\"amount\":\"100\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"2\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rương tự chọn trang bị 3*\",\"amount\":\"3\",\"icon\":\"81\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"10000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"10000\",\"icon\":\"86\"}]');
INSERT INTO `ny_event_milestone` VALUES (5, 5, 100000, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"50000\",\"icon\":\"1\"}]');
INSERT INTO `ny_event_milestone` VALUES (6, 3, 100000, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"11111\",\"icon\":null}]');
INSERT INTO `ny_event_milestone` VALUES (7, 5, 200000, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"50000\",\"icon\":\"1\"},{\"id\":\"0:00\",\"name\":\"Xu\",\"amount\":\"1000000\",\"icon\":\"2\"}]');
INSERT INTO `ny_event_milestone` VALUES (8, 6, 100000, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"50000\",\"icon\":\"3\"}]');
INSERT INTO `ny_event_milestone` VALUES (9, 7, 100000, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"10000\",\"icon\":\"3\"},{\"id\":\"0:04\",\"name\":\"EXP Chiến Binh\",\"amount\":\"100000\",\"icon\":\"3\"},{\"id\":\"0:03\",\"name\":\"EXP Bản Thân\",\"amount\":\"1000000\",\"icon\":null}]');
INSERT INTO `ny_event_milestone` VALUES (10, 7, 2000000, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"10000\",\"icon\":\"3\"}]');
INSERT INTO `ny_event_milestone` VALUES (11, 2, 200000, '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"50\",\"icon\":\"9\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"4000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"4000000\",\"icon\":\"3\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"100\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"100\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Thú Bông\",\"amount\":\"200\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"5\",\"icon\":\"5\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"15000\",\"icon\":\"86\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"15000\",\"icon\":\"87\"}]');
INSERT INTO `ny_event_milestone` VALUES (12, 2, 500000, '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"120\",\"icon\":\"9\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"6000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"6000000\",\"icon\":\"3\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"200\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"200\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Thú Bông\",\"amount\":\"500\",\"icon\":\"8\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"15000\",\"icon\":\"4\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm Thăng Giai T3\",\"amount\":\"5\",\"icon\":\"82\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"8\",\"icon\":\"5\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"10\",\"icon\":\"88\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"1\",\"icon\":\"85\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"25000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"25000\",\"icon\":\"86\"}]');
INSERT INTO `ny_event_milestone` VALUES (13, 2, 1000000, '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"250\",\"icon\":\"9\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"9000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"9000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"25000\",\"icon\":\"4\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm Thăng Giai T3\",\"amount\":\"10\",\"icon\":\"82\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"400\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"500\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"750\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"10\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rương Tự Chọn Trang Bị 3*\",\"amount\":\"15\",\"icon\":\"81\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"1\",\"icon\":\"85\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"50\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"50000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"50000\",\"icon\":\"86\"}]');
INSERT INTO `ny_event_milestone` VALUES (14, 2, 2000000, '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"450\",\"icon\":\"9\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"15000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"15000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"45000\",\"icon\":\"4\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"600\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"1000\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"1500\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"15\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rương Tự Chọn Trang Bị 3*\",\"amount\":\"25\",\"icon\":\"81\"},{\"id\":\"3:500094\",\"name\":\"Nghề Nghiệp Tiên Khí Hộp Quà\",\"amount\":\"2\",\"icon\":\"89\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"2\",\"icon\":\"85\"},{\"id\":\"3:401001\",\"name\":\"Thần Trang Tự Chọn\",\"amount\":\"2\",\"icon\":\"90\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Tự Chọn\",\"amount\":\"100\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"80000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"80000\",\"icon\":\"86\"}]');
INSERT INTO `ny_event_milestone` VALUES (15, 2, 3000000, '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"650\",\"icon\":\"9\"},{\"id\":\"3:100146\",\"name\":\"Quán Ma Chi Bình Hỗn Độn\",\"amount\":\"200\",\"icon\":\"10\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"25000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"25000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"65000\",\"icon\":\"4\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"800\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"1200\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"1800\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"25\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rương Tự Chọn Trang Bị 3*\",\"amount\":\"45\",\"icon\":\"81\"},{\"id\":\"3:500094\",\"name\":\"Nghề Nghiệp Tiên Khí\",\"amount\":\"3\",\"icon\":\"89\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"2\",\"icon\":\"85\"},{\"id\":\"3:401001\",\"name\":\"Thần Trang Tự Chọn\",\"amount\":\"2\",\"icon\":\"90\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"150\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"110000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"110000\",\"icon\":\"86\"}]');
INSERT INTO `ny_event_milestone` VALUES (16, 2, 4000000, '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"850\",\"icon\":\"9\"},{\"id\":\"3:100146\",\"name\":\"Quán Ma Chi Bình Hỗn Độn\",\"amount\":\"300\",\"icon\":\"10\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"35000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"35000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"85000\",\"icon\":\"4\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"1000\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"1500\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"2250\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"40\",\"icon\":\"5\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm Tăng Giai\",\"amount\":\"35\",\"icon\":\"82\"},{\"id\":\"3:500094\",\"name\":\"Nghề Nghiệp Tiên Khí\",\"amount\":\"4\",\"icon\":\"89\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"3\",\"icon\":\"85\"},{\"id\":\"3:401001\",\"name\":\"Thần Trang Tự Chọn\",\"amount\":\"2\",\"icon\":\"90\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"150\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"150000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"150000\",\"icon\":\"86\"}]');
INSERT INTO `ny_event_milestone` VALUES (17, 2, 5000000, '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"1050\",\"icon\":\"9\"},{\"id\":\"3:100146\",\"name\":\"Quán Ma Chi Bình Hỗn Độn\",\"amount\":\"400\",\"icon\":\"10\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"50000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"50000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"100000\",\"icon\":\"4\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"1500\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"2000\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"2750\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"55\",\"icon\":\"5\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm Tăng Giai\",\"amount\":\"50\",\"icon\":\"82\"},{\"id\":\"3:500094\",\"name\":\"Nghề Nghiệp Tiên Khí\",\"amount\":\"5\",\"icon\":\"89\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"4\",\"icon\":\"85\"},{\"id\":\"3:401001\",\"name\":\"Thần Trang Tự Chọn\",\"amount\":\"3\",\"icon\":\"90\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"150\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"200000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"200000\",\"icon\":\"86\"}]');
INSERT INTO `ny_event_milestone` VALUES (18, 1, 2, '[{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"1000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"1000000\",\"icon\":\"3\"}]');
INSERT INTO `ny_event_milestone` VALUES (19, 1, 3, '[{\"id\":\"0:01\",\"name\":\"KNB\",\"amount\":\"100000\",\"icon\":null},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"5000\",\"icon\":\"4\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"100\",\"icon\":\"7\"}]');
INSERT INTO `ny_event_milestone` VALUES (20, 1, 4, '[{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"100\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"1\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rương Tự Chọn Trang Bị 3*\",\"amount\":\"3\",\"icon\":\"81\"}]');
INSERT INTO `ny_event_milestone` VALUES (21, 1, 5, '[{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên \",\"amount\":\"2\",\"icon\":\"81\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"2000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"2000\",\"icon\":\"86\"},{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"10\",\"icon\":\"9\"}]');
INSERT INTO `ny_event_milestone` VALUES (22, 1, 7, '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"10\",\"icon\":\"9\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"2000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"2000000\",\"icon\":\"3\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"100\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"100\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"100\",\"icon\":\"8\"}]');
INSERT INTO `ny_event_milestone` VALUES (23, 1, 6, '[{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"2000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"2000000\",\"icon\":\"3\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"100\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"100\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"100\",\"icon\":\"8\"}]');

-- ----------------------------
-- Table structure for ny_gate
-- ----------------------------
DROP TABLE IF EXISTS `ny_gate`;
CREATE TABLE `ny_gate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(10) UNSIGNED NOT NULL COMMENT '1: Banking, 2: Card, 3: Momo',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `person` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `stk` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qr_link` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bonus_default` int(11) NOT NULL DEFAULT 0,
  `bonus` int(11) NOT NULL DEFAULT 0,
  `expires_bonus` int(11) UNSIGNED NULL DEFAULT 0,
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_gate
-- ----------------------------
INSERT INTO `ny_gate` VALUES (1, 1, 'Vietcombank', 'Nguyễn Văn A', '01325135135', '', 'https://img.vietqr.io/image/VCB-0451000397594-print.png', 0, 200, 0, 1, 1690656479);
INSERT INTO `ny_gate` VALUES (2, 2, 'Card', 'System', 'System', '', '', 0, 160, 1703869200, 1, 1691465503);
INSERT INTO `ny_gate` VALUES (3, 3, 'Momo', 'Nguyễn Văn A', '037888888', '', 'https://momosv3.apimienphi.com/api/QRCode', 0, 200, 0, 1, 1690656475);

-- ----------------------------
-- Table structure for ny_gift
-- ----------------------------
DROP TABLE IF EXISTS `ny_gift`;
CREATE TABLE `ny_gift`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `list` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_gift
-- ----------------------------
INSERT INTO `ny_gift` VALUES (1, 'Nạp 500k', '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"120\",\"icon\":\"9\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"6000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"6000000\",\"icon\":\"3\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"200\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"200\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Thú Bông\",\"amount\":\"500\",\"icon\":\"8\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"15000\",\"icon\":\"4\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm Thăng Giai T3\",\"amount\":\"5\",\"icon\":\"82\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"8\",\"icon\":\"5\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"10\",\"icon\":\"88\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"1\",\"icon\":\"85\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"25000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"25000\",\"icon\":\"86\"}]');
INSERT INTO `ny_gift` VALUES (2, 'Nạp 100k', '[{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"2000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"2000000\",\"icon\":\"3\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"50\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"50\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"100\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"2\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rương Tự Chọn Trang Bị 3*\",\"amount\":\"3\",\"icon\":\"81\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"10000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"10000\",\"icon\":\"86\"}]');
INSERT INTO `ny_gift` VALUES (3, 'Nạp 200k', '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"50\",\"icon\":\"9\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"4000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"4000000\",\"icon\":\"3\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"100\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"100\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"200\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"5\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rượng Tự Chọn Trang Bị 3*\",\"amount\":\"6\",\"icon\":\"81\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"15000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"15000\",\"icon\":\"86\"}]');
INSERT INTO `ny_gift` VALUES (4, 'Nạp 1000k', '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"250\",\"icon\":\"9\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"9000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"9000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"25000\",\"icon\":\"4\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm Thăng Giai T3\",\"amount\":\"10\",\"icon\":\"82\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"400\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"500\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"750\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"10\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rương Tự Chọn Trang Bị 3*\",\"amount\":\"15\",\"icon\":\"81\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"1\",\"icon\":\"85\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"50\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"50000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"50000\",\"icon\":\"86\"}]');
INSERT INTO `ny_gift` VALUES (5, 'Nạp 2000k', '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"450\",\"icon\":\"9\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"15000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"15000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"45000\",\"icon\":\"4\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"600\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"1000\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"1500\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"15\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rương Tự Chọn Trang Bị 3*\",\"amount\":\"25\",\"icon\":\"81\"},{\"id\":\"3:500094\",\"name\":\"Nghề Nghiệp Tiên Khí Hộp Quà\",\"amount\":\"2\",\"icon\":\"89\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"2\",\"icon\":\"85\"},{\"id\":\"3:401001\",\"name\":\"Thần Trang Tự Chọn\",\"amount\":\"2\",\"icon\":\"90\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Tự Chọn\",\"amount\":\"100\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"80000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"80000\",\"icon\":\"86\"}]');
INSERT INTO `ny_gift` VALUES (6, 'Nạp 3000k', '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"650\",\"icon\":\"9\"},{\"id\":\"3:100146\",\"name\":\"Quán Ma Chi Bình Hỗn Độn\",\"amount\":\"200\",\"icon\":\"10\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"25000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"25000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"65000\",\"icon\":\"4\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"800\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"1200\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"1800\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"25\",\"icon\":\"5\"},{\"id\":\"3:500024\",\"name\":\"Rương Tự Chọn Trang Bị 3*\",\"amount\":\"45\",\"icon\":\"81\"},{\"id\":\"3:500094\",\"name\":\"Nghề Nghiệp Tiên Khí\",\"amount\":\"3\",\"icon\":\"89\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"2\",\"icon\":\"85\"},{\"id\":\"3:401001\",\"name\":\"Thần Trang Tự Chọn\",\"amount\":\"2\",\"icon\":\"90\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"150\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"110000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"110000\",\"icon\":\"86\"}]');
INSERT INTO `ny_gift` VALUES (7, 'Nạp 4000k', '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"850\",\"icon\":\"9\"},{\"id\":\"3:100146\",\"name\":\"Quán Ma Chi Bình Hỗn Độn\",\"amount\":\"300\",\"icon\":\"10\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"35000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"35000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"85000\",\"icon\":\"4\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"1000\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"1500\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"2250\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"40\",\"icon\":\"5\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm Tăng Giai\",\"amount\":\"35\",\"icon\":\"82\"},{\"id\":\"3:500094\",\"name\":\"Nghề Nghiệp Tiên Khí\",\"amount\":\"4\",\"icon\":\"89\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"3\",\"icon\":\"85\"},{\"id\":\"3:401001\",\"name\":\"Thần Trang Tự Chọn\",\"amount\":\"2\",\"icon\":\"90\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"150\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"150000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"150000\",\"icon\":\"86\"}]');
INSERT INTO `ny_gift` VALUES (8, 'Nạp 5000k', '[{\"id\":\"3:100096\",\"name\":\"Quán Ma Chi Bình Gói Quà\",\"amount\":\"1050\",\"icon\":\"9\"},{\"id\":\"3:100146\",\"name\":\"Quán Ma Chi Bình Hỗn Độn\",\"amount\":\"400\",\"icon\":\"10\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"50000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"50000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"100000\",\"icon\":\"4\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"1500\",\"icon\":\"6\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"2000\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"2750\",\"icon\":\"8\"},{\"id\":\"5:20001\",\"name\":\"Long Hồn\",\"amount\":\"55\",\"icon\":\"5\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm Tăng Giai\",\"amount\":\"50\",\"icon\":\"82\"},{\"id\":\"3:500094\",\"name\":\"Nghề Nghiệp Tiên Khí\",\"amount\":\"5\",\"icon\":\"89\"},{\"id\":\"3:500059\",\"name\":\"Thông Dụng Tiên Khí\",\"amount\":\"4\",\"icon\":\"85\"},{\"id\":\"3:401001\",\"name\":\"Thần Trang Tự Chọn\",\"amount\":\"3\",\"icon\":\"90\"},{\"id\":\"3:400023\",\"name\":\"Thần Ma Anh Hùng Ngẫu Nhiên\",\"amount\":\"150\",\"icon\":\"88\"},{\"id\":\"3:100216\",\"name\":\"Kỳ Lân Tiên Ngọc\",\"amount\":\"200000\",\"icon\":\"87\"},{\"id\":\"3:100004\",\"name\":\"Mạ Vàng Phấn\",\"amount\":\"200000\",\"icon\":\"86\"}]');
INSERT INTO `ny_gift` VALUES (9, '100k Linh Ngọc', '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"100000\",\"icon\":\"1\"}]');
INSERT INTO `ny_gift` VALUES (10, 'QUÀ LOAN TIN', '[{\"id\":\"0:01\",\"name\":\"KNB\",\"amount\":\"100000\",\"icon\":null},{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"100000\",\"icon\":\"1\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"5000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"5000000\",\"icon\":\"3\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"10000\",\"icon\":\"4\"},{\"id\":\"3:100253\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"1000\",\"icon\":\"7\"},{\"id\":\"3:100252\",\"name\":\"Gấu Bông\",\"amount\":\"1000\",\"icon\":\"8\"}]');
INSERT INTO `ny_gift` VALUES (11, 'Quà mốc 30M LC', '[{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"200000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"200000000\",\"icon\":\"3\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"25000\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Thú Bông\",\"amount\":\"25000\",\"icon\":\"8\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"20000\",\"icon\":\"6\"},{\"id\":\"3:500094 \",\"name\":\"Nghề Nghiệp Tiên Khí Hộp Quà\",\"amount\":\"6\",\"icon\":\"96\"},{\"id\":\"3:500093 \",\"name\":\"Hỗn độn mảnh vỡ tự do\",\"amount\":\"1000\",\"icon\":\"86\"},{\"id\":\"3:100146\",\"name\":\"Quán Ma Chi Bình Hỗn Độn\",\"amount\":\"1000\",\"icon\":\"9\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm T3\",\"amount\":\"250\",\"icon\":\"82\"}]');
INSERT INTO `ny_gift` VALUES (12, 'Quà mốc 500k', '[{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"5000\",\"icon\":\"4\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"2000\",\"icon\":\"8\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"2000\",\"icon\":\"7\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"20000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"20000000\",\"icon\":\"3\"}]');
INSERT INTO `ny_gift` VALUES (13, 'Quà mốc 1000k', '[{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"5000\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"5000\",\"icon\":\"8\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"50000000\",\"icon\":\"3\"},{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"50000000\",\"icon\":\"2\"},{\"id\":\"3:100001\",\"name\":\"Tiến Giai Thạch\",\"amount\":\"10000\",\"icon\":\"4\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"5000\",\"icon\":\"6\"}]');
INSERT INTO `ny_gift` VALUES (14, 'Quà Mốc 10M', '[{\"id\":\"0:00\",\"name\":\"Kim Tệ\",\"amount\":\"50000000\",\"icon\":\"2\"},{\"id\":\"0:04\",\"name\":\"EXP Anh Hùng\",\"amount\":\"50000000\",\"icon\":\"3\"},{\"id\":\"3:100252\",\"name\":\"Thú Linh Tinh Hoa\",\"amount\":\"5000\",\"icon\":\"7\"},{\"id\":\"3:100253\",\"name\":\"Gấu Bông\",\"amount\":\"5000\",\"icon\":\"8\"},{\"id\":\"3:100342\",\"name\":\"Phá Cảnh Đan\",\"amount\":\"5000\",\"icon\":\"6\"},{\"id\":\"3:500094 \",\"name\":\"Nghề Nghiệp Tiên Khí Hộp Quà\",\"amount\":\"1\",\"icon\":\"96\"},{\"id\":\"3:100146\",\"name\":\"Quán Ma Chi Bình Hỗn Độn\",\"amount\":\"200\",\"icon\":\"9\"},{\"id\":\"3:100146\",\"name\":\"Quán Ma Chi Bình Hỗn Độn\",\"amount\":\"200\",\"icon\":\"9\"},{\"id\":\"3:100258\",\"name\":\"Thượng Phẩm T3\",\"amount\":\"75\",\"icon\":\"82\"}]');

-- ----------------------------
-- Table structure for ny_giftcode
-- ----------------------------
DROP TABLE IF EXISTS `ny_giftcode`;
CREATE TABLE `ny_giftcode`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `server_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'all',
  `max` int(11) UNSIGNED NULL DEFAULT 0,
  `count` int(11) UNSIGNED NULL DEFAULT 0,
  `gifts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `expires_time` int(11) UNSIGNED NULL DEFAULT 0,
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_giftcode
-- ----------------------------

-- ----------------------------
-- Table structure for ny_log_admin
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_admin`;
CREATE TABLE `ny_log_admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_admin
-- ----------------------------
INSERT INTO `ny_log_admin` VALUES (1, 'admin', 'updateUserInfo', 'Cập nhật tiền tệ cho tài khoản [admin] với lý do [GM]', 1689001271);
INSERT INTO `ny_log_admin` VALUES (2, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test11] tại máy chủ [1] với lý do [1]', 1742709402);
INSERT INTO `ny_log_admin` VALUES (3, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [admin] tại máy chủ [1] với lý do [a]', 1742753238);
INSERT INTO `ny_log_admin` VALUES (4, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [admin] tại máy chủ [1] với lý do [a]', 1742754622);
INSERT INTO `ny_log_admin` VALUES (5, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [admin] tại máy chủ [1] với lý do [1]', 1742867386);
INSERT INTO `ny_log_admin` VALUES (6, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [admin] tại máy chủ [1] với lý do [aa]', 1742867741);
INSERT INTO `ny_log_admin` VALUES (7, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [admin] tại máy chủ [1] với lý do [a]', 1742893277);
INSERT INTO `ny_log_admin` VALUES (8, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [admin] tại máy chủ [1] với lý do [a]', 1742893923);
INSERT INTO `ny_log_admin` VALUES (9, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [admin] tại máy chủ [1] với lý do [a]', 1742893969);
INSERT INTO `ny_log_admin` VALUES (10, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test11] tại máy chủ [1] với lý do [1]', 1743265000);
INSERT INTO `ny_log_admin` VALUES (11, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test11] tại máy chủ [1] với lý do [1]', 1743265031);
INSERT INTO `ny_log_admin` VALUES (12, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test11] tại máy chủ [1] với lý do [a]', 1743265065);
INSERT INTO `ny_log_admin` VALUES (13, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test12] tại máy chủ [1] với lý do [1]', 1743265133);
INSERT INTO `ny_log_admin` VALUES (14, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test11] tại máy chủ [1] với lý do [123]', 1743313159);
INSERT INTO `ny_log_admin` VALUES (15, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test13] tại máy chủ [1] với lý do [1]', 1743313177);
INSERT INTO `ny_log_admin` VALUES (16, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test13] tại máy chủ [1] với lý do [a]', 1743313672);
INSERT INTO `ny_log_admin` VALUES (17, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test13] tại máy chủ [1] với lý do [1]', 1743313785);
INSERT INTO `ny_log_admin` VALUES (18, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test11] tại máy chủ [1] với lý do [a]', 1743357475);
INSERT INTO `ny_log_admin` VALUES (19, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test13] tại máy chủ [1] với lý do [1]', 1743357507);
INSERT INTO `ny_log_admin` VALUES (20, 'admin', 'sendItemToUser', 'Gửi vật phẩm cho tài khoản [test13] tại máy chủ [1] với lý do [a]', 1743357539);

-- ----------------------------
-- Table structure for ny_log_event
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_event`;
CREATE TABLE `ny_log_event`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `server_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `event_id` int(11) NOT NULL,
  `milestone_id` int(11) NOT NULL,
  `action` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `gifts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` enum('error','sent','new') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'new',
  `send_mail_at` datetime NULL DEFAULT NULL,
  `reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_event
-- ----------------------------
INSERT INTO `ny_log_event` VALUES (1, 'vanduc2611c', '1', 3, 6, 'Đã nhận mốc thưởng [Nạp 100000 VNĐ] của sự kiện [Tích nạp tháng] tại máy chủ [1]', 1690223189, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"11111\",\"icon\":null}]', 'sent', '2023-07-25 02:50:02', '成功给s1区的玩家『一曲红尘醉』发送道具【Linh Ngọc】成功');

-- ----------------------------
-- Table structure for ny_log_giftcode
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_giftcode`;
CREATE TABLE `ny_log_giftcode`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `server_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `giftcode_id` int(11) NOT NULL,
  `action` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_giftcode
-- ----------------------------

-- ----------------------------
-- Table structure for ny_log_ip
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_ip`;
CREATE TABLE `ny_log_ip`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `block` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0: Unblock, 1: Block',
  `connect` double(50, 0) NULL DEFAULT 0,
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2962 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_ip
-- ----------------------------
INSERT INTO `ny_log_ip` VALUES (1, '171.241.15.187', 0, 1995, 1690391932);
INSERT INTO `ny_log_ip` VALUES (2900, '171.241.58.35', 0, 412, 1742841859);
INSERT INTO `ny_log_ip` VALUES (2901, '118.71.18.80', 0, 4, 1742786140);
INSERT INTO `ny_log_ip` VALUES (2902, '118.70.144.69', 0, 683, 1743740777);
INSERT INTO `ny_log_ip` VALUES (2903, '54.90.151.216', 0, 0, 1742786919);
INSERT INTO `ny_log_ip` VALUES (2904, '54.158.235.76', 0, 0, 1742787152);
INSERT INTO `ny_log_ip` VALUES (2905, '103.53.170.145', 0, 9, 1742793049);
INSERT INTO `ny_log_ip` VALUES (2906, '171.241.87.23', 0, 256, 1743427939);
INSERT INTO `ny_log_ip` VALUES (2907, '1.53.240.32', 0, 52, 1743255294);
INSERT INTO `ny_log_ip` VALUES (2908, '116.98.248.165', 0, 10, 1743251527);
INSERT INTO `ny_log_ip` VALUES (2909, '42.114.249.194', 0, 6, 1743251813);
INSERT INTO `ny_log_ip` VALUES (2910, '118.70.98.15', 0, 5, 1743251850);
INSERT INTO `ny_log_ip` VALUES (2911, '183.81.64.226', 0, 4, 1743252478);
INSERT INTO `ny_log_ip` VALUES (2912, '123.21.250.95', 0, 10, 1743504476);
INSERT INTO `ny_log_ip` VALUES (2913, '171.241.137.72', 0, 9, 1743259088);
INSERT INTO `ny_log_ip` VALUES (2914, '171.241.51.28', 0, 6, 1743259583);
INSERT INTO `ny_log_ip` VALUES (2915, '66.249.73.3', 0, 1, 1743265585);
INSERT INTO `ny_log_ip` VALUES (2916, '171.247.68.119', 0, 9, 1743292874);
INSERT INTO `ny_log_ip` VALUES (2917, '118.71.92.3', 0, 7, 1743319269);
INSERT INTO `ny_log_ip` VALUES (2918, '27.66.21.157', 0, 5, 1743318231);
INSERT INTO `ny_log_ip` VALUES (2919, '27.67.95.73', 0, 0, 1743318535);
INSERT INTO `ny_log_ip` VALUES (2920, '104.28.242.247', 0, 7, 1743344027);
INSERT INTO `ny_log_ip` VALUES (2921, '171.255.127.36', 0, 8, 1743348854);
INSERT INTO `ny_log_ip` VALUES (2922, '42.113.240.67', 0, 8, 1743386568);
INSERT INTO `ny_log_ip` VALUES (2923, '1.54.176.186', 0, 1, 1743387833);
INSERT INTO `ny_log_ip` VALUES (2924, '58.186.69.93', 0, 0, 1743389007);
INSERT INTO `ny_log_ip` VALUES (2925, '123.20.212.172', 0, 11, 1743389714);
INSERT INTO `ny_log_ip` VALUES (2926, '171.251.40.121', 0, 2, 1743393398);
INSERT INTO `ny_log_ip` VALUES (2927, '66.249.73.2', 0, 0, 1743398250);
INSERT INTO `ny_log_ip` VALUES (2928, '35.168.9.117', 0, 0, 1743399467);
INSERT INTO `ny_log_ip` VALUES (2929, '14.232.244.252', 0, 0, 1743403478);
INSERT INTO `ny_log_ip` VALUES (2930, '171.225.185.110', 0, 2, 1743418151);
INSERT INTO `ny_log_ip` VALUES (2931, '115.76.50.238', 0, 0, 1743432510);
INSERT INTO `ny_log_ip` VALUES (2932, '171.244.84.159', 0, 7, 1743503780);
INSERT INTO `ny_log_ip` VALUES (2933, '123.27.3.155', 0, 3, 1743503798);
INSERT INTO `ny_log_ip` VALUES (2934, '113.178.85.253', 0, 0, 1743503853);
INSERT INTO `ny_log_ip` VALUES (2935, '173.252.127.112', 0, 0, 1743503891);
INSERT INTO `ny_log_ip` VALUES (2936, '125.212.159.192', 0, 6, 1743503935);
INSERT INTO `ny_log_ip` VALUES (2937, '116.96.44.127', 0, 0, 1743505508);
INSERT INTO `ny_log_ip` VALUES (2938, '14.177.45.193', 0, 17, 1743509588);
INSERT INTO `ny_log_ip` VALUES (2939, '59.153.225.147', 0, 5, 1743509949);
INSERT INTO `ny_log_ip` VALUES (2940, '58.186.128.116', 0, 3, 1743512360);
INSERT INTO `ny_log_ip` VALUES (2941, '14.166.50.187', 0, 2, 1743517887);
INSERT INTO `ny_log_ip` VALUES (2942, '171.241.25.59', 0, 11, 1743826718);
INSERT INTO `ny_log_ip` VALUES (2943, '27.79.226.235', 0, 1, 1743579998);
INSERT INTO `ny_log_ip` VALUES (2944, '58.187.78.254', 0, 9, 1743591007);
INSERT INTO `ny_log_ip` VALUES (2945, '27.78.35.183', 0, 2, 1743699757);
INSERT INTO `ny_log_ip` VALUES (2946, '35.173.188.65', 0, 0, 1743733839);
INSERT INTO `ny_log_ip` VALUES (2947, '115.75.161.198', 0, 5, 1743754768);
INSERT INTO `ny_log_ip` VALUES (2948, '112.197.8.70', 0, 0, 1743754740);
INSERT INTO `ny_log_ip` VALUES (2949, '123.22.46.239', 0, 1, 1743767125);
INSERT INTO `ny_log_ip` VALUES (2950, '171.225.184.83', 0, 6, 1743840143);
INSERT INTO `ny_log_ip` VALUES (2951, '1.55.18.59', 0, 0, 1743845611);
INSERT INTO `ny_log_ip` VALUES (2952, '171.237.167.213', 0, 1, 1743848533);
INSERT INTO `ny_log_ip` VALUES (2953, '116.98.242.64', 0, 8, 1743860733);
INSERT INTO `ny_log_ip` VALUES (2954, '171.244.120.68', 0, 4, 1743861740);
INSERT INTO `ny_log_ip` VALUES (2955, '58.187.54.180', 0, 8, 1743865824);
INSERT INTO `ny_log_ip` VALUES (2956, '112.197.12.70', 0, 0, 1743865769);
INSERT INTO `ny_log_ip` VALUES (2957, '173.252.127.48', 0, 0, 1743937061);
INSERT INTO `ny_log_ip` VALUES (2958, '104.28.68.155', 0, 0, 1743960402);
INSERT INTO `ny_log_ip` VALUES (2959, '203.210.162.23', 0, 1, 1743997147);
INSERT INTO `ny_log_ip` VALUES (2960, '125.235.121.2', 0, 14, 1744024401);
INSERT INTO `ny_log_ip` VALUES (2961, '14.186.237.207', 0, 3, 1744087220);

-- ----------------------------
-- Table structure for ny_log_login
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_login`;
CREATE TABLE `ny_log_login`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2730 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_login
-- ----------------------------
INSERT INTO `ny_log_login` VALUES (1, 'admin', '171.241.15.187', 1689001084);
INSERT INTO `ny_log_login` VALUES (2674, 'admin', '171.241.58.35', 1742703541);
INSERT INTO `ny_log_login` VALUES (2675, 'test11', '171.241.58.35', 1742703591);
INSERT INTO `ny_log_login` VALUES (2676, 'test11', '171.241.58.35', 1742749693);
INSERT INTO `ny_log_login` VALUES (2677, 'admin', '171.241.58.35', 1742753114);
INSERT INTO `ny_log_login` VALUES (2678, '234234', '118.71.18.80', 1742786139);
INSERT INTO `ny_log_login` VALUES (2679, 'test11', '118.70.144.69', 1742786615);
INSERT INTO `ny_log_login` VALUES (2680, 'test111', '118.70.144.69', 1742787061);
INSERT INTO `ny_log_login` VALUES (2681, 'admin', '118.70.144.69', 1742787296);
INSERT INTO `ny_log_login` VALUES (2682, 'test11', '103.53.170.145', 1742788086);
INSERT INTO `ny_log_login` VALUES (2683, 'test11', '171.241.58.35', 1742837391);
INSERT INTO `ny_log_login` VALUES (2684, 'admin', '118.70.144.69', 1742867346);
INSERT INTO `ny_log_login` VALUES (2685, 'test111', '118.70.144.69', 1742867479);
INSERT INTO `ny_log_login` VALUES (2686, 'test11', '171.241.87.23', 1742914326);
INSERT INTO `ny_log_login` VALUES (2687, 'test11', '171.241.87.23', 1742959213);
INSERT INTO `ny_log_login` VALUES (2688, 'test11', '1.53.240.32', 1743244144);
INSERT INTO `ny_log_login` VALUES (2689, 'test12', '1.53.240.32', 1743249383);
INSERT INTO `ny_log_login` VALUES (2690, '123123', '42.114.249.194', 1743251810);
INSERT INTO `ny_log_login` VALUES (2691, 'lak000', '118.70.98.15', 1743251824);
INSERT INTO `ny_log_login` VALUES (2692, 'tungpuskin', '183.81.64.226', 1743252469);
INSERT INTO `ny_log_login` VALUES (2693, 'shuichi', '123.21.250.95', 1743253123);
INSERT INTO `ny_log_login` VALUES (2694, 'hoanghung', '171.241.137.72', 1743259084);
INSERT INTO `ny_log_login` VALUES (2695, 'phucok', '171.241.51.28', 1743259579);
INSERT INTO `ny_log_login` VALUES (2696, 'test11', '171.241.87.23', 1743263065);
INSERT INTO `ny_log_login` VALUES (2697, 'admin', '171.241.87.23', 1743264982);
INSERT INTO `ny_log_login` VALUES (2698, 'test12', '171.241.87.23', 1743265089);
INSERT INTO `ny_log_login` VALUES (2699, 'test13', '171.241.87.23', 1743265589);
INSERT INTO `ny_log_login` VALUES (2700, 'test13', '171.241.87.23', 1743267600);
INSERT INTO `ny_log_login` VALUES (2701, 'toan300', '171.247.68.119', 1743292839);
INSERT INTO `ny_log_login` VALUES (2702, 'admin', '171.241.87.23', 1743299311);
INSERT INTO `ny_log_login` VALUES (2703, 'khanhlam', '118.71.92.3', 1743315309);
INSERT INTO `ny_log_login` VALUES (2704, 'lak000', '171.255.127.36', 1743348766);
INSERT INTO `ny_log_login` VALUES (2705, 'test13', '171.241.87.23', 1743356218);
INSERT INTO `ny_log_login` VALUES (2706, 'hoanghung', '42.113.240.67', 1743386075);
INSERT INTO `ny_log_login` VALUES (2707, 'test13', '118.70.144.69', 1743396224);
INSERT INTO `ny_log_login` VALUES (2708, 'admin', '171.241.87.23', 1743427939);
INSERT INTO `ny_log_login` VALUES (2709, 'test13', '118.70.144.69', 1743474842);
INSERT INTO `ny_log_login` VALUES (2710, 'admin', '118.70.144.69', 1743503670);
INSERT INTO `ny_log_login` VALUES (2711, 'phucok', '171.244.84.159', 1743503777);
INSERT INTO `ny_log_login` VALUES (2712, 'lak000', '123.27.3.155', 1743503795);
INSERT INTO `ny_log_login` VALUES (2713, 'lak000', '113.178.85.253', 1743503853);
INSERT INTO `ny_log_login` VALUES (2714, 'phucbaby', '125.212.159.192', 1743503932);
INSERT INTO `ny_log_login` VALUES (2715, 'shuichi', '123.21.250.95', 1743504472);
INSERT INTO `ny_log_login` VALUES (2716, 'alex123', '14.177.45.193', 1743509515);
INSERT INTO `ny_log_login` VALUES (2717, 'alex123', '59.153.225.147', 1743509893);
INSERT INTO `ny_log_login` VALUES (2718, 'test13', '171.241.25.59', 1743527074);
INSERT INTO `ny_log_login` VALUES (2719, 'alex123', '27.79.226.235', 1743579998);
INSERT INTO `ny_log_login` VALUES (2720, 'admin', '118.70.144.69', 1743664721);
INSERT INTO `ny_log_login` VALUES (2721, 'test13', '118.70.144.69', 1743733502);
INSERT INTO `ny_log_login` VALUES (2722, 'thmodz', '115.75.161.198', 1743754740);
INSERT INTO `ny_log_login` VALUES (2723, 'hihihi', '171.225.184.83', 1743840140);
INSERT INTO `ny_log_login` VALUES (2724, 'hoanghung', '171.237.167.213', 1743848533);
INSERT INTO `ny_log_login` VALUES (2725, '12345678h', '116.98.242.64', 1743860699);
INSERT INTO `ny_log_login` VALUES (2726, 'lak000', '171.244.120.68', 1743861737);
INSERT INTO `ny_log_login` VALUES (2727, 'oiconga123', '58.187.54.180', 1743865804);
INSERT INTO `ny_log_login` VALUES (2728, 'toan95', '125.235.121.2', 1744024028);
INSERT INTO `ny_log_login` VALUES (2729, '234234', '14.186.237.207', 1744087219);

-- ----------------------------
-- Table structure for ny_log_login_server
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_login_server`;
CREATE TABLE `ny_log_login_server`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `server_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_login_server
-- ----------------------------

-- ----------------------------
-- Table structure for ny_log_mission
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_mission`;
CREATE TABLE `ny_log_mission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `server_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mission_id` int(11) NOT NULL,
  `action` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `gifts` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` enum('error','sent','new') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'new',
  `reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `send_mail_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_mission
-- ----------------------------
INSERT INTO `ny_log_mission` VALUES (1, 'vanduc2611c', '1', 1, 'Đã nhận thưởng nhiệm vụ [Đăng nhập 7 ngày] tại máy chủ [1]', 1690226013, '[{\"id\":\"3:999999\",\"name\":\"Linh Ngọc\",\"amount\":\"11111\",\"icon\":null}]', 'sent', '成功给s1区的玩家『一曲红尘醉』发送道具【Linh Ngọc】成功', '2023-07-25 03:50:01');

-- ----------------------------
-- Table structure for ny_log_referral
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_referral`;
CREATE TABLE `ny_log_referral`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `invitee` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_referral
-- ----------------------------
INSERT INTO `ny_log_referral` VALUES (1, 'phungtruong', 'tranlinh', '[tranlinh] đã đăng ký tài khoản bằng mã mời từ [phungtruong], cả 2 nhận được [0 Xu Khóa] từ đặc quyền [VIP 0] của [phungtruong]', 1690951693);

-- ----------------------------
-- Table structure for ny_log_shop
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_shop`;
CREATE TABLE `ny_log_shop`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `server_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `shop_id` int(11) NOT NULL,
  `shop_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double(50, 0) UNSIGNED NOT NULL,
  `action` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `item_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quantity` int(11) NULL DEFAULT NULL,
  `status` enum('error','sent','new') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'new',
  `reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `send_mail_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_shop
-- ----------------------------
INSERT INTO `ny_log_shop` VALUES (1, 'vanduc2611c', '1', 1, 'item', 100000, 'Đã mua vật phẩm [Linh Ngọc] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', 1690197654, '3:999999', 100000, 'sent', '成功给s1区的玩家『一曲红尘醉』发送道具【Linh Ngọc】成功', '2023-07-24 19:30:17');
INSERT INTO `ny_log_shop` VALUES (2, 'test11', '1', 3, 'item', 200000, 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', 1742705500, '3:999999', 200000, 'sent', '', '2025-03-23 12:52:03');
INSERT INTO `ny_log_shop` VALUES (3, 'test11', '1', 91, 'item', 900000, 'Đã mua vật phẩm [Viêm 14*] số lượng [x1] với giá [900000 Xu] tại máy chủ [1]', 1742709369, '1:600210', 1, 'sent', '', '2025-03-23 13:57:01');
INSERT INTO `ny_log_shop` VALUES (4, 'admin', '1', 91, 'item', 900000, 'Đã mua vật phẩm [Viêm 14*] số lượng [x1] với giá [900000 Xu] tại máy chủ [1]', 1742756246, '1:600210', 1, 'sent', '', '2025-03-24 02:58:01');
INSERT INTO `ny_log_shop` VALUES (5, 'test11', '1', 95, 'item', 350000, 'Đã mua vật phẩm [Nghề Nghiệp Tiên Khí Hộp Quà] số lượng [x1] với giá [350000 Xu] tại máy chủ [1]', 1742757965, '3:500094', 1, 'sent', '', '2025-03-24 03:27:01');
INSERT INTO `ny_log_shop` VALUES (6, 'test11', '1', 5, 'item', 1000000, 'Đã mua vật phẩm [Linh Ngọc 1000k] số lượng [x1000000] với giá [1000000 Xu] tại máy chủ [1]', 1742793049, '3:999999', 1000000, 'sent', '', '2025-03-24 13:11:01');
INSERT INTO `ny_log_shop` VALUES (7, 'admin', '1', 2, 'item', 100000, 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', 1742874516, '3:999999', 100000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 11:49:01');
INSERT INTO `ny_log_shop` VALUES (8, 'admin', '1', 92, 'item', 900000, 'Đã mua vật phẩm [Quang 14*] số lượng [x1] với giá [900000 Xu] tại máy chủ [1]', 1742875673, '1:600310', 1, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:08:02');
INSERT INTO `ny_log_shop` VALUES (9, 'admin', '1', 2, 'item', 100000, 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', 1742875930, '3:999999', 100000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:13:01');
INSERT INTO `ny_log_shop` VALUES (10, 'admin', '1', 2, 'item', 100000, 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', 1742875938, '3:999999', 100000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:13:01');
INSERT INTO `ny_log_shop` VALUES (11, 'admin', '1', 4, 'item', 500000, 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', 1742876030, '3:999999', 500000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:14:02');
INSERT INTO `ny_log_shop` VALUES (12, 'admin', '1', 4, 'item', 500000, 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', 1742876408, '3:999999', 500000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:21:02');
INSERT INTO `ny_log_shop` VALUES (13, 'admin', '1', 4, 'item', 500000, 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', 1742876415, '3:999999', 500000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:21:02');
INSERT INTO `ny_log_shop` VALUES (14, 'admin', '1', 4, 'item', 500000, 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', 1742876499, '3:999999', 500000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:22:01');
INSERT INTO `ny_log_shop` VALUES (15, 'admin', '1', 3, 'item', 200000, 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', 1742876504, '3:999999', 200000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:22:02');
INSERT INTO `ny_log_shop` VALUES (16, 'admin', '1', 4, 'item', 500000, 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', 1742876519, '3:999999', 500000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:22:02');
INSERT INTO `ny_log_shop` VALUES (17, 'admin', '1', 4, 'item', 500000, 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', 1742876640, '3:999999', 500000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:24:01');
INSERT INTO `ny_log_shop` VALUES (18, 'admin', '1', 3, 'item', 200000, 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', 1742876900, '3:999999', 200000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:29:01');
INSERT INTO `ny_log_shop` VALUES (19, 'admin', '1', 2, 'item', 100000, 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', 1742877051, '3:999999', 100000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:31:02');
INSERT INTO `ny_log_shop` VALUES (20, 'admin', '1', 3, 'item', 200000, 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', 1742877101, '3:999999', 200000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:32:01');
INSERT INTO `ny_log_shop` VALUES (21, 'admin', '1', 3, 'item', 200000, 'Đã mua vật phẩm [Linh Ngọc 200k] số lượng [x200000] với giá [200000 Xu] tại máy chủ [1]', 1742877107, '3:999999', 200000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:32:01');
INSERT INTO `ny_log_shop` VALUES (22, 'admin', '1', 2, 'item', 100000, 'Đã mua vật phẩm [Linh Ngọc 100k] số lượng [x100000] với giá [100000 Xu] tại máy chủ [1]', 1742878034, '3:999999', 100000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:48:02');
INSERT INTO `ny_log_shop` VALUES (23, 'admin', '1', 4, 'item', 500000, 'Đã mua vật phẩm [Linh Ngọc 500k] số lượng [x500000] với giá [500000 Xu] tại máy chủ [1]', 1742878056, '3:999999', 500000, 'sent', '&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  mysqli_fetch_assoc() expects parameter 1 to be mysqli_result, boolean given in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;116&lt;/b&gt;&lt;br /&gt;\n&lt;br /&gt;\n&lt;b&gt;Warning&lt;/b&gt;:  file_put_contents(./log/用户邮件2025-03-25.log): failed to open stream: Permission denied in &lt;b&gt;/home/web/tool/user/function/common.php&lt;/b&gt; on line &lt;b&gt;176&lt;/b&gt;&lt;br /&gt;\n成功给s1区的玩家『Tháo』发', '2025-03-25 12:48:02');

-- ----------------------------
-- Table structure for ny_log_wheel
-- ----------------------------
DROP TABLE IF EXISTS `ny_log_wheel`;
CREATE TABLE `ny_log_wheel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `server_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gift_id` int(11) NOT NULL,
  `action` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `item_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quantity` int(11) NULL DEFAULT NULL,
  `status` enum('error','sent','new') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'new',
  `gift_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `send_mail_at` datetime NULL DEFAULT NULL,
  `reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_log_wheel
-- ----------------------------
INSERT INTO `ny_log_wheel` VALUES (1, 'tester01', '1', 4, 'Quay được [50K Xu]', 1690001158, NULL, 50000, 'sent', 'coin', NULL, NULL);

-- ----------------------------
-- Table structure for ny_mission_custom
-- ----------------------------
DROP TABLE IF EXISTS `ny_mission_custom`;
CREATE TABLE `ny_mission_custom`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `gifts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `expires_time` int(11) UNSIGNED NULL DEFAULT 0,
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_mission_custom
-- ----------------------------

-- ----------------------------
-- Table structure for ny_news
-- ----------------------------
DROP TABLE IF EXISTS `ny_news`;
CREATE TABLE `ny_news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title_seo` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `img` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `viewer` int(11) NOT NULL DEFAULT 0,
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_news
-- ----------------------------
INSERT INTO `ny_news` VALUES (1, 'KHAI MỞ SV MỚI S3 - ẢNH', 'khai-mo-sv-moi-s3---anh', 'KHAI MỞ SV MỚI VÀO 10H00 NGÀY 31/07', '<p><strong>ĐĂNG NHẬP NHẬN NGAY 200K XU NẠP + 200K KNB + 1000 LƯỢT QUAY + VIP6</strong></p><p>SỰ KIÊN TÂN THỦ:</p><p><strong>VIP6666 - VIP7777 - VIP8888 - VIP9999</strong></p><p>======================================</p><p><strong>CODE SỰ KIỆN LIKE SHARE LOAN TIN:</strong></p><p>100.000 KNB</p><p>100.000 XU NẠP</p><p>10.000 TIẾN GIAI THẠCH</p><p>5.000.0000 EXP ANH HÙNG</p><p>5.000.000 KIM TỆ</p><p>1000 THÚ LINH TINH HOA</p><p>1000 GẤU BÔNG</p><p>======================================</p><p><strong>BƯỚC 1</strong>: LIKE + SHARE BÀI VIẾT NÀY Ở TRANG CÁ NHÂN ĐỂ CHẾ ĐỘ CÔNG KHAI VÀ SHARE VÀO 3 GROUP GAME BẤT KỲ</p><p><strong>BƯỚC 2</strong>: COMMENT 5 LẦN VÀO BÀI VIẾT + TAG 3 NGƯỜI BẠN</p><p><strong>BƯỚC 3</strong>: LÀM ĐỦ CÁC BƯỚC CHỤP HÌNH ẢNH GỬI VÀO INBOX FANPAGE NHẬN CODE</p><p>======================================</p><p>NẠP QUA <strong>MOMO/BANK</strong> TẶNG THÊM <strong>200%</strong> TỔNG NHÂN <strong>300%</strong></p><p>SỰ KIỆN 7 NGÀY ĐUA TOP LỰC CHIẾN, ĐUA TOP NẠP, ĐUA TOP TIÊU, ĐUA TOP LEO THÁP</p>', 'new', 'https://i.imgur.com/NBHfOcs.jpg', 432, 1, 1690656004);
INSERT INTO `ny_news` VALUES (2, 'KHUYẾN MÃI NẠP x3', 'khuyen-mai-nap-x3', 'Ưu đãi KM 300%, Mốc nạp Đơn, Mốc nạp tích lũy', '<p>KHUYẾN MÃI <strong>300%</strong> NẠP THẺ QUA: MOMO VÀ BANKING</p><p>THÀNH VIÊN GROUP ZALO: NẠP XONG + CHỤP ẢNH GỬI ADMIN ĐÃ THAM GIA NHÓM ĐƯỢC TẶNG THÊM <strong>200%</strong> XU: TỔNG NHẬN LÀ <strong>500%</strong> - <strong>CHỈ ÁP DỤNG LẦN NẠP ĐẦU TIÊN</strong></p><ul><li>KHI NẠP NGƯỜI CHƠI SẼ NHẬN THÊM XU KHÓA CÓ GIÁ TRỊ NHƯ XU THƯỜNG VÀ MUA VẬT PHẨM Ở MỤC CỬA HÀNG</li></ul><p>KHUYẾN MÃI NẠP ĐƠN</p><ul><li>1 MỆNH GIÁ 500K: <strong style=\"color: rgb(5, 5, 5);\">Tặng 2 tướng 14* tự chọn(Không được tính hệ Hỗn Độn) + 2000 Thú Linh Tinh Hoa + 2000 Gấu Bông + 5000 Tiến Giai Thạch + 20.000.000 Kim Tệ + 20.000.000 EXP Anh Hùng</strong></li><li><span style=\"color: rgb(5, 5, 5);\">1 MỆNH GIÁ 1M: </span><strong style=\"color: rgb(5, 5, 5);\">Tặng 5 tướng 14* + 5000 Phá Cảnh Đan + 10000 Thú Linh Tinh Hoa + 10000 Gấu Bông + 50.000.000 Kim Tệ + 50.000.000 EXP Anh Hùng</strong></li><li><strong style=\"color: rgb(5, 5, 5);\">1 MỆNH GIÁ 3M: Tặng 5 Tướng HỖN ĐỘN 14*( Trừ Võ Thần) +15000 Phá Cảnh Đan + 20000 Thú Linh Tinh Hoa + 20000 Gấu Bông + 100.000.000 Kim Tệ + 100.000.000 EXP Anh Hùng</strong></li></ul><p>KHUYẾN MÃI ĐẠT MỐC HÀNG NGÀY: SẼ RESET THEO NGÀY</p><ul><li>CHI TIẾT CÁC MỐC NẠP TẠI: http://play.thiendeafk.mobi/client/shop</li></ul>', 'hot', 'https://imgur.com/sWcxGRS.jpg', 338, 1, 1691747547);
INSERT INTO `ny_news` VALUES (3, 'HỆ THỐNG TIỀN TỆ TRONG GAME', 'he-thong-tien-te-trong-game', 'Các tiền tệ trong game', '<p>HỆ THỐNG TIỀN TỆ TRONG GAME</p><p><br></p><p><strong>1 - Xu Nạp</strong> (Chỉ sử dụng ở WEB NẠP: Xu xanh, Xu vàng)&nbsp;</p><ul><li>Là Xu nhận được khi thực hiện nạp bằng Bank hoặc MoMo.&nbsp;</li><li>Khi nạp nhận được Xu Nạp sẽ được tính tích nạp tại mục Sự Kiện ngoài ra khi có nhiệm vụ sẽ cần phải dùng Xu Nạp để tiêu và hoàn thành</li><li>Xu này dùng để mua các vật phẩm ở mục cửa hàng rồi gửi vào game qua thư.&nbsp;</li><li>Mỗi khi mua vật phẩm sau 5\' sẽ gửi vào trong game.&nbsp;</li></ul><p><br></p><p><strong>2 - Linh Ngọc</strong> (Chỉ sử dụng trong Game)</p><ul><li>Là vật phẩm trong game dùng để mua được tất cả các gói nạp trong game</li><li>Khi tiêu Linh Ngọc sẽ được tính Điểm Vip và Event tích nạp trong game theo tỉ lệ: 100k = 1000 Điểm</li><li>Để nhận được Linh Ngọc sẽ cần dùng Xu Nạp để mua từ WEB NẠP chuyển vào thông qua mục CỬA HÀNG</li><li>Ngoài ra để nhận thêm Linh Ngọc sẽ cần tham gia các event trên fanpage và Group Zalo</li></ul><p><br></p>', 'hot', 'https://imgur.com/E9bplTB.png', 156, 1, 1691167632);
INSERT INTO `ny_news` VALUES (4, 'KHAI MỞ SV MỚI S4 - VIÊM', 'khai-mo-sv-moi-s4---viem', 'KHAI MỞ SV MỚI VÀO 10H00 NGÀY 07/08', '<p><strong>ĐĂNG NHẬP NHẬN NGAY 200K XU NẠP + 200K KNB + 1000 LƯỢT QUAY + VIP6</strong></p><p>SỰ KIÊN TÂN THỦ:</p><p><strong>VIP6666 - VIP7777 - VIP8888 - VIP9999</strong></p><p>======================================</p><p><strong>CODE SỰ KIỆN LIKE SHARE LOAN TIN:</strong></p><p>100.000 KNB</p><p>100.000 XU NẠP</p><p>10.000 TIẾN GIAI THẠCH</p><p>5.000.0000 EXP ANH HÙNG</p><p>5.000.000 KIM TỆ</p><p>1000 THÚ LINH TINH HOA</p><p>1000 GẤU BÔNG</p><p>======================================</p><p><strong>BƯỚC 1</strong>: LIKE + SHARE BÀI VIẾT NÀY Ở TRANG CÁ NHÂN ĐỂ CHẾ ĐỘ CÔNG KHAI VÀ SHARE VÀO 3 GROUP GAME BẤT KỲ</p><p><strong>BƯỚC 2</strong>: COMMENT 5 LẦN VÀO BÀI VIẾT + TAG 3 NGƯỜI BẠN</p><p><strong>BƯỚC 3</strong>: LÀM ĐỦ CÁC BƯỚC CHỤP HÌNH ẢNH GỬI VÀO INBOX FANPAGE NHẬN CODE</p><p>======================================</p><p>NẠP QUA&nbsp;<strong>MOMO/BANK</strong>&nbsp;TẶNG THÊM&nbsp;<strong>200%</strong>&nbsp;TỔNG NHÂN&nbsp;<strong>300%</strong></p><p>SỰ KIỆN 7 NGÀY ĐUA TOP LỰC CHIẾN, ĐUA TOP NẠP, ĐUA TOP TIÊU, ĐUA TOP LEO THÁP</p>', 'new', 'https://i.imgur.com/NBHfOcs.jpg', 481, 1, 1691252796);
INSERT INTO `ny_news` VALUES (5, 'KHAI MỞ SV MỚI S5-QUANG', 'khai-mo-sv-moi-s5-quang', 'KHAI MỞ SV MỚI VÀO 10H00 NGÀY 14/08', '<p><strong>ĐĂNG NHẬP NHẬN NGAY 200K XU NẠP + 200K KNB + 1000 LƯỢT QUAY + VIP6</strong></p><p>SỰ KIÊN TÂN THỦ:</p><p><strong>VIP6666 - VIP7777 - VIP8888 - VIP9999</strong></p><p>======================================</p><p><strong>CODE SỰ KIỆN LIKE SHARE LOAN TIN:</strong></p><p>100.000 KNB</p><p>100.000 XU NẠP</p><p>10.000 TIẾN GIAI THẠCH</p><p>5.000.0000 EXP ANH HÙNG</p><p>5.000.000 KIM TỆ</p><p>1000 THÚ LINH TINH HOA</p><p>1000 GẤU BÔNG</p><p>======================================</p><p><strong>BƯỚC 1</strong>: LIKE + SHARE BÀI VIẾT NÀY Ở TRANG CÁ NHÂN ĐỂ CHẾ ĐỘ CÔNG KHAI VÀ SHARE VÀO 3 GROUP GAME BẤT KỲ</p><p><strong>BƯỚC 2</strong>: COMMENT 5 LẦN VÀO BÀI VIẾT + TAG 3 NGƯỜI BẠN</p><p><strong>BƯỚC 3</strong>: LÀM ĐỦ CÁC BƯỚC CHỤP HÌNH ẢNH GỬI VÀO INBOX FANPAGE NHẬN CODE</p><p>======================================</p><p>NẠP QUA&nbsp;<strong>MOMO/BANK</strong>&nbsp;TẶNG THÊM&nbsp;<strong>200%</strong>&nbsp;TỔNG NHÂN&nbsp;<strong>300%</strong></p><p><strong>THÀNH VIÊN GROUP ZALO TẶNG THÊM 200% TỔNG LÀ 500% CHỈ ĐƯƠC 1 LẦN DUY NHẤT</strong></p><p>SỰ KIỆN 7 NGÀY ĐUA TOP LỰC CHIẾN, ĐUA TOP NẠP, ĐUA TOP TIÊU, ĐUA TOP LEO THÁP</p>', 'new', 'https://i.imgur.com/shyJMnb.jpg', 142, 1, 1691891321);
INSERT INTO `ny_news` VALUES (6, 'HOÀN TẤT BẢO TRÌ', 'hoan-tat-bao-tri', 'Câp nhật event mới', '<p>THÔNG TIN UPDATE BẢN MỚI</p><ul><li>Tính năng <strong>Dự Đoán Tam Giới</strong> tặng thêm <strong>Linh Ngọc (Xu Nạp)</strong></li><li>Phần quà <strong>BXH Tam Giới</strong> tặng thêm <strong>Linh Ngọc (Xu Nạp)</strong></li><li>Làm mới event BXH Nạp Liên Server</li><li>Cập nhật event BXH Long Châu</li><li>Cập nhật event: Thú Hồn: Dùng KNB kiếm Thú Hồn hoàn trả Kim Tệ</li><li>Cập nhật event: Triệu Hồi: Với nhiều mốc ưu đãi</li><li>Cập nhật event: Bảo Khố để nhận thêm nhiều Tàng Phẩm</li><li>Cập nhật event triệu hồi: Hệ Hỗn Độn: Tướng Ảnh</li></ul>', 'update', 'https://imgur.com/E9bplTB.png', 36, 1, 1691977549);

-- ----------------------------
-- Table structure for ny_notify
-- ----------------------------
DROP TABLE IF EXISTS `ny_notify`;
CREATE TABLE `ny_notify`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `view` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_notify
-- ----------------------------
INSERT INTO `ny_notify` VALUES (1, 'admin', 'pay', 'Bạn được duyệt thành công giao dịch nạp tiền [P-0001], nhận về [20000 Xu] [0 Xu Khóa] [1 Lượt Quay]', 1, 1689220084);

-- ----------------------------
-- Table structure for ny_pay
-- ----------------------------
DROP TABLE IF EXISTS `ny_pay`;
CREATE TABLE `ny_pay`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `money` double(50, 0) UNSIGNED NOT NULL,
  `gate_id` int(11) NOT NULL,
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `token` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `qr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0: Wait, 1: Done, 2: Error',
  `verifier` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `verify_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_pay
-- ----------------------------
INSERT INTO `ny_pay` VALUES (1, 'admin', 20000, 3, 'P-0001', '5cba426833796d8cfb81e5aa1cab6f36', 'https://momosv3.apimienphi.com/api/QRCode?phone=System&amount=20000&note=P-0001', 1, 'admin', 1689220084, 1689002488);
INSERT INTO `ny_pay` VALUES (2, 'admin', 200000, 1, 'P-0002', 'f38d8f8290bc4234d7f1e6fbb5f27d91', 'https://img.vietqr.io/image/VCB-0451000397594-print.png?amount=200000&addInfo=P-0002', 0, NULL, NULL, 1743664809);
INSERT INTO `ny_pay` VALUES (3, 'admin', 2000000, 1, 'P-0003', '200a19348130083c47ba6977b3a9af27', 'https://img.vietqr.io/image/VCB-0451000397594-print.png?amount=2000000&addInfo=P-0003', 0, NULL, NULL, 1743664865);

-- ----------------------------
-- Table structure for ny_server
-- ----------------------------
DROP TABLE IF EXISTS `ny_server`;
CREATE TABLE `ny_server`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `server_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `db_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `path` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `file_start` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'start.sh',
  `file_stop` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'stop.sh',
  `running` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0: No, 1: Yes',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_server
-- ----------------------------
INSERT INTO `ny_server` VALUES (1, '1', 'S1', 'stat', NULL, 'start.sh', 'stop.sh', 0, 1691955889);
INSERT INTO `ny_server` VALUES (2, '3', 'S3', 'stat', NULL, 'start.sh', 'stop.sh', 0, 1691955889);
INSERT INTO `ny_server` VALUES (3, '4', 'S4', 'stat', NULL, 'start.sh', 'stop.sh', 0, 1691955889);
INSERT INTO `ny_server` VALUES (4, '5', 'S5', 'stat', NULL, 'start.sh', 'stop.sh', 0, 1691955889);
INSERT INTO `ny_server` VALUES (5, '2', 'S2', 'stat', NULL, 'start.sh', 'stop.sh', 0, 1691955889);

-- ----------------------------
-- Table structure for ny_server_rank_gift
-- ----------------------------
DROP TABLE IF EXISTS `ny_server_rank_gift`;
CREATE TABLE `ny_server_rank_gift`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `min` int(11) UNSIGNED NULL DEFAULT 0,
  `max` int(11) UNSIGNED NULL DEFAULT 0,
  `gifts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_server_rank_gift
-- ----------------------------

-- ----------------------------
-- Table structure for ny_shop_currency
-- ----------------------------
DROP TABLE IF EXISTS `ny_shop_currency`;
CREATE TABLE `ny_shop_currency`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double(50, 0) UNSIGNED NOT NULL,
  `amount` int(11) NOT NULL,
  `buy_with` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `display` tinyint(3) UNSIGNED NOT NULL COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_shop_currency
-- ----------------------------
INSERT INTO `ny_shop_currency` VALUES (1, '1 Vòng Quay', 'wheel', 50000, 1, 'coin_lock', NULL, 1, 0);

-- ----------------------------
-- Table structure for ny_shop_effect
-- ----------------------------
DROP TABLE IF EXISTS `ny_shop_effect`;
CREATE TABLE `ny_shop_effect`  (
  `id` int(11) NOT NULL,
  `name` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double(50, 0) UNSIGNED NOT NULL,
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_shop_effect
-- ----------------------------
INSERT INTO `ny_shop_effect` VALUES (1, 'Huyền Long', 100000, 'dragon-blue', 1, 0);
INSERT INTO `ny_shop_effect` VALUES (2, 'Ngọc Long', 100000, 'dragon-green', 1, 0);
INSERT INTO `ny_shop_effect` VALUES (3, 'Huyết Long', 100000, 'dragon-red', 1, 0);

-- ----------------------------
-- Table structure for ny_shop_item
-- ----------------------------
DROP TABLE IF EXISTS `ny_shop_item`;
CREATE TABLE `ny_shop_item`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double(50, 0) UNSIGNED NOT NULL,
  `amount` int(11) NOT NULL,
  `icon` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `thamso` int(11) NULL DEFAULT NULL,
  `item_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_shop_item
-- ----------------------------
INSERT INTO `ny_shop_item` VALUES (1, 'Linh Ngọc 50k', 50000, 50000, '1', 1, 1691380916, 0, '3:999999');
INSERT INTO `ny_shop_item` VALUES (2, 'Linh Ngọc 100k', 100000, 100000, '1', 1, 1691380921, 0, '3:999999');
INSERT INTO `ny_shop_item` VALUES (3, 'Linh Ngọc 200k', 200000, 200000, '1', 1, 1691380924, 0, '3:999999');
INSERT INTO `ny_shop_item` VALUES (4, 'Linh Ngọc 500k', 500000, 500000, '1', 1, 1691380926, 0, '3:999999');
INSERT INTO `ny_shop_item` VALUES (5, 'Linh Ngọc 1000k', 1000000, 1000000, '1', 1, 1691380928, 0, '3:999999');
INSERT INTO `ny_shop_item` VALUES (6, 'Kim Tệ x10M', 50000, 10000000, '2', 1, 1690881802, 0, '0:00');
INSERT INTO `ny_shop_item` VALUES (7, 'EXP Anh Hùng  x10M', 50000, 10000000, '3', 1, 1690881806, 0, '0:04');

-- ----------------------------
-- Table structure for ny_shop_recharge
-- ----------------------------
DROP TABLE IF EXISTS `ny_shop_recharge`;
CREATE TABLE `ny_shop_recharge`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double(50, 0) UNSIGNED NOT NULL,
  `max` double(50, 0) UNSIGNED NOT NULL DEFAULT 0,
  `save_pay_ingame` double(50, 0) UNSIGNED NULL DEFAULT 0,
  `icon` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `item_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_shop_recharge
-- ----------------------------
INSERT INTO `ny_shop_recharge` VALUES (1, 'Linh Ngọc 2', 100000, 2, 10000, '', 1, 1690779223, '3:999999');

-- ----------------------------
-- Table structure for ny_user
-- ----------------------------
DROP TABLE IF EXISTS `ny_user`;
CREATE TABLE `ny_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `vip` int(11) NOT NULL DEFAULT 0,
  `vip_exp` double(50, 0) UNSIGNED NULL DEFAULT 0,
  `login_day` int(11) NULL DEFAULT 0,
  `coin` double(50, 0) UNSIGNED NULL DEFAULT 0,
  `coin_lock` double(50, 0) UNSIGNED NULL DEFAULT 0,
  `diamond` double(50, 0) UNSIGNED NULL DEFAULT 0,
  `wheel` double(50, 0) UNSIGNED NULL DEFAULT 0,
  `spend_day` double(50, 0) NULL DEFAULT 0,
  `spend_month` double(50, 0) NULL DEFAULT 0,
  `spend_all` double(50, 0) NULL DEFAULT 0,
  `pay_day` double(50, 0) NULL DEFAULT 0,
  `pay_month` double(50, 0) NULL DEFAULT 0,
  `pay_all` double(50, 0) NULL DEFAULT 0,
  `referral_count` double(50, 0) NULL DEFAULT 0,
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `join_group` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0: False, 1: True',
  `join_zalo` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0: False, 1: True',
  `join_telegram` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0: False, 1: True',
  `get_gifts_referral` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0: False, 1: True',
  `effect` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'vip',
  `date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `month` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `year` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1253 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_user
-- ----------------------------
INSERT INTO `ny_user` VALUES (1, 'admin', 0, 180000, 2, 35153000, 0, 0, 190, 0, 0, 16427000, 0, 0, 180000, 0, 0, 0, 0, 0, 0, 'dragon-red', '03', '04', '2025', 1743664865);
INSERT INTO `ny_user` VALUES (1233, 'test11', 0, 0, 5, 39303000, 0, 0, 0, 0, 2450000, 2450000, 0, 0, 0, 0, 1742703591, 0, 0, 0, 0, 'vip', '29', '03', '2025', 1743265084);
INSERT INTO `ny_user` VALUES (1234, '234234', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1742786139, 0, 0, 0, 0, 'vip', '08', '04', '2025', 1744087220);
INSERT INTO `ny_user` VALUES (1235, 'test111', 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1742787061, 0, 0, 0, 0, 'vip', '25', '03', '2025', 1742883629);
INSERT INTO `ny_user` VALUES (1236, 'test12', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743249383, 0, 0, 0, 0, 'vip', '29', '03', '2025', 1743265574);
INSERT INTO `ny_user` VALUES (1237, '123123', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743251810, 0, 0, 0, 0, 'vip', '29', '03', '2025', 1743251813);
INSERT INTO `ny_user` VALUES (1238, 'lak000', 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743251824, 0, 0, 0, 0, 'vip', '05', '04', '2025', 1743861740);
INSERT INTO `ny_user` VALUES (1239, 'tungpuskin', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743252469, 0, 0, 0, 0, 'vip', '29', '03', '2025', 1743252478);
INSERT INTO `ny_user` VALUES (1240, 'shuichi', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743253123, 0, 0, 0, 0, 'vip', '01', '04', '2025', 1743504477);
INSERT INTO `ny_user` VALUES (1241, 'hoanghung', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743259084, 0, 0, 0, 0, 'vip', '05', '04', '2025', 1743848533);
INSERT INTO `ny_user` VALUES (1242, 'phucok', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743259579, 0, 0, 0, 0, 'vip', '01', '04', '2025', 1743503780);
INSERT INTO `ny_user` VALUES (1243, 'test13', 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743265589, 0, 0, 0, 0, 'vip', '04', '04', '2025', 1743740777);
INSERT INTO `ny_user` VALUES (1244, 'toan300', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743292839, 0, 0, 0, 0, 'vip', '30', '03', '2025', 1743292874);
INSERT INTO `ny_user` VALUES (1245, 'khanhlam', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743315309, 0, 0, 0, 0, 'vip', '30', '03', '2025', 1743319269);
INSERT INTO `ny_user` VALUES (1246, 'phucbaby', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743503932, 0, 0, 0, 0, 'vip', '01', '04', '2025', 1743503935);
INSERT INTO `ny_user` VALUES (1247, 'alex123', 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743509515, 0, 0, 0, 0, 'vip', '02', '04', '2025', 1743579998);
INSERT INTO `ny_user` VALUES (1248, 'thmodz', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743754740, 0, 0, 0, 0, 'vip', '04', '04', '2025', 1743754768);
INSERT INTO `ny_user` VALUES (1249, 'hihihi', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743840140, 0, 0, 0, 0, 'vip', '05', '04', '2025', 1743840143);
INSERT INTO `ny_user` VALUES (1250, '12345678h', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743860699, 0, 0, 0, 0, 'vip', '05', '04', '2025', 1743860733);
INSERT INTO `ny_user` VALUES (1251, 'oiconga123', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1743865804, 0, 0, 0, 0, 'vip', '05', '04', '2025', 1743865824);
INSERT INTO `ny_user` VALUES (1252, 'toan95', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1744024028, 0, 0, 0, 0, 'vip', '07', '04', '2025', 1744024401);

-- ----------------------------
-- Table structure for ny_vip
-- ----------------------------
DROP TABLE IF EXISTS `ny_vip`;
CREATE TABLE `ny_vip`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL DEFAULT 0,
  `need_exp` double(50, 0) UNSIGNED NULL DEFAULT 0,
  `discount_shop` int(11) NOT NULL DEFAULT 0 COMMENT 'percent of price',
  `pay_bonus` int(11) NOT NULL DEFAULT 0 COMMENT 'percent of pay',
  `referral_pay_bonus` int(11) NOT NULL DEFAULT 0 COMMENT 'percent of pay',
  `referral_bonus_coin` double(50, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'money',
  `pay_to_wheel` double(50, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '? Pay = 1 Wheel',
  `diamond_to_money` double(50, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1 Diamond = ? Money',
  `gifts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_vip
-- ----------------------------
INSERT INTO `ny_vip` VALUES (1, 0, 0, 0, 0, 1, 0, 20000, 0, '[]');
INSERT INTO `ny_vip` VALUES (2, 1, 500000, 2, 2, 2, 0, 20000, 1, '[]');
INSERT INTO `ny_vip` VALUES (3, 2, 2000000, 5, 5, 5, 0, 20000, 1, '[]');
INSERT INTO `ny_vip` VALUES (4, 3, 4000000, 5, 5, 5, 0, 20000, 1, '[]');
INSERT INTO `ny_vip` VALUES (5, 4, 8000000, 10, 10, 10, 5000, 15000, 1, '[]');
INSERT INTO `ny_vip` VALUES (6, 5, 15000000, 10, 10, 10, 5000, 15000, 1, '[]');
INSERT INTO `ny_vip` VALUES (7, 6, 30000000, 15, 15, 15, 10000, 15000, 1, '[]');
INSERT INTO `ny_vip` VALUES (8, 7, 50000000, 15, 15, 15, 10000, 10000, 1, '[]');
INSERT INTO `ny_vip` VALUES (9, 8, 100000000, 20, 20, 20, 20000, 10000, 1, '[]');
INSERT INTO `ny_vip` VALUES (10, 9, 150000000, 20, 20, 20, 20000, 5000, 1, '[]');
INSERT INTO `ny_vip` VALUES (11, 10, 200000000, 25, 25, 25, 30000, 5000, 1, '[]');

-- ----------------------------
-- Table structure for ny_wheel_gift
-- ----------------------------
DROP TABLE IF EXISTS `ny_wheel_gift`;
CREATE TABLE `ny_wheel_gift`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `amount` double(50, 0) UNSIGNED NOT NULL,
  `percent` float NOT NULL,
  `display` tinyint(3) UNSIGNED NOT NULL COMMENT '0: Hide, 1: Show',
  `update_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `item_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_wheel_gift
-- ----------------------------
INSERT INTO `ny_wheel_gift` VALUES (1, 'Mất lượt', 'unlucky', 0, 0.5, 1, 1691733678, '0');
INSERT INTO `ny_wheel_gift` VALUES (2, '5M Kim Tệ', 'item', 5000000, 0.2, 1, 1691398215, '0:00');
INSERT INTO `ny_wheel_gift` VALUES (3, '100k Linh Ngọc', 'item', 100000, 0.01, 1, 1691734025, '3');
INSERT INTO `ny_wheel_gift` VALUES (4, '5M EXP Anh Hùng', 'item', 5000000, 0.2, 1, 1691398242, '0:04');
INSERT INTO `ny_wheel_gift` VALUES (5, '200 Thú Bông', 'item', 200, 0.01, 1, 1691734034, '3');
INSERT INTO `ny_wheel_gift` VALUES (6, '500K Xu', 'coin', 500000, 0.0000001, 1, 1691733725, '0');
INSERT INTO `ny_wheel_gift` VALUES (7, '500K Xu khóa', 'coin_lock', 500000, 0.0000001, 1, 1691398237, '0');
INSERT INTO `ny_wheel_gift` VALUES (8, '2000 Phá Cảnh Đan', 'item', 2000, 0.00001, 1, 1691733736, '3');
INSERT INTO `ny_wheel_gift` VALUES (9, '50 Bình Hỗn Độn', 'item', 50, 0.001, 1, 1691734041, '3');
INSERT INTO `ny_wheel_gift` VALUES (10, 'Thêm lượt', 'wheel', 1, 0.3, 1, 0, NULL);

-- ----------------------------
-- Table structure for ny_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `ny_withdraw`;
CREATE TABLE `ny_withdraw`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `diamond` double(50, 0) UNSIGNED NOT NULL,
  `money` double(50, 0) UNSIGNED NOT NULL,
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `token` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '0: Wait, 1: Done, 2: Error',
  `verifier` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `verify_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ny_withdraw
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
