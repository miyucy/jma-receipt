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
      *    入院会計作成用パラメタ　　　COPY (CPORCHCM34S01.INC)
      *                                使用プログラム (ORCHCM34S01)
      *    設定項目
      *      医療機関ＩＤ
      *      患者ＩＤ
      *      算定年月
      *      保険組合せ
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  HCM34S01-AREA.
      *
      *医療機関ＩＤ
           03  HCM34S01-HOSPID                 PIC X(24).
      *患者ＩＤ
           03  HCM34S01-PTID                   PIC 9(10).
      *算定年月
           03  HCM34S01-SANTEIYM               PIC X(06).
      *保険組合せ
           03  HCM34S01-HKNCOMBI               PIC 9(04).
      *保険番号
           03  HCM34S01-HKNNUM                 PIC X(03).
      *返却項目
           03  HCM34S01-HENKYAKU-AREA.
      *
      *選定入院料患者自己負担額
               05  HCM34S01-SENTEI-PTFTN       PIC 9(08).
      *
      *返却テーブル
               05  HCM34S01-HENKYAKU-MAX       PIC 9(05).
               05  HCM34S01-HENKYAKU-TBL       OCCURS  100.
      *入院基本料診療区分
                   07  HCM34S01-SRYKBN         PIC  X(02).
      *剤識別区分
                   07  HCM34S01-ZAISKBKBN      PIC  X(01).
      *剤点数
                   07  HCM34S01-ZAITEN         PIC  9(08).
      *剤回数
                   07  HCM34S01-ZAIKAISU       PIC  9(07).
      *診療コード
                   07  HCM34S01-SRYCD          PIC  X(09)
                                               OCCURS  20.
      *診療回数テーブル
                   07  HCM34S01-DAY-TBL.
                       09  HCM34S01-DAY        PIC  9(03)
                                               OCCURS  31.
      *復帰コード（１：算定年月エラー　２：患者検索エラー　３：入院なし）
           03  HCM34S01-RC                     PIC S9(9) BINARY.
      *
