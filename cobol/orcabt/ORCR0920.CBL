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
       PROGRAM-ID.             ORCR0920.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト入院（労災・自賠責）
      *  コンポーネント名  : 月次業務　労災自賠責明細書ファイル作成
      *                      （金額摘要欄並び替え）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/06/01    NACL-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
           SELECT  RECE82-FILE     ASSIGN  RECE01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE82-KEY
                                   FILE    STATUS  IS  STS-RECE82.
      *   
           SELECT  RECE84-FILE     ASSIGN  RECE84PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE84-KEY
                                   FILE    STATUS  IS  STS-RECE84.
      *    
           SELECT  RECE85-FILE     ASSIGN  RECE85PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE85-KEY
                                   FILE    STATUS  IS  STS-RECE85.
      *   
           SELECT  RECE86-FILE     ASSIGN  RECE86PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE86-KEY
                                   FILE    STATUS  IS  STS-RECE86.
      *    
           SELECT  RECE86X-FILE     ASSIGN  RECE86PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE86X-KEY
                                   FILE    STATUS  IS  STS-RECE86.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       FD  RECE82-FILE.
       01  RECE82-REC.
           COPY    "CPRCF082.INC".
      *
       FD  RECE84-FILE.
       01  RECE84-REC.
           COPY    "CPRCF084.INC".
      *
       FD  RECE85-FILE.
       01  RECE85-REC.
           COPY    "CPRCF085.INC".
      *
       FD  RECE86-FILE.
       01  RECE86-REC. 
           COPY    "CPRCF0861.INC" REPLACING  //RECE861//
                                   BY         //RECE86//.
      *
       FD  RECE86X-FILE.
       01  RECE86X-REC. 
           COPY    "CPRCF0861.INC" REPLACING  //RECE861//
                                   BY         //RECE86X//.
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
                                   BY         //RECE84//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE85//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE86//.
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
           03  STS-RECE82          PIC X(02).
           03  STS-RECE84          PIC X(02).
           03  STS-RECE85          PIC X(02).
           03  STS-RECE86          PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE82          PIC 9(01).
           03  FLG-RECE84          PIC 9(01).
           03  FLG-RECE85          PIC 9(01).
      ***  03  FLG-TENSU           PIC 9(01).
           03  FLG-SP              PIC 9(01).
           03  FLG-NOPRT           PIC 9(01).
           03  FLG-HENSYU          PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE82          PIC 9(06).
           03  CNT-RECE84          PIC 9(06).
           03  CNT-RECE85          PIC 9(06).
           03  CNT-RECE86          PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
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
      *
      *    剤印字行数
           03  WRK-TBLMAX          PIC 9(03).
      *    剤明細総数
           03  WRK-ZAIWMAX         PIC 9(03).
      *     
           03  WRK-WLINETEK                    PIC 9(03).
           03  WRK-SRYSURYOW                   PIC X(20).
           03  WRK-ZAIIDX                      PIC 9(03).
           03  WRK-NAMEKETA                    PIC 9(03).
           03  WRK-YOHAKU                      PIC 9(03).
           03  WRK-WKETA                       PIC 9(03).
      *    剤診療行為コード別編集用     
           03  WRK-WIDX1                       PIC 9(03).
      *     
           03  WRK-SRYKBN                      PIC X(02).
           03  WRK-Z9                          PIC ZZZ9.
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
           03  TBL-ZAIW-OCC               OCCURS 100.
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
      *    診療行為別テーブル（出力用）
       01  TBL-ZAI-AREA.
           03  TBL-ZAI-OCC               OCCURS 100.
               05  TBL-ZAI-SRYACTINF.
      *            診療コード/数量/回数
                   07  TBL-ZAI-SRYCD           PIC  X(09).
                   07  TBL-ZAI-SRYSURYO        PIC  9(05)V9(03).
                   07  TBL-ZAI-SRYKAISU        PIC  9(03).
      *            単位コード/単位名称有効桁数/単位名称
                   07  TBL-ZAI-TANICD          PIC  9(03).
                   07  TBL-ZAI-TANIMOJISU      PIC  9(01).
                   07  TBL-ZAI-TANINAME        PIC  X(24).
      *            点数識別区分/点数/明細請求フラグ
                   07  TBL-ZAI-TENSIKIBETU     PIC  9(01).
                   07  TBL-ZAI-TEN             PIC  9(09)V9(02).
                   07  TBL-ZAI-MEISKYFLG       PIC  X(01).
      *            自動算定区分/名称入力番号/点数欄集計先識別
                   07  TBL-ZAI-AUTOKBN         PIC  X(01).
                   07  TBL-ZAI-INPUTNUM        PIC  9(03).
                   07  TBL-ZAI-TENTTLKBN       PIC  9(03).
               05  TBL-ZAI-NAMEINF.
      *            漢字有効桁数/漢字名称
                   07  TBL-ZAI-YUKOKETA        PIC  9(02).
                   07  TBL-ZAI-NAME            PIC  X(200).
      *
      *    固定値
       01  CONST-AREA.
      *    初診
           03  CONS-SYOSHIN    PIC X(09)   VALUE   "101110010".
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
      ***  COPY    "CPTENSU.INC".
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
           INITIALIZE                  TBL-ZAI-AREA
           INITIALIZE                  TBL-ZAIW-AREA
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
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
           MOVE    "ORCR0920"      TO  JOB-PGID
           MOVE    "金額摘要欄並び替え（労災・自賠責）"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 990-RECE82-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＯＰＥＮ処理
      *****************************************************************
       110-FILE-OPEN-SEC          SECTION.
      *
           MOVE    "RECE820"           TO  RECE01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE01PARA-TERMID
      *
           MOVE    "RECE84B"           TO  RECE84PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE84PARA-TERMID
      *
           MOVE    "RECE85B"           TO  RECE85PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE85PARA-TERMID
      *
           MOVE    "RECE861"           TO  RECE86PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE86PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE82-FILE
      *
           OPEN    INPUT               RECE84-FILE
      *
           OPEN    INPUT               RECE85-FILE
      *
           OPEN    OUTPUT              RECE86X-FILE
           CLOSE                       RECE86X-FILE
      *
           OPEN    I-O                 RECE86-FILE
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
           INITIALIZE                  TBL-ZAI-AREA
           MOVE    ZERO                TO  WRK-TBLMAX
      *
      *    パラメータ０４ファイルより編集
           INITIALIZE                      RECE84-REC
           MOVE    RECE82-HOSPID       TO  RECE84-HOSPID
           MOVE    RECE82-SRYYM        TO  RECE84-SRYYM
           MOVE    RECE82-NYUGAIKBN    TO  RECE84-NYUGAIKBN
           MOVE    RECE82-PTID         TO  RECE84-PTID
           MOVE    RECE82-RECEKA       TO  RECE84-RECEKA
           MOVE    RECE82-HKNID        TO  RECE84-HKNID
           MOVE    RECE82-TEKSTYMD     TO  RECE84-TEKSTYMD
           MOVE    ZERO                TO  RECE84-ZAINUM
      *
           START   RECE84-FILE
               KEY IS    >=   RECE84-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE84
               NOT INVALID
                   PERFORM 990-RECE84-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( SPA-STS              =   2                )
               OR     ( FLG-RECE84           =   1                )
               OR     ( RECE82-HOSPID    NOT =   RECE84-HOSPID    )
               OR     ( RECE82-SRYYM     NOT =   RECE84-SRYYM     )
               OR     ( RECE82-NYUGAIKBN NOT =   RECE84-NYUGAIKBN )
               OR     ( RECE82-PTID      NOT =   RECE84-PTID      )
               OR     ( RECE82-RECEKA    NOT =   RECE84-RECEKA    )
               OR     ( RECE82-HKNID     NOT =   RECE84-HKNID     )
               OR     ( RECE82-TEKSTYMD  NOT =   RECE84-TEKSTYMD  )
      *
               PERFORM 2002-TBLZAIW-TAIHI-SEC
      *
               IF      SPA-STS          =   ZERO
      *            レセプト０４ファイル編集処理
                   PERFORM 2003-SRYKBN11-HENSYU-SEC
      *
                   ADD     1               TO  CNT-RECE84
      *
                   PERFORM 990-RECE84-NEXT-SEC
               END-IF     
           END-PERFORM
      *
           PERFORM 990-RECE82-READ-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細テーブル退避処理
      *****************************************************************
       2002-TBLZAIW-TAIHI-SEC    SECTION.
      *
           INITIALIZE                      TBL-ZAIW-AREA
           MOVE    ZERO                TO  WRK-ZAIWMAX
           MOVE    ZERO                TO  WRK-TBLMAX
           MOVE    ZERO                TO  IDY                           
      *
      *    パラメータ０５ファイルより編集
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPID       TO  RECE85-HOSPID
           MOVE    RECE84-SRYYM        TO  RECE85-SRYYM
           MOVE    RECE84-NYUGAIKBN    TO  RECE85-NYUGAIKBN
           MOVE    RECE84-PTID         TO  RECE85-PTID
           MOVE    RECE84-RECEKA       TO  RECE85-RECEKA
           MOVE    RECE84-HKNID        TO  RECE85-HKNID
           MOVE    RECE84-TEKSTYMD     TO  RECE85-TEKSTYMD
           MOVE    RECE84-ZAINUM       TO  RECE85-ZAINUM
           START   RECE85-FILE
               KEY IS    >=   RECE85-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE85
               NOT INVALID
                   PERFORM 990-RECE85-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( SPA-STS              =   2                   )
               OR     ( FLG-RECE85           =   1                   )
               OR     ( RECE84-HOSPID    NOT =   RECE85-HOSPID       )
               OR     ( RECE84-SRYYM     NOT =   RECE85-SRYYM        )
               OR     ( RECE84-NYUGAIKBN NOT =   RECE85-NYUGAIKBN    )
               OR     ( RECE84-PTID      NOT =   RECE85-PTID         )
               OR     ( RECE84-RECEKA    NOT =   RECE85-RECEKA       )
               OR     ( RECE84-HKNID     NOT =   RECE85-HKNID        )
               OR     ( RECE84-TEKSTYMD  NOT =   RECE85-TEKSTYMD     )
               OR     ( RECE84-ZAINUM    NOT =   RECE85-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE85-SRYCD(IDX) =   SPACE )
                         OR      ( SPA-STS           =   2     ) 
                   IF      RECE85-SIKFLG (IDX)         =   "2"        
      *
                       ADD     1                 TO  WRK-ZAIWMAX 
                       IF      WRK-ZAIWMAX       >   100
                           MOVE    "テーブルがオーバーしました"
                                                     TO  WRK-RECEERR
                           PERFORM 500-ERR-HENSYU-SEC
                           MOVE    2                 TO  SPA-STS
                           GO  TO  2002-TBLZAIW-TAIHI-EXT
                       ELSE
                           MOVE    WRK-ZAIWMAX       TO  IDZ
                           MOVE    RECE85-SRYACTINF (IDX)
                                             TO  TBL-ZAIW-SRYACTINF(IDZ)
                           MOVE    RECE85-NAMEINF   (IDX)
                                             TO  TBL-ZAIW-NAMEINF  (IDZ)
                       END-IF
                   END-IF  
               END-PERFORM
               ADD     1                 TO  CNT-RECE85
      *
               PERFORM 990-RECE85-NEXT-SEC
           END-PERFORM
      *
           .
       2002-TBLZAIW-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    編集処理
      *****************************************************************
       2003-SRYKBN11-HENSYU-SEC    SECTION.
      *
      *    剤　明細テーブルチェック
           INITIALIZE                    TBL-ZAI-AREA
           MOVE    ZERO              TO  WRK-TBLMAX
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       WRK-ZAIWMAX   
               MOVE    IDX1          TO  WRK-WIDX1
               PERFORM 20031-SRYKBN-CHECK-SEC
               IF      FLG-NOPRT         =   ZERO
      *            レセプト０５剤編集処理
                   PERFORM 430-TBLZAI-HEN-SEC
               END-IF
           END-PERFORM    
      *
           IF       WRK-TBLMAX           >   ZERO
      *        剤・診療行為テーブル出力処理
               PERFORM 450-RECE86-OUT-SEC
           END-IF
      *
           .
       2003-SRYKBN11-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細印字チェック 診療区分（１１）処理
      *****************************************************************
       20031-SRYKBN-CHECK-SEC        SECTION.
      * 
           MOVE    ZERO          TO  FLG-NOPRT
      *
           EVALUATE    RECE84-SRYKBN
               WHEN    "11"
                   IF  TBL-ZAIW-SRYCD (WRK-WIDX1)
                                             =   CONS-SYOSHIN
                       MOVE    1                 TO  FLG-NOPRT
                   END-IF
           END-EVALUATE            
      *
           .
       20031-SRYKBN-CHECK-EXT.
           EXIT.
      *     
      *****************************************************************
      *    剤テーブル編集処理
      *****************************************************************
       430-TBLZAI-HEN-SEC     SECTION.
      *
           ADD     1                TO  WRK-TBLMAX
           IF  WRK-TBLMAX           >   100
               DISPLAY "*** ORCR0920 TBL-ZAI INDEX[100] OVER  ***"
           ELSE
               MOVE    TBL-ZAIW-SRYACTINF (IDX1)
                                       TO  TBL-ZAI-SRYACTINF(WRK-TBLMAX)
               MOVE    TBL-ZAIW-NAMEINF   (IDX1)
                                       TO  TBL-ZAI-NAMEINF  (WRK-TBLMAX)
           END-IF    
           .
       430-TBLZAI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０６出力処理
      *****************************************************************
       450-RECE86-OUT-SEC    SECTION.
      *               
           PERFORM   VARYING   IDY   FROM    1   BY  1
                     UNTIL     IDY   >   WRK-TBLMAX
               ADD     1                 TO  WRK-LINENUM
               MOVE    SPACE             TO  RECE86-REC
               INITIALIZE                    RECE86-REC
               MOVE    TBL-ZAI-SRYACTINF (IDY)
                                         TO  RECE86-SRYACTINF
               MOVE    TBL-ZAI-NAMEINF  (IDY)
                                         TO  RECE86-NAMEINF 
               PERFORM 4501-RECE86-HENSYU-SEC
           END-PERFORM
      *     
           INITIALIZE                    TBL-ZAI-AREA
           MOVE    ZERO                  TO  WRK-TBLMAX
      *
           .
       450-RECE86-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０６編集処理
      *****************************************************************
       4501-RECE86-HENSYU-SEC    SECTION.
      *
           MOVE    RECE82-KEY        TO  RECE86-KEY
           MOVE    RECE84-PTNUM      TO  RECE86-PTNUM
           MOVE    RECE84-SRYKA      TO  RECE86-SRYKA
           MOVE    RECE84-SRYKBN     TO  RECE86-SRYKBN 
           MOVE    RECE84-ZAIKAISU   TO  RECE86-ZAIKAISU 
           MOVE    TBL-ZAI-SRYCD (1) TO  RECE86-SRYCD1
           MOVE    RECE84-ZAINUM     TO  RECE86-ZAINUM
           MOVE    WRK-LINENUM       TO  RECE86-LINENUM
      *---------適用欄並び替え用の編集（表用番号等）-----------------
      ***  IF      IDY               =   1                           
      ***      INITIALIZE                           TNS-TENSU-REC    
      ***      MOVE    TBL-ZAI-SRYCD (1)    TO      TNS-SRYCD        
      ***      MOVE    TNS-TENSU-REC        TO      MCPDATA-REC      
      ***      MOVE    RECE84-SRYYM         TO      ORC-DBYMD(1:6)   
      ***      MOVE    "01"                 TO      ORC-DBYMD(7:2)   
      ***      PERFORM 900-TENSU-INV-SEC                             
      ***      IF      FLG-TENSU            =       1                
      ***          INITIALIZE               TNS-TENSU-REC            
      ***      END-IF                                                
      ***  END-IF                                                    
           IF ( RECE86-SRYKBN        =  "40"              ) AND      
              ( RECE86-SRYCD1(1:5)   =  "09593"           )          
              MOVE    999               TO  RECE86-NYUTENTTLKBN      
           ELSE                                                      
              IF ( RECE86-SRYKBN        =  "40"              ) AND   
                 ( RECE86-SRYCD1(1:5)   =  "09594"           )       
                 MOVE    998               TO  RECE86-NYUTENTTLKBN   
              ELSE          
      ***        MOVE    TNS-NYUTENTTLKBN  TO  RECE86-NYUTENTTLKBN      
                 MOVE    TBL-ZAI-TENTTLKBN(1)                           
                                           TO  RECE86-NYUTENTTLKBN      
              END-IF
           END-IF                                                       
      *
           WRITE   RECE86-REC
           IF      STS-RECE86          NOT =   ZERO
               DISPLAY "*** ORCR0920 RECE86 WRITE ERR  ***"
               MOVE   WRK-TBLMAX     TO  IDY
               MOVE    2             TO  SPA-STS                       
           ELSE
               ADD     1             TO  CNT-RECE86
           END-IF    
      *
           .
       4501-RECE86-HENSYU-EXT.
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
           CLOSE                       RECE82-FILE
           CLOSE                       RECE84-FILE
           CLOSE                       RECE85-FILE
           CLOSE                       RECE86-FILE     
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
           DISPLAY "RECE82  IN  " CNT-RECE82   
           DISPLAY "RECE86  CNT " CNT-RECE86 
           DISPLAY "*** ORCR0920 END ***"
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       990-RECE82-READ-SEC           SECTION.
      *
           READ    RECE82-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
                   MOVE    2           TO  SPA-STS
               NOT AT  END
                   ADD     1           TO  CNT-RECE82
                   MOVE    ZERO        TO  FLG-END
      *
                   DISPLAY "RECE82  PTNUM=" RECE82-PTNUM
      *
           END-READ
      *
           .
       990-RECE82-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０４データ読み
      ****************************************************************
       990-RECE84-NEXT-SEC           SECTION.
      *
           READ    RECE84-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE84
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE84
                   IF      RECE84-MEISAISU    =   ZERO
                       GO  TO  990-RECE84-NEXT-SEC
                   END-IF       
           END-READ
      *
           .
       990-RECE84-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０５データ読み
      ****************************************************************
       990-RECE85-NEXT-SEC           SECTION.
      *
           READ    RECE85-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE85
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE85
           END-READ
      *
           .
       990-RECE85-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込（キー）
      *****************************************************************
      * 900-TENSU-INV-SEC         SECTION.                             
      *
      *     MOVE    "DBSELECT"          TO  MCP-FUNC
      *     MOVE    "TENSU-KEY"         TO  ORC-DBPATH
      *     CALL    "ORCMCPSUB"          USING
      *                                  MCPAREA
      *                                  ORCMCPAREA
      *                                  MCPDATA-REC
      *     IF      MCP-RC              =   ZERO
      *         MOVE    "DBFETCH"           TO  MCP-FUNC
      *         MOVE    "TENSU-KEY"         TO  ORC-DBPATH
      *         CALL    "ORCMCPSUB"          USING
      *                                      MCPAREA
      *                                      ORCMCPAREA
      *                                      MCPDATA-REC
      *         IF      MCP-RC              =   ZERO
      *             MOVE    ZERO                TO  FLG-TENSU
      *             MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
      *         ELSE
      *             INITIALIZE                  TNS-TENSU-REC
      *             MOVE    1                   TO  FLG-TENSU
      *         END-IF
      *     ELSE
      *         INITIALIZE                  TNS-TENSU-REC
      *         MOVE    1                   TO  FLG-TENSU
      *     END-IF
      *
      *     MOVE    "DBCLOSE"           TO  MCP-FUNC
      *     MOVE    "TENSU-KEY"         TO  ORC-DBPATH
      *     CALL    "ORCMCPSUB"          USING
      *                                  MCPAREA
      *                                  ORCMCPAREA
      *                                  MCPDATA-REC
      *
      *     .
      * 900-TENSU-INV-EXT.
      *     EXIT.
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
       900-DBDISCONNECT-EXT.
           EXIT.
