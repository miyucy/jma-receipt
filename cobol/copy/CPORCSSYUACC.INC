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
      *    主情報アクセス用パラメタ      COPY (CPORCSSYUACC.INC)
      *                                  使用プログラム (ORCSSYUACC)
      *    設定項目
      *      処理区分
      *      診療年月
      *      入外区分
      *      患者ＩＤ
      *      入力科
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCSSYUACCAREA.
      *
           03  LNK-SYUACC-IN.
      *        処理区分
      *        1:当月の情報取得
               05  LNK-SYUACC-I-KBN       PIC X(02).
      *        診療年月
               05  LNK-SYUACC-I-SRYYM     PIC 9(06).
      *        入外区分
               05  LNK-SYUACC-I-NYUGAIKBN PIC X(01).
      *        患者ＩＤ
               05  LNK-SYUACC-I-PTID      PIC 9(10).
      *
           03  LNK-SYUACC-IO.
      *        診療科(手入力情報)
               05  LNK-SYUACC-IO-H-SRYKA   PIC X(02).
      *        レセプト情報
               05  LNK-SYUACC-IO-OCC               OCCURS  100.
      *            入外区分
                   07  LNK-SYUACC-IO-NYUGAIKBN
                                       PIC X(01).
      *            審査支払機関
                   07  LNK-SYUACC-IO-TEISYUTUSAKI
                                       PIC 9(01).
      *            レセプト種別
                   07  LNK-SYUACC-IO-RECESYUBETU
                                       PIC X(04).
      *            保険者番号
                   07  LNK-SYUACC-IO-HKNJANUM
                                       PIC X(08).
      *            補助区分
                   07  LNK-SYUACC-IO-HOJOKBN
                                       PIC X(01).
      *            システム主科
                   07  LNK-SYUACC-IO-SYUKA-AUTO
                                       PIC X(02).
      *            手入力主科
                   07  LNK-SYUACC-IO-SYUKA-INPUT
                                       PIC X(02).
      *            主科別情報
                   07  LNK-SYUACC-IO-SRYKATBL      OCCURS  50.
      *            主科
                       09  LNK-SYUACC-IO-SRYKA
                                       PIC X(02).
      *            保険組合せ番号
                       09  LNK-SYUACC-IO-HKNCOMBI-AREA.
                           11  LNK-SYUACC-IO-HKNCOMBI
                                       PIC 9(04)   OCCURS  10.
      *            請求点数合計
                       09  LNK-SYUACC-IO-TENSU
                                       PIC S9(09).
      *            受診回数合計(入院外)
                       09  LNK-SYUACC-IO-KAISU    
                                       PIC 9(03).
      *            通算日数合計(入院)
                       09  LNK-SYUACC-IO-NISSU
                                       PIC 9(03).
      *            終了日
                       09  LNK-SYUACC-IO-EDDAY
                                       PIC 9(02).
      *
      *    復帰コード
           03  LNK-SYUACC-RC           PIC S9(9) BINARY.
