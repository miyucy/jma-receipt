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
       PROGRAM-ID.             ORCBPRVPRT.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : プレビューDBからの印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/08/01    NACL-藤原   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE        ASSIGN  RECEERR
                                       FILE    STATUS  IS  STS-RECEERR.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                 PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"  REPLACING  //RECE01PARA//
                                       BY         //RECEERR//.
           03  FILLER                  PIC X(04)   VALUE   ".dat".
      *
      *    一覧
           COPY    "HCMSL80.INC".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-OUT                 PIC X(02).
           03  STS-PTHKN               PIC X(02).
           03  STS-ERR                 PIC X(02).
           03  STS-RECLST              PIC X(02).
           03  STS-RECEERR             PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-PTNUM               PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-SRYKARRK            PIC 9(01).
      *
           03  FLG-CHK                 PIC 9(01).
           03  FLG-ERR                 PIC 9(01).
           03  FLG-ERR3                PIC 9(01).
           03  FLG-HOJOKBN             PIC 9(01).
           03  FLG-OK                  PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PTHKNINF            PIC 9(06).
           03  CNT-UPD                 PIC 9(06).
           03  CNT-IN                  PIC 9(06).
           03  CNT-IN-SEL              PIC 9(06).
           03  CNT-COMMIT              PIC 9(06).
           03  CNT-HEN                 PIC 9(06).
      *
           03  CNT-OUT                 PIC 9(06).
           03  CNT-ERR                 PIC 9(06).
           03  CNT-ERR2                PIC 9(06).
           03  CNT-OK                  PIC 9(06).
           03  CNT-PTINF               PIC 9(06).
      *
           03  CNT-LCNT1               PIC 9(02).
           03  CNT-LCNT2               PIC 9(02).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY              PIC 9(02).
               05  SYS-MM              PIC 9(02).
               05  SYS-DD              PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID          PIC 9(07).
           03  WRK-PARA-SHELLID        PIC X(08).
           03  WRK-PARA-HOSPID         PIC X(24).
           03  WRK-PARA-LSTYMD         PIC X(08).
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-RECEERR             PIC X(200).
      *
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-SYMD2.
               05  WRK-SYY2            PIC 9(02).
               05  WRK-SMM2            PIC 9(02).
               05  WRK-SDD2            PIC 9(02).
           03  WRK-MAE-TEKSTYMD        PIC X(08).
           03  WRK-MAE-TEKEDYMD        PIC X(08).
           03  WRK-MAE-HKNNUM          PIC X(03).
           03  WRK-MAE-HKNID           PIC 9(10).
      *
           03  WRK-PTID                PIC 9(10).
           03  WRK-PAYKBN              PIC X(02).
           03  WRK-HKNNUM              PIC X(03).
      *
           03  WRK-Z3                  PIC ZZ9.
      *
           03  WRK-LSTYMD              PIC X(08).
      *
           03  WRK-BYMD-70.
               05  WRK-BYY             PIC 9(04).
               05  WRK-BMM             PIC 9(02).
               05  WRK-BDD             PIC 9(02).
      *
      *    帳票出力領域
       01  ERRMES-AREA.
           03  ERRMES-TITLE1.
               05  FILLER              PIC X(02)   VALUE  SPACE.
               05  FILLER              PIC X(60)   VALUE
               "＜＜　レセプトチェックリスト一覧　＞＞".
               05  ERRMES-TITLE1-YY    PIC X(04).
               05  FILLER              PIC X(01) VALUE ".".
               05  ERRMES-TITLE1-MM    PIC X(02).
               05  FILLER              PIC X(01) VALUE ".".
               05  ERRMES-TITLE1-DD    PIC X(02).
           03  ERRMES-TITLE3.
               05  FILLER              PIC X(04) VALUE
                                                 "NO".
               05  FILLER              PIC X(38) VALUE
                                                 "ERR-MESSAGE".
               05  FILLER              PIC X(20) VALUE
                   "患者番号".
               05  FILLER              PIC X(01) VALUE SPACE.
               05  FILLER              PIC X(10) VALUE SPACE.
               05  FILLER              PIC X(04) VALUE SPACE.
               05  FILLER              PIC X(10) VALUE
                   "患者ＩＤ".
      *
      *    出力エラーファイル
       01  ERR-REC.
               05  ERR-NO              PIC X(05).
               05  FILLER              PIC X(01).
               05  ERR-MES             PIC X(40).
               05  FILLER              PIC X(01).
               05  ERR-PTNUM           PIC X(20).
               05  FILLER              PIC X(01).
               05  ERR-LSTYMD          PIC X(10).
               05  FILLER              PIC X(03).
               05  ERR-PTID            PIC X(10).
               05  FILLER              PIC X(03).
               05  ERR-ERRMSG          PIC X(50).
      *
      *    変換明細
       01  MEISAI-HEAD.
           03  FILLER                  PIC X(02)   VALUE   SPACE.
           03  FILLER                  PIC X(60)   VALUE
               "＜＜　レセプトチェックリスト一覧　＞＞".
           03  FILLER                  PIC X(10)   VALUE   SPACE.
           03  MEISAI-HEAD-YY          PIC X(04).
           03  FILLER                  PIC X(01) VALUE ".".
           03  MEISAI-HEAD-MM          PIC X(02).
           03  FILLER                  PIC X(01) VALUE ".".
           03  MEISAI-HEAD-DD          PIC X(02).
      *
       01  MEISAI-HEAD2.
           03  FILLER                  PIC X(20)   VALUE
               "患者番号".
           03  FILLER                  PIC X(01)   VALUE   SPACE.
           03  FILLER                  PIC X(08)   VALUE
               "診療年月".
           03  FILLER                  PIC X(02)   VALUE   SPACE.
           03  FILLER                  PIC X(06)   VALUE   SPACE.
           03  FILLER                  PIC X(02)   VALUE   SPACE.
           03  FILLER                  PIC X(12)   VALUE   SPACE.
           03  FILLER                  PIC X(10)   VALUE
               "修正内容".
      *
       01  MEISAI-BODY1.
           03  MEISAI-PTNUM            PIC X(20).
           03  FILLER                  PIC X(01)   VALUE   SPACE.
           03  MEISAI-SRYYM            PIC X(08).
           03  FILLER                  PIC X(01)   VALUE   SPACE.
           03  MEISAI-MSG              PIC X(80).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    プレビューＤＢ
           COPY    "CPPRVKANRI.INC".          
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    システム管理（医療機関情報基本情報）
           COPY    "CPSK1001.INC".
      *
      *    患者番号変換マスタ
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
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
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "ORCA-DBPATH".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
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
           02  FILLER                  PIC X(256).
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           PERFORM 200-MAIN-SEC
                   UNTIL       FLG-END     =   1
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
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
                                       WRK-PARA-LSTYMD
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBPRVPRT"    TO  JOB-PGID
           MOVE    "プレビューチェックリスト出力"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
      *
           INITIALIZE                  SPA-AREA
      *
      *    システム日付を２００３０４０１とする
           MOVE    "20030401"      TO  SPA-SYSYMD
      *    作成日
           ACCEPT  WRK-SYMD2       FROM    DATE
           COMPUTE WRK-SYY         =   WRK-SYY2    +   2000
           MOVE    WRK-SMM2        TO  WRK-SMM
           MOVE    WRK-SDD2        TO  WRK-SDD
      *
           MOVE    WRK-SYY         TO  ERRMES-TITLE1-YY
           MOVE    WRK-SMM         TO  ERRMES-TITLE1-MM
           MOVE    WRK-SDD         TO  ERRMES-TITLE1-DD
      *
           MOVE    WRK-SYY         TO  MEISAI-HEAD-YY
           MOVE    WRK-SMM         TO  MEISAI-HEAD-MM
           MOVE    WRK-SDD         TO  MEISAI-HEAD-DD
      *
      *    システム管理情報　検索処理
           PERFORM 2200-CP1001-KENSAKU-SEC
      *
      *    端末ＩＤ固定
           MOVE    "ORCATERM"          TO  SPA-TERMID
      *
           MOVE    WRK-PARA-HOSPID     TO  SPA-HOSPID
      *
      *    置換対象テーブル保存
           PERFORM 900-PRVKANRI-INV-SEC
           IF      FLG-END             =   1
      *        対象データなし
               MOVE    "処理対象のデータがありませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
               GO  TO              100-INIT-EXT
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC         SECTION.
      *
      *
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    患者保険情報検索
      *    INITIALIZE                  PRVKANRI-REC
           PERFORM 2101-PRV-SYORI-SEC                
           PERFORM 900-PRVKANRI-FETCH-SEC
      *    IF      FLG-ERR         NOT =   ZERO
      *        MOVE    "ＤＢ更新でエラーがありました。"
      *                                    TO  WRK-RECEERR
      *        PERFORM 500-ERR-HENSYU-SEC
      *    END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理情報　検索処理
      *****************************************************************
       2200-CP1001-KENSAKU-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
           MOVE    SPACE               TO  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    WRK-SYMD            TO  ORC-DBYMD
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSTEM-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           IF  FLG-SYSKANRI            =   1
               MOVE    1                   TO  FLG-END
           ELSE
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
               MOVE    SYS-1001-HOSPID     TO  SPA-HOSPID
               MOVE    SYS-1001-HOSPSBT    TO  SPA-HOSPSBT
               MOVE    SYS-1001-ROUPAYKBN  TO  SPA-ROUPAYKBN
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
       2200-CP1001-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    任継続中一覧帳票出力　初期処理
      *****************************************************************
       2101-PRV-SYORI-SEC                SECTION.
      *
           ADD     1                   TO  CNT-IN
           ADD     1                   TO  CNT-LCNT1
           IF      CNT-LCNT1           >   80
      *        帳票印刷処理
               PERFORM 400-PRINT-OUT-SEC
               MOVE    1                   TO  CNT-LCNT1
           END-IF
      *
           IF      CNT-LCNT1           =   1
               INITIALIZE                  HCMSL80
               MOVE    MEISAI-HEAD         TO  HCMSL80-MOJI (CNT-LCNT1)
               ADD     1                   TO  CNT-LCNT1
               MOVE    MEISAI-HEAD2        TO  HCMSL80-MOJI (CNT-LCNT1)
               ADD     1                   TO  CNT-LCNT1
               ADD     1                   TO  CNT-LCNT1
           END-IF
           MOVE    SPACE               TO  MEISAI-BODY1
           PERFORM 220-PTNUM-KEN-SEC
           MOVE    PTNUM-PTNUM         TO  MEISAI-PTNUM
           MOVE    PRVKANRI-SRYYM      TO  MEISAI-SRYYM
           MOVE    PRVKANRI-MEMO       TO  MEISAI-MSG  
      *
           MOVE    MEISAI-BODY1        TO  HCMSL80-MOJI (CNT-LCNT1)
      *
           .
       2101-PRV-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *     患者番号取得処理
      *****************************************************************
       220-PTNUM-KEN-SEC            SECTION.
      *
      *    患者番号変換
           MOVE    SPACE               TO  PTNUM-REC
           INITIALIZE                      PTNUM-REC
           MOVE    SPA-HOSPID          TO  PTNUM-HOSPID
           MOVE    PRVKANRI-PTID       TO  PTNUM-PTID
      *
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTNUM-REC
                   MOVE    ZERO                TO  FLG-PTNUM
               ELSE
                   MOVE    1                   TO  FLG-PTNUM
                   INITIALIZE                  PTNUM-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTNUM
               INITIALIZE                  PTNUM-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       220-PTNUM-KEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       400-PRINT-OUT-SEC                SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
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
           MOVE   "HCMSL80.red"        TO  SPRT-PRTID
           MOVE    "プレビューチェックリスト出力"
                                       TO  SPRT-TITLE
           MOVE    HCMSL80             TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           .
       400-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           IF      CNT-LCNT1           >   ZERO
      *        帳票印刷処理
               PERFORM 400-PRINT-OUT-SEC
           END-IF
      *
           DISPLAY "*** ORCBPRVPRT PRVKANRI:"       CNT-IN
           DISPLAY "*** ORCBPRVPRT END ***"
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           IF      CNT-COMMIT      =   ZERO
               MOVE    CNT-UPD         TO  CNT-HEN
           ELSE
               COMPUTE CNT-HEN         =   CNT-UPD
                                       -  (CNT-COMMIT   *   50 )
           END-IF
      *****MOVE    CNT-UPD         TO  JOB-UPDCNT
           MOVE    CNT-IN          TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
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
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタＦＥＴＣＨ処理
      *****************************************************************
       900-SYSTEM-NEXT-SEC         SECTION.
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
       900-SYSTEM-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *     プレビューＤＢ読み込み
      *****************************************************************
       900-PRVKANRI-INV-SEC            SECTION.
      *
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY5
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC             =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    PATH-TBL-PRVKANRI-KEY5
                                           TO  MCP-PATH
               CALL    "MCPSUB"            USING
                                               MCPAREA
                                               MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PRVKANRI-REC
             DISPLAY "take fetch ok"
                   MOVE    ZERO            TO  FLG-END
               ELSE  
             DISPLAY "take fetch ng"
                   MOVE    SPACE           TO  PRVKANRI-REC
                   MOVE    1               TO  FLG-END
               END-IF 
           ELSE 
                   MOVE    1               TO  FLG-END
           END-IF
           .
       900-PRVKANRI-INV-EXT.
           EXIT.
      *      
      *****************************************************************
      *     プレビューＤＢ読み込み
      *****************************************************************
       900-PRVKANRI-FETCH-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY5
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PRVKANRI-REC
             DISPLAY "take fetch ok"
                   MOVE    ZERO            TO  FLG-END
           ELSE  
             DISPLAY "take fetch ng"
                   MOVE    SPACE           TO  PRVKANRI-REC
                   MOVE    1               TO  FLG-END
           END-IF 
           .
       900-PRVKANRI-FETCH-EXT.
           EXIT.
      *      
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
           PERFORM 1001-DBSTART-SEC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＴＡＲＴ処理
      *****************************************************************
       1001-DBSTART-SEC        SECTION.
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       1001-DBSTART-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＴＡＲＴ処理
      *****************************************************************
       9001-DBDBCOMMIT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       9001-DBDBCOMMIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           IF      FLG-ERR         =   ZERO
               MOVE    "DBCOMMIT"      TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-IF
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
