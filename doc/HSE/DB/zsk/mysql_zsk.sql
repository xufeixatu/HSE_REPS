drop table if exists zsk_class;

drop table if exists zsk_document;

drop table if exists zsk_history_version;

/*==============================================================*/
/* Table: zsk_class                                             */
/*==============================================================*/
create table zsk_class
(
   id                   varchar(64) not null comment '分类ID',
   zsk_name             varchar(200) not null comment '知识库文档分类名称',
   pid                  varchar(64) comment '上级分类ID(引用ID)',
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
   classId              varchar(64) comment '当前文档所属分类的id(引用分类表id)',
   file_name            varchar(200) not null comment '文件名',
   file_data            blob not null comment '文件字节存储的字段',
   create_date          date not null comment '上传文档的时间',
   create_by            varchar(64) not null comment '上传人',
   update_date          date comment '最后修订时间',
   update_by            varchar(64) comment '最后修订人',
   `desc`               varchar(255) comment '描述',
   primary key (id)
);

alter table zsk_document comment '知识库中存储文档数据的主表';

/*==============================================================*/
/* Table: zsk_history_version                                   */
/*==============================================================*/
create table zsk_history_version
(
   id                   varchar(64) not null comment '知识库文档历史版本表的ID',
   document_Id          varchar(64) comment '当前历史版本所属的知识库文档ID',
   file_name            varchar(200) not null comment '历史文档名称',
   file_data            blob not null comment '历史文档的字节数据',
   update_date          date comment '当前历史文档的最后修订时间',
   update_by            varchar(64) comment '当前历史文档的修订人',
   `desc`               varchar(255) comment '当前历史文档的历史描述信息',
   primary key (id)
);

alter table zsk_history_version comment '知识库中存储历史版本文档数据的表';
