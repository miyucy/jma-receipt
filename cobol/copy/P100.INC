        02  P100.
            03  P100-FIXED1                    OCCURS 2.
              04  P100-FRA-KANJI.
                05  P100-FIXED2.
                  06  P100-KANANAME           PIC X(50).
                  06  P100-SCR-KANJILST.
                    07  P100-KANJILST.
                      08  P100-KANJILST-COUNT  PIC S9(9)   BINARY.
                      08  P100-KANJILST-ITEM   OCCURS  50.
                        09  P100-KANJILST-NO   PIC X(02).
                        09  P100-KANJILST-KANJI
                                               PIC X(50).
                      08  P100-KANJILST-SELECT PIC X
                                               OCCURS  50.
                  06  P100-SELNUM              PIC S9(3).
                  06  P100-SELNUM-STATE        PIC S9(9)   BINARY.
                  06  P100-KANJINAME           PIC X(51).
