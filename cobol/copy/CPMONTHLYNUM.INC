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
      *    月代り受給者番号           　 COPY  (CPMONTHLYNUM.INC)  *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  MONTHLYNUM-REC.
      *キー
           03  MONTHLYNUM-KEY.
      *医療機関ＩＤ
               05  MONTHLYNUM-HOSPID           PIC  X(24).
      *患者ＩＤ
               05  MONTHLYNUM-PTID             PIC  9(10).
      *保険番号（公費）
               05  MONTHLYNUM-KOHNUM           PIC  X(03).
      *診療年月
               05  MONTHLYNUM-SRYYM            PIC  X(06).
      *受給者番号
           03  MONTHLYNUM-JKYSNUM              PIC  X(20).
      *端末ＩＤ
           03  MONTHLYNUM-TERMID               PIC  X(32).
      *オペーレータＩＤ
           03  MONTHLYNUM-OPID                 PIC  X(16).
      *作成年月日
           03  MONTHLYNUM-CREYMD               PIC  X(08).
      *更新年月日
           03  MONTHLYNUM-UPYMD                PIC  X(08).
      *更新時間
           03  MONTHLYNUM-UPHMS                PIC  X(06).
