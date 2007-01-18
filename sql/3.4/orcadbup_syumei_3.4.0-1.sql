\set ON_ERROR_STOP
--
-- ÊÝ¸±ÅÀ¿ô(HKNTEN)ÄÉ²Ã
-- ÊÝ¸±ÀÁµá³Û(HKNMONEY)ÄÉ²Ã
-- ¼«ÈñÀÁµá³Û(JIHIMONEY)ÄÉ²Ã
-- ¿©»öÀÁµá³Û(SKJMONEY)ÄÉ²Ã
-- À¸³èÀÁµá³Û(LIFEMONEY)ÄÉ²Ã
-- Ä´À°¶â(CHOSEI)ÄÉ²Ã
-- ¸ºÌÈ¶â³Û(DISCOUNTMONEY)ÄÉ²Ã
-- ¼«ÈñÆâÌõ(JIHI_1¡ÁJIHI_10)ÄÉ²Ã
-- ¼¼ÎÁº¹³Û(RMSAGAKU)ÄÉ²Ã
-- 
-- Create Date : 2006/12/19           --
--
--  ¹àÌÜÄÉ²Ã                        --
alter table TBL_SYUMEI
   add column HKNTEN		numeric(08);
alter table TBL_SYUMEI
   add column HKNMONEY		numeric(08);
alter table TBL_SYUMEI
   add column JIHIMONEY		numeric(08);
alter table TBL_SYUMEI
   add column SKJMONEY		numeric(08);
alter table TBL_SYUMEI
   add column LIFEMONEY		numeric(08);
alter table TBL_SYUMEI
   add column CHOSEI		numeric(08);
alter table TBL_SYUMEI
   add column DISCOUNTMONEY	numeric(08);
alter table TBL_SYUMEI
   add column JIHI_1		numeric(08);
alter table TBL_SYUMEI
   add column JIHI_2		numeric(08);
alter table TBL_SYUMEI
   add column JIHI_3		numeric(08);
alter table TBL_SYUMEI
   add column JIHI_4		numeric(08);
alter table TBL_SYUMEI
   add column JIHI_5		numeric(08);
alter table TBL_SYUMEI
   add column JIHI_6		numeric(08);
alter table TBL_SYUMEI
   add column JIHI_7		numeric(08);
alter table TBL_SYUMEI
   add column JIHI_8		numeric(08);
alter table TBL_SYUMEI
   add column JIHI_9		numeric(08);
alter table TBL_SYUMEI
   add column JIHI_10		numeric(08);
alter table TBL_SYUMEI
   add column RMSAGAKU		numeric(08);


--  ¥¼¥íÀßÄê                       --
alter table TBL_SYUMEI
   alter HKNTEN		set default 0;
alter table TBL_SYUMEI
   alter HKNMONEY	set default 0;
alter table TBL_SYUMEI
   alter JIHIMONEY	set default 0;
alter table TBL_SYUMEI
   alter SKJMONEY	set default 0;
alter table TBL_SYUMEI
   alter LIFEMONEY	set default 0;
alter table TBL_SYUMEI
   alter CHOSEI		set default 0;
alter table TBL_SYUMEI
   alter DISCOUNTMONEY	set default 0;
alter table TBL_SYUMEI
   alter JIHI_1		set default 0;
alter table TBL_SYUMEI
   alter JIHI_2		set default 0;
alter table TBL_SYUMEI
   alter JIHI_3		set default 0;
alter table TBL_SYUMEI
   alter JIHI_4		set default 0;
alter table TBL_SYUMEI
   alter JIHI_5		set default 0;
alter table TBL_SYUMEI
   alter JIHI_6		set default 0;
alter table TBL_SYUMEI
   alter JIHI_7		set default 0;
alter table TBL_SYUMEI
   alter JIHI_8		set default 0;
alter table TBL_SYUMEI
   alter JIHI_9		set default 0;
alter table TBL_SYUMEI
   alter JIHI_10	set default 0;
alter table TBL_SYUMEI
   alter RMSAGAKU	set default 0;
