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
