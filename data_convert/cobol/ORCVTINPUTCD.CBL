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
       PROGRAM-ID.                 ORCVTINPUTCD.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＤＢ作成処理
      *  コンポーネント名  : ＣＳＶファイルコンバート処理
      *                                 （点数マスター情報：入力コード）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/08/21    山本          新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-伊藤     01/12/12  ＤＢコールインターフェイス
      *                                     の変更  
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
      *    点数マスター情報ＣＳＶファイル
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
      *    点数マスター情報ＣＳＶファイル
       FD  CSV-FILE.
       01  CSV-REC.
           03  CSV-R                   PIC X(3000).
           03  CSV-RR  REDEFINES       CSV-R.
               05  CSV-X               PIC X(01)  OCCURS   3000.
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
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-TENSU               PIC 9(01).
           03  FLG-INPUTCD             PIC 9(01).
           03  FLG-SRYCD               PIC 9(01).
           03  FLG-AREA1.
               05  FLG-ERR             PIC 9(01).
               05  FLG-COMMA           PIC 9(01).
               05  FLG-DELI1           PIC 9(01).
               05  FLG-DELI2           PIC 9(01).
               05  FLG-NODATA          PIC 9(01).
           03  FLG-ERRARI              PIC 9(01).
           03  FLG-UPDATE              PIC 9(01).
           03  FLG-DATAEND             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PARA                PIC 9(06).
           03  CNT-CSV                 PIC 9(06).
           03  CNT-ICD                 PIC 9(06).
           03  CNT-ERR                 PIC 9(03).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
           03  IDZ                     PIC 9(04).
           03  IDE                     PIC 9(04).
      *
      *    パラメータ保存
      *     
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-SYMD2.
               05  WRK-SYY2        PIC 9(02).
               05  WRK-SMM2        PIC 9(02).
               05  WRK-SDD2        PIC 9(02).
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
           03  WRK-INPUTCD-AREA.
               05  WRK-INPUTCD         PIC X(20).
               05  WRK-CDSYU           PIC X(01).
               05  WRK-DSPSEQ          PIC 9(02).
               05  WRK-SRYCD           PIC X(09).
               05  WRK-NUMCNT          PIC 9(04).
               05  WRK-SPCFLG          PIC 9(01).
               05  WRK-ACPT            PIC X(01).
      *
      *    帳票出力領域
       01  MES-AREA.
           03  MES-TITLE1.
               05  FILLER              PIC X(25) VALUE
                                       "【PGID:ORCVTINPUTCD.CBL】".
               05  MES-TITLE1-YY       PIC X(04) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-MM       PIC X(02) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-DD       PIC X(02) VALUE SPACE.
           03  MES-TITLE2.
               05  FILLER              PIC X(18) VALUE
                                                 "NO    ERR-MESSAGE/".
               05  FILLER              PIC X(73) VALUE
                   "ERRNO 1:必須未入力 2:項目エラー --------".
      *
       01  ERRLST-AREA.
      *    エラー番号１・２・３　で使用
           03  ERR-REC1.
               05  ERR1-NO             PIC X(05).
               05  FILLER              PIC X(01).
               05  ERR1-CSVLINE        PIC 9(06).
               05  ERR-OCCURS          OCCURS   1.
                   07  FILLER          PIC X(01).
                   07  ERR1-ERRNO      PIC X(02).
                   07  ERR1-KOMOKU     PIC X(20).
                   07  FILLER          PIC X(01).
                   07  ERR1-ATAI       PIC X(20).
      *    エラー番号４・５・６　で使用
           03  ERR-REC2.
               05  ERR2-NO             PIC X(05).
               05  FILLER              PIC X(01).
               05  ERR2-MES            PIC X(20).
               05  FILLER              PIC X(01).
               05  ERR2-SRYCD          PIC X(09).
               05  FILLER              PIC X(01).
               05  ERR2-CDSYU          PIC X(01).
               05  FILLER              PIC X(01).
               05  ERR2-INPUTCD        PIC X(20).
               05  FILLER              PIC X(01).
               05  ERR2-DSPSEQ         PIC 9(02).
      *
      *    メッセージ領域
      *    03  CONS-MES4               PIC X(20) VALUE
      *        "ＤＢエラー４".
           03  CONS-MES5               PIC X(20) VALUE
               "診療コード該当無し".
           03  CONS-MES6               PIC X(20) VALUE
               "入力ＤＢエラー".
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    システム管理（医療機関情報）
           COPY    "CPSK1001.INC".
      *    入力コード
       01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *    共通パラメタ
           COPY    "MCPAREA".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           MOVE    ZERO                TO  FLG-AREA
           MOVE    ZERO                TO  CNT-AREA
           MOVE    ZERO                TO  IDX-AREA
           MOVE    SPACE               TO  ASS-AREA
           INITIALIZE                      WRK-AREA
           INITIALIZE                      SPA-AREA
      *
      *    パラメータ情報取得
           PERFORM 101-PARA-GET-SEC
           IF  FLG-PARA                =   2
               MOVE    1               TO  FLG-CSV
               GO      TO              100-INIT-EXT
           END-IF
      *
           ACCEPT  WRK-SYMD2       FROM    DATE
           MOVE    WRK-SYMD2           TO  WRK-SYMD (3:)
           ADD     2000                TO  WRK-SYY
           MOVE    WRK-SYMD            TO  SPA-SYSYMD
           MOVE    SPA-SYSYMD(1:4)     TO  MES-TITLE1-YY
           MOVE    SPA-SYSYMD(5:2)     TO  MES-TITLE1-MM
           MOVE    SPA-SYSYMD(7:2)     TO  MES-TITLE1-DD
      *
      *    端末ＩＤ固定
           MOVE    "ORCATERM"          TO  SPA-TERMID
      *
      *    帳票ＯＰＥＮ処理
           OPEN    INPUT               CSV-FILE
           IF  STS-CSV             NOT =   ZERO
               MOVE    1               TO  FLG-CSV
               DISPLAY "*(ORCVTINPUTCD)* INPUTCD-FILE OPN STS["
                       STS-CSV "]"
               GO      TO              100-INIT-EXT
           END-IF
      *    帳票出力　初期処理
           PERFORM 2990-ERRLST-INIT-SEC
           IF  FLG-CSV                 =   1
               GO      TO              100-INIT-EXT
           END-IF
      *
      *    データベースオープン
           PERFORM 100-DBOPEN-SEC
      *
      *    システム管理情報　検索処理
           PERFORM 110-CP1001-KENSAKU-SEC
           IF  FLG-CSV                 =   1
               GO      TO              100-INIT-EXT
           END-IF
      *
      *    ＣＳＶファイル　検索処理
           MOVE    1                   TO  FLG-UPDATE
           PERFORM 900-CSV-KENSAKU-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメータ情報取得
      *****************************************************************
       101-PARA-GET-SEC                SECTION.
      *
           MOVE    ZERO                TO  FLG-PARA
           OPEN    INPUT               PARA-FILE
           IF      STS-PARA        NOT =   ZERO
               MOVE    2               TO  FLG-PARA
               DISPLAY "*(ORCVTINPUTCD)* PARA-FILE OPN STS["
                       STS-PARA "]"
               GO      TO              101-PARA-GET-EXT
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
      *    nop
           .
       101-PARA-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメータ情報取得（１）
      *****************************************************************
       101-PARA-GET1-SEC               SECTION.
      *
           EVALUATE                    PARA-DATKBN
             WHEN  "01-5"
                   MOVE  PARA-DATA     TO  ASS-CSV
             WHEN  "02-5"
                   MOVE  PARA-DATA     TO  ASS-ERR
           END-EVALUATE
      *
           .
       101-PARA-GET1-EXT.
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
               MOVE    1                   TO  FLG-CSV
           ELSE
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
               MOVE    SYS-1001-HOSPID     TO  SPA-HOSPID
               MOVE    SYS-1001-HOSPSBT    TO  SPA-HOSPSBT
               MOVE    SYS-1001-ROUPAYKBN  TO  SPA-ROUPAYKBN
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
       110-CP1001-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           IF  CNT-CSV (4:3)           =   ZERO
               DISPLAY "***(ORCVTINPUTCD)*** CNT-CSV[" CNT-CSV "]"
                                       UPON    CONSOLE
           END-IF
           MOVE    SPACE               TO  INPUTCD-REC
           INITIALIZE                      INPUTCD-REC

           MOVE    ZERO                TO  WRK-POINT-AREA
           MOVE    ZERO                TO  IDX-AREA
      *    対象レコードにエラーが存在するかどうか
           MOVE    ZERO                TO  FLG-ERRARI
           MOVE    ZERO                TO  FLG-DATAEND
      *
      *    入力コードＣＳＶファイルに存在する項目数分、繰り返す
      *    またはレコード終了、またはエラー発生まで
           PERFORM     VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX           >   20   )
                       OR      ( WRK-PO-ED     >=  3000 )
                       OR      ( FLG-ERRARI NOT =  ZERO )
      *
               MOVE    ZERO            TO  FLG-AREA1
               MOVE    IDX             TO  WRK-KOUMOKU-NO
               COMPUTE     WRK-PO-ST   =   WRK-PO-ED   +   1
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
                       PERFORM 290-ERRREC-EDIT-SEC
                       MOVE    1       TO  FLG-ERRARI
                       PERFORM 2950-ERRLST-OUT-SEC
                   END-IF
               ELSE
                   PERFORM 290-ERRREC-EDIT-SEC
                   MOVE    1           TO  FLG-ERRARI
                   PERFORM 2950-ERRLST-OUT-SEC
               END-IF
      *
      *
           END-PERFORM
      *
      *    ＣＳＶファイル　検索処理
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
                       UNTIL   ( IDY           >=  3000 )
                       OR      ( FLG-COMMA     =   1    )
      *        カンマの位置
               IF  ( CSV-X (IDY)       =   ","  )   OR
                   ((IDX               =   20   )  AND
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
           IF  WRK-MO-CNT              =   1            AND
      *        Cr(MS-DOS)
               CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   X"0D"
               MOVE  1                 TO  FLG-NODATA
           END-IF
      *D     IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
      *D                                 =   SPACE
      *D         MOVE  1                 TO  FLG-NODATA
      *D     END-IF
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
      *        １：診療コード
               WHEN    1
      *        １４：レセプト電算コード
               WHEN    14
      *        １６：入力コード１
               WHEN    16
      *
                   MOVE    1           TO  FLG-ERR
      *
               WHEN    OTHER
                   CONTINUE
               END-EVALUATE
           END-IF
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
      *    １：診療コード
           WHEN    1
               CONTINUE
      *    １４：レセプト電算コード
           WHEN    14
               PERFORM 2410-SRYCD-SET-SEC
      *    １６：入力コード１
           WHEN    16
      *    １７：入力コード２
           WHEN    17
      *    １８：入力コード３
           WHEN    18
      *    １９：入力コード４
           WHEN    19
      *    ２０：入力コード５
           WHEN    20
               PERFORM 2450-INPUTCD-SET-SEC
      *
           END-EVALUATE
      *
           .
       240-KOUMOKU-BETU-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１４：レセプト電算コード　処理
      *****************************************************************
       2410-SRYCD-SET-SEC              SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   9
                   MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  ICD-SRYCD
                   MOVE  ICD-SRYCD     TO  WRK-SRYCD
                   PERFORM 260-TENSU-EXIST-CHK-SEC
                   IF  FLG-TENSU       NOT = ZERO
                       MOVE    5       TO  FLG-ERR
                   END-IF   
               ELSE
                   MOVE    2           TO  FLG-ERR
               END-IF
           END-IF
      *
           .
       2410-SRYCD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１６−２０：入力コード　処理
      *****************************************************************
       2450-INPUTCD-SET-SEC            SECTION.
      *
           MOVE    SPACE               TO  WRK-INPUTCD
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT         <=   20
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-INPUTCD
                   PERFORM 250-CDSYU-SET-SEC
                   IF  FLG-ERR         NOT = ZERO
                       GO      TO      2450-INPUTCD-SET-EXT
                   ELSE
                       MOVE    SPA-HOSPID  TO  ICD-HOSPID
                       MOVE    WRK-INPUTCD TO  ICD-INPUTCD
                       MOVE    WRK-CDSYU   TO  ICD-CDSYU
                       PERFORM 270-DSPSEQ-SET-SEC
                       IF  FLG-ERR     NOT =   ZERO
                           GO      TO  2450-INPUTCD-SET-EXT
                       ELSE
                           PERFORM     280-ICD-INSERT-SEC
                       END-IF
                   END-IF
               ELSE
                   MOVE    2           TO  FLG-ERR
               END-IF
           END-IF
      *
           .
       2450-INPUTCD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    コード種別　処理
      *****************************************************************
       250-CDSYU-SET-SEC               SECTION.
      *
           MOVE    ZERO                TO  WRK-NUMCNT
           MOVE    ZERO                TO  WRK-SPCFLG
      *
           PERFORM VARYING    IDZ      FROM    1   BY  1
                   UNTIL      IDZ      >=  20
      *
               IF  WRK-INPUTCD(IDZ:1)      NOT =     SPACE
                   IF  WRK-SPCFLG              =   1
                       MOVE    2           TO  FLG-ERR 
                       GO      TO          250-CDSYU-SET-EXT
                   END-IF
                   IF  WRK-INPUTCD(IDZ:1)  =   "P"   OR
                       WRK-INPUTCD(IDZ:1)  =   "S"
                       MOVE    2           TO  FLG-ERR 
                       GO      TO          250-CDSYU-SET-EXT
                   END-IF
      *
                   IF
      *    全角カタカナ
                       WRK-INPUTCD(IDZ:1)  =   X"A5" OR
      *    全角英数字
                       WRK-INPUTCD(IDZ:1)  =   X"A3" OR
      *    全角記号
                       WRK-INPUTCD(IDZ:1)  =   X"A1"
                       MOVE    "J"         TO  WRK-CDSYU
                       GO      TO          250-CDSYU-SET-EXT
                   END-IF
      *
      *    半角英数字
                   IF  WRK-INPUTCD(IDZ:1)  =   "0"   OR
                       WRK-INPUTCD(IDZ:1)  =   "1"   OR
                       WRK-INPUTCD(IDZ:1)  =   "2"   OR
                       WRK-INPUTCD(IDZ:1)  =   "3"   OR
                       WRK-INPUTCD(IDZ:1)  =   "4"   OR
                       WRK-INPUTCD(IDZ:1)  =   "5"   OR
                       WRK-INPUTCD(IDZ:1)  =   "6"   OR
                       WRK-INPUTCD(IDZ:1)  =   "7"   OR
                       WRK-INPUTCD(IDZ:1)  =   "8"   OR
                       WRK-INPUTCD(IDZ:1)  =   "9"
                       ADD 1               TO  WRK-NUMCNT
                   ELSE
                       MOVE    "A"         TO  WRK-CDSYU
                       GO      TO          250-CDSYU-SET-EXT
                   END-IF
      *
               ELSE
      *
                   EVALUATE    WRK-NUMCNT
                   WHEN 0
                       CONTINUE
      *    半角数字（４桁）
                   WHEN 4
                       MOVE    "4"         TO  WRK-CDSYU
                       MOVE    1           TO  WRK-SPCFLG
      *    半角数字（５桁）
                   WHEN 5
                       MOVE    "5"         TO  WRK-CDSYU
                       MOVE    1           TO  WRK-SPCFLG
      *    半角数字（６桁）
                   WHEN 6
                       MOVE    "6"         TO  WRK-CDSYU
                       MOVE    1           TO  WRK-SPCFLG
      *
                   WHEN OTHER
                       MOVE    2           TO  FLG-ERR 
                       GO      TO          250-CDSYU-SET-EXT
                   END-EVALUATE
               END-IF
           END-PERFORM
           .
       250-CDSYU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    表示連番　処理
      *****************************************************************
       270-DSPSEQ-SET-SEC              SECTION.
      *
           MOVE    INPUTCD-REC         TO MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "INPUTCD-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-INPUTCD
               MOVE    "INPUTCD-KEY2"  TO  ORC-DBPATH
               PERFORM 9410-INPUTCD-CHCK-SEC
           ELSE
               MOVE    1               TO  FLG-INPUTCD
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "INPUTCD-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      FLG-INPUTCD         =   ZERO
      *
               MOVE    INPUTCD-REC     TO  MCPDATA-REC
               MOVE    "DBSELECT"      TO  MCP-FUNC
               MOVE    "INPUTCD-KEY4"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"  USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
               MOVE    ZERO            TO  WRK-DSPSEQ
      *
               IF      MCP-RC          =   ZERO
                   MOVE    ZERO        TO  FLG-SRYCD
                   MOVE    "INPUTCD-KEY4"  TO  ORC-DBPATH
                   PERFORM 940-INPUTCD-NEXT-SEC
                       UNTIL FLG-INPUTCD   =   1
               ELSE
                   MOVE    1           TO  FLG-SRYCD
               END-IF
      *
               ADD     1               TO  WRK-DSPSEQ
      *
               MOVE    "DBCLOSE"       TO  MCP-FUNC
               MOVE    "INPUTCD-KEY4"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"  USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           ELSE
                   MOVE    6           TO  FLG-ERR
                   GO      TO          270-DSPSEQ-SET-EXT
      *
           END-IF
      *
      *
           .
       270-DSPSEQ-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ存在チェック
      *****************************************************************
       260-TENSU-EXIST-CHK-SEC         SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    ICD-SRYCD           TO  TNS-SRYCD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSU-KEY"     TO  ORC-DBPATH
               PERFORM 930-TENSU-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TESNSU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
       260-TENSU-EXIST-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コードマスタ　登録処理
      *****************************************************************
       280-ICD-INSERT-SEC              SECTION.
      *
      *    DISPLAY "[ INPUT CD debug, DBINSERT DATA]"
      *    DISPLAY "SPA-HOSPID : "     SPA-HOSPID
      *    DISPLAY "WRK-CDSYU  : "     WRK-CDSYU
      *    DISPLAY "WRK-INPUTCD: "     WRK-INPUTCD
      *    DISPLAY "WRK-SRYCD  : "     WRK-SRYCD
      *    DISPLAY "WRK-DSPSEQ : "     WRK-DSPSEQ
      *    DISPLAY "SPA-TERMID : "     SPA-TERMID
      *    GO      TO                  280-ICD-INSERT-EXT
      *
           MOVE    SPA-HOSPID          TO  ICD-HOSPID
           MOVE    WRK-CDSYU           TO  ICD-CDSYU
           MOVE    WRK-INPUTCD         TO  ICD-INPUTCD
           MOVE    SPACE               TO  ICD-SRYKBN
           MOVE    WRK-SRYCD           TO  ICD-SRYCD
           MOVE    WRK-DSPSEQ          TO  ICD-DSPSEQ
           MOVE    SPACE               TO  ICD-DSPNAME
           MOVE    SPA-TERMID          TO  ICD-TERMID
           MOVE    SPACE               TO  ICD-OPID
           MOVE    SPACE               TO  ICD-CREYMD
           MOVE    SPACE               TO  ICD-UPYMD
           MOVE    SPACE               TO  ICD-UPHMS
      *
           MOVE    INPUTCD-REC         TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
                MOVE    6              TO  FLG-ERR
                GO      TO             280-ICD-INSERT-EXT
           END-IF
           ADD     1                   TO  CNT-ICD
      *
           .
       280-ICD-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集処理
      *****************************************************************
       290-ERRREC-EDIT-SEC             SECTION.
      *
           IF  FLG-ERR                 <=  3
               ADD     1               TO  IDE
               IF  IDE                 >   1
                   GO      TO          290-ERRREC-EDIT-EXT
               END-IF
               IF  IDE                     =   1
                   ADD     1               TO  CNT-ERR
                   MOVE    SPACE           TO  ERR-REC1
                   MOVE    CNT-ERR (1:3)   TO  ERR1-NO (1:3)
                   MOVE    ":"             TO  ERR1-NO (4:1)
                   MOVE    CNT-CSV         TO  ERR1-CSVLINE
               END-IF
           END-IF
      *
           EVALUATE    FLG-ERR
      *    必須項目未入力エラー
           WHEN    1
      *    項目エラー
           WHEN    2
      *
      *    WHEN    3
               PERFORM 2910-ERRREC-EDIT-BETU1-SEC
      *
      *    WHEN    4
      *    ＤＢエラー
           WHEN    5
      *    入力コードＤＢ出力エラー
           WHEN    6
               PERFORM 2910-ERRREC-EDIT-BETU2-SEC
           END-EVALUATE
      *
           .
       290-ERRREC-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集　別１　処理
      *****************************************************************
       2910-ERRREC-EDIT-BETU1-SEC      SECTION.
      *
      *    エラー内容番号転送
           MOVE    FLG-ERR (1:1)       TO  ERR1-ERRNO (IDE)(1:1)
           MOVE    ":"                 TO  ERR1-ERRNO (IDE)(2:1)
      *
      *    エラー項目名称転送
           EVALUATE    WRK-KOUMOKU-NO
      *    １：診療コード
           WHEN    1
               MOVE    "診療コード"            TO  ERR1-KOMOKU(IDE)
      *    １４：レセプト電算コード
           WHEN    14
               MOVE    "レセプト電算コード"    TO  ERR1-KOMOKU(IDE)
      *    １６：入力コード１
           WHEN    16
               MOVE    "入力コード１"          TO  ERR1-KOMOKU(IDE)
      *    １７：入力コード２
           WHEN    17
               MOVE    "入力コード２"          TO  ERR1-KOMOKU(IDE)
      *    １８：入力コード３
           WHEN    18
               MOVE    "入力コード３"          TO  ERR1-KOMOKU(IDE)
      *    １９：入力コード４
           WHEN    19
               MOVE    "入力コード４"          TO  ERR1-KOMOKU(IDE)
      *    ２０：入力コード５
           WHEN    20
               MOVE    "入力コード５"          TO  ERR1-KOMOKU(IDE)
      *
           END-EVALUATE
      *
      *    エラー値転送
           IF  WRK-MO-CNT          NOT =   ZERO
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  ERR1-ATAI  (IDE)(1:8)
           END-IF
      *
           .
       2910-ERRREC-EDIT-BETU1-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集　別２　処理
      *****************************************************************
       2910-ERRREC-EDIT-BETU2-SEC      SECTION.
      *
           ADD     1                   TO  CNT-ERR
           MOVE    SPACE               TO  ERR-REC2
           MOVE    CNT-ERR (1:3)       TO  ERR2-NO (1:3)
           MOVE    ":"                 TO  ERR2-NO (4:1)
           EVALUATE    FLG-ERR
      *    WHEN    4
      *        MOVE    CONS-MES4       TO  ERR2-MES
           WHEN    5
               MOVE    CONS-MES5       TO  ERR2-MES
               MOVE    ICD-SRYCD       TO  ERR2-SRYCD 
           WHEN    6
               MOVE    CONS-MES6       TO  ERR2-MES
               MOVE    ICD-SRYCD       TO  ERR2-SRYCD 
               MOVE    ICD-CDSYU       TO  ERR2-CDSYU 
               MOVE    ICD-INPUTCD     TO  ERR2-INPUTCD
           END-EVALUATE
      *
      * ToDo
      *
           .
       2910-ERRREC-EDIT-BETU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト出力処理
      *****************************************************************
       2950-ERRLST-OUT-SEC              SECTION.
      *
           IF  FLG-ERR                <=   3
               MOVE    ERR-REC1        TO      ERR-REC
               WRITE   ERR-REC
           ELSE
               MOVE    ERR-REC2        TO      ERR-REC
               WRITE   ERR-REC
           END-IF
      *
           .
       2950-ERRLST-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票出力　初期処理
      *****************************************************************
       2990-ERRLST-INIT-SEC            SECTION.
      *
           OPEN    OUTPUT              ERR-FILE
           IF  STS-LST             NOT =   ZERO
               MOVE    1               TO  FLG-CSV
               DISPLAY "*(ORCVTINPUTCD)* ERRFILE OPN STS[" STS-LST "]"
               GO      TO              2990-ERRLST-INIT-EXT
           END-IF
      *
           MOVE    MES-TITLE1      TO      ERR-REC
           WRITE   ERR-REC
           MOVE    MES-TITLE2      TO      ERR-REC
           WRITE   ERR-REC
      *
           .
       2990-ERRLST-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           MOVE    2                   TO  FLG-UPDATE
      *
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
      *    帳票出力　終了処理
           CLOSE                       CSV-FILE
           CLOSE                       ERR-FILE
      *
           DISPLAY "*(ORCVTINPUTCD)* CSV     /I CNT[" CNT-CSV      "]"
                                       UPON    CONSOLE
           DISPLAY "*(ORCVTINPUTCD)* INPUTCD /O CNT[" CNT-ICD      "]"
                                       UPON    CONSOLE
           DISPLAY "*(ORCVTINPUTCD)* ERR     /O CNT[" CNT-ERR      "]"
                                       UPON    CONSOLE
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
      *    点数マスタＦＥＴＣＨ処理
      *****************************************************************
       930-TENSU-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           .
       930-TENSU-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コードテーブルＦＥＴＣＨ処理
      *****************************************************************
       940-INPUTCD-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  INPUTCD-REC
               MOVE    ICD-DSPSEQ      TO  WRK-DSPSEQ
               MOVE    ZERO            TO  FLG-INPUTCD
           ELSE
               INITIALIZE                  INPUTCD-REC
               MOVE    1               TO  FLG-INPUTCD
           END-IF
      *
           .
       940-INPUTCD-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コードテーブルＦＥＴＣＨ処理  for EXIST_CHEK
      *****************************************************************
       9410-INPUTCD-CHCK-SEC               SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    1               TO  FLG-INPUTCD
           ELSE
               MOVE    ZERO            TO  FLG-INPUTCD
           END-IF
      *
           .
       9410-INPUTCD-CHCK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＳＶファイル検索処理
      *****************************************************************
       900-CSV-KENSAKU-SEC             SECTION.
      *
          MOVE    SPACE                TO  CSV-R
      *
          READ    CSV-FILE
              AT  END
                  MOVE    1            TO  FLG-CSV
              NOT AT  END
                  MOVE    ZERO         TO  FLG-CSV
                  ADD     1            TO  CNT-CSV
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
