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
      *    通算日数取得サブ          COPY (CPORCSRSITUSAN.INC)   *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSRSITUSANAREA.
      *    医療機関コード
           03  RSITUSAN-HOSPID             PIC  X(24).
      *    患者ＩＤ
           03  RSITUSAN-PTID               PIC  9(10).
      *    保険組合せ
           03  RSITUSAN-HKNCOMBI           PIC  9(04).
      *    診療年月
           03  RSITUSAN-SRYYM              PIC  X(06).
      *
      *    出力領域
           03  RSITUSAN-OUT-AREA.
      *        日数
               05  RSITUSAN-NISSU          PIC 9(08).
      *        算定終了日
               05  RSITUSAN-SANTEIEDYMD    PIC X(08).
      *
      *    リターンコード
           03  RSITUSAN-RC                 PIC 9(02).
