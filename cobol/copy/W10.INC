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
          02  W10.
              03  W10-B03.
                04  W10-B03-STATE       PIC S9(9)   BINARY.
              03  W10-STYUKYMD.
                04  W10-VALUE           PIC X(9).
              03  W10-EDYUKYMD.
                04  W10-VALUE           PIC X(9).
              03  W10-NOTEBOOK.
                04  W10-PAGENO          PIC S9(9)   BINARY.
                04  W10-FIXED.
                  05  W10-PROGNAME.
                    06  W10-VALUE       PIC X(24).
                  05  W10-HCNAME.
                    06  W10-VALUE       PIC X(80).
                  05  W10-HCNUM.
                    06  W10-VALUE       PIC S9(3).
                  05  W10-PARA-G        OCCURS  8.
                      06  W10-PARAHYOJI PIC X(20).
                      06  W10-PARA      PIC X(10).
                  05  W10-OPTHISSU-KBN-G        OCCURS  8.
                      06  W10-OPTHISSU  PIC X.
                      06  W10-OPTNINI   PIC X.
                04  W10-N01.
                  05  W10-N01-STATE     PIC S9(9)   BINARY.
                04  W10-FIXED1.
                  05  W10-PROGNAME1.
                    06  W10-VALUE       PIC X(24).
                  05  W10-HCNAME1.
                    06  W10-VALUE       PIC X(80).
                  05  W10-HCNUM1.
                    06  W10-VALUE       PIC S9(3).
                  05  W10-PARA1-G        OCCURS  8.
                      06  W10-PARAHYOJI1 PIC X(20).
                      06  W10-PARA1      PIC X(10).
                  05  W10-OPTHISSU-KBN1-G        OCCURS  8.
                      06  W10-OPTHISSU1 PIC X.
                      06  W10-OPTNINI1  PIC X.
                04  W10-N02.
                  05  W10-N02-STATE     PIC S9(9)   BINARY.
