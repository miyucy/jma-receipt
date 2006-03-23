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
        02  W27.
            03  W27-FIXED6.
              04  W27-CMB-BTU-NAME.
                05  W27-BTU-NAME           PIC X(23).
                05  W27-BTU-NAME-CNT       PIC S9(9)   BINARY.
                05  W27-BTU-NAME-ITM       PIC X(23)   OCCURS  50 TIMES.
              04  W27-BTU-SBT              PIC X(20).
              04  W27-BTU-KHNRYO           PIC X(60).
              04  W27-SCROLLEDWINDOW1.
                05  W27-BRMLST.
                  06  W27-BRMLST-CNT       PIC S9(9)   BINARY.
                  06  W27-BRMLST-ROW       PIC S9(9)   BINARY.
                  06  W27-BRMLST-ROWATTR   PIC S9(9)   BINARY.
                  06  W27-BRMLST-ITM       OCCURS  400 TIMES.
                    07  W27-TYUKO          PIC X(4).
                    07  W27-TSELNUM        PIC X(4).
                    07  W27-TBRMNUM        PIC X(10).
                    07  W27-TTOKNYUIN      PIC X(24).
                    07  W27-TBRMSBT        PIC X(20).
                    07  W27-TSAGAKU        PIC X(10).
                    07  W27-TSTYUKYMD      PIC X(9).
                    07  W27-TEDYUKYMD      PIC X(9).
                  06  W27-BRMLST-SELECT    PIC X   OCCURS  400 TIMES.
              04  W27-STSELNUM             PIC S9(3).
              04  W27-EDSELNUM             PIC S9(3).
              04  W27-STBRMNUM             PIC X(6).
              04  W27-EDBRMNUM             PIC X(6).
              04  W27-KJNYMD               PIC X(10).
              03  W27-CHK-KSN-OCC          OCCURS 15.
                04  W27-CHK-KSN            PIC X(01).
                04  W27-CHK-KSN-LBL        PIC X(80).
                04  W27-CHK-KSN-STATE      PIC S9(9)   BINARY.
