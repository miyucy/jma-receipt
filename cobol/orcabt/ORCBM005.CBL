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
       PROGRAM-ID.             ORCBM005.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 請求帳票
      *  コンポーネント名  : 未請求患者一覧表（ＨＣ０５）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/03/05    MCC-森脇      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/05/22  テスト患者は処理しない     
      *                                     診療年月が違って請求年月が同じ時
      *                                     出力の対象とする
      *
      *  01.01.01    NACL-藤原    02.09.17  印刷サブの追加
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   FILE    STATUS  IS  STS-PARA.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
006900*    印刷用データ
       FD  PRT-FILE.
           COPY    "HC05.INC".
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *     
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE10          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01). 
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SEIKYU          PIC 9(01). 
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(03).
           03  CNT-IN              PIC 9(05).
           03  CNT-OUT             PIC 9(05).
           03  CNT-RENNUM          PIC 9(05). 
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).    
      *
      *    一時領域
       01  WRK-AREA.
      *****03  WRK-IN              PIC X(01).
      *
           03  WRK-PARA.
               05  WRK-PARA1.
                   07  WRK-PARA-SKYYM   PIC  X(06).
                   07  WRK-PARA-TERMID  PIC  X(16).
                   07  WRK-PARA-SYSYMD  PIC  X(08).
               05  WRK-PARA-HOSPID      PIC  X(24).
               05  WRK-PARA-TEISYUTUSAKI
                                        PIC  X(01).
               05  WRK-PARA-TERMID32    PIC  X(32).
      * 
           03  WRK-RECEERR           PIC X(200).        
      *
           03  WRK-SYSYMDWH          PIC X(22).
      *  
           03  WRK-HC01PARA-CNT      PIC  9(03).
      *
           03  WRK-MSG               PIC X(10). 
      *
           03  WRK-SRYYM             PIC X(16).     
      *
           03  WRK-SYMD.
               05  WRK-SYY           PIC 9(04).
               05  WRK-SMM           PIC 9(02).
               05  WRK-SDD           PIC 9(02).
           03  WRK-HENYMDG           PIC X(22).
      *
           03  WRK-PAGE              PIC ZZ9.
           03  WRK-RENNUM            PIC ZZZZ9.
           03  WRK-TEN               PIC ZZZ,ZZZ,ZZ9.
      *
      *    集計領域
       01  SUM-AREA                               VALUE   ZERO.
           03  SUM-GHKNTEN           PIC 9(08).
           03  SUM-GMONEY1           PIC 9(08).
           03  SUM-GMONEY2           PIC 9(08).
           03  SUM-RENNUM            PIC 9(05).
      *
      *    キー領域
       01  KEY-AREA                               VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-TEISYUTUSAKI    PIC 9(01).
           03  KEY-OLD.
               05  KEY-O-TEISYUTUSAKI    PIC 9(01).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    医療機関情報
           COPY  "CPSK1001.INC".
      *
      *    診療科目情報
           COPY    "CPSK1005.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY    "CPSK1031.INC".
      *
           COPY    "CPRCF010.INC".
      * 
      ******************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    印刷パラメタ
           COPY    "CPORCSMKPRT.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    共通パラメタ
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
                                       SUM-AREA
                                       CNT-AREA
      *
           ACCEPT  SYS-TIME            FROM    TIME     
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO  WRK-PARA1
                                             WRK-PARA-HOSPID
                                             WRK-PARA-TEISYUTUSAKI
                                             WRK-PARA-TERMID32 
      *
           PERFORM 100-DBOPEN-SEC
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
      *    システム日付の編集
           MOVE    WRK-PARA-SYSYMD     TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  WRK-SYSYMDWH   
      *
           MOVE    WRK-PARA-SKYYM      TO  WRK-SYMD(1:6)
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  WRK-SRYYM
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
      *
           PERFORM 900-SEIKYU-SELECT-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    ZERO            TO  SUM-AREA
                                       CNT-RENNUM
           MOVE    KEY-NEW         TO  KEY-OLD 
      *     
      *    帳票編集<見出し>処理
           PERFORM 310-HEAD-HEN-SEC
      *     
      *    帳票編集<明細>処理
           PERFORM             UNTIL   FLG-END     =   1
                               OR      KEY-NEW NOT =   KEY-OLD
               PERFORM 320-BODY-HEN-SEC
           END-PERFORM    
      *
      *    帳票編集<合計>処理
              PERFORM 330-SUM-HEN-SEC
      *
      *    帳票印刷処理
           PERFORM 390-PRINT-OUT-SEC
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
           MOVE    SPACE               TO  HC05
      *
           MOVE    WRK-SRYYM           TO  HC05-HSRYYM
           MOVE    WRK-SYSYMDWH        TO  HC05-SYSYMD
           MOVE    CNT-PAGE            TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  HC05-PAGE
      *
           EVALUATE    KEY-N-TEISYUTUSAKI
               WHEN    1
                   MOVE    "社保分"    TO  HC05-TEISYUTUNAME
               WHEN    2    
                   MOVE    "国保分"    TO  HC05-TEISYUTUNAME
           END-EVALUATE
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
           IF      CNT-LINE        >=  22
      *        帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
      *        帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
           END-IF                    
      *
           ADD     1                 TO  CNT-LINE
           ADD     1                 TO  CNT-RENNUM
      *
           MOVE    CNT-RENNUM        TO  WRK-RENNUM
           MOVE    WRK-RENNUM        TO  HC05-RENNUM(CNT-LINE)
      *
           MOVE    RECE10-PTNUM      TO  HC05-PTNUM(CNT-LINE)
      *
      **** MOVE    SPACE               TO  PTINF-REC
      *    INITIALIZE                      PTINF-REC
      *    MOVE    RECE10-HOSPID       TO  PTINF-HOSPID
      *    MOVE    RECE10-PTID         TO  PTINF-PTID
      *    MOVE    PTINF-REC           TO  MCPDATA-REC
      *    PERFORM 800-PTINF-READ-SEC
      *    IF      FLG-PTINF           =   ZERO 
               MOVE    PTINF-NAME          TO  HC05-NAME(CNT-LINE)
      *****END-IF    
      *
           MOVE    RECE10-HKNJANUM     TO  HC05-HKNJANUM(CNT-LINE)
      *
           MOVE    RECE10-SRYYM        TO  WRK-SYMD(1:6)
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  HC05-SRYYM(CNT-LINE)
      *
           MOVE    RECE10-HENREIYM     TO  WRK-SYMD(1:6)
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HC05-HENYM(CNT-LINE)
      *
           MOVE    RECE10-SKYYM        TO  WRK-SYMD(1:6)
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  HC05-SEIYM(CNT-LINE)
      *
           MOVE    RECE10-TOTALTEN(1)  TO  WRK-TEN
           MOVE    WRK-TEN             TO  HC05-HKNTEN(CNT-LINE)   
           MOVE    RECE10-TOTALTEN(2)  TO  WRK-TEN
           MOVE    WRK-TEN             TO  HC05-MONEY1(CNT-LINE)
           MOVE    RECE10-TOTALTEN(3)  TO  WRK-TEN
           MOVE    WRK-TEN             TO  HC05-MONEY2(CNT-LINE)
      *
           EVALUATE    RECE10-SKYKBN
               WHEN    "0"
                   MOVE    "請求しない"    TO  HC05-SKYKBN (CNT-LINE) 
               WHEN    "1"
                   MOVE    "未請求"        TO  HC05-SKYKBN (CNT-LINE) 
               WHEN    "2"
                   MOVE    "請求済み"      TO  HC05-SKYKBN (CNT-LINE) 
           END-EVALUATE            
      *
           IF      RECE10-SKYKBN       =   "1"
               MOVE    "未"                TO  HC05-MSG (CNT-LINE)
           END-IF
           IF      RECE10-SRYYM    NOT =   WRK-PARA-SKYYM
               MOVE    "他"                TO  HC05-MSG (CNT-LINE) (3:)
           END-IF
      *
           IF    ( RECE10-SKYKBN   NOT =   ZERO                     )
               IF    ( RECE10-SRYYM    =   WRK-PARA-SKYYM           )
               AND   ( RECE10-SKYYM    =   WRK-PARA-SKYYM  OR  ZERO )
                   MOVE    "※"                TO
                                               HC05-TAISYO(CNT-LINE)
                   ADD     1                   TO  SUM-RENNUM
                   ADD     RECE10-TOTALTEN(1)  TO  SUM-GHKNTEN
                   ADD     RECE10-TOTALTEN(2)  TO  SUM-GMONEY1
                   ADD     RECE10-TOTALTEN(3)  TO  SUM-GMONEY2
               ELSE
                   IF    ( RECE10-SKYKBN   NOT =   ZERO            )
                   AND   ( RECE10-SKYYM        =   WRK-PARA-SKYYM  )
                       MOVE    "※"                TO 
                                               HC05-TAISYO(CNT-LINE)
                       ADD     1                   TO  SUM-RENNUM
                       ADD     RECE10-TOTALTEN(1)  TO  SUM-GHKNTEN
                       ADD     RECE10-TOTALTEN(2)  TO  SUM-GMONEY1
                       ADD     RECE10-TOTALTEN(3)  TO  SUM-GMONEY2
                   END-IF
               END-IF
           END-IF        
      *
           ADD     1                   TO  CNT-OUT
      *         
      *    合計集計処理
      *
           PERFORM 900-SEIKYU-FETCH-SEC         
      *
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<合計部>処理
      *****************************************************************
       330-SUM-HEN-SEC          SECTION.
      *
           MOVE    SUM-RENNUM        TO  WRK-RENNUM
           MOVE    WRK-RENNUM        TO  HC05-GKENSU
           MOVE    SUM-GHKNTEN       TO  WRK-TEN
           MOVE    WRK-TEN           TO  HC05-GHKNTEN
           MOVE    SUM-GMONEY1       TO  WRK-TEN
           MOVE    WRK-TEN           TO  HC05-GMONEY1
           MOVE    SUM-GMONEY2       TO  WRK-TEN
           MOVE    WRK-TEN           TO  HC05-GMONEY2
      *
           .
       330-SUM-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC                SECTION.
      *
      *　　印刷用データ出力
      *
           ADD     1                   TO  WRK-HC01PARA-CNT 
           MOVE    "HC05"              TO  HC01PARA-FORM-ID
           MOVE    WRK-PARA-TERMID32   TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           MOVE    WRK-HC01PARA-CNT    TO  HC01PARA-CNT
      *
           OPEN    OUTPUT  PRT-FILE
           WRITE   HC05
           CLOSE                       PRT-FILE
      * 
      *****MOVE   "HC05.dia"           TO  SHELL-DIA
      *    MOVE   "HC05.def"           TO  SHELL-DEF
      *    MOVE   "HC01.sh"            TO  SHELL-ID
      *    MOVE   HC01PARA             TO  SHELL-DAT
      *****MOVE   SYS-1031-PRTNM(5)    TO  SHELL-PRTNM 
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
            MOVE   "HC05.dia"          TO  MKPRT-DIA
            MOVE   "HC05.def"          TO  MKPRT-DEF
            MOVE   HC01PARA            TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(5)   TO  MKPRT-PRTNM
            CALL   "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
      *****
      *    印刷用スクリプト処理
      *
      *    MOVE    SPACE           TO  SHELLTBL
      *    MOVE    SHELL-NAME      TO  SHELLTBL-NAME
      *    MOVE    SHELL-ARG1      TO  SHELLTBL-ARG1
      *    MOVE    SHELL-ARG2      TO  SHELLTBL-ARG2
      *    MOVE    SHELL-ARG3      TO  SHELLTBL-ARG3
      *    MOVE    SHELL-ARG4      TO  SHELLTBL-ARG4
      *    MOVE    SHELL-ARG5      TO  SHELLTBL-ARG5
      *
      *    MOVE    SHELLTBL        TO  MCPDATA-REC
      *    MOVE    "SHELL"         TO  MCP-FUNC
      *    MOVE    PATH-SHELL-SHELL
      *                            TO  MCP-PATH
      *    CALL    "MCPSUB"        USING
      *                                MCPAREA
      *****                            MCPDATA-REC                         
           .
       390-PRINT-OUT-EXT.
           EXIT.
