        01  HCGS140G1.
            02  HCGS140G1-PAGE  PIC X(3).
            02  HCGS140G1-SRYYM PIC X(16).
            02  HCGS140G1-SYSYMD    PIC X(22).
            02  HCGS140G1-NYUGAI    PIC X(4).
            02  HCGS140G1-SRYKANAME PIC X(20).
            02  HCGS140G1-CITY-AREA.
              03  HCGS140G1-KBN1-TBL      OCCURS  3 TIMES.
                04  HCGS140G1-KENSU PIC X(4).
                04  HCGS140G1-NISSU PIC X(4).
                04  HCGS140G1-TENSU PIC X(9).
                04  HCGS140G1-FTNMONEY  PIC X(9).
                04  HCGS140G1-HKNMONEY  PIC X(9).
                04  HCGS140G1-KOHMONEY  PIC X(9).
                04  HCGS140G1-TTLMONEY  PIC X(9).
              03  HCGS140G1-KOHI-TBL      OCCURS  21 TIMES.
                04  HCGS140G1-KOHNAME   PIC X(24).
                04  HCGS140G1-KOHKENSU  PIC X(4).
                04  HCGS140G1-KOHNISSU  PIC X(4).
                04  HCGS140G1-KOHTENSU  PIC X(9).
