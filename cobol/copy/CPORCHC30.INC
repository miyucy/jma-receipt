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
      *    薬剤情報出力パラメタ              COPY (CPORCHC30.INC)
      *                                          (ORCHC30 で使用）
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCHC30AREA.
      *
      *    最大件数
           03  ORCHC30-MAX             PIC 9(04).
      *
           03  ORCHC30-DATA-TBL        OCCURS   99.
      *        薬剤コード
               05  ORCHC30-SRYCD       PIC X(09).
      *        用法コード（空白あり）
               05  ORCHC30-YSRYCD      PIC X(09).
      *        数量
               05  ORCHC30-SURYO       PIC 9(05)V9(03).
      *        日数（回数）
               05  ORCHC30-KAISU       PIC 9(03).
      *        （１：内服、２：頓服、３：外用、）
               05  ORCHC30-ZAIKBN      PIC X(01).
      *        用法コード２（表示のみ）
               05  ORCHC30-YOHOU-G.
                   07  ORCHC30-YOHOU       PIC X(09)   OCCURS  5.
      *
