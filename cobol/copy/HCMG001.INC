        01  HCMG001.
            02  HCMG001-DAI PIC X(80).
            02  HCMG001-YMD PIC X(26).
            02  HCMG001-PAGE    PIC X(7).
            02  HCMG001-TAI-TBL.
              03  HCMG001-TAI-CD  PIC X(14).
              03  HCMG001-TAI-NAME    PIC X(48).
              03  HCMG001-TAI-TANI    PIC X(14).
              03  HCMG001-TAI-NAIYO   PIC X(14)   OCCURS  7 TIMES.
            02  HCMG001-NAI-TBL         OCCURS  35 TIMES.
              03  HCMG001-CD  PIC X(9).
              03  HCMG001-NAME    PIC X(48).
              03  HCMG001-TANI    PIC X(14).
              03  HCMG001-NAIYO   PIC X(10)       OCCURS  7 TIMES.
