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
      *         点数マスタ    COPY (CPTENSUPLSU.INC)     *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  TENSUPLSU-REC.
           03  TNSP-KEY.
               05  TNSP-SRYCD           PIC  X(09).
               05  TNSP-YUKOSTYMD       PIC  X(08).
               05  TNSP-YUKOEDYMD       PIC  X(08).
      *    処方名称
           03  TNSP-SHOYUKOKETA         PIC  9(02).
           03  TNSP-SHONAME             PIC  X(200).
      *    採血料区分
           03  TNSP-SAIKETUKBN          PIC  9(01).
      *    入力チェック区分
           03  TNSP-INPCHKKBN           PIC  9(01).
      *    添付資料用薬剤分類区分
           03  TNSP-TENPUYAKKBN         PIC  X(02).
      *
           03  TNSP-TERMID              PIC  X(16).
           03  TNSP-OPID                PIC  X(16).
           03  TNSP-CREYMD              PIC  X(08).
           03  TNSP-UPYMD               PIC  X(08).
           03  TNSP-UPHMS               PIC  X(06).
      *　　主キー更新用項目
           03  TNSPUP-KEY.
               05  TNSPUP-SRYCD         PIC  X(09).
               05  TNSPUP-YUKOSTYMD     PIC  X(08).
               05  TNSPUP-YUKOEDYMD     PIC  X(08).
