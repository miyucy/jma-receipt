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
      *    レセプト明細書０３ COPY (CPRCF03.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.06.29  保険者番号・
      *                                     適用開始年月日の追加
      *  01.00.02    MCC-藤原     01.09.28  医療機関ＩＤの修正
      *  01.00.03    MCC-藤原     01.12.17  病名コードの桁数の修正
      *  01.00.04    MCC-藤原     02.05.14  転帰区分をＫＥＹに追加
      *  01.00.05    MCC-藤原     02.06.11  転帰日をＫＥＹに追加
      ************************************************************
      *01  RECE03-REC.
           03  RECE03-KEY.
      *医療機関ＩＤ
               05  RECE03-HOSPID          PIC  X(24).
      *診療年月
               05  RECE03-SRYYM           PIC  9(06).
      *入外区分
               05  RECE03-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE03-PTID            PIC  9(10).
      *レセプト科
               05  RECE03-RECEKA          PIC  X(02).
      *審査支払機関
               05  RECE03-TEISYUTUSAKI    PIC  9(01).
      *レセプト種別
               05  RECE03-RECESYUBETU     PIC  9(04).
      *保険者番号        
               05  RECE03-HKNJANUM        PIC  X(08).
      *適用開始年月日
               05  RECE03-TEKSTYMD        PIC  X(08). 
      *診療開始日
               05  RECE03-SRYYMD          PIC X(08).
      *転帰区分
               05  RECE03-TENKIKBN        PIC X(01).
      *転帰日
               05  RECE03-TENKIYMD        PIC X(08).
      *病名
               05  RECE03-BYOMEI          PIC X(160).
      *主病名フラグ
               05  RECE03-SYUBYOFLG       PIC X(01).
      *連番号
               05  RECE03-RENNUM          PIC 9(02).
      *患者番号
           03  RECE03-PTNUM               PIC X(20).
      *診療科
           03  RECE03-SRYKA               PIC X(02).
      *基本病名コード
           03  RECE03-KHNBYOMEICD         PIC X(07).
      *病名コード
           03  RECE03-BYOMEICD-G.
               05  RECE03-BYOMEICD-1    PIC X(07).
               05  RECE03-BYOMEICD-2    PIC X(07).
               05  RECE03-BYOMEICD-3    PIC X(07).
               05  RECE03-BYOMEICD-4    PIC X(07).
               05  RECE03-BYOMEICD-5    PIC X(07).
               05  RECE03-BYOMEICD-6    PIC X(07).
      *
           03  RECE03-BYOMEICD-R        REDEFINES   RECE03-BYOMEICD-G.
               05  RECE03-BYOMEICD      PIC X(07)
                                       OCCURS   6.
      *疑いフラグ
           03  RECE03-UTAGAIFLG         PIC X(01).
      *主病名フラグ
      *****03  RECE03-SYUBYOFLG         PIC X(01).
      *慢性フラグ
           03  RECE03-MANSEIKBN         PIC 9(02).
      *保険組合番号
           03  RECE03-HKNCOMBI          PIC X(04).
      *レセプト表示フラグ
           03  RECE03-REZEFLG           PIC X(01).
      *レセプト表示月数
           03  RECE03-REZEMM            PIC 9(02).
      *転帰区分
      *****03  RECE03-TENKIKBN          PIC X(01).
      *転帰日
      **** 03  RECE03-TENKIYMD          PIC X(08).
      *病名
      **** 03  RECE03-BYOMEI            PIC X(160).
      *病名文字数
           03  RECE03-BYOMEIMOJI        PIC 9(03).
      *病名編集フラグ
           03  RECE03-BYOMEIHENFLG      PIC X(01).
      *IＣＤ１０
           03  RECE03-ICD10             PIC X(05).
      *管理番号
           03  RECE03-KNRNUM            PIC 9(05).
      *標準病名コード
           03  RECE03-HYOJUNCD          PIC X(09).
      *レセプト電算コード
           03  RECE03-RECECD-G.
               05  RECE03-RECECD        PIC X(07)
                                       OCCURS   18.
      *
