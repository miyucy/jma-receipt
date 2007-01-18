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
           03  SS002-IDX               PIC 9(03).
           03  SS002-OT.
               05  SS002-SKYMONEY      PIC S9(08).
               05  SS002-HKNTEN        PIC S9(08).
               05  SS002-HKNMONEY      PIC S9(08).
               05  SS002-JIHIMONEY     PIC S9(08).
               05  SS002-SKJMONEY      PIC S9(08).
               05  SS002-LIFEMONEY     PIC S9(08).
               05  SS002-CHOSEI        PIC S9(08).
               05  SS002-DISCOUNTMONEY PIC S9(08).
               05  SS002-JIHI-G.
                   07  SS002-JIHI      PIC S9(08)
                                       OCCURS  10.
               05  SS002-RMSAGAKU      PIC S9(08).
