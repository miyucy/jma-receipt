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
       PROGRAM-ID.             ORCBREV200404.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次統計
      *  コンポーネント名  : 入院会計一括置換（平成１６年４月）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/02/27    NACL-太田     新規作成
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
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                     PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"      REPLACING   //RECE01PARA//
                                           BY          //RECEERR//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *    ステータス領域
      *
      *    一覧
           COPY    "HCMSL55.INC".
      *
      *
       01  STS-AREA.
           03  STS-RECEERR                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-PTNUM                   PIC 9(01).
           03  FLG-NYUINACT                PIC 9(01).
           03  FLG-NYUINACCT               PIC 9(01).
           03  FLG-NYUINACCT-KEY17         PIC 9(01).
           03  FLG-TENSU                   PIC 9(01).
           03  FLG-END                     PIC 9(01).
           03  FLG-ENTRYCHK                PIC 9(01).
           03  FLG-NYUINDAY-G.
               05  FLG-NYUINDAY                PIC 9(01)
                                               OCCURS  31.
           03  FLG-TOKTEIDAY-G.
               05  FLG-TOKTEIDAY               PIC 9(01)
                                               OCCURS  31.
           03  FLG-RITO-KSN                PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE                    PIC 9(05).
           03  CNT-PAGE                    PIC 9(05).
           03  CNT-JOB-UPDCNT              PIC 9(06).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME                    PIC 9(08).
           03  SYS-YMD.
               05  SYS-YY                  PIC 9(02).
               05  SYS-MM                  PIC 9(02).
               05  SYS-DD                  PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                        PIC 9(05).
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
           03  IDX3                        PIC 9(05).
           03  IDX4                        PIC 9(05).
           03  IDX5                        PIC 9(05).
           03  IDXA                        PIC 9(05).
           03  IDXB                        PIC 9(05).
      *
      *    パラメタ領域
       01  PARA-AREA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID              PIC 9(07).
           03  WRK-PARA-SHELLID            PIC X(08).
           03  WRK-PARA-HOSPID             PIC X(24).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-ERRNO                   PIC 9(2).
           03  WRK-RECEERR                 PIC X(200).
           03  WRK-PTID                    PIC 9(10).
           03  WRK-SRYCD                   PIC 9(09).
           03  WRK-SRYYM                   PIC X(06).
           03  WRK-TNS-YMD                 PIC X(08).
           03  WRK-NAIYO                   PIC X(100).
           03  WRK-KANACHK-MAE-INPUT       PIC X(400).
           03  WRK-NACCT-ZAISKBKBN         PIC X(01).
           03  WRK-SRYKBN                  PIC X(02).
           03  WRK-ZAINUM                  PIC 9(08).
           03  WRK-NYUKHNKSNKBN-G.
               05  WRK-NYUKHNKSNKBN-MAX    PIC 9(03).
               05  WRK-NYUKHNKSNKBN-OCC    OCCURS  50.
                   07  WRK-NYUKHNKSNKBN    PIC 9(03).
                   07  WRK-NYUKHNKSNKBN-DAY
                                           PIC 9(01)
                                           OCCURS  31.
           03  WRK-DEL-SRYCD               PIC X(09).
           03  WRK-DEL-ZAI-G.
               05  WRK-DEL-ZAI-MAX         PIC 9(03).
               05  WRK-DEL-ZAI-OCC         OCCURS  50.
                   07  WRK-DEL-SRYKBN      PIC X(02).
                   07  WRK-DEL-ZAINUM      PIC 9(08).
      *
           03  WRK-INS-SRY-G.
               05  WRK-INS-SRY-MAX         PIC 9(03).
               05  WRK-INS-SRY-OCC         OCCURS  50.
                   07  WRK-INS-SRY-SRYCD   PIC X(09).
                   07  WRK-INS-SRY-TENSU   PIC S9(07)V9(03).
                   07  WRK-INS-SRY-TENSIKIBETU
                                           PIC 9(01).
           03  WRK-ZAISKBKBN               PIC X(01).
      *
           03  WRK-INS-ZAI-G.
               05  WRK-INS-ZAI-SRYCD-9     PIC 9(09).
               05  WRK-INS-ZAI-TEN         PIC S9(08).
               05  WRK-INS-ZAI-TENSU       PIC S9(08).
      *
               05  WRK-INS-ZAI-ZAITEN      PIC 9(08).
               05  WRK-INS-ZAI-ZAITEN-G    PIC 9(08).
               05  WRK-INS-ZAI-SRYCDTOTAL  PIC 9(14).
               05  WRK-INS-ZAI-SURYOUTOTAL PIC 9(07)V9(03).
               05  WRK-INS-ZAI-MEISAISU    PIC 9(07).
               05  WRK-INS-ZAI-SRYSYUKBN   PIC X(03).
               05  WRK-INS-ZAI-SRYKBN      PIC X(02).
               05  WRK-INS-ZAI-ZAINUM      PIC 9(08).
               05  WRK-INS-ZAI-KAISU       PIC 9(07).
               05  WRK-INS-ZAI-DAY         PIC 9(01)
                                           OCCURS  31.
           03  WRK-KSN-NYUKHNKSNKBN        PIC 9(03).
           03  WRK-KASAN                   PIC 9(08)V999.
           03  WRK-KASAN-ALL               PIC 9(08)V999.
           03  WRK-GENZAN                  PIC 9(08)V999.
           03  WRK-GENZAN-ALL              PIC 9(08)V999.
           03  WRK-RENNUM                  PIC 9(02).
           03  WRK-ZAIKAISU-G.
               05  WRK-ZAIKAISU-OCC        OCCURS  2.
                   07  WRK-ZAIKAISU        PIC 9(07).
                   07  WRK-ZAIKAISU-DAY    PIC 9(01)
                                           OCCURS  31.
      *
       01  KEY-AREA.
           03  KEY-HOSPID                  PIC X(24).
           03  KEY-PTID                    PIC 9(10).
           03  KEY-SRYYM                   PIC X(06).
      *
       01  LST-AREA.
           03  LST-HEAD.
               05                      PIC X(04)   VALUE   "番号".
               05                      PIC X(02)   VALUE   " ".
               05                      PIC X(20)   VALUE   "患者番号".
               05                      PIC X(02)   VALUE   " ".
               05                      PIC X(26)   VALUE   "氏名".
               05                      PIC X(01)   VALUE   " ".
               05                      PIC X(08)   VALUE   "診療年月".
               05                      PIC X(02)   VALUE   " ".
               05                      PIC X(40)   VALUE   "変更内容".
               05  LST-HEAD-PAGE       PIC Z,ZZ9.
               05                      PIC X(05)   VALUE   "頁".
      *
           03  LST-MEISAI-G.
               05  LST-MEISAI-OCC      OCCURS      54.
                   07  LST-NO          PIC Z(04).
                   07  LST-FIL1        PIC X(01).
                   07  LST-PTNUM       PIC X(20).
                   07  LST-FIL2        PIC X(01).
                   07  LST-NAME        PIC X(30).
                   07  LST-FIL3        PIC X(01).
                   07  LST-SRYYM       PIC X(08).
                   07  LST-FIL4        PIC X(01).
                   07  LST-NAIYO       PIC X(52).
      *
      *    点数マスタ退避ワーク
       01  WKTNS-AREA.
           03  WKTNS-RITO-G.
               05  WKTNS-RITO-TEN      PIC S9(07)V9(03).
               05  WKTNS-RITO-NAME     PIC X(100).
           03  WKTNS-SINSEIJI-G.
               05  WKTNS-SINSEIJI-TEN  PIC S9(07)V9(03).
               05  WKTNS-SINSEIJI-NAME PIC X(100).
      *
       01  CONST-AREA.
           03  CONST-REVYM             PIC X(06)   VALUE   "200404".
           03  CONST-REVYMD            PIC X(08)   VALUE   "20040401".
      *
           03  CONST-SINSEIJI-SRYCD    PIC 9(09)   VALUE   190109770.
           03  CONST-RITO-SRYCD        PIC 9(09)   VALUE   190117270.
           03  CONST-LST-HEAD-LINE     PIC 9(05)   VALUE   1.
           03  CONST-LST-MEISAI-MAX    PIC 9(05)   VALUE   54.
           03  CONST-INS-MSG           PIC X(10)   VALUE   "を追加".
           03  CONST-UPD-MSG           PIC X(10)   VALUE   "を変更".
           03  CONST-NYUKHNKSNKBN-MAX  PIC 9(03)   VALUE   50.
           03  CONST-DEL-ZAI-MAX       PIC 9(03)   VALUE   50.
      *
      *    入院診療会計退避ワーク
       01  WKNYUINACCT-REC.
           COPY    "CPNYUINACCT.INC"
                   REPLACING   //NACCT-//  BY //WKNACCT-//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK5000.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *
      *    入院料加算チェック
       01  NYUKSNCHK-REC.
           COPY    "CPNYUKSNCHK.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
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
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
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
      *
           PERFORM 100-DBOPEN-SEC
      *
           INITIALIZE                  PARA-AREA
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
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBREV200404"     TO  JOB-PGID
           MOVE    "入院会計一括置換"
                                       TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
           INITIALIZE                      KEY-AREA
      *
           PERFORM 1001-SYS-5000-GET-SEC
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
           .
       100-INIT-EXT.
           EXIT.
      *
           .
       110-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    入院基本情報取得
      *****************************************************************
       1001-SYS-5000-GET-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-RITO-KSN
      *
           INITIALIZE                      SYS-5000-REC
           MOVE    "5000"              TO  SYS-5000-KANRICD
           MOVE    "*"                 TO  SYS-5000-KBNCD
           MOVE    CONST-REVYMD        TO  ORC-DBYMD
           MOVE    SYS-5000-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               INITIALIZE  SYS-5000-REC
           ELSE
               MOVE    MCPDATA-REC     TO  SYS-5000-REC
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF   ( SYS-5000-KSNCD  (15) NOT =   SPACE )
            AND ( SYS-5000-KSNKBN (15)     =   "2" )
                MOVE   1               TO  FLG-RITO-KSN
           END-IF
      *
           .
       1001-SYS-5000-GET-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    点数マスタ退避ワーク編集処理
           PERFORM 2001-WKTNS-HEN-SEC
      *
      *    帳票初期処理
           PERFORM 2001-HCMSL55-INIT-SEC
      *
           MOVE    ZERO                TO  FLG-NYUINACCT
      *
           INITIALIZE                      NYUINACCT-REC
           MOVE    WRK-PARA-HOSPID     TO  NACCT-HOSPID
           MOVE    "1"                 TO  NACCT-NYUGAIKBN
           MOVE    CONST-REVYM         TO  NACCT-SRYYM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "NYUINACCT-KEY21"   TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC  NOT =   ZERO )
               MOVE    1               TO  FLG-NYUINACCT
           ELSE
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-NYUINACCT   NOT =   ZERO )
      *
               IF    ( KEY-HOSPID          NOT =   NACCT-HOSPID )
                OR   ( KEY-PTID            NOT =   NACCT-PTID )
                OR   ( KEY-SRYYM           NOT =   NACCT-SRYYM )
      *
                   MOVE    NACCT-HOSPID    TO  KEY-HOSPID
                   MOVE    NACCT-PTID      TO  KEY-PTID
                   MOVE    NACCT-SRYYM     TO  KEY-SRYYM
      *
                   IF    ( FLG-RITO-KSN    =   1 )
                       MOVE    NYUINACCT-REC   TO  WKNYUINACCT-REC
      *
      *                入院会計作成処理
                       PERFORM 2001-NYUINACCT-INS-SEC
      *
                       MOVE    WKNYUINACCT-REC TO  NYUINACCT-REC
      *
                   END-IF
      *
               END-IF
      *
      *        入院会計変更処理
               PERFORM 2001-NYUINACCT-UPD-SEC
      *
               MOVE    "NYUINACCT-KEY21"   TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC  NOT =   ZERO )
                   MOVE    1           TO  FLG-NYUINACCT
               ELSE
                   MOVE    MCPDATA-REC TO  NYUINACCT-REC
               END-IF
           END-PERFORM
      *
           MOVE    "NYUINACCT-KEY21"   TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( CNT-LINE            >   ZERO )
               PERFORM 2002-HCMSL55-PRT-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ退避ワーク編集処理
      *****************************************************************
       2001-WKTNS-HEN-SEC              SECTION.
      *
           INITIALIZE                  WKTNS-AREA
      *
      *    離島加算
           MOVE    CONST-RITO-SRYCD
                                       TO  WRK-SRYCD
           MOVE    CONST-REVYMD        TO  WRK-TNS-YMD
           PERFORM 900-TENSU-KEY-SEL-SEC
           MOVE    TNS-NAME            TO  WKTNS-RITO-NAME
           MOVE    TNS-TEN             TO  WKTNS-RITO-TEN
      *
      *    新生児入院医療管理加算
           MOVE    CONST-SINSEIJI-SRYCD
                                       TO  WRK-SRYCD
           MOVE    CONST-REVYMD        TO  WRK-TNS-YMD
           PERFORM 900-TENSU-KEY-SEL-SEC
           MOVE    TNS-NAME            TO  WKTNS-SINSEIJI-NAME
           MOVE    TNS-TEN             TO  WKTNS-SINSEIJI-TEN
      *
           .
       2001-WKTNS-HEN-EXT.
           EXIT.
      *****************************************************************
      *    帳票初期処理
      *****************************************************************
       2001-HCMSL55-INIT-SEC           SECTION.
      *
           MOVE    ZERO                TO  CNT-LINE
                                           CNT-PAGE
      *
           INITIALIZE                      LST-MEISAI-G
      *
           .
       2001-HCMSL55-INIT-EXT.
           EXIT.
      *****************************************************************
      *    入院会計作成処理
      *****************************************************************
       2001-NYUINACCT-INS-SEC          SECTION.
      *
      *    保険組合せチェック処理
           PERFORM 20011-HKNCOMBI-CHK-SEC
      *
      *    入院料算定日チェック処理
           PERFORM 20011-NYUINRYODAY-CHK-SEC
      *
           IF    ( FLG-RITO-KSN        =   1 )
      *
      *        剤存在チェック（存在すれば削除する）
               MOVE    SYS-5000-KSNCD  (15)    TO  WRK-DEL-SRYCD
               PERFORM 20011-ZAI-SONZAI-CHK-SEC
      *
      *        離島加算追加
               INITIALIZE                          WRK-INS-SRY-G
               MOVE    CONST-RITO-SRYCD        TO  WRK-INS-SRY-SRYCD (1)
               MOVE    1                       TO  WRK-INS-SRY-MAX
      *
               MOVE    "6"                     TO  WRK-NACCT-ZAISKBKBN
      *
               PERFORM 20011-ZAI-SAKUSEI-SEC
      *
               COMPUTE CNT-JOB-UPDCNT  =   CNT-JOB-UPDCNT  +   1
      *
               MOVE    WKNACCT-PTID            TO  WRK-PTID
               MOVE    WKNACCT-SRYYM           TO  WRK-SRYYM
      *
               MOVE    SPACE               TO  WRK-NAIYO
               STRING  WKTNS-RITO-NAME     DELIMITED   BY  SPACE
                       CONST-INS-MSG       DELIMITED   BY  SPACE
               INTO    WRK-NAIYO
               END-STRING
      *
               PERFORM 2002-HCMSL55-HEN-SEC
      *
           END-IF
      *
           .
       2001-NYUINACCT-INS-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せチェック処理
      *****************************************************************
       20011-HKNCOMBI-CHK-SEC          SECTION.
      *
           INITIALIZE                      FLG-NYUINDAY-G
      *
           MOVE    "5"                 TO  WRK-NACCT-ZAISKBKBN
           PERFORM 900-NYUINACCT-KEY17-SEL-SEC
      *
           PERFORM UNTIL ( FLG-NYUINACCT-KEY17 NOT =   ZERO )
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   31 )
      *
                   IF    ( NACCT-DAY(IDX0) >   ZERO )
                       MOVE    1       TO  FLG-NYUINDAY (IDX0)
                   END-IF
      *
               END-PERFORM
      *
               PERFORM 900-NYUINACCT-KEY17-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-HKNCOMBI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院料算定日チェック処理
      *****************************************************************
       20011-NYUINRYODAY-CHK-SEC       SECTION.
      *
           INITIALIZE                  FLG-TOKTEIDAY-G
                                       WRK-NYUKHNKSNKBN-G
      *
           MOVE    "1"                 TO  WRK-NACCT-ZAISKBKBN
           PERFORM 900-NYUINACCT-KEY17-SEL-SEC
      *
           PERFORM UNTIL ( FLG-NYUINACCT-KEY17 NOT =   ZERO )
      *
      *        選定入院料は無視する
               IF    ( NACCT-SRYCDTOTAL    =    099999916 )
                   CONTINUE
               ELSE
      *
      *            入院診療行為検索処理
                   PERFORM 20011-NYUINACT-SEL-SEC
      *
      *            入院基本加算区分チェック処理
                   PERFORM 20011-NYUKHNKSNKBN-CHK-SEC
      *
      *            特定入院料の算定日をチェック
                   IF    ( NACCT-SRYKBN        =   "92" )
                       PERFORM VARYING IDX0    FROM    1   BY  1
                           UNTIL ( IDX0    >   31 )
      *
                           IF    ( NACCT-DAY(IDX0) >   ZERO )
                               MOVE    1   TO  FLG-TOKTEIDAY (IDX0)
                           END-IF
      *
                       END-PERFORM
                   END-IF
               END-IF
      *
               PERFORM 900-NYUINACCT-KEY17-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-NYUINRYODAY-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為検索処理
      *****************************************************************
       20011-NYUINACT-SEL-SEC          SECTION.
      *
           INITIALIZE                      NYUINACT-REC
      *
           MOVE    NACCT-HOSPID        TO  NSRY-HOSPID
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "NYUINACT-KEY9"     TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACT-REC
           ELSE
               INITIALIZE                  NYUINACT-REC
           END-IF
      *
           MOVE    "NYUINACT-KEY9"     TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-NYUINACT-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院基本加算区分チェック処理
      *****************************************************************
       20011-NYUKHNKSNKBN-CHK-SEC      SECTION.
      *
           IF    ( WRK-NYUKHNKSNKBN-MAX    >=  CONST-NYUKHNKSNKBN-MAX )
               GO  TO  20011-NYUKHNKSNKBN-CHK-EXT
           END-IF
      *
           COMPUTE WRK-NYUKHNKSNKBN-MAX
               =   WRK-NYUKHNKSNKBN-MAX    +   1
      *
           MOVE    WRK-NYUKHNKSNKBN-MAX    TO  IDXA
      *
           MOVE    NSRY-SRYCD (1)          TO  WRK-SRYCD
           MOVE    CONST-REVYMD            TO  WRK-TNS-YMD
           PERFORM 900-TENSU-KEY-SEL-SEC
      *
           MOVE    TNS-NYUKHNKSNKBN        TO  WRK-NYUKHNKSNKBN (IDXA)
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   31 )
               IF    ( NACCT-DAY(IDX0) >   ZERO )
                   MOVE    1               TO  WRK-NYUKHNKSNKBN-DAY
                                                         (IDXA IDX0)
               END-IF
           END-PERFORM
      *
           .
       20011-NYUKHNKSNKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    剤存在チェック処理
      *****************************************************************
       20011-ZAI-SONZAI-CHK-SEC        SECTION.
      *
           INITIALIZE                  WRK-DEL-ZAI-G
      *
           MOVE    ZERO                TO  FLG-NYUINACT
           INITIALIZE                      NYUINACT-REC
           MOVE    WKNACCT-HOSPID      TO  NSRY-HOSPID
           MOVE    WKNACCT-NYUGAIKBN   TO  NSRY-NYUGAIKBN
           MOVE    WKNACCT-PTID        TO  NSRY-PTID
           MOVE    WKNACCT-SRYYM       TO  NSRY-SRYYM
           MOVE    WRK-DEL-SRYCD       TO  NSRY-SRYCD (1)
                                           NSRY-SRYCD (2)
                                           NSRY-SRYCD (3)
                                           NSRY-SRYCD (4)
                                           NSRY-SRYCD (5)
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "NYUINACT-KEY7"     TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACT
               INITIALIZE                  NYUINACT-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-NYUINACT    NOT =   ZERO )
      *
               PERFORM VARYING IDX3    FROM    1   BY  1
                       UNTIL ( IDX3    >   WRK-DEL-ZAI-MAX )
                         OR  ( WRK-DEL-ZAINUM (IDX3)
                                       =   NSRY-ZAINUM )
                   CONTINUE
               END-PERFORM
      *
               IF    ( IDX3         >   WRK-DEL-ZAI-MAX )
                   IF    ( CONST-DEL-ZAI-MAX
                                    >   WRK-DEL-ZAI-MAX )
                       COMPUTE WRK-DEL-ZAI-MAX
                           =   WRK-DEL-ZAI-MAX +   1
      *
                       MOVE    NSRY-ZAINUM
                           TO  WRK-DEL-ZAINUM (WRK-DEL-ZAI-MAX)
                       MOVE    NSRY-SRYKBN
                           TO  WRK-DEL-SRYKBN (WRK-DEL-ZAI-MAX)
      *
                   END-IF
               END-IF
      *
               MOVE    "NYUINACT-KEY7" TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC              =   ZERO )
                   MOVE    MCPDATA-REC TO  NYUINACT-REC
               ELSE
                   MOVE    1           TO  FLG-NYUINACT
                   INITIALIZE              NYUINACT-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "NYUINACT-KEY7"     TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   WRK-DEL-ZAI-MAX )
      *
               MOVE    WRK-DEL-SRYKBN (IDX2)
                                       TO  WRK-SRYKBN
               MOVE    WRK-DEL-ZAINUM (IDX2)
                                       TO  WRK-ZAINUM
      *
      *        入院診療行為削除
               PERFORM 20011-NYUINACT-DEL-SEC
      *
      *        入院会計削除
               PERFORM 20011-NYUINACCT-DEL-SEC
      *
           END-PERFORM
      *
           .
       20011-ZAI-SONZAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為削除処理
      *****************************************************************
       20011-NYUINACT-DEL-SEC          SECTION.
      *
           INITIALIZE                      NYUINACT-REC
      *
           MOVE    WKNACCT-HOSPID      TO  NSRY-HOSPID
           MOVE    WKNACCT-NYUGAIKBN   TO  NSRY-NYUGAIKBN
           MOVE    WKNACCT-PTID        TO  NSRY-PTID
           MOVE    WKNACCT-SRYKA       TO  NSRY-SRYKA
           MOVE    WKNACCT-SRYYM       TO  NSRY-SRYYM
           MOVE    WKNACCT-ZAINUM      TO  NSRY-ZAINUM
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "NYUINACT-DEL11"    TO  ORC-DBPATH
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    3               TO  WRK-ERRNO
               PERFORM 2002-NYUINACT-ERR-HEN-SEC
               MOVE    "入院診療行為の削除に失敗しました"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       20011-NYUINACT-DEL-EXT.
           EXIT.
      *****************************************************************
      *    入院会計削除処理
      *****************************************************************
       20011-NYUINACCT-DEL-SEC         SECTION.
      *
           INITIALIZE                      NYUINACCT-REC
      *
           MOVE    WKNACCT-KEY         TO  NACCT-KEY
           MOVE    WRK-SRYKBN          TO  NACCT-SRYKBN
           MOVE    WRK-ZAINUM          TO  NACCT-ZAINUM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "NYUINACCT-KEY"     TO  ORC-DBPATH
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    2               TO  WRK-ERRNO
               PERFORM 2002-NYUINACCT-ERR-HEN-SEC
               MOVE    "入院会計の削除に失敗しました"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       20011-NYUINACCT-DEL-EXT.
           EXIT.
      *****************************************************************
      *    剤作成処理
      *****************************************************************
       20011-ZAI-SAKUSEI-SEC           SECTION.
      *
           INITIALIZE                      WRK-INS-ZAI-G
                                           WRK-ZAIKAISU-G
      *
      *    点数計算処理
           PERFORM 20011-TEUNSU-KEISAN-SEC
      *
      *    剤回数編集処理
           PERFORM 20011-ZAIKAISU-HEN-SEC
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL ( IDXB    >   2 )
      *
               IF    ( IDXB        =   2 )
                   MOVE    "920"       TO  WRK-INS-ZAI-SRYSYUKBN
                   MOVE    "92"        TO  WRK-INS-ZAI-SRYKBN
               ELSE
                   MOVE    "900"       TO  WRK-INS-ZAI-SRYSYUKBN
                   MOVE    "90"        TO  WRK-INS-ZAI-SRYKBN
               END-IF
      *
               IF    ( WRK-ZAIKAISU (IDXB) >   ZERO )
      *
      *            剤番号取得処理
                   PERFORM 20011-ZAINUM-SET-SEC
      *
      *            入院会計作成処理
                   MOVE    WRK-ZAIKAISU (IDXB) TO  WRK-INS-ZAI-KAISU
                   PERFORM VARYING IDX0    FROM    1   BY  1
                               UNTIL ( IDX0    >   31 )
                       MOVE    WRK-ZAIKAISU-DAY (IDXB IDX0)
                                               TO  WRK-INS-ZAI-DAY(IDX0)
                   END-PERFORM
                   PERFORM 20011-NYUINACCT-INS-SEC
      *
      *            入院診療行為追加処理
                   PERFORM 20011-NYUINACT-INS-SEC
               END-IF
      *
           END-PERFORM
      *
           .
       20011-ZAI-SAKUSEI-EXT.
           EXIT.
      *****************************************************************
      *   剤回数編集処理
      *****************************************************************
       20011-ZAIKAISU-HEN-SEC          SECTION.
      *
           MOVE    WRK-INS-SRY-SRYCD (1)
                                       TO  WRK-SRYCD
           MOVE    CONST-REVYMD        TO  WRK-TNS-YMD
           PERFORM 900-TENSU-KEY-SEL-SEC
           MOVE    TNS-NYUKHNKSNKBN    TO  WRK-KSN-NYUKHNKSNKBN
      *
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4    >   WRK-NYUKHNKSNKBN-MAX )
      *
               INITIALIZE                  NYUKSNCHK-REC
               MOVE    WRK-NYUKHNKSNKBN (IDX4)
                                       TO  NYUKSNCHK-NYUINKBN
               MOVE    WRK-KSN-NYUKHNKSNKBN
                                       TO  NYUKSNCHK-KSNKBN
               MOVE    CONST-REVYMD    TO  ORC-DBYMD
               MOVE    NYUKSNCHK-REC   TO  MCPDATA-REC
               MOVE    "NYUKSNCHK-KEY" TO  ORC-DBPATH
               PERFORM 910-DBSELECT-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  NYUKSNCHK-REC
               ELSE
                   INITIALIZE              NYUKSNCHK-REC
               END-IF
      *
               MOVE    "NYUKSNCHK-KEY" TO  ORC-DBPATH
               PERFORM 910-DBCLOSE-SEC
      *
               IF    ( NYUKSNCHK-CHKKBN    =   "1" OR  "2" )
                   PERFORM VARYING IDX1    FROM    1   BY  1
                           UNTIL ( IDX1    >   31 )
                       IF    ( WRK-NYUKHNKSNKBN-DAY (IDX4 IDX1)
                                                           >   ZERO )
                           IF    ( FLG-TOKTEIDAY (IDX1)    =   ZERO )
                               COMPUTE WRK-ZAIKAISU (1)
                                   =   WRK-ZAIKAISU (1)
                                   +   1
                               MOVE    1    TO  WRK-ZAIKAISU-DAY(1 IDX1)
                           ELSE
                               COMPUTE WRK-ZAIKAISU (2)
                                   =   WRK-ZAIKAISU (2)
                                   +   1
                               MOVE    1    TO  WRK-ZAIKAISU-DAY(2 IDX1)
                           END-IF
                       END-IF
                   END-PERFORM
               END-IF
           END-PERFORM
      *
           .
       20011-ZAIKAISU-HEN-EXT.
           EXIT.
      *****************************************************************
      *   剤番号取得処理
      *****************************************************************
       20011-ZAINUM-SET-SEC          SECTION.
      *
      *    患者マスターより、最終剤番号を再番し、患者マスターを更新する
           MOVE    WKNACCT-PTID        TO  WRK-PTID
           PERFORM 900-PTINF-KEY-SEL-SEC
           IF    ( FLG-PTINF           =   1 )
               MOVE    4               TO  WRK-ERRNO
               PERFORM 2002-PTINF-ERR-HEN-SEC
               MOVE    "患者情報の検索に失敗しました"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    最大剤番号
           IF    ( PTINF-MAXZAINUM     =   ALL "9" )
               MOVE    ZERO            TO  PTINF-MAXZAINUM
           END-IF
      *
           COMPUTE PTINF-MAXZAINUM
               =   PTINF-MAXZAINUM     +   1
      *
           MOVE    PTINF-MAXZAINUM     TO  WRK-INS-ZAI-ZAINUM
      *
           MOVE    SMCNDATE-YMD        TO  PTINF-UPYMD
           MOVE    SMCNDATE-HMS        TO  PTINF-UPHMS
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBUPDATE-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    5               TO  WRK-ERRNO
               PERFORM 2002-PTINF-ERR-HEN-SEC
               MOVE    "患者情報の更新に失敗しました"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF 
      *
           .
      *
       20011-ZAINUM-SET-EXT.
           EXIT.
      *****************************************************************
      *    点数計算処理
      *****************************************************************
       20011-TEUNSU-KEISAN-SEC         SECTION.
      *
           PERFORM VARYING IDX5    FROM    1   BY  1
                   UNTIL ( IDX5    >   WRK-INS-SRY-MAX )
      *
               MOVE    WRK-INS-SRY-SRYCD (IDX5)
                                       TO  WRK-SRYCD
               MOVE    CONST-REVYMD    TO  WRK-TNS-YMD
               PERFORM 900-TENSU-KEY-SEL-SEC
      *
               MOVE    TNS-TENSIKIBETU TO  WRK-INS-SRY-TENSIKIBETU(IDX5)
               MOVE    TNS-TEN         TO  WRK-INS-SRY-TENSU      (IDX5)
      *
      *        労災のコード
               IF    ( TNS-SRYCD       =   "101" )
      *
      *            金額を点数へ置換える
                   IF    ( TNS-TENSIKIBETU     =   1 )
                       COMPUTE WRK-INS-SRY-TENSU (IDX5)
                           =   TNS-TEN /   10
                   END-IF
               END-IF
      *
           END-PERFORM
      *
      *    点数算定
           PERFORM VARYING     IDX5    FROM    1   BY  1
                   UNTIL      (IDX5    >   WRK-INS-SRY-MAX )
      *
      *        点数集計
               EVALUATE    WRK-INS-SRY-TENSIKIBETU (IDX5)
      *        ％加算・減算
               WHEN    5
               WHEN    6
                   CONTINUE
      *        点数（マイナス）
               WHEN    8
                   COMPUTE WRK-INS-ZAI-ZAITEN-G
                       =   WRK-INS-ZAI-ZAITEN-G
                       +   WRK-INS-SRY-TENSU (IDX5)
      *        点数
               WHEN    OTHER
                   COMPUTE WRK-INS-ZAI-ZAITEN
                       =   WRK-INS-ZAI-ZAITEN
                       +   WRK-INS-SRY-TENSU (IDX5)
               END-EVALUATE
      *
      *        各集計
               MOVE    WRK-INS-SRY-SRYCD (IDX5)
                                       TO  WRK-INS-ZAI-SRYCD-9
               COMPUTE WRK-INS-ZAI-SRYCDTOTAL
                   =   WRK-INS-ZAI-SRYCDTOTAL
                   +   WRK-INS-ZAI-SRYCD-9
               COMPUTE WRK-INS-ZAI-MEISAISU
                   =   WRK-INS-ZAI-MEISAISU    +   1
               COMPUTE WRK-INS-ZAI-SURYOUTOTAL
                   =   WRK-INS-ZAI-SURYOUTOTAL +   1
      *
           END-PERFORM
      *
      *    点数集計処理
           MOVE    ZERO                TO  WRK-KASAN
           MOVE    ZERO                TO  WRK-KASAN-ALL
           MOVE    ZERO                TO  WRK-GENZAN
           MOVE    ZERO                TO  WRK-GENZAN-ALL
           PERFORM VARYING     IDX5    FROM    1   BY  1
                   UNTIL      (IDX5    >   WRK-INS-SRY-MAX )
      *
               EVALUATE    WRK-INS-SRY-TENSIKIBETU (IDX5)
      *        ％加算
               WHEN    5
                   COMPUTE WRK-KASAN       =   WRK-INS-ZAI-ZAITEN
                                           *   WRK-INS-SRY-TENSU (IDX5)
                                           /   100
                                           +   0.5
      *
                   COMPUTE WRK-KASAN-ALL   =   WRK-KASAN-ALL
                                           +   WRK-KASAN
      *        ％減算
               WHEN    6
                   COMPUTE WRK-GENZAN      =   WRK-INS-ZAI-ZAITEN
                                           *   WRK-INS-SRY-TENSU (IDX5)
                                           /   100
                                           +   0.5
                   COMPUTE WRK-GENZAN-ALL  =   WRK-GENZAN-ALL
                                           +   WRK-GENZAN
               END-EVALUATE
           END-PERFORM
      *
      *    点数計算
           COMPUTE WRK-INS-ZAI-ZAITEN  =   WRK-INS-ZAI-ZAITEN
                                       +   WRK-KASAN-ALL
                                       -   WRK-GENZAN-ALL
                                       -   WRK-INS-ZAI-ZAITEN-G
      *
           .
       20011-TEUNSU-KEISAN-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為作成処理
      *****************************************************************
       20011-NYUINACT-INS-SEC          SECTION.
      *
           MOVE    ZERO            TO  WRK-RENNUM
           MOVE    ZERO            TO  IDX1
      *
           PERFORM UNTIL ( IDX1    >=  WRK-INS-SRY-MAX )
      *
               COMPUTE WRK-RENNUM  =   WRK-RENNUM  +   1
      *
               INITIALIZE                      NYUINACT-REC
      *
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   5 )
                        OR   ( IDX1    >=  WRK-INS-SRY-MAX )
      *
                   COMPUTE IDX1    =   IDX1    +   1
      *
                   MOVE    WRK-INS-SRY-SRYCD (IDX1)
                                           TO  NSRY-SRYCD (IDX2)
                   MOVE    1               TO  NSRY-SRYSURYO (IDX2)
      *
               END-PERFORM
      *
               MOVE    WKNACCT-HOSPID      TO  NSRY-HOSPID
               MOVE    WKNACCT-NYUGAIKBN   TO  NSRY-NYUGAIKBN
               MOVE    WKNACCT-PTID        TO  NSRY-PTID
               MOVE    WKNACCT-SRYKA       TO  NSRY-SRYKA
               MOVE    WKNACCT-SRYYM       TO  NSRY-SRYYM
      *
      *        剤番号
               MOVE    WRK-INS-ZAI-ZAINUM  TO  NSRY-ZAINUM
      *
      *        連番号
               MOVE    WRK-RENNUM          TO  NSRY-RENNUM
      *
               MOVE    WRK-INS-ZAI-SRYSYUKBN
                                           TO  NSRY-SRYSYUKBN
               MOVE    WRK-INS-ZAI-SRYKBN
                                           TO  NSRY-SRYKBN
      *
               MOVE    SMCNDATE-YMD        TO  NSRY-CREYMD
               MOVE    SMCNDATE-YMD        TO  NSRY-UPYMD
               MOVE    SMCNDATE-HMS        TO  NSRY-UPHMS
      *
               MOVE    NYUINACT-REC        TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "NYUINACT-KEY"      TO  ORC-DBPATH
               PERFORM 910-DBINSERT-SEC
               IF    ( MCP-RC  NOT =   ZERO )
                   MOVE    6               TO  WRK-ERRNO
                   PERFORM 2002-NYUINACT-ERR-HEN-SEC
                   MOVE    "入院診療行為の追加に失敗しました"
                                           TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
               END-IF
      *
           END-PERFORM
      *
           .
       20011-NYUINACT-INS-EXT.
           EXIT.
      *****************************************************************
      *    入院会計作成処理
      *****************************************************************
       20011-NYUINACCT-INS-SEC         SECTION.
      *
           INITIALIZE                      NYUINACCT-REC
      *
           MOVE    WKNACCT-HOSPID      TO  NACCT-HOSPID
           MOVE    WKNACCT-NYUGAIKBN   TO  NACCT-NYUGAIKBN
           MOVE    WKNACCT-PTID        TO  NACCT-PTID
           MOVE    WKNACCT-SRYKA       TO  NACCT-SRYKA
           MOVE    WKNACCT-SRYYM       TO  NACCT-SRYYM
           MOVE    WRK-INS-ZAI-SRYKBN  TO  NACCT-SRYKBN
           MOVE    WRK-INS-ZAI-ZAINUM  TO  NACCT-ZAINUM
           MOVE    ZERO                TO  NACCT-HKNCOMBI
      *    剤識別区分
           MOVE    WRK-NACCT-ZAISKBKBN TO  NACCT-ZAISKBKBN
      *    剤点数
           MOVE    WRK-INS-ZAI-ZAITEN  TO  NACCT-ZAITEN
      *    診療コード計
           MOVE    WRK-INS-ZAI-SRYCDTOTAL
                                       TO  NACCT-SRYCDTOTAL
      *    数量計
           MOVE    WRK-INS-ZAI-SURYOUTOTAL
                                       TO  NACCT-SURYOUTOTAL
      *    明細数
           MOVE    WRK-INS-ZAI-MEISAISU
                                       TO  NACCT-MEISAISU
      *    手技点数１
           MOVE    WRK-INS-ZAI-ZAITEN  TO  NACCT-SYUTEN1
      *    手技点数２
           MOVE    ZERO                TO  NACCT-SYUTEN2
      *    薬剤点数
           MOVE    ZERO                TO  NACCT-YKZTEN
      *    器材点数
           MOVE    ZERO                TO  NACCT-KIZAITEN
      *
           MOVE    WRK-INS-ZAI-KAISU   TO  NACCT-ZAIKAISU
      *
      *    回数セット
           PERFORM VARYING IDX0   FROM     1   BY  1
                   UNTIL ( IDX0   >   31 )
      *
               MOVE    WRK-INS-ZAI-DAY (IDX0)
                                       TO  NACCT-DAY (IDX0)
      *
           END-PERFORM
      *
           MOVE    SMCNDATE-YMD        TO  NACCT-CREYMD
           MOVE    SMCNDATE-YMD        TO  NACCT-UPYMD
           MOVE    SMCNDATE-HMS        TO  NACCT-UPHMS
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "NYUINACCT-KEY"     TO  ORC-DBPATH
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    7               TO  WRK-ERRNO
               PERFORM 2002-NYUINACCT-ERR-HEN-SEC
               MOVE    "入院会計の追加に失敗しました"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       20011-NYUINACCT-INS-EXT.
           EXIT.
      *****************************************************************
      *    入院会計変更処理
      *****************************************************************
       2001-NYUINACCT-UPD-SEC          SECTION.
      *
      *    新生児入院医療管理加算の点数を変更
           IF    ( NACCT-SRYCDTOTAL    =   CONST-SINSEIJI-SRYCD )
      *
               PERFORM 2001-SINSEIJI-UPD-SEC
               GO  TO  2001-NYUINACCT-UPD-EXT
           END-IF
      *
           .
       2001-NYUINACCT-UPD-EXT.
           EXIT.
      *****************************************************************
      *    新生児入院医療管理加算変更処理
      *****************************************************************
       2001-SINSEIJI-UPD-SEC           SECTION.
      *
           MOVE    WKTNS-SINSEIJI-TEN  TO  NACCT-ZAITEN
                                           NACCT-SYUTEN1
      *
           MOVE    SMCNDATE-YMD        TO  NACCT-UPYMD
           MOVE    SMCNDATE-HMS        TO  NACCT-UPHMS
      *
      *    入院会計更新
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "NYUINACCT-KEY"     TO  ORC-DBPATH
           PERFORM 910-DBUPDATE-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  WRK-ERRNO
               PERFORM 2002-NYUINACCT-ERR-HEN-SEC
               MOVE    "入院会計の更新に失敗しました"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           COMPUTE CNT-JOB-UPDCNT  =   CNT-JOB-UPDCNT  +   1
      *
           MOVE    NACCT-PTID          TO  WRK-PTID
           MOVE    NACCT-SRYYM         TO  WRK-SRYYM
      *
           MOVE    SPACE               TO  WRK-NAIYO
           STRING  WKTNS-SINSEIJI-NAME DELIMITED   BY  SPACE
                   CONST-UPD-MSG       DELIMITED   BY  SPACE
           INTO    WRK-NAIYO
           END-STRING
      *
           PERFORM 2002-HCMSL55-HEN-SEC
      *
           .
       2001-SINSEIJI-UPD-EXT.
           EXIT.
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       2002-HCMSL55-HEN-SEC            SECTION.
      *
           COMPUTE CNT-LINE    =   CNT-LINE    +   1
      *
      *    患者情報検索
           PERFORM 900-PTINF-KEY-SEL-SEC
      *
      *    患者番号検索
           PERFORM 900-PTNUM-KEY-SEL-SEC
      *
           MOVE    CNT-JOB-UPDCNT      TO  LST-NO    (CNT-LINE)
           MOVE    PTNUM-PTNUM         TO  LST-PTNUM (CNT-LINE)
      *
           MOVE    PTINF-NAME          TO  WRK-KANACHK-MAE-INPUT
           PERFORM 800-ENRTRY-CHK-SEC
           IF    ( FLG-ENTRYCHK        =   2 )
               MOVE    ALL "　"        TO  LST-NAME  (CNT-LINE)
               STRING  PTINF-NAME          DELIMITED   BY  SPACE
               INTO    LST-NAME  (CNT-LINE)
               END-STRING
           ELSE
               MOVE    PTINF-NAME      TO  LST-NAME  (CNT-LINE)
           END-IF
      *
           MOVE    WRK-SRYYM           TO  LST-SRYYM (CNT-LINE)
           MOVE    WRK-NAIYO           TO  LST-NAIYO (CNT-LINE)
      *
           IF    ( CNT-LINE            >=  CONST-LST-MEISAI-MAX )
               PERFORM 2002-HCMSL55-PRT-SEC
           END-IF
      *
           .
       2002-HCMSL55-HEN-EXT.
           EXIT.
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       2002-HCMSL55-PRT-SEC            SECTION.
      *
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   1
      *
           MOVE    CNT-PAGE            TO  LST-HEAD-PAGE
           MOVE    LST-HEAD            TO  HCMSL55-MOJI (1)
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   CONST-LST-MEISAI-MAX )
      *
               MOVE    LST-MEISAI-OCC (IDX0)
                                       TO  HCMSL55-MOJI
                                          (IDX0 + CONST-LST-HEAD-LINE)
      *
           END-PERFORM
      *
           PERFORM 290-PRINT-SEC
      *
           MOVE    ZERO                TO  CNT-LINE
      *
           INITIALIZE                      LST-MEISAI-G
      *
           .
       2002-HCMSL55-PRT-EXT.
           EXIT.
      *****************************************************************
      *    入院会計エラー編集処理
      *****************************************************************
       2002-NYUINACCT-ERR-HEN-SEC      SECTION.
      *
           DISPLAY "*** NYUINACCT ERR[" WRK-ERRNO "]***"
           DISPLAY "KEY[" NACCT-KEY "]"
           DISPLAY "************************"
      *
           .
       2002-NYUINACCT-ERR-HEN-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為エラー編集処理
      *****************************************************************
       2002-NYUINACT-ERR-HEN-SEC      SECTION.
      *
           DISPLAY "*** NYUINACT ERR[" WRK-ERRNO "]***"
           DISPLAY "KEY[" NSRY-KEY "]"
           DISPLAY "************************"
      *
           .
       2002-NYUINACT-ERR-HEN-EXT.
           EXIT.
      *****************************************************************
      *    患者情報エラー編集処理
      *****************************************************************
       2002-PTINF-ERR-HEN-SEC          SECTION.
      *
           DISPLAY "*** PTINF ERR[" WRK-ERRNO "]***"
           DISPLAY "PTID[" PTINF-PTID "]"
           DISPLAY "************************"
      *
           .
       2002-PTINF-ERR-HEN-EXT.
           EXIT.
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       290-PRINT-SEC                   SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"           TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  SPRT-TBL-GROUP
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID 
                                   TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                   TO  SPRT-PRIORITY
           MOVE   "HCMSL55.red"    TO  SPRT-PRTID
           MOVE    "入院会計一括置換"
                                    TO  SPRT-TITLE
           MOVE    HCMSL55          TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID
                                    TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID
                                    TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM
                                    TO  SPRT-PRTNM
           MOVE    "1"              TO  SPRT-SITEKBN
           CALL    "ORCSPRT"            USING
                                        ORCSPRTAREA
           IF      SPRT-RETURN          =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                        TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       290-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
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
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC              SECTION.
      *
           OPEN    OUTPUT      RECEERR-FILE
      *
           MOVE    WRK-RECEERR     TO  RECEERR-REC
           WRITE   RECEERR-REC
           CLOSE   RECEERR-FILE
      *
      *    ジョブ管理終了処理
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
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           STOP RUN
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    全角半角混在チェック
      *****************************************************************
       800-ENRTRY-CHK-SEC              SECTION.
      *
           MOVE    ZERO                TO  FLG-ENTRYCHK
      *
           IF  ( WRK-KANACHK-MAE-INPUT =   SPACE )
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
           MOVE    SPACE               TO  ORCSKANACHKAREA
           INITIALIZE                      ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-KANACHK-MAE-INPUT
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    NOT =   ZERO )
               MOVE    9               TO  FLG-ENTRYCHK
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
      *
      *    全角文字の場合、間に半角スペースがなかったかチェック
           IF    ( KANACHK-SYUBETU     =   2  )
            AND  ( KANACHK-RC2         =   8  )
               MOVE    9               TO  FLG-KANACHK
           ELSE
               MOVE    KANACHK-SYUBETU TO  FLG-KANACHK
           END-IF
      *
           .
       800-ENRTRY-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院会計検索処理（ＫＥＹ１７）
      *****************************************************************
       900-NYUINACCT-KEY17-SEL-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-NYUINACCT-KEY17
           INITIALIZE                      NYUINACCT-REC
           MOVE    WKNACCT-HOSPID      TO  NACCT-HOSPID
           MOVE    WKNACCT-PTID        TO  NACCT-PTID
           MOVE    WKNACCT-SRYYM       TO  NACCT-SRYYM
           MOVE    WRK-NACCT-ZAISKBKBN TO  NACCT-ZAISKBKBN
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT-KEY17
               INITIALIZE                  NYUINACCT-REC
           END-IF
      *
           .
       900-NYUINACCT-KEY17-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院会計読み込み処理（ＫＥＹ１７）
      *****************************************************************
       900-NYUINACCT-KEY17-READ-SEC    SECTION.
      *
           MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT-KEY17
               INITIALIZE                  NYUINACCT-REC
           END-IF
      *
           .
       900-NYUINACCT-KEY17-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者番号取得処理
      *****************************************************************
       900-PTNUM-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNUM
           INITIALIZE                      PTNUM-REC
           MOVE    WRK-PARA-HOSPID     TO  PTNUM-HOSPID
           MOVE    WRK-PTID            TO  PTNUM-PTID
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNUM-REC
           ELSE
               MOVE    1               TO  FLG-PTNUM
               INITIALIZE                  PTNUM-REC
           END-IF
      *
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
      *
       900-PTNUM-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    患者情報取得処理
      *****************************************************************
       900-PTINF-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PTINF
           INITIALIZE                      PTINF-REC
           MOVE    WRK-PARA-HOSPID     TO  PTINF-HOSPID
           MOVE    WRK-PTID            TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PTINF-REC
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
      *
       900-PTINF-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理(KEY1)
      *****************************************************************
       900-TENSU-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
      *
           INITIALIZE                      TNS-TENSU-REC
           MOVE    WRK-SRYCD           TO  TNS-SRYCD
           MOVE    WRK-TNS-YMD         TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
      *
           ELSE
               MOVE    1               TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
      *
       900-TENSU-KEY-SEL-EXT.
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
       900-DBDISCONNECT-EXT.
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
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ変更
      *****************************************************************
       910-DBUPDATE-SEC                SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ追加
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ削除
      *****************************************************************
       910-DBDELETE-SEC                SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
