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
            02  N21.
              03  N21-FIXED17.
                05  N21-TBL.
                  07  N21-KEKKALST.
                    09  N21-COUNT     PIC S9(9)   BINARY.
                    09  N21-ROW       PIC S9(9)   BINARY.
                    09  N21-ROWATTR   PIC S9(9)   BINARY.
                    09  N21-ITEM                  OCCURS  200.
                      11  N21-TNO     PIC X(5).
                      11  N21-TNAME   PIC X(100).
                    09  N21-SELECT    PIC X       OCCURS  200.
                05  N21-KENCD         PIC X(20).
                05  N21-KENNAIYO      PIC X(26).
                05  N21-KENNAME       PIC X(100).
                05  N21-SELNUM        PIC S9(3).
                05  N21-NAME          PIC X(80).
                05  N21-EFFECT        PIC X(186).
                05  N21-COLOR         PIC X(136).
                05  N21-SHAPE         PIC X(136).
                05  N21-MARK          PIC X(136).
                05  N21-CAUTION       PIC X(410).
                05  N21-PHOTO         PIC X(256).
