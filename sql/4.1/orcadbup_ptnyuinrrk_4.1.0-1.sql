\set ON_ERROR_STOP

alter table tbl_ptnyuinrrk add column timekbn_in  char(1);
update tbl_ptnyuinrrk set timekbn_in='1' ;
update tbl_ptnyuinrrk set timekbn_in='0' where doujitsukbn in ('1','2') or skjkbn = '0';
