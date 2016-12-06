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
      *    レセプト作成−印刷指示画面ＳＰＡ
           COPY    "R02SCR-SPA".
      *
       01  SPA-SCR-REC.
           COPY    "CPR02SPASCR.INC".
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
           03  SPA-R03-AREA.
               05  SPA-NAIB-R03-AREA.
                   07  SPA-NAI-SRYYM               PIC 9(06).
                   07  SPA-NAI-SRYYMH              PIC X(16).
                   07  SPA-NAI-NYUGAIKBN           PIC X(06).
      *
                   07  SPA-NAI-2005-AUTODSPKBN     PIC X(01).
                   07  SPA-NAI-200501-INSPECT-ZERO-KBN
                                                   PIC X(01).
                   07  SPA-NAI-200501-RECEIPT-MAKE-KBN
                                                   PIC X(01).
                   07  SPA-NAI-200505-HKNJANUM     PIC X(08).
                   07  SPA-NAI-200501-INSPECT-INCLUDE
                                                   PIC X(01).
                   07  SPA-NAI-9101-COOPBASE       PIC X(01).
                   07  SPA-NAI-9102-EFOUT          PIC X(01).
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
           COPY    "CPORCSGETTEMP.INC".
           COPY    "ORCA-BLOB".
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
           EVALUATE    RECEMAKEQ-REQUET-NUMBER
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
           IF      WRK-ERRCD       NOT =   SPACE
               GO  TO  200-MAIN-EXT
           END-IF
      *
           EVALUATE    RECEMAKEQ-REQUET-NUMBER
           WHEN    "01"
      *        処理実施処理
               PERFORM 2002-RECEIPT-MAKE-SEC
           WHEN    "02"
      *        処理確認処理
               PERFORM 2003-RECEIPT-CHECK-SEC
           WHEN    "03"
      *        キャンセル処理
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
      *    区分コード０１のデータ読み込み
           INITIALIZE                  SYS-200501-REC
           MOVE    "2005"          TO  SYS-200501-KANRICD
           MOVE    "01"            TO  SYS-200501-KBNCD
           MOVE    SPA-SYSYMD      TO  SYS-200501-STYUKYMD
                                       SYS-200501-EDYUKYMD
grpsys     MOVE    SPA-HOSPNUM     TO  SYS-200501-HOSPNUM
           MOVE    SYS-200501-REC  TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI    =   ZERO
               MOVE   MCPDATA-REC  TO  SYS-200501-REC
           ELSE
               INITIALIZE              SYS-200501-REC
               MOVE    SYS-2005-TERMID (1:4)
                                   TO  SYS-200501-TBL (1:4)
           END-IF
           IF      SYS-200501-INSPECT-ZERO-KBN
                                   =   SPACE
               MOVE    "0"             TO  SYS-200501-INSPECT-ZERO-KBN
           END-IF
           IF      SYS-200501-RECEIPT-MAKE-KBN
                                   =   SPACE
               MOVE    "1"             TO  SYS-200501-RECEIPT-MAKE-KBN
           END-IF
           IF      SYS-200501-INSPECT-INCLUDE-KBN
                                   =   SPACE
               MOVE    "0"             TO
                                       SYS-200501-INSPECT-INCLUDE-KBN
           END-IF
           MOVE    SYS-200501-INSPECT-ZERO-KBN
                                   TO  SPA-NAI-200501-INSPECT-ZERO-KBN
           MOVE    SYS-200501-INSPECT-INCLUDE-KBN
                                   TO
                                   SPA-NAI-200501-INSPECT-INCLUDE
           MOVE    SYS-200501-RECEIPT-MAKE-KBN
                                   TO  SPA-NAI-200501-RECEIPT-MAKE-KBN
           EVALUATE    SPA-NAI-200501-RECEIPT-MAKE-KBN
               WHEN    "1"
                   MOVE    SPA-GMN-PRTKBNLST (1)
                                           TO  SPA-GMN-PRTKBN-G
               WHEN    "2"
                   MOVE    SPA-GMN-PRTKBNLST (2)
                                           TO  SPA-GMN-PRTKBN-G
           END-EVALUATE
      *
      *    レセプト・総括編集情報（区分コード０５のデータ読込）
           INITIALIZE                  SYS-200505-REC
           MOVE    "2005"          TO  SYS-200505-KANRICD
           MOVE    "05"            TO  SYS-200505-KBNCD
           MOVE    SPA-SYSYMD      TO  SYS-200505-STYUKYMD
                                       SYS-200505-EDYUKYMD
