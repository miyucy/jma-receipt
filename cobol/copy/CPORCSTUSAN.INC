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
      *    通算日数取得サブ          COPY (CPORCSTUSAN.INC)      *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSTUSANAREA.
      *  医療機関コード
           03  STUSAN-HOSPID               PIC  X(24).
      *  患者ＩＤ
           03  STUSAN-PTID                 PIC  9(10).
      *    基準日
           03  STUSAN-KJNYMD               PIC X(08).
      *  出力領域
      *    通算日数
           03  STUSAN-OUT-AREA.
               05  STUSAN-NISSU-VAL.
      *            日数１：今回入院日から基準日までの通算日数
                   07  STUSAN-NISSU01      PIC 9(08).
      *            日数２：初回入院から基準日までの通算日数（他院分含む）
                   07  STUSAN-NISSU02      PIC 9(08).
      *            日数３：初回入院から基準日までの通算日数（他院分含めず）
                   07  STUSAN-NISSU03      PIC 9(08).
      *            日数４：初回入院から基準日までの通算日数
      *            （一般入院料で入院していた日数（他院分含めず））
                   07  STUSAN-NISSU04      PIC 9(08).
               05  STUSAN-TUSAN-R  REDEFINES   STUSAN-NISSU-VAL.
                   07  STUSAN-TUSAN-OCC    OCCURS  4.
                       09  STUSAN-NISSU    PIC 9(08).
      *  リターンコード
           03  STUSAN-RC               PIC 9(02).
