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
        02  W13.
              03  W13-YUKOSTYMD.
                04  W13-VALUE   PIC X(9).
              03  W13-YUKOEDYMD.
                04  W13-VALUE   PIC X(9).
              03  W13-RSIIRYOCDN.
                04  W13-VALUE   PIC X(40).
              03  W13-SONSHOUKBN1.
                04  W13-VALUE   PIC X(2).
              03  W13-SONSHOUKBN2.
                04  W13-VALUE   PIC X(1).
              03  W13-SONSHOUNAME.
                04  W13-VALUE   PIC X(60).
              03  W13-SCROLLEDWINDOW6.
                04  W13-SONSHOUKBNLST.
                  05  W13-SONSHOUKBN-COUNT   PIC S9(9)   BINARY.
                  05  W13-SONSHOUKBN-ROW     PIC S9(9)   BINARY.
                  05  W13-SONSHOUKBN-ROWATTR  PIC S9(9)   BINARY.
                  05  W13-SONSHOUKBN-ITEM    OCCURS  40 TIMES.
                    06  W13-TSONSHOUKBN      PIC X(4).
                    06  W13-TSONSHOUNAME     PIC X(60).
                  05  W13-SONSHOUKBN-SELECT  PIC X   OCCURS  40 TIMES.
              03  W13-TENKBN-COMBO.
                04  W13-TENKBN         PIC X(20).
                04  W13-TENKBN-COUNT   PIC S9(9)   BINARY.
                04  W13-TENKBNLST      PIC X(20)   OCCURS  2 TIMES.
              03  W13-KSNRATE.
                04  W13-VALUE   PIC S9(2).
              03  W13-RSIIRYOKBN-COMBO.
                04  W13-RSIIRYOKBN       PIC X(20).
                04  W13-RSIIRYOKBN-COUNT PIC S9(9)   BINARY.
                04  W13-RSIIRYOKBNLST    PIC X(20)   OCCURS  2 TIMES.
              03  W13-TAXKBN-COMBO.
                04  W13-TAXKBN           PIC X(10).
                04  W13-TAXKBN-COUNT     PIC S9(9)   BINARY.
                04  W13-TAXKBNLST        PIC X(10)   OCCURS  2 TIMES.
              03  W13-SKJKBN-COMBO.
                04  W13-SKJKBN           PIC X(20).
                04  W13-SKJKBN-COUNT     PIC S9(9)   BINARY.
                04  W13-SKJKBNLST        PIC X(20)   OCCURS  2 TIMES.
