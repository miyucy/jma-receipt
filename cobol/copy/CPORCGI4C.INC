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
      *    剤セット、チェック　   COPY (CPORCGI4C.INC)
      *                              (ORCGI4C で使用）
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCGI4CAREA.
      *
      *    処理画面
           03  LNK-GI4C-PG            PIC X(04).
      *
      *    セット入力のセットコード
           03  LNK-GI4C-SETCODE       PIC X(06).
      *    小児科外来診療科算定有り
           03  LNK-GI4C-SYONIKA-ARI2  PIC  9(01).
      *
