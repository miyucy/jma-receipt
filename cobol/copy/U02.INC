      *******************************************************************
      * Project code name "ORCA"
      * 日医標準レセプトソフト（JMA standard receipt software）
      * Copyright(C) 2002 JMA (Japan Medical Association)
      *
      * This program is part of "JMA standard receipt software".
      *
      *     This program is distributed in the hope that it will be useful
      * for further advancement in medical care, according to JMA Open
      * Source License, but WITHOUT ANY WARRANTY.
      *     Everyone is granted permission to use, copy, modify and
      * redistribute this program, but only under the conditions described
      * in the JMA Open Source License. You should have received a copy of
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
         02  U02.
    ****    02  U02-FIXED1.
              03  U02-SRYYMD.
                04  U02-VALUE   PIC X(31).
              03  U02-PTNUM-G.
                04  U02-PTNUM-STATE   PIC S9(9)   BINARY.
                04  U02-PTNUM        PIC X(21).
              03  U02-NAME-G.
                04  U02-NAME-STATE   PIC S9(9)   BINARY.
                04  U02-NAME         PIC X(51).
              03  U02-BIRTHDAY.
                04  U02-VALUE   PIC X(10).
              03  U02-SRYKA-COMBO.
                04  U02-SRYKA.
                  05  U02-VALUE   PIC X(22).
                04  U02-SRYKA-COUNT   PIC S9(9)   BINARY.
                04  U02-SRYKA-ITEM    PIC X(21)   OCCURS  99 TIMES.
              03  U02-DRNAME-COMBO.
                04  U02-DRNAME.
                  05  U02-VALUE   PIC X(28).
                04  U02-DRNAME-COUNT   PIC S9(9)   BINARY.
                04  U02-DRNAME-ITEM    PIC X(27)   OCCURS  50 TIMES.
              03  U02-SRYNAIYO-COMBO.
                04  U02-SRYNAIYO.
                  05  U02-VALUE   PIC X(22).
                04  U02-SRYNAIYO-COUNT   PIC S9(9)   BINARY.
                04  U02-SRYNAIYO-ITEM    PIC X(21)   OCCURS  10 TIMES.
              03  U02-KARUTE-COMBO.
                04  U02-KARUTE.
                  05  U02-VALUE   PIC X(15).
                04  U02-KARUTE-COUNT   PIC S9(9)   BINARY.
                04  U02-KARUTE-ITEM    PIC X(14)   OCCURS  2 TIMES.
              03  U02-SYOHO-COMBO.
                04  U02-SYOHO.
                  05  U02-VALUE   PIC X(15).
                04  U02-SYOHO-COUNT   PIC S9(9)   BINARY.
                04  U02-SYOHO-ITEM    PIC X(14)   OCCURS  2 TIMES.
              03  U02-HKNCOMBI.
                04  U02-VALUE   PIC S9(4).
              03  U02-SELNUM.
                04  U02-VALUE   PIC S9(4).
              03  U02-SCROLLEDWINDOW3.
                04  U02-HKNCOMBI-LIST.
                  05  U02-HKNCOMBI-COUNT   PIC S9(9)   BINARY.
                  05  U02-ITEM        OCCURS  15 TIMES.
                    07  U02-HCNUM   PIC X(5).
                    07  U02-HCHKN   PIC X(11).
                    07  U02-HCKOH1  PIC X(11).
                    07  U02-HCKOH2  PIC X(11).
                    07  U02-HCKOH3  PIC X(11).
                    07  U02-HCKOH4  PIC X(11).
                  05  U02-HKNCOMBI-SELECT  PIC X       OCCURS  15 TIMES.
              03  U02-MIKAKUNINN-LIST.
                04  U02-MIKAKUNINN-COUNT   PIC S9(9)   BINARY.
                04  U02-ITEM        OCCURS  5 TIMES.
                  05  U02-MLSEIDONAME       PIC X(22).
                  05  U02-MLKIGONUM         PIC X(40).
                  05  U02-MLLASTYMD         PIC X(10).
                04  U02-MIKAKUNINN-SELECT  PIC X       OCCURS  5 TIMES.
              03  U02-BHK1.
                04  U02-BHK1-VALUE   PIC X.
                04  U02-BHK1-LABEL   PIC X(3).
              03  U02-BHK2.
                04  U02-BHK2-VALUE   PIC X.
                04  U02-BHK2-LABEL   PIC X(3).
              03  U02-BHK3.
                04  U02-BHK3-VALUE   PIC X.
                04  U02-BHK3-LABEL   PIC X(3).
              03  U02-BHK4.
                04  U02-BHK4-VALUE   PIC X.
                04  U02-BHK4-LABEL   PIC X(3).
              03  U02-BHK5.
                04  U02-BHK5-VALUE   PIC X.
                04  U02-BHK5-LABEL   PIC X(3).
              03  U02-SCROLLEDWINDOW4.
                04  U02-UKETUKE-LIST.
                  05  U02-UKETUKE-COUNT   PIC S9(9)   BINARY.
                  05  U02-UKETUKE-ITEM        OCCURS  100 TIMES.
                    07  U02-ULNUM         PIC X(5).
                    07  U02-ULYYKTIME     PIC X(6).
                    07  U02-ULUKETUKETIME PIC X(6).
                    07  U02-ULPTNUM       PIC X(21).
                    07  U02-ULNAME        PIC X(51).
                    07  U02-ULSRYKA       PIC X(11).
                    07  U02-ULDRNAME      PIC X(21).
                    07  U02-ULSRYNAIYO    PIC X(21).
                    07  U02-ULRRKYMD      PIC X(10).
                  05  U02-UKETUKE-SELECT  PIC X       OCCURS  100 TIMES.
