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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBMGZU.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次
      *  コンポーネント名  : 画像診断フィルム料一括変更
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/02/18    NACL-多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
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
           03  FLG-END                 PIC 9(01).
           03  FLG-SRYACCT             PIC 9(01).
           03  FLG-SRYACT              PIC 9(01).
           03  FLG-TENSU               PIC 9(01).
      *
           03  FLG-OK                  PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-UPD                 PIC 9(04).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY              PIC 9(02).
               05  SYS-MM              PIC 9(02).
               05  SYS-DD              PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID          PIC 9(07).
           03  WRK-PARA-SHELLID        PIC X(08).
           03  WRK-PARA-HOSPID         PIC X(24).
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-KIZAITEN            PIC 9(08).
           03  WRK-KIZAIKEI            PIC 9(08).
           03  WRK-FIRUMU              PIC 9(08).
           03  WRK-SYOKEIS2            PIC 9(08)V99.
      *
           03  WRK-DD                  PIC 9(02).
      *
      *    COPY    "CPSHELLTBL.INC".
      *
      *    COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *
      *    診療会計マスタ
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    診療行為マスタ
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER                  PIC X(256).
      *
      ******************************************************************
      *
       PROCEDURE               DIVISION
                                       USING
                                       COMMAND-PARAM.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                       INTO            LNK-PRTKANRI-RENNUM
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
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBMGZU"      TO  JOB-PGID
           MOVE    "画像診断一括変更"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC         SECTION.
      *
      *
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    画像診断検索
           INITIALIZE                  SRYACCT-REC
           MOVE    WRK-PARA-HOSPID TO  ACCT-HOSPID
           MOVE    "70"            TO  ACCT-SRYKBN
      *
           MOVE    SRYACCT-REC     TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SRYACCT-KEY17" TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY17"     TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           PERFORM
               UNTIL       FLG-SRYACCT     =   1
      *TEST
           IF     ACCT-PTID   =   2477
      *TEST
      *        最初の日を保存（点数マスタ検索のため）
               MOVE    01                  TO  WRK-DD
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   31
                   IF      ACCT-DAY (1 IDY)    >   ZERO
                       MOVE    IDY                 TO  WRK-DD
                   END-IF
               END-PERFORM
      *        器材料がある時、再計算する
               IF      ACCT-KIZAITEN       >   ZERO
                   PERFORM 201-KIZAIKEI-SEC
               END-IF
      *TEST
            END-IF
      *TEST
      *
               MOVE    "SRYACCT-KEY17"     TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"        TO  MCP-FUNC
           MOVE    "SRYACCT-KEY17" TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    器材料再計算処理
      *****************************************************************
       201-KIZAIKEI-SEC          SECTION.
      *
           INITIALIZE                  SRYACT-REC
           MOVE    ACCT-HOSPID         TO  SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN
           MOVE    ACCT-PTID           TO  SRY-PTID
           MOVE    ACCT-SRYKA          TO  SRY-SRYKA
           MOVE    ACCT-SRYYM          TO  SRY-SRYYM
           MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 910-SRYACT-READ-SEC
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           MOVE    ZERO                TO  WRK-KIZAIKEI
           MOVE    ZERO                TO  WRK-KIZAITEN
           PERFORM
               UNTIL   FLG-SRYACT      =   1
               PERFORM VARYING IDX     FROM    1   BY  1
                       UNTIL ( IDX     >   5 )
                       OR    ( SRY-SRYCD(IDX)  =   SPACE )
      *            器材の集計
                   IF     (SRY-SRYCD(IDX)(1:1)     =   "7"  )  OR
                          (SRY-SRYCD(IDX)(1:3)     =   "059")
                       PERFORM 2011-KIZAI-TEN-SEC
                   END-IF
               END-PERFORM
      *
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 910-SRYACT-READ-SEC
           END-PERFORM
      *
      *    フィルム以外の点数
      *    金額計÷１０　四捨五入
           COMPUTE WRK-SYOKEIS2        =   WRK-KIZAIKEI
                                       /   10
                                       +   0.5
           MOVE    WRK-SYOKEIS2        TO  WRK-KIZAITEN
      *
           IF      WRK-KIZAITEN        >   ZERO
      *        特定器材あり
               IF      ACCT-KIZAITEN       >   WRK-KIZAITEN
                   COMPUTE WRK-FIRUMU      =   ACCT-KIZAITEN
                                           -   WRK-KIZAITEN
               ELSE
                   MOVE    ZERO            TO  WRK-FIRUMU
               END-IF
           ELSE
               MOVE    ACCT-KIZAITEN       TO  WRK-FIRUMU
           END-IF
      *
           MOVE    WRK-KIZAITEN        TO  ACCT-KIZAITEN
           MOVE    WRK-FIRUMU          TO  ACCT-SYUTEN2
           COMPUTE ACCT-SYUTEN1        =   ACCT-SYUTEN1
                                       +   WRK-FIRUMU
      *
      *    更新
           MOVE    SRYACCT-REC     TO  MCPDATA-REC
           MOVE    "DBUPDATE"      TO  MCP-FUNC
           MOVE    "SRYACCT-KEY"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *!   IF      MCP-RC          NOT =   ZERO
               DISPLAY "ORCBMGZU SRYACCT UPD ERR:"  MCP-RC
                       ",KEY:"   ACCT-KEY
      *!   END-IF
           ADD     1                   TO  CNT-UPD
      *
           .
       201-KIZAIKEI-EXT.
           EXIT.
      *****************************************************************
      *    器材編集処理
      *****************************************************************
       2011-KIZAI-TEN-SEC           SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    SRY-SRYCD(IDX)      TO  TNS-SRYCD
      *    点数マスタ検索
           PERFORM 900-TNS-READ-SEC
      *
      *    フィルム以外の点数
           IF      TNS-DATAKBN         =   "3"
                GO      TO      2011-KIZAI-TEN-EXT
           END-IF
      *
           IF      TNS-TOKUKIZAISBT1   =   ZERO
      *        (購入価格＊数量)
               COMPUTE WRK-SYOKEIS2        =   TNS-TEN
                                           *   SRY-SRYSURYO (IDX)
      *
               ADD     WRK-SYOKEIS2        TO  WRK-KIZAIKEI
           END-IF
      *
             .
       2011-KIZAI-TEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           DISPLAY "*** ORCBMGZU UPD:"     CNT-UPD
           DISPLAY "*** ORCBMGZU END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-UPD         TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *     診療会計マスタ検索処理
      *****************************************************************
       900-SRYACCT-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    ZERO            TO  FLG-SRYACCT
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACCT
           END-IF
           .
       900-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *     診療行為マスタ検索処理
      *****************************************************************
       910-SRYACT-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    ZERO            TO  FLG-SRYACT
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACT
           END-IF
           .
       910-SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ検索
      *****************************************************************
       900-TNS-READ-SEC            SECTION.
      *
           MOVE    ZERO            TO  TNS-YUKOSTYMD
           MOVE    ALL "9"         TO  TNS-YUKOEDYMD
      *
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "TENSU-KEY"     TO  ORC-DBPATH
           MOVE    SRY-SRYYM       TO  ORC-DBYMD(1:6)
           MOVE    WRK-DD          TO  ORC-DBYMD(7:2)
      *
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "TENSU-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF        ( MCP-RC          =   ZERO )
                   MOVE    ZERO            TO  FLG-TENSU
                   MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1               TO  FLG-TENSU
               END-IF
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1               TO  FLG-TENSU
           END-IF
           .
       900-TNS-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
