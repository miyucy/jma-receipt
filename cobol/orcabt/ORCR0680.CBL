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
000300 PROGRAM-ID.             ORR0680.
000400*****************************************************************
000500*  システム名        : ＯＲＣＡ
000600*  サブシステム名    : レセプト（入院）
000700*  コンポーネント名  : 病名編集
000800*  管理者            : 
      *  作成日付    作業者        記述
      *  02/12/10    NACL−藤原　  新規作成
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
           SELECT  RECE63-FILE     ASSIGN  RECE63PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE63-KEY
                                   FILE    STATUS  IS  STS-RECE63.
006900*
           SELECT  RECE631-FILE    ASSIGN  RECE631PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE631-KEY
                                   FILE    STATUS  IS  STS-RECE631.
006900*
           SELECT  RECE63W-FILE    ASSIGN  RECE631PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE631W-KEY
                                   FILE    STATUS  IS  STS-RECE631.
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
006900*
007000 DATA                    DIVISION.
007100 FILE                    SECTION.
      *
      *    レセプト明細書  
       FD  RECE63-FILE.
       01  RECE63-REC. 
           COPY    "CPRCF063.INC".
      *
       FD  RECE631-FILE.
       01  RECE631-REC. 
           COPY    "CPRCF0631.INC".
      *
       FD  RECE63W-FILE.
       01  RECE63W-REC. 
           COPY    "CPRCF0631.INC" REPLACING  //RECE631//
                                   BY         //RECE631W//.
      *     
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
                                   BY         //RECE63//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE631//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
018000*    フラグ領域
       01  STS-AREA.
           03  STS-RECE631                             PIC X(02).
           03  STS-RECE63                              PIC X(02).
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
               05  KEY-N-TEISYUTUSAKI  PIC 9(01).
               05  KEY-N-RECESYUBETU   PIC 9(04).
               05  KEY-N-HKNJANUM      PIC X(08).
               05  KEY-N-HOJOKBN       PIC X(01).
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
               05  KEY-O-TEISYUTUSAKI  PIC 9(01).
               05  KEY-O-RECESYUBETU   PIC 9(04).
               05  KEY-O-HKNJANUM      PIC X(08).
               05  KEY-O-HOJOKBN       PIC X(01).
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
           MOVE    "ORR0680"      TO  JOB-PGID
           MOVE    "傷病名編集"    TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECE630"           TO  RECE63PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE63PARA-TERMID
      *
           MOVE    "RECE631"           TO  RECE631PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE631PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    OUTPUT              RECE63W-FILE
           CLOSE                       RECE63W-FILE
      *
           OPEN    INPUT               RECE63-FILE
      *
           OPEN    I-O                 RECE631-FILE
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
           PERFORM 900-RECE63-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *    
           INITIALIZE                      RECE631-REC
           MOVE    RECE63-HOSPID       TO  RECE631-HOSPID
           MOVE    RECE63-SRYYM        TO  RECE631-SRYYM
           MOVE    RECE63-NYUGAIKBN    TO  RECE631-NYUGAIKBN
           MOVE    RECE63-PTID         TO  RECE631-PTID
           MOVE    RECE63-RECEKA       TO  RECE631-RECEKA
           MOVE    RECE63-TEISYUTUSAKI TO  RECE631-TEISYUTUSAKI
           MOVE    RECE63-RECESYUBETU  TO  RECE631-RECESYUBETU
           MOVE    RECE63-HKNJANUM     TO  RECE631-HKNJANUM
           MOVE    RECE63-HOJOKBN      TO  RECE631-HOJOKBN
           MOVE    RECE63-TEKSTYMD     TO  RECE631-TEKSTYMD
           MOVE    RECE63-SRYYMD       TO  RECE631-SRYYMD
           MOVE    RECE63-SYUBYOFLG    TO  RECE631-SYUBYOFLG   
           MOVE    RECE63-TENKIKBN     TO  RECE631-TENKIKBN
           MOVE    RECE63-RENNUM       TO  RECE631-RENNUM
           MOVE    RECE63-PTNUM        TO  RECE631-PTNUM
           MOVE    RECE63-SRYKA        TO  RECE631-SRYKA
           MOVE    RECE63-KHNBYOMEICD  TO  RECE631-KHNBYOMEICD   
           MOVE    RECE63-BYOMEICD-G   TO  RECE631-BYOMEICD-G
           MOVE    RECE63-UTAGAIFLG    TO  RECE631-UTAGAIFLG
           MOVE    RECE63-MANSEIKBN    TO  RECE631-MANSEIKBN
           IF      SYS-2005-TENKIHENKBN    =   ZERO
               MOVE    SPACE               TO  RECE631-TENKIYMD
           ELSE    
               MOVE    RECE63-TENKIYMD     TO  RECE631-TENKIYMD   
           END-IF    
           MOVE    RECE63-BYOMEI       TO  RECE631-BYOMEI
           MOVE    RECE63-BYOMEIMOJI   TO  RECE631-BYOMEIMOJI
           MOVE    RECE63-BYOMEIHENFLG TO  RECE631-BYOMEIHENFLG   
      *
           WRITE   RECE631-REC
           ADD     1                   TO  CNT-OUT
      *
           MOVE    KEY-NEW             TO  KEY-OLD   
           PERFORM             UNTIL   FLG-END       =   1
                               OR      KEY-NEW   NOT =   KEY-OLD
               PERFORM 900-RECE63-READ-SEC      
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
           CLOSE   RECE63-FILE
           CLOSE   RECE631-FILE
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
      ***     DISPLAY "RECE63   IN  " CNT-IN  UPON CONSOLE 
      ***     DISPLAY "RECE631  CNT " CNT-OUT UPON CONSOLE 
      ***     DISPLAY "*** ORR0680 END ***"
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細書０２読込
      *****************************************************************
       900-RECE63-READ-SEC             SECTION.
      *
           READ    RECE63-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
                   MOVE    HIGH-VALUE  TO  KEY-NEW
               NOT AT  END
                   ADD     1           TO  CNT-IN
                   MOVE    ZERO        TO  FLG-END
                   MOVE    RECE63-HOSPID       TO  KEY-N-HOSPID
                   MOVE    RECE63-SRYYM        TO  KEY-N-SRYYM
                   MOVE    RECE63-NYUGAIKBN    TO  KEY-N-NYUGAIKBN
                   MOVE    RECE63-PTID         TO  KEY-N-PTID
                   MOVE    RECE63-RECEKA       TO  KEY-N-RECEKA
                   MOVE    RECE63-TEISYUTUSAKI TO  KEY-N-TEISYUTUSAKI
                   MOVE    RECE63-RECESYUBETU  TO  KEY-N-RECESYUBETU
                   MOVE    RECE63-HKNJANUM     TO  KEY-N-HKNJANUM
                   MOVE    RECE63-HOJOKBN      TO  KEY-N-HOJOKBN
                   MOVE    RECE63-TEKSTYMD     TO  KEY-N-TEKSTYMD
                   MOVE    RECE63-SRYYMD       TO  KEY-N-SRYYMD
                   MOVE    RECE63-TENKIKBN     TO  KEY-N-TENKIKBN
                   MOVE    RECE63-BYOMEI       TO  KEY-N-BYOMEI
                   IF      SYS-2005-TENKIHENKBN    =   ZERO
                       MOVE    SPACE               TO  KEY-N-TENKIYMD
                   ELSE
                       MOVE    RECE63-TENKIYMD     TO  KEY-N-TENKIYMD
                   END-IF    
           END-READ
           .
       900-RECE63-READ-EXT.
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
