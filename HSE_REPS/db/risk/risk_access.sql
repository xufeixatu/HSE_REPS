/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : hse

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2017-05-24 01:36:17
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
INSERT INTO `risk_access` VALUES ('42a7b57f6a90451686167e7a7a2f801f', null, null, null, null, null, '0', null, 'test6', 'test6', 'test6', 'test6', '0', '0', 'test6', '1', '4999a8b3bd9c4dd09f84096269e64457', '0', null, '3', null, null, null, null, null, null, null, null, null, null, '1', '2017-05-24 00:28:53', '1', '2017-05-24 00:28:53', 'test6', '0');
INSERT INTO `risk_access` VALUES ('67f7ac5d53224127877a41efe9c219cb', null, null, null, null, null, '0,1', '5', 'testEVN', 'testEVN', 'testEVN', 'testEVN', '0', '0', 'testEVN', '1', null, null, null, null, null, null, null, null, null, '1', 'testEVN', null, null, null, '1', '2017-05-23 22:01:59', '1', '2017-05-23 22:01:59', '', '0');
INSERT INTO `risk_access` VALUES ('6d6842f64e59480ca00074bb43d221ee', null, null, null, null, null, '1', '5', 'en3', 'en3', 'en3', 'en3', '0', '0', 'en3', '1', null, null, null, null, null, null, null, null, null, '1', 'en3', null, null, null, '1', '2017-05-24 00:26:03', '1', '2017-05-24 00:26:03', 'en3', '0');
INSERT INTO `risk_access` VALUES ('7f8c7361e0b84c6bae85013b391ce196', null, null, null, null, null, '0', '5', 'test1', 'test1', 'test1', 'test1', '0', '0', 'test1', '1', '3cd75ff73fbc41bb8fe44fb427d3edc8', '1', null, '5', null, null, null, null, null, null, null, null, null, null, '1', '2017-05-23 21:14:33', '1', '2017-05-23 21:14:33', 'test1', '0');
INSERT INTO `risk_access` VALUES ('9d244e29b06844428cc726eedc18db25', null, null, null, null, null, '0,1', '5', 'test1', 'test1', 'test1', 'test1', '0', '0', 'test1', '1', null, null, null, null, null, null, null, null, null, '2', 'test1', null, null, null, '1', '2017-05-24 00:17:52', '1', '2017-05-24 00:17:52', 'test1', '0');
INSERT INTO `risk_access` VALUES ('bc1b647d2468485791d2d6fd2c48999f', null, null, null, null, null, '2', '5', 'test5', 'test5', 'test5', 'test5', '0', '0', 'test5', '1', 'f12fd0342dea45eb994cbeeafc62fc5a', '0', null, '3', null, null, null, '不知道', null, null, '报备', null, null, null, '1', '2017-05-19 23:30:05', '1', '2017-05-19 23:30:05', 'test5', '0');
INSERT INTO `risk_access` VALUES ('d624d9b7b5bc46ce9dcd1e64a46aee55', null, null, null, null, null, '1', '5', 'ev1', 'ev1', 'ev1', 'ev1', '1', '1', 'ev1', '1', null, null, null, null, null, null, null, null, null, '1', 'ev1', null, null, null, '1', '2017-05-24 00:14:18', '1', '2017-05-24 00:14:18', '', '0');
INSERT INTO `risk_access` VALUES ('e235a50a76ae4d3ba2129025fed8c4df', null, null, null, null, null, '0,1', '1', 'en2', 'en2', 'en2', 'en2', '0', '0', 'en2', '1', null, null, null, null, null, null, null, null, null, '2', 'en2', null, null, null, '1', '2017-05-24 00:22:31', '1', '2017-05-24 00:22:31', 'en2', '0');

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
INSERT INTO `risk_saferesult` VALUES ('095db059926340a89f88f694ee6e517b', 'bc1b647d2468485791d2d6fd2c48999f', '0.2', '10', '40', '80.0', null, null, null, '3', null, null, '1', '2017-05-22 14:48:03', '1', '2017-05-22 14:48:03', null, '0');
INSERT INTO `risk_saferesult` VALUES ('1b5849b56fab4f9b819640b29c5db483', '913f02c0a61e46009c425906428cad6a', '0.2', '0.5', '7', '0.7', null, null, null, '1', null, null, '1', '2017-05-19 23:23:44', '1', '2017-05-19 23:23:44', null, '0');
INSERT INTO `risk_saferesult` VALUES ('2004f11fead64fe2b32cb9c9fcc42195', 'bc1b647d2468485791d2d6fd2c48999f', '0.2', '10', '40', '80.0', null, null, null, '3', null, null, '1', '2017-05-19 23:30:05', '1', '2017-05-19 23:30:05', null, '0');
INSERT INTO `risk_saferesult` VALUES ('303d64a448ed4bdea83d7e3251a2c9d3', 'bc1b647d2468485791d2d6fd2c48999f', '0.2', '10', '40', '80.0', null, null, null, '3', null, null, '1', '2017-05-22 14:33:29', '1', '2017-05-22 14:33:29', null, '0');
INSERT INTO `risk_saferesult` VALUES ('3cd75ff73fbc41bb8fe44fb427d3edc8', '7f8c7361e0b84c6bae85013b391ce196', '3', '10', '100', '3000.0', null, null, null, '5', null, null, '1', '2017-05-23 21:14:52', '1', '2017-05-23 21:14:52', null, '0');
INSERT INTO `risk_saferesult` VALUES ('4999a8b3bd9c4dd09f84096269e64457', '42a7b57f6a90451686167e7a7a2f801f', '3', '6', '4', '72.0', null, null, null, '3', null, null, '1', '2017-05-24 00:35:38', '1', '2017-05-24 00:35:38', null, '0');
INSERT INTO `risk_saferesult` VALUES ('60649dea5e7143a3a4b4cfd52dc82184', 'bc1b647d2468485791d2d6fd2c48999f', '0.2', '10', '40', '80.0', null, null, null, '3', null, null, '1', '2017-05-22 14:26:14', '1', '2017-05-22 14:26:14', null, '0');
INSERT INTO `risk_saferesult` VALUES ('9268f2036e5c490ab0ffe7e71d668ca9', 'bc1b647d2468485791d2d6fd2c48999f', '0.2', '10', '40', '80.0', null, null, null, '3', null, null, '1', '2017-05-22 16:57:15', '1', '2017-05-22 16:57:15', null, '0');
INSERT INTO `risk_saferesult` VALUES ('b367e80ea37b42528242f07bcfe5cf15', '0d213bb1eede45f1bafdf5db0eb3a8cd', '0.1', '0.5', '4', '0.2', null, null, null, '1', null, null, '1', '2017-05-19 22:15:44', '1', '2017-05-19 22:15:44', null, '0');
INSERT INTO `risk_saferesult` VALUES ('bf880fadc6744af182ce7ec85f2a31a2', '00db34d5198448879c2547c630e9f3b1', '3', '0.5', '1', '1.5', null, null, null, '1', null, null, '1', '2017-05-19 21:52:47', '1', '2017-05-19 21:52:47', null, '0');
INSERT INTO `risk_saferesult` VALUES ('f12fd0342dea45eb994cbeeafc62fc5a', 'bc1b647d2468485791d2d6fd2c48999f', '0.2', '10', '40', '80.0', null, null, null, '3', null, null, '1', '2017-05-23 21:04:55', '1', '2017-05-23 21:04:55', null, '0');


