        02  M95.
   ******   02  M95-FIXED1.
              03  M95-CALENDAR1.
                04  M95-YEAR    PIC S9(9)   BINARY.
                04  M95-MONTH   PIC S9(9)   BINARY.
                04  M95-DAY PIC S9(9)   BINARY.
              03  M95-SYSYMD.
                04  M95-VALUE   PIC X(10).
              03  M95-JIKANKBN-COMB.
                04  M95-JIKANKBN.
                  05  M95-VALUE   PIC X(30).
                04  M95-JIKANKBN-COUNT   PIC S9(9)   BINARY.
                04  M95-JIKANKBN-ITEM
                        PIC X(30)   OCCURS  5 TIMES.
