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
      *    労災レセプト明細書             COPY (CPRCF040.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE40-REC.
           03  RECE40-KEY.
      *医療機関ＩＤ
               05  RECE40-HOSPID          PIC  X(24).
      *診療年月
               05  RECE40-SRYYM           PIC  9(06).
      *入外区分
               05  RECE40-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE40-PTID            PIC  9(10).
      *レセプト診療科
               05  RECE40-RECEKA          PIC  X(02).
      *主保険ＩＤ
               05  RECE40-HKNID           PIC  9(10).
      *適用開始年月日
               05  RECE40-TEKSTYMD        PIC  X(08). 
      *主保険保険番号
           03  RECE40-HKNNUM              PIC  X(03).
      *保険組合せ番号
           03  RECE40-HKNCOMBI            PIC  9(04).
      *診療科情報
           03 RECE40-SRYKAINF.
               05  RECE40-SRYKA           PIC  X(02)  OCCURS  10.
      *未訂正区分
           03  RECE40-TEISEIKBN           PIC  X(01).
      *予備
           03  FILLER                     PIC  X(20).
      
