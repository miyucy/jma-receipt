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
        02  W01.
            03  W01-FIXED1.
              04  W01-SCROLLEDWINDOW1.
                05  W01-TENSU-LIST.
                  06  W01-COUNT   PIC S9(9)   BINARY.
                  06  W01-ITEM        OCCURS  100 TIMES.
                    07  W01-TSELNUM     PIC X(4).
                    07  W01-TSTYUKYMD   PIC X(10).
                    07  W01-TEDYUKYMD   PIC X(10).
                  06  W01-SELECT  PIC X       OCCURS  100 TIMES.
              04  W01-STYUKYMD.
                05  W01-VALUE   PIC X(11).
              04  W01-EDYUKYMD.
                05  W01-VALUE   PIC X(11).
              04  W01-KANRICD-COMBO.
                05  W01-KANRICD   PIC X(36).
                05  W01-KANRICD-COUNT   PIC S9(9)   BINARY.
                05  W01-KANRICDLST  PIC X(35)   OCCURS  30 TIMES.
              04  W01-SELNUM.
                05  W01-VALUE   PIC 9(3).
              04  W01-KBNCD-COMBO.
                05  W01-KBNCD       PIC X(36).
                05  W01-KBNCD-COUNT PIC S9(9)   BINARY.
                05  W01-KBNCDLST    PIC X(35)   OCCURS  200 TIMES.
              04  W01-MIDASI.
                05  W01-VALUE   PIC X(20).
