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
      *    患者入院履歴              COPY (CPPTNYUINRRK.INC)     *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  PTNYUINRRK-REC.
      *キー
           03  PTNYUINRRK-KEY.
      *医療機関ＩＤ
               05  PTNYUINRRK-HOSPID              PIC  X(24).
      *患者ＩＤ
               05  PTNYUINRRK-PTID                PIC  9(10).
      *入院履歴番号（入院１回で＋１ずつ採番）
               05  PTNYUINRRK-RRKNUM              PIC  9(03).
      *入院履歴枝番号（転科・転室・転棟時に採番）
               05  PTNYUINRRK-RRKEDANUM           PIC  9(03).
      *病棟番号
           03  PTNYUINRRK-BTUNUM                  PIC  X(02).
      *病棟名称
           03  PTNYUINRRK-BTUNAME                 PIC  X(20).
      *病室番号
           03  PTNYUINRRK-BRMNUM                  PIC  X(08).
      *入院科
           03  PTNYUINRRK-NYUINKA                 PIC  X(02).
      *保険組合せ番号
           03  PTNYUINRRK-HKNCOMBINUM             PIC  X(04).
      *入院日
           03  PTNYUINRRK-NYUINYMD                PIC  X(08).
      *退院日
           03  PTNYUINRRK-TAIINYMD                PIC  X(08).
      *特定入院料区分（１：医療機関／２：病棟／３：病室）
           03  PTNYUINRRK-TOKUTEI-KBN             PIC  X(01).
      *特定入院料
           03  PTNYUINRRK-TOKUTEI-NYUIN           PIC  X(02).
      *室料差額
           03  PTNYUINRRK-RM-SAGAKU               PIC  X(02).
      *定期請求区分
           03  PTNYUINRRK-TEIKI-SEIKYUKBN         PIC  X(01).
      *検索表示区分
           03  PTNYUINRRK-KENSAKU-DISPKBN         PIC  X(01).
      *初回継続区分
           03  PTNYUINRRK-SHOKAIKBN               PIC  X(01).
      *初回番号
           03  PTNYUINRRK-SHONUM                  PIC  9(03).
      *担当医１（主治医）
           03  PTNYUINRRK-DRCD1                   PIC  X(05).
      *担当医２
           03  PTNYUINRRK-DRCD2                   PIC  X(05).
      *担当医３
           03  PTNYUINRRK-DRCD3                   PIC  X(05).
      *状態区分（１:入院/２:転科/３:転棟/４:転室/５:他院入院／
      *          ６:自院歴）
           03  PTNYUINRRK-JTIKBN                  PIC  X(01).
      *算定病棟
           03  PTNYUINRRK-SANTEI-BTUNUM           PIC  X(02).
      *算定病室
           03  PTNYUINRRK-SANTEI-BRMNUM           PIC  X(02).
      *転入日
           03  PTNYUINRRK-TENNYUYMD               PIC  X(08).
      *転出日
           03  PTNYUINRRK-TENSTUYMD               PIC  X(08).
      *通算対象日数（他院歴で考慮する日数）
           03  PTNYUINRRK-TAISYONISSU             PIC  9(04).
      *通算日数１（９０日越え算定用）
           03  PTNYUINRRK-TUSANNISSU1             PIC  9(04).
      *通算日数２（１８０日越え算定用）
           03  PTNYUINRRK-TUSANNISSU2             PIC  9(04).
      *端末ＩＤ
           03  PTNYUINRRK-TERMID                  PIC  X(16).
      *オペーレータＩＤ
           03  PTNYUINRRK-OPID                    PIC  X(16).
      *作成年月日
           03  PTNYUINRRK-CREYMD                  PIC  X(08).
      *更新年月日
           03  PTNYUINRRK-UPYMD                   PIC  X(08).
      *更新時間
           03  PTNYUINRRK-UPHMS                   PIC  X(06).
