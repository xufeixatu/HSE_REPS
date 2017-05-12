/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : hse

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2017-05-12 23:04:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `msg_message`
-- ----------------------------
DROP TABLE IF EXISTS `msg_message`;
CREATE TABLE `msg_message` (
  `messageId` varchar(50) NOT NULL,
  `text` varchar(50) DEFAULT NULL,
  `avatarPath` varchar(100) DEFAULT NULL,
  `filePath` varchar(100) DEFAULT NULL,
  `thumbPath` varchar(100) DEFAULT NULL,
  `messageType` varchar(50) DEFAULT NULL,
  `nativePath` varchar(100) DEFAULT NULL,
  `conversationType` varchar(50) DEFAULT NULL,
  `objectName` varchar(50) DEFAULT NULL,
  `sendUserId` varchar(50) DEFAULT NULL,
  `messageDirection` varchar(50) DEFAULT NULL,
  `receivedId` varchar(50) NOT NULL,
  `sendTime` varchar(50) DEFAULT NULL,
  `receivedTime` varchar(50) DEFAULT NULL,
  `sendStatus` varchar(50) DEFAULT NULL,
  `taskUrl` varchar(100) DEFAULT NULL,
  `taskStatus` varchar(50) DEFAULT NULL,
  `taskTitle` varchar(500) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '0' COMMENT '删除标记'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of msg_message
-- ----------------------------
INSERT INTO `msg_message` VALUES ('1', '2', '3', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1017-05-09 04:30:04', null, null, null, '0');
INSERT INTO `msg_message` VALUES ('2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2', '2217-05-09 04:30:20', '2', '2017-05-09 04:30:20', '2', '2');
INSERT INTO `msg_message` VALUES ('3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', '3', null, null, null, null, '0');
INSERT INTO `msg_message` VALUES ('4', '4', '4', '4', '4', '4', '4', '4', '4', '4', '4', '4', '4', '4', '4', '4', '4', '4', '4', null, null, null, null, null, '0');

-- ----------------------------
-- Table structure for `msg_user`
-- ----------------------------
DROP TABLE IF EXISTS `msg_user`;
CREATE TABLE `msg_user` (
  `userId` varchar(50) NOT NULL,
  `userName` varchar(50) DEFAULT NULL,
  `loginName` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `avatarUrl` varchar(100) DEFAULT NULL,
  `avatarUrlNative` varchar(100) DEFAULT NULL,
  `avatarFile` varchar(100) DEFAULT NULL,
  `groupId` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `token` varchar(300) DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of msg_user
-- ----------------------------
INSERT INTO `msg_user` VALUES ('0', 'username-0', 'loginname-0', 'password-0', 'avatarUrl-0', 'avatarUrlNative-0', 'avatarFile-0', null, 'remark-0', 'token-0', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('1', 'username-1', 'loginname-1', 'password-1', 'avatarUrl-1', 'avatarUrlNative-1', 'avatarFile-1', null, 'remark-1', 'token-1', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('2', 'username-2', 'loginname-2', 'password-2', 'avatarUrl-2', 'avatarUrlNative-2', 'avatarFile-2', null, 'remark-2', 'token-2', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('3', 'username-3', 'loginname-3', 'password-3', 'avatarUrl-3', 'avatarUrlNative-3', 'avatarFile-3', null, 'remark-3', 'token-3', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('4', 'username-4', 'loginname-4', 'password-4', 'avatarUrl-4', 'avatarUrlNative-4', 'avatarFile-4', null, 'remark-4', 'token-4', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('5', 'username-5', 'loginname-5', 'password-5', 'avatarUrl-5', 'avatarUrlNative-5', 'avatarFile-5', null, 'remark-5', 'token-5', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('6', 'username-6', 'loginname-6', 'password-6', 'avatarUrl-6', 'avatarUrlNative-6', 'avatarFile-6', null, 'remark-6', 'token-6', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('7', 'username-7', 'loginname-7', 'password-7', 'avatarUrl-7', 'avatarUrlNative-7', 'avatarFile-7', null, 'remark-7', 'token-7', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('8', 'username-8', 'loginname-8', 'password-8', 'avatarUrl-8', 'avatarUrlNative-8', 'avatarFile-8', null, 'remark-8', 'token-8', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('9', 'username-9', 'loginname-9', 'password-9', 'avatarUrl-9', 'avatarUrlNative-9', 'avatarFile-9', null, 'remark-9', 'token-9', null, null, null, null, null, '0');
INSERT INTO `msg_user` VALUES ('1111', 'jiachao', null, '1111', 'www', null, null, null, null, 'rbiH+tkHvnLbYxN+7v5ZQJnCRKPUm7NGvky+97GOmLct45cijY96ojF8xKypRPn+j8IAtid0nzVUsD2PLHifrQ==', null, null, null, null, null, '0');
