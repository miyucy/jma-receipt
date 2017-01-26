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
       PROGRAM-ID.                 ORCGMJOB.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : メンテナンス
      *  コンポーネント名  : ログファイル確認
      *  管理者            : 
      *  作成日付    作業者        記述
      *  13/12/01    NACL−伊藤     新規作成
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
      *    ログファイル
           SELECT  LOG-FILE        ASSIGN  ASS-LOGF
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-LOGF.
      *    ログファイル（ＤＢから作成時）
           SELECT  LOGT-FILE       ASSIGN  ASS-LOGF
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-LOGTF.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    ログファイル
       FD  LOG-FILE.
       01  LOG-REC                 PIC X(1000).
      * 
      *    ログファイル
       FD  LOGT-FILE.
       01  LOGT-REC                PIC X(410000). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-MJOB.
           03  SPA-NAI-MOTOPG        PIC X(08).
           03  SPA-MJOB-AREA.
               05  SPA-GMN-CUR       PIC 9(02).
               05  SPA-GMN-TBL.
                   07  SPA-GMN-OCC             OCCURS  100.
                       09  SPA-GMN-TUSER       PIC X(16).
                       09  SPA-GMN-TPID        PIC 9(05).
                       09  SPA-GMN-TCOMMAND    PIC X(256).
                       09  SPA-GMN-TSTART      PIC X(22).
                       09  SPA-GMN-TEND        PIC X(22).
                       09  SPA-GMN-TKBNID      PIC X(01).
                       09  SPA-GMN-TRESULT     PIC X(04).
                       09  SPA-GMN-TMSG        PIC X(200).
                       09  SPA-GMN-TCOMMENT    PIC X(512).
               05  SPA-GMN-DATAVIEW  PIC X(63000).
               05  SPA-GMN-CNTHEN    PIC X(50).
               05  SPA-GMN-PAGE      PIC 9(01).
      *
               05  SPA-NAI-TBL.
                   07  SPA-NAI-OCC             OCCURS  100.
                       09  SPA-NAI-TID        PIC X(37).
                       09  SPA-NAI-EXTRA      PIC X(512).
               05  SPA-NAI-CNT       PIC 9(06).
               05  SPA-NAI-NEXT      PIC 9(01).
               05  SPA-NAI-PAGE      PIC 9(06).
               05  SPA-NAI-TOTALPAGE PIC 9(06).
               05  SPA-NAI-PAGECNT   OCCURS 200
                                     PIC S9(09) BINARY.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-LOGF            PIC X(02).
           03  STS-LOGTF           PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-MBL             PIC 9(01).
           03  FLG-MBCL            PIC 9(01).
           03  FLG-LOGF            PIC 9(01).
           03  FLG-OVR             PIC 9(01).
           03  FLG-SELLOG          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(06).
           03  IDX2                PIC 9(05).
           03  IDX2-1              PIC 9(05).
           03  IDX-1               PIC 9(05).
           03  IDX-1U              PIC 9(05).
           03  IDX-3               PIC 9(05).
           03  IDX-CNT             PIC 9(05).
           03  IDX-P               PIC 9(01).
      *
      *    一時領域
       01  WRK-AREA.
      *    ログファイルパス 
           03  ASS-LOGF            PIC X(256).
           03  WRK-DATA-MAX        PIC 9(06).
           03  WRK-DATAVIEW-G      PIC X(63000).
           03  WRK-DATAVIEW        PIC X(63000). 
           03  WRK-CNT             PIC 9(05).
           03  WRK-CNT-U           PIC 9(05).
           03  WRK-Z1              PIC ZZZ,ZZ9.
           03  WRK-Z2              PIC ZZZ,ZZ9.
           03  WRK-ZZ              PIC ZZ9.
           03  WRK-SELIDX          PIC 9(03).
           03  WRK-MOVECOUNT       PIC 9(09).
      *
           COPY    "CPSHELLTBL.INC".
      *                             
       01  SHELL-AREA.
           05  SHELL-NAME          PIC X(12) VALUE
                                   "logupload.sh".
      *     
       01  WRK-CONS-AREA.
           03  WRK-CONS-MAX-LEN    PIC 9(05)   VALUE   63000.
      *
           COPY    "ENUM-VALUE".
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
       01  MBL-REC.
           COPY    "CPMBL.INC".
       01  MBCL-REC.
           COPY    "CPMBCL.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    コード変換サブ
      *     COPY    "CPORCSJISTOEUC.INC".
      *
      *    半角チェックサブ
      *     COPY    "CPORCSKANACHK.INC".
      *
      *    一時ファイル名取得
           COPY    "CPORCSGETTEMP.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
       01  MCPDATA.
           03  MCPREC              PIC X(420000).
      *
      *   ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
       01  UIDIO-AREA.
           03  C-RET               PIC X(02).
           03  C-UID               PIC X(36).
       01  ST                      PIC 9(02).
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
           COPY    "M80.INC".
           COPY    "M96.INC".
           COPY    "M97.INC".
           COPY    "MMERR.INC".
           COPY    "MMID1.INC".
           COPY    "MJOB.INC".
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
           MOVE    SPA-COMMON          TO  SPA-AREA
           MOVE    SPA-FREE            TO  SPA-MJOB-AREA
      *
           MOVE    SPACE               TO  SPA-ERRCD
           MOVE    ZERO                TO  FLG-END
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
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-MJOB-AREA       TO  SPA-FREE
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE  FLG-AREA
           INITIALIZE  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "MMERR"
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
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "MJOB   "           TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                   TO  FLG-END
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
      *        前
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 470-PREV-SYORI-SEC
      *        次
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 470-NEXT-SYORI-SEC
      *        タブ画面切り替え
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 490-TAB-CHANGE-SEC
               WHEN    "CLICKED"       ALSO    "B11"
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 400-LOG-UPLOAD-SEC
           END-EVALUATE
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        ジョブ選択
               WHEN    "SELECT"        ALSO    "LIST"
                   PERFORM 400-JOB-SELECT-SEC
      *            ログタブに切り替え
                   MOVE    2                   TO  SPA-GMN-CUR
      *        タブ切り替え
               WHEN    "SWITCH"        ALSO    "nb1"
                   PERFORM 490-TAB-CHANGE-SEC
           END-EVALUATE
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
      *    前に処理したログファイルを削除する
           PERFORM 900-LOGF-DEL-SEC
      *
           MOVE    SPA-NAI-MOTOPG      TO  SPA-SAKIPG
           MOVE    "MJOB"              TO  SPA-MOTOPG
           MOVE    SPACE               TO  LINKAREA
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                   TO  FLG-END
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
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    SPA-MOTOPG          TO  SPA-NAI-MOTOPG
           END-IF
      *
      **     EVALUATE    SPA-MOTOPG
      **         WHEN    "xxxx"
      **             PERFORM XXXX-SEC
      **         WHEN    OTHER
                   PERFORM 310-SPASET-SEC
      **     END-EVALUATE
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE  SPA-MJOB-AREA
           PERFORM 400-MBL-SPASET-SEC
           MOVE    1                   TO  SPA-GMN-CUR
           MOVE    1                   TO  SPA-GMN-PAGE
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ編集処理
      *****************************************************************
       400-MBL-SPASET-SEC          SECTION.
      *
           INITIALIZE  MBL-REC
           MOVE    SPA-HOSPNUM         TO  MBL-TENANT
           MOVE    SPA-SYSYMD          TO  MBL-STARTTIME
