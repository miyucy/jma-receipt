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
      *    資格２レコード     COPY (CPRCF022.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE22-REC.
      *レコード共通
           03  RECE22-KYOTU-AREA.
      *レコード長      
               05  RECE22-LENGTH          PIC  9(04).
      *レコード種別
               05  RECE22-SYUBETU         PIC  9(02).
      *レセプト番号
               05  RECE22-RECENUM         PIC  9(06).
      *レコード番号
               05  RECE22-RECNUM          PIC  9(03).
      *老人保険情報
           03  RECE22-RJNINF.
      *老人保険−市町村番号
               05  RECE22-RJNFTNJANUM     PIC  X(08).
      *老人保険−受給者番号
               05  RECE22-RJNJKYSNUM      PIC  X(07).
      *公費情報
           03  RECE22-KOHINF              OCCURS  2.
      *公費−負担者番号
               05  RECE22-KOHFTNJANUM     PIC  X(08).
      *公費−受給者番号
               05  RECE22-KOHJKYSNUM      PIC  X(07).
      *公費−任意給付区分
               05  RECE22-KOHNINIKYUKBN   PIC  X(01).
      *老人第二公費情報
           03  RECE22-RJNKOHINF.
      *老人第二公費−市町村番号
               05  RECE22-RJN2FTNJANUM    PIC  X(08).
      *老人第二公費−受給者番号
               05  RECE22-RJN2JKYSNUM     PIC  X(07).
      *予備
           03  RECE22-YOBI                PIC  X(179).
      *改行コード
           03  RECE22-RETURNCD            PIC  X(01).
