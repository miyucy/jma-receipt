            02  G99.
              03  G99-MSG.
                04  G99-VALUE   PIC X(81).
              03  G99-SCROLLEDWINDOW28.
                04  G99-JOBKANRILST.
                  05  G99-COUNT   PIC S9(9)   BINARY.
                  05  G99-ITEM        OCCURS  30 TIMES.
                    06  G99-RENNUM    PIC X(7).
                    06  G99-SHORINM   PIC X(26).
                    06  G99-STARTTIME PIC X(8).
                    06  G99-ENDTIME   PIC X(8).
                    06  G99-PAGE      PIC X(10).
                    06  G99-ERRMSG    PIC X(100).
                  05  G99-SELECT  PIC X       OCCURS  30 TIMES.
