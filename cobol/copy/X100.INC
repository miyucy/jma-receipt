            02  X100.
              03  X100-SCROLLEDWINDOW28.
                04  X100-BYOMEICDLST.
                  05  X100-COUNT       PIC S9(9)   BINARY.
                  05  X100-ROW         PIC S9(9)   BINARY.
                  05  X100-ROWATTR     PIC S9(9)   BINARY.
                  05  X100-ITEM                OCCURS  100 TIMES.
                    06  X100-TBANGO    PIC X(2).
                    06  X100-TBYOMEICD PIC X(7).
                    06  X100-TBYOMEI   PIC X(40).
                  05  X100-SELECT      PIC X   OCCURS  100 TIMES.
