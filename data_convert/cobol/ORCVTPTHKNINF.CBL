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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCVTPTHKNINF.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＤＢ作成処理
      *  コンポーネント名  : ＣＳＶファイルコンバート処理（患者保険）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/04/11    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者        日付      内容
      *  01.00.01    MCC-伊藤      01/09/26  記号の末尾のピリオドを取る 
      *  01.00.02    MCC-藤原      01/11/01  患者番号の空白までで桁数
      *                                      を編集  
      *  01.00.03    MCC-藤原      01/11/01  氏名・かな氏名を空白まで
      *                                      を編集  
      *  01.00.04    MCC-伊藤      01/12/12  患者番号構成に合わせて
      *                                      前０詰め編集を行う  
      *  01.00.05    MCC-伊藤      01/12/12  ＤＢコールインターフェイス
      *                                      の変更
      *  01.00.06    MCC-藤原      02/01/07  適用開始年月日の編集修正
      ************************************   OpenCOBOL対応
      *  01.00.07    MCC-伊藤      02/02/14  文字と数字の変換
      *  01.00.08    MCC-森脇      02/05/01  空白編集の変更  
      *  01.00.09    NACL-森脇     05/07/13  エラーメッセージ、コミット
      *  01.00.10    NACL-森脇     05/08/25  負担区分追加
      *  01.00.11    NACL-森脇     05/09/26  構造変更
      *  01.00.12    NACL-多々納   06/01/12  補助区分編集修正
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメータファイル
           SELECT  PARA-FILE       ASSIGN
                                   "/home/orca/ORCADC.PARA"
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-PARA.
      *
      *    入力患者保険情報ＣＳＶファイル
           SELECT  CSV-FILE        ASSIGN
                                   ASS-CSV
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-CSV.
      *
      *    出力エラーファイル
           SELECT  ERR-FILE        ASSIGN
                                   ASS-ERR
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-LST.
      *
      *    分割ファイル
           SELECT  ISAM-FILE       ASSIGN
                                   ASS-ISAM
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  ISAM-KEY
                                   FILE    STATUS  IS  STS-ISAM.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *    パラメータファイル
       FD  PARA-FILE.
       01  PARA-REC.
           03  PARA-RECKBN             PIC X(01).
           03  PARA-DATKBN             PIC X(04).
           03  FILLER                  PIC X(01).
           03  PARA-DATA               PIC X(100).
      *
      *    入力患者保険情報ＣＳＶファイル
       FD  CSV-FILE.
       01  CSV-REC.
           03  CSV-R                   PIC X(300).
           03  CSV-RR  REDEFINES       CSV-R.
               05  CSV-X               PIC X(01)  OCCURS   300.
      *
      *    出力エラーファイル
       FD  ERR-FILE.
       01  ERR-REC                     PIC X(100).
      *
      *    分割レコード
       FD  ISAM-FILE.
       01  ISAM-REC.
           03  ISAM-KEY.
               05  ISAM-PTID           PIC 9(10).
               05  ISAM-HKNID          PIC 9(10).
           03  ISAM-TBL.
               05  ISAM-HKNNUM         PIC X(03).
               05  ISAM-FTNKBN         PIC X(01).
               05  ISAM-HKNJANUM       PIC X(08).
               05  ISAM-HIHKNJANAME    PIC X(100).
               05  ISAM-HONKZKKBN      PIC X(01).
               05  ISAM-HOJOKBN        PIC X(01).
               05  ISAM-CONTKBN        PIC X(01).
               05  ISAM-KIGO           PIC X(80).
               05  ISAM-NUM            PIC X(80).
               05  ISAM-GAIFTN         PIC 9(03).
               05  ISAM-NYUFTN         PIC 9(03).
               05  ISAM-JKYSNUM        PIC X(20).
               05  ISAM-TEKSTYMD       PIC X(08).
               05  ISAM-TEKEDYMD       PIC X(08).
               05  ISAM-KAKUNINYMD     PIC X(08).
               05  ISAM-CREYMD         PIC X(08).
               05  ISAM-UPYMD          PIC X(08).
               05  ISAM-PTNUM          PIC X(20).
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    ファイル指定領域
       01  ASS-AREA.
           03  ASS-CSV                 PIC X(256).
           03  ASS-ERR                 PIC X(256).
           03  ASS-ISAM                PIC X(256).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA                PIC X(02).
           03  STS-CSV                 PIC X(02).
           03  STS-LST                 PIC X(02).
           03  STS-ISAM                PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PARA                PIC 9(01).
           03  FLG-CSV                 PIC 9(01).
           03  FLG-ISAM                PIC 9(01).
      *
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-PTNUM               PIC 9(01).
           03  FLG-PTINF               PIC 9(01).
           03  FLG-PTHKNINF            PIC 9(01).
      *
           03  FLG-ERRARI              PIC 9(01).
           03  FLG-DATAEND             PIC 9(01).
           03  FLG-AREA1.
               05  FLG-ERR             PIC 9(01).
               05  FLG-COMMA           PIC 9(01).
               05  FLG-DELI1           PIC 9(01).
               05  FLG-DELI2           PIC 9(01).
               05  FLG-NODATA          PIC 9(01).
      *
           03  FLG-YMD                 PIC 9(01).
      *
           03  FLG-ROUJIN              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PARA                PIC 9(06).
           03  CNT-CSV                 PIC 9(06).
           03  CNT-ISAM                PIC 9(06).
           03  CNT-ERR                 PIC 9(06).
           03  CNT-COMMIT              PIC 9(06).
           03  CNT-PTNUM               PIC 9(06).
           03  CNT-PTHKNINF            PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
           03  IDZ                     PIC 9(04).
           03  IDS                     PIC 9(04).
           03  IDE                     PIC 9(04).
           03  IDI                     PIC 9(02).
      *
      *    パラメータ保存
       01  PARA-SAVE.
           03  PARA-05-1               PIC X(02).
           03  PARA-06-1               PIC X(08).
           03  PARA-00-2               PIC X(01).
           03  PARA-09-2               PIC X(06).
           03  PARA-11-2               PIC X(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-SYMD2.
               05  WRK-SYY2            PIC 9(02).
               05  WRK-SMM2            PIC 9(02).
               05  WRK-SDD2            PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY           PIC 9(04).
               05  WRK-SYSMM           PIC 9(02).
               05  WRK-SYSDD           PIC 9(02).
      *
           03  WRK-POINT-AREA.
               05  WRK-PO-ST           PIC 9(04).
               05  WRK-PO-ED           PIC 9(04).
           03  WRK-MOVE-AREA.
               05  WRK-MO-ST           PIC 9(04).
               05  WRK-MO-CNT          PIC 9(04).
               05  WRK-WK              PIC 9(04).
           03  WRK-DATA                PIC X(200).
           03  WRK-LEN                 PIC 9(03).
           03  WRK-CNT                 PIC 9(04).
      *
           03  WRK-RENKETA             PIC 9(02).
           03  WRK-COMMIT              PIC 9(06).
           03  WRK-ERR                 PIC 9(06).
      *
           03  WRK-DBPATH              PIC X(64).
           03  WRK-PTID                PIC 9(10).
           03  WRK-HKNID               PIC 9(10).
           03  WRK-NUM1                PIC 9(01).
           03  WRK-NUM2                PIC 9(02).
           03  WRK-KOUMOKU-NO          PIC 9(04).
     *
           03  WRK-HEN-FTNKBN2         PIC X(01).
     *
           03  WRK-BASEYMD.
               05  WRK-BYY             PIC 9(04).
               05  WRK-BMM             PIC 9(02).
               05  WRK-BDD             PIC 9(02).
           03  WRK-BYMD-70.
               05  WRK-B70-YY          PIC 9(04).
               05  WRK-B70-MM          PIC 9(02).
               05  WRK-B70-DD          PIC 9(02).
      *
      *    新フォーマット用
       01  WRK-HEN-AREA.
           03  WRK-HEN-PTNUM           PIC X(20).
           03  WRK-HEN-FTNKBN          PIC X(01).
           03  WRK-HEN-HOJOKBN         PIC X(01).
           03  WRK-HEN-GAIFTN          PIC 9(03).
           03  WRK-HEN-NYUFTN          PIC 9(03).
           03  WRK-HEN-TEKSTYMD        PIC X(08).
           03  WRK-HEN-TEKEDYMD        PIC X(08).
      *
      *    帳票出力領域
       01  MES-AREA.
           03  MES-TITLE1.
               05  FILLER              PIC X(26) VALUE
                                       "【PGID:ORCVTPTHKNINF.CBL】".
               05  MES-TITLE1-YY       PIC X(04) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-MM       PIC X(02) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-DD       PIC X(02) VALUE SPACE.
           03  MES-TITLE2.
               05  MES-TITLE2-L1.
                   07  FILLER          PIC X(10) VALUE "LINENO ERR".
                   07  FILLER          PIC X(42) VALUE
                   " [1]必須未入力        [2]項目桁数不正     ".
                   07  FILLER          PIC X(10) VALUE " [3]誤入力".
               05  MES-TITLE2-L2.
                   07  FILLER          PIC X(10) VALUE SPACE.
                   07  FILLER          PIC X(42) VALUE
                   " [5]患者番号取得失敗  [6]患者情報取得失敗 ".
                   07  FILLER          PIC X(42) VALUE
                   " [7]患者番号更新失敗  [8]患者保険出力失敗".
               05  MES-TITLE2-L3.
                   07  FILLER          PIC X(30) VALUE
                   "       MSG [9]労災保険スキップ".
               05  MES-TITLE2-L4.
                   07  FILLER          PIC X(50) VALUE
                   "--------------------------------------------------".
                   07  FILLER          PIC X(49) VALUE
                   "-------------------------------------------------".
      *
       01  ERRLST-AREA.
      *    エラー番号１・２・３　で使用
           03  ERR-REC1.
               05  ERR1-LINENO         PIC X(06).
               05  FILLER              PIC X(01).
               05  ERR1-NAIYO          PIC X(03).
               05  ERR-OCCURS          OCCURS   4.
                   07  FILLER          PIC X(01).
                   07  ERR1-ERRNO      PIC X(03).
                   07  ERR1-KOMOKU     PIC X(09).
                   07  ERR1-ATAI       PIC X(08).
      *    エラー番号５・６・７・８・９　で使用
           03  ERR-REC2.
               05  ERR2-LINENO         PIC X(06).
               05  FILLER              PIC X(01).
               05  ERR2-NAIYO          PIC X(03).
               05  FILLER              PIC X(01).
               05  ERR2-ERRNO          PIC X(03).
               05  ERR2-PTNUMMES       PIC X(09).
               05  ERR2-PTNUM          PIC X(10).
               05  FILLER              PIC X(02).
               05  ERR2-PTIDMES        PIC X(09).
               05  ERR2-PTID           PIC X(10).
               05  FILLER              PIC X(02).
               05  ERR2-HKNNUMMES      PIC X(09).
               05  ERR2-HKNNUM         PIC X(03).
               05  FILLER              PIC X(01).
               05  ERR2-HKNIDMES       PIC X(05).
               05  ERR2-HKNID          PIC X(02).
               05  FILLER              PIC X(01).
               05  ERR2-TEKSTEDMES     PIC X(05).
               05  ERR2-TEKSTYMD       PIC X(08).
               05  ERR2-TEKBAR         PIC X(01).
               05  ERR2-TEKEDYMD       PIC X(08).
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    システム管理（医療機関情報）
           COPY    "CPSK1001.INC".
      *    システム管理（患者番号構成管理）
           COPY    "CPSK1009.INC".
      *    患者保険情報
       01  PTHKN-REC.
           COPY    "CPPTHKNINF.INC".
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
           COPY    "CPORCXKANACONV.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
       PROCEDURE                   DIVISION.
      ****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-CSV     =   1
      *    分割レコードがあれば処理
           PERFORM 250-PTHKNINF-BUNKATU-SET-SEC
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  SPA-AREA
      *
      *    パラメータ情報取得
           PERFORM 101-PARA-GET-SEC
           IF  FLG-PARA            =   2
               MOVE    1           TO  FLG-CSV
               GO  TO  100-INIT-EXT
           END-IF
      *
           ACCEPT  WRK-SYMD2       FROM    DATE
           MOVE    WRK-SYMD2       TO  WRK-SYSYMD (3:)
           ADD     2000            TO  WRK-SYSYY
           MOVE    WRK-SYSYMD      TO  SPA-SYSYMD
           MOVE    SPA-SYSYMD(1:4) TO  MES-TITLE1-YY
           MOVE    SPA-SYSYMD(5:2) TO  MES-TITLE1-MM
           MOVE    SPA-SYSYMD(7:2) TO  MES-TITLE1-DD
      *    端末ＩＤ固定
           MOVE    "ORCATERM"      TO  SPA-TERMID
      *
      *    データベースオープン
           PERFORM 100-DBOPEN-SEC
      *
      *    システム管理情報　検索処理
           PERFORM 120-CP1001-KENSAKU-SEC
           IF  FLG-CSV             =   1
               GO  TO  100-INIT-EXT
           END-IF
      *
           PERFORM 120-CP1009-KENSAKU-SEC
           IF  FLG-CSV             =   1
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    ＣＳＶ入力ファイル　初期処理
           OPEN    INPUT           CSV-FILE
           IF  STS-CSV         NOT =   ZERO
               MOVE    1           TO  FLG-CSV
               DISPLAY "*(ORCVTPTHKNINF)* PTHKN-FILE OPN STS["
                                       STS-CSV "]"
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    帳票出力　初期処理
           PERFORM 2710-ERRLST-INIT-SEC
           IF  FLG-CSV             =   1
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    分割レコードファイル　初期処理
           MOVE    "/tmp/ORCVTPTHKNINF_ISAM"
                                   TO  ASS-ISAM
      *    ISAMファイルクリア
           OPEN    OUTPUT              ISAM-FILE
           CLOSE                       ISAM-FILE
      *
           OPEN    I-O                 ISAM-FILE
      *
           MOVE    PARA-05-1       TO  WRK-RENKETA(1:2)
           MOVE    PARA-09-2       TO  WRK-COMMIT
           MOVE    PARA-11-2       TO  WRK-ERR
      *
      *    患者保険ＣＳＶファイル　検索処理
           PERFORM 900-CSV-KENSAKU-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメータ情報取得
      *****************************************************************
       101-PARA-GET-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-PARA
           MOVE    SPACE           TO  PARA-SAVE
           OPEN    INPUT               PARA-FILE
           IF      STS-PARA        NOT =   ZERO
               MOVE    2               TO  FLG-PARA
               DISPLAY "*(ORCVTPTHKNINF)* PARA-FILE OPN STS["
                       STS-PARA "]"
               GO  TO  101-PARA-GET-EXT
           END-IF
      *
           PERFORM 900-PARA-READ-SEC
      *
           PERFORM UNTIL   FLG-PARA    =   1
               IF      PARA-RECKBN         =   "@"
                   PERFORM 101-PARA-GET1-SEC
               END-IF
               PERFORM  900-PARA-READ-SEC
           END-PERFORM
      *
           CLOSE                       PARA-FILE
      *
      *    パラメータチェック処理
           IF    ( PARA-05-1           IS  NUMERIC )   AND
                 ( PARA-09-2           IS  NUMERIC )   AND
                 ( PARA-11-2           IS  NUMERIC )
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-CSV
               GO  TO  101-PARA-GET-EXT
           END-IF
      *
           .
       101-PARA-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメータ情報取得（１）
      *****************************************************************
       101-PARA-GET1-SEC           SECTION.
      *
           EVALUATE    PARA-DATKBN
               WHEN    "01-2"
                   MOVE    PARA-DATA   TO  ASS-CSV
               WHEN    "02-2"
                   MOVE    PARA-DATA   TO  ASS-ERR
               WHEN    "05-1"
                   MOVE    PARA-DATA   TO  PARA-05-1
               WHEN    "06-1"
                   MOVE    PARA-DATA   TO  PARA-06-1
               WHEN    "09-2"
                   MOVE    PARA-DATA   TO  PARA-09-2
               WHEN    "00-2"
                   MOVE    PARA-DATA   TO  PARA-00-2
               WHEN    "11-2"
                   MOVE    PARA-DATA   TO  PARA-11-2
           END-EVALUATE
      *
           .
       101-PARA-GET1-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理情報　検索処理
      *****************************************************************
       120-CP1001-KENSAKU-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
           MOVE    SPACE           TO  SYS-1001-REC
           MOVE    "1001"          TO  SYS-1001-KANRICD
           MOVE    SYS-1001-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
           MOVE    WRK-SYSYMD      TO  ORC-DBYMD
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
               PERFORM 900-SYSTEM-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   1
               MOVE    1               TO  FLG-CSV
           ELSE
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
               MOVE    SYS-1001-HOSPID     TO  SPA-HOSPID
               MOVE    SYS-1001-HOSPSBT    TO  SPA-HOSPSBT
               MOVE    SYS-1001-ROUPAYKBN  TO  SPA-ROUPAYKBN
           END-IF
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       120-CP1001-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理情報　検索処理
      *****************************************************************
       120-CP1009-KENSAKU-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
           MOVE    SPACE           TO  SYS-1009-REC
           MOVE    "1009"          TO  SYS-1009-KANRICD
           MOVE    "*"             TO  SYS-1009-KBNCD
           MOVE    SYS-1009-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           MOVE    WRK-SYSYMD      TO  ORC-DBYMD
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               PERFORM 900-SYSTEM-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   1
               MOVE    1               TO  FLG-CSV
           ELSE
               MOVE    MCPDATA-REC     TO  SYS-1009-REC
           END-IF
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       120-CP1009-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    1000件ごとにメッセージを表示
           IF      CNT-CSV (4:3)       =   ZERO
               DISPLAY "***(ORCVTPTHKNINF)*** CNT-CSV[" CNT-CSV "]"
           END-IF
      *    指定した件数になったらコミット処理
           IF      CNT-COMMIT          =   WRK-COMMIT
               PERFORM 900-DBCOMMIT-SEC
               MOVE    ZERO            TO  CNT-COMMIT
           END-IF
      *    エラーが指定した件数になったら処理終了
           IF    ( WRK-ERR         NOT =   ZERO )  AND
                 ( CNT-ERR             =   WRK-ERR )
               MOVE    1               TO  FLG-CSV
               GO  TO  200-MAIN-EXT
           END-IF
      *
           INITIALIZE                  PTHKN-REC
           MOVE    SPACE           TO  PTHKN-REC
           INITIALIZE                  WRK-HEN-AREA
           MOVE    SPACE           TO  WRK-HEN-AREA
           MOVE    ZERO            TO  WRK-POINT-AREA
           MOVE    ZERO            TO  IDX-AREA
           MOVE    ZERO            TO  FLG-ERRARI
           MOVE    ZERO            TO  FLG-DATAEND
           MOVE    ZERO            TO  WRK-KOUMOKU-NO
      *
      *    患者保険ＣＳＶファイルに存在する項目数分、繰り返す
      *    またはレコード終了、または項目エラー４個まで
           PERFORM VARYING   IDX   FROM    1   BY  1
                   UNTIL   ( IDX           >   18   )
                   OR      ( WRK-PO-ED     >=  300  )
                   OR      ( IDE           >   4    )
      *
               MOVE    ZERO            TO  FLG-AREA1
               COMPUTE WRK-PO-ST   =   WRK-PO-ED   +   1
      *
               IF  ( CSV-R (WRK-PO-ST:)    =   SPACE )  OR
                   ( FLG-DATAEND           =   1     )
                   MOVE    1           TO  FLG-DATAEND
                   MOVE    WRK-PO-ST   TO  WRK-PO-ED
               ELSE
                   ADD     1             TO  WRK-KOUMOKU-NO
      *            項目終了文字後のカンマ位置を取得
                   PERFORM 210-CHAR-END-GET-SEC
               END-IF
      *        項目共通処理
               PERFORM 220-KOUMOKU-KYOTU-SEC
      *        項目別チェック処理
               PERFORM 240-KOUMOKU-BETU-SEC
           END-PERFORM
      *
           IF      FLG-ERRARI              =   ZERO
      *        患者保険情報セット
               PERFORM 250-PTHKNINF-SET-SEC
               IF      FLG-ERR             NOT =   ZERO
      *            エラーリスト編集/出力処理
                   PERFORM 270-ERRREC-EDIT-SEC
                   MOVE    2           TO  FLG-ERRARI
                   PERFORM 270-ERRLST-OUT-SEC
               END-IF
           ELSE
      *        エラーリスト出力処理
               PERFORM 270-ERRLST-OUT-SEC
           END-IF
      *
      *    患者保険ＣＳＶファイル　検索処理
           PERFORM 900-CSV-KENSAKU-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象項目の文字終了位置を取得
      *****************************************************************
       210-CHAR-END-GET-SEC        SECTION.
      *
           PERFORM VARYING   IDY   FROM    WRK-PO-ST   BY  1
                   UNTIL   ( IDY           >=  300  )
                   OR      ( FLG-COMMA     =   1    )
      *        カンマの位置
               IF    ( CSV-X (IDY)     =   ","  )  OR
                     ((IDX             =   18   )  AND
                      (CSV-X (IDY)     =   SPACE))
                   MOVE    IDY         TO  WRK-PO-ED
                   MOVE    1           TO  FLG-COMMA
               END-IF
      *        デリミタ(")存在するかどうか
               IF      CSV-X (IDY)         =   """"
                   IF      FLG-DELI1       =   ZERO
                       MOVE    1       TO  FLG-DELI1
                   ELSE
                       MOVE    1       TO  FLG-DELI2
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       210-CHAR-END-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目共通処理
      *****************************************************************
       220-KOUMOKU-KYOTU-SEC       SECTION.
      *
           MOVE    ZERO            TO  WRK-MOVE-AREA
      *
      *    データが省略されている場合、FLG-NODATAに1をセット
           IF      FLG-DELI1           =   1
      *        デリミタ(")を含んでいる場合
               IF      FLG-DELI2       =   1
                   COMPUTE WRK-WK      =   WRK-PO-ST   +   2
               ELSE
                   COMPUTE WRK-WK      =   WRK-PO-ST   +   1
               END-IF
               IF  WRK-WK              =   WRK-PO-ED
                   MOVE    1           TO  FLG-NODATA
                   GO  TO  220-KOUMOKU-KYOTU-EXT
               END-IF
           ELSE
      *        デリミタ(")を含んでいない場合
               IF      WRK-PO-ST       =   WRK-PO-ED
                   MOVE    1           TO  FLG-NODATA
                   GO  TO  220-KOUMOKU-KYOTU-EXT
               END-IF
           END-IF
      *
      *    転送開始位置・転送桁数を算出
           IF      FLG-DELI1           =   1
      *        デリミタ(")を含んでいる場合
               COMPUTE WRK-MO-ST       =   WRK-PO-ST   +   1
               IF  FLG-DELI2           =   1
                   COMPUTE WRK-MO-CNT  =   WRK-PO-ED
                                       -  (WRK-PO-ST   +   2)
               ELSE
                   COMPUTE WRK-MO-CNT  =  (WRK-PO-ED   -   1)
                                       -   WRK-PO-ST
               END-IF
           ELSE
      *        デリミタ(")を含んでいない場合
               MOVE    WRK-PO-ST       TO  WRK-MO-ST
               COMPUTE WRK-MO-CNT      =   WRK-PO-ED  -  WRK-PO-ST
           END-IF
      *
           .
       220-KOUMOKU-KYOTU-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目別処理
      *****************************************************************
       240-KOUMOKU-BETU-SEC        SECTION.
      *
           EVALUATE    WRK-KOUMOKU-NO
      *    １：患者番号
           WHEN    1
               PERFORM 2410-PTNUM-SET-SEC
      *    ２：レコード番号（保険番号）
           WHEN    2
               PERFORM 2410-RECORD-HKN-SET-SEC
      *    ３：法別番号
           WHEN    3
               PERFORM 2410-HBTNUM-SET-SEC
      *    ４：負担区分
           WHEN    4
               PERFORM 2410-FTNKBN-SET-SEC
      *    ５：保険者番号
           WHEN    5
               PERFORM 2410-HKNJANUM-SET-SEC
      *    ６：本人家族区分
           WHEN    6
               PERFORM 2410-HONKZKKBN-SET-SEC
      *    ７：補助区分
           WHEN    7
               PERFORM 2410-HOJOKBN-SET-SEC
      *    ８：継続区分
           WHEN    8
               PERFORM 2410-CONTKBN-SET-SEC
      *    ９：記号
           WHEN    9
               PERFORM 2410-KIGO-SET-SEC
      *    １０：番号
           WHEN    10
               PERFORM 2410-NUM-SET-SEC
      *    １１：被保険者氏名
           WHEN    11
               PERFORM 2410-HIHKNJANAME-SET-SEC
      *    １２：外来負担率（％）
           WHEN    12
               PERFORM 2410-GAIFTN-SET-SEC
      *    １３：入院負担率（％）
           WHEN    13
               PERFORM 2410-NYUFTN-SET-SEC
      *    １４：適用開始日
           WHEN    14
               PERFORM 2410-TEKSTYMD-SET-SEC
      *    １５：適用終了日
           WHEN    15
               PERFORM 2410-TEKEDYMD-SET-SEC
      *    １６：保険確認日
           WHEN    16
               PERFORM 2410-KAKUNINYMD-SET-SEC
      *    １７：登録日
           WHEN    17
               PERFORM 2410-CREYMD-SET-SEC
      *    １８：更新日
           WHEN    18
               PERFORM 2410-UPYMD-SET-SEC
      *    フォーマットエラー
           WHEN    OTHER
      *        旧フォーマットの場合
               IF      PARA-00-2       =  "1"
                   IF      IDX         >   17
                       MOVE    3       TO  FLG-ERR
                   END-IF
               END-IF
           END-EVALUATE
      *
           IF      FLG-ERR         NOT =   ZERO
               MOVE    1           TO  FLG-ERRARI
               PERFORM 270-ERRREC-EDIT-SEC
           END-IF
      *
           .
       240-KOUMOKU-BETU-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目空白処理
      *****************************************************************
       2401-SPACE-HENSYU-SEC       SECTION.
      *
           MOVE    ZERO            TO  WRK-LEN
      *
           IF      WRK-DATA            =   SPACE
               MOVE    1               TO  WRK-LEN
           ELSE
               PERFORM VARYING IDS FROM    200 BY  -1
                       UNTIL   IDS <       1
                   IF      WRK-DATA (IDS:1)    NOT =   SPACE
                       MOVE    IDS             TO  WRK-LEN
                       MOVE    1               TO  IDS
                   END-IF
               END-PERFORM
      *
      *        後ろの全角空白を削除
               IF      WRK-LEN             >   1
                   PERFORM 24021-KUHAKU-DEL-SEC
               END-IF
           END-IF
           .
       2401-SPACE-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    全角桁数・空白処理
      *****************************************************************
       2402-ZENKAKU-HEN-SEC        SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    WRK-DATA        TO  KANACHK-MAE-INPUT
           MOVE    WRK-CNT         TO  KANACHK-MAX-CNT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           MOVE    KANACHK-MAE-INPUT   TO  WRK-DATA
           MOVE    KANACHK-MAX         TO  WRK-LEN
           IF      KANACHK-RC      NOT =   ZERO
      *        全角・半角混在エラ−
               MOVE    3               TO  FLG-ERR
           ELSE
               IF      KANACHK-SYUBETU =   1
      *        半角を全角へ
                   INITIALIZE                  ORCSKANACHKAREA
                   MOVE    "2"             TO  KANACHK-SYORI
                   MOVE    WRK-DATA        TO  KANACHK-MAE-INPUT
                   MOVE    WRK-CNT         TO  KANACHK-MAX-CNT
                   CALL    "ORCSKANACHK"       USING
                                               ORCSKANACHKAREA
                   IF      KANACHK-RC      =   ZERO
                       MOVE    KANACHK-MAX         TO  WRK-LEN
                       MOVE    KANACHK-OUT-INPUT   TO  WRK-DATA
                   END-IF
               ELSE
                   MOVE    KANACHK-OUT-INPUT   TO  WRK-DATA
               END-IF
           END-IF
           IF      WRK-LEN         =   ZERO
               MOVE    1               TO  WRK-LEN
           END-IF
      *    後ろの全角空白を削除
           IF      WRK-LEN         >   1
               PERFORM 24021-KUHAKU-DEL-SEC
           END-IF
           .
       2402-ZENKAKU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    全角空白削除処理
      *****************************************************************
       24021-KUHAKU-DEL-SEC        SECTION.
      *
           COMPUTE IDZ             =   WRK-LEN     -   1
           IF      WRK-DATA (IDZ:2)    =   "　"
               MOVE    1                   TO  WRK-LEN
               PERFORM VARYING IDS     FROM    IDZ BY  -2
                       UNTIL   IDS     <   2
                   IF      WRK-DATA (IDS:2)    NOT =   "　"
                       COMPUTE WRK-LEN         =   IDS     +   1
                       MOVE    2               TO  IDS
                   ELSE
                       IF      IDS             =   3
                           IF      WRK-DATA (1:2)      NOT =   "　"
                               MOVE    2               TO  WRK-LEN
                           END-IF
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
           .
       2402-ZENKAKU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１：患者番号　処理
      *****************************************************************
       2410-PTNUM-SET-SEC          SECTION.
      *
           MOVE    SPACE           TO  SPA-PTNUM
      *
      *    必須未入力
           IF      FLG-NODATA          =   1
               MOVE    1               TO  FLG-ERR
               GO  TO  2410-PTNUM-SET-EXT
           END-IF
      *
      *    空白までを編集する
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-HEN-PTNUM
           MOVE    ZERO                TO  WRK-CNT
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL ( IDZ >       WRK-MO-CNT )
                   OR    ( WRK-HEN-PTNUM (IDZ:1)   =   SPACE )
               MOVE    IDZ             TO  WRK-CNT
           END-PERFORM
           MOVE    WRK-CNT             TO  WRK-MO-CNT
      *
      *    項目桁数不正
           IF    ( WRK-MO-CNT          =   0  )    OR
                 ( WRK-MO-CNT          >   20 )
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-PTNUM-SET-EXT
           END-IF
      *
      *    患者番号セット
           IF   (( SYS-1009-PTNUMKSIKBN    =   "1" ) AND
                 ( SYS-1009-JIYKSIKBN      =   "2" ))    OR
                (( SYS-1009-PTNUMKSIKBN    =   "2" ) AND
                 ( SYS-1009-HJNKSIKBN      =   "3" OR "4" ))
               MOVE    ZERO            TO  SPA-PTNUM(1:WRK-RENKETA)
               COMPUTE IDZ             =   WRK-RENKETA
                                       -   WRK-MO-CNT
                                       +   1
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  SPA-PTNUM(IDZ:)
           ELSE
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  SPA-PTNUM
           END-IF
      *
           .
       2410-PTNUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目２：レコード番号（保険番号）　処理
      *****************************************************************
       2410-RECORD-HKN-SET-SEC     SECTION.
      *
      *    必須未入力
           IF      FLG-NODATA          =   1
               MOVE    1               TO  FLG-ERR
               GO  TO  2410-RECORD-HKN-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   2
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-RECORD-HKN-SET-EXT
           END-IF
      *
      *    誤入力
           IF  ( CSV-REC (WRK-MO-ST:WRK-MO-CNT) IS NOT NUMERIC  ) OR
               ( CSV-REC (WRK-MO-ST:WRK-MO-CNT) =   ZERO )
               MOVE    3               TO  FLG-ERR
               GO  TO  2410-RECORD-HKN-SET-EXT
           END-IF
      *
      *    保険番号セット
           IF      WRK-MO-CNT  =   1
               MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-NUM1
               MOVE  WRK-NUM1          TO  PTHKN-HKNID
           ELSE
               MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-NUM2
               MOVE  WRK-NUM2          TO  PTHKN-HKNID
           END-IF
      *
           .
       2410-RECORD-HKN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目３：法別番号
      *****************************************************************
       2410-HBTNUM-SET-SEC         SECTION.
      *
      *    必須未入力
           IF      FLG-NODATA          =   1
               MOVE    1               TO  FLG-ERR
               GO  TO  2410-HBTNUM-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   2
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-HBTNUM-SET-EXT
           END-IF
      *
           EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
      *        法別番号セット
               WHEN    "01"    THRU    "04"
               WHEN    "06"    THRU    "07"
               WHEN    "31"    THRU    "34"
               WHEN    "60"
               WHEN    "63"
               WHEN    "67"
               WHEN    "72"    THRU    "75"
               WHEN    "98"    THRU    "99"
                   CONTINUE
      *        誤入力
               WHEN    OTHER
                   MOVE    3           TO  FLG-ERR
                   GO  TO  2410-HBTNUM-SET-EXT
           END-EVALUATE
      *
      *    保険番号セット
           EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
      *        労災？？→保険番号不確定
               WHEN    "98"
                   MOVE    "971"       TO  PTHKN-HKNNUM
      *        自費
               WHEN    "99"
                   MOVE    "980"       TO  PTHKN-HKNNUM
      *        その他
               WHEN    OTHER
                   MOVE    "0"         TO  PTHKN-HKNNUM (1:1)
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-HKNNUM (2:2)
           END-EVALUATE
      *
           .
       2410-HBTNUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目４：負担区分　処理
      *****************************************************************
       2410-FTNKBN-SET-SEC         SECTION.
      *
      *    旧フォーマットの場合次の項目
           IF      PARA-00-2           =   "1"
               MOVE    "0"             TO  WRK-HEN-FTNKBN
               ADD     1               TO  WRK-KOUMOKU-NO
               PERFORM 2410-HKNJANUM-SET-SEC
               GO  TO  2410-FTNKBN-SET-EXT
           END-IF
      *
      *    未入力
           IF      FLG-NODATA          =   1
               MOVE    "0"             TO  WRK-HEN-FTNKBN
               GO  TO  2410-FTNKBN-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          NOT =   1
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-FTNKBN-SET-EXT
           END-IF
      *
      *    負担区分セット
           EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
               WHEN    "0"
               WHEN    "1"
               WHEN    "2"
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-HEN-FTNKBN
      *        誤入力
               WHEN    OTHER
                   MOVE    3           TO  FLG-ERR
           END-EVALUATE
      *
           .
       2410-FTNKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目５：保険者番号　処理
      *****************************************************************
       2410-HKNJANUM-SET-SEC       SECTION.
      *
      *    必須未入力
           IF      FLG-NODATA          =   1
      *        自費・労災以外
               IF    ( PTHKN-HKNNUM    NOT =   "971" )  AND
                     ( PTHKN-HKNNUM    NOT =   "980" )
                   MOVE    1           TO  FLG-ERR
               END-IF
               GO  TO  2410-HKNJANUM-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >  8
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-HKNJANUM-SET-EXT
           END-IF
      *
      *    保険者番号セット
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                   TO  WRK-DATA
           PERFORM 2401-SPACE-HENSYU-SEC
           MOVE    WRK-DATA (1:WRK-LEN)
                                   TO  PTHKN-HKNJANUM
      *
           .
       2410-HKNJANUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目６：本人家族区分　処理
      *****************************************************************
       2410-HONKZKKBN-SET-SEC      SECTION.
      *
      *    必須未入力
           IF      FLG-NODATA          =   1
               MOVE    1               TO  FLG-ERR
               GO  TO 2410-HONKZKKBN-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   1
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-HONKZKKBN-SET-EXT
           END-IF
      *
      *    本人家族区分セット
           EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
               WHEN    "1" 
               WHEN    "2"
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-HONKZKKBN
      *        誤入力
               WHEN    OTHER
                   MOVE    3           TO  FLG-ERR
                   GO  TO  2410-HONKZKKBN-SET-EXT
           END-EVALUATE
      *
           .
       2410-HONKZKKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目７：補助区分　処理
      *****************************************************************
       2410-HOJOKBN-SET-SEC        SECTION.
      *
      *    未入力
           IF      FLG-NODATA          =   1
               MOVE    SPACE           TO  WRK-HEN-HOJOKBN
               GO  TO  2410-HOJOKBN-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   1
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-HOJOKBN-SET-EXT
           END-IF
      *
      *    補助区分セット
           EVALUATE    PTHKN-HKNNUM
      *        船員
               WHEN    "002"
                   EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                       WHEN    "0"
                           MOVE    SPACE   TO  WRK-HEN-HOJOKBN
                       WHEN    "1"     THRU    "3"
                           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-HEN-HOJOKBN
      *                誤入力
                       WHEN    OTHER
                           MOVE    3       TO  FLG-ERR
                           GO  TO  2410-HOJOKBN-SET-EXT
                   END-EVALUATE
      *        国保
               WHEN    "060"
                   EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                       WHEN    "0"
                       WHEN    "1"     THRU    "3"
                           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-HEN-HOJOKBN
      *                誤入力
                       WHEN    OTHER
                           MOVE    3       TO  FLG-ERR
                           GO  TO  2410-HOJOKBN-SET-EXT
                   END-EVALUATE
      *        自費
               WHEN    "980"
                   EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                       WHEN    "0"
                           MOVE    "1"     TO  WRK-HEN-HOJOKBN
                       WHEN    "1"     THRU    "2"
                           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-HEN-HOJOKBN
      *                誤入力
                       WHEN    OTHER
                           MOVE    3       TO  FLG-ERR
                           GO  TO  2410-HOJOKBN-SET-EXT
                   END-EVALUATE
      *        共済
               WHEN    "031"    THRU    "034"
                   EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                       WHEN    "0"
                           MOVE    SPACE   TO  WRK-HEN-HOJOKBN
                       WHEN    "2"
                           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-HEN-HOJOKBN
      *                誤入力
                       WHEN    OTHER
                           MOVE    3       TO  FLG-ERR
                           GO  TO  2410-HOJOKBN-SET-EXT
                   END-EVALUATE
      *        船員・国保・自費以外
               WHEN    OTHER
                   EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                       WHEN    "0"
                           MOVE    SPACE   TO  WRK-HEN-HOJOKBN
      *                誤入力
                       WHEN    OTHER
                           MOVE    3       TO  FLG-ERR
                           GO  TO  2410-HOJOKBN-SET-EXT
                   END-EVALUATE
           END-EVALUATE
      *
           .
       2410-HOJOKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目８：継続区分　処理
      *****************************************************************
       2410-CONTKBN-SET-SEC        SECTION.
      *
      *    未入力
           IF      FLG-NODATA          =   1
               MOVE    SPACE           TO  PTHKN-CONTKBN
               GO  TO  2410-CONTKBN-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   1
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-CONTKBN-SET-EXT
           END-IF
      *
      *    継続区分セット
           EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
               WHEN    "0"
                   MOVE    SPACE       TO  PTHKN-CONTKBN
               WHEN    "1"
               WHEN    "2"
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-CONTKBN
      *        誤入力
               WHEN    OTHER
                   MOVE    3           TO  FLG-ERR
                   GO  TO  2410-CONTKBN-SET-EXT
           END-EVALUATE
      *
           .
       2410-CONTKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目９：記号　処理
      *****************************************************************
       2410-KIGO-SET-SEC           SECTION.
      *
      *    必須未入力
           IF      FLG-NODATA          =   1
      *        自費・労災以外
      *         IF    ( PTHKN-HKNNUM    NOT =   "971" )  AND
      *               ( PTHKN-HKNNUM    NOT =   "980" )
      *             MOVE    1           TO  FLG-ERR
      *         END-IF
               GO  TO  2410-KIGO-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   80
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-KIGO-SET-EXT
           END-IF
      *
      *    記号セット
           IF      WRK-MO-CNT          >  ZERO
               COMPUTE IDZ             =  WRK-MO-ST
                                       +  WRK-MO-CNT
                                       -  2
               IF      CSV-REC (IDZ:2) = "．"
                   COMPUTE WRK-MO-CNT  =  WRK-MO-CNT
                                       -  2
               END-IF
           END-IF
           IF      WRK-MO-CNT    >  ZERO
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
               PERFORM 2401-SPACE-HENSYU-SEC
               MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTHKN-KIGO
               IF      PTHKN-KIGO(1:2) = X"8080"
                   MOVE "・"           TO  PTHKN-KIGO(1:2)
               END-IF
               PERFORM VARYING IDZ     FROM    1   BY      2
                       UNTIL   IDZ     >   WRK-LEN
                   IF  PTHKN-KIGO(IDZ:2) =   X"8080"
                       MOVE "・"         TO  PTHKN-KIGO(1:2)
                       MOVE  WRK-LEN     TO  IDZ
                   END-IF
               END-PERFORM
           END-IF
      *
           .
       2410-KIGO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１０：番号　処理
      *****************************************************************
       2410-NUM-SET-SEC            SECTION.
      *
      *    必須未入力
           IF      FLG-NODATA          =   1
      *        自費・労災以外
      *         IF    ( PTHKN-HKNNUM     NOT =   "971" )  AND
      *               ( PTHKN-HKNNUM     NOT =   "980" )
      *             MOVE    1           TO  FLG-ERR
      *         END-IF
               GO  TO  2410-NUM-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   80
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-NUM-SET-EXT
           END-IF
      *
      *    番号セット
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                   TO  WRK-DATA
           PERFORM 2401-SPACE-HENSYU-SEC
           MOVE    WRK-DATA(1:WRK-LEN)
                                   TO  PTHKN-NUM
      *
           .
       2410-NUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１１：被保険者名　処理
      *****************************************************************
       2410-HIHKNJANAME-SET-SEC    SECTION.
      *
      *    未入力
           IF      FLG-NODATA          =   1
               GO  TO  2410-HIHKNJANAME-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   100
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-HIHKNJANAME-SET-EXT
           END-IF
      *
      *    被保険者名セット
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                   TO  WRK-DATA
           MOVE    100             TO  WRK-CNT
           PERFORM 2402-ZENKAKU-HEN-SEC
           IF      FLG-ERR         =   ZERO
               MOVE    WRK-DATA (1:WRK-LEN)
                                   TO  PTHKN-HIHKNJANAME
           END-IF
      *
           .
       2410-HIHKNJANAME-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１２：外来負担率（％）　処理
      *****************************************************************
       2410-GAIFTN-SET-SEC         SECTION.
      *
           MOVE    ZERO                TO  WRK-HEN-GAIFTN
      *    未入力
           IF      FLG-NODATA          =   1
               GO  TO  2410-GAIFTN-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   3
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-GAIFTN-SET-EXT
           END-IF
      *
      *    外来負担率セット
           EVALUATE    WRK-MO-CNT
               WHEN    1
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-NUM1
                   MOVE    WRK-NUM1        TO  WRK-HEN-GAIFTN
               WHEN    2
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-NUM2
                   MOVE    WRK-NUM2        TO  WRK-HEN-GAIFTN
               WHEN    3
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-HEN-GAIFTN
           END-EVALUATE
      *
           .
       2410-GAIFTN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１３：入院負担率（％）　処理
      *****************************************************************
       2410-NYUFTN-SET-SEC         SECTION.
      *
           MOVE    ZERO                TO  WRK-HEN-NYUFTN
      *    未入力
           IF      FLG-NODATA          =   1
               GO  TO  2410-NYUFTN-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   3
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-NYUFTN-SET-EXT
           END-IF
      *
      *    入院負担率セット
           EVALUATE    WRK-MO-CNT
               WHEN    1
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-NUM1
                   MOVE    WRK-NUM1        TO  WRK-HEN-NYUFTN
               WHEN    2
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-NUM2
                   MOVE    WRK-NUM2        TO  WRK-HEN-NYUFTN
               WHEN    3
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  WRK-HEN-NYUFTN
           END-EVALUATE
      *
           .
       2410-NYUFTN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１４：適用開始日　処理
      *****************************************************************
       2410-TEKSTYMD-SET-SEC       SECTION.
      *
      *    未入力
           IF      FLG-NODATA          =   1
               MOVE    PARA-06-1       TO  WRK-HEN-TEKSTYMD
               GO  TO  2410-TEKSTYMD-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          >   8
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-TEKSTYMD-SET-EXT
           END-IF
      *
      *    適用開始日セット
           IF      CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   ALL "0"
               MOVE    PARA-06-1       TO  WRK-SYMD
           ELSE
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-SYMD
           END-IF
           PERFORM 31012-SEIWA-HEN-SEC
           IF      FLG-YMD         =   1
               MOVE    3               TO  FLG-ERR
           ELSE
               MOVE    WRK-SYMD        TO  WRK-HEN-TEKSTYMD
           END-IF
      *
           .
       2410-TEKSTYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１５：適用終了日　処理
      *****************************************************************
       2410-TEKEDYMD-SET-SEC       SECTION.
      *
      *    未入力
           IF      FLG-NODATA          =   1
               MOVE    ALL "9"         TO  WRK-HEN-TEKEDYMD
               GO  TO  2410-TEKEDYMD-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          NOT =   8
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-TEKEDYMD-SET-EXT
           END-IF
      *
      *    適用終了日セット
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                   TO   WRK-SYMD
           IF      (WRK-SYMD        =   ALL "9")
               MOVE    WRK-SYMD        TO  WRK-HEN-TEKEDYMD
               GO  TO  2410-TEKEDYMD-SET-EXT
           END-IF
           PERFORM 31012-SEIWA-HEN-SEC
           IF      FLG-YMD         =   1
               MOVE    3               TO  FLG-ERR
           ELSE
               MOVE    WRK-SYMD        TO  WRK-HEN-TEKEDYMD
           END-IF
      *
           .
       2410-TEKEDYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１６：保険確認日　処理
      *****************************************************************
       2410-KAKUNINYMD-SET-SEC     SECTION.
      *
      *    未入力
           IF      FLG-NODATA          =   1
               GO  TO  2410-KAKUNINYMD-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          NOT =   8
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-KAKUNINYMD-SET-EXT
           END-IF
      *
      *    保険確認日セット
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-SYMD
           IF      WRK-SYMD (7:2)  =  ZERO
               MOVE    "01"            TO  WRK-SYMD (7:2)
           END-IF
           PERFORM 31012-SEIWA-HEN-SEC
           IF      FLG-YMD         =   1
               MOVE    3               TO  FLG-ERR
           ELSE
               MOVE    WRK-SYMD        TO  PTHKN-KAKUNINYMD
           END-IF
      *
           .
       2410-KAKUNINYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１７：登録日　処理
      *****************************************************************
       2410-CREYMD-SET-SEC         SECTION.
      *
      *    未入力
           IF      FLG-NODATA          =   1
               GO  TO  2410-CREYMD-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          NOT =   8
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-CREYMD-SET-EXT
           END-IF
      *
      *    登録日セット
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                   TO   WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           IF      FLG-YMD         =   1
               MOVE    3               TO  FLG-ERR
           ELSE
               MOVE    WRK-SYMD        TO  PTHKN-CREYMD
           END-IF
      *
           .
       2410-CREYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１８：更新日　処理
      *****************************************************************
       2410-UPYMD-SET-SEC          SECTION.
      *
      *    未入力
           IF      FLG-NODATA          =   1
               GO  TO  2410-UPYMD-SET-EXT
           END-IF
      *
      *    項目桁数不正
           IF      WRK-MO-CNT          NOT =   8
               MOVE    2               TO  FLG-ERR
               GO  TO  2410-UPYMD-SET-EXT
           END-IF
      *
      *    更新日セット
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                   TO   WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           IF      FLG-YMD         =   1
               MOVE    3               TO  FLG-ERR
           ELSE
               MOVE    WRK-SYMD        TO  PTHKN-UPYMD
           END-IF
      *
           .
       2410-UPYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険マスタ　セット処理
      *****************************************************************
       250-PTHKNINF-SET-SEC        SECTION.
      *
      *    労災ならスキップ処理
           IF          PTHKN-HKNNUM  =   "971"
               MOVE    9               TO  FLG-ERR
               GO  TO  250-PTHKNINF-SET-EXT
           END-IF
      *
      *    患者番号読み込み
           PERFORM 900-PTNUM-READ-SEC
           IF          FLG-PTNUM       =   1
               MOVE    5               TO  FLG-ERR
               GO  TO  250-PTHKNINF-SET-EXT
           END-IF
      *    患者情報読み込み
           PERFORM 900-PTINF-READ-SEC
           IF          FLG-PTINF       NOT =   ZERO
               MOVE    6               TO  FLG-ERR
               GO  TO  250-PTHKNINF-SET-EXT
           END-IF
      *
      *    レコード番号が大きかったら最大値をセット
           IF      WRK-HKNID       <   PTHKN-HKNID
               MOVE    PTHKN-HKNID     TO  WRK-HKNID
           END-IF
      *
           MOVE    SPA-HOSPID      TO  PTHKN-HOSPID
           MOVE    PTNUM-PTID      TO  PTHKN-PTID
           MOVE    SPA-TERMID      TO  PTHKN-TERMID
      *    前期高齢者チェック
           PERFORM 250-OLDFTNKBN-HEN-SEC
           IF  FLG-ERR             NOT =   ZERO
               GO  TO  250-PTHKNINF-SET-EXT
           END-IF
      *
      *    補助区分再セット
           PERFORM 250-HOJYOKBN-HEN-SEC
      *
      *    患者番号変換マスタ更新処理
           PERFORM 260-PTNUM-UPDATE-SEC
           IF  FLG-ERR             NOT =   ZERO
               GO  TO  250-PTHKNINF-SET-EXT
           END-IF
      *    患者保険マスタ　更新処理
           PERFORM 260-PTHKNINF-INSERT-SEC
           IF  FLG-ERR             NOT =   ZERO
               GO  TO  250-PTHKNINF-SET-EXT
           END-IF
      *
           .
       250-PTHKNINF-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険情報分割登録処理
      *****************************************************************
       250-PTHKNINF-BUNKATU-SET-SEC    SECTION.
      *
           CLOSE                       ISAM-FILE
      *
           OPEN    INPUT               ISAM-FILE
      *
           MOVE    ZERO                TO  WRK-PTID
      *
           INITIALIZE                  ISAM-REC
           PERFORM 900-ISAM-NEXT-SEC
      *
      *    ISAMファイルがなくなるまで
           PERFORM UNTIL ( FLG-ISAM    =   1 )
      *        患者が変わったら最大連番取得
               IF      WRK-PTID        NOT =   ISAM-PTID
                   MOVE    ISAM-PTID       TO  WRK-PTID
                   MOVE    ZERO            TO  WRK-HKNID
                   INITIALIZE                  PTHKN-REC
                   MOVE    SPA-HOSPID      TO  PTHKN-HOSPID
                   MOVE    ISAM-PTID       TO  PTHKN-PTID
                   MOVE    PTHKN-REC       TO  MCPDATA-REC
                   MOVE    "PTHKNINF-KEY2" TO  WRK-DBPATH
                   PERFORM 900-PTHKNINF-SELECT-SEC
                   PERFORM UNTIL (FLG-PTHKNINF   =   1)
                       MOVE    MCPDATA-REC     TO  PTHKN-REC
      *               レコード番号が大きかったら最大値をセット
                       IF      WRK-HKNID       <   PTHKN-HKNID
                           MOVE    PTHKN-HKNID     TO  WRK-HKNID
                       END-IF
                       PERFORM 900-PTHKNINF-FETCH-SEC
                   END-PERFORM
                   PERFORM 900-PTHKNINF-CLOSE-SEC
               END-IF
      *
      *        患者保険情報に再セット
               INITIALIZE                  PTHKN-REC
               MOVE    SPA-HOSPID      TO  PTHKN-HOSPID
               MOVE    ISAM-PTID       TO  PTHKN-PTID
               ADD     1               TO  WRK-HKNID
               IF      WRK-HKNID   <   10
                   MOVE    WRK-HKNID       TO  WRK-NUM1
                   MOVE    WRK-NUM1        TO  PTHKN-HKNID
               ELSE
                   MOVE    WRK-HKNID       TO  WRK-NUM2
                   MOVE    WRK-NUM2        TO  PTHKN-HKNID
               END-IF
               MOVE    ISAM-HKNNUM     TO  PTHKN-HKNNUM
               MOVE    ISAM-FTNKBN     TO  WRK-HEN-FTNKBN
               MOVE    ISAM-HKNJANUM   TO  PTHKN-HKNJANUM
               MOVE    ISAM-HONKZKKBN  TO  PTHKN-HONKZKKBN
               MOVE    ISAM-HOJOKBN    TO  WRK-HEN-HOJOKBN
               MOVE    ISAM-CONTKBN    TO  PTHKN-CONTKBN
               MOVE    ISAM-KIGO       TO  PTHKN-KIGO
               MOVE    ISAM-NUM        TO  PTHKN-NUM
               MOVE    ISAM-HIHKNJANAME    TO  PTHKN-HIHKNJANAME
               MOVE    ISAM-GAIFTN     TO  WRK-HEN-GAIFTN
               MOVE    ISAM-NYUFTN     TO  WRK-HEN-NYUFTN
               MOVE    ISAM-TEKSTYMD   TO  WRK-HEN-TEKSTYMD
               MOVE    ISAM-TEKEDYMD   TO  WRK-HEN-TEKEDYMD
               MOVE    ISAM-KAKUNINYMD TO  PTHKN-KAKUNINYMD
               MOVE    ISAM-CREYMD     TO  PTHKN-CREYMD
               MOVE    ISAM-UPYMD      TO  PTHKN-UPYMD
               MOVE    ISAM-PTNUM      TO  SPA-PTNUM
               MOVE    SPA-TERMID      TO  PTHKN-TERMID
      *
      *        補助区分再セット
               MOVE    1               TO  FLG-ROUJIN
               PERFORM 250-HOJYOKBN-HEN-SEC
      *        患者番号変換マスタ更新処理
               PERFORM 260-PTNUM-UPDATE-SEC
               IF  FLG-ERR             NOT =   ZERO
                   GO  TO  250-PTHKNINF-BUNKATU-SET-EXT
               END-IF
      *        患者保険マスタ　更新処理
               PERFORM 260-PTHKNINF-INSERT-SEC
               IF  FLG-ERR             NOT =   ZERO
                   GO  TO  250-PTHKNINF-BUNKATU-SET-EXT
               END-IF
               PERFORM 900-ISAM-NEXT-SEC
           END-PERFORM
      *
           CLOSE                       ISAM-FILE
      *
      *    ISAMファイルクリア
           OPEN    OUTPUT              ISAM-FILE
           CLOSE                       ISAM-FILE
      *
      *    ISAMファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    ASS-ISAM        TO  IF-FILENAME
           CALL    "orcfiledel"        USING
                                       ORCSFDELAREA
      *
           .
       250-PTHKNINF-BUNKATU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    前期高齢者負担区分再セット処理
      *****************************************************************
       250-OLDFTNKBN-HEN-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-ROUJIN
      *
      *    老人は対象外
           IF      PTINF-BIRTHDAY  <=   "19320930"
               GO  TO  250-OLDFTNKBN-HEN-EXT
           END-IF
      *
      *    生年月日から７０歳到達日を求める
      *    １日ならば生年月日、１日以外ならば生年月日の翌月１日
           MOVE    ZERO                TO  WRK-BASEYMD
           MOVE    ZERO                TO  WRK-BYMD-70
           MOVE    PTINF-BIRTHDAY      TO  WRK-BASEYMD
           IF          WRK-BDD         NOT =   01
               COMPUTE WRK-BMM         =   WRK-BMM     +   1
               IF      WRK-BMM         >   12
                   COMPUTE WRK-BYY     =   WRK-BYY     +   1
                   MOVE    01              TO  WRK-BMM
               END-IF
               MOVE    01              TO  WRK-BDD
           END-IF
      *    ７０歳を迎える日
           MOVE    WRK-BASEYMD         TO  WRK-BYMD-70
           COMPUTE WRK-B70-YY          =   WRK-B70-YY  +   70
      *
      *    前期高齢者でないときは処理抜ける
           IF     (PTINF-BIRTHDAY      >   "19320930" ) AND
                  (WRK-BYMD-70         <=  WRK-SYSYMD ) AND
                  (WRK-HEN-TEKEDYMD    >=  WRK-SYSYMD )
      *        前期高齢者で負担区分が0なら負担区分に１をセット
               IF     (WRK-HEN-FTNKBN      =   "0" )
                   MOVE    "1"             TO  WRK-HEN-FTNKBN
               END-IF
               MOVE    1                   TO  FLG-ROUJIN
           ELSE
               GO  TO  250-OLDFTNKBN-HEN-EXT
           END-IF
      *
      *    ７０歳になる日が期間をまたがるときはレコードを分ける
           IF    ( WRK-HEN-TEKSTYMD    <=  WRK-BYMD-70 ) AND
                 ( WRK-HEN-TEKEDYMD    >=  WRK-BYMD-70 ) AND
                 ( WRK-HEN-TEKEDYMD    >=  "20021001"  )
      *        補助区分等セット
               PERFORM 250-OLDPTHKNINF-SET-SEC
           END-IF
      *
           .
       250-OLDFTNKBN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    前期高齢者負担区分再セット処理
      *****************************************************************
       250-OLDPTHKNINF-SET-SEC     SECTION.
      *
           MOVE    ZERO            TO  FLG-ISAM
           MOVE    ZERO            TO  IDI
      *
           PERFORM UNTIL   FLG-ISAM    NOT =   ZERO
               ADD     1               TO  IDI
               INITIALIZE                  ISAM-REC
               MOVE    PTNUM-PTID      TO  ISAM-PTID
               MOVE    IDI             TO  ISAM-HKNID
      *        存在チェック
               PERFORM 900-ISAM-READ-SEC
           END-PERFORM
      *
           ADD     1                   TO  CNT-ISAM
      *    分割レコードに追加
           INITIALIZE                      ISAM-REC
           MOVE    PTHKN-PTID          TO  ISAM-PTID
           MOVE    IDI                 TO  ISAM-HKNID
           MOVE    SPA-PTNUM           TO  ISAM-PTNUM
           MOVE    PTHKN-HKNNUM        TO  ISAM-HKNNUM
     ***** MOVE    "0"                 TO  ISAM-FTNKBN
           MOVE    WRK-HEN-FTNKBN      TO  ISAM-FTNKBN
           MOVE    PTHKN-HKNJANUM      TO  ISAM-HKNJANUM
           MOVE    PTHKN-HONKZKKBN     TO  ISAM-HONKZKKBN
           MOVE    WRK-HEN-HOJOKBN     TO  ISAM-HOJOKBN
           MOVE    PTHKN-CONTKBN       TO  ISAM-CONTKBN
           MOVE    PTHKN-KIGO          TO  ISAM-KIGO
           MOVE    PTHKN-NUM           TO  ISAM-NUM
           MOVE    PTHKN-HIHKNJANAME   TO  ISAM-HIHKNJANAME
           MOVE    WRK-HEN-GAIFTN      TO  ISAM-GAIFTN
           MOVE    WRK-HEN-NYUFTN      TO  ISAM-NYUFTN
      *
           MOVE    WRK-BYMD-70         TO  ISAM-TEKSTYMD
           MOVE    WRK-HEN-TEKEDYMD    TO  ISAM-TEKEDYMD
      *
           MOVE    PTHKN-KAKUNINYMD    TO  ISAM-KAKUNINYMD
           MOVE    PTHKN-CREYMD        TO  ISAM-CREYMD
           MOVE    PTHKN-UPYMD         TO  ISAM-UPYMD
           WRITE   ISAM-REC
      *
      *    ７０歳を迎える日から適用開始日を求める
           MOVE    ZERO                TO  WRK-BASEYMD
           MOVE    WRK-BYMD-70     TO  WRK-BASEYMD
           COMPUTE WRK-BMM         =   WRK-BMM     -   1
           IF          WRK-BMM     <   1
               COMPUTE WRK-BYY     =   WRK-BYY     -   1
               MOVE    12              TO  WRK-BMM
           END-IF
           MOVE    01              TO  WRK-BDD
      *
      *    月末取得
           MOVE    WRK-BASEYMD     TO  WRK-SYMD
           PERFORM 20021-GETSUMASTU-GET-SEC
           MOVE    WRK-SYMD        TO  WRK-HEN-TEKEDYMD
           MOVE    ZERO                TO  FLG-ROUJIN
           .
       250-OLDPTHKNINF-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    前期高齢者分補助区分再セット処理
      *****************************************************************
       250-HOJYOKBN-HEN-SEC        SECTION.
      *
           MOVE    WRK-HEN-HOJOKBN     TO  PTHKN-HOJOKBN
           MOVE    WRK-HEN-TEKSTYMD    TO  PTHKN-TEKSTYMD
           MOVE    WRK-HEN-TEKEDYMD    TO  PTHKN-TEKEDYMD
      *
      *    自費の場合処理抜ける
           IF          PTHKN-HKNNUM    =   "980"
               GO  TO  250-HOJYOKBN-HEN-EXT
           END-IF
      *
      *    前期高齢者以外
           IF      FLG-ROUJIN          =   ZERO
               MOVE    SPACE           TO  WRK-HEN-FTNKBN2
           ELSE
               MOVE    WRK-HEN-FTNKBN  TO  WRK-HEN-FTNKBN2
           END-IF
      *
           EVALUATE    PTHKN-HKNNUM
      *    船員
           WHEN    "002"
               EVALUATE  WRK-HEN-FTNKBN2   ALSO    WRK-HEN-HOJOKBN
      *        負担割合１
               WHEN        "1"     ALSO    SPACE
               WHEN        "1"     ALSO    "0"
                   MOVE    "9"             TO  PTHKN-HOJOKBN
               WHEN        "1"     ALSO    "1"
                   MOVE    "A"             TO  PTHKN-HOJOKBN
               WHEN        "1"     ALSO    "2"
                   MOVE    "B"             TO  PTHKN-HOJOKBN
               WHEN        "1"     ALSO    "3"
                   MOVE    "C"             TO  PTHKN-HOJOKBN
      *        負担割合２
               WHEN        "2"     ALSO    SPACE
               WHEN        "2"     ALSO    "0"
                   MOVE    "8"             TO  PTHKN-HOJOKBN
               WHEN        "2"     ALSO    "1"
                   MOVE    "D"             TO  PTHKN-HOJOKBN
               WHEN        "2"     ALSO    "2"
                   MOVE    "E"             TO  PTHKN-HOJOKBN
               WHEN        "2"     ALSO    "3"
                   MOVE    "F"             TO  PTHKN-HOJOKBN
               END-EVALUATE
      *    共済
           WHEN    "031"   THRU    "034"
               EVALUATE    WRK-HEN-FTNKBN2 ALSO    WRK-HEN-HOJOKBN
               WHEN        "1"     ALSO    "2"
                   MOVE    "B"             TO  PTHKN-HOJOKBN
               WHEN        "2"     ALSO    "2"
                   MOVE    "E"             TO  PTHKN-HOJOKBN
               END-EVALUATE
      *    国保
           WHEN    "060"
               IF    ( PTHKN-HKNJANUM(7:)      =   SPACE ) AND
                     ( PTHKN-HKNJANUM(3:1)     =   "3" )
                   EVALUATE    WRK-HEN-GAIFTN  ALSO  WRK-HEN-NYUFTN
                   WHEN    10      ALSO    0
                       MOVE    "4"             TO  PTHKN-HOJOKBN
                   WHEN    20      ALSO    10
                       IF      WRK-HEN-FTNKBN2     NOT =   "1"
                           MOVE    "5"         TO  PTHKN-HOJOKBN
                       END-IF
                   WHEN    30      ALSO    20
                       IF        ( WRK-HEN-FTNKBN2     NOT =   "2" )
                           AND   ( WRK-HEN-FTNKBN2     NOT =   "1" )
                           MOVE    "6"         TO  PTHKN-HOJOKBN
                       END-IF
                   END-EVALUATE
               ELSE
                   EVALUATE    WRK-HEN-FTNKBN2
      *            負担割合１
                   WHEN        "1"
                       MOVE    "1"             TO  PTHKN-HOJOKBN
      *            負担割合２
                   WHEN        "2"
                       MOVE    "2"             TO  PTHKN-HOJOKBN
                   END-EVALUATE
               END-IF
      *
           WHEN    OTHER
      *    通常の場合
               EVALUATE    WRK-HEN-FTNKBN2
      *        負担割合１
               WHEN        "1"
                   MOVE    "9"             TO  PTHKN-HOJOKBN
      *        負担割合２
               WHEN        "2"
                   MOVE    "8"             TO  PTHKN-HOJOKBN
               END-EVALUATE
           END-EVALUATE
      *
           .
       250-HOJYOKBN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号変換マスタ　更新処理
      *****************************************************************
       260-PTNUM-UPDATE-SEC        SECTION.
      *
      *    最大保険ＩＤで患者番号変換マスタを更新
           IF  PTNUM-HKNID         <   PTHKN-HKNID
               MOVE    PTHKN-HKNID     TO  PTNUM-HKNID
               MOVE    SPA-SYSYMD      TO  PTNUM-UPYMD
               MOVE    PTNUM-REC       TO  MCPDATA-REC
               MOVE    "DBUPDATE"      TO  MCP-FUNC
               MOVE    "PTNUM-KEY2"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"  USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF          MCP-RC      NOT =   ZERO
                   MOVE    7               TO  FLG-ERR
                   GO  TO  260-PTNUM-UPDATE-EXT
               END-IF
           END-IF
      *
           .
       260-PTNUM-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険マスタ　登録処理
      *****************************************************************
       260-PTHKNINF-INSERT-SEC     SECTION.
      *
      *    存在チェック
           PERFORM 900-PTHKNINF-READ-SEC
           IF      FLG-PTHKNINF    =   ZERO
               MOVE    8              TO  FLG-ERR
               GO  TO  260-PTHKNINF-INSERT-EXT
           END-IF
      *
           MOVE    PTHKN-REC       TO  MCPDATA-REC
           MOVE    "DBINSERT"      TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF           MCP-RC     NOT =   ZERO
               MOVE    8              TO  FLG-ERR
               GO  TO  260-PTHKNINF-INSERT-EXT
           END-IF
           ADD     1              TO  CNT-PTHKNINF
      *
           .
       260-PTHKNINF-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集処理
      *****************************************************************
       270-ERRREC-EDIT-SEC         SECTION.
      *
           IF          FLG-ERR     <=  4
               ADD     1               TO  IDE
               IF          IDE         >   4
                   GO  TO  270-ERRREC-EDIT-EXT
               END-IF
               IF          IDE         =   1
                   ADD     1               TO  CNT-ERR
                   MOVE    SPACE           TO  ERR-REC1
                   MOVE    CNT-CSV         TO  ERR1-LINENO
                   MOVE    "ERR"           TO  ERR1-NAIYO
               END-IF
           END-IF
      *
           EVALUATE    FLG-ERR
      *    必須項目未入力エラー
           WHEN    1
      *    項目桁数エラー
           WHEN    2
      *    誤入力エラー
           WHEN    3
               PERFORM 2910-ERRREC-EDIT-BETU1-SEC
      *    患者番号取得エラー
           WHEN    5
      *    患者情報取得エラー
           WHEN    6
      *    患者番号更新エラー
           WHEN    7
      *    患者保険出力エラー
           WHEN    8
      *    労災読み飛ばしエラー
           WHEN    9
               PERFORM 2910-ERRREC-EDIT-BETU2-SEC
           END-EVALUATE
      *
           .
       270-ERRREC-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集　別１　処理
      *****************************************************************
       2910-ERRREC-EDIT-BETU1-SEC  SECTION.
      *
      *    エラー内容番号転送
           MOVE    "["             TO  ERR1-ERRNO (IDE)(1:1)
           MOVE    FLG-ERR (1:1)   TO  ERR1-ERRNO (IDE)(2:1)
           MOVE    "]"             TO  ERR1-ERRNO (IDE)(3:1)
      *
      *    エラー項目名称転送
           EVALUATE    WRK-KOUMOKU-NO
      *    １：患者番号
           WHEN    1
               MOVE    "患者番号:"     TO  ERR1-KOMOKU(IDE)
      *    ２：レコード番号（保険番号）
           WHEN    2
               MOVE    "レコ番  :"     TO  ERR1-KOMOKU(IDE)
      *    ３：法別番号
           WHEN    3
               MOVE    "法別番号:"     TO  ERR1-KOMOKU(IDE)
      *    ４：負担区分
           WHEN    4
               MOVE    "負担区分:"     TO  ERR1-KOMOKU(IDE)
      *    ５：保険者番号
           WHEN    5
               MOVE    "保険者番:"     TO  ERR1-KOMOKU(IDE)
      *    ６：本人家族区分
           WHEN    6
               MOVE    "本家区分:"     TO  ERR1-KOMOKU(IDE)
      *    ７：補助区分
           WHEN    7
               MOVE    "補助区分:"     TO  ERR1-KOMOKU(IDE)
      *    ８：継続区分
           WHEN    8
               MOVE    "継続区分:"     TO  ERR1-KOMOKU(IDE)
      *    ９：記号
           WHEN    9
               MOVE    "記号    :"     TO  ERR1-KOMOKU(IDE)
      *    １０：番号
           WHEN    10
               MOVE    "番号    :"     TO  ERR1-KOMOKU(IDE)
      *    １１：被保険者氏名
           WHEN    11
               MOVE    "被保険者:"     TO  ERR1-KOMOKU(IDE)
      *    １２：外来負担率（％）
           WHEN    12
               MOVE    "外来負担:"     TO  ERR1-KOMOKU(IDE)
      *    １３：入院負担率（％）
           WHEN    13
               MOVE    "入院負担:"     TO  ERR1-KOMOKU(IDE)
      *    １４：適用開始日
           WHEN    14
               MOVE    "適用開始:"     TO  ERR1-KOMOKU(IDE)
      *    １５：適用終了日
           WHEN    15
               MOVE    "適用終了:"     TO  ERR1-KOMOKU(IDE)
      *    １６：保険確認日
           WHEN    16
               MOVE    "保険確認:"     TO  ERR1-KOMOKU(IDE)
      *    １７：登録日
           WHEN    17
               MOVE    "登録日  :"     TO  ERR1-KOMOKU(IDE)
      *    １８：更新日
           WHEN    18
               MOVE    "更新日  :"     TO  ERR1-KOMOKU(IDE)
      *    フォーマットエラー
           WHEN    OTHER
               MOVE    "過多項目:"     TO  ERR1-KOMOKU(IDE)
           END-EVALUATE
      *
      *    エラー値転送
           IF          WRK-MO-CNT      NOT =   ZERO
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  ERR1-ATAI(IDE)(1:8)
           END-IF
      *
           .
       2910-ERRREC-EDIT-BETU1-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集　別２　処理
      *****************************************************************
       2910-ERRREC-EDIT-BETU2-SEC  SECTION.
      *
           ADD     1               TO  CNT-ERR
           MOVE    SPACE           TO  ERR-REC2
           MOVE    CNT-CSV         TO  ERR2-LINENO
           MOVE    "["             TO  ERR2-ERRNO (1:1)
           MOVE    FLG-ERR(1:1)    TO  ERR2-ERRNO (2:1)
           MOVE    "]"             TO  ERR2-ERRNO (3:1)
           MOVE    "患者番号:"     TO  ERR2-PTNUMMES
           MOVE    "患者ＩＤ:"     TO  ERR2-PTIDMES
           MOVE    "保険番号:"     TO  ERR2-HKNNUMMES
           MOVE    "連番:"         TO  ERR2-HKNIDMES
           MOVE    "期間:"         TO  ERR2-TEKSTEDMES
      *
           MOVE    SPA-PTNUM       TO  ERR2-PTNUM
           MOVE    PTHKN-PTID      TO  ERR2-PTID
      *
           IF      PTHKN-HKNNUM    NOT =   SPACE
               MOVE    PTHKN-HKNNUM    TO  ERR2-HKNNUM
               IF      PTHKN-HKNID     <   10
                   MOVE    PTHKN-HKNID     TO  WRK-NUM1
                   MOVE    WRK-NUM1        TO  ERR2-HKNID
               ELSE
                   MOVE    PTHKN-HKNID     TO  WRK-NUM2
                   MOVE    WRK-NUM2        TO  ERR2-HKNID
               END-IF
           END-IF
      *
           IF    ( WRK-HEN-TEKSTYMD    NOT =   SPACE ) AND
                 ( WRK-HEN-TEKEDYMD    NOT =   SPACE )
               MOVE    WRK-HEN-TEKSTYMD    TO  ERR2-TEKSTYMD
               MOVE    WRK-HEN-TEKEDYMD    TO  ERR2-TEKEDYMD
               MOVE    "-"                 TO  ERR2-TEKBAR
           END-IF
      *
           IF      FLG-ERR         =   9
               MOVE    "MSG"           TO  ERR2-NAIYO
           ELSE
               MOVE    "ERR"           TO  ERR2-NAIYO
           END-IF
      *
           .
       2910-ERRREC-EDIT-BETU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト出力処理
      *****************************************************************
       270-ERRLST-OUT-SEC          SECTION.
      *
           IF          FLG-ERRARI      =   1
               MOVE    ERR-REC1        TO      ERR-REC
               WRITE   ERR-REC
           ELSE
               MOVE    ERR-REC2        TO      ERR-REC
               WRITE   ERR-REC
           END-IF
      *
           .
       270-ERRLST-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票出力　初期処理
      *****************************************************************
       2710-ERRLST-INIT-SEC        SECTION.
      *
           OPEN    OUTPUT              ERR-FILE
           IF      STS-LST         NOT =   ZERO
               MOVE    1               TO  FLG-CSV
               DISPLAY "*(ORCVTPTHKNINF)* ERRFILE OPN STS[" STS-LST "]"
               GO  TO  2710-ERRLST-INIT-EXT
           END-IF
      *
           MOVE    MES-TITLE1      TO      ERR-REC
           WRITE   ERR-REC
           MOVE    MES-TITLE2-L1   TO      ERR-REC
           WRITE   ERR-REC
           MOVE    MES-TITLE2-L2   TO      ERR-REC
           WRITE   ERR-REC
           MOVE    MES-TITLE2-L3   TO      ERR-REC
           WRITE   ERR-REC
           MOVE    MES-TITLE2-L4   TO      ERR-REC
           WRITE   ERR-REC
      *
           .
       2710-ERRLST-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック処理
      *****************************************************************
       31012-SEIWA-HEN-SEC         SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY1-AREA
           MOVE    "11"            TO  LNK-DAY1-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY1-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY1-AREA
           IF      STS-DAY-RC1     =   ZERO
               MOVE    0               TO  FLG-YMD
           ELSE
               MOVE    1               TO  FLG-YMD
           END-IF
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    月末取得処理
      *****************************************************************
       20021-GETSUMASTU-GET-SEC    SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY7-AREA
           MOVE    "71"                TO  LNK-DAY7-IRAI
           MOVE    WRK-SYMD(1:6)       TO  LNK-DAY7-YM
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI TO  WRK-SYMD
      *
           .
       20021-GETSUMASTU-GET-EXT.
            EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    帳票出力　終了処理
           CLOSE                       CSV-FILE
           CLOSE                       ERR-FILE
      *
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
      *
           DISPLAY "*(ORCVTPTHKNINF)* CSV     /I CNT[" CNT-CSV      "]"
           DISPLAY "*(ORCVTPTHKNINF)* PTHKNINF/O CNT[" CNT-PTHKNINF "]"
           DISPLAY "*(ORCVTPTHKNINF)* ERR     /O CNT[" CNT-ERR      "]"
           DISPLAY "*(ORCVTPTHKNINF)* ISAM    /O CNT[" CNT-ISAM     "]"
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタＦＥＴＣＨ処理
      *****************************************************************
       900-SYSTEM-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC          =   ZERO
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
      *    患者番号変換マスタ　読み込み処理
      *****************************************************************
       900-PTNUM-READ-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-PTNUM
           MOVE    SPACE           TO  PTNUM-REC
           INITIALIZE                  PTNUM-REC
           MOVE    SPA-HOSPID      TO  PTNUM-HOSPID
           MOVE    SPA-PTNUM       TO  PTNUM-PTNUM
           MOVE    PTNUM-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "PTNUM-KEY2"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF          MCP-RC          =   ZERO
               MOVE    "PTNUM-KEY2"    TO  ORC-DBPATH
               MOVE    "DBFETCH"       TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF          MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC     TO  PTNUM-REC
                   MOVE    ZERO            TO  FLG-PTNUM
               ELSE
                   INITIALIZE                  PTNUM-REC
                   MOVE    1               TO  FLG-PTNUM
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTNUM
           END-IF
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "PTNUM-KEY2"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PTNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報マスタ読込
      *****************************************************************
       900-PTINF-READ-SEC          SECTION.
      *
           MOVE    SPACE           TO  PTINF-REC
           INITIALIZE                  PTINF-REC
           MOVE    SPA-HOSPID      TO  PTINF-HOSPID
           MOVE    PTNUM-PTID      TO  PTINF-PTID
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "PTINF-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC          =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "PTINF-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF          MCP-RC          =   ZERO
                   MOVE    ZERO            TO  FLG-PTINF
                   MOVE    MCPDATA-REC     TO  PTINF-REC
               ELSE
                   MOVE    1               TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "PTINF-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険マスタ読込
      *****************************************************************
       900-PTHKNINF-READ-SEC       SECTION.
      *
           MOVE    PTHKN-REC       TO  MCPDATA-REC
           MOVE    "PTHKNINF-KEY"  TO  WRK-DBPATH
           PERFORM 900-PTHKNINF-SELECT-SEC
           PERFORM 900-PTHKNINF-CLOSE-SEC
      *
           .
       900-PTHKNINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険マスタ読込
      *****************************************************************
       900-PTHKNINF-SELECT-SEC     SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC          =   ZERO
               PERFORM 900-PTHKNINF-FETCH-SEC
           ELSE
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
      *
           .
       900-PTHKNINF-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険マスタ読込
      *****************************************************************
       900-PTHKNINF-FETCH-SEC      SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC          =   ZERO
               MOVE    ZERO            TO  FLG-PTHKNINF
           ELSE
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
      *
           .
       900-PTHKNINF-FETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険マスタ読込
      *****************************************************************
       900-PTHKNINF-CLOSE-SEC      SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PTHKNINF-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険ＣＳＶファイル　検索処理
      *****************************************************************
       900-CSV-KENSAKU-SEC         SECTION.
      *
          MOVE    SPACE            TO  CSV-R
      *
          READ    CSV-FILE
              AT  END
                  MOVE    1            TO  FLG-CSV
              NOT AT  END
                  MOVE    ZERO         TO  FLG-CSV
                  ADD     1            TO  CNT-CSV
                  ADD     1            TO  CNT-COMMIT
          END-READ
      *
          .
       900-CSV-KENSAKU-EXT.
          EXIT.
      *
      *****************************************************************
      *    パラメータファイル読み込み処理
      *****************************************************************
       900-PARA-READ-SEC           SECTION.
      *
          MOVE    SPACE            TO  PARA-REC
      *
          READ    PARA-FILE
              AT  END
                  MOVE    1            TO  FLG-PARA
              NOT AT  END
                  ADD     1            TO  CNT-PARA
          END-READ
      *
          .
       900-PARA-READ-EXT.
          EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC      NOT =   ZERO
               DISPLAY "DBOPEN ERROR"
           END-IF
      *
           MOVE    "DBSTART"        TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF          MCP-RC       NOT =   ZERO
               DISPLAY "DBSTART ERROR"
           END-IF
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    分割レコードファイル読込
      *****************************************************************
       900-ISAM-READ-SEC           SECTION.
      *
           READ    ISAM-FILE
               INVALID
                   MOVE    1           TO  FLG-ISAM
               NOT INVALID
                   MOVE    ZERO        TO  FLG-ISAM
           END-READ
           .
       900-ISAM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    分割レコードファイル順読込
      *****************************************************************
       900-ISAM-NEXT-SEC           SECTION.
      *
           READ    ISAM-FILE       NEXT
               AT  END
                   MOVE    1           TO  FLG-ISAM
               NOT AT  END
                   MOVE    ZERO        TO  FLG-ISAM
           END-READ
           .
       900-ISAM-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　ＣＯＭＭＩＴ処理
      *****************************************************************
       900-DBCOMMIT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    "DBSTART"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-DBCOMMIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC      NOT =   ZERO
               DISPLAY "DBCOMMIT ERROR"
           END-IF
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC      NOT =   ZERO
               DISPLAY "DBDISCONNECT ERROR"
           END-IF
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
