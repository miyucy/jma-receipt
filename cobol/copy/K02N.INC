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
        02  K02N.
      ****  02  K02N-FIXED2.
              03  K02N-PTNUM.
                04  K02N-VALUE  PIC X(20).
              03  K02N-KANANAME.
                04  K02N-VALUE  PIC X(50).
              03  K02N-NAME.
                04  K02N-VALUE  PIC X(50).
              03  K02N-SEX.
                04  K02N-VALUE  PIC X(2).
              03  K02N-HKNCOMBICOMB.
                04  K02N-HKNCOMBI.
                  05  K02N-VALUE  PIC X(50).
                04  K02N-HKNCOMBI-COUNT  PIC S9(9)   BINARY.
                04  K02N-HKNCOMBI-ITEM   PIC X(50)   OCCURS  15 TIMES.
              03  K02N-RATE.
                04  K02N-VALUE  PIC X(6).
              03  K02N-BIRTHDAY.
                04  K02N-VALUE  PIC X(9).
              03  K02N-NENREI.
                04  K02N-VALUE  PIC X(6).
              03  K02N-SRYYMD.
                04  K02N-VALUE  PIC X(14).
              03  K02N-SRYKBN    OCCURS   24.
                04  K02N-VALUE   PIC X(2).
              03  K02N-INPUTCD   OCCURS   24.
                04  K02N-VALUE   PIC X(22).
              03  K02N-MEISYO    OCCURS   24.
                04  K02N-VALUE   PIC X(62).
              03  K02N-SURYO-G   OCCURS   24.
                04  K02N-SURYO-STYLE   PIC X(20).
                04  K02N-SURYO   PIC X(60).
              03  K02N-DOSELNUM.
                04  K02N-VALUE  PIC X(3).
              03  K02N-NYUINKA.
                04  K02N-VALUE  PIC X(10).
              03  K02N-NYUINKIKAN.
                04  K02N-VALUE  PIC X(20).
              03  K02N-TEISEI.
                04  K02N-TEISEI-VALUE  PIC X.
                04  K02N-TEISEI-LABEL  PIC X(10).
              03  K02N-SRYKACOMB.
                04  K02N-SRYKA.
                  05  K02N-VALUE  PIC X(16).
                04  K02N-SRYKA-COUNT  PIC S9(9)   BINARY.
                04  K02N-SRYKA-ITEM   PIC X(16)   OCCURS  40 TIMES.
              03  K02N-TABOOCOB.
                04  K02N-TABOO.
                  05  K02N-VALUE  PIC X(62).
                04  K02N-TABOO-COUNT  PIC S9(9)   BINARY.
                04  K02N-TABOO-ITEM   PIC X(62)   OCCURS  23 TIMES.
              03  K02N-SCROLLEDWINDOW1.
                04  K02N-RRKLIST.
                  05  K02N-COUNT  PIC S9(9)   BINARY.
                  05  K02N-ITEM       OCCURS  150 TIMES.
                    06  K02N-NO      PIC X(3).
                    06  K02N-RRKYMD  PIC X(13).
                    06  K02N-RRKSRYKA  PIC X(2).
                    06  K02N-RRKHKNCOMBI  PIC X(04).
                  05  K02N-SELECT PIC X       OCCURS  150 TIMES.
              03  K02N-CONTKBN.
                04  K02N-CONTKBN-STYLE  PIC X(20).
                04  K02N-CONTKBN-VALUE  PIC X(6).
              03  K02N-SYORIMEI.
                04  K02N-SYORIMEI-STYLE  PIC X(20).
                04  K02N-SYORIMEI-VALUE  PIC X(12).
              03  K02N-MODE.
                04  K02N-VALUE  PIC X(10).
              03  K02N-JIKANKBNCOMB.
                04  K02N-JIKANKBN.
                  05  K02N-VALUE  PIC X(22).
                04  K02N-JIKANKBN-COUNT  PIC S9(9)   BINARY.
                04  K02N-JIKANKBN-ITEM   PIC X(22)   OCCURS  5 TIMES.
