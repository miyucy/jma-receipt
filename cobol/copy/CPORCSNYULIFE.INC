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
      *    入院時生活療養費負担額取得パラメタ　　COPY (CPORCSNYULIFE.INC)
      *                                使用プログラム (ORCSNYULIFE)
      *    設定項目
      *      医療機関ＩＤ
      *      患者ＩＤ
      *      算定年月
      *
      *    ※返却項目の食事に係る金額は１食分の値を返却
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSNYULIFE-AREA.
      *
      *医療機関ＩＤ
           03  LNK-NYULIFE-HOSPID                     PIC  X(24).
      *患者ＩＤ
           03  LNK-NYULIFE-PTID                       PIC  9(10).
      *算定年月
           03  LNK-NYULIFE-SANTEIYM                   PIC  X(06).
      *返却項目
           03  LNK-NYULIFE-HENKYAKU-AREA.
      *入院時生活療養費返却テーブル
               05  LNK-NYULIFE-HENKYAKU-TABLE         OCCURS  31.
      *入院時生活療養費対象区分
                   07  LNK-NYULIFE-KBN                PIC  X(01).
      *入院時生活療養費負担軽減区分
                   07  LNK-NYULIFE-FTNKBN             PIC  X(01).
      *入院時生活療養費−食事−診療コード
                   07  LNK-NYULIFE-SKJ-SRYCD          PIC  X(09).
      *入院時生活療養費−食事−金額
                   07  LNK-NYULIFE-SKJ-MONEY          PIC  9(07).
      *入院時生活療養費−水光熱費−診療コード
                   07  LNK-NYULIFE-SUI-SRYCD          PIC  X(09).
      *入院時生活療養費−水光熱費−金額
                   07  LNK-NYULIFE-SUI-MONEY          PIC  9(07).
      *入院時生活療養費−食事負担−診療コード
                   07  LNK-NYULIFE-SKJFTN-SRYCD       PIC  X(09).
      *入院時生活療養費−食事負担−金額
                   07  LNK-NYULIFE-SKJFTN-MONEY       PIC  9(07).
      *入院時生活療養費−水光熱費負担−診療コード
                   07  LNK-NYULIFE-SUIFTN-SRYCD       PIC  X(09).
      *入院時生活療養費−水光熱費負担−金額
                   07  LNK-NYULIFE-SUIFTN-MONEY       PIC  9(07).
      *
      *復帰コード（１：算定年月エラー　２：患者検索エラー
      *            ３：入院会計なし）
           03  LNK-NYULIFE-RC                     PIC S9(9) BINARY.
      *
