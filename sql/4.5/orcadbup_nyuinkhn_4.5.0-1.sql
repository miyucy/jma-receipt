--                                              --
-- 平成２２年度改定入院基本データ追加           --
--                                              --
-- 有床診療所入院基本料１（期間切替え）         --
-- 有床診療所入院基本料２（期間切替え）         --
-- 有床診療所入院基本料３（追加）               --
-- 一般病棟７対１特別入院基本料（追加）         --
-- 一般病棟１０対１特別入院基本料（追加）       --
-- 結核病棟７対１特別入院基本料（追加）         --
-- 結核病棟１０対１特別入院基本料（追加）       --
-- 精神病棟１３対１入院基本料（追加）           --
-- 精神病棟１０対１特別入院基本料（追加）       --
-- 特定機能病院精神病棟１３対１入院基本料（追加） --
-- 精神病棟特別入院基本料（期間加算の変更）     --
--                                              --
-- Create Date : 2010/03/02                     --
--                                              --
\set ON_ERROR_STOP

delete from tbl_nyuinkhn where khn_srycd = '099999950';
delete from tbl_nyuinkhn where khn_srycd = '099999951';
delete from tbl_nyuinkhn where khn_srycd = '099999952';
delete from tbl_nyuinkhn where khn_srycd = '190131310';
delete from tbl_nyuinkhn where khn_srycd = '190131410';
delete from tbl_nyuinkhn where khn_srycd = '190134310';
delete from tbl_nyuinkhn where khn_srycd = '190134410';
delete from tbl_nyuinkhn where khn_srycd = '190134510';
delete from tbl_nyuinkhn where khn_srycd = '190134610';
delete from tbl_nyuinkhn where khn_srycd = '190134710';
delete from tbl_nyuinkhn where khn_srycd = '190085010' and yukostymd = '20060401';
delete from tbl_nyuinkhn where khn_srycd = '190085010' and yukostymd = '20100401';

COPY "tbl_nyuinkhn" FROM stdin;
099999950	20060401	20100331	1	 	  	  	  	  	  	0	190097010	190097110	190119510	190119610	190119610	190119610	190119610			        	        	      
099999951	20060401	20100331	1	 	  	  	  	  	  	0	190097210	190097310	190119710	190119810	190119810	190119810	190119810			        	        	      
099999950	20100401	99999999	1	 	  	  	  	  	  	0	190097010	190119510	190119610	190119610	190119610	190119610	190119610			        	        	      
099999951	20100401	99999999	1	 	  	  	  	  	  	0	190097210	190119710	190119810	190119810	190119810	190119810	190119810			        	        	      
099999952	20100401	99999999	1	 	  	  	  	  	  	0	190135110	190135210	190135310	190135310	190135310	190135310	190135310			        	        	      
190131310	20100401	99999999	1	 	  	  	  	  	  	1244	190079570	190079770	         	         	         	         	         			        	        	      
190131410	20100401	99999999	1	 	  	  	  	  	  	1040	190079570	190079770	         	         	         	         	         			        	        	      
190134310	20100401	99999999	1	 	  	  	  	  	  	1158	190118110	190083470	190122770	         	         	         	         			        	        	      
190134410	20100401	99999999	1	 	  	  	  	  	  	954	190118110	190083470	190122770	         	         	         	         			        	        	      
190134510	20100401	99999999	1	 	  	  	  	  	  	920	190085210	190085410	190085610	190085710	190085710	190085810	         			        	        	      
190134610	20100401	99999999	1	 	  	  	  	  	  	992	190085310	190085510	190118270	190085710	190085710	190085810	         			        	        	      
190134710	20100401	99999999	1	 	  	  	  	  	  	920	190089770	190089870	190089970	190090070	190090070	190090170	         			        	        	      
190085010	20060401	20100331	1	 	  	  	  	  	  	550	190085310	190085510	190118270	190118370	190118370	190118470	         			        	        	      
190085010	20100401	99999999	1	 	  	  	  	  	  	550	190085310	190085510	190118270	190085710	190085710	190085810	         			        	        	      
\.
