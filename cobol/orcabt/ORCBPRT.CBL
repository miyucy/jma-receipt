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
      *
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBPRT.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 帳票ＤＢの印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/16    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/05/20  再印刷画面からの印刷による修正  
      *  01.00.02    NACL-藤原    02/09/12  ディレクトリをサブプロへ
      *  01.01.01    NACL-藤原    02/10/10  印刷用コンスタント領域の追加
      *                                     印刷用ファイルにサイト区分を追加
      *  01.01.02    NACL-藤原    03/03/04  印刷ＤＢへのプリンタ名追加による
      *                                     修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   ORGANIZATION    IS  LINE
                                                       SEQUENTIAL 
                                   FILE    STATUS  IS  STS-PRT.
      *
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
       01  PRT-REC.
           03  PRT-PRTID           PIC X(30).
           03  PRT-PRTNM           PIC X(20).
           03  PRT-SITEKBN         PIC X(01).
           03  PRT-PRTDATA         PIC X(10000).
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *    シェル用領域
      *****COPY    "CPCOMMONSHELL.INC".
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).    
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-PRT             PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PRTDATA         PIC 9(01).
           03  FLG-PRTKANRI        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN              PIC 9(04).
           03  CNT-OUT             PIC 9(10).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-HC01PARA-CNT    PIC  9(03).
      *
           03  WRK-RECEERR         PIC X(200). 
      *
           03  WRK-PATH            PIC X(64). 
      *
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-STPAGE     PIC 9(05).
           03  WRK-PARA-EDPAGE     PIC 9(05).
      *
           03  WRK-IN              PIC X(01).
      *
      *    印刷用コンスタント領域 
           COPY    "CPPRTCONST.INC".          
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY    "CPSK1031.INC".
      *
      *    印刷管理ＤＢ
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    印刷ＤＢ
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".          
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE           DIVISION
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
                   UNTIL       FLG-END     =   1
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
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           ACCEPT  SYS-TIME            FROM    TIME     
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
                                               WRK-PARA-STPAGE
                                               WRK-PARA-EDPAGE
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBPRT"       TO  JOB-PGID
           MOVE    "帳票印刷処理"  TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
      *    出力先プリンタ名割り当て情報処理
      *****PERFORM 110-SYSKANRI-HENSYU-SEC
      *
      *    印刷管理ＤＢ読み込み処理
           PERFORM 900-PRTKANRI-SELECT-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力先プリンタ名割り当て情報処理
      *****************************************************************
       110-SYSKANRI-HENSYU-SEC                   SECTION.
      *
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE    
               INITIALIZE                  SYS-1031-REC
           END-IF                                     
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    印刷用ファイル作成  
           MOVE    "HC99"          TO  HC01PARA-FORM-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  HC01PARA-TERMID
           MOVE    SYS-TIME        TO  HC01PARA-SYOHMS
           MOVE    1               TO  HC01PARA-CNT
           OPEN    OUTPUT              PRT-FILE
      *
           PERFORM                     UNTIL   FLG-PRTKANRI =   1
                                       OR      FLG-END      =   1   
      *        印刷ＤＢ編集処理
               PERFORM 900-PRTDATA-SELECT-SEC
               PERFORM                     UNTIL   FLG-PRTDATA  =   1
                                           OR      FLG-END      =   1
                   PERFORM 2001-PRTDATA-PRINT-SEC
                   PERFORM 900-PRTDATA-FET-SEC
               END-PERFORM    
               PERFORM 2003-PRTKANRI-UPD-SEC
               PERFORM 900-PRTKANRI-FET-SEC
           END-PERFORM                                
      *
           CLOSE                       PRT-FILE
      *     
      *   印刷用スクリプト処理
      *
           IF      CNT-OUT             >   ZERO
           AND     FLG-ERR             =   ZERO 
      *
               MOVE    SPACE           TO  SHELLTBL
      *        ファイルデイレクトリ位置指定
               INITIALIZE              ORCSMKPASSAREA
               MOVE    "scripts/daily/HCALL2.sh"
                                       TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *         
               MOVE    HC01PARA        TO  SHELLTBL-ARG1
               MOVE    SHELLTBL        TO  MCPDATA-REC
               MOVE    "SHELL"         TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                           MCPAREA
                                           MCPDATA-REC
           END-IF                                                
      *
           MOVE    1                   TO  FLG-END     
           .
       200-MAIN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       2001-PRTDATA-PRINT-SEC          SECTION.
      *
           MOVE    SPACE               TO  PRT-REC 
           MOVE    PRTDATA-PRTID       TO  PRT-PRTID
           IF      PRTDATA-PRTNM       =   SPACE
               MOVE    PRTKANRI-PRTNM      TO  PRT-PRTNM
           ELSE
               MOVE    PRTDATA-PRTNM       TO  PRT-PRTNM
           END-IF
           EVALUATE    PRTDATA-SITEKBN
               WHEN    "1"
               WHEN    "2"               
                   MOVE    PRTDATA-SITEKBN     TO  PRT-SITEKBN
               WHEN    OTHER
                   SET     PRTCONST-IDX        TO  1
                   SEARCH  PRTCONST-TX VARYING PRTCONST-IDX
                       AT  END
                           MOVE    "2"         TO  PRT-SITEKBN
                       WHEN    PRTCONST-PRTID (PRTCONST-IDX)
                                               =   PRTDATA-PRTID
                           MOVE    "1"         TO  PRT-SITEKBN
                   END-SEARCH
           END-EVALUATE                                                                
           MOVE    PRTDATA-PRTDATA     TO  PRT-PRTDATA
           WRITE   PRT-REC
      *
           ADD     1                   TO  CNT-OUT     
      *
           PERFORM 2002-PRTDATA-UPD-SEC
           .
       2001-PRTDATA-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷フラグセット処理
      *****************************************************************
       2002-PRTDATA-UPD-SEC          SECTION.
      *
      *    印刷フラグセット
           MOVE    "1"                 TO  PRTDATA-PRTFLG
      *
           MOVE    PRTDATA-REC         TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRTDATA-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢの更新でエラーになりました"
                                          TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
          END-IF    
           .
       2001-PRTDATA-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷フラグセット処理
      *****************************************************************
       2003-PRTKANRI-UPD-SEC          SECTION.
      *
           MOVE    "1"                 TO  PRTKANRI-PRTFLG
           MOVE    PRTKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRTKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC               =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷管理ＤＢの更新でエラーになりました"
                                        TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF    
           .
       2003-PRTKANRI-UPD-EXT.
           EXIT.
      *
