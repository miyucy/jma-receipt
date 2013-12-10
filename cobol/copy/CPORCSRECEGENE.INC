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
      *    院外処方一般名編集パラメタ　　COPY (CPORCSRECEGENE.INC)
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSRECEGENEAREA.
      *
      *入力
           03  ORCSRECEGENE-IN-AREA.
      *医療機関ＩＤ
               05  ORCSRECEGENE-HOSPNUM         PIC  9(02).
      *患者ＩＤ
               05  ORCSRECEGENE-PTID            PIC  9(10).
      *診療年月
               05  ORCSRECEGENE-SRYYM           PIC  X(06).
      *入外区分
               05  ORCSRECEGENE-NYUGAIKBN       PIC  X(01).
      *剤番号
               05  ORCSRECEGENE-ZAINUM          PIC  9(08).
      *
      *後発医薬品への変更可署名(SYS-1030-KOUHATUKA)
               05  ORCSRECEGENE-KOUHATUKA       PIC  X(01).
      *出力
           03  ORCSRECEGENE-OUT-AREA.
      *ＭＡＸ
               05  ORCSRECEGENE-TBLMAX         PIC  9(03).
               05  ORCSRECEGENE-SRYCD-G        OCCURS   50.
      *            診療コード
                   07  ORCSRECEGENE-SRYCD          PIC X(09).
      *            一般名コード（薬価基準コード）
                   07  ORCSRECEGENE-YAKKAKJNCD     PIC X(12).
      *            一般名区分（１：一般名加算）
                   07  ORCSRECEGENE-GENERIC-KBN    PIC X(01).
      *            一般名称
                   07  ORCSRECEGENE-GENERICNAME    PIC X(200).
      *            一般名名称区分（1:一般名,2：処方名称）
                   07  ORCSRECEGENE-NAME-KBN       PIC X(01).
      *            一般名単位コード
                   07  ORCSRECEGENE-GEN-TANICD     PIC 9(03).
      *            一般名単位名称
                   07  ORCSRECEGENE-GEN-TANINAME   PIC X(24).
      *            換算値
                   07  ORCSRECEGENE-KANZANCHI      PIC 9(05)V9(05).
      *            換算値の単位
                   07  ORCSRECEGENE-KNS-TANICD     PIC 9(03).
      *            換算値の単位
                   07  ORCSRECEGENE-KNS-TANINAME   PIC X(24).
      *エラーコード
           03  ORCSRECEGENE-ERRCD           PIC 9(01).
      *