-- ----------------------------
-- Records of sys_dict
-- ----------------------------


INSERT INTO `sys_dict` VALUES ('29acf5d880cc43ec87472763f775034d', '1', '环境类型', 'risk_Type', '环境类型', 20, '0', '1', '2017-5-10 15:25:32', '1', '2017-5-10 15:25:43', '', '0');
INSERT INTO `sys_dict` VALUES ('8c729d15ee144545818449662adadd48', '0', '安全风险', 'risk_Type', '安全风险', 10, '0', '1', '2017-5-10 15:25:15', '1', '2017-5-10 15:25:15', '', '0');
INSERT INTO `sys_dict` VALUES ('9a98eb4824c14af29c1c8456d3824fa8', '4', '重大风险清单', 'risk_Type', '重大风险清单', 50, '0', '1', '2017-5-19 23:56:33', '1', '2017-5-19 23:56:33', '', '0');
INSERT INTO `sys_dict` VALUES ('9c90f2eb32184bb282c7ed68c57b2329', '3', '环境因素清单', 'risk_Type', '环境因素清单', 40, '0', '1', '2017-5-19 23:55:59', '1', '2017-5-19 23:55:59', '', '0');
INSERT INTO `sys_dict` VALUES ('f8beb214afc24620a607645385bb91e8', '2', '安全风险清单', 'risk_Type', '安全风险清单', 30, '0', '1', '2017-5-19 23:55:21', '1', '2017-5-19 23:55:30', '', '0');
INSERT INTO `sys_dict` VALUES ('15e1e8e2860e4aaa914350fe96f9cfb6', '5', '相关方', 'risk_class', '相关方', 20, '0', '1', '2017-5-10 17:18:08', '1', '2017-5-10 17:18:08', '相关方', '0');
INSERT INTO `sys_dict` VALUES ('1853c6b760a8439a9738973a17a537f5', '1', '开停车过程', 'risk_class', '开停车过程', 20, '0', '1', '2017-5-10 17:17:01', '1', '2017-5-10 17:17:01', '开停车过程', '0');
INSERT INTO `sys_dict` VALUES ('311ec7b84a02436b9d57326198cfe6b3', '3', '紧急情况下', 'risk_class', '紧急情况下', 40, '0', '1', '2017-5-10 17:17:40', '1', '2017-5-10 17:17:40', '紧急情况下', '0');
INSERT INTO `sys_dict` VALUES ('4944a2b7606f4885b9987f75f941201c', '4', '办公过程', 'risk_class', '办公过程', 50, '0', '1', '2017-5-10 17:17:53', '1', '2017-5-10 17:17:53', '办公过程', '0');
INSERT INTO `sys_dict` VALUES ('f355a20249f9443ab16f0f16fdca6ccf', '2', '检维修过程', 'risk_class', '检维修过程', 30, '0', '1', '2017-5-10 17:17:21', '1', '2017-5-10 17:17:21', '检维修过程', '0');
INSERT INTO `sys_dict` VALUES ('0cfa2555cebc45c4ad90ce55d0c17189', '7', '可能性小，完全意外（1次/10年）', 'risk_cscore', '可能性', 60, '0', '1', '2017-5-19 18:58:21', '1', '2017-5-19 18:58:21', '', '0');
INSERT INTO `sys_dict` VALUES ('0f70c66fdbe14a3cab24043125c294a3', '4', '很不可能，可以设想（1次/20年）', 'risk_cscore', '可能性', 70, '0', '1', '2017-5-19 18:58:47', '1', '2017-5-19 18:58:47', '', '0');
INSERT INTO `sys_dict` VALUES ('1e7faf0ec5ce49d7aa4e72c49b8a03d0', '40', '相当可能（1次/6个月）', 'risk_cscore', '可能性', 40, '0', '1', '2017-5-19 18:57:35', '1', '2017-5-19 18:57:35', '', '0');
INSERT INTO `sys_dict` VALUES ('21c1e65f06bf4f21b19c5c52b6e13b69', '100', '完全可以预料（1次/周）', 'risk_cscore', '可能性', 30, '0', '1', '2017-5-19 18:57:20', '1', '2017-5-19 18:57:20', '', '0');
INSERT INTO `sys_dict` VALUES ('99189a494d5f4338a876da79f3e4738f', '15', '可能，但不经常（1次/3年）', 'risk_cscore', '可能性', 50, '0', '1', '2017-5-19 18:57:52', '1', '2017-5-19 18:58:13', '', '0');
INSERT INTO `sys_dict` VALUES ('da6cf0057ad949af98ea276e1af8d913', '1', '极不可能（1次/大于20年）', 'risk_cscore', '可能性', 80, '0', '1', '2017-5-19 18:59:51', '1', '2017-5-19 18:59:51', '', '0');
INSERT INTO `sys_dict` VALUES ('0af65bebb9244259bdc5f9dad2db7585', '6', '每天工作时间内暴露', 'risk_escore', '可能性', 30, '0', '1', '2017-5-19 18:53:39', '1', '2017-5-19 18:53:39', '', '0');
INSERT INTO `sys_dict` VALUES ('4b1aac767b474a60b717ac9c63056543', '2', '每月一次暴露', 'risk_escore', '可能性', 50, '0', '1', '2017-5-19 18:54:20', '1', '2017-5-19 18:54:20', '', '0');
INSERT INTO `sys_dict` VALUES ('5b570f374cd14440a1f11237d4ca2ae5', '10', '连续暴露', 'risk_escore', '可能性', 20, '0', '1', '2017-5-19 18:53:20', '1', '2017-5-19 18:53:20', '人员暴露的频繁程度（E）', '0');
INSERT INTO `sys_dict` VALUES ('867ba624e0524927891e540e3c5b0cf3', '0.5', '非常罕见的暴露（&lt;1次/年）', 'risk_escore', '可能性', 70, '0', '1', '2017-5-19 18:55:35', '1', '2017-5-19 18:55:35', '', '0');
INSERT INTO `sys_dict` VALUES ('a4d10519b789453292fd85d3081251da', '1', '每年几次暴露', 'risk_escore', '可能性', 60, '0', '1', '2017-5-19 18:54:31', '1', '2017-5-19 18:55:22', '', '0');
INSERT INTO `sys_dict` VALUES ('ccf34861532745d6af0d31669a8b5211', '3', '每周一次，或偶然暴露', 'risk_escore', '可能性', 40, '0', '1', '2017-5-19 18:54:09', '1', '2017-5-19 18:54:09', '', '0');
INSERT INTO `sys_dict` VALUES ('295deabaed904f81835290a7009b8d3c', '1', '重大风险', 'risk_heave_flag', '是否重大', 20, '0', '1', '2017-5-19 12:06:51', '1', '2017-5-23 20:45:05', '是否重大', '0');
INSERT INTO `sys_dict` VALUES ('bf1e29445b5e4f8abaa31134ad17fd34', '0', '非重大风险', 'risk_heave_flag', '是否重大', 10, '0', '1', '2017-5-19 12:06:01', '1', '2017-5-23 20:44:40', '是否重大风险', '0');
INSERT INTO `sys_dict` VALUES ('5443edcec9584fd8b4f6c82bd21a06c6', '1', '是', 'risk_is_flag', '是非判断', 10, '0', '1', '2017-5-19 19:29:14', '1', '2017-5-23 20:44:02', '', '0');
INSERT INTO `sys_dict` VALUES ('5a7e480f269942d8b8237ad1ad0f9e80', '0', '否', 'risk_is_flag', '是非判断', 20, '0', '1', '2017-5-19 19:29:25', '1', '2017-5-23 20:44:22', '', '0');
INSERT INTO `sys_dict` VALUES ('192c289a917d4383b78ecb3fdb366d40', '4', '四级风险', 'risk_level', '四级风险', 30, '0', '1', '2017-5-19 23:36:01', '1', '2017-5-19 23:36:01', '', '0');
INSERT INTO `sys_dict` VALUES ('2ef97143d647449bbf266bbba18ac3a1', '1', '一级风险', 'risk_level', '一级风险', 10, '0', '1', '2017-5-10 17:16:36', '1', '2017-5-19 23:35:27', '一级风险', '0');
INSERT INTO `sys_dict` VALUES ('5d41b01bbd0a49d9a7d655a00d75d2f2', '5', '五级风险', 'risk_level', '五级风险', 40, '0', '1', '2017-5-19 23:36:41', '1', '2017-5-19 23:36:41', '', '0');
INSERT INTO `sys_dict` VALUES ('97d92f85f8a743efa3a802a9b5ad0228', '2', '二级风险', 'risk_level', '一级风险', 20, '0', '1', '2017-5-19 23:35:37', '1', '2017-5-19 23:35:37', '', '0');
INSERT INTO `sys_dict` VALUES ('bafb445fcd2e42ce995bfe5db37ad18f', '3', '三级风险', 'risk_level', '三级风险', 21, '0', '1', '2017-5-19 23:35:49', '1', '2017-5-19 23:36:19', '', '0');
INSERT INTO `sys_dict` VALUES ('132fd9f7d0304acd9eacda75682b1dc6', '1', '可能性小，完全意外（1次/10年）', 'risk_lscore', '可能性', 30, '0', '1', '2017-5-19 18:49:46', '1', '2017-5-19 18:49:46', '', '0');
INSERT INTO `sys_dict` VALUES ('3195dd836ea64745bb0c8fe606b03a35', '0.5', '很不可能，可以设想（1次/20年）', 'risk_lscore', '可能性', 40, '0', '1', '2017-5-19 18:51:38', '1', '2017-5-19 18:51:38', '', '0');
INSERT INTO `sys_dict` VALUES ('40f71992ba0848689000cf64c8f9e164', '0.1', '实际不可能', 'risk_lscore', '可能性', 60, '0', '1', '2017-5-19 18:52:23', '1', '2017-5-19 18:52:23', '', '0');
INSERT INTO `sys_dict` VALUES ('79d34c4803454a398adc566887cf0f72', '6', '相当可能（6月/次）', 'risk_lscore', '可能性', 20, '0', '1', '2017-5-19 18:48:19', '1', '2017-5-19 18:48:19', '', '0');
INSERT INTO `sys_dict` VALUES ('8c6da911931a4df6ac9fe24dc3577b11', '10', '完全可以预料(1次/周)', 'risk_lscore', '可能性', 10, '0', '1', '2017-5-19 18:47:41', '1', '2017-5-19 18:48:53', '', '0');
INSERT INTO `sys_dict` VALUES ('a3f319fe41084c01be048303909ffff5', '0.2', '极不可能（1次/大于20年）', 'risk_lscore', '可能性', 50, '0', '1', '2017-5-19 18:52:06', '1', '2017-5-19 18:52:06', '', '0');
INSERT INTO `sys_dict` VALUES ('aebb742324434f5d90ca3a72f13d8320', '3', '可能，但不经常（1次/3年）', 'risk_lscore', '可能性', 20, '0', '1', '2017-5-19 18:49:21', '1', '2017-5-19 18:49:21', '', '0');
INSERT INTO `sys_dict` VALUES ('1f76a41f002e4f19aa33c9b53df9f59b', '2', '需要住院治疗，缺工	职业性多发病	1万元～10万元', 'risk_mscore', '可能造成结果', 49, '0', '1', '2017-5-23 21:34:37', '1', '2017-5-23 21:36:09', '', '0');
INSERT INTO `sys_dict` VALUES ('5a2807fcfc9b431884a1ed69199af780', '8', '有1人死亡	职业病（多人）	100万元～1000万元', 'risk_mscore', '可能造成结果', 50, '0', '1', '2017-5-23 21:35:23', '1', '2017-5-23 21:35:23', '', '0');
INSERT INTO `sys_dict` VALUES ('5facf182023d4fb0915fddb4b593ca68', '10', '有多人死亡		＞1000万元', 'risk_mscore', '可能造成结果', 51, '0', '1', '2017-5-23 21:35:45', '1', '2017-5-23 21:35:59', '', '0');
INSERT INTO `sys_dict` VALUES ('c497e99c2f0840038628b1b4f5a96feb', '4', '永久性失能	职业病（1人）	10万元～100万元', 'risk_mscore', '可能造成结果', 50, '0', '1', '2017-5-23 21:34:54', '1', '2017-5-23 21:34:54', '', '0');
INSERT INTO `sys_dict` VALUES ('e6b2f8e403114210b9aa85c1ab2285ff', '1', '轻微，仅需简单急救	身体不适	＜1万元', 'risk_mscore', '可能造成结果', 40, '0', '1', '2017-5-23 21:34:05', '1', '2017-5-23 21:34:05', '', '0');
INSERT INTO `sys_dict` VALUES ('0dce844eeaa843d4be6565dec8114e82', '1', '异常', 'risk_status_type', '异常', 20, '0', '1', '2017-5-10 16:12:51', '1', '2017-5-23 20:48:53', '状态异常', '0');
INSERT INTO `sys_dict` VALUES ('2b83d617dc314c18822a65a8959785ba', '0', '正常', 'risk_status_type', '正常', 10, '0', '1', '2017-5-10 16:12:05', '1', '2017-5-23 20:47:56', '状态正常', '0');
INSERT INTO `sys_dict` VALUES ('bd1fab2b021e4ca58128b9e8a8112a5d', '3', '紧急', 'risk_status_type', '紧急', 20, '0', '1', '2017-5-10 16:13:27', '1', '2017-5-23 20:48:13', '状态紧急', '0');
INSERT INTO `sys_dict` VALUES ('a0d222a54b8c4174a6acf0ddafe82328', '0', '过去', 'risk_tense_type', '过去', 10, '0', '1', '2017-5-10 16:09:25', '1', '2017-5-23 20:46:20', '时态过去', '0');
INSERT INTO `sys_dict` VALUES ('c2c01e42cd0b4dbfab0968fe2d007ef6', '1', '现在', 'risk_tense_type', '现在', 20, '0', '1', '2017-5-10 16:09:53', '1', '2017-5-23 20:45:42', '时态现在', '0');
INSERT INTO `sys_dict` VALUES ('ddfed0362da34baaad52a339579a3d0c', '2', '将来', 'risk_tense_type', '将来', 30, '0', '1', '2017-5-10 16:10:27', '1', '2017-5-23 20:46:01', '时态将来', '0');
INSERT INTO `sys_dict` VALUES ('0ae02043aa8b4a6891c429823059cc5b', '1', '一年一次', 'emission_frequency', '排放频率', 10, '0', '1', '2017-5-11 21:25:09', '1', '2017-5-11 21:25:46', '排放频率', '0');
INSERT INTO `sys_dict` VALUES ('9c293c2a91b649dd80f6b537427fad9d', '2', '一个季度一次', 'emission_frequency', '排放频率', 20, '0', '1', '2017-5-11 21:25:30', '1', '2017-5-11 21:26:01', '排放频率', '0');


