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
000300 PROGRAM-ID.             ORCR0440.
000400*****************************************************************
000500*  システム名        : ＯＲＣＡ
000600*  サブシステム名    : レセプト（労災・自賠責）
000700*  コンポーネント名  : 月次業務　労災自賠責明細書ファイル作成
      *                      （傷病名編集）
000800*  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-門脇    02.11.11  転帰日が未来日のとき病名の表示
      *                                     をするように修正
      *  01.00.02    NACL-門脇    03.03.10  診療科１０から２０へ
      *****************************************************************
001200*
001300 ENVIRONMENT             DIVISION.
001400 CONFIGURATION           SECTION.
001500 INPUT-OUTPUT            SECTION.
001600 FILE-CONTROL.
      *
      *    レセプト明細書  
           SELECT  RECE41-FILE     ASSIGN  RECE01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE41-KEY
                                   FILE    STATUS  IS  STS-RECE41.
006900*
           SELECT  RECE42-FILE     ASSIGN  RECE42PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE42-KEY
                                   FILE    STATUS  IS  STS-RECE42.
006900*
           SELECT  RECE42W-FILE    ASSIGN  RECE42PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE42W-KEY
                                   FILE    STATUS  IS  STS-RECE42.
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
006900*
007000 DATA                    DIVISION.
007100 FILE                    SECTION.
      *
      *    レセプト明細書  
       FD  RECE41-FILE.
       01  RECE41-REC. 
           COPY    "CPRCF041.INC".
      *
       FD  RECE42-FILE.
       01  RECE42-REC. 
           COPY    "CPRCF042.INC".
      *
       FD  RECE42W-FILE.
       01  RECE42W-REC. 
           COPY    "CPRCF042.INC"  REPLACING  //RECE42//
                                   BY         //RECE42W//.
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
010200 WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC".
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE42//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03                      PIC X(04)   VALUE   ".dat".
      *
018000*    フラグ領域
       01  STS-AREA.
           03  STS-RECE41          PIC X(02).
           03  STS-RECE42          PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
018100 01  FLG-AREA.
           03  FLG-END             PIC 9(01).
018900     03  FLG-PTBYOMEI        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-CHK             PIC 9(01).
020700*
020800*    カウント領域
020900 01  CNT-AREA.
021000     03  CNT-IN              PIC 9(06).
           03  CNT-OUT             PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX                 PIC 9(03). 
           03  IDY                 PIC 9(03). 
           03  IDZ                 PIC 9(03).
