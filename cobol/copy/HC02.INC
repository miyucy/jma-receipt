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
        01  HC02.
              03  HC02-SRYKA    PIC  X(2).
              03  HC02-FTNJA    PIC  X(16).
              03  HC02-JKYSNUM    PIC  X(14).
              03  HC02-HKNJA    PIC  X(16).
              03  HC02-KIGONUM    PIC  X(22).
              03  HC02-NAME    PIC  X(24).
              03  HC02-BIRTH    PIC  X(22).
              03  HC02-KOFYMD    PIC  X(22).
              03  HC02-SEX    PIC  X(2).
              03  HC02-KIKYY    PIC  X(4).
              03  HC02-KIKMM    PIC  X(4).
              03  HC02-KIKDD    PIC  X(4).
              03  HC02-FTNJA2    PIC  X(16).
              03  HC02-JKYSNUM2    PIC  X(14).
              03  HC02-HOSPADRS    PIC  X(30).
              03  HC02-HOSPNAME    PIC  X(30).
              03  HC02-HOSPTEL    PIC  X(30).
              03  HC02-DRNAME    PIC  X(26).
              03  HC02-NAIYO     PIC  X(86)   OCCURS  20.
      ********03  HC02-NAIYO1    PIC  X(86).
      *       03  HC02-NAIYO2    PIC  X(86).
      *       03  HC02-NAIYO3    PIC  X(86).
      *       03  HC02-NAIYO4    PIC  X(86).
      *       03  HC02-NAIYO5    PIC  X(86).
      *       03  HC02-NAIYO6    PIC  X(86).
      *       03  HC02-NAIYO7    PIC  X(86).
      *       03  HC02-NAIYO8    PIC  X(86).
      *       03  HC02-NAIYO9    PIC  X(86).
      *       03  HC02-NAIYO10    PIC  X(86).
      *       03  HC02-NAIYO11    PIC  X(86).
      *       03  HC02-NAIYO12    PIC  X(86).
      *       03  HC02-NAIYO13    PIC  X(86).
      *       03  HC02-NAIYO14    PIC  X(86).
      *       03  HC02-NAIYO15    PIC  X(86).
      *       03  HC02-NAIYO16    PIC  X(86).
      *       03  HC02-NAIYO17    PIC  X(86).
      *       03  HC02-NAIYO18    PIC  X(86).
      *       03  HC02-NAIYO19    PIC  X(86).
      ********03  HC02-NAIYO20    PIC  X(86).
              03  HC02-PTNUM    PIC  X(20).
              03  HC02-HONKZKKBN    PIC  X(16).
              03  HC02-FTNKBN    PIC  X(20).
