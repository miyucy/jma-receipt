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
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
        02  O03.
      *    02  O03-FIXED6.
              03  O03-SYOKBN-VALUE     PIC X.
              03  O03-SYOKBN-LABEL     PIC X(8).
              03  O03-TPAGE-G  OCCURS 36.
                04  O03-TPAGE.
                  05  O03-VALUE        PIC  9(4).
              03  O03-TKENSU-G OCCURS 36.
                04  O03-TKENSU.
                  05  O03-VALUE        PIC  9(4).
              03  O03-TCHK-G OCCURS 36.
                04  O03-TCHK.
                  05  O03-TCHK-STATE   PIC S9(09) BINARY.
                  05  O03-TCHK-VALUE   PIC X.
                  05  O03-TCHK-LABEL   PIC X(20).
              03  O03-FILEKBN.
                04  O03-VALUE   PIC X(34).
              03  O03-CREYMD.
                04  O03-VALUE   PIC X(22).
              03  O03-KENSU.
                04  O03-VALUE   PIC  9(4).
              03  O03-PAGE.
                04  O03-VALUE   PIC  9(4).
              03  O03-PRTJYUN-COMBO.
                04  O03-PRTJYUN.
                  05  O03-VALUE   PIC X(25).
                04  O03-PRTJYUN-COUNT   PIC S9(9)   BINARY.
                04  O03-PRTJYUNLST      PIC X(25)   OCCURS  5 TIMES.
