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
      *    レセプト明細書     COPY (CPRCF06.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.06.29  保険者番号・
      *                                     適用開始年月日の追加
      ************************************************************
      *01  RECE06-REC.
           03  RECE06-KEY.
      *医療機関ＩＤ
               05  RECE06-HOSPID          PIC  X(24).
      *診療年月
               05  RECE06-SRYYM           PIC  9(06).
      *入外区分
               05  RECE06-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE06-PTID            PIC  9(10).
      *レセプト科
               05  RECE06-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE06-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE06-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE06-HKNJANUM        PIC  X(08).
      *適用開始年月日
               05  RECE06-TEKSTYMD        PIC  X(08). 
      *公費分離区分
               05  RECE06-KOHBUNRI        PIC  9(01).
      *剤番号
               05  RECE06-ZAINUM          PIC  9(05).
      *連番号
               05  RECE06-LINENUM         PIC  9(05).
      *剤明細数
           03  RECE06-ZAIMEISAISU         PIC  9(03).
      *患者番号
           03  RECE06-PTNUM               PIC  X(20).
      *診療科
           03  RECE06-SRYKA               PIC  X(02).
      *診療区分
           03  RECE06-SRYKBN              PIC  X(02).
      *適要欄情報
           03  RECE06-TEKIYO-INF.
      *剤区切（＊）
               05  RECE06-ASTER           PIC  X(02).
      *摘要
               05  RECE06-TEKIYO          PIC  X(100).
      *剤点数
           03  RECE06-ZAITEN              PIC  9(08).
      *検査実施区分
           03  RECE06-KNSJISKBN           PIC  9(01).
      *表用番号
           03  RECE06-CDKBN-SYO           PIC  9(01).
           03  RECE06-CDKBN-BU            PIC  9(02).
           03  RECE06-CDKBN-KBN           PIC  X(01).
           03  RECE06-CDKBN-KBNNUM        PIC  9(03).
           03  RECE06-CDKBN-KBNNUM-EDA    PIC  9(02).
           03  RECE06-CDKBN-KOUBAN        PIC  9(02).
           03  RECE06-KOUHYOJUNNUM        PIC  9(09).
