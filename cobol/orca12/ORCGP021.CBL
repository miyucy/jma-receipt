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
       PROGRAM-ID.             ORCGP021.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 患者連絡先（Ｐ０２１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01/06/13  登録後、診療行為遷移を追加
      *  01.00.02    MCC-多々納   02/05/02  全角チェックサブ追加
      *  02.00.00    MCC-多々納   02/07/04  インタフェース変更
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメタデータ
      *    SELECT  PARA-FILE       ASSIGN  FILE-NAME1
      *                            ORGANIZATION    IS  INDEXED
      *                            ACCESS  MODE    IS  DYNAMIC
      *                            RECORD  KEY     IS  PAR-KEY
      *                            FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *    パラメタデータ
      *FD  PARA-FILE.
      *01  PARA-REC.
      *    03  PAR-KEY.
      *********05  PAR-TERMID          PIC X(32).
      *        05  PAR-FILEMEI         PIC X(08).
      *        05  PAR-EDANUM          PIC 9(04).
      **** 03  PAR-DATA-REC            PIC X(3000).
      *
       WORKING-STORAGE             SECTION.
      *    パラメタファイル名
       01  FILE-NAME1.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(07)   VALUE   "P01PARA".
           03  FILE-TERMID1        PIC X(32)   VALUE   SPACE.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    患者登録スパ領域
           COPY    "P02COMMON-SPA".
      *    患者画面スパ領域
           COPY    "P02SCR-SPA".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PARA            PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-ERR             PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-REN-POST        PIC 9(01).
           03  FLG-OFF-POST        PIC 9(01).
           03  FLG-KIS-POST        PIC 9(01).
           03  FLG-POST            PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-POST            PIC X(07).
           03  WRK-ADRS            PIC X(100).
      *
       01  WRK-HENKAN-AREA.
           03  WRK-MAE-INPUT       PIC X(400).
           03  WRK-ATO-INPUT       PIC X(400).
      *
           03  WRK-MAE-POST        PIC X(07).
      **** 03  WRK-POST            PIC X(07).
      **** 03  WRK-ADRS            PIC X(100).
      *    入力項目名
           03  WRK-MCP-WIDGET          PIC X(64).
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
      *
           03  WRK-HENTIME.
               05  WRK-THH         PIC 99.
               05  FILLER          PIC X(01)   VALUE  ":".
               05  WRK-TMM         PIC 99.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    周辺住所
           COPY    "CPSK1015.INC".
      *
      *    住所マスタ
       01  ADRS-REC.
           COPY    "CPADRS.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
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
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-P02SCRAREA
           MOVE    SPA-WORK        TO  SPA-P02KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  SPA-FLG-END
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
           IF      SPA-FLG-END         =   ZERO
               PERFORM 5001-MAPCUR-SEC
           END-IF
      *
           MOVE    SPA-P02KYOUTU   TO  SPA-WORK
           MOVE    SPA-P02SCRAREA  TO  SPA-FREE
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
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
      *    初期画面編集
           PERFORM 300-SCREEN-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           MOVE    SPA-WORK        TO  SPA-P02KYOUTU
      *
           EVALUATE    SPA-MOTOPG
      *        住所検索より住所編集
               WHEN    "P99"
                   PERFORM 330-ADRS-SET-SEC
      *
      *        住所検索より
               WHEN    "P98" 
                   PERFORM 330-ADRS-SET-SEC
      *        住所検索より
               WHEN    "P982" 
                   PERFORM 330-ADRS-POST2-SEC
      *
      *        初期画面編集
               WHEN    OTHER
                   PERFORM 310-SPASET-SEC
                   MOVE    1           TO  SPA-GMN21-CUR
           END-EVALUATE
      *
           .
       3OO-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    周辺住所より編集処理
      *****************************************************************
       330-ADRS-SET-SEC            SECTION.
      *
           EVALUATE    SPA-GMN21-INKBN
      *        連絡先
               WHEN    1
                   MOVE    JPAR-POST       TO  SPA-GMN21-RENRAKU-POST
                   IF      JPAR-POST       =   SPACE
                       MOVE    7           TO  SPA-GMN21-CUR
                   ELSE
                       MOVE    JPAR-EDITADRS-NAME
                                           TO  SPA-GMN21-RENRAKU-ADRS
                       MOVE    9           TO  SPA-GMN21-CUR
                   END-IF
      *        勤務先　住所編集
               WHEN    "2"
                   MOVE    JPAR-POST       TO  SPA-GMN21-OFFICE-POST
                   IF      JPAR-POST       =   SPACE
                       MOVE    13          TO  SPA-GMN21-CUR
                   ELSE
                       MOVE    JPAR-EDITADRS-NAME
                                           TO  SPA-GMN21-OFFICE-ADRS
                       MOVE    15          TO  SPA-GMN21-CUR
                   END-IF
      *        帰省先　住所編集
               WHEN    "3"
                   MOVE    JPAR-POST       TO  SPA-GMN21-KISEI-POST
                   IF      JPAR-POST       =   SPACE
                       MOVE    18          TO  SPA-GMN21-CUR
                   ELSE
                       MOVE    JPAR-EDITADRS-NAME
                                           TO  SPA-GMN21-KISEI-ADRS
                       MOVE    20          TO  SPA-GMN21-CUR
                   END-IF
           END-EVALUATE
           MOVE    SPACE               TO  JPARA-REC
      *
           .
       330-ADRS-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    住所編集処理
      *****************************************************************
       330-ADRS-POST2-SEC            SECTION.
      *
           EVALUATE    SPA-GMN21-INKBN
      *        連絡先
               WHEN    1
                   IF      SPA-GMN982-TOWNNAME     =   SPACE
                       MOVE    7           TO  SPA-GMN21-CUR
                   ELSE
                       MOVE    SPA-GMN982-POST
                                           TO  SPA-GMN21-RENRAKU-POST
                       MOVE    SPA-GMN982-TOWNNAME
                                           TO  SPA-GMN21-RENRAKU-ADRS
                       MOVE    9           TO  SPA-GMN21-CUR
                   END-IF
      *        勤務先　住所編集
               WHEN    "2"
                   IF      SPA-GMN982-TOWNNAME     =   SPACE
                       MOVE    13          TO  SPA-GMN21-CUR
                   ELSE
                       MOVE    SPA-GMN982-POST
                                           TO  SPA-GMN21-OFFICE-POST
                       MOVE    SPA-GMN982-TOWNNAME
                                           TO  SPA-GMN21-OFFICE-ADRS
                       MOVE    15          TO  SPA-GMN21-CUR
                   END-IF
      *        帰省先　住所編集
               WHEN    "3"
                   IF      SPA-GMN982-TOWNNAME     =   SPACE
                       MOVE    18          TO  SPA-GMN21-CUR
                   ELSE
                       MOVE    SPA-GMN982-POST
                                           TO  SPA-GMN21-KISEI-POST
                       MOVE    SPA-GMN982-TOWNNAME
                                           TO  SPA-GMN21-KISEI-ADRS
                       MOVE    20          TO  SPA-GMN21-CUR
                   END-IF
           END-EVALUATE
      *
           .
       330-ADRS-POST2-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           .
       31O-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
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
      *    カーソル指定のない時、入力した項目の次ぎへ
           IF      SPA-GMN21-CUR       =   ZERO
               PERFORM 50011-INPUT-CUR-SEC
               ADD     1               TO  SPA-GMN21-CUR
           END-IF
      *
           EVALUATE    SPA-GMN21-CUR
               WHEN    01
                   MOVE    "P021_FAX"           TO  MCP-WIDGET
               WHEN    02
                   MOVE    "P021_KEITAI"        TO  MCP-WIDGET
               WHEN    03
                   MOVE    "P021_EMAIL"         TO  MCP-WIDGET
               WHEN    04
                   MOVE    "P021_JOB"           TO  MCP-WIDGET
               WHEN    05
                   MOVE    "P021_RENNAME"       TO  MCP-WIDGET
               WHEN    06
                   MOVE    "P021_RENZOKUGARA"   TO  MCP-WIDGET
               WHEN    07
                   MOVE    "P021_RENPOST"       TO  MCP-WIDGET
               WHEN    08
                   MOVE    "P021_RENADRS"        TO  MCP-WIDGET
               WHEN    09
                   MOVE    "P021_RENBANTI"      TO  MCP-WIDGET
               WHEN    10
                   MOVE    "P021_RENTEL1"       TO  MCP-WIDGET
               WHEN    11
                   MOVE    "P021_RENTEL2"       TO  MCP-WIDGET
               WHEN    12
                   MOVE    "P021_OFFNAME"       TO  MCP-WIDGET
               WHEN    13
                   MOVE    "P021_OFFPOST"       TO  MCP-WIDGET
               WHEN    14
                   MOVE    "P021_OFFADRS"        TO  MCP-WIDGET
               WHEN    15
                   MOVE    "P021_OFFBANTI"      TO  MCP-WIDGET
               WHEN    16
                   MOVE    "P021_OFFTEL"        TO  MCP-WIDGET
               WHEN    17
                   MOVE    "P021_KISNAME"       TO  MCP-WIDGET
               WHEN    18
                   MOVE    "P021_KISPOST"       TO  MCP-WIDGET
               WHEN    19
                   MOVE    "P021_KISADRS"        TO  MCP-WIDGET
               WHEN    20
                   MOVE    "P021_KISBANTI"      TO  MCP-WIDGET
               WHEN    21
                   MOVE    "P021_KISTEL"        TO  MCP-WIDGET
               WHEN    22
                   MOVE    "B08"                TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC          SECTION.
      *
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "P021_FAX"
                   MOVE    01              TO  SPA-GMN21-CUR
               WHEN    "P021_KEITAI"
                   MOVE    02              TO  SPA-GMN21-CUR
               WHEN    "P021_EMAIL"
                   MOVE    03              TO  SPA-GMN21-CUR
               WHEN    "P021_JOB"
                   MOVE    04              TO  SPA-GMN21-CUR
               WHEN    "P021_RENNAME"
                   MOVE    05              TO  SPA-GMN21-CUR
               WHEN    "P021_RENZOKUGARA"
                   MOVE    06              TO  SPA-GMN21-CUR
               WHEN    "P021_RENPOST"
                   MOVE    07              TO  SPA-GMN21-CUR
               WHEN    "P021_RENADRS"
                   MOVE    08              TO  SPA-GMN21-CUR
               WHEN    "P021_RENBANTI"
                   MOVE    09              TO  SPA-GMN21-CUR
               WHEN    "P021_RENTEL1"
                   MOVE    10              TO  SPA-GMN21-CUR
               WHEN    "P021_RENTEL2"
                   MOVE    11              TO  SPA-GMN21-CUR
               WHEN    "P021_OFFNAME"
                   MOVE    12              TO  SPA-GMN21-CUR
               WHEN    "P021_OFFPOST"
                   MOVE    13              TO  SPA-GMN21-CUR
               WHEN    "P021_OFFADRS"
                   MOVE    14              TO  SPA-GMN21-CUR
               WHEN    "P021_OFFBANTI"
                   MOVE    15              TO  SPA-GMN21-CUR
               WHEN    "P021_OFFTEL"
                   MOVE    16              TO  SPA-GMN21-CUR
               WHEN    "P021_KISNAME"
                   MOVE    17              TO  SPA-GMN21-CUR
               WHEN    "P021_KISPOST"
                   MOVE    18              TO  SPA-GMN21-CUR
               WHEN    "P021_KISADRS"
                   MOVE    19              TO  SPA-GMN21-CUR
               WHEN    "P021_KISBANTI"
                   MOVE    20              TO  SPA-GMN21-CUR
               WHEN    "P021_KISTEL"
                   MOVE    21              TO  SPA-GMN21-CUR
           END-EVALUATE
      *
           .
       50011-INPUT-CUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           INITIALIZE                  JPARA-REC
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *
      *     以外はエラー
               WHEN    "CLICKED"       ALSO     ANY
                   MOVE    "0110"          TO  SPA-ERRCD
                   MOVE    1               TO  SPA-GMN21-CUR
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       490-TOUROKU-SEC             SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
          .
       490-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
      *    入力個所のセット
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN21-CUR
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェックと別画面処理
           PERFORM 4102-KIHON-CHK-SEC
           IF     (SPA-ERRCD       NOT =   SPACE )  OR
                  (SPA-FLG-END     NOT =   ZERO  )
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC          SECTION.
      *
           MOVE    P02-P021-FAX        TO  SPA-GMN21-FAX
      *    携帯
           MOVE    P02-P021-KEITAI     TO  SPA-GMN21-KEITAI-TEL
      *    メール
           MOVE    P02-P021-EMAIL      TO  SPA-GMN21-EMAIL
      *    仕事
           MOVE    P02-P021-JOB        TO  SPA-GMN21-JOB
      *    連絡先
           MOVE    P02-P021-RENNAME    TO  SPA-GMN21-RENRAKU-NAME
           MOVE    P02-P021-RENZOKUGARA
                                       TO  SPA-GMN21-RENRAKU-ZOKUGARA
           IF      P02-P021-RENPOST    =   SPA-GMN21-RENRAKU-POST
               MOVE    ZERO                TO  FLG-REN-POST
           ELSE
               MOVE    1                   TO  FLG-REN-POST
           END-IF
           MOVE    P02-P021-RENPOST    TO  SPA-GMN21-RENRAKU-POST
           MOVE    P02-P021-RENADRS    TO  SPA-GMN21-RENRAKU-ADRS
           MOVE    P02-P021-RENBANTI   TO  SPA-GMN21-RENRAKU-BANTI
           MOVE    P02-P021-RENTEL1    TO  SPA-GMN21-RENRAKU-TEL1
           MOVE    P02-P021-RENTEL2    TO  SPA-GMN21-RENRAKU-TEL2
      *    勤務先
           MOVE    P02-P021-OFFNAME    TO  SPA-GMN21-OFFICE-NAME
           IF      P02-P021-OFFPOST    =   SPA-GMN21-OFFICE-POST
               MOVE    ZERO                TO  FLG-OFF-POST
           ELSE
               MOVE    1                   TO  FLG-OFF-POST
           END-IF
           MOVE    P02-P021-OFFPOST    TO  SPA-GMN21-OFFICE-POST
           MOVE    P02-P021-OFFADRS    TO  SPA-GMN21-OFFICE-ADRS
           MOVE    P02-P021-OFFBANTI   TO  SPA-GMN21-OFFICE-BANTI
           MOVE    P02-P021-OFFTEL     TO  SPA-GMN21-OFFICE-TEL
      *    帰省先
           MOVE    P02-P021-KISNAME    TO  SPA-GMN21-KISEI-NAME
           IF      P02-P021-KISPOST    =   SPA-GMN21-KISEI-POST
               MOVE    ZERO                TO  FLG-KIS-POST
           ELSE
               MOVE    1                   TO  FLG-KIS-POST
           END-IF
           MOVE    P02-P021-KISPOST    TO  SPA-GMN21-KISEI-POST
           MOVE    P02-P021-KISADRS    TO  SPA-GMN21-KISEI-ADRS
           MOVE    P02-P021-KISBANTI   TO  SPA-GMN21-KISEI-BANTI
           MOVE    P02-P021-KISTEL     TO  SPA-GMN21-KISEI-TEL
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェックと別画面処理
      *****************************************************************
       4102-KIHON-CHK-SEC          SECTION.
      *
      *    連絡先−名前
           PERFORM 4101-RENRAKUNAME-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    連絡先−続柄
           PERFORM 4101-RENZOKUGARA-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *    郵便番号
           PERFORM 4101-RENPOST-CHK-SEC
           IF     (SPA-ERRCD       NOT =   SPACE )  OR
                  (SPA-FLG-END     NOT =   ZERO  )
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *    連絡先−住所
           PERFORM 4101-RENRAKUADRS-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    連絡先−番地
           PERFORM 4101-RENBANTI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *    勤務先−名前
           PERFORM 4101-OFFNAME-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *    郵便番号
           PERFORM 4101-OFFPOST-CHK-SEC
           IF     (SPA-ERRCD       NOT =   SPACE )  OR
                  (SPA-FLG-END     NOT =   ZERO  )
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *    勤務先−住所
           PERFORM 4101-OFFADRS-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    勤務先−番地
           PERFORM 4101-OFFBANTI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *    帰省先−名前
           PERFORM 4101-KISNAME-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *    郵便番号
           PERFORM 4101-KISPOST-CHK-SEC
           IF     (SPA-ERRCD       NOT =   SPACE )  OR
                  (SPA-FLG-END     NOT =   ZERO  )
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *    帰省先−住所
           PERFORM 4101-KISADRS-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    帰省先−番地
           PERFORM 4101-KISBANTI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    連絡先−名前チェック処理
      *****************************************************************
       4101-RENRAKUNAME-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-RENRAKU-NAME   TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN21-RENRAKU-NAME
           ELSE
               MOVE    "2101"              TO  SPA-ERRCD
               MOVE    5                   TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-RENRAKUNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    連絡先−名前チェック処理
      *****************************************************************
       4101-RENZOKUGARA-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-RENRAKU-ZOKUGARA   TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT   TO  SPA-GMN21-RENRAKU-ZOKUGARA
           ELSE
               MOVE    "2102"              TO  SPA-ERRCD
               MOVE    6                   TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-RENZOKUGARA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    連絡先−郵便番号チェック処理
      *****************************************************************
       4101-RENPOST-CHK-SEC          SECTION.
      *
           IF      SPA-GMN21-RENRAKU-POST  =   SPACE
               GO      TO      4101-RENPOST-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN21-RENRAKU-POST  TO  WRK-MAE-POST
           MOVE    1                   TO  SPA-GMN21-INKBN
           MOVE    FLG-REN-POST        TO  FLG-POST
      *
           PERFORM 430-POST-SYORI-SEC
      *    エラー
           IF      FLG-ERR             =   1
               MOVE    "2103"          TO  SPA-ERRCD
               MOVE    7               TO  SPA-GMN21-CUR
               GO      TO      4101-RENPOST-CHK-EXT
           END-IF
      *    対象あり
           IF      FLG-POST            =   1
               MOVE    WRK-POST        TO  SPA-GMN21-RENRAKU-POST
               MOVE    WRK-ADRS        TO  SPA-GMN21-RENRAKU-ADRS
           END-IF
           .
      *
       4101-RENPOST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    連絡先−住所チェック処理
      *****************************************************************
       4101-RENRAKUADRS-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-RENRAKU-ADRS   TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN21-RENRAKU-ADRS
           ELSE
               MOVE    "2104"              TO  SPA-ERRCD
               MOVE    8                    TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-RENRAKUADRS-CHK-EXT.
           EXIT.
      *****************************************************************
      *    連絡先−住所チェック処理
      *****************************************************************
       4101-RENBANTI-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-RENRAKU-BANTI TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN21-RENRAKU-BANTI
           ELSE
               MOVE    "2104"              TO  SPA-ERRCD
               MOVE    9                   TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-RENBANTI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    勤務先−名前チェック処理
      *****************************************************************
       4101-OFFNAME-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-OFFICE-NAME   TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN21-OFFICE-NAME
           ELSE
               MOVE    "2105"              TO  SPA-ERRCD
               MOVE    12                  TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-OFFNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    勤務先−郵便番号チェック処理
      *****************************************************************
       4101-OFFPOST-CHK-SEC          SECTION.
      *
           IF      SPA-GMN21-OFFICE-POST  =   SPACE
               GO      TO      4101-OFFPOST-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN21-OFFICE-POST  TO  WRK-MAE-POST
           MOVE    2                   TO  SPA-GMN21-INKBN
           MOVE    FLG-OFF-POST        TO  FLG-POST
      *
           PERFORM 430-POST-SYORI-SEC
      *    エラー
           IF      FLG-ERR             =   1
               MOVE    "2106"          TO  SPA-ERRCD
               MOVE    13              TO  SPA-GMN21-CUR
               GO      TO      4101-OFFPOST-CHK-EXT
           END-IF
      *    対象あり
           IF      FLG-POST            =   1
               MOVE    WRK-POST        TO  SPA-GMN21-OFFICE-POST
               MOVE    WRK-ADRS        TO  SPA-GMN21-OFFICE-ADRS
           END-IF
           .
      *
       4101-OFFPOST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    勤務先−住所チェック処理
      *****************************************************************
       4101-OFFADRS-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-OFFICE-ADRS   TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN21-OFFICE-ADRS
           ELSE
               MOVE    "2107"              TO  SPA-ERRCD
               MOVE    14                  TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-OFFADRS-CHK-EXT.
           EXIT.
      *****************************************************************
      *    勤務先−住所チェック処理
      *****************************************************************
       4101-OFFBANTI-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-OFFICE-BANTI  TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN21-OFFICE-BANTI
           ELSE
               MOVE    "2107"              TO  SPA-ERRCD
               MOVE    15                   TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-OFFBANTI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    帰省先−名前チェック処理
      *****************************************************************
       4101-KISNAME-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-KISEI-NAME    TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN21-KISEI-NAME
           ELSE
               MOVE    "2108"              TO  SPA-ERRCD
               MOVE    17                  TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-KISNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    帰省先−郵便番号チェック処理
      *****************************************************************
       4101-KISPOST-CHK-SEC          SECTION.
      *
           IF      SPA-GMN21-KISEI-POST  =   SPACE
               GO      TO      4101-KISPOST-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN21-KISEI-POST  TO  WRK-MAE-POST
           MOVE    3                   TO  SPA-GMN21-INKBN
           MOVE    FLG-KIS-POST        TO  FLG-POST
      *
           PERFORM 430-POST-SYORI-SEC
      *    エラー
           IF      FLG-ERR             =   1
               MOVE    "2109"          TO  SPA-ERRCD
               MOVE    18              TO  SPA-GMN21-CUR
               GO      TO      4101-KISPOST-CHK-EXT
           END-IF
      *    対象あり
           IF      FLG-POST            =   1
               MOVE    WRK-POST        TO  SPA-GMN21-KISEI-POST
               MOVE    WRK-ADRS        TO  SPA-GMN21-KISEI-ADRS
           END-IF
           .
      *
       4101-KISPOST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    帰省先−住所チェック処理
      *****************************************************************
       4101-KISADRS-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-KISEI-ADRS    TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN21-KISEI-ADRS
           ELSE
               MOVE    "2110"              TO  SPA-ERRCD
               MOVE    19                  TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-KISADRS-CHK-EXT.
           EXIT.
      *****************************************************************
      *    帰省先−住所チェック処理
      *****************************************************************
       4101-KISBANTI-CHK-SEC          SECTION.
      *
      *    半角空白を全角空白へ
           MOVE    SPA-GMN21-KISEI-BANTI   TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      FLG-ERR             =   ZERO
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN21-KISEI-BANTI
           ELSE
               MOVE    "2110"              TO  SPA-ERRCD
               MOVE    20                  TO  SPA-GMN21-CUR
           END-IF
           .
      *
       4101-KISBANTI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    郵便番号チェック処理
      *****************************************************************
       430-POST-SYORI-SEC          SECTION.
      *
           IF      WRK-MAE-POST(1:1)   =   "/"
               IF      WRK-MAE-POST(2:3)   NUMERIC
                   PERFORM 41011-SYUHEN-JYUSYO-SEC
               ELSE
                   PERFORM 440-JYUSYO-SEC
               END-IF
               GO      TO      430-POST-SYORI-EXT
           END-IF
      *
      *    入力があった時のみ、行う
           IF      FLG-POST            =   ZERO
               GO      TO      430-POST-SYORI-EXT
           END-IF
      *
      *    郵便番号より、住所一覧を表示する
           INITIALIZE                  SPA-P982-AREA
           MOVE    WRK-MAE-POST        TO  SPA-GMN982-POST
           MOVE    "P02"               TO  SPA-GMN982-MOTOPG
      *
           MOVE    SPA-P02KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-P02SCRAREA      TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGP982"          USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-P02SCRAREA
           MOVE    SPA-WORK        TO  SPA-P02KYOUTU
      *    対象なし
           IF      SPA-GMN982-MAX      =   ZERO
               MOVE     1                  TO  FLG-ERR
               GO      TO      430-POST-SYORI-EXT
           END-IF
      *    １件の時、対象
           IF      SPA-GMN982-MAX      =   1
               MOVE    SPA-GMN982-POST     TO  WRK-POST
               MOVE    SPA-GMN982-TOWNNAME TO  WRK-ADRS
               GO      TO      430-POST-SYORI-EXT
           END-IF
      *
      *    住所一覧画面へ
           MOVE    "SELNUM"            TO  MCP-WIDGET
      *
           MOVE    SPA-P02KYOUTU       TO  SPA-WORK
      *
      *    一覧へ
           MOVE    "P982"              TO  SPA-SAKIPG
           MOVE    "P02"               TO  SPA-MOTOPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "P982"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  SPA-FLG-END
           .
      *
       430-POST-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    周辺住所チェック処理
      *****************************************************************
       41011-SYUHEN-JYUSYO-SEC         SECTION.
      *
      *    システム管理より周辺住所を検索
           INITIALIZE                  SYS-1015-REC
           MOVE    "1015"              TO  SYS-1015-KANRICD
           MOVE    WRK-MAE-POST (2:3)  TO  SYS-1015-KBNCD
           MOVE    SYS-1015-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-SYSTEM-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1015-REC
           ELSE
      *        周辺住所一覧へ
               PERFORM 440-JYUSYO-SEC
               GO      TO      41011-SYUHEN-JYUSYO-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
      *    住所データ読み出し
           INITIALIZE                      ADRS-REC
           MOVE    SYS-1015-LPUBCD     TO  ADRS-LPUBCD
           MOVE    SYS-1015-POST       TO  ADRS-POST
           MOVE    SYS-1015-RENNUM     TO  ADRS-EDANUM
           MOVE    ADRS-REC            TO  MCPDATA-REC
           MOVE   "DBSELECT"           TO  MCP-FUNC
           MOVE   "ADRS-KEY"           TO  ORC-DBPATH
           CALL   "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "ADRS-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  ADRS-REC
                   MOVE    ADRS-POST           TO  WRK-POST
                   MOVE    ADRS-EDITADRS-NAME  TO  WRK-ADRS
                   MOVE    1                   TO  FLG-OK
               END-IF
           END-IF
      *
           IF      FLG-OK              =   ZERO
      *        周辺住所一覧へ
               PERFORM 440-JYUSYO-SEC
           END-IF
           .
       41011-SYUHEN-JYUSYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    半角空白を全角空白へ変換処理
      *****************************************************************
       890-HALF-ZEN-SEC         SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-MAE-INPUT       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
               MOVE    1                   TO  FLG-ERR
               MOVE    WRK-MAE-INPUT       TO  WRK-ATO-INPUT
           ELSE
               MOVE    ZERO                TO  FLG-ERR
               MOVE    KANACHK-OUT-INPUT   TO  WRK-ATO-INPUT
           END-IF
      *
           .
       890-HALF-ZEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    住所検索へ
      *****************************************************************
       440-JYUSYO-SEC             SECTION.
      *
           INITIALIZE                  P98
           INITIALIZE                  P99
           INITIALIZE                  JPARA-REC
           CALL  "ORCSADR"             USING
                                       SPA-P02KYOUTU
                                       SPA-P02SCRAREA
                                       P98
                                       P99
                                       SPA-SYSYMD
      *
           MOVE    "P02"               TO  SPA-GMN98-MOTOPG
           MOVE    SPA-P02KYOUTU       TO  SPA-WORK
           MOVE    SPA-P02SCRAREA      TO  SPA-FREE
           MOVE    SPA-AREA            TO  SPA-COMMON
      *
           MOVE    "SELNUM"            TO  MCP-WIDGET
           MOVE    "P98"               TO  SPA-SAKIPG
           MOVE    "P02"               TO  SPA-MOTOPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "P98"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  SPA-FLG-END
      *
           .
       440-JYUSYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSTEM-READ-SEC         SECTION.
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
       900-SYSTEM-READ-EXT.
           EXIT.
      *
      *
      ***************************************************************
      *    ＰＵＴ　処理
      ***************************************************************
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
