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
       PROGRAM-ID.             ORCSPRVDBDEL.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為入力
      *  コンポーネント名  : リアルタイムプレビュー
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    NACL−竹田　　新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    カウント領域
       01  FLG-AREA.
           03  FLG-SYUNOU                              PIC 9(01).
           03  FLG-SYUMEI                              PIC 9(01).
           03  FLG-SYUTTL                              PIC 9(01).
           03  FLG-JYURRK                              PIC 9(01).
           03  FLG-SRYACCT                             PIC 9(01).
           03  FLG-SRYACT                              PIC 9(01).
           03  FLG-SANTEI                              PIC 9(01).
           03  FLG-SRYKARRK                            PIC 9(01).
           03  FLG-PTCOM                               PIC 9(01).
           03  FLG-DEL                                 PIC 9(01).
      *
           03  WRK-SRYYMD.
               05  WRK-SRYYM           PIC X(06).
               05  WRK-SRYDD           PIC X(02).
      *  
           03  WRK-ZAINUM              PIC 9(08).
      *
      *
           COPY    "MCPAREA".
      *
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納明細
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *    収納合計マスタ
       01  SYUTTL-REC.
           COPY    "CPSYUTOTAL.INC".
      *
      *    受診履歴マスタ
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    会計マスタ
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    会計付加情報マスタ
       01  SRYACCTPLUS-REC.
           COPY    "CPSRYACCTPLUS.INC".
      *
      *    診療行為マスタ
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    算定マスタ
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    診療科履歴マスタ
       01  SRYKARRK-REC.
           COPY    "CPSRYKARRK.INC".
      *
      *    患者コメントマスタ
       01  PTCOM-REC.
           COPY    "CPPTCOM.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  PARAM-HOSPID       PIC X(24).
       01  PARAM-NYUGAIKBN    PIC X(01).
       01  PARAM-PTID         PIC 9(10).
      *01  PARAM-RC           PIC 9(02).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           PARAM-HOSPID
           PARAM-NYUGAIKBN
           PARAM-PTID.
      *    PARAM-RC.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           DISPLAY "take DBDEL START"
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
      *
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
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
      *    TMP DB存在チェック
           PERFORM 2000-TMPDB-EXIST-SEC
      *    TMP DB削除処理
           IF      FLG-DEL             =  1
               PERFORM 2001-TMPDB-DELETE-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    テンポラリDB存在チェック処理
      *****************************************************************
       2000-TMPDB-EXIST-SEC         SECTION.
      *
           MOVE    PARAM-HOSPID        TO      JYURRK-HOSPID
           MOVE    PARAM-PTID          TO      JYURRK-PTID
           MOVE    JYURRK-REC          TO      MCPDATA-REC
           MOVE    "DBSELECT"          TO      MCP-FUNC
           MOVE    PATH-TBL-JYURRK-PRV-KEY31
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "DBFETCH"         TO      MCP-FUNC
               MOVE    PATH-TBL-JYURRK-PRV-KEY31
                                       TO      MCP-PATH
               PERFORM  900-TMPDB-ACCESS-SEC
               IF      MCP-RC          =       ZERO
               DISPLAY "take jyurrk_prv exist   "
                  MOVE 1               TO      FLG-DEL
               ELSE
               DISPLAY "take jyurrk_prv not fount   "
                  MOVE ZERO            TO      FLG-DEL
               END-IF
               MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
               MOVE    PATH-TBL-JYURRK-PRV-KEY31
                                       TO      MCP-PATH
               CALL    "MCPSUB"        USING
                                       MCPAREA
                                       MCPDATA-REC
           END-IF
           .
       2000-TMPDB-EXIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    テンポラリDB削除処理
      *****************************************************************
       2001-TMPDB-DELETE-SEC        SECTION.
      *収納マスタ
           MOVE    PARAM-HOSPID        TO      SYU-HOSPID
           MOVE    PARAM-NYUGAIKBN     TO      SYU-NYUGAIKBN
           MOVE    PARAM-PTID          TO      SYU-PTID
           MOVE    SYUNOU-REC          TO      MCPDATA-REC
           DISPLAY "take tmp db delete syunou st = " SYU-PTID "," 
                                           SYU-HOSPID ","
                                           SYU-NYUGAIKBN
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-SYUNOU-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
      *収納明細マスタ
           MOVE    PARAM-HOSPID        TO      SMEI-HOSPID
           MOVE    PARAM-NYUGAIKBN     TO      SMEI-NYUGAIKBN
           MOVE    PARAM-PTID          TO      SMEI-PTID
           MOVE    SYUMEI-REC          TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-SYUMEI-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
      *収納トータルマスタ
           MOVE    PARAM-HOSPID        TO      SYUTTL-HOSPID
           MOVE    PARAM-NYUGAIKBN     TO      SYUTTL-NYUGAIKBN
           MOVE    PARAM-PTID          TO      SYUTTL-PTID
           MOVE    SYUTTL-REC          TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-SYUTOTAL-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
      *会計マスタ
           MOVE    PARAM-HOSPID        TO      ACCT-HOSPID
           MOVE    PARAM-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    PARAM-PTID          TO      ACCT-PTID
           MOVE    SRYACCT-REC         TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-SRYACCT-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
      *診療行為マスタ
           MOVE    PARAM-HOSPID        TO      SRY-HOSPID
           MOVE    PARAM-NYUGAIKBN     TO      SRY-NYUGAIKBN
           MOVE    PARAM-PTID          TO      SRY-PTID
           MOVE    SRYACT-REC          TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-SRYACT-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
      *算定履歴マスタ
           MOVE    PARAM-HOSPID        TO      SANTEI-HOSPID
           MOVE    PARAM-NYUGAIKBN     TO      SANTEI-NYUGAIKBN
           MOVE    PARAM-PTID          TO      SANTEI-PTID
           MOVE    SANTEI-REC          TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-SANTEI-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
      *受診履歴マスタ
           MOVE    PARAM-HOSPID        TO      JYURRK-HOSPID
           MOVE    PARAM-NYUGAIKBN     TO      JYURRK-NYUGAIKBN
           MOVE    PARAM-PTID          TO      JYURRK-PTID
           MOVE    JYURRK-REC          TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-JYURRK-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
      *診療科履歴マスタ
           MOVE    PARAM-HOSPID        TO      KARRK-HOSPID
           MOVE    PARAM-PTID          TO      KARRK-PTID
           MOVE    SRYKARRK-REC        TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-SRYKARRK-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
      *患者コメントマスタ
           MOVE    PARAM-HOSPID        TO      PTCOM-HOSPID
           MOVE    PARAM-PTID          TO      PTCOM-PTID
           MOVE    PTCOM-REC           TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-PTCOM-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
      *患者マスタ
           MOVE    PARAM-HOSPID        TO      PTINF-HOSPID
           MOVE    PARAM-PTID          TO      PTINF-PTID
           MOVE    PTINF-REC           TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-PTINF-PRV-DELPRV
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *診療行為付加情報マスタ
           MOVE    PARAM-HOSPID        TO      ACCTP-HOSPID
           MOVE    PARAM-NYUGAIKBN     TO      ACCTP-NYUGAIKBN
           MOVE    PARAM-PTID          TO      ACCTP-PTID
           MOVE    SRYACCTPLUS-REC     TO      MCPDATA-REC
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    PATH-TBL-SRYACCTPLUS-PRV-DEL1
                                       TO      MCP-PATH
           PERFORM  900-TMPDB-ACCESS-SEC
      *
           .
       2001-TMPDB-DELETE-EXT.
           EXIT.
      *****************************************************************
      *    本体DB更新処理
      *****************************************************************
       900-TMPDB-ACCESS-SEC            SECTION.
      *
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC         NOT  =   ZERO
               INITIALIZE                  MCPDATA-REC
           END-IF
      *
           .
       900-REALDB-INS-EXT.
           EXIT.
