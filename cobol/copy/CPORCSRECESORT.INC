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
      *    レセ器材再編集パラメタ　　COPY (CPORCSRECESORT.INC)
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSRECESORTAREA.
      *
      *入力
           03  ORCSRECESORT-IN-AREA.
      *医療機関ＩＤ
               05  ORCSRECESORT-HOSPID          PIC  X(24).
      *入外区分
               05  ORCSRECESORT-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  ORCSRECESORT-PTID            PIC  9(10).
      *診療年月
               05  ORCSRECESORT-SRYYM           PIC  X(06).
      *診療区分
               05  ORCSRECESORT-SRYKBN          PIC  X(02).
      *剤番号
               05  ORCSRECESORT-ZAINUM          PIC  9(08).
      *剤内容
               05  ORCSRECESORT-IN-TBL.
                   07  ORCSRECESORT-IN-SRYCD-G  OCCURS   50.
                       09  ORCSRECESORT-IN-SRYCD    PIC X(09).
      *                データ区分
                       09  ORCSRECESORT-IN-DATAKBN  PIC X(01).
      *                特定器材種別１
                       09  ORCSRECESORT-IN-TOKUKIZAISBT1 
                                                    PIC X(01).
      *                酸素等区分
                       09  ORCSRECESORT-IN-SANSOKBN PIC X(01).
      *出力
           03  ORCSRECESORT-OUT-AREA.
      *        器材テーブル（１：フィルム、２：酸素、３：窒素、４：その他器材）
               05  ORCSRECESORT-DATE-TBL       OCCURS   4.
      *            点数
                   07  ORCSRECESORT-ZAITEN     PIC  9(08).
      *            器材コード
                   07  ORCSRECESORT-SRYCD-G.
                       09  ORCSRECESORT-SRYCD       PIC X(09)
                                                    OCCURS   50.
      *エラーコード（１：剤なし）
           03  ORCSRECESORT-ERRCD           PIC 9(01).
      *
