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
       PROGRAM-ID.                 ORCMUP0011.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＤＢ作成処理
      *  コンポーネント名  : 保険番号マスタ更新処理
      *                    : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/09/05    NACL-藤原     新規作成
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
      *    入力：保険番号マスタ更新ファイル
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
      *    入力：保険番号マスタ更新ファイル
       FD  IN-FILE.
           COPY    "CPHKNNUMWK.INC".
      *
      *    出力：エラーファイル
       FD  ERR-FILE.
           COPY    "CPHKNNUMWK.INC"       REPLACING
                                       //HKNWK-// BY //ERR-HKNWK-//.
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
           03  FLG-SYSKANRI            PIC 9(01).
      *
           03  FLG-SYORI               PIC 9(01).
           03  FLG-HKNNUM              PIC 9(01).
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
               05  WRK-TNSUP-HKNNUM         PIC  X(09).
               05  WRK-TNSUP-TEKSTYMD     PIC  X(08).
               05  WRK-TNSUP-TEKEDYMD     PIC  X(08).
      *
           03  WRK-ERRCD               PIC 9(01). 
      *
           03  WRK-IN                  PIC X(01). 
      *
      *    出力ファイル領域
       01  MES-AREA.
           03  MES-TITLE1.
               05  FILLER              PIC X(21) VALUE
                                       "【PGID:ORCMUP0011.CBL】".
               05  MES-TITLE1-YY       PIC X(04) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-MM       PIC X(02) VALUE SPACE.
               05  FILLER              PIC X(01) VALUE ".".
               05  MES-TITLE1-DD       PIC X(02) VALUE SPACE.
      *
           01  WRK-MSG-AREA.
               03  WRK-MSG-01          PIC X(14).
               03  FILLER              PIC X(01)   VALUE   SPACE.
               03  WRK-HKNNUM          PIC X(03).
               03  FILLER              PIC X(01)   VALUE   ",".
               03  WRK-PAYKBN          PIC X(02).
               03  FILLER              PIC X(01)   VALUE   ",".
               03  WRK-TEKSTYMD        PIC X(08).
               03  FILLER              PIC X(01)   VALUE   ",".
               03  WRK-TEKEDYMD        PIC X(08).
               03  FILLER              PIC X(01)   VALUE   ",".
               03  WRK-TEKEDYMD2       PIC X(08).
               03  FILLER              PIC X(01)   VALUE   ",".
               03  WRK-NAME            PIC X(100).
      *
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
      *    保険番号マスタ−
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    システム管理マスタ
           COPY    "CPSK1001.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
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
      *    医療機関ＩＤ編集
           MOVE    SPACE               TO  SYS-1001-REC
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           ELSE    
               DISPLAY "SYS 001 ERR"
           END-IF                                     
      *
      *    ファイル情報
           PERFORM 101-ASSIN-GET-SEC
      *
      *    入力　初期処理
           OPEN    INPUT           IN-FILE
           IF  STS-IN          NOT =   ZERO
               MOVE    1           TO  FLG-IN
               DISPLAY "*(ORCMUP0011)* IN-FILE OPN STS["
                                       STS-IN "]"
           END-IF
      *
      *    出力ファイル　初期処理
           PERFORM 2700-OUTLST-INIT-SEC
      *
      *    保険番号マスタ更新ファイル読込み処理
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
           EVALUATE    HKNWK-SYORIKBN
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
      *    保険番号マスタ更新ファイル読込み処理
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
           INITIALIZE                  HKNNUM-REC
           MOVE    SYS-1001-HOSPID     TO  HKN-HOSPID
           MOVE    HKNWK-HKNNUM        TO  HKN-HKNNUM
           MOVE    HKNWK-PAYKBN        TO  HKN-PAYKBN
           MOVE    HKNWK-TEKSTYMD      TO  HKN-TEKSTYMD
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
               PERFORM                     910-HKNNUM-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-HKNNUM
           END-IF
      *
      *    単純追加
           IF      HKNWK-TEKEDYMD2    =   SPACE
      *        追加エラー
               IF      FLG-HKNNUM           =   ZERO
                   MOVE    1               TO  WRK-ERRCD
                   PERFORM 2040-ERR-SYORI-SEC
                   GO      TO      2010-INSERT-SYORI-EXT
               END-IF
      *
      *        ＤＢ追加
               PERFORM 20101-HKNNUM-INS-SEC
           ELSE
      *
      *    追加更新
               MOVE    ZERO                TO  FLG-SYORI
               PERFORM UNTIL   (FLG-HKNNUM      =   1  )  OR
                               (FLG-SYORI       =   1  )
                   IF     (HKN-TEKSTYMD   <=  HKNWK-TEKEDYMD2 ) AND
                          (HKN-TEKEDYMD   >   HKNWK-TEKEDYMD2 )
      *                更新
                       MOVE    HKNWK-TEKEDYMD2    TO  HKN-TEKEDYMD
                       PERFORM 20102-HKNNUM-UPD-SEC
      *
      *                ＤＢ追加
                       PERFORM 20101-HKNNUM-INS-SEC
                       MOVE    1                   TO  FLG-SYORI
                   ELSE
                       MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
                       PERFORM                     910-HKNNUM-READ-SEC
                   END-IF
               END-PERFORM
      *
               IF      FLG-SYORI           =   ZERO
      *
      *            ＤＢ追加
                   PERFORM 20101-HKNNUM-INS-SEC
               END-IF
           END-IF
           .
       2010-INSERT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ追加  処理
      *****************************************************************
       20101-HKNNUM-INS-SEC           SECTION.
      *
           INITIALIZE                  HKNNUM-REC
           MOVE    HKNWK-KEY           TO  HKN-KEY
           MOVE    SYS-1001-HOSPID     TO  HKN-HOSPID
           MOVE    HKNWK-TEKEDYMD      TO  HKN-TEKEDYMD
           MOVE    HKNWK-REC (55:)     TO  HKNNUM-REC(46:)
      *    保険番号マスタの確認
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY"    TO  ORC-DBPATH
               PERFORM                     910-HKNNUM-READ-SEC
               IF     (FLG-HKNNUM         =   ZERO )  AND
                      (HKN-TEKSTYMD       =   HKNWK-TEKSTYMD) AND
                      (HKN-TEKEDYMD       =   HKNWK-TEKEDYMD)
                   MOVE    5           TO  WRK-ERRCD
                   PERFORM 2040-ERR-SYORI-SEC
                   GO      TO      20101-HKNNUM-INS-EXT
               END-IF
           END-IF
      *
      *    保険番号マスタ追加
           INITIALIZE                  HKNNUM-REC
           MOVE    HKNWK-KEY           TO  HKN-KEY
           MOVE    SYS-1001-HOSPID     TO  HKN-HOSPID
           MOVE    HKNWK-TEKEDYMD      TO  HKN-TEKEDYMD
           MOVE    HKNWK-REC(55:)      TO  HKNNUM-REC(46:)
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
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
       20101-HKNNUM-INS-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ更新  処理
      *****************************************************************
       20102-HKNNUM-UPD-SEC           SECTION.
      *
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               MOVE    2               TO  WRK-ERRCD
               PERFORM 2040-ERR-SYORI-SEC
           END-IF
           .
       20102-HKNNUM-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新  処理
      *****************************************************************
       2020-UPDATE-SYORI-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-SYORI
      *
           INITIALIZE                  HKNNUM-REC
           MOVE    SYS-1001-HOSPID     TO  HKN-HOSPID
           MOVE    HKNWK-HKNNUM        TO  HKN-HKNNUM
           MOVE    HKNWK-PAYKBN        TO  HKN-PAYKBN    
           MOVE    HKNWK-TEKSTYMD      TO  HKN-TEKSTYMD
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
               PERFORM                     910-HKNNUM-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-HKNNUM
           END-IF
      *
      *    通常更新
           IF      HKNWK-TEKEDYMD2     =   SPACE
               PERFORM UNTIL   (FLG-HKNNUM      =   1  )  OR
                               (FLG-SYORI       =   1  )
                   IF     (HKN-TEKSTYMD   <=  HKNWK-TEKSTYMD ) AND
                          (HKN-TEKEDYMD   >=  HKNWK-TEKSTYMD )
      *                更新
                       MOVE    HKNWK-KEY           TO  HKN-KEY
                       MOVE    SYS-1001-HOSPID     TO  HKN-HOSPID
                       MOVE    HKNWK-TEKEDYMD      TO  HKN-TEKEDYMD
                       MOVE    HKNWK-REC(55:)      TO  HKNNUM-REC(46:)
                       PERFORM 20102-HKNNUM-UPD-SEC
                       ADD     1                   TO  CNT-UPD
      *
                       MOVE    1                   TO  FLG-SYORI
                   ELSE
                       MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
                       PERFORM                     910-HKNNUM-READ-SEC
                   END-IF
               END-PERFORM
           ELSE
      *
      *    期限更新
               PERFORM UNTIL   (FLG-HKNNUM      =   1  )  OR
                               (FLG-SYORI       =   1  )
                   IF     (HKN-TEKSTYMD   <=  HKNWK-TEKEDYMD2 ) AND
                          (HKN-TEKEDYMD   >   HKNWK-TEKEDYMD2 )
      *                更新
                       MOVE    HKNWK-TEKEDYMD2     TO  HKN-TEKEDYMD
                       PERFORM 20102-HKNNUM-UPD-SEC
                       ADD     1                   TO  CNT-UPD
      *
                       MOVE    1                   TO  FLG-SYORI
                   ELSE
                       MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
                       PERFORM                     910-HKNNUM-READ-SEC
                   END-IF
               END-PERFORM
      *
           END-IF
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
           MOVE    HKNWK-REC          TO  ERR-HKNWK-REC
           WRITE                          ERR-HKNWK-REC
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
           MOVE    HKNWK-HKNNUM      TO  WRK-HKNNUM
           MOVE    HKNWK-PAYKBN      TO  WRK-PAYKBN  
           MOVE    HKNWK-TEKSTYMD    TO  WRK-TEKSTYMD
           MOVE    HKNWK-TEKEDYMD    TO  WRK-TEKEDYMD
           MOVE    HKNWK-TEKEDYMD2   TO  WRK-TEKEDYMD2
           MOVE    HKNWK-SEIDONAME   TO  WRK-NAME
           EVALUATE    WRK-ERRCD
               WHEN    1
                   MOVE    "追加エラー"       TO  WRK-MSG-01
               WHEN    2
                   MOVE    "更新エラー"       TO  WRK-MSG-01
               WHEN    3
                   MOVE    "更新データなし"   TO  WRK-MSG-01
               WHEN    5
                   MOVE    "保険番号追加済み"
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
      *****************************************************************
      *    出力ファイル　初期処理
      *****************************************************************
       2700-OUTLST-INIT-SEC            SECTION.
      *
           OPEN    OUTPUT              ERR-FILE
           IF  STS-ERR             NOT =   ZERO
               DISPLAY "*(ORCMUP0011)* OUTFILE OPN STS[" STS-ERR "]"
               GO      TO              2700-OUTLST-INIT-EXT
           END-IF
      *
      *    エラーレコード出力ファイル　オープン
           OPEN    OUTPUT              PLF-FILE
           IF  STS-PLF             NOT =   ZERO
               DISPLAY "*(ORCMUP0011)* PLFFILE OPN STS[" STS-PLF "]"
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
           DISPLAY "*(ORCMUP0011)* INPUT  /I   CNT[" CNT-IN  "]"
           DISPLAY "*(ORCMUP0011)*  INSERT     CNT[" CNT-INS "]"
           DISPLAY "*(ORCMUP0011)*  UPDATE     CNT[" CNT-UPD "]"
           DISPLAY "*(ORCMUP0011)*  DELETE     CNT[" CNT-DEL "]"
           DISPLAY "*(ORCMUP0011)* ERR    /O   CNT[" CNT-ERR "]"
           DISPLAY "*(ORCMUP0011)* PLF    /O   CNT[" CNT-PLF "]"
      **** ACCEPT  WRK-IN
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスタ更新ファイル読込み処理
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
          .
       900-IN-KENSAKU-EXT.
          EXIT.
      *
      *****************************************************************
      *    保険番号マスター読込
      *****************************************************************
       910-HKNNUM-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNNUM-REC
               MOVE    ZERO                TO  FLG-HKNNUM
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1                   TO  FLG-HKNNUM
           END-IF
      *
           .
       910-HKNNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    ZERO                TO  ORC-DBYMD
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       800-SYSKANRI-READ-EXT.
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
      *
           MOVE    "DBSTART"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
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
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
