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
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
        02  M00.
            03  M00-FIXED1.
              04  M00-STATE-G.
                05  M00-G01.
                  06  M00-G01-STATE   PIC S9(9)   BINARY.
                05  M00-G02.
                  06  M00-G03-STATE   PIC S9(9)   BINARY.
                05  M00-G03.
                  06  M00-G04-STATE   PIC S9(9)   BINARY.
              04  M00-STATE-R       REDEFINES  M00-STATE-G.
                05  M00-STATE-O     PIC S9(09) BINARY  OCCURS  3.
              04  M00-SELNUM.
                05  M00-VALUE   PIC 9(2).
              04  M00-LBLMSG-G.
                05  M00-LBLMSG-STYLE   PIC X(20).
                05  M00-LBLMSG         PIC X(60).
