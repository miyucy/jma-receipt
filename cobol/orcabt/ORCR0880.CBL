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
       PROGRAM-ID.             ORCR0880.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト入院（労災・自賠責）
      *  コンポーネント名  : 月次業務　労災自賠責明細書ファイル作成
      *                      コメント編集２（労災・自賠責）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/06/01    NACL-門脇　    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-門脇    04/06/07  コピー句０８５変更に伴う修正
      *  中止処理追加
      *  01.01.01    NACL-藤原    04/10/13  中止処理の追加
      *  01.01.02    NACL-門脇    05/07/15  自賠責従来様式対応
      *  02.09.01    NACL-門脇    06/04/13  ２００６年４月改正対応
      *  02.09.02    NACL-門脇    06/04/26  救急医療管理加算コメント編集修正
      *  03.04.01    NACL-門脇    06/12/01  自賠責健保準拠対応
      *
      *  03.05.01    NACL-門脇    07/06/01  グループ診療対応
      *  03.05.02    NACL-藤原    07/06/01  realtime preview 処理追加
      *  04.01.01    NACL-門脇    07/11/01  公務災害対応
      *  04.01.02    NACL-門脇    07/11/26  特定器材商品名記載対応
      *
      *  04.03.01    NACL-門脇    08/09/25  自賠責０９５９３の集計先対応
      *
      *  04.06.01    NACL-門脇    13/02/18  労災レセ電対応
      *                                     （新診療行為コード対応）
      *
      *  04.07.01    NACL-門脇    13/01/21  労災レセ電対応
      *  04.07.02    NACL-門脇    13/10/02  自賠責（第三者行為）対応
      *  04.07.03    NACL-門脇    14/05/08  救急医療管理加算の算定日記載
      *                                     やめる
      *  04.07.04    NACL-門脇    14/07/08  明細が５０を超える場合の対応
      *
      *  04.08.01    NACL-藤原    14/07/07  一時ディレクトリ対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
           SELECT  RECE82-FILE     ASSIGN  RECE82PARA
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
           SELECT  RECE841-FILE    ASSIGN  RECE841PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE841-KEY
                                   FILE    STATUS  IS  STS-RECE841.
      *
           SELECT  RECE851-FILE    ASSIGN  RECE851PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE851-KEY
                                   FILE    STATUS  IS  STS-RECE851.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       FD  RECE82-FILE.
       01  RECE82-REC.
           COPY    "CPRCF082.INC".
      *
      *
       FD  RECE84-FILE.
       01  RECE84-REC.
           COPY    "CPRCF084.INC".
      *
      *
       FD  RECE85-FILE.
       01  RECE85-REC.
           COPY    "CPRCF085.INC".
      *
       FD  RECE841-FILE.
       01  RECE841-REC. 
           COPY    "CPRCF084.INC"  REPLACING   //RECE84//
                                   BY          //RECE841//.
      *
       FD  RECE851-FILE.
       01  RECE851-REC. 
           COPY    "CPRCF085.INC"  REPLACING   //RECE85//
                                   BY          //RECE851//.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *     レセプト明細ファイル 名称領域 
           COPY    "CPRECEDAT1.INC"
                                   REPLACING  //RECEDAT1//
                                   BY         //RECE82//.
      *
           COPY    "CPRECEDAT1.INC"
                                   REPLACING  //RECEDAT1//
                                   BY         //RECE84//.
      *
           COPY    "CPRECEDAT1.INC"
                                   REPLACING  //RECEDAT1//
                                   BY         //RECE85//.
      *
           COPY    "CPRECEDAT1.INC"
                                   REPLACING  //RECEDAT1//
                                   BY         //RECE841//.
      *
           COPY    "CPRECEDAT1.INC"
                                   REPLACING  //RECEDAT1//
                                   BY         //RECE851//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPERRFL.INC"   REPLACING  //ERRFLPARA//
                                   BY         //RECEERR//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE82          PIC X(02).
           03  STS-RECE84          PIC X(02).
           03  STS-RECE841         PIC X(02).
           03  STS-RECE85          PIC X(02).
           03  STS-RECE851         PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE84          PIC 9(01).
           03  FLG-RECE85          PIC 9(01).
           03  FLG-WRKRECE85       PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-NYU-RENZOKU     PIC 9(01).
           03  FLG-COMMENT         PIC 9(02).
      *    
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE82          PIC 9(06).
           03  CNT-RECE84          PIC 9(06).
           03  CNT-RECE85          PIC 9(06).
           03  CNT-IN-CANCEL       PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDW                 PIC 9(04).
           03  DAY-IDX             PIC 9(02).
           03  IDX-RECE85          PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM              PIC  X(06).
               05  WRK-PARA-TERMID             PIC  X(16).
               05  WRK-PARA-SYSYMD             PIC  X(08).
               05  WRK-PARA-RECEKBN            PIC  X(01).
               05  WRK-PARA-JOBID              PIC  9(07).
               05  WRK-PARA-SHELLID            PIC  X(08).
           03  WRK-PARA-JIBAIPRTKBN            PIC  X(01).
           03  WRK-PARA-HOSPNUM                PIC  9(02).
      *
           03  WRK-RECEERR         PIC X(200).
           03  WRK-RENNUM          PIC 9(02).
           03  WRK-CNT-MEISAI      PIC 9(04).
      *
           03  WRK-TAIHI-SRYYMD.
               05  WRK-TAIHI-SRYYM             PIC  9(06).
               05  WRK-TAIHI-SRYD              PIC  9(02).
      *
       01  WRK-RECE85-REC. 
           COPY    "CPRCF085.INC"  REPLACING   //RECE85//
                                   BY          //WRK-RECE85//.
      *
       01  WRK-RECE85XX-REC.
         02 WRK-RECE85XX-TBL       OCCURS 100.
           COPY    "CPRCF085.INC"  REPLACING   //RECE85//
                                   BY          //WRK-RECE85XX//.
      *
       01  MAX-MEISAISU            PIC 9(07).
      *
       01  WRK-FREE-AREA2.
           03  WRK-FREEINF2                  OCCURS 50.
               05  WK-FREE-YUKOKETA2         PIC  9(03).
               05  WK-FREE-NAME2             PIC  X(200).
               05  WK-FREE-MEISKYFLG2        PIC  X(01).
               05  WK-FREE-SETCOMATFLG2      PIC  9(03).
      *
       01  WRK-JIDO-SETCOM-AREA.
           03  WRK-JIDO-SETCOMATFLG          PIC  9(03).
           03  WRK-JIDO-SETCOMFLG            PIC  X(01).
      *
       01  TBL-NYU-DAY.
           03  TBL-NYU-DAY-OCC               OCCURS  31.
               05  TBL-NYU-DAY-ST            PIC 9(02).
               05  TBL-NYU-DAY-ED            PIC 9(02).
               05  TBL-NYU-DAY-FLG           PIC 9(01).
      *
      *    日付全角変換領域
       01  TBL-TUKI-AREA.
           03  FILLER              PIC X(04)  VALUE "　１".
           03  FILLER              PIC X(04)  VALUE "　２".
           03  FILLER              PIC X(04)  VALUE "　３".
           03  FILLER              PIC X(04)  VALUE "　４".
           03  FILLER              PIC X(04)  VALUE "　５".
           03  FILLER              PIC X(04)  VALUE "　６".
           03  FILLER              PIC X(04)  VALUE "　７".
           03  FILLER              PIC X(04)  VALUE "　８".
           03  FILLER              PIC X(04)  VALUE "　９".
           03  FILLER              PIC X(04)  VALUE "１０".
           03  FILLER              PIC X(04)  VALUE "１１".
           03  FILLER              PIC X(04)  VALUE "１２".
       01  TBL-TUKI-AREA-R         REDEFINES   TBL-TUKI-AREA.
           03  TBL-TUKI            PIC X(04)   OCCURS   12.
      *
      *    日付全角変換領域
       01  TBL-DAY-AREA.
           03  FILLER              PIC X(04)  VALUE "　１".
           03  FILLER              PIC X(04)  VALUE "　２".
           03  FILLER              PIC X(04)  VALUE "　３".
           03  FILLER              PIC X(04)  VALUE "　４".
           03  FILLER              PIC X(04)  VALUE "　５".
           03  FILLER              PIC X(04)  VALUE "　６".
           03  FILLER              PIC X(04)  VALUE "　７".
           03  FILLER              PIC X(04)  VALUE "　８".
           03  FILLER              PIC X(04)  VALUE "　９".
           03  FILLER              PIC X(04)  VALUE "１０".
           03  FILLER              PIC X(04)  VALUE "１１".
           03  FILLER              PIC X(04)  VALUE "１２".
           03  FILLER              PIC X(04)  VALUE "１３".
           03  FILLER              PIC X(04)  VALUE "１４".
           03  FILLER              PIC X(04)  VALUE "１５".
           03  FILLER              PIC X(04)  VALUE "１６".
           03  FILLER              PIC X(04)  VALUE "１７".
           03  FILLER              PIC X(04)  VALUE "１８".
           03  FILLER              PIC X(04)  VALUE "１９".
           03  FILLER              PIC X(04)  VALUE "２０".
           03  FILLER              PIC X(04)  VALUE "２１".
           03  FILLER              PIC X(04)  VALUE "２２".
           03  FILLER              PIC X(04)  VALUE "２３".
           03  FILLER              PIC X(04)  VALUE "２４".
           03  FILLER              PIC X(04)  VALUE "２５".
           03  FILLER              PIC X(04)  VALUE "２６".
           03  FILLER              PIC X(04)  VALUE "２７".
           03  FILLER              PIC X(04)  VALUE "２８".
           03  FILLER              PIC X(04)  VALUE "２９".
           03  FILLER              PIC X(04)  VALUE "３０".
           03  FILLER              PIC X(04)  VALUE "３１".
       01  TBL-DAY-AREA-R          REDEFINES   TBL-DAY-AREA.
           03  TBL-DAY             PIC X(04)   OCCURS   31.
      *
      *    固定値
       01  CONST-AREA.
      *    救急医療管理加算
           03  CONS-KYUKYU         PIC X(09)  VALUE   "101110020".
           03  CONS-KYUKYU2        PIC X(09)  VALUE   "101800880".
      *
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
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    診療科目情報
           COPY    "CPSK1005.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
           COPY    "CPORCSGETTEMP.INC".
      *     
      *    数値変換サブ
           COPY    "CPORCSNUM.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
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
                   UNTIL   FLG-END  =  1
      *
           PERFORM 300-END-SEC
      *
           IF      WRK-PARA-SHELLID    NOT =   "RECEPTX"
               STOP    RUN
           ELSE
               EXIT    PROGRAM
           END-IF 
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
           INITIALIZE                  SPA-AREA
           INITIALIZE                  RECEERR
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO    WRK-PARA
                                               WRK-PARA-JIBAIPRTKBN
                                               WRK-PARA-HOSPNUM
                                               RECEERR
           END-UNSTRING
           MOVE    WRK-PARA-HOSPNUM    TO  SPA-HOSPNUM
      *
      *    ファイルＯＰＥＮ処理
      *
           PERFORM 110-FILE-OPEN-SEC
      *
           IF      WRK-PARA-SHELLID    NOT =   "RECEPTX"
               PERFORM 120-DBOPEN-SEC
      *
      *        ステップ管理開始処理
               MOVE    "STS"               TO  SJOBKANRI-MODE
               INITIALIZE                      JOBKANRI-REC
               MOVE    "ORCR0880"          TO  JOB-PGID
               MOVE    "コメント編集２（労災・自賠責）"
                                           TO  JOB-SHELLMSG
