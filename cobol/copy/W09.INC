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
        02  W09.
            03  W09-FIXED1.
              04  W09-YUKOSTYMD.
                05  W09-VALUE   PIC X(10).
              04  W09-YUKOEDYMD.
                05  W09-VALUE   PIC X(10).
              04  W09-B03.
                05  W09-B03-STATE   PIC S9(9)   BINARY.
              04  W09-SYURUINAME.
                05  W09-VALUE   PIC X(41).
              04  W09-PRTJYUNI.
                05  W09-VALUE   PIC X(3).
              04  W09-SYUBETU-G     OCCURS  10.
                  05  W09-SYUBETU.
                    06  W09-VALUE   PIC X(5).
              04  W09-SYUBETUNAME-G OCCURS  10.
                  05  W09-SYUBETUNAME.
                    06  W09-VALUE   PIC X(41).
              04  W09-TEISYUTUSAKI-COMBO.
                  05  W09-TEISYUTUSAKI   PIC X(27).
                  05  W09-TEISYUTUSAKI-COUNT   PIC S9(9)   BINARY.
                  05  W09-TEISYUTUSAKILST  PIC X(26)   OCCURS  5 TIMES.
