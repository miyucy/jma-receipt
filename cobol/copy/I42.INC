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
        02  I42.
              03  I42-PTNUM.
                04  I42-VALUE   PIC X(20).
              03  I42-KANANAME.
                04  I42-VALUE   PIC X(30).
              03  I42-NAME.
                04  I42-VALUE   PIC X(30).
              03  I42-BIRTHDAY.
                04  I42-VALUE   PIC X(9).
              03  I42-SEX.
                04  I42-VALUE   PIC X(2).
              03  I42-SRYKA.
                04  I42-VALUE   PIC X(10).
              03  I42-SCROLLEDWINDOW1.
                04  I42-SRYACTYMD.
                  05  I42-SRYACTYMD-COUNT   PIC S9(9)   BINARY.
                  05  I42-SRYACTYMD-ITEM        OCCURS  100 TIMES.
                    06  I42-SRYACTYMD-YMD  PIC X(10).
                    06  I42-SRYACTYMD-NAME  PIC X(40).
                  05  I42-SRYACTYMD-SELECT  PIC X   OCCURS  100 TIMES.
              03  I42-SCROLLEDWINDOW2.
                04  I42-SRYACTCNT.
                  05  I42-SRYACTCNT-COUNT   PIC S9(9)   BINARY.
                  05  I42-SRYACTCNT-ITEM        OCCURS  100 TIMES.
                    06  I42-SRYACTCNT-YM    PIC X(7).
                    06  I42-SRYACTCNT-NAME  PIC X(40).
                    06  I42-SRYACTCNT-CNT    PIC X(5).
                  05  I42-SRYACTCNT-SELECT  PIC X    OCCURS  100 TIMES.
