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
         02  C06.
            03  C06-FIXED9.
              04  C06-SELNUM1 PIC X(5).
              04  C06-SELNUM2 PIC X(5).
              04  C06-SRYYM   PIC X(8).
              04  C06-SRYKBN-COMBO.
                05  C06-SRYKBN  PIC X(16).
                05  C06-COUNT3  PIC S9(9)   BINARY.
                05  C06-SRYKBNLST  PIC X(16)   OCCURS  10 TIMES.
              04  C06-SCR-TEKILST.
                05  C06-BYOMEILST.
                  06  C06-COUNT2   PIC S9(9)   BINARY.
                  06  C06-BYOMEI-ITEM        OCCURS  50 TIMES.
                    07  C06-TBANGO2   PIC X(5).
                    07  C06-TBYOMEI   PIC X(51).
                    07  C06-TSTRYMD   PIC X(10).
                    07  C06-TTENKI    PIC X(7).
                  06  C06-SELECT  PIC X       OCCURS  50 TIMES.
              04  C06-SCR-ACTLST.
                05  C06-SRYACTLST.
                  06  C06-COUNT1   PIC S9(9)   BINARY.
                  06  C06-SRYACT-ITEM        OCCURS  50 TIMES.
                    07  C06-TBANGO1     PIC X(5).
                    07  C06-TKOUIMEI    PIC X(41).
                  06  C06-SELECT1 PIC X       OCCURS  50 TIMES.
