        01  HCM30.
            02  HCM30-STRSRYYMD PIC X(22).
            02  HCM30-ENDSRYYMD PIC X(22).
            02  HCM30-PTNUM PIC X(20).
            02  HCM30-PTNAME    PIC X(20).
            02  HCM30-HAKKOYMD  PIC X(22).
            02  HCM30-PAGE  PIC X(3).
            02  HCM30-SRYYMD    PIC X(12)       OCCURS  40 TIMES.
            02  HCM30-HKNTEN    PIC X(7)        OCCURS  40 TIMES.
            02  HCM30-TEN   PIC X(2)    OCCURS  40 TIMES.
            02  HCM30-SKYMONEY  PIC X(11)       OCCURS  40 TIMES.
            02  HCM30-YEN   PIC X(2)    OCCURS  40 TIMES.
            02  HCM30-GHKNTEN   PIC X(7).
            02  HCM30-GSKYMONEY PIC X(11).
            02  HCM30-HOSPADRS  PIC X(60).
            02  HCM30-HOSPNAME  PIC X(40).
            02  HCM30-HOSPTEL   PIC X(15).
