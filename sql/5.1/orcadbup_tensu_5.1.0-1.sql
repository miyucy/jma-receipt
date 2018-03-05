--                                      
-- 点数テーブル
--                                    
-- 悪性腫瘍病理組織標本加算追加
--                                   
-- Create Date : 2018/03/04      

\set ON_ERROR_STOP

alter table tbl_tensu add column akuseibyoriksn smallint default 0;
-- update tbl_tensu set akuseibyoriksn=0;
