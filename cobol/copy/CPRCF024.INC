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
      *    レセプト電算・ 適用レコード         (CPRCF023.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE24-REC.
      *レコード共通
           03  RECE24-KYOTU-AREA.
      *レコード長
               05  RECE24-LENGTH          PIC  9(04).
      *レコード種別
               05  RECE24-SYUBETU         PIC  9(02).
      *レセプト番号
               05  RECE24-RECENUM         PIC  9(06).
      *レコード番号
               05  RECE24-RECNUM          PIC  9(03).
      *適用データ
           03  RECE24-TEKIYOU             PIC  X(241).
      *改行コード
           03  RECE24-RETURNCD            PIC  X(01).
      