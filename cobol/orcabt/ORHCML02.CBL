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
       PROGRAM-ID.             ORHCML02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 点数マスタ
      *  コンポーネント名  : 点数マスタ一覧表・特定器材（ＨＣＭＬ０２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/12/10    MCC-森脇      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01/07/03  日付入力チェックサブ追加
      *  01.00.02    MCC-藤原     02/03/18  帳票ファイル名の変更
      *  01.00.03    MCC-藤原     02/04/24  印刷管理・印刷ＤＢの追加
      *  01.00.04    MCC-藤原     02/05/10  頁数のジョブ管理ＤＢへの更新
      *
      *  01.01.01    NACL-藤原    02/10/10  サイト区分追加
      *  01.01.02    NACL-森脇    03/03/10  TERMIDの領域指定なし
      *  02.00.01    NACL-森脇    03/12/25  その他材料追加
      *  02.00.02    NACL-森脇    04/03/16  点数の桁修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *    エラーファイル
           SELECT  TENSUERR-FILE    ASSIGN  TENSUERR
                                   FILE    STATUS  IS  STS-TENSUERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  TENSUERR-FILE.
       01  TENSUERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //TENSUERR//.
           03                      PIC X(04)   VALUE   ".dat".
      *     
           COPY    "HCML02.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-TENSUERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(03).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           COPY    "CPHCMLSHELL.INC"
                                   REPLACING  //SHELL-//
                                   BY         //WRK-PARA-//.
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PATH                PIC X(64).
      *
           03  WRK-TENSUERR             PIC X(200).        
      *
           03  WRK-LNKYMD            PIC X(10).
           03  WRK-MSTYMDH           PIC X(10).
           03  WRK-MSTYMDWH          PIC X(22).
           03  WRK-SYSYMDWH          PIC X(22).
      *  
           03  WRK-SYSYMD.
               05  WRK-SYSYY         PIC 9(04).
               05  WRK-SYSMM         PIC 9(02).
               05  WRK-SYSDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY           PIC 9(04).
               05  WRK-SMM           PIC 9(02).
               05  WRK-SDD           PIC 9(02).
           03  WRK-HENYMDG           PIC X(22).
      *
      *     03  WRK-IN                PIC X.
      *
           03  WRK-PAGE              PIC ZZ,ZZ9.
      *----(02.00.02)--UPD-START---
           03  WRK-TEN               PIC ZZZ,ZZZ,ZZ9.99.
      *----(02.00.02)--UPD-END-----
           03  WRK-JGNTEN            PIC ZZZ,ZZ9.
           03  WRK-KGNAGE            PIC Z9.
           03  WRK-JGNAGE            PIC Z9.
           03  WRK-KOUHYOJYUNNUM     PIC ZZZZZZZZ9.     
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".          
      *
      *    医療機関名      
           COPY  "CPSK1001.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *     
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".          
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-END         =   1
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           PERFORM 100-DBOPEN-SEC
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
                                               WRK-PARA-AREA
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORHCML02"      TO  JOB-PGID
      *----(02.00.01)--UPD-START---
           EVALUATE    WRK-PARA-KBN
               WHEN    1
                   MOVE    "点数マスタ一覧表・特定器材" 
                                   TO  JOB-SHELLMSG
               WHEN    2
                   MOVE    "点数マスタ一覧表・その他材料" 
                                   TO  JOB-SHELLMSG
           END-EVALUATE
      *----(02.00.01)--UPD-END-----
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *                             
           MOVE    LNK-PRTKANRI-SKYYMD
                                    TO  WRK-LNKYMD
           PERFORM 831-YMDCONV12-SEC
           MOVE    WRK-LNKYMD       TO  WRK-MSTYMDH
      *     
           MOVE    "TENSUERR"       TO  TENSUERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  TENSUERR-TERMID
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
      *
           IF      FLG-END            =   ZERO
      *    帳票印刷開始処理
               PERFORM 900-DBSELECT-SEC
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC                   SECTION.
      *               
      *    医療機関名称編集
           MOVE    SPACE               TO  SYS-1001-REC
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
               IF      SYS-1001-HOSPNAME   =   LOW-VALUE
                   MOVE    SPACE               TO  SYS-1001-HOSPNAME
               END-IF  
           ELSE    
               INITIALIZE                  SYS-1001-REC
               MOVE    "医療機関名称が取得できませんでした。"
                                           TO  WRK-TENSUERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF                                     
           .
      *
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM              UNTIL   FLG-END     =   1
      *        帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
      *        帳票編集<明細>処理
               PERFORM 320-BODY-HEN-SEC
      *        帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
           END-PERFORM
      *
           PERFORM 900-DBCLOSE-SEC
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       310-HEAD-HEN-SEC          SECTION.
      *
           MOVE    ZERO                TO  CNT-LINE
           ADD     1                   TO  CNT-PAGE
      *
           INITIALIZE                      HCML02
           MOVE    SPACE               TO  HCML02
      *
           MOVE    SYS-1001-HOSPNAME   TO  HCML02-HOSPNAME
           MOVE    WRK-MSTYMDH         TO  HCML02-MSTYMD
           MOVE    CNT-PAGE            TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  HCML02-PAGE
      *
      *----(02.00.01)--ADD-START---
           EVALUATE    WRK-PARA-KBN
               WHEN    1
                   MOVE    "（特定器材）"      TO  HCML02-TITLE
               WHEN    2
                   MOVE    "（その他材料）"    TO  HCML02-TITLE
           END-EVALUATE
      *----(02.00.01)--ADD-END-----
      *
           .
       310-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       320-BODY-HEN-SEC      SECTION.
      *
           MOVE    ZERO                TO  CNT-LINE
      *
           PERFORM             UNTIL   FLG-END     =   1
                               OR      CNT-LINE    =   15                    
      *
               ADD     1                  TO  CNT-LINE
      *
               MOVE    TNS-TEN            TO  WRK-TEN
               MOVE    WRK-TEN            TO  HCML02-TEN(CNT-LINE)
               IF  TNS-JGNTEN  NOT  =  "0"
                   MOVE    TNS-JGNTEN     TO  WRK-JGNTEN
                   MOVE    WRK-JGNTEN     TO  HCML02-JGNTEN(CNT-LINE)
               END-IF
               IF  TNS-KGNAGE  NOT  =  "00"
                   MOVE    TNS-KGNAGE     TO  WRK-KGNAGE
                   MOVE    WRK-KGNAGE     TO  HCML02-KGNAGE(CNT-LINE)
               END-IF
               IF  TNS-JGNAGE  NOT  =  "00"
                   MOVE    "-"            TO  HCML02-NYOROAGE(CNT-LINE)
                   IF  TNS-JGNAGE   =  "AA"
                       MOVE    TNS-JGNAGE TO  HCML02-JGNAGE(CNT-LINE)
                   ELSE
                       MOVE    TNS-JGNAGE TO  WRK-JGNAGE
                       MOVE    WRK-JGNAGE TO  HCML02-JGNAGE(CNT-LINE)
                   END-IF
               END-IF
               MOVE    TNS-KOUHYOJYUNNUM  TO  WRK-KOUHYOJYUNNUM
               MOVE    WRK-KOUHYOJYUNNUM  TO
                                          HCML02-KOUHYOJYUNNUM(CNT-LINE)
      *
               MOVE    TNS-SRYCD          TO  HCML02-SRYCD(CNT-LINE)
               MOVE    TNS-NAME           TO  HCML02-NAME(CNT-LINE)
               MOVE    TNS-TANINAME       TO  HCML02-TANINAME(CNT-LINE)
               MOVE    TNS-YUKOSTYMD      TO  HCML02-YUKOSTYMD(CNT-LINE)
               MOVE    TNS-YUKOEDYMD      TO  HCML02-YUKOEDYMD(CNT-LINE)
               MOVE    "-"                TO  HCML02-NYORO(CNT-LINE)
               IF      TNS-DATAKBN  NOT  =  "0"
                   MOVE    TNS-DATAKBN   TO  HCML02-DATAKBN(CNT-LINE)
               END-IF
      *        年齢加算 
               EVALUATE  TNS-TOKUKIZAIAGEKSNKBN
                   WHEN  "0"
                       MOVE  SPACE       
                             TO      HCML02-TOKUKIZAIAGEKSNKBN(CNT-LINE)
                   WHEN  "1"
                       MOVE  "年齢加算"    
                             TO      HCML02-TOKUKIZAIAGEKSNKBN(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"   
                             TO      HCML02-TOKUKIZAIAGEKSNKBN(CNT-LINE)
               END-EVALUATE
      *        名称識別
               EVALUATE  TNS-MEIUSESKB
                   WHEN  "0"
                       MOVE  SPACE       TO  HCML02-MEIUSESKB(CNT-LINE)
                   WHEN  "1"
                       MOVE  "名称識別"  TO  HCML02-MEIUSESKB(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"  TO  HCML02-MEIUSESKB(CNT-LINE)
               END-EVALUATE         
      *        酸素等
               EVALUATE  TNS-SANSOKBN
                   WHEN  "0"
                       MOVE  SPACE       TO  HCML02-SANSOKBN(CNT-LINE)
                   WHEN  "1"
                       MOVE  "酸素等"    TO  HCML02-SANSOKBN(CNT-LINE)           
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"  TO  HCML02-SANSOKBN(CNT-LINE)     
               END-EVALUATE     
      *        特定器材1 
               EVALUATE  TNS-TOKUKIZAISBT1
                   WHEN  "0"
                       MOVE  SPACE  TO  HCML02-TOKUKIZAISBTONE(CNT-LINE)
                   WHEN  "2"
                       MOVE  "酸素" TO  HCML02-TOKUKIZAISBTONE(CNT-LINE)
                   WHEN  "3"
                       MOVE "放射線" TO HCML02-TOKUKIZAISBTONE(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"  
                             TO       HCML02-TOKUKIZAISBTONE(CNT-LINE)
               END-EVALUATE
      *        特定器材2 
               EVALUATE  TNS-TOKUKIZAISBT2
                   WHEN  "0"
                       MOVE  SPACE  TO  HCML02-TOKUKIZAISBTTSU(CNT-LINE)
                   WHEN  "1"
                       MOVE  "控除あり"  TO 
                                      HCML02-TOKUKIZAISBTTSU(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"  
                             TO       HCML02-TOKUKIZAISBTTSU(CNT-LINE)
               END-EVALUATE
      *
               PERFORM 900-DBFETCH-SEC         
      *              
           END-PERFORM     
      *
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC                SECTION.
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
           MOVE    "HCML02"            TO  SPRT-PRTID
      *----(02.00.01)--UPD-START---
           EVALUATE    WRK-PARA-KBN
               WHEN    1
                   MOVE    "点数マスタ一覧表・特定器材"
                                       TO  SPRT-TITLE
               WHEN    2
                   MOVE    "点数マスタ一覧表・その他材料"
                                       TO  SPRT-TITLE
           END-EVALUATE
      *----(02.00.01)--UPD-END-----
           MOVE    HCML02              TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                          TO  WRK-TENSUERR
               PERFORM 500-ERR-HENSYU-SEC                           
           END-IF                                                              
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
      *
           OPEN    INPUT   TENSUERR-FILE
      *     
           IF      STS-TENSUERR         =   ZERO
               CONTINUE
           ELSE
               OPEN    OUTPUT              TENSUERR-FILE
      *
               MOVE    WRK-TENSUERR         TO  TENSUERR-REC
               WRITE   TENSUERR-REC
      *         
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-TENSUERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *
           CLOSE   TENSUERR-FILE
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
           DISPLAY "*** ORHCML02 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CNT-PAGE        TO  JOB-UPDCNT 
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *                              
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *   和暦年月日→西暦年月日（機能１２）
      *****************************************************************
       831-YMDCONV12-SEC                         SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-LNKYMD          TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-LNKYMD
           .
      *
       831-YMDCONV12-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ　検索 
      *****************************************************************
       900-DBSELECT-SEC                 SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC
      *----(02.00.01)--UPD-START---
           EVALUATE    WRK-PARA-KBN
      *        特定器材
               WHEN    1
                   MOVE    "700000000"         TO  TNS-SRYCD
                   MOVE    "799999999"         TO  TNSUP-SRYCD
      *        その他材料
               WHEN    2
                   MOVE    "059000001"         TO  TNS-SRYCD
                   MOVE    "059999999"         TO  TNSUP-SRYCD
           END-EVALUATE
      *----(02.00.01)--UPD-END-----
      *
           EVALUATE    WRK-PARA-CYUKBN ALSO    WRK-PARA-SYUKBN
               WHEN    1               ALSO    1
                   MOVE    "TENSU-KEY12S"      TO  WRK-PATH
               WHEN    1               ALSO    2
                   MOVE    "TENSU-KEY12M"      TO  WRK-PATH
               WHEN    1               ALSO    3
                   MOVE    "TENSU-KEY12K"      TO  WRK-PATH
               WHEN    2               ALSO    1
                   MOVE    "TENSU-KEY12S1"     TO  WRK-PATH
               WHEN    2               ALSO    2
                   MOVE    "TENSU-KEY12M1"     TO  WRK-PATH
               WHEN    2               ALSO    3
                   MOVE    "TENSU-KEY12K1"     TO  WRK-PATH
           END-EVALUATE
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           MOVE    WRK-PARA-MSTYMD     TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               PERFORM 900-DBFETCH-SEC
           ELSE
               MOVE    1                   TO  FLG-END
           END-IF        
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *     点数マスタを検索処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-END
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
           ELSE
               MOVE    1                       TO  FLG-END
           END-IF  
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ　クローズ処理
      *****************************************************************
       900-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    WRK-PARA-MSTYMD     TO  ORC-DBYMD
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
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       800-SYSKANRI-READ-EXT.
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
