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
        02  C05.
            03  C05-FIXED9.
              04  C05-SELNUM          PIC 9(4).
              04  C05-HENCOD          PIC X(7).
              04  C05-HENBYO          PIC X(101).
              04  C05-BYOKEN          PIC X(31).
              04  C05-TBYOCD2-ITEM  OCCURS 6.
                  06  C05-TBYOCD2     PIC X(8).
              04  C05-SYOBYO          PIC 9(1).
              04  C05-SCR-BYOMEILST.
                05  C05-BYOMEILST.
                  06  C05-COUNT       PIC S9(9)   BINARY.
                  06  C05-BYOMEI-ITEM        OCCURS  100 TIMES.
                    07  C05-TBANGO    PIC X(5).
                    07  C05-TSYUBET   PIC X(7).
                    07  C05-TIKOSAKICD
                                      PIC X(5).
                    07  C05-TBYOMEI   PIC X(51).
                    07  C05-THAISIYMD PIC X(10).
                    07  C05-TBYOCD    PIC X(8).
                  06  C05-SELECT      PIC X  OCCURS  100 TIMES.
