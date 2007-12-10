        01  HCM60.
            02  HCM60-PREFNUM.
              03  HCM60-PREFNUM-S
                      PIC X(1)    OCCURS  2 TIMES.
            02  HCM60-HOSPCD.
              03  HCM60-HOSPCD-S
                      PIC X(1)    OCCURS  7 TIMES.
            02  HCM60-SRYYM.
              03  HCM60-SRYY  PIC X(2).
              03  HCM60-SRYM  PIC X(2).
            02  HCM60-HOSPSBT
                    PIC X(2)    OCCURS  2 TIMES.
            02  HCM60-SEIKYUYMD.
              03  HCM60-SEIKYUYY  PIC X(2).
              03  HCM60-SEIKYUMM  PIC X(2).
              03  HCM60-SEIKYUDD  PIC X(2).
            02  HCM60-HOSPADRS  PIC X(80).
            02  HCM60-HOSPNAME  PIC X(80).
            02  HCM60-DRNAME    PIC X(40).
            02  HCM60-HOSPTEL   PIC X(15).
            02  HCM60-ATENA PIC X(20).
