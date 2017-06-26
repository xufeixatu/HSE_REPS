/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : hse

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2017-05-12 23:04:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `risk_access`
-- ----------------------------
DROP TABLE IF EXISTS `risk_access`;
CREATE TABLE `risk_access` (
  `id` varchar(64) NOT NULL COMMENT '危害辨识项ID',
  `number` varchar(255) DEFAULT NULL COMMENT '编号',
  `years` date DEFAULT NULL COMMENT '年份',
  `unit` varchar(255) DEFAULT NULL COMMENT '属地单位',
  `recognize_by` varchar(255) DEFAULT NULL COMMENT '辨识人',
  `recognize_date` datetime DEFAULT NULL COMMENT '辨识时间',
  `risk_type` varchar(255) DEFAULT NULL COMMENT '风险类型',
  `category` varchar(255) DEFAULT NULL COMMENT '类别',
  `place_device` varchar(255) DEFAULT NULL COMMENT '场所、设备',
  `risk_name` varchar(255) DEFAULT NULL COMMENT '风险名称(环境因素名称/安全风险名称)',
  `work_name` varchar(255) DEFAULT NULL COMMENT '作业活动名称/活动、物料、产品、服务',
  `risk_factors` varchar(255) DEFAULT NULL COMMENT '危害因素（危险源）',
  `tense` varchar(1) DEFAULT NULL COMMENT '时态',
  `status` varchar(1) DEFAULT NULL COMMENT '状态',
  `result` varchar(255) DEFAULT NULL COMMENT '可能导致的后果',
  `judge_tf` varchar(255) DEFAULT NULL COMMENT '是非判断',
  `accessID` varchar(64) DEFAULT NULL COMMENT '评价结果ID',
  `is_heaverisk` varchar(255) DEFAULT NULL COMMENT '是否重大风险',
  `lastyear_recognize` varchar(255) DEFAULT NULL COMMENT '对应上年度的辨识项',
  `risk_level` varchar(255) DEFAULT NULL COMMENT '风险等级',
  `workflowID` varchar(64) DEFAULT NULL COMMENT '工作流实例ID',
  `duty_unit` varchar(255) DEFAULT NULL COMMENT '责任单位',
  `management_plan` varchar(255) DEFAULT NULL COMMENT '对应管理方案',
  `affect` varchar(255) DEFAULT NULL COMMENT '影响（可能导致的事故、环境影响）',
  `measure` varchar(255) DEFAULT NULL COMMENT '措施（采取的消减、控制措施，现有控制方法）',
  `frequency` varchar(255) DEFAULT NULL COMMENT '排放频率',
  `reason` varchar(255) DEFAULT NULL COMMENT '触发原因',
  `reserve_1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `reserve_2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `reserve_3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(255) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of risk_access
-- ----------------------------
INSERT INTO `risk_access` VALUES ('81044aa088ad4031aed2dddbcc61330d', '1', '2017-05-01', '1', '1', '2017-05-01 22:27:14', '0', '0', '', '1', '1', '1', '0', '0', '1', '0', '1', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '2017-05-10 22:27:30', '1', '2017-05-10 22:27:30', '1', '0');
INSERT INTO `risk_access` VALUES ('e978b6399c224497b235c3351ebb5b72', null, null, null, null, null, '0', '0', '1号钻井平台', '钻井作业', '钻井作业', '漏水', '1', '3', '浪费水源', '0', '', null, '', '', '', '', '', '', '', '1', '', null, null, null, '1', '2017-05-11 21:28:12', '1', '2017-05-11 21:28:12', '', '0');

-- ----------------------------
-- Table structure for `risk_envirresult`
-- ----------------------------
DROP TABLE IF EXISTS `risk_envirresult`;
CREATE TABLE `risk_envirresult` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `recognizeID` varchar(64) DEFAULT NULL COMMENT '危害辨识项ID',
  `LScore` varchar(255) DEFAULT NULL COMMENT 'L得分',
  `SScore` varchar(255) DEFAULT NULL COMMENT 'S得分',
  `MScore` varchar(255) DEFAULT NULL COMMENT '风险程度M得分',
  `assess_by` varchar(255) DEFAULT NULL COMMENT '评价人',
  `assess_date` datetime DEFAULT NULL COMMENT '评价时间',
  `assess_result` varchar(255) DEFAULT NULL COMMENT '评价结果',
  `risk_level` varchar(255) DEFAULT NULL COMMENT '风险等级',
  `reserve_1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `reserve_2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` datetime DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(255) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of risk_envirresult
-- ----------------------------

-- ----------------------------
-- Table structure for `risk_saferesult`
-- ----------------------------
DROP TABLE IF EXISTS `risk_saferesult`;
CREATE TABLE `risk_saferesult` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `recognizeID` varchar(64) DEFAULT NULL COMMENT '危害辨识项ID',
  `LScore` varchar(255) DEFAULT NULL COMMENT 'L得分',
  `EScore` varchar(255) DEFAULT NULL COMMENT 'E得分',
  `CScore` varchar(255) DEFAULT NULL COMMENT 'C得分',
  `DScore` varchar(255) DEFAULT NULL COMMENT '危险值D得分',
  `assess_by` varchar(255) DEFAULT NULL COMMENT '评价人',
  `assess_date` datetime DEFAULT NULL COMMENT '评价时间',
  `assess_result` varchar(255) DEFAULT NULL COMMENT '评价结果',
  `risk_level` varchar(255) DEFAULT NULL COMMENT '风险等级',
  `reserve_1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `reserve_2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` datetime DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(255) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of risk_saferesult
-- ----------------------------
