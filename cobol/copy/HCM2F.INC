        01  HCM2F.
            02  HCM2F-HOSPCD    PIC X(20).
            02  HCM2F-TITLE PIC X(36).
            02  HCM2F-HKN-TBL.
              03  HCM2F-HKN-TBLG          OCCURS  4 TIMES.
                04  HCM2F-HKN-G     OCCURS  2 TIMES.
                  05  HCM2F-KENSU PIC X(6).
                  05  HCM2F-NISSU PIC X(6).
                  05  HCM2F-TENSU PIC X(10).
                  05  HCM2F-YKZFTN    PIC X(8).
                  05  HCM2F-ITBFTN    PIC X(9).
            02  HCM2F-KOHNUM    PIC X(3)        OCCURS  2 TIMES.
            02  HCM2F-KOHNAME   PIC X(12)       OCCURS  2 TIMES.
            02  HCM2F-SYO-TBL.
              03  HCM2F-SYO-TBLG          OCCURS  4 TIMES.
                04  HCM2F-SYOKENSU  PIC X(6).
                04  HCM2F-SYONISSU  PIC X(6).
                04  HCM2F-SYOKINGAK PIC X(9).
                04  HCM2F-SYOFTNGAK PIC X(9).
