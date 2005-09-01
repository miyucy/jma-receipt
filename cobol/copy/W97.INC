        02  W97.
    ******* 02  W97-FIXED1.
              03  W97-GYOUMUMEI-TBL   OCCURS  20.
                04  W97-GYOUMUMEI   PIC X(14).
              03  W97-GYOUMUID-TBL    OCCURS 20.
                04  W97-GYOUMUID   PIC X(8).
              03  W97-SHELL-TBL       OCCURS  20.
                04  W97-SHELL-STATE   PIC S9(9)   BINARY.
                04  W97-SHELL        PIC X(100).
              03  W97-EXECUTE-TBL     OCCURS  20.
                04  W97-EXECUTE-VALUE   PIC X.
                04  W97-EXECUTE-STATE   PIC S9(9)   BINARY.
                04  W97-EXECUTE-LABEL   PIC X(4).
