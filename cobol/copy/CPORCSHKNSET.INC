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
      *    保険組合せ編集パラメタ　　COPY (CPORCSHKNSET.INC)
      *                            使用プログラム 
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  ORCSHKNSETAREA.
      *
      *入力
           03  ORCSHKN-IN-AREA.
      *処理区分（１：当日対象、２：全部）
               05  ORCSHKN-KBN                 PIC  X(01).
      *
      *保険組合せ一覧
           03  ORCSHKN-OUT-AREA.
      *        最大件数
               05  ORCSHKN-HKN-MAX             PIC 9(04).
      *        初期表示位置
               05  ORCSHKN-IDX                 PIC 9(04).
      *
      *        一覧画面表示
               05  ORCSHKN-GMN-HKNCOMBI-LISTG.
                   07  ORCSHKN-GMN-HKN-LIST    OCCURS  100.
      *                画面表示用
                       09  ORCSHKN-GMN-HKNCOMBINUM     PIC  X(04).
                       09  ORCSHKN-GMN-HKNCOMBIMEI     PIC  X(50).
                       09  ORCSHKN-GMN-FTNRATEMEI      PIC  X(05).
                       09  ORCSHKN-GMN-TEKSTYMD        PIC  X(09).
                       09  ORCSHKN-GMN-TEKEDYMD        PIC  X(09).
      *                内部表示
                       09  ORCSHKN-NAI-TEKSTYMD        PIC  X(08).
                       09  ORCSHKN-NAI-TEKEDYMD        PIC  X(08).
                       09  ORCSHKN-NAI-FTNRATE         PIC  9(03).
                       09  ORCSHKN-NAI-HKNID           PIC  9(10).
                       09  ORCSHKN-NAI-HKNNUM          PIC  X(03).
                       09  ORCSHKN-NAI-RSI-SISIKBN     PIC  X(01).
                       09  ORCSHKN-NAI-RSI-SHOBYOYMD   PIC  X(08).
                       09  ORCSHKN-NAI-RSI-HKNKBN      PIC  X(01).
                       09  ORCSHKN-NAI-KOH1HKNNUM      PIC  X(03).
                       09  ORCSHKN-NAI-KOH2HKNNUM      PIC  X(03).
                       09  ORCSHKN-NAI-KOH3HKNNUM      PIC  X(03).
                       09  ORCSHKN-NAI-KOH4HKNNUM      PIC  X(03).
      *エラーコード
           03  ORCSHKN-ERRCD                    PIC 9(01).
      *
