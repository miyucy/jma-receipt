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
        02  W11.
      *     02  W11-FIXED2.
              03  W11-NOTE3.
                04  W11-PAGENO  PIC S9(9)   BINARY.
                04  W11-FI23.
                  05  W11-DSPNAME-G     OCCURS  10.
                    06  W11-DSPNAME     PIC X(30).
                  05  W11-PRTNM-G       OCCURS  10.
                    06  W11-PRTNM       PIC X(16).
                  05  W11-ORCAORGNM-G   OCCURS   4.
                    06  W11-ORCAORGNM   PIC X(20).
                  05  W11-ORCAORGCHK-G  OCCURS   4.
                    06  W11-ORCAORGCHK  PIC X.
                  05  W11-ORCACSTNM-G   OCCURS   4.
                    06  W11-ORCACSTNM   PIC X(20).
                  05  W11-ORCACSTCHK-G  OCCURS   4.
                    06  W11-ORCACSTCHK  PIC X.
                  05  W11-DSPNAME-N-G   OCCURS  10.
                    06  W11-DSPNAME-N   PIC X(30).
                  05  W11-PRTNM-N-G     OCCURS  10.
                    06  W11-PRTNM-N     PIC X(16).
                  05  W11-ORCAORGNM-N-G OCCURS   3.
                    06  W11-ORCAORGNM-N PIC X(20).
                  05  W11-ORCAORGCHK-N-G
                                        OCCURS   3.
                    06  W11-ORCAORGCHK-N 
                                        PIC X.
                  05  W11-ORCACSTNM-N-G OCCURS   3.
                    06  W11-ORCACSTNM-N PIC X(20).
                  05  W11-ORCACSTCHK-N-G
                                        OCCURS   3.
                    06  W11-ORCACSTCHK-N
                                        PIC X.
                04  W11-N01-STATE       PIC S9(9)   BINARY.
                04  W11-FIXED28.
                  05  W11-SYOHODSPNAME.
                    06  W11-VALUE   PIC X(10).
                  05  W11-SYOHOGEPRTFLG-COMBO.
                    06  W11-SYOHOGEPRTFLG
                                        PIC X(12).
                    06  W11-SYOHOGEPRTFLG-COUNT  
                                        PIC S9(9)   BINARY.
                    06  W11-SYOHOGEPRTFLGLST
                                        PIC X(12)   OCCURS  2.
                04  W11-N02-STATE       PIC S9(9)   BINARY.
              03  W11-STYUKYMD          PIC X(9).
              03  W11-EDYUKYMD          PIC X(9).
