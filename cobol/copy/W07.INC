            02  W07.
                03  W07-FIXED1.
                    04  W07-B03.
                      05  W07-B03-STATE       PIC S9(9)   BINARY.
                    04  W07-YUKOSTYMD         PIC X(9).
                    04  W07-YUKOEDYMD         PIC X(9).
                    04  W07-NOTEBOOK1.
                      05  W07-PAGENO          PIC S9(9)   BINARY.
                      05  W07-TAG1.
                        06  W07-DATA-TBL      OCCURS  7.
                          07  W07-DATA-COMBO.
                            08  W07-DATA.
                              09  W07-VALUE   PIC X(12).
                          07  W07-COUNT       PIC S9(9)   BINARY.
                          07  W07-DATALST     PIC X(12)   OCCURS  2.
                        06  W07-SRYKACD-G.
                          07  W07-SRYKACD-STATE   PIC S9(9)   BINARY.
                          07  W07-SRYKACD         PIC X(2).
                        06  W07-SRYKAMEI      PIC X(20).
                        06  W07-KIKAN         PIC S9(2).
                        06  W07-GAIKANKBN-COMBO.
                          07  W07-GAIKANKBN.
                            08  W07-VALUE     PIC X(22).
                          07  W07-GAIKANKBN-COUNT PIC S9(9)   BINARY.
                          07  W07-GAIKANKBN-ITEM  PIC X(22)   OCCURS  3.
                        06  W07-GAIMOVE-COMBO.
                          07  W07-GAIMOVE.
                            08  W07-VALUE     PIC X(22).
                          07  W07-GAIMOVE-COUNT   PIC S9(9)   BINARY.
                          07  W07-GAIMOVE-ITEM    PIC X(22)   OCCURS  3.
                      05  W07-TAGNAME1.
                        06  W07-TAGNAME1-STATE    PIC S9(9)   BINARY.
                      05  W07-TAG2.
                        06  W07-BYOMEIKBN-COMBO.
                          07  W07-BYOMEIKBN.
                            08  W07-VALUE     PIC X(28).
                          07  W07-BYOMEIKBN-COUNT PIC S9(9)   BINARY.
                          07  W07-BYOMEIKBN-ITEM  PIC X(28)   OCCURS  2.
                        06  W07-JISYOKBN-COMBO.
                          07  W07-JISYOKBN.
                            08  W07-VALUE     PIC X(28).
                          07  W07-JISYOKBN-COUNT  PIC S9(9)   BINARY.
                          07  W07-JISYOKBN-ITEM   PIC X(28)   OCCURS  2.
                        06  W07-HAKKOKBN-COMBO.
                          07  W07-HAKKOKBN.
                            08  W07-VALUE     PIC X(28).
                          07  W07-HAKKOKBN-COUNT  PIC S9(9)   BINARY.
                          07  W07-HAKKOKBN-ITEM   PIC X(28)   OCCURS  3.
                        06  W07-HOJYOKBN-COMBO.
                          07  W07-HOJYOKBN.
                            08  W07-VALUE     PIC X(28).
                          07  W07-HOJYOKBN-COUNT  PIC S9(9)   BINARY.
                          07  W07-HOJYOKBN-ITEM   PIC X(28)   OCCURS  2.
                      05  W07-TAGNAME2.
                        06  W07-TAGNAME2-STATE    PIC S9(9)   BINARY.
