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
       PROGRAM-ID.             ORCBI201.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院患者照会
      *  コンポーネント名  : 入院患者検索結果一覧出力（ＯＲＣＢ�毅横娃院�
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/10/14    NACL-森脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者        日付       内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメータファイル
           SELECT  BI201-FILE      ASSIGN  PRFNAME
                                   ORGANIZATION    IS  SEQUENTIAL
                                   FILE    STATUS  IS  STS-BI201.
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
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    パラメータファイル
       FD  BI201-FILE.
           COPY    "CPBI201.INC".
      *
      *    印刷用データ
       FD  PRT-FILE.
       01  PRT-REC.
           03  PRT-PRTID               PIC X(30).
           03  PRT-PRTNM               PIC X(20).
           03  PRT-SITEKBN             PIC X(01).
           03  PRT-PRTDATA             PIC X(10000).
      *
      *    ＣＳＶファイル
       FD  CSV-FILE.
       01  CSV-REC                     PIC X(1000).
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
      *
      *    ワークパラメータファイル
           COPY    "CPBI201.INC"       REPLACING  //BI201//
                                       BY         //WKBI201//.
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
           03  STS-BI201               PIC X(02).
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
           03  FLG-I001                PIC 9(01).
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
           03  WRK-ADRS                PIC X(400).
           03  WRK-PARA.
               05  WRK-PARA-PAFNAME
                                       PIC X(100).
               05  WRK-PARA-TERMID     PIC X(64).
               05  WRK-PARA-SYSYMD     PIC X(08).
               05  WRK-PARA-SYSTIME    PIC X(08).
               05  WRK-PARA-HOSPID     PIC X(24).
               05  WRK-PARA-STAFFCD    PIC X(05).
           03  WRK-PROC-KNS            PIC 9(09).
           03  WRK-ZZZZ9               PIC ZZZZ9.
           03  WRK-ZZZZ9C              PIC ZZ,ZZ9.
           03  WRK-SYMD                PIC 9(08).
           03  WRK-HENYMDG1            PIC X(09).
           03  WRK-HENYMDG3            PIC X(22).
           03  WRK-PRTNM               PIC X(20).
           03  WRK-CALC-YMD1.
               05  WRK-CALC-YY1        PIC 9(04).
               05  WRK-CALC-MM1        PIC 9(02).
               05  WRK-CALC-DD1        PIC 9(02).
           03  WRK-CALC-YMD2.
               05  WRK-CALC-YY2        PIC 9(04).
               05  WRK-CALC-MM2        PIC 9(02).
               05  WRK-CALC-DD2        PIC 9(02).
           03  WRK-AGE-YY              PIC S9(04).
           03  WRK-AGE-MM              PIC S9(02).
           03  WRK-AGE-G.
               05  WRK-AGE-Z           PIC ---9.
               05  WRK-AGE-MEI         PIC X(04).
      *
       01  CSV-EDIT-AREA.
           03  CSV-NO                  PIC Z(9)9.
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-PTNUM               PIC X(20).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-NAME                PIC X(100).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-SEX                 PIC X(2).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-AGENUM              PIC X(04).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-AGETANI             PIC X(04).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-BTU-NAME            PIC X(20).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-BRMNUM              PIC X(06).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-NYUINYMD            PIC X(10).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-TAIINYMD            PIC X(10).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-SRYKANAME           PIC X(80).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-POST                PIC X(07).
           03  FILLER                  PIC X(01)   VALUE ",".
           03  CSV-JYUSYO              PIC X(400).
      * 
       01  CONST-AREA.
           03  CONST-LINE              PIC 9(05)   VALUE   30.
           03  CONST-JOBID             PIC 9(07)   VALUE   1.
           03  CONST-JOB-SHELLID       PIC X(08)
               VALUE   "ORCBI201".
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
           COPY    "CPSK1031.INC".
      *
      *    診療科目情報
           COPY    "CPSK1005.INC".
      *
      *    病棟マスタ
           COPY    "CPSK5001.INC".
      *
      *    入院患者照会ビュー
       01  I001-REC.
           COPY    "CPI001.INC".
      *
      *    入院患者検索結果一覧
           COPY    "HCM40.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    病室名称編集
           COPY    "CPORCSBRMNUM.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
           COPY    "ORCA-DBPATH".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
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
                                               WRK-PARA-HOSPID
                                               WRK-PARA-STAFFCD
      *
      *    ＤＢオープン
           PERFORM 120-DBOPEN-SEC
      *
           PERFORM 900-JOB-STEP-START-SEC
      *
           MOVE    WRK-PARA-PAFNAME
                                   TO  PRFNAME
      *
      *    パラメータファイルオープン
           OPEN    INPUT               BI201-FILE
      *
      *    パラメータファイル読み込み
           READ    BI201-FILE
      *
           MOVE    BI201           TO  WKBI201
      *
           CLOSE   BI201-FILE
      *
           IF          WKBI201-PROC-FLG    =   ZERO
               MOVE    WKBI201-CSVFILENAME TO  CSVNAME
      *
               OPEN    OUTPUT              CSV-FILE
           ELSE
      *        印刷用ファイルオープン
               MOVE    "HC99"              TO  HC01PARA-FORM-ID
               MOVE    WRK-PARA-TERMID     TO  HC01PARA-TERMID
               MOVE    WRK-PARA-SYSTIME    TO  HC01PARA-SYOHMS
               MOVE    1                   TO  HC01PARA-CNT
      *
               OPEN    OUTPUT              PRT-FILE
      *
      *        プリンタ名取得処理
               PERFORM 110-PRTNUM-GET-SEC
               MOVE    SYS-1031-PRTNM(6)   TO  WRK-PRTNM
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    プリンタ名取得処理
      *****************************************************************
       110-PRTNUM-GET-SEC          SECTION.
      *
           MOVE    SPACE           TO  SPA-AREA
           INITIALIZE                  SPA-AREA
      *
           MOVE    WRK-PARA-HOSPID     TO  SPA-HOSPID
           MOVE    WRK-PARA-STAFFCD    TO  SPA-STAFFCD
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                  ORCSPRTNMAREA
           MOVE    "2"             TO  ORCSPRTNM-KBN
           MOVE    WRK-PARA-SYSYMD TO  ORCSPRTNM-SRYYMD
           MOVE    "2"             TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                       ORCSPRTNMAREA
                                       SPA-AREA
                                       SYS-1031-REC
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
      *    入院患者照会ビュー検索処理
           PERFORM 910-I001-SELECT-SEC
      *
      *    入院患者照会ビュー読み飛ばし処理
           PERFORM 910-I001-READ-SKIP-SEC
      *
      *    処理件数算出
           COMPUTE WRK-PROC-KNS    =   WKBI201-EDKNS
                                   -   WKBI201-STKNS
                                   +   1
      *
           COMPUTE CNT-PAGE        =   WKBI201-STPAGE
                                   -   1
      *
           INITIALIZE                  HCM40
      *
           PERFORM VARYING CNT-KNS     FROM    1   BY  1
                   UNTIL ( CNT-KNS     >   WRK-PROC-KNS )
                   OR    ( FLG-I001    =   1 )
      *
               IF          WKBI201-PROC-FLG    =  ZERO
      *            ＣＳＶ編集処理
                   PERFORM 800-CSV-EDIT-SEC
               ELSE
      *            帳票編集処理
                   PERFORM 800-PRT-EDIT-SEC
               END-IF
      *
      *        入院患者照会ビュー読込処理
               PERFORM 910-I001-READ-SEC
      *
           END-PERFORM
      *
           IF          WKBI201-PROC-FLG    =   1
               IF          CNT-LINE        >   ZERO
      *            帳票出力処理
                   PERFORM 800-PRT-WRITE-SEC
               END-IF
           END-IF
      *
      *    入院患者照会ビュークローズ処理
           PERFORM 910-I001-CLOSE-SEC
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
           IF          WKBI201-PROC-FLG    =  ZERO
               CLOSE   CSV-FILE
           ELSE
      *
               CLOSE   PRT-FILE
      *
               MOVE    SPACE           TO  SHELLTBL
      *        ファイルデイレクトリ位置指定
               INITIALIZE                  ORCSMKPASSAREA
               MOVE    "scripts/daily/HCALL2.sh"
                                       TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"        USING
                                           ORCSMKPASSAREA
               MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
               MOVE    HC01PARA        TO  SHELLTBL-ARG1
               MOVE    SHELLTBL        TO  MCPDATA-REC
               MOVE    "SHELL"         TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL
                                       TO  MCP-PATH
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                           MCPDATA-REC
           END-IF
      *
           PERFORM 900-JOB-STEP-END-SEC
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
       800-CSV-EDIT-SEC            SECTION.
      *
           MOVE    CNT-KNS         TO  CSV-NO
           MOVE    I001-PTNUM      TO  CSV-PTNUM
           MOVE    I001-NAME       TO  CSV-NAME
      *
           EVALUATE    I001-SEX
           WHEN    1
               MOVE    "男"            TO  CSV-SEX
           WHEN    2
               MOVE    "女"            TO  CSV-SEX
           END-EVALUATE
      *
           PERFORM 900-AGE-EDIT-SEC
           MOVE    WRK-AGE-Z       TO  CSV-AGENUM
           MOVE    WRK-AGE-MEI     TO  CSV-AGETANI
      *
      *    病棟名称
           MOVE    SPACE           TO  SYS-5001-REC
           INITIALIZE                  SYS-5001-REC
           MOVE    "5001"          TO  SYS-5001-KANRICD
           MOVE    I001-BTUNUM     TO  SYS-5001-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYS-5001-REC    TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF          FLG-SYSKANRI    =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-5001-REC
               MOVE    SYS-5001-BTU-NAME
                                       TO  CSV-BTU-NAME
           END-IF
      *
      *    病室名編集
           INITIALIZE                  ORCSBRMNUMAREA
           MOVE    I001-BRMNUM(3:) TO  SBRMNUM-IN-BRMNUM
           CALL    "ORCSBRMNUM"        USING
                                       ORCSBRMNUMAREA
           MOVE    SBRMNUM-OT-BRMNUM   TO   CSV-BRMNUM
      *
      *    入院日
           MOVE    I001-NYUINYMD(1:4)  TO  CSV-NYUINYMD(1:4)
           MOVE    "/"                 TO  CSV-NYUINYMD(5:1)
           MOVE    I001-NYUINYMD(5:2)  TO  CSV-NYUINYMD(6:2)
           MOVE    "/"                 TO  CSV-NYUINYMD(8:1)
           MOVE    I001-NYUINYMD(7:2)  TO  CSV-NYUINYMD(9:2)
      *    退院日
           IF          I001-TAIINYMD       =   "99999999"
               MOVE    SPACE               TO  CSV-TAIINYMD
           ELSE
               MOVE    I001-TAIINYMD(1:4)  TO  CSV-TAIINYMD(1:4)
               MOVE    "/"                 TO  CSV-TAIINYMD(5:1)
               MOVE    I001-TAIINYMD(5:2)  TO  CSV-TAIINYMD(6:2)
               MOVE    "/"                 TO  CSV-TAIINYMD(8:1)
               MOVE    I001-TAIINYMD(7:2)  TO  CSV-TAIINYMD(9:2)
           END-IF
      *
      *    診療科名称
           MOVE    SPACE           TO  SYS-1005-REC
           INITIALIZE                  SYS-1005-REC
           MOVE    "1005"          TO  SYS-1005-KANRICD
           MOVE    I001-NYUINKA    TO  SYS-1005-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYS-1005-REC    TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF          FLG-SYSKANRI    =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               MOVE    SYS-1005-SRYKANAME
                                       TO  CSV-SRYKANAME
           END-IF
      *
           MOVE    I001-HOME-POST  TO  CSV-POST
      *
           PERFORM 900-ADRS-EDIT-SEC
      *
           MOVE    WRK-ADRS        TO  CSV-JYUSYO
      *
           MOVE    CSV-EDIT-AREA   TO  CSV-REC
      *
           WRITE   CSV-REC
      *
           .
       800-CSV-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       800-PRT-EDIT-SEC            SECTION.
      *
           COMPUTE CNT-LINE        =   CNT-LINE    +   1
      *
           MOVE    CNT-KNS         TO  WRK-ZZZZ9
           MOVE    WRK-ZZZZ9       TO  HCM40-CD(CNT-LINE)
      *    患者番号の実際の文字列長を求める
           MOVE    20              TO  WRK-STR-LEN
           MOVE    I001-PTNUM      TO  WRK-STR
           PERFORM 900-STR-LEN-GET-SEC
           IF         WRK-STR-LEN      > 10
              MOVE    I001-PTNUM(1:10) TO  HCM40-PTNUMUP(CNT-LINE)
              MOVE    I001-PTNUM(11:)  TO  HCM40-PTNUMDN(CNT-LINE)
           ELSE
              MOVE    I001-PTNUM       TO  HCM40-PTNUM(CNT-LINE)
           END-IF
      *
      *    患者氏名の実際の文字列長を求める
           MOVE    100             TO  WRK-STR-LEN
           MOVE    I001-NAME       TO  WRK-STR
           PERFORM 900-STR-LEN-GET-SEC
           IF          WRK-STR-LEN         >   20
               MOVE    I001-NAME       TO  HCM40-NAME2(CNT-LINE)
           ELSE
               MOVE    I001-NAME       TO  HCM40-NAME(CNT-LINE)
           END-IF
      *
           EVALUATE    I001-SEX
           WHEN    1
               MOVE    "男"            TO  HCM40-SEX(CNT-LINE)
           WHEN    2
               MOVE    "女"            TO  HCM40-SEX(CNT-LINE)
           END-EVALUATE
      *
      *    年齢編集
           PERFORM 900-AGE-EDIT-SEC
           MOVE    WRK-AGE-Z       TO  HCM40-AGEZ(CNT-LINE)
           MOVE    WRK-AGE-MEI     TO  HCM40-AGEMEI(CNT-LINE)
      *
      *    病棟名称
           MOVE    SPACE           TO  SYS-5001-REC
           INITIALIZE                  SYS-5001-REC
           MOVE    "5001"          TO  SYS-5001-KANRICD
           MOVE    I001-BTUNUM     TO  SYS-5001-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYS-5001-REC    TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF          FLG-SYSKANRI    =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-5001-REC
               MOVE    SYS-5001-BTU-TANNAME
                                       TO  HCM40-TANNAME(CNT-LINE)
           END-IF
      *
      *    病室名編集
           INITIALIZE                  ORCSBRMNUMAREA
           MOVE    I001-BRMNUM(3:) TO  SBRMNUM-IN-BRMNUM
           CALL    "ORCSBRMNUM"        USING
                                       ORCSBRMNUMAREA
           MOVE    SBRMNUM-OT-BRMNUM
                                   TO  HCM40-BRMNUM(CNT-LINE)
      *
           MOVE    I001-NYUINYMD   TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG1    TO  HCM40-NYUINYMD(CNT-LINE)
      *
           MOVE    I001-TAIINYMD   TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG1    TO  HCM40-TAIINYMD(CNT-LINE)
      *
      *    診療科名称
           MOVE    SPACE           TO  SYS-1005-REC
           INITIALIZE                  SYS-1005-REC
           MOVE    "1005"          TO  SYS-1005-KANRICD
           MOVE    I001-NYUINKA    TO  SYS-1005-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYS-1005-REC    TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF          FLG-SYSKANRI    =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               MOVE    SYS-1005-SRYKANAME
                                       TO  HCM40-SRYKA(CNT-LINE)
           END-IF
      *
           IF          I001-HOME-POST  NOT =   SPACE
               MOVE    I001-HOME-POST (1:3)
                                       TO  HCM40-YUBINNUM(CNT-LINE)(1:3)
               MOVE    "-"             TO  HCM40-YUBINNUM(CNT-LINE)(4:1)
               MOVE    I001-HOME-POST (4:4)
                                       TO  HCM40-YUBINNUM(CNT-LINE)(5:4)
           ELSE
               MOVE    SPACE           TO  HCM40-YUBINNUM(CNT-LINE)
           END-IF
      *
           PERFORM 900-ADRS-EDIT-SEC
      *
           IF          WRK-ADRS(37:)   =   SPACE
               MOVE    WRK-ADRS        TO  HCM40-JYUSYO (CNT-LINE)
           ELSE
               MOVE    WRK-ADRS        TO  HCM40-JYUSYO2 (CNT-LINE)
           END-IF
      *
           IF          CNT-LINE        >=   CONST-LINE
      *        帳票出力処理
               PERFORM 800-PRT-WRITE-SEC
               INITIALIZE                  HCM40
               MOVE    ZERO            TO  CNT-LINE
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
      *
           MOVE    WRK-PARA-SYSYMD TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG3    TO  HCM40-SAKUSEIBI
      *
           MOVE    CNT-PAGE        TO  WRK-ZZZZ9C
           MOVE    WRK-ZZZZ9C      TO  HCM40-PAGE
      *
      *
           MOVE    SPACE           TO  PRT-REC
           MOVE    "HCM40.red"     TO  PRT-PRTID
           MOVE    WRK-PRTNM       TO  PRT-PRTNM
           MOVE    "1"             TO  PRT-SITEKBN
           MOVE    HCM40           TO  PRT-PRTDATA
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
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           IF          STS-DAY-RC1     =  ZERO
               MOVE    LNK-DAY2-EDTYMD1
                                       TO  WRK-HENYMDG1
               MOVE    LNK-DAY2-EDTYMD3
                                       TO  WRK-HENYMDG3
               INSPECT WRK-HENYMDG3    REPLACING  ALL "  "  BY  "　"
           ELSE
               MOVE    SPACE           TO  WRK-HENYMDG1
               MOVE    SPACE           TO  WRK-HENYMDG3
           END-IF
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    年齢編集処理
      *****************************************************************
       900-AGE-EDIT-SEC            SECTION.
      *
           IF          I001-BIRTHDAY   <   BI201-KJYNYMD
               MOVE    I001-BIRTHDAY   TO  WRK-CALC-YMD1
               MOVE    BI201-KJYNYMD   TO  WRK-CALC-YMD2
               PERFORM 900-AGE-CALC-SEC
           ELSE
               MOVE    BI201-KJYNYMD   TO  WRK-CALC-YMD1
               MOVE    I001-BIRTHDAY   TO  WRK-CALC-YMD2
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
      *****************************************************************
      *    住所編集処理
      *****************************************************************
       900-ADRS-EDIT-SEC           SECTION.
      *
           MOVE    SPACE           TO  WRK-ADRS
      *
      *    住所の項目長を求める
           MOVE    1               TO  WRK-STR-LEN
           MOVE    SPACE           TO  WRK-STR
           STRING  I001-HOME-ADRS  DELIMITED   BY  SIZE
           INTO    WRK-STR
           WITH POINTER WRK-STR-LEN
           END-STRING
           COMPUTE WRK-STR-LEN     =   WRK-STR-LEN -   1
      *
      *    住所の実際の文字列長を求める
           MOVE    I001-HOME-ADRS  TO  WRK-STR
           PERFORM 900-STR-LEN-GET-SEC
           MOVE    WRK-STR-LEN     TO  WRK-PTINF-ADR-LEN
      *
      *    番地の項目長を求める
           MOVE    1               TO  WRK-STR-LEN
           MOVE    SPACE           TO  WRK-STR
           STRING  I001-HOME-BANTI DELIMITED   BY  SIZE
           INTO    WRK-STR
           WITH POINTER WRK-STR-LEN
           END-STRING
           COMPUTE WRK-STR-LEN     =   WRK-STR-LEN -   1
      *
      *    番地の実際の文字列長を求める
           MOVE    I001-HOME-BANTI TO  WRK-STR
           PERFORM 900-STR-LEN-GET-SEC
           MOVE    WRK-STR-LEN     TO  WRK-PTINF-BANTI-LEN
      *
           MOVE    1               TO  WRK-STR-PNT
           IF          WRK-PTINF-ADR-LEN   >   0
               STRING  I001-HOME-ADRS(1: WRK-PTINF-ADR-LEN)
                                       DELIMITED   BY  SIZE
                       "　"            DELIMITED   BY  SIZE
               INTO    WRK-ADRS
               WITH    POINTER WRK-STR-PNT
               END-STRING
           END-IF
      *
           IF          WRK-PTINF-BANTI-LEN >   0
               STRING  I001-HOME-BANTI(1: WRK-PTINF-BANTI-LEN)
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
       900-STR-LEN-GET-SEC         SECTION.
      *
           PERFORM VARYING IDX-LEN FROM    WRK-STR-LEN BY  -1
                   UNTIL ( IDX-LEN     <   1 )
                   OR    ( WRK-STR(IDX-LEN:1)  NOT =   SPACE )
               CONTINUE
           END-PERFORM
      *
           MOVE    IDX-LEN         TO  WRK-STR-LEN
      *
           .
       900-STR-LEN-GET-EXT.
           EXIT.
      *****************************************************************
      *    年齢文字列長取得処理
      *****************************************************************
       900-STR-LEN-AGEGET-SEC      SECTION.
      *
           PERFORM VARYING IDX-LEN FROM    WRK-STR-LEN BY  -1
                   UNTIL ( IDX-LEN     <   1 )
                   OR    ( WRK-STR(IDX-LEN:1)  NOT =   "-" )
               CONTINUE
           END-PERFORM
      *
           MOVE    IDX-LEN         TO  WRK-STR-LEN
      *
           .
       900-STR-LEN-AGEGET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC       SECTION.
      *
           MOVE    WRK-PARA-SYSYMD TO  ORC-DBYMD
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC          =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF          MCP-RC          =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       800-SYSKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    入院患者照会ビュー検索処理
      *****************************************************************
       910-I001-SELECT-SEC         SECTION.
      *
           INITIALIZE                  I001-REC
           MOVE    BI201-SQL       TO  I001-SQL
           MOVE    I001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "I001-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC          =   ZERO
               PERFORM 910-I001-READ-SEC
           ELSE
               MOVE    1               TO  FLG-I001
           END-IF
      *
           .
       910-I001-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    入院患者照会ビュー読込処理
      *****************************************************************
       910-I001-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           MOVE    "I001-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC          =   ZERO
               MOVE    MCPDATA-REC     TO  I001-REC
               MOVE    ZERO            TO  FLG-I001
           ELSE
               MOVE    1               TO  FLG-I001
           END-IF
      *
           .
       910-I001-READ-EXT.
           EXIT.
      *****************************************************************
      *    入院患者照会ビュー読み飛ばし処理
      *****************************************************************
       910-I001-READ-SKIP-SEC      SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1        >=  WKBI201-STKNS )
                   OR    ( FLG-I001    =   1 )
      *        入院患者照会ビュー読込処理
               PERFORM 910-I001-READ-SEC
           END-PERFORM
      *
           .
       910-I001-READ-SKIP-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院患者照会ビュークローズ処理
      *****************************************************************
       910-I001-CLOSE-SEC          SECTION.
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "I001-KEY"      TO  ORC-DBPATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-I001-CLOSE-EXT.
           EXIT.
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
           MOVE    "入院患者検索結果一覧出力"
                                   TO  JOB-SHELLMSG
           MOVE    "ORCBI201"      TO  JOB-PGID
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           .
       900-JOB-STEP-START-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理チェック処理
      *****************************************************************
       900-JOB-STEP-END-SEC        SECTION.
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CONST-JOBID     TO  JOB-JOBID
           MOVE    CONST-JOB-SHELLID
                                   TO  JOB-SHELLID
           IF          WKBI201-PROC-FLG    =   ZERO
               MOVE    WRK-PROC-KNS
                                   TO  JOB-UPDCNT
           ELSE
               COMPUTE JOB-UPDCNT  =   CNT-PAGE
                                   -   WKBI201-STPAGE
                                   +   1
           END-IF
      *
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           .
       900-JOB-STEP-END-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　接続処理
      *****************************************************************
       120-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    "DBSTART"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       120-DBOPEN-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　切断処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-DBDISCONNECT-EXT.
           EXIT.
