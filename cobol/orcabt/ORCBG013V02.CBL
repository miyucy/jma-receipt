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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBG013V02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 外来月別請求書発行
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/12/03    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    対象患者ファイル（初期化用）
           SELECT  BG01301CL-FILE  ASSIGN   ORCBG01301PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  BG01301CL-KEY
                                   FILE    STATUS  IS  STS-BG01301CL.
      *
      *    対象患者ファイル
           SELECT  BG01301-FILE    ASSIGN   ORCBG01301PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  BG01301-KEY
                                   FILE    STATUS  IS  STS-BG01301.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    処理対象患者ファイル(初期化用)
       FD  BG01301CL-FILE.
       01  BG01301CL-REC.
           03  BG01301CL-KEY.
               05  BG01301CL-PTNUM             PIC X(20).
           03  BG01301CL-PTID                  PIC 9(10).
      *
      *    処理対象患者ファイル
       FD  BG01301-FILE.
       01  BG01301-REC.
           03  BG01301-KEY.
               05  BG01301-PTNUM               PIC X(20).
           03  BG01301-PTID                    PIC 9(10).
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                         PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    対象患者ファイル
           COPY    "CPCOMMONDAT2.INC"
                                           REPLACING   //RECE01//
                                           BY          //ORCBG01301//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"      REPLACING  //RECE01PARA//
                                           BY         //RECEERR//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-RECEERR                         PIC X(02).
           03  STS-BG01301CL                       PIC X(02).
           03  STS-BG01301                         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-SYUNOU                          PIC 9(01).
           03  FLG-BG01301                         PIC 9(01).
           03  FLG-PTNUM                           PIC 9(01).
           03  FLG-PTINF                           PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-BG01301                         PIC 9(05).
           03  CNT-PAGE                            PIC 9(08).
           03  CNT-JOB-UPDCNT                      PIC 9(08).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                                PIC 9(05).
           03  IDX1                                PIC 9(05).
           03  IDXE                                PIC 9(05).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                      PIC 9(07).
           03  WRK-PARA-SHELLID                    PIC X(08).
           03  WRK-PARA-HOSPID                     PIC X(24).
           03  WRK-PARA-SRYYM                      PIC X(06).
           03  WRK-PARA-HAKUHOUFLG                 PIC X(01).
           03  WRK-PARA-PTNUM                      PIC X(20).
           03  WRK-PARA-HAKYMD                     PIC X(08).
           03  WRK-PARA-ZEROSKYFLG                 PIC X(01).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR                         PIC X(200).
           03  WRK-PTID                            PIC 9(10).
           03  WRK-PTNUM                           PIC X(20).
           03  WRK-TITLE                           PIC X(100).
           03  WRK-STR                             PIC X(200).
           03  WRK-LEN                             PIC 9(05).
           03  WRK-SHO                             PIC 9(05).
           03  WRK-AMARI                           PIC 9(05).
           03  WRK-MAE-INPUT                       PIC X(300).
           03  WRK-OUT-INPUT                       PIC X(300).
           03  WRK-OUT-MAX                         PIC 9(05).
           03  WRK-STR-LEFT                        PIC X(500).
           03  WRK-STR-LEFT-Z      REDEFINES       WRK-STR-LEFT.
               05  WRK-STR-LEFT-ZX99               PIC Z(9)9.
               05                                  PIC X(490).
           03  WRK-STR-LEFT-TMP                    PIC X(500).
      *        全角編集用項目
           03  WRK-N.
               05  WRK-BG01301-KNS-N                PIC X(10).
               05  WRK-BG01301-TIME-N              PIC X(16).
      *
       01  ERR-EDIT-AREA.
           03  ERR-PTID                            PIC 9(10).
           03  ERR-PTNUM                           PIC X(20).
           03  ERR-ERRMSG                          PIC X(80).
           03  ERR-HEN-ERRMSG                      PIC X(80).
      *
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    印刷管理
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    印刷用データ
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    印刷ＤＢ制御サブ
           COPY    "CPORCSPRT.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    外来月別請求書
           COPY    "CPORCHCM43.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER                  PIC X(1000).
      *
      ******************************************************************
      *
       PROCEDURE               DIVISION
                                       USING
                                       COMMAND-PARAM.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  ERR-EDIT-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                       INTO            LNK-PRTKANRI-RENNUM
                                       LNK-PRTKANRI-TBL-KEY
                                       LNK-PRTKANRI-TBL-GROUP
                                       LNK-PRTKANRI-SHORI-RENNUM
                                       LNK-PRTKANRI-SRYYM
                                       LNK-PRTKANRI-SKYYMD
                                       LNK-PRTKANRI-SHELLID
                                       LNK-PRTKANRI-PRIORITY
                                       LNK-PRTKANRI-TERMID
                                       LNK-PRTKANRI-OPID
                                       LNK-PRTKANRI-PRTNM
                                       WRK-PARA-JOBID
                                       WRK-PARA-SHELLID
                                       WRK-PARA-HOSPID
                                       WRK-PARA-SRYYM
                                       WRK-PARA-HAKUHOUFLG
                                       WRK-PARA-PTNUM
                                       WRK-PARA-HAKYMD
                                       WRK-PARA-ZEROSKYFLG
      *
           MOVE    "外来月別請求書"    TO  WRK-TITLE
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBG013V02"       TO  JOB-PGID
           MOVE    WRK-TITLE           TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "BG01301"           TO  ORCBG01301PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  ORCBG01301PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
           MOVE    ZERO                TO  FLG-END
      *
      *    ＳＰＡエリアセット処理
           PERFORM 1001-SPA-SET-SEC
      *
      *    印刷パラメタエリアセット処理
           PERFORM 1001-ORCSPRTAREA-SET-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    ＳＰＡエリアセット処理
      *****************************************************************
       1001-SPA-SET-SEC                SECTION.
      *
      *    システム日付セット
           INITIALIZE                      SPA-AREA
           MOVE    "2"                 TO  SPA-NYUGAIKBN
           MOVE    LNK-PRTKANRI-SKYYMD
                                       TO  SPA-SYSYMD
           MOVE    WRK-PARA-HOSPID     TO  SPA-HOSPID
      *
           MOVE    LNK-PRTKANRI-TERMID TO  SPA-TERMID
      *
           .
       1001-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    印刷パラメタエリアセット処理
      *****************************************************************
       1001-ORCSPRTAREA-SET-SEC         SECTION.
      *
      *    印刷パラメタ編集
           INITIALIZE                      ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           MOVE    WRK-PARA-SRYYM      TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
           MOVE    WRK-TITLE           TO  SPRT-TITLE
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
      *
           .
       1001-ORCSPRTAREA-SET-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *
           EVALUATE    WRK-PARA-PTNUM
      *    外来全患者
           WHEN    SPACE
               PERFORM 210-GAI-ALL-HEN-SEC
               IF    ( FLG-END     NOT =   ZERO )
                   GO  TO  200-MAIN-EXT
               END-IF
      *    外来指定患者
           WHEN    OTHER
               PERFORM 210-PTSHITEI-HEN-SEC
               IF    ( FLG-END     NOT =   ZERO )
                   GO  TO  200-MAIN-EXT
               END-IF
           END-EVALUATE
      *
           MOVE    1                   TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    会計カード編集処理−外来対象診療年月全患者−
      *****************************************************************
       210-GAI-ALL-HEN-SEC             SECTION.
      *
      *    処理対象患者ファイル出力処理
           PERFORM 2101-BG01301-OUT-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  210-GAI-ALL-HEN-EXT
           END-IF
      *
      *    外来月別請求書編集処理
           PERFORM 2101-TUKISKY-HEN-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  210-GAI-ALL-HEN-EXT
           END-IF
      *
           .
       210-GAI-ALL-HEN-EXT.
           EXIT.
      *****************************************************************
      *    処理対象患者ファイル出力処理
      *****************************************************************
       2101-BG01301-OUT-SEC              SECTION.
      *
           OPEN    OUTPUT  BG01301CL-FILE
           CLOSE   BG01301CL-FILE
      *
           OPEN    OUTPUT  BG01301-FILE
      *
           MOVE    ZERO            TO  FLG-SYUNOU
      *
           PERFORM 900-SYUNOU-KEY36-SEL-SEC
      *
           PERFORM UNTIL ( FLG-SYUNOU  NOT =   ZERO )
      *
      *        患者番号取得
               MOVE    SYU-PTID    TO  WRK-PTID
               PERFORM 900-PTNUM-KEY-SEL-SEC
               IF    ( FLG-PTNUM   =   ZERO )
                   MOVE    MCPDATA-REC TO  PTNUM-REC
               ELSE
                   PERFORM 21011-PTNUM-ERR-HEN-SEC
                   GO  TO  2101-BG01301-OUT-EXT
               END-IF
      *
               INITIALIZE              BG01301-REC
               MOVE    PTNUM-PTNUM     TO  BG01301-PTNUM
               MOVE    SYU-PTID        TO  BG01301-PTID
      *
               WRITE   BG01301-REC
      *
               PERFORM 900-SYUNOU-KEY36-FET-SEC
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-SYUNOU-KEY36
                                   TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           CLOSE   BG01301-FILE
      *
           .
       2101-BG01301-OUT-EXT.
           EXIT.
      *****************************************************************
      *    患者情報エラー編集処理
      *****************************************************************
       21011-PTINF-ERR-HEN-SEC         SECTION.
      *
           INITIALIZE          ERR-EDIT-AREA
           MOVE    SYU-PTID    TO  ERR-PTID
           MOVE    "患者情報の取得に失敗しました"
                               TO  ERR-ERRMSG
           PERFORM 800-ERRMSG-EDIT-SEC
           MOVE    ERR-HEN-ERRMSG  TO  WRK-RECEERR
           PERFORM 500-ERR-HENSYU-SEC
      *
           .
       21011-PTINF-ERR-HEN-EXT.
           EXIT.
      *****************************************************************
      *    患者番号エラー編集処理
      *****************************************************************
       21011-PTNUM-ERR-HEN-SEC         SECTION.
      *
           INITIALIZE          ERR-EDIT-AREA
           MOVE    SYU-PTID    TO  ERR-PTID
           MOVE    "患者番号の取得に失敗しました"
                               TO  ERR-ERRMSG
           PERFORM 800-ERRMSG-EDIT-SEC
           MOVE    ERR-HEN-ERRMSG  TO  WRK-RECEERR
           PERFORM 500-ERR-HENSYU-SEC
      *
           .
       21011-PTNUM-ERR-HEN-EXT.
           EXIT.
      *****************************************************************
      *    外来月別請求書編集処理
      *****************************************************************
       2101-TUKISKY-HEN-SEC            SECTION.
      *
           MOVE    ZERO        TO  FLG-BG01301
           OPEN    INPUT  BG01301-FILE
      *
           PERFORM 900-BG01301-READ-SEC
      *
           PERFORM UNTIL ( FLG-BG01301 NOT =   ZERO )
      *
               MOVE    BG01301-PTID    TO  WRK-PTID
               MOVE    BG01301-PTNUM   TO  WRK-PTNUM
               PERFORM 2101-ORCHCM43-CALL-SEC
               IF    ( FLG-END     NOT =   ZERO )
                   GO  TO  2101-TUKISKY-HEN-EXT
               END-IF
      *
               PERFORM 2101-SYORI-KEIKA-HEN-SEC
      *
               PERFORM 900-BG01301-READ-SEC
      *
           END-PERFORM
      *
           CLOSE   BG01301-FILE
      *
           .
       2101-TUKISKY-HEN-EXT.
           EXIT.
      *****************************************************************
      *    処理経過編集処理
      *****************************************************************
       2101-SYORI-KEIKA-HEN-SEC        SECTION.
      *
           MOVE    ZERO            TO  WRK-SHO
                                       WRK-AMARI
           DIVIDE  50          INTO    CNT-BG01301 GIVING  WRK-SHO
           REMAINDER WRK-AMARI
           END-DIVIDE
      *
           IF    ( WRK-AMARI       NOT =   ZERO )
               GO  TO  2101-SYORI-KEIKA-HEN-EXT
           END-IF
      *
           MOVE    CNT-BG01301     TO  WRK-STR-LEFT-ZX99
           PERFORM 800-STR-HIDARIZUME-HEN-SEC
           MOVE    WRK-STR-LEFT    TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT   TO  WRK-BG01301-KNS-N
           PERFORM 800-MCNDATE-SEC
           MOVE    SPACE           TO  WRK-MAE-INPUT
           MOVE    SMCNDATE-HMS(1:2)
                                   TO  WRK-MAE-INPUT(1:2)
           MOVE    "."             TO  WRK-MAE-INPUT(3:1)
           MOVE    SMCNDATE-HMS(3:2)
                                   TO  WRK-MAE-INPUT(4:2)
           MOVE    "."             TO  WRK-MAE-INPUT(6:1)
           MOVE    SMCNDATE-HMS(5:2)
                                   TO  WRK-MAE-INPUT(7:2)
           MOVE    WRK-MAE-INPUT   TO  WRK-BG01301-TIME-N
      *
      *    ステップ途中処理
           MOVE    "STM"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           STRING  "処理患者数："      DELIMITED BY SIZE
                   WRK-BG01301-KNS-N   DELIMITED BY SPACE
                   "件　"              DELIMITED BY SIZE
                   WRK-BG01301-TIME-N  DELIMITED BY SPACE
           INTO    JOB-YOBI
           END-STRING
           MOVE    CNT-JOB-UPDCNT      TO  JOB-UPDCNT
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBG013V02"       TO  JOB-PGID
           MOVE    WRK-TITLE           TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    ZERO                TO  CNT-JOB-UPDCNT
      *
           .
       2101-SYORI-KEIKA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    外来月別請求書編集処理−患者指定−
      *****************************************************************
       210-PTSHITEI-HEN-SEC            SECTION.
      *
           MOVE    WRK-PARA-PTNUM      TO  WRK-PTNUM
           PERFORM 900-PTNUM-KEY2-SEL-SEC
      *
           MOVE    PTNUM-PTID          TO  WRK-PTID
           MOVE    PTNUM-PTNUM         TO  WRK-PTNUM
           PERFORM 2101-ORCHCM43-CALL-SEC
           IF    ( FLG-END         NOT =   ZERO )
               GO  TO  210-PTSHITEI-HEN-EXT
           END-IF
      *
           .
       210-PTSHITEI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    外来月別請求書編集サブ呼出処理
      *****************************************************************
       2101-ORCHCM43-CALL-SEC          SECTION.
      *
           MOVE    WRK-PTID            TO  SPA-PTID
           MOVE    WRK-PTNUM           TO  SPA-PTNUM
      *
           INITIALIZE                      ORCHCM43AREA
           MOVE    "1"                 TO  ORCHCM43-KBN
           MOVE    WRK-PARA-SRYYM      TO  ORCHCM43-STSRYYM
           MOVE    WRK-PARA-HAKUHOUFLG TO  ORCHCM43-HAKUHOUFLG
           MOVE    WRK-PARA-HAKYMD     TO  ORCHCM43-HAKYMD
           MOVE    WRK-PARA-ZEROSKYFLG TO  ORCHCM43-ZEROSKYFLG
      *
           CALL    "ORCHCM43V02"       USING
                                       SPA-AREA
                                       ORCSPRTAREA
                                       ORCHCM43AREA
           IF    ( ORCHCM43-RC     NOT =   ZERO )
               INITIALIZE              ERR-EDIT-AREA
               MOVE    SPA-PTID        TO  ERR-PTID
               MOVE    "外来月別請求書の作成に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG  TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  2101-ORCHCM43-CALL-EXT
           END-IF
      *
           COMPUTE CNT-BG01301 =   CNT-BG01301 +   1
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   ORCHCM43-PAGE
           COMPUTE CNT-JOB-UPDCNT  =   CNT-JOB-UPDCNT
                                   +   ORCHCM43-PAGE
      *
           .
       2101-ORCHCM43-CALL-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT               RECEERR-FILE
           IF        ( STS-RECEERR     =   ZERO )
               CONTINUE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR     TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
           MOVE    1               TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    ファイル削除
           PERFORM 800-BG01301-DEL-SEC
      *
           IF    ( CNT-BG01301     =   ZERO )
               MOVE    "処理対象のデータがありませんでした"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           DISPLAY "*** ORCBG01301 IN " CNT-BG01301  " ***"
           DISPLAY "*** ORCBG01301 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-JOB-UPDCNT  TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    全角変換処理
      *****************************************************************
       800-ZENKAKU-HEN-SEC         SECTION.
      *
           MOVE    SPACE           TO  WRK-OUT-INPUT
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE  WRK-MAE-INPUT     TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF    ( KANACHK-RC      =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-OUT-INPUT
               MOVE    KANACHK-MAX TO  WRK-OUT-MAX
           END-IF
      *
           .
       800-ZENKAKU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    文字列左詰処理
      *****************************************************************
       800-STR-HIDARIZUME-HEN-SEC      SECTION.
      *
           MOVE    WRK-STR-LEFT    TO  IDXE
           PERFORM VARYING IDXE    FROM    1   BY  1
                   UNTIL ( IDXE    >       500 )
      *
               IF    ( WRK-STR-LEFT (IDXE:1)
                                       NOT =   SPACE )
                   MOVE    WRK-STR-LEFT (IDXE:)
                                           TO  WRK-STR-LEFT-TMP
                   MOVE    WRK-STR-LEFT-TMP
                                           TO  WRK-STR-LEFT
                   MOVE    500             TO  IDXE
               END-IF
      *
           END-PERFORM
      *
           .
       800-STR-HIDARIZUME-HEN-EXT.
           EXIT.
      *****************************************************************
      *    対象患者ファイル削除処理
      *****************************************************************
       800-BG01301-DEL-SEC            SECTION.
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    ORCBG01301PARA TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
           .
       800-BG01301-DEL-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ編集処理
      *****************************************************************
       800-ERRMSG-EDIT-SEC         SECTION.
      *
           MOVE    SPACE           TO  ERR-HEN-ERRMSG
      *
           IF    ( ERR-PTNUM       =   SPACE )
               MOVE    ERR-PTID    TO  WRK-PTID
               PERFORM 900-PTNUM-KEY-SEL-SEC
               IF    ( FLG-PTNUM   =   ZERO )
                   MOVE    PTNUM-PTNUM TO  ERR-PTNUM
               ELSE
                   STRING "?(ID:"      DELIMITED   BY  SIZE
                      ERR-PTID         DELIMITED   BY  SIZE
                      ")"              DELIMITED   BY  SIZE
                   INTO   ERR-PTNUM
                   END-STRING
               END-IF
           END-IF
      *
           MOVE    1               TO  WRK-LEN
           MOVE    SPACE           TO  WRK-STR
           STRING  ERR-PTNUM           DELIMITED   BY  SPACE
           INTO    WRK-STR     WITH    POINTER WRK-LEN
           END-STRING
      *
           COMPUTE WRK-LEN         =   WRK-LEN -   1
      *
           MOVE    ZERO            TO  WRK-SHO
                                       WRK-AMARI
           DIVIDE  2   INTO    WRK-LEN GIVING  WRK-SHO
           REMAINDER WRK-AMARI
           END-DIVIDE
      *
           IF    ( WRK-AMARI   =   ZERO )
               STRING  ERR-ERRMSG          DELIMITED   BY  SPACE
                       "［患者番号："      DELIMITED   BY  SIZE
                       ERR-PTNUM           DELIMITED   BY  SPACE
                       "］"                DELIMITED   BY  SIZE
               INTO    ERR-HEN-ERRMSG
               END-STRING
           ELSE
               STRING  ERR-ERRMSG          DELIMITED   BY  SPACE
                       "［患者番号:"       DELIMITED   BY  SIZE
                       ERR-PTNUM           DELIMITED   BY  SPACE
                       "］"                DELIMITED   BY  SIZE
               INTO    ERR-HEN-ERRMSG
               END-STRING
           END-IF
      *
           .
       800-ERRMSG-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    対象患者ファイル読込処理
      *****************************************************************
       900-BG01301-READ-SEC          SECTION.
      *
           READ    BG01301-FILE       NEXT
           AT  END
               MOVE    1               TO  FLG-BG01301
           END-READ
      *
           .
       900-BG01301-READ-EXT.
           EXIT.
      *****************************************************************
      *    収納情報検索処理(KEY36)
      *****************************************************************
       900-SYUNOU-KEY36-SEL-SEC        SECTION.
      *
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID      TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN   TO  SYU-NYUGAIKBN
           STRING  WRK-PARA-SRYYM      DELIMITED   BY  SPACE
                   "%"                 DELIMITED   BY  SIZE
           INTO    SYU-SRYYMD
           END-STRING
      *
           MOVE    SYUNOU-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUNOU-KEY36
                                   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYUNOU-REC
           ELSE
               MOVE    1           TO  FLG-SYUNOU
           END-IF
      *
           .
       900-SYUNOU-KEY36-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納情報ＦＥＴＣＨ処理(KEY36)
      *****************************************************************
       900-SYUNOU-KEY36-FET-SEC        SECTION.
      *
           MOVE    PATH-TBL-SYUNOU-KEY36
                                   TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYUNOU-REC
           ELSE
               MOVE    1           TO  FLG-SYUNOU
           END-IF
      *
           .
       900-SYUNOU-KEY36-FET-EXT.
           EXIT.
      *****************************************************************
      *    患者番号情報検索処理(KEY)
      *****************************************************************
       900-PTNUM-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-PTNUM
      *
           INITIALIZE                  PTNUM-REC
           MOVE    WRK-PARA-HOSPID TO  PTNUM-HOSPID
           MOVE    WRK-PTID        TO  PTNUM-PTID
           MOVE    PTNUM-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNUM-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTNUM-REC
           ELSE
               MOVE    1           TO  FLG-PTNUM
               INITIALIZE              PTNUM-REC
           END-IF
      *
           MOVE    PATH-TBL-PTNUM-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-PTNUM-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    患者番号情報検索処理(KEY2)
      *****************************************************************
       900-PTNUM-KEY2-SEL-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-PTNUM
      *
           INITIALIZE                  PTNUM-REC
           MOVE    WRK-PARA-HOSPID TO  PTNUM-HOSPID
           STRING  WRK-PTNUM       DELIMITED   BY  SPACE
                   "%"             DELIMITED   BY  SIZE
           INTO    PTNUM-PTNUM
           END-STRING
           MOVE    PTNUM-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNUM-KEY2 TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTNUM-REC
           ELSE
               MOVE    1           TO  FLG-PTNUM
               INITIALIZE              PTNUM-REC
           END-IF
      *
           MOVE    PATH-TBL-PTNUM-KEY2 TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-PTNUM-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    患者情報検索処理(KEY)
      *****************************************************************
       900-PTINF-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-PTINF
      *
           INITIALIZE                  PTINF-REC
           MOVE    WRK-PARA-HOSPID TO  PTINF-HOSPID
           MOVE    WRK-PTID        TO  PTINF-PTID
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTINF-REC
           ELSE
               MOVE    1           TO  FLG-PTINF
               INITIALIZE              PTINF-REC
           END-IF
      *
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-PTINF-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC          SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       910-DBFETCH-SEC            SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　切断処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBDISCONNECT-EXT.
           EXIT.
