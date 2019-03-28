--                                      
-- 患者労災テーブル
--                                    
-- 公費ＩＤ追加
--                                   
-- Create Date : 2013/7/2       

\set ON_ERROR_STOP

alter table tbl_ptrsiinf DROP CONSTRAINT tbl_ptrsiinf_primary_key;
alter table tbl_ptrsiinf add column kohid bigint;
update tbl_ptrsiinf set kohid = 0;
alter table tbl_ptrsiinf add constraint tbl_ptrsiinf_primary_key primary key (hospnum,ptid,hknid,kohid);