ito           MOVE    "20170125"          TO  MBL-STARTTIME
ito   ***        MOVE    WRK-MOVECOUNT       TO  MBL-MOVECOUNT
           MOVE    MBL-REC             TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "monbatch_log"      TO  MCP-TABLE
           MOVE    "list1"             TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           IF      MCP-RC              =   ZERO
               PERFORM 900-MBL-FET-SEC
           ELSE 
               MOVE    1                   TO  FLG-MBL
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL  (FLG-MBL    =   1)
                               OR     (IDX        =   99)
               ADD     1                   TO  IDX
               MOVE    MBL-ID              TO  SPA-NAI-TID      (IDX)
               MOVE    MBL-EXUSER          TO  SPA-GMN-TUSER    (IDX)
               MOVE    MBL-PGID            TO  SPA-GMN-TPID     (IDX)
               MOVE    MBL-STARTTIME       TO  SPA-GMN-TSTART   (IDX)
               MOVE    MBL-ENDTIME         TO  SPA-GMN-TEND     (IDX)
               MOVE    MBL-NAME            TO  SPA-GMN-TCOMMAND (IDX)
               MOVE    MBL-RC              TO  SPA-GMN-TRESULT  (IDX)
               MOVE    MBL-MESSAGE         TO  SPA-GMN-TMSG     (IDX)
               MOVE    MBL-COMMENT         TO  SPA-GMN-TCOMMENT (IDX)
               MOVE    MBL-EXTRA           TO  SPA-NAI-EXTRA    (IDX)
      *
               PERFORM 900-MBL-FET-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "monbatch_log"      TO  MCP-TABLE
           MOVE    "list1"             TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
       400-MBL-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    バッチログ選択処理
      *****************************************************************
       400-JOB-SELECT-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-SELLOG
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >   99
               IF      MJOB-SELECT (IDX)   =   "T"
                   MOVE    1                   TO  FLG-SELLOG
                   MOVE    IDX                 TO  WRK-SELIDX
                   EXIT    PERFORM
              END-IF
           END-PERFORM
      *
