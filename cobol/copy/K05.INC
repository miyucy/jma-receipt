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
        02  K05.
      ****  02  K05-FIXED2.
              03  K05-SETCODE.
                04  K05-VALUE   PIC X(7).
              03  K05-NAME.
                04  K05-VALUE   PIC X(81).
              03  K05-SRYKBN    OCCURS  23.
                04  K05-VALUE   PIC X(3).
              03  K05-INPUTCD   OCCURS  23.
                04  K05-VALUE   PIC X(23).
              03  K05-MEISYO    OCCURS  23.
                04  K05-VALUE   PIC X(63).
              03  K05-SURYO     OCCURS  23.
                04  K05-VALUE   PIC X(21).
              03  K05-SYORINAME.
                04  K05-SYORINAME-STYLE   PIC X(20).
                04  K05-SYORINAME-VALUE   PIC X(21).
