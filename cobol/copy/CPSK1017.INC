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
      *         システム管理マスタ     (CPSK1017.INC)   *
      *         （１０１７）                            *
      *         患者登録機能制御情報                    *
      *-------------------------------------------------*
      *****************************************************************
      *  修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    04.03.08  生活保護受給者番号受給者番号の追加
      *****************************************************************
       01  SYS-1017-REC.
           03  SYS-1017-KEY.
      *管理コード
               05  SYS-1017-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-1017-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-1017-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-1017-EDYUKYMD    PIC  X(08).
      *人名辞書使用チェック
           03  SYS-1017-JINMEI-USE      PIC X(01).
      *カルテ病名編集
           03  SYS-1017-KARUTE-BYOMEI   PIC X(01).
      *患者登録のカルテ発行
           03  SYS-1017-KARUTE-HAKKO    PIC X(01).
      *自費保険の補助区分
           03  SYS-1017-JIHIHKN-TAX     PIC X(01).
      *生活保護受給者番号
           03  SYS-1017-SEIHO-JKYSNUM   PIC X(01).
      *予備
           03  FILLER                   PIC X(495).
      *端末ＩＤ
           03  SYS-1017-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-1017-OPID            PIC  X(16).
      *作成年月日
           03  SYS-1017-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-1017-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-1017-UPHMS           PIC  X(06).
