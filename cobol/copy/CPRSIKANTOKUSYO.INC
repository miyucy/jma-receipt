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
      *******************************************************************
      ************************************************************
      *    労災基準監督署マスタ     COPY  (CPRSIKANTOKUSYO.INC)  *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RSIKANTOKUSYO-REC.
      *キー
           03  RSIKANTOKUSYO-KEY.
      *署コード
               05  RSIKANTOKUSYO-SYOCD          PIC  X(05).
      *有効開始年月日
               05  RSIKANTOKUSYO-YUKOSTYMD      PIC  X(08).
      *有効終了年月日
               05  RSIKANTOKUSYO-YUKOEDYMD      PIC  X(08).
      *名称
           03  RSIKANTOKUSYO-NAME               PIC  X(50).
      *端末ＩＤ
           03  RSIKANTOKUSYO-TERMID             PIC  X(16).
      *オペーレータＩＤ
           03  RSIKANTOKUSYO-OPID               PIC  X(16).
      *作成年月日
           03  RSIKANTOKUSYO-CREYMD             PIC  X(08).
      *更新年月日
           03  RSIKANTOKUSYO-UPYMD              PIC  X(08).
      *更新時間
           03  RSIKANTOKUSYO-UPHMS              PIC  X(06).
