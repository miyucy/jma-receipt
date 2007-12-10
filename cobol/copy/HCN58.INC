        01  HCN58.
            02  HCN58-PTNUM PIC X(20).
            02  HCN58-PAGE  PIC X(5).
            02  HCN58-RENNUM    PIC X(7).
            02  HCN58-KIGONUM   PIC X(10).
            02  HCN58-SRYYM PIC X(18).
            02  HCN58-KANANAME  PIC X(40).
            02  HCN58-NAME  PIC X(50).
            02  HCN58-SEX
                    PIC X(2)    OCCURS  2 TIMES.
            02  HCN58-BIRTHG
                    PIC X(2)    OCCURS  4 TIMES.
            02  HCN58-BIRTHYY   PIC X(2).
            02  HCN58-HOSPADRS  PIC X(100).
            02  HCN58-HOSPNAME  PIC X(80).
            02  HCN58-BYOMEI
                    PIC X(54)   OCCURS  5 TIMES.
            02  HCN58-SRYYMD
                    PIC X(24)   OCCURS  5 TIMES.
            02  HCN58-TENKI-G           OCCURS  5 TIMES.
              03  HCN58-TENKI
                      PIC X(2)    OCCURS  3 TIMES.
            02  HCN58-JNISSU    PIC X(2).
            02  HCN58-SHOSHIN
                    PIC X(2)    OCCURS  3 TIMES.
            02  HCN58-SIDOTIME  PIC X(10).
            02  HCN58-ZAITAKUTIME   PIC X(10).
            02  HCN58-KHNTEN
                    PIC X(7)    OCCURS  18 TIMES.
            02  HCN58-KAISU
                    PIC X(3)    OCCURS  21 TIMES.
            02  HCN58-SYUGITEN
                    PIC X(7)    OCCURS  21 TIMES.
            02  HCN58-YKZTEN
                    PIC X(7)    OCCURS  21 TIMES.
            02  HCN58-NYUING    PIC X(4).
            02  HCN58-HOSPSBT
                    PIC X(2)    OCCURS  2 TIMES.
            02  HCN58-NYUSYUBETSU
                    PIC X(10)   OCCURS  5 TIMES.
            02  HCN58-NYUKHNTEN
                    PIC X(7)    OCCURS  8 TIMES.
            02  HCN58-NYUKHNTENN
                    PIC X(10)   OCCURS  8 TIMES.
            02  HCN58-NYUKAISU
                    PIC X(3)    OCCURS  10 TIMES.
            02  HCN58-NYUSYUGITEN
                    PIC X(7)    OCCURS  10 TIMES.
            02  HCN58-NYUYKZTEN
                    PIC X(7)    OCCURS  10 TIMES.
            02  HCN58-SYOUKEI
                    PIC X(7)    OCCURS  3 TIMES.
            02  HCN58-SYOKJN-KHN    PIC X(2).
            02  HCN58-SYOKJN    PIC X(4).
            02  HCN58-SYOKHNTEN
                    PIC X(7)    OCCURS  4 TIMES.
            02  HCN58-SYOKAKERU
                    PIC X(4)    OCCURS  4 TIMES.
            02  HCN58-SYOKAISU
                    PIC X(3)    OCCURS  4 TIMES.
            02  HCN58-SYONICHI
                    PIC X(4)    OCCURS  4 TIMES.
            02  HCN58-SYOKINGAKU
                    PIC X(7)    OCCURS  4 TIMES.
            02  HCN58-SYOEN PIC X(2).
            02  HCN58-GOKEI
                    PIC X(7)    OCCURS  4 TIMES.
            02  HCN58-SRYKBN
                    PIC X(2)    OCCURS  50 TIMES.
            02  HCN58-TEKIYO
                    PIC X(52)   OCCURS  50 TIMES.
