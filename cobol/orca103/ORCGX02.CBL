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
       PROGRAM-ID.                               ORCGX02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : チェックマスタ情報設定
      *  コンポーネント名  : チェックマスタ情報設定（Ｘ０２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/02/01  病名コードを７桁に変更
      *                                     削除ボタンの追加
      *  01.00.02    MCC-藤原     02/04/05  項目数を１００に変更
      *  01.00.03    MCC-多々納   02/04/26  印刷の追加      
      *  01.00.04    NACL-伊藤    02/10/24  薬剤と病名の時明細表示頁に      
      *                                     よる添字のバグ修正
      *  01.00.05    NACL-多々納  02/11/18  一括入力変更
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
      *    チェックマスタ情報設定用共通パラメタ
           COPY    "X01COMMON-SPA".
      *
      *    チェックマスタ情報用画面スパ
           COPY    "X01SCR-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-X02.
           03  SPA-X02-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD    PIC X(09).
                   07  SPA-GMN-EDYUKYMD    PIC X(09).
                   07  SPA-GMN-CHKKBN-G.
                       09  SPA-GMN-CHKKBN      PIC X(01).
                       09  SPA-GMN-CHKKBNFIL   PIC X(01).
                       09  SPA-GMN-CHKKBNANME  PIC X(48).
                   07  SPA-GMN-SRYCD       PIC X(09).
                   07  SPA-GMN-NAME        PIC X(100).              
                   07  SPA-GMN-TBL.
      *****************09  SPA-GMN-TBLO    OCCURS  60.
                       09  SPA-GMN-TBLO    OCCURS  100.
                           11  SPA-GMN-TTEKCD     PIC X(09).
                           11  SPA-GMN-TNAME      PIC X(100).
                           11  SPA-MAE-TTEKCD     PIC X(09).
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBLO    OCCURS  100.
                           11  SPA-NAI-ERR        PIC X(01).
      *
           COPY    "ENUM-VALUE".
      *     
       01  WRK-CONS-MAX                   PIC 9(03)   VALUE   100. 
       01  WRK-CONS-PAGE                  PIC 9(02)   VALUE   5.
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                            PIC 9(01).
           03  FLG-CHK                            PIC 9(01).
           03  FLG-TENSU                          PIC 9(01).
           03  FLG-BYOMEI                         PIC 9(01).
      *
           03  FLG-OK                             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                               PIC 9(03).
           03  IDY                               PIC 9(03).
           03  IDZ                               PIC 9(03).
           03  IDZ1                              PIC 9(03).
           03  IDX2                              PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-XIDMSG          PIC X(70). 
           03  WRK-WIDGET.
               05  WRK-WIDGET1     PIC X(05).
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
      *    入力項目名
           03  WRK-MCP-WIDGET          PIC X(64).
      *    最終行
           03  WRK-MAX                 PIC 9(04).
      *
           03  WRK-NAME                PIC X(200).
      *
       01  TBL-AREA.
           03  TBL-GMN-AREA.
               05  TBL-GMN-TBLO    OCCURS  100.
                   07  TBL-GMN-TTEKCD     PIC X(09).
                   07  TBL-GMN-TNAME      PIC X(100).
                   07  TBL-MAE-TTEKCD     PIC X(09).
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
                    
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    一覧印刷変換領域
           COPY    "CPORCHXLST.INC".
      *
      *    ＤＢ検索
      *01  MCPDATA-REC                 PIC X(5000).
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
           COPY    "X01.INC".
           COPY    "X02.INC".
           COPY    "X98.INC". 
           COPY    "XERR.INC".
           COPY    "XID1.INC".
      *
       PROCEDURE                                 DIVISION    USING
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
           MOVE    SPA-WORK        TO  SPA-X01KYOUTU 
           MOVE    SPA-FREE        TO  SPA-X01FREE
           MOVE    SPA-X01SONOTA   TO  SPA-X02 
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
           MOVE    SPA-X01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-X02         TO  SPA-X01SONOTA
           MOVE    SPA-X01FREE     TO  SPA-FREE    
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
           IF      SPA-MOTOPG          =   "XERR"
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
               PERFORM 510-GSRAUTH-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
      **** MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "X02    "           TO  MCP-WINDOW.
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
               WHEN    "X98"
      *    病名セット処理
                   PERFORM 320-X98SPASET-SEC
                   GO      TO      300-SCREEN-EXT
               WHEN    "XID1"
                   PERFORM 330-XID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           MOVE    1               TO  SPA-GMN-PAGE
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
           INITIALIZE              SPA-X02-AREA
      *
           MOVE    SPA-X01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-X01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
           MOVE    SPA-X01-CHKKBN-G    TO  SPA-GMN-CHKKBN-G
           MOVE    SPA-X01-SRYCD       TO  SPA-GMN-SRYCD
           MOVE    SPA-X01-NAME        TO  SPA-GMN-NAME
      *
      *    チェックマスタ読み込み 
           INITIALIZE                  CHK-REC
           MOVE    SPA-X01-CHKKBN      TO  CHK-CHKKBN
           MOVE    SPA-X01-SRYCD       TO  CHK-SRYCD
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    SPA-X01-STYUKYMD    TO  ORC-DBYMD
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "CHK-KEY2"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "CHK-KEY2"         TO  ORC-DBPATH
               PERFORM 900-CHK-READ-SEC
           ELSE
               INITIALIZE                  CHK-REC
               MOVE    1               TO  FLG-CHK
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM UNTIL      (IDX     =  WRK-CONS-MAX  )  OR
                              (FLG-CHK =   1            )
               MOVE    MCPDATA-REC          TO  CHK-REC
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY         >   10
                       OR      CHK-CD (IDY)    =   SPACE 
                   ADD     1               TO  IDX 
                   MOVE    CHK-CD (IDY)    TO  SPA-GMN-TTEKCD (IDX)
                   MOVE    SPA-GMN-TTEKCD (IDX)
                                           TO  SPA-MAE-TTEKCD (IDX)
                   EVALUATE    SPA-GMN-CHKKBN
                       WHEN    "1"
                       WHEN    "2"  
      *                病名マスタ読み込み
                           INITIALIZE               BYOMEI-REC
                           MOVE    CHK-CD (IDY)     TO  BYO-BYOMEICD
                           MOVE    BYOMEI-REC       TO  MCPDATA-REC 
                           PERFORM 900-BYOMEI-READ-SEC
                           IF      FLG-BYOMEI       =   ZERO
                               MOVE    MCPDATA-REC  TO  BYOMEI-REC
                               MOVE    BYO-BYOMEI   TO  SPA-GMN-TNAME
                                                                  (IDX)
                           END-IF
                       WHEN    "3"
                           CONTINUE
                       WHEN    "4"
                       WHEN    "5"  
      *                点数マスタ読み込み
                           PERFORM 3101-TENNAME-SEC
               END-PERFORM
      *
               MOVE    "CHK-KEY2"              TO  ORC-DBPATH
               PERFORM 900-CHK-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "CHK-KEY2"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      * 
      *
           MOVE    IDX             TO  SPA-GMN-MAX
           COMPUTE SPA-GMN-PAGE    =   (SPA-GMN-MAX - 1)
                                   /   20  + 1
           MOVE    1               TO  SPA-GMN-CUR 
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為コードセット処理
      *****************************************************************
       3101-TENNAME-SEC          SECTION.
      *
           INITIALIZE                      TNS-TENSU-REC
           MOVE    CHK-CD (IDY)        TO  TNS-SRYCD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               PERFORM 900-TENSU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF
           MOVE    ZERO                TO  FLG-OK
           MOVE    SPACE               TO  WRK-NAME
           PERFORM
               UNTIL     FLG-TENSU     =   1
      *
               IF      (SPA-X01-STYUKYMD   >=  TNS-YUKOSTYMD )  AND
                       (SPA-X01-EDYUKYMD   <=  TNS-YUKOEDYMD )
                   MOVE    TNS-NAME        TO  SPA-GMN-TNAME (IDX)
                   MOVE    1               TO  FLG-TENSU
                   MOVE    1               TO  FLG-OK
               ELSE
                   MOVE    TNS-NAME        TO  WRK-NAME
               END-IF
      *
               IF      FLG-TENSU           =   ZERO
                   MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
                   PERFORM 900-TENSU-READ-SEC
               END-IF
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF     (FLG-OK              =   ZERO ) AND
                  (WRK-NAME        NOT =   SPACE)
               MOVE    SPACE               TO  SPA-GMN-TNAME (IDX)
               STRING      "★削除済★"    DELIMITED   BY  SIZE
                           WRK-NAME        DELIMITED   BY  SIZE
                                           INTO    SPA-GMN-TNAME (IDX)
               END-STRING
           END-IF
      *
           .
       3101-TENNAME-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為コードセット処理
      *****************************************************************
       320-X98SPASET-SEC          SECTION.
      *
           IF      SPA-X98-SRYCD   NOT =   SPACE
               MOVE    SPA-X98-SRYCD       TO  X02-TEKCD(SPA-GMN-CUR)
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
           END-IF
           .
       320-X98SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-XID1-SET-SEC            SECTION.
      *
           IF      SPA-XID1-FLG        =   "OK"
               IF      SPA-XIDCD           =   "1002"
                   PERFORM 4031-DEL-SEC
               ELSE
                   PERFORM 490-KOUSHIN-SEC
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  SPA-XID1-FLG
           MOVE    SPACE           TO  SPA-XIDCD
           .
       330-XID1-SET-EXT.
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
      *        削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM  403-DEL-SEC
      *    前画面
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 430-MAEGMN-SEC
      *    次画面
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 440-ATOGMN-SEC
      *        検索
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM  409-KENSAKU-SEC
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM  410-KAKUTEI-SEC
      *        印刷
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM  411-PRINT-SEC
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
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
      *
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
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   20
               COMPUTE IDZ             =   IDX
                                       +  (SPA-GMN-PAGE - 1 ) * 20
               EVALUATE    SPA-GMN-CHKKBN
                   WHEN    "1"
                   WHEN    "2" 
                       MOVE  X02-TEKCD (IDX)(1:7)
                                              TO  SPA-GMN-TTEKCD (IDZ)
                   WHEN    OTHER
                       MOVE  X02-TEKCD (IDX)  TO  SPA-GMN-TTEKCD (IDZ)
               END-EVALUATE
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
      *    チェック区分
           PERFORM 4101-TEKCD-CHK-SEC
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
           MOVE    "X01"               TO  SPA-SAKIPG
           MOVE    "X02"               TO  SPA-MOTOPG
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
      *  　診療行為コードチェック
      *****************************************************************
       4101-TEKCD-CHK-SEC                         SECTION.
      *
      *    空白をつめる
           PERFORM 41011-KUHAKU-SYORI-SEC
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   SPA-GMN-MAX   )  OR
                              (SPA-ERRCD   NOT =   SPACE )  OR
                              (FLG-END     NOT =   ZERO  )
      *
               IF     SPA-GMN-TTEKCD(IDX)(1:1) =   "/"
                   COMPUTE SPA-GMN-CUR         =   IDX
                                               -  ((SPA-GMN-PAGE  -  1)
                                               *   20 )
                   PERFORM  409-KENSAKU-SEC
               ELSE
      *            変更のあった時チェック
                   IF      SPA-GMN-TTEKCD(IDX) NOT =
                                               SPA-MAE-TTEKCD(IDX)
                       EVALUATE    SPA-GMN-CHKKBN
                           WHEN    "1"
                           WHEN    "2" 
                               PERFORM 41012-BYOMEI-CHK-SEC
                           WHEN    OTHER
                               PERFORM 41013-TENSU-CHK-SEC
                       END-EVALUATE
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4101-TEKCD-CHK-EXT
           END-IF
      *
      *    同一コードチェック
           PERFORM 41014-JYUFUKU-CHK-SEC
      *
           .
       4101-TEKCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    空白削除処理
      *****************************************************************
       41011-KUHAKU-SYORI-SEC             SECTION.
      *
           INITIALIZE                      SPA-NAI-TBL
      *
           MOVE    SPACE               TO  TBL-AREA
           INITIALIZE                      TBL-AREA
           MOVE    SPA-GMN-TBL         TO  TBL-GMN-AREA
           INITIALIZE                      SPA-GMN-TBL
           MOVE    ZERO                TO  SPA-GMN-MAX
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   100
               IF      TBL-GMN-TTEKCD (IDX)    NOT =   SPACE
                   ADD     1               TO  SPA-GMN-MAX
                   MOVE    TBL-GMN-TBLO (IDX)
                                           TO  SPA-GMN-TBLO(SPA-GMN-MAX)
               END-IF
           END-PERFORM
           .
       41011-KUHAKU-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    病名マスタチェック処理
      *****************************************************************
       41012-BYOMEI-CHK-SEC            SECTION.
      *
      *    病名マスタ読み込み
           INITIALIZE                      BYOMEI-REC
           MOVE    SPA-GMN-TTEKCD (IDX)   TO  BYO-BYOMEICD
           MOVE    BYOMEI-REC             TO  MCPDATA-REC 
           PERFORM 900-BYOMEI-READ-SEC
           IF      FLG-BYOMEI          =   1
               MOVE    "0002"          TO  SPA-ERRCD
               MOVE    "1"             TO  SPA-NAI-ERR (IDX)
           ELSE
               MOVE    MCPDATA-REC         TO  BYOMEI-REC
               IF      BYO-BYOMEICD (1:1)  =   "Z"
                   MOVE    "0010"          TO  SPA-ERRCD
                   MOVE    "1"             TO  SPA-NAI-ERR (IDX)
               ELSE
                   MOVE    BYO-BYOMEI      TO  SPA-GMN-TNAME  (IDX)
                   MOVE    SPA-GMN-TTEKCD(IDX)
                                           TO  SPA-MAE-TTEKCD(IDX)
               END-IF 
           END-IF
           .
       41012-BYOMEI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタチェック処理
      *****************************************************************
       41013-TENSU-CHK-SEC            SECTION.
      *
      *    点数マスタ読み込み
           INITIALIZE                      TNS-TENSU-REC
           MOVE    SPA-GMN-TTEKCD (IDX)    TO  TNS-SRYCD
           MOVE    SPA-X01-EDYUKYMD        TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC           TO MCPDATA-REC
           PERFORM 900-TENSU-INV-SEC
           IF      FLG-TENSU           =   1
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    "1"             TO  SPA-NAI-ERR (IDX)
               GO       TO  41013-TENSU-CHK-EXT
           ELSE
               MOVE    TNS-NAME        TO  SPA-GMN-TNAME (IDX)
           END-IF
      *
      *    診療行為コードのチェック
           EVALUATE    SPA-GMN-CHKKBN
               WHEN    "4"
                   IF      SPA-GMN-TTEKCD (IDX) (1:1) NOT =   "6"
                       MOVE    "0008"              TO  SPA-ERRCD
                       MOVE    "1"             TO  SPA-NAI-ERR (IDX)
                   END-IF
               WHEN    "5"
                   IF      SPA-GMN-TTEKCD (IDX) (1:1)  =   "6" OR
                                                           "7"
                       MOVE    "0008"              TO  SPA-ERRCD
                       MOVE    "1"             TO  SPA-NAI-ERR (IDX)
                   END-IF
           END-EVALUATE
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    SPA-GMN-TTEKCD (IDX)
                                          TO  SPA-MAE-TTEKCD (IDX)
           END-IF
           .
       41013-TENSU-CHK-EXT.
           EXIT.
           .
      *****************************************************************
      *    同一コードチェック処理
      *****************************************************************
       41014-JYUFUKU-CHK-SEC            SECTION.
      *
      *    同一コードチェック    
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   SPA-GMN-MAX  )  OR
                              (SPA-ERRCD   NOT =   SPACE)
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL      (IDY     >   SPA-GMN-MAX  )  OR
                                  (SPA-ERRCD   NOT =   SPACE)
                   IF      IDX             =   IDY
                       CONTINUE
                   ELSE
                       IF      SPA-GMN-TTEKCD (IDX)    =
                                                   SPA-GMN-TTEKCD (IDY)
                           MOVE    "0005"          TO  SPA-ERRCD
                           MOVE    "1"             TO  SPA-NAI-ERR (IDX)
                           MOVE    "1"             TO  SPA-NAI-ERR (IDY)
                       END-IF
                   END-IF
               END-PERFORM
           END-PERFORM
      *
           .
       41014-JYUFUKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       430-MAEGMN-SEC             SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      430-MAEGMN-EXT
           END-IF
      *
           IF      SPA-GMN-PAGE       =   1
               MOVE    "0006"             TO  SPA-ERRCD
               GO  TO  430-MAEGMN-EXT
           END-IF
           COMPUTE SPA-GMN-PAGE   =   SPA-GMN-PAGE    -   1
           MOVE    1                  TO  SPA-GMN-CUR
           .
       430-MAEGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       440-ATOGMN-SEC             SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      440-ATOGMN-EXT
           END-IF
      *
           IF      SPA-GMN-PAGE       =   WRK-CONS-PAGE
               MOVE    "0007"             TO  SPA-ERRCD
               GO  TO  440-ATOGMN-EXT
           ELSE
               COMPUTE IDX     =   SPA-GMN-PAGE   *   20
               IF      SPA-GMN-TTEKCD (IDX)   =   SPACE
                   MOVE    "0007"             TO  SPA-ERRCD
                   GO  TO  440-ATOGMN-EXT
               END-IF
           END-IF
           COMPUTE SPA-GMN-PAGE   =   SPA-GMN-PAGE    +   1
           MOVE    1                  TO  SPA-GMN-CUR
           .
       440-ATOGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                               SECTION.
      *
           MOVE    "1002"              TO  SPA-XIDCD
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
      *    チェックマスタ削除 
           INITIALIZE                  CHK-REC
           MOVE    SPA-X01-CHKKBN      TO  CHK-CHKKBN
           MOVE    SPA-X01-SRYCD       TO  CHK-SRYCD
           MOVE    SPA-X01-STYUKYMD    TO  CHK-YUKOSTYMD
           MOVE    SPA-X01-EDYUKYMD    TO  CHK-YUKOEDYMD
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "CHK-KEY4"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"                  TO  SPA-ERRCD
               GO  TO  4031-DEL-EXT
           END-IF
      *
           MOVE   "JOIN"               TO   MCP-PUTTYPE 
           PERFORM 210-BACK
           .
       4031-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索処理
      *****************************************************************
       409-KENSAKU-SEC             SECTION.
      *
      * 
           MOVE    "X02"               TO  SPA-MOTOPG
           MOVE    "X98"               TO  SPA-SAKIPG
           MOVE    "X02"               TO  SPA-X98-MOTOPG
      *
           MOVE    "INPUT"             TO  MCP-WIDGET 
      *
      *    共通ＳＰＡ編集
           INITIALIZE                  SPA-X98-AREA
           MOVE    "2"                 TO  SPA-X98-TYPE
      *
           INITIALIZE                  SPA-X98GMN-AREA
           EVALUATE    SPA-X01-CHKKBN
               WHEN    "1"
                   MOVE    "1"                 TO  SPA-X98-GMN-KBN
                   MOVE    "4"             TO  SPA-X98-GMN-SYORI
               WHEN    "3"
                   MOVE    "4"             TO  SPA-X98-GMN-SYORI
               WHEN    "4"
                   MOVE    "4"             TO  SPA-X98-GMN-SYORI
                   MOVE    "2"                 TO  SPA-X98-GMN-KBN
               WHEN    "2"
                   MOVE    "8"             TO  SPA-X98-GMN-SYORI
                   MOVE    "1"                 TO  SPA-X98-GMN-KBN
               WHEN    "5"
                   MOVE    "2"                 TO  SPA-X98-GMN-KBN
                   MOVE    "8"             TO  SPA-X98-GMN-SYORI
           END-EVALUATE
           MOVE    SPACE               TO  X98 
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE.
           MOVE   "X98    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       409-KENSAKU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       411-PRINT-SEC               SECTION.
      *
           INITIALIZE                  ORCHXLSTAREA
           MOVE    SPA-GMN-CHKKBN      TO  HXLST-CHKKBN
           MOVE    SPA-GMN-SRYCD       TO  HXLST-SRYCD
           CALL    "ORCHXLST"      USING   SPA-AREA
                                           ORCHXLSTAREA
      *
           .
       411-PRINT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    確定
      *****************************************************************
       410-KAKUTEI-SEC           SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-KAKUTEI-EXT
           END-IF
      *
           PERFORM 4901-KANRENCHK-SEC
           IF      SPA-ERRCD        =   SPACE
               MOVE    "1001"           TO  SPA-XIDCD
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
      *    チェックマスタ削除 
           INITIALIZE                  CHK-REC
           MOVE    SPA-X01-CHKKBN      TO  CHK-CHKKBN
           MOVE    SPA-X01-SRYCD       TO  CHK-SRYCD
           MOVE    SPA-X01-STYUKYMD    TO  CHK-YUKOSTYMD
           MOVE    SPA-X01-EDYUKYMD    TO  CHK-YUKOEDYMD
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "CHK-KEY4"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"                  TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-EXT
           END-IF
      *
      *    チェックマスタ追加
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDY
           PERFORM UNTIL   IDY     >=  SPA-GMN-MAX
               INITIALIZE                  CHK-REC
               MOVE    SPA-X01-CHKKBN      TO  CHK-CHKKBN
               MOVE    SPA-X01-SRYCD       TO  CHK-SRYCD
               MOVE    SPA-X01-STYUKYMD    TO  CHK-YUKOSTYMD
               MOVE    SPA-X01-EDYUKYMD    TO  CHK-YUKOEDYMD
               EVALUATE    SPA-X01-CHKKBN
                   WHEN    "1"
                   WHEN    "2"
                       MOVE    "1"             TO  CHK-CDKBN
                   WHEN    "3"
                       MOVE    "3"             TO  CHK-CDKBN
                   WHEN    "4" 
                   WHEN    "5"
                       MOVE    "2"             TO  CHK-CDKBN
               END-EVALUATE
      *
               ADD     1                   TO  IDX
               MOVE    IDX                 TO  CHK-RENNUM
               IF      CHK-RENNUM          =   1
                   MOVE    SPA-GMN-MAX         TO  CHK-TEKCDNUM
               END-IF 
               MOVE    ZERO                TO  IDZ         
               PERFORM UNTIL   IDZ     >=  10
                       OR      IDY     >=  SPA-GMN-MAX
                   ADD     1                   TO  IDY   
                   IF      SPA-GMN-TTEKCD (IDY)    NOT =   SPACE
                       ADD     1                       TO  IDZ
                       MOVE    SPA-GMN-TTEKCD (IDY)    TO  CHK-CD (IDZ)
                   END-IF
               END-PERFORM
               MOVE    CHK-REC             TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "CHK-KEY"           TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              NOT =   ZERO 
                   MOVE    "1001"                  TO  SPA-ERRCD
                   GO  TO  490-KOUSHIN-EXT
               END-IF      
           END-PERFORM    
      *
           MOVE   "JOIN"     TO   MCP-PUTTYPE 
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
      *
           MOVE    ZERO                 TO  SPA-GMN-MAX
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       WRK-CONS-MAX
               IF      SPA-GMN-TTEKCD  (IDX)   NOT =   SPACE
                   ADD     1                   TO  SPA-GMN-MAX
               END-IF
           END-PERFORM
           IF      SPA-GMN-MAX         =   ZERO
               MOVE    "0004"              TO  SPA-ERRCD
           END-IF   
           .
       4901-KANRENCHK-EXT.
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
           IF      SPA-XIDCD       NOT =   SPACE
               PERFORM 520-XIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "X02    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  X02
      *
           COMPUTE IDY     =   SPA-GMN-PAGE    *   20
           COMPUTE IDZ     =   IDY             -   19
      *
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  WRK-MAX
           PERFORM VARYING     IDZ1     FROM    IDZ   BY  1
                   UNTIL       IDZ1     >       IDY
               ADD     1                        TO  IDX
               MOVE    SPA-GMN-TTEKCD  (IDZ1)    TO  X02-TEKCD (IDX)
               MOVE    SPA-GMN-TNAME   (IDZ1)    TO  X02-DSPNAME  (IDX)
               IF      SPA-GMN-TTEKCD  (IDZ1)  NOT =   SPACE
                   MOVE    IDX                 TO  WRK-MAX
               END-IF
      *        エラー位置
               IF      SPA-NAI-ERR (IDZ1)  =   "1"
                   MOVE    IDX             TO  SPA-GMN-CUR
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-CHKKBN-G    TO  X02-CHKKBN
           MOVE    SPA-GMN-SRYCD       TO  X02-SRYCD
           MOVE    SPA-GMN-NAME        TO  X02-NAME
           MOVE    SPA-GMN-STYUKYMD    TO  X02-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD    TO  X02-EDYUKYMD
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
           MOVE    WIDGET-INSENSITIVE      TO  X02-B03-STATE
      *
           IF      SPA-X01-SELNUM          >   ZERO    
               MOVE    WIDGET-NORMAL      TO  X02-B03-STATE
           END-IF 
           .
       51O-GSRAUTH-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           IF      SPA-GMN-CUR         =   ZERO
               IF      WRK-MCP-WIDGET(1:5)     =   "TEKCD"
                   MOVE    WRK-MCP-WIDGET(6:2)     TO  IDX2
                   MOVE    IDX2                    TO  SPA-GMN-CUR
                   ADD     1                       TO  SPA-GMN-CUR
                   IF      SPA-GMN-CUR             >   20
                       MOVE    99                  TO  SPA-GMN-CUR
                   END-IF
               ELSE
                   COMPUTE SPA-GMN-CUR         =   WRK-MAX
                                               +   1
               END-IF
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
                WHEN   1
                    MOVE  "TEKCD01"    TO  MCP-WIDGET
                WHEN   2
                    MOVE  "TEKCD02"    TO  MCP-WIDGET
                WHEN   3
                    MOVE  "TEKCD03"    TO  MCP-WIDGET
                WHEN   4
                    MOVE  "TEKCD04"    TO  MCP-WIDGET
                WHEN   5
                    MOVE  "TEKCD05"    TO  MCP-WIDGET
                WHEN   6
                    MOVE  "TEKCD06"    TO  MCP-WIDGET
                WHEN   7
                    MOVE  "TEKCD07"    TO  MCP-WIDGET
                WHEN   8
                    MOVE  "TEKCD08"    TO  MCP-WIDGET
                WHEN   9
                    MOVE  "TEKCD09"    TO  MCP-WIDGET
                WHEN   10
                    MOVE  "TEKCD10"    TO  MCP-WIDGET
                WHEN   11
                    MOVE  "TEKCD11"    TO  MCP-WIDGET
                WHEN   12
                    MOVE  "TEKCD12"    TO  MCP-WIDGET
                WHEN   13
                    MOVE  "TEKCD13"    TO  MCP-WIDGET
                WHEN   14
                    MOVE  "TEKCD14"    TO  MCP-WIDGET
                WHEN   15
                    MOVE  "TEKCD15"    TO  MCP-WIDGET
                WHEN   16
                    MOVE  "TEKCD16"    TO  MCP-WIDGET
                WHEN   17
                    MOVE  "TEKCD17"    TO  MCP-WIDGET
                WHEN   18
                    MOVE  "TEKCD18"    TO  MCP-WIDGET
                WHEN   19
                    MOVE  "TEKCD19"    TO  MCP-WIDGET
                WHEN   20
                    MOVE  "TEKCD20"    TO  MCP-WIDGET
                 WHEN   99
                    MOVE  "B12"        TO  MCP-WIDGET
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
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "点数マスタにありません"   TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "病名マスタにありません"   TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "項目に入力がありません"   TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "適用コードに入力がありません"
                                                      TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "適用コードが重複しています"
                                                      TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "前頁はありません"         TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "次頁はありません"         TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "チェック区分に対して入力できないコードです"
                                                      TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "修飾語コードは入力できません"
                                                      TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"
                                                      TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "更新処理前の削除ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  XERR
           MOVE    SPA-ERRCD            TO  XERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  XERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "X02"                TO  SPA-MOTOPG
           MOVE    "XERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "XERR"               TO  MCP-WINDOW
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
       520-XIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-XIDMSG
      *
           EVALUATE    SPA-XIDCD
               WHEN    "1001"
                   MOVE    "チェックマスタ設定情報を登録します"
                                        TO  WRK-XIDMSG
               WHEN    "1002"
                   MOVE    "チェックマスタ設定情報を削除します"
                                        TO  WRK-XIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  XID1
           MOVE    SPA-XIDCD            TO  XID1-ID1CODE
           MOVE    WRK-XIDMSG           TO  XID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "X02"                TO  SPA-MOTOPG
           MOVE    "XID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "XID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-XIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-READ-SEC         SECTION.
      *
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
               MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
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
      *****************************************************************
      *    点数マスター読込（キー）
      *****************************************************************
       900-TENSU-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "TENSU-KEY"        TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *
           .
       900-TENSU-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込（キー）
      *****************************************************************
       900-TENSU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               MOVE    ZERO                TO  FLG-TENSU
           ELSE
               INITIALIZE                      TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           .
       900-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェックマスタ読み込み処理
      *****************************************************************
       900-CHK-READ-SEC         SECTION.
      *
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-CHK
           ELSE
               MOVE    1               TO  FLG-CHK
           END-IF
      *
           .
       900-CHK-READ-EXT.
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