057400*
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *         
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *
           MOVE    1                   TO  FLG-END
                                           FLG-ERR
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-OUT         TO  JOB-UPDCNT                        
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           DISPLAY "*** ORCBPRT IN  "  CNT-IN
           DISPLAY "*** ORCBPRT OUT "  CNT-OUT
      **** DISPLAY "*** ORCBPRT END ***"
      *****ACCEPT WRK-IN
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷管理ＤＢ読み込み
      *****************************************************************
       900-PRTKANRI-SELECT-SEC          SECTION.
      *
           INITIALIZE                      PRTKANRI-REC
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  PRTKANRI-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  PRTKANRI-TBL-GROUP
           MOVE    PRTKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRTKANRI-KEY2
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               PERFORM 900-PRTKANRI-FET-SEC
           ELSE 
               MOVE    1                   TO  FLG-PRTKANRI
                                               FLG-END
           END-IF
           .
       900-PRTKANRI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷管理ＤＢ読み込み
      *****************************************************************
       900-PRTKANRI-FET-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    PATH-TBL-PRTKANRI-KEY2
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *                                  
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRTKANRI-REC
               IF      LNK-PRTKANRI-RENNUM  =   ZERO
                   CONTINUE
               ELSE
                   IF      LNK-PRTKANRI-RENNUM   NOT = 
                                           PRTKANRI-RENNUM
                       GO  TO  900-PRTKANRI-FET-SEC
                   END-IF
               END-IF                                             
               IF      LNK-PRTKANRI-SHORI-RENNUM   =   ZERO
                   CONTINUE
               ELSE
                   IF      LNK-PRTKANRI-SHORI-RENNUM   NOT = 
                                           PRTKANRI-SHORI-RENNUM
                       GO  TO  900-PRTKANRI-FET-SEC
                   END-IF
               END-IF                                             
               MOVE    ZERO                TO  FLG-PRTKANRI
                                               FLG-END
           ELSE
               MOVE    1                   TO  FLG-PRTKANRI
                                               FLG-END 
           END-IF
           .
       900-PRTKANRI-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷ＤＢ読み込み
      *****************************************************************
       900-PRTDATA-SELECT-SEC          SECTION.
      *
           INITIALIZE                      PRTDATA-REC
           MOVE    PRTKANRI-RENNUM     TO  PRTDATA-RENNUM
           MOVE    PRTKANRI-SHORI-RENNUM
                                       TO  PRTDATA-SHORI-RENNUM
           MOVE    PRTKANRI-TBL-GROUP  TO  PRTDATA-TBL-GROUP
           MOVE    PRTKANRI-TBL-KEY    TO  PRTDATA-TBL-KEY
           MOVE    WRK-PARA-STPAGE     TO  PRTDATAXX-STPAGE
           MOVE    WRK-PARA-EDPAGE     TO  PRTDATAXX-EDPAGE
      *
           MOVE    PRTDATA-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRTDATA-KEY2
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               PERFORM 900-PRTDATA-FET-SEC
           ELSE 
               MOVE    1                   TO  FLG-PRTDATA
           END-IF
           .
       900-PRTDATA-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷ＤＢ読み込み
      *****************************************************************
       900-PRTDATA-FET-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    PATH-TBL-PRTDATA-KEY2
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *                                  
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRTDATA-REC
               ADD     1                   TO  CNT-IN
               MOVE    ZERO                TO  FLG-PRTDATA
           ELSE  
               MOVE    1                   TO  FLG-PRTDATA
           END-IF 
           .
       900-PRTDATA-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    LNK-PRTKANRI-SRYYM  TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2) 
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       800-SYSKANRI-READ-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
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
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
