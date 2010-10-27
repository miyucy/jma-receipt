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
      *         システム管理マスタ     (CPSK0044.INC)   *
      *         （００４４）                            *
      *         月次統計パラメータ情報（標準提供）      *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-0044-REC.
           03  SYS-0044-KEY.
               05  SYS-0044-HOSPNUM     PIC 9(2).
      *管理コード
               05  SYS-0044-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-0044-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-0044-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-0044-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-0044-TBL.
      *帳票名
               05  SYS-0044-HCNAME      PIC  X(160).
      *プログラム名
               05  SYS-0044-PRGNAME     PIC  X(24).
      *パラメタ
               05  SYS-0044-PARA-TBL.
                   07  SYS-0044-PARA-G      OCCURS  10.
                       09  SYS-0044-PARAHYOJI
                                        PIC X(20).
                       09  SYS-0044-PARA    PIC X(10).
      *必須区分（SPACE or 1:必須2:任意）
               05  SYS-0044-HISSU-KBN   OCCURS  10
                                        PIC X(01).
      *予備
               05                       PIC  X(06).
      *端末ＩＤ
           03  SYS-0044-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-0044-OPID            PIC  X(16).
      *作成年月日
           03  SYS-0044-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-0044-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-0044-UPHMS           PIC  X(06).
      *　　主キー更新用項目
           03  SYSUPD-0044-KEY.
               05  SYSUP-0044-HOSPNUM     PIC 9(2).
               05  SYSUP-0044-KANRICD     PIC X(04).
               05  SYSUP-0044-KBNCD       PIC X(08).
               05  SYSUP-0044-STYUKYMD    PIC X(08).
               05  SYSUP-0044-EDYUKYMD    PIC X(08).
