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
      *    患者                 COPY (CPPTINF.INC)     *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-太田     02/06/06  必要項目の見直し
      ************************************************************
      *01  QUERY-PTINF-REC.
      *キー
           03  QUERY-PTINF-KEY.
      *医療機関ＩＤ
               05  QUERY-PTINF-HOSPID          PIC  X(24).
      *患者ＩＤ
               05  QUERY-PTINF-PTID            PIC  9(10).
      *カナ氏名
           03  QUERY-PTINF-KANANAME            PIC  X(100).
      *漢字氏名
           03  QUERY-PTINF-NAME                PIC  X(100).
      *性別
           03  QUERY-PTINF-SEX                 PIC  X(01).
      *生年月日
           03  QUERY-PTINF-BIRTHDAY            PIC  X(08).
      *自宅−住所
           03  QUERY-PTINF-HOME-ADRS           PIC  X(200).
      *自宅−番地方書
           03  QUERY-PTINF-HOME-BANTI          PIC  X(200).
      *患者番号
           03  QUERY-PTINF-PTNUM               PIC  X(20).
      *
      *フリーＳＱＬ文（WHERE句）
           03  QUERY-PTINF-SQL                 PIC  X(15000).
