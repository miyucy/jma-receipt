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
       PROGRAM-ID.             ORCBQ01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者照会
      *  コンポーネント名  : 患者一覧出力（ＯＲＣＢＱ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/06/13    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付       内容
      *  01.00.02    MCC-太田     02.06.26+ ジョブ管理機能追加
      *                                   +-出力項目に年齢追加
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメータファイル
           SELECT  BQ01-FILE   ASSIGN  PRFNAME
                                   ORGANIZATION    IS  SEQUENTIAL
                                   FILE    STATUS  IS  STS-BQ01.
      *
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   ORGANIZATION    IS  LINE
                                                       SEQUENTIAL 
                                   FILE    STATUS  IS  STS-PRT.
      *
      *    ＣＳＶファイル
           SELECT  CSV-FILE        ASSIGN  CSVNAME
                                   ORGANIZATION    IS  LINE
                                                       SEQUENTIAL 
                                   FILE    STATUS  IS  STS-CSV.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    パラメータファイル
       FD  BQ01-FILE.
           COPY    "CPBQ01.INC".
      *
      *    印刷用データ
       FD  PRT-FILE.
       01  PRT-REC.
           03  PRT-PRTID               PIC X(30).
           03  PRT-PRTNM               PIC X(20).
           03  PRT-PRTDATA             PIC X(10000).
      *
      *    ＣＳＶファイル
       FD  CSV-FILE.
       01  CSV-REC.
           03  CSV-NO                  PIC Z(9)9.
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-PTNUM               PIC X(20).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-NAME                PIC X(100).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-SEX                 PIC X(2).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-BIRTHDAY            PIC X(10).
      *----(01.00.02) LINE ADD START ----------------------------------
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-AGENUM              PIC X(04).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-AGETANI             PIC X(04).
      *----(01.00.02) LINE ADD END   ----------------------------------
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-JYUSYO              PIC X(400).
      *
       WORKING-STORAGE                 SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
           COPY    "CPSHELLTBL.INC".
      *
      *    ワークパラメータファイル
           COPY    "CPBQ01.INC"
                                   REPLACING  //BQ01//
                                   BY         //WKBQ01//.
      *
      *
       01  ASSIGN-NAME-AREA.
      *        パラメータファイル名
           03  PRFNAME                 PIC X(100).
      *        ＣＳＶファイル名
           03  CSVNAME                 PIC X(100).
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-BQ01                PIC X(02).
           03  STS-PRT                 PIC X(02).
           03  STS-CSV                 PIC X(02).
      *
      *    インデックス領域
       01  IDX-AREA.
           03  IDX1                    PIC 9(09).
           03  IDX-LEN                 PIC 9(05).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-PTINF               PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PAGE                PIC 9(09).
           03  CNT-LINE                PIC 9(05).
           03  CNT-KNS                 PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA. 
           03  WRK-STR                 PIC X(20000).
           03  WRK-STR-LEN             PIC 9(05).
           03  WRK-STR-PNT             PIC 9(05).
           03  WRK-PTINF-ADR-LEN       PIC 9(05).
           03  WRK-PTINF-BANTI-LEN     PIC 9(05).
           03  WRK-ADRS                PIC X(100).
           03  WRK-PARA.
               05  WRK-PARA-PAFNAME
                                       PIC X(100).
               05  WRK-PARA-TERMID     PIC X(32).
               05  WRK-PARA-SYSYMD     PIC X(08).
               05  WRK-PARA-SYSTIME    PIC X(08).
           03  WRK-PROC-KNS            PIC 9(09).
           03  WRK-ZZZZ9               PIC ZZZZ9.
           03  WRK-ZZZZ9C              PIC ZZ,ZZ9.
           03  WRK-SYMD                PIC 9(08).
           03  WRK-HENYMDG             PIC X(22).
           03  WRK-PRTNM               PIC X(20).
      *----(01.00.02) LINE ADD START ----------------------------------
           03  WRK-CALC-YMD1.
               05  WRK-CALC-YY1                    PIC 9(04).
               05  WRK-CALC-MM1                    PIC 9(02).
               05  WRK-CALC-DD1                    PIC 9(02).
      *
           03  WRK-CALC-YMD2.
               05  WRK-CALC-YY2                    PIC 9(04).
               05  WRK-CALC-MM2                    PIC 9(02).
               05  WRK-CALC-DD2                    PIC 9(02).
           03  WRK-AGE-YY                          PIC S9(04).
           03  WRK-AGE-MM                          PIC S9(02).
           03  WRK-AGE-G.
               05  WRK-AGE-Z                       PIC ---9.
               05  WRK-AGE-MEI                     PIC X(04).
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
       01  CONST-AREA.
           03  CONST-LINE              PIC 9(05)   VALUE   30.
      *----(01.00.02) LINE ADD START ----------------------------------
           03  CONST-JOBID             PIC 9(07)   VALUE   1.
           03  CONST-JOB-SHELLID                   PIC X(08)
               VALUE   "ORCBQ01".
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *
      *    患者マスタ（照会用コピー句）
       01  QUERY-PTINF-REC.
           COPY    "CPQPTINF.INC".
      *
      *    患者一覧
           COPY "HC28.INC".
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
           COPY    "ORCA-DBPATH".
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      *
      ******************************************************************
       PROCEDURE                       DIVISION
                                       USING     COMMAND-PARAM.
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
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  STS-AREA
                                       FLG-AREA
                                       IDX-AREA
                                       WRK-AREA
                                       CNT-AREA
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    WRK-PARA-PAFNAME
                                               WRK-PARA-TERMID
                                               WRK-PARA-SYSYMD
                                               WRK-PARA-SYSTIME
      *
      *    ＤＢオープン
           PERFORM 120-DBOPEN-SEC
      *
      *----(01.00.02) LINE ADD START ----------------------------------
           PERFORM 900-JOB-STEP-START-SEC
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    WRK-PARA-PAFNAME    TO  PRFNAME
      *
      *    パラメータファイルオープン
           OPEN    INPUT               BQ01-FILE
      *
      *    パラメータファイル読み込み
           READ    BQ01-FILE
      *
           MOVE    BQ01                TO  WKBQ01
      *
           CLOSE   BQ01-FILE
      *
           IF  ( WKBQ01-PROC-FLG       =   ZERO )
               MOVE    WKBQ01-CSVFILENAME
                                       TO  CSVNAME
      *
               OPEN    OUTPUT              CSV-FILE
      *
           ELSE
      *        印刷用ファイルオープン
               MOVE    "HC99"          TO  HC01PARA-FORM-ID
               MOVE    WRK-PARA-TERMID
                                       TO  HC01PARA-TERMID
               MOVE    WRK-PARA-SYSTIME
                                       TO  HC01PARA-SYOHMS
               MOVE    1               TO  HC01PARA-CNT
      *
               OPEN    OUTPUT              PRT-FILE
      *
      *        プリンタ名取得処理
               PERFORM 110-PRTNUM-GET-SEC
               MOVE    SYS-1031-PRTNM(6)
                                       TO  WRK-PRTNM
      *
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    プリンタ名取得処理
      *****************************************************************
       110-PRTNUM-GET-SEC                  SECTION.
      *
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE
               INITIALIZE                  SYS-1031-REC
           END-IF
           .
      *
       110-PRTNUM-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    ZERO            TO  CNT-LINE
                                       CNT-KNS
      *
      *    患者対象データ検索処理
           PERFORM 910-PTINF-SELECT-SEC
      *
      *    患者データ読み飛ばし処理
           PERFORM 910-PTINF-READ-SKIP-SEC
      *
      *    処理件数算出
           COMPUTE WRK-PROC-KNS    =   WKBQ01-EDKNS
                                   -   WKBQ01-STKNS
                                   +   1
      *
           COMPUTE CNT-PAGE        =   WKBQ01-STPAGE
                                   -   1
      *
           INITIALIZE                  HC28
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1        >   WRK-PROC-KNS )
                OR       ( FLG-PTINF   =   1 )
      *
               IF  ( WKBQ01-PROC-FLG   =  ZERO )
      *
      *            ＣＳＶ編集処理
                   PERFORM 800-CSV-EDIT-SEC
               ELSE
      *
      *            帳票編集処理
                   PERFORM 800-PRT-EDIT-SEC
               END-IF
      *
      *        患者マスタ読込処理
               PERFORM 910-PTINF-READ-SEC
      *
           END-PERFORM
      *
           IF  ( WKBQ01-PROC-FLG   =   1 )
               IF  ( CNT-LINE      >   ZERO )
      *            帳票出力処理
                   PERFORM 800-PRT-WRITE-SEC
               END-IF
           END-IF
      *
      *    患者対象データクローズ処理
           PERFORM 910-PTINF-CLOSE-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           IF  ( WKBQ01-PROC-FLG    =  ZERO )
               CLOSE   CSV-FILE
      *
           ELSE
      *
               CLOSE   PRT-FILE
      *
               MOVE   "HCALL2.sh"      TO  SHELL-ID
      *
               MOVE    SPACE           TO  SHELLTBL
               MOVE    SHELL-NAME      TO  SHELLTBL-NAME
               MOVE    HC01PARA        TO  SHELLTBL-ARG1
               MOVE    SHELLTBL        TO  MCPDATA-REC
               MOVE    "SHELL"         TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                           MCPAREA
                                           MCPDATA-REC
           END-IF
      *
      *----(01.00.02) LINE ADD START ----------------------------------
           PERFORM 900-JOB-STEP-END-SEC
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＳＶ編集処理
      *****************************************************************
       800-CSV-EDIT-SEC                SECTION.
      *
           MOVE    CNT-KNS         TO  CSV-NO
           MOVE    QUERY-PTINF-PTNUM
                                   TO  CSV-PTNUM
           MOVE    QUERY-PTINF-NAME
                                   TO  CSV-NAME
           EVALUATE    QUERY-PTINF-SEX
           WHEN    1
               MOVE    "男"        TO  CSV-SEX
           WHEN    2
               MOVE    "女"        TO  CSV-SEX
           END-EVALUATE
      *
           MOVE    QUERY-PTINF-BIRTHDAY (1:4)
                                   TO  CSV-BIRTHDAY (1:4)
           MOVE    "/"             TO  CSV-BIRTHDAY (5:1)
           MOVE    QUERY-PTINF-BIRTHDAY (5:2)
                                   TO  CSV-BIRTHDAY (6:2)
           MOVE    "/"             TO  CSV-BIRTHDAY (8:1)
           MOVE    QUERY-PTINF-BIRTHDAY (7:2)
                                   TO  CSV-BIRTHDAY (9:2)
      *
      *----(01.00.02) LINE ADD START ----------------------------------
           PERFORM 900-AGE-EDIT-SEC
           MOVE    WRK-AGE-Z       TO  CSV-AGENUM
           MOVE    WRK-AGE-MEI     TO  CSV-AGETANI
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM 900-ADRS-EDIT-SEC
      *
           MOVE    WRK-ADRS        TO  CSV-JYUSYO
      *
           WRITE   CSV-REC
      *
           .
       800-CSV-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       800-PRT-EDIT-SEC                SECTION.
      *
           COMPUTE CNT-LINE    =   CNT-LINE    +   1
      *
           MOVE    CNT-KNS         TO  WRK-ZZZZ9
           MOVE    WRK-ZZZZ9       TO  HC28-CD     (CNT-LINE)
      *----(01.00.02) LINE DEL START ----------------------------------
      *    MOVE    QUERY-PTINF-PTNUM
      *                            TO  HC28-PTNUM  (CNT-LINE)
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
      *    住所の実際の文字列長を求める
           MOVE    20                    TO  WRK-STR-LEN
           MOVE    QUERY-PTINF-PTNUM     TO  WRK-STR
           PERFORM 900-STR-LEN-GET-SEC
           IF    ( WRK-STR-LEN         > 10  )
              MOVE    QUERY-PTINF-PTNUM(1:10)
                                   TO  HC28-PTNUMUP(CNT-LINE)
              MOVE    QUERY-PTINF-PTNUM(11:)
                                   TO  HC28-PTNUMDN(CNT-LINE)
           ELSE
              MOVE    QUERY-PTINF-PTNUM
                                   TO  HC28-PTNUM  (CNT-LINE)
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    QUERY-PTINF-NAME
                                   TO  HC28-NAME   (CNT-LINE)
           EVALUATE    QUERY-PTINF-SEX
           WHEN    1
               MOVE    "男"        TO  HC28-SEIBETU(CNT-LINE)
           WHEN    2
               MOVE    "女"        TO  HC28-SEIBETU(CNT-LINE)
           END-EVALUATE
      *
           MOVE    QUERY-PTINF-BIRTHDAY  TO  WRK-SYMD
      *
           PERFORM 800-SEIWA-HEN-SEC
      *
           STRING  WRK-HENYMDG (1 : 2)
                   WRK-HENYMDG (5 : 4)
                   "．"
                   WRK-HENYMDG (11 : 4)
                   "．"
                   WRK-HENYMDG (17 : 4)
                   DELIMITED   BY  SIZE
                   INTO                HC28-TANJYOBI
                                                   (CNT-LINE)
           END-STRING
      *
      *----(01.00.02) LINE ADD START ----------------------------------
           PERFORM 900-AGE-EDIT-SEC
           MOVE    WRK-AGE-Z       TO  HC28-AGENUM (CNT-LINE)
           MOVE    WRK-AGE-MEI     TO  HC28-AGETANI(CNT-LINE)
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM 900-ADRS-EDIT-SEC
      *
           MOVE    WRK-ADRS        TO  HC28-JYUSYO (CNT-LINE)
      *
           IF  ( CNT-LINE         >=   CONST-LINE )
      *
      *        帳票出力処理
               PERFORM 800-PRT-WRITE-SEC
      *
               INITIALIZE              HC28
               MOVE    ZERO        TO  CNT-LINE
      *
      *
           END-IF
      *
           .
       800-PRT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    帳票出力処理
      *****************************************************************
       800-PRT-WRITE-SEC           SECTION.
      *
           COMPUTE CNT-PAGE        =   CNT-PAGE    +   1
      *
      *    ヘッダ部編集
           MOVE    WKBQ01-HYODAI   TO  HC28-HYODAI
      *
           MOVE    WKBQ01-JYOKEN1  TO  HC28-JYOKEN (1)
      *
           MOVE    WKBQ01-JYOKEN2  TO  HC28-JYOKEN (2)
      *
           MOVE    WRK-PARA-SYSYMD TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG     TO  HC28-SAKUSEIBI
      *
           MOVE    CNT-PAGE        TO  WRK-ZZZZ9C
           MOVE    WRK-ZZZZ9C      TO  HC28-PAGE
      *
      *
           MOVE    SPACE           TO  PRT-REC
           MOVE    "HC28"          TO  PRT-PRTID
           MOVE    WRK-PRTNM       TO  PRT-PRTNM
           MOVE    HC28            TO  PRT-PRTDATA
           WRITE   PRT-REC
      *
           .
       800-PRT-WRITE-EXT.
           EXIT.
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC           SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           INSPECT WRK-HENYMDG    REPLACING  ALL "  "  BY  "　"
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    年齢編集処理
      *****************************************************************
       900-AGE-EDIT-SEC                SECTION.
      *
           IF  (   QUERY-PTINF-BIRTHDAY
                                       <   BQ01-KJYNYMD )
               MOVE    QUERY-PTINF-BIRTHDAY
                                       TO  WRK-CALC-YMD1
               MOVE    BQ01-KJYNYMD    TO  WRK-CALC-YMD2
               PERFORM 900-AGE-CALC-SEC
           ELSE
               MOVE    BQ01-KJYNYMD    TO  WRK-CALC-YMD1
               MOVE    QUERY-PTINF-BIRTHDAY
                                       TO  WRK-CALC-YMD2
               PERFORM 900-AGE-CALC-SEC
               COMPUTE WRK-AGE-YY      =   WRK-AGE-YY
                                       *   -1
               COMPUTE WRK-AGE-MM      =   WRK-AGE-MM
                                       *   -1
           END-IF
      *
           IF    ( WRK-AGE-YY          =   ZERO )
               MOVE    WRK-AGE-MM      TO  WRK-AGE-Z
               MOVE    "ヶ月"          TO  WRK-AGE-MEI
           ELSE
               MOVE    WRK-AGE-YY      TO  WRK-AGE-Z
               MOVE    "歳"            TO  WRK-AGE-MEI
           END-IF
      *
           .
       900-AGE-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    年齢計算処理
      *****************************************************************
       900-AGE-CALC-SEC                SECTION.
      *
           COMPUTE WRK-AGE-YY          =   WRK-CALC-YY2
                                       -   WRK-CALC-YY1
           IF    ( WRK-CALC-YMD1(5:4)  >   WRK-CALC-YMD2(5:4) )
               COMPUTE WRK-AGE-YY      =   WRK-AGE-YY
                                       -   1
               COMPUTE WRK-AGE-MM      =  (WRK-CALC-MM2    +   12 )
                                       -   WRK-CALC-MM1
           ELSE
               COMPUTE WRK-AGE-MM      =   WRK-CALC-MM2
                                       -   WRK-CALC-MM1
           END-IF
           IF    ( WRK-CALC-DD1        >   WRK-CALC-DD2 )
               COMPUTE WRK-AGE-MM      =   WRK-AGE-MM
                                       -   1
           END-IF
      *
           .
       900-AGE-CALC-EXT.
           EXIT.
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    住所編集処理
      *****************************************************************
       900-ADRS-EDIT-SEC                   SECTION.
      *
           MOVE    SPACE           TO  WRK-ADRS
      *
      *    住所の項目長を求める
           MOVE    1               TO  WRK-STR-LEN
           MOVE    SPACE           TO  WRK-STR
           STRING  QUERY-PTINF-HOME-ADRS   DELIMITED   BY  SIZE
           INTO    WRK-STR
           WITH POINTER WRK-STR-LEN
           END-STRING
           COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *    住所の実際の文字列長を求める
           MOVE    QUERY-PTINF-HOME-ADRS TO  WRK-STR
           PERFORM 900-STR-LEN-GET-SEC
           MOVE    WRK-STR-LEN           TO  WRK-PTINF-ADR-LEN
      *
      *    番地の項目長を求める
           MOVE    1               TO  WRK-STR-LEN
           MOVE    SPACE           TO  WRK-STR
           STRING  QUERY-PTINF-HOME-BANTI  DELIMITED   BY  SIZE
           INTO    WRK-STR
           WITH POINTER WRK-STR-LEN
           END-STRING
           COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *    番地の実際の文字列長を求める
           MOVE    QUERY-PTINF-HOME-BANTI  TO  WRK-STR
           PERFORM 900-STR-LEN-GET-SEC
           MOVE    WRK-STR-LEN         TO  WRK-PTINF-BANTI-LEN
      *
           MOVE    1                   TO  WRK-STR-PNT
           IF  ( WRK-PTINF-ADR-LEN     >   0)
               STRING  QUERY-PTINF-HOME-ADRS 
                               (1: WRK-PTINF-ADR-LEN)
                                       DELIMITED   BY  SIZE
                       "　"            DELIMITED   BY  SIZE
               INTO    WRK-ADRS
               WITH    POINTER WRK-STR-PNT
               END-STRING
           END-IF
      *
           IF  ( WRK-PTINF-BANTI-LEN   >   0)
               STRING  QUERY-PTINF-HOME-BANTI 
                               (1: WRK-PTINF-BANTI-LEN)
                                       DELIMITED   BY  SIZE
               INTO    WRK-ADRS
               WITH    POINTER WRK-STR-PNT
               END-STRING
           END-IF
      *
           .
       900-ADRS-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    文字列長取得処理
      *****************************************************************
       900-STR-LEN-GET-SEC                 SECTION.
      *
           PERFORM VARYING IDX-LEN FROM    WRK-STR-LEN BY  -1
               UNTIL   ( IDX-LEN   <   1)
                OR     ( WRK-STR (IDX-LEN : 1) NOT =   SPACE)
      *
               CONTINUE
           END-PERFORM
      *
           MOVE    IDX-LEN     TO  WRK-STR-LEN
      *
           .
       900-STR-LEN-GET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    WRK-PARA-SYSYMD     TO  ORC-DBYMD
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       800-SYSKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者マスタ検索処理
      *****************************************************************
       910-PTINF-SELECT-SEC            SECTION.
      *
           INITIALIZE                  MCPAREA
           MOVE    PATH-QUERY-PTINF-KEY
                                       TO  MCP-PATH
           MOVE    SPACE               TO  QUERY-PTINF-REC
           MOVE    WKBQ01-SQL          TO  QUERY-PTINF-SQL
           MOVE    QUERY-PTINF-REC     TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"    USING   MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-PTINF
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       910-PTINF-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    患者マスタ読込処理
      *****************************************************************
       910-PTINF-READ-SEC              SECTION.
      *
           INITIALIZE              MCPAREA
           MOVE    PATH-QUERY-PTINF-KEY
                                       TO  MCP-PATH
           MOVE    SPACE               TO  MCPDATA-REC
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"    USING   MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-PTINF
               MOVE    MCPDATA-REC     TO  QUERY-PTINF-REC
               COMPUTE     CNT-KNS     =   CNT-KNS +   1
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       910-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者マスタ読み飛ばし処理
      *****************************************************************
       910-PTINF-READ-SKIP-SEC         SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1        >       WKBQ01-STKNS )
                 OR      ( FLG-PTINF   =       1 )
      *
      *        患者マスタ読込処理
               PERFORM 910-PTINF-READ-SEC
      *
           END-PERFORM
      *
           .
       910-PTINF-READ-SKIP-EXT.
           EXIT.
      *****************************************************************
      *    患者マスタクローズ処理
      *****************************************************************
       910-PTINF-CLOSE-SEC             SECTION.
      *
           INITIALIZE              MCPAREA
           MOVE    PATH-QUERY-PTINF-KEY
                                       TO  MCP-PATH
           MOVE    SPACE               TO  MCPDATA-REC
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           CALL    "MCPSUB"    USING   MCPAREA
                                       MCPDATA-REC
      *
           .
       910-PTINF-CLOSE-EXT.
           EXIT.
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    ステップ管理開始処理
      *****************************************************************
       900-JOB-STEP-START-SEC      SECTION.
      *
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CONST-JOBID     TO  JOB-JOBID
           MOVE    CONST-JOB-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "患者一覧出力"  TO  JOB-SHELLMSG
           MOVE    "ORCBQ01"       TO  JOB-PGID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           .
       900-JOB-STEP-START-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理チェック処理
      *****************************************************************
       900-JOB-STEP-END-SEC            SECTION.
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CONST-JOBID     TO  JOB-JOBID
           MOVE    CONST-JOB-SHELLID
                                   TO  JOB-SHELLID
           IF  ( WKBQ01-PROC-FLG   =   ZERO )
               MOVE    WRK-PROC-KNS
                                   TO  JOB-UPDCNT
           ELSE
               MOVE    CNT-PAGE    TO  JOB-UPDCNT
           END-IF
      *
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           .
       900-JOB-STEP-END-EXT.
           EXIT.
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    ＤＢ　接続処理
      *****************************************************************
       120-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC
           CALL    "MCPSUB"             USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    "DBSTART"           TO  MCP-FUNC
           CALL    "MCPSUB"             USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       120-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　切断処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-DBDISCONNECT-EXT.
           EXIT.
      *
      *----(01.00.XX) LINE ADD START ----------------------------------
      *----(01.00.XX) LINE ADD END   ----------------------------------
      *----(01.00.XX) LINE UPD START ----------------------------------
      *----(01.00.XX) LINE UPD END   ----------------------------------
