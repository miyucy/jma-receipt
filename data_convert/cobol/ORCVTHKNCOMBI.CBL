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
       PROGRAM-ID.                 ORCVTHKNCOMBI.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＤＢ作成処理
      *  コンポーネント名  : 保険組合せ作成処理
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/04/11    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-伊藤     01/12/12  ＤＢコールインターフェイス
      *                                     の変更  
      *  01.00.02    NACL-多々納  02/09/19  パラメタＦをＤＢパラメタへ変更
      *                                     Ｈ１４．１０改正対応
      *  01.00.03    NACL-多々納  02/11/29  前期高齢者対応
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメータファイル
           SELECT  PARM-FILE       ASSIGN
                                   "/home/orca/ORCADC.PARA"
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-PARM.
      *
      *    パラメタデータ
      *    SELECT  PARA-FILE       ASSIGN  "/var/tmp/P01PARAORCATERM"
      *                            ORGANIZATION    IS  INDEXED
      *                            ACCESS  MODE    IS  DYNAMIC
      *                            RECORD  KEY     IS  PAR-KEY
      *                            FILE    STATUS  IS  STS-PARA.
      *　　入力組合せデータ
      *    SELECT  NC01PARA-FILE   ASSIGN  "/var/tmp/NC01PARAORCATERM"
      *                            ORGANIZATION    IS  INDEXED
      *                            ACCESS  MODE    IS  DYNAMIC
      *                            RECORD  KEY     IS  PARA-NC01-KEY
      ***                          FILE    STATUS  IS  STS-PARA.
      *    出力エラーファイル
           SELECT  ERR-FILE        ASSIGN
                                   ASS-ERR
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-LST.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *    パラメータファイル
       FD  PARM-FILE.
       01  PARM-REC.
           03  PARM-RECKBN             PIC X(01).
           03  PARM-DATKBN             PIC X(04).
           03  FILLER                  PIC X(01).
           03  PARM-DATA               PIC X(100).
      *
      *    パラメタデータ
      *FD  PARA-FILE.
      *01  PARA-REC.
      *    03  PAR-KEY.
      *        05  PAR-FILEMEI         PIC X(08).
      *        05  PAR-EDANUM          PIC 9(04).
      *    03  PAR-DATA-REC            PIC X(3000).
      *
      *    新組合せパラメタデータ
      *FD  NC01PARA-FILE.
      *01  NC01PARA-REC.
      *    03  PARA-NC01-KEY.
      *        05  PARA-NC01-TERMID    PIC X(32).
      *        05  PARA-NC01-EDANUM    PIC 9(04).
      *    03  PARA-NC01-REC           PIC X(500).
      *    03  PARA-NC01-FLG           PIC 9(01).
      *
      *    出力エラーファイル
       FD  ERR-FILE.
       01  ERR-REC.
           03  ERR-REC1                PIC X(100).
           03  ERR-REC1-R  REDEFINES   ERR-REC1.
               05  ERR-NO              PIC X(05).
               05  FILLER              PIC X(01).
               05  ERR-MES             PIC X(50).
               05  FILLER              PIC X(01).
               05  ERR-HKNNUM          PIC X(03).
               05  FILLER              PIC X(03).
               05  ERR-PTID            PIC X(10).
               05  FILLER              PIC X(03).
               05  ERR-MCPRC           PIC X(06).
               05  FILLER              PIC X(03).
               05  ERR-ERRCD           PIC X(12).
               05  FILLER              PIC X(03).
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    ファイル指定領域
       01  ASS-AREA.
           03  ASS-ERR             PIC X(256).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARM            PIC X(02).
           03  STS-PARA            PIC X(02).
           03  STS-LST             PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PARM            PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-NC01PARA        PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-HKNCOOMBI       PIC 9(01).
           03  FLG-PTHKNINF        PIC 9(01).
           03  FLG-PTKOHINF        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PTNUM           PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-RJN             PIC 9(01).
           03  FLG-HKNKOH          PIC 9(01).
           03  FLG-ERR             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(03).
           03  CNT-PARM            PIC 9(06).
           03  CNT-PTINF           PIC 9(06).
           03  CNT-PTHKNINF        PIC 9(06).
           03  CNT-PTKOHINF        PIC 9(06).
           03  CNT-HKNCOMBI        PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *TEST ST
           03  WRK-SYMD2.
               05  WRK-SYY2        PIC 9(02).
               05  WRK-SMM2        PIC 9(02).
               05  WRK-SDD2        PIC 9(02).
      *TEST ED
      *
           03  WRK-KENSAKU-AREA.
               05  WRK-KEN-HKNNUM      PIC X(03).
               05  WRK-KEN-TEKSTYMD    PIC X(08).
               05  WRK-KEN-TEKEDYMD    PIC X(08).
               05  WRK-KEN-ERFLG       PIC X(01).
               05  WRK-KEN-SBTKBN      PIC X(01).
               05  WRK-KEN-HOJOKBN     PIC X(01).
               05  WRK-KEN-CONTKBN     PIC X(01).
               05  WRK-KEN-SEIDO       PIC X(10).
               05  WRK-KEN-HKNKOH      PIC 9(01).
               05  WRK-KEN-PAYKBN      PIC X(02).
      *    基準日
           03  WRK-BASEYMD.
               05  WRK-BYY             PIC 9(04).
               05  WRK-BMM             PIC 9(02).
               05  WRK-BDD             PIC 9(02).
           03  WRK-BYMD-70.
               05  WRK-B70-YY          PIC 9(04).
               05  WRK-B70-MM          PIC 9(02).
               05  WRK-B70-DD          PIC 9(02).
      *
           03  WRK-HKN-HKNKOHSBTKBN    PIC X(02).
           03  FLG-HENKOU              PIC 9(01).
      *
      *    新組合せパラメタデータ用レイアウト
       01  NC01PARA-REC.
           03  PARA-NC01-REC           PIC X(500).
           03  PARA-NC01-FLG           PIC 9(01).
      *
      *    スパ領域
       01  SPA-AREA2.
           03  SPA-HKNID               PIC 9(10).
           03  SPA-KOHID               PIC 9(10).
      *
      *    帳票出力領域
       01  MES-AREA.
           03  MES-TITLE1.
               05  FILLER              PIC X(26) VALUE
                                       "【PGID:ORCVTHKNCOMBI.CBL】".
               05  MES-TITLE1-YY       PIC X(04).
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-MM       PIC X(02).
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-DD       PIC X(02).
           03  MES-TITLE1-DATE         PIC X(10).
           03  MES-TITLE2.
               05  FILLER              PIC X(07) VALUE "   *** ".
               05  MES-TITLE2-NAME     PIC X(09).
               05  FILLER              PIC X(02) VALUE ": ".
               05  MES-TITLE2-ATAI     PIC X(10).
               05  FILLER              PIC X(04) VALUE " ***".
           03  MES-TITLE3.
               05  FILLER              PIC X(57) VALUE
                                                 "NO    ERR-MESSAGE".
               05  FILLER              PIC X(03) VALUE "HKN".
               05  FILLER              PIC X(03) VALUE SPACE.
      *         05  FILLER              PIC X(20) VALUE "PTNUM".
      *         05  FILLER              PIC X(01).
               05  FILLER              PIC X(10) VALUE "PTID".
               05  FILLER              PIC X(03) VALUE SPACE.
               05  FILLER              PIC X(06) VALUE "MCP-RC".
               05  FILLER              PIC X(03) VALUE SPACE.
               05  FILLER              PIC X(12) VALUE "ERRCD(P02W2)".
               05  FILLER              PIC X(03) VALUE SPACE.
      *
      *    メッセージ領域
       01  CONS-AREA.
           03  CONS-MES1               PIC X(50) VALUE
               "保険番号マスタ該当なし".
           03  CONS-MES2               PIC X(50) VALUE
               "患者保険マスタに公費が入っている".
           03  CONS-MES3               PIC X(50) VALUE
               "患者公費マスタに保険が入っている".
           03  CONS-MES4               PIC X(50) VALUE
               "保険・公費テーブルオーバー(P02W2)組合せ出力止め".
           03  CONS-MES5               PIC X(50) VALUE
               "保険番号マスタ該当なし    (P02W2)組合せ出力止め".
           03  CONS-MES6               PIC X(50) VALUE
               "患者番号変換マスタ読込エラー".
      *
       01  CONS1-AREA.
           03  CONS-CNTST              PIC 9(06) VALUE   0.
           03  CONS-CNTED              PIC 9(06) VALUE   000100.
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    システム管理（医療機関情報基本情報）
           COPY    "CPSK1001.INC".
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *    患者保険情報
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *    患者公費情報せ
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    パラメタ
       01  PARA-REC.
           COPY    "CPPARA.INC".
      *
      *    パラメタ
       01  WRK-PARA-REC.
           COPY    "CPPARA.INC"        REPLACING
                                       //PARA-// BY //WRK-PARA-//.
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
       PROCEDURE                       DIVISION.
      ****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-PTINF   =   1
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
      *
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      * 
           MOVE    ZERO            TO  FLG-AREA
           MOVE    ZERO            TO  CNT-AREA
           MOVE    ZERO            TO  IDX-AREA
           MOVE    ZERO            TO  SPA-AREA2
           INITIALIZE                  WRK-AREA
           INITIALIZE                  SPA-AREA
      *
      *    パラメータ情報取得
           PERFORM 101-PARM-GET-SEC
           IF  FLG-PARM            =   2
               MOVE    1           TO  FLG-PTINF
               GO      TO          100-INIT-EXT
           END-IF
      *
           ACCEPT  WRK-SYMD2       FROM    DATE
      *****MOVE    WRK-SYMD2       TO  WRK-SYMD (3:)
           MOVE    WRK-SYY2        TO  WRK-SYY
           MOVE    WRK-SMM2        TO  WRK-SMM
           MOVE    WRK-SDD2        TO  WRK-SDD
           ADD     2000            TO  WRK-SYY
           MOVE    WRK-SYMD        TO  SPA-SYSYMD
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
           PERFORM 110-CP1001-KENSAKU-SEC
           IF  FLG-PTINF           =   1
               GO  TO              100-INIT-EXT
           END-IF
      *
      *    帳票出力　初期処理
           PERFORM 120-LST-INIT-SEC
      *
      *    患者情報　検索処理
           PERFORM 900-PTINF-KENSAKU-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメータ情報取得
      *****************************************************************
       101-PARM-GET-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-PARM
           OPEN    INPUT           PARM-FILE
           IF      STS-PARM        NOT =   ZERO
               MOVE    2               TO  FLG-PARM
               DISPLAY "*(ORCVTHKNCOMBI)* PARM-FILE OPN STS["
                        STS-PARM "]"
               GO      TO          101-PARM-GET-EXT
           END-IF
      *
           PERFORM 900-PARM-READ-SEC
      *
           PERFORM UNTIL
                   FLG-PARM  =  1
      *
               IF  PARM-RECKBN         =   "@"
                   PERFORM 101-PARM-GET1-SEC
               END-IF
      *
               PERFORM  900-PARM-READ-SEC
           END-PERFORM
      *
           CLOSE   PARM-FILE
      *
      *    パラメータチェック処理
      *
           .
       101-PARM-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメータ情報取得（１）
      *****************************************************************
       101-PARM-GET1-SEC           SECTION.
      *
           EVALUATE                PARM-DATKBN
             WHEN  "02-4"
                   MOVE  PARM-DATA TO  ASS-ERR
           END-EVALUATE
      *
           .
       101-PARM-GET1-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理情報　検索処理
      *****************************************************************
       110-CP1001-KENSAKU-SEC          SECTION.
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
               MOVE    1                   TO  FLG-PTINF
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
       110-CP1001-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票出力　初期処理
      *****************************************************************
       120-LST-INIT-SEC                SECTION.
      *
           OPEN    OUTPUT              ERR-FILE
           IF  STS-LST             NOT =   ZERO
               MOVE    1               TO  FLG-PTINF
               DISPLAY "*(ORCVTHKNCOMBI)* ERRFILE OPN STS[" STS-LST "]"
               GO      TO              120-LST-INIT-EXT
           END-IF
      *
           MOVE    MES-TITLE1          TO  ERR-REC
           WRITE   ERR-REC
           MOVE    "HOSPID"            TO  MES-TITLE2-NAME
           MOVE    SPA-HOSPID(1:10)    TO  MES-TITLE2-ATAI
           MOVE    MES-TITLE2          TO  ERR-REC
           WRITE   ERR-REC
           MOVE    "HOSPSBT"           TO  MES-TITLE2-NAME
           MOVE    SPA-HOSPSBT         TO  MES-TITLE2-ATAI
           MOVE    MES-TITLE2          TO  ERR-REC
           WRITE   ERR-REC
           MOVE    "ROUPAYKBN"         TO  MES-TITLE2-NAME
           MOVE    SPA-ROUPAYKBN       TO  MES-TITLE2-ATAI
           MOVE    MES-TITLE2          TO  ERR-REC
           WRITE   ERR-REC
           MOVE    MES-TITLE3          TO  ERR-REC
           WRITE   ERR-REC
      *
           .
       120-LST-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報　検索処理
      *****************************************************************
       900-PTINF-KENSAKU-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PTINF
           MOVE    SPACE               TO  PTINF-REC
           INITIALIZE                      PTINF-REC
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTINF-KEY4"    TO  ORC-DBPATH
               PERFORM 910-PTINF-NEXT-SEC
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       900-PTINF-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           IF  CNT-PTINF (4:3)         =   ZERO
               DISPLAY "***(ORCVTHKNCOMBI)*** CNT-PTINF[" CNT-PTINF "]"
           END-IF
           IF   ( PTINF-PTID    NOT =   ALL "0"   AND
                  PTINF-PTID    NOT =   SPACE )
      *        作成処理
               PERFORM 200-SAKUSEI-SYORI-SEC
           END-IF
      *
           MOVE    "PTINF-KEY4"        TO  ORC-DBPATH
           PERFORM 910-PTINF-NEXT-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    作成処理
      *****************************************************************
       200-SAKUSEI-SYORI-SEC            SECTION.
      *
      *
           MOVE    PTINF-PTID          TO  SPA-PTID
           MOVE    ZERO                TO  IDX-AREA
           MOVE    ZERO                TO  SPA-AREA2
      *    ７０歳到達日
      *    生年月日から基準日を求める
      *    １日ならば生年月日、１日以外ならば生年月日の翌月１日
           MOVE    PTINF-BIRTHDAY      TO  WRK-BASEYMD
           IF      WRK-BDD         NOT =   01
               COMPUTE WRK-BMM         =   WRK-BMM     +   1
               IF      WRK-BMM         >   12
                   COMPUTE WRK-BYY     =   WRK-BYY     +   1
                   MOVE    01              TO  WRK-BMM
               END-IF
               MOVE    01                  TO  WRK-BDD
           END-IF
      *    ７０歳を迎える日
           MOVE    WRK-BASEYMD         TO  WRK-BYMD-70
           COMPUTE WRK-B70-YY          =   WRK-B70-YY  +   70
      *
      *    ファイルオープン処理
           PERFORM 210-PARA-OPEN-SEC
      *
      *    患者保険情報　検索処理
           PERFORM 220-PTHKNINF-KENSAKU-SEC
      *
      *    患者公費情報　検索処理
           PERFORM 230-PTKOHINF-KENSAKU-SEC
      *
      *    組合せ編集処理
           CALL    "ORCGP02W2" USING   SPA-AREA
           IF  SPA-ERRCD           NOT =   SPACE
      *        エラーリスト出力処理
               PERFORM 2220-ERRLST-OUT-SEC
               GO  TO                  200-SAKUSEI-SYORI-EXT
           END-IF
      *
      *    保険組合せ　登録処理
           PERFORM 240-HKNCOMBI-INSERT-SEC
      *
      *    患者番号変換マスタ　更新処理
           IF  IDZ                     >   ZERO
               PERFORM 250-PTNUM-UPDATE-SEC
           END-IF
      *
           .
       200-SAKUSEI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルオープン処理
      *****************************************************************
       210-PARA-OPEN-SEC              SECTION.
      *
      *    MOVE    ZERO               TO  FLG-PARA
      *    OPEN    I-O                PARA-FILE
      *    IF  STS-PARA           NOT =   ZERO
      *        MOVE    2              TO  FLG-PARA
      *        DISPLAY "*(ORCVTHKNCOMBI)* PARA OPN1-ERR STS["
      *                               STS-PARA "]"
      *    ELSE
      *        PERFORM 990-PARA-NEXT-SEC
      *    END-IF
      *
      *    対象PTID以外のデータを削除
      *    PERFORM   UNTIL  FLG-PARA  NOT =   ZERO
      *#         IF  PAR-TERMID             =   SPA-TERMID
      *            DELETE      PARA-FILE      RECORD
      *            IF  STS-PARA       NOT =   ZERO
      *                DISPLAY "*(ORCVTHKNCOMBI)* PARA DEL-ERR STS["
      *                                   STS-PARA "]"
      *            END-IF
      *#         END-IF
      *        PERFORM 990-PARA-NEXT-SEC
      *    END-PERFORM
      *    CLOSE                      PARA-FILE
      *    IF  STS-PARA           NOT =   ZERO
      *        DISPLAY "*(ORCVTHKNCOMBI)* PARA CLS1-ERR STS["
      *                               STS-PARA "]"
      *    END-IF
      *
      *    IF  FLG-PARA               =   2
      *        OPEN    OUTPUT         PARA-FILE
      *    ELSE
      *        OPEN    I-O            PARA-FILE
      *    END-IF
      *    IF  STS-PARA           NOT =   ZERO
      *        DISPLAY "*(ORCVTHKNCOMBI)* PARA OPN2-ERR STS["
      *                               STS-PARA "]"
      *****END-IF
      *
      *    パラメタ削除
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "PARA-DEL2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       210-PARA-OPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険情報　検索処理
      *****************************************************************
       220-PTHKNINF-KENSAKU-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-PTHKNINF
           MOVE    SPACE               TO  PTHKNINF-REC
           INITIALIZE                      PTHKNINF-REC
           MOVE    SPA-HOSPID          TO  PTHKN-HOSPID
           MOVE    SPA-PTID            TO  PTHKN-PTID
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTHKNINF-KEY2" TO  ORC-DBPATH
               PERFORM 920-PTHKNINF-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
      *
           PERFORM   UNTIL   FLG-PTHKNINF  =   1
               ADD     1                   TO  SPA-HKNID
               IF  PTHKN-SAKJOKBN          =   SPACE
                   INITIALIZE                  WRK-KENSAKU-AREA
                   MOVE    PTHKN-HKNNUM    TO  WRK-KEN-HKNNUM
                   MOVE    PTHKN-TEKSTYMD  TO  WRK-KEN-TEKSTYMD
                   MOVE    PTHKN-TEKEDYMD  TO  WRK-KEN-TEKEDYMD
                   MOVE    1               TO  WRK-KEN-HKNKOH
                   MOVE    ZERO            TO  WRK-KEN-PAYKBN
      *            保険確認処理
                   PERFORM 2210-HKNKOH-KAKUNIN-SEC
                   IF  WRK-KEN-ERFLG           =   SPACE
      *                前期高齢者の時、補助区分を再編集する
                       IF     (PTINF-BIRTHDAY      >   "19320930" ) AND
                              (WRK-BYMD-70         <=  WRK-SYMD   ) AND
                              (PTHKN-TEKEDYMD      >=  WRK-SYMD   )
                           PERFORM 2201-HOJOKBN-SET-SEC
                       END-IF
      *
                       ADD     1               TO  IDX
                       MOVE    SPACE               TO  PARA-REC
                       INITIALIZE                      PARA-REC
                       MOVE    "PTHKNINF"          TO  PARA-FILEMEI
                       MOVE    IDX                 TO  PARA-EDANUM
                       MOVE    PTHKNINF-REC        TO  PARA-DATA-REC
                       PERFORM 400-PARA-INSERT-SEC
      *********        INITIALIZE                  PARA-REC
      *#                 MOVE    SPA-TERMID      TO  PAR-TERMID
      *                MOVE    "PTHKNINF"      TO  PAR-FILEMEI
      *                MOVE    IDX             TO  PAR-EDANUM
      *                MOVE    PTHKNINF-REC    TO  PAR-DATA-REC
      *                WRITE                       PARA-REC
      *                IF  STS-PARA        NOT =   ZERO
      *              DISPLAY "*(ORCVTHKNCOMBI)* WRITE-HKN ERR STS["
      *                                        STS-PARA "]"
      **************** END-IF
                   ELSE
      *                エラーリスト出力処理
                       PERFORM 2220-ERRLST-OUT-SEC
                   END-IF
               END-IF
      *
               MOVE    "PTHKNINF-KEY2" TO  ORC-DBPATH
               PERFORM 920-PTHKNINF-NEXT-SEC
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
       220-PTHKNINF-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    前期高齢者の時、補助区分を再編集する処理
      *****************************************************************
       2201-HOJOKBN-SET-SEC        SECTION.
      *
      *    労災・自費・治験
           IF      WRK-HKN-HKNKOHSBTKBN    =   "4"  OR  "8"  OR  "9"
               GO      TO      2201-HOJOKBN-SET-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-HENKOU
           EVALUATE    PTHKN-HKNNUM
               WHEN    "002"
      *            船員
                   EVALUATE    PTHKN-HOJOKBN
                       WHEN    "1"
                           MOVE    "A"         TO  PTHKN-HOJOKBN
                           MOVE    1           TO  FLG-HENKOU
                       WHEN    "2"
                           MOVE    "B"         TO  PTHKN-HOJOKBN
                           MOVE    1           TO  FLG-HENKOU
                       WHEN    "3"
                           MOVE    "C"         TO  PTHKN-HOJOKBN
                           MOVE    1           TO  FLG-HENKOU
                       WHEN    OTHER
                           MOVE    "9"         TO  PTHKN-HOJOKBN
                           MOVE    1           TO  FLG-HENKOU
                   END-EVALUATE
               WHEN    "060"
      *            国保
                   EVALUATE    PTHKN-HOJOKBN
                       WHEN    "1"
                       WHEN    "2"
                           CONTINUE
                       WHEN    OTHER
                           MOVE    "1"         TO  PTHKN-HOJOKBN
                           MOVE    1           TO  FLG-HENKOU
                   END-EVALUATE
               WHEN    OTHER
      *            その他
                   MOVE    "9"             TO  PTHKN-HOJOKBN
                   MOVE    1               TO  FLG-HENKOU
           END-EVALUATE
           IF      FLG-HENKOU          =   1
      *        保険情報更新
               MOVE    PTHKNINF-REC        TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "*(ORCVTHKNCOMBI)*  PTHKNINF UPD ERR:" MCP-RC
                           ",KEY:" PTHKN-KEY
               END-IF
           END-IF
      *
           .
       2201-HOJOKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費情報　検索処理
      *****************************************************************
       230-PTKOHINF-KENSAKU-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-PTKOHINF
           MOVE    SPACE               TO  PTKOHINF-REC
           INITIALIZE                      PTKOHINF-REC
           MOVE    SPA-HOSPID          TO  PTKOH-HOSPID
           MOVE    SPA-PTID            TO  PTKOH-PTID
           MOVE    PTKOHINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTKOHINF-KEY2" TO  ORC-DBPATH
               PERFORM 930-PTKOHINF-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-PTKOHINF
           END-IF
      *
           PERFORM   UNTIL   FLG-PTKOHINF  =   1
               ADD     1                   TO  SPA-KOHID
               IF  PTKOH-SAKJOKBN          =   SPACE
                   INITIALIZE                  WRK-KENSAKU-AREA
                   MOVE    PTKOH-KOHNUM    TO  WRK-KEN-HKNNUM
                   MOVE    PTKOH-TEKSTYMD  TO  WRK-KEN-TEKSTYMD
                   MOVE    PTKOH-TEKEDYMD  TO  WRK-KEN-TEKEDYMD
                   MOVE    PTKOH-PAYKBN    TO  WRK-KEN-PAYKBN
                   MOVE    2               TO  WRK-KEN-HKNKOH
      *            保険確認処理
                   PERFORM 2210-HKNKOH-KAKUNIN-SEC
                   IF  WRK-KEN-ERFLG           =   SPACE
                       ADD     1               TO  IDY
                       MOVE    SPACE               TO  PARA-REC
                       INITIALIZE                      PARA-REC
                       MOVE    "PTKOHINF"          TO  PARA-FILEMEI
                       MOVE    IDY                 TO  PARA-EDANUM
                       MOVE    PTKOHINF-REC        TO  PARA-DATA-REC
                       PERFORM 400-PARA-INSERT-SEC
      ***********      INITIALIZE                  PARA-REC
      *#                 MOVE    SPA-TERMID      TO  PAR-TERMID
      *                MOVE    "PTKOHINF"      TO  PAR-FILEMEI
      *                MOVE    IDY             TO  PAR-EDANUM
      *                MOVE    PTKOHINF-REC    TO  PAR-DATA-REC
      *                WRITE                       PARA-REC
      *                IF  STS-PARA        NOT =   ZERO
      *                DISPLAY "*(ORCVTHKNCOMBI)* WRITE-KOH ERR STS["
      *                                        STS-PARA "]"
      **************   END-IF
                   ELSE
      *                エラーリスト出力処理
                       PERFORM 2220-ERRLST-OUT-SEC
                   END-IF
               END-IF
      *
               MOVE    "PTKOHINF-KEY2" TO  ORC-DBPATH
               PERFORM 930-PTKOHINF-NEXT-SEC
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
       230-PTKOHINF-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険公費確認処理
      *****************************************************************
       2210-HKNKOH-KAKUNIN-SEC        SECTION.
      *
           MOVE    ZERO               TO  FLG-HKNNUM
           MOVE    SPACE              TO  HKNNUM-REC
           MOVE    SPA-HOSPID         TO  HKN-HOSPID
           MOVE    WRK-KEN-HKNNUM     TO  HKN-HKNNUM
           IF      WRK-KEN-PAYKBN     =   SPACE
               MOVE    ZERO               TO  WRK-KEN-PAYKBN
           END-IF
      *    老人公費で支払区分が設定されていない時、システム管理より
           IF     (WRK-KEN-PAYKBN     =    ZERO )  AND
                  (WRK-KEN-HKNNUM     =    "027")
               MOVE    SPA-HOSPSBT         TO  HKN-PAYKBN (1:1) 
               MOVE    SPA-ROUPAYKBN       TO  HKN-PAYKBN (2:1)
           ELSE
               MOVE    WRK-KEN-PAYKBN      TO  HKN-PAYKBN
           END-IF
      *
           MOVE    HKNNUM-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"         TO  MCP-FUNC
      *****MOVE    "HKNNUM-KEY2"      TO  ORC-DBPATH
           MOVE    "HKNNUM-KEY7"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"     USING   MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
      ******** MOVE    "HKNNUM-KEY2"   TO  ORC-DBPATH
               MOVE    "HKNNUM-KEY7"   TO  ORC-DBPATH
               PERFORM 950-HKNNUM-NEXT-SEC
               MOVE    "1"             TO  WRK-KEN-ERFLG
           ELSE
               INITIALIZE              HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
               MOVE    "2"             TO  WRK-KEN-ERFLG
           END-IF
      *
           MOVE    ZERO                TO  FLG-RJN
           MOVE    SPACE               TO  WRK-HKN-HKNKOHSBTKBN
           PERFORM   UNTIL   FLG-HKNNUM    =   1
             IF  ( WRK-KEN-TEKSTYMD        >=  HKN-TEKSTYMD ) AND
                 ( WRK-KEN-TEKEDYMD        <=  HKN-TEKEDYMD )
               IF  HKN-HKNKOHSBTKBN        =   "3"
                   MOVE    1               TO  FLG-RJN
      **********   IF  (HKN-PAYKBN (1:1)   =   SPA-HOSPSBT)  AND
      ***********      (HKN-PAYKBN (2:1)   =   SPA-ROUPAYKBN)
                     MOVE    SPACE         TO  WRK-KEN-ERFLG
                     MOVE    1             TO  FLG-HKNNUM
      *********    ELSE
      *              PERFORM 950-HKNNUM-NEXT-SEC
      **********   END-IF
               ELSE
                   MOVE    SPACE               TO  WRK-KEN-ERFLG
                   MOVE    1                   TO  FLG-HKNNUM
                   MOVE    HKN-HKNKOHSBTKBN    TO  WRK-HKN-HKNKOHSBTKBN
               END-IF
             ELSE
               MOVE    "HKNNUM-KEY7"   TO  ORC-DBPATH
               PERFORM 950-HKNNUM-NEXT-SEC
             END-IF
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY7"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    対象支払区分の老人が存在しない場合
           IF  (WRK-KEN-ERFLG          =   "1")  AND
               (FLG-RJN                =   1  )
               MOVE    ZERO               TO  FLG-HKNNUM
               MOVE    SPACE              TO  HKNNUM-REC
               MOVE    SPA-HOSPID         TO  HKN-HOSPID
               MOVE    WRK-KEN-HKNNUM     TO  HKN-HKNNUM
               MOVE    HKNNUM-REC         TO  MCPDATA-REC
               MOVE    "DBSELECT"         TO  MCP-FUNC
               MOVE    "HKNNUM-KEY2"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC             =   ZERO
                   MOVE    "HKNNUM-KEY2"  TO  ORC-DBPATH
                   PERFORM 950-HKNNUM-NEXT-SEC
               ELSE
                   INITIALIZE             HKNNUM-REC
                   MOVE    1              TO  FLG-HKNNUM
               END-IF
      *
               PERFORM   UNTIL   FLG-HKNNUM   =   1
                 IF  ( WRK-KEN-TEKSTYMD       >=  HKN-TEKSTYMD ) AND
                     ( WRK-KEN-TEKEDYMD       <=  HKN-TEKEDYMD )
                     IF  HKN-HKNKOHSBTKBN     =   "3"
                         IF  (HKN-PAYKBN      =   "00")
                             MOVE    SPACE    TO  WRK-KEN-ERFLG
                             MOVE    1              TO  FLG-HKNNUM
                         ELSE
                             PERFORM 950-HKNNUM-NEXT-SEC
                         END-IF
                     ELSE
                         PERFORM 950-HKNNUM-NEXT-SEC
                     END-IF
                 ELSE
                     PERFORM 950-HKNNUM-NEXT-SEC
                 END-IF
               END-PERFORM
               MOVE    "DBCLOSE"          TO  MCP-FUNC
               MOVE    "HKNNUM-KEY2"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-IF
      *    対象の保険番号マスタが見つかった場合
           IF  WRK-KEN-ERFLG              =   SPACE
      *        対象の保険番号が保険のもの
               IF  HKN-HKNKOHSBTKBN       =   "1"  OR  "4"
                                          OR  "8"  OR  "9"
      *        　　患者公費情報のデータ
                   IF  WRK-KEN-HKNKOH     =   2
                       MOVE    "4"        TO  WRK-KEN-ERFLG
                   END-IF
               ELSE
      *        対象の保険番号が公費のもの
      *        　　患者情報情報のデータ
                   IF  WRK-KEN-HKNKOH     =   1
                       MOVE    "3"        TO  WRK-KEN-ERFLG
                   END-IF
               END-IF
           END-IF
      *
           .
       2210-HKNKOH-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタファイル作成処理
      *****************************************************************
       400-PARA-INSERT-SEC           SECTION.
      *
      *    パラメタ登録
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
      *
           MOVE    PARA-REC            TO  WRK-PARA-REC
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PARA
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PARA-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      FLG-PARA            =   1
               MOVE    WRK-PARA-REC        TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "*(ORCVTHKNCOMBI)*  PARA INSERT ERR:" MCP-RC
                           ",KEY2:" PARA-KEY
                           ",EDANUM:" PARA-EDANUM
               END-IF
           ELSE
               MOVE    WRK-PARA-REC        TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "*(ORCVTHKNCOMBI)*  PARA UPDATE ERR:" MCP-RC
                           ",KEY2:" PARA-KEY
                           ",EDANUM:" PARA-EDANUM
               END-IF
           END-IF
      *
           .
       400-PARA-INSERT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    エラーリスト出力処理
      *****************************************************************
       2220-ERRLST-OUT-SEC                SECTION.
      *
           ADD     1                   TO  CNT-ERR
           MOVE    ZERO                TO  FLG-ERR
      *
           IF  SPA-ERRCD               =   SPACE
               EVALUATE    WRK-KEN-ERFLG
      *        該当する保険番号なし
               WHEN    "1"
               WHEN    "2"
                   MOVE    1           TO  FLG-ERR
      *        患者保険マスタに公費が入っている場合
               WHEN    "3"
                   MOVE    2           TO  FLG-ERR
      *        患者公費マスタに保険が入っている場合
               WHEN    "4"
                   MOVE    3           TO  FLG-ERR
               END-EVALUATE
               IF  FLG-ERR             =   ZERO
                   MOVE    6           TO  FLG-ERR
               END-IF
           ELSE
      *        サブプロ（ORCGP02W2）内でエラー発生
               EVALUATE    SPA-ERRCD
      *        保険・公費テーブル１００件オーバー
               WHEN    "0015"
                   MOVE    4           TO  FLG-ERR
      *        保険・公費　該当なし
               WHEN    "0001"
               WHEN    "0014"
                   MOVE    5           TO  FLG-ERR
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE               TO  ERR-REC
           MOVE    CNT-ERR (1:3)       TO  ERR-NO (1:3)
           MOVE    ":"                 TO  ERR-NO (5:1)
           EVALUATE    FLG-ERR
           WHEN    1
               MOVE    CONS-MES1       TO  ERR-MES
               MOVE    WRK-KEN-HKNNUM  TO  ERR-HKNNUM
           WHEN    2
               MOVE    CONS-MES2       TO  ERR-MES
               MOVE    WRK-KEN-HKNNUM  TO  ERR-HKNNUM
           WHEN    3
               MOVE    CONS-MES3       TO  ERR-MES
               MOVE    WRK-KEN-HKNNUM  TO  ERR-HKNNUM
           WHEN    4
               MOVE    CONS-MES4       TO  ERR-MES
           WHEN    5
               MOVE    CONS-MES5       TO  ERR-MES
           WHEN    6
               MOVE    CONS-MES6       TO  ERR-MES
           END-EVALUATE
           MOVE    SPA-PTID            TO  ERR-PTID
           MOVE    SPA-ERRCD           TO  ERR-ERRCD
           WRITE   ERR-REC
      *
           MOVE    SPACE               TO  WRK-KEN-ERFLG
           MOVE    SPACE               TO  SPA-ERRCD
           MOVE    ZERO                TO  FLG-ERR
      *
           .
       2220-ERRLST-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ　登録処理
      *****************************************************************
       240-HKNCOMBI-INSERT-SEC         SECTION.
      *
      *    OPEN    INPUT               NC01PARA-FILE
      *    IF  STS-PARA            NOT =   ZERO
      *        MOVE    2               TO  FLG-PARA
      *        DISPLAY "*(ORCVTHKNCOMBI)* NC01PARA OPN-ERR STS["
      *                                STS-PARA "]"
      *    END-IF
      *    MOVE    ZERO                TO  FLG-NC01PARA
      *    INITIALIZE                      PARA-NC01-KEY
      *    MOVE    SPA-TERMID          TO  PARA-NC01-TERMID
      *    START   NC01PARA-FILE
      *        KEY IS    >=   PARA-NC01-KEY
      *        INVALID
      *            MOVE    1           TO  FLG-NC01PARA
      *        NOT INVALID
      *            PERFORM 980-NC01PARA-NEXT-SEC
      *    END-START
      *****PERFORM   UNTIL   FLG-NC01PARA  =   1
      *        組合せ番号　設定処理
      *        PERFORM 2410-HKNCOMBINUM-SET-SEC
      *
      *        PERFORM 980-NC01PARA-NEXT-SEC
      *    END-PERFORM
      *****CLOSE                       NC01PARA-FILE
      *
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "NC01PARA"          TO  PARA-FILEMEI
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY2"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1                   TO  FLG-PARA
           END-IF
           PERFORM
               UNTIL   FLG-PARA            =  1
      *
               MOVE    PARA-DATA-REC       TO  NC01PARA-REC
      *        組合せ番号　設定処理
               PERFORM 2410-HKNCOMBINUM-SET-SEC
      *
               MOVE    "PARA-KEY2"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           END-PERFORM
      *
           .
       240-HKNCOMBI-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    組合せ番号　設定処理
      *****************************************************************
       2410-HKNCOMBINUM-SET-SEC        SECTION.
      *
           MOVE    SPACE               TO  HKNCOMBI-REC
           MOVE    PARA-NC01-REC       TO  HKNCOMBI-REC
           ADD     1                   TO  IDZ
           MOVE    IDZ                 TO  COMB-HKNCOMBINUM
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "*(ORCVTHKNCOMBI)* HKNCOMBI INS-ERR[" MCP-RC "]"
           END-IF
           ADD     1                   TO  CNT-HKNCOMBI
      *
           .
       2410-HKNCOMBINUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号変換マスタ　更新処理
      *****************************************************************
       250-PTNUM-UPDATE-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNUM
           MOVE    SPACE               TO  PTNUM-REC
           INITIALIZE                      PTNUM-REC
           MOVE    SPA-HOSPID          TO  PTNUM-HOSPID
           MOVE    SPA-PTID            TO  PTNUM-PTID
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTNUM-KEY"     TO  ORC-DBPATH
               PERFORM 940-PTNUM-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-PTNUM
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      FLG-PTNUM           =   1
                MOVE    SPACE          TO  SPA-ERRCD
                MOVE    SPACE          TO  WRK-KEN-ERFLG
                PERFORM 2220-ERRLST-OUT-SEC
           ELSE
               MOVE    IDZ             TO  PTNUM-AUTOCOMBINUM
               IF  SPA-HKNID       NOT =   PTNUM-HKNID
                   MOVE    SPA-HKNID   TO  PTNUM-HKNID
               END-IF
               IF  SPA-KOHID       NOT =   PTNUM-KOHID
                   MOVE    SPA-KOHID   TO  PTNUM-KOHID
               END-IF
               MOVE    SPA-SYSYMD      TO  PTNUM-UPYMD
               MOVE    PTNUM-REC       TO  MCPDATA-REC
               MOVE    "DBUPDATE"      TO  MCP-FUNC
               MOVE    "PTNUM-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"  USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "*(ORCVTHKNCOMBI)* PTNUM UPD-ERR PTID["
                           SPA-PTID "]MCP-RC[" MCP-RC "]"
               END-IF
           END-IF
      *
           .
       250-PTNUM-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
      *    帳票出力　終了処理
           CLOSE                       ERR-FILE
      *
           DISPLAY "*(ORCVTHKNCOMBI)* PTINF   /I CNT[" CNT-PTINF    "]"
           DISPLAY "*(ORCVTHKNCOMBI)* PTHKNINF/I CNT[" CNT-PTHKNINF "]"
           DISPLAY "*(ORCVTHKNCOMBI)* PTKOHINF/I CNT[" CNT-PTKOHINF "]"
           DISPLAY "*(ORCVTHKNCOMBI)* HKNCOMBI/O CNT[" CNT-HKNCOMBI "]"
           DISPLAY "*(ORCVTHKNCOMBI)* ERR     /O CNT[" CNT-ERR      "]"
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
      *    患者マスタＦＥＴＣＨ処理
      *****************************************************************
       910-PTINF-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTINF-REC
               MOVE    ZERO            TO  FLG-PTINF
               ADD     1               TO  CNT-PTINF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
           .
       910-PTINF-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険マスタＦＥＴＣＨ処理
      *****************************************************************
       920-PTHKNINF-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTHKNINF-REC
               MOVE    ZERO            TO  FLG-PTHKNINF
               ADD     1               TO  CNT-PTHKNINF
           ELSE
               INITIALIZE                  PTHKNINF-REC
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
      *
           .
       920-PTHKNINF-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    患者公費マスタＦＥＴＣＨ処理
      *****************************************************************
       930-PTKOHINF-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTKOHINF-REC
               MOVE    ZERO            TO  FLG-PTKOHINF
               ADD     1               TO  CNT-PTKOHINF
           ELSE
               INITIALIZE                  PTKOHINF-REC
               MOVE    1               TO  FLG-PTKOHINF
           END-IF
      *
           .
       930-PTKOHINF-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    患者番号変換マスタＦＥＴＣＨ処理
      *****************************************************************
       940-PTNUM-NEXT-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTNUM-REC
               MOVE    ZERO            TO  FLG-PTNUM
           ELSE
               INITIALIZE                  PTNUM-REC
               MOVE    1               TO  FLG-PTNUM
           END-IF
      *
           .
       940-PTNUM-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    保険番号マスタ次検索処理
      *****************************************************************
       950-HKNNUM-NEXT-SEC             SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           .
       950-HKNNUM-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    新組合せパラメタデータ次読み
      *****************************************************************
      *980-NC01PARA-NEXT-SEC          SECTION.
      *
      *   READ    NC01PARA-FILE       NEXT
      *       AT  END
      *           MOVE    1           TO  FLG-NC01PARA
      *       NOT AT  END
      *           MOVE    ZERO        TO  FLG-NC01PARA
      *   END-READ
      *
      *   .
      *980-NC01PARA-NEXT-EXT.
      *** EXIT.
      *
      *****************************************************************
      *    パラメタデータ次読み
      *****************************************************************
      *990-PARA-NEXT-SEC              SECTION.
      *
      *   READ    PARA-FILE           NEXT
      *       AT  END
      *           MOVE    1           TO  FLG-PARA
      *       NOT AT  END
      *           MOVE    ZERO        TO  FLG-PARA
      *   END-READ
      *
      *   .
      *990-PARA-NEXT-EXT.
      *** EXIT.
      *
      *
      *****************************************************************
      *    パラメータファイル読み込み処理
      *****************************************************************
       900-PARM-READ-SEC               SECTION.
      *
          MOVE    SPACE                TO  PARM-REC
      *
          READ    PARM-FILE
              AT  END
                  MOVE    1            TO  FLG-PARM
              NOT AT  END
                  ADD     1            TO  CNT-PARM
          END-READ
      *
          .
       900-PARM-READ-EXT.
          EXIT.
      *****************************************************************
      *    パラメタ情報読み込み
      *****************************************************************
       990-PARA-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PARA-REC
               MOVE    ZERO            TO  FLG-PARA
           ELSE
      *********INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           .
       990-PARA-READ-EXT.
           EXIT.
      *
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC      NOT =   ZERO
               DISPLAY "DBOPEN ERROR"
           END-IF
      *
           MOVE    "DBSTART"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC      NOT =   ZERO
               DISPLAY "DBSTART ERROR"
           END-IF
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC      NOT =   ZERO
               DISPLAY "DBCOMMIT ERROR"
           END-IF
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC      NOT =   ZERO
               DISPLAY "DBDISCONNECT ERROR"
           END-IF
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
