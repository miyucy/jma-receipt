        01  HCMG007.
            02  HCMG007-SRYYM   PIC X(16).
            02  HCMG007-NYUGAI  PIC X(4).
            02  HCMG007-SAKYMD  PIC X(22).
            02  HCMG007-PTNUM   PIC X(10).
            02  HCMG007-PAGE    PIC X(3).
            02  HCMG007-PTNUM2  PIC X(20).
            02  HCMG007-KANANAME    PIC X(50).
            02  HCMG007-NAME    PIC X(50).
            02  HCMG007-BIRTHDAY    PIC X(22).
            02  HCMG007-SRYKA   PIC X(10).
            02  HCMG007-NYUINYMD    PIC X(22).
            02  HCMG007-TAIINYMD    PIC X(22).
            02  HCMG007-HKNAREA         OCCURS  6 TIMES.
              03  HCMG007-HKNCOMBINUM PIC X(4).
              03  HCMG007-HKNCOMBIMEI PIC X(30).
              03  HCMG007-TEKSTYMD    PIC X(9).
              03  HCMG007-TEKEDYMD    PIC X(9).
              03  HCMG007-HKNNAME PIC X(10).
              03  HCMG007-HKNJANUM    PIC X(8).
              03  HCMG007-HONKZK  PIC X(4).
              03  HCMG007-FTNRATE PIC X(4).
              03  HCMG007-CONTKBN PIC X(4).
              03  HCMG007-KIGO    PIC X(34).
              03  HCMG007-NUM PIC X(34).
            02  HCMG007-BYOMEIAREA      OCCURS  10 TIMES.
              03  HCMG007-BYOMEI  PIC X(54).
              03  HCMG007-SRYKA   PIC X(2).
              03  HCMG007-SYUBYO  PIC X(2).
              03  HCMG007-SRYYMD  PIC X(9).
              03  HCMG007-TENKI   PIC X(10).
            02  HCMG007-SRYAREA         OCCURS  28 TIMES.
              03  HCMG007-SRYKBN  PIC X(2).
              03  HCMG007-HKNCOMBINUM2    PIC X(4).
              03  HCMG007-TEKIYO  PIC X(52).
              03  HCMG007-DAY PIC X(2)    OCCURS  31 TIMES.
