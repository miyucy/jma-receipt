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
        02  I47.
          03  I47-PTNUM.
            04  I47-VALUE   PIC X(20).
          03  I47-SRYYM.
            04  I47-VALUE   PIC X(8).
          03  I47-KANANAME.
            04  I47-VALUE   PIC X(50).
          03  I47-NAME.
            04  I47-VALUE   PIC X(50).
          03  I47-BIRTHDAY.
            04  I47-VALUE   PIC X(9).
          03  I47-SEX.
            04  I47-VALUE   PIC X(2).
          03  I47-NYUINYMD.
            04  I47-VALUE   PIC X(9).
          03  I47-TAIINYMD.
            04  I47-VALUE   PIC X(9).
          03  I47-SELNUM.
            04  I47-VALUE   PIC X(50).
          03  I47-MEISYO.
            04  I47-VALUE   PIC X(200).
          03  I47-DAYALL.
            04  I47-VALUE   PIC X(2).
          03  I47-DAY-G.
            04  I47-DAY     PIC X(2)   OCCURS  31.
          03  I47-GRPINPUT.
            04  I47-VALUE   PIC X(50).
          03  I47-SCROLLEDWINDOW1.
            04  I47-RYOLIST.
              05  I47-RYOLIST-COUNT   PIC S9(9)   BINARY.
              05  I47-RYOLIST-ROW PIC S9(9)   BINARY.
              05  I47-RYOLIST-ROWATTR PIC S9(9)   BINARY.
              05  I47-RYOLIST-ITEM    OCCURS  100 TIMES.
                06  I47-TNUM    PIC X(2).
                06  I47-TMARK   PIC X(1).
                06  I47-TNAME   PIC X(100).
                06  I47-TDAYALL PIC X(2).
                06  I47-TDAY-G.
                  07  I47-TDAY  PIC X(2) OCCURS 31.
              05  I47-RYOLIST-SELECT
                      PIC X       OCCURS  100 TIMES.
