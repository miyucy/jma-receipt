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
        02  R02.
              04  R02-B09.
                05  R02-B09-STATE   PIC S9(9)   BINARY.
              04  R02-B10.
                05  R02-B10-STATE   PIC S9(9)   BINARY.
              04  R02-SYOKBN.
                05  R02-SYOKBN-VALUE   PIC X.
                05  R02-SYOKBN-LABEL   PIC X(9).
              04  R02-TSTDATA-G    OCCURS  36.
                05  R02-TSTDATA-STATE   PIC S9(09) BINARY.
                05  R02-TSTDATA.
                  06  R02-VALUE   PIC X(101).
              04  R02-TEDDATA-G    OCCURS  36.
                05  R02-TEDDATA-STATE   PIC S9(09) BINARY.
                05  R02-TEDDATA.
                  06  R02-VALUE   PIC X(101).
              04  R02-TPAGE-G      OCCURS  36.
                05  R02-TPAGE.
                  06  R02-VALUE   PIC 9(4).
              04  R02-TKENSU-G      OCCURS  36.
                05  R02-TKENSU.
                  06  R02-VALUE   PIC 9(4).
              04  R02-TCHK-G       OCCURS  36.
                05  R02-TCHK.
                  06  R02-TCHK-STATE   PIC S9(09) BINARY.
                  06  R02-TCHK-VALUE   PIC X.
                  06  R02-TCHK-LABEL   PIC X(41).
              04  R02-FILEKBN.
                05  R02-VALUE     PIC X(41).
              04  R02-CREYMD.
                05  R02-VALUE     PIC X(23).
              04  R02-KENSU.
                05  R02-VALUE   PIC 9(4).
              04  R02-PAGE.
                05  R02-VALUE   PIC 9(4).
              04  R02-PRTJYUN-COMBO.
                05  R02-PRTJYUN.
                  06  R02-VALUE   PIC X(26).
                05  R02-PRTJYUN-COUNT   PIC S9(9)   BINARY.
                05  R02-PRTJYUNLST  PIC X(26)   OCCURS  5 TIMES.
              04  R02-PREFKBN-COMBO.
                05  R02-PREFKBN.
                  06  R02-VALUE   PIC X(7).
                05  R02-PREFKBN-COUNT   PIC S9(9)   BINARY.
                05  R02-PREFKBNLST  PIC X(6)   OCCURS  3 TIMES.
