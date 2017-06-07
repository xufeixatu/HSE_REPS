SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS train_need_matrix;
DROP TABLE IF EXISTS train_content;
DROP TABLE IF EXISTS train_record_courseware;
DROP TABLE IF EXISTS train_courseware;
DROP TABLE IF EXISTS train_job;
DROP TABLE IF EXISTS train_plan;
DROP TABLE IF EXISTS train_record_score;
DROP TABLE IF EXISTS train_record;




/* Create Tables */

-- 培训知识内容信息表
CREATE TABLE train_content
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 序号
	sn varchar(8) NOT NULL COMMENT '序号',
	-- 培训知识内容名称
	name varchar(100) NOT NULL COMMENT '培训知识内容名称',
	-- 培训分类
	classify varchar(8) NOT NULL COMMENT '培训分类',
	first_period varchar(32),
	-- 复培课时/频率 (小时/N年)
	next_period varchar(32) COMMENT '复培课时/频率 (小时/N年)',
	-- 培训组织单位
	organizer varchar(128) NOT NULL COMMENT '培训组织单位',
	-- 培训完成要求 (职前/职后)
	requirement char(1) NOT NULL COMMENT '培训完成要求 (职前/职后)',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
) COMMENT = '培训知识内容信息表' DEFAULT CHARACTER SET utf8;


CREATE TABLE train_courseware
(
	-- 编码
	id varchar(64) NOT NULL COMMENT '编码',
	file varchar(255),
	-- 课件名称
	name varchar(64) COMMENT '课件名称',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8;


-- 培训岗位信息表
CREATE TABLE train_job
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 序号
	sn varchar(32) NOT NULL COMMENT '序号',
	-- 培训岗位名称
	name varchar(100) NOT NULL COMMENT '培训岗位名称',
	-- 岗位分类(0：通用类；A：厂机关及附属,B：基层单位)
	classify char(1) NOT NULL COMMENT '岗位分类(0：通用类；A：厂机关及附属,B：基层单位)',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
) COMMENT = '培训岗位信息表' DEFAULT CHARACTER SET utf8;


CREATE TABLE train_need_matrix
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 版本号
	version varchar(8) COMMENT '版本号',
	-- 培训岗位编码
	job_id varchar(64) NOT NULL COMMENT '培训岗位编码',
	-- 培训知识内容编号
	content_id varchar(64) NOT NULL COMMENT '培训知识内容编号',
	-- 培训有效起始时间
	start_time datetime COMMENT '培训有效起始时间',
	-- 培训有效截止时间
	-- 
	end_time datetime COMMENT '培训有效截止时间
',
	-- 培训状态（已培训、未培训）
	-- 
	status varchar(8) COMMENT '培训状态（已培训、未培训）
',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8;


