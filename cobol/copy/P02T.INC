        02  P02T.
              03  P02T-NYUGAI-COMBO.
                04  P02T-NYUGAI.
                  05  P02T-VALUE  PIC X(20).
                04  P02T-NYUGAI-COUNT  PIC S9(9)   BINARY.
                04  P02T-NYUGAI-ITEM
                        PIC X(20)   OCCURS  3 TIMES.
              03  P02T-CD       OCCURS  5.
                04  P02T-VALUE  PIC X(2).
              03  P02T-NAIYO    OCCURS  5.
                04  P02T-VALUE  PIC X(8).
              03  P02T-STYM     OCCURS  5.
                04  P02T-VALUE  PIC X(7).
              03  P02T-EDYM     OCCURS  5.
                04  P02T-VALUE  PIC X(7).