grpsys         PERFORM 900-CALL-ORCSJOB-SEC
      *
      *        処理中止設定処理
               PERFORM 500-CANCEL-HENSYU-SEC
           END-IF 
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
           MOVE    SPACE               TO  RECE82PARA
           INITIALIZE                      RECE82PARA
           MOVE    "RECE820"           TO  RECE82PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE82PARA-TERMID
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  RECE82PARA-HOSPNUM
      *
           MOVE    SPACE               TO  RECE84PARA
           INITIALIZE                      RECE84PARA
           MOVE    "RECE84X"           TO  RECE84PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE84PARA-TERMID
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  RECE84PARA-HOSPNUM
      *
           MOVE    SPACE               TO  RECE85PARA
           INITIALIZE                      RECE85PARA
           MOVE    "RECE851"           TO  RECE85PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE85PARA-TERMID
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  RECE85PARA-HOSPNUM
      *
           MOVE    SPACE               TO  RECE841PARA
           INITIALIZE                      RECE841PARA
           MOVE    "RECE84B"           TO  RECE841PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE841PARA-TERMID
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  RECE841PARA-HOSPNUM
      *
           MOVE    SPACE               TO  RECE851PARA
           INITIALIZE                      RECE851PARA
           MOVE    "RECE85B"           TO  RECE851PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE851PARA-TERMID
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  RECE851PARA-HOSPNUM
      *
           INITIALIZE                      SGETTEMP-AREA
           MOVE    RECEERR             TO  SGETTEMP-BASENAMES  (1)
           MOVE    RECE82PARA-BASENAME TO  SGETTEMP-BASENAMES  (2)
           MOVE    RECE84PARA-BASENAME TO  SGETTEMP-BASENAMES  (3)
           MOVE    RECE85PARA-BASENAME TO  SGETTEMP-BASENAMES  (4)
           MOVE    RECE841PARA-BASENAME
                                       TO  SGETTEMP-BASENAMES  (5)
           MOVE    RECE851PARA-BASENAME
                                       TO  SGETTEMP-BASENAMES  (6)
           CALL    "ORCSGETTEMP"       USING   SGETTEMP-AREA
           MOVE    SGETTEMP-FULLNAMES (1)
                                       TO  RECEERR
           MOVE    SGETTEMP-FULLNAMES (2)
                                       TO  RECE82PARA
           MOVE    SGETTEMP-FULLNAMES (3)
                                       TO  RECE84PARA
           MOVE    SGETTEMP-FULLNAMES (4)
                                       TO  RECE85PARA
           MOVE    SGETTEMP-FULLNAMES (5)
                                       TO  RECE841PARA
           MOVE    SGETTEMP-FULLNAMES (6)
                                       TO  RECE851PARA
      *
           OPEN    INPUT               RECE82-FILE
      *
           OPEN    INPUT               RECE84-FILE
      *
           OPEN    INPUT               RECE85-FILE
      *
           OPEN    OUTPUT              RECE841-FILE
           CLOSE                       RECE841-FILE
      *
           OPEN    OUTPUT              RECE851-FILE
           CLOSE                       RECE851-FILE
      *
           OPEN    I-O                 RECE841-FILE
      *
           OPEN    I-O                 RECE851-FILE
      *
           .
       110-FILE-OPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           INITIALIZE                      WRK-JIDO-SETCOM-AREA
      *
           INITIALIZE                      RECE84-REC
           MOVE    RECE82-HOSPNUM      TO  RECE84-HOSPNUM
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
               UNTIL  ( FLG-END              =   1                   )
               OR     ( FLG-RECE84           =   1                   )
               OR     ( RECE82-HOSPNUM   NOT =   RECE84-HOSPNUM      )
               OR     ( RECE82-SRYYM     NOT =   RECE84-SRYYM        )
               OR     ( RECE82-NYUGAIKBN NOT =   RECE84-NYUGAIKBN    )
               OR     ( RECE82-PTID      NOT =   RECE84-PTID         )
               OR     ( RECE82-RECEKA    NOT =   RECE84-RECEKA       )
               OR     ( RECE82-HKNID     NOT =   RECE84-HKNID        )
               OR     ( RECE82-TEKSTYMD  NOT =   RECE84-TEKSTYMD     )
      *
               EVALUATE   RECE84-SRYKBN
                 WHEN      "11"
                   IF  ((RECE82-HKNKBN   =  "4") AND
                        (RECE82-JIBAIKBN =  "2"))
                   OR  ((RECE82-HKNKBN   =  "5") AND
                        (RECE82-KOMUKBN  =  "2"))
                   OR  ( RECE82-HKNKBN   =  "6" )
                       MOVE       RECE84-REC    TO   RECE841-REC
                       WRITE      RECE841-REC
                       ADD     1          TO      CNT-RECE84
                       PERFORM    2002-RECE85-TENSOU-SEC
                   ELSE
                     IF    RECE84-FLG-SYODOU-COMMENT   =    "1"
                       PERFORM    2001-SYODOU-COMMENT-SEC
                     ELSE
                       MOVE       RECE84-REC    TO   RECE841-REC
                       WRITE      RECE841-REC
                       ADD     1          TO      CNT-RECE84
                       PERFORM    2002-RECE85-TENSOU-SEC
                     END-IF
                   END-IF
                 WHEN      "80"
                   IF (( RECE82-KYUKYU-PRTKBN    =      1         ) AND
                       ( RECE84-SRYCDTOTAL(6:9)  =   CONS-KYUKYU  ) AND
                       ( RECE82-SRYYM           <=   "201306"     ))
      ***          OR (( RECE82-KYUKYU-PRTKBN    =      1         ) AND
      ***              ( RECE84-SRYCDTOTAL(6:9)  =   CONS-KYUKYU2 ) AND
      ***              ( RECE82-SRYYM           >=   "201307"     ))
                   OR (( RECE84-JIBAISYUKEIKBN   =      4         ) AND
                       ( RECE84-SRYCDTOTAL(6:5)  =   "09593"      ) AND
                       ( RECE82-SRYYM           <=   "201306"     ))
                       MOVE    SPACE   TO   WRK-TAIHI-SRYYMD
                       IF  (RECE84-JIBAISYUKEIKBN   =    4   )
                       AND (RECE84-SRYCDTOTAL(6:5)  = "09593")
                         PERFORM  VARYING  IDX2  FROM  1  BY  1
                                   UNTIL   IDX2   >   31
                           IF  RECE84-KAISU(1 IDX2)   NOT =    ZERO
                             MOVE  RECE84-SRYYM  TO  WRK-TAIHI-SRYYM
                             MOVE  IDX2          TO  WRK-TAIHI-SRYD
                             MOVE  31            TO  IDX2
                           END-IF
                         END-PERFORM
                       ELSE
                         MOVE  RECE82-KYUKYUYMD  TO  WRK-TAIHI-SRYYMD
                       END-IF
                       IF   RECE82-SRYYM   >=  "200604"
                         PERFORM  2001-KYUKYU-COMMENT200604-SEC
                       ELSE
                         PERFORM  2001-KYUKYU-COMMENT-SEC
                       END-IF
                   ELSE
                       MOVE       RECE84-REC    TO   RECE841-REC
                       WRITE      RECE841-REC
                       ADD     1          TO      CNT-RECE84
                       PERFORM    2002-RECE85-TENSOU-SEC
                   END-IF
                 WHEN   OTHER
                       MOVE       RECE84-REC    TO   RECE841-REC
                       WRITE      RECE841-REC
                       ADD     1          TO      CNT-RECE84
                       PERFORM    2002-RECE85-TENSOU-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE84-NEXT-SEC
      *
      *        処理中止設定処理
               IF      CNT-IN-CANCEL       =   50
                   MOVE    ZERO                TO  CNT-IN-CANCEL
                   PERFORM 500-CANCEL-HENSYU-SEC
               END-IF
      *
           END-PERFORM
      *
           PERFORM 990-RECE82-READ-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    救急医療管理加算のコメント編集
      *****************************************************************
       2001-KYUKYU-COMMENT-SEC          SECTION.
      *
           INITIALIZE            WRK-JIDO-SETCOM-AREA
           MOVE      "1"       TO     WRK-JIDO-SETCOMFLG
           MOVE      301       TO     WRK-JIDO-SETCOMATFLG
      *
           MOVE       RECE84-REC    TO   RECE841-REC
           ADD        1             TO   RECE841-MEISAISU
           IF   WRK-JIDO-SETCOMFLG   =  "1"
             MOVE  WRK-JIDO-SETCOMFLG
                                    TO   RECE841-SETCOMFLG
           END-IF
           WRITE      RECE841-REC
           ADD        1             TO   CNT-RECE84
      *
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPNUM      TO  RECE85-HOSPNUM
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
                     MOVE    1         TO  FLG-RECE85
                 NOT INVALID
                     PERFORM 990-RECE85-NEXT-SEC
           END-START
      *
           MOVE    RECE85-REC           TO  RECE851-REC
           MOVE    RECE85-SRYACT-TBL(1) TO  RECE851-SRYACT-TBL(1)
           MOVE    RECE85-SRYACT-TBL(2) TO  RECE851-SRYACT-TBL(3)
           MOVE    RECE85-SRYACT-TBL(3) TO  RECE851-SRYACT-TBL(4)
           MOVE    RECE85-SRYACT-TBL(4) TO  RECE851-SRYACT-TBL(5)
      *
           MOVE    SPACE                TO  RECE851-SRYACT-TBL(2)
           INITIALIZE                       RECE851-SRYACT-TBL(2)
           MOVE    "810000001"          TO  RECE851-SRYCD(2)
           MOVE    ZERO                 TO  RECE851-SRYSURYO(2)
           MOVE    9                    TO  RECE851-YUKOKETA(2)
      * 
           MOVE    "算定　　　月　　日" TO  RECE851-NAME(2)
      **   MOVE     RECE82-KYUKYUYMD(5:2)
           MOVE     WRK-TAIHI-SRYYMD(5:2)
                                        TO  DAY-IDX
           MOVE     TBL-TUKI(DAY-IDX)   TO  RECE851-NAME(2)(7:4)
      **   MOVE     RECE82-KYUKYUYMD(7:2)
           MOVE     WRK-TAIHI-SRYYMD(7:2)
                                        TO  DAY-IDX
           MOVE     TBL-DAY(DAY-IDX)    TO  RECE851-NAME(2)(13:4)
      *
           IF    WRK-JIDO-SETCOMATFLG  NOT = ZERO
             MOVE  "2"                  TO  RECE851-MEISKYFLG(2)
             MOVE  WRK-JIDO-SETCOMATFLG TO  RECE851-SETCOMATFLG(2)
           END-IF
      *
           MOVE     "2"                 TO  RECE851-SIKFLG(2)
      *
           WRITE    RECE851-REC
           ADD      1                   TO  CNT-RECE85
      *    
           .
       2001-KYUKYU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    救急医療管理加算のコメント編集（２００６０４以降）
      *****************************************************************
       2001-KYUKYU-COMMENT200604-SEC          SECTION.
      *
           INITIALIZE            WRK-JIDO-SETCOM-AREA
           MOVE      "1"       TO     WRK-JIDO-SETCOMFLG
           MOVE      301       TO     WRK-JIDO-SETCOMATFLG
      *
           PERFORM     20011-NYU-DAY-SEC
      *
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPNUM      TO  RECE85-HOSPNUM
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
                     MOVE    1         TO  FLG-RECE85
                 NOT INVALID
                     PERFORM 990-RECE85-NEXT-SEC
                     MOVE  RECE85-REC  TO  WRK-RECE85-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                TO  IDX-RECE85
           MOVE    SPACE               TO  WRK-RECE85XX-REC
           INITIALIZE                      WRK-RECE85XX-REC
      *
           MOVE    RECE84-MEISAISU     TO  MAX-MEISAISU
      *
      *    算定日コメントの挿入
           PERFORM  VARYING      IDX    FROM  1   BY   1
                    UNTIL       (IDX    >     31)      OR
                                (TBL-NYU-DAY-ST(IDX)  =  ZERO)
               COMPUTE  MAX-MEISAISU  =  MAX-MEISAISU  +  1
               MOVE   "810000001"
                             TO  WRK-RECE85XX-SRYCD(MAX-MEISAISU 1)
               MOVE    ZERO  TO  WRK-RECE85XX-SRYSURYO(MAX-MEISAISU 1)
               IF    TBL-NYU-DAY-FLG(IDX)  =  1
                 MOVE    8   TO  WRK-RECE85XX-YUKOKETA(MAX-MEISAISU 1)
                 MOVE    "算定　　月　　日"
                             TO  WRK-RECE85XX-NAME(MAX-MEISAISU 1)
                 MOVE    RECE82-SRYYM(5:2)    TO  DAY-IDX
                 MOVE    TBL-TUKI(DAY-IDX)
                             TO  WRK-RECE85XX-NAME(MAX-MEISAISU 1)(5:4)
                 MOVE    TBL-NYU-DAY-ST(IDX)  TO  DAY-IDX
                 MOVE    TBL-DAY(DAY-IDX)
                             TO  WRK-RECE85XX-NAME(MAX-MEISAISU 1)(11:4)
               ELSE
                 MOVE    12  TO  WRK-RECE85XX-YUKOKETA(MAX-MEISAISU 1)
                 MOVE    "算定　　月　　日〜　　日"
                             TO  WRK-RECE85XX-NAME(MAX-MEISAISU 1)
                 MOVE    RECE82-SRYYM(5:2)    TO  DAY-IDX
                 MOVE    TBL-TUKI(DAY-IDX)
                             TO  WRK-RECE85XX-NAME(MAX-MEISAISU 1)(5:4)
                 MOVE    TBL-NYU-DAY-ST(IDX)  TO  DAY-IDX
                 MOVE    TBL-DAY(DAY-IDX)
                             TO  WRK-RECE85XX-NAME(MAX-MEISAISU 1)(11:4)
                 MOVE    TBL-NYU-DAY-ED(IDX)  TO  DAY-IDX
                 MOVE    TBL-DAY(DAY-IDX)
                             TO  WRK-RECE85XX-NAME(MAX-MEISAISU 1)(19:4)
               END-IF
               IF    WRK-JIDO-SETCOMATFLG  NOT = ZERO
                 MOVE  "2" TO  WRK-RECE85XX-MEISKYFLG(MAX-MEISAISU 1)
                 MOVE  WRK-JIDO-SETCOMATFLG
                           TO  WRK-RECE85XX-SETCOMATFLG(MAX-MEISAISU 1)
               END-IF
               MOVE    "2"   TO  WRK-RECE85XX-SIKFLG(MAX-MEISAISU 1)
           END-PERFORM
      *
           PERFORM    20011-SRYACTINF-HENSYU-SEC
      *
           .
       2001-KYUKYU-COMMENT200604-EXT.
           EXIT.
      *
      *****************************************************************
      *    日確定
      *****************************************************************
       20011-NYU-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-NYU-DAY
      *
           MOVE    ZERO          TO  DAY-IDX
           MOVE    ZERO          TO  FLG-NYU-RENZOKU
      *
           PERFORM    VARYING    IDX  FROM   1   BY   1
                      UNTIL     (IDX      >   31)  OR
                                (DAY-IDX  >   31)
                IF    RECE84-KAISU(1 IDX)   =  ZERO
                      MOVE  ZERO  TO  FLG-NYU-RENZOKU
                ELSE
                      IF    FLG-NYU-RENZOKU  =  ZERO
                         ADD   1     TO  DAY-IDX
                         MOVE  IDX   TO  TBL-NYU-DAY-ST(DAY-IDX)
                      END-IF
                      MOVE  IDX      TO  TBL-NYU-DAY-ED(DAY-IDX)
                      MOVE  1        TO  FLG-NYU-RENZOKU
                END-IF
           END-PERFORM
      *
           PERFORM    VARYING    DAY-IDX  FROM   1   BY   1
                      UNTIL  (DAY-IDX                      >   31)  OR
                             (TBL-NYU-DAY-ST(DAY-IDX)  = ZERO)
                IF    TBL-NYU-DAY-ST(DAY-IDX)
                                    =   TBL-NYU-DAY-ED(DAY-IDX)
                      MOVE  1       TO  TBL-NYU-DAY-FLG(DAY-IDX)
                ELSE
                      MOVE  2       TO  TBL-NYU-DAY-FLG(DAY-IDX)
                END-IF
           END-PERFORM
      *
           .
       20011-NYU-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    初診（同日複数診療科）のコメント編集
      *****************************************************************
       2001-SYODOU-COMMENT-SEC          SECTION.
      *
           INITIALIZE            WRK-JIDO-SETCOM-AREA
           MOVE      "1"       TO     WRK-JIDO-SETCOMFLG
           MOVE      204       TO     WRK-JIDO-SETCOMATFLG
      *
           MOVE       ZERO       TO   IDZ
           INITIALIZE            WRK-FREE-AREA2
      *
           PERFORM   VARYING   IDX    FROM   1   BY   1
                      UNTIL   (IDX                       >   10  )
                       OR     (RECE84-SYODOU-SRYKA(IDX)  =  SPACE)
      *
             ADD      1                  TO  IDZ
             MOVE    "複初算定診療科："  TO  WK-FREE-NAME2(IDZ)(1:16)
      *      診療科の取得
             INITIALIZE                      SYS-1005-REC
             MOVE    "1005"              TO  SYS-1005-KANRICD
             MOVE    RECE84-SYODOU-SRYKA(IDX)
                                         TO  SYS-1005-KBNCD
             MOVE    RECE82-SRYYM        TO  SYS-1005-STYUKYMD(1:6)
             MOVE    "01"                TO  SYS-1005-STYUKYMD(7:2)
             MOVE    SYS-1005-STYUKYMD   TO  SYS-1005-EDYUKYMD