057400*
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
      *
           OPEN    INPUT   RECEERR-FILE
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
      *
           PERFORM 900-SEIKYU-CLOSE-SEC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           DISPLAY "*** ORCBM005 IN  "  CNT-IN
           DISPLAY "***          OUT "  CNT-OUT 
           DISPLAY "*** ORCBM005 END ***"
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC        SECTION.
      *
           IF      WRK-SYMD            =   ZERO   OR  SPACE
                MOVE    SPACE              TO  WRK-HENYMDG
           ELSE    
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
               INSPECT WRK-HENYMDG    REPLACING  ALL "  "  BY  "　"
           END-IF    
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスタ読込
      *****************************************************************
       800-PTINF-READ-SEC         SECTION.
      *
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
                   MOVE    ZERO                TO  FLG-PTINF
                   MOVE    MCPDATA-REC         TO  PTINF-REC
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
       800-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       800-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    WRK-PARA-SYSYMD     TO  ORC-DBYMD
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
       800-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理マスタ読込
      *****************************************************************
       900-SEIKYU-SELECT-SEC                 SECTION.
      *
           MOVE    SPACE                TO  RECE10-REC  
           MOVE    WRK-PARA-HOSPID      TO  RECE10-HOSPID
           MOVE    WRK-PARA-SKYYM       TO  RECE10-SKYYM
           MOVE    RECE10-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"           TO  MCP-FUNC
           MOVE    "SEIKYU-KEY5"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               PERFORM 900-SEIKYU-FETCH-SEC
           ELSE
               MOVE    1                   TO  FLG-END
               MOVE    HIGH-VALUE          TO  KEY-NEW 
           END-IF
           .
       900-SEIKYU-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理マスタ 検索処理
      *****************************************************************
       900-SEIKYU-FETCH-SEC                SECTION.
      *           
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    "SEIKYU-KEY5"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-END
               MOVE    MCPDATA-REC         TO  RECE10-REC
               EVALUATE    WRK-PARA-TEISYUTUSAKI
                   WHEN    ZERO
                       CONTINUE
                   WHEN    1
                   WHEN    2
                       IF      RECE10-TEISYUTUSAKI NOT =
                                               WRK-PARA-TEISYUTUSAKI
                           GO  TO  900-SEIKYU-FETCH-SEC
                       END-IF
               END-EVALUATE                                        
      *
      *        テスト患者のときは読み飛ばす
               MOVE    SPACE               TO  PTINF-REC
               INITIALIZE                      PTINF-REC
               MOVE    RECE10-HOSPID       TO  PTINF-HOSPID
               MOVE    RECE10-PTID         TO  PTINF-PTID
               MOVE    PTINF-REC           TO  MCPDATA-REC
               PERFORM 800-PTINF-READ-SEC
               IF      FLG-PTINF           =   ZERO
               AND     PTINF-TSTPTNUMKBN   =   "1"
                   GO  TO  900-SEIKYU-FETCH-SEC
               END-IF
      *         
               MOVE    RECE10-TEISYUTUSAKI TO  KEY-N-TEISYUTUSAKI
               ADD     1                   TO  CNT-IN
           ELSE
               MOVE    1                   TO  FLG-END 
               MOVE    HIGH-VALUE          TO  KEY-NEW
           END-IF  
           .
       900-SEIKYU-FETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理マスタ クローズ処理
      *****************************************************************
       900-SEIKYU-CLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           MOVE    "SEIKYU-KEY5"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       900-SEIKYU-CLOSE-EXT.
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