CREATE TABLE train_plan
(
	id varchar(64) NOT NULL,
	object_office_id varchar(64) NOT NULL,
	-- 培训分类
	classify varchar(8) NOT NULL COMMENT '培训分类',
	-- 培训主题
	name varchar(255) NOT NULL COMMENT '培训主题',
	-- 培训对象(1:管理人员，0:操作人员)
	train_object varchar(8) NOT NULL COMMENT '培训对象(1:管理人员，0:操作人员)',
	-- 培训时间
	train_time datetime NOT NULL COMMENT '培训时间',
	-- 学时
	period varchar(32) NOT NULL COMMENT '学时',
	-- 培训人数
	plan_number int NOT NULL COMMENT '培训人数',
	-- 培训方式
	train_method varchar(8) NOT NULL COMMENT '培训方式',
	-- 责任单位
	subject_office_id varchar(64) NOT NULL COMMENT '责任单位',
	-- 培训频率
	frequency varchar(32) NOT NULL COMMENT '培训频率',
	-- 培训要求
	requirement varchar(255) NOT NULL COMMENT '培训要求',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	-- 计划状态（新建/发布/取消）
	status varchar(8) NOT NULL COMMENT '计划状态（新建/发布/取消）',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8;


CREATE TABLE train_record
(
	id varchar(64) NOT NULL,
	-- 培训主题
	name varchar(255) NOT NULL COMMENT '培训主题',
	object_office_id varchar(64) NOT NULL,
	-- 培训分类(法定安全取证培训、HSE管理制度及基本知识培训、岗位应急培训、HSE技能培训)
	classify varchar(8) COMMENT '培训分类(法定安全取证培训、HSE管理制度及基本知识培训、岗位应急培训、HSE技能培训)',
	-- 培训方式（集中/送外/在线培训）
	train_method varchar(8) COMMENT '培训方式（集中/送外/在线培训）',
	-- 培训对象（管理人员、操作人员）
	train_object varchar(8) COMMENT '培训对象（管理人员、操作人员）',
	-- 培训时间
	train_time datetime NOT NULL COMMENT '培训时间',
	-- 培训时长
	train_duration varchar(32) COMMENT '培训时长',
	-- 责任单位
	subject_office_id varchar(64) NOT NULL COMMENT '责任单位',
	-- 培训讲师姓名
	teacher_name varchar(32) COMMENT '培训讲师姓名',
	-- 培训人数
	plan_number int NOT NULL COMMENT '培训人数',
	-- 联系人
	contact varchar(64) NOT NULL COMMENT '联系人',
	-- 归档状态（-1取消，0草稿，1归档）
	status varchar(8) DEFAULT '0' NOT NULL COMMENT '归档状态（-1取消，0草稿，1归档）',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	-- 是否考试
	is_exam varchar(8) NOT NULL COMMENT '是否考试',
	-- 考试时间
	exam_time datetime COMMENT '考试时间',
	-- 考试时长
	exam_duration varchar(8) COMMENT '考试时长',
	pass varchar(32),
	-- 是否培训计划的记录（0否，1是）
	is_plan varchar(8) NOT NULL COMMENT '是否培训计划的记录（0否，1是）',
	-- 培训计划
	plan_id varchar(64) COMMENT '培训计划',
	-- 培训记录过程的照片文件
	files varchar(255) COMMENT '培训记录过程的照片文件',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8;


CREATE TABLE train_record_courseware
(
	-- 编码
	id varchar(64) NOT NULL COMMENT '编码',
	-- 培训记录
	record_id varchar(64) NOT NULL COMMENT '培训记录',
	-- 课件
	courseware_id varchar(64) NOT NULL COMMENT '课件',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8;


CREATE TABLE train_record_score
(
	-- 编号
	id varchar(64) NOT NULL COMMENT '编号',
	-- 培训记录
	record_id varchar(64) NOT NULL COMMENT '培训记录',
	-- 受培人员
	user_id varchar(64) NOT NULL COMMENT '受培人员',
	-- 培训成绩
	score varchar(32) NOT NULL COMMENT '培训成绩',
	-- 创建者
	create_by varchar(64) NOT NULL COMMENT '创建者',
	-- 创建时间
	create_date datetime NOT NULL COMMENT '创建时间',
	-- 更新者
	update_by varchar(64) NOT NULL COMMENT '更新者',
	-- 更新时间
	update_date datetime NOT NULL COMMENT '更新时间',
	-- 备注信息
	remarks varchar(255) COMMENT '备注信息',
	-- 删除标记（0：正常；1：删除）
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记（0：正常；1：删除）',
	PRIMARY KEY (id)
) DEFAULT CHARACTER SET utf8;



/* Create Foreign Keys */

ALTER TABLE train_need_matrix
	ADD FOREIGN KEY (content_id)
	REFERENCES train_content (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE train_record_courseware
	ADD FOREIGN KEY (courseware_id)
	REFERENCES train_courseware (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE train_need_matrix
	ADD FOREIGN KEY (job_id)
	REFERENCES train_job (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE train_record_courseware
	ADD FOREIGN KEY (record_id)
	REFERENCES train_record (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE train_record_score
	ADD FOREIGN KEY (record_id)
	REFERENCES train_record (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



