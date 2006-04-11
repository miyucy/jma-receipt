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
      *    診療費明細書出力パラメタ       COPY (CPORCHC04.INC)
      *                                          (ORCHC04 で使用）
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCHC04AREA.
      *
      *    伝票番号（必須）
           03  ORCHC04-DENPNUM          PIC 9(07).
      *
      *    発行区分 (2:訂正)
           03  ORCHC04-HAKKOFLG        PIC 9(01).
      *    発行方法（1:科・保険別、2:保険別、3:科別、4:全体)
      *             (0:伝票番号分のみ)
           03  ORCHC04-HAKHOUFLG        PIC 9(01).
      *    伝票番号枝番（収納からの再発行）
           03  ORCHC04-DENPEDANUM      PIC  9(02).
      *
