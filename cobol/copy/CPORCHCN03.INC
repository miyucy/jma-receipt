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
      *    請求書兼領収書出力パラメタ      COPY (CPORCHCN03.INC)
      *                                          (ORCHCN03 で使用）
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC−多々納  02/03/14  今回請求額を追加
      ************************************************************
      *
       01  ORCHCN03AREA.
      *
      *    伝票番号（必須）
           03  ORCHCN03-DENPNUM        PIC 9(07).
      *
      *    今回請求額
           03  ORCHCN03-SEIKYU         PIC S9(07).
      *    今回入金額
           03  ORCHCN03-NYUKIN         PIC S9(07).
      *
