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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
      ******************************************************************
      *    収納API共通コピー句          COPY (CPAPI023COMMON.INC)
      ******************************************************************
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
      *    請求点数名称
       01  TBL-HKNTEN-MEI-AREA.
           03  FILLER              PIC X(03)   VALUE   "A00".
           03  FILLER              PIC X(30)   VALUE   "初・再診料".
           03  FILLER              PIC X(03)   VALUE   "B00".
           03  FILLER              PIC X(30)   VALUE   "医学管理等".
           03  FILLER              PIC X(03)   VALUE   "C00".
           03  FILLER              PIC X(30)   VALUE   "在宅療養".
           03  FILLER              PIC X(03)   VALUE   "F00".
           03  FILLER              PIC X(30)   VALUE   "投薬".
           03  FILLER              PIC X(03)   VALUE   "G00".
           03  FILLER              PIC X(30)   VALUE   "注射".
           03  FILLER              PIC X(03)   VALUE   "J00".
           03  FILLER              PIC X(30)   VALUE   "処置".
           03  FILLER              PIC X(03)   VALUE   "K00".
           03  FILLER              PIC X(30)   VALUE   "手術".
           03  FILLER              PIC X(03)   VALUE   "L00".
           03  FILLER              PIC X(30)   VALUE   "麻酔".
           03  FILLER              PIC X(03)   VALUE   "D00".
           03  FILLER              PIC X(30)   VALUE   "検査".
           03  FILLER              PIC X(03)   VALUE   "E00".
           03  FILLER              PIC X(30)   VALUE   "画像診断".
           03  FILLER              PIC X(03)   VALUE   "H00".
           03  FILLER              PIC X(30)   VALUE   "リハビリ".
           03  FILLER              PIC X(03)   VALUE   "I00".
           03  FILLER              PIC X(30)   VALUE   "精神科専門".
           03  FILLER              PIC X(03)   VALUE   "M00".
           03  FILLER              PIC X(30)   VALUE   "放射線治療".
           03  FILLER              PIC X(03)   VALUE   "N00".
           03  FILLER              PIC X(30)   VALUE   "病理診断".
           03  FILLER              PIC X(03)   VALUE   "A10".
           03  FILLER              PIC X(30)   VALUE   "入院料".
           03  FILLER              PIC X(03)   VALUE   "001".
           03  FILLER              PIC X(30)   VALUE   "療養担当手当".
       01  TBL-HKNTEN-MEI-RES      REDEFINES   TBL-HKNTEN-MEI-AREA.
           03  TBL-HKNTEN-MEI-OCC  OCCURS   16.
               05  TBL-HKNTEN-KBN  PIC X(03).
               05  TBL-HKNTEN-MEI  PIC X(30).
