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
       PROGRAM-ID.                     ORCHCN03S01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 入院請求書兼領収書印刷サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  06/02/09    NACL−太田    新規作成
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
      *    印刷用データ
           SELECT  IN01-FILE   ASSIGN  WRK-ASSIGN
                               ORGANIZATION    IS  LINE SEQUENTIAL 
                               FILE    STATUS  IS  STS-IN01.
      *
      *    印刷用データ
           SELECT  PRT-FILE    ASSIGN  HC03PARA
                               ORGANIZATION    IS  LINE SEQUENTIAL 
                               FILE    STATUS  IS  STS-PARA.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
       FD  IN01-FILE.
       01  IN01-REC.
           03  IN01-SRYYMD             PIC X(08).
           03  IN01-PTID               PIC 9(10).
           03  IN01-PRTID              PIC X(30).
           03  IN01-PRTNM              PIC X(20).
           03  IN01-SITEKBN            PIC X(01).
           03  IN01-PRTDATA            PIC X(10000).
      *
      *    印刷用データ
       FD  PRT-FILE.
       01  PRT-REC.
           03  PRT-PRTID               PIC X(30).
           03  PRT-PRTNM               PIC X(20).
           03  PRT-SITEKBN             PIC X(01).
           03  PRT-PRTDATA             PIC X(10000).
      *
       WORKING-STORAGE                 SECTION.
      *
           COPY    "CPCOMMONPRT.INC"   REPLACING   //HC01PARA//
                                       BY          //HC03PARA//.
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-IN01                PIC X(02).
           03  STS-PARA                PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-IN01                PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                    PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-ASSIGN              PIC X(500).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY    "CPMKPASS.INC".
      *
      *    印刷ＤＢ制御サブ
           COPY    "CPORCSPRT.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "CPORCHCN03.INC".
           COPY    "CPCOMMONPRT.INC".
      *
       PROCEDURE                   DIVISION    USING
           ORCHCN03AREA
           HC01PARA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
                                       STS-AREA
                                       WRK-AREA
                                       IDX-AREA
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 200-END-SEC
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           MOVE    HC01PARA        TO  WRK-ASSIGN
                                       HC03PARA
      *
           COMPUTE HC03PARA-CNT    =   HC03PARA-CNT    +   1
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           IF    ( ORCHCN03-PRTKBN     =   "1" )
               PERFORM 2001-BATCH-PRINT-SEC
           ELSE
               PERFORM 2001-ONLINE-PRINT-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    バッチ出力処理
      *****************************************************************
       2001-BATCH-PRINT-SEC            SECTION.
      *
           MOVE    ZERO                    TO  ORCHCN03-OUTCNT
      *
           OPEN    INPUT   IN01-FILE
      *
           PERFORM 900-IN01-READ-SEC
      *
           PERFORM UNTIL ( FLG-IN01    NOT =   ZERO )
      *
               COMPUTE ORCHCN03-OUTCNT
                   =   ORCHCN03-OUTCNT     +   1
      *
               MOVE    ORCHCN03-PRTAREA    TO  ORCSPRTAREA
               MOVE    IN01-SRYYMD (1:6)   TO  SPRT-SRYYM
               MOVE    IN01-PTID           TO  SPRT-PTID
               MOVE    IN01-PRTID          TO  SPRT-PRTID
               MOVE    IN01-PRTNM          TO  SPRT-PRTNM
               MOVE    IN01-PRTDATA        TO  SPRT-PRTDATA
               MOVE    IN01-SITEKBN        TO  SPRT-SITEKBN

               CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
               IF    ( SPRT-RETURN         =   ZERO )
                   CONTINUE
               ELSE
                   DISPLAY "ORCSPRT ERR !! " SPRT-RETURN
               END-IF
      *
               PERFORM 900-IN01-READ-SEC
      *
           END-PERFORM
      *
           CLOSE   IN01-FILE
      *
           .
       2001-BATCH-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    オンライン出力処理
      *****************************************************************
       2001-ONLINE-PRINT-SEC           SECTION.
      *
           OPEN    INPUT   IN01-FILE
                   OUTPUT  PRT-FILE
      *
           PERFORM 900-IN01-READ-SEC
      *
           PERFORM UNTIL ( FLG-IN01    NOT =   ZERO )
      *
               INITIALIZE                      PRT-REC
      *
               MOVE    IN01-PRTID          TO  PRT-PRTID
               MOVE    IN01-PRTNM          TO  PRT-PRTNM
               MOVE    IN01-PRTDATA        TO  PRT-PRTDATA
               MOVE    IN01-SITEKBN        TO  PRT-SITEKBN
      *
               WRITE   PRT-REC
      *
               PERFORM 900-IN01-READ-SEC
      *
           END-PERFORM
      *
           CLOSE   IN01-FILE
                   PRT-FILE
      *
           MOVE    SPACE           TO  SHELLTBL
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    "scripts/daily/HCALL2.sh"
                                   TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
           MOVE    HC03PARA        TO  SHELLTBL-ARG1
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "shell"         TO  MCP-TABLE
           MOVE    "shell"         TO  MCP-PATHNAME
           MOVE    "SHELL"         TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       2001-ONLINE-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       200-END-SEC                 SECTION.
      *
      *
           .
       200-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷用データ読込処理
      *****************************************************************
       900-IN01-READ-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-IN01
      *
           READ    IN01-FILE
           AT  END
               MOVE    1           TO  FLG-IN01
           END-READ
      *
           .
       900-IN01-READ-EXT.
           EXIT.
      *
