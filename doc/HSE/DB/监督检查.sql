/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50619
Source Host           : localhost:3306
Source Database       : hse

Target Server Type    : MYSQL
Target Server Version : 50619
File Encoding         : 65001

Date: 2017-05-20 09:37:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for check_item
-- ----------------------------
DROP TABLE IF EXISTS `check_item`;
CREATE TABLE `check_item` (
  `id` varchar(64) NOT NULL,
  `template_id` varchar(64) DEFAULT NULL,
  `check_content` text COMMENT '检查项的内容',
  `check_standard` varchar(255) DEFAULT NULL COMMENT '检查项的合格标准',
  `sort` int(11) DEFAULT NULL COMMENT '排序序号',
  `craete_by` varchar(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标识',
  `obligate_1` varchar(255) DEFAULT NULL,
  `obligate_2` varchar(255) DEFAULT NULL,
  `obligate_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每个检查模板中的检查项';

-- ----------------------------
-- Table structure for check_item_check
-- ----------------------------
DROP TABLE IF EXISTS `check_item_check`;
CREATE TABLE `check_item_check` (
  `id` varchar(64) NOT NULL,
  `inspct_id` varchar(64) DEFAULT NULL COMMENT '检查记录表id',
  `check_item_id` varchar(64) DEFAULT NULL,
  `check_result` varchar(64) DEFAULT NULL,
  `check_time` datetime DEFAULT NULL,
  `report_status` varchar(64) DEFAULT NULL COMMENT '该检查项的检查结果是上报还是未上报。',
  `craete_by` varchar(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标识',
  `obligate_1` varchar(255) DEFAULT NULL,
  `obligate_2` varchar(255) DEFAULT NULL,
  `obligate_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用于存储上报状态、具体检查时间与检查结果。';

-- ----------------------------
-- Table structure for check_template
-- ----------------------------
DROP TABLE IF EXISTS `check_template`;
CREATE TABLE `check_template` (
  `id` varchar(64) NOT NULL,
  `template_name` varchar(100) DEFAULT NULL,
  `template_desc` varchar(500) DEFAULT NULL,
  `upload_time` datetime DEFAULT NULL,
  `upload_person_id` varchar(100) DEFAULT NULL,
  `used_status` varchar(64) DEFAULT '启用' COMMENT '默认为启用状态，用户可修改为停用状态。',
  `create_by` varchar(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标识',
  `obligate_1` varchar(255) DEFAULT NULL,
  `obligate_2` varchar(255) DEFAULT NULL,
  `obligate_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for check_type_class
-- ----------------------------
DROP TABLE IF EXISTS `check_type_class`;
CREATE TABLE `check_type_class` (
  `id` varchar(64) NOT NULL COMMENT '检查表ID',
  `name` varchar(200) DEFAULT NULL COMMENT '检查的分类名称',
  `type_desc` varchar(255) DEFAULT NULL COMMENT '检查分类描述',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序',
  `parent_id` varchar(64) DEFAULT NULL,
  `parent_ids` varchar(500) DEFAULT NULL,
  `craete_by` varchar(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标识',
  `obligate_1` varchar(255) DEFAULT NULL,
  `obligate_2` varchar(255) DEFAULT NULL,
  `obligate_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检查类别分类';

-- ----------------------------
-- Table structure for checker
-- ----------------------------
DROP TABLE IF EXISTS `checker`;
CREATE TABLE `checker` (
  `checker_id` varchar(64) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `quesition_id` varchar(64) DEFAULT NULL,
  `obligate_1` varchar(255) DEFAULT NULL,
  `obligate_2` varchar(255) DEFAULT NULL,
  `obligate_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`checker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录问题的抄送人。';

-- ----------------------------
-- Table structure for inspct
-- ----------------------------
DROP TABLE IF EXISTS `inspct`;
CREATE TABLE `inspct` (
  `id` varchar(64) NOT NULL,
  `type_id` varchar(64) DEFAULT NULL,
  `check_dept` varchar(64) DEFAULT NULL COMMENT '检查部门id',
  `check_person` varchar(64) DEFAULT NULL,
  `check_date` datetime DEFAULT NULL,
  `inspection_dept_id` varchar(200) DEFAULT NULL,
  `template_id` varchar(64) DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标识',
  `obligate_1` varchar(255) DEFAULT NULL,
  `obligate_2` varchar(255) DEFAULT NULL,
  `obligate_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` varchar(64) NOT NULL,
  `check_item_id` varchar(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `question_desc` varchar(255) DEFAULT NULL,
  `question_class_id` varchar(255) DEFAULT NULL,
  `question_level_id` varchar(64) DEFAULT NULL,
  `inspection_dept_type_id` varchar(64) DEFAULT NULL COMMENT '引用数据字典的ID，该类别引用的是内部单位，则受检单位ID是公司部门ID，否则是承包商的名称或ID\r\n            此字段应在问题表中',
  `state_id` varchar(64) DEFAULT NULL COMMENT '该问题的处理状态有：受理中，审批中，待关闭，已关闭。',
  `approval_opinion` varchar(255) DEFAULT NULL COMMENT '上报人所在部门领导审批上报问题',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
  `accept_person_id` varchar(64) DEFAULT NULL COMMENT '受检单位指定的责任人',
  `ractification_person_id` varchar(64) DEFAULT NULL,
  `ractification_state_id` varchar(64) DEFAULT NULL COMMENT '检查项的整改状态',
  `accept_time` datetime DEFAULT NULL COMMENT '指定的开始时间',
  `specify_end_time` datetime DEFAULT NULL COMMENT '指定的结束时间',
  `real_end_time` datetime DEFAULT NULL,
  `closer_id` varchar(64) DEFAULT NULL,
  `close_time` datetime DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_by` varchar(64) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标识',
  `document_id` varchar(64) DEFAULT NULL COMMENT '文档即附件集合的标识，可以关联多个附件',
  `upload_time` datetime DEFAULT NULL,
  `proc_ins_id` varchar(64) DEFAULT NULL COMMENT '流程实例id',
  `reporter_comment` varchar(255) DEFAULT NULL COMMENT '问题上报者意见',
  `reporter_leader_comment` varchar(255) DEFAULT NULL COMMENT '问题上报者部门负责人意见',
  `rectifier_leader_comment` varchar(255) DEFAULT NULL COMMENT '整改部门负责人意见',
  `rectifier_comment` varchar(255) DEFAULT NULL COMMENT '整改者意见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储问题';

-- ----------------------------
-- Table structure for question_audition
-- ----------------------------
DROP TABLE IF EXISTS `question_audition`;
CREATE TABLE `question_audition` (
  `id` varchar(64) NOT NULL,
  `auditor_id` varchar(64) DEFAULT NULL,
  `audit_desc` varchar(500) DEFAULT NULL,
  `audit_time` datetime DEFAULT NULL,
  `question_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for question_comment
-- ----------------------------
DROP TABLE IF EXISTS `question_comment`;
CREATE TABLE `question_comment` (
  `access_review_id` varchar(64) NOT NULL,
  `quesition_id` varchar(64) DEFAULT NULL,
  `comm` varchar(255) DEFAULT NULL,
  `comment_time` datetime DEFAULT NULL,
  `review_desc` varchar(255) DEFAULT NULL,
  `obligate_1` varchar(255) DEFAULT NULL,
  `obligate_2` varchar(255) DEFAULT NULL,
  `obligate_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`access_review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对于上报问题的评论。';

-- ----------------------------
-- Table structure for question_copy
-- ----------------------------
DROP TABLE IF EXISTS `question_copy`;
CREATE TABLE `question_copy` (
  `id` varchar(64) NOT NULL,
  `quesition_id` varchar(64) DEFAULT NULL,
  `copy_type_id` varchar(64) DEFAULT NULL COMMENT '类别包括， 部门领导，质量环保科，公司领导等。',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='这个记录的是，问题与抄送类型之间的关联。';

-- ----------------------------
-- Table structure for rectification_scene_picture
-- ----------------------------
DROP TABLE IF EXISTS `rectification_scene_picture`;
CREATE TABLE `rectification_scene_picture` (
  `rectification_scene_picture_id` varchar(64) NOT NULL,
  `question_id` varchar(64) DEFAULT NULL,
  `rectification_description` varchar(500) DEFAULT NULL,
  `picture_desc` varchar(255) DEFAULT NULL,
  `doc_id` varchar(64) DEFAULT NULL,
  `upload_time` datetime DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `obligate_1` varchar(255) DEFAULT NULL,
  `obligate_2` varchar(255) DEFAULT NULL,
  `obligate_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rectification_scene_picture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='整改现场照片';

-- ----------------------------
-- Table structure for reporting_quesition_feedback
-- ----------------------------
DROP TABLE IF EXISTS `reporting_quesition_feedback`;
CREATE TABLE `reporting_quesition_feedback` (
  `id` varchar(64) NOT NULL COMMENT '上报问题整改ID',
  `name` varchar(100) DEFAULT NULL,
  `quesition_id` varchar(64) DEFAULT NULL,
  `feedback_content` varchar(500) DEFAULT NULL,
  `feedback_time` datetime DEFAULT NULL,
  `feedback_person_id` varchar(64) DEFAULT NULL,
  `obligate_1` varchar(255) DEFAULT NULL,
  `obligate_2` varchar(255) DEFAULT NULL,
  `obligate_3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
