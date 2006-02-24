      *******************************************************************
      * Project code name "ORCA"
      * 日医標準レセプトソフト（JMA standard receipt software）
      * Copyright(C) 2002 JMA (Japan Medical Association)
      *
      * This program is part of "JMA standard receipt software".
      *
      *     This program is distributed in the hope that it will be useful
      * for further advancement in medical care, according to JMA Open
      * Source License, but WITHOUT ANY WARRANTY.
      *     Everyone is granted permission to use, copy, modify and
      * redistribute this program, but only under the conditions described
      * in the JMA Open Source License. You should have received a copy of
      * this license along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
      *
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCGW12.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : レセプト印刷情報（Ｗ１２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/02/26  レセ電区分、レセ電出力先の追加
      *  01.00.02    MCC-藤原     02/03/28  国保ＯＣＲ区分、国保診療報酬請求書
      *                                     区分の追加
      *  01.00.03    MCC-藤原     02/04/03  県単用項目編集プログラム名の追加
      *  01.00.04    MCC-藤原     02/05/13  病名編集区分１（診療科別）の追加
      *  01.00.05    MCC-藤原     02/06/04  転帰日編集区分の追加
      *  01.00.06    MCC-藤原     02/07/04  出力先プリンタ情報の追加
      *  02.00.01    NACL-多々納  02/11/13  一括入力 
      *  02.00.02    NACL-藤原    03/01/08  通し番号編集区分の追加 
      *  02.00.03    NACL-藤原    03/02/27  入院用県単用項目編集プログラム名の追加
      *  02.00.04    NACL-藤原    03/03/07  未入力時のチェック
      *  02.00.05    NACL-藤原    03/04/09  続紙区分（入院）の追加
      *  02.00.06    NACL-藤原    03/07/02  主病名編集フラグの追加
      *  02.00.07    NACL-藤原    03/08/06  レセ電の設定の修正
      *  02.00.08    NACL-藤原    03/08/21  続紙区分（入院外）
      *                                     ・続紙出力先の追加
      *  02.00.09    NACL-太田    03/11/18  老人と原爆区分の追加
      *  02.00.10    NACL-太田    04/01/15  自費レセプト摘要欄記載区分追加
      *  02.00.11    NACL-藤原    04/02/18  社保ＯＣＲ区分の追加
      *  02.00.12    NACL-藤原    04/03/05  主病名編集フラグに区分を追加
      *  02.00.13    NACL-藤原    04/03/29  続紙区分に縦形式（長）追加
      *  02.00.14    NACL-藤原    04/04/09  レセプトコメント（症状詳記）記録区分
      *                                     ・診療科編集区分の追加
      *  02.00.15    NACL-太田    04/04/15  プリンタ名の指定を入／外分ける
      *  02.00.16    NACL-藤原    04/07/02  出力順・自動遷移区分を追加
      *  02.00.17    NACL-藤原    04/09/29  レセ電・ＯＣＲ区分の設定に追加
      *
      *  02.07.01    NACL-藤原    05/08/20  特別療養費対応
      *                                     「特別療養費」文字記載位置
      *                                     給付割合欄記載区分
      *                                     レセプト種別欄記載区分
      *                                     を追加 
      *
      *  02.07.02    NACL-藤原    05/12/12  国保レセプト編綴順対応
      *                                     MONFUNC対応
      *  02.07.03    NACL-藤原    06/02/01  主科対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-W12.
           03  SPA-W12-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-HSTYUKYMD       PIC X(09).
                   07  SPA-GMN-HEDYUKYMD       PIC X(09).              
      *
                   07  SPA-GMN-KOUMOKU.
                       09  SPA-GMN-BYOMEIHENKBN-G.
                           11  SPA-GMN-BYOMEIHENKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-BYOMEIHENKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-BYOMEIHENKBN1-G.
                           11  SPA-GMN-BYOMEIHENKBN1
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-BYOMEIHENKBN1MEI
                                              PIC X(20).
                       09  SPA-GMN-SYUBYOHENFLG-G.
                           11  SPA-GMN-SYUBYOHENFLG
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SYUBYOHENFLGMEI
                                              PIC X(44).
                       09  SPA-GMN-TENKIHENKBN-G.
                           11  SPA-GMN-TENKIHENKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-TENKIHENKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-KKHRECEKBN-G.
                           11  SPA-GMN-KKHRECEKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-KKHRECEKBNMEI
                                              PIC X(22).
                       09  SPA-GMN-SYARECEKBN-G.
                           11  SPA-GMN-SYARECEKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SYARECEKBNMEI
                                              PIC X(22).
                       09  SPA-GMN-RECEDENOUT PIC X(30).              
                       09  SPA-GMN-SYAOCRKBN-G.
                           11  SPA-GMN-SYAOCRKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SYAOCRKBNMEI
                                              PIC X(22).
                       09  SPA-GMN-KKHOCRKBN-G.
                           11  SPA-GMN-KKHOCRKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-KKHOCRKBNMEI
                                              PIC X(22).
                       09  SPA-GMN-PREFPRGID  PIC X(15).              
                       09  SPA-GMN-PREFPRGID1 PIC X(15).              
                       09  SPA-GMN-SYAPRTNM   PIC X(16).              
                       09  SPA-GMN-KKHPRTNM   PIC X(16).              
                       09  SPA-GMN-SYAPRTNM-NEXT
                                              PIC X(16).              
                       09  SPA-GMN-KKHPRTNM-NEXT
                                              PIC X(16).              
                       09  SPA-GMN-SYAPRTNM-N PIC X(16).              
                       09  SPA-GMN-KKHPRTNM-N PIC X(16).              
                       09  SPA-GMN-SYAPRTNM-NEXT-N
                                              PIC X(16).              
                       09  SPA-GMN-KKHPRTNM-NEXT-N
                                              PIC X(16).              
                       09  SPA-GMN-RENNUMHENKBN-G.
                           11  SPA-GMN-RENNUMHENKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-RENNUMHENKBNMEI
                                              PIC X(20).
                       09  SPA-GMN-NEXTPRTKBN-G.
                           11  SPA-GMN-NEXTPRTKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-NEXTPRTKBNMEI
                                              PIC X(14).
                       09  SPA-GMN-NEXTPRTKBN1-G.
                           11  SPA-GMN-NEXTPRTKBN1
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-NEXTPRTKBN1MEI
                                              PIC X(14).
                       09  SPA-GMN-RJNGNBKKBN-G.
                           11  SPA-GMN-RJNGNBKKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-RJNGNBKKBNMEI
                                              PIC X(22).
                       09  SPA-GMN-JIHITEKKSIKBN-G.
                           11  SPA-GMN-JIHITEKKSIKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-JIHITEKKSIKBNMEI
                                              PIC X(08).
                       09  SPA-GMN-RECECOMKBN-G.
                           11  SPA-GMN-RECECOMKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-RECECOMKBNMEI
                                              PIC X(24).
                       09  SPA-GMN-SRYKAHENKBN-G.
                           11  SPA-GMN-SRYKAHENKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SRYKAHENKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-PRTJYUN1-G.
                           11  SPA-GMN-PRTJYUN1
                                              PIC X(02).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-PRTJYUN1MEI
                                              PIC X(22).
                       09  SPA-GMN-PRTJYUN2-G.
                           11  SPA-GMN-PRTJYUN2
                                              PIC X(02).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-PRTJYUN2MEI
                                              PIC X(22).
                       09  SPA-GMN-PRTJYUN3-G.
                           11  SPA-GMN-PRTJYUN3
                                              PIC X(02).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-PRTJYUN3MEI
                                              PIC X(22).
                       09  SPA-GMN-AUTODSPKBN-G.
                           11  SPA-GMN-AUTODSPKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-AUTODSPKBNMEI
                                              PIC X(18).
      *                                        
                       09  SPA-GMN-MOJI-KISAIKBN-G.
                           11  SPA-GMN-MOJI-KISAIKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-MOJI-KISAIKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-KYURATE-KISAIKBN-G.
                           11  SPA-GMN-KYURATE-KISAIKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-KYURATE-KISAIKBNMEI
                                              PIC X(24).
                       09  SPA-GMN-RECESYUBETU-KISAIKBN-G.
                           11  SPA-GMN-RECESYUBETU-KISAIKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-RECESYUBETU-KISAIKBNMEI
                                              PIC X(24).
      *                                        
                       09  SPA-GMN-KKHPRTKBN-G.
                           11  SPA-GMN-KKHPRTKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-KKHPRTKBNMEI
                                              PIC X(18).
      *
                       09  SPA-GMN-PREFKBN-PRTJYUN-G.
                           11  SPA-GMN-PREFKBN-PRTJYUN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-PREFKBN-PRTJYUNMEI
                                              PIC X(10).
                       09  SPA-GMN-HKNJANUM-PRTJYUN-G.
                           11  SPA-GMN-HKNJANUM-PRTJYUN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-HKNJANUM-PRTJYUNMEI
                                              PIC X(44).
                       09  SPA-GMN-RECESYUBETU-PRTJYUN-G.
                           11  SPA-GMN-RECESYUBETU-PRTJYUN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-RECESYUBETU-PRTJYUNMEI
                                              PIC X(28).
                       09  SPA-GMN-ZAITAKU-G.
                           11  SPA-GMN-ZAITAKU
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-ZAITAKUMEI
                                              PIC X(24).
                       09  SPA-GMN-CHOUKI-G.
                           11  SPA-GMN-CHOUKI
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-CHOUKIMEI
                                              PIC X(24).
                       09  SPA-GMN-HKNJANUM-PRTKBN-G.
                           11  SPA-GMN-HKNJANUM-PRTKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-HKNJANUM-PRTKBNMEI
                                              PIC X(22).
                       09  SPA-GMN-HKNJANUM   PIC X(08).
                       09  SPA-GMN-HKNJANAME  PIC X(50).
                       09  SPA-GMN-SELNUM     PIC 9(03).
                       09  SPA-GMN-STYUKYMD   PIC X(10).
                       09  SPA-GMN-EDYUKYMD   PIC X(10).
                       09  SPA-GMN-SYUKA-KBN-G.
                           11  SPA-GMN-SYUKA-KBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SYUKA-KBNMEI
                                              PIC X(20).
                       09  SPA-GMN-SYUKA-NYUIN-G.
                           11  SPA-GMN-SYUKA-NYUIN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SYUKA-NYUINMEI
                                              PIC X(20).
                       09  SPA-GMN-SYUKA-GAIRAI-G.
                           11  SPA-GMN-SYUKA-GAIRAI
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SYUKA-GAIRAIMEI
                                              PIC X(20).
                       09  SPA-GMN-SYUKA-MODE-G.
                           11  SPA-GMN-SYUKA-MODE
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SYUKA-MODEMEI
                                              PIC X(20).
                       09  SPA-GMN-SYUKA-SELECT-G.
                           11  SPA-GMN-SYUKA-SELECT
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SYUKA-SELECTMEI
                                              PIC X(20).
      *                                        
                   07  SPA-GMN-BYOMEIHENKBNLST        OCCURS  2.
                       09  SPA-GMN-BYOMEIHENKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-BYOMEIHENKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-BYOMEIHENKBN-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-BYOMEIHENKBN1LST       OCCURS  2.
                       09  SPA-GMN-BYOMEIHENKBN1L
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-BYOMEIHENKBN1MEIL
                                              PIC X(20).
                   07  SPA-GMN-BYOMEIHENKBN1-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-SYUBYOHENFLGLST       OCCURS  4.
                       09  SPA-GMN-SYUBYOHENFLGL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SYUBYOHENFLGMEIL
                                              PIC X(44).
                   07  SPA-GMN-SYUBYOHENFLG-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-TENKIHENKBNLST         OCCURS  2.
                       09  SPA-GMN-TENKIHENKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-TENKIHENKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-TENKIHENKBN-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-KKHRECEKBNLST          OCCURS  4.
                       09  SPA-GMN-KKHRECEKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-KKHRECEKBNMEIL
                                              PIC X(22).
                   07  SPA-GMN-KKHRECEKBN-MAX PIC 9(02).    
      *                                        
                   07  SPA-GMN-SYARECEKBNLST          OCCURS  4.
                       09  SPA-GMN-SYARECEKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SYARECEKBNMEIL
                                              PIC X(22).
                   07  SPA-GMN-SYARECEKBN-MAX PIC 9(02).    
      *                                        
                   07  SPA-GMN-KKHOCRKBNLST           OCCURS  4.
                       09  SPA-GMN-KKHOCRKBNL PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-KKHOCRKBNMEIL
                                              PIC X(22).
                   07  SPA-GMN-KKHOCRKBN-MAX  PIC 9(02).    
      *                                        
                   07  SPA-GMN-SYAOCRKBNLST           OCCURS  4.
                       09  SPA-GMN-SYAOCRKBNL PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SYAOCRKBNMEIL
                                              PIC X(22).
                   07  SPA-GMN-SYAOCRKBN-MAX  PIC 9(02).    
      *                                        
                   07  SPA-GMN-KKHPRTKBNLST           OCCURS  2.
                       09  SPA-GMN-KKHPRTKBNL PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-KKHPRTKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-KKHPRTKBN-MAX  PIC 9(02).    
      *                                        
                   07  SPA-GMN-RENNUMHENKBNLST        OCCURS  3.
                       09  SPA-GMN-RENNUMHENKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-RENNUMHENKBNMEIL
                                              PIC X(20).
                   07  SPA-GMN-RENNUMHENKBN-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-NEXTPRTKBNLST        OCCURS  3.
                       09  SPA-GMN-NEXTPRTKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-NEXTPRTKBNMEIL
                                              PIC X(14).
                   07  SPA-GMN-NEXTPRTKBN-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-NEXTPRTKBN1LST       OCCURS  4.
                       09  SPA-GMN-NEXTPRTKBN1L
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-NEXTPRTKBN1MEIL
                                              PIC X(14).
                   07  SPA-GMN-NEXTPRTKBN1-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-RJNGNBKKBNLST       OCCURS  4.
                       09  SPA-GMN-RJNGNBKKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-RJNGNBKKBNMEIL
                                              PIC X(22).
                   07  SPA-GMN-RJNGNBKKBN-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-JIHITEKKSIKBNLST
                                              OCCURS  2.
                       09  SPA-GMN-JIHITEKKSIKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-JIHITEKKSIKBNMEIL
                                              PIC X(08).
                   07  SPA-GMN-JIHITEKKSIKBN-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-RECECOMKBNLST  OCCURS  2.
                       09  SPA-GMN-RECECOMKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-RECECOMKBNMEIL
                                              PIC X(24).
                   07  SPA-GMN-RECECOMKBN-MAX PIC 9(02).    
      *                                        
                   07  SPA-GMN-SRYKAHENKBNLST OCCURS  2.
                       09  SPA-GMN-SRYKAHENKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SRYKAHENKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-SRYKAHENKBN-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-PRTJYUN1LST    OCCURS  5.
                       09  SPA-GMN-PRTJYUN1L  PIC X(02).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-PRTJYUN1MEIL
                                              PIC X(22).
                   07  SPA-GMN-PRTJYUN1-MAX   PIC 9(02).   
      * 
                   07  SPA-GMN-PRTJYUN2LST    OCCURS  5.
                       09  SPA-GMN-PRTJYUN2L  PIC X(02).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-PRTJYUN2MEIL
                                              PIC X(22).
                   07  SPA-GMN-PRTJYUN2-MAX   PIC 9(02).   
      * 
                   07  SPA-GMN-PRTJYUN3LST    OCCURS  5.
                       09  SPA-GMN-PRTJYUN3L  PIC X(02).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-PRTJYUN3MEIL
                                              PIC X(22).
                   07  SPA-GMN-PRTJYUN3-MAX   PIC 9(02).   
      * 
                   07  SPA-GMN-AUTODSPKBNLST  OCCURS  2.
                       09  SPA-GMN-AUTODSPKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-AUTODSPKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-AUTODSPKBN-MAX PIC 9(02).   
      * 
                   07  SPA-GMN-MOJI-KISAIKBNLST  OCCURS  5.
                       09  SPA-GMN-MOJI-KISAIKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-MOJI-KISAIKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-MOJI-KISAIKBN-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-KYURATE-KISAIKBNLST     OCCURS  5.
                       09  SPA-GMN-KYURATE-KISAIKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-KYURATE-KISAIKBNMEIL
                                              PIC X(24).
                   07  SPA-GMN-KYURATE-KISAIKBN-MAX PIC 9(02).   
      * 
                   07  SPA-GMN-RECESYUBETU-KISAIKBNLST OCCURS  5.
                       09  SPA-GMN-RECESYUBETU-KISAIKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-RECESYUBETU-KISAIKBNMEIL
                                              PIC X(24).
                   07  SPA-GMN-RECESYUBETU-KISAIKBN-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-PREFKBN-PRTJYUNLST  OCCURS  5.
                       09  SPA-GMN-PREFKBN-PRTJYUNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-PREFKBN-PRTJYUNMEIL
                                              PIC X(10).
                   07  SPA-GMN-PREFKBN-PRTJYUN-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-HKNJANUM-PRTJYUNLST     OCCURS  6.
                       09  SPA-GMN-HKNJANUM-PRTJYUNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-HKNJANUM-PRTJYUNMEIL
                                              PIC X(44).
                   07  SPA-GMN-HKNJANUM-PRTJYUN-MAX PIC 9(02).   
      * 
                   07  SPA-GMN-RECESYUBETU-PRTJYUNLST OCCURS  6.
                       09  SPA-GMN-RECESYUBETU-PRTJYUNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-RECESYUBETU-PRTJYUNMEIL
                                              PIC X(28).
                   07  SPA-GMN-RECESYUBETU-PRTJYUN-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-ZAITAKULST  OCCURS  5.
                       09  SPA-GMN-ZAITAKUL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-ZAITAKUMEIL
                                              PIC X(24).
                   07  SPA-GMN-ZAITAKU-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-CHOUKILST     OCCURS  5.
                       09  SPA-GMN-CHOUKIL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-CHOUKIMEIL
                                              PIC X(24).
                   07  SPA-GMN-CHOUKI-MAX PIC 9(02).   
      * 
                   07  SPA-GMN-HKNJANUM-PRTKBNLST OCCURS  5.
                       09  SPA-GMN-HKNJANUM-PRTKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-HKNJANUM-PRTKBNMEIL
                                              PIC X(22).
                   07  SPA-GMN-HKNJANUM-PRTKBN-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-SYUKA-KBNLST   OCCURS  2.
                       09  SPA-GMN-SYUKA-KBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SYUKA-KBNMEIL
                                              PIC X(20).
                   07  SPA-GMN-SYUKA-KBN-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-SYUKA-NYUINLST  OCCURS  5.
                       09  SPA-GMN-SYUKA-NYUINL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SYUKA-NYUINMEIL
                                              PIC X(20).
                   07  SPA-GMN-SYUKA-NYUIN-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-SYUKA-GAIRAILST    OCCURS  5.
                       09  SPA-GMN-SYUKA-GAIRAIL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SYUKA-GAIRAIMEIL
                                              PIC X(20).
                   07  SPA-GMN-SYUKA-GAIRAI-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-SYUKA-SELECTLST    OCCURS  5.
                       09  SPA-GMN-SYUKA-SELECTL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SYUKA-SELECTMEIL
                                              PIC X(20).
                   07  SPA-GMN-SYUKA-SELECT-MAX
                                              PIC 9(02).   
      * 
                   07  SPA-GMN-SYUKA-MODELST  OCCURS  2.
                       09  SPA-GMN-SYUKA-MODEL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SYUKA-MODEMEIL
                                              PIC X(20).
                   07  SPA-GMN-SYUKA-MODE-MAX PIC 9(02).   
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-STYUKYMD       PIC 9(08).
                   07  SPA-NAI-EDYUKYMD       PIC 9(08).
      *
                   07  SPA-NAI-2008-KBNCD.
                       09  SPA-NAI-2008-KBNCD-9
                                              PIC 9(08).
      *
               05  SPA-1001-PREFNUM           PIC 9(02). 
      *
           COPY    "ENUM-VALUE".
      *
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
      *
           03  FLG-ROW             PIC 9(01).
           03  FLG-UPDFLG          PIC 9(01).
      *
      *    カウント領域
      *
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
      *
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
      *
       01  WRK-AREA.
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-WIDMSG          PIC X(70). 
           03  WRK-YMD             PIC X(09). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
      *
           03  WRK-MCP-WIDGET      PIC X(64).
      *
           03  WRK-MCP-TABLE       PIC X(64).
           03  WRK-MCP-PATHNAME    PIC X(64).
      *
           03  WRK-KBNCD.
               05  WRK-KBNCD-9     PIC 9(08).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *         
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *
      *    医療機関情報
           COPY    "CPSK1001.INC".
      *
      *    レセプト印刷情報
           COPY  "CPSK2005.INC".
      *
      *    レセプト印刷情報（編綴順）
           COPY  "CPSK2008.INC".
      *
      *    レセプト印刷情報（主科設定）
           COPY  "CPSK2009.INC".
      *
      *    保険者番号
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
      *
           COPY  "CPORCSDAY.INC".
      *
           COPY  "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "W01.INC".
           COPY    "W02.INC".
           COPY    "W03.INC".
           COPY    "W04.INC".
           COPY    "W05.INC".
           COPY    "W06.INC".
           COPY    "W07.INC". 
           COPY    "W08.INC". 
           COPY    "W09.INC".
           COPY    "W10.INC".
           COPY    "W11.INC".
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W16.INC".
           COPY    "W17.INC".
           COPY    "W18.INC".
           COPY    "W19.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W28.INC".
           COPY    "W29.INC".
           COPY    "W30.INC".
           COPY    "W60.INC".
           COPY    "W61.INC".
           COPY    "W98.INC".
           COPY    "W97.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
           COPY    "WID2.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W12
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"          ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-W12         TO  SPA-FREE
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK 
           MOVE    SPA-AREA        TO  SPA-COMMON
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "WERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               PERFORM 510-GSRAUTH-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      * 
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W12"                TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                    TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
               WHEN    "WID1"
                   PERFORM 330-WID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF      SPA-WID1-FLG    =   "OK"
               PERFORM 490-KOUSHIN-SEC
           END-IF
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD      
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE   SPA-W12-AREA
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-HSTYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-HEDYUKYMD
      *     
           MOVE    "0"                 TO  SPA-GMN-BYOMEIHENKBNL    (1)
           MOVE    "連結表示"          TO  SPA-GMN-BYOMEIHENKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-BYOMEIHENKBNL    (2)
           MOVE    "単独表示"          TO  SPA-GMN-BYOMEIHENKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-BYOMEIHENKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-BYOMEIHENKBN1L   (1)
           MOVE    "受診科のみ表示"    TO  SPA-GMN-BYOMEIHENKBN1MEIL(1)
           MOVE    "1"                 TO  SPA-GMN-BYOMEIHENKBN1L   (2)
           MOVE    "全ての診療科分を表示"
                                       TO  SPA-GMN-BYOMEIHENKBN1MEIL(2)
           MOVE    2                   TO  SPA-GMN-BYOMEIHENKBN1-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-SYUBYOHENFLGL   (1)
           MOVE    "主病名の編集を行わない"
                                       TO  SPA-GMN-SYUBYOHENFLGMEIL(1)
           MOVE    "1"                 TO  SPA-GMN-SYUBYOHENFLGL   (2)
           MOVE    "主病名の編集を行う（区切り有）"
                                       TO  SPA-GMN-SYUBYOHENFLGMEIL(2)
           MOVE    "2"                 TO  SPA-GMN-SYUBYOHENFLGL   (3)
           MOVE    "主病名の編集を行う（区切り無）"
                                       TO  SPA-GMN-SYUBYOHENFLGMEIL(3)
           MOVE    "3"                 TO  SPA-GMN-SYUBYOHENFLGL   (4)
           MOVE    "主病名の編集を行う（区切り有・主単）"
                                       TO  SPA-GMN-SYUBYOHENFLGMEIL(4)
           MOVE    4                   TO  SPA-GMN-SYUBYOHENFLG-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-TENKIHENKBNL     (1)
           MOVE    "転帰日を表示しない"
                                       TO  SPA-GMN-TENKIHENKBNMEIL  (1)
           MOVE    "1"                 TO  SPA-GMN-TENKIHENKBNL     (2)
           MOVE    "転帰日を表示する"  TO  SPA-GMN-TENKIHENKBNMEIL  (2)
           MOVE    2                   TO  SPA-GMN-TENKIHENKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-KKHRECEKBNL      (1)
           MOVE    "出力なし"          TO  SPA-GMN-KKHRECEKBNMEIL   (1)
           MOVE    "1"                 TO  SPA-GMN-KKHRECEKBNL      (2)
           MOVE    "入院外のみ"        TO  SPA-GMN-KKHRECEKBNMEIL   (2)
           MOVE    "2"                 TO  SPA-GMN-KKHRECEKBNL      (3)
           MOVE    "入院のみ"          TO  SPA-GMN-KKHRECEKBNMEIL   (3)
           MOVE    "3"                 TO  SPA-GMN-KKHRECEKBNL      (4)
           MOVE    "入院・入院外"
                                       TO  SPA-GMN-KKHRECEKBNMEIL   (4)
           MOVE    4                   TO  SPA-GMN-KKHRECEKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-SYARECEKBNL      (1)
           MOVE    "出力なし"          TO  SPA-GMN-SYARECEKBNMEIL   (1)
           MOVE    "1"                 TO  SPA-GMN-SYARECEKBNL      (2)
           MOVE    "入院外のみ"        TO  SPA-GMN-SYARECEKBNMEIL   (2)
           MOVE    "2"                 TO  SPA-GMN-SYARECEKBNL      (3)
           MOVE    "入院のみ"          TO  SPA-GMN-SYARECEKBNMEIL   (3)
           MOVE    "3"                 TO  SPA-GMN-SYARECEKBNL      (4)
           MOVE    "入院・入院外"      TO  SPA-GMN-SYARECEKBNMEIL   (4)
           MOVE    4                   TO  SPA-GMN-SYARECEKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-KKHOCRKBNL    (1)
           MOVE    "ＯＣＲなし"        TO  SPA-GMN-KKHOCRKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-KKHOCRKBNL    (2)
           MOVE    "ＯＣＲ（入院外のみ）"
                                       TO  SPA-GMN-KKHOCRKBNMEIL (2)
           MOVE    "2"                 TO  SPA-GMN-KKHOCRKBNL    (3)
           MOVE    "ＯＣＲ（入院のみ）"
                                       TO  SPA-GMN-KKHOCRKBNMEIL (3)
           MOVE    "3"                 TO  SPA-GMN-KKHOCRKBNL    (4)
           MOVE    "ＯＣＲ（入院・入院外）"
                                       TO  SPA-GMN-KKHOCRKBNMEIL (4)
           MOVE    4                   TO  SPA-GMN-KKHOCRKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-SYAOCRKBNL    (1)
           MOVE    "ＯＣＲ（入院外のみ）"
                                       TO  SPA-GMN-SYAOCRKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-SYAOCRKBNL    (2)
           MOVE    "ＯＣＲなし"        TO  SPA-GMN-SYAOCRKBNMEIL (2)
           MOVE    "2"                 TO  SPA-GMN-SYAOCRKBNL    (3)
           MOVE    "ＯＣＲ（入院・入院外）"
                                       TO  SPA-GMN-SYAOCRKBNMEIL (3)
           MOVE    3                   TO  SPA-GMN-SYAOCRKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-KKHPRTKBNL    (1)
           MOVE    "給付割合なしの様式"
                                       TO  SPA-GMN-KKHPRTKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-KKHPRTKBNL    (2)
           MOVE    "給付割合ありの様式"
                                       TO  SPA-GMN-KKHPRTKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-KKHPRTKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-RENNUMHENKBNL    (1)
           MOVE    "通し番号を表示しない"
                                       TO  SPA-GMN-RENNUMHENKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-RENNUMHENKBNL    (2)
           MOVE    "通し番号を表示する"
                                       TO  SPA-GMN-RENNUMHENKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-RENNUMHENKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-NEXTPRTKBNL    (1)
           MOVE    "横タイプ"          TO  SPA-GMN-NEXTPRTKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-NEXTPRTKBNL    (2)
           MOVE    "縦タイプ"          TO  SPA-GMN-NEXTPRTKBNMEIL (2)
           MOVE    "2"                 TO  SPA-GMN-NEXTPRTKBNL    (3)
           MOVE    "縦タイプ（長）"    TO  SPA-GMN-NEXTPRTKBNMEIL (3)
           MOVE    3                   TO  SPA-GMN-NEXTPRTKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-NEXTPRTKBN1L    (1)
           MOVE    "指定なし"          TO  SPA-GMN-NEXTPRTKBN1MEIL (1)
           MOVE    "1"                 TO  SPA-GMN-NEXTPRTKBN1L    (2)
           MOVE    "横タイプ"          TO  SPA-GMN-NEXTPRTKBN1MEIL (2)
           MOVE    "2"                 TO  SPA-GMN-NEXTPRTKBN1L    (3)
           MOVE    "縦タイプ"          TO  SPA-GMN-NEXTPRTKBN1MEIL (3)
           MOVE    "3"                 TO  SPA-GMN-NEXTPRTKBN1L    (4)
           MOVE    "縦タイプ（長）"    TO  SPA-GMN-NEXTPRTKBN1MEIL (4)
           MOVE    4                   TO  SPA-GMN-NEXTPRTKBN1-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-RJNGNBKKBNL    (1)
           MOVE    "社保、国保とも印刷不可"
                                       TO  SPA-GMN-RJNGNBKKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-RJNGNBKKBNL    (2)
           MOVE    "社保の併用に限り印刷" 
                                       TO  SPA-GMN-RJNGNBKKBNMEIL (2)
           MOVE    "2"                 TO  SPA-GMN-RJNGNBKKBNL    (3)
           MOVE    "国保の併用に限り印刷"
                                       TO  SPA-GMN-RJNGNBKKBNMEIL (3)
           MOVE    "3"                 TO  SPA-GMN-RJNGNBKKBNL    (4)
           MOVE    "社保、国保とも印刷"
                                       TO  SPA-GMN-RJNGNBKKBNMEIL (4)
           MOVE    4                   TO  SPA-GMN-RJNGNBKKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-RECECOMKBNL    (1)
           MOVE    "レセ電データに記録する"
                                       TO  SPA-GMN-RECECOMKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-RECECOMKBNL    (2)
           MOVE    "レセ電データに記録しない"
                                       TO  SPA-GMN-RECECOMKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-RECECOMKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-SRYKAHENKBNL    (1)
           MOVE    "診療科を表示する"  TO  SPA-GMN-SRYKAHENKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-SRYKAHENKBNL    (2)
           MOVE    "診療科を表示しない"
                                       TO  SPA-GMN-SRYKAHENKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-SRYKAHENKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-JIHITEKKSIKBNL    (1)
           MOVE    "なし"              TO  SPA-GMN-JIHITEKKSIKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-JIHITEKKSIKBNL    (2)
           MOVE    "あり"              TO  SPA-GMN-JIHITEKKSIKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-JIHITEKKSIKBN-MAX 
      *
           MOVE    "01"                TO  SPA-GMN-PRTJYUN1L    (1)
           MOVE    "保険者番号・カナ氏名順"
                                       TO  SPA-GMN-PRTJYUN1MEIL (1)
           MOVE    "02"                TO  SPA-GMN-PRTJYUN1L    (2)
           MOVE    "保険者番号・患者番号順"
                                       TO  SPA-GMN-PRTJYUN1MEIL (2)
           MOVE    "03"                TO  SPA-GMN-PRTJYUN1L    (3)
           MOVE    "カナ氏名順"        TO  SPA-GMN-PRTJYUN1MEIL (3)
           MOVE    "04"                TO  SPA-GMN-PRTJYUN1L    (4)
           MOVE    "患者番号順"        TO  SPA-GMN-PRTJYUN1MEIL (4)
           MOVE    4                   TO  SPA-GMN-PRTJYUN1-MAX 
      *
           MOVE    "01"                TO  SPA-GMN-PRTJYUN3L    (1)
           MOVE    "保険者番号・カナ氏名順"
                                       TO  SPA-GMN-PRTJYUN3MEIL (1)
           MOVE    "02"                TO  SPA-GMN-PRTJYUN3L    (2)
           MOVE    "保険者番号・患者番号順"
                                       TO  SPA-GMN-PRTJYUN3MEIL (2)
           MOVE    "03"                TO  SPA-GMN-PRTJYUN3L    (3)
           MOVE    "カナ氏名順"        TO  SPA-GMN-PRTJYUN3MEIL (3)
           MOVE    "04"                TO  SPA-GMN-PRTJYUN3L    (4)
           MOVE    "患者番号順"        TO  SPA-GMN-PRTJYUN3MEIL (4)
           MOVE    "06"                TO  SPA-GMN-PRTJYUN3L    (5)
           MOVE    "編綴順"            TO  SPA-GMN-PRTJYUN3MEIL (5)
           MOVE    5                   TO  SPA-GMN-PRTJYUN3-MAX 
      *
           MOVE    "01"                TO  SPA-GMN-PRTJYUN2L    (1)
           MOVE    "保険者番号・カナ氏名順"
                                       TO  SPA-GMN-PRTJYUN2MEIL (1)
           MOVE    "02"                TO  SPA-GMN-PRTJYUN2L    (2)
           MOVE    "保険者番号・患者番号順"
                                       TO  SPA-GMN-PRTJYUN2MEIL (2)
           MOVE    "03"                TO  SPA-GMN-PRTJYUN2L    (3)
           MOVE    "カナ氏名順"        TO  SPA-GMN-PRTJYUN2MEIL (3)
           MOVE    "04"                TO  SPA-GMN-PRTJYUN2L    (4)
           MOVE    "患者番号順"        TO  SPA-GMN-PRTJYUN2MEIL (4)
           MOVE    "05"                TO  SPA-GMN-PRTJYUN2L    (5)
           MOVE    "入力順"            TO  SPA-GMN-PRTJYUN2MEIL (5)
           MOVE    5                   TO  SPA-GMN-PRTJYUN2-MAX 
      *
           MOVE    "0"                 TO  SPA-GMN-AUTODSPKBNL    (1)
           MOVE    "自動遷移しない"    TO  SPA-GMN-AUTODSPKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-AUTODSPKBNL    (2)
           MOVE    "自動遷移する"      TO  SPA-GMN-AUTODSPKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-AUTODSPKBN-MAX 
      *
           MOVE    "0"                 TO  SPA-GMN-MOJI-KISAIKBNL    (1)
           MOVE    "レセプト上部中央"  TO  SPA-GMN-MOJI-KISAIKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-MOJI-KISAIKBNL    (2)
           MOVE    "レセプト上部右"    TO  SPA-GMN-MOJI-KISAIKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-MOJI-KISAIKBN-MAX 
      *
           MOVE    "0"             TO  SPA-GMN-KYURATE-KISAIKBNL    (1)
           MOVE    "１０割"        TO  SPA-GMN-KYURATE-KISAIKBNMEIL (1)
           MOVE    "1"             TO  SPA-GMN-KYURATE-KISAIKBNL    (2)
           MOVE    "０割"          TO  SPA-GMN-KYURATE-KISAIKBNMEIL (2)
           MOVE    "2"             TO  SPA-GMN-KYURATE-KISAIKBNL    (3)
           MOVE    "記載なし"      TO  SPA-GMN-KYURATE-KISAIKBNMEIL (3)
           MOVE    "3"             TO  SPA-GMN-KYURATE-KISAIKBNL    (4)
           MOVE    "通常の給付割合を記載"
                                   TO  SPA-GMN-KYURATE-KISAIKBNMEIL (4)
           MOVE    4               TO  SPA-GMN-KYURATE-KISAIKBN-MAX 
      *
           MOVE    "0"             TO
                                   SPA-GMN-RECESYUBETU-KISAIKBNL    (1)
           MOVE    "通常のレセプト種別を記載"
                                   TO
                                   SPA-GMN-RECESYUBETU-KISAIKBNMEIL (1)
           MOVE    "1"             TO
                                   SPA-GMN-RECESYUBETU-KISAIKBNL    (2)
           MOVE    "記載なし"      TO
                                   SPA-GMN-RECESYUBETU-KISAIKBNMEIL (2)
           MOVE    2               TO  SPA-GMN-RECESYUBETU-KISAIKBN-MAX 
      *
           MOVE    "1"             TO  SPA-GMN-PREFKBN-PRTJYUNL    (1)
           MOVE    "県内・県外"    TO  SPA-GMN-PREFKBN-PRTJYUNMEIL (1)
           MOVE    "2"             TO  SPA-GMN-PREFKBN-PRTJYUNL    (2)
           MOVE    "県外・県内"    TO  SPA-GMN-PREFKBN-PRTJYUNMEIL (2)
           MOVE    2               TO  SPA-GMN-PREFKBN-PRTJYUN-MAX 
      *
           MOVE    "1"             TO  SPA-GMN-HKNJANUM-PRTJYUNL    (1)
           MOVE    "市町村国保・国保組合・県内扱いの県外国保組合"
                                   TO  SPA-GMN-HKNJANUM-PRTJYUNMEIL (1)
           MOVE    "2"             TO  SPA-GMN-HKNJANUM-PRTJYUNL    (2)
           MOVE    "市町村国保・県内扱いの県外国保組合・国保組合"
                                   TO  SPA-GMN-HKNJANUM-PRTJYUNMEIL (2)
           MOVE    "3"             TO  SPA-GMN-HKNJANUM-PRTJYUNL    (3)
           MOVE    "国保組合・市町村国保・県内扱いの県外国保組合"
                                   TO  SPA-GMN-HKNJANUM-PRTJYUNMEIL (3)
           MOVE    "4"             TO  SPA-GMN-HKNJANUM-PRTJYUNL    (4)
           MOVE    "国保組合・県内扱いの県外国保組合・市町村国保"
                                   TO  SPA-GMN-HKNJANUM-PRTJYUNMEIL (4)
           MOVE    "5"             TO  SPA-GMN-HKNJANUM-PRTJYUNL    (5)
           MOVE    "県内扱いの県外国保組合・市町村国保・国保組合"
                                   TO  SPA-GMN-HKNJANUM-PRTJYUNMEIL (5)
           MOVE    "6"             TO  SPA-GMN-HKNJANUM-PRTJYUNL    (6)
           MOVE
               "県内扱いの県外国保組合・国保組合・市町村国保"
                                   TO  SPA-GMN-HKNJANUM-PRTJYUNMEIL (6)
           MOVE    6               TO  SPA-GMN-HKNJANUM-PRTJYUN-MAX 
      *
           MOVE    "1"             TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNL    (1)
           MOVE    "国保一般・老人保健・退職国保"
                                   TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNMEIL (1)
           MOVE    "2"             TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNL    (2)
           MOVE    "国保一般・退職国保・老人保健"      TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNMEIL (2)
           MOVE    "3"             TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNL    (3)
           MOVE    "老人保健・国保一般・退職国保"
                                   TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNMEIL (3)
           MOVE    "4"             TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNL    (4)
           MOVE    "老人保健・退職国保・国保一般"      TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNMEIL (4)
           MOVE    "5"             TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNL    (5)
           MOVE    "退職国保・国保一般・老人保健"
                                   TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNMEIL (5)
           MOVE    "6"             TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNL    (6)
           MOVE    "退職国保・老人保健・国保一般"      TO
                                   SPA-GMN-RECESYUBETU-PRTJYUNMEIL (6)
           MOVE    6               TO  SPA-GMN-RECESYUBETU-PRTJYUN-MAX 
      *
           MOVE    "1"             TO  SPA-GMN-ZAITAKUL    (1)
           MOVE    "県内・県外の先頭に印刷" 
                                   TO  SPA-GMN-ZAITAKUMEIL (1)
           MOVE    "2"             TO  SPA-GMN-ZAITAKUL    (2)
           MOVE    "保険者の先頭に印刷"
                                   TO  SPA-GMN-ZAITAKUMEIL (2)
           MOVE    2               TO  SPA-GMN-ZAITAKU-MAX 
      *
           MOVE    "1"             TO  SPA-GMN-CHOUKIL    (1)
           MOVE    "県内・県外の先頭に印刷" 
                                   TO  SPA-GMN-CHOUKIMEIL (1)
           MOVE    "2"             TO  SPA-GMN-CHOUKIL    (2)
           MOVE    "保険者の先頭に印刷"
                                   TO  SPA-GMN-CHOUKIMEIL (2)
           MOVE    2               TO  SPA-GMN-CHOUKI-MAX 
      *
           MOVE    "1"             TO  SPA-GMN-HKNJANUM-PRTKBNL    (1)
           MOVE    "市町村国保の先頭に印刷" 
                                   TO  SPA-GMN-HKNJANUM-PRTKBNMEIL (1)
           MOVE    "2"             TO  SPA-GMN-HKNJANUM-PRTKBNL    (2)
           MOVE    "市町村国保の最後に印刷"
                                   TO  SPA-GMN-HKNJANUM-PRTKBNMEIL (2)
           MOVE    2               TO  SPA-GMN-HKNJANUM-PRTKBN-MAX
      *
           MOVE    "0"             TO  SPA-GMN-SYUKA-KBNL      (1)
           MOVE    "しない"        TO  SPA-GMN-SYUKA-KBNMEIL   (1)
           MOVE    "1"             TO  SPA-GMN-SYUKA-KBNL      (2)
           MOVE    "する"          TO  SPA-GMN-SYUKA-KBNMEIL   (2)
           MOVE    2               TO  SPA-GMN-SYUKA-KBN-MAX 
      *
           MOVE    "1"             TO  SPA-GMN-SYUKA-NYUINL    (1)
           MOVE    "当月の入院日数" 
                                   TO  SPA-GMN-SYUKA-NYUINMEIL (1)
           MOVE    "2"             TO  SPA-GMN-SYUKA-NYUINL    (2)
           MOVE    "当月の請求点数"
                                   TO  SPA-GMN-SYUKA-NYUINMEIL (2)
           MOVE    "3"             TO  SPA-GMN-SYUKA-NYUINL    (3)
           MOVE    "当月の最終入院科"
                                   TO  SPA-GMN-SYUKA-NYUINMEIL (3)
           MOVE    3               TO  SPA-GMN-SYUKA-NYUIN-MAX 
      *
           MOVE    "1"             TO  SPA-GMN-SYUKA-GAIRAIL   (1)
           MOVE    "当月の受診回数" 
                                   TO  SPA-GMN-SYUKA-GAIRAIMEIL(1)
           MOVE    "2"             TO  SPA-GMN-SYUKA-GAIRAIL   (2)
           MOVE    "当月の請求点数"
                                   TO  SPA-GMN-SYUKA-GAIRAIMEIL(2)
           MOVE    2               TO  SPA-GMN-SYUKA-GAIRAI-MAX 
      *
           MOVE    "0"             TO  SPA-GMN-SYUKA-SELECTL     (1)
           MOVE    "主科を設定しない"
                                   TO  SPA-GMN-SYUKA-SELECTMEIL  (1)
           MOVE    "1"             TO  SPA-GMN-SYUKA-SELECTL     (2)
           MOVE    "先頭の科で設定"
                                   TO  SPA-GMN-SYUKA-SELECTMEIL  (2)
           MOVE    "2"             TO  SPA-GMN-SYUKA-SELECTL     (3)
           MOVE    "最後の科で設定"
                                   TO  SPA-GMN-SYUKA-SELECTMEIL  (3)
           MOVE    3               TO  SPA-GMN-SYUKA-SELECT-MAX 
      *
           MOVE    "1"             TO  SPA-GMN-SYUKA-MODEL     (1)
           MOVE    "オンライン"    TO  SPA-GMN-SYUKA-MODEMEIL  (1)
           MOVE    "2"             TO  SPA-GMN-SYUKA-MODEL     (2)
           MOVE    "一括バッチ"    TO  SPA-GMN-SYUKA-MODEMEIL  (2)
           MOVE    2               TO  SPA-GMN-SYUKA-MODE-MAX 
      *
      *       医療機関情報
           MOVE    SPACE               TO  SYS-1001-REC
           INITIALIZE                      SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SPA-W01-SEL-STYUKYMD
                                       TO  SYS-1001-STYUKYMD
                                           SYS-1001-EDYUKYMD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  WRK-MCP-TABLE
           MOVE    "key10"             TO  WRK-MCP-PATHNAME
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-1001-REC
               MOVE    SYS-1001-PREFNUM        TO  SPA-1001-PREFNUM
           END-IF 
      *
      *    レセプト・総括編集情報
           MOVE    SPACE               TO  SYS-2005-REC
           INITIALIZE                      SYS-2005-REC
           MOVE    "2005"              TO  SYS-2005-KANRICD
           MOVE    "*"                 TO  SYS-2005-KBNCD
           MOVE    SPA-W01-SEL-STYUKYMD
                                       TO  SYS-2005-STYUKYMD
           MOVE    SPA-W01-SEL-EDYUKYMD
                                       TO  SYS-2005-EDYUKYMD
           MOVE    SYS-2005-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"     TO  WRK-MCP-TABLE
           MOVE    "key10"             TO  WRK-MCP-PATHNAME
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-2005-REC
      *
               IF      SYS-2005-PRTJYUNKBN3    =   SPACE
                   MOVE    SYS-2005-PRTJYUNKBN1    TO
                                                   SYS-2005-PRTJYUNKBN3
               END-IF
      *         
               MOVE    SYS-2005-BYOMEIHENKBN   TO  SPA-GMN-BYOMEIHENKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-BYOMEIHENKBN-MAX
                   IF      SPA-GMN-BYOMEIHENKBN 
                                   =   SPA-GMN-BYOMEIHENKBNL (IDY)
                       MOVE    SPA-GMN-BYOMEIHENKBNLST (IDY)
                                           TO  SPA-GMN-BYOMEIHENKBN-G
                       MOVE    SPA-GMN-BYOMEIHENKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-BYOMEIHENKBN1  TO  SPA-GMN-BYOMEIHENKBN1
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-BYOMEIHENKBN1-MAX
                   IF      SPA-GMN-BYOMEIHENKBN1 
                                   =   SPA-GMN-BYOMEIHENKBN1L (IDY)
                       MOVE    SPA-GMN-BYOMEIHENKBN1LST (IDY)
                                           TO  SPA-GMN-BYOMEIHENKBN1-G
                       MOVE    SPA-GMN-BYOMEIHENKBN1-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-SYUBYOHENFLG  TO  SPA-GMN-SYUBYOHENFLG
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYUBYOHENFLG-MAX
                   IF      SPA-GMN-SYUBYOHENFLG 
                                   =   SPA-GMN-SYUBYOHENFLGL (IDY)
                       MOVE    SPA-GMN-SYUBYOHENFLGLST (IDY)
                                           TO  SPA-GMN-SYUBYOHENFLG-G
                       MOVE    SPA-GMN-SYUBYOHENFLG-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-TENKIHENKBN    TO  SPA-GMN-TENKIHENKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-TENKIHENKBN-MAX
                   IF      SPA-GMN-TENKIHENKBN 
                                   =   SPA-GMN-TENKIHENKBNL (IDY)
                       MOVE    SPA-GMN-TENKIHENKBNLST (IDY)
                                           TO  SPA-GMN-TENKIHENKBN-G
                       MOVE    SPA-GMN-TENKIHENKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *
               MOVE    SYS-2005-KKHRECEKBN TO  SPA-GMN-KKHRECEKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KKHRECEKBN-MAX
                   IF      SPA-GMN-KKHRECEKBN 
                                   =   SPA-GMN-KKHRECEKBNL (IDY)
                       MOVE    SPA-GMN-KKHRECEKBNLST (IDY)
                                           TO  SPA-GMN-KKHRECEKBN-G
                       MOVE    SPA-GMN-KKHRECEKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-SYARECEKBN TO  SPA-GMN-SYARECEKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYARECEKBN-MAX
                   IF      SPA-GMN-SYARECEKBN 
                                   =   SPA-GMN-SYARECEKBNL (IDY)
                       MOVE    SPA-GMN-SYARECEKBNLST (IDY)
                                           TO  SPA-GMN-SYARECEKBN-G
                       MOVE    SPA-GMN-SYARECEKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *
               MOVE    SYS-2005-RECEDENOUT TO  SPA-GMN-RECEDENOUT
      *         
               MOVE    SYS-2005-KKHOCRKBN  TO  SPA-GMN-KKHOCRKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KKHOCRKBN-MAX
                   IF      SPA-GMN-KKHOCRKBN 
                                   =   SPA-GMN-KKHOCRKBNL (IDY)
                       MOVE    SPA-GMN-KKHOCRKBNLST (IDY)
                                           TO  SPA-GMN-KKHOCRKBN-G
                       MOVE    SPA-GMN-KKHOCRKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-SYAOCRKBN  TO  SPA-GMN-SYAOCRKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYAOCRKBN-MAX
                   IF      SPA-GMN-SYAOCRKBN 
                                   =   SPA-GMN-SYAOCRKBNL (IDY)
                       MOVE    SPA-GMN-SYAOCRKBNLST (IDY)
                                           TO  SPA-GMN-SYAOCRKBN-G
                       MOVE    SPA-GMN-SYAOCRKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *
               MOVE    SYS-2005-PREFPRGID (1)
                                           TO  SPA-GMN-PREFPRGID
               MOVE    SYS-2005-PREFPRGID (2)
                                           TO  SPA-GMN-PREFPRGID1
      *         
               MOVE    SYS-2005-KKHPRTKBN  TO  SPA-GMN-KKHPRTKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KKHPRTKBN-MAX
                   IF      SPA-GMN-KKHPRTKBN 
                                   =   SPA-GMN-KKHPRTKBNL (IDY)
                       MOVE    SPA-GMN-KKHPRTKBNLST (IDY)
                                           TO  SPA-GMN-KKHPRTKBN-G
                       MOVE    SPA-GMN-KKHPRTKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *
               MOVE    SYS-2005-SYAPRTNM   TO  SPA-GMN-SYAPRTNM         
               MOVE    SYS-2005-SYAPRTNM-NEXT
                                           TO  SPA-GMN-SYAPRTNM-NEXT
      *
               MOVE    SYS-2005-KKHPRTNM   TO  SPA-GMN-KKHPRTNM         
               MOVE    SYS-2005-KKHPRTNM-NEXT
                                           TO  SPA-GMN-KKHPRTNM-NEXT
               MOVE    SYS-2005-SYAPRTNM-N TO  SPA-GMN-SYAPRTNM-N
               MOVE    SYS-2005-SYAPRTNM-NEXT-N
                                           TO  SPA-GMN-SYAPRTNM-NEXT-N
      *
               MOVE    SYS-2005-KKHPRTNM-N TO  SPA-GMN-KKHPRTNM-N
               MOVE    SYS-2005-KKHPRTNM-NEXT-N
                                           TO  SPA-GMN-KKHPRTNM-NEXT-N
      *         
               MOVE    SYS-2005-RENNUMHENKBN 
                                           TO  SPA-GMN-RENNUMHENKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-RENNUMHENKBN-MAX
                   IF      SPA-GMN-RENNUMHENKBN 
                                   =   SPA-GMN-RENNUMHENKBNL (IDY)
                       MOVE    SPA-GMN-RENNUMHENKBNLST (IDY)
                                           TO  SPA-GMN-RENNUMHENKBN-G
                       MOVE    SPA-GMN-RENNUMHENKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-NEXTPRTKBN TO  SPA-GMN-NEXTPRTKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-NEXTPRTKBN-MAX
                   IF      SPA-GMN-NEXTPRTKBN 
                                   =   SPA-GMN-NEXTPRTKBNL (IDY)
                       MOVE    SPA-GMN-NEXTPRTKBNLST (IDY)
                                           TO  SPA-GMN-NEXTPRTKBN-G
                       MOVE    SPA-GMN-NEXTPRTKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-NEXTPRTKBN-G 
                                           TO  SPA-GMN-NEXTPRTKBN1
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-NEXTPRTKBN1-MAX
                   IF      SPA-GMN-NEXTPRTKBN1 
                                   =   SPA-GMN-NEXTPRTKBN1L (IDY)
                       MOVE    SPA-GMN-NEXTPRTKBN1LST (IDY)
                                           TO  SPA-GMN-NEXTPRTKBN1-G
                       MOVE    SPA-GMN-NEXTPRTKBN1-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *
               MOVE    SYS-2005-RJNGNBKKBN TO  SPA-GMN-RJNGNBKKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-RJNGNBKKBN-MAX
                   IF      SPA-GMN-RJNGNBKKBN 
                                   =   SPA-GMN-RJNGNBKKBNL (IDY)
                       MOVE    SPA-GMN-RJNGNBKKBNLST (IDY)
                                           TO  SPA-GMN-RJNGNBKKBN-G
                       MOVE    SPA-GMN-RJNGNBKKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-JIHITEKKSIKBN TO  SPA-GMN-JIHITEKKSIKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-JIHITEKKSIKBN-MAX
                   IF      SPA-GMN-JIHITEKKSIKBN 
                                   =   SPA-GMN-JIHITEKKSIKBNL (IDY)
                       MOVE    SPA-GMN-JIHITEKKSIKBNLST (IDY)
                                           TO  SPA-GMN-JIHITEKKSIKBN-G
                       MOVE    SPA-GMN-JIHITEKKSIKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-RECECOMKBN TO  SPA-GMN-RECECOMKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-RECECOMKBN-MAX
                   IF      SPA-GMN-RECECOMKBN 
                                   =   SPA-GMN-RECECOMKBNL (IDY)
                       MOVE    SPA-GMN-RECECOMKBNLST (IDY)
                                           TO  SPA-GMN-RECECOMKBN-G
                       MOVE    SPA-GMN-RECECOMKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-SRYKAHENKBN TO  SPA-GMN-SRYKAHENKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SRYKAHENKBN-MAX
                   IF      SPA-GMN-SRYKAHENKBN 
                                   =   SPA-GMN-SRYKAHENKBNL (IDY)
                       MOVE    SPA-GMN-SRYKAHENKBNLST (IDY)
                                           TO  SPA-GMN-SRYKAHENKBN-G
                       MOVE    SPA-GMN-SRYKAHENKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-AUTODSPKBN TO  SPA-GMN-AUTODSPKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-AUTODSPKBN-MAX
                   IF      SPA-GMN-AUTODSPKBN
                                   =   SPA-GMN-AUTODSPKBNL (IDY)
                       MOVE    SPA-GMN-AUTODSPKBNLST (IDY)
                                           TO  SPA-GMN-AUTODSPKBN-G
                       MOVE    SPA-GMN-AUTODSPKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-PRTJYUNKBN1   TO  SPA-GMN-PRTJYUN1
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-PRTJYUN1-MAX
                   IF      SPA-GMN-PRTJYUN1 
                                   =   SPA-GMN-PRTJYUN1L (IDY)
                       MOVE    SPA-GMN-PRTJYUN1LST (IDY)
                                           TO  SPA-GMN-PRTJYUN1-G
                       MOVE    SPA-GMN-PRTJYUN1-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-PRTJYUNKBN2   TO  SPA-GMN-PRTJYUN2
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-PRTJYUN2-MAX
                   IF      SPA-GMN-PRTJYUN2
                                   =   SPA-GMN-PRTJYUN2L (IDY)
                       MOVE    SPA-GMN-PRTJYUN2LST (IDY)
                                           TO  SPA-GMN-PRTJYUN2-G
                       MOVE    SPA-GMN-PRTJYUN2-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-PRTJYUNKBN3    TO  SPA-GMN-PRTJYUN3
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-PRTJYUN3-MAX
                   IF      SPA-GMN-PRTJYUN3 
                                   =   SPA-GMN-PRTJYUN3L (IDY)
                       MOVE    SPA-GMN-PRTJYUN3LST (IDY)
                                           TO  SPA-GMN-PRTJYUN3-G
                       MOVE    SPA-GMN-PRTJYUN3-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-MOJI-KISAIKBN  TO  SPA-GMN-MOJI-KISAIKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-MOJI-KISAIKBN-MAX
                   IF      SPA-GMN-MOJI-KISAIKBN
                                   =   SPA-GMN-MOJI-KISAIKBNL (IDY)
                       MOVE    SPA-GMN-MOJI-KISAIKBNLST (IDY)
                                           TO  SPA-GMN-MOJI-KISAIKBN-G
                       MOVE    SPA-GMN-MOJI-KISAIKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-KYURATE-KISAIKBN
                                           TO  SPA-GMN-KYURATE-KISAIKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KYURATE-KISAIKBN-MAX
                   IF      SPA-GMN-KYURATE-KISAIKBN
                                   =   SPA-GMN-KYURATE-KISAIKBNL (IDY)
                       MOVE    SPA-GMN-KYURATE-KISAIKBNLST (IDY)
                                           TO
                                           SPA-GMN-KYURATE-KISAIKBN-G
                       MOVE    SPA-GMN-KYURATE-KISAIKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2005-RECESYUBETU-KISAIKBN
                                           TO
                                           SPA-GMN-RECESYUBETU-KISAIKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-RECESYUBETU-KISAIKBN-MAX
                   IF      SPA-GMN-RECESYUBETU-KISAIKBN
                               =   SPA-GMN-RECESYUBETU-KISAIKBNL (IDY)
                       MOVE    SPA-GMN-RECESYUBETU-KISAIKBNLST (IDY)
                                           TO
                                       SPA-GMN-RECESYUBETU-KISAIKBN-G
                       MOVE    SPA-GMN-RECESYUBETU-KISAIKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
           END-IF
      *
      *    レセプト（編綴順）情報
           MOVE    SPACE               TO  SYS-2008-REC
           INITIALIZE                      SYS-2008-REC
           MOVE    "2008"              TO  SYS-2008-KANRICD
           MOVE    SPA-W01-SEL-STYUKYMD
                                       TO  SYS-2008-STYUKYMD
           MOVE    SPA-W01-SEL-EDYUKYMD
                                       TO  SYS-2008-EDYUKYMD
           MOVE    SYS-2008-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  WRK-MCP-TABLE
           MOVE    "key13"             TO  WRK-MCP-PATHNAME
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-2008-REC
      *
               MOVE    SYS-2008-KBNCD      TO  SPA-NAI-2008-KBNCD
      *
               MOVE    SYS-2008-PREFKBN-PRTJYUN
                                           TO  SPA-GMN-PREFKBN-PRTJYUN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-PREFKBN-PRTJYUN-MAX
                   IF      SPA-GMN-PREFKBN-PRTJYUN
                                   =   SPA-GMN-PREFKBN-PRTJYUNL (IDY)
                       MOVE    SPA-GMN-PREFKBN-PRTJYUNLST (IDY)
                                           TO  SPA-GMN-PREFKBN-PRTJYUN-G
                       MOVE    SPA-GMN-PREFKBN-PRTJYUN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2008-HKNJANUM-PRTJYUN
                                           TO  SPA-GMN-HKNJANUM-PRTJYUN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-HKNJANUM-PRTJYUN-MAX
                   IF      SPA-GMN-HKNJANUM-PRTJYUN
                                   =   SPA-GMN-HKNJANUM-PRTJYUNL (IDY)
                       MOVE    SPA-GMN-HKNJANUM-PRTJYUNLST (IDY)
                                           TO
                                           SPA-GMN-HKNJANUM-PRTJYUN-G
                       MOVE    SPA-GMN-HKNJANUM-PRTJYUN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2008-RECESYUBETU-PRTJYUN
                                           TO
                                           SPA-GMN-RECESYUBETU-PRTJYUN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-RECESYUBETU-PRTJYUN-MAX
                   IF      SPA-GMN-RECESYUBETU-PRTJYUN
                               =   SPA-GMN-RECESYUBETU-PRTJYUNL (IDY)
                       MOVE    SPA-GMN-RECESYUBETU-PRTJYUNLST (IDY)
                                           TO
                                       SPA-GMN-RECESYUBETU-PRTJYUN-G
                       MOVE    SPA-GMN-RECESYUBETU-PRTJYUN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *         
               MOVE    SYS-2008-ZAITAKU    TO  SPA-GMN-ZAITAKU
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-ZAITAKU-MAX
                   IF      SPA-GMN-ZAITAKU
                                   =   SPA-GMN-ZAITAKUL (IDY)
                       MOVE    SPA-GMN-ZAITAKULST (IDY)
                                           TO  SPA-GMN-ZAITAKU-G
                       MOVE    SPA-GMN-ZAITAKU-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2008-CHOUKI     TO  SPA-GMN-CHOUKI
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-CHOUKI-MAX
                   IF      SPA-GMN-CHOUKI
                                   =   SPA-GMN-CHOUKIL (IDY)
                       MOVE    SPA-GMN-CHOUKILST (IDY)
                                           TO
                                           SPA-GMN-CHOUKI-G
                       MOVE    SPA-GMN-CHOUKI-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2008-HKNJANUM-PRTKBN
                                           TO
                                           SPA-GMN-HKNJANUM-PRTKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-HKNJANUM-PRTKBN-MAX
                   IF      SPA-GMN-HKNJANUM-PRTKBN
                               =   SPA-GMN-HKNJANUM-PRTKBNL (IDY)
                       MOVE    SPA-GMN-HKNJANUM-PRTKBNLST (IDY)
                                           TO
                                       SPA-GMN-HKNJANUM-PRTKBN-G
                       MOVE    SPA-GMN-HKNJANUM-PRTKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2008-HKNJANUM   TO  SPA-GMN-HKNJANUM
               MOVE    SPACE               TO  HKNJAINF-REC
               INITIALIZE                      HKNJAINF-REC
               MOVE    SPA-HOSPID          TO  HKNJA-HOSPID
               MOVE    SPA-GMN-HKNJANUM    TO  HKNJA-HKNJANUM
               MOVE    HKNJAINF-REC        TO  MCPDATA-REC
               PERFORM 900-HKNJAINF-READ-SEC
               MOVE    HKNJA-HKNJANAME     TO  SPA-GMN-HKNJANAME
           ELSE
               MOVE    ZERO                TO  SPA-NAI-2008-KBNCD-9  
           END-IF
      *
      *    レセプト情報（主科設定）
      *
      *    レセプト・総括編集情報
           MOVE    SPACE               TO  SYS-2009-REC
           INITIALIZE                      SYS-2009-REC
           MOVE    "2009"              TO  SYS-2009-KANRICD
           MOVE    "*"                 TO  SYS-2009-KBNCD
           MOVE    SPA-W01-SEL-STYUKYMD
                                       TO  SYS-2009-STYUKYMD
           MOVE    SPA-W01-SEL-EDYUKYMD
                                       TO  SYS-2009-EDYUKYMD
           MOVE    SYS-2009-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  WRK-MCP-TABLE
           MOVE    "key10"             TO  WRK-MCP-PATHNAME
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-2009-REC
      *
               MOVE    SYS-2009-SYUKA-KBN      TO  SPA-GMN-SYUKA-KBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYUKA-KBN-MAX
                   IF      SPA-GMN-SYUKA-KBN
                                   =   SPA-GMN-SYUKA-KBNL (IDY)
                       MOVE    SPA-GMN-SYUKA-KBNLST (IDY)
                                               TO SPA-GMN-SYUKA-KBN-G
                       MOVE    SPA-GMN-SYUKA-KBN-MAX
                                               TO  IDY
                   END-IF
               END-PERFORM
      *         
               MOVE    SYS-2009-SYUKA-NYUIN    TO  SPA-GMN-SYUKA-NYUIN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYUKA-NYUIN-MAX
                   IF      SPA-GMN-SYUKA-NYUIN
                                   =   SPA-GMN-SYUKA-NYUINL (IDY)
                       MOVE    SPA-GMN-SYUKA-NYUINLST (IDY)
                                               TO  SPA-GMN-SYUKA-NYUIN-G
                       MOVE    SPA-GMN-SYUKA-NYUIN-MAX
                                               TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2009-SYUKA-GAIRAI   TO  SPA-GMN-SYUKA-GAIRAI
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYUKA-GAIRAI-MAX
                   IF      SPA-GMN-SYUKA-GAIRAI
                                   =   SPA-GMN-SYUKA-GAIRAIL (IDY)
                       MOVE    SPA-GMN-SYUKA-GAIRAILST (IDY)
                                               TO SPA-GMN-SYUKA-GAIRAI-G
                       MOVE    SPA-GMN-SYUKA-GAIRAI-MAX
                                               TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2009-SYUKA-SELECT   TO  SPA-GMN-SYUKA-SELECT
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-SYUKA-SELECT-MAX
                   IF      SPA-GMN-SYUKA-SELECT
                                   =   SPA-GMN-SYUKA-SELECTL (IDY)
                       MOVE    SPA-GMN-SYUKA-SELECTLST (IDY)
                                               TO
                                               SPA-GMN-SYUKA-SELECT-G
                       MOVE    SPA-GMN-SYUKA-SELECT-MAX
                                               TO  IDY
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-2009-SYUKA-MODE     TO  SPA-GMN-SYUKA-MODE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-SYUKA-MODE-MAX
                   IF      SPA-GMN-SYUKA-MODE
                                   =   SPA-GMN-SYUKA-MODEL (IDY)
                       MOVE    SPA-GMN-SYUKA-MODELST (IDY)
                                               TO  SPA-GMN-SYUKA-MODE-G
                       MOVE    SPA-GMN-SYUKA-MODE-MAX
                                               TO  IDY
                   END-IF
               END-PERFORM
           END-IF    
      *
           IF     SPA-GMN-BYOMEIHENKBN-G   =   SPACE
               MOVE    SPA-GMN-BYOMEIHENKBNLST (1)
                                           TO  SPA-GMN-BYOMEIHENKBN-G
           END-IF                                              
           IF     SPA-GMN-BYOMEIHENKBN1-G  =   SPACE
               MOVE    SPA-GMN-BYOMEIHENKBN1LST (1)
                                           TO  SPA-GMN-BYOMEIHENKBN1-G
           END-IF                                              
           IF     SPA-GMN-SYUBYOHENFLG-G  =   SPACE
               MOVE    SPA-GMN-SYUBYOHENFLGLST (1)
                                           TO  SPA-GMN-SYUBYOHENFLG-G
           END-IF                                              
           IF     SPA-GMN-TENKIHENKBN-G    =   SPACE
               MOVE    SPA-GMN-TENKIHENKBNLST (1)
                                           TO  SPA-GMN-TENKIHENKBN-G
           END-IF                                              
           IF     SPA-GMN-KKHRECEKBN-G     =   SPACE
               MOVE    SPA-GMN-KKHRECEKBNLST (1)
                                           TO  SPA-GMN-KKHRECEKBN-G
           END-IF                                              
           IF     SPA-GMN-SYARECEKBN-G     =   SPACE
               MOVE    SPA-GMN-SYARECEKBNLST (1)
                                           TO  SPA-GMN-SYARECEKBN-G
           END-IF                                              
           IF     SPA-GMN-RENNUMHENKBN-G   =   SPACE
               MOVE    SPA-GMN-RENNUMHENKBNLST (1)
                                           TO  SPA-GMN-RENNUMHENKBN-G
           END-IF                                              
           IF     SPA-GMN-NEXTPRTKBN-G   =   SPACE
               MOVE    SPA-GMN-NEXTPRTKBNLST (1)
                                           TO  SPA-GMN-NEXTPRTKBN-G
           END-IF                                              
           IF     SPA-GMN-NEXTPRTKBN1-G  =   SPACE
               MOVE    SPA-GMN-NEXTPRTKBN1LST (1)
                                           TO  SPA-GMN-NEXTPRTKBN1-G
           END-IF                                              
           IF     SPA-GMN-RJNGNBKKBN-G  =   SPACE
               MOVE    SPA-GMN-RJNGNBKKBNLST (1)
                                           TO  SPA-GMN-RJNGNBKKBN-G
           END-IF                                              
           IF     SPA-GMN-JIHITEKKSIKBN-G  =   SPACE
               MOVE    SPA-GMN-JIHITEKKSIKBNLST (1)
                                           TO  SPA-GMN-JIHITEKKSIKBN-G
           END-IF                                              
           IF     SPA-GMN-SYAOCRKBN-G  =   SPACE
               MOVE    SPA-GMN-SYAOCRKBNLST (1)
                                           TO  SPA-GMN-SYAOCRKBN-G
           END-IF                                              
           IF     SPA-GMN-KKHOCRKBN-G  =   SPACE
               MOVE    SPA-GMN-KKHOCRKBNLST (1)
                                           TO  SPA-GMN-KKHOCRKBN-G
           END-IF                                              
           IF     SPA-GMN-RECECOMKBN   =   SPACE
               MOVE    SPA-GMN-RECECOMKBNLST (1)
                                           TO  SPA-GMN-RECECOMKBN-G
           END-IF                                              
           IF     SPA-GMN-SRYKAHENKBN  =   SPACE
               MOVE    SPA-GMN-SRYKAHENKBNLST (1)
                                           TO  SPA-GMN-SRYKAHENKBN-G
           END-IF                                              
           IF     SPA-GMN-AUTODSPKBN   =   SPACE
               MOVE    SPA-GMN-AUTODSPKBNLST (1)
                                           TO  SPA-GMN-AUTODSPKBN-G
           END-IF                                              
           IF     SPA-GMN-PRTJYUN1     =   SPACE
               MOVE    SPA-GMN-PRTJYUN1LST (1)
                                           TO  SPA-GMN-PRTJYUN1-G
           END-IF                                              
           IF     SPA-GMN-PRTJYUN2     =   SPACE
               MOVE    SPA-GMN-PRTJYUN2LST (1)
                                           TO  SPA-GMN-PRTJYUN2-G
           END-IF                                              
           IF     SPA-GMN-PRTJYUN3     =   SPACE
               MOVE    SPA-GMN-PRTJYUN3LST (1)
                                           TO  SPA-GMN-PRTJYUN3-G
           END-IF                                              
           IF     SPA-GMN-MOJI-KISAIKBN    =   SPACE
               MOVE    SPA-GMN-MOJI-KISAIKBNLST (1)
                                           TO  SPA-GMN-MOJI-KISAIKBN-G
           END-IF                                              
           IF     SPA-GMN-KYURATE-KISAIKBN =   SPACE
               MOVE    SPA-GMN-KYURATE-KISAIKBNLST (1)
                                           TO
                                           SPA-GMN-KYURATE-KISAIKBN-G
           END-IF                                              
           IF     SPA-GMN-RECESYUBETU-KISAIKBN =   SPACE
               MOVE    SPA-GMN-RECESYUBETU-KISAIKBNLST (1)
                                           TO
                                       SPA-GMN-RECESYUBETU-KISAIKBN-G
           END-IF                                              
           IF     SPA-GMN-SYUKA-KBN    =   SPACE
               MOVE    SPA-GMN-SYUKA-KBNLST (1)
                                           TO  SPA-GMN-SYUKA-KBN-G
           END-IF                                              
      *
           MOVE    1                   TO  SPA-GMN-CUR
           . 
       31O-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *    タグ
               WHEN    "CLICKED"       ALSO    "N01"
               WHEN    "CLICKED"       ALSO    "N02"
               WHEN    "CLICKED"       ALSO    "N03"
               WHEN    "CLICKED"       ALSO    "N04"
               WHEN    "CLICKED"       ALSO    "N05"
                   PERFORM 440-TAG-CHANGE-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC       SECTION.
      *
           MOVE    W12-BYOMEIHENKBN    TO  SPA-GMN-BYOMEIHENKBN-G 
           MOVE    W12-KKHRECEKBN      TO  SPA-GMN-KKHRECEKBN-G 
           MOVE    W12-SYARECEKBN      TO  SPA-GMN-SYARECEKBN-G 
           MOVE    W12-RECEDENOUT      TO  SPA-GMN-RECEDENOUT 
           MOVE    W12-SYAOCRKBN       TO  SPA-GMN-SYAOCRKBN-G 
           MOVE    W12-KKHOCRKBN       TO  SPA-GMN-KKHOCRKBN-G 
           MOVE    W12-PREFPRGID       TO  SPA-GMN-PREFPRGID
           MOVE    W12-PREFPRGID1      TO  SPA-GMN-PREFPRGID1
           MOVE    W12-KKHPRTKBN       TO  SPA-GMN-KKHPRTKBN-G 
           MOVE    W12-BYOMEIHENKBN1   TO  SPA-GMN-BYOMEIHENKBN1-G 
           MOVE    W12-SYUBYOHENFLG    TO  SPA-GMN-SYUBYOHENFLG-G 
           MOVE    W12-TENKIHENKBN     TO  SPA-GMN-TENKIHENKBN-G 
           MOVE    W12-SYAPRTNM        TO  SPA-GMN-SYAPRTNM
           MOVE    W12-KKHPRTNM        TO  SPA-GMN-KKHPRTNM
           MOVE    W12-RENNUMHENKBN    TO  SPA-GMN-RENNUMHENKBN-G 
           MOVE    W12-NEXTPRTKBN      TO  SPA-GMN-NEXTPRTKBN-G 
           MOVE    W12-NEXTPRTKBN1     TO  SPA-GMN-NEXTPRTKBN1-G 
           MOVE    W12-RJNGNBKKBN      TO  SPA-GMN-RJNGNBKKBN-G 
           MOVE    W12-JIHITEKKSIKBN   TO  SPA-GMN-JIHITEKKSIKBN-G 
           MOVE    W12-SYAPRTNM-NEXT   TO  SPA-GMN-SYAPRTNM-NEXT
           MOVE    W12-KKHPRTNM-NEXT   TO  SPA-GMN-KKHPRTNM-NEXT
           MOVE    W12-SRYKAHENKBN     TO  SPA-GMN-SRYKAHENKBN-G
           MOVE    W12-RECECOMKBN      TO  SPA-GMN-RECECOMKBN-G
           MOVE    W12-SYAPRTNM-N      TO  SPA-GMN-SYAPRTNM-N
           MOVE    W12-KKHPRTNM-N      TO  SPA-GMN-KKHPRTNM-N
           MOVE    W12-SYAPRTNM-NEXT-N TO  SPA-GMN-SYAPRTNM-NEXT-N
           MOVE    W12-KKHPRTNM-NEXT-N TO  SPA-GMN-KKHPRTNM-NEXT-N
           MOVE    W12-AUTODSPKBN      TO  SPA-GMN-AUTODSPKBN-G
           MOVE    W12-PRTJYUNKBN1     TO  SPA-GMN-PRTJYUN1-G
           MOVE    W12-PRTJYUNKBN2     TO  SPA-GMN-PRTJYUN2-G
           MOVE    W12-PRTJYUNKBN3     TO  SPA-GMN-PRTJYUN3-G
      *
           MOVE    W12-MOJI-KISAIKBN   TO  SPA-GMN-MOJI-KISAIKBN-G
           MOVE    W12-KYURATE-KISAIKBN
                                       TO  SPA-GMN-KYURATE-KISAIKBN-G
           MOVE    W12-RECESYUBETU-KISAIKBN
                                       TO
                                       SPA-GMN-RECESYUBETU-KISAIKBN-G
      *
           MOVE    W12-PREFKBN-PRTJYUN TO  SPA-GMN-PREFKBN-PRTJYUN-G
           MOVE    W12-HKNJANUM-PRTJYUN
                                       TO  SPA-GMN-HKNJANUM-PRTJYUN-G
           MOVE    W12-RECESYUBETU-PRTJYUN
                                       TO
                                       SPA-GMN-RECESYUBETU-PRTJYUN-G
           MOVE    W12-ZAITAKU         TO  SPA-GMN-ZAITAKU-G
           MOVE    W12-CHOUKI          TO  SPA-GMN-CHOUKI-G
           MOVE    W12-HKNJANUM-PRTKBN TO  SPA-GMN-HKNJANUM-PRTKBN-G
           MOVE    W12-HKNJANUM        TO  SPA-GMN-HKNJANUM
      *
           MOVE    W12-SYUKA-KBN       TO  SPA-GMN-SYUKA-KBN-G
           MOVE    W12-SYUKA-NYUIN     TO  SPA-GMN-SYUKA-NYUIN-G
           MOVE    W12-SYUKA-GAIRAI    TO  SPA-GMN-SYUKA-GAIRAI-G
           MOVE    W12-SYUKA-SELECT    TO  SPA-GMN-SYUKA-SELECT-G
           MOVE    W12-SYUKA-MODE      TO  SPA-GMN-SYUKA-MODE-G
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC       SECTION.
      *
           PERFORM 4100-BYOMEIHENKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4107-BYOMEIHENKBN1-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4114-SYUBYOHENFLG-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4108-TENKIHENKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4102-SYARECEKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-KKHRECEKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4103-RECEDENOUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4120-RECECOMKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4119-SYAOCRKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4104-KKHOCRKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4106-PREFPRGID-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4112-PREFPRGID1-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4109-SYAPRTNM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4109-SYAPRTNM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4115-SYAPRTNM-NEXT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4110-KKHPRTNM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4116-KKHPRTNM-NEXT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4111-RENNUMHEKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4113-NEXTPRTKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4114-NEXTPRTKBN1-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4117-RJNGNBKKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4118-JIHITEKKSIKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4121-SRYKAHENKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4122-AUTODSPKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4123-PRTJYUN1-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4135-PRTJYUN3-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4124-PRTJYUN2-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4125-MOJI-KISAIKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4126-KYURATE-KISAIKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4127-RECESYUBETU-KISAIKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4128-PREFKBN-PRTJYUN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4129-HKNJANUM-PRTJYUN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4130-RECESYUBETU-PRTJYUN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4131-ZAITAKU-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4132-CHOUKI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4133-HKNJANUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4134-HKNJANUM-PRTKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4105-KKHPRTKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
           PERFORM 4135-SYUKA-KBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4136-SYUKA-NYUIN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4137-SYUKA-GAIRAI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4139-SYUKA-SELECT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4138-SYUKA-MODE-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名編集区分ェック
      *****************************************************************
       4100-BYOMEIHENKBN-CHK-SEC       SECTION.
      *
      *
      **** MOVE    W12-BYOMEIHENKBN       TO  SPA-GMN-BYOMEIHENKBN-G 
      *
           IF      SPA-GMN-BYOMEIHENKBN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-BYOMEIHENKBN-MAX
                   IF      SPA-GMN-BYOMEIHENKBN 
                                   =   SPA-GMN-BYOMEIHENKBNL (IDY)
                       MOVE    SPA-GMN-BYOMEIHENKBNLST (IDY)
                                           TO  SPA-GMN-BYOMEIHENKBN-G
                       MOVE    SPA-GMN-BYOMEIHENKBN-MAX
                                           TO  IDY
                   END-IF
               END-PERFORM
      *     
               IF      SPA-GMN-BYOMEIHENKBNMEI =   SPACE
                   MOVE    1                   TO  SPA-GMN-CUR
                   MOVE    "0001"              TO  SPA-ERRCD
               END-IF
           END-IF 
      *
           .
       4100-BYOMEIHENKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    国保レセプト区分チェック
      *****************************************************************
       4101-KKHRECEKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-KKHRECEKBN  =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KKHRECEKBN-MAX
                   IF      SPA-GMN-KKHRECEKBN 
                                   =   SPA-GMN-KKHRECEKBNL (IDY)
                       MOVE    SPA-GMN-KKHRECEKBNLST (IDY)
                                           TO  SPA-GMN-KKHRECEKBN-G
                       MOVE    SPA-GMN-KKHRECEKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-KKHRECEKBNMEI   =   SPACE
                   MOVE    5                      TO  SPA-GMN-CUR
                   MOVE    "0002"                  TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4101-KKHRECEKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    社保レセプト区分ェック
      *****************************************************************
       4102-SYARECEKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-SYARECEKBN  =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYARECEKBN-MAX
                   IF      SPA-GMN-SYARECEKBN 
                                   =   SPA-GMN-SYARECEKBNL (IDY)
                       MOVE    SPA-GMN-SYARECEKBNLST (IDY)
                                           TO  SPA-GMN-SYARECEKBN-G
                       MOVE    SPA-GMN-SYARECEKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-SYARECEKBNMEI   =   SPACE
                   MOVE    4                       TO  SPA-GMN-CUR
                   MOVE    "0003"                  TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4102-SYARECEKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセ電データ出力先チェック
      *****************************************************************
       4103-RECEDENOUT-CHK-SEC       SECTION.
      *
      *
           .
       4103-RECEDENOUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    国保ＯＣＲ印刷区分ェック
      *****************************************************************
       4104-KKHOCRKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-KKHOCRKBN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KKHOCRKBN-MAX
                   IF      SPA-GMN-KKHOCRKBN
                                   =   SPA-GMN-KKHOCRKBNL (IDY)
                       MOVE    SPA-GMN-KKHOCRKBNLST (IDY)
                                           TO  SPA-GMN-KKHOCRKBN-G
                       MOVE    SPA-GMN-KKHOCRKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-KKHOCRKBNMEI    =   SPACE
                   MOVE    7                  TO  SPA-GMN-CUR
                   MOVE    "0004"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4104-KKHOCRKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    県単用項目編集プログラム名チェック
      *****************************************************************
       4106-PREFPRGID-CHK-SEC       SECTION.
      *
      *
           IF      SPA-GMN-PREFPRGID      =   SPACE
               CONTINUE
           ELSE     
               IF      SPA-GMN-PREFPRGID(1:1) =   "S"
                   CONTINUE
               ELSE
                  MOVE    8                      TO  SPA-GMN-CUR
                  MOVE    "0006"                 TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       4106-PREFPRGID-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    県単用項目編集プログラム名（入院用）チェック
      *****************************************************************
       4112-PREFPRGID1-CHK-SEC       SECTION.
      *
      *
           IF      SPA-GMN-PREFPRGID1     =   SPACE
               CONTINUE
           ELSE     
               IF      SPA-GMN-PREFPRGID1(1:1) =   "S"
                   CONTINUE
               ELSE
                  MOVE    13                     TO  SPA-GMN-CUR
                  MOVE    "0006"                 TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       4112-PREFPRGID1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    国保診療報酬請求書印刷分チェック
      *****************************************************************
       4105-KKHPRTKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-KKHPRTKBN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KKHPRTKBN-MAX
                   IF      SPA-GMN-KKHPRTKBN
                                   =   SPA-GMN-KKHPRTKBNL (IDY)
                       MOVE    SPA-GMN-KKHPRTKBNLST (IDY)
                                           TO  SPA-GMN-KKHPRTKBN-G
                       MOVE    SPA-GMN-KKHPRTKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-KKHPRTKBNMEI    =   SPACE
                   MOVE    11                  TO  SPA-GMN-CUR
                   MOVE    "0005"                  TO  SPA-ERRCD
               END-IF
           END-IF     
      *
           .
       4105-KKHPRTKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名編集区分１チェック
      *****************************************************************
       4107-BYOMEIHENKBN1-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-BYOMEIHENKBN1   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-BYOMEIHENKBN1-MAX
                   IF      SPA-GMN-BYOMEIHENKBN1 
                                   =   SPA-GMN-BYOMEIHENKBN1L (IDY)
                       MOVE    SPA-GMN-BYOMEIHENKBN1LST (IDY)
                                           TO  SPA-GMN-BYOMEIHENKBN1-G
                       MOVE    SPA-GMN-BYOMEIHENKBN1-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-BYOMEIHENKBN1MEI =   SPACE
                   MOVE    2                       TO  SPA-GMN-CUR
                   MOVE    "0001"                  TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4107-BYOMEIHENKBN1-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    主病名編集フラグチェック
      *****************************************************************
       4114-SYUBYOHENFLG-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-SYUBYOHENFLG   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYUBYOHENFLG-MAX
                   IF      SPA-GMN-SYUBYOHENFLG 
                                   =   SPA-GMN-SYUBYOHENFLGL (IDY)
                       MOVE    SPA-GMN-SYUBYOHENFLGLST (IDY)
                                           TO  SPA-GMN-SYUBYOHENFLG-G
                       MOVE    SPA-GMN-SYUBYOHENFLG-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-SYUBYOHENFLGMEI =   SPACE
                   MOVE    15                      TO  SPA-GMN-CUR
                   MOVE    "0010"                  TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4114-SYUBYOHENFLG-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    転帰日編集区分チェック
      *****************************************************************
       4108-TENKIHENKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-TENKIHENKBN     =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-TENKIHENKBN-MAX
                   IF      SPA-GMN-TENKIHENKBN 
                                   =   SPA-GMN-TENKIHENKBNL (IDY)
                       MOVE    SPA-GMN-TENKIHENKBNLST (IDY)
                                           TO  SPA-GMN-TENKIHENKBN-G
                       MOVE    SPA-GMN-TENKIHENKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *      
               IF      SPA-GMN-TENKIHENKBNMEI =   SPACE
                   MOVE    3                   TO  SPA-GMN-CUR
                   MOVE    "0007"                  TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4108-TENKIHENKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    社保出力先プリンタ名チェック
      *****************************************************************
       4109-SYAPRTNM-CHK-SEC       SECTION.
      *
           .
       4109-SYAPRTNM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    国保出力先プリンタ名チェック
      *****************************************************************
       4110-KKHPRTNM-CHK-SEC       SECTION.
      *
           .
       4110-KKHPRTNM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    通し番号編集区分チェック
      *****************************************************************
       4111-RENNUMHEKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-RENNUMHENKBN    =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-RENNUMHENKBN-MAX
                   IF      SPA-GMN-RENNUMHENKBN
                                   =   SPA-GMN-RENNUMHENKBNL (IDY)
                       MOVE    SPA-GMN-RENNUMHENKBNLST (IDY)
                                           TO  SPA-GMN-RENNUMHENKBN-G
                       MOVE    SPA-GMN-RENNUMHENKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-RENNUMHENKBNMEI    =   SPACE
                   MOVE    12                  TO  SPA-GMN-CUR
                   MOVE    "0008"                  TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4111-RENNUMHEKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    続紙区分（入院）チェック
      *****************************************************************
       4113-NEXTPRTKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-NEXTPRTKBN    =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-NEXTPRTKBN-MAX
                   IF      SPA-GMN-NEXTPRTKBN
                                   =   SPA-GMN-NEXTPRTKBNL (IDY)
                       MOVE    SPA-GMN-NEXTPRTKBNLST (IDY)
                                           TO  SPA-GMN-NEXTPRTKBN-G
                       MOVE    SPA-GMN-NEXTPRTKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-NEXTPRTKBNMEI    =   SPACE
                   MOVE    14                 TO  SPA-GMN-CUR
                   MOVE    "0009"                  TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4113-NEXTPRTKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    続紙区分（入院外）チェック
      *****************************************************************
       4114-NEXTPRTKBN1-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-NEXTPRTKBN1    =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-NEXTPRTKBN1-MAX
                   IF      SPA-GMN-NEXTPRTKBN1
                                   =   SPA-GMN-NEXTPRTKBN1L (IDY)
                       MOVE    SPA-GMN-NEXTPRTKBN1LST (IDY)
                                           TO  SPA-GMN-NEXTPRTKBN1-G
                       MOVE    SPA-GMN-NEXTPRTKBN1-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-NEXTPRTKBN1MEI    =   SPACE
                   MOVE    16                 TO  SPA-GMN-CUR
                   MOVE    "0009"                  TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4114-NEXTPRTKBN1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    社保出力先プリンタ名（続紙）チェック
      *****************************************************************
       4115-SYAPRTNM-NEXT-CHK-SEC       SECTION.
      *
           .
       4115-SYAPRTNM-NEXT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    国保出力先プリンタ名（続紙）チェック
      *****************************************************************
       4116-KKHPRTNM-NEXT-CHK-SEC       SECTION.
      *
           .
       4116-KKHPRTNM-NEXT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    老人と原爆区分チェック
      *****************************************************************
       4117-RJNGNBKKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-RJNGNBKKBN    =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-RJNGNBKKBN-MAX
                        OR     SPA-GMN-RJNGNBKKBN
                                   =       SPA-GMN-RJNGNBKKBNL (IDY)
                   CONTINUE
               END-PERFORM
      * 
               IF      IDY <=      SPA-GMN-RJNGNBKKBN-MAX
                   MOVE    SPA-GMN-RJNGNBKKBNLST (IDY)
                                              TO  SPA-GMN-RJNGNBKKBN-G
               ELSE
                   MOVE    19                 TO  SPA-GMN-CUR
                   MOVE    "0011"             TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4117-RJNGNBKKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    自費レセ摘要欄記載区分チェック
      *****************************************************************
       4118-JIHITEKKSIKBN-CHK-SEC      SECTION.
      *
           IF      SPA-GMN-JIHITEKKSIKBN    =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-JIHITEKKSIKBN-MAX
                        OR     SPA-GMN-JIHITEKKSIKBN
                                   =       SPA-GMN-JIHITEKKSIKBNL (IDY)
                   CONTINUE
               END-PERFORM
      * 
               IF      IDY <=      SPA-GMN-JIHITEKKSIKBN-MAX
                   MOVE    SPA-GMN-JIHITEKKSIKBNLST (IDY)
                                          TO  SPA-GMN-JIHITEKKSIKBN-G
               ELSE
                   MOVE    20             TO  SPA-GMN-CUR
                   MOVE    "0012"         TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           .
       4118-JIHITEKKSIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    社保ＯＣＲ印刷区分ェック
      *****************************************************************
       4119-SYAOCRKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-SYAOCRKBN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYAOCRKBN-MAX
                   IF      SPA-GMN-SYAOCRKBN
                                   =   SPA-GMN-SYAOCRKBNL (IDY)
                       MOVE    SPA-GMN-SYAOCRKBNLST (IDY)
                                           TO  SPA-GMN-SYAOCRKBN-G
                       MOVE    SPA-GMN-SYAOCRKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-SYAOCRKBNMEI    =   SPACE
                   MOVE    7                  TO  SPA-GMN-CUR
                   MOVE    "0004"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4119-SYAOCRKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプトコメント（症状詳記）記録区分チェック
      *****************************************************************
       4120-RECECOMKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-RECECOMKBN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-RECECOMKBN-MAX
                   IF      SPA-GMN-RECECOMKBN
                                   =   SPA-GMN-RECECOMKBNL (IDY)
                       MOVE    SPA-GMN-RECECOMKBNLST (IDY)
                                           TO  SPA-GMN-RECECOMKBN-G
                       MOVE    SPA-GMN-RECECOMKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-RECECOMKBNMEI   =   SPACE
                   MOVE    22                      TO  SPA-GMN-CUR
                   MOVE    "0013"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4120-RECECOMKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科編集区分チェック
      *****************************************************************
       4121-SRYKAHENKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-SRYKAHENKBN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SRYKAHENKBN-MAX
                   IF      SPA-GMN-SRYKAHENKBN
                                   =   SPA-GMN-SRYKAHENKBNL (IDY)
                       MOVE    SPA-GMN-SRYKAHENKBNLST (IDY)
                                           TO  SPA-GMN-SRYKAHENKBN-G
                       MOVE    SPA-GMN-SRYKAHENKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-SRYKAHENKBNMEI  =   SPACE
                   MOVE    23                      TO  SPA-GMN-CUR
                   MOVE    "0014"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4121-SRYKAHENKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自動遷移区分チェック
      *****************************************************************
       4122-AUTODSPKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-AUTODSPKBN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-AUTODSPKBN-MAX
                   IF      SPA-GMN-AUTODSPKBN
                                   =   SPA-GMN-AUTODSPKBNL (IDY)
                       MOVE    SPA-GMN-AUTODSPKBNLST (IDY)
                                           TO  SPA-GMN-AUTODSPKBN-G
                       MOVE    SPA-GMN-AUTODSPKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-AUTODSPKBNMEI  =   SPACE
                   MOVE    28                      TO  SPA-GMN-CUR
                   MOVE    "0015"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4122-AUTODSPKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    一括作成出力順（社保）チェック
      *****************************************************************
       4123-PRTJYUN1-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-PRTJYUN1   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-PRTJYUN1-MAX
                   IF      SPA-GMN-PRTJYUN1
                                   =   SPA-GMN-PRTJYUN1L (IDY)
                       MOVE    SPA-GMN-PRTJYUN1LST (IDY)
                                           TO  SPA-GMN-PRTJYUN1-G
                       MOVE    SPA-GMN-PRTJYUN1-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-PRTJYUN1MEI  =   SPACE
                   MOVE    29                      TO  SPA-GMN-CUR
                   MOVE    "0016"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4123-PRTJYUN1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    一括作成出力順（国保）チェック
      *****************************************************************
       4135-PRTJYUN3-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-PRTJYUN3   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-PRTJYUN3-MAX
                   IF      SPA-GMN-PRTJYUN3
                                   =   SPA-GMN-PRTJYUN3L (IDY)
                       MOVE    SPA-GMN-PRTJYUN3LST (IDY)
                                           TO  SPA-GMN-PRTJYUN3-G
                       MOVE    SPA-GMN-PRTJYUN3-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-PRTJYUN3MEI  =   SPACE
                   MOVE    30                      TO  SPA-GMN-CUR
                   MOVE    "0028"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4135-PRTJYUN3-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別作成出力順チェック
      *****************************************************************
       4124-PRTJYUN2-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-PRTJYUN2   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-PRTJYUN2-MAX
                   IF      SPA-GMN-PRTJYUN2
                                   =   SPA-GMN-PRTJYUN2L (IDY)
                       MOVE    SPA-GMN-PRTJYUN2LST (IDY)
                                           TO  SPA-GMN-PRTJYUN2-G
                       MOVE    SPA-GMN-PRTJYUN2-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-PRTJYUN2MEI  =   SPACE
                   MOVE    30                      TO  SPA-GMN-CUR
                   MOVE    "0017"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4124-PRTJYUN2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    「特別療養費」文字記載位置チェック
      *****************************************************************
       4125-MOJI-KISAIKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-MOJI-KISAIKBN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-MOJI-KISAIKBN-MAX
                   IF      SPA-GMN-MOJI-KISAIKBN
                                   =   SPA-GMN-MOJI-KISAIKBNL (IDY)
                       MOVE    SPA-GMN-MOJI-KISAIKBNLST (IDY)
                                           TO  SPA-GMN-MOJI-KISAIKBN-G
                       MOVE    SPA-GMN-MOJI-KISAIKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-MOJI-KISAIKBNMEI  =   SPACE
                   MOVE    50                      TO  SPA-GMN-CUR
                   MOVE    "0018"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4125-MOJI-KISAIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    給付割合欄記載区分チェック
      *****************************************************************
       4126-KYURATE-KISAIKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-KYURATE-KISAIKBN
                                           =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KYURATE-KISAIKBN-MAX
                   IF      SPA-GMN-KYURATE-KISAIKBN
                                   =   SPA-GMN-KYURATE-KISAIKBNL (IDY)
                       MOVE    SPA-GMN-KYURATE-KISAIKBNLST (IDY)
                                           TO
                                           SPA-GMN-KYURATE-KISAIKBN-G
                       MOVE    SPA-GMN-KYURATE-KISAIKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-KYURATE-KISAIKBNMEI =   SPACE
                   MOVE    51                      TO  SPA-GMN-CUR
                   MOVE    "0019"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4126-KYURATE-KISAIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト種別欄記載区分チェック
      *****************************************************************
       4127-RECESYUBETU-KISAIKBN-CHK-SEC   SECTION.
      *
           IF      SPA-GMN-RECESYUBETU-KISAIKBN
                                           =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-RECESYUBETU-KISAIKBN-MAX
                   IF      SPA-GMN-RECESYUBETU-KISAIKBN
                                   =
                                   SPA-GMN-RECESYUBETU-KISAIKBNL (IDY)
                       MOVE    SPA-GMN-RECESYUBETU-KISAIKBNLST (IDY)
                                           TO
                                       SPA-GMN-RECESYUBETU-KISAIKBN-G
                       MOVE    SPA-GMN-RECESYUBETU-KISAIKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-RECESYUBETU-KISAIKBNMEI =   SPACE
                   MOVE    52                      TO  SPA-GMN-CUR
                   MOVE    "0020"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4127-RECESYUBETU-KISAIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷順指定・県内県外チェック
      *****************************************************************
       4128-PREFKBN-PRTJYUN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-PREFKBN-PRTJYUN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-PREFKBN-PRTJYUN-MAX
                   IF      SPA-GMN-PREFKBN-PRTJYUN
                                   =   SPA-GMN-PREFKBN-PRTJYUNL (IDY)
                       MOVE    SPA-GMN-PREFKBN-PRTJYUNLST (IDY)
                                           TO  SPA-GMN-PREFKBN-PRTJYUN-G
                       MOVE    SPA-GMN-PREFKBN-PRTJYUN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-PREFKBN-PRTJYUNMEI  =   SPACE
                   MOVE    70                      TO  SPA-GMN-CUR
                   MOVE    "0021"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4128-PREFKBN-PRTJYUN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷順指定・保険者チェック
      *****************************************************************
       4129-HKNJANUM-PRTJYUN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-HKNJANUM-PRTJYUN
                                           =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-HKNJANUM-PRTJYUN-MAX
                   IF      SPA-GMN-HKNJANUM-PRTJYUN
                                   =   SPA-GMN-HKNJANUM-PRTJYUNL (IDY)
                       MOVE    SPA-GMN-HKNJANUM-PRTJYUNLST (IDY)
                                           TO
                                           SPA-GMN-HKNJANUM-PRTJYUN-G
                       MOVE    SPA-GMN-HKNJANUM-PRTJYUN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-HKNJANUM-PRTJYUNMEI =   SPACE
                   MOVE    71                      TO  SPA-GMN-CUR
                   MOVE    "0022"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4129-HKNJANUM-PRTJYUN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷順指定・レセプト種別チェック
      *****************************************************************
       4130-RECESYUBETU-PRTJYUN-CHK-SEC   SECTION.
      *
           IF      SPA-GMN-RECESYUBETU-PRTJYUN
                                           =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-RECESYUBETU-PRTJYUN-MAX
                   IF      SPA-GMN-RECESYUBETU-PRTJYUN
                                   =
                                   SPA-GMN-RECESYUBETU-PRTJYUNL (IDY)
                       MOVE    SPA-GMN-RECESYUBETU-PRTJYUNLST (IDY)
                                           TO
                                       SPA-GMN-RECESYUBETU-PRTJYUN-G
                       MOVE    SPA-GMN-RECESYUBETU-PRTJYUN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-RECESYUBETU-PRTJYUNMEI =   SPACE
                   MOVE    72                      TO  SPA-GMN-CUR
                   MOVE    "0023"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4130-RECESYUBETU-PRTJYUN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    在総診・在医総チェック
      *****************************************************************
       4131-ZAITAKU-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-ZAITAKU   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-ZAITAKU-MAX
                   IF      SPA-GMN-ZAITAKU
                                   =   SPA-GMN-ZAITAKUL (IDY)
                       MOVE    SPA-GMN-ZAITAKULST (IDY)
                                           TO  SPA-GMN-ZAITAKU-G
                       MOVE    SPA-GMN-ZAITAKU-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-ZAITAKUMEI  =   SPACE
                   MOVE    73                      TO  SPA-GMN-CUR
                   MOVE    "0024"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4131-ZAITAKU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    長期（長期高額療養費）チェック
      *****************************************************************
       4132-CHOUKI-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-CHOUKI
                                           =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-CHOUKI-MAX
                   IF      SPA-GMN-CHOUKI
                                   =   SPA-GMN-CHOUKIL (IDY)
                       MOVE    SPA-GMN-CHOUKILST (IDY)
                                           TO
                                           SPA-GMN-CHOUKI-G
                       MOVE    SPA-GMN-CHOUKI-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-CHOUKIMEI =   SPACE
                   MOVE    74                      TO  SPA-GMN-CUR
                   MOVE    "0025"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4132-CHOUKI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関の所在地保険者チェック
      *****************************************************************
       4133-HKNJANUM-CHK-SEC   SECTION.
      *
           MOVE    SPACE                TO SPA-GMN-HKNJANAME
      *
           IF      SPA-GMN-HKNJANUM        =   SPACE
               MOVE    SPACE               TO  SPA-GMN-HKNJANUM-PRTKBN-G
           ELSE
               MOVE    SPACE               TO  HKNJAINF-REC
               INITIALIZE                      HKNJAINF-REC
               MOVE    SPA-HOSPID          TO  HKNJA-HOSPID
               MOVE    SPA-GMN-HKNJANUM    TO  HKNJA-HKNJANUM
               MOVE    HKNJAINF-REC        TO  MCPDATA-REC
               PERFORM 900-HKNJAINF-READ-SEC
               IF      FLG-HKNJAINF        =   ZERO
                   MOVE    HKNJA-HKNJANAME     TO  SPA-GMN-HKNJANAME
                   IF      HKNJA-HKNNUM    NOT =   "060"      
                       MOVE    75                      TO  SPA-GMN-CUR
                       MOVE    "0026"                  TO  SPA-ERRCD
                   ELSE
                       IF      HKNJA-HKNJANUM (1:2)
                                               NOT =   SPA-1001-PREFNUM
                           MOVE    75                  TO  SPA-GMN-CUR
                           MOVE    "0029"              TO  SPA-ERRCD
                       END-IF
                   END-IF
               ELSE
                   MOVE    75                      TO  SPA-GMN-CUR
                   MOVE    "0026"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4133-HKNJANUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関の所在地保険者印刷位置チェック
      *****************************************************************
       4134-HKNJANUM-PRTKBN-CHK-SEC   SECTION.
      *
           IF      SPA-GMN-HKNJANUM-PRTKBN
                                           =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-HKNJANUM-PRTKBN-MAX
                   IF      SPA-GMN-HKNJANUM-PRTKBN
                                   =
                                   SPA-GMN-HKNJANUM-PRTKBNL (IDY)
                       MOVE    SPA-GMN-HKNJANUM-PRTKBNLST (IDY)
                                           TO
                                       SPA-GMN-HKNJANUM-PRTKBN-G
                       MOVE    SPA-GMN-HKNJANUM-PRTKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-HKNJANUM-PRTKBNMEI =   SPACE
                   MOVE    76                      TO  SPA-GMN-CUR
                   MOVE    "0027"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4134-HKNJANUM-PRTKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主科設定フラグチェック
      *****************************************************************
       4135-SYUKA-KBN-CHK-SEC   SECTION.
      *
           IF      SPA-GMN-SYUKA-KBN
                                           =   SPACE
               MOVE    SPA-GMN-SYUKA-KBNLST (1)
                                               TO  SPA-GMN-SYUKA-KBN-G
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-SYUKA-KBN-MAX
                   IF      SPA-GMN-SYUKA-KBN
                                   =
                                   SPA-GMN-SYUKA-KBNL (IDY)
                       MOVE    SPA-GMN-SYUKA-KBNLST (IDY)
                                           TO
                                       SPA-GMN-SYUKA-KBN-G
                       MOVE    SPA-GMN-SYUKA-KBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-SYUKA-KBNMEI =   SPACE
                   MOVE    90                      TO  SPA-GMN-CUR
                   MOVE    "0030"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4135-SYUKA-KBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主科設定情報（入院）チェック
      *****************************************************************
       4136-SYUKA-NYUIN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-SYUKA-NYUIN   =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYUKA-NYUIN-MAX
                   IF      SPA-GMN-SYUKA-NYUIN
                                   =   SPA-GMN-SYUKA-NYUINL (IDY)
                       MOVE    SPA-GMN-SYUKA-NYUINLST (IDY)
                                           TO  SPA-GMN-SYUKA-NYUIN-G
                       MOVE    SPA-GMN-SYUKA-NYUIN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-SYUKA-NYUINMEI  =   SPACE
                   MOVE    91                      TO  SPA-GMN-CUR
                   MOVE    "0031"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4136-SYUKA-NYUIN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主科設定情報（入院外）チェック
      *****************************************************************
       4137-SYUKA-GAIRAI-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-SYUKA-GAIRAI
                                           =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYUKA-GAIRAI-MAX
                   IF      SPA-GMN-SYUKA-GAIRAI
                                   =   SPA-GMN-SYUKA-GAIRAIL (IDY)
                       MOVE    SPA-GMN-SYUKA-GAIRAILST (IDY)
                                           TO
                                           SPA-GMN-SYUKA-GAIRAI-G
                       MOVE    SPA-GMN-SYUKA-GAIRAI-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-SYUKA-GAIRAIMEI =   SPACE
                   MOVE    92                      TO  SPA-GMN-CUR
                   MOVE    "0032"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4137-SYUKA-GAIRAI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主科情報取得フラグチェック
      *****************************************************************
       4138-SYUKA-MODE-CHK-SEC   SECTION.
      *
           IF      SPA-GMN-SYUKA-MODE
                                           =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-SYUKA-MODE-MAX
                   IF      SPA-GMN-SYUKA-MODE
                                   =
                                   SPA-GMN-SYUKA-MODEL (IDY)
                       MOVE    SPA-GMN-SYUKA-MODELST (IDY)
                                           TO
                                       SPA-GMN-SYUKA-MODE-G
                       MOVE    SPA-GMN-SYUKA-MODE-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-SYUKA-MODEMEI =   SPACE
                   MOVE    94                      TO  SPA-GMN-CUR
                   MOVE    "0033"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4138-SYUKA-MODE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数科同一選択チェック
      *****************************************************************
       4139-SYUKA-SELECT-CHK-SEC   SECTION.
      *
           IF      SPA-GMN-SYUKA-SELECT    =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >   SPA-GMN-SYUKA-SELECT-MAX
                   IF      SPA-GMN-SYUKA-SELECT
                                   =
                                   SPA-GMN-SYUKA-SELECTL (IDY)
                       MOVE    SPA-GMN-SYUKA-SELECTLST (IDY)
                                           TO
                                       SPA-GMN-SYUKA-SELECT-G
                       MOVE    SPA-GMN-SYUKA-SELECT-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *     
               IF      SPA-GMN-SYUKA-SELECTMEI =   SPACE
                   MOVE    93                      TO  SPA-GMN-CUR
                   MOVE    "0034"                  TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       4139-SYUKA-SELECT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    タグ編集処理
      *****************************************************************
       440-TAG-CHANGE-SEC            SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "N01"
                   MOVE   0            TO  IDX
               WHEN    "N04"
                  MOVE    1            TO  IDX
               WHEN    "N02"
                  MOVE    2            TO  IDX
               WHEN    "N03"
                  MOVE    3            TO  IDX
               WHEN    "N05"
                  MOVE    4            TO  IDX
           END-EVALUATE
      *
      *    タグが変わったとき項目チェック
           IF      IDX              NOT =   W12-PAGENO
               MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
               MOVE    ZERO                TO  SPA-GMN-CUR
      *
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
               IF      SPA-ERRCD            =   SPACE
      *            関連チェック
                   PERFORM 4900-KANRENCHK-SEC
                   IF      SPA-ERRCD        =   SPACE
                       EVALUATE    IDX
                           WHEN    0
                               MOVE    1            TO  SPA-GMN-CUR
                           WHEN    1
                               MOVE    70           TO  SPA-GMN-CUR
                           WHEN    2
                               MOVE    50           TO  SPA-GMN-CUR
                           WHEN    3
                               MOVE    11           TO  SPA-GMN-CUR
                           WHEN    4
                               MOVE    90           TO  SPA-GMN-CUR
                       END-EVALUATE
                   END-IF
               END-IF
           END-IF        
           .
       440-TAG-CHANGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W12"               TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-W01KYOUTU
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録前処理
      *****************************************************************
       490-TOUROKU-SEC              SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
              GO      TO      490-TOUROKU-EXT
           END-IF
      *
           PERFORM 4900-KANRENCHK-SEC
           IF      SPA-ERRCD        =   SPACE
              MOVE    "1001"           TO  SPA-WIDCD
           END-IF
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
      *    レセプト（基本・特別療養費）総括編集情報
           MOVE    SPACE               TO  SYS-2005-REC
           INITIALIZE                      SYS-2005-REC
           MOVE    "2005"                  TO  SYS-2005-KANRICD
           MOVE    "*"                     TO  SYS-2005-KBNCD
           MOVE    SPA-W01-SEL-STYUKYMD    TO  SYS-2005-STYUKYMD
           MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYS-2005-EDYUKYMD
           MOVE    SYS-2005-REC            TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  WRK-MCP-TABLE
           MOVE    "key10"             TO  WRK-MCP-PATHNAME
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-2005-REC
           ELSE
               MOVE    SPACE                   TO  SYS-2005-REC
               INITIALIZE                          SYS-2005-REC
               MOVE    "2005"                  TO  SYS-2005-KANRICD
               MOVE    "*"                     TO  SYS-2005-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-2005-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-2005-EDYUKYMD
           MOVE    SPA-GMN-BYOMEIHENKBN    TO  SYS-2005-BYOMEIHENKBN
           MOVE    SPA-GMN-BYOMEIHENKBN1   TO  SYS-2005-BYOMEIHENKBN1
           MOVE    SPA-GMN-SYUBYOHENFLG    TO  SYS-2005-SYUBYOHENFLG
           MOVE    SPA-GMN-TENKIHENKBN     TO  SYS-2005-TENKIHENKBN
           MOVE    SPA-GMN-KKHRECEKBN      TO  SYS-2005-KKHRECEKBN
           MOVE    SPA-GMN-SYARECEKBN      TO  SYS-2005-SYARECEKBN
           MOVE    SPA-GMN-RECEDENOUT      TO  SYS-2005-RECEDENOUT
           MOVE    SPA-GMN-SYAOCRKBN       TO  SYS-2005-SYAOCRKBN
           MOVE    SPA-GMN-KKHOCRKBN       TO  SYS-2005-KKHOCRKBN
           MOVE    SPA-GMN-KKHPRTKBN       TO  SYS-2005-KKHPRTKBN
           MOVE    SPA-GMN-PREFPRGID       TO  SYS-2005-PREFPRGID (1)
           MOVE    SPA-GMN-PREFPRGID1      TO  SYS-2005-PREFPRGID (2)
           MOVE    SPA-GMN-SYAPRTNM        TO  SYS-2005-SYAPRTNM
           MOVE    SPA-GMN-KKHPRTNM        TO  SYS-2005-KKHPRTNM
           MOVE    SPA-GMN-RENNUMHENKBN    TO  SYS-2005-RENNUMHENKBN
           MOVE    SPA-GMN-NEXTPRTKBN      TO  SYS-2005-NEXTPRTKBN
           MOVE    SPA-GMN-NEXTPRTKBN1     TO  SYS-2005-NEXTPRTKBN-G
           MOVE    SPA-GMN-RJNGNBKKBN      TO  SYS-2005-RJNGNBKKBN
           MOVE    SPA-GMN-JIHITEKKSIKBN   TO  SYS-2005-JIHITEKKSIKBN
           MOVE    SPA-GMN-SYAPRTNM-NEXT   TO  SYS-2005-SYAPRTNM-NEXT
           MOVE    SPA-GMN-KKHPRTNM-NEXT   TO  SYS-2005-KKHPRTNM-NEXT
           MOVE    SPA-GMN-SRYKAHENKBN     TO  SYS-2005-SRYKAHENKBN
           MOVE    SPA-GMN-RECECOMKBN      TO  SYS-2005-RECECOMKBN
           MOVE    SPA-GMN-SYAPRTNM-N      TO  SYS-2005-SYAPRTNM-N
           MOVE    SPA-GMN-KKHPRTNM-N      TO  SYS-2005-KKHPRTNM-N
           MOVE    SPA-GMN-SYAPRTNM-NEXT-N TO  SYS-2005-SYAPRTNM-NEXT-N
           MOVE    SPA-GMN-KKHPRTNM-NEXT-N TO  SYS-2005-KKHPRTNM-NEXT-N
           MOVE    SPA-GMN-AUTODSPKBN      TO  SYS-2005-AUTODSPKBN
           MOVE    SPA-GMN-PRTJYUN1        TO  SYS-2005-PRTJYUNKBN1
           MOVE    SPA-GMN-PRTJYUN2        TO  SYS-2005-PRTJYUNKBN2
           MOVE    SPA-GMN-PRTJYUN3        TO  SYS-2005-PRTJYUNKBN3
           MOVE    SPA-GMN-MOJI-KISAIKBN   TO  SYS-2005-MOJI-KISAIKBN
           MOVE    SPA-GMN-KYURATE-KISAIKBN
                                           TO  SYS-2005-KYURATE-KISAIKBN
           MOVE    SPA-GMN-RECESYUBETU-KISAIKBN
                                           TO
                                           SYS-2005-RECESYUBETU-KISAIKBN
           MOVE    SYS-2005-REC            TO  SYSKANRI-REC
      *     
           PERFORM 800-MCNDATE-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    SMCNDATE-YMD            TO  SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "tbl_syskanri"          TO  MCP-TABLE
               MOVE    "upd1"                  TO  MCP-PATHNAME
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    SMCNDATE-YMD            TO  SYS-CREYMD
                                                   SYS-UPYMD
               MOVE    SMCNDATE-HMS            TO  SYS-UPHMS
               MOVE    "tbl_syskanri"          TO  MCP-TABLE
               MOVE    "key"                   TO  MCP-PATHNAME
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"                  TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-EXT
           END-IF      
      *
      *    レセプト・総括編集情報（主科設定）
           MOVE    SPACE               TO  SYS-2009-REC
           INITIALIZE                      SYS-2009-REC
           MOVE    "2009"              TO  SYS-2009-KANRICD
           MOVE    "*"                 TO  SYS-2009-KBNCD
           MOVE    SPA-W01-SEL-STYUKYMD
                                       TO  SYS-2009-STYUKYMD
           MOVE    SPA-W01-SEL-EDYUKYMD
                                       TO  SYS-2009-EDYUKYMD
           MOVE    SYS-2009-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  WRK-MCP-TABLE
           MOVE    "key10"             TO  WRK-MCP-PATHNAME
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-2009-REC
           ELSE
               MOVE    SPACE               TO  SYS-2009-REC
               INITIALIZE                      SYS-2009-REC
               MOVE    "2009"              TO  SYS-2009-KANRICD
               MOVE    "*"                 TO  SYS-2009-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD    TO  SYS-2009-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-2009-EDYUKYMD
           MOVE    SPA-GMN-SYUKA-KBN   TO  SYS-2009-SYUKA-KBN
           MOVE    SPA-GMN-SYUKA-NYUIN TO  SYS-2009-SYUKA-NYUIN
           MOVE    SPA-GMN-SYUKA-GAIRAI
                                       TO  SYS-2009-SYUKA-GAIRAI 
           MOVE    SPA-GMN-SYUKA-MODE  TO  SYS-2009-SYUKA-MODE
           MOVE    SPA-GMN-SYUKA-SELECT
                                       TO  SYS-2009-SYUKA-SELECT
           MOVE    SYS-2009-REC        TO  SYSKANRI-REC
      *     
           PERFORM 800-MCNDATE-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    SMCNDATE-YMD        TO  SYS-UPYMD
               MOVE    SMCNDATE-HMS        TO  SYS-UPHMS
               MOVE    SYS-KANRICD         TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD           TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD
                                           TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD
                                           TO  SYSUP-EDYUKYMD
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "upd1"              TO  MCP-PATHNAME
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           ELSE
               MOVE    SMCNDATE-YMD        TO  SYS-CREYMD
                                               SYS-UPYMD
               MOVE    SMCNDATE-HMS        TO  SYS-UPHMS
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               MOVE    "DBINSERT"          TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"                  TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-EXT
           END-IF      
      *
      *    レセプト（編綴順）情報
      *
           MOVE    ZERO                TO  FLG-UPDFLG
      *
      *    項目が未入力で未登録の場合は更新しない 
           IF    ( SPA-GMN-PREFKBN-PRTJYUN =   SPACE )
           AND   ( SPA-GMN-HKNJANUM-PRTJYUN
                                           =   SPACE )
           AND   ( SPA-GMN-RECESYUBETU-PRTJYUN
                                           =   SPACE )
           AND   ( SPA-GMN-ZAITAKU         =   SPACE )
           AND   ( SPA-GMN-CHOUKI          =   SPACE )
           AND   ( SPA-GMN-HKNJANUM-PRTKBN =   SPACE )
           AND   ( SPA-GMN-HKNJANUM        =   SPACE )
           AND   ( SPA-NAI-2008-KBNCD-9    =   ZERO  )
               CONTINUE
           ELSE
      *        項目に変更があった場合
               IF      SPA-NAI-2008-KBNCD-9    >   ZERO
                   MOVE    SPACE               TO  SYS-2008-REC
                   INITIALIZE                      SYS-2008-REC
                   MOVE    "2008"              TO  SYS-2008-KANRICD
                   MOVE    SPA-NAI-2008-KBNCD  TO  SYS-2008-KBNCD
                   MOVE    SPA-W01-SEL-STYUKYMD
                                               TO  SYS-2008-STYUKYMD
                   MOVE    SPA-W01-SEL-EDYUKYMD
                                               TO  SYS-2008-EDYUKYMD
                   MOVE    SYS-2008-REC        TO  MCPDATA-REC
                   MOVE    "tbl_syskanri"      TO  WRK-MCP-TABLE
                   MOVE    "key10"             TO  WRK-MCP-PATHNAME
                   PERFORM 900-SYSKANRI-INV-SEC
                   IF      FLG-SYSKANRI        =   ZERO
                       MOVE    MCPDATA-REC         TO  SYS-2008-REC
      *
                       IF    ( SPA-GMN-PREFKBN-PRTJYUN     =
                                           SYS-2008-PREFKBN-PRTJYUN    )
                       AND   ( SPA-GMN-HKNJANUM-PRTJYUN    =
                                           SYS-2008-HKNJANUM-PRTJYUN   )
                       AND   ( SPA-GMN-RECESYUBETU-PRTJYUN =
                                           SYS-2008-RECESYUBETU-PRTJYUN)
                       AND   ( SPA-GMN-ZAITAKU             =
                                           SYS-2008-ZAITAKU            )
                       AND   ( SPA-GMN-CHOUKI              =
                                           SYS-2008-CHOUKI             )
                       AND   ( SPA-GMN-HKNJANUM-PRTKBN     =
                                           SYS-2008-HKNJANUM-PRTKBN    )
                       AND   ( SPA-GMN-HKNJANUM            =
                                           SYS-2008-HKNJANUM           )
                           CONTINUE
                       ELSE
                           MOVE    1                   TO  FLG-UPDFLG
                       END-IF
                   ELSE
                       MOVE    1                   TO  FLG-UPDFLG
                   END-IF
               ELSE 
                   MOVE    1                   TO  FLG-UPDFLG
               END-IF
      *
               IF      FLG-UPDFLG          =   1    
                   MOVE    SPACE               TO  SYS-2008-REC
                   INITIALIZE                      SYS-2008-REC
                   MOVE    "2008"              TO  SYS-2008-KANRICD
                   MOVE    SPA-NAI-2008-KBNCD-9
                                               TO  WRK-KBNCD-9
                   IF      WRK-KBNCD-9         =   99999999
                       MOVE    1                   TO  WRK-KBNCD-9
                   ELSE
                       ADD     1                   TO  WRK-KBNCD-9
                   END-IF
                   MOVE    WRK-KBNCD           TO  SYS-2008-KBNCD
                   MOVE    SPA-W01-STYUKYMD    TO  SYS-2008-STYUKYMD
                   MOVE    SPA-W01-EDYUKYMD    TO  SYS-2008-EDYUKYMD
                   MOVE    SPA-GMN-PREFKBN-PRTJYUN TO
                                           SYS-2008-PREFKBN-PRTJYUN
                   MOVE    SPA-GMN-HKNJANUM-PRTJYUN
                                               TO
                                           SYS-2008-HKNJANUM-PRTJYUN
                   MOVE    SPA-GMN-RECESYUBETU-PRTJYUN
                                               TO
                                           SYS-2008-RECESYUBETU-PRTJYUN
                   MOVE    SPA-GMN-ZAITAKU     TO  SYS-2008-ZAITAKU
                   MOVE    SPA-GMN-CHOUKI      TO  SYS-2008-CHOUKI 
                   MOVE    SPA-GMN-HKNJANUM-PRTKBN TO
                                           SYS-2008-HKNJANUM-PRTKBN
                   MOVE    SPA-GMN-HKNJANUM    TO  SYS-2008-HKNJANUM 
                   MOVE    SYS-2008-REC        TO  SYSKANRI-REC
      *     
                   PERFORM 800-MCNDATE-SEC
                   MOVE    SMCNDATE-YMD        TO  SYS-CREYMD
                                                   SYS-UPYMD
                   MOVE    SMCNDATE-HMS        TO  SYS-UPHMS
                   MOVE    "tbl_syskanri"      TO  MCP-TABLE
                   MOVE    "key"               TO  MCP-PATHNAME
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    SYSKANRI-REC        TO  MCPDATA-REC
                   CALL    "MONFUNC"           USING
                                               MCPAREA
                                               MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO 
                       MOVE    "1003"              TO  SPA-ERRCD
                       GO  TO  490-KOUSHIN-EXT
                   END-IF
               END-IF
           END-IF          
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       490-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC           SECTION.
      *
      *    レセプト編綴順情報
           IF    ( SPA-GMN-PREFKBN-PRTJYUN =   SPACE )
           AND   ( SPA-GMN-HKNJANUM-PRTJYUN
                                           =   SPACE )
           AND   ( SPA-GMN-RECESYUBETU-PRTJYUN
                                           =   SPACE )
           AND   ( SPA-GMN-ZAITAKU         =   SPACE )
           AND   ( SPA-GMN-CHOUKI          =   SPACE )
           AND   ( SPA-GMN-HKNJANUM-PRTKBN =   SPACE )
           AND   ( SPA-GMN-HKNJANUM        =   SPACE )
               CONTINUE
           ELSE
      *        印刷順指定が全て入力されているか  
               IF    ( SPA-GMN-PREFKBN-PRTJYUN =   SPACE )
               OR    ( SPA-GMN-HKNJANUM-PRTJYUN
                                               =   SPACE )
               OR   ( SPA-GMN-RECESYUBETU-PRTJYUN
                                               =   SPACE )
                   MOVE    70                  TO  SPA-GMN-CUR
                   MOVE    "0097"              TO  SPA-ERRCD
               END-IF
      *        医療機関の所在地保険者と所在地保険者印刷位置
               IF      SPA-ERRCD               =   SPACE  
                   IF    ( SPA-GMN-HKNJANUM-PRTKBN
                                               NOT =   SPACE )
                   AND   ( SPA-GMN-HKNJANUM        =   SPACE )
                       MOVE    75                  TO  SPA-GMN-CUR
                       MOVE    "0098"              TO  SPA-ERRCD
                   END-IF
               END-IF
           END-IF
      *
      *    印刷順（国保）と編綴順設定の関連チェック
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-GMN-PRTJYUN3    =   "06"
                   IF    ( SPA-GMN-PREFKBN-PRTJYUN =   SPACE )
                   OR    ( SPA-GMN-HKNJANUM-PRTJYUN
                                                   =   SPACE )
                   OR   ( SPA-GMN-RECESYUBETU-PRTJYUN
                                                   =   SPACE )
                       MOVE    70                  TO  SPA-GMN-CUR
                       MOVE    "0096"              TO  SPA-ERRCD
                   END-IF
               END-IF
           END-IF                         
      *
      *    レセプト・総括編集情報（主科設定）
           IF      SPA-ERRCD           =   SPACE
               IF    ( SPA-GMN-SYUKA-KBN       =   ZERO  )
               AND   ( SPA-GMN-SYUKA-NYUIN     =   SPACE )
               AND   ( SPA-GMN-SYUKA-GAIRAI    =   SPACE )
               AND   ( SPA-GMN-SYUKA-MODE      =   SPACE )
               AND   ( SPA-GMN-SYUKA-SELECT    =   SPACE )
                   CONTINUE
               ELSE
                   IF    ( SPA-GMN-SYUKA-KBN       =   ZERO )
                       IF    ( SPA-GMN-SYUKA-NYUIN     =   SPACE )
                       AND   ( SPA-GMN-SYUKA-GAIRAI    =   SPACE )
                       AND   ( SPA-GMN-SYUKA-MODE      =   SPACE )
                       AND   ( SPA-GMN-SYUKA-SELECT    =   SPACE )
                           CONTINUE
                       ELSE
                           MOVE    91                  TO  SPA-GMN-CUR
                           MOVE    "0100"              TO  SPA-ERRCD
                       END-IF
                   ELSE
                       IF   ( SPA-GMN-SYUKA-GAIRAI     =   SPACE )
                       OR   ( SPA-GMN-SYUKA-MODE       =   SPACE )
                       OR   ( SPA-GMN-SYUKA-SELECT     =   SPACE )
                           MOVE    91                  TO  SPA-GMN-CUR
                           MOVE    "0099"              TO  SPA-ERRCD
                       END-IF
                       IF    ( SPA-BEDSU               >   ZERO  )
                       AND   ( SPA-GMN-SYUKA-NYUIN     =   SPACE )
                           MOVE    91                  TO  SPA-GMN-CUR
                           MOVE    "0099"              TO  SPA-ERRCD
                       END-IF
                   END-IF
               END-IF
           END-IF    
      *    
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
           PERFORM 510-GSRAUTH-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-WIDCD       NOT =   SPACE
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W12    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPA-GMN-HSTYUKYMD        TO  W12-YUKOSTYMD
           MOVE    SPA-GMN-HEDYUKYMD        TO  W12-YUKOEDYMD
      *
           MOVE    SPA-GMN-BYOMEIHENKBN-G   TO  W12-BYOMEIHENKBN
           MOVE    SPA-GMN-BYOMEIHENKBN1-G  TO  W12-BYOMEIHENKBN1
           MOVE    SPA-GMN-SYUBYOHENFLG-G   TO  W12-SYUBYOHENFLG
           MOVE    SPA-GMN-TENKIHENKBN-G    TO  W12-TENKIHENKBN
           MOVE    SPA-GMN-KKHRECEKBN-G     TO  W12-KKHRECEKBN
           MOVE    SPA-GMN-SYARECEKBN-G     TO  W12-SYARECEKBN
           MOVE    SPA-GMN-SYAOCRKBN-G      TO  W12-SYAOCRKBN
           MOVE    SPA-GMN-KKHOCRKBN-G      TO  W12-KKHOCRKBN
           MOVE    SPA-GMN-KKHPRTKBN-G      TO  W12-KKHPRTKBN
           MOVE    SPA-GMN-RENNUMHENKBN-G   TO  W12-RENNUMHENKBN
           MOVE    SPA-GMN-NEXTPRTKBN-G     TO  W12-NEXTPRTKBN
           MOVE    SPA-GMN-NEXTPRTKBN1-G    TO  W12-NEXTPRTKBN1
           MOVE    SPA-GMN-RJNGNBKKBN-G     TO  W12-RJNGNBKKBN
           MOVE    SPA-GMN-JIHITEKKSIKBN-G  TO  W12-JIHITEKKSIKBN
           MOVE    SPA-GMN-RECECOMKBN-G     TO  W12-RECECOMKBN
           MOVE    SPA-GMN-SRYKAHENKBN-G    TO  W12-SRYKAHENKBN
           MOVE    SPA-GMN-AUTODSPKBN-G     TO  W12-AUTODSPKBN
           MOVE    SPA-GMN-PRTJYUN1-G       TO  W12-PRTJYUNKBN1
           MOVE    SPA-GMN-PRTJYUN2-G       TO  W12-PRTJYUNKBN2
           MOVE    SPA-GMN-PRTJYUN3-G       TO  W12-PRTJYUNKBN3
           MOVE    SPA-GMN-MOJI-KISAIKBN-G  TO  W12-MOJI-KISAIKBN
           MOVE    SPA-GMN-KYURATE-KISAIKBN-G
                                            TO  W12-KYURATE-KISAIKBN
           MOVE    SPA-GMN-RECESYUBETU-KISAIKBN-G
                                            TO  W12-RECESYUBETU-KISAIKBN
           MOVE    SPA-GMN-PREFKBN-PRTJYUN-G
                                            TO  W12-PREFKBN-PRTJYUN
           MOVE    SPA-GMN-HKNJANUM-PRTJYUN-G
                                            TO  W12-HKNJANUM-PRTJYUN
           MOVE    SPA-GMN-RECESYUBETU-PRTJYUN-G
                                            TO  W12-RECESYUBETU-PRTJYUN
           MOVE    SPA-GMN-ZAITAKU-G        TO  W12-ZAITAKU
           MOVE    SPA-GMN-CHOUKI-G
                                            TO  W12-CHOUKI
           MOVE    SPA-GMN-HKNJANUM         TO  W12-HKNJANUM
           MOVE    SPA-GMN-HKNJANAME        TO  W12-HKNJANAME
           MOVE    SPA-GMN-HKNJANUM-PRTKBN-G
                                            TO  W12-HKNJANUM-PRTKBN
           MOVE    SPA-GMN-SYUKA-KBN-G      TO  W12-SYUKA-KBN
           MOVE    SPA-GMN-SYUKA-NYUIN-G    TO  W12-SYUKA-NYUIN
           MOVE    SPA-GMN-SYUKA-GAIRAI-G   TO  W12-SYUKA-GAIRAI
           MOVE    SPA-GMN-SYUKA-MODE-G     TO  W12-SYUKA-MODE
           MOVE    SPA-GMN-SYUKA-SELECT-G   TO  W12-SYUKA-SELECT
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-BYOMEIHENKBN-MAX
               MOVE    SPA-GMN-BYOMEIHENKBNLST (IDY)
                                       TO  W12-BYOMEIHENKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-BYOMEIHENKBN-MAX
                                       TO  W12-BYOMEIHENKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-BYOMEIHENKBN1-MAX
               MOVE    SPA-GMN-BYOMEIHENKBN1LST (IDY)
                                       TO  W12-BYOMEIHENKBN1LST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-BYOMEIHENKBN1-MAX
                                       TO  W12-BYOMEIHENKBN1-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SYUBYOHENFLG-MAX
               MOVE    SPA-GMN-SYUBYOHENFLGLST (IDY)
                                       TO  W12-SYUBYOHENFLGLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYUBYOHENFLG-MAX
                                       TO  W12-SYUBYOHENFLG-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-TENKIHENKBN-MAX
               MOVE    SPA-GMN-TENKIHENKBNLST (IDY)
                                       TO  W12-TENKIHENKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-TENKIHENKBN-MAX
                                       TO  W12-TENKIHENKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-KKHRECEKBN-MAX
               MOVE    SPA-GMN-KKHRECEKBNLST (IDY)
                                       TO  W12-KKHRECEKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-KKHRECEKBN-MAX
                                       TO  W12-KKHRECEKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SYARECEKBN-MAX
               MOVE    SPA-GMN-SYARECEKBNLST (IDY)
                                       TO  W12-SYARECEKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYARECEKBN-MAX
                                       TO  W12-SYARECEKBN-COUNT 
      *
           MOVE    SPA-GMN-RECEDENOUT  TO  W12-RECEDENOUT
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SYAOCRKBN-MAX
               MOVE    SPA-GMN-SYAOCRKBNLST (IDY)
                                       TO  W12-SYAOCRKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYAOCRKBN-MAX
                                       TO  W12-SYAOCRKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-KKHOCRKBN-MAX
               MOVE    SPA-GMN-KKHOCRKBNLST (IDY)
                                       TO  W12-KKHOCRKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-KKHOCRKBN-MAX
                                       TO  W12-KKHOCRKBN-COUNT 
      *
           MOVE    SPA-GMN-PREFPRGID   TO  W12-PREFPRGID
           MOVE    SPA-GMN-PREFPRGID1  TO  W12-PREFPRGID1
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-KKHPRTKBN-MAX
               MOVE    SPA-GMN-KKHPRTKBNLST (IDY)
                                       TO  W12-KKHPRTKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-KKHPRTKBN-MAX
                                       TO  W12-KKHPRTKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-RENNUMHENKBN-MAX
               MOVE    SPA-GMN-RENNUMHENKBNLST (IDY)
                                       TO  W12-RENNUMHENKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-RENNUMHENKBN-MAX
                                       TO  W12-RENNUMHENKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-NEXTPRTKBN-MAX
               MOVE    SPA-GMN-NEXTPRTKBNLST (IDY)
                                       TO  W12-NEXTPRTKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-NEXTPRTKBN-MAX
                                       TO  W12-NEXTPRTKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-NEXTPRTKBN1-MAX
               MOVE    SPA-GMN-NEXTPRTKBN1LST (IDY)
                                       TO  W12-NEXTPRTKBN1LST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-NEXTPRTKBN1-MAX
                                       TO  W12-NEXTPRTKBN1-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-RJNGNBKKBN-MAX
               MOVE    SPA-GMN-RJNGNBKKBNLST (IDY)
                                       TO  W12-RJNGNBKKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-RJNGNBKKBN-MAX
                                       TO  W12-RJNGNBKKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-JIHITEKKSIKBN-MAX
               MOVE    SPA-GMN-JIHITEKKSIKBNLST (IDY)
                                       TO  W12-JIHITEKKSIKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-JIHITEKKSIKBN-MAX
                                       TO  W12-JIHITEKKSIKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-RECECOMKBN-MAX
               MOVE    SPA-GMN-RECECOMKBNLST (IDY)
                                       TO  W12-RECECOMKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-RECECOMKBN-MAX
                                       TO  W12-RECECOMKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SRYKAHENKBN-MAX
               MOVE    SPA-GMN-SRYKAHENKBNLST (IDY)
                                       TO  W12-SRYKAHENKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SRYKAHENKBN-MAX
                                       TO  W12-SRYKAHENKBN-COUNT 
      *
           MOVE    SPA-GMN-SYAPRTNM    TO  W12-SYAPRTNM
      *
           MOVE    SPA-GMN-SYAPRTNM-NEXT
                                       TO  W12-SYAPRTNM-NEXT
      *
           MOVE    SPA-GMN-KKHPRTNM    TO  W12-KKHPRTNM 
      *
           MOVE    SPA-GMN-KKHPRTNM-NEXT
                                       TO  W12-KKHPRTNM-NEXT 
      *
           MOVE    SPA-GMN-SYAPRTNM-N  TO  W12-SYAPRTNM-N
      *
           MOVE    SPA-GMN-SYAPRTNM-NEXT-N
                                       TO  W12-SYAPRTNM-NEXT-N
      *
           MOVE    SPA-GMN-KKHPRTNM-N  TO  W12-KKHPRTNM-N
      *
           MOVE    SPA-GMN-KKHPRTNM-NEXT-N
                                       TO  W12-KKHPRTNM-NEXT-N
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-AUTODSPKBN-MAX
               MOVE    SPA-GMN-AUTODSPKBNLST (IDY)
                                       TO  W12-AUTODSPKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-AUTODSPKBN-MAX
                                       TO  W12-AUTODSPKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-PRTJYUN1-MAX
               MOVE    SPA-GMN-PRTJYUN1LST (IDY)
                                       TO  W12-PRTJYUNKBN1LST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-PRTJYUN1-MAX
                                       TO  W12-PRTJYUNKBN1-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-PRTJYUN3-MAX
               MOVE    SPA-GMN-PRTJYUN3LST (IDY)
                                       TO  W12-PRTJYUNKBN3LST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-PRTJYUN3-MAX
                                       TO  W12-PRTJYUNKBN3-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-PRTJYUN2-MAX
               MOVE    SPA-GMN-PRTJYUN2LST (IDY)
                                       TO  W12-PRTJYUNKBN2LST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-PRTJYUN2-MAX
                                       TO  W12-PRTJYUNKBN2-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-MOJI-KISAIKBN-MAX
               MOVE    SPA-GMN-MOJI-KISAIKBNLST (IDY)
                                       TO  W12-MOJI-KISAIKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-MOJI-KISAIKBN-MAX
                                       TO  W12-MOJI-KISAIKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-KYURATE-KISAIKBN-MAX
               MOVE    SPA-GMN-KYURATE-KISAIKBNLST (IDY)
                                       TO  W12-KYURATE-KISAIKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-KYURATE-KISAIKBN-MAX
                                       TO  W12-KYURATE-KISAIKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >   SPA-GMN-RECESYUBETU-KISAIKBN-MAX
               MOVE    SPA-GMN-RECESYUBETU-KISAIKBNLST (IDY)
                                       TO
                                       W12-RECESYUBETU-KISAIKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-RECESYUBETU-KISAIKBN-MAX
                                       TO
                                       W12-RECESYUBETU-KISAIKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-PREFKBN-PRTJYUN-MAX
               MOVE    SPA-GMN-PREFKBN-PRTJYUNLST (IDY)
                                       TO  W12-PREFKBN-PRTJYUNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-PREFKBN-PRTJYUN-MAX
                                       TO  W12-PREFKBN-PRTJYUN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-HKNJANUM-PRTJYUN-MAX
               MOVE    SPA-GMN-HKNJANUM-PRTJYUNLST (IDY)
                                       TO  W12-HKNJANUM-PRTJYUNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-HKNJANUM-PRTJYUN-MAX
                                       TO  W12-HKNJANUM-PRTJYUN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >   SPA-GMN-RECESYUBETU-PRTJYUN-MAX
               MOVE    SPA-GMN-RECESYUBETU-PRTJYUNLST (IDY)
                                       TO
                                       W12-RECESYUBETU-PRTJYUNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-RECESYUBETU-PRTJYUN-MAX
                                       TO
                                       W12-RECESYUBETU-PRTJYUN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-ZAITAKU-MAX
               MOVE    SPA-GMN-ZAITAKULST (IDY)
                                       TO  W12-ZAITAKULST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-ZAITAKU-MAX TO  W12-ZAITAKU-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-CHOUKI-MAX
               MOVE    SPA-GMN-CHOUKILST (IDY)
                                       TO  W12-CHOUKILST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-CHOUKI-MAX  TO  W12-CHOUKI-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >   SPA-GMN-HKNJANUM-PRTKBN-MAX
               MOVE    SPA-GMN-HKNJANUM-PRTKBNLST (IDY)
                                       TO
                                       W12-HKNJANUM-PRTKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-HKNJANUM-PRTKBN-MAX
                                       TO
                                       W12-HKNJANUM-PRTKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >   SPA-GMN-SYUKA-KBN-MAX
               MOVE    SPA-GMN-SYUKA-KBNLST (IDY)
                                           TO  W12-SYUKA-KBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYUKA-KBN-MAX   TO  W12-SYUKA-KBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SYUKA-NYUIN-MAX
               MOVE    SPA-GMN-SYUKA-NYUINLST (IDY)
                                           TO  W12-SYUKA-NYUINLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYUKA-NYUIN-MAX TO  W12-SYUKA-NYUIN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SYUKA-GAIRAI-MAX
               MOVE    SPA-GMN-SYUKA-GAIRAILST (IDY)
                                           TO  W12-SYUKA-GAIRAILST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYUKA-GAIRAI-MAX
                                           TO  W12-SYUKA-GAIRAI-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >   SPA-GMN-SYUKA-MODE-MAX
               MOVE    SPA-GMN-SYUKA-MODELST (IDY)
                                           TO  W12-SYUKA-MODELST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYUKA-MODE-MAX  TO  W12-SYUKA-MODE-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >   SPA-GMN-SYUKA-SELECT-MAX
               MOVE    SPA-GMN-SYUKA-SELECTLST (IDY)
                                           TO  W12-SYUKA-SELECTLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYUKA-SELECT-MAX
                                           TO  W12-SYUKA-SELECT-COUNT 
     *
           IF      SPA-BEDSU       >   ZERO
               MOVE    WIDGET-NORMAL       TO  W12-PREFPRGID1-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE  TO  W12-PREFPRGID1-STATE
           END-IF
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    業務権限非活性処理
      *****************************************************************
       510-GSRAUTH-SEC             SECTION.
      *
           .
       51O-GSRAUTH-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "傷病名編集区分入力エラー"    TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "国保レセ電出力区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "社保レセ電出力区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "国保ＯＣＲ出力区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "国保診療報酬請求書区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE
                       "県単用プログラム名の一桁目はＳで入力して下さい"
                                                         TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "転帰日編集区分入力エラー"    TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "通し番号編集区分入力エラー"  TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "続紙区分入力エラー"          TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "主病名編集フラグ入力エラー"  TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "老人と原爆区分入力エラー"    TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "自費レセ摘要欄記載区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE
                       "レセプトコメント（症状詳記）記録区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0014"
                   MOVE    "診療科編集区分入力エラー"    TO  SPA-ERRMSG
               WHEN    "0015"
                   MOVE    "自動遷移区分入力エラー"      TO  SPA-ERRMSG
               WHEN    "0016"
                   MOVE    "一括作成出力順（社保）入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0017"
                   MOVE    "個別作成出力順入力エラー"    TO  SPA-ERRMSG
               WHEN    "0018"
                   MOVE    "「特別療養費」文字記載位置入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0019"
                   MOVE    "給付割合欄記載区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0020"
                   MOVE    "レセプト種別欄記載区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0021"
                   MOVE    "印刷順指定・県内県外入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0022"
                   MOVE    "印刷順指定・保険者入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0023"
                   MOVE    "印刷順指定・レセプト種別入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0024"
                   MOVE    "在総診入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0025"
                   MOVE    "長期（長期高額療養費）入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0026"
                   MOVE    "所在地保険者番号入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0027"
                   MOVE    "所在地保険者印刷位置入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0028"
                   MOVE    "一括作成出力順（国保）入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0029"
                   MOVE    "所在地保険者は県内の保険者を入力して下さい"
                                                         TO  SPA-ERRMSG
               WHEN    "0030"
                   MOVE    "主科実施の有無入力エラー"    TO  SPA-ERRMSG
               WHEN    "0031"
                   MOVE    "主科設定情報（入院）入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0032"
                   MOVE    "主科設定情報（入院外）入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0033"
                   MOVE    "主科情報取得入力エラー"      TO  SPA-ERRMSG
               WHEN    "0034"
                   MOVE    "複数科同一選択入力エラー"    TO  SPA-ERRMSG
      *
               WHEN    "0096"
                   STRING  "一括作成出力順（国保）の指定が編綴順です。"
                                               DELIMITED  BY  SIZE
                           "編綴順の設定を行って下さい"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0097"
                   MOVE    "印刷順に未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "0098"
                   STRING
                       "医療機関の所在地保険者印刷位置を選択して"
                                               DELIMITED  BY  SIZE
                       "あるのに所在地保険者が未入力です"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "0100"
                   MOVE
                   "主科対応をしないときに設定されている項目があります"
                                               TO  SPA-ERRMSG
      *
               WHEN    "1003"
                   MOVE    "更新ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W12"                TO  SPA-MOTOPG
           MOVE    "WERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-WIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-WIDMSG
      *
           EVALUATE    SPA-WIDCD
               WHEN    "1001"
                   MOVE    "レセプト印刷情報を登録します"
                                                TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W12"                TO  SPA-MOTOPG
           MOVE    "WID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-WIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理    
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
          IF      SPA-GMN-CUR          =   ZERO
               PERFORM 50011-CUR-SET-SEC
          END-IF
      *
          EVALUATE    SPA-GMN-CUR
                WHEN    1
                    MOVE  "BYOMEIHENKBN"     TO   MCP-WIDGET
                WHEN    2
                    MOVE  "BYOMEIHENKBN1"    TO   MCP-WIDGET
                WHEN    3
                    MOVE  "TENKIHENKBN"      TO   MCP-WIDGET
                WHEN    4
                    MOVE  "SYARECEKBN"       TO   MCP-WIDGET
                WHEN    5
                    MOVE  "KKHRECEKBN"       TO   MCP-WIDGET
                WHEN    6
                    MOVE  "RECEDENOUT"       TO   MCP-WIDGET
                WHEN    7
                    MOVE  "KKHOCRKBN"        TO   MCP-WIDGET
                WHEN    8
                    MOVE  "PREFPRGID"        TO   MCP-WIDGET
                WHEN    9
                    MOVE  "SYAPRTNM"         TO   MCP-WIDGET
                WHEN    10
                    MOVE  "KKHPRTNM"         TO   MCP-WIDGET
                WHEN    11
                    MOVE  "KKHPRTKBN"        TO   MCP-WIDGET
                WHEN    12
                    MOVE  "RENNUMHENKBN"     TO   MCP-WIDGET
                WHEN    13
                    MOVE  "PREFPRGID1"       TO   MCP-WIDGET
                WHEN    16
                    MOVE  "NEXTPRTKBN_1"     TO   MCP-WIDGET
                WHEN    14
                    MOVE  "NEXTPRTKBN"       TO   MCP-WIDGET
                WHEN    15
                    MOVE  "SYUBYOHENFLG"     TO   MCP-WIDGET
                WHEN    17
                    MOVE  "SYAPRTNM_NEXT"    TO   MCP-WIDGET
                WHEN    18
                    MOVE  "KKHPRTNM_NEXT"    TO   MCP-WIDGET
                WHEN    19
                    MOVE  "RJNGNBKKBN"       TO   MCP-WIDGET
                WHEN    20
                    MOVE  "JIHITEKKSIKBN"    TO   MCP-WIDGET
                WHEN    21
                    MOVE  "SYAOCRKBN"        TO   MCP-WIDGET
                WHEN    22
                    MOVE  "RECECOMKBN"       TO   MCP-WIDGET
                WHEN    23
                    MOVE  "SRYKAHENKBN"      TO   MCP-WIDGET
                WHEN    24
                    MOVE  "SYAPRTNM_N"       TO   MCP-WIDGET
                WHEN    25
                    MOVE  "SYAPRTNM_NEXT_N"  TO   MCP-WIDGET
                WHEN    26
                    MOVE  "KKHPRTNM_N"       TO   MCP-WIDGET
                WHEN    27
                    MOVE  "KKHPRTNM_NEXT_N"  TO   MCP-WIDGET
                WHEN    28
                    MOVE  "AUTODSPKBN"       TO   MCP-WIDGET
                WHEN    29
                    MOVE  "PRTJYUNKBN1"      TO   MCP-WIDGET
                WHEN    31
                    MOVE  "PRTJYUNKBN3"      TO   MCP-WIDGET
                WHEN    30
                    MOVE  "PRTJYUNKBN2"      TO   MCP-WIDGET
      *
                WHEN    50
                    MOVE  "MOJI_KISAIKBN"    TO   MCP-WIDGET
                WHEN    51
                    MOVE  "KYURATE_KISAIKBN" TO   MCP-WIDGET
                WHEN    52
                    MOVE  "RECESYUBETU_KISAIKBN"
                                             TO   MCP-WIDGET
      *
                WHEN    70
                    MOVE  "PR_PRTJYUN"       TO   MCP-WIDGET
                WHEN    71
                    MOVE  "HKN_PRTJYUN"      TO   MCP-WIDGET
                WHEN    72
                    MOVE  "REC_PRTJYUN"      TO   MCP-WIDGET
                WHEN    73
                    MOVE  "ZAITAKU"          TO   MCP-WIDGET
                WHEN    74
                    MOVE  "CHOUKI"           TO   MCP-WIDGET
                WHEN    75
                    MOVE  "HKNJANUM"         TO   MCP-WIDGET
                WHEN    76
                    MOVE  "HKNJ_PRTKBN"      TO   MCP-WIDGET
      *
                WHEN    90
                    MOVE  "SYUKA_KBN"        TO   MCP-WIDGET
                WHEN    91
                    MOVE  "SYUKA_NYUIN"      TO   MCP-WIDGET
                WHEN    92
                    MOVE  "SYUKA_GAIRAI"     TO   MCP-WIDGET
                WHEN    93
                    MOVE  "SYUKA_SELECT"     TO   MCP-WIDGET
                WHEN    94
                    MOVE  "SYUKA_MODE"       TO   MCP-WIDGET
      *
                WHEN    99
                    MOVE  "B12"              TO   MCP-WIDGET
            END-EVALUATE
      *
            EVALUATE    SPA-GMN-CUR
                WHEN    1   THRU    10
                WHEN    12  THRU    31
                    MOVE    0                TO  W12-PAGENO
                WHEN    70  THRU    79
                    MOVE    1                TO  W12-PAGENO
                WHEN    50  THRU    52
                    MOVE    2                TO  W12-PAGENO
                WHEN    11
                    MOVE    3                TO  W12-PAGENO
                WHEN    90  THRU    98
                    MOVE    4                TO  W12-PAGENO
      **********WHEN    99
      **********    MOVE    SPA-W12-PAGENO   TO  W12-PAGENO
            END-EVALUATE
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル編集処理
      *****************************************************************
       50011-CUR-SET-SEC         SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "BYOMEIHENKBN"
                   MOVE    2           TO  SPA-GMN-CUR
               WHEN    "BYOMEIHENKBN1"
                   MOVE    15          TO  SPA-GMN-CUR
               WHEN    "SYUBYOHENFLG"
                   MOVE    3           TO  SPA-GMN-CUR
               WHEN    "TENKIHENKBN"
                   MOVE    4           TO  SPA-GMN-CUR
               WHEN    "SYARECEKBN"
                   MOVE    5           TO  SPA-GMN-CUR
               WHEN    "KKHRECEKBN"
                   MOVE    6           TO  SPA-GMN-CUR
               WHEN    "RECEDENOUT"
                   MOVE    22          TO  SPA-GMN-CUR
               WHEN    "RECECOMKBN"
                   MOVE    21          TO  SPA-GMN-CUR
               WHEN    "SYAOCRKBN"
                   MOVE    7           TO  SPA-GMN-CUR
               WHEN    "KKHOCRKBN"
                   MOVE    8           TO  SPA-GMN-CUR
               WHEN    "PREFPRGID"
                   IF      SPA-BEDSU       >   ZERO
                       MOVE    13          TO  SPA-GMN-CUR
                   ELSE
                       MOVE    12          TO  SPA-GMN-CUR
                   END-IF
               WHEN    "PREFPRGID1"
                   MOVE    12          TO  SPA-GMN-CUR
               WHEN    "SYAPRTNM"
                   MOVE    17          TO  SPA-GMN-CUR
               WHEN    "SYAPRTNM_NEXT"
                   MOVE    10          TO  SPA-GMN-CUR
               WHEN    "KKHPRTNM"
                   MOVE    18          TO  SPA-GMN-CUR
               WHEN    "KKHPRTNM_NEXT"
                   MOVE    16          TO  SPA-GMN-CUR
               WHEN    "RENNUMHENKBN"
                   MOVE    9           TO  SPA-GMN-CUR
               WHEN    "NEXTPRTKBN_1"
                   MOVE    24          TO  SPA-GMN-CUR
               WHEN    "NEXTPRTKBN"
                   MOVE    19          TO  SPA-GMN-CUR
               WHEN    "RJNGNBKKBN"
                   MOVE    20          TO  SPA-GMN-CUR
               WHEN    "JIHITEKKSIKBN"
                   MOVE    23          TO  SPA-GMN-CUR
               WHEN    "SRYKAHENKBN"
                   MOVE    28          TO  SPA-GMN-CUR
               WHEN    "AUTODSPKBN"
                   MOVE    29          TO  SPA-GMN-CUR
               WHEN    "PRTJYUNKBN1"
                   MOVE    31          TO  SPA-GMN-CUR
               WHEN    "PRTJYUNKBN3"
                   MOVE    30          TO  SPA-GMN-CUR
               WHEN    "PRTJYUNKBN2"
                   MOVE    99          TO  SPA-GMN-CUR
               WHEN    "SYAPRTNM_N"
                   MOVE    25          TO  SPA-GMN-CUR
               WHEN    "SYAPRTNM_NEXT_N"
                   MOVE    26          TO  SPA-GMN-CUR
               WHEN    "KKHPRTNM_N"
                   MOVE    27          TO  SPA-GMN-CUR
               WHEN    "KKHPRTNM_NEXT_N"
                   MOVE    14          TO  SPA-GMN-CUR
      *
               WHEN    "MOJI_KISAIKBN"
                   MOVE    51          TO  SPA-GMN-CUR
               WHEN    "KYURATE_KISAIKBN"
                   MOVE    52          TO  SPA-GMN-CUR
               WHEN    "RECESYUBETU_KISAIKBN"
                   MOVE    99          TO  SPA-GMN-CUR
      *
               WHEN    "PR_PRTJYUN"
                   MOVE    71          TO  SPA-GMN-CUR
               WHEN    "HKN_PRTJYUN"
                   MOVE    72          TO  SPA-GMN-CUR
               WHEN    "REC_PRTJYUN"
                   MOVE    73          TO  SPA-GMN-CUR
               WHEN    "ZAITAKU"
                   MOVE    74          TO  SPA-GMN-CUR
               WHEN    "CHOUKI"
                   MOVE    75          TO  SPA-GMN-CUR
               WHEN    "HKNJANUM"
                   IF      SPA-GMN-HKNJANUM    =   SPACE
                       MOVE    99          TO  SPA-GMN-CUR
                   ELSE
                       MOVE    76          TO  SPA-GMN-CUR
                   END-IF
               WHEN    "HKNJ_PRTKBN"
                   MOVE    99          TO  SPA-GMN-CUR
      *
               WHEN    "SYUKA_KBN"
                   MOVE    91          TO  SPA-GMN-CUR
               WHEN    "SYUKA_NYUIN"
                   MOVE    92          TO  SPA-GMN-CUR
               WHEN    "SYUKA_GAIRAI"
                   MOVE    93          TO  SPA-GMN-CUR
               WHEN    "SYUKA_SELECT"
                   MOVE    94          TO  SPA-GMN-CUR
               WHEN    "SYUKA_MODE"
                   MOVE    99          TO  SPA-GMN-CUR
      *
               WHEN    "KKHPRTKBN"
                   MOVE    99          TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
       50011-CUR-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
               MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
               MOVE    "DBFETCH"           TO  MCP-FUNC
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者マスター読込（キー）
      *****************************************************************
       900-HKNJAINF-READ-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_hknjainf"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "tbl_hknjainf"      TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNJAINF
                   MOVE    MCPDATA-REC         TO  HKNJAINF-REC
               ELSE
                   MOVE    1                   TO  FLG-HKNJAINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNJAINF
           END-IF
      *
           MOVE    "tbl_hknjainf"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-HKNJAINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
      *
           .
       900-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
