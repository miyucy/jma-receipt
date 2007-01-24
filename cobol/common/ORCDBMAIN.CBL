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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCDBMAIN.
      *****************************************************************
      *  システム名        : ORCA
      *  サブシステム名    : 
      *  コンポーネント名  : ORCA DB アクセスメインモジュール
      *  返却エラーコード  : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/01/23    NACL-竹田     新規作成
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD              PIC X(08).
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
     *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *    共通領域
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *
       PROCEDURE                    DIVISION    USING
           MCPAREA
           MCPDATA-REC
           SPA-AREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
      *
           EXIT PROGRAM
           .
      *
