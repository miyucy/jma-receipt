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
       01  SS002-AREA.
           03  SS002-IN.
               05  SS002-UPDKBN        PIC X(01).
               05  SS002-EDANUM        PIC 9(02).
           03  SS002-OT.
               05  SS002-SYURRKNUM     PIC S9(09)  BINARY.
               05  SS002-SYUEDANUM     PIC S9(09)  BINARY.
               05  SS002-SYURRKUPDKBN  PIC X(01).
               05  SS002-RC            PIC S9(09)  BINARY.
