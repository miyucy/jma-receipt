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
000300 PROGRAM-ID.             ORCR0400.
000400*****************************************************************
000500*  システム名        : ＯＲＣＡ
000600*  サブシステム名    : レセプト（労災・自賠責）
000700*  コンポーネント名  : 月次業務　労災自賠責明細書ファイル作成
      *                              （対象患者抽出）
000800*  管理者            : 
000900*  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
001100*****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-門脇    02.09.09  自賠責対応
      *  01.00.02    NACL-藤原    03.02.24  最新のレセプトのみＤＢに残す
      *****************************************************************
001200*
001300 ENVIRONMENT             DIVISION.
001400 CONFIGURATION           SECTION.
001500 INPUT-OUTPUT            SECTION.
001600 FILE-CONTROL.
      *
      *    レセプト明細書  
           SELECT  RECE40-FILE     ASSIGN  RECE40PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE40-KEY
                                   FILE    STATUS  IS  STS-RECE40.
006900*
           SELECT  RECE401-FILE    ASSIGN  RECE40PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE401-KEY
                                   FILE    STATUS  IS  STS-RECE401.
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
006900*
007000 DATA                    DIVISION.
007100 FILE                    SECTION.
      *
      *    レセプト明細書  
       FD  RECE40-FILE.
       01  RECE40-REC. 
           COPY    "CPRCF040.INC".
      *
       FD  RECE401-FILE.
       01  RECE401-REC. 
           COPY    "CPRCF040.INC"  REPLACING  //RECE40//
                                   BY         //RECE401//.
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
010200 WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE40//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
018000*    フラグ領域
       01  STS-AREA.
           03  STS-RECE40                              PIC X(02).
           03  STS-RECE401                             PIC X(02).
           03  STS-RECEERR                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-SRYACCT                             PIC 9(01).
           03  FLG-SYSKANRI                            PIC 9(01).
           03  FLG-HKNCOMBI                            PIC 9(01). 
           03  FLG-RECE40                              PIC 9(01).
           03  FLG-PTRSIINF                            PIC 9(01).
           03  FLG-PTINF                               PIC 9(01).
           03  FLG-RECE07                              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                                  PIC 9(06).
           03  CNT-OUT                                 PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDW                                     PIC 9(03). 
           03  IDX                                     PIC 9(03). 
           03  IDX1                                    PIC 9(03). 
           03  IDY                                     PIC 9(03). 
           03  IDZ                                     PIC 9(03).
           03  TBL-MAX                                 PIC 9(03).
      *
       01  KEY-AREA                            VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-PTID                          PIC 9(10).
               05  KEY-N-HKNCOMBI                      PIC 9(04).
               05  KEY-N-SRYKA                         PIC X(02).
           03  KEY-OLD.
               05  KEY-O-PTID                          PIC 9(10).
               05  KEY-O-HKNCOMBI                      PIC 9(04).
               05  KEY-O-SRYKA                         PIC X(02).
024000*
024100*    一時領域
      *
