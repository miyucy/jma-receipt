--                                    --
-- �����ƥ�����ǡ�������             --
-- �쥻�ץȼ��� 2003                  --
--                                    --
--                                    --
-- Create Date : 2008/03/26           --
--                                    --
\set ON_ERROR_STOP

update tbl_syskanri set edyukymd = '20080331' where kanricd = '2003' and kbncd in ('034','036','038','055','057','059','116','118','120','137','139','141','161','162','163','170','171','172','176','177','178','185','186','187','062','065','068','146','151','156','173','174','175','188','189','190','025','028','031','041','046','051','019','061','020','021','064','022','023','067','024','102','107','112','123','128','133','143','144','148','149','150','153','154','155','043','048','053','125','130','135','026','029','032','104','109','114') and edyukymd = 99999999;
delete from tbl_syskanri where kanricd = '2003' and kbncd = '145';
delete from tbl_syskanri where hospnum = 0;


COPY tbl_syskanri (kanricd, kbncd, styukymd, edyukymd, kanritbl, termid, opid, creymd, upymd, uphms, hospnum) FROM stdin;
2003	025     	20080401	99999999	���ݡ�ñ�ȡ�������̤���ؼ�              11114                                    2002			        	        	      	0
2003	028     	20080401	99999999	���ݡ�ʻ�ѡ�������̤���ؼ�              11124                                    2007			        	        	      	0
2003	031     	20080401	99999999	���ݡ�ʻ�ѣ�������̤���ؼ�              11134                                    2012			        	        	      	0
2003	041     	20080401	99999999	���ݡ�ñ�ȡ�������̤���ؼ�              21114                                    2002			        	        	      	0
2003	046     	20080401	99999999	���ݡ�ʻ�ѡ�������̤���ؼ�              21124                                    2007			        	        	      	0
2003	051     	20080401	99999999	���ݡ�ʻ�ѣ�������̤���ؼ�              21134                                    2012			        	        	      	0
2003	061     	20080401	99999999	���ݡ��࿦��������̤���ؼ�              21414                                    2017			        	        	      	0
2003	064     	20080401	99999999	���ݡ��࿦ʻ�ѡ���̤���ؼ�              21424                                    2020			        	        	      	0
2003	067     	20080401	99999999	���ݡ��࿦ʻ�ѣ���̤���ؼ�              21434                                    2023			        	        	      	0
2003	102     	20080401	99999999	���ݡ�ñ�ȡ�������̤���ؼ�              11113                                    1002			        	        	      	0
2003	107     	20080401	99999999	���ݡ�ʻ�ѡ�������̤���ؼ�              11123                                    1007			        	        	      	0
2003	112     	20080401	99999999	���ݡ�ʻ�ѣ�������̤���ؼ�              11133                                    1012			        	        	      	0
2003	123     	20080401	99999999	���ݡ�ñ�ȡ�������̤���ؼ�              21113                                    1002			        	        	      	0
2003	128     	20080401	99999999	���ݡ�ʻ�ѡ�������̤���ؼ�              21123                                    1007			        	        	      	0
2003	133     	20080401	99999999	���ݡ�ʻ�ѣ�������̤���ؼ�              21133                                    1012			        	        	      	0
2003	144     	20080401	99999999	���ݡ��࿦��������̤���ؼ�              21413                                    1017			        	        	      	0
2003	149     	20080401	99999999	���ݡ��࿦ʻ�ѡ���̤���ؼ�              21423                                    1020			        	        	      	0
2003	154     	20080401	99999999	���ݡ��࿦ʻ�ѣ���̤���ؼ�              21433                                    1023			        	        	      	0
2003	034     	20080401	99999999	���衡��������ñ�ȡ������̡������    61318                                    2001			        	        	      	0
2003	161     	20080401	99999999	���衡��������ñ�ȡ�������            61310                                    2002			        	        	      	0
2003	036     	20080401	99999999	���衡��������ʻ�ѡ������̡������    61328                                    2003			        	        	      	0
2003	162     	20080401	99999999	���衡��������ʻ�ѡ�������            61320                                    2004			        	        	      	0
2003	038     	20080401	99999999	���衡��������ʻ�ѣ������̡������    61338                                    2005			        	        	      	0
2003	163     	20080401	99999999	���衡��������ʻ�ѣ�������            61330                                    2006			        	        	      	0
2003	116     	20080401	99999999	���衡��������ñ�ȡ������̡������    61317                                    1001			        	        	      	0
2003	176     	20080401	99999999	���衡��������ñ�ȡ�������            61319                                    1002			        	        	      	0
2003	118     	20080401	99999999	���衡��������ʻ�ѡ������̡������    61327                                    1003			        	        	      	0
2003	177     	20080401	99999999	���衡��������ʻ�ѡ�������            61329                                    1004			        	        	      	0
2003	120     	20080401	99999999	���衡��������ʻ�ѣ������̡������    61337                                    1005			        	        	      	0
2003	178     	20080401	99999999	���衡��������ʻ�ѣ�������            61339                                    1006			        	        	      	0
2003	019     	20080401	99999999	���ݡ��࿦���������ܿ�                  21412                                    2016			        	        	      	0
2003	020     	20080401	99999999	���ݡ��࿦����������²                  21416                                    2018			        	        	      	0
2003	021     	20080401	99999999	���ݡ��࿦ʻ�ѡ����ܿ�                  21422                                    2019			        	        	      	0
2003	022     	20080401	99999999	���ݡ��࿦ʻ�ѡ�����²                  21426                                    2021			        	        	      	0
2003	023     	20080401	99999999	���ݡ��࿦ʻ�ѣ����ܿ�                  21432                                    2022			        	        	      	0
2003	024     	20080401	99999999	���ݡ��࿦ʻ�ѣ�����²                  21436                                    2024			        	        	      	0
2003	143     	20080401	99999999	���ݡ��࿦���������ܿ�                  21411                                    1016			        	        	      	0
2003	145     	20021001	20080331	���ݡ��࿦����������²                  21415                                    1024			        	        	      	0
2003	145     	20080401	99999999	���ݡ��࿦����������²                  21415                                    1018			        	        	      	0
2003	148     	20080401	99999999	���ݡ��࿦ʻ�ѡ����ܿ�                  21421                                    1019			        	        	      	0
2003	150     	20080401	99999999	���ݡ��࿦ʻ�ѡ�����²                  21425                                    1021			        	        	      	0
2003	153     	20080401	99999999	���ݡ��࿦ʻ�ѣ����ܿ�                  21431                                    1022			        	        	      	0
2003	155     	20080401	99999999	���ݡ��࿦ʻ�ѣ�����²                  21435                                    1024			        	        	      	0
2003	026     	20080401	99999999	���ݡ�ñ�ȡ���������������԰��̡������11118                                    2004			        	        	      	0
2003	029     	20080401	99999999	���ݡ�ʻ�ѡ���������������԰��̡������11128                                    2009			        	        	      	0
2003	032     	20080401	99999999	���ݡ�ʻ�ѣ���������������԰��̡������11138                                    2014			        	        	      	0
2003	043     	20080401	99999999	���ݡ�ñ�ȡ���������������԰��̡������21118                                    2004			        	        	      	0
2003	048     	20080401	99999999	���ݡ�ʻ�ѡ���������������԰��̡������21128                                    2009			        	        	      	0
2003	053     	20080401	99999999	���ݡ�ʻ�ѣ���������������԰��̡������21138                                    2014			        	        	      	0
2003	104     	20080401	99999999	���ݡ�ñ�ȡ���������������԰��̡������11117                                    1004			        	        	      	0
2003	109     	20080401	99999999	���ݡ�ʻ�ѡ���������������԰��̡������11127                                    1009			        	        	      	0
2003	114     	20080401	99999999	���ݡ�ʻ�ѣ���������������԰��̡������11137                                    1014			        	        	      	0
2003	125     	20080401	99999999	���ݡ�ñ�ȡ���������������԰��̡������21117                                    1004			        	        	      	0
2003	130     	20080401	99999999	���ݡ�ʻ�ѡ���������������԰��̡������21127                                    1009			        	        	      	0
2003	135     	20080401	99999999	���ݡ�ʻ�ѣ���������������԰��̡������21137                                    1014			        	        	      	0
\.

insert into tbl_syskanri
select
a.kanricd,
a.kbncd,
a.styukymd,
a.edyukymd,
a.kanritbl,
a.termid,
a.opid,
a.creymd,
a.upymd,
a.uphms,
b.hospnum
from tbl_syskanri a,tbl_sysbase b
where
    a.hospnum = 0 ;

delete from tbl_syskanri where hospnum = 0;

