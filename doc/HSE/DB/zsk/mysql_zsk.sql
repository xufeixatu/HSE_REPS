drop table if exists zsk_class;

drop table if exists zsk_document;

drop table if exists zsk_history_version;

/*==============================================================*/
/* Table: zsk_class                                             */
/*==============================================================*/
create table zsk_class
(
   id                   varchar(64) not null comment '����ID',
   zsk_name             varchar(200) not null comment '֪ʶ���ĵ���������',
   pid                  varchar(64) comment '�ϼ�����ID(����ID)',
   `desc`               varchar(255) comment '�Ե�ǰ���������',
   primary key (id)
);

alter table zsk_class comment '֪ʶ���ĵ������';

/*==============================================================*/
/* Table: zsk_document                                          */
/*==============================================================*/
create table zsk_document
(
   id                   varchar(64) not null comment '�ϴ��ĵ��ı�ʶ',
   classId              varchar(64) comment '��ǰ�ĵ����������id(���÷����id)',
   file_name            varchar(200) not null comment '�ļ���',
   file_data            blob not null comment '�ļ��ֽڴ洢���ֶ�',
   create_date          date not null comment '�ϴ��ĵ���ʱ��',
   create_by            varchar(64) not null comment '�ϴ���',
   update_date          date comment '����޶�ʱ��',
   update_by            varchar(64) comment '����޶���',
   `desc`               varchar(255) comment '����',
   primary key (id)
);

alter table zsk_document comment '֪ʶ���д洢�ĵ����ݵ�����';

/*==============================================================*/
/* Table: zsk_history_version                                   */
/*==============================================================*/
create table zsk_history_version
(
   id                   varchar(64) not null comment '֪ʶ���ĵ���ʷ�汾���ID',
   document_Id          varchar(64) comment '��ǰ��ʷ�汾������֪ʶ���ĵ�ID',
   file_name            varchar(200) not null comment '��ʷ�ĵ�����',
   file_data            blob not null comment '��ʷ�ĵ����ֽ�����',
   update_date          date comment '��ǰ��ʷ�ĵ�������޶�ʱ��',
   update_by            varchar(64) comment '��ǰ��ʷ�ĵ����޶���',
   `desc`               varchar(255) comment '��ǰ��ʷ�ĵ�����ʷ������Ϣ',
   primary key (id)
);

alter table zsk_history_version comment '֪ʶ���д洢��ʷ�汾�ĵ����ݵı�';
