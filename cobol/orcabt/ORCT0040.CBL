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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCT0040.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 定期請求
      *  コンポーネント名  : 定期請求データ更新
      *  管理者            :
      *  作成日付    作業者        記述
      *  02/01/07    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     NACL−太田   03.09.02  定期請求印刷情報に設定する
      *                                     氏名をカナ氏名に修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *
      *    定期請求収納ファイル(IN)
           SELECT  TEIKI06-FILE   ASSIGN   TEIKI06PARA
                   ORGANIZATION   LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TEIKI06.
      *
      *    患者請求履歴ファイル(IN)
           SELECT  TEIKI02-FILE    ASSIGN  TEIKI02PARA
                   ORGANIZATION   LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TEIKI02.
      *
      *    請求取消対象収納ファイル(IN)
           SELECT  TEIKI07-FILE   ASSIGN   TEIKI07PARA
                   ORGANIZATION   LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TEIKI07.
      *
      *    削除対象患者請求履歴ファイル(IN)
           SELECT  TEIKI05-FILE    ASSIGN  TEIKI05PARA
                   ORGANIZATION   LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TEIKI05.
      *
      *    エラーファイル
           SELECT  TEIKIERR-FILE   ASSIGN  TEIKIERR
                                   FILE    STATUS  IS  STS-TEIKIERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    定期請求収納ファイル
       FD  TEIKI06-FILE.
       01  TEIKI06-REC.
           COPY    "CPSYUNOU.INC"      REPLACING   //SYU-//
                                       BY          //TEIKI06-//.
      *
      *    定期請求履歴情報ファイル
       FD  TEIKI02-FILE.
       01  TEIKI02-REC.
           COPY    "CPPTTEIKIRRK.INC"  REPLACING   //PTTEIKIRRK-//
                                       BY          //TEIKI02-//.
      *
      *    請求取消対象収納ファイル
       FD  TEIKI07-FILE.
       01  TEIKI07-REC.
           COPY    "CPSYUNOU.INC"      REPLACING   //SYU-//
                                       BY          //TEIKI07-//.
      *
      *    削除対象患者請求履歴ファイル
       FD  TEIKI05-FILE.
       01  TEIKI05-REC.
           COPY    "CPPTTEIKIRRK.INC"  REPLACING   //PTTEIKIRRK-//
                                       BY          //TEIKI05-//.
      *
      *    エラーファイル
       FD  TEIKIERR-FILE.
       01  TEIKIERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *
      *    定期請求収納ファイル名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI06//.
      *
      *
      *    定期請求履歴情報ファイル名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI02//.
      *
      *    請求取消対象収納ファイル名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI07//.
      *
      *    削除対象患者請求履歴ファイル名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01//
                                   BY         //TEIKI05//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01PARA//
                                   BY         //TEIKIERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TEIKIERR                            PIC X(02).
           03  STS-TEIKI06                             PIC X(02).
           03  STS-TEIKI02                             PIC X(02).
           03  STS-TEIKI07                             PIC X(02).
           03  STS-TEIKI05                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-ERR                                 PIC 9(01).
           03  FLG-TEIKI06                             PIC 9(01).
           03  FLG-TEIKI02                             PIC 9(01).
           03  FLG-TEIKI07                             PIC 9(01).
           03  FLG-TEIKI05                             PIC 9(01).
           03  FLG-SYUNOU                              PIC 9(01).
           03  FLG-SYUMEI                              PIC 9(01).
           03  FLG-SYSKANRI                            PIC 9(01).
           03  FLG-SYS5012                             PIC 9(01).
           03  FLG-PTINF                               PIC 9(01).
           03  FLG-PTNYUINRRK                          PIC 9(01).
           03  FLG-TEIKIPRT                            PIC 9(01).
           03  FLG-PTTEIKIRRK                          PIC 9(01).
           03  FLG-TEIKIKANRI                          PIC 9(01).
           03  FLG-TEIKIRRK                            PIC 9(01).
           03  FLG-HIT                                 PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT1                                PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX1                                    PIC 9(04). 
           03  IDX2                                    PIC 9(04). 
           03  IDX3                                    PIC 9(04). 
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME.
               05  SYS-THH         PIC 9(02).
               05  SYS-TMM         PIC 9(02).
               05  SYS-TSS         PIC 9(02).
               05  SYS-TDD         PIC 9(02).
           03  SYS-YMD.
               05  SYS-YY          PIC 9(04).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  SYS-WKYMD.
               05  SYS-WKYY        PIC 9(02).
               05  SYS-WKMM        PIC 9(02).
               05  SYS-WKDD        PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-DBPATH                          PIC  X(100).
           03  WRK-PARA.
               05  WRK-PARA-ARG1.
                   07   WRK-PARA-SRYYM             PIC  X(06).
                   07   WRK-PARA-TERMID            PIC  X(64).
                   07   WRK-PARA-SYSYMD            PIC  X(08).
               05  WRK-PARA-SYOKBN                 PIC  X(01).
               05  WRK-PARA-KIKAN-OCC  OCCURS 3.
                   07  WRK-PARA-KIKAN-ST       PIC  X(08).
                   07  WRK-PARA-KIKAN-ED       PIC  X(08).
                   07  WRK-PARA-KIKAN-KBN      PIC  X(01).
               05  WRK-PARA-JOBID              PIC  9(07).
               05  WRK-PARA-SHELLID            PIC  X(08).
      *
           03  WRK-TEIKIERR                    PIC X(200).
           03  WRK-SKYMONEY                    PIC  S9(07).
           03  WRK-NYUKIN-TOTAL                PIC  S9(07).
           03  WRK-DENPNUM                     PIC 9(07).
           03  WRK-DENPNUM-X                   PIC X(08).
           03  WRK-STR                 PIC X(200).
           03  WRK-LEN                 PIC 9(05).
           03  WRK-SHO                 PIC 9(05).
           03  WRK-AMARI               PIC 9(05).
      *
       01  ERR-EDIT-AREA.
           03  ERR-PTID                PIC 9(10).
           03  ERR-PTNUM               PIC X(20).
           03  ERR-ERRMSG              PIC X(80).
           03  ERR-HEN-ERRMSG          PIC X(80).
      *
      *
      *    定期請求管理集計用ワーク
       01  SUMTEIKIKANRI-REC.
         02    SUMTEIKIKANRI-MAX       PIC 9(05).
         02    SUMTEIKIKANRI-OCC    OCCURS 50.
           COPY  "CPTEIKIKANRI.INC" REPLACING  //TEIKIKANRI-//
                                           BY //SUMTEIKIKANRI-//.
      *
      *    定期請求履歴集計用ワーク
       01  SUMTEIKIRRK-REC.
         02    SUMTEIKIRRK-MAX         PIC 9(05).
         02    SUMTEIKIRRK-OCC     OCCURS 500.
           COPY  "CPTEIKIRRK.INC"  REPLACING  //TEIKIRRK-//
                                           BY //SUMTEIKIRRK-//.
      *
      *    収納明細ワーク
       01  WKSYUMEI-REC.
           COPY  "CPSYUMEI.INC"     REPLACING  //SMEI-//
                                           BY //WKSMEI-//.
      *
      *    定期請求管理情報ワーク
       01  WKTEIKIKANRI-REC.
           COPY  "CPTEIKIKANRI.INC"    REPLACING  //TEIKIKANRI-//
                                           BY //WKTEIKIKANRI-//.
      *
      *    定期請求印刷情報ワーク
       01  WKTEIKIPRT-REC.
           COPY  "CPTEIKIPRT.INC"    REPLACING  //TEIKIPRT-//
                                           BY //WKTEIKIPRT-//.
      *
      *    定期請求履歴情報ワーク
       01  WKTEIKIRRK-REC.
           COPY  "CPTEIKIRRK.INC"    REPLACING  //TEIKIRRK-//
                                           BY //WKTEIKIRRK-//.
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納明細
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *    定期請求管理
       01  TEIKIKANRI-REC.
           COPY    "CPTEIKIKANRI.INC".
      *
      *    定期請求印刷
       01  TEIKIPRT-REC.
           COPY    "CPTEIKIPRT.INC".
      *
      *    定期請求履歴
       01  TEIKIRRK-REC.
           COPY    "CPTEIKIRRK.INC".
      *
      *    患者定期請求履歴
       01  PTTEIKIRRK-REC.
           COPY    "CPPTTEIKIRRK.INC".
      *
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    伝票番号
           COPY    "CPSK0041.INC".
      *    医療機関情報
           COPY    "CPSK1001.INC".
      *    患者番号構成管理情報
           COPY  "CPSK1009.INC".
      *    定期請求作成指示（個別指示）コード
           COPY  "CPSK5012.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    定期請求用収納作成サブ
       01  LNK-ORCS02-REC.
           COPY  "CPORCS02.INC".
       01  LNK-SYUNOU-REC-T.
         02 LNK-SYUNOU-REC     OCCURS 10.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL ( FLG-END =   1 )
                                   OR    ( FLG-ERR =   1 )
      *
           PERFORM 300-TERM-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  INDEX-AREA
                                       CNT-AREA
                                       WRK-AREA
                                       SYS-AREA
                                       SPA-AREA
                                       SUMTEIKIKANRI-REC
                                       SUMTEIKIRRK-REC
      *
           ACCEPT  SYS-TIME    FROM    TIME
      *
           ACCEPT  SYS-WKYMD   FROM    DATE
           COMPUTE SYS-YY  =   SYS-WKYY    +   2000
           COMPUTE SYS-MM  =   SYS-WKMM
           COMPUTE SYS-DD  =   SYS-WKDD
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    WRK-PARA-ARG1
                                               WRK-PARA-SYOKBN
                                               WRK-PARA-KIKAN-OCC (1)
                                               WRK-PARA-KIKAN-OCC (2)
                                               WRK-PARA-KIKAN-OCC (3)
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCT0040"      TO  JOB-PGID
           MOVE    "定期請求データ更新"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
           MOVE    "TEIKI006"          TO  TEIKI06PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI06PARA-TERMID
      *
           MOVE    "TEIKI002"          TO  TEIKI02PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI02PARA-TERMID
      *
           MOVE    "TEIKI007"          TO  TEIKI07PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI07PARA-TERMID
      *
           MOVE    "TEIKI005"          TO  TEIKI05PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKI05PARA-TERMID
      *
           MOVE    "TEIKIERR"          TO  TEIKIERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKIERR-TERMID
      *
           OPEN    INPUT               TEIKI06-FILE
           OPEN    INPUT               TEIKI02-FILE
           OPEN    INPUT               TEIKI07-FILE
           OPEN    INPUT               TEIKI05-FILE
      *
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    ZERO                TO  ORC-DBYMD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           ELSE
               MOVE    "医療機関情報が取得できませんでした。"
                                           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    患者番号構成管理情報編集
           INITIALIZE                  SYS-1009-REC
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
           MOVE    WRK-PARA-SRYYM      TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1009-REC
               MOVE    SYS-1009-PTNUMKSIKBN
                                           TO  SPA-1009-PTNUMKSIKBN
               MOVE    SYS-1009-HJNKSIKBN  TO  SPA-1009-HJNKSIKBN
               MOVE    SYS-1009-HJNKSINENKBN 
                                           TO  SPA-1009-HJNKSINENKBN
               MOVE    SYS-1009-HJNKSIRENNUMKBN
                                           TO  SPA-1009-HJNKSIRENNUMKBN
               MOVE    SYS-1009-HJNKSIRENNUMKETA
                                           TO  SPA-1009-HJNKSIRENNUMKETA
           ELSE
               MOVE    "患者番号構成管理情報が取得できませんでした"
                                           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  100-INIT-EXT
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    定期請求管理情報削除処理
           PERFORM 900-TEIKIKANRI-DEL-SEC
           IF    ( FLG-ERR     =   1 )
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    定期請求印刷情報削除処理
           PERFORM 900-TEIKIPRT-DEL-SEC
           IF    ( FLG-ERR     =   1 )
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    ダミー収納削除処理
           PERFORM 2001-DUMMY-SYUNOU-DEL-SEC
           IF    ( FLG-ERR     =   1 )
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    前回定期請求情報更新処理
           PERFORM 2002-MAE-SEIKYU-KOUSIN-SEC
           IF    ( FLG-ERR     =   1 )
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    定期請求情報更新処理
           PERFORM 2003-SEIKYU-KOUSIN-SEC
           IF    ( FLG-ERR     =   1 )
               GO  TO  200-MAIN-EXT
           END-IF
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ダミー収納削除処理
      *****************************************************************
       2001-DUMMY-SYUNOU-DEL-SEC       SECTION.
      *
      *    IF    ( WRK-PARA-SYOKBN     =   "1" )
      *
      *    --  一括ダミー収納削除処理 --
      *
               INITIALIZE                  SYUNOU-REC
               MOVE    SYS-1001-HOSPID     TO  SYU-HOSPID
               MOVE    "1"                 TO  SYU-NYUGAIKBN
               MOVE    "3"                 TO  SYU-CREATEKBN
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "SYUNOU-DEL2"       TO  ORC-DBPATH
               MOVE    "DBDELETE"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"             USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               IF  (   MCP-RC          NOT =   ZERO )
                   MOVE  "仮収納データ削除処理に失敗しました"
                                   TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2001-DUMMY-SYUNOU-DEL-EXT
               END-IF
      *    ELSE
      *
      *    --  個別ダミー収納削除処理 --
      *
      *        定期請求指示（個別指示）コード読み込み
      *        MOVE    ZERO                TO  FLG-SYS5012
      *        INITIALIZE                      SYS-5012-REC
      *        MOVE    "5012"              TO  SYS-5012-KANRICD
      *        MOVE    ZERO                TO  ORC-DBYMD
      *        MOVE    SYS-5012-REC        TO  MCPDATA-REC
      *        MOVE    "DBSELECT"          TO  MCP-FUNC
      *        MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *        CALL    "ORCMCPSUB"         USING
      *                                    MCPAREA
      *                                    ORCMCPAREA
      *                                    MCPDATA-REC
      *        IF      MCP-RC              =   ZERO
      *            PERFORM 900-SYS5012-READ-SEC
      *        ELSE
      *            MOVE    1               TO  FLG-SYS5012
      *        END-IF
      *
      *        PERFORM UNTIL ( FLG-SYS5012 NOT =   ZERO )
      *
      *            個別ダミー収納削除処理
      *            INITIALIZE              SYUNOU-REC
      *            MOVE    SYS-1001-HOSPID TO  SYU-HOSPID
      *            MOVE    "1"             TO  SYU-NYUGAIKBN
      *            MOVE    SYS-5012-PTID   TO  SYU-PTID
      *            MOVE    "3"             TO  SYU-CREATEKBN
      *            MOVE    SYUNOU-REC      TO  MCPDATA-REC
      *            MOVE    "SYUNOU-DEL3"   TO  ORC-DBPATH
      *            MOVE    "DBDELETE"      TO  MCP-FUNC
      *            CALL    "ORCMCPSUB"     USING
      *                                    MCPAREA
      *                                    ORCMCPAREA
      *                                    MCPDATA-REC
      *            IF  (   MCP-RC          NOT =   ZERO )
      *                MOVE  "個別仮収納データ削除処理に失敗しました"
      *                                    TO  WRK-TEIKIERR
      *                PERFORM 500-ERR-HENSYU-SEC
      *                GO  TO  2001-DUMMY-SYUNOU-DEL-EXT
      *            END-IF
      *
      *            PERFORM 900-SYS5012-READ-SEC
      *
      *        END-PERFORM
      *
      *        カーソルクロース
      *        MOVE    "DBCLOSE"           TO  MCP-FUNC
      *        MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *        CALL    "ORCMCPSUB"             USING
      *                                        MCPAREA
      *                                        ORCMCPAREA
      *                                        MCPDATA-REC
      *    END-IF
      *
           .
       2001-DUMMY-SYUNOU-DEL-EXT.
           EXIT.
      *****************************************************************
      *    前回定期請求情報更新処理
      *****************************************************************
       2002-MAE-SEIKYU-KOUSIN-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-TEIKI07
      *
      *    請求取消対象収納ファイル読込
           PERFORM 910-TEIKI07-READ-SEC
      *
           PERFORM UNTIL ( FLG-TEIKI07 NOT =   ZERO )
      *
      *        収納データ更新処理
               PERFORM 20021-SYUNOU-KOUSIN-SEC
               IF    ( FLG-ERR     =   1 )
                   GO  TO  2002-MAE-SEIKYU-KOUSIN-EXT
               END-IF
      *
      *        請求取消対象収納ファイル読込
               PERFORM 910-TEIKI07-READ-SEC
      *
           END-PERFORM
      *
           MOVE    ZERO                TO  FLG-TEIKI05
      *
      *    削除対象患者請求履歴ファイル読込
           PERFORM 910-TEIKI05-READ-SEC
      *
           PERFORM UNTIL ( FLG-TEIKI05 NOT =   ZERO )
      *
      *        患者定期請求履歴データ更新処理
               PERFORM 20021-PTTEIKIRRK-KOUSIN-SEC
               IF    ( FLG-ERR     =   1 )
                   GO  TO  2002-MAE-SEIKYU-KOUSIN-EXT
               END-IF
      *
      *        定期請求管理情報集計（マイナス分）
               PERFORM 20021-TEIKIRRK-SUM-SEC
      *
      *        削除対象患者請求履歴ファイル読込
               PERFORM 910-TEIKI05-READ-SEC
      *
           END-PERFORM
      *
           .
       2002-MAE-SEIKYU-KOUSIN-EXT.
           EXIT.
      *****************************************************************
      *    収納データ更新処理
      *****************************************************************
       20021-SYUNOU-KOUSIN-SEC         SECTION.
      *
           MOVE    TEIKI07-REC         TO  SYUNOU-REC
      *
      *    収納明細作成処理
           PERFORM 20021-SYUMEI-SAKUSEI-SEC
           IF    ( FLG-ERR     =   1 )
               GO  TO  20021-SYUNOU-KOUSIN-EXT
           END-IF
      *
      *    請求取消として収納マスターを更新
           MOVE    ZERO                TO  SYU-SKYMONEY
      *                                    SYU-NYUKIN-TOTAL
           MOVE    "3"                 TO  SYU-DENPJTIKBN
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    SYU-PTID        TO  ERR-PTID
               MOVE    "収納マスタの更新に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20021-SYUNOU-KOUSIN-EXT
           END-IF
      *
           .
       20021-SYUNOU-KOUSIN-EXT.
           EXIT. 
      *****************************************************************
      *    収納明細作成処理
      *****************************************************************
       20021-SYUMEI-SAKUSEI-SEC        SECTION.
      *
           COMPUTE WRK-SKYMONEY      =   SYU-SKYMONEY        *   -1
      *
      *    伝票番号枝番を求める
           MOVE    ZERO                TO  FLG-SYUMEI
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    "SYUMEI-KEY2"   TO   ORC-DBPATH
               PERFORM 910-SYUMEI-READ-SEC
           ELSE
                MOVE    1              TO  FLG-SYUMEI
           END-IF
      *
           PERFORM VARYING  IDX1   FROM    1   BY   1
               UNTIL ( FLG-SYUMEI  =   1)
               MOVE    "SYUMEI-KEY2"   TO  ORC-DBPATH  
               PERFORM 910-SYUMEI-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    SPACE               TO  SYUMEI-REC
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
      *伝票番号
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
      *伝票番号枝番
           MOVE    IDX1                TO  SMEI-DENPEDANUM
      *入金連番
           MOVE    ZERO                TO  SMEI-NYUKINRENNUM
      *診療科
           MOVE    SYU-SRYKA           TO  SMEI-SRYKA
      *伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *請求発行日（発行日の西暦）
           MOVE    SPACE               TO  SMEI-SKYPRINTYMD
      *請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *領収書発行日
           MOVE    SPACE               TO  SMEI-RYOSYUPRINTYMD
      *領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *請求金額
           MOVE    WRK-SKYMONEY        TO  SMEI-SKYMONEY
      *
      *入返金区分
           MOVE    SPACE               TO  SMEI-NYUHEN-KBN
      *入返金額
           MOVE    ZERO                TO  SMEI-NYUHEN-MONEY
      *入返金日
           MOVE    WRK-PARA-SYSYMD     TO  SMEI-NYUHEN-YMD
      *入金方法
           MOVE    "00"                TO  SMEI-NYUKIN-HOHO
      *状態区分
           MOVE    "5"                 TO  SMEI-JOUTAIKBN
      *
      *    追加対象のデータが既に存在しないかチェック
           MOVE    ZERO                TO  FLG-SYUMEI
           MOVE    SYUMEI-REC          TO  WKSYUMEI-REC
           PERFORM 900-SYUMEI-READ-SEC
      *
           IF    ( FLG-SYUMEI          =   ZERO )
               MOVE    SMEI-PTID       TO  ERR-PTID
               MOVE    "収納明細マスタの更新に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20021-SYUMEI-SAKUSEI-EXT
           END-IF
      *
      *    収納明細追加
           MOVE    WKSYUMEI-REC        TO  SYUMEI-REC
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    SMEI-PTID       TO  ERR-PTID
               MOVE    "収納明細マスタの更新に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20021-SYUMEI-SAKUSEI-EXT
           END-IF
      *
           .
       20021-SYUMEI-SAKUSEI-EXT.
           EXIT. 
      *****************************************************************
      *    患者定期請求履歴データ更新処理
      *****************************************************************
       20021-PTTEIKIRRK-KOUSIN-SEC     SECTION.
      *
           MOVE    TEIKI05-REC         TO  PTTEIKIRRK-REC
      *
           MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
           MOVE    "PTTEIKIRRK-KEY"    TO  ORC-DBPATH
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF  (   MCP-RC          NOT =   ZERO )
               MOVE    PTTEIKIRRK-PTID TO  ERR-PTID
               MOVE    "患者定期請求履歴データの削除に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20021-PTTEIKIRRK-KOUSIN-EXT
           END-IF
      *
           .
       20021-PTTEIKIRRK-KOUSIN-EXT.
           EXIT. 
      *
      *****************************************************************
      *    定期請求管理情報集計（マイナス分）
      *****************************************************************
       20021-TEIKIRRK-SUM-SEC          SECTION.
      *
      *    定期請求管理情報集計（マイナス分）
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   500 )
               EVALUATE SUMTEIKIRRK-SRYYM (IDX1)
                                   ALSO    SUMTEIKIRRK-SAKKBN (IDX1)
               WHEN    SPACE       ALSO    ANY
                   MOVE    PTTEIKIRRK-SRYYM
                                   TO  SUMTEIKIRRK-SRYYM   (IDX1)
                   MOVE    PTTEIKIRRK-SAKKBN
                                   TO  SUMTEIKIRRK-SAKKBN  (IDX1)
                   MOVE    PTTEIKIRRK-SKYSTYMD
                                   TO  SUMTEIKIRRK-SKYSTYMD(IDX1)
                   MOVE    PTTEIKIRRK-SKYEDYMD
                                   TO  SUMTEIKIRRK-SKYEDYMD(IDX1)
                   COMPUTE SUMTEIKIRRK-SKYTEN (IDX1)
                       =   PTTEIKIRRK-SKYTEN     *   -1
                   COMPUTE SUMTEIKIRRK-SKYMONEY (IDX1)
                       =   PTTEIKIRRK-SKYMONEY   *   -1
                   COMPUTE SUMTEIKIRRK-MAX
                       =   SUMTEIKIRRK-MAX     +   1
                   MOVE    500         TO  IDX1
               WHEN    PTTEIKIRRK-SRYYM
                                   ALSO    PTTEIKIRRK-SAKKBN
                   COMPUTE SUMTEIKIRRK-SKYTEN (IDX1)
                       =   SUMTEIKIRRK-SKYTEN (IDX1)
                       + ( PTTEIKIRRK-SKYTEN     *   -1 )
                   COMPUTE SUMTEIKIRRK-SKYMONEY (IDX1)
                       =   SUMTEIKIRRK-SKYMONEY (IDX1)
                       + ( PTTEIKIRRK-SKYMONEY   *   -1 )
                   MOVE    500         TO  IDX1
               END-EVALUATE
           END-PERFORM
      *
           .
       20021-TEIKIRRK-SUM-EXT.
           EXIT. 
      *****************************************************************
      *    定期請求情報更新処理
      *****************************************************************
       2003-SEIKYU-KOUSIN-SEC          SECTION.
      *
           MOVE    ZERO                    TO  FLG-TEIKI06
      *
      *    定期請求収納ファイル読込
           PERFORM 910-TEIKI06-READ-SEC
      *
           PERFORM UNTIL ( FLG-TEIKI06 NOT =   ZERO )
      *
      *        伝票番号取得処理
               PERFORM 20031-DENPNUM-GET-SEC
               IF (  FLG-ERR   =   1 )
                   GO  TO  2003-SEIKYU-KOUSIN-EXT
               END-IF
               MOVE    WRK-DENPNUM         TO  TEIKI06-DENPNUM
      *
               MOVE    TEIKI06-REC         TO  SYUNOU-REC
      *
      *        更新前チェック（既に重複するデータがある場合はエラー）
               MOVE   ZERO                 TO  FLG-SYUNOU
               PERFORM 900-SYUNOU-READ-SEC
               IF    ( FLG-SYUNOU          =   ZERO )
                   MOVE    SYU-PTID        TO  ERR-PTID
                   MOVE    "収納データの更新に失敗しました"
                                           TO  ERR-ERRMSG
                   PERFORM 800-ERRMSG-EDIT-SEC
                   MOVE    ERR-HEN-ERRMSG
                                           TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2003-SEIKYU-KOUSIN-EXT
               END-IF
      *
               MOVE    TEIKI06-REC         TO  SYUNOU-REC
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               MOVE    "DBINSERT"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          NOT =   ZERO )
                   MOVE    SYU-PTID        TO  ERR-PTID
                   MOVE    "収納データの更新に失敗しました"
                                           TO  ERR-ERRMSG
                   PERFORM 800-ERRMSG-EDIT-SEC
                   MOVE    ERR-HEN-ERRMSG
                                           TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2003-SEIKYU-KOUSIN-EXT
               END-IF
      *
      *        収納明細作成処理
               PERFORM 20031-SYUMEI-SAKUSEI-SEC
               IF (  FLG-ERR   =   1 )
                   GO  TO  2003-SEIKYU-KOUSIN-EXT
               END-IF
      *
      *        最新病棟番号別集計処理
               PERFORM 20031-NOW-BTUNUM-SUM-SEC
               IF (  FLG-ERR   =   1 )
                   GO  TO  2003-SEIKYU-KOUSIN-EXT
               END-IF
      *
      *        定期請求印刷情報作成処理
               PERFORM 20031-TEIKIPRT-SAKUSEI-SEC
               IF (  FLG-ERR   =   1 )
                   GO  TO  2003-SEIKYU-KOUSIN-EXT
               END-IF
      *
      *        定期請求収納ファイル読込
               PERFORM 910-TEIKI06-READ-SEC
      *
           END-PERFORM
      *
           MOVE    ZERO                    TO  FLG-TEIKI02
      *
      *    患者請求履歴ファイル読込
           PERFORM 910-TEIKI02-READ-SEC
      *
           PERFORM UNTIL ( FLG-TEIKI02 NOT =   ZERO )
      *
               MOVE    TEIKI02-REC         TO  PTTEIKIRRK-REC
      *
      *        更新前チェック（既に重複するデータがある場合はエラー）
               MOVE   ZERO                 TO  FLG-PTTEIKIRRK
               PERFORM 900-PTTEIKIRRK-READ-SEC
               IF    ( FLG-PTTEIKIRRK  =   ZERO )
                   MOVE    PTTEIKIRRK-PTID TO  ERR-PTID
                   MOVE    "患者請求履歴データの更新に失敗しました"
                                           TO  ERR-ERRMSG
                   PERFORM 800-ERRMSG-EDIT-SEC
                   MOVE    ERR-HEN-ERRMSG
                                           TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2003-SEIKYU-KOUSIN-EXT
               END-IF
      *
               MOVE    TEIKI02-REC         TO  PTTEIKIRRK-REC
      *
      *        収納伝票番号取得処理
               PERFORM 20031-SYU-DENPNUM-GET-SEC
               IF    ( FLG-ERR    =        1 )
                   GO  TO  2003-SEIKYU-KOUSIN-EXT
               END-IF
      *
               MOVE    WRK-DENPNUM         TO  PTTEIKIRRK-DENPNUM
      *
               MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
               MOVE    "PTTEIKIRRK-KEY"    TO  ORC-DBPATH
               MOVE    "DBINSERT"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          NOT =   ZERO )
                   MOVE    PTTEIKIRRK-PTID TO  ERR-PTID
                   MOVE    "患者請求履歴データの更新に失敗しました"
                                           TO  ERR-ERRMSG
                   PERFORM 800-ERRMSG-EDIT-SEC
                   MOVE    ERR-HEN-ERRMSG
                                           TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2003-SEIKYU-KOUSIN-EXT
               END-IF
      *
      *        定期請求管理情報集計（プラス分）
               PERFORM 20031-TEIKIRRK-SUM-SEC
      *
      *        患者請求履歴ファイル読込
               PERFORM 910-TEIKI02-READ-SEC
      *
           END-PERFORM
      *
      *    定期請求管理情報更新処理
           PERFORM 20031-TEIKIKANRI-KOUSIN-SEC
           IF    ( FLG-ERR     =   1 )
               GO  TO  2003-SEIKYU-KOUSIN-EXT
           END-IF
      *
      *    定期請求履歴情報更新処理
           PERFORM 20031-TEIKIRRK-KOUSIN-SEC
           IF    ( FLG-ERR     =   1 )
               GO  TO  2003-SEIKYU-KOUSIN-EXT
           END-IF
      *
           .
       2003-SEIKYU-KOUSIN-EXT.
           EXIT. 
      *****************************************************************
      *    伝票番号取得処理
      *****************************************************************
       20031-DENPNUM-GET-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
                                           WRK-DENPNUM
      *
           INITIALIZE                  SYS-0041-REC.
           MOVE    "0041"              TO  SYS-0041-KANRICD
           MOVE    "*"                 TO  SYS-0041-KBNCD
           MOVE    ZERO                TO  SYS-0041-STYUKYMD
           MOVE    ALL "9"             TO  SYS-0041-EDYUKYMD
      *
           MOVE    WRK-PARA-SYSYMD     TO  ORC-DBYMD
           MOVE    SYS-0041-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-0041-REC
           END-IF
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    SYS-0041-DENPNUMMAX-NYU
                                       TO  WRK-DENPNUM-X
               IF    ( WRK-DENPNUM-X   =   SPACE )
                   MOVE    ZERO        TO  SYS-0041-DENPNUMMAX-NYU
               ELSE
                   MOVE    WRK-DENPNUM-X
                                       TO  SYS-0041-DENPNUMMAX-NYU
               END-IF
      *
               COMPUTE SYS-0041-DENPNUMMAX-NYU
                   =   SYS-0041-DENPNUMMAX-NYU +   1
      *
               MOVE    SYS-0041-DENPNUMMAX-NYU
                                           TO  WRK-DENPNUM
      *
               MOVE    SYS-0041-REC        TO  MCPDATA-REC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          NOT =   ZERO )
                   MOVE    SPACE       TO  WRK-TEIKIERR
                   STRING  "伝票番号の更新に失敗しました"
                                          DELIMITED    BY  SIZE
                           "[伝票番号:"   DELIMITED    BY  SIZE
                           SYS-0041-DENPNUMMAX-NYU
                                          DELIMITED    BY  SIZE
                           "]"            DELIMITED    BY  SIZE
                   INTO    WRK-TEIKIERR
                   END-STRING
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  20031-DENPNUM-GET-EXT
               END-IF
           ELSE
               MOVE    SPACE       TO  WRK-TEIKIERR
               STRING  "伝票番号の更新に失敗しました"
                                      DELIMITED    BY  SIZE
                       "[伝票番号:"   DELIMITED    BY  SIZE
                       SYS-0041-DENPNUMMAX-NYU
                                      DELIMITED    BY  SIZE
                       "]"            DELIMITED    BY  SIZE
               INTO    WRK-TEIKIERR
               END-STRING
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20031-DENPNUM-GET-EXT
           END-IF
      *
           .
       20031-DENPNUM-GET-EXT.
           EXIT.
      *****************************************************************
      *    収納明細作成処理
      *****************************************************************
       20031-SYUMEI-SAKUSEI-SEC        SECTION.
      *
           MOVE    SPACE               TO  SYUMEI-REC
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
      *
      *    伝票番号
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
      *    伝票番号枝番
           MOVE    01                  TO  SMEI-DENPEDANUM
      *診療科
           MOVE    SYU-SRYKA           TO  SMEI-SRYKA
      *    伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *    請求発行日（発行日の西暦）
           MOVE    WRK-PARA-SYSYMD     TO  SMEI-SKYPRINTYMD
      *    請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *    領収書発行日
           MOVE    SMEI-SKYPRINTYMD    TO  SMEI-RYOSYUPRINTYMD
      *    領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *    請求金額
           MOVE    SYU-SKYMONEY        TO  SMEI-SKYMONEY
      *    入返金日
           MOVE    SMEI-SKYPRINTYMD    TO  SMEI-NYUHEN-YMD
      *    入金連番
           MOVE    01                  TO  SMEI-NYUKINRENNUM
      *
      *    状態区分
           IF    ( SYU-SKYMONEY        =   ZERO )
               MOVE    SPACE           TO  SMEI-JOUTAIKBN
           ELSE
               MOVE    "9"             TO  SMEI-JOUTAIKBN
           END-IF
      *
           MOVE    SYUMEI-REC          TO  WKSYUMEI-REC
      *
      *    更新前チェック（既に重複するデータがある場合はエラー）
           MOVE   ZERO                 TO  FLG-SYUMEI
           PERFORM 900-SYUMEI-READ-SEC
           IF    ( FLG-SYUMEI  =   ZERO )
               MOVE    SMEI-PTID       TO  ERR-PTID
               MOVE    "収納明細マスタの更新に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20031-SYUMEI-SAKUSEI-EXT
           END-IF
      *
           MOVE    WKSYUMEI-REC    TO  SYUMEI-REC
           MOVE    SYUMEI-REC      TO  MCPDATA-REC
           MOVE    "SYUMEI-KEY"    TO  ORC-DBPATH
           MOVE    "DBINSERT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    SMEI-PTID       TO  ERR-PTID
               MOVE    "収納明細マスタの更新に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20031-SYUMEI-SAKUSEI-EXT
           END-IF
      *
           .
       20031-SYUMEI-SAKUSEI-EXT.
           EXIT. 
      *****************************************************************
      *    最新病棟番号別集計処理
      *****************************************************************
       20031-NOW-BTUNUM-SUM-SEC        SECTION.
      *
      *    患者情報読み込み
           MOVE    SYU-HOSPID          TO  PTINF-HOSPID
           MOVE    SYU-PTID            TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF    ( FLG-PTINF       NOT =   ZERO )
               MOVE    PTINF-PTID      TO  ERR-PTID
               MOVE    "患者情報の取得に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20031-NOW-BTUNUM-SUM-EXT
           END-IF
      *
      *    最新の入院履歴情報より病棟番号を取得
           INITIALIZE  PTNYUINRRK-REC
           MOVE    PTINF-HOSPID        TO  PTNYUINRRK-HOSPID
           MOVE    PTINF-PTID          TO  PTNYUINRRK-PTID
           MOVE    PTINF-RRKNUM        TO  PTNYUINRRK-RRKNUM
           MOVE    PTINF-RRKEDANUM     TO  PTNYUINRRK-RRKEDANUM
           PERFORM 900-PTNYUINRRK-READ-SEC
           IF    ( FLG-PTNYUINRRK  NOT =   ZERO )
               MOVE    PTNYUINRRK-PTID TO  ERR-PTID
               MOVE    "最新入院履歴の取得に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20031-NOW-BTUNUM-SUM-EXT
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   50 )
               EVALUATE SUMTEIKIKANRI-BTUNUM (IDX1)
               WHEN    SPACE
                   MOVE    PTNYUINRRK-BTUNUM
                                   TO  SUMTEIKIKANRI-BTUNUM (IDX1)
                   MOVE    1       TO  SUMTEIKIKANRI-KENSU (IDX1)
                   COMPUTE SUMTEIKIKANRI-MAX
                       =   SUMTEIKIKANRI-MAX   +   1
                   MOVE    50      TO  IDX1
               WHEN    PTNYUINRRK-BTUNUM
                   COMPUTE SUMTEIKIKANRI-KENSU (IDX1)
                       =   SUMTEIKIKANRI-KENSU (IDX1)  +   1
                   MOVE    50      TO  IDX1
               END-EVALUATE
           END-PERFORM
           .
      *
       20031-NOW-BTUNUM-SUM-EXT.
           EXIT. 
      *****************************************************************
      *    定期請求印刷情報作成
      *****************************************************************
       20031-TEIKIPRT-SAKUSEI-SEC          SECTION.
      *
           INITIALIZE  TEIKIPRT-REC
           MOVE    PTNYUINRRK-BTUNUM       TO  TEIKIPRT-BTUNUM
           MOVE    PTINF-HOSPID            TO  TEIKIPRT-HOSPID
           MOVE    PTINF-PTID              TO  TEIKIPRT-PTID
      *
      *    患者番号を取得
           INITIALIZE                      ORCSPTIDAREA
           MOVE    PTINF-HOSPID            TO  SPTID-HOSPID
           MOVE    PTINF-PTID              TO  SPTID-PTID
           CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                           SPA-1009-TBL
           IF    ( SPTID-RC        NOT =   ZERO )
               MOVE    PTINF-PTID      TO  ERR-PTID
               MOVE    "患者番号の取得に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20031-TEIKIPRT-SAKUSEI-EXT
           END-IF
           MOVE    SPTID-PTNUM             TO  TEIKIPRT-PTNUM
      *
           MOVE    PTINF-KANANAME          TO  TEIKIPRT-NAME
           MOVE    SYU-DENPNUM             TO  TEIKIPRT-DENPNUM
      *
           MOVE    TEIKIPRT-REC            TO  WKTEIKIPRT-REC
      *
      *    更新対象のデータがすでに存在する場合はエラー
           PERFORM 900-TEIKIPRT-READ-SEC
           IF    ( FLG-TEIKIPRT    =   ZERO )
               MOVE    TEIKIPRT-PTID   TO  ERR-PTID
               MOVE    "定期請求印刷情報データの作成に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20031-TEIKIPRT-SAKUSEI-EXT
           END-IF
      *
           MOVE    WKTEIKIPRT-REC      TO  TEIKIPRT-REC
      *
      *    定期請求印刷データ作成
           MOVE    TEIKIPRT-REC        TO  MCPDATA-REC
           MOVE    "TEIKIPRT-KEY"      TO  ORC-DBPATH
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF  (   MCP-RC          NOT =   ZERO )
               MOVE    TEIKIPRT-PTID   TO  ERR-PTID
               MOVE    "定期請求印刷情報データの作成に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20031-TEIKIPRT-SAKUSEI-EXT
           END-IF
      *
           .
       20031-TEIKIPRT-SAKUSEI-EXT.
            EXIT.
      *****************************************************************
      *    定期請求管理情報集計（プラス分）
      *****************************************************************
       20031-TEIKIRRK-SUM-SEC          SECTION.
      *
      *    定期請求管理情報集計（プラス分）
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   500 )
               EVALUATE SUMTEIKIRRK-SRYYM (IDX1)
                                   ALSO    SUMTEIKIRRK-SAKKBN (IDX1)
               WHEN    SPACE       ALSO    ANY
                   MOVE    PTTEIKIRRK-SRYYM
                                   TO  SUMTEIKIRRK-SRYYM   (IDX1)
                   MOVE    PTTEIKIRRK-SAKKBN
                                   TO  SUMTEIKIRRK-SAKKBN  (IDX1)
                   MOVE    PTTEIKIRRK-SKYSTYMD
                                   TO  SUMTEIKIRRK-SKYSTYMD(IDX1)
                   MOVE    PTTEIKIRRK-SKYEDYMD
                                   TO  SUMTEIKIRRK-SKYEDYMD(IDX1)
                   COMPUTE SUMTEIKIRRK-SKYTEN (IDX1)
                       =   PTTEIKIRRK-SKYTEN
                   COMPUTE SUMTEIKIRRK-SKYMONEY (IDX1)
                       =   PTTEIKIRRK-SKYMONEY
                   COMPUTE SUMTEIKIRRK-MAX
                       =   SUMTEIKIRRK-MAX     +   1
                   MOVE    500         TO  IDX1
               WHEN    PTTEIKIRRK-SRYYM
                                   ALSO    PTTEIKIRRK-SAKKBN
                   COMPUTE SUMTEIKIRRK-SKYTEN (IDX1)
                       =   SUMTEIKIRRK-SKYTEN (IDX1)
                       +   PTTEIKIRRK-SKYTEN
                   COMPUTE SUMTEIKIRRK-SKYMONEY (IDX1)
                       =   SUMTEIKIRRK-SKYMONEY (IDX1)
                       +   PTTEIKIRRK-SKYMONEY
                   MOVE    500         TO  IDX1
               END-EVALUATE
           END-PERFORM
      *
           .
       20031-TEIKIRRK-SUM-EXT.
           EXIT. 
      *****************************************************************
      *    定期請求管理情報更新処理
      *****************************************************************
       20031-TEIKIKANRI-KOUSIN-SEC     SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SUMTEIKIKANRI-MAX )
      *
               INITIALIZE  TEIKIKANRI-REC
      *
               MOVE    SUMTEIKIKANRI-BTUNUM (IDX1)
                                       TO  TEIKIKANRI-BTUNUM
               MOVE    WRK-PARA-SYOKBN
                                       TO  TEIKIKANRI-SYOKBN
               MOVE    WRK-PARA-SYSYMD TO  TEIKIKANRI-CREYMD
               MOVE    SYS-TIME        TO  TEIKIKANRI-CREHMS
      *
               IF    ( WRK-PARA-SYOKBN =   "1" )
                   MOVE    WRK-PARA-SRYYM
                                       TO  TEIKIKANRI-SRYYM
               END-IF
      *
               MOVE    SUMTEIKIKANRI-KENSU (IDX1)
                                       TO  TEIKIKANRI-PAGE
                                           TEIKIKANRI-KENSU
               MOVE    WRK-PARA-TERMID TO  TEIKIKANRI-TERMID
      *
               MOVE    TEIKIKANRI-REC  TO  WKTEIKIKANRI-REC
      *
      *        更新対象のデータがすでに存在する場合はエラー
               PERFORM 900-TEIKIKANRI-READ-SEC
               IF    ( FLG-TEIKIKANRI  =   ZERO )
                   MOVE  "定期請求管理情報データの作成に失敗しました"
                                       TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  20031-TEIKIKANRI-KOUSIN-EXT
               END-IF
      *
               MOVE    WKTEIKIKANRI-REC    TO  TEIKIKANRI-REC
      *
      *        定期請求管理データ作成
               MOVE    TEIKIKANRI-REC      TO  MCPDATA-REC
               MOVE    "TEIKIKANRI-KEY"    TO  ORC-DBPATH
               MOVE    "DBINSERT"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF  (   MCP-RC          NOT =   ZERO )
                   MOVE  "定期請求管理情報データの作成に失敗しました"
                                       TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  20031-TEIKIKANRI-KOUSIN-EXT
               END-IF
      *
           END-PERFORM
      *
           .
       20031-TEIKIKANRI-KOUSIN-EXT.
           EXIT. 
      *****************************************************************
      *    定期請求履歴情報更新処理
      *****************************************************************
       20031-TEIKIRRK-KOUSIN-SEC       SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SUMTEIKIRRK-MAX )
      *
               INITIALIZE  TEIKIRRK-REC
      *
               MOVE    SUMTEIKIRRK-SRYYM    (IDX1)
                                       TO  TEIKIRRK-SRYYM
               MOVE    SUMTEIKIRRK-SAKKBN   (IDX1)
                                       TO  TEIKIRRK-SAKKBN
               MOVE    SUMTEIKIRRK-SKYSTYMD (IDX1)
                                       TO  TEIKIRRK-SKYSTYMD
               MOVE    SUMTEIKIRRK-SKYEDYMD (IDX1)
                                       TO  TEIKIRRK-SKYEDYMD
               MOVE    SUMTEIKIRRK-SKYTEN   (IDX1)
                                       TO  TEIKIRRK-SKYTEN
               MOVE    SUMTEIKIRRK-SKYMONEY (IDX1)
                                       TO  TEIKIRRK-SKYMONEY
               MOVE    WRK-PARA-TERMID TO  TEIKIRRK-TERMID
               MOVE    SYS-YMD         TO  TEIKIRRK-CREYMD
                                           TEIKIRRK-UPYMD
               MOVE    SYS-TIME        TO  TEIKIRRK-UPHMS
      *
               MOVE    TEIKIRRK-REC    TO  WKTEIKIRRK-REC
      *
               PERFORM 900-TEIKIRRK-READ-SEC
      *        更新対象のデータがすでに存在する場合は更新
      *        存在しない場合は追加
               IF    ( FLG-TEIKIRRK  =   ZERO )
      *
                   COMPUTE TEIKIRRK-SKYTEN
                       =   TEIKIRRK-SKYTEN
                       +   SUMTEIKIRRK-SKYTEN   (IDX1)
      *
                   COMPUTE TEIKIRRK-SKYMONEY
                       =   TEIKIRRK-SKYMONEY
                       +   SUMTEIKIRRK-SKYMONEY (IDX1)
      *
      *            定期請求管理データ更新
                   MOVE    TEIKIRRK-REC    TO  MCPDATA-REC
                   MOVE    "TEIKIRRK-KEY"  TO  ORC-DBPATH
                   MOVE    "DBUPDATE"      TO  MCP-FUNC
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF  (   MCP-RC          NOT =   ZERO )
                       MOVE  "定期請求履歴データの更新に失敗しました"
                                           TO  WRK-TEIKIERR
                       PERFORM 500-ERR-HENSYU-SEC
                       GO  TO  20031-TEIKIRRK-KOUSIN-EXT
                   END-IF
               ELSE
      *
                   MOVE    WKTEIKIRRK-REC  TO  TEIKIRRK-REC
      *
      *            定期請求管理データ作成
                   MOVE    TEIKIRRK-REC    TO  MCPDATA-REC
                   MOVE    "TEIKIRRK-KEY"  TO  ORC-DBPATH
                   MOVE    "DBINSERT"      TO  MCP-FUNC
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF  (   MCP-RC          NOT =   ZERO )
                       MOVE  "定期請求履歴データの作成に失敗しました"
                                           TO  WRK-TEIKIERR
                       PERFORM 500-ERR-HENSYU-SEC
                       GO  TO  20031-TEIKIRRK-KOUSIN-EXT
                   END-IF
               END-IF
      *
      *
           END-PERFORM
      *
           .
       20031-TEIKIRRK-KOUSIN-EXT.
           EXIT. 
      *****************************************************************
      *    収納伝票番号取得処理
      *****************************************************************
       20031-SYU-DENPNUM-GET-SEC           SECTION.
      *
           MOVE    ZERO                TO  WRK-DENPNUM
      *
      *    収納マスタ検索
           MOVE    ZERO                TO  FLG-SYUNOU
           INITIALIZE  SYUNOU-REC
           MOVE    SYS-1001-HOSPID     TO  SYU-HOSPID
           MOVE    "1"                 TO  SYU-NYUGAIKBN
           MOVE    PTTEIKIRRK-PTID     TO  SYU-PTID
           MOVE    PTTEIKIRRK-SRYYM    TO  SYU-SRYYMD
           MOVE    "__"                TO  SYU-SRYYMD (7 : )
           MOVE    PTTEIKIRRK-SKYSTYMD TO  SYU-SKYSTYMD
           MOVE    PTTEIKIRRK-SKYEDYMD TO  SYU-SKYEDYMD
           MOVE    PTTEIKIRRK-HKNCOMBINUM
                                       TO  SYU-HKNCOMBINUM
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "SYUNOU-KEY18"      TO  ORC-DBPATH
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-SYUNOU-KEY18-READ-SEC
           ELSE
               MOVE    1           TO  FLG-SYUNOU
           END-IF
      *
           MOVE    ZERO            TO  FLG-HIT
           PERFORM UNTIL ( FLG-SYUNOU  NOT =   ZERO )
                   OR    ( FLG-HIT =   1 )
      *
               IF    ( SYU-DENPJTIKBN  NOT =   "3" )
                   MOVE    1       TO  FLG-HIT
               END-IF
      *
               IF    ( FLG-HIT     =   ZERO )
                   PERFORM 910-SYUNOU-KEY18-READ-SEC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SYUNOU-KEY18"      TO  ORC-DBPATH
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF    ( FLG-HIT         =   ZERO )
               MOVE    PTTEIKIRRK-PTID TO  ERR-PTID
               MOVE    "収納データの取得に失敗しました"
                                       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG  TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20031-SYU-DENPNUM-GET-EXT
           END-IF
      *
           MOVE    SYU-DENPNUM         TO  WRK-DENPNUM
           .
      *
       20031-SYU-DENPNUM-GET-EXT.
           EXIT. 
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC              SECTION.
      *
           OPEN    INPUT   TEIKIERR-FILE
           IF      STS-TEIKIERR         =   ZERO
               CLOSE   TEIKIERR-FILE
           ELSE
               OPEN    OUTPUT              TEIKIERR-FILE
      *
               MOVE    WRK-TEIKIERR         TO  TEIKIERR-REC
               WRITE   TEIKIERR-REC
               CLOSE   TEIKIERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-TEIKIERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *                             
           MOVE    1                   TO  FLG-ERR
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   TEIKI06-FILE
                   TEIKI02-FILE
                   TEIKI07-FILE
                   TEIKI05-FILE
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *     
           DISPLAY "TEIKI06 (ORCT0040) CNT " CNT-OUT1 
           DISPLAY "*** ORCT0040 END ***"
      ***  ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ編集処理
      *****************************************************************
       800-ERRMSG-EDIT-SEC             SECTION.
      *
           MOVE    SPACE               TO  ERR-HEN-ERRMSG
                                           ERR-PTNUM
      *
      *    患者番号を取得
           INITIALIZE                      ORCSPTIDAREA
           MOVE    SYS-1001-HOSPID     TO  SPTID-HOSPID
           MOVE    ERR-PTID            TO  SPTID-PTID
           CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                           SPA-1009-TBL
           IF    ( SPTID-RC            =   ZERO )
               MOVE    SPTID-PTNUM     TO  ERR-PTNUM
           ELSE
               STRING "?(ID:"          DELIMITED   BY  SIZE
                      ERR-PTID         DELIMITED   BY  SIZE
                      ")"              DELIMITED   BY  SIZE
               INTO   ERR-PTNUM
               END-STRING
           END-IF
      *
           MOVE    1                   TO  WRK-LEN
           MOVE    SPACE               TO  WRK-STR
           STRING  ERR-PTNUM           DELIMITED   BY  SPACE
           INTO    WRK-STR
           WITH  POINTER WRK-LEN
           END-STRING
      *
           COMPUTE WRK-LEN =   WRK-LEN -   1
      *
           MOVE    ZERO                TO  WRK-SHO
                                           WRK-AMARI
           DIVIDE  2   INTO    WRK-LEN GIVING  WRK-SHO
           REMAINDER WRK-AMARI
           END-DIVIDE
      *
           IF    ( WRK-AMARI   =   ZERO )
               STRING  ERR-ERRMSG          DELIMITED   BY  SPACE
                       "［患者番号："      DELIMITED   BY  SIZE
                       ERR-PTNUM           DELIMITED   BY  SPACE
                       "］"                DELIMITED   BY  SIZE
               INTO    ERR-HEN-ERRMSG
               END-STRING
           ELSE
               STRING  ERR-ERRMSG          DELIMITED   BY  SPACE
                       "［患者番号:"       DELIMITED   BY  SIZE
                       ERR-PTNUM           DELIMITED   BY  SPACE
                       "］"                DELIMITED   BY  SIZE
               INTO    ERR-HEN-ERRMSG
               END-STRING
           END-IF
      *
           .
       800-ERRMSG-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
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
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
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
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスター読込（主キー）
      *****************************************************************
       900-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SYUNOU-REC
                   MOVE    ZERO                TO  FLG-SYUNOU
               ELSE
                   MOVE    1                   TO  FLG-SYUNOU
                   INITIALIZE                  SYUNOU-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYUNOU
               INITIALIZE                  SYUNOU-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYUNOU-READ-EXT.
           EXIT.
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       910-SYUNOU-KEY18-READ-SEC       SECTION.
      *
           MOVE    SYUNOU-REC      TO  MCPDATA-REC
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY18"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYUNOU-REC
               MOVE    ZERO                TO  FLG-SYUNOU
           ELSE
               MOVE    1                   TO  FLG-SYUNOU
               INITIALIZE                  SYUNOU-REC
           END-IF
      *
           .
       910-SYUNOU-KEY18-READ-EXT.
           EXIT.
      *****************************************************************
      *    定期請求収納ファイル読込
      *****************************************************************
       910-TEIKI06-READ-SEC            SECTION.
      *
           READ    TEIKI06-FILE
           AT  END
               MOVE    1               TO  FLG-TEIKI06
           END-READ
      *
           .
       910-TEIKI06-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者請求履歴ファイル読込
      *****************************************************************
       910-TEIKI02-READ-SEC            SECTION.
      *
           READ    TEIKI02-FILE
           AT  END
               MOVE    1               TO  FLG-TEIKI02
           END-READ
      *
           .
       910-TEIKI02-READ-EXT.
           EXIT.
      *****************************************************************
      *    請求取消対象収納ファイル読込
      *****************************************************************
       910-TEIKI07-READ-SEC            SECTION.
      *
           READ    TEIKI07-FILE
           AT  END
               MOVE    1               TO  FLG-TEIKI07
           END-READ
      *
           .
       910-TEIKI07-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除対象患者請求履歴ファイル読込
      *****************************************************************
       910-TEIKI05-READ-SEC            SECTION.
      *
           READ    TEIKI05-FILE
           AT  END
               MOVE    1               TO  FLG-TEIKI05
           END-READ
      *
           .
       910-TEIKI05-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    定期請求管理情報削除処理
      *****************************************************************
       900-TEIKIKANRI-DEL-SEC         SECTION.
      *
           MOVE    SPACE               TO  MCPDATA-REC
           MOVE    "TEIKIKANRI-DEL1"   TO  ORC-DBPATH
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF  (   MCP-RC          NOT =   ZERO )
               MOVE  "定期請求管理データの削除に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  900-TEIKIKANRI-DEL-EXT
           END-IF
      *
           .
       900-TEIKIKANRI-DEL-EXT.
            EXIT.
      *****************************************************************
      *    定期請求印刷情報削除処理
      *****************************************************************
       900-TEIKIPRT-DEL-SEC            SECTION.
      *
           MOVE    SPACE               TO  MCPDATA-REC
           MOVE    "TEIKIPRT-DEL1"     TO  ORC-DBPATH
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF  (   MCP-RC          NOT =   ZERO )
               MOVE  "定期請求印刷情報データの削除に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  900-TEIKIPRT-DEL-EXT
           END-IF
      *
           .
       900-TEIKIPRT-DEL-EXT.
            EXIT.
      *****************************************************************
      *    収納明細読込（主キー）
      *****************************************************************
       900-SYUMEI-READ-SEC         SECTION.
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SYUMEI-REC
                   MOVE    ZERO                TO  FLG-SYUMEI
               ELSE
                   MOVE    1                   TO  FLG-SYUMEI
                   INITIALIZE                  SYUMEI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYUMEI
               INITIALIZE                  SYUMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYUMEI-READ-EXT.
           EXIT.
      **************************************************************
      *    収納明細読込
      **************************************************************
       910-SYUMEI-READ-SEC             SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYUMEI-REC
               MOVE    ZERO            TO  FLG-SYUMEI
           ELSE
               INITIALIZE                  SYUMEI-REC
               MOVE    1               TO  FLG-SYUMEI
           END-IF
      *
           .
       910-SYUMEI-READ-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ（定期請求個別指示）　ＲＥＡＤ
      *****************************************************************
       900-SYS5012-READ-SEC         SECTION.
      *
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYS5012
               MOVE    MCPDATA-REC     TO  SYS-5012-REC
           ELSE
               MOVE    1               TO  FLG-SYS5012
           END-IF
           .
       900-SYS5012-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者マスター読込（主キー）
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    ZERO                TO  FLG-PTINF
               ELSE
                   MOVE    1                   TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴マスター読込
      *****************************************************************
       900-PTNYUINRRK-READ-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNYUINRRK-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    "DBFETCH"   TO  MCP-FUNC
               MOVE    "PTNYUINRRK-KEY"
                                       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
               ELSE
                   MOVE    1           TO  FLG-PTNYUINRRK
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNYUINRRK-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-PTNYUINRRK-READ-EXT.
           EXIT.
      *****************************************************************
      *    請求印刷情報読込
      *****************************************************************
       900-TEIKIPRT-READ-SEC         SECTION.
      *
           MOVE    TEIKIPRT-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TEIKIPRT-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TEIKIPRT-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-TEIKIPRT
                   MOVE   MCPDATA-REC      TO  TEIKIPRT-REC
               ELSE
                   MOVE    1               TO  FLG-TEIKIPRT
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TEIKIPRT
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TEIKIPRT-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-TEIKIPRT-READ-EXT.
           EXIT.
      *****************************************************************
      *    請求管理情報読込
      *****************************************************************
       900-TEIKIKANRI-READ-SEC         SECTION.
      *
           MOVE    TEIKIKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TEIKIKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TEIKIKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-TEIKIKANRI
                   MOVE   MCPDATA-REC      TO  TEIKIKANRI-REC
               ELSE
                   MOVE    1               TO  FLG-TEIKIKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TEIKIKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TEIKIKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-TEIKIKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    請求履歴情報読込
      *****************************************************************
       900-TEIKIRRK-READ-SEC           SECTION.
      *
           MOVE    TEIKIRRK-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TEIKIRRK-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "TEIKIRRK-KEY"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF      MCP-RC          =   ZERO
                   MOVE    ZERO        TO  FLG-TEIKIRRK
                   MOVE   MCPDATA-REC  TO  TEIKIRRK-REC
               ELSE
                   MOVE    1           TO  FLG-TEIKIRRK
               END-IF
           ELSE
               MOVE    1               TO  FLG-TEIKIRRK
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TEIKIRRK-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-TEIKIRRK-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者請求履歴情報読込
      *****************************************************************
       900-PTTEIKIRRK-READ-SEC         SECTION.
      *
           MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTTEIKIRRK-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTTEIKIRRK-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-PTTEIKIRRK
                   MOVE   MCPDATA-REC      TO  PTTEIKIRRK-REC
               ELSE
                   MOVE    1               TO  FLG-PTTEIKIRRK
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTTEIKIRRK
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTTEIKIRRK-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-TEIKIPRT-READ-EXT.
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
           IF    ( FLG-ERR         =   ZERO )
               MOVE    "DBCOMMIT"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-IF
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
