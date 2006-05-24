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
          03  N23.
                04  N23-FIXED2.
                    05  N23-JYO                PIC X       OCCURS  2.
                    05  N23-KBN-G                          OCCURS  3.
                        07  N23-KBN            PIC X.
                        07  N23-KBN-STATE      PIC S9(9)   BINARY.
                    05  N23-NAME-G.
                        07  N23-NAME           PIC X(10).
                        07  N23-NAME-STATE     PIC S9(9)   BINARY.
                    05  N23-SRYCD-G.
                        07  N23-SRYCD          PIC X(10).
                        07  N23-SRYCD-STATE    PIC S9(9)   BINARY.
                    05  N23-IYK-G                          OCCURS  2.
                        07  N23-IYK            PIC X.
                        07  N23-IYK-STATE      PIC S9(9)   BINARY.
                    05  N23-SYU                PIC X       OCCURS  2.