024000*
024100*    一時領域
024200 01  WRK-AREA.
     ****  03  WRK-IN              PIC X(01).
           03  WRK-PARA.
               05  WRK-PARA-SRYYM  PIC  X(06).
               05  WRK-PARA-TERMID PIC  X(16).
               05  WRK-PARA-SYSYMD PIC  X(08).
               05  WRK-PARA-JOBID  PIC  9(07).
               05  WRK-PARA-SHELLID
                                   PIC  X(08).
           03  WRK-PATH            PIC X(64). 
           03  WRK-YM              PIC 9(06).
           03  WRK-RENNUM          PIC 9(02).
      *
           03  WRK-RECEERR         PIC X(200). 
      *    傷病名編集
           03  WRK-BYOMEI          PIC X(150).
           03  WRK-BYOMEIW         PIC X(150).
      *    傷病名編集フラグ（疑い）
           03  WRK-HENFLG1         PIC X(01).
      *    傷病名編集フラグ（急性）
           03  WRK-HENFLG2         PIC X(01). 
      *    病名文字数         
           03  WRK-MOJISU          PIC 9(03).
      *
       01  KEY-AREA                            VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-SRYYMD    PIC 9(08).
           03  KEY-OLD.
               05  KEY-O-SRYYMD    PIC 9(08).
      *
      *    疑い編集
       01  WRK-UTAGAI-AREA.
      *    疑い
           03  WRK-CONS-UTAGAI     PIC X(06)   VALUE   "の疑い".
           03  WRK-CONS-UTAGAI-MOJISU
                                   PIC 9(02)   VALUE   6.       
      *    急性
           03  WRK-CONS-KYUSEI     PIC X(04)   VALUE   "急性".      
           03  WRK-CONS-KYUSEI-MOJISU
                                   PIC 9(02)   VALUE   4.       
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
      *    患者病名
       01  PTBYOMEI-REC.
           COPY    "CPPTBYOMEI.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
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
           MOVE    "ORCR0440"      TO  JOB-PGID
           MOVE    "傷病名編集（労災・自賠責）" 
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECE410"           TO  RECE01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE01PARA-TERMID
      *
           MOVE    "RECE420"           TO  RECE42PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE42PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    OUTPUT              RECE42W-FILE
           CLOSE                       RECE42W-FILE
      *
           OPEN    INPUT               RECE41-FILE    
           OPEN    I-O                 RECE42-FILE
      *     
      *    レセプト編集区分情報
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "2005"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI     =   ZERO
               MOVE    MCPDATA-REC      TO  SYS-2005-REC
                
           ELSE    
               MOVE    SPACE            TO  SYS-2005-REC
           END-IF
           IF      SYS-2005-BYOMEIHENKBN1   =   SPACE
               MOVE    ZERO             TO  SYS-2005-BYOMEIHENKBN1
           END-IF
      *
      *        レセプト明細０２読み込み
           PERFORM 900-RECE41-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *    
      *    患者病名読み込み（患者ＩＤ、診療年月日、診療科順）
           INITIALIZE                  PTBYOMEI-REC
           MOVE    RECE41-HOSPID       TO  PTBYO-HOSPID
           MOVE    RECE41-PTID         TO  PTBYO-PTID
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTBYOMEI-KEY3"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTBYOMEI-KEY3"     TO  ORC-DBPATH 
               PERFORM 900-PTBYO-READ-SEC
           ELSE
               INITIALIZE                  PTBYOMEI-REC
               MOVE    1                   TO  FLG-PTBYOMEI
           END-IF
      *
           PERFORM 2001-PTBYO-HENSYU-SEC
                           UNTIL       FLG-PTBYOMEI     =   1
      *    カーソルクロース
           INITIALIZE                  MCPAREA
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTBYOMEI-KEY3"     TO  ORC-DBPATH 
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           PERFORM 900-RECE41-READ-SEC      
           .
       200-MAIN-EXT.
           EXIT. 
      *            
      * 
      *****************************************************************
      *    患者病名診療年月日別処理
      *****************************************************************
       2001-PTBYO-HENSYU-SEC                SECTION.
      *
           MOVE    PTBYO-SRYYMD            TO  KEY-N-SRYYMD
           MOVE    ZERO                    TO  WRK-RENNUM
      *
           MOVE    KEY-NEW                 TO  KEY-OLD   
           PERFORM             UNTIL       FLG-PTBYOMEI    =   1
                               OR          KEY-NEW     NOT =   KEY-OLD
               PERFORM 2001-PTBYO-CHK-SEC
      * 
               MOVE    "PTBYOMEI-KEY3"         TO  ORC-DBPATH 
               PERFORM 900-PTBYO-READ-SEC
           END-PERFORM    
           .
       2001-PTBYO-HENSYU-EXT.
           EXIT. 
      *            
