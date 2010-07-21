\set ON_ERROR_STOP

alter table tbl_ptbyomei add column seqnum numeric(4) DEFAULT 0;
update tbl_ptbyomei set seqnum = 9999;
