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
       PROGRAM-ID.                               ORCGX01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : チェックマスタ情報設定
      *  コンポーネント名  : チェックマスタ情報設定（Ｘ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01/07/03  日付入力チェックサブ追加
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.01.03    MCC-多々納   02/04/26  印刷の追加      
      *  01.01.04    NACL-多々納  02/10/02  添え字を数字へ修正
      *  01.01.05    NACL-多々納  02/11/18  一括入力・診療コード入力修正
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
       01  SPA-X01.
           03  SPA-X01-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-TBLO    OCCURS  100.
                           11  SPA-GMN-TBANGO     PIC 9(03).
                           11  SPA-GMN-TSTYUKYMD  PIC X(09).
                           11  SPA-GMN-TEDYUKYMD  PIC X(09).  
                   07  SPA-GMN-KOUMOKU.
                       09  SPA-GMN-CHKKBN-G.
                           11  SPA-GMN-CHKKBN     PIC X(01).
                           11  SPA-GMN-CHKKBNFL   PIC X(01).
                           11  SPA-GMN-CHKKBNNAME PIC X(20).
                       09  SPA-GMN-SRYCD          PIC X(09). 
                       09  SPA-GMN-NAME           PIC X(100).
                       09  SPA-GMN-KOUMOKU1.
                           11  SPA-GMN-SELNUM     PIC X(03).
                           11  SPA-GMN-STYUKYMD   PIC X(10).
                           11  SPA-GMN-EDYUKYMD   PIC X(10).
      *                 
                   07  SPA-GMN-CHKKBNLIST         OCCURS  9.
                       09  SPA-GMN-CHKKBNL        PIC X(01).
                       09  SPA-GMN-F1L            PIC X(01).
                       09  SPA-GMN-CHKKBNMEIL     PIC X(20).
                   07  SPA-GMN-CHKKBN-MAX         PIC 9(02).    
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-CHKKBN             PIC X(01).
                   07  SPA-NAI-SRYCD              PIC X(09). 
                   07  SPA-NAI-KOUMOKU1.
                       09  SPA-NAI-STYUKYMD       PIC 9(08).
                       09  SPA-NAI-EDYUKYMD       PIC 9(08).
                       09  SPA-NAI-SELNUM         PIC 9(03).
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBLO    OCCURS  100.
                           11  SPA-NAI-TSTYUKYMD  PIC 9(08).
                           11  SPA-NAI-TEDYUKYMD  PIC 9(08). 
                           11  SPA-NAI-NAME       PIC X(100).
                   07  SPA-MAE-SRYCD              PIC X(09). 
      *
              05  SPA-NAI-SELNO                   PIC 9(03).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                            PIC 9(01).
           03  FLG-CHK                            PIC 9(01).
           03  FLG-TENSU                          PIC 9(01).
      *
           03  FLG-OK                             PIC 9(01).
           03  FLG-TOUROKU                        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                               PIC 9(04).
           03  IDY                               PIC 9(04).
           03  IDZ                               PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SELNO           PIC 9(03).
           03  WRK-YMD             PIC X(10). 
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
      *
           03  WRK-INPUTCD             PIC X(09).
           03  WRK-CD-MCNT             PIC 9(02).
           03  FLG-KANJI               PIC 9(01).
           03  FLG-KENSAKU             PIC 9(01).
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
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *----(01.02.03) LINE ADD START ----------------------------------
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *----(01.02.03) LINE ADD END   ----------------------------------
      *
      *    一覧印刷変換領域
           COPY    "CPORCHXLST.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-X01KYOUTU 
           MOVE    SPA-FREE        TO  SPA-X01FREE
           MOVE    SPA-X01SONOTA   TO  SPA-X01 
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
           MOVE    SPA-X01         TO  SPA-X01SONOTA
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
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
      ***  MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "X01    "           TO  MCP-WINDOW.
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
           MOVE    1               TO  SPA-GMN-CUR
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG(1:3)
               WHEN    "X98"
      *    病名セット処理
                   PERFORM 320-X98SPASET-SEC
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
           INITIALIZE                  SPA-X01-AREA
                                       SPA-X01KYOUTU
      *
           MOVE    "1"                 TO  SPA-GMN-CHKKBNL    (1)
           MOVE    "薬剤と病名"        TO  SPA-GMN-CHKKBNMEIL (1)
           MOVE    "2"                 TO  SPA-GMN-CHKKBNL    (2)
           MOVE    "診療行為と病名"    TO  SPA-GMN-CHKKBNMEIL (2)
           MOVE    "3"                 TO  SPA-GMN-CHKKBNL    (3)
           MOVE    "薬剤と禁忌"        TO  SPA-GMN-CHKKBNMEIL (3)
           MOVE    "4"                 TO  SPA-GMN-CHKKBNL    (4)
           MOVE    "薬剤と併用禁忌"    TO  SPA-GMN-CHKKBNMEIL (4)
           MOVE    "5"                 TO  SPA-GMN-CHKKBNL    (5)
           MOVE    "診療行為の併用算定"
                                       TO  SPA-GMN-CHKKBNMEIL (5)
      *
           MOVE    1                   TO  SPA-GMN-CUR 
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為コードセット処理
      *****************************************************************
       320-X98SPASET-SEC          SECTION.
      *
           IF      SPA-X98-SRYCD   NOT =   SPACE    
      ******** MOVE    SPA-X98-SRYCD       TO  X01-SRYCD
               MOVE    SPA-X98-SRYCD       TO  SPA-GMN-SRYCD
               PERFORM 4104-SRYCD-CHK-SEC
           END-IF  
           .
       320-X98SPASET-EXT.
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
                   PERFORM  210-BACK
      *        クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 493-CLEAR-SEC
      *        検索
               WHEN    "CLICKED"       ALSO    "B09"
                   MOVE    SPACE               TO  WRK-INPUTCD
                   PERFORM  409-KENSAKU-SEC
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM  410-KAKUTEI-SEC
      *        検索
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
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        選択番号
               WHEN    "ACTIVATE"       ALSO    "SELNUM"
                   PERFORM  4101-SELNUM-CHK-SEC
      *        一括入力分
               WHEN    "ACTIVATE"       ALSO    ANY
                   PERFORM 400-ENTRY-SYORI-SEC
      *        行選択
               WHEN    ANY             ALSO    "TENSU_LIST"
                   PERFORM 41015-LIST1SEL-SEC
           END-EVALUATE
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "M02"               TO  SPA-SAKIPG
           MOVE    "X01"               TO  SPA-MOTOPG
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
      *
      *****************************************************************
      *    番号選択　入力処理
      *****************************************************************
       4101-SELNUM-CHK-SEC       SECTION.
      *
           INITIALIZE                  SPA-GMN-KOUMOKU1
                                       SPA-NAI-KOUMOKU1
           MOVE    ZERO                TO  SPA-NAI-SELNO
      *
           MOVE    X01-SELNUM          TO  SPA-GMN-SELNUM
      *
           INITIALIZE                     ORCSNUMAREA
           MOVE    SPA-GMN-SELNUM      TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    3                   TO  SPA-GMN-CUR
               MOVE    "0001"              TO  SPA-ERRCD
               GO      TO      4101-SELNUM-CHK-EXT
           ELSE
               MOVE    SNUM-OUTNUM     TO  SPA-NAI-SELNUM
            END-IF
      *
           IF      SPA-NAI-SELNUM      =   ZERO
               MOVE    SPA-GMN-MAX         TO  SPA-NAI-SELNUM
               MOVE    SPA-NAI-SELNUM      TO  SPA-GMN-SELNUM
           ELSE
      *        選択番号チェック
               IF      SPA-NAI-SELNUM      >=  1
               AND     SPA-NAI-SELNUM      <=  SPA-GMN-MAX   
                   CONTINUE
               ELSE
                   MOVE    3                   TO  SPA-GMN-CUR
                   MOVE    "0001"              TO  SPA-ERRCD
                   GO  TO  4101-SELNUM-CHK-EXT 
               END-IF
           END-IF
      *
           MOVE    SPA-NAI-SELNUM      TO  SPA-NAI-SELNO
      *
           PERFORM 41011-SELNUM-HENSYU-SEC
           .
       4101-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号編集処理
      *****************************************************************
       41011-SELNUM-HENSYU-SEC           SECTION.
      *
           MOVE    SPA-GMN-TSTYUKYMD(SPA-NAI-SELNO)
                                       TO  SPA-GMN-STYUKYMD
           MOVE    SPA-NAI-TSTYUKYMD(SPA-NAI-SELNO)
                                       TO  SPA-NAI-STYUKYMD
           MOVE    SPA-GMN-TEDYUKYMD(SPA-NAI-SELNO)
                                       TO  SPA-GMN-EDYUKYMD
           MOVE    SPA-NAI-TEDYUKYMD(SPA-NAI-SELNO)
                                       TO  SPA-NAI-EDYUKYMD
     *
           MOVE    SPA-NAI-NAME   (SPA-NAI-SELNO)
                                       TO  SPA-GMN-NAME
     *
           MOVE    4                   TO  SPA-GMN-CUR
           .
       41011-SELNUM-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    一括分　入力処理
      *****************************************************************
       400-ENTRY-SYORI-SEC       SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        チェック区分
               WHEN    "ACTIVATE"       ALSO    "CHKKBN"
                   INITIALIZE                  SPA-GMN-KOUMOKU
                   INITIALIZE                  SPA-NAI-SELNO
           END-EVALUATE
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
           MOVE    ZERO                TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       400-ENTRY-SYORI-EXT.
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
           MOVE    X01-CHKKBN          TO  SPA-GMN-CHKKBN-G
           MOVE    X01-SRYCD           TO  SPA-GMN-SRYCD
      *
           MOVE    X01-STYUKYMD        TO  SPA-GMN-STYUKYMD
           MOVE    X01-EDYUKYMD        TO  SPA-GMN-EDYUKYMD
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
           PERFORM  4105-CHKKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *    診療行為コード
           PERFORM  4104-SRYCD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    有効開始年月日
           PERFORM  4102-STYUKYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    有効終了年月日
           PERFORM 4103-EDYUKYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *  　チェック区分チェック
      *****************************************************************
       4105-CHKKBN-CHK-SEC             SECTION.
      *
           IF      SPA-GMN-CHKKBN      =   SPA-NAI-CHKKBN
               GO      TO      4105-CHKKBN-CHK-EXT
           END-IF
      *
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   9
               IF      SPA-GMN-CHKKBN      =   SPA-GMN-CHKKBNLIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-CHKKBNLIST(IDX)
                                           TO  SPA-GMN-CHKKBN-G
                   MOVE    9               TO  IDX
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0006"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-CUR
               GO      TO      4105-CHKKBN-CHK-EXT
           END-IF
           IF      SPA-GMN-CHKKBN      =   "3"
               MOVE    "0010"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-CUR
               GO      TO      4105-CHKKBN-CHK-EXT
           END-IF
      *
           INITIALIZE                  SPA-GMN-TBL
           INITIALIZE                  SPA-NAIB-AREA
           MOVE    ZERO                TO  SPA-GMN-MAX
      *
           MOVE    SPA-GMN-CHKKBN      TO  SPA-NAI-CHKKBN 
      *
           .
       4105-CHKKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    有効開始年月日チェック処理
      *****************************************************************
       4102-STYUKYMD-CHK-SEC          SECTION.
      *
      *
           IF      SPA-GMN-STYUKYMD    =   SPACE
               MOVE    ZERO                TO  SPA-NAI-EDYUKYMD
               IF     (SPA-GMN-EDYUKYMD    NOT =   SPACE      ) OR
                      (WRK-MCP-WIDGET      =   "STYUKYMD" ) OR
                      (WRK-MCP-WIDGET      =   "EDYUKYMD" ) OR
                      (FLG-TOUROKU         =   1          )
                   MOVE    "00000000"         TO  SPA-GMN-STYUKYMD
               END-IF
               GO      TO      4102-STYUKYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-STYUKYMD   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-SYMD             TO  SPA-NAI-STYUKYMD 
               MOVE    WRK-HENYMDG          TO  SPA-GMN-STYUKYMD
           ELSE
               MOVE    4                  TO  SPA-GMN-CUR
               MOVE    ZERO               TO  SPA-NAI-STYUKYMD
               GO  TO  4102-STYUKYMD-CHK-EXT
           END-IF
      *
           .
       4102-STYUKYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    有効終了年月日チェック処理
      *****************************************************************
       4103-EDYUKYMD-CHK-SEC          SECTION.
      *
      *
           IF      SPA-GMN-EDYUKYMD    =   SPACE
               MOVE    ZERO                TO  SPA-NAI-EDYUKYMD
               IF     (WRK-MCP-WIDGET      =   "EDYUKYMD" ) OR
                      (FLG-TOUROKU         =   1          )
                   MOVE    "99999999"         TO  SPA-GMN-EDYUKYMD
                   MOVE    ALL "9"            TO  SPA-NAI-EDYUKYMD
               END-IF
               GO      TO      4103-EDYUKYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-EDYUKYMD    TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-SYMD            TO  SPA-NAI-EDYUKYMD 
               MOVE    WRK-HENYMDG         TO  SPA-GMN-EDYUKYMD
           ELSE
               MOVE    5                  TO  SPA-GMN-CUR
               GO  TO  4103-EDYUKYMD-CHK-EXT
           END-IF
      *
           .
       4103-EDYUKYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　診療行為コードチェック
      *****************************************************************
       4104-SRYCD-CHK-SEC                         SECTION.
      *
      *
      *    検索へ
           IF      SPA-GMN-SRYCD(1:1)  =   "/"
               MOVE    SPACE               TO  WRK-INPUTCD
               PERFORM 409-KENSAKU-SEC
               GO                TO  4104-SRYCD-CHK-EXT
           END-IF
      *
           IF     (SPA-GMN-SRYCD       =   SPACE   )  AND
                  (WRK-MCP-WIDGET      =   "SRYCD" )
               MOVE    "0005"          TO  SPA-ERRCD
               MOVE    2               TO  SPA-GMN-CUR
               GO      TO      4104-SRYCD-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-SRYCD       =   SPA-MAE-SRYCD
               GO      TO      4104-SRYCD-CHK-EXT
           END-IF
      *
           INITIALIZE                  SPA-GMN-KOUMOKU1
                                       SPA-GMN-TBL
                                       SPA-NAI-KOUMOKU1
                                       SPA-NAI-SRYCD
                                       SPA-GMN-NAME
           MOVE    ZERO            TO  SPA-NAI-SELNO
                                       SPA-GMN-MAX
           IF      SPA-GMN-SRYCD       =   SPACE
               GO      TO      4104-SRYCD-CHK-EXT
           END-IF
      *
      *    入力コードチェック
           PERFORM 4010-SRYCD-CHK-SEC
           IF      FLG-KENSAKU         =   1
               GO      TO      4104-SRYCD-CHK-EXT
           END-IF
      *
      *    点数マスタ読み込み
           INITIALIZE                      TNS-TENSU-REC
           MOVE    SPA-GMN-SRYCD       TO  TNS-SRYCD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               PERFORM 900-TENSU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF
           IF      FLG-TENSU           =   1
               MOVE    "0005"          TO  SPA-ERRCD
               MOVE    2               TO  SPA-GMN-CUR
               GO      TO      4104-SRYCD-CHK-EXT
           ELSE
      *        最終履歴の名称をセットする
               PERFORM UNTIL       FLG-TENSU       =   1
                   MOVE    TNS-NAME            TO  SPA-GMN-NAME
      *
                   MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
                   PERFORM 900-TENSU-READ-SEC
               END-PERFORM
           END-IF
      *
           EVALUATE    SPA-GMN-CHKKBN
               WHEN    "1"
               WHEN    "3"
               WHEN    "4"
                   IF      SPA-GMN-SRYCD (1:1) NOT =   "6"
                       MOVE    "0008"              TO  SPA-ERRCD
                       MOVE    2               TO  SPA-GMN-CUR
                       GO                TO  4104-SRYCD-CHK-EXT
                   END-IF
               WHEN    "2"
               WHEN    "5"
                   IF      SPA-GMN-SRYCD (1:1)     =   "6" OR  "7"
                       MOVE    "0008"              TO  SPA-ERRCD
                       MOVE    2               TO  SPA-GMN-CUR
                       GO                TO  4104-SRYCD-CHK-EXT
                   END-IF
           END-EVALUATE
      *
           MOVE    SPA-GMN-SRYCD       TO  SPA-NAI-SRYCD
           MOVE    SPA-GMN-SRYCD       TO  SPA-MAE-SRYCD
      *
      *    チェックマスタ読み込み 
           INITIALIZE                  CHK-REC
           MOVE    SPA-GMN-CHKKBN      TO  CHK-CHKKBN
           MOVE    SPA-GMN-SRYCD       TO  CHK-SRYCD
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "CHK-KEY6"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "CHK-KEY6"         TO  ORC-DBPATH
               PERFORM 900-CHK-READ-SEC
           ELSE
               INITIALIZE                  CHK-REC
               MOVE    1               TO  FLG-CHK
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM UNTIL      (IDX     =  100  )  OR
                              (FLG-CHK =   1   )
               IF      CHK-RENNUM           =   1
                   ADD     1                    TO  IDX 
                   MOVE    IDX                  TO  SPA-GMN-TBANGO
                                                                 (IDX)
                   MOVE    CHK-YUKOSTYMD        TO  SPA-NAI-TSTYUKYMD
                                                                 (IDX)
                   MOVE    CHK-YUKOSTYMD         TO  WRK-SYMD
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG          TO  SPA-GMN-TSTYUKYMD
                                                                (IDX)
                   MOVE    CHK-YUKOEDYMD        TO  SPA-NAI-TEDYUKYMD
                                                                (IDX)
                   MOVE    CHK-YUKOEDYMD        TO  WRK-SYMD
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG          TO  SPA-GMN-TEDYUKYMD
                                                                (IDX)
      *
      *           点数マスタ読み込み
                   INITIALIZE                   TNS-TENSU-REC
                   MOVE    CHK-SRYCD            TO  TNS-SRYCD
                   MOVE    CHK-YUKOSTYMD        TO  ORC-DBYMD
                   MOVE    TNS-TENSU-REC        TO  MCPDATA-REC
      *
                   MOVE    "DBSELECT"           TO  MCP-FUNC
                   MOVE    "TENSU-KEY"          TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC              =   ZERO
                        MOVE    "TENSU-KEY"         TO  ORC-DBPATH
                        PERFORM 900-TENSU-READ-SEC
                   ELSE
                       MOVE    1                   TO  FLG-TENSU
                   END-IF
                   IF      FLG-TENSU           =   ZERO
                       MOVE    TNS-NAME            TO  SPA-NAI-NAME
                                                             (IDX)
                   END-IF
                   MOVE    IDX                  TO  SPA-GMN-MAX 
               END-IF
      *
               MOVE    "CHK-KEY6"              TO  ORC-DBPATH
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
           EVALUATE    SPA-GMN-MAX
               WHEN    ZERO
                   MOVE    4                       TO  SPA-GMN-CUR
               WHEN    1
                   MOVE    SPA-GMN-TSTYUKYMD (1)   TO  SPA-GMN-STYUKYMD
                   MOVE    SPA-NAI-TSTYUKYMD (1)   TO  SPA-NAI-STYUKYMD
                   MOVE    SPA-GMN-TEDYUKYMD (1)   TO  SPA-GMN-EDYUKYMD
                   MOVE    SPA-NAI-TEDYUKYMD (1)   TO  SPA-NAI-EDYUKYMD
                   MOVE    "001"                   TO  SPA-GMN-SELNUM
                   MOVE    1                       TO  SPA-NAI-SELNUM
                   MOVE    1                       TO  SPA-NAI-SELNO
                   MOVE    12                      TO  SPA-GMN-CUR
               WHEN    OTHER
                   MOVE    3                       TO  SPA-GMN-CUR
           END-EVALUATE
           .
       4104-SRYCD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　入力コードチェック処理
      *****************************************************************
       4010-SRYCD-CHK-SEC                        SECTION.
      *
           MOVE    ZERO               TO  FLG-KENSAKU
      *
           MOVE    ZERO               TO  WRK-CD-MCNT
           MOVE    ZERO               TO  FLG-KANJI
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN-SRYCD       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC      NOT =   ZERO
      *        全角半角混在エラー
               MOVE    "0007"              TO  SPA-ERRCD
               GO      TO    4010-SRYCD-CHK-EXT
           ELSE
               MOVE    KANACHK-MAX         TO  WRK-CD-MCNT
      *        全角
               IF      KANACHK-SYUBETU     =   2
                   MOVE    1               TO  FLG-KANJI
               ELSE
                   MOVE    ZERO            TO  FLG-KANJI
               END-IF
           END-IF
      *
      *    半角で９文字の時、点数マスタチェックへ
           IF     (WRK-CD-MCNT         =   9  )  AND
                  (FLG-KANJI           =   ZERO )  AND
                  (SPA-GMN-SRYCD       NUMERIC  )
               GO      TO    4010-SRYCD-CHK-EXT
           END-IF
      *
           MOVE    1                   TO  FLG-KENSAKU
           MOVE    SPA-GMN-SRYCD       TO  WRK-INPUTCD
           PERFORM 409-KENSAKU-SEC
      *
           .
       4010-SRYCD-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41015-LIST1SEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-MAX
               IF      X01-SELECT (IDX)    =   "T"
                   IF      IDX             =   SPA-NAI-SELNO 
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNO
                       MOVE    SPA-GMN-MAX      TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-SELNO 
           END-IF
      *
           MOVE    SPA-NAI-SELNO      TO  SPA-GMN-SELNUM
                                          SPA-NAI-SELNUM 
      *
           PERFORM 41011-SELNUM-HENSYU-SEC               
           .
       41015-LIST1SEL-EXT.
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
           IF      HXLST-RCD       NOT =   ZERO
               MOVE    "0009"          TO  SPA-ERRCD
           END-IF
      *
           .
       411-PRINT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    検索処理
      *****************************************************************
       409-KENSAKU-SEC             SECTION.
      *
      *    共通ＳＰＡ編集
           INITIALIZE                  SPA-X98-AREA
           MOVE    "2"                 TO  SPA-X98-TYPE
      *
           INITIALIZE                  SPA-X98GMN-AREA
           IF      WRK-INPUTCD         NOT =   SPACE
               EVALUATE    SPA-GMN-CHKKBN
                   WHEN    "1"
                   WHEN    "3"
                   WHEN    "4"
      *                薬剤
                       MOVE    "4"             TO  SPA-X98-GMN-SYORI
                   WHEN    "2"
                   WHEN    "5"
      *                診療行為
                       MOVE    "8"             TO  SPA-X98-GMN-SYORI
               END-EVALUATE
               MOVE    WRK-INPUTCD         TO  SPA-X98-INPUTCD
               MOVE    "1"                 TO  SPA-X98-TYPE
               IF      FLG-KANJI           =   1
                   MOVE    "J"             TO  SPA-X98-CDSYUBETU
               ELSE
                   IF      WRK-INPUTCD(1:1)    NUMERIC
                       EVALUATE    WRK-CD-MCNT
                           WHEN    3
                           WHEN    6
                               MOVE    "6"     TO  SPA-X98-CDSYUBETU
                           WHEN    4
                               MOVE    "4"     TO  SPA-X98-CDSYUBETU
                           WHEN    5
                               MOVE    "5"     TO  SPA-X98-CDSYUBETU
                       END-EVALUATE
                   ELSE
                       MOVE    "A"             TO  SPA-X98-CDSYUBETU
                   END-IF
               END-IF
               MOVE    "2"                 TO  SPA-X98-GMN-KBN
      *        画面編集
               PERFORM 41011-X98-SET-SEC
           ELSE
      *        画面編集
               MOVE    "2"                 TO  SPA-X98-GMN-KBN
               PERFORM 41011-X98-SET-SEC
           END-IF
      *
           MOVE    "X01"               TO  SPA-MOTOPG
           MOVE    "X98"               TO  SPA-SAKIPG
           MOVE    "X01"               TO  SPA-X98-MOTOPG
      *
           IF      SPA-X98-GMN-MAX     =   ZERO
               MOVE    "INPUT"             TO  MCP-WIDGET
           ELSE
               MOVE    "SELNUM"            TO  MCP-WIDGET
           END-IF
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE
           MOVE   "X98    "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       409-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索画面編集処理
      *****************************************************************
       41011-X98-SET-SEC                           SECTION.
      *
      *
           MOVE    SPA-X01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-X01         TO  SPA-X01SONOTA
           MOVE    SPA-X01FREE     TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGX98"           USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-X01KYOUTU 
           MOVE    SPA-FREE        TO  SPA-X01FREE
           MOVE    SPA-X01SONOTA   TO  SPA-X01 
      *
           .
       41011-X98-SET-EXT.
           EXIT.
      *****************************************************************
      *    項目クリア
      *****************************************************************
       493-CLEAR-SEC                   SECTION.
      *
           PERFORM 310-SPASET-SEC
           MOVE    1               TO  SPA-GMN-PAGE
      *
           .
       491-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定
      *****************************************************************
       410-KAKUTEI-SEC           SECTION.
      *
           MOVE    1                   TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO  TO  410-KAKUTEI-EXT
           END-IF
      *
           IF      SPA-NAI-STYUKYMD        =   ZERO
               IF      SPA-GMN-STYUKYMD(1:8)   =   ALL "0"
                   CONTINUE
               ELSE    
                   MOVE    2                   TO  SPA-GMN-CUR
                   MOVE    "0003"              TO  SPA-ERRCD
                   GO  TO  410-KAKUTEI-EXT
               END-IF    
           END-IF
           IF     (SPA-NAI-EDYUKYMD    =   ZERO   )
           OR     (SPA-NAI-CHKKBN      =   SPACE  )
           OR     (SPA-NAI-SRYCD       =   SPACE  )
               MOVE    2                   TO  SPA-GMN-CUR
               MOVE    "0003"              TO  SPA-ERRCD
               GO  TO  410-KAKUTEI-EXT
           END-IF
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-MAX
                   OR      SPA-ERRCD   NOT =   SPACE
               IF      SPA-NAI-SELNUM      =   IDX 
                   CONTINUE
               ELSE
                   IF      SPA-NAI-STYUKYMD    >=  SPA-NAI-TSTYUKYMD
                                                                  (IDX)
                   AND     SPA-NAI-STYUKYMD    <=  SPA-NAI-TEDYUKYMD
                                                                  (IDX)
                       MOVE    "0004"              TO  SPA-ERRCD 
                   END-IF
                   IF      SPA-NAI-EDYUKYMD    >=  SPA-NAI-TSTYUKYMD
                                                                 (IDX)
                   AND     SPA-NAI-EDYUKYMD    <=  SPA-NAI-TEDYUKYMD
                                                                 (IDX)
                       MOVE    "0004"              TO  SPA-ERRCD 
                   END-IF
               END-IF
           END-PERFORM 
           IF      SPA-ERRCD           NOT =   SPACE
               MOVE    2                   TO  SPA-GMN-CUR
               GO  TO  410-KAKUTEI-EXT
           END-IF      
      *
      *    画面移行用のパラメタ
           INITIALIZE                  SPA-X01KYOUTU
           MOVE    SPA-GMN-SELNUM      TO  SPA-X01-SELNUM
           MOVE    SPA-NAI-STYUKYMD    TO  SPA-X01-STYUKYMD
           MOVE    SPA-NAI-EDYUKYMD    TO  SPA-X01-EDYUKYMD 
           MOVE    SPA-GMN-STYUKYMD    TO  SPA-X01-STYUKYMDH
           MOVE    SPA-GMN-EDYUKYMD    TO  SPA-X01-EDYUKYMDH
           MOVE    SPA-GMN-CHKKBN-G    TO  SPA-X01-CHKKBN-G
           MOVE    SPA-GMN-SRYCD       TO  SPA-X01-SRYCD
           MOVE    SPA-GMN-NAME        TO  SPA-X01-NAME  
           MOVE    SPA-X01KYOUTU       TO  SPA-WORK
      *
           MOVE    "X02"               TO  SPA-SAKIPG
           MOVE    "X01"               TO  SPA-MOTOPG
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   SPA-SAKIPG           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       410-KAKUTEI-EXT.
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
      *----(01.00.01) LINE ADD START --------------------------------
      *            日付画面チェックサブ
                   INITIALIZE                      ORCSGDAYAREA
                   MOVE    WRK-YMD             TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"          USING
                                               ORCSGDAYAREA
                   IF      SGDAY-RC            =   ZERO
                       MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
                       MOVE    SGDAY-SDAY          TO  WRK-SYMD
                   ELSE
                       MOVE    "0002"              TO  SPA-ERRCD
                   END-IF
      *----(01.00.01) LINE ADD END   --------------------------------
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
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "X01    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  X01
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-MAX
               MOVE    SPA-GMN-TBANGO    (IDX) TO  X01-TBANGO (IDX)
               MOVE    SPA-GMN-TSTYUKYMD (IDX) TO  X01-TSTYUKYMD(IDX)
               MOVE    SPA-GMN-TEDYUKYMD (IDX) TO  X01-TEDYUKYMD(IDX)
               MOVE    IDX                     TO  X01-COUNT
               IF      IDX             =   SPA-NAI-SELNO 
                   MOVE    "T"             TO  X01-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  X01-SELECT (IDX)
               END-IF
           END-PERFORM   
           MOVE    SPA-GMN-MAX         TO  X01-COUNT
      *
           MOVE    SPA-GMN-SRYCD       TO  X01-SRYCD
           MOVE    SPA-GMN-NAME        TO  X01-NAME
           MOVE    SPA-GMN-SELNUM      TO  X01-SELNUM
           MOVE    SPA-GMN-STYUKYMD    TO  X01-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD    TO  X01-EDYUKYMD
           MOVE    SPA-GMN-CHKKBN-G    TO  X01-CHKKBN 
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       5
               MOVE    SPA-GMN-CHKKBNLIST(IDX) TO  X01-CHKKBNLIST (IDX)
               MOVE    IDX                     TO  X01-CHKKBNCOUNT
           END-PERFORM
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
           IF      SPA-GMN-CUR         =   ZERO
               PERFORM 50011-CUR-SET-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
                WHEN   1
                    MOVE  "CHKKBN"     TO  MCP-WIDGET
                WHEN   2
                    MOVE  "SRYCD"      TO  MCP-WIDGET
                WHEN   3
                    MOVE  "SELNUM"     TO  MCP-WIDGET
                WHEN   4
                    MOVE  "STYUKYMD"   TO  MCP-WIDGET
                WHEN   5
                    MOVE  "EDYUKYMD"   TO  MCP-WIDGET
                WHEN   12
                    MOVE  "B12"        TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       50011-CUR-SET-SEC             SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "CHKKBN"
                   MOVE    2               TO  SPA-GMN-CUR
               WHEN    "SRYCD"
                   MOVE    3               TO  SPA-GMN-CUR
               WHEN    "SELNUM"
                   MOVE    4               TO  SPA-GMN-CUR
               WHEN    "STYUKYMD"
                   MOVE    5               TO  SPA-GMN-CUR
               WHEN    "EDYUKYMD"
                   MOVE    12              TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
       50011-CUR-SET-EXT.
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
                   MOVE    "選択番号が有りません"     TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "日付入力エラー"           TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "エラーの項目があります"   TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "有効期間が重複します"     TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "点数マスタがありません"   TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "チェク区分がありません"   TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "診療コード入力エラー"     TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "チェック区分に対して入力できないコードです"
                                                      TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "チェック区分を入力してから印刷して下さい"
                                                      TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "薬剤と禁忌のチェックコードは使用できません"
                                                      TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  XERR
           MOVE    SPA-ERRCD            TO  XERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  XERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "X01"                TO  SPA-MOTOPG
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
      *    点数マスター読込（キー）
      *****************************************************************
       900-TENSU-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-TENSU-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込処理
      *****************************************************************
       900-TENSU-READ-SEC         SECTION.
      *
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
               MOVE    ZERO            TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1               TO  FLG-TENSU
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
               MOVE    MCPDATA-REC         TO  CHK-REC
               MOVE    ZERO            TO  FLG-CHK
           ELSE
               INITIALIZE                  CHK-REC
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

