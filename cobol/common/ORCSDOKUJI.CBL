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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         ORCSDOKUJI.
      ****************************************************************
      *    OS           LINUX                                         
      *                                                               
      *    PROGRAM      ORCSDOKUJI  /  負担金額算定サブ（計算ロジック追加）                   
      *                     
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/09/16    NACL−小豆沢  新規作成
      ****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
       ENVIRONMENT         DIVISION.
       CONFIGURATION       SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE SECTION.
      *
       01  WK-END                      PIC 9(08).
       01  WK-FLG.
           03  FLG-PTINF               PIC 9(01).
      *
           03  WK-ERR                  PIC 9(01).
           03  WK-UERR                 PIC 9(01).
           03  WK-PAYKBN               PIC X(02).
      *
      *    保険区分（空白：医保　１：労災　２：自賠責）
           03  WK-HKNKBN               PIC X(01).
      *
      *    患者負担計算時の四捨五入用ワーク
           03  WK-FTN                  PIC 9(10).
      *
      *    添え字領域
       01  IDX-AREA.
           03  IDX                     PIC  9(02)  VALUE  ZERO.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      /
      ***
       LINKAGE             SECTION.
           COPY  "MCPAREA".
       01  LNK-SYU-SYUNOU-REC.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
      /
       PROCEDURE           DIVISION  USING
                                     LNK-SYU-SYUNOU-REC.
      ******************************************************************
      *        依頼制御処理
      ******************************************************************
       MAIN-RTN            SECTION.
       MAIN-000.
      *
       MAIN-EXT.
           EXIT PROGRAM
           STOP RUN.
      *
