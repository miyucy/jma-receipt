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
      *    日次統計用入院情報取得パラメタ　COPY (CPORCBT120SUB.INC)
      *                                使用プログラム (ORCBT120SUB.CBL)
      *    設定項目
      *      医療機関ＩＤ
      *      患者ＩＤ
      *      算定年月日
      *      診療科
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCBT120SUB-AREA.
      *
      *医療機関ＩＤ
           03  LNK-ORCBT120SUB-HOSPID                PIC  X(24).
      *患者ＩＤ
           03  LNK-ORCBT120SUB-PTID                  PIC  9(10).
      *算定年月
           03  LNK-ORCBT120SUB-SANTEIYMD             PIC  X(08).
      *診療科（００：全科で固定セット）
           03  LNK-ORCBT120SUB-SRYKA                 PIC  X(02).
      *返却項目
           03  LNK-ORCBT120SUB-HENKYAKU-AREA.
      *医師コード
               05  LNK-ORCBT120SUB-DRCD              PIC  X(05).
      *入退院区分（１：当日入院　２：当日退院　３：入院中）
               05  LNK-ORCBT120SUB-NYUIN-KBN         PIC  9(01).
      *病棟番号
               05  LNK-ORCBT120SUB-BTUNUM            PIC  X(02).
      *病室番号
               05  LNK-ORCBT120SUB-BRMNUM            PIC  X(06).
      *前日病棟番号
               05  LNK-ORCBT120SUB-MAE-BTUNUM        PIC  X(02).
      *前日病室番号
               05  LNK-ORCBT120SUB-MAE-BRMNUM        PIC  X(06).
      *外泊区分
               05  LNK-ORCBT120SUB-GAIHAKU-KBN       PIC  9(01).
      *食事区分
               05  LNK-ORCBT120SUB-SKJ-KBN           PIC  9(01).
      *退院事由
               05  LNK-ORCBT120SUB-TAIINCD           PIC  X(02).
      *入院科
               05  LNK-ORCBT120SUB-NYUINKA           PIC  X(02).
      *レセ電入院科
               05  LNK-ORCBT120SUB-RECENYUINKA       PIC  X(02).
      *前日入院科
               05  LNK-ORCBT120SUB-MAE-NYUINKA       PIC  X(02).
      *前日レセ電入院科
               05  LNK-ORCBT120SUB-MAE-RECENYUINKA   PIC  X(02).
      *
      *復帰コード（１：算定日エラー　２：患者検索エラー　３：診療科エラー
      *            ４：未入院　５：情報取得エラー）
           03  LNK-ORCBT120SUB-RC                    PIC S9(9) BINARY.