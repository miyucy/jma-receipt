          02  I21.
              03  I21-PTNUM.
                04  I21-VALUE   PIC X(20).
              03  I21-KANANAME.
                04  I21-VALUE   PIC X(50).
              03  I21-ADRS.
                04  I21-VALUE   PIC X(100).
              03  I21-SRYKANAME.
                04  I21-VALUE   PIC X(18).
              03  I21-NAME.
                04  I21-VALUE   PIC X(50).
              03  I21-SEX.
                04  I21-VALUE   PIC X(2).
              03  I21-BIRTHDAY.
                04  I21-VALUE   PIC X(9).
              03  I21-JYOTAI1-STYLE   PIC X(20).
              03  I21-JYOTAI1-VALUE   PIC X(10).
              03  I21-JYOTAI2-STYLE   PIC X(20).
              03  I21-JYOTAI2-VALUE   PIC X(10).
              03  I21-JYOTAI3-STYLE   PIC X(20).
              03  I21-JYOTAI3-VALUE   PIC X(10).
              03  I21-AGE.
                04  I21-VALUE   PIC S9(3).
              03  I21-BRMNUM.
                04  I21-VALUE   PIC X(8).
              03  I21-BTUNUM.
                04  I21-VALUE   PIC X(10).
              03  I21-MSG1-STYLE   PIC X(20).
              03  I21-MSG1-VALUE   PIC X(20).
              03  I21-MSG2-STYLE   PIC X(20).
              03  I21-MSG2-VALUE   PIC X(20).
              03  I21-MSG3-STYLE   PIC X(20).
              03  I21-MSG3-VALUE   PIC X(20).
              03  I21-MSG4-STYLE   PIC X(20).
              03  I21-MSG4-VALUE   PIC X(20).
              03  I21-COMMENT-STYLE   PIC X(20).
              03  I21-COMMENT-VALUE   PIC X(100).
              03  I21-GAIHAKU-STYLE   PIC X(20).
              03  I21-GAIHAKU-VALUE   PIC X(8).
              03  I21-SCROLLEDWINDOW1.
                04  I21-RIREKILST.
                  05  I21-COUNT       PIC S9(9)   BINARY.
                  05  I21-ROW         PIC S9(9)   BINARY.
                  05  I21-ROWATTR     PIC S9(9)   BINARY.
                  05  I21-ITEM        OCCURS  50 TIMES.
                    06  I21-TNYUINYMD PIC X(9).
                    06  I21-TTAIINYMD PIC X(9).
                    06  I21-TSRYKA    PIC X(10).
                  05  I21-SELECT  PIC X       OCCURS  50 TIMES.
