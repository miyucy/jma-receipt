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
      ************************************************************
      *    印刷用コンスタント領域 COPY (CPPRTCONST.INC)          *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ENUM-VALUES.
           02  PRTCONST-T.
             03  PRTCONST-T11.
               05  PRTCONST-PRTID-T11  PIC  X(10)
                                       VALUE   "HC401     " .
               05  PRTCONST-PRTID-T12  PIC  X(10)
                                       VALUE   "HC07      " .
               05  PRTCONST-PRTID-T13  PIC  X(10)
                                       VALUE   "HC17      " .
               05  PRTCONST-PRTID-T14  PIC  X(10)
                                       VALUE   "HC17V01   " .
               05  PRTCONST-PRTID-T15  PIC  X(10)
                                       VALUE   "HC08      " .
               05  PRTCONST-PRTID-T16  PIC  X(10)
                                       VALUE   "HC08V01   " .
               05  PRTCONST-PRTID-T17  PIC  X(10)
                                       VALUE   "HC04      " .
               05  PRTCONST-PRTID-T18  PIC  X(10)
                                       VALUE   "HC04V01   " .
               05  PRTCONST-PRTID-T19  PIC  X(10)
                                       VALUE   "HC04V02   " .
               05  PRTCONST-PRTID-T19  PIC  X(10)
                                       VALUE   "HC04V03   " .
               05  PRTCONST-PRTID-T21  PIC  X(10)
                                       VALUE   "HC041     " .
               05  PRTCONST-PRTID-T22  PIC  X(10)
                                       VALUE   "HC041V01  " .
               05  PRTCONST-PRTID-T23  PIC  X(10)
                                       VALUE   "HC041V02  " .
               05  PRTCONST-PRTID-T23  PIC  X(10)
                                       VALUE   "HC041V03  " .
               05  PRTCONST-PRTID-T24  PIC  X(10)
                                       VALUE   "HCML01    " .
               05  PRTCONST-PRTID-T25  PIC  X(10)
                                       VALUE   "HCML02    " .
               05  PRTCONST-PRTID-T26  PIC  X(10)
                                       VALUE   "HCML03    " .
               05  PRTCONST-PRTID-T27  PIC  X(10)
                                       VALUE   "HCML06    " .
               05  PRTCONST-PRTID-T27  PIC  X(10)
                                       VALUE   "HCM2C     " .
               05  PRTCONST-PRTID-T27  PIC  X(10)
                                       VALUE   "HCM2D     " .
               05  PRTCONST-PRTID-T27  PIC  X(10)
                                       VALUE   "HCM2E     " .
               05  PRTCONST-PRTID-T27  PIC  X(10)
                                       VALUE   "HCM2F     " .
           02  PRTCONST-R  REDEFINES   PRTCONST-T.
             03  PRTCONST-TX           OCCURS  31.
               05  PRTCONST-PRTID      PIC  X(10).
