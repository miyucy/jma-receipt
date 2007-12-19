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
       PROGRAM-ID.             ORCR1210.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  コンポーネント名  : 公害レセプト（入院）
      *                      診療実日数編集
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/11/16    NACL−藤原    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
           SELECT  RECE200-FILE    ASSIGN  RECE200PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE200-KEY
                                   FILE    STATUS  IS  STS-RECE200.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
       FD  RECE200-FILE.
       01  RECE200-REC. 
           COPY    "CPRCF200.INC".
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPRECEDAT1.INC"
                                   REPLACING  //RECEDAT1//
                                   BY         //RECE200//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPERRFL.INC"
                                   REPLACING  //ERRFLPARA//
                                   BY         //RECEERR//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE200                             PIC X(02).
           03  STS-RECEERR                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-SHOSAISIN                           PIC 9(01).
           03  FLG-SHOSAISIN-GEN                       PIC 9(01).
           03  FLG-NYUINACCT                           PIC 9(01).
           03  FLG-NYUINACT                            PIC 9(01).
           03  FLG-SRYACCT                             PIC 9(01).
           03  FLG-SRYACT                              PIC 9(01).
           03  FLG-RECE200                              PIC 9(01).
           03  FLG-NYUKHN                              PIC 9(01).
           03  FLG-TENSU                               PIC 9(01).
           03  FLG-ARI                                 PIC 9(01).
           03  FLG-SYSKANRI                            PIC 9(01).
           03  FLG-NYURYAKUSHO                         PIC 9(01).
           03  FLG-GAIHAKU                             PIC 9(01).
           03  FLG-MIJISI-GENSAN                       PIC 9(01).       
           03  FLG-MIJISI-INNAI                        PIC 9(01).       
           03  FLG-MIJISI-IRYO                         PIC 9(01).       
           03  FLG-MIJISI-JYOKU                        PIC 9(01).       
           03  FLG-SENTEICDCHG                         PIC 9(01).
           03  FLG-SET                                 PIC 9(01).
           03  FLG-FUKUSHI                             PIC 9(01).
           03  FLG-NYURYAKUWRK                         PIC 9(01).
           03  FLG-NISSUSET                            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                              PIC 9(06).
           03  CNT-MOD                             PIC 9(06).
           03  CNT-IN-CANCEL                       PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                                     PIC 9(03).
           03  IDY                                     PIC 9(03).
           03  IDZ                                     PIC 9(03).
           03  IDX1                                    PIC 9(03).
           03  IDX2                                    PIC 9(03).
           03  IDX3                                    PIC 9(02).
           03  KH-IDX                                  PIC 9(03).
           03  NYUINACT-IDX                            PIC 9(03).
           03  NYUINACT-IDX2                           PIC 9(03).
           03  ACCT-IDX                                PIC 9(03).
           03  SRYACT-IDX                              PIC 9(03).
           03  ID1                                     PIC 9(03).
           03  GENSAN-IDX                              PIC 9(03).
           03  GENSAN-IDX2                             PIC 9(03).
           03  IDV                                     PIC 9(02).
           03  TENTEK-IDX                              PIC 9(03).
           03  SYSKAN-IDX                              PIC 9(03).
      *
      *    実日数カウント用領域
       01  TBL-JNISSU.
           03  TBL-JNISSU-HKN       OCCURS   5.
               05  TBL-JNISSU-DAY                      PIC X(01)
                                                       OCCURS   31.
      *
      *    実日数減カウント用領域
       01  TBL-JNISSU-GEN.
           03  TBL-JNISSU-HKN-GEN   OCCURS   5.
               05  TBL-JNISSU-DAY-GEN                  PIC X(01)
                                                       OCCURS   31.
      *
      *    未実施減算退避用フラグテーブル
       01  TBL-GENSAN.
           03  TBL-GENSAN-INF       OCCURS  31.
               05  TBL-INNAI                           PIC X(01).
               05  TBL-IRYO                            PIC X(01).
               05  TBL-JYOKU                           PIC X(01).
      *
      *    未実施減算退避用点数テーブル
       01  TBL-GENSAN2.
           03  TBL-GENSAN2-INF      OCCURS  31.
               05  TBL-MIJISI-TENSU                    PIC 9(09).
      *
      *    医療機関（入院基本）カウント
       01  WRK-SYS5000-COUNT                           PIC 9(02).
      *
      *    合計点数（診療行為）集計用領域
       01  TBL-TOTALTEN.
           03  TBL-TOTALTEN-HKN     OCCURS   5.
               05  TBL-TOTALTEN-ACCT                   PIC S9(08).
      *    合計点数（診療行為）集計用領域
      *    （ぶん点・公費分離区分編集用）
       01  TBL-TOTALTEN2.
           03  TBL-TOTALTEN2-HKN    OCCURS   5.
               05  TBL-TOTALTEN2-ACCT                  PIC S9(08).
      *
       01  WRK-DAY-TABLE.
           03  WRK-DAY-T                               OCCURS   31.
               05  WRK-DAY1                            PIC 9(04).
               05  WRK-DAY1-NYUTENTTLKBN               PIC 9(03).
               05  WRK-DAY1-SENTEI                     PIC 9(04).
               05  WRK-DAY2                            PIC 9(04).
               05  WRK-DAY4                            PIC 9(04).
               05  WRK-DAY41                           PIC 9(04).
               05  WRK-DAY5                            PIC 9(04).
               05  WRK-DAY6                            PIC 9(04).
               05  WRK-DAY6-ZAITEN                     PIC 9(08).
               05  WRK-DAY7                            PIC 9(04).
               05  WRK-DAY7-ZAITEN                     PIC 9(08).
               05  WRK-ACCT90                          PIC 9(08).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-IN                                  PIC X(01).
           03  WRK-PARA.
               05  WRK-PARA-SRYYM                      PIC X(06).
               05  WRK-PARA-TERMID                     PIC X(16).
               05  WRK-PARA-SYSYMD                     PIC X(08).
               05  WRK-PARA-JOBID                      PIC 9(07).
               05  WRK-PARA-SHELLID                    PIC X(08).
           03  WRK-PARA-HOSPNUM                        PIC 9(02).
           03  WRK-SYS-SRYYMD                          PIC X(08).
           03  WRK-SRYYM-5000                          PIC X(06).
      *
           03  WRK-PREFNUM                             PIC X(02).
      *
           03  WRK-HYOKETU-TEN                         PIC 9(09)V99.
      *
           03  WRK-NYUINF-TABLE.
               05  WRK-NYUINF-TBL                      OCCURS  10.
                   07  WRK-NYUKHNKEI                   PIC 9(09)
                                                           OCCURS 5.
                   07  WRK-NYUTOKKEI                   PIC 9(09)
                                                           OCCURS 5.
               05  WRK-NYUINF-TBL2                     OCCURS   5.
                   07  WRK-NYUKHNKEI2                  PIC S9(09).
                   07  WRK-NYUTOKKEI2                  PIC S9(09).
      *
      *    入院略称退避ワーク
           03  WRK-NYURYAKU-OCC                       OCCURS  200.
               05  WRK-NYURYAKU-SRYCD                 PIC X(09).
               05  WRK-NYURYAKU-YUKOSTYMD             PIC X(09).
               05  WRK-NYURYAKU-YUKOEDYMD             PIC X(09).
               05  WRK-NYURYAKU-DATA                  PIC X(400).
           03  WRK-NYUYAKU-CD                         PIC X(09).
           03  WRK-NYURYAKU-IDX                       PIC 9(03).
           03  WRK-NYURYAKU-MAX                       PIC 9(03).
      *
       01  WRK-TENTEK.
           03  WRK-TENTEK-SYUTEN                       PIC 9(07).
           03  WRK-TENTEK-ZAIKAISU                     PIC 9(04).
           03  WRK-TENTEK-TABLE.
               05  WRK-TENTEK-TBL                      OCCURS  10.
                   07  WRK-TENTEK-YKZTEN               PIC 9(07).
                   07  WRK-TENTEK-KIZAITEN             PIC 9(07).
           03  WRK-TENTEK-FLG-TABLE.
               05  WRK-TENTEK-FLG-TBL                  OCCURS  10.
                   07  WRK-TENTEK-FLG                  PIC 9(01)
                                                           OCCURS 5.
      *
       01  WRK-CONS-AREA.
      *    固定端末ＩＤ
           03  WRK-CONS-TERMID     PIC X(64)   VALUE
                                   "0100007FZZZZZZZZZZZZZZZZZZZZZZZZ". 
      *    入院略称読み込みワーク用
           03  WRK-NYURYAKU-CONST-MAX             PIC 9(03) VALUE 200.
      *
           03  WRK-RECEERR                             PIC X(200). 
      *
      *    入院点数算定用ワークエリア
       01  WRK-NYUIN-TENSU-AREA.
           03  WRK-KHNTEN                              PIC 9(08). 
           03  WRK-SENTEI-KHNTEN                       PIC 9(08).
           03  WRK-SENTEI-ZAITEN                       PIC 9(08).
           03  WRK-KSNTEN                              PIC S9(08).
           03  WRK-NYUTENTTLKBN                        PIC 9(03).
           03  WRK-NYUKHNRYO                           PIC 9(09).
           03  WRK-NYUTOKRYO                           PIC 9(09).
           03  WRK-SHOKUJIRYOYO-OCC.
               05  WRK-SHOKUJIRYOYO                    PIC 9(01)
                                                       OCCURS 31.
           03  WRK-TOKUKANRIKASAN-OCC.
               05  WRK-TOKUKANRIKASAN                  PIC 9(01)
                                                       OCCURS 31.
           03  WRK-SRYCD                               PIC X(09).
           03  WRK-RYAKUSHO                            PIC X(14).
           03  WRK-SRYYMD                              PIC X(08).       
           03  WRK-SRYYMD-TAIHI                        PIC X(08).   
           03  WRK-SENTEI-KEISU                        PIC 9V99.    
           03  WRK-GAIHAKU-SRYCD                       PIC X(09).
           03  WRK-GAIHAKU-KHNTEN                      PIC 9(08).
      *
      *
      *    医療機関（基本情報）退避用領域
       01  TBL-SYS1001-T.
           03  TBL-SYS1001-OCC     OCCURS  100.
               05  TBL-SYS1001                         PIC X(610).
      *
      *    医療機関（入院基本）退避用領域
       01  TBL-SYS5000-T.
           03  TBL-SYS5000-OCC     OCCURS  100.
               05  TBL-SYS5000                         PIC X(610).
      *
      *
           COPY    "MCPAREA".
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
           COPY    "CPSK1001.INC".
      *
           COPY    "CPSK5000.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    診療行為
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    点数
           COPY    "CPTENSU.INC".
      *
      *    入院略称
       01  NYURYAKUSHO-REC.
           COPY    "CPNYUINRYAKUSHO.INC".
      *
      *    選定入院料
       01  SENTEICDCHG-REC.
           COPY    "CPSENTEICDCHG.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    入院点滴一括更新サブ
           COPY    "CPORCSTENTEK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL   FLG-END =   1 
      *
           PERFORM 300-TERM-SEC
      *
           IF      WRK-PARA-SHELLID    NOT =   "RECEPTX"
               STOP    RUN
           ELSE
               EXIT    PROGRAM
           END-IF 
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
                                       SPA-AREA
      *
           MOVE    ZERO                TO  FLG-END
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO    WRK-PARA
                                               WRK-PARA-HOSPNUM
                                               RECEERR
           END-UNSTRING
           MOVE    WRK-PARA-HOSPNUM    TO  SPA-HOSPNUM
      *
           IF      WRK-PARA-SHELLID    NOT =   "RECEPTX"
      *        ＤＢオープン処理
               PERFORM 100-DBOPEN-SEC
      *
      *        ステップ管理開始処理
               MOVE    "STS"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    "ORCR1210"      TO  JOB-PGID
               MOVE    "診療実日数編集"
                                       TO  JOB-SHELLMSG
               PERFORM   900-CALL-ORCSJOB-SEC
      *        処理中止設定処理
               PERFORM 500-CANCEL-HENSYU-SEC
           END-IF
      *
      *    システム管理情報編集処理
           IF      FLG-END             =   ZERO
               PERFORM 1001-SYSKANRI-HENSYU-SEC
           END-IF
           .
       100-INIT-EXT.
           EXIT.
      *
      ******************************************************************
      *    システム管理情報編集処理
      ******************************************************************
       1001-SYSKANRI-HENSYU-SEC          SECTION.
      *
           IF   WRK-PARA-SRYYM    NOT =  ZERO
      *       医療機関情報
              INITIALIZE                      SYSKANRI-REC
              MOVE    "1001"              TO  SYS-KANRICD
              MOVE    "*"                 TO  SYS-KBNCD
              MOVE    WRK-PARA-SRYYM      TO  SYS-STYUKYMD (1:6)
              MOVE    "01"                TO  SYS-STYUKYMD (7:2)
              MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
              MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
              MOVE    SYSKANRI-REC        TO  MCPDATA-REC
              MOVE    "tbl_syskanri"      TO  MCP-TABLE
              MOVE    "key10"             TO  MCP-PATHNAME
              PERFORM   900-DBSELECT-SEC
              IF      MCP-RC              =   ZERO
                  MOVE    "tbl_syskanri"  TO  MCP-TABLE
                  MOVE    "key10"         TO  MCP-PATHNAME
                  PERFORM  900-SYSKANRI-READ-SEC
      *
                  IF      FLG-SYSKANRI     =   ZERO
                     MOVE   SYS-1001-PREFNUM  TO  WRK-PREFNUM
                  ELSE
                     MOVE  "医療機関情報が取得できませんでした。"
                                          TO  WRK-RECEERR
                     PERFORM 500-ERR-HENSYU-SEC
                  END-IF    
              ELSE
                  MOVE    "医療機関情報が取得できませんでした。"
                                          TO  WRK-RECEERR
                  PERFORM 500-ERR-HENSYU-SEC
              END-IF
      *
              MOVE    "tbl_syskanri"      TO  MCP-TABLE
              MOVE    "key10"             TO  MCP-PATHNAME
              PERFORM 900-CLOSE-SEC
      *
           ELSE
              MOVE     ZERO               TO  SYSKAN-IDX
              MOVE     SPACE              TO  TBL-SYS1001-T
              INITIALIZE                      TBL-SYS1001-T
      *
              INITIALIZE                      SYSKANRI-REC
              MOVE    "1001"              TO  SYS-KANRICD
              MOVE    "*"                 TO  SYS-KBNCD
              MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
              MOVE    SYSKANRI-REC        TO  MCPDATA-REC
              MOVE    "tbl_syskanri"      TO  MCP-TABLE
              MOVE    "key8"              TO  MCP-PATHNAME
              PERFORM   900-DBSELECT-SEC
              IF      MCP-RC              =   ZERO
                  MOVE    "tbl_syskanri"  TO  MCP-TABLE
                  MOVE    "key8"          TO  MCP-PATHNAME
                  PERFORM  900-SYSKANRI-READ-SEC
                  PERFORM  UNTIL  (FLG-SYSKANRI  =    1)
                            OR    (SYSKAN-IDX   >=  100)
      *
                    ADD     1             TO  SYSKAN-IDX
                    MOVE    SYS-1001-REC  TO  TBL-SYS1001(SYSKAN-IDX)
      *
                    MOVE    "tbl_syskanri"  TO  MCP-TABLE
                    MOVE    "key8"          TO  MCP-PATHNAME
                    PERFORM  900-SYSKANRI-READ-SEC
      *
                  END-PERFORM
              ELSE
                  MOVE    "医療機関情報が取得できませんでした。"
                                          TO  WRK-RECEERR
                  PERFORM 500-ERR-HENSYU-SEC
              END-IF
      *
              MOVE    "tbl_syskanri"      TO  MCP-TABLE
              MOVE    "key8"              TO  MCP-PATHNAME
              PERFORM 900-CLOSE-SEC
      *
           END-IF
      *
           IF   WRK-PARA-SRYYM    NOT =  ZERO
      *
             MOVE     WRK-PARA-SRYYM     TO  WRK-SRYYM-5000
             PERFORM   10012-SYS-5000-CHK-SEC
      *      医療機関減算の取得（システム管理テーブルより）
             INITIALIZE                   WRK-SHOKUJIRYOYO-OCC
                                          WRK-TOKUKANRIKASAN-OCC
      *
             MOVE     ZERO               TO  FLG-MIJISI-INNAI
                                             FLG-MIJISI-IRYO
                                             FLG-MIJISI-JYOKU
      *
             MOVE     SPACE              TO  TBL-GENSAN
             INITIALIZE                      TBL-GENSAN
      *
             INITIALIZE                      SYSKANRI-REC
             MOVE    "5000"              TO  SYS-KANRICD
             MOVE    "*"                 TO  SYS-KBNCD
             MOVE    WRK-PARA-SRYYM      TO  SYS-STYUKYMD (1:6)
             MOVE    "01"                TO  SYS-STYUKYMD (7:2)
             MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
             MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
             MOVE    SYSKANRI-REC        TO  MCPDATA-REC
             MOVE    "tbl_syskanri"      TO  MCP-TABLE
             MOVE    "key10"             TO  MCP-PATHNAME
             PERFORM   900-DBSELECT-SEC
             IF      MCP-RC              =   ZERO
                 MOVE    "tbl_syskanri"  TO  MCP-TABLE
                 MOVE    "key10"         TO  MCP-PATHNAME
                 PERFORM  900-SYSKANRI-READ-SEC
                 IF      FLG-SYSKANRI        =   ZERO
                   PERFORM  10011-SYSKAN-HENSYU-SEC
                   IF        WRK-SYS5000-COUNT    =     ZERO
                      CONTINUE
                   ELSE
                      PERFORM  10013-SYS-5000-GET-SEC
                   END-IF
                 ELSE
                   MOVE "医療機関情報−入院基本が取得できませんでした。"
                                         TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                 END-IF
             ELSE
                  MOVE "医療機関情報−入院基本が取得できませんでした。"
                                         TO  WRK-RECEERR
                  PERFORM 500-ERR-HENSYU-SEC
             END-IF
      *
              MOVE    "tbl_syskanri"     TO  MCP-TABLE
              MOVE    "key10"            TO  MCP-PATHNAME
              PERFORM 900-CLOSE-SEC
      *
           ELSE
      *
             MOVE     ZERO               TO  SYSKAN-IDX
             MOVE     SPACE              TO  TBL-SYS5000-T
             INITIALIZE                      TBL-SYS5000-T
      *
             INITIALIZE                      SYSKANRI-REC
             MOVE    "5000"              TO  SYS-KANRICD
             MOVE    "*"                 TO  SYS-KBNCD
             MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
             MOVE    SYSKANRI-REC        TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "tbl_syskanri"      TO  MCP-TABLE
             MOVE    "key8"              TO  MCP-PATHNAME
             PERFORM   900-DBSELECT-SEC
             IF      MCP-RC              =   ZERO
                 MOVE    "tbl_syskanri"  TO  MCP-TABLE
                 MOVE    "key8"          TO  MCP-PATHNAME
                 PERFORM  900-SYSKANRI-READ-SEC
                 PERFORM  UNTIL  (FLG-SYSKANRI  =    1)
                           OR    (SYSKAN-IDX   >=  100)
                   ADD     1            TO  SYSKAN-IDX
                   MOVE   SYS-5000-REC  TO  TBL-SYS5000(SYSKAN-IDX)
      *
                   MOVE    "tbl_syskanri"  TO  MCP-TABLE
                   MOVE    "key8"          TO  MCP-PATHNAME
                   PERFORM  900-SYSKANRI-READ-SEC
                 END-PERFORM
             ELSE
                  MOVE "医療機関情報−入院基本が取得できませんでした。"
                                         TO  WRK-RECEERR
                  PERFORM 500-ERR-HENSYU-SEC
             END-IF
      *
              MOVE    "tbl_syskanri"     TO  MCP-TABLE
              MOVE    "key8"             TO  MCP-PATHNAME
              PERFORM 900-CLOSE-SEC
           END-IF
      *
           .
       1001-SYSKANRI-HENSYU-EXT.
           EXIT.
      *
      ******************************************************************
      *    月内に複数の医療期間情報がないか検索（医療機関減算の確認）  *
      ******************************************************************
       10012-SYS-5000-CHK-SEC                 SECTION.
      *
           MOVE     ZERO               TO  WRK-SYS5000-COUNT
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5000"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    WRK-SRYYM-5000      TO  SYS-STYUKYMD(1:6)
           MOVE    "__"                TO  SYS-STYUKYMD(7:2)
           MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key11"             TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"    TO  MCP-TABLE
               MOVE    "key11"           TO  MCP-PATHNAME
               PERFORM  900-SYSKANRI-READ-SEC
               PERFORM  UNTIL    FLG-SYSKANRI   =   1
                   ADD     1     TO        WRK-SYS5000-COUNT
                   MOVE    "tbl_syskanri"   TO  MCP-TABLE
                   MOVE    "key11"          TO  MCP-PATHNAME
                   PERFORM  900-SYSKANRI-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_syskanri"     TO  MCP-TABLE
           MOVE    "key11"            TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
      *
       10012-SYS-5000-CHK-EXT.
           EXIT.
      *
      ******************************************************************
      *    月内の医療期間情報取得（医療機関減算情報）                  *
      ******************************************************************
       10013-SYS-5000-GET-SEC                 SECTION.
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5000"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    WRK-SRYYM-5000      TO  SYS-STYUKYMD(1:6)
           MOVE    "__"                TO  SYS-STYUKYMD(7:2)
           MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key11"             TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"    TO  MCP-TABLE
               MOVE    "key11"           TO  MCP-PATHNAME
               PERFORM  900-SYSKANRI-READ-SEC
               PERFORM  UNTIL    FLG-SYSKANRI   =   1
                 MOVE   SYS-5000-STYUKYMD(7:2)  TO  IDV
                 PERFORM  VARYING   GENSAN-IDX  FROM  1  BY  1
                            UNTIL     GENSAN-IDX   >   4
                  IF    SYS-5000-GENKBN(GENSAN-IDX)   =   "2"    
                    EVALUATE  GENSAN-IDX
                      WHEN  2
                        MOVE    1     TO    FLG-MIJISI-INNAI    
                        PERFORM VARYING GENSAN-IDX2 FROM IDV BY 1
                           UNTIL     GENSAN-IDX2   >   31
                          MOVE  "1"   TO    TBL-INNAI(GENSAN-IDX2)
                        END-PERFORM
                      WHEN  3
                        MOVE    1     TO    FLG-MIJISI-IRYO     
                        PERFORM VARYING GENSAN-IDX2 FROM IDV BY 1
                           UNTIL     GENSAN-IDX2   >   31
                          MOVE  "1"   TO    TBL-IRYO(GENSAN-IDX2)
                        END-PERFORM
                      WHEN  4
                        MOVE    1     TO    FLG-MIJISI-JYOKU    
                        PERFORM VARYING GENSAN-IDX2 FROM IDV BY 1
                           UNTIL     GENSAN-IDX2   >   31
                          MOVE  "1"   TO    TBL-JYOKU(GENSAN-IDX2)
                        END-PERFORM
                    END-EVALUATE
                  ELSE
                    EVALUATE  GENSAN-IDX
                      WHEN  2
                        PERFORM VARYING GENSAN-IDX2 FROM IDV BY 1
                           UNTIL     GENSAN-IDX2   >   31
                          MOVE  SPACE   TO    TBL-INNAI(GENSAN-IDX2)
                        END-PERFORM
                      WHEN  3
                        PERFORM VARYING GENSAN-IDX2 FROM IDV BY 1
                           UNTIL     GENSAN-IDX2   >   31
                          MOVE  SPACE   TO    TBL-IRYO(GENSAN-IDX2)
                        END-PERFORM
                      WHEN  4
                        PERFORM VARYING GENSAN-IDX2 FROM IDV BY 1
                           UNTIL     GENSAN-IDX2   >   31
                          MOVE  SPACE   TO    TBL-JYOKU(GENSAN-IDX2)
                        END-PERFORM
                    END-EVALUATE
                  END-IF
                 END-PERFORM
      *
                 PERFORM    VARYING  IDX3  FROM  IDV  BY  1
                             UNTIL   IDX3    >   31
                      EVALUATE    SYS-5000-SHOKUJIRYOYOCD
      *                入院食事療養（１）
                       WHEN         "197000110"
                          MOVE     1      TO   WRK-SHOKUJIRYOYO(IDX3)
                          EVALUATE  SYS-5000-SHOKUKBN(1)
                            WHEN     "1"
                              MOVE  ZERO  TO   WRK-TOKUKANRIKASAN(IDX3)
                            WHEN     "2"
                              MOVE    1   TO   WRK-TOKUKANRIKASAN(IDX3)
                          END-EVALUATE
      *                入院食事療養（２）
                       WHEN         "197000710"
                          MOVE     2      TO   WRK-SHOKUJIRYOYO(IDX3)
                          MOVE    ZERO    TO   WRK-TOKUKANRIKASAN(IDX3)
                      END-EVALUATE
                 END-PERFORM
      *
                 MOVE    "tbl_syskanri"      TO  MCP-TABLE
                 MOVE    "key11"             TO  MCP-PATHNAME
                 PERFORM  900-SYSKANRI-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_syskanri"     TO  MCP-TABLE
           MOVE    "key11"            TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
      *
       10013-SYS-5000-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    シスカンの編集
      *****************************************************************
       10011-SYSKAN-HENSYU-SEC                SECTION.
      *
           PERFORM  VARYING   GENSAN-IDX  FROM  1  BY  1
                    UNTIL     GENSAN-IDX   >   4
                IF    SYS-5000-GENKBN(GENSAN-IDX)   =   "2"    
                    EVALUATE  GENSAN-IDX
                        WHEN  2
                            MOVE    1     TO    FLG-MIJISI-INNAI    
                            PERFORM VARYING GENSAN-IDX2 FROM 1 BY 1
                               UNTIL     GENSAN-IDX2   >   31
                              MOVE  "1"   TO    TBL-INNAI(GENSAN-IDX2)
                            END-PERFORM
                        WHEN  3
                            MOVE    1     TO    FLG-MIJISI-IRYO     
                            PERFORM VARYING GENSAN-IDX2 FROM 1 BY 1
                               UNTIL     GENSAN-IDX2   >   31
                              MOVE  "1"   TO    TBL-IRYO(GENSAN-IDX2)
                            END-PERFORM
                        WHEN  4
                            MOVE    1     TO    FLG-MIJISI-JYOKU    
                            PERFORM VARYING GENSAN-IDX2 FROM 1 BY 1
                               UNTIL     GENSAN-IDX2   >   31
                              MOVE  "1"   TO    TBL-JYOKU(GENSAN-IDX2)
                            END-PERFORM
                    END-EVALUATE
                END-IF
           END-PERFORM
      *
           PERFORM   VARYING   IDX3   FROM  1  BY  1
                      UNTIL    IDX3    >   31
              EVALUATE    SYS-5000-SHOKUJIRYOYOCD
      *         入院食事療養（１）
                WHEN         "197000110"
                    MOVE     1      TO   WRK-SHOKUJIRYOYO(IDX3)
                    EVALUATE  SYS-5000-SHOKUKBN(1)
                      WHEN     "1"
                        MOVE  ZERO  TO   WRK-TOKUKANRIKASAN(IDX3)
                      WHEN     "2"
                        MOVE    1   TO   WRK-TOKUKANRIKASAN(IDX3)
                    END-EVALUATE
      *         入院食事療養（２）
                WHEN         "197000710"
                    MOVE     2      TO   WRK-SHOKUJIRYOYO(IDX3)
              END-EVALUATE
           END-PERFORM
      *
           .
       10011-SYSKAN-HENSYU-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    "RECE700"           TO  RECE200PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE200PARA-TERMID
           MOVE    WRK-PARA-HOSPNUM    TO  RECE200PARA-HOSPNUM
      *
           OPEN    I-O                 RECE200-FILE
      *
           PERFORM 900-RECE200-READ-SEC
      *
           PERFORM             UNTIL   FLG-RECE200 =   1
                               OR      FLG-END     =   1
               PERFORM 20011-HENSYU-SEC
      *
               PERFORM 900-RECE200-READ-SEC
      *
      *        処理中止設定処理
               IF      CNT-IN-CANCEL       =   50
                   MOVE    ZERO                TO  CNT-IN-CANCEL
                   PERFORM 500-CANCEL-HENSYU-SEC
               END-IF
           END-PERFORM
      *
           CLOSE   RECE200-FILE
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      * 
      *****************************************************************
      *    編集処理
      *****************************************************************
       20011-HENSYU-SEC                   SECTION.
      *
           MOVE       SPACE             TO     TBL-JNISSU
           INITIALIZE                          TBL-JNISSU
           MOVE       SPACE             TO     TBL-JNISSU-GEN
           INITIALIZE                          TBL-JNISSU-GEN
      *
           MOVE       SPACE             TO     TBL-TOTALTEN
           INITIALIZE                          TBL-TOTALTEN
           MOVE       SPACE             TO     TBL-TOTALTEN2
           INITIALIZE                          TBL-TOTALTEN2
           MOVE       SPACE             TO     WRK-NYUINF-TABLE
           INITIALIZE                          WRK-NYUINF-TABLE
      *
           MOVE       SPACE             TO     WRK-DAY-TABLE
           INITIALIZE                          WRK-DAY-TABLE
      *
           MOVE       SPACE             TO     TBL-GENSAN2
           INITIALIZE                          TBL-GENSAN2
      *
           MOVE       ZERO              TO     FLG-MIJISI-GENSAN        
      *
           MOVE       ZERO              TO     FLG-FUKUSHI
      *
      ***  PERFORM    VARYING    IDX    FROM   1   BY   1
      ***             UNTIL     (IDX      >   10)  OR
      ***                       (RECE200-SRYKA(IDX)   =   SPACE)
               PERFORM    200111-RECE200-HENSYU-SEC
               PERFORM    200112-RECE200-HENSYU2-SEC
               PERFORM    200113-RECE200-HENSYU3-SEC
               IF   RECE200-SRYYM  >= "200604"
                 CONTINUE
               ELSE
                 PERFORM  200114-RECE200-HENSYU4-SEC
               END-IF
               PERFORM    200115-RECE200-HENSYU9-SEC
      ***  END-PERFORM
      *
           PERFORM     200116-JNISSU-SET-SEC
      *
           PERFORM     200117-RECE200-REWRITE-SEC
           .
       20011-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       200111-RECE200-HENSYU-SEC                SECTION.
      *
           INITIALIZE                            NYUINACCT-REC
           MOVE    RECE200-HOSPNUM        TO      NACCT-HOSPNUM
           MOVE    RECE200-NYUGAIKBN      TO      NACCT-NYUGAIKBN
           MOVE    RECE200-PTID           TO      NACCT-PTID
      ***  MOVE    RECE200-SRYKA(IDX)     TO      NACCT-SRYKA
           MOVE    RECE200-SRYYM          TO      NACCT-SRYYM
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC
           MOVE    "tbl_nyuinacct"       TO      MCP-TABLE
           MOVE    "key7"                TO      MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "tbl_nyuinacct"   TO      MCP-TABLE
               MOVE    "key7"            TO      MCP-PATHNAME
               PERFORM  900-NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-ZAISKBKBN    =    "1"  OR  "2"  OR  
                                                "4"  OR  "5"  OR
                                                "6"  OR  "7"
                       PERFORM    2001111-NYUIN-DAY-TAIHI-SEC
                 END-IF
      *
                 MOVE    "tbl_nyuinacct"       TO      MCP-TABLE
                 MOVE    "key7"                TO      MCP-PATHNAME
                 PERFORM        900-NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "tbl_nyuinacct"    TO  MCP-TABLE
           MOVE    "key7"             TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           PERFORM  VARYING  IDY    FROM    1   BY  1
                          UNTIL   IDY     >       31
      *
                 IF        WRK-DAY5(IDY)   =   RECE200-HKNCOMBI
                      MOVE    ZERO            TO    FLG-SHOSAISIN
                      IF   WRK-DAY1(IDY)   NOT =    ZERO    
                               MOVE    1      TO    FLG-SHOSAISIN
                      END-IF
      *
                      PERFORM   2001112-RECE200-TENSOU11-SEC
                 END-IF
      *
           END-PERFORM
      *
      *+++
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE200-HOSPNUM       TO      ACCT-HOSPNUM
           MOVE    RECE200-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE200-PTID          TO      ACCT-PTID
      ***  MOVE    RECE200-SRYKA(IDX)    TO      ACCT-SRYKA
           MOVE    RECE200-SRYYM         TO      ACCT-SRYYM
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "tbl_sryacct"        TO  MCP-TABLE
           MOVE    "key33"              TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_sryacct"    TO      MCP-TABLE
               MOVE    "key33"          TO      MCP-PATHNAME
               PERFORM  900-SRYACCT-READ-SEC
               PERFORM  UNTIL
                  (FLG-SRYACCT        =    1)
                       IF      ACCT-HKNCOMBI   =
                                               RECE200-HKNCOMBI
      *
                           IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                                (ACCT-ZAIKAISU  NOT =    ZERO)
                                MOVE    ZERO     TO    FLG-SHOSAISIN
                                                       FLG-SHOSAISIN-GEN
                                IF   ACCT-SRYKBN  =  "11"  OR
                                                     "13"  OR  "14"
                                    PERFORM 2001113-SHOSAISIN-HANTEI-SEC
                                END-IF
                                PERFORM   2001114-RECE200-TENSOU12-SEC
                           END-IF
                           IF   (ACCT-ZAITEN    =        ZERO)    AND
                                (ACCT-ZAIKAISU  NOT =    ZERO)
                                MOVE    ZERO     TO    FLG-SHOSAISIN
                                                       FLG-SHOSAISIN-GEN
                                IF   ACCT-SRYKBN  =  "11"  OR  "99" 
                                    PERFORM 2001113-SHOSAISIN-HANTEI-SEC
                                END-IF
                                PERFORM   2001114-RECE200-TENSOU12-SEC
                           END-IF
                           IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                                (ACCT-ZAIKAISU  NOT =    ZERO)
                                IF   ACCT-SRYKBN  =  "90" OR "92"   
                                    PERFORM   2001115-NYUINRYO-TAIHI-SEC
                                END-IF
                           END-IF
                       END-IF
                   MOVE    "tbl_sryacct"     TO  MCP-TABLE
                   MOVE    "key33"           TO  MCP-PATHNAME
                   PERFORM   900-SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_sryacct"    TO  MCP-TABLE
           MOVE    "key33"          TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       200111-RECE200-HENSYU-EXT.
           EXIT.
      *
      ******************************************************************
      *    会計フラグ退避処理                                          *
      ******************************************************************
       2001111-NYUIN-DAY-TAIHI-SEC         SECTION.
      *
           PERFORM    VARYING   IDY   FROM   1   BY   1
                                    UNTIL    IDY    >    31
      *
             IF       NACCT-DAY(IDY)   NOT =  ZERO 
      *
               IF     NACCT-ZAISKBKBN    =    "1"  
                  IF     NACCT-SRYCDTOTAL    =    099999916
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY1-SENTEI(IDY)
                  ELSE
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY1(IDY) 
                    IF  ( NACCT-SRYKBN     = "90"      )
                    OR  ( NACCT-SRYCDTOTAL = 190799410 )
                    OR  ( NACCT-SRYCDTOTAL = 190799510 )
                       MOVE   903  TO  WRK-DAY1-NYUTENTTLKBN(IDY)       
                    ELSE                                                
                       MOVE   920  TO  WRK-DAY1-NYUTENTTLKBN(IDY)       
                    END-IF
                  END-IF
               END-IF 
      *
               IF     NACCT-ZAISKBKBN    =    "2"  
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY2(IDY) 
               END-IF 
      *
               IF   RECE200-SRYYM  >= "200604"
                 CONTINUE
               ELSE
                 IF     NACCT-ZAISKBKBN    =    "4"
                   IF    NACCT-SRYCDTOTAL  =    197000570 
                      MOVE   NACCT-DAY(IDY)   TO  WRK-DAY41(IDY)
                   ELSE
                      MOVE   NACCT-DAY(IDY)   TO  WRK-DAY4(IDY)
                   END-IF
                 END-IF
               END-IF
      *
               IF     NACCT-ZAISKBKBN    =    "5"  
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY5(IDY) 
               END-IF 
      *
               IF     NACCT-ZAISKBKBN    =    "6"  
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY6(IDY) 
                    IF  NACCT-SRYCDTOTAL  =  190080470   OR             
                                             190799670   OR             
                                             190080570   OR             
                                             190799770   OR             
                                             190111690   OR             
                                             190809090   OR             
                                             190111790   OR             
                                             190809190                  
                      CONTINUE                                          
                    ELSE                                                
                      ADD    NACCT-ZAITEN   TO  WRK-DAY6-ZAITEN(IDY)
                    END-IF
               END-IF 
      *
               IF     NACCT-ZAISKBKBN    =    "7"  
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY7(IDY) 
                    ADD    NACCT-ZAITEN     TO  WRK-DAY7-ZAITEN(IDY)
               END-IF 
      *
             END-IF
      *
           END-PERFORM.
      *
       2001111-NYUIN-DAY-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2001112-RECE200-TENSOU11-SEC                 SECTION.
      *
               IF   FLG-SHOSAISIN        =       1
                       MOVE    "1"   TO   TBL-JNISSU-DAY(1 IDY)
               END-IF
           .
       2001112-RECE200-TENSOU11-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計テーブルの内容から診療行為テーブルを読み込み、
      *    診療実日数のカウントを行える剤であるかの判定
      *****************************************************************
       2001113-SHOSAISIN-HANTEI-SEC                 SECTION.
      *
           INITIALIZE                           SRYACT-REC
           MOVE    ACCT-HOSPNUM         TO      SRY-HOSPNUM
           MOVE    ACCT-NYUGAIKBN       TO      SRY-NYUGAIKBN
           MOVE    ACCT-PTID            TO      SRY-PTID
      ***  MOVE    ACCT-SRYKA           TO      SRY-SRYKA
           MOVE    ACCT-SRYYM           TO      SRY-SRYYM
           MOVE    ACCT-ZAINUM          TO      SRY-ZAINUM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "tbl_sryact"         TO      MCP-TABLE
           MOVE    "key9"               TO      MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_sryact"     TO      MCP-TABLE
               MOVE    "key9"           TO      MCP-PATHNAME
               PERFORM  900-SRYACT-READ-SEC
               PERFORM  UNTIL  FLG-SRYACT    =    1
                   PERFORM   VARYING   SRYACT-IDX  FROM  1   BY   1
                             UNTIL    (SRYACT-IDX    >   5)  OR
                                      (SRY-SRYCD(SRYACT-IDX)
                                                         =   SPACE)
      ****                                               =   SPACE)  OR
      ****                            (FLG-SHOSAISIN     =    1)
                       MOVE    SPACE         TO   TNS-TENSU-REC
                       INITIALIZE                 TNS-TENSU-REC
                       MOVE    SRY-SRYCD(SRYACT-IDX) TO   TNS-SRYCD
                       MOVE    ACCT-SRYYM         TO  TNS-YUKOSTYMD(1:6)
                       MOVE    "01"               TO  TNS-YUKOSTYMD(7:2)
                       MOVE    TNS-YUKOSTYMD      TO  TNS-YUKOEDYMD
                       PERFORM  900-TENSU-READ-SEC
                       IF       FLG-TENSU      =    ZERO
                         IF ( (TNS-JITUDAY    =     2)    AND
                              (TNS-DAYCNT     =     1   OR   2) ) OR
                            (  SRY-SRYCD(SRYACT-IDX) =  "099409901" OR
                                                        "099999902" OR
                                                        "099110001" OR
                                                        "099120001" OR
                                                        "111011810")
                             MOVE    1      TO    FLG-SHOSAISIN
                         END-IF
                         IF    SRY-SRYCD(SRYACT-IDX) =  "099409903"
                             MOVE    1      TO    FLG-SHOSAISIN-GEN
                         END-IF
                       END-IF
                   END-PERFORM
                   MOVE    "tbl_sryact"      TO   MCP-TABLE
                   MOVE    "key9"            TO   MCP-PATHNAME
                   PERFORM   900-SRYACT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_sryact"     TO  MCP-TABLE
           MOVE    "key9"           TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
      *
       SHOSAISHIN-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2001114-RECE200-TENSOU12-SEC                 SECTION.
      *
               IF   FLG-SHOSAISIN        =       1
                    PERFORM    VARYING   ACCT-IDX   FROM   1    BY   1
                               UNTIL    ACCT-IDX   >      31
                           IF  ACCT-DAY(1 ACCT-IDX)   NOT =    ZERO
                               MOVE    "1"       TO
                                             TBL-JNISSU-DAY(1 ACCT-IDX)
                           END-IF
                    END-PERFORM
               END-IF
               IF   FLG-SHOSAISIN-GEN    =       1
                    PERFORM    VARYING   ACCT-IDX   FROM   1    BY   1
                               UNTIL    ACCT-IDX   >      31
                           IF  ACCT-DAY(1 ACCT-IDX)   NOT =    ZERO
                               MOVE    "1"       TO
                                         TBL-JNISSU-DAY-GEN(1 ACCT-IDX)
                           END-IF
                    END-PERFORM
               END-IF
           .
       2001114-RECE200-TENSOU12-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計の入院料等の退避処理
      *****************************************************************
       2001115-NYUINRYO-TAIHI-SEC                 SECTION.
      *
           IF        ACCT-SRYCDTOTAL    =    190080470
                                        OR   190799670
                                        OR   190080570
                                        OR   190799770
                                        OR   190111690
                                        OR   190809090
                                        OR   190111790
                                        OR   190809190
                CONTINUE
           ELSE
                PERFORM    VARYING   ACCT-IDX   FROM   1    BY   1
                                 UNTIL    ACCT-IDX   >      31
                   IF  ACCT-DAY(1 ACCT-IDX)   NOT =    ZERO
                         COMPUTE  WRK-ACCT90(ACCT-IDX) = 
                                  WRK-ACCT90(ACCT-IDX) +
                                 (ACCT-ZAITEN * ACCT-DAY(1 ACCT-IDX))
                   END-IF
                END-PERFORM
           END-IF
      *
           .
       2001115-NYUINRYO-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       200112-RECE200-HENSYU2-SEC                SECTION.
      *
           PERFORM      2001122-SENTEI-KEISU-GET-SEC
      *
           INITIALIZE                            NYUINACCT-REC
           MOVE    RECE200-HOSPNUM        TO      NACCT-HOSPNUM
           MOVE    RECE200-NYUGAIKBN      TO      NACCT-NYUGAIKBN
           MOVE    RECE200-PTID           TO      NACCT-PTID
      ***  MOVE    RECE200-SRYKA(IDX)     TO      NACCT-SRYKA
           MOVE    RECE200-SRYYM          TO      NACCT-SRYYM
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key7"              TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key7"              TO  MCP-PATHNAME
               PERFORM  900-NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-ZAISKBKBN          =    "1"  
                 AND    NACCT-SRYCDTOTAL   NOT   =    099999916
      *
      *            入院基本料と加減算点数の取得
                   PERFORM   2001123-NYUINKHN-GET-SEC
      *
                   PERFORM  VARYING  IDY    FROM    1   BY  1
                                  UNTIL   IDY     >       31
      *
                      MOVE     ZERO    TO   FLG-NISSUSET
      *
                         IF  WRK-DAY5(IDY)  =  RECE200-HKNCOMBI
                              IF   NACCT-ZAITEN    NOT =    ZERO  
                              AND  NACCT-DAY(IDY)  NOT =    ZERO  
                                   PERFORM 2001124-RECE200-TENSOU21-SEC
                              END-IF
                         END-IF
      *
                   END-PERFORM
      *
                 END-IF
      *
                 IF     NACCT-ZAISKBKBN    =    "6"  
      *
                   PERFORM  VARYING  IDY    FROM    1   BY  1
                                  UNTIL   IDY     >       31
      *
                       IF  WRK-DAY1(IDY) NOT =  ZERO 
                         IF   WRK-DAY5(IDY)   =  RECE200-HKNCOMBI
                              IF   (NACCT-ZAITEN    NOT =    ZERO)  
                              AND  (NACCT-DAY(IDY)  NOT =    ZERO)  
                              AND  (WRK-DAY2(IDY)  =    ZERO  OR  4)
                                   PERFORM 2001125-RECE200-TENSOU22-SEC
                              END-IF
                         END-IF
                       END-IF
      *
                   END-PERFORM
      *
                 END-IF
      *
                 MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
                 MOVE    "key7"              TO  MCP-PATHNAME
                 PERFORM        900-NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key7"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
      *+++
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE200-HOSPNUM       TO      ACCT-HOSPNUM
           MOVE    RECE200-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE200-PTID          TO      ACCT-PTID
      ***  MOVE    RECE200-SRYKA(IDX)    TO      ACCT-SRYKA
           MOVE    RECE200-SRYYM         TO      ACCT-SRYYM
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "tbl_sryacct"        TO      MCP-TABLE
           MOVE    "key33"              TO      MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_sryacct"    TO      MCP-TABLE
               MOVE    "key33"          TO      MCP-PATHNAME
               PERFORM  900-SRYACCT-READ-SEC
               PERFORM  UNTIL
                  (FLG-SRYACCT        =    1)
                       IF      ACCT-HKNCOMBI   =
                                               RECE200-HKNCOMBI
                           IF   (ACCT-ZAITEN    NOT =    ZERO)
                           AND  (ACCT-ZAIKAISU  NOT =    ZERO)
                                IF   ACCT-SRYKBN  =  "90" OR "92"  
                                    PERFORM 2001126-RECE200-TENSOU23-SEC
                                END-IF
                           END-IF
                       END-IF
                   MOVE    "tbl_sryacct"     TO   MCP-TABLE
                   MOVE    "key33"           TO   MCP-PATHNAME
                   PERFORM   900-SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_sryacct"       TO  MCP-TABLE
           MOVE    "key33"             TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       200112-RECE200-HENSYU2-EXT.
           EXIT.
      *
      **************************************************************
      *    選定外泊時の係数取得
      **************************************************************
       2001122-SENTEI-KEISU-GET-SEC           SECTION.
      *
           MOVE      ZERO           TO     WRK-SENTEI-KEISU
      *
           IF   RECE200-SRYYM    <=    "200303"
               MOVE   0.1           TO     WRK-SENTEI-KEISU
           END-IF
      *
           IF ( RECE200-SRYYM    >=    "200304" )   AND
              ( RECE200-SRYYM    <=    "200403" )
               MOVE   0.05           TO    WRK-SENTEI-KEISU
           END-IF
      *
           IF   RECE200-SRYYM    >=    "200404"
               MOVE   ZERO          TO     WRK-SENTEI-KEISU
           END-IF
      *
           .
      *
       2001122-SENTEI-KEISU-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2001124-RECE200-TENSOU21-SEC                 SECTION.
      *
      *    入院基本料と加減算点数の計算
                      MOVE    1          TO        KH-IDX
                      PERFORM      20011241-NYUINACCT-GET-SEC
           .
       2001124-RECE200-TENSOU21-EXT.
           EXIT.
      *
      **************************************************************
      *    入院基本料と加減算点数の計算
      **************************************************************
       20011241-NYUINACCT-GET-SEC           SECTION.
      *
      *    入院料と外泊を比較して点数算定
      *
           EVALUATE   WRK-NYUTENTTLKBN
               WHEN   903
                  MOVE      ZERO   TO  WRK-NYUKHNRYO
                  IF    WRK-DAY1-SENTEI(IDY)   NOT  =  ZERO
                    EVALUATE   WRK-DAY2(IDY)
                       WHEN   ZERO
                         MOVE     WRK-SENTEI-ZAITEN  TO  
                                       WRK-NYUKHNRYO
                       WHEN   1
                         COMPUTE  WRK-NYUKHNRYO =
                                 (WRK-KHNTEN  *  WRK-SENTEI-KEISU)
                                                     +  0.5
                       WHEN   3
                         COMPUTE  WRK-NYUKHNRYO =
                                 (WRK-KHNTEN  *  WRK-SENTEI-KEISU)
                                                     +  0.5
                       WHEN   4
                         COMPUTE  WRK-NYUKHNRYO =
      ****                       (WRK-KHNTEN         *  0.15)
                                 (WRK-KHNTEN  *  WRK-SENTEI-KEISU)
                                                     +  0.5
                    END-EVALUATE
                  ELSE
                    EVALUATE   WRK-DAY2(IDY)
                       WHEN   ZERO
                         MOVE     NACCT-ZAITEN   TO  
                                       WRK-NYUKHNRYO
                       WHEN   1
                         COMPUTE  WRK-NYUKHNRYO =
                                 (WRK-KHNTEN    *  0.15)
                                                +  0.5
                       WHEN   2
                         COMPUTE  WRK-NYUKHNRYO =
                                 (WRK-KHNTEN    *  0.3)
                                                +  0.5
                       WHEN   4
                         IF   RECE200-SRYYM    >=    "200404"
                            COMPUTE  WRK-NYUKHNRYO =
                                    (WRK-KHNTEN    *  0.3)
                                                   +  0.5
                         ELSE
                            COMPUTE  WRK-NYUKHNRYO =
                                    (WRK-KHNTEN    *  0.15)
                                                   +  0.5
                         END-IF
                    END-EVALUATE
                  END-IF
                  EVALUATE   WRK-DAY2(IDY)
                     WHEN   ZERO
                            COMPUTE  WRK-NYUTOKKEI2(KH-IDX)  =
                                     WRK-NYUTOKKEI2(KH-IDX)  -
                                     TBL-MIJISI-TENSU(IDY)
                         COMPUTE  RECE200-NYUTOKKEI2(KH-IDX)  =
                                  RECE200-NYUTOKKEI2(KH-IDX)  -
                                  TBL-MIJISI-TENSU(IDY)
                         MOVE     1      TO    FLG-MIJISI-GENSAN        
                  END-EVALUATE
                  IF   WRK-NYUKHNRYO  NOT = ZERO
                    MOVE     ZERO     TO    FLG-ARI
                    PERFORM  VARYING  ID1    FROM    1   BY  1
                                UNTIL   ID1                   > 10
                                  OR    RECE200-NYUKHNNISSU(ID1)
                                                              = ZERO
                                  OR    FLG-ARI               = 1
                      IF  RECE200-NYUKHNRYO(ID1)  =  WRK-NYUKHNRYO
                            IF   FLG-NISSUSET   =  ZERO
                              ADD   1   TO   RECE200-NYUKHNNISSU(ID1)
                              MOVE  1   TO   FLG-NISSUSET
                            END-IF
                               ADD   WRK-NYUKHNRYO
                                      TO   WRK-NYUKHNKEI(ID1 KH-IDX)
                            ADD   WRK-NYUKHNRYO
                                      TO   RECE200-NYUKHNKEI(ID1 KH-IDX)
                            MOVE  1   TO   FLG-ARI
                      END-IF
                    END-PERFORM  
                    IF  FLG-ARI  =  ZERO  
                      ADD        1           TO RECE200-NYUKHNNISSU(ID1)
                      MOVE       1           TO  FLG-NISSUSET
                      MOVE   WRK-NYUKHNRYO   TO  RECE200-NYUKHNRYO(ID1)
                         ADD    WRK-NYUKHNRYO   
                                       TO  WRK-NYUKHNKEI(ID1 KH-IDX)
                      ADD    WRK-NYUKHNRYO   
                                       TO  RECE200-NYUKHNKEI(ID1 KH-IDX)
                    END-IF
                  END-IF
               WHEN   920
                  MOVE      ZERO   TO  WRK-NYUTOKRYO
                  MOVE      ZERO   TO  FLG-GAIHAKU
                  IF    WRK-DAY1-SENTEI(IDY)   NOT  =  ZERO
                    EVALUATE   WRK-DAY2(IDY)
                       WHEN   ZERO
                         MOVE     WRK-SENTEI-ZAITEN   TO  
                                       WRK-NYUTOKRYO
                       WHEN   1
                         COMPUTE  WRK-NYUTOKRYO =
                                 (WRK-KHNTEN  *  WRK-SENTEI-KEISU)
                                                     +  0.5
                         MOVE   1   TO   FLG-GAIHAKU
                       WHEN   3
                         COMPUTE  WRK-NYUTOKRYO =
                                 (WRK-KHNTEN  *  WRK-SENTEI-KEISU)
                                                     +  0.5
                         MOVE   1   TO   FLG-GAIHAKU
                       WHEN   4
                         COMPUTE  WRK-NYUTOKRYO =
      ****                       (WRK-KHNTEN         *  0.15)
                                 (WRK-KHNTEN  *  WRK-SENTEI-KEISU)
                                                     +  0.5
                         MOVE   1   TO   FLG-GAIHAKU
                    END-EVALUATE
                  ELSE
                    EVALUATE   WRK-DAY2(IDY)
                       WHEN   ZERO
                         MOVE     NACCT-ZAITEN   TO  
                                       WRK-NYUTOKRYO
                       WHEN   1
                         COMPUTE  WRK-NYUTOKRYO =
                                 (WRK-KHNTEN    *  0.15)
                                                +  0.5
                         MOVE   1   TO   FLG-GAIHAKU
                       WHEN   2
                         COMPUTE  WRK-NYUTOKRYO =
                                 (WRK-KHNTEN    *  0.3)
                                                +  0.5
                         MOVE   1   TO   FLG-GAIHAKU
                       WHEN   4
                         IF   RECE200-SRYYM    >=    "200404"
                            COMPUTE  WRK-NYUTOKRYO =
                                    (WRK-KHNTEN    *  0.3)
                                                   +  0.5
                         ELSE
                            COMPUTE  WRK-NYUTOKRYO =
                                    (WRK-KHNTEN    *  0.15)
                                                   +  0.5
                         END-IF
                         MOVE   1   TO   FLG-GAIHAKU
                    END-EVALUATE
                  END-IF
                  EVALUATE   WRK-DAY2(IDY)
                     WHEN   ZERO
                            COMPUTE  WRK-NYUTOKKEI2(KH-IDX)  =
                                     WRK-NYUTOKKEI2(KH-IDX)  -
                                     TBL-MIJISI-TENSU(IDY)
                         COMPUTE  RECE200-NYUTOKKEI2(KH-IDX)  =
                                  RECE200-NYUTOKKEI2(KH-IDX)  -
                                  TBL-MIJISI-TENSU(IDY)
                         MOVE     1      TO    FLG-MIJISI-GENSAN        
                  END-EVALUATE
                  IF  (WRK-DAY6(IDY)          NOT =  ZERO)
                  AND (WRK-DAY6-ZAITEN(IDY)   NOT =  ZERO)
                  AND (WRK-DAY2(IDY)              =  ZERO  OR  4)
                      COMPUTE  WRK-NYUTOKRYO = WRK-NYUTOKRYO
                                             + WRK-DAY6-ZAITEN(IDY)
                  END-IF
                  IF  WRK-ACCT90(IDY)        NOT =  ZERO
                      COMPUTE  WRK-NYUTOKRYO = WRK-NYUTOKRYO
                                             + WRK-ACCT90(IDY)
                  END-IF
                  IF   WRK-NYUTOKRYO  NOT = ZERO
                   IF     FLG-GAIHAKU  =  ZERO
                    MOVE     ZERO     TO    FLG-ARI
                    PERFORM  VARYING  ID1    FROM    1   BY  1
                        UNTIL ( ID1                          > 10    )  
                          OR  ( RECE200-NYUTOKNISSU(ID1)      = ZERO  )
                          OR  ( FLG-ARI                      = 1     )
                      IF  RECE200-NYUTOKRYO-RYAKU(ID1)  =  WRK-RYAKUSHO
                            IF   FLG-NISSUSET   =  ZERO
                              ADD   1   TO   RECE200-NYUTOKNISSU(ID1)
                              MOVE  1   TO   FLG-NISSUSET
                            END-IF
                               ADD   WRK-NYUTOKRYO
                                      TO   WRK-NYUTOKKEI(ID1 KH-IDX)
                            ADD   WRK-NYUTOKRYO
                                      TO   RECE200-NYUTOKKEI(ID1 KH-IDX)
                            MOVE  1   TO   FLG-ARI
                      END-IF
                    END-PERFORM  
                    IF  FLG-ARI  =  ZERO  
                      ADD        1           TO RECE200-NYUTOKNISSU(ID1)
                      MOVE       1           TO  FLG-NISSUSET
                      MOVE   WRK-RYAKUSHO    TO  RECE200-NYUTOKRYO-RYAKU
                                                                   (ID1)
      ***             略称が空白の場合の為の処置
                      MOVE   999999999       TO  RECE200-NYUTOKRYO(ID1)
      *
                         ADD    WRK-NYUTOKRYO   
                                       TO  WRK-NYUTOKKEI(ID1 KH-IDX)
                      ADD    WRK-NYUTOKRYO   
                                       TO  RECE200-NYUTOKKEI(ID1 KH-IDX)
                    END-IF
                   ELSE
                    MOVE     ZERO     TO    FLG-ARI
                    PERFORM  VARYING  ID1    FROM    1   BY  1
                        UNTIL ( ID1                          > 10    )  
                          OR  ( RECE200-NYUTOKNISSU(ID1)      = ZERO  )
                          OR  ( FLG-ARI                      = 1     )
                      IF  RECE200-NYUTOKRYO(ID1)  =  WRK-NYUTOKRYO
      ****                  IF   KH-IDX =  1
      ****                  OR   RECE200-HKNNUM  =  SPACE
                            IF   FLG-NISSUSET   =  ZERO
                              ADD   1   TO   RECE200-NYUTOKNISSU(ID1)
                              MOVE  1   TO   FLG-NISSUSET
                            END-IF
                               ADD   WRK-NYUTOKRYO
                                      TO   WRK-NYUTOKKEI(ID1 KH-IDX)
                            ADD   WRK-NYUTOKRYO
                                      TO   RECE200-NYUTOKKEI(ID1 KH-IDX)
                            MOVE  1   TO   FLG-ARI
                      END-IF
                    END-PERFORM  
                    IF  FLG-ARI  =  ZERO  
                      ADD        1           TO RECE200-NYUTOKNISSU(ID1)
                      MOVE       1           TO  FLG-NISSUSET
      ***             点数がゼロの場合の為の処置
                      MOVE   "９９９９９９９"
                                             TO  RECE200-NYUTOKRYO-RYAKU
                                                                   (ID1)
      *
                      MOVE   WRK-NYUTOKRYO   TO  RECE200-NYUTOKRYO(ID1)
                         ADD    WRK-NYUTOKRYO   
                                       TO  WRK-NYUTOKKEI(ID1 KH-IDX)
                      ADD    WRK-NYUTOKRYO   
                                       TO  RECE200-NYUTOKKEI(ID1 KH-IDX)
                    END-IF
                   END-IF
                  END-IF
           END-EVALUATE
      *
           .
       20011241-NYUINACCT-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2001125-RECE200-TENSOU22-SEC                 SECTION.
      *
      *    入院基本料加減算点数の計算
                      MOVE    1          TO        KH-IDX
                      PERFORM      20011251-NYUINACCT-GET2-SEC
           .
       2001125-RECE200-TENSOU22-EXT.
           EXIT.
      *
      **************************************************************
      *    入院基本料加減算点数の計算
      **************************************************************
       20011251-NYUINACCT-GET2-SEC           SECTION.
      *
           IF  NACCT-SRYCDTOTAL       =  190080470   OR                 
                                         190799670   OR                 
                                         190080570   OR                 
                                         190799770   OR                 
                                         190111690   OR                 
                                         190809090   OR                 
                                         190111790   OR                 
                                         190809190                      
              CONTINUE                                                  
           ELSE                                                         
      *
              EVALUATE   WRK-DAY1-NYUTENTTLKBN(IDY)
                 WHEN   903
                       COMPUTE  WRK-NYUKHNKEI2(KH-IDX)  =
                                WRK-NYUKHNKEI2(KH-IDX)  +  NACCT-ZAITEN
                    COMPUTE  RECE200-NYUKHNKEI2(KH-IDX)  =
                             RECE200-NYUKHNKEI2(KH-IDX)  +  NACCT-ZAITEN
              END-EVALUATE
      *
           END-IF
      *
           .
       20011251-NYUINACCT-GET2-EXT.
           EXIT.
      *
      **************************************************************
      *    入院基本料と加減算点数の取得
      **************************************************************
       2001123-NYUINKHN-GET-SEC           SECTION.
      *
           IF  ( NACCT-SRYKBN     = "90"      )
           OR  ( NACCT-SRYCDTOTAL = 190799410 )
           OR  ( NACCT-SRYCDTOTAL = 190799510 )
                 MOVE   903   TO  WRK-NYUTENTTLKBN                      
           ELSE                                                         
                 MOVE   920   TO  WRK-NYUTENTTLKBN                      
           END-IF                                                       
      *
           MOVE    ZERO               TO   WRK-KHNTEN
           MOVE    SPACE              TO   WRK-RYAKUSHO
           MOVE    ZERO               TO   NYUINACT-IDX2
           MOVE    ZERO               TO   WRK-KSNTEN
           MOVE    ZERO               TO   WRK-SENTEI-KHNTEN
           MOVE    ZERO               TO   WRK-SENTEI-ZAITEN
           MOVE    SPACE              TO   WRK-GAIHAKU-SRYCD
           MOVE    ZERO               TO   WRK-GAIHAKU-KHNTEN
           MOVE    ZERO               TO   WRK-HYOKETU-TEN
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPNUM      TO   NSRY-HOSPNUM
           MOVE    NACCT-NYUGAIKBN    TO   NSRY-NYUGAIKBN
           MOVE    NACCT-PTID         TO   NSRY-PTID
      ***  MOVE    NACCT-SRYKA        TO   NSRY-SRYKA
           MOVE    NACCT-SRYYM        TO   NSRY-SRYYM
           MOVE    NACCT-ZAINUM       TO   NSRY-ZAINUM
           MOVE    NYUINACT-REC       TO   MCPDATA-REC
           MOVE    "tbl_nyuinact"     TO   MCP-TABLE
           MOVE    "key9"             TO   MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC             =    ZERO
               MOVE    "tbl_nyuinact"     TO   MCP-TABLE
               MOVE    "key9"             TO   MCP-PATHNAME
               PERFORM 900-NYUINACT-READ-SEC
           ELSE
               MOVE    1              TO   FLG-NYUINACT
           END-IF
      *
           IF      FLG-NYUINACT        =   ZERO
      *
               MOVE      ZERO          TO  FLG-NYUKHN  
               PERFORM   VARYING  NYUINACT-IDX  FROM 1  BY  1
                 UNTIL  (FLG-NYUKHN         =   1)    OR
                        (NYUINACT-IDX       >   5)    OR
                        (NSRY-SRYCD(NYUINACT-IDX)  =  SPACE)
                     MOVE    SPACE         TO   TNS-TENSU-REC
                     INITIALIZE                 TNS-TENSU-REC
                     MOVE    NSRY-SRYCD(NYUINACT-IDX) TO   TNS-SRYCD
                     MOVE    NACCT-SRYYM        TO  TNS-YUKOSTYMD(1:6)
                     MOVE    "01"               TO  TNS-YUKOSTYMD(7:2)
                     MOVE    TNS-YUKOSTYMD      TO  TNS-YUKOEDYMD
                     PERFORM  900-TENSU-READ-SEC
                     IF       FLG-TENSU      =    ZERO
                         IF   TNS-DATAKBN    =    1
                              MOVE   TNS-TEN   TO   WRK-KHNTEN
      *                       初期加算（及び長期減算）の点数取得
      ***                     COMPUTE   WRK-KSNTEN  =  NACCT-ZAITEN
      ***                                           -  WRK-KHNTEN
      *                       看護比率基準未達時の入院基本点数の取得
                              PERFORM  20011231-GAIHAKU-NYUINKHN-SET-SEC
                              IF   WRK-GAIHAKU-KHNTEN  NOT =  ZERO
                                 MOVE   WRK-GAIHAKU-KHNTEN
                                               TO   WRK-KHNTEN
                              END-IF
                              MOVE   NYUINACT-IDX
                                               TO   NYUINACT-IDX2
      ***                     MOVE   1         TO   FLG-NYUKHN
                         ELSE
                              EVALUATE  TNS-TENSIKIBETU
                                WHEN     3
                                    MOVE  TNS-TEN  TO  WRK-KSNTEN
                                WHEN     8
                                    COMPUTE  WRK-KSNTEN = TNS-TEN * -1
                                WHEN     6
                                    MOVE  TNS-TEN  TO  WRK-HYOKETU-TEN
                              END-EVALUATE
                         END-IF
                     END-IF                  
               END-PERFORM
      *
               IF    WRK-NYUTENTTLKBN     =   920  
               AND   NYUINACT-IDX2    NOT =   ZERO
      *
                 MOVE    SPACE         TO   NYURYAKUSHO-REC
                 INITIALIZE                 NYURYAKUSHO-REC
                 MOVE    NSRY-SRYCD(NYUINACT-IDX2) 
                                       TO   NYURYAKUSHO-SRYCD
                 MOVE    NACCT-SRYYM   TO   NYURYAKUSHO-YUKOSTYMD(1:6)
                 MOVE    "01"          TO   NYURYAKUSHO-YUKOSTYMD(7:2)
                 MOVE    NYURYAKUSHO-YUKOSTYMD
                                       TO   NYURYAKUSHO-YUKOEDYMD
                 PERFORM  900-NYURYAKUSHO-READ-SEC
                 IF       FLG-NYURYAKUSHO    =    ZERO
                   MOVE     NYURYAKUSHO-RYAKUSHO
                                       TO  WRK-RYAKUSHO
                 END-IF                  
      *
               END-IF 
      *
      *        選定入院料の算定
      *
               IF    NYUINACT-IDX2          NOT   =   ZERO
      *
                 MOVE    SPACE                TO  SENTEICDCHG-REC
                 INITIALIZE                       SENTEICDCHG-REC
                 MOVE    NSRY-SRYCD(NYUINACT-IDX2)
                                              TO  SENCHG-IPNSRYCD
                 MOVE    SENTEICDCHG-REC      TO  MCPDATA-REC
                 MOVE    "tbl_senteicdchg"   TO  MCP-TABLE
                 MOVE    "key2"              TO  MCP-PATHNAME
                 PERFORM   900-DBSELECT-SEC
                 IF      MCP-RC             =    ZERO
                     MOVE    "tbl_senteicdchg"   TO  MCP-TABLE
                     MOVE    "key2"              TO  MCP-PATHNAME
                     PERFORM  900-SENTEICDCHG-READ-SEC
                 ELSE
                     MOVE    1                TO  FLG-SENTEICDCHG
                 END-IF
      *
                 IF  FLG-SENTEICDCHG   =   ZERO
      *
                    MOVE    SPACE               TO    TNS-TENSU-REC
                    INITIALIZE                        TNS-TENSU-REC
                    MOVE    SENCHG-SENTEISRYCD  TO    TNS-SRYCD
                    MOVE    NACCT-SRYYM         TO    TNS-YUKOSTYMD(1:6)
                    MOVE    "01"                TO    TNS-YUKOSTYMD(7:2)
                    MOVE    TNS-YUKOSTYMD       TO    TNS-YUKOEDYMD
                    PERFORM  900-TENSU-READ-SEC
                    IF       FLG-TENSU      =    ZERO
                       MOVE     TNS-TEN         TO    WRK-SENTEI-KHNTEN
                       COMPUTE  WRK-SENTEI-ZAITEN  =  WRK-SENTEI-KHNTEN
                                                   +  WRK-KSNTEN
                       IF     WRK-HYOKETU-TEN    NOT =   ZERO
      *                  標欠：％減算
                         COMPUTE    WRK-SENTEI-ZAITEN  =
                                  ( WRK-SENTEI-ZAITEN  -
                                   (WRK-SENTEI-ZAITEN  *
                                    (WRK-HYOKETU-TEN   /  100)))  +  0.5
                       END-IF
                    END-IF  
      *
                 END-IF
      *
                 MOVE    "tbl_senteicdchg"   TO  MCP-TABLE
                 MOVE    "key2"              TO  MCP-PATHNAME
                 PERFORM 900-CLOSE-SEC
      *
               END-IF
      *
           END-IF
      *
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           IF     WRK-HYOKETU-TEN    NOT =   ZERO
      *      標欠：％減算
             COMPUTE    WRK-KHNTEN  =
                      ( WRK-KHNTEN  -
                       (WRK-KHNTEN  *
                        (WRK-HYOKETU-TEN   /  100)))  +  0.5
           END-IF
      *
           .
       2001123-NYUINKHN-GET-EXT.
           EXIT.
      *
      **************************************************************
      *    外泊時の入院基本料取得
      **************************************************************
       20011231-GAIHAKU-NYUINKHN-SET-SEC           SECTION.
      *
           EVALUATE  TNS-SRYCD
               WHEN  "190078210"
                     MOVE  "190077410"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078310"
                     MOVE  "190077510"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078410"
                     MOVE  "190077610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078510"
                     MOVE  "190077710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078610"
                     MOVE  "190077810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078710"
                     MOVE  "190077910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078810"
                     MOVE  "190078010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078910"
                     MOVE  "190078110"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190082410"
                     MOVE  "190081710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082510"
                     MOVE  "190081810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082610"
                     MOVE  "190081910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082710"
                     MOVE  "190082010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082810"
                     MOVE  "190082110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082910"
                     MOVE  "190082210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190083010"
                     MOVE  "190082310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190084310"
                     MOVE  "190083610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084410"
                     MOVE  "190083710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084510"
                     MOVE  "190083810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084610"
                     MOVE  "190083910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084710"
                     MOVE  "190084010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084810"
                     MOVE  "190084110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084910"
                     MOVE  "190084210"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190087410"
                     MOVE  "190085910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087510"
                     MOVE  "190086010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087610"
                     MOVE  "190086110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087710"
                     MOVE  "190086210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087810"
                     MOVE  "190086310"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087910"
                     MOVE  "190086410"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088010"
                     MOVE  "190086510"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088110"
                     MOVE  "190086610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088210"
                     MOVE  "190086710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088310"
                     MOVE  "190086810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088410"
                     MOVE  "190086910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088510"
                     MOVE  "190087010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088610"
                     MOVE  "190087110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088710"
                     MOVE  "190087210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088810"
                     MOVE  "190087310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190094710"
                     MOVE  "190093710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190094810"
                     MOVE  "190093810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190094910"
                     MOVE  "190093910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190095010"
                     MOVE  "190094010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190095110"
                     MOVE  "190094110"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190797410"
                     MOVE  "190796610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797510"
                     MOVE  "190796710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797610"
                     MOVE  "190796810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797710"
                     MOVE  "190796910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797810"
                     MOVE  "190797010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797910"
                     MOVE  "190797110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190798010"
                     MOVE  "190797210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190798110"
                     MOVE  "190797310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190803510"
                     MOVE  "190802810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803610"
                     MOVE  "190802910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803710"
                     MOVE  "190803010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803810"
                     MOVE  "190803110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803910"
                     MOVE  "190803210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190804010"
                     MOVE  "190803310"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190804110"
                     MOVE  "190803410"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190091210"
                     MOVE  "190090210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190091310"
                     MOVE  "190090310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190109670"
                     MOVE  "190097010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190808870"
                     MOVE  "190805710"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190117070"
                     MOVE  "190097010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190813270"
                     MOVE  "190805710"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190117670"
                     MOVE  "190097010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190813870"
                     MOVE  "190805710"      TO   WRK-GAIHAKU-SRYCD
      *        診療所老人医療管理料
               WHEN  "190774210"
                     MOVE  "190774110"      TO   WRK-GAIHAKU-SRYCD
      *        老人性認知症疾患治療病棟入院料１
               WHEN  "190740010"
                     MOVE  "190739910"      TO   WRK-GAIHAKU-SRYCD
      *        老人性認知症疾患治療病棟入院料２
               WHEN  "190813510"
                     MOVE  "190813410"      TO   WRK-GAIHAKU-SRYCD
           END-EVALUATE
      *
           IF   (RECE200-SRYYM      >= "200604"   )
           AND  (WRK-GAIHAKU-SRYCD  = "190774110" OR
                                      "190739910" OR
                                      "190813410")
               MOVE    SPACE    TO    WRK-GAIHAKU-SRYCD
           END-IF
      *
           IF    WRK-GAIHAKU-SRYCD    NOT =   SPACE
               MOVE    SPACE         TO   TNS-TENSU-REC
               INITIALIZE                 TNS-TENSU-REC
               MOVE    WRK-GAIHAKU-SRYCD  TO  TNS-SRYCD
               MOVE    NACCT-SRYYM        TO  TNS-YUKOSTYMD(1:6)
               MOVE    "01"               TO  TNS-YUKOSTYMD(7:2)
               MOVE    TNS-YUKOSTYMD      TO  TNS-YUKOEDYMD
               PERFORM  900-TENSU-READ-SEC
               IF       FLG-TENSU      =    ZERO
                        MOVE   TNS-TEN    TO  WRK-GAIHAKU-KHNTEN
               END-IF                  
           END-IF
      *
           .
       20011231-GAIHAKU-NYUINKHN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2001126-RECE200-TENSOU23-SEC                 SECTION.
      *
                 MOVE    1          TO        KH-IDX
                 PERFORM    VARYING   ACCT-IDX   FROM   1    BY   1
                            UNTIL    ACCT-IDX   >      31
                        IF  WRK-DAY1(ACCT-IDX)     NOT =    ZERO 
                        AND ACCT-DAY(1 ACCT-IDX)   NOT =    ZERO
                            PERFORM      20011261-SRYACCT-GET-SEC
                        END-IF
                 END-PERFORM
      *
           .
       2001126-RECE200-TENSOU23-EXT.
           EXIT.
      *
      **************************************************************
      *    診療会計の入院基本料加減算点数の計算
      **************************************************************
       20011261-SRYACCT-GET-SEC           SECTION.
      *
           EVALUATE   WRK-DAY1-NYUTENTTLKBN(ACCT-IDX)
              WHEN   903
                 IF        ACCT-SRYCDTOTAL    =    190080470
                                              OR   190799670
                                              OR   190080570
                                              OR   190799770
                                              OR   190111690
                                              OR   190809090
                                              OR   190111790
                                              OR   190809190
                       COMPUTE  WRK-NYUTOKKEI2(KH-IDX)  =
                                WRK-NYUTOKKEI2(KH-IDX)  -
                             (ACCT-ZAITEN * ACCT-DAY(1 ACCT-IDX))
                    COMPUTE  RECE200-NYUTOKKEI2(KH-IDX)  =
                             RECE200-NYUTOKKEI2(KH-IDX)  -
                             (ACCT-ZAITEN * ACCT-DAY(1 ACCT-IDX))
                 ELSE
                       COMPUTE  WRK-NYUKHNKEI2(KH-IDX)  =
                                WRK-NYUKHNKEI2(KH-IDX)  +
                             (ACCT-ZAITEN * ACCT-DAY(1 ACCT-IDX))
                    COMPUTE  RECE200-NYUKHNKEI2(KH-IDX)  =
                             RECE200-NYUKHNKEI2(KH-IDX)  +
                             (ACCT-ZAITEN * ACCT-DAY(1 ACCT-IDX))
                 END-IF
              WHEN   920
                 IF        ACCT-SRYCDTOTAL    =    190080470
                                              OR   190799670
                                              OR   190080570
                                              OR   190799770
                                              OR   190111690
                                              OR   190809090
                                              OR   190111790
                                              OR   190809190
                       COMPUTE  WRK-NYUTOKKEI2(KH-IDX)  =
                                WRK-NYUTOKKEI2(KH-IDX)  -
                             (ACCT-ZAITEN * ACCT-DAY(1 ACCT-IDX))
                    COMPUTE  RECE200-NYUTOKKEI2(KH-IDX)  =
                             RECE200-NYUTOKKEI2(KH-IDX)  -
                             (ACCT-ZAITEN * ACCT-DAY(1 ACCT-IDX))
                 END-IF
           END-EVALUATE
      *
           .
       20011261-SRYACCT-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       200113-RECE200-HENSYU3-SEC                SECTION.
      *
           INITIALIZE                            NYUINACCT-REC
           MOVE    RECE200-HOSPNUM        TO      NACCT-HOSPNUM
           MOVE    RECE200-NYUGAIKBN      TO      NACCT-NYUGAIKBN
           MOVE    RECE200-PTID           TO      NACCT-PTID
      ***  MOVE    RECE200-SRYKA(IDX)     TO      NACCT-SRYKA
           MOVE    RECE200-SRYYM          TO      NACCT-SRYYM
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC
           MOVE    "tbl_nyuinacct"       TO      MCP-TABLE
           MOVE    "key7"                TO      MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "tbl_nyuinacct"   TO      MCP-TABLE
               MOVE    "key7"            TO      MCP-PATHNAME
               PERFORM  900-NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-ZAISKBKBN          =    "1"  
                 AND    NACCT-SRYCDTOTAL   NOT   =    099999916
      *
                   PERFORM  VARYING  IDY    FROM    1   BY  1
                                  UNTIL   IDY     >       31
      *
                         IF  WRK-DAY5(IDY)  =  RECE200-HKNCOMBI
                              IF   WRK-DAY1-NYUTENTTLKBN(IDY) = 903
                              AND  NACCT-ZAITEN    NOT =    ZERO  
                              AND  NACCT-DAY(IDY)  NOT =    ZERO  
                                   PERFORM   2001131-NYUINKHN-GET3-SEC
                                   MOVE    31    TO    IDY
                              END-IF
                         END-IF
                   END-PERFORM
                 END-IF
      *
                 MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
                 MOVE    "key7"              TO  MCP-PATHNAME
                 PERFORM        900-NYUINACCT-READ-SEC
              END-PERFORM
      *
           END-IF
      *
           MOVE    "tbl_nyuinacct"      TO  MCP-TABLE
           MOVE    "key7"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
      *
           INITIALIZE                            NYUINACCT-REC
           MOVE    RECE200-HOSPNUM        TO      NACCT-HOSPNUM
           MOVE    RECE200-NYUGAIKBN      TO      NACCT-NYUGAIKBN
           MOVE    RECE200-PTID           TO      NACCT-PTID
      ***  MOVE    RECE200-SRYKA(IDX)     TO      NACCT-SRYKA
           MOVE    RECE200-SRYYM          TO      NACCT-SRYYM
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC
           MOVE    "tbl_nyuinacct"       TO      MCP-TABLE
           MOVE    "key7"                TO      MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "tbl_nyuinacct"   TO  MCP-TABLE
               MOVE    "key7"            TO  MCP-PATHNAME
               PERFORM  900-NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-ZAISKBKBN    =    "6"  
      *
                   PERFORM  VARYING  IDY    FROM    1   BY  1
                                  UNTIL   IDY     >       31
      *
                       IF   WRK-DAY1(IDY) NOT =  ZERO 
                         IF   WRK-DAY5(IDY)  =  RECE200-HKNCOMBI
                              IF   (NACCT-ZAITEN    NOT =    ZERO)  
                              AND  (NACCT-DAY(IDY)  NOT =    ZERO)  
                              AND  (WRK-DAY2(IDY)  =    ZERO  OR  4)
                                   PERFORM   2001131-NYUINKHN-GET3-SEC
                                   MOVE    31    TO    IDY
                              END-IF
                         END-IF
                       END-IF
      *
                   END-PERFORM
      *
                 END-IF
      *
                 MOVE    "tbl_nyuinacct"      TO  MCP-TABLE
                 MOVE    "key7"               TO  MCP-PATHNAME
                 PERFORM        900-NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "tbl_nyuinacct"      TO  MCP-TABLE
           MOVE    "key7"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
      *+++
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE200-HOSPNUM       TO      ACCT-HOSPNUM
           MOVE    RECE200-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE200-PTID          TO      ACCT-PTID
      ***  MOVE    RECE200-SRYKA(IDX)    TO      ACCT-SRYKA
           MOVE    RECE200-SRYYM         TO      ACCT-SRYYM
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "tbl_sryacct"        TO      MCP-TABLE
           MOVE    "key33"              TO      MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_sryacct"    TO      MCP-TABLE
               MOVE    "key33"          TO      MCP-PATHNAME
               PERFORM  900-SRYACCT-READ-SEC
               PERFORM  UNTIL
                  (FLG-SRYACCT        =    1)
                       IF      ACCT-HKNCOMBI   =
                                               RECE200-HKNCOMBI
                           IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                                (ACCT-ZAIKAISU  NOT =    ZERO)
                             IF   ACCT-SRYKBN  =  "90" OR "92"  
                               PERFORM VARYING ACCT-IDX FROM 1 BY 1
                                  UNTIL    ACCT-IDX   >   31
                                  IF  WRK-DAY1(ACCT-IDX)   NOT = ZERO 
                                  AND ACCT-DAY(1 ACCT-IDX) NOT = ZERO
                                        PERFORM 2001132-ACCTKHN-GET3-SEC
                                        MOVE  31  TO  ACCT-IDX
                                  END-IF
                               END-PERFORM
                             END-IF
                           END-IF
                       END-IF
                   MOVE    "tbl_sryacct"     TO      MCP-TABLE
                   MOVE    "key33"           TO      MCP-PATHNAME
                   PERFORM   900-SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_sryacct"        TO  MCP-TABLE
           MOVE    "key33"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
           .
       200113-RECE200-HENSYU3-EXT.
           EXIT.
      *
      **************************************************************
      *    入院略称の取得
      **************************************************************
       2001131-NYUINKHN-GET3-SEC           SECTION.
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPNUM      TO   NSRY-HOSPNUM
           MOVE    NACCT-NYUGAIKBN    TO   NSRY-NYUGAIKBN
           MOVE    NACCT-PTID         TO   NSRY-PTID
      ***  MOVE    NACCT-SRYKA        TO   NSRY-SRYKA
           MOVE    NACCT-SRYYM        TO   NSRY-SRYYM
           MOVE    NACCT-ZAINUM       TO   NSRY-ZAINUM
           MOVE    NYUINACT-REC       TO   MCPDATA-REC
           MOVE    "tbl_nyuinact"     TO   MCP-TABLE
           MOVE    "key9"             TO   MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "tbl_nyuinact"   TO   MCP-TABLE
               MOVE    "key9"           TO   MCP-PATHNAME
               PERFORM  900-NYUINACT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACT  =    "1")
      *
                 PERFORM   VARYING  NYUINACT-IDX  FROM 1  BY  1
                      UNTIL  (NYUINACT-IDX       >   5)    OR
                             (NSRY-SRYCD(NYUINACT-IDX)  =  SPACE)
      *
                       MOVE    NSRY-SRYCD(NYUINACT-IDX) 
                                              TO  WRK-SRYCD
                       MOVE    NACCT-SRYYM    TO  WRK-SRYYMD-TAIHI(1:6)
                       MOVE    "01"           TO  WRK-SRYYMD-TAIHI(7:2)
                       MOVE    NACCT-SRYYM    TO  WRK-SRYYMD(1:6)
                       MOVE    "01"           TO  WRK-SRYYMD(7:2)
      *
                       PERFORM   500-RYAKUSYO-HENSYU-SEC
      *
                 END-PERFORM
      *
                 MOVE    "tbl_nyuinact"     TO   MCP-TABLE
                 MOVE    "key9"             TO   MCP-PATHNAME
                 PERFORM        900-NYUINACT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       2001131-NYUINKHN-GET3-EXT.
           EXIT.
      *
      **************************************************************
      *    入院略称の取得（診療会計）
      **************************************************************
       2001132-ACCTKHN-GET3-SEC           SECTION.
      *
           INITIALIZE                           SRYACT-REC
           MOVE    ACCT-HOSPNUM         TO      SRY-HOSPNUM
           MOVE    ACCT-NYUGAIKBN       TO      SRY-NYUGAIKBN
           MOVE    ACCT-PTID            TO      SRY-PTID
      ***  MOVE    ACCT-SRYKA           TO      SRY-SRYKA
           MOVE    ACCT-SRYYM           TO      SRY-SRYYM
           MOVE    ACCT-ZAINUM          TO      SRY-ZAINUM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "tbl_sryact"         TO      MCP-TABLE
           MOVE    "key9"               TO      MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_sryact"     TO      MCP-TABLE
               MOVE    "key9"           TO      MCP-PATHNAME
               PERFORM  900-SRYACT-READ-SEC
               PERFORM  UNTIL  FLG-SRYACT    =    1
                   PERFORM   VARYING   SRYACT-IDX  FROM  1   BY   1
                             UNTIL    (SRYACT-IDX    >   5)  OR
                                      (SRY-SRYCD(SRYACT-IDX)
                                                         =   SPACE)
      *
                       MOVE    SRY-SRYCD(SRYACT-IDX)
                                                  TO  WRK-SRYCD
                       MOVE    ACCT-SRYYM         TO  WRK-SRYYMD(1:6)
                       MOVE    "01"               TO  WRK-SRYYMD(7:2)
      *
                       PERFORM   500-RYAKUSYO-HENSYU-SEC
      *
                   END-PERFORM
                   MOVE    "tbl_sryact"      TO   MCP-TABLE
                   MOVE    "key9"            TO   MCP-PATHNAME
                   PERFORM   900-SRYACT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_sryact"        TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       2001132-ACCTKHN-GET3-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       200115-RECE200-HENSYU9-SEC                SECTION.
      *
      *     点滴薬剤（器材）まとめ処理
           PERFORM    2001151-TENTEK-MATOME-SEC
      *
           INITIALIZE    WRK-TENTEK-FLG-TABLE
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE200-HOSPNUM       TO      ACCT-HOSPNUM
           MOVE    RECE200-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE200-PTID          TO      ACCT-PTID
      ***  MOVE    RECE200-SRYKA(IDX)    TO      ACCT-SRYKA
           MOVE    RECE200-SRYYM         TO      ACCT-SRYYM
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "tbl_sryacct"        TO      MCP-TABLE
           MOVE    "key33"              TO      MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_sryacct"    TO      MCP-TABLE
               MOVE    "key33"          TO      MCP-PATHNAME
               PERFORM  900-SRYACCT-READ-SEC
               PERFORM  UNTIL
                  (FLG-SRYACCT        =    1)
                       IF      ACCT-HKNCOMBI   =
                                               RECE200-HKNCOMBI
                           MOVE   IDX1          TO   TENTEK-IDX
                           IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                                (ACCT-ZAIKAISU  NOT =    ZERO)
                               PERFORM   2001152-RECE200-TENSOU9-SEC
                           END-IF
                       END-IF
                   MOVE    "tbl_sryacct"        TO      MCP-TABLE
                   MOVE    "key33"              TO      MCP-PATHNAME
                   PERFORM   900-SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_sryacct"        TO      MCP-TABLE
           MOVE    "key33"              TO      MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
      *    療養担当手当集計
      *
           PERFORM  VARYING  IDY    FROM    1   BY  1
                     UNTIL   IDY     >     31
      *
             IF   WRK-DAY1(IDY)   NOT =   ZERO
      *
                   IF   WRK-DAY5(IDY)  =  RECE200-HKNCOMBI
                      IF  (WRK-DAY7(IDY)          NOT =  ZERO)
                      AND (WRK-DAY7-ZAITEN(IDY)   NOT =  ZERO)
                      AND (WRK-DAY2(IDY)              =  ZERO  OR  4)
                           PERFORM 2001153-RECE200-TENSOU9-RYOYO-SEC
                      END-IF
                   END-IF
             END-IF
      *
           END-PERFORM
      *
           .
       200115-RECE200-HENSYU9-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2001152-RECE200-TENSOU9-SEC                 SECTION.
      *
               IF        ACCT-SRYKBN   =    "90" OR "92" OR "95"  
                                                 OR "96" OR "97"
                   CONTINUE
               ELSE
                 IF        ACCT-SRYCDTOTAL    =    630010002
                   COMPUTE   TBL-TOTALTEN-ACCT(1) =  
                             TBL-TOTALTEN-ACCT(1) -
                             (ACCT-ZAITEN  *  
                              ACCT-ZAIKAISU)
                   COMPUTE   TBL-TOTALTEN2-ACCT(1) =  
                             TBL-TOTALTEN2-ACCT(1) -
                             (ACCT-ZAITEN  *  
                              ACCT-ZAIKAISU)
                 ELSE
                   IF        WRK-TENTEK-FLG(TENTEK-IDX 1)  =   ZERO
                       COMPUTE   TBL-TOTALTEN-ACCT(1) =  
                                 TBL-TOTALTEN-ACCT(1) +
                                 WRK-TENTEK-YKZTEN(TENTEK-IDX) +
                                 WRK-TENTEK-KIZAITEN(TENTEK-IDX)
                       COMPUTE   TBL-TOTALTEN2-ACCT(1) =  
                                 TBL-TOTALTEN2-ACCT(1) +
                                 WRK-TENTEK-YKZTEN(TENTEK-IDX) +
                                 WRK-TENTEK-KIZAITEN(TENTEK-IDX)
                       MOVE  1        TO   WRK-TENTEK-FLG(TENTEK-IDX 1)
                   END-IF
                   IF        ACCT-SRYKBN     =    "33"
                       PERFORM   20011521-TENTEK-SYUTEN-SEC
                       COMPUTE   TBL-TOTALTEN-ACCT(1) =  
                                 TBL-TOTALTEN-ACCT(1) +
                                 WRK-TENTEK-SYUTEN
                       COMPUTE   TBL-TOTALTEN2-ACCT(1) =  
                                 TBL-TOTALTEN2-ACCT(1) +
                                 WRK-TENTEK-SYUTEN
                   ELSE
                       COMPUTE   TBL-TOTALTEN-ACCT(1) =  
                                 TBL-TOTALTEN-ACCT(1) +
                                 (ACCT-ZAITEN  *  
                                  ACCT-ZAIKAISU)
                       COMPUTE   TBL-TOTALTEN2-ACCT(1) =  
                                 TBL-TOTALTEN2-ACCT(1) +
                                 (ACCT-ZAITEN  *  
                                  ACCT-ZAIKAISU)
                   END-IF
                 END-IF
               END-IF
           .
       2001152-RECE200-TENSOU9-EXT.
           EXIT.
      *
      *****************************************************************
      *    点滴注射の薬剤（器材）点数算定
      *****************************************************************
       2001151-TENTEK-MATOME-SEC                    SECTION.
      *
           INITIALIZE                  WRK-TENTEK-TABLE
      *
               INITIALIZE                  ORCSTENTEKAREA
               MOVE    "2"                 TO  ORCSTEN-KBN
               MOVE    RECE200-PTID        TO  ORCSTEN-PTID
               MOVE    RECE200-SRYYM       TO  ORCSTEN-SRYYM
               MOVE    RECE200-HKNCOMBI   TO  ORCSTEN-HKNCOMBI
               MOVE    RECE200-HOSPNUM     TO  SPA-HOSPNUM
               CALL    "ORCSTENTEK"        USING
                                           SPA-AREA
                                           ORCSTENTEKAREA
      *        薬剤点数と器材点数
               PERFORM  VARYING  IDX1    FROM    1   BY  1
                          UNTIL  IDX1     >       31
      *
                        IF  ORCSTEN-ZAITEN(IDX1)  NOT =  ZERO
                            ADD    ORCSTEN-ZAITEN(IDX1)
                                   TO  WRK-TENTEK-YKZTEN(TENTEK-IDX)
                        END-IF
               END-PERFORM
      *
               PERFORM  VARYING  IDX1    FROM    1   BY  1
                          UNTIL  IDX1     >       50
                           OR    ORCSTEN-KIZ-ZAITEN(IDX1)  =  ZERO
      *
                        MOVE    ZERO   TO   WRK-TENTEK-ZAIKAISU
                        PERFORM  VARYING  IDX2    FROM    1   BY  1
                              UNTIL   IDX2     >       31
                            ADD    ORCSTEN-KIZ-DAY(IDX1 IDX2)
                                   TO  WRK-TENTEK-ZAIKAISU
                        END-PERFORM
      *
                        COMPUTE  WRK-TENTEK-KIZAITEN(TENTEK-IDX)  =
                                 WRK-TENTEK-KIZAITEN(TENTEK-IDX)  +
                                 ( ORCSTEN-KIZ-ZAITEN(IDX1) *
                                   WRK-TENTEK-ZAIKAISU ) 
      *
               END-PERFORM
           .
       2001151-TENTEK-MATOME-EXT.
           EXIT.
      *
      *****************************************************************
      *    点滴注射の手技点数算定
      *****************************************************************
       20011521-TENTEK-SYUTEN-SEC                    SECTION.
      *
      *診療行為テーブルから診療種別区分の取得
           INITIALIZE                      SRYACT-REC
           MOVE    ACCT-HOSPNUM       TO   SRY-HOSPNUM
           MOVE    ACCT-NYUGAIKBN     TO   SRY-NYUGAIKBN
           MOVE    ACCT-PTID          TO   SRY-PTID
      ***  MOVE    ACCT-SRYKA         TO   SRY-SRYKA
           MOVE    ACCT-SRYYM         TO   SRY-SRYYM
           MOVE    ACCT-ZAINUM        TO   SRY-ZAINUM
           MOVE    SRYACT-REC         TO   MCPDATA-REC
           MOVE    "tbl_sryact"       TO   MCP-TABLE
           MOVE    "key9"             TO   MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC             =    ZERO
                 MOVE    "tbl_sryact"     TO   MCP-TABLE
                 MOVE    "key9"           TO   MCP-PATHNAME
                 PERFORM  900-SRYACT-READ-SEC
           ELSE
                 MOVE    1                TO   FLG-SRYACT
           END-IF
      *
           MOVE    ZERO                   TO   WRK-TENTEK-SYUTEN
      *
           IF   FLG-SRYACT   =    ZERO
                EVALUATE  SRY-SRYSYUKBN
                    WHEN  "330"
                    WHEN  "331"
                       COMPUTE WRK-TENTEK-SYUTEN = WRK-TENTEK-SYUTEN +
                               (ACCT-SYUTEN1 * ACCT-ZAIKAISU)
                    WHEN  "340"
                       COMPUTE WRK-TENTEK-SYUTEN = WRK-TENTEK-SYUTEN +
                               (ACCT-ZAITEN * ACCT-ZAIKAISU)
                END-EVALUATE
           END-IF
      *
           MOVE    "tbl_sryact"        TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       20011521-TENTEK-SYUTEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    療養担当手当転送
      *****************************************************************
       2001153-RECE200-TENSOU9-RYOYO-SEC               SECTION.
      *
                 COMPUTE  TBL-TOTALTEN-ACCT(1) =
                          TBL-TOTALTEN-ACCT(1) +
                          WRK-DAY7-ZAITEN(IDY)
                 COMPUTE  TBL-TOTALTEN2-ACCT(1) =
                          TBL-TOTALTEN2-ACCT(1) +
                          WRK-DAY7-ZAITEN(IDY)
           .
       2001153-RECE200-TENSOU9-RYOYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    実日数の項目転送（Ｆ００２）
      *****************************************************************
       200116-JNISSU-SET-SEC                    SECTION.
      *
      *実日数から減する
           PERFORM    VARYING    IDX    FROM   1   BY   1
                       UNTIL     IDX    >      5
             PERFORM    VARYING    IDY    FROM    1   BY   1
                         UNTIL     IDY    >      31
                IF  (TBL-JNISSU-DAY(IDX IDY)      NOT =  SPACE)
                AND (TBL-JNISSU-DAY-GEN(IDX IDY)  NOT =  SPACE)
                    MOVE  SPACE  TO  TBL-JNISSU-DAY(IDX IDY)
                END-IF
             END-PERFORM
           END-PERFORM
      *
           MOVE     1                   TO  IDX
               PERFORM    VARYING    IDY    FROM    1   BY   1
                          UNTIL      IDY    >     31
                    IF    TBL-JNISSU-DAY(IDX IDY)  NOT =  SPACE
                          ADD    1      TO    RECE200-JNISSU
                    END-IF
               END-PERFORM
      *
           PERFORM    VARYING    IDX    FROM   1   BY   1
                      UNTIL      IDX    >      5
               PERFORM    VARYING    IDY    FROM    1   BY   1
                          UNTIL      IDY    >     31
                    IF    TBL-JNISSU-DAY(IDX IDY)  NOT =  SPACE
                          MOVE   "1"    TO    RECE200-JNISSUTBL(IDY)
                    END-IF
               END-PERFORM
           END-PERFORM
      *
           PERFORM    VARYING    IDX    FROM   1   BY   1
                      UNTIL      IDX    >      10
               PERFORM    VARYING    IDY    FROM    1   BY   1
                          UNTIL      IDY    >     5
                    COMPUTE  RECE200-TOTALTEN(IDY)  = 
                             RECE200-TOTALTEN(IDY)  + 
                             WRK-NYUKHNKEI(IDX IDY)
                    COMPUTE  RECE200-TOTALTEN(IDY)  = 
                             RECE200-TOTALTEN(IDY)  + 
                             WRK-NYUTOKKEI(IDX IDY)
               END-PERFORM
           END-PERFORM
      *
           PERFORM    VARYING    IDY    FROM    1   BY   1
                          UNTIL      IDY    >     5
                    COMPUTE  RECE200-TOTALTEN(IDY)  = 
                             RECE200-TOTALTEN(IDY)  + 
                             WRK-NYUKHNKEI2(IDY)
                    COMPUTE  RECE200-TOTALTEN(IDY)  = 
                             RECE200-TOTALTEN(IDY)  + 
                             WRK-NYUTOKKEI2(IDY)
           END-PERFORM
      *
           PERFORM    VARYING    IDY    FROM    1   BY   1
                          UNTIL      IDY    >     5
                    COMPUTE  RECE200-TOTALTEN(IDY)  = 
                             RECE200-TOTALTEN(IDY)  + 
                             TBL-TOTALTEN-ACCT(IDY)
                    COMPUTE  RECE200-HENTOTALTEN(IDY)  = 
                             RECE200-HENTOTALTEN(IDY)  + 
                             TBL-TOTALTEN2-ACCT(IDY)
           END-PERFORM
      *
           PERFORM    VARYING    IDX    FROM   1   BY   1
                      UNTIL      IDX    >      10
               PERFORM    VARYING    IDY    FROM    2   BY   1
                          UNTIL      IDY    >     5
                 IF  ( RECE200-HENTOTALTEN(IDY) NOT =  ZERO       )
                 AND ( RECE200-HENTOTALTEN(1)   NOT =  
                                         RECE200-HENTOTALTEN(IDY) )
                    CONTINUE
                 ELSE
                    MOVE    ZERO    TO   RECE200-NYUKHNKEI(IDX IDY)
                    MOVE    ZERO    TO   RECE200-NYUTOKKEI(IDX IDY)
                 END-IF
               END-PERFORM
           END-PERFORM
      *
           PERFORM    VARYING    IDY    FROM    2   BY   1
                      UNTIL      IDY    >     5
                 IF  ( RECE200-HENTOTALTEN(IDY) NOT =  ZERO       )
                 AND ( RECE200-HENTOTALTEN(1)   NOT =  
                                         RECE200-HENTOTALTEN(IDY) )
                    CONTINUE
                 ELSE
                    MOVE    ZERO    TO   RECE200-NYUKHNKEI2(IDY)
                    MOVE    ZERO    TO   RECE200-NYUTOKKEI2(IDY)
                 END-IF
           END-PERFORM
      *
           PERFORM    VARYING    IDX    FROM   1   BY   1
                      UNTIL      IDX    >      10
                 IF   RECE200-NYUTOKRYO(IDX)  =  999999999
                    MOVE    ZERO    TO   RECE200-NYUTOKRYO(IDX)
                 END-IF
                 IF   RECE200-NYUTOKRYO-RYAKU(IDX)  
                                             =  "９９９９９９９"
                    MOVE    SPACE   TO   RECE200-NYUTOKRYO-RYAKU(IDX)
                 END-IF
           END-PERFORM
      *
           .
       200116-JNISSU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ更新処理（Ｆ００２）
      *****************************************************************
       200117-RECE200-REWRITE-SEC                SECTION.
      *
           REWRITE   RECE200-REC
      *
           ADD     1                   TO  CNT-MOD
      *
           .
       200117-RECE200-REWRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *         
               IF      WRK-PARA-SHELLID    NOT =   "RECEPTX"
      *            ジョブ管理終了処理
                   MOVE    "JBE"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    WRK-RECEERR     TO  JOB-YOBI
                   MOVE    "9999"          TO  JOB-ERRCD
                   PERFORM   900-CALL-ORCSJOB-SEC
               END-IF
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理中止処理
      *****************************************************************
       500-CANCEL-HENSYU-SEC                SECTION.
      *
           IF      WRK-PARA-SHELLID    =   "RECEPTX"
               CONTINUE
           ELSE
               MOVE    "CHK"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               PERFORM   900-CALL-ORCSJOB-SEC
               IF    ( SJOBKANRI-RETURN
                                       =   ZERO )
               AND   ( JOB-STOPFLG     =   1    )
                   MOVE    "処理が中止されました"
                                           TO  WRK-RECEERR
      *
                   OPEN    INPUT   RECEERR-FILE
                   IF      STS-RECEERR         =   ZERO
                       CLOSE   RECEERR-FILE
                   ELSE
                       OPEN    OUTPUT              RECEERR-FILE
      *    
                       MOVE    WRK-RECEERR         TO  RECEERR-REC
                       WRITE   RECEERR-REC
                       CLOSE   RECEERR-FILE
      *         
      *                ジョブ管理終了処理
                       MOVE    "CAN"           TO  SJOBKANRI-MODE
                       INITIALIZE                  JOBKANRI-REC
                       MOVE    WRK-RECEERR     TO  JOB-YOBI
                       MOVE    "8888"          TO  JOB-ERRCD
                       MOVE    2               TO  JOB-STOPFLG
                       PERFORM   900-CALL-ORCSJOB-SEC
                   END-IF
      *                             
                   MOVE    1                   TO  FLG-END
               END-IF
           END-IF
           .
       500-CANCEL-HENSYU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           IF      WRK-PARA-SHELLID    NOT =   "RECEPTX"
      *        ステップ管理終了処理
               MOVE    "STE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               PERFORM   900-CALL-ORCSJOB-SEC
      *
               PERFORM 900-DBDISCONNECT-SEC
           END-IF
      *
           DISPLAY "RECE200 IN  :" CNT-IN
           DISPLAY "        MOD :" CNT-MOD
           DISPLAY "*** ORCR1210 END ***"
           .
       300-TERM-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    入院略称の編集
      *****************************************************************
       500-RYAKUSYO-HENSYU-SEC                SECTION.
      *
           MOVE    SPACE         TO   NYURYAKUSHO-REC
           INITIALIZE                 NYURYAKUSHO-REC
      *
           MOVE    WRK-SRYCD     TO   NYURYAKUSHO-SRYCD
           MOVE    WRK-SRYYMD    TO   NYURYAKUSHO-YUKOSTYMD
                                      NYURYAKUSHO-YUKOEDYMD
           PERFORM  900-NYURYAKUSHO-READ-SEC
           IF       FLG-NYURYAKUSHO    =    ZERO
              MOVE     ZERO     TO    FLG-ARI
              PERFORM  VARYING  ID1    FROM    1   BY  1
                    UNTIL   ID1                   > 20
                      OR    RECE200-NYUSYUBETU(ID1) = SPACE
                      OR    FLG-ARI                = 1 
                 IF  RECE200-NYUSYUBETU(ID1)  
                            =  NYURYAKUSHO-RYAKUSHO
                     MOVE  1   TO   FLG-ARI
                 END-IF
              END-PERFORM  
              IF  FLG-ARI  =  ZERO  
                     MOVE   NYURYAKUSHO-RYAKUSHO
                               TO   RECE200-NYUSYUBETU(ID1)
              END-IF
      *
              IF   RECE200-SRYYM  >= "200604"
                CONTINUE
              ELSE
                IF   WRK-SRYCD  =  "190109670"  OR  "190808870"
      *
                 MOVE     ZERO     TO    FLG-ARI
                 PERFORM  VARYING  ID1    FROM    1   BY  1
                       UNTIL   ID1                   > 20
                         OR    RECE200-NYUSYUBETU(ID1) = SPACE
                         OR    FLG-ARI                = 1 
                    IF  RECE200-NYUSYUBETU(ID1)(1:4)   =   "有看"
                        MOVE  1   TO   FLG-ARI
                    END-IF
                 END-PERFORM  
                 IF  FLG-ARI  =  ZERO  
                        MOVE   "有看"
                                  TO   RECE200-NYUSYUBETU(ID1)(1:4)
                 END-IF
      *
                END-IF
                IF   WRK-SRYCD  =  "190117070"  OR  "190813270"
      *
                 MOVE     ZERO     TO    FLG-ARI
                 PERFORM  VARYING  ID1    FROM    1   BY  1
                       UNTIL   ID1                   > 20
                         OR    RECE200-NYUSYUBETU(ID1) = SPACE
                         OR    FLG-ARI                = 1 
                    IF  RECE200-NYUSYUBETU(ID1)(1:4)   =   "有医"
                        MOVE  1   TO   FLG-ARI
                    END-IF
                 END-PERFORM  
                 IF  FLG-ARI  =  ZERO  
                        MOVE   "有医"
                                  TO   RECE200-NYUSYUBETU(ID1)(1:4)
                 END-IF
      *
                END-IF
                IF   WRK-SRYCD  =  "190117670"  OR  "190813870"
      *
                 MOVE     ZERO     TO    FLG-ARI
                 PERFORM  VARYING  ID1    FROM    1   BY  1
                       UNTIL   ID1                   > 20
                         OR    RECE200-NYUSYUBETU(ID1) = SPACE
                         OR    FLG-ARI                = 1 
                    IF  RECE200-NYUSYUBETU(ID1)(1:6)   =   "有看医"
                        MOVE  1   TO   FLG-ARI
                    END-IF
                 END-PERFORM  
                 IF  FLG-ARI  =  ZERO  
                        MOVE   "有看医"
                                  TO   RECE200-NYUSYUBETU(ID1)(1:6)
                 END-IF
      *
                END-IF
              END-IF
           ELSE
              IF   ( RECE200-SRYYM  >= "200604"    )
              AND  ( WRK-SRYCD      = "190123250" OR
                                      "190123350" OR
                                      "190123450" OR
                                      "190123550" )
                MOVE     ZERO     TO    FLG-ARI
                PERFORM  VARYING  ID1    FROM    1   BY  1
                      UNTIL   ID1                   > 20
                        OR    RECE200-NYUSYUBETU(ID1) = SPACE
                        OR    FLG-ARI                = 1 
                   EVALUATE   WRK-SRYCD
                     WHEN     "190123250"
                      IF  RECE200-NYUSYUBETU(ID1)(1:8) = "一般経過"
                          MOVE  1   TO   FLG-ARI
                      END-IF
                     WHEN     "190123350"
                      IF  RECE200-NYUSYUBETU(ID1)(1:8) = "結核経過"
                          MOVE  1   TO   FLG-ARI
                      END-IF
                     WHEN     "190123450"
                      IF  RECE200-NYUSYUBETU(ID1)(1:8) = "精神経過"
                          MOVE  1   TO   FLG-ARI
                      END-IF
                     WHEN     "190123550"
                      IF  RECE200-NYUSYUBETU(ID1)(1:8) = "障害経過"
                          MOVE  1   TO   FLG-ARI
                      END-IF
                   END-EVALUATE
                END-PERFORM  
                IF  FLG-ARI  =  ZERO
                   EVALUATE   WRK-SRYCD
                     WHEN     "190123250"
                      MOVE   "一般経過"
                                 TO   RECE200-NYUSYUBETU(ID1)(1:8)
                     WHEN     "190123350"
                      MOVE   "結核経過"
                                 TO   RECE200-NYUSYUBETU(ID1)(1:8)
                     WHEN     "190123450"
                      MOVE   "精神経過"
                                 TO   RECE200-NYUSYUBETU(ID1)(1:8)
                     WHEN     "190123550"
                      MOVE   "障害経過"
                                 TO   RECE200-NYUSYUBETU(ID1)(1:8)
                   END-EVALUATE
                END-IF
              END-IF
           END-IF
      *
           .
       500-RYAKUSYO-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       900-NYUINACCT-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                  NYUINACCT-REC
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           .
       900-NYUINACCT-READ-EXT.
           EXIT.
      *
      **************************************************************
      *    入院診療行為マスター読込
      **************************************************************
       900-NYUINACT-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  NYUINACT-REC
               MOVE    ZERO            TO  FLG-NYUINACT
           ELSE
               INITIALIZE                  NYUINACT-REC
               MOVE    1               TO  FLG-NYUINACT
           END-IF
      *
           .
       900-NYUINACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計読込
      *****************************************************************
       900-SRYACCT-READ-SEC           SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
               MOVE    ZERO            TO  FLG-SRYACCT
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           .
       900-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為読込
      *****************************************************************
       900-SRYACT-READ-SEC           SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       900-SRYACT-READ-EXT.
           EXIT.
      *     
      *****************************************************************
      *    点数マスター読込（主キー）
      *****************************************************************
       900-TENSU-READ-SEC         SECTION.
      *
           MOVE    SPA-HOSPNUM         TO  TNS-HOSPNUM
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_tensu"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM   900-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   MOVE    1                   TO  FLG-TENSU
                   INITIALIZE                  TNS-TENSU-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-TENSU-READ-EXT.
           EXIT.
      *     
      *****************************************************************
      *    入院略称マスター読込（主キー）
      *****************************************************************
       900-NYURYAKUSHO-READ-SEC        SECTION.
      *
           MOVE     ZERO       TO    FLG-NYURYAKUSHO
      *
           PERFORM  910-NYURYAKUWRK-CHK-SEC
      *
           IF      FLG-NYURYAKUWRK     =   ZERO
               MOVE    NYURYAKUSHO-REC     TO  MCPDATA-REC
               MOVE    "tbl_nyuinryakusho" TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM   900-DBSELECT-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    "tbl_nyuinryakusho" TO  MCP-TABLE
                   MOVE    "key"               TO  MCP-PATHNAME
                   PERFORM   900-DBFETCH-SEC
                   IF      MCP-RC               =   ZERO
                       MOVE    MCPDATA-REC      TO  NYURYAKUSHO-REC
                       MOVE    ZERO             TO  FLG-NYURYAKUSHO
                       PERFORM  910-NYURYAKUWRK-HEN-SEC
                   ELSE
                       MOVE    1                TO  FLG-NYURYAKUSHO
                       INITIALIZE                   NYURYAKUSHO-REC
                   END-IF
               ELSE
                   MOVE    1                    TO  FLG-NYURYAKUSHO
                   INITIALIZE                       NYURYAKUSHO-REC
               END-IF
      *
               MOVE    "tbl_nyuinryakusho" TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-CLOSE-SEC
           END-IF
      *
           .
       900-NYURYAKUSHO-READ-EXT.
           EXIT.
      *****************************************************************
      *    入院略称マスター退避ワークチェック処理
      *****************************************************************
       910-NYURYAKUWRK-CHK-SEC               SECTION.
      *
           MOVE    ZERO                TO  FLG-NYURYAKUWRK
      *
           PERFORM VARYING WRK-NYURYAKU-IDX  FROM    1   BY  1
             UNTIL ( WRK-NYURYAKU-IDX  >   WRK-NYURYAKU-CONST-MAX ) OR
                   ( FLG-NYURYAKUWRK   =     1 )      OR
                   ( WRK-NYURYAKU-IDX  >   200 )
               IF    ( WRK-NYURYAKU-SRYCD (WRK-NYURYAKU-IDX)
                                       =   NYURYAKUSHO-SRYCD )
                 AND ( WRK-NYURYAKU-YUKOSTYMD (WRK-NYURYAKU-IDX)
                                       <=  NYURYAKUSHO-YUKOSTYMD)
                 AND ( WRK-NYURYAKU-YUKOEDYMD (WRK-NYURYAKU-IDX)
                                       >=  NYURYAKUSHO-YUKOSTYMD)
                   MOVE    1           TO  FLG-NYURYAKUWRK
                   MOVE    WRK-NYURYAKU-DATA (WRK-NYURYAKU-IDX)
                                       TO  NYURYAKUSHO-REC
               END-IF
           END-PERFORM
      *
           .
       910-NYURYAKUWRK-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院略称マスター退避ワーク編集処理
      *****************************************************************
       910-NYURYAKUWRK-HEN-SEC               SECTION.
      *
           IF    ( WRK-NYURYAKU-CONST-MAX  >   WRK-NYURYAKU-MAX )
               COMPUTE WRK-NYURYAKU-MAX    =  WRK-NYURYAKU-MAX   +   1
               MOVE    NYURYAKUSHO-SRYCD   TO  WRK-NYURYAKU-SRYCD
                                                   (WRK-NYURYAKU-MAX)
               MOVE    NYURYAKUSHO-YUKOSTYMD
                                           TO  WRK-NYURYAKU-YUKOSTYMD
                                                   (WRK-NYURYAKU-MAX)
               MOVE    NYURYAKUSHO-YUKOEDYMD
                                           TO  WRK-NYURYAKU-YUKOEDYMD
                                                   (WRK-NYURYAKU-MAX)
               MOVE    NYURYAKUSHO-REC     TO  WRK-NYURYAKU-DATA
                                                   (WRK-NYURYAKU-MAX)
           END-IF
      *
           .
       910-NYURYAKUWRK-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    選定療養マスター読込
      *****************************************************************
       900-SENTEICDCHG-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SENTEICDCHG-REC
               MOVE    ZERO            TO  FLG-SENTEICDCHG
           ELSE
               INITIALIZE                  SENTEICDCHG-REC
               MOVE    1               TO  FLG-SENTEICDCHG
           END-IF
      *
           .
       900-SENTEICDCHG-READ-EXT.
           EXIT.
      *
      **************************************************************
      *    システム管理マスタ読み込み処理
      **************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
                                           SYS-1001-REC
                                           SYS-5000-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                  SYSKANRI-REC
                                           SYS-1001-REC
                                           SYS-5000-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    中間ファイルＲＥＡＤ処理
      *****************************************************************
       900-RECE200-READ-SEC            SECTION.
      *
           READ    RECE200-FILE   NEXT
               AT  END
                   MOVE    1     TO    FLG-RECE200
               NOT  AT  END
                   ADD     1     TO    CNT-IN
                                       CNT-IN-CANCEL
      *
                   DISPLAY "RECE200 " IDZ " PTNUM=" RECE200-PTNUM     
      *
                   PERFORM 910-SYSKANRI-HENSYU-SEC
      *
           END-READ
           .
       900-RECE200-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    診療年月の対象となるシス管理を取得（個別処理のみ
      ****************************************************************
       910-SYSKANRI-HENSYU-SEC         SECTION.
      *
           IF   WRK-PARA-SRYYM    NOT =  ZERO
               CONTINUE
           ELSE
      *        医療機関ＩＤ編集
               MOVE  ZERO           TO  FLG-SET
               MOVE  RECE200-SRYYM   TO  WRK-SYS-SRYYMD(1:6)
               MOVE  "01"           TO  WRK-SYS-SRYYMD(7:2)
               PERFORM  VARYING  SYSKAN-IDX  FROM  1  BY  1
                     UNTIL  ( SYSKAN-IDX              >  100  )
                      OR    ( TBL-SYS1001(SYSKAN-IDX) = SPACE )
                      OR    ( FLG-SET                 =   1   )
      *
                 MOVE  TBL-SYS1001(SYSKAN-IDX)  TO  SYS-1001-REC
                 IF   ( SYS-1001-STYUKYMD  <=  WRK-SYS-SRYYMD    )
                 AND  ( WRK-SYS-SRYYMD     <=  SYS-1001-EDYUKYMD )
                    MOVE     1               TO    FLG-SET
                    MOVE   SYS-1001-PREFNUM  TO    WRK-PREFNUM
                 END-IF
      *
               END-PERFORM
               IF     FLG-SET  =  ZERO
                  STRING
                    "医療機関情報が取得できませんでした。診療年月＝"
                                               DELIMITED  BY  SIZE 
                       RECE200-SRYYM            DELIMITED  BY  SIZE
                                       INTO    WRK-RECEERR
                  END-STRING
                  PERFORM 500-ERR-HENSYU-SEC
                  MOVE    1              TO  FLG-RECE200
                  GO  TO  910-SYSKANRI-HENSYU-EXT
               END-IF
      *
               MOVE      RECE200-SRYYM   TO  WRK-SRYYM-5000
               PERFORM   10012-SYS-5000-CHK-SEC
      *        医療機関減算の取得（システム管理テーブルより）
               INITIALIZE                 WRK-SHOKUJIRYOYO-OCC
                                          WRK-TOKUKANRIKASAN-OCC
      *
               MOVE     ZERO      TO  FLG-MIJISI-INNAI
                                      FLG-MIJISI-IRYO
                                      FLG-MIJISI-JYOKU
      *
               MOVE     SPACE     TO  TBL-GENSAN
               INITIALIZE             TBL-GENSAN
      *
               MOVE  ZERO         TO  FLG-SET
               MOVE  RECE200-SRYYM TO  WRK-SYS-SRYYMD(1:6)
               MOVE  "01"         TO  WRK-SYS-SRYYMD(7:2)
               PERFORM  VARYING  SYSKAN-IDX  FROM  1  BY  1
                    UNTIL  ( SYSKAN-IDX              >  100  )
                     OR    ( TBL-SYS5000(SYSKAN-IDX) = SPACE )
                     OR    ( FLG-SET                 =   1   )
      *
                  MOVE  TBL-SYS5000(SYSKAN-IDX)  TO  SYS-5000-REC
                  IF   ( SYS-5000-STYUKYMD  <=  WRK-SYS-SRYYMD    )
                  AND  ( WRK-SYS-SRYYMD     <=  SYS-5000-EDYUKYMD )
                     MOVE     1       TO    FLG-SET
                     PERFORM  10011-SYSKAN-HENSYU-SEC
                     IF        WRK-SYS5000-COUNT    =     ZERO
                       CONTINUE
                     ELSE
                       PERFORM  10013-SYS-5000-GET-SEC
                     END-IF
                  END-IF
      *
               END-PERFORM
               IF     FLG-SET  =  ZERO
                  STRING
              "医療機関情報−入院基本が取得できませんでした。診療年月＝"
                                               DELIMITED  BY  SIZE 
                       RECE200-SRYYM            DELIMITED  BY  SIZE
                                       INTO    WRK-RECEERR
                  END-STRING
                  PERFORM 500-ERR-HENSYU-SEC
                  MOVE    1              TO  FLG-RECE200
                  GO  TO  910-SYSKANRI-HENSYU-EXT
               END-IF
           END-IF
      *
           .
      *
       910-SYSKANRI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-CLOSE-EXT.
           EXIT.
      *      
      *
      *****************************************************************
      *    ジョブ管理ＤＢ制御処理
      *****************************************************************
       900-CALL-ORCSJOB-SEC            SECTION.
      *
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    SPA-HOSPNUM     TO  JOB-HOSPNUM
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
                                   SPA-AREA
           .
       900-CALL-ORCSJOB-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC              =   ZERO
               CONTINUE
           ELSE
               DISPLAY "SELECT ERR table=" MCP-TABLE
                       " pathname="        MCP-PATHNAME
           END-IF
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"     USING   MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBOPEN"            TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBSTART"           TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBDISCONNECT-EXT.
           EXIT.
