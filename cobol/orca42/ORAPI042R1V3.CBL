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
       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         ORAPI042R1V3.
      *****************************************************************
      *  システム名        : 日医標準レセプトソフト
      *  サブシステム名    :  API連携用モジュール
      *  コンポーネント名  : レセプト作成(xml2)
      *  管理者            :
      *  作成日付    作業者        記述
      *  16/09/15    NACL−藤原    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル名称
           COPY    "CPTEMPFL.INC"  REPLACING  //TEMPFLPARA//
                                   BY         //RECEERR//.
      *
      *    エラーファイル名称領域 
           COPY    "CPERRFL.INC".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    レセプト作成指示共通パラメタ
           COPY    "R01COMMON-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "R01SCR-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "R03SCR-SPA"    REPLACING  //SPA-GMN-//
                                   BY         //SPA-GMN-R03-//.
      *
      *    レセプト作成−印刷指示画面ＳＰＡ
           COPY    "R02SCR-SPA".
      *
       01  SPA-SCR-REC.
           COPY    "CPR02SPASCR.INC".
      *   
           COPY    "ENUM-VALUE".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-RECE07          PIC 9(01).
           03  FLG-BTPARA          PIC 9(01).
           03  FLG-SYUKA           PIC 9(01).
           03  FLG-RECE08          PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01). 
           03  FLG-NYUINACCT       PIC 9(01).
           03  FLG-SEIKYU          PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-ROW             PIC 9(01).
           03  FLG-ZAISKBKBN       PIC 9(01). 
           03  FLG-TOUROKU         PIC 9(01).
           03  FLG-SEIKYU-UMU      PIC 9(01).
           03  FLG-TAISYO          PIC 9(01).
           03  FLG-4001-RSIIRYOKBN PIC X(01).
           03  FLG-4001-JIBAIKBN   PIC 9(01).
           03  FLG-SYORI           PIC 9(01).
           03  FLG-SPASCR          PIC 9(01).
           03  FLG-SPATMP          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
           03  IDW                     PIC 9(04).
           03  IDZ                     PIC 9(04).
           03  IDXX                    PIC 9(04).
           03  IDZZ                    PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY             PIC X(04).
               05  WRK-SMM             PIC X(02).
               05  WRK-SDD             PIC X(02).
           03  WRK-HEN-DATE.
               05  WRK-HEN-YY          PIC X(04).
               05  WRK-HEN-H1          PIC X(01).
               05  WRK-HEN-MM          PIC X(02).
               05  WRK-HEN-H2          PIC X(01).
               05  WRK-HEN-DD          PIC X(02).
      *    時間編集
           03  WRK-THMS.
               05  WRK-THH             PIC X(02).
               05  WRK-TMM             PIC X(02).
               05  WRK-TSS             PIC X(02).
           03  WRK-HEN-TIME.
               05  WRK-HEN-THH         PIC X(02).
               05  WRK-HEN-T1          PIC X(01).
               05  WRK-HEN-TMM         PIC X(02).
               05  WRK-HEN-T2          PIC X(01).
               05  WRK-HEN-TSS         PIC X(02).
      *    エラーコード
           03  WRK-ERRCD               PIC X(03).
           03  WRK-ERRMSG              PIC X(100).
           03  WRK-WARNING             PIC X(03).
           03  WRK-WARNING-MSG         PIC X(100).
      *
           03  WRK-ERR-PATIENT-MAX     PIC 9(03).
      *
           03  WRK-OPID                PIC X(16).
      *
           03  WRK-KBNCD-X.
               05  WRK-KBNCD-9         PIC 9(03).
      *
           03  WRK-PREFNUM             PIC 9(02).
      *
           03  WRK-SHELL-ARG1.
             05  WRK-SHELL-SRYYM       PIC X(06).
             05  WRK-SHELL-TERMID      PIC X(16).
             05  WRK-SHELL-SYSYMD      PIC X(08).  
      *
           03  WRK-MCP-TABLE           PIC X(64).
           03  WRK-MCP-PATHNAME        PIC X(64).
      *
           03  WRK-PARAM               PIC X(256).
      *
           03  WRK-SRYYM               PIC 9(06).
      *
           03  WRK-ACCT-SRYYM          PIC 9(06).
           03  WRK-ACCT-PTID           PIC 9(10).
           03  WRK-ACCT-NYUGAIKBN      PIC X(01).
      *
           03  WRK-X.
               05  WRK-9               PIC 9(05).
      *
           03  WRK-FILEMEI             PIC X(20).
      *
       01  KEY-AREA                        VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-PTID          PIC 9(10).
               05  KEY-N-HKNCOMBI      PIC 9(04).
               05  KEY-N-SRYKA         PIC X(02).
           03  KEY-OLD.
               05  KEY-O-PTID          PIC 9(10).
               05  KEY-O-HKNCOMBI      PIC 9(04).
               05  KEY-O-SRYKA         PIC X(02).
      *
       01  WRK-XML-AREA.
           03  WRK-REGIST-YMD10        PIC X(10).
           03  WRK-REGIST-TIME8        PIC X(08).
      *
           03  WRK-REGIST-YMD          PIC X(08).
           03  WRK-REGIST-TIME.
               05  WRK-REGIST-THH      PIC X(02).
               05  WRK-REGIST-TMM      PIC X(02).
               05  WRK-REGIST-TSS      PIC X(02).
           03  WRK-PTNUM               PIC X(20).
      *
       01  SPA-RECE07-REC. 
           COPY    "CPRCF007.INC"  REPLACING  //RECE07//
                                   BY         //SPA-RECE07//.
           03  SPA-RECE07-SRYKA-KOKUHO
                                   PIC X(02).
           03  SPA-RECE07-SRYKA-KOUIKI
                                   PIC X(02).
           03  SPA-RECE07-RECE-PUTH-T   OCCURS 2.
               05  SPA-RECE07-ZAITAKU-KBN-T
                                   PIC  X(01).
               05  SPA-RECE07-CHOUKI-KBN-T
                                   PIC  X(01).
               05  SPA-RECE07-SRT-LAST-T
                                   PIC  X(01).
               05  SPA-RECE07-KOUGAKU-TEN-T
                                   PIC  9(07).
           03  SPA-RECE08-DRCD-SRYKA
                                   PIC X(02).
           03  SPA-RECE08-SORT-1   PIC X(10).
           03  SPA-RECE08-SORT-2   PIC X(50).
           03  SPA-RECE08-RECESYUBETU-SRT
                                   PIC X(03).
           03  SPA-RECE07-FUMEI-PAGE
                                   PIC 9(05).
           03  SPA-RECE07-HKNJANUM-SYAHO-T.
               05  SPA-RECE07-HKNJANUM-SRT-SYAHO
                                   PIC X(01).
               05  SPA-RECE07-HKNJANUM-SYAHO-MAX
                                   PIC  9(02).
               05  SPA-RECE07-HKNJANUM-SYAHO
                                   PIC X(08)   OCCURS  10.
      * 
           COPY    "MCPAREA"       REPLACING  //MCP//
                                   BY         //TAIHI-MCP//.
      *
       01  WRK-CONS-AREA.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "RECEPT1".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
           03  WRK-CONS-JOB-SHELLID1
                                   PIC X(08)   VALUE   "TEIKI1".
           03  WRK-CONS-JOB-JOBID1 PIC 9(07)   VALUE   1.
           03  WRK-CONS-BTPARA-SHELLID
                                   PIC X(08)   VALUE   "ORCBQ01".
           03  WRK-CONS-BTPARA-SCRIPTID
                                   PIC X(20)   VALUE   "ORCBQ02.sh".
      *
      *    印刷管理ＤＢのキー値  
           03  WRK-CONS-PRTKANRI-TBL-KEY
                                   PIC X(08)   VALUE   "RECEPT2".
      *
      *    エラーファイルＩＤ
           03  WRK-CONS-FILE-ID    PIC X(08)   VALUE   "OR042ERR".
      *
      *    個別対象患者一覧
           03  WRK-CONS-LINE-MAX   PIC 9(03)   VALUE   100.
      *
      *    労災保険番号 
           03  WRK-CONS-ROUSAI-HKNNUM
                                   PIC X(03)   VALUE   "971". 
      *
      *    自賠責保険番号 
           03  WRK-CONS-JIBAISEKI-HKNNUM
                                   PIC X(03)   VALUE   "973". 
      *
      *    公害保険番号 
           03  WRK-CONS-KOUGAI-HKNNUM
                                   PIC X(03)   VALUE   "975". 
      *
      *    第三者行為
           03  WRK-CONS-DAISANSYA-HKNNUM
                                   PIC X(03)   VALUE   "970". 
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
           COPY    "CPORCSCOMMON.INC".
      *
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTNUM.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    COPY    "CPORCXKANACONV.INC".
      *
      *    COPY    "CPORCSKANACHK.INC".
      *    日付変換サブ
           COPY     "CPORCSGDAY.INC".
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    排他制御サブパラメタ
           COPY    "CPORCSLOCK.INC".
      *    API XML読み込み用定義体
           COPY    "CPRECEIPT-MAKEV3REQ.INC".
      *    API XML読み込み用定義体
           COPY    "CPRECEIPT-MAKEV3RES.INC".
      *ver.4.7
      *    API XML読み込み共通定義
           COPY    "CPAPIV2REQ.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPDATA2.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *
      **     COPY    "CPORCSGETTEMP.INC".
             COPY    "ORCA-BLOB".
      *
      *    ＵＩＤ取得用エリア
       01  UIDIO-AREA.
           03  C-RET               PIC X(2).
           03  C-UID               PIC X(36).
       01  ST                      PIC 9(2).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報
           COPY    "CPSK1001.INC".
      *    職員情報
           COPY    "CPSK1010.INC".
      *
           COPY    "CPSK2001.INC".
      *
           COPY    "CPSK2002.INC".
      *
           COPY    "CPSK2003.INC".
      *
           COPY    "CPSK2005.INC".
           COPY    "CPSK200501.INC".
           COPY    "CPSK200505.INC".
      *
           COPY    "CPSK2006.INC".
      *
           COPY    "CPSK4001.INC".
      *
           COPY    "CPSK9101.INC".
      *
           COPY    "CPSK9102.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    レセプト管理     
       01  RECE07-REC. 
           COPY    "CPRCF007.INC".
      *
           COPY    "CPRCF008.INC".
      *
      *    パラメタ
       01  BTPARA-REC.
           COPY    "CPBTPARA.INC".
      *
      *    主科
       01  SYUKA-REC.
           COPY    "CPSYUKA.INC".
      *
      *    定期請求ジョブチェックサブ
           COPY    "CPORCSTEIKIJOB.INC".
      *
      *    システム基本
       01  SYSBASE-REC.
           COPY    "CPSYSBASE.INC".
      *
      *    システムユーザー
       01  SYSUSER-REC.
           COPY    "CPSYSUSER.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
           COPY    "CPRCF010.INC".
      *
           COPY    "CPKOHSKY.INC".
      *
      *    レセプト電算
           COPY    "CPRECEDEN.INC".
      *
      *    入院料未算定日取得サブ
           COPY    "CPORCSNYUINDAY.INC".
      *
      *    ＳＰＡ一時テーブル
       01  SPATMP-REC.
           COPY    "CPSPA-TMP.INC".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "ORCA42SCRAREA.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-MAIN-SEC                SECTION.
      *
           DISPLAY   "**********************"
           DISPLAY   "* receipt_Make start *"
           DISPLAY   "**********************"
      *
           INITIALIZE                      FLG-AREA
           INITIALIZE                      IDX-AREA
           INITIALIZE                      WRK-AREA
      *****INITIALIZE                      CNT-AREA
           INITIALIZE                      SPA-AREA
                                           SPA-R01KYOUTU
                                           SPA-R01FREE
                                           SPA-R02
                                           SPA-R03
      *
           MOVE    MCPAREA             TO  TAIHI-MCPAREA
      *
      *    初期処理
           PERFORM 100-INIT-SEC
      *    主処理
           IF      WRK-ERRCD           =   SPACE
               PERFORM 200-MAIN-SEC
           END-IF
      *
           IF      WRK-ERRCD           =   "999"
      *        ユーザＩＤエラー
               MOVE   404                  TO  APILST-HTTPSTATUS
           ELSE
      *        返却領域編集
               PERFORM 300-RGTXMLMAKE-SEC
           END-IF
      *
           DISPLAY   "**********************"
           DISPLAY   "* receipt_Make end   *"
           DISPLAY   "**********************"
           .
       000-MAIN-EXIT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                      WRK-XML-AREA
           INITIALIZE                      XML-RECEIPT-MAKERES
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
           MOVE   "Acceptance_Info"    TO  RECEMAKES-RESKEY
      *
           STRING  "A+"                DELIMITED  BY  SIZE
                   MCP-USER            DELIMITED  BY  SIZE
                                       INTO    WRK-OPID
           END-STRING
           MOVE    MCP-USER            TO  SPA-OPID
           MOVE    SMCNDATE-YMD        TO  SPA-SYSYMD
      *    日付・時間出力編集
           MOVE    SMCNDATE-YMD        TO  WRK-SYMD
           MOVE    SMCNDATE-HMS        TO  WRK-THMS
           PERFORM 801-DAYHEN01-SEC
           MOVE    WRK-HEN-DATE        TO
                                       RECEMAKES-INFORMATION-DATE
           MOVE    WRK-HEN-TIME        TO
                                       RECEMAKES-INFORMATION-TIME
      *
      *    医療機関識別番号セット 
           MOVE    "API"               TO  SPA-MOTOPG
           CALL    "ORCSHOSPNUM"       USING
                                       MCPAREA
                                       SPA-AREA
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE    "999"               TO  WRK-ERRCD
               GO  TO  100-INIT-EXT
           END-IF
      * 
      *    ＳＰＡ共通設定
           INITIALIZE                  SYS-1010-REC
           INITIALIZE                  ORCSCOMMONAREA
           MOVE    "M00"               TO  ORCSCOMMON-PG
           CALL    "ORCSCOMMON"        USING
                                       MCPAREA
                                       SPA-AREA
                                       ORCSCOMMONAREA
                                       SYS-1010-REC
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE   "089"            TO  WRK-ERRCD
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    XML情報取り出し
           PERFORM 1000-RGTXMLREAD-SEC
           IF      WRK-ERRCD       NOT =   SPACE
               GO  TO  200-MAIN-EXT
           END-IF
      *
           MOVE    ZERO                TO  RECEMAKES-API-RESULT
           MOVE    SPACE               TO  WRK-ERRCD
                                           WRK-WARNING
      *
           MOVE    ZERO                TO  FLG-SYORI
           EVALUATE    RECEMAKEQ-REQUEST-NUMBER
           WHEN    "01"
      *        処理実施
               MOVE    1                   TO  FLG-SYORI
           WHEN    "02"
      *        処理確認
               MOVE    2                   TO  FLG-SYORI
           WHEN    "03"
      *        キャンセル
               MOVE    3                   TO  FLG-SYORI
      *
           WHEN    OTHER
               MOVE    "091"               TO  WRK-ERRCD
           END-EVALUATE
      *
      *    入力項目チェック処理
           IF      WRK-ERRCD           =   SPACE
               PERFORM 2001-INPUT-CHK-SEC
           END-IF
      *
      *??
           DISPLAY "2001=" WRK-ERRCD "#" SPA-ERRCD "#"
      *??
           IF    ( WRK-ERRCD       NOT =   SPACE )
           OR    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  200-MAIN-EXT
           END-IF
      *
           EVALUATE    RECEMAKEQ-REQUEST-NUMBER
               WHEN    "01"
      *            処理実施処理
                   PERFORM 2002-RECEIPT-MAKE-SEC
               WHEN    "02"
      *            処理確認処理
                   PERFORM 2003-RECEIPT-CHECK-SEC
               WHEN    "03"
      *            キャンセル処理
                   PERFORM 2004-RECEIPT-CANCEL-SEC
           END-EVALUATE
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    XML情報から内容を取り出す
      *****************************************************************
       1000-RGTXMLREAD-SEC   SECTION.
      *
           INITIALIZE                      XML-APIREQ
           INITIALIZE                      XML-RECEIPT-MAKEREQ
      *
      *    XML情報取り出し
           MOVE    "XMLOPEN"           TO  MCP-FUNC
           MOVE    "xml_receipt_makev3req"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    APILST-BODY         TO  APIREQ-OBJECT
           MOVE    ZERO                TO  APIREQ-MODE
           MOVE    "receipt_makev3req" TO  APIREQ-RECORDNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       XML-APIREQ
                                       SPA-AREA
           IF     (MCP-RC              =   ZERO  OR  1  )
               CONTINUE
           ELSE
               DISPLAY "XMLOPEN failure = " MCP-RC
               MOVE   "097"             TO  WRK-ERRCD
           END-IF
      *
           MOVE    "XMLREAD"           TO  MCP-FUNC
           MOVE    "xml_receipt_makev3req"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    ORCA-BLOB-OBJECT    TO  APIREQ-OBJECT
           MOVE    "receipt_makev3req" TO  APIREQ-RECORDNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       XML-APIREQ
                                       SPA-AREA
           IF     (MCP-RC              =   ZERO  OR  1  )
               MOVE    XML-APIREQ      TO  XML-RECEIPT-MAKEREQ
               PERFORM 10001-XML-REMAKE-SEC
           ELSE
               DISPLAY "XMLREAD failure = " MCP-RC
               MOVE   "098"             TO  WRK-ERRCD
           END-IF
      *
           MOVE    "XMLCLOSE"          TO  MCP-FUNC
           MOVE    "xml_receipt_makev3req"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    ORCA-BLOB-OBJECT    TO  APIREQ-OBJECT
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       XML-APIREQ
                                       SPA-AREA
           IF     (MCP-RC              =   ZERO    OR  1  )
               CONTINUE
           END-IF
      *
           .
       1000-RGTXMLREAD-EXT.
           EXIT.
      *
      *****************************************************************
      *    XML情報書き込み処理
      *****************************************************************
       300-RGTXMLMAKE-SEC   SECTION.
      *
           IF      WRK-ERRCD           =   SPACE
      *        正常終了
               MOVE    "02"            TO  RECEMAKES-RESPONS-NUMBER
               EVALUATE    FLG-SYORI
                   WHEN    1
                       MOVE    "処理実施終了"
                                           TO  RECEMAKES-API-RESULT-MSG
                   WHEN    2
                       MOVE    "処理確認終了"
                                           TO  RECEMAKES-API-RESULT-MSG
                   WHEN    3
                       MOVE    "処理キャンセル終了"
                                           TO  RECEMAKES-API-RESULT-MSG
               END-EVALUATE
           ELSE
               MOVE    "01"            TO  RECEMAKES-RESPONS-NUMBER
      *        エラーメッセージ
               PERFORM 890-ERRCD-MSG-SEC
               MOVE    WRK-ERRCD       TO  RECEMAKES-API-RESULT
               MOVE    WRK-ERRMSG      TO  RECEMAKES-API-RESULT-MSG
           END-IF
      *    警告メッセージ
           MOVE    WRK-WARNING     TO  RECEMAKES-API-WARNING
           MOVE    WRK-WARNING-MSG TO  RECEMAKES-API-WARNING-MSG
      *
           MOVE    RECEMAKEQ-KARTE-UID TO  RECEMAKES-KARTE-UID
           MOVE    RECEMAKEQ-ORCA-UID  TO  RECEMAKES-ORCA-UID
           MOVE    RECEMAKEQ-REQUEST-NUMBER
                                       TO  RECEMAKES-REQUEST-NUMBER
           EVALUATE    RECEMAKEQ-RECEIPT-MODE
               WHEN    "All"
                   MOVE    RECEMAKEQ-PERFORM-MONTH
                                           TO  RECEMAKES-PERFORM-MONTH
           END-EVALUATE
      *
           IF      APILST-BODY        NOT =   LOW-VALUE
               DISPLAY "MDCRES-OBJECT not low_value"
           END-IF
      *
           MOVE    "XMLOPEN"           TO  MCP-FUNC
           MOVE    "xml_receipt_makev3res"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    1                   TO  RECEMAKES-MODE
           MOVE    "receipt_makev3res" TO  RECEMAKES-RECORDNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       XML-RECEIPT-MAKERES
                                       SPA-AREA
           IF    ( MCP-RC              =   ZERO    OR  1 )
               CONTINUE
           ELSE
               DISPLAY "XMLOPEN failure = " MCP-RC
           END-IF
      *
           MOVE    "XMLWRITE"          TO  MCP-FUNC
           MOVE    "xml_receipt_makev3res"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "receipt_makev3res" TO  RECEMAKES-RECORDNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       XML-RECEIPT-MAKERES
                                       SPA-AREA
           IF    ( MCP-RC              =   ZERO    OR  1 )
               CONTINUE
           ELSE
               DISPLAY "XMLWRITE failure = " MCP-RC
           END-IF
      *
           MOVE    "XMLCLOSE"          TO  MCP-FUNC
           MOVE    "xml_receipt_makev3res"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "receipt_makev3res" TO  RECEMAKES-RECORDNAME
           CALL   "ORCDBMAIN"          USING
                                       MCPAREA
                                       XML-RECEIPT-MAKERES
                                       SPA-AREA
           IF    ( MCP-RC              =   ZERO    OR  1 )
               MOVE  RECEMAKES-OBJECT      TO  APILST-BODY
               MOVE  "application/xml"     TO  APILST-CONTENT-TYPE
           ELSE
               DISPLAY "XMLCLOSE failure = " MCP-RC
               DISPLAY "accept xml write failure "
           END-IF
      *
          .
       300-RGTXMLMAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    読み込んだXMLのLOW-VALUE を  SPACE に置換
      *****************************************************************
       10001-XML-REMAKE-SEC        SECTION.
      *
           .
       10001-XML-REMAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目チェック処理
      *****************************************************************
       2001-INPUT-CHK-SEC      SECTION.
      *
      *    初画面情報
           MOVE    SPACE           TO  LINKAREA
                                       SPA-MOTOPG
                                       SPA-RIDCD-AREA
                                       SPA-RID1-AREA
      *
           MOVE    "LINK"          TO  MCP-STATUS
           MOVE    SPACE           TO  MCP-EVENT
      *
           PERFORM 800-ORCGR03-CALL-SEC
      *
      *    処理区分
           EVALUATE    RECEMAKEQ-RECEIPT-MODE
               WHEN    "All"
                   MOVE    "T"             TO  SPA-GMN-R03-IKKATU
                   MOVE    "F"             TO  SPA-GMN-R03-KOBETU
               WHEN    OTHER
                   MOVE    "T"             TO  SPA-GMN-R03-KOBETU
                   MOVE    "F"             TO  SPA-GMN-R03-IKKATU
           END-EVALUATE
      *
      *    レセプト作成区分
           EVALUATE    RECEMAKEQ-PRINT-MODE
               WHEN    "Check"
                       MOVE    "2"         TO  R03-PRTKBN
                   WHEN    OTHER
                       MOVE    "1"         TO  R03-PRTKBN
           END-EVALUATE
      *
      *    入外区分
           EVALUATE    RECEMAKEQ-INOUT
               WHEN    "I"
                   MOVE    "1"             TO  R03-NYUGAIKBN
               WHEN    "O"
                   MOVE    "2"             TO  R03-NYUGAIKBN
               WHEN    OTHER
                   MOVE    "012"           TO  WRK-ERRCD
           END-EVALUATE
      *
      *    提出先
           IF      WRK-ERRCD           =   SPACE
               MOVE    "F"                 TO  SPA-DATAKBN1-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN2-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN3-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN4-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN5-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN11-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN21-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN22-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN23-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN24-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN25-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN26-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN31-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN32-VALUE
               MOVE    "F"                 TO  SPA-DATAKBN33-VALUE
               EVALUATE    SPA-GMN-R03-IKKATU
                   WHEN    "T"
                       EVALUATE    RECEMAKEQ-SUBMISSION-MODE
                           WHEN    "01"
                               MOVE    "T"     TO  SPA-DATAKBN1-VALUE
                           WHEN    "02"
                               MOVE    "T"     TO  SPA-DATAKBN2-VALUE
                           WHEN    "03"
                               MOVE    "T"     TO  SPA-DATAKBN3-VALUE
                           WHEN    "04"
                               MOVE    "T"     TO  SPA-DATAKBN5-VALUE
                           WHEN    "05"
                               MOVE    "T"     TO  SPA-DATAKBN11-VALUE
                           WHEN    "06"
                               MOVE    "T"     TO  SPA-DATAKBN31-VALUE
                           WHEN    "07"
                               MOVE    "T"     TO  SPA-DATAKBN32-VALUE
                           WHEN    "08"
                               MOVE    "T"     TO  SPA-DATAKBN33-VALUE
                           WHEN    "09"
                               MOVE    "T"     TO  SPA-DATAKBN4-VALUE
                           WHEN    OTHER
                               MOVE    "013"   TO  WRK-ERRCD
                       END-EVALUATE
                   WHEN    "F"
                       EVALUATE    RECEMAKEQ-SUBMISSION-MODE
                           WHEN    "01"
                               MOVE    "T"     TO  SPA-DATAKBN21-VALUE
                           WHEN    "05"
                               MOVE    "T"     TO  SPA-DATAKBN22-VALUE
                           WHEN    "06"
                               MOVE    "T"     TO  SPA-DATAKBN23-VALUE
                           WHEN    "07"
                               MOVE    "T"     TO  SPA-DATAKBN24-VALUE
                           WHEN    "08"
                               MOVE    "T"     TO  SPA-DATAKBN26-VALUE
                           WHEN    "09"
                               MOVE    "T"     TO  SPA-DATAKBN25-VALUE
                           WHEN    OTHER
                               MOVE    "013"   TO  WRK-ERRCD
                       END-EVALUATE
               END-EVALUATE
           END-IF
      *
           IF      WRK-ERRCD           =   SPACE
               EVALUATE    SPA-GMN-R03-IKKATU
                   WHEN    "T"
      *                診療年月
                       MOVE    RECEMAKEQ-PERFORM-MONTH
                                                   TO  WRK-HEN-DATE
                       PERFORM 802-DAYHEN02-SEC
                       MOVE    WRK-SYMD (1:6)      TO  R03-SRYYM
               END-EVALUATE
           END-IF
     *
           IF      WRK-ERRCD       NOT =   SPACE
               GO  TO  2001-INPUT-CHK-EXT
           END-IF
      *
      *
      *    更新前チェック
           MOVE    SPACE           TO  LINKAREA
                                       SPA-MOTOPG
                                       SPA-RIDCD-AREA
                                       SPA-RID1-AREA
      *
           MOVE    "PUTG"          TO  MCP-STATUS
           MOVE    "CLICKED"       TO  MCP-EVENT
           MOVE    "B12"           TO  MCP-WIDGET
      *
           PERFORM 800-ORCGR03-CALL-SEC
      *??
           DISPLAY "CHK SPA-ERRCD=" SPA-ERRCD "#" SPA-RIDCD-AREA "#"
           DISPLAY "CHK SPA-R01-FILEKBN=" SPA-R01-FILEKBN
           DISPLAY "CHK SPA-R01-RECEKBN=" SPA-R01-RECEKBN
           DISPLAY "CHK SPA-R01-PRTKBN =" SPA-R01-PRTKBN
           DISPLAY "CHK SPA-R01-NYUGAIKBN =" SPA-R01-NYUGAIKBN
           DISPLAY "CHK SPA-DATAKBN    =" SPA-DATAKBN 
      *??
      *
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE    "050"               TO  WRK-ERRCD
               GO  TO  2001-INPUT-CHK-EXT
           END-IF
      *
      *    個別作成チェック
           IF    ( SPA-R01-FILEKBN =   "2"  )
           AND   ( RECEMAKEQ-REQUEST-NUMBER
                                   =   "01" )
               MOVE    SPACE           TO  LINKAREA
                                           SPA-MOTOPG
                                           SPA-RIDCD-AREA
                                           SPA-RID1-AREA
      *
               MOVE    "LINK"          TO  MCP-STATUS
               MOVE    SPACE           TO  MCP-EVENT
      *
               PERFORM 800-ORCGR01-CALL-SEC
      *
               PERFORM VARYING IDZZ    FROM    1   BY  1
                       UNTIL   IDZZ    >       WRK-CONS-LINE-MAX
                       OR      RECEMAKEQ-PATIENT-ID (IDZZ)
                                       =   SPACE
      *            患者番号
                   MOVE    RECEMAKEQ-PATIENT-ID (IDZZ)
                                               TO  R01-PTNUM
      *            診療年月
                   MOVE    RECEMAKEQ-PATIENT-PERFORM-DATE (IDZZ)
                                               TO  WRK-HEN-DATE
                   PERFORM 802-DAYHEN02-SEC
                   MOVE    WRK-SYMD (1:6)      TO  R01-SRYYM
      *
                   MOVE    SPACE           TO  LINKAREA
                                               SPA-MOTOPG
                                               SPA-RIDCD-AREA
                                               SPA-RID1-AREA
      *
                   MOVE    SPACE           TO  MCP-STATUS
                   MOVE    "ACTIVATE"      TO  MCP-EVENT
                   MOVE    SPACE           TO  MCP-WIDGET
      *
                   PERFORM 800-ORCGR01-CALL-SEC
      *??
           DISPLAY "SPA-RIDCD=" SPA-RIDCD "#" SPA-ERRCD "#"
      *??
      *            請求データ削除処理
                   EVALUATE    SPA-RIDCD
                       WHEN    "1008"
                       WHEN    "1009"
                       WHEN    "1010"
      *                    診療なしの請求管理削除処理
      *
                           MOVE    SPACE           TO  LINKAREA
                                                       SPA-MOTOPG
                                                       SPA-RIDCD-AREA
                                                       SPA-RID1-AREA
      *
                           MOVE    "OK"            TO  SPA-RID1-FLG
                           MOVE    "RID1"          TO  SPA-MOTOPG
      *
                           MOVE    "LINK"          TO  MCP-STATUS
                           MOVE    SPACE           TO  MCP-EVENT
      *
                           PERFORM 800-ORCGR01-CALL-SEC
                   END-EVALUATE
      *??
           DISPLAY "SPA-ERRCD=" SPA-ERRCD "#" SPA-RIDCD "#"
                   SPA-NAI-R01-DELETE  "#" SPA-NAI-R01-CHK "#"
           DISPLAY "WRK-ERRCD=" WRK-ERRCD "#"
      *??
      *
                   IF    ( SPA-ERRCD       =   SPACE )
                       IF    ( SPA-NAI-R01-DELETE  =   1 )
                       OR    ( SPA-NAI-R01-CHK     =   1 )
                           PERFORM 20012-PATIENT-ERR-SEC
                       END-IF
                   ELSE
                       PERFORM 20012-PATIENT-ERR-SEC
                   END-IF
               END-PERFORM
      *
      *        エラーがあれば処理終了
               IF      WRK-ERR-PATIENT-MAX >   ZERO
                   GO  TO  2001-INPUT-CHK-EXT
               END-IF
      *
      *        更新前チェック
               MOVE    SPACE           TO  LINKAREA
                                           SPA-MOTOPG
                                           SPA-RIDCD-AREA
                                           SPA-RID1-AREA
      *
               MOVE    "PUTG"          TO  MCP-STATUS
               MOVE    "CLICKED"       TO  MCP-EVENT
               MOVE    "B12"           TO  MCP-WIDGET
      *
               PERFORM 800-ORCGR01-CALL-SEC
      *
               IF      SPA-ERRCD   NOT =   SPACE
                   MOVE    "051"          TO  WRK-ERRCD
               END-IF
           END-IF
      *
           .
       2001-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別対象患者編集処理
      *****************************************************************
       20012-PATIENT-HENSYU-SEC     SECTION.
      *
           .
       20012-PATIENT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別対象患者エラー処理
      *****************************************************************
       20012-PATIENT-ERR-SEC     SECTION.
      *
           ADD     1               TO  WRK-ERR-PATIENT-MAX
           MOVE    RECEMAKEQ-PATIENT-ID (IDZZ)
                                   TO  RECEMAKES-PATIENT-ID
                                                   (WRK-ERR-PATIENT-MAX)
           MOVE    RECEMAKEQ-PATIENT-PERFORM-DATE (IDZZ)
                                   TO  RECEMAKES-PERFORM-DATE
                                                   (WRK-ERR-PATIENT-MAX)
           IF    ( SPA-NAI-R01-DELETE  =   1 )
           OR    ( SPA-NAI-R01-CHK     =   1 )
               MOVE    "Del"           TO  RECEMAKES-ERROR-CODE
                                                   (WRK-ERR-PATIENT-MAX)
           ELSE
               IF      SPA-ERRCD   NOT =  SPACE
                   EVALUATE    SPA-ERRCD
                       WHEN    "0003"
                           MOVE    "010"       TO  RECEMAKES-ERROR-CODE
                                                   (WRK-ERR-PATIENT-MAX)
                       WHEN    "0009"
                           MOVE    "011"       TO  RECEMAKES-ERROR-CODE
                                                   (WRK-ERR-PATIENT-MAX)
                       WHEN    OTHER
                           MOVE    SPA-ERRCD (2:3)
                                               TO  RECEMAKES-ERROR-CODE
                                                   (WRK-ERR-PATIENT-MAX)
                   END-EVALUATE
               ELSE
                   MOVE    WRK-ERRCD       TO  RECEMAKES-ERROR-CODE
                                                   (WRK-ERR-PATIENT-MAX)
               END-IF
           END-IF
      *
           IF      WRK-ERRCD       =   SPACE
               MOVE    RECEMAKES-ERROR-CODE    (WRK-ERR-PATIENT-MAX)
                                       TO  WRK-ERRCD
           END-IF
           .
       20012-PATIENT-ERR-EXT.
           EXIT.
      *****************************************************************
      *    レセプト作成処理
      *****************************************************************
       2002-RECEIPT-MAKE-SEC       SECTION.
      *
      *    UIDコード取得処理
           PERFORM 20021-UID-GET-SEC
           MOVE    C-UID           TO  RECEMAKEQ-ORCA-UID
      *
      *    ジョブ管理チェック処理
           PERFORM 800-JOBKANRI-CHK-SEC
           IF      WRK-ERRCD      NOT =   SPACE
               GO  TO  2002-RECEIPT-MAKE-EXT
           END-IF
      *??
           DISPLAY "MAKE SPA-ERRCD=" SPA-ERRCD "#" SPA-RIDCD-AREA "#"
           DISPLAY "MAKE SPA-R01-SYOKBN=" SPA-R01-SYOKBN "#"
           DISPLAY "MAKE SPA-R01-RECEKBN=" SPA-R01-RECEKBN 
           DISPLAY "MAKE SPA-R01-FILEKBN=" SPA-R01-FILEKBN
      *??
           STRING  RECEMAKEQ-KARTE-UID DELIMITED  BY  SPACE
                   RECEMAKEQ-ORCA-UID  DELIMITED  BY  SPACE
                                       INTO    SPA-R01-JOB-PARAM
           END-STRING
      *
           MOVE    SPACE           TO  LINKAREA
                                       SPA-MOTOPG
                                       SPA-RID1-AREA
      *
           MOVE    "RID1"          TO  SPA-MOTOPG
           MOVE    "OK"            TO  SPA-RID1-FLG
      *
           MOVE    "LINK"          TO  MCP-STATUS
           MOVE    SPACE           TO  MCP-EVENT
      *
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   PERFORM 800-ORCGR03-CALL-SEC
               WHEN    "2"
                   PERFORM 800-ORCGR01-CALL-SEC
           END-EVALUATE
      *
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE    "052"               TO  WRK-ERRCD
           END-IF
      *
           .
       2002-RECEIPT-MAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    UIDコード取得処理
      *****************************************************************
       20021-UID-GET-SEC     SECTION.
      *
      *    UIDコード取得処理
           INITIALIZE                  UIDIO-AREA
           CALL    "orcuidset"         USING
                                       ST
                                       UIDIO-AREA
      *
           .
       20021-UID-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト作成確認処理
      *****************************************************************
       2003-RECEIPT-CHECK-SEC     SECTION.
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           PERFORM 900-CALL-ORCSJOB-SEC
           IF      SJOBKANRI-RETURN
                                   =   ZERO
      *        パラメータとカルテUID+オルカUID をチェック
               MOVE    SPACE           TO WRK-PARAM
               STRING  RECEMAKEQ-KARTE-UID DELIMITED   BY  SPACE
                       RECEMAKEQ-ORCA-UID  DELIMITED   BY  SPACE
                                           INTO    WRK-PARAM
               END-STRING
      *
               IF    ( WRK-PARAM   NOT =   JOB-PARAM     )
               OR    ( SPA-R01-NYUGAIKBN
                                   NOT =   JOB-NYUGAIKBN )
               OR    ( SPA-R01-FILEKBN
                                   NOT =   JOB-SYOKBN    )
               OR    ( SPA-R01-SRYYM
                                   NOT =   JOB-SRYYM     )
                   MOVE    "003"           TO  WRK-ERRCD
                   MOVE    "対象の処理はありません"
                                           TO  WRK-ERRMSG
                   GO  TO  2003-RECEIPT-CHECK-EXT
               END-IF
      *
               MOVE    "PUTG"          TO  MCP-STATUS
               MOVE    "CLICKED"       TO  MCP-EVENT
               MOVE    "B11"           TO  MCP-WIDGET
      *
               MOVE    SPACE           TO  LINKAREA
               MOVE    "R03"           TO  SPA-MOTOPG
      *
               MOVE    SPA-R01KYOUTU   TO  SPA-WORK
               MOVE    SPA-AREA        TO  SPA-COMMON
      *
               CALL    "ORCGR99"           USING
                                           MCPAREA
                                           SPAAREA
                                           LINKAREA
                                           SCRAREA
      *
               MOVE    SPA-COMMON      TO  SPA-AREA
               MOVE    SPA-WORK        TO  SPA-R01KYOUTU
      *
               MOVE    TAIHI-MCPAREA   TO  MCPAREA
      *
               EVALUATE    R99-MSG
                   WHEN    "処理は正常に終了しました"
                       CONTINUE
                   WHEN    "処理中です"
                       MOVE    "001"           TO  RECEMAKES-API-RESULT
                       MOVE    "073"           TO  WRK-ERRCD
                       MOVE    R99-SHORINM (1) TO  WRK-ERRMSG
                   WHEN    OTHER
                       MOVE    R99-MSG         TO   WRK-WARNING-MSG
                       EVALUATE   R99-MSG
                           WHEN   "対象データがありませんでした"
                               MOVE    "W01"   TO  WRK-WARNING
                           WHEN   "対象のレセプトが作成されていません"
                               MOVE    "W02"   TO  WRK-WARNING
                           WHEN   "主科未設定分又は種別不明分があります"
                               MOVE    "W03"   TO  WRK-WARNING
                           WHEN   "該当する処理はありません" 
                               MOVE    "022"   TO  WRK-ERRCD
                           WHEN   OTHER
                               MOVE    "002"   TO  RECEMAKES-API-RESULT
                               MOVE    "072"   TO  WRK-ERRCD
                       END-EVALUATE
               END-EVALUATE
      *
               IF      R99-B12-STATE   =   WIDGET-NORMAL
      *            頁・件数の編集処理
                   PERFORM 3101-HENSYU-SEC
               END-IF
           END-IF
      *
           .
       2003-RECEIPT-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    頁・件数の編集処理
      *****************************************************************
       3101-HENSYU-SEC             SECTION.
      *
           MOVE    SPACE           TO  SPA-MOTOPG
                                       LINKAREA
      *
           MOVE    SPA-R01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-R02         TO  SPA-FREE
      *
           MOVE    "LINK"          TO  MCP-STATUS
           MOVE    SPACE           TO  MCP-EVENT
      *
           IF      SPA-R01-RECEKBN     =   "0" OR  "1" OR  "2" OR  "7"
               CALL    "ORCGR02"           USING
                                           MCPAREA
                                           SPAAREA
                                           LINKAREA
                                           SCRAREA
      *        画面ＳＰＡ読込み
               PERFORM 000-R02SPA-SET-SEC
      *
               MOVE    SPA-COMMON      TO  SPA-AREA
               MOVE    SPA-FREE        TO  SPA-R02
               MOVE    SPA-WORK        TO  SPA-R01KYOUTU
      *
               MOVE    TAIHI-MCPAREA   TO  MCPAREA
      *
               PERFORM VARYING     IDW     FROM    1   BY  1
                       UNTIL       IDW     >       SPA-GMN-PAGE-MAX
                   MOVE    IDW             TO  WRK-9
                   MOVE    WRK-X           TO
                                   RECEMAKES-SUBMISSION-POSITION (IDW)
      *
                   MOVE    ZERO            TO  IDZ
                   PERFORM VARYING     IDX     FROM    1   BY  1
                           UNTIL       IDX     >       36
                       IF      SPA-NAI-PRTJYUNI (IDW IDX)  =   SPACE
                           CONTINUE
                       ELSE
                           ADD     1               TO  IDZ
                           MOVE    IDZ             TO  WRK-9
                           MOVE    WRK-X           TO
                                    RECEMAKES-DETAIL-POSITION(IDW IDZ)
                           MOVE    SPA-GMN-TKENSU      (IDW IDX)
                                           TO
                                   RECEMAKES-NUMBER          (IDW IDZ)
                           MOVE    SPA-GMN-TPAGE       (IDW IDX)
                                           TO
                                   RECEMAKES-NUMBER-OF-SHEETS(IDW IDZ)
                           MOVE    SPA-NAI-SYUBETU    (IDW IDX 1)
                                           TO
                                   RECEMAKES-SUBMISSION-CODE (IDW IDZ)
                           MOVE    SPA-GMN-TSYURUINAME (IDW IDX)
                                           TO
                                   RECEMAKES-SUBMISSION-TYPE (IDW IDZ)
                       END-IF
                   END-PERFORM
               END-PERFORM
      *
               MOVE    SPA-GMN-PRTJYUNMEI  TO
                                       RECEMAKES-RECEIPT-PRINT-ORDER (1)
               MOVE    SPA-GMN-PRTJYUN1MEI TO
                                       RECEMAKES-RECEIPT-PRINT-ORDER (2)
               MOVE    SPA-GMN-PRTJYUN2MEI TO
                                       RECEMAKES-RECEIPT-PRINT-ORDER (3)
               MOVE    SPA-GMN-PAGEH       TO
                                       RECEMAKES-ALL-NUMBER
               MOVE    SPA-GMN-KENSUH      TO
                                       RECEMAKES-ALL-NUMBER-OF-SHEETS
               MOVE    SPA-GMN-FILEKBN     TO  RECEMAKES-PERFORM-TITLE
           ELSE
               CALL    "ORCGR04"           USING
                                           MCPAREA
                                           SPAAREA
                                           LINKAREA
                                           SCRAREA
      *
               MOVE    SPA-COMMON      TO  SPA-AREA
               MOVE    SPA-FREE        TO  SPA-R02
               MOVE    SPA-WORK        TO  SPA-R01KYOUTU
      *
               MOVE    TAIHI-MCPAREA   TO  MCPAREA
      *
               MOVE    1               TO  IDW
               MOVE    IDW             TO  WRK-9
               MOVE    WRK-X           TO
                                   RECEMAKES-SUBMISSION-POSITION (IDW)
      *
               MOVE    ZERO            TO  IDZ
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >       25
                   IF      SPA-NAI-R04-PRTJYUNI (IDX)  =   SPACE
                       CONTINUE
                   ELSE
                       ADD     1               TO  IDZ
                       MOVE    IDZ             TO  WRK-9
                       MOVE    WRK-X           TO
                                    RECEMAKES-DETAIL-POSITION(IDW IDZ)
                       MOVE    SPA-GMN-R04-TKENSU      (IDX)
                                           TO
                                   RECEMAKES-NUMBER          (IDW IDZ)
                       MOVE    SPA-GMN-R04-TPAGE       (IDX)
                                           TO
                                   RECEMAKES-NUMBER-OF-SHEETS(IDW IDZ)
                       MOVE    SPA-NAI-R04-SYUBETU     (IDX 1)
                                           TO
                                   RECEMAKES-SUBMISSION-CODE (IDW IDZ)
                       MOVE    SPA-GMN-R04-TSYURUINAME (IDX)
                                           TO
                                   RECEMAKES-SUBMISSION-TYPE (IDW IDZ)
                   END-IF
               END-PERFORM
      *
               MOVE    SPA-GMN-R04-PRTJYUNMEI
                                           TO
                                       RECEMAKES-RECEIPT-PRINT-ORDER (1)
               MOVE    SPA-GMN-R04-PAGEH   TO
                                       RECEMAKES-ALL-NUMBER
               MOVE    SPA-GMN-R04-KENSUH  TO
                                       RECEMAKES-ALL-NUMBER-OF-SHEETS
               MOVE    SPA-GMN-R04-FILEKBN TO  RECEMAKES-PERFORM-TITLE
           END-IF
           .
       3101-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト作成キャンセル処理
      *****************************************************************
       2004-RECEIPT-CANCEL-SEC     SECTION.
      *
      *    中止フラグのセット
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           PERFORM 900-CALL-ORCSJOB-SEC
           IF      SJOBKANRI-RETURN
                                   =   ZERO
      *        パラメータとカルテUID+オルカUID をチェック
               MOVE    SPACE           TO WRK-PARAM
               STRING  RECEMAKEQ-KARTE-UID DELIMITED   BY  SPACE
                       RECEMAKEQ-ORCA-UID  DELIMITED   BY  SPACE
                                           INTO    WRK-PARAM
               END-STRING
               IF      WRK-PARAM   NOT =   JOB-PARAM
                   MOVE    "022"           TO  WRK-ERRCD
                   MOVE    "該当する処理はありません"
                                           TO  WRK-ERRMSG
                   GO  TO  2004-RECEIPT-CANCEL-EXT
               END-IF
      *
               IF      JOB-ENDYMD      =   SPACE
      *            ジョブ管理終了処理
                   MOVE    "STP"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   MOVE    1               TO  JOB-STOPFLG
                   PERFORM 900-CALL-ORCSJOB-SEC
      *            ジョブ管理終了処理
                   MOVE    "STP"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   MOVE    1               TO  JOB-STOPFLG
                   PERFORM 900-CALL-ORCSJOB-SEC
               END-IF
           END-IF
           .
       2004-RECEIPT-CANCEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理チェック処理
      *****************************************************************
       800-JOBKANRI-CHK-SEC       SECTION.
      *
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
          PERFORM 900-CALL-ORCSJOB-SEC
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "070"           TO  WRK-ERRCD
                   STRING  "レセプト作成処理中です【"
                                             DELIMITED  BY  SIZE
                           JOB-SHELLMSG      DELIMITED  BY  SPACE
                           "】"              DELIMITED  BY  SIZE
                                             INTO  WRK-ERRMSG
                   END-STRING
               END-IF
           END-IF    
      *
      *    入院の処理のとき定期請求のチェックをする
           IF    ( WRK-ERRCD       =   SPACE   )
           AND   ( SPA-R01-NYUGAIKBN   =   "1" )
               INITIALIZE                  STEIKIJOB-AREA
               MOVE    "1"             TO  STEIKIJOB-RECEKBN
               MOVE    SPA-R01-NYUGAIKBN
                                       TO  STEIKIJOB-NYUGAIKBN
               IF    ( SPA-R01-FILEKBN     =   "1" )
                   MOVE    "1"         TO  STEIKIJOB-SYOKBN
                   MOVE    SPA-R01-SRYYM   TO  STEIKIJOB-SRYYM
               ELSE
                   MOVE    "2"         TO  STEIKIJOB-SYOKBN
               END-IF
      *
               CALL    "ORCSTEIKIJOB"      USING   STEIKIJOB-AREA
                                                   SPA-AREA
               IF    ( STEIKIJOB-ERRCD NOT =   SPACE )
                   MOVE    "071"               TO  WRK-ERRCD
                   MOVE    STEIKIJOB-ERRMSG    TO  WRK-ERRMSG
               END-IF
           END-IF
      *??
           DISPLAY "800 CHK=" WRK-ERRCD "#" WRK-ERRMSG "#"
           .
       800-JOBKANRI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト一括作成処理
      *****************************************************************
       800-ORCGR03-CALL-SEC                SECTION.
      *
           MOVE    SPA-R01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-R03         TO  SPA-FREE
      *
           CALL    "ORCGR03"           USING
                                           MCPAREA
                                           SPAAREA
                                           LINKAREA
                                           SCRAREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-R03
           MOVE    SPA-WORK        TO  SPA-R01KYOUTU
      *
           MOVE    TAIHI-MCPAREA   TO  MCPAREA
           .
       800-ORCGR03-CALL-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト個別作成処理
      *****************************************************************
       800-ORCGR01-CALL-SEC                SECTION.
     *
               MOVE    SPA-R01KYOUTU   TO  SPA-WORK
               MOVE    SPA-AREA        TO  SPA-COMMON
      *
      *        画面ＳＰＡ書込み
               PERFORM 000-R01SPA-OUT-SEC
      *
               CALL    "ORCGR01"           USING
                                           MCPAREA
                                           SPAAREA
                                           LINKAREA
                                           SCRAREA
      *
               MOVE    SPA-COMMON      TO  SPA-AREA
               MOVE    SPA-WORK        TO  SPA-R01KYOUTU
      *
      *        画面ＳＰＡ読込み
               PERFORM 000-R01SPA-SET-SEC
      *
           MOVE    TAIHI-MCPAREA   TO  MCPAREA
           .
       800-ORCGR01-CALL-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ読込
      *****************************************************************
       000-R01SPA-SET-SEC             SECTION.
      *
           INITIALIZE                      SPA-R01-AREA
      *
           MOVE    "SPAGMN"            TO  WRK-FILEMEI
           PERFORM 000-SPATMP-SEL-SEC
      *
           MOVE    "SPANAI"            TO  WRK-FILEMEI
           PERFORM 000-SPATMP-SEL-SEC
      *
      *    一時保存テーブル削除処理
           INITIALIZE                      SPATMP-REC
           MOVE    "R01"               TO  SPATMP-GYOUMUID
           PERFORM 900-SPATMP-DBDELETE-SEC
           .
       000-R01SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ読込
      *****************************************************************
       000-SPATMP-SEL-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-SPASCR
      *
           INITIALIZE                      SPATMP-REC
           MOVE    SPA-HOSPNUM         TO  SPATMP-HOSPNUM
           MOVE    "R01"               TO  SPATMP-GYOUMUID
           MOVE    SPA-TERMID          TO  SPATMP-TERMID
           MOVE    WRK-FILEMEI         TO  SPATMP-FILEMEI
           MOVE    1                   TO  SPATMP-EDANUM
      *
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-SPATMP-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-SPATMP-READ-SEC
               IF      FLG-SPATMP          =   ZERO
                   IF      WRK-FILEMEI         =   "SPAGMN"
                       MOVE    SPATMP-DATA-REC     TO   SPA-R01-GMN
                   ELSE
                       MOVE    SPATMP-DATA-REC     TO   SPA-R01-NAI
                   END-IF
               END-IF
           ELSE
               INITIALIZE                  SPATMP-REC
               MOVE    1               TO  FLG-SPATMP
           END-IF
      *
           MOVE    "key"              TO  MCP-PATHNAME
           PERFORM 900-SPATMP-DBCLOSE-SEC
           .
       000-SPATMP-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ書込
      *****************************************************************
       000-R01SPA-OUT-SEC             SECTION.
      *
           MOVE    "SPAGMN"            TO  WRK-FILEMEI
           PERFORM 000-SPATMP-OUT-SEC
      *
           MOVE    "SPANAI"            TO  WRK-FILEMEI
           PERFORM 000-SPATMP-OUT-SEC
      *
           .
       000-R01SPA-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ書込
      *****************************************************************
       000-SPATMP-OUT-SEC                SECTION.
      *
           INITIALIZE                      SPATMP-REC
           MOVE    SPA-HOSPNUM         TO  SPATMP-HOSPNUM
           MOVE    "R01"               TO  SPATMP-GYOUMUID
           MOVE    SPA-TERMID          TO  SPATMP-TERMID
           MOVE    WRK-FILEMEI         TO  SPATMP-FILEMEI
           MOVE    1                   TO  SPATMP-EDANUM
           IF      WRK-FILEMEI         =   "SPAGMN"
               MOVE    SPA-R01-GMN         TO  SPATMP-DATA-REC
           ELSE
               MOVE    SPA-R01-NAI         TO  SPATMP-DATA-REC
           END-IF
      *
           MOVE    SPATMP-REC          TO  MCPDATA2-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-SPATMP-CALL-SEC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "R01 SPATMP INSERT ERR:"  MCP-RC
                           ",KEY:" SPATMP-KEY
               MOVE    "9999"          TO  SPA-ERRCD
           END-IF
           .
       000-SPATMP-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ読込
      *****************************************************************
       000-R02SPA-SET-SEC             SECTION.
      *
           INITIALIZE                      SPA-SCR-REC
           MOVE    ZERO                TO  FLG-SPASCR
      *??  MOVE    ZERO                TO  IDX
      *
           INITIALIZE                      SPATMP-REC
           MOVE    SPA-HOSPNUM         TO  SPATMP-HOSPNUM
           MOVE    "R02"               TO  SPATMP-GYOUMUID
           MOVE    SPA-TERMID          TO  SPATMP-TERMID
           MOVE    "SPAGMN"            TO  SPATMP-FILEMEI
           MOVE    1                   TO  SPATMP-EDANUM
      *
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-SPATMP-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-SPATMP-READ-SEC
               IF      FLG-SPATMP          =   ZERO
                   MOVE    SPATMP-DATA-REC     TO   SPA-SCR-REC
               END-IF
           ELSE
               INITIALIZE                  SPATMP-REC
               MOVE    1               TO  FLG-SPATMP
           END-IF
      *
           MOVE    "key"              TO  MCP-PATHNAME
           PERFORM 900-SPATMP-DBCLOSE-SEC
      *
      *    一時保存テーブル削除処理
           INITIALIZE                      SPATMP-REC
           MOVE    "R02"               TO  SPATMP-GYOUMUID
           PERFORM 900-SPATMP-DBDELETE-SEC
           .
       000-R02SPA-SET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    日付編集処理
      *****************************************************************
       801-DAYHEN01-SEC                SECTION.
      *
           INITIALIZE                  WRK-HEN-DATE
           MOVE    WRK-SYY             TO  WRK-HEN-YY
           MOVE    WRK-SMM             TO  WRK-HEN-MM
           MOVE    WRK-SDD             TO  WRK-HEN-DD
           MOVE    "-"                 TO  WRK-HEN-H1
           MOVE    "-"                 TO  WRK-HEN-H2
           IF      WRK-SYMD            =   "99999999"
               MOVE    "12"                TO  WRK-HEN-MM
               MOVE    "31"                TO  WRK-HEN-DD
           END-IF
      *
           INITIALIZE                  WRK-HEN-TIME
           MOVE    WRK-THH             TO  WRK-HEN-THH
           MOVE    WRK-TMM             TO  WRK-HEN-TMM
           MOVE    WRK-TSS             TO  WRK-HEN-TSS
           MOVE    ":"                 TO  WRK-HEN-T1
           MOVE    ":"                 TO  WRK-HEN-T2
           .
       801-DAYHEN01-EXT.
           EXIT.
      *****************************************************************
      *    日付変換編集処理
      *****************************************************************
       802-DAYHEN02-SEC                SECTION.
      *
           INITIALIZE                  WRK-SYMD
           MOVE    WRK-HEN-YY          TO  WRK-SYY
           MOVE    WRK-HEN-MM          TO  WRK-SMM
           MOVE    WRK-HEN-DD          TO  WRK-SDD
           IF      WRK-SYMD            =   "99991231"
               MOVE    "99"                TO  WRK-SMM
               MOVE    "99"                TO  WRK-SDD
           END-IF
      *
           INITIALIZE                  WRK-THMS
           MOVE    WRK-HEN-THH         TO  WRK-THH
           MOVE    WRK-HEN-TMM         TO  WRK-TMM
           MOVE    WRK-HEN-TSS         TO  WRK-TSS
           .
       802-DAYHEN02-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ編集処理
      *****************************************************************
       890-ERRCD-MSG-SEC            SECTION.
      *
           EVALUATE    WRK-ERRCD
               WHEN    "070"
               WHEN    "071"
                   GO  TO  890-ERRCD-MSG-EXT
               WHEN    "072"
                   MOVE    "002"           TO  WRK-ERRCD
                   GO  TO  890-ERRCD-MSG-EXT
               WHEN    "073"
                   MOVE    "001"           TO  WRK-ERRCD
                   GO  TO  890-ERRCD-MSG-EXT
               WHEN    "019"
               WHEN    "020"
                   MOVE    "003"           TO  WRK-ERRCD
                   GO  TO  890-ERRCD-MSG-EXT
           END-EVALUATE
      * 
           MOVE    SPACE               TO  WRK-ERRMSG
      *
           EVALUATE    WRK-ERRCD
           WHEN    "001"
               MOVE    "患者番号が未設定です"  TO  WRK-ERRMSG
           WHEN    "010"
               MOVE    "患者番号に該当する患者が存在しません"
                                               TO  WRK-ERRMSG
           WHEN    "011"
               MOVE    "診療年月が暦日ではありません"
                                               TO  WRK-ERRMSG
           WHEN    "012"
               MOVE    "入外区分設定誤り"      TO  WRK-ERRMSG
           WHEN    "013"
               MOVE    "提出先設定誤り"        TO  WRK-ERRMSG
           WHEN    "014"
               STRING  "該当診療年月は健保準拠の設定ですので"
                                       DELIMITED   BY  SIZE
                       "自賠責（新様式）は選択できません"
                                       DELIMITED   BY  SIZE
                                       INTO        WRK-ERRMSG
               END-STRING
           WHEN    "015"
               STRING  "労災準拠の設定がありませんので"
                                       DELIMITED   BY  SIZE
                       "自賠責（新様式）は選択できません"
                                       DELIMITED   BY  SIZE
                                       INTO        WRK-ERRMSG
               END-STRING
           WHEN    "016"
               MOVE    "印刷モード設定誤り"    TO  WRK-ERRMSG
           WHEN    "017"
               MOVE    "レセプト指示コードが更新できません"
                                               TO  WRK-ERRMSG
           WHEN    "018"
               MOVE    "パラメタＤＢが更新できません"
                                               TO  WRK-ERRMSG
           WHEN    "021"
               MOVE    "レセプトの対象となるデータが入力してありません"
                                               TO  WRK-ERRMSG
           WHEN    "022"
               MOVE    "該当する処理はありません"
                                               TO  WRK-ERRMSG
           WHEN    "050"
           WHEN    "051"
           WHEN    "052"
      *        画面エラー
               MOVE    SPA-ERRMSG             TO  WRK-ERRMSG
               EVALUATE    SPA-ERRCD
                   WHEN    "0010"
                       MOVE    "050"           TO  WRK-ERRCD
               END-EVALUATE
      *    共通エラー
           WHEN    "089"
      *        ORCSCOMMON のエラー
               EVALUATE    SPA-ERRCD
                   WHEN    "1001"
                       MOVE    "職員情報が取得できません"
                                               TO  WRK-ERRMSG
                   WHEN    "1002"
                       MOVE    "医療機関情報が取得できません"
                                               TO  WRK-ERRMSG
                   WHEN    "1003"
                       MOVE    "システム日付が取得できません"
                                               TO  WRK-ERRMSG
                   WHEN    "1005"
                       MOVE    "患者番号構成情報が取得できません"
                                               TO  WRK-ERRMSG
                   WHEN    "1015"
                       STRING  "グループ医療機関が不整合です。"
                           "処理を終了して下さい。"
                                               DELIMITED  BY  SIZE
                                               INTO    WRK-ERRMSG
                       END-STRING
                   WHEN    OTHER
                       MOVE    "システム項目が設定できません"
                                               TO  WRK-ERRMSG
               END-EVALUATE
           WHEN    "090"
               MOVE    "他端末使用中"          TO  WRK-ERRMSG
           WHEN    "091"
               MOVE    "処理区分未設定"        TO  WRK-ERRMSG
           WHEN    "097"
               MOVE   "送信内容に誤りがあります。"
                                               TO  WRK-ERRMSG
           WHEN    "098"
               MOVE   "送信内容の読込ができませんでした"
                                               TO  WRK-ERRMSG
           WHEN    "099"
               MOVE    "ユーザＩＤ未登録。"    TO  WRK-ERRMSG
           END-EVALUATE
           .
       890-ERRCD-MSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込（主キー）
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptinf"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-PTINF-READ-N-SEC
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                      PTINF-REC
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込
      *****************************************************************
       900-PTINF-READ-N-SEC       SECTION.
      *
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PTINF-REC
               MOVE    ZERO                TO  FLG-PTINF
           ELSE
               MOVE    1                   TO  FLG-PTINF
                INITIALIZE                  PTINF-REC
           END-IF
      *
           .
       900-PTINF-READ-N-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key10"         TO  MCP-PATHNAME
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスタ　ＲＥＡＤ
      *****************************************************************
       900-SRYACCT-READ-SEC         SECTION.
      *
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-SRYACCT
               MOVE    MCPDATA-REC         TO  SRYACCT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           IF      FLG-SRYACCT         =   ZERO
               MOVE    ACCT-PTID           TO  KEY-N-PTID 
               MOVE    ACCT-HKNCOMBI       TO  KEY-N-HKNCOMBI
               MOVE    ACCT-SRYKA          TO  KEY-N-SRYKA
           END-IF
           .
       900-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスタ　ＲＥＡＤ
      *****************************************************************
       900-NYUINACCT-READ-SEC          SECTION.
      *
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-NYUINACCT
               MOVE    MCPDATA-REC         TO  NYUINACCT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           IF      FLG-NYUINACCT       =   ZERO
               MOVE    NACCT-PTID          TO  KEY-N-PTID 
      *********MOVE    NACCT-HKNCOMBI      TO  KEY-N-HKNCOMBI
               MOVE    NACCT-SRYKA         TO  KEY-N-SRYKA
           END-IF
           .
       900-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスタ読込
      *****************************************************************
       910-HKNCOMBI-INV-SEC         SECTION.
      *
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_hkncombi"      TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNCOMBI
                   MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
                   IF      COMB-DELKBN         =   "1"
                       MOVE    1                   TO  FLG-HKNCOMBI
                   END-IF
               ELSE
                   MOVE    1                   TO  FLG-HKNCOMBI
                   INITIALIZE                      HKNCOMBI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNCOMBI
               INITIALIZE                      HKNCOMBI-REC
           END-IF
      *
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       910-HKNCOMBI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ読込
      *****************************************************************
       900-BTPARA-READ-SEC         SECTION.
      *
           MOVE    BTPARA-REC          TO  MCPDATA-REC
           MOVE    "tbl_btpara"        TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_btpara"        TO  MCP-TABLE
               MOVE    "key5"              TO  MCP-PATHNAME
               PERFORM 900-BTPARA-READ-N-SEC
           ELSE
               MOVE    1                   TO  FLG-BTPARA
               INITIALIZE                      BTPARA-REC
           END-IF
      *
           MOVE    "tbl_btpara"        TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-BTPARA-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ読込
      *****************************************************************
       900-BTPARA-READ-N-SEC          SECTION.
      *
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  BTPARA-REC
               MOVE    ZERO                TO  FLG-BTPARA
           ELSE
               MOVE    1                   TO  FLG-BTPARA
               INITIALIZE                      BTPARA-REC
           END-IF
      *
           .
       900-BTPARA-READ-N-EXT.
           EXIT.
      *
      *****************************************************************
      *    主科情報読込
      *****************************************************************
       900-SYUKA-READ-SEC         SECTION.
      *
           MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
               MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
               PERFORM 910-SYUKA-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SYUKA
           END-IF
      *
           MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-SYUKA-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    主科情報読込
      *****************************************************************
       910-SYUKA-NEXT-SEC         SECTION.
      * 
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC               =   ZERO
               MOVE    ZERO                 TO  FLG-SYUKA
               MOVE    MCPDATA-REC          TO  SYUKA-REC
           ELSE
               MOVE    1                    TO  FLG-SYUKA
               INITIALIZE                       SYUKA-REC
           END-IF
      *
           .
       910-SYUKA-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスター読込（対象請求管理データの存在チェック）
      *****************************************************************
       900-SEIKYU-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-SEIKYU-UMU
      *
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key59"             TO  MCP-PATHNAME
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key59"             TO  MCP-PATHNAME
               PERFORM 900-SEIKYU-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SEIKYU
           END-IF
      *
           PERFORM                 UNTIL   FLG-SEIKYU      =   1
                                   OR      FLG-SEIKYU-UMU  =   1
               EVALUATE    SPA-R01-RECEKBN
                   WHEN    "0"
                       IF      RECE10-TEISYUTUSAKI =   1   OR  2   OR  6
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
                   WHEN    "3"
                       IF      RECE10-TEISYUTUSAKI =   3
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
                   WHEN    "4"
                   WHEN    "5"
                       IF    ( RECE10-TEISYUTUSAKI =   4             )
                       AND   ( RECE10-HKNNUM       =
                                           WRK-CONS-JIBAISEKI-HKNNUM )
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
                   WHEN    "6"
                       IF      RECE10-TEISYUTUSAKI =   5
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
                   WHEN    "8"
                       IF    ( RECE10-TEISYUTUSAKI =   4             )
                       AND   ( RECE10-HKNNUM       =
                                           WRK-CONS-DAISANSYA-HKNNUM )
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
               END-EVALUATE
      * 
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key59"             TO  MCP-PATHNAME
               PERFORM 900-SEIKYU-NEXT-SEC
           END-PERFORM
      * 
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key59"             TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-SEIKYU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスター読込
      *****************************************************************
       900-SEIKYU-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC          =   ZERO
               MOVE    ZERO            TO  FLG-SEIKYU
               MOVE    MCPDATA-REC     TO  RECE10-REC
           ELSE
               MOVE    1               TO  FLG-SEIKYU
           END-IF
      *
           .
       900-SEIKYU-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスター読込（対象請求管理データの請求しない設定存在チェック）
      *****************************************************************
       900-SEIKYU-SKYKBN-CHECK-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-SEIKYU-UMU
      *
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key59"             TO  MCP-PATHNAME
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key59"             TO  MCP-PATHNAME
               PERFORM 900-SEIKYU-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SEIKYU
           END-IF
      *
           PERFORM                 UNTIL   FLG-SEIKYU      =   1
                                   OR      FLG-SEIKYU-UMU  =   1
               IF      RECE10-SKYKBN       =   "0"
                   EVALUATE    SPA-R01-RECEKBN
                     WHEN    "0"
                       IF      RECE10-TEISYUTUSAKI =   1   OR  2   OR  6
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
                     WHEN    "3"
                       IF      RECE10-TEISYUTUSAKI =   3
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
                     WHEN    "4"
                     WHEN    "5"
                       IF    ( RECE10-TEISYUTUSAKI =   4            )
                       AND   ( RECE10-HKNNUM       =
                                           WRK-CONS-JIBAISEKI-HKNNUM )
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
                     WHEN    "6"
                       IF      RECE10-TEISYUTUSAKI =   5
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
                     WHEN    "8"
                       IF    ( RECE10-TEISYUTUSAKI =   4             )
                       AND   ( RECE10-HKNNUM       =
                                           WRK-CONS-DAISANSYA-HKNNUM )
                           MOVE    1               TO  FLG-SEIKYU-UMU
                       END-IF
                   END-EVALUATE
               END-IF
      * 
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key59"             TO  MCP-PATHNAME
               PERFORM 900-SEIKYU-NEXT-SEC
           END-PERFORM
      * 
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key59"             TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-SEIKYU-SKYKBN-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト管理読込（キー）
      *****************************************************************
       900-RECE07-INV-SEC         SECTION.
      *
           MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
               MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
               PERFORM 900-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-RECE07
                   MOVE    MCPDATA-REC         TO  RECE07-REC
               ELSE
                   MOVE    1                   TO  FLG-RECE07
               END-IF
           ELSE
               MOVE    1                   TO  FLG-RECE07
           END-IF
      *
           MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-RECE07-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト管理（ＳＥＬＥＣＴ）
      *****************************************************************
       900-RECE07-SELECT-SEC           SECTION.
      *
           MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
           MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
               MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
               PERFORM 900-RECE07-FETCH-SEC
           ELSE
               MOVE    1                   TO  FLG-RECE07
           END-IF
      *
           .
       900-RECE07-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト管理（ＦＥＴＣＨ）
      *****************************************************************
       900-RECE07-FETCH-SEC            SECTION.
      *
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-RECE07
               MOVE    MCPDATA-REC         TO  RECE07-REC
           ELSE
               MOVE    1                   TO  FLG-RECE07
           END-IF
      *
           .
       900-RECE07-FETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト印刷読込処理
      *****************************************************************
       900-RECE08-INV-SEC           SECTION.
      *
           MOVE    "tbl_receprt"       TO  MCP-TABLE
           MOVE    "key44"             TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_receprt"       TO  MCP-TABLE
               MOVE    "key44"             TO  MCP-PATHNAME
               PERFORM 900-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-RECE08
                   MOVE    MCPDATA-REC         TO  RECE08-REC
               ELSE
                   MOVE    1                   TO  FLG-RECE08
               END-IF
           ELSE
               MOVE    1                   TO  FLG-RECE08
           END-IF
      *
           MOVE    "tbl_receprt"       TO  MCP-TABLE
           MOVE    "key44"             TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-RECE08-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    一時保存テーブルＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-SPATMP-DBSELECT-SEC                SECTION.
      *
           MOVE    SPATMP-REC          TO  MCPDATA2-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-SPATMP-CALL-SEC
      *
           .
       900-SPATMP-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    一時保存テーブルＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-SPATMP-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           PERFORM 900-SPATMP-CALL-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA2-REC    TO  SPATMP-REC
               MOVE    ZERO            TO  FLG-SPATMP
           ELSE
               INITIALIZE                  SPATMP-REC
               MOVE    1               TO  FLG-SPATMP
           END-IF
      *
           .
       900-SPATMP-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    一時保存テーブルクローズ処理
      *****************************************************************
       900-SPATMP-DBCLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           PERFORM 900-SPATMP-CALL-SEC
      *
           .
       900-SPATMP-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    一時保存テーブル削除処理
      *****************************************************************
       900-SPATMP-DBDELETE-SEC         SECTION.
      *
           MOVE    SPA-TERMID          TO  SPATMP-TERMID
           MOVE    SPA-HOSPNUM         TO  SPATMP-HOSPNUM
      *
           MOVE    SPATMP-REC          TO  MCPDATA2-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "del2"              TO  MCP-PATHNAME
           PERFORM 900-SPATMP-CALL-SEC
      *
           .
       900-SPATMP-DBDELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    一時保存テーブル検索処理
      *****************************************************************
       900-SPATMP-CALL-SEC                SECTION.
      *
           MOVE    "tbl_spa_tmp"       TO  MCP-TABLE
           CALL    "ORCDBSPATMP"       USING   MCPAREA
                                               MCPDATA2-REC
                                               SPA-AREA
      *
           .
       900-SPATMP-CALL-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    ジョブ管理ＤＢ制御処理
      *****************************************************************
       900-CALL-ORCSJOB-SEC            SECTION.
      *
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
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    No Commit処理
      *****************************************************************
       900-NOCOMMIT-SEC            SECTION.
      *
      * For Debug
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBOPEN"            TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBSTART"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
      * For Debug
      *
           .
       900-NOCOMMIT-EXT.
           EXIT.
      *
