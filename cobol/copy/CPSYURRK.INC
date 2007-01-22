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
      *    収納履歴マスタ  COPY (CPSYURRK.INC)                   *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  SYURRK-REC.
           03  SYURRK-KEY.
      *医療機関ＩＤ
               05  SYURRK-HOSPID          PIC  X(24).
      *患者ＩＤ
               05  SYURRK-PTID            PIC  9(10).
      *入外区分
               05  SYURRK-NYUGAIKBN       PIC  X(01).
      *伝票番号
               05  SYURRK-DENPNUM         PIC S9(9)   BINARY.
      *状態区分
               05  SYURRK-JOUTAIKBN       PIC  X(01).
      *収納履歴番号
               05  SYURRK-SYURRKNUM       PIC S9(9)   BINARY.
      *収納履歴枝番号
               05  SYURRK-SYUEDANUM       PIC S9(9)   BINARY.
      *診療科
           03  SYURRK-SRYKA               PIC  X(02).
      *保険組合せ番号
           03  SYURRK-HKNCOMBINUM         PIC  X(04).
      *保険点数
           03  SYURRK-TOTAL-HKNTEN        PIC S9(9)   BINARY.
      *保険適用金額
           03  SYURRK-HKNTEKMONEY         PIC S9(9)   BINARY.
      *老人一部負担金
           03  SYURRK-RJN-FTN             PIC S9(9)   BINARY.
      *公費一部負担金
           03  SYURRK-KOH-FTN             PIC S9(9)   BINARY.
      *労災保険−患者請求分円建て合計額
           03  SYURRK-RSI-TOTAL           PIC S9(9)   BINARY.
      *自費小計（消費税なし）
           03  SYURRK-JIHI-TOTAL          PIC S9(9)   BINARY.
      *自費小計（消費税あり）
           03  SYURRK-JIHI-TOTAL-TAX      PIC S9(9)   BINARY.
      *自費金額消費税
           03  SYURRK-JIHI-TAX            PIC S9(9)   BINARY.
      *適用外金額
           03  SYURRK-TOTAL-TGMONEY       PIC S9(9)   BINARY.
      *適用外金額（消費税あり）
           03  SYURRK-TOTAL-TGMONEY-TAX   PIC S9(9)   BINARY.
      *食事負担額（自費：自己負担合計）
           03  SYURRK-SKYMONEY-SKJ-JIHI-KEI
                                          PIC S9(9)   BINARY.
           03  SYURRK-SKYMONEY-LIFE-JIHI-KEI
                                          PIC S9(9)   BINARY.
      *室料差額
           03  SYURRK-RMSAGAKU            PIC S9(9)   BINARY.
      *食事負担額（保険：自己負担合計）
           03  SYURRK-SKYMONEY-SKJ-KEI    PIC S9(9)   BINARY.
      *入院時生活療養費負担額（保険：自己負担合計）
           03  SYURRK-SKYMONEY-LIFE-KEI   PIC S9(9)   BINARY.
      *請求金額
           03  SYURRK-SKYMONEY            PIC S9(9)   BINARY.
      *調整金
           03  SYURRK-CHOSEI              PIC S9(9)   BINARY.
      *減免金額
           03  SYURRK-DISCOUNT-MONEY      PIC S9(9)   BINARY.
      *自費
           03  SYURRK-JIHI-G.
               05  SYURRK-JIHI-OCC        OCCURS   10.
                 07  SYURRK-JIHI-TAXNASI  PIC S9(9)   BINARY.
                 07  SYURRK-JIHI-TAXARI   PIC S9(9)   BINARY.
      *端末ＩＤ
           03  SYURRK-TERMID              PIC  X(16).
      *オペーレータＩＤ
           03  SYURRK-OPID                PIC  X(16).
      *作成年月日
           03  SYURRK-CREYMD              PIC  X(08).
      *更新年月日
           03  SYURRK-UPYMD               PIC  X(08).
      *更新時間
           03  SYURRK-UPHMS               PIC  X(06).
      *
