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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGXC01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 総括データ確認
      *  コンポーネント名  : 総括データ確認（ＸＣ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/05/30    MCC−門脇　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    レセプト明細ファイル シェル領域 
           COPY    "CPCOMMONSHELL1.INC".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    未請求一覧印刷処理共通パラメタ
           COPY    "XC01COMMON-SPA".
      *
       01  SPA-XC01.
           03  SPA-XC01-AREA.
               05  SPA-GMN-PAGE                    PIC 9(02).
               05  SPA-GMN-MAX                     PIC 9(04).
               05  SPA-GMN-CUR                     PIC 9(02).
      *
               05  SPA-GMN-COMBO-COUNT
                                                   PIC 9(02). 
               05  SPA-GMN-SEIKYU-COUNT
                                                   PIC 9(04). 
               05  SPA-GMN-SEIKYU-SCOUNT
                                                   PIC 9(04). 
               05  SPA-GMN-SEIKYU-ECOUNT
                                                   PIC 9(04). 
               05  SPA-GMN-ATOPAGE                 PIC 9(02). 
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-HSKYYM              PIC X(22).
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-OCC             OCCURS  200.
                           11  SPA-GMN-TSELNUM     PIC 9(04).
                           11  SPA-GMN-TPTNUM      PIC X(20).
                           11  SPA-GMN-TNAME       PIC X(30).
                           11  SPA-GMN-TTEISYUTUSAKI
                                                   PIC X(06).
                           11  SPA-GMN-THKNJANUM   PIC X(08).
                           11  SPA-GMN-TSRYYM      PIC X(06).
                           11  SPA-GMN-TTOTALTEN   PIC X(10).
                           11  SPA-GMN-TTOTALTEN1  PIC X(10).
                           11  SPA-GMN-TTOTALTEN2  PIC X(10).
                           11  SPA-GMN-THENREIYM   PIC X(06).
                           11  SPA-GMN-TSKYYM      PIC X(06).
                           11  SPA-GMN-TSKYKBN-G.
                               13  SPA-GMN-TSKYKBN PIC X(01).
                               13  SPA-GMN-TFILLER PIC X(01).
                               13  SPA-GMN-TSKYKBNMEI
                                                   PIC X(10).
                   07  SPA-GMN-BODY.        
                       09  SPA-GMN-SELNUM          PIC 9(04).
                       09  SPA-GMN-BODY1.
                           11  SPA-GMN-PTNUM       PIC X(20).
                           11  SPA-GMN-NAME        PIC X(30).
                           11  SPA-GMN-TEISYUTUSAKI
                                                   PIC X(06).
                           11  SPA-GMN-HKNJANUM    PIC X(08).
                           11  SPA-GMN-HKNJANAME   PIC X(40).
                           11  SPA-GMN-SRYYM       PIC X(06).
                           11  SPA-GMN-TOTALTEN    PIC X(10).
                           11  SPA-GMN-TOTALTEN1   PIC X(10).
                           11  SPA-GMN-TOTALTEN2   PIC X(10).
                           11  SPA-GMN-HENREIYM    PIC X(06).
                           11  SPA-GMN-SKYYM       PIC X(06).
                           11  SPA-GMN-SKYKBN-G.
                               13  SPA-GMN-SKYKBNG PIC X(01).
                               13  SPA-GMN-FILLERG PIC X(01).
                               13  SPA-GMN-SKYKBNMEIG
                                                   PIC X(10).
      * 
                       09  SPA-UPDFLG              PIC X(01).
      *
                   07  SPA-GMN-SKYKBNCOMBO         OCCURS    3.
                       09  SPA-GMN-SKYKBN          PIC X(01).
                       09  SPA-GMN-FILLER          PIC X(01).
                       09  SPA-GMN-SKYKBNMEI
                                                   PIC X(10).
      *                   
               05  SPA-NAI-AREA.
                   07  SPA-NAI-SELNUM              PIC 9(04).  
                   07  SPA-NAI-HENREIYM            PIC X(06).
                   07  SPA-NAI-SKYYM               PIC X(06).
                   07  SPA-NAI-SKYKBN              PIC X(01).
      *
               05  SPA-NAI-AREA2.
                   07  SPA-NAI-OCC                 OCCURS  200.
                      09  SPA-RECE10-KEY.   
                       11  SPA-RECE10-HOSPID       PIC  X(24).
                       11  SPA-RECE10-SRYYM        PIC  9(06).
                       11  SPA-RECE10-NYUGAIKBN    PIC  X(01).
                       11  SPA-RECE10-PTID         PIC  9(10).
                       11  SPA-RECE10-RECEKA       PIC  X(02).
                       11  SPA-RECE10-TEISYUTUSAKI PIC  9(01).
                       11  SPA-RECE10-RECESYUBETU  PIC  X(04).
                       11  SPA-RECE10-HKNJANUM     PIC  X(08).
                       11  SPA-RECE10-TEKSTYMD     PIC  X(08).
                      09  SPA-NAI-SRYYM            PIC  X(06).
      *
      *   
           COPY    "ENUM-VALUE".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-PTINF                           PIC 9(01).
           03  FLG-SEIKYU                          PIC 9(01).
           03  FLG-SEIKYU2                         PIC 9(01).
           03  FLG-HKNJAINF                        PIC 9(01).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
           03  SYS-TIME            PIC X(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR         PIC X(200).
           03  WRK-XCIDMSG         PIC X(70).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SELNUM          PIC 9(04).
           03  WRK-SELNUM2         PIC 9(04). 
      *
           03  WRK-TOTALTEN        PIC ZZ,ZZZ,ZZ9.
           03  WRK-GMN-PAGE        PIC 9(02).
      *
       01  WRK-HEN-AREA.
           03  WRK-HEN-SELNUM      PIC ZZZ9. 
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
           03  WRK-HENYMD3G        PIC X(22).
           03  WRK-HENTIME.
               05  WRK-HH          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-MM          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-SS          PIC X(02).
      *
       01  WRK-KOTEI-AREA.
           03  WRK-OCC             PIC 9(03)   VALUE    200.     
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".
      *
      **> 01  WRK-LNK-AREA.
      **>     COPY    "CPORCSPRTLNK.INC".   
      *              
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *    請求管理
           COPY    "CPRCF010.INC".
      *    保険マスタ
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *   ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           COPY    "XC01.INC".
           COPY    "XCERR.INC".
           COPY    "XCID1.INC".
      *
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
           MOVE    SPA-FREE        TO  SPA-XC01
           MOVE    SPA-WORK        TO  SPA-XC01KYOUTU 
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN     "LINK"         ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"         ALSO   "CLICKED"
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
           MOVE    SPA-XC01KYOUTU  TO  SPA-WORK  
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-XC01        TO  SPA-FREE
      *
           .
           EXIT    PROGRAM.
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "XCERR"
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
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "XC01"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           EVALUATE    SPA-MOTOPG
               WHEN    "XCID1"
                   PERFORM 330-XCID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *    他のＬＤより
           IF      LNK-KYOUTU      NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           END-IF
      *
           MOVE    1               TO  WRK-GMN-PAGE
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
           INITIALIZE              SPA-XC01-AREA
                                   SPA-XC01KYOUTU
      *
           MOVE    WRK-GMN-PAGE               TO  SPA-GMN-PAGE
      *  
      *    請求月の編集
           MOVE    SPA-PRTKANRI-TBL-KEY(1:6)  TO  WRK-SYMD(1:6)
           MOVE    "01"                       TO  WRK-SYMD(7:2)
           IF      WRK-SYMD (1:6)          =   ZERO    OR  SPACE
               MOVE    SPACE                   TO  WRK-HENYMD3G
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMD3G
           END-IF
           MOVE    WRK-HENYMD3G(1:16)  TO  SPA-GMN-HSKYYM(1:16)  
           MOVE    "請求分"            TO  SPA-GMN-HSKYYM(17:6)
      *
           MOVE    "0"                 TO  SPA-GMN-SKYKBN    (1)
           MOVE    "請求しない"        TO  SPA-GMN-SKYKBNMEI (1)
           MOVE    "1"                 TO  SPA-GMN-SKYKBN    (2)
           MOVE    "未請求"            TO  SPA-GMN-SKYKBNMEI (2)
           MOVE    "2"                 TO  SPA-GMN-SKYKBN    (3)
           MOVE    "請求済"            TO  SPA-GMN-SKYKBNMEI (3)
      *                                 
      *
           PERFORM   900-SEIKYU-SELECT-SEC    
      *
           MOVE      ZERO              TO  IDX
           PERFORM   UNTIL     (FLG-SEIKYU        =   1         )  OR
                               (IDX              >=  WRK-OCC    )
      *  
             ADD     1                   TO  IDX
             MOVE    RECE10-KEY          TO  SPA-RECE10-KEY (IDX)
      *
             COMPUTE WRK-SELNUM  = (( SPA-GMN-PAGE - 1 ) * WRK-OCC ) 
                                 +    IDX  
             MOVE    WRK-SELNUM          TO  SPA-GMN-TSELNUM(IDX)
      *
             MOVE    RECE10-PTNUM        TO  SPA-GMN-TPTNUM (IDX)
             MOVE    PTINF-NAME          TO  SPA-GMN-TNAME  (IDX)
      *
             EVALUATE    RECE10-TEISYUTUSAKI
                 WHEN    1
                     MOVE    "社保分"    TO  SPA-GMN-TTEISYUTUSAKI(IDX)
                 WHEN    2    
                     MOVE    "国保分"    TO  SPA-GMN-TTEISYUTUSAKI(IDX)
             END-EVALUATE
             MOVE    RECE10-HKNJANUM     TO  SPA-GMN-THKNJANUM(IDX)
      *
             MOVE    RECE10-SRYYM        TO  WRK-SYMD(1:6)
             MOVE    "01"                TO  WRK-SYMD(7:2)
             IF      WRK-SYMD (1:6)          =   ZERO    OR  SPACE
                 MOVE    SPACE                   TO  WRK-HENYMDG
             ELSE
                 INITIALIZE                      STS-AREA-DAY
                 INITIALIZE                      LNK-DAY2-AREA
                 MOVE    "21"                TO  LNK-DAY2-IRAI
                 MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
                 CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                      LNK-DAY2-AREA
                 MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
             END-IF
             MOVE    WRK-HENYMDG(1:6)    TO  SPA-GMN-TSRYYM(IDX)   
      *
             MOVE    RECE10-SRYYM        TO  SPA-NAI-SRYYM (IDX)
      *
             MOVE    RECE10-TOTALTEN(1)  TO  SPA-GMN-TTOTALTEN (IDX)
             MOVE    RECE10-TOTALTEN(2)  TO  SPA-GMN-TTOTALTEN1(IDX)
             MOVE    RECE10-TOTALTEN(3)  TO  SPA-GMN-TTOTALTEN2(IDX)
      *
             MOVE    RECE10-HENREIYM     TO  WRK-SYMD(1:6)
             MOVE    "01"                TO  WRK-SYMD(7:2)
             IF      WRK-SYMD (1:6)          =   ZERO    OR  SPACE
                 MOVE    SPACE                   TO  WRK-HENYMDG
             ELSE
                 INITIALIZE                      STS-AREA-DAY
                 INITIALIZE                      LNK-DAY2-AREA
                 MOVE    "21"                TO  LNK-DAY2-IRAI
                 MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
                 CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                      LNK-DAY2-AREA
                 MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
             END-IF
             MOVE    WRK-HENYMDG(1:6)    TO  SPA-GMN-THENREIYM(IDX)
      *
             MOVE    RECE10-SKYYM        TO  WRK-SYMD(1:6)
             MOVE    "01"                TO  WRK-SYMD(7:2)
             IF      WRK-SYMD (1:6)          =   ZERO    OR  SPACE
                 MOVE    SPACE                   TO  WRK-HENYMDG
             ELSE
                 INITIALIZE                      STS-AREA-DAY
                 INITIALIZE                      LNK-DAY2-AREA
                 MOVE    "21"                TO  LNK-DAY2-IRAI
                 MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
                 CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                      LNK-DAY2-AREA
                 MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
             END-IF
             MOVE    WRK-HENYMDG(1:6)    TO  SPA-GMN-TSKYYM(IDX)
      *    
             MOVE    RECE10-SKYKBN       TO  SPA-GMN-TSKYKBN(IDX)
             PERFORM VARYING     IDY     FROM    1   BY  1
                                           UNTIL     IDY   >   3  
                    IF   SPA-GMN-SKYKBN(IDY)  =  RECE10-SKYKBN  
                        MOVE  SPA-GMN-SKYKBNMEI(IDY) 
                                         TO  SPA-GMN-TSKYKBNMEI(IDX)
                        MOVE    99       TO  IDY   
                    END-IF
             END-PERFORM
      *
             PERFORM 900-SEIKYU-FETCH-SEC
      *
           END-PERFORM
      *
           IF        IDX   =   WRK-OCC
               IF   FLG-SEIKYU     =   ZERO  
                   MOVE     1    TO   SPA-GMN-ATOPAGE
               ELSE
                   MOVE   ZERO   TO   SPA-GMN-ATOPAGE
               END-IF 
           ELSE  
                   MOVE   ZERO   TO   SPA-GMN-ATOPAGE
           END-IF  
      *
           PERFORM   900-SEIKYU-CLOSE-SEC                                             *                                 
           MOVE    IDX                 TO  SPA-GMN-MAX
           MOVE    1                   TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-MAX  =  ZERO
           AND     SPA-GMN-PAGE =  1   
                MOVE    "0007"         TO  SPA-ERRCD
           END-IF
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-XCID1-SET-SEC            SECTION.
      *
           IF      SPA-XCID1-FLG    =   "OK"
               EVALUATE    SPA-XCIDCD
                   WHEN    "1001"
                       PERFORM 450-PRINT-SEC
                   WHEN    "1002"
                       PERFORM 430-KOSIN-SEC
               END-EVALUATE
               MOVE    1               TO  SPA-GMN-CUR
           ELSE  
               EVALUATE    SPA-XCIDCD
                   WHEN    "1001"
                       MOVE    1               TO  SPA-GMN-CUR
                   WHEN    "1002"
                       MOVE    2               TO  SPA-GMN-CUR
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE           TO  SPA-XCID1-FLG
           MOVE    SPACE           TO  SPA-XCIDCD
           .
       330-XCID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *     戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE   "CHANGE"         TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *     クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 420-CLEAR-SEC
      *     前ページ
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 420-MAEPAGE-SEC
      *     次ページ
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 420-ATOPAGE-SEC
      *     印刷
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 450-PRINT-GID-SEC
      *     更新
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 430-KOSIN-GID-SEC
      
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 201-SELNUM-SEC
               WHEN    "ACTIVATE"      ALSO    "HENREIYM"
                   PERFORM 202-HENREIYM-SEC
               WHEN    "ACTIVATE"      ALSO    "SKYYM"
                   PERFORM 203-SKYYM-SEC
               WHEN    "ACTIVATE"      ALSO    "SKYKBN"
                   PERFORM 204-SKYKBN-SEC
      *        行選択
               WHEN    ANY             ALSO    "SOUKATULST"
                   PERFORM 205-SELECT-SEC
           END-EVALUATE
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号入力処理
      *****************************************************************
       201-SELNUM-SEC                 SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           INITIALIZE                  SPA-GMN-BODY
      *      
           MOVE    XC01-SELNUM         TO  SPA-GMN-SELNUM 
           MOVE    ZERO                TO  SPA-NAI-SELNUM 
      *     
           IF      SPA-GMN-SELNUM      =   ZERO
                   MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               COMPUTE WRK-SELNUM  = (( SPA-GMN-PAGE - 1 ) * WRK-OCC ) 
                                 +    1  
               COMPUTE WRK-SELNUM2 = (( SPA-GMN-PAGE - 1 ) * WRK-OCC ) 
                                 +    SPA-GMN-MAX  
               IF       SPA-GMN-SELNUM >= WRK-SELNUM
               AND      SPA-GMN-SELNUM <= WRK-SELNUM2
                   MOVE  SPA-GMN-SELNUM    TO  SPA-NAI-SELNUM 
                   PERFORM 2011-SELECT-HENSYU-SEC
               ELSE
                   MOVE    "0001"          TO  SPA-ERRCD
               END-IF    
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    2                   TO  SPA-GMN-CUR
           END-IF    
           .
       201-SELNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者検索処理
      *****************************************************************
       2011-SELECT-HENSYU-SEC        SECTION.
      *
           COMPUTE WRK-SELNUM =       SPA-NAI-SELNUM
                              -    (( SPA-GMN-PAGE - 1 ) * WRK-OCC ) 
           MOVE    WRK-SELNUM                   TO  IDX
      *     
           MOVE    SPA-GMN-TPTNUM       (IDX)   TO  SPA-GMN-PTNUM
           MOVE    SPA-GMN-TNAME        (IDX)   TO  SPA-GMN-NAME
           MOVE    SPA-GMN-TTEISYUTUSAKI(IDX)   TO  SPA-GMN-TEISYUTUSAKI
           MOVE    SPA-GMN-THKNJANUM    (IDX)   TO  SPA-GMN-HKNJANUM
      *
           PERFORM 900-HKNJAINF-INV-SEC
           MOVE    HKNJA-HKNJANAME              TO  SPA-GMN-HKNJANAME
      *
           MOVE    SPA-GMN-TSRYYM       (IDX)   TO  SPA-GMN-SRYYM
           MOVE    SPA-GMN-TTOTALTEN    (IDX)   TO  SPA-GMN-TOTALTEN
           MOVE    SPA-GMN-TTOTALTEN1   (IDX)   TO  SPA-GMN-TOTALTEN1
           MOVE    SPA-GMN-TTOTALTEN2   (IDX)   TO  SPA-GMN-TOTALTEN2
           MOVE    SPA-GMN-THENREIYM    (IDX)   TO  SPA-GMN-HENREIYM
           MOVE    SPA-GMN-TSKYYM       (IDX)   TO  SPA-GMN-SKYYM
           MOVE    SPA-GMN-TSKYKBN      (IDX)   TO  SPA-GMN-SKYKBNG
           MOVE    SPA-GMN-TSKYKBNMEI   (IDX)   TO  SPA-GMN-SKYKBNMEIG
           .
       2011-SELECT-HENSYU-EXT.
           EXIT.
           .
      *
      *****************************************************************
      *    返戻年月　入力処理
      *****************************************************************
       202-HENREIYM-SEC          SECTION.
      *
           MOVE    2               TO  SPA-GMN-CUR
      *
           MOVE    XC01-HENREIYM   TO  SPA-GMN-HENREIYM
           MOVE    SPACE           TO  SPA-NAI-HENREIYM
      *
           IF      SPA-GMN-HENREIYM =   SPACE
               CONTINUE
           ELSE
      *    日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    "1"                 TO  SGDAY-INTYPE
               MOVE    SPA-GMN-HENREIYM    TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY(1:6)
                                       TO  SPA-GMN-HENREIYM
                   MOVE    SGDAY-SDAY (1:6)
                                       TO  SPA-NAI-HENREIYM
      *
                   COMPUTE WRK-SELNUM =  SPA-NAI-SELNUM
                                  -  (( SPA-GMN-PAGE - 1 ) * WRK-OCC )
      *
                   IF      SPA-NAI-HENREIYM
                                  <   SPA-NAI-SRYYM (WRK-SELNUM)
                       MOVE    "0002"          TO  SPA-ERRCD
                   END-IF
               ELSE
                   MOVE    "0002"          TO  SPA-ERRCD
               END-IF
           END-IF
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    3               TO  SPA-GMN-CUR
           END-IF
           .
       202-HENREIYM-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求年月　入力処理
      *****************************************************************
       203-SKYYM-SEC          SECTION.
      *
           MOVE    3               TO  SPA-GMN-CUR
      *
           MOVE    XC01-SKYYM      TO  SPA-GMN-SKYYM
           MOVE    SPACE           TO  SPA-NAI-SKYYM
      *
           IF      SPA-GMN-SKYYM    =   SPACE
              CONTINUE
           ELSE 
      *    日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    "1"                 TO  SGDAY-INTYPE
               MOVE    SPA-GMN-SKYYM       TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY(1:6)
                                           TO  SPA-GMN-SKYYM
                   MOVE    SGDAY-SDAY (1:6)
                                           TO  SPA-NAI-SKYYM
      *
                   COMPUTE WRK-SELNUM =  SPA-NAI-SELNUM
                                  -  (( SPA-GMN-PAGE - 1 ) * WRK-OCC )
      *
                   IF      SPA-NAI-SKYYM
                                  <   SPA-NAI-SRYYM (WRK-SELNUM)
                       MOVE    "0003"          TO  SPA-ERRCD
                   END-IF
               ELSE
                   MOVE    "0003"          TO  SPA-ERRCD
               END-IF
           END-IF
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    4               TO  SPA-GMN-CUR
           END-IF
           .
       203-SKYYM-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求区分入力処理
      *****************************************************************
       204-SKYKBN-SEC             SECTION.
      *
           MOVE    4                   TO  SPA-GMN-CUR
      *
           MOVE    XC01-SKYKBN         TO  SPA-GMN-SKYKBN-G
           MOVE    SPACE               TO  SPA-NAI-SKYKBN
      * 
           PERFORM VARYING     IDX     FROM    1   BY  1
                                           UNTIL     IDX   >   3  
                    IF   SPA-GMN-SKYKBN(IDX)  =  SPA-GMN-SKYKBNG  
                        MOVE  SPA-GMN-SKYKBN(IDX) 
                                         TO  SPA-NAI-SKYKBN
                        MOVE  SPA-GMN-SKYKBNMEI(IDX) 
                                         TO  SPA-GMN-SKYKBNMEIG
                        MOVE  99         TO  IDX   
                    ELSE
                        MOVE  SPACE      TO  SPA-GMN-SKYKBNMEIG    
                    END-IF
           END-PERFORM
           IF      SPA-GMN-SKYKBNMEIG    =   SPACE
              MOVE    "0004"       TO  SPA-ERRCD
           END-IF       
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    2               TO  SPA-GMN-CUR
           END-IF
           .
       204-SKYKBN-EXT.
           EXIT.     
      *     
      *****************************************************************
      *    行選択処理
      *****************************************************************
       205-SELECT-SEC               SECTION.
      *          
      *    行選択
           MOVE    ZERO                TO  WRK-SELNUM
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
      *
             IF      XC01-SOUKATULST-SELECT (IDX)   =   "T"
      *
                COMPUTE WRK-SELNUM2 = (( SPA-GMN-PAGE - 1 ) * WRK-OCC ) 
                                    +    IDX  
                IF      WRK-SELNUM2 =   SPA-NAI-SELNUM
                       CONTINUE
                ELSE        
                       MOVE    WRK-SELNUM2     TO  WRK-SELNUM
                       MOVE    SPA-GMN-MAX     TO  IDX
                END-IF
      *
             END-IF    
      *
           END-PERFORM
      *
           IF      WRK-SELNUM          >   ZERO
               MOVE    WRK-SELNUM          TO  SPA-NAI-SELNUM
           END-IF
      *
           INITIALIZE                  SPA-GMN-BODY
      *
           MOVE    SPA-NAI-SELNUM      TO  SPA-GMN-SELNUM
      *
      *
           PERFORM 2011-SELECT-HENSYU-SEC
      *
           MOVE    2                   TO  SPA-GMN-CUR         
           .
       205-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *        
           MOVE    SPA-MOTOPG2         TO  SPA-SAKIPG
           MOVE    "XC01"              TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  SPA-WORK 
           INITIALIZE                  SPA-KYOTUKEY
                                       SPA-KYOTU-SET
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア処理
      *****************************************************************
       420-CLEAR-SEC                SECTION.
      *
           INITIALIZE               SPA-GMN-BODY
                                    SPA-NAI-AREA
      *
           MOVE    1                TO  SPA-GMN-CUR        
      *
           .
       420-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    前ページ処理
      *****************************************************************
       420-MAEPAGE-SEC                SECTION.
      *
           IF       SPA-GMN-PAGE  =  1
                MOVE    "0006"          TO  SPA-ERRCD
                GO  TO  420-MAEPAGE-EXT
           ELSE
                COMPUTE  WRK-GMN-PAGE  =  SPA-GMN-PAGE  -  1
           END-IF
      *  
           PERFORM 310-SPASET-SEC
      *       
           .
       420-MAEPAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次ページ処理
      *****************************************************************
       420-ATOPAGE-SEC                SECTION.
      *
           IF       SPA-GMN-ATOPAGE  =  ZERO
                MOVE    "0008"          TO  SPA-ERRCD
                GO  TO  420-ATOPAGE-EXT
           ELSE
                COMPUTE  WRK-GMN-PAGE  =  SPA-GMN-PAGE  +  1
           END-IF
      *  
           PERFORM 310-SPASET-SEC
      *
           .
       420-ATOPAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       430-KOSIN-GID-SEC                SECTION.
      *
           MOVE    SPACE           TO  SPA-UPDFLG
      *     
           IF      SPA-NAI-SELNUM      =   ZERO
                   MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               COMPUTE WRK-SELNUM  = (( SPA-GMN-PAGE - 1 ) * WRK-OCC ) 
                                 +    1  
               COMPUTE WRK-SELNUM2 = (( SPA-GMN-PAGE - 1 ) * WRK-OCC ) 
                                 +    SPA-GMN-MAX  
               IF       SPA-NAI-SELNUM >= WRK-SELNUM
               AND      SPA-NAI-SELNUM <= WRK-SELNUM2
                   CONTINUE 
               ELSE
                   MOVE    "0001"          TO  SPA-ERRCD
               END-IF    
           END-IF
      *
           IF      SPA-ERRCD       NOT =   SPACE                 
               GO  TO  430-KOSIN-GID-EXT               
           END-IF
      *
           PERFORM    202-HENREIYM-SEC
           IF      SPA-ERRCD       NOT =   SPACE                 
               GO  TO  430-KOSIN-GID-EXT               
           END-IF
      *
           PERFORM    203-SKYYM-SEC
           IF      SPA-ERRCD       NOT =   SPACE                 
               GO  TO  430-KOSIN-GID-EXT               
           END-IF
      * 
           PERFORM    204-SKYKBN-SEC 
           IF      SPA-ERRCD       NOT =   SPACE                 
               GO  TO  430-KOSIN-GID-EXT               
           END-IF
      *
           IF      SPA-UPDFLG          =   SPACE
               MOVE    "0005"              TO  SPA-ERRCD
               MOVE     2                  TO  SPA-GMN-CUR 
           END-IF
           IF      SPA-ERRCD       NOT =   SPACE                 
               GO  TO  430-KOSIN-GID-EXT               
           END-IF
      *     
      *    ガイドメッセージセット
           MOVE    "1002"              TO  SPA-XCIDCD
      *
           .
       430-KOSIN-GID-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       430-KOSIN-SEC                SECTION.
      *
      *    更新済
           MOVE    SPACE           TO  SPA-UPDFLG
      *
           MOVE    SPACE           TO  RECE10-REC   
           INITIALIZE                  RECE10-REC
      *
           COMPUTE WRK-SELNUM =       SPA-NAI-SELNUM
                              -    (( SPA-GMN-PAGE - 1 ) * WRK-OCC ) 
      *
           MOVE    SPA-RECE10-KEY (WRK-SELNUM)
                                   TO  RECE10-KEY
      *
           PERFORM 910-SEIKYU-INV-SEC
           IF      FLG-SEIKYU2          =   ZERO
               MOVE    MCPDATA-REC         TO  RECE10-REC
           ELSE
               MOVE    "1001"              TO  SPA-ERRCD
               GO  TO  430-KOSIN-EXT
           END-IF
      *
           MOVE    SPA-NAI-HENREIYM       TO  RECE10-HENREIYM
           MOVE    SPA-NAI-SKYYM          TO  RECE10-SKYYM           
           MOVE    SPA-NAI-SKYKBN         TO  RECE10-SKYKBN
      *
           MOVE    SPA-SYSYMD             TO  RECE10-UPDYMD
      *
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC      
      *
           IF      MCP-RC     =   ZERO
               MOVE    1               TO  SPA-GMN-CUR
               INITIALIZE                  SPA-GMN-AREA
                                           SPA-NAI-AREA
                                           SPA-NAI-AREA2
           ELSE
               MOVE    "1001"          TO  SPA-ERRCD
               GO  TO  430-KOSIN-EXT
           END-IF
      *
           MOVE    1               TO  WRK-GMN-PAGE
      *     
           PERFORM 310-SPASET-SEC
           .
       430-KOSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    作表処理
      *****************************************************************
       450-PRINT-GID-SEC                SECTION.
      *
           IF    (  SPA-NAI-SELNUM    NOT  =   ZERO  )
           OR    (  SPA-GMN-SELNUM    NOT  =   ZERO  )
               MOVE    "0009"          TO  SPA-ERRCD
           END-IF
      *
           IF      SPA-ERRCD       NOT =   SPACE                 
               GO  TO  450-PRINT-GID-EXT               
           END-IF
      *
      *    ガイドメッセージセット
           MOVE    "1001"              TO  SPA-XCIDCD
      *
           .
       450-PRINT-GID-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷編集処理
      *****************************************************************
       450-PRINT-SEC                   SECTION.
      * 
           MOVE    SPACE               TO  SHELLTBL 
           MOVE    SPA-PRTKANRI-TBL-KEY(1:6)
                                       TO  SHELL-SRYYM 
           MOVE    SPA-TERMID          TO  SHELL-TERMID
           MOVE    SPA-SYSYMD          TO  SHELL-SYSYMD    
           EVALUATE    SPA-XCIDCD
               WHEN    "1001"
                   MOVE    "recept5.sh"        TO  SHELL-SHELL
                   MOVE    "0"                 TO  SHELL-RECEKBN
           END-EVALUATE
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    SPA-TERMID          TO  RECEERR-TERMID
           MOVE    RECEERR             TO  SHELL-ERRFILE
           OPEN    OUTPUT   RECEERR-FILE
           CLOSE   RECEERR-FILE
           MOVE    SPACE               TO  SHELLTBL
           MOVE    SHELL-NAME          TO  SHELLTBL-NAME
           MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1
           MOVE    SHELL-ARG3          TO  SHELLTBL-ARG2
           MOVE    SHELL-ARG4          TO  SHELLTBL-ARG3
           MOVE    SPA-HOSPID          TO  SHELLTBL-ARG4
           MOVE    SPA-TERMID          TO  SHELLTBL-ARG5
           MOVE    SHELLTBL            TO  MCPDATA-REC
           MOVE    "SHELL"             TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
           CALL    "MCPSUB"            USING   MCPAREA
                                               MCPDATA-REC
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *                         
           .
       450-PRINT-EXT.
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
           IF      SPA-XCIDCD       NOT =   SPACE
               PERFORM 520-TIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
      *****MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "XC01    "          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面内容編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  XC01
      * 
           MOVE    SPA-GMN-HSKYYM      TO  XC01-HSKYYM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX             >   SPA-GMN-MAX  
      *
             MOVE  SPA-GMN-TSELNUM(IDX)  TO   WRK-HEN-SELNUM
             MOVE  WRK-HEN-SELNUM        TO   XC01-TSELNUM(IDX)
             MOVE  SPA-GMN-TPTNUM(IDX)   TO   XC01-TPTNUM(IDX)
             MOVE  SPA-GMN-TNAME(IDX)    TO   XC01-TNAME(IDX)
             MOVE  SPA-GMN-TTEISYUTUSAKI(IDX)
                                         TO   XC01-TTEISYUTUSAKI(IDX)
             MOVE  SPA-GMN-THKNJANUM(IDX)
                                         TO   XC01-THKNJANUM(IDX)
             MOVE  SPA-GMN-TSRYYM(IDX)   TO   XC01-TSRYYM(IDX)
             MOVE  SPA-GMN-TTOTALTEN(IDX)
                                         TO   WRK-TOTALTEN
             MOVE  WRK-TOTALTEN          TO   XC01-TTOTALTEN(IDX)
             MOVE  SPA-GMN-TTOTALTEN1(IDX)
                                         TO   WRK-TOTALTEN
             MOVE  WRK-TOTALTEN          TO   XC01-TTOTALTEN1(IDX)
             MOVE  SPA-GMN-TTOTALTEN2(IDX)
                                         TO   WRK-TOTALTEN
             MOVE  WRK-TOTALTEN          TO   XC01-TTOTALTEN2(IDX)
             MOVE  SPA-GMN-THENREIYM(IDX)
                                         TO   XC01-THENREIYM(IDX)
             MOVE  SPA-GMN-TSKYYM(IDX)   TO   XC01-TSKYYM(IDX)
             MOVE  SPA-GMN-TSKYKBNMEI(IDX)
                                         TO   XC01-TSKYKBN(IDX)
      * 
             COMPUTE WRK-SELNUM = (( SPA-GMN-PAGE - 1 ) * WRK-OCC ) 
                                +    IDX        
      *
             IF      WRK-SELNUM           =   SPA-NAI-SELNUM
                 MOVE    "T"    TO    XC01-SOUKATULST-SELECT(IDX)
             ELSE
                 MOVE    "F"    TO    XC01-SOUKATULST-SELECT(IDX)
             END-IF
      *
           END-PERFORM
      *
           MOVE    SPA-GMN-MAX         TO  XC01-SOUKATULST-COUNT
      **
           MOVE    SPA-GMN-SELNUM      TO  XC01-SELNUM
           MOVE    SPA-GMN-PTNUM       TO  XC01-PTNUM
           MOVE    SPA-GMN-NAME        TO  XC01-NAME
           MOVE    SPA-GMN-TEISYUTUSAKI
                                       TO  XC01-TEISYUTUSAKI
           MOVE    SPA-GMN-HKNJANUM    TO  XC01-HKNJANUM
           MOVE    SPA-GMN-HKNJANAME   TO  XC01-HKNJANAME
           MOVE    SPA-GMN-SRYYM       TO  XC01-SRYYM
           IF      SPA-NAI-SELNUM      =   ZERO  
              MOVE    SPACE               TO  XC01-TOTALTEN
              MOVE    SPACE               TO  XC01-TOTALTEN1
              MOVE    SPACE               TO  XC01-TOTALTEN2
           ELSE  
              MOVE    SPA-GMN-TOTALTEN    TO  WRK-TOTALTEN
              MOVE    WRK-TOTALTEN        TO  XC01-TOTALTEN
              MOVE    SPA-GMN-TOTALTEN1   TO  WRK-TOTALTEN
              MOVE    WRK-TOTALTEN        TO  XC01-TOTALTEN1
              MOVE    SPA-GMN-TOTALTEN2   TO  WRK-TOTALTEN
              MOVE    WRK-TOTALTEN        TO  XC01-TOTALTEN2
           END-IF
           MOVE    SPA-GMN-HENREIYM    TO  XC01-HENREIYM
      *
           MOVE    SPA-GMN-SKYYM       TO  XC01-SKYYM
           MOVE    SPA-GMN-SKYKBN-G    TO  XC01-SKYKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX             >   3  
                 MOVE    SPA-GMN-SKYKBNCOMBO(IDX)
                                       TO  XC01-SKYKBNCOMBO-ITEM(IDX)
                 MOVE    IDX           TO  SPA-GMN-COMBO-COUNT
           END-PERFORM
           MOVE    SPA-GMN-COMBO-COUNT TO  XC01-SKYKBNCOMBO-COUNT    
      **
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
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE    "SELNUM"       TO  MCP-WIDGET
               WHEN    2
                   MOVE    "HENREIYM"     TO  MCP-WIDGET
               WHEN    3
                   MOVE    "SKYYM"        TO  MCP-WIDGET
               WHEN    4
                   MOVE    "SKYKBN"       TO  MCP-WIDGET
          END-EVALUATE
          .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "該当の選択番号はありません" 
                                               TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "返戻年月の入力が誤りです" 
                                               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "請求年月の入力が誤りです" 
                                               TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "請求区分の入力が誤りです" 
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "修正項目がありません" 
                                               TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "前ページはありません" 
                                               TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "表示するデータはありません" 
                                               TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "次ページはありません" 
                                               TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "データ修正中です" 
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "請求管理ＤＢが更新できませんでした"
                                                TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  XCERR
           MOVE    SPA-ERRCD            TO  XCERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  XCERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "XC01"               TO  SPA-MOTOPG
           MOVE    "XCERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "XCERR"              TO  MCP-WINDOW
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
      *    エラーメッセージ表示処理
      *****************************************************************
       520-TIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-XCIDMSG
      *
           EVALUATE    SPA-XCIDCD
                WHEN    "1001"
                   MOVE    "印刷処理を行います"
                                       TO  WRK-XCIDMSG
               WHEN    "1002"
                   MOVE    "登録処理を行います"
                                       TO  WRK-XCIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  XCID1
           MOVE    SPA-XCIDCD           TO  XCID1-ID1CODE
           MOVE    WRK-XCIDMSG          TO  XCID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "XC01"               TO  SPA-MOTOPG
           MOVE    "XCID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "XCID1"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-TIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者マスター読込（キー）
      *****************************************************************
       900-HKNJAINF-INV-SEC         SECTION.
      *
           MOVE    SPACE                TO  HKNJAINF-REC  
           MOVE    SPA-HOSPID           TO  HKNJA-HOSPID
           MOVE    SPA-GMN-HKNJANUM     TO  HKNJA-HKNJANUM
           MOVE    HKNJAINF-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"           TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNJAINF
                   MOVE    MCPDATA-REC         TO  HKNJAINF-REC
               ELSE
                   MOVE    1                   TO  FLG-HKNJAINF
                   INITIALIZE                  HKNJAINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNJAINF
               INITIALIZE                  HKNJAINF-REC
           END-IF
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-HKNJAINF-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理マスタ読込
      *****************************************************************
       900-SEIKYU-SELECT-SEC                 SECTION.
      *
           MOVE    SPACE                TO  RECE10-REC  
           MOVE    SPA-HOSPID           TO  RECE10-HOSPID
           MOVE    SPA-PRTKANRI-TBL-KEY(1:6)
                                        TO  RECE10-SKYYM
           MOVE    RECE10-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"           TO  MCP-FUNC
           MOVE    "SEIKYU-KEY5"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO             TO  SPA-GMN-SEIKYU-COUNT
               COMPUTE  SPA-GMN-SEIKYU-ECOUNT = (SPA-GMN-PAGE * WRK-OCC)
                                              +  1
               COMPUTE  SPA-GMN-SEIKYU-SCOUNT = SPA-GMN-SEIKYU-ECOUNT
                                              -  WRK-OCC
               PERFORM 900-SEIKYU-FETCH-SEC
           ELSE
               MOVE    1                TO  FLG-SEIKYU
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
      *
               MOVE    ZERO                TO  FLG-SEIKYU
               MOVE    MCPDATA-REC         TO  RECE10-REC
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
               ADD      1                  TO  SPA-GMN-SEIKYU-COUNT
      *
               IF       SPA-GMN-SEIKYU-COUNT >= SPA-GMN-SEIKYU-SCOUNT
               AND      SPA-GMN-SEIKYU-COUNT <= SPA-GMN-SEIKYU-ECOUNT
                     CONTINUE  
               ELSE  
                     GO  TO  900-SEIKYU-FETCH-SEC
               END-IF  
      *  
           ELSE
               MOVE    1                   TO  FLG-SEIKYU
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
      *    請求マスター読込（主キー）
      *****************************************************************
       910-SEIKYU-INV-SEC         SECTION.
      *
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-SEIKYU2
               ELSE
                   MOVE    1               TO  FLG-SEIKYU2
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SEIKYU2
           END-IF
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           MOVE    "SEIKYU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-SEIKYU-INV-EXT.
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
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"                   TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                    USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
