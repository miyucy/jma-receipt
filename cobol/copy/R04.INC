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
        02  R04.
              03  R04-B09.
                04  R04-B09-STATE   PIC S9(9)   BINARY.
              03  R04-B10.
                04  R04-B10-STATE   PIC S9(9)   BINARY.
              04  R04-SYOKBN.
                05  R04-SYOKBN-VALUE   PIC X.
                05  R04-SYOKBN-LABEL   PIC X(9).
              04  R04-TSTDATA-G    OCCURS  25.
                05  R04-TSTDATA-STATE   PIC S9(09) BINARY.
                05  R04-TSTDATA.
                  06  R04-VALUE   PIC X(101).
              04  R04-TEDDATA-G    OCCURS  25.
                05  R04-TEDDATA-STATE   PIC S9(09) BINARY.
                05  R04-TEDDATA.
                  06  R04-VALUE   PIC X(101).
              04  R04-TPAGE-G      OCCURS  25.
                05  R04-TPAGE.
                  06  R04-VALUE   PIC 9(4).
              04  R04-TKENSU-G      OCCURS  25.
                05  R04-TKENSU.
                  06  R04-VALUE   PIC 9(4).
              04  R04-TCHK-G       OCCURS  25.
                05  R04-TCHK.
                  06  R04-TCHK-STATE   PIC S9(09) BINARY.
                  06  R04-TCHK-VALUE   PIC X.
                  06  R04-TCHK-LABEL   PIC X(41).
              04  R04-FILEKBN.
                05  R04-VALUE     PIC X(35).
              04  R04-CREYMD.
                05  R04-VALUE     PIC X(23).
              04  R04-KENSU.
                05  R04-VALUE   PIC 9(4).
              04  R04-PAGE.
                05  R04-VALUE   PIC 9(4).
              04  R04-PREFKBN-COMBO.
                05  R04-PREFKBN.
                  06  R04-VALUE   PIC X(7).
                05  R04-PREFKBN-COUNT   PIC S9(9)   BINARY.
                05  R04-PREFKBNLST  PIC X(6)   OCCURS  3 TIMES.
              04  R04-PRTJYUN-COMBO.
                05  R04-PRTJYUN.
                  06  R04-VALUE   PIC X(26).
                05  R04-PRTJYUN-COUNT   PIC S9(9)   BINARY.
                05  R04-PRTJYUNLST  PIC X(26)   OCCURS  5 TIMES.
