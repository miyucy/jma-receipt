            02  XA99.
              03  XA99-MSG.
                04  XA99-VALUE   PIC X(81).
              03  XA99-SCROLLEDWINDOW28.
                04  XA99-JOBKANRILST.
                  05  XA99-COUNT   PIC S9(9)   BINARY.
                  05  XA99-ITEM        OCCURS  30 TIMES.
                    06  XA99-RENNUM    PIC X(7).
                    06  XA99-SHORINM   PIC X(20).
                    06  XA99-STARTTIME PIC X(8).
                    06  XA99-ENDTIME   PIC X(8).
                    06  XA99-PAGE      PIC X(10).
                    06  XA99-ERRMSG    PIC X(100).
                  05  XA99-SELECT  PIC X       OCCURS  30 TIMES.
