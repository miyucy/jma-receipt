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
      *         一般名マスタ  COPY (CPGENERICNAMEWK.INC)     *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  GENERICNAMEWK-REC.
           03  GENERICWK-SYORIKBN        PIC X(01).
           03  GENERICWK-KEY.
      *    薬価基準コード
               05  GENERICWK-YAKKAKJNCD  PIC  X(09).
      *    一般名有効桁
           03  GENERICWK-YUKOKETA        PIC  9(02).
      *    一般名
           03  GENERICWK-GENERICNAME     PIC  X(200).
      *    単位コード
           03  GENERICWK-TANICD          PIC  X(03).
      *    単位名称
           03  GENERICWK-TANINAME        PIC  X(24).
      *    数量換算値
           03  GENERICWK-KANZANCHI       PIC  9(05)V9(05).
      *
           03  GENERICWK-TERMID          PIC  X(16).
           03  GENERICWK-OPID            PIC  X(16).
           03  GENERICWK-CREYMD          PIC  X(08).
           03  GENERICWK-UPYMD           PIC  X(08).
           03  GENERICWK-UPHMS           PIC  X(06).
