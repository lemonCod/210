/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50727
Source Host           : localhost:3306
Source Database       : experiment_report

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2019-09-20 12:42:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '班级id',
  `class_name` varchar(64) NOT NULL COMMENT '班级名称',
  `grade_id` int(11) DEFAULT '1' COMMENT '学生年级',
  `college_id` int(11) DEFAULT '1' COMMENT '学院id',
  `teacher_id` int(11) NOT NULL COMMENT '教师id',
  `is_valid` tinyint(3) NOT NULL DEFAULT '1' COMMENT '默认1为有效，0为无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`class_id`) USING BTREE,
  KEY `fk_college_id` (`college_id`),
  KEY `fk_grade_id` (`grade_id`),
  KEY `fk_teacher_id` (`teacher_id`),
  CONSTRAINT `fk_college_id` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_grade_id` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`grade_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='班级表';

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES ('1', '医软1班', '1', '1', '1', '1', '2019-09-15 18:34:07', '2019-09-15 18:34:07');
INSERT INTO `class` VALUES ('2', '医软2班', '2', '1', '1', '1', '2019-09-15 18:38:18', '2019-09-15 18:38:18');
INSERT INTO `class` VALUES ('3', '涉外1班', '1', '1', '2', '1', '2019-09-15 18:38:43', '2019-09-15 18:38:43');
INSERT INTO `class` VALUES ('4', '涉外2班', '1', '1', '2', '1', '2019-09-15 18:39:10', '2019-09-15 18:39:10');

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college` (
  `college_id` int(11) NOT NULL,
  `college_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '学院名称',
  PRIMARY KEY (`college_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES ('1', '医药信息工程学院');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '课程名称',
  PRIMARY KEY (`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '微机原理');
INSERT INTO `course` VALUES ('2', '计算机网络');
INSERT INTO `course` VALUES ('3', '操作系统');

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade` (
  `grade_id` int(11) NOT NULL AUTO_INCREMENT,
  `grade_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`grade_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES ('1', '16级');
INSERT INTO `grade` VALUES ('2', '17级');
INSERT INTO `grade` VALUES ('3', '18级');
INSERT INTO `grade` VALUES ('4', '19级');

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` char(32) NOT NULL COMMENT '作业id',
  `class_id` int(11) NOT NULL COMMENT '班级id',
  `student_number` varchar(64) NOT NULL COMMENT '学生学号',
  `report_name` varchar(64) NOT NULL COMMENT '学生自己修改的作业名字',
  `report_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '提交的报告存放路径',
  `report_correct` tinyint(3) NOT NULL DEFAULT '0' COMMENT '0为未批阅,1为已批阅',
  `task_grade` double(11,0) DEFAULT NULL COMMENT '作业成绩',
  `is_valid` tinyint(3) NOT NULL DEFAULT '1' COMMENT '默认1为有效，0为无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `student_number` (`student_number`),
  KEY `report_ibfk_2` (`class_id`),
  KEY `task_id` (`task_id`),
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`student_number`) REFERENCES `student` (`student_number`) ON UPDATE CASCADE,
  CONSTRAINT `report_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON UPDATE CASCADE,
  CONSTRAINT `report_ibfk_3` FOREIGN KEY (`task_id`) REFERENCES `task_notice` (`task_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='作业提交表';

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES ('1', '79c0e389', '2', '2016207320107', '测试实验报告', 'http://localhost:8080/submit/static/image/fd01ec91_2016207320050-16医软一班-张琪- 图形点阵显示实验.doc', '0', null, '1', '2019-09-17 18:39:43', '2019-09-17 18:39:50');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_number` varchar(64) NOT NULL COMMENT '学生学号',
  `student_name` varchar(32) NOT NULL COMMENT '学生姓名',
  `student_password` varchar(64) NOT NULL COMMENT '学生密码',
  `student_sex` tinyint(3) DEFAULT NULL COMMENT '学生性别，默认1为男，0为女',
  `class_id` int(11) NOT NULL COMMENT '班级id',
  `is_valid` tinyint(3) NOT NULL DEFAULT '1' COMMENT '默认1为有效，0为无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`student_id`) USING BTREE,
  UNIQUE KEY `unq_studnet_number` (`student_number`) USING BTREE,
  KEY `fk_class_id` (`class_id`),
  CONSTRAINT `fk_class_id` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='学生表';

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '2016207320107', '吴涛', '2016207320107', null, '2', '1', '2019-09-15 21:34:44', '2019-09-17 18:42:12');
INSERT INTO `student` VALUES ('2', '2016207320106', '沈默', '2016207320106', null, '2', '1', '2019-09-17 18:43:20', '2019-09-17 18:43:20');
INSERT INTO `student` VALUES ('3', '2016207320105', '陈平安', '2016207320105', null, '2', '1', '2019-09-17 18:43:54', '2019-09-17 18:43:54');

