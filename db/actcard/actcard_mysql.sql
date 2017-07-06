/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50132
Source Host           : localhost:3306
Source Database       : jeesite

Target Server Type    : MYSQL
Target Server Version : 50132
File Encoding         : 65001

Date: 2017-05-24 04:23:09
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `actcard`
-- ----------------------------
DROP TABLE IF EXISTS `actcard`;
CREATE TABLE `actcard` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `proc_ins_id` varchar(64)  COMMENT '流程实例ID',
  `unsafe_acts` text NOT NULL COMMENT '不安全行为',
  `measure` text NOT NULL COMMENT '解决措施',
  `safety_acts` text COMMENT '安全行为',
  `suggestions` text COMMENT '建议',
  `reporter` varchar(255) NOT NULL COMMENT '填报人',
  `reporter_office` varchar(255) NOT NULL COMMENT '填报人单位',
  `reporting_time` datetime NOT NULL COMMENT '填报时间',
  `rectification_result` text COMMENT '整改结果',
  `closer` varchar(255) DEFAULT NULL COMMENT '关闭人',
  `close_time` datetime DEFAULT NULL COMMENT '关闭时间',
  `state` varchar(255) DEFAULT NULL COMMENT '状态',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  `territorial_office_id` varchar(64) DEFAULT NULL COMMENT '属地单位',
  `report_pic` varchar(1000) DEFAULT NULL COMMENT '上报时图片',
  `rectification_pic` varchar(1000) DEFAULT NULL COMMENT '整改图片',
  `actcard_unsafe_event_id` text COMMENT '不安全分类',
  `actcard_unsafe_event_child_id` text COMMENT '不安全分类子类',
  `solver` varchar(64) DEFAULT NULL COMMENT '整改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ACT卡';


-- ----------------------------
-- Table structure for `actcard_review`
-- ----------------------------
DROP TABLE IF EXISTS `actcard_review`;
CREATE TABLE `actcard_review` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `content` text COMMENT '评阅内容',
  `actcard_id` varchar(64) NOT NULL COMMENT '所评阅的ACT卡',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ACT卡评阅';

-- ----------------------------
-- Records of actcard_review
-- ----------------------------

-- ----------------------------
-- Table structure for `actcard_unsafe_event`
-- ----------------------------
DROP TABLE IF EXISTS `actcard_unsafe_event`;
CREATE TABLE `actcard_unsafe_event` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='不安全事件';

-- ----------------------------
-- Records of actcard_unsafe_event
-- ----------------------------
INSERT INTO actcard_unsafe_event VALUES ('0fc6cd98a6b14668afcc3b88b0f07a86', '0', '0,', '人员的位置 Location of personnel', '30', '1', '2017-05-23 23:08:35', '1', '2017-05-23 23:08:35', '', '0');
INSERT INTO actcard_unsafe_event VALUES ('15d29cb45a0147308fcf28efbc6c1015', '0', '0,', '工具与设备 Tools and facilities', '30', '1', '2017-05-23 23:10:41', '1', '2017-05-23 23:12:17', '', '0');
INSERT INTO actcard_unsafe_event VALUES ('2b1742b80dde4f89b161a1e7d86f04aa', '0fc6cd98a6b14668afcc3b88b0f07a86', '0,0fc6cd98a6b14668afcc3b88b0f07a86,', '碰撞到物体的危险 Risk to be collided by the object', '30', '1', '2017-05-23 23:09:44', '1', '2017-05-23 23:09:44', '', '0');
INSERT INTO actcard_unsafe_event VALUES ('661573de7ff5454caf13723ce0239921', '15d29cb45a0147308fcf28efbc6c1015', '0,15d29cb45a0147308fcf28efbc6c1015,', '使用不正确的工具与设备 Use of improper tools and facilities', '30', '1', '2017-05-23 23:11:56', '1', '2017-05-23 23:11:56', '', '0');
INSERT INTO actcard_unsafe_event VALUES ('70a02d34961a4d37adda86521bd974ce', '0', '0,', '避险路线 Eseape way', '30', '1', '2017-05-23 23:13:05', '1', '2017-05-23 23:13:05', '', '0');
INSERT INTO actcard_unsafe_event VALUES ('98b0115db1cf4ca5bf24bf6378ecaf1d', '70a02d34961a4d37adda86521bd974ce', '0,70a02d34961a4d37adda86521bd974ce,', '避险路线不合适 Improper escape way', '30', '1', '2017-05-23 23:13:34', '1', '2017-05-23 23:14:09', '', '0');
INSERT INTO actcard_unsafe_event VALUES ('e6d3776499e742009438d1322b7c5308', 'edff93f6dd7b42df9875a2323a2e15c4', '0,edff93f6dd7b42df9875a2323a2e15c4,', '头部 Head', '30', '1', '2017-05-23 23:08:04', '1', '2017-05-23 23:08:04', '', '0');
INSERT INTO actcard_unsafe_event VALUES ('edff93f6dd7b42df9875a2323a2e15c4', '0', '0,', '个人安全防护装备 PPE', '30', '1', '2017-05-23 23:07:44', '1', '2017-05-23 23:07:44', '', '0');
