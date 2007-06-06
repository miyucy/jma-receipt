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
       PROGRAM-ID.             ORCR0200.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト
      *  コンポーネント名  : レセプト電算ファイル作成
      *                      レセプト明細書の並び替え処理 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−小豆沢   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    03/08/06  診療区分９９は１１に変更
      *  01.00.02    NACL-藤原    04/05/19  診療区分＝９５と９６(自費)の
      *                                     は対象としない
      *  01.00.03    NACL-門脇    04/09/03  保険組み合わせ編集修正
      *
      *  02.07.01    NACL-藤原    05/08/20  特別療養費対応
      *  02.07.02    NACL-藤原    05/12/02  診療区分９９は０１に変更
      *                                     MONFUNC対応
      *
      *  ２００６年４月改正対応
      *  02.09.01    NACL-藤原    06/04/20  検査等実施判断グループの追加
      *
      *  03.03.01    NACL-藤原    06/09/29  検査の判断料の記載方法の変更
      *                                     検査等実施判断の追加
      *
      *  03.05.01    NACL-藤原    07/04/19  グループ診療対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    レセプト明細書  
      *
           SELECT  RECE04-FILE     ASSIGN  RECE04PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE04-KEY
                                   FILE    STATUS  IS  STS-RECE04.
      *
           SELECT  RECE041-FILE    ASSIGN  RECE041PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE041-KEY
                                   FILE    STATUS  IS  STS-RECE041.
      *
           SELECT  RECE04W-FILE     ASSIGN  RECE041PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE04W-KEY
                                   FILE    STATUS  IS  STS-RECE041.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    レセプト明細書  
       FD  RECE04-FILE.
       01  RECE04-REC. 
           COPY    "CPRCF004.INC".
      *
       FD  RECE041-FILE.
       01  RECE041-REC. 
           COPY    "CPRCF0041.INC".
      *
       FD  RECE04W-FILE.
       01  RECE04W-REC. 
           COPY    "CPRCF0041.INC"  REPLACING  //RECE041//
                                   BY          //RECE04W//.
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
grpsys*
grpsys     COPY    "COMMON-SPA".
      *
      *     レセプト明細ファイル 名称領域 
      *
           COPY    "CPRECEDAT1.INC"
                                   REPLACING  //RECEDAT1//
                                   BY         //RECE04//.
      *
           COPY    "CPRECEDAT1.INC"
                                   REPLACING  //RECEDAT1//
                                   BY         //RECE041//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPERRFL.INC"   REPLACING  //ERRFLPARA//
                                   BY         //RECEERR//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE041                             PIC X(02).
           03  STS-RECE04                              PIC X(02).
           03  STS-RECEERR                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-READ                                PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                                  PIC 9(06).
           03  CNT-OUT                                 PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(06).
           03  IDY                     PIC 9(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA1.
                   07  WRK-PARA-SRYYM  PIC X(06).
                   07  WRK-PARA-TERMID PIC X(16).
                   07  WRK-PARA-SYSYMD PIC X(08).
               05  WRK-PARA-JOBID      PIC 9(07).
               05  WRK-PARA-SHELLID    PIC X(08).
               05  WRK-PARA-TEISYUTUSAKI
                                       PIC X(01).
               05  WRK-PARA-SYARECEKBN PIC X(01).
               05  WRK-PARA-KKHRECEKBN PIC X(01).
           03  WRK-PARA-HOSPNUM        PIC 9(02).
      *
           03  WRK-RECEERR             PIC X(200). 
           03  WRK-KOHBUNRI            PIC 9(01).
           03  WRK-HKNCOMBI            PIC 9(04).
      *****03  OLD-KEY                 PIC X(65).
           03  OLD-KEY.
               05  OLD-RECE041-HOSPNUM     PIC  9(02).
               05  OLD-RECE041-SRYYM       PIC  9(06).
               05  OLD-RECE041-NYUGAIKBN   PIC  X(01).
               05  OLD-RECE041-PTID        PIC  9(10).
               05  OLD-RECE041-RECEKA      PIC  X(02).
               05  OLD-RECE041-TEISYUTUSAKI
                                           PIC  9(01).
               05  OLD-RECE041-RECESYUBETU PIC  9(04).
               05  OLD-RECE041-HKNJANUM    PIC  X(08).
               05  OLD-RECE041-HOJOKBN     PIC  X(01).
               05  OLD-RECE041-TEKSTYMD    PIC  X(08). 
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *     
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE                   DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL   FLG-END =   1 
      *
           PERFORM 300-TERM-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
                                       SPA-AREA
                                       FLG-AREA
      *
           MOVE    ZERO                TO  FLG-END
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO    WRK-PARA1
                                               WRK-PARA-TEISYUTUSAKI
                                               WRK-PARA-SYARECEKBN
                                               WRK-PARA-KKHRECEKBN
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
                                               WRK-PARA-HOSPNUM
                                               RECEERR
           END-UNSTRING
           MOVE    WRK-PARA-HOSPNUM    TO  SPA-HOSPNUM
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    "レセ電用データ並び変え"
                                   TO  JOB-SHELLMSG
           MOVE    "ORCR0200"      TO  JOB-PGID
grpsys     PERFORM 900-CALL-ORCSJOB-SEC
      *
           MOVE    "RECE041"           TO  RECE04PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE04PARA-TERMID
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  RECE04PARA-HOSPNUM
      *
           MOVE    "RECE049"           TO  RECE041PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE041PARA-TERMID
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  RECE041PARA-HOSPNUM
      *
           OPEN    OUTPUT              RECE04W-FILE
           CLOSE                       RECE04W-FILE
      *
           OPEN    INPUT               RECE04-FILE
      *
           OPEN    I-O                 RECE041-FILE
      *
      *        レセプト明細０３読み込み
           PERFORM 900-RECE04-READ-SEC
           MOVE    RECE04-KEY(1:43)    TO  OLD-KEY
           MOVE  9                     TO  WRK-KOHBUNRI
           MOVE  ZERO                  TO  WRK-HKNCOMBI
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           INITIALIZE                      RECE041-REC
grpsys     MOVE    RECE04-HOSPNUM      TO  RECE041-HOSPNUM
           MOVE    RECE04-SRYYM        TO  RECE041-SRYYM
           MOVE    RECE04-NYUGAIKBN    TO  RECE041-NYUGAIKBN
           MOVE    RECE04-PTID         TO  RECE041-PTID
           MOVE    RECE04-RECEKA       TO  RECE041-RECEKA
           MOVE    RECE04-TEISYUTUSAKI TO  RECE041-TEISYUTUSAKI
           MOVE    RECE04-RECESYUBETU  TO  RECE041-RECESYUBETU
           MOVE    RECE04-HKNJANUM     TO  RECE041-HKNJANUM
           MOVE    RECE04-HOJOKBN      TO  RECE041-HOJOKBN
           MOVE    RECE04-TEKSTYMD     TO  RECE041-TEKSTYMD
           MOVE    RECE04-ZAINUM       TO  RECE041-ZAINUM
           MOVE    RECE04-KOHBUNRI     TO  RECE041-KOHBUNRI
           IF      RECE04-KEY(1:43)    NOT =   OLD-KEY
                MOVE  9                TO  WRK-KOHBUNRI
                MOVE  ZERO             TO  WRK-HKNCOMBI
                MOVE  RECE04-KEY(1:43) TO  OLD-KEY
           END-IF
           IF      RECE04-KOHBUNRI     <   WRK-KOHBUNRI
                MOVE   RECE04-KOHBUNRI TO  WRK-KOHBUNRI
                MOVE   RECE04-HKNCOMBI TO  WRK-HKNCOMBI
           END-IF
           IF      RECE04-SRYKBN   =   "99"
               MOVE    "01"            TO  RECE041-SRYKBN
               IF  RECE04-HKNCOMBI     =   ZERO
                   MOVE    WRK-HKNCOMBI    TO  RECE04-HKNCOMBI
               END-IF
           ELSE
               MOVE    RECE04-SRYKBN       TO  RECE041-SRYKBN
           END-IF
           MOVE    RECE04-PTNUM        TO  RECE041-PTNUM
           MOVE    RECE04-SRYKA        TO  RECE041-SRYKA
           MOVE    RECE04-HKNCOMBI     TO  RECE041-HKNCOMBI
           MOVE    RECE04-JIHOKBN      TO  RECE041-JIHOKBN
           MOVE    RECE04-ZAITEN       TO  RECE041-ZAITEN
           MOVE    RECE04-SRYCDTOTAL   TO  RECE041-SRYCDTOTAL
           MOVE    RECE04-SURYOUTOTAL  TO  RECE041-SURYOUTOTAL
           MOVE    RECE04-MEISAISU     TO  RECE041-MEISAISU
           MOVE    RECE04-ZAIKAISU     TO  RECE041-ZAIKAISU
           MOVE    RECE04-SYUTEN1      TO  RECE041-SYUTEN1
           MOVE    RECE04-SYUTEN2      TO  RECE041-SYUTEN2
           MOVE    RECE04-YKZTEN       TO  RECE041-YKZTEN
           MOVE    RECE04-KIZAITEN     TO  RECE041-KIZAITEN
           MOVE    RECE04-DRCD         TO  RECE041-DRCD
           MOVE    RECE04-ZAIREQFLG    TO  RECE041-ZAIREQFLG
           MOVE    RECE04-TEIGENRATE   TO  RECE041-TEIGENRATE
           MOVE    RECE04-KNSJISGRPKBN TO  RECE041-KNSJISGRPKBN
           MOVE    RECE04-KNSJISKBN    TO  RECE041-KNSJISKBN
           MOVE    RECE04-DAY-AREA     TO  RECE041-DAY-AREA
      *
           WRITE   RECE041-REC
           ADD     1                   TO  CNT-OUT
      *
      *
           PERFORM 900-RECE04-READ-SEC      
           .
       200-MAIN-EXT.
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
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
grpsys         PERFORM 900-CALL-ORCSJOB-SEC
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
grpsys     PERFORM 900-CALL-ORCSJOB-SEC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           CLOSE   RECE04-FILE
           CLOSE   RECE041-FILE
      *
           DISPLAY "RECE04   IN  " CNT-IN
           DISPLAY "RECE041  CNT " CNT-OUT
           DISPLAY "*** ORCR0200 END ***"
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細書０２読込
      *****************************************************************
       900-RECE04-READ-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-READ
      *
           PERFORM                 UNTIL   FLG-END     =   1
                                   OR      FLG-READ    =   1            
               READ    RECE04-FILE         NEXT
                   AT  END
                       MOVE    1           TO  FLG-END
                   NOT AT  END
                       IF  ( ( WRK-PARA-SYARECEKBN =   ZERO
                                                   OR  "2"  )  AND
                             ( RECE04-TEISYUTUSAKI
                                                   =   "1"  )      )
                       OR  ( ( WRK-PARA-KKHRECEKBN =   ZERO
                                                   OR  "2"  )  AND
                             ( RECE04-TEISYUTUSAKI
                                                   =   "2"  )      )
                       OR  (   RECE04-RECESYUBETU  =   ZERO   OR 
                                                       8888   OR 
                                                       6666        )
                       OR  (   RECE04-SRYKBN       =   "95"   OR
                                                       "96"        )
                           CONTINUE
                       ELSE
                           MOVE    1           TO  FLG-READ
                       END-IF      
      *
                       IF      FLG-READ            =   1         
                           ADD     1                   TO  CNT-IN
                           MOVE    ZERO                TO  FLG-END
                       END-IF
               END-READ
           END-PERFORM
           .
       900-RECE04-READ-EXT.
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
      *    ＤＢオープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
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
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
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
