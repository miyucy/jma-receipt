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
        02  D01.
          03  D01-SRYYM.
            04  D01-VALUE   PIC X(6).
          03  D01-CHKMSG1.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG2.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG3.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG4.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG5.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG6.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG7.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG8.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG9.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG10.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG11.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG12.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG13.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG14.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG15.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG16.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG17.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG18.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG19.
            04  D01-VALUE   PIC X(40).
          03  D01-CHKMSG20.
            04  D01-VALUE   PIC X(40).
          03  D01-NYUGAIKBNCOMB.
            04  D01-NYUGAIKBN.
              05  D01-VALUE            PIC X(20).
            04  D01-NYUGAIKBN-COUNT    PIC S9(9)   BINARY.
            04  D01-NYUGAIKBN-ITEM     PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB01.
            04  D01-CHKKBN01.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN01-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN01-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB02.
            04  D01-CHKKBN02.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN02-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN02-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB03.
            04  D01-CHKKBN03.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN03-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN03-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB04.
            04  D01-CHKKBN04.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN04-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN04-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB05.
            04  D01-CHKKBN05.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN05-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN05-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB06.
            04  D01-CHKKBN06.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN06-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN06-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB07.
            04  D01-CHKKBN07.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN07-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN07-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB08.
            04  D01-CHKKBN08.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN08-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN08-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB09.
            04  D01-CHKKBN09.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN09-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN09-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB10.
            04  D01-CHKKBN10.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN10-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN10-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB11.
            04  D01-CHKKBN11.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN11-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN11-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB12.
            04  D01-CHKKBN12.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN12-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN12-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB13.
            04  D01-CHKKBN13.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN13-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN13-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB14.
            04  D01-CHKKBN14.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN14-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN14-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB15.
            04  D01-CHKKBN15.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN15-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN15-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB16.
            04  D01-CHKKBN16.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN16-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN16-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB17.
            04  D01-CHKKBN17.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN17-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN17-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB18.
            04  D01-CHKKBN18.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN18-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN18-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB19.
            04  D01-CHKKBN19.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN19-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN19-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKKBNCOMB20.
            04  D01-CHKKBN20.
              05  D01-VALUE            PIC X(20).
            04  D01-CHKKBN20-COUNT     PIC S9(9)   BINARY.
            04  D01-CHKKBN20-ITEM      PIC X(20)   OCCURS  5 TIMES.
