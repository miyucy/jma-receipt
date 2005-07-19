        02  J023.
     ****** 02  J023-FIXED1.
              03  J023-COMMENT.
                04  J023-VALUE  PIC X(800).
              03  J023-BUNNUM.
                04  J023-VALUE  PIC S9(3).
              03  J023-SRYYM.
                04  J023-VALUE  PIC X(6).
              03  J023-JYURRKLIST.
                04  J023-JYURRK-COUNT  PIC S9(9)   BINARY.
                04  J023-JYURRK-ROW  PIC S9(9)   BINARY.
                04  J023-JYURRK-ROWATTR  PIC S9(9)   BINARY.
                04  J023-ITEM       OCCURS 10 TIMES.
                  05  J023-TJYURRKNUM     PIC X(2).
                  05  J023-TJYURRKYMD     PIC X(10).
                04  J023-JYURRK-SELECT PIC X       OCCURS  10 TIMES.
              03  J023-JYURRKNUM.
                04  J023-VALUE  PIC S9(2).
              03  J023-COPYTUKI.
                04  J023-VALUE  PIC S9(2).
              03  J023-COPYSRYYM.
                04  J023-VALUE  PIC X(7).
              03  J023-HKNCOMBICOMB.
                04  J023-HKNCOMBI.
                  05  J023-VALUE  PIC X(55).
                04  J023-HKNCOMBI-COUNT  PIC S9(9)   BINARY.
                04  J023-HKNCOMBI-ITEM
                        PIC X(55)   OCCURS  30 TIMES.
              03  J023-SRYKACOMB.
                04  J023-SRYKA.
                  05  J023-VALUE  PIC X(20).
                04  J023-SRYKA-COUNT  PIC S9(9)   BINARY.
                04  J023-SRYKA-ITEM
                        PIC X(20)   OCCURS  41 TIMES.
              03  J023-NYUGAIKBNCOMB.
                04  J023-NYUGAIKBN.
                  05  J023-VALUE  PIC X(55).
                04  J023-NYUGAIKBN-COUNT  PIC S9(9)   BINARY.
                04  J023-NYUGAIKBN-ITEM
                        PIC X(55)   OCCURS  2 TIMES.
              03  J023-SCROLLEDWINDOW1.
                04  J023-RECELIST.
                  05  J023-RECE-COUNT  PIC S9(9)   BINARY.
                  05  J023-RECE-ROW  PIC S9(9)   BINARY.
                  05  J023-RECE-ROWATTR  PIC S9(9)   BINARY.
                  05  J023-ITEM       OCCURS  100 TIMES.
                    06  J023-TRENNUM   PIC X(3).
                    06  J023-TSRYYM    PIC X(6).
                    06  J023-TSRYKA    PIC X(10).
                    06  J023-THKNCOMBI PIC X(50).
                    06  J023-TSRYDD    PIC X(3).
                    06  J023-TCOMMENT  PIC X(100).
                  05  J023-RECE-SELECT PIC X       OCCURS  100 TIMES.
              03  J023-SELNUM.
                04  J023-VALUE  PIC X(40).
              03  J023-MIDASI-G.
                04  J023-MIDASI-STYLE  PIC X(20).
                04  J023-MIDASI       PIC X(20).
