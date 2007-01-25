\set ON_ERROR_STOP

alter table tbl_senteicdchg add  column hospnum  integer;
update tbl_senteicdchg set hospnum = 1 ;
alter table tbl_senteicdchg drop constraint  tbl_senteicdchg_primary_key;
alter table tbl_senteicdchg add constraint tbl_senteicdchg_primary_key primary key (hospnum,ipnsrycd, senteisrycd);
drop index idx_senteicdchg_senteisrycd;
create index idx_senteicdchg_senteisrycd on tbl_senteicdchg(hospnum,senteisrycd);
