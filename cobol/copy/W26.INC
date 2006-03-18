        02  W26.
      *    02  W26-FIXED6.
              03  W26-B12-STATE            PIC S9(9)   BINARY.
              03  W26-CMB-BTU-NAME.
                04  W26-BTU-NAME.
                  05  W26-VALUE   PIC X(23).
                04  W26-BTU-NAME-CNT   PIC S9(9)   BINARY.
                04  W26-BTU-NAME-ITM   PIC X(23)   OCCURS  50 TIMES.
              03  W26-BTU-SBT.
                04  W26-VALUE   PIC X(20).
              03  W26-BTU-KHNRYO.
                04  W26-VALUE   PIC X(60).
              03  W26-STYUKYMD.
                04  W26-VALUE   PIC X(10).
              03  W26-EDYUKYMD.
                04  W26-VALUE   PIC X(10).
              03  W26-CHK-KSN-OCC          OCCURS 9.
                04  W26-CHK-KSN            PIC X(01).
                04  W26-CHK-KSN-LBL        PIC X(80).
                04  W26-CHK-KSN-STATE      PIC S9(9)   BINARY.
              03  W26-SELNUM.
                04  W26-VALUE   PIC S9(3).
              03  W26-SCROLLEDWINDOW1.
                04  W26-YUKOYMDLST.
                  05  W26-YUKOYMDLST-CNT   PIC S9(9)   BINARY.
                  05  W26-YUKOYMDLST-ROW   PIC S9(9)   BINARY.
                  05  W26-YUKOYMDLST-ROWATTR   PIC S9(9)   BINARY.
                  05  W26-YUKOYMDLST-ITM   OCCURS  100 TIMES.
                    06  W26-TSELNUM        PIC X(3).
                    06  W26-TSTYUKYMD      PIC X(9).
                    06  W26-TEDYUKYMD      PIC X(9).
                  05  W26-YUKOYMDLST-SELECT
                                           PIC X
                                           OCCURS  100 TIMES.
