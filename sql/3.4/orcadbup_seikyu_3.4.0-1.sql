--                                    --
-- ��������ơ��֥���ѹ�             --
--                                    --
-- ���ܤ��ɲ�                         --
--   �ݸ��ɣ�    (HKNID)              --
--   Ϸ�͸���ɣ�(RJNHKNID)           --
--   ����ɣ�    (KOHID1)             --
--               (KOHID2)             --
--               (KOHID3)             --
--               (KOHID4)             --
--                                    --
-- Create Date : 2007/02/27           --
--                                    --
\set ON_ERROR_STOP

--    �����ɲ�                        --
alter table tbl_seikyu
   add column HKNID  numeric(10);
alter table tbl_seikyu
   add column RJNHKNID  numeric(10);
alter table tbl_seikyu
   add column KOHID1  numeric(10);
alter table tbl_seikyu
   add column KOHID2  numeric(10);
alter table tbl_seikyu
   add column KOHID3  numeric(10);
alter table tbl_seikyu
   add column KOHID4  numeric(10);

--    ��������                       --
alter table tbl_seikyu
   alter HKNID set default 0;
alter table tbl_seikyu
   alter RJNHKNID set default 0;
alter table tbl_seikyu
   alter KOHID1 set default 0;
alter table tbl_seikyu
   alter KOHID2 set default 0;
alter table tbl_seikyu
   alter KOHID3 set default 0;
alter table tbl_seikyu
   alter KOHID4 set default 0;

update tbl_seikyu set HKNID = 0;
update tbl_seikyu set RJNHKNID = 0;
update tbl_seikyu set KOHID1 = 0;
update tbl_seikyu set KOHID2 = 0;
update tbl_seikyu set KOHID3 = 0;
update tbl_seikyu set KOHID4 = 0;
