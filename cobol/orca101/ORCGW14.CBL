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
       IDENTIFICATION                            DIVISION.
       PROGRAM-ID.                               ORCGW14.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 県単独事業設定
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    02.08.30  印刷指示項目の追加
      *  02.00.01    NACL-多々納  02/11/14  一括入力 
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
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
       01  SPA-W14.
           03  SPA-W14-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(04).
               05  SPA-GMN-PAGE-MAX    PIC 9(02).
               05  SPA-GMN-CUR         PIC 9(03).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD    PIC X(09).
                   07  SPA-GMN-EDYUKYMD    PIC X(09).
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-TBLO            OCCURS  25.
                           11  SPA-GMN-TCD         PIC X(04).
                           11  SPA-GMN-SHELLID     PIC X(20).
                           11  SPA-GMN-SHORIMSG    PIC X(40).
                           11  SPA-GMN-CHK.
                              13  SPA-GMN-CHKFLG   PIC X(01)
                                                   OCCURS   4.
                   07  SPA-GMN-PRTKBN11    PIC X(01).
                   07  SPA-GMN-PRTKBN12    PIC X(01).
                   07  SPA-GMN-PRTKBN21    PIC X(01).
                   07  SPA-GMN-PRTKBN22    PIC X(01).
      *                                                             
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDZ1                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-WIDMSG          PIC X(70).
           03  WRK-KBNCD           PIC 9(04).
           03  WRK-IDX2            PIC 9(02).
           03  WRK-IDX3            PIC 9(03).
           03  WRK-WIDGET.
               05  WRK-WIDGET1     PIC X(07).
               05  WRK-WIDGET2     PIC 9(02).
               05                  PIC X(03). 
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
      *
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-MCP-WIDGET      PIC X(64).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
       01  WRK-CONS-LINE-MAX       PIC 9(02)   VALUE   25.              
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    県単独事業情報コード
           COPY    "CPSK3003.INC".
      *    県単独名
           COPY  "CPSK3004.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
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
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W14
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
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
           MOVE    SPA-W14         TO  SPA-FREE
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
               IF      FLG-END         =   1
                   GO  TO  100-INIT-EXT
               END-IF 
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "W14    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
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
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
      *
           INITIALIZE              SPA-W14-AREA
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       WRK-CONS-LINE-MAX
               MOVE    IDX             TO  SPA-GMN-TCD (IDX)
               MOVE    ALL "F"         TO  SPA-GMN-CHK (IDX)
           END-PERFORM
           MOVE    "T"                 TO  SPA-GMN-PRTKBN11
           MOVE    "F"                 TO  SPA-GMN-PRTKBN12             
           MOVE    "T"                 TO  SPA-GMN-PRTKBN21
           MOVE    "F"                 TO  SPA-GMN-PRTKBN22             
      *
      *    標準総括表印刷指示
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    "044"               TO  SYS-3003-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
           ELSE
               INITIALIZE                      SYS-3003-REC
           END-IF    
           IF      SYS-3003-PRTKBN1    =   SPACE
               MOVE    "T"                 TO  SPA-GMN-PRTKBN11  
               MOVE    "F"                 TO  SPA-GMN-PRTKBN12  
           ELSE
               MOVE    "F"                 TO  SPA-GMN-PRTKBN11  
               MOVE    "T"                 TO  SPA-GMN-PRTKBN12
           END-IF      
           IF      SYS-3003-PRTKBN2    =   SPACE
               MOVE    "T"                 TO  SPA-GMN-PRTKBN21  
               MOVE    "F"                 TO  SPA-GMN-PRTKBN22  
           ELSE
               MOVE    "F"                 TO  SPA-GMN-PRTKBN21  
               MOVE    "T"                 TO  SPA-GMN-PRTKBN22
           END-IF      
      * 
      *    県単独情報
           MOVE    SPACE               TO  SYS-3004-REC
           INITIALIZE                      SYS-3004-REC
           MOVE    SPA-W01-KANRICD     TO  SYS-3004-KANRICD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-3004-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           PERFORM         UNTIL   FLG-SYSKANRI   =   1
               MOVE    MCPDATA-REC         TO  SYS-3004-REC
               MOVE    SYS-3004-KBNCD(1:4) TO  IDX
               MOVE    SYS-3004-SHELLID    TO  SPA-GMN-SHELLID (IDX)
               MOVE    SYS-3004-SHORIMSG   TO  SPA-GMN-SHORIMSG(IDX)
               MOVE    SYS-3004-CHK        TO  SPA-GMN-CHK     (IDX)
      *
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    WRK-CONS-LINE-MAX   TO  SPA-GMN-MAX
      *
           COMPUTE SPA-GMN-PAGE-MAX    =   (SPA-GMN-MAX - 1)     /
                                            WRK-CONS-LINE-MAX    + 1
           MOVE    1                   TO  SPA-GMN-PAGE
           MOVE    1                   TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
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
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                           SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO      MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM  210-BACK
      *       前画面
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 430-MAEGMN-SEC
      *       次画面
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 440-ATOGMN-SEC
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 410-KAKUTEI-SEC
      *        社保印刷指示
               WHEN    "CLICKED"       ALSO    "PRTKBN11"
                   PERFORM 450-PRTKBN11-SEC
               WHEN    "CLICKED"       ALSO    "PRTKBN12"
                   PERFORM 450-PRTKBN12-SEC
      *        国保印刷指示
               WHEN    "CLICKED"       ALSO    "PRTKBN21"
                   PERFORM 450-PRTKBN21-SEC
               WHEN    "CLICKED"       ALSO    "PRTKBN22"
                   PERFORM 450-PRTKBN22-SEC
      *        処理対象
               WHEN    OTHER
                   EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET(1:6)
                       WHEN    "CLICKED"       ALSO    "CHKBTN"
                           MOVE    MCP-WIDGET          TO  WRK-WIDGET
                           MOVE    WRK-WIDGET2         TO  IDX 
                           PERFORM 420-CHKFLG-CHK-SEC
                  END-EVALUATE    
           END-EVALUATE
           .
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                             SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC       SECTION.
      *
      *    シェル名
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   25
               MOVE    W14-SHELLID (IDX)   TO  SPA-GMN-SHELLID (IDX)
           END-PERFORM
      *    処理名
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   25
               MOVE    W14-SHORIMSG(IDX)  TO  SPA-GMN-SHORIMSG (IDX)
           END-PERFORM
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC       SECTION.
      *
           PERFORM  4101-SHELLID-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM  4102-SHORIMSG-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W14"               TO  SPA-MOTOPG
      *
      ***  MOVE   "CHANGE"             TO  MCP-PUTTYPE
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
      *    シェル名入力処理
      *****************************************************************
       4101-SHELLID-CHK-SEC       SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX         >   25  )   OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF     SPA-GMN-SHELLID (IDX)    NOT =   SPACE
                   INITIALIZE                  ORCSKANACHKAREA
                   MOVE    "1"                 TO  KANACHK-SYORI
                   MOVE    SPA-GMN-SHELLID (IDX)
                                               TO  KANACHK-MAE-INPUT
                   CALL    "ORCSKANACHK"       USING
                                               ORCSKANACHKAREA
                   IF     (KANACHK-RC      NOT =   ZERO  )  OR
                          (KANACHK-SYUBETU     =   2     )
                       MOVE    "0001"          TO  SPA-ERRCD
                       COMPUTE SPA-GMN-CUR     =  (IDX   -   1)  *   6
                                               +   1
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       4101-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理名入力処理
      *****************************************************************
       4102-SHORIMSG-CHK-SEC       SECTION.
      *
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX         >   25  )   OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF     SPA-GMN-SHORIMSG (IDX)   NOT =   SPACE
                   INITIALIZE                  ORCSKANACHKAREA
                   MOVE    "1"                 TO  KANACHK-SYORI
                   MOVE    SPA-GMN-SHORIMSG (IDX)
                                               TO  KANACHK-MAE-INPUT
                   CALL    "ORCSKANACHK"       USING
                                               ORCSKANACHKAREA
                   IF     (KANACHK-RC      NOT =   ZERO  )  OR
                          (KANACHK-SYUBETU     =   1     )
                       MOVE    "0002"          TO  SPA-ERRCD
                       COMPUTE SPA-GMN-CUR     =  (IDX   -   1)  *   6
                                               +   2
                   ELSE
                       MOVE    KANACHK-OUT-INPUT
                                               TO  SPA-GMN-SHORIMSG(IDX)
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       4102-SHORIMSG-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理対象チェック処理
      *****************************************************************
       420-CHKFLG-CHK-SEC       SECTION.
      *
           MOVE    MCP-WIDGET (7:3)   TO  WRK-IDX3
           COMPUTE IDX     =   (WRK-IDX3  +   3)  /   4
           COMPUTE IDY     =    WRK-IDX3  -   (IDX    -   1)  *   4   
      *
      *****COMPUTE SPA-GMN-CUR        =  (IDX -   1)  *   6   +
           COMPUTE WRK-GMN-CUR        =  (IDX -   1)  *   6   +
                                          2   +   IDY
      *
           MOVE    W14-CHKBTN(IDX IDY)    TO  SPA-GMN-CHKFLG (IDX IDY)
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      420-CHKFLG-CHK-EXT
           END-IF
      *
      *    次のカーソル位置指定
           MOVE    WRK-GMN-CUR         TO  SPA-GMN-CUR
           IF      IDY                 <   3
               ADD     1                  TO  SPA-GMN-CUR
           ELSE
               IF      IDX                =   WRK-CONS-LINE-MAX
                   MOVE    1                  TO  SPA-GMN-CUR
               ELSE    
                   ADD     2                  TO  SPA-GMN-CUR
               END-IF    
           END-IF
           .
       420-CHKFLG-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       430-MAEGMN-SEC             SECTION.
      *
           PERFORM 4901-KANRENCHK-SEC
           IF      SPA-ERRCD      NOT =   SPACE
               GO  TO  430-MAEGMN-EXT
           END-IF
      *
           IF      SPA-GMN-PAGE       =   1
               MOVE    "0006"             TO  SPA-ERRCD
               GO  TO  430-MAEGMN-EXT
           END-IF
      *
           COMPUTE SPA-GMN-PAGE   =   SPA-GMN-PAGE    -   1
      *
      *    PERFORM 3101-SHELLID-HENSYU-SEC  
           .
       430-MAEGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       440-ATOGMN-SEC             SECTION.
      *
           PERFORM 4901-KANRENCHK-SEC
           IF      SPA-ERRCD      NOT =   SPACE
               GO  TO  440-ATOGMN-EXT
           END-IF
      *
           IF      SPA-GMN-PAGE       =   SPA-GMN-PAGE-MAX
               MOVE    "0007"             TO  SPA-ERRCD
               GO  TO  440-ATOGMN-EXT
           END-IF
           COMPUTE SPA-GMN-PAGE   =   SPA-GMN-PAGE    +   1       
      *
           .
       440-ATOGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    標準社保総括表印刷指示処理
      *****************************************************************
       450-PRTKBN11-SEC          SECTION.
      *
           MOVE    W14-PRTKBN11    TO  SPA-GMN-PRTKBN11
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           .
       450-PRTKBN11-EXT.
           EXIT.
      *
      *****************************************************************
      *    標準社保総括表印刷指示処理
      *****************************************************************
       450-PRTKBN12-SEC          SECTION.
      *
           MOVE    W14-PRTKBN12    TO  SPA-GMN-PRTKBN12
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       450-PRTKBN12-EXT.
           EXIT.
      *
      *****************************************************************
      *    標準国保総括表印刷指示処理
      *****************************************************************
       450-PRTKBN21-SEC          SECTION.
      *
           MOVE    W14-PRTKBN21    TO  SPA-GMN-PRTKBN21
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       450-PRTKBN21-EXT.
           EXIT.
      *
      *****************************************************************
      *    標準国保総括表印刷指示処理
      *****************************************************************
       450-PRTKBN22-SEC          SECTION.
      *
           MOVE    W14-PRTKBN22    TO  SPA-GMN-PRTKBN22
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       450-PRTKBN22-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定
      *****************************************************************
       410-KAKUTEI-SEC           SECTION.
      *
           PERFORM 4901-KANRENCHK-SEC
           IF      SPA-ERRCD        =   SPACE
               MOVE    "1001"           TO  SPA-WIDCD
           END-IF
           .
       410-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
      *    印刷指示    
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    "044"               TO  SYS-3003-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC
           ELSE    
               MOVE    SPACE               TO  SYS-3003-REC 
               INITIALIZE                      SYS-3003-REC
               MOVE    "3003"              TO  SYS-3003-KANRICD
               MOVE    "044"               TO  SYS-3003-KBNCD
               MOVE    ZERO                TO  SYS-3003-STYUKYMD
               MOVE    ALL "9"             TO  SYS-3003-EDYUKYMD
           END-IF    
           IF      SPA-GMN-PRTKBN11    =   "T"
               MOVE    SPACE               TO  SYS-3003-PRTKBN1
           ELSE
               MOVE    "1"                 TO  SYS-3003-PRTKBN1
           END-IF        
           IF      SPA-GMN-PRTKBN21    =   "T"
               MOVE    SPACE               TO  SYS-3003-PRTKBN2
           ELSE
               MOVE    "1"                 TO  SYS-3003-PRTKBN2
           END-IF        
      *
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"          TO  MCP-FUNC
           END-IF
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    "1003"          TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-EXT
           END-IF
      * 
      *    県単独情報
           MOVE    SPACE               TO  SYS-3004-REC
           INITIALIZE                      SYS-3004-REC
           MOVE    SPA-W01-KANRICD     TO  SYS-3004-KANRICD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-3004-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      * 
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"                  TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-EXT
           END-IF
      * 
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   IDX      >=  SPA-GMN-MAX
               ADD     1                       TO  IDX
                   MOVE    SPACE                   TO  SYS-3004-REC
                   INITIALIZE                      SYS-3004-REC
                   MOVE    SPA-W01-KANRICD         TO  SYS-3004-KANRICD
                   MOVE    SPA-GMN-TCD (IDX)       TO  SYS-3004-KBNCD
                   MOVE    SPA-W01-STYUKYMD        TO  SYS-3004-STYUKYMD
                   MOVE    SPA-W01-EDYUKYMD        TO  SYS-3004-EDYUKYMD
                   MOVE    SPA-GMN-SHORIMSG (IDX)  TO  SYS-3004-SHORIMSG
                   MOVE    SPA-GMN-SHELLID  (IDX)  TO  SYS-3004-SHELLID
                   MOVE    SPA-GMN-CHK (IDX)       TO  SYS-3004-CHK
      *
                   MOVE    SYS-3004-REC            TO  MCPDATA-REC
                   MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
                   MOVE    "DBINSERT"              TO  MCP-FUNC
                   CALL    "ORCMCPSUB"             USING
                                                       MCPAREA
                                                       ORCMCPAREA
                                                       MCPDATA-REC
                   IF      MCP-RC              NOT =   ZERO 
                       MOVE    "1001"                  TO  SPA-ERRCD
                       GO  TO  490-KOUSHIN-EXT
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
       4901-KANRENCHK-SEC           SECTION.
      *
           MOVE    SPACE                TO  SPA-ERRCD
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4901-KANRENCHK-EXT
           END-IF
           .
       4901-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           EVALUATE  WRK-YMD(1:8)
               WHEN  ZERO
                   MOVE  ZERO                    TO  WRK-SYMD
                   MOVE  WRK-YMD(1:8)            TO  WRK-HENYMDG
               WHEN  "99999999"
                   MOVE  ALL "9"                 TO  WRK-SYMD
                   MOVE  WRK-YMD(1:8)            TO  WRK-HENYMDG  
               WHEN    OTHER
                   IF      WRK-YMD  (1:7)  NOT NUMERIC
                       INSPECT     WRK-YMD      REPLACING   ALL " "
                                                            BY  "0"
                       MOVE    WRK-YMD(1:1)      TO  WRK-WGO
                       MOVE    WRK-YMD(2:2)      TO  WRK-WYY
                       MOVE    WRK-YMD(5:2)      TO  WRK-WMM
                       MOVE    WRK-YMD(8:2)      TO  WRK-WDD
                   ELSE
                       MOVE    WRK-YMD(1:7)      TO  WRK-WYMD 
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
                       MOVE    "0002"          TO  SPA-ERRCD
                   ELSE
                       MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
                       PERFORM 5002-HIZUKE-HEN-SEC
                   END-IF
           END-EVALUATE        
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   ZERO
               MOVE    WRK-SYMD (1:8)      TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
     *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
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
           MOVE    "W14    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  W14
      *
           COMPUTE IDY     =   SPA-GMN-PAGE    *   25 
           COMPUTE IDZ     =   IDY             -   24
      *
           PERFORM VARYING     IDX      FROM    1   BY  1
                   UNTIL       IDX      >       WRK-CONS-LINE-MAX 
               MOVE    SPA-GMN-TCD        (IDX) TO  W14-CD       (IDX)
               MOVE    SPA-GMN-SHORIMSG   (IDX) TO  W14-SHORIMSG (IDX)
               MOVE    SPA-GMN-SHELLID    (IDX) TO  W14-SHELLID  (IDX)
               MOVE    SPA-GMN-CHK        (IDX) TO  W14-CHK      (IDX)
           END-PERFORM   
      *
           MOVE    SPA-GMN-STYUKYMD     TO  W14-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD     TO  W14-EDYUKYMD
           MOVE    SPA-GMN-PRTKBN11     TO  W14-PRTKBN11
           MOVE    SPA-GMN-PRTKBN12     TO  W14-PRTKBN12
           MOVE    SPA-GMN-PRTKBN21     TO  W14-PRTKBN21
           MOVE    SPA-GMN-PRTKBN22     TO  W14-PRTKBN22
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
          IF      SPA-GMN-CUR          =   ZERO
               PERFORM 50011-CUR-SET-SEC
          END-IF
      *
           EVALUATE    SPA-GMN-CUR
                WHEN   1
                    MOVE  "SHELLID01"    TO  MCP-WIDGET
                WHEN   7
                    MOVE  "SHELLID02"    TO  MCP-WIDGET
                WHEN   13
                    MOVE  "SHELLID03"    TO  MCP-WIDGET
                WHEN   19
                    MOVE  "SHELLID04"    TO  MCP-WIDGET
                WHEN   25
                    MOVE  "SHELLID05"    TO  MCP-WIDGET
                WHEN   31
                    MOVE  "SHELLID06"    TO  MCP-WIDGET
                WHEN   37
                    MOVE  "SHELLID07"    TO  MCP-WIDGET
                WHEN   43
                    MOVE  "SHELLID08"    TO  MCP-WIDGET
                WHEN   49
                    MOVE  "SHELLID09"    TO  MCP-WIDGET
                WHEN   55
                    MOVE  "SHELLID10"    TO  MCP-WIDGET
                WHEN   61
                    MOVE  "SHELLID11"    TO  MCP-WIDGET
                WHEN   67
                    MOVE  "SHELLID12"    TO  MCP-WIDGET
                WHEN   73
                    MOVE  "SHELLID13"    TO  MCP-WIDGET
                WHEN   79
                    MOVE  "SHELLID14"    TO  MCP-WIDGET
                WHEN   85
                    MOVE  "SHELLID15"    TO  MCP-WIDGET
                WHEN   91
                    MOVE  "SHELLID16"    TO  MCP-WIDGET
                WHEN   97
                    MOVE  "SHELLID17"    TO  MCP-WIDGET
                WHEN   103
                    MOVE  "SHELLID18"    TO  MCP-WIDGET
                WHEN   109
                    MOVE  "SHELLID19"    TO  MCP-WIDGET
                WHEN   115
                    MOVE  "SHELLID20"    TO  MCP-WIDGET
                WHEN   121
                    MOVE  "SHELLID21"    TO  MCP-WIDGET
                WHEN   127
                    MOVE  "SHELLID22"    TO  MCP-WIDGET
                WHEN   133
                    MOVE  "SHELLID23"    TO  MCP-WIDGET
                WHEN   139
                    MOVE  "SHELLID24"    TO  MCP-WIDGET
                WHEN   145
                    MOVE  "SHELLID25"    TO  MCP-WIDGET
                WHEN   2
                    MOVE  "SHORIMSG01"    TO  MCP-WIDGET
                WHEN   8
                    MOVE  "SHORIMSG02"    TO  MCP-WIDGET
                WHEN   14
                    MOVE  "SHORIMSG03"    TO  MCP-WIDGET
                WHEN   20
                    MOVE  "SHORIMSG04"    TO  MCP-WIDGET
                WHEN   26
                    MOVE  "SHORIMSG05"    TO  MCP-WIDGET
                WHEN   32
                    MOVE  "SHORIMSG06"    TO  MCP-WIDGET
                WHEN   38
                    MOVE  "SHORIMSG07"    TO  MCP-WIDGET
                WHEN   44
                    MOVE  "SHORIMSG08"    TO  MCP-WIDGET
                WHEN   50
                    MOVE  "SHORIMSG09"    TO  MCP-WIDGET
                WHEN   56
                    MOVE  "SHORIMSG10"    TO  MCP-WIDGET
                WHEN   62
                    MOVE  "SHORIMSG11"    TO  MCP-WIDGET
                WHEN   68
                    MOVE  "SHORIMSG12"    TO  MCP-WIDGET
                WHEN   74
                    MOVE  "SHORIMSG13"    TO  MCP-WIDGET
                WHEN   80
                    MOVE  "SHORIMSG14"    TO  MCP-WIDGET
                WHEN   86
                    MOVE  "SHORIMSG15"    TO  MCP-WIDGET
                WHEN   92
                    MOVE  "SHORIMSG16"    TO  MCP-WIDGET
                WHEN   98
                    MOVE  "SHORIMSG17"    TO  MCP-WIDGET
                WHEN   104
                    MOVE  "SHORIMSG18"    TO  MCP-WIDGET
                WHEN   110
                    MOVE  "SHORIMSG19"    TO  MCP-WIDGET
                WHEN   116
                    MOVE  "SHORIMSG20"    TO  MCP-WIDGET
                WHEN   122
                    MOVE  "SHORIMSG21"    TO  MCP-WIDGET
                WHEN   128
                    MOVE  "SHORIMSG22"    TO  MCP-WIDGET
                WHEN   134
                    MOVE  "SHORIMSG23"    TO  MCP-WIDGET
                WHEN   140
                    MOVE  "SHORIMSG24"    TO  MCP-WIDGET
                WHEN   146
                    MOVE  "SHORIMSG25"    TO  MCP-WIDGET
                WHEN   3
                    MOVE  "CHKBTN001"    TO  MCP-WIDGET
                WHEN   4
                    MOVE  "CHKBTN002"    TO  MCP-WIDGET
                WHEN   5
                    MOVE  "CHKBTN003"    TO  MCP-WIDGET
                WHEN   6
                    MOVE  "CHKBTN004"    TO  MCP-WIDGET
                WHEN   9
                    MOVE  "CHKBTN005"    TO  MCP-WIDGET
                WHEN   10
                    MOVE  "CHKBTN006"    TO  MCP-WIDGET
                WHEN   11
                    MOVE  "CHKBTN007"    TO  MCP-WIDGET
                WHEN   12
                    MOVE  "CHKBTN008"    TO  MCP-WIDGET
                WHEN   15
                    MOVE  "CHKBTN009"    TO  MCP-WIDGET
                WHEN   16
                    MOVE  "CHKBTN010"    TO  MCP-WIDGET
                WHEN   17
                    MOVE  "CHKBTN011"    TO  MCP-WIDGET
                WHEN   18
                    MOVE  "CHKBTN012"    TO  MCP-WIDGET
                WHEN   21
                    MOVE  "CHKBTN013"    TO  MCP-WIDGET
                WHEN   22
                    MOVE  "CHKBTN014"    TO  MCP-WIDGET
                WHEN   23
                    MOVE  "CHKBTN015"    TO  MCP-WIDGET
                WHEN   24
                    MOVE  "CHKBTN016"    TO  MCP-WIDGET
                WHEN   27
                    MOVE  "CHKBTN017"    TO  MCP-WIDGET
                WHEN   28
                    MOVE  "CHKBTN018"    TO  MCP-WIDGET
                WHEN   29
                    MOVE  "CHKBTN019"    TO  MCP-WIDGET
                WHEN   30
                    MOVE  "CHKBTN020"    TO  MCP-WIDGET
                WHEN   33
                    MOVE  "CHKBTN021"    TO  MCP-WIDGET
                WHEN   34
                    MOVE  "CHKBTN022"    TO  MCP-WIDGET
                WHEN   35
                    MOVE  "CHKBTN023"    TO  MCP-WIDGET
                WHEN   36
                    MOVE  "CHKBTN024"    TO  MCP-WIDGET
                WHEN   39
                    MOVE  "CHKBTN025"    TO  MCP-WIDGET
                WHEN   40
                    MOVE  "CHKBTN026"    TO  MCP-WIDGET
                WHEN   41
                    MOVE  "CHKBTN027"    TO  MCP-WIDGET
                WHEN   42
                    MOVE  "CHKBTN028"    TO  MCP-WIDGET
                WHEN   45
                    MOVE  "CHKBTN029"    TO  MCP-WIDGET
                WHEN   46
                    MOVE  "CHKBTN030"    TO  MCP-WIDGET
                WHEN   47
                    MOVE  "CHKBTN031"    TO  MCP-WIDGET
                WHEN   48
                    MOVE  "CHKBTN032"    TO  MCP-WIDGET
                WHEN   51
                    MOVE  "CHKBTN033"    TO  MCP-WIDGET
                WHEN   52
                    MOVE  "CHKBTN034"    TO  MCP-WIDGET
                WHEN   53
                    MOVE  "CHKBTN035"    TO  MCP-WIDGET
                WHEN   54
                    MOVE  "CHKBTN036"    TO  MCP-WIDGET
                WHEN   57
                    MOVE  "CHKBTN037"    TO  MCP-WIDGET
                WHEN   58
                    MOVE  "CHKBTN038"    TO  MCP-WIDGET
                WHEN   59
                    MOVE  "CHKBTN039"    TO  MCP-WIDGET
                WHEN   60
                    MOVE  "CHKBTN040"    TO  MCP-WIDGET
                WHEN   63
                    MOVE  "CHKBTN041"    TO  MCP-WIDGET
                WHEN   64
                    MOVE  "CHKBTN042"    TO  MCP-WIDGET
                WHEN   65
                    MOVE  "CHKBTN043"    TO  MCP-WIDGET
                WHEN   66
                    MOVE  "CHKBTN044"    TO  MCP-WIDGET
                WHEN   69
                    MOVE  "CHKBTN045"    TO  MCP-WIDGET
                WHEN   70
                    MOVE  "CHKBTN046"    TO  MCP-WIDGET
                WHEN   71
                    MOVE  "CHKBTN047"    TO  MCP-WIDGET
                WHEN   72
                    MOVE  "CHKBTN048"    TO  MCP-WIDGET
                WHEN   75
                    MOVE  "CHKBTN049"    TO  MCP-WIDGET
                WHEN   76
                    MOVE  "CHKBTN050"    TO  MCP-WIDGET
                WHEN   77
                    MOVE  "CHKBTN051"    TO  MCP-WIDGET
                WHEN   78
                    MOVE  "CHKBTN052"    TO  MCP-WIDGET
                WHEN   81
                    MOVE  "CHKBTN053"    TO  MCP-WIDGET
                WHEN   82
                    MOVE  "CHKBTN054"    TO  MCP-WIDGET
                WHEN   83
                    MOVE  "CHKBTN055"    TO  MCP-WIDGET
                WHEN   84
                    MOVE  "CHKBTN056"    TO  MCP-WIDGET
                WHEN   87
                    MOVE  "CHKBTN057"    TO  MCP-WIDGET
                WHEN   88
                    MOVE  "CHKBTN058"    TO  MCP-WIDGET
                WHEN   89
                    MOVE  "CHKBTN059"    TO  MCP-WIDGET
                WHEN   90
                    MOVE  "CHKBTN060"    TO  MCP-WIDGET
                WHEN   93
                    MOVE  "CHKBTN061"    TO  MCP-WIDGET
                WHEN   94
                    MOVE  "CHKBTN062"    TO  MCP-WIDGET
                WHEN   95
                    MOVE  "CHKBTN063"    TO  MCP-WIDGET
                WHEN   96
                    MOVE  "CHKBTN064"    TO  MCP-WIDGET
                WHEN   99
                    MOVE  "CHKBTN065"    TO  MCP-WIDGET
                WHEN   100
                    MOVE  "CHKBTN066"    TO  MCP-WIDGET
                WHEN   101
                    MOVE  "CHKBTN067"    TO  MCP-WIDGET
                WHEN   102
                    MOVE  "CHKBTN068"    TO  MCP-WIDGET
                WHEN   105
                    MOVE  "CHKBTN069"    TO  MCP-WIDGET
                WHEN   106
                    MOVE  "CHKBTN070"    TO  MCP-WIDGET
                WHEN   107
                    MOVE  "CHKBTN071"    TO  MCP-WIDGET
                WHEN   108
                    MOVE  "CHKBTN072"    TO  MCP-WIDGET
                WHEN   111
                    MOVE  "CHKBTN073"    TO  MCP-WIDGET
                WHEN   112
                    MOVE  "CHKBTN074"    TO  MCP-WIDGET
                WHEN   113
                    MOVE  "CHKBTN075"    TO  MCP-WIDGET
                WHEN   114
                    MOVE  "CHKBTN076"    TO  MCP-WIDGET
                WHEN   117
                    MOVE  "CHKBTN077"    TO  MCP-WIDGET
                WHEN   118
                    MOVE  "CHKBTN078"    TO  MCP-WIDGET
                WHEN   119
                    MOVE  "CHKBTN079"    TO  MCP-WIDGET
                WHEN   120
                    MOVE  "CHKBTN080"    TO  MCP-WIDGET
                WHEN   123
                    MOVE  "CHKBTN081"    TO  MCP-WIDGET
                WHEN   124
                    MOVE  "CHKBTN082"    TO  MCP-WIDGET
                WHEN   125
                    MOVE  "CHKBTN083"    TO  MCP-WIDGET
                WHEN   126
                    MOVE  "CHKBTN084"    TO  MCP-WIDGET
                WHEN   129
                    MOVE  "CHKBTN085"    TO  MCP-WIDGET
                WHEN   130
                    MOVE  "CHKBTN086"    TO  MCP-WIDGET
                WHEN   131
                    MOVE  "CHKBTN087"    TO  MCP-WIDGET
                WHEN   132
                    MOVE  "CHKBTN088"    TO  MCP-WIDGET
                WHEN   135
                    MOVE  "CHKBTN089"    TO  MCP-WIDGET
                WHEN   136
                    MOVE  "CHKBTN090"    TO  MCP-WIDGET
                WHEN   137
                    MOVE  "CHKBTN091"    TO  MCP-WIDGET
                WHEN   138
                    MOVE  "CHKBTN092"    TO  MCP-WIDGET
                WHEN   141
                    MOVE  "CHKBTN093"    TO  MCP-WIDGET
                WHEN   142
                    MOVE  "CHKBTN094"    TO  MCP-WIDGET
                WHEN   143
                    MOVE  "CHKBTN095"    TO  MCP-WIDGET
                WHEN   144
                    MOVE  "CHKBTN096"    TO  MCP-WIDGET
                WHEN   147
                    MOVE  "CHKBTN097"    TO  MCP-WIDGET
                WHEN   148
                    MOVE  "CHKBTN098"    TO  MCP-WIDGET
                WHEN   149
                    MOVE  "CHKBTN099"    TO  MCP-WIDGET
                WHEN   150
                    MOVE  "CHKBTN100"    TO  MCP-WIDGET
                 WHEN   200
                    MOVE  "B12"        TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *****************************************************************
      *    カーソル編集処理
      *****************************************************************
       50011-CUR-SET-SEC         SECTION.
      *
           IF      WRK-MCP-WIDGET(1:7) =   "SHELLID"
               MOVE    WRK-MCP-WIDGET(8:2) TO  WRK-IDX2
               COMPUTE SPA-GMN-CUR         =  (WRK-IDX2   -   1)  *   6
                                           +   1
               ADD     1                   TO  SPA-GMN-CUR
           END-IF
      *
           IF      WRK-MCP-WIDGET(1:8) =   "SHORIMSG"
               MOVE    WRK-MCP-WIDGET(9:2) TO  WRK-IDX2
               COMPUTE SPA-GMN-CUR         =  (WRK-IDX2   -   1)  *   6
                                           +   2
               ADD     1                   TO  SPA-GMN-CUR
           END-IF
      *
           .
       50011-CUR-SET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "シェル名は半角で入力して下さい"
                                                      TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "処理名は全角で入力して下さい"
                                                      TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "項目に入力がありません"   TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "前頁はありません"         TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "次頁はありません"         TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"
                                                      TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除ができませんでした"
                                                      TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "印刷指示の更新ができませんでした"
                                                      TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W14"                TO  SPA-MOTOPG
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
                   MOVE    "登録処理をします"    TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W14"                TO  SPA-MOTOPG
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
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
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
      *
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

