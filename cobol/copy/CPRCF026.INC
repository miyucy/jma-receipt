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
      *    合計書レコード     COPY (CPRCF026.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE26-REC.
      *レコード共通
           03  RECE26-KYOTU-AREA.
      *レコード長      
               05  RECE26-LENGTH          PIC  9(04).
      *レコード種別
               05  RECE26-SYUBETU         PIC  9(02).
      *レセプト番号
               05  RECE26-RECENUM         PIC  9(06).
      *レコード番号
               05  RECE26-RECNUM          PIC  9(03).
      *レセプト種別
           03  RECE26-RECESYUBETU         PIC  9(04).
      *審査支払機関
           03  RECE26-TEISYUTUSAKI        PIC  9(01).
      *医療機関コード
           03  RECE26-HOSPCD              PIC  9(07).
      *請求年月
           03  RECE26-SEIKYUYM            PIC  9(04).
      *総件数
           03  RECE26-TOTALKENSU          PIC  9(06).
      *総合計点数
           03  RECE26-TOTALTENSU          PIC  9(10).
      *請求年月−年号
           03  RECE26-SEIKYU-NENGO        PIC  9(01).
      *予備
           03  RECE26-YOBI                PIC  X(208).
      *改行コード
           03  RECE26-RETURNCD            PIC  X(01).
