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
        02  W24.
            03  W24-FIXED6.
              04  W24-STYUKYMD                 PIC X(10).
              04  W24-EDYUKYMD                 PIC X(10).
              04  W24-FRAME1.
                05  W24-FIXED7.
                  06  W24-CMB-SK-NYUSYOKU.
                    07  W24-SK-NYUSYOKU        PIC X(28).
                    07  W24-SK-NYUSYOKU-CNT    PIC S9(9)
                                               BINARY.
                    07  W24-SK-NYUSYOKU-ITM    PIC X(28)
                                               OCCURS  5.
                  06  W24-CMB-SK-TOKKSN.
                    07  W24-SK-TOKKSN          PIC X(28).
                    07  W24-SK-TOKKSN-CNT      PIC S9(9)
                                               BINARY.
                    07  W24-SK-TOKKSN-ITM      PIC X(28)
                                               OCCURS  5.
                  06  W24-CMB-SK-SYOKUDO.
                    07  W24-SK-SYOKUDO         PIC X(28).
                    07  W24-SK-SYOKUDO-CNT     PIC S9(9)
                                               BINARY.
                    07  W24-SK-SYOKUDO-ITM     PIC X(28)
                                               OCCURS  5.
              04  W24-FRAME2.
                05  W24-FIXED8.
                  06  W24-CMB-GN-NYUSRY.
                    07  W24-GN-NYUSRY          PIC X(28).
                    07  W24-GN-NYUSRY-CNT      PIC S9(9)
                                               BINARY.
                    07  W24-GN-NYUSRY-ITM      PIC X(28)
                                               OCCURS  5.
                  06  W24-CMB-GN-INKANSEN.
                    07  W24-GN-INKANSEN        PIC X(28).
                    07  W24-GN-INKANSEN-CNT    PIC S9(9)
                                               BINARY.
                    07  W24-GN-INKANSEN-ITM    PIC X(28)
                                               OCCURS  5.
                  06  W24-CMB-GN-ANZEN.
                    07  W24-GN-ANZEN           PIC X(28).
                    07  W24-GN-ANZEN-CNT       PIC S9(9)
                                               BINARY.
                    07  W24-GN-ANZEN-ITM       PIC X(28)
                                               OCCURS  5.
                  06  W24-CMB-GN-JOKUSO.
                    07  W24-GN-JOKUSO          PIC X(28).
                    07  W24-GN-JOKUSO-CNT      PIC S9(9)
                                               BINARY.
                    07  W24-GN-JOKUSO-ITM      PIC X(28)
                                               OCCURS  5.
              04  W24-FRAME3.
                05  W24-FIXED9.
                  06  W24-CHK-NYUKSN.
                    07 W24-CHK-NYUKSN-OCC      OCCURS 20.
                      08 W24-CHK-NYUKSNFLG     PIC X(01).
                      08 W24-CHK-NYUKSNNM      PIC X(01).
                  06  W24-NYUKSNNM             PIC X(32)
                                               OCCURS 20.
                  06  W24-CMB-CHIIKIKSN.
                    07  W24-CHIIKIKSN          PIC X(28).
                    07  W24-CHIIKIKSN-CNT      PIC S9(9)
                                               BINARY.
                    07  W24-CHIIKIKSN-ITM      PIC X(28)
                                               OCCURS  5.
              04  W24-FRAME4.
                05  W24-FIXED10.
                  06  W24-SRYCD                PIC X(09)
                                               OCCURS 10.
                  06  W24-SRYACT               PIC X(30)
                                               OCCURS 10.
