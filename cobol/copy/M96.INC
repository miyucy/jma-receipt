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
        02  M96.
            03  M96-LIST1.
              04  M96-COUNT1   PIC S9(9)   BINARY.
              04  M96-ROW1     PIC S9(9)   BINARY.
              04  M96-ROWATTR1 PIC S9(9)   BINARY.
              04  M96-ITEM1        OCCURS  2 TIMES.
                05  M96-VALUE11  PIC X(64).
                05  M96-VALUE12  PIC X(64).
                05  M96-VALUE13  PIC X(64).
                05  M96-VALUE14  PIC X(64).
                05  M96-VALUE15  PIC X(64).
                05  M96-VALUE16  PIC X(09).
              04  M96-SELECT1  PIC X       OCCURS  2 TIMES.
            03  M96-LIST2.
              04  M96-COUNT2   PIC S9(9)   BINARY.
              04  M96-ROW2     PIC S9(9)   BINARY.
              04  M96-ROWATTR2 PIC S9(9)   BINARY.
              04  M96-ITEM2        OCCURS  2 TIMES.
                05  M96-VALUE21  PIC X(09).
                05  M96-VALUE22  PIC X(08).
                05  M96-VALUE23  PIC X(09).
                05  M96-VALUE24  PIC X(08).
                05  M96-VALUE25  PIC X(08).
                05  M96-VALUE26  PIC X(08).
              04  M96-SELECT2  PIC X       OCCURS  2 TIMES.
            03  M96-MSG1.
              04  M96-MSG1-STYLE PIC X(20).
              04  M96-VALUE3     PIC X(62).
