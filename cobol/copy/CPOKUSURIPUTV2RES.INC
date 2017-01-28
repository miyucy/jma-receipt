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
      ******************************************************************
      *    ＡＰＩレスポンスお薬手帳情報
      *    COPY (CPOKUSURIPUTV2RES.INC)
      ******************************************************************
       01  XML-OKUSURIPUTRES.
           03  OKUSURIPUTRES-CONTEXT     PIC S9(9)   BINARY.
           03  OKUSURIPUTRES-OBJECT      PIC X(8).
           03  OKUSURIPUTRES-MODE        PIC S9(9)   BINARY.
           03  OKUSURIPUTRES-RECORDNAME  PIC X(128).
      *
           03  OKUSURIPUTRES-OKUSURIPUTV2RES.
               05  OKUSURIPUTRES-INFORMATION-DATE    PIC X(10).
               05  OKUSURIPUTRES-INFORMATION-TIME    PIC X(08).
               05  OKUSURIPUTRES-API-RESULT          PIC X(04).
               05  OKUSURIPUTRES-API-RESULT-MSG      PIC X(100).
               05  OKUSURIPUTRES-JMA-VERSION         PIC X(64).
      *        基準日
               05  OKUSURIPUTRES-BASE-DATE           PIC X(10).
      *        患者情報
               05  OKUSURIPUTRES-PTINF-AREA.
                 07  OKUSURIPUTRES-PTNUM             PIC X(20).
                 07  OKUSURIPUTRES-NAME              PIC X(100).
                 07  OKUSURIPUTRES-KANANAME          PIC X(100).
                 07  OKUSURIPUTRES-BIRTHDAY          PIC X(10).
                 07  OKUSURIPUTRES-SEX               PIC X(1).
      *        お薬手帳管理データテーブル（１０件まで）
               05  OKUSURIPUTRES-INFOMATION  OCCURS  10.
      *        連番
                 07  OKUSURIPUTRES-RENNUM            PIC X(04).
      *        グループ
                 07  OKUSURIPUTRES-TBL-GROUP         PIC X(14).
      *        UUID
                 07  OKUSURIPUTRES-TBL-UUID          PIC X(36).
      *        処理内連番
                 07  OKUSURIPUTRES-SHORI-RENNUM      PIC X(04).
      *        お薬手帳データ
               05  OKUSURIPUTRES-DATA.
                   07  OKUSURIPUTRES-CSV-DATA        PIC X(10000).
