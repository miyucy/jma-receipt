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
      *
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCGR98.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト
      *  コンポーネント名  : レセプト作成-生活保護まとめ入力（Ｒ９８）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *                                     修正
      *　入院機能追加　
      *  01.00.01    NACL-藤原    02/12/11  入外区分追加 
      *  01.00.02    NACL-藤原    03/01/14  入院会計の読込追加
      *                                     入外区分の表示追加 
      *  01.00.03   NACL-藤原     03.01.20  月代り受給者番号に入外区分を追加
      *  01.00.04   NACL-藤原     03.07.07  公費の開始日が末日でも対象と
      *                                     なるように修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    レセプト作成指示共通パラメタ
           COPY    "R01COMMON-SPA".
      *
      *   
           COPY    "ENUM-VALUE".
      *
      *    画面用ＳＰＡ
       01  SPA-R98.
           03  SPA-R98-AREA.
               05  SPA-GMN-MAX                     PIC 9(04).
               05  SPA-GMN-PAGE                    PIC 9(02).
               05  SPA-GMN-MAX-PAGE                PIC 9(02). 
               05  SPA-GMN-CUR                     PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SRYYMH              PIC X(26).
                   07  SPA-GMN-SRYYM               PIC X(06).
                   07  SPA-GMN-TABLE.
                       09  SPA-GMN-TBL             OCCURS   40.
                           11  SPA-GMN-TBL-G       OCCURS   25.
                               13  SPA-GMN-TPTNUM  PIC X(20).
                               13  SPA-GMN-TNAME   PIC X(30).
                               13  SPA-GMN-TFTNJANUM
                                                   PIC X(08).
                               13  SPA-GMN-TJKYSNUM
                                                   PIC X(20).
      *
               05  SPA-NAI-AREA.
                   07  SPA-NAI-SRYYM               PIC 9(06).
                   07  SPA-NAI-TABLE.
                       09  SPA-NAI-TBL             OCCURS  40.
                           11  SPA-NAI-TBL-G       OCCURS  25.
                               13  SPA-NAI-TPTID   PIC 9(10).
                               13  SPA-NAI-TSRYYM  PIC 9(06).
      *        入力項目名
               05  SPA-MCP-WIDGET                  PIC X(64).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01). 
           03  FLG-PTKOHINF        PIC 9(01).
           03  FLG-MONTHLYNUM      PIC 9(01).
           03  FLG-NYUINACCT       PIC 9(01).
      *     
           03  FLG-CHK             PIC 9(01).
           03  FLG-SEIHO           PIC 9(01). 
           03  FLG-TOUROKU         PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
           03  IDX1                PIC 9(04). 
           03  IDX2                PIC 9(04).     
      *
       01  KEY-AREA                            VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-PTID      PIC 9(10).
               05  KEY-N-HKNCOMBI  PIC 9(04).
           03  KEY-OLD.
               05  KEY-O-PTID      PIC 9(10).
               05  KEY-O-HKNCOMBI  PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PATH            PIC X(64).
           03  WRK-KOH-IDX         PIC 9(01).
           03  WRK-CUR-IDX         PIC 9(02).
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-RIDMSG          PIC X(70).
           03  WRK-YM              PIC X(07). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-HENYMDG1        PIC X(09).
           03  WRK-HENYMDG3        PIC X(22).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
           03  WRK-HENTIME.
               05  WRK-HH          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-MM          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-SS          PIC X(02).
      *
       01  WRK-CONS-AREA.
      *    
           03  WRK-LINE-MAX        PIC 9(02)   VALUE   25.
           03  WRK-PAGE-MAX        PIC 9(02)   VALUE   40. 
      *    生活保護保険番号 
           03  WRK-CONS-SEIHO-HKNNUM
                                   PIC X(03)   VALUE   "012". 
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "RECEPT1".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    患者公費情報
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    月代わり受給者番号
       01  MONTHLYNUM-REC.
           COPY    "CPMONTHLYNUM.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   チェックデジット
           COPY    "CPORCCHKDGT.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *     
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "R01.INC".
           COPY    "R02.INC".
           COPY    "R03.INC".
           COPY    "R04.INC".
           COPY    "R98.INC".
           COPY    "R99.INC".
           COPY    "RERR.INC".
           COPY    "RID1.INC".
           COPY    "RID2.INC".
           COPY    "RID3.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-R98
           MOVE    SPA-WORK        TO  SPA-R01KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-R01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-R98         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "RERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "R98    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           EVALUATE    SPA-MOTOPG
      *    作表処理
               WHEN    "RID1"
                   PERFORM 330-RID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE              SPA-R98-AREA
      *
      *    対象診療年月
           IF      SPA-SYSYMD(7:2)     >   "10"
               MOVE    SPA-SYSYMD(1:6)     TO  SPA-NAI-SRYYM
           ELSE
               INITIALIZE                     STS-AREA-DAY
               INITIALIZE                     LNK-DAY6-AREA
               MOVE  "61"                     TO  LNK-DAY6-IRAI
               MOVE  SPA-SYSYMD               TO  LNK-DAY6-KIJUN
               MOVE  "2"                      TO  LNK-DAY6-ZOGENPTN
               MOVE  -1                       TO  LNK-DAY6-ZOGEN
               CALL  "ORCSDAY"                USING   STS-AREA-DAY
                                              LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN(1:6)   TO  SPA-NAI-SRYYM
           END-IF
      *
           PERFORM 3101-SEH-HENSYU-SEC     
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    該当診療月の生保の患者情報編集処理
      *****************************************************************
       3101-SEH-HENSYU-SEC         SECTION.
      *
           MOVE    ZERO            TO  IDX1
                                       IDX2
      *
           INITIALIZE                  SPA-GMN-TABLE
                                       SPA-NAI-TABLE
                                       SPA-GMN-CUR
                                       SPA-GMN-MAX                                
      *
      *    対象診療年月
           MOVE    SPA-NAI-SRYYM   TO  WRK-SYMD (1:6)
           MOVE    "01"            TO  WRK-SYMD (7:2)  
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG3 (1:16)
                                   TO  SPA-GMN-SRYYMH (1:16)
           MOVE    "分"            TO  SPA-GMN-SRYYMH (17:2)
           MOVE    WRK-HENYMDG1 (1:6)
                                   TO  SPA-GMN-SRYYM
      *    入外区分
           EVALUATE    SPA-R01-NYUGAIKBN
               WHEN    "1"
                   MOVE    "入院"      TO  SPA-GMN-SRYYMH (21:)
               WHEN    "2"
                   MOVE    "入院外"    TO  SPA-GMN-SRYYMH (21:)
           END-EVALUATE
      *
      *    診療年月に生保が有効な患者
           INITIALIZE                  PTKOHINF-REC                            
           MOVE    SPA-HOSPID      TO  PTKOH-HOSPID
           MOVE    WRK-CONS-SEIHO-HKNNUM
                                   TO  PTKOH-KOHNUM
           MOVE    SPA-NAI-SRYYM   TO  PTKOH-TEKEDYMD (1:6)
           MOVE    "01"            TO  PTKOH-TEKEDYMD (7:2)
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY6-AREA
           MOVE    "61"            TO  LNK-DAY6-IRAI
           MOVE    PTKOH-TEKEDYMD  TO  LNK-DAY6-KIJUN
           MOVE    "2"             TO  LNK-DAY6-ZOGENPTN
           MOVE    1               TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN TO  PTKOH-TEKSTYMD                        
           MOVE    PTKOHINF-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY5" TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC           =   ZERO
               MOVE    "PTKOHINF-KEY5"  TO  WRK-PATH
               PERFORM 910-PTKOHINF-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-PTKOHINF
           END-IF
      *
      *    今月に生保対象の診療行為があるか
           PERFORM UNTIL       FLG-PTKOHINF    =   1
      *        診療会計読み込み（患者ＩＤ、保険組合せ、診療科順）
               INITIALIZE                  SRYACCT-REC
               MOVE    SPA-HOSPID      TO  ACCT-HOSPID
               MOVE    SPA-NAI-SRYYM   TO  ACCT-SRYYM
               MOVE    PTKOH-PTID      TO  ACCT-PTID
      *********MOVE    "2"             TO  ACCT-NYUGAIKBN
               MOVE    SPA-R01-NYUGAIKBN
                                       TO  ACCT-NYUGAIKBN
               MOVE    SRYACCT-REC     TO  MCPDATA-REC
               MOVE    "DBSELECT"      TO  MCP-FUNC
               MOVE    "SRYACCT-KEY9"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          =   ZERO
                   MOVE    "SRYACCT-KEY9"  TO  ORC-DBPATH
                   PERFORM 900-SRYACCT-NEXT-SEC
               ELSE
                   INITIALIZE              SRYACCT-REC
                   MOVE    1               TO  FLG-SRYACCT
               END-IF
      *
               MOVE    ZERO                TO  FLG-SEIHO
      *        診療会計より検索
               PERFORM UNTIL       FLG-SRYACCT     =   1
                   MOVE    ZERO                TO  FLG-SEIHO       
      *            保険組合せ読込み
                   INITIALIZE                  HKNCOMBI-REC
                   MOVE    SPA-HOSPID          TO  COMB-HOSPID
                   MOVE    PTKOH-PTID          TO  COMB-PTID
                   MOVE    KEY-N-HKNCOMBI      TO  COMB-HKNCOMBINUM 
                   MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
                   PERFORM 910-HKNCOMBI-READ-SEC
                   IF      FLG-HKNCOMBI        =   ZERO
                       PERFORM VARYING IDX     FROM    1   BY  1
                               UNTIL   IDX     >       4
                               OR      COMB-KOHHKNNUM (IDX)
                                                   =   SPACE
                               OR      FLG-SEIHO   =   1                       
                           IF      COMB-KOHHKNNUM (IDX)    =
                                               WRK-CONS-SEIHO-HKNNUM
                               MOVE    1               TO  FLG-SEIHO
                               MOVE    IDX             TO  WRK-KOH-IDX
                           END-IF
                       END-PERFORM
                   END-IF    
      *
                   IF      FLG-SEIHO           =   1
                       PERFORM 31011-SEH-GMN-HENSYU-SEC
                   END-IF      
      *             
                   IF      FLG-SEIHO           =   1
                       MOVE    1                   TO  FLG-SRYACCT 
                   ELSE
                       MOVE    KEY-NEW             TO  KEY-OLD
                       PERFORM     UNTIL   FLG-SRYACCT     =   1 
                                   OR      KEY-NEW     NOT =   KEY-OLD            
                           MOVE    "SRYACCT-KEY9"  TO  ORC-DBPATH
                           PERFORM 900-SRYACCT-NEXT-SEC
                       END-PERFORM    
                   END-IF         
               END-PERFORM
      *        カーソルクロース
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
      *        入院会計読み込み（基本）
               IF      SPA-R01-NYUGAIKBN    =   "1"
               AND     FLG-SEIHO            =   ZERO
                   INITIALIZE                  NYUINACCT-REC
                   MOVE    SPA-HOSPID          TO  NACCT-HOSPID
                   MOVE    PTKOH-PTID          TO  NACCT-PTID
                   MOVE    SPA-NAI-SRYYM       TO  NACCT-SRYYM
                   MOVE    NYUINACCT-REC       TO  MCPDATA-REC
                   MOVE    "DBSELECT"          TO  MCP-FUNC
                   MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                   IF      MCP-RC              =   ZERO
                       MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
                       PERFORM  900-NYUINACCT-READ-SEC
                   ELSE
                       MOVE    1                   TO  FLG-NYUINACCT    
                   END-IF
      *            カーソルクロース
                   MOVE    "DBCLOSE"           TO  MCP-FUNC
                   MOVE    "NYUINACCT-KEY14"   TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
                   IF      FLG-NYUINACCT       =   ZERO
                       MOVE    "1"                 TO  FLG-SEIHO
                       PERFORM 31011-SEH-GMN-HENSYU-SEC
                   END-IF      
               END-IF
      *                                      
               MOVE    "PTKOHINF-KEY5"  TO  WRK-PATH
               PERFORM 910-PTKOHINF-NEXT-SEC
           END-PERFORM                                 
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY5"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *    現在頁                 
           MOVE    1               TO  SPA-GMN-PAGE
      *    最大頁
           IF      SPA-GMN-MAX         =   ZERO
               MOVE    1                   TO  SPA-GMN-MAX-PAGE
           ELSE    
               COMPUTE SPA-GMN-MAX-PAGE    = 
                                  ( SPA-GMN-MAX +   WRK-LINE-MAX 
                                                -   1            )
                                               /   WRK-LINE-MAX
           END-IF                                      
      *    該当の生保患者がないとき
           IF      SPA-GMN-MAX     =    ZERO
               MOVE    98              TO  SPA-GMN-CUR
               MOVE    "該当患者なし"  TO  SPA-GMN-TNAME (1 1)
           ELSE         
               MOVE    2               TO  SPA-GMN-CUR
           END-IF    
      *
           .
       3101-SEH-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報画面編集処理
      *****************************************************************
       31011-SEH-GMN-HENSYU-SEC         SECTION.
      *
           ADD     1               TO  SPA-GMN-MAX
           COMPUTE IDX1    =
                         ( SPA-GMN-MAX +   WRK-LINE-MAX  -   1 )
                                       /   WRK-LINE-MAX
           COMPUTE IDX2    =
                         ( SPA-GMN-MAX +   WRK-LINE-MAX )
                                       -   IDX1  *   WRK-LINE-MAX
           MOVE    PTKOH-PTID      TO      SPA-NAI-TPTID (IDX1 IDX2)
           INITIALIZE                  ORCSPTIDAREA
           MOVE    SPA-HOSPID      TO  SPTID-HOSPID
           MOVE    PTKOH-PTID      TO  SPTID-PTID
           CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                           SPA-1009-TBL
           MOVE    SPTID-PTNUM     TO    SPA-GMN-TPTNUM (IDX1 IDX2)
           MOVE    SPA-HOSPID      TO  PTINF-HOSPID
           MOVE    PTKOH-PTID      TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           MOVE    PTINF-NAME      TO  SPA-GMN-TNAME (IDX1 IDX2)
      *****MOVE    SPA-GMN-SRYYM   TO  SPA-GMN-TSRYYM(IDX1 IDX2)
      *****MOVE    SPA-NAI-SRYYM   TO  SPA-NAI-TSRYYM(IDX1 IDX2)
           MOVE    PTKOH-FTNJANUM  TO  SPA-GMN-TFTNJANUM (IDX1 IDX2)
           MOVE    SPA-HOSPID      TO  MONTHLYNUM-HOSPID
           MOVE    PTKOH-PTID      TO  MONTHLYNUM-PTID
           MOVE    WRK-CONS-SEIHO-HKNNUM
                                   TO  MONTHLYNUM-KOHNUM
           MOVE    SPA-NAI-SRYYM   TO  MONTHLYNUM-SRYYM
           MOVE    SPA-R01-NYUGAIKBN
                                   TO  MONTHLYNUM-NYUGAIKBN
           MOVE    MONTHLYNUM-REC  TO  MCPDATA-REC
           PERFORM 910-MONTHLYNUM-READ-SEC
           IF      FLG-MONTHLYNUM  =   ZERO
               MOVE    MONTHLYNUM-JKYSNUM  
                                       TO  SPA-GMN-TJKYSNUM (IDX1 IDX2)
           END-IF                    
      *
           .
       31011-SEH-GMN-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-RID1-SET-SEC            SECTION.
      *
           IF      SPA-RID1-FLG    =   "OK"
               EVALUATE    SPA-RIDCD
                   WHEN    "1001"
                       PERFORM 450-TOUROKU-SEC
                       MOVE    "JOIN"          TO  MCP-PUTTYPE
                       PERFORM 210-BACK
                   WHEN    "1002"
                   WHEN    "1003"
                       PERFORM 450-TOUROKU-SEC
               END-EVALUATE
           END-IF
      *                 
           EVALUATE    SPA-RIDCD
               WHEN    "1002"
                   PERFORM 450-BACK-MONTH-SEC
               WHEN    "1003"
                   PERFORM 480-NEXT-MONTH-SEC
           END-EVALUATE
      *
           MOVE    SPACE           TO  SPA-RID1-FLG
           MOVE    SPACE           TO  SPA-RIDCD      
           .
       330-RID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *        前月分 
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 450-BACK-MONTH-MAE-SEC
      *        前頁 
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 460-BACK-PAGE-SEC
      *        次頁 
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 470-NEXT-PAGE-SEC
      *        次月分 
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 480-NEXT-MONTH-MAE-SEC
      *        登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-TOUROKU-MAE-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
      *    入力個所のセット
           PERFORM 400-GMN-INPUT-SEC
      *
           MOVE    ZERO                TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       400-GMN-INPUT-SEC          SECTION.
      *
           MOVE    MCP-WIDGET          TO  SPA-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
           .
      *
       400-GMN-INPUT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェック
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *     
      *    関連チェック
      *****PERFORM 4103-KANREN-CHK-SEC
      *    IF      SPA-ERRCD       NOT =   SPACE 
      *        GO  TO  410-INPUT-CHK-EXT
      *****END-IF
      *
      *    登録時、必須入力チェック
           IF      FLG-TOUROKU         =   1
      *****    PERFORM 4109-TOUROKU-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
           END-IF
      *
           MOVE    ZERO            TO  SPA-GMN-CUR
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC          SECTION.
      *
           MOVE    SPA-GMN-PAGE        TO  IDX1
      *       
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       25
      *        患者番号
      *********MOVE    R98-PTNUM (IDX) TO  SPA-GMN-TPTNUM   (IDX1 IDX)
      *        受給者番号         
               MOVE    R98-JKYSNUM (IDX) 
                                       TO  SPA-GMN-TJKYSNUM (IDX1 IDX)
           END-PERFORM
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC          SECTION.
      *
           MOVE    SPA-GMN-PAGE        TO  IDX1
      *     
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       25
      *        患者番号
      *****    PERFORM 41021-PTNUM-CHK-SEC
      *        IF      SPA-ERRCD       NOT =   SPACE 
      *            GO  TO  4102-KIHON-CHK-EXT
      *****    END-IF
      *        受給者番号         
               PERFORM 41023-JKYSNUM-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE 
                   GO      TO      4102-KIHON-CHK-EXT
               END-IF
           END-PERFORM
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
       41021-PTNUM-CHK-SEC            SECTION.
      *         
           COMPUTE SPA-GMN-CUR         =   IDX *   2   -   1
      *
           MOVE    SPACE               TO  SPA-GMN-TNAME (IDX1 IDX)
           MOVE    ZERO                TO  SPA-NAI-TPTID (IDX1 IDX)
      *
           IF      SPA-GMN-TPTNUM (IDX1 IDX)   =   SPACE
               GO  TO  41021-PTNUM-CHK-EXT
           END-IF
      *
           MOVE    SPACE               TO  SPA-GMN-TNAME (IDX1 IDX)
           MOVE    ZERO                TO  SPA-NAI-TPTID (IDX1 IDX)
      *
           INITIALIZE                  ORCSPTIDAREA
           MOVE    SPA-HOSPID          TO  SPTID-HOSPID
           MOVE    SPA-GMN-TPTNUM (IDX1 IDX)
                                       TO  SPTID-PTNUM
           CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                               SPA-1009-TBL
           IF      SPTID-RC        NOT =   ZERO
               MOVE    "0003"          TO  SPA-ERRCD
               GO  TO                  41021-PTNUM-CHK-EXT
           END-IF
           MOVE    SPTID-PTNUM         TO  SPA-GMN-TPTNUM (IDX1 IDX)
           MOVE    SPTID-PTID          TO  SPA-NAI-TPTID  (IDX1 IDX)
      *
      *    患者マスター存在チェック
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-NAI-TPTID (IDX1 IDX)
                                       TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           NOT =   ZERO
               MOVE    "0001"              TO  SPA-ERRCD
               GO      TO      41021-PTNUM-CHK-EXT
           END-IF
      *
           MOVE    PTINF-NAME        TO  SPA-GMN-TNAME (IDX1 IDX)
           .
       41021-PTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    受給者番号入力処理
      *****************************************************************
       41023-JKYSNUM-CHK-SEC                SECTION.
      *
           COMPUTE SPA-GMN-CUR         =   IDX *   2
      *
           IF      SPA-GMN-TJKYSNUM (IDX1 IDX) =   SPACE
               GO      TO      41023-JKYSNUM-CHK-EXT
           END-IF
      *
           IF      SPA-NAI-TPTID (IDX1 IDX)    =   ZERO
               MOVE    "0009"                  TO  SPA-ERRCD
               GO      TO      41023-JKYSNUM-CHK-EXT
           END-IF
      *
      *    半角・全角のチェックと桁数判定
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN-TJKYSNUM (IDX1 IDX)
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC      NOT =   ZERO
      *        半角・全角混在エラー
               MOVE    "0007"              TO  SPA-ERRCD
               GO      TO          41023-JKYSNUM-CHK-EXT
           END-IF
           IF      KANACHK-RC2     NOT =   ZERO
      *        入力文字エラー
               MOVE    "0008"         TO  SPA-ERRCD
               GO  TO                 41023-JKYSNUM-CHK-EXT
           END-IF
           IF      KANACHK-MAX         <=  1
               MOVE    "0008"              TO  SPA-ERRCD
           END-IF
      *
      *    入力された保険者番号をセットすれば、サブプロ内で
      *    検証してくれる (処理区分:2)
           INITIALIZE                      LNK-CHKDGT-AREA
           MOVE    2                   TO  LNK-I-SYORIKBN
           MOVE    SPA-GMN-TJKYSNUM (IDX1 IDX)
                                       TO  LNK-I-CODE
           CALL    "ORCSCHKDGT"    USING   LNK-CHKDGT-AREA
           IF      LNK-O-ERRCD     NOT =   ZERO
               MOVE    "0005"          TO  SPA-ERRCD
               GO  TO               41023-JKYSNUM-CHK-EXT
           END-IF
           .
       41023-JKYSNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    関連チェック処理
      *****************************************************************
       4103-KANREN-CHK-SEC             SECTION.
      *
           MOVE    SPA-GMN-PAGE        TO  IDX1
      *
      *    患者番号と診療年月の関連チェック
           PERFORM 41031-KANREN-CHK1-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO      TO      4103-KANREN-CHK-EXT
           END-IF
      *
      *    患者番号と診療年月の重複チェック
           PERFORM 41032-KANREN-CHK1-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO      TO      4103-KANREN-CHK-EXT
           END-IF
           .
      *
       4103-KANREN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号と診療年月チェック処理
      *****************************************************************
       41031-KANREN-CHK1-SEC           SECTION.
      * 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       25
      *
               COMPUTE SPA-GMN-CUR         =   IDX *   2   -   1
      *
               IF     SPA-NAI-TPTID (IDX1 IDX)     =   ZERO
                   GO  TO  41031-KANREN-CHK1-EXT
               END-IF
      *
      *        生保があるか         
               MOVE    ZERO                TO  FLG-CHK
      *      
               MOVE    SPA-HOSPID          TO  PTKOH-HOSPID
               MOVE    SPA-NAI-TPTID (IDX1 IDX)
                                           TO  PTKOH-PTID
               MOVE    WRK-CONS-SEIHO-HKNNUM
                                           TO  PTKOH-KOHNUM
               MOVE    PTKOHINF-REC        TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "PTKOHINF-KEY4"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "PTKOHINF-KEY4"     TO  WRK-PATH
                   PERFORM 910-PTKOHINF-NEXT-SEC
               ELSE    
                   MOVE    1                   TO  FLG-PTKOHINF
               END-IF
               PERFORM         UNTIL   FLG-PTKOHINF     =   1
                               OR      FLG-CHK          =   1
                   IF      SPA-NAI-SRYYM       >=  PTKOH-TEKSTYMD (1:6)  
                   AND     SPA-NAI-SRYYM       <=  PTKOH-TEKEDYMD (1:6)  
                       MOVE    1                   TO  FLG-CHK
                   END-IF
                   MOVE    "PTKOHINF-KEY4"     TO  WRK-PATH
                   PERFORM 910-PTKOHINF-NEXT-SEC
               END-PERFORM        
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "PTKOHINF-KEY4"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      FLG-CHK             =   1
                   MOVE    PTKOH-FTNJANUM  TO  SPA-GMN-TFTNJANUM 
                                                           (IDX1 IDX)
               ELSE
                   MOVE    "0006"          TO  SPA-ERRCD
                   GO  TO  41031-KANREN-CHK1-EXT
               END-IF
      *
      *        受給者番号未入力のとき
      *        月代わり受給者番号マスタに既に存在するとき                          
               IF      SPA-GMN-TJKYSNUM  (IDX1 IDX)
                                       =   SPACE
                   MOVE    SPA-HOSPID      TO  MONTHLYNUM-HOSPID
                   MOVE    SPA-NAI-TPTID (IDX1 IDX)
                                           TO  MONTHLYNUM-PTID
                   MOVE    WRK-CONS-SEIHO-HKNNUM
                                           TO  MONTHLYNUM-KOHNUM
                   MOVE    SPA-NAI-SRYYM   TO  MONTHLYNUM-SRYYM
                   MOVE    SPA-R01-NYUGAIKBN
                                           TO  MONTHLYNUM-NYUGAIKBN
                   MOVE    MONTHLYNUM-REC  TO  MCPDATA-REC
                   PERFORM 910-MONTHLYNUM-READ-SEC
                   IF      FLG-MONTHLYNUM  =   ZERO 
                       IF      SPA-GMN-TJKYSNUM (IDX1 IDX)
                                               =   SPACE
                           MOVE    MONTHLYNUM-JKYSNUM
                                           TO  SPA-GMN-TJKYSNUM
                                                           (IDX1 IDX)
                       END-IF
                   END-IF
               END-IF
           END-PERFORM                                
      *
           .
       41031-KANREN-CHK1-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号の重複チェック処理
      *****************************************************************
       41032-KANREN-CHK1-SEC         SECTION.
      * 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       24
      *
               COMPUTE SPA-GMN-CUR         =   IDX *   2   -   1
      *
               IF     SPA-GMN-TPTNUM (IDX1 IDX)    =   SPACE 
                   CONTINUE
               ELSE
                   COMPUTE IDY     =       IDX     +   1
                   PERFORM VARYING IDZ FROM    IDY BY  1
                           UNTIL   IDZ >       25
                       IF     SPA-GMN-TPTNUM (IDX1 IDX)    =   SPACE 
                           CONTINUE
                       ELSE
                           IF     SPA-GMN-TPTNUM (IDX1 IDX)
                                           =   SPA-GMN-TPTNUM (IDX1 IDZ)
                               MOVE    "0010"              TO  SPA-ERRCD
                               GO  TO  41032-KANREN-CHK1-EXT
                           END-IF
                       END-IF
                   END-PERFORM        
               END-IF    
           END-PERFORM                                
      *
           .
       41032-KANREN-CHK1-EXT.
           EXIT.
      *
      ****************************************************************
      *    登録前、必須入力チェック処理
      ****************************************************************
       4109-TOUROKU-CHK-SEC      SECTION.
      *
      *    登録時、必須入力チェック
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       25
               IF      SPA-GMN-TPTNUM  (IDX1 IDX)   =   SPACE
               AND     SPA-GMN-TJKYSNUM(IDX1 IDX)   =   SPACE
                   CONTINUE
               ELSE
                   IF      SPA-GMN-TPTNUM (IDX1 IDX)    =   SPACE
                       MOVE    "0100"              TO  SPA-ERRCD
                       COMPUTE SPA-GMN-CUR     =   IDX *   2   -   1
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF    
                   IF      SPA-GMN-TJKYSNUM(IDX1 IDX)   =   SPACE
                       MOVE    "0102"              TO  SPA-ERRCD
                       COMPUTE SPA-GMN-CUR     =   IDX *   2  
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF    
               END-IF        
           END-PERFORM
           .
      *
       4109-TOUROKU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    前月分表示前処理
      *****************************************************************
       450-BACK-MONTH-MAE-SEC            SECTION.
      * 
           IF      SPA-GMN-MAX         >   ZERO
      *        入力個所のセット
               PERFORM 400-GMN-INPUT-SEC
      *
               MOVE    1                   TO  FLG-TOUROKU
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
      *
               IF      SPA-ERRCD           =   SPACE
                   MOVE    "1002"              TO  SPA-RIDCD
               END-IF
           ELSE
               PERFORM 450-BACK-MONTH-SEC
           END-IF
           .
      *
       450-BACK-MONTH-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    前月分処理
      *****************************************************************
       450-BACK-MONTH-SEC               SECTION.
      *         
           INITIALIZE                     STS-AREA-DAY
           INITIALIZE                     LNK-DAY6-AREA
           MOVE    "61"                   TO  LNK-DAY6-IRAI
           MOVE    SPA-NAI-SRYYM          TO  LNK-DAY6-KIJUN (1:6)
           MOVE    "01"                   TO  LNK-DAY6-KIJUN (7:2)  
           MOVE    "2"                    TO  LNK-DAY6-ZOGENPTN
           MOVE    -1                     TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"              USING   STS-AREA-DAY
                                                  LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN(1:6)   TO  SPA-NAI-SRYYM
      *     
           PERFORM 3101-SEH-HENSYU-SEC
           .
      *
       450-BACK-MONTH-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁処理
      *****************************************************************
       460-BACK-PAGE-SEC               SECTION.
      *
      *    入力個所のセット
           PERFORM 400-GMN-INPUT-SEC
      *
           MOVE    1                   TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           IF      SPA-ERRCD           =   SPACE
               COMPUTE SPA-GMN-PAGE    =   SPA-GMN-PAGE    -   1
               MOVE    2                   TO  SPA-GMN-CUR
           END-IF    
           .
      *
       460-BACK-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁処理
      *****************************************************************
       470-NEXT-PAGE-SEC               SECTION.
      *
      *    入力個所のセット
           PERFORM 400-GMN-INPUT-SEC
      *
           MOVE    1                   TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           IF      SPA-ERRCD           =   SPACE
               COMPUTE SPA-GMN-PAGE    =   SPA-GMN-PAGE    +   1
               MOVE    2                   TO  SPA-GMN-CUR
           END-IF    
           .
      *
       470-NEXT-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次月分表示前処理
      *****************************************************************
       480-NEXT-MONTH-MAE-SEC            SECTION.
      * 
           IF      SPA-GMN-MAX         >   ZERO
      *        入力個所のセット
               PERFORM 400-GMN-INPUT-SEC
      *
               MOVE    1                   TO  FLG-TOUROKU
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
      *
               IF      SPA-ERRCD           =   SPACE
                   MOVE    "1003"              TO  SPA-RIDCD
               END-IF
           ELSE
               PERFORM 480-NEXT-MONTH-SEC
           END-IF
           .             
      *
       480-NEXT-MONTH-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次月分処理
      *****************************************************************
       480-NEXT-MONTH-SEC               SECTION.
      * 
      *     次月診療年月         
           INITIALIZE                     STS-AREA-DAY
           INITIALIZE                     LNK-DAY6-AREA
           MOVE    "61"                   TO  LNK-DAY6-IRAI
           MOVE    SPA-NAI-SRYYM          TO  LNK-DAY6-KIJUN (1:6)
           MOVE    "01"                   TO  LNK-DAY6-KIJUN (7:2)  
           MOVE    "2"                    TO  LNK-DAY6-ZOGENPTN
           MOVE    1                      TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"              USING   STS-AREA-DAY
                                                  LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN(1:6)   TO  SPA-NAI-SRYYM
      *     
           PERFORM 3101-SEH-HENSYU-SEC
      *            
           .
      *
       480-NEXT-MONTH-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "R03"               TO  SPA-SAKIPG
           MOVE    "R98"               TO  SPA-MOTOPG
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新前処理
      *****************************************************************
       450-TOUROKU-MAE-SEC                SECTION.
      *
           IF      SPA-GMN-MAX         =   ZERO
               MOVE    "0011"              TO  SPA-ERRCD
               MOVE    98                  TO  SPA-GMN-CUR 
               GO  TO  450-TOUROKU-MAE-EXT
           END-IF
      *         
      *    入力個所のセット
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
           MOVE    1                   TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    "1001"              TO  SPA-RIDCD
           END-IF     
           .
       450-TOUROKU-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       450-TOUROKU-SEC                SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       SPA-GMN-MAX-PAGE
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       25
                       OR      SPA-NAI-TPTID (IDX1 IDX)    =   ZERO    
                   IF      SPA-NAI-TPTID (IDX1 IDX)    =   ZERO
                       CONTINUE
                   ELSE
                       INITIALIZE                  MONTHLYNUM-REC 
                       MOVE    SPA-HOSPID      TO  MONTHLYNUM-HOSPID
                       MOVE    SPA-NAI-TPTID (IDX1 IDX)
                                               TO  MONTHLYNUM-PTID
                       MOVE    WRK-CONS-SEIHO-HKNNUM
                                               TO  MONTHLYNUM-KOHNUM
                       MOVE    SPA-NAI-SRYYM   TO  MONTHLYNUM-SRYYM
                       MOVE    SPA-R01-NYUGAIKBN
                                               TO  MONTHLYNUM-NYUGAIKBN
                       MOVE    MONTHLYNUM-REC  TO  MCPDATA-REC
                       PERFORM 910-MONTHLYNUM-READ-SEC
      *
      *                受給者番号未入力のとき月代わり受給者番号マスタに
      *                存在しないときは更新しない                 
                       IF      SPA-GMN-TJKYSNUM (IDX1 IDX)
                                               =   SPACE
                       AND     FLG-MONTHLYNUM  =   1
                           CONTINUE
                       ELSE                             
                           MOVE    SPA-GMN-TJKYSNUM (IDX1 IDX)
                                               TO  MONTHLYNUM-JKYSNUM
                           IF      FLG-MONTHLYNUM  =   ZERO
                               MOVE    "DBUPDATE"          TO  MCP-FUNC
                           ELSE
                               MOVE    "DBINSERT"          TO  MCP-FUNC   
                           END-IF
                           MOVE    MONTHLYNUM-REC  TO  MCPDATA-REC
                           MOVE    "MONTHLYNUM-KEY"
                                                   TO  ORC-DBPATH
                           CALL    "ORCMCPSUB"         USING
                                                       MCPAREA
                                                       ORCMCPAREA
                                                       MCPDATA-REC
                           IF      MCP-RC              =   ZERO
                               CONTINUE
                           ELSE    
                               MOVE    "1001"              TO  SPA-ERRCD
                               GO  TO  450-TOUROKU-EXT
                           END-IF
                       END-IF
                   END-IF    
               END-PERFORM
           END-PERFORM                     
           .
       450-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HGO
               MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
               MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
               MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG1
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG1
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG3
               
           END-IF
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      * 
           IF      WRK-YM   (1:5)  NOT NUMERIC
               INSPECT     WRK-YM       REPLACING   ALL " " BY  "0"         
               MOVE    WRK-YM(1:1)      TO  WRK-WGO
               MOVE    WRK-YM(2:2)      TO  WRK-WYY
               MOVE    WRK-YM(5:2)      TO  WRK-WMM
           ELSE
               MOVE    WRK-YM(1:5)      TO  WRK-WYMD (1:5)
           END-IF
           MOVE    "01"             TO  WRK-WDD
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY1-AREA
           MOVE    "12"                TO  LNK-DAY1-IRAI
           MOVE    ZERO                TO  LNK-DAY1-YMD
           MOVE    WRK-WYMD            TO  LNK-DAY1-YMD(2:7)
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY1-AREA
           IF      STS-DAY-RC1     NOT =   ZERO
               MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-RIDCD       NOT =   SPACE
               PERFORM 520-RIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "R98    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      * 
           MOVE    SPACE               TO  R98
      *
           MOVE    SPA-GMN-SRYYMH      TO  R98-SRYYMH-VALUE
           MOVE    "blue"              TO  R98-SRYYMH-STYLE
      *
           MOVE    SPA-GMN-PAGE        TO  IDX1
      *          
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   25
               MOVE    SPA-GMN-TPTNUM     (IDX1 IDX)
                                           TO  R98-PTNUM    (IDX)
               MOVE    SPA-GMN-TNAME      (IDX1 IDX)
                                           TO  R98-NAME     (IDX)
               MOVE    SPA-GMN-TFTNJANUM  (IDX1 IDX)
                                           TO  R98-FTNJANUM (IDX)
               MOVE    SPA-GMN-TJKYSNUM   (IDX1 IDX)
                                           TO  R98-JKYSNUM  (IDX)
           END-PERFORM
      *
           IF      SPA-GMN-PAGE        =   1     
               MOVE    WIDGET-INSENSITIVE  TO  R98-B06-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  R98-B06-STATE
           END-IF    
           IF      SPA-GMN-PAGE        =   SPA-GMN-MAX-PAGE
               MOVE    WIDGET-INSENSITIVE  TO  R98-B07-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  R98-B07-STATE
           END-IF    
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
      *    カーソル指定のない時、入力した項目の次へ
           IF      SPA-GMN-CUR         =   ZERO
               PERFORM 50011-INPUT-CUR-SEC
      *****    ADD     1               TO  SPA-GMN-CUR
               ADD     2               TO  SPA-GMN-CUR
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1
               WHEN    3
               WHEN    5
               WHEN    7
               WHEN    9
               WHEN    11
               WHEN    13
               WHEN    15
               WHEN    17
               WHEN    19
               WHEN    21
               WHEN    23
               WHEN    25
               WHEN    27
               WHEN    29
               WHEN    31
               WHEN    33
               WHEN    35
               WHEN    37
               WHEN    39
               WHEN    41
               WHEN    43
               WHEN    45
               WHEN    47
               WHEN    49
                    COMPUTE WRK-CUR-IDX     = ( SPA-GMN-CUR +   1 )
                                            /   2
                    MOVE  "PTNUM"           TO  MCP-WIDGET 
                    MOVE    WRK-CUR-IDX     TO  MCP-WIDGET (6:2) 
               WHEN    2
               WHEN    4
               WHEN    6
               WHEN    8
               WHEN    10
               WHEN    12
               WHEN    14
               WHEN    16
               WHEN    18
               WHEN    20
               WHEN    22
               WHEN    24
               WHEN    26
               WHEN    28
               WHEN    30
               WHEN    32
               WHEN    34
               WHEN    36
               WHEN    38
               WHEN    40
               WHEN    42
               WHEN    44
               WHEN    46
               WHEN    48
               WHEN    50
                    COMPUTE WRK-CUR-IDX     =   SPA-GMN-CUR   /   2
                    MOVE    "JKYSNUM"       TO  MCP-WIDGET 
                    MOVE    WRK-CUR-IDX     TO  MCP-WIDGET (8:2) 
      *            
               WHEN    98
                    MOVE  "B01"        TO  MCP-WIDGET   
               WHEN    99
                    MOVE  "B12"        TO  MCP-WIDGET   
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC          SECTION.
      *
           EVALUATE    	TRUE
      *        患者番号
               WHEN    SPA-MCP-WIDGET (1:5)    =   "PTNUM"
                   MOVE    SPA-MCP-WIDGET (6:2)    TO  WRK-CUR-IDX
                   COMPUTE SPA-GMN-CUR =   WRK-CUR-IDX    *   2   -   1        
      *        受給者番号
               WHEN    SPA-MCP-WIDGET (1:7)    =   "JKYSNUM"
                   MOVE    SPA-MCP-WIDGET (8:2)    TO  WRK-CUR-IDX
                   COMPUTE SPA-GMN-CUR =   WRK-CUR-IDX    *   2        
           END-EVALUATE
           .
      *
       50011-INPUT-CUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示処理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "患者番号入力エラー"        TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "診療年月入力エラー"        TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "該当の患者番号はありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "半角で入力して下さい"      TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "受給者番号検証番号エラーです"
                                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "生活保護の対象ではありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "受給者番号は全角・半角の混在はできません"
                                                       TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "受給者番号は全角・半角の混在はできません"
                                                       TO  SPA-ERRMSG
               WHEN    "0009"                                        
                   MOVE
                       "対象の患者がないので受給者番号は入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "同じ患者番号が入力してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "更新対象の患者はありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0100"
                   MOVE    "患者番号が未入力です"      TO  SPA-ERRMSG
               WHEN    "0102"
                   MOVE    "受給者番号が未入力です"    TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "月代わり受給者番号マスタが更新できません"
                                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  RERR
           MOVE    SPA-ERRCD            TO  RERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  RERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "R98"                TO  SPA-MOTOPG
           MOVE    "RERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "RERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-RIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-RIDMSG
      *
           EVALUATE    SPA-RIDCD
               WHEN    "1001"
                   MOVE    "更新します"        TO  WRK-RIDMSG
               WHEN    "1002"
                   MOVE    "前月分を表示します　当月分を更新しますか"
                                               TO  WRK-RIDMSG
               WHEN    "1003"
                   MOVE    "次月分を表示します　当月分を更新しますか"
                                               TO  WRK-RIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  RID1
           MOVE    SPA-RIDCD            TO  RID1-ID1CODE
           MOVE    WRK-RIDMSG           TO  RID1-ID1MSG
           EVALUATE    SPA-RIDCD
               WHEN    "1001"
                   MOVE    "戻る"       TO  RID1-B01-LABEL
               WHEN    "1002"
               WHEN    "1003"
                   MOVE    "ＮＯ"       TO  RID1-B01-LABEL
           END-EVALUATE        
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "R98"                TO  SPA-MOTOPG
           MOVE    "RID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "RID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-RIDSET-EXT.
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
               CALL    "ORCMCPSUB"          USING
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
      *    診療会計マスタ　ＲＥＡＤ
      *****************************************************************
       900-SRYACCT-NEXT-SEC         SECTION.
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
           END-IF
           .
       900-SRYACCT-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスタ読込
      *****************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
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
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費情報マスタ読込
      *****************************************************************
       910-PTKOHINF-READ-SEC         SECTION.
      *
           MOVE    "DBSELECT"           TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC               =   ZERO
               MOVE    "PTKOHINF-KEY"       TO  WRK-PATH
               PERFORM 910-PTKOHINF-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-PTKOHINF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       910-PTKOHINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費情報マスタ読込
      *****************************************************************
       910-PTKOHINF-NEXT-SEC         SECTION.
      * 
           MOVE    "DBFETCH"            TO  MCP-FUNC
           MOVE    WRK-PATH             TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC               =   ZERO
               MOVE    ZERO                 TO  FLG-PTKOHINF
               MOVE    MCPDATA-REC          TO  PTKOHINF-REC
               IF      PTKOH-SAKJOKBN       =   "1"
                   MOVE    1                    TO  FLG-PTKOHINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTKOHINF
           END-IF
      *
           .
       910-PTKOHINF-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    月代わり受給者番号マスタ読込
      *****************************************************************
       910-MONTHLYNUM-READ-SEC         SECTION.
      *
           MOVE    "DBSELECT"           TO  MCP-FUNC
           MOVE    "MONTHLYNUM-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC               =   ZERO
               MOVE    "DBFETCH"            TO  MCP-FUNC
               MOVE    "MONTHLYNUM-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC               =   ZERO
                   MOVE    ZERO                 TO  FLG-MONTHLYNUM
                   MOVE    MCPDATA-REC          TO  MONTHLYNUM-REC
               ELSE
                   MOVE    1                   TO  FLG-MONTHLYNUM
               END-IF
           ELSE
               MOVE    1                   TO  FLG-MONTHLYNUM
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "MONTHLYNUM-KEY"    TO      ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       910-MONTHLYNUM-READ-EXT.
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
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
           .
       900-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *
