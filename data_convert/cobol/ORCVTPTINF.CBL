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
       PROGRAM-ID.                 ORCVTPTINF.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＤＢ作成処理
      *  コンポーネント名  : ＣＳＶファイルコンバート処理（患者情報）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/04/11    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/11/01  患者番号の空白までで桁数
      *                                     を編集  
      *  01.00.02    MCC-藤原     01/11/01  氏名・かな氏名を空白まで
      *                                     を編集  
      *  01.00.03    MCC-伊藤     01/12/12  患者番号構成に合わせて
      *                                     前０詰め編集を行う  
      *  01.00.04    MCC-伊藤     01/12/12  ＤＢコールインターフェイス
      *                                     の変更 
      *  01.00.05    MCC-森脇     02/05/01  空白編集の変更  
      *  01.01.01    NACL-森脇    02/11/28  入院履歴番号、枝番号の追加
      *  01.01.02    NACL-多々納  03/10/10  自由構成患者番号編集修正
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
      *    入力患者情報ＣＳＶファイル
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
      *    入力患者情報ＣＳＶファイル
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
           03  FLG-PTINF               PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-PTNUM               PIC 9(01).
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
           03  CNT-PTINF               PIC 9(06).
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
           03  PARA-03-1               PIC X(01).
           03  PARA-03-2               PIC X(10).
           03  PARA-03-3               PIC X(10).
           03  PARA-04-1               PIC X(10).
           03  PARA-05-1               PIC X(02).
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
           03  WRK-WARIKBN             PIC 9(01).
           03  WRK-RENKETA             PIC 9(02).
           03  WRK-PTNUM               PIC X(20).
           03  WRK-CNT                 PIC 9(04).
           03  WRK-DATA                PIC X(200).
           03  WRK-LEN                 PIC 9(03). 
      *
      *    帳票出力領域
       01  MES-AREA.
           03  MES-TITLE1.
               05  FILLER              PIC X(23) VALUE
                                       "【PGID:ORCVTPTINF.CBL】".
               05  MES-TITLE1-YY       PIC X(04) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-MM       PIC X(02) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-DD       PIC X(02) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE SPACE.
               05  MES-TITLE1-PARA     PIC X(10).
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
               05  FILLER              PIC X(01).
               05  ERR1-NAME           PIC X(20).
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
               05  ERR2-MES            PIC X(20).
               05  FILLER              PIC X(01).
               05  ERR2-PTNUM          PIC X(20).
               05  FILLER              PIC X(01).
               05  ERR2-KANANAME       PIC X(30).
               05  FILLER              PIC X(01).
               05  ERR2-NAME           PIC X(20).
               05  FILLER              PIC X(01).
               05  ERR2-BIRTH          PIC X(08).
               05  FILLER              PIC X(01).
               05  ERR2-SEX            PIC X(02).
      *
      *    メッセージ領域
       01  CONS-AREA.
      *     03  CONS-MES1               PIC X(20) VALUE
      *         "必須項目未入力エラー".
      *     03  CONS-MES2               PIC X(20) VALUE
      *         "項目桁数エラー".
      *     03  CONS-MES3               PIC X(20) VALUE
      *         "誤入力エラー".
           03  CONS-MES4               PIC X(20) VALUE
               "患者ＩＤ取得エラー".
           03  CONS-MES5               PIC X(20) VALUE
               "番号ＤＢ出力エラー".
           03  CONS-MES6               PIC X(20) VALUE
               "患者ＤＢ出力エラー".
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    システム管理（医療機関情報）
           COPY    "CPSK1001.INC".
      *    システム管理（患者番号構成管理）
           COPY    "CPSK1009.INC".
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
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
       100-INIT-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-AREA
           MOVE    ZERO            TO  CNT-AREA
           MOVE    ZERO            TO  IDX-AREA
           MOVE    SPACE           TO  ASS-AREA
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
      *
      *    端末ＩＤ固定
           MOVE    "ORCATERM"      TO  SPA-TERMID
      *
      *    帳票ＯＰＥＮ処理
           OPEN    INPUT           CSV-FILE
           IF  STS-CSV         NOT =   ZERO
               MOVE    1           TO  FLG-CSV
               DISPLAY "*(ORCVTPTINF)* PTINF-FILE OPN STS[" STS-CSV "]"
               GO      TO          100-INIT-EXT
           END-IF
      *    帳票出力　初期処理
           MOVE    PARA-04-1       TO  MES-TITLE1-PARA
           PERFORM 2910-ERRLST-INIT-SEC
           IF  FLG-CSV             =   1
               GO  TO              100-INIT-EXT
           END-IF
      *
      *    データベースオープン
           PERFORM 100-DBOPEN-SEC
      *
      *    システム管理情報　検索処理
           PERFORM 110-CP1001-KENSAKU-SEC
           IF  FLG-CSV             =   1
               GO  TO              100-INIT-EXT
           END-IF
      *    患者番号構成クリア処理
           IF      PARA-03-1       =   "T"
               MOVE    9           TO  FLG-UPDATE
               PERFORM 250-PTNUM-GET-SEC
           END-IF
      *    患者番号桁数　取得処理
           MOVE    ZERO            TO  FLG-UPDATE
           PERFORM 250-PTNUM-GET-SEC
           IF  WRK-RENKETA (1:2)   NOT =   PARA-05-1
               MOVE    1           TO  FLG-CSV
               DISPLAY "*(ORCVTPTINF)* PTNUM BYTE UNMATCH!"
               GO  TO              100-INIT-EXT
           END-IF
           MOVE    PARA-05-1       TO  WRK-RENKETA(1:2)
      *
      *    患者ＣＳＶファイル　検索処理
           MOVE    1               TO  FLG-UPDATE
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
               DISPLAY "*(ORCVTPTINF)* PARA-FILE OPN STS[" STS-PARA "]"
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
           IF  PARA-03-2               IS  NUMERIC
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-CSV
               GO      TO          101-PARA-GET-EXT
           END-IF
      *
           IF  PARA-03-3               IS  NUMERIC
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-CSV
               GO      TO          101-PARA-GET-EXT
           END-IF
      *
           IF  PARA-04-1               IS  NUMERIC
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-CSV
               GO      TO          101-PARA-GET-EXT
           END-IF
      *
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
             WHEN  "01-1"
                   MOVE  PARA-DATA TO  ASS-CSV
             WHEN  "02-1"
                   MOVE  PARA-DATA TO  ASS-ERR
             WHEN  "03-1"
                   IF    PARA-DATA =   "YES"
                                   OR  "yes"
                     MOVE  "T"     TO  PARA-03-1
                   ELSE
                     MOVE  "F"     TO  PARA-03-1
                   END-IF
             WHEN  "03-2"
                   MOVE  PARA-DATA TO  PARA-03-2
             WHEN  "03-3"
                   MOVE  PARA-DATA TO  PARA-03-3
             WHEN  "04-1"
                   MOVE  PARA-DATA TO  PARA-04-1
             WHEN  "05-1"
                   MOVE  PARA-DATA TO  PARA-05-1
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
               DISPLAY "***(ORCVTPTINF)*** CNT-CSV[" CNT-CSV "]"
           END-IF
           MOVE    SPACE               TO  PTINF-REC
           INITIALIZE                      PTINF-REC
           MOVE    ZERO                TO  WRK-POINT-AREA
           MOVE    ZERO                TO  IDX-AREA
           MOVE    ZERO                TO  WRK-WARIKBN
      *    対象患者にエラーが存在するかどうか
           MOVE    ZERO                TO  FLG-ERRARI
           MOVE    ZERO                TO  FLG-DATAEND
      *
      *    患者ＣＳＶファイルに存在する項目数分、繰り返す
      *    またはレコード終了、または項目エラー４個まで
           PERFORM     VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX           >   49   )
                       OR      ( WRK-PO-ED     >=  3000 )
                       OR      ( IDE           >   4    )
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
                       MOVE    1           TO  FLG-ERRARI
                   END-IF
               ELSE
                   PERFORM 290-ERRREC-EDIT-SEC
                   MOVE    1               TO  FLG-ERRARI
               END-IF
      *
           END-PERFORM
      *
      *----(01.01.01)--ADD-START---
           MOVE    ZERO                TO  PTINF-MAXZAINUM
           MOVE    ZERO                TO  PTINF-RRKNUM
           MOVE    ZERO                TO  PTINF-RRKEDANUM
      *----(01.01.01)--ADD-END-----
      *
           IF  FLG-ERRARI              =   ZERO
      *        患者ＩＤ取得処理
               PERFORM 250-PTNUM-GET-SEC
               IF  FLG-ERR             =   ZERO
      *            患者番号変換マスタ　更新処理
                   PERFORM 260-PTNUM-INSERT-SEC
                   IF  FLG-ERR             =   ZERO
      *                患者マスタ　更新処理
                       PERFORM 270-PTINF-INSERT-SEC
                       IF  FLG-ERR         NOT =   ZERO
      *                    エラーリスト編集/出力処理
                           PERFORM 290-ERRREC-EDIT-SEC
                           MOVE    2           TO  FLG-ERRARI
                           PERFORM 290-ERRLST-OUT-SEC
                       END-IF
                   ELSE
      *                エラーリスト編集/出力処理
                       PERFORM 290-ERRREC-EDIT-SEC
                       MOVE    2           TO  FLG-ERRARI
                       PERFORM 290-ERRLST-OUT-SEC
                   END-IF
               ELSE
      *            エラーリスト編集/出力処理
                   PERFORM 290-ERRREC-EDIT-SEC
                   MOVE    2           TO  FLG-ERRARI
                   PERFORM 290-ERRLST-OUT-SEC
               END-IF
           ELSE
      *        エラーリスト出力処理
               MOVE    1           TO  FLG-ERRARI
               PERFORM 290-ERRLST-OUT-SEC
           END-IF
      *
      *    患者ＣＳＶファイル　検索処理
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
               IF  ( CSV-X (IDY)       =   ","        )  OR
                   ((IDX               =   49  OR  48) AND
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
      *        １：患者番号
               WHEN    1
      *        ２：カナ氏名
               WHEN    2
      *        ３：漢字氏名
               WHEN    3
                   IF  PTINF-KANANAME  =   SPACE
                       CONTINUE
                   ELSE
                       GO  TO          230-HISSU-KOUMOKU-EXT
                   END-IF
      *        ５：性別
               WHEN    5
      *        ６：生年月日
               WHEN    6
      *コメント START --------------------------------
      **        ９：自宅−住所
      *         WHEN    9
      **        １０：自宅−番地
      *         WHEN    10
      **        １３：世帯主
      *         WHEN    13
      **        １４：続柄
      *         WHEN    14
      **        １５：職業
      *         WHEN    15
      *コメント END   --------------------------------
      *        ４７：テスト患者フラグ
               WHEN    47
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
      *    ２：カナ氏名
           WHEN    2
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
               PERFORM 2401-SPACE-HENSYU-SEC                        
               MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-KANANAME
      *    ３：漢字氏名
           WHEN    3
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
               PERFORM 2401-SPACE-HENSYU-SEC                        
               MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-NAME
               ELSE
                   MOVE    PTINF-KANANAME
                                       TO  PTINF-NAME
               END-IF
      *    ４：通称
           WHEN    4
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-NICKNAME
               END-IF
      *    ５：性別
           WHEN    5
               PERFORM 2410-SEX-SET-SEC
      *    ６：生年月日
           WHEN    6
               PERFORM 2410-BIRTHDAY-SET-SEC
      *    ７：死亡区分
           WHEN    7
               PERFORM 2410-DEATHKBN-SET-SEC
      *    ８：自宅−郵便番号
           WHEN    8
               PERFORM 2410-HOME-POST-SET-SEC
      *    ９：自宅−住所
           WHEN    9
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-HOME-ADRS
               END-IF
      *    １０：自宅−番地
           WHEN    10
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-HOME-BANTI
               END-IF
      *    １１：自宅−電話番号（昼）
           WHEN    11
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-HOME-TEL1
               END-IF
      *    １２：自宅−電話番号（夜）
           WHEN    12
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-HOME-TEL2
               END-IF
      *    １３：世帯主
           WHEN    13
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC    
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-SETAINUSI
               END-IF
      *    １４：続柄
           WHEN    14
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC 
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-ZOKUGARA
               END-IF
      *    １５：職業
           WHEN    15
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-JOB
               END-IF
      *    １６：携帯電話番号
           WHEN    16
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-KEITAI-TEL
               END-IF
      *    １７：ＦＡＸ番号
           WHEN    17
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-FAX
               END-IF
      *    １８：電子メールアドレス
           WHEN    18
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-EMAIL
               END-IF
      *    １９：減免事由
           WHEN    19
               PERFORM 2410-DISCOUNT-KBN-SET-SEC
      *    ２０：割引区分
           WHEN    20
               PERFORM 2410-WARIKBN-SET-SEC
      *    ２１：割引
           WHEN    21
               PERFORM 2410-DISCOUNT-SET-SEC
      *    ２２：コメント１
           WHEN    22
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-COMMENT-1
               END-IF
      *    ２３：コメント２
           WHEN    23
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-COMMENT-2
               END-IF
      *    ２４：禁忌１
           WHEN    24
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-TABOO-1
               END-IF
      *    ２５：禁忌２
           WHEN    25
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-TABOO-2
               END-IF
      *    ２６：アレルギー１
           WHEN    26
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-ALLERGY-1
               END-IF
      *    ２７：アレルギー２
           WHEN    27
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-ALLERGY-2
               END-IF
      *    ２８：感染症１
           WHEN    28
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-KANSENSYO-1
               END-IF
      *    ２９：感染症２
           WHEN    29
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-KANSENSYO-2
               END-IF
      *    ３０：連絡先−名称
           WHEN    30
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-RENRAKU-NAME
               END-IF
      *    ３１：連絡先−続柄
           WHEN    31
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-RENRAKU-ZOKUGARA
               END-IF
      *    ３２：連絡先−郵便番号
           WHEN    32
               PERFORM 2410-RENRAKU-POST-SET-SEC
      *    ３３：連絡先−住所
           WHEN    33
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-RENRAKU-ADRS
               END-IF
      *    ３４：連絡先−番地方書
           WHEN    34
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-RENRAKU-BANTI
               END-IF
      *    ３５：連絡先−電話番号（昼）
           WHEN    35
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-RENRAKU-TEL1
               END-IF
      *    ３６：連絡先−電話番号（夜）
           WHEN    36
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-RENRAKU-TEL2
               END-IF
      *    ３７：勤務先−名称
           WHEN    37
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-OFFICE-NAME
               END-IF
      *    ３８：勤務先−郵便番号
           WHEN    38
               PERFORM 2410-OFFICE-POST-SET-SEC
      *    ３９：勤務先−住所
           WHEN    39
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-OFFICE-ADRS
               END-IF
      *    ４０：勤務先−番地方書
           WHEN    40
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-OFFICE-BANTI
               END-IF
      *    ４１：勤務先−電話番号
           WHEN    41
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-OFFICE-TEL
               END-IF
      *    ４２：帰省先−名称
           WHEN    42
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-KISEI-NAME
               END-IF
      *    ４３：帰省先−郵便番号
           WHEN    43
               PERFORM 2410-KISEI-POST-SET-SEC
      *    ４４：帰省先−住所
           WHEN    44
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-KISEI-ADRS
               END-IF
      *    ４５：帰省先−番地方書
           WHEN    45
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-KISEI-BANTI
               END-IF
      *    ４６：帰省先−電話番号
           WHEN    46
               IF  WRK-MO-CNT          >   ZERO
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-KISEI-TEL
               END-IF
      *    ４７：テスト患者フラグ
           WHEN    47
               PERFORM 2410-TSTPTNUMKBN-SET-SEC
      *    ４８：登録日
           WHEN    48
               PERFORM 2410-CREYMD-SET-SEC
      *    ４９：更新日
           WHEN    49
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
               PERFORM VARYING IDE FROM    200 BY  -1
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
           IF     (WRK-MO-CNT          >   0  )   AND
                  (WRK-MO-CNT          <=  20 )
               CONTINUE
           ELSE
      *        未入力、２０文字以上はエラー
               MOVE    2               TO  FLG-ERR
               GO      TO      2410-PTNUM-SET-EXT
           END-IF
      *
           IF   (( SYS-1009-PTNUMKSIKBN    =   "1" ) AND
                 ( SYS-1009-JIYKSIKBN      =   "2" ))    OR
                (( SYS-1009-PTNUMKSIKBN    =   "2" ) AND
                 ( SYS-1009-HJNKSIKBN      =   "3" OR "4" ))
               MOVE    ZERO                TO  SPA-PTNUM(1:WRK-RENKETA)
               IF      WRK-MO-CNT      >   WRK-RENKETA
                   COMPUTE WRK-MO-ST    =   WRK-MO-ST   
                                        +  (WRK-MO-CNT  -   WRK-RENKETA)
                   MOVE  CSV-REC (WRK-MO-ST:WRK-RENKETA)
                                       TO  SPA-PTNUM
               ELSE                       
                  COMPUTE WRK-MO-ST1   =   WRK-RENKETA
                                       -   WRK-MO-CNT
                                       +   1
                   MOVE  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  SPA-PTNUM(WRK-MO-ST1:)
               END-IF                        
           ELSE
               MOVE    1               TO  WRK-MO-ST1
               MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  SPA-PTNUM(WRK-MO-ST1:)
           END-IF
      *
           .
       2410-PTNUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目５：性別　処理
      *****************************************************************
       2410-SEX-SET-SEC                SECTION.
      *
           IF  WRK-MO-CNT              =   1
               CONTINUE
           ELSE
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-SEX-SET-EXT
           END-IF
      *
           IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   "1"  OR  "2"
               CONTINUE
           ELSE
               MOVE    3               TO  FLG-ERR
               GO      TO              2410-SEX-SET-EXT
           END-IF
      *
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTINF-SEX
      *
           .
       2410-SEX-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目６：生年月日　処理
      *****************************************************************
       2410-BIRTHDAY-SET-SEC           SECTION.
      *
           IF  WRK-MO-CNT              =   8
               CONTINUE
           ELSE
               MOVE    2               TO  FLG-ERR
               GO      TO              2410-BIRTHDAY-SET-EXT
           END-IF
      *
           MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTINF-BIRTHDAY
      *
           .
       2410-BIRTHDAY-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目７：死亡区分　処理
      *****************************************************************
       2410-DEATHKBN-SET-SEC           SECTION.
      *
           IF  FLG-NODATA              =   1
               MOVE    "0"             TO  PTINF-DEATHKBN
           ELSE
               IF  WRK-MO-CNT          =   1
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTINF-DEATHKBN
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-DEATHKBN-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-DEATHKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目８：自宅−郵便番号　処理
      *****************************************************************
       2410-HOME-POST-SET-SEC          SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT         <=   7
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-HOME-POST
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-HOME-POST-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-HOME-POST-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目１９：減免事由　処理
      *****************************************************************
       2410-DISCOUNT-KBN-SET-SEC       SECTION.
      *
      *    例：職員家族通院（固定値:02）
           IF  WRK-MO-CNT              =   ZERO
               MOVE    "00"            TO  PTINF-DISCOUNT-KBN
           ELSE
               EVALUATE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
               WHEN    "職員家族通院"
                   MOVE    "02"        TO  PTINF-DISCOUNT-KBN
               WHEN    "職員家族入院"
                   MOVE    "03"        TO  PTINF-DISCOUNT-KBN
               WHEN    OTHER
                   MOVE    "00"        TO  PTINF-DISCOUNT-KBN
               END-EVALUATE
           END-IF
      *
           .
       2410-DISCOUNT-KBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目２０：割引区分　処理
      *****************************************************************
       2410-WARIKBN-SET-SEC            SECTION.
      *
           IF  WRK-MO-CNT              =   ZERO
               MOVE    ZERO            TO  WRK-WARIKBN
           ELSE
               IF  WRK-MO-CNT          =   1
                   IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT) =  "1"  OR  "2"
                       MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-WARIKBN
                   ELSE
                       MOVE    3       TO  FLG-ERR
                       GO      TO      2410-WARIKBN-SET-EXT
                   END-IF
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-WARIKBN-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-WARIKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目２１：割引　処理
      *****************************************************************
       2410-DISCOUNT-SET-SEC           SECTION.
      *
           IF  WRK-MO-CNT              =   ZERO
               MOVE    "00"            TO  PTINF-DISCOUNT
           ELSE
               EVALUATE    TRUE
      *        例：定率
               WHEN    CSV-REC (WRK-MO-ST:WRK-MO-CNT)  =   "20"
                   IF  WRK-WARIKBN     =   "1"
                       MOVE    "02"    TO  PTINF-DISCOUNT
                   END-IF
      *        例：定額
               WHEN    CSV-REC (WRK-MO-ST:WRK-MO-CNT)  =   "1000"
                   IF  WRK-WARIKBN     =   "2"
                       MOVE    "04"    TO  PTINF-DISCOUNT
                   END-IF
               END-EVALUATE
      *
               IF  PTINF-DISCOUNT      =   SPACE
                   MOVE    "00"        TO  PTINF-DISCOUNT
               END-IF
           END-IF
      *
           .
       2410-DISCOUNT-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目３２：連絡先−郵便番号　処理
      *****************************************************************
       2410-RENRAKU-POST-SET-SEC       SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT         <=   7
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-RENRAKU-POST
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-RENRAKU-POST-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-RENRAKU-POST-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目３８：勤務先−郵便番号　処理
      *****************************************************************
       2410-OFFICE-POST-SET-SEC        SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT         <=   7
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-OFFICE-POST
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-OFFICE-POST-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-OFFICE-POST-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目４３：帰省先−郵便番号　処理
      *****************************************************************
       2410-KISEI-POST-SET-SEC        SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT         <=   7
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  WRK-DATA
                   PERFORM 2401-SPACE-HENSYU-SEC                        
                   MOVE    WRK-DATA (1:WRK-LEN)
                                       TO  PTINF-KISEI-POST
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-KISEI-POST-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-KISEI-POST-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目４７：テスト患者フラグ　処理
      *****************************************************************
       2410-TSTPTNUMKBN-SET-SEC        SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   1
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTINF-TSTPTNUMKBN
               ELSE
                   MOVE    2           TO  FLG-ERR
                   GO      TO          2410-TSTPTNUMKBN-SET-EXT
               END-IF
           END-IF
      *
           .
       2410-TSTPTNUMKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目４８：登録日　処理
      *****************************************************************
       2410-CREYMD-SET-SEC             SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   8
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTINF-CREYMD
               ELSE
                   IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   ZERO
                       CONTINUE
                   ELSE
                       MOVE    2       TO  FLG-ERR
                       GO      TO      2410-CREYMD-SET-EXT
                   END-IF
               END-IF
           END-IF
      *
           .
       2410-CREYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目４９：更新日　処理
      *****************************************************************
       2410-UPYMD-SET-SEC             SECTION.
      *
           IF  FLG-NODATA              =   ZERO
      *
               IF  WRK-MO-CNT          =   8
                   MOVE    CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       TO  PTINF-UPYMD
               ELSE
                   IF  CSV-REC (WRK-MO-ST:WRK-MO-CNT)
                                       =   ZERO
                       CONTINUE
                   ELSE
                       MOVE    2       TO  FLG-ERR
                       GO      TO      2410-UPYMD-SET-EXT
                   END-IF
               END-IF
           END-IF
      *
           .
       2410-UPYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者ＩＤ取得処理
      *****************************************************************
       250-PTNUM-GET-SEC               SECTION.
      *
      *    患者番号採番検索
           PERFORM 2510-PTGETNUM-GET-SEC
           IF  FLG-SYSKANRI            =   1
               MOVE    4               TO  FLG-ERR
               GO  TO                  250-PTNUM-GET-EXT
           END-IF
      *
           MOVE    MCPDATA-REC         TO  SYS-1009-REC
           EVALUATE    FLG-UPDATE
           WHEN    ZERO
      *        患者番号桁数算出処理
               PERFORM 2520-PTNUM-KETA-SEC
               GO  TO                  250-PTNUM-GET-EXT
           WHEN    1
               COMPUTE SYS-1009-PTID   =   SYS-1009-PTID    +   1
               MOVE    SYS-1009-PTID   TO  SPA-PTID
           WHEN    2
               MOVE    PARA-04-1       TO  SYS-1009-RENNUM(1:10)
           WHEN    9
               MOVE    PARA-03-2       TO  SYS-1009-RENNUM(1:10)
               MOVE    PARA-03-3       TO  SYS-1009-PTID(1:10)
           END-EVALUATE
      *
      *    患者番号採番  更新
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    4               TO  FLG-ERR
               GO  TO                  250-PTNUM-GET-EXT
           END-IF
      *
           .
       250-PTNUM-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号採番検索
      *****************************************************************
       2510-PTGETNUM-GET-SEC            SECTION.
      *
           INITIALIZE                  SYS-1009-REC
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
      *
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               PERFORM 900-SYSTEM-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
       2510-PTGETNUM-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号桁数算出処理
      *****************************************************************
       2520-PTNUM-KETA-SEC            SECTION.
      *
           EVALUATE    SYS-1009-PTNUMKSIKBN
           WHEN    "1"
               MOVE    SYS-1009-JIYKSIKETA         TO  WRK-RENKETA
           WHEN    "2"
               MOVE    SYS-1009-HJNKSIRENNUMKETA   TO  WRK-RENKETA
               IF  SYS-1009-HJNKSIKBN    =   "1"  OR  "2"
                   EVALUATE    SYS-1009-HJNKSINENKBN
                   WHEN    "1"
                       ADD     3         TO  WRK-RENKETA
                   WHEN    "2"
                       ADD     4         TO  WRK-RENKETA
                   END-EVALUATE
               END-IF
               IF  SYS-1009-HJNKSIKBN    =   "1"  OR  "3"
                   ADD     1             TO  WRK-RENKETA
               END-IF
           WHEN    "3"
               EVALUATE    SYS-1009-KKCKSIKBN
               WHEN    "1"
                   COMPUTE WRK-RENKETA   =   SYS-1009-KKCKSIMAEKETA
                                         +   SYS-1009-KKCKSIRENNUMKETA
                                         +   SYS-1009-KKCKSIATOKETA
               WHEN    "2"
                   COMPUTE WRK-RENKETA   =   SYS-1009-KKCKSIMAEKETA
                                         +   SYS-1009-KKCKSIRENNUMKETA
               WHEN    "3"
                   COMPUTE WRK-RENKETA   =   SYS-1009-KKCKSIRENNUMKETA
                                         +   SYS-1009-KKCKSIATOKETA
               END-EVALUATE
           END-EVALUATE
           .
      *
       2520-PTNUM-KETA-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号変換マスタ　更新処理
      *****************************************************************
       260-PTNUM-INSERT-SEC            SECTION.
      *
      *     MOVE    ZERO                TO  FLG-PTNUM
      *     MOVE    SPACE               TO  PTNUM-REC
      *     INITIALIZE                      PTNUM-REC
      *     MOVE    SPA-HOSPID          TO  PTNUM-HOSPID
      *     MOVE    SPA-PTID            TO  PTNUM-PTID
      *     MOVE    PTNUM-REC           TO  MCPDATA-REC
      *     MOVE    "DBSELECT"          TO  MCP-FUNC
      *     MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
      *     CALL    "MCPDBSUB"      USING   MCPAREA
      *                                     MCPDATA-REC
      *     IF      MCP-RC              =   ZERO
      *         MOVE    "PTNUM-KEY"     TO  ORC-DBPATH
      *         PERFORM 940-PTNUM-NEXT-SEC
      *     ELSE
      *         MOVE    1               TO  FLG-PTNUM
      *     END-IF
      *     MOVE    "DBCLOSE"           TO  MCP-FUNC
      *     MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
      *     CALL    "MCPDBSUB"      USING   MCPAREA
      *                                     MCPDATA-REC
      **    重複エラー
      *     IF      FLG-PTNUM           =   ZERO
      *          MOVE    5              TO  FLG-ERR
      *          GO      TO             260-PTNUM-INSERT-EXT
      *     END-IF
      *
           MOVE    SPACE               TO  PTNUM-REC
           INITIALIZE                      PTNUM-REC
           MOVE    SPA-HOSPID          TO  PTNUM-HOSPID
           MOVE    SPA-PTID            TO  PTNUM-PTID
           MOVE    SPA-PTNUM           TO  PTNUM-PTNUM
           MOVE    PTINF-TSTPTNUMKBN   TO  PTNUM-TSTPTNUMKBN
           MOVE    SPA-TERMID          TO  PTNUM-TERMID
           MOVE    PTINF-CREYMD        TO  PTNUM-CREYMD
           MOVE    PTINF-UPYMD         TO  PTNUM-UPYMD
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
                MOVE    5              TO  FLG-ERR
                GO      TO             260-PTNUM-INSERT-EXT
           END-IF
           ADD     1                   TO  CNT-PTNUM
      *
           .
       260-PTNUM-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスタ　登録処理
      *****************************************************************
       270-PTINF-INSERT-SEC            SECTION.
      *
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-PTID            TO  PTINF-PTID
           MOVE    ZERO                TO  PTINF-CONDITION-1
           MOVE    ZERO                TO  PTINF-CONDITION-2
           MOVE    ZERO                TO  PTINF-CONDITION-3
           MOVE    SPA-TERMID          TO  PTINF-TERMID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
                MOVE    6              TO  FLG-ERR
                GO      TO             270-PTINF-INSERT-EXT
           END-IF
           ADD     1                   TO  CNT-PTINF
      *
           .
       270-PTINF-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト編集処理
      *****************************************************************
       290-ERRREC-EDIT-SEC             SECTION.
      *
           IF  FLG-ERR                 <=  3
               ADD     1               TO  IDE
               IF  IDE                 >   4
                   GO  TO              290-ERRREC-EDIT-EXT
               END-IF
               IF  IDE                     =   1
                   ADD     1               TO  CNT-ERR
                   MOVE    SPACE           TO  ERR-REC1
                   MOVE    CNT-ERR (1:3)   TO  ERR1-NO (1:3)
                   MOVE    ":"             TO  ERR1-NO (4:1)
                   MOVE    SPA-PTNUM       TO  ERR1-PTNUM
                   MOVE    PTINF-NAME      TO  ERR1-NAME
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
      *    患者ＩＤ取得エラー
           WHEN    4
      *    番号ＤＢ出力エラー
           WHEN    5
      *    患者ＤＢ出力エラー
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
      *    １：患者番号
           WHEN    1
               MOVE    "患者番号"      TO  ERR1-KOMOKU(IDE)
      *    ２：カナ氏名
           WHEN    2
               MOVE    "カナ氏名"      TO  ERR1-KOMOKU(IDE)
      *    ３：漢字氏名
           WHEN    3
               MOVE    "漢字氏名"      TO  ERR1-KOMOKU(IDE)
      *    ４：通称
           WHEN    4
               MOVE    "通称"          TO  ERR1-KOMOKU(IDE)
      *    ５：性別
           WHEN    5
               MOVE    "性別"          TO  ERR1-KOMOKU(IDE)
      *    ６：生年月日
           WHEN    6
               MOVE    "生年月日"      TO  ERR1-KOMOKU(IDE)
      *    ７：死亡区分
           WHEN    7
               MOVE    "死亡区分"      TO  ERR1-KOMOKU(IDE)
      *    ８：自宅−郵便番号
           WHEN    8
               MOVE    "自郵便番"      TO  ERR1-KOMOKU(IDE)
      *    ９：自宅−住所
           WHEN    9
               MOVE    "自住所"        TO  ERR1-KOMOKU(IDE)
      *    １０：自宅−番地
           WHEN    10
               MOVE    "自番地"        TO  ERR1-KOMOKU(IDE)
      *    １１：自宅−電話番号（昼）
           WHEN    11
               MOVE    "自電話昼"      TO  ERR1-KOMOKU(IDE)
      *    １２：自宅−電話番号（夜）
           WHEN    12
               MOVE    "自電話夜"      TO  ERR1-KOMOKU(IDE)
      *    １３：世帯主
           WHEN    13
               MOVE    "世帯主"        TO  ERR1-KOMOKU(IDE)
      *    １４：続柄
           WHEN    14
               MOVE    "続柄"          TO  ERR1-KOMOKU(IDE)
      *    １５：職業
           WHEN    15
               MOVE    "職業"          TO  ERR1-KOMOKU(IDE)
      *    １６：携帯電話番号
           WHEN    16
               MOVE    "携帯"          TO  ERR1-KOMOKU(IDE)
      *    １７：ＦＡＸ番号
           WHEN    17
               MOVE    "ＦＡＸ"        TO  ERR1-KOMOKU(IDE)
      *    １８：電子メールアドレス
           WHEN    18
               MOVE    "メール"        TO  ERR1-KOMOKU(IDE)
      *    １９：減免事由
           WHEN    19
               MOVE    "減免事由"      TO  ERR1-KOMOKU(IDE)
      *    ２０：割引区分
           WHEN    20
               MOVE    "割引区分"      TO  ERR1-KOMOKU(IDE)
      *    ２１：割引
           WHEN    21
               MOVE    "割引"          TO  ERR1-KOMOKU(IDE)
      *    ２２：コメント１
           WHEN    22
               MOVE    "コメ１"        TO  ERR1-KOMOKU(IDE)
      *    ２３：コメント２
           WHEN    23
               MOVE    "コメ２"        TO  ERR1-KOMOKU(IDE)
      *    ２４：禁忌１
           WHEN    24
               MOVE    "禁忌１"        TO  ERR1-KOMOKU(IDE)
      *    ２５：禁忌２
           WHEN    25
               MOVE    "禁忌２"        TO  ERR1-KOMOKU(IDE)
      *    ２６：アレルギー１
           WHEN    26
               MOVE    "アレル１"      TO  ERR1-KOMOKU(IDE)
      *    ２７：アレルギー２
           WHEN    27
               MOVE    "アレル２"      TO  ERR1-KOMOKU(IDE)
      *    ２８：感染症１
           WHEN    28
               MOVE    "感染症１"      TO  ERR1-KOMOKU(IDE)
      *    ２９：感染症２
           WHEN    29
               MOVE    "感染症２"      TO  ERR1-KOMOKU(IDE)
      *    ３０：連絡先−名称
           WHEN    30
               MOVE    "連−名称"      TO  ERR1-KOMOKU(IDE)
      *    ３１：連絡先−続柄
           WHEN    31
               MOVE    "連−続柄"      TO  ERR1-KOMOKU(IDE)
      *    ３２：連絡先−郵便番号
           WHEN    32
               MOVE    "連郵便番"      TO  ERR1-KOMOKU(IDE)
      *    ３３：連絡先−住所
           WHEN    33
               MOVE    "連−住所"      TO  ERR1-KOMOKU(IDE)
      *    ３４：連絡先−番地方書
           WHEN    34
               MOVE    "連−番地"      TO  ERR1-KOMOKU(IDE)
      *    ３５：連絡先−電話番号（昼）
           WHEN    35
               MOVE    "連電話昼"      TO  ERR1-KOMOKU(IDE)
      *    ３６：連絡先−電話番号（夜）
           WHEN    36
               MOVE    "連電話夜"      TO  ERR1-KOMOKU(IDE)
      *    ３７：勤務先−名称
           WHEN    37
               MOVE    "勤−名称"      TO  ERR1-KOMOKU(IDE)
      *    ３８：勤務先−郵便番号
           WHEN    38
               MOVE    "勤郵便番"      TO  ERR1-KOMOKU(IDE)
      *    ３９：勤務先−住所
           WHEN    39
               MOVE    "勤−住所"      TO  ERR1-KOMOKU(IDE)
      *    ４０：勤務先−番地方書
           WHEN    40
               MOVE    "勤−番地"      TO  ERR1-KOMOKU(IDE)
      *    ４１：勤務先−電話番号
           WHEN    41
               MOVE    "勤−電話"      TO  ERR1-KOMOKU(IDE)
      *    ４２：帰省先−名称
           WHEN    42
               MOVE    "帰−名称"      TO  ERR1-KOMOKU(IDE)
      *    ４３：帰省先−郵便番号
           WHEN    43
               MOVE    "帰郵便番"      TO  ERR1-KOMOKU(IDE)
      *    ４４：帰省先−住所
           WHEN    44
               MOVE    "帰−住所"      TO  ERR1-KOMOKU(IDE)
      *    ４５：帰省先−番地方書
           WHEN    45
               MOVE    "帰−住所"      TO  ERR1-KOMOKU(IDE)
      *    ４６：帰省先−電話番号
           WHEN    46
               MOVE    "帰−電話"      TO  ERR1-KOMOKU(IDE)
      *    ４７：テスト患者フラグ
           WHEN    47
               MOVE    "テスト患"      TO  ERR1-KOMOKU(IDE)
      *    ４８：登録日
           WHEN    48
               MOVE    "登録日"        TO  ERR1-KOMOKU(IDE)
      *    ４９：更新日
           WHEN    49
               MOVE    "更新日"        TO  ERR1-KOMOKU(IDE)
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
           WHEN    4
               MOVE    CONS-MES4       TO  ERR2-MES
           WHEN    5
               MOVE    CONS-MES5       TO  ERR2-MES
           WHEN    6
               MOVE    CONS-MES6       TO  ERR2-MES
           END-EVALUATE
           MOVE    SPA-PTNUM           TO  ERR2-PTNUM
           MOVE    PTINF-KANANAME      TO  ERR2-KANANAME
           MOVE    PTINF-NAME          TO  ERR2-NAME
           MOVE    PTINF-BIRTHDAY      TO  ERR2-BIRTH
           IF  PTINF-SEX               =   "1"
               MOVE    "男"            TO  ERR2-SEX
           ELSE
               MOVE    "女"            TO  ERR2-SEX
           END-IF
      *
           .
       2910-ERRREC-EDIT-BETU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト出力処理
      *****************************************************************
       290-ERRLST-OUT-SEC              SECTION.
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
       290-ERRLST-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票出力　初期処理
      *****************************************************************
       2910-ERRLST-INIT-SEC            SECTION.
      *
           OPEN    OUTPUT              ERR-FILE
           IF  STS-LST             NOT =   ZERO
               MOVE    1               TO  FLG-CSV
               DISPLAY "*(ORCVTPTINF)* ERRFILE OPN STS[" STS-LST "]"
               GO      TO              2910-ERRLST-INIT-EXT
           END-IF
      *
           MOVE    MES-TITLE1      TO      ERR-REC
           WRITE   ERR-REC
           MOVE    MES-TITLE2      TO      ERR-REC
           WRITE   ERR-REC
      *
           .
       2910-ERRLST-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           MOVE    2                   TO  FLG-UPDATE
           PERFORM 250-PTNUM-GET-SEC
      *
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
      *    帳票出力　終了処理
           CLOSE                       CSV-FILE
           CLOSE                       ERR-FILE
      *
           DISPLAY "*(ORCVTPTINF)* CSV     /I CNT[" CNT-CSV      "]"
           DISPLAY "*(ORCVTPTINF)* PTINF   /O CNT[" CNT-PTINF    "]"
           DISPLAY "*(ORCVTPTINF)* ERR     /O CNT[" CNT-ERR      "]"
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
      *    患者ＣＳＶファイル検索処理
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
