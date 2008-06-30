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
      *    入院診療行為照会テーブル    COPY (CPNSHOUKAI.INC)             *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付     内容
      ************************************************************
      *01  NSHOUKAI-REC.
           03  NSHOUKAI-HOSPNUM        PIC 9(02).
           03  NSHOUKAI-PTID           PIC 9(10).
           03  NSHOUKAI-SRYYMD         PIC X(08).
           03  NSHOUKAI-SRYKA          PIC X(02).
           03  NSHOUKAI-HKNCOMBINUM    PIC X(04).
           03  NSHOUKAI-SRYCD          PIC X(09).
           03  NSHOUKAI-TERMID         PIC X(16).
           03  NSHOUKAI-OPID           PIC X(16).
           03  NSHOUKAI-CREYMD         PIC X(08).
           03  NSHOUKAI-UPYMD          PIC X(08).
           03  NSHOUKAI-UPHMS          PIC X(06).
