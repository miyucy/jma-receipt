            02  I20.
              03  I20-PTNUM.
                04  I20-VALUE   PIC X(20).
              03  I20-STNYUINYMD.
                04  I20-VALUE   PIC X(10).
              03  I20-NAME.
                04  I20-VALUE   PIC X(30).
              03  I20-EDNYUINYMD.
                04  I20-VALUE   PIC X(10).
              03  I20-ADRS.
                04  I20-VALUE   PIC X(100).
              03  I20-SELNUM.
                04  I20-VALUE   PIC S9(3).
              03  I20-EDAGECOMBO.
                04  I20-EDAGE       PIC X(13).
                04  I20-EDAGE-COUNT PIC S9(9)   BINARY.
                04  I20-EDAGELST    PIC X(13)   OCCURS  14 TIMES.
              03  I20-STAGECOMBO.
                04  I20-STAGE       PIC X(13).
                04  I20-STAGE-COUNT PIC S9(9)   BINARY.
                04  I20-STAGELST    PIC X(13)   OCCURS  14 TIMES.
              03  I20-SRYKA-COMBO.
                04  I20-SRYKA       PIC X(23).
                04  I20-SRYKA-COUNT PIC S9(9)   BINARY.
                04  I20-SRYKALST    PIC X(23)   OCCURS  40 TIMES.
              03  I20-BTUNUMCOMBO.
                04  I20-BTUNUM          PIC X(23).
                04  I20-BTUNUM-COUNT    PIC S9(9)   BINARY.
                04  I20-BTUNUMLST       PIC X(23)   OCCURS  50 TIMES.
              03  I20-SCROLLEDWINDOW28.
                04  I20-KANJYALST.
                  05  I20-COUNT   PIC S9(9)   BINARY.
                  05  I20-ITEM        OCCURS  200 TIMES.
                    06  I20-TRENNUM    PIC X(3).
                    06  I20-TPTNUM     PIC X(20).
                    06  I20-TNAME      PIC X(30).
                    06  I20-TSEX       PIC X(2).
                    06  I20-TBRMNUM    PIC X(8).
                    06  I20-TNYUINYMD  PIC X(9).
                    06  I20-TTAIINYMD  PIC X(9).
                    06  I20-TSRYKA     PIC X(20).
                    06  I20-TGAIHAKU   PIC X(6).
                    06  I20-TCOMMENT   PIC X(6).
                    06  I20-TADRS      PIC X(50).
                  05  I20-SELECT  PIC X       OCCURS  200 TIMES.
