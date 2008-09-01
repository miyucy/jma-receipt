DELETE from tbl_cron;

COPY tbl_cron (cronid, run, name, min, "hour", dom, mon, dow, script, termid, opid, creymd, upymd, uphms) FROM stdin;
1	1	ＤＢバックアップ	00	01	* 	* 	*	db-backup.sh			20080828	20080828	032359
\.

