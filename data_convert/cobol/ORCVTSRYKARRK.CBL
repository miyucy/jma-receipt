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
       PROGRAM-ID.                 ORCVTSRYKARRK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＤＢ作成処理
      *  コンポーネント名  : ＣＳＶファイルコンバート処理（診療科履歴・
      *                                                    初診算定日）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/01/24    NACL-多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
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
      *    入力受診日情報ＣＳＶファイル
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
      *    入力患者保険情報ＣＳＶファイル
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
           03  FLG-SRYKARRK            PIC 9(01).
           03  FLG-SANTEI              PIC 9(01).
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
           03  CNT-SRYKARRK            PIC 9(06).
           03  CNT-SANTEI              PIC 9(06).
           03  CNT-ERR                 PIC 9(03).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                     PIC 9(04).
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
           03  IDZ                     PIC 9(04).
           03  IDE                     PIC 9(04).
           03  IDX-T                   PIC 9(04).
           03  IDX-Y2                  PIC 9(02).
      *
      *    パラメータ保存
       01  PARA-SAVE.
           03  PARA-05-1               PIC X(02).
           03  PARA-06-1               PIC X(08).
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
               05  WRK-SRYKA           PIC X(02).
               05  WRK-SRYKA-9         REDEFINES   WRK-SRYKA
                                       PIC 9(02).
               05  WRK-LASTYMD         PIC X(08).
               05  WRK-SYOSINYMD       PIC X(08).
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
           03  WRK-HKNID               PIC 9(10).
           03  WRK-RENKETA             PIC 9(02).
           03  WRK-PTNUM               PIC X(20).
           03  WRK-CNT                 PIC 9(04). 
           03  WRK-DATA                PIC X(100).
           03  WRK-LEN                 PIC 9(03).
           03  WRK-NUM1                PIC 9(01).
           03  WRK-NUM2                PIC 9(02).
      *
           03  WRK-SRYCD               PIC X(09).
      *
       01  TBL-KENSAKU-AREA.
           03  TBL-KENSAKU-TBL     OCCURS   10.
               05  TBL-SRYKA           PIC X(02).
               05  TBL-SRYKA-9         REDEFINES   TBL-SRYKA
                                           PIC 9(02).
               05  TBL-LASTYMD         PIC X(08).
               05  TBL-SYOSINYMD       PIC X(08).
      *
      *    帳票出力領域
       01  MES-AREA.
           03  MES-TITLE1.
               05  FILLER              PIC X(26) VALUE
                                       "【PGID:ORCVTSRYKARRK.CBL】".
               05  MES-TITLE1-YY       PIC X(04) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-MM       PIC X(02) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-DD       PIC X(02) VALUE SPACE.
           03  MES-TITLE2.
               05  FILLER              PIC X(18) VALUE
                                                 "NO    ERR-MESSAGE/".
               05  FILLER              PIC X(73) VALUE
                   "ERRNO 1:必須未入力 2:項目桁数 3:誤入力 --------".
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
               05  ERR2-SRYKA          PIC X(02).
               05  FILLER              PIC X(01).
               05  ERR2-LASTYMD        PIC X(08).
               05  FILLER              PIC X(01).
               05  ERR2-SYOSINYMD      PIC X(08).
      *
      *    メッセージ領域
       01  CONS-AREA.
      *     03  CONS-MES1               PIC X(22) VALUE
      *         "必須項目未入力エラー".
      *     03  CONS-MES2               PIC X(22) VALUE
      *         "項目桁数エラー".
      *     03  CONS-MES3               PIC X(22) VALUE
      *         "誤入力エラー".
           03  CONS-MES4               PIC X(22) VALUE
               "患者番号ＤＢ取得エラー".
           03  CONS-MES5               PIC X(22) VALUE
               "日付未設定エラー".
           03  CONS-MES6               PIC X(22) VALUE
               "診療科履歴ＤＢ登録済み".
           03  CONS-MES7               PIC X(22) VALUE
               "初診算定日ＤＢ登録済み".
           03  CONS-MES8               PIC X(22) VALUE
               "診療科履歴ＤＢ出力エラー".
           03  CONS-MES9               PIC X(22) VALUE
               "算定履歴ＤＢ出力エラー".
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    システム管理（医療機関情報）
           COPY    "CPSK1001.INC".
      *    システム管理（患者番号構成管理）
           COPY    "CPSK1009.INC".
      *    診療科履歴
       01  SRYKARRK-REC.
           COPY    "CPSRYKARRK.INC".
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
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
               DISPLAY "*(ORCVTSRYKARRK)* PTHKN-FILE OPN STS["
                                       STS-CSV "]"
               GO      TO          100-INIT-EXT
           END-IF
      *    帳票出力　初期処理
           PERFORM 2710-ERRLST-INIT-SEC
           IF  FLG-CSV             =   1
               GO  TO              100-INIT-EXT
           END-IF
      *
           MOVE    PARA-05-1       TO  WRK-RENKETA(1:2)
      *
      *    ＣＳＶファイル　検索処理
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
           OPEN    INPUT           PARA-FILE
           IF      STS-PARA        NOT =   ZERO
               MOVE    2               TO  FLG-PARA
               DISPLAY "*(ORCVTSRYKARRK)* PARA-FILE OPN STS["
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
             WHEN  "01-2"
                   MOVE  PARA-DATA TO  ASS-CSV
             WHEN  "02-2"
                   MOVE  PARA-DATA TO  ASS-ERR
             WHEN  "05-1"
                   MOVE  PARA-DATA TO  PARA-05-1
             WHEN  "06-1"
                   MOVE  PARA-DATA TO  PARA-06-1
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
               DISPLAY "***(ORCVTSRYKARRK)*** CNT-CSV[" CNT-CSV "]"
           END-IF
           MOVE    ZERO                TO  WRK-POINT-AREA
           MOVE    ZERO                TO  IDX-AREA
           MOVE    SPACE               TO  SPA-PTNUM
           MOVE    ZERO                TO  SPA-PTID
           INITIALIZE                  WRK-KENSAKU-AREA
           INITIALIZE                  TBL-KENSAKU-AREA
      *    対象患者にエラーが存在するかどうか
           MOVE    ZERO                TO  FLG-ERRARI
           MOVE    ZERO                TO  FLG-DATAEND
      *
      *    患者保険ＣＳＶファイルに存在する項目数分、繰り返す
      *    またはレコード終了、または項目エラー４個まで
           PERFORM     VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX           >   17   )
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
           IF  FLG-ERRARI              =   ZERO
      *        マスタ更新処理
               PERFORM 250-KOUSIN-SYORI-SEC
               IF  FLG-ERR         NOT =   ZERO
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
                       UNTIL   ( IDY           >=  300  )
                       OR      ( FLG-COMMA     =   1    )
      *        カンマの位置
               IF  ( CSV-X (IDY)       =   ","   )  OR
                   ((IDX               =   17   )  AND
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
      *        ２：診療科
               WHEN    2
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
      *    １：患者番号
           WHEN    1
               PERFORM 2410-PTNUM-SET-SEC
      *    ２：診療科
           WHEN    2
               MOVE    1               TO  IDX-T
               PERFORM 2410-SRYKA-SET-SEC
      *    ３：前回受診歴１
           WHEN    3
               MOVE    1               TO  IDX-T
               PERFORM 2410-LASTYMD-SET-SEC
      *    ４：初診算定日
           WHEN    4
               MOVE    1               TO  IDX-T
               PERFORM 2410-SYOSINYMD-SET-SEC
      *    ５：診療科
           WHEN    5
               MOVE    2               TO  IDX-T
               PERFORM 2410-SRYKA-SET-SEC
      *    ６：前回受診歴１
           WHEN    6
               MOVE    2               TO  IDX-T
               PERFORM 2410-LASTYMD-SET-SEC
      *    ７：初診算定日
           WHEN    7
               MOVE    2               TO  IDX-T
               PERFORM 2410-SYOSINYMD-SET-SEC
      *    ８：診療科
           WHEN    8
               MOVE    3               TO  IDX-T
               PERFORM 2410-SRYKA-SET-SEC
      *    ９：前回受診歴１
           WHEN    9
               MOVE    3               TO  IDX-T
               PERFORM 2410-LASTYMD-SET-SEC
      *    10：初診算定日
           WHEN    10
               MOVE    3               TO  IDX-T
               PERFORM 2410-SYOSINYMD-SET-SEC
      *
           END-EVALUATE
      *
           .
       240-KOUMOKU-BETU-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目空白処理
      *****************************************************************
       2401-SPACE-HENSYU-SEC              SECTION.
      *
           MOVE    ZERO                   TO  WRK-LEN
      *
           IF      WRK-DATA               =   SPACE
               MOVE    1                      TO  WRK-LEN
           ELSE         
               PERFORM VARYING IDE FROM    100 BY  -1
                       UNTIL   IDE <       1
                   IF      WRK-DATA (IDE:1)    NOT =   SPACE
                       MOVE    IDE              TO  WRK-LEN
                       MOVE    1                TO  IDE
                   END-IF     
               END-PERFORM
      *
               IF      WRK-LEN             >   1
                   COMPUTE IDW     =   WRK-LEN     -   1
                   IF      WRK-DATA (IDW:2)    =   "　"
                       MOVE    1                   TO  WRK-LEN
                       PERFORM VARYING IDE FROM    IDW BY  -2
                               UNTIL   IDE  < 2
                           IF      WRK-DATA (IDE:2)    NOT =   "　"
                               COMPUTE WRK-LEN     =   IDE     +   1
                               MOVE    2                TO  IDE
                           ELSE
                               IF  IDE = 3 
                                   IF  WRK-DATA (1:2)    NOT =   "　"
                                       MOVE    2   TO  WRK-LEN
                                   END-IF
                               END-IF
                           END-IF
                       END-PERFORM      
                   END-IF         
               END-IF
           END-IF            
      *
           .
       2401-SPACE-HENSYU-EXT.
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
      *    項目２：診療科処理
      *****************************************************************
       2410-SRYKA-SET-SEC         SECTION.
      *
           EVALUATE    WRK-MO-CNT
               WHEN    1
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                               TO  WRK-NUM1
                   MOVE    WRK-NUM1            TO  TBL-SRYKA-9(IDX-T)
               WHEN    2
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                               TO  WRK-NUM2
                   MOVE    WRK-NUM2            TO  TBL-SRYKA(IDX-T)
               WHEN    OTHER
                   MOVE    2                   TO  FLG-ERR
           END-EVALUATE
      *
           .
       2410-SRYKA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目３：最終受診日処理
      *****************************************************************
       2410-LASTYMD-SET-SEC         SECTION.
      *
           IF      WRK-MO-CNT          =   8
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  TBL-LASTYMD(IDX-T)
               IF     (TBL-LASTYMD(IDX-T)  NOT NUMERIC )  OR
                      (TBL-LASTYMD(IDX-T)      =   ALL "9")
                   MOVE    2                   TO  FLG-ERR
               END-IF
           ELSE
               MOVE    SPACE               TO  TBL-LASTYMD(IDX-T)
           END-IF
      *
           .
       2410-LASTYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目３：初診算定日
      *****************************************************************
       2410-SYOSINYMD-SET-SEC             SECTION.
      *
           IF      WRK-MO-CNT          =   8
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  TBL-SYOSINYMD(IDX-T)
               IF     (TBL-SYOSINYMD(IDX-T) NOT NUMERIC )  OR
                      (TBL-SYOSINYMD (IDX-T)    =   ALL "9")
                   MOVE    2                   TO  FLG-ERR
               END-IF
           ELSE
               MOVE    SPACE               TO  TBL-SYOSINYMD(IDX-T)
           END-IF
      *
           .
       2410-SYOSINYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    マスタ更新処理
      *****************************************************************
       250-KOUSIN-SYORI-SEC            SECTION.
      *
      *    患者番号より患者ＩＤを求める
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
                MOVE    4              TO  FLG-ERR
                GO      TO             250-KOUSIN-SYORI-EXT
           ELSE
      *        患者番号変換マスタより転送
               MOVE    PTNUM-PTID      TO  SPA-PTID
           END-IF
      *
           INITIALIZE                  WRK-KENSAKU-AREA
           PERFORM VARYING     IDX-T   FROM    1   BY  1
                   UNTIL       IDX-T   >   10
               IF      TBL-SRYKA (IDX-T)   NOT =   SPACE
                   IF      TBL-SYOSINYMD(IDX-T)    =   SPACE
                       MOVE    TBL-LASTYMD(IDX-T)
                                           TO  TBL-SYOSINYMD(IDX-T)
                   END-IF
               END-IF
           END-PERFORM
      *
           PERFORM VARYING     IDX-T   FROM    1   BY  1
                   UNTIL       IDX-T   >   10
               IF      TBL-SRYKA (IDX-T)   NOT =   SPACE
                   IF      TBL-LASTYMD (IDX-T)     >   WRK-LASTYMD
                       MOVE    TBL-SRYKA (IDX-T)   TO  WRK-SRYKA
                       MOVE    TBL-LASTYMD(IDX-T)  TO  WRK-LASTYMD
                       MOVE    TBL-SYOSINYMD(IDX-T)    TO  WRK-SYOSINYMD
                   END-IF
               END-IF
           END-PERFORM
      *
      *    日付がない時、作成しない
           IF     (WRK-LASTYMD         =   SPACE )  AND
                  (WRK-SYOSINYMD       =   SPACE )
               MOVE    5               TO  FLG-ERR
               GO      TO             250-KOUSIN-SYORI-EXT
           END-IF
      *    初診日が最終受診日より後の時
           IF      WRK-SYOSINYMD       >   WRK-LASTYMD
               MOVE    WRK-SYOSINYMD       TO  WRK-LASTYMD
           END-IF
      *
      *    診療科履歴作成
           PERFORM 260-SRYKARRK-INSERT-SEC
           IF      FLG-ERR         NOT =   ZERO
               GO      TO             250-KOUSIN-SYORI-EXT
           END-IF
      *    初診算定日
           IF      WRK-SYOSINYMD   NOT =   SPACE
               PERFORM 270-SANTEIRRK-INSERT-SEC
           END-IF
           .
       250-KOUSIN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科履歴作成登録処理
      *****************************************************************
       260-SRYKARRK-INSERT-SEC            SECTION.
      *
      *    診療科履歴読込
           MOVE    SPACE               TO  SRYKARRK-REC
           INITIALIZE                      SRYKARRK-REC
           MOVE    SPA-HOSPID          TO  KARRK-HOSPID
           MOVE    SPA-PTID            TO  KARRK-PTID
           MOVE    WRK-SRYKA           TO  KARRK-SRYKA
      *
           MOVE    SRYKARRK-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYKARRK-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYKARRK-KEY"      TO  ORC-DBPATH
               PERFORM 910-SRYKARRK-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYKARRK
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYKARRK-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *    診療科新規作成
           IF      FLG-SRYKARRK        =   ZERO
               MOVE    6               TO  FLG-ERR
               GO      TO              260-SRYKARRK-INSERT-EXT
           END-IF
      *    新規作成
           MOVE    SPACE               TO  SRYKARRK-REC
           INITIALIZE                      SRYKARRK-REC
           MOVE    SPA-HOSPID          TO  KARRK-HOSPID
           MOVE    SPA-PTID            TO  KARRK-PTID
           MOVE    WRK-SRYKA           TO  KARRK-SRYKA
      *    最終受診日
           MOVE    WRK-LASTYMD         TO  KARRK-LASTYMD
      *    初診日１
           MOVE    WRK-SYOSINYMD       TO  KARRK-SYOSINYMD1
      *    初診日２
           MOVE    WRK-SYOSINYMD       TO  KARRK-SYOSINYMD2
      *
      *    診療科履歴作成
           MOVE    SRYKARRK-REC        TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "SRYKARRK-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
                MOVE    9              TO  FLG-ERR
                GO      TO             260-SRYKARRK-INSERT-EXT
           END-IF
           ADD     1                   TO  CNT-SRYKARRK
      *
           .
       260-SRYKARRK-INSERT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    初診算定履歴登録処理
      *****************************************************************
       270-SANTEIRRK-INSERT-SEC            SECTION.
      *
      *    仮の初診料
           MOVE    "099110001"         TO  WRK-SRYCD
      *
           INITIALIZE                  SANTEI-REC
           MOVE    SPA-HOSPID          TO  SANTEI-HOSPID
           MOVE    SPA-PTID            TO  SANTEI-PTID
           MOVE    WRK-SYOSINYMD(1:6)  TO  SANTEI-SRYYM
           MOVE    WRK-SRYCD           TO  SANTEI-SRYCD
           MOVE    ZERO                TO  SANTEI-NYUGAIKBN
           MOVE    ZERO                TO  SANTEI-SRYKA
      *
           MOVE    SANTEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SANTEI-KEY"       TO  ORC-DBPATH
               PERFORM 920-SANTEI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SANTEI
           END-IF
           IF      FLG-SANTEI          =   ZERO
                MOVE    7              TO  FLG-ERR
                GO      TO             270-SANTEIRRK-INSERT-EXT
           END-IF
      *
      *    作成
           INITIALIZE                  SANTEI-REC
           MOVE    SPA-HOSPID          TO  SANTEI-HOSPID
           MOVE    SPA-PTID            TO  SANTEI-PTID
           MOVE    WRK-SYOSINYMD(1:6)  TO  SANTEI-SRYYM
           MOVE    WRK-SRYCD           TO  SANTEI-SRYCD
           MOVE    ZERO                TO  SANTEI-NYUGAIKBN
           MOVE    ZERO                TO  SANTEI-SRYKA
           MOVE    ZERO                TO  SANTEI-HKNCOMBINUM
      *    初回算定日
           MOVE    WRK-SYOSINYMD       TO  SANTEI-FSANTEIYMD
           MOVE    WRK-SYOSINYMD(7:2)  TO  SANTEI-MSANTEID
      *    当月算定歴回数
           MOVE    1                   TO  SANTEI-MSANTEICNT
      *    当日算定日
           MOVE    WRK-SYOSINYMD(7:2)  TO  IDX-Y2
           MOVE    1                   TO  SANTEI-DAY (IDX-Y2)
      *
           MOVE    SANTEI-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
                MOVE    8              TO  FLG-ERR
                GO      TO             270-SANTEIRRK-INSERT-EXT
           END-IF
           ADD     1                   TO  CNT-SANTEI
      *
           .
       270-SANTEIRRK-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集処理
      *****************************************************************
       270-ERRREC-EDIT-SEC             SECTION.
      *
           IF  FLG-ERR                 <=  3
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
               PERFORM 2910-ERRREC-EDIT-BETU1-SEC
      *    番号ＤＢ取得エラー
           WHEN    4
      *    日付なしエラー
           WHEN    5
      *    受診履歴登録済みエラー
           WHEN    6
      *    初診算定登録済みエラー
           WHEN    7
      *    患者保険ＤＢ出力エラー
           WHEN    8
      *    患者保険ＤＢ出力エラー
           WHEN    9
               PERFORM 2910-ERRREC-EDIT-BETU2-SEC
      *    文字化けエラー
      *****WHEN    7
      *****    PERFORM 2910-ERRREC-EDIT-BETU1-SEC
           END-EVALUATE
      *
           .
       270-ERRREC-EDIT-EXT.
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
      *    １：患者番号
           WHEN    1
               MOVE    "患者番号"      TO  ERR1-KOMOKU(IDE)
      *    ２：レコード番号（保険番号）
           WHEN    2
               MOVE    "診療科"        TO  ERR1-KOMOKU(IDE)
      *    ３：法別番号
           WHEN    3
               MOVE    "最終受診日"    TO  ERR1-KOMOKU(IDE)
      *    ４：保険者番号
           WHEN    4
               MOVE    "初診算定日"    TO  ERR1-KOMOKU(IDE)
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
           WHEN    4
               MOVE    CONS-MES4       TO  ERR2-MES
           WHEN    5
               MOVE    CONS-MES5       TO  ERR2-MES
           WHEN    6
               MOVE    CONS-MES6       TO  ERR2-MES
           WHEN    7
               MOVE    CONS-MES7       TO  ERR2-MES
           WHEN    8
               MOVE    CONS-MES8       TO  ERR2-MES
           WHEN    9
               MOVE    CONS-MES9       TO  ERR2-MES
           END-EVALUATE
           MOVE    SPA-PTNUM           TO  ERR2-PTNUM
           IF      SPA-PTID        NOT =   ZERO
               MOVE    SPA-PTID        TO  ERR2-PTID
           END-IF
           MOVE    WRK-SRYKA           TO  ERR2-SRYKA
           MOVE    WRK-LASTYMD         TO  ERR2-LASTYMD
           MOVE    WRK-SYOSINYMD       TO  ERR2-SYOSINYMD
      *
           .
       2910-ERRREC-EDIT-BETU2-EXT.
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
      *    帳票出力　初期処理
      *****************************************************************
       2710-ERRLST-INIT-SEC            SECTION.
      *
           OPEN    OUTPUT              ERR-FILE
           IF  STS-LST             NOT =   ZERO
               MOVE    1               TO  FLG-CSV
               DISPLAY "*(ORCVTSRYKARRK)* ERRFILE OPN STS[" STS-LST "]"
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
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *    帳票出力　終了処理
           CLOSE                       CSV-FILE
           CLOSE                       ERR-FILE
      *
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
      *
           DISPLAY "*(ORCVTSRYKARRK)* CSV     /I CNT[" CNT-CSV      "]"
           DISPLAY "*(ORCVTSRYKARRK)* SRYKARRK/O CNT[" CNT-SRYKARRK "]"
           DISPLAY "*(ORCVTSRYKARRK)* SANTEI  /O CNT[" CNT-SANTEI   "]"
           DISPLAY "*(ORCVTSRYKARRK)* ERR     /O CNT[" CNT-ERR      "]"
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
      *
      *****************************************************************
      *    算定歴マスタ読み込み
      *****************************************************************
       920-SANTEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SANTEI-REC
               MOVE    ZERO                TO  FLG-SANTEI
           ELSE
               INITIALIZE                      SANTEI-REC
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           .
       920-SANTEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科歴データ主キー検索
      *****************************************************************
       910-SRYKARRK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYKARRK-REC
               MOVE    ZERO                TO  FLG-SRYKARRK
           ELSE
               MOVE    1                   TO  FLG-SRYKARRK
               INITIALIZE                  SRYKARRK-REC
           END-IF
      *
           .
       910-SRYKARRK-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者保険ＣＳＶファイル　検索処理
      *****************************************************************
       900-CSV-KENSAKU-SEC            SECTION.
      *
          MOVE    SPACE               TO  CSV-R
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
