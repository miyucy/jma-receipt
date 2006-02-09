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
      *    レセプト種別編集パラメタ      COPY (CPORCSSYUBETU.INC)
      *                                  使用プログラム (ORCSSYUBETU)
      *    設定項目
      *      医療機関ＩＤ
      *      県番号
      *      患者ＩＤ
      *      診療年月
      *      入外区分
      *      年齢
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *
       01  ORCSSYUBETUAREA.
      *
           03  LNK-SYUBETU-IN.
      *        医療機関ＩＤ
               05  LNK-SYUBETU-HOSPID      PIC X(24).
      *        県番号
               05  LNK-SYUBETU-PREFNUM     PIC 9(02).
      *        診療年月
               05  LNK-SYUBETU-SRYYM       PIC 9(06).
      *        入外区分
               05  LNK-SYUBETU-NYUGAIKBN   PIC X(01).
      *        患者ＩＤ
               05  LNK-SYUBETU-PTID        PIC 9(10).
      *        生年月日
               05  LNK-SYUBETU-BIRTHDAY    PIC X(08).
      *
           03  LNK-SYUBETU-OT.
      *        レセプト情報
               05  LNK-SYUBETU-OCC         OCCURS  100.
      *            審査支払機関
                   07  LNK-SYUBETU-TEISYUTUSAKI
                                       PIC 9(01).
      *            レセプト種別
                   07  LNK-SYUBETU-RECESYUBETU
                                       PIC X(04).
      *            保険者番号
                   07  LNK-SYUBETU-HKNJANUM
                                       PIC X(08).
      *            保険組合せ番号
                   07  LNK-SYUBETU-HKNCOMBI-AREA.
                       09  LNK-SYUBETU-HKNCOMBI
                                       PIC 9(04)   OCCURS  10.
      *
      *    復帰コード  １：設定項目エラー
      *                ２：診療年月エラー（平成１４年９月以前）
      *                ３：年齢取得エラー
      *                ９：対象レセプトなし
           03  LNK-SYUBETU-RC              PIC 9(01).