ito        DISPLAY "FLG-SELLOG = " FLG-SELLOG
           IF      FLG-SELLOG          =   1
               PERFORM 4001-FILE-OUTPUT-SEC
               PERFORM 4001-DATA-HENSYU-SEC
           END-IF
           .
       400-JOB-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ログＤＢからファイル書き出し処理
      *****************************************************************
       4001-FILE-OUTPUT-SEC        SECTION.
      *
      *    前に処理したログファイルを削除する
           PERFORM 900-LOGF-DEL-SEC
      *
           INITIALIZE  UIDIO-AREA
           CALL    "orcuidset"     USING   ST
                                           UIDIO-AREA
           INITIALIZE  SGETTEMP-AREA
           MOVE    C-UID               TO  SGETTEMP-BASENAME
           CALL    "ORCSGETTEMP"   USING   SGETTEMP-AREA
           MOVE    SGETTEMP-FULLNAME   TO  ASS-LOGF
      *
           OPEN    OUTPUT  LOGT-FILE
      *
           INITIALIZE  MBCL-REC
           MOVE    SPA-NAI-TID (WRK-SELIDX)
                                       TO  MBCL-ID
           MOVE    MBCL-REC            TO  MCPREC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "monbatch_clog"     TO  MCP-TABLE
           MOVE    "log1"              TO  MCP-PATHNAME
           CALL    "MONFUNC"       USING   MCPAREA
                                           MCPREC
                                           SPA-AREA
           IF      MCP-RC              =   ZERO
               PERFORM 900-MBCL-FET-SEC
           ELSE
               MOVE    1                   TO  FLG-MBCL
           END-IF
      *
           PERFORM UNTIL   FLG-MBCL    =   1
               MOVE    MBCL-CLOG           TO  LOGT-REC
               WRITE   LOGT-REC
               PERFORM 900-MBCL-FET-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "monbatch_clog"     TO  MCP-TABLE
           MOVE    "log1"              TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           CLOSE   LOGT-FILE
           .
       4001-FILE-OUTPUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ編集処理
      *****************************************************************
       4001-DATA-HENSYU-SEC        SECTION.
      *
           MOVE    SPACE               TO  SPA-GMN-DATAVIEW
           MOVE    SPA-NAI-CNT         TO  WRK-DATA-MAX
           MOVE    ZERO                TO  SPA-NAI-NEXT
           MOVE    ZERO                TO  SPA-NAI-CNT
           MOVE    ZERO                TO  IDX-CNT
           MOVE    ZERO                TO  IDX
           COMPUTE SPA-NAI-PAGE        =   SPA-NAI-PAGE  +  1
           IF      SPA-NAI-PAGE        >   200
               MOVE    1                   TO  SPA-NAI-PAGE
               MOVE    ZERO                TO  WRK-DATA-MAX
           END-IF
           MOVE    WRK-DATA-MAX      TO  SPA-NAI-PAGECNT (SPA-NAI-PAGE)
      *
      *#   IF      SPA-NAI-TOTALPAGE   =   0
      *#           PERFORM 4100-DATA-HENSYU-SEC
      *#       DISPLAY "ORCGMJOB : SPA-NAI-TOTALPAGE = "
      *#               SPA-NAI-TOTALPAGE
      *#   END-IF
      *
           OPEN    INPUT   LOG-FILE
           MOVE    ZERO                TO  FLG-LOGF
           IF      STS-LOGF        NOT =   ZERO
      *        データなし
               MOVE   1                TO  FLG-LOGF
               DISPLAY " STS-LOGF:"  STS-LOGF
           END-IF
      *
           MOVE   SPACE                TO  WRK-DATAVIEW
           MOVE   ZERO                 TO  WRK-CNT
           MOVE   ZERO                 TO  WRK-CNT-U
           PERFORM UNTIL   FLG-LOGF    =   1
               READ    LOG-FILE
                   AT  END
                       MOVE   1                TO  FLG-LOGF
                   NOT AT  END
                       ADD    1                TO  IDX
                       IF     WRK-DATA-MAX     <   IDX
                           ADD     1               TO  IDX-CNT
                           PERFORM 40011-DATA-HEN-SEC
                       END-IF
               END-READ
           END-PERFORM
      *
           CLOSE   LOG-FILE
      *
           IF      IDX-CNT             =   ZERO
      *        対象なし
               MOVE    "0001"              TO  SPA-ERRCD
           ELSE
               MOVE    WRK-DATAVIEW        TO  SPA-GMN-DATAVIEW
      *        内容
               MOVE    SPACE               TO  SPA-GMN-CNTHEN
               ADD     1                   TO  WRK-DATA-MAX
               MOVE    WRK-DATA-MAX        TO  WRK-Z1
               IF      SPA-NAI-NEXT        =   1
                   MOVE    SPA-NAI-CNT         TO  WRK-Z2
               ELSE
                   MOVE    IDX                 TO  WRK-Z2
               END-IF
               STRING  "（"                DELIMITED  BY  SIZE
                       WRK-Z1              DELIMITED  BY  SIZE
                       "〜"                DELIMITED  BY  SIZE
                       WRK-Z2              DELIMITED  BY  SIZE
                       "）"                DELIMITED  BY  SIZE
                                       INTO  SPA-GMN-CNTHEN
               END-STRING
               IF      SPA-NAI-NEXT        =   1
                   MOVE    2                   TO  SPA-GMN-CUR
               ELSE
                   MOVE    9                   TO  SPA-GMN-CUR
               END-IF
           END-IF
           .
       4001-DATA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ編集処理（総ページ数算出）
      *    （注意）とりあえず未使用です
      *****************************************************************
       4100-DATA-HENSYU-SEC           SECTION.
      *
           MOVE    ZERO                TO  IDX-CNT
           MOVE    ZERO                TO  IDX
      *
           OPEN    INPUT               LOG-FILE
           MOVE    ZERO                TO  FLG-LOGF
           IF      STS-LOGF        NOT =   ZERO
      *        データなし
               MOVE   1                TO  FLG-LOGF
               DISPLAY " STS-LOGF:"  STS-LOGF
           END-IF
      *
           MOVE    ZERO                TO  WRK-CNT
           PERFORM UNTIL       FLG-LOGF  =   1
               READ    LOG-FILE
                   AT  END
                       MOVE   1                TO  FLG-LOGF
                   NOT AT  END
                       PERFORM 41001-DATA-HEN-SEC
               END-READ
           END-PERFORM
      *
           CLOSE                       LOG-FILE
           .
       4100-DATA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ編集処理（総ページ数算出）
      *    （注意）とりあえず未使用です
      *****************************************************************
       41001-DATA-HEN-SEC           SECTION.
      *
           MOVE   ZERO             TO  FLG-OVR
           MOVE   ZERO             TO  IDX-1
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2    >   1000 )  OR
                              (FLG-OVR =   1    )
               COMPUTE IDX2-1          =   IDX2  +  1
               IF     (LOG-REC(IDX2:2)     =   SPACE )
                   MOVE    1           TO  FLG-OVR
               ELSE
                   IF     (LOG-REC(IDX2:1)     >=  X"A1" )
                       ADD     2           TO  IDX-1
                   ELSE
                       ADD     1           TO  IDX-1
                   END-IF
               END-IF
           END-PERFORM
      *
           IF     (IDX-1   +   WRK-CNT )   >=  WRK-CONS-MAX-LEN
               COMPUTE SPA-NAI-TOTALPAGE   =   SPA-NAI-TOTALPAGE  +  1
               MOVE   ZERO             TO  WRK-CNT
           ELSE
               COMPUTE WRK-CNT         =   WRK-CNT  +  IDX-1
               COMPUTE WRK-CNT         =   WRK-CNT  +  1
           END-IF
           .
       41001-DATA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       40011-DATA-HEN-SEC          SECTION.
      *
      *    文字コードがUTF-8の場合はEUC-JPへ変換する
      *    文字コード変換
      *ito start
      *    COPY句はorcsjistoeucを代用している　ちゃんと作成するか
      *ito end
      *     MOVE    LOG-REC                 TO  SJISTOEUC-INDATA
      *     INITIALIZE                      SJISTOEUC-OUTDATA
      *     MOVE    10000               TO  SJISTOEUC-INLEN
      *     MOVE    10000               TO  SJISTOEUC-OUTLEN
      *     CALL    "orcsutftoeuc"      USING
      *                                 ORCSJISTOEUC
      *     MOVE    SPACE               TO  LOG-REC
      *     MOVE    SJISTOEUC-OUTDATA   TO  LOG-REC
      *
           MOVE   ZERO             TO  FLG-OVR
           MOVE   ZERO             TO  IDX-1
           MOVE   ZERO             TO  IDX-1U
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2    >   1000 )  OR
                              (FLG-OVR =   1    )
               COMPUTE IDX2-1          =   IDX2  +  1
               IF     (LOG-REC(IDX2:20)    =   SPACE )
                   MOVE    1           TO  FLG-OVR
               ELSE
                   ADD     1           TO  IDX-1
                   IF     (LOG-REC(IDX2:1)     >=  X"A1" )
                       ADD     2           TO  IDX-1U
                   ELSE
                       ADD     1           TO  IDX-1U
                   END-IF
               END-IF
           END-PERFORM
      *
           IF     (IDX-1U +  WRK-CNT-U )   >=  WRK-CONS-MAX-LEN
               MOVE    1               TO  FLG-LOGF
               MOVE    1               TO  SPA-NAI-NEXT
               COMPUTE SPA-NAI-CNT     =   IDX    -   1
           ELSE
               IF      WRK-DATAVIEW    =   SPACE
                   MOVE    LOG-REC(1:IDX-1)    TO  WRK-DATAVIEW
                   MOVE    IDX-1           TO  WRK-CNT
                   MOVE    IDX-1U          TO  WRK-CNT-U
               ELSE
                   COMPUTE IDX-3           =   WRK-CNT   +  1
                   MOVE    LOG-REC(1:IDX-1)    TO  WRK-DATAVIEW
                                                          (IDX-3:IDX-1)
                   COMPUTE WRK-CNT         =   WRK-CNT  +  IDX-1
                   COMPUTE WRK-CNT-U       =   WRK-CNT-U  +  IDX-1U
               END-IF
               COMPUTE WRK-CNT         =   WRK-CNT  +  1
               COMPUTE WRK-CNT-U       =   WRK-CNT-U  +  1
               IF      WRK-CNT-U       <=  WRK-CONS-MAX-LEN
                   MOVE    X"0A"           TO  WRK-DATAVIEW(WRK-CNT:1)
               END-IF
           END-IF
           .
       40011-DATA-HEN-SEC-EXT.
           EXIT.
      *
      *****************************************************************
      *    ログアップロード処理
      *****************************************************************
       400-LOG-UPLOAD-SEC          SECTION.
      *
           INITIALIZE  SHELLTBL
           MOVE    SHELL-NAME          TO  SHELLTBL-NAME
           MOVE    ASS-LOGF            TO  SHELLTBL-ARG1
           MOVE    SPA-NAI-EXTRA (WRK-SELIDX)
                                       TO  SHELLTBL-EXTRA
      *    説明
           MOVE    SHELLTBL-LOG-FILEID TO  SHELLTBL-ARG2
      *    ログデータ型式
           IF      MCP-WIDGET          =   "B12"
               MOVE    "txt"               TO  SHELLTBL-ARG3
           ELSE
               MOVE    "html"              TO  SHELLTBL-ARG3
           END-IF
      *    ファイル名
           STRING  "batchlog-"             DELIMITED   BY  SIZE
                   SPA-GMN-TPID (WRK-SELIDX)
                                           DELIMITED   BY  SIZE
                   "."                     DELIMITED   BY  SIZE
                   SHELLTBL-ARG3           DELIMITED   BY  SPACE
               INTO    SHELLTBL-ARG4
           END-STRING
      *
           MOVE    SHELLTBL            TO  MCPDATA-REC
           MOVE    "SHELL"             TO  MCP-FUNC
           MOVE    "shell"             TO  MCP-TABLE
           MOVE    "allways"           TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"     USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
       400-LOG-UPLOAD-EXT.
           EXIT.
      *
      *****************************************************************
      *    前内容処理
      *****************************************************************
       470-PREV-SYORI-SEC          SECTION.
      *
           IF      SPA-NAI-PAGE        >   1
               COMPUTE SPA-NAI-PAGE        =   SPA-NAI-PAGE  -  1
               MOVE    SPA-NAI-PAGECNT (SPA-NAI-PAGE)
                                           TO  SPA-NAI-CNT
               COMPUTE SPA-NAI-PAGE        =   SPA-NAI-PAGE  -  1
               PERFORM 4001-DATA-HENSYU-SEC
           ELSE
               MOVE    "0003"              TO  SPA-ERRCD
           END-IF
           .
       470-PREV-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    次内容処理
      *****************************************************************
       470-NEXT-SYORI-SEC          SECTION.
      *
           IF      SPA-NAI-NEXT        =   1
               PERFORM 4001-DATA-HENSYU-SEC
           ELSE
               MOVE    "0002"              TO  SPA-ERRCD
           END-IF
           .
       470-NEXT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    タブ画面切り替え処理
      *****************************************************************
       490-TAB-CHANGE-SEC          SECTION.
      *
           DISPLAY "MJOB-PAGENO = " MJOB-PAGENO
           IF      MJOB-PAGENO         =   ZERO
               PERFORM 400-JOB-SELECT-SEC
           END-IF
           EVALUATE    MCP-WIDGET
               WHEN    "B08"
                   IF      MJOB-PAGENO         >=  1
                       MOVE    ZERO                TO  IDX-P
                   ELSE
                       COMPUTE IDX-P               =   MJOB-PAGENO
                                                   +   1
                   END-IF
               WHEN    OTHER
                   MOVE    MJOB-PAGENO         TO  IDX-P
           END-EVALUATE
      *
           EVALUATE    IDX-P
               WHEN    ZERO
                   MOVE    1                   TO  SPA-GMN-CUR
               WHEN    1
                   MOVE    2                   TO  SPA-GMN-CUR
           END-EVALUATE
           .
       490-TAB-CHANGE-EXT.
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
           MOVE    "CURRENT"           TO  MCP-PUTTYPE
           MOVE    "MJOB   "           TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE  MJOB
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL  (IDX                 >   99)
                     OR   (SPA-GMN-TSTART(IDX) =   SPACE)
      *
               MOVE    SPA-GMN-TUSER     (IDX) TO  MJOB-VALUE1 (IDX)
               MOVE    SPA-GMN-TPID      (IDX) TO  MJOB-VALUE2 (IDX)
               MOVE    SPA-GMN-TCOMMAND  (IDX) TO  MJOB-VALUE3 (IDX)
               MOVE    SPA-GMN-TSTART    (IDX) TO  MJOB-VALUE4 (IDX)
               MOVE    SPA-GMN-TEND      (IDX) TO  MJOB-VALUE5 (IDX)
               MOVE    SPA-GMN-TMSG      (IDX) TO  MJOB-VALUE6 (IDX)
               MOVE    SPA-GMN-TCOMMENT  (IDX) TO  MJOB-VALUE7 (IDX)
           END-PERFORM
      *
           MOVE    IDX                 TO  MJOB-COUNT
      *
           MOVE    SPA-GMN-DATAVIEW    TO  MJOB-DATAVIEW
           MOVE    SPA-GMN-CNTHEN      TO  MJOB-CNTHEN
      *
           IF      SPA-NAI-NEXT        =   1
               MOVE    "《次ページあり》"  TO  MJOB-MIDASI
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE    WIDGET-INSENSITIVE  TO  MJOB-B08-STATE
                   MOVE    WIDGET-INSENSITIVE  TO  MJOB-B11-STATE
                   MOVE    WIDGET-INSENSITIVE  TO  MJOB-B12-STATE
               WHEN    2
                   MOVE    WIDGET-NORMAL       TO  MJOB-B08-STATE
                   MOVE    WIDGET-NORMAL       TO  MJOB-B11-STATE
                   MOVE    WIDGET-NORMAL       TO  MJOB-B12-STATE
           END-EVALUATE
      *
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           IF    ( SPA-ERRCD           =   SPACE)
           AND   ( SPA-GMN-CUR         =   ZERO )
               PERFORM 50011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE    ZERO                TO  MJOB-PAGENO
                   MOVE    "LIST"              TO  MCP-WIDGET   
               WHEN    2
                   MOVE    1                   TO  MJOB-PAGENO
                   MOVE    "dataview"          TO  MCP-WIDGET   
           END-EVALUATE
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC         SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
           .
       50011-INPUT-CUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示処理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "表示するデータはありません。" 
                                               TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "次頁はありません。" 
                                               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "前頁はありません。" 
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  MMERR
           MOVE    SPA-ERRCD           TO  MMERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  MMERR-ERRMSG
      *
           MOVE    "B01"               TO  MCP-WIDGET
           MOVE    "MJOB"              TO  SPA-MOTOPG
           MOVE    "MMERR"             TO  SPA-SAKIPG
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "MMERR"             TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    monbatch_logレコード読み込み処理
      *****************************************************************
       900-MBL-FET-SEC             SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    "monbatch_log"      TO  MCP-TABLE
           MOVE    "list1"             TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
      *                                  
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  MBL-REC
               MOVE    ZERO                TO  FLG-MBL
           ELSE
               MOVE    1                   TO  FLG-MBL
           END-IF
           .
       900-MBL-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *    monbatch_clogレコード読み込み処理
      *****************************************************************
       900-MBCL-FET-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    "monbatch_clog"     TO  MCP-TABLE
           MOVE    "log1"              TO  MCP-PATHNAME
           CALL    "MONFUNC"       USING   MCPAREA
                                           MCPREC
                                           SPA-AREA
      *                                  
           IF      MCP-RC              =   ZERO
               MOVE    MCPREC              TO  MBCL-REC
               MOVE    ZERO                TO  FLG-MBCL
           ELSE
               MOVE    1                   TO  FLG-MBCL
           END-IF
           .
       900-MBCL-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ログファイル削除処理
      *****************************************************************
       900-LOGF-DEL-SEC            SECTION.
      *
           IF      ASS-LOGF        NOT =   SPACE
               MOVE    ZERO                TO  IF-RESULT
               MOVE    ASS-LOGF            TO  IF-FILENAME
               CALL    "orcfiledel"    USING   ORCSFDELAREA
           END-IF
           .
       900-LOGF-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE    "PUTWINDOW"         TO  MCP-FUNC
           CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
