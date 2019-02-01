--                                      
-- 排他制御監視
--                                    
-- karte_uid変更
--                                   
-- Create Date : 2015/2/12    

\set ON_ERROR_STOP

alter table tbl_lock alter column karte_uid type varchar(36);

