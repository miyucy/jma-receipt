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
ALTER TABLE IF EXISTS tbl_byomei SET SCHEMA master;
CREATE VIEW tbl_byomei AS SELECT * FROM master.tbl_byomei;
-- 検査分類
ALTER TABLE IF EXISTS tbl_kensasort SET SCHEMA master;
CREATE VIEW tbl_kensasort AS SELECT * FROM master.tbl_kensasort;
-- 相互作用
ALTER TABLE IF EXISTS tbl_interact SET SCHEMA master;
CREATE VIEW tbl_interact AS SELECT * FROM master.tbl_interact;
-- 症状措置
ALTER TABLE IF EXISTS tbl_sskijyo SET SCHEMA master;
CREATE VIEW tbl_sskijyo AS SELECT * FROM master.tbl_sskijyo;

-- -- 適応病名
-- ALTER TABLE IF EXISTS tbl_tekioubyomei SET SCHEMA master;
-- -- 一般名
-- ALTER TABLE IF EXISTS tbl_genericname SET SCHEMA master;
-- -- 包括チェック
-- ALTER TABLE IF EXISTS tbl_hktsantei SET SCHEMA master;
-- -- 包括診療コード
-- ALTER TABLE IF EXISTS tbl_hktsrycd SET SCHEMA master;
-- -- 感染症判定
-- ALTER TABLE IF EXISTS tbl_infection_judgment SET SCHEMA master;
-- -- 入院基本料
-- ALTER TABLE IF EXISTS tbl_nyuinkhn SET SCHEMA master;
-- -- 入院料加算チェック
-- ALTER TABLE IF EXISTS tbl_nyuksnchk SET SCHEMA master;
-- -- 入院レセプト記載略称
-- ALTER TABLE IF EXISTS tbl_nyuinryakusho SET SCHEMA master;
-- -- 同義語
-- ALTER TABLE IF EXISTS tbl_synonym SET SCHEMA master;


-- -- 電子点数表
-- ALTER TABLE IF EXISTS tbl_etensu_1 SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_etensu_2 SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_etensu_2_jma SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_etensu_2_sample SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_etensu_3_1 SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_etensu_3_2 SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_etensu_3_3 SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_etensu_3_4 SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_etensu_4 SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_etensu_5 SET SCHEMA master;


-- -- 労働基準監督署
-- ALTER TABLE IF EXISTS tbl_labor_sio SET SCHEMA master;
-- -- 最低薬価
-- ALTER TABLE IF EXISTS tbl_generic_price SET SCHEMA master;
-- -- 介護保険者
-- ALTER TABLE IF EXISTS tbl_hknjainf_care SET SCHEMA master;
-- -- 選定療養費一般コード振替
-- ALTER TABLE IF EXISTS tbl_senteicdchg SET SCHEMA master;
-- -- 入院料置換
-- ALTER TABLE IF EXISTS tbl_nyuincdchg SET SCHEMA master;
-- -- 医薬品傷病名
-- ALTER TABLE IF EXISTS tbl_tekiou_medicine SET SCHEMA master;
-- ALTER TABLE IF EXISTS tbl_tekiou_disease SET SCHEMA master;
-- -- 医薬品分類
-- ALTER TABLE IF EXISTS tbl_generic_class SET SCHEMA master;
-- -- 向精神薬成分コード
-- ALTER TABLE IF EXISTS tbl_psychotropic SET SCHEMA master;
