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
       PROGRAM-ID.                     ORCDTCHK000.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェック
      *  コンポーネント名  : 各処理呼出
      *  管理者            :
      *  作成日付    作業者        記述
      *  05/03/31    NACL−太田    新規作成
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
       DATA                            DIVISION.
       FILE                            SECTION.
      *
       WORKING-STORAGE                 SECTION.
      *
       01  DTCHK-RC                    PIC S9(09).
      *
      *    エラーファイルファイル名称領域 
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHKERR//.
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-HOSPID     PIC X(24).
      *
      *    データチェック一括処理パラメータ
           COPY    "CPORCBSD01PARA.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    データチェック診療会計
       01  DCACCT-REC.
           COPY    "CPDCACCT.INC".
      *
      *    データチェック診療行為
       01  DCSRY-REC.
           COPY    "CPDCSRY.INC".
      *
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
           COPY    "ORCA-DBPATH".
      *
      ****************************************************************
       LINKAGE                         SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE                       DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
      *
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    LNK-PRTKANRI-RENNUM
                                               LNK-PRTKANRI-TBL-KEY
                                               LNK-PRTKANRI-TBL-GROUP
                                               LNK-PRTKANRI-SHORI-RENNUM
                                               LNK-PRTKANRI-SRYYM
                                               LNK-PRTKANRI-SKYYMD
                                               LNK-PRTKANRI-SHELLID
                                               LNK-PRTKANRI-PRIORITY
                                               LNK-PRTKANRI-TERMID
                                               LNK-PRTKANRI-OPID
                                               LNK-PRTKANRI-PRTNM
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
                                               WRK-PARA-HOSPID
                                               DTCHKERRPARA
                                               ORCBSD01-SRYYM
                                               ORCBSD01-NYUGAIKBN
                                               ORCBSD01-CHKKBN-G
                                               ORCBSD01-JIHIPROCKBN
                                               ORCBSD01-INGAIPROCKBN
                                               ORCBSD01-PRTPTLSTKBN
      *
           PERFORM 100-DBOPEN-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    ZERO                TO  DTCHK-RC
      *
           IF    ( DTCHK-RC            =   ZERO )
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ST:ORCDTCHK004"
                   CALL    "ORCDTCHK004"       USING
                                               DTCHK-RC
                                               COMMAND-PARAM
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ED:ORCDTCHK004"
           END-IF
      *
           IF    ( DTCHK-RC            =   ZERO )
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ST:ORCDTCHK005"
                   CALL    "ORCDTCHK005"       USING
                                               DTCHK-RC
                                               COMMAND-PARAM
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ED:ORCDTCHK005"
           END-IF
      *
           IF    ( DTCHK-RC            =   ZERO )
               IF    ( ORCBSD01-NYUGAIKBN  =       "1" )
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ST:ORCDTCHK006"
                   CALL    "ORCDTCHK006"       USING
                                               DTCHK-RC
                                               COMMAND-PARAM
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ED:ORCDTCHK006"
               END-IF
           END-IF
      *
           IF    ( DTCHK-RC            =   ZERO )
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ST:ORCDTCHK001"
                   CALL    "ORCDTCHK001"       USING
                                               DTCHK-RC
                                               COMMAND-PARAM
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ED:ORCDTCHK001"
           END-IF
      *
           IF    ( DTCHK-RC            =   ZERO )
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ST:ORCDTCHK002"
                   CALL    "ORCDTCHK002"       USING
                                               DTCHK-RC
                                               COMMAND-PARAM
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ED:ORCDTCHK002"
           END-IF
      *
           IF    ( DTCHK-RC            =   ZERO )
               IF  ( ORCBSD01-PRTPTLSTKBN  =   "2" )
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ST:ORCDTCHK007"
                   CALL    "ORCDTCHK007"       USING
                                               DTCHK-RC
                                               COMMAND-PARAM
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ED:ORCDTCHK007"
               END-IF
           END-IF
      *
           IF    ( DTCHK-RC            =   ZERO )
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ST:ORCDTCHK003"
                   CALL    "ORCDTCHK003"       USING
                                               DTCHK-RC
                                               COMMAND-PARAM
                   PERFORM 800-MCNDATE-SEC
                   DISPLAY SMCNDATE-HMS "ED:ORCDTCHK003"
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           PERFORM 900-DBDISCONNECT-SEC
      *     
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBOPEN"            TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBDISCONNECT-EXT.
           EXIT.
