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
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-伊藤     01/09/26  記号の末尾のピリオドを取る 
      *  01.00.02    MCC-藤原     01/11/01  患者番号の空白までで桁数
      *                                     を編集  
      *  01.00.03    MCC-藤原     01/11/01  氏名・かな氏名を空白まで
      *                                     を編集  
      *  01.00.04    MCC-伊藤     01/12/12  患者番号構成に合わせて
      *                                     前０詰め編集を行う  
      *  01.00.05    MCC-伊藤     01/12/12  ＤＢコールインターフェイス
      *                                     の変更
      *  01.00.06    MCC-藤原     02/01/07  適用開始年月日の編集修正
      ************************************  OpenCOBOL対応
      *  01.00.07    MCC-伊藤     02/02/14  文字と数字の変換
      *  01.00.08    MCC-森脇     02/05/01  空白編集の変更  
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
           03  FLG-PTHKNINF            PIC 9(01).
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
           03  CNT-PTHKNINF            PIC 9(06).
           03  CNT-PTNUM               PIC 9(06).
           03  CNT-ERR                 PIC 9(03).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                     PIC 9(04).
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
           03  IDZ                     PIC 9(04).
           03  IDE                     PIC 9(04).
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
           03  WRK-HKNID               PIC 9(10).
           03  WRK-RENKETA             PIC 9(02).
           03  WRK-PTNUM               PIC X(20).
           03  WRK-CNT                 PIC 9(04). 
           03  WRK-DATA                PIC X(100).
           03  WRK-LEN                 PIC 9(03).
           03  WRK-NUM1                PIC 9(01).
           03  WRK-NUM2                PIC 9(02).
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
               05  ERR2-HKNNUM         PIC X(03).
               05  FILLER              PIC X(01).
               05  ERR2-HKNID          PIC X(10).
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
               "患者番号ＤＢ出力エラー".
           03  CONS-MES6               PIC X(22) VALUE
               "患者保険ＤＢ出力エラー".
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
               DISPLAY "*(ORCVTPTHKNINF)* PTHKN-FILE OPN STS["
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
           MOVE    ZERO                TO  FLG-PARA
           OPEN    INPUT           PARA-FILE
           IF      STS-PARA        NOT =   ZERO
               MOVE    2               TO  FLG-PARA
               DISPLAY "*(ORCVTPTHKNINF)* PARA-FILE OPN STS["
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
               DISPLAY "***(ORCVTPTHKNINF)*** CNT-CSV[" CNT-CSV "]"
           END-IF
           MOVE    SPACE               TO  PTHKN-REC
           INITIALIZE                      PTHKN-REC
           MOVE    ZERO                TO  WRK-POINT-AREA
           MOVE    ZERO                TO  IDX-AREA
           MOVE    ZERO                TO  WRK-HKNID
           MOVE    SPACE               TO  SPA-PTNUM
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
      * 記号の文字化けエラーは警告とする
               IF  FLG-ERRARI              =   1    AND
                   FLG-ERR                 =   7
                   PERFORM 270-ERRLST-OUT-SEC
                   MOVE    ZERO            TO  FLG-ERR
                   MOVE    ZERO            TO  FLG-ERRARI
               END-IF
      *
           END-PERFORM
      *
           IF  FLG-ERRARI              =   ZERO
      *        患者番号変換マスタ更新処理
               PERFORM 250-PTNUM-UPDATE-SEC
               IF  FLG-ERR             =   ZERO
      *            患者保険マスタ　更新処理
                   PERFORM 260-PTHKNINF-INSERT-SEC
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
      *        ２：レコード番号（保険番号）
               WHEN    2
      *        ３：法別番号
               WHEN    3
      **        ４：保険者番号
      *         WHEN    4
      *        ５：本人家族区分
               WHEN    5
      **        ６：補助区分
      *         WHEN    6
      **        ７：継続区分
      *         WHEN    7
      **        ８：記号
      *         WHEN    8
      **        ９：番号
      *         WHEN    9
      **        １１：外来負担率（％）
      *         WHEN    11
      **        １２：入院負担率（％）
      *         WHEN    12
      **        １３：適用開始日
      *         WHEN    13
      **        １４：適用終了日
      *         WHEN    14
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
      *    ２：レコード番号（保険番号）
           WHEN    2
               PERFORM 2410-RECORD-HKN-SET-SEC
      *    ３：法別番号
           WHEN    3
               PERFORM 2410-HBTNUM-SET-SEC
      *    ４：保険者番号
           WHEN    4
               PERFORM 2410-HKNJANUM-SET-SEC
      *    ５：本人家族区分
           WHEN    5
               PERFORM 2410-HONKZKKBN-SET-SEC
      *    ６：補助区分
           WHEN    6
               PERFORM 2410-HOJOKBN-SET-SEC
      *    ７：継続区分
           WHEN    7
               PERFORM 2410-CONTKBN-SET-SEC
      *    ８：記号
           WHEN    8
               PERFORM 2410-KIGO-SET-SEC
      *    ９：番号
           WHEN    9
               PERFORM 2410-NUM-SET-SEC
      *    １０：被保険者氏名
           WHEN    10
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTHKN-HIHKNJANAME
               END-IF
      **    １１：外来負担率（％）
      *     WHEN    11
      **    １２：入院負担率（％）
      *     WHEN    12
      *         CONTINUE
      *    １３：適用開始日
           WHEN    13
               PERFORM 2410-TEKSTYMD-SET-SEC
      *    １４：適用終了日
           WHEN    14
               PERFORM 2410-TEKEDYMD-SET-SEC
      *    １５：保険確認日
           WHEN    15
               PERFORM 2410-KAKUNINYMD-SET-SEC
      *    １６：登録日
           WHEN    16
               PERFORM 2410-CREYMD-SET-SEC
      *    １７：更新日
           WHEN    17
               PERFORM 2410-UPYMD-SET-SEC
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
      *    項目２：レコード番号（保険番号）　処理
      *****************************************************************
       2410-RECORD-HKN-SET-SEC         SECTION.
      *
           IF  WRK-MO-CNT              =   1  OR  2
      *
               IF  ( CSV-REC (WRK-MO-ST:WRK-MO-CNT) IS  NUMERIC  ) AND
                   ( CSV-REC (WRK-MO-ST:WRK-MO-CNT) NOT =   ZERO )
      *            MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
      *                                TO  WRK-HKNID
      *            MOVE    WRK-HKNID   TO  PTHKN-HKNID
                   IF      WRK-MO-CNT  =   1
                     MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-NUM1
                     MOVE  WRK-NUM1    TO  PTHKN-HKNID
                   ELSE
                     MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-NUM2
                     MOVE  WRK-NUM2    TO  PTHKN-HKNID
                   END-IF  
               ELSE
                   MOVE    3           TO  FLG-ERR
                   GO      TO          2410-RECORD-HKN-SET-EXT
               END-IF
           ELSE
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-RECORD-HKN-SET-EXT
           END-IF
      *
           .
       2410-RECORD-HKN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目３：法別番号
      *****************************************************************
       2410-HBTNUM-SET-SEC             SECTION.
      *
           IF  WRK-MO-CNT              =   2
      *
               IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "01"  OR  "02"  OR  "03"
                                       OR  "04"  OR  "06"  OR  "07"
                                       OR  "31"  OR  "32"  OR  "33"
                                       OR  "34"  OR  "63"  OR  "72"
                                       OR  "73"  OR  "74"  OR  "75"
                                       OR  "60"  OR  "67"
                                       OR  "98"  OR  "99"
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
      *    労災？？→保険番号不確定
           WHEN    "98"
               MOVE    "971"           TO  PTHKN-HKNNUM
      *    自費
           WHEN    "99"
               MOVE    "980"           TO  PTHKN-HKNNUM
      *
           WHEN    OTHER
               MOVE    "0"             TO  PTHKN-HKNNUM (1:1)
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-HKNNUM (2:2)
           END-EVALUATE
      *
           .
       2410-HBTNUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目４：保険者番号　処理
      *****************************************************************
       2410-HKNJANUM-SET-SEC           SECTION.
      *
           EVALUATE    PTHKN-HKNNUM
      *    自費
           WHEN    "980"
      *    労災
           WHEN    "971"
               IF  FLG-NODATA          =   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-HKNJANUM
               END-IF
      *
           WHEN    OTHER
      *コメント START --------------------------
      **        自費・労災以外は必須入力
      *         IF  FLG-NODATA          =   1
      *             MOVE    1           TO  FLG-ERR
      *             GO      TO          2410-HKNJANUM-SET-EXT
      *         ELSE
      *コメント END   --------------------------
                   IF  WRK-MO-CNT      <=  8
                       IF  WRK-MO-CNT  >   ZERO
                           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-HKNJANUM
                       END-IF
                   ELSE
                       MOVE    2       TO  FLG-ERR
                       GO      TO      2410-HKNJANUM-SET-EXT
                   END-IF
      *コメント START --------------------------
      *         END-IF
      *コメント END   --------------------------
           END-EVALUATE
      *
           .
       2410-HKNJANUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目５：本人家族区分　処理
      *****************************************************************
       2410-HONKZKKBN-SET-SEC          SECTION.
      *
           IF  WRK-MO-CNT              =   1
      *
               IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "1"  OR  "2"
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-HONKZKKBN
               ELSE
                   MOVE    3           TO  FLG-ERR
                   GO      TO          2410-HONKZKKBN-SET-EXT
               END-IF
           ELSE
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-HONKZKKBN-SET-EXT
           END-IF
      *
           .
       2410-HONKZKKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目６：補助区分　処理
      *****************************************************************
       2410-HOJOKBN-SET-SEC           SECTION.
      *
           IF  WRK-MO-CNT              =   1
      *
               EVALUATE    PTHKN-HKNNUM
      *        船員
               WHEN    "002"
                   IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "0" OR "1" OR "2" OR "3"
                       IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)  =   "0"
                           MOVE    SPACE          TO  PTHKN-HOJOKBN
                       ELSE
                           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                                  TO  PTHKN-HOJOKBN
                       END-IF
                   ELSE
                       MOVE    3       TO  FLG-ERR
                       GO      TO      2410-HOJOKBN-SET-EXT
                   END-IF
      *        国保
               WHEN    "060"
                   IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "0" OR "1" OR "2" OR "3"
                       MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                                  TO  PTHKN-HOJOKBN
                   ELSE
                       MOVE    3       TO  FLG-ERR
                       GO      TO      2410-HOJOKBN-SET-EXT
                   END-IF
      *        自費
               WHEN    "980"
                   IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           =   "1"  OR  "2"
                       MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  PTHKN-HOJOKBN
                   ELSE
      *                自費で補助区分ZEROの場合、課税の値("1")を転送
                       IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           =   ZERO
                           MOVE    "1"     TO  PTHKN-HOJOKBN
                       ELSE
                           MOVE    3       TO  FLG-ERR
                           GO      TO      2410-HOJOKBN-SET-EXT
                       END-IF
                   END-IF
      *        船員・国保・自費以外
               WHEN    OTHER
                   IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT) =   "0"
                       MOVE    SPACE   TO  PTHKN-HOJOKBN
                   ELSE
                       MOVE    3       TO  FLG-ERR
                       GO      TO      2410-HOJOKBN-SET-EXT
                   END-IF
               END-EVALUATE
           ELSE
      *コメント START --------------------------
      *         MOVE    2               TO  FLG-ERR
      *
               IF  WRK-MO-CNT          =   ZERO
                   EVALUATE    PTHKN-HKNNUM
      *            国保
                   WHEN    "060"
      *            自費
                   WHEN    "980"
                       MOVE    1       TO  FLG-ERR
      *            国保・自費以外
                   WHEN    OTHER
                       MOVE    SPACE   TO  PTHKN-HOJOKBN
                   END-EVALUATE
               ELSE
                   MOVE    2           TO  FLG-ERR
               END-IF
      *コメント END   --------------------------
               GO      TO              2410-HOJOKBN-SET-EXT
           END-IF
      *
           .
       2410-HOJOKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目７：継続区分　処理
      *****************************************************************
       2410-CONTKBN-SET-SEC            SECTION.
      *
           EVALUATE    WRK-MO-CNT
           WHEN    1
               IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "0"   OR   "1"  OR  "2"
                   IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "1"  OR  "2"
                       MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-CONTKBN
                   ELSE
                       MOVE    SPACE   TO  PTHKN-CONTKBN
                   END-IF
               ELSE
                   MOVE    3           TO  FLG-ERR
                   GO      TO          2410-CONTKBN-SET-EXT
               END-IF
      *コメント START --------------------------
           WHEN    ZERO
               MOVE    SPACE           TO  PTHKN-CONTKBN
      *コメント END   --------------------------
           WHEN    OTHER
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-CONTKBN-SET-EXT
           END-EVALUATE
      *
           .
       2410-CONTKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目８：記号　処理
      *****************************************************************
       2410-KIGO-SET-SEC               SECTION.
      *
      *---- (01.00.01) LINE ADD START --------------------------------
           IF  WRK-MO-CNT    >  ZERO
               COMPUTE WRK-MO-ST1  =  WRK-MO-ST
                                   +  WRK-MO-CNT
                                   -  2
               IF  CSV-REC (WRK-MO-ST1:2) = "．"
                   COMPUTE WRK-MO-CNT  =  WRK-MO-CNT
                                       -  2
               END-IF
           END-IF
      *---- (01.00.01) LINE ADD END   --------------------------------
           EVALUATE    PTHKN-HKNNUM
      *    自費
           WHEN    "980"
      *    労災
           WHEN    "971"
               IF  FLG-NODATA          =   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTHKN-KIGO
               END-IF
      *
           WHEN    OTHER
      *コメント START --------------------------
      **        自費・労災以外は必須入力
      *         IF  FLG-NODATA          =   1
      *             MOVE    1           TO  FLG-ERR
      *             GO      TO          2410-KIGO-SET-EXT
      *         END-IF
             IF  WRK-MO-CNT            >   ZERO
      *コメント END   --------------------------
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
               PERFORM 2401-SPACE-HENSYU-SEC
               MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTHKN-KIGO
               IF      PTHKN-KIGO(1:2) = X"8080"
                   MOVE "・"           TO  PTHKN-KIGO(1:2)
                   MOVE 7              TO  FLG-ERR
               END-IF
               PERFORM VARYING IDW
                       FROM    1
                       BY      2
                       UNTIL   IDW       >   WRK-LEN
                   IF  PTHKN-KIGO(IDW:2) =   X"8080"
                       MOVE  7           TO  FLG-ERR
                       MOVE  WRK-LEN     TO  IDW
                   END-IF
               END-PERFORM
      *コメント START --------------------------
             END-IF
      *コメント END   --------------------------
           END-EVALUATE
      *
           .
       2410-KIGO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目９：番号　処理
      *****************************************************************
       2410-NUM-SET-SEC                SECTION.
      *
           EVALUATE    PTHKN-HKNNUM
      *    自費
           WHEN    "980"
      *    労災
           WHEN    "971"
               IF  FLG-NODATA          =   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTHKN-NUM
               END-IF
      *
           WHEN    OTHER
      *コメント START --------------------------
      **        自費・労災以外は必須入力
      *         IF  FLG-NODATA          =   1
      *             MOVE    1           TO  FLG-ERR
      *             GO      TO          2410-NUM-SET-EXT
      *         END-IF
             IF  WRK-MO-CNT            >   ZERO
      *コメント END   --------------------------
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
               PERFORM 2401-SPACE-HENSYU-SEC                        
               MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTHKN-NUM
      *コメント START --------------------------
             END-IF
      *コメント END   --------------------------
           END-EVALUATE
      *
           .
       2410-NUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１３：適用開始日　処理
      *****************************************************************
       2410-TEKSTYMD-SET-SEC           SECTION.
      *
           EVALUATE    WRK-MO-CNT
      *
           WHEN    ZERO
               MOVE    PARA-06-1       TO  PTHKN-TEKSTYMD
      *
           WHEN    1
               IF      CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "0"
                   MOVE    PARA-06-1       TO  PTHKN-TEKSTYMD
               ELSE                        
                   MOVE    2               TO  FLG-ERR
               END-IF                   
      *
           WHEN    8
               IF      CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   ALL "0"
                   MOVE    PARA-06-1       TO  PTHKN-TEKSTYMD
               ELSE                        
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                           TO  PTHKN-TEKSTYMD
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
      *    項目１４：適用終了日　処理
      *****************************************************************
       2410-TEKEDYMD-SET-SEC           SECTION.
      *
           EVALUATE    WRK-MO-CNT
      *
           WHEN    ZERO
               MOVE    ALL "9"         TO  PTHKN-TEKEDYMD
      *
           WHEN    8
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-TEKEDYMD
           WHEN    OTHER
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-TEKEDYMD-SET-EXT
           END-EVALUATE
      *
           .
       2410-TEKEDYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１５：保険確認日　処理
      *****************************************************************
       2410-KAKUNINYMD-SET-SEC         SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   8
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-KAKUNINYMD
                   IF  PTHKN-KAKUNINYMD (7:2)  =  ZERO
                       MOVE    "01"    TO  PTHKN-KAKUNINYMD (7:2)
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
      *    項目１６：登録日　処理
      *****************************************************************
       2410-CREYMD-SET-SEC             SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   8
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-CREYMD
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
      *    項目１７：更新日　処理
      *****************************************************************
       2410-UPYMD-SET-SEC             SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   8
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTHKN-UPYMD
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
                MOVE    4              TO  FLG-ERR
                GO      TO             250-PTNUM-UPDATE-EXT
           ELSE
      *        患者番号変換マスタより転送
               MOVE    PTNUM-PTID      TO  PTHKN-PTID
      *        最大保険ＩＤで患者番号変換マスタを更新
               IF  PTNUM-HKNID         <   PTHKN-HKNID
                   MOVE    PTHKN-HKNID     TO  PTNUM-HKNID
                   MOVE    SPA-SYSYMD      TO  PTNUM-UPYMD
                   MOVE    PTNUM-REC       TO  MCPDATA-REC
                   MOVE    "DBUPDATE"      TO  MCP-FUNC
                   MOVE    "PTNUM-KEY2"    TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"  USING   MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC      NOT =   ZERO
                       MOVE    5               TO  FLG-ERR
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
      *    患者保険マスタ　登録処理
      *****************************************************************
       260-PTHKNINF-INSERT-SEC            SECTION.
      *
           MOVE    SPA-HOSPID          TO  PTHKN-HOSPID
           MOVE    SPA-TERMID          TO  PTHKN-TERMID
           MOVE    PTHKN-REC           TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
                MOVE    6              TO  FLG-ERR
                GO      TO             260-PTHKNINF-INSERT-EXT
           END-IF
           ADD     1                   TO  CNT-PTHKNINF
      *
           .
       260-PTHKNINF-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集処理
      *****************************************************************
       270-ERRREC-EDIT-SEC             SECTION.
      *
           IF  FLG-ERR                 <=  3  OR
               FLG-ERR                 =   7
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
      *    番号ＤＢ出力エラー
           WHEN    5
      *    患者保険ＤＢ出力エラー
           WHEN    6
               PERFORM 2910-ERRREC-EDIT-BETU2-SEC
      *    文字化けエラー
           WHEN    7
               PERFORM 2910-ERRREC-EDIT-BETU1-SEC
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
               MOVE    "レコード"      TO  ERR1-KOMOKU(IDE)
      *    ３：法別番号
           WHEN    3
               MOVE    "法別番号"      TO  ERR1-KOMOKU(IDE)
      *    ４：保険者番号
           WHEN    4
               MOVE    "保険者番"      TO  ERR1-KOMOKU(IDE)
      *    ５：本人家族区分
           WHEN    5
               MOVE    "本人家族"      TO  ERR1-KOMOKU(IDE)
      *    ６：補助区分
           WHEN    6
               MOVE    "補助区分"      TO  ERR1-KOMOKU(IDE)
      *    ７：継続区分
           WHEN    7
               MOVE    "継続区分"      TO  ERR1-KOMOKU(IDE)
      *    ８：記号
           WHEN    8
               MOVE    "記号"          TO  ERR1-KOMOKU(IDE)
      *    ９：番号
           WHEN    9
               MOVE    "番号"          TO  ERR1-KOMOKU(IDE)
      *    １０：被保険者氏名
           WHEN    10
               MOVE    "被保険者"      TO  ERR1-KOMOKU(IDE)
      *    １１：外来負担率（％）
           WHEN    11
               MOVE    "外来負担"      TO  ERR1-KOMOKU(IDE)
      *    １２：入院負担率（％）
           WHEN    12
               MOVE    "入院負担"      TO  ERR1-KOMOKU(IDE)
      *    １３：適用開始日
           WHEN    13
               MOVE    "適用開始"      TO  ERR1-KOMOKU(IDE)
      *    １４：適用終了日
           WHEN    14
               MOVE    "適用終了"      TO  ERR1-KOMOKU(IDE)
      *    １５：保険確認日
           WHEN    15
               MOVE    "保険確認"      TO  ERR1-KOMOKU(IDE)
      *    １６：登録日
           WHEN    16
               MOVE    "登録日"        TO  ERR1-KOMOKU(IDE)
      *    １７：更新日
           WHEN    17
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
           END-EVALUATE
           MOVE    SPA-PTNUM           TO  ERR2-PTNUM
           IF  PTHKN-PTID          NOT =   ZERO
               MOVE    PTHKN-PTID      TO  ERR2-PTID
           END-IF
           MOVE    PTHKN-HKNNUM        TO  ERR2-HKNNUM
           IF  PTHKN-HKNID         NOT =   ZERO
               MOVE    PTHKN-HKNID     TO  ERR2-HKNID
           END-IF
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
               DISPLAY "*(ORCVTPTHKNINF)* ERRFILE OPN STS[" STS-LST "]"
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
           DISPLAY "*(ORCVTPTHKNINF)* CSV     /I CNT[" CNT-CSV      "]"
           DISPLAY "*(ORCVTPTHKNINF)* PTHKNINF/O CNT[" CNT-PTHKNINF "]"
           DISPLAY "*(ORCVTPTHKNINF)* ERR     /O CNT[" CNT-ERR      "]"
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
