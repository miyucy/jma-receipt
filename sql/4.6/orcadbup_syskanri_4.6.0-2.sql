--                                    --
-- システム管理データ追加             --
-- 医療観察法の対応                   --
--   病棟情報の病棟種別               --
--   入退院登録の入院料選択           --
--                                    --
-- Create Date : 2011/01/07           --
--                                    --

\set ON_ERROR_STOP

update tbl_syskanri set kanritbl = substr(kanritbl,1,408) || ' 1' || substr(kanritbl,411,90) where kanricd = '5000' and substr(kanritbl,409,1) = '1' and styukymd >= '20120401';
