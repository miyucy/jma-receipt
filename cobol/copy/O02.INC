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
        02  O02.
      *     02  O02-FIXED6.
              03  O02-PTNUM.
                04  O02-VALUE   PIC X(20).
              03  O02-NAME.
                04  O02-VALUE   PIC X(68).
              03  O02-SEIYM.
                04  O02-VALUE   PIC X(6).
              03  O02-SCROLLEDWINDOW1.
                04  O02-LIST01.
                  05  O02-LIST01-COUNT   PIC S9(9)   BINARY.
                  05  O02-LIST01-ITEM        OCCURS  50 TIMES.
                    06  O02-VALUE1  PIC X(20).
                    06  O02-VALUE2  PIC X(68).
                    06  O02-VALUE3  PIC X(6).
                    06  O02-VALUE4  PIC X(10).
                  05  O02-LIST01-SELECT  PIC X       OCCURS  50 TIMES.
              03  O02-SAKKBNCOMBO.
                04  O02-SAKKBN.
                  05  O02-VALUE   PIC X(12).
                04  O02-SAKKBN-COUNT   PIC S9(9)   BINARY.
                04  O02-SAKKBN-ITEM    PIC X(12)   OCCURS  10 TIMES.
