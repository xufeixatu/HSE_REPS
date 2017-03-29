drop table if exists Data_dict;

drop table if exists work_approve_history;

drop table if exists work_feedback;

drop table if exists work_frequency;

drop table if exists work_plan;

drop table if exists work_responsible_dept;

drop table if exists work_type;

drop table if exists zsk_class;

drop table if exists zsk_document;

drop table if exists zsk_history_version;

/*==============================================================*/
/* Table: Data_dict                                             */
/*==============================================================*/
create table Data_dict
(
   id                   varchar(64) not null comment '数据字典标识(PK)',
   field_name           varchar(200) comment '数据字段名称',
   field_desc           varchar(255) comment '数据字段描述',
   primary key (id)
);

alter table Data_dict comment '数据字典表';

/*==============================================================*/
/* Table: work_approve_history                                  */
/*==============================================================*/
create table work_approve_history
(
   id                   varchar(64) not null,
   approve_update_history varchar(255) comment '审批更新的历史信息',
   work_plan_id         varchar(64),
   user_id              varchar(64) comment '修改人引用人员ID(FK)',
   primary key (id)
);

alter table work_approve_history comment '审批历史信息表';

/*==============================================================*/
/* Table: work_feedback                                         */
/*==============================================================*/
create table work_feedback
(
   id                   varchar(64) not null,
   feedback_info        varchar(255) comment '反馈信息',
   feedbakc_user_id     varchar(64) comment '反馈人的用户ID(FK)',
   word_plan_id         varchar(64) comment '工作计划的ID(FK)',
   feedback_reply       varchar(255) comment '指派人对反馈的回复',
   primary key (id)
);

alter table work_feedback comment '工作任务反馈表';

/*==============================================================*/
/* Table: work_frequency                                        */
/*==============================================================*/
create table work_frequency
(
   id                   varchar(64) not null,
   month                varchar(10) comment '执行工作的月份',
   work_plan_id         varchar(64) comment '关联工作计划表的工作计划ID[FK]',
   primary key (id)
);

alter table work_frequency comment '工作频次';

/*==============================================================*/
/* Table: work_plan                                             */
/*==============================================================*/
create table work_plan
(
   id                   varchar(64) not null,
   title                varchar(200) not null comment '工作计划标题',
   work_class_id        varchar(64) comment '工作计划分类标识',
   required_finish_time date comment '要求完成时间',
   start_time           date comment '开始时间',
   planed_finish_time   date comment '工作计划的计划完成时间',
   dept_id              varchar(64) comment '引用指定部门ID（FK）',
   user_id              varchar(64) comment '指定责任人ID（FK）',
   actual_finish_time   date comment '工作实际完成时间',
   work_level_id        varchar(64) comment '引用工作级别ID(FK)',
   work_desc            varchar(255) comment '工作描述',
   job_require          varchar(255) comment '工作要求',
   zsk_id               varchar(64) comment '这个是工作计划附件，统一上传知识库，这里引用知识库ID（FK）',
   work_state_id        varchar(64) comment '工作状态（引用数据字典中工作状态选择项ID）(FK)',
   is_open              bool comment '是否公开(不公开则只有责任人和任务分派人可见)',
   create_by            varchar(64) comment '工作计划的分派人ID(FK)',
   parent_id            varchar(64) comment '子任务引用父任务的ID[FK]',
   is_cancel            bool comment '是否取消任务（任务取消时子任务同时取消，些字段同步设置为false）',
   cancel_reason        varchar(255) comment '取消原因',
   is_remove            bool comment '是否删除属性',
   remove_reason        varchar(255) comment '删除原因',
   is_approvable        bool comment '可否审批',
   is_approve_update    bool comment '是否允许审批时更新工作计划',
   is_retains_approve_update bool comment '是否保留审批时更新的工作计划历史信息',
   approve_opinion      varchar(255) comment '审批意见',
   reminder_desc        varchar(255) comment '催办描述，催办时工作置顶',
   primary key (id)
);

alter table work_plan comment '工作计划表';

/*==============================================================*/
/* Table: work_responsible_dept                                 */
/*==============================================================*/
create table work_responsible_dept
(
   id                   varchar(64) not null,
   dept_id              varchar(64) comment '责任部门ID（关联部门表ID）[FK]',
   work_plan_id         varchar(64) comment '工作计划ID(关联工作计划表)[FK]',
   primary key (id)
);

alter table work_responsible_dept comment '责任部门';

/*==============================================================*/
/* Table: work_type                                             */
/*==============================================================*/
create table work_type
(
   id                   varchar(64) not null,
   type_name            varchar(200) comment '工作分类的名称',
   type_desc            varchar(255) comment '工作分类的描述',
   pid                  varchar(64) comment '分类父ID(FK)',
   primary key (id)
);

alter table work_type comment '工作计划分类表';

/*==============================================================*/
/* Table: zsk_class                                             */
/*==============================================================*/
create table zsk_class
(
   id                   varchar(64) not null comment '分类ID',
   zsk_name             varchar(200) not null comment '知识库文档分类名称',
   pid                  varchar(64) comment '上级分类ID(引用ID)(FK)',
   `desc`               varchar(255) comment '对当前分类的描述',
   primary key (id)
);

alter table zsk_class comment '知识库文档分类表';

/*==============================================================*/
/* Table: zsk_document                                          */
/*==============================================================*/
create table zsk_document
(
   id                   varchar(64) not null comment '上传文档的标识',
   classId              varchar(64) comment '当前文档所属分类的id(引用分类表id)(FK)',
   file_name            varchar(200) not null comment '文件名',
   file_data            longblob not null comment '文件字节存储的字段',
   create_date          date not null comment '上传文档的时间',
   create_by            varchar(64) not null comment '上传人',
   update_date          date comment '最后修订时间',
   update_by            varchar(64) comment '最后修订人',
   `desc`               varchar(255) comment '描述',
   doc_type             varchar(10) comment '文档的类型，如.doc  .html.txt',
   primary key (id)
);

alter table zsk_document comment '知识库中存储文档数据的主表';

/*==============================================================*/
/* Table: zsk_history_version                                   */
/*==============================================================*/
create table zsk_history_version
(
   id                   varchar(64) not null comment '知识库文档历史版本表的ID',
   document_Id          varchar(64) comment '当前历史版本所属的知识库文档ID(FK)',
   file_name            varchar(200) not null comment '历史文档名称',
   file_data            blob not null comment '历史文档的字节数据',
   update_date          date comment '当前历史文档的最后修订时间',
   update_by            varchar(64) comment '当前历史文档的修订人',
   `desc`               varchar(255) comment '当前历史文档的历史描述信息',
   doc_type             varchar(20),
   primary key (id)
);

alter table zsk_history_version comment '知识库中存储历史版本文档数据的表';
