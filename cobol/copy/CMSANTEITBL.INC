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
      *----------------------------------------------------------------*
      *    算定履歴保険番号毎のコードテーブル COPY (CMSANTEITBL.INC)
      *----------------------------------------------------------------*
      *****************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-多々納  02/08/09  療養の給付請求書取扱料追加
      *****************************************************************
      *
      *    算定履歴保険番号毎のコード
       01  TBL-SANTEI-AREA.
      *    理学療法（個別）１０単位チェックテーブル
           03  FILLER              PIC X(12)   VALUE   "KR 180022110".
           03  FILLER              PIC X(12)   VALUE   "KR 180022310".
           03  FILLER              PIC X(12)   VALUE   "KR 180022510".
           03  FILLER              PIC X(12)   VALUE   "KR 180022710".
      *    作業療法（個別）
           03  FILLER              PIC X(12)   VALUE   "KS 180023610".
           03  FILLER              PIC X(12)   VALUE   "KS 180023810".
      *    言語療法（個別）
           03  FILLER              PIC X(12)   VALUE   "KG 180024810".
           03  FILLER              PIC X(12)   VALUE   "KG 180025010".
      *    理学療法（個別）（老人）
           03  FILLER              PIC X(12)   VALUE   "KR 180706810".
           03  FILLER              PIC X(12)   VALUE   "KR 180707010".
           03  FILLER              PIC X(12)   VALUE   "KR 180707210".
           03  FILLER              PIC X(12)   VALUE   "KR 180707410".
      *    作業療法（個別）（老人）
           03  FILLER              PIC X(12)   VALUE   "KS 180708110".
           03  FILLER              PIC X(12)   VALUE   "KS 180708310".
      *
      *    理学療法（集団）
           03  FILLER              PIC X(12)   VALUE   "SR 180022210".
           03  FILLER              PIC X(12)   VALUE   "SR 180022410".
           03  FILLER              PIC X(12)   VALUE   "SR 180022610".
           03  FILLER              PIC X(12)   VALUE   "SR 180022810".
      *    作業療法（集団）
           03  FILLER              PIC X(12)   VALUE   "SS 180023710".
           03  FILLER              PIC X(12)   VALUE   "SS 180023910".
      *    言語療法（集団）
           03  FILLER              PIC X(12)   VALUE   "SG 180024910".
           03  FILLER              PIC X(12)   VALUE   "SG 180025110".
      *    理学療法（集団）（老人）
           03  FILLER              PIC X(12)   VALUE   "SR 180706910".
           03  FILLER              PIC X(12)   VALUE   "SR 180707110".
           03  FILLER              PIC X(12)   VALUE   "SR 180707310".
           03  FILLER              PIC X(12)   VALUE   "SR 180707510".
      *    作業療法（集団）（老人）
           03  FILLER              PIC X(12)   VALUE   "SS 180708210".
           03  FILLER              PIC X(12)   VALUE   "SS 180708410".
      *
      *    消炎鎮痛処置
      *    マッサージ等の手技による
           03  FILLER              PIC X(12)   VALUE   " M 140029610".
      *    器具等による
           03  FILLER              PIC X(12)   VALUE   " K 140040310".
      *    湿布処置１
           03  FILLER              PIC X(12)   VALUE   " P 140002210".
      *    湿布処置２
           03  FILLER              PIC X(12)   VALUE   " P 140002310".
      *
      *    労災の救急医療管理加算
           03  FILLER              PIC X(12)   VALUE   "   101110020".
           03  FILLER              PIC X(12)   VALUE   "   101110030".
      *
      *    労災の療養の給付請求書取扱料
           03  FILLER              PIC X(12)   VALUE   "   101130020".
      *
      *    労災の手指の創傷に係る機能回復指導加算
           03  FILLER              PIC X(12)   VALUE   "   101500080".
      *
       01  TBL-SANTEI-AREA-R       REDEFINES   TBL-SANTEI-AREA.
           03  TBL-SANTEI-OCC      OCCURS   36  INDEXED   TBL-SAN.
      *        リハビリ（K:個別、S:集団）
               05  TBL-RIGAKU-RYO      PIC X(01).
      *        リハビリ（R:理学,S:作業, G:言語)
      *        消炎鎮痛処置(M:マッサージ等,K:器具等、P:湿布)
               05  TBL-RIGAKU-KBN      PIC X(01).
      *        予備
               05  FILLER              PIC X(01).
      *
               05  TBL-SANTEI-SRYCD    PIC X(09).
      *
      *    保険毎算定あり
       01  FLG-HKNSAN                  PIC 9(01).
      *    リハビリ有無
       01  FLG-HKN-SANTEI              PIC 9(01).
      *
