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
      *         システム管理マスタ     (CPSK4001.INC)            *
      *         （４００１）                                     *
      *         労災医療機関情報                                 *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    02.09.17  加算率追加
      ************************************************************
       01  SYS-4001-REC.
           03  SYS-4001-KEY.
      *管理コード
               05  SYS-4001-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-4001-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-4001-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-4001-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-4001-TBL.
      *労災指定医療機関区分
               05  SYS-4001-RSIIRYOKBN  PIC  X(1).
      *指定医療機関コード
               05  SYS-4001-RSIIRYOCDN  PIC  X(80).
      *点数単価区分
               05  SYS-4001-TENKBN      PIC  X(1).
      *加算率
               05  SYS-4001-KSNRATE     PIC  9(02).
      *予備
           03                           PIC  X(416).
      *端末ＩＤ
           03  SYS-4001-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-4001-OPID            PIC  X(16).
      *作成年月日
           03  SYS-4001-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-4001-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-4001-UPHMS           PIC  X(06).
