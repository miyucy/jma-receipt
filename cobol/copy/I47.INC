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
         02  I47.
            03  I47-FIXED10.
              04  I47-POP-TOUMEI PIC X(40).
              04  I47-SCROLLEDWINDOW1.
                05  I47-VIEWPORT1.
                  06  I47-LIST1.
                    07  I47-COUNT  PIC S9(9)   BINARY.
                    07  I47-KNKMEI   PIC X(40)   OCCURS  50 TIMES.
                    07  I47-SELECT PIC X       OCCURS  50 TIMES.
