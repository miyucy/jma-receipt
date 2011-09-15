        02  W201.
     ****** 02  W201-FIXED32.
              03  W201-SCROLLEDWINDOW28.
                04  W201-MEILIST.
                  05  W201-MEILIST-COUNT  PIC S9(9)   BINARY.
                  05  W201-MEILIST-ROW    PIC S9(9)   BINARY.
                  05  W201-MEILIST-ROWATTR    PIC S9(9)   BINARY.
                  05  W201-ITEM       OCCURS  100 TIMES.
                    06  W201-TRENNUM PIC X(3).
                    06  W201-TFORMID PIC X(20).
                    06  W201-TPRTNM  PIC X(16).
                    06  W201-TOFFSET-X PIC X(5).
                    06  W201-TOFFSET-Y PIC X(5).
                  05  W201-MEILIST-SELECT
                          PIC X       OCCURS  100 TIMES.
              03  W201-FORMID.
                04  W201-VALUE  PIC X(20).
              03  W201-PRTNM.
                04  W201-VALUE  PIC X(16).
              03  W201-OFFSET-X.
                04  W201-VALUE  PIC X(5).
              03  W201-OFFSET-Y.
                04  W201-VALUE  PIC X(5).
              03  W201-SELNUM.
                04  W201-VALUE  PIC S9(3).
