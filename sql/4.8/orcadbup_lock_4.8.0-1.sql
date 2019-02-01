--                                      
-- 排他制御監視
--                                    
-- karte_uid追加
--                                   
-- Create Date : 2014/10/23     

\set ON_ERROR_STOP

alter table tbl_lock add column karte_uid varchar(32);
update tbl_lock set karte_uid = '';

