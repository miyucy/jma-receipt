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
            02  T01.
              03  T01-SKYYM.
                04  T01-VALUE   PIC X(7).
              03  T01-B06-STATE PIC S9(9)   BINARY.
              03  T01-B07-STATE PIC S9(9)   BINARY.
              03  T01-DATAKBN1.
                04  T01-DATAKBN1-STATE   PIC S9(9)   BINARY.
                04  T01-DATAKBN1-VALUE   PIC X.
              03  T01-DATAKBN2.
                04  T01-DATAKBN2-STATE   PIC S9(9)   BINARY.
                04  T01-DATAKBN2-VALUE   PIC X.
              03  T01-DATAKBN4.
                04  T01-DATAKBN4-STATE   PIC S9(9)   BINARY.
                04  T01-DATAKBN4-VALUE   PIC X.
              03  T01-DATAKBN5.
                04  T01-DATAKBN5-STATE   PIC S9(9)   BINARY.
                04  T01-DATAKBN5-VALUE   PIC X.
              03  T01-DATAKBN3.
                04  T01-DATAKBN3-STATE   PIC S9(9)   BINARY.
                04  T01-DATAKBN3-VALUE   PIC X.
              03  T01-SRYYM.
                04  T01-SRYYM-STATE   PIC S9(9)   BINARY.
                04  T01-SRYYM-VALUE   PIC X(20).
              03  T01-SKYYMD.
                04  T01-VALUE   PIC X(10).
              03  T01-PRTKBN1.
                04  T01-PRTKBN1-STYLE   PIC X(20).
                04  T01-PRTKBN1-VALUE   PIC X(4).
              03  T01-PRTKBN2.
                04  T01-PRTKBN2-STYLE   PIC X(20).
                04  T01-PRTKBN2-VALUE   PIC X(4).
              03  T01-HKNJANUM.
                04  T01-VALUE   PIC X(8).
              03  T01-HKNJAMEI.
                04  T01-VALUE   PIC X(40).
              03  T01-DATA-COMBO.
                04  T01-DATA-STATE PIC S9(9)   BINARY.
                04  T01-DATA.
                  05  T01-1VALUE    PIC X(22).
                04  T01-DATA-COUNT PIC S9(9)   BINARY.
                04  T01-DATA-ITEM
                        PIC X(22)   OCCURS  3 TIMES.
