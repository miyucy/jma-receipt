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
      *   労災レセプト明細書（入院）（病名） COPY (CPRCF083.INC) *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE83-REC.
           03  RECE83-KEY.
      *医療機関ＩＤ
               05  RECE83-HOSPID          PIC  X(24).
      *診療年月
               05  RECE83-SRYYM           PIC  9(06).
      *入外区分
               05  RECE83-NYUGAIKBN       PIC  X(01).
      *患者ＩＤ
               05  RECE83-PTID            PIC  9(10).
      *レセプト科
               05  RECE83-RECEKA          PIC  X(02).
      *保険ＩＤ        
               05  RECE83-HKNID           PIC  9(10).
      *適用開始年月日
               05  RECE83-TEKSTYMD        PIC  X(08).
      *診療開始日
               05  RECE83-SRYYMD          PIC  X(08).
      *病名
               05  RECE83-BYOMEI          PIC  X(160).
      *基本病名コード
           03  RECE83-KHNBYOMEICD         PIC  X(07).
      *病名コード
           03  RECE83-BYOMEICD-G.
               05  RECE83-BYOMEICD-1    PIC X(07).
               05  RECE83-BYOMEICD-2    PIC X(07).
               05  RECE83-BYOMEICD-3    PIC X(07).
               05  RECE83-BYOMEICD-4    PIC X(07).
               05  RECE83-BYOMEICD-5    PIC X(07).
               05  RECE83-BYOMEICD-6    PIC X(07).
      *
           03  RECE83-BYOMEICD-R        REDEFINES   RECE83-BYOMEICD-G.
               05  RECE83-BYOMEICD      PIC X(07)
                                       OCCURS   6.
      *疑いフラグ
           03  RECE83-UTAGAIFLG         PIC X(01).
      *慢性フラグ
           03  RECE83-MANSEIKBN         PIC 9(02).
      *主病名フラグ
           03  RECE83-SYUBYOFLG       PIC  X(01).
      *保険組合番号
           03  RECE83-HKNCOMBI          PIC X(04).
      *レセプト表示フラグ
           03  RECE83-REZEFLG           PIC X(01).
      *レセプト表示月数
           03  RECE83-REZEMM            PIC 9(02).
      *転帰区分
           03  RECE83-TENKIKBN          PIC  X(01).
      *転帰日
           03  RECE83-TENKIYMD          PIC  X(08).
      *病名文字数
           03  RECE83-BYOMEIMOJI        PIC 9(03).
      *病名編集フラグ
           03  RECE83-BYOMEIHENFLG      PIC X(01).
      *IＣＤ１０
           03  RECE83-ICD10             PIC X(05).
      *管理番号
           03  RECE83-KNRNUM            PIC 9(05).
      *標準病名コード
           03  RECE83-HYOJUNCD          PIC X(09).
