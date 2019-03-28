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
      *----------------------------------------------------------*
      *    患者一覧印刷           COPY (CPORCHC28.INC)
      *                                (ORCHC28 で使用）
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCHC28AREA.
      *表題
           03  ORCHC28-HYODAI              PIC X(100).
      *条件１
           03  ORCHC28-JYOKEN1             PIC X(100).
      *条件２
           03  ORCHC28-JYOKEN2             PIC X(100).
      *患者ID領域
           03  ORCHC28-PTID-AREA.
      *患者ID件数
               05  ORCHC28-PTID-COUNT      PIC 9(05).
      *
               05  ORCHC28-PTID-OCC        OCCURS  200.
      *連番
                   07  ORCHC28-PTID-SEQ    PIC X(5).
      *患者ID
                   07  ORCHC28-PTID        PIC 9(10).
      *
