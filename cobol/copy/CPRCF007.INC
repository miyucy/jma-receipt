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
      *    レセプト管理                       (CPRCF007.INC)     *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02.02.12  人数の追加
      *  01.00.02    MCC-藤原     02.02.25  索引ファイルからＤＢへ変更
      *
      *  01.01.01    NACL-藤原    02.09.26  入外区分・処理区分の追加
      ************************************************************
      *01  RECE07-REC.
      *ＫＥＹ
           03  RECE07-KEY.
      *帳票ＩＤ
               05  RECE07-PRTID            PIC  X(04).
      *処理区分（１：一括、２：個別）
               05  RECE07-SYOKBN           PIC  X(01).
      *作成日
               05  RECE07-CREYMD           PIC  X(08).
      *作成時間
               05  RECE07-CREHMS           PIC  X(06).
      *審査支払機関
               05  RECE07-TEISYUTUSAKI     PIC  X(01).
      *レセプト種別
               05  RECE07-RECESYUBETU      PIC  X(04).
      *入外区分
           03  RECE07-NYUGAIKBN            PIC  X(01).
      *診療年月（一括：診療年月、個別：先頭の診療年月）
           03  RECE07-SRYYM                PIC  X(06).
      *ページ
           03  RECE07-PAGE                 PIC  9(05).
      *ページ
           03  RECE07-KENSU                PIC  9(05).
      *データ区分
           03  RECE07-RECEKBN              PIC  X(01).
      *端末ＩＤ
           03  RECE07-TERMID               PIC  X(16).
