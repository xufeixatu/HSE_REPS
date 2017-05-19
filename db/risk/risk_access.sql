/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : hse

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2017-05-20 00:00:08
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
INSERT INTO `risk_access` VALUES ('0f4bc700d98548c9b9a0b318e1ab6f68', null, null, null, null, null, '0', '0', '测试方', '测试方', '测试方', '测试方', '0', '0', '测试方', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '2017-05-19 21:27:55', '1', '2017-05-19 21:27:55', '测试方', '0');
INSERT INTO `risk_access` VALUES ('582f21ec156449b2ba152c0690850c32', null, null, null, null, null, '0', '0', '大汽车', '大汽车运输路面不咋地', '大汽车运输路面不咋地', '大汽车运输路面不咋地', '1', '3', '大汽车运输路面不咋地', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '2017-05-19 19:31:21', '1', '2017-05-19 19:31:21', '', '0');
INSERT INTO `risk_access` VALUES ('81044aa088ad4031aed2dddbcc61330d', '1', '2017-05-01', '1', '1', '2017-05-01 22:27:14', '0', '0', '', '1', '1', '1', '0', '0', '1', '0', '1', '0', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '2017-05-10 22:27:30', '1', '2017-05-10 22:27:30', '1', '0');
INSERT INTO `risk_access` VALUES ('913f02c0a61e46009c425906428cad6a', null, null, null, null, null, '0', '0', 'test4', 'test4', 'test4', 'test4', '1', '3', 'test4', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '2017-05-19 23:23:44', '1', '2017-05-19 23:23:44', 'test4', '0');
INSERT INTO `risk_access` VALUES ('bc1b647d2468485791d2d6fd2c48999f', null, null, null, null, null, '0', '5', 'test5', 'test5', 'test5', 'test5', '0', '0', 'test5', '1', '2004f11fead64fe2b32cb9c9fcc42195', null, null, '3', null, null, null, null, null, null, null, null, null, null, '1', '2017-05-19 23:30:05', '1', '2017-05-19 23:30:05', 'test5', '0');
INSERT INTO `risk_access` VALUES ('d135b1e3f4da4a838f2edd3beb1b04b4', null, null, null, null, null, '0', '0', 'riskType', 'riskType', 'riskType', 'riskType', '0', '0', 'riskType', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '2017-05-19 19:50:06', '1', '2017-05-19 19:50:06', 'riskType', '0');
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
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(255) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of risk_saferesult
-- ----------------------------
INSERT INTO `risk_saferesult` VALUES ('02ca6b9c2898423e8ffcaabe96af87b1', '9d7efa6715ea4c9b883016c1a3114e1a', '0.1', '0.5', '1', '0.05', null, null, null, '1', null, null, '1', '2017-05-19 21:46:43', '1', '2017-05-19 21:46:43', null, '0');
INSERT INTO `risk_saferesult` VALUES ('1b5849b56fab4f9b819640b29c5db483', '913f02c0a61e46009c425906428cad6a', '0.2', '0.5', '7', '0.7', null, null, null, '1', null, null, '1', '2017-05-19 23:23:44', '1', '2017-05-19 23:23:44', null, '0');
INSERT INTO `risk_saferesult` VALUES ('2004f11fead64fe2b32cb9c9fcc42195', 'bc1b647d2468485791d2d6fd2c48999f', '0.2', '10', '40', '80.0', null, null, null, '3', null, null, '1', '2017-05-19 23:30:05', '1', '2017-05-19 23:30:05', null, '0');
INSERT INTO `risk_saferesult` VALUES ('b367e80ea37b42528242f07bcfe5cf15', '0d213bb1eede45f1bafdf5db0eb3a8cd', '0.1', '0.5', '4', '0.2', null, null, null, '1', null, null, '1', '2017-05-19 22:15:44', '1', '2017-05-19 22:15:44', null, '0');
INSERT INTO `risk_saferesult` VALUES ('bf880fadc6744af182ce7ec85f2a31a2', '00db34d5198448879c2547c630e9f3b1', '3', '0.5', '1', '1.5', null, null, null, '1', null, null, '1', '2017-05-19 21:52:47', '1', '2017-05-19 21:52:47', null, '0');

