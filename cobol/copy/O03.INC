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
        02  O03.
            03  O03-FIXED6.
              04  O03-LISTWIND.
                05  O03-LIST11.
                  06  O03-LIST11-COUNT   PIC S9(9)   BINARY.
                  06  O03-LIST11-ITEM        OCCURS  50 TIMES.
                    07  O03-VALUE1  PIC X(28).
                    07  O03-VALUE2  PIC X(10).
                    07  O03-VALUE3  PIC X(10).
                  06  O03-LIST11-SELECT  PIC X       OCCURS  50 TIMES.
              04  O03-PRJUNCOMBO.
                05  O03-PRJUN.
                  06  O03-VALUE   PIC X(23).
                05  O03-PRJUN-COUNT   PIC S9(9)   BINARY.
                05  O03-PRJUN-ITEM    PIC X(22)   OCCURS  10 TIMES.
