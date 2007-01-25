\set ON_ERROR_STOP

alter table tbl_pgkanri add  column hospnum  integer;
update tbl_pgkanri set hospnum = 1 ;
alter table tbl_pgkanri drop constraint  tbl_pgkanri_primary_key;
alter table tbl_pgkanri add constraint tbl_pgkanri_primary_key primary key (hospnum,debianversion, systemversion, pgno);
