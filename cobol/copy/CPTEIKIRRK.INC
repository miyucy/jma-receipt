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
      *    定期請求履歴                       (CPTEIKIRRK.INC)   *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  TEIKIRRK-REC.
      *診療年月
           03  TEIKIRRK-SRYYM              PIC  X(06).
      *作成区分（処理期）
      *    １〜３：各処理期／９：月末時のみ（入退院登録で指定）
           03  TEIKIRRK-SAKKBN             PIC  X(01).
      *請求開始年月日
           03  TEIKIRRK-SKYSTYMD           PIC  X(08).
      *請求終了年月日
           03  TEIKIRRK-SKYEDYMD           PIC  X(08).
      *請求点数（合計）
           03  TEIKIRRK-SKYTEN             PIC  S9(09).
      *請求金額（合計）
           03  TEIKIRRK-SKYMONEY           PIC  S9(09).
      *再請求区分
           03  TEIKIRRK-SAISKYKBN          PIC  X(1).
      *端末ＩＤ
           03  TEIKIRRK-TERMID             PIC  X(16).
      *オペーレータＩＤ
           03  TEIKIRRK-OPID               PIC  X(16).
      *作成年月日
           03  TEIKIRRK-CREYMD             PIC  X(08).
      *更新年月日
           03  TEIKIRRK-UPYMD              PIC  X(08).
      *更新時間
           03  TEIKIRRK-UPHMS              PIC  X(06).
