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
        02  X01.
      *****   02  X01-FIXED1.
              03  X01-SCROLLEDWINDOW1.
                04  X01-TENSU-LIST.
                  05  X01-COUNT   PIC S9(9)   BINARY.
                  05  X01-ITEM        OCCURS  100 TIMES.
                    06  X01-TBANGO     PIC X(4).
                    06  X01-TSTYUKYMD  PIC X(10).
                    06  X01-TEDYUKYMD  PIC X(10).
                  05  X01-SELECT  PIC X       OCCURS  100 TIMES.
              03  X01-SELNUM.
                04  X01-VALUE   PIC X(4).
              03  X01-STYUKYMD.
                04  X01-VALUE   PIC X(11).
              03  X01-EDYUKYMD.
                04  X01-VALUE   PIC X(11).
              03  X01-SRYCD.
                04  X01-VALUE   PIC X(10).
              03  X01-NAME.
                04  X01-VALUE   PIC X(101).
              03  X01-CHKKBNCOMB.
                04  X01-CHKKBN.
                  05  X01-VALUE   PIC X(23).
                04  X01-CHKKBNCOUNT   PIC S9(9)   BINARY.
                04  X01-CHKKBNLIST    PIC X(22)   OCCURS  9 TIMES.
