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
            02  W07.
                03  W07-FIXED1.
                    04  W07-YUKOSTYMD           PIC X(9).
                    04  W07-YUKOEDYMD           PIC X(9).
                    04  W07-B03.
                      05  W07-B03-STATE         PIC S9(9)   BINARY.
                    04  W07-NOTEBOOK1.
                      05  W07-PAGENO            PIC S9(9)   BINARY.
                      05  W07-TAG1.
                        06  W07-DATA-TBL        OCCURS  5.
                          07  W07-DATA-COMBO.
                            08  W07-DATA.   
                              09  W07-VALUE     PIC X(12).
                            08  W07-COUNT       PIC S9(9)   BINARY.
                            08  W07-DATALST     PIC X(12)   OCCURS  2.
                      05  W07-TAGNAME1.
                        06  W07-TG1-STATE       PIC S9(9)   BINARY.
                      05  W07-TAG2.
                        06  W07-KIKAN           PIC S9(2).
                  05  W07-GAIKANRIKBNCOMB.
                    06  W07-GAIKANRIKBN.
                      07  W07-VALUE   PIC X(22).
                    06  W07-GAIKANRIKBN-COUNT   PIC S9(9)   BINARY.
                    06  W07-GAIKANRIKBN-ITEM    PIC X(22)   OCCURS  3.
                      05  W07-TAGNAME2.
                        06  W07-TG2-STATE       PIC S9(9)   BINARY.
