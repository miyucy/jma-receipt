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
      *****************************************************************
      *
      *     一時ファイル 名称領域      CPCOMMONDAT3.INC
      *
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 
      *****************************************************************
       01  TMPFLPARA.
           03  FILLER                  PIC X(05)   VALUE   "/tmp/".
           03  TMPFLPARA-HOSPNUM       PIC 9(2).
           03  TMPFLPARA-SYOKBN1       PIC 9(01)   VALUE   0.
           03  TMPFLPARA-SYOKBN2       PIC 9(01)   VALUE   0.
           03  TMPFLPARA-FILE-ID       PIC X(08).
           03  TMPFLPARA-TERMID        PIC X(64).
           03  FILLER                  PIC X(04)   VALUE   ".dat".
