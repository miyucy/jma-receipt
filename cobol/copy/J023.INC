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
        02  J023.
      ***   02  J023-FIXED1.
              03  J023-COMMENT.
                04  J023-VALUE  PIC X(400).
              03  J023-SELNUM.
                04  J023-VALUE  PIC S9(3).
              03  J023-BUNNUM.
                04  J023-VALUE  PIC S9(3).
              03  J023-SRYYM.
                04  J023-VALUE  PIC X(7).
              03  J023-SRYKACOMB.
                04  J023-SRYKA.
                  05  J023-VALUE  PIC X(21).
                04  J023-SRYKA-COUNT  PIC S9(9)   BINARY.
                04  J023-SRYKA-ITEM   PIC X(20)   OCCURS  10 TIMES.
              03  J023-MIDASI-G.
                04  J023-MIDASI-STYLE  PIC X(20).
                04  J023-MIDASI       PIC X(20).
              03  J023-HKNCOMBICOMB.
                04  J023-HKNCOMBI.
                  05  J023-VALUE  PIC X(41).
                04  J023-HKNCOMBI-COUNT  PIC S9(9)   BINARY.
                04  J023-HKNCOMBI-ITEM   PIC X(40)   OCCURS  10 TIMES.
              03  J023-SCROLLEDWINDOW1.
                04  J023-RECELIST.
                  05  J023-RECE-COUNT  PIC S9(9)   BINARY.
                  05  J023-ITEM       OCCURS  100 TIMES.
                    06  J023-TRENNUM   PIC X(3).
                    06  J023-TSRYYM    PIC X(6).
                    06  J023-TSRYKA    PIC X(10).
                    06  J023-THKNCOMBI PIC X(20).
                    06  J023-TSRYDD    PIC X(3).
                    06  J023-TCOMMENT  PIC X(50).
                  05  J023-RECE-SELECT PIC X       OCCURS  100 TIMES.
              03  J023-PANDACLIST1.
                04  J023-JYURRK-COUNT  PIC S9(9)   BINARY.
                04  J023-ITEM       OCCURS  5 TIMES.
                  05  J023-TJYURRKNUM     PIC X(2).
                  05  J023-TJYURRKYMD     PIC X(10).
                04  J023-JYURRK-SELECT PIC X       OCCURS  5 TIMES.
              03  J023-JYURRKNUM.
                04  J023-VALUE  PIC S9(2).
