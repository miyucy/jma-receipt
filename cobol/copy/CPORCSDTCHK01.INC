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
       01  SDTCHK01AREA.
           03  SDTCHK01-CHK-PTN-G.
               05  SDTCHK01-CHK-PTN-OCC        OCCURS  5.
                   07  SDTCHK01-CHK-PTN        PIC 9(01).
           03  SDTCHK01-IN.
               05  SDTCHK01-HOSPID             PIC X(24).
               05  SDTCHK01-PTID               PIC 9(10).
               05  SDTCHK01-SRYKA              PIC X(02).
               05  SDTCHK01-CHKKBN             PIC X(01).
               05  SDTCHK01-SRYCD              PIC X(09).
               05  SDTCHK01-KJNYMD             PIC X(08).
               05  SDTCHK01-CDKBN              PIC X(01).
               05  SDTCHK01-NYUGAIKBN          PIC X(01).
           03  SDTCHK01-OT.
               05  SDTCHK01-O-OK               PIC 9(01).
               05  SDTCHK01-O-MAX              PIC 9(05).
               05  SDTCHK01-O-OCC              OCCURS 100.
                   07  SDTCHK01-O-ERRFLG       PIC 9(01).
                   07  SDTCHK01-O-SRYYMD       PIC X(08).
                   07  SDTCHK01-O-BYOMEI       PIC X(160).
