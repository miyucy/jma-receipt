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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
      *---------------------------------------------------*
      *    算定履歴変更パラメタ                          *
      *                         COPY  (CPORCSSANTEI.INC) *
      *
      *---------------------------------------------------*
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-多々納  02/12/05  初診料算定日追加
      *****************************************************************
       01  ORCSSANTEIAREA.
      *
      *処理区分（１：追加、更新、３：削除）
           03  SSANTEI-SYORI             PIC  X(01).
      *処理ＰＧ
           03  SSANTEI-PG                PIC  X(03).
      *対象コード
           03  SSANTEI-SRYCD             PIC  X(09).
      *診療年月日
           03  SSANTEI-SRYYMD            PIC  X(08).
      *初回年月日（必要な時のみ）
           03  SSANTEI-SYOKAIYMD         PIC  X(08).
      *患者ＩＤ
           03  SSANTEI-PTID              PIC  9(10).
      *算定回数
           03  SSANTEI-KAISU             PIC  9(08).
      *初診料算定日（新規でＫ０３の時のみ）
           03  SSANTEI-SYOYMD            PIC  X(08).
      *
      *    一括更新の時（Ｊ０２）
           03  SSANTEI-IKKATU.
      *入外区分
               05  SSANTEI-NYUGAIKBN       PIC  X(01).
      *診療科
               05  SSANTEI-SRYKA           PIC  X(02).
      *当月初回算定日
               05  SSANTEI-MSANTEID        PIC  X(02).
      *当月算定回数
               05  SSANTEI-MSANTEICNT      PIC  9(03).
      *変更診療回数テーブル
               05  SSANTEI-DAY-AREA.
                   07  SSANTEI-DAY         PIC  9(03)
                                           OCCURS   31.
      *変更前診療回数テーブル
               05  SSANTEI-MAE-DAY-AREA.
                   07  SSANTEI-MAE-DAY     PIC  9(03)
                                           OCCURS   31.
      *
