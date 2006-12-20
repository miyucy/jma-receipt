        01  HCM31N.
            02  HCM31N-STRSRYYMD    PIC X(22).
            02  HCM31N-ENDSRYYMD    PIC X(22).
            02  HCM31N-PTNUM    PIC X(20).
            02  HCM31N-PTNAME   PIC X(20).
            02  HCM31N-HAKKOYMD PIC X(22).
            02  HCM31N-PAGE PIC X(3).
            02  HCM31N-LABELYMD PIC X(10).
            02  HCM31N-SRYYMD
                    PIC X(12)   OCCURS  30 TIMES.
            02  HCM31N-HKNTEN
                    PIC X(9)    OCCURS  30 TIMES.
            02  HCM31N-TEN
                    PIC X(2)    OCCURS  30 TIMES.
            02  HCM31N-FTNMONEY
                    PIC X(11)   OCCURS  30 TIMES.
            02  HCM31N-HYEN
                    PIC X(2)    OCCURS  30 TIMES.
            02  HCM31N-SKJMONEY
                    PIC X(11)   OCCURS  30 TIMES.
            02  HCM31N-SYEN
                    PIC X(2)    OCCURS  30 TIMES.
            02  HCM31N-JIHIMONEY
                    PIC X(11)   OCCURS  30 TIMES.
            02  HCM31N-JYEN
                    PIC X(2)    OCCURS  30 TIMES.
            02  HCM31N-SKYMONEY
                    PIC X(11)   OCCURS  30 TIMES.
            02  HCM31N-YEN
                    PIC X(2)    OCCURS  30 TIMES.
            02  HCM31N-GHKNTEN  PIC X(9).
            02  HCM31N-GFTNMONEY    PIC X(11).
            02  HCM31N-GSKJMONEY    PIC X(11).
            02  HCM31N-GJIHIMONEY   PIC X(11).
            02  HCM31N-GSKYMONEY    PIC X(11).
            02  HCM31N-HOSPADRS PIC X(60).
            02  HCM31N-HOSPADRS2    PIC X(100).
            02  HCM31N-HOSPNAME PIC X(60).
            02  HCM31N-HOSPTEL  PIC X(15).
            02  HCM31N-NYUGAI   PIC X(8).
