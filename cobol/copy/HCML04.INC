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
          01  HCML04.
              03  HCML04-PAGE        PIC  X(6).
              03  HCML04-MSTYMD      PIC  X(22).
              03  HCML04-HOSPNAME    PIC  X(60).
              03  HCML04-SRYCD       PIC  X(9)    OCCURS  15.
              03  HCML04-NAME        PIC  X(100)  OCCURS  15.
              03  HCML04-TEN         PIC  X(12)   OCCURS  15.
              03  HCML04-HKNTEK      PIC  X(12)   OCCURS  15.
              03  HCML04-BUI         PIC  X(10)   OCCURS  15.
              03  HCML04-GAITEN      PIC  X(3)    OCCURS  15.
              03  HCML04-NYUTEN      PIC  X(3)    OCCURS  15.
              03  HCML04-KRM1        PIC  X(1)    OCCURS  15.
              03  HCML04-KET1        PIC  X(1)    OCCURS  15.
              03  HCML04-KRM2        PIC  X(1)    OCCURS  15.
              03  HCML04-KET2        PIC  X(1)    OCCURS  15.
              03  HCML04-KRM3        PIC  X(1)    OCCURS  15.
              03  HCML04-KET3        PIC  X(1)    OCCURS  15.
              03  HCML04-KRM4        PIC  X(1)    OCCURS  15.
              03  HCML04-KET4        PIC  X(1)    OCCURS  15.
              03  HCML04-YUKOSTYMD   PIC  X(8)    OCCURS  15.
              03  HCML04-NYORO       PIC  X(2)    OCCURS  15.
              03  HCML04-YUKOEDYMD   PIC  X(8)    OCCURS  15.
