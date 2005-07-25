        02  I43.
   ******   02  I43-FIXED1.
              03  I43-COMMENT.
                04  I43-VALUE   PIC X(800).
              03  I43-BUNNUM.
                04  I43-VALUE   PIC S9(3).
              03  I43-SRYYM.
                04  I43-VALUE   PIC X(6).
              03  I43-JYURRKLIST.
                04  I43-JYURRK-COUNT   PIC S9(9)   BINARY.
                04  I43-JYURRK-ROW PIC S9(9)   BINARY.
                04  I43-JYURRK-ROWATTR PIC S9(9)   BINARY.
                04  I43-ITEM        OCCURS  10 TIMES.
                  05  I43-TJYURRKNUM  PIC X(2).
                  05  I43-TJYURRKYMD  PIC X(10).
                04  I43-JYURRK-SELECT
                        PIC X       OCCURS  10 TIMES.
              03  I43-JYURRKNUM.
                04  I43-VALUE   PIC S9(2).
              03  I43-COPYTUKI.
                04  I43-VALUE   PIC S9(2).
              03  I43-COPYSRYYM.
                04  I43-VALUE   PIC X(7).
              03  I43-HKNCOMBICOMB.
                04  I43-HKNCOMBI.
                  05  I43-VALUE   PIC X(55).
                04  I43-HKNCOMBI-COUNT   PIC S9(9)   BINARY.
                04  I43-HKNCOMBI-ITEM
                        PIC X(55)   OCCURS  30 TIMES.
              03  I43-SRYKACOMB.
                04  I43-SRYKA.
                  05  I43-VALUE   PIC X(20).
                04  I43-SRYKA-COUNT   PIC S9(9)   BINARY.
                04  I43-SRYKA-ITEM
                        PIC X(20)   OCCURS  41 TIMES.
              03  I43-SELNUM.
                04  I43-VALUE   PIC X(40).
              03  I43-MIDASI-G.
                04  I43-MIDASI-STYLE   PIC X(20).
                04  I43-MIDASI         PIC X(20).
              03  I43-NYUGAIKBNCOMB.
                04  I43-NYUGAIKBN.
                  05  I43-VALUE   PIC X(55).
                04  I43-NYUGAIKBN-COUNT   PIC S9(9)   BINARY.
                04  I43-NYUGAIKBN-ITEM
                        PIC X(55)   OCCURS  2 TIMES.
              03  I43-SCROLLEDWINDOW1.
                04  I43-RECELIST.
                  05  I43-RECE-COUNT   PIC S9(9)   BINARY.
                  05  I43-RECE-ROW PIC S9(9)   BINARY.
                  05  I43-RECE-ROWATTR PIC S9(9)   BINARY.
                  05  I43-ITEM        OCCURS  100 TIMES.
                    06  I43-TRENNUM   PIC X(3).
                    06  I43-TSRYYM    PIC X(6).
                    06  I43-TSRYKA    PIC X(10).
                    06  I43-THKNCOMBI PIC X(50).
                    06  I43-TSRYDD    PIC X(3).
                    06  I43-TCOMMENT  PIC X(100).
                  05  I43-RECE-SELECT
                          PIC X       OCCURS  100 TIMES.
