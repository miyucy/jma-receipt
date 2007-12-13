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
      *    短期滞在手術基本料２入院取得パラメタ　COPY (CPORCSTANKI2.INC)
      *                                使用プログラム (ORCSTANKI2)
      *    設定項目
      *      医療機関番号
      *      患者ＩＤ
      *      算定年月
      *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSTANKI2-AREA.
      *
      *医療機関番号
           03  LNK-TANKI2-HOSPNUM             PIC 9(2).
      *患者ＩＤ
           03  LNK-TANKI2-PTID                PIC  9(10).
      *算定年月
           03  LNK-TANKI2-SANTEIYM            PIC  X(06).
      *返却項目
           03  LNK-TANKI2-HENKYAKU-AREA.
      *短期滞在手術基本料２入院区分
             05  LNK-TANKI2-TBL.
      *  （空白：対象外　１：入院）
               07  LNK-TANKI2-KBN             PIC  X(01)  OCCURS  31.
      *
      *復帰コード（１：算定年月エラー　２：患者検索エラー
      *            ３：入院会計なし　４：短期滞在手術基本料２未算定）
           03  LNK-TANKI2-RC                        PIC S9(9) BINARY.
      *
