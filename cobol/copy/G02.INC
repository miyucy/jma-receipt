          02  G02.
              03  G02-SRYYM.
                04  G02-VALUE   PIC X(7).
              03  G02-FILENM1.
                04  G02-VALUE   PIC X(150).
              03  G02-FILENM2.
                04  G02-VALUE   PIC X(150).
              03  G02-HOUKATUKBN1.
                04  G02-VALUE   PIC X.
              03  G02-HOUKATUKBN2.
                04  G02-VALUE   PIC X.
              03  G02-KOJINKBN1.
                04  G02-VALUE   PIC X.
              03  G02-KOJINKBN2.
                04  G02-VALUE   PIC X.
              03  G02-NYUGAIKBNCOMBO.
                04  G02-NYUGAIKBN.
                  05  G02-VALUE   PIC X(8).
                04  G02-NYUGAIKBN-COUNT   PIC S9(9)   BINARY.
                04  G02-NYUGAIKBN-ITEM    PIC X(8)    OCCURS  2 TIMES.
              03  G02-DATAKBN3.
                04  G02-VALUE   PIC X.
              03  G02-DATAKBN2.
                04  G02-VALUE   PIC X.
              03  G02-DATAKBN1.
                04  G02-VALUE   PIC X.
              03  G02-CDKBN1.
                04  G02-VALUE   PIC X.
              03  G02-CDKBN2.
                04  G02-VALUE   PIC X.
