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
      *  サブシステム名    : 印刷プレビュー
      *  コンポーネント名  : 印刷プレビュー指定（ＸＣ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/01/20    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-XXXX    YY/MM/DD  
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
006900*    入力ＰＳファイル
           SELECT  PREVIEW-FILE    ASSIGN  
                                         "/etc/jma-receipt/preview.env"
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-PREVIEW.
006900*    出力ＰＳファイル
      *    SELECT  OTPREVIEW-FILE    ASSIGN  OTPREVIEW
      *                            ORGANIZATION    IS  LINE SEQUENTIAL
      *                            FILE    STATUS  IS  STS-OTPREVIEW.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
006900*    入力ＰＳファイル
       FD  PREVIEW-FILE.
       01  PREVIEW-RECORD. 
           03  PREVIEW-ENV      PIC X(200). 
006900*    出力ＰＳファイル
      *FD  OTPREVIEW-FILE.
      *01  OTPREVIEW-RECORD. 
      *    03  OTPREVIEW-FIL    PIC X(1000). 
      *
       WORKING-STORAGE             SECTION.
       01  PREVIEW              PIC X(512).
       01  OTPREVIEW            PIC X(512).
       01  WORK-KEY-AREA.
           03 WRK-TITLE         PIC X(40).
           03 WRK-PTNUM         PIC X(20).
           03 WRK-SRYYM         PIC X(10).
      *
      *     レセプト明細ファイル シェル領域 
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
      *    再印刷処理共通パラメタ
           COPY    "XC01COMMON-SPA".
      *
       01  SPA-XC01.
           03  SPA-XC01-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
               05  SPA-GMN-NEXT        PIC 9(01).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-TITLE               PIC X(40).
                   07  SPA-GMN-TITLE1              PIC X(08).
                   07  SPA-GMN-TITLE2              PIC X(10).
                   07  SPA-GMN-ERRMSG              PIC X(40).
                   07  SPA-GMN-FILENAME            PIC X(200).
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-OCC             OCCURS  100.
                           11  SPA-GMN-TNO         PIC 9(03).
                           11  SPA-GMN-TTBL-GROUP  PIC X(14).
                           11  SPA-GMN-TRENNUM     PIC 9(04).
                           11  SPA-GMN-TSHORI-RENNUM
                                                   PIC 9(04).
                           11  SPA-GMN-TPAGE       PIC 9(05).
                           11  SPA-GMN-TSRYYM      PIC X(06).
                           11  SPA-GMN-TSKYYMD     PIC X(09).
                           11  SPA-GMN-TSHORI-TITLE
                                                   PIC X(20).
                           11  SPA-GMN-TPRT-TITLE  PIC X(60).
                           11  SPA-GMN-PTNUM       PIC X(20).
                           11  SPA-GMN-TPRFLG      PIC X(01).
                           11  SPA-GMN-TUPDFLG     PIC X(02).
                   07  SPA-GMN-BODY.        
                       09  SPA-GMN-SELNUM          PIC 9(03).
                       09  SPA-GMN-MEMO            PIC X(100).      
                       09  SPA-GMN-BODY1.
                           11  SPA-GMN-TBL-GROUP   PIC X(14).
      *                    11  SPA-GMN-RENNUM      PIC 9(04).
      *                    11  SPA-GMN-SHORI-RENNUM
      *                                            PIC 9(04).
                           11  SPA-GMN-STPAGE      PIC 9(05).
                           11  SPA-GMN-EDPAGE      PIC 9(05).
      *                 
               05  SPA-NAI-AREA.
                   07  SPA-NAI-SELNUM              PIC 9(03).      
                   07  SPA-NAI-MEMO-FLG            PIC 9(01).      
                   07  SPA-NAI-ENV-FLG             PIC 9(01).      
                   07  SPA-NAI-ENV                 PIC X(200).      
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-OCC             OCCURS  100.
                           11  SPA-NAI-TBL-KEY     PIC X(08).
                           11  SPA-NAI-RENNUM      PIC 9(04).
                           11  SPA-NAI-MEMO       PIC X(100).      
                           11  SPA-NAI-TBL-GROUP   PIC X(14).
                           11  SPA-NAI-SHORI-RENNUM
                                                   PIC 9(04).
                           11  SPA-NAI-PAGE        PIC 9(05).
                           11  SPA-NAI-FILENAME    PIC X(200).
                           11  SPA-NAI-PRTNM       PIC X(16).
                           11  SPA-NAI-PTID        PIC 9(10).
                           11  SPA-NAI-MAKEOK-FLG  PIC 9(01).
                           11  SPA-NAI-UPDFLG      PIC X(01).
      *                     
               05  SPA-WRK-TBL-KEY                 PIC X(08).            
      *                 
      *****03  SPA-XC01-MOTOPG                     PIC X(08).    
      *
      *   
           COPY    "ENUM-VALUE".
      *
      *   
           COPY    "CMJOBNAME.INC".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
       01  PS-FILE-ID              PIC X(200).
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
           03  STS-PREVIEW         PIC X(02).
           03  STS-OTPREVIEW       PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PREVIEW         PIC 9(01).
           03  FLG-PRVKANRI        PIC 9(01).
           03  FLG-END             PIC 9(01).
           03  FLG-IN              PIC 9(01).
           03  FLG-CHK             PIC 9(01).
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
           03  IDX2                PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PRVKANRI-TBL-GROUP
                                   PIC X(14).
           03  WRK-PREVIEW-RENNUM PIC 9(04).
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
           03  WRK-PAGE            PIC ZZZZZZZZZ9.   
           03  WRK-MOTOPG          PIC X(08).
           03  WRK-SELNUM          PIC 9(03). 
           03  WRK-STR             PIC 9(05).
      *
           03  WRK-ZZ              PIC ZZ9.
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
       01  WRK-SHELL-NAME.
           05  FILLER             PIC X(16) VALUE
                                             "scripts/allways/".
           05  WRK-SHELL-SHELL    PIC X(20).         
      *
       01  WRK-PSFILE-AREA.
             05  WRK-PSFILE-FOLDER     PIC X(165).
             05  WRK-PSFILE-TBL-KEY    PIC X(08).
             05  WRK-PSFILE-RENNUM     PIC X(04).
             05  WRK-PSFILE-GROUP      PIC X(14).
             05  WRK-PSFILE-SRENNUM    PIC X(04).
             05  WRK-PSFILE-PAGE       PIC X(05).

           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".
      *
       01  WRK-LNK-AREA.
           COPY    "CPORCSPRTLNK.INC".   
      *              
      *
       01  WRK-CONS-AREA.
      *    システム管理ＤＢ（３００３）のキー値  
           03  WRK-CONS-3003-KBNCD PIC X(08)   VALUE   "003".
      *    印刷管理ＤＢのキー値  
           03  WRK-CONS-PREVIEW-TBL-KEY
                                   PIC X(08)   VALUE   "PREPRINT".
           03  WRK-CONS-PREVIEW-TBL-GROUP
                                   PIC X(14)   VALUE   SPACE.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "PREPRINT".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   ZERO.
      *
      *
           03  WRK-CONS-LINE-MAX   PIC 9(03)   VALUE   100.
      *     
      *    プレビュー用情報
           COPY    "CPXC01LNK.INC".
      *
      *   ファイル取得関数
       01 ORCFILEGET-AREA.
           03  ORCF-FILE-MODE   PIC X(1).
           03  ORCF-FILE-NAME   PIC X(200).
           03  ORCF-DATA        PIC X(100000).
           03  ORCF-RET         PIC X(2).
       01  ST                PIC 9(2).
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1031.INC".
      *
           COPY    "CPSK3003.INC".
      *
      *01  PREVIEW-REC.
           COPY    "CPPREVIEW.INC".
      *
      *01  PRVKANRI-REC.
           COPY    "CPPRVKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".          
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
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
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
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
           COPY    "XC99.INC".
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
      **** MOVE    SPACE               TO  LINKAREA
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
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               INITIALIZE              SPA-XC01-AREA
                                       SPA-XC01KYOUTU
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    SPA-WORK            TO  LNK-XC01-AREA
               MOVE    LNK-XC01-AREA       TO  SPA-XC01-LN-AREA
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
               PERFORM 310-SPASET-SEC
               GO  TO  300-SCREEN-EXT
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    作表処理
               WHEN    "XC99" 
                   GO      TO      300-SCREEN-EXT
               WHEN    "XCID1"
                   PERFORM 330-XCID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           INITIALIZE              SPA-XC01-AREA
                                   SPA-XC01KYOUTU
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
           INITIALIZE                  SPA-XC01-AREA
      *
           OPEN    INPUT      PREVIEW-FILE
           IF      STS-PREVIEW         =   ZERO
                   PERFORM 45013-INPS-READ-SEC 
                   CLOSE   PREVIEW-FILE
           ELSE
                   MOVE    1              TO  FLG-IN 
           END-IF
           IF      FLG-IN      =   ZERO
                   MOVE  1     TO  SPA-NAI-ENV-FLG
                   STRING  PREVIEW-ENV         DELIMITED  BY  SPACE
                           "/"                 DELIMITED  BY  SPACE
                                       INTO    SPA-NAI-ENV
                   END-STRING
           ELSE
                   MOVE "/tmp/"
                               TO  SPA-NAI-ENV
           END-IF
      *
           EVALUATE    SPA-PRTKANRI-TBL-KEY
               WHEN    "SOKATU"
                   MOVE    "診療年月"     TO  SPA-GMN-TITLE1
                   MOVE    "請求年月日"   TO  SPA-GMN-TITLE2
               WHEN    "RECEPT2"
                   MOVE    "診療年月"     TO  SPA-GMN-TITLE1
                   MOVE    "請求年月日"   TO  SPA-GMN-TITLE2
               WHEN    "DAILY"
               WHEN    "MONTHLY"
                   MOVE    SPACE          TO  SPA-GMN-TITLE1
                   MOVE    "作成年月日"   TO  SPA-GMN-TITLE2
               WHEN    OTHER
                   MOVE    "年月"         TO  SPA-GMN-TITLE1
                   MOVE    "年月日"       TO  SPA-GMN-TITLE2
           END-EVALUATE
      *
      *    プレビューDB検索処理
           PERFORM 2011-PRVKANRI-HEN-SEC
           MOVE    1                      TO  SPA-GMN-PAGE
           MOVE    1                      TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＸＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-XCID1-SET-SEC            SECTION.
      *
           IF      SPA-XCID1-FLG    =   "OK"
               EVALUATE    SPA-XCIDCD
                   WHEN    "6666"
                       MOVE    "JOIN"          TO  MCP-PUTTYPE
                       PERFORM 210-BACK-SYORI-SEC
                   WHEN    "1001"
                   WHEN    "1004"
                   WHEN    "1005"
                       PERFORM 450-PRINT-SEC
               END-EVALUATE        
           END-IF
      *
           MOVE    1               TO  SPA-GMN-CUR
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
      *     終了
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE   "CHANGE"         TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *     状態
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 2011-PRVKANRI-HEN-SEC
      *     訂正
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 440-MAKE-UPD-SEC
      *
      *     前行
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 480-BEFORELINE-SEC
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 440-ATOGMN-SEC
      *     次行
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 470-NEXTLINE-SEC
      *     印刷
               WHEN    "CLICKED"       ALSO    "B12"
      *            PERFORM 450-PRINT-GID-SEC
                   PERFORM 450-PRINT-SEC
      *     処理確認
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 490-KAKUNIN-SEC
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
      *        メモ入力
               WHEN    "ACTIVATE"      ALSO    "MEMO"
                   PERFORM 202-MEMO-SEC
      *        行選択
               WHEN    ANY             ALSO    "CLIST"
                   PERFORM 203-SELECT-SEC
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
      *     
           IF      SPA-GMN-SELNUM      =   ZERO
               CONTINUE
           ELSE
               IF      SPA-GMN-SELNUM  >   SPA-GMN-MAX
                   MOVE    "0001"          TO  SPA-ERRCD
               ELSE
                   MOVE    SPA-GMN-SELNUM  TO  SPA-NAI-SELNUM     
                   PERFORM 2011-SELECT-HENSYU-SEC
               END-IF    
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    3                   TO  SPA-GMN-CUR
           END-IF    
           .
       201-SELNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    メモ入力処理
      *****************************************************************
       202-MEMO-SEC                   SECTION.
      *
           MOVE   SPA-GMN-SELNUM       TO  IDX
      *
           MOVE    XC01-MEMO           TO  SPA-GMN-MEMO
                                           SPA-NAI-MEMO(IDX)
      *
           INITIALIZE                  PRVKANRI-REC
           MOVE    SPA-NAI-TBL-KEY (IDX)
                                       TO  PRVKANRI-TBL-KEY
           MOVE    SPA-NAI-RENNUM (IDX)
                                       TO  PRVKANRI-RENNUM
           MOVE    SPA-NAI-TBL-GROUP (IDX)
                                       TO  PRVKANRI-TBL-GROUP
           MOVE    SPA-NAI-SHORI-RENNUM (IDX)
                                       TO  PRVKANRI-SHORI-RENNUM
           MOVE    SPA-NAI-PAGE(IDX)   TO  PRVKANRI-PAGE
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           PERFORM 900-PRVKANRI-INV-SEC
           MOVE    MCPDATA-REC         TO  PRVKANRI-REC
           MOVE    SPA-NAI-UPDFLG(IDX) TO  PRVKANRI-MOD-FLG
           MOVE    SPA-NAI-MEMO(IDX)   TO  PRVKANRI-MEMO
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           PERFORM 4401-PRVKANRI-UPD-SEC
           MOVE    3                   TO  SPA-GMN-CUR
           .
       202-MEMO-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者検索処理
      *****************************************************************
       2011-SELECT-HENSYU-SEC        SECTION.
      *
           MOVE    SPA-NAI-SELNUM      TO  IDY
      *     
           MOVE    SPA-NAI-FILENAME (IDY)   TO  SPA-GMN-FILENAME 
      **** MOVE    SPA-GMN-TSHORI-RENNUM (IDY) TO
      ****                                     SPA-NAI-SHORI-RENNUM
           .
       2011-SELECT-HENSYU-EXT.
           EXIT.
           .
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       203-SELECT-SEC               SECTION.
      *          
           MOVE    99                  TO  SPA-GMN-CUR         
      *    行選択
           MOVE    ZERO                TO  WRK-SELNUM
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
               IF      XC01-SELECT (IDX)   =   "T"
                   IF      IDX             =   SPA-NAI-SELNUM
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNUM
                       MOVE    SPA-GMN-MAX     TO  IDX
                   END-IF
               END-IF    
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
           PERFORM 2011-SELECT-HENSYU-SEC
      *                                 
           MOVE    SPACE               TO  SPA-GMN-ERRMSG
           MOVE    SPACE               TO  PREVIEW
           MOVE    SPA-NAI-FILENAME (SPA-GMN-SELNUM)
                                       TO  WRK-PSFILE-AREA
           STRING  SPA-NAI-ENV         DELIMITED  BY  SPACE
                   WRK-PSFILE-TBL-KEY  DELIMITED  BY  SPACE
                   WRK-PSFILE-RENNUM   DELIMITED  BY  SPACE
                   WRK-PSFILE-GROUP    DELIMITED  BY  SPACE
                   WRK-PSFILE-SRENNUM  DELIMITED  BY  SPACE
                   WRK-PSFILE-PAGE     DELIMITED  BY  SPACE
                                       INTO   PREVIEW
           END-STRING
      *                                 
           PERFORM 460-FILE-HENSYU-SEC
           MOVE    SPA-NAI-SELNUM      TO  IDX
           PERFORM 2013-PREVIEW-CHECK-SEC
           MOVE    SPA-NAI-FILENAME (IDX)   TO  SPA-GMN-FILENAME 
      *
           IF      SPA-NAI-UPDFLG(IDX)      =   1
                   MOVE    SPA-NAI-MEMO (IDY)
                                            TO  SPA-GMN-MEMO
                   MOVE    1                TO  SPA-NAI-MEMO-FLG
                   MOVE    2                TO  SPA-GMN-CUR         
           END-IF
      *
           .
       203-SELECT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       440-MAKE-UPD-SEC            SECTION.
           IF      XC01-SELECT (SPA-GMN-SELNUM)   =   "T"
              IF   SPA-GMN-TUPDFLG (SPA-GMN-SELNUM)   =   "○"
                   MOVE SPACE          TO
                                       SPA-GMN-TUPDFLG(SPA-GMN-SELNUM)
                   MOVE SPACE          TO
                                       SPA-NAI-UPDFLG(SPA-GMN-SELNUM)
                   MOVE ZERO           TO
                                       SPA-NAI-MEMO-FLG
                   MOVE SPACE          TO
                                       SPA-NAI-MEMO(SPA-GMN-SELNUM)
                                       SPA-GMN-MEMO
              ELSE
                   MOVE "○"           TO
                                       SPA-GMN-TUPDFLG(SPA-GMN-SELNUM)
                   MOVE "1"            TO
                                       SPA-NAI-UPDFLG(SPA-GMN-SELNUM)
                   MOVE 1              TO
                                       SPA-NAI-MEMO-FLG
                   MOVE 2              TO  SPA-GMN-CUR
              END-IF
           END-IF
           MOVE   SPA-GMN-SELNUM       TO  IDX
           INITIALIZE                  PRVKANRI-REC
           MOVE    SPA-NAI-TBL-KEY (IDX)
                                       TO  PRVKANRI-TBL-KEY
           MOVE    SPA-NAI-RENNUM (IDX)
                                       TO  PRVKANRI-RENNUM
           MOVE    SPA-NAI-TBL-GROUP (IDX)
                                       TO  PRVKANRI-TBL-GROUP
           MOVE    SPA-NAI-SHORI-RENNUM (IDX)
                                       TO  PRVKANRI-SHORI-RENNUM
           MOVE    SPA-NAI-PAGE(IDX)   TO  PRVKANRI-PAGE
           MOVE    SPA-NAI-MEMO(IDX)   TO  PRVKANRI-MEMO
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           PERFORM 900-PRVKANRI-INV-SEC
           MOVE    MCPDATA-REC         TO  PRVKANRI-REC
           MOVE    SPA-NAI-UPDFLG(IDX) TO  PRVKANRI-MOD-FLG
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           PERFORM 4401-PRVKANRI-UPD-SEC
           .
       440-MAKE-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       2014-PRV-HENSYU-SEC         SECTION.
           IF      SPA-NAI-MAKEOK-FLG (IDX)    =   ZERO
               PERFORM   20121-PREVIEW-EXIST-SEC
             IF    FLG-PREVIEW           =   1  
      *             再印刷以外からの遷移
      *     ラージオブジェクト対応までコメント★
      *        IF   SPA-XC01-LN-MODE      =  "1"
                   PERFORM   20122-PSFILE-EXIST-SEC
      *        END-IF
             END-IF
           END-IF
           .
       2014-PRV-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       460-FILE-HENSYU-SEC         SECTION.
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
      *            PERFORM 2013-PREVIEW-CHECK-SEC
                   PERFORM 2014-PRV-HENSYU-SEC
      *        
           END-PERFORM
           .
       460-FILE-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
      *    PERFORM 900-SYSKANRI-INV-SEC
           MOVE    1                   TO  FLG-SYSKANRI
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
                   IF      SJOBKANRI-RETURN
                                           =   ZERO
                       IF      JOB-ENDYMD      =   SPACE
      *********        AND     JOB-TERMID      =   SPA-TERMID
                           MOVE    "6666"          TO  SPA-XCIDCD
                           GO  TO  210-BACK-EXT
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
      *    ファイルクリア
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
               IF    SPA-NAI-FILENAME (IDX)
                                       NOT =   SPACE
                   MOVE    ZERO            TO  IF-RESULT
                   MOVE    SPA-NAI-FILENAME (IDX)
                                           TO  IF-FILENAME
      *     ラージオブジェクト対応までコメント★
      * ★         CALL    "orcfiledel"    USING
      *                                    ORCSFDELAREA
               END-IF    
           END-PERFORM
      *
           PERFORM 210-BACK-SYORI-SEC         
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      *
           MOVE    SPA-MOTOPG2         TO  SPA-SAKIPG
           MOVE    "XC01"              TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  SPA-WORK
           MOVE    SPA-XC01-LN-AREA    TO  SPA-WORK 
      **** INITIALIZE                  SPA-KYOTUKEY
      ****                             SPA-KYOTU-SET
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
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
      *    前行　処理
      *****************************************************************
       480-BEFORELINE-SEC                SECTION.
      *
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
               IF      XC01-SELECT (IDX)   =   "T"
                   IF      IDX             =   SPA-NAI-SELNUM
                       CONTINUE
                   ELSE        
                       MOVE    IDX         TO  SPA-NAI-SELNUM
                       MOVE    SPA-GMN-MAX TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
      *    行選択
      *    MOVE    ZERO                TO  WRK-SELNUM
      *    IF     (SPA-GMN-MAX         <=  SPA-NAI-SELNUM) 
           IF     (SPA-NAI-SELNUM      =   1)
                   GO                  TO  480-BEFORELINE-EXT
           END-IF
      *     
           IF      SPA-NAI-SELNUM      =   ZERO
                   MOVE  "T"           TO  XC01-SELECT (1)
                   MOVE   1            TO  SPA-NAI-SELNUM
           ELSE
                   MOVE  "F"           TO  XC01-SELECT (SPA-NAI-SELNUM)
                   COMPUTE SPA-NAI-SELNUM  =  SPA-NAI-SELNUM  -  1
                   MOVE  "T"           TO  XC01-SELECT (SPA-NAI-SELNUM)
           END-IF
      *    検索処理
           PERFORM 203-SELECT-SEC
      *
           .
       480-BEFORELINE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次行　処理
      *****************************************************************
       470-NEXTLINE-SEC                SECTION.
      *
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
               IF      XC01-SELECT (IDX)   =   "T"
                   IF      IDX             =   SPA-NAI-SELNUM
                       CONTINUE
                   ELSE        
                       MOVE    IDX         TO  SPA-NAI-SELNUM
                       MOVE    SPA-GMN-MAX TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
      *    行選択
      *    MOVE    ZERO                TO  WRK-SELNUM
           IF     (SPA-GMN-MAX         <=  SPA-NAI-SELNUM) 
      *    OR     (SPA-NAI-SELNUM      =   1)
                   GO                  TO  470-NEXTLINE-EXT
           END-IF
      *     
           IF      SPA-NAI-SELNUM      =   ZERO
                   MOVE  "T"           TO  XC01-SELECT (1)
                   MOVE   1            TO  SPA-NAI-SELNUM
           ELSE
                   MOVE  "F"           TO  XC01-SELECT (SPA-NAI-SELNUM)
                   COMPUTE SPA-NAI-SELNUM  =  SPA-NAI-SELNUM  +  1
                   MOVE  "T"           TO  XC01-SELECT (SPA-NAI-SELNUM)
           END-IF
      *    検索処理
           PERFORM 203-SELECT-SEC
      *
           .
       470-NEXTLINE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       440-ATOGMN-SEC             SECTION.
      *
           IF      SPA-GMN-NEXT        =   ZERO
               GO      TO      440-ATOGMN-EXT
           END-IF
      *
           ADD     1                   TO  SPA-GMN-PAGE
      *    検索処理
           PERFORM 2011-PREVIEW-HEN-SEC
      *
           .
       440-ATOGMN-EXT.
           EXIT.
      *****************************************************************
      *    作表処理
      *****************************************************************
       450-PRINT-GID-SEC                SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRCD                 
      *    ジョブ管理チェック        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
                   IF      SJOBKANRI-RETURN
                                           =   ZERO
                       IF      JOB-ENDYMD      =   SPACE
                           MOVE    "7777"          TO  SPA-ERRCD
                           MOVE    SPACE           TO  WRK-RECEERR
                           STRING  "処理中です【"  DELIMITED  BY  SIZE
                                   JOB-SHELLMSG    DELIMITED  BY  SPACE
                                   "】"            DELIMITED  BY  SIZE      
                                                   INTO  WRK-RECEERR
                           MOVE    SYS-3003-JOBID  TO  IDX
                       END-IF
                   END-IF    
               END-PERFORM
           END-IF
      *
           IF      SPA-ERRCD       NOT =   SPACE                 
               GO  TO  450-PRINT-GID-EXT               
           END-IF
      *     
      *    IF      SPA-GMN-TBL-GROUP   =   SPACE
      *        MOVE    "0001"              TO  SPA-ERRCD
      *    ELSE
      *        IF      SPA-GMN-STPAGE      >
      *                            SPA-GMN-TPAGE (SPA-GMN-SELNUM) 
      *        OR      SPA-GMN-EDPAGE      >
      *                            SPA-GMN-TPAGE (SPA-GMN-SELNUM) 
      *            MOVE    "0002"              TO  SPA-ERRCD
      *        ELSE    
      *            IF      SPA-GMN-EDPAGE      <   SPA-GMN-STPAGE 
      *                MOVE    "0002"              TO  SPA-ERRCD
      *            END-IF
      *        END-IF
      *    END-IF                                            
      *
           IF      SPA-ERRCD       NOT =   SPACE                 
               GO  TO  450-PRINT-GID-EXT               
           END-IF
      *         
      *    プレビューＤＢのチェック
           INITIALIZE                      PREVIEW-REC
           MOVE    SPA-PRTKANRI-TBL-KEY
                                       TO  PREVIEW-TBL-KEY
      *    MOVE    SPA-GMN-TBL-GROUP   TO  PREVIEW-TITLE
      *     ラージオブジェクト対応までコメント★
      *    MOVE    PREVIEW-REC        TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    PATH-TBL-PREVIEW-KEY2
      *                                TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *    IF      MCP-RC             =   ZERO
      *        PERFORM 900-PREVIEW-FET2-SEC
      *    ELSE
               MOVE    1                   TO  FLG-PREVIEW
      *    END-IF
      * end ラージオブジェクト対応までコメント★
      *     
      *    指定のグループが存在しないとき
           IF      FLG-PREVIEW        =   1
               MOVE    "0005"              TO  SPA-ERRCD
               GO  TO  450-PRINT-GID-EXT   
           ELSE
               MOVE    PREVIEW-TBL-KEY    TO  SPA-WRK-TBL-KEY    
           END-IF
      *     
      *    ガイドメッセージセット
           MOVE    "1001"                 TO  SPA-XCIDCD
      *
      *    未処理の帳票があるとき
           PERFORM                     UNTIL   FLG-PREVIEW    =   1
               PERFORM 900-PREVIEW-FET2-SEC
           END-PERFORM                   
      *                  
      *     ラージオブジェクト対応までコメント★
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    PATH-TBL-PREVIEW-KEY2
      *                                TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
           .
       450-PRINT-GID-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷編集処理
      *****************************************************************
       450-PRINT-SEC                   SECTION.
      * 
      *    ＪＯＢＩＤ（３００４）削除処理
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC
               MOVE    SYS-3003-REC        TO  MCPDATA-REC
               MOVE    "DBDELETE"          TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   CONTINUE
               ELSE                                 
                   MOVE    "1005"              TO  SPA-ERRCD
                   GO  TO  450-PRINT-EXT
               END-IF
           END-IF                 
      * 
      *    ジョブ管理削除処理
           MOVE    "ALL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING   ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
           IF      SJOBKANRI-RETURN    =   ZERO
               CONTINUE
           ELSE
               MOVE    "1004"              TO  SPA-ERRCD
               GO  TO  450-PRINT-EXT
           END-IF             
      *
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
           ACCEPT  SYS-TIME            FROM    TIME
      *
           MOVE    ZERO                TO  WRK-CONS-JOB-JOBID     
                                           WRK-PREVIEW-RENNUM
           MOVE    SPACE               TO  WRK-CONS-PREVIEW-TBL-GROUP                                
      *     
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    SPA-TERMID          TO  RECEERR-TERMID
      *
      *    印刷処理
      *
           PERFORM 45011-JOBKANRI-HENSYU-SEC
      *                                   
           MOVE    RECEERR             TO  SHELL-ERRFILE
      *             
           MOVE    SPACE               TO  SHELLTBL
      *****MOVE    "/usr/local/orca/scripts/allways/print.sh"
      *****                            TO  SHELLTBL-NAME
           MOVE    "preprint.sh"       TO  WRK-SHELL-SHELL
      *    ファイルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME      TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
      *     
           MOVE    SPACE               TO  LNK-PRTKANRI-AREA
           INITIALIZE                      LNK-PRTKANRI-AREA
           MOVE    SPA-WRK-TBL-KEY     TO  LNK-PRTKANRI-TBL-KEY  
           MOVE    SPA-NAI-TBL-GROUP (SPA-NAI-SELNUM)
                                       TO  LNK-PRTKANRI-TBL-GROUP
           MOVE    SPA-NAI-RENNUM    (SPA-NAI-SELNUM)
                                       TO  LNK-PRTKANRI-RENNUM
           MOVE    SPA-NAI-SHORI-RENNUM (SPA-NAI-SELNUM)
                                       TO  LNK-PRTKANRI-SHORI-RENNUM
           MOVE    "preprint.sh"       TO  LNK-PRTKANRI-SHELLID
           MOVE    SPA-TERMID          TO  LNK-PRTKANRI-TERMID
           MOVE    SPA-OPID            TO  LNK-PRTKANRI-OPID
           MOVE    LNK-PRTKANRI-RENNUM TO  SHELLTBL-ARG1       
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SHELLTBL-ARG2     
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SHELLTBL-ARG3       
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SHELLTBL-ARG4       
           MOVE    LNK-PRTKANRI-SRYYM  TO  SHELLTBL-ARG5       
           MOVE    LNK-PRTKANRI-SKYYMD TO  SHELLTBL-ARG6       
           MOVE    LNK-PRTKANRI-SHELLID
                                       TO  SHELLTBL-ARG7       
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SHELLTBL-ARG8      
           MOVE    LNK-PRTKANRI-TERMID TO  SHELLTBL-ARG9       
           MOVE    LNK-PRTKANRI-OPID   TO  SHELLTBL-ARG10      
           MOVE    LNK-PRTKANRI-PRTNM  TO  SHELLTBL-ARG11      
      *                 
           MOVE    SHELL-ARG4          TO  SHELLTBL-ARG12
           MOVE    WRK-CONS-JOB-JOBID  TO  SHELLTBL-ARG13
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SHELLTBL-ARG14
      *    MOVE    SPA-GMN-STPAGE      TO  SHELLTBL-ARG15
      *    MOVE    SPA-GMN-EDPAGE      TO  SHELLTBL-ARG16                      
           IF      SPA-XCID1-FLG    =   "OK"
      *      MOVE    "/tmp/"
             MOVE  SPA-NAI-ENV 
                                       TO  OTPREVIEW
             MOVE    WRK-CONS-JOB-SHELLID
                                       TO  OTPREVIEW(6:)
      *      OPEN  OUTPUT OTPREVIEW-FILE
             PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
      *        
               IF      SPA-NAI-FILENAME (IDX)  NOT  =  SPACE 
                       MOVE    SPA-NAI-FILENAME (IDX)
                                          TO  PREVIEW
                       OPEN    INPUT      PREVIEW-FILE
                       PERFORM 45013-INPS-READ-SEC 
                       CLOSE               PREVIEW-FILE
               END-IF
             END-PERFORM
      *      CLOSE OTPREVIEW-FILE
             MOVE  SPA-NAI-ENV 
                                       TO  SHELLTBL-ARG15
             MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SHELLTBL-ARG15(6:)
             MOVE    SPA-NAI-PRTNM    (1)
                                       TO  SHELLTBL-ARG16                                 
           ELSE
             MOVE    SPA-NAI-FILENAME (SPA-NAI-SELNUM)
                                       TO  SHELLTBL-ARG15
             MOVE    SPA-NAI-PRTNM    (SPA-NAI-SELNUM)
                                       TO  SHELLTBL-ARG16                                 
           END-IF
           IF      SPA-XCIDCD          =   "1005"
                   MOVE    "3"         TO  SHELLTBL-ARG17                                   
           ELSE
                   MOVE    "1"         TO  SHELLTBL-ARG17                                   
           END-IF
           MOVE    SHELLTBL            TO  MCPDATA-REC
           MOVE    "SHELL"             TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC                         
      *
      *    ＪＯＢＩＤ更新処理
      *
           PERFORM 45012-JOBID-UPD-SEC 
      *     
      *    情報確認画面を表示                                                   
      *    PERFORM 490-KAKUNIN-SEC
           .
       450-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    プレビューDB検索処理
      *****************************************************************
       2011-PREVIEW-HEN-SEC        SECTION.
      *
           INITIALIZE                  SPA-GMN-TBL
           INITIALIZE                  SPA-NAI-AREA
           MOVE    ZERO                TO  SPA-GMN-MAX
           MOVE    ZERO                TO  IDX
      *
      *    検索
           INITIALIZE                  PREVIEW-REC
           MOVE    SPA-PRTKANRI-TBL-KEY
                                       TO  PREVIEW-TBL-KEY
      *     ラージオブジェクト対応までコメント★
      *    MOVE    PREVIEW-REC        TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    PATH-TBL-PREVIEW-KEY2
      *                                TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *    IF      MCP-RC             =   ZERO
      *        PERFORM 900-PREVIEW-FET-SEC
      *    ELSE 
               MOVE    1                   TO  FLG-PREVIEW
      *    END-IF
      * end ラージオブジェクト対応までコメント★
      *
           IF     (SPA-GMN-NEXT        =   1  )  AND
                  (SPA-GMN-PAGE        >   1  )
               COMPUTE WRK-STR         =   (SPA-GMN-PAGE  -  1)
                                       *   100
                                       +   1
           ELSE
               MOVE    1               TO  WRK-STR
           END-IF
      *
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDX2
           PERFORM UNTIL   (IDX        >   100       ) OR
                           (FLG-PREVIEW  =   1         )
      *
               ADD     1               TO  IDX2
               IF      IDX2            >=  WRK-STR
                       PERFORM 2012-PRVKANRI-HENSYU-SEC
               END-IF
      *
               PERFORM 900-PREVIEW-FET-SEC
           END-PERFORM
      * 
      *     ラージオブジェクト対応までコメント★
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    PATH-TBL-PREVIEW-KEY2
      *                                TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      * end ラージオブジェクト対応までコメント★
      *
      *    IF     (IDX             >   100  )  AND
      *           (FLG-PREVIEW     =   ZERO )
      *        MOVE    "0003"          TO  SPA-ERRCD
      *    END-IF
      *
           IF     (IDX             >   100  )  AND
                  (FLG-PREVIEW       =   ZERO )
               MOVE    1               TO  SPA-GMN-NEXT
           ELSE
               MOVE    ZERO            TO  SPA-GMN-NEXT
           END-IF
      *
           .
       2011-PREVIEW-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    プレビューDB検索処理
      *****************************************************************
       2011-PRVKANRI-HEN-SEC        SECTION.
      *
      *    検索
           INITIALIZE                  PRVKANRI-REC
           MOVE    SPA-PRTKANRI-TBL-KEY
                                       TO  PRVKANRI-TBL-KEY
           MOVE    LNK-XC01-RENNUM     TO  PRVKANRI-RENNUM
           MOVE    LNK-XC01-TBL-GROUP  TO  PRVKANRI-TBL-GROUP
           MOVE    LNK-XC01-SHORI-RENNUM
                                       TO  PRVKANRI-SHORI-RENNUM
           MOVE    LNK-XC01-ST-PAGE    TO  PRVKANRIXX-STPAGE
           MOVE    LNK-XC01-ED-PAGE    TO  PRVKANRIXX-EDPAGE
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY3
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC             =   ZERO
               PERFORM 900-PRVKANRI-FET-SEC
           ELSE 
               MOVE    1                   TO  FLG-PRVKANRI
           END-IF
      *
           IF     (SPA-GMN-NEXT        =   1  )  AND
                  (SPA-GMN-PAGE        >   1  )
               COMPUTE WRK-STR         =   (SPA-GMN-PAGE  -  1)
                                       *   100
                                       +   1
           ELSE
               MOVE    1               TO  WRK-STR
           END-IF
      *
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDX2
           PERFORM UNTIL ( IDX             >   100 ) OR
                         ( FLG-PRVKANRI    =   1   )
      *
               ADD     1               TO  IDX2
               IF      IDX2            >=  WRK-STR
                       PERFORM 2012-PRVKANRI-HENSYU-SEC
               END-IF
      *
               PERFORM 900-PRVKANRI-FET-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY3
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
      *    IF     (IDX             >   100  )  AND
      *           (FLG-PREVIEW     =   ZERO )
      *        MOVE    "0003"          TO  SPA-ERRCD
      *    END-IF
      *
           IF     (IDX             >   100  )  AND
                  (FLG-PREVIEW       =   ZERO )
               MOVE    1               TO  SPA-GMN-NEXT
           ELSE
               MOVE    ZERO            TO  SPA-GMN-NEXT
           END-IF
      *
           .
       2011-PRVKANRI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    プレビューDB編集処理
      *****************************************************************
       2012-PRVKANRI-HENSYU-SEC        SECTION.
      *
      *    既にＳＰＡに存在するかチェック
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       SPA-GMN-MAX
               IF    ( PRVKANRI-TBL-KEY        =
                                           SPA-NAI-TBL-KEY      (IDZ) )
               AND   ( PRVKANRI-RENNUM         =
                                           SPA-NAI-RENNUM       (IDZ) )
               AND   ( PRVKANRI-TBL-GROUP      =
                                           SPA-NAI-TBL-GROUP    (IDZ) )
               AND   ( PRVKANRI-SHORI-RENNUM   =
                                           SPA-NAI-SHORI-RENNUM (IDZ) )
               AND   ( PRVKANRI-PAGE           =  
                                           SPA-NAI-PAGE         (IDZ) )
                   MOVE    1               TO  FLG-CHK
                   MOVE    IDZ             TO  IDX
                   MOVE    SPA-GMN-MAX     TO  IDZ
               END-IF
           END-PERFORM
      *
      *    ＳＰＡに追加
           IF      FLG-CHK             =   ZERO
               COMPUTE IDX     =   SPA-GMN-MAX     +   1
               IF      IDX                 <=  100
                   MOVE    IDX                 TO  SPA-GMN-TNO(IDX)
      *
                   MOVE    PRVKANRI-TBL-KEY    TO
                                           SPA-NAI-TBL-KEY   (IDX)
                   MOVE    PRVKANRI-RENNUM     TO  
                                           SPA-NAI-RENNUM   (IDX)
                   MOVE    PRVKANRI-TBL-GROUP  TO  
                                           SPA-NAI-TBL-GROUP (IDX)
                   MOVE    PRVKANRI-SHORI-RENNUM TO  
                                           SPA-NAI-SHORI-RENNUM (IDX)
                   MOVE    PRVKANRI-PAGE       TO  
                                           SPA-NAI-PAGE (IDX)
                   MOVE    PRVKANRI-TITLE      TO
                                           SPA-GMN-TPRT-TITLE (IDX)
                   MOVE    PRVKANRI-MEMO       TO
                                           SPA-NAI-MEMO (IDX)
                   MOVE    PRVKANRI-FILENAME   TO  WRK-PSFILE-AREA
                   STRING  SPA-NAI-ENV         DELIMITED  BY  SPACE
                          WRK-PSFILE-TBL-KEY   DELIMITED  BY  SPACE
                          WRK-PSFILE-RENNUM    DELIMITED  BY  SPACE
                          WRK-PSFILE-GROUP     DELIMITED  BY  SPACE
                          WRK-PSFILE-SRENNUM   DELIMITED  BY  SPACE
                          WRK-PSFILE-PAGE      DELIMITED  BY  SPACE
                                       INTO    SPA-NAI-FILENAME (IDX)
                   END-STRING
                   MOVE    PRVKANRI-PRTNM      TO  SPA-NAI-PRTNM (IDX)
                   MOVE    PRVKANRI-PTID       TO  SPA-NAI-PTID  (IDX)
                   MOVE    PRVKANRI-MOD-FLG    TO  SPA-NAI-UPDFLG (IDX)
                   IF      SPA-NAI-UPDFLG (IDX) =  "1"
                     MOVE  "○"                TO  SPA-GMN-TUPDFLG (IDX)
                   END-IF
      *
                   INITIALIZE                      ORCSPTIDAREA
                   MOVE    SPA-HOSPID          TO  SPTID-HOSPID
                   MOVE    PRVKANRI-PTID       TO  SPTID-PTID
                   CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                                   SPA-1009-TBL
                   IF      SPTID-RC        NOT =   ZERO
                       MOVE    SPACE           TO  SPA-GMN-PTNUM  (IDX)
                   ELSE
                       MOVE    SPTID-PTNUM     TO  SPA-GMN-PTNUM  (IDX)
                   END-IF
      *
      *            IF      PRVKANRI-TBL-GROUP  NOT =
      *                                        WRK-PRVKANRI-TBL-GROUP
                       MOVE    PRVKANRI-TBL-GROUP   TO
      *                                        SPA-NAI-TBL-GROUP (IDX)
                                               WRK-PRVKANRI-TBL-GROUP
                       IF      PRVKANRI-SRYYM  NOT =   SPACE   AND ZERO
                           MOVE    PRVKANRI-SRYYM  TO  WRK-SYMD (1:6)
                           MOVE    "01"            TO  WRK-SYMD (7:2)
                           PERFORM 5002-HIZUKE-HEN-SEC
                           MOVE    WRK-HENYMDG(1:6)
                                               TO  SPA-GMN-TSRYYM (IDX)
                       END-IF
                       IF      PRVKANRI-SKYYMD NOT =   SPACE   AND ZERO
                           MOVE    PRVKANRI-SKYYMD TO  WRK-SYMD 
                           PERFORM 5002-HIZUKE-HEN-SEC
                           MOVE    WRK-HENYMDG     TO
                                                   SPA-GMN-TSKYYMD(IDX)
                       END-IF
                       SET     TBL-IDX             TO  1
                       SEARCH      MNAME-TBL-OCC   VARYING   TBL-IDX
                           AT   END
                               MOVE    SPACE       TO
                                           SPA-GMN-TSHORI-TITLE (IDX)
                           WHEN    PRVKANRI-TBL-KEY    =   MNAME-SHELLID
                                                          (TBL-IDX)
                               MOVE    MNAME-JOBNAME (TBL-IDX)
                                                TO  SPA-GMN-TSHORI-TITLE
                                                           (IDX)
                       END-SEARCH
      *            END-IF
      *
                   MOVE    IDX                 TO  SPA-GMN-MAX
               END-IF
           END-IF
      *
      *  10        20        30        40        50        60
