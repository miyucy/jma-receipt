            02  W12.
              03  W12-YUKOSTYMD.
                04  W12-VALUE   PIC X(9).
              03  W12-YUKOEDYMD.
                04  W12-VALUE   PIC X(9).
              03  W12-NOTE3.
                04  W12-PAGENO  PIC S9(9)   BINARY.
                04  W12-FI23.
                  05  W12-RECEDENOUT.
                    06  W12-VALUE   PIC X(30).
                  05  W12-PREFPRGID.
                    06  W12-VALUE   PIC X(15).
                  05  W12-PREFPRGID1-STATE   PIC S9(9)   BINARY.
                  05  W12-PREFPRGID1       PIC X(15).
                  05  W12-SYAPRTNM.
                    06  W12-VALUE   PIC X(16).
                  05  W12-SYAPRTNM-NEXT.
                    06  W12-VALUE   PIC X(16).
                  05  W12-KKHPRTNM.
                    06  W12-VALUE   PIC X(16).
                  05  W12-KKHPRTNM-NEXT.
                    06  W12-VALUE   PIC X(16).
                  05  W12-SYUBYOHENFLG-COMBO.
                    06  W12-SYUBYOHENFLG.
                      07  W12-VALUE   PIC X(46).
                    06  W12-SYUBYOHENFLG-COUNT   PIC S9(9)   BINARY.
                    06  W12-SYUBYOHENFLGLST
                            PIC X(46)   OCCURS  4 TIMES.
                  05  W12-SYAPRTNM-N.
                    06  W12-VALUE   PIC X(16).
                  05  W12-SYAPRTNM-NEXT-N.
                    06  W12-VALUE   PIC X(16).
                  05  W12-KKHPRTNM-N.
                    06  W12-VALUE   PIC X(16).
                  05  W12-KKHPRTNM-NEXT-N.
                    06  W12-VALUE   PIC X(16).
                  05  W12-NEXTPRTKBN1-COMBO.
                    06  W12-NEXTPRTKBN1.
                      07  W12-VALUE   PIC X(16).
                    06  W12-NEXTPRTKBN1-COUNT   PIC S9(9)   BINARY.
                    06  W12-NEXTPRTKBN1LST
                            PIC X(16)   OCCURS  4 TIMES.
                  05  W12-NEXTPRTKBN-COMBO.
                    06  W12-NEXTPRTKBN.
                      07  W12-VALUE   PIC X(16).
                    06  W12-NEXTPRTKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-NEXTPRTKBNLST
                            PIC X(16)   OCCURS  3 TIMES.
                  05  W12-JIHITEKKSIKBN-COMBO.
                    06  W12-JIHITEKKSIKBN.
                      07  W12-VALUE   PIC X(10).
                    06  W12-JIHITEKKSIKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-JIHITEKKSIKBNLST
                            PIC X(10)   OCCURS  2 TIMES.
                  05  W12-RECECOMKBN-COMBO.
                    06  W12-RECECOMKBN.
                      07  W12-VALUE   PIC X(26).
                    06  W12-RECECOMKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-RECECOMKBNLST
                            PIC X(26)   OCCURS  2 TIMES.
                  05  W12-BYOMEIHENKBN-COMBO.
                    06  W12-BYOMEIHENKBN.
                      07  W12-VALUE   PIC X(20).
                    06  W12-BYOMEIHENKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-BYOMEIHENKBNLST
                            PIC X(20)   OCCURS  2 TIMES.
                  05  W12-BYOMEIHENKBN1-COMBO.
                    06  W12-BYOMEIHENKBN1.
                      07  W12-VALUE   PIC X(22).
                    06  W12-BYOMEIHENKBN1-COUNT   PIC S9(9)   BINARY.
                    06  W12-BYOMEIHENKBN1LST
                            PIC X(22)   OCCURS  2 TIMES.
                  05  W12-TENKIHENKBN-COMBO.
                    06  W12-TENKIHENKBN.
                      07  W12-VALUE   PIC X(20).
                    06  W12-TENKIHENKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-TENKIHENKBNLST
                            PIC X(20)   OCCURS  2 TIMES.
                  05  W12-SYARECEKBN-COMBO.
                    06  W12-SYARECEKBN.
                      07  W12-VALUE   PIC X(24).
                    06  W12-SYARECEKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-SYARECEKBNLST
                            PIC X(24)   OCCURS  4 TIMES.
                  05  W12-KKHRECEKBN-COMBO.
                    06  W12-KKHRECEKBN.
                      07  W12-VALUE   PIC X(24).
                    06  W12-KKHRECEKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-KKHRECEKBNLST
                            PIC X(24)   OCCURS  4 TIMES.
                  05  W12-SYAOCRKBN-COMBO.
                    06  W12-SYAOCRKBN.
                      07  W12-VALUE   PIC X(24).
                    06  W12-SYAOCRKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-SYAOCRKBNLST
                            PIC X(24)   OCCURS  4 TIMES.
                  05  W12-KKHOCRKBN-COMBO.
                    06  W12-KKHOCRKBN.
                      07  W12-VALUE   PIC X(24).
                    06  W12-KKHOCRKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-KKHOCRKBNLST
                            PIC X(24)   OCCURS  4 TIMES.
                  05  W12-RJNGNBKKBN-COMBO.
                    06  W12-RJNGNBKKBN.
                      07  W12-VALUE   PIC X(24).
                    06  W12-RJNGNBKKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-RJNGNBKKBNLST
                            PIC X(24)   OCCURS  4 TIMES.
                  05  W12-RENNUMHENKBN-COMBO.
                    06  W12-RENNUMHENKBN.
                      07  W12-VALUE   PIC X(22).
                    06  W12-RENNUMHENKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-RENNUMHENKBNLST
                            PIC X(22)   OCCURS  3 TIMES.
                  05  W12-PRTJYUNKBN2-COMBO.
                    06  W12-PRTJYUNKBN2.
                      07  W12-VALUE   PIC X(26).
                    06  W12-PRTJYUNKBN2-COUNT   PIC S9(9)   BINARY.
                    06  W12-PRTJYUNKBN2LST
                            PIC X(26)   OCCURS  5 TIMES.
                  05  W12-PRTJYUNKBN1-COMBO.
                    06  W12-PRTJYUNKBN1.
                      07  W12-VALUE   PIC X(26).
                    06  W12-PRTJYUNKBN1-COUNT   PIC S9(9)   BINARY.
                    06  W12-PRTJYUNKBN1LST
                            PIC X(26)   OCCURS  4 TIMES.
                  05  W12-AUTODSPKBN-COMBO.
                    06  W12-AUTODSPKBN.
                      07  W12-VALUE   PIC X(20).
                    06  W12-AUTODSPKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-AUTODSPKBNLST
                            PIC X(20)   OCCURS  2 TIMES.
                  05  W12-SRYKAHENKBN-COMBO.
                    06  W12-SRYKAHENKBN.
                      07  W12-VALUE   PIC X(20).
                    06  W12-SRYKAHENKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-SRYKAHENKBNLST
                            PIC X(20)   OCCURS  2 TIMES.
                04  W12-FI24.
                  05  W12-KKHPRTKBN-COMBO.
                    06  W12-KKHPRTKBN.
                      07  W12-VALUE   PIC X(20).
                    06  W12-KKHPRTKBN-COUNT   PIC S9(9)   BINARY.
                    06  W12-KKHPRTKBNLST
                            PIC X(20)   OCCURS  2 TIMES.