070100*****************************************************************
070200*    患者病名チェック処理
070300*****************************************************************
070400 2001-PTBYO-CHK-SEC         SECTION.
      *
      *    診療科
           MOVE    ZERO                TO  FLG-CHK 
           IF      SYS-2005-BYOMEIHENKBN1      =   ZERO     
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       20
                       OR      RECE41-SRYKA(IDX)   =   SPACE
                   IF      PTBYO-SRYKA          =   RECE41-SRYKA (IDX)
                       MOVE    1                    TO  FLG-CHK
                       MOVE    10                   TO  IDX
                   END-IF
               END-PERFORM
               IF      FLG-CHK              =   ZERO
                   GO  TO  2001-PTBYO-CHK-EXT
               END-IF
           END-IF        
      *
      *    診療開始日
           IF      PTBYO-SRYYMD(1:6)    =   RECE41-SRYYM
               CONTINUE
           ELSE
               IF      PTBYO-SRYYMD(1:6)    <   RECE41-SRYYM 
                   IF      PTBYO-TENKIKBN       =   SPACE
                       CONTINUE
                   ELSE
      ***              IF      PTBYO-TENKIYMD(1:6)  =   RECE41-SRYYM
                       IF      PTBYO-TENKIYMD(1:6)  >=  RECE41-SRYYM
                           CONTINUE
                       ELSE
                           GO  TO  2001-PTBYO-CHK-EXT
                       END-IF
                   END-IF       
               ELSE
                   GO  TO  2001-PTBYO-CHK-EXT
               END-IF
           END-IF
      *
      *    入外区分
           IF      PTBYO-NYUGAIKBN      =   SPACE
               CONTINUE
           ELSE
               IF      PTBYO-NYUGAIKBN  NOT =   RECE41-NYUGAIKBN
                   GO  TO  2001-PTBYO-CHK-EXT
               END-IF
           END-IF
      *
      *    保険組合せ
           IF      PTBYO-HKNCOMBI       =   RECE41-HKNCOMBI 
               CONTINUE
           ELSE
               GO  TO  2001-PTBYO-CHK-EXT
           END-IF
      *
      *    レセプト表示月
           IF      PTBYO-REZEFLG          =   "1"
              GO  TO  2001-PTBYO-CHK-EXT
           END-IF
      *
           IF      PTBYO-REZEMM           >   ZERO
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY6-AREA
               MOVE    "61"                TO  LNK-DAY6-IRAI
               MOVE    PTBYO-SRYYMD        TO  LNK-DAY6-KIJUN 
               MOVE    "2"                 TO  LNK-DAY6-ZOGENPTN
               COMPUTE LNK-DAY6-ZOGEN  =   PTBYO-REZEMM    -   1    
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN(1:6)
                                           TO  WRK-YM
               IF      WRK-YM              >=  RECE41-SRYYM
                   CONTINUE
               ELSE
                   GO  TO  2001-PTBYO-CHK-EXT
               END-IF
           END-IF                    
      *                               
           PERFORM 20011-RECE42-WRITE-SEC
           .
       2001-PTBYO-CHK-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    レセプト明細０３編集処理
      *****************************************************************
       20011-RECE42-WRITE-SEC              SECTION.
      *
      *    疑いフラグより病名を編集
           MOVE    SPACE               TO  WRK-HENFLG1
                                           WRK-HENFLG2
      *       
           IF      PTBYO-UTAGAIFLG NOT =   SPACE
               COMPUTE WRK-MOJISU   =   PTBYO-BYOMEIMOJI   *   2
               IF      PTBYO-UTAGAIFLG  =   "1" OR  "3"
                   IF      WRK-MOJISU       <   8
                       MOVE    1                TO  IDZ
                   ELSE    
                       COMPUTE IDZ     =   WRK-MOJISU    -   7
                   END-IF    
                   PERFORM VARYING IDX FROM    IDZ BY  2
                           UNTIL   IDX >       WRK-MOJISU
                       IF      PTBYO-BYOMEI (IDX:2)      =   "疑"
                           MOVE    "1"              TO  WRK-HENFLG1
                           MOVE    WRK-MOJISU       TO  IDX
                       END-IF
                   END-PERFORM
               END-IF                
               IF      PTBYO-UTAGAIFLG =   "2" OR  "3"
                   PERFORM VARYING IDX FROM    1   BY  2
                           UNTIL   IDX >       WRK-MOJISU
                       IF      PTBYO-BYOMEI (IDX:4)      =   "急性"
                           MOVE    "1"              TO  WRK-HENFLG2
                           MOVE    WRK-MOJISU       TO  IDX
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
      *     
      *    病名文字数を計算
           COMPUTE WRK-MOJISU          =   PTBYO-BYOMEIMOJI   *   2
           MOVE    PTBYO-BYOMEI      TO  WRK-BYOMEI
      *
      *    疑いフラグがセットされているとき
           IF    ( PTBYO-UTAGAIFLG     =   "1" OR  "3" )
           AND   ( WRK-HENFLG1         =   SPACE       )                         
               MOVE    SPACE               TO  WRK-BYOMEI
               STRING  PTBYO-BYOMEI        DELIMITED BY  SPACE
                       WRK-CONS-UTAGAI     DELIMITED BY  SIZE
                       INTO                WRK-BYOMEI
               COMPUTE WRK-MOJISU          =      
                                WRK-MOJISU +   WRK-CONS-UTAGAI-MOJISU
               MOVE    "1"                 TO  PTBYO-BYOMEIHENFLG                 
           END-IF    
           IF    ( PTBYO-UTAGAIFLG     =   "2" OR  "3" )
           AND   ( WRK-HENFLG2         =   SPACE       )                         
               MOVE    SPACE               TO  WRK-BYOMEIW
               STRING  WRK-CONS-KYUSEI     DELIMITED BY  SIZE
                       WRK-BYOMEI          DELIMITED BY  SPACE
                       INTO                WRK-BYOMEIW
               COMPUTE WRK-MOJISU          =      
                                WRK-MOJISU +   WRK-CONS-KYUSEI-MOJISU
               MOVE    WRK-BYOMEIW         TO  WRK-BYOMEI  
               MOVE    "1"                 TO  PTBYO-BYOMEIHENFLG                 
           END-IF
      *
           ADD     1                   TO  WRK-RENNUM
           
           INITIALIZE                      RECE42-REC
           MOVE    RECE41-HOSPID       TO  RECE42-HOSPID
           MOVE    RECE41-SRYYM        TO  RECE42-SRYYM
           MOVE    RECE41-NYUGAIKBN    TO  RECE42-NYUGAIKBN
           MOVE    RECE41-PTID         TO  RECE42-PTID
           MOVE    RECE41-RECEKA       TO  RECE42-RECEKA
           MOVE    RECE41-HKNID        TO  RECE42-HKNID
           MOVE    RECE41-TEKSTYMD     TO  RECE42-TEKSTYMD
           MOVE    PTBYO-SRYYMD        TO  RECE42-SRYYMD
           MOVE    WRK-RENNUM          TO  RECE42-RENNUM
           MOVE    RECE41-PTNUM        TO  RECE42-PTNUM
           MOVE    PTBYO-SRYKA         TO  RECE42-SRYKA
           MOVE    PTBYO-KHNBYOMEICD   TO  RECE42-KHNBYOMEICD   
           MOVE    PTBYO-BYOMEICD-G    TO  RECE42-BYOMEICD-G
           MOVE    PTBYO-UTAGAIFLG     TO  RECE42-UTAGAIFLG
           IF      PTBYO-SYUBYOFLG     =   "1"
               MOVE    PTBYO-SYUBYOFLG     TO  RECE42-SYUBYOFLG    
           ELSE
               MOVE    "9"                 TO  RECE42-SYUBYOFLG 
           END-IF   
           MOVE    PTBYO-MANSEIKBN     TO  RECE42-MANSEIKBN
           IF      RECE41-SRYYM        <   PTBYO-TENKIYMD(1:6)
               CONTINUE
           ELSE    
               MOVE    PTBYO-TENKIKBN      TO  RECE42-TENKIKBN
               MOVE    PTBYO-TENKIYMD      TO  RECE42-TENKIYMD   
           END-IF    
           MOVE    WRK-BYOMEI          TO  RECE42-BYOMEI
           COMPUTE RECE42-BYOMEIMOJI    =   WRK-MOJISU    /   2
           MOVE    PTBYO-BYOMEIHENFLG  TO  RECE42-BYOMEIHENFLG   
      *
           WRITE   RECE42-REC
           ADD     1                   TO  CNT-OUT   
076800     .
076900 20011-RECE42-WRITE-EXT.
077000     EXIT.
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
057400*
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   RECE41-FILE
           CLOSE   RECE42-FILE
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
          DISPLAY "RECE41  IN  " CNT-IN 
          DISPLAY "RECE42  CNT " CNT-OUT  
          DISPLAY "*** ORCR0440 END ***"
      ***     ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者病名マスタ　ＲＥＡＤ
      *****************************************************************
       900-PTBYO-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-PTBYOMEI
               MOVE    MCPDATA-REC     TO  PTBYOMEI-REC 
           ELSE
               MOVE    1               TO  FLG-PTBYOMEI
           END-IF
           .
       900-PTBYO-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細書０２読込
      *****************************************************************
       900-RECE41-READ-SEC             SECTION.
      *
           READ    RECE41-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
               NOT AT  END
                   ADD     1           TO  CNT-IN
                   MOVE    ZERO        TO  FLG-END
           END-READ
           .
       900-RECE41-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
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
       900-SYSKANRI-READ-EXT.
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
      *
