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
        02  S05.
              03  S05-B06.
                04  S05-B06-STATE       PIC S9(9)   BINARY.
              03  S05-B07.
                04  S05-B07-STATE       PIC S9(9)   BINARY.
              03  S05-PTNUM             PIC X(20).
              03  S05-NAME.
                04  S05-VALUE           PIC X(50).
              03  S05-LBLMSG-G.
                04  S05-LBLMSG-STYLE
                                        PIC X(20).
                04  S05-LBLMSG          PIC X(50).
              03  S05-SELNUM            PIC S9(4).
              03  S05-GAI-MISYU         PIC S9(9).
              03  S05-NYU-MISYU         PIC S9(9).
              03  S05-SCROLLEDWINDOW1.
                04  S05-SYULIST.
                  05  S05-SYULIST-COUNT PIC S9(9)   BINARY.
                  05  S05-SYULIST-ITEM  OCCURS  200 TIMES.
                    06  S05-TNUM        PIC X(5).
                    06  S05-TDENPNUM    PIC X(9).
                    06  S05-TSRYKA      PIC X(6).
                    06  S05-TNYUGAI     PIC X(4).
                    06  S05-THKN        PIC X(50).
                    06  S05-TFTNRATE    PIC X(5).
                    06  S05-TSKYSTYMD   PIC X(11).
                    06  S05-TSRYYMD     PIC X(15).
                    06  S05-TSKYMONEY   PIC X(11).
                    06  S05-TMISYUMONEY PIC X(11).
                    06  S05-TDENPJTI    PIC X(16).
                  05  S05-SYULIST-SELECT   PIC X
                                           OCCURS  200 TIMES.