-- ----------------------------
-- Table structure for `sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `value` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `label` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `type` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '类型',
  `description` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `parent_id` varchar(64) COLLATE utf8_bin DEFAULT '0' COMMENT '父级编号',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('0ae02043aa8b4a6891c429823059cc5b', '1', '一年一次', 'emission_frequency', '排放频率', '10', '0', '1', '2017-05-11 21:25:09', '1', '2017-05-11 21:25:46', '排放频率', '0');
INSERT INTO `sys_dict` VALUES ('0af65bebb9244259bdc5f9dad2db7585', '6', '每天工作时间内暴露', 'risk_escore', '可能性', '30', '0', '1', '2017-05-19 18:53:39', '1', '2017-05-19 18:53:39', '', '0');
INSERT INTO `sys_dict` VALUES ('0cfa2555cebc45c4ad90ce55d0c17189', '7', '可能性小，完全意外（1次/10年）', 'risk_cscore', '可能性', '60', '0', '1', '2017-05-19 18:58:21', '1', '2017-05-19 18:58:21', '', '0');
INSERT INTO `sys_dict` VALUES ('0dce844eeaa843d4be6565dec8114e82', '1', '异常', 'status_Type', '异常', '20', '0', '1', '2017-05-10 16:12:51', '1', '2017-05-10 16:12:51', '状态异常', '0');
INSERT INTO `sys_dict` VALUES ('0f70c66fdbe14a3cab24043125c294a3', '4', '很不可能，可以设想（1次/20年）', 'risk_cscore', '可能性', '70', '0', '1', '2017-05-19 18:58:47', '1', '2017-05-19 18:58:47', '', '0');
INSERT INTO `sys_dict` VALUES ('1', '0', '正常', 'del_flag', '删除标记', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('10', 'yellow', '黄色', 'color', '颜色值', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('100', 'java.util.Date', 'Date', 'gen_java_type', 'Java类型', '50', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('101', 'com.thinkgem.HSE.modules.sys.entity.User', 'User', 'gen_java_type', 'Java类型', '60', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('102', 'com.thinkgem.HSE.modules.sys.entity.Office', 'Office', 'gen_java_type', 'Java类型', '70', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('103', 'com.thinkgem.HSE.modules.sys.entity.Area', 'Area', 'gen_java_type', 'Java类型', '80', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('104', 'Custom', 'Custom', 'gen_java_type', 'Java类型', '90', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('105', '1', '会议通告\0\0', 'oa_notify_type', '通知通告类型', '10', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('106', '2', '奖惩通告\0\0', 'oa_notify_type', '通知通告类型', '20', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('107', '3', '活动通告\0\0', 'oa_notify_type', '通知通告类型', '30', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('108', '0', '草稿', 'oa_notify_status', '通知通告状态', '10', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('109', '1', '发布', 'oa_notify_status', '通知通告状态', '20', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('11', 'orange', '橙色', 'color', '颜色值', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('110', '0', '未读', 'oa_notify_read', '通知通告状态', '10', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('111', '1', '已读', 'oa_notify_read', '通知通告状态', '20', '0', '1', '2013-11-08 08:00:00', '1', '2013-11-08 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('12', 'default', '默认主题', 'theme', '主题方案', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('13', 'cerulean', '天蓝主题', 'theme', '主题方案', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('132fd9f7d0304acd9eacda75682b1dc6', '1', '可能性小，完全意外（1次/10年）', 'risk_lscore', '可能性', '30', '0', '1', '2017-05-19 18:49:46', '1', '2017-05-19 18:49:46', '', '0');
INSERT INTO `sys_dict` VALUES ('14', 'readable', '橙色主题', 'theme', '主题方案', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('15', 'united', '红色主题', 'theme', '主题方案', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('15e1e8e2860e4aaa914350fe96f9cfb6', '5', '相关方', 'risk_class', '相关方', '20', '0', '1', '2017-05-10 17:18:08', '1', '2017-05-10 17:18:08', '相关方', '0');
INSERT INTO `sys_dict` VALUES ('16', 'flat', 'Flat主题', 'theme', '主题方案', '60', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('17', '1', '国家', 'sys_area_type', '区域类型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('18', '2', '省份、直辖市', 'sys_area_type', '区域类型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('1853c6b760a8439a9738973a17a537f5', '1', '开停车过程', 'risk_class', '开停车过程', '20', '0', '1', '2017-05-10 17:17:01', '1', '2017-05-10 17:17:01', '开停车过程', '0');
INSERT INTO `sys_dict` VALUES ('19', '3', '地市', 'sys_area_type', '区域类型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('192c289a917d4383b78ecb3fdb366d40', '4', '四级风险', 'risk_level', '四级风险', '30', '0', '1', '2017-05-19 23:36:01', '1', '2017-05-19 23:36:01', '', '0');
INSERT INTO `sys_dict` VALUES ('1e7faf0ec5ce49d7aa4e72c49b8a03d0', '40', '相当可能（1次/6个月）', 'risk_cscore', '可能性', '40', '0', '1', '2017-05-19 18:57:35', '1', '2017-05-19 18:57:35', '', '0');
INSERT INTO `sys_dict` VALUES ('2', '1', '删除', 'del_flag', '删除标记', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('20', '4', '区县', 'sys_area_type', '区域类型', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('21', '1', '公司', 'sys_office_type', '机构类型', '60', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('21c1e65f06bf4f21b19c5c52b6e13b69', '100', '完全可以预料（1次/周）', 'risk_cscore', '可能性', '30', '0', '1', '2017-05-19 18:57:20', '1', '2017-05-19 18:57:20', '', '0');
INSERT INTO `sys_dict` VALUES ('22', '2', '部门', 'sys_office_type', '机构类型', '70', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('23', '3', '小组', 'sys_office_type', '机构类型', '80', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('24', '4', '其它', 'sys_office_type', '机构类型', '90', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('25', '1', '综合部', 'sys_office_common', '快捷通用部门', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('26', '2', '开发部', 'sys_office_common', '快捷通用部门', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('27', '3', '人力部', 'sys_office_common', '快捷通用部门', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('28', '1', '一级', 'sys_office_grade', '机构等级', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('29', '2', '二级', 'sys_office_grade', '机构等级', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('295deabaed904f81835290a7009b8d3c', '1', '重大风险', 'heave_flag', '是否重大', '20', '0', '1', '2017-05-19 12:06:51', '1', '2017-05-19 12:06:51', '是否重大', '0');
INSERT INTO `sys_dict` VALUES ('29acf5d880cc43ec87472763f775034d', '1', '环境类型', 'risk_Type', '环境类型', '20', '0', '1', '2017-05-10 15:25:32', '1', '2017-05-10 15:25:43', '', '0');
INSERT INTO `sys_dict` VALUES ('2b83d617dc314c18822a65a8959785ba', '0', '正常', 'status_Type', '正常', '10', '0', '1', '2017-05-10 16:12:05', '1', '2017-05-10 16:13:12', '状态正常', '0');
INSERT INTO `sys_dict` VALUES ('2ef97143d647449bbf266bbba18ac3a1', '1', '一级风险', 'risk_level', '一级风险', '10', '0', '1', '2017-05-10 17:16:36', '1', '2017-05-19 23:35:27', '一级风险', '0');
INSERT INTO `sys_dict` VALUES ('3', '1', '显示', 'show_hide', '显示/隐藏', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('30', '3', '三级', 'sys_office_grade', '机构等级', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('31', '4', '四级', 'sys_office_grade', '机构等级', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('311ec7b84a02436b9d57326198cfe6b3', '3', '紧急情况下', 'risk_class', '紧急情况下', '40', '0', '1', '2017-05-10 17:17:40', '1', '2017-05-10 17:17:40', '紧急情况下', '0');
INSERT INTO `sys_dict` VALUES ('3195dd836ea64745bb0c8fe606b03a35', '0.5', '很不可能，可以设想（1次/20年）', 'risk_lscore', '可能性', '40', '0', '1', '2017-05-19 18:51:38', '1', '2017-05-19 18:51:38', '', '0');
INSERT INTO `sys_dict` VALUES ('32', '1', '所有数据', 'sys_data_scope', '数据范围', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('33', '2', '所在公司及以下数据', 'sys_data_scope', '数据范围', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('34', '3', '所在公司数据', 'sys_data_scope', '数据范围', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('35', '4', '所在部门及以下数据', 'sys_data_scope', '数据范围', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('36', '5', '所在部门数据', 'sys_data_scope', '数据范围', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('37', '8', '仅本人数据', 'sys_data_scope', '数据范围', '90', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('38', '9', '按明细设置', 'sys_data_scope', '数据范围', '100', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('39', '1', '系统管理', 'sys_user_type', '用户类型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('4', '0', '隐藏', 'show_hide', '显示/隐藏', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('40', '2', '部门经理', 'sys_user_type', '用户类型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('40f71992ba0848689000cf64c8f9e164', '0.1', '实际不可能', 'risk_lscore', '可能性', '60', '0', '1', '2017-05-19 18:52:23', '1', '2017-05-19 18:52:23', '', '0');
INSERT INTO `sys_dict` VALUES ('41', '3', '普通用户', 'sys_user_type', '用户类型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('42', 'basic', '基础主题', 'cms_theme', '站点主题', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('43', 'blue', '蓝色主题', 'cms_theme', '站点主题', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('44', 'red', '红色主题', 'cms_theme', '站点主题', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('45', 'article', '文章模型', 'cms_module', '栏目模型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('46', 'picture', '图片模型', 'cms_module', '栏目模型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('47', 'download', '下载模型', 'cms_module', '栏目模型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('48', 'link', '链接模型', 'cms_module', '栏目模型', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('49', 'special', '专题模型', 'cms_module', '栏目模型', '50', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('4944a2b7606f4885b9987f75f941201c', '4', '办公过程', 'risk_class', '办公过程', '50', '0', '1', '2017-05-10 17:17:53', '1', '2017-05-10 17:17:53', '办公过程', '0');
INSERT INTO `sys_dict` VALUES ('4b1aac767b474a60b717ac9c63056543', '2', '每月一次暴露', 'risk_escore', '可能性', '50', '0', '1', '2017-05-19 18:54:20', '1', '2017-05-19 18:54:20', '', '0');
INSERT INTO `sys_dict` VALUES ('5', '1', '是', 'yes_no', '是/否', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('50', '0', '默认展现方式', 'cms_show_modes', '展现方式', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('51', '1', '首栏目内容列表', 'cms_show_modes', '展现方式', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('52', '2', '栏目第一条内容', 'cms_show_modes', '展现方式', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('53', '0', '发布', 'cms_del_flag', '内容状态', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('54', '1', '删除', 'cms_del_flag', '内容状态', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('5443edcec9584fd8b4f6c82bd21a06c6', '1', '是', 'is_flag', '是非判断', '10', '0', '1', '2017-05-19 19:29:14', '1', '2017-05-19 19:29:32', '', '0');
INSERT INTO `sys_dict` VALUES ('55', '2', '审核', 'cms_del_flag', '内容状态', '15', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('56', '1', '首页焦点图', 'cms_posid', '推荐位', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('57', '2', '栏目页文章推荐', 'cms_posid', '推荐位', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('58', '1', '咨询', 'cms_guestbook', '留言板分类', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('59', '2', '建议', 'cms_guestbook', '留言板分类', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('5a7e480f269942d8b8237ad1ad0f9e80', '0', '否', 'is_flag', '是非判断', '20', '0', '1', '2017-05-19 19:29:25', '1', '2017-05-19 19:29:36', '', '0');
INSERT INTO `sys_dict` VALUES ('5b570f374cd14440a1f11237d4ca2ae5', '10', '连续暴露', 'risk_escore', '可能性', '20', '0', '1', '2017-05-19 18:53:20', '1', '2017-05-19 18:53:20', '人员暴露的频繁程度（E）', '0');
INSERT INTO `sys_dict` VALUES ('5d41b01bbd0a49d9a7d655a00d75d2f2', '5', '五级风险', 'risk_level', '五级风险', '40', '0', '1', '2017-05-19 23:36:41', '1', '2017-05-19 23:36:41', '', '0');
INSERT INTO `sys_dict` VALUES ('6', '0', '否', 'yes_no', '是/否', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('60', '3', '投诉', 'cms_guestbook', '留言板分类', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('61', '4', '其它', 'cms_guestbook', '留言板分类', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('62', '1', '公休', 'oa_leave_type', '请假类型', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('63', '2', '病假', 'oa_leave_type', '请假类型', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('64', '3', '事假', 'oa_leave_type', '请假类型', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('65', '4', '调休', 'oa_leave_type', '请假类型', '40', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('66', '5', '婚假', 'oa_leave_type', '请假类型', '60', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('67', '1', '接入日志', 'sys_log_type', '日志类型', '30', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('68', '2', '异常日志', 'sys_log_type', '日志类型', '40', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('69', 'leave', '请假流程', 'act_type', '流程类型', '10', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('7', 'red', '红色', 'color', '颜色值', '10', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('70', 'test_audit', '审批测试流程', 'act_type', '流程类型', '20', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('71', '1', '分类1', 'act_category', '流程分类', '10', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('72', '2', '分类2', 'act_category', '流程分类', '20', '0', '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('73', 'crud', '增删改查', 'gen_category', '代码生成分类', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('74', 'crud_many', '增删改查（包含从表）', 'gen_category', '代码生成分类', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('75', 'tree', '树结构', 'gen_category', '代码生成分类', '30', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('76', '=', '=', 'gen_query_type', '查询方式', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('77', '!=', '!=', 'gen_query_type', '查询方式', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('78', '&gt;', '&gt;', 'gen_query_type', '查询方式', '30', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('79', '&lt;', '&lt;', 'gen_query_type', '查询方式', '40', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('79d34c4803454a398adc566887cf0f72', '6', '相当可能（6月/次）', 'risk_lscore', '可能性', '20', '0', '1', '2017-05-19 18:48:19', '1', '2017-05-19 18:48:19', '', '0');
INSERT INTO `sys_dict` VALUES ('8', 'green', '绿色', 'color', '颜色值', '20', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('80', 'between', 'Between', 'gen_query_type', '查询方式', '50', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('81', 'like', 'Like', 'gen_query_type', '查询方式', '60', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('82', 'left_like', 'Left Like', 'gen_query_type', '查询方式', '70', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('83', 'right_like', 'Right Like', 'gen_query_type', '查询方式', '80', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('84', 'input', '文本框', 'gen_show_type', '字段生成方案', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('85', 'textarea', '文本域', 'gen_show_type', '字段生成方案', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('86', 'select', '下拉框', 'gen_show_type', '字段生成方案', '30', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('867ba624e0524927891e540e3c5b0cf3', '0.5', '非常罕见的暴露（&lt;1次/年）', 'risk_escore', '可能性', '70', '0', '1', '2017-05-19 18:55:35', '1', '2017-05-19 18:55:35', '', '0');
INSERT INTO `sys_dict` VALUES ('87', 'checkbox', '复选框', 'gen_show_type', '字段生成方案', '40', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('88', 'radiobox', '单选框', 'gen_show_type', '字段生成方案', '50', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('89', 'dateselect', '日期选择', 'gen_show_type', '字段生成方案', '60', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('8c6da911931a4df6ac9fe24dc3577b11', '10', '完全可以预料(1次/周)', 'risk_lscore', '可能性', '10', '0', '1', '2017-05-19 18:47:41', '1', '2017-05-19 18:48:53', '', '0');
INSERT INTO `sys_dict` VALUES ('8c729d15ee144545818449662adadd48', '0', '安全风险', 'risk_Type', '安全风险', '10', '0', '1', '2017-05-10 15:25:15', '1', '2017-05-10 15:25:15', '', '0');
INSERT INTO `sys_dict` VALUES ('9', 'blue', '蓝色', 'color', '颜色值', '30', '0', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('90', 'userselect', '人员选择', 'gen_show_type', '字段生成方案', '70', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('91', 'officeselect', '部门选择', 'gen_show_type', '字段生成方案', '80', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('92', 'areaselect', '区域选择', 'gen_show_type', '字段生成方案', '90', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('93', 'String', 'String', 'gen_java_type', 'Java类型', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('94', 'Long', 'Long', 'gen_java_type', 'Java类型', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('95', 'dao', '仅持久层', 'gen_category', '代码生成分类\0\0\0\0', '40', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('96', '1', '男', 'sex', '性别', '10', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('97', '2', '女', 'sex', '性别', '20', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '0');
INSERT INTO `sys_dict` VALUES ('97d92f85f8a743efa3a802a9b5ad0228', '2', '二级风险', 'risk_level', '一级风险', '20', '0', '1', '2017-05-19 23:35:37', '1', '2017-05-19 23:35:37', '', '0');
INSERT INTO `sys_dict` VALUES ('98', 'Integer', 'Integer', 'gen_java_type', 'Java类型', '30', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('99', 'Double', 'Double', 'gen_java_type', 'Java类型', '40', '0', '1', '2013-10-28 08:00:00', '1', '2013-10-28 08:00:00', null, '1');
INSERT INTO `sys_dict` VALUES ('99189a494d5f4338a876da79f3e4738f', '15', '可能，但不经常（1次/3年）', 'risk_cscore', '可能性', '50', '0', '1', '2017-05-19 18:57:52', '1', '2017-05-19 18:58:13', '', '0');
INSERT INTO `sys_dict` VALUES ('9a98eb4824c14af29c1c8456d3824fa8', '4', '重大风险清单', 'risk_Type', '重大风险清单', '50', '0', '1', '2017-05-19 23:56:33', '1', '2017-05-19 23:56:33', '', '0');
INSERT INTO `sys_dict` VALUES ('9c293c2a91b649dd80f6b537427fad9d', '2', '一个季度一次', 'emission_frequency', '排放频率', '20', '0', '1', '2017-05-11 21:25:30', '1', '2017-05-11 21:26:01', '排放频率', '0');
INSERT INTO `sys_dict` VALUES ('9c90f2eb32184bb282c7ed68c57b2329', '3', '环境因素清单', 'risk_Type', '环境因素清单', '40', '0', '1', '2017-05-19 23:55:59', '1', '2017-05-19 23:55:59', '', '0');
INSERT INTO `sys_dict` VALUES ('a0d222a54b8c4174a6acf0ddafe82328', '0', '过去', 'tense_Type', '过去', '10', '0', '1', '2017-05-10 16:09:25', '1', '2017-05-10 16:10:42', '时态过去', '0');
INSERT INTO `sys_dict` VALUES ('a3f319fe41084c01be048303909ffff5', '0.2', '极不可能（1次/大于20年）', 'risk_lscore', '可能性', '50', '0', '1', '2017-05-19 18:52:06', '1', '2017-05-19 18:52:06', '', '0');
INSERT INTO `sys_dict` VALUES ('a4d10519b789453292fd85d3081251da', '1', '每年几次暴露', 'risk_escore', '可能性', '60', '0', '1', '2017-05-19 18:54:31', '1', '2017-05-19 18:55:22', '', '0');
INSERT INTO `sys_dict` VALUES ('aebb742324434f5d90ca3a72f13d8320', '3', '可能，但不经常（1次/3年）', 'risk_lscore', '可能性', '20', '0', '1', '2017-05-19 18:49:21', '1', '2017-05-19 18:49:21', '', '0');
INSERT INTO `sys_dict` VALUES ('bafb445fcd2e42ce995bfe5db37ad18f', '3', '三级风险', 'risk_level', '三级风险', '21', '0', '1', '2017-05-19 23:35:49', '1', '2017-05-19 23:36:19', '', '0');
INSERT INTO `sys_dict` VALUES ('bd1fab2b021e4ca58128b9e8a8112a5d', '3', '紧急', 'status_Type', '紧急', '20', '0', '1', '2017-05-10 16:13:27', '1', '2017-05-10 16:13:41', '状态紧急', '0');
INSERT INTO `sys_dict` VALUES ('bf1e29445b5e4f8abaa31134ad17fd34', '0', '非重大风险', 'heave_flag', '是否重大', '10', '0', '1', '2017-05-19 12:06:01', '1', '2017-05-19 12:07:39', '是否重大风险', '0');
INSERT INTO `sys_dict` VALUES ('c2c01e42cd0b4dbfab0968fe2d007ef6', '1', '现在', 'tense_Type', '现在', '20', '0', '1', '2017-05-10 16:09:53', '1', '2017-05-10 16:10:54', '时态现在', '0');
INSERT INTO `sys_dict` VALUES ('ccf34861532745d6af0d31669a8b5211', '3', '每周一次，或偶然暴露', 'risk_escore', '可能性', '40', '0', '1', '2017-05-19 18:54:09', '1', '2017-05-19 18:54:09', '', '0');
INSERT INTO `sys_dict` VALUES ('da6cf0057ad949af98ea276e1af8d913', '1', '极不可能（1次/大于20年）', 'risk_cscore', '可能性', '80', '0', '1', '2017-05-19 18:59:51', '1', '2017-05-19 18:59:51', '', '0');
INSERT INTO `sys_dict` VALUES ('ddfed0362da34baaad52a339579a3d0c', '2', '将来', 'tense_Type', '将来', '30', '0', '1', '2017-05-10 16:10:27', '1', '2017-05-10 16:10:27', '时态将来', '0');
INSERT INTO `sys_dict` VALUES ('f355a20249f9443ab16f0f16fdca6ccf', '2', '检维修过程', 'risk_class', '检维修过程', '30', '0', '1', '2017-05-10 17:17:21', '1', '2017-05-10 17:17:21', '检维修过程', '0');
INSERT INTO `sys_dict` VALUES ('f45b3b6df74748a79fe2407cd2fcd9d7', '1', '重大风险', 'heave_flag', '是否重大', '20', '0', '1', '2017-05-19 12:06:51', '1', '2017-05-19 12:06:51', '是否重大', '1');
INSERT INTO `sys_dict` VALUES ('f8beb214afc24620a607645385bb91e8', '2', '安全风险清单', 'risk_Type', '安全风险清单', '30', '0', '1', '2017-05-19 23:55:21', '1', '2017-05-19 23:55:30', '', '0');
