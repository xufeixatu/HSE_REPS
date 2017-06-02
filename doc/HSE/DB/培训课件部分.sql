/*
Navicat MySQL Data Transfer

Source Server         : hse
Source Server Version : 50096
Source Host           : localhost:3306
Source Database       : hse

Target Server Type    : MYSQL
Target Server Version : 50096
File Encoding         : 65001

Date: 2017-06-02 12:09:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for course_catalog
-- ----------------------------
DROP TABLE IF EXISTS `course_catalog`;
CREATE TABLE `course_catalog` (
  `id` varchar(64) NOT NULL,
  `catalog_name` varchar(64) default NULL,
  `catalog_desc` varchar(255) default NULL,
  `parent_id` varchar(64) default NULL,
  `parent_ids` varchar(2000) default NULL,
  `name` varchar(100) default NULL,
  `sort` decimal(10,0) default NULL,
  `create_by` varchar(64) default NULL,
  `create_date` datetime default NULL,
  `update_by` varchar(64) default NULL,
  `update_date` datetime default NULL,
  `remarks` varchar(255) default NULL,
  `del_flag` char(1) NOT NULL default '',
  PRIMARY KEY  (`id`,`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_catalog
-- ----------------------------
INSERT INTO `course_catalog` VALUES ('058f2b4e02444e58acce1d0f4ebc8cbd', 'CSS', '', '25b3cb7e748e41af8786098f80620dde', '0,25b3cb7e748e41af8786098f80620dde,', null, '2', '1', '2017-06-01 20:33:23', '1', '2017-06-01 20:33:23', null, '0');
INSERT INTO `course_catalog` VALUES ('142c8a014c634c7780e60902ad310520', '数据库', '数据库相关技术', '0', '0,', null, '40', '1', '2017-06-01 20:32:32', '1', '2017-06-01 20:32:32', null, '0');
INSERT INTO `course_catalog` VALUES ('16bf28ed55a948e588f6a195429ad063', '后端开发', '后端开发系列', '0', '0,', null, '20', '1', '2017-06-01 20:32:00', '1', '2017-06-01 20:32:00', null, '0');
INSERT INTO `course_catalog` VALUES ('25b3cb7e748e41af8786098f80620dde', '前端开发', '前端开发系列', '0', '0,', null, '10', '1', '2017-06-01 20:24:56', '1', '2017-06-01 20:24:56', null, '0');
INSERT INTO `course_catalog` VALUES ('30d93da412eb4891b7095207f5359fae', 'MySql', 'MySql', '142c8a014c634c7780e60902ad310520', '0,142c8a014c634c7780e60902ad310520,', null, '30', '1', '2017-06-01 20:35:13', '1', '2017-06-01 20:35:13', null, '0');
INSERT INTO `course_catalog` VALUES ('4e6197f34838416fb3edfe5ba1141aeb', 'C++', 'C++', '16bf28ed55a948e588f6a195429ad063', '0,16bf28ed55a948e588f6a195429ad063,', null, '31', '1', '2017-06-01 20:34:22', '1', '2017-06-01 20:34:22', null, '0');
INSERT INTO `course_catalog` VALUES ('b278de3ec3ff499c856ea8e81b8775e7', 'C语言', 'C语言', '16bf28ed55a948e588f6a195429ad063', '0,16bf28ed55a948e588f6a195429ad063,', null, '1', '1', '2017-06-01 20:34:13', '1', '2017-06-01 20:34:13', null, '0');
INSERT INTO `course_catalog` VALUES ('b553178c425140a68bbd1141ae81b885', 'JavaScript', 'JavaScript', '25b3cb7e748e41af8786098f80620dde', '0,25b3cb7e748e41af8786098f80620dde,', null, '3', '1', '2017-06-01 20:33:48', '1', '2017-06-01 20:33:48', null, '0');
INSERT INTO `course_catalog` VALUES ('c1baeafdb29c4e87ba9446b9f6db64d2', 'Android', 'Android', 'd6b6ef87029d44ce99097a7c067d1be0', '0,d6b6ef87029d44ce99097a7c067d1be0,', null, '1', '1', '2017-06-01 20:34:57', '1', '2017-06-01 20:34:57', null, '0');
INSERT INTO `course_catalog` VALUES ('d6b6ef87029d44ce99097a7c067d1be0', '移动开发', '移动开发系列', '0', '0,', null, '30', '1', '2017-06-01 20:32:16', '1', '2017-06-01 20:32:16', null, '0');
INSERT INTO `course_catalog` VALUES ('fe8d73f8870e48b19983a8770a4856f8', 'HTML', 'HTML语言', '25b3cb7e748e41af8786098f80620dde', '0,25b3cb7e748e41af8786098f80620dde,', null, '1', '1', '2017-06-01 20:33:03', '1', '2017-06-01 20:33:03', null, '0');

-- ----------------------------
-- Table structure for course_catelog
-- ----------------------------
DROP TABLE IF EXISTS `course_catelog`;
CREATE TABLE `course_catelog` (
  `id` varchar(64) NOT NULL,
  `course_id` varchar(64) default NULL,
  `attach_id` varchar(64) default NULL,
  `attach_name` varchar(255) default NULL,
  `create_by` varchar(64) default NULL,
  `create_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `update_by` varchar(64) default NULL,
  `update_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `remarks` varchar(255) default NULL,
  `del_flag` char(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_catelog
-- ----------------------------
INSERT INTO `course_catelog` VALUES ('35643970543a4ccf92689d060a4c0599', 'wesadf', 'asdfd', '试试而非的善意', '1', '2017-05-17 21:45:48', '1', '2017-05-17 21:45:48', '阿三打', '0');

-- ----------------------------
-- Table structure for course_review
-- ----------------------------
DROP TABLE IF EXISTS `course_review`;
CREATE TABLE `course_review` (
  `id` varchar(64) NOT NULL,
  `course_id` varchar(64) default NULL,
  `assess_by_id` varchar(64) default NULL,
  `assess_opinion` varchar(255) default NULL,
  `assess_grade` varchar(64) default NULL,
  `unused_1` varchar(64) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_review
-- ----------------------------

-- ----------------------------
-- Table structure for course_study
-- ----------------------------
DROP TABLE IF EXISTS `course_study`;
CREATE TABLE `course_study` (
  `id` varchar(64) NOT NULL,
  `course_id` varchar(64) default NULL,
  `train_by_id` varchar(64) default NULL,
  `study_status` varchar(64) default NULL,
  `study_time` datetime default NULL,
  `study_date` datetime default NULL,
  `study_start_time` datetime default NULL,
  `study_end_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_study
-- ----------------------------

-- ----------------------------
-- Table structure for train_course
-- ----------------------------
DROP TABLE IF EXISTS `train_course`;
CREATE TABLE `train_course` (
  `id` varchar(64) NOT NULL,
  `train_plan_extra_id` varchar(64) default NULL,
  `course_type_id` varchar(64) default NULL,
  `cover_id` varchar(255) default NULL,
  `doc_id` varchar(500) default NULL,
  `course_name` varchar(255) default NULL,
  `course_dec` varchar(255) default NULL,
  `course_time` varchar(64) default NULL,
  `course_count` varchar(64) default '0',
  `course_grade` varchar(64) default '0',
  `upload_by` varchar(64) default NULL,
  `upload_time` datetime default NULL,
  `create_by` varchar(64) default NULL,
  `create_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `update_by` varchar(64) default NULL,
  `update_date` timestamp NOT NULL default '0000-00-00 00:00:00',
  `remarks` varchar(255) default NULL,
  `del_flag` char(1) default NULL,
  `unused_1` varchar(64) default NULL,
  `unused_2` varchar(64) default NULL,
  `unused_3` varchar(64) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of train_course
-- ----------------------------
INSERT INTO `train_course` VALUES ('023e54a4684f439aa30ade982e57223e', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/u19456.png', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '商务礼仪与交往艺术', '合乎礼仪的形象，合乎形象的礼仪', '13', null, null, '王少昌', '2017-05-17 19:26:40', '1', '2017-05-20 19:40:29', '1', '2017-05-17 19:26:42', null, '0', null, null, null);
INSERT INTO `train_course` VALUES ('1032b1d728484afc96b3faaf2448f2d5', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/images.jpg', '||||||/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4||/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie2(1).mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie2.mp4', '测试课件', '测试课件', '12', null, null, null, '2017-05-31 14:20:18', '1', '2017-05-31 14:22:36', '1', '2017-05-20 20:53:33', null, '0', null, null, null);
INSERT INTO `train_course` VALUES ('4f38957f3aa64d92909bf864132bbf85', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/u19454.png', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '有效沟通', '巧用有效沟通技巧，化抗拒为联结', '4', null, null, '王少昌', '2017-05-17 19:31:47', '1', '2017-05-20 19:40:27', '1', '2017-05-17 19:31:49', null, '0', null, null, null);
INSERT INTO `train_course` VALUES ('55cbf64433b84416880c71b7b31136ff', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/images.jpg', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '新增测试课件', '测试课件描述', '365', null, null, '王少昌', '2017-05-19 21:30:53', '1', '2017-05-20 19:40:27', '1', '2017-05-19 21:30:55', null, '1', null, null, null);
INSERT INTO `train_course` VALUES ('5cb5ccbff7864ef18382e8b0d8668df4', null, null, '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/images.jpg', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '1', '1', '1', null, null, '1', '2017-05-17 19:10:42', '1', '2017-05-20 19:40:26', '1', '2017-05-17 19:10:43', null, '1', null, null, null);
INSERT INTO `train_course` VALUES ('968a463018a04fa0b41cf98175a55cfd', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/images.jpg', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/06/%E5%AD%A6%E4%B9%A0%E4%BD%BF%E4%BA%BA%E8%BF%9B%E6%AD%A5.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/06/%E7%9F%A5%E8%AF%86%E5%B0%B1%E6%98%AF%E5%8A%9B%E9%87%8F.mp4', 'HTML', 'HTML学习', '12', null, null, null, '2017-06-01 22:25:23', '1', '2017-06-02 11:49:46', '1', '2017-06-01 22:25:53', null, '1', null, null, null);
INSERT INTO `train_course` VALUES ('baad92ecfacc48dbb048f02b73fa3810', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/images.jpg', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie2.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie2(1).mp4', '11212', '2112', '32', null, null, null, '2017-05-31 15:01:44', '1', '2017-05-31 15:02:14', '1', '2017-05-31 15:02:14', null, '0', null, null, null);
INSERT INTO `train_course` VALUES ('bcbe49092c8d4708b5584a96e1cbd6f3', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/u19458.png', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '测试', '测试', '1', null, null, '王少昌', '2017-05-19 21:38:43', '1', '2017-05-20 19:40:25', '1', '2017-05-19 21:38:45', null, '1', null, null, null);
INSERT INTO `train_course` VALUES ('c455792364db43f59761bcd21c08f774', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/images.jpg', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/06/%E7%9F%A5%E8%AF%86%E5%B0%B1%E6%98%AF%E5%8A%9B%E9%87%8F.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/06/%E5%AD%A6%E4%B9%A0%E4%BD%BF%E4%BA%BA%E8%BF%9B%E6%AD%A5.mp4', '芝士就是力量', '没有吃饱哪有力气减肥', '2', null, null, null, '2017-06-01 16:24:22', '1', '2017-06-02 12:06:53', '1', '2017-06-01 16:25:36', null, '1', null, null, null);
INSERT INTO `train_course` VALUES ('c677ee0792e54adb837a20e3de923659', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/u19458.png', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '关键对话', '关键对话，怎样才能产生关键作用？', '16', null, null, '王少昌', '2017-05-17 19:32:32', '1', '2017-05-20 19:40:24', '1', '2017-05-17 19:32:33', null, '0', null, null, null);
