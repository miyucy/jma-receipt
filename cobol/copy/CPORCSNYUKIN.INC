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
      *    まとめ入金編集パラメタ                                 *
      *                         COPY  (CPORCSNYUKIN.INC)          *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSNYUKINAREA.
      *入力値
      *    医療機関ＩＤ（必須）
           03  LNK-SCNYUKIN-HOSPID           PIC X(24).
      *    患者ＩＤ（必須）
           03  LNK-SCNYUKIN-PTID             PIC 9(10).
      *    処理区分（必須）
      *      １：未収仮入金
      *      ２：未収更新（収納実更新）
           03  LNK-SCNYUKIN-SYORIKBN         PIC X(01).
      *    入金額
           03  LNK-SCNYUKIN-NYUKIN-MONEY     PIC 9(08).
      *    入金日
           03  LNK-SCNYUKIN-NYUKIN-YMD       PIC X(08).
      *出力値
           03  LNK-SCNYUKIN-OUT-AREA.
      *        入金振り分け情報
               05  LNK-SCNYUKIN-FURIWAKE-INF   OCCURS  100.
      *            伝票番号
                   07  LNK-SCNYUKIN-DENPNUM    PIC 9(07).
      *            請求額
                   07  LNK-SCNYUKIN-SKYMONEY   PIC 9(07).
      *            入金振り分け額
                   07  LNK-SCNYUKIN-FURIWAKEMONEY  PIC 9(07).
      *復帰コード
      *    00:正常
      *    10:パラメータ不正
      *    11:入金振り分け対象データなし
      *    12:入金振り分け対象データ１００件以上の為、処理不可
           03  LNK-SCNYUKIN-RC              PIC 9(02).
      *
      *
