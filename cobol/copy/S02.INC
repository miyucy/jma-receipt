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
        02  S02.
              03  S02-B04.
                04  S02-B04-STATE    PIC S9(9)   BINARY.
              03  S02-B03S.
                04  S02-B03S-STATE   PIC S9(9)   BINARY.
              03  S02-PTNUM-STATE
                                PIC S9(9)   BINARY.
              03  S02-PTNUM     PIC X(20).
              03  S02-KANANAME.
                04  S02-VALUE   PIC X(50).
              03  S02-NAME.
                04  S02-VALUE   PIC X(50).
              03  S02-BIRTHDAY.
                04  S02-VALUE   PIC X(9).
              03  S02-SEX.
                04  S02-VALUE   PIC X(2).
              03  S02-SELNUM    PIC S9(4).
              03  S02-GAI-MISYU PIC S9(9).
              03  S02-NYU-MISYU PIC S9(9).
              03  S02-SRYYM.
                04  S02-VALUE   PIC X(7).
              03  S02-SCROLLEDWINDOW1.
                04  S02-SYULIST.
                  05  S02-SYULIST-COUNT    PIC S9(9)   BINARY.
                  05  S02-SYULIST-ITEM     OCCURS  200 TIMES.
                    06  S02-TNUM        PIC X(5).
                    06  S02-TDENPNUM    PIC X(9).
                    06  S02-TSRYKA      PIC X(6).
                    06  S02-TNYUGAI     PIC X(4).
                    06  S02-THKN        PIC X(30).
                    06  S02-TFTNRATE    PIC X(5).
                    06  S02-TSKYSTYMD   PIC X(11).
                    06  S02-TSRYYMD     PIC X(15).
                    06  S02-TSKYMONEY   PIC X(11).
                    06  S02-TMISYUMONEY PIC X(11).
                    06  S02-TDENPJTI    PIC X(16).
                  05  S02-SYULIST-SELECT   PIC X
                                           OCCURS  200 TIMES.
              03  S02-SRYKACOMBO.
                04  S02-SRYKA         PIC X(21).
                04  S02-SRYKA-COUNT   PIC S9(9)   BINARY.
                04  S02-SRYKALST      PIC X(21)   OCCURS  99 TIMES.
              03  S02-NYUGAIKBNCOMBO.
                04  S02-NYUGAIKBN.
                  05  S02-VALUE   PIC X(8).
                04  S02-NYUGAIKBN-COUNT   PIC S9(9)   BINARY.
                04  S02-NYUGAIKBN-ITEM    PIC X(8)    OCCURS  3 TIMES.
