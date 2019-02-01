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
      *    ＡＰＩレスポンス診療科情報一覧
      *                                     COPY (CPDEPARTMETV2RES.INC)
      ******************************************************************
        01  XML-DEPARTMENTRES.
            02  DEPTRES-CONTEXT            PIC S9(9)   BINARY.
            02  DEPTRES-OBJECT             PIC X(36).
            02  DEPTRES-MODE               PIC S9(9)   BINARY.
            02  DEPTRES-RECORDNAME         PIC X(128).
            02  DEPTRES-APPOINTRES.
      *       実施日
              03  DEPTRES-INFORMATION-DATE    PIC X(10).
      *       実施時間
              03  DEPTRES-INFORMATION-TIME    PIC X(8).
      *       返却コード
              03  DEPTRES-API-RESULT          PIC X(2).
      *       返却メッセージ
              03  DEPTRES-API-RESULT-MSG      PIC X(100).
      *
              03  DEPTRES-RESKEY              PIC X(100).
      *       基準日
              03  DEPTRES-BASE-DATE           PIC X(10).
      *       診療科一覧
              03  DEPTRES-DEPARTMET-INFOMATION.
                 05  DEPTRES-DEPARTMET-INFO      OCCURS   100.
      *               診療科コード
                      07  DEPTRES-DEP-CODE        PIC X(2).
      *               診療科名称
                      07  DEPTRES-SRYKANAME       PIC X(80).
      *               短縮名称１
                      07  DEPTRES-SRYKANAME1      PIC X(20).
      *               短縮名称２
                      07  DEPTRES-SRYKANAME2      PIC X(12).
      *               短縮名称３
                      07  DEPTRES-SRYKANAME3      PIC X(04).
      *               レセ電診療科コード
                      07  DEPTRES-RECESRYKA       PIC X(02).
      *
