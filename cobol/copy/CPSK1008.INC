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
      *         システム管理マスタ     (CPSK1008.INC)   *
      *         （１００８）                            *
      *         チェック機能制御情報                    *
      *-------------------------------------------------*
      *****************************************************************
      *  修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-多々納  02/10/10  外来管理加算チェック追加
      *  01.00.02    NACL-多々納  03/10/16  育児栄養加算自動算定から
      *                                     外来カーソル移動追加
      *****************************************************************
       01  SYS-1008-REC.
           03  SYS-1008-KEY.
      *管理コード
               05  SYS-1008-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-1008-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-1008-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-1008-EDYUKYMD    PIC  X(08).
      *相互作用チェック期間
           03  SYS-1008-INTERACT-KIKAN  PIC 9(02).
      *外来管理加算チェック
           03  SYS-1008-GAIKANRIKBN-CHK PIC X(01).
      *育児栄養加算自動算定
           03  SYS-1008-IKUJIEIYO-FLG   PIC X(01).
      *育児栄養加算自動算定科
           03  SYS-1008-IKUJIEIYO-SRYKA PIC X(02).
      *予備
           03  FILLER                   PIC X(04).
      *外来カーソル移動
           03  SYS-1008-GAI-CURSOR-SET-1   PIC X(01).
      *入院初診料自動発生
           03  SYS-1008-NYU-SYOSIN      PIC X(01).
      *予備
      *****03  FILLER                   PIC X(489).
           03  FILLER                   PIC X(488).
      *端末ＩＤ
           03  SYS-1008-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-1008-OPID            PIC  X(16).
      *作成年月日
           03  SYS-1008-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-1008-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-1008-UPHMS           PIC  X(06).
