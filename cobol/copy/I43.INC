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
        02  I43.
              03  I43-COMMENT.
                04  I43-VALUE  PIC X(400).
              03  I43-SELNUM.
                04  I43-VALUE  PIC S9(3).
              03  I43-BUNNUM.
                04  I43-VALUE  PIC S9(3).
              03  I43-SRYYM.
                04  I43-VALUE  PIC X(6).
              03  I43-SRYKACOMB.
                04  I43-SRYKA.
                  05  I43-VALUE  PIC X(20).
                04  I43-SRYKA-COUNT  PIC S9(9)   BINARY.
                04  I43-SRYKA-ITEM   PIC X(20)   OCCURS  100 TIMES.
              03  I43-MIDASI-G.
                04  I43-MIDASI-STYLE PIC X(20).
                04  I43-MIDASI       PIC X(20).
              03  I43-HKNCOMBICOMB.
                04  I43-HKNCOMBI.
                  05  I43-VALUE  PIC X(40).
                04  I43-HKNCOMBI-COUNT  PIC S9(9)   BINARY.
                04  I43-HKNCOMBI-ITEM   PIC X(40)   OCCURS  10 TIMES.
              03  I43-SCROLLEDWINDOW1.
                04  I43-RECELIST.
                  05  I43-RECE-COUNT  PIC S9(9)   BINARY.
                  05  I43-ITEM       OCCURS  100 TIMES.
                    06  I43-TRENNUM   PIC X(3).
                    06  I43-TSRYYM    PIC X(6).
                    06  I43-TSRYKA    PIC X(10).
                    06  I43-THKNCOMBI PIC X(20).
                    06  I43-TSRYDD    PIC X(3).
                    06  I43-TCOMMENT  PIC X(50).
                  05  I43-RECE-SELECT PIC X       OCCURS  100 TIMES.
