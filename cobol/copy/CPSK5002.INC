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
      *         システム管理マスタ     (CPSK5002.INC)   *
      *         （５００２）                            *
      *         病室マスタ                              *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-5002-REC.
           03  SYS-5002-KEY.
      *管理コード
               05  SYS-5002-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-5002-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-5002-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-5002-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-5002-TBL.
      *病室番号
               05  SYS-5002-BRM-NUM
                                        PIC  X(08).
      *病室種別
               05  SYS-5002-BRM-SBT
                                        PIC  X(02).
      *特定入院料
               05  SYS-5002-BRM-TOKTEI-NYUIN
                                        PIC  X(02).
      *収容人数
               05  SYS-5002-BRM-NINZU   PIC  9(02).
      *室料差額
               05  SYS-5002-BRM-SAGAKU  PIC  X(02).
      *性別特定
               05  SYS-5002-BRM-SEX     PIC  X(01).
      *内線番号
               05  SYS-5002-BRM-NAITEL
                                        PIC  X(05).
      *診療科
               05  SYS-5002-BRM-KA      PIC  X(02).
      *
      *新生児入院医療管理加算
               05  SYS-5002-SINSEIJI.
                   07  SYS-5002-SINSEIJI-CD      PIC X(09).
                   07  SYS-5002-SINSEIJI-KBN     PIC X(01).
      *診療所療養病床療養環境加算
               05  SYS-5002-SNR-RYOYO            OCCURS 2.
                   07  SYS-5002-SNR-RYOYO-CD     PIC X(09).
                   07  SYS-5002-SNR-RYOYO-KBN    PIC X(01).
      *放射線治療病室管理加算
               05  SYS-5002-HOSYASEN.
                   07  SYS-5002-HOSYASEN-CD      PIC X(09).
                   07  SYS-5002-HOSYASEN-KBN     PIC X(01).
      *療養環境加算
               05  SYS-5002-RYOYO.
                   07  SYS-5002-RYOYO-CD         PIC X(09).
                   07  SYS-5002-RYOYO-KBN        PIC X(01).
      *予備
           03                           PIC  X(426).
      *端末ＩＤ
           03  SYS-5002-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-5002-OPID            PIC  X(16).
      *作成年月日
           03  SYS-5002-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-5002-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-5002-UPHMS           PIC  X(06).
