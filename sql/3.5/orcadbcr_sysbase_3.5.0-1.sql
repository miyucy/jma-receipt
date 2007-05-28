--                                    --
-- システム基本テーブルの作成         --
--                                    --
--                                    --
-- Create Date : 2007/1/24            --
--                                    --

-- TBL_SYSBASE 作成                   --

create	table	tbl_sysbase	(
	GRPNUM		int,
	HOSPNUM 	numeric(2,0);
	HOSPNAME	varchar(120),
	KIGEN		char(8),
	HONBUNGRP	int,
	HONBUNKBN 	int,
	CREYMD		char(8),
	UPYMD		char(8),
	UPHMS		char(6),
	constraint tbl_sysbase_primary_key primary key(
		GRPNUM
	)
);

insert into tbl_sysbase values (1, 1, '＊', '99999999', 0, 0, to_char(now(),'yyyymmdd'), '', to_char(now(),'hh24miss'));
