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
        02  C07.
              03  C07-COMMENT.
                04  C07-VALUE   PIC X(400).
              03  C07-SELNUM.
                04  C07-VALUE   PIC S9(3).
              03  C07-BUNNUM.
                04  C07-VALUE   PIC S9(3).
              03  C07-SRYYM.
                04  C07-VALUE   PIC X(7).
              03  C07-SRYKACOMB.
                04  C07-SRYKA.
                  05  C07-VALUE  PIC X(21).
                04  C07-SRYKA-COUNT  PIC S9(9)   BINARY.
                04  C07-SRYKA-ITEM   PIC X(20)   OCCURS  41 TIMES.
              03  C07-NYUGAIKBNCOMB.
                04  C07-NYUGAIKBN.
                  05  C07-VALUE  PIC X(9).
                04  C07-NYUGAIKBN-COUNT  PIC S9(9)   BINARY.
                04  C07-NYUGAIKBN-ITEM   PIC X(8)    OCCURS  2 TIMES.
              03  C07-MIDASI-G.
                04  C07-MIDASI-STYLE  PIC X(20).
                04  C07-MIDASI       PIC X(20).
              03  C07-HKNCOMBICOMB.
                04  C07-HKNCOMBI.
                  05  C07-VALUE  PIC X(41).
                04  C07-HKNCOMBI-COUNT  PIC S9(9)   BINARY.
                04  C07-HKNCOMBI-ITEM   PIC X(40)   OCCURS  10 TIMES.
              03  C07-SCROLLEDWINDOW1.
                04  C07-RECELIST.
                  05  C07-RECE-COUNT    PIC S9(9)   BINARY.
                  05  C07-RECE-ROW      PIC S9(9)   BINARY.
                  05  C07-RECE-ROWATTR  PIC S9(9)   BINARY.
                  05  C07-ITEM       OCCURS  100 TIMES.
                    06  C07-TRENNUM     PIC X(3).
                    06  C07-TSRYYM      PIC X(6).
                    06  C07-TSRYKA      PIC X(10).
                    06  C07-THKNCOMBI   PIC X(20).
                    06  C07-TSRYDD      PIC X(3).
                    06  C07-TCOMMENT    PIC X(50).
                  05  C07-RECE-SELECT   PIC X       OCCURS  100 TIMES.
              03  C07-JYURRKLIST.
                04  C07-JYURRK-COUNT    PIC S9(9)   BINARY.
                04  C07-JYURRK-ROW      PIC S9(9)   BINARY.
                04  C07-JYURRK-ROWATTR
                                        PIC S9(9)   BINARY.
                04  C07-ITEM       OCCURS  5 TIMES.
                  05  C07-TJYURRKNUM     PIC X(2).
                  05  C07-TJYURRKYMD     PIC X(10).
                04  C07-JYURRK-SELECT PIC X       OCCURS  5 TIMES.
              03  C07-JYURRKNUM.
                04  C07-VALUE   PIC S9(2).
