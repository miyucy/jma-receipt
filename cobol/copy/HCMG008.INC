        01  HCMG008.
            02  HCMG008-SRYYM   PIC X(16).
            02  HCMG008-NYUGAI  PIC X(4).
            02  HCMG008-SAKYMD  PIC X(22).
            02  HCMG008-PTNUM   PIC X(10).
            02  HCMG008-PAGE    PIC X(3).
            02  HCMG008-PTNUM2  PIC X(20).
            02  HCMG008-KANANAME    PIC X(50).
            02  HCMG008-NAME    PIC X(50).
            02  HCMG008-BIRTHDAY    PIC X(22).
            02  HCMG008-SRYKA   PIC X(10).
            02  HCMG008-NYUINYMD    PIC X(22).
            02  HCMG008-TAIINYMD    PIC X(22).
            02  HCMG008-SRYAREA         OCCURS  39 TIMES.
              03  HCMG008-SRYKBN  PIC X(2).
              03  HCMG008-HKNCOMBINUM2    PIC X(4).
              03  HCMG008-TEKIYO  PIC X(52).
              03  HCMG008-DAY PIC X(2)    OCCURS  31 TIMES.