----+-*--+----+----+----+----+----+----+----+----+----+----+----+----+
      *    未処理のときプレビューＤＢより編集
           IF      IDX                 <=  100
             IF      SPA-NAI-MAKEOK-FLG (IDX)    =   ZERO
               PERFORM   20121-PREVIEW-EXIST-SEC
               IF    FLG-PREVIEW           =   1  
      *    再印刷以外からの遷移
      *     ラージオブジェクト対応までコメント★
      *         IF   SPA-XC01-LN-MODE      =  "1"
                   PERFORM   20122-PSFILE-EXIST-SEC
      *         END-IF
               END-IF
             END-IF
           END-IF
      *           
           .
       2012-PRVKANRI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    プレビューpsファイル編集処理
      *****************************************************************
       20122-PSFILE-EXIST-SEC      SECTION.
      *  10        20        30        40        50        60
----+-*--+----+----+----+----+----+----+----+----+----+----+----+----+
      *    MOVE   PRVKANRI-FILENAME    TO  WRK-PSFILE-AREA
      *
           MOVE   SPA-NAI-TBL-KEY (IDX)    TO  WRK-PSFILE-TBL-KEY
           MOVE   SPA-NAI-RENNUM    (IDX)  TO  WRK-PSFILE-RENNUM
           MOVE   SPA-NAI-TBL-GROUP (IDX)  TO  WRK-PSFILE-GROUP
           MOVE   SPA-NAI-SHORI-RENNUM (IDX)
                                           TO  WRK-PSFILE-SRENNUM
           MOVE   SPA-NAI-PAGE (IDX)       TO  WRK-PSFILE-PAGE
      *
      *  10        20        30        40        50        60
