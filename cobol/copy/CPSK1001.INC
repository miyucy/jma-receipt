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
      *         システム管理マスタ     (CPSK1001.INC)   *
      *         （１００１）                            *
      *         医療機関情報−基本情報                  *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01.06.18  院外処方せん発行フラグ
      *                                     前回処方表示フラグ　　　追加
      *  01.00.02    NACL-森脇    02.08.16  薬剤情報発行フラグ追加
      ************************************************************
       01  SYS-1001-REC.
           03  SYS-1001-KEY.
      *管理コード
               05  SYS-1001-KANRICD     PIC  X(04).
      *区分コード
               05  SYS-1001-KBNCD       PIC  X(08).
      *有効開始年月日
               05  SYS-1001-STYUKYMD    PIC  X(08).
      *有効終了年月日
               05  SYS-1001-EDYUKYMD    PIC  X(08).
      *管理テーブル
           03  SYS-1001-TBL.
      *県番号
               05  SYS-1001-PREFNUM     PIC  9(02).
      *点数表区分
               05  SYS-1001-TENHYOKBN   PIC  9(01).
      *医療機関コード
               05  SYS-1001-HOSPCD      PIC  9(07).
      *医療機関種別
               05  SYS-1001-HOSPSBT     PIC  9(01).
      *医療機関ＩＤ
               05  SYS-1001-HOSPID      PIC  X(24).
      *医療機関名称
               05  SYS-1001-HOSPNAME    PIC  X(120).
      *開設者名
               05  SYS-1001-KAISETUNAME PIC  X(120).
      *管理者名
               05  SYS-1001-KANRINAME   PIC  X(80).
      *病床数
               05  SYS-1001-BEDSU       PIC  9(04).
      *老人支払区分
               05  SYS-1001-ROUPAYKBN   PIC  X(01).
      *旧総合病院
               05  SYS-1001-HOSPSBT1    PIC  9(01).
      *医療機関コード
               05  SYS-1001-HOSPCDN     PIC  X(40).
      *院外処方区分
               05  SYS-1001-SYOHOKBN    PIC  X(01).
      *請求書発行フラグ
               05  SYS-1001-SKYPRTFLG   PIC  X(01).
      *----(01.00.01) LINE ADD START ----------------------------------
      *院外処方せん発行フラグ
               05  SYS-1001-SYOHOPRTFLG      PIC  X(01).
      *前回処方表示フラグ
               05  SYS-1001-ZENSYOHOFLG      PIC  X(01).
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
      *薬剤情報発行フラグ
               05  SYS-1001-YAKUJYOPRTFLG    PIC  X(01).
      *予備
           03                           PIC  X(94).
      *----(01.00.02) LINE ADD END   ----------------------------------
      *端末ＩＤ
           03  SYS-1001-TERMID          PIC  X(16).
      *オペーレータＩＤ
           03  SYS-1001-OPID            PIC  X(16).
      *作成年月日
           03  SYS-1001-CREYMD          PIC  X(08).
      *更新年月日
           03  SYS-1001-UPYMD           PIC  X(08).
      *更新時間
           03  SYS-1001-UPHMS           PIC  X(06).
