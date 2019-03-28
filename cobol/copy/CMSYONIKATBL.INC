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
      *    小児科外来診察料テーブル COPY (CMSYONIKATBL.INC)
      *----------------------------------------------------------------*
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       01  TBL-SYONIKA-AREA.
      *
           03  FILLER              PIC X(11)   VALUE   "  111010370".
           03  FILLER              PIC X(11)   VALUE   "3 111010470".
           03  FILLER              PIC X(11)   VALUE   "3 111010570".
           03  FILLER              PIC X(11)   VALUE   "3 111010670".
           03  FILLER              PIC X(11)   VALUE   "3 111010770".
           03  FILLER              PIC X(11)   VALUE   "  111010870".
           03  FILLER              PIC X(11)   VALUE   "  111010970".
           03  FILLER              PIC X(11)   VALUE   "  111011070".
           03  FILLER              PIC X(11)   VALUE   "  111011170".
           03  FILLER              PIC X(11)   VALUE   "4 112005770".
           03  FILLER              PIC X(11)   VALUE   "4 112005870".
           03  FILLER              PIC X(11)   VALUE   "4 112005970".
           03  FILLER              PIC X(11)   VALUE   "4 112006070".
           03  FILLER              PIC X(11)   VALUE   "1 113003510".
           03  FILLER              PIC X(11)   VALUE   "2 113003610".
           03  FILLER              PIC X(11)   VALUE   "1 113003710".
           03  FILLER              PIC X(11)   VALUE   "2 113003810".
           03  FILLER              PIC X(11)   VALUE   "  113005070".
           03  FILLER              PIC X(11)   VALUE   "  113005170".
           03  FILLER              PIC X(11)   VALUE   "4 113005270".
           03  FILLER              PIC X(11)   VALUE   "4 113005370".
           03  FILLER              PIC X(11)   VALUE   "4 113005470".
           03  FILLER              PIC X(11)   VALUE   "4 113005570".
      *    開放型病院共同指導料（１）
           03  FILLER              PIC X(11)   VALUE   "9 180010510".
      *    退院時共同指導加算
           03  FILLER              PIC X(11)   VALUE   "9 180015870".
      *    地域連携小児夜間・休日診療料
           03  FILLER              PIC X(11)   VALUE   "9 113006710".
      *    Ｈ１６．４から追加
           03  FILLER              PIC X(11)   VALUE   "3 113007070".
           03  FILLER              PIC X(11)   VALUE   "3 113007170".
           03  FILLER              PIC X(11)   VALUE   "3 113007270".
           03  FILLER              PIC X(11)   VALUE   "4 113007370".
           03  FILLER              PIC X(11)   VALUE   "4 113007470".
           03  FILLER              PIC X(11)   VALUE   "4 113007570".
           03  FILLER              PIC X(11)   VALUE   "4 113007670".
           03  FILLER              PIC X(11)   VALUE   "4 113007770".
           03  FILLER              PIC X(11)   VALUE   "4 113007870".
      *    時間外加算
           03  FILLER              PIC X(11)   VALUE   "3 113009670".
           03  FILLER              PIC X(11)   VALUE   "4 113009770".
           03  FILLER              PIC X(11)   VALUE   "4 113009870".
      *    療養担当手当（入院外）
           03  FILLER              PIC X(11)   VALUE   "9 199000610".
      *    診療情報提供料２（Ｈ１８／４から）
           03  FILLER              PIC X(11)   VALUE   "9 113009510".
      *    地域連携小児夜間・休日診療料２
           03  FILLER              PIC X(11)   VALUE   "9 113008210".
      *    院内トリアージ加算
           03  FILLER              PIC X(11)   VALUE   "9 113011570".
      *
       01  TBL-SYONIKA-AREA-R      REDEFINES   TBL-SYONIKA-AREA.
           03  TBL-SYONIKA-OCC     OCCURS  42  INDEXED   TBL-SYO.
      *        1:初診、2:再診、3:初診時間外、4:再診時間外
      *        9:小児科外来診察料以外でも算定可能
               05  TBL-SYONIKA-KBN         PIC X(01).
               05  TBL-YOBI1               PIC X(01).
               05  TBL-SYONIKA-SRYCD       PIC X(09).
      *
