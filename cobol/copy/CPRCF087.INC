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
      *    労災レセプト明細書（入院）     COPY (CPRCF087.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE87-REC.
           03  RECE87-KEY.
      *医療機関ＩＤ
               05  RECE87-HOSPID          PIC  X(24).
      *診療年月
               05  RECE87-SRYYM           PIC  9(06).
      *入外区分
               05  RECE87-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE87-PTID            PIC  9(10).
      *レセプト科
               05  RECE87-RECEKA          PIC  X(02).
      *保険ＩＤ        
               05  RECE87-HKNID           PIC  9(10).
      *適用開始年月日
               05  RECE87-TEKSTYMD        PIC  X(08). 
      *診療区分
               05  RECE87-SRYKBN          PIC  X(02).
      *剤識別区分
               05  RECE87-ZAISKBKBN       PIC  X(01).
      *剤識別内番号
               05  RECE87-ZAISKBBAN       PIC  9(08).
      *点滴出力区分
               05  RECE87-TENTEKIKBN      PIC  9(02).
      *点滴出力区分別内番号
               05  RECE87-TENTEKIBAN      PIC  9(08).
      *検査実施区分
               05  RECE87-KNSJISKBN       PIC  9(01).
      *表用番号
               05  RECE87-CDKBN-SYO           PIC  9(01).
               05  RECE87-CDKBN-BU            PIC  9(02).
               05  RECE87-CDKBN-KBN           PIC  X(01).
               05  RECE87-CDKBN-KBNNUM        PIC  9(03).
               05  RECE87-CDKBN-KBNNUM-EDA    PIC  9(02).
               05  RECE87-CDKBN-KOUBAN        PIC  9(02).
               05  RECE87-KOUHYOJUNNUM        PIC  9(09).
      *剤点数
               05  RECE87-ZAITEN          PIC  9(08).
      *剤番号
               05  RECE87-ZAINUM          PIC  9(08).
      *連番号
               05  RECE87-LINENUM         PIC  9(05).
      *剤明細数
           03  RECE87-ZAIMEISAISU         PIC  9(03).
      *患者番号
           03  RECE87-PTNUM               PIC  X(20).
      *診療科
           03  RECE87-SRYKA               PIC  X(02).
      *適要欄情報
           03  RECE87-TEKIYO-INF.
      *剤区切（＊）
               05  RECE87-ASTER           PIC  X(02).
      *摘要
               05  RECE87-TEKIYO          PIC  X(100).
