              03  W14.
                04  W14-FIXED2.
                  05  W14-STYUKYMD.
                    06  W14-VALUE   PIC X(10).
                  05  W14-EDYUKYMD.
                    06  W14-VALUE   PIC X(10).
                04  W03-CD-G   OCCURS 25.
                  05  W14-CD.
                    06  W14-VALUE   PIC X(5).
                04  W03-SHELLID-G   OCCURS 25.
                  05  W14-SHELLID.
                    06  W14-VALUE   PIC X(21).
                04  W03-SHORIMSG-G   OCCURS 25.
                  05  W14-SHORIMSG.
                    06  W14-VALUE   PIC X(41).
                04  W03-CHKBTN01-G   OCCURS 25.
                  05  W14-CHK.
                    06  W14-CHKG     OCCURS 4.
                      07  W14-CHKBTN   PIC X.
