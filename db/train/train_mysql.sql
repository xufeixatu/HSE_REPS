/*
Navicat MySQL Data Transfer

Source Server         : localhost3306
Source Server Version : 50541
Source Host           : localhost:3306
Source Database       : jeesite

Target Server Type    : MYSQL
Target Server Version : 50541
File Encoding         : 65001

Date: 2017-05-21 18:40:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for train_content
-- ----------------------------
DROP TABLE IF EXISTS `train_content`;
CREATE TABLE `train_content` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(100) NOT NULL COMMENT '培训知识内容名称',
  `sn` varchar(8) NOT NULL COMMENT '序号',
  `classify` varchar(8) NOT NULL COMMENT '培训分类',
  `first_period` varchar(32) DEFAULT NULL,
  `next_period` varchar(32) DEFAULT NULL COMMENT '复培课时/频率 (小时/N年)',
  `organizer` varchar(128) NOT NULL COMMENT '培训组织单位',
  `requirement` char(1) NOT NULL COMMENT '培训完成要求 (职前/职后)',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='培训知识内容信息表';

-- ----------------------------
-- Records of train_content
-- ----------------------------
INSERT INTO `train_content` VALUES ('03c7312a486f402ca9c9b365f2522dd0', '电工操作证', '03', '1', '148/ 180', '8/3年', '外部', '1', '1', '2017-05-21 10:21:23', '1', '2017-05-21 10:45:50', '电工操作证 (高压、低压、防爆电气）', '0');
INSERT INTO `train_content` VALUES ('0c9cca3c3a2a4c06b740036a725ffb0b', '专项应急处置预案演练 (14个专项)', '58', '3', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:21:14', '1', '2017-05-21 11:21:14', '', '0');
INSERT INTO `train_content` VALUES ('112686cb7e4749aca3503f7867eaaada', '反违章六条禁令', '33', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:06:06', '1', '2017-05-21 11:06:06', '', '0');
INSERT INTO `train_content` VALUES ('126c237240ce471f951d5a1513418576', '移动式起重机吊装作业安全管理细则', '50', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:18:12', '1', '2017-05-21 11:18:12', '', '0');
INSERT INTO `train_content` VALUES ('1275f15dba9d4ef4b28c7026a89a542b', '应急演练 - 厂级', '56', '3', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:20:24', '1', '2017-05-21 11:20:24', '', '0');
INSERT INTO `train_content` VALUES ('13d223c06d464348880af3e12398490a', '工作循环分析管理实施细则', '45', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:15:31', '1', '2017-05-21 11:15:31', '', '0');
INSERT INTO `train_content` VALUES ('2286975735ba4f0b92d7a754e232a42c', '井控证', '07', '1', '80', '40/2年', '外部', '1', '1', '2017-05-21 10:23:52', '1', '2017-05-21 10:46:01', '', '0');
INSERT INTO `train_content` VALUES ('24eba2b7575e43f29d9aac5d9a4b13c0', '临时用电安全管理细则', '42', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:14:20', '1', '2017-05-21 11:14:20', '', '0');
INSERT INTO `train_content` VALUES ('38a6bdb796154ccd9440bdd0051e49ec', '冬季安全生产措施', '30', '2', '', '', '作业区', '1', '1', '2017-05-21 11:04:06', '1', '2017-05-21 11:04:06', '', '0');
INSERT INTO `train_content` VALUES ('4416a9c461e24f87a8c3feb388ba5645', '起重机械指挥证', '15', '1', '', '', '外部', '1', '1', '2017-05-21 10:45:21', '1', '2017-05-21 10:45:21', '', '0');
INSERT INTO `train_content` VALUES ('445c814ea64b4d8c909f0d879d33fec5', '各部门相关HSE程序文件', '35', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:06:59', '1', '2017-05-21 11:06:59', '', '0');
INSERT INTO `train_content` VALUES ('4924294438da41dbbacfc03df965387c', '停电应急预案', '60', '3', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:22:11', '1', '2017-05-21 11:22:11', '', '0');
INSERT INTO `train_content` VALUES ('4cfc07c9899d4ea994382ec4d3c5bf5b', '动火作业安全管理细则', '39', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:12:55', '1', '2017-05-21 11:12:55', '', '0');
INSERT INTO `train_content` VALUES ('4d793919fb364c7ebce89102c5d9d0e1', '危险作业管理及作业票办理程序', '37', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:10:35', '1', '2017-05-21 11:10:35', '', '0');
INSERT INTO `train_content` VALUES ('50b465e99ee84752ae1f449ec945accf', '新员工入场安全教育培训-厂级', '22', '2', '', '', '综合办', '1', '1', '2017-05-21 10:49:44', '1', '2017-05-21 10:49:44', '', '0');
INSERT INTO `train_content` VALUES ('5148fe89049943d7b1a4993de411cc5f', '新员工入场安全教育培训-部门级', '23', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 10:50:08', '1', '2017-05-21 10:50:08', '', '0');
INSERT INTO `train_content` VALUES ('5c89c0521bee4c6ebdd0b762d661fafe', '消防证', '19', '1', '', '', '外部', '1', '1', '2017-05-21 10:48:24', '1', '2017-05-21 10:48:24', '', '0');
INSERT INTO `train_content` VALUES ('5e15a327bd74419faccfb0534fc9f435', '脚手架作业安全管理细则', '48', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:17:06', '1', '2017-05-21 11:17:06', '', '0');
INSERT INTO `train_content` VALUES ('676c63b10127405197376bd1e3fd5240', '启动前安全检查管理细则', '47', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:16:44', '1', '2017-05-21 11:16:44', '', '0');
INSERT INTO `train_content` VALUES ('6fb38b4bb3c1485d92ae8bb6a864995b', '岗位职责、岗位风险因素及控制措施', '32', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:05:04', '1', '2017-05-21 11:05:04', '', '0');
INSERT INTO `train_content` VALUES ('739333317e474e39907e696f2bc14969', '气体检测仪的使用', '63', '4', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:23:26', '1', '2017-05-21 11:24:18', '气体检测仪的使用 （氧气、可燃气体）', '0');
INSERT INTO `train_content` VALUES ('7634d69c552046d48aaa28840f9271e8', '夏天安全生产措施', '29', '2', '', '', '作业区', '1', '1', '2017-05-21 10:53:30', '1', '2017-05-21 10:53:30', '', '0');
INSERT INTO `train_content` VALUES ('78b583cb414b4911a7bc4c211c96dbe1', '作业许可管理细则', '38', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:11:05', '1', '2017-05-21 11:11:05', '', '0');
INSERT INTO `train_content` VALUES ('790ec43d5d2c4719a68582445a08ade5', '行为安全观察与沟通管理细则', '52', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:18:54', '1', '2017-05-21 11:18:54', '', '0');
INSERT INTO `train_content` VALUES ('7b6fa5a880734b099ffd37de4c12927c', '苏南6项HSE政策和12项作业准则', '31', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:04:32', '1', '2017-05-21 11:04:32', '', '0');
INSERT INTO `train_content` VALUES ('7cb7b3a0909445ec9f85358e35aa720a', '进入受限空间安全管理细则', '41', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:13:48', '1', '2017-05-21 11:13:48', '', '0');
INSERT INTO `train_content` VALUES ('89b8b6dabaee471eae7e901d61c108e2', '应急演练 - 作业区级', '57', '3', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:20:45', '1', '2017-05-21 11:20:45', '', '0');
INSERT INTO `train_content` VALUES ('914b9e4ec8ff410c9133169f22543663', '进入厂（站）安全须知介绍', '25', '2', '', '', '集气站', '1', '1', '2017-05-21 10:51:07', '1', '2017-05-21 10:51:07', '', '0');
INSERT INTO `train_content` VALUES ('926c9c1073bd440193ebd16e1a4bfb7f', '防雷防静电装置管理实施细则', '54', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:19:36', '1', '2017-05-21 11:19:36', '', '0');
INSERT INTO `train_content` VALUES ('993eec6dd1b247f3928cf738fe89d8e5', '外来施工人员进厂（站）前HSE培训', '26', '2', '', '', '作业区', '1', '1', '2017-05-21 10:51:57', '1', '2017-05-21 10:51:57', '', '0');
INSERT INTO `train_content` VALUES ('9a555d8d0b5d4b7c9ad594153ba9d965', '甲醇、污水、凝析油管理制度', '36', '2', '', '', '作业区', '1', '1', '2017-05-21 11:10:00', '1', '2017-05-21 11:10:00', '', '0');
INSERT INTO `train_content` VALUES ('9bfa33fed3dc4dc8b8031ff86bd90c45', '上岗证培训 - A类 管理岗', '27', '2', '', '', '综合办', '1', '1', '2017-05-21 10:52:30', '1', '2017-05-21 10:52:30', '', '0');
INSERT INTO `train_content` VALUES ('9fba2e4abf23478a99abd70471d040cc', '管线打开安全管理细则', '46', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:16:22', '1', '2017-05-21 11:16:22', '', '0');
INSERT INTO `train_content` VALUES ('a06ae546ae594443acdfb3886bfa7ce6', 'HSE培训管理细则', '51', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:18:31', '1', '2017-05-21 11:18:31', '', '0');
INSERT INTO `train_content` VALUES ('a089d241071f49f0a4961c4d3596af44', '新员工入场安全教育培训-班组级', '24', '2', '', '', '班组', '1', '1', '2017-05-21 10:50:43', '1', '2017-05-21 10:50:43', '', '0');
INSERT INTO `train_content` VALUES ('a3dcc9b4aece476a8ea26975f5265dfe', '登高作业证', '05', '1', '100', '8/3年', '外部', '1', '1', '2017-05-21 10:23:05', '1', '2017-05-21 10:45:56', '登高作业证 （高处架设、高处维护）', '0');
INSERT INTO `train_content` VALUES ('a434d0f000434b60a97e95822a441924', '车辆及交通安全管理细则', '55', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:19:59', '1', '2017-05-21 11:19:59', '', '0');
INSERT INTO `train_content` VALUES ('a6cf81d214f34dccaa338186285aa078', '压力管道作业证', '14', '1', '', '', '外部', '1', '1', '2017-05-21 10:43:55', '1', '2017-05-21 10:44:23', '压力管道作业证 （巡检维护、带压封堵、带压密封）', '0');
INSERT INTO `train_content` VALUES ('ace94b748f9742d79edbf6ab44f6a040', '防火责任人知识技能培训', '61', '3', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:22:33', '1', '2017-05-21 11:22:33', '', '0');
INSERT INTO `train_content` VALUES ('b24b64f7b2504f6f8bb44c94f484c151', '应急消防知识培训', '62', '3', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:22:57', '1', '2017-05-21 11:22:57', '', '0');
INSERT INTO `train_content` VALUES ('c5ee69037244487e917dfdf40314338e', 'HSE九项管理原则', '34', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:06:32', '1', '2017-05-21 11:06:32', '', '0');
INSERT INTO `train_content` VALUES ('ca20f2a9ecc84c99817fe69a4baa1a17', '挖掘作业安全管理细则', '49', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:17:51', '1', '2017-05-21 11:17:51', '', '0');
INSERT INTO `train_content` VALUES ('cb7610f147e8404fb9104de08de6bb37', '企业主要负责人安全资格证', '01', '1', '48', '16/年', '外部', '2', '1', '2017-05-18 00:40:04', '1', '2017-05-21 10:45:39', '企业主要负责人安全资格证', '0');
INSERT INTO `train_content` VALUES ('d0dae411e3cc4d2b942f1425f4b6bb25', '企业安全管理资格证', '02', '1', '48', '16/年', '外部', '2', '1', '2017-05-21 10:20:16', '1', '2017-05-21 10:45:44', '', '0');
INSERT INTO `train_content` VALUES ('d75a62f977754bf89249c6f6cc142951', '高处作业安全管理实施细则', '40', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:13:23', '1', '2017-05-21 11:13:23', '', '0');
INSERT INTO `train_content` VALUES ('d7f64b6a02974a55b1da3ebdf8df492e', '超压应急预案', '59', '3', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:21:51', '1', '2017-05-21 11:21:51', '', '0');
INSERT INTO `train_content` VALUES ('d854dda3ba1a48ad82c67fd0673470a1', '工作前安全分析管理实施细则', '44', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:15:08', '1', '2017-05-21 11:15:08', '', '0');
INSERT INTO `train_content` VALUES ('e1c12a834c27474ab773d736f361a182', '工艺和设备变更管理细则', '43', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:14:43', '1', '2017-05-21 11:14:43', '', '0');
INSERT INTO `train_content` VALUES ('e332c0a66beb43189378335391a76149', '应急设备及消防器材的使用', '64', '4', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:24:05', '1', '2017-05-21 11:24:05', '应急设备及消防器材的使用 （呼吸器、灭火器、急救包等）', '0');
INSERT INTO `train_content` VALUES ('e6c7f29670f64e0896561fa7e1291573', '上岗证培训 - B类 操作岗', '28', '2', '', '', '综合办', '1', '1', '2017-05-21 10:53:03', '1', '2017-05-21 10:53:03', '', '0');
INSERT INTO `train_content` VALUES ('ee01d165210345a5a6c786dee600a700', '食品卫生知识培训健康合格证', '21', '1', '', '', '外部', '1', '1', '2017-05-21 10:48:50', '1', '2017-05-21 10:48:50', '', '0');
INSERT INTO `train_content` VALUES ('efe9cdcf2ef24024932b3af8dc56f2bc', '安全目视化管理细则', '53', '2', '', '', '各部门（作业区）', '1', '1', '2017-05-21 11:19:17', '1', '2017-05-21 11:19:17', '', '0');

-- ----------------------------
-- Table structure for train_courseware
-- ----------------------------
DROP TABLE IF EXISTS `train_courseware`;
CREATE TABLE `train_courseware` (
  `id` varchar(64) NOT NULL COMMENT '编码',
  `file` varchar(255) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL COMMENT '课件名称',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of train_courseware
-- ----------------------------

-- ----------------------------
-- Table structure for train_job
-- ----------------------------
DROP TABLE IF EXISTS `train_job`;
CREATE TABLE `train_job` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(100) NOT NULL COMMENT '培训岗位名称',
  `sn` varchar(32) NOT NULL COMMENT '序号',
  `classify` char(1) NOT NULL COMMENT '岗位分类(0：通用类；A：厂机关及附属,B：基层单位)',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='培训岗位信息表';

-- ----------------------------
-- Records of train_job
-- ----------------------------
INSERT INTO `train_job` VALUES ('0697da9a35d644b3892a0bf70db28fab', '巡护岗', 'B33', '3', '1', '2017-05-21 11:54:54', '1', '2017-05-21 11:54:54', '', '0');
INSERT INTO `train_job` VALUES ('0901d847bcee48579a62074bb9bc7af5', '主任、副主任', 'A81', '2', '1', '2017-05-21 11:50:54', '1', '2017-05-21 11:50:54', '', '0');
INSERT INTO `train_job` VALUES ('0b05ac07f407446bb57d53f498ab9cf6', '技术组', 'B4', '3', '1', '2017-05-21 11:55:22', '1', '2017-05-21 11:55:22', '', '0');
INSERT INTO `train_job` VALUES ('0df251927b4342cc8d26cdf24f928cfd', '进入厂、站、及作业现场的人员', '1', '1', '1', '2017-05-18 00:38:50', '1', '2017-05-21 11:25:02', '所有需要进入厂、站、及作业现场的人员（包括来访人员）', '0');
INSERT INTO `train_job` VALUES ('0f0f4dacb96a47debe4febe01505fff3', '科员', 'A52', '2', '1', '2017-05-21 11:49:00', '1', '2017-05-21 11:49:00', '', '0');
INSERT INTO `train_job` VALUES ('16c88a84a9c14eeca68c61638d00f411', '控制中心', 'B5', '3', '1', '2017-05-21 12:00:50', '1', '2017-05-21 12:00:50', '', '0');
INSERT INTO `train_job` VALUES ('1b265f2971f34ffc906feb8f49cb27b5', '科员', 'A92', '2', '1', '2017-05-21 11:52:15', '1', '2017-05-21 11:52:15', '', '0');
INSERT INTO `train_job` VALUES ('1b46258c5f2c4b11acda64bdb8fa4d57', '科员', 'A82', '2', '1', '2017-05-21 11:51:08', '1', '2017-05-21 11:51:08', '', '0');
INSERT INTO `train_job` VALUES ('1def5d0bddc946289955b40f642271dc', '调度岗', 'B32', '3', '1', '2017-05-21 11:54:45', '1', '2017-05-21 11:54:45', '', '0');
INSERT INTO `train_job` VALUES ('293d453007db4d99808527ddf9ae5dba', '主任、副主任', 'A71', '2', '1', '2017-05-21 11:50:06', '1', '2017-05-21 11:50:06', '', '0');
INSERT INTO `train_job` VALUES ('391f1bea4ea24e5c8b121a9134c4d287', '材料岗', 'B34', '3', '1', '2017-05-21 11:55:05', '1', '2017-05-21 11:55:05', '', '0');
INSERT INTO `train_job` VALUES ('456fe56617c54969948c9f9e9513f7d3', '主任、副主任', 'A61', '2', '1', '2017-05-21 11:49:26', '1', '2017-05-21 11:49:26', '', '0');
INSERT INTO `train_job` VALUES ('49272434e7c040068bccb98132a724e3', '地质', 'B45', '3', '1', '2017-05-21 11:58:08', '1', '2017-05-21 11:58:08', '', '0');
INSERT INTO `train_job` VALUES ('49a8fd0ab2c34542bffb2e940ddfcea6', '工艺', 'B44', '3', '1', '2017-05-21 11:56:14', '1', '2017-05-21 11:56:14', '', '0');
INSERT INTO `train_job` VALUES ('50a4a0d7200949e091db6249c2038efc', '主任、副主任', 'A91', '2', '1', '2017-05-21 11:52:05', '1', '2017-05-21 11:52:05', '', '0');
INSERT INTO `train_job` VALUES ('52cd57614995496baf7b393f76667a60', '集气站', 'B6', '3', '1', '2017-05-21 12:01:04', '1', '2017-05-21 12:01:04', '', '0');
INSERT INTO `train_job` VALUES ('5b56df1766504d86807aa91a0cbbfd18', '组长', 'B21', '3', '1', '2017-05-21 11:53:43', '1', '2017-05-21 11:53:43', '', '0');
INSERT INTO `train_job` VALUES ('5ece7131a5f044f3be8b6445fbfa8b49', 'HSE管理', 'B46', '3', '1', '2017-05-21 11:58:31', '1', '2017-05-21 11:58:31', '', '0');
INSERT INTO `train_job` VALUES ('65ba2b44b80d45569b746f3f15e710ac', '地质部', 'A8', '2', '1', '2017-05-21 11:50:37', '1', '2017-05-21 11:50:37', '', '0');
INSERT INTO `train_job` VALUES ('6a720f72640143b7b5e7e933ada1a2f6', '科员', 'A32', '2', '1', '2017-05-21 11:27:33', '1', '2017-05-21 11:27:33', '', '0');
INSERT INTO `train_job` VALUES ('707f39ef74e14ed5b2891306cb21aac1', '科员', 'A102', '2', '1', '2017-05-21 11:52:56', '1', '2017-05-21 11:52:56', '', '0');
INSERT INTO `train_job` VALUES ('7713fdb194104e6198f8e202738d6e15', '主任、副主任', 'A51', '2', '1', '2017-05-21 11:48:50', '1', '2017-05-21 11:48:50', '', '0');
INSERT INTO `train_job` VALUES ('7d2b19e953c54ff2b69e39cb6fd9b3ee', '综合组', 'B2', '3', '1', '2017-05-21 11:53:29', '1', '2017-05-21 11:53:29', '', '0');
INSERT INTO `train_job` VALUES ('804243fa9c304aeb9df9a1728b2c092f', '综合（党委）办公室', 'A4', '2', '1', '2017-05-21 11:27:43', '1', '2017-05-21 11:27:43', '', '0');
INSERT INTO `train_job` VALUES ('813ff0f5ab454762aa1d157d72ae41c3', '经理、副经理、党支部书记', 'B1', '3', '1', '2017-05-21 11:53:13', '1', '2017-05-21 11:53:13', '', '0');
INSERT INTO `train_job` VALUES ('827fdf84683b45c3857baf16bb50049d', '组长', 'B31', '3', '1', '2017-05-21 11:54:33', '1', '2017-05-21 11:54:33', '', '0');
INSERT INTO `train_job` VALUES ('8b384dc538cd416590f528533c414f0d', '主任、副主任', 'A41', '2', '1', '2017-05-21 11:27:56', '1', '2017-05-21 11:27:56', '', '0');
INSERT INTO `train_job` VALUES ('95c07ce9aefa4c5aa7b771b6e00e71bb', '主任、副主任', 'A101', '2', '1', '2017-05-21 11:52:41', '1', '2017-05-21 11:52:41', '', '0');
INSERT INTO `train_job` VALUES ('960fbd73a2814afda39b34ee10e7f7e3', '钻井工程部', 'A7', '2', '1', '2017-05-21 11:49:54', '1', '2017-05-21 11:49:54', '', '0');
INSERT INTO `train_job` VALUES ('96dca817e51241a5a45489b0939bcf74', '计划财务部', 'A10', '2', '1', '2017-05-21 11:52:29', '1', '2017-05-21 11:52:29', '', '0');
INSERT INTO `train_job` VALUES ('97be74c0f6a84e0997ff744a927c3905', '公共关系部', 'A6', '2', '1', '2017-05-21 11:49:13', '1', '2017-05-21 11:49:13', '', '0');
INSERT INTO `train_job` VALUES ('9e7ba8b99e4f4250b14bb8297ff9efd0', '地面工程部', 'A9', '2', '1', '2017-05-21 11:51:53', '1', '2017-05-21 11:51:53', '', '0');
INSERT INTO `train_job` VALUES ('ad7e7622563245319991dba1c1536449', '科员', 'A62', '2', '1', '2017-05-21 11:49:37', '1', '2017-05-21 11:49:37', '', '0');
INSERT INTO `train_job` VALUES ('aedcc2a0ff7a4441b3c67d597db62a5f', '设备管理', 'B42', '3', '1', '2017-05-21 11:55:48', '1', '2017-05-21 11:55:48', '', '0');
INSERT INTO `train_job` VALUES ('bf3837ed7cae4b0db299a00ad5a23ffd', '科员', 'A42', '2', '1', '2017-05-21 11:28:09', '1', '2017-05-21 11:28:09', '', '0');
INSERT INTO `train_job` VALUES ('c2def0c9eb644469abf6f5778c8685d2', '组长', 'B41', '3', '1', '2017-05-21 11:55:34', '1', '2017-05-21 11:55:34', '', '0');
INSERT INTO `train_job` VALUES ('ca0a7e9bd9994f2db188d73d158fc4da', '主任、副主任', 'A31', '2', '1', '2017-05-21 11:27:21', '1', '2017-05-21 11:27:21', '', '0');
INSERT INTO `train_job` VALUES ('d90ddc29daca4721a1b1a2890b3ce7b4', '采气工', 'B62', '3', '1', '2017-05-21 12:01:28', '1', '2017-05-21 12:01:28', '', '0');
INSERT INTO `train_job` VALUES ('da6584ea131f44cca4d513d34a5767ee', '合同采购部', 'A5', '2', '1', '2017-05-21 11:48:31', '1', '2017-05-21 11:48:31', '', '0');
INSERT INTO `train_job` VALUES ('dbdde6685071405caf1ce15d18f059ee', '生产安全部', 'A3', '2', '1', '2017-05-21 11:27:11', '1', '2017-05-21 11:27:11', '', '0');
INSERT INTO `train_job` VALUES ('e111595ed62d44759dccde27e6383ad5', '科员', 'A72', '2', '1', '2017-05-21 11:50:19', '1', '2017-05-21 11:50:19', '', '0');
INSERT INTO `train_job` VALUES ('e3e7699c180d4e9bb8abc4bcb99ada27', '副总工程师', 'A2', '2', '1', '2017-05-21 11:26:59', '1', '2017-05-21 11:26:59', '', '0');
INSERT INTO `train_job` VALUES ('e480e2a0e3304a68bb8bdbbfdfde6d69', '数字化', 'B43', '3', '1', '2017-05-21 11:55:59', '1', '2017-05-21 11:55:59', '', '0');
INSERT INTO `train_job` VALUES ('e6e1a5e0c0424e008e903d30b4df9065', '经理、党委书记、副经理', 'A1', '2', '1', '2017-05-21 11:26:44', '1', '2017-05-21 11:26:44', '', '0');
INSERT INTO `train_job` VALUES ('e9f804c6ff394f21b7165c9af252ec40', '生产组', 'B3', '3', '1', '2017-05-21 11:54:15', '1', '2017-05-21 11:54:15', '', '0');
INSERT INTO `train_job` VALUES ('eb574f033795407c8bc643e0479d568d', '集气站站长、副站长', 'B61', '3', '1', '2017-05-21 12:01:17', '1', '2017-05-21 12:01:17', '', '0');
INSERT INTO `train_job` VALUES ('fbf47d04acb54bdea28c08780c0a9b2a', '组员', 'B22', '3', '1', '2017-05-21 11:53:58', '1', '2017-05-21 11:53:58', '', '0');

-- ----------------------------
-- Table structure for train_need_matrix
-- ----------------------------
DROP TABLE IF EXISTS `train_need_matrix`;
CREATE TABLE `train_need_matrix` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `job_id` varchar(64) NOT NULL COMMENT '培训岗位编码',
  `content_id` varchar(64) NOT NULL COMMENT '培训知识内容编号',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  `version` varchar(8) DEFAULT NULL COMMENT '版本号',
  PRIMARY KEY (`id`),
  KEY `content_id` (`content_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `train_need_matrix_ibfk_1` FOREIGN KEY (`content_id`) REFERENCES `train_content` (`id`),
  CONSTRAINT `train_need_matrix_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `train_job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of train_need_matrix
-- ----------------------------
INSERT INTO `train_need_matrix` VALUES ('48e0f872ee074c7faf73f46318c2439d', '0df251927b4342cc8d26cdf24f928cfd', '9bfa33fed3dc4dc8b8031ff86bd90c45', '1', '2017-05-21 12:03:22', '1', '2017-05-21 12:14:15', '', '0', '20150201');
INSERT INTO `train_need_matrix` VALUES ('7130ce3e5cfc48369c6961689e602f52', '0df251927b4342cc8d26cdf24f928cfd', '993eec6dd1b247f3928cf738fe89d8e5', '1', '2017-05-21 12:03:03', '1', '2017-05-21 12:13:48', '', '0', '20150201');
INSERT INTO `train_need_matrix` VALUES ('7e187032aabf4c28bbd640230e1094e5', '5ece7131a5f044f3be8b6445fbfa8b49', 'd0dae411e3cc4d2b942f1425f4b6bb25', '1', '2017-05-21 12:26:10', '1', '2017-05-21 12:26:10', '', '0', '20150201');
INSERT INTO `train_need_matrix` VALUES ('935f3c987a994ab0916bb816644f3a05', '0df251927b4342cc8d26cdf24f928cfd', '914b9e4ec8ff410c9133169f22543663', '1', '2017-05-18 08:28:32', '1', '2017-05-21 12:02:37', '', '0', '20150201');
INSERT INTO `train_need_matrix` VALUES ('99a5e89dfcbc48b89d05b38d82f2eafa', '0df251927b4342cc8d26cdf24f928cfd', 'e6c7f29670f64e0896561fa7e1291573', '1', '2017-05-21 12:03:36', '1', '2017-05-21 12:13:44', '', '0', '20150201');

-- ----------------------------
-- Table structure for train_plan
-- ----------------------------
DROP TABLE IF EXISTS `train_plan`;
CREATE TABLE `train_plan` (
  `id` varchar(64) NOT NULL,
  `object_office_id` varchar(64) NOT NULL COMMENT '受训单位',
  `classify` varchar(8) NOT NULL COMMENT '培训分类',
  `name` varchar(255) NOT NULL COMMENT '培训课题',
  `train_object` varchar(8) NOT NULL COMMENT '培训对象(1:管理人员，0:操作人员)',
  `train_time` datetime NOT NULL COMMENT '培训时间',
  `period` varchar(32) NOT NULL COMMENT '学时',
  `plan_number` int(11) unsigned zerofill NOT NULL COMMENT '拟培人数',
  `train_method` varchar(8) NOT NULL COMMENT '培训方式',
  `subject_office_id` varchar(64) NOT NULL COMMENT '负责单位',
  `frequency` varchar(32) NOT NULL COMMENT '培训频率',
  `requirement` varchar(255) NOT NULL COMMENT '培训要求',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  `status` varchar(8) NOT NULL COMMENT '计划状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of train_plan
-- ----------------------------
INSERT INTO `train_plan` VALUES ('1', '26', '4', '技术培训', '1', '2017-05-31 08:16:29', '0', '00000000000', '1', '11', '0', '0', '1', '2017-05-21 08:17:09', '1', '2017-05-21 17:34:59', '0', '0', '1');

-- ----------------------------
-- Table structure for train_record
-- ----------------------------
DROP TABLE IF EXISTS `train_record`;
CREATE TABLE `train_record` (
  `id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '培训主题',
  `object_office_id` varchar(64) NOT NULL,
  `train_time` datetime NOT NULL COMMENT '培训时间',
  `subject_office_id` varchar(64) NOT NULL COMMENT '责任单位',
  `plan_number` int(11) NOT NULL COMMENT '培训人数',
  `contact` varchar(64) NOT NULL COMMENT '联系人',
  `status` varchar(8) NOT NULL DEFAULT '0' COMMENT '归档状态（-1取消，0草稿，1归档）',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  `is_exam` varchar(8) NOT NULL COMMENT '是否考试',
  `exam_time` datetime DEFAULT NULL COMMENT '考试时间',
  `exam_duration` varchar(32) DEFAULT NULL COMMENT '考试时长',
  `pass` varchar(32) DEFAULT NULL,
  `is_plan` varchar(8) NOT NULL COMMENT '是否培训计划的记录（0否，1是）',
  `train_duration` varchar(32) DEFAULT NULL COMMENT '培训时长',
  `plan_id` varchar(64) DEFAULT NULL COMMENT '培训计划',
  `files` varchar(255) DEFAULT NULL COMMENT '过程资料',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of train_record
-- ----------------------------
INSERT INTO `train_record` VALUES ('1c9003a5feb44de68cead755f7261dc8', '2017-05-21技术培训', '26', '2017-05-31 08:16:29', '11', '0', '1', '0', '1', '2017-05-21 17:31:53', '1', '2017-05-21 17:31:53', null, '0', '0', null, null, null, '1', '0', '1', null);
INSERT INTO `train_record` VALUES ('7db3d55b7fe6405183c35457d2c01303', '2017年研发项目培训', '6', '2017-05-31 16:26:57', '9', '12', '6', '0', '1', '2017-05-20 16:28:27', '1', '2017-05-21 16:54:34', '', '0', '1', null, '', '', '1', '23水电费', '1', '|/jeesite/userfiles/1/files/train/record/trainRecord/2017/05/__3_1_1_20160514130351.jpg|/jeesite/userfiles/1/files/train/record/trainRecord/2017/05/__3_1_1_20160514130351.jpg');
INSERT INTO `train_record` VALUES ('d12af463cac74507a8790fbe2b94bb06', '2017-05-21技术培训', '26', '2017-05-31 08:16:29', '11', '0', '1', '0', '1', '2017-05-21 17:34:59', '1', '2017-05-21 17:34:59', null, '0', '0', null, null, null, '1', '0', '1', null);
INSERT INTO `train_record` VALUES ('fd2a1b98198c4eaba0984855901fc41b', '测试', '2', '2017-05-21 15:22:56', '6', '21', '1', '1', '1', '2017-05-20 15:23:45', '1', '2017-05-20 16:22:04', '', '0', '1', '2017-05-02 15:23:26', '34', '33', '1', '23', null, null);

-- ----------------------------
-- Table structure for train_record_courseware
-- ----------------------------
DROP TABLE IF EXISTS `train_record_courseware`;
CREATE TABLE `train_record_courseware` (
  `id` varchar(64) NOT NULL COMMENT '编码',
  `record_id` varchar(64) NOT NULL COMMENT '培训记录',
  `courseware_id` varchar(64) NOT NULL COMMENT '课件',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `courseware_id` (`courseware_id`),
  KEY `record_id` (`record_id`),
  CONSTRAINT `train_record_courseware_ibfk_1` FOREIGN KEY (`courseware_id`) REFERENCES `train_courseware` (`id`),
  CONSTRAINT `train_record_courseware_ibfk_2` FOREIGN KEY (`record_id`) REFERENCES `train_record` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of train_record_courseware
-- ----------------------------

-- ----------------------------
-- Table structure for train_record_score
-- ----------------------------
DROP TABLE IF EXISTS `train_record_score`;
CREATE TABLE `train_record_score` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `record_id` varchar(64) NOT NULL COMMENT '培训记录',
  `user_id` varchar(64) NOT NULL COMMENT '受培人员',
  `score` varchar(32) NOT NULL COMMENT '培训成绩',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `record_id` (`record_id`),
  CONSTRAINT `train_record_score_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `train_record` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of train_record_score
-- ----------------------------
INSERT INTO `train_record_score` VALUES ('ae3bb958a8df400c84419fecadecbc61', '7db3d55b7fe6405183c35457d2c01303', '6', '23.7', '1', '2017-05-20 16:28:27', '1', '2017-05-20 16:28:27', '', '1');
