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
000200 IDENTIFICATION          DIVISION.
000300 PROGRAM-ID.             ORCR0450.
000400*****************************************************************
000500*  システム名        : ＯＲＣＡ
000600*  サブシステム名    : レセプト
000700*  コンポーネント名  : 月次業務　労災明細書ファイル作成（傷病名並替え）
000800*  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
001200*
001300 ENVIRONMENT             DIVISION.
001400 CONFIGURATION           SECTION.
001500 INPUT-OUTPUT            SECTION.
001600 FILE-CONTROL.
      *
      *    レセプト明細書  
006900*
           SELECT  RECE42-FILE     ASSIGN  RECE42PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE42-KEY
                                   FILE    STATUS  IS  STS-RECE42.
006900*
           SELECT  RECE43-FILE    ASSIGN  RECE43PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE43-KEY
                                   FILE    STATUS  IS  STS-RECE43.
006900*
           SELECT  RECE43W-FILE     ASSIGN  RECE43PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE43W-KEY
                                   FILE    STATUS  IS  STS-RECE43.
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
006900*
007000 DATA                    DIVISION.
007100 FILE                    SECTION.
      *
      *    レセプト明細書  
       FD  RECE42-FILE.
       01  RECE42-REC. 
           COPY    "CPRCF042.INC".
      *
       FD  RECE43-FILE.
       01  RECE43-REC. 
           COPY    "CPRCF043.INC".
      *
       FD  RECE43W-FILE.
       01  RECE43W-REC. 
           COPY    "CPRCF043.INC"  REPLACING   //RECE43//
                                   BY          //RECE43W//.
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
010200 WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE42//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE43//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
018000*    フラグ領域
       01  STS-AREA.
           03  STS-RECE43                             PIC X(02).
           03  STS-RECE42                              PIC X(02).
           03  STS-RECEERR                             PIC X(02).
      *
018100 01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-SYSKANRI                            PIC 9(01).
020700*
020800*    カウント領域
020900 01  CNT-AREA.
021000     03  CNT-IN                                  PIC 9(06).
           03  CNT-OUT                                 PIC 9(06).
024000*
024100*    一時領域
024200 01  WRK-AREA.
      *****03  WRK-IN          PIC X(01).
           03  WRK-PARA.
               05  WRK-PARA-SRYYM                      PIC  X(06).
               05  WRK-PARA-TERMID                     PIC  X(16).
               05  WRK-PARA-SYSYMD                     PIC  X(08).
               05  WRK-PARA-JOBID                      PIC  9(07).
               05  WRK-PARA-SHELLID                    PIC  X(08).
      *
           03  WRK-RECEERR             PIC X(200). 
      *
       01  KEY-AREA                            VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-HOSPID        PIC X(24).
               05  KEY-N-SRYYM         PIC 9(06).
               05  KEY-N-NYUGAIKBN     PIC X(01).
               05  KEY-N-PTID          PIC 9(10).
               05  KEY-N-RECEKA        PIC X(02).
               05  KEY-N-HKNID         PIC 9(10).
               05  KEY-N-TEKSTYMD      PIC X(08). 
               05  KEY-N-SRYYMD        PIC X(08).
               05  KEY-N-TENKIKBN      PIC X(01).
               05  KEY-N-TENKIYMD      PIC X(08).
               05  KEY-N-BYOMEI        PIC X(160).
           03  KEY-OLD.
               05  KEY-O-HOSPID        PIC X(24).
               05  KEY-O-SRYYM         PIC 9(06).
               05  KEY-O-NYUGAIKBN     PIC X(01).
               05  KEY-O-PTID          PIC 9(10).
               05  KEY-O-RECEKA        PIC X(02).
               05  KEY-O-HKNID         PIC 9(10).
               05  KEY-O-TEKSTYMD      PIC X(08). 
               05  KEY-O-SRYYMD        PIC X(08).
               05  KEY-O-TENKIKBN      PIC X(01).
               05  KEY-O-TENKIYMD      PIC X(08).
               05  KEY-O-BYOMEI        PIC X(160).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK2005.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL   FLG-END =   1 
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
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
      *
           MOVE    ZERO                TO  FLG-END
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0450"      TO  JOB-PGID
           MOVE    "傷病名並び替え（労災）"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECE420"           TO  RECE42PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE42PARA-TERMID
      *
           MOVE    "RECE430"           TO  RECE43PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE43PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    OUTPUT              RECE43W-FILE
           CLOSE                       RECE43W-FILE
      *
           OPEN    INPUT               RECE42-FILE
      *
           OPEN    I-O                 RECE43-FILE
      *     
      *    レセプト編集区分情報
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "2005"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           PERFORM 960-KANRIMST-READ-SEC
           IF      FLG-SYSKANRI     =   ZERO
               MOVE    MCPDATA-REC      TO  SYS-2005-REC
           ELSE    
               MOVE    SPACE            TO  SYS-2005-REC
           END-IF
           IF      SYS-2005-TENKIHENKBN    =   SPACE
               MOVE    ZERO             TO  SYS-2005-TENKIHENKBN
           END-IF
      *
      *        レセプト明細０３読み込み
           PERFORM 900-RECE42-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *    
           INITIALIZE                      RECE43-REC
           MOVE    RECE42-HOSPID       TO  RECE43-HOSPID
           MOVE    RECE42-SRYYM        TO  RECE43-SRYYM
           MOVE    RECE42-NYUGAIKBN    TO  RECE43-NYUGAIKBN
           MOVE    RECE42-PTID         TO  RECE43-PTID
           MOVE    RECE42-RECEKA       TO  RECE43-RECEKA
           MOVE    RECE42-HKNID        TO  RECE43-HKNID
           MOVE    RECE42-TEKSTYMD     TO  RECE43-TEKSTYMD
           MOVE    RECE42-SRYYMD       TO  RECE43-SRYYMD
           MOVE    RECE42-SYUBYOFLG    TO  RECE43-SYUBYOFLG   
           MOVE    RECE42-TENKIKBN     TO  RECE43-TENKIKBN
           MOVE    RECE42-RENNUM       TO  RECE43-RENNUM
           MOVE    RECE42-PTNUM        TO  RECE43-PTNUM
           MOVE    RECE42-SRYKA        TO  RECE43-SRYKA
           MOVE    RECE42-KHNBYOMEICD  TO  RECE43-KHNBYOMEICD   
           MOVE    RECE42-BYOMEICD-G   TO  RECE43-BYOMEICD-G
           MOVE    RECE42-UTAGAIFLG    TO  RECE43-UTAGAIFLG
           MOVE    RECE42-MANSEIKBN    TO  RECE43-MANSEIKBN
           IF      SYS-2005-TENKIHENKBN    =   ZERO
               MOVE    SPACE               TO  RECE43-TENKIYMD
           ELSE    
               MOVE    RECE42-TENKIYMD     TO  RECE43-TENKIYMD   
           END-IF    
           MOVE    RECE42-BYOMEI       TO  RECE43-BYOMEI
           MOVE    RECE42-BYOMEIMOJI   TO  RECE43-BYOMEIMOJI
           MOVE    RECE42-BYOMEIHENFLG TO  RECE43-BYOMEIHENFLG   
      *
           WRITE   RECE43-REC
           ADD     1                   TO  CNT-OUT
      *
           MOVE    KEY-NEW             TO  KEY-OLD   
           PERFORM             UNTIL   FLG-END       =   1
                               OR      KEY-NEW   NOT =   KEY-OLD
               PERFORM 900-RECE42-READ-SEC      
           END-PERFORM    
           .
       200-MAIN-EXT.
           EXIT. 
