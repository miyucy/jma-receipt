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
       PROGRAM-ID.             ORCGN01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 保険者情報設定
      *  コンポーネント名  : 保険者情報
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.00.02    MCC-藤原     01/10/24  削除ができるように修正 
      *  01.00.03    NACL-藤原    02/09/05  保険番号のコラムリストを
      *                                     １００に変更
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
           COPY    "N01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-N01.
           03  SPA-N01-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
      
               05  SPA-GMN-AREA.
                   07  SPA-GMN-HKNJANUM       PIC X(08).
                   07  SPA-GMN-HKNNUMLST      OCCURS  100.
                       09  SPA-GMN-HKNNUML    PIC X(03).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-HKNNUMNML  PIC X(20).
                   07  SPA-GMN-HKNIDX         PIC 9(03).
      *                 
                   07  SPA-GMN-KOUMOKU.
                       09  SPA-GMN-HKNJANAME      PIC X(200).
                       09  SPA-GMN-HKNJANAMETAN1  PIC X(100).
                       09  SPA-GMN-HKNJANAMETAN2  PIC X(40).
                       09  SPA-GMN-HKNJANAMETAN3  PIC X(40).
                       09  SPA-GMN-POST           PIC X(07).
                       09  SPA-GMN-ADRS           PIC X(100).
                       09  SPA-GMN-BANTI          PIC X(100).
                       09  SPA-GMN-TEL            PIC X(15).
                       09  SPA-GMN-KIGO           PIC X(80).
      *
                       09  SPA-GMN-HKNNUM-G.
                           11  SPA-GMN-HKNNUM     PIC X(03).
                           11  SPA-GMN-FL         PIC X(01).
                           11  SPA-GMN-HKNNUMNM   PIC X(20).
      *
               05  SPA-NAI-AREA.
                   07  SPA-NAI-UPDFLG     PIC 9(01).
                   07  SPA-HKNJANUM-LEN   PIC 9(01).
                   07  SPA-NAI-HKNNUML    OCCURS  100.
                       09  SPA-NAI-HKNKOHSBTKBN   PIC X(01).
      *
      *   
           COPY    "ENUM-VALUE".
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
           03  FLG-ADRS            PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01). 
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
           03  WRK-HENFLG          PIC 9(01).
           03  WRK-NIDMSG          PIC X(70). 
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
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
       01  HKNJAINF-REC.
           COPY  "CPHKNJAINF.INC".
      *    住所マスタ
       01  ADRS-REC.
           COPY    "CPADRS.INC".
      *
      *    保険番号マスタ
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *   チェックデジット
           COPY    "CPORCCHKDGT.INC".
      *
      *    日付サブルーチン領域
      *
           COPY  "CPORCSDAY.INC".
      *
           COPY  "CPORCSLNK.INC".
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
           COPY    "N01.INC".
           COPY    "NERR.INC".
           COPY    "NID1.INC".
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
           MOVE    SPA-WORK        TO  SPA-N01KYOUTU
           MOVE    SPA-FREE        TO  SPA-N01
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
           MOVE    SPA-N01         TO  SPA-FREE
           MOVE    SPA-N01KYOUTU   TO  SPA-WORK 
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
           IF      SPA-MOTOPG          =   "NERR"
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
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      * 
      ***  MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "N01"                TO  MCP-WINDOW
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
               WHEN    "NID1"
                   PERFORM 330-NID1-SET-SEC
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
       330-NID1-SET-SEC            SECTION.
      *
           IF      SPA-NID1-FLG    =   "OK"
               IF      SPA-NIDCD            =   "1002"
                   PERFORM 4031-DEL-SEC
               ELSE
                   PERFORM 490-KOUSHIN-SEC
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  SPA-NID1-FLG
           MOVE    SPACE           TO  SPA-NIDCD      
           .
       330-NID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE   SPA-N01-AREA
                        SPA-N01KYOUTU
      *
      *    保険番号　全件編集（適用範囲分）
           INITIALIZE                  HKNNUM-REC
           MOVE    SPA-HOSPID          TO  HKN-HOSPID
           MOVE    SPA-SYSYMD          TO  HKN-TEKSTYMD
           MOVE    SPA-SYSYMD          TO  HKN-TEKEDYMD
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY3"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY3"       TO  ORC-DBPATH
               PERFORM 921-HKNMST-NEXT-SEC
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           PERFORM UNTIL       FLG-HKNNUM  =   1
                               OR      SPA-GMN-HKNIDX
                                           =   100
               IF      SPA-GMN-HKNIDX  >   ZERO
               AND     HKN-HKNNUM      = 
                                      SPA-GMN-HKNNUML (SPA-GMN-HKNIDX)
                   CONTINUE
               ELSE    
                   ADD     1               TO  SPA-GMN-HKNIDX
                   MOVE    HKN-HKNNUM      TO  SPA-GMN-HKNNUML
                                                      (SPA-GMN-HKNIDX)
                   IF      HKN-HKNNUM      =   "027"
                       MOVE    "老人保健"      TO  SPA-GMN-HKNNUMNML
                                                      (SPA-GMN-HKNIDX)
                   ELSE
                       MOVE    HKN-TANSEIDONAME
                                               TO  SPA-GMN-HKNNUMNML
                                                      (SPA-GMN-HKNIDX)
                   END-IF                                       
                   MOVE    HKN-HKNKOHSBTKBN    TO
                                               SPA-NAI-HKNKOHSBTKBN
                                                      (SPA-GMN-HKNIDX)
               END-IF                                       
      *
               MOVE    "HKNNUM-KEY3"       TO  ORC-DBPATH
               PERFORM 921-HKNMST-NEXT-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    1                   TO  SPA-GMN-CUR
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
                   PERFORM 210-BACK
      *        クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM  402-CLEAR-SEC
      *        削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM  403-DEL-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
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
               WHEN    "ACTIVATE"      ALSO    "HKNJANUM"
                   PERFORM 4100-HKNJANUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNJANAME"
                   PERFORM 4101-HKNJANAME-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNJANAMETAN1"
                   PERFORM 4102-HKNJANAMETAN1-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNJANAMETAN2"
                   PERFORM 4103-HKNJANAMETAN2-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNJANAMETAN3"
                   PERFORM 4104-HKNJANAMETAN3-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNNUM"
                   PERFORM 4105-HKNNUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "POST"
                   PERFORM 4106-POST-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "ADRS"
                   PERFORM 4107-ADRS-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BANTI"
                   PERFORM 4108-BANTI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "TEL"
                   PERFORM 4109-TEL-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "KIGO"
                   PERFORM 4110-KIGO-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号チェック
      *****************************************************************
       4100-HKNJANUM-CHK-SEC       SECTION.
      *
           MOVE    1                TO  SPA-GMN-CUR
      *
           MOVE    N01-HKNJANUM     TO  SPA-GMN-HKNJANUM           
      * 
      *
           MOVE    ZERO             TO  SPA-HKNJANUM-LEN
           PERFORM    VARYING   IDX   FROM    1   BY  1
                      UNTIL    (IDX      >    8  )
                      OR       (SPA-GMN-HKNJANUM(IDX:1)  =   SPACE)
               ADD     1                 TO  SPA-HKNJANUM-LEN
           END-PERFORM
      *
           IF      SPA-HKNJANUM-LEN =   4   OR  6  OR  8
               CONTINUE
           ELSE         
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO               4100-HKNJANUM-CHK-EXT
           END-IF
      *
           IF  SPA-GMN-HKNJANUM (1:SPA-HKNJANUM-LEN)
                                      IS  NOT NUMERIC
               MOVE    "0001"         TO  SPA-ERRCD
               GO  TO                 4100-HKNJANUM-CHK-EXT
           END-IF
      *
      *    入力された保険者番号をセットすれば、サブプロ内で
      *    検証してくれる (処理区分:2)
           IF      SPA-HKNJANUM-LEN =   4
               CONTINUE
           ELSE
               INITIALIZE               LNK-CHKDGT-AREA
               MOVE    2                TO  LNK-I-SYORIKBN
               MOVE    SPA-GMN-HKNJANUM TO  LNK-I-CODE
               CALL    "ORCSCHKDGT"       USING   LNK-CHKDGT-AREA
               IF      LNK-O-ERRCD      NOT =   ZERO
                   MOVE    "0002"       TO  SPA-ERRCD
                   GO  TO               4100-HKNJANUM-CHK-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  HKNJAINF-REC
           INITIALIZE                      HKNJAINF-REC
           MOVE    SPA-HOSPID          TO  HKNJA-HOSPID
           MOVE    SPA-GMN-HKNJANUM    TO  HKNJA-HKNJANUM
           MOVE    HKNJAINF-REC        TO  MCPDATA-REC
           PERFORM 900-HKNJAINF-INV-SEC
           IF      FLG-HKNJAINF        =   ZERO
               MOVE    1                   TO  SPA-NAI-UPDFLG 
               MOVE    HKNJA-HKNJANAME     TO  SPA-GMN-HKNJANAME
               MOVE    HKNJA-HKNJANAME-TAN1
                                           TO  SPA-GMN-HKNJANAMETAN1
               MOVE    HKNJA-HKNJANAME-TAN2
                                           TO  SPA-GMN-HKNJANAMETAN2
               MOVE    HKNJA-HKNJANAME-TAN3
                                           TO  SPA-GMN-HKNJANAMETAN3
               MOVE    HKNJA-HKNNUM        TO  SPA-GMN-HKNNUM
               MOVE    HKNJA-POST          TO  SPA-GMN-POST
               MOVE    HKNJA-ADRS          TO  SPA-GMN-ADRS
               MOVE    HKNJA-BANTI         TO  SPA-GMN-BANTI
               MOVE    HKNJA-TEL           TO  SPA-GMN-TEL
               MOVE    HKNJA-KIGO          TO  SPA-GMN-KIGO
           ELSE
               MOVE    ZERO                TO  SPA-NAI-UPDFLG
               MOVE    SPACE               TO  SPA-GMN-KOUMOKU
               EVALUATE    SPA-HKNJANUM-LEN
                   WHEN    4
                       MOVE    "001"           TO  SPA-GMN-HKNNUM
                   WHEN    6
                       MOVE    "060"           TO  SPA-GMN-HKNNUM
                   WHEN    8
                       IF      SPA-GMN-HKNJANUM (1:2)
                                               =   "27"
                           MOVE    "027"           TO  SPA-GMN-HKNNUM
                           MOVE    "老人保健"      TO  SPA-GMN-HKNNUMNM
                           MOVE    2               TO  SPA-GMN-CUR
                           GO  TO  4100-HKNJANUM-CHK-EXT
                       ELSE
                          INITIALIZE                  HKNNUM-REC
                          MOVE    SPA-HOSPID          TO  HKN-HOSPID
                          MOVE    SPA-GMN-HKNJANUM(1:2)
                                                      TO  HKN-HBTNUM
                          MOVE    SPA-SYSYMD          TO  HKN-TEKSTYMD
                          MOVE    SPA-SYSYMD          TO  HKN-TEKEDYMD
                          MOVE    HKNNUM-REC          TO  MCPDATA-REC
                          MOVE    "HKNNUM-KEY4"       TO  WRK-PATH
                          PERFORM 900-HKNNUM-INV-SEC
                          IF      FLG-HKNNUM          =   ZERO
                              MOVE    HKN-HKNNUM      TO  SPA-GMN-HKNNUM
                          END-IF      
                       END-IF       
               END-EVALUATE                
           END-IF
      *     
           IF      SPA-GMN-HKNNUM      NOT =   SPACE        
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-HKNIDX
                   IF      SPA-GMN-HKNNUM  =   SPA-GMN-HKNNUML (IDX)
                       MOVE    SPA-GMN-HKNNUMLST (IDX)
                                           TO  SPA-GMN-HKNNUM-G
                       MOVE    50          TO  IDX                    
                   END-IF
               END-PERFORM
           END-IF       
      *             
           MOVE    2                  TO  SPA-GMN-CUR
           .
       4100-HKNJANUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者名称チェック
      *****************************************************************
       4101-HKNJANAME-CHK-SEC       SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR
      *
           MOVE    N01-HKNJANAME       TO  SPA-GMN-HKNJANAME
      *
           IF      SPA-GMN-HKNJANAMETAN1
                                       =   SPACE
               MOVE    SPA-GMN-HKNJANAME   TO  SPA-GMN-HKNJANAMETAN1
           END-IF                                      
      *
           MOVE    3                   TO  SPA-GMN-CUR
           .
       4101-HKNJANAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者名称短縮１チェック
      *****************************************************************
       4102-HKNJANAMETAN1-CHK-SEC     SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR
      *
           MOVE    N01-HKNJANAMETAN1   TO  SPA-GMN-HKNJANAMETAN1
      *
           IF      SPA-GMN-HKNJANAMETAN2
                                       =   SPACE
               MOVE    SPA-GMN-HKNJANAMETAN1
                                       TO  SPA-GMN-HKNJANAMETAN2
           END-IF                                      
      *                           
           MOVE    4                   TO  SPA-GMN-CUR
           .
       4102-HKNJANAMETAN1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者名称短縮２チェック
      *****************************************************************
       4103-HKNJANAMETAN2-CHK-SEC     SECTION.
      *
           MOVE    4                   TO  SPA-GMN-CUR
      *
           MOVE    N01-HKNJANAMETAN2   TO  SPA-GMN-HKNJANAMETAN2
      *
           IF      SPA-GMN-HKNJANAMETAN3
                                       =   SPACE
               MOVE    SPA-GMN-HKNJANAMETAN2
                                       TO  SPA-GMN-HKNJANAMETAN3
           END-IF                                      
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
       4103-HKNJANAMETAN2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者名称短縮３チェック
      *****************************************************************
       4104-HKNJANAMETAN3-CHK-SEC          SECTION.
      *
           MOVE    5                   TO  SPA-GMN-CUR
      *
           MOVE    N01-HKNJANAMETAN3   TO  SPA-GMN-HKNJANAMETAN3
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
       4104-HKNJANAMETAN3-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号チェック
      *****************************************************************
       4105-HKNNUM-CHK-SEC          SECTION.
      *
           MOVE    6                   TO  SPA-GMN-CUR
      *
           MOVE    N01-HKNNUM          TO  SPA-GMN-HKNNUM-G
      *
           IF      SPA-GMN-HKNNUM      =   SPACE
               CONTINUE
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-HKNIDX
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-HKNNUM =   SPA-GMN-HKNNUML (IDY)
                       MOVE    SPA-GMN-HKNNUMLST (IDY)
                                          TO  SPA-GMN-HKNNUM-G
                       MOVE    1          TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0001"               TO  SPA-ERRCD
                   GO  TO  4105-HKNNUM-CHK-EXT
               END-IF
      *
               EVALUATE    SPA-GMN-HKNNUM
                   WHEN    "001"
                       IF      SPA-HKNJANUM-LEN NOT =   4
                           MOVE    "0001"         TO  SPA-ERRCD
                       END-IF                       
                   WHEN    "060"
                       IF      SPA-HKNJANUM-LEN NOT =   6
                           MOVE    "0001"         TO  SPA-ERRCD
                       END-IF
                   WHEN    OTHER
                       IF      SPA-HKNJANUM-LEN NOT =   8
                           MOVE    "0001"         TO  SPA-ERRCD
                       ELSE
                          INITIALIZE                  HKNNUM-REC
                          MOVE    SPA-HOSPID          TO  HKN-HOSPID
                          MOVE    SPA-GMN-HKNNUM      TO  HKN-HKNNUM
                          MOVE    SPA-SYSYMD          TO  HKN-TEKSTYMD
                          MOVE    SPA-SYSYMD          TO  HKN-TEKEDYMD
                          MOVE    HKNNUM-REC          TO  MCPDATA-REC
                          MOVE    "HKNNUM-KEY5"       TO  WRK-PATH
                          PERFORM 900-HKNNUM-INV-SEC
                          IF      FLG-HKNNUM          =   ZERO
                              IF      HKN-HBTNUM      NOT =
                                              SPA-GMN-HKNJANUM (1:2)
                                  MOVE    "0001"         TO  SPA-ERRCD
                              END-IF
                           ELSE    
                               MOVE    "0001"         TO  SPA-ERRCD
                           END-IF      
                       END-IF                     
               END-EVALUATE                     
           END-IF        
      *
           IF      SPA-ERRCD           =   SPACE
               ADD     1                   TO  SPA-GMN-CUR
           END-IF    
           .
       4105-HKNNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    郵便番号チェック
      *****************************************************************
       4106-POST-CHK-SEC        SECTION.
      *
           MOVE    7                   TO  SPA-GMN-CUR
      *
           MOVE    N01-POST            TO  SPA-GMN-POST
      *
           IF      SPA-GMN-POST    NOT =   SPACE
               MOVE    SPACE               TO  ADRS-REC    
               INITIALIZE                  ADRS-REC
               MOVE    SPA-GMN-POST        TO  ADRS-POST
               MOVE    ADRS-REC            TO  MCPDATA-REC
               PERFORM 900-ADRS-INV-SEC
               IF      FLG-ADRS            =   ZERO
                   MOVE    ADRS-EDITADRS-NAME  TO  SPA-GMN-ADRS
               ELSE
                   MOVE    SPACE               TO  SPA-GMN-ADRS    
               END-IF
           END-IF
      *                 
           ADD     1                   TO  SPA-GMN-CUR
           .
       4106-POST-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    住所チェック
      *****************************************************************
       4107-ADRS-CHK-SEC            SECTION.
      *
           MOVE    8                   TO  SPA-GMN-CUR
      *
           MOVE    N01-ADRS            TO  SPA-GMN-ADRS
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
       4107-ADRS-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番地方書チェック
      *****************************************************************
       4108-BANTI-CHK-SEC        SECTION.
      *
           MOVE    9                   TO  SPA-GMN-CUR
      *
           MOVE    N01-BANTI           TO  SPA-GMN-BANTI
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
       4108-BANTI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    電話番号チェック
      *****************************************************************
       4109-TEL-CHK-SEC            SECTION.
      *
           MOVE    10                  TO  SPA-GMN-CUR
      * 
           MOVE    N01-TEL             TO  SPA-GMN-TEL
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
       4109-TEL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    記号チェック
      *****************************************************************
       4110-KIGO-CHK-SEC         SECTION.
      *
           MOVE    11                  TO  SPA-GMN-CUR
      *
           MOVE    N01-KIGO            TO  SPA-GMN-KIGO
      *
           MOVE    99                 TO  SPA-GMN-CUR
           .
       4110-KIGO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "M02"               TO  SPA-SAKIPG
           MOVE    "N01"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
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
      *    削除確認画面表示処理
      *****************************************************************
       402-CLEAR-SEC                               SECTION.
      *
           MOVE    SPACE               TO  SPA-GMN-KOUMOKU
                                           SPA-GMN-HKNJANUM
      *
           MOVE    ZERO                TO  SPA-NAI-UPDFLG
      *          
           MOVE    1                   TO  SPA-GMN-CUR
      *
           .    
       402-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                               SECTION.
      *
           IF      SPA-NAI-UPDFLG      =   ZERO
               MOVE    "0003"              TO  SPA-ERRCD
           ELSE    
               MOVE    "1002"              TO  SPA-NIDCD
           END-IF    
      *
           .    
       403-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理
      *****************************************************************
       4031-DEL-SEC                              SECTION.
      *
           MOVE    SPACE               TO  HKNJAINF-REC
           INITIALIZE                      HKNJAINF-REC
           MOVE    SPA-HOSPID          TO  HKNJA-HOSPID
           MOVE    SPA-GMN-HKNJANUM    TO  HKNJA-HKNJANUM
           MOVE    HKNJAINF-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"                  TO  SPA-ERRCD
               GO  TO  4031-DEL-EXT
           END-IF
      *
           PERFORM 310-SPASET-SEC
           .
       4031-DEL-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *       登録前処理
      *****************************************************************
       490-TOUROKU-SEC              SECTION.
      *
           MOVE    "1001"           TO  SPA-NIDCD
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
      *
           IF      SPA-NAI-UPDFLG      =   1
               MOVE    SPACE               TO  HKNJAINF-REC
               INITIALIZE                      HKNJAINF-REC
               MOVE    SPA-HOSPID          TO  HKNJA-HOSPID
               MOVE    SPA-GMN-HKNJANUM    TO  HKNJA-HKNJANUM
               MOVE    HKNJAINF-REC        TO  MCPDATA-REC
               PERFORM 900-HKNJAINF-INV-SEC
           ELSE
               MOVE    SPACE               TO  HKNJAINF-REC
               INITIALIZE                      HKNJAINF-REC
               MOVE    SPA-HOSPID          TO  HKNJA-HOSPID
               MOVE    SPA-GMN-HKNJANUM    TO  HKNJA-HKNJANUM
           END-IF
      *          
           MOVE    SPA-GMN-HKNJANAME       TO  HKNJA-HKNJANAME 
           MOVE    SPA-GMN-HKNJANAMETAN1   TO  HKNJA-HKNJANAME-TAN1 
           MOVE    SPA-GMN-HKNJANAMETAN2   TO  HKNJA-HKNJANAME-TAN2 
           MOVE    SPA-GMN-HKNJANAMETAN3   TO  HKNJA-HKNJANAME-TAN3 
           MOVE    SPA-GMN-HKNNUM          TO  HKNJA-HKNNUM 
           MOVE    SPA-GMN-POST            TO  HKNJA-POST 
           MOVE    SPA-GMN-ADRS            TO  HKNJA-ADRS 
           MOVE    SPA-GMN-BANTI           TO  HKNJA-BANTI 
           MOVE    SPA-GMN-TEL             TO  HKNJA-TEL 
           MOVE    SPA-GMN-KIGO            TO  HKNJA-KIGO 
      *
           MOVE    HKNJAINF-REC            TO  MCPDATA-REC
           MOVE    "HKNJAINF-KEY"          TO  ORC-DBPATH
           IF      SPA-NAI-UPDFLG      =   1
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1001"                  TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-EXT
           END-IF      
      *
           PERFORM 310-SPASET-SEC 
           .
       490-KOUSHIN-EXT.
           EXIT.
      *
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
           IF      SPA-NIDCD       NOT =   SPACE
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "N01    "           TO  MCP-WINDOW.
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
           MOVE    SPA-GMN-HKNJANUM      TO  N01-HKNJANUM
           MOVE    SPA-GMN-HKNJANAME     TO  N01-HKNJANAME
           MOVE    SPA-GMN-HKNJANAMETAN1 TO  N01-HKNJANAMETAN1
           MOVE    SPA-GMN-HKNJANAMETAN2 TO  N01-HKNJANAMETAN2
           MOVE    SPA-GMN-HKNJANAMETAN3 TO  N01-HKNJANAMETAN3
           MOVE    SPA-GMN-POST          TO  N01-POST
           MOVE    SPA-GMN-ADRS          TO  N01-ADRS
           MOVE    SPA-GMN-BANTI         TO  N01-BANTI  
           MOVE    SPA-GMN-TEL           TO  N01-TEL
           MOVE    SPA-GMN-KIGO          TO  N01-KIGO
      *
           MOVE    SPA-GMN-HKNNUM-G      TO  N01-HKNNUM
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   SPA-GMN-HKNIDX
               MOVE    SPA-GMN-HKNNUMLST (IDX) TO  N01-HKNNUMLST (IDX)
               MOVE    IDX                     TO  N01-COUNT
           END-PERFORM
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラー"        TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "検証番号チェックエラー"
                                               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "未登録のデータなので削除できません"
                                               TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新処理ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除処理ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  NERR
           MOVE    SPA-ERRCD            TO  NERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  NERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "N01"                TO  SPA-MOTOPG
           MOVE    "NERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "NERR"               TO  MCP-WINDOW
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
           MOVE    SPACE               TO  WRK-NIDMSG
      *
           EVALUATE    SPA-NIDCD
               WHEN    "1001"
                   MOVE    "登録処理をします"    TO  WRK-NIDMSG
               WHEN    "1002"
                   MOVE    "削除処理をします"    TO  WRK-NIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  NID1
           MOVE    SPA-NIDCD            TO  NID1-ID1CODE
           MOVE    WRK-NIDMSG           TO  NID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "N01"                TO  SPA-MOTOPG
           MOVE    "NID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "NID1"               TO  MCP-WINDOW
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
          EVALUATE    SPA-GMN-CUR
                WHEN    01
                    MOVE    "HKNJANUM"          TO   MCP-WIDGET
                WHEN    02
                    MOVE    "HKNJANAME"         TO   MCP-WIDGET
                WHEN    03
                    MOVE    "HKNJANAMETAN1"     TO   MCP-WIDGET
                WHEN    04
                    MOVE    "HKNJANAMETAN2"     TO   MCP-WIDGET
                WHEN    05
                    MOVE    "HKNJANAMETAN3"     TO   MCP-WIDGET
                WHEN    06
                    MOVE    "HKNNUM"            TO   MCP-WIDGET
                WHEN    07
                    MOVE    "POST"              TO   MCP-WIDGET
                WHEN    08
                    MOVE    "ADRS"              TO   MCP-WIDGET
                WHEN    09
                    MOVE    "BANTI"             TO   MCP-WIDGET
                WHEN    10
                    MOVE    "TEL"               TO   MCP-WIDGET
                WHEN    11
                    MOVE    "KIGO"              TO   MCP-WIDGET
                WHEN    99
                    MOVE    "B12"               TO   MCP-WIDGET
            END-EVALUATE
      *
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
       900-HKNJAINF-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNJAINF
                   MOVE    MCPDATA-REC         TO  HKNJAINF-REC
               ELSE
                   MOVE    1                   TO  FLG-HKNJAINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNJAINF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-HKNJAINF-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-ADRS-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "ADRS-KEY2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "ADRS-KEY2"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-ADRS
                   MOVE    MCPDATA-REC         TO  ADRS-REC
               ELSE
                   MOVE    1                   TO  FLG-ADRS
               END-IF
           ELSE
               MOVE    1                   TO  FLG-ADRS
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "ADRS-KEY2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-ADRS-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-HKNNUM-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH        TO  ORC-DBPATH
               PERFORM 921-HKNMST-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-HKNNUM
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
       900-HKNNUM-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスタ次検索処理
      *****************************************************************
       921-HKNMST-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE              HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           .
       921-HKNMST-NEXT-EXT.
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
