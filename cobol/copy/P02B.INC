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
      * this license along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
        02  P02B.
     *******02  P02B-FIXED10.
              03  P02B-TEKSTYMD.
                04  P02B-VALUE  PIC X(11).
              03  P02B-TEKEDYMD.
                04  P02B-VALUE  PIC X(11).
              03  P02B-HIHKNJANAME.
                04  P02B-VALUE  PIC X(51).
              03  P02B-KAKUNINYMD.
                04  P02B-VALUE  PIC X(11).
              03  P02B-HKNJANUM.
                04  P02B-VALUE  PIC X(9).
              03  P02B-KIGO.
                04  P02B-VALUE  PIC X(41).
              03  P02B-NUM.
                04  P02B-VALUE  PIC X(41).
              03  P02B-HKNJAADRS.
                04  P02B-VALUE  PIC X(35).
              03  P02B-HKNJABANTI.
                04  P02B-VALUE  PIC X(35).
              03  P02B-HKNJATEL.
                04  P02B-VALUE  PIC X(35).
              03  P02B-HKNJANAME.
                04  P02B-VALUE  PIC X(35).
              03  P02B-HKNNUMCOMB.
                04  P02B-HKNNUM.
                  05  P02B-VALUE  PIC X(21).
                04  P02B-HKNNUM-COUNT  PIC S9(9)   BINARY.
                04  P02B-HKNNUM-ITEM   PIC X(20)   OCCURS  50 TIMES.
              03  P02B-HONKZKKBNCOMB.
                04  P02B-HONKZKKBN.
                  05  P02B-VALUE  PIC X(7).
                04  P02B-HONKZKKBN-COUNT  PIC S9(9)   BINARY.
                04  P02B-HONKZKKBN-ITEM   PIC X(6)    OCCURS  5 TIMES.
              03  P02B-HOJOKBNCOMB.
                04  P02B-HOJOKBN.
                  05  P02B-VALUE  PIC X(7).
                04  P02B-HOJOKBN-COUNT  PIC S9(9)   BINARY.
                04  P02B-HOJOKBN-ITEM   PIC X(6)    OCCURS  5 TIMES.
              03  P02B-KEIKBNCOMB.
                04  P02B-KEIKBN.
                  05  P02B-VALUE  PIC X(7).
                04  P02B-KEIKBN-COUNT  PIC S9(9)   BINARY.
                04  P02B-KEIKBN-ITEM   PIC X(6)    OCCURS  2 TIMES.
              03  P02B-SKKGETYMD.
                04  P02B-VALUE  PIC X(11).
