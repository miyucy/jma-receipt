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
       PROGRAM-ID.                 ORCGR99.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト
      *  コンポーネント名  : 処理結果
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    02.08.30  タイマー機能の追加
      *
      *  01.01.01    NACL-藤原    02/09/24  ２００２．１０改正対応
      *　入院機能追加　
      *  01.02.01    NACL-藤原    02/12/13  入外区分追加 
      *
      *  ２００３．４改正対応
      *  01.03.01    NACL-藤原    03/04/17  対象がないときエラーを表示する
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
       01  SPA-RECE07-REC. 
           COPY    "CPRCF007.INC"  REPLACING  //RECE07//
                                   BY         //SPA-RECE07//.
      *
      *   
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    レセプト作成指示共通パラメタ
           COPY    "R01COMMON-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE07          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
       01  WRK-AREA.
           03  WRK-PAGE            PIC ZZZZ9.
      *
           03  WRK-PATH            PIC X(64).      
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
      *    ジョブ管理ＤＢのキー値（作成処理）  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "RECEPT1".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
      *    ジョブ管理ＤＢのキー値（印刷処理）  
           03  WRK-CONS-JOB-SHELLID1
                                   PIC X(08)   VALUE   "RECEPT2".
           03  WRK-CONS-JOB-JOBID1 PIC 9(07)   VALUE   1.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    レセプト管理     
       01  RECE07-REC. 
           COPY    "CPRCF007.INC".
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
           COPY    "R01.INC".
           COPY    "R02.INC".
           COPY    "R03.INC".
           COPY    "R04.INC".
           COPY    "R98.INC".
           COPY    "R99.INC".
           COPY    "RERR.INC".
           COPY    "RID1.INC".
           COPY    "RID2.INC".
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
           MOVE    SPA-WORK        TO  SPA-R01KYOUTU
      * 
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN      OTHER
                   PERFORM 200-GMNSENI
           END-EVALUATE
      *
           MOVE    SPA-R01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
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
      *    印刷画面へ
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 4501-NEXT-GMN-SEC
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
           MOVE    SPACE               TO  SPA-R99-FLG
      *     
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG
           MOVE    "R99"               TO  SPA-MOTOPG
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
           MOVE    SPACE               TO  R99
                         
           MOVE    ZERO                TO  R99-COUNT
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           IF      SPA-R01-GMNKBN  =   "R02"  OR  "R04"
               MOVE    WRK-CONS-JOB-JOBID1
                                       TO  JOB-JOBID
               MOVE    WRK-CONS-JOB-SHELLID1
                                       TO  JOB-SHELLID
           ELSE
               MOVE    WRK-CONS-JOB-JOBID
                                       TO  JOB-JOBID
               MOVE    WRK-CONS-JOB-SHELLID
                                       TO  JOB-SHELLID
           END-IF
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC 
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               MOVE    1               TO  IDX                    
               MOVE    JOB-JOBID       TO  R99-RENNUM   (IDX)
               MOVE    JOB-SHELLMSG    TO  R99-SHORINM  (IDX)
               MOVE    JOB-STARTTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-STARTTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-STARTTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  R99-STARTTIME(IDX)
               MOVE    JOB-ENDTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-ENDTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-ENDTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  R99-ENDTIME  (IDX)
               MOVE    JOB-YOBI        TO  R99-ERRMSG   (IDX)
               IF      SPA-R01-GMNKBN  =   "R02"  OR  "R04"
                   COMPUTE R99-PROGRESSBAR-VALUE  =
                           JOB-STEPCNT  /   2      *   100
               ELSE
                   COMPUTE R99-PROGRESSBAR-VALUE  =
                           JOB-STEPCNT  /   13     *   100
               END-IF
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "処理中です"    TO  R99-MSG
               ELSE
                   IF      JOB-ERRCD       =   SPACE
                       IF      SPA-R01-GMNKBN  =   "R02"   OR  "R04"
                           CONTINUE
                       ELSE
                           IF      JOB-UPDCNT      =   ZERO    
                               MOVE    "対象データがありませんでした"
                                                       TO  R99-MSG
                           ELSE
                               PERFORM 4501-REPRINT-CHK-SEC
                               IF      SPA-RECE07-PRTID    =   SPACE
                                   MOVE    
                                   "対象のレセプトが作成されていません"
                                               TO  R99-MSG
                               ELSE                    
                                   MOVE    SPA-RECE07-KEY
                                           TO  SPA-R01-RECE07-KEY
                                   MOVE    SPA-RECE07-RECEKBN
                                           TO  SPA-R01-RECE07-RECEKBN
                                   MOVE    SPA-RECE07-SRYYM
                                           TO  SPA-R01-RECE07-SRYYM
                                   MOVE    SPA-RECE07-NYUGAIKBN
                                           TO  SPA-R01-RECE07-NYUGAIKBN
                               END-IF
                           END-IF   
                       END-IF
                   ELSE
                       STRING  JOB-YOBI    DELIMITED  BY  SPACE
                               "【"        DELIMITED  BY  SIZE
                              JOB-SHELLMSG DELIMITED  BY  SPACE
                              "】"         DELIMITED  BY  SIZE      
                                           INTO  R99-MSG
                   END-IF                          
               END-IF    
               MOVE    IDX                     TO  R99-COUNT    
           END-IF
      *     
           MOVE    WIDGET-INSENSITIVE   TO  R99-B12-STATE
           IF      R99-MSG              =   SPACE
               IF      R99-COUNT            >   ZERO    
                   IF      SPA-R01-GMNKBN  =   "R02"   OR  "R04"
                       IF      JOB-UPDCNT           =   ZERO
                           MOVE    "該当のレセプトはありませんでした"
                                                TO  R99-MSG
                       ELSE
                           MOVE    JOB-UPDCNT           TO  WRK-PAGE
                           STRING
                               "処理は正常に終了しました　処理枚数は"
                                                    DELIMITED  BY  SIZE
                                   WRK-PAGE         DELIMITED  BY  SIZE
                                   "枚です"         DELIMITED  BY  SIZE
                                                    INTO  R99-MSG
                           END-STRING
                       END-IF
                   ELSE
                       MOVE    "処理は正常に終了しました"
                                                    TO  R99-MSG
                   END-IF
                   MOVE   100                   TO
                                            R99-PROGRESSBAR-VALUE                             
                   IF      SPA-R01-GMNKBN  =   "R02"   OR  "R04"
                       MOVE    "B01"                TO  MCP-WIDGET
                   ELSE
                       MOVE    WIDGET-NORMAL        TO  R99-B12-STATE
                       MOVE    "B12"                TO  MCP-WIDGET
                   END-IF 
               ELSE
                   MOVE    "B01"                TO  MCP-WIDGET
                   MOVE    "該当する処理はありません"
                                                TO  R99-MSG
               END-IF                                 
           ELSE                                        
               MOVE    "B11"                TO  MCP-WIDGET
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE
           MOVE    "R99    "           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    再印刷チェック処理
      *****************************************************************
       4501-REPRINT-CHK-SEC         SECTION.
      *
           INITIALIZE              SPA-RECE07-KEY
                                   SPA-RECE07-RECEKBN
                                   SPA-RECE07-NYUGAIKBN
                                   SPA-RECE07-SRYYM
      *
      *
           INITIALIZE                  RECE07-REC
           IF      SPA-R01-RECEKBN     =   "0" OR  "1" OR  "2"
               MOVE    "HC06"              TO  RECE07-PRTID
           ELSE
               IF      SPA-R01-RECEKBN     =   "3"
                   MOVE    "HC21"              TO  RECE07-PRTID
               END-IF
               IF      SPA-R01-RECEKBN     =   "4"
                   MOVE    "HC23"              TO  RECE07-PRTID
               END-IF
           END-IF            
           IF      SPA-R01-FILEKBN         =   "1"
               MOVE    SPA-R01-SRYYM       TO  RECE07-SRYYM
               MOVE    "1"                 TO  RECE07-SYOKBN
      *********MOVE    "2"                 TO  RECE07-NYUGAIKBN
               MOVE    SPA-R01-NYUGAIKBN   TO  RECE07-NYUGAIKBN
               MOVE    SPA-R01-RECEKBN     TO  RECE07-RECEKBN
               MOVE    "RECEKANRI-KEY7"    TO  WRK-PATH
           ELSE
      *********MOVE    ZERO                TO  RECE07-SRYYM
               MOVE    "2"                 TO  RECE07-SYOKBN
               MOVE    SPA-R01-NYUGAIKBN   TO  RECE07-NYUGAIKBN
      *********MOVE    "RECEKANRI-KEY2"    TO  WRK-PATH
               MOVE    "RECEKANRI-KEY5"    TO  WRK-PATH
           END-IF
           MOVE    RECE07-REC          TO  MCPDATA-REC
           PERFORM 900-RECE07-INV-SEC
           IF      FLG-RECE07          =   ZERO
               MOVE    RECE07-KEY          TO  SPA-RECE07-KEY
               MOVE    RECE07-RECEKBN      TO  SPA-RECE07-RECEKBN
               MOVE    RECE07-SRYYM        TO  SPA-RECE07-SRYYM
               MOVE    RECE07-NYUGAIKBN    TO  SPA-RECE07-NYUGAIKBN
           END-IF
      *
           .
       4501-REPRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       4501-NEXT-GMN-SEC            SECTION.
      *
           MOVE    "OK"                TO  SPA-R99-FLG
      *     
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG
           MOVE    "R99"               TO  SPA-MOTOPG
      *
           MOVE    "JOIN"              TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       4501-NEXT-GMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト管理読込（キー）
      *****************************************************************
       900-RECE07-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
      *****MOVE    "RECEKANRI-KEY2"    TO  ORC-DBPATH
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
      **********MOVE    "RECEKANRI-KEY2"    TO  ORC-DBPATH
                MOVE    WRK-PATH            TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-RECE07
                   MOVE    MCPDATA-REC         TO  RECE07-REC
               ELSE
                   MOVE    1                   TO  FLG-RECE07
               END-IF
           ELSE
               MOVE    1                   TO  FLG-RECE07
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
      *****MOVE    "RECEKANRI-KEY2"    TO  ORC-DBPATH
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-RECE07-INV-EXT.
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
