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
       PROGRAM-ID.             SR3201.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト
      *  コンポーネント名  : レセプト明細書（県単用項目ファイル）作成
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/03/28    MCC-藤原      新規作成
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
      *    レセプト０２データ
           SELECT  RECE02-FILE     ASSIGN  RECE01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE02-KEY
                                   FILE    STATUS  IS  STS-RECE02.
      *    レセプト（県単用項目）データ
           SELECT  RECE11-FILE     ASSIGN  RECE11PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE11-KEY
                                   FILE    STATUS  IS  STS-RECE11.
      *    レセプト（県単用項目）データ
           SELECT  RECE111-FILE    ASSIGN  RECE11PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE111-KEY
                                   FILE    STATUS  IS  STS-RECE11.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    レセプト０２データ
       FD  RECE02-FILE.
       01  RECE02-REC.
           COPY    "CPRCF002.INC".
      *
      *    レセプト（県単用項目）データ
       FD  RECE11-FILE.
       01  RECE11-REC. 
           COPY    "CPRCF011.INC".
      *
      *    レセプト（県単用項目）´データ
       FD  RECE111-FILE.
       01  RECE111-REC. 
           COPY    "CPRCF011.INC"  REPLACING  //RECE11//
                                   BY         //RECE111//.
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC".
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE11//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    レセプト帳票
           COPY    "HC06.INC".     
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE11          PIC X(02).
           03  STS-RECE02          PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE02          PIC 9(06).
           03  CNT-RECE11          PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
      *    パラメタエリア 
           03  WRK-PARA.
               05  WRK-PARA-SRYYM  PIC X(06).
               05  WRK-PARA-TERMID PIC X(16).
               05  WRK-PARA-SYSYMD PIC X(08).
               05  WRK-PARA-JOBID  PIC 9(07).
               05  WRK-PARA-SHELLID
                                   PIC X(08).
      *    エラーメッセージ
           03  WRK-RECEERR         PIC X(200).
      *
      *    日付編集エリア
       01  WRK-HENSYU-AREA.
           03  WRK-SYMD            PIC X(08).
           03  WRK-HENYMDG         PIC X(22).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
      *
      *    固定項目エリア
        01  WRK-CONS-AREA.
            03  WRK-CONS-GENBAKU   PIC X(03)   VALUE   "019".
            03  WRK-CONS-MARUFUK   PIC X(03)   VALUE   "191".
            03  WRK-CONS-MARUNYU   PIC X(03)   VALUE   "190".         
      *
            03  WRK-CONS-GENBAKU-X PIC X(06)   VALUE   "【原】".
            03  WRK-CONS-GENBAKU1-X
                                   PIC X(12)   VALUE   "１３−（原）".
            03  WRK-CONS-MARUNYU-X PIC X(06)   VALUE   "【乳】".
            03  WRK-CONS-MARUFUK-X PIC X(06)   VALUE   "【福】".
            
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE           DIVISION
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
                   UNTIL       FLG-END     =   1
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      * 
      *    ワーク初期化 
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
      *　　パラメタセット　
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
      *    ＤＢＯＰＥＮ
           PERFORM 900-DBOPEN-SEC
      *
      *    ステップ管理開始セット処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "SR3201"            TO  JOB-PGID
           MOVE    "県単項目編集"      TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
      *
      *    ファイルＯＰＥＮ
           MOVE    "RECE020"           TO  RECE01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE01PARA-TERMID
      *
           MOVE    "RECE110"           TO  RECE11PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE11PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE02-FILE
      *
           OPEN    OUTPUT              RECE111-FILE
           CLOSE                       RECE111-FILE
      *
           OPEN    I-O                 RECE11-FILE
      *
      *    ファイルＲＥＡＤ
           PERFORM 900-RECE02-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    SPACE               TO  HC06
      *
      *    ＨＥＡＤ編集処理
           PERFORM 2001-HC06-HEAD-HENSYU-SEC     
      *
      *    ＢＯＤＹ編集処理
           PERFORM 2002-HC06-BODY-HENSYU-SEC     
      *
      *    ＦＯＯＴ編集処理
           PERFORM 2003-HC06-FOOT-HENSYU-SEC     
      *
      *    特記事項編集処理
           PERFORM 2004-HC06-TOKKI-HENSYU-SEC     
      *
      *   　ファイル出力処理
           IF      HC06            NOT =   SPACE
               PERFORM 2005-WRITE-SEC
           END-IF
      *              
      *    ファイルＲＥＡＤ
           PERFORM 900-RECE02-READ-SEC
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＨＥＡＤ編集処理
      *****************************************************************
       2001-HC06-HEAD-HENSYU-SEC   SECTION.
      *
      *****MOVE    ???                TO  HC06-HEAD1 (1)
      *****MOVE    ???                TO  HC06-HEAD2 (1)
      *****MOVE    ???                TO  HC06-HEAD3 (1)
           .
       2001-HC06-HEAD-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＢＯＤＹ編集処理
      *****************************************************************
       2002-HC06-BODY-HENSYU-SEC   SECTION.
      *
      *    マル乳・マル福・老人＋原爆（社保のとき）
           IF      RECE02-TEISYUTUSAKI =   1
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       10
                       OR      RECE02-HKNCOMBI (IDX)  =   ZERO
      *            保険組合せテーブルの検索
                   INITIALIZE                       HKNCOMBI-REC
                   MOVE    RECE02-HOSPID        TO  COMB-HOSPID
                   MOVE    RECE02-PTID          TO  COMB-PTID
                   MOVE    RECE02-HKNCOMBI (IDX)
                                                TO  COMB-HKNCOMBINUM
                   MOVE    HKNCOMBI-REC         TO  MCPDATA-REC
                   PERFORM 900-HKNCOMBI-INV-SEC
                   IF      FLG-HKNCOMBI         =   ZERO 
                       PERFORM VARYING IDY FROM    1   BY  1
                               UNTIL   IDY >       4
                               OR      COMB-KOHHKNNUM(IDY) =   SPACE    
      *                    マル乳のとき
                           IF      COMB-KOHHKNNUM (IDY)
                                                   =   WRK-CONS-MARUNYU
                               MOVE    WRK-CONS-MARUNYU-X
                                                   TO  HC06-BODY (47:6)
                               MOVE    4           TO  IDY
                               MOVE    10          TO  IDX    
                           END-IF
      *                    マル福のとき
                           IF      COMB-KOHHKNNUM (IDY)
                                               =   WRK-CONS-MARUFUK
                               MOVE    WRK-CONS-MARUFUK-X
                                                   TO  HC06-BODY (47:6)
                               MOVE    4           TO  IDY
                               MOVE    10          TO  IDX    
                           END-IF
      *
      *  　　　　　　　　　老人＋原爆
                           IF      RECE02-RJNHKNID     >   ZERO
                               IF      COMB-KOHHKNNUM (IDY)
                                                   =   WRK-CONS-GENBAKU
                                   MOVE    WRK-CONS-GENBAKU-X
                                                   TO  HC06-BODY (47:6)
                                   MOVE    4           TO  IDY
                                   MOVE    10          TO  IDX  
                               END-IF      
                           END-IF
                       END-PERFORM
                   END-IF    
               END-PERFORM
           END-IF                                           
           .
       2002-HC06-BODY-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＦＯＯＴ編集処理
      *****************************************************************
       2003-HC06-FOOT-HENSYU-SEC   SECTION.
      *
      *****MOVE    ???                TO  HC06-FOOT (1)
      *****MOVE    ???                TO  HC06-FOOT (2)
      *****MOVE    ???                TO  HC06-FOOT (3)
      *****MOVE    ???                TO  HC06-FOOT (4)
           .
       2003-HC06-FOOT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    特記事項編集処理
      *****************************************************************
       2004-HC06-TOKKI-HENSYU-SEC   SECTION.
      *
      *    老人＋原爆（国保のとき）
           IF      RECE02-TEISYUTUSAKI =   2
           AND     RECE02-RJNHKNID     >   ZERO
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       10
                       OR      RECE02-HKNCOMBI (IDX)  =   ZERO
      *            保険組合せテーブルの検索
                   INITIALIZE                       HKNCOMBI-REC
                   MOVE    RECE02-HOSPID        TO  COMB-HOSPID
                   MOVE    RECE02-PTID          TO  COMB-PTID
                   MOVE    RECE02-HKNCOMBI (IDX)
                                                TO  COMB-HKNCOMBINUM
                   MOVE    HKNCOMBI-REC         TO  MCPDATA-REC
                   PERFORM 900-HKNCOMBI-INV-SEC
                   IF      FLG-HKNCOMBI         =   ZERO 
                       PERFORM VARYING IDY FROM    1   BY  1
                               UNTIL   IDY >       4
                               OR      COMB-KOHHKNNUM(IDY) =   SPACE    
      *                    老人＋原爆
                           IF      COMB-KOHHKNNUM (IDY)
                                               =   WRK-CONS-GENBAKU
                               MOVE    WRK-CONS-GENBAKU1-X
                                               TO  HC06-TOKKI (1)
                               MOVE    4           TO  IDY
                               MOVE    10          TO  IDX  
                           END-IF
                       END-PERFORM
                   END-IF    
               END-PERFORM
           END-IF                                           
           .
       2004-HC06-TOKKI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *   　ファイル出力処理
      *****************************************************************
       2005-WRITE-SEC              SECTION.
      *
           INITIALIZE                      RECE11-REC
           MOVE    RECE02-HOSPID       TO  RECE11-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE11-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE11-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE11-PTID
           MOVE    RECE02-RECEKA       TO  RECE11-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE11-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE11-RECESYUBETU
           MOVE    RECE02-HKNJANUM-KEY TO  RECE11-HKNJANUM
           MOVE    RECE02-TEKSTYMD     TO  RECE11-TEKSTYMD
           MOVE    HC06                TO  RECE11-PRTDATA 
      *
           WRITE   RECE11-REC
           ADD     1                   TO  CNT-RECE11
           .
       2005-WRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    ファイルＣＬＯＳＥ処理
           CLOSE                       RECE02-FILE
           CLOSE                       RECE11-FILE     
      *
      *    ステップ管理終了処理
           MOVE    "STE"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           DISPLAY "RECE02  IN  "      CNT-RECE02
           DISPLAY "RECE11  CNT "      CNT-RECE11
           DISPLAY "*** SR3201 END ***"
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT          RECEERR-FILE
      *
               MOVE    WRK-RECEERR     TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *         
      *        ジョブ管理終了処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付変換処理
      *****************************************************************
       510-YMD-HENSYU-SEC          SECTION.
      *    西暦日本語変換処理
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
      *     MOVE    LNK-DAY2-EDTYMD3   TO  WRK-HENYMDG
           .
       510-YMD-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       900-RECE02-READ-SEC         SECTION.
      *
           READ    RECE02-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
               NOT AT  END
                   ADD     1           TO  CNT-RECE02
           END-READ
      *
           .
       900-RECE02-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスタ読込
      *****************************************************************
       900-HKNCOMBI-INV-SEC        SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNCOMBI
                   MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
               ELSE
                   MOVE    1                   TO  FLG-HKNCOMBI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNCOMBI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-HKNCOMBI-INV-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       900-DBOPEN-SEC                SECTION.
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
