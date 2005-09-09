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
      *         システム管理マスタ     (CPSK1039.INC)   *
      *         （１０３８）                            *
      *         収納機能情報                            *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-1039-REC.
           03  SYS-1039-KEY.
      *管理コード
               05  SYS-1039-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-1039-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-1039-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-1039-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-1039-TBL.
      *入金管理区分
               05  SYS-1039-NYKNKNRKBN  PIC  X(01).
      *請求書兼領収書発行区分（外来）
               05  SYS-1039-SKYPRTGKBN  PIC  X(01).
      *請求書兼領収書発行区分（入院）
               05  SYS-1039-SKYPRTNKBN  PIC  X(01).
      *統計時間
               05  SYS-1039-STIME.
                   07  SYS-1039-STIME-HH   PIC  X(02).
                   07  SYS-1039-STIME-MM   PIC  X(02).
      *仮締時間
               05  SYS-1039-KARITIME.
                   07  SYS-1039-KARITIME-OCC1          OCCURS  2.
                       09  SYS-1039-KARIDAY    PIC X   OCCURS  7.
                       09  SYS-1039-KARITIME-OCC2      OCCURS  2.
                           11  SYS-1039-KARISTTIME.
                               13  SYS-1039-KARIST-HH  PIC X(02).
                               13  SYS-1039-KARIST-MM  PIC X(02).
                           11  SYS-1039-KARIEDTIME.
                               13  SYS-1039-KARIED-HH  PIC X(02).
                               13  SYS-1039-KARIED-MM  PIC X(02).
      *予備
               05                       PIC  X(447).
      *端末ＩＤ
           03  SYS-1039-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-1039-OPID            PIC  X(16).
      *作成年月日
           03  SYS-1039-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-1039-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-1039-UPHMS           PIC  X(06).
