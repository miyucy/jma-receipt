        02  P982.
     ***   02  P982-FIXED32.
              03  P982-SELNUM.
                04  P982-VALUE  PIC X(4).
              03  P982-SCROLLEDWINDOW26.
                04  P982-LIST.
                  05  P982-COUNT  PIC S9(9)   BINARY.
                  05  P982-ITEM       OCCURS  100 TIMES.
                    06  P982-SEQNO    PIC X(3).
                    06  P982-POST     PIC X(7).
                    06  P982-LPUBCD   PIC X(5).
                    06  P982-TOWNNAME  PIC X(100).
                  05  P982-SELECT PIC X       OCCURS  100 TIMES.
