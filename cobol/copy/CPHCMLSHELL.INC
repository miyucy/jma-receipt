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
       01  SHELL-AREA.
          03  SHELL-SRYCHK        PIC 9(01).
          03  SHELL-SRYKBN        PIC 9(01).
          03  SHELL-SRYSTR        PIC 9(02).
          03  SHELL-SRYEND        PIC 9(02).
          03  SHELL-TOKCHK        PIC 9(01).
      *----(01.01.01)--ADD-START---
          03  SHELL-COMCHK-G.
              05  SHELL-COMCHK    PIC 9(01)  OCCURS  3.
      *----(01.01.01)--ADD-END-----
          03  SHELL-IYKCHK-G.
              05  SHELL-IYKCHK    PIC 9(01)  OCCURS  6.
          03  SHELL-MSTYMD        PIC X(08).
          03  SHELL-CYUKBN        PIC 9(01).
          03  SHELL-SYUKBN        PIC 9(01).

