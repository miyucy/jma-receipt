            02  L99.
              03  L99-MSG.
                04  L99-VALUE   PIC X(80).
              03  L99-SCROLLEDWINDOW28.
                04  L99-JOBKANRILST.
                  05  L99-COUNT   PIC S9(9)   BINARY.
                  05  L99-ITEM        OCCURS  30 TIMES.
                    06  L99-RENNUM    PIC X(7).
                    06  L99-SHORINM   PIC X(26).
                    06  L99-STARTTIME PIC X(8).
                    06  L99-ENDTIME   PIC X(8).
                    06  L99-PAGE      PIC X(10).
                    06  L99-ERRMSG    PIC X(100).
                  05  L99-SELECT  PIC X       OCCURS  30 TIMES.
