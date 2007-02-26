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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCDTCHK010.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェック
      *  コンポーネント名  : エラー患者情報登録
      *  管理者            :
      *  作成日付    作業者        記述
      *  07/02/    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
      *
      *    データチェック中間ファイル（チェック結果）
           SELECT  DTCHK004-FILE
                                   ASSIGN  DTCHK004PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  DTCHK004-KEY
                                   FILE    STATUS  IS  STS-DTCHK004.
      *
      *    エラーファイル
           SELECT  DTCHKERR-FILE   ASSIGN  DTCHKERRPARA
                                   FILE    STATUS  IS  STS-DTCHKERR.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *    データチェック中間ファイル（チェック結果）
       FD  DTCHK004-FILE.
           COPY    "CPDTCHK004.INC".
      *
      *    エラーファイル
       FD  DTCHKERR-FILE.
       01  DTCHKERR-REC                PIC X(200). 
      *
       WORKING-STORAGE                 SECTION.
      *
      *    エラーファイルファイル名称領域 
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHKERR//.
      *
      *    中間ファイルファイル名称領域 
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHK004//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-DTCHK004                            PIC X(02).
           03  STS-DTCHKERR                            PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-ERR                                 PIC 9(01).
           03  FLG-DTCHK004                            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-CHK004                              PIC 9(08).
      *
       01  IDX-AREA.
           03  IDX0                                    PIC 9(05).
      *
       01  WRK-AREA.
           03  WRK-SYMD                                PIC X(08).
           03  WRK-DTCHKERR                            PIC X(200).
           03  WRK-JOB-YOBI                            PIC X(500).
           03  WRK-KBNCD-G.
               05  WRK-KBNCD-KBN                       PIC X(01).
               05  WRK-KBNCD-SEQ                       PIC 9(07).
      *
       01  KEY-AREA.
           03  KEY-PTID                                PIC 9(10).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                          PIC 9(07).
           03  WRK-PARA-SHELLID                        PIC X(08).
           03  WRK-PARA-HOSPID                         PIC X(24).
      *
      *    データチェック一括処理パラメータ
           COPY    "CPORCBSD01PARA.INC".
      *
      *    固定値領域
      *01  CONST-AREA.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    チェックマスタ４
           COPY    "CPCHK004.INC".
      *
      *    個別処理基本情報
           COPY    "CPCK2000.INC".
      *
      *    個別処理患者情報
           COPY    "CPCK2001.INC".
      *
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
      *
      ****************************************************************
       LINKAGE                         SECTION.
       01  DTCHK-RC        PIC S9(09).
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE                       DIVISION
               USING
           DTCHK-RC
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           DISPLAY "*** ORCDTCHK010 START ***"
      *
           PERFORM 100-INIT-SEC
      *
           IF    ( FLG-END     =   ZERO )
               PERFORM 200-MAIN-SEC
           END-IF
      *
           PERFORM 300-END-SEC
      *
           MOVE    FLG-ERR         TO  DTCHK-RC
      *
           EXIT    PROGRAM
      *
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  STS-AREA
                                       IDX-AREA
                                       CNT-AREA
                                       FLG-AREA
                                       WRK-AREA
                                       WRK-PARA
                                       KEY-AREA
                                       ORCBSD01PARA
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    LNK-PRTKANRI-RENNUM
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
                                               DTCHKERRPARA
                                               ORCBSD01-IKTKBT
                                               ORCBSD01-SRYYM
                                               ORCBSD01-NYUGAIKBN
                                               ORCBSD01-CHKKBN-G
                                               ORCBSD01-SYAHOPROCKBN
                                               ORCBSD01-KOKUHOPROCKBN
                                               ORCBSD01-RSIPROCKBN
                                               ORCBSD01-JBIPROCKBN
                                               ORCBSD01-JIHIPROCKBN
                                               ORCBSD01-INGAIPROCKBN
                                               ORCBSD01-PRTSRTKBN
                                               ORCBSD01-PRTPTLSTKBN
                                               ORCBSD01-SRYYMDKBN
                                               ORCBSD01-STSRYYMD
                                               ORCBSD01-EDSRYYMD
      *
           PERFORM 900-DBSTART-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCDTCHK010"       TO  JOB-PGID
           MOVE    "エラー患者情報登録"
                                       TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
      *    データチェック中間ファイル名
           MOVE    "DTCHK004"          TO  DTCHK004-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHK004-TERMID
      *
           PERFORM 900-DBCOMMIT-SEC
      *
           PERFORM 900-DBSTART-SEC
      *
           PERFORM 1001-INIT-VAL-SET-SEC
      *
           INITIALIZE                  CK4-2000-REC
           MOVE    "2000"              TO  CK4-2000-KANRICD
           MOVE    "4%"                TO  CK4-2000-KBNCD
           MOVE    WRK-SYMD            TO  CK4-2000-STYUKYMD
                                           CK4-2000-EDYUKYMD
           MOVE    CK4-2000-REC        TO  MCPDATA-REC
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "del1"              TO  MCP-PATHNAME
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "前回処理情報の削除に失敗しました"
                                       TO  WRK-DTCHKERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           IF    ( FLG-END             =   ZERO )
               INITIALIZE                  CK4-2001-REC
               MOVE    "2001"              TO  CK4-2001-KANRICD
               MOVE    "4%"                TO  CK4-2001-KBNCD
               MOVE    WRK-SYMD            TO  CK4-2001-STYUKYMD
                                               CK4-2001-EDYUKYMD
               MOVE    CK4-2001-REC        TO  MCPDATA-REC
               MOVE    "tbl_chk004"        TO  MCP-TABLE
               MOVE    "del1"              TO  MCP-PATHNAME
               PERFORM 910-DBDELETE-SEC
               IF    ( MCP-RC          NOT =   ZERO )
                   MOVE    "エラー患者情報の削除に失敗しました"
                                       TO  WRK-DTCHKERR
                   PERFORM 500-ERR-HENSYU-SEC
               END-IF
           END-IF
      *
           PERFORM 900-DBCOMMIT-SEC
      *
           PERFORM 900-DBSTART-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期値設定処理
      *****************************************************************
       1001-INIT-VAL-SET-SEC           SECTION.
      *
           MOVE    ORCBSD01-SRYYM      TO  WRK-SYMD
           MOVE    "01"                TO  WRK-SYMD(7:2)
      *
           .
       1001-INIT-VAL-SET-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           INITIALIZE                  CK4-2000-REC
           MOVE    "2000"          TO  CK4-2000-KANRICD
           MOVE    "4"             TO  CK4-2000-KBNCD
           MOVE    "00000000"      TO  CK4-2000-STYUKYMD
           MOVE    "99999999"      TO  CK4-2000-EDYUKYMD
           MOVE    ORCBSD01PARA    TO  CK4-2000-TBL
           PERFORM 800-MCNDATE-SEC
           MOVE    SMCNDATE-YMD    TO  CK4-2000-CREYMD
                                       CK4-2000-UPYMD
           MOVE    SMCNDATE-YMD    TO  CK4-2000-UPHMS
           MOVE    CK4-2000-REC    TO  MCPDATA-REC
           MOVE    "tbl_chk004"    TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               MOVE    "前回処理情報の登録に失敗しました"
                                   TO  WRK-DTCHKERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           IF    ( FLG-END         =   ZERO )
               PERFORM 2001-PTID-EDIT-SEC
           END-IF
      *
           MOVE    1               TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    エラー患者編集処理
      *****************************************************************
       2001-PTID-EDIT-SEC              SECTION.
      *
           INITIALIZE                  WRK-KBNCD-G
           MOVE    "4"             TO  WRK-KBNCD-KBN
      *
           OPEN    INPUT   DTCHK004-FILE
      *
           PERFORM 900-DTCHK004-READ-SEC
      *
           PERFORM UNTIL ( FLG-DTCHK004    NOT =   ZERO )
      *
               COMPUTE WRK-KBNCD-SEQ   =   WRK-KBNCD-SEQ   +   1
      *
               INITIALIZE                      CK4-2001-REC
               MOVE    "2001"              TO  CK4-2001-KANRICD
               MOVE    WRK-KBNCD-G         TO  CK4-2001-KBNCD
               MOVE    "00000000"          TO  CK4-2001-STYUKYMD
               MOVE    "99999999"          TO  CK4-2001-EDYUKYMD
               MOVE    DTCHK004-PTID       TO  CK4-2001-PTID
               MOVE    DTCHK004-MULHKNKBN  TO  CK4-2001-MULHKNKBN
      *
               MOVE    DTCHK004-PTID       TO  KEY-PTID
      *
               PERFORM UNTIL ( FLG-DTCHK004    NOT =   ZERO )
                        OR   ( KEY-PTID        NOT =   DTCHK004-PTID )
      *
      *
                   EVALUATE    DTCHK004-HKNKBN
                   WHEN    "1"
                       MOVE    "1"         TO  CK4-2001-SYAHO
                   WHEN    "2"
                       MOVE    "1"         TO  CK4-2001-KOKUHO
                   WHEN    "3"
                       MOVE    "1"         TO  CK4-2001-ROUSAI
                   WHEN    "4"
                       MOVE    "1"         TO  CK4-2001-JIBAI
                   WHEN    "5"
                       MOVE    "1"         TO  CK4-2001-JIHI
                   END-EVALUATE
      *
                   PERFORM 900-DTCHK004-READ-SEC
      *
               END-PERFORM
      *
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD    TO  CK4-2001-CREYMD
                                           CK4-2001-UPYMD
               MOVE    SMCNDATE-YMD    TO  CK4-2001-UPHMS
               MOVE    CK4-2001-REC    TO  MCPDATA-REC
               MOVE    "tbl_chk004"    TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM 910-DBINSERT-SEC
               IF    ( MCP-RC      NOT =   ZERO )
                   MOVE    "エラー患者情報の登録に失敗しました"
                                       TO  WRK-DTCHKERR
                   PERFORM 500-ERR-HENSYU-SEC
                   MOVE    1           TO  FLG-DTCHK004
               END-IF
      *
           END-PERFORM
      *
           CLOSE   DTCHK004-FILE
      *
           .
       2001-PTID-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC              SECTION.
      *
           OPEN    INPUT   DTCHKERR-FILE
           IF    ( STS-DTCHKERR        =   ZERO )
               CLOSE   DTCHKERR-FILE
           ELSE
               OPEN    OUTPUT              DTCHKERR-FILE
      *
               MOVE    WRK-DTCHKERR    TO  DTCHKERR-REC
               WRITE   DTCHKERR-REC
               CLOSE   DTCHKERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-DTCHKERR    TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
           END-IF
      *
           MOVE    1                   TO  FLG-END
           MOVE    1                   TO  FLG-ERR
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    ZERO            TO  JOB-UPDCNT
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           PERFORM 900-DBCOMMIT-SEC
      *     
           DISPLAY "*** ORCDTCHK010 END ***"
           .
       300-END-EXT.
           EXIT.
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
      *    チェック結果ファイル読込処理
      *****************************************************************
       900-DTCHK004-READ-SEC           SECTION.
      *
           READ    DTCHK004-FILE       NEXT
           AT  END
               MOVE    1           TO  FLG-DTCHK004
           END-READ
      *
           .
       900-DTCHK004-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＤＥＬＥＴＥ処理
      *****************************************************************
       910-DBDELETE-SEC                 SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＵＰＤＡＴＥ処理
      *****************************************************************
       910-DBUPDATE-SEC                SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　ＳＴＡＲＴ処理
      *****************************************************************
       900-DBSTART-SEC                 SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBSTART"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBSTART-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　ＣＯＭＭＩＴ処理
      *****************************************************************
       900-DBCOMMIT-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBCOMMIT-EXT.
           EXIT.
