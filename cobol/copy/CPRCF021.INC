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
      *    資格１レコード     COPY (CPRCF021.INC)        *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  RECE21-REC.
      *レコード共通
           03  RECE21-KYOTU-AREA.
      *レコード長      
               05  RECE21-LENGTH          PIC  9(04).
      *レコード種別
               05  RECE21-SYUBETU         PIC  9(02).
      *レセプト番号
               05  RECE21-RECENUM         PIC  9(06).
      *レコード番号
               05  RECE21-RECNUM          PIC  9(03).
      *レセプト種別
           03  RECE21-RECESYUBETU         PIC  9(04).
      *診療年月
           03  RECE21-SRYYM               PIC  9(04).
      *審査支払機関
           03  RECE21-TEISYUTUSAKI        PIC  9(01).
      *医療機関コード
           03  RECE21-HOSPCD              PIC  9(07).
      *診療科
           03  RECE21-SRYKA               PIC  X(02).
      *患者氏名領域
           03  RECE21-PTNAME-AREA.
      *患者氏名モード識別
               05  RECE21-PTNAME-MODE     PIC  9(01).
      *患者氏名
               05  RECE21-PTNAME          PIC  X(40).
      *男女区分
           03  RECE21-SEX                 PIC  9(01).
      *生年月日
           03  RECE21-BIRTHDAY            PIC  9(07).
      *保険者番号
           03  RECE21-HKNJANUM            PIC  X(08).
      *保険者証情報
           03  RECE21-KIGONUM-AREA.
               05  RECE21-KIGONUM-MODE    PIC  9(01).
               05  RECE21-KIGONUM         PIC  X(40).
      *給付割合
           03  RECE21-KYURATE             PIC  X(03).
      *職務上の事由
           03  RECE21-JIYU                PIC  X(01).
      *予備
           03  RECD21-YOBI1               PIC  X(01).
      *証明書
           03  RECE21-CERTNUM             PIC  X(03).
      *特記事項情報
           03  RECE21-TOKKIINF.
               05  RECE21-TOKKIINF-TBL    OCCURS  5.
      *特記事項
                 07  RECE21-TOKKI         PIC  X(02).
      *病床数
           03  RECE21-BEDSU               PIC  X(04).
      *診療年月−年号        
           03  RECE21-SRYYM-NENGO         PIC  9(01).
      *病棟区分情報
           03  RECE21-BYOTOKBNINF.
               05  RECE21-BYOYOKBNINF-TBL OCCURS  4.
      *病棟区分
                 07  RECE21-BYOTOKBN      PIC  X(02).
      *予備
           03  RECE21-YOBI2               PIC  X(73).
      *レセプト削除表示
           03  RECE21-RECESAKUJO          PIC  X(01).
      *カルテ番号等
           03  RECE21-KARUTE              PIC  X(20).
      *改行コード
           03  RECE21-RETURNCD            PIC  X(01).
