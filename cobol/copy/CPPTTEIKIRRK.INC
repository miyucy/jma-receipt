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
      *    患者定期請求履歴                   (CPPTTEIKIRRK.INC) *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  PTTEIKIRRK-REC.
      *診療年月
           03  PTTEIKIRRK-SRYYM            PIC  X(06).
      *患者ＩＤ
           03  PTTEIKIRRK-PTID             PIC  9(10).
      *作成区分（処理期）
      *    １〜３：各処理期／９：月末時のみ（入退院登録で指定）
           03  PTTEIKIRRK-SAKKBN           PIC  X(01).
      *保険組合せ
           03  PTTEIKIRRK-HKNCOMBINUM      PIC  9(04).
      *請求開始年月日
           03  PTTEIKIRRK-SKYSTYMD         PIC  X(08).
      *請求終了年月日
           03  PTTEIKIRRK-SKYEDYMD         PIC  X(08).
      *請求点数
           03  PTTEIKIRRK-SKYTEN           PIC  S9(09).
      *請求金額
           03  PTTEIKIRRK-SKYMONEY         PIC  S9(09).
      *端末ＩＤ
           03  PTTEIKIRRK-TERMID           PIC  X(16).
      *オペーレータＩＤ
           03  PTTEIKIRRK-OPID             PIC  X(16).
      *作成年月日
           03  PTTEIKIRRK-CREYMD           PIC  X(08).
      *更新年月日
           03  PTTEIKIRRK-UPYMD            PIC  X(08).
      *更新時間
           03  PTTEIKIRRK-UPHMS            PIC  X(06).
