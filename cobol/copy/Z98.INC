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
        02  Z98.
     ***  02  Z98-FIXED32.
              03  Z98-INPUT.
                04  Z98-VALUE   PIC X(22).
              03  Z98-SENTAKU.
                04  Z98-VALUE   PIC X(30).
              03  Z98-SELNUM     PIC X(03)   OCCURS  5.
              03  Z98-SCROLLEDWINDOW26.
                04  Z98-LIST.
                  05  Z98-COUNT   PIC S9(9)   BINARY.
                  05  Z98-ROW     PIC S9(9)   BINARY.
                  05  Z98-ROWATTR PIC S9(9)   BINARY.
                  05  Z98-ITEM        OCCURS  200 TIMES.
                    06  Z98-NO      PIC X(3).
                    06  Z98-NAME    PIC X(70).
                    06  Z98-TANI    PIC X(6).
                    06  Z98-KISOTEN  PIC X(10).
                  05  Z98-SELECT  PIC X       OCCURS  200 TIMES.
              03  Z98-JIINCOB.
                04  Z98-JIIN.
                  05  Z98-VALUE   PIC X(16).
                04  Z98-JIIN-COUNT   PIC S9(9)   BINARY.
                04  Z98-JIIN-ITEM    PIC X(16)   OCCURS  10 TIMES.
              03  Z98-USERCOB.
                04  Z98-USER.
                  05  Z98-VALUE   PIC X(10).
                04  Z98-USER-COUNT   PIC S9(9)   BINARY.
                04  Z98-USER-ITEM    PIC X(10)   OCCURS  10 TIMES.

