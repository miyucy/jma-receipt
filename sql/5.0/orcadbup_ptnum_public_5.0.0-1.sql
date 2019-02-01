--                                      
-- 患者地域連携テーブル
--                                    
-- 医療等ＩＤ追加
-- 共通番号追加
--                                   
-- Create Date : 2016/10/24      

\set ON_ERROR_STOP

alter table tbl_ptnum_public add column patient_id_2 character varying(20);
alter table tbl_ptnum_public add column patient_id_3 character varying(20);
update tbl_ptnum_public set patient_id_2 = '';
update tbl_ptnum_public set patient_id_3 = '';
