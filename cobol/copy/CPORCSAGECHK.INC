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
      *    保険算定用年齢・割合計算パラメタ                      *
      *                         COPY  (CPORCSAGECHK.INC)          *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSAGECHKAREA.
      *入力値
      *    医療機関ＩＤ（必須）
           03  AGECHK-HOSPID           PIC X(24).
      *    患者ＩＤ（必須）
           03  AGECHK-PTID             PIC 9(10).
      *    診療日（必須）
           03  AGECHK-SRYYMD           PIC X(08).
      *    患者生年月日
           03  AGECHK-BIRTHDAY         PIC X(08).
      *    保険組合番号
           03  AGECHK-HKNCOMBINUM      PIC X(04).
      *出力値
           03  AGECHK-OUT-AREA.
      *        年齢
               05  AGECHK-NENREI         PIC 9(03).
      *        以下、保険組合番号入力時
      *        負担割合（３歳未満と70歳以上の８，９割給付のみ）
               05  AGECHK-FTNRATE        PIC 9(03).
      *        負担割合名称
               05  AGECHK-FTNRATEMEI     PIC X(10).
      *        老人エラー（１：老人保険なし）
               05  AGECHK-RJNCHK         PIC 9(01).
      *    復帰コード
           03  AGECHK-RC              PIC 9(02).
      *
      *