----+-*--+----+----+----+----+----+----+----+----+----+----+----+----+
           MOVE    SPACE               TO  ORCF-FILE-NAME
           STRING  SPA-NAI-ENV         DELIMITED  BY  SPACE
                   WRK-PSFILE-TBL-KEY  DELIMITED  BY  SPACE
                   WRK-PSFILE-RENNUM   DELIMITED  BY  SPACE
                   WRK-PSFILE-GROUP    DELIMITED  BY  SPACE
                   WRK-PSFILE-SRENNUM  DELIMITED  BY  SPACE
                   WRK-PSFILE-PAGE     DELIMITED  BY  SPACE
                                       INTO   ORCF-FILE-NAME
           END-STRING
           MOVE    "r"                 TO  ORCF-FILE-MODE
           CALL    "orcfileio"         USING ST  ORCFILEGET-AREA
           IF      ORCF-RET            =   ZERO
                   MOVE  1             TO
                                       SPA-NAI-MAKEOK-FLG (IDX)
                   MOVE   "*"          TO
                                        SPA-GMN-TPRFLG     (IDX)
                   GO        TO  20122-PSFILE-EXIST-EXT
           END-IF
----+-*--+----+----+----+----+----+----+----+----+----+----+----+----+
           MOVE   SPACE                TO  ORCF-FILE-NAME
           STRING  "/var/tmp/" DELIMITED  BY  SPACE
                  WRK-PSFILE-TBL-KEY   DELIMITED  BY  SPACE
                  WRK-PSFILE-RENNUM    DELIMITED  BY  SPACE
                  WRK-PSFILE-GROUP     DELIMITED  BY  SPACE
                  WRK-PSFILE-SRENNUM   DELIMITED  BY  SPACE
                  WRK-PSFILE-PAGE      DELIMITED  BY  SPACE
                                       INTO   ORCF-FILE-NAME
           END-STRING
      *
           MOVE    "r"         TO  ORCF-FILE-MODE
           MOVE    SPACE       TO  PREVIEW-PRTDATA 
           CALL    "orcfileio" USING ST  ORCFILEGET-AREA
           IF      ORCF-RET    NOT =   ZERO
                   DISPLAY "★★★★★FGET FILE OPEN ERROR "
                                       ORCF-FILE-NAME 
           ELSE  
                   MOVE    ORCF-DATA    TO  PREVIEW-PRTDATA 
      *
                   MOVE    SPACE        TO  ORCF-FILE-NAME
                   STRING  SPA-NAI-ENV  DELIMITED  BY  SPACE
                        WRK-PSFILE-TBL-KEY DELIMITED  BY  SPACE
                        WRK-PSFILE-RENNUM  DELIMITED  BY  SPACE
                        WRK-PSFILE-GROUP   DELIMITED  BY  SPACE
                        WRK-PSFILE-SRENNUM DELIMITED  BY  SPACE
                        WRK-PSFILE-PAGE    DELIMITED  BY  SPACE
                                           INTO   ORCF-FILE-NAME
                   END-STRING
      *---------------------------------------------------------
                   MOVE    "w"          TO  ORCF-FILE-MODE
                   MOVE    PREVIEW-PRTDATA
                                           TO  ORCF-DATA 
                   CALL    "orcfileio"     USING ST  ORCFILEGET-AREA
                      IF   ORCF-RET        NOT =   ZERO
                           DISPLAY "FGET FILE OPEN ERROR "
                                           ORCF-FILE-NAME 
                      ELSE
                           MOVE  1         TO
                                           SPA-NAI-MAKEOK-FLG (IDX)
                           MOVE   "*"      TO
                                           SPA-GMN-TPRFLG     (IDX)
      *
                           MOVE    SPA-NAI-TBL-KEY (IDX)
                                           TO  PREVIEW-TBL-KEY
                           MOVE    SPA-NAI-RENNUM    (IDX)
                                           TO  PREVIEW-RENNUM
                           MOVE    SPA-NAI-TBL-GROUP (IDX)
                                           TO  PREVIEW-TBL-GROUP
                           MOVE    SPA-NAI-SHORI-RENNUM (IDX)
                                           TO  PREVIEW-SHORI-RENNUM
                           MOVE    SPA-NAI-PAGE (IDX)
                                           TO  PREVIEW-PAGE
                           MOVE    PREVIEW-REC
                                           TO  MCPDATA-REC
                           MOVE    "DBINSERT"
                                           TO  MCP-FUNC
      *     ラージオブジェクト対応までコメント★
      *                    MOVE    PATH-TBL-PREVIEW-KEY
      *                                    TO  MCP-PATH
      * end ラージオブジェクト対応までコメント★
                           MOVE    ZERO    TO  MCP-RC
      *
      *     ラージオブジェクト対応までコメント★
      *                    CALL    "MCPSUB"
      *                                    USING
      *                                    MCPAREA
      *                                    MCPDATA-REC
                           IF      MCP-RC  =   ZERO
                             MOVE    ZERO  TO  IF-RESULT
                             MOVE   SPA-NAI-TBL-KEY (IDX)
                                           TO  WRK-PSFILE-TBL-KEY
                             MOVE   SPA-NAI-RENNUM    (IDX)
                                           TO  WRK-PSFILE-RENNUM
                             MOVE   SPA-NAI-TBL-GROUP (IDX)
                                           TO  WRK-PSFILE-GROUP
                             MOVE   SPA-NAI-SHORI-RENNUM (IDX)
                                           TO  WRK-PSFILE-SRENNUM
                             MOVE   SPA-NAI-PAGE (IDX)
                                           TO  WRK-PSFILE-PAGE
                             MOVE   SPACE  TO  ORCF-FILE-NAME
