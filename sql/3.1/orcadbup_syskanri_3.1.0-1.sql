\set ON_ERROR_STOP

delete from tbl_syskanri where kanricd = '0044' and kbncd = '1024';

COPY "tbl_syskanri" FROM stdin;
0044	1024    	00000000	99999999	診療行為別集計表                                                                                                                                                ORCBG017                診療年月            YM        入外区分            PSN1      診療科              SRYKA     診療区分１          SRYKBN    診療区分２          SRYKBN    診療区分３          SRYKBN    診療区分４          SRYKBN    診療区分５          SRYKBN                                                                11212222			20060628	20060628	183117
\.
