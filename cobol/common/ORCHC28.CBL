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
       PROGRAM-ID.             ORCHC28.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者一覧印刷
      *  コンポーネント名  : 患者一覧印刷（ＨＣ２８）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/05/20    MCC-森脇      新規作成
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
      *     SELECT  RECEERR-FILE    ASSIGN  RECEERR
      *                             FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
           COPY    "HC28.INC".
      *
      *    エラーファイル
      * FD  RECEERR-FILE.
      * 01  RECEERR-REC             PIC X(200). 
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
      *     COPY    "CPCOMMONDAT2.INC"
      *                             REPLACING  //RECE01PARA//
      *                             BY         //RECEERR//.
      *     03                      PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *     03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-DAT             PIC 9(05).
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(03).
          
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).
      *
      *    一時領域
       01  WRK-AREA.             
      *     03  WRK-RECEERR           PIC X(200).   
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
           03  WRK-HENYMDGE.
               05  WRK-HEG1          PIC X(02).
               05  WRK-HEG2          PIC X(02).
               05  WRK-HEYY          PIC X(04).
               05  FILLER            PIC X(02).
               05  WRK-HEMM          PIC X(04).
               05  FILLER            PIC X(02).
               05  WRK-HEDD          PIC X(04).
               05  FILLER            PIC X(02).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(02).
               05  WRK-HYY         PIC X(04).
               05  WRK-CN1         PIC X(02).
               05  WRK-HMM         PIC X(04).
               05  WRK-CN2         PIC X(02).
               05  WRK-HDD         PIC X(04).
      *
      *     03  WRK-IN                PIC X.
      *
           03  WRK-PAGE              PIC ZZ,ZZ9.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者情報
       01  PTINF-REC.
           COPY  "CPPTINF.INC".
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       COPY    "COMMON-SPA".
       COPY  "CPORCHC28.INC".         
      *
      ******************************************************************
       PROCEDURE                       DIVISION
                                       USING     
                                       SPA-AREA
                                       ORCHC28AREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *             UNTIL       FLG-END     =   1
      *
      *     PERFORM 300-END-SEC
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
      *     MOVE    "RECEERR"           TO  RECEERR-FILE-ID
      *     MOVE    SPA-TERMID          TO  RECEERR-TERMID
      *
      *    パラメタ編集処理
      *     PERFORM 120-DBOPEN-SEC
           PERFORM 110-PARA-HENSYU-SEC
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
           MOVE    ZERO                TO  FLG-PTINF
           MOVE    ZERO                TO  CNT-AREA
           INITIALIZE                  CNT-AREA
      *
           IF ( ORCHC28-PTID-COUNT     =   ZERO )
      *        帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
      *
      *        帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
      *
               GO  TO  200-MAIN-EXT
           END-IF
      *
           PERFORM UNTIL   CNT-DAT  >=  ORCHC28-PTID-COUNT  
      *        帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
      *        帳票編集<明細>処理
               PERFORM UNTIL (CNT-LINE  >=  30)
                       OR  CNT-DAT  >=  ORCHC28-PTID-COUNT 
                   PERFORM 320-BODY-HEN-SEC
               END-PERFORM
      *        帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
           END-PERFORM
      *
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
           COMPUTE      CNT-PAGE  =    CNT-PAGE  +  1
      *
           INITIALIZE                      HC28
           MOVE    SPACE               TO  HC28
      *
           MOVE    SPA-SYSYMD          TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HC28-SAKUSEIBI
      *
           MOVE    CNT-PAGE            TO  WRK-PAGE
      *     MOVE    WRK-PAGE            TO  HC28-PAGE
      *
           MOVE  ORCHC28-HYODAI        TO  HC28-HYODAI
           MOVE  ORCHC28-JYOKEN1       TO  HC28-JYOKEN(1)
           MOVE  ORCHC28-JYOKEN2       TO  HC28-JYOKEN(2)
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
           COMPUTE      CNT-LINE  =    CNT-LINE  +  1 
           COMPUTE      CNT-DAT   =    CNT-DAT   +  1  
      *
           IF  ORCHC28-PTID-COUNT  =  0
               GO  TO   320-BODY-HEN-EXT
           END-IF
      *         
           MOVE  ORCHC28-PTID-SEQ(CNT-DAT)
                                     TO  HC28-CD(CNT-LINE)
      *
           PERFORM 900-DBREAD-SEC
      *
           IF  FLG-PTINF  =  ZERO
      *
               INITIALIZE                  ORCSPTIDAREA
               MOVE    SPA-HOSPID          TO  SPTID-HOSPID
               MOVE    PTINF-PTID          TO  SPTID-PTID
      *
               CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                                   SPA-1009-TBL
               IF      SPTID-RC            =   ZERO
                   MOVE    SPTID-PTNUM
                                     TO  HC28-PTNUM(CNT-LINE)
               END-IF
      *
      *
               MOVE  PTINF-NAME      TO  HC28-NAME(CNT-LINE)
               MOVE  PTINF-HOME-ADRS TO  HC28-JYUSYO(CNT-LINE)
               EVALUATE  PTINF-SEX 
                   WHEN  "1"
                       MOVE  "男"    TO  HC28-SEIBETU(CNT-LINE)
                   WHEN  "2"
                       MOVE  "女"    TO  HC28-SEIBETU(CNT-LINE)
               END-EVALUATE
      *            
               MOVE  PTINF-BIRTHDAY  TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG   TO  WRK-HENYMDGE
               MOVE    WRK-HEG1      TO  WRK-HGO
               MOVE    WRK-HEYY      TO  WRK-HYY
               MOVE    "．"          TO  WRK-CN1 
               MOVE    WRK-HEMM      TO  WRK-HMM
               MOVE    "．"          TO  WRK-CN2 
               MOVE    WRK-HEDD      TO  WRK-HDD
               MOVE    WRK-HENYMD    TO  HC28-TANJYOBI(CNT-LINE)
           END-IF
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
           MOVE    "HC28"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           MOVE    CNT-PAGE            TO  HC01PARA-CNT
           OPEN    OUTPUT              PRT-FILE
           WRITE   HC28
           CLOSE                       PRT-FILE
      *
           MOVE   "HC01.sh"            TO  SHELL-ID
           MOVE   "HC28.dia"           TO  SHELL-DIA
           MOVE   "HC28.def"           TO  SHELL-DEF
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
      *
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
      * 500-ERR-HENSYU-SEC                SECTION.
      *
      *     OPEN    INPUT   RECEERR-FILE
      *     
      *     IF      STS-RECEERR         =   ZERO
      *         CONTINUE
      *     ELSE
      *         OPEN    OUTPUT              RECEERR-FILE
      *
      *         MOVE    WRK-RECEERR         TO  RECEERR-REC
      *         WRITE   RECEERR-REC
      *     END-IF
      *
      *     CLOSE   RECEERR-FILE
      *
      *     MOVE    1               TO  FLG-END 
      * 
      *     .
      * 500-ERR-HENSYU-EXT.
      *     EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
      * 300-END-SEC                 SECTION.
      *
      *     PERFORM 900-DBDISCONNECT-SEC
      *
      *     .
      * 300-END-EXT.
      *     EXIT.
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
      *    患者マスタ　検索 
      *****************************************************************
       900-DBREAD-SEC                 SECTION.
      *
           INITIALIZE                     PTINF-REC
           MOVE    SPA-HOSPID             TO  PTINF-HOSPID
           MOVE    ORCHC28-PTID(CNT-DAT)  TO  PTINF-PTID
           MOVE    PTINF-REC              TO  MCPDATA-REC
           MOVE    "DBSELECT"             TO  MCP-FUNC
           MOVE    "PTINF-KEY"            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"            USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
           IF  MCP-RC  =  ZERO
               MOVE    "DBFETCH"          TO  MCP-FUNC
               MOVE    "PTINF-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"        USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
               IF  MCP-RC  =  ZERO
                   MOVE    ZERO            TO  FLG-PTINF
                   MOVE    MCPDATA-REC     TO  PTINF-REC
               ELSE
                   MOVE    1               TO  FLG-PTINF
               END-IF  
           ELSE
               MOVE    1                   TO  FLG-PTINF
           END-IF        
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "PTINF-KEY"             TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           .
       900-DBREAD-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
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
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
      * 120-DBOPEN-SEC                SECTION.
      *
      *     MOVE    "DBOPEN"            TO  MCP-FUNC.
      *     CALL    "ORCMCPSUB"          USING
      *                                  MCPAREA
      *                                  ORCMCPAREA
      *                                  MCPDATA-REC.
      *
      *     MOVE    "DBSTART"           TO  MCP-FUNC.
      *     CALL    "ORCMCPSUB"          USING
      *                                  MCPAREA
      *                                  ORCMCPAREA
      *                                  MCPDATA-REC.
      *     .
      * 120-DBOPEN-EXT.
      *     EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
      * 900-DBDISCONNECT-SEC            SECTION.
      *
      *     MOVE    "DBCOMMIT"          TO  MCP-FUNC.
      *     CALL    "ORCMCPSUB"          USING
      *                                  MCPAREA
      *                                  ORCMCPAREA
      *                                  MCPDATA-REC.
      *
      *     MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
      *     CALL    "ORCMCPSUB"          USING
      *                                  MCPAREA
      *                                  ORCMCPAREA
      *                                  MCPDATA-REC.
      *     .
      * 900-DBCLOSE-EXT.
      *     EXIT.
      *