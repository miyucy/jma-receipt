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
      *    レセプト明細書     COPY (CPRCF04.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.06.29  保険者番号・
      *                                     適用開始年月日の追加
      *  01.00.02    NACL-藤原    02.09.02  日数のテーブルを変更
      ************************************************************
      *01  RECE04-REC.
           03  RECE04-KEY.
      *医療機関ＩＤ
               05  RECE04-HOSPID          PIC  X(24).
      *診療年月
               05  RECE04-SRYYM           PIC  9(06).
      *入外区分
               05  RECE04-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE04-PTID            PIC  9(10).
      *レセプト科
               05  RECE04-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE04-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE04-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE04-HKNJANUM       PIC  X(08).
      *適用開始年月日
               05  RECE04-TEKSTYMD        PIC  X(08). 
      *剤番号
               05  RECE04-ZAINUM          PIC  9(05).
      *公費分離区分
           03  RECE04-KOHBUNRI            PIC  9(01).
      *診療区分
           03  RECE04-SRYKBN              PIC  X(02).
      *患者番号
           03  RECE04-PTNUM               PIC  X(20).
      *診療科
           03  RECE04-SRYKA               PIC  X(02).
      *保険組合せ番号
           03  RECE04-HKNCOMBI            PIC  9(04).
      *自保区分
           03  RECE04-JIHOKBN             PIC  X(01).
      *剤点数
           03  RECE04-ZAITEN              PIC  9(08).
      *診療コード計
           03  RECE04-SRYCDTOTAL          PIC  9(14).
      *数量計
           03  RECE04-SURYOUTOTAL         PIC  9(07)V9(03).
      *明細数
           03  RECE04-MEISAISU            PIC  9(04).
      *剤回数
           03  RECE04-ZAIKAISU            PIC  9(04).
      *手技点数１
           03  RECE04-SYUTEN1             PIC  9(07).
      *手技点数２
           03  RECE04-SYUTEN2             PIC  9(07).
      *薬剤点数
           03  RECE04-YKZTEN              PIC  9(07).
      *器材点数
           03  RECE04-KIZAITEN            PIC  9(07).
      *ドクターコード
           03  RECE04-DRCD                PIC  X(05).
      *剤請求フラグ
           03  RECE04-ZAIREQFLG           PIC  X(01).
      *逓減率
           03  RECE04-TEIGENRATE          PIC  X(01).
      *コメントコードフラグ
           03  RECE04-COMCDFLG            PIC  X(01).
      *日数回数テーブル
           03  RECE04-DAY-AREA.
      *        診療回数テーブル（1:合計,2:１回,3:２回, 4:３回以上）
             04  RECE04-DAY-TBL           OCCURS  4.
                 05  RECE04-KAISUINF      OCCURS  31.
                     07  RECE04-KAISU     PIC  9(03).
