\set ON_ERROR_STOP

alter table tbl_joblog add  column hospnum  integer;
update tbl_joblog set hospnum = 1 ;
alter table tbl_joblog drop constraint  tbl_joblog_primary_key;
alter table tbl_joblog add constraint tbl_joblog_primary_key primary key (hospnum,logymd, logtime, progname, kbnid);
