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
        02  I48.
              03  I48-INPUT.
                04  I48-VALUE   PIC X(23).
              03  I48-SENTAKU.
                04  I48-VALUE   PIC X(31).
              03  I48-SELNUM     PIC X(04)   OCCURS  5.
              03  I48-SCROLLEDWINDOW26.
                04  I48-LIST.
                  05  I48-COUNT   PIC S9(9)   BINARY.
                  05  I48-ITEM        OCCURS  200 TIMES.
                    06  I48-NO      PIC X(3).
                    06  I48-NAME    PIC X(70).
                    06  I48-TANI    PIC X(6).
                    06  I48-KISOTEN  PIC X(10).
                  05  I48-SELECT  PIC X       OCCURS  200 TIMES.
              03  I48-JIINCOB.
                04  I48-JIIN.
                  05  I48-VALUE   PIC X(17).
                04  I48-JIIN-COUNT   PIC S9(9)   BINARY.
                04  I48-JIIN-ITEM    PIC X(16)   OCCURS  10 TIMES.
              03  I48-USERCOB.
                04  I48-USER.
                  05  I48-VALUE   PIC X(11).
                04  I48-USER-COUNT   PIC S9(9)   BINARY.
                04  I48-USER-ITEM    PIC X(10)   OCCURS  10 TIMES.

