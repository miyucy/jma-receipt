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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBGCHILDBIRTH.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 出産一時金等代理申請・受取請求書
      *  管理者            : 
      *  作成日付    作業者        記述
      *  09/07/28    NACL-藤原     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
           COPY    "HCN61.INC".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PAGE            PIC 9(05).
           03  CNT-LINE            PIC 9(05).
           03  CNT-OUT             PIC 9(05).
           03  CNT-IN              PIC 9(05).
      *
       01  KEY-AREA.
           03  KEY-NEW.
               05  KEY-N-HKNJANUM  PIC X(08).
               05  KEY-N-BUNBENKBN PIC 9(01).
           03  KEY-OLD.
               05  KEY-O-HKNJANUM  PIC X(08).
               05  KEY-O-BUNBENKBN PIC 9(01).
      *
       01  SUM-AREA.
           03  SUM-CNT             PIC 9(03).
           03  SUM-BIRTHCNT        PIC 9(03).
           03  SUM-MONEY           PIC 9(08).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-HOSPNUM    PIC 9(02).
           03  RECEERR             PIC X(100).
           03  WRK-PARA-SRYYM      PIC X(06).
           03  WRK-PARA-TEISYUTUSAKI
                                   PIC X(01).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR         PIC X(200).
           03  WRK-SKYYM           PIC X(16).
      *
           03  WRK-9               PIC 9.
           03  WRK-ZZ9             PIC ZZ9.
           03  WRK-Z9              PIC Z9.
           03  WRK-ZZZZZZZ9        PIC ZZ,ZZZ,ZZ9.
      *
      *    医療機関情報
           03  WRK-HOSPNAME        PIC X(60).
           03  WRK-HOSPNAME-R      REDEFINES   WRK-HOSPNAME.
               05  WRK-HOSPNAME1   PIC X(30).
               05  WRK-HOSPNAME2   PIC X(30).
           03  WRK-HOSPADRS        PIC X(88).
           03  WRK-HOSPADRS-R      REDEFINES   WRK-HOSPADRS.
               05  WRK-HOSPADRS1   PIC X(44).
               05  WRK-HOSPADRS2   PIC X(44).
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HENYMDG.
               05  WRK-HENYMD-G    PIC X(01).
               05  WRK-HENYMD-Y    PIC X(02).
               05  FILLER          PIC X(01).
               05  WRK-HENYMD-M    PIC X(02).
               05  FILLER          PIC X(01).
               05  WRK-HENYMD-D    PIC X(02).
      *
           03  WRK-ERRMSG          PIC X(300).
      *
           COPY    "CPSHELLTBL.INC".
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
      *    医療機関情報（基本）
           COPY    "CPSK1001.INC".
      *
      *    医療機関情報（住所）
           COPY    "CPSK1002.INC".
      *
      *    医療機関編集情報
           COPY    "CPSK1900.INC".
           COPY    "CPSK1901.INC".
           COPY    "CPSK1902.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    分娩管理
       01  BUNBEN-REC.
           COPY    "CPBUNBEN.INC".
      *
      *    印刷管理
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    印刷
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
           COPY    "CPORCSKANACHK.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
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
      *
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER                  PIC X(1000).
      *
      ******************************************************************
      *
       PROCEDURE               DIVISION
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
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SPA-AREA
           INITIALIZE                  SUM-AREA
           MOVE    LOW-VALUE       TO  KEY-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                       INTO            LNK-PRTKANRI-RENNUM
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
                                       WRK-PARA-HOSPNUM
                                       RECEERR
                                       WRK-PARA-SRYYM
                                       WRK-PARA-TEISYUTUSAKI
           END-UNSTRING
      *
           MOVE    WRK-PARA-HOSPNUM    TO SPA-HOSPNUM
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    "ORCBGCHILDBIRTH"   TO  JOB-PGID
           MOVE    "出産一時金等代理申請・受取請求書"
                                    TO  JOB-SHELLMSG
      *
           PERFORM 900-CALL-ORCSJOB-SEC
      *
      *    請求年月編集
           MOVE    WRK-PARA-SRYYM  TO  WRK-SYMD (1:6)
           MOVE    "01"            TO  WRK-SYMD (7:2)
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    LNK-DAY2-EDTYMD3(1:16)
                                   TO  WRK-SKYYM
      *
      *    作成日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
      *
      *    システム管理情報取得 
           PERFORM 1001-SYSKANRI-HENSYU-SEC
      *
      *    分娩管理読込   
           PERFORM 900-BUNBEN-READ-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    システム管理情報取得 
      *****************************************************************
       1001-SYSKANRI-HENSYU-SEC      SECTION.
      *
           INITIALIZE                  SYS-1001-REC
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  SYS-1001-HOSPNUM
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    WRK-SYMD            TO  SYS-1001-STYUKYMD
                                           SYS-1001-EDYUKYMD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           ELSE
               MOVE    "医療機関情報（基本）が取得できません" 
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           INITIALIZE                  SYS-1002-REC
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  SYS-1002-HOSPNUM
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    WRK-SYMD            TO  SYS-1002-STYUKYMD
                                           SYS-1002-EDYUKYMD
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1002-REC
           ELSE
               MOVE    "医療機関情報（住所）が取得できません" 
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           IF      FLG-END             =   ZERO
               MOVE    SYS-1001-HOSPNAME   TO  WRK-HOSPNAME
               MOVE    SYS-1002-ADRS       TO  WRK-HOSPADRS
      *        医療機関編集情報取得
               PERFORM 900-1900-READ-SEC
           END-IF    
      *    
           .
       1001-SYSKANRI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           INITIALIZE                  SUM-AREA
           MOVE    KEY-NEW         TO  KEY-OLD
      *
           PERFORM          UNTIL   FLG-END        =   1
                            OR      KEY-NEW    NOT =   KEY-OLD
      *        明細編集処理
               PERFORM 2002-BODY-PRINT-SEC
           END-PERFORM
      *
      *    合計編集処理
           PERFORM 2003-TERM-PRINT-SEC
      *
      *    帳票印刷処理
           PERFORM 2004-PRINT-OUT-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    見出し編集処理
      *****************************************************************
       2001-HEAD-PRINT-SEC                SECTION.
      *
           MOVE    SPACE           TO  HCN61
      *
           MOVE    KEY-N-HKNJANUM  TO  HCN61-HKNJANUM
           MOVE    WRK-SKYYM       TO  HCN61-SKYYM
           EVALUATE    KEY-N-BUNBENKBN
               WHEN    1
                   MOVE    "○"            TO  HCN61-BUNBENKBN (1)
               WHEN    2
                   MOVE    "○"            TO  HCN61-BUNBENKBN (2)
           END-EVALUATE
           MOVE    SYS-1001-HOSPCD TO  HCN61-HOSPCD
      *****MOVE    SYS-1001-       TO  HCN61-SANKANUM
           MOVE    WRK-HOSPADRS1   TO  HCN61-HOSPADRS (1)
           MOVE    WRK-HOSPADRS2   TO  HCN61-HOSPADRS (2)
           MOVE    WRK-HOSPNAME1   TO  HCN61-HOSPNAME (1)
           MOVE    WRK-HOSPNAME2   TO  HCN61-HOSPNAME (2)
      *     
           ADD     1               TO  CNT-PAGE
           MOVE    CNT-PAGE        TO  WRK-ZZ9
           MOVE    WRK-ZZ9         TO  HCN61-PAGE
      *
           MOVE    ZERO            TO  CNT-LINE
           .
       2001-HEAD-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細編集処理
      *****************************************************************
       2002-BODY-PRINT-SEC          SECTION.
      *
      *    見出し編集処理
           PERFORM 2001-HEAD-PRINT-SEC
      *
           PERFORM          UNTIL   FLG-END        =   1
                            OR      KEY-NEW    NOT =   KEY-OLD
                            OR      CNT-LINE       >=  3
               ADD     1               TO  CNT-LINE
      *
               INITIALIZE                      PTINF-REC
               MOVE    WRK-PARA-HOSPNUM    TO  PTINF-HOSPNUM
               MOVE    BUNBEN-PTID         TO  PTINF-PTID
               PERFORM 900-PTINF-READ-SEC
      *
               EVALUATE    BUNBEN-TEISYUTUSAKI
                   WHEN    "1"
                       MOVE    "○"            TO  HCN61-TEISYUTUSAKI
                                                           (CNT-LINE 1)
                   WHEN    "2"
                       MOVE    "○"            TO  HCN61-TEISYUTUSAKI
                                                           (CNT-LINE 2)
               END-EVALUATE
               EVALUATE    BUNBEN-HONKZKKBN
                   WHEN    "1"
                       MOVE    "○"            TO  HCN61-HONKZKKBN
                                                           (CNT-LINE 1)
                   WHEN    "5"
                       MOVE    "○"            TO  HCN61-HONKZKKBN
                                                           (CNT-LINE 2)
               END-EVALUATE
               MOVE    BUNBEN-KIGO         TO  HCN61-KIGO  (CNT-LINE)
               MOVE    BUNBEN-NUM          TO  HCN61-NUM   (CNT-LINE)
               MOVE    BUNBEN-NAME         TO  HCN61-NAME  (CNT-LINE)
               MOVE    PTINF-BIRTHDAY      TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               EVALUATE    WRK-HENYMD-G
                   WHEN    "S"
                       MOVE    "○"            TO  HCN61-BIRTHG
                                                           (CNT-LINE 1)
                   WHEN    "H"
                       MOVE    "○"            TO  HCN61-BIRTHG
                                                           (CNT-LINE 2)
               END-EVALUATE
               MOVE    WRK-HENYMD-Y        TO  HCN61-BIRTHY(CNT-LINE)
               MOVE    WRK-HENYMD-M        TO  HCN61-BIRTHM(CNT-LINE)
               MOVE    WRK-HENYMD-D        TO  HCN61-BIRTHD(CNT-LINE)
               MOVE    BUNBEN-ZAIWEEK      TO  WRK-Z9
               MOVE    WRK-Z9              TO  HCN61-ZAIWEEK
                                                           (CNT-LINE)
               MOVE    BUNBEN-BIRTHDAY     TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMD-Y        TO  HCN61-CBIRTHY (CNT-LINE)
               MOVE    WRK-HENYMD-M        TO  HCN61-CBIRTHM (CNT-LINE)
               MOVE    WRK-HENYMD-D        TO  HCN61-CBIRTHD (CNT-LINE)
               EVALUATE    BUNBEN-SIZANKBN
                   WHEN    "1"
                       MOVE    "○"            TO  HCN61-SIZANKBN
                                                           (CNT-LINE 1)
                   WHEN    "2"
                       MOVE    "○"            TO  HCN61-SIZANKBN
                                                           (CNT-LINE 2)
                   WHEN    "3"
                       MOVE    "○"            TO  HCN61-SIZANKBN
                                                           (CNT-LINE 3)
               END-EVALUATE
               MOVE    BUNBEN-BIRTHCNT     TO  WRK-9
               MOVE    WRK-9               TO  HCN61-BIRTHCNT (CNT-LINE)
               MOVE    BUNBEN-NYUIN-DAY    TO  WRK-ZZ9
               MOVE    WRK-Z9              TO  HCN61-NYUINDAY (CNT-LINE)
               EVALUATE    BUNBEN-SANKAKBN
                   WHEN    "1"
                       MOVE    "○"            TO  HCN61-SANKAKBN
                                                           (CNT-LINE 1)
                   WHEN    "2"
                       MOVE    "○"            TO  HCN61-SANKAKBN
                                                           (CNT-LINE 2)
                   WHEN    "3"
                       MOVE    "○"            TO  HCN61-SANKAKBN
                                                           (CNT-LINE 3)
               END-EVALUATE
               MOVE    BUNBEN-MONEY (1)    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-NYU-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (2)    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-RMSGK-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (3)    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-KAIJO-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (4)    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-BUNBEN-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (5)    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-SHIN-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (6)    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-KNS-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (7)    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-SYC-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (8)    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-SNK-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (9)    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-ETC-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (10)   TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-ICBFTN-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (11)   TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-NINPUFTN-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-MONEY (12)   TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCN61-DAIRI-MONEY
                                                           (CNT-LINE)
               MOVE    BUNBEN-BIKOU        TO  HCN61-BIKOU (CNT-LINE)
      *
               ADD     1                   TO  SUM-CNT
               ADD     BUNBEN-BIRTHCNT     TO  SUM-BIRTHCNT
               ADD     BUNBEN-MONEY (12)   TO  SUM-MONEY
      *
      *        ＣＳＶデータ作成処理
      ****     PERFORM 2003-CSV-HENSYU-SEC
      *
      *        分娩管理読込   
               PERFORM 900-BUNBEN-READ-N-SEC
           END-PERFORM
      *
      *    帳票印刷処理
           IF      KEY-NEW         =   KEY-OLD
               PERFORM 2004-PRINT-OUT-SEC
           END-IF
 
           .
       2002-BODY-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    合計編集処理
      *****************************************************************
       2003-TERM-PRINT-SEC                SECTION.
      *
           MOVE    SUM-CNT         TO  WRK-ZZ9
           MOVE    WRK-ZZ9         TO  HCN61-GCNT
           MOVE    SUM-BIRTHCNT    TO  WRK-ZZ9
           MOVE    WRK-ZZ9         TO  HCN61-GBIRTHCNT
           MOVE    SUM-MONEY       TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9    TO  HCN61-GDAIRI-MONEY
           .
      *
       2003-TERM-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       2004-PRINT-OUT-SEC              SECTION.
      *
           INITIALIZE                      ORCSPRTAREA
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
           MOVE   "HCN61.red"          TO  SPRT-PRTID
           MOVE    HCN61               TO  SPRT-PRTDATA
           EVALUATE    WRK-PARA-TEISYUTUSAKI
               WHEN    "1"
                   MOVE    "（社保）出産一時金等代理申請・受取請求書"
                                               TO  SPRT-TITLE
               WHEN    "2"
                   MOVE    "（国保）出産一時金等代理申請・受取請求書"
                                               TO  SPRT-TITLE
           END-EVALUATE
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
      *
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
grpsys                                 SPA-AREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                          TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           .
       2004-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT               RECEERR-FILE
           IF        ( STS-RECEERR     =   ZERO )
               CONTINUE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR     TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               PERFORM 900-CALL-ORCSJOB-SEC
           END-IF
      *
           MOVE    1               TO  FLG-END
      *
           MOVE    SPACE           TO  WRK-ERRMSG
           STRING  "ORCBGCHILDBIRTH "
                                   DELIMITED  BY  SIZE
                   WRK-RECEERR     DELIMITED  BY  SIZE
                   LOW-VALUE       DELIMITED  BY  SIZE
                                   INTO    WRK-ERRMSG
           END-STRING
           CALL    "cobabort"      USING   WRK-ERRMSG
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           MOVE    "tbl_bunben"    TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           DISPLAY "*** ORCBGCHILDBIRTH IN   "  CNT-IN
           DISPLAY "*** ORCBGCHILDBIRTH OUT  "  CNT-OUT
           DISPLAY "*** ORCBGCHILDBIRTH PAGE "  CNT-PAGE
           DISPLAY "*** ORCBGCHILDBIRTH END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
           PERFORM 900-CALL-ORCSJOB-SEC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理読込
      *****************************************************************
       900-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC          =   ZERO
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key10"         TO  MCP-PATHNAME
               PERFORM 900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    分娩管理読込
      *****************************************************************
       900-BUNBEN-READ-SEC             SECTION.
      *     
           INITIALIZE                  BUNBEN-REC
           MOVE    WRK-PARA-HOSPNUM
                                   TO  BUNBEN-HOSPNUM
           MOVE    WRK-PARA-SRYYM  TO  BUNBEN-SKYYM
           MOVE    WRK-PARA-TEISYUTUSAKI
                                   TO  BUNBEN-TEISYUTUSAKI
           MOVE    BUNBEN-REC      TO  MCPDATA-REC
           MOVE    "tbl_bunben"    TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC          =   ZERO
               PERFORM 900-BUNBEN-READ-N-SEC
           ELSE
               MOVE    1               TO  FLG-END
           END-IF
           .
       900-BUNBEN-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    分娩管理読込
      *****************************************************************
       900-BUNBEN-READ-N-SEC           SECTION.
      *
           MOVE    "tbl_bunben"    TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
      *
           PERFORM 900-DBFETCH-SEC
           IF      MCP-RC          =   ZERO
               MOVE    MCPDATA-REC     TO  BUNBEN-REC
               MOVE    BUNBEN-BUNBENKBN
                                       TO  KEY-N-BUNBENKBN
               MOVE    BUNBEN-HKNJANUM TO  KEY-N-HKNJANUM    
               ADD     1               TO  CNT-IN
      *  
               DISPLAY "PTNUM=" BUNBEN-PTNUM
           ELSE
               MOVE    1               TO  FLG-END
               MOVE    HIGH-VALUE      TO  KEY-NEW
           END-IF
           .
       900-BUNBEN-READ-N-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者読み込み
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC       TO  MCPDATA-REC
      *
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC          =   ZERO
               MOVE    "tbl_ptinf"     TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM 900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    ZERO            TO  FLG-PTINF
                   MOVE    MCPDATA-REC     TO  PTINF-REC
               ELSE
                   MOVE    1               TO  FLG-PTINF
                   INITIALIZE              PTINF-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE              PTINF-REC
           END-IF
      *
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関編集情報読込
      *****************************************************************
       900-1900-READ-SEC           SECTION.
      *
           MOVE    SPACE           TO  SYS-1900-REC
           INITIALIZE                  SYS-1900-REC
           MOVE    SPA-HOSPNUM     TO  SYS-1900-HOSPNUM
           MOVE    "1900"          TO  SYS-1900-KANRICD
           MOVE    "*"             TO  SYS-1900-KBNCD
           MOVE    WRK-SYMD        TO  SYS-1900-STYUKYMD
                                       SYS-1900-EDYUKYMD
           MOVE    SYS-1900-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1900-REC
               IF      SYS-1900-PRTKBN(19)  NOT =   SPACE
      *            医療機関名称編集情報
                   PERFORM 900-1901-READ-SEC
      *            医療機関住所編集情報
                   PERFORM 900-1902-READ-SEC
                END-IF
           ELSE
               INITIALIZE                  SYS-1900-REC
           END-IF
           .
      *
       900-1900-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関名称編集情報読み込み
      *****************************************************************
       900-1901-READ-SEC           SECTION.
      *
           MOVE    SPACE           TO  SYS-1901-REC
           INITIALIZE                  SYS-1901-REC
           MOVE    SPA-HOSPNUM     TO  SYS-1901-HOSPNUM
           MOVE    "1901"          TO  SYS-1901-KANRICD
           MOVE    SYS-1900-PRTKBN(19)
                                   TO  SYS-1901-KBNCD
           MOVE    WRK-SYMD        TO  SYS-1901-STYUKYMD
                                       SYS-1901-EDYUKYMD
           MOVE    SYS-1901-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1901-REC
               MOVE    SYS-1901-HOSPNAME1  TO  WRK-HOSPNAME1
               MOVE    SYS-1901-HOSPNAME2  TO  WRK-HOSPNAME2
           ELSE
               INITIALIZE                      SYS-1901-REC
           END-IF
           .
      *
       900-1901-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関住所編集情報読込
      *****************************************************************
       900-1902-READ-SEC           SECTION.
      *
           MOVE    SPACE           TO  SYS-1902-REC
           INITIALIZE                  SYS-1902-REC
           MOVE    SPA-HOSPNUM     TO  SYS-1902-HOSPNUM
           MOVE    "1902"          TO  SYS-1902-KANRICD
           MOVE    SYS-1900-PRTKBN(19)
                                   TO  SYS-1902-KBNCD
           MOVE    WRK-SYMD        TO  SYS-1902-STYUKYMD
                                       SYS-1902-EDYUKYMD
           MOVE    SYS-1902-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1902-REC
               MOVE    SYS-1902-ADRS1      TO  WRK-HOSPADRS1
               MOVE    SYS-1902-ADRS2      TO  WRK-HOSPADRS2
           ELSE
               INITIALIZE                      SYS-1902-REC
           END-IF
           .
      *
       900-1902-READ-EXT.
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
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC               SECTION.
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
      *
