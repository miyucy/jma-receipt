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
              03  W23-CMB-NYUKINPRTKBN.
                04  W23-NYUKINPRTKBN       PIC X(30).
                04  W23-NYUKINPRTKBN-STATE PIC S9(9)   BINARY.
                04  W23-NYUKINPRTKBN-COUNT PIC S9(9)   BINARY.
                04  W23-NYUKINPRTKBNLST    PIC X(30)   OCCURS  5 TIMES.
                04  W23-NYUKINPRTKBNLST-STATE
                                           PIC S9(9)   BINARY.
              03  W23-CMB-SAISYORIKBN.
                04  W23-SAISYORIKBN        PIC X(60).
                04  W23-SAISYORIKBN-COUNT  PIC S9(9)   BINARY.
                04  W23-SAISYORIKBNLST     PIC X(60)   OCCURS  5 TIMES.
