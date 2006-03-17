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
      *   リハビリ同一算定コードテーブル COPY (CMRIHACDTBL.INC)
      *----------------------------------------------------------------*
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *    リハビリのコード
       01  TBL-RIHABIRI-AREA.
      *    心血管疾病リハビリ
           03  FILLER              PIC X(12)   VALUE   "1  180027410".
           03  FILLER              PIC X(12)   VALUE   "1  180027510".
      *    脳血管疾病リハビリ
           03  FILLER              PIC X(12)   VALUE   "2  180027610".
           03  FILLER              PIC X(12)   VALUE   "2  180027710".
      *    運動器リハビリ
           03  FILLER              PIC X(12)   VALUE   "3  180027810".
           03  FILLER              PIC X(12)   VALUE   "3  180027910".
      *    呼吸器リハビリ
           03  FILLER              PIC X(12)   VALUE   "4  180028010".
           03  FILLER              PIC X(12)   VALUE   "4  180028110".
      *
       01  TBL-RIHABIRI-AREA-R     REDEFINES   TBL-RIHABIRI-AREA.
           03  TBL-RIHABIRI-OCC    OCCURS   8   INDEXED   TBL-RIH.
      *        リハビリ種類
               05  TBL-RIHA-KBN        PIC X(01).
               05  TBL-RIHA-YOBO       PIC X(02).
               05  TBL-RIHA-SRYCD      PIC X(09).
      *
       01  FLG-RIHA-OK                 PIC 9(01).
      *