grpsys       MOVE    SPA-HOSPNUM         TO  SYS-1005-HOSPNUM
             MOVE    SYS-1005-REC        TO  MCPDATA-REC
             MOVE    "tbl_syskanri"      TO  MCP-TABLE
             MOVE    "key10"             TO  MCP-PATHNAME
grpsys       PERFORM 900-DBSELECT-SEC
             IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"    TO  MCP-TABLE
               MOVE    "key10"           TO  MCP-PATHNAME
               PERFORM  900-SYSKANRI-READ-SEC
               IF      FLG-SYSKANRI      =   ZERO
                  MOVE  SYS-1005-SRYKANAME(1:40)
                                         TO  WK-FREE-NAME2(IDZ)(17:40)
               END-IF
             END-IF
             MOVE    "tbl_syskanri"      TO  MCP-TABLE
             MOVE    "key10"             TO  MCP-PATHNAME
             PERFORM 900-CLOSE-SEC
      *
             IF    WRK-JIDO-SETCOMATFLG  NOT = ZERO
               MOVE  "2"                   TO  WK-FREE-MEISKYFLG2(IDZ)
               MOVE  WRK-JIDO-SETCOMATFLG  TO  WK-FREE-SETCOMATFLG2(IDZ)
             END-IF
      *
             PERFORM   VARYING   IDW   FROM   200   BY  -1
                        UNTIL    IDW   <   1
                IF   WK-FREE-NAME2(IDZ)(IDW:1)  NOT =  SPACE
                     COMPUTE WK-FREE-YUKOKETA2(IDZ) =  IDW  /   2
                     MOVE    1   TO    IDW
                END-IF
             END-PERFORM
      *
           END-PERFORM
      *
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPNUM      TO  RECE85-HOSPNUM
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
                     MOVE    1         TO  FLG-RECE85
                 NOT INVALID
                     PERFORM 990-RECE85-NEXT-SEC
                     MOVE  RECE85-REC  TO  WRK-RECE85-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                TO  IDX-RECE85
           MOVE    SPACE               TO  WRK-RECE85XX-REC
           INITIALIZE                      WRK-RECE85XX-REC
      *
           MOVE    RECE84-MEISAISU     TO  MAX-MEISAISU
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                COMPUTE  MAX-MEISAISU        =   MAX-MEISAISU  +  1
                MOVE   "810000001"
                             TO  WRK-RECE85XX-SRYCD(MAX-MEISAISU 1)
                MOVE   ZERO  TO  WRK-RECE85XX-SRYSURYO(MAX-MEISAISU 1)
                MOVE   WK-FREE-YUKOKETA2(IDX)
                             TO  WRK-RECE85XX-YUKOKETA(MAX-MEISAISU 1)
                MOVE   WK-FREE-NAME2(IDX)
                             TO  WRK-RECE85XX-NAME(MAX-MEISAISU 1)
                MOVE   WK-FREE-MEISKYFLG2(IDX)
                          TO  WRK-RECE85XX-MEISKYFLG(MAX-MEISAISU 1)
                MOVE   WK-FREE-SETCOMATFLG2(IDX)
                          TO  WRK-RECE85XX-SETCOMATFLG(MAX-MEISAISU 1)
                MOVE    "2"  TO  WRK-RECE85XX-SIKFLG(MAX-MEISAISU 1)
           END-PERFORM
      *
           PERFORM    20011-SRYACTINF-HENSYU-SEC
      *
           .
       2001-SYODOU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ０５　ＳＲＹＡＣＴＩＮＦ編集処理
      *****************************************************************
       20011-SRYACTINF-HENSYU-SEC     SECTION.
      *
           PERFORM
             UNTIL  ( FLG-RECE85           =   1                   )
             OR     ( RECE84-HOSPNUM   NOT =   RECE85-HOSPNUM      )
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
                  ADD    1             TO      IDX-RECE85
                  MOVE   RECE85-SRYACT-TBL(IDX)
                             TO   WRK-RECE85XX-SRYACT-TBL(IDX-RECE85 1)
             END-PERFORM 
      *
             PERFORM 990-RECE85-NEXT-SEC
      *
           END-PERFORM
      *
      *    コメントを含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE85
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE85
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE85  =    1
      *
                  INITIALIZE                        RECE851-REC
                  MOVE    WRK-RECE85-KEY       TO   RECE851-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE851-RENNUM
                  MOVE    WRK-RECE85-PTNUM     TO   RECE851-PTNUM
                  MOVE    WRK-RECE85-SRYKA     TO   RECE851-SRYKA
                  MOVE    WRK-RECE85-SRYKBN    TO   RECE851-SRYKBN
                  MOVE    WRK-RECE85-SRYSYUKBN TO   RECE851-SRYSYUKBN
                  MOVE    WRK-RECE85-JIHIMONEY TO   RECE851-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE85   =   1)
                     ADD         1             TO    IDX-RECE85
                     IF (WRK-RECE85XX-SRYCD(IDX-RECE85 1) = SPACE)
                     OR (IDX-RECE85                       >  100 )
                         MOVE    1             TO    FLG-WRKRECE85
                     ELSE
                         MOVE  WRK-RECE85XX-SRYACT-TBL(IDX-RECE85 1)
                                          TO   RECE851-SRYACT-TBL(IDX)
      *
                         IF    WRK-RECE85XX-SIKFLG(IDX-RECE85 1)  =  "2"
                              ADD    1    TO   WRK-CNT-MEISAI
                         END-IF
      *
                     END-IF
                  END-PERFORM
                  IF   RECE851-SRYCD(1)  NOT =  SPACE
                     WRITE   RECE851-REC
                     ADD     1            TO   CNT-RECE85
                  END-IF
           END-PERFORM
      *
           MOVE    RECE84-REC        TO      RECE841-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE841-MEISAISU
           IF   WRK-JIDO-SETCOMFLG   =  "1"
             MOVE  WRK-JIDO-SETCOMFLG
                                     TO      RECE841-SETCOMFLG
           END-IF
           WRITE   RECE841-REC
           ADD     1                 TO      CNT-RECE84
      *
           .
       20011-SRYACTINF-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０５転送処理
      *****************************************************************
       2002-RECE85-TENSOU-SEC     SECTION.
      *
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPNUM      TO  RECE85-HOSPNUM
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
               UNTIL  ( FLG-RECE85           =   1                   )
               OR     ( RECE84-HOSPNUM   NOT =   RECE85-HOSPNUM      )
               OR     ( RECE84-SRYYM     NOT =   RECE85-SRYYM        )
               OR     ( RECE84-NYUGAIKBN NOT =   RECE85-NYUGAIKBN    )
               OR     ( RECE84-PTID      NOT =   RECE85-PTID         )
               OR     ( RECE84-RECEKA    NOT =   RECE85-RECEKA       )
               OR     ( RECE84-HKNID     NOT =   RECE85-HKNID        )
               OR     ( RECE84-TEKSTYMD  NOT =   RECE85-TEKSTYMD     )
               OR     ( RECE84-ZAINUM    NOT =   RECE85-ZAINUM       )
      *
               MOVE          RECE85-REC       TO      RECE851-REC
               WRITE         RECE851-REC
               ADD           1                TO      CNT-RECE85
      *
               PERFORM 990-RECE85-NEXT-SEC
      *
           END-PERFORM
      *
           .
       2002-RECE85-TENSOU-EXT.
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
               IF      WRK-PARA-SHELLID    NOT =   "RECEPTX"
      *            ジョブ管理終了処理
                   MOVE    "JBE"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    WRK-RECEERR     TO  JOB-YOBI
                   MOVE    "9999"          TO  JOB-ERRCD
grpsys             PERFORM 900-CALL-ORCSJOB-SEC
               END-IF
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理中止処理
      *****************************************************************
       500-CANCEL-HENSYU-SEC                SECTION.
      *
           IF      WRK-PARA-SHELLID    =   "RECEPTX"
               CONTINUE
           ELSE
               MOVE    "CHK"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
grpsys         PERFORM 900-CALL-ORCSJOB-SEC
               IF    ( SJOBKANRI-RETURN
                                       =   ZERO )
               AND   ( JOB-STOPFLG     =   1    )
                   MOVE    "処理が中止されました"
                                           TO  WRK-RECEERR
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
      *                ジョブ管理終了処理
                       MOVE    "CAN"           TO  SJOBKANRI-MODE
                       INITIALIZE                  JOBKANRI-REC
                       MOVE    WRK-RECEERR     TO  JOB-YOBI
                       MOVE    "8888"          TO  JOB-ERRCD
                       MOVE    2               TO  JOB-STOPFLG
grpsys                 PERFORM 900-CALL-ORCSJOB-SEC
                   END-IF
      *                             
                   MOVE    1                   TO  FLG-END
               END-IF
           END-IF
           .
       500-CANCEL-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    ファイルＣＬＯＳＥ処理
           PERFORM 310-FILE-CLOSE-SEC
      *
           IF      WRK-PARA-SHELLID    NOT =   "RECEPTX"
      *        ステップ管理終了処理
               MOVE    "STE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
