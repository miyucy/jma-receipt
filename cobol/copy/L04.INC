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
      *
        02  L04.
      *     02  L04-FIXED.
              03  L04-B12-G.
                  05  L04-B04-LABEL    PIC X(10).
                  05  L04-B12-LABEL    PIC X(10).
              03  L04-MESPROC          PIC X(10).
              03  L04-MESSTSRYYMD      PIC X(10).
              03  L04-MESSTTIME        PIC X(10).
              03  L04-CHK-MESSTSRYYMD  PIC X.
              03  L04-CHK-MESSTTIME    PIC X.
              03  L04-MESEDSRYYMD      PIC X(10).
              03  L04-MESEDTIME        PIC X(10).
              03  L04-CHK-MESEDSRYYMD  PIC X.
              03  L04-CHK-MESEDTIME    PIC X.
              03  L04-CMB-PROCKBN.
                04  L04-PROCKBN.
                  05  L04-VALUE        PIC X(50).
                04  L04-PROCKBN-COUNT  PIC S9(9)   BINARY.
                04  L04-PROCKBN-ITEM   PIC X(50)
                                       OCCURS  10 TIMES.
              03  L04-TERM-G.
                04  L04-TERM-OCC       OCCURS  10  TIMES.
                  05  L04-NO           PIC S9(02).
                  05  L04-HOURS-OCC    OCCURS  2   TIMES.
                    06  L04-SRYYMD-G.
                      07  L04-SRYYMD-STYLE
                                       PIC X(20).
                      07  L04-SRYYMD   PIC X(10).
                    06  L04-TIME-G.
                      07  L04-TIME-STYLE
                                       PIC X(20).
                      07  L04-TIME     PIC X(10).
                    06    L04-CHK-SRYYMD   PIC X.
                    06    L04-CHK-TIME     PIC X.
                  05  L04-MARK-G.
                      06  L04-MARK-STYLE
                                       PIC X(20).
                      06  L04-MARK     PIC X(02).
              03  L04-STSRYYMD         PIC X(10).
              03  L04-STNO             PIC S9(02).
              03  L04-STHR             PIC X(02).
              03  L04-STMIN            PIC X(02).
              03  L04-EDSRYYMD         PIC X(10).
              03  L04-EDNO             PIC S9(02).
              03  L04-EDHR             PIC S9(02).
              03  L04-EDMIN            PIC S9(02).
              03  L04-LBL-KIKAN1       PIC X(08).
              03  L04-LBL-KIKAN2       PIC X(02).
              03  L04-CMB-HOURSKBN.
                04  L04-HOURSKBN.
                  05  L04-VALUE        PIC X(10).
                04  L04-HOURSKBN-COUNT PIC S9(9)   BINARY.
                04  L04-HOURSKBN-ITEM  PIC X(10)
                                       OCCURS  5 TIMES.
