        02  W07.
    ********02  W07-FIXED1.
              03  W07-B03.
                04  W07-B03-STATE   PIC S9(9)   BINARY.
              03  W07-YUKOSTYMD.
                04  W07-VALUE   PIC X(9).
              03  W07-YUKOEDYMD.
                04  W07-VALUE   PIC X(9).
              03  W07-NOTEBOOK1.
                04  W07-PAGENO  PIC S9(9)   BINARY.
                04  W07-TAG1.
                    05  W07-DATA-TBL      OCCURS  7.
                      06  W07-DATA-COMBO.
                          07  W07-DATA.
                              08  W07-VALUE   PIC X(12).
                      06  W07-COUNT       PIC S9(9)   BINARY.
                      06  W07-DATALST     PIC X(12)   OCCURS  2.
                  05  W07-SRYKACD-G.
                    06  W07-SRYKACD-STATE   PIC S9(9)   BINARY.
                    06  W07-SRYKACD         PIC X(2).
                  05  W07-SRYKAMEI.
                    06  W07-VALUE   PIC X(20).
                  05  W07-NYUSYOSIN-COMB.
                    06  W07-NYUSYOSIN.
                      07  W07-VALUE   PIC X(12).
                    06  W07-NYUSYOSIN-COUNT   PIC S9(9)   BINARY.
                    06  W07-NYUSYOSIN-ITEM    PIC X(12)   OCCURS  2.
                  05  W07-KIKAN.
                    06  W07-VALUE   PIC S9(2).
                  05  W07-GAIKANKBN-COMBO.
                    06  W07-GAIKANKBN.
                      07  W07-VALUE   PIC X(22).
                    06  W07-GAIKANKBN-COUNT   PIC S9(9)   BINARY.
                    06  W07-GAIKANKBN-ITEM    PIC X(22)   OCCURS  3.
                  05  W07-GAIMOVE-COMBO.
                    06  W07-GAIMOVE.
                      07  W07-VALUE   PIC X(22).
                    06  W07-GAIMOVE-COUNT   PIC S9(9)   BINARY.
                    06  W07-GAIMOVE-ITEM    PIC X(22)   OCCURS  3 TIMES.
                04  W07-TAGNAME1.
                  05  W07-TAGNAME1-STATE   PIC S9(9)   BINARY.
                04  W07-TAG2.
                  05  W07-BYOMEIKBN-COMBO.
                    06  W07-BYOMEIKBN.
                      07  W07-VALUE   PIC X(28).
                    06  W07-BYOMEIKBN-COUNT   PIC S9(9)   BINARY.
                    06  W07-BYOMEIKBN-ITEM    PIC X(28)   OCCURS  2.
                  05  W07-JISYOKBN-COMBO.
                    06  W07-JISYOKBN.
                      07  W07-VALUE   PIC X(28).
                    06  W07-JISYOKBN-COUNT   PIC S9(9)   BINARY.
                    06  W07-JISYOKBN-ITEM    PIC X(28)   OCCURS  2.
                  05  W07-HAKKOKBN-COMBO.
                    06  W07-HAKKOKBN.
                      07  W07-VALUE   PIC X(28).
                    06  W07-HAKKOKBN-COUNT   PIC S9(9)   BINARY.
                    06  W07-HAKKOKBN-ITEM    PIC X(28)   OCCURS  3.
                  05  W07-HOJYOKBN-COMBO.
                    06  W07-HOJYOKBN.
                      07  W07-VALUE   PIC X(28).
                    06  W07-HOJYOKBN-COUNT   PIC S9(9)   BINARY.
                    06  W07-HOJYOKBN-ITEM    PIC X(28)   OCCURS  2.
                04  W07-TAGNAME2.
                  05  W07-TAGNAME2-STATE   PIC S9(9)   BINARY.
