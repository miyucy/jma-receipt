            02  O99.
              03  O99-MSG.
                04  O99-VALUE   PIC X(81).
              03  O99-SCROLLEDWINDOW28.
                04  O99-JOBKANRILST.
                  05  O99-COUNT   PIC S9(9)   BINARY.
                  05  O99-ITEM        OCCURS  2 TIMES.
                    06  O99-RENNUM    PIC X(7).
                    06  O99-SHORINM   PIC X(34).
                    06  O99-STARTTIME PIC X(8).
                    06  O99-ENDTIME   PIC X(8).
                    06  O99-ERRMSG    PIC X(100).
                  05  O99-SELECT  PIC X       OCCURS  2 TIMES.
              03  O99-B12-STATE   PIC S9(9)   BINARY.
              03  O99-PROGRESSBAR-VALUE       PIC S9(9)   BINARY.
