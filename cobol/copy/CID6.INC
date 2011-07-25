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
        02  CID6.
              03  CID6-B10-STATE
                                PIC S9(9)   BINARY.
              03  CID6-B12-STATE
                                PIC S9(9)   BINARY.
              03  CID6-BYOMEICD1.
                04  CID6-VALUE  PIC X(10).
              03  CID6-BYOMEI1.
                04  CID6-VALUE  PIC X(70).
              03  CID6-BYOMEICD2.
                04  CID6-VALUE  PIC X(10).
              03  CID6-BYOMEI2.
                04  CID6-VALUE  PIC X(70).
              03  CID6-MSG.
                04  CID6-VALUE  PIC X(120).
              03  CID6-BYOMEICD PIC X(07)  OCCURS  6.
              03  CID6-BYOMEI10.
                04  CID6-VALUE  PIC X(90).
              03  CID6-MSG1.
                04  CID6-VALUE  PIC X(80).
              03  CID6-MSG2.
                04  CID6-VALUE  PIC X(120).
