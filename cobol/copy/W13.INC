        02  W13.
              03  W13-YUKOSTYMD.
                04  W13-VALUE   PIC X(10).
              03  W13-YUKOEDYMD.
                04  W13-VALUE   PIC X(10).
              03  W13-RSIIRYOCDN.
                04  W13-VALUE   PIC X(41).
              03  W13-SONSHOUKBN1.
                04  W13-VALUE   PIC X(3).
              03  W13-SONSHOUKBN2.
                04  W13-VALUE   PIC X(2).
              03  W13-SONSHOUNAME.
                04  W13-VALUE   PIC X(61).
              03  W13-SCROLLEDWINDOW6.
                04  W13-SONSHOUKBNLST.
                  05  W13-SONSHOUKBN-COUNT   PIC S9(9)   BINARY.
                  05  W13-SONSHOUKBN-ITEM    OCCURS  40 TIMES.
                    06  W13-TSONSHOUKBN      PIC X(4).
                    06  W13-TSONSHOUNAME     PIC X(60).
                  05  W13-SONSHOUKBN-SELECT  PIC X   OCCURS  40 TIMES.
              03  W13-TENKBN-COMBO.
                04  W13-TENKBN         PIC X(21).
                04  W13-TENKBN-COUNT   PIC S9(9)   BINARY.
                04  W13-TENKBNLST      PIC X(20)   OCCURS  2 TIMES.
              03  W13-KSNRATE.
                04  W13-VALUE   PIC S9(2).
              03  W13-RSIIRYOKBN-COMBO.
                04  W13-RSIIRYOKBN       PIC X(21).
                04  W13-RSIIRYOKBN-COUNT PIC S9(9)   BINARY.
                04  W13-RSIIRYOKBNLST    PIC X(20)   OCCURS  2 TIMES.
