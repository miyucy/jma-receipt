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
       PROGRAM-ID.             ORCBG012.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 調整金一覧表
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/12/03    NACL-太田     新規作成
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
      *    調整金情報ソートファイル（初期化用）
           SELECT  BG012SRTCL-FILE ASSIGN   ORCBG012SRTPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  BG012SRTCL-KEY
                                   FILE    STATUS  IS  STS-BG012SRTCL.
      *
      *    調整金情報ソートファイル
           SELECT  BG012SRT-FILE   ASSIGN   ORCBG012SRTPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  BG012SRT-KEY
                                   FILE    STATUS  IS  STS-BG012SRT.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    調整金情報ソートファイル（初期化用）
       FD  BG012SRTCL-FILE.
       01  BG012SRTCL-REC.
           02  BG012SRTCL-KEY                  PIC X(150).
           02  BG012SRTCL-PTNUM                PIC X(20).
           02  BG012SRTCL-NAME                 PIC X(100).
           02  BG012SRTCL-DAT.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-//
                                           BY //BG012SRTCL-SYU-//.
      *
      *    調整金情報ソートファイル
       FD  BG012SRT-FILE.
       01  BG012SRT-REC.
           02  BG012SRT-KEY.
               03  BG012SRT-KEY-SRYKA          PIC X(02).
               03  BG012SRT-KEY-SEQ            PIC 9(08).
               03  BG012SRT-KEY-DUMMY          PIC X(140).
           02  BG012SRT-PTNUM                  PIC X(20).
           02  BG012SRT-NAME                   PIC X(100).
           02  BG012SRT-DAT.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-//
                                           BY //BG012SRT-SYU-//.
      *
      *    患者番号順
       01  BG012SRT01-REC.
           02  BG012SRT01-KEY.
               03  BG012SRT01-KEY-SRYKA        PIC X(02).
               03  BG012SRT01-KEY-PTNUM        PIC X(20).
               03  BG012SRT01-KEY-SRYYMD       PIC X(08).
               03  BG012SRT01-KEY-DENPNUM      PIC 9(07).
               03  BG012SRT01-KEY-SEQ          PIC 9(08).
               03  BG012SRT01-KEY-DUMMY        PIC X(105).
           02  BG012SRT01-PTNUM                PIC X(20).
           02  BG012SRT01-NAME                 PIC X(100).
           02  BG012SRT01-DAT.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-//
                                           BY //BG012SRT01-SYU-//.
      *
      *    診療年月日
       01  BG012SRT02-REC.
           02  BG012SRT02-KEY.
               03  BG012SRT02-KEY-SRYKA        PIC X(02).
               03  BG012SRT02-KEY-SRYYMD       PIC X(08).
               03  BG012SRT02-KEY-DENPNUM      PIC 9(07).
               03  BG012SRT02-KEY-PTNUM        PIC X(20).
               03  BG012SRT02-KEY-SEQ          PIC 9(08).
               03  BG012SRT02-KEY-DUMMY        PIC X(105).
           02  BG012SRT02-PTNUM                PIC X(20).
           02  BG012SRT02-NAME                 PIC X(100).
           02  BG012SRT02-DAT.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-//
                                           BY //BG012SRT02-SYU-//.

      *
      *    伝票番号
       01  BG012SRT03-REC.
           02  BG012SRT03-KEY.
               03  BG012SRT03-KEY-SRYKA        PIC X(02).
               03  BG012SRT03-KEY-DENPNUM      PIC 9(07).
               03  BG012SRT03-KEY-SEQ          PIC 9(08).
               03  BG012SRT03-KEY-DUMMY        PIC X(133).
           02  BG012SRT03-PTNUM                PIC X(20).
           02  BG012SRT03-NAME                 PIC X(100).
           02  BG012SRT03-DAT.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-//
                                           BY //BG012SRT03-SYU-//.
      *
      *    カナ氏名順
       01  BG012SRT04-REC.
           02  BG012SRT04-KEY.
               03  BG012SRT04-KEY-SRYKA        PIC X(02).
               03  BG012SRT04-KEY-KANANAME     PIC X(100).
               03  BG012SRT04-KEY-PTNUM        PIC X(20).
               03  BG012SRT04-KEY-SRYYMD       PIC X(08).
               03  BG012SRT04-KEY-DENPNUM      PIC 9(07).
               03  BG012SRT04-KEY-SEQ          PIC 9(08).
               03  BG012SRT04-KEY-DUMMY        PIC X(05).
           02  BG012SRT04-PTNUM                PIC X(20).
           02  BG012SRT04-NAME                 PIC X(100).
           02  BG012SRT04-DAT.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-//
                                           BY //BG012SRT04-SYU-//.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    調整金情報ソートファイル
           COPY    "CPCOMMONDAT2.INC"
                                           REPLACING   //RECE01//
                                           BY          //ORCBG012SRT//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"      REPLACING  //RECE01PARA//
                                           BY         //RECEERR//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    印刷用領域
           COPY    "HCM42.INC".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-RECEERR                         PIC X(02).
           03  STS-BG012SRTCL                      PIC X(02).
           03  STS-BG012SRT                        PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-SYUNOU                          PIC 9(01).
           03  FLG-BG012SRT                        PIC 9(01).
           03  FLG-PTNUM                           PIC 9(01).
           03  FLG-PTINF                           PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-HIZUKE-ERR                      PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PAGE                            PIC 9(05).
           03  CNT-LINE                            PIC 9(05).
           03  CNT-SEQ                             PIC 9(08).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                      PIC 9(07).
           03  WRK-PARA-SHELLID                    PIC X(08).
           03  WRK-PARA-HOSPID                     PIC X(24).
           03  WRK-PARA-KKNKBN                     PIC X(01).
           03  WRK-PARA-KKNSTYM                    PIC X(06).
           03  WRK-PARA-KKNEDYM                    PIC X(06).
           03  WRK-PARA-SRTKBN                     PIC X(01).
           03  WRK-PARA-KAKBN                      PIC X(01).
           03  WRK-PARA-NYUGAIKBN                  PIC X(01).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR                         PIC X(200).
           03  WRK-SYMD                            PIC X(08).
           03  WRK-EDTYMD1                         PIC X(10).
           03  WRK-EDTYMD3                         PIC X(22).
           03  WRK-TITLE                           PIC X(100).
           03  WRK-PTID                            PIC 9(10).
           03  WRK-SRYKALST-G.
               05  WRK-SRYKALST-MAX                PIC 9(05).
               05  WRK-SRYKALST-OCC                OCCURS 50.
                   07  WRK-SRYKAL                  PIC X(02).
                   07  WRK-SRYKAL-STYUKYMD         PIC X(08).
                   07  WRK-SRYKAL-EDYUKYMD         PIC X(08).
                   07  WRK-SRYKAMEIL               PIC X(80).
                   07  WRK-SRYKAMEIL1              PIC X(20).
           03  WRK-KKN-HEN.
               05  WRK-KKNSTYMD                    PIC X(16).
               05  WRK-KKNMID                      PIC X(02).
               05  WRK-KKNEDYMD                    PIC X(16).
           03  WRK-ZZ9                             PIC ZZ9.
           03  WRK-CHOSEI-G.
               05  WRK-CHOSEI                      PIC ---,---,--9.
               05  WRK-CHOSEIKNS                   PIC ZZ,ZZ9.
               05  WRK-CHOSEI-SGK                  PIC S9(11).
               05  WRK-KACHOSEIKNS                 PIC  9(05).
               05  WRK-KACHOSEIP                   PIC S9(11).
               05  WRK-KACHOSEIM                   PIC S9(11).
               05  WRK-TTLCHOSEIKNS                PIC  9(05).
               05  WRK-TTLCHOSEIP                  PIC S9(11).
               05  WRK-TTLCHOSEIM                  PIC S9(11).
           03  WRK-DENPNUM-G.
               05  WRK-DENPNUM                     PIC 9(07).
           03  WRK-SRYYMDM-G.
               05  WRK-SRYYMDM-ST                  PIC X(09).
               05  WRK-SRYYMDM-MID                 PIC X(01).
               05  WRK-SRYYMDM-ED                  PIC X(05).
           03  WRK-SRT-SRYKA                       PIC X(02).
           03  WRK-SRT-SRYYMD                      PIC X(08).
           03  WRK-SPRT-SRYYM                      PIC X(06).
           03  WRK-KKNYM                           PIC X(100).
      *
       01  HEAD-AREA.
           03  HEAD-NYUGAI                         PIC X(10).
           03  HEAD-KKNYM                          PIC X(34).
           03  HEAD-SAKYMD                         PIC X(22).
           03  HEAD-SRTKBN                         PIC X(20).
      *
       01  ERR-EDIT-AREA.
           03  ERR-PTID                            PIC 9(10).
           03  ERR-PTNUM                           PIC X(20).
           03  ERR-ERRMSG                          PIC X(80).
           03  ERR-HEN-ERRMSG                      PIC X(80).
      *
       01  KEY-AREA.
           03  KEY-SRYKA                           PIC X(02).
      *
       01  CONST-AREA.
           03  CONST-LINE-MAX              PIC 9(05)   VALUE 30.
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
      *    診療科情報
           COPY    "CPSK1005.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
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
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
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
           INITIALIZE                  HEAD-AREA
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
                                       WRK-PARA-KKNKBN
                                       WRK-PARA-KKNSTYM
                                       WRK-PARA-KKNEDYM
                                       WRK-PARA-SRTKBN
                                       WRK-PARA-KAKBN
                                       WRK-PARA-NYUGAIKBN
      *
           MOVE    SPACE               TO  WRK-TITLE
      *
           IF    ( WRK-PARA-NYUGAIKBN  =   "1" )
               MOVE    "調整金一覧表−入院"
                                       TO  WRK-TITLE
           ELSE
               MOVE    "2"             TO  WRK-PARA-NYUGAIKBN
               MOVE    "調整金一覧表−外来"
                                       TO  WRK-TITLE
           END-IF
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBG012"          TO  JOB-PGID
           MOVE    WRK-TITLE           TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "BG012SR"           TO  ORCBG012SRTPARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  ORCBG012SRTPARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
           MOVE    ZERO                TO  FLG-END
      *
      *    パラメータチェック処理
           PERFORM 1001-PARA-CHK-SEC
           IF    ( FLG-END         NOT =   ZERO )
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    診療科ワーク編集処理
           PERFORM 1001-SRYKALST-HEN-SEC
      *
      *    ヘッダー編集処理
           PERFORM 1001-HEADER-HEN-SEC
      *
      *    調整金情報ソートファイル編集処理
           PERFORM 1001-BG012SRT-HEN-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    パラメータチェック処理
      *****************************************************************
       1001-PARA-CHK-SEC               SECTION.
      *
      *    期間指定区分チェック
           PERFORM 1001-KKNKBN-CHK-SEC
           IF    ( FLG-END         NOT =   ZERO )
               GO  TO  1001-PARA-CHK-EXT
           END-IF
      *
      *    期間指定区分＝１のとき
           IF    ( WRK-PARA-KKNKBN     =   "1" )
      *
      *        期間開始年月チェック
               PERFORM 1001-KKNSTYM-CHK-SEC
               IF    ( FLG-END         NOT =   ZERO )
                   GO  TO  1001-PARA-CHK-EXT
               END-IF
      *
      *        期間終了年月チェック
               IF    ( WRK-PARA-KKNEDYM    NOT =   SPACE )
                   PERFORM 1001-KKNEDYM-CHK-SEC
                   IF    ( FLG-END         NOT =   ZERO )
                       GO  TO  1001-PARA-CHK-EXT
                   END-IF
               END-IF
           END-IF
      *
           .
       1001-PARA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    期間指定区分チェック
      *****************************************************************
       1001-KKNKBN-CHK-SEC             SECTION.
      *
      *    期間指定区分＝０，１であること
           IF    ( WRK-PARA-KKNKBN     =   "0" OR  "1" )
               CONTINUE
           ELSE
               MOVE    SPACE           TO  WRK-RECEERR
               STRING  "期間指定区分が誤りです［"
                                                   DELIMITED   BY  SIZE
                       WRK-PARA-KKNKBN             DELIMITED   BY  SIZE
                       "］"                        DELIMITED   BY  SIZE
               INTO    WRK-RECEERR
               END-STRING
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  1001-KKNKBN-CHK-EXT
           END-IF
      *
           .
       1001-KKNKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    期間開始年月チェック
      *****************************************************************
       1001-KKNSTYM-CHK-SEC            SECTION.
      *
      *    開始年月が設定されていること
           IF    ( WRK-PARA-KKNSTYM    NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "開始年月が未設定です"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  1001-KKNSTYM-CHK-EXT
           END-IF
      *
      *    開始年月が"000000"か日付として妥当であること
           IF    ( WRK-PARA-KKNSTYM    =   "000000" )
               CONTINUE
           ELSE
               MOVE    WRK-PARA-KKNSTYM    TO  WRK-SYMD
               MOVE    "01"            TO  WRK-SYMD (7:2)
               PERFORM 800-SEIWA-HEN-SEC
               IF    ( FLG-HIZUKE-ERR  =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    SPACE           TO  WRK-RECEERR
                   STRING  "開始年月が誤りです［"
                                               DELIMITED   BY  SIZE
                       WRK-PARA-KKNSTYM        DELIMITED   BY  SIZE
                       "］"                    DELIMITED   BY  SIZE
                   INTO    WRK-RECEERR
                   END-STRING
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  1001-KKNSTYM-CHK-EXT
               END-IF
           END-IF
      *
           .
       1001-KKNSTYM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    期間終了年月チェック
      *****************************************************************
       1001-KKNEDYM-CHK-SEC            SECTION.
      *
      *    終了年月が"999999"か日付として妥当であること
           IF    ( WRK-PARA-KKNEDYM    =   "999999" )
               CONTINUE
           ELSE
               MOVE    WRK-PARA-KKNEDYM    TO  WRK-SYMD
               MOVE    "01"            TO  WRK-SYMD (7:2)
               PERFORM 800-SEIWA-HEN-SEC
               IF    ( FLG-HIZUKE-ERR  =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    SPACE           TO  WRK-RECEERR
                   STRING  "終了年月が誤りです［"
                                               DELIMITED   BY  SIZE
                       WRK-PARA-KKNEDYM        DELIMITED   BY  SIZE
                       "］"                    DELIMITED   BY  SIZE
                   INTO    WRK-RECEERR
                   END-STRING
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  1001-KKNEDYM-CHK-EXT
               END-IF
           END-IF
      *
      *    開始年月≦終了年月であること
           IF    ( WRK-PARA-KKNSTYM   <=   WRK-PARA-KKNEDYM )
               CONTINUE
           ELSE
               MOVE    "開始年月＞終了年月となっています"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  1001-KKNEDYM-CHK-EXT
           END-IF
      *
           .
       1001-KKNEDYM-CHK-EXT.
           EXIT.
      *************************************************************
      *    診療科ワーク編集処理
      *************************************************************
       1001-SRYKALST-HEN-SEC           SECTION.
      *
           INITIALIZE  WRK-SRYKALST-G
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           INITIALIZE  SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-SYSKANRI-KEY5  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYS-1005-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                    OR   ( WRK-SRYKALST-MAX   >=   50   )
      *
               COMPUTE WRK-SRYKALST-MAX
                   =   WRK-SRYKALST-MAX    +   1
      *
               MOVE    WRK-SRYKALST-MAX    TO  IDX1
      *
               MOVE    SYS-1005-KBNCD      TO  WRK-SRYKAL    (IDX1)
               MOVE    SYS-1005-STYUKYMD   TO  WRK-SRYKAL-STYUKYMD
                                                             (IDX1)
               MOVE    SYS-1005-EDYUKYMD   TO  WRK-SRYKAL-EDYUKYMD
                                                             (IDX1)
               MOVE    SYS-1005-SRYKANAME  TO  WRK-SRYKAMEIL (IDX1)
               MOVE    SYS-1005-SRYKANAME1 TO  WRK-SRYKAMEIL1(IDX1)
      *
               MOVE    PATH-TBL-SYSKANRI-KEY5  TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC              =   ZERO )
                   MOVE    MCPDATA-REC     TO  SYS-1005-REC
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
                   INITIALIZE                  SYS-1005-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-SYSKANRI-KEY5  TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       1001-SRYKALST-HEN-EXT.
           EXIT.
      *************************************************************
      *    ヘッダー編集処理
      *************************************************************
       1001-HEADER-HEN-SEC             SECTION.
      *
           MOVE    "000000"            TO  WRK-SPRT-SRYYM
      *
      *    タイトル
           IF    ( WRK-PARA-NYUGAIKBN  =   "1" )
               MOVE    "入院"          TO  HEAD-NYUGAI
           ELSE
               MOVE    "外来"          TO  HEAD-NYUGAI
           END-IF
      *
      *    ソート区分
           EVALUATE    WRK-PARA-SRTKBN
           WHEN    "1"
               MOVE    "診療年月日順"  TO  HEAD-SRTKBN
           WHEN    "2"
               MOVE    "伝票番号順"    TO  HEAD-SRTKBN
           WHEN    "3"
               MOVE    "カナ氏名順"    TO  HEAD-SRTKBN
           WHEN    OTHER
               MOVE    "患者番号順"    TO  HEAD-SRTKBN
           END-EVALUATE
      *
      *    作成日
           MOVE    LNK-PRTKANRI-SKYYMD TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  HEAD-SAKYMD
      *
           IF    ( WRK-PARA-KKNKBN     =   "1" )
      *
               IF    ( WRK-PARA-KKNSTYM    =   "000000" )
                AND  ( WRK-PARA-KKNEDYM    =   "999999" )
                   MOVE    "指定なし"              TO  HEAD-KKNYM
               ELSE
      *            期間
                   INITIALIZE  WRK-KKN-HEN
      *
                   IF    ( WRK-PARA-KKNSTYM    NOT =   "000000" )
                       MOVE    WRK-PARA-KKNSTYM    TO  WRK-SYMD
                       MOVE    "01"                TO  WRK-SYMD(7:2)
                       PERFORM 800-SEIWA-HEN-SEC
                       MOVE    WRK-EDTYMD3 (1:16)  TO  WRK-KKNSTYMD
                       MOVE    WRK-PARA-KKNSTYM    TO  WRK-SPRT-SRYYM
                   END-IF
      *
      *
                   IF    ( WRK-PARA-KKNEDYM    NOT =   SPACE )
                       MOVE    "〜"                    TO  WRK-KKNMID
                   END-IF
      *
                   IF    ( WRK-PARA-KKNEDYM        =   SPACE
                                                   OR  "999999" )
                       MOVE    SPACE               TO  WRK-KKNEDYMD
                   ELSE
                       MOVE    WRK-PARA-KKNEDYM    TO  WRK-SYMD
                       MOVE    "01"                TO  WRK-SYMD(7:2)
                       PERFORM 800-SEIWA-HEN-SEC
                       MOVE    WRK-EDTYMD3 (1:16)  TO  WRK-KKNEDYMD
                   END-IF
      *
                   IF    ( WRK-KKNSTYMD        =   WRK-KKNEDYMD )
                       MOVE    WRK-KKNSTYMD        TO  HEAD-KKNYM
                   ELSE
                       MOVE    WRK-KKN-HEN         TO  HEAD-KKNYM
                   END-IF
               END-IF
      *
           ELSE
               MOVE    "指定なし"                  TO  HEAD-KKNYM
           END-IF
      *
           .
       1001-HEADER-HEN-EXT.
           EXIT.
      *****************************************************************
      *    調整金情報ソートファイル編集処理
      *****************************************************************
       1001-BG012SRT-HEN-SEC           SECTION.
      *
           MOVE    ZERO                TO  CNT-SEQ
      *
      *    調整金情報ソートファイル初期化
           OPEN    OUTPUT                  BG012SRTCL-FILE
           CLOSE   BG012SRTCL-FILE
      *
           OPEN    OUTPUT                  BG012SRT-FILE
      *
           PERFORM 900-SYUNOU-KEY34-SEL-SEC
      *
           PERFORM UNTIL ( FLG-SYUNOU  NOT =   ZERO )
      *
               COMPUTE CNT-SEQ =   CNT-SEQ     +   1
      *
               MOVE    SYU-PTID        TO  WRK-PTID
               PERFORM 900-PTINF-KEY-SEL-SEC
      *
               MOVE    SYU-PTID        TO  WRK-PTID
               PERFORM 900-PTNUM-KEY-SEL-SEC
      *
               IF    ( WRK-PARA-KAKBN  =   "1" )
                   MOVE    SYU-SRYKA       TO  WRK-SRT-SRYKA
               ELSE
                   MOVE    "00"            TO  WRK-SRT-SRYKA
               END-IF
      *
               IF    ( SYU-NYUGAIKBN   =   "1" )
                   MOVE    SYU-SKYEDYMD    TO  WRK-SRT-SRYYMD
               ELSE
                   MOVE    SYU-SRYYMD      TO  WRK-SRT-SRYYMD
               END-IF
      *
               EVALUATE    WRK-PARA-SRTKBN
      *        診療年月日
               WHEN    "1"
                   INITIALIZE                  BG012SRT02-REC
                   MOVE    WRK-SRT-SRYKA   TO  BG012SRT02-KEY-SRYKA
                   MOVE    WRK-SRT-SRYYMD  TO  BG012SRT02-KEY-SRYYMD
                   MOVE    PTNUM-PTNUM     TO  BG012SRT02-KEY-PTNUM
                   MOVE    SYU-DENPNUM     TO  BG012SRT02-KEY-DENPNUM
                   MOVE    CNT-SEQ         TO  BG012SRT02-KEY-SEQ
                   MOVE    PTINF-NAME      TO  BG012SRT02-NAME
                   MOVE    PTNUM-PTNUM     TO  BG012SRT02-PTNUM
                   MOVE    SYUNOU-REC      TO  BG012SRT02-DAT
                   WRITE   BG012SRT02-REC
      *
      *        伝票番号順
               WHEN    "2"
                   INITIALIZE                  BG012SRT03-REC
                   MOVE    WRK-SRT-SRYKA   TO  BG012SRT03-KEY-SRYKA
                   MOVE    SYU-DENPNUM     TO  BG012SRT03-KEY-DENPNUM
                   MOVE    CNT-SEQ         TO  BG012SRT03-KEY-SEQ
                   MOVE    PTINF-NAME      TO  BG012SRT03-NAME
                   MOVE    PTNUM-PTNUM     TO  BG012SRT03-PTNUM
                   MOVE    SYUNOU-REC      TO  BG012SRT03-DAT
                   WRITE   BG012SRT03-REC
      *
      *        カナ氏名順
               WHEN    "3"
                   INITIALIZE                  BG012SRT04-REC
                   MOVE    WRK-SRT-SRYKA   TO  BG012SRT04-KEY-SRYKA
                   MOVE    PTINF-KANANAME  TO  BG012SRT04-KEY-KANANAME
                   MOVE    PTNUM-PTNUM     TO  BG012SRT04-KEY-PTNUM
                   MOVE    WRK-SRT-SRYYMD  TO  BG012SRT04-KEY-SRYYMD
                   MOVE    SYU-DENPNUM     TO  BG012SRT04-KEY-DENPNUM
                   MOVE    CNT-SEQ         TO  BG012SRT04-KEY-SEQ
                   MOVE    PTINF-NAME      TO  BG012SRT04-NAME
                   MOVE    PTNUM-PTNUM     TO  BG012SRT04-PTNUM
                   MOVE    SYUNOU-REC      TO  BG012SRT04-DAT
                   WRITE   BG012SRT04-REC
      *
      *        患者番号順
               WHEN    OTHER
                   INITIALIZE                  BG012SRT01-REC
                   MOVE    WRK-SRT-SRYKA   TO  BG012SRT01-KEY-SRYKA
                   MOVE    PTNUM-PTNUM     TO  BG012SRT01-KEY-PTNUM
                   MOVE    WRK-SRT-SRYYMD  TO  BG012SRT01-KEY-SRYYMD
                   MOVE    SYU-DENPNUM     TO  BG012SRT01-KEY-DENPNUM
                   MOVE    CNT-SEQ         TO  BG012SRT01-KEY-SEQ
                   MOVE    PTINF-NAME      TO  BG012SRT01-NAME
                   MOVE    PTNUM-PTNUM     TO  BG012SRT01-PTNUM
                   MOVE    SYUNOU-REC      TO  BG012SRT01-DAT
                   WRITE   BG012SRT01-REC
      *
               END-EVALUATE
      *
               PERFORM 900-SYUNOU-KEY34-FET-SEC
      *
           END-PERFORM
      *
      *
           MOVE    PATH-TBL-SYUNOU-KEY34   TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           CLOSE   BG012SRT-FILE
      *
           .
       1001-BG012SRT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    ZERO            TO  CNT-PAGE
           MOVE    ZERO            TO  CNT-LINE
           INITIALIZE                  WRK-CHOSEI-G
           MOVE    ZERO            TO  FLG-BG012SRT
      *
           OPEN    INPUT               BG012SRT-FILE
      *
           PERFORM 900-BG012SRT-READ-SEC
      *
           PERFORM UNTIL ( FLG-BG012SRT    NOT =  ZERO )
                     OR  ( FLG-END         NOT =  ZERO )
      *
               PERFORM 210-HEAD-SEC
      *
               PERFORM UNTIL ( CNT-LINE         >=  CONST-LINE-MAX )
                         OR  ( KEY-SRYKA     NOT =  BG012SRT-KEY-SRYKA )
                         OR  ( FLG-BG012SRT  NOT =  ZERO )
                         OR  ( FLG-END       NOT =  ZERO )
      *
                   PERFORM 220-MEISAI-SEC
      *
               END-PERFORM
      *
               PERFORM 230-TOTAL-SEC
      *
               PERFORM 240-PRINT-SEC
      *
           END-PERFORM
      *
           CLOSE   BG012SRT-FILE
      *
           MOVE    1                   TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ヘッダ編集処理
      *****************************************************************
       210-HEAD-SEC                    SECTION.
      *
           MOVE    BG012SRT-KEY-SRYKA
                                   TO  KEY-SRYKA
      *
           MOVE    ZERO            TO  CNT-LINE
      *
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   1
      *
           INITIALIZE                  HCM42
           MOVE    HEAD-NYUGAI     TO  HCM42-NYUGAI
           MOVE    HEAD-SRTKBN     TO  HCM42-SRTKBN
           MOVE    HEAD-KKNYM      TO  HCM42-KKNYM
           MOVE    HEAD-SAKYMD     TO  HCM42-SAKYMD
           MOVE    CNT-PAGE        TO  WRK-ZZ9
           MOVE    WRK-ZZ9         TO  HCM42-PAGE
      *
      *
           IF    ( WRK-PARA-KAKBN  =   "1" )
      *
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   WRK-SRYKALST-MAX )
      *
                   IF    ( BG012SRT-SYU-SRYKA
                                   =   WRK-SRYKAL (IDX1) )
                    AND  ( BG012SRT-SYU-SRYYMD
                                  >=  WRK-SRYKAL-STYUKYMD (IDX1))
                    AND  ( BG012SRT-SYU-SRYYMD
                                  <=  WRK-SRYKAL-EDYUKYMD (IDX1))
      *
                       MOVE    SPACE       TO  WRK-KKNYM
                       STRING  HCM42-KKNYM     DELIMITED   BY  SPACE
                               "　"            DELIMITED   BY  SIZE
                               WRK-SRYKAMEIL (IDX1)
                                               DELIMITED   BY  SPACE
                       INTO    WRK-KKNYM
                       END-STRING
      *
                       MOVE    WRK-KKNYM   TO  HCM42-KKNYM
                       MOVE    WRK-SRYKALST-MAX
                                           TO  IDX1
      *
                   END-IF
      *
               END-PERFORM
           END-IF
      *
           .
       210-HEAD-EXT.
           EXIT.
      *****************************************************************
      *    明細編集処理
      *****************************************************************
       220-MEISAI-SEC                  SECTION.
      *
           MOVE    BG012SRT-DAT    TO  SYUNOU-REC
      *
           COMPUTE CNT-LINE    =   CNT-LINE    +   1
      *
           MOVE    BG012SRT-PTNUM  TO  HCM42-PTNUM (CNT-LINE)
           MOVE    BG012SRT-NAME   TO  HCM42-NAME  (CNT-LINE)
      *
           MOVE    SYU-DENPNUM     TO  WRK-DENPNUM
           MOVE    WRK-DENPNUM-G   TO  HCM42-DENPNUM (CNT-LINE)
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   WRK-SRYKALST-MAX )
                    OR   ( HCM42-SRYKA (CNT-LINE)  NOT =   SPACE )
      *
               IF    ( SYU-SRYKA   =   WRK-SRYKAL (IDX1) )
                AND  ( SYU-SRYYMD  >=  WRK-SRYKAL-STYUKYMD (IDX1))
                AND  ( SYU-SRYYMD  <=  WRK-SRYKAL-EDYUKYMD (IDX1))
                   MOVE    WRK-SRYKAMEIL1(IDX1)
                                   TO  HCM42-SRYKA (CNT-LINE)
               END-IF
      *
           END-PERFORM
      *
           IF    ( WRK-PARA-NYUGAIKBN  =   "1" )
               INITIALIZE                  WRK-SRYYMDM-G
               MOVE    SYU-SKYSTYMD    TO  WRK-SYMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-EDTYMD1     TO  WRK-SRYYMDM-ST
               MOVE    "-"             TO  WRK-SRYYMDM-MID
               MOVE    SYU-SKYEDYMD    TO  WRK-SYMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-EDTYMD1(5:) TO  WRK-SRYYMDM-ED
      *
               MOVE    WRK-SRYYMDM-G   TO  HCM42-SKYKKN  (CNT-LINE)
      *
           ELSE
               MOVE    SYU-SRYYMD      TO  WRK-SYMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-EDTYMD1     TO  HCM42-SRYMD   (CNT-LINE)
           END-IF
      *
           IF    ( SYU-CHOSEI          >=  ZERO )
               MOVE    SYU-CHOSEI      TO  WRK-CHOSEI
               MOVE    WRK-CHOSEI      TO  HCM42-CHOSEIP (CNT-LINE)
               COMPUTE WRK-KACHOSEIP
                   =   WRK-KACHOSEIP  +   SYU-CHOSEI
               COMPUTE WRK-TTLCHOSEIP
                   =   WRK-TTLCHOSEIP +   SYU-CHOSEI
           ELSE
               MOVE    SYU-CHOSEI      TO  WRK-CHOSEI
               MOVE    WRK-CHOSEI      TO  HCM42-CHOSEIM (CNT-LINE)
               COMPUTE WRK-KACHOSEIM
                   =   WRK-KACHOSEIM  +   SYU-CHOSEI
               COMPUTE WRK-TTLCHOSEIM
                   =   WRK-TTLCHOSEIM +   SYU-CHOSEI
           END-IF
      *
           COMPUTE WRK-KACHOSEIKNS    =   WRK-KACHOSEIKNS  +   1
           COMPUTE WRK-TTLCHOSEIKNS   =   WRK-TTLCHOSEIKNS +   1
      *
           PERFORM 900-BG012SRT-READ-SEC
      *
           .
       220-MEISAI-EXT.
           EXIT.
      *****************************************************************
      *    合計行編集処理
      *****************************************************************
       230-TOTAL-SEC                   SECTION.
      *
           IF    ( WRK-PARA-KAKBN      =   "1" )
               IF    ( KEY-SRYKA       NOT =  BG012SRT-KEY-SRYKA )
                 OR  ( FLG-BG012SRT    NOT =  ZERO )
                 OR  ( FLG-END         NOT =  ZERO )
      *
                   MOVE    "科合計"        TO  HCM42-LBLPAG
      *
                   MOVE    WRK-KACHOSEIKNS TO  WRK-CHOSEIKNS
                   MOVE    WRK-CHOSEIKNS   TO  HCM42-KACHOSEIKNS
      *
                   MOVE    WRK-KACHOSEIP   TO  WRK-CHOSEI
                   MOVE    WRK-CHOSEI      TO  HCM42-KACHOSEIP
      *
                   MOVE    WRK-KACHOSEIM   TO  WRK-CHOSEI
                   MOVE    WRK-CHOSEI      TO  HCM42-KACHOSEIM
      *
                   COMPUTE WRK-CHOSEI-SGK
                       =   WRK-KACHOSEIP   +   WRK-KACHOSEIM
      *
                   MOVE    WRK-CHOSEI-SGK  TO  WRK-CHOSEI
                   MOVE    WRK-CHOSEI      TO  HCM42-KACHOSEI
      *
                   MOVE    ZERO            TO  WRK-KACHOSEIKNS
                   MOVE    ZERO            TO  WRK-KACHOSEIP
                   MOVE    ZERO            TO  WRK-KACHOSEIM
      *
               END-IF
           END-IF
      *
           IF    ( FLG-BG012SRT    NOT =   ZERO )
      *
               MOVE    "総合計"            TO  HCM42-LBLTTL
      *
               MOVE    WRK-TTLCHOSEIKNS    TO  WRK-CHOSEIKNS
               MOVE    WRK-CHOSEIKNS       TO  HCM42-TTLCHOSEIKNS
      *
               MOVE    WRK-TTLCHOSEIP      TO  WRK-CHOSEI
               MOVE    WRK-CHOSEI          TO  HCM42-TTLCHOSEIP
      *
               MOVE    WRK-TTLCHOSEIM      TO  WRK-CHOSEI
               MOVE    WRK-CHOSEI          TO  HCM42-TTLCHOSEIM
      *
               COMPUTE WRK-CHOSEI-SGK
                   =   WRK-TTLCHOSEIP      +   WRK-TTLCHOSEIM
      *
               MOVE    WRK-CHOSEI-SGK      TO  WRK-CHOSEI
               MOVE    WRK-CHOSEI          TO  HCM42-TTLCHOSEI
           END-IF
      *
           .
       230-TOTAL-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       240-PRINT-SEC                   SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           MOVE    WRK-SPRT-SRYYM      TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID 
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
           MOVE   "HCM42.red"          TO  SPRT-PRTID
           MOVE    WRK-TITLE           TO  SPRT-TITLE
           MOVE    HCM42               TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF    ( SPRT-RETURN         =   ZERO )
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       240-PRINT-EXT.
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
           PERFORM 800-BG012SRT-DEL-SEC
      *
           IF    ( CNT-PAGE        =   ZERO )
               MOVE    "処理対象のデータがありませんでした"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           DISPLAY "*** ORCBG012 IN " CNT-PAGE  " ***"
           DISPLAY "*** ORCBG012 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
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
      *    調整金情報ソートファイル削除処理
      *****************************************************************
       800-BG012SRT-DEL-SEC            SECTION.
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    ORCBG012SRTPARA TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
           .
       800-BG012SRT-DEL-EXT.
           EXIT.
      *****************************************************************
      *    調整金情報ソートファイル読込処理
      *****************************************************************
       900-BG012SRT-READ-SEC          SECTION.
      *
           READ    BG012SRT-FILE       NEXT
           AT  END
               MOVE    1               TO  FLG-BG012SRT
           END-READ
      *
           .
       900-BG012SRT-READ-EXT.
           EXIT.
      *****************************************************************
      *    収納情報検索処理(KEY34)
      *****************************************************************
       900-SYUNOU-KEY34-SEL-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUNOU
      *
           INITIALIZE                      SYUNOU-REC
           MOVE    WRK-PARA-HOSPID     TO  SYU-HOSPID
           MOVE    WRK-PARA-NYUGAIKBN  TO  SYU-NYUGAIKBN
           IF    ( WRK-PARA-KKNKBN =   "0" )
               MOVE    "00000000"      TO  SYU-SKYSTYMD
               MOVE    "99999999"      TO  SYU-SKYEDYMD
           ELSE
               IF    ( WRK-PARA-KKNSTYM    =   "000000" )
                   MOVE    "00000000"  TO  SYU-SKYSTYMD
               ELSE
                   MOVE    WRK-PARA-KKNSTYM
                                       TO  SYU-SKYSTYMD
                   MOVE    "01"        TO  SYU-SKYSTYMD(7:2)
               END-IF
      *
               IF    ( WRK-PARA-KKNEDYM    =   SPACE )
                       MOVE    SYU-SKYSTYMD
                                       TO  SYU-SKYEDYMD
                       MOVE    "31"    TO  SYU-SKYEDYMD (7:2)
               ELSE
                   IF    ( WRK-PARA-KKNEDYM    =   "999999" )
                       MOVE    "99999999"
                                       TO  SYU-SKYEDYMD
                   ELSE
                       MOVE    WRK-PARA-KKNEDYM
                                       TO  SYU-SKYEDYMD
                       MOVE    "31"    TO  SYU-SKYEDYMD (7:2)
                   END-IF
               END-IF
      *
           END-IF
      *
           MOVE    SYUNOU-REC              TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUNOU-KEY34   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYUNOU-REC
           ELSE
               MOVE    1           TO  FLG-SYUNOU
               INITIALIZE              SYUNOU-REC
           END-IF
      *
           .
       900-SYUNOU-KEY34-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納情報ＦＥＴＣＨ処理(KEY34)
      *****************************************************************
       900-SYUNOU-KEY34-FET-SEC        SECTION.
      *
           MOVE    PATH-TBL-SYUNOU-KEY34   TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
               INITIALIZE                  SYUNOU-REC
           END-IF
      *
           .
       900-SYUNOU-KEY34-FET-EXT.
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
