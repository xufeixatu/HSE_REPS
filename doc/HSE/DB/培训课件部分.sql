/*
Navicat MySQL Data Transfer

Source Server         : hse
Source Server Version : 50096
Source Host           : localhost:3306
Source Database       : hse

Target Server Type    : MYSQL
Target Server Version : 50096
File Encoding         : 65001

Date: 2017-05-23 14:01:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for course_catalog
-- ----------------------------
DROP TABLE IF EXISTS `course_catalog`;
CREATE TABLE `course_catalog` (
  `id` varchar(64) NOT NULL,
  `catalog_name` varchar(64) default NULL,
  `catalog_desc` varchar(64) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_catalog
-- ----------------------------

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
  `update_date` timestamp NOT NULL default '2017-06-01 00:00:00',
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
  `update_date` timestamp NOT NULL default '2017-06-01 00:00:00',
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
INSERT INTO `train_course` VALUES ('1032b1d728484afc96b3faaf2448f2d5', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/images.jpg', '||/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '测试课件', '测试课件', '12', null, null, null, '2017-05-20 20:51:29', '1', '2017-05-20 20:53:33', '1', '2017-05-20 20:53:33', null, '0', null, null, null);
INSERT INTO `train_course` VALUES ('4f38957f3aa64d92909bf864132bbf85', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/u19454.png', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '有效沟通', '巧用有效沟通技巧，化抗拒为联结', '4', null, null, '王少昌', '2017-05-17 19:31:47', '1', '2017-05-20 19:40:27', '1', '2017-05-17 19:31:49', null, '0', null, null, null);
INSERT INTO `train_course` VALUES ('55cbf64433b84416880c71b7b31136ff', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/images.jpg', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '新增测试课件', '测试课件描述', '365', null, null, '王少昌', '2017-05-19 21:30:53', '1', '2017-05-20 19:40:27', '1', '2017-05-19 21:30:55', null, '1', null, null, null);
INSERT INTO `train_course` VALUES ('5cb5ccbff7864ef18382e8b0d8668df4', null, null, '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/images.jpg', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '1', '1', '1', null, null, '1', '2017-05-17 19:10:42', '1', '2017-05-20 19:40:26', '1', '2017-05-17 19:10:43', null, '1', null, null, null);
INSERT INTO `train_course` VALUES ('bcbe49092c8d4708b5584a96e1cbd6f3', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/u19458.png', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '测试', '测试', '1', null, null, '王少昌', '2017-05-19 21:38:43', '1', '2017-05-20 19:40:25', '1', '2017-05-19 21:38:45', null, '1', null, null, null);
INSERT INTO `train_course` VALUES ('c677ee0792e54adb837a20e3de923659', null, null, '/HSE/userfiles/1/files/train_course/trainCourse/2017/05/u19458.png', '|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4|/HSE/userfiles/1/files/train_course/trainCourse/2017/05/movie.mp4', '关键对话', '关键对话，怎样才能产生关键作用？', '16', null, null, '王少昌', '2017-05-17 19:32:32', '1', '2017-05-20 19:40:24', '1', '2017-05-17 19:32:33', null, '0', null, null, null);
