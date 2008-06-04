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
       PROGRAM-ID.                 ORCXRMST2.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : マスタ更新処理
      *  コンポーネント名  : 更新プログラム実行処理
      *                    : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/02/22    MCC-多々納    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-太田     02/03/18  点数マスタレイアウト変更
      *                                     対応
      * 02.05.00     NACL-竹田    05/04/05  バージョン依存緩和処理追加
      * 03.00.00     NACL-伊藤    06/05/26  MONFUNC対応
      * 04.03.00     NACL-太田    08/05/22  異常処理系強化
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    入力：パラメータファイル
           SELECT  IN-FILE         ASSIGN  PGEXIST01
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-IN.
      *
      *    エラーファイル
           SELECT  MSTERR-FILE     ASSIGN  PARA-ERRFILE
                                   FILE    STATUS IS  STS-MSTERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    入力ファイル
       FD  IN-FILE.
       01  IN-REC.
           03  IN-FIL                  PIC X(01).
      *
      *    エラーファイル
       FD  MSTERR-FILE.
       01  MSTERR-REC              PIC X(200).
      *
       WORKING-STORAGE             SECTION.
grpsys*
grpsys     COPY    "COMMON-SPA".
      *
       01  PGEXIST01                   PIC X(256).
      *    ファイル指定領域
       01  ASS-AREA.
           03  ASS-IN                  PIC X(256).
           03  ASS-ERR                 PIC X(256).
           03  ASS-PLF                 PIC X(256).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-IN                  PIC X(02).
           03  STS-MSTERR              PIC X(02).
           03  STS-OUT                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-IN                  PIC 9(01).
           03  FLG-MSTKANRI            PIC 9(01).
           03  FLG-END                 PIC 9(01).
      *
           03  FLG-SYORI               PIC 9(01).
      *
           03  FLG-CHECK               PIC 9(01).
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PARA                PIC 9(06).
           03  CNT-IN                  PIC 9(06).
           03  CNT-OUT                 PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
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
      *
           03  WRK-IN                  PIC X(01). 
      *
           03  WRK-UPFILE              PIC X(100).
           03  WRK-UPFILE2             PIC X(100).
           03  WRK-MSTERR              PIC X(200).
      *
       01  PARA-AREA.
           03  PARA-MAIN.
               05  PARA-HOSPNUM              PIC 9(02).
               05  PARA-DBFILE               PIC X(13).
               05  PARA-MASTER-KBN           PIC X(02).
               05  PARA-SEPARATE             PIC X(01).
               05  PARA-DBRVERVION           PIC X(21).
               05  PARA-UPPG                 PIC X(10).
               05  PARA-UPFILE               PIC X(100).
           03  PARA-MSTCOUNT                 PIC 9(06).
           03  PARA-MSTSEQ                   PIC 9(06).
           03  PARA-MSTCNTMSG                PIC X(20).
           03  PARA-COUNT                    PIC 9(06).
           03  PARA-ERRFILE                  PIC X(100).
           03  PARA-JOBID                    PIC  9(07).
           03  PARA-SHELLID                  PIC  X(08).
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    マスタ管理情報
       01  MSTKANRI-REC.
           COPY    "CPMSTKANRI.INC".
      *
      *    ジョブ管理情報
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
      *
           COPY    "CPMUPLINK.INC".
      *
           COPY    "CPHOMEDIR.INC".
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
       01  PARA-REC                PIC   X(400).
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
           IF    ( FLG-END =   ZERO )
               PERFORM 200-MAIN-SEC
           END-IF
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
           INITIALIZE                  WRK-AREA
                                       SPA-AREA
                                       PARA-AREA
      *
           UNSTRING    PARA-REC    DELIMITED   BY  ","
           INTO                    PARA-MAIN
                                   PARA-MSTCOUNT
                                   PARA-MSTSEQ
                                   PARA-MSTCNTMSG
                                   PARA-COUNT
                                   PARA-ERRFILE
                                   PARA-JOBID
                                   PARA-SHELLID
           END-UNSTRING
      *
           MOVE    PARA-HOSPNUM    TO  SPA-HOSPNUM
      *
           PERFORM 100-DBOPEN-SEC
      *
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    PARA-HOSPNUM    TO  JOB-HOSPNUM
           MOVE    PARA-JOBID      TO  JOB-JOBID
           MOVE    PARA-SHELLID    TO  JOB-SHELLID
           PERFORM 800-ORCSJOB-SEC
           IF    ( SJOBKANRI-RETURN    =   ZERO )
               IF  ( JOB-STOPFLG       =   1    )
                   PERFORM 500-CAN-HENSYU-SEC
               END-IF
           END-IF
      *
           IF    ( FLG-END         =   ZERO )
      *
      *        ステップ管理開始処理
               MOVE    "STS"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    PARA-HOSPNUM    TO  JOB-HOSPNUM
               MOVE    PARA-JOBID      TO  JOB-JOBID
               MOVE    PARA-SHELLID    TO  JOB-SHELLID
               MOVE    "ORCXRMST2"     TO  JOB-PGID
               STRING  "マスタ更新中 " DELIMITED   BY  SIZE
                       PARA-MSTCNTMSG  DELIMITED   BY  SPACE
               INTO    JOB-SHELLMSG
               END-STRING
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
                                       SPA-AREA
           END-IF
      *
           PERFORM 800-MCNDATE-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    SPACE               TO  WRK-UPFILE
           STRING  PARA-UPFILE         DELIMITED  BY  "*"
                                       INTO    WRK-UPFILE
           END-STRING
      *
           MOVE    ZERO                TO  IDY
           PERFORM VARYING     IDX     FROM    1     BY  1
                   UNTIL       IDX     >   100
               IF      WRK-UPFILE(IDX:1)    =   "/"
                   MOVE    IDX             TO  IDY
               END-IF
           END-PERFORM
      *
           ADD     1                   TO  IDY
           MOVE    SPACE               TO  WRK-UPFILE2
           MOVE    WRK-UPFILE(IDY:)    TO  WRK-UPFILE2
      *
      *    更新プログラム存在チェック
           PERFORM 2001-PGEXIST-CHECK
      *
           IF    ( FLG-END             =   ZERO )
               PERFORM 2001-EXEC-UPPG-SEC
           END-IF
      *
           IF    ( FLG-END             =   ZERO )
               PERFORM 2001-UPDATE-MSTKANRI-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新プログラム実行処理
      *****************************************************************
       2001-EXEC-UPPG-SEC              SECTION.
      *
           INITIALIZE                      LNK-AREA
           MOVE    PARA-DBFILE         TO  LNK-DBFILE
           MOVE    WRK-UPFILE2         TO  LNK-UPFILE
           MOVE    PARA-DBRVERVION     TO  LNK-DBRVERSION
           MOVE    PARA-HOSPNUM        TO  LNK-HOSPNUM
           MOVE    SMCNDATE-YMD        TO  LNK-MNTYMD
           MOVE    SMCNDATE-HMS        TO  LNK-MNTHMS
           MOVE    PARA-COUNT          TO  LNK-COUNT
      *
      *    更新プログラム実行
           CALL    PARA-UPPG           USING
                                       LNK-AREA
      *
           IF    ( LNK-RC          NOT =   ZERO )
               MOVE    SPACE           TO  WRK-MSTERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       2001-EXEC-UPPG-EXT.
           EXIT.
      *****************************************************************
      *    マスタ更新処理
      *****************************************************************
       2001-UPDATE-MSTKANRI-SEC        SECTION.
      *
           PERFORM 900-MSTKANRI-KEY-SEL-SEC
      *
      *    マスタ管理マスタ更新
           IF      FLG-MSTKANRI        =   ZERO
               MOVE    PARA-DBRVERVION TO  MSTKANRI-DBRVERSION1
               MOVE    SMCNDATE-YMD    TO  MSTKANRI-UPYMD
               MOVE    SMCNDATE-HMS    TO  MSTKANRI-UPHMS
               MOVE    MSTKANRI-REC    TO  MCPDATA-REC
               MOVE    "tbl_mstkanri"  TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
grpsys         PERFORM 910-DBUPDATE-SEC
               IF    ( MCP-RC          NOT =   ZERO )
                   DISPLAY "*(ORCXMST2)* DBUPDATE ERR:" MCP-RC
                   MOVE    "マスター管理の更新に失敗しました"
                                       TO  WRK-MSTERR
                   PERFORM 500-ERR-HENSYU-SEC
               END-IF
           ELSE
               PERFORM 920-DBABORT-SEC
               MOVE    "更新対象のマスタデータが存在しません"
                                       TO  WRK-MSTERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       2001-UPDATE-MSTKANRI-EXT.
           EXIT.
      *****************************************************************
      *    更新プログラム存在チェック
      *****************************************************************
       2001-PGEXIST-CHECK              SECTION.
      *
           MOVE    ZERO            TO  FLG-CHECK
      *
           STRING  HOMEDIR-NAME        DELIMITED  BY  SPACE
                   PARA-UPPG           DELIMITED  BY  SPACE
                   ".so"               DELIMITED  BY  SIZE
                                       INTO   PGEXIST01 
           END-STRING
      *    入力　初期処理
           OPEN    INPUT           IN-FILE
           IF      STS-IN          NOT =   ZERO
               STRING  HOMEDIR-NAME        DELIMITED  BY  SPACE
                       "patch-lib/"        DELIMITED  BY  SIZE
                       PARA-UPPG           DELIMITED  BY  SPACE
                       ".so"               DELIMITED  BY  SIZE
                                           INTO   PGEXIST01 
               END-STRING
               OPEN    INPUT           IN-FILE
               IF      STS-IN          NOT =   ZERO
                   MOVE    1           TO  FLG-CHECK
                   DISPLAY "*(ORCXRMST2)* IN-FILE OPN STS["
                                           STS-IN "]"
               ELSE
                   CLOSE    IN-FILE
               END-IF
           ELSE
               CLOSE    IN-FILE
           END-IF
      *
           IF    ( FLG-CHECK       NOT =  ZERO )
               DISPLAY "*(ORCXMST2)* MODULE NOT FOUND:" PARA-UPPG
               MOVE    SPACE           TO  WRK-MSTERR
               STRING  "更新プログラムが存在しません:"
                                       DELIMITED   BY  SIZE
                       PARA-UPPG       DELIMITED   BY  SIZE
               INTO    WRK-MSTERR
               END-STRING
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       2001-PGEXIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブキャンセル処理
      *****************************************************************
       500-CAN-HENSYU-SEC              SECTION.
      *
           MOVE    "処理が中止されました"
                                       TO  WRK-MSTERR
      *
           OPEN    INPUT   MSTERR-FILE
           IF    ( STS-MSTERR          =   ZERO )
               CLOSE   MSTERR-FILE
           ELSE
               OPEN    OUTPUT              MSTERR-FILE
      *
               MOVE    WRK-MSTERR      TO  MSTERR-REC
               WRITE   MSTERR-REC
               CLOSE   MSTERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "CAN"           TO  SJOBKANRI-MODE
               INITIALIZE                   JOBKANRI-REC
               MOVE    PARA-JOBID      TO  JOB-JOBID
               MOVE    PARA-SHELLID    TO  JOB-SHELLID
               MOVE    "8888"          TO  JOB-ERRCD
               MOVE    WRK-MSTERR      TO  JOB-YOBI
               MOVE    SPA-HOSPNUM     TO  JOB-HOSPNUM
               MOVE    2               TO  JOB-STOPFLG
               PERFORM 800-ORCSJOB-SEC
           END-IF
      *
           MOVE    1               TO  FLG-END
      *
           .
       500-CAN-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC              SECTION.
      *
           OPEN    INPUT   MSTERR-FILE
           IF    ( STS-MSTERR          =   ZERO )
               CLOSE   MSTERR-FILE
           ELSE
               OPEN    OUTPUT              MSTERR-FILE
      *
               MOVE    WRK-MSTERR      TO  MSTERR-REC
               WRITE   MSTERR-REC
               CLOSE   MSTERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"            TO  SJOBKANRI-MODE
               INITIALIZE                   JOBKANRI-REC
               MOVE    PARA-JOBID       TO  JOB-JOBID
               STRING  "00"             DELIMITED  BY  SIZE
                       PARA-MASTER-KBN  DELIMITED  BY  SIZE
               INTO    JOB-ERRCD
               END-STRING
               MOVE    PARA-SHELLID    TO  JOB-SHELLID
               MOVE    WRK-MSTERR      TO  JOB-YOBI
               MOVE    SPA-HOSPNUM     TO  JOB-HOSPNUM
               PERFORM 800-ORCSJOB-SEC
           END-IF
      *
           MOVE    1               TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    PARA-HOSPNUM    TO  JOB-HOSPNUM
           MOVE    PARA-JOBID      TO  JOB-JOBID
           MOVE    PARA-SHELLID    TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
                                   SPA-AREA
      *
      *    DB DISCONNECT
           PERFORM 900-DBDISCONNECT-SEC
      *
      *    出力ファイル　終了処理
      **** CLOSE                       IN-FILE
      *
      *    DISPLAY "*(ORCXRMST2)* INPUT  /I   CNT[" CNT-IN  "]"
      *    ACCEPT  WRK-IN
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理サブ
      *****************************************************************
       800-ORCSJOB-SEC                 SECTION.
      *
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA 
                                       JOBKANRI-REC
                                       SPA-AREA
      *
           .
       800-ORCSJOB-EXT.
           EXIT.
      *****************************************************************
      *    入力ファイル読込み処理
      *****************************************************************
      *900-IN-READ-SEC          SECTION.
      *
      *   READ    IN-FILE
      *       AT  END
      *           MOVE    1               TO  FLG-IN
      *       NOT AT  END
      *           MOVE    ZERO            TO  FLG-IN
      *           ADD     1               TO  CNT-IN
      *   END-READ
      *
      *   .
      *900-IN-READ-EXT.
      *   EXIT.
      *****************************************************************
      *    マスタ管理検索処理
      *****************************************************************
       900-MSTKANRI-KEY-SEL-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-MSTKANRI
      *
      *    マスタ管理マスタ検索
           INITIALIZE                  MSTKANRI-REC
           MOVE    "ORCADB"            TO  MSTKANRI-KANRICD
           MOVE    PARA-MASTER-KBN     TO  MSTKANRI-KANRICD(7:2)
           MOVE    SPA-HOSPNUM         TO  MSTKANRI-HOSPNUM
           MOVE    MSTKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_mstkanri"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  MSTKANRI-REC
           ELSE
               INITIALIZE                  MSTKANRI-REC
               MOVE    1               TO  FLG-MSTKANRI
           END-IF
      *
           MOVE    "tbl_mstkanri"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-MSTKANRI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC            SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           IF        ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       910-DBFETCH-SEC             SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    テーブル更新処理
      *****************************************************************
       910-DBUPDATE-SEC            SECTION.
      *
           MOVE    "DBUPDATE"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    テーブル更新処理
      *****************************************************************
       910-INSERT-SEC              SECTION.
      *
           MOVE    "DBINSERT"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
       910-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢアボート処理
      *****************************************************************
       920-DBABORT-SEC                 SECTION.
      *
           INITIALIZE                  JOBKANRI-REC
           MOVE    1               TO  JOB-HOSPNUM
           MOVE    "tbl_jobkanri"  TO  MCP-TABLE
           MOVE    "abort"         TO  MCP-PATHNAME
           MOVE    JOBKANRI-REC    TO  MCPDATA-REC
           PERFORM 910-DBSELECT-SEC
      *
           .
       920-DBABORT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           .
       900-DBDISCONNECT-EXT.
           EXIT.
