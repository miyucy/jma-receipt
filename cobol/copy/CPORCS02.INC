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
      *    負担金額算定用パラメタ（入院用）COPY (CPORCS02.INC)
      *                                使用プログラム (ORCS02)
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  LNK-ORCS02-REC.
      *医療機関ＩＤ
           03  LNK-S02-HOSPID              PIC  X(24).
      *入外区分
           03  LNK-S02-NYUGAIKBN           PIC  X(01).
      *患者ＩＤ
           03  LNK-S02-PTID                PIC  9(10).
      *再計算処理区分
           03  LNK-S02-SAIKEISAN-KBN       PIC  X(01).
      *再計算対象伝票番号
           03  LNK-S02-SAIKEISAN-DENPYO    PIC  9(07).
      *自賠責手技点合計
           03  LNK-S02-SYUTEN              PIC  9(07).
      *高齢者算定患者区分
           03  LNK-S02-KOUREI-NYUIN-KBN    PIC  X(01).
      *入院通算日数
           03  LNK-S02-NYUIN-TSUSAN-NISSU  PIC  9(04).
      *請求開始日
           03  LNK-S02-SKYSTYMD            PIC  X(08).
      *請求終了日
           03  LNK-S02-SKYEDYMD            PIC  X(08).
      *定期請求区分
           03  LNK-S02-TEIKI-KBN           PIC  X(01).
      *システム日付
           03  LNK-S02-SYSYMD              PIC  X(08).
      *公費（更正）の請求年月・入院日数
           03  LNK-S02-KOSEI-AREA.
              05  LNK-S02-KOSEI-OCC        OCCURS   2.
                07  LNK-S02-KOSEI-YYMM     PIC  X(06).
                07  LNK-S02-KOSEI-NISUU    PIC  9(02).
      *公費（育成）の請求年月・入院日数
           03  LNK-S02-IKUSEI-AREA.
              05  LNK-S02-IKUSEI-OCC       OCCURS   2.
                07  LNK-S02-IKUSEI-YYMM    PIC  X(06).
                07  LNK-S02-IKUSEI-NISUU   PIC  9(02).
      *船員保険（被保険者）＋通勤災害＋初診時
           03  LNK-S02-SENINFLG            PIC  X(01).
      *自賠責診断書料金額
           03  LNK-S02-SINDAN              PIC  9(07).
      *自賠責明細書料金額
           03  LNK-S02-MEISAI              PIC  9(07).
      *自賠責療養担当手当点数
           03  LNK-S02-RYOYO               PIC  9(07).
      *復帰コード
           03  LNK-S02-RC                  PIC S9(9)   BINARY.
      *