----+-*--+----+----+----+----+----+----+----+----+----+----+----+----+
                             STRING  "/var/tmp/" DELIMITED  BY  SPACE
                               WRK-PSFILE-TBL-KEY
                                                 DELIMITED  BY  SPACE
                               WRK-PSFILE-RENNUM DELIMITED  BY  SPACE
                               WRK-PSFILE-GROUP  DELIMITED  BY  SPACE
                               WRK-PSFILE-SRENNUM
                                                 DELIMITED  BY  SPACE
                               WRK-PSFILE-PAGE   DELIMITED  BY  SPACE
                                                 INTO  ORCF-FILE-NAME
                             END-STRING
                             MOVE    ORCF-FILE-NAME
                                           TO  IF-FILENAME
                             CALL    "orcfiledel"    USING
                                           ORCSFDELAREA
                               DISPLAY "file del start "
                                             IF-FILENAME
                           ELSE
                               DISPLAY "take preview insert err "
                                   PRVKANRI-PAGE
                           END-IF
                      END-IF
           END-IF
           .
       20122-PSFILE-EXIST-EXT.
           EXIT.
      *           
      *****************************************************************
      *    プレビューDB編集処理
      *****************************************************************
       20121-PREVIEW-EXIST-SEC      SECTION.
      *           
      *           
            MOVE    SPA-NAI-TBL-KEY (IDX)    TO  PREVIEW-TBL-KEY
            MOVE    SPA-NAI-RENNUM    (IDX)  TO  PREVIEW-RENNUM
            MOVE    SPA-NAI-TBL-GROUP (IDX)  TO  PREVIEW-TBL-GROUP
            MOVE    SPA-NAI-SHORI-RENNUM (IDX)
                                             TO  PREVIEW-SHORI-RENNUM
            MOVE    SPA-NAI-PAGE (IDX)       TO  PREVIEW-PAGE
      *           
      *           
      *     MOVE    PRVKANRI-TBL-KEY         TO  PREVIEW-TBL-KEY
      *     MOVE    PRVKANRI-RENNUM          TO  PREVIEW-RENNUM
      *     MOVE    PRVKANRI-TBL-GROUP       TO  PREVIEW-TBL-GROUP
      *     MOVE    PRVKANRI-SHORI-RENNUM    TO  PREVIEW-SHORI-RENNUM
      *     MOVE    PRVKANRI-PAGE            TO  PREVIEW-PAGE
            MOVE    PREVIEW-REC              TO  MCPDATA-REC
            MOVE    "DBSELECT"               TO  MCP-FUNC
      *     ラージオブジェクト対応までコメント★
      *     MOVE    PATH-TBL-PREVIEW-KEY
      *                                      TO  MCP-PATH
      *     MOVE    ZERO                     TO  MCP-RC
      *     CALL    "MCPSUB"            USING
      *                                 MCPAREA
      *                                 MCPDATA-REC
      *     IF      MCP-RC                   =   ZERO
      *             PERFORM 900-PREVIEW-FET-SEC
      *     ELSE 
                    MOVE    1                   TO  FLG-PREVIEW
      *     END-IF
      * end ラージオブジェクト対応までコメント★
            IF     FLG-PREVIEW               =   ZERO
                   MOVE   SPACE                TO  ORCF-FILE-NAME
                   MOVE   SPA-NAI-FILENAME (IDX)
                                               TO  ORCF-FILE-NAME
                   MOVE    "w"                 TO  ORCF-FILE-MODE
                   MOVE    PREVIEW-PRTDATA     TO  ORCF-DATA 
                   CALL    "orcfileio"     USING ST  ORCFILEGET-AREA
                   IF      ORCF-RET        NOT =   ZERO
                       DISPLAY "FGET FILE OPEN ERROR " ORCF-FILE-NAME 
                   ELSE
                     MOVE  1                   TO
                                               SPA-NAI-MAKEOK-FLG (IDX)
                     MOVE   "*"                TO
                                               SPA-GMN-TPRFLG     (IDX)
                   END-IF
            END-IF
           .
       20121-PREVIEW-EXIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    プレビューDB編集処理
      *****************************************************************
       2013-PREVIEW-CHECK-SEC        SECTION.
      *
            IF      SPA-NAI-MAKEOK-FLG (IDX) =   1
                    MOVE    SPACE
                                           TO  SPA-GMN-ERRMSG
                    MOVE    SPA-NAI-MEMO(IDX)
                                           TO  SPA-GMN-MEMO
                    MOVE    1              TO  SPA-NAI-MEMO-FLG
                    GO      TO               2013-PREVIEW-CHECK-EXT
            END-IF
      *
            MOVE    SPA-NAI-TBL-KEY (IDX)    TO  PREVIEW-TBL-KEY
            MOVE    SPA-NAI-RENNUM    (IDX)  TO  PREVIEW-RENNUM
            MOVE    SPA-NAI-TBL-GROUP (IDX)  TO  PREVIEW-TBL-GROUP
            MOVE    SPA-NAI-SHORI-RENNUM (IDX)
                                             TO  PREVIEW-SHORI-RENNUM
            MOVE    SPA-NAI-PAGE (IDX)       TO  PREVIEW-PAGE
            MOVE    PREVIEW-REC              TO  MCPDATA-REC
            MOVE    "DBSELECT"               TO  MCP-FUNC
      *     ラージオブジェクト対応までコメント★
      *     MOVE    PATH-TBL-PREVIEW-KEY
      *                                      TO  MCP-PATH
      *     CALL    "MCPSUB"            USING
      *                                 MCPAREA
      *                                 MCPDATA-REC
      *     IF      MCP-RC             =   ZERO
      *         PERFORM 900-PREVIEW-FET-SEC
      *     ELSE 
                MOVE    1                   TO  FLG-PREVIEW
      *     END-IF
      * end ラージオブジェクト対応までコメント★
            IF     FLG-PREVIEW         =   ZERO
                   MOVE   SPA-NAI-FILENAME (IDX)   TO  ORCF-FILE-NAME
                   MOVE    "w"                 TO  ORCF-FILE-MODE
                   MOVE    PREVIEW-PRTDATA     TO  ORCF-DATA 
                   CALL    "orcfileio"     USING ST  ORCFILEGET-AREA
                   IF      ORCF-RET        NOT =   ZERO
                           DISPLAY "file write err = ["
                                  ORCF-FILE-NAME "]"
                   ELSE 
                          MOVE  1              TO 
                                               SPA-NAI-MAKEOK-FLG (IDX)
                          MOVE   "*"           TO
                                               SPA-GMN-TPRFLG (IDX)
                          MOVE   SPACE
                                               TO  SPA-GMN-ERRMSG
                   END-IF
            ELSE
                 MOVE    "帳票データ作成中です"
                                           TO  SPA-GMN-ERRMSG
            END-IF
      *
           .
       2013-PREVIEW-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＳファイルＩ−Ｏ処理
      *****************************************************************
       45013-INPS-READ-SEC             SECTION.
      *    入力ＰＳファイル読込み
           PERFORM 900-IN-READ-SEC
      *    PERFORM
      *        UNTIL    FLG-IN         =   1
      *
      *        MOVE     PREVIEW-FIL    TO  
      *                                OTPREVIEW-FIL     
      *        WRITE    OTPREVIEW-RECORD    
      *    入力ＰＳファイル読込み
      *        PERFORM 900-IN-READ-SEC
      *    END-PERFORM
           .
       45013-INPS-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力ファイル読込み処理
      *****************************************************************
       900-IN-READ-SEC          SECTION.
      *
          READ    PREVIEW-FILE
              AT  END
                  MOVE    1               TO  FLG-IN
              NOT AT  END
                  MOVE    ZERO            TO  FLG-IN
          END-READ
      *
          .
       900-IN-READ-EXT.
          EXIT.
      *
      *****************************************************************
      *    ジョブ開始セット処理
      *****************************************************************
       45011-JOBKANRI-HENSYU-SEC       SECTION.
      *
           ADD     1               TO  WRK-CONS-JOB-JOBID
      *       
           MOVE    "DEL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
      *
           MOVE    "JBS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           MOVE    SPA-TERMID      TO  JOB-TERMID                        
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
      *
           .
       45011-JOBKANRI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＪＯＢＩＤ更新処理
      *****************************************************************
       45012-JOBID-UPD-SEC    SECTION.
      *
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
      *       
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    ZERO                TO  SYS-3003-STYUKYMD
           MOVE    ALL "9"             TO  SYS-3003-EDYUKYMD
           MOVE    WRK-CONS-PREVIEW-TBL-KEY
                                       TO  SYS-3003-TBL-KEY
           MOVE    WRK-CONS-PREVIEW-TBL-GROUP
                                       TO  SYS-3003-TBL-GROUP
           MOVE    WRK-CONS-JOB-JOBID  TO  SYS-3003-JOBID                                      
      *
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           IF      FLG-SYSKANRI        =   ZERO     
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"          TO  MCP-FUNC
           END-IF         
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "SYSKANRI 3003  ERR KEY = ["
                                  MCP-RC  " " SYS-3003-KEY  "]"   
      *****    MOVE    "1010"          TO  SPA-ERRCD
           END-IF
      *
           .
       45012-JOBID-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
           MOVE    SPACE               TO  XC99
           MOVE    ZERO                TO  XC99-COUNT
      *        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC 
                   IF      SJOBKANRI-RETURN    =   ZERO
                       MOVE    JOB-JOBID       TO  XC99-RENNUM   (IDX)
                       MOVE    JOB-SHELLMSG    TO  XC99-SHORINM  (IDX)
                       MOVE    JOB-STARTTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-STARTTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-STARTTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  XC99-STARTTIME(IDX)
                       MOVE    JOB-ENDTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-ENDTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-ENDTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  XC99-ENDTIME  (IDX)
                       MOVE    JOB-UPDCNT      TO  WRK-PAGE
                       MOVE    WRK-PAGE        TO  XC99-PAGE     (IDX)
                       MOVE    JOB-YOBI        TO  XC99-ERRMSG   (IDX)
                       IF      JOB-ENDYMD      =   SPACE
                           MOVE    "処理中です"    TO  XC99-MSG
                       ELSE
                           IF      JOB-ERRCD       =   SPACE
                               CONTINUE
                           ELSE
                               STRING  JOB-YOBI    DELIMITED  BY  SPACE
                                       "【"        DELIMITED  BY  SIZE
                                      JOB-SHELLMSG DELIMITED  BY  SPACE
                                      "】"         DELIMITED  BY  SIZE      
                                                   INTO  XC99-MSG
                           END-IF                          
                       END-IF    
                       MOVE    IDX                     TO  XC99-COUNT    
                   END-IF
               END-PERFORM
           END-IF
           IF      XC99-MSG              =   SPACE
               IF      XC99-COUNT            >   ZERO    
                   MOVE    "処理は正常に終了しました"
                                                TO  XC99-MSG
               ELSE
                   MOVE    "該当する処理はありません"
                                                TO  XC99-MSG
               END-IF                                 
           END-IF                                 
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "XC01"                TO  SPA-MOTOPG
           MOVE    "XC99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "XC99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
           .
       490-KAKUNIN-EXT.
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
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
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
           EVALUATE    SPA-PRTKANRI-TBL-KEY
               WHEN    "RECEPT2"
                   MOVE    WIDGET-NORMAL
                                       TO  XC01-B05-STATE
               WHEN    OTHER
                   MOVE    WIDGET-INSENSITIVE
                                       TO  XC01-B05-STATE
                                           XC01-MEMO-STATE
           END-EVALUATE
      *
      *  10        20        30        40        50        60
