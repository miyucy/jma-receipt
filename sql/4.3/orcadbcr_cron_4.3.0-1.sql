create	table	tbl_cron	(
	CRONID	numeric(4,0),
	RUN	char(1),
	NAME	varchar(30),
	MIN	char(2),
	HOUR	char(2),
	DOM	char(2),
	MON	char(2),
	DOW	char(1),
	SCRIPT	varchar(100),
	TERMID	varchar(16),
	OPID	varchar(16),
	CREYMD	char(8),
	UPYMD	char(8),
	UPHMS	char(6)
);

ALTER TABLE ONLY tbl_cron
    ADD CONSTRAINT tbl_cron_primary_key PRIMARY KEY (cronid);

COMMENT ON TABLE tbl_cron IS 'クーロン情報';