grpsys     MOVE    SPA-HOSPNUM     TO  SYS-200505-HOSPNUM
           MOVE    SYS-200505-REC  TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI    =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-200505-REC
           ELSE
               INITIALIZE                  SYS-200505-REC
           END-IF
           MOVE    SYS-200505-HKNJANUM (1)
                                   TO  SPA-NAI-200505-HKNJANUM
      *
      *
      *    入外区分
           EVALUATE    RECEMAKEQ-INOUT
               WHEN    "I"
                   MOVE    "1"             TO  SPA-R01-NYUGAIKBN
               WHEN    "O"
                   MOVE    "2"             TO  SPA-R01-NYUGAIKBN
               WHEN    OTHER
                   MOVE    "012"           TO  WRK-ERRCD
           END-EVALUATE
      *
      *    提出先
           IF      WRK-ERRCD           =   SPACE
               EVALUATE    RECEMAKEQ-SUBMISSION-MODE
                   WHEN    "01"
                       MOVE    "0"         TO  SPA-R01-RECEKBN
                   WHEN    "02"
                       MOVE    "1"         TO  SPA-R01-RECEKBN
                   WHEN    "03"
                       MOVE    "2"         TO  SPA-R01-RECEKBN
                   WHEN    "04"
                       MOVE    "7"         TO  SPA-R01-RECEKBN
                   WHEN    "05"
                       MOVE    "3"         TO  SPA-R01-RECEKBN
                   WHEN    "06"
                       MOVE    "4"         TO  SPA-R01-RECEKBN
                   WHEN    "07"
                       MOVE    "5"         TO  SPA-R01-RECEKBN
                   WHEN    "08"
                       MOVE    "8"         TO  SPA-R01-RECEKBN
                   WHEN    "09"
                       MOVE    "6"         TO  SPA-R01-RECEKBN
                   WHEN    OTHER
                       MOVE    "013"       TO  WRK-ERRCD
               END-EVALUATE
           END-IF
      *
      *    レセプト作成区分
           IF      WRK-ERRCD           =   SPACE
               EVALUATE    RECEMAKEQ-PRINT-MODE
                   WHEN    "Check"
                       MOVE    "2"         TO  SPA-R01-PRTKBN
                   WHEN    OTHER
                       MOVE    "1"         TO  SPA-R01-PRTKBN
               END-EVALUATE
      *
      *        点検用レセ（０点公費あり、包括診療分あり）のとき
               IF     SPA-R01-PRTKBN      =   "2"
      *            医保分
                   IF    ( SPA-R01-RECEKBN     =   "0" OR  "1" OR
                                                   "2" OR  "7"    )
                       EVALUATE    SPA-NAI-200501-INSPECT-ZERO-KBN
                                   ALSO   SPA-NAI-200501-INSPECT-INCLUDE
                           WHEN    "1" ALSO    "0"
                               MOVE    "3"         TO  SPA-R01-PRTKBN
                           WHEN    "0" ALSO    "1"
                               MOVE    "4"         TO  SPA-R01-PRTKBN
                          WHEN    "1" ALSO    "1"
                              MOVE    "5"          TO  SPA-R01-PRTKBN
                       END-EVALUATE
                   ELSE
                       EVALUATE    SPA-NAI-200501-INSPECT-ZERO-KBN
                                   ALSO   SPA-NAI-200501-INSPECT-INCLUDE
                           WHEN    ANY ALSO    "1"
                               MOVE    "4"         TO  SPA-R01-PRTKBN
                       END-EVALUATE
                   END-IF
               END-IF
           END-IF
      *
      *    処理区分
           IF      WRK-ERRCD           =   SPACE
               EVALUATE    RECEMAKEQ-RECEIPT-MODE
                   WHEN    "All"
                       MOVE    "1"         TO  SPA-R01-FILEKBN
                   WHEN    OTHER
                       MOVE    "2"         TO  SPA-R01-FILEKBN
               END-EVALUATE
           END-IF
      *
           IF      WRK-ERRCD       NOT =   SPACE
               GO  TO  2001-INPUT-CHK-EXT
           END-IF
      *
      *??
           DISPLAY "SPA-R01-RECEKBN=" SPA-R01-RECEKBN "#" 
           DISPLAY "SPA-R01-FILEKBN=" SPA-R01-FILEKBN "#" 
           DISPLAY "SPA-R01-PRTKBN =" SPA-R01-PRTKBN "#" 
      *??
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
      *            診療年月
                   MOVE    RECEMAKEQ-PERFORM-MONTH
                                               TO  WRK-HEN-DATE
                   PERFORM 802-DAYHEN02-SEC
                   MOVE    WRK-SYMD (1:6)      TO  SPA-R01-SRYYM
      *
                   INITIALIZE                  ORCSGDAYAREA
                   MOVE    "1"             TO  SGDAY-INTYPE
                   MOVE    SPA-R01-SRYYM   TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"      USING   ORCSGDAYAREA
                   IF      SGDAY-RC        =   ZERO
                       IF    (  SPA-R01-SRYYM       <   200804 )
                       AND   (  SPA-R01-FILEKBN     =   "0"    )
                       AND   (  SPA-R01-PRTKBN      =   "2"    )
                           MOVE    "016"            TO  WRK-ERRCD
                       END-IF
                   ELSE
                       MOVE    "011"            TO  WRK-ERRCD
                   END-IF
               WHEN    "2"
                   MOVE    ZERO                TO  SPA-R01-SRYYM
                   MOVE    "1"                 TO  SPA-GMN-R01-SYORI
      *
                   PERFORM VARYING IDZZ    FROM    1   BY  1
                           UNTIL   IDZZ    >       WRK-CONS-LINE-MAX
                           OR      RECEMAKEQ-PATIENT-ID (IDZZ)
                                               =   SPACE
      *??
           DISPLAY "IDZZ=" IDZZ "#" RECEMAKEQ-PATIENT-ID (IDZZ)
                         "#" RECEMAKEQ-PATIENT-PERFORM-DATE (IDZZ) "#" 
      *??
                       MOVE    SPACE           TO  SPA-ERRCD
                                                   WRK-ERRCD
       *               患者番号
                       MOVE    RECEMAKEQ-PATIENT-ID (IDZZ)
                                               TO  WRK-PTNUM
                       INITIALIZE                  ORCSPTIDAREA
                       MOVE    SPA-HOSPNUM         TO  SPTID-HOSPNUM
                       MOVE    WRK-PTNUM           TO  SPTID-PTNUM
                       CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                                           SPA-AREA
                       IF      SPTID-RC        NOT =   ZERO
                           MOVE    "0003"          TO  SPA-ERRCD
                       ELSE
                           MOVE    SPTID-PTNUM     TO  SPA-GMN-R01-PTNUM
                           MOVE    SPTID-PTID      TO  SPA-NAI-R01-PTID
      *
      *                    患者マスター存在チェック
                           INITIALIZE                  PTINF-REC
                           MOVE    SPA-HOSPNUM     TO  PTINF-HOSPNUM
                           MOVE    SPTID-PTID      TO  PTINF-PTID
                           PERFORM 900-PTINF-READ-SEC
                           IF      FLG-PTINF       NOT =   ZERO
                               MOVE    "0003"          TO  SPA-ERRCD
                           ELSE
                               MOVE    PTINF-TSTPTNUMKBN   TO
                                               SPA-NAI-R01-TSTPTNUMKBN
                           END-IF
                       END-IF
      *                診療年月
                       IF      WRK-ERRCD       =   SPACE
                           MOVE    RECEMAKEQ-PATIENT-PERFORM-DATE (IDZZ)
                                                   TO  WRK-HEN-DATE
                           MOVE    SPACE           TO  WRK-HEN-TIME
                           PERFORM 802-DAYHEN02-SEC
                           MOVE    WRK-SYMD (1:6)  TO  SPA-NAI-R01-SRYYM
                           INITIALIZE                  ORCSGDAYAREA
                           MOVE    "1"             TO  SGDAY-INTYPE
                           MOVE    SPA-NAI-R01-SRYYM
                                                   TO  SGDAY-INDAY
                           CALL    "ORCSGDAY"      USING   ORCSGDAYAREA
                           IF      SGDAY-RC        =   ZERO
                               MOVE    SGDAY-OTDAY(1:6)
                                                   TO  SPA-GMN-R01-SRYYM
                               MOVE    SGDAY-SDAY (1:6)
                                                   TO  SPA-NAI-R01-SRYYM
                           ELSE
                               MOVE    "0009"              TO  SPA-ERRCD
                           END-IF
                       END-IF
      *
                       IF      WRK-ERRCD       =   SPACE
                           MOVE    SPA-R01-NYUGAIKBN
                                               TO  SPA-GMN-R01-NYUGAIKBN
      *                    個別対象患者チェック処理
                           PERFORM 41041-TUIKA-SEC
                       END-IF
      *??
           DISPLAY "IDZZ=" IDZZ "#" WRK-ERRCD "#" SPA-ERRCD "#" 
                   SPA-NAI-R01-DELETE  "#" SPA-NAI-R01-CHK "#"
      *??
      *
                       IF    ( WRK-ERRCD       =   SPACE )
                       AND   ( SPA-ERRCD       =   SPACE )
                           IF    ( SPA-NAI-R01-DELETE  =   1 )
                           OR    ( SPA-NAI-R01-CHK     =   1 )
                               PERFORM 20012-PATIENT-ERR-SEC
                           END-IF
                       ELSE
                           PERFORM 20012-PATIENT-ERR-SEC
                       END-IF
                   END-PERFORM
       *
                   IF      SPA-GMN-R01-MAX        =   ZERO
                       MOVE    "021"              TO  WRK-ERRCD
                  END-IF
           END-EVALUATE
      *
           .
       2001-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別対象患者チェック処理
      *****************************************************************
       41041-TUIKA-SEC                SECTION.
      *
      **** IF      SPA-GMN-R01-MAX     =   WRK-CONS-LINE-MAX
      ****     MOVE    "0002"              TO  SPA-ERRCD
      ****     GO      TO      41041-TUIKA-EXT
      **** END-IF
      *
           PERFORM 4203-KOMOKUCHK-SEC
           IF    ( SPA-ERRCD    NOT =   SPACE )
           OR    ( SPA-RIDCD    NOT =   SPACE )
               GO  TO  41041-TUIKA-EXT
           END-IF    
      *
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "0"
               WHEN    "3"
                   PERFORM 4204-SRYYM-CHK-SEC
                   IF      SPA-ERRCD    NOT =   SPACE
                       GO  TO  41041-TUIKA-EXT
                   END-IF
           END-EVALUATE    
      *
           COMPUTE IDY     =   SPA-GMN-R01-MAX  +   1
           PERFORM 4202-INTBL-CHK-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  41041-TUIKA-EXT
           END-IF
      *    
           ADD     1                TO  SPA-GMN-R01-MAX
           MOVE    SPA-GMN-R01-MAX      TO
                                SPA-GMN-R01-TRENNUM   (SPA-GMN-R01-MAX)
           MOVE    SPA-GMN-R01-MAX          TO  IDX
           PERFORM 4201-INTBL-SET-SEC
      *
      **** MOVE    SPA-GMN-R01-MAX  TO  R01-ROW
      *
      **** MOVE    4                TO  SPA-GMN-R01-CUR  
      *
           .
       41041-TUIKA-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4203-KOMOKUCHK-SEC           SECTION.
      *
           MOVE    SPACE                TO  SPA-ERRCD
      **** MOVE    SPA-GMN-R01-CUR          TO  WRK-GMN-CUR
      * 
      *****PERFORM 4103-PTNUM-CHK-SEC
      *
      *****IF      SPA-GMN-R01-NYUGAIKBN    =   SPACE
      *****    MOVE    SPA-R01-NYUGAIKBN    TO  SPA-GMN-R01-NYUGAIKBN
      *****END-IF
      *
      *    自賠責（新様式）のとき健保準拠かチェック
           IF    ( SPA-R01-RECEKBN     =   "4" )
               INITIALIZE                  SYS-4001-REC
               MOVE    "4001"              TO  SYS-4001-KANRICD
               MOVE    "*"                 TO  SYS-4001-KBNCD
               MOVE    SPA-NAI-R01-SRYYM   TO  SYS-4001-STYUKYMD(1:6)
               MOVE    "01"                TO  SYS-4001-STYUKYMD(7:2)
               MOVE    SYS-4001-STYUKYMD   TO  SYS-4001-EDYUKYMD
               MOVE    SPA-HOSPNUM         TO  SYS-4001-HOSPNUM
               MOVE    SYS-4001-REC        TO  MCPDATA-REC
               PERFORM 900-SYSKANRI-INV-SEC
               IF      FLG-SYSKANRI        =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-4001-REC
               ELSE
                  INITIALIZE                   SYS-4001-REC
               END-IF
               IF      SYS-4001-JIBAIKBN   =   "2"
                   MOVE    "0036"              TO  SPA-ERRCD
                   MOVE    5                   TO  SPA-GMN-R01-CUR
                   GO  TO  4203-KOMOKUCHK-EXT
               END-IF
            END-IF
      *
      *    診療会計チェック
           MOVE    SPA-NAI-R01-PTID    TO  WRK-ACCT-PTID
           MOVE    SPA-NAI-R01-SRYYM   TO  WRK-ACCT-SRYYM
           MOVE    SPA-GMN-R01-NYUGAIKBN
                                       TO  WRK-ACCT-NYUGAIKBN
           PERFORM 42031-SRYACCT-CHK-SEC
      *
      *    診療会計が存在しないとき入院会計をチェック（入院のみ）
           IF    ( FLG-ERR             =   ZERO )
           AND   ( SPA-R01-NYUGAIKBN   =   "1"  )
               PERFORM 42032-NYUINACCT-CHK-SEC
           END-IF
      *          
           IF      FLG-ERR             =   1
               MOVE    "0008"              TO  SPA-ERRCD
           ELSE 
               IF      FLG-CHK             =   ZERO
                   MOVE    "0006"              TO  SPA-ERRCD
               ELSE 
                   IF    ( SPA-R01-NYUGAIKBN   =   "1"  )
                   AND   ( FLG-ZAISKBKBN       =   ZERO )
                       MOVE    "0014"              TO  SPA-ERRCD
                   END-IF
               END-IF
           END-IF
      *
           IF      SPA-R01-PRTKBN       =   "9" OR  "8"
             CONTINUE
           ELSE
             IF      SPA-ERRCD            =   SPACE
      *        未請求設定のチェック（医保）
               IF      SPA-R01-RECEKBN     =   "0"
                   INITIALIZE                  SYUKA-REC
                   MOVE    SPA-HOSPNUM     TO  SYUKA-HOSPNUM
                   MOVE    SPA-NAI-R01-PTID
                                           TO  SYUKA-PTID
                   MOVE    SPA-NAI-R01-SRYYM
                                           TO  SYUKA-SRYYM
                   MOVE    SPA-GMN-R01-NYUGAIKBN
                                           TO  SYUKA-NYUGAIKBN
                   MOVE    "YYYY"          TO  SYUKA-RECESYUBETU
                   MOVE    SYUKA-REC       TO  MCPDATA-REC
                   MOVE    "tbl_syuka"     TO  WRK-MCP-TABLE
                   MOVE    "key15"         TO  WRK-MCP-PATHNAME
                   PERFORM 900-SYUKA-READ-SEC
                   IF      FLG-SYUKA       =   ZERO
                       IF      SYUKA-MISEIKYU-FLG   =   "01"
                           MOVE    "0035"               TO  SPA-ERRCD
                       END-IF
                   END-IF
               END-IF
      *        請求しない設定の存在チェック
               IF      SPA-ERRCD           =   SPACE
                   INITIALIZE                      RECE10-REC
                   MOVE    SPA-HOSPNUM         TO  RECE10-HOSPNUM
                   MOVE    SPA-NAI-R01-SRYYM   TO  RECE10-SRYYM
                   MOVE    SPA-GMN-R01-NYUGAIKBN
                                               TO  RECE10-NYUGAIKBN
                   MOVE    SPA-NAI-R01-PTID    TO  RECE10-PTID
                   PERFORM 900-SEIKYU-SKYKBN-CHECK-SEC
                   IF      FLG-SEIKYU-UMU      =   1
                       MOVE    1                   TO  SPA-NAI-R01-CHK
                   ELSE
                       MOVE    ZERO                TO  SPA-NAI-R01-CHK
                   END-IF
               END-IF
             ELSE
      *        請求管理テーブルの存在チェック
               EVALUATE    SPA-ERRCD
                   WHEN    "0006"
                   WHEN    "0008"
                   WHEN    "0014"
                       INITIALIZE                  RECE10-REC
                       MOVE    SPA-HOSPNUM     TO  RECE10-HOSPNUM
                       MOVE    SPA-NAI-R01-SRYYM
                                               TO  RECE10-SRYYM
                       MOVE    SPA-GMN-R01-NYUGAIKBN
                                               TO  RECE10-NYUGAIKBN
                       MOVE    SPA-NAI-R01-PTID
                                               TO  RECE10-PTID
                       PERFORM 900-SEIKYU-READ-SEC
                       IF      FLG-SEIKYU-UMU  =   1
                           MOVE    1               TO
                                                   SPA-NAI-R01-DELETE
      *                    請求データ削除処理
                           MOVE    SPA-NAI-R01-SRYYM
                                                   TO  WRK-ACCT-SRYYM
                           MOVE    SPA-GMN-R01-NYUGAIKBN
                                                   TO
                                                   WRK-ACCT-NYUGAIKBN
                           MOVE    SPA-NAI-R01-PTID
                                                   TO  WRK-ACCT-PTID
                           PERFORM 4801-DBDELETE-SYORI-SEC
                           IF      SPA-ERRCD   NOT =   SPACE
                              GO  TO  4203-KOMOKUCHK-EXT
                           END-IF 
                       END-IF    
               END-EVALUATE
             END-IF
           END-IF
           .
       4203-KOMOKUCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求データ削除処理
      *****************************************************************
       4801-DBDELETE-SYORI-SEC         SECTION.
      *
      *    請求管理削除
           INITIALIZE                  RECE10-REC
           MOVE    SPA-HOSPNUM     TO  RECE10-HOSPNUM
           MOVE    WRK-ACCT-SRYYM  TO  RECE10-SRYYM
           MOVE    WRK-ACCT-NYUGAIKBN
                                   TO  RECE10-NYUGAIKBN
           MOVE    WRK-ACCT-PTID   TO  RECE10-PTID
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "0"
                   MOVE    1               TO  RECE10-TEISYUTUSAKI
                   MOVE    2               TO  RECE10-XXTEISYUTUSAKI
               WHEN    "3"
                   MOVE    3               TO  RECE10-TEISYUTUSAKI
                   MOVE    3               TO  RECE10-XXTEISYUTUSAKI 
               WHEN    "4"
               WHEN    "5"
               WHEN    "8"
                   MOVE    4               TO  RECE10-TEISYUTUSAKI
                   MOVE    4               TO  RECE10-XXTEISYUTUSAKI 
                   IF      SPA-R01-RECEKBN =   "8"
                       MOVE    "970"           TO  RECE10-HKNNUM
                   ELSE
                       MOVE    "973"           TO  RECE10-HKNNUM
                   END-IF
               WHEN    "6"
                   MOVE    5               TO  RECE10-TEISYUTUSAKI
                   MOVE    5               TO  RECE10-XXTEISYUTUSAKI 
           END-EVALUATE
           MOVE    RECE10-REC      TO  MCPDATA-REC
           MOVE    "tbl_seikyu"    TO  MCP-TABLE
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "4"
               WHEN    "5"
               WHEN    "8"
                   MOVE    "del10"         TO  MCP-PATHNAME
               WHEN    OTHER
                   MOVE    "del7"          TO  MCP-PATHNAME
           END-EVALUATE
           MOVE    "DBDELETE"      TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC      NOT =   ZERO
               DISPLAY "SEIKYU KEY=" RECE10-KEY
               MOVE    "1002"          TO  SPA-ERRCD
               GO  TO  4801-DBDELETE-SYORI-EXT
           END-IF
      *
           IF      SPA-R01-RECEKBN =   "0"
               INITIALIZE                  RECE10-REC
               MOVE    SPA-HOSPNUM     TO  RECE10-HOSPNUM
               MOVE    WRK-ACCT-SRYYM  TO  RECE10-SRYYM
               MOVE    WRK-ACCT-NYUGAIKBN
                                       TO  RECE10-NYUGAIKBN
               MOVE    WRK-ACCT-PTID   TO  RECE10-PTID
               MOVE    6               TO  RECE10-TEISYUTUSAKI
               MOVE    6               TO  RECE10-XXTEISYUTUSAKI
               MOVE    RECE10-REC      TO  MCPDATA-REC
               MOVE    "tbl_seikyu"    TO  MCP-TABLE
               MOVE    "del7"          TO  MCP-PATHNAME
               MOVE    "DBDELETE"      TO  MCP-FUNC
               PERFORM 900-ORCDBMAIN-SEC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "SEIKYU KEY=" RECE10-KEY
                   MOVE    "1002"          TO  SPA-ERRCD
                   GO  TO  4801-DBDELETE-SYORI-EXT
               END-IF
           END-IF     
      *
           IF      SPA-R01-RECEKBN     =   "0"
      *        公費請求書削除
               INITIALIZE                  KOHSKY-REC
               MOVE    SPA-HOSPNUM     TO  KOHSKY-HOSPNUM
               MOVE    WRK-ACCT-SRYYM  TO  KOHSKY-SRYYM
               MOVE    WRK-ACCT-NYUGAIKBN
                                       TO  KOHSKY-NYUGAIKBN
               MOVE    WRK-ACCT-PTID   TO  KOHSKY-PTID
               MOVE    KOHSKY-REC      TO  MCPDATA-REC
               MOVE    "tbl_kohsky"    TO  MCP-TABLE
               MOVE    "del4"          TO  MCP-PATHNAME
               MOVE    "DBDELETE"      TO  MCP-FUNC
               PERFORM 900-ORCDBMAIN-SEC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "KOHKSY KEY=" KOHSKY-KEY
                   MOVE    "1003"          TO  SPA-ERRCD
                   GO  TO  4801-DBDELETE-SYORI-EXT
               END-IF
      *        レセ電削除
               INITIALIZE                  RECEDEN-REC
               MOVE    SPA-HOSPNUM     TO  RECEDEN-HOSPNUM
               MOVE    WRK-ACCT-SRYYM  TO  RECEDEN-SRYYM
               MOVE    WRK-ACCT-NYUGAIKBN
                                       TO  RECEDEN-NYUGAIKBN
               MOVE    WRK-ACCT-PTID   TO  RECEDEN-PTID
               MOVE    1               TO  RECEDEN-TEISYUTUSAKI
               MOVE    RECEDEN-REC     TO  MCPDATA-REC
               MOVE    "tbl_receden"   TO  MCP-TABLE
               MOVE    "del4"          TO  MCP-PATHNAME
               MOVE    "DBDELETE"      TO  MCP-FUNC
               PERFORM 900-ORCDBMAIN-SEC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "RECEDEN KEY=" RECEDEN-KEY
                   MOVE    "1004"          TO  SPA-ERRCD
                   GO  TO  4801-DBDELETE-SYORI-EXT
               END-IF
      *
               INITIALIZE                  RECEDEN-REC
               MOVE    SPA-HOSPNUM     TO  RECEDEN-HOSPNUM
               MOVE    WRK-ACCT-SRYYM  TO  RECEDEN-SRYYM
               MOVE    WRK-ACCT-NYUGAIKBN
                                       TO  RECEDEN-NYUGAIKBN
               MOVE    WRK-ACCT-PTID   TO  RECEDEN-PTID
               MOVE    2               TO  RECEDEN-TEISYUTUSAKI
               MOVE    RECEDEN-REC     TO  MCPDATA-REC
               MOVE    "tbl_receden"   TO  MCP-TABLE
               MOVE    "del4"          TO  MCP-PATHNAME
               MOVE    "DBDELETE"      TO  MCP-FUNC
               PERFORM 900-ORCDBMAIN-SEC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "RECEDEN KEY=" RECEDEN-KEY
                   MOVE    "1004"          TO  SPA-ERRCD
                   GO  TO  4801-DBDELETE-SYORI-EXT
               END-IF
      *
               INITIALIZE                  RECEDEN-REC
               MOVE    SPA-HOSPNUM     TO  RECEDEN-HOSPNUM
               MOVE    WRK-ACCT-SRYYM  TO  RECEDEN-SRYYM
               MOVE    WRK-ACCT-NYUGAIKBN
                                       TO  RECEDEN-NYUGAIKBN
               MOVE    WRK-ACCT-PTID   TO  RECEDEN-PTID
               MOVE    6               TO  RECEDEN-TEISYUTUSAKI
               MOVE    RECEDEN-REC     TO  MCPDATA-REC
               MOVE    "tbl_receden"   TO  MCP-TABLE
               MOVE    "del4"          TO  MCP-PATHNAME
               MOVE    "DBDELETE"      TO  MCP-FUNC
               PERFORM 900-ORCDBMAIN-SEC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "RECEDEN KEY=" RECEDEN-KEY
                   MOVE    "1004"          TO  SPA-ERRCD
                   GO  TO  4801-DBDELETE-SYORI-EXT
               END-IF
           END-IF     
      *
           IF    ( SPA-R01-RECEKBN     =   "3"      )
           AND   ( WRK-ACCT-SRYYM      >=  "201307" )
      *        レセ電削除
               INITIALIZE                  RECEDEN-REC
               MOVE    SPA-HOSPNUM     TO  RECEDEN-HOSPNUM
               MOVE    WRK-ACCT-SRYYM  TO  RECEDEN-SRYYM
               MOVE    WRK-ACCT-NYUGAIKBN
                                       TO  RECEDEN-NYUGAIKBN
               MOVE    WRK-ACCT-PTID   TO  RECEDEN-PTID
               MOVE    3               TO  RECEDEN-TEISYUTUSAKI
               MOVE    RECEDEN-REC     TO  MCPDATA-REC
               MOVE    "tbl_receden"   TO  MCP-TABLE
               MOVE    "del4"          TO  MCP-PATHNAME
               MOVE    "DBDELETE"      TO  MCP-FUNC
               PERFORM 900-ORCDBMAIN-SEC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "RECEDEN KEY=" RECEDEN-KEY
                   MOVE    "1004"          TO  SPA-ERRCD
                   GO  TO  4801-DBDELETE-SYORI-EXT
               END-IF
           END-IF
           .
      *
       4801-DBDELETE-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計チェック処理
      *****************************************************************
       42031-SRYACCT-CHK-SEC           SECTION.
      * 
           MOVE    ZERO                TO  FLG-CHK
                                           FLG-ERR
                                           FLG-ZAISKBKBN
      *     
           INITIALIZE                      SRYACCT-REC
           MOVE    SPA-HOSPNUM         TO  ACCT-HOSPNUM
           MOVE    WRK-ACCT-PTID       TO  ACCT-PTID
           MOVE    WRK-ACCT-SRYYM      TO  ACCT-SRYYM
           MOVE    WRK-ACCT-NYUGAIKBN  TO  ACCT-NYUGAIKBN
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "tbl_sryacct"   TO  MCP-TABLE
           MOVE    "key30"         TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC          =   ZERO
               MOVE    "tbl_sryacct"   TO  MCP-TABLE
               MOVE    "key30"         TO  MCP-PATHNAME
               PERFORM 900-SRYACCT-READ-SEC
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           PERFORM             UNTIL   FLG-SRYACCT     =   1
                               OR      FLG-CHK         =   1
                               OR      FLG-ERR         =   1
               MOVE    KEY-NEW             TO  KEY-OLD
      *     
      *        保険組合せ読込み
               INITIALIZE                  HKNCOMBI-REC
               MOVE    SPA-HOSPNUM         TO  COMB-HOSPNUM
               MOVE    ACCT-PTID           TO  COMB-PTID
               MOVE    ACCT-HKNCOMBI       TO  COMB-HKNCOMBINUM 
               MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
               PERFORM  910-HKNCOMBI-INV-SEC
      *
               IF      FLG-HKNCOMBI        =   ZERO
                   EVALUATE    SPA-R01-RECEKBN
                       WHEN    "0"
                           IF    ( COMB-HKNNUM =
                                           WRK-CONS-ROUSAI-HKNNUM    )
                           OR    ( COMB-HKNNUM =
                                           WRK-CONS-JIBAISEKI-HKNNUM )
                           OR    ( COMB-HKNNUM =
                                           WRK-CONS-KOUGAI-HKNNUM    )
                               CONTINUE
                           ELSE    
                               MOVE    1           TO  FLG-CHK
                           END-IF
                       WHEN    "3"
                           IF      COMB-HKNNUM =
                                           WRK-CONS-ROUSAI-HKNNUM
                               MOVE    1           TO  FLG-CHK
                           END-IF
                       WHEN    "4"
                       WHEN    "5"
                           IF      COMB-HKNNUM =
                                           WRK-CONS-JIBAISEKI-HKNNUM
                               MOVE    1           TO  FLG-CHK
                           END-IF
                       WHEN    "6"
                           IF      COMB-HKNNUM =
                                           WRK-CONS-KOUGAI-HKNNUM
                               MOVE    1           TO  FLG-CHK
                           END-IF
                       WHEN    "8"
                           IF      COMB-KOHHKNNUM (1)
                                               =
                                           WRK-CONS-DAISANSYA-HKNNUM
                               MOVE    1           TO  FLG-CHK
                           END-IF
                   END-EVALUATE
               ELSE
                   MOVE    1                   TO  FLG-ERR
               END-IF        
      *
               PERFORM UNTIL   FLG-SRYACCT     =   1
                       OR      FLG-CHK         =   1
                       OR      FLG-ERR         =   1 
                       OR      KEY-NEW     NOT =   KEY-OLD
                   MOVE    "tbl_sryacct"   TO  MCP-TABLE
                   MOVE    "key30"         TO  MCP-PATHNAME
                   PERFORM 900-SRYACCT-READ-SEC
               END-PERFORM
           END-PERFORM
      *    カーソルクロース
           MOVE    "tbl_sryacct"   TO  MCP-TABLE
           MOVE    "key30"         TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
           .
       42031-SRYACCT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計チェック処理
      *****************************************************************
       42032-NYUINACCT-CHK-SEC           SECTION.
      *     
      *    入院会計読込み（基本）
           INITIALIZE                  NYUINACCT-REC
           MOVE    SPA-HOSPNUM         TO  NACCT-HOSPNUM
           MOVE    WRK-ACCT-PTID       TO  NACCT-PTID
           MOVE    WRK-ACCT-SRYYM      TO  NACCT-SRYYM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key14"             TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key14"             TO  MCP-PATHNAME
               PERFORM  900-NYUINACCT-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-NYUINACCT    
           END-IF
      *
           PERFORM             UNTIL    FLG-NYUINACCT  =   1
                               OR       FLG-ERR        =   1      
      *        保険組合せ読込み
               IF      NACCT-ZAISKBKBN     =   "1"
                   MOVE    1                   TO  FLG-ZAISKBKBN
               END-IF
               IF      NACCT-ZAISKBKBN     =   "5"
                 PERFORM VARYING IDXX    FROM    1   BY  1
                         UNTIL   IDXX    >       31
                         OR      FLG-CHK =       1
                         OR      FLG-ERR =       1     
                   IF      NACCT-DAY (IDXX)      >   ZERO    
                       INITIALIZE                  HKNCOMBI-REC
                       MOVE    NACCT-HOSPNUM       TO  COMB-HOSPNUM
                       MOVE    NACCT-PTID          TO  COMB-PTID
                       MOVE    NACCT-DAY (IDXX)    TO  COMB-HKNCOMBINUM 
                       MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
                       PERFORM  910-HKNCOMBI-INV-SEC
      *
                       IF      FLG-HKNCOMBI        =   ZERO
                         EVALUATE    SPA-R01-RECEKBN
                           WHEN    "0"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-ROUSAI-HKNNUM
                               OR      COMB-HKNNUM =
                                               WRK-CONS-JIBAISEKI-HKNNUM
                               OR      COMB-HKNNUM =
                                               WRK-CONS-KOUGAI-HKNNUM
                                   CONTINUE
                               ELSE    
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                           WHEN    "3"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-ROUSAI-HKNNUM
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                           WHEN    "4"
                           WHEN    "5"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-JIBAISEKI-HKNNUM
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                           WHEN    "6"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-KOUGAI-HKNNUM
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                           WHEN    "8"
                               IF      COMB-KOHHKNNUM (1)
                                                   =
                                               WRK-CONS-DAISANSYA-HKNNUM
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                         END-EVALUATE 
                       ELSE
                         MOVE    1                 TO  FLG-ERR
                       END-IF
                   END-IF
                 END-PERFORM
                 MOVE    1                   TO  FLG-NYUINACCT 
               ELSE            
                 MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
                 MOVE    "key14"             TO  MCP-PATHNAME
                 PERFORM  900-NYUINACCT-READ-SEC
               END-IF
           END-PERFORM    
      *    カーソルクロース
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key14"             TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
      *    会計が見つからないとき、同日再入院があれば保険組合せ読込みをチェック
           IF    ( FLG-ERR             =   ZERO )
           AND   ( FLG-CHK             =   ZERO )
               INITIALIZE                      ORCSNYUINDAY-AREA
               MOVE    SPA-HOSPNUM         TO  LNK-NYUINDAY-HOSPNUM
               MOVE    WRK-ACCT-PTID       TO  LNK-NYUINDAY-PTID
               MOVE    WRK-ACCT-SRYYM      TO  LNK-NYUINDAY-SANTEIYM
               CALL    "ORCSNYUINDAY"      USING   ORCSNYUINDAY-AREA
                                                   SPA-AREA
               IF      LNK-NYUINDAY-RC >   0
                   GO  TO  42032-NYUINACCT-CHK-EXT
               END-IF
      *
               PERFORM VARYING IDXX    FROM    1   BY  1
                       UNTIL   IDXX    >       31
                       OR      FLG-CHK =       1
                       OR      FLG-ERR =       1     
                   IF      LNK-NYUINDAY-DOUJITSU-KBN (IDXX)
                                               =   "1"
                       INITIALIZE                      HKNCOMBI-REC
                       MOVE    SPA-HOSPNUM         TO  COMB-HOSPNUM
                       MOVE    WRK-ACCT-PTID       TO  COMB-PTID
                       MOVE    LNK-NYUINDAY-DOUJITSU-HKNCOMBI (IDXX)
                                                   TO  COMB-HKNCOMBINUM 
                       MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
                       PERFORM  910-HKNCOMBI-INV-SEC
      *
                       IF      FLG-HKNCOMBI        =   ZERO
                         EVALUATE    SPA-R01-RECEKBN
                           WHEN    "0"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-ROUSAI-HKNNUM
                               OR      COMB-HKNNUM =
                                               WRK-CONS-JIBAISEKI-HKNNUM
                               OR      COMB-HKNNUM =
                                               WRK-CONS-KOUGAI-HKNNUM
                                   CONTINUE
                               ELSE    
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                           WHEN    "3"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-ROUSAI-HKNNUM
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                           WHEN    "4"
                           WHEN    "5"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-JIBAISEKI-HKNNUM
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                           WHEN    "6"
                               IF      COMB-HKNNUM =
                                               WRK-CONS-KOUGAI-HKNNUM
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                           WHEN    "8"
                               IF      COMB-KOHHKNNUM (1)
                                                   =
                                               WRK-CONS-DAISANSYA-HKNNUM
                                   MOVE    1           TO  FLG-CHK
                               END-IF
                         END-EVALUATE 
                       ELSE
                         MOVE    1                 TO  FLG-ERR
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
           .
       42032-NYUINACCT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       診療年月の改正前・後の重複チェック処理
      *****************************************************************
       4204-SRYYM-CHK-SEC           SECTION.
      *
           EVALUATE    SPA-R01-RECEKBN ALSO    SPA-R01-NYUGAIKBN
               WHEN    "0"             ALSO    ANY
                   IF      SPA-NAI-R01-DELETE  =   1
                       CONTINUE
                   ELSE
      *                追加のときまたは１行
                       IF    ( SPA-GMN-R01-MAX      =   ZERO         )
                       OR    ( SPA-GMN-R01-MAX      =   1       AND 
                               SPA-GMN-R01-RENNUM   =   1            )
                           IF      SPA-NAI-R01-SRYYM    <   200210
                               MOVE    "1"      TO  SPA-NAI-R01-SYOKBN
                           ELSE
                               IF      SPA-NAI-R01-SRYYM    <   200804
                                   MOVE    "2"  TO  SPA-NAI-R01-SYOKBN
                               ELSE
                                   MOVE    "3"  TO  SPA-NAI-R01-SYOKBN
                               END-IF
                           END-IF
                       ELSE
                           EVALUATE    SPA-NAI-R01-SYOKBN
                               WHEN    "1"
                                   IF      SPA-NAI-R01-SRYYM
                                                           <   200210
                                       CONTINUE
                                   ELSE
                                       IF      SPA-NAI-R01-SRYYM
                                                           >=  200804
                                           MOVE    "0039"  TO  SPA-ERRCD
                                       ELSE 
                                           MOVE    "0007"  TO  SPA-ERRCD
                                       END-IF
                                   END-IF                                  
                               WHEN    "2"
                                   IF      SPA-NAI-R01-SRYYM
                                                           <   200210
                                       MOVE    "0007"      TO  SPA-ERRCD
                                   ELSE
                                       IF      SPA-NAI-R01-SRYYM
                                                           >=  200804
                                           MOVE    "0039"  TO  SPA-ERRCD
                                       END-IF
                                   END-IF
                               WHEN    "3"
                                   IF      SPA-NAI-R01-SRYYM
                                                           <   200804
                                       MOVE    "0039"      TO  SPA-ERRCD
                                   END-IF
                           END-EVALUATE
                       END-IF
                   END-IF                  
               WHEN    "3"             ALSO    "1"
      *            追加のときまたは１行
                   IF    ( SPA-GMN-R01-MAX      =   ZERO         )
                   OR    ( SPA-GMN-R01-MAX      =   1       AND 
                           SPA-GMN-R01-RENNUM   =   1            )
                       IF      SPA-NAI-R01-SRYYM    <   200610
                           MOVE    "1"          TO  SPA-NAI-R01-SYOKBN
                       ELSE
                           MOVE    "2"          TO  SPA-NAI-R01-SYOKBN
                       END-IF
                   ELSE
                       IF      SPA-NAI-R01-SYOKBN   =   "1"
                           IF      SPA-NAI-R01-SRYYM    <   200610
                               CONTINUE
                           ELSE
                               MOVE    "0029"           TO  SPA-ERRCD
                           END-IF
                       ELSE
                           IF      SPA-NAI-R01-SRYYM    >=  200610
                               CONTINUE
                           ELSE
                               MOVE    "0029"           TO  SPA-ERRCD
                           END-IF
                       END-IF
                   END-IF
           END-EVALUATE
      *
           IF      SPA-ERRCD            =   SPACE
               CONTINUE
           ELSE
               MOVE    5                    TO  SPA-GMN-R01-CUR
           END-IF
           .
       4204-SRYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目重複チェック処理
      *****************************************************************
       4202-INTBL-CHK-SEC                SECTION.
      *
           MOVE    SPACE                   TO  SPA-ERRCD
      * 
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       WRK-CONS-LINE-MAX
                   OR      SPA-ERRCD   NOT =   SPACE
               IF      IDX         =   IDY 
                   CONTINUE
               ELSE
                   IF    ( SPA-NAI-R01-TPTID     (IDX)
                                           =   SPA-NAI-R01-PTID      )
                   AND   ( SPA-GMN-R01-TSRYYM    (IDX)
                                           =   SPA-GMN-R01-SRYYM     )
                   AND   ( SPA-GMN-R01-TNYUGAIKBN(IDX)
                                           =   SPA-GMN-R01-NYUGAIKBN )
                       MOVE    "0005"              TO  SPA-ERRCD
                       MOVE    WRK-CONS-LINE-MAX   TO  IDX
                   END-IF
               END-IF
           END-PERFORM
           .                   
       4202-INTBL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目編集処理
      *****************************************************************
       4201-INTBL-SET-SEC                SECTION.
      *
           MOVE    SPA-GMN-R01-PTNUM   TO  SPA-GMN-R01-TPTNUM    (IDX)
           MOVE    SPA-NAI-R01-PTID    TO  SPA-NAI-R01-TPTID     (IDX)
           MOVE    SPA-GMN-R01-NAME    TO  SPA-GMN-R01-TNAME     (IDX)
           MOVE    SPA-GMN-R01-SRYYM   TO  SPA-GMN-R01-TSRYYM    (IDX)
           MOVE    SPA-NAI-R01-SRYYM   TO  SPA-NAI-R01-TSRYYM    (IDX)
           MOVE    SPA-GMN-R01-NYUGAIKBN
                                       TO  SPA-GMN-R01-TNYUGAIKBN(IDX)
           IF      SPA-NAI-R01-TSTPTNUMKBN  =   "1"
               MOVE    "テ"            TO  SPA-GMN-R01-TTSTPTNUMKBN(IDX)
           END-IF
           MOVE    SPA-NAI-R01-DELETE  TO  SPA-NAI-R01-TDELETE   (IDX)
           IF      SPA-NAI-R01-DELETE  =   1
               STRING  "［削除］"             DELIMITED  BY  SIZE
                       SPA-GMN-R01-NAME       DELIMITED  BY  SPACE
                                       INTO    SPA-GMN-R01-TNAME (IDX)      
               END-STRING
           END-IF
           MOVE    SPA-NAI-R01-CHK    TO  SPA-NAI-R01-TCHK (IDX)
      * 
           INITIALIZE                  SPA-GMN-R01-KOUMOKU
                                       SPA-NAI-R01-KOUMOKU
           MOVE    ZERO                TO  SPA-NAI-R01-SELNO                             
      *
          .
       4201-INTBL-SET-EXT.
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
           .
       20012-PATIENT-ERR-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト作成処理
      *****************************************************************
       2002-RECEIPT-MAKE-SEC     SECTION.
      *
           IF      SPA-R01-FILEKBN     =   "2"
               MOVE    "1"                 TO  SPA-GMN-R01-SYOKBN
           END-IF
      *
      *    点検用レセプトで平成２００８年３月以前のときは提出用に変更
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "2"
                   MOVE    ZERO            TO  SPA-NAI-R01-PRTKBN-FLG
                   IF      SPA-R01-PRTKBN  =   "2" OR  "3"
                                           OR  "4" OR  "5"
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       SPA-GMN-R01-MAX
                               OR      SPA-NAI-R01-PRTKBN-FLG
                                           =       1
                           IF    ( SPA-GMN-R01-SYORI
                                                   =   "4" OR  "5" )
                           AND   ( SPA-NAI-R01-TTAISYO (IDX)
                                                   =   0           )
                               CONTINUE
                           ELSE  
                               IF   ( SPA-NAI-R01-TDELETE (IDX)
                                                   =   1           )
                                   CONTINUE
                               ELSE
                                   IF      SPA-NAI-R01-TSRYYM (IDX)
                                                       <   200804
                                       MOVE    1       TO
                                               SPA-NAI-R01-PRTKBN-FLG
                                   END-IF
                               END-IF
                           END-IF
                       END-PERFORM
      *
                       IF      SPA-NAI-R01-PRTKBN-FLG  =   1
                           MOVE    "1"             TO  SPA-R01-PRTKBN
                           MOVE    "???"           TO  WRK-ERRCD
                       END-IF
                   END-IF
           END-EVALUATE
      *
      *    ジョブ管理チェック処理
           PERFORM 800-JOBKANRI-CHK-SEC
           IF      WRK-ERRCD      NOT =   SPACE
               GO  TO  2002-RECEIPT-MAKE-EXT
           END-IF
      *
      *    自賠責（新様式）のとき健保準拠か労災準拠のチェック
           IF    ( SPA-R01-RECEKBN     =   "4" )
               EVALUATE    SPA-R01-FILEKBN
                   WHEN    "1"
                       INITIALIZE                  SYS-4001-REC
                       MOVE    "4001"          TO  SYS-4001-KANRICD
                       MOVE    "*"             TO  SYS-4001-KBNCD
                       MOVE    SPA-R01-SRYYM   TO 
                                               SYS-4001-STYUKYMD(1:6)
                       MOVE    "01"            TO 
                                               SYS-4001-STYUKYMD(7:2)
                       MOVE    SYS-4001-STYUKYMD
                                               TO  SYS-4001-EDYUKYMD
                       MOVE    SPA-HOSPNUM     TO  SYS-4001-HOSPNUM
                       MOVE    SYS-4001-REC    TO  MCPDATA-REC
                       PERFORM 900-SYSKANRI-INV-SEC
                       IF      FLG-SYSKANRI        =   ZERO
                           MOVE    MCPDATA-REC     TO  SYS-4001-REC
                       ELSE
                           INITIALIZE                  SYS-4001-REC
                       END-IF
                       IF      SYS-4001-JIBAIKBN   =   "2"
                           MOVE    "014"               TO  WRK-ERRCD
                           GO  TO  2002-RECEIPT-MAKE-EXT
                       END-IF
                   WHEN    "2"
                       MOVE    ZERO                TO  FLG-4001-JIBAIKBN
      *
                       INITIALIZE                      SYS-4001-REC
                       MOVE    "4001"              TO  SYS-4001-KANRICD
                       MOVE    "*"                 TO  SYS-4001-KBNCD
                       MOVE    SPA-HOSPNUM         TO  SYS-4001-HOSPNUM
                       MOVE    SYS-4001-REC        TO  MCPDATA-REC
                       MOVE    "tbl_syskanri"      TO  MCP-TABLE
                       MOVE    "key8"              TO  MCP-PATHNAME
                       PERFORM 900-DBSELECT-SEC
                       IF      MCP-RC              =   ZERO
                           MOVE    "tbl_syskanri"      TO  MCP-TABLE
                           MOVE    "key8"              TO  MCP-PATHNAME
                           PERFORM  900-SYSKANRI-READ-SEC
                           PERFORM  UNTIL   FLG-SYSKANRI   =    1
                               MOVE    MCPDATA-REC     TO  SYS-4001-REC
                               IF      SYS-4001-JIBAIKBN   =   "2"
                                   CONTINUE
                               ELSE
                                   MOVE    1       TO  FLG-4001-JIBAIKBN
                                   MOVE    1       TO  FLG-SYSKANRI
                               END-IF
      *
                               MOVE    "tbl_syskanri"  TO  MCP-TABLE
                               MOVE    "key8"          TO  MCP-PATHNAME
                               PERFORM 900-SYSKANRI-READ-SEC
                           END-PERFORM
                       END-IF
                       MOVE    "tbl_syskanri"      TO  MCP-TABLE
                       MOVE    "key8"              TO  MCP-PATHNAME
                       PERFORM 900-CLOSE-SEC
      *
                       IF      FLG-4001-JIBAIKBN   =   ZERO
                           MOVE    "015"               TO  WRK-ERRCD
                           GO  TO  2002-RECEIPT-MAKE-EXT
                       END-IF
               END-EVALUATE
           END-IF
      *
      *    レセプト指示更新
           INITIALIZE                  SYS-2001-REC
           MOVE    "2001"              TO  SYS-2001-KANRICD
           MOVE    "*"                 TO  SYS-2001-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-2001-STYUKYMD
                                           SYS-2001-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-2001-HOSPNUM
           MOVE    SYS-2001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-2001-REC
           ELSE
               INITIALIZE                  SYS-2001-REC
               MOVE    SPA-HOSPNUM     TO  SYS-2001-HOSPNUM
               MOVE    "2001"          TO  SYS-2001-KANRICD
               MOVE    "*"             TO  SYS-2001-KBNCD
               MOVE    ZERO            TO  SYS-2001-STYUKYMD
               MOVE    ALL "9"         TO  SYS-2001-EDYUKYMD
           END-IF
           INITIALIZE                      SYS-2001-TBL
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   MOVE    "1"                 TO  SYS-2001-SYOKBN
                   MOVE    SPA-R01-RECEKBN     TO  SYS-2001-RECEKBN
                   MOVE    SPA-R01-NYUGAIKBN   TO  SYS-2001-NYUGAIKBN
                   MOVE    SPA-R01-SRYYM       TO  SYS-2001-SRYYM
                   IF      SPA-R01-PRTKBN      =   "1"
                       MOVE    SPACE               TO  SYS-2001-PRTKBN
                   ELSE
                       IF      SPA-R01-PRTKBN      =   "8" OR  "9"
                           MOVE    SPA-R01-PRTKBN  TO  SYS-2001-PRTKBN
                       ELSE
                           MOVE    "1"             TO  SYS-2001-PRTKBN
                       END-IF
                   END-IF
               WHEN    "2"
                   MOVE    "2"                 TO  SYS-2001-SYOKBN
                   MOVE    "000000"            TO  SYS-2001-SRYYM
                   MOVE    SPA-R01-RECEKBN     TO  SYS-2001-RECEKBN
                   MOVE    SPA-R01-NYUGAIKBN   TO  SYS-2001-NYUGAIKBN
                   MOVE    SPA-GMN-R01-SYORI   TO  SYS-2001-SYOSBT 
                   IF      SPA-R01-PRTKBN      =   "1"
                       MOVE    SPACE               TO  SYS-2001-PRTKBN
                   ELSE
                       IF      SPA-R01-PRTKBN      =   "8" OR  "9"
                           MOVE    SPA-R01-PRTKBN  TO  SYS-2001-PRTKBN
                       ELSE
                           MOVE    "1"             TO  SYS-2001-PRTKBN
                       END-IF
                   END-IF
           END-EVALUATE
      *
           MOVE    SYS-2001-REC        TO  MCPDATA-REC
           IF      FLG-SYSKANRI        =   1
               MOVE    "DBINSERT"          TO  MCP-FUNC
           ELSE
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           END-IF
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC          NOT =   ZERO 
               MOVE    "017"               TO  WRK-ERRCD
               DISPLAY "2001 SYSKANRI-KEY =>" SYS-2001-KEY 
               GO  TO  2002-RECEIPT-MAKE-EXT
           END-IF
      *
           IF      SPA-R01-FILEKBN     =   "2"
      *        個別指示削除処理
               INITIALIZE                  SYS-2002-REC
               MOVE    "2002"              TO  SYS-2002-KANRICD
               MOVE    "0001"              TO  SYS-2002-KBNCD
               MOVE    SPA-SYSYMD          TO  SYS-2002-STYUKYMD
                                               SYS-2002-EDYUKYMD
               MOVE    SPA-HOSPNUM         TO  SYS-2002-HOSPNUM
               MOVE    SYS-2002-REC        TO  MCPDATA-REC
               PERFORM 900-SYSKANRI-INV-SEC
               IF      FLG-SYSKANRI        =   ZERO
                   INITIALIZE                      SYS-2002-REC
                   MOVE    "2002"                  TO  SYS-2002-KANRICD
                   MOVE    SPA-SYSYMD              TO  SYS-2002-STYUKYMD
                                                       SYS-2002-EDYUKYMD
                   MOVE    SPA-HOSPNUM             TO  SYS-2002-HOSPNUM
                   MOVE    SYS-2002-REC            TO  MCPDATA-REC
                   MOVE    "DBDELETE"              TO  MCP-FUNC
                   MOVE    "tbl_syskanri"          TO  MCP-TABLE
                   MOVE    "del11"                 TO  MCP-PATHNAME
                   PERFORM 900-ORCDBMAIN-SEC
      *
                   IF      MCP-RC              NOT =   ZERO 
                       MOVE    "1001"                  TO  SPA-ERRCD
                       DISPLAY "SYSKANRI-KEY =>" SYS-2002-KEY 
                       GO  TO  2002-RECEIPT-MAKE-EXT
                   END-IF
               END-IF
      *
      *        個別指示登録処理
               MOVE    ZERO                TO  WRK-KBNCD-9
               MOVE    SPA-NAI-R01-TSRYYM (1)  TO  WRK-SRYYM
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-R01-MAX
                 IF    ( SPA-GMN-R01-SYORI     =   "4" OR  "5" )
                 AND   ( SPA-NAI-R01-TTAISYO (IDX)
                                               =   0           )
                    CONTINUE
                 ELSE  
                  IF   ( SPA-NAI-R01-TDELETE (IDX)
                                               =   1           )
                      CONTINUE
                  ELSE
                   IF      WRK-SRYYM       <   SPA-NAI-R01-TSRYYM(IDX)
                       MOVE    SPA-NAI-R01-TSRYYM(IDX)  TO  WRK-SRYYM
                   END-IF
      *
      *??
           DISPLAY "IDX=" IDX "#" SPA-GMN-R01-TPTNUM(IDX) 
                                "#" SPA-NAI-R01-TSRYYM(IDX) "#" 
      *??
                   INITIALIZE                  SYS-2002-REC
                   MOVE    "2002"              TO  SYS-2002-KANRICD
                   ADD     1                   TO  WRK-KBNCD-9
                   MOVE    WRK-KBNCD-X         TO  SYS-2002-KBNCD 
                   MOVE    ZERO                TO  SYS-2002-STYUKYMD
                   MOVE    ALL "9"             TO  SYS-2002-EDYUKYMD
                   MOVE    SPA-GMN-R01-TPTNUM(IDX) TO  SYS-2002-PTNUM
                   MOVE    SPA-NAI-R01-TPTID (IDX) TO  SYS-2002-PTID
                   MOVE    SPA-NAI-R01-TSRYYM(IDX) TO  SYS-2002-SRYYM
                   MOVE    SPA-R01-NYUGAIKBN   TO  SYS-2002-NYUGAIKBN
                   MOVE    SPA-TERMID          TO  SYS-2002-TERMID
                   MOVE    SPA-OPID            TO  SYS-2002-OPID
                   MOVE    SMCNDATE-YMD        TO  SYS-2002-CREYMD
                   MOVE    SMCNDATE-YMD        TO  SYS-2002-UPYMD
                   MOVE    SMCNDATE-HMS        TO  SYS-2002-UPHMS
                   MOVE    SPA-HOSPNUM         TO  SYS-2002-HOSPNUM
                   MOVE    SYS-2002-REC        TO  MCPDATA-REC
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "tbl_syskanri"          TO  MCP-TABLE
                   MOVE    "key"                   TO  MCP-PATHNAME
                   PERFORM 900-ORCDBMAIN-SEC
                   IF      MCP-RC          NOT =   ZERO 
                       MOVE    "1002"              TO  SPA-ERRCD
                       DISPLAY "2002 SYSKANRI-KEY =>" SYS-2002-KEY 
                       GO  TO  2002-RECEIPT-MAKE-EXT
                   END-IF
                  END-IF
                 END-IF
               END-PERFORM
           END-IF
      *
      *    パラメタＤＢ更新
           INITIALIZE                      BTPARA-REC
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  BTPARA-SHELLID
           MOVE    SPA-HOSPNUM         TO  BTPARA-HOSPNUM
           MOVE    BTPARA-REC          TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "tbl_btpara"        TO  MCP-TABLE
           MOVE    "del1"              TO  MCP-PATHNAME
           PERFORM 900-ORCDBMAIN-SEC
      *
           INITIALIZE                      BTPARA-REC
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  BTPARA-SHELLID
           MOVE    WRK-CONS-JOB-JOBID  TO  BTPARA-JOBID
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   MOVE    "00"                TO  BTPARA-INFO-KBN
               WHEN    "2"
                   MOVE    "01"                TO  BTPARA-INFO-KBN
           END-EVALUATE
           MOVE    SPA-TERMID          TO  BTPARA-TERMID
           MOVE    SPA-OPID            TO  BTPARA-OPID
           MOVE    SMCNDATE-YMD        TO  BTPARA-CREYMD
           MOVE    SMCNDATE-YMD        TO  BTPARA-UPYMD
           MOVE    SMCNDATE-HMS        TO  BTPARA-UPHMS
           MOVE    SPA-HOSPNUM         TO  BTPARA-HOSPNUM
           MOVE    BTPARA-REC          TO  MCPDATA-REC
           MOVE    "tbl_btpara"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "DBINSERT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC          NOT =   ZERO
                MOVE    "018"              TO  SPA-ERRCD
                GO  TO  2002-RECEIPT-MAKE-EXT
           END-IF
      *
      *    ジョブ開始セット
           MOVE    "DEL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           PERFORM 900-CALL-ORCSJOB-SEC
      *
           MOVE    "JBS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           MOVE    SPA-TERMID      TO  JOB-TERMID
           STRING  RECEMAKEQ-KARTE-UID DELIMITED  BY  SPACE
                   RECEMAKEQ-ORCA-UID  DELIMITED  BY  SPACE
                                       INTO    JOB-PARAM
           END-STRING
           MOVE    SPA-R01-NYUGAIKBN
                                   TO  JOB-NYUGAIKBN
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   MOVE    "1"             TO  JOB-SYOKBN
               WHEN    "2"
                   MOVE    "2"             TO  JOB-SYOKBN
           END-EVALUATE
           MOVE    SPA-R01-SRYYM   TO  JOB-SRYYM
           PERFORM 900-CALL-ORCSJOB-SEC
      *
      *    印刷用スクリプト処理
           MOVE    WRK-CONS-FILE-ID    TO  ERRFLPARA-FILE-ID
           MOVE    SPA-TERMID          TO  ERRFLPARA-TERMID
           MOVE    SPA-HOSPNUM         TO  ERRFLPARA-HOSPNUM
           MOVE    SPACE               TO  RECEERR
           STRING  MCP-TEMPDIR         DELIMITED   BY  SPACE
                   "/"                 DELIMITED   BY  SIZE
                   ERRFLPARA-BASENAME  DELIMITED   BY  SPACE
                                       INTO        RECEERR
           END-STRING
      *
           OPEN    OUTPUT   RECEERR-FILE
           CLOSE   RECEERR-FILE
      *
      *    県番号の取得
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   INITIALIZE                  SYS-1001-REC
                   MOVE    "1001"          TO  SYS-1001-KANRICD
                   MOVE    "*"             TO  SYS-1001-KBNCD
                   MOVE    SPA-R01-SRYYM   TO  SYS-1001-STYUKYMD (1:6)
                   MOVE    "01"            TO  SYS-1001-STYUKYMD (7:2)
                   MOVE    SYS-1001-STYUKYMD 
                                           TO  SYS-1001-EDYUKYMD
                   MOVE    SPA-HOSPNUM     TO  SYS-1001-HOSPNUM
                   MOVE    SYS-1001-REC    TO  MCPDATA-REC
                   PERFORM 900-SYSKANRI-INV-SEC
                   IF      FLG-SYSKANRI    =   ZERO
                       MOVE   MCPDATA-REC      TO  SYS-1001-REC
                   ELSE
                       MOVE   SPACE            TO  SYS-1001-REC
                   END-IF
               WHEN    "2"
                   MOVE    ZERO                TO  WRK-PREFNUM
      *
                   INITIALIZE                      SYSKANRI-REC
                   MOVE    "1001"              TO  SYS-KANRICD
                   MOVE    "*"                 TO  SYS-KBNCD
                   MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
                   MOVE    SYSKANRI-REC        TO  MCPDATA-REC
                   MOVE    "tbl_syskanri"      TO  MCP-TABLE
                   MOVE    "key8"              TO  MCP-PATHNAME
                   PERFORM 900-DBSELECT-SEC
                   IF      MCP-RC              =   ZERO
                       MOVE    "tbl_syskanri"      TO  MCP-TABLE
                       MOVE    "key8"              TO  MCP-PATHNAME
                       PERFORM  900-SYSKANRI-READ-SEC
                       PERFORM  UNTIL   FLG-SYSKANRI   =    1
                           MOVE    MCPDATA-REC   TO  SYS-1001-REC
                           EVALUATE    SYS-1001-PREFNUM
                               WHEN    "40"
                               WHEN    "06"
                                   MOVE    SYS-1001-PREFNUM
                                                       TO  WRK-PREFNUM
                                   MOVE    1           TO  FLG-SYSKANRI
                           END-EVALUATE
      *
                           MOVE    "tbl_syskanri"      TO  MCP-TABLE
                           MOVE    "key8"              TO  MCP-PATHNAME
                           PERFORM 900-SYSKANRI-READ-SEC
                       END-PERFORM
                   END-IF
                   MOVE    "tbl_syskanri"      TO  MCP-TABLE
                   MOVE    "key8"              TO  MCP-PATHNAME
                   PERFORM 900-CLOSE-SEC
           END-EVALUATE
      *
      *    カスタマイズＰＧ・レセ電情報の設定
           INITIALIZE                  SYS-2005-REC
           MOVE    "2005"          TO  SYS-2005-KANRICD
           MOVE    "*"             TO  SYS-2005-KBNCD
           MOVE    SPA-SYSYMD      TO  SYS-2005-STYUKYMD
                                       SYS-2005-EDYUKYMD
           MOVE    SPA-HOSPNUM     TO  SYS-2005-HOSPNUM
           MOVE    SYS-2005-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI    =   ZERO
               MOVE   MCPDATA-REC  TO  SYS-2005-REC
           ELSE
               MOVE   SPACE        TO  SYS-2005-REC
           END-IF
      *
      *    区分コード０１のデータ読み込み
           INITIALIZE                  SYS-200501-REC
           MOVE    "2005"          TO  SYS-200501-KANRICD
           MOVE    "01"            TO  SYS-200501-KBNCD
           MOVE    SPA-SYSYMD      TO  SYS-200501-STYUKYMD
                                       SYS-200501-EDYUKYMD
           MOVE    SPA-HOSPNUM     TO  SYS-200501-HOSPNUM
           MOVE    SYS-200501-REC  TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI    =   ZERO
               MOVE   MCPDATA-REC  TO  SYS-200501-REC
           ELSE
               INITIALIZE              SYS-200501-REC
               MOVE    SYS-2005-TERMID (1:4)
                                   TO  SYS-200501-TBL (1:4)
           END-IF
      *
           IF      SYS-2005-PREFPRGID (1) (1:1)
                                   NOT =  "S"
                   MOVE  "NOPG"    TO  SYS-2005-PREFPRGID (1)
           END-IF
           IF      SYS-2005-PREFPRGID (2) (1:1)
                                   NOT =  "S"
                   MOVE  "NOPG"    TO  SYS-2005-PREFPRGID (2)
           END-IF
           IF      SYS-2005-KKHRECEKBN =   SPACE
               MOVE    ZERO            TO  SYS-2005-KKHRECEKBN      
           END-IF
           IF      SYS-2005-SYARECEKBN =   SPACE
               MOVE    ZERO            TO  SYS-2005-SYARECEKBN      
           END-IF
           IF      SYS-2005-FRAME-JIBAIPRTKBN
                                       =   SPACE
               MOVE    ZERO            TO  SYS-2005-FRAME-JIBAIPRTKBN
           END-IF
           IF      SYS-2005-FRAME-JIBAIPRTKBN-N
                                       =   SPACE
               MOVE    ZERO            TO  SYS-2005-FRAME-JIBAIPRTKBN-N
           END-IF
           IF      SYS-200501-JIBAIPRTKBN
                                       =   SPACE
               MOVE    "1"             TO  SYS-200501-JIBAIPRTKBN
           END-IF
           IF      SYS-200501-JIBAIPRTKBN-N
                                       =   SPACE
               MOVE    "1"             TO  SYS-200501-JIBAIPRTKBN-N
           END-IF
           IF      SYS-200501-JIBAIPRTKBN1
                                       =   SPACE
               MOVE    "2"             TO  SYS-200501-JIBAIPRTKBN1
           END-IF
           IF      SYS-200501-JIBAIPRTKBN1-N
                                       =   SPACE
               MOVE    "2"             TO  SYS-200501-JIBAIPRTKBN1-N
           END-IF
           IF      SYS-200501-KOUIKIRECEKBN
                                       =   SPACE
               MOVE    ZERO            TO  SYS-200501-KOUIKIRECEKBN
           END-IF
           IF      SYS-200501-FRAME-ROUPRTKBN
                                       =   SPACE
               MOVE    ZERO            TO  SYS-200501-FRAME-ROUPRTKBN
           END-IF
           IF      SYS-200501-FRAME-ROUPRTKBN-N
                                       =   SPACE
               MOVE    ZERO            TO  SYS-200501-FRAME-ROUPRTKBN-N
           END-IF
           IF      SYS-200501-COMMENT-ROU-KSIKBN
                                       =   SPACE
               MOVE    ZERO            TO  SYS-200501-COMMENT-ROU-KSIKBN
           END-IF
           IF      SYS-200501-ROUPRTKBN
                                       =   SPACE
               MOVE    ZERO            TO  SYS-200501-ROUPRTKBN
           END-IF
           IF      SYS-200501-ROUPRTKBN-N
                                       =   SPACE
               MOVE    ZERO            TO  SYS-200501-ROUPRTKBN-N
           END-IF
           IF      SYS-200501-ROURECEKBN
                                       =   SPACE
               MOVE    "0"             TO  SYS-200501-ROURECEKBN
           END-IF
      *
      *    労災指定医療機関の有無
      *    （平成２５年６月以前は指定なしとする）
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   INITIALIZE                  SYS-4001-REC
                   IF      SPA-R01-SRYYM   <   201307
                       MOVE    "0"             TO  SYS-4001-RSIIRYOKBN
                   ELSE 
                       MOVE    SPA-HOSPNUM     TO  SYS-4001-HOSPNUM
                       MOVE    "4001"          TO  SYS-4001-KANRICD
                       MOVE    "*"             TO  SYS-4001-KBNCD
                       MOVE    SPA-R01-SRYYM   TO  SYS-4001-STYUKYMD
                                                                   (1:6)
                       MOVE    "01"            TO  SYS-4001-STYUKYMD
                                                                   (7:2)
                       MOVE    SYS-4001-STYUKYMD
                                               TO  SYS-4001-EDYUKYMD
                       MOVE    SYS-4001-REC    TO  MCPDATA-REC
                       PERFORM 900-SYSKANRI-INV-SEC
                       IF      FLG-SYSKANRI        =   ZERO
                           MOVE    MCPDATA-REC     TO  SYS-4001-REC
                       ELSE
                           INITIALIZE                  SYS-4001-REC
                       END-IF
                   END-IF
               WHEN    "2"
                   MOVE    ZERO                TO  FLG-4001-RSIIRYOKBN
                   INITIALIZE                      SYS-4001-REC
                   MOVE    "4001"              TO  SYS-4001-KANRICD
                   MOVE    "*"                 TO  SYS-4001-KBNCD
                   MOVE    SPA-HOSPNUM         TO  SYS-4001-HOSPNUM
                   MOVE    SYS-4001-REC        TO  MCPDATA-REC
                   MOVE    "tbl_syskanri"      TO  MCP-TABLE
                   MOVE    "key8"              TO  MCP-PATHNAME
                   PERFORM 900-DBSELECT-SEC
                   IF      MCP-RC              =   ZERO
                       MOVE    "tbl_syskanri"      TO  MCP-TABLE
                       MOVE    "key8"              TO  MCP-PATHNAME
                       PERFORM  900-SYSKANRI-READ-SEC
                       PERFORM  UNTIL   FLG-SYSKANRI   =    1
                           MOVE    MCPDATA-REC     TO  SYS-4001-REC
                           IF    ( SYS-4001-EDYUKYMD   >=  20130701 )
                           AND   ( SYS-4001-RSIIRYOKBN =   "1"      )
                               MOVE    SYS-4001-RSIIRYOKBN
                                              TO  FLG-4001-RSIIRYOKBN
                               MOVE    1       TO  FLG-SYSKANRI
                          END-IF
      *
                          MOVE    "tbl_syskanri"  TO  MCP-TABLE
                          MOVE    "key8"          TO  MCP-PATHNAME
                          PERFORM 900-SYSKANRI-READ-SEC
                     END-PERFORM
                  END-IF
                  MOVE    "tbl_syskanri"      TO  MCP-TABLE
                  MOVE    "key8"              TO  MCP-PATHNAME
                  PERFORM 900-CLOSE-SEC
          END-EVALUATE
      *
           MOVE    SPACE           TO  SHELLTBL
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "0"
               WHEN    "1"
               WHEN    "2"
               WHEN    "7"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    "recept9.sh"    TO  SHELLTBL-NAME
                   ELSE
                       MOVE    "recept1.sh"    TO  SHELLTBL-NAME
                   END-IF                        
               WHEN    "3"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    "recept10.sh"   TO  SHELLTBL-NAME
                   ELSE
                       MOVE    "recept6.sh"    TO  SHELLTBL-NAME
                   END-IF
               WHEN    "4"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    "recept11.sh"   TO  SHELLTBL-NAME
                   ELSE
                       MOVE    "recept8.sh"    TO  SHELLTBL-NAME
                   END-IF
               WHEN    "5"
               WHEN    "8"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    "recept13.sh"   TO  SHELLTBL-NAME
                   ELSE
                       MOVE    "recept12.sh"
                                               TO  SHELLTBL-NAME
                   END-IF
               WHEN    "6"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    "recept15.sh"   TO  SHELLTBL-NAME
                   ELSE
                       MOVE    "recept14.sh"   TO  SHELLTBL-NAME
                   END-IF
           END-EVALUATE
      *
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   MOVE    SPA-R01-SRYYM   TO  WRK-SHELL-SRYYM
               WHEN    "2"
                   MOVE    ZERO            TO  WRK-SHELL-SRYYM
           END-EVALUATE
           MOVE    SPA-TERMID      TO  WRK-SHELL-TERMID
           MOVE    SMCNDATE-YMD    TO  WRK-SHELL-SYSYMD
           MOVE    WRK-SHELL-ARG1  TO  SHELLTBL-ARG1
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   MOVE    "1"             TO  SHELLTBL-ARG2
               WHEN    "2"
                   MOVE    "2"             TO  SHELLTBL-ARG2
           END-EVALUATE
           MOVE    SPA-R01-RECEKBN TO  SHELLTBL-ARG3
           MOVE    ERRFLPARA-BASENAME
                                   TO  SHELLTBL-ARG4
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG5
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG6
           IF      SPA-R01-NYUGAIKBN   =   "1"
               MOVE    SYS-2005-PREFPRGID (2)
                                       TO  SHELLTBL-ARG7
           ELSE
               MOVE    SYS-2005-PREFPRGID (1)
                                       TO  SHELLTBL-ARG7
           END-IF
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   MOVE    SPA-R01-SRYYM   TO  SHELLTBL-ARG8
               WHEN    "2"
                   MOVE    WRK-SRYYM       TO  SHELLTBL-ARG8
           END-EVALUATE
           MOVE    SMCNDATE-YMD    TO  SHELLTBL-ARG9
           MOVE    SMCNDATE-HMS    TO  SHELLTBL-ARG10 (1:6)
           MOVE    "00"            TO  SHELLTBL-ARG10 (7:2)
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   MOVE    SYS-1001-PREFNUM
                                           TO  SHELLTBL-ARG11
               WHEN    "2"
                   MOVE    "00"            TO  SHELLTBL-ARG11
           END-EVALUATE
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "0"
               WHEN    "1"
               WHEN    "2"
               WHEN    "7"
                   IF      SYS-2005-SYARECEKBN
                                           =   ZERO
                       MOVE    "0"             TO  SHELLTBL-ARG12
                   ELSE
                       MOVE    SYS-2005-SYARECEKBN
                                               TO  SHELLTBL-ARG12
                   END-IF
                   IF      SYS-2005-KKHRECEKBN
                                           =   ZERO
                       MOVE    "0"             TO  SHELLTBL-ARG13
                   ELSE
                       MOVE    SYS-2005-KKHRECEKBN
                                               TO  SHELLTBL-ARG13
                   END-IF
               WHEN    "3"
                   MOVE    SYS-200501-ROURECEKBN
                                               TO  SHELLTBL-ARG12
                   EVALUATE    SPA-R01-FILEKBN
                       WHEN    "1"
                           MOVE    SYS-4001-RSIIRYOKBN
                                                   TO  SHELLTBL-ARG13
                       WHEN    "2"
                           MOVE    FLG-4001-RSIIRYOKBN
                                                   TO  SHELLTBL-ARG13
                   END-EVALUATE
               WHEN    OTHER
                   MOVE    "0"                 TO  SHELLTBL-ARG12
                                                   SHELLTBL-ARG13
           END-EVALUATE
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "3"
                   MOVE    SYS-200501-COMMENT-ROU-KSIKBN
                                           TO  SHELLTBL-ARG14
               WHEN    OTHER
                   EVALUATE    SPA-R01-FILEKBN
                       WHEN    "1"
                           MOVE    "00"            TO  SHELLTBL-ARG14
                       WHEN    "2"
                           MOVE    WRK-PREFNUM     TO  SHELLTBL-ARG14
                   END-EVALUATE
           END-EVALUATE
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "4"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    SYS-2005-FRAME-JIBAIPRTKBN-N
                                                   TO  SHELLTBL-ARG15
                   ELSE
                       MOVE    SYS-2005-FRAME-JIBAIPRTKBN
                                                   TO  SHELLTBL-ARG15
                   END-IF
               WHEN    "3"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    SYS-200501-FRAME-ROUPRTKBN-N
                                                   TO  SHELLTBL-ARG15
                   ELSE
                       MOVE    SYS-200501-FRAME-ROUPRTKBN
                                                   TO  SHELLTBL-ARG15
                   END-IF
           END-EVALUATE
           MOVE    SPA-HOSPNUM     TO  SHELLTBL-ARG16
           EVALUATE    SPA-R01-RECEKBN
               WHEN    "4"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    SYS-200501-JIBAIPRTKBN1-N
                                                   TO  SHELLTBL-ARG17
                   ELSE
                       MOVE    SYS-200501-JIBAIPRTKBN1
                                                   TO  SHELLTBL-ARG17
                   END-IF
               WHEN    "5"
               WHEN    "8"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    SYS-200501-JIBAIPRTKBN-N
                                                   TO  SHELLTBL-ARG17
                   ELSE
                       MOVE    SYS-200501-JIBAIPRTKBN
                                                   TO  SHELLTBL-ARG17
                   END-IF
               WHEN    "3"
                   IF      SPA-R01-NYUGAIKBN   =   "1"
                       MOVE    SYS-200501-ROUPRTKBN-N
                                                   TO  SHELLTBL-ARG17
                   ELSE
                       MOVE    SYS-200501-ROUPRTKBN
                                                   TO  SHELLTBL-ARG17
                   END-IF
           END-EVALUATE
           MOVE    SPA-R01-PRTKBN      TO  SHELLTBL-ARG18
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "1"
                   MOVE    "0"             TO  SHELLTBL-ARG19
               WHEN    "2"
                   MOVE    "1"             TO  SHELLTBL-ARG19
           END-EVALUATE
           MOVE    "0"             TO  SHELLTBL-ARG20
           MOVE     SPA-HOSPNUM    TO   SHELLTBL-HOSPNUM
           MOVE     SHELLTBL-ARG5  TO   SHELLTBL-JOBID
           MOVE     SHELLTBL-ARG6  TO   SHELLTBL-SHELLID
      *
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    "shell"         TO  MCP-TABLE
           MOVE    "monthly"       TO  MCP-PATHNAME
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
       2002-RECEIPT-MAKE-EXT.
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
               IF      WRK-PARAM   NOT =   JOB-PARAM
                   MOVE    "022"           TO  WRK-ERRCD
                   MOVE    "該当する処理はありません"
                                           TO  WRK-ERRMSG
                   GO  TO  2003-RECEIPT-CHECK-EXT
               END-IF
      *
      *        処理中
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "001"           TO  RECEMAKES-API-RESULT
                   MOVE    "073"           TO  WRK-ERRCD
                   MOVE    JOB-SHELLMSG    TO  WRK-ERRMSG
               ELSE
      *            処理終了
                   IF      JOB-ERRCD       =   SPACE
                       MOVE    "000"       TO  RECEMAKES-API-RESULT
                       IF      JOB-UPDCNT  =   ZERO
                           MOVE    "W01"       TO  WRK-WARNING
                           MOVE    "対象データがありませんでした"
                                               TO  WRK-WARNING-MSG
                       ELSE
                           PERFORM 20031-REPRINT-CHK-SEC
                           IF      SPA-RECE07-PRTID    =   SPACE
                               MOVE    "W02"       TO  WRK-WARNING
                               MOVE
                                   "対象のレセプトが作成されていません"
                                                   TO  WRK-WARNING-MSG
                           ELSE
                               MOVE    SPA-RECE07-KEY
                                           TO  SPA-R01-RECE07-KEY
                               MOVE    SPA-RECE07-RECEKBN
                                           TO  SPA-R01-RECE07-RECEKBN
                               MOVE    SPA-RECE07-SRYYM
                                           TO  SPA-R01-RECE07-SRYYM
                               MOVE    SPA-RECE07-NYUGAIKBN
                                           TO  SPA-R01-RECE07-NYUGAIKBN
                               MOVE    SPA-RECE07-SYORISBT
                                           TO  SPA-R01-RECE07-SYORISBT
                               MOVE    SPA-RECE07-STYMD
                                           TO  SPA-R01-RECE07-STYMD
                               MOVE    SPA-RECE07-EDYMD
                                           TO  SPA-R01-RECE07-EDYMD
                               MOVE    SPA-RECE07-HSEQNUM
                                          TO  SPA-R01-RECE07-HSEQNUM
                               MOVE    SPA-RECE07-HKNJANUM
                                          TO  SPA-R01-RECE07-HKNJANUM
                               MOVE    SPA-RECE07-SRYKA-KOKUHO
                                          TO SPA-R01-RECE07-SRYKA-KOKUHO
                               MOVE    SPA-RECE07-SRYKA-KOUIKI
                                          TO SPA-R01-RECE07-SRYKA-KOUIKI
                               MOVE    SPA-RECE07-RECE-PUTH-T (1)
                                          TO SPA-R01-RECE07-RECE-PUTH(1)
                               MOVE    SPA-RECE07-RECE-PUTH-T (2)
                                          TO SPA-R01-RECE07-RECE-PUTH(2)
                               MOVE    SPA-RECE08-DRCD-SRYKA
                                           TO SPA-R01-RECE08-DRCD-SRYKA
                               MOVE    SPA-RECE08-SORT-1
                                           TO SPA-R01-RECE08-SORT-1
                               MOVE    SPA-RECE08-SORT-2
                                           TO SPA-R01-RECE08-SORT-2
                               MOVE    SPA-RECE08-RECESYUBETU-SRT
                                           TO
                                       SPA-R01-RECE08-RECESYUBETU-SRT 
                               MOVE    SPA-RECE07-FUMEI-PAGE
                                           TO  SPA-R01-RECE07-FUMEI-PAGE
                               MOVE    SPA-RECE07-HKNJANUM-SYAHO-T
                                           TO
                                       SPA-R01-RECE07-HKNJANUM-SYAHO-T
      *
                               IF    ( SPA-R01-RECE07-SRYKA
                                                           =   "XX" )
                               OR    ( SPA-R01-RECE07-SRYKA-KOKUHO
                                                           =   "XX" )
                               OR    ( SPA-R01-RECE07-SRYKA-KOUIKI
                                                           =   "XX" )
                               OR    ( SPA-R01-RECE07-FUMEI-PAGE
                                                           >   ZERO )
                                   MOVE    "W03"       TO  WRK-WARNING
                                   STRING
                                       "主科未設定分又は種別不明分が"
                                                   DELIMITED   BY  SIZE
                                       "あります"  DELIMITED   BY  SIZE
                                               INTO    WRK-WARNING-MSG
                                   END-STRING
                               END-IF
      *
      *                        頁・件数の編集処理
                               PERFORM 3101-HENSYU-SEC
                           END-IF
                       END-IF
                   ELSE
                       MOVE    "002"           TO  RECEMAKES-API-RESULT
                       MOVE    "072"           TO  WRK-ERRCD
                       STRING  JOB-YOBI        DELIMITED  BY  SPACE
                               "【"            DELIMITED  BY  SIZE
                              JOB-SHELLMSG     DELIMITED  BY  SPACE
                              "】"             DELIMITED  BY  SIZE
                                               INTO  WRK-ERRMSG
                       END-STRING
                   END-IF
               END-IF
           ELSE
               MOVE    "022"           TO  WRK-ERRCD
               MOVE    "該当する処理はありません"
                                       TO  WRK-ERRMSG
           END-IF
      *
           .
       2003-RECEIPT-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    再印刷チェック処理
      *****************************************************************
       20031-REPRINT-CHK-SEC         SECTION.
      *
           INITIALIZE              SPA-RECE07-REC
      *
           INITIALIZE                  RECE07-REC
           IF      SPA-R01-RECEKBN     =   "0" OR  "1" OR  "2" OR  "7"
               MOVE    "HC06"              TO  RECE07-PRTID
           ELSE
               IF      SPA-R01-RECEKBN     =   "3"
                   MOVE    "HC21"          TO  RECE07-PRTID
               END-IF
               IF      SPA-R01-RECEKBN     =   "4" OR  "5" OR  "8"
                   MOVE    "HC23"          TO  RECE07-PRTID
               END-IF
               IF      SPA-R01-RECEKBN     =   "6"
                   MOVE    "HC25"          TO  RECE07-PRTID
               END-IF
           END-IF            
           MOVE    SPA-HOSPNUM         TO  RECE07-HOSPNUM
           IF      SPA-R01-FILEKBN         =   "1"
               MOVE    SPA-R01-SRYYM           TO  RECE07-SRYYM
               MOVE    "1"                 TO  RECE07-SYOKBN
               MOVE    SPA-R01-NYUGAIKBN       TO  RECE07-NYUGAIKBN
               MOVE    SPA-R01-RECEKBN         TO  RECE07-RECEKBN
               MOVE    "tbl_recekanri"     TO  WRK-MCP-TABLE
               MOVE    "key7"              TO  WRK-MCP-PATHNAME
           ELSE
               MOVE    "2"                 TO  RECE07-SYOKBN
               MOVE    SPA-R01-NYUGAIKBN       TO  RECE07-NYUGAIKBN
               MOVE    "tbl_recekanri"     TO  WRK-MCP-TABLE
               MOVE    "key5"              TO  WRK-MCP-PATHNAME
           END-IF
           MOVE    RECE07-REC          TO  MCPDATA-REC
           PERFORM 900-RECE07-INV-SEC
           IF      FLG-RECE07          =   ZERO
               MOVE    RECE07-REC      TO  SPA-RECE07-REC
               MOVE    "99999999"      TO  SPA-RECE07-HKNJANUM
               MOVE    "00"            TO  SPA-RECE07-SRYKA 
                                           SPA-RECE07-SRYKA-KOKUHO
                                           SPA-RECE07-SRYKA-KOUIKI
               INITIALIZE                  SPA-RECE07-RECE-PUTH-T(1)
                                           SPA-RECE07-RECE-PUTH-T(2)
               MOVE    SPACE           TO  SPA-RECE08-DRCD-SRYKA
                                           SPA-RECE08-SORT-1
                                           SPA-RECE08-SORT-2
                                           SPA-RECE08-RECESYUBETU-SRT
               MOVE    ZERO            TO  SPA-RECE07-FUMEI-PAGE
               INITIALIZE                  SPA-RECE07-HKNJANUM-SYAHO-T
               MOVE    "%%%%%%%%"      TO  SPA-RECE07-HKNJANUM-SYAHO (1)
               MOVE    1               TO  SPA-RECE07-HKNJANUM-SYAHO-MAX
               MOVE    "9"             TO  SPA-RECE07-HKNJANUM-SRT-SYAHO
      *
      *        一括作成で社保処理のとき編綴順設定の有無チェック
               IF    ( SPA-R01-FILEKBN         =   "1"         )
               AND   ( SPA-R01-RECEKBN         =   "0" OR  "1" )
                   MOVE    "tbl_recekanri"     TO  WRK-MCP-TABLE
                   MOVE    "key6"              TO  WRK-MCP-PATHNAME
                   MOVE    "1"                 TO  RECE07-TEISYUTUSAKI
                   MOVE    RECE07-REC          TO  MCPDATA-REC
                   PERFORM 900-RECE07-INV-SEC
                   IF      FLG-RECE07          =   ZERO
                       MOVE    RECE07-RECESYUBETU-SRT
                                                   TO
                                           SPA-RECE08-RECESYUBETU-SRT
                   END-IF
               END-IF  
      *
      *        一括作成で国保処理のとき編綴順設定の有無チェック
               IF    ( SPA-R01-FILEKBN         =   "1"         )
               AND   ( SPA-R01-RECEKBN         =   "0" OR  "2" )
                   MOVE    "tbl_recekanri"     TO  WRK-MCP-TABLE
                   MOVE    "key6"              TO  WRK-MCP-PATHNAME
                   MOVE    "2"                 TO  RECE07-TEISYUTUSAKI
                   MOVE    RECE07-REC          TO  MCPDATA-REC
                   PERFORM 900-RECE07-INV-SEC
                   IF      FLG-RECE07          =   ZERO
                       MOVE    RECE07-HKNJANUM TO  SPA-RECE07-HKNJANUM
                       MOVE    RECE07-HSEQNUM  TO  SPA-RECE07-HSEQNUM
      *                編綴順設定のとき詳細情報を取得
                       IF    ( SPA-RECE07-HKNJANUM
                                               NOT =   "99999999" )
                       AND   ( SPA-RECE07-HSEQNUM  =   "99999999" )
                           MOVE    "tbl_recekanri" TO  WRK-MCP-TABLE
                           MOVE    "key12"         TO  WRK-MCP-PATHNAME
                           MOVE    "1"             TO  RECE07-PREFKBN
                           MOVE    "2"             TO
                                                   RECE07-TEISYUTUSAKI
                           MOVE    RECE07-REC      TO  MCPDATA-REC
                           PERFORM 900-RECE07-INV-SEC
                           IF      FLG-RECE07      =   ZERO
                               EVALUATE    RECE07-PREFKBN-SRT (1:1)
                                   WHEN    "1"
                                       MOVE    1           TO  IDXX
                                   WHEN    "2"
                                       MOVE    2           TO  IDXX
                               END-EVALUATE    
                               MOVE    RECE07-ZAITAKU-KBN  TO
                                         SPA-RECE07-ZAITAKU-KBN-T (IDXX)
                               MOVE    RECE07-CHOUKI-KBN   TO
                                         SPA-RECE07-CHOUKI-KBN-T  (IDXX)
                               MOVE    RECE07-SRT-LAST     TO
                                         SPA-RECE07-SRT-LAST-T    (IDXX)
                               MOVE    RECE07-KOUGAKU-TEN  TO
                                         SPA-RECE07-KOUGAKU-TEN-T (IDXX)
                           END-IF
                           MOVE    "tbl_recekanri" TO  WRK-MCP-TABLE
                           MOVE    "key12"         TO  WRK-MCP-PATHNAME
                           MOVE    "2"             TO  RECE07-PREFKBN
                           MOVE    "2"             TO
                                                   RECE07-TEISYUTUSAKI
                           MOVE    RECE07-REC      TO  MCPDATA-REC
                           PERFORM 900-RECE07-INV-SEC
                           IF      FLG-RECE07      =   ZERO
                               EVALUATE    RECE07-PREFKBN-SRT (1:1)
                                   WHEN    "1"
                                       MOVE    1           TO  IDXX
                                   WHEN    "2"
                                       MOVE    2           TO  IDXX
                               END-EVALUATE    
                               MOVE    RECE07-ZAITAKU-KBN  TO
                                         SPA-RECE07-ZAITAKU-KBN-T (IDXX)
                               MOVE    RECE07-CHOUKI-KBN   TO
                                         SPA-RECE07-CHOUKI-KBN-T  (IDXX)
                               MOVE    RECE07-SRT-LAST     TO
                                         SPA-RECE07-SRT-LAST-T    (IDXX)
                               MOVE    RECE07-KOUGAKU-TEN  TO
                                         SPA-RECE07-KOUGAKU-TEN-T (IDXX)
                           END-IF
                       END-IF
                   END-IF
               END-IF  
      *
      *        一括作成のとき主科設定の有無チェック
               IF    ( SPA-SYUKA-KBN           =   "1"         )
                   MOVE    "tbl_recekanri"     TO  WRK-MCP-TABLE
                   MOVE    "key11"             TO  WRK-MCP-PATHNAME
                   MOVE    "1"                 TO  RECE07-TEISYUTUSAKI
                   MOVE    RECE07-REC          TO  MCPDATA-REC
                   PERFORM 900-RECE07-INV-SEC
                   IF      FLG-RECE07          =   ZERO
                       MOVE    RECE07-SRYKA    TO  SPA-RECE07-SRYKA
                   END-IF
                   MOVE    "tbl_recekanri"     TO  WRK-MCP-TABLE
                   MOVE    "key11"             TO  WRK-MCP-PATHNAME
                   MOVE    "2"                 TO  RECE07-TEISYUTUSAKI
                   MOVE    RECE07-REC          TO  MCPDATA-REC
                   PERFORM 900-RECE07-INV-SEC
                   IF      FLG-RECE07          =   ZERO
                       MOVE    RECE07-SRYKA    TO
                                               SPA-RECE07-SRYKA-KOKUHO
                   END-IF
                   MOVE    "tbl_recekanri"     TO  WRK-MCP-TABLE
                   MOVE    "key11"             TO  WRK-MCP-PATHNAME
                   MOVE    "6"                 TO  RECE07-TEISYUTUSAKI
                   MOVE    RECE07-REC          TO  MCPDATA-REC
                   PERFORM 900-RECE07-INV-SEC
                   IF      FLG-RECE07          =   ZERO
                       MOVE    RECE07-SRYKA    TO
                                               SPA-RECE07-SRYKA-KOUIKI
                   END-IF
               END-IF  
      *
      *        一括作成のとき医師別設定、病棟別設定、
      *                      ターミナルデジット設定の有無チェック
               IF    ( SPA-R01-FILEKBN         =   "1"         )
                   INITIALIZE                      RECE08-REC
                   MOVE    RECE07-HOSPNUM      TO  RECE08-HOSPNUM
                   MOVE    RECE07-PRTID        TO  RECE08-PRTID
                   MOVE    RECE07-SRYYM        TO  RECE08-RECEYM
                   MOVE    RECE07-CREYMD       TO  RECE08-CREYMD
                   MOVE    RECE07-CREHMS       TO  RECE08-CREHMS
                   MOVE    RECE07-NYUGAIKBN    TO  RECE08-NYUGAIKBN
                   MOVE    RECE08-REC          TO  MCPDATA-REC
                   PERFORM 900-RECE08-INV-SEC
                   IF      FLG-RECE08          =   ZERO
                       MOVE    RECE08-DRCD-SRYKA   TO
                                               SPA-RECE08-DRCD-SRYKA
                       MOVE    RECE08-SORT-1       TO
                                               SPA-RECE08-SORT-1
                       MOVE    RECE08-SORT-2       TO
                                               SPA-RECE08-SORT-2
                   END-IF
               END-IF
      *
      *        一括作成で社保処理のとき直接請求する保険者のチェックと取得
               IF    ( SPA-R01-FILEKBN         =   "1"         )
               AND   ( SPA-R01-RECEKBN         =   "0" OR  "1" )
                   MOVE    "99999999"          TO
                                           SPA-RECE07-HKNJANUM-SYAHO (1)
                   MOVE    "9"                 TO
                                           SPA-RECE07-HKNJANUM-SRT-SYAHO
                   MOVE    1                   TO  IDXX
      *
                   MOVE    "tbl_recekanri"     TO  WRK-MCP-TABLE
                   MOVE    "key14"             TO  WRK-MCP-PATHNAME
                   MOVE    "1"                 TO
                                               SPA-RECE07-TEISYUTUSAKI
                   MOVE    SPA-RECE07-REC      TO  MCPDATA-REC
                   PERFORM 900-RECE07-SELECT-SEC
                   PERFORM             UNTIL   FLG-RECE07  =   1
                                       OR      IDXX        =   10
                                       OR      RECE07-HKNJANUM-SRT
                                                           =   "9"
                       IF      IDXX            =   1
                           MOVE    RECE07-HKNJANUM-SRT TO
                                       SPA-RECE07-HKNJANUM-SRT-SYAHO
                       END-IF                                        
                       IF      RECE07-HKNJANUM NOT =   "99999999"
                           ADD     1                   TO  IDXX
                           MOVE    RECE07-HKNJANUM     TO
                                       SPA-RECE07-HKNJANUM-SYAHO (IDXX)
                       END-IF
      *
                       MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
                       MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
                       PERFORM 900-RECE07-FETCH-SEC
                   END-PERFORM
      *
                   MOVE    WRK-MCP-TABLE       TO  MCP-TABLE
                   MOVE    WRK-MCP-PATHNAME    TO  MCP-PATHNAME
                   PERFORM 900-CLOSE-SEC
      *
                   IF      IDXX                =   1
                       MOVE    "%%%%%%%%"          TO  
                                           SPA-RECE07-HKNJANUM-SYAHO (1)
                   END-IF
      *
                   MOVE    IDXX                TO
                                           SPA-RECE07-HKNJANUM-SYAHO-MAX
               END-IF  
      *
      *        不明分の有無チェック
               MOVE    SPA-RECE07-KEY      TO  RECE07-KEY
               MOVE    "%"                 TO  RECE07-TEISYUTUSAKI
               MOVE    "0000"              TO  RECE07-RECESYUBETU
               MOVE    "%%"                TO  RECE07-SRYKA 
               MOVE    "tbl_recekanri"     TO  WRK-MCP-TABLE
               MOVE    "key13"             TO  WRK-MCP-PATHNAME
               MOVE    RECE07-REC          TO  MCPDATA-REC
               PERFORM 900-RECE07-INV-SEC
               IF      FLG-RECE07          =   ZERO
                   MOVE    RECE07-PAGE         TO  SPA-RECE07-FUMEI-PAGE
               ELSE
                   MOVE    ZERO                TO  SPA-RECE07-FUMEI-PAGE
               END-IF
           END-IF
      *
           .
       20031-REPRINT-CHK-EXT.
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
               MOVE    SPA-GMN-R04-PRTJYUNMEI  TO
                                       RECEMAKES-RECEIPT-PRINT-ORDER (1)
               MOVE    SPA-GMN-R04-PAGEH       TO
                                       RECEMAKES-ALL-NUMBER
               MOVE    SPA-GMN-R04-KENSUH      TO
                                       RECEMAKES-ALL-NUMBER-OF-SHEETS
           END-IF
           .
       3101-HENSYU-EXT.
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
           PERFORM 900-SPATMP-DBDELETE-SEC
           .
       000-R02SPA-SET-EXT.
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
           .
       800-JOBKANRI-CHK-EXT.
           EXIT.
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
           INITIALIZE                      SPATMP-REC
           MOVE    "R02"               TO  SPATMP-GYOUMUID
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
