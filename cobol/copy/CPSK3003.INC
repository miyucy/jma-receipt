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
      *         システム管理マスタ     (CPSK3003.INC)   *
      *         （３００３）                            *
      *         県単独事業情報コード                    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-3003-REC.
           03  SYS-3003-KEY.
      *管理コード
               05  SYS-3003-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-3003-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-3003-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-3003-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-3003-TBL.
      *ＫＥＹ
               05  SYS-3003-TBL-KEY     PIC  X(08).
      *ＪＯＢＩＤ
               05  SYS-3003-JOBID       PIC  9(07).
      *グループ
               05  SYS-3003-TBL-GROUP   PIC  X(14).
      *予備
           03                           PIC  X(474).
      *端末ＩＤ
           03  SYS-3003-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-3003-OPID            PIC  X(16).
      *作成年月日
           03  SYS-3003-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-3003-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-3003-UPHMS           PIC  X(06).
