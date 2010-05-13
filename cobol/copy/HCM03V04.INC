        01  HCM03V04.
            02  HCM03V04-NO PIC X(7).
            02  HCM03V04-MIDASHI    PIC X(10).
            02  HCM03V04-HAKYMD PIC X(22).
            02  HCM03V04-PAGE   PIC X(3).
            02  HCM03V04-NAME   PIC X(30).
            02  HCM03V04-PTNUM  PIC X(20).
            02  HCM03V04-LBLSRYYMD  PIC X(10).
            02  HCM03V04-SRYYMD PIC X(30).
            02  HCM03V04-SRYKANAME  PIC X(20).
            02  HCM03V04-HOKEN  PIC X(20).
            02  HCM03V04-FUTAN  PIC X(3).
            02  HCM03V04-FUTANLABEL PIC X(2).
            02  HCM03V04-KINGAKU    PIC X(18).
            02  HCM03V04-GOKTEN PIC X(18).
            02  HCM03V04-FTNKIN PIC X(18).
            02  HCM03V04-JIHI   PIC X(18).
            02  HCM03V04-SEIKYU PIC X(18).
            02  HCM03V04-IRYOADRS   PIC X(100).
            02  HCM03V04-IRYOMEI    PIC X(100).
            02  HCM03V04-IRYOTEL    PIC X(15).
            02  HCM03V04-LABEL1 PIC X(16).
            02  HCM03V04-LABEL2 PIC X(16).
            02  HCM03V04-NAIYO1-TBL     OCCURS  25 TIMES.
              03  HCM03V04-SRYKBN1    PIC X(10).
              03  HCM03V04-SRYMEI1    PIC X(92).
              03  HCM03V04-KINGAKU1   PIC X(11).
              03  HCM03V04-KINGAKU12  PIC X(16).
              03  HCM03V04-KAISU1 PIC X(3).
              03  HCM03V04-KAISU12    PIC X(6).
            02  HCM03V04-NAIYO2-TBL     OCCURS  36 TIMES.
              03  HCM03V04-SRYKBN2    PIC X(10).
              03  HCM03V04-SRYMEI2    PIC X(92).
              03  HCM03V04-KINGAKU2   PIC X(11).
              03  HCM03V04-KINGAKU22  PIC X(16).
              03  HCM03V04-KAISU2 PIC X(3).
              03  HCM03V04-KAISU22    PIC X(6).
