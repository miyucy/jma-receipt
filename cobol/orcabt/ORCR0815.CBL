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
       PROGRAM-ID.             ORCR0815.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト入院（労災・自賠責）
      *  コンポーネント名  : 月次業務　自賠責明細書ファイル作成
      *                              （自賠責対象患者抽出）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/06/01    NACL−藤原　  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-門脇    04/01/14  診療行為の包括分は除く
      *                                     SRYACCT8→29
      *                                     SRYACCT9→30
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    レセプト明細書  
           SELECT  RECE82-FILE     ASSIGN  RECE82PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE82-KEY
                                   FILE    STATUS  IS  STS-RECE82.
      *
           SELECT  RECE821-FILE    ASSIGN  RECE82PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE821-KEY
                                   FILE    STATUS  IS  STS-RECE821.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    レセプト明細書  
       FD  RECE82-FILE.
       01  RECE82-REC. 
           COPY    "CPRCF082.INC".
      *
       FD  RECE821-FILE.
       01  RECE821-REC. 
           COPY    "CPRCF082.INC"  REPLACING  //RECE82//
                                   BY         //RECE821//.
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE82//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE82              PIC X(02).
           03  STS-RECE821             PIC X(02).
           03  STS-RECEERR             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-SRYACCT             PIC 9(01).
           03  FLG-NYUINACCT           PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-KYUSEIRRK           PIC 9(01).
           03  FLG-HKNCOMBI            PIC 9(01). 
           03  FLG-PTRSIINF            PIC 9(01).
           03  FLG-PTINF               PIC 9(01).
           03  FLG-RECE07              PIC 9(01).
           03  FLG-RECE82              PIC 9(01).
      *
           03  FLG-ARI                 PIC 9(01).
           03  FLG-SET                 PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                  PIC 9(06).
           03  CNT-OUT                 PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDW                     PIC 9(03). 
           03  IDX                     PIC 9(03). 
           03  IDX1                    PIC 9(03). 
           03  IDX2                    PIC 9(03). 
           03  IDX3                    PIC 9(03). 
           03  IDX4                    PIC 9(03).
           03  IDX5                    PIC 9(03).
           03  IDY                     PIC 9(03). 
           03  IDZ                     PIC 9(03).
           03  TBL-MAX                 PIC 9(03).
           03  SYSKAN-IDX              PIC 9(03).
      *
       01  KEY-AREA                            VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-PTID                          PIC 9(10).
               05  KEY-N-HKNCOMBI                      PIC 9(04).
           03  KEY-OLD.
               05  KEY-O-PTID                          PIC 9(10).
               05  KEY-O-HKNCOMBI                      PIC 9(04).
      *
      *    医療機関（基本情報）退避用領域
       01  TBL-SYS1001-T.
           03  TBL-SYS1001-OCC                         OCCURS  10.
               05  TBL-SYS1001                         PIC X(610).
      *    労災自賠医療機関退避用領域
       01  TBL-SYS4001-T.
           03  TBL-SYS4001-OCC                         OCCURS  10.
               05  TBL-SYS4001                         PIC X(610).
      *
      *    一時領域
      *
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM                      PIC  X(06).
               05  WRK-PARA-TERMID                     PIC  X(16).
               05  WRK-PARA-SYSYMD                     PIC  X(08).
               05  WRK-PARA-SYOKBN                     PIC  X(01).
               05  WRK-PARA-RECEKBN                    PIC  X(01).
               05  WRK-PARA-JOBID                      PIC  9(07).
               05  WRK-PARA-SHELLID                    PIC  X(08).
      *
           03  WRK-SYS-SRYYMD          PIC X(08).
      *
           03  WRK-RECEERR             PIC X(200). 
      *
           03  WRK-HKNNUM              PIC 9(03).     
      *
           03  WRK-DBPATH              PIC X(64).
      *
           03  WRK-KSNRATE             PIC 9(03).      
           03  WRK-DBKBN               PIC X(01).
      *
           03  WRK-STYMD               PIC X(08).
           03  WRK-EDYMD               PIC X(08).
      *
           03  WRK-ERR-AREA.
               05  WRK-UPDKBN          PIC X(01).
               05  WRK-TEISEIKBN       PIC X(01).
               05  WRK-ROUSAIKBN       PIC X(01).
               05  WRK-ERR-DAY         PIC 9(02).
               05  WRK-ERR-HKNCOMBINUM PIC 9(04).
               05  WRK-ERR-ERRKBN      PIC X(01).
               05  WRK-ERR-TEKSTYMD    PIC 9(08).
               05  WRK-ERR-TEKEDYMD    PIC 9(08).
      * 
           03  WRK-YMD.
               05  WRK-YY              PIC 9(04).
               05  WRK-MM              PIC 9(02).
               05  WRK-DD              PIC 9(02).     
      *
           03  WRK-SRYYMD.
               05  WRK-SRYYYMM         PIC 9(06).
               05  WRK-SRYDD           PIC 9(02).
      *              
      *    診療回数テーブル（入院会計用　１：基本　２：組合せ）
           03  WRK-DAY-AREA.
               05  WRK-DAY-TBL         OCCURS  2.
                   07  WRK-DAY         PIC 9(03)
                                           OCCURS   31.
      *     
      *    ワーク保険組合せ（入院会計用） 
       01  WRK-HKNCOMBI-TABLE.
           02  WRK-HKNCOMBI-REC        OCCURS  10. 
           COPY    "CPHKNCOMBI.INC"    REPLACING  //COMB-//
                                       BY         //WRK-COMB-//.
           03  WRK-HKNCOMBI-SYOKBN     PIC X(01).   
           03  WRK-HKNCOMBI-ERR-DAY    PIC 9(02).   
      *
      *    固定値
       01  WRK-CONS-AREA.
      *    労災保険番号 
           03  WRK-CONS-ROUSAI-HKNNUM
                                   PIC X(03)   VALUE   "971". 
      *    自賠責保険番号 
           03  WRK-CONS-JIBAI-HKNNUM
                                   PIC X(03)   VALUE   "973".       
      *     
      *
       01  WRK-RECE07-REC. 
           COPY    "CPRCF007.INC"  REPLACING  //RECE07//
                                   BY         //WRK-RECE07//.
      * 
       01  WRK-RECE82-REC. 
           COPY    "CPRCF082.INC"  REPLACING  //RECE82//
                                   BY         //WRK-RECE82//.
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
      *    医療機関情報
           COPY    "CPSK1001.INC".
      *
      *    患者番号構成管理情報
           COPY    "CPSK1009.INC".
      *
      *    レセプト作成指示コード
           COPY    "CPSK2001.INC".
      *
      *    レセプト作成指示（個別指示）コード
           COPY    "CPSK2002.INC".
      *
      *    労災自賠医療機関情報
           COPY    "CPSK4001.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
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
      *    旧姓履歴情報
       01  KYUSEIRRK-REC.
           COPY    "CPKYUSEIRRK.INC".
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
      *   保険算定用年齢・割合計算サブ
           COPY    "CPORCSAGECHK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
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
           MOVE    "ORCR0815"      TO  JOB-PGID
           MOVE    "対象患者抽出（自賠責）"                              
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
           MOVE    "RECE820"           TO  RECE82PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE82PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
      *
           IF   WRK-PARA-SRYYM    NOT =  ZERO
      *       医療機関ＩＤ編集
              INITIALIZE                  SYS-1001-REC
              MOVE    "1001"              TO  SYS-1001-KANRICD
              MOVE    "*"                 TO  SYS-1001-KBNCD
              MOVE    WRK-PARA-SRYYM      TO  ORC-DBYMD (1:6)
              MOVE    "01"                TO  ORC-DBYMD (7:2)
              MOVE    SYS-1001-REC        TO  MCPDATA-REC
              PERFORM 910-SYSKANRI-INV-SEC
              IF      FLG-SYSKANRI        =   ZERO
                  MOVE    MCPDATA-REC         TO  SYS-1001-REC
              ELSE
                  MOVE    "医療機関情報が取得できませんでした。"
                                              TO  WRK-RECEERR
                  PERFORM 500-ERR-HENSYU-SEC
              END-IF
           ELSE
              MOVE     ZERO               TO  SYSKAN-IDX
              MOVE     SPACE              TO  TBL-SYS1001-T
              INITIALIZE                      TBL-SYS1001-T
      *
              INITIALIZE                      SYS-1001-REC
              MOVE    "1001"              TO  SYS-1001-KANRICD
              MOVE    "*"                 TO  SYS-1001-KBNCD
              MOVE    SYS-1001-REC        TO  MCPDATA-REC
              MOVE    "DBSELECT"          TO  MCP-FUNC
              MOVE    "SYSKANRI-KEY8"     TO  ORC-DBPATH
              CALL    "ORCMCPSUB"             USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
              IF      MCP-RC              =   ZERO
                  MOVE    "SYSKANRI-KEY8" TO  ORC-DBPATH
                  PERFORM 900-SYSKANRI-READ-SEC
                  PERFORM  UNTIL   FLG-SYSKANRI  =    1
      *
                    MOVE    MCPDATA-REC   TO  SYS-1001-REC
                    ADD     1             TO  SYSKAN-IDX
                    MOVE    SYS-1001-REC  TO  TBL-SYS1001(SYSKAN-IDX)
      *
                    MOVE    "SYSKANRI-KEY8" TO  ORC-DBPATH
                    PERFORM 900-SYSKANRI-READ-SEC
      *
                  END-PERFORM
              ELSE
                  MOVE    "医療機関情報が取得できませんでした。"
                                            TO  WRK-RECEERR
                  PERFORM 500-ERR-HENSYU-SEC
              END-IF
      *
              MOVE    "DBCLOSE"           TO  MCP-FUNC
              MOVE    "SYSKANRI-KEY8"     TO  ORC-DBPATH
              CALL    "ORCMCPSUB"          USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-IF
      *
      *    患者番号構成管理情報編集
           INITIALIZE                  SYS-1009-REC
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
           MOVE    WRK-PARA-SRYYM      TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1009-REC
               MOVE    SYS-1009-PTNUMKSIKBN
                                       TO  SPA-1009-PTNUMKSIKBN
               MOVE    SYS-1009-HJNKSIKBN  
                                       TO  SPA-1009-HJNKSIKBN
               MOVE    SYS-1009-HJNKSINENKBN 
                                       TO  SPA-1009-HJNKSINENKBN
               MOVE    SYS-1009-HJNKSIRENNUMKBN
                                       TO  SPA-1009-HJNKSIRENNUMKBN
               MOVE    SYS-1009-HJNKSIRENNUMKETA
                                       TO  SPA-1009-HJNKSIRENNUMKETA
           ELSE
               MOVE    "患者番号構成管理情報が取得できませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           IF   WRK-PARA-SRYYM    NOT =  ZERO
      *       システム管理マスタ（４００１）から点数単価の取得
              INITIALIZE                         SYS-4001-REC
              MOVE    "4001"               TO    SYS-4001-KANRICD
              MOVE    "*"                  TO    SYS-4001-KBNCD
              MOVE    WRK-PARA-SRYYM       TO    ORC-DBYMD (1:6)
              MOVE    "01"                 TO    ORC-DBYMD (7:2)
              MOVE    SYS-4001-REC         TO    MCPDATA-REC
              PERFORM 910-SYSKANRI-INV-SEC
              IF      FLG-SYSKANRI        =   ZERO
                  MOVE    MCPDATA-REC         TO  SYS-4001-REC
                  IF      SYS-4001-KSNRATE(1:2)  =  SPACE                  
                      MOVE   100           TO    WRK-KSNRATE               
                  ELSE                                                     
                      COMPUTE WRK-KSNRATE  =  SYS-4001-KSNRATE             
                                           +  100                          
                  END-IF                                                   
              ELSE
                  MOVE    "労災自賠医療機関情報が取得できませんでした"     
                                              TO  WRK-RECEERR
                  PERFORM 500-ERR-HENSYU-SEC
              END-IF
           ELSE
              MOVE     ZERO               TO  SYSKAN-IDX
              MOVE     SPACE              TO  TBL-SYS4001-T
              INITIALIZE                      TBL-SYS4001-T
      *
              INITIALIZE                      SYS-4001-REC
              MOVE    "4001"              TO  SYS-4001-KANRICD
              MOVE    "*"                 TO  SYS-4001-KBNCD
              MOVE    SYS-4001-REC        TO  MCPDATA-REC
              MOVE    "DBSELECT"          TO  MCP-FUNC
              MOVE    "SYSKANRI-KEY8"     TO  ORC-DBPATH
              CALL    "ORCMCPSUB"             USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
              IF      MCP-RC              =   ZERO
                  MOVE    "SYSKANRI-KEY8" TO  ORC-DBPATH
                  PERFORM 900-SYSKANRI-READ-SEC
                  PERFORM  UNTIL   FLG-SYSKANRI  =    1
      *
                    MOVE    MCPDATA-REC   TO  SYS-4001-REC
                    ADD     1             TO  SYSKAN-IDX
                    MOVE    SYS-4001-REC  TO  TBL-SYS4001(SYSKAN-IDX)
      *
                    MOVE    "SYSKANRI-KEY8" TO  ORC-DBPATH
                    PERFORM 900-SYSKANRI-READ-SEC
      *
                  END-PERFORM
              ELSE
                  MOVE    "労災自賠医療機関情報が取得できませんでした"     
                                              TO  WRK-RECEERR
                  PERFORM 500-ERR-HENSYU-SEC
              END-IF
      *
              MOVE    "DBCLOSE"           TO  MCP-FUNC
              MOVE    "SYSKANRI-KEY8"     TO  ORC-DBPATH
              CALL    "ORCMCPSUB"          USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-IF
      *
           OPEN    OUTPUT              RECE821-FILE
           CLOSE                       RECE821-FILE
      *
           OPEN    I-O                 RECE82-FILE
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
           MOVE    "HC23"              TO  RECE07-PRTID
           MOVE    WRK-PARA-SRYYM      TO  RECE07-SRYYM
           MOVE    "1"                 TO  RECE07-SYOKBN
           MOVE    "1"                 TO  RECE07-NYUGAIKBN
           MOVE    WRK-PARA-RECEKBN    TO  RECE07-RECEKBN
           MOVE    RECE07-REC          TO  MCPDATA-REC
           MOVE    "RECEKANRI-KEY7"    TO  WRK-DBPATH
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
      *
           MOVE    "1"                 TO  WRK-DBKBN 
      *      
           INITIALIZE                  SRYACCT-REC
           MOVE    SYS-1001-HOSPID     TO  ACCT-HOSPID
           MOVE    SYS-2001-SRYYM      TO  ACCT-SRYYM
           MOVE    "1"                 TO  ACCT-NYUGAIKBN
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY29"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY29"     TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           PERFORM UNTIL       FLG-SRYACCT     =   1
               PERFORM 20011-IKKATU-SRYACCT-HENSYU-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY29"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    入院会計読み込み（患者ＩＤ、診療科、剤識別区分順）
      *
           MOVE    "2"                 TO  WRK-DBKBN 
      *
           MOVE    LOW-VALUE           TO  KEY-AREA
      *     
           INITIALIZE                  NYUINACCT-REC
           MOVE    SYS-1001-HOSPID     TO  NACCT-HOSPID
           MOVE    SYS-2001-SRYYM      TO  NACCT-SRYYM
           MOVE    "1"                 TO  NACCT-NYUGAIKBN
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY13"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACCT-KEY13"       TO  ORC-DBPATH
               PERFORM 900-NYUINACCT-READ-SEC
           ELSE
               INITIALIZE                  NYUINACCT-REC
               MOVE    1                   TO  FLG-NYUINACCT
           END-IF
      *
           PERFORM UNTIL       FLG-NYUINACCT   =   1
               PERFORM 20012-IKKATU-NYUINACCT-HENSYU-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY13"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       2001-IKKATU-SYORI-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    一括編集処理
      *****************************************************************
       20011-IKKATU-SRYACCT-HENSYU-SEC              SECTION.
      *
      *    テスト患者のときは読み飛ばす
           MOVE    SYS-1001-HOSPID         TO  PTINF-HOSPID
           MOVE    KEY-N-PTID              TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
      *
           DISPLAY "SRYACCT PTID=" KEY-N-PTID 
                   " TSTPTNUMKBN=" PTINF-TSTPTNUMKBN
      *
           IF      FLG-PTINF           =   ZERO
           AND     PTINF-TSTPTNUMKBN   =   "1"
               MOVE    KEY-NEW             TO  KEY-OLD
               PERFORM         UNTIL   FLG-SRYACCT     =   1 
                               OR      KEY-N-PTID  NOT =   KEY-O-PTID
                   MOVE    "SRYACCT-KEY29"         TO  ORC-DBPATH
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
                   MOVE    SPACE               TO  WRK-ERR-AREA
                   INITIALIZE                      WRK-ERR-AREA
      *
                   IF      FLG-HKNCOMBI    =   ZERO
      *                自賠責保険の対象であるか
                       IF      COMB-HKNNUM  =   WRK-CONS-JIBAI-HKNNUM
      *                    診療月内に摘要日が存在するか
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
                       MOVE    1               TO  WRK-ERR-ERRKBN
                       MOVE    KEY-N-HKNCOMBI  TO  WRK-ERR-HKNCOMBINUM
                   END-IF    
      *             
                   MOVE    KEY-NEW             TO  KEY-OLD
                   PERFORM         UNTIL   FLG-SRYACCT     =   1 
                                   OR      KEY-NEW     NOT =   KEY-OLD
                       IF      WRK-ROUSAIKBN           =   SPACE            
                           PERFORM 200111-SRYACCT-HENSYU-SEC 
                       END-IF    
      *
      *                自賠責保険以外または日付変更がないとき
      *                または既にエラー対象のとき
      *                同じ患者ＩＤ・保険組合せは読み飛ばす
                       IF    ( WRK-ROUSAIKBN   =   "1"   )
                       OR    ( WRK-UPDKBN      =   SPACE )
                       OR    ( WRK-TEISEIKBN   =   "1"   )
                           MOVE    KEY-NEW             TO  KEY-OLD
                           PERFORM     UNTIL   FLG-SRYACCT =   1 
                                       OR      KEY-NEW NOT =   KEY-OLD
                               MOVE    "SRYACCT-KEY29" TO  ORC-DBPATH
                               PERFORM 900-SRYACCT-READ-SEC
                           END-PERFORM
                       ELSE
                           MOVE    "SRYACCT-KEY29"     TO  ORC-DBPATH
                           PERFORM 900-SRYACCT-READ-SEC
                       END-IF
                   END-PERFORM    
               END-PERFORM         
           END-IF    
           .
       20011-IKKATU-SRYACCT-HENSYU-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    ファイル処理
      *****************************************************************
       200111-SRYACCT-HENSYU-SEC              SECTION.
      *
      *    労災保険情報読み込み     
           INITIALIZE              PTRSIINF-REC
           MOVE    COMB-HOSPID     TO  PTRSI-HOSPID
           MOVE    COMB-HKNID      TO  PTRSI-HKNID
           MOVE    COMB-PTID       TO  PTRSI-PTID
           MOVE    PTRSIINF-REC    TO  MCPDATA-REC
           PERFORM 900-PTRSIINF-INV-SEC
           IF      FLG-PTRSIINF    =   1
               MOVE    "1"             TO  WRK-ROUSAIKBN
           END-IF                
      *
      *    労災・自賠責保険以外のとき処理しない
           IF      WRK-ROUSAIKBN       =   "1"
               GO  TO  200111-SRYACCT-HENSYU-EXT
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
                           MOVE    IDX             TO  WRK-ERR-DAY
                           MOVE    2               TO  WRK-ERR-ERRKBN
                           MOVE    KEY-N-HKNCOMBI  TO
                                                   WRK-ERR-HKNCOMBINUM
                           MOVE    COMB-TEKSTYMD   TO  WRK-ERR-TEKSTYMD    
                       END-IF
                   END-PERFORM
               ELSE
                   IF      COMB-TEKSTYMD(1:6)  >   WRK-STYMD (1:6)
                       MOVE    "1"             TO  WRK-TEISEIKBN
                       MOVE    3               TO  WRK-ERR-ERRKBN
                       MOVE    KEY-N-HKNCOMBI  TO
                                               WRK-ERR-HKNCOMBINUM
                       MOVE    COMB-TEKSTYMD   TO  WRK-ERR-TEKSTYMD    
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
                           MOVE    IDX             TO  WRK-ERR-DAY
                           MOVE    4               TO  WRK-ERR-ERRKBN
                           MOVE    KEY-N-HKNCOMBI  TO
                                                   WRK-ERR-HKNCOMBINUM
                           MOVE    COMB-TEKEDYMD   TO  WRK-ERR-TEKEDYMD    
                       END-IF
                   END-PERFORM
               ELSE
                   IF      COMB-TEKEDYMD(1:6)  <   WRK-EDYMD (1:6)
                       MOVE    "1"             TO  WRK-TEISEIKBN
                       MOVE    5               TO  WRK-ERR-ERRKBN
                       MOVE    KEY-N-HKNCOMBI  TO
                                               WRK-ERR-HKNCOMBINUM
                       MOVE    COMB-TEKEDYMD   TO  WRK-ERR-TEKEDYMD    
                   END-IF    
               END-IF    
           END-IF
      *
      *    ファイル編集処理
           PERFORM 20011-FILE-HENSYU-SEC
           .
       200111-SRYACCT-HENSYU-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    入院会計一括編集処理
      *****************************************************************
       20012-IKKATU-NYUINACCT-HENSYU-SEC              SECTION.
      *     
      *    テスト患者のときは読み飛ばす
           MOVE    SYS-1001-HOSPID         TO  PTINF-HOSPID
           MOVE    KEY-N-PTID              TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           =   ZERO
           AND     PTINF-TSTPTNUMKBN   =   "1"
               MOVE    KEY-NEW             TO  KEY-OLD
               PERFORM         UNTIL   FLG-NYUINACCT   =   1 
                               OR      KEY-N-PTID  NOT =   KEY-O-PTID
                   MOVE    "NYUINACCT-KEY13"       TO  ORC-DBPATH
                   PERFORM 900-NYUINACCT-READ-SEC
               END-PERFORM
           ELSE
               MOVE    KEY-NEW             TO  KEY-OLD
               INITIALIZE                      WRK-DAY-AREA
                                               WRK-HKNCOMBI-TABLE
      *
               PERFORM         UNTIL   FLG-NYUINACCT   =   1 
                               OR      KEY-NEW     NOT =   KEY-OLD
      *            剤識別区分別テーブル編集
                   EVALUATE    NACCT-ZAISKBKBN
                       WHEN    "1"
                           MOVE    1               TO  IDX
                       WHEN    "5"
                           MOVE    2               TO  IDX
                   END-EVALUATE
                   PERFORM VARYING IDX1    FROM    1   BY  1
                           UNTIL   IDX1    >       31
                       IF      NACCT-DAY  (IDX1)       >   ZERO
                           MOVE    NACCT-DAY (IDX1)    TO
                                                   WRK-DAY (IDX IDX1)
                       END-IF
                   END-PERFORM            
                   MOVE    "NYUINACCT-KEY13"       TO  ORC-DBPATH
                   PERFORM 900-NYUINACCT-READ-SEC
               END-PERFORM
      *
      *        入院会計より保険組合せ読込     
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       31
                   IF      WRK-DAY (1 IDX)     >   ZERO    AND
                           WRK-DAY (2 IDX)     >   ZERO
                       PERFORM 200121-NYUINACCT-CHK-SEC
                   END-IF
               END-PERFORM        
      *
      *        入院会計の保険組合せを追加
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL   IDX2    >       10
                       OR      WRK-COMB-HKNCOMBINUM (IDX2) =   ZERO
                   IF      WRK-HKNCOMBI-SYOKBN (IDX2)  =   "1"
                       CONTINUE
                   ELSE    
                       MOVE    SPACE               TO  WRK-ERR-AREA
                       INITIALIZE                      WRK-ERR-AREA
      *
                       MOVE    WRK-HKNCOMBI-REC (IDX2)
                                               TO  HKNCOMBI-REC    
                       IF      WRK-HKNCOMBI-SYOKBN (IDX2)  =   "2"
                           MOVE    "1"             TO  WRK-TEISEIKBN
                           IF      WRK-HKNCOMBI-ERR-DAY (IDX2)
                                                   =   ZERO
                               MOVE    1           TO  WRK-ERR-ERRKBN
                           ELSE
                               MOVE    WRK-HKNCOMBI-ERR-DAY (IDX2)
                                                   TO  WRK-ERR-DAY
                               MOVE    6           TO  WRK-ERR-ERRKBN
                           END-IF
                           MOVE    WRK-COMB-HKNCOMBINUM (IDX2)  TO
                                                   WRK-ERR-HKNCOMBINUM
                       END-IF        
      *
                       PERFORM 200122-NYUINACCT-HENSYU-SEC
                   END-IF 
               END-PERFORM
           END-IF    
           .
       20012-IKKATU-NYUINACCT-HENSYU-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    入院会計チェック処理
      *****************************************************************
       200121-NYUINACCT-CHK-SEC           SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       10
      *
      *        保険組合せ追加
               IF      WRK-COMB-HKNCOMBINUM (IDX1) =   ZERO
                   INITIALIZE                  HKNCOMBI-REC
                   MOVE    SYS-1001-HOSPID TO  COMB-HOSPID
                   MOVE    KEY-O-PTID      TO  COMB-PTID
                   MOVE    WRK-DAY (2 IDX) TO
                                           COMB-HKNCOMBINUM 
                   MOVE    HKNCOMBI-REC    TO  MCPDATA-REC
                   PERFORM 910-HKNCOMBI-INV-SEC
      *            （対象外の組合せは１をセット）
                   IF      FLG-HKNCOMBI    =   ZERO
                       MOVE    HKNCOMBI-REC    TO
                                           WRK-HKNCOMBI-REC  (IDX1)
                       IF      COMB-HKNNUM NOT =
                                           WRK-CONS-JIBAI-HKNNUM
                           MOVE    "1"         TO
                                           WRK-HKNCOMBI-SYOKBN (IDX1)
                       END-IF
                   ELSE
                       MOVE    WRK-DAY (2 IDX) TO
                                           WRK-COMB-HKNCOMBINUM (IDX1)
                       MOVE    "2"     TO  WRK-HKNCOMBI-SYOKBN  (IDX1)
                   END-IF
               END-IF
      *
      *        適用範囲かチェック（範囲外のとき２をセット）
               IF      WRK-DAY (2 IDX)     =
                                       WRK-COMB-HKNCOMBINUM (IDX1)
                   IF      WRK-HKNCOMBI-SYOKBN (IDX1)   NOT =   SPACE
                       CONTINUE                    
                   ELSE     
                       MOVE    WRK-STYMD       TO  WRK-YMD
                       MOVE    IDX             TO  WRK-DD
                       IF      WRK-COMB-TEKSTYMD (IDX1)
                                               <=  WRK-YMD
                       AND     WRK-COMB-TEKEDYMD (IDX1)
                                               >=  WRK-YMD
                           CONTINUE
                       ELSE   
                           MOVE    "2"         TO
                                           WRK-HKNCOMBI-SYOKBN  (IDX1)
                           MOVE    IDX         TO
                                           WRK-HKNCOMBI-ERR-DAY (IDX1)
                       END-IF
                   END-IF
                   MOVE    10              TO  IDX1
               END-IF            
           END-PERFORM
           .
       200121-NYUINACCT-CHK-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    入院会計ファイル処理
      *****************************************************************
       200122-NYUINACCT-HENSYU-SEC           SECTION.
      *
           MOVE    WRK-HKNCOMBI-REC  (IDX2)  TO  HKNCOMBI-REC
      *    労災保険情報読み込み     
           INITIALIZE              PTRSIINF-REC
           MOVE    COMB-HOSPID     TO  PTRSI-HOSPID
           MOVE    COMB-HKNID      TO  PTRSI-HKNID
           MOVE    COMB-PTID       TO  PTRSI-PTID
           MOVE    PTRSIINF-REC    TO  MCPDATA-REC
           PERFORM 900-PTRSIINF-INV-SEC
      *
           PERFORM 20011-FILE-HENSYU-SEC
           .
        200122-NYUINACCT-HENSYU-EXT.
           EXIT. 
           .
      *            
      *****************************************************************
      *    編集処理
      *****************************************************************
       20011-FILE-HENSYU-SEC              SECTION.
      *     
           INITIALIZE                      WRK-RECE82-REC
           MOVE    SYS-1001-HOSPID     TO  WRK-RECE82-HOSPID
           IF      WRK-PARA-SYOKBN     =   "1"
               MOVE    SYS-2001-SRYYM      TO  WRK-RECE82-SRYYM
           ELSE
               MOVE    SYS-2002-SRYYM      TO  WRK-RECE82-SRYYM
           END-IF
           MOVE    "1"                 TO  WRK-RECE82-NYUGAIKBN
           MOVE    COMB-PTID           TO  WRK-RECE82-PTID
           MOVE    COMB-HKNID          TO  WRK-RECE82-HKNID
           MOVE    COMB-TEKSTYMD       TO  WRK-RECE82-TEKSTYMD
           MOVE    WRK-RECE82-KEY      TO  RECE82-KEY 
           PERFORM 900-RECE82-READ-SEC
           IF      FLG-RECE82          =   ZERO
               MOVE    RECE82-REC          TO  WRK-RECE82-REC 
               PERFORM 200111-RECE82-REWRITE-SEC
           ELSE
               PERFORM 200112-RECE82-WRITE-SEC
           END-IF
      *   
           .
       20011-FILE-HENSYU-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    出力処理
      *****************************************************************
       200112-RECE82-WRITE-SEC              SECTION.
      *
      *    保険組合せ番号情報
           MOVE    COMB-HKNCOMBINUM   TO  WRK-RECE82-HKNCOMBI
      *
      *    診療科情報（診療会計のとき）
           IF      WRK-DBKBN          =   "2"
               CONTINUE
           ELSE              
               MOVE    ACCT-SRYKA         TO  WRK-RECE82-SRYKA (1)
           END-IF
           IF      WRK-DBKBN          =   "2"
      ***      MOVE    WRK-DAY-TBL (2)    TO  WRK-RECE82-DAY-AREA
               PERFORM   VARYING   IDX3    FROM    1   BY  1
                           UNTIL   IDX3    >      31
                 IF      WRK-DAY (1 IDX3)     >   ZERO    AND
                         WRK-DAY (2 IDX3)     >   ZERO
                    MOVE   WRK-DAY(2 IDX3)  TO  WRK-RECE82-DAY(IDX3)
                 END-IF
               END-PERFORM
           END-IF
      *
      *    患者番号取得
           INITIALIZE                      ORCSPTIDAREA
           MOVE    WRK-RECE82-HOSPID   TO  SPTID-HOSPID
           MOVE    WRK-RECE82-PTID     TO  SPTID-PTID
           CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                               SPA-1009-TBL
           MOVE    SPTID-PTNUM         TO  WRK-RECE82-PTNUM
      *
      *    患者情報
           MOVE   PTINF-KANANAME       TO  WRK-RECE82-KANANAME
           MOVE   PTINF-NAME           TO  WRK-RECE82-NAME
           MOVE   PTINF-SEX            TO  WRK-RECE82-SEX
           MOVE   PTINF-BIRTHDAY       TO  WRK-RECE82-BIRTHDAY
      *
      *    患者年齢計算
           INITIALIZE                  ORCSAGECHKAREA
           MOVE    WRK-RECE82-HOSPID   TO  AGECHK-HOSPID
           MOVE    WRK-RECE82-PTID     TO  AGECHK-PTID
           MOVE    WRK-RECE82-SRYYM    TO  AGECHK-SRYYMD(1:6)
           MOVE    "01"                TO  AGECHK-SRYYMD(7:2)
           MOVE    PTINF-BIRTHDAY      TO  AGECHK-BIRTHDAY
           CALL    "ORCSAGECHK"            USING
                                           ORCSAGECHKAREA
           IF      AGECHK-RC           =   ZERO
               MOVE  AGECHK-NENREI         TO  WRK-RECE82-AGE
           END-IF
      *
      *    患者情報（旧姓履歴の取得）
           INITIALIZE                      KYUSEIRRK-REC
           MOVE    WRK-RECE82-HOSPID   TO  KYUSEI-HOSPID
           MOVE    WRK-RECE82-PTID     TO  KYUSEI-PTID
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY7-AREA
           MOVE    "71"                TO  LNK-DAY7-IRAI
           MOVE    WRK-RECE82-SRYYM    TO  LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  KYUSEI-CHGYMD
           MOVE    KYUSEIRRK-REC       TO  MCPDATA-REC
           PERFORM 900-KYUSEIRRK-READ-SEC
           IF       FLG-KYUSEIRRK      =   ZERO
               MOVE    KYUSEI-NAME         TO  WRK-RECE82-NAME
               MOVE    KYUSEI-KANANAME     TO  WRK-RECE82-KANANAME
           END-IF         
      *          
      *    患者労災保険情報
           MOVE   PTRSI-HKNKBN         TO  WRK-RECE82-HKNKBN
           MOVE   PTRSI-HKNNUM         TO  WRK-RECE82-HKNNUM
           MOVE   PTRSI-KOFUNUM        TO  WRK-RECE82-KOFUNUM
           MOVE   PTRSI-JIGYOUNAME     TO  WRK-RECE82-JIGYOUNAME
           MOVE   PTRSI-PREFNAME       TO  WRK-RECE82-PREFNAME
           MOVE   PTRSI-PREFKBN        TO  WRK-RECE82-PREFKBN  
           MOVE   PTRSI-CITYNAME       TO  WRK-RECE82-CITYNAME
           MOVE   PTRSI-CITYKBN        TO  WRK-RECE82-CITYKBN
      *
           MOVE   PTRSI-SINKEI         TO  WRK-RECE82-SINKEI
           EVALUATE    PTRSI-HKNKBN 
               WHEN    "1"  
                   IF    ( PTRSI-SINKEI        =   "1" OR  "3" OR
                                                   "7"              )
                   AND   ( PTRSI-RYOSTYMD(1:6) <   WRK-RECE82-SRYYM )
                       MOVE    "5"         TO  WRK-RECE82-SINKEI
                   END-IF
               WHEN    "2"  
                   IF    ( PTRSI-SINKEI        =   "1" OR  "7"      )
                   AND   ( PTRSI-RYOSTYMD(1:6) <   WRK-RECE82-SRYYM )
                       MOVE   "5"          TO  WRK-RECE82-SINKEI
                   END-IF
           END-EVALUATE
      *
           MOVE   PTRSI-TENKI          TO  WRK-RECE82-TENKI
           MOVE   PTRSI-SHOBYOYMD      TO  WRK-RECE82-SHOBYOYMD
           MOVE   PTRSI-SISIKBN        TO  WRK-RECE82-SISIKBN
      **>  MOVE   PTRSI-RYOSTYMD       TO  WRK-RECE82-RYOSTYMD
           MOVE   SPACE                TO  WRK-RECE82-RYOSTYMD
      **>  MOVE   PTRSI-RYOEDYMD       TO  WRK-RECE82-RYOEDYMD
           MOVE   SPACE                TO  WRK-RECE82-RYOEDYMD
           MOVE   PTRSI-COMMENT        TO  WRK-RECE82-COMMENT
           MOVE   PTRSI-SAIGAIKBN      TO  WRK-RECE82-SAIGAIKBN 
           MOVE   PTRSI-RYOSTYMD       TO  WRK-RECE82-SHOSHINYMD
      *
      *    自賠責加算率
           MOVE    WRK-KSNRATE         TO  WRK-RECE82-KSNRATE
      *
      *    病院・診療所区分
           MOVE    SYS-1001-HOSPSBT    TO  WRK-RECE82-HOSPSBT
      *
           IF      WRK-TEISEIKBN      =   "1"
               MOVE    WRK-ERR-ERRKBN     TO  WRK-RECE82-ERR-ERRKBN
               MOVE    WRK-ERR-DAY        TO  WRK-RECE82-ERR-DAY
               MOVE    WRK-ERR-HKNCOMBINUM 
                                          TO  WRK-RECE82-ERR-HKNCOMBINUM
               MOVE    WRK-ERR-TEKSTYMD   TO  WRK-RECE82-ERR-TEKSTYMD
               MOVE    WRK-ERR-TEKEDYMD   TO  WRK-RECE82-ERR-TEKEDYMD
           END-IF 
      *
           MOVE    WRK-RECE82-REC      TO  RECE82-REC
           WRITE   RECE82-REC
           ADD     1                   TO  CNT-OUT
           .
       200112-RECE82-WRITE-EXT.
           EXIT.
      *            
      *****************************************************************
      *    出力処理
      *****************************************************************
       200111-RECE82-REWRITE-SEC            SECTION.
      *
           IF      WRK-DBKBN          =   "2"
               CONTINUE
           ELSE              
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       20
                   IF      WRK-RECE82-SRYKA    (IDX)       =   SPACE
                       MOVE    ACCT-SRYKA      TO  WRK-RECE82-SRYKA(IDX)
                       MOVE    20              TO  IDX
                   ELSE
                       IF      WRK-RECE82-SRYKA    (IDX)   
                                                   =   ACCT-SRYKA
                           MOVE    20                  TO  IDX
                       END-IF
                   END-IF    
               END-PERFORM
           END-IF
      *
           IF      WRK-DBKBN          =   "2"
      ***      MOVE    WRK-DAY-TBL (2)    TO  WRK-RECE82-DAY-AREA
               PERFORM   VARYING   IDX3    FROM    1   BY  1
                           UNTIL   IDX3    >      31
                 IF      WRK-DAY (1 IDX3)     >   ZERO    AND
                         WRK-DAY (2 IDX3)     >   ZERO
                    MOVE   WRK-DAY(2 IDX3)  TO  WRK-RECE82-DAY(IDX3)
                 END-IF
               END-PERFORM
           END-IF
      *
           IF      WRK-TEISEIKBN           =   "1"
           AND     WRK-RECE82-ERR-ERRKBN   =   SPACE
               MOVE    WRK-ERR-ERRKBN      TO  WRK-RECE82-ERR-ERRKBN
               MOVE    WRK-ERR-DAY         TO  WRK-RECE82-ERR-DAY
               MOVE    WRK-ERR-HKNCOMBINUM TO 
                                           WRK-RECE82-ERR-HKNCOMBINUM
               MOVE    WRK-ERR-TEKSTYMD    TO  WRK-RECE82-ERR-TEKSTYMD
               MOVE    WRK-ERR-TEKEDYMD    TO  WRK-RECE82-ERR-TEKEDYMD
           END-IF          
      *
           MOVE    WRK-RECE82-REC      TO  RECE82-REC
           REWRITE RECE82-REC
           .
       200111-RECE82-REWRITE-EXT.
           EXIT.
      * 
      *****************************************************************
      *    個別処理
      *****************************************************************
       2002-KOBETU-SYORI-SEC               SECTION.
      *
      *    レセプト管理削除処理（個別分）
           INITIALIZE                  RECE07-REC
           MOVE    "HC23"              TO  RECE07-PRTID
           MOVE    "1"                 TO  RECE07-NYUGAIKBN
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
           MOVE    "HC23"              TO  RECE08-PRTID
           MOVE    "1"                 TO  RECE08-NYUGAIKBN
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
           .
      *
       2002-KOBETU-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    個別編集処理
      *****************************************************************
       20021-KOBETU-HENSYU-SEC              SECTION.
      *
           MOVE    MCPDATA-REC         TO  SYS-2002-REC
      *
           DISPLAY "SYS PTID=" SYS-2002-PTID 
      *
      *    医療機関ＩＤ編集
           MOVE  ZERO           TO  FLG-SET
           MOVE  SYS-2002-SRYYM TO  WRK-SYS-SRYYMD(1:6)
           MOVE  "01"           TO  WRK-SYS-SRYYMD(7:2)
           PERFORM  VARYING  SYSKAN-IDX  FROM  1  BY  1
                    UNTIL  ( SYSKAN-IDX              >  10   )
                     OR    ( TBL-SYS1001(SYSKAN-IDX) = SPACE )
                     OR    ( FLG-SET                 =   1   )
      *
                MOVE  TBL-SYS1001(SYSKAN-IDX)  TO  SYS-1001-REC
                IF   ( SYS-1001-STYUKYMD  <=  WRK-SYS-SRYYMD    )
                AND  ( WRK-SYS-SRYYMD     <=  SYS-1001-EDYUKYMD )
                    MOVE     1       TO    FLG-SET
                END-IF
      *
           END-PERFORM
           IF     FLG-SET  =  ZERO
               STRING   "医療機関情報が取得できませんでした。診療年月＝"
                                           DELIMITED  BY  SIZE 
                        SYS-2002-SRYYM     DELIMITED  BY  SIZE
                                       INTO    WRK-RECEERR
               END-STRING
               PERFORM 500-ERR-HENSYU-SEC
               GO       TO      20021-KOBETU-HENSYU-EXT
           END-IF
      *
      *    システム管理マスタ（４００１）から点数単価の取得
           MOVE  ZERO           TO  FLG-SET
           MOVE  SYS-2002-SRYYM TO  WRK-SYS-SRYYMD(1:6)
           MOVE  "01"           TO  WRK-SYS-SRYYMD(7:2)
           PERFORM  VARYING  SYSKAN-IDX  FROM  1  BY  1
                    UNTIL  ( SYSKAN-IDX              >  10   )
                     OR    ( TBL-SYS4001(SYSKAN-IDX) = SPACE )
                     OR    ( FLG-SET                 =   1   )
      *
                MOVE  TBL-SYS4001(SYSKAN-IDX)  TO  SYS-4001-REC
                IF   ( SYS-4001-STYUKYMD  <=  WRK-SYS-SRYYMD    )
                AND  ( WRK-SYS-SRYYMD     <=  SYS-4001-EDYUKYMD )
                    MOVE     1       TO    FLG-SET
                    IF      SYS-4001-KSNRATE(1:2)  =  SPACE
                       MOVE   100           TO    WRK-KSNRATE
                    ELSE
                       COMPUTE WRK-KSNRATE  =  SYS-4001-KSNRATE
                                            +  100
                    END-IF
                END-IF
      *
           END-PERFORM
           IF     FLG-SET  =  ZERO
               STRING
               "労災自賠医療機関情報が取得できませんでした。診療年月＝"
                                           DELIMITED  BY  SIZE 
                        SYS-2002-SRYYM     DELIMITED  BY  SIZE
                                       INTO    WRK-RECEERR
               END-STRING
               PERFORM 500-ERR-HENSYU-SEC
               GO       TO      20021-KOBETU-HENSYU-EXT
           END-IF
      *
      *    患者情報取得
           MOVE    SYS-1001-HOSPID     TO  PTINF-HOSPID
           MOVE    SYS-2002-PTID       TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
      *
      *    診療年月編集
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
           MOVE    "1"                 TO  WRK-DBKBN 
      *      
           INITIALIZE                  SRYACCT-REC
           MOVE    SYS-1001-HOSPID     TO  ACCT-HOSPID
           MOVE    SYS-2002-PTID       TO  ACCT-PTID
           MOVE    SYS-2002-SRYYM      TO  ACCT-SRYYM
           MOVE    SYS-2002-NYUGAIKBN  TO  ACCT-NYUGAIKBN
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY30"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY30"     TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           PERFORM UNTIL       FLG-SRYACCT     =   1
               PERFORM 200211-KOBETU-SRYACCT-HENSYU-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY30"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *        入院会計読み込み
           MOVE    "2"                 TO  WRK-DBKBN 
      *      
      *
           MOVE    LOW-VALUE           TO  KEY-AREA
      *     
           INITIALIZE                  NYUINACCT-REC
           MOVE    SYS-1001-HOSPID     TO  NACCT-HOSPID
           MOVE    SYS-2002-PTID       TO  NACCT-PTID
           MOVE    SYS-2002-SRYYM      TO  NACCT-SRYYM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
               PERFORM 900-NYUINACCT-READ-SEC
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1                   TO  FLG-NYUINACCT
           END-IF
      *
           PERFORM UNTIL       FLG-NYUINACCT     =   1
               PERFORM 200212-KOBETU-NYUINACCT-HENSYU-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *    
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           PERFORM 900-SYSKANRI-READ-SEC
           .
       20021-KOBETU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ出力処理
      *****************************************************************
       200211-KOBETU-SRYACCT-HENSYU-SEC                SECTION.
      *
           MOVE    KEY-NEW             TO  KEY-OLD
           PERFORM             UNTIL   FLG-SRYACCT     =   1 
      *****    MOVE    ACCT-HKNCOMBI       TO  KEY-N-HKNCOMBI
      *****    MOVE    ACCT-PTID           TO  KEY-N-PTID 
      *        保険組合せ読込み
               INITIALIZE                  HKNCOMBI-REC
               MOVE    SYS-1001-HOSPID     TO  COMB-HOSPID
               MOVE    ACCT-PTID           TO  COMB-PTID
               MOVE    ACCT-HKNCOMBI       TO  COMB-HKNCOMBINUM 
               MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
               PERFORM  910-HKNCOMBI-INV-SEC
      *
      *        未訂正分があるか
               MOVE    SPACE               TO  WRK-ERR-AREA
               INITIALIZE                      WRK-ERR-AREA
      *
               IF      FLG-HKNCOMBI    =   ZERO
                   IF      COMB-HKNNUM  =   WRK-CONS-JIBAI-HKNNUM
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
                   MOVE    1                   TO  WRK-ERR-ERRKBN
                   MOVE    ACCT-HKNCOMBI       TO  WRK-ERR-HKNCOMBINUM
               END-IF    
      *
               MOVE    KEY-NEW             TO  KEY-OLD
               PERFORM         UNTIL   FLG-SRYACCT     =   1
                               OR      KEY-NEW     NOT =   KEY-OLD
                   IF      WRK-ROUSAIKBN           =   SPACE            
                       PERFORM 200111-SRYACCT-HENSYU-SEC
                   END-IF    
      *
                   IF    ( WRK-ROUSAIKBN     =   "1"   )  
                   OR    ( WRK-UPDKBN        =   SPACE )         
                       MOVE    KEY-NEW             TO  KEY-OLD
                       PERFORM     UNTIL   FLG-SRYACCT     =   1 
                                   OR      KEY-NEW     NOT =   KEY-OLD
                           MOVE    "SRYACCT-KEY30"     TO  ORC-DBPATH
                           PERFORM 900-SRYACCT-READ-SEC
                        END-PERFORM
                   ELSE
                       MOVE    "SRYACCT-KEY30"     TO  ORC-DBPATH
                       PERFORM 900-SRYACCT-READ-SEC
                   END-IF
               END-PERFORM    
           END-PERFORM         
      *
           .
       200211-KOBETU-SRYACCT-HENSYU-EXT.
           EXIT.
      *            
      *****************************************************************
      *    入院会計個別編集処理
      *****************************************************************
       200212-KOBETU-NYUINACCT-HENSYU-SEC              SECTION.
      *     
           MOVE    KEY-NEW             TO  KEY-OLD
           INITIALIZE                      WRK-DAY-AREA
                                           WRK-HKNCOMBI-TABLE
      *
           PERFORM         UNTIL   FLG-NYUINACCT   =   1 
                           OR      KEY-NEW     NOT =   KEY-OLD
      *        剤識別区分別テーブル編集
               EVALUATE    NACCT-ZAISKBKBN
                   WHEN    "1"
                       MOVE    1               TO  IDX
                   WHEN    "5"
                       MOVE    2               TO  IDX
               END-EVALUATE
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL   IDX1  >        31
                   IF      NACCT-DAY  (IDX1)       >   ZERO
                       MOVE    NACCT-DAY (IDX1)    TO
                                               WRK-DAY (IDX IDX1)
                   END-IF
               END-PERFORM            
               MOVE    "NYUINACCT-KEY14"       TO  ORC-DBPATH
               PERFORM 900-NYUINACCT-READ-SEC
           END-PERFORM
      *
      *    入院会計より保険組合せ読込     
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       31
               IF      WRK-DAY (1 IDX)     >   ZERO    AND
                       WRK-DAY (2 IDX)     >   ZERO
                   PERFORM 200121-NYUINACCT-CHK-SEC
               END-IF
           END-PERFORM        
      *
      *    入院会計の保険組合せを追加
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL   IDX2    >       10
                   OR      WRK-COMB-HKNCOMBINUM (IDX2) =   ZERO
               IF      WRK-HKNCOMBI-SYOKBN (IDX2)  =   "1"
                   CONTINUE
               ELSE    
                   MOVE    SPACE               TO  WRK-ERR-AREA
                   INITIALIZE                      WRK-ERR-AREA
                   MOVE    WRK-HKNCOMBI-REC (IDX2)
                                           TO  HKNCOMBI-REC    
                   IF      WRK-HKNCOMBI-SYOKBN (IDX2)  =   "2"
                       MOVE    "1"         TO  WRK-TEISEIKBN
                       IF      WRK-HKNCOMBI-ERR-DAY (IDX2)
                                                   =   ZERO
                           MOVE    1           TO  WRK-ERR-ERRKBN
                       ELSE
                           MOVE    WRK-HKNCOMBI-ERR-DAY (IDX2)
                                               TO  WRK-ERR-DAY
                           MOVE    6           TO  WRK-ERR-ERRKBN
                       END-IF
                       MOVE    WRK-COMB-HKNCOMBINUM (IDX2)  TO
                                               WRK-ERR-HKNCOMBINUM
                   END-IF        
                   PERFORM 200122-NYUINACCT-HENSYU-SEC
               END-IF 
           END-PERFORM
           .
       200212-KOBETU-NYUINACCT-HENSYU-EXT.
           EXIT. 
      *
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
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   RECE82-FILE
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
           DISPLAY "RECE82  CNT " CNT-OUT 
           DISPLAY "*** ORCR0815 END ***"
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
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
           .
       910-SYSKANRI-INV-EXT.
           EXIT.
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
               MOVE    ACCT-PTID           TO  KEY-N-PTID 
               MOVE    ACCT-HKNCOMBI       TO  KEY-N-HKNCOMBI
           ELSE
               MOVE    1               TO  FLG-SRYACCT
           END-IF
           .
       900-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスタ　ＲＥＡＤ
      *****************************************************************
       900-NYUINACCT-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-NYUINACCT
               MOVE    MCPDATA-REC         TO  NYUINACCT-REC
               MOVE    NACCT-PTID          TO  KEY-N-PTID 
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
           .
       900-NYUINACCT-READ-EXT.
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
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
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
           MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
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
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
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
           MOVE    WRK-DBPATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    WRK-DBPATH            TO  ORC-DBPATH
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
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
           .
       900-RECE07-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    旧姓履歴マスタ読み込み
      *****************************************************************
       900-KYUSEIRRK-READ-SEC          SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "KYUSEIRRK-KEY3"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "KYUSEIRRK-KEY3"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  KYUSEIRRK-REC
                   MOVE    ZERO                TO  FLG-KYUSEIRRK
               ELSE
                   MOVE    1                   TO  FLG-KYUSEIRRK
               END-IF
           ELSE
               MOVE    1               TO  FLG-KYUSEIRRK
           END-IF
      *
           MOVE    "KYUSEIRRK-KEY3"    TO  WRK-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
           .
       900-KYUSEIRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソルクローズ処理
      *****************************************************************
       900-DBCLOSE-SEC                 SECTION.
      *
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    中間ファイルＲＥＡＤ処理
      *****************************************************************
       900-RECE82-READ-SEC            SECTION.
      *
           READ    RECE82-FILE
               INVALID
                   MOVE    1           TO    FLG-RECE82
               NOT  INVALID
                   MOVE    ZERO        TO  FLG-RECE82
           END-READ
           .
       900-RECE82-READ-EXT.
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
       900-DBDISCONNECT-EXT.
           EXIT.