024200 01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM                      PIC  X(06).
               05  WRK-PARA-TERMID                     PIC  X(16).
               05  WRK-PARA-SYSYMD                     PIC  X(08).
               05  WRK-PARA-SYOKBN                     PIC  X(01).
               05  WRK-PARA-RECEKBN                    PIC  X(01).
               05  WRK-PARA-JOBID                      PIC  9(07).
               05  WRK-PARA-SHELLID                    PIC  X(08).
      *
           03  WRK-RECEERR             PIC X(200). 
      *
           03  WRK-HKNNUM              PIC 9(03).     
      *
           03  WRK-PATH                PIC X(64).
      *
           03  WRK-SRYYMD.
               05  WRK-SRYYM           PIC 9(06).
               05  WRK-SRYDD           PIC 9(02).  
           03  WRK-SYOKBN              PIC X(01).
      *
           03  WRK-STYMD               PIC X(08).
           03  WRK-EDYMD               PIC X(08).
           03  WRK-UPDKBN              PIC X(01).
           03  WRK-TEISEIKBN           PIC X(01).
           03  WRK-ROUSAIKBN           PIC X(01).
      * 
           03  WRK-YMD.
               05  WRK-YY              PIC 9(04).
               05  WRK-MM              PIC 9(02).
               05  WRK-DD              PIC 9(02).     
      *
       01  WRK-CONS-AREA.
      *    労災保険番号 
           03  WRK-CONS-ROUSAI-HKNNUM  PIC X(03)   VALUE   "971".
      *     
      *
       01  WRK-RECE07-REC. 
           COPY    "CPRCF007.INC"  REPLACING  //RECE07//
                                   BY         //WRK-RECE07//.
      * 
       01  WRK-RECE40-REC. 
           COPY    "CPRCF040.INC"  REPLACING  //RECE40//
                                   BY         //WRK-RECE40//.
      *
           COPY    "MCPAREA".
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
      *    医療機関情報
           COPY  "CPSK1001.INC".
      *    医療機関情報
           COPY  "CPSK1005.INC".
      *    レセプト作成指示コード
           COPY    "CPSK2001.INC".
      *    レセプト作成指示（個別指示）コード
           COPY    "CPSK2002.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    レセプト管理     
       01  RECE07-REC. 
           COPY    "CPRCF007.INC".
      *
      *    レセプト
           COPY    "CPRCF008.INC".
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
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
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
           MOVE    "ORCR0400"      TO  JOB-PGID
           MOVE    "対象患者抽出（労災）"                              
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
      *
           MOVE    WRK-PARA-SRYYM      TO  SYS-2001-SRYYM
           MOVE    WRK-PARA-SYOKBN     TO  SYS-2001-SYOKBN 
      *
           MOVE    "RECE400"           TO  RECE40PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE40PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    ZERO                TO  ORC-DBYMD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           ELSE
               MOVE    "医療機関情報が取得できませんでした。"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           OPEN    OUTPUT              RECE401-FILE
           CLOSE                       RECE401-FILE
      *
           OPEN    I-O                 RECE40-FILE  
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *    
           EVALUATE    WRK-PARA-SYOKBN
               WHEN    "1"
                   PERFORM 2001-IKKATU-SYORI-SEC
               WHEN    "2"
                   PERFORM 2002-KOBETU-SYORI-SEC
           END-EVALUATE
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.             
      * 
      *****************************************************************
      *    一括処理
      *****************************************************************
       2001-IKKATU-SYORI-SEC               SECTION.
      *
      *    診療年月編集
           MOVE    WRK-PARA-SRYYM      TO  WRK-STYMD (1:6)
           MOVE    "01"                TO  WRK-STYMD (7:2)
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY7-AREA
           MOVE    "71"                TO  LNK-DAY7-IRAI
           MOVE    WRK-PARA-SRYYM      TO  LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-EDYMD 
      *
      *    診療年月レセプト管理削除処理（一括分）
           INITIALIZE                  RECE07-REC
           MOVE    "HC21"              TO  RECE07-PRTID
           MOVE    WRK-PARA-SRYYM      TO  RECE07-SRYYM
           MOVE    "1"                 TO  RECE07-SYOKBN
           MOVE    "2"                 TO  RECE07-NYUGAIKBN
           MOVE    WRK-PARA-RECEKBN    TO  RECE07-RECEKBN
           MOVE    RECE07-REC          TO  MCPDATA-REC
           MOVE    "RECEKANRI-KEY7"    TO  WRK-PATH
           PERFORM 900-RECE07-INV-SEC
           IF      FLG-RECE07          =   ZERO
               MOVE    RECE07-REC          TO  WRK-RECE07-REC
               MOVE    RECE07-REC          TO  MCPDATA-REC 
               MOVE    "RECEKANRI-DEL1"    TO  ORC-DBPATH
               MOVE    "DBDELETE"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC    
      *
      *        診療年月レセプト削除処理（一括分）
               INITIALIZE                  RECE08-REC
               MOVE    WRK-RECE07-PRTID    TO  RECE08-PRTID
               MOVE    WRK-RECE07-SRYYM    TO  RECE08-RECEYM
               MOVE    WRK-RECE07-CREYMD   TO  RECE08-CREYMD
               MOVE    WRK-RECE07-CREHMS   TO  RECE08-CREHMS
               MOVE    WRK-RECE07-NYUGAIKBN
                                           TO  RECE08-NYUGAIKBN
               MOVE    RECE08-REC          TO  MCPDATA-REC
               MOVE    "RECEPRT-DEL1"      TO  ORC-DBPATH
               MOVE    "DBDELETE"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           END-IF  
      *
      *    診療会計読み込み（患者ＩＤ、保険組合せ、診療科順）
           INITIALIZE                  SRYACCT-REC
           MOVE    SYS-1001-HOSPID     TO  ACCT-HOSPID
           MOVE    SYS-2001-SRYYM      TO  ACCT-SRYYM
           MOVE    "2"                 TO  ACCT-NYUGAIKBN
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY8"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY8"      TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           PERFORM UNTIL       FLG-SRYACCT     =   1
               PERFORM 20011-IKKATU-HENSYU-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY8"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       2001-IKKATU-SYORI-EXT.
           EXIT. 
      *            
070100*****************************************************************
070200*    一括編集処理
070300*****************************************************************
070400 20011-IKKATU-HENSYU-SEC              SECTION.
      *
      *    テスト患者のときは読み飛ばす
           MOVE    SYS-1001-HOSPID         TO  PTINF-HOSPID
           MOVE    KEY-N-PTID              TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           =   ZERO
           AND     PTINF-TSTPTNUMKBN   =   "1"
               MOVE    KEY-NEW             TO  KEY-OLD
               PERFORM         UNTIL   FLG-SRYACCT     =   1 
                               OR      KEY-N-PTID  NOT =   KEY-O-PTID
                   MOVE    "SRYACCT-KEY8"          TO  ORC-DBPATH
                   PERFORM 900-SRYACCT-READ-SEC
               END-PERFORM
           ELSE
               MOVE    KEY-NEW             TO  KEY-OLD
               PERFORM         UNTIL   FLG-SRYACCT     =   1 
                               OR      KEY-N-PTID  NOT =   KEY-O-PTID
      *            保険組合せ読込み
                   INITIALIZE                  HKNCOMBI-REC
                   MOVE    SYS-1001-HOSPID     TO  COMB-HOSPID
                   MOVE    KEY-N-PTID          TO  COMB-PTID
                   MOVE    KEY-N-HKNCOMBI      TO  COMB-HKNCOMBINUM 
                   MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
                   PERFORM 910-HKNCOMBI-INV-SEC
      *
      *            未訂正分があるか
                   MOVE    SPACE               TO  WRK-UPDKBN
                                                   WRK-TEISEIKBN
                                                   WRK-ROUSAIKBN
      *
                   IF      FLG-HKNCOMBI    =   ZERO
                       IF      COMB-HKNNUM  =   WRK-CONS-ROUSAI-HKNNUM
                           IF      COMB-TEKSTYMD   <=  WRK-STYMD
                           AND     COMB-TEKEDYMD   >=  WRK-EDYMD
                               MOVE    SPACE           TO  WRK-UPDKBN
                           ELSE
                               MOVE    "1"             TO  WRK-UPDKBN
                           END-IF
                       ELSE     
                           MOVE    "1"             TO  WRK-ROUSAIKBN
                       END-IF    
                   ELSE
                       MOVE    "1"             TO  WRK-TEISEIKBN    
                   END-IF    
      *             
                   MOVE    KEY-NEW             TO  KEY-OLD
                   PERFORM         UNTIL   FLG-SRYACCT     =   1 
                                   OR      KEY-NEW     NOT =   KEY-OLD
                       IF      WRK-ROUSAIKBN           =   SPACE            
                           PERFORM 20011-FILE-SYORI-SEC 
                       END-IF    
      *
      *                処理対象以外かアフターケア以外か日付変更がないとき
      *                同じ患者ＩＤ・診療科・保険組合せは読み飛ばす
                       IF    ( WRK-ROUSAIKBN         =   "1"           )  
                       OR    (     ( WRK-UPDKBN      =   SPACE       )         
                               AND ( PTRSI-HKNKBN    =   "1" OR  "2" 
                                                             OR  "4" ) )  
                           MOVE    KEY-NEW             TO  KEY-OLD
                           PERFORM     UNTIL   FLG-SRYACCT =   1 
                                       OR      KEY-NEW NOT =   KEY-OLD
                               MOVE    "SRYACCT-KEY8"  TO  ORC-DBPATH
                               PERFORM 900-SRYACCT-READ-SEC
                           END-PERFORM
                       ELSE
                           MOVE    "SRYACCT-KEY8"      TO  ORC-DBPATH
                           PERFORM 900-SRYACCT-READ-SEC
                       END-IF
                   END-PERFORM    
               END-PERFORM         
           END-IF    
           .
       20011-IKKATU-HENSYU-EXT.
           EXIT. 
      *            
070100*****************************************************************
070200*    ファイル処理
070300*****************************************************************
070400 20011-FILE-SYORI-SEC              SECTION.
      *
      *    労災保険情報読み込み     
           INITIALIZE              PTRSIINF-REC
           MOVE    COMB-HOSPID     TO  PTRSI-HOSPID
           MOVE    COMB-HKNID      TO  PTRSI-HKNID
           MOVE    COMB-PTID       TO  PTRSI-PTID
           MOVE    PTRSIINF-REC    TO  MCPDATA-REC
           PERFORM 900-PTRSIINF-INV-SEC
           IF      FLG-PTRSIINF    =   "1"
               MOVE    "1"             TO  WRK-ROUSAIKBN
           END-IF                
      *
      *    労災・自賠責保険以外のとき処理しない
           IF      WRK-ROUSAIKBN       =   "1"
               GO  TO  20011-FILE-SYORI-EXT
           END-IF
      *                  
           IF      WRK-UPDKBN          =   "1"
      *    保険の訂正がされているか
               IF      COMB-TEKSTYMD(1:6)  =   WRK-STYMD (1:6)
                   MOVE    COMB-TEKSTYMD       TO  WRK-YMD
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX             >=  WRK-DD
                           OR      WRK-TEISEIKBN   =   "1"
                       IF      ACCT-DAY (1 IDX)    >   ZERO
                           MOVE    "1"             TO  WRK-TEISEIKBN
                       END-IF
                   END-PERFORM
               ELSE
                   IF      COMB-TEKSTYMD(1:6)  >   WRK-STYMD (1:6)
                       MOVE    "1"             TO  WRK-TEISEIKBN
                   END-IF
               END-IF      
               IF      COMB-TEKEDYMD(1:6)  =   WRK-EDYMD (1:6)
                   MOVE    COMB-TEKEDYMD       TO  WRK-YMD
                   ADD     1                   TO  WRK-DD
                   PERFORM VARYING IDX FROM    WRK-DD  BY  1
                           UNTIL   IDX             >   31
                           OR      WRK-TEISEIKBN   =   "1"
                       IF      ACCT-DAY (1 IDX)    >   ZERO
                           MOVE    "1"             TO  WRK-TEISEIKBN
                       END-IF
                   END-PERFORM
               ELSE
                   IF      COMB-TEKEDYMD(1:6)  <   WRK-EDYMD (1:6)
                       MOVE    "1"             TO  WRK-TEISEIKBN
                   END-IF    
               END-IF    
           END-IF
      *     
      *        レセプト診療科（旧総合病院のとき）
           IF      SYS-1001-HOSPSBT1   =   1
               INITIALIZE                  SYS-1005-REC
               MOVE    "1005"              TO  SYS-1005-KANRICD
               MOVE    ACCT-SRYKA          TO  SYS-1005-KBNCD
               IF      WRK-PARA-SYOKBN     =   "1"
                   MOVE    SYS-2001-SRYYM      TO  ORC-DBYMD(1:6)
               ELSE
                   MOVE    SYS-2002-SRYYM      TO  ORC-DBYMD(1:6)
               END-IF
               MOVE    "01"                TO  ORC-DBYMD(7:2)
               MOVE    SYS-1005-REC        TO  MCPDATA-REC
               PERFORM 910-SYSKANRI-INV-SEC
               MOVE    MCPDATA-REC         TO  SYS-1005-REC
           ELSE
               INITIALIZE                   SYS-1005-REC
           END-IF
      *
      *    最終診療日
      *
      *    請求書
           PERFORM 20011-FILE-HENSYU-SEC
           .
       20011-FILE-SYORI-EXT.
           EXIT. 
      *            
      *            
070100*****************************************************************
070200*    ファイル編集処理
070300*****************************************************************
070400 20011-FILE-HENSYU-SEC              SECTION.
      *     
           INITIALIZE                      WRK-RECE40-REC
           MOVE    SYS-1001-HOSPID     TO  WRK-RECE40-HOSPID
           IF      WRK-PARA-SYOKBN     =   "1"
               MOVE    SYS-2001-SRYYM      TO  WRK-RECE40-SRYYM
           ELSE
               MOVE    SYS-2002-SRYYM      TO  WRK-RECE40-SRYYM
           END-IF
           MOVE    ACCT-NYUGAIKBN      TO  WRK-RECE40-NYUGAIKBN
           MOVE    COMB-PTID           TO  WRK-RECE40-PTID
           IF      SYS-1001-HOSPSBT1   =   1
               MOVE    SYS-1005-RECESRYKA  TO WRK-RECE40-RECEKA
           ELSE
               MOVE    SPACE               TO WRK-RECE40-RECEKA
           END-IF
           MOVE    COMB-HKNID          TO  WRK-RECE40-HKNID
           IF      PTRSI-HKNKBN        =   "3"
               PERFORM VARYING IDW FROM    1   BY  1
                       UNTIL   IDW         >   31
                   IF      ACCT-DAY (1 IDW)    >   ZERO
                       MOVE    ACCT-SRYYM      TO  WRK-SRYYM
                       MOVE    IDW             TO  WRK-SRYDD
                       MOVE    WRK-SRYYMD      TO  WRK-RECE40-TEKSTYMD  
                       MOVE    WRK-RECE40-KEY      TO  RECE40-KEY
                       PERFORM 900-RECE40-READ-SEC
                       IF      FLG-RECE40          =   ZERO
                           MOVE    RECE40-REC  TO  WRK-RECE40-REC 
                           PERFORM 20011-RECE40-REWRITE-SEC
                       ELSE
                           MOVE    WRK-SRYYMD  TO  WRK-RECE40-TEKSTYMD  
                           PERFORM 20011-RECE40-WRITE-SEC
                       END-IF
                   END-IF
               END-PERFORM
            ELSE   
               MOVE    COMB-TEKSTYMD       TO  WRK-RECE40-TEKSTYMD
               MOVE    WRK-RECE40-KEY      TO  RECE40-KEY 
               PERFORM 900-RECE40-READ-SEC
               IF      FLG-RECE40          =   ZERO
                   MOVE    RECE40-REC          TO  WRK-RECE40-REC 
                   PERFORM 20011-RECE40-REWRITE-SEC
               ELSE
                   PERFORM 20011-RECE40-WRITE-SEC
               END-IF
           END-IF    
      *   
           .
       20011-FILE-HENSYU-EXT.
           EXIT. 
      *            
070100*****************************************************************
070200*    出力処理
070300*****************************************************************
070400 20011-RECE40-WRITE-SEC              SECTION.
      *
           MOVE    COMB-HKNNUM        TO  WRK-RECE40-HKNNUM
           MOVE    COMB-HKNCOMBINUM   TO  WRK-RECE40-HKNCOMBI
           MOVE    ACCT-SRYKA         TO  WRK-RECE40-SRYKA (1)
           MOVE    WRK-TEISEIKBN      TO  WRK-RECE40-TEISEIKBN
      *
           MOVE    WRK-RECE40-REC      TO  RECE40-REC
           WRITE   RECE40-REC
           ADD     1                   TO  CNT-OUT
      *
076800     .
076900 20011-RECE40-WRITE-EXT.
077000     EXIT.
      *            
070100*****************************************************************
070200*    出力処理
070300*****************************************************************
070400 20011-RECE40-REWRITE-SEC            SECTION.
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       10
               IF      WRK-RECE40-SRYKA    (IDX)       =   SPACE
                   MOVE    ACCT-SRYKA      TO  WRK-RECE40-SRYKA (IDX)
                   MOVE    10              TO  IDX
               ELSE
                   IF      WRK-RECE40-SRYKA    (IDX)   =   ACCT-SRYKA
                       MOVE    10                  TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-TEISEIKBN           =   "1"
               MOVE    "1"                 TO  WRK-RECE40-TEISEIKBN     
           END-IF          
      *
           MOVE    WRK-RECE40-REC      TO  RECE40-REC
           REWRITE RECE40-REC
076800     .
076900 20011-RECE40-REWRITE-EXT.
077000     EXIT.
      * 
      *****************************************************************
      *    個別処理
      *****************************************************************
       2002-KOBETU-SYORI-SEC               SECTION.
      *
      *    レセプト管理削除処理（個別分）
           INITIALIZE                  RECE07-REC
           MOVE    "HC21"              TO  RECE07-PRTID
           MOVE    "2"                 TO  RECE07-NYUGAIKBN
           MOVE    RECE07-REC          TO  MCPDATA-REC
           MOVE    "RECEKANRI-DEL2"    TO  ORC-DBPATH
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC      
      *
      *    レセプト削除処理（個別分）
           INITIALIZE                  RECE08-REC
           MOVE    "HC21"              TO  RECE08-PRTID
           MOVE    "2"                 TO  RECE08-NYUGAIKBN
           MOVE    RECE08-REC          TO  MCPDATA-REC
           MOVE    "RECEPRT-DEL2"      TO  ORC-DBPATH
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC      
      *
      *        レセプト指示（個別指示）コード読み込み
           INITIALIZE                      SYS-2002-REC
           MOVE    "2002"              TO  SYS-2002-KANRICD
           MOVE    ZERO                TO  ORC-DBYMD
           MOVE    SYS-2002-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           PERFORM 20021-KOBETU-HENSYU-SEC
                              UNTIL       FLG-SYSKANRI    =   1
                              OR          FLG-END         =   1
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
069800     .
057900*
069900 2002-KOBETU-SYORI-EXT.
070000     EXIT.
070100*****************************************************************
070200*    個別編集処理
070300*****************************************************************
070400 20021-KOBETU-HENSYU-SEC              SECTION.
      *
           MOVE    MCPDATA-REC         TO  SYS-2002-REC
      *
      *??     IF      SYS-2002-RECEKBN    =   "1"
      *        診療年月編集
               MOVE    SYS-2002-SRYYM      TO  WRK-STYMD (1:6)
               MOVE    "01"                TO  WRK-STYMD (7:2)
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY7-AREA
               MOVE    "71"                TO  LNK-DAY7-IRAI
               MOVE    SYS-2002-SRYYM      TO  LNK-DAY7-YM
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY7-AREA
               MOVE    LNK-DAY7-KOYOMI     TO  WRK-EDYMD 
      *
      *        診療会計読み込み
               INITIALIZE                  SRYACCT-REC
               MOVE    SYS-1001-HOSPID     TO  ACCT-HOSPID
               MOVE    SYS-2002-PTID       TO  ACCT-PTID
               MOVE    SYS-2002-SRYYM      TO  ACCT-SRYYM
               MOVE    SYS-2002-NYUGAIKBN  TO  ACCT-NYUGAIKBN
               MOVE    SRYACCT-REC         TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
                   PERFORM 900-SRYACCT-READ-SEC
               ELSE
                   INITIALIZE                  SRYACCT-REC
                   MOVE    1                   TO  FLG-SRYACCT
               END-IF
      *
               PERFORM UNTIL       FLG-SRYACCT     =   1
                   PERFORM 20011-HENSYU-SEC
               END-PERFORM
      *        カーソルクロース
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *??     END-IF                                 
      *    
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           PERFORM 900-SYSKANRI-READ-SEC
076800     .
076900 20021-KOBETU-HENSYU-EXT.
077000     EXIT.
057400*
      *****************************************************************
      *    データ出力処理
      *****************************************************************
       20011-HENSYU-SEC                SECTION.
      *
           MOVE    KEY-NEW             TO  KEY-OLD
           PERFORM             UNTIL   FLG-SRYACCT     =   1 
               MOVE    ACCT-HKNCOMBI       TO  KEY-N-HKNCOMBI
               MOVE    ACCT-PTID           TO  KEY-N-PTID 
               MOVE    ACCT-SRYKA          TO  KEY-N-SRYKA
      *        保険組合せ読込み
               INITIALIZE                  HKNCOMBI-REC
               MOVE    SYS-1001-HOSPID     TO  COMB-HOSPID
               MOVE    ACCT-PTID           TO  COMB-PTID
               MOVE    ACCT-HKNCOMBI       TO  COMB-HKNCOMBINUM 
               MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
               PERFORM  910-HKNCOMBI-INV-SEC
      *
      *        未訂正分があるか
               MOVE    SPACE               TO  WRK-UPDKBN
                                               WRK-TEISEIKBN
                                               WRK-ROUSAIKBN
      *
               IF      FLG-HKNCOMBI    =   ZERO
                   IF      COMB-HKNNUM  =   WRK-CONS-ROUSAI-HKNNUM
                       IF      COMB-TEKSTYMD   <=  WRK-STYMD
                       AND     COMB-TEKEDYMD   >=  WRK-EDYMD
                           MOVE    SPACE           TO  WRK-UPDKBN
                       ELSE
                           MOVE    "1"             TO  WRK-UPDKBN
                       END-IF
                   ELSE     
                       MOVE    "1"             TO  WRK-ROUSAIKBN
                   END-IF    
               ELSE
                   MOVE    "1"             TO  WRK-TEISEIKBN    
               END-IF    
      *
               MOVE    KEY-NEW             TO  KEY-OLD
               PERFORM         UNTIL   FLG-SRYACCT     =   1
                               OR      KEY-NEW     NOT =   KEY-OLD
                   IF      WRK-ROUSAIKBN           =   SPACE            
                       PERFORM 20011-FILE-SYORI-SEC
                   END-IF    
      *
                   IF    ( WRK-ROUSAIKBN           =   "1"           )  
                   OR    (     ( WRK-UPDKBN        =   SPACE       )         
                           AND ( PTRSI-HKNKBN      =   "1" OR  "2" 
                                                           OR  "4" ) )    
                       MOVE    KEY-NEW             TO  KEY-OLD
                       PERFORM     UNTIL   FLG-SRYACCT     =   1 
                                   OR      KEY-NEW     NOT =   KEY-OLD
                           MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
                           PERFORM 900-SRYACCT-READ-SEC
                        END-PERFORM
                   ELSE
                       MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
                       PERFORM 900-SRYACCT-READ-SEC
                   END-IF
               END-PERFORM    
           END-PERFORM         
      *
           .
       20011-HENSYU-EXT.
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
           .
       500-ERR-HENSYU-EXT.
           EXIT.
