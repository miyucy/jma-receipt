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
      *    レセプト明細書     COPY (CPRCF041.INC)                *
      *    (レセプト電算処理システムのレコード並び替え用コピー句 *      
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    02.09.13  日数のテーブルを変更
      *  01.00.02    NACL-藤原    03/03/12  補助区分の追加
      *  01.00.03    NACL-門脇    03.03.03  剤番号桁修正
      ************************************************************
      *01  RECE041-REC.
           03  RECE041-KEY.
      *医療機関ＩＤ
               05  RECE041-HOSPID          PIC  X(24).
      *診療年月
               05  RECE041-SRYYM           PIC  9(06).
      *入外区分
               05  RECE041-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE041-PTID            PIC  9(10).
      *レセプト科
               05  RECE041-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE041-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE041-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE041-HKNJANUM        PIC  X(08).
      *補助区分
               05  RECE041-HOJOKBN         PIC  X(01).
      *適用開始年月日
               05  RECE041-TEKSTYMD        PIC  X(08). 
      *診療区分
               05  RECE041-SRYKBN          PIC  X(02).
      *剤番号
               05  RECE041-ZAINUM          PIC  9(08).
      *公費分離区分
           03  RECE041-KOHBUNRI            PIC  9(01).
      *患者番号
           03  RECE041-PTNUM               PIC  X(20).
      *診療科
           03  RECE041-SRYKA               PIC  X(02).
      *保険組合せ番号
           03  RECE041-HKNCOMBI            PIC  9(04).
      *自保区分
           03  RECE041-JIHOKBN             PIC  X(01).
      *剤点数
           03  RECE041-ZAITEN              PIC  9(08).
      *診療コード計
           03  RECE041-SRYCDTOTAL          PIC  9(14).
      *数量計
           03  RECE041-SURYOUTOTAL         PIC  9(07)V9(03).
      *明細数
           03  RECE041-MEISAISU            PIC  9(04).
      *剤回数
           03  RECE041-ZAIKAISU            PIC  9(04).
      *手技点数１
           03  RECE041-SYUTEN1             PIC  9(07).
      *手技点数２
           03  RECE041-SYUTEN2             PIC  9(07).
      *薬剤点数
           03  RECE041-YKZTEN              PIC  9(07).
      *器材点数
           03  RECE041-KIZAITEN            PIC  9(07).
      *ドクターコード
           03  RECE041-DRCD                PIC  X(05).
      *剤請求フラグ
           03  RECE041-ZAIREQFLG           PIC  X(01).
      *逓減率
           03  RECE041-TEIGENRATE          PIC  X(01).
      *日数回数テーブル
           03  RECE041-DAY-AREA.
      *        診療回数テーブル（1:合計,2:１回,3:２回, 4:３回以上）
             04  RECE041-DAY-TBL           OCCURS  4.
                 05  RECE041-KAISUINF      OCCURS  31.
                     07  RECE041-KAISU     PIC  9(03).
