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
      ************************************************************
      *    労災入院会計作成用パラメタ　　　COPY (CPORCSROUNYUIN.INC)
      *                                使用プログラム (ORCSROUNYUIN)
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSROUNYUIN-AREA.
      *
      *医療機関ＩＤ
           03  LNK-SROUNYUIN-HOSPID                  PIC  X(24).
      *患者ＩＤ
           03  LNK-SROUNYUIN-PTID                    PIC  9(10).
      *算定日
           03  LNK-SROUNYUIN-SANTEIYMD               PIC  X(08).
      *保険組合せ
           03  LNK-SROUNYUIN-HKNCOMBI                PIC  9(04).
      *剤点数
           03  LNK-SROUNYUIN-ZAITEN                  PIC  9(08).
      *診療コード計
           03  LNK-SROUNYUIN-SRYCDTOTAL              PIC  9(14).
      *明細数
           03  LNK-SROUNYUIN-MEISAISU                PIC  9(07).
      *診療コード
           03  LNK-SROUNYUIN-ROUSAI.
               05  LNK-SROUNYUIN-SRYCD               PIC  X(09)
                                                     OCCURS 20.
      *復帰コード
           03  LNK-SROUNYUIN-RC                      PIC S9(9) BINARY.
      *
