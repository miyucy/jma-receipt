--                                --
-- ORCA DataBase Table Definition --
--                                --
-- 入院オーダー情報       --
--                                --
-- Table Name  : TBL_ORDER       --
-- Create Date : 2004/10/14       --
--                                --

create table TBL_ORDER (
	HOSPID			 	char(24) 		not null,
	KARTE_KEY			varchar(36) 	not null,
	NYUGAIKBN			char(1) 		not null,
	PTNUM				char(20) 		not null,
	PTID				numeric(10,0) 	not null,
	SRYKA				char(2) 		not null,
	SRYYMD				char(8) 		not null,
	HKNCOMBI			numeric(4,0) 	not null,
	ORDERNUM			numeric(2,0) 	not null,
	RENNUM				numeric(2,0) 	not null,
	UKEYMD   			char(8) 		not null,
	UKEHMS   			char(6) 		not null,
	DRCD				char(5),
	STATUS				char(1),
	ERRCD1				char(4),
	ERRCD2				char(4),
	ZAICD				char(2),
	SRYSYUKBN			char(3),
	IDOKBN				char(2),
	SRYSKBKBN			char(5),
	SRYCD				char(9),
	SRYSURYO			numeric(8,3),
	SRYKAISU			numeric(3,0),
	ZAIKAISU			numeric(8,0),
	ERRCD_ZAI			char(4),
	ERRCD_ITEM			char(4),
	CREKBN				char(1),
	KARTE_KEY_STS		char(1),
	REMARKS				varchar(80),
	TERMID   			varchar(16),
	OPID     			varchar(16),
	CREYMD   			char(8),
	UPYMD    			char(8),
	UPHMS				char(6),
constraint TBL_ORDER_primary_key primary key (HOSPID,KARTE_KEY,NYUGAIKBN,PTNUM,PTID,SRYKA,SRYYMD,HKNCOMBI,
ORDERNUM,RENNUM,UKEYMD,UKEHMS));
