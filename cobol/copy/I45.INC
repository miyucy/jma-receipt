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
        02  I45.
              03  I45-SELNUM.
                04  I45-VALUE  PIC S9(3).
              03  I45-SCROLLEDWINDOW1.
                04  I45-BUNREILIST.
                  05  I45-BUNREI-COUNT  PIC S9(9)   BINARY.
                  05  I45-ITEM       OCCURS  200 TIMES.
                    06  I45-TRENNUM        PIC X(3).
                    06  I45-TCOMMENT       PIC X(100).
                  05  I45-BUNREI-SELECT PIC X       OCCURS  200 TIMES.
