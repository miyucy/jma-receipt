--                                   --
-- 点数マスタの設定                  --
--                                   --
-- Create Date : 2006/03/13          --
--                                   --

-- 入院用システム予約コード作成      --
-- 099999918 食事（朝）              --
-- 099999919 食事（昼）              --
-- 099999920 食事（夕）              --
-- システム管理病棟設定表示用コード  --
-- 099999950 有床診療所入院基本料１  --
-- 099999951 有床診療所入院基本料２  --

insert into tbl_tensu (srycd,yukostymd,yukoedymd,srykbn,srysyukbn,yukoketa,name,kanayukoketa,kananame,tensikibetu,ten,tanicd,datakbn,
chuksncd,chuksntsuban,kgnage,jgnage,ageksnkgn1,ageksnjgn1,ageksnsrycd1,ageksnkgn2,ageksnjgn2,ageksnsrycd2,ageksnkgn3,
ageksnjgn3,ageksnsrycd3,ageksnkgn4,ageksnjgn4,ageksnsrycd4,cdkbn_kbn,kokuchi_kbn,idokanren,yakkakjncd,syomeikanren,
chgymd,haisiymd,keikasochiymd,creymd,upymd,uphms)
values
('099999918','20060401','99999999','99','990',5,'食事（朝）',8,'ショクジ（アサ）',0,0,'000',1,
'0000','0','00','00','00','00','         ','00','00','         ','00','00','         ','00','00','         ',' ',' ','         ',
'            ','         ','        ','        ','        ','20060401','        ','000000');
insert into tbl_tensu (srycd,yukostymd,yukoedymd,srykbn,srysyukbn,yukoketa,name,kanayukoketa,kananame,tensikibetu,ten,tanicd,datakbn,
chuksncd,chuksntsuban,kgnage,jgnage,ageksnkgn1,ageksnjgn1,ageksnsrycd1,ageksnkgn2,ageksnjgn2,ageksnsrycd2,ageksnkgn3,
ageksnjgn3,ageksnsrycd3,ageksnkgn4,ageksnjgn4,ageksnsrycd4,cdkbn_kbn,kokuchi_kbn,idokanren,yakkakjncd,syomeikanren,
chgymd,haisiymd,keikasochiymd,creymd,upymd,uphms)
values
('099999919','20060401','99999999','99','990',5,'食事（昼）',8,'ショクジ（ヒル）',0,0,'000',1,
'0000','0','00','00','00','00','         ','00','00','         ','00','00','         ','00','00','         ',' ',' ','         ',
'            ','         ','        ','        ','        ','20060401','        ','000000');
insert into tbl_tensu (srycd,yukostymd,yukoedymd,srykbn,srysyukbn,yukoketa,name,kanayukoketa,kananame,tensikibetu,ten,tanicd,datakbn,
chuksncd,chuksntsuban,kgnage,jgnage,ageksnkgn1,ageksnjgn1,ageksnsrycd1,ageksnkgn2,ageksnjgn2,ageksnsrycd2,ageksnkgn3,
ageksnjgn3,ageksnsrycd3,ageksnkgn4,ageksnjgn4,ageksnsrycd4,cdkbn_kbn,kokuchi_kbn,idokanren,yakkakjncd,syomeikanren,
chgymd,haisiymd,keikasochiymd,creymd,upymd,uphms)
values
('099999920','20060401','99999999','99','990',5,'食事（夕）',8,'ショクジ（ユウ）',0,0,'000',1,
'0000','0','00','00','00','00','         ','00','00','         ','00','00','         ','00','00','         ',' ',' ','         ',
'            ','         ','        ','        ','        ','20060401','        ','000000');

insert into tbl_tensu (srycd,yukostymd,yukoedymd,srykbn,srysyukbn,yukoketa,name,kanayukoketa,kananame,tensikibetu,ten,tanicd,datakbn,
chuksncd,chuksntsuban,kgnage,jgnage,ageksnkgn1,ageksnjgn1,ageksnsrycd1,ageksnkgn2,ageksnjgn2,ageksnsrycd2,ageksnkgn3,
ageksnjgn3,ageksnsrycd3,ageksnkgn4,ageksnjgn4,ageksnsrycd4,cdkbn_kbn,kokuchi_kbn,idokanren,yakkakjncd,syomeikanren,
chgymd,haisiymd,keikasochiymd,creymd,upymd,uphms)
values
('099999950','20060401','99999999','99','990',11,'有床診療所入院基本料１',6,'ユウショウ１',0,0,'000',1,
'0000','0','00','00','00','00','         ','00','00','         ','00','00','         ','00','00','         ',' ',' ','         ',
'            ','         ','        ','        ','        ','20060401','        ','000000');
insert into tbl_tensu (srycd,yukostymd,yukoedymd,srykbn,srysyukbn,yukoketa,name,kanayukoketa,kananame,tensikibetu,ten,tanicd,datakbn,
chuksncd,chuksntsuban,kgnage,jgnage,ageksnkgn1,ageksnjgn1,ageksnsrycd1,ageksnkgn2,ageksnjgn2,ageksnsrycd2,ageksnkgn3,
ageksnjgn3,ageksnsrycd3,ageksnkgn4,ageksnjgn4,ageksnsrycd4,cdkbn_kbn,kokuchi_kbn,idokanren,yakkakjncd,syomeikanren,
chgymd,haisiymd,keikasochiymd,creymd,upymd,uphms)
values
('099999951','20060401','99999999','99','990',11,'有床診療所入院基本料２',6,'ヨウウショウ２',0,0,'000',1,
'0000','0','00','00','00','00','         ','00','00','         ','00','00','         ','00','00','         ',' ',' ','         ',
'            ','         ','        ','        ','        ','20060401','        ','000000');
