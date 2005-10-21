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
       01  QSUB03-LNK.
           03  QSUB03-IN-AREA.
               05  QSUB03-HOSPID       PIC X(24).
               05  QSUB03-PTID         PIC 9(10).
               05  QSUB03-KJNYMD       PIC X(08).
           03  QSUB03-OT-AREA.
               05  QSUB03-HKNCOMBI     PIC X(04).
               05  QSUB03-HKNNUM       PIC X(03).
               05  QSUB03-HKNCOMBIMEI  PIC X(20).
               05  QSUB03-SRYKA        PIC X(02).
               05  QSUB03-LASTYMD      PIC X(08).
               05  QSUB03-BRMNUM       PIC X(10).
