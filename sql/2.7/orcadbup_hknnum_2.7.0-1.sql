copy "tbl_hknnum" FROM stdin;
JPN000000000000         	069	19900101	00	99999999	  	退職特別療養費	退特療費	1	0	1	 	 	   	   	   	0	999	10	 	1	0	1	100	0	0	0	0	0	0	0	0	1	100	0	0	0	0	0	0	0	0	1	100	0	0	0	0	0	0	0	0	1	100	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0			        	        	      
JPN000000000000         	068	19900101	00	99999999	  	特別療養費	特療費	1	0	1	 	 	   	   	   	0	999	10	 	1	0	1	100	0	0	0	0	0	0	0	0	1	100	0	0	0	0	0	0	0	0	1	100	0	0	0	0	0	0	0	0	1	100	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0			        	        	      
\.

update tbl_hknnum set hospid = a.hospid 
from (select hospid from tbl_hknnum
where hknnum = '001'
 and  paykbn = '00'
 and  tekstymd <= '20050401'
 and  tekedymd >= '20050401'
) a
where 
tbl_hknnum.hknnum in ('068','069');
