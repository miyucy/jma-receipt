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
       PROGRAM-ID.             ORCBG007.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 会計カード
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/07/30    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    処理対象患者ソートファイル(初期化用)
           SELECT  BG007SRTCL-FILE ASSIGN   ORCBG007SRTPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  BG007SRTCL-KEY
                                   FILE    STATUS  IS  STS-BG007SRTCL.
      *
      *    処理対象患者ソートファイル
           SELECT  BG007SRT-FILE   ASSIGN   ORCBG007SRTPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  BG007SRT-KEY
                                   FILE    STATUS  IS  STS-BG007SRT.
      *
      *    処理対象患者ファイル
           SELECT  BG00701-FILE    ASSIGN   ORCBG00701PARA
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-BG00701.
      *
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    処理対象患者ソートファイル(初期化用)
       FD  BG007SRTCL-FILE.
       01  BG007SRTCL-REC.
           03  BG007SRTCL-KEY                      PIC X(130).
           03  BG007SRTCL-PTID                     PIC 9(10).
      *
      *    処理対象患者ソートファイル
       FD  BG007SRT-FILE.
       01  BG007SRT-REC.
           03  BG007SRT-KEY                        PIC X(130).
           03  BG007SRT-PTID                       PIC 9(10).
      *
      *    病棟番号・カナ氏名順
       01  BG007SRT01-REC.
           03  BG007SRT01-KEY.
               05  BG007SRT01-BTUNUM               PIC 9(02).
               05  BG007SRT01-KANANAME             PIC X(100).
               05  BG007SRT01-DUMMY                PIC X(28).
           03  BG007SRT01-PTID                     PIC 9(10).
      *
      *    病棟番号・患者番号順
       01  BG007SRT02-REC.
           03  BG007SRT02-KEY.
               05  BG007SRT02-BTUNUM               PIC 9(02).
               05  BG007SRT02-PTNUM                PIC X(20).
               05  BG007SRT02-DUMMY                PIC X(108).
           03  BG007SRT02-PTID                     PIC 9(10).
      *
      *    カナ氏名順
       01  BG007SRT03-REC.
           03  BG007SRT03-KEY.
               05  BG007SRT03-KANANAME             PIC X(100).
               05  BG007SRT03-DUMMY                PIC X(30).
           03  BG007SRT03-PTID                     PIC 9(10).
      *
      *    患者番号順
       01  BG007SRT04-REC.
           03  BG007SRT04-KEY.
               05  BG007SRT04-PTNUM                PIC X(20).
               05  BG007SRT04-DUMMY                PIC X(110).
           03  BG007SRT04-PTID                     PIC 9(10).
      *
      *    処理対象患者ファイル
       FD  BG00701-FILE.
       01  BG00701-REC.
           03  BG00701-PTID                        PIC 9(10).
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    処理対象患者ファイル
           COPY    "CPCOMMONDAT2.INC"
                                           REPLACING   //RECE01//
                                           BY          //ORCBG007SRT//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    処理対象患者ファイル
           COPY    "CPCOMMONDAT2.INC"
                                           REPLACING   //RECE01//
                                           BY          //ORCBG00701//.
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
           03  STS-BG007SRTCL                      PIC X(02).
           03  STS-BG007SRT                        PIC X(02).
           03  STS-BG00701                         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-DBRC                            PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-SRYACCT                         PIC 9(01).
           03  FLG-BG00701                         PIC 9(01).
           03  FLG-PTNYUINRRK                      PIC 9(01).
           03  FLG-SKIP                            PIC 9(01).
           03  FLG-BG007SRT                        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-BG007                           PIC 9(05).
           03  CNT-PAGE                            PIC 9(08).
           03  CNT-JOB-UPDCNT                      PIC 9(08).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME                            PIC 9(08).
           03  SYS-YMD.
               05  SYS-YY                          PIC 9(02).
               05  SYS-MM                          PIC 9(02).
               05  SYS-DD                          PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDXE                                PIC 9(05).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                      PIC 9(07).
           03  WRK-PARA-SHELLID                    PIC X(08).
           03  WRK-PARA-HOSPID                     PIC X(24).
           03  WRK-PARA-SRYYM                      PIC X(06).
           03  WRK-PARA-PTNUM                      PIC X(20).
           03  WRK-PARA-NYUGAIKBN                  PIC X(01).
           03  WRK-PARA-BTUNUM                     PIC X(02).
           03  WRK-PARA-SRTKBN                     PIC X(01).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD                            PIC X(08).
           03  WRK-DBPATH                          PIC X(100).
           03  WRK-EDTYMD1                         PIC X(10).
           03  WRK-EDTYMD3                         PIC X(22).
           03  WRK-RECEERR                         PIC X(200).
           03  WRK-PTID                            PIC 9(10).
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
               05  WRK-BG007-KNS-N                 PIC X(10).
               05  WRK-BG007-TIME-N                PIC X(16).
      *
       01  KEY-AREA.
           03  KEY-PTID                            PIC 9(10).
      *
       01  ERR-EDIT-AREA.
           03  ERR-PTID                            PIC 9(10).
           03  ERR-PTNUM                           PIC X(20).
           03  ERR-ERRMSG                          PIC X(80).
           03  ERR-HEN-ERRMSG                      PIC X(80).
      *
           COPY    "CPSHELLTBL.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報
           COPY    "CPSK1009.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
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
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    印刷ＤＢ制御サブ
           COPY    "CPORCSPRT.INC".
      *
      *    会計カード編集サブ
           COPY    "CPORCHCM34.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "COMMON-SPA".
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
           PERFORM UNTIL ( FLG-END NOT =   ZERO )
               PERFORM 200-MAIN-SEC
           END-PERFORM
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
           INITIALIZE                  KEY-AREA
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
                                       WRK-PARA-PTNUM
                                       WRK-PARA-NYUGAIKBN
                                       WRK-PARA-BTUNUM
                                       WRK-PARA-SRTKBN
      *
           MOVE    SPACE               TO  WRK-TITLE
      *
           IF    ( WRK-PARA-NYUGAIKBN  =   "1" )
             OR  ( WRK-PARA-NYUGAIKBN  =   "2" )
               CONTINUE
           ELSE
               MOVE    "2"             TO  WRK-PARA-NYUGAIKBN
           END-IF
      *
           IF    ( WRK-PARA-NYUGAIKBN  =   "1" )
               MOVE    "会計カード−入院"
                                       TO  WRK-TITLE
           ELSE
               MOVE    "会計カード−外来"
                                       TO  WRK-TITLE
           END-IF
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBG007"          TO  JOB-PGID
           MOVE    WRK-TITLE           TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "BG007SR"           TO  ORCBG007SRTPARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  ORCBG007SRTPARA-TERMID
      *
           MOVE    "BG00701"           TO  ORCBG00701PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  ORCBG00701PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
      *    ＳＰＡエリアセット処理
           PERFORM 110-SPA-SET-SEC
      *
      *    印刷パラメタエリアセット処理
           PERFORM 110-ORCSPRTAREA-SET-SEC
      *
           MOVE    ZERO                TO  CNT-BG007
                                           CNT-PAGE
                                           CNT-JOB-UPDCNT
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＳＰＡエリアセット処理
      *****************************************************************
       110-SPA-SET-SEC                 SECTION.
      *
      *    システム日付セット
           INITIALIZE                      SPA-AREA
           MOVE    LNK-PRTKANRI-SKYYMD
                                       TO  SPA-SYSYMD
           MOVE    WRK-PARA-HOSPID     TO  SPA-HOSPID
      *
      *
      *    患者番号構成管理情報編集
           MOVE    SPACE               TO  SYS-1009-REC
           INITIALIZE                  SYS-1009-REC
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    "SYSKANRI-KEY"      TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC            =   ZERO )
               MOVE    MCPDATA-REC         TO  SYS-1009-REC
               MOVE    SYS-1009-PTNUMKSIKBN
                                       TO  SPA-1009-PTNUMKSIKBN
               MOVE    SYS-1009-JIYKSIKBN
                                       TO  SPA-1009-JIYKSIKBN
               MOVE    SYS-1009-JIYKSIKETA
                                       TO  SPA-1009-JIYKSIKETA
               MOVE    SYS-1009-HJNKSIKBN
                                       TO  SPA-1009-HJNKSIKBN
               MOVE    SYS-1009-HJNKSINENKBN
                                       TO  SPA-1009-HJNKSINENKBN
               MOVE    SYS-1009-HJNKSIRENNUMKBN
                                       TO  SPA-1009-HJNKSIRENNUMKBN
               MOVE    SYS-1009-HJNKSIRENNUMKETA
                                       TO  SPA-1009-HJNKSIRENNUMKETA
               MOVE    SYS-1009-KKCKSIKBN
                                       TO  SPA-1009-KKCKSIKBN
               MOVE    SYS-1009-KKCKSIMAEKETA
                                       TO  SPA-1009-KKCKSIMAEKETA
               MOVE    SYS-1009-KKCKSIRENNUMKETA
                                       TO  SPA-1009-KKCKSIRENNUMKETA
               MOVE    SYS-1009-KKCKSIATOKETA
                                       TO  SPA-1009-KKCKSIATOKETA
           END-IF
      *
           MOVE    LNK-PRTKANRI-TERMID TO  SPA-TERMID
      *
           .
       110-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷パラメタエリアセット処理
      *****************************************************************
       110-ORCSPRTAREA-SET-SEC         SECTION.
      *
      *    印刷パラメタ編集
           INITIALIZE                      ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           MOVE    LNK-PRTKANRI-SRYYM  TO  SPRT-SRYYM
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
       110-ORCSPRTAREA-SET-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           EVALUATE    WRK-PARA-NYUGAIKBN
                                   ALSO WRK-PARA-PTNUM
      *    入院全患者
           WHEN        "1"         ALSO SPACE
               PERFORM 210-NYU-ALL-HEN-SEC
               IF    ( FLG-END     NOT =   ZERO )
                   GO  TO  200-MAIN-EXT
               END-IF
      *    入院指定患者
           WHEN        "1"         ALSO NOT SPACE
               PERFORM 210-PTSHITEI-HEN-SEC
               IF    ( FLG-END     NOT =   ZERO )
                   GO  TO  200-MAIN-EXT
               END-IF
      *    外来全患者
           WHEN        "2"         ALSO SPACE
               PERFORM 210-GAI-ALL-HEN-SEC
               IF    ( FLG-END     NOT =   ZERO )
                   GO  TO  200-MAIN-EXT
               END-IF
      *    外来指定患者
           WHEN        "2"         ALSO NOT SPACE
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
      *    会計カード編集処理−入院対象診療年月全患者−
      *****************************************************************
       210-NYU-ALL-HEN-SEC         SECTION.
      *
      *    処理対象患者ソートファイル編集処理
           PERFORM 2101-SRTFILE-HEN-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  210-NYU-ALL-HEN-EXT
           END-IF
      *
      *    処理対象患者ファイル出力処理
           PERFORM 2101-NYU-BG007-OUT-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  210-NYU-ALL-HEN-EXT
           END-IF
      *
      *    会計カード編集処理
           PERFORM 2101-KAIKEI-HEN-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  210-NYU-ALL-HEN-EXT
           END-IF
      *
           .
       210-NYU-ALL-HEN-EXT.
           EXIT.
      *****************************************************************
      *    処理対象患者ソートファイル編集処理
      *****************************************************************
       2101-SRTFILE-HEN-SEC        SECTION.
      *
      *    処理対象患者ソートファイル初期化
           OPEN    OUTPUT                  BG007SRTCL-FILE
           CLOSE   BG007SRTCL-FILE
      *
           OPEN    OUTPUT                  BG007SRT-FILE
      *
      *    対象患者抽出
           MOVE    ZERO                TO  FLG-PTNYUINRRK
           INITIALIZE                      PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    WRK-PARA-SRYYM      TO  WRK-SYMD
           PERFORM 800-GETUMATU-SEC
           MOVE    WRK-SYMD            TO  PTNYUINRRK-NYUINYMD
           MOVE    WRK-PARA-SRYYM      TO  PTNYUINRRK-TAIINYMD
           MOVE    "01"                TO  PTNYUINRRK-TAIINYMD(7:2)
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY26"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1               TO  FLG-PTNYUINRRK
           ELSE
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
               MOVE    PTNYUINRRK-PTID TO  KEY-PTID
           END-IF
      *
           PERFORM UNTIL ( FLG-PTNYUINRRK  NOT =   ZERO )
      *
      *        最新入院歴情報取得処理
               PERFORM 21011-SAISIN-NYUINRRK-GET-SEC
               IF    ( FLG-END         NOT =   ZERO )
                   GO  TO  2101-SRTFILE-HEN-EXT
               END-IF
      *
               IF    ( PTINF-TSTPTNUMKBN   NOT =   "1" )
                   IF    ( WRK-PARA-BTUNUM     =   SPACE )
                       PERFORM 21011-BG007SRT-WRITE-SEC
                       IF    ( FLG-END         NOT =   ZERO )
                           GO  TO  2101-SRTFILE-HEN-EXT
                       END-IF
                   ELSE
                       IF    ( WRK-PARA-BTUNUM =   PTNYUINRRK-BTUNUM )
                           PERFORM 21011-BG007SRT-WRITE-SEC
                           IF    ( FLG-END         NOT =   ZERO )
                               GO  TO  2101-SRTFILE-HEN-EXT
                           END-IF
                       END-IF
                   END-IF
               END-IF
      *
               PERFORM 900-PTNYUINRRK-KEY26-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "PTNYUINRRK-KEY26"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           CLOSE   BG007SRT-FILE
      *
           .
       2101-SRTFILE-HEN-EXT.
           EXIT.
      *****************************************************************
      *    最新入院歴情報取得処理
      *****************************************************************
       21011-SAISIN-NYUINRRK-GET-SEC   SECTION.
      *
      *    患者情報読み込み
           INITIALIZE                      PTINF-REC
           MOVE    PTNYUINRRK-HOSPID   TO  PTINF-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "PTINF-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               INITIALIZE          ERR-EDIT-AREA
               MOVE   PTNYUINRRK-PTID  TO  ERR-PTID
               MOVE    "患者情報の取得に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG  TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  21011-SAISIN-NYUINRRK-GET-EXT
           ELSE
               MOVE    MCPDATA-REC     TO  PTINF-REC
           END-IF
      *
           MOVE    "PTINF-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( PTINF-TSTPTNUMKBN   NOT =   "1" )
      *
      *        最新の入院履歴情報を取得
               INITIALIZE  PTNYUINRRK-REC
               MOVE    PTINF-HOSPID        TO  PTNYUINRRK-HOSPID
               MOVE    PTINF-PTID          TO  PTNYUINRRK-PTID
               MOVE    PTINF-RRKNUM        TO  PTNYUINRRK-RRKNUM
               MOVE    PTINF-RRKEDANUM     TO  PTNYUINRRK-RRKEDANUM
               MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
               MOVE    "PTNYUINRRK-KEY"    TO  WRK-DBPATH
               PERFORM 900-TBL-SELECT-SEC
               IF    ( FLG-DBRC        NOT =   ZERO )
                   INITIALIZE              ERR-EDIT-AREA
                   MOVE    PTINF-PTID      TO  ERR-PTID
                   MOVE    "最新入院履歴の取得に失敗しました"
                                           TO  ERR-ERRMSG
                   PERFORM 800-ERRMSG-EDIT-SEC
                   MOVE    ERR-HEN-ERRMSG
                                           TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  21011-SAISIN-NYUINRRK-GET-EXT
               ELSE
                   MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY"    TO  WRK-DBPATH
               PERFORM 900-TBL-CLOSE-SEC
           END-IF
      *
           .
       21011-SAISIN-NYUINRRK-GET-EXT.
           EXIT.
      *****************************************************************
      *    処理対象患者ファイル出力処理（入院）
      *****************************************************************
       2101-NYU-BG007-OUT-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-BG007SRT
      *
           OPEN    INPUT   BG007SRT-FILE
           OPEN    OUTPUT  BG00701-FILE
      *
           PERFORM 2101-BG007SRT-READ-SEC
      *
           PERFORM UNTIL ( FLG-BG007SRT    NOT =   ZERO )
      *
               MOVE    BG007SRT-PTID   TO  BG00701-PTID
               WRITE   BG00701-REC
      *
               PERFORM 2101-BG007SRT-READ-SEC
      *
           END-PERFORM
      *
           CLOSE   BG00701-FILE
           CLOSE   BG007SRT-FILE
      *
           .
       2101-NYU-BG007-OUT-EXT.
           EXIT.
      *****************************************************************
      *    処理対象患者ファイル出力処理（入院）
      *****************************************************************
       2101-BG007SRT-READ-SEC          SECTION.
      *
           READ    BG007SRT-FILE       NEXT
           AT  END
               MOVE    1               TO  FLG-BG007SRT
           END-READ
      *
           .
       2101-BG007SRT-READ-EXT.
           EXIT.
      *****************************************************************
      *    処理対象患者ソートファイル出力処理
      *****************************************************************
       21011-BG007SRT-WRITE-SEC        SECTION.
      *
           EVALUATE    WRK-PARA-SRTKBN
      *
           WHEN    "1"
               INITIALIZE                  BG007SRT01-REC
               MOVE    PTNYUINRRK-BTUNUM
                                           TO  BG007SRT01-BTUNUM
               MOVE    PTINF-KANANAME      TO  BG007SRT01-KANANAME
               MOVE    PTNYUINRRK-PTID     TO  BG007SRT01-PTID
               WRITE   BG007SRT01-REC
           WHEN    "2"
      *
               PERFORM 21011-PTNUM-GET-SEC
               IF    ( FLG-END         NOT =   ZERO )
                   GO  TO  21011-BG007SRT-WRITE-EXT
               END-IF
      *
               INITIALIZE                  BG007SRT02-REC
               MOVE    PTNYUINRRK-BTUNUM
                                           TO  BG007SRT02-BTUNUM
               MOVE    SPTID-PTNUM         TO  BG007SRT02-PTNUM
               MOVE    PTNYUINRRK-PTID     TO  BG007SRT02-PTID
               WRITE   BG007SRT02-REC
           WHEN    "3"
      *
               INITIALIZE                  BG007SRT03-REC
               MOVE    PTINF-KANANAME      TO  BG007SRT03-KANANAME
               MOVE    PTNYUINRRK-PTID     TO  BG007SRT03-PTID
               WRITE   BG007SRT03-REC
           WHEN    "4"
      *
               PERFORM 21011-PTNUM-GET-SEC
               IF    ( FLG-END         NOT =   ZERO )
                   GO  TO  21011-BG007SRT-WRITE-EXT
               END-IF
      *
               INITIALIZE                  BG007SRT04-REC
               MOVE    SPTID-PTNUM         TO  BG007SRT04-PTNUM
               MOVE    PTNYUINRRK-PTID     TO  BG007SRT04-PTID
               WRITE   BG007SRT04-REC
           WHEN    OTHER
               INITIALIZE                  BG007SRT01-REC
               MOVE    PTNYUINRRK-BTUNUM   TO  BG007SRT01-BTUNUM
               MOVE    PTINF-KANANAME      TO  BG007SRT01-KANANAME
               MOVE    PTNYUINRRK-PTID     TO  BG007SRT01-PTID
               WRITE   BG007SRT01-REC
           END-EVALUATE
      *
           .
       21011-BG007SRT-WRITE-EXT.
           EXIT.
      *****************************************************************
      *    患者番号取得処理
      *****************************************************************
       21011-PTNUM-GET-SEC         SECTION.
      *
           INITIALIZE                      ORCSPTIDAREA
           MOVE    PTNYUINRRK-HOSPID   TO  SPTID-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  SPTID-PTID
           CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                           SPA-1009-TBL
           IF    ( SPTID-RC        NOT =   ZERO )
               INITIALIZE              ERR-EDIT-AREA
               MOVE    PTNYUINRRK-PTID
                                       TO  ERR-PTID
               MOVE    "患者番号の取得に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG  TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  21011-PTNUM-GET-EXT
           END-IF
      *
           .
       21011-PTNUM-GET-EXT.
           EXIT.
      *****************************************************************
      *    会計カード編集処理−外来対象診療年月全患者−
      *****************************************************************
       210-GAI-ALL-HEN-SEC         SECTION.
      *
      *    処理対象患者ファイル出力処理
           PERFORM 2101-GAI-BG007-OUT-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  210-GAI-ALL-HEN-EXT
           END-IF
      *
      *    会計カード編集処理
           PERFORM 2101-KAIKEI-HEN-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  210-GAI-ALL-HEN-EXT
           END-IF
      *
           .
       210-GAI-ALL-HEN-EXT.
           EXIT.
      *****************************************************************
      *    処理対象患者ファイル出力処理（外来）
      *****************************************************************
       2101-GAI-BG007-OUT-SEC          SECTION.
      *
           OPEN    OUTPUT  BG00701-FILE
      *
           MOVE    ZERO            TO  FLG-SRYACCT
      *
           INITIALIZE                  SRYACCT-REC
           MOVE    SPA-HOSPID      TO  ACCT-HOSPID
           MOVE    WRK-PARA-NYUGAIKBN
                                   TO  ACCT-NYUGAIKBN
           MOVE    WRK-PARA-SRYYM  TO  ACCT-SRYYM
           MOVE    SRYACCT-REC     TO  MCPDATA-REC
           MOVE    "SRYACCT-KEY21" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    1           TO  FLG-SRYACCT
           ELSE
               MOVE    MCPDATA-REC TO  SRYACCT-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SRYACCT NOT =   ZERO )
      *
      *        患者情報読み込み（テスト患者チェック）
               INITIALIZE              PTINF-REC
               MOVE    SPA-HOSPID  TO  PTINF-HOSPID
               MOVE    ACCT-PTID   TO  PTINF-PTID
               MOVE    PTINF-REC   TO  MCPDATA-REC
               MOVE    "PTINF-KEY" TO  WRK-DBPATH
               PERFORM 900-TBL-SELECT-SEC
               IF    ( FLG-DBRC    NOT =   ZERO )
                   INITIALIZE          ERR-EDIT-AREA
                   MOVE    ACCT-PTID       TO  ERR-PTID
                   MOVE    "患者情報の取得に失敗しました"
                                   TO  ERR-ERRMSG
                   PERFORM 800-ERRMSG-EDIT-SEC
                   MOVE    ERR-HEN-ERRMSG  TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2101-GAI-BG007-OUT-EXT
               ELSE
                   MOVE    MCPDATA-REC TO  PTINF-REC
               END-IF
      *
      *        テスト患者は対象外とする
               IF    ( PTINF-TSTPTNUMKBN   NOT =   "1" )
                   MOVE    ACCT-PTID   TO  BG00701-PTID
                   WRITE   BG00701-REC
               END-IF
      *
               MOVE    "SRYACCT-KEY21" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC    NOT =   ZERO )
                   MOVE    1           TO  FLG-SRYACCT
               ELSE
                   MOVE    MCPDATA-REC TO  SRYACCT-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SRYACCT-KEY21" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           CLOSE   BG00701-FILE
      *
           .
       2101-GAI-BG007-OUT-EXT.
           EXIT.
      *****************************************************************
      *    会計カード編集処理
      *****************************************************************
       2101-KAIKEI-HEN-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-BG00701
           OPEN    INPUT  BG00701-FILE
      *
           PERFORM 2101-BG00701-READ-SEC
      *
           PERFORM UNTIL ( FLG-BG00701 NOT =   ZERO )
      *
               MOVE    BG00701-PTID    TO  WRK-PTID
               PERFORM 2101-ORCHCM34-CALL-SEC
               IF    ( FLG-END     NOT =   ZERO )
                   GO  TO  2101-KAIKEI-HEN-EXT
               END-IF
      *
               PERFORM 2101-SYORI-KEIKA-HEN-SEC
      *
               PERFORM 2101-BG00701-READ-SEC
      *
           END-PERFORM
      *
           CLOSE   BG00701-FILE
      *
           .
       2101-KAIKEI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    処理対象患者ファイル読込処理
      *****************************************************************
       2101-BG00701-READ-SEC           SECTION.
      *
           READ    BG00701-FILE
           AT  END
               MOVE    1       TO  FLG-BG00701
           END-READ
      *
           .
       2101-BG00701-READ-EXT.
           EXIT.
      *****************************************************************
      *    処理対象患者ファイル削除処理
      *****************************************************************
       2101-BG00701-DEL-SEC            SECTION.
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    ORCBG00701PARA  TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
           .
       2101-BG00701-DEL-EXT.
           EXIT.
      *****************************************************************
      *    処理対象患者ソートファイル削除処理
      *****************************************************************
       2101-BG007SRT-DEL-SEC          SECTION.
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    ORCBG007SRTPARA TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
           .
       2101-BG007SRT-DEL-EXT.
           EXIT.
      *****************************************************************
      *    処理経過編集処理
      *****************************************************************
       2101-SYORI-KEIKA-HEN-SEC        SECTION.
      *
           MOVE    ZERO            TO  WRK-SHO
                                       WRK-AMARI
           DIVIDE  50          INTO    CNT-BG007   GIVING  WRK-SHO
           REMAINDER WRK-AMARI
           END-DIVIDE
      *
           IF    ( WRK-AMARI       NOT =   ZERO )
               GO  TO  2101-SYORI-KEIKA-HEN-EXT
           END-IF
      *
           MOVE    CNT-BG007       TO  WRK-STR-LEFT-ZX99
           PERFORM 800-STR-HIDARIZUME-HEN-SEC
           MOVE    WRK-STR-LEFT    TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT   TO  WRK-BG007-KNS-N
           ACCEPT  SYS-TIME        FROM    TIME
           MOVE    SPACE           TO  WRK-MAE-INPUT
           MOVE    SYS-TIME(1:2)   TO  WRK-MAE-INPUT(1:2)
           MOVE    "."             TO  WRK-MAE-INPUT(3:1)
           MOVE    SYS-TIME(3:2)   TO  WRK-MAE-INPUT(4:2)
           MOVE    "."             TO  WRK-MAE-INPUT(6:1)
           MOVE    SYS-TIME(5:2)   TO  WRK-MAE-INPUT(7:2)
      *    PERFORM 800-ZENKAKU-HEN-SEC
      *    MOVE    WRK-OUT-INPUT   TO  WRK-BG007-TIME-N
           MOVE    WRK-MAE-INPUT   TO  WRK-BG007-TIME-N
      *
      *    ステップ途中処理
           MOVE    "STM"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           STRING  "処理患者数："      DELIMITED BY SIZE
                   WRK-BG007-KNS-N     DELIMITED BY SPACE
                   "件　"              DELIMITED BY SIZE
                   WRK-BG007-TIME-N    DELIMITED BY SPACE
           INTO    JOB-YOBI
           END-STRING
           MOVE    CNT-JOB-UPDCNT      TO  JOB-UPDCNT
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBG007"          TO  JOB-PGID
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
      *    会計カード編集処理−患者指定−
      *****************************************************************
       210-PTSHITEI-HEN-SEC            SECTION.
      *
           INITIALIZE                      ORCSPTIDAREA
           MOVE    SPA-HOSPID          TO  SPTID-HOSPID
           MOVE    WRK-PARA-PTNUM      TO  SPTID-PTNUM
           CALL    "ORCSPTID"          USING
                                       ORCSPTIDAREA
                                       SPA-1009-TBL
           IF    ( SPTID-RC        NOT =   ZERO )
               INITIALIZE              ERR-EDIT-AREA
               MOVE    WRK-PARA-PTNUM  TO  ERR-PTNUM
               MOVE    "該当の患者は存在しません"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG  TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  210-PTSHITEI-HEN-EXT
           END-IF
      *
           MOVE    SPTID-PTID          TO  WRK-PTID
           PERFORM 2101-ORCHCM34-CALL-SEC
           IF    ( FLG-END         NOT =   ZERO )
               GO  TO  210-PTSHITEI-HEN-EXT
           END-IF
      *
           .
       210-PTSHITEI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    会計カード編集サブ呼出処理
      *****************************************************************
       2101-ORCHCM34-CALL-SEC          SECTION.
      *
           MOVE    WRK-PTID            TO  SPA-PTID
      *
           INITIALIZE                      ORCHCM34AREA
           MOVE    "2"                 TO  ORCHCM34-KBN
           MOVE    WRK-PARA-SRYYM      TO  ORCHCM34-SRYYM
           MOVE    WRK-PARA-NYUGAIKBN  TO  ORCHCM34-NYUGAIKBN
           MOVE    ORCSPRTAREA         TO  ORCHCM34-PRTAREA
      *
           CALL    "ORCHCM34"          USING
                                       SPA-AREA
                                       ORCHCM34AREA
           IF    ( ORCHCM34-RC     NOT =   ZERO )
               INITIALIZE              ERR-EDIT-AREA
               MOVE    SPA-PTID        TO  ERR-PTID
               MOVE    "会計カードの作成に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG  TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  2101-ORCHCM34-CALL-EXT
           END-IF
      *
           COMPUTE CNT-BG007   =   CNT-BG007   +   1
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   ORCHCM34-PAGE
           COMPUTE CNT-JOB-UPDCNT  =   CNT-JOB-UPDCNT
                                   +   ORCHCM34-PAGE
      *
           .
       2101-ORCHCM34-CALL-EXT.
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
           PERFORM 2101-BG007SRT-DEL-SEC
           PERFORM 2101-BG00701-DEL-SEC
      *
           IF    ( CNT-BG007           =   ZERO )
               MOVE    "処理対象のデータがありませんでした"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           DISPLAY "*** ORCBG007 IN " CNT-BG007  " ***"
           DISPLAY "*** ORCBG007 END ***"
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
      *    月末日取得処理
      *****************************************************************
       800-GETUMATU-SEC      SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY1-AREA
           MOVE    "71"                TO   LNK-DAY7-IRAI
           MOVE    WRK-SYMD (1 : 6)    TO   LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                       LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-SYMD
      *
           .
       800-GETUMATU-EXT.
            EXIT.
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC           SECTION.
      *
           MOVE    SPACE           TO  WRK-EDTYMD1
                                       WRK-EDTYMD3
      *
           IF        ( WRK-SYMD        =   SPACE )
               GO  TO  800-SEIWA-HEN-EXT
           END-IF
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-EDTYMD1
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-EDTYMD3
           INSPECT WRK-EDTYMD3     REPLACING  ALL "  "  BY  "　"
      *
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ編集処理
      *****************************************************************
       800-ERRMSG-EDIT-SEC         SECTION.
      *
           MOVE    SPACE           TO  ERR-HEN-ERRMSG
      *
           IF    ( ERR-PTNUM       =   SPACE )
               INITIALIZE              ORCSPTIDAREA
               MOVE    WRK-PARA-HOSPID TO  SPTID-HOSPID
               MOVE    ERR-PTID        TO  SPTID-PTID
               CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                           SPA-1009-TBL
               IF    ( SPTID-RC            =   ZERO )
                   MOVE    SPTID-PTNUM TO  ERR-PTNUM
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
      *
      *****************************************************************
      *    処理対象患者ソートファイル編集処理
      *****************************************************************
       900-PTNYUINRRK-KEY26-READ-SEC   SECTION.
      *
           MOVE    1                       TO  FLG-SKIP
      *
           PERFORM UNTIL ( FLG-SKIP            = ZERO )
                    OR   ( FLG-PTNYUINRRK  NOT = ZERO )
      *
      *
               MOVE    "PTNYUINRRK-KEY26"  TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC        NOT =   ZERO )
                   MOVE    1               TO  FLG-PTNYUINRRK
               ELSE
                   MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
                   IF    ( PTNYUINRRK-PTID NOT =   KEY-PTID )
                       MOVE    PTNYUINRRK-PTID TO  KEY-PTID
                       MOVE    ZERO        TO  FLG-SKIP
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       900-PTNYUINRRK-KEY26-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
               MOVE    WRK-DBPATH      TO  ORC-DBPATH
               MOVE    "DBFETCH"       TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF        ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1           TO  FLG-DBRC
               END-IF
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       900-TBL-READ-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-TBL-CLOSE-SEC           SECTION.
      *
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　ＣＯＭＭＩＴ処理
      *****************************************************************
       900-DBCOMMIT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
           .
       900-DBCOMMIT-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　ＳＴＡＲＴ処理
      *****************************************************************
       900-DBSTART-SEC                SECTION.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       900-DBSTART-EXT.
           EXIT.