-- ----------------------------
-- Records of sys_menu
-- ----------------------------

INSERT INTO `sys_menu` VALUES ('17bb630f6da74db885c76b14d4f90bb7', '1acfac56cb8541f688c5664e6deba02b', '0,1,46715019600c44138ebf16088cffd31a,1acfac56cb8541f688c5664e6deba02b,', '安全风险清单', 30, '/risk/riskAccess/list?riskType=2', '', '', '1', '', '1', '2017-5-10 12:12:41', '1', '2017-5-23 21:00:36', '', '0');
INSERT INTO `sys_menu` VALUES ('1acfac56cb8541f688c5664e6deba02b', '46715019600c44138ebf16088cffd31a', '0,1,46715019600c44138ebf16088cffd31a,', '清单', 90, '', '', '', '1', '', '1', '2017-5-10 12:12:21', '1', '2017-5-10 12:12:21', '', '0');
INSERT INTO `sys_menu` VALUES ('1d599d4e2f2f41af85090beadd2a6521', '8855ea64c939442abef6c248bfeb8dcf', '0,1,46715019600c44138ebf16088cffd31a,8855ea64c939442abef6c248bfeb8dcf,', '识别库', 30, '/../static/fengxianku.html', '', '', '1', '', '1', '2017-5-10 12:14:00', '1', '2017-5-23 21:53:50', '', '0');
INSERT INTO `sys_menu` VALUES ('52345b2394c54408a3f347c4a096896b', '46715019600c44138ebf16088cffd31a', '0,1,46715019600c44138ebf16088cffd31a,', '新建', 30, '', '', '', '1', '', '1', '2017-5-10 10:34:03', '1', '2017-5-10 10:34:03', '', '0');
INSERT INTO `sys_menu` VALUES ('6ac1e842efc34a8c99e2123fdf6c0405', '46715019600c44138ebf16088cffd31a', '0,1,46715019600c44138ebf16088cffd31a,', '识别汇总', 60, '', '', '', '1', '', '1', '2017-5-10 10:37:34', '1', '2017-5-10 10:37:34', '', '0');
INSERT INTO `sys_menu` VALUES ('8776ca9399964932a2a52d2cb3288a69', '1acfac56cb8541f688c5664e6deba02b', '0,1,46715019600c44138ebf16088cffd31a,1acfac56cb8541f688c5664e6deba02b,', '环境因素清单', 60, '/risk/riskAccess/list?riskType=3', '', '', '1', '', '1', '2017-5-10 12:12:59', '1', '2017-5-23 21:00:48', '', '0');
INSERT INTO `sys_menu` VALUES ('8855ea64c939442abef6c248bfeb8dcf', '46715019600c44138ebf16088cffd31a', '0,1,46715019600c44138ebf16088cffd31a,', '风险识别评价库', 120, '', '', '', '1', '', '1', '2017-5-10 12:13:37', '1', '2017-5-10 12:13:37', '', '0');
INSERT INTO `sys_menu` VALUES ('c799646d15c14322a032c3641d5d8bb8', '52345b2394c54408a3f347c4a096896b', '0,1,46715019600c44138ebf16088cffd31a,52345b2394c54408a3f347c4a096896b,', '健康安全危害辨识', 30, '/risk/riskAccess/form', '', '', '1', 'risk:riskAccess:edit', '1', '2017-5-10 10:37:05', '1', '2017-5-18 01:24:53', '', '0');
INSERT INTO `sys_menu` VALUES ('c90c539329d04682bbe8672c6507bb85', '6ac1e842efc34a8c99e2123fdf6c0405', '0,1,46715019600c44138ebf16088cffd31a,6ac1e842efc34a8c99e2123fdf6c0405,', '安全风险识别汇总', 30, '/risk/riskAccess/list?riskType=0', '', '', '1', 'risk:riskAccess:view', '1', '2017-5-10 10:37:56', '1', '2017-5-18 00:59:45', '', '0');
INSERT INTO `sys_menu` VALUES ('d48bc1c46619424f90ef33c8cecbea86', '1acfac56cb8541f688c5664e6deba02b', '0,1,46715019600c44138ebf16088cffd31a,1acfac56cb8541f688c5664e6deba02b,', '重大风险清单', 90, '/risk/riskAccess/list?riskType=4', '', '', '1', '', '1', '2017-5-10 12:13:16', '1', '2017-5-23 21:00:58', '', '0');
INSERT INTO `sys_menu` VALUES ('ddbbe1c652134a2dad6d52f7dce93c00', '6ac1e842efc34a8c99e2123fdf6c0405', '0,1,46715019600c44138ebf16088cffd31a,6ac1e842efc34a8c99e2123fdf6c0405,', '环境因素识别汇总', 60, '/risk/riskAccess/list?riskType=1', '', '', '1', 'risk:riskAccess:view', '1', '2017-5-10 10:38:32', '1', '2017-5-18 01:00:01', '', '0');
INSERT INTO `sys_menu` VALUES ('e6113e541a35459e8fd132fc58883367', '52345b2394c54408a3f347c4a096896b', '0,1,46715019600c44138ebf16088cffd31a,52345b2394c54408a3f347c4a096896b,', '环境危害辨识', 60, '/risk/riskAccess/envirFactorForm', '', '', '1', 'risk:riskAccess:edit', '1', '2017-5-18 01:01:16', '1', '2017-5-18 01:23:50', '', '0');
