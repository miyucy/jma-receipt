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
        02  X98.
    ****   02  X98-FIXED32.
              03  X98-SELNUM.
                04  X98-VALUE   PIC X(4).
              03  X98-INPUT.
                04  X98-VALUE   PIC X(23).
              03  X98-SENTAKU.
                04  X98-VALUE   PIC X(21).
              03  X98-SCROLLEDWINDOW26.
                04  X98-LIST.
                  05  X98-COUNT   PIC S9(9)   BINARY.
                  05  X98-ITEM        OCCURS  200 TIMES.
                    06  X98-NO      PIC X(3).
                    06  X98-NAME    PIC X(70).
                    06  X98-KISOTEN   PIC X(10).
                  05  X98-SELECT  PIC X       OCCURS  200 TIMES.
