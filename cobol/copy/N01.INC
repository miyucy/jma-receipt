        02  N01.
      *      02  N01-FIXED6.
              03  N01-HKNJANUM.
                04  N01-VALUE   PIC X(8).
              03  N01-HKNJANAME.
                04  N01-VALUE   PIC X(100).
              03  N01-HKNJANAMETAN1.
                04  N01-VALUE   PIC X(50).
              03  N01-HKNJANAMETAN2.
                04  N01-VALUE   PIC X(20).
              03  N01-HKNJANAMETAN3.
                04  N01-VALUE   PIC X(20).
              03  N01-HKNNUMCOMBO.
                04  N01-HKNNUM.
                  05  N01-VALUE   PIC X(30).
                04  N01-HKNNUM-COUNT   PIC S9(9)   BINARY.
                04  N01-HKNNUM-ITEM
                        PIC X(30)   OCCURS  100 TIMES.
              03  N01-KYURATE1COMBO.
                04  N01-KYURATE1.
                  05  N01-VALUE   PIC X(30).
                04  N01-KYURATE1-STATE   PIC S9(9)   BINARY.
                04  N01-KYURATE1-COUNT   PIC S9(9)   BINARY.
                04  N01-KYURATE1-ITEM
                        PIC X(30)   OCCURS  3 TIMES.
              03  N01-KYURATE2COMBO.
                04  N01-KYURATE2.
                  05  N01-VALUE   PIC X(30).
                04  N01-KYURATE2-STATE   PIC S9(9)   BINARY.
                04  N01-KYURATE2-COUNT   PIC S9(9)   BINARY.
                04  N01-KYURATE2-ITEM
                        PIC X(30)   OCCURS  3 TIMES.
              03  N01-POST.
                04  N01-VALUE   PIC X(7).
              03  N01-ADRS.
                04  N01-VALUE   PIC X(100).
              03  N01-BANTI.
                04  N01-VALUE   PIC X(100).
              03  N01-TEL.
                04  N01-VALUE   PIC X(15).
              03  N01-KIGO.
                04  N01-VALUE   PIC X(40).
              03  N01-IDOKBNCOBO.
                04  N01-IDOKBN.
                  05  N01-VALUE   PIC X(30).
                04  N01-IDOKBN-COUNT   PIC S9(9)   BINARY.
                04  N01-IDOKBN-ITEM
                        PIC X(30)   OCCURS  10 TIMES.
              03  N01-IDOYMD.
                04  N01-VALUE   PIC X(10).
