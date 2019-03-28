--                                                --
-- 平成２０年度改定入院加算チェック追加           --
--                                                -- 
-- 入院料加算追加の対応                           --
--   ２５対１補助体制加算                         --
--   ５０対１補助体制加算                         --
--   ７５対１補助体制加算                         --
-- １００対１補助体制加算                         --
--                                                --
--                                                --
-- Create Date : 2008/03/11                       --
--                                                --
\set ON_ERROR_STOP

delete from tbl_nyuksnchk where ksnkbn = '416' and yukostymd = '20080401';
delete from tbl_nyuksnchk where ksnkbn = '417' and yukostymd = '20080401';
delete from tbl_nyuksnchk where ksnkbn = '418' and yukostymd = '20080401';
delete from tbl_nyuksnchk where ksnkbn = '419' and yukostymd = '20080401';

COPY "tbl_nyuksnchk" FROM stdin;
135	416	20080401	99999999	1			        	        	      
135	417	20080401	99999999	1			        	        	      
135	418	20080401	99999999	1			        	        	      
135	419	20080401	99999999	1			        	        	      
159	416	20080401	99999999	1			        	        	      
159	417	20080401	99999999	1			        	        	      
159	418	20080401	99999999	1			        	        	      
159	419	20080401	99999999	1			        	        	      
001	416	20080401	99999999	1			        	        	      
001	417	20080401	99999999	1			        	        	      
001	418	20080401	99999999	1			        	        	      
001	419	20080401	99999999	1			        	        	      
002	416	20080401	99999999	1			        	        	      
002	417	20080401	99999999	1			        	        	      
002	418	20080401	99999999	1			        	        	      
002	419	20080401	99999999	1			        	        	      
003	416	20080401	99999999	1			        	        	      
003	417	20080401	99999999	1			        	        	      
003	418	20080401	99999999	1			        	        	      
003	419	20080401	99999999	1			        	        	      
009	416	20080401	99999999	1			        	        	      
009	417	20080401	99999999	1			        	        	      
009	418	20080401	99999999	1			        	        	      
009	419	20080401	99999999	1			        	        	      
099	416	20080401	99999999	1			        	        	      
099	417	20080401	99999999	1			        	        	      
099	418	20080401	99999999	1			        	        	      
099	419	20080401	99999999	1			        	        	      
100	416	20080401	99999999	1			        	        	      
100	417	20080401	99999999	1			        	        	      
100	418	20080401	99999999	1			        	        	      
100	419	20080401	99999999	1			        	        	      
142	416	20080401	99999999	1			        	        	      
142	417	20080401	99999999	1			        	        	      
142	418	20080401	99999999	1			        	        	      
142	419	20080401	99999999	1			        	        	      
161	416	20080401	99999999	1			        	        	      
161	417	20080401	99999999	1			        	        	      
161	418	20080401	99999999	1			        	        	      
161	419	20080401	99999999	1			        	        	      
055	416	20080401	99999999	1			        	        	      
055	417	20080401	99999999	1			        	        	      
055	418	20080401	99999999	1			        	        	      
055	419	20080401	99999999	1			        	        	      
056	416	20080401	99999999	1			        	        	      
056	417	20080401	99999999	1			        	        	      
056	418	20080401	99999999	1			        	        	      
056	419	20080401	99999999	1			        	        	      
162	416	20080401	99999999	1			        	        	      
162	417	20080401	99999999	1			        	        	      
162	418	20080401	99999999	1			        	        	      
162	419	20080401	99999999	1			        	        	      
070	416	20080401	99999999	1			        	        	      
070	417	20080401	99999999	1			        	        	      
070	418	20080401	99999999	1			        	        	      
070	419	20080401	99999999	1			        	        	      
071	416	20080401	99999999	1			        	        	      
071	417	20080401	99999999	1			        	        	      
071	418	20080401	99999999	1			        	        	      
071	419	20080401	99999999	1			        	        	      
072	416	20080401	99999999	1			        	        	      
072	417	20080401	99999999	1			        	        	      
072	418	20080401	99999999	1			        	        	      
072	419	20080401	99999999	1			        	        	      
201	416	20080401	99999999	1			        	        	      
201	417	20080401	99999999	1			        	        	      
201	418	20080401	99999999	1			        	        	      
201	419	20080401	99999999	1			        	        	      
202	416	20080401	99999999	1			        	        	      
202	417	20080401	99999999	1			        	        	      
202	418	20080401	99999999	1			        	        	      
202	419	20080401	99999999	1			        	        	      
203	416	20080401	99999999	1			        	        	      
203	417	20080401	99999999	1			        	        	      
203	418	20080401	99999999	1			        	        	      
203	419	20080401	99999999	1			        	        	      
230	416	20080401	99999999	1			        	        	      
230	417	20080401	99999999	1			        	        	      
230	418	20080401	99999999	1			        	        	      
230	419	20080401	99999999	1			        	        	      
233	416	20080401	99999999	1			        	        	      
233	417	20080401	99999999	1			        	        	      
233	418	20080401	99999999	1			        	        	      
233	419	20080401	99999999	1			        	        	      
204	416	20080401	99999999	1			        	        	      
204	417	20080401	99999999	1			        	        	      
204	418	20080401	99999999	1			        	        	      
204	419	20080401	99999999	1			        	        	      
205	416	20080401	99999999	1			        	        	      
205	417	20080401	99999999	1			        	        	      
205	418	20080401	99999999	1			        	        	      
205	419	20080401	99999999	1			        	        	      
206	416	20080401	99999999	1			        	        	      
206	417	20080401	99999999	1			        	        	      
206	418	20080401	99999999	1			        	        	      
206	419	20080401	99999999	1			        	        	      
207	416	20080401	99999999	1			        	        	      
207	417	20080401	99999999	1			        	        	      
207	418	20080401	99999999	1			        	        	      
207	419	20080401	99999999	1			        	        	      
208	416	20080401	99999999	1			        	        	      
208	417	20080401	99999999	1			        	        	      
208	418	20080401	99999999	1			        	        	      
208	419	20080401	99999999	1			        	        	      
209	416	20080401	99999999	1			        	        	      
209	417	20080401	99999999	1			        	        	      
209	418	20080401	99999999	1			        	        	      
209	419	20080401	99999999	1			        	        	      
234	416	20080401	99999999	1			        	        	      
234	417	20080401	99999999	1			        	        	      
234	418	20080401	99999999	1			        	        	      
234	419	20080401	99999999	1			        	        	      
227	416	20080401	99999999	1			        	        	      
227	417	20080401	99999999	1			        	        	      
227	418	20080401	99999999	1			        	        	      
227	419	20080401	99999999	1			        	        	      
228	416	20080401	99999999	1			        	        	      
228	417	20080401	99999999	1			        	        	      
228	418	20080401	99999999	1			        	        	      
228	419	20080401	99999999	1			        	        	      
210	416	20080401	99999999	1			        	        	      
210	417	20080401	99999999	1			        	        	      
210	418	20080401	99999999	1			        	        	      
210	419	20080401	99999999	1			        	        	      
211	416	20080401	99999999	1			        	        	      
211	417	20080401	99999999	1			        	        	      
211	418	20080401	99999999	1			        	        	      
211	419	20080401	99999999	1			        	        	      
235	416	20080401	99999999	1			        	        	      
235	417	20080401	99999999	1			        	        	      
235	418	20080401	99999999	1			        	        	      
235	419	20080401	99999999	1			        	        	      
236	416	20080401	99999999	1			        	        	      
236	417	20080401	99999999	1			        	        	      
236	418	20080401	99999999	1			        	        	      
236	419	20080401	99999999	1			        	        	      
231	416	20080401	99999999	1			        	        	      
231	417	20080401	99999999	1			        	        	      
231	418	20080401	99999999	1			        	        	      
231	419	20080401	99999999	1			        	        	      
237	416	20080401	99999999	1			        	        	      
237	417	20080401	99999999	1			        	        	      
237	418	20080401	99999999	1			        	        	      
237	419	20080401	99999999	1			        	        	      
214	416	20080401	99999999	1			        	        	      
214	417	20080401	99999999	1			        	        	      
214	418	20080401	99999999	1			        	        	      
214	419	20080401	99999999	1			        	        	      
\.
