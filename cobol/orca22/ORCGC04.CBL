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
       PROGRAM-ID.             ORCGC04.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 病名登録
      *  コンポーネント名  : 自院病名検索（Ｃ０４）
      *  管理者            : 
      *  01/12/11    MCC−藤原   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/05/08  半角チェック追加
      *  01.00.02    MCC-多々納   02/05/08  半角チェック時、半角空白を
      *                                     全角空白へ置換えの追加
      *  01.00.03    MCC-藤原     02/05/17  コラムリスト700に変更
      *
      *  01.01.01    NACL-藤原    02/08/23  新傷病名マスタ対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *   
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    病名登録用共通パラメタ
           COPY    "C01COMMON-SPA".
      *
      *    病名登録用画面ＳＰＡ
           COPY    "C02SCR-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-USERBYOMEI      PIC 9(01).
           03  FLG-BYOMEI          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDW                 PIC 9(04).
           03  IDX1                PIC 9(04). 
           03  IDX2                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-NUM             PIC ZZ9.
           03  WRK-SELNO           PIC 9(03). 
           03  WRK-WIDGET.
               05  WRK-WIDGET1     PIC X(07).
               05  WRK-WIDGET2     PIC 9(01).  
           05  WRK-BYOMEI          PIC X(400).
      *
           05  WRK-PATH            PIC X(64).      
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HAISIYMDH       PIC X(22).
      *
      *
       01  WRK-TBL-MAX             PIC 9(03)   VALUE   700.
      *
       01  WRK-HEN-AREA.
           03  WRK-NENGO           PIC X(04).
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    自院病名マスタ−
       01  USERBYOMEI-REC.
           COPY    "CPUSERBYOMEI.INC".
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
           COPY    "CPORCMCP.INC".  
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "C02.INC".
           COPY    "C03.INC".
           COPY    "C04.INC".
           COPY    "C05.INC".
           COPY    "C06.INC".
           COPY    "C07.INC".
           COPY    "C08.INC".
           COPY    "CERR.INC".
           COPY    "CID1.INC".
           COPY    "CID2.INC".
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
           MOVE    SPA-FREE        TO  SPA-C02FREE
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
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-C02FREE     TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "CERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "C04    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           MOVE    2               TO  SPA-GMN-C04-CUR
           .
       300-SCREEN-EXT.
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
      *    全分類検索
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 450-BUNRUI-HENSYU-SEC
      *    確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-KAKUTEI-SEC
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
               WHEN    "ACTIVATE"      ALSO    "SELNUM1"
                   PERFORM 41001-SELNUM1-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SELNUM2"
                   PERFORM 41002-SELNUM2-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "INPUTCD1"
               WHEN    "ACTIVATE"      ALSO    "INPUTCD2"
               WHEN    "ACTIVATE"      ALSO    "INPUTCD3"
               WHEN    "ACTIVATE"      ALSO    "INPUTCD4"
               WHEN    "ACTIVATE"      ALSO    "INPUTCD5"
               WHEN    "ACTIVATE"      ALSO    "INPUTCD6"
                   PERFORM 41003-INPUTCD-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "KENBYOMEI"
                   PERFORM 41004-KENBYOMEI-CHK-SEC
      *        病名選択
               WHEN    ANY             ALSO    "BYOMEILST"
                   PERFORM 41020-BYOMEISEL-SEC
      *        分類選択
               WHEN    ANY             ALSO    "BUNRUILST"
                   PERFORM 41021-BUNRUILST-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    分類名選択処理
      *****************************************************************
       41001-SELNUM1-CHK-SEC            SECTION.
      *
           MOVE    9                   TO  SPA-GMN-C04-CUR
      *
           MOVE    ZERO                TO  SPA-NAI-C04-SELNUM1 
      *
           MOVE    C04-SELNUM1         TO  SPA-GMN-C04-SELNUM1
      *
           IF      SPA-GMN-C04-SELNUM1 =   ZERO
               MOVE    2                   TO  SPA-GMN-C04-CUR
           ELSE
               IF      SPA-GMN-C04-SELNUM1 >   SPA-GMN-C04-BUNRUI-MAX
                   MOVE    "0012"          TO  SPA-ERRCD
               ELSE
                   MOVE    SPA-GMN-C04-SELNUM1
                                           TO  SPA-NAI-C04-SELNUM1
                   MOVE    "USERBYOMEI-KEY7"
                                           TO  WRK-PATH                         
                   PERFORM 410011-BUNRUI-HENSYU-SEC
               END-IF
           END-IF    
           .
       41002-SELNUM2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名一覧 編集処理
      *****************************************************************
       410011-BUNRUI-HENSYU-SEC         SECTION.
      *
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDY
      *
           MOVE    ZERO                TO  SPA-GMN-C04-MAX
           INITIALIZE                  SPA-GMN-C04-BYOMEI-TBL
      *
      *    分類コード ’Ａ’，’Ｊ’のもの
           INITIALIZE                  USERBYOMEI-REC
           MOVE    SPA-HOSPID          TO  USBYO-HOSPID
           IF      WRK-PATH            =   "USERBYOMEI-KEY7"
               MOVE    SPA-GMN-C04-BBUNRUICD (SPA-NAI-C04-SELNUM1)
                                       TO  USBYO-BUNRUICD
           END-IF                                                       
           IF      WRK-PATH            =   "USERBYOMEI-KEY8"
               MOVE    SPA-GMN-C04-KENBYOMEI
                                       TO  USBYO-BYOMEI
           END-IF                                                       
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           ELSE
               INITIALIZE                  USERBYOMEI-REC
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           PERFORM UNTIL       (FLG-USERBYOMEI   =   1            )  OR
                               (IDX              >=  WRK-TBL-MAX  )
      *
               ADD     1               TO  IDX
      *
               MOVE    IDX             TO  SPA-GMN-C04-TBANGO  (IDX)
      *        病名入力コード
               MOVE    USBYO-BYOMEIINPUTCD
                                       TO  SPA-GMN-C04-TINPUTCD(IDX)
      *        病名
               MOVE    USBYO-BYOMEI    TO  SPA-GMN-C04-TBYOMEI (IDX)
      *
               MOVE    WRK-PATH        TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    IDX                 TO  SPA-GMN-C04-MAX
           MOVE    SPACE               TO  SPA-GMN-C04-KENBYOMEI
      *
           MOVE    2                   TO  SPA-GMN-C04-CUR
           .
       410011-BUNRUI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名番号選択処理
      *****************************************************************
       41002-SELNUM2-CHK-SEC            SECTION.
      *                                     
           MOVE    2                   TO  SPA-GMN-C04-CUR
      *
      *    病名コードが６つのとき
           IF      SPA-NAI-C04-BYOMEICD-MAX
                                       =   6
               MOVE    99                  TO  SPA-GMN-C04-CUR
               MOVE    "0013"              TO  SPA-ERRCD
               GO  TO  41002-SELNUM2-CHK-EXT
           END-IF
      *
      *    変更処理のとき      
           IF      SPA-NAI-C04-BYOMEICD-MAX
                                       =   1
           AND     SPA-GMN-C02-BANGO   >   ZERO               
               MOVE    99                  TO  SPA-GMN-C04-CUR
               MOVE    "0003"              TO  SPA-ERRCD
               GO  TO  41002-SELNUM2-CHK-EXT
           END-IF
      *
      
           MOVE    ZERO                TO  SPA-NAI-C04-SELNUM2
      *
           MOVE    C04-SELNUM2         TO  SPA-GMN-C04-SELNUM2
      *
           IF      SPA-GMN-C04-SELNUM2 =   ZERO
               CONTINUE
           ELSE    
               IF      SPA-GMN-C04-SELNUM2 >   SPA-GMN-C04-MAX
                   MOVE    "0012"              TO  SPA-ERRCD
               ELSE
                   MOVE    SPA-GMN-C04-SELNUM2 TO  SPA-NAI-C04-SELNUM2 
                   PERFORM 410021-INPUTCD-HENSYU-SEC
               END-IF    
           END-IF
      *
           .
       41002-SELNUM2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択病名編集処理
      *****************************************************************
       410021-INPUTCD-HENSYU-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-HAISIYMDH
      *     
      *    同一病名入力のとき
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       6
               IF      SPA-GMN-C04-INPUTCD (IDZ)
                                   NOT =   SPACE     
               AND     SPA-GMN-C04-TINPUTCD (SPA-NAI-C04-SELNUM2)
                                       =   SPA-GMN-C04-INPUTCD (IDZ)
                   MOVE    "0002"          TO  SPA-ERRCD
                   MOVE    6               TO  IDZ
               END-IF
           END-PERFORM
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    ZERO            TO  SPA-NAI-C04-BYOMEICD-MAX
      *      
               PERFORM VARYING IDZ     FROM    1   BY  1
                       UNTIL   IDZ     >       6
                   IF      SPA-GMN-C04-INPUTCD (IDZ)  =   SPACE     
                       MOVE    SPA-GMN-C04-TINPUTCD
                                           (SPA-NAI-C04-SELNUM2)
                                       TO  SPA-GMN-C04-INPUTCD (IDZ)
                       MOVE    SPA-GMN-C04-TBYOMEI
                                           (SPA-NAI-C04-SELNUM2)
                                       TO  SPA-NAI-C04-BYOMEI  (IDZ)
      *                廃止年月日がある病名のチェック
                       INITIALIZE                  USERBYOMEI-REC
                       MOVE    SPA-HOSPID      TO  USBYO-HOSPID
                       MOVE    SPA-GMN-C04-INPUTCD (IDZ)
                                               TO  USBYO-BYOMEIINPUTCD
                       PERFORM 900-USBYO-INV-SEC
                       IF      FLG-USERBYOMEI      =   ZERO
                       AND     USBYO-BYOMEIHENFLG  =   SPACE 
                           PERFORM 4100211-HAISIYMD-CHECK-SEC
                       END-IF    
                       MOVE    6           TO  IDZ
                   END-IF
      *         
                   ADD     1           TO  SPA-NAI-C04-BYOMEICD-MAX    
               END-PERFORM
      *                                     
               PERFORM 3100-BYOMEI-HENSYU-SEC
           END-IF    
      *     
           MOVE    ZERO                TO  SPA-GMN-C04-SELNUM2
                                           SPA-NAI-C04-SELNUM2 
      *
           IF      SPA-ERRCD           =   SPACE
               CONTINUE
           ELSE
               GO  TO  410021-INPUTCD-HENSYU-EXT
           END-IF
      *
           IF      WRK-HAISIYMDH       =   SPACE
               CONTINUE
           ELSE
               MOVE    "0075"              TO  SPA-ERRCD
           END-IF                     
      *
           .
       410021-INPUTCD-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    廃止年月日チェック処理
      *****************************************************************
       4100211-HAISIYMD-CHECK-SEC      SECTION.
      * 
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       6
                   OR      USBYO-BYOMEICD (IDX1)   =   SPACE
               MOVE    USBYO-BYOMEICD (IDX1)
                                       TO  BYO-BYOMEICD
               MOVE    ZERO            TO  FLG-BYOMEI
               PERFORM 900-BYOMEI-READ-SEC
               IF      FLG-BYOMEI          =   ZERO
                   IF      BYO-IKOSAKICD       =   SPACE
                       IF      BYO-HAISIYMD        =   ALL "9"
                                                   OR  SPACE
                           CONTINUE
                       ELSE
                           MOVE    BYO-HAISIYMD    TO  WRK-SYMD
                           PERFORM 5002-HIZUKE-HEN-SEC
                           MOVE    LNK-DAY2-EDTYMD3
                                                   TO  WRK-HAISIYMDH
                           MOVE    6           TO  IDX1                     
                       END-IF
                   END-IF                
               END-IF
           END-PERFORM                
           .
        4100211-HAISIYMD-CHECK-EXT.
           EXIT.         
      *
      *****************************************************************
      *    病名編集処理
      *****************************************************************
       3100-BYOMEI-HENSYU-SEC      SECTION.
      * 
           MOVE    SPA-NAI-C04-BYOMEI (1)  TO  WRK-BYOMEI
      *     
           PERFORM VARYING IDX FROM    2   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-C04-INPUTCD (IDX)   NOT =   SPACE
                   STRING  WRK-BYOMEI              DELIMITED  BY  SPACE
                           "／"                    DELIMITED  BY  SIZE
                           SPA-NAI-C04-BYOMEI(IDX) DELIMITED  BY  SPACE
                                  INTO             WRK-BYOMEI
               END-IF    
           END-PERFORM    
           MOVE    WRK-BYOMEI          TO  SPA-GMN-C04-BYOMEI
           .
       3100-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名コードチェック処理
      *****************************************************************
       41003-INPUTCD-CHK-SEC          SECTION.
      *
           MOVE    2               TO  SPA-GMN-C04-CUR
      *
           MOVE    SPACE               TO  WRK-HAISIYMDH
      *
           MOVE    MCP-WIDGET      TO  WRK-WIDGET
           MOVE    WRK-WIDGET2     TO  IDZ
      *
           COMPUTE SPA-GMN-C04-CUR =   SPA-GMN-C04-CUR    +   IDZ
      *
      *    半角チェック
           IF      C04-INPUTCD (IDZ)   =   SPACE
               CONTINUE
           ELSE    
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    C04-INPUTCD (IDZ)   TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-RC2         =   ZERO
                   MOVE    KANACHK-OUT-INPUT   TO  C04-INPUTCD (IDZ)
               ELSE
                   MOVE    "0072"              TO  SPA-ERRCD
                   GO  TO  41003-INPUTCD-CHK-EXT
               END-IF
           END-IF    
      *
           MOVE    C04-INPUTCD (IDZ)   TO  SPA-GMN-C04-INPUTCD(IDZ)
      *
           IF      SPA-GMN-C04-INPUTCD (IDZ)   =   SPACE
               MOVE    SPACE               TO  SPA-NAI-C04-BYOMEI (IDZ)
           ELSE
               INITIALIZE                  USERBYOMEI-REC
               MOVE    SPA-HOSPID          TO  USBYO-HOSPID
               MOVE    SPA-GMN-C04-INPUTCD(IDZ)
                                           TO  USBYO-BYOMEIINPUTCD
               PERFORM 900-USBYO-INV-SEC                            
               IF      FLG-USERBYOMEI      =   ZERO
      *            同一病名入力のとき
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       6
                       IF      IDX         NOT =   IDZ     
                       AND     SPA-GMN-C04-INPUTCD (IDZ)
                                               =
                                           SPA-GMN-C04-INPUTCD(IDX)
                           MOVE    "0002"          TO  SPA-ERRCD
                           MOVE    6               TO  IDX
                       END-IF
                   END-PERFORM
               ELSE
                   MOVE    "0004"          TO  SPA-ERRCD    
               END-IF
               IF      SPA-ERRCD           =   SPACE    
                   MOVE    USBYO-BYOMEI    TO  SPA-NAI-C04-BYOMEI (IDZ)
               ELSE
                   MOVE    SPACE           TO  SPA-NAI-C04-BYOMEI (IDZ)
                                               SPA-GMN-C04-INPUTCD(IDZ)     
               END-IF
      *        廃止年月日がある病名のチェック
               IF      SPA-ERRCD           =   SPACE    
                   IF      USBYO-BYOMEIHENFLG  =   SPACE
                       PERFORM 4100211-HAISIYMD-CHECK-SEC
                   END-IF    
               END-IF       
           END-IF
      *
           MOVE    ZERO            TO  SPA-NAI-C04-BYOMEICD-MAX
      *     
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       6
               IF      SPA-GMN-C04-INPUTCD (IDX)  NOT =   SPACE     
                   ADD     1           TO  SPA-NAI-C04-BYOMEICD-MAX
               END-IF    
           END-PERFORM
      *                                     
           PERFORM 3100-BYOMEI-HENSYU-SEC
      *         
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-GMN-C04-CUR     =   8
                   MOVE    2                   TO  SPA-GMN-C04-CUR
               ELSE                                   
                   ADD     1                   TO  SPA-GMN-C04-CUR
               END-IF
           END-IF    
      *
           IF      WRK-HAISIYMDH       =   SPACE
               CONTINUE
           ELSE
               MOVE    "0075"              TO  SPA-ERRCD
           END-IF                     
           .
       41003-INPUTCD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索病名チェック処理
      *****************************************************************
       41004-KENBYOMEI-CHK-SEC          SECTION.
      *
           MOVE    1                  TO  SPA-GMN-C04-CUR
      *         
           MOVE    C04-KENBYOMEI      TO  SPA-GMN-C04-KENBYOMEI
      *
           IF      SPA-GMN-C04-KENBYOMEI  =   SPACE
               CONTINUE
           ELSE
      *        半角チェック
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-C04-KENBYOMEI
                                           TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "2"
                   MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-C04-KENBYOMEI
      *************CONTINUE
               ELSE
                   MOVE    "0071"              TO  SPA-ERRCD
                   GO  TO  41004-KENBYOMEI-CHK-EXT
               END-IF
               PERFORM 410041-BYOMEI-KENSAKU-SEC
           END-IF    
      *
           MOVE    2                  TO  SPA-GMN-C04-CUR
           .
       41004-KENBYOMEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名検索
      *****************************************************************
       410041-BYOMEI-KENSAKU-SEC          SECTION.
      *
           MOVE    "USERBYOMEI-KEY8"       TO  WRK-PATH                         
           PERFORM 410011-BUNRUI-HENSYU-SEC
           .
       410041-BYOMEI-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名行選択処理
      *****************************************************************
       41020-BYOMEISEL-SEC       SECTION.
      *
      *    病名コードが６つのとき
           IF      SPA-NAI-C04-BYOMEICD-MAX
                                       =   6
               MOVE    99                  TO  SPA-GMN-C04-CUR
               MOVE    "0013"              TO  SPA-ERRCD
               GO  TO  41020-BYOMEISEL-EXT
           END-IF
      *
      *    変更処理のとき      
           IF      SPA-NAI-C04-BYOMEICD-MAX
                                       =   1
           AND     SPA-GMN-C02-BANGO   >   ZERO                             
               MOVE    99                  TO  SPA-GMN-C04-CUR
               MOVE    "0003"              TO  SPA-ERRCD
               GO  TO  41020-BYOMEISEL-EXT
           END-IF
      * 
           MOVE    ZERO                TO  WRK-SELNO
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-C04-MAX
               IF      C04-BYOMEILST-SELECT (IDX)    =   "T"
                   MOVE    IDX                  TO  WRK-SELNO
                   MOVE    SPA-GMN-C04-MAX      TO  IDX
               END-IF
           END-PERFORM
      *
           MOVE    WRK-SELNO           TO  SPA-NAI-C04-SELNUM2 
           PERFORM 410021-INPUTCD-HENSYU-SEC
           .
       41020-BYOMEISEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    分類名行選択処理
      *****************************************************************
       41021-BUNRUILST-SEC       SECTION.
      *          
      *    行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-C04-BUNRUI-MAX
               IF      C04-BUNRUI-SELECT (IDX)    =   "T"
                   IF      IDX             =   SPA-NAI-C04-SELNUM1
                       CONTINUE
                   ELSE        
                       MOVE    IDX                     TO  WRK-SELNO
                       MOVE    SPA-GMN-C04-BUNRUI-MAX  TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-C04-SELNUM1
                                               SPA-GMN-C04-SELNUM1
           END-IF
      *
           MOVE    "USERBYOMEI-KEY7"   TO  WRK-PATH                         
           PERFORM 410011-BUNRUI-HENSYU-SEC
           .
       41021-BUNRUISEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "C02"               TO  SPA-SAKIPG
           MOVE    "C04"               TO  SPA-MOTOPG
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
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
      *    全分類編集処理
      *****************************************************************
       450-BUNRUI-HENSYU-SEC           SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN-C04-SELNUM1
                                           SPA-NAI-C04-SELNUM1
      *     
           MOVE    "USERBYOMEI-KEY3"   TO  WRK-PATH                         
           PERFORM 410011-BUNRUI-HENSYU-SEC
      *
           MOVE    2                   TO  SPA-GMN-C04-CUR     
           .
       450-BUNRUI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定　処理
      *****************************************************************
       450-KAKUTEI-SEC             SECTION.
      *
           MOVE    ZERO            TO  IDY
      *     
           INITIALIZE                  SPA-C01KYOUTU 
      *     
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       6
               IF      SPA-GMN-C04-INPUTCD (IDX)   NOT =   SPACE
                   ADD     1           TO  IDY    
                   MOVE    SPA-GMN-C04-INPUTCD  (IDX)
                                       TO  SPA-C01-TBYOMEICD (IDY) 
           END-PERFORM
           MOVE    SPA-C01KYOUTU   TO  SPA-WORK
      *
           PERFORM 210-BACK
           .
       450-KAKUTEI-EXT.
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
               MOVE    SPACE               TO  WRK-NENGO
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
               MOVE    LNK-DAY2-EDTYMD2-G  TO  WRK-NENGO
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
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE
           MOVE    "C04    "           TO  MCP-WINDOW
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
           MOVE    SPACE               TO  C04
      *
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-C04-MAX
               MOVE    SPA-GMN-C04-TBANGO    (IDX)
                                           TO  WRK-NUM
               MOVE    WRK-NUM             TO  C04-TBANGO    (IDX)
               MOVE    SPA-GMN-C04-TINPUTCD(IDX)
                                           TO  C04-TBYOMEIINPUTCD(IDX)
               MOVE    SPA-GMN-C04-TBYOMEI    (IDX)
                                           TO  C04-TBYOMEI   (IDX)
           END-PERFORM
           MOVE    SPA-GMN-C04-MAX     TO  C04-BYOMEILST-COUNT
      *
           MOVE    SPA-GMN-C04-KENBYOMEI   TO  C04-KENBYOMEI
           MOVE    SPA-GMN-C04-SELNUM1     TO  C04-SELNUM1
           MOVE    SPA-GMN-C04-SELNUM2     TO  C04-SELNUM2
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL       IDX     >      6
               MOVE    SPA-GMN-C04-INPUTCD(IDX)   TO  C04-INPUTCD (IDX)
           END-PERFORM
           MOVE    SPA-GMN-C04-BYOMEI      TO  C04-BYOMEI
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-C04-BUNRUI-MAX
               MOVE    SPA-GMN-C04-BBUNRUICD (IDX)
                                           TO  C04-BBUNRUICD (IDX)
               MOVE    SPA-GMN-C04-BBUNRUIMEI(IDX)
                                           TO  C04-BBUNRUIMEI(IDX)
      *        
                IF      IDX             =   SPA-NAI-C04-SELNUM1
                   MOVE    "T"         TO  C04-BUNRUI-SELECT (IDX)
               ELSE
                   MOVE    "F"         TO  C04-BUNRUI-SELECT (IDX)
               END-IF
           END-PERFORM    
           MOVE    SPA-GMN-C04-BUNRUI-MAX  TO  C04-BUNRUI-COUNT
               
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
         EVALUATE    SPA-GMN-C04-CUR
             WHEN    1
                     MOVE  "KENBYOMEI"  TO  MCP-WIDGET
             WHEN    2
                     MOVE  "SELNUM2"    TO  MCP-WIDGET
             WHEN    3
                     MOVE  "INPUTCD1"   TO  MCP-WIDGET
             WHEN    4
                     MOVE  "INPUTCD2"   TO  MCP-WIDGET
             WHEN    5
                     MOVE  "INPUTCD3"   TO  MCP-WIDGET
             WHEN    6
                     MOVE  "INPUTCD4"   TO  MCP-WIDGET
             WHEN    7
                     MOVE  "INPUTCD5"   TO  MCP-WIDGET
             WHEN    8
                     MOVE  "INPUTCD6"   TO  MCP-WIDGET
             WHEN    9
                     MOVE  "SELNUM1"    TO  MCP-WIDGET
         END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
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
                   MOVE    "入力エラーです"            TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "既に同一病名入力コードが存在します" 
                                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE
                       "変更処理中なので病名はひとつしか入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "自院病名マスタが存在しません"
                                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象のデータが選択してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "項目に入力がありません"    TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "病名入力コード入力エラー" 
                                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "病名が入力されていません"  TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "病名コードの入力でエラーがあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "選択番号入力エラー"        TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE    "これ以上選択できません"    TO  SPA-ERRMSG
               WHEN    "0071"
                   MOVE    "全角入力して下さい"       TO  SPA-ERRMSG
               WHEN    "0072"
                   MOVE    "全角または半角のみで入力して下さい" 
                                                       TO  SPA-ERRMSG
               WHEN    "0075"
                   MOVE    "入力された病名はマスター上で"
                                       TO  SPA-ERRMSG
                   MOVE    WRK-HAISIYMDH
                                       TO  SPA-ERRMSG (29:22)
                   MOVE    "で廃止の扱いとなっています。"
                                       TO  SPA-ERRMSG (51:)
               WHEN    "1003"
                   MOVE    "自院病名マスタが存在しません"
                                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WRK-HAISIYMDH     
      *
           MOVE    SPACE                TO  CERR
           MOVE    SPA-ERRCD            TO  CERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  CERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "C04"                TO  SPA-MOTOPG
           MOVE    "CERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "CERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名マスター読込（主キー）
      *****************************************************************
       900-USBYO-INV-SEC         SECTION.
      *
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY6"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "USERBYOMEI-KEY6"   TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-USERBYOMEI
               INITIALIZE                  USERBYOMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY6"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-USBYO-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名マスター読込
      *****************************************************************
       900-USBYO-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  USERBYOMEI-REC
               MOVE    ZERO            TO  FLG-USERBYOMEI
           ELSE
               INITIALIZE                  USERBYOMEI-REC
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           .
       900-USBYO-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-READ-SEC         SECTION.
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  BYOMEI-REC
                   MOVE    ZERO                TO  FLG-BYOMEI
               ELSE
                   MOVE    1                   TO  FLG-BYOMEI
                   INITIALIZE                  BYOMEI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-BYOMEI
               INITIALIZE                  BYOMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-BYOMEI-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *
