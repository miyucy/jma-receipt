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
          03  D01-SRYYM                PIC X(07).
          03  D01-CMB-NYUGAIKBN.
            04  D01-NYUGAIKBN          PIC X(20).
            04  D01-NYUGAIKBN-COUNT    PIC S9(9)   BINARY.
            04  D01-NYUGAIKBN-ITEM     PIC X(20)   OCCURS  5 TIMES.
          03  D01-CHKMSG-G.
            04  D01-CHKMSG             PIC X(40)   OCCURS 18 TIMES.
          03  D01-JIHIPROCMSG          PIC X(40).
          03  D01-INGAIPROCMSG         PIC X(40).
          03  D01-CMB-CHKKBN-G.
            04  D01-CMB-CHKKBN-OCC                 OCCURS 18 TIMES.
              05  D01-CHKKBN           PIC X(20).
              05  D01-CHKKBN-COUNT     PIC S9(9)   BINARY.
              05  D01-CHKKBN-ITEM      PIC X(20)   OCCURS  5 TIMES.
          03  D01-CMB-JIHIPROCKBN.
            04  D01-JIHIPROCKBN        PIC X(20).
            04  D01-JIHIPROCKBN-COUNT  PIC S9(9)   BINARY.
            04  D01-JIHIPROCKBN-ITEM   PIC X(20)   OCCURS  5 TIMES.
          03  D01-CMB-INGAIPROCKBN.
            04  D01-INGAIPROCKBN       PIC X(20).
            04  D01-INGAIPROCKBN-COUNT PIC S9(9)   BINARY.
            04  D01-INGAIPROCKBN-ITEM  PIC X(20)   OCCURS  5 TIMES.
