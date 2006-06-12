        02  W63.
              03  W63-B06-STATE PIC S9(9)   BINARY.
              03  W63-SELNUM    PIC S9(2).
              03  W63-STYUKYMD.
                04  W63-VALUE   PIC X(10).
              03  W63-EDYUKYMD.
                04  W63-VALUE   PIC X(10).
              03  W63-HKNJANUM.
                04  W63-VALUE   PIC X(10).
              03  W63-HKNJANAME.
                04  W63-VALUE   PIC X(100).
              03  W63-CMB-JYKNKBN.
                04  W63-JYKNKBN PIC X(16).
                04  W63-JYKNKBN-COUNT  PIC S9(9)   BINARY.
                04  W63-JYKNKBN-ITEM   PIC X(16)   OCCURS  5 TIMES.
              03  W63-CMB-HKNNUM.
                04  W63-HKNNUM         PIC X(20).
                04  W63-HKNNUM-COUNT   PIC S9(9)   BINARY.
                04  W63-HKNNUM-ITEM    PIC X(20)   OCCURS  50 TIMES.
              03  W63-CMB-KIGO.
                04  W63-KIGO           PIC X(16).
                04  W63-KIGO-COUNT     PIC S9(9)   BINARY.
                04  W63-KIGO-ITEM      PIC X(16)   OCCURS  5 TIMES.
              03  W63-CLISTSCROLL.
                04  W63-CHECKLIST.
                  05  W63-CHECKLIST-COUNT   PIC S9(9)   BINARY.
                  05  W63-CHECKLIST-ROW     PIC S9(9)   BINARY.
                  05  W63-CHECKLIST-ROWATTR PIC S9(9)   BINARY.
                  05  W63-CHECKLIST-ITEM    OCCURS  200 TIMES.
                    06  W63-TNUM       PIC X(3).
                    06  W63-THKNJANUM  PIC X(9).
                    06  W63-TJYKNKBN   PIC X(4).
                    06  W63-THKNJANAME PIC X(60).
                    06  W63-THKNNUM    PIC X(20).
                    06  W63-TKIGOCHK   PIC X(10).
                    06  W63-TSTYUKYMD  PIC X(9).
                    06  W63-TEDYUKYMD  PIC X(9).
                  05  W63-CHECKLIST-SELECT
                          PIC X        OCCURS  200 TIMES.
