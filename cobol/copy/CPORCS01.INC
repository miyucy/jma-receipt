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
      *    負担金額算定用パラメタ　　　　　 COPY (CPORCS01.INC)
      *                                使用プログラム  (ORCS01)
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     NACL-多々納  03/04/16  自賠責・船員保険追加
      * 01.00.02     NACL-門脇    04/06/30  レイアウト修正
      ************************************************************
       01  LNK-ORCS01-REC.
      *
      *再計算処理区分
           03  LNK-S01-SAIKEISAN-KBN       PIC  X(01).
      *再計算対象伝票番号
      *    03  LNK-S01-SAIKEISAN-DENPYO    PIC  9(07).
      *高齢者（在宅総合・在宅末期）算定患者区分
           03  LNK-S01-KOUREI-ZAITAKU-KBN  PIC  X(01).
      *複数科まとめ集計フラグ（０：まとめ計算する　１：しない）
           03  LNK-S01-KAGRPFLG            PIC  X(01).
      *
           03  LNK-S01-SINKOUI.
      *診療行為内容 
             04  LNK-S01-TBL1              OCCURS   3.
      *診療行為内容 
               05  LNK-S01-TBL             OCCURS  40.
      *診療区分
                 06  LNK-S01-SRYKBN        PIC  X(02).
      *剤番号
                 06  LNK-S01-ZAIBAN        PIC  9(08).
      *診療コード
                 06  LNK-S01-SRYCD         PIC  X(09).
      *数量
                 06  LNK-S01-SURYOU        PIC  9(05)V9(03).
      *回数
                 06  LNK-S01-KAISUU        PIC  9(03).
      *点数
                 06  LNK-S01-TENSUU        PIC  9(07).
      *
           03  LNK-S01-OCC                 OCCURS  15.
      *自賠責手技点合計
             04  LNK-S01-SYUTEN            PIC  9(07).
      *自賠責診断書料金額
             04  LNK-S01-SINDAN            PIC  9(07).
      *自賠責明細書料金額
             04  LNK-S01-MEISAI            PIC  9(07).
      *自賠責療養担当手当点数
             04  LNK-S01-RYOYO             PIC  9(07).
      *船員保険（被保険者）＋通勤災害＋初診時
             04  LNK-S01-SENINFLG          PIC  X(01).
      *初診料算定フラグ（地方公費用）
             04  LNK-S01-SYOSINFLG         PIC  X(01).
      *
      *使用インデックス
           03  LNK-S01-IDX                 PIC  9(02).
      *
           03  LNK-S01-OCC2                OCCURS  15.
      *合計レコードをもつレコード識別フラグ
             04  LNK-S01-TTLARIFLG         PIC  X(01).
      *復帰コード
           03  LNK-S01-RC                  PIC  S9(9)   BINARY.
      *
