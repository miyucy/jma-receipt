        02  W23.
      *     02  W23-FIXED6.
              03  W23-YUKOSTYMD PIC X(9).
              03  W23-YUKOEDYMD PIC X(9).
              03  W23-SEIKYU01  PIC X(3).
              03  W23-SEIKYU02  PIC X(3).
              03  W23-SEIKYU03  PIC X(3).
              03  W23-CMB-NYUKINKBN.
                04  W23-NYUKINKBN          PIC X(60).
                04  W23-NYUKINKBN-COUNT    PIC S9(9)   BINARY.
                04  W23-NYUKINKBNLST       PIC X(60)   OCCURS  5 TIMES.
