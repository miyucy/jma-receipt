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
       PROGRAM-ID.             ORHCML01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 点数マスタ
      *  コンポーネント名  : 点数マスタ一覧表・薬剤（HCML01）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/12/03    MCC-森脇      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02.03.18  帳票ファイル名の変更
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   FILE    STATUS  IS  STS-PARA.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
           COPY    "HCML01.INC".
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
           03  STS-RECEERR         PIC X(02).
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
           03  CNT-PAGE            PIC 9(06).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PATH                PIC X(64).
      *
       01  INEX-AREA.
           03  IDX                   PIC 9(02).      
      *
           03  WRK-RECEERR             PIC X(200).        
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
           03  WRK-PAGE              PIC ZZ,ZZ9.
           03  WRK-TEN               PIC Z,ZZZ,ZZ9.99.
           03  WRK-CSYYOURYO         PIC ZZ,ZZ9.     
      *
       01  WRK-JOBKANRI-AREA.                             
           03  WRK-JOBKANRI-MODE       PIC X(03). 
018900     03  WRK-JOBKANRI-RETURN     PIC S9(03).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
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
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPHCMLSHELL.INC"
                                   REPLACING  //SHELL-//
                                   BY         //WRK-PARA-//.
           03  WRK-PARA-TERMID     PIC X(32).
           03  WRK-PARA-SYSYMDWH   PIC X(09).
      *
      *
      ******************************************************************
       PROCEDURE                       DIVISION
                                       USING   WRK-PARA-AREA.
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
           EXIT    PROGRAM
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
           ACCEPT  SYS-TIME            FROM    TIME  
      *     
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
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
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF                                     
      *      
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE    
               INITIALIZE                  SYS-1031-REC
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
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      WRK-PARA-IYKCHK (IDX)   >   ZERO    
      *            帳票編集処理
                   PERFORM 2001-PRINT-SEC
               END-IF
           END-PERFORM
      *
           MOVE    1               TO  FLG-END             
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       2001-PRINT-SEC                SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
           INITIALIZE                  CNT-AREA
      *     
      *    帳票印刷開始処理
           PERFORM 900-DBSELECT-SEC
      *
           PERFORM              UNTIL   FLG-TENSU   =   1
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
       2001-PRINT-EXT.
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
           MOVE    SPACE               TO  HCML01
      *
           MOVE    SYS-1001-HOSPNAME   TO  HCML01-HOSPNAME
           MOVE    WRK-PARA-SYSYMDWH   TO  HCML01-MSTYMD
           MOVE    CNT-PAGE            TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  HCML01-PAGE
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
           PERFORM             UNTIL   FLG-TENSU   =   1
                               OR      CNT-LINE    =   15                    
      *
               ADD     1                 TO  CNT-LINE
      *
               MOVE    TNS-TEN           TO  WRK-TEN
               MOVE    WRK-TEN           TO  HCML01-TEN(CNT-LINE)
               MOVE    TNS-CSYYOURYO     TO  WRK-CSYYOURYO
               MOVE    WRK-CSYYOURYO     TO  HCML01-CSYYOURYO(CNT-LINE)
      *
               MOVE    TNS-SRYCD         TO  HCML01-SRYCD(CNT-LINE)
               MOVE    TNS-NAME          TO  HCML01-NAME(CNT-LINE)
               MOVE    TNS-TANINAME      TO  HCML01-TANINAME(CNT-LINE)
               MOVE    TNS-YUKOSTYMD     TO  HCML01-YUKOSTYMD(CNT-LINE)
               MOVE    TNS-YUKOEDYMD     TO  HCML01-YUKOEDYMD(CNT-LINE)
               MOVE    TNS-YAKKAKJNCD    TO  HCML01-YAKKAKJNCD(CNT-LINE)
               MOVE    "-"               TO  HCML01-NYORO(CNT-LINE)
               IF      TNS-KEIKASOCHIYMD  NOT  =  "00000000"
                   MOVE    TNS-KEIKASOCHIYMD TO 
                                         HCML01-KEIKASOCHIYMD(CNT-LINE)
               END-IF
      *        麻毒区分 
               EVALUATE  TNS-MADOKUKBN
                   WHEN  "0"
                       MOVE  SPACE       TO  HCML01-MADOKUKBN(CNT-LINE)
                   WHEN  "1"
                       MOVE  "麻毒"      TO  HCML01-MADOKUKBN(CNT-LINE)
                   WHEN  "2"
                       MOVE  "毒薬"      TO  HCML01-MADOKUKBN(CNT-LINE)
                   WHEN  "3"
                       MOVE  "覚せい剤"  TO  HCML01-MADOKUKBN(CNT-LINE)
                   WHEN  "5"
                       MOVE  "向精神薬"  TO  HCML01-MADOKUKBN(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"  TO  HCML01-MADOKUKBN(CNT-LINE)
               END-EVALUATE
      *        神経破壊剤
               EVALUATE  TNS-SINKEIHAKAIKBN
                   WHEN  "0"
                       MOVE  SPACE   TO  HCML01-SINKEIHAKAIKBN(CNT-LINE)
                   WHEN  "1"
                       MOVE  "神経破壊"     
                                     TO  HCML01-SINKEIHAKAIKBN(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"
                                     TO  HCML01-SINKEIHAKAIKBN(CNT-LINE)
               END-EVALUATE         
      *        生物学的製剤
               EVALUATE  TNS-SEIBUTUGAKUKBN
                   WHEN  "0"
                       MOVE  SPACE   TO  HCML01-SEIBUTUGAKUKBN(CNT-LINE)
                   WHEN  "1"
                       MOVE  "生物製剤"  
                                     TO  HCML01-SEIBUTUGAKUKBN(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"
                                     TO  HCML01-SEIBUTUGAKUKBN(CNT-LINE)
               END-EVALUATE     
      *        造影剤(造影補助剤) 
               EVALUATE  TNS-ZOEIZAIKBN
                   WHEN  "0"
                       MOVE  SPACE       TO  HCML01-ZOEIZAIKBN(CNT-LINE)
                   WHEN  "1"
                       MOVE  "造影剤"    TO  HCML01-ZOEIZAIKBN(CNT-LINE)
                   WHEN  "2"
                       MOVE  "造影補助"  TO  HCML01-ZOEIZAIKBN(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"  TO  HCML01-ZOEIZAIKBN(CNT-LINE)
               END-EVALUATE
      *        薬剤 
               EVALUATE  TNS-YKZKBN
                   WHEN  "1"
                       MOVE  "内用"      TO  HCML01-YKZKBN(CNT-LINE)
                   WHEN  "3"
                       MOVE  "その他"    TO  HCML01-YKZKBN(CNT-LINE)
                   WHEN  "4"
                       MOVE  "注射"      TO  HCML01-YKZKBN(CNT-LINE)
                   WHEN  "6"
                       MOVE  "外用"      TO  HCML01-YKZKBN(CNT-LINE)
                   WHEN  "8"
                       MOVE  "歯科薬剤"  TO  HCML01-YKZKBN(CNT-LINE)
                   WHEN  "9"
                       MOVE  "歯科特定"  TO  HCML01-YKZKBN(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"  TO  HCML01-YKZKBN(CNT-LINE)
               END-EVALUATE
      *        剤型 
               EVALUATE  TNS-ZAIGATAKBN
                   WHEN  "0"
                       MOVE  SPACE       TO  HCML01-ZAIGATAKBN(CNT-LINE)
                   WHEN  "1"
                       MOVE  "散剤"      TO  HCML01-ZAIGATAKBN(CNT-LINE)
                   WHEN  "2"
                       MOVE  "顆粒剤"    TO  HCML01-ZAIGATAKBN(CNT-LINE)
                   WHEN  "3"
                       MOVE  "液剤"      TO  HCML01-ZAIGATAKBN(CNT-LINE)
                   WHEN  OTHER
                       MOVE  "＊＊＊＊"  TO  HCML01-ZAIGATAKBN(CNT-LINE)
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
      *    ファイルＯＰＥＮ
           MOVE    "HCML"              TO  HC01PARA-FORM-ID
           MOVE    WRK-PARA-IYKCHK (IDX)
                                       TO  HC01PARA-FORM-ID (4:1)
           MOVE    WRK-PARA-TERMID     TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           MOVE    CNT-PAGE            TO  HC01PARA-CNT
           OPEN    OUTPUT               PRT-FILE
           WRITE  HCML01
           CLOSE                       PRT-FILE
      *
           MOVE   "HC01.sh"            TO  SHELL-ID
           MOVE   "HCML01.dia"         TO  SHELL-DIA
           MOVE   "HCML01.def"         TO  SHELL-DEF
           MOVE   HC01PARA             TO  SHELL-DAT
           MOVE   SYS-1031-PRTNM(6)    TO  SHELL-PRTNM 
      *   印刷用スクリプト処理
           MOVE  SHELL-NAME            TO  SHELLTBL-NAME
           MOVE  SHELL-ARG1            TO  SHELLTBL-ARG1
           MOVE  SHELL-ARG2            TO  SHELLTBL-ARG2
           MOVE  SHELL-ARG3            TO  SHELLTBL-ARG3
           MOVE  SHELL-ARG4            TO  SHELLTBL-ARG4
           MOVE  SHELL-ARG5            TO  SHELLTBL-ARG5
           MOVE  SHELLTBL              TO  MCPDATA-REC
           MOVE    "SHELL"             TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC                         
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
           OPEN    INPUT   RECEERR-FILE
      *     
           IF      STS-RECEERR         =   ZERO
               CONTINUE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
               WRITE   RECEERR-REC
           END-IF
      *
           CLOSE   RECEERR-FILE
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
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           INSPECT WRK-HENYMDG    REPLACING  ALL "  "  BY  "　"
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ　検索 
      *****************************************************************
       900-DBSELECT-SEC                 SECTION.
      *  
           INITIALIZE                  TNS-TENSU-REC
           MOVE    "600000000"         TO  TNS-SRYCD
           MOVE    "699999999"         TO  TNSUP-SRYCD 
           MOVE    WRK-PARA-IYKCHK (IDX)
                                       TO  TNS-YKZKBN
      *
           EVALUATE    WRK-PARA-CYUKBN ALSO    WRK-PARA-SYUKBN        
               WHEN    1               ALSO    1
                   MOVE    "TENSU-KEY11S"      TO  WRK-PATH 
               WHEN    1               ALSO    2
                   MOVE    "TENSU-KEY11M"      TO  WRK-PATH 
               WHEN    1               ALSO    3
                   MOVE    "TENSU-KEY11K"      TO  WRK-PATH
               WHEN    2               ALSO    1
                   MOVE    "TENSU-KEY11S1"     TO  WRK-PATH 
               WHEN    2               ALSO    2
                   MOVE    "TENSU-KEY11M1"     TO  WRK-PATH 
               WHEN    2               ALSO    3
                   MOVE    "TENSU-KEY11K1"     TO  WRK-PATH
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
               MOVE    1                   TO  FLG-TENSU
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
               MOVE    ZERO            TO  FLG-TENSU
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
           ELSE
               MOVE    1                       TO  FLG-TENSU
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
