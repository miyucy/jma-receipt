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
         02  J042.
            03  J042-FIXED10.
              04  J042-POP-TOUMEI PIC X(40).
              04  J042-SCROLLEDWINDOW1.
                05  J042-VIEWPORT1.
                  06  J042-LIST1.
                    07  J042-COUNT  PIC S9(9)   BINARY.
                    07  J042-KNKMEI   PIC X(40)   OCCURS  50 TIMES.
                    07  J042-SELECT PIC X       OCCURS  50 TIMES.
