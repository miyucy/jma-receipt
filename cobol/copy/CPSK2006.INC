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
      *         システム管理マスタ     (CPSK2006.INC)            *
      *         （２００６）                                     *
      *         レセプト特記事項編集情報                         *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
       01  SYS-2006-REC.
           03  SYS-2006-KEY.
      *管理コード
               05  SYS-2006-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-2006-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-2006-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-2006-EDYUKYMD    PIC  X(08).
      *保険番号
           03  SYS-2006-HKNNUM          PIC  X(03).
      *審査支払機関
           03  SYS-2006-TEISYUTUSAKI    PIC  9(01).
      *保険者番号
           03  SYS-2006-HKNJANUM        PIC  X(08).
      *老人区分
           03  SYS-2006-RJNKBN          PIC  X(01).
      *在総診区分
           03  SYS-2006-ZAITAKU         PIC  X(01).
      *特記事項
           03  SYS-2006-TOKKI           PIC  X(24).
      *摘要欄記載（未使用）
           03  SYS-2006-TEKIYO          PIC  X(100).
      *給付割合
           03  SYS-2006-KYURATE         PIC  9(03).
      *負担者番号記載区分（未使用）
           03  SYS-2006-FTNJANUMKBN     PIC  X(02).
      *レセ電：特記事項
           03  SYS-2006-RECEDEN-TOKKI   PIC  X(02).
      *レセ電：給付割合
           03  SYS-2006-RECEDEN-KYURATE PIC  9(03).
      *レセ電：公費レコード区分
           03  SYS-2006-RECEDEN-KORECKBN
                                        PIC  X(01).
      *レセ電：負担者番号記載区分（未使用）
           03  SYS-2006-RECEDEN-FTNJANUMKBN
                                        PIC  X(02).
      *レセ電：老人減免区分（未使用）
           03  SYS-2006-RECEDEN-RJNGENMENKBN
                                        PIC  X(01).
      *レセ電：摘要欄記載（未使用）
           03  SYS-2006-RECEDEN-TEKIYO  PIC  X(152).
      *予備
           03  FILLER                   PIC  X(196).
      *端末ＩＤ
           03  SYS-2006-TERMID          PIC  X(16).
      *オペレータＩＤ
           03  SYS-2006-OPID            PIC  X(16).
      *作成年月日
           03  SYS-2006-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-2006-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-2006-UPHMS           PIC  X(06).
