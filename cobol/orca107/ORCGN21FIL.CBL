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
       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         ORCGN21FIL.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 薬剤情報設定
      *  コンポーネント名  : ファイルセレクション
      *  管理者            : 
      *  作成日付    作業者        記述
      *  08/06/25    NACL−森脇    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT         DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
       DATA                DIVISION.
      *
       WORKING-STORAGE         SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "N21COMMON-SPA".
      *
           COPY    "N21SCR-SPA".
      *
           COPY    "ENUM-VALUE".
      *
      *    ファイル存在チェック
           COPY    "CPORCSFILECHK.INC".
      *    画像表示用
           COPY    "ORCA-BLOB".
      *
           COPY    "ORCA-DBPATH".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
       01  FLG-AREA.
           03  FLG-OK              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(03).
      *
       01  WRK-AREA.
           03  WRK-PASSMEI         PIC X(256).
           03  WRK-FILEMEI         PIC X(128).
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                 SECTION.
      *
            COPY    "MCPAREA".
            COPY    "ORCA-SPA".
            COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "N21.INC".
           COPY    "N22.INC".
           COPY    "N23.INC".
           COPY    "N29.INC".
           COPY    "N21ERR.INC".
           COPY    "N21ID1.INC".
           COPY    "N21ID2.INC".
           COPY    "N21FIL.INC".
      *
      ******************************************************************
       PROCEDURE           DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-N21KYOUTU
           MOVE    SPA-FREE        TO  SPA-N21SCRAREA
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *        画面遷移
               WHEN    "PUTG"          ALSO    "CLICKED"
                   PERFORM 200-GMNSENI
           END-EVALUATE
      *
           MOVE    SPA-N21SCRAREA  TO  SPA-FREE
           MOVE    SPA-N21KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           .
      *
           EXIT    PROGRAM.
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  N21FIL
           MOVE    SPACE           TO  N21FIL-PHOTO
           MOVE    LOW-VALUE       TO  N21FIL-PHOTOAREA
           MOVE    SPACE           TO  SPA-N21FIL-PHOTO
           MOVE    LOW-VALUE       TO  SPA-N21FIL-OBJECT
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                 SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        登録
               WHEN    OTHER
                   PERFORM 210-GAZO
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "N21"           TO  SPA-SAKIPG
           MOVE    "N21FIL"        TO  SPA-MOTOPG
      *
           MOVE    SPACE           TO  LINKAREA
      *
           MOVE    "JOIN"          TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG      TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    アップロード　処理
      *****************************************************************
       210-GAZO                    SECTION.
      *
      *    画像チェック
           IF      N21FIL-PHOTO    NOT =   SPACE
               PERFORM 431-GAZO-FILE-CHK
               IF      FLG-OK          =   1
      *            画像がなければアップロードする
                   PERFORM 431-GAZO-PATH-CHK-SEC
                   MOVE    SPACE           TO  SPA-N21FIL-PHOTO
                   STRING  SPA-GMN-FOLDER      DELIMITED  BY  SPACE
                           WRK-FILEMEI         DELIMITED  BY  SPACE
                                       INTO    SPA-N21FIL-PHOTO
                   END-STRING
                   MOVE    SPA-N21FIL-PHOTO    TO  SPA-GMN-PHOTO
                   IF      N21FIL-PHOTOAREA    NOT =   LOW-VALUE
                       MOVE    N21FIL-PHOTOAREA    TO  SPA-N21FIL-OBJECT
                   END-IF
               ELSE
                   MOVE    N21FIL-PHOTO        TO  SPA-GMN-PHOTO
               END-IF
           END-IF
      *
           PERFORM 210-BACK
      *
           .
       210-GAZO-EXT.
           EXIT.
      *
      *****************************************************************
      *    画像ファイル存在チェック
      *****************************************************************
       431-GAZO-FILE-CHK           SECTION.
      *
           MOVE    ZERO            TO  FLG-OK
      *
      *    画像ファイルがない場合は処理抜ける
           INITIALIZE                  ORCSFILECHKAREA
           MOVE    N21FIL-PHOTO    TO  FILECHK-NAME
           CALL    "ORCSFILECHK"       USING
                                       ORCSFILECHKAREA
           IF      FILECHK-RC      NOT =   0
               MOVE    1               TO  FLG-OK
           END-IF
      *
           .
       431-GAZO-FILE-EXT.
           EXIT.
      *
      *****************************************************************
      *    画像パス名編集
      *****************************************************************
       431-GAZO-PATH-CHK-SEC            SECTION.
      *
           INITIALIZE                  WRK-AREA
      *
           MOVE    N21FIL-PHOTO    TO  WRK-PASSMEI
           MOVE    SPACE           TO  WRK-FILEMEI
           MOVE    ZERO            TO  FLG-OK
      *
           PERFORM VARYING IDX     FROM    256 BY -1 
                   UNTIL   IDX     <       1
               IF      WRK-PASSMEI(IDX:)   NOT =   SPACE
                   IF    ( WRK-PASSMEI(IDX:1)  =   "/" ) OR
                         ( WRK-PASSMEI(IDX:1)  =   "\" )
                       IF      WRK-PASSMEI(1:IDX)
                                           NOT =   SPA-GMN-FOLDER(1:IDX)
                           MOVE    1           TO  FLG-OK
                       END-IF
                       COMPUTE IDX     =   IDX     +   1
                       MOVE    WRK-PASSMEI(IDX:)
                                           TO  WRK-FILEMEI
                       MOVE    1           TO  IDX
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      WRK-FILEMEI     =   SPACE
               MOVE    WRK-PASSMEI     TO  WRK-FILEMEI
           END-IF
      *
           .
       431-GAZO-PATH-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW          SECTION.
      *
           MOVE   "PUTWINDOW"  TO  MCP-FUNC
           CALL   "ORCDBMAIN"      USING
                                   MCPAREA
                                   MCPDATA-REC
                                   SPA-AREA
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
