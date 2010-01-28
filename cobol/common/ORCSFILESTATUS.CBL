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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCSFILESTATUS.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : ファイル存在チェック
      *  管理者            : 
      *  作成日付    作業者        記述
      *  22/01/22    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
           SELECT  IN-FILE         ASSIGN  ASS-FILENAME
                                   FILE    STATUS  IS  STS-IN.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
       FD  IN-FILE.
       01  IN-REC                      PIC X(01).
      *
       WORKING-STORAGE                 SECTION.
      *
       01  ASS-AREA.
           03  ASS-FILENAME            PIC X(128).
      *
       01  STS-AREA.
           03  STS-IN                  PIC X(02).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                         SECTION.
      *
           COPY    "CPORCSFILESTATUS.INC".
      *
       PROCEDURE                       DIVISION    USING
           SFILESTATUS-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
      *    初期処理
           PERFORM 100-INIT-SEC
      *
      *    主処理
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
      *
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    ZERO        TO  SFILESTATUS-RC
      *
           MOVE    SFILESTATUS-FILENAME     TO  ASS-FILENAME
           OPEN    INPUT   IN-FILE
           IF    ( STS-IN  NOT =   ZERO )
               MOVE    1       TO  SFILESTATUS-RC
           END-IF
      *
           CLOSE   IN-FILE
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *
           .
       300-END-EXT.
           EXIT.
      *
