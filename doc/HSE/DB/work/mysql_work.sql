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
   id                   varchar(64) not null comment '�����ֵ��ʶ(PK)',
   field_name           varchar(200) comment '�����ֶ�����',
   field_desc           varchar(255) comment '�����ֶ�����',
   primary key (id)
);

alter table Data_dict comment '�����ֵ��';

/*==============================================================*/
/* Table: work_approve_history                                  */
/*==============================================================*/
create table work_approve_history
(
   id                   varchar(64) not null,
   approve_update_history varchar(255) comment '�������µ���ʷ��Ϣ',
   work_plan_id         varchar(64),
   user_id              varchar(64) comment '�޸���������ԱID(FK)',
   primary key (id)
);

alter table work_approve_history comment '������ʷ��Ϣ��';

/*==============================================================*/
/* Table: work_feedback                                         */
/*==============================================================*/
create table work_feedback
(
   id                   varchar(64) not null,
   feedback_info        varchar(255) comment '������Ϣ',
   feedbakc_user_id     varchar(64) comment '�����˵��û�ID(FK)',
   word_plan_id         varchar(64) comment '�����ƻ���ID(FK)',
   feedback_reply       varchar(255) comment 'ָ���˶Է����Ļظ�',
   primary key (id)
);

alter table work_feedback comment '������������';

/*==============================================================*/
/* Table: work_frequency                                        */
/*==============================================================*/
create table work_frequency
(
   id                   varchar(64) not null,
   month                varchar(10) comment 'ִ�й������·�',
   work_plan_id         varchar(64) comment '���������ƻ���Ĺ����ƻ�ID[FK]',
   primary key (id)
);

alter table work_frequency comment '����Ƶ��';

/*==============================================================*/
/* Table: work_plan                                             */
/*==============================================================*/
create table work_plan
(
   id                   varchar(64) not null,
   title                varchar(200) not null comment '�����ƻ�����',
   work_class_id        varchar(64) comment '�����ƻ������ʶ',
   required_finish_time date comment 'Ҫ�����ʱ��',
   start_time           date comment '��ʼʱ��',
   planed_finish_time   date comment '�����ƻ��ļƻ����ʱ��',
   dept_id              varchar(64) comment '����ָ������ID��FK��',
   user_id              varchar(64) comment 'ָ��������ID��FK��',
   actual_finish_time   date comment '����ʵ�����ʱ��',
   work_level_id        varchar(64) comment '���ù�������ID(FK)',
   work_desc            varchar(255) comment '��������',
   job_require          varchar(255) comment '����Ҫ��',
   zsk_id               varchar(64) comment '����ǹ����ƻ�������ͳһ�ϴ�֪ʶ�⣬��������֪ʶ��ID��FK��',
   work_state_id        varchar(64) comment '����״̬�����������ֵ��й���״̬ѡ����ID��(FK)',
   is_open              bool comment '�Ƿ񹫿�(��������ֻ�������˺���������˿ɼ�)',
   create_by            varchar(64) comment '�����ƻ��ķ�����ID(FK)',
   parent_id            varchar(64) comment '���������ø������ID[FK]',
   is_cancel            bool comment '�Ƿ�ȡ����������ȡ��ʱ������ͬʱȡ����Щ�ֶ�ͬ������Ϊfalse��',
   cancel_reason        varchar(255) comment 'ȡ��ԭ��',
   is_remove            bool comment '�Ƿ�ɾ������',
   remove_reason        varchar(255) comment 'ɾ��ԭ��',
   is_approvable        bool comment '�ɷ�����',
   is_approve_update    bool comment '�Ƿ���������ʱ���¹����ƻ�',
   is_retains_approve_update bool comment '�Ƿ�������ʱ���µĹ����ƻ���ʷ��Ϣ',
   approve_opinion      varchar(255) comment '�������',
   reminder_desc        varchar(255) comment '�߰��������߰�ʱ�����ö�',
   primary key (id)
);

alter table work_plan comment '�����ƻ���';

/*==============================================================*/
/* Table: work_responsible_dept                                 */
/*==============================================================*/
create table work_responsible_dept
(
   id                   varchar(64) not null,
   dept_id              varchar(64) comment '���β���ID���������ű�ID��[FK]',
   work_plan_id         varchar(64) comment '�����ƻ�ID(���������ƻ���)[FK]',
   primary key (id)
);

alter table work_responsible_dept comment '���β���';

/*==============================================================*/
/* Table: work_type                                             */
/*==============================================================*/
create table work_type
(
   id                   varchar(64) not null,
   type_name            varchar(200) comment '�������������',
   type_desc            varchar(255) comment '�������������',
   pid                  varchar(64) comment '���ุID(FK)',
   primary key (id)
);

alter table work_type comment '�����ƻ������';

/*==============================================================*/
/* Table: zsk_class                                             */
/*==============================================================*/
create table zsk_class
(
   id                   varchar(64) not null comment '����ID',
   zsk_name             varchar(200) not null comment '֪ʶ���ĵ���������',
   pid                  varchar(64) comment '�ϼ�����ID(����ID)(FK)',
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
   classId              varchar(64) comment '��ǰ�ĵ����������id(���÷����id)(FK)',
   file_name            varchar(200) not null comment '�ļ���',
   file_data            longblob not null comment '�ļ��ֽڴ洢���ֶ�',
   create_date          date not null comment '�ϴ��ĵ���ʱ��',
   create_by            varchar(64) not null comment '�ϴ���',
   update_date          date comment '����޶�ʱ��',
   update_by            varchar(64) comment '����޶���',
   `desc`               varchar(255) comment '����',
   doc_type             varchar(10) comment '�ĵ������ͣ���.doc  .html.txt',
   primary key (id)
);

alter table zsk_document comment '֪ʶ���д洢�ĵ����ݵ�����';

/*==============================================================*/
/* Table: zsk_history_version                                   */
/*==============================================================*/
create table zsk_history_version
(
   id                   varchar(64) not null comment '֪ʶ���ĵ���ʷ�汾���ID',
   document_Id          varchar(64) comment '��ǰ��ʷ�汾������֪ʶ���ĵ�ID(FK)',
   file_name            varchar(200) not null comment '��ʷ�ĵ�����',
   file_data            blob not null comment '��ʷ�ĵ����ֽ�����',
   update_date          date comment '��ǰ��ʷ�ĵ�������޶�ʱ��',
   update_by            varchar(64) comment '��ǰ��ʷ�ĵ����޶���',
   `desc`               varchar(255) comment '��ǰ��ʷ�ĵ�����ʷ������Ϣ',
   doc_type             varchar(20),
   primary key (id)
);

alter table zsk_history_version comment '֪ʶ���д洢��ʷ�汾�ĵ����ݵı�';
