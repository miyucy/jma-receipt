\set ON_ERROR_STOP
delete from tbl_nyuinryakusho where srycd = '190121310' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190121410' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190121510' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190121610' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190121710' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190121810' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190122010' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190122110' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190122210' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190122310' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190122410' and yukostymd = '20060701' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190122510' and yukostymd = '20060701' and yukoedymd = '99999999';
COPY "tbl_nyuinryakusho" FROM stdin;
190121310	20060701	99999999	療Ａ						
190121410	20060701	99999999	療Ｂ						
190121510	20060701	99999999	療Ｃ						
190121610	20060701	99999999	療Ｄ						
190121710	20060701	99999999	療Ｅ						
190121810	20060701	99999999	療特						
190122010	20060701	99999999	診療Ａ						
190122110	20060701	99999999	診療Ｂ						
190122210	20060701	99999999	診療Ｃ						
190122310	20060701	99999999	診療Ｄ						
190122410	20060701	99999999	診療Ｅ						
190122510	20060701	99999999	診療２特						
\.
