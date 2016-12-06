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
       PROGRAM-ID.         ORAPI042R2V3.
      *****************************************************************
      *  システム名        : 日医標準レセプトソフト
      *  サブシステム名    :  API連携用モジュール
      *  コンポーネント名  : レセプト印刷(xml2)
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
           03  IDYY                    PIC 9(04).
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
           03  WRK-ERR-RECEIPT-MAX     PIC 9(03).
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
      *    ワーク明細一覧
           03  WRK-ERR-INFOMATION.
               05  WRK-SUBMISSION-INFOMATION    OCCURS  19.
      *            連番
                   07  WRK-SUBMISSION-POSITION
                                               PIC X(5).
                   07  WRK-DETAIL-INFOMATION   OCCURS  36.
      *                連番
                       09  WRK-DETAIL-POSITION     PIC X(5).
      *                種別等コード
                       09  WRK-SUBMISSION-CODE     PIC X(10).
      *                種別
                       09  WRK-SUBMISSION-TYPE     PIC X(100).
      *                件数
                       09  WRK-NUMBER              PIC X(5).
      *                枚数
                       09  WRK-NUMBER-OF-SHEETS    PIC X(5).
      *                枚数
                       09  WRK-ERROR-CODE   PIC X(3).
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
      *
       01  WRK-CONS-AREA.
      *    １頁の最大行数
           03  WRK-CONS-LINE-MAX   PIC 9(02)   VALUE   36.   
      *    最大頁数
           03  WRK-CONS-PAGE-MAX   PIC 9(02)   VALUE   19.   
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "RECEPT1".
           03  WRK-CONS-JOB-SHELLID1
                                   PIC X(08)   VALUE   "RECEPT2".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
      *
      *    印刷管理ＤＢのキー値  
           03  WRK-CONS-PRTKANRI-TBL-KEY
                                   PIC X(08)   VALUE   "RECEPT2".
           03  WRK-CONS-PRTKANRI-TBL-GROUP
                                   PIC X(14)   VALUE   SPACE.
      *
      *    エラーファイルＩＤ
           03  WRK-CONS-FILE-ID    PIC X(08)   VALUE   "OR042ERR".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
           COPY    "CPORCSCOMMON.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *    日付変換サブ
           COPY     "CPORCSGDAY.INC".
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    排他制御サブパラメタ
           COPY    "CPORCSLOCK.INC".
      *    API XML読み込み用定義体
           COPY    "CPRECEIPT-PRINTV3REQ.INC".
      *    API XML読み込み用定義体
           COPY    "CPRECEIPT-PRINTV3RES.INC".
      *ver.4.7
      *    API XML読み込み共通定義
           COPY    "CPAPIV2REQ.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    レセプト管理     
       01  RECE07-REC. 
           COPY    "CPRCF007.INC".
      *
           COPY    "CPRCF008.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPDATA2.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "CPORCSGETTEMP.INC".
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
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    ＳＰＡ一時テーブル
       01  SPATMP-REC.
           COPY    "CPSPA-TMP.INC".
      *
           COPY    "ORCA-BLOB".
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
           DISPLAY   "***********************"
           DISPLAY   "* receipt_Print start *"
           DISPLAY   "***********************"
      *
           INITIALIZE                      FLG-AREA
           INITIALIZE                      IDX-AREA
           INITIALIZE                      WRK-AREA
      *****INITIALIZE                      CNT-AREA
           INITIALIZE                      SPA-AREA
                                           SPA-R01KYOUTU
                                           SPA-R02
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
               MOVE   404                  TO  APILST03-HTTPSTATUS
           ELSE
      *        返却領域編集
               PERFORM 300-RGTXMLMAKE-SEC
           END-IF
      *
           DISPLAY   "***********************"
           DISPLAY   "* receipt_Print end   *"
           DISPLAY   "***********************"
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
           INITIALIZE                      XML-RECEIPT-PRINTRES
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
           MOVE   "Acceptance_Info"    TO  RECEPRINTS-RESKEY
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
                                       RECEPRINTS-INFORMATION-DATE
           MOVE    WRK-HEN-TIME        TO
                                       RECEPRINTS-INFORMATION-TIME
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
           MOVE    ZERO                TO  RECEPRINTS-API-RESULT
           MOVE    SPACE               TO  WRK-ERRCD
                                           WRK-WARNING
      *
           MOVE    ZERO                TO  FLG-SYORI
           EVALUATE    RECEPRINTQ-REQUET-NUMBER
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
           EVALUATE    RECEPRINTQ-REQUET-NUMBER
           WHEN    "01"
      *        処理実施処理
               PERFORM 2002-RECEIPT-PRINT-SEC
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
           INITIALIZE                      XML-RECEIPT-PRINTREQ
      *
      *    XML情報取り出し
           MOVE    "XMLOPEN"           TO  MCP-FUNC
           MOVE    "xml_receipt_printv3req"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    APILST03-BODY       TO  APIREQ-OBJECT
           MOVE    ZERO                TO  APIREQ-MODE
           MOVE    "receipt_printv3req" TO  APIREQ-RECORDNAME
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
           MOVE    "xml_receipt_printv3req"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    ORCA-BLOB-OBJECT    TO  APIREQ-OBJECT
           MOVE    "receipt_printv3req" TO  APIREQ-RECORDNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       XML-APIREQ
                                       SPA-AREA
           IF     (MCP-RC              =   ZERO  OR  1  )
               MOVE    XML-APIREQ      TO  XML-RECEIPT-PRINTREQ
               PERFORM 10001-XML-REMAKE-SEC
           ELSE
               DISPLAY "XMLREAD failure = " MCP-RC
               MOVE   "098"             TO  WRK-ERRCD
           END-IF
      *
           MOVE    "XMLCLOSE"          TO  MCP-FUNC
           MOVE    "xml_receipt_printv3req"
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
               MOVE    "02"            TO  RECEPRINTS-RESPONS-NUMBER
               EVALUATE    FLG-SYORI
                   WHEN    1
                       MOVE    "処理実施終了"
                                           TO  RECEPRINTS-API-RESULT-MSG
                   WHEN    2
                       MOVE    "処理確認終了"
                                           TO  RECEPRINTS-API-RESULT-MSG
                   WHEN    3
                       MOVE    "処理キャンセル終了"
                                           TO  RECEPRINTS-API-RESULT-MSG
               END-EVALUATE
           ELSE
               MOVE    "01"            TO  RECEPRINTS-RESPONS-NUMBER
      *        エラーメッセージ
               PERFORM 890-ERRCD-MSG-SEC
               MOVE    WRK-ERRCD       TO  RECEPRINTS-API-RESULT
               MOVE    WRK-ERRMSG      TO  RECEPRINTS-API-RESULT-MSG
           END-IF
      *    警告メッセージ
           MOVE    WRK-WARNING         TO  RECEPRINTS-API-WARNING
           MOVE    WRK-WARNING-MSG     TO  RECEPRINTS-API-WARNING-MSG
      *
           IF      APILST03-BODY   NOT =   LOW-VALUE
               DISPLAY "MDCRES-OBJECT not low_value"
           END-IF
      *
           MOVE    "XMLOPEN"           TO  MCP-FUNC
           MOVE    "xml_receipt_printv3res"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    1                   TO  RECEPRINTS-MODE
           MOVE    "receipt_printv3res"
                                       TO  RECEPRINTS-RECORDNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       XML-RECEIPT-PRINTRES
                                       SPA-AREA
           IF    ( MCP-RC              =   ZERO    OR  1 )
               CONTINUE
           ELSE
               DISPLAY "XMLOPEN failure = " MCP-RC
           END-IF
      *
           MOVE    "XMLWRITE"          TO  MCP-FUNC
           MOVE    "xml_receipt_printv3res"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "receipt_printv3res" TO  RECEPRINTS-RECORDNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       XML-RECEIPT-PRINTRES
                                       SPA-AREA
           IF    ( MCP-RC              =   ZERO    OR  1 )
               CONTINUE
           ELSE
               DISPLAY "XMLWRITE failure = " MCP-RC
           END-IF
      *
           MOVE    "XMLCLOSE"          TO  MCP-FUNC
           MOVE    "xml_receipt_printv3res"
                                       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "receipt_printv3res" TO  RECEPRINTS-RECORDNAME
           CALL   "ORCDBMAIN"          USING
                                       MCPAREA
                                       XML-RECEIPT-PRINTRES
                                       SPA-AREA
           IF    ( MCP-RC              =   ZERO    OR  1 )
               MOVE  RECEPRINTS-OBJECT     TO  APILST03-BODY
               MOVE  "application/xml"     TO  APILST03-CONTENT-TYPE
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
      *    入外区分
           EVALUATE    RECEPRINTQ-INOUT
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
               EVALUATE    RECEPRINTQ-SUBMISSION-MODE
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
      *    処理区分
           IF      WRK-ERRCD           =   SPACE
               EVALUATE    RECEPRINTQ-RECEIPT-MODE
                   WHEN    "All"
                       MOVE    "1"         TO  SPA-R01-FILEKBN
                   WHEN    OTHER
                       MOVE    "2"         TO  SPA-R01-FILEKBN
               END-EVALUATE
           END-IF
      *
      *    印刷指示
           IF      WRK-ERRCD           =   SPACE
               EVALUATE    RECEPRINTQ-PRINT-MODE
                   WHEN    "All"
                       MOVE    "T"             TO  SPA-GMN-SYOKBN
                   WHEN    OTHER
                       MOVE    "F"             TO  SPA-GMN-SYOKBN
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
           DISPLAY "SPA-GMN-SYOKBN =" SPA-GMN-SYOKBN "#" 
      *??
           EVALUATE    SPA-GMN-SYOKBN
               WHEN    "T"
      *            診療年月
                   MOVE    RECEPRINTQ-PERFORM-MONTH
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
               WHEN    "F"
                   MOVE    ZERO            TO  SPA-R01-SRYYM
                   MOVE    "1"             TO  SPA-GMN-R01-SYORI
           END-EVALUATE
      *
           IF      WRK-ERRCD       =   SPACE
      *        レセプト作成結果取得処理
               PERFORM 2003-RECEIPT-CHECK-SEC
           END-IF
      *
           IF      WRK-ERRCD   NOT =   SPACE
               GO  TO  2001-INPUT-CHK-EXT
           END-IF
      *
      *    個別の項目チェック
           EVALUATE    SPA-GMN-SYOKBN
               WHEN    "F"
                   PERFORM VARYING IDYY    FROM    1   BY  1
                           UNTIL   IDYY    >       19
                           OR      RECEPRINTQ-SUBMISSION-POSITION (IDYY)
                                           =   SPACE
                       MOVE    SPACE           TO  WRK-ERRCD
      *                連番
                       INITIALIZE                      ORCSNUMAREA
                       MOVE    RECEPRINTQ-SUBMISSION-POSITION (IDYY)
                                               TO  SNUM-INX
                       CALL    "ORCSNUM"       USING
                                                   ORCSNUMAREA
                       IF    ( SNUM-RC             =   ZERO )
                       AND   ( SNUM-SEISUU         <   6    )
                          MOVE    SNUM-OUTNUM         TO  IDY
                       ELSE
                           MOVE    "???"              TO  WRK-ERRCD
                       END-IF
      *
                       PERFORM VARYING IDZZ    FROM    1   BY  1
                               UNTIL   IDZZ    >       36
                               OR      RECEPRINTQ-DETAIL-POSITION
                                                           (IDYY IDZZ)
                                               =   SPACE
      *                    連番
                           IF      WRK-ERRCD       =   SPACE
                               INITIALIZE                  ORCSNUMAREA
                               MOVE    RECEPRINTQ-DETAIL-POSITION
                                                           (IDYY IDZZ)
                                                       TO  SNUM-INX
                               CALL    "ORCSNUM"       USING
                                                           ORCSNUMAREA
                               IF    ( SNUM-RC         =   ZERO )
                               AND   ( SNUM-SEISUU     <   6    )
                                  MOVE    SNUM-OUTNUM      TO  IDY
                               ELSE
                                   MOVE    "???"          TO  WRK-ERRCD
                               END-IF
                           END-IF
      *                    件数
                           IF      WRK-ERRCD       =   SPACE
                               INITIALIZE                  ORCSNUMAREA
                               MOVE    RECEPRINTQ-NUMBER   (IDYY IDZZ)
                                                       TO  SNUM-INX
                               CALL    "ORCSNUM"       USING
                                                           ORCSNUMAREA
                               IF    ( SNUM-RC         =   ZERO )
                               AND   ( SNUM-SEISUU     <   6    )
                                  MOVE    SNUM-OUTNUM      TO  IDY
                               ELSE
                                   MOVE    "???"          TO  WRK-ERRCD
                               END-IF
                           END-IF 
      *                    枚数
                           IF      WRK-ERRCD       =   SPACE
                               INITIALIZE                  ORCSNUMAREA
                               MOVE    RECEPRINTQ-NUMBER-OF-SHEETS
                                                           (IDYY IDZZ)
                                                       TO  SNUM-INX
                               CALL    "ORCSNUM"       USING
                                                           ORCSNUMAREA
                               IF    ( SNUM-RC         =   ZERO )
                               AND   ( SNUM-SEISUU     <   6    )
                                  MOVE    SNUM-OUTNUM      TO  IDY
                               ELSE
                                   MOVE    "???"          TO  WRK-ERRCD
                               END-IF
                           END-IF
      *
                           IF      WRK-ERRCD       =   SPACE
      *                        関連チェック処理
                               PERFORM 20011-CHECK-SEC
                           END-IF
      *
                           IF      WRK-ERRCD       =   SPACE
                               CONTINUE
                           ELSE
                               PERFORM 20012-RECEIPT-ERR-SEC
                           END-IF
                       END-PERFORM
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
      *    関連チェック処理
      *****************************************************************
       20011-CHECK-SEC     SECTION.
      *
           .
       20011-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別指示エラー処理
      *****************************************************************
       20012-RECEIPT-ERR-SEC     SECTION.
      *
           ADD     1               TO  WRK-ERR-RECEIPT-MAX
      *
           MOVE    WRK-ERRCD       TO  RECEPRINTS-ERROR-CODE
                                           (WRK-ERR-RECEIPT-MAX IDZZ)
      *
           MOVE    RECEPRINTQ-SUBMISSION-POSITION (IDYY)
                                   TO  RECEPRINTS-SUBMISSION-POSITION
                                           (WRK-ERR-RECEIPT-MAX)
           MOVE    RECEPRINTQ-DETAIL-POSITION      (IDYY IDZZ)
                                   TO  RECEPRINTQ-DETAIL-POSITION
                                           (WRK-ERR-RECEIPT-MAX IDZZ)
           MOVE    RECEPRINTQ-PRINT-INSTRUCT       (IDYY IDZZ)
                                   TO  RECEPRINTQ-PRINT-INSTRUCT
                                           (WRK-ERR-RECEIPT-MAX IDZZ)
           MOVE    RECEPRINTQ-SUBMISSION-PRINTER1  (IDYY IDZZ)
                                   TO  RECEPRINTQ-SUBMISSION-PRINTER1
                                           (WRK-ERR-RECEIPT-MAX IDZZ)
           MOVE    RECEPRINTQ-SUBMISSION-PRINTER2  (IDYY IDZZ)
                                   TO  RECEPRINTQ-SUBMISSION-PRINTER2
                                           (WRK-ERR-RECEIPT-MAX IDZZ)
           MOVE    RECEPRINTQ-SUBMISSION-CODE      (IDYY IDZZ)
                                   TO  RECEPRINTQ-SUBMISSION-CODE
                                           (WRK-ERR-RECEIPT-MAX IDZZ)
           MOVE    RECEPRINTQ-SUBMISSION-TYPE      (IDYY IDZZ)
                                   TO  RECEPRINTQ-SUBMISSION-TYPE
                                           (WRK-ERR-RECEIPT-MAX IDZZ)
           MOVE    RECEPRINTQ-NUMBER               (IDYY IDZZ)
                                   TO  RECEPRINTQ-NUMBER
                                           (WRK-ERR-RECEIPT-MAX IDZZ)
           MOVE    RECEPRINTQ-NUMBER-OF-SHEETS     (IDYY IDZZ)
                                   TO  RECEPRINTQ-NUMBER-OF-SHEETS
                                           (WRK-ERR-RECEIPT-MAX IDZZ)
           .
       20012-RECEIPT-ERR-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト印刷処理
      *****************************************************************
       2002-RECEIPT-PRINT-SEC     SECTION.
      *
      *    ジョブ管理チェック処理
           PERFORM 800-JOBKANRI-CHK-SEC
           IF      WRK-ERRCD      NOT =   SPACE
               GO  TO  2002-RECEIPT-PRINT-EXT
           END-IF
      *
           EVALUATE    SPA-R01-FILEKBN
               WHEN    "F"
                   CONTINUE
           END-EVALUATE
      *
      *
           MOVE    "RID3"          TO  SPA-MOTOPG
           MOVE    "OK"            TO  SPA-RID1-FLG
           MOVE    "1001"          TO  SPA-RIDCD3
           MOVE    SPACE           TO  LINKAREA
      *
           MOVE    SPA-R01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-R02         TO  SPA-FREE
      *
      *    画面ＳＰＡ書込み
           PERFORM 000-R02SPA-OUT-SEC
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
           END-IF
           .
       2002-RECEIPT-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト印刷確認処理
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
               STRING  RECEPRINTQ-KARTE-UID DELIMITED   BY  SPACE
                       RECEPRINTQ-ORCA-UID  DELIMITED   BY  SPACE
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
                   MOVE    "001"           TO  RECEPRINTS-API-RESULT
                   MOVE    "073"           TO  WRK-ERRCD
                   MOVE    JOB-SHELLMSG    TO  WRK-ERRMSG
               ELSE
      *            処理終了
                   IF      JOB-ERRCD       =   SPACE
                       MOVE    "000"       TO  RECEPRINTS-API-RESULT
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
      *                        頁・件数の編集処理
                               PERFORM 3101-HENSYU-SEC
                           END-IF
                       END-IF
                   ELSE
                       MOVE    "002"           TO  RECEPRINTS-API-RESULT
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
           END-IF
      *
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
      *    画面ＳＰＡ書込
      *****************************************************************
       000-R02SPA-OUT-SEC             SECTION.
      *
           INITIALIZE                      SPATMP-REC
           MOVE    SPA-HOSPNUM         TO  SPATMP-HOSPNUM
           MOVE    "R02"               TO  SPATMP-GYOUMUID
           MOVE    SPA-TERMID          TO  SPATMP-TERMID
           MOVE    "SPAGMN"            TO  SPATMP-FILEMEI
      *
           MOVE    SPATMP-REC          TO  MCPDATA2-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "del1"              TO  MCP-PATHNAME
           PERFORM 900-SPATMP-CALL-SEC
      *
           INITIALIZE                      SPATMP-REC
           MOVE    SPA-HOSPNUM         TO  SPATMP-HOSPNUM
           MOVE    "R02"               TO  SPATMP-GYOUMUID
           MOVE    SPA-TERMID          TO  SPATMP-TERMID
           MOVE    "SPAGMN"            TO  SPATMP-FILEMEI
           MOVE    1                   TO  SPATMP-EDANUM
           MOVE    SPA-SCR-REC         TO  SPATMP-DATA-REC
      *
           MOVE    SPATMP-REC          TO  MCPDATA2-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-SPATMP-CALL-SEC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "R02 SPATMP INSERT ERR:"  MCP-RC
                           ",KEY:" SPATMP-KEY
               MOVE    "9999"          TO  SPA-ERRCD
           END-IF
           .
       000-R02SPA-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト作成キャンセル処理
      *****************************************************************
       2004-RECEIPT-CANCEL-SEC     SECTION.
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
           MOVE    WRK-CONS-JOB-SHELLID1
                                   TO  JOB-SHELLID
          PERFORM 900-CALL-ORCSJOB-SEC
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               IF      JOB-ENDYMD      =   SPACE
                   MOVE    "070"           TO  WRK-ERRCD
                   STRING  "レセプト印刷処理中です【"
                                             DELIMITED  BY  SIZE
                           JOB-SHELLMSG      DELIMITED  BY  SPACE
                           "】"              DELIMITED  BY  SIZE
                                             INTO  WRK-ERRMSG
                   END-STRING
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
      *    共通エラー
           WHEN    "089"
               MOVE    SPACE                   TO  WRK-ERRMSG
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
