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
       PROGRAM-ID.             ORCGW97.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : ユーザプログラム起動（Ｗ９７）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/08/31    NACL−多々納  新規作成
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
       01  SPA-W97.
           03  SPA-W97-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-CUR         PIC 9(03).
      *
      *        起動画面
               05  SPA-GMN-GYOUMU-TBL.
                   07  SPA-GMN-GYOUMU-OCC   OCCURS   20.
                       09  SPA-GMN-GYOUMUMEI      PIC X(20).
                       09  SPA-GMN-GYOUMUID       PIC X(08).
               05  SPA-GYOUMU-MAX      PIC 9(03).
      *        実行スクリプト
               05  SPA-GMN-SHELL-TBL.
                   07  SPA-GMN-SHELL-OCC   OCCURS   20.
                       09  SPA-GMN-SHELL         PIC X(100).
      *
                       09  SPA-GMN-EXECUTE       PIC X(01).
                       09  SPA-GMN-EXECUTE-MEI   PIC X(04).
                       09  SPA-GMN-CHK           PIC X(01).
      *
           COPY    "ENUM-VALUE".
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-CHK             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
           03  IDX2                PIC 9(02).
      *
      *    一時領域
      *
       01  WRK-AREA.
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-PATH            PIC X(64).
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
      *
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
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    ユーザプログラム起動
           COPY  "CPSK9700.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
      *
           COPY  "CPORCSDAY.INC".
      *
           COPY  "CPORCSLNK.INC".
      *
      *    カナチェック
           COPY  "CPORCSKANACHK.INC".
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
           COPY    "ORCA-DBPATH".
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
           COPY    "W16.INC".
           COPY    "W17.INC".
           COPY    "W18.INC".
           COPY    "W19.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W28.INC".
           COPY    "W29.INC".
           COPY    "W30.INC".
           COPY    "W60.INC".
           COPY    "W61.INC".
           COPY    "W98.INC".
           COPY    "W97.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
           COPY    "WID2.INC".
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W97
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
           MOVE    SPA-W97         TO  SPA-FREE
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
               IF      FLG-END             =   ZERO
      *            画面編集
                   PERFORM 500-GMNHEN-SEC
                   PERFORM 510-GSRAUTH-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       PERFORM 510-ERRSET-SEC
                   END-IF
               END-IF
           END-IF
      *
           IF      FLG-END             =   ZERO
               MOVE    SPACE               TO  LINKAREA
      * 
               MOVE    SPACE                TO  MCP-PUTTYPE
               MOVE    "W97"                TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                    TO  FLG-END
           END-IF
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
               WHEN    OTHER
                   PERFORM 310-SPASET-SEC
           END-EVALUATE
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
           EVALUATE    SPA-WIDCD
               WHEN    "1001"
                   IF      SPA-WID1-FLG    =   "OK"
                       PERFORM 490-KOUSHIN-SEC
                   ELSE
                       MOVE    1           TO  SPA-GMN-CUR
                   END-IF
           END-EVALUATE
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
           INITIALIZE   SPA-W97
      *
           MOVE    "患者登録"          TO  SPA-GMN-GYOUMUMEI (1)
           MOVE    "P02"               TO  SPA-GMN-GYOUMUID  (1)
           MOVE    "受付"              TO  SPA-GMN-GYOUMUMEI (2)
           MOVE    "U02"               TO  SPA-GMN-GYOUMUID  (2)
           MOVE    "請求確認"          TO  SPA-GMN-GYOUMUMEI (3)
           MOVE    "K03"               TO  SPA-GMN-GYOUMUID  (3)
           MOVE    3                   TO  SPA-GYOUMU-MAX
      *
      *    初期表示
           MOVE    SPACE               TO  SYS-9700-REC
           INITIALIZE                      SYS-9700-REC
           MOVE    "9700"              TO  SYS-9700-KANRICD
           MOVE    SYS-9700-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-SYSKANRI-KEY6
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               PERFORM 990-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           PERFORM UNTIL    FLG-SYSKANRI   =   1
               MOVE    MCPDATA-REC         TO  SYS-9700-REC
               PERFORM 3101-SPA-GMNHEN-SEC
      *
               MOVE    PATH-TBL-SYSKANRI-KEY6  TO  MCP-PATH
               PERFORM 990-SYSKANRI-READ-SEC
           END-PERFORM
           MOVE    PATH-TBL-SYSKANRI-KEY6  TO  MCP-PATH
           PERFORM 990-DBCLOSE-SEC
      *
      *    実行可否初期設定
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GYOUMU-MAX
               IF      SPA-GMN-EXECUTE (IDX)   =   "1"
                   MOVE    "T"             TO  SPA-GMN-CHK (IDX)
               ELSE
                   MOVE    "F"             TO  SPA-GMN-CHK (IDX)
               END-IF
           END-PERFORM
      *
           MOVE    1                   TO  SPA-GMN-CUR
           . 
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期表示編集処理
      *****************************************************************
       3101-SPA-GMNHEN-SEC              SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GYOUMU-MAX
               IF      SYS-9700-KBNCD  =   SPA-GMN-GYOUMUID (IDX)
      *            シェル名
                   MOVE    SYS-9700-SHELL  TO  SPA-GMN-SHELL (IDX)
      *            実行可否
                   MOVE    SYS-9700-EXECUTE-SW 
                                           TO  SPA-GMN-EXECUTE (IDX)
                   MOVE    SPA-GYOUMU-MAX  TO  IDX
               END-IF
           END-PERFORM
      *
           . 
       3101-SPA-GMNHEN-EXT.
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
               WHEN    "CLICKED"      ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *    実行
               WHEN    "CLICKED"      ALSO    "EXECUTE01"
               WHEN    "CLICKED"      ALSO    "EXECUTE02"
               WHEN    "CLICKED"      ALSO    "EXECUTE03"
               WHEN    "CLICKED"      ALSO    "EXECUTE04"
               WHEN    "CLICKED"      ALSO    "EXECUTE05"
               WHEN    "CLICKED"      ALSO    "EXECUTE06"
               WHEN    "CLICKED"      ALSO    "EXECUTE07"
               WHEN    "CLICKED"      ALSO    "EXECUTE08"
               WHEN    "CLICKED"      ALSO    "EXECUTE09"
               WHEN    "CLICKED"      ALSO    "EXECUTE10"
               WHEN    "CLICKED"      ALSO    "EXECUTE11"
               WHEN    "CLICKED"      ALSO    "EXECUTE12"
               WHEN    "CLICKED"      ALSO    "EXECUTE13"
               WHEN    "CLICKED"      ALSO    "EXECUTE14"
               WHEN    "CLICKED"      ALSO    "EXECUTE15"
               WHEN    "CLICKED"      ALSO    "EXECUTE16"
               WHEN    "CLICKED"      ALSO    "EXECUTE17"
               WHEN    "CLICKED"      ALSO    "EXECUTE18"
               WHEN    "CLICKED"      ALSO    "EXECUTE19"
               WHEN    "CLICKED"      ALSO    "EXECUTE20"
                   PERFORM 410-EXECUTE-CHK-SEC
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
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       200-ENTRY-EXT.
           EXIT.
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
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
                   UNTIL       IDX     >   SPA-GYOUMU-MAX
               MOVE    W97-SHELL (IDX)     TO  SPA-GMN-SHELL (IDX)
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
           IF      SPA-ERRCD           =   SPACE
               PERFORM 41021-SHELL-CHK-SEC
           END-IF
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    実行スクリプトチェック処理
      *****************************************************************
       41021-SHELL-CHK-SEC            SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GYOUMU-MAX
               IF      SPA-GMN-SHELL (IDX) =   SPACE
                   MOVE    "F"         TO  SPA-GMN-CHK (IDX)
               END-IF
           END-PERFORM
      *
           .
       41021-SHELL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    実行チェック処理
      *****************************************************************
       410-EXECUTE-CHK-SEC             SECTION.
      *
      *    他の入力項目のチェック
           PERFORM 410-INPUT-CHK-SEC
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
           IF      MCP-WIDGET(8:2)     NUMERIC
               MOVE    MCP-WIDGET(8:2)     TO  IDX2
               MOVE    IDX2                TO  IDX
      *
               IF      SPA-GMN-SHELL (IDX) NOT =   SPACE
                   EVALUATE    SPA-GMN-CHK (IDX)
                   WHEN    "T"
                       MOVE    "F"         TO  SPA-GMN-CHK (IDX)
                   WHEN    "F"
                       MOVE    "T"         TO  SPA-GMN-CHK (IDX)
                   END-EVALUATE
               END-IF
           END-IF
      *
           .
       410-EXECUTE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W97"               TO  SPA-MOTOPG
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
      *    入力項目のチェック
           PERFORM 410-INPUT-CHK-SEC
      *
           IF      SPA-ERRCD           =   SPACE
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
      *    更新日取得
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GYOUMU-MAX
      *
               IF      SPA-GMN-CHK (IDX)   =   "T"
                   MOVE    "1"             TO  SPA-GMN-EXECUTE (IDX)
               ELSE
                   MOVE    "0"             TO  SPA-GMN-EXECUTE (IDX)
               END-IF
      *
               MOVE    SPACE               TO  SYS-9700-REC
               INITIALIZE                      SYS-9700-REC
               MOVE    "9700"                  TO  SYS-9700-KANRICD
               STRING  SPA-GMN-GYOUMUID(IDX)   DELIMITED BY  SPACE
                       "%"                     DELIMITED BY  SIZE
                                         INTO  SYS-9700-KBNCD
               END-STRING
               MOVE    "00000000"              TO  SYS-9700-STYUKYMD
               MOVE    "99999999"              TO  SYS-9700-EDYUKYMD
               MOVE    SYS-9700-REC            TO  MCPDATA-REC
               MOVE    PATH-TBL-SYSKANRI-KEY   TO  MCP-PATH
               PERFORM 910-DBSELECT-SEC
               IF      MCP-RC              =   ZERO
                   PERFORM 990-SYSKANRI-READ-SEC
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
               MOVE    PATH-TBL-SYSKANRI-KEY   TO  MCP-PATH
               PERFORM 990-DBCLOSE-SEC
               IF      FLG-SYSKANRI            =   ZERO
                   MOVE    MCPDATA-REC             TO  SYS-9700-REC
      *            実行スクリプト
                   IF      SPA-GMN-SHELL (IDX)     =   SPACE
      *                削除
                       PERFORM 4903-DELETE-SYORI-SEC
                   ELSE
      *                更新
                       PERFORM 4902-UPDATE-SYORI-SEC
                   END-IF
               ELSE
      *            実行スクリプト
                   IF      SPA-GMN-SHELL (IDX)     =   SPACE
                       CONTINUE
                   ELSE
      *                新規
                       PERFORM 4901-INSERT-SYORI-SEC
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           IF      SPA-ERRCD           =   SPACE
      *        戻る
               MOVE   "JOIN"               TO  MCP-PUTTYPE
               PERFORM 210-BACK
           END-IF
           .
       490-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *       新規登録処理
      *****************************************************************
       4901-INSERT-SYORI-SEC           SECTION.
      *
           MOVE    SPACE                   TO  SYS-9700-REC
           INITIALIZE                      SYS-9700-REC
           MOVE   "9700"                   TO  SYS-9700-KANRICD
           MOVE    SPA-GMN-GYOUMUID(IDX)   TO  SYS-9700-KBNCD
           MOVE    "00000000"              TO  SYS-9700-STYUKYMD
           MOVE    "99999999"              TO  SYS-9700-EDYUKYMD
           MOVE    SPA-GMN-SHELL (IDX)     TO  SYS-9700-SHELL
           MOVE    SPA-GMN-EXECUTE(IDX)    TO  SYS-9700-EXECUTE-SW
      *
           MOVE    SMCNDATE-YMD        TO  SYS-9700-CREYMD
           MOVE    SMCNDATE-YMD        TO  SYS-9700-UPYMD
           MOVE    SMCNDATE-HMS        TO  SYS-9700-UPHMS
      *
           MOVE    SYS-9700-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO 
               MOVE    "1001"              TO  SPA-ERRCD
               DISPLAY "W97 DB INS ERR KEY:" SYS-9700-KEY 
           END-IF
           .
       4901-INSERT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *       更新処理
      *****************************************************************
       4902-UPDATE-SYORI-SEC           SECTION.
      *
           MOVE    SPA-GMN-SHELL (IDX)     TO  SYS-9700-SHELL
           MOVE    SPA-GMN-EXECUTE(IDX)    TO  SYS-9700-EXECUTE-SW
      *
           MOVE    SMCNDATE-YMD        TO  SYS-9700-UPYMD
           MOVE    SMCNDATE-HMS        TO  SYS-9700-UPHMS
      *
           MOVE    SYS-9700-REC        TO  SYSKANRI-REC
           MOVE    SYS-KANRICD         TO  SYSUP-KANRICD
           MOVE    SYS-KBNCD           TO  SYSUP-KBNCD
           MOVE    SYS-STYUKYMD        TO  SYSUP-STYUKYMD
           MOVE    SYS-EDYUKYMD        TO  SYSUP-EDYUKYMD
           MOVE    "SYSKANRI-UPD1"     TO  ORC-DBPATH
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO 
               MOVE    "1002"              TO  SPA-ERRCD
               DISPLAY "W97 DB UPD ERR KEY:" SYS-9700-KEY 
           END-IF
           .
       4902-UPDATE-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理
      *****************************************************************
       4903-DELETE-SYORI-SEC           SECTION.
      *
           MOVE    SYS-9700-REC            TO  MCPDATA-REC
           MOVE    "DBDELETE"              TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"              TO  SPA-ERRCD
               DISPLAY "W97 DB DEL ERR SYSKANRI-KEY =>" SYS-9700-KEY 
           END-IF
           .
       4903-DELETE-SYORI-EXT.
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
           MOVE    "W97    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  W97
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GYOUMU-MAX
               MOVE    SPA-GMN-GYOUMUMEI(IDX)
                                           TO  W97-GYOUMUMEI(IDX)
               MOVE    SPA-GMN-GYOUMUID(IDX)
                                           TO  W97-GYOUMUID (IDX)
               MOVE    SPA-GMN-SHELL  (IDX)
                                           TO  W97-SHELL (IDX)
               MOVE    SPA-GMN-CHK    (IDX)
                                           TO  W97-EXECUTE-VALUE(IDX)
               IF      SPA-GMN-CHK    (IDX)    =   "T"
                   MOVE    "ON"            TO  W97-EXECUTE-LABEL(IDX)
               ELSE
                   MOVE    "OFF"           TO  W97-EXECUTE-LABEL(IDX)
               END-IF
           END-PERFORM
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
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   20
              IF      IDX              <=  SPA-GYOUMU-MAX
                   MOVE    WIDGET-NORMAL       TO  W97-SHELL-STATE(IDX)
                   MOVE    WIDGET-NORMAL       TO  W97-EXECUTE-STATE
                                                                  (IDX)
               ELSE
                   MOVE    WIDGET-INSENSITIVE  TO  W97-SHELL-STATE(IDX)
                   MOVE    WIDGET-INSENSITIVE  TO  W97-EXECUTE-STATE
                                                                  (IDX)
               END-IF
           END-PERFORM
           .
       51O-GSRAUTH-EXT.
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
                   MOVE    "入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "登録ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "更新ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "削除ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W97"                TO  SPA-MOTOPG
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
           MOVE    SPACE                TO  WRK-WIDMSG
      *
           EVALUATE    SPA-WIDCD
               WHEN    "1001"
                   MOVE    "ユーザプログラム起動情報を登録します。"
                                                     TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W97"                TO  SPA-MOTOPG
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
          IF      SPA-GMN-CUR          =   ZERO
               PERFORM 50011-CUR-SET-SEC
          END-IF
      *
          EVALUATE    SPA-GMN-CUR
                WHEN    01   THRU  20
                    MOVE     SPA-GMN-CUR       TO  IDX2
                    MOVE     "SHELL"           TO  MCP-WIDGET
                    MOVE     IDX2              TO  MCP-WIDGET(6:2)
                WHEN    21   THRU  41
                    MOVE     SPA-GMN-CUR       TO  IDX2
                    MOVE     "EXECUTE"         TO  MCP-WIDGET
                    COMPUTE  IDX2              =   IDX2   -   20
                    MOVE     IDX2              TO  MCP-WIDGET(8:2)
      *
                WHEN    99
                    MOVE  "B12"            TO   MCP-WIDGET
            END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル編集処理
      *****************************************************************
       50011-CUR-SET-SEC         SECTION.
      *
           EVALUATE    TRUE
      *
               WHEN    WRK-MCP-WIDGET(1:5)     =   "SHELL"
                   MOVE    WRK-MCP-WIDGET(6:2)     TO  IDX2
                   IF      IDX2                <=  SPA-GYOUMU-MAX
                        COMPUTE SPA-GMN-CUR    =   IDX2
                                               +   20
                   ELSE
                        MOVE    99             TO  SPA-GMN-CUR
                   END-IF
      *
               WHEN    WRK-MCP-WIDGET(1:7)     =   "EXECUTE"
                   MOVE    WRK-MCP-WIDGET(8:2)     TO  IDX2
                   IF      IDX2                <   SPA-GYOUMU-MAX
                        COMPUTE SPA-GMN-CUR    =   IDX2
                                               +   1
                   ELSE
                        MOVE    99             TO  SPA-GMN-CUR
                   END-IF
           END-EVALUATE
      *
           .
       50011-CUR-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       990-SYSKANRI-READ-SEC                SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       990-SYSKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクロース処理
      *****************************************************************
       990-DBCLOSE-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       990-DBCLOSE-EXT.
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