057400*
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
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
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   RECE42-FILE
           CLOSE   RECE43-FILE
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
           DISPLAY "RECE42   IN  " CNT-IN  UPON CONSOLE 
           DISPLAY "RECE43  CNT " CNT-OUT UPON CONSOLE 
           DISPLAY "*** ORCR0450 END ***"
      ***     ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細書０２読込
      *****************************************************************
       900-RECE42-READ-SEC             SECTION.
      *
           READ    RECE42-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
                   MOVE    HIGH-VALUE  TO  KEY-NEW
               NOT AT  END
                   ADD     1           TO  CNT-IN
                   MOVE    ZERO        TO  FLG-END
                   MOVE    RECE42-HOSPID       TO  KEY-N-HOSPID
                   MOVE    RECE42-SRYYM        TO  KEY-N-SRYYM
                   MOVE    RECE42-NYUGAIKBN    TO  KEY-N-NYUGAIKBN
                   MOVE    RECE42-PTID         TO  KEY-N-PTID
                   MOVE    RECE42-RECEKA       TO  KEY-N-RECEKA
                   MOVE    RECE42-HKNID        TO  KEY-N-HKNID
                   MOVE    RECE42-TEKSTYMD     TO  KEY-N-TEKSTYMD
                   MOVE    RECE42-SRYYMD       TO  KEY-N-SRYYMD
                   MOVE    RECE42-TENKIKBN     TO  KEY-N-TENKIKBN
                   MOVE    RECE42-BYOMEI       TO  KEY-N-BYOMEI
                   IF      SYS-2005-TENKIHENKBN    =   ZERO
                       MOVE    SPACE               TO  KEY-N-TENKIYMD
                   ELSE
                       MOVE    RECE42-TENKIYMD     TO  KEY-N-TENKIYMD
                   END-IF    
           END-READ
           .
       900-RECE42-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       960-KANRIMST-READ-SEC         SECTION.
      * 
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           MOVE    WRK-PARA-SRYYM  TO  ORC-DBYMD (1:6)
           MOVE    "01"            TO  ORC-DBYMD (7:2) 
           CALL    "ORCMCPSUB"     USING
                                   MCPAREA
                                   ORCMCPAREA
                                   MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               MOVE    "DBFETCH"       TO  MCP-FUNC
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF      MCP-RC          =   ZERO
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
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       960-KANRIMST-READ-EXT.
           EXIT.
      *      
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
