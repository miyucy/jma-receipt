delete from tbl_syskanri where kanricd = '5110' and kbncd = '05' and styukymd = '20040401';
delete from tbl_syskanri where kanricd = '5110' and kbncd = '06';
delete from tbl_syskanri where kanricd = '5110' and kbncd = '15';

COPY "tbl_syskanri" FROM stdin;
5110	05      	20040401	99999999	老人性認知症疾患治療病棟入院料１        老認治１			        	        	      
5110	06      	00000000	99999999	老人性認知症疾患療養病棟入院料          老認療			        	        	      
5110	15      	20040401	99999999	老人性認知症疾患治療病棟入院料２        老認治２			        	        	      
\.
