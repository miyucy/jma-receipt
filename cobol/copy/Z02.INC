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
        02  Z02.
      **    02  Z02-FIXED1.
              03  Z02-SRYCDH.
                04  Z02-VALUE   PIC X(10).
              03  Z02-YUKOSTYMDH.
                04  Z02-VALUE   PIC X(10).
              03  Z02-YUKOEDYMDH.
                04  Z02-VALUE   PIC X(10).
              03  Z02-NAMEH.
                04  Z02-VALUE   PIC X(101).
              03  Z02-NAME.
                04  Z02-VALUE   PIC X(101).
              03  Z02-KANANAME.
                04  Z02-VALUE   PIC X(101).
              03  Z02-YUKOSTYMD.
                04  Z02-VALUE   PIC X(11).
              03  Z02-YUKOEDYMD.
                04  Z02-VALUE   PIC X(11).
              03  Z02-COLUMN1.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-DIGIT4.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-DIGIT3.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-DIGIT2.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-DIGIT1.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-COLUMN4.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-COLUMN3.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-COLUMN2.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-TEN.
                04  Z02-VALUE   PIC 9(9).
              03  Z02-HKNTEKKBN-COMBO.
                04  Z02-HKNTEKKBN    PIC X(13).
                04  Z02-HKNTEKKBN-COUNT   PIC S9(9)   BINARY.
                04  Z02-HKNTEKKBNLST PIC X(12)   OCCURS  3 TIMES.
              03  Z02-GAITENTTLKBN.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-NYUTENTTLKBN.
                04  Z02-VALUE   PIC 9(3).
              03  Z02-BUIKBN-COMBO.
                04  Z02-BUIKBN    PIC X(9).
                04  Z02-BUIKBN-COUNT   PIC S9(9)   BINARY.
                04  Z02-BUIKBNLST PIC X(8)   OCCURS  8 TIMES.
              03  Z02-FORMALNAME.
                04  Z02-VALUE   PIC X(201).
              03  Z02-INPCHKKBN.
                04  Z02-VALUE   PIC 9(1).
