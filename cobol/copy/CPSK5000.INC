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
      *         システム管理マスタ     (CPSK5000.INC)   *
      *         （５０００）                            *
      *         医療機関情報−入院基本情報              *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-5000-REC.
           03  SYS-5000-KEY.
      *管理コード
               05  SYS-5000-KANRICD        PIC X(04).
      *区分コード
               05  SYS-5000-KBNCD          PIC X(08).
      *有効開始年月日
               05  SYS-5000-STYUKYMD       PIC X(08).
      *有効終了年月日
               05  SYS-5000-EDYUKYMD       PIC X(08).
      *管理テーブル
           03  SYS-5000-TBL.
      *入院時食事療養
               05  SYS-5000-SHOKUJIRYOYOCD
                                           PIC X(09).
      *食事情報
               05  SYS-5000-SHOKU-INF      OCCURS  5.
                   07  SYS-5000-SHOKUCD    PIC  X(09).
                   07  SYS-5000-SHOKUKBN   PIC  X(01).
      *
      *医療機関減算情報
               05  SYS-5000-GEN-INF        OCCURS   5.
                   07  SYS-5000-GENCD      PIC  X(09).
                   07  SYS-5000-GENKBN     PIC  X(01).
      *入院料加算情報
               05  SYS-5000-KSN-INF        OCCURS  20.
                   07  SYS-5000-KSNCD      PIC  X(09).
                   07  SYS-5000-KSNKBN     PIC  X(01).
      *地域加算情報
               05  SYS-5000-CHIIKIKSN      PIC  X(09).
      *入院会計テーブル表示情報
               05  SYS-5000-GENSAN-INF     OCCURS  10.
                   07  SYS-5000-DSPCD      PIC  X(09).
      *予備
           03                              PIC  X(92).
      *端末ＩＤ
           03  SYS-5000-TERMID             PIC  X(16).
      *オペーレータＩＤ
           03  SYS-5000-OPID               PIC  X(16).
      *作成年月日
           03  SYS-5000-CREYMD             PIC  X(08).
      *更新年月日
           03  SYS-5000-UPYMD              PIC  X(08).
      *更新時間
           03  SYS-5000-UPHMS              PIC  X(06).
