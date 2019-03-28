--                                    --
-- 収納プレビューテーブルの変更       --
--                                    --
-- 項目の追加                         --
--   病理診断   BYR                   --
--                                    --
-- Create Date : 2008/03/03           --
--                                    --
\set ON_ERROR_STOP


--    項目追加                        --
alter table TBL_SYUNOU_PRV
   add column BYR_HKNTEN    numeric(07);
alter table TBL_SYUNOU_PRV
   add column BYR_MONEY     numeric(07);
alter table TBL_SYUNOU_PRV
   add column BYR_TGMONEY   numeric(07);
alter table TBL_SYUNOU_PRV
   add column BYR_TGMONEY_TAX numeric(07);

--    ゼロ設定                       --
alter table TBL_SYUNOU_PRV
   alter BYR_HKNTEN set default 0;
alter table TBL_SYUNOU_PRV
   alter BYR_MONEY set default 0;
alter table TBL_SYUNOU_PRV
   alter BYR_TGMONEY set default 0;
alter table TBL_SYUNOU_PRV
   alter BYR_TGMONEY_TAX set default 0;

UPDATE TBL_SYUNOU_PRV SET BYR_HKNTEN=0,BYR_MONEY=0,BYR_TGMONEY=0,BYR_TGMONEY_TAX=0;
-- UPDATE TBL_SYUNOU_PRV SET MSI_HKNTEN            =0 WHERE MSI_HKNTEN IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET MSI_MONEY             =0 WHERE MSI_MONEY IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET MSI_TGMONEY           =0 WHERE MSI_TGMONEY IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET MSI_TGMONEY_TAX       =0 WHERE MSI_TGMONEY_TAX IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SSN_HKNTEN            =0 WHERE SSN_HKNTEN IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SSN_MONEY             =0 WHERE SSN_MONEY IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SSN_TGMONEY           =0 WHERE SSN_TGMONEY IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SSN_TGMONEY_TAX       =0 WHERE SSN_TGMONEY_TAX IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET HOU_HKNTEN            =0 WHERE HOU_HKNTEN IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET HOU_MONEY             =0 WHERE HOU_MONEY IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET HOU_TGMONEY           =0 WHERE HOU_TGMONEY IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET HOU_TGMONEY_TAX       =0 WHERE HOU_TGMONEY_TAX  IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET RYO_HKNTEN            =0 WHERE RYO_HKNTEN IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET RYO_MONEY             =0 WHERE RYO_MONEY IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET RYO_TGMONEY           =0 WHERE RYO_TGMONEY IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET RYO_TGMONEY_TAX       =0 WHERE RYO_TGMONEY_TAX  IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SHOHOU_SAI            =0 WHERE SHOHOU_SAI IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET GRP_HAKHOUFLG         =0 WHERE GRP_HAKHOUFLG IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SHOKUJI8_NISSU        =0 WHERE SHOKUJI8_NISSU IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SHOKUJI8              =0 WHERE SHOKUJI8 IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SHOKUJI9_NISSU        =0 WHERE SHOKUJI9_NISSU IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SHOKUJI9              =0 WHERE SHOKUJI9 IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SHOKUJI10_NISSU       =0 WHERE SHOKUJI10_NISSU IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SHOKUJI10             =0 WHERE SHOKUJI10 IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET RYOYOHI_LIFE          =0 WHERE RYOYOHI_LIFE IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SKYMONEY_LIFE         =0 WHERE SKYMONEY_LIFE IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SKYMONEY_LIFE_TAX     =0 WHERE SKYMONEY_LIFE_TAX IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SKYMONEY_LIFE_KEI     =0 WHERE SKYMONEY_LIFE_KEI IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET RYOYOHI_LIFE_JIHI     =0 WHERE RYOYOHI_LIFE_JIHI IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SKYMONEY_LIFE_JIHI    =0 WHERE SKYMONEY_LIFE_JIHI IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SKYMONEY_LIFE_JIHI_TAX=0 WHERE SKYMONEY_LIFE_JIHI_TAX IS NULL;
-- UPDATE TBL_SYUNOU_PRV SET SKYMONEY_LIFE_JIHI_KEI=0 WHERE SKYMONEY_LIFE_JIHI_KEI IS NULL;
