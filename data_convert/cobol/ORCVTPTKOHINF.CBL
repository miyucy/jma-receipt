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
       PROGRAM-ID.                 ORCVTPTKOHINF.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＤＢ作成処理
      *  コンポーネント名  : ＣＳＶファイルコンバート処理（患者公費）
      *  管理者            : 
      *  01/04/11    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/11/01  患者番号の空白までで桁数
      *                                     を編集  
      *  01.00.02    MCC-伊藤     01/12/12  患者番号構成に合わせて
      *                                     前０詰め編集を行う  
      *  01.00.03    MCC-伊藤     01/12/12  ＤＢコールインターフェイス
      *                                     の変更  
      *  01.00.04    MCC-藤原     02/01/07  適用開始年月日の編集修正
      ************************************  OpenCOBOL対応
      *  01.00.05    MCC-伊藤     02/02/14  文字と数字の変換
      *  01.01.01    NACL-森脇    02/11/28  支払区分の追加
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
      *    入力患者公費情報ＣＳＶファイル
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
      *    入力患者公費情報ＣＳＶファイル
       FD  CSV-FILE.
       01  CSV-REC.
           03  CSV-R                   PIC X(300).
           03  CSV-RR  REDEFINES       CSV-R.
               05  CSV-X               PIC X(01)  OCCURS   300.
      *
      *    出力エラーファイル
       FD  ERR-FILE.
       01  ERR-REC                     PIC X(130).
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
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA                PIC X(02).
           03  STS-CSV                 PIC X(02).
           03  STS-LST                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PARA                PIC 9(01).
           03  FLG-CSV                 PIC 9(01).
           03  FLG-PTKOHINF            PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-PTNUM               PIC 9(01).
           03  FLG-AREA1.
               05  FLG-ERR             PIC 9(01).
               05  FLG-COMMA           PIC 9(01).
               05  FLG-DELI1           PIC 9(01).
               05  FLG-DELI2           PIC 9(01).
               05  FLG-NODATA          PIC 9(01).
           03  FLG-ERRARI              PIC 9(01).
           03  FLG-DATAEND             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PARA                PIC 9(06).
           03  CNT-CSV                 PIC 9(06).
           03  CNT-PTKOHINF            PIC 9(06).
           03  CNT-ERR                 PIC 9(03).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                     PIC 9(04).
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
           03  IDZ                     PIC 9(04).
           03  IDE                     PIC 9(04).
           03  IDJ                     PIC 9(04).
           03  IDI-G.
               05  IDI                 PIC 9(01).
      *
      *    パラメータ保存
       01  PARA-SAVE.
           03  PARA-05-1               PIC X(02).
           03  PARA-06-2               PIC X(08).
           03  PARA-07-0               PIC X(01).
           03  PARA-07-TBL             OCCURS 9.
               05  PARA-07-L           PIC X(02).
               05  PARA-07-R           PIC X(03).
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
           03  WRK-POINT-AREA.
               05  WRK-PO-ST           PIC 9(04).
               05  WRK-PO-ED           PIC 9(04).
           03  WRK-KOUMOKU-NO          PIC 9(04).
           03  WRK-MOVE-AREA.
               05  WRK-MO-ST           PIC 9(04).
               05  WRK-MO-ST1          PIC 9(04).
               05  WRK-MO-CNT          PIC 9(04).
               05  WRK-WK1             PIC 9(04).
               05  WRK-WK2             PIC 9(04).
               05  WRK-WK3             PIC 9(04).
               05  WRK-WK4             PIC 9(04).
           03  WRK-KOHID               PIC 9(10).
           03  WRK-RENKETA             PIC 9(02).
           03  WRK-PTNUM               PIC X(20).
           03  WRK-CNT                 PIC 9(04). 
           03  WRK-NUM1                PIC 9(01).
           03  WRK-NUM2                PIC 9(02).
      *
      *    帳票出力領域
       01  MES-AREA.
           03  MES-TITLE1.
               05  FILLER              PIC X(26) VALUE
                                       "【PGID:ORCVTPTKOHINF.CBL】".
               05  MES-TITLE1-YY       PIC X(04) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-MM       PIC X(02) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-DD       PIC X(02) VALUE SPACE.
           03  MES-TITLE2.
               05  FILLER              PIC X(18) VALUE
                                                 "NO    ERR-MESSAGE/".
               05  FILLER              PIC X(73) VALUE
               "ERRNO 1:必須未入力 2:項目桁数 3:誤入力 4:法別番号".
      *
       01  ERRLST-AREA.
      *    エラー番号１・２・３　で使用
           03  ERR-REC1.
               05  ERR1-NO             PIC X(05).
               05  FILLER              PIC X(01).
               05  ERR1-PTNUM          PIC X(20).
               05  ERR-OCCURS          OCCURS   4.
                   07  FILLER          PIC X(01).
                   07  ERR1-ERRNO      PIC X(02).
                   07  ERR1-KOMOKU     PIC X(08).
                   07  FILLER          PIC X(01).
                   07  ERR1-ATAI       PIC X(08).
      *    エラー番号４・５・６　で使用
           03  ERR-REC2.
               05  ERR2-NO             PIC X(05).
               05  FILLER              PIC X(01).
               05  ERR2-MES            PIC X(22).
               05  FILLER              PIC X(01).
               05  ERR2-PTNUM          PIC X(20).
               05  FILLER              PIC X(01).
               05  ERR2-PTID           PIC X(10).
               05  FILLER              PIC X(01).
               05  ERR2-KOHNUM         PIC X(03).
               05  FILLER              PIC X(01).
               05  ERR2-KOHID          PIC X(10).
      *
      *    メッセージ領域
       01  CONS-AREA.
      *     03  CONS-MES1               PIC X(22) VALUE
      *         "必須項目未入力エラー".
      *     03  CONS-MES2               PIC X(22) VALUE
      *         "項目桁数エラー".
      *     03  CONS-MES3               PIC X(22) VALUE
      *         "誤入力エラー".
           03  CONS-MES5               PIC X(22) VALUE
               "患者番号ＤＢ取得エラー".
           03  CONS-MES6               PIC X(22) VALUE
               "患者番号ＤＢ出力エラー".
           03  CONS-MES7               PIC X(22) VALUE
               "患者公費ＤＢ出力エラー".
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    システム管理（医療機関情報）
           COPY    "CPSK1001.INC".
      *    システム管理（患者番号構成管理）
           COPY    "CPSK1009.INC".
      *    患者公費情報
       01  PTKOH-REC.
           COPY    "CPPTKOHINF.INC".
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
                   UNTIL   FLG-CSV     =   1
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
           MOVE    ZERO            TO  FLG-AREA
           MOVE    ZERO            TO  CNT-AREA
           MOVE    ZERO            TO  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  SPA-AREA
      *
      *    パラメータ情報取得
           PERFORM 101-PARA-GET-SEC
           IF  FLG-PARA            =   2
               MOVE    1           TO  FLG-CSV
               GO      TO          100-INIT-EXT
           END-IF
      *
           ACCEPT  WRK-SYMD2       FROM    DATE
           MOVE    WRK-SYMD2       TO  WRK-SYMD (3:)
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
           PERFORM 120-CP1001-KENSAKU-SEC
           IF  FLG-CSV             =   1
               GO  TO              100-INIT-EXT
           END-IF
           PERFORM 120-CP1009-KENSAKU-SEC
           IF  FLG-CSV             =   1
               GO  TO              100-INIT-EXT
           END-IF
      *    ＣＳＶ入力ファイル　初期処理
           OPEN    INPUT           CSV-FILE
           IF  STS-CSV         NOT =   ZERO
               MOVE    1           TO  FLG-CSV
               DISPLAY "*(ORCVTPTKOHINF)* PTKOH-FILE OPN STS["
                                       STS-CSV "]"
               GO      TO          100-INIT-EXT
           END-IF
      *    帳票出力　初期処理
           PERFORM 2710-ERRLST-INIT-SEC
           IF  FLG-CSV             =   1
               GO  TO              100-INIT-EXT
           END-IF
           MOVE    PARA-05-1       TO  WRK-RENKETA(1:2)
      *
      *    患者公費ＣＳＶファイル　検索処理
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
           MOVE    ZERO                TO  FLG-PARA
           MOVE    SPACE               TO  PARA-SAVE
           OPEN    INPUT           PARA-FILE
           IF      STS-PARA        NOT =   ZERO
               MOVE    2               TO  FLG-PARA
               DISPLAY "*(ORCVTPTKOHINF)* PARA-FILE OPN STS["
                       STS-PARA "]"
               GO      TO          101-PARA-GET-EXT
           END-IF
      *
           PERFORM 900-PARA-READ-SEC
      *
           PERFORM UNTIL
                   FLG-PARA  =  1
      *
               IF  PARA-RECKBN         =   "@" 
                   PERFORM 101-PARA-GET1-SEC
               END-IF
      *
               PERFORM  900-PARA-READ-SEC
           END-PERFORM
      *
           CLOSE   PARA-FILE
      *
      *    パラメータチェック処理
           IF  PARA-05-1               IS  NUMERIC
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-CSV
               GO      TO          101-PARA-GET-EXT
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
           EVALUATE                PARA-DATKBN
             WHEN  "01-3"
                   MOVE  PARA-DATA TO  ASS-CSV
             WHEN  "02-3"
                   MOVE  PARA-DATA TO  ASS-ERR
             WHEN  "05-1"
                   MOVE  PARA-DATA TO  PARA-05-1
             WHEN  "06-2"
                   MOVE  PARA-DATA TO  PARA-06-2
             WHEN  "07-0"
                   MOVE  PARA-DATA TO  PARA-07-0
             WHEN  "07-1"
             WHEN  "07-2"
             WHEN  "07-3"
             WHEN  "07-4"
             WHEN  "07-5"
             WHEN  "07-6"
             WHEN  "07-7"
             WHEN  "07-8"
             WHEN  "07-9"
                   MOVE  PARA-DATKBN(4:1) TO  IDI-G
                   MOVE  PARA-DATA(1:2)   TO  PARA-07-L(IDI)
                   MOVE  PARA-DATA(4:3)   TO  PARA-07-R(IDI)
           END-EVALUATE
      *
           .
       101-PARA-GET1-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理情報　検索処理
      *****************************************************************
       120-CP1001-KENSAKU-SEC          SECTION.
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
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSTEM-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           IF  FLG-SYSKANRI            =   1
               MOVE    1                   TO  FLG-CSV
           ELSE
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
               MOVE    SYS-1001-HOSPID     TO  SPA-HOSPID
               MOVE    SYS-1001-HOSPSBT    TO  SPA-HOSPSBT
               MOVE    SYS-1001-ROUPAYKBN  TO  SPA-ROUPAYKBN
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
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
       120-CP1009-KENSAKU-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
           MOVE    SPACE               TO  SYS-1009-REC
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    WRK-SYMD            TO  ORC-DBYMD
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-SYSTEM-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           IF  FLG-SYSKANRI            =   1
               MOVE    1                   TO  FLG-CSV
           ELSE
               MOVE    MCPDATA-REC         TO  SYS-1009-REC
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
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
       200-MAIN-SEC                    SECTION.
      *
           IF  CNT-CSV (4:3)           =   ZERO
               DISPLAY "***(ORCVTPTKOHINF)*** CNT-CSV[" CNT-CSV "]"
                                       UPON    CONSOLE
           END-IF
           MOVE    SPACE               TO  PTKOH-REC
           INITIALIZE                      PTKOH-REC
           MOVE    ZERO                TO  WRK-POINT-AREA
           MOVE    ZERO                TO  IDX-AREA
           MOVE    ZERO                TO  WRK-KOHID
           MOVE    SPACE               TO  SPA-PTNUM
      *    対象患者にエラーが存在するかどうか
           MOVE    ZERO                TO  FLG-ERRARI
           MOVE    ZERO                TO  FLG-DATAEND
      *
      *    患者公費ＣＳＶファイルに存在する項目数分、繰り返す
      *    またはレコード終了、または項目エラー４個まで
           PERFORM     VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX           >   12   )
                       OR      ( WRK-PO-ED     >=  300  )
                       OR      ( IDE           >   4    )
      *
               COMPUTE     WRK-PO-ST   =   WRK-PO-ED   +   1
               MOVE    ZERO            TO  FLG-AREA1
               MOVE    IDX             TO  WRK-KOUMOKU-NO
      *
               IF  ( CSV-R (WRK-PO-ST:)    =   SPACE )  OR
                   ( FLG-DATAEND           =   1     )
                   MOVE    1           TO  FLG-DATAEND
                   MOVE    WRK-PO-ST   TO  WRK-PO-ED
               ELSE
      *            項目終了文字後のカンマ位置を取得(WRK-PO-ED)
                   PERFORM 210-CHAR-END-GET-SEC
               END-IF
      *
      *        項目共通処理
               PERFORM 220-KOUMOKU-KYOTU-SEC
      *
      *        必須項目チェック処理
               PERFORM 230-HISSU-KOUMOKU-SEC
               IF  FLG-ERR             =   ZERO
      *            項目別処理
                   PERFORM 240-KOUMOKU-BETU-SEC
                   IF  FLG-ERR         NOT =   ZERO
                       PERFORM 270-ERRREC-EDIT-SEC
                       MOVE    1           TO  FLG-ERRARI
                   END-IF
               ELSE
                   PERFORM 270-ERRREC-EDIT-SEC
                   MOVE    1               TO  FLG-ERRARI
               END-IF
      *
           END-PERFORM
      *
      *----(01.01.01)--ADD-START--
           IF      PTKOH-KOHNUM    =   "027"
               MOVE    "01"                TO  PTKOH-PAYKBN
               MOVE    "20021001"          TO  PTKOH-TEKSTYMD
           ELSE
               MOVE    "00"                TO  PTKOH-PAYKBN
           END-IF
      *----(01.01.01)--ADD-END----
      *
           IF  FLG-ERRARI              =   ZERO
      *        患者番号変換マスタ更新処理
               PERFORM 250-PTNUM-UPDATE-SEC
               IF  FLG-ERR             =   ZERO
      *            患者公費マスタ　更新処理
                   PERFORM 260-PTKOHINF-INSERT-SEC
                   IF  FLG-ERR         NOT =   ZERO
      *                エラーリスト編集/出力処理
                       PERFORM 270-ERRREC-EDIT-SEC
                       MOVE    2           TO  FLG-ERRARI
                       PERFORM 270-ERRLST-OUT-SEC
                   END-IF
               ELSE
      *            エラーリスト編集/出力処理
                   PERFORM 270-ERRREC-EDIT-SEC
                   MOVE    2           TO  FLG-ERRARI
                   PERFORM 270-ERRLST-OUT-SEC
               END-IF
           ELSE
      *        エラーリスト出力処理
               MOVE    1           TO  FLG-ERRARI
               PERFORM 270-ERRLST-OUT-SEC
           END-IF
      *
      *    患者公費ＣＳＶファイル　検索処理
           PERFORM 900-CSV-KENSAKU-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象項目の文字終了位置を取得
      *****************************************************************
       210-CHAR-END-GET-SEC            SECTION.
      *
           PERFORM     VARYING   IDY   FROM    WRK-PO-ST   BY  1
                       UNTIL   ( IDY           >=  300  )
                       OR      ( FLG-COMMA     =   1    )
      *        カンマの位置
               IF  ( CSV-X (IDY)       =   ","   )  OR
                   ((IDX               =   12 )  AND
                    (CSV-X (IDY)       =   SPACE))
                   MOVE    IDY         TO  WRK-PO-ED
                   MOVE    1           TO  FLG-COMMA
               END-IF
      *        デリミタ(")存在するかどうか
               IF  CSV-X (IDY)         =   """"
                   IF  FLG-DELI1       =   ZERO
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
       220-KOUMOKU-KYOTU-SEC           SECTION.
      *
           MOVE    ZERO                TO  WRK-MOVE-AREA
      *
      *    データが省略されている場合、FLG-NODATAに1をセット
           IF  FLG-DELI1               =   1
      *        デリミタ(")を含んでいる場合
               IF  FLG-DELI2           =   1
                   COMPUTE WRK-WK1     =   WRK-PO-ST   +   2
               ELSE
                   COMPUTE WRK-WK1     =   WRK-PO-ST   +   1
               END-IF
               IF  WRK-WK1             =   WRK-PO-ED
                   MOVE    1           TO  FLG-NODATA
                   GO      TO          220-KOUMOKU-KYOTU-EXT
               END-IF
           ELSE
      *        デリミタ(")を含んでいない場合
               IF  WRK-PO-ST           =   WRK-PO-ED
                   MOVE    1           TO  FLG-NODATA
                   GO      TO          220-KOUMOKU-KYOTU-EXT
               END-IF
           END-IF
      *
      *    転送開始位置・転送桁数を算出
           IF  FLG-DELI1               =   1
      *        デリミタ(")を含んでいる場合
               COMPUTE   WRK-MO-ST     =   WRK-PO-ST   +   1
               IF  FLG-DELI2           =   1
                   COMPUTE   WRK-MO-CNT    =   WRK-PO-ED
                                           -  (WRK-PO-ST   +   2)
               ELSE
                   COMPUTE   WRK-MO-CNT    =  (WRK-PO-ED   -   1)
                                           -   WRK-PO-ST
               END-IF
           ELSE
      *        デリミタ(")を含んでいない場合
               MOVE    WRK-PO-ST       TO  WRK-MO-ST
               COMPUTE   WRK-MO-CNT    =   WRK-PO-ED  -  WRK-PO-ST
           END-IF
      *
           .
       220-KOUMOKU-KYOTU-EXT.
           EXIT.
      *
      *****************************************************************
      *    必須項目チェック処理
      *****************************************************************
       230-HISSU-KOUMOKU-SEC           SECTION.
      *
           IF  FLG-NODATA              =   1
      *
               EVALUATE    WRK-KOUMOKU-NO
      *        １：患者番号
               WHEN    1
      *        ２：レコード番号（公費番号）
               WHEN    2
      **        ５：負担者番号
      *         WHEN    5
      **        ６：受給者番号
      *         WHEN    6
      **        ８：適用開始日
      *         WHEN    8
      **        ９：適用終了日
      *         WHEN    9
                   MOVE    1           TO  FLG-ERR
      *
               WHEN    OTHER
                   CONTINUE
               END-EVALUATE
           END-IF
      *
      *コメント START ---------------------------------------------
      **    法別番号・法別番号（地方公費）どちらかに入っていること
      *     IF  WRK-KOUMOKU-NO          =   4
      **        法別番号（地方公費）が存在する場合
      *         IF  FLG-NODATA          =   ZERO
      *             IF  PTKOH-KOHNUM    NOT =   SPACE
      *                 MOVE    4           TO  FLG-ERR
      *                 GO      TO          230-HISSU-KOUMOKU-EXT
      *             END-IF
      *         ELSE
      **        法別番号（地方公費）が存在しない場合
      *             IF  PTKOH-KOHNUM        =   SPACE
      *                 MOVE    4           TO  FLG-ERR
      *                 GO      TO          230-HISSU-KOUMOKU-EXT
      *             END-IF
      *         END-IF
      *     END-IF
      *コメント END   ---------------------------------------------
      *
           .
       230-HISSU-KOUMOKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目別処理
      *****************************************************************
       240-KOUMOKU-BETU-SEC            SECTION.
      *
           EVALUATE    WRK-KOUMOKU-NO
      *    １：患者番号
           WHEN    1
               PERFORM 2410-PTNUM-SET-SEC
      *    ２：レコード番号（公費番号）
           WHEN    2
               PERFORM 2410-RECORD-KOH-SET-SEC
      *    ３：法別番号
           WHEN    3
               PERFORM 2410-HBTNUM-SET-SEC
      *    ４：法別番号（地方公費）
           WHEN    4
               PERFORM 2410-HBTNUM-CHIHO-SET-SEC
      *    ５：負担者番号
           WHEN    5
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTKOH-FTNJANUM
               END-IF
      *    ６：受給者番号
           WHEN    6
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTKOH-JKYSNUM
               END-IF
      **    ７：公費一部負担金
      *     WHEN    7
      *         CONTINUE
      *    ８：適用開始日
           WHEN    8
               PERFORM 2410-TEKSTYMD-SET-SEC
      *    ９：適用終了日
           WHEN    9
               PERFORM 2410-TEKEDYMD-SET-SEC
      *    １０：公費確認日
           WHEN    10
               PERFORM 2410-KAKUNINYMD-SET-SEC
      *    １１：登録日
           WHEN    11
               PERFORM 2410-CREYMD-SET-SEC
      *    １２：更新日
           WHEN    12
               PERFORM 2410-UPYMD-SET-SEC
      *
           END-EVALUATE
      *
           .
       240-KOUMOKU-BETU-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１：患者番号　処理
      *****************************************************************
       2410-PTNUM-SET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-PTNUM
      *
      *    空白までを編集する     
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-PTNUM
           MOVE    ZERO                TO  WRK-CNT                            
           PERFORM VARYING IDW FROM    1   BY  1
                   UNTIL   IDW >       WRK-MO-CNT
                   OR      WRK-PTNUM (IDW:1)   =   SPACE 
               MOVE    IDW             TO    WRK-CNT
           END-PERFORM
           MOVE    WRK-CNT             TO  WRK-MO-CNT
      *
           IF      WRK-MO-CNT          >   0   AND
                   WRK-MO-CNT          <=  20
             IF (( SYS-1009-PTNUMKSIKBN    =   "1" ) AND
                 ( SYS-1009-JIYKSIKBN      =   "2" ))    OR
                (( SYS-1009-PTNUMKSIKBN    =   "2" ) AND
                 ( SYS-1009-HJNKSIKBN      =   "3" OR "4" ))
               MOVE  ZERO              TO  SPA-PTNUM(1:WRK-RENKETA)
               COMPUTE WRK-MO-ST1      =   WRK-RENKETA
                                       -   WRK-MO-CNT
                                       +   1
               MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  SPA-PTNUM(WRK-MO-ST1:)
             ELSE
               MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  SPA-PTNUM
             END-IF
           ELSE
               MOVE    2               TO  FLG-ERR
           END-IF
      *
           .
       2410-PTNUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目２：レコード番号（公費番号）　処理
      *****************************************************************
       2410-RECORD-KOH-SET-SEC         SECTION.
      *
           IF  WRK-MO-CNT              =   1  OR  2
      *
               IF  ( CSV-REC (WRK-MO-ST:WRK-MO-CNT) IS  NUMERIC  ) AND
                   ( CSV-REC (WRK-MO-ST:WRK-MO-CNT) NOT =   ZERO )
      *            MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
      *                                TO  WRK-KOHID
      *            MOVE    WRK-KOHID   TO  PTKOH-KOHID
                   IF      WRK-MO-CNT  =   1
                     MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-NUM1
                     MOVE  WRK-NUM1    TO  PTKOH-KOHID
                   ELSE
                     MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-NUM2
                     MOVE  WRK-NUM2    TO  PTKOH-KOHID
                   END-IF  
               ELSE
                   MOVE    3           TO  FLG-ERR
                   GO      TO          2410-RECORD-KOH-SET-EXT
               END-IF
           ELSE
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-RECORD-KOH-SET-EXT
           END-IF
      *
           .
       2410-RECORD-KOH-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目３：法別番号
      *****************************************************************
       2410-HBTNUM-SET-SEC             SECTION.
      *
           IF  FLG-NODATA              =   1
               GO  TO                  2410-HBTNUM-SET-EXT
           END-IF
      *
           IF  WRK-MO-CNT              =   2
      *
               IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "10"  OR  "11"  OR  "12"
                                       OR  "13"  OR  "14"  OR  "15"
                                       OR  "16"  OR  "17"  OR  "18"
                                       OR  "19"  OR  "20"  OR  "21"
                                       OR  "23"  OR  "27"  OR  "28"
                                       OR  "29"  OR  "50"  OR  "51"
                                       OR  "52"  OR  "53"
      **コメント START ---------------------------------------------
      *                                 OR  "55"  OR  "56"
      **コメント END   ---------------------------------------------
                   CONTINUE
               ELSE
                   MOVE    3           TO  FLG-ERR
                   GO      TO          2410-HBTNUM-SET-EXT
               END-IF
           ELSE
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-HBTNUM-SET-EXT
           END-IF
      *
           EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
      *    特定疾患（負担無し）
           WHEN    "50"
               MOVE    "091"           TO  PTKOH-KOHNUM
      *
      **コメント START ---------------------------------------------
      **    福祉
      *     WHEN    "55"
      *         MOVE    "191"           TO  PTKOH-KOHNUM
      **    乳児
      *     WHEN    "56"
      *         MOVE    "190"           TO  PTKOH-KOHNUM
      **コメント END   ---------------------------------------------
      *
           WHEN    OTHER
               MOVE    "0"             TO  PTKOH-KOHNUM (1:1)
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTKOH-KOHNUM (2:2)
           END-EVALUATE
      *
           .
       2410-HBTNUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目４：法別番号（地方公費）
      *****************************************************************
       2410-HBTNUM-CHIHO-SET-SEC       SECTION.
      *
           IF  FLG-NODATA              =   1
               GO  TO                  2410-HBTNUM-CHIHO-SET-EXT
           END-IF
      *
           IF  WRK-MO-CNT              =   2
               CONTINUE
           ELSE
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-HBTNUM-CHIHO-SET-EXT
           END-IF
      *
           MOVE    PARA-07-0           TO  IDI-G
           PERFORM VARYING IDJ
                   FROM    1
                   BY      1
                   UNTIL   IDJ  >  IDI
               IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   PARA-07-L(IDJ)
                   MOVE  PARA-07-R(IDJ)
                                       TO  PTKOH-KOHNUM
                   MOVE  IDI           TO  IDJ
               ELSE
                   IF  IDJ             =   IDI
                       MOVE    3       TO  FLG-ERR
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       2410-HBTNUM-CHIHO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目８：適用開始日　処理
      *****************************************************************
       2410-TEKSTYMD-SET-SEC           SECTION.
      *
           EVALUATE    WRK-MO-CNT
      *
           WHEN    ZERO
               MOVE    PARA-06-2       TO  PTKOH-TEKSTYMD
      *
           WHEN    1
               IF      CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "0"
                   MOVE    PARA-06-2       TO  PTKOH-TEKSTYMD
               ELSE                        
                   MOVE    2               TO  FLG-ERR
               END-IF                   
      *
           WHEN    8
               IF      CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   ALL "0"
                   MOVE    PARA-06-2       TO  PTKOH-TEKSTYMD
               ELSE                        
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  PTKOH-TEKSTYMD
               END-IF                            
           WHEN    OTHER
               MOVE    2               TO  FLG-ERR
           END-EVALUATE
      *
           .
       2410-TEKSTYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目９：適用終了日　処理
      *****************************************************************
       2410-TEKEDYMD-SET-SEC           SECTION.
      *
           EVALUATE    WRK-MO-CNT
      *
           WHEN    ZERO
               MOVE    ALL "9"         TO  PTKOH-TEKEDYMD
      *
           WHEN    8
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTKOH-TEKEDYMD
           WHEN    OTHER
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-TEKEDYMD-SET-EXT
           END-EVALUATE
      *
      *----(01.01.01)--ADD-START--
           IF      PTKOH-KOHNUM     =  "027"        AND
                   PTKOH-TEKEDYMD   <  "20021001"
               MOVE    3               TO  FLG-ERR
           END-IF
      *----(01.01.01)--ADD-END----
      *
           .
       2410-TEKEDYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１０：公費確認日　処理
      *****************************************************************
       2410-KAKUNINYMD-SET-SEC         SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   8
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTKOH-KAKUNINYMD
                   IF  PTKOH-KAKUNINYMD (7:2)  =  ZERO
                       MOVE    "01"    TO  PTKOH-KAKUNINYMD (7:2)
                   END-IF
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-KAKUNINYMD-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-KAKUNINYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１１：登録日　処理
      *****************************************************************
       2410-CREYMD-SET-SEC             SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   8
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTKOH-CREYMD
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-CREYMD-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-CREYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１２：更新日　処理
      *****************************************************************
       2410-UPYMD-SET-SEC             SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   8
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTKOH-UPYMD
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-UPYMD-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-UPYMD-SET-EXT.
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
           MOVE    SPA-PTNUM           TO  PTNUM-PTNUM
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY2"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTNUM-KEY2"    TO  ORC-DBPATH
               PERFORM 940-PTNUM-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-PTNUM
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNUM-KEY2"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      FLG-PTNUM           =   1
                MOVE    5              TO  FLG-ERR
                GO      TO             250-PTNUM-UPDATE-EXT
           ELSE
      *        患者番号変換マスタより転送
               MOVE    PTNUM-PTID      TO  PTKOH-PTID
      *        最大公費ＩＤで患者番号変換マスタを更新
               IF  PTNUM-KOHID         <   PTKOH-KOHID
                   MOVE    PTKOH-KOHID     TO  PTNUM-KOHID
                   MOVE    SPA-SYSYMD      TO  PTNUM-UPYMD
                   MOVE    PTNUM-REC       TO  MCPDATA-REC
                   MOVE    "DBUPDATE"      TO  MCP-FUNC
                   MOVE    "PTNUM-KEY2"    TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"  USING   MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC      NOT =   ZERO
                       MOVE    6               TO  FLG-ERR
                       GO      TO              250-PTNUM-UPDATE-EXT
                   END-IF
               END-IF
           END-IF
      *
           .
       250-PTNUM-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費マスタ　登録処理
      *****************************************************************
       260-PTKOHINF-INSERT-SEC            SECTION.
      *
           MOVE    SPA-HOSPID          TO  PTKOH-HOSPID
           MOVE    SPA-TERMID          TO  PTKOH-TERMID
           MOVE    PTKOH-REC           TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
                MOVE    7              TO  FLG-ERR
                GO      TO             260-PTKOHINF-INSERT-EXT
           END-IF
           ADD     1                   TO  CNT-PTKOHINF
      *
           .
       260-PTKOHINF-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集処理
      *****************************************************************
       270-ERRREC-EDIT-SEC             SECTION.
      *
           IF  FLG-ERR                 <=  4
               ADD     1               TO  IDE
               IF  IDE                 >   4
                   GO  TO              270-ERRREC-EDIT-EXT
               END-IF
               IF  IDE                     =   1
                   ADD     1               TO  CNT-ERR
                   MOVE    SPACE           TO  ERR-REC1
                   MOVE    CNT-ERR (1:3)   TO  ERR1-NO (1:3)
                   MOVE    ":"             TO  ERR1-NO (4:1)
                   MOVE    SPA-PTNUM       TO  ERR1-PTNUM
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
      *    法別番号関連エラー
           WHEN    4
               PERFORM 2710-ERRREC-EDIT-BETU1-SEC
      *    番号ＤＢ取得エラー
           WHEN    5
      *    番号ＤＢ出力エラー
           WHEN    6
      *    患者公費ＤＢ出力エラー
           WHEN    7
               PERFORM 2710-ERRREC-EDIT-BETU2-SEC
           END-EVALUATE
      *
           .
       270-ERRREC-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集　別１　処理
      *****************************************************************
       2710-ERRREC-EDIT-BETU1-SEC      SECTION.
      *
      *    エラー内容番号転送
           MOVE    FLG-ERR (1:1)       TO  ERR1-ERRNO (IDE)(1:1)
           MOVE    ":"                 TO  ERR1-ERRNO (IDE)(2:1)
      *
      *    エラー項目名称転送
           EVALUATE    WRK-KOUMOKU-NO
      *    １：患者番号
           WHEN    1
               MOVE    "患者番号"      TO  ERR1-KOMOKU(IDE)
      *    ２：レコード番号（公費番号）
           WHEN    2
               MOVE    "レコード"      TO  ERR1-KOMOKU(IDE)
      *    ３：法別番号
           WHEN    3
               MOVE    "法別番号"      TO  ERR1-KOMOKU(IDE)
      *    ４：法別番号（地方公費）
           WHEN    4
      *        法別番号・法別番号（地方公費）両方に入っている場合
               IF  ( FLG-NODATA        =   ZERO  )  AND
                   ( PTKOH-KOHNUM  NOT =   SPACE )
                   MOVE    "法別番号"      TO  ERR1-KOMOKU(IDE)
                   MOVE    PTKOH-KOHNUM    TO  ERR1-ATAI  (IDE)(1:8)
                   ADD     1               TO  IDE
                   IF  IDE                 >   4
                       GO  TO              2710-ERRREC-EDIT-BETU1-EXT
                   END-IF
                   MOVE    "法別地方"      TO  ERR1-KOMOKU(IDE)
               ELSE
                   MOVE    "法別地方"      TO  ERR1-KOMOKU(IDE)
               END-IF
      *    ５：負担者番号
           WHEN    5
               MOVE    "負担者番"      TO  ERR1-KOMOKU(IDE)
      *    ６：受給者番号
           WHEN    6
               MOVE    "受給者番"      TO  ERR1-KOMOKU(IDE)
      *    ７：公費一部負担金
           WHEN    7
               MOVE    "公費一部"      TO  ERR1-KOMOKU(IDE)
      *    ８：適用開始日
           WHEN    8
               MOVE    "適用開始"      TO  ERR1-KOMOKU(IDE)
      *    ９：適用終了日
           WHEN    9
               MOVE    "適用終了"      TO  ERR1-KOMOKU(IDE)
      *    １０：公費確認日
           WHEN    10
               MOVE    "公費確認"      TO  ERR1-KOMOKU(IDE)
      *    １１：登録日
           WHEN    11
               MOVE    "登録日"        TO  ERR1-KOMOKU(IDE)
      *    １２：更新日
           WHEN    12
               MOVE    "更新日"        TO  ERR1-KOMOKU(IDE)
           END-EVALUATE
      *
      *    エラー値転送
           IF  WRK-MO-CNT          NOT =   ZERO
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  ERR1-ATAI  (IDE)(1:8)
           END-IF
      *
           .
       2710-ERRREC-EDIT-BETU1-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集　別２　処理
      *****************************************************************
       2710-ERRREC-EDIT-BETU2-SEC      SECTION.
      *
           ADD     1                   TO  CNT-ERR
           MOVE    SPACE               TO  ERR-REC2
           MOVE    CNT-ERR (1:3)       TO  ERR2-NO (1:3)
           MOVE    ":"                 TO  ERR2-NO (4:1)
           EVALUATE    FLG-ERR
           WHEN    5
               MOVE    CONS-MES5       TO  ERR2-MES
           WHEN    6
               MOVE    CONS-MES6       TO  ERR2-MES
           WHEN    7
               MOVE    CONS-MES7       TO  ERR2-MES
           END-EVALUATE
           MOVE    SPA-PTNUM           TO  ERR2-PTNUM
           IF  PTKOH-PTID          NOT =   ZERO
               MOVE    PTKOH-PTID      TO  ERR2-PTID
           END-IF
           MOVE    PTKOH-KOHNUM        TO  ERR2-KOHNUM
           IF  PTKOH-KOHID         NOT =   ZERO
               MOVE    PTKOH-KOHID     TO  ERR2-KOHID
           END-IF
      *
           .
       2710-ERRREC-EDIT-BETU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票出力　初期処理
      *****************************************************************
       2710-ERRLST-INIT-SEC            SECTION.
      *
           OPEN    OUTPUT              ERR-FILE
           IF  STS-LST             NOT =   ZERO
               MOVE    1               TO  FLG-CSV
               DISPLAY "*(ORCVTPTKOHINF)* ERRFILE OPN STS[" STS-LST "]"
               GO      TO              2710-ERRLST-INIT-EXT
           END-IF
      *
           MOVE    MES-TITLE1      TO      ERR-REC
           WRITE   ERR-REC
           MOVE    MES-TITLE2      TO      ERR-REC
           WRITE   ERR-REC
      *
           .
       2710-ERRLST-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト出力処理
      *****************************************************************
       270-ERRLST-OUT-SEC              SECTION.
      *
           IF  FLG-ERRARI              =   1
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
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
      *    帳票出力　終了処理
           CLOSE                       CSV-FILE
           CLOSE                       ERR-FILE
      *
           DISPLAY "*(ORCVTPTKOHINF)* CSV     /I CNT[" CNT-CSV      "]"
           DISPLAY "*(ORCVTPTKOHINF)* PTKOHINF/O CNT[" CNT-PTKOHINF "]"
           DISPLAY "*(ORCVTPTKOHINF)* ERR     /O CNT[" CNT-ERR      "]"
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
           CALL    "ORCMCPSUB"      USING   MCPAREA
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
      *    患者番号変換マスタＦＥＴＣＨ処理
      *****************************************************************
       940-PTNUM-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"      USING   MCPAREA
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
      *    患者公費ＣＳＶファイル　検索処理
      *****************************************************************
       900-CSV-KENSAKU-SEC          SECTION.
      *
          READ    CSV-FILE
              AT  END
                  MOVE    1           TO  FLG-CSV
              NOT AT  END
                  MOVE    ZERO        TO  FLG-CSV
                  ADD     1           TO  CNT-CSV
          END-READ
      *
          .
       900-CSV-KENSAKU-EXT.
          EXIT.
      *
      *****************************************************************
      *    パラメータファイル読み込み処理
      *****************************************************************
       900-PARA-READ-SEC               SECTION.
      *
          MOVE    SPACE                TO  PARA-REC
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
