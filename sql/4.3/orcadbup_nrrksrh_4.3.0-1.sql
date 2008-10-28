\set ON_ERROR_STOP

alter table tbl_nrrksrh add column rrknum numeric(3,0);
update tbl_nrrksrh set rrknum = 0;

