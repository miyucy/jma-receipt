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
       IDENTIFICATION                      DIVISION.
       PROGRAM-ID.                         ORCSTUSAN.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 通算日数取得サブ
      *  返却エラーコード  : 00:正常　99:エラー
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/02/06    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.10    NACL-太田    03.03.12  日付４の計算方法修正
      *****************************************************************
      *
       ENVIRONMENT                         DIVISION.
       CONFIGURATION                       SECTION.
       INPUT-OUTPUT                        SECTION.
       FILE-CONTROL.
      *
      *
       DATA                                DIVISION.
      *FILE                                SECTION.
      *
      *
       WORKING-STORAGE                     SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-ERR                     PIC 9(01).
           03  FLG-HIT                     PIC 9(01).
           03  FLG-DBRC                    PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
           03  FLG-NYUINACCT               PIC 9(01).
           03  FLG-NYUINACT                PIC 9(01).
           03  FLG-TOKUTEI                 PIC 9(01).
           03  FLG-SENTEICDCHG             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                        PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-YMD                     PIC X(10). 
           03  WRK-HENYMDG                 PIC X(09).
           03  WRK-SYMD.
               05  WRK-SYY                 PIC 9(04).
               05  WRK-SMM                 PIC 9(02).
               05  WRK-SDD                 PIC 9(02).
           03  WRK-STYMD                   PIC X(08).
           03  WRK-EDYMD                   PIC X(08).
           03  WRK-STSRYYM                 PIC X(06).
           03  WRK-EDSRYYM                 PIC X(06).
           03  WRK-NISSU                   PIC 9(05).
           03  WRK-NISSU1                  PIC 9(05).
           03  WRK-NISSU2                  PIC 9(05).
           03  WRK-DBPATH                  PIC X(20).
           03  WRK-ZOGENPTN                PIC X(01).
           03  WRK-ZOGEN                   PIC S9(05).
           03  WRK-KEISANYMD               PIC X(08).
           03  WRK-STIDX                   PIC 9(02).
           03  WRK-EDIDX                   PIC 9(02).
      *
      *    患者入院履歴ワーク
       01  WKPTNYUINRRK-REC.
           COPY  "CPPTNYUINRRK.INC"    REPLACING  //PTNYUINRRK-// 
                                       BY         //WKPTNYUINRRK-//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    入院会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    点数
           COPY    "CPTENSU.INC".
      *
      *    選定療養費
       01  SENTEICDCHG-REC.
           COPY    "CPSENTEICDCHG.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *    共通領域
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                             SECTION.
      *
           COPY    "CPORCSTUSAN.INC".
      *
       PROCEDURE                           DIVISION    USING
           ORCSTUSANAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                        SECTION.
      *
           INITIALIZE                      WRK-AREA
           INITIALIZE                      FLG-AREA
           INITIALIZE                      IDX-AREA
           INITIALIZE                      STUSAN-OUT-AREA
           INITIALIZE                      STUSAN-RC
      *
           MOVE    ZERO                TO  FLG-ERR
      *
      *    パラメータチェック
           PERFORM 100-PRM-CHK-SEC
           IF    ( STUSAN-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    主処理
           PERFORM 200-MAIN-SEC
           IF    ( STUSAN-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
           .
       000-PROC-EXT.
           EXIT.
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    パラメータチェック
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
           IF    ( STUSAN-KJNYMD       =   SPACE )
               MOVE    "99"            TO  STUSAN-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
           MOVE    STUSAN-KJNYMD       TO  WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           IF    ( STUSAN-RC       NOT =   ZERO )
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
           .
       100-PRM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                        SECTION.
      *
      *    今回入院分通算処理
           PERFORM 2100-KONKAI-NYUIN-TUSAN-SEC
           IF    ( STUSAN-RC       NOT =   ZERO )
               GO  TO  200-MAIN-EXT
           END-IF
      *
           IF    ( PTNYUINRRK-SHOKAIKBN    =   "1" )
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    過去入院分通算処理
           PERFORM 2100-KAKO-NYUIN-TUSAN-SEC
           IF    ( STUSAN-RC       NOT =   ZERO )
               GO  TO  200-MAIN-EXT
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    今回入院分通算処理
      *****************************************************************
       2100-KONKAI-NYUIN-TUSAN-SEC         SECTION.
      *
           PERFORM 2110-NYUINRRK-SEL-SEC
           IF    ( STUSAN-RC       NOT =   ZERO )
               GO  TO  2100-KONKAI-NYUIN-TUSAN-EXT
           END-IF
      *
           IF    ( PTNYUINRRK-NYUINYMD <=  STUSAN-KJNYMD )
           AND   ( PTNYUINRRK-TAIINYMD >=  STUSAN-KJNYMD )
               IF    ( PTNYUINRRK-JTIKBN   =   "5" OR "6" )
                   MOVE    "99"            TO  STUSAN-RC
                   GO  TO  2100-KONKAI-NYUIN-TUSAN-EXT
               END-IF
      *
               MOVE    PTNYUINRRK-NYUINYMD TO  WRK-STYMD
               MOVE    STUSAN-KJNYMD       TO  WRK-EDYMD
               PERFORM 800-KIKAN-CALC-SEC
               IF    ( STUSAN-RC       NOT  =   ZERO )
                   GO  TO  2100-KONKAI-NYUIN-TUSAN-EXT
               END-IF
      *
               COMPUTE STUSAN-NISSU01
                   =   STUSAN-NISSU01      +   WRK-NISSU2
               COMPUTE STUSAN-NISSU02
                   =   STUSAN-NISSU02      +   WRK-NISSU2
               COMPUTE STUSAN-NISSU03
                   =   STUSAN-NISSU03      +   WRK-NISSU2
               MOVE    PTNYUINRRK-NYUINYMD TO  WRK-STYMD
               MOVE    STUSAN-KJNYMD       TO  WRK-EDYMD
               PERFORM 2120-NYUINKIKAN-SEL-SEC
           ELSE
               PERFORM 2110-TUSAN-SYUKEI-SEC
               IF    ( STUSAN-RC       NOT  =   ZERO )
                   GO  TO  2100-KONKAI-NYUIN-TUSAN-EXT
               END-IF
           END-IF
      *
      *
           .
       2100-KONKAI-NYUIN-TUSAN-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴検索処理
      *****************************************************************
       2110-NYUINRRK-SEL-SEC               SECTION.
      *
      *    基準日に入院中の歴を取得する
           MOVE    ZERO                TO  FLG-PTNYUINRRK
      *
           INITIALIZE                      PTNYUINRRK-REC
           MOVE    STUSAN-HOSPID       TO  PTNYUINRRK-HOSPID
           MOVE    STUSAN-PTID         TO  PTNYUINRRK-PTID
           MOVE    STUSAN-KJNYMD       TO  PTNYUINRRK-NYUINYMD
           MOVE    "PTNYUINRRK-KEY17"  TO  WRK-DBPATH
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           PERFORM 900-TBL-SELECT-SEC
      *
           IF    ( FLG-DBRC            =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
           MOVE    "PTNYUINRRK-KEY17"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( FLG-PTNYUINRRK  NOT =   ZERO )
               MOVE    "99"            TO  STUSAN-RC
               GO  TO  2110-NYUINRRK-SEL-EXT
           END-IF
      *
           .
       2110-NYUINRRK-SEL-EXT.
           EXIT.
      *****************************************************************
      *    通算日数集計処理
      *****************************************************************
       2110-TUSAN-SYUKEI-SEC                SECTION.
      *
           EVALUATE    PTNYUINRRK-JTIKBN
           WHEN    "5"
               COMPUTE STUSAN-NISSU02
                   =   STUSAN-NISSU02  +   PTNYUINRRK-TAISYONISSU
               COMPUTE STUSAN-NISSU04
                   =   STUSAN-NISSU04  +   PTNYUINRRK-TAISYONISSU
           WHEN    "6"
               COMPUTE STUSAN-NISSU02
                   =   STUSAN-NISSU02  +   PTNYUINRRK-TAISYONISSU
               COMPUTE STUSAN-NISSU03
                   =   STUSAN-NISSU03  +   PTNYUINRRK-TAISYONISSU
               COMPUTE STUSAN-NISSU04
                   =   STUSAN-NISSU04  +   PTNYUINRRK-TAISYONISSU
           WHEN    OTHER
               MOVE    PTNYUINRRK-NYUINYMD TO  WRK-STYMD
               MOVE    PTNYUINRRK-TAIINYMD TO  WRK-EDYMD
               PERFORM 800-KIKAN-CALC-SEC
               IF    ( STUSAN-RC       NOT =   ZERO )
                   GO  TO  2110-TUSAN-SYUKEI-EXT
               END-IF
               COMPUTE STUSAN-NISSU02
                   =   STUSAN-NISSU02  +   WRK-NISSU2
               COMPUTE STUSAN-NISSU03
                   =   STUSAN-NISSU03  +   WRK-NISSU2
               MOVE    PTNYUINRRK-NYUINYMD TO  WRK-STYMD
               MOVE    PTNYUINRRK-TAIINYMD TO  WRK-EDYMD
               PERFORM 2120-NYUINKIKAN-SEL-SEC
           END-EVALUATE
           .
      *
       2110-TUSAN-SYUKEI-EXT.
           EXIT.
      *****************************************************************
      *    入院期間検索処理
      *****************************************************************
       2120-NYUINKIKAN-SEL-SEC              SECTION.
      *
           MOVE    WRK-STYMD           TO  WRK-STSRYYM
           MOVE    WRK-EDYMD           TO  WRK-EDSRYYM
      *
           PERFORM UNTIL ( WRK-STSRYYM >   WRK-EDSRYYM )
      *
               PERFORM 2121-NYUINACCT-SEL-SEC
               IF    ( STUSAN-RC   NOT =   ZERO )
                   GO  TO  2120-NYUINKIKAN-SEL-EXT
               END-IF
      *
               MOVE   WRK-STSRYYM      TO  WRK-YMD
               MOVE   "01"             TO  WRK-YMD (7 : 2)
               MOVE   "2"              TO  WRK-ZOGENPTN
               MOVE   1                TO  WRK-ZOGEN
               PERFORM 800-CALENDAR-SEC
               MOVE    WRK-KEISANYMD   TO  WRK-STSRYYM
      *
           END-PERFORM
      *
           .
       2120-NYUINKIKAN-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院会計検索処理
      *****************************************************************
       2121-NYUINACCT-SEL-SEC              SECTION.
      *
      *
           MOVE    ZERO                TO  FLG-NYUINACCT
           INITIALIZE                      NYUINACCT-REC
           MOVE    PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
           MOVE    "1"                 TO  NACCT-NYUGAIKBN
           MOVE    PTNYUINRRK-PTID     TO  NACCT-PTID
           MOVE    WRK-STSRYYM         TO  NACCT-SRYYM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "NYUINACCT-KEY7"    TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC            =   "1" )
               MOVE    "1"             TO  FLG-NYUINACCT
           END-IF
      *
           PERFORM UNTIL ( FLG-NYUINACCT   NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
      *
               IF    ( NACCT-ZAISKBKBN     =    "1"    )
                   PERFORM 2121-NYUINACT-SEL-SEC
                   IF    ( STUSAN-RC   NOT =   ZERO )
                       GO  TO  2121-NYUINACCT-SEL-EXT
                   END-IF
      *
                   IF    ( FLG-TOKUTEI     =   ZERO )
                     AND ( FLG-SENTEICDCHG =   ZERO )
                       PERFORM 2121-NYUINACT-TUSAN-SEC
                   END-IF
               END-IF
      *
               MOVE    "NYUINACCT-KEY7"    TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC            =   "1" )
                   MOVE    "1"         TO  FLG-NYUINACCT
               END-IF
      *
           END-PERFORM
      *
           MOVE    "NYUINACCT-KEY7"    TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       2121-NYUINACCT-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為検索処理
      *****************************************************************
       2121-NYUINACT-SEL-SEC               SECTION.
      *
           MOVE    ZERO                TO  FLG-TOKUTEI
      *
           MOVE    ZERO                TO  FLG-NYUINACT
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPID        TO  NSRY-HOSPID
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "NYUINACT-KEY9"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC            =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACT
           END-IF
      *
           MOVE    "NYUINACT-KEY9"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( FLG-NYUINACT    NOT =   ZERO )
               MOVE    "99"            TO  STUSAN-RC
               GO  TO  2121-NYUINACT-SEL-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-HIT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1        >   5 )
                OR       ( FLG-HIT NOT =   ZERO )
                OR       ( NSRY-SRYCD (IDX1)   =   SPACE )
      *
               INITIALIZE                  TNS-TENSU-REC
               MOVE    NSRY-SRYCD(IDX1)    TO  TNS-SRYCD
               MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
               MOVE    NACCT-SRYYM         TO  ORC-DBYMD(1:6)
               MOVE    "01"                TO  ORC-DBYMD(7:2)
               MOVE    "TENSU-KEY"         TO  WRK-DBPATH
               PERFORM 900-TBL-SELECT-SEC
               IF    ( FLG-DBRC            =   ZERO )
                   MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
                   IF    ( TNS-DATAKBN     =   1 )
                       MOVE    1           TO  FLG-HIT
                       IF  ( TNS-NYUTENTTLKBN  =   920 )
                           MOVE    1       TO  FLG-TOKUTEI
                       ELSE
                           PERFORM 2121-SENTEICDCHG-CHK-SEC
                       END-IF
                   END-IF
               END-IF
      *
               MOVE    "TENSU-KEY"         TO  WRK-DBPATH
               PERFORM 900-TBL-CLOSE-SEC
      *
           END-PERFORM
      *
           IF    ( FLG-HIT             =   ZERO )
               MOVE    "99"            TO  STUSAN-RC
               GO  TO  2121-NYUINACT-SEL-EXT
           END-IF
      *
           .
       2121-NYUINACT-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院会計通算処理
      *****************************************************************
       2121-NYUINACT-TUSAN-SEC             SECTION.
      *
           IF    ( WRK-STYMD (1 : 6)   =   WRK-STSRYYM )
               MOVE    WRK-STYMD (7 : 2)   TO  WRK-STIDX
           ELSE
               MOVE    1                   TO  WRK-STIDX
           END-IF
      *
           IF    ( WRK-EDYMD (1 : 6)   =   WRK-STSRYYM )
               MOVE    WRK-EDYMD (7 : 2)   TO  WRK-EDIDX
           ELSE
               MOVE    31                  TO  WRK-EDIDX
           END-IF
      *
           PERFORM VARYING IDX1    FROM    WRK-STIDX   BY  1
                   UNTIL ( IDX1    >       WRK-EDIDX )
               IF    ( NACCT-DAY (IDX1)    >   ZERO )
                   COMPUTE STUSAN-NISSU04
                       =   STUSAN-NISSU04 +    1
               END-IF
           END-PERFORM
      *
           .
       2121-NYUINACT-TUSAN-EXT.
           EXIT.
      *****************************************************************
      *    選定療養費置換可能チェック処理
      *****************************************************************
       2121-SENTEICDCHG-CHK-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-SENTEICDCHG
      *
           INITIALIZE  SENTEICDCHG-REC
           MOVE    TNS-SRYCD       TO  SENCHG-IPNSRYCD
           MOVE    SENTEICDCHG-REC TO  MCPDATA-REC
           MOVE    "SENTEICDCHG-KEY2"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO  )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-SENTEICDCHG
           END-IF
      *
           MOVE    "SENTEICDCHG-KEY2"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       2121-SENTEICDCHG-CHK-EXT.
           EXIT.
      *****************************************************************
      *    過去入院分通算処理
      *****************************************************************
       2100-KAKO-NYUIN-TUSAN-SEC           SECTION.
      *
           MOVE    PTNYUINRRK-REC      TO  WKPTNYUINRRK-REC
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK
      *
      *    INITIALIZE                      PTNYUINRRK-REC
      *    MOVE    WKPTNYUINRRK-HOSPID TO  PTNYUINRRK-HOSPID
      *    MOVE    WKPTNYUINRRK-PTID   TO  PTNYUINRRK-PTID
      *    MOVE    WKPTNYUINRRK-NYUINYMD   TO  PTNYUINRRK-NYUINYMD
      *    MOVE    WKPTNYUINRRK-SHONUM     TO  PTNYUINRRK-SHONUM
           MOVE    "PTNYUINRRK-KEY16"  TO  WRK-DBPATH
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC            =   1 )
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
           PERFORM UNTIL   ( FLG-PTNYUINRRK    NOT =   ZERO )
                    OR     ( PTNYUINRRK-SHOKAIKBN  =   "1"  )
      *
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
      *
               PERFORM 2110-TUSAN-SYUKEI-SEC
               IF    ( STUSAN-RC       NOT =   ZERO )
                   GO  TO  2100-KAKO-NYUIN-TUSAN-EXT
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY16"  TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC            =   1 )
                   MOVE    1           TO  FLG-PTNYUINRRK
               END-IF
           END-PERFORM
      *
           MOVE    "PTNYUINRRK-KEY16"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       2100-KAKO-NYUIN-TUSAN-EXT.
           EXIT.
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       800-HIZUKE-CHK-SEC                  SECTION.
      *
           MOVE    SPACE                   TO  WRK-HENYMDG
                                               WRK-SYMD
      *
           IF    ( WRK-YMD                 =   SPACE )
               GO  TO  800-HIZUKE-CHK-EXT
           END-IF
      *
           INITIALIZE                          ORCSGDAYAREA
           MOVE    WRK-YMD                 TO  SGDAY-INDAY
           CALL    "ORCSGDAY"                  USING
                                               ORCSGDAYAREA
           IF  ( SGDAY-RC                  =   ZERO )
               MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY          TO  WRK-SYMD
           ELSE
               MOVE    99                  TO  STUSAN-RC
           END-IF
           .
       800-HIZUKE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    期間算出処理
      *****************************************************************
       800-KIKAN-CALC-SEC                  SECTION.
      *
           INITIALIZE                      WRK-NISSU1
                                           WRK-NISSU2
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY5-AREA
           MOVE    "51"                TO  LNK-DAY5-IRAI
           MOVE    WRK-STYMD           TO  LNK-DAY5-START
           MOVE    WRK-EDYMD           TO  LNK-DAY5-END
           CALL    "ORCSDAY"               USING
                                           STS-AREA-DAY
                                           LNK-DAY5-AREA
           IF    ( STS-DAY-RC1     NOT =   ZERO )
               MOVE    99              TO  STUSAN-RC
               GO  TO                      800-KIKAN-CALC-EXT
           END-IF
      *
           MOVE    LNK-DAY5-NISSU1     TO  WRK-NISSU1
           MOVE    LNK-DAY5-NISSU2     TO  WRK-NISSU2
      *
           .
       800-KIKAN-CALC-EXT.
           EXIT.
      *****************************************************************
      *    カレンダー処理
      *****************************************************************
       800-CALENDAR-SEC                    SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
           MOVE    WRK-ZOGENPTN        TO  LNK-DAY6-ZOGENPTN
           MOVE    WRK-ZOGEN           TO  LNK-DAY6-ZOGEN
           CALL  "ORCSDAY"                 USING
                                           STS-AREA-DAY
                                           LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN     TO  WRK-KEISANYMD
      *
           .
       800-CALENDAR-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC                  SECTION.
      *
           MOVE    ZERO                TO  FLG-DBRC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 910-DB-SELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    WRK-DBPATH      TO  ORC-DBPATH
               PERFORM 910-DB-READ-SEC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1           TO  FLG-DBRC
               END-IF
           ELSE
               MOVE    1               TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       900-TBL-READ-SEC                    SECTION.
      *
           MOVE    ZERO                TO  FLG-DBRC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 910-DB-READ-SEC
           IF    ( MCP-RC              =   ZERO )
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-TBL-CLOSE-SEC                   SECTION.
      *
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DB-SELECT-SEC                   SECTION.
      *
           MOVE    "DBSELECT"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DB-READ-SEC                     SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
      *
       910-DB-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                    SECTION.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
