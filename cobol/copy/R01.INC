           02  R01.
              03  R01-B09-STATE   PIC S9(09) BINARY.
              03  R01-SYORI-COMBO.
                04  R01-SYORI-STATE   PIC S9(09) BINARY.
                04  R01-SYORI.
                  05  R01-VALUE   PIC X(12).
                04  R01-SYORI-COUNT   PIC S9(9)   BINARY.
                04  R01-SYORILST
                        PIC X(12)   OCCURS  5 TIMES.
              03  R01-STJYUSINYMD-STATE   PIC S9(09) BINARY.
              03  R01-STJYUSINYMD.
                04  R01-VALUE   PIC X(10).
              03  R01-EDJYUSINYMD-STATE   PIC S9(09) BINARY.
              03  R01-EDJYUSINYMD.
                04  R01-VALUE   PIC X(10).
              03  R01-RENNUM-STATE   PIC S9(09) BINARY.
              03  R01-RENNUM.
                04  R01-VALUE   PIC S9(3).
              03  R01-SRYYM-STATE   PIC S9(09) BINARY.
              03  R01-SRYYM.
                04  R01-VALUE   PIC X(7).
              03  R01-PTNUM-STATE   PIC S9(09) BINARY.
              03  R01-PTNUM.
                04  R01-VALUE   PIC X(20).
              03  R01-NYUGAIKBN-STATE   PIC S9(09) BINARY.
              03  R01-NYUGAIKBN.
                04  R01-VALUE   PIC X(1).
              03  R01-NAME.
                04  R01-VALUE   PIC X(50).
              03  R01-SCROLLEDWINDOW1.
                04  R01-RECELST.
                  05  R01-COUNT   PIC S9(9)   BINARY.
                  05  R01-ROW PIC S9(9)   BINARY.
                  05  R01-ROWATTR PIC S9(9)   BINARY.
                  05  R01-ITEM        OCCURS  100 TIMES.
                    06  R01-TRENNUM  PIC X(4).
                    06  R01-TPTNUM   PIC X(20).
                    06  R01-TNAME    PIC X(50).
                    06  R01-TSRYYM   PIC X(7).
                    06  R01-TNYUGAIKBN PIC X(1).
                  05  R01-SELECT  PIC X       OCCURS  100 TIMES.
              03  R01-SYOKBN-STYLE   PIC X(20).
              03  R01-SYOKBN         PIC X(25).
              03  R01-LABEL.
                04  R01-VALUE   PIC X(10).
