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
            02  N31.
      *      02  N31-FIXED6.
              03  N31-B06.
                04  N31-B06-STATE         PIC S9(9)   BINARY.
              03  N31-B07.
                04  N31-B07-STATE         PIC S9(9)   BINARY.
              03  N31-POST                PIC X(7).
              03  N31-SCROLLEDWINDOW1.
                04  N31-CYOIKILST.
                  05  N31-CYOIKI-COUNT    PIC S9(9)   BINARY.
                  05  N31-CYOIKI-ROW      PIC S9(9)   BINARY.
                  05  N31-CYOIKI-ROWATTR  PIC S9(9)   BINARY.
                  05  N31-CYOIKI-ITEM     OCCURS  100 TIMES.
                    06  N31-CYO-HEN       PIC X(2).
                    06  N31-CYO-CD        PIC X(4).
                    06  N31-CYO-POST      PIC X(7).
                    06  N31-CYO-ADRS      PIC X(100).
                  05  N31-CYOIKI-SELECT   PIC X       OCCURS  100.
              03  N31-SELNUM              PIC S9(3).
              03  N31-PREFCDCOMBO.
                04  N31-PREFCD            PIC X(13).
                04  N31-PREFCD-COUNT      PIC S9(9)   BINARY.
                04  N31-PREFCD-ITEM       PIC X(13)   OCCURS  47.
              03  N31-PREFNAME            PIC X(10).
              03  N31-PREFKANA            PIC X(20).
              03  N31-CITYKANA            PIC X(100).
              03  N31-TOWNKANA            PIC X(100).
              03  N31-CITYNAME            PIC X(50).
              03  N31-TOWNNAME            PIC X(50).
