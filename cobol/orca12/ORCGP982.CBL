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
       PROGRAM-ID.                               ORCGP982.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 住所検索
      *  コンポーネント名  : 住所一覧画面（P982）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/04    MCC-多々納    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
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
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    患者登録用共通パラメタ
           COPY    "P02COMMON-SPA".
      *
      *    患者画面スパ領域
           COPY    "P02SCR-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-ADRS            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
           03  CNT-ENT             PIC 9(06).
      *
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-SEYMD.
               05  WRK-SEYY        PIC 9(04).
               05  WRK-SEMM        PIC 9(02).
               05  WRK-SEDD        PIC 9(02).
      *
           03  WRK-Z9              PIC ZZ9.
      *
           03  WRK-DBPATH            PIC X(64).
      *
           03  WRK-ERRMSG          PIC X(40).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    （周辺町域情報）
           COPY    "CPSK1015.INC".
      *    住所マスタ
       01  ADRS-REC.
           COPY    "CPADRS.INC".
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
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
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
           COPY    "P02.INC".
           COPY    "P02A.INC".
      *****COPY    "P02B.INC".
      *****COPY    "P02C.INC".
           COPY    "P02D.INC".
           COPY    "P02E.INC".
           COPY    "P02F.INC".
           COPY    "P014.INC".
           COPY    "P98.INC".
           COPY    "P981.INC".
           COPY    "P99.INC".
           COPY    "P0201.INC".
           COPY    "P982.INC".
           COPY    "P100.INC".
           COPY    "PERR.INC".
           COPY    "PID1.INC".
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
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON          TO  SPA-AREA.
           MOVE    SPA-FREE            TO  SPA-P02SCRAREA
           MOVE    SPA-WORK            TO  SPA-P02KYOUTU
      *
           MOVE    SPACE               TO  SPA-ERRCD
           MOVE    ZERO                TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"         ALSO   "CLICKED"
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
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-P02KYOUTU       TO  SPA-WORK
           MOVE    SPA-P02SCRAREA      TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "PERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           PERFORM 5001-MAPCUR-SEC
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE
           MOVE   "P982"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  SPA-GMN982-SELNUM
           MOVE    ZERO                TO  SPA-NAI982-SELNUM
           MOVE    ZERO                TO  SPA-GMN982-NEXT
      *
           PERFORM 310-SPA-SET-SEC
      *    １件のみの時、対象とする
           IF      SPA-GMN982-MAX          =   1
               MOVE    1                   TO  IDX
               MOVE    SPA-GMN982-TPOST   (IDX)
                                           TO  SPA-GMN982-POST
               MOVE    SPA-GMN982-TLPUBCD (IDX)
                                           TO  SPA-GMN982-LPUBCD
               MOVE    SPA-GMN982-TRENNUM (IDX)
                                           TO  SPA-GMN982-RENNUM
               MOVE    SPA-GMN982-TTOWNNAME (IDX)
                                           TO  SPA-GMN982-TOWNNAME
           END-IF
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       310-SPA-SET-SEC             SECTION.
      *
      *    一覧読込み
           INITIALIZE                      SPA-GMN982-TBL-G
      *
           INITIALIZE                      ADRS-REC
           MOVE    SPA-GMN982-LPUBCD       TO  ADRS-LPUBCD
           MOVE    SPA-GMN982-POST         TO  ADRS-POST
      *    地方公共団体コードのみ
           IF     (SPA-GMN982-LPUBCD   NOT =   SPACE )  AND
                  (SPA-GMN982-POST         =   SPACE )
               MOVE    "ADRS-KEY3"         TO  WRK-DBPATH
           END-IF
      *    郵便番号のみ
           IF     (SPA-GMN982-LPUBCD       =   SPACE )  AND
                  (SPA-GMN982-POST     NOT =   SPACE )
               MOVE    "ADRS-KEY4"         TO  WRK-DBPATH
           END-IF
      *    両方
           IF     (SPA-GMN982-LPUBCD   NOT =   SPACE )  AND
                  (SPA-GMN982-POST     NOT =   SPACE )
               MOVE    "ADRS-KEY5"         TO  WRK-DBPATH
           END-IF
      *
           MOVE    ADRS-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-DBPATH          TO  ORC-DBPATH
               PERFORM 900-ADRS-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-ADRS
           END-IF
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDX2
           PERFORM UNTIL    (FLG-ADRS      =   1   )  OR
                            (IDX           >=  100  )
               ADD     1                   TO  IDX2
               IF      SPA-GMN982-NEXT     <   IDX2
                   ADD     1               TO  SPA-GMN982-MAX
                   ADD     1               TO  IDX
                   MOVE    IDX             TO  SPA-GMN982-SEQNO (IDX)
                   MOVE    ADRS-POST       TO  SPA-GMN982-TPOST (IDX)
                   MOVE    ADRS-LPUBCD     TO  SPA-GMN982-TLPUBCD (IDX)
      *************MOVE    ADRS-TOWNNAME   TO  SPA-GMN982-TTOWNNAME(IDX)
                   MOVE    ADRS-EDITADRS-NAME
                                           TO  SPA-GMN982-TTOWNNAME(IDX)
                   MOVE    ADRS-EDANUM     TO  SPA-GMN982-TRENNUM(IDX)
               END-IF
      *
               MOVE    WRK-DBPATH          TO  ORC-DBPATH
               PERFORM 900-ADRS-READ-SEC
           END-PERFORM
      *
           IF     (SPA-GMN982-MAX          =   100  )  AND
                  (FLG-ADRS                =   ZERO )
               MOVE    "0005"              TO  SPA-ERRCD
               MOVE    IDX2                TO  SPA-GMN982-NEXT
           ELSE
               MOVE    ZERO                TO  SPA-GMN982-NEXT
           END-IF
      *
           .
       310-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   INITIALIZE                      SPA-GMN982-KEY
                   PERFORM 210-BACK
      *        次頁
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 220-NEXT-HEN-SEC
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
      *        キー入力
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 41011-SELNUM-CHK-SEC
      *        行選択
               WHEN    ANY             ALSO    "LIST"
                   PERFORM 41012-LISTSEL-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *****************************************************************
      *    番号選択　処理
      *****************************************************************
       41011-SELNUM-CHK-SEC                SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           MOVE    P982-SELNUM         TO  SPA-GMN982-SELNUM
      *
      *    選択番号入力
           INITIALIZE                      ORCSNUMAREA
           MOVE    P982-SELNUM         TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN         =   "1"   )   OR
                  (SNUM-SYOKBN         =   "1"   )
               MOVE    "0001"              TO  SPA-ERRCD
               GO      TO      41011-SELNUM-CHK-EXT
           ELSE
               MOVE    SNUM-OUTNUM     TO  SPA-NAI982-SELNUM
           END-IF
      *
      *    １件のみとき、１とする
           IF     (SPA-GMN982-MAX      =   1  )  AND
                  (SPA-NAI982-SELNUM   =   ZERO)
               MOVE    1               TO  SPA-NAI982-SELNUM
           END-IF
      *
           IF      SPA-NAI982-SELNUM   <   1   OR
                                       >   SPA-GMN982-MAX
               MOVE    "0002"              TO  SPA-ERRCD
               GO      TO      41011-SELNUM-CHK-EXT
           ELSE
               MOVE    SPA-NAI982-SELNUM   TO  IDX
               MOVE    SPA-GMN982-TPOST   (IDX)
                                           TO  SPA-GMN982-POST
               MOVE    SPA-GMN982-TLPUBCD (IDX)
                                           TO  SPA-GMN982-LPUBCD
               MOVE    SPA-GMN982-TRENNUM (IDX)
                                           TO  SPA-GMN982-RENNUM
               MOVE    SPA-GMN982-TTOWNNAME (IDX)
                                           TO  SPA-GMN982-TOWNNAME
      *
               PERFORM 210-BACK
           END-IF
           .
       41011-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41012-LISTSEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  SPA-NAI982-SELNUM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   200
               IF      P982-SELECT (IDX)    =   "T"
                   MOVE    SPA-GMN982-SEQNO (IDX)
                                            TO  SPA-NAI982-SELNUM
                   MOVE    200              TO  IDX
               END-IF
           END-PERFORM
      *
           IF      SPA-NAI982-SELNUM   >   ZERO
               MOVE    SPA-NAI982-SELNUM   TO  P982-SELNUM
               PERFORM 41011-SELNUM-CHK-SEC
           END-IF
           .
       41012-LISTSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁処理
      *****************************************************************
       220-NEXT-HEN-SEC       SECTION.
      *
           IF      SPA-GMN982-NEXT     =   ZERO
               MOVE    "0003"          TO  SPA-ERRCD
           ELSE
               PERFORM 310-SPA-SET-SEC
           END-IF
           .
       220-NEXT-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG
           MOVE    "P982"              TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
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
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "P982"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  P982
           INITIALIZE                      P982
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN982-MAX
               MOVE    SPA-GMN982-SEQNO (IDX)  TO  WRK-Z9
               MOVE    WRK-Z9                  TO  P982-SEQNO   (IDX)
               MOVE    SPA-GMN982-TPOST (IDX)  TO  P982-POST   (IDX)
               MOVE    SPA-GMN982-TLPUBCD (IDX)
                                               TO  P982-LPUBCD (IDX)
               MOVE    SPA-GMN982-TTOWNNAME (IDX)
                                               TO  P982-TOWNNAME(IDX)
           END-PERFORM
           MOVE    SPA-GMN982-MAX      TO  P982-COUNT
      *
           MOVE    SPA-GMN982-SELNUM   TO  P982-SELNUM
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
           EVALUATE    SPA-GMN-CUR
               WHEN    01
                   MOVE    "SELNUM"        TO  MCP-WIDGET
           END-EVALUATE
           .
       5001-MAPCUR-EXT.
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
                   MOVE    "入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "選択番号入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "次ページはありません"
                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象のデータが１００件以上あります"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  PERR
           MOVE    SPA-ERRCD           TO  PERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  PERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "P982"              TO  SPA-MOTOPG
           MOVE    "PERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "PERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    住所マスター読込処理
      *****************************************************************
       900-ADRS-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  ADRS-REC
               MOVE    ZERO                TO  FLG-ADRS
           ELSE
               INITIALIZE                      ADRS-REC
               MOVE    1                   TO  FLG-ADRS
           END-IF
      *
           .
       900-ADRS-READ-EXT.
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
