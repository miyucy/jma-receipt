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
        02  J024.
     ****   02  J024-FIXED1.
              03  J024-SELNUM.
                04  J024-VALUE  PIC S9(3).
              03  J024-SCROLLEDWINDOW1.
                04  J024-BUNREILIST.
                  05  J024-BUNREI-COUNT  PIC S9(9)   BINARY.
                  05  J024-ITEM       OCCURS  200 TIMES.
                    06  J024-TRENNUM        PIC X(3).
                    06  J024-TCOMMENT       PIC X(100).
                  05  J024-BUNREI-SELECT PIC X       OCCURS  200 TIMES.
