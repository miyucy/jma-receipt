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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGW23.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 定期請求情報（Ｗ２３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02.08.01    ひさなが 　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    02/11/04  暫定的に定期請求を月末のみ
      *                                     選択可とする
      *  01.00.02    NACL-太田    03/02/12  期別の指定を可能にする
      *                           03/02/25  再請求区分を削除
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
           COPY    "ENUM-VALUE".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
       01  SPA-W23.
           03  SPA-W23-AREA.
               05  SPA-GMN-PAGE               PIC 9(02).
               05  SPA-GMN-MAX                PIC 9(03).
               05  SPA-GMN-CUR                PIC 9(03).
               05  SPA-GMN-KBN                PIC X(02).
               05  SPA-GMN-RUN                PIC 9(01).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-YUKOSTYMD      PIC X(9).
                   07  SPA-GMN-YUKOEDYMD      PIC X(9).
                   07  SPA-GMN-SEIKYU-VAL.
                       09  SPA-GMN-SEIKYU01   PIC X(03).
                       09  SPA-GMN-SEIKYU02   PIC X(03).
                       09  SPA-GMN-SEIKYU03   PIC X(03).
                   07  SPA-GMN-SEIKYU-R    REDEFINES
                       SPA-GMN-SEIKYU-VAL.
                       09  SPA-GMN-SEIKYU-OCC OCCURS  3.
                           11  SPA-GMN-SEIKYU PIC   X(03).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-SEIKYU-VAL.
                       09  SPA-NAI-SEIKYU01   PIC 9(02).
                       09  SPA-NAI-SEIKYU02   PIC 9(02).
                       09  SPA-NAI-SEIKYU03   PIC 9(02).
                   07  SPA-NAI-SEIKYU-R    REDEFINES
                       SPA-NAI-SEIKYU-VAL.
                       09  SPA-NAI-SEIKYU-OCC OCCURS  3.
                           11  SPA-NAI-SEIKYU PIC   9(02).
      *
       01  WRK-AREA.
           03  WRK-WIDMSG          PIC X(70). 
           03  WRK-DAY             PIC 9(02).
      *    入力項目名
           03  WRK-MCP-WIDGET      PIC X(64).
      *
      *    インデックス領域
       01  IDX-AREA.
           03  IDX1                PIC 9(05).
           03  IDX2                PIC 9(05).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-CHK             PIC 9(01).
      *
      *    メッセージ領域
       01  T-MESSAGE-AREA.
           03  T-MESSAGE-800-01    PIC X(16)   VALUE
               "入力エラーです。".
           03  T-MESSAGE-800-02    PIC X(24)   VALUE
               "更新ができませんでした。".
           03  T-MESSAGE-800-03    PIC X(26)   VALUE
               "定期請求情報を更新します。".
      *
      *****************************************************************
      *    ファイル連絡　領域
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    請求管理マスタ
           COPY    "CPSK5010.INC".
      *
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
      *     テーブルアクセス
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
           COPY    "W98.INC".
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
      *****************************************************************
      *    主    処    理
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU.
           MOVE    SPA-FREE        TO  SPA-W23.
      *
           INITIALIZE                  IDX-AREA
                                       FLG-AREA
                                       WRK-AREA
      *
           MOVE    SPACE           TO  SPA-ERRCD.
           MOVE    ZERO            TO  FLG-END.
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
      *    画面遷移がない時、画面表示へ
           IF  FLG-END   =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK.
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-W23         TO  SPA-FREE.
      *
       000-PROC-SEC-EXT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  FLG-AREA.
      *    エラー画面より
           IF  SPA-MOTOPG   =   "WERR" 
               MOVE    SPACE           TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF    ( SPA-ERRCD       NOT =   SPACE )
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF.
      *
           MOVE    SPACE                TO  LINKAREA
      * 
      ***  MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W23"                TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                    TO  FLG-END
           .
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF  LINKAREA   NOT =   SPACE
               MOVE    LNK-KYOUTU              TO  SPA-KYOUTU
           END-IF.
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "WID1"
               PERFORM 330-WID1-SET-SEC
               GO  TO  300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC.
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF      SPA-WID1-FLG    =   "OK"
               IF      SPA-WIDCD            =   "1001"
                   PERFORM 490-KOUSHIN-SEC
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD
           .
       330-WID1-SET-EXT.
           EXIT.
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR.
      *
           INITIALIZE   SPA-W23
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-YUKOSTYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-YUKOEDYMD
      *
           MOVE    SPACE               TO  SYS-5010-REC.
           INITIALIZE                      SYS-5010-REC.
           MOVE    "5010"              TO  SYS-5010-KANRICD.
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD.
           MOVE    SYS-5010-REC        TO  MCPDATA-REC.
           PERFORM 900-SYSKANRI-INV-SEC.
           IF  FLG-SYSKANRI   =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-5010-REC
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   3 )
                   MOVE    SYS-5010-SEIKYU-DAY (IDX1)
                                       TO  SPA-NAI-SEIKYU (IDX1)
                                           SPA-GMN-SEIKYU (IDX1)
                   IF    ( SYS-5010-SEIKYU-DAY (IDX1)
                                       =   ZERO )
                       MOVE    SPACE   TO  SPA-GMN-SEIKYU (IDX1)
                   END-IF
               END-PERFORM
      *
           END-IF.
           .
      *
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 210-BACK
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 530-RIDSET2-SEC
               WHEN    OTHER
                   MOVE    1                   TO  SPA-GMN-CUR
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
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
       410-INPUT-CHK-SEC               SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO  TO                  410-INPUT-CHK-EXT
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
           MOVE    W23-SEIKYU01    TO  SPA-GMN-SEIKYU01
           MOVE    W23-SEIKYU02    TO  SPA-GMN-SEIKYU02
           MOVE    W23-SEIKYU03    TO  SPA-GMN-SEIKYU03
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
      *    請求日確認処理（１）
           PERFORM T-000-YMDCHEK1-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    請求日確認処理（２）
           PERFORM T-000-YMDCHEK2-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    請求日確認処理（３）
           PERFORM T-000-YMDCHEK3-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
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
           MOVE    SPACE               TO  SPA-MOTOPG2
           MOVE    "W23"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
      *
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
           MOVE    SPACE                   TO  SYS-5010-REC
           INITIALIZE                          SYS-5010-REC
      *
           MOVE    "5010"                  TO  SYS-5010-KANRICD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-5010-REC            TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF  FLG-SYSKANRI   =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-5010-REC
           ELSE
               MOVE    SPACE                   TO  SYS-5010-REC
               INITIALIZE                      SYS-5010-REC
           END-IF
      *
           MOVE   "5010"                   TO  SYS-5010-KANRICD
           MOVE    "*"                     TO  SYS-5010-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  SYS-5010-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-5010-EDYUKYMD
           MOVE    SPA-NAI-SEIKYU01        TO  SYS-5010-SEIKYU-DAY1
           MOVE    SPA-NAI-SEIKYU02        TO  SYS-5010-SEIKYU-DAY2
           MOVE    SPA-NAI-SEIKYU03        TO  SYS-5010-SEIKYU-DAY3
           MOVE    SPA-TERMID              TO  SYS-5010-TERMID
           MOVE    SPA-OPID                TO  SYS-5010-OPID
           MOVE    SYS-5010-REC            TO  SYSKANRI-REC
      *
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    SPA-SYSYMD              TO  SYS-UPYMD
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    SPA-SYSYMD              TO  SYS-CREYMD
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
      *
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "2001"              TO  SPA-ERRCD
           ELSE
               MOVE    "JOIN"              TO  MCP-PUTTYPE
               PERFORM 210-BACK
           END-IF
           .
      *
       490-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC.
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
           MOVE    SPACE           TO  LINKAREA.
           MOVE    "CURRENT"       TO  MCP-PUTTYPE.
           MOVE    "W23"           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面内容編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE                   TO  W23.
      *
           MOVE    SPA-GMN-YUKOSTYMD       TO  W23-YUKOSTYMD
           MOVE    SPA-GMN-YUKOEDYMD       TO  W23-YUKOEDYMD
      *
           MOVE    SPA-GMN-SEIKYU01        TO  W23-SEIKYU01
           MOVE    SPA-GMN-SEIKYU02        TO  W23-SEIKYU02
           MOVE    SPA-GMN-SEIKYU03        TO  W23-SEIKYU03
      *
           PERFORM 5001-MAPCUR-SEC.
      *
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
               MOVE    "入力エラー"                    TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "有効な日付（１〜２７，９９）を入力してください"
                                                       TO  SPA-ERRMSG
           WHEN    "0101"
               MOVE    "請求日を設定してください"
                                                       TO  SPA-ERRMSG
           WHEN    "0102"
               MOVE    "請求日は１期より順に設定してください"
                                                       TO  SPA-ERRMSG
           WHEN    "0103"
               MOVE    "日付の設定に誤りがあります"
                                                       TO  SPA-ERRMSG
           WHEN    "0104"
               MOVE    "月末日（９９）を設定してください"
                                                       TO  SPA-ERRMSG
           WHEN    "2001"
               MOVE    "更新処理に失敗しました"        TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W23"                TO  SPA-MOTOPG
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
               MOVE    "定期請求情報を更新します"
                                        TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W23"                TO  SPA-MOTOPG
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
       5001-MAPCUR-SEC              SECTION.
      *
          IF      SPA-GMN-CUR          =   ZERO
               PERFORM 50011-CUR-SET-SEC
          END-IF
      *
           EVALUATE    SPA-GMN-CUR
           WHEN    01
                   MOVE    "SEIKYU01"      TO  MCP-WIDGET
           WHEN    02
                   MOVE    "SEIKYU02"      TO  MCP-WIDGET
           WHEN    03
                   MOVE    "SEIKYU03"      TO  MCP-WIDGET
           WHEN    101
                   MOVE    "B12"           TO  MCP-WIDGET
           END-EVALUATE.
      *
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル編集処理
      *****************************************************************
       50011-CUR-SET-SEC         SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SEIKYU01"
                   MOVE    1           TO  SPA-GMN-CUR
           WHEN    "SEIKYU02"
                   MOVE    2           TO  SPA-GMN-CUR
           WHEN    "SEIKYU03"
                   MOVE    3           TO  SPA-GMN-CUR
           END-EVALUATE
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SEIKYU03"
               MOVE    101             TO  SPA-GMN-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-CUR =   SPA-GMN-CUR +   1
           END-EVALUATE
      *
           .
       50011-CUR-SET-EXT.
           EXIT.
      *****************************************************************
      *    確認メッセージ表示理
      *****************************************************************
       530-RIDSET2-SEC                     SECTION.
      *
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO          530-RIDSET2-EXT
           END-IF
      *
           IF    (  SPA-NAI-SEIKYU (1) =   ZERO)
            AND  (  SPA-NAI-SEIKYU (2) =   ZERO)
            AND  (  SPA-NAI-SEIKYU (3) =   ZERO)
               MOVE    "0101"  TO  SPA-ERRCD
               MOVE    1       TO  SPA-GMN-CUR
               GO  TO  530-RIDSET2-EXT
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >    2 )
               COMPUTE IDX2    =   IDX1    +   1
      *
               IF    ( SPA-NAI-SEIKYU (IDX1)       =   ZERO )
                AND  ( SPA-NAI-SEIKYU (IDX2)   NOT =   ZERO )
                   MOVE    "0102"      TO  SPA-ERRCD
                   MOVE    IDX1        TO  SPA-GMN-CUR
                   GO  TO  530-RIDSET2-EXT
               END-IF
      *
               IF    ( SPA-NAI-SEIKYU (IDX1)   NOT =   ZERO )
                AND  ( SPA-NAI-SEIKYU (IDX2)   NOT =   ZERO )
                   IF    ( SPA-NAI-SEIKYU (IDX1)
                                       <   SPA-NAI-SEIKYU (IDX2) )
                       CONTINUE
                   ELSE
                       MOVE    "0103"      TO  SPA-ERRCD
                       MOVE    IDX1        TO  SPA-GMN-CUR
                       GO  TO  530-RIDSET2-EXT
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           MOVE    ZERO            TO   FLG-CHK
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >    3 )
               IF    (  SPA-NAI-SEIKYU (IDX1) =   "99" )
                   MOVE    1       TO  FLG-CHK
                   MOVE    3       TO  IDX1
               END-IF
           END-PERFORM
      *
           IF    ( FLG-CHK         =   ZERO )
               MOVE    "0104"      TO  SPA-ERRCD
               GO  TO  530-RIDSET2-EXT
           END-IF
      *
           MOVE    "1001"          TO  SPA-WIDCD
           .
      *
       530-RIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"                   TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                   USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF  MCP-RC   =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF  MCP-RC   =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求日 確認処理（１）
      *****************************************************************
       T-000-YMDCHEK1-SEC              SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI-SEIKYU01
      *
           IF    ( SPA-GMN-SEIKYU01        =   SPACE )
               GO  TO  T-000-YMDCHEK1-EXT
           END-IF
      *
           INITIALIZE                  ORCSNUMAREA
           MOVE    SPA-GMN-SEIKYU01    TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF  ( SNUM-RC       NOT =   ZERO  )
            OR ( SNUM-MINKBN   NOT =   SPACE )
            OR ( SNUM-SYOKBN   NOT =   SPACE )
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-CUR
               GO TO   T-000-YMDCHEK1-EXT
           ELSE
               MOVE    SNUM-OUTNUM     TO  WRK-DAY
               IF    (( WRK-DAY        >=  01 )
                AND   ( WRK-DAY        <=  27 ))
                OR    ( WRK-DAY         =  99 )
                   CONTINUE
               ELSE
                   MOVE    "0002"      TO  SPA-ERRCD
                   MOVE    1           TO  SPA-GMN-CUR
                   GO TO   T-000-YMDCHEK1-EXT
               END-IF
           END-IF
      *
           MOVE    WRK-DAY             TO  SPA-NAI-SEIKYU01
                                           SPA-GMN-SEIKYU01
           .
      *
       T-000-YMDCHEK1-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求日 確認処理（２）
      *****************************************************************
       T-000-YMDCHEK2-SEC                SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI-SEIKYU02
      *
           IF    ( SPA-GMN-SEIKYU02        =   SPACE )
               GO  TO  T-000-YMDCHEK2-EXT
           END-IF
      *
           INITIALIZE                  ORCSNUMAREA
           MOVE    SPA-GMN-SEIKYU02    TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF  ( SNUM-RC       NOT =   ZERO  )
            OR ( SNUM-MINKBN   NOT =   SPACE )
            OR ( SNUM-SYOKBN   NOT =   SPACE )
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    2               TO  SPA-GMN-CUR
               GO TO   T-000-YMDCHEK2-EXT
           ELSE
               MOVE    SNUM-OUTNUM     TO  WRK-DAY
               IF    (( WRK-DAY        >=  01 )
                AND   ( WRK-DAY        <=  27 ))
                OR    ( WRK-DAY         =  99 )
                   CONTINUE
               ELSE
                   MOVE    "0002"      TO  SPA-ERRCD
                   MOVE    2           TO  SPA-GMN-CUR
                   GO TO   T-000-YMDCHEK2-EXT
               END-IF
           END-IF
      *
           MOVE    WRK-DAY             TO  SPA-NAI-SEIKYU02
                                           SPA-GMN-SEIKYU02
           .
      *
       T-000-YMDCHEK2-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求日 確認処理（３）
      *****************************************************************
       T-000-YMDCHEK3-SEC                SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI-SEIKYU03
      *
           IF    ( SPA-GMN-SEIKYU03        =   SPACE )
               GO  TO  T-000-YMDCHEK3-EXT
           END-IF
      *
           INITIALIZE                  ORCSNUMAREA
           MOVE    SPA-GMN-SEIKYU03    TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF  ( SNUM-RC       NOT =   ZERO  )
            OR ( SNUM-MINKBN   NOT =   SPACE )
            OR ( SNUM-SYOKBN   NOT =   SPACE )
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    3               TO  SPA-GMN-CUR
               GO TO   T-000-YMDCHEK3-EXT
           ELSE
               MOVE    SNUM-OUTNUM     TO  WRK-DAY
               IF    (( WRK-DAY        >=  01 )
                AND   ( WRK-DAY        <=  27 ))
                OR    ( WRK-DAY         =  99 )
                   CONTINUE
               ELSE
                   MOVE    "0002"      TO  SPA-ERRCD
                   MOVE    3           TO  SPA-GMN-CUR
                   GO TO   T-000-YMDCHEK3-EXT
               END-IF
           END-IF
      *
           MOVE    WRK-DAY             TO  SPA-NAI-SEIKYU03
                                           SPA-GMN-SEIKYU03
           .
      *
       T-000-YMDCHEK3-EXT.
           EXIT.
      *
