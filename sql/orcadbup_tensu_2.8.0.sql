--                                   --
-- 点数マスタの設定                  --
--                                   --
-- Create Date : 2006/03/13          --
--                                   --

-- 入院用システム予約コード作成      --
-- 099999918 食事（朝）              --
-- 099999919 食事（昼）              --
-- 099999920 食事（夕）              --

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
