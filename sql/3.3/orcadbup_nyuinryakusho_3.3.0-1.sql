\set ON_ERROR_STOP
delete from tbl_nyuinryakusho where srycd = '190123710' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190123810' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190123910' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124010' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124110' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124210' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124310' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124410' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124510' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124610' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124710' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124810' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190124910' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190125010' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190125110' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190125210' and yukostymd = '20061001' and yukoedymd = '99999999';
delete from tbl_nyuinryakusho where srycd = '190125310' and yukostymd = '20061001' and yukoedymd = '99999999';
COPY "tbl_nyuinryakusho" FROM stdin;
190123710	20061001	99999999	療Ａ生						
190123810	20061001	99999999	療Ｂ生						
190123910	20061001	99999999	療Ｃ生						
190124010	20061001	99999999	療Ｄ生						
190124110	20061001	99999999	療Ｅ生						
190124210	20061001	99999999	療特生						
190124310	20061001	99999999	診療Ａ生						
190124410	20061001	99999999	診療Ｂ生						
190124510	20061001	99999999	診療Ｃ生						
190124610	20061001	99999999	診療Ｄ生						
190124710	20061001	99999999	診療Ｅ生						
190124810	20061001	99999999	診療２特生						
190124910	20061001	99999999	復リ入生						
190125010	20061001	99999999	診医療管生						
190125110	20061001	99999999	診医療管生						
190125210	20061001	99999999	診医療管生						
190125310	20061001	99999999	短手２生						
\.
