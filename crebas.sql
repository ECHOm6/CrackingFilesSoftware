/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2023/1/14 16:42:46                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Course') and o.name = 'FK_COURSE_RELATIONS_COURSE')
alter table Course
   drop constraint FK_COURSE_RELATIONS_COURSE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SC') and o.name = 'FK_SC_SC_STUDENT')
alter table SC
   drop constraint FK_SC_SC_STUDENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SC') and o.name = 'FK_SC_SC2_COURSE')
alter table SC
   drop constraint FK_SC_SC2_COURSE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Teacher') and o.name = 'FK_TEACHER_TC_COURSE')
alter table Teacher
   drop constraint FK_TEACHER_TC_COURSE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Course')
            and   name  = 'Relationship_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Course.Relationship_2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Course')
            and   type = 'U')
   drop table Course
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SC')
            and   name  = 'SC2_FK'
            and   indid > 0
            and   indid < 255)
   drop index SC.SC2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SC')
            and   name  = 'SC_FK'
            and   indid > 0
            and   indid < 255)
   drop index SC.SC_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SC')
            and   type = 'U')
   drop table SC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Student')
            and   type = 'U')
   drop table Student
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Teacher')
            and   name  = 'TC_FK'
            and   indid > 0
            and   indid < 255)
   drop index Teacher.TC_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Teacher')
            and   type = 'U')
   drop table Teacher
go

/*==============================================================*/
/* Table: Course                                                */
/*==============================================================*/
create table Course (
   Cno                  smallint             not null,
   Cou_Cno              smallint             null,
   Cname                char(10)             null,
   constraint PK_COURSE primary key nonclustered (Cno)
)
go

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on Course (
Cou_Cno ASC
)
go

/*==============================================================*/
/* Table: SC                                                    */
/*==============================================================*/
create table SC (
   Sno                  char(8)              not null,
   Cno                  smallint             not null,
   Grade                float(2)             null,
   constraint PK_SC primary key (Sno, Cno)
)
go

/*==============================================================*/
/* Index: SC_FK                                                 */
/*==============================================================*/
create index SC_FK on SC (
Sno ASC
)
go

/*==============================================================*/
/* Index: SC2_FK                                                */
/*==============================================================*/
create index SC2_FK on SC (
Cno ASC
)
go

/*==============================================================*/
/* Table: Student                                               */
/*==============================================================*/
create table Student (
   Sno                  char(8)              not null,
   Sname                char(10)             null,
   Sage                 smallint             null,
   constraint PK_STUDENT primary key nonclustered (Sno)
)
go

/*==============================================================*/
/* Table: Teacher                                               */
/*==============================================================*/
create table Teacher (
   Tno                  char(3)              not null,
   Cno                  smallint             null,
   Tname                char(10)             null,
   constraint PK_TEACHER primary key nonclustered (Tno)
)
go

/*==============================================================*/
/* Index: TC_FK                                                 */
/*==============================================================*/
create index TC_FK on Teacher (
Cno ASC
)
go

alter table Course
   add constraint FK_COURSE_RELATIONS_COURSE foreign key (Cou_Cno)
      references Course (Cno)
go

alter table SC
   add constraint FK_SC_SC_STUDENT foreign key (Sno)
      references Student (Sno)
go

alter table SC
   add constraint FK_SC_SC2_COURSE foreign key (Cno)
      references Course (Cno)
go

alter table Teacher
   add constraint FK_TEACHER_TC_COURSE foreign key (Cno)
      references Course (Cno)
go

