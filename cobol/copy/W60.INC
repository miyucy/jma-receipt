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
        02  W60.
      *     02  W60-FIXED1.
              03  W60-B03-STATE PIC S9(9)   BINARY.
              03  W60-MTRX             PIC X(02)
                                       OCCURS 5.
              03  W60-CHKMTRX          PIC X(01)
                                       OCCURS 5.
              03  W60-CMB-PRTSRTKBN.
                04  W60-PRTSRTKBN          PIC X(22).
                04  W60-PRTSRTKBN-COUNT    PIC S9(9)   BINARY.
                04  W60-PRTSRTKBN-ITEM     PIC X(22)   OCCURS  2.
