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
        02  Y03.
      ***   02  Y03-FIXED1.
              03  Y03-SRYMD.
                04  Y03-VALUE   PIC X(10).
              03  Y03-HYODAI.
                04  Y03-VALUE   PIC X(21).
              03  Y03-SCROLLEDWINDOW1.
                04  Y03-TSLIST.
                  05  Y03-COUNT   PIC S9(9)   BINARY.
                  05  Y03-ITEM        OCCURS  90 TIMES.
                        08  Y03-NUM  PIC X(4).
                        08  Y03-YYKTIME  PIC X(5).
                        08  Y03-SRYKA  PIC X(10).
                        08  Y03-SRYNAIYO  PIC X(8).
                        08  Y03-DRNAME  PIC X(12).
                        08  Y03-NAME  PIC X(20).
                        08  Y03-PTNUM  PIC X(20).
                        08  Y03-RENRAKU  PIC X(15).
                        08  Y03-RAIIN  PIC X(4).
                  05  Y03-SELECT  PIC X       OCCURS  90 TIMES.
