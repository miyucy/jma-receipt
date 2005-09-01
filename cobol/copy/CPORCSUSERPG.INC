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
      *----------------------------------------------------------*
      *    ユーザプログラム起動パラメタ      COPY (CPORCSUSERPG.INC)
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCSUSERPGAREA.
      *
      *処理ＰＧ
           03  ORCSUSERPG-GMNPG            PIC X(08).
      *
      *処理状況（１：追加、２：更新、３：削除）
           03  ORCSUSERPG-SYORI            PIC X(01).
      *システム日付西暦
           03  ORCSUSERPG-SYSYMD           PIC X(08).
      *診療日
           03  ORCSUSERPG-SRYYMD           PIC X(08).
      *患者ＩＤ
           03  ORCSUSERPG-PTID             PIC 9(10).
      *患者番号
           03  ORCSUSERPG-PTNUM            PIC X(20).
      *