grpsys         PERFORM 900-CALL-ORCSJOB-SEC
      *
               PERFORM 900-DBDISCONNECT-SEC
           END-IF
      *
           DISPLAY "RECE82  IN  " CNT-RECE82  
           DISPLAY "RECE84  CNT " CNT-RECE84  
           DISPLAY "RECE85  CNT " CNT-RECE85  
           DISPLAY "*** ORCR0880 END ***"
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＣＬＯＳＥ処理
      *****************************************************************
       310-FILE-CLOSE-SEC              SECTION.
      *
           CLOSE                       RECE82-FILE
      *
           CLOSE                       RECE84-FILE
      *
           CLOSE                       RECE85-FILE
      *
           CLOSE                       RECE841-FILE
           CLOSE                       RECE851-FILE
      *
           .
       310-FILE-CLOSE-EXT.
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
               NOT AT  END
                   ADD     1           TO  CNT-RECE82
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
                   ADD     1         TO  CNT-IN-CANCEL
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
      *    システム管理マスター読込
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理ＤＢ制御処理
      *****************************************************************
       900-CALL-ORCSJOB-SEC            SECTION.
      *
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
grpsys     MOVE    SPA-HOSPNUM     TO  JOB-HOSPNUM
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
                                   SPA-AREA
           .
       900-CALL-ORCSJOB-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC              =   ZERO
               CONTINUE
           ELSE
               DISPLAY "SELECT ERR table=" MCP-TABLE
                       " pathname="        MCP-PATHNAME
           END-IF
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    クローズ処理
      *****************************************************************
       900-CLOSE-SEC                  SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       120-DBOPEN-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBOPEN"            TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBSTART"           TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
           .
       120-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
           .
       900-DBDISCONNECT-EXT.
           EXIT.
      *
