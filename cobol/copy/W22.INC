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
        02  W22.
            03  W22-FIXED6.
              04  W22-KANRICDCOMBO.
                05  W22-KANRICD.
                  06  W22-VALUE              PIC X(31).
                05  W22-KANRICD-COUNT        PIC S9(9)   BINARY.
                05  W22-KANRICD-ITEM         PIC X(30) OCCURS  20 TIMES.
              04  W22-KBNCD.
                05  W22-VALUE                PIC X(09).
              04  W22-MEISYOU.
                05  W22-VALUE                PIC X(51).
              04  W22-STYUKYMD.
                05  W22-VALUE                PIC X(10).
              04  W22-EDYUKYMD.
                05  W22-VALUE                PIC X(10).
              04  W22-MEISYOUWINDOW.
                05  W22-MEISYOULIST.
                  06  W22-MEISYOU-COUNT      PIC S9(9)   BINARY.
                  06  W22-MEISYOU-ITEM           OCCURS  20 TIMES.
                    07  W22-VALUE1           PIC X(16).
                    07  W22-VALUE2           PIC X(60).
                    07  W22-VALUE3           PIC X(19).
                    07  W22-VALUE4           PIC X(19).
                  06  W22-MEISYOU-SELECT     PIC X OCCURS  20 TIMES.