--                                                         --
-- 医療観察法入院略称テーブル                              --
--                                                         --
-- 急性期入院対象者入院医学管理料   (188000110)            --
-- 回復期入院対象者入院医学管理料   (188000510)            --
-- 社会復帰期入院対象者入院医学管理料   (188000610)        --
--                                                         --
--                                              --
-- Create Date : 2010/08/02                     --
--                                              --
\set ON_ERROR_STOP

delete from tbl_nyuinryakusho where srycd = '188000110';
delete from tbl_nyuinryakusho where srycd = '188000510';
delete from tbl_nyuinryakusho where srycd = '188000610';

COPY "tbl_nyuinryakusho" FROM stdin;
188000110	20100401	99999999	観察急性期				        	        	      
188000510	20100401	99999999	観察回復期				        	        	      
188000610	20100401	99999999	観察復帰期				        	        	      
\.
