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
      *         システム管理マスタ     (CPSK5004.INC)   *
      *         （５０１０）                            *
      *         入院請求管理マスタ                      *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-5010-REC.
           03  SYS-5010-KEY.
      *管理コード
               05  SYS-5010-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-5010-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-5010-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-5010-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-5010-TBL.
      *１期請求日
               05  SYS-5010-SEIKYU-DAY1 PIC  9(02).
      *２期請求日
               05  SYS-5010-SEIKYU-DAY2 PIC  9(02).
      *３期請求日
               05  SYS-5010-SEIKYU-DAY3 PIC  9(02).
      *再請求区分（１：赤伝処理　２：訂正更新）
               05  SYS-5010-RESEIKYUKBN PIC  X(01).
      *予備
           03                           PIC  X(497).
      *端末ＩＤ
           03  SYS-5010-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-5010-OPID            PIC  X(16).
      *作成年月日
           03  SYS-5010-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-5010-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-5010-UPHMS           PIC  X(06).