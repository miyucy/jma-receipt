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
      *
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCGW99.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : ＣＬＡＩＭ接続情報（Ｗ９９）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
　
      *    画面用ＳＰＡ
       01  SPA-W99.
           03  SPA-W99-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD       PIC X(09).
                   07  SPA-GMN-EDYUKYMD       PIC X(09).              
      *
                   07  SPA-GMN-UKEBUTTON-G.
                       09  SPA-GMN-UKEBUTTON  PIC X(01) OCCURS 2.
                   07  SPA-GMN-KANBUTTON-G.
                       09  SPA-GMN-KANBUTTON  PIC X(01) OCCURS 2.
                   07  SPA-GMN-SYNBUTTON-G.
                       09  SPA-GMN-SYNBUTTON  PIC X(01) OCCURS 2.
      *                                        
                   07  SPA-GMN-SETUZOKU-G.   
                       09  SPA-GMN-SETUZOKU
                                              PIC X(01).
                       09  SPA-GMN-F1         PIC X(01).
                       09  SPA-GMN-SETUZOKUMEI
                                              PIC X(18).
      *                                        
                   07  SPA-GMN-SCODE-G.
                       09  SPA-GMN-SCODE
                                              PIC X(01).
                       09  SPA-GMN-F1         PIC X(01).
                       09  SPA-GMN-SCODEMEI
                                              PIC X(18).
      *                                        
                   07  SPA-GMN-SETUZOKULST      OCCURS  2.
                       09  SPA-GMN-SETUZOKUL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SETUZOKUMEIL
                                              PIC X(18).
                   07  SPA-GMN-SETUZOKU-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-SCODELST          OCCURS  3.
                       09  SPA-GMN-SCODEL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SCODEMEIL
                                              PIC X(18).
                   07  SPA-GMN-SCODE-MAX     PIC 9(02).    
      *
                   07  SPA-GMN-TBL.            
                       09  SPA-GMN-TBL-G      OCCURS  10.
                           11  SPA-GMN-TADDRESS-G.
                               13  SPA-GMN-SADDRESS
                                              PIC X(40).
                               13  SPA-GMN-SPORT1
                                              PIC X(05).
                               13  SPA-GMN-SPORT2
                                              PIC X(05).
                               13  SPA-GMN-SMEMO
                                              PIC X(40).
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-STYUKYMD       PIC 9(08).
                   07  SPA-NAI-EDYUKYMD       PIC 9(08).
      *             
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBLO       OCCURS  10.
                           11  SPA-NAI-TADDRESS-G.
                               13  SPA-NAI-SADDRESS
                                              PIC X(40).
                               13  SPA-NAI-SPORT1
                                              PIC X(05).
                               13  SPA-NAI-SPORT2
                                              PIC X(05).
                               13  SPA-NAI-SMEMO
                                              PIC X(40).
      *
              05  SPA-NAI-SELNO               PIC 9(03).
      *
           COPY    "ENUM-VALUE".
      *
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    カウント領域
      *
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
      *
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
      *
       01  WRK-AREA.
           03  WRK-PATH            PIC X(64).
           03  WRK-SELNO           PIC 9(03).
           03  WRK-NUM             PIC 9(02).
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-WIDMSG          PIC X(70). 
           03  WRK-YMD             PIC X(09). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
       01  WRK-ADDRESS.
           03  WRK-ADDRESS1        PIC X(08).
           03  WRK-ADDRESS2        PIC 9(02).
       01  WRK-PORT.
           03  WRK-PORT1           PIC X(05).
           03  WRK-PORT2           PIC 9(02).
       01  WRK-MEMO.
           03  WRK-MEMO1           PIC X(05).
           03  WRK-MEMO2           PIC 9(02).
      *
       01  WRK-CONS-LINE-MAX       PIC 9(02)   VALUE   10.
       01  WRK-KBNCD               PIC 9(02).
      *               
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    ＣＬＡＩＭ医療機関情報
           COPY  "CPSK9000.INC".
      *    ＣＬＡＩＭ接続設定情報
           COPY  "CPSK9001.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *    日付サブルーチン領域
      *
           COPY  "CPORCSDAY.INC".
      *
           COPY  "CPORCSLNK.INC".
      *     
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           COPY    "W01.INC".
           COPY    "W02.INC".
           COPY    "W03.INC".
           COPY    "W04.INC".
           COPY    "W05.INC".
           COPY    "W06.INC".
           COPY    "W07.INC". 
           COPY    "W08.INC". 
           COPY    "W09.INC".
           COPY    "W10.INC".
           COPY    "W11.INC".
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W99
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"          ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-W99         TO  SPA-FREE
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK 
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "WERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               PERFORM 510-GSRAUTH-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      * 
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W99"                TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                    TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
               WHEN    "WID1"
                   PERFORM 330-WID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF      SPA-WID1-FLG    =   "OK"
               PERFORM 490-KOUSHIN-SEC
           END-IF
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD      
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE   SPA-W99-AREA
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
      *     
           MOVE    "0"                 TO  SPA-GMN-SETUZOKUL    (1)
           MOVE    "しない"            TO  SPA-GMN-SETUZOKUMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-SETUZOKUL    (2)
           MOVE    "する"              TO  SPA-GMN-SETUZOKUMEIL (2)
           MOVE    2                   TO  SPA-GMN-SETUZOKU-MAX 
      *     
           MOVE    "1"                 TO  SPA-GMN-SCODEL      (1)
           MOVE    "ＥＵＣ"            TO  SPA-GMN-SCODEMEIL   (1)
           MOVE    "2"                 TO  SPA-GMN-SCODEL      (2)
           MOVE    "Ｓ−ｊｉｓ"        TO  SPA-GMN-SCODEMEIL   (2)
           MOVE    "3"                 TO  SPA-GMN-SCODEL      (3)
           MOVE    "ＵＴＦ−８"        TO  SPA-GMN-SCODEMEIL   (3)
           MOVE    3                   TO  SPA-GMN-SCODE-MAX 
      * 
           MOVE    SPACE               TO  SYS-9000-REC
           INITIALIZE                      SYS-9000-REC
           MOVE    "9000"              TO  SYS-9000-KANRICD
           MOVE    "*"                 TO  SYS-9000-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-9000-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  WRK-PATH
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-9000-REC
               MOVE    SYS-9000-SETUZOKU   TO  SPA-GMN-SETUZOKU 
      *
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SETUZOKU-MAX
                 IF        SPA-GMN-SETUZOKU-G(1:1)
                                   =   SPA-GMN-SETUZOKUL (IDY)
                   MOVE    SPA-GMN-SETUZOKULST (IDY)
                                           TO  SPA-GMN-SETUZOKU-G
                   MOVE    SPA-GMN-SETUZOKU-MAX
                                           TO  IDY
                 END-IF                                     
               END-PERFORM
      *
               MOVE    SYS-9000-CODE       TO  SPA-GMN-SCODE  
      *
               PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-SCODE-MAX
                 IF        SPA-GMN-SCODE-G(1:1)
                                   =   SPA-GMN-SCODEL (IDY)
                   MOVE    SPA-GMN-SCODELST (IDY)
                                           TO  SPA-GMN-SCODE-G
                   MOVE    SPA-GMN-SCODE-MAX
                                           TO  IDY
                 END-IF                                     
               END-PERFORM
               MOVE    SYS-9000-UKEBUTTON (1)
                                       TO  SPA-GMN-UKEBUTTON (1)  
               MOVE    SYS-9000-UKEBUTTON (2)
                                       TO  SPA-GMN-UKEBUTTON (2)  
               MOVE    SYS-9000-KANBUTTON (1)
                                       TO  SPA-GMN-KANBUTTON (1)  
               MOVE    SYS-9000-KANBUTTON (2)
                                       TO  SPA-GMN-KANBUTTON (2)  
               MOVE    SYS-9000-SYNBUTTON (1)
                                       TO  SPA-GMN-SYNBUTTON (1)  
               MOVE    SYS-9000-SYNBUTTON (2)
                                       TO  SPA-GMN-SYNBUTTON (2)  
           ELSE
               MOVE    "T" 
                                       TO  SPA-GMN-UKEBUTTON (1)  
               MOVE    "F" 
                                       TO  SPA-GMN-UKEBUTTON (2)  
               MOVE    "T" 
                                       TO  SPA-GMN-KANBUTTON (1)  
               MOVE    "F" 
                                       TO  SPA-GMN-KANBUTTON (2)  
               MOVE    "T" 
                                       TO  SPA-GMN-SYNBUTTON (1)  
               MOVE    "F" 
                                       TO  SPA-GMN-SYNBUTTON (2)  
           END-IF             
      *
           MOVE    SPACE               TO  SYS-9001-REC
           INITIALIZE                      SYS-9001-REC
           MOVE    "9001"              TO  SYS-9001-KANRICD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-9001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   FLG-SYSKANRI   =   1
                               OR      IDX            >= 
                                                  WRK-CONS-LINE-MAX
               MOVE    MCPDATA-REC        TO  SYS-9001-REC
               ADD     1              TO  IDX
               MOVE    SYS-9001-ADDRESS 
                                       TO  SPA-GMN-SADDRESS (IDX)  
               MOVE    SYS-9001-PORT1 
                                       TO  SPA-GMN-SPORT1 (IDX)  
               MOVE    SYS-9001-PORT2 
                                       TO  SPA-GMN-SPORT2 (IDX)  
               MOVE    SYS-9001-MEMO 
                                       TO  SPA-GMN-SMEMO (IDX)  
      *
               MOVE    "SYSKANRI-KEY5"    TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *                                  
           MOVE    IDX                 TO  SPA-GMN-MAX
      *
           MOVE    1                    TO  SPA-GMN-CUR
           . 
       31O-SPASET-EXT.
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
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *    受付ボタン処理
               WHEN    "CLICKED"       ALSO    "UKEBUTTON1"
               WHEN    "CLICKED"       ALSO    "UKEBUTTON2"
                   PERFORM 430-UKEBUTTON-SEC
      *    患者登録ボタン処理
               WHEN    "CLICKED"       ALSO    "KANBUTTON1"
               WHEN    "CLICKED"       ALSO    "KANBUTTON2"
                   PERFORM 440-KANBUTTON-SEC
      *    診療行為ボタン処理
               WHEN    "CLICKED"       ALSO    "SYNBUTTON1"
               WHEN    "CLICKED"       ALSO    "SYNBUTTON2"
                   PERFORM 450-SYNBUTTON-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"      ALSO    "SETUZOKU"
                   PERFORM 4100-SETUZOKU-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SCODE"
                   PERFORM 4101-CODE-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SADDRESS01"
               WHEN    "ACTIVATE"      ALSO    "SADDRESS02"
               WHEN    "ACTIVATE"      ALSO    "SADDRESS03"
               WHEN    "ACTIVATE"      ALSO    "SADDRESS04"
               WHEN    "ACTIVATE"      ALSO    "SADDRESS05"
               WHEN    "ACTIVATE"      ALSO    "SADDRESS06"
               WHEN    "ACTIVATE"      ALSO    "SADDRESS07"
               WHEN    "ACTIVATE"      ALSO    "SADDRESS08"
               WHEN    "ACTIVATE"      ALSO    "SADDRESS09"
               WHEN    "ACTIVATE"      ALSO    "SADDRESS10"
                   MOVE MCP-WIDGET     TO      WRK-ADDRESS
                   MOVE WRK-ADDRESS2   TO      IDX
                   PERFORM 4102-ADDRESS-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SPORT01_1"
               WHEN    "ACTIVATE"      ALSO    "SPORT02_1"
               WHEN    "ACTIVATE"      ALSO    "SPORT03_1"
               WHEN    "ACTIVATE"      ALSO    "SPORT04_1"
               WHEN    "ACTIVATE"      ALSO    "SPORT05_1"
               WHEN    "ACTIVATE"      ALSO    "SPORT06_1"
               WHEN    "ACTIVATE"      ALSO    "SPORT07_1"
               WHEN    "ACTIVATE"      ALSO    "SPORT08_1"
               WHEN    "ACTIVATE"      ALSO    "SPORT09_1"
               WHEN    "ACTIVATE"      ALSO    "SPORT10_1"
                   MOVE MCP-WIDGET     TO      WRK-PORT
                   MOVE WRK-PORT2      TO      IDX
                   PERFORM 4103-PORT1-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SPORT01_2"
               WHEN    "ACTIVATE"      ALSO    "SPORT02_2"
               WHEN    "ACTIVATE"      ALSO    "SPORT03_2"
               WHEN    "ACTIVATE"      ALSO    "SPORT04_2"
               WHEN    "ACTIVATE"      ALSO    "SPORT05_2"
               WHEN    "ACTIVATE"      ALSO    "SPORT06_2"
               WHEN    "ACTIVATE"      ALSO    "SPORT07_2"
               WHEN    "ACTIVATE"      ALSO    "SPORT08_2"
               WHEN    "ACTIVATE"      ALSO    "SPORT09_2"
               WHEN    "ACTIVATE"      ALSO    "SPORT10_2"
                   MOVE MCP-WIDGET     TO      WRK-PORT
                   MOVE WRK-PORT2      TO      IDX
                   PERFORM 4104-PORT2-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SMEMO01"
               WHEN    "ACTIVATE"      ALSO    "SMEMO02"
               WHEN    "ACTIVATE"      ALSO    "SMEMO03"
               WHEN    "ACTIVATE"      ALSO    "SMEMO04"
               WHEN    "ACTIVATE"      ALSO    "SMEMO05"
               WHEN    "ACTIVATE"      ALSO    "SMEMO06"
               WHEN    "ACTIVATE"      ALSO    "SMEMO07"
               WHEN    "ACTIVATE"      ALSO    "SMEMO08"
               WHEN    "ACTIVATE"      ALSO    "SMEMO09"
               WHEN    "ACTIVATE"      ALSO    "SMEMO10"
                   MOVE MCP-WIDGET     TO      WRK-MEMO
                   MOVE WRK-MEMO2      TO      IDX
                   PERFORM 4105-MEMO-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *   受付ボタン処理 
      *****************************************************************
       430-UKEBUTTON-SEC           SECTION.
      *
           MOVE    W99-UKEBUTTON1         TO  SPA-GMN-UKEBUTTON (1) 
           MOVE    W99-UKEBUTTON2         TO  SPA-GMN-UKEBUTTON (2) 
      *
           MOVE    5                      TO  SPA-GMN-CUR
      *
           .
       430-UKEBUTTON-SEC-EXT.
           EXIT.
      *
      *****************************************************************
      *   患者登録ボタン処理 
      *****************************************************************
       440-KANBUTTON-SEC           SECTION.
      *
           MOVE    W99-KANBUTTON1         TO  SPA-GMN-KANBUTTON (1) 
           MOVE    W99-KANBUTTON2         TO  SPA-GMN-KANBUTTON (2) 
      *
           MOVE    7                      TO  SPA-GMN-CUR
      *
           .
       440-KANBUTTON-SEC-EXT.
           EXIT.
      *
      *****************************************************************
      *   診療行為ボタン処理 
      *****************************************************************
       450-SYNBUTTON-SEC           SECTION.
      *
           MOVE    W99-SYNBUTTON1         TO  SPA-GMN-SYNBUTTON (1) 
           MOVE    W99-SYNBUTTON2         TO  SPA-GMN-SYNBUTTON (2) 
      *
           MOVE    9                      TO  SPA-GMN-CUR
      *
           .
       450-SYNBUTTON-SEC-EXT.
           EXIT.
      *****************************************************************
      *   ＩＰアドレス入力チェック処理 
      *****************************************************************
       4102-ADDRESS-CHK-SEC       SECTION.
      *
           COMPUTE SPA-GMN-CUR            =   9  +  4 * (IDX  - 1)
      *
           MOVE    W99-ADDRESS (IDX)      TO  SPA-GMN-SADDRESS (IDX) 
      *    半角チェック
           IF      SPA-GMN-SADDRESS (IDX) NOT =   SPACE     
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-SADDRESS (IDX)
                                           TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "1"
                   MOVE    KANACHK-OUT-INPUT
                                           TO  SPA-GMN-SADDRESS (IDX) 
               ELSE
                   MOVE    "0004"          TO  SPA-ERRCD
                   GO  TO  4102-ADDRESS-CHK-EXT
               END-IF
           ELSE
                   MOVE    49              TO  SPA-GMN-CUR
                   GO  TO  4102-ADDRESS-CHK-EXT
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               COMPUTE SPA-GMN-CUR         =   9  +  4 * (IDX  - 1)
                                           +   1 
           END-IF
           .
       4102-ADDRESS-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *   ポート１入力チェック処理 
      *****************************************************************
       4103-PORT1-CHK-SEC          SECTION.
      *
           COMPUTE SPA-GMN-CUR            =   10 +  4 * (IDX  - 1)
      *
           MOVE    W99-PORT1 (IDX)        TO  SPA-GMN-SPORT1 (IDX) 
      *    半角チェック
           IF      SPA-GMN-SPORT1 (IDX) NOT =   SPACE     
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-SPORT1 (IDX)
                                           TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "1"
                   MOVE    KANACHK-OUT-INPUT
                                           TO  SPA-GMN-SPORT1 (IDX) 
               ELSE
                   MOVE    "0004"              TO  SPA-ERRCD
                   GO  TO  4103-PORT1-CHK-EXT
               END-IF
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               COMPUTE SPA-GMN-CUR         =   10  +  4 * (IDX  - 1)
                                           +   1 
           END-IF
           .
       4103-PORT1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *   ポート２入力チェック処理 
      *****************************************************************
       4104-PORT2-CHK-SEC          SECTION.
      *
           COMPUTE SPA-GMN-CUR            =   11 +  4 * (IDX  - 1)
      *
           MOVE    W99-PORT2 (IDX)        TO  SPA-GMN-SPORT2 (IDX) 
      *    半角チェック
           IF      SPA-GMN-SPORT2 (IDX) NOT =   SPACE     
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-SPORT2 (IDX)
                                           TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "1"
                   MOVE    KANACHK-OUT-INPUT
                                           TO  SPA-GMN-SPORT2 (IDX) 
               ELSE
                   MOVE    "0004"              TO  SPA-ERRCD
                   GO  TO  4104-PORT2-CHK-EXT
               END-IF
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               COMPUTE SPA-GMN-CUR         =   11  +  4 * (IDX  - 1)
                                           +   1 
           END-IF
           .
       4104-PORT2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *   メモ入力チェック処理 
      *****************************************************************
       4105-MEMO-CHK-SEC       SECTION.
      *
           COMPUTE SPA-GMN-CUR            =   12 +  4 * (IDX  - 1)
      *
           MOVE    W99-MEMO (IDX)         TO  SPA-GMN-SMEMO (IDX) 
      *    半角チェック
           IF      SPA-GMN-SMEMO (IDX)    NOT =   SPACE     
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-SMEMO(IDX)
                                           TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "2"
                   MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-SMEMO(IDX) 
               ELSE
                   MOVE    "0005"              TO  SPA-ERRCD
                   GO  TO  4105-MEMO-CHK-EXT
               END-IF
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               COMPUTE SPA-GMN-CUR         =   12  +  4 * (IDX  - 1)
                                           +   1 
           END-IF
           .
       4105-MEMO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＬＡＩＭ接続区分チェック
      *****************************************************************
       4100-SETUZOKU-CHK-SEC       SECTION.
      *
           MOVE    1                      TO  SPA-GMN-CUR
      *
           MOVE    W99-SETUZOKU           TO  SPA-GMN-SETUZOKU-G 
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-SETUZOKU-MAX
               IF      SPA-GMN-SETUZOKU
                                   =   SPA-GMN-SETUZOKUL (IDY)
                   MOVE    SPA-GMN-SETUZOKULST (IDY)
                                           TO  SPA-GMN-SETUZOKU-G
                   MOVE    SPA-GMN-SETUZOKU-MAX
                                           TO  IDY
               END-IF                                     
           END-PERFORM
      *
           IF      SPA-GMN-SETUZOKUMEI =   SPACE
               MOVE    "0001"                  TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    2                      TO  SPA-GMN-CUR
           END-IF
           .
       4100-SETUZOKU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    送信用コードチェック
      *****************************************************************
       4101-CODE-CHK-SEC       SECTION.
      *
           MOVE    2                      TO  SPA-GMN-CUR
      *
           MOVE    W99-SCODE              TO  SPA-GMN-SCODE-G  
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-SCODE-MAX
               IF      SPA-GMN-SCODE-G(1:1)
                                   =   SPA-GMN-SCODEL (IDY)
                   MOVE    SPA-GMN-SCODELST (IDY)
                                           TO  SPA-GMN-SCODE-G
                   MOVE    SPA-GMN-SCODE-MAX
                                           TO  IDY
               END-IF                                     
           END-PERFORM
      *
           IF      SPA-GMN-SCODEMEI =   SPACE
               MOVE    "0002"                  TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    3                      TO  SPA-GMN-CUR
           END-IF
           .
       4101-CODE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W99"               TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-W01KYOUTU
      *
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
      *       登録前処理
      *****************************************************************
       490-TOUROKU-SEC              SECTION.
      *
           PERFORM 4900-KANRENCHK-SEC
           IF      SPA-ERRCD        =   SPACE
              MOVE    "1001"           TO  SPA-WIDCD
           END-IF
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
      *    労災医療機関情報
           MOVE    SPACE               TO  SYS-9000-REC
           INITIALIZE                      SYS-9000-REC
           MOVE    "9000"                  TO  SYS-9000-KANRICD
           MOVE    "*"                     TO  SYS-9000-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-9000-REC            TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"          TO  WRK-PATH
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-9000-REC
           ELSE
               MOVE    SPACE                   TO  SYS-9000-REC
               INITIALIZE                      SYS-9000-REC
               MOVE    "9000"                  TO  SYS-9000-KANRICD
               MOVE    "*"                     TO  SYS-9000-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-9000-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-9000-EDYUKYMD
           MOVE    SPA-GMN-SETUZOKU        TO  SYS-9000-SETUZOKU
           MOVE    SPA-GMN-SCODE           TO  SYS-9000-CODE
           MOVE    SPA-GMN-UKEBUTTON-G     TO  SYS-9000-UKEBUTTON-G
           MOVE    SPA-GMN-KANBUTTON-G     TO  SYS-9000-KANBUTTON-G
           MOVE    SPA-GMN-SYNBUTTON-G     TO  SYS-9000-SYNBUTTON-G
           MOVE    SYS-9000-REC            TO  SYSKANRI-REC
      *     
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"                  TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-EXT
           END-IF      
      *
      *    ＣＬＡＩＭ接続設定名称削除処理
           INITIALIZE                  SYS-9001-REC
           MOVE    "9001"              TO  SYS-9001-KANRICD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-9001-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY2"     TO  WRK-PATH 
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               INITIALIZE                      SYS-9001-REC
               MOVE    "9001"                  TO  SYS-9001-KANRICD
               MOVE    SYS-9001-REC            TO  MCPDATA-REC
               MOVE    SPA-SYSYMD              TO  ORC-DBYMD
               MOVE    "DBDELETE"              TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY2"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
               IF      MCP-RC              NOT =   ZERO 
                   MOVE    "1001"                  TO  SPA-ERRCD
                   DISPLAY "SYSKANRI-KEY =>" SYS-9001-KEY 
                   GO  TO  490-KOUSHIN-EXT
               END-IF
           END-IF
      *
      *    ＣＬＡＩＭ接続設定登録処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       WRK-CONS-LINE-MAX
               IF      SPA-GMN-SADDRESS (IDX)
                                       NOT  =   SPACE   
                   INITIALIZE                  SYS-9001-REC
                   MOVE    "9001"           TO  SYS-9001-KANRICD
                   MOVE    IDX              TO  WRK-KBNCD
                   MOVE    WRK-KBNCD        TO  SYS-9001-KBNCD
                   MOVE    SPA-GMN-SADDRESS (IDX)
                                            TO  SYS-9001-ADDRESS 
                   MOVE    SPA-GMN-SPORT1 (IDX)
                                            TO  SYS-9001-PORT1 
                   MOVE    SPA-GMN-SPORT2 (IDX)
                                            TO  SYS-9001-PORT2 
                   MOVE    SPA-GMN-SMEMO (IDX)
                                            TO  SYS-9001-MEMO 
                   MOVE    SPA-W01-STYUKYMD    TO  SYS-9001-STYUKYMD
                   MOVE    SPA-W01-EDYUKYMD    TO  SYS-9001-EDYUKYMD
                   MOVE    SYS-9001-REC        TO  MCPDATA-REC
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
      *
                   IF      MCP-RC          NOT =   ZERO 
                       MOVE    "1002"              TO  SPA-ERRCD
                       DISPLAY "2002 SYSKANRI-KEY =>" SYS-9001-KEY 
                       GO  TO  490-KOUSHIN-EXT
                   END-IF
               END-IF    
           END-PERFORM
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       490-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC           SECTION.
      *
           MOVE    SPACE                TO  SPA-ERRCD
           MOVE    SPA-GMN-CUR          TO  WRK-GMN-CUR 
      *
           PERFORM 4100-SETUZOKU-CHK-SEC
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4101-CODE-CHK-SEC
           END-IF    
      *
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-GMN-CUR          TO  SPA-GMN-CUR
           END-IF             
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
           PERFORM 510-GSRAUTH-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-WIDCD       NOT =   SPACE
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W99    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE                       W99
      *
           MOVE    SPA-GMN-STYUKYMD         TO  W99-YUKOSTYMD
           MOVE    SPA-GMN-EDYUKYMD         TO  W99-YUKOEDYMD
      *
           MOVE    SPA-GMN-SETUZOKU-G       TO  W99-SETUZOKU
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SETUZOKU-MAX
               MOVE    SPA-GMN-SETUZOKULST (IDY)
                                       TO  W99-SETUZOKUL (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SETUZOKU-MAX
                                       TO  W99-SETUZOKU-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                  UNTIL   IDY     >       SPA-GMN-SCODE-MAX
               MOVE    SPA-GMN-SCODELST (IDY)
                                       TO  W99-SCODEL (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SCODE-MAX  TO  W99-SCODE-COUNT 
      *
           MOVE    SPA-GMN-SCODE-G    TO  W99-SCODE                                  
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       10 
               MOVE    SPA-GMN-SADDRESS (IDX)
                                           TO  W99-ADDRESS (IDX)
               MOVE    SPA-GMN-SPORT1(IDX)
                                           TO  W99-PORT1(IDX)
               MOVE    SPA-GMN-SPORT2(IDX)
                                           TO  W99-PORT2(IDX)
               MOVE    SPA-GMN-SMEMO(IDX)
                                           TO  W99-MEMO(IDX)
           END-PERFORM
      *
           MOVE    SPA-GMN-UKEBUTTON (1)  TO  W99-UKEBUTTON1          
           MOVE    SPA-GMN-UKEBUTTON (2)  TO  W99-UKEBUTTON2         
           MOVE    SPA-GMN-KANBUTTON (1)  TO  W99-KANBUTTON1          
           MOVE    SPA-GMN-KANBUTTON (1)  TO  W99-KANBUTTON1          
           MOVE    SPA-GMN-SYNBUTTON (2)  TO  W99-SYNBUTTON2         
           MOVE    SPA-GMN-SYNBUTTON (2)  TO  W99-SYNBUTTON2         
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    業務権限非活性処理
      *****************************************************************
       510-GSRAUTH-SEC             SECTION.
      *
           .
       51O-GSRAUTH-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "ＣＬＡＩＭ接続区分の入力に誤りがあります"
                                                         TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "送信用コードの入力に誤りがあります"
                                                         TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "半角で入力して下さい"
                                                         TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "半角で入力して下さい"        TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "全角で入力して下さい"        TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "数字で入力して下さい"        TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "損傷区分をこれ以上追加できません"
                                                         TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W99"                TO  SPA-MOTOPG
           MOVE    "WERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-WIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-WIDMSG
      *
           EVALUATE    SPA-WIDCD
               WHEN    "1001"
                   MOVE    "ＣＬＡＩＭ設定情報を登録します"
                                                TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W99"                TO  SPA-MOTOPG
           MOVE    "WID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-WIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理    
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
          DISPLAY "SPA-GMN-CUR = " SPA-GMN-CUR
          EVALUATE    SPA-GMN-CUR
                WHEN    1
                    MOVE  "SETUZOKU"       TO   MCP-WIDGET
                WHEN    2
                    MOVE  "SCODE"          TO   MCP-WIDGET
                WHEN    3
                    MOVE  "UKEBUTTON1"     TO   MCP-WIDGET
                WHEN    4
                    MOVE  "UKEBUTTON2"     TO   MCP-WIDGET
                WHEN    5
                    MOVE  "KANBUTTON1"     TO   MCP-WIDGET
                WHEN    6
                    MOVE  "KANBUTTON2"     TO   MCP-WIDGET
                WHEN    7
                    MOVE  "SYNBUTTON1"     TO   MCP-WIDGET
                WHEN    8
                    MOVE  "SYNBUTTON2"     TO   MCP-WIDGET
                WHEN    9
                    MOVE  "SADDRESS01"     TO   MCP-WIDGET
                WHEN    13
                    MOVE  "SADDRESS02"     TO   MCP-WIDGET
                WHEN    17
                    MOVE  "SADDRESS03"     TO   MCP-WIDGET
                WHEN    21
                    MOVE  "SADDRESS04"     TO   MCP-WIDGET
                WHEN    25
                    MOVE  "SADDRESS05"     TO   MCP-WIDGET
                WHEN    29
                    MOVE  "SADDRESS06"     TO   MCP-WIDGET
                WHEN    33
                    MOVE  "SADDRESS07"     TO   MCP-WIDGET
                WHEN    37
                    MOVE  "SADDRESS08"     TO   MCP-WIDGET
                WHEN    41
                    MOVE  "SADDRESS09"     TO   MCP-WIDGET
                WHEN    45
                    MOVE  "SADDRESS10"     TO   MCP-WIDGET
                WHEN    10
                    MOVE  "SPORT01_1"      TO   MCP-WIDGET
                WHEN    14
                    MOVE  "SPORT02_1"      TO   MCP-WIDGET
                WHEN    18
                    MOVE  "SPORT03_1"      TO   MCP-WIDGET
                WHEN    22
                    MOVE  "SPORT04_1"      TO   MCP-WIDGET
                WHEN    26
                    MOVE  "SPORT05_1"      TO   MCP-WIDGET
                WHEN    30
                    MOVE  "SPORT06_1"      TO   MCP-WIDGET
                WHEN    34
                    MOVE  "SPORT07_1"      TO   MCP-WIDGET
                WHEN    38
                    MOVE  "SPORT08_1"      TO   MCP-WIDGET
                WHEN    42
                    MOVE  "SPORT09_1"      TO   MCP-WIDGET
                WHEN    46
                    MOVE  "SPORT10_1"      TO   MCP-WIDGET
                WHEN    11
                    MOVE  "SPORT01_2"      TO   MCP-WIDGET
                WHEN    15
                    MOVE  "SPORT02_2"      TO   MCP-WIDGET
                WHEN    19
                    MOVE  "SPORT03_2"      TO   MCP-WIDGET
                WHEN    23
                    MOVE  "SPORT04_2"      TO   MCP-WIDGET
                WHEN    27
                    MOVE  "SPORT05_2"      TO   MCP-WIDGET
                WHEN    31
                    MOVE  "SPORT06_2"      TO   MCP-WIDGET
                WHEN    35
                    MOVE  "SPORT07_2"      TO   MCP-WIDGET
                WHEN    39
                    MOVE  "SPORT08_2"      TO   MCP-WIDGET
                WHEN    43
                    MOVE  "SPORT09_2"      TO   MCP-WIDGET
                WHEN    47
                    MOVE  "SPORT10_2"      TO   MCP-WIDGET
                WHEN    12
                    MOVE  "SMEMO01"        TO   MCP-WIDGET
                WHEN    16
                    MOVE  "SMEMO02"        TO   MCP-WIDGET
                WHEN    20
                    MOVE  "SMEMO03"        TO   MCP-WIDGET
                WHEN    24
                    MOVE  "SMEMO04"        TO   MCP-WIDGET
                WHEN    28
                    MOVE  "SMEMO05"        TO   MCP-WIDGET
                WHEN    32
                    MOVE  "SMEMO06"        TO   MCP-WIDGET
                WHEN    36
                    MOVE  "SMEMO07"        TO   MCP-WIDGET
                WHEN    40
                    MOVE  "SMEMO08"        TO   MCP-WIDGET
                WHEN    44
                    MOVE  "SMEMO09"        TO   MCP-WIDGET
                WHEN    48
                    MOVE  "SMEMO10"        TO   MCP-WIDGET
                WHEN    49
                    MOVE  "B12"            TO   MCP-WIDGET
            END-EVALUATE
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YMD  (1:7)  NOT NUMERIC
               INSPECT     WRK-YMD      REPLACING   ALL " " BY  "0"
               MOVE    WRK-YMD(1:1)     TO  WRK-WGO
               MOVE    WRK-YMD(2:2)     TO  WRK-WYY
               MOVE    WRK-YMD(5:2)     TO  WRK-WMM
               MOVE    WRK-YMD(8:2)     TO  WRK-WDD
           ELSE
               MOVE    WRK-YMD(1:7)     TO  WRK-WYMD
           END-IF
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY1-AREA
           MOVE    "12"                TO  LNK-DAY1-IRAI
           MOVE    ZERO                TO  LNK-DAY1-YMD
           MOVE    WRK-WYMD            TO  LNK-DAY1-YMD(2:7)
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY1-AREA
           IF      STS-DAY-RC1     NOT =   ZERO
               MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HGO
               MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
               MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
               MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    WRK-PATH            TO  ORC-DBPATH
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
           MOVE    WRK-PATH            TO  ORC-DBPATH
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
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-EXT.
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