-- ----------------------------
-- Table structure for task_notice
-- ----------------------------
DROP TABLE IF EXISTS `task_notice`;
CREATE TABLE `task_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` char(32) NOT NULL COMMENT '作业id',
  `term_id` int(11) NOT NULL COMMENT '学期id',
  `class_id` int(11) NOT NULL COMMENT '班级id',
  `task_name` varchar(64) NOT NULL COMMENT '作业名称',
  `course_id` int(11) NOT NULL COMMENT '课程名称id',
  `teacher_number` varchar(64) DEFAULT NULL COMMENT '教师工号',
  `task_path` varchar(255) DEFAULT NULL COMMENT '布置的作业存放路径',
  `is_valid` tinyint(3) NOT NULL DEFAULT '1' COMMENT '默认1为有效，0为无效',
  `submit_deadline` date DEFAULT NULL COMMENT '学生提交截止时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_term_id` (`term_id`),
  KEY `id` (`id`,`task_id`),
  KEY `task_id` (`task_id`),
  KEY `class_id` (`class_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `fk_term_id` FOREIGN KEY (`term_id`) REFERENCES `term` (`term_id`) ON UPDATE CASCADE,
  CONSTRAINT `task_notice_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON UPDATE CASCADE,
  CONSTRAINT `task_notice_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='作业发布表';

-- ----------------------------
-- Records of task_notice
-- ----------------------------
INSERT INTO `task_notice` VALUES ('3', '79c0e389', '1', '3', '双字节码运算', '2', '102', 'http://localhost:8080/submit/static/image/38cb15cc_2016207320056-赵雅倩-16医软一班-图形点阵显示实验.doc', '1', null, '2019-09-17 12:20:25', '2019-09-17 15:47:11');
INSERT INTO `task_notice` VALUES ('4', '41ab9d51', '1', '2', '交通灯控制实验', '2', '102', 'http://localhost:8080/submit/static/image/520fb7e4_2016207320029-16医软一班-汪泽- 图形点阵显示实验.doc', '1', null, '2019-09-17 12:27:40', '2019-09-17 15:46:49');
INSERT INTO `task_notice` VALUES ('5', 'e2ffbfcb', '1', '2', '语音模块实验', '1', '102', 'http://localhost:8080/submit/static/image/b1472f00_2016207320009-方奇-16医软1-图形点阵显示实验.docx', '1', null, '2019-09-17 12:32:08', '2019-09-17 15:46:54');
INSERT INTO `task_notice` VALUES ('6', 'd84c316c', '1', '2', '交通灯控制', '2', '101', 'http://localhost:8080/submit/static/image/a1160826_2016207320060-16医软一班-朱子豪-实验十二  图形点阵显示实验.doc', '1', null, '2019-09-17 12:37:55', '2019-09-17 13:04:47');
INSERT INTO `task_notice` VALUES ('7', '90f4b1d9', '1', '2', '电子风琴', '3', '101', 'http://localhost:8080/submit/static/image/b2bea971_2016207320030_16医软1班_王朝_图形点阵显示实验.doc', '1', '2019-09-20', '2019-09-17 12:40:47', '2019-09-17 15:46:07');
INSERT INTO `task_notice` VALUES ('9', 'fffa5fcc', '1', '2', '交通灯控制', '2', '101', 'http://localhost:8080/submit/static/image/fd01ec91_2016207320050-16医软一班-张琪- 图形点阵显示实验.doc', '1', '2019-09-21', '2019-09-17 18:37:53', '2019-09-17 18:37:53');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `teacher_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_number` varchar(64) NOT NULL COMMENT '教师工号',
  `teacher_name` varchar(32) NOT NULL COMMENT '教师姓名',
  `teacher_password` varchar(64) NOT NULL COMMENT '教师登录密码',
  `teacher_sex` tinyint(3) DEFAULT NULL COMMENT '性别,1为男,0为女',
  `identity` tinyint(3) DEFAULT NULL COMMENT '身份等级1为老师 2 为管理员',
  `is_valid` tinyint(3) NOT NULL DEFAULT '1' COMMENT '默认1为有效，0为无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`teacher_id`) USING BTREE,
  UNIQUE KEY `uqe_teacher_number` (`teacher_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='教师表';

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', '101', '张三', '252835', null, null, '1', '2019-09-08 21:52:19', '2019-09-08 21:52:19');
INSERT INTO `teacher` VALUES ('2', '102', '李四', '161726', null, null, '1', '2019-09-08 21:53:03', '2019-09-08 21:53:03');

-- ----------------------------
-- Table structure for term
-- ----------------------------
DROP TABLE IF EXISTS `term`;
CREATE TABLE `term` (
  `term_id` int(11) NOT NULL AUTO_INCREMENT,
  `study_year` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'xxx学年',
  `term_name` varchar(11) NOT NULL COMMENT 'xxx学期',
  `is_valid` tinyint(3) NOT NULL DEFAULT '1' COMMENT '默认1为有效，0为无效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `grade_id` int(11) NOT NULL COMMENT '年级id',
  PRIMARY KEY (`term_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='学期表';

-- ----------------------------
-- Records of term
-- ----------------------------
INSERT INTO `term` VALUES ('1', '2019-2020', '第1学期', '1', '2019-09-15 21:36:07', '2019-09-15 21:36:07', '1');
INSERT INTO `term` VALUES ('2', '2019-2020', '第1学期', '1', '2019-09-15 21:36:38', '2019-09-15 21:36:38', '2');
INSERT INTO `term` VALUES ('3', '2019-2020', '第1学期', '1', '2019-09-15 21:37:01', '2019-09-15 21:37:01', '3');
INSERT INTO `term` VALUES ('4', '2019-2020', '第1学期', '1', '2019-09-15 21:37:25', '2019-09-15 21:37:25', '4');
INSERT INTO `term` VALUES ('5', '2020-2021', '第2学期', '1', '2019-09-16 12:33:26', '2019-09-16 12:34:41', '1');
INSERT INTO `term` VALUES ('6', '2020-2021', '第2学期', '1', '2019-09-16 12:33:54', '2019-09-16 12:34:51', '2');
INSERT INTO `term` VALUES ('7', '2020-2021', '第2学期', '1', '2019-09-16 12:34:11', '2019-09-16 12:34:55', '3');
INSERT INTO `term` VALUES ('8', '2020-2021', '第2学期', '1', '2019-09-16 12:34:29', '2019-09-16 12:35:00', '4');
