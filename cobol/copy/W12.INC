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
            02  W12.
              03  W12-YUKOSTYMD.
                04  W12-VALUE   PIC X(9).
              03  W12-YUKOEDYMD.
                04  W12-VALUE   PIC X(9).
              03  W12-BYOMEIHENKBN-COMBO.
                04  W12-BYOMEIHENKBN       PIC X(20).
                04  W12-BYOMEIHENKBN-COUNT PIC S9(9)   BINARY.
                04  W12-BYOMEIHENKBNLST    PIC X(20)   OCCURS  2 TIMES.
              03  W12-BYOMEIHENKBN1-COMBO.
                04  W12-BYOMEIHENKBN1      PIC X(22).
                04  W12-BYOMEIHENKBN1-COUNT
                                           PIC S9(9)   BINARY.
                04  W12-BYOMEIHENKBN1LST   PIC X(22)   OCCURS  2 TIMES.
              03  W12-TENKIHENKBN-COMBO.
                04  W12-TENKIHENKBN        PIC X(20).
                04  W12-TENKIHENKBN-COUNT  PIC S9(9)   BINARY.
                04  W12-TENKIHENKBNLST     PIC X(20)   OCCURS  2 TIMES.
              03  W12-KKHRECEKBN-COMBO.
                04  W12-KKHRECEKBN         PIC X(20).
                04  W12-KKHRECEKBN-COUNT   PIC S9(9)   BINARY.
                04  W12-KKHRECEKBNLST      PIC X(20)   OCCURS  3 TIMES.
              03  W12-SYARECEKBN-COMBO.
                04  W12-SYARECEKBN         PIC X(20).
                04  W12-SYARECEKBN-COUNT   PIC S9(9)   BINARY.
                04  W12-SYARECEKBNLST      PIC X(20)   OCCURS  3 TIMES.
              03  W12-RECEDENOUT.
                04  W12-VALUE   PIC X(30).
              03  W12-KKHOCRKBN-COMBO.
                04  W12-KKHOCRKBN       PIC X(20).
                04  W12-KKHOCRKBN-COUNT PIC S9(9)   BINARY.
                04  W12-KKHOCRKBNLST    PIC X(20)   OCCURS  2 TIMES.
              03  W12-PREFPRGID.
                04  W12-VALUE   PIC X(15).
              03 W12-PREFPRGID1-STATE
                                PIC S9(9)   BINARY.
              03  W12-PREFPRGID1.
                04  W12-VALUE   PIC X(15).
              03  W12-SYAPRTNM.
                04  W12-VALUE   PIC X(16).
              03  W12-KKHPRTNM.
                04  W12-VALUE   PIC X(16).
              03  W12-RENNUMHENKBN-COMBO.
                04  W12-RENNUMHENKBN       PIC X(22).
                04  W12-RENNUMHENKBN-COUNT PIC S9(9)   BINARY.
                04  W12-RENNUMHENKBNLST    PIC X(22)   OCCURS  3 TIMES.
              03  W12-NEXTPRTKBN-COMBO.
                04  W12-NEXTPRTKBN         PIC X(22).
                04  W12-NEXTPRTKBN-COUNT   PIC S9(9)   BINARY.
                04  W12-NEXTPRTKBNLST      PIC X(22)   OCCURS  2 TIMES.
              03  W12-KKHPRTKBN-COMBO.
                04  W12-KKHPRTKBN       PIC X(20).
                04  W12-KKHPRTKBN-COUNT PIC S9(9)   BINARY.
                04  W12-KKHPRTKBNLST    PIC X(20)   OCCURS  2 TIMES.