----+-*--+----+----+----+----+----+----+----+----+----+----+----+----+
           MOVE    SPA-GMN-TITLE       TO  XC01-TITLE
           MOVE    "blue"              TO  XC01-TITLE-STYLE
           MOVE    SPA-GMN-ERRMSG      TO  XC01-ERRMSG
           MOVE    "red"               TO  XC01-ERRMSG-STYLE
      *    MOVE    SPA-GMN-TITLE2      TO  XC01-HEAD2
      *     
           MOVE    SPA-GMN-SELNUM      TO  XC01-SELNUM
           MOVE    SPA-GMN-FILENAME    TO  XC01-PSAREA
           IF      XC01-PSAREA         =   SPACE
                   MOVE  SPA-NAI-FILENAME(1)
                                       TO  XC01-PSAREA
                   MOVE    "T"         TO  XC01-SELECT (1)
      *            MOVE  1             TO  SPA-NAI-SELNUM
           END-IF
      *
           MOVE    SPACE               TO  WRK-TITLE
           MOVE    SPACE               TO  WRK-PTNUM
           MOVE    SPACE               TO  WRK-SRYYM
           IF     (SPA-NAI-MEMO-FLG    =   1)
           AND    (SPA-PRTKANRI-TBL-KEY
                                       =   "RECEPT2")
                   MOVE  WIDGET-NORMAL 
                                       TO  XC01-MEMO-STATE
                   MOVE  SPA-GMN-MEMO  TO  XC01-MEMO
           ELSE
                   MOVE    WIDGET-INSENSITIVE
                                       TO  XC01-MEMO-STATE
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX             >   SPA-GMN-MAX
      *
               MOVE    SPA-GMN-TNO       (IDX) TO  WRK-ZZ
               MOVE    WRK-ZZ                  TO  XC01-TNO       (IDX)
               MOVE    SPA-GMN-TPAGE     (IDX) TO  WRK-PAGE
               IF      SPA-GMN-TSRYYM    (IDX) NOT =   WRK-SRYYM
                       MOVE    SPA-GMN-TSRYYM (IDX)
                                               TO  XC01-TSRYYM    (IDX)
                                                   WRK-SRYYM
               END-IF
      *        MOVE    SPA-GMN-TSRYYM    (IDX) TO  XC01-TSRYYM    (IDX)
               IF      SPA-GMN-TPRT-TITLE(IDX) NOT =   WRK-TITLE 
                 MOVE    SPA-GMN-TPRT-TITLE(IDX)
                                               TO  WRK-TITLE
                 MOVE  SPA-GMN-TPRT-TITLE(IDX) TO  XC01-TPRT-TITLE(IDX)
               END-IF
               IF      SPA-GMN-PTNUM(IDX)      NOT = WRK-PTNUM
                 MOVE  SPA-GMN-PTNUM(IDX)      TO  WRK-PTNUM
                 MOVE  SPA-GMN-PTNUM(IDX)      TO  XC01-PTNUM(IDX)
               END-IF
               MOVE    SPA-GMN-TPRFLG    (IDX) TO  XC01-OKFLG(IDX)
               MOVE    SPA-GMN-TUPDFLG   (IDX) TO  XC01-UPDFLG(IDX)
      *        
               IF      IDX             =   SPA-NAI-SELNUM
                   MOVE    "T"             TO  XC01-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  XC01-SELECT (IDX)
               END-IF
           END-PERFORM
      *
           MOVE    SPA-GMN-MAX         TO  XC01-COUNT
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
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE    "SELNUM"       TO  MCP-WIDGET
               WHEN    2
                   MOVE    "MEMO"         TO  MCP-WIDGET
               WHEN    3
                   MOVE    "B08"          TO  MCP-WIDGET
               WHEN    5
                   MOVE    "STPAGE"       TO  MCP-WIDGET
               WHEN    6
                   MOVE    "EDPAGE"       TO  MCP-WIDGET
               WHEN    99
                   MOVE    "B12"          TO  MCP-WIDGET
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
                   MOVE    "頁の入力が違います" 
                                               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "未入力の項目があります" 
                                               TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "頁の入力が違います" 
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "該当の帳票はありません" 
                                               TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "該当の帳票はありません" 
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "帳票管理ＤＢが削除できませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "帳票ＤＢが削除できませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1004"
                   MOVE    "ジョブ管理ＤＢが削除できませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1005"
                   MOVE
                   "システム管理ＤＢ（３００３）が削除できませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "7777"
                   MOVE    WRK-RECEERR         TO  SPA-ERRMSG
               WHEN    "9999"
                   MOVE    WRK-RECEERR         TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  XCERR
           MOVE    SPA-ERRCD            TO  XCERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  XCERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "XC01"                TO  SPA-MOTOPG
           MOVE    "XCERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                 TO  MCP-PUTTYPE
           MOVE    "XCERR"               TO  MCP-WINDOW
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
       520-TIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-XCIDMSG
      *
           EVALUATE    SPA-XCIDCD
               WHEN    "1001"
                   MOVE    "一括印刷処理を行います"
                                       TO  WRK-XCIDMSG
               WHEN    "1002"
                   MOVE    "該当のグループの削除処理を行います"
                                       TO  WRK-XCIDMSG
               WHEN    "1003"
                   MOVE
                   "処理中の可能性がありますが削除処理を行いますか"
                                       TO  WRK-XCIDMSG
               WHEN    "1004"
                   MOVE
                   "処理中の可能性がありますが印刷処理を行いますか"
                                       TO  WRK-XCIDMSG
               WHEN    "1005"
                   MOVE    "プレビュー処理を行います"
                                       TO  WRK-XCIDMSG
               WHEN    "6666"
                   MOVE    "印刷処理中です"
                                            TO  WRK-XCIDMSG
               WHEN    "8888"
                   MOVE    "処理が正常終了しました"
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
      *     印刷管理ＤＢ読み込み（ｋｅｙ２）
      *****************************************************************
       900-PREVIEW-FET2-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
      *     ラージオブジェクト対応までコメント★
      *    MOVE    PATH-TBL-PREVIEW-KEY2
      *                                TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *                                  
      *    IF      MCP-RC              =   ZERO
      *        MOVE    MCPDATA-REC         TO  PREVIEW-REC
      *        MOVE    ZERO                TO  FLG-PREVIEW
      *    ELSE
               MOVE    1                   TO  FLG-PREVIEW
      *    END-IF
      * end ラージオブジェクト対応までコメント★
           .
       900-PREVIEW-FET2-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷管理ＤＢ読み込み
      *****************************************************************
       900-PREVIEW-FET-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
      *     ラージオブジェクト対応までコメント★
      *    MOVE    PATH-TBL-PREVIEW-KEY
      *                                TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *                                  
      *    IF      MCP-RC              =   ZERO
      *        MOVE    MCPDATA-REC         TO  PREVIEW-REC
      *        MOVE    ZERO                TO  FLG-PREVIEW
      *    ELSE
               MOVE    1                   TO  FLG-PREVIEW
      *    END-IF
           .
       900-PREVIEW-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *     プレビュー管理ＤＢ更新
      *****************************************************************
       4401-PRVKANRI-UPD-SEC            SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *                                  
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRVKANRI-REC
               MOVE    ZERO                TO  FLG-PRVKANRI
           ELSE
               MOVE    1                   TO  FLG-PRVKANRI
           END-IF
           .
       4401-PRVKANRI-UPD--EXT.
           EXIT.
      *
      *****************************************************************
      *     プレビュー管理ＤＢ読み込み
      *****************************************************************
       900-PRVKANRI-FET-SEC            SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY3
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *                                  
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRVKANRI-REC
               MOVE    ZERO                TO  FLG-PRVKANRI
           ELSE
               MOVE    1                   TO  FLG-PRVKANRI
           END-IF
           .
       900-PRVKANRI-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *    プレビュー管理マスター読込（キー）
      *****************************************************************
       900-PRVKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    PATH-TBL-PRVKANRI-KEY
                                       TO  MCP-PATH
               CALL    "MCPSUB"         USING
                                        MCPAREA
                                        MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-PRVKANRI
               ELSE
                   MOVE    1                   TO  FLG-PRVKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PRVKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    PATH-TBL-PRVKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       900-PRVKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
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
       900-SYSKANRI-INV-EXT.
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
