          02  W61.
              03  W61-SELNUM.
                04  W61-VALUE   PIC S9(3).
              03  W61-STYUKYMD.
                04  W61-VALUE   PIC X(10).
              03  W61-EDYUKYMD.
                04  W61-VALUE   PIC X(10).
              03  W61-HKNNUM.
                04  W61-VALUE   PIC X(3).
              03  W61-SEIDONAME.
                04  W61-VALUE   PIC X(50).
              03  W61-TEISYUTUSAKI-COMBO.
                04  W61-TEISYUTUSAKI         PIC X(12).
                04  W61-TEISYUTUSAKI-COUNT   PIC S9(9)   BINARY.
                04  W61-TEISYUTUSAKI-ITEM
                                          PIC X(12)   OCCURS  2 TIMES.
              03  W61-HKNJANUM.
                04  W61-VALUE   PIC X(8).
              03  W61-HKNJANAME.
                04  W61-VALUE   PIC X(100).
              03  W61-ZAITAKU-COMBO.
                04  W61-ZAITAKU         PIC X(12).
                04  W61-ZAITAKU-COUNT   PIC S9(9)   BINARY.
                04  W61-ZAITAKU-ITEM
                        PIC X(12)   OCCURS  2 TIMES.
              03  W61-RJNKBN-COMBO.
                04  W61-RJNKBN         PIC X(12).
                04  W61-RJNKBN-COUNT   PIC S9(9)   BINARY.
                04  W61-RJNKBN-ITEM
                        PIC X(12)   OCCURS  2 TIMES.
              03  W61-TOKKI.
                04  W61-VALUE   PIC X(12).
              03  W61-KYURATE.
                04  W61-VALUE   PIC S9(3).
              03  W61-FTNJANUMKBN-COMBO.
                04  W61-FTNJANUMKBN         PIC X(25).
                04  W61-FTNJANUMKBN-COUNT   PIC S9(9)   BINARY.
                04  W61-FTNJANUMKBN-ITEM
                        PIC X(25)   OCCURS  5 TIMES.
              03  W61-FTNJANUM.
                04  W61-VALUE   PIC X(8).
              03  W61-JKYSNUMKBN-COMBO.
                04  W61-JKYSNUMKBN         PIC X(25).
                04  W61-JKYSNUMKBN-COUNT   PIC S9(9)   BINARY.
                04  W61-JKYSNUMKBN-ITEM
                        PIC X(25)   OCCURS  5 TIMES.
              03  W61-JKYSNUM.
                04  W61-VALUE   PIC X(7).
              03  W61-RECEDEN-TOKKI.
                04  W61-VALUE   PIC X(2).
              03  W61-RECEDEN-KYURATE.
                04  W61-VALUE   PIC S9(3).
              03  W61-RECEDEN-KORECKBN-COMBO.
                04  W61-RECEDEN-KORECKBN         PIC X(12).
                04  W61-RECEDEN-KORECKBN-COUNT   PIC S9(9)   BINARY.
                04  W61-RECEDEN-KORECKBN-ITEM
                        PIC X(12)   OCCURS  2 TIMES.
              03  W61-RECEDEN-FTNJANUMKBN-COMBO.
                04  W61-RECEDEN-FTNJANUMKBN         PIC X(25).
                04  W61-RECEDEN-FTNJANUMKBN-COUNT   PIC S9(9)   BINARY.
                04  W61-RECEDEN-FTNJANUMKBN-ITEM
                        PIC X(25)   OCCURS  5 TIMES.
              03  W61-RECEDEN-FTNJANUM  PIC X(8).
              03  W61-RECEDEN-JKYSNUMKBN-COMBO.
                04  W61-RECEDEN-JKYSNUMKBN         PIC X(25).
                04  W61-RECEDEN-JKYSNUMKBN-COUNT   PIC S9(9)   BINARY.
                04  W61-RECEDEN-JKYSNUMKBN-ITEM
                        PIC X(25)   OCCURS  5 TIMES.
              03  W61-RECEDEN-JKYSNUM   PIC X(7).
              03  W61-SCROLLEDWINDOW28.
                04  W61-TOKKILST.
                  05  W61-COUNT   PIC S9(9)   BINARY.
                  05  W61-ROW PIC S9(9)   BINARY.
                  05  W61-ITEM            OCCURS  100 TIMES.
                    06  W61-TRENNUM       PIC X(3).
                    06  W61-THKNNUM       PIC X(3).
                    06  W61-TSEIDONAME    PIC X(50).
                    06  W61-TTEISYUTUSAKI PIC X(10).
                    06  W61-THKNJANUM     PIC X(8).
                    06  W61-TRJNKBN       PIC X(10).
                    06  W61-TZAITAKU      PIC X(10).
                    06  W61-TSTYUKYMD     PIC X(9).
                    06  W61-TEDYUKYMD     PIC X(9).
                  05  W61-SELECT
                          PIC X       OCCURS  100 TIMES.
