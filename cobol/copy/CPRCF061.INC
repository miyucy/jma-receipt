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
      *    レセプト明細書・医療費請求書（入院） COPY (CPRCF061.INC)      *
      ********************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    03.03.03  診療科数１０から２０へ変更
      *  01.00.02    NACL-藤原    03.03.11  レセプト種別不明情報の追加
      ********************************************************************
      *01  RECE61-REC.
           03  RECE61-KEY.
      *医療機関ＩＤ
               05  RECE61-HOSPID          PIC  X(24).
      *診療年月
               05  RECE61-SRYYM           PIC  9(06).
      *入外区分
               05  RECE61-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE61-PTID            PIC  9(10).
      *レセプト診療科
               05  RECE61-RECEKA          PIC  X(02).
      *主保険保険番号
               05  RECE61-HKNNUM          PIC  X(03).
      *公費ＩＤ
               05  RECE61-KOHID           PIC  9(10).
      *保険者番号        
               05  RECE61-HKNJANUM        PIC  X(08).
      *本人家族区分
               05  RECE61-HONKZKKBN       PIC  X(01).
      *補助区分
               05  RECE61-HOJOKBN         PIC  X(01).
      *適用開始年月日
               05  RECE61-TEKSTYMD        PIC  X(08). 
      *公費領域
           03 RECE61-KOHI-AREA.
               05  RECE61-KOHI-TBL        OCCURS  4.
      *    公費ＩＤ
                   07  RECE61-KOHID-O     PIC  9(10).
      *    公費保険番号
                   07  RECE61-KOHHKNNUM-O PIC  X(03).
      *   公費支払区分
                   07 RECE61-KOHPAYKBN-O  PIC  X(02).
      *主保険ＩＤ
           03  RECE61-HKNID               PIC  9(10).
      *保険組合せ番号領域
           03 RECE61-HKNCOMBI-AREA.
               05  RECE61-HKNCOMBI-TBL    OCCURS  10.
                   07  RECE61-HKNCOMBI-O  PIC  9(04).
      *診療科情報
           03 RECE61-SRYKAINF.
               05  RECE61-SRYKA           PIC  X(02)  OCCURS  20.
      *適用年月日領域
           03 RECE61-TEKYMD-AREA.
               05  RECE61-TEKYMD-TBL      OCCURS  10.
      *適用開始年月日
                   07  RECE61-TEKSTYMDX   PIC  X(08). 
      *適用終了年月日
                   07  RECE61-TEKEDYMDX   PIC  X(08). 
      *継続区分
           03  RECE61-CONTKBN             PIC  X(01).
      *レセプト記載外公費番号
           03  RECE61-ETC-HKNNUM          PIC  X(03).
      *未訂正区分
           03  RECE61-TEISEIKBN           PIC  X(01).
      *レセプト種別不明エラー情報
           03  RECE61-ERR-AREA.
               05  RECE61-ERR-ERRKBN      PIC 9(01).
               05  RECE61-ERR-DAY         PIC 9(02).
               05  RECE61-ERR-HKNCOMBINUM PIC 9(04).
               05  RECE61-ERR-TEKSTYMD    PIC 9(08).
               05  RECE61-ERR-TEKEDYMD    PIC 9(08).
      *予備
           03  FILLER                      PIC  X(20).
      
