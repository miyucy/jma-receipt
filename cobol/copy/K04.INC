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
         02  K04.
            03  K04-FIXED31.
              04  K04-PTNUM   PIC X(21).
              04  K04-KANANAME    PIC X(31).
              04  K04-NAME    PIC X(31).
              04  K04-BIRTHDAY    PIC X(10).
              04  K04-SEX PIC X(3).
              04  K04-SRYYM   PIC X(10).
              04  K04-SRYKA   PIC X(11).
              04  K04-SANTEILIST.
                05  K04-SANTEILIST-COUNT PIC S9(9) BINARY.
                05  K04-SANTEILIST-ITEM  OCCURS  30 TIMES.
                  06  K04-SANTEINAME  PIC X(51).
                  06  K04-SRYKAMEI    PIC X(9).
                  06  K04-SYOKAIYMD   PIC X(10).
                  06  K04-SANTEIYMD   PIC X(10).
                  06  K04-KAISU       PIC X(4).
                  06  K04-YY          PIC X(5).
                  06  K04-MM          PIC X(3).
                  06  K04-DD          PIC X(3).
                05  K04-SANTEILIST-SELECT PIC X OCCURS 30 TIMES.
              04  K04-NENREI    PIC X(07).