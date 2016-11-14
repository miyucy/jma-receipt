--                            --
-- マスター系テーブルの分離   --
--                            --
-- Create Date : 2016/08/29   --
--                            --

-- マスター系のスキーマ作成

CREATE SCHEMA IF NOT EXISTS master;

--
-- テーブルをマスター系スキーマへ移動する
--

-- 点数
-- ALTER TABLE IF EXISTS tbl_tensu SET SCHEMA master;

-- 病名
ALTER TABLE IF EXISTS master.tbl_byomei SET SCHEMA public;
-- 検査分類
ALTER TABLE IF EXISTS master.tbl_kensasort SET SCHEMA public;
-- 相互作用
ALTER TABLE IF EXISTS master.tbl_interact SET SCHEMA public;
-- 症状措置
ALTER TABLE IF EXISTS master.tbl_sskijyo SET SCHEMA public;
-- 適応病名
ALTER TABLE IF EXISTS master.tbl_tekioubyomei SET SCHEMA public;
-- 一般名
ALTER TABLE IF EXISTS master.tbl_genericname SET SCHEMA public;
-- 包括チェック
ALTER TABLE IF EXISTS master.tbl_hktsantei SET SCHEMA public;
-- 包括診療コード
ALTER TABLE IF EXISTS master.tbl_hktsrycd SET SCHEMA public;
-- 感染症判定
ALTER TABLE IF EXISTS master.tbl_infection_judgment SET SCHEMA public;
-- 入院基本料
ALTER TABLE IF EXISTS master.tbl_nyuinkhn SET SCHEMA public;
-- 入院料加算チェック
ALTER TABLE IF EXISTS master.tbl_nyuksnchk SET SCHEMA public;
-- 入院レセプト記載略称
ALTER TABLE IF EXISTS master.tbl_nyuinryakusho SET SCHEMA public;
-- 同義語
ALTER TABLE IF EXISTS master.tbl_synonym SET SCHEMA public;


-- 電子点数表
ALTER TABLE IF EXISTS master.tbl_etensu_1 SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_etensu_2 SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_etensu_2_jma SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_etensu_2_sample SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_etensu_3_1 SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_etensu_3_2 SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_etensu_3_3 SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_etensu_3_4 SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_etensu_4 SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_etensu_5 SET SCHEMA public;


-- 労働基準監督署
ALTER TABLE IF EXISTS master.tbl_labor_sio SET SCHEMA public;
-- 最低薬価
ALTER TABLE IF EXISTS master.tbl_generic_price SET SCHEMA public;
-- 介護保険者
ALTER TABLE IF EXISTS master.tbl_hknjainf_care SET SCHEMA public;
-- 選定療養費一般コード振替
ALTER TABLE IF EXISTS master.tbl_senteicdchg SET SCHEMA public;
-- 入院料置換
ALTER TABLE IF EXISTS master.tbl_nyuincdchg SET SCHEMA public;
-- 医薬品傷病名
ALTER TABLE IF EXISTS master.tbl_tekiou_medicine SET SCHEMA public;
ALTER TABLE IF EXISTS master.tbl_tekiou_disease SET SCHEMA public;
-- 医薬品分類
ALTER TABLE IF EXISTS master.tbl_generic_class SET SCHEMA public;
-- 向精神薬成分コード
ALTER TABLE IF EXISTS master.tbl_psychotropic SET SCHEMA public;
