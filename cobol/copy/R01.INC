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
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
        02  R01.
            03  R01-FIXED6.
              04  R01-RENNUM.
                05  R01-VALUE   PIC 9(3).
              04  R01-SRYYM.
                05  R01-VALUE   PIC X(8).
              04  R01-PTNUM.
                05  R01-VALUE   PIC X(21).
              04  R01-NYUGAIKBN.
                05  R01-VALUE   PIC X(2).
              04  R01-NAME.
                05  R01-VALUE   PIC X(51).
              04  R01-SCROLLEDWINDOW1.
                05  R01-RECELST.
                  06  R01-COUNT      PIC S9(9)   BINARY.
                  06  R01-ROW        PIC S9(9)   BINARY.
                  06  R01-ROWATTR    PIC S9(9)   BINARY.
                  06  R01-ITEM        OCCURS  100 TIMES.
                    07  R01-TRENNUM  PIC X(4).
                    07  R01-TPTNUM   PIC X(21).
                    07  R01-TNAME    PIC X(51).
                    07  R01-TSRYYM   PIC X(7).
                    07  R01-TNYUGAIKBN PIC X(2).
                  06  R01-SELECT  PIC X       OCCURS  100 TIMES.
              04  R01-SYOKBN-STYLE PIC X(20).
              04  R01-SYOKBN       PIC X(20).
