\set ON_ERROR_STOP
--
--
-- ¼ıÇ¼ÍúÎòÈÖ¹æ(SYURRKNUM)ÄÉ²Ã
-- ¼ıÇ¼ÍúÎò»ŞÈÖ¹æ(SYURRKEDANUM)ÄÉ²Ã
-- ¼ıÇ¼ÍúÎò¹¹¿·¶èÊ¬(SYURRKUPDKBN)ÄÉ²Ã
-- 
-- Create Date : 2006/12/19           --
--
--  ¹àÌÜÄÉ²Ã                        --
alter table TBL_SYUMEI_PRV
   add column SYURRKNUM		integer;
alter table TBL_SYUMEI_PRV
   add column SYUEDANUM		integer;
alter table TBL_SYUMEI_PRV
   add column SYURRKUPDKBN	char(1);


--  ¥¼¥íÀßÄê                       --
alter table TBL_SYUMEI_PRV
   alter SYURRKNUM	set default 0;
alter table TBL_SYUMEI_PRV
   alter SYUEDANUM	set default 0;

alter table TBL_SYUMEI_PRV add  column hospnum  integer;
alter table TBL_SYUMEI_PRV drop column hospid;
update TBL_SYUMEI_PRV set hospnum = 1 ;
alter table TBL_SYUMEI_PRV add constraint tbl_syumei_primary_prv_key primary key (hospnum,ptid,denpnum,denpedanum,creymd);
