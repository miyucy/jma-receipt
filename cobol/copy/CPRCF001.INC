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
      *    レセプト明細書・医療費請求書   COPY (CPRCF001.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.06.27  継続区分の追加
      *  01.00.02    MCC-藤原     01.06.29  適用終了年月日の追加
      *  01.01.03    MCC-藤原     02.02.01  補足区分の追加
      *  01.01.04    MCC-藤原     02.02.13  ｋｅｙを保険ＩＤから
      *                                     保険番号に変更
      *                                     本人家族区分の追加
      *                                     保険組合せを３から１０に変更
      *  01.01.05    MCC-藤原     02.03.13  適用年月日を複数個に変更
      *  01.01.06    MCC-藤原     02.05.24  保険変更時の未訂正フラグの追加
      *  01.01.07    NACL-藤原    03.02.12  補助区分の追加
      *  01.01.08    NACL-藤原    03.03.03  診療科数１０から２０へ変更
      *  01.01.09    NACL-藤原    03.03.11  レセプト種別不明情報の追加
      ************************************************************
      *01  RECE01-REC.
           03  RECE01-KEY.
      *医療機関ＩＤ
               05  RECE01-HOSPID          PIC  X(24).
      *診療年月
               05  RECE01-SRYYM           PIC  9(06).
      *入外区分
               05  RECE01-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE01-PTID            PIC  9(10).
      *レセプト診療科
               05  RECE01-RECEKA          PIC  X(02).
      *主保険保険番号
               05  RECE01-HKNNUM          PIC  X(03).
      *公費ＩＤ
               05  RECE01-KOHID           PIC  9(10).
      *保険者番号        
               05  RECE01-HKNJANUM        PIC  X(08).
      *本人家族区分
               05  RECE01-HONKZKKBN       PIC  X(01).
      *補助区分
               05  RECE01-HOJOKBN         PIC  X(01).
      *適用開始年月日
               05  RECE01-TEKSTYMD        PIC  X(08). 
      *公費領域
           03 RECE01-KOHI-AREA.
               05  RECE01-KOHI-TBL        OCCURS  4.
      *    公費ＩＤ
                   07  RECE01-KOHID-O     PIC  9(10).
      *    公費保険番号
                   07  RECE01-KOHHKNNUM-O PIC  X(03).
      *   公費支払区分
                   07 RECE01-KOHPAYKBN-O  PIC  X(02).
      *主保険ＩＤ
           03  RECE01-HKNID               PIC  9(10).
      *保険組合せ番号領域
           03 RECE01-HKNCOMBI-AREA.
               05  RECE01-HKNCOMBI-TBL    OCCURS  10.
                   07  RECE01-HKNCOMBI-O  PIC  9(04).
      *診療科情報
           03 RECE01-SRYKAINF.
               05  RECE01-SRYKA           PIC  X(02)  OCCURS  20.
      *適用年月日領域
           03 RECE01-TEKYMD-AREA.
               05  RECE01-TEKYMD-TBL      OCCURS  10.
      *適用開始年月日
                   07  RECE01-TEKSTYMDX   PIC  X(08). 
      *適用終了年月日
                   07  RECE01-TEKEDYMDX   PIC  X(08). 
      *継続区分
           03  RECE01-CONTKBN             PIC  X(01).
      *レセプト記載外公費番号
           03  RECE01-ETC-HKNNUM          PIC  X(03).
      *未訂正区分
           03  RECE01-TEISEIKBN           PIC  X(01).
      *レセプト種別不明エラー情報
           03  RECE01-ERR-AREA.
               05  RECE01-ERR-ERRKBN      PIC 9(01).
               05  RECE01-ERR-DAY         PIC 9(02).
               05  RECE01-ERR-HKNCOMBINUM PIC 9(04).
               05  RECE01-ERR-TEKSTYMD    PIC 9(08).
               05  RECE01-ERR-TEKEDYMD    PIC 9(08).
      *予備
           03  FILLER                     PIC  X(20).
