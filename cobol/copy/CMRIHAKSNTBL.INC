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
      *----------------------------------------------------------------*
      *    リハビリの早期リハ加算テーブル COPY (CMRIHAKSNTBL.INC)
      *----------------------------------------------------------------*
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       01  TBL-RIHABIRI-AREA.
      *    理学早期リハ加算
           03  FILLER              PIC X(09)   VALUE   "180022970".
           03  FILLER              PIC X(09)   VALUE   "180023070".
           03  FILLER              PIC X(09)   VALUE   "180023170".
           03  FILLER              PIC X(09)   VALUE   "180023270".
           03  FILLER              PIC X(09)   VALUE   "180023370".
           03  FILLER              PIC X(09)   VALUE   "180023470".
           03  FILLER              PIC X(09)   VALUE   "180023570".
      *    作業早期リハ加算
           03  FILLER              PIC X(09)   VALUE   "180024070".
           03  FILLER              PIC X(09)   VALUE   "180024170".
           03  FILLER              PIC X(09)   VALUE   "180024270".
           03  FILLER              PIC X(09)   VALUE   "180024370".
           03  FILLER              PIC X(09)   VALUE   "180024470".
           03  FILLER              PIC X(09)   VALUE   "180024570".
           03  FILLER              PIC X(09)   VALUE   "180024670".
      *    理学早期リハ加算(老人）
           03  FILLER              PIC X(09)   VALUE   "180707670".
           03  FILLER              PIC X(09)   VALUE   "180707770".
           03  FILLER              PIC X(09)   VALUE   "180707870".
           03  FILLER              PIC X(09)   VALUE   "180707970".
           03  FILLER              PIC X(09)   VALUE   "180708570".
           03  FILLER              PIC X(09)   VALUE   "180708670".
           03  FILLER              PIC X(09)   VALUE   "180708770".
           03  FILLER              PIC X(09)   VALUE   "180708870".
      *    早期リハビリ加算（労災）
           03  FILLER              PIC X(09)   VALUE   "101800040".
           03  FILLER              PIC X(09)   VALUE   "101800050".
           03  FILLER              PIC X(09)   VALUE   "101800060".
           03  FILLER              PIC X(09)   VALUE   "101800070".
      *    理学療法外来移行加算(老人）
           03  FILLER              PIC X(09)   VALUE   "180708070".
      *    作業療法外来移行加算(老人）
           03  FILLER              PIC X(09)   VALUE   "180708970".
      *
       01  TBL-RIHABIRI-AREA-R       REDEFINES   TBL-RIHABIRI-AREA.
           03  TBL-RIHABIRI-OCC      OCCURS   28  INDEXED   TBL-RIDX.
               05  TBL-RIHA-SRYCD      PIC X(09).
      *
      *    早期リハビリあり
       01  FLG-SOUKI                   PIC 9(01).
      *
