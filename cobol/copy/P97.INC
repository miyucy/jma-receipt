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
        02  P97.
      ****  02  P97-FIXED3.
              03  P97-SELNO.
                04  P97-VALUE   PIC S9(4).
              03  P97-NAMEKEN.
                04  P97-VALUE   PIC X(31).
              03  P97-KANA.
                04  P97-VALUE   PIC X(11).
              03  P97-SCROLLEDWINDOW2.
                04  P97-LIST.
                  05  P97-COUNT   PIC S9(9)   BINARY.
                  05  P97-ITEM        OCCURS  100 TIMES.
                    07  P97-NO      PIC X(5).
                    07  P97-PTNUM   PIC X(21).
                    07  P97-NAME    PIC X(51).
                    07  P97-SEX     PIC X(5).
                    07  P97-BIRTH   PIC X(13).
                    07  P97-RRKYMD  PIC X(13).
                  05  P97-SELECT  PIC X       OCCURS  100 TIMES.
