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
        02  K06.
      ***  02  K06-FIXED5.
              03  K06-PTNUM.
                04  K06-VALUE   PIC X(20).
              03  K06-SRYYM.
                04  K06-VALUE   PIC X(7).
              03  K06-KANANAME.
                04  K06-VALUE   PIC X(30).
              03  K06-MEISYO.
                04  K06-VALUE   PIC X(70).
              03  K06-SEX.
                04  K06-VALUE   PIC X(2).
              03  K06-DAY-G     OCCURS  31.
                04  K06-DAY.
                  05  K06-VALUE   PIC S9(2).
              03  K06-SRYCD.
                04  K06-VALUE   PIC X(9).
              03  K06-NYUGAIKBN.
                04  K06-VALUE   PIC S9(1).
              03  K06-FSANTEIYMD.
                04  K06-VALUE   PIC X(10).
              03  K06-NAME.
                04  K06-VALUE   PIC X(30).
              03  K06-BIRTHDAY.
                04  K06-VALUE   PIC X(9).
              03  K06-SELNUM.
                04  K06-VALUE   PIC S9(3).
              03  K06-MSANTEID.
                04  K06-VALUE   PIC S9(2).
              03  K06-MSANTEICNT.
                04  K06-VALUE   PIC S9(3).
              03  K06-NENREI.
                04  K06-VALUE   PIC X(6).
              03  K06-SRYKA.
                04  K06-VALUE   PIC S9(2).
              03  K06-SCROLLEDWINDOW1.
                04  K06-SANTEILST.
                  05  K06-COUNT   PIC S9(9)   BINARY.
                  05  K06-ITEM        OCCURS  100 TIMES.
                    06  K06-TRENNUM     PIC X(4).
                    06  K06-TSRYCD      PIC X(09).
                    06  K06-TNYUGAIKBN  PIC X(2).
                    06  K06-TSRYKA      PIC X(10).
                    06  K06-THKNCOMBI   PIC X(20).
                    06  K06-TMEISYO     PIC X(60).
                    06  K06-TFSANTEIYMD PIC X(10).
                    06  K06-TMSANTEID   PIC X(2).
                    06  K06-TMSANTEICNT PIC X(4).
                  05  K06-SELECT  PIC X       OCCURS  100 TIMES.
              03  K06-HKNCOMBI.
                04  K06-VALUE   PIC S9(4).
              03  K06-SRYKAMEI.
                04  K06-VALUE   PIC X(10).
              03  K06-HKNCOMBIMEI.
                04  K06-VALUE   PIC X(20).
