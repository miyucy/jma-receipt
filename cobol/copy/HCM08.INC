        01  HCM08.
            02  HCM08-SYORIYMD  PIC X(24).
            02  HCM08-PAGE  PIC X(3).
            02  HCM08-NAIYO-TBL         OCCURS  30 TIMES.
              03  HCM08-SRYKA PIC X(8).
              03  HCM08-PTNUM PIC X(20).
              03  HCM08-NAME  PIC X(34).
              03  HCM08-SEX   PIC X(2).
              03  HCM08-BIRTHDAY  PIC X(22).
              03  HCM08-DENPNUM   PIC X(7).
              03  HCM08-SRYMD PIC X(5).
              03  HCM08-SEIKYU    PIC X(9).
              03  HCM08-RYOSYU    PIC X(9).
              03  HCM08-MISYU PIC X(9).
              03  HCM08-JYOTAI    PIC X(16).
            02  HCM08-TTL-TBL           OCCURS  3 TIMES.
              03  HCM08-TTLMSG    PIC X(10).
              03  HCM08-SEIKYUTTL PIC X(9).
              03  HCM08-RYOSYUTTL PIC X(9).
              03  HCM08-MISYUTTL  PIC X(9).
            02  HCM08-SEIKYUTTLMSG  PIC X(10).
            02  HCM08-RYOSYUTTLMSG  PIC X(10).
            02  HCM08-MISYUTTLMSG   PIC X(10).
