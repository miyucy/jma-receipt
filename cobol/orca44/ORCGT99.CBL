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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGT99.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 総括・請求書
      *  コンポーネント名  : 処理結果
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    03.07.05  タイマー機能の追加
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-T01.
           03  SPA-T01-AREA.
               05  SPA-GMN-MAX                     PIC 9(04).
               05  SPA-GMN-PAGE                    PIC 9(02).
               05  SPA-GMN-CUR                     PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SKYYM               PIC X(07).
                   07  SPA-GMN-SRYYM               PIC X(20).
                   07  SPA-GMN-SKYYMD              PIC X(10).
                   07  SPA-GMN-PRTKBN1.
                       09  SPA-GMN-PRTKBN1-STYLE   PIC X(20).
                       09  SPA-GMN-PRTKBN1-VALUE   PIC X(04). 
                   07  SPA-GMN-PRTKBN2.
                       09  SPA-GMN-PRTKBN2-STYLE   PIC X(20).
                       09  SPA-GMN-PRTKBN2-VALUE   PIC X(04). 
                   07  SPA-GMN-HKNJANUM            PIC X(08).
                   07  SPA-GMN-HKNJAMEI            PIC X(40). 
      *
               05  SPA-NAIB-T01-AREA.
                   07  SPA-NAI-SKYYM               PIC 9(06).
                   07  SPA-NAI-SRYYM               PIC 9(06).
                   07  SPA-NAI-SKYYMD              PIC 9(08).
                   07  SPA-NAI-PRTKBN1             PIC X(01).
                   07  SPA-NAI-PRTKBN2             PIC X(01). 
                   07  SPA-NAI-HKNJANUM            PIC X(08). 
      *
               05  SPA-STATE.             
                   07  SPA-SRYYM-STATE             PIC S9(09)  BINARY.
                   07  SPA-DATAKBN1-STATE          PIC S9(09)  BINARY.
                   07  SPA-DATAKBN2-STATE          PIC S9(09)  BINARY.
                   07  SPA-DATAKBN3-STATE          PIC S9(09)  BINARY.
                   07  SPA-DATAKBN4-STATE          PIC S9(09)  BINARY.
                   07  SPA-DATAKBN5-STATE          PIC S9(09)  BINARY.
      *
               05  SPA-DATAKBN.         
                   07  SPA-DATAKBN1-VALUE          PIC X(01).
                   07  SPA-DATAKBN2-VALUE          PIC X(01).
                   07  SPA-DATAKBN3-VALUE          PIC X(01).
                   07  SPA-DATAKBN4-VALUE          PIC X(01).
                   07  SPA-DATAKBN5-VALUE          PIC X(01).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
       01  WRK-AREA.
           03  WRK-PAGE            PIC ZZZZZZZZZ9.
      *     
       01  WRK-HEN-AREA.
           03  WRK-HENTIME.
               05  WRK-HH          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-MM          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-SS          PIC X(02).
      *
       01  WRK-CONS-AREA.
      *    システム管理ＤＢ（３００３）のキー値  
           03  WRK-CONS-3003-KBNCD PIC X(08)   VALUE   "044".
      *    印刷管理ＤＢのキー値  
           03  WRK-CONS-PRTKANRI-TBL-KEY
                                   PIC X(08)   VALUE   "SOKATU".
           03  WRK-CONS-PRTKANRI-TBL-GROUP
                                   PIC X(14)   VALUE   SPACE.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "SOKATU".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   ZERO.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
           COPY    "CPSK3003.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "T01.INC".
           COPY    "T99.INC".
           COPY    "TERR.INC".
           COPY    "TID1.INC".
           COPY    "TID2.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-T01
      * 
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN      OTHER
                   PERFORM 200-GMNSENI
           END-EVALUATE
      *
           MOVE    SPA-AREA        TO  SPA-COMMON
      *****MOVE    SPA-T01         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      * 
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *    処理状態
               WHEN    "CLICKED"       ALSO    "pandatimer1"
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-KAKUNIN-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG
           MOVE    "T99"               TO  SPA-MOTOPG
      *
           MOVE    "JOIN"              TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
           MOVE    SPACE               TO  T99
           MOVE    ZERO                TO  T99-COUNT
      *        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-NAI-SKYYM       TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC 
                   IF      SJOBKANRI-RETURN    =   ZERO
                       MOVE    JOB-JOBID       TO  T99-RENNUM   (IDX)
                       MOVE    JOB-SHELLMSG    TO  T99-SHORINM  (IDX)
                       MOVE    JOB-STARTTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-STARTTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-STARTTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  T99-STARTTIME(IDX)
                       MOVE    JOB-ENDTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-ENDTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-ENDTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  T99-ENDTIME  (IDX)
                       MOVE    JOB-UPDCNT      TO  WRK-PAGE
                       MOVE    WRK-PAGE        TO  T99-PAGE     (IDX)
                       MOVE    JOB-YOBI        TO  T99-ERRMSG   (IDX)
                       IF      JOB-ENDYMD      =   SPACE
                           MOVE    "処理中です"    TO  T99-MSG
                       ELSE
                           IF      JOB-ERRCD       =   SPACE
                               CONTINUE
                           ELSE
                               STRING  JOB-YOBI    DELIMITED  BY  SPACE
                                       "【"        DELIMITED  BY  SIZE
                                      JOB-SHELLMSG DELIMITED  BY  SPACE
                                      "】"         DELIMITED  BY  SIZE      
                                                   INTO  T99-MSG
                           END-IF                          
                       END-IF    
                       MOVE    IDX                     TO  T99-COUNT    
                   END-IF
               END-PERFORM
           END-IF
           IF      T99-MSG              =   SPACE
               MOVE    "B01"                TO  MCP-WIDGET
               IF      T99-COUNT            >   ZERO    
                   MOVE    "処理は正常に終了しました"
                                                TO  T99-MSG
               ELSE
                   MOVE    "該当する処理はありません"
                                                TO  T99-MSG
               END-IF                                 
           ELSE                                        
               MOVE    "B11"                TO  MCP-WIDGET
           END-IF                                 
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE
           MOVE    "T99    "           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
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
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
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
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
