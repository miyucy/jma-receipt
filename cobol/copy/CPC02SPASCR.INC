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
      *****************************************************************
      *
      *    病名登録 画面ＳＰＡ 
      *            画面　Ｃ０２で使用 
      *          
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/06/06  保険病名フラグの追加
      *  01.02.01    MCC-藤原     01/08/27  画面修正による項目の修正            
      *  01.03.01    MCC-藤原     01/12/06  自院病名マスタの追加     
      *****************************************************************
      *
      *01  SPA-SCR-REC.
      *
           03  SPA-GMN-C02-TBL.
               05  SPA-GMN-C02-TBLO            OCCURS   200.
                   07  SPA-GMN-C02-TBANGO      PIC 9(03).
                   07  SPA-GMN-C02-TSRYYMD     PIC X(09).
                   07  SPA-GMN-C02-TSRYNENGOH  PIC X(04).
                   07  SPA-GMN-C02-TBYOMEI     PIC X(81).
                   07  SPA-GMN-C02-TUTAGAIFLG  PIC X(14).
                   07  SPA-GMN-C02-TSYUBYOFLG  PIC X(12).
                   07  SPA-GMN-C02-TMANSEIKBN  PIC X(42).
                   07  SPA-GMN-C02-TNYUGAIKBN  PIC X(06).
                   07  SPA-GMN-C02-THKNCOMBI   PIC X(40).
                   07  SPA-GMN-C02-TREZEFLG    PIC X(10).
                   07  SPA-GMN-C02-TREZEMM     PIC 9(02).
                   07  SPA-GMN-C02-TTENKIKBN   PIC X(04).
                   07  SPA-GMN-C02-TTENKIYMD   PIC X(09).
                   07  SPA-GMN-C02-TTENKINENGOH
                                               PIC X(04).
      *----(01.00.01) LINE ADD START ----------------------------------
                   07  SPA-GMN-C02-THKNBYOMEIFLG
                                               PIC X(08).
      *----(01.00.01) LINE ADD END   ----------------------------------
      * 
           03  SPA-NAI-C02-TBL.
               05  SPA-NAI-C02-TBLO            OCCURS   200.
                   07  SPA-NAI-C02-TKEY.
                       09  SPA-NAI-C02-TSRYYMD  PIC X(08).
                       09  SPA-NAI-C02-TRENNUM  PIC 9(02).
                   07  SPA-NAI-C02-TBYOMEIHENFLG
                                                PIC X(01).
                   07  SPA-NAI-C02-TBYOMEICD-G.
                       09  SPA-NAI-C02-TBYOMEICD
      *****************                         PIC X(05).
                                                PIC X(10)  OCCURS  6.
                   07  SPA-NAI-C02-TBYOMEIINPUTCD
                                                PIC X(20).
                   07  SPA-NAI-C02-TBYOMEICDSU  PIC 9(01).                                                           
                   07  SPA-NAI-C02-TTENKIYMD    PIC X(08).
                   07  SPA-NAI-C02-TUTAGAIFLG   PIC X(01).
                   07  SPA-NAI-C02-TSYUBYOFLG   PIC X(01).
                   07  SPA-NAI-C02-TMANSEIKBN   PIC 9(02).
                   07  SPA-NAI-C02-TNYUGAIKBN   PIC X(01).
                   07  SPA-NAI-C02-THKNCOMBI    PIC 9(04).
                   07  SPA-NAI-C02-TREZEFLG     PIC X(01).
                   07  SPA-NAI-C02-TTENKIKBN    PIC X(01).
                   07  SPA-NAI-C02-THKNBYOMEIFLG
                                                PIC X(01).
                   07  SPA-NAI-C02-TBYOMEIMOJI  PIC 9(02).
                   07  SPA-NAI-C02-TCHARTBYOMEI PIC X(480).
                   07  SPA-NAI-C02-TCHARTBYOMEIMOJI
                                                PIC 9(02). 
                   07  SPA-NAI-C02-TUPDFLG      PIC 9(01).
      *
           03  SPA-DEL-TBL.
               05  SPA-DEL-TBLO                 OCCURS   200.
                   07  SPA-DEL-TRENNUM          PIC 9(02).
                   07  SPA-DEL-TSRYYMD          PIC X(08).
                   
