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
      *     カルテ３号様式出力パラメタ    COPY (CPORCHC33.INC)
      *                                          (ORCHC33 で使用）
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCHC33AREA.
      *
      *    処理区分（１：オンライン、２：一括）
           03  ORCHC33-KBN             PIC X(01).
      *
      *    患者番号
           03  ORCHC33-PTNUM           PIC X(20).
      *    患者ＩＤ
           03  ORCHC33-PTID            PIC 9(10).
      *    診療年月
           03  ORCHC33-SRYYM           PIC X(06).
      *    診療年月（終了）
           03  ORCHC33-SRYYM-END       PIC X(06).
      *    入外区分
           03  ORCHC33-NYUGAIKBN       PIC X(01).
      *    診療科
           03  ORCHC33-SRYKA           PIC X(02).
      *
      *    一括パラメタ
           03  ORCHC33-PRTAREA         PIC X(15000).
      *
      *出力領域
      *    ページ枚数
           03  ORCHC33-PAGE            PIC 9(04).
      *
      *    エラーコード
           03  ORCHC33-RC              PIC 9(02).
      *
