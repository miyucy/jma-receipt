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
       PROGRAM-ID.                 ORCMUP0001.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＤＢ作成処理
      *  コンポーネント名  : 点数マスタ更新処理
      *                    : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/02/15    MCC-多々納    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-太田     02/03/18  点数マスタレイアウト変更
      *                                     対応
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    入力：パラメータファイル
      *    SELECT  PARA-FILE       ASSIGN
      *                            "ORCMUP00.PARA"
      *                            ORGANIZATION    IS  LINE SEQUENTIAL
      *                            FILE    STATUS  IS  STS-PARA.
      *
      *    入力：点数マスタファイル
           SELECT  IN-FILE         ASSIGN
                                   ASS-IN
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-IN.
      *    出力：エラーファイル
           SELECT  ERR-FILE        ASSIGN
                                   ASS-ERR
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-ERR.
      *    出力：プルーフファイル
           SELECT  PLF-FILE        ASSIGN
                                   ASS-PLF
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-PLF.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    パラメータファイル
      *FD  PARA-FILE.
      *01  PARA-REC.
      *    03  PARA-RECKBN             PIC X(01).
      *    03  PARA-DATKBN             PIC X(04).
      *    03  FILLER                  PIC X(01).
      *    03  PARA-DATA               PIC X(100).
      *
      *    入力：医薬品ファイル（新）
       FD  IN-FILE.
      *---(01.00.01) LINE UPD START -------------------------------------
      *    COPY    "CPTENSUWK.INC".
       01  IN-REC                      PIC X(10000).
      *---(01.00.01) LINE UPD END   -------------------------------------
      *
      *    出力：エラーファイル
       FD  ERR-FILE.
           COPY    "CPTENSUWK.INC"       REPLACING
                                       //TNSWK-// BY //ERR-TNSWK-//.
      *
      *    出力：プルーフファイル
       FD  PLF-FILE.
       01  PLF-REC                 PIC X(1000).
      *
       WORKING-STORAGE             SECTION.
      *
      *    ファイル指定領域
       01  ASS-AREA.
           03  ASS-IN                  PIC X(256).
           03  ASS-ERR                 PIC X(256).
           03  ASS-PLF                 PIC X(256).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA                PIC X(02).
           03  STS-IN                  PIC X(02).
           03  STS-ERR                 PIC X(02).
           03  STS-PLF                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PARA                PIC 9(01).
           03  FLG-IN                  PIC 9(01).
           03  FLG-PLF                 PIC 9(01).
      *
           03  FLG-SYORI               PIC 9(01).
           03  FLG-TENSU               PIC 9(01).
           03  FLG-TENSUPLUS           PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PARA                PIC 9(06).
           03  CNT-IN                  PIC 9(06).
           03  CNT-INS                 PIC 9(06).
           03  CNT-UPD                 PIC 9(06).
           03  CNT-DEL                 PIC 9(06).
           03  CNT-ERR                 PIC 9(06).
           03  CNT-PLF                 PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
      *
      *
       01  SYS-DATE.
           03  SYS-YY                  PIC 9(02).
           03  SYS-MM                  PIC 9(02).
           03  SYS-DD                  PIC 9(02).
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
      *　　主キー更新用項目
           03  WRK-TNSUP-KEY.
               05  WRK-TNSUP-SRYCD         PIC  X(09).
               05  WRK-TNSUP-YUKOSTYMD     PIC  X(08).
               05  WRK-TNSUP-YUKOEDYMD     PIC  X(08).
      *
           03  WRK-ERRCD               PIC 9(01). 
      *    点数保存
           03  WRK-HZN-TEN             PIC  9(09)V99.
           03  WRK-HZN-OLDTEN          PIC  9(09)V99.
      *
           03  WRK-IN                  PIC X(01). 
      *
      *    出力ファイル領域
       01  MES-AREA.
           03  MES-TITLE1.
               05  FILLER              PIC X(21) VALUE
                                       "【PGID:ORCMUP0001.CBL】".
               05  MES-TITLE1-YY       PIC X(04) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-MM       PIC X(02) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-DD       PIC X(02) VALUE SPACE.
      *
           01  WRK-MSG-AREA.
               03  WRK-MSG-01          PIC X(14).
               03  FILLER              PIC X(01)   VALUE   SPACE.
               03  WRK-SRYCD           PIC X(09).
               03  FILLER              PIC X(01)   VALUE   ",".
               03  WRK-YUKOSTYMD       PIC X(08).
               03  FILLER              PIC X(01)   VALUE   ",".
               03  WRK-YUKOEDYMD       PIC X(08).
               03  FILLER              PIC X(01)   VALUE   ",".
               03  WRK-YUKOEDYMD2      PIC X(08).
               03  FILLER              PIC X(01)   VALUE   ",".
               05  WRK-NAME            PIC X(100).
      *
      *---(01.00.01) LINE ADD START -------------------------------------
      *    旧マスタデータ退避領域
           01  TNSWK-TENSU-REC-V01.
               03  TNSWK-V01-AREA-01   PIC X(962).
               03  TNSWK-V01-AREA-02   PIC X(136).
               03  TNSWK-V01-AREA-03   PIC X(192).
      *---(01.00.01) LINE ADD START -------------------------------------
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *---(01.00.01) LINE ADD START -------------------------------------
           COPY    "CPTENSUWK.INC".
      *---(01.00.01) LINE ADD START -------------------------------------
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *
      *    点数マスタ付加コード
        01 TENSUPLUS-REC.
           COPY    "CPTENSUPLUS.INC".
      *
      *    点数マスタ付加コードワーク
        01 WRK-TENSUPLUS-REC.
           COPY    "CPTENSUPLUS.INC"    REPLACING
                                       //TNSP// BY //WRK-TNSP//.
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
       01  PARA-REC.
           03  PARA-DBFILE               PIC X(13).
           03  PARA-UPFILE               PIC X(100).
      *---(01.00.01) LINE ADD START -------------------------------------
           03  LNK-DBRVERSION            PIC X(21).
      *---(01.00.01) LINE ADD END   -------------------------------------
      *
       PROCEDURE                       DIVISION
           USING
           PARA-REC.
      *
      ****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-IN      =   1
      *
           PERFORM 300-END-SEC
      *
      *****STOP    RUN
           .
           EXIT    PROGRAM
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
      *
      *    DB OPEN
           PERFORM 100-DBOPEN-SEC
           IF      MCP-RC      NOT =   ZERO
               DISPLAY "DBOPEN ERR"
           END-IF.
      *
      *    パラメータ情報取得
      *****PERFORM 101-PARA-GET-SEC
      *    ファイル情報
           PERFORM 101-ASSIN-GET-SEC
      *
      *    入力　初期処理
           OPEN    INPUT           IN-FILE
           IF  STS-IN          NOT =   ZERO
               MOVE    1           TO  FLG-IN
               DISPLAY "*(ORCMUP0001)* IN-FILE OPN STS["
                                       STS-IN "]"
           END-IF
      *
      *    出力ファイル　初期処理
           PERFORM 2700-OUTLST-INIT-SEC
      *
      *    点数マスタ変更ファイル読込み処理
           IF      FLG-IN              =   ZERO
               PERFORM 900-IN-KENSAKU-SEC
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイル情報取得
      *****************************************************************
       101-ASSIN-GET-SEC                SECTION.
      *
      *    入力ファイル
           MOVE    SPACE               TO  ASS-IN
           STRING  "/home/orca/"       DELIMITED  BY  SIZE
                   PARA-DBFILE         DELIMITED  BY  SPACE
                   "/"                 DELIMITED  BY  SIZE
                   PARA-UPFILE         DELIMITED  BY  SPACE
                                       INTO    ASS-IN
           END-STRING
      *
      *    エラーファイル
           MOVE    SPACE               TO  ASS-ERR
           STRING  "/home/orca/"       DELIMITED  BY  SIZE
                   "orca-mstlog/"      DELIMITED  BY  SIZE
                   PARA-UPFILE         DELIMITED  BY  SPACE
                   ".ERR"              DELIMITED  BY  SIZE
                                       INTO    ASS-ERR
           END-STRING
      *
      *    プルーフファイル
           MOVE    SPACE               TO  ASS-PLF
           STRING  "/home/orca/"       DELIMITED  BY  SIZE
                   "orca-mstlog/"      DELIMITED  BY  SIZE
                   PARA-UPFILE         DELIMITED  BY  SPACE
                   ".PLF"              DELIMITED  BY  SIZE
                                       INTO    ASS-PLF
           END-STRING
      *
      *    DISPLAY "PARA-UPFILE:" PARA-UPFILE
      *    DISPLAY "ASS-IN:" ASS-IN
      *    DISPLAY "ASS-ERR:" ASS-ERR
      *    DISPLAY "ASS-PLF:" ASS-PLF
      *
           .
       101-ASSIN-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    ZERO            TO  WRK-ERRCD
      *
           EVALUATE    TNSWK-SYORIKBN
      *        追加
               WHEN    "I"
                   PERFORM 2010-INSERT-SYORI-SEC
      *        更新
               WHEN    "U"
                   PERFORM 2020-UPDATE-SYORI-SEC
      *        削除
               WHEN    "D"
                   PERFORM 2030-DELETE-SYORI-SEC
           END-EVALUATE
      *
      *    点数マスタ変更ファイル読込み処理
           PERFORM 900-IN-KENSAKU-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    追加  処理
      *****************************************************************
       2010-INSERT-SYORI-SEC               SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    TNSWK-SRYCD         TO  TNS-SRYCD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
           MOVE    TNSWK-YUKOSTYMD     TO  ORC-DBYMD
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               PERFORM                     910-TENSU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
      *    単純追加
           IF      TNSWK-YUKOEDYMD2    =   SPACE
      *        追加エラー
               IF      FLG-TENSU           =   ZERO
                   MOVE    1               TO  WRK-ERRCD
                   PERFORM 2040-ERR-SYORI-SEC
                   GO      TO      2010-INSERT-SYORI-EXT
               END-IF
      *
      *        ＤＢ追加
               PERFORM 20101-TENSU-INS-SEC
           ELSE
      *
      *    追加更新
               MOVE    ZERO                TO  FLG-SYORI
               PERFORM UNTIL   (FLG-TENSU      =   1  )  OR
                               (FLG-SYORI      =   1  )
                   IF     (TNS-YUKOSTYMD   <=  TNSWK-YUKOEDYMD2 ) AND
                          (TNS-YUKOEDYMD   >=  TNSWK-YUKOEDYMD2 )
      *                更新
                       MOVE    TNS-KEY             TO  TNSUP-KEY
                       MOVE    TNSWK-YUKOEDYMD2    TO  TNS-YUKOEDYMD
                       PERFORM 20102-TENSU-UPD-SEC
      *
      *                ＤＢ追加
                       PERFORM 20101-TENSU-INS-SEC
                       IF      WRK-ERRCD           =   ZERO
      *                点数マスタ付加情報追加
                           IF      WRK-TNSP-KEY    NOT =   SPACE
                               PERFORM 20104-TENSUPLUS-INS-SEC
                           END-IF
                       END-IF
      *
                       MOVE    1                   TO  FLG-SYORI
                   ELSE
                       MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
                       PERFORM                     910-TENSU-READ-SEC
                   END-IF
               END-PERFORM
      *
               IF      FLG-SYORI           =   ZERO
      *
      *            ＤＢ追加
                   PERFORM 20101-TENSU-INS-SEC
               END-IF
           END-IF
           .
       2010-INSERT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ追加  処理
      *****************************************************************
       20101-TENSU-INS-SEC           SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    TNSWK-KEY           TO  TNS-KEY
           MOVE    TNSWK-TENSU-REC(35:)
                                       TO  TNS-TENSU-REC(26:)
      *    点数マスタの確認
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           MOVE    TNS-YUKOSTYMD       TO  ORC-DBYMD
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               PERFORM                     910-TENSU-READ-SEC
               IF     (FLG-TENSU           =   ZERO )  AND
                      (TNS-YUKOSTYMD       =   TNSWK-YUKOSTYMD) AND
                      (TNS-YUKOEDYMD       =   TNSWK-YUKOEDYMD)
                   MOVE    5               TO  WRK-ERRCD
                   PERFORM 2040-ERR-SYORI-SEC
                   GO      TO      20101-TENSU-INS-EXT
               END-IF
           END-IF
      *
      *    点数マスタ追加
           INITIALIZE                  TNS-TENSU-REC
           MOVE    TNSWK-KEY           TO  TNS-KEY
           MOVE    TNSWK-TENSU-REC(35:)
                                       TO  TNS-TENSU-REC(26:)
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    1               TO  WRK-ERRCD
               PERFORM 2040-ERR-SYORI-SEC
           ELSE
               ADD     1               TO  CNT-INS
           END-IF
           .
       20101-TENSU-INS-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ更新  処理
      *****************************************************************
       20102-TENSU-UPD-SEC           SECTION.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "TENSU-UPD1"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    2               TO  WRK-ERRCD
               PERFORM 2040-ERR-SYORI-SEC
           END-IF
      *
      *    点数マスタ付加情報更新
           PERFORM 20103-TENSUPLUS-SYORI-SEC
           .
       20102-TENSU-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ更新  処理
      *****************************************************************
       20103-TENSUPLUS-SYORI-SEC       SECTION.
      *
      *
           MOVE    SPACE               TO  TENSUPLUS-REC
           INITIALIZE                      TENSUPLUS-REC
           MOVE    TNSUP-SRYCD         TO  TNSP-SRYCD
           MOVE    TNSUP-YUKOSTYMD     TO  TNSP-YUKOSTYMD
           MOVE    TNSUP-YUKOEDYMD     TO  TNSP-YUKOEDYMD
      *
           MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               PERFORM 980-TENSUPLUS-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-TENSUPLUS
               INITIALIZE                      TENSUPLUS-REC
           END-IF
      *
           MOVE    SPACE               TO  WRK-TENSUPLUS-REC
           IF      FLG-TENSUPLUS       =   ZERO
               MOVE    TENSUPLUS-REC       TO  WRK-TENSUPLUS-REC
      *
               MOVE    TNSP-KEY            TO  TNSPUP-KEY
               MOVE    TNS-KEY             TO  TNSP-KEY
      *
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-UPD1"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   MOVE    4               TO  WRK-ERRCD
                   PERFORM 2040-ERR-SYORI-SEC
               END-IF
           END-IF
      *
           .
       20103-TENSUPLUS-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ付加情報追加処理
      *****************************************************************
       20104-TENSUPLUS-INS-SEC           SECTION.
      *
           MOVE    WRK-TENSUPLUS-REC   TO  TENSUPLUS-REC
      *
           MOVE    TNS-KEY             TO  TNSP-KEY
      *
           MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               PERFORM 980-TENSUPLUS-READ-SEC
               IF      FLG-TENSUPLUS       =   ZERO
                   MOVE    6               TO  WRK-ERRCD
                   PERFORM 2040-ERR-SYORI-SEC
                   GO      TO      20104-TENSUPLUS-INS-EXT
               END-IF
           END-IF
      *
           MOVE    WRK-TENSUPLUS-REC   TO  TENSUPLUS-REC
           MOVE    TNS-KEY             TO  TNSP-KEY
      *
           MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    7               TO  WRK-ERRCD
               PERFORM 2040-ERR-SYORI-SEC
           END-IF
      *
           .
       20104-TENSUPLUS-INS-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新  処理
      *****************************************************************
       2020-UPDATE-SYORI-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-SYORI
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    TNSWK-SRYCD         TO  TNS-SRYCD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
           MOVE    TNSWK-YUKOSTYMD     TO  ORC-DBYMD
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               PERFORM                     910-TENSU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF
           PERFORM UNTIL   (FLG-TENSU      =   1  )  OR
                           (FLG-SYORI      =   1  )
               IF     (TNS-YUKOSTYMD   <=  TNSWK-YUKOSTYMD ) AND
                      (TNS-YUKOEDYMD   >=  TNSWK-YUKOSTYMD )
      *            特定器材で点数識別＝２の時、点数を変更しない
                   IF     (TNSWK-SRYCD(1:1)    =   "7"  )  AND
                          (TNSWK-TENSIKIBETU   =   2    )
                       MOVE    TNS-TEN         TO  WRK-HZN-TEN
                       MOVE    TNS-OLDTEN      TO  WRK-HZN-OLDTEN
                   ELSE
                       MOVE    TNSWK-TEN       TO  WRK-HZN-TEN
                       MOVE    TNSWK-OLDTEN    TO  WRK-HZN-OLDTEN
                   END-IF
      *
      *            更新
                   MOVE    TNS-KEY             TO  WRK-TNSUP-KEY
                   MOVE    TNSWK-KEY           TO  TNS-KEY
                   MOVE    TNSWK-TENSU-REC(35:)
                                               TO  TNS-TENSU-REC(26:)
      *            点数の入れ替え
                   MOVE    WRK-HZN-TEN         TO  TNS-TEN
                   MOVE    WRK-HZN-OLDTEN      TO  TNS-OLDTEN
      *
                   MOVE    WRK-TNSUP-KEY       TO  TNSUP-KEY
                   PERFORM 20102-TENSU-UPD-SEC
                   ADD     1                   TO  CNT-UPD
      *
                   MOVE    1                   TO  FLG-SYORI
               ELSE
                   MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
                   PERFORM                     910-TENSU-READ-SEC
               END-IF
           END-PERFORM
      *
      *    更新エラー
           IF      FLG-SYORI           =   ZERO
               MOVE    3               TO  WRK-ERRCD
               PERFORM 2040-ERR-SYORI-SEC
           END-IF
           .
       2020-UPDATE-SYORI-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    削除  処理
      *****************************************************************
       2030-DELETE-SYORI-SEC           SECTION.
      *
           .
       2030-DELETE-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー処理
      *****************************************************************
       2040-ERR-SYORI-SEC            SECTION.
      *
      *    エラー出力
           MOVE    TNSWK-TENSU-REC    TO  ERR-TNSWK-TENSU-REC
           WRITE                          ERR-TNSWK-TENSU-REC
           ADD     1                  TO  CNT-ERR
      *
      *    エラーメッセージ出力
           PERFORM 20401-PLF-OUT-SEC
      *
           .
       2040-ERR-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ出力処理
      *****************************************************************
       20401-PLF-OUT-SEC            SECTION.
      *
           MOVE    TNSWK-SRYCD        TO  WRK-SRYCD
           MOVE    TNSWK-YUKOSTYMD    TO  WRK-YUKOSTYMD
           MOVE    TNSWK-YUKOEDYMD    TO  WRK-YUKOEDYMD
           MOVE    TNSWK-YUKOEDYMD2   TO  WRK-YUKOEDYMD2
           MOVE    TNSWK-NAME         TO  WRK-NAME
           EVALUATE    WRK-ERRCD
               WHEN    1
                   MOVE    "追加エラー"       TO  WRK-MSG-01
               WHEN    2
                   MOVE    "更新エラー"       TO  WRK-MSG-01
               WHEN   3
                   MOVE    "更新データなし"   TO  WRK-MSG-01
               WHEN   4
                   MOVE    "点数付加更新エラー"
                                               TO  WRK-MSG-01
               WHEN   5
                   MOVE    "点数追加済み"
                                               TO  WRK-MSG-01
               WHEN   6
                   MOVE    "点数付加追加済み"
                                               TO  WRK-MSG-01
               WHEN   7
                   MOVE    "点数付加追加エラー"
                                               TO  WRK-MSG-01
           END-EVALUATE
      *
           MOVE    WRK-MSG-AREA       TO  PLF-REC
           WRITE                          PLF-REC
           ADD     1                  TO  CNT-PLF
      *
           .
       20401-PLF-OUT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    出力ファイル　初期処理
      *****************************************************************
       2700-OUTLST-INIT-SEC            SECTION.
      *
           OPEN    OUTPUT              ERR-FILE
           IF  STS-ERR             NOT =   ZERO
               DISPLAY "*(ORCMUP0001)* OUTFILE OPN STS[" STS-ERR "]"
               GO      TO              2700-OUTLST-INIT-EXT
           END-IF
      *
      *    エラーレコード出力ファイル　オープン
           OPEN    OUTPUT              PLF-FILE
           IF  STS-PLF             NOT =   ZERO
               DISPLAY "*(ORCMUP0001)* PLFFILE OPN STS[" STS-PLF "]"
               GO      TO              2700-OUTLST-INIT-EXT
           END-IF
           ACCEPT  SYS-DATE            FROM    DATE
           COMPUTE WRK-SYY             =   SYS-YY    +   2000
           MOVE    WRK-SYY             TO  MES-TITLE1-YY
           MOVE    SYS-MM              TO  MES-TITLE1-MM
           MOVE    SYS-DD              TO  MES-TITLE1-DD
           MOVE    MES-TITLE1          TO  PLF-REC
           WRITE   PLF-REC
      *
      *
           .
       2700-OUTLST-INIT-EXT.
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
      *    出力ファイル　終了処理
           CLOSE                       IN-FILE
           CLOSE                       ERR-FILE
           CLOSE                       PLF-FILE
      *
           DISPLAY "*(ORCMUP0001)* INPUT  /I   CNT[" CNT-IN  "]"
           DISPLAY "*(ORCMUP0001)*  INSERT     CNT[" CNT-INS "]"
           DISPLAY "*(ORCMUP0001)*  UPDATE     CNT[" CNT-UPD "]"
           DISPLAY "*(ORCMUP0001)*  DELETE     CNT[" CNT-DEL "]"
           DISPLAY "*(ORCMUP0001)* ERR    /O   CNT[" CNT-ERR "]"
           DISPLAY "*(ORCMUP0001)* PLF    /O   CNT[" CNT-PLF "]"
      **** ACCEPT  WRK-IN
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ変更ファイル読込み処理
      *****************************************************************
       900-IN-KENSAKU-SEC          SECTION.
      *
          READ    IN-FILE
              AT  END
                  MOVE    1               TO  FLG-IN
              NOT AT  END
                  MOVE    ZERO            TO  FLG-IN
                  ADD     1               TO  CNT-IN
          END-READ
      *
      *---(01.00.01) LINE ADD START -------------------------------------
          IF   ( FLG-IN            =     ZERO )
               PERFORM 900-IN-DATA-SET-SEC
          END-IF
      *---(01.00.01) LINE ADD END   -------------------------------------
      *
          .
       900-IN-KENSAKU-EXT.
          EXIT.
      *
      *---(01.00.01) LINE ADD START -------------------------------------
      *****************************************************************
      *    点数マスタ変更データ設定処理
      *****************************************************************
       900-IN-DATA-SET-SEC         SECTION.
      *
           EVALUATE    TRUE
           WHEN    LNK-DBRVERSION (3:6)    <   "000907"
               PERFORM 900-TNSWK-V01-SET
      *
           WHEN    OTHER
               MOVE    IN-REC      TO  TNSWK-TENSU-REC
           END-EVALUATE
      *
          .
       900-IN-DATA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    変更後レイアウト移送処理
      *****************************************************************
       900-TNSWK-V01-SET          SECTION.
      *
           MOVE    IN-REC              TO  TNSWK-TENSU-REC-V01
      *
           MOVE    TNSWK-V01-AREA-01   TO  TNSWK-TENSU-REC (1    : 962)
      *     MOVE    ZERO                TO  TNSWK-KIJUNTEIGENKBN
      *     MOVE    ZERO                TO  TNSWK-KIJUNTEIGENCD
           MOVE    ZERO                TO  TNSWK-TENSU-REC (963  : 4)
           MOVE    TNSWK-V01-AREA-02   TO  TNSWK-TENSU-REC (967  : 136)
      *    MOVE    ZERO                TO  TNSWK-KOUHATUKBN
           MOVE    ZERO                TO  TNSWK-TENSU-REC (1103 : 1  )
           MOVE    TNSWK-V01-AREA-03   TO  TNSWK-TENSU-REC (1104 : 192)
      *
          .
       900-TNSWK-V01-EXT.
           EXIT.
      *
      *---(01.00.01) LINE ADD END   -------------------------------------
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               MOVE    ZERO                TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    点数マスタ付加情報読込
      *****************************************************************
       980-TENSUPLUS-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TENSUPLUS-REC
               MOVE    ZERO            TO  FLG-TENSUPLUS
           ELSE
               INITIALIZE                  TENSUPLUS-REC
               MOVE    1               TO  FLG-TENSUPLUS
           END-IF
           .
      *
       980-TENSUPLUS-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
