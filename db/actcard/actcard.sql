SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE actcard_unsafe;
DROP TABLE actcard;
DROP TABLE actcard_review;
DROP TABLE actcard_unsafe_event;




/* Create Tables */

CREATE TABLE actcard
(
	id varchar(64) NOT NULL COMMENT '编号',
	unsafe_acts text NOT NULL COMMENT '不安全行为',
	measure text NOT NULL COMMENT '解决措施',
	safety_acts text COMMENT '安全行为',
	suggestions text COMMENT '建议',
	reporter varchar(255) NOT NULL COMMENT '填报人',
	reporter_office varchar(255) NOT NULL COMMENT '填报人单位',
	reporting_time datetime NOT NULL COMMENT '填报时间',
	rectification_result text COMMENT '整改结果',
	closer varchar(255) COMMENT '关闭人',
	close_time datetime COMMENT '关闭时间',
	state varchar(255) COMMENT '状态',
	create_by varchar(64) NOT NULL COMMENT '创建者',
	create_date datetime NOT NULL COMMENT '创建时间',
	update_by varchar(64) NOT NULL COMMENT '更新者',
	update_date datetime NOT NULL COMMENT '更新时间',
	remarks varchar(255) COMMENT '备注信息',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记',
	act_card_unsafe_event_child_id text COMMENT '不安全分类子类',
	territorial_office_id varchar(64) COMMENT '属地单位',
	report_pic varchar(1000) COMMENT '上报时图片',
	rectification_pic varchar(1000) COMMENT '整改图片',
	act_card_unsafe_event_id text COMMENT '不安全分类',
	solver varchar(64) COMMENT '整改人',
	act_unsafe_other  COMMENT 'act不安全其他',
	PROC_INS_ID varchar(64) COMMENT '流程实例ID',
	PRIMARY KEY (id)
) COMMENT = 'ACT卡';


CREATE TABLE actcard_review
(
	id varchar(64) NOT NULL COMMENT '编号',
	content text COMMENT '评阅内容',
	act_card_id varchar(64) NOT NULL COMMENT '所评阅的ACT卡',
	create_by varchar(64) NOT NULL COMMENT '创建者',
	create_date datetime NOT NULL COMMENT '创建时间',
	update_by varchar(64) NOT NULL COMMENT '更新者',
	update_date datetime NOT NULL COMMENT '更新时间',
	remarks varchar(255) COMMENT '备注信息',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (id)
) COMMENT = 'ACT卡评阅';


CREATE TABLE actcard_unsafe
(
	unsafe_event_id varchar(64) NOT NULL COMMENT '不安全事件编号',
	actcard_id varchar(64) NOT NULL COMMENT 'actcard编号',
	parent_id varchar(64) NOT NULL COMMENT '父级编号',
	parent_ids varchar(2000) NOT NULL COMMENT '所有父级编号',
	name varchar(100) NOT NULL COMMENT '名称',
	sort decimal(10,0) NOT NULL COMMENT '排序',
	create_by varchar(64) NOT NULL COMMENT '创建者',
	create_date datetime NOT NULL COMMENT '创建时间',
	update_by varchar(64) NOT NULL COMMENT '更新者',
	update_date datetime NOT NULL COMMENT '更新时间',
	remarks varchar(255) COMMENT '备注信息',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记',
	PRIMARY KEY (unsafe_event_id, actcard_id)
) COMMENT = 'actcard_unsafe';


CREATE TABLE actcard_unsafe_event
(
	id varchar(64) NOT NULL COMMENT '编号',
	parent_id varchar(64) NOT NULL COMMENT '父级编号',
	parent_ids varchar(2000) NOT NULL COMMENT '所有父级编号',
	name varchar(100) NOT NULL COMMENT '名称',
	sort decimal(10,0) NOT NULL COMMENT '排序',
	create_by varchar(64) NOT NULL COMMENT '创建者',
	create_date datetime NOT NULL COMMENT '创建时间',
	update_by varchar(64) NOT NULL COMMENT '更新者',
	update_date datetime NOT NULL COMMENT '更新时间',
	remarks varchar(255) COMMENT '备注信息',
	del_flag char(1) DEFAULT '0' NOT NULL COMMENT '删除标记',
	name_en varchar(255) COMMENT '英文名称',
	PRIMARY KEY (id)
) COMMENT = '不安全事件';



/* Create Foreign Keys */

ALTER TABLE actcard_unsafe
	ADD FOREIGN KEY (actcard_id)
	REFERENCES actcard (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE actcard_unsafe
	ADD FOREIGN KEY (unsafe_event_id)
	REFERENCES actcard_unsafe_event (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



