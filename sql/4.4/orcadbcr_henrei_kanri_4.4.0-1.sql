\set ON_ERROR_STOP
--
-- オンライン返戻管理テーブル
--
-- Create Date : 2008/12/12         --
--
create	table	tbl_henrei_kanri	(
	HOSPNUM	numeric(2,0),
	TEISYUTUSAKI	char(1),
	SYORIYM	char(6),
	RECV_TOTAL_CNT	numeric(5,0),
	RECV_PATIENT_CNT	numeric(5,0),
	RECV_GO_CNT	numeric(5,0),
	RECV_GO_TEN	numeric(10,0),
	TERMID	varchar(64),
	OPID	varchar(16),
	CREYMD	char(8),
	UPYMD	char(8),
	UPHMS	char(6),
	Constraint "tbl_henrei_kanri_primary_key" primary key(
		HOSPNUM,
		TEISYUTUSAKI,
		SYORIYM
	)
);
