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
       PROGRAM-ID.             ORCR0467.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト（労災・自賠責）
      *  コンポーネント名  : 月次業務　労災自賠責明細書ファイル作成
      *                      （金額摘要欄編集）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-門脇    02.09.19  自賠責対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
           SELECT  RECE41-FILE     ASSIGN  RECE01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE41-KEY
                                   FILE    STATUS  IS  STS-RECE41.
      *   
           SELECT  RECE46-FILE     ASSIGN  RECE46PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE46-KEY
                                   FILE    STATUS  IS  STS-RECE46.
      *   
           SELECT  RECE47-FILE     ASSIGN  RECE47PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE47-KEY
                                   FILE    STATUS  IS  STS-RECE47.
      *    
           SELECT  RECE47X-FILE     ASSIGN  RECE47PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE47X-KEY
                                   FILE    STATUS  IS  STS-RECE47.
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       FD  RECE41-FILE.
       01  RECE41-REC.
           COPY    "CPRCF041.INC".
      *
       FD  RECE46-FILE.
       01  RECE46-REC.
           COPY    "CPRCF0461.INC" REPLACING  //RECE461//
                                   BY         //RECE46//.
      *
      *
       FD  RECE47-FILE.
       01  RECE47-REC. 
           COPY    "CPRCF0471.INC"  REPLACING //RECE471//
                                   BY         //RECE47//.
      *
       FD  RECE47X-FILE.
       01  RECE47X-REC. 
           COPY    "CPRCF0471.INC"  REPLACING //RECE471//
                                   BY         //RECE47X//.
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC".
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE46//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE47//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *     
      *    フラグ領域
       01  STS-AREA.
           03  SPA-STS             PIC 9(04).
           03  STS-RECE41          PIC X(02).
           03  STS-RECE47          PIC X(02).
           03  STS-RECE46          PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE41          PIC 9(01).
           03  FLG-RECE46          PIC 9(01).
           03  FLG-RECE47          PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-SP              PIC 9(01).
           03  FLG-NOPRT           PIC 9(01).
           03  FLG-HENSYU          PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE41          PIC 9(06).
           03  CNT-RECE47          PIC 9(06).
           03  CNT-RECE46          PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *    点数回数編集用     
           03  IDA                 PIC 9(04).
           03  IDB                 PIC 9(04).
      *    剤診療行為コード別編集用     
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM              PIC  X(06).
               05  WRK-PARA-TERMID             PIC  X(16).
               05  WRK-PARA-SYSYMD             PIC  X(08).
               05  WRK-PARA-JOBID              PIC  9(07).
               05  WRK-PARA-SHELLID            PIC  X(08).
      *
           03  WRK-RECEERR         PIC X(200).
      *
           03  WRK-LINENUM         PIC 9(05).
      *    剤印字行数
           03  WRK-TBLMAX         PIC 9(03).
      * 
           03  WRK-YUKOKETA        PIC  9(02).
           03  WRK-NAME            PIC  X(200).
      *
      *    数字半角全角変換用     
           03  WRK-NUM                         PIC 9(01).
           03  WRK-CHAR-IDX                    PIC 9(02).
           03  WRK-CHAR-HENKAN-AREA.
               05  WRK-CHAR-X                  PIC X(10).
               05  WRK-CHAR-N                  PIC X(20).
               05  WRK-CHAR-CNT                PIC 9(02).
               05  WRK-CHAR-FLG                PIC 9(01). 
               05  WRK-CHAR-N-CNT              PIC 9(02).
      *
           03  WRK-EDIT-AREA.
               05  WRK-CLM                     PIC 9(03).
               05  WRK-WCLM                    PIC 9(03).
      *
           03  WRK-KOUI                        PIC X(200).
      *
           03  WRK-ZAI.
               05  WRK-ZAI-NAME                PIC X(52).
      *
           03  WRK-ZAI1.
      ***      05  WRK-ZAI1-NAME               PIC X(28).               
               05  WRK-ZAI1-NAME               PIC X(24).               
      *
      *    点数・回数編集用
           03  WRK-ZAITENX                     PIC ZZZZZZZZ9.99.
           03  WRK-ZAIKAISUX                   PIC ZZZ9.
           03  WRK-TNSKAI-AREA.
               05  WRK-TNSKAI-ST               PIC 9(03).
               05  WRK-TNSKAI-ST1              PIC 9(03).
               05  WRK-TNSKAI-KETA             PIC 9(02).
               05  WRK-TNSKAI-LEN              PIC 9(02).
      *
               05  WRK-TNSKAI.
                   07  WRK-ZAITEN              PIC X(10).
                   07  WRK-X                   PIC X(02).
                   07  WRK-ZAIKAISU            PIC X(06).
      *             
           03  WRK-ST                          PIC 9(03).
      *     
           03  WRK-WLINETEK                    PIC 9(03).
           03  WRK-SRYSURYOW                   PIC X(20).
           03  WRK-ZAIIDX                      PIC 9(03).
           03  WRK-NAMEKETA                    PIC 9(03).
           03  WRK-YOHAKU                      PIC 9(03).
           03  WRK-WKETA                       PIC 9(03).
      *     
           03  WRK-SRYKBN                      PIC X(02).
           03  WRK-Z9                          PIC ZZZ9.
      *****03  WRK-IN                          PIC X(01).
      *
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMDG         PIC X(22).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
      *
           03  WRK-HENTIME.
               05  WRK-THH         PIC 99.
               05  FILLER          PIC X(01)   VALUE  ":".
               05  WRK-TMM         PIC 99.
      *          
      *    診療行為別テーブル
       01  TBL-ZAIW-AREA.
           03  TBL-ZAIW-REC.
               05  TBL-ZAIW-SRYACTINF.
      *            診療コード/数量/回数
                   07  TBL-ZAIW-SRYCD           PIC  X(09).
                   07  TBL-ZAIW-SRYSURYO        PIC  9(05)V9(03).
                   07  TBL-ZAIW-SRYKAISU        PIC  9(03).
      *            単位コード/単位名称有効桁数/単位名称
                   07  TBL-ZAIW-TANICD          PIC  9(03).
                   07  TBL-ZAIW-TANIMOJISU      PIC  9(01).
                   07  TBL-ZAIW-TANINAME        PIC  X(24).
      *            点数識別区分/点数/明細請求フラグ
                   07  TBL-ZAIW-TENSIKIBETU     PIC  9(01).
                   07  TBL-ZAIW-TEN             PIC  9(09)V9(02).
                   07  TBL-ZAIW-MEISKYFLG       PIC  X(01).
      *            自動算定区分/名称入力番号/点数欄集計先識別
                   07  TBL-ZAIW-AUTOKBN         PIC  X(01).
                   07  TBL-ZAIW-INPUTNUM        PIC  9(03).
                   07  TBL-ZAIW-TENTTLKBN       PIC  9(03).
               05  TBL-ZAIW-NAMEINF.
      *            漢字有効桁数/漢字名称
                   07  TBL-ZAIW-YUKOKETA        PIC  9(02).
                   07  TBL-ZAIW-NAME            PIC  X(200).
      *
      *    固定値
       01  CONST-AREA.
      *         
      *    適用欄最大文字数（金額欄）
      ***  03  CONS-TEKIYOU1-LEN           PIC 9(02)   VALUE   28.      
           03  CONS-TEKIYOU1-LEN           PIC 9(02)   VALUE   24.      
      *     
      *    適用欄最大文字数（点数欄）
           03  CONS-TEKIYOU2-LEN           PIC 9(02)   VALUE   52.
      *
      *    適用欄最大行数（点数欄）
           03  CONS-TEKIYOU2-LINE-MAX      PIC  9(03)  VALUE   100.   
      *            
      *    適用欄最大行数（金額欄）
      ***  03  CONS-TEKIYOU1-LINE-MAX      PIC  9(03)  VALUE   9.       
           03  CONS-TEKIYOU1-LINE-MAX      PIC  9(03)  VALUE   6.       
      *
      *    パス名領域
       01  WRK-PATH                        PIC X(64).
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    点数
           COPY    "CPTENSU.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *     
      *    数値変換サブ
           COPY    "CPORCSNUM.INC".
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
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
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL       SPA-STS     =   2
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
           INITIALIZE                  SPA-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
      *    ファイルＯＰＥＮ処理
      *
           PERFORM 110-FILE-OPEN-SEC
           PERFORM 120-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0467"      TO  JOB-PGID
           MOVE    "金額摘要欄編集（自賠責）"                           
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 990-RECE41-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＯＰＥＮ処理
      *****************************************************************
       110-FILE-OPEN-SEC          SECTION.
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           MOVE    "RECE410"           TO  RECE01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE01PARA-TERMID
      *
           MOVE    "RECE461"           TO  RECE46PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE46PARA-TERMID
      *
           MOVE    "RECE471"           TO  RECE47PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE47PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE41-FILE
      *
           OPEN    INPUT               RECE46-FILE
      *
           OPEN    OUTPUT              RECE47X-FILE
           CLOSE                       RECE47X-FILE
      *
           OPEN    I-O                 RECE47-FILE
      *
           .
       110-FILE-OPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    行カウンタ初期化
           MOVE    ZERO                TO  WRK-LINENUM
           MOVE    ZERO                TO  WRK-TBLMAX
      *
           INITIALIZE                      TBL-ZAIW-AREA
      *
      *    外来管理加算（特例５２）の編集
           IF      RECE41-GAITOKU-PRTKBN1  =   "1"
               PERFORM 2001-RECE44-ZAIHEN-MAE-SEC
               MOVE    RECE41-GAITOKU-TEN1 TO  WRK-ZAITENX
               MOVE    RECE41-GAITOKU-KAISU1
                                           TO  WRK-ZAIKAISUX
               PERFORM 4304-TENSUKAI-HEN-SEC
               MOVE    "（特）"            TO  WRK-ZAI1-NAME (1:6)                            
               MOVE    WRK-TNSKAI (WRK-TNSKAI-LEN:)
                                           TO
                                        WRK-ZAI1-NAME(WRK-TNSKAI-ST1:)
               MOVE    RECE41-KEY        TO  RECE46-KEY
               MOVE    ZERO              TO  RECE46-GAITENTTLKBN
               MOVE    SPACE             TO  RECE46-SRYCD1
               MOVE    ZERO              TO  RECE46-ZAINUM
               PERFORM 450-RECE47-OUT-SEC                         
           END-IF
      *
      *    外来管理加算（特例２６）の編集
           IF      RECE41-GAITOKU-PRTKBN2  =   "1"
               PERFORM 2001-RECE44-ZAIHEN-MAE-SEC
               MOVE    RECE41-GAITOKU-TEN2 TO  WRK-ZAITENX
               MOVE    RECE41-GAITOKU-KAISU2
                                           TO  WRK-ZAIKAISUX
               PERFORM 4304-TENSUKAI-HEN-SEC
               MOVE    "（特）"            TO  WRK-ZAI1-NAME (1:6)                            
               MOVE    WRK-TNSKAI (WRK-TNSKAI-LEN:)
                                           TO
                                        WRK-ZAI1-NAME(WRK-TNSKAI-ST1:)
               MOVE    RECE41-KEY        TO  RECE46-KEY
               MOVE    ZERO              TO  RECE46-GAITENTTLKBN
               MOVE    SPACE             TO  RECE46-SRYCD1
               MOVE    ZERO              TO  RECE46-ZAINUM
               PERFORM 450-RECE47-OUT-SEC                       
           END-IF
      *
      *    パラメータ０４ファイルより編集
           INITIALIZE                      RECE46-REC
           MOVE    RECE41-HOSPID       TO  RECE46-HOSPID
           MOVE    RECE41-SRYYM        TO  RECE46-SRYYM
           MOVE    RECE41-NYUGAIKBN    TO  RECE46-NYUGAIKBN
           MOVE    RECE41-PTID         TO  RECE46-PTID
           MOVE    RECE41-RECEKA       TO  RECE46-RECEKA
           MOVE    RECE41-HKNID        TO  RECE46-HKNID
           MOVE    RECE41-TEKSTYMD     TO  RECE46-TEKSTYMD
      *
           START   RECE46-FILE
               KEY IS    >=   RECE46-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE46
               NOT INVALID
                   PERFORM 990-RECE46-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( SPA-STS              =   2                )
               OR     ( FLG-RECE46           =   1                )
               OR     ( RECE41-HOSPID    NOT =   RECE46-HOSPID    )
               OR     ( RECE41-SRYYM     NOT =   RECE46-SRYYM     )
               OR     ( RECE41-NYUGAIKBN NOT =   RECE46-NYUGAIKBN )
               OR     ( RECE41-PTID      NOT =   RECE46-PTID      )
               OR     ( RECE41-RECEKA    NOT =   RECE46-RECEKA    )
               OR     ( RECE41-HKNID     NOT =   RECE46-HKNID     )
               OR     ( RECE41-TEKSTYMD  NOT =   RECE46-TEKSTYMD  )
      *
                   PERFORM 2001-RECE44-ZAIHEN-MAE-SEC
      *            
                   PERFORM 2002-TBLZAIW-TAIHI-SEC
      *
                   PERFORM 2003-TEKIYOU-HENSYU-SEC
      *
                   PERFORM 990-RECE46-NEXT-SEC
           END-PERFORM
      *
           PERFORM 990-RECE41-READ-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    剤編集前処理
      *****************************************************************
       2001-RECE44-ZAIHEN-MAE-SEC     SECTION.
      *
           MOVE    SPACE               TO  WRK-ZAI
                                           WRK-ZAI1
           MOVE    ZERO                TO  WRK-CLM
      *
           .
       2001-RECE44-ZAIHEN-MAE-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    明細テーブル退避処理
      *****************************************************************
       2002-TBLZAIW-TAIHI-SEC    SECTION.
      *
           MOVE    RECE46-SRYACTINF  TO  TBL-ZAIW-SRYACTINF
           MOVE    RECE46-NAMEINF    TO  TBL-ZAIW-NAMEINF  
      *
           .
       2002-TBLZAIW-TAIHI-EXT.
           EXIT.
      *****************************************************************
      *    編集処理
      *****************************************************************
       2003-TEKIYOU-HENSYU-SEC    SECTION.
      *
      *    金額・回数編集
           MOVE    TBL-ZAIW-TEN        TO  WRK-ZAITENX
           MOVE    RECE46-ZAIKAISU     TO  WRK-ZAIKAISUX
      *     
           PERFORM 4304-TENSUKAI-HEN-SEC 
      *
      *    明細編集・明細桁数計算
           PERFORM 4302-MEISAI-KETA-HEN1-SEC
      *
      *    剤・診療行為テーブル出力処理
      **** PERFORM 450-RECE47-OUT-SEC
      *
           .
       2003-TEKIYOU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細・明細桁　編集処理
      *****************************************************************
       4302-MEISAI-KETA-HEN1-SEC    SECTION.
      *
      *    名称の長さ
           COMPUTE   WRK-NAMEKETA  =
                         TBL-ZAIW-YUKOKETA 
                         *   2
           MOVE    1                   TO  WRK-ST              
      *
           MOVE    ZERO                TO  FLG-HENSYU
      *     
           PERFORM UNTIL   FLG-HENSYU  =   1  
               IF      WRK-TBLMAX         <   CONS-TEKIYOU1-LINE-MAX 
                   MOVE    SPACE               TO  WRK-ZAI1
                   MOVE    TBL-ZAIW-NAME (WRK-ST:)
                                               TO  WRK-ZAI1-NAME
                   IF      WRK-TNSKAI      NOT =   SPACE                            
                       IF      WRK-ZAI1-NAME (WRK-TNSKAI-ST1:)
                                               =   SPACE
                           MOVE    WRK-TNSKAI (WRK-TNSKAI-LEN:)
                                               TO
                                        WRK-ZAI1-NAME(WRK-TNSKAI-ST1:)
                           MOVE    1               TO  FLG-HENSYU
                       END-IF                 
                   END-IF                                                  
      *            剤・診療行為テーブル編集処理
                   PERFORM 450-RECE47-OUT-SEC
                   COMPUTE WRK-ST          =   WRK-ST         +
                                               CONS-TEKIYOU1-LEN
               ELSE
                   MOVE    SPACE               TO  WRK-ZAI
                   MOVE    TBL-ZAIW-NAME (WRK-ST:)
                                               TO  WRK-ZAI-NAME
                   IF      WRK-TNSKAI      NOT =   SPACE                            
                       IF      WRK-ZAI-NAME (WRK-TNSKAI-ST:)
                                               =   SPACE
                           MOVE    WRK-TNSKAI (WRK-TNSKAI-LEN:)
                                               TO
                                        WRK-ZAI-NAME(WRK-TNSKAI-ST:)
                           MOVE    1               TO  FLG-HENSYU
                       END-IF                 
                   END-IF                                                  
      *            剤・診療行為テーブル編集処理
                   PERFORM 450-RECE47-OUT-SEC
                   COMPUTE WRK-ST          =   WRK-ST         +
                                               CONS-TEKIYOU2-LEN
               END-IF
      *
      *　　　　金額の編集がないときまだ印刷する文字があるか         
               IF      WRK-TNSKAI          =   SPACE                            
                   IF      TBL-ZAIW-NAME (WRK-ST:)
                                               =   SPACE
                       MOVE    1               TO  FLG-HENSYU
                   END-IF                                                  
           END-PERFORM        
           .
       4302-MEISAI-KETA-HEN1-EXT.
           EXIT.
      *
      *****************************************************************
      *    金額・回数編集処理
      *****************************************************************
       4304-TENSUKAI-HEN-SEC    SECTION.
      *
           INITIALIZE              WRK-TNSKAI-AREA
      *
           IF      TBL-ZAIW-SRYCD (1:1)
                                   =   "8"
               GO  TO  4304-TENSUKAI-HEN-EXT
           END-IF
      *                                           
           INITIALIZE              ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI 
           MOVE    WRK-ZAITENX(5:5)
                                   TO  KANACHK-MAE-INPUT (1:5)
           MOVE    "X"             TO  KANACHK-MAE-INPUT (6:1)
           MOVE    WRK-ZAIKAISUX (2:3)
                                   TO  KANACHK-MAE-INPUT (7:3)
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      KANACHK-RC      =   ZERO
               MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                       TO  WRK-TNSKAI
               MOVE    "×"                TO  WRK-X
           END-IF
      *
      *    必要有効桁数（点数ZZZZZ X 数量ZZZ の全角の桁数）
           MOVE    ZERO                TO  WRK-TNSKAI-KETA
           PERFORM VARYING   IDZ     FROM    1   BY  2
                   UNTIL     IDZ     >       18
               IF      WRK-TNSKAI (IDZ:2)      NOT =   SPACE
                   COMPUTE WRK-TNSKAI-KETA   =   18  -  IDZ     +   1
                   MOVE    IDZ                 TO  WRK-TNSKAI-LEN 
                   MOVE    18                  TO  IDZ
               END-IF 
           END-PERFORM
      *     
      *    印刷開始位置を取得
           COMPUTE   WRK-TNSKAI-ST     =   ( CONS-TEKIYOU2-LEN  -
                                             WRK-TNSKAI-KETA      )
                                       +   1
           COMPUTE   WRK-TNSKAI-ST1    =   ( CONS-TEKIYOU1-LEN  -
                                             WRK-TNSKAI-KETA      )
                                       +   1
      *
           .
       4304-TENSUKAI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０６出力処理
      *****************************************************************
       450-RECE47-OUT-SEC    SECTION.
      *
           ADD     1                   TO  WRK-LINENUM
           MOVE    SPACE               TO  RECE47-REC
           INITIALIZE                      RECE47-REC
      *     
           IF      WRK-TBLMAX         <   CONS-TEKIYOU1-LINE-MAX 
               ADD     1                   TO  WRK-TBLMAX
               MOVE    WRK-ZAI1            TO  RECE47-TEKIYO-INF
           ELSE    
               MOVE    WRK-ZAI             TO  RECE47-TEKIYO-INF
           END-IF
      *     
           PERFORM 4501-RECE47-HENSYU-SEC
      *
           MOVE    SPACE                TO  WRK-ZAI
                                            WRK-ZAI1
           .
       450-RECE47-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０６編集処理
      *****************************************************************
       4501-RECE47-HENSYU-SEC    SECTION.
      *
           MOVE    RECE46-KEY        TO  RECE47-KEY
           MOVE    WRK-LINENUM       TO  RECE47-LINENUM
           MOVE    RECE46-PTNUM      TO  RECE47-PTNUM
           MOVE    RECE46-SRYKA      TO  RECE47-SRYKA
           MOVE    RECE46-SRYKBN     TO  RECE47-SRYKBN
      *
           WRITE   RECE47-REC
           IF      STS-RECE47          NOT =   ZERO
               DISPLAY "*** ORCR0467 RECE47 WRITE ERR  ***"
               MOVE    2             TO  SPA-STS                       
           ELSE
               ADD     1             TO  CNT-RECE47
           END-IF    
      *
           .
       4501-RECE47-HENSYU-EXT.
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
           CLOSE                       RECE41-FILE
           CLOSE                       RECE47-FILE
           CLOSE                       RECE46-FILE     
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
           DISPLAY "RECE41  IN  " CNT-RECE41   
           DISPLAY "RECE47  CNT " CNT-RECE47 
           DISPLAY "*** ORCR0467 END ***"
      ***     ACCEPT  WRK-IN FROM CONSOLE 
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       990-RECE41-READ-SEC           SECTION.
      *
           READ    RECE41-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
                   MOVE    2           TO  SPA-STS
               NOT AT  END
                   ADD     1           TO  CNT-RECE41
                   MOVE    ZERO        TO  FLG-END
           END-READ
      *
           .
       990-RECE41-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０４データ読み
      ****************************************************************
       990-RECE46-NEXT-SEC           SECTION.
      *
           READ    RECE46-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE46
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE46
           END-READ
      *
           .
       990-RECE46-NEXT-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       120-DBOPEN-SEC                SECTION.
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
