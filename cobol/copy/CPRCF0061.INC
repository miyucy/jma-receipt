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
      ************************************************************
      *    レセプト明細書     COPY (CPRCF061.INC)       *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.06.29  保険者番号・
      *                                     適用開始年月日の追加
      *                                     KEYが長すぎるので医療機関ＩＤ・
      *                                     診療年月を削除
      *  01.00.02    NACL-藤原    02.11.07  医療機関ＩＤ・診療年月を追加
      *  01.00.03    NACL-藤原    03/03/12  補助区分の追加
      ************************************************************
      *01  RECE061-REC.
           03  RECE061-KEY.
      *医療機関ＩＤ
               05  RECE061-HOSPID          PIC  X(24).
      *診療年月
               05  RECE061-SRYYM           PIC  9(06).
      *入外区分
               05  RECE061-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE061-PTID            PIC  9(10).
      *レセプト科
               05  RECE061-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE061-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE061-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE061-HKNJANUM        PIC  X(08).
      *補助区分
               05  RECE061-HOJOKBN         PIC  X(01).
      *適用開始年月日
               05  RECE061-TEKSTYMD        PIC  X(08). 
      *公費分離区分
               05  RECE061-KOHBUNRI        PIC  9(01).
      *診療区分
               05  RECE061-SRYKBN          PIC  X(02).
      *検査実施区分
               05  RECE061-KNSJISKBN       PIC  9(01).
      *表用番号
               05  RECE061-CDKBN-SYO           PIC  9(01).
               05  RECE061-CDKBN-BU            PIC  9(02).
               05  RECE061-CDKBN-KBN           PIC  X(01).
               05  RECE061-CDKBN-KBNNUM        PIC  9(03).
               05  RECE061-CDKBN-KBNNUM-EDA    PIC  9(02).
               05  RECE061-CDKBN-KOUBAN        PIC  9(02).
               05  RECE061-KOUHYOJUNNUM        PIC  9(09).
      *剤点数
               05  RECE061-ZAITEN          PIC  9(08).
      *剤番号
               05  RECE061-ZAINUM          PIC  9(05).
      *連番号
               05  RECE061-LINENUM         PIC  9(05).
      *剤明細数
           03  RECE061-ZAIMEISAISU         PIC  9(03).
      *患者番号
           03  RECE061-PTNUM               PIC  X(20).
      *診療科
           03  RECE061-SRYKA               PIC  X(02).
      *適要欄情報
           03  RECE061-TEKIYO-INF.
      *剤区切（＊）
               05  RECE061-ASTER           PIC  X(02).
      *摘要
               05  RECE061-TEKIYO          PIC  X(100).
