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
      *----------------------------------------------------------*
      *    診療行為入力項目変換パラメタ　  COPY (CPORCGI4G.INC)
      *                              (ORCGI4G で使用）
      *
      *----------------------------------------------------------*
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCGI4GAREA.
      *    ＰＧ名
           03  LNK-GI4G-PG             PIC X(06).
      *    入力出力領域
           03  LNK-GI4G-INPUTCD        PIC X(22).
      *    ＳＰＡライン
           03  LNK-GI4G-GMN-IDX        PIC 9(04).
      *    画面ライン
           03  LNK-GI4G-MAP-IDX        PIC 9(04).
      *    時間外特例医療機関
           03  LNK-GI4G-JIKANTOKU          PIC  9(01).
      *
      *    出力領域
           03  LNK-GI4G-OUTAREA.
      *        ’＿’有無
               05  LNK-GI4G-JODOU          PIC 9(01).
      *        コード変更有無（０：変更なし、１：変更あり）
               05  LNK-GI4G-NYURYOKU       PIC 9(01).
      *        入力コード
               05  LNK-GI4G-INCD           PIC X(22).
      *        入力コード桁数
               05  LNK-GI4G-INCDCNT        PIC 9(02).
      *        入力コード種別
               05  LNK-GI4G-CDSYU          PIC X(01).
      *        数量
               05  LNK-GI4G-SURYO          PIC 9(07)V9(03).
      *        回数
               05  LNK-GI4G-KAISU          PIC 9(04).
      *        分画数
               05  LNK-GI4G-BUNGSU         PIC 9(03).
      *        その入力値
               05  LNK-GI4G-MOJI1          PIC X(10).
               05  LNK-GI4G-MOJI2          PIC X(10).
               05  LNK-GI4G-MOJI3          PIC X(10).
               05  LNK-GI4G-MOJI4          PIC X(10).
      *        時間外フラグ
               05  LNK-GI4G-JIKAN          PIC 9(01).
      *
      *        数量
               05  LNK-GI4G-SURYOFLG      PIC 9(02).
               05  LNK-GI4G-SURYOCNT      PIC 9(02).
      *        回数（＊アリ）
               05  LNK-GI4G-KAISUCNT       PIC 9(02).
      *        回数（＊アリ）
               05  LNK-GI4G-KAISUFLG       PIC 9(01).
      *        分画数
               05  LNK-GI4G-BUNGSUFLG      PIC 9(01).
      *        その入力値
               05  LNK-GI4G-MCNT1          PIC 9(02).
               05  LNK-GI4G-MCNT2          PIC 9(02).
               05  LNK-GI4G-MCNT3          PIC 9(02).
               05  LNK-GI4G-MCNT4          PIC 9(02).
      *        検索画面へ
               05  LNK-GI4G-KENSAKU        PIC X(01).
      *        入院回数
               05  LNK-GI4G-NYUIN-KAISU.
                   07  LNK-GI4G-NYU-DAY    PIC 9(02)
                                           OCCURS   31.
      *
