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
      *    レセプト電算・医療機関情報レコード  (CPRCF020.INC)    *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE20-REC.
      *レコード共通
           03  RECE20-KYOTU-AREA.
      *レコード長
               05  RECE20-KYOTU-LENGTH    PIC  9(04).
      *レコード種別
               05  RECE20-KYOTU-SYUBETU   PIC  9(02).
      *レセプト番号
               05  RECE20-KYOTU-RECENUM   PIC  9(06).
      *レコード番号
               05  RECE20-KYOTU-RECNUM    PIC  9(03).
      *ボリューム通番
           03  RECE20-VOLNUM              PIC  9(04).
      *都道府県
           03  RECE20-PREFNUM             PIC  9(02).
      *点数表区分
           03  RECE20-TENHYOKBN           PIC  9(01).
      *審査支払機関
           03  RECE20-TEISYUTUSAKI        PIC  9(01).
      *医療機関コード
           03  RECE20-HOSPCD              PIC  9(07).
      *診療科
           03  RECE20-SRYKA               PIC  X(02).
      *予備        
           03  FILLER                     PIC  X(01).
      *医療機関名称
           03  RECE20-HOSPNAME            PIC  X(40).
      *予備        
           03  RECE20-YOBI                PIC  X(183).
      *改行コード
           03  RECE20-RETURNCD            PIC  X(01).
