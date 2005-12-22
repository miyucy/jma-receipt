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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBCHKSND2.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : チェックマスタ設定（新→旧）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/03/01    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    確認リスト
           COPY    "HCMSL80.INC".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"      REPLACING  //RECE01PARA//
                                           BY         //RECEERR//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-RECEERR                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-ERR                             PIC 9(01).
           03  FLG-CHKMST                          PIC 9(01).
           03  FLG-CHKSND-KEY2                     PIC 9(01).
           03  FLG-CHKSND                          PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RENNUM                          PIC 9(08).
           03  CNT-LINE                            PIC 9(08).
           03  CNT-PAGE                            PIC 9(08).
           03  CNT-CD                              PIC 9(08).
           03  CNT-OUTPUT                          PIC 9(08).
           03  CNT-CHKSND                          PIC 9(08).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                                PIC 9(05).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                      PIC 9(07).
           03  WRK-PARA-SHELLID                    PIC X(08).
           03  WRK-PARA-HOSPID                     PIC X(24).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-ZZZZ9-G.
               05  WRK-ZZZZ9                       PIC ZZZZ9.
           03  WRK-RECEERR                         PIC X(200).
           03  WRK-MEMO                            PIC X(500).
           03  WRK-TNS-SRYCD                       PIC X(09).
           03  WRK-TNS-YMD                         PIC X(08).
           03  WRK-TITLE                           PIC X(100).
           03  WRK-CHKKBNMEI                       PIC X(20).
      *
       01  MES-AREA.
           03  MES-MES01.
               05  PIC X(40)
                   VALUE   "　旧マスタに登録済みでした    ".
      *
       01  CONST-AREA.
           03  CONST-CHK-MAX                   PIC 9(03)   VALUE 10.
           03  CONST-LINE-MAX                  PIC 9(05)   VALUE 80.
      *
           COPY    "CPSHELLTBL.INC".
      *
       01  WKCHKSND-REC.
           COPY    "CPCHKSND.INC"          REPLACING  //CHKSND-//
                                           BY         //WKCHKSND-//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    印刷管理
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    印刷用データ
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    チェックマスター
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *
      *    チェックマスター２
       01  CHKSND-REC.
           COPY    "CPCHKSND.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    印刷ＤＢ制御サブ
           COPY    "CPORCSPRT.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                         SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER                  PIC X(1000).
      *
      ******************************************************************
      *
       PROCEDURE               DIVISION
                                       USING
                                       COMMAND-PARAM.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                       INTO            LNK-PRTKANRI-RENNUM
                                       LNK-PRTKANRI-TBL-KEY
                                       LNK-PRTKANRI-TBL-GROUP
                                       LNK-PRTKANRI-SHORI-RENNUM
                                       LNK-PRTKANRI-SRYYM
                                       LNK-PRTKANRI-SKYYMD
                                       LNK-PRTKANRI-SHELLID
                                       LNK-PRTKANRI-PRIORITY
                                       LNK-PRTKANRI-TERMID
                                       LNK-PRTKANRI-OPID
                                       LNK-PRTKANRI-PRTNM
                                       WRK-PARA-JOBID
                                       WRK-PARA-SHELLID
                                       WRK-PARA-HOSPID
      *
           MOVE    "適用病名情報更新（新→旧）"
                                       TO  WRK-TITLE
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBCHKSND2"       TO  JOB-PGID
           MOVE    WRK-TITLE           TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
           MOVE    ZERO                TO  FLG-END
      *
           PERFORM 800-MCNDATE-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           INITIALIZE              HCMSL80
           MOVE    ZERO            TO  CNT-LINE
           MOVE    ZERO            TO  CNT-PAGE
      *
           PERFORM 20011-HEAD-HEN-SEC
      *
           PERFORM 900-CHKSND-KEY14-SEL-SEC
      *
           PERFORM UNTIL ( FLG-CHKSND  NOT =   ZERO )
                    OR   ( FLG-END     NOT =   ZERO )
      *
               PERFORM 900-CHKMST-KEY3-SEL-SEC
               IF    ( FLG-CHKMST  =   ZERO )
                   MOVE    CHKSND-SRYCD        TO  WRK-TNS-SRYCD
                   MOVE    CHKSND-YUKOSTYMD    TO  WRK-TNS-YMD
                   PERFORM 2200-SRYNAME-HEN-SEC
                   MOVE    WRK-MEMO        TO  HCMSL80-MOJI (CNT-LINE)
                   PERFORM 250-LINE-CNT-SEC
                   MOVE    MES-MES01       TO  HCMSL80-MOJI (CNT-LINE)
                   PERFORM 250-LINE-CNT-SEC
               ELSE
                   PERFORM 2001-CHKMST-HEN-SEC
                   IF    ( FLG-END     NOT =   ZERO )
                       GO  TO  200-MAIN-EXT
                   END-IF
               END-IF
      *
               PERFORM 900-CHKSND-KEY14-FET-SEC
      *
           END-PERFORM
      *
           IF    ( CNT-LINE        >   2 )
               PERFORM 250-PRINT-SEC
           END-IF
      *
           MOVE    1                   TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェックマスタ編集処理
      *****************************************************************
       2001-CHKMST-HEN-SEC             SECTION.
      *
           MOVE    ZERO            TO  CNT-RENNUM
           MOVE    ZERO            TO  CNT-CD
           INITIALIZE                  CHK-REC
      *
           MOVE    CHKSND-REC      TO  WKCHKSND-REC
      *
           PERFORM 900-CHKSND-KEY2-SEL-SEC
      *
           PERFORM UNTIL ( FLG-CHKSND-KEY2 NOT =   ZERO )
                    OR   ( FLG-END         NOT =   ZERO )
      *
               COMPUTE CNT-CD      =   CNT-CD  +   1
      *
               MOVE    CHKSND-KEY  TO  CHK-KEY
                                       CHKUP-KEY
      *
               MOVE    CHKSND-CD (1:7) TO  CHK-CD (CNT-CD)
      *
               IF    ( CNT-CD     >=   CONST-CHK-MAX )
                   PERFORM 2001-CHKMST-INS-SEC
                   IF    ( FLG-END     NOT =   ZERO )
                       GO  TO  2001-CHKMST-HEN-EXT
                   END-IF
      *
                   MOVE    ZERO        TO  CNT-CD
                   INITIALIZE          CHK-REC
      *
               END-IF
      *
               PERFORM 900-CHKSND-KEY2-FET-SEC
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-CHKSND-KEY2    TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           IF    ( CNT-CD     >    ZERO )
               PERFORM 2001-CHKMST-INS-SEC
               IF    ( FLG-END     NOT =   ZERO )
                   GO  TO  2001-CHKMST-HEN-EXT
               END-IF
           END-IF
      *
           MOVE    WKCHKSND-REC    TO  CHKSND-REC
      *
           INITIALIZE                  CHK-REC
           MOVE    CHKSND-KEY      TO  CHK-KEY
                                       CHKUP-KEY
           COMPUTE CHK-TEKCDNUM
               = ( CNT-RENNUM  -   1 )
               *   CONST-CHK-MAX
               +   CNT-CD
      *
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    PATH-TBL-CHK-UPD2   TO  MCP-PATH
           PERFORM 910-DBUPDATE-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               MOVE    "チェックマスタの更新に失敗しました"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       2001-CHKMST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ追加処理
      *****************************************************************
       2001-CHKMST-INS-SEC             SECTION.
      *
           COMPUTE CNT-RENNUM  =   CNT-RENNUM  +   1
      *
           MOVE    CNT-RENNUM      TO  CHK-RENNUM
      *
           PERFORM 800-MCNDATE-SEC
           MOVE    SMCNDATE-YMD    TO  CHK-CREYMD
                                       CHK-UPYMD
           MOVE    SMCNDATE-HMS    TO  CHK-UPHMS
      *
           MOVE    CHK-REC         TO  MCPDATA-REC
           MOVE    PATH-TBL-CHK-KEY    TO  MCP-PATH
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               MOVE    "チェックマスタの追加に失敗しました"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       2001-CHKMST-INS-EXT.
           EXIT.
      *****************************************************************
      *    ヘッダ情報編集処理
      *****************************************************************
       20011-HEAD-HEN-SEC              SECTION.
      *
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   1
      *
           MOVE    CNT-PAGE        TO  WRK-ZZZZ9
      *
           INITIALIZE                  HCMSL80
      *
           STRING
               "＊＊＊＊　適用病名情報更新確認リスト（新→旧）　＊＊＊"
                                                   DELIMITED   BY  SIZE
               "（作成日："                        DELIMITED   BY  SIZE
               LNK-PRTKANRI-SKYYMD(1:4)            DELIMITED   BY  SIZE
               "."                                 DELIMITED   BY  SIZE
               LNK-PRTKANRI-SKYYMD(5:2)            DELIMITED   BY  SIZE
               "."                                 DELIMITED   BY  SIZE
               LNK-PRTKANRI-SKYYMD(7:2)            DELIMITED   BY  SIZE
               "）"                                DELIMITED   BY  SIZE
               "PAGE "                             DELIMITED   BY  SIZE
               WRK-ZZZZ9-G                         DELIMITED   BY  SIZE
           INTO    HCMSL80-MOJI (1)
           END-STRING
      *
           MOVE    2               TO  CNT-LINE
      *
           .
       20011-HEAD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為名称編集処理
      *****************************************************************
       2200-SRYNAME-HEN-SEC            SECTION.
      *
           MOVE    SPACE           TO  WRK-CHKKBNMEI
           IF    ( CHKSND-CHKKBN   =   "1" )
               MOVE    "薬剤と病名："
                                   TO  WRK-CHKKBNMEI
           ELSE
               MOVE    "診療行為と病名："
                                   TO  WRK-CHKKBNMEI
           END-IF
      *
           INITIALIZE                  WRK-MEMO
      *
           PERFORM 900-TENSU-KEY-SEL-SEC
      *
           STRING  WRK-CHKKBNMEI       DELIMITED   BY  SPACE
                   CHKSND-SRYCD        DELIMITED   BY  SIZE
                   " "                 DELIMITED   BY  SIZE
                   TNS-NAME            DELIMITED   BY  SPACE
                   " "                 DELIMITED   BY  SIZE
                   CHKSND-YUKOSTYMD    DELIMITED   BY  SIZE
                   "-"                 DELIMITED   BY  SIZE
                   CHKSND-YUKOEDYMD    DELIMITED   BY  SIZE
           INTO    WRK-MEMO
           END-STRING
      *
           .
       2200-SRYNAME-HEN-EXT.
           EXIT.
      *****************************************************************
      *    行カウント処理
      *****************************************************************
       250-LINE-CNT-SEC                SECTION.
      *
           IF    ( CNT-LINE       >=   CONST-LINE-MAX )
               PERFORM 250-PRINT-SEC
               PERFORM 20011-HEAD-HEN-SEC
           ELSE
               COMPUTE CNT-LINE    =   CNT-LINE    +   1
           END-IF
      *
           .
       250-LINE-CNT-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       250-PRINT-SEC                   SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           MOVE    LNK-PRTKANRI-SRYYM  TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID 
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
           MOVE   "HCMSL80.red"        TO  SPRT-PRTID
           MOVE    "適用病名情報更新確認リスト（新→旧）"
                                       TO  SPRT-TITLE
           MOVE    HCMSL80             TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF    ( SPRT-RETURN         =   ZERO )
               COMPUTE CNT-OUTPUT  =   CNT-OUTPUT  +   1
           ELSE
               DISPLAY "ORCSPRT ERR!!"
           END-IF
      *
           .
       250-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT               RECEERR-FILE
           IF        ( STS-RECEERR     =   ZERO )
               CONTINUE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR     TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
           MOVE    1               TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           IF    ( CNT-CHKSND      =   ZERO )
               MOVE    "処理対象のデータがありませんでした"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           ELSE
               IF    ( CNT-OUTPUT  >   ZERO )
                   MOVE    "確認リストを確認してください"
                                   TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
               END-IF
           END-IF
      *
           DISPLAY "*** ORCBCHKSND2 IN " CNT-CHKSND  " ***"
           DISPLAY "*** ORCBCHKSND2 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-OUTPUT      TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
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
      *    チェックマスタ２情報検索(KEY2)
      *****************************************************************
       900-CHKSND-KEY2-SEL-SEC         SECTION.
      *
           MOVE    ZERO            TO  FLG-CHKSND-KEY2
      *
           MOVE    CHKSND-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-CHKSND-KEY2    TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  CHKSND-REC
           ELSE
               MOVE    1           TO  FLG-CHKSND-KEY2
           END-IF
      *
           .
       900-CHK-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ情報ＦＥＴＣＨ処理(KEY2)
      *****************************************************************
       900-CHKSND-KEY2-FET-SEC         SECTION.
      *
           MOVE    PATH-TBL-CHKSND-KEY2    TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  CHKSND-REC
           ELSE
               MOVE    1           TO  FLG-CHKSND-KEY2
           END-IF
      *
           .
       900-CHKSND-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２情報検索(KEY14)
      *****************************************************************
       900-CHKSND-KEY14-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-CHKSND
      *
           INITIALIZE                  CHKSND-REC
           MOVE    CHKSND-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-CHKSND-KEY14  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  CHKSND-REC
           ELSE
               INITIALIZE              CHKSND-REC
               MOVE    1           TO  FLG-CHKSND
           END-IF
      *
           IF    ( FLG-CHKSND      =   ZERO )
               COMPUTE CNT-CHKSND  =   CNT-CHKSND  +   1
           END-IF
      *
           .
       900-CHKSND-KEY14-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２情報ＦＥＴＣＨ処理(KEY14)
      *****************************************************************
       900-CHKSND-KEY14-FET-SEC           SECTION.
      *
           MOVE    PATH-TBL-CHKSND-KEY14  TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  CHKSND-REC
           ELSE
               INITIALIZE              CHKSND-REC
               MOVE    1           TO  FLG-CHKSND
           END-IF
      *
           IF    ( FLG-CHKSND      =   ZERO )
               COMPUTE CNT-CHKSND  =   CNT-CHKSND  +   1
           END-IF
      *
           .
       900-CHKSND-KEY14-FET-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ情報検索(KEY3)
      *****************************************************************
       900-CHKMST-KEY3-SEL-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-CHKMST
      *
           INITIALIZE                      CHK-REC
           MOVE    CHKSND-CHKKBN       TO  CHK-CHKKBN
           MOVE    CHKSND-SRYCD        TO  CHK-SRYCD
           MOVE    CHKSND-YUKOEDYMD    TO  CHK-YUKOSTYMD
           MOVE    CHKSND-YUKOSTYMD    TO  CHK-YUKOEDYMD
           MOVE    CHKSND-CDKBN        TO  CHK-CDKBN
      *
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    PATH-TBL-CHK-KEY3   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  CHK-REC
           ELSE
               INITIALIZE                  CHK-REC
               MOVE    1               TO  FLG-CHKMST
           END-IF
      *
           MOVE    PATH-TBL-CHK-KEY3   TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-CHKMST-KEY3-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理(KEY)
      *****************************************************************
       900-TENSU-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    WRK-TNS-SRYCD   TO  TNS-SRYCD
           MOVE    WRK-TNS-YMD     TO  TNS-YUKOSTYMD
                                       TNS-YUKOEDYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
           MOVE    PATH-TBL-TENSU-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
               INITIALIZE              TNS-TENSU-REC
           END-IF
      *
           MOVE    PATH-TBL-TENSU-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC          SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
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
       910-DBFETCH-SEC            SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
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
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＵＰＤＡＴＥ処理
      *****************************************************************
       910-DBUPDATE-SEC                 SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　ＣＯＭＭＩＴ処理
      *****************************************************************
       910-DBCOMMIT-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       910-DBCOMMIT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　切断処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBDISCONNECT-EXT.
           EXIT.
