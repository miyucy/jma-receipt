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
      *-------------------------------------------------*
      *         システム管理マスタ     (CPSK1004.INC)   *
      *         （１００４）                            *
      *         医療機関情報−広告情報                  *
      *-------------------------------------------------*
       01  SYS-1004-REC.
           03  SYS-1004-KEY.
      *管理コード
               05  SYS-1004-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-1004-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-1004-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-1004-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-1004-TBL.
      *電子メールアドレス
               05  SYS-1004-E-MAIL      PIC  X(100).
      *ホームページアドレス
               05  SYS-1004-URL         PIC  X(100).
      *予備
           03                           PIC  X(300).
      *端末ＩＤ
           03  SYS-1004-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-1004-OPID            PIC  X(16).
      *作成年月日
           03  SYS-1004-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-1004-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-1004-UPHMS           PIC  X(06).
