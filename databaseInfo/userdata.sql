/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : userdata

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 11/06/2020 10:08:45
*/

CREATE DATABASE userdata;
USE userdata;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for girl
-- ----------------------------
DROP TABLE IF EXISTS `girl`;
CREATE TABLE `girl`  (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `cup_size` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `age` int(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 123 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of girl
-- ----------------------------
INSERT INTO `girl` VALUES (1, 'a', 12);
INSERT INTO `girl` VALUES (2, 'b', 22);
INSERT INTO `girl` VALUES (3, 'c', 32);
INSERT INTO `girl` VALUES (123, 'abc', 50);

-- ----------------------------
-- Table structure for shoes
-- ----------------------------
DROP TABLE IF EXISTS `shoes`;
CREATE TABLE `shoes`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `size` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` int(11) NULL DEFAULT NULL,
  `photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `up` int(11) NULL DEFAULT NULL,
  `down` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shoes
-- ----------------------------
INSERT INTO `shoes` VALUES (1, 'addidas', '8', 188, 'images/product4.jpeg', 10, 1);
INSERT INTO `shoes` VALUES (2, 'addidas', '9', 218, 'images/product5.jpeg', 0, 0);
INSERT INTO `shoes` VALUES (3, 'nike', '11', 368, 'images/product6.jpeg', 0, 0);
INSERT INTO `shoes` VALUES (4, 'nike', '10', 228, 'images/product7.jpeg', 0, 0);
INSERT INTO `shoes` VALUES (5, 'nike', '13', 368, 'images/product8.jpeg', 1, 1);
INSERT INTO `shoes` VALUES (6, 'nike', '8', 118, 'images/product9.png', 0, 0);
INSERT INTO `shoes` VALUES (7, 'nike', '7', 388, 'images/product10.jpeg', 0, 0);
INSERT INTO `shoes` VALUES (8, 'addidas', '10', 488, 'images/product11.jpeg', 0, 0);
INSERT INTO `shoes` VALUES (9, 'addidas', '12', 588, 'images/product12.jpeg', 0, 0);
INSERT INTO `shoes` VALUES (10, 'addidas', '13', 88, 'images/product13.jpeg', 0, 0);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `passward` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `time` datetime(0) NULL DEFAULT NULL,
  `checked` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `unchecked` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `billing` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'sht668', '\"E10ADC3949BA59ABBE56E057F20F883E\"', 'sht668@usask.ca', '2019-04-08 17:18:37', '[{\"check\":\"[{\\\"shoe\\\":\\\"1\\\"},{\\\"shoe\\\":\\\"2\\\"},{\\\"shoe\\\":\\\"3\\\"}]\"},{\"check\":\"[{\\\"shoe\\\":\\\"4\\\"},{\\\"shoe\\\":\\\"3\\\"}]\"}]', '[{\"shoe\":\"5\"},{\"shoe\":\"1\"},{\"shoe\":\"10\"}]', '{\"firstname\":\"shi\",\"address\":\"street\",\"postal\":\"123456\",\"lastname\":\"tang\"}');

SET FOREIGN_KEY_CHECKS = 1;