057400*
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   RECE40-FILE
      *
           IF      CNT-OUT             =   ZERO 
               MOVE    "処理対象のデータがありませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
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
           DISPLAY "RECE40  CNT " CNT-OUT 
           DISPLAY "*** ORCR0400 END ***"
      ***  ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       910-SYSKANRI-INV-SEC         SECTION.
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
       910-SYSKANRI-INV-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    診療行為マスタ　ＲＥＡＤ
      *****************************************************************
       900-SRYACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-SRYACCT
               MOVE    MCPDATA-REC         TO  SRYACCT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           IF      FLG-SRYACCT         =   ZERO
               MOVE    ACCT-PTID           TO  KEY-N-PTID 
               MOVE    ACCT-HKNCOMBI       TO  KEY-N-HKNCOMBI
               MOVE    ACCT-SRYKA          TO  KEY-N-SRYKA
           END-IF
           .
       900-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスタ読込
      *****************************************************************
       910-HKNCOMBI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNCOMBI
                   MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
                   IF      COMB-DELKBN         =   "1"
                       MOVE    1                   TO  FLG-HKNCOMBI
                   END-IF
               ELSE
                   MOVE    1                   TO  FLG-HKNCOMBI
                   INITIALIZE                      HKNCOMBI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNCOMBI
               INITIALIZE                      HKNCOMBI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-HKNCOMBI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者労災保険情報マスタ読込
      *****************************************************************
       900-PTRSIINF-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-PTRSIINF
                   MOVE    MCPDATA-REC         TO  PTRSIINF-REC
                   IF      PTRSI-SAKUJOKBN     =   "1"
                       MOVE    1                   TO  FLG-PTRSIINF
                   END-IF
               ELSE
                    INITIALIZE                 PTRSIINF-REC
                   MOVE    1                   TO  FLG-PTRSIINF
               END-IF
           ELSE
               INITIALIZE                  PTRSIINF-REC
               MOVE    1                   TO  FLG-PTRSIINF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-PTRSIINF-INV-EXT.
           EXIT.
      *
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
      *
      *****************************************************************
      *    レセプト管理読込（キー）
      *****************************************************************
       900-RECE07-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    WRK-PATH            TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-RECE07
                   MOVE    MCPDATA-REC         TO  RECE07-REC
               ELSE
                   MOVE    1                   TO  FLG-RECE07
               END-IF
           ELSE
               MOVE    1                   TO  FLG-RECE07
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-RECE07-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細書読込
      *****************************************************************
       900-RECE40-READ-SEC             SECTION.
      *
           READ    RECE40-FILE
               INVALID
                   MOVE    1           TO  FLG-RECE40
               NOT INVALID
                   MOVE    ZERO        TO  FLG-RECE40
           END-READ
           .
       900-RECE40-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細書読込（順読み）
      *****************************************************************
       910-RECE40-READ-N-SEC             SECTION.
      *
           READ    RECE40-FILE     NEXT
               AT  END
                   MOVE    1           TO  FLG-RECE40
               NOT AT  END
                   MOVE    ZERO        TO  FLG-RECE40
           END-READ
           .
       910-RECE40-READ-N-EXT.
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
