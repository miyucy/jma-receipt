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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
        02  K02.
      ****  02  K02-FIXED2.
              03  K02-PTNUM.
                04  K02-VALUE   PIC X(20).
              03  K02-KANANAME.
                04  K02-VALUE   PIC X(50).
              03  K02-NAME.
                04  K02-VALUE   PIC X(50).
              03  K02-BIRTHDAY.
                04  K02-VALUE   PIC X(9).
              03  K02-SEX.
                04  K02-VALUE   PIC X(2).
              03  K02-RATE.
                04  K02-VALUE   PIC X(6).
              03  K02-LASTYMD.
                04  K02-VALUE   PIC X(9).
              03  K02-SYOSINYMD.
                04  K02-VALUE   PIC X(9).
              03  K02-MISYUMONEY.
                04  K02-VALUE   PIC X(15).
              03  K02-SRYYMD.
                04  K02-VALUE   PIC X(14).
              03  K02-GOKEITEN.
                04  K02-VALUE   PIC X(15).
              03  K02-SRYKBN    OCCURS   20.
                04  K02-VALUE   PIC X(2).
              03  K02-INPUTCD   OCCURS 20.
                04  K02-VALUE   PIC X(22).
              03  K02-MEISYO    OCCURS  20.
                04  K02-VALUE   PIC X(62).
              03  K02-SURYO-R     OCCURS  20.
                04  K02-SURYO-STYLE   PIC X(20).
                04  K02-SURYO   PIC X(60).
              03  K02-NENREI.
                04  K02-VALUE   PIC X(6).
              03  K02-ZAITENTOTAL.
                04  K02-VALUE   PIC X(15).
              03  K02-INGAI.
                04  K02-INGAI-VALUE   PIC X.
                04  K02-INGAI-LABEL   PIC X(10).
              03  K02-DOSELNUM.
                04  K02-VALUE   PIC X(3).
              03  K02-TEISEI.
                04  K02-TEISEI-VALUE   PIC X.
                04  K02-TEISEI-LABEL   PIC X(10).
              03  K02-HKNCOMBICOMB.
                04  K02-HKNCOMBI.
                  05  K02-VALUE   PIC X(50).
                04  K02-HKNCOMBI-COUNT   PIC S9(9)   BINARY.
                04  K02-HKNCOMBI-ITEM    PIC X(50)   OCCURS  15 TIMES.
              03  K02-CONTKBN.
                04  K02-CONTKBN-STYLE   PIC X(20).
                04  K02-CONTKBN-VALUE   PIC X(6).
              03  K02-MODE.
                04  K02-VALUE   PIC X(10).
              03  K02-SRYKACOMB.
                04  K02-SRYKA.
                  05  K02-VALUE   PIC X(16).
                04  K02-SRYKA-COUNT   PIC S9(9)   BINARY.
                04  K02-SRYKA-ITEM    PIC X(16)   OCCURS  40 TIMES.
              03  K02-TABOOCOB.
                04  K02-TABOO.
                  05  K02-VALUE   PIC X(62).
                04  K02-TABOO-COUNT   PIC S9(9)   BINARY.
                04  K02-TABOO-ITEM    PIC X(62)   OCCURS  23 TIMES.
              03  K02-SYORIMEI.
                04  K02-SYORIMEI-STYLE   PIC X(20).
                04  K02-SYORIMEI-VALUE   PIC X(12).
              03  K02-SCROLLEDWINDOW1.
                04  K02-RRKLIST.
                  05  K02-COUNT   PIC S9(9)   BINARY.
                  05  K02-ITEM        OCCURS  100 TIMES.
                    06  K02-NO      PIC X(3).
                    06  K02-RRKYMD  PIC X(16).
                  05  K02-SELECT  PIC X       OCCURS  100 TIMES.
