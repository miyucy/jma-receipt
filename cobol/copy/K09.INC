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
        02  K09.
      *****  02  K09-FIXED1.
              03  K09-DOSEL.
                04  K09-VALUE   PIC X(41).
              03  K09-SELNUM.
                04  K09-VALUE   PIC X(4).
              03  K09-SCROLLEDWINDOW2.
                04  K09-RRKLIST.
                  05  K09-COUNT1   PIC S9(9)   BINARY.
                  05  K09-ITEM1        OCCURS  100 TIMES.
                    06  K09-NO      PIC X(3).
                    06  K09-RRKYMD  PIC X(16).
                  05  K09-SELECT1  PIC X       OCCURS  100 TIMES.
              03  K09-SCROLLEDWINDOW1.
                04  K09-VIEWPORT1.
                  05  K09-LIST1.
                    06  K09-COUNT2   PIC S9(9)   BINARY.
                    06  K09-ITEM     PIC X(90)  OCCURS  200 TIMES.
                    06  K09-SELECT2  PIC X       OCCURS  200 TIMES.
