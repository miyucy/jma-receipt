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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGM97.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 業務選択
      *  コンポーネント名  : プログラム更新（Ｍ９７）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/01/16    NACL-森脇     新規作成
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
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    画面活性非活性
           COPY    "ENUM-VALUE".
      *
      *    マスタ更新シェル領域 
           COPY    "CPCOMMONSHELLMST.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "ORCA-DBPATH".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    スパ領域
           COPY    "M00COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-M97.
           03  SPA-M97-AREA.
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-ONKBN   PIC X(01).
                   07  SPA-GMN-OFFKBN  PIC X(01).
      *
                   07  SPA-GMN-OFFNAIYO.
                       09  SPA-GMN-CD         PIC X(01).
                       09  SPA-GMN-F1         PIC X(01).
                       09  SPA-GMN-MEI        PIC X(12).
      *
                   07  SPA-GMN-NAIYOLIST      OCCURS  99.
                       09  SPA-GMN-TEIKYOYMD  PIC X(09).
                       09  SPA-GMN-SYORIFLG   PIC X(08).
                       09  SPA-GMN-NAIYO      PIC X(100).
                   07  SPA-GMN-NAIYOLIST-MAX  PIC 9(02).
      *
                   07  SPA-GMN-MESSEGE.
                       09  SPA-GMN-MSG        PIC X(20).
                       09  SPA-GMN-MSG-STYLE  PIC X(122).
      *
               05  SPA-GMN-OFFNAIYO-AREA.
                   07  SPA-GMN-OFFLIST        OCCURS  2.
                       09  SPA-GMN-CDL        PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-MEIL       PIC X(12).
                   07  SPA-GMN-OFFLIST-MAX    PIC 9(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PGKANRI         PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(02).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD             PIC X(08).
           03  SYS-TIME            PIC X(06).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-NAIYO           PIC 9(02).
      *
      *    処理区分領域
       01  SKBN-AREA.
           03  SKBN-RUN            PIC X(03).
      *
       01  PARA-REC.
           03  PARA-DBFILE         PIC X(13).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-DBPATH          PIC X(64).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
           03  WRK-ENDYMD          PIC  X(09).
           03  WRK-ENDTIME         PIC  X(08).
      *
       01  WRK-JOBKANRI-AREA.
           03  WRK-JOBKANRI-MODE   PIC X(03). 
           03  WRK-JOBKANRI-RETURN PIC S9(03).
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
           COPY  "CPORCSDAY.INC".
           COPY  "CPORCSLNK.INC".
      *
      *    ＰＧ管理
       01  PGKANRI-REC.
           COPY    "CPPGKANRI.INC".
      *
      *    ジョブ管理
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
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
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "M00.INC".
           COPY    "M01.INC".
           COPY    "M01N.INC".
           COPY    "M02.INC".
           COPY    "M95.INC".
           COPY    "M96.INC".
           COPY    "M97.INC".
           COPY    "MERR.INC".
           COPY    "MID1.INC".
           COPY    "MVER.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
                                               MCPAREA
                                               SPAAREA
                                               LINKAREA
                                               SCRAREA.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-M00KYOUTU
           MOVE    SPA-FREE        TO  SPA-M97
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"          ALSO    "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN    OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END         =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-M00KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-M97         TO  SPA-FREE
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  SYS-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG      =   "MERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF          FLG-END     =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF          SPA-ERRCD   NOT     =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "M97"               TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                   TO  FLG-END
      *
           .
      *
       100-INIT-EXT.
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
                   PERFORM 210-BACK
      *        情報
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 400-JYOUHOU-SEC
      *        状況
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 400-JYOKYO-SET-SEC
      *        更新
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 410-KAKUNIN-SEC
      *        オンライン・オフライン
               WHEN    "CLICKED"       ALSO    "ONKBN" 
                   MOVE  M97-ONKBN             TO  SPA-GMN-ONKBN
                   MOVE  2                     TO  SPA-GMN-CUR
               WHEN    "CLICKED"       ALSO    "OFFKBN" 
                   MOVE  M97-OFFKBN            TO  SPA-GMN-OFFKBN
                   IF      SPA-GMN-OFFKBN      =   "T"
                       MOVE  3                     TO  SPA-GMN-CUR
                   ELSE
                       MOVE  99                    TO  SPA-GMN-CUR
                   END-IF
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力　処理
      *****************************************************************
       200-ENTRY                 SECTION.
      *
           EVALUATE    MCP-EVENT        ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"       ALSO    "OFFNAIYO"
                   PERFORM  400-OFFNAIYO-CHK-SEC
           END-EVALUATE
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           PERFORM 820-JOBKANRI-READ2-SEC.
      *
           IF  SKBN-RUN   =   "RUN"
               MOVE    SPACE               TO  MID1
               MOVE    "0301"              TO  MID1-ID1CODE
               MOVE    "マスタ更新中です。よろしいですか？"
                                           TO  MID1-ID1MSG
               PERFORM 830-GAMENN-SET5-SEC
           ELSE
               PERFORM 830-GAMENN-SET6-SEC
           END-IF
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF      LINKAREA   NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
      *    確認画面ＯＫ処理
           EVALUATE    SPA-MOTOPG
               WHEN    "MID1"
                   PERFORM 320-MID1-SET-SEC
                   GO  TO  300-SCREEN-EXT
           END-EVALUATE
      *
           MOVE    SPACE       TO  SPA-MID1-FLG
           MOVE    SPACE       TO  SPA-MIDCD
      *
           PERFORM 310-SPASET-SEC.
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE              SPA-M97-AREA
      *
           MOVE    "T"             TO  SPA-GMN-ONKBN
           MOVE    "F"             TO  SPA-GMN-OFFKBN
      *
           MOVE    "1"             TO  SPA-GMN-CDL(1)
           MOVE    "フロッピー"    TO  SPA-GMN-MEIL(1)
           MOVE    "2"             TO  SPA-GMN-CDL(2)
           MOVE    "ＣＤ−ＲＯＭ"  TO  SPA-GMN-MEIL(2)
           MOVE    2               TO  SPA-GMN-OFFLIST-MAX
      *
           MOVE    ZERO            TO  SPA-GMN-NAIYOLIST-MAX
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
     *****************************************************************
      *    確認画面（ＭＩＤ１）ＯＫ処理
      *****************************************************************
       320-MID1-SET-SEC      SECTION.
      *
           IF      SPA-MID1-FLG    =   "OK"
      *        更新処理
               PERFORM 420-KOUSHIN-SEC
           ELSE
               MOVE    1           TO  SPA-GMN-CUR
           END-IF
      *
           MOVE    SPACE       TO  SPA-MID1-FLG
           MOVE    SPACE       TO  SPA-MIDCD
           .
      *
       320-MID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    情報入手
      *****************************************************************
       400-JYOUHOU-SEC              SECTION.
      *
           IF      SPA-GMN-ONKBN        =   "T"
               MOVE    "program_upgrade_online.sh"
                                        TO  SHELL-SHELL
               MOVE    "1"              TO  SHELL-ARG1
           END-IF
      *
           IF      SPA-GMN-OFFKBN       =   "T"
               MOVE    "program_upgrade_offline.sh"
                                        TO  SHELL-SHELL
               EVALUATE    SPA-GMN-CD
                   WHEN    "1"
                       MOVE    "1"              TO  SHELL-ARG1
                       MOVE    "1"              TO  SHELL-ARG2
                   WHEN    "2"
                       MOVE    "1"              TO  SHELL-ARG1
                       MOVE    "2"              TO  SHELL-ARG2
                   WHEN    OTHER
                       GO  TO  400-JYOUHOU-SEC-EXT
               END-EVALUATE
           END-IF
      *
      *    マスタ更新処理
           MOVE    SPACE               TO  SHELLTBL.
           MOVE    SHELL-NAME          TO  SHELLTBL-NAME.
           MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1.
           MOVE    SHELL-ARG2          TO  SHELLTBL-ARG2.
           MOVE    SHELL-ARG3          TO  SHELLTBL-ARG3.
           MOVE    SHELL-ARG4          TO  SHELLTBL-ARG4.
           MOVE    SHELLTBL            TO  MCPDATA-REC.
      *
           MOVE    "SHELL"             TO  MCP-FUNC.
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
           PERFORM 400-JYOKYO-SET-SEC
           .
      *
       400-JYOUHOU-SEC-EXT.
           EXIT.
      *
      *****************************************************************
      *    状況更新
      *****************************************************************
       400-JYOKYO-SET-SEC                SECTION.
      *
           MOVE    ZERO            TO  CNT-NAIYO
      *
           INITIALIZE                  PGKANRI-REC
           MOVE    "PGKANRI-ALL"   TO  WRK-DBPATH
           PERFORM 900-PGKANRI-SELECT-SEC
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   FLG-PGKANRI =   1
                   OR      IDX         >   99
      *    日付変換
               MOVE    PGKANRI-RELEASEYMD  TO  WRK-SYMD
               PERFORM 700-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG         TO  SPA-GMN-TEIKYOYMD(IDX)
      *    更新フラグ
               IF      PGKANRI-UPDATEFLG   =   "T"
                   MOVE    "　　済　"      TO  SPA-GMN-SYORIFLG(IDX)
               ELSE
                   MOVE    "　　　　"      TO  SPA-GMN-SYORIFLG(IDX)
               END-IF
      *    内容
               MOVE    PGKANRI-COMMENT     TO  SPA-GMN-NAIYO(IDX)
      *
               COMPUTE CNT-NAIYO       =   CNT-NAIYO   +   1
               PERFORM 900-PGKANRI-FETCH-SEC
           END-PERFORM
      *
           PERFORM 900-PGKANRI-CLOSE-SEC
      *
           MOVE    CNT-NAIYO           TO  SPA-GMN-NAIYOLIST-MAX
           .
       400-JYOKYO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    オフライン処理コンボ
      *****************************************************************
       400-OFFNAIYO-CHK-SEC              SECTION.
      *
      *    変化なし
           IF         (M97-OFF-NAIYO   NOT =  SPACE)
               AND    (M97-OFF-NAIYO       =  SPA-GMN-OFFNAIYO)
      *
               IF      SPA-GMN-OFFLIST-MAX >  ZERO
                   MOVE  1          TO  SPA-GMN-CUR
               END-IF
               GO  TO  400-OFFNAIYO-CHK-EXT
           END-IF
      *
           MOVE    M97-OFF-NAIYO      TO  SPA-GMN-OFFNAIYO
      *
           IF      SPA-GMN-CD       =   "1"     OR    "2"
               MOVE    99               TO  SPA-GMN-CUR
           ELSE
               MOVE    "0001"           TO  SPA-ERRCD
               PERFORM 510-ERRSET-SEC
           END-IF
           .
       400-OFFNAIYO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       410-KAKUNIN-SEC         SECTION.
      *
           IF          SPA-ERRCD    NOT    =   SPACE
               GO  TO  410-KAKUNIN-EXT
           END-IF
      *
           PERFORM 820-JOBKANRI-READ2-SEC.
      *
           IF  SKBN-RUN   =   "RUN"
               MOVE    SPACE               TO  MERR
               MOVE    "0203"              TO  MERR-ERRCODE
               MOVE    "マスタ更新は実行中です。"
                                           TO  MERR-ERRMSG
               PERFORM 830-GAMENN-SET4-SEC
           ELSE
               MOVE    SPACE               TO  MID1
               MOVE    "0202"              TO  MID1-ID1CODE
               MOVE    "マスタ更新を実行します。よろしいですか？"
                                           TO  MID1-ID1MSG
               PERFORM 830-GAMENN-SET5-SEC
           END-IF
      *
           .
       410-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       420-KOUSHIN-SEC         SECTION.
      *
           PERFORM 820-JOBKANRI-READ1-SEC.
      *
           IF  (JOB-ENDYMD    NOT =   SPACE)  AND
               (JOB-ENDYMD(7:2)   =   SPACE)
               MOVE    "20"               TO  WRK-SYMD(1:2)
               MOVE    JOB-ENDYMD(1:6)    TO  WRK-SYMD(3:6)
           ELSE
               MOVE    JOB-ENDYMD         TO  WRK-SYMD
           END-IF
           PERFORM 700-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG        TO  WRK-ENDYMD
           IF  JOB-ENDTIME   =   SPACE
               MOVE    JOB-ENDTIME        TO  WRK-ENDTIME
           ELSE
               MOVE    ":"                TO  WRK-ENDTIME(3:1)
               MOVE    ":"                TO  WRK-ENDTIME(6:1)
               MOVE    JOB-ENDTIME(1:2)   TO  WRK-ENDTIME(1:2)
               MOVE    JOB-ENDTIME(3:2)   TO  WRK-ENDTIME(4:2)
               MOVE    JOB-ENDTIME(5:2)   TO  WRK-ENDTIME(7:2)
           END-IF
      *
           IF  WRK-JOBKANRI-RETURN   =   ZERO
      *     ジョブ管理削除
               MOVE    "DEL"               TO  WRK-JOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    1                   TO  JOB-JOBID
               MOVE    "MSTMNT"            TO  JOB-SHELLID
               CALL    "ORCSJOB"           USING
                                           WRK-JOBKANRI-AREA
                                           JOBKANRI-REC
           END-IF.
      *
      *    ジョブ管理作成
           MOVE    "JBS"               TO  WRK-JOBKANRI-MODE.
           INITIALIZE                  JOBKANRI-REC.
           MOVE    1                   TO  JOB-JOBID.
           MOVE    "MSTMNT"            TO  JOB-SHELLID.
           CALL    "ORCSJOB"           USING
                                       WRK-JOBKANRI-AREA
                                       JOBKANRI-REC.
      *
           IF      SPA-GMN-ONKBN        =   "T"
               MOVE    "program_upgrade_online.sh"
                                        TO  SHELL-SHELL
               MOVE    "2"              TO  SHELL-ARG1
           END-IF
      *
           IF      SPA-GMN-OFFKBN       =   "T"
               MOVE    "program_upgrade_offline.sh"
                                        TO  SHELL-SHELL
               EVALUATE    SPA-GMN-CD
                   WHEN    "1"
                       MOVE    "2"              TO  SHELL-ARG1
                       MOVE    "1"              TO  SHELL-ARG2
                   WHEN    "2"
                       MOVE    "2"              TO  SHELL-ARG1
                       MOVE    "2"              TO  SHELL-ARG2
                   WHEN    OTHER
                       GO  TO  400-JYOUHOU-SEC-EXT
               END-EVALUATE
           END-IF
      *
      *    マスタ更新処理
           MOVE    SPACE               TO  SHELLTBL.
           MOVE    SHELL-NAME          TO  SHELLTBL-NAME.
           MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1.
           MOVE    SHELL-ARG2          TO  SHELLTBL-ARG2.
           MOVE    SHELL-ARG3          TO  SHELLTBL-ARG3.
           MOVE    SHELL-ARG4          TO  SHELLTBL-ARG4.
           MOVE    SHELLTBL            TO  MCPDATA-REC.
      *
           MOVE    "SHELL"             TO  MCP-FUNC.
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
           PERFORM 400-JYOKYO-SET-SEC
           .
      *
       420-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦和暦編集処理
      *****************************************************************
       700-SEIWA-HEN-SEC             SECTION.
      *
           IF  WRK-SYMD   =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF.
      *
       700-SEIWA-HEN-EXT.
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
           MOVE    "M97"               TO  MCP-WINDOW
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
           INITIALIZE              M97
      *
           MOVE    SPA-GMN-ONKBN   TO  M97-ONKBN
           MOVE    SPA-GMN-OFFKBN  TO  M97-OFFKBN
      *
           IF      SPA-GMN-OFFKBN  =   "T"
               MOVE    SPA-GMN-OFFNAIYO    TO  M97-OFF-NAIYO
               PERFORM VARYING IDX FROM    1       BY  1
                       UNTIL   IDX >       SPA-GMN-OFFLIST-MAX
                   MOVE    SPA-GMN-OFFLIST(IDX)
                                           TO  M97-OFF-LIST(IDX)
               END-PERFORM
               MOVE    SPA-GMN-OFFLIST-MAX TO  M97-OFF-COUNT
               MOVE    WIDGET-NORMAL       TO  M97-OFF-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE  TO  M97-OFF-STATE
           END-IF
      *
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL   IDX >       SPA-GMN-NAIYOLIST-MAX
               MOVE    SPA-GMN-TEIKYOYMD(IDX)
                                       TO  M97-NAIYO-0(IDX)
               MOVE    SPA-GMN-SYORIFLG(IDX)
                                       TO  M97-NAIYO-1(IDX)
               MOVE    SPA-GMN-NAIYO(IDX)
                                       TO  M97-NAIYO-2(IDX)
           END-PERFORM
           MOVE    SPA-GMN-NAIYOLIST-MAX   TO  M97-NAIYO-COUNT
      *
           MOVE    SPA-GMN-MSG             TO  M97-MSG-NAIYO
           MOVE    SPA-GMN-MSG-STYLE       TO  M97-MSG-STYLE
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
      *
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE  "ONKBN"    TO  MCP-WIDGET
               WHEN    2
                   MOVE  "OFFKBN"   TO  MCP-WIDGET
               WHEN    3
                   MOVE  "OFFNAIYO" TO  MCP-WIDGET
               WHEN    99
                   MOVE  "B12"      TO  MCP-WIDGET
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
            EVALUATE    SPA-ERRCD
                WHEN    "0001"
                    MOVE    "入力エラー"
                                                TO  SPA-ERRMSG
                WHEN    "1001"
                    MOVE    "ＰＧ更新エラー"
                                                TO  SPA-ERRMSG
                WHEN    "1001"
                    MOVE    "ＰＧ更新エラー"
                                                TO  SPA-ERRMSG
                WHEN    OTHER
                    MOVE    SPACE               TO  SPA-ERRMSG
            END-EVALUATE
      *
           MOVE    SPACE                TO  MERR
           MOVE    SPA-ERRCD            TO  MERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  MERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "M97"                TO  SPA-MOTOPG
           MOVE    "MERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "MERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
      *
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理読込
      *****************************************************************
       820-JOBKANRI-READ1-SEC     SECTION.
      *
           MOVE    "CHK"           TO  WRK-JOBKANRI-MODE.
           INITIALIZE                  JOBKANRI-REC.
           MOVE    1               TO  JOB-JOBID.
           MOVE    "MSTMNT"        TO  JOB-SHELLID.
           CALL    "ORCSJOB"       USING
                                   WRK-JOBKANRI-AREA
                                   JOBKANRI-REC.
      *
       820-JOBKANRI-READ1-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理読込
      *****************************************************************
       820-JOBKANRI-READ2-SEC     SECTION.
      *
           MOVE    "CHK"           TO  WRK-JOBKANRI-MODE.
           INITIALIZE                  JOBKANRI-REC.
           MOVE    1               TO  JOB-JOBID.
           MOVE    "MSTMNT"        TO  JOB-SHELLID.
           CALL    "ORCSJOB"       USING
                                   WRK-JOBKANRI-AREA
                                   JOBKANRI-REC.
      *
           IF  WRK-JOBKANRI-RETURN   =   ZERO
               IF  JOB-ERRCD(1:2)   =   "99"
                   MOVE    SPACE           TO  SKBN-RUN
               ELSE
                   IF  JOB-ERRCD(1:2)   =   "01"
                       MOVE    SPACE         TO  SKBN-RUN
                   ELSE
                       IF  (JOB-ENDTIME       NOT =   SPACE)  AND
                           (JOB-ENDYMD        NOT =   SPACE)
                           MOVE    SPACE        TO  SKBN-RUN
                       ELSE
                           MOVE    "RUN"        TO  SKBN-RUN
                       END-IF
                   END-IF
               END-IF
           ELSE
               MOVE    SPACE        TO  SKBN-RUN
           END-IF.
      *
       820-JOBKANRI-READ2-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ERR
      *****************************************************************
       830-GAMENN-SET4-SEC        SECTION.
      *
           MOVE    "B01"               TO  MCP-WIDGET
           MOVE    "M97"               TO  SPA-MOTOPG
           MOVE    "MERR"              TO  SPA-SAKIPG
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "MERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END.
      *
       830-GAMENN-SET4-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面警告
      *****************************************************************
       830-GAMENN-SET5-SEC        SECTION.
      *
           MOVE    "B12"               TO  MCP-WIDGET.
           MOVE    "M97"               TO  SPA-MOTOPG.
           MOVE    "MID1"              TO  SPA-SAKIPG.
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "MID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       830-GAMENN-SET5-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る
      *****************************************************************
       830-GAMENN-SET6-SEC        SECTION.
      *
           MOVE    "M00"               TO  SPA-SAKIPG
           MOVE    "M97"               TO  SPA-MOTOPG
           MOVE    "M00"               TO  MCP-WINDOW
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END.
      *
       830-GAMENN-SET6-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＧ管理マスタ読み込み（キー）
      *****************************************************************
       900-PGKANRI-SELECT-SEC  SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"     USING
                                   MCPAREA
                                   ORCMCPAREA
                                   MCPDATA-REC
           IF          MCP-RC      =   ZERO
               MOVE    ZERO        TO  FLG-PGKANRI
               PERFORM 900-PGKANRI-FETCH-SEC
           ELSE
               MOVE    1           TO  FLG-PGKANRI
           END-IF
      *
            .
       900-PGKANRI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＧ管理マスタ読み込み（キー）
      *****************************************************************
       900-PGKANRI-FETCH-SEC   SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"     USING
                                   MCPAREA
                                   ORCMCPAREA
                                   MCPDATA-REC
      *
           IF          MCP-RC      =   ZERO
               MOVE    ZERO            TO  FLG-PGKANRI
               MOVE    MCPDATA-REC     TO  PGKANRI-REC
           ELSE
               MOVE    1           TO  FLG-PGKANRI
           END-IF
           .
      *
       900-PGKANRI-FETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＧ管理マスタ読み込み（キー）
      *****************************************************************
       900-PGKANRI-CLOSE-SEC   SECTION.
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"     USING
                                   MCPAREA
                                   ORCMCPAREA
                                   MCPDATA-REC
           .
      *
       900-PGKANRI-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"      TO  MCP-FUNC
           CALL   "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
