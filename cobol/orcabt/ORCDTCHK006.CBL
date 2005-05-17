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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCDTCHK006.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェック
      *  コンポーネント名  : 入院会計情報抽出
      *  管理者            :
      *  作成日付    作業者        記述
      *  05/03/31    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
      *    データチェック診療会計
           SELECT  DCACCT-FILE
                                   ASSIGN  DTCHKACCTPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  DCACCT-KEY
                                   FILE    STATUS  IS  STS-DCACCT.
      *
      *    データチェック診療行為
           SELECT  DCSRY-FILE
                                   ASSIGN  DTCHKSRYPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  DCSRY-KEY
                                   FILE    STATUS  IS  STS-DCSRY.
      *
      *    エラーファイル
           SELECT  DTCHKERR-FILE   ASSIGN  DTCHKERRPARA
                                   FILE    STATUS  IS  STS-DTCHKERR.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *    データチェック診療会計
       FD  DCACCT-FILE.
       01  DCACCT-REC.
           COPY    "CPDCACCT.INC".
      *
      *    データチェック診療行為
       FD  DCSRY-FILE.
       01  DCSRY-REC.
           COPY    "CPDCSRY.INC".
      *
      *    エラーファイル
       FD  DTCHKERR-FILE.
       01  DTCHKERR-REC                PIC X(200). 
      *
       WORKING-STORAGE                 SECTION.
      *
      *
      *    中間ファイルファイル名称領域 
           COPY    "CPCOMMONDAT6.INC"      REPLACING  //DTCHK//
                                   BY                 //DTCHKERR//.
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHKACCT//.
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHKSRY//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-DTCHKERR                PIC X(02).
           03  STS-DCACCT                  PIC X(02).
           03  STS-DCSRY                   PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                     PIC 9(01).
           03  FLG-ERR                     PIC 9(01).
           03  FLG-NYUINACCT               PIC 9(01).
           03  FLG-HKNCOMBI                PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
           03  FLG-GENZAN                  PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ZAINUM                  PIC 9(08).
      *
       01  IDX-AREA.
           03  IDX0                        PIC 9(05).
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
           03  IDX3                        PIC 9(05).
           03  IDX4                        PIC 9(05).
           03  IDX5                        PIC 9(05).
           03  IDX6                        PIC 9(05).
           03  IDX7                        PIC 9(05).
           03  IDX8                        PIC 9(05).
           03  IDX-DAY                     PIC 9(02).
      *
       01  WRK-AREA.
           03  WRK-DTCHKERR                PIC X(200).
           03  WRK-JOB-YOBI                PIC X(500).
           03  WRK-COMB-HKNCOMBINUM        PIC 9(04).
           03  WRK-HBTSRYKA-G.
               05  WRK-HBTSRYKA-HBTKA      PIC X(02)   OCCURS  31.
               05  WRK-HBTSRYKA-MAX        PIC 9(05).
               05  WRK-HBTSRYKA-OCC        OCCURS  100.
                   07  WRK-HBTSRYKA        PIC X(02).
                   07  WRK-HBTSRYKA-DAY    PIC 9(01)   OCCURS  31.
           03  WRK-STIDX                   PIC 9(02).
           03  WRK-EDIDX                   PIC 9(02).
           03  WRK-DAY-G.
               05  WRK-DAY                 PIC 9(03)   OCCURS  31.
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID              PIC 9(07).
           03  WRK-PARA-SHELLID            PIC X(08).
           03  WRK-PARA-HOSPID             PIC X(24).
      *
      *    データチェック一括処理パラメータ
           COPY    "CPORCBSD01PARA.INC".
      *
       01  TCOMBI-AREA.
           03  TCOMBI-MAX                  PIC 9(05).
           03  TCOMBI-HKNCOMBI-OCC         OCCURS  50.
               05  TCOMBI-HKNCOMBI         PIC 9(04).
               05  TCOMBI-HKNCOMBI-CNT     PIC 9(03).
               05  TCOMBI-HKNCOMBI-DAY     PIC 9(01)
                                           OCCURS  31.
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-HKNCOMBICD            PIC X(09) VALUE  "999999912".
           03  CONST-HBTSRYKA-MAX          PIC 9(05) VALUE  100.
           03  CONST-ACCT-STATUS-G.
               05  CONST-STS-NYUKHN        PIC 9(05) VALUE     1.
               05  CONST-STS-GAIHAKU       PIC 9(05) VALUE     2.
               05  CONST-STS-HKNCOMBI      PIC 9(05) VALUE     4.
               05  CONST-STS-NYUKSN        PIC 9(05) VALUE     8.
               05  CONST-STS-NYUGEN        PIC 9(05) VALUE    16.
               05  CONST-STS-JITDAY        PIC 9(05) VALUE    32.
               05  CONST-STS-SNTDAY        PIC 9(05) VALUE    64.
           03  CONST-GENZAN-G.
               05  CONST-GENZAN-VAL.
                   07  CONST-GENKNS-IPNCD  PIC X(09) VALUE "190080570".
                   07  CONST-GENKNS-RJNCD  PIC X(09) VALUE "190799770".
                   07  CONST-GENANZ-IPNCD  PIC X(09) VALUE "190111690".
                   07  CONST-GENANZ-RJNCD  PIC X(09) VALUE "190809090".
                   07  CONST-GENJKS-IPNCD  PIC X(09) VALUE "190111790".
                   07  CONST-GENJKS-RJNCD  PIC X(09) VALUE "190809190".
               05  CONST-GENZAN-R  REDEFINES   CONST-GENZAN-VAL.
                   07  CONST-GENZANCD      PIC X(09) OCCURS 6.
               05  CONST-GENZAN-MAX        PIC 9(05) VALUE  6.
           03  CONST-SRYCD-MAX             PIC 9(05) VALUE 20.
           03  CONST-TCOMBI-MAX            PIC 9(05) VALUE 50.
      *
      *    スパ領域
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
      *    入院診療会計マスター
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    入院会計編集サブ
           COPY    "CPORCHCM34S01.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
           COPY    "ORCA-DBPATH".
      *
      ****************************************************************
       LINKAGE                         SECTION.
       01  DTCHK-RC        PIC S9(09).
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE                       DIVISION
               USING
           DTCHK-RC
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           DISPLAY "*** ORCDTCHK006 START ***"
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           MOVE    FLG-ERR         TO  DTCHK-RC
      *
           EXIT PROGRAM
      *
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  STS-AREA
                                       IDX-AREA
                                       CNT-AREA
                                       FLG-AREA
                                       WRK-AREA
                                       WRK-PARA
                                       ORCBSD01PARA
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    LNK-PRTKANRI-RENNUM
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
                                               WRK-PARA-HOSPID
                                               DTCHKERRPARA
                                               ORCBSD01-SRYYM
                                               ORCBSD01-NYUGAIKBN
                                               ORCBSD01-CHKKBN-G
                                               ORCBSD01-JIHIPROCKBN
                                               ORCBSD01-INGAIPROCKBN
                                               ORCBSD01-PRTPTLSTKBN
      *
           PERFORM 900-DBSTART-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCDTCHK006"       TO  JOB-PGID
           MOVE    "入院会計情報抽出"  TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
      *    データチェック中間ファイル名
           MOVE    "DCACCT00"          TO  DTCHKACCT-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHKACCT-TERMID
      *
           MOVE    "DCSRY000"          TO  DTCHKSRY-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHKSRY-TERMID
      *
      *    初期値設定処理
           PERFORM 1001-INIT-VAL-SET-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期値設定処理
      *****************************************************************
       1001-INIT-VAL-SET-SEC           SECTION.
      *
           PERFORM 800-MCNDATE-SEC
      *
           .
       1001-INIT-VAL-SET-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    ZERO            TO  FLG-NYUINACCT
      *
           OPEN    I-O     DCACCT-FILE
                           DCSRY-FILE
      *
           PERFORM 900-NYUINACCT-KEY27-SEL-SEC
      *
           PERFORM UNTIL ( FLG-NYUINACCT   NOT =   ZERO )
      *
               IF    ( NACCT-ZAIKAISU  >   ZERO )
                   PERFORM 2001-HBTSRYKA-HEN-SEC
      *
                   PERFORM 2001-TCOMBI-HEN-SEC
      *
                   PERFORM 2001-NACCT-EDIT-SEC
               END-IF
      *
               PERFORM 900-NYUINACCT-KEY27-FET-SEC
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-NYUINACCT-KEY27    TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           CLOSE           DCACCT-FILE
                           DCSRY-FILE
      *
           MOVE    1               TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    日別診療科編集処理
      *****************************************************************
       2001-HBTSRYKA-HEN-SEC           SECTION.
      *
           MOVE    ZERO                TO  WRK-HBTSRYKA-G
      *
           PERFORM 900-PTNYUINRRK-KEY41-SEL-SEC
      *
           PERFORM UNTIL ( FLG-PTNYUINRRK  NOT =   ZERO )
      *
               IF    ( PTNYUINRRK-TENNYUYMD (1:6)  <   NACCT-SRYYM )
                   MOVE    1           TO  WRK-STIDX
               ELSE
                   MOVE    PTNYUINRRK-TENNYUYMD (7:2)
                                       TO  WRK-STIDX
               END-IF
      *
               IF    ( PTNYUINRRK-TENSTUYMD (1:6)  >   NACCT-SRYYM )
                   MOVE    31          TO  WRK-EDIDX
               ELSE
                   MOVE    PTNYUINRRK-TENSTUYMD (7:2)
                                       TO  WRK-EDIDX
               END-IF
      *
               PERFORM VARYING IDX-DAY     FROM    WRK-STIDX   BY  1
                       UNTIL ( IDX-DAY     >       WRK-EDIDX )
                   MOVE    PTNYUINRRK-NYUINKA
                                       TO  WRK-HBTSRYKA-HBTKA (IDX-DAY)
               END-PERFORM
      *
               PERFORM 900-PTNYUINRRK-KEY41-FET-SEC
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY41   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           PERFORM VARYING IDX-DAY FROM    1   BY  1
                   UNTIL ( IDX-DAY >   31 )
      *
               PERFORM VARYING IDX5    FROM    1   BY  1
                       UNTIL ( IDX5    >   WRK-HBTSRYKA-MAX )
                       OR    ( WRK-HBTSRYKA (IDX5)
                                       = WRK-HBTSRYKA-HBTKA (IDX-DAY) )
      *
                   CONTINUE
      *
               END-PERFORM
      *
               MOVE    ZERO        TO  IDX6
      *
               IF    ( IDX5    >   WRK-HBTSRYKA-MAX )
      *
                   IF    ( WRK-HBTSRYKA-MAX    <   CONST-HBTSRYKA-MAX )
                       COMPUTE WRK-HBTSRYKA-MAX
                           =   WRK-HBTSRYKA-MAX    +   1
      *
                       MOVE    WRK-HBTSRYKA-MAX    TO  IDX6
      *
                       MOVE    WRK-HBTSRYKA-HBTKA (IDX-DAY)
                                   TO  WRK-HBTSRYKA (IDX6)
                   END-IF
               ELSE
                   MOVE    IDX5    TO  IDX6
               END-IF
      *
               IF    ( IDX6        >   ZERO )
                   MOVE    1       TO  WRK-HBTSRYKA-DAY (IDX6 IDX-DAY)
               END-IF
      *
           END-PERFORM
      *
      *
      *
           .
       2001-HBTSRYKA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ情報編集処理
      *****************************************************************
       2001-TCOMBI-HEN-SEC             SECTION.
      *
           INITIALIZE                  TCOMBI-AREA
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   31 )
      *
               IF    ( NACCT-DAY (IDX1)    >   ZERO )
      *
                   PERFORM VARYING IDX2    FROM    1   BY  1
                           UNTIL ( IDX2    >   TCOMBI-MAX )
                           OR    ( NACCT-DAY (IDX1)
                                           =   TCOMBI-HKNCOMBI (IDX2) )
      *
                       CONTINUE
      *
                   END-PERFORM
      *
                   IF    (     IDX2                >   TCOMBI-MAX )
                       IF    ( CONST-TCOMBI-MAX    >   TCOMBI-MAX )
                           COMPUTE TCOMBI-MAX  =   TCOMBI-MAX  +   1
                           MOVE    NACCT-DAY (IDX1)
                                           TO  TCOMBI-HKNCOMBI
                                                       (TCOMBI-MAX)
                           COMPUTE TCOMBI-HKNCOMBI-CNT (TCOMBI-MAX)
                               =   TCOMBI-HKNCOMBI-CNT (TCOMBI-MAX)
                               +   1
                           MOVE    1       TO  TCOMBI-HKNCOMBI-DAY
                                                       (TCOMBI-MAX IDX1)
                       END-IF
                   ELSE
                           COMPUTE TCOMBI-HKNCOMBI-CNT (IDX2)
                               =   TCOMBI-HKNCOMBI-CNT (IDX2)
                               +   1
                           MOVE    1       TO  TCOMBI-HKNCOMBI-DAY
                                                       (IDX2 IDX1)
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       2001-TCOMBI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    入院会計情報編集処理
      *****************************************************************
       2001-NACCT-EDIT-SEC             SECTION.
      *
           MOVE    ZERO                TO  CNT-ZAINUM
      *
           PERFORM VARYING IDX3    FROM    1   BY  1
                   UNTIL ( IDX3    >   TCOMBI-MAX )
      *
               MOVE    TCOMBI-HKNCOMBI (IDX3)  TO  WRK-COMB-HKNCOMBINUM
               PERFORM 900-HKNCOMBI-KEY-SEL-SEC
      *
               INITIALIZE                  HCM34S01-AREA
                                           SPA-AREA
               MOVE    WRK-PARA-HOSPID     TO  HCM34S01-HOSPID
               MOVE    NACCT-PTID          TO  HCM34S01-PTID
               MOVE    NACCT-SRYYM         TO  HCM34S01-SANTEIYM
               MOVE    COMB-HKNCOMBINUM    TO  HCM34S01-HKNCOMBI
               MOVE    COMB-HKNNUM         TO  HCM34S01-HKNNUM
      *
               IF    ( COMB-HKNNUM         =     "971" OR "973" )
      *
                   CALL    "ORCHCM34S02"       USING HCM34S01-AREA
                                                     SPA-AREA
               ELSE
                   CALL    "ORCHCM34S01"       USING HCM34S01-AREA
                                                     SPA-AREA
               END-IF
      *
               PERFORM 20011-DCACCT-INS-SEC
      *
           END-PERFORM
      *
           PERFORM 20012-DCACCT-INS-SEC
      *
           .
       2001-NACCT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院会計情報追加処理
      *****************************************************************
       20011-DCACCT-INS-SEC                SECTION.
      *
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4    >   HCM34S01-HENKYAKU-MAX )
      *
               IF    ( HCM34S01-ZAISKBKBN (IDX4)   NOT =   "3" )
                   PERFORM VARYING IDX7    FROM    1   BY  1
                           UNTIL ( IDX7    >   WRK-HBTSRYKA-MAX )
      *
                       MOVE    ZERO    TO  WRK-DAY-G
      *
                       PERFORM VARYING IDX-DAY FROM    1   BY  1
                               UNTIL ( IDX-DAY >   31 )
                           IF    ( WRK-HBTSRYKA-DAY (IDX7 IDX-DAY )
                                               > ZERO )
                            AND  ( HCM34S01-DAY     (IDX4 IDX-DAY )
                                               > ZERO )
                               MOVE    HCM34S01-DAY     (IDX4 IDX-DAY )
                                       TO  WRK-DAY (IDX-DAY)
                           END-IF
                       END-PERFORM
      *
                       IF    ( WRK-DAY-G   NOT =   ZERO )
                           PERFORM 200111-DCACCT-INS-SEC
                       END-IF
      *
                   END-PERFORM
               END-IF
      *
           END-PERFORM
      *
           .
       20011-DCACCT-INS-EXT.
           EXIT.
      *****************************************************************
      *    入院会計情報追加処理
      *****************************************************************
       200111-DCACCT-INS-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-GENZAN
      *
           COMPUTE CNT-ZAINUM  =   CNT-ZAINUM  +   1
      *
           PERFORM 200111-DCSRY-INS-SEC
      *
           INITIALIZE                      DCACCT-REC
           MOVE    NACCT-PTID          TO  DCACCT-PTID
           MOVE    CNT-ZAINUM          TO  DCACCT-ZAINUM
           MOVE    "2"                 TO  DCACCT-ACCTKBN
           MOVE    WRK-HBTSRYKA    (IDX7)
                                       TO  DCACCT-SRYKA
           MOVE    HCM34S01-SRYKBN (IDX4)
                                       TO  DCACCT-SRYKBN
           MOVE    COMB-HKNCOMBINUM    TO  DCACCT-HKNCOMBI
           MOVE    HCM34S01-ZAITEN (IDX4)
                                       TO  DCACCT-ZAITEN
      *
           PERFORM VARYING IDX-DAY FROM    1   BY  1
                   UNTIL ( IDX-DAY >   31 )
      *
               COMPUTE DCACCT-ZAIKAISU
                   =   DCACCT-ZAIKAISU
                   +   WRK-DAY (IDX-DAY)
      *
           END-PERFORM
      *
           MOVE    COMB-HKNNUM         TO  DCACCT-HKNNUM
           MOVE    NACCT-NYUGAIKBN     TO  DCACCT-NYUGAIKBN
      *
           IF    ( HCM34S01-ZAISKBKBN (IDX4) =   "1" )
               COMPUTE DCACCT-STATUS
                   =   DCACCT-STATUS
                   +   CONST-STS-JITDAY
                   +   CONST-STS-NYUKHN
           END-IF
      *
           IF    ( HCM34S01-ZAISKBKBN (IDX4) =   "2" )
               COMPUTE DCACCT-STATUS
                   =   DCACCT-STATUS
                   +   CONST-STS-GAIHAKU
           END-IF
      *
           IF    ( HCM34S01-ZAISKBKBN (IDX4)  =   "6" )
               IF    ( FLG-GENZAN  =   ZERO )
                   COMPUTE DCACCT-STATUS
                       =   DCACCT-STATUS
                       +   CONST-STS-NYUKSN
               ELSE
                   COMPUTE DCACCT-STATUS
                       =   DCACCT-STATUS
                       +   CONST-STS-NYUGEN
               END-IF
           END-IF
      *
           PERFORM VARYING IDX-DAY FROM    1   BY  1
                   UNTIL ( IDX-DAY >   31 )
      *
               IF    ( WRK-DAY (IDX-DAY)   >   ZERO )
                   COMPUTE DCACCT-ACCTRENNUM
                       =   DCACCT-ACCTRENNUM  +   1
                   MOVE    NACCT-SRYYM TO  DCACCT-SRYYMD
                   MOVE    IDX-DAY     TO  DCACCT-SRYYMD (7:2)
                   MOVE    WRK-DAY (IDX-DAY)
                                       TO  DCACCT-DAYCNT
                   MOVE    IDX-DAY     TO  DCACCT-DAY
      *
                   WRITE   DCACCT-REC
               END-IF
      *
           END-PERFORM
      *
           .
       200111-DCACCT-INS-EXT.
           EXIT.
      *****************************************************************
      *    入院診療行為情報追加処理
      *****************************************************************
       200111-DCSRY-INS-SEC            SECTION.
      *
           INITIALIZE                  DCSRY-REC
           MOVE    NACCT-PTID      TO  DCSRY-PTID
           MOVE    CNT-ZAINUM      TO  DCSRY-ZAINUM
           MOVE    "2"             TO  DCSRY-ACCTKBN
           PERFORM VARYING IDX8    FROM    1   BY  1
                   UNTIL ( IDX8    >   CONST-SRYCD-MAX )
                    OR   ( HCM34S01-SRYCD (IDX4 IDX8)
                                   =   SPACE )
      *
               MOVE    IDX8        TO  DCSRY-SRYRENNUM
               MOVE    HCM34S01-SRYCD (IDX4 IDX8)
                                   TO  DCSRY-SRYCD
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   CONST-GENZAN-MAX )
                   IF    ( DCSRY-SRYCD =   CONST-GENZANCD (IDX0) )
                       MOVE    1   TO  FLG-GENZAN
                   END-IF
               END-PERFORM
      *
               MOVE    SMCNDATE-YMD    TO  DCSRY-CREYMD
                                           DCSRY-UPYMD
               MOVE    SMCNDATE-HMS    TO  DCSRY-UPHMS
      *
               WRITE   DCSRY-REC
      *
           END-PERFORM
      *
           .
       200111-DCSRY-INS-EXT.
           EXIT.
      *****************************************************************
      *    入院会計情報追加処理（保険組合せ剤追加）
      *****************************************************************
       20012-DCACCT-INS-SEC            SECTION.
      *
           COMPUTE CNT-ZAINUM  =   CNT-ZAINUM  +   1
      *
           INITIALIZE                      DCSRY-REC
           MOVE    NACCT-PTID          TO  DCSRY-PTID
           MOVE    CNT-ZAINUM          TO  DCSRY-ZAINUM
           MOVE    "2"                 TO  DCSRY-ACCTKBN
           MOVE    1                   TO  DCSRY-SRYRENNUM
           MOVE    CONST-HKNCOMBICD    TO  DCSRY-SRYCD
      *
           MOVE    SMCNDATE-YMD        TO  DCSRY-CREYMD
                                           DCSRY-UPYMD
           MOVE    SMCNDATE-HMS        TO  DCSRY-UPHMS
      *
           WRITE   DCSRY-REC
      *
           INITIALIZE                      DCACCT-REC
           MOVE    NACCT-PTID          TO  DCACCT-PTID
           MOVE    CNT-ZAINUM          TO  DCACCT-ZAINUM
           MOVE    "2"                 TO  DCACCT-ACCTKBN
           MOVE    NACCT-SRYKA         TO  DCACCT-SRYKA
           MOVE    NACCT-SRYKBN        TO  DCACCT-SRYKBN
           MOVE    NACCT-HKNCOMBI      TO  DCACCT-HKNCOMBI
           MOVE    NACCT-ZAITEN        TO  DCACCT-ZAITEN
           MOVE    NACCT-ZAIKAISU      TO  DCACCT-ZAIKAISU
           MOVE    NACCT-NYUGAIKBN     TO  DCACCT-NYUGAIKBN
           MOVE    CONST-STS-HKNCOMBI  TO  DCACCT-STATUS
      *
           PERFORM VARYING IDX-DAY FROM    1   BY  1
                   UNTIL ( IDX-DAY >   31 )
      *
               IF    ( NACCT-DAY (IDX-DAY)   >   ZERO )
                   COMPUTE DCACCT-ACCTRENNUM
                       =   DCACCT-ACCTRENNUM  +   1
                   MOVE    NACCT-SRYYM TO  DCACCT-SRYYMD
                   MOVE    IDX-DAY     TO  DCACCT-SRYYMD (7:2)
                   MOVE    NACCT-DAY (IDX-DAY)
                                       TO  DCACCT-DAYCNT
                   MOVE    IDX-DAY     TO  DCACCT-DAY
                   WRITE   DCACCT-REC
               END-IF
      *
           END-PERFORM
      *
           .
       20012-DCACCT-INS-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC              SECTION.
      *
           OPEN    INPUT   DTCHKERR-FILE
           IF    ( STS-DTCHKERR        =   ZERO )
               CLOSE   DTCHKERR-FILE
           ELSE
               OPEN    OUTPUT              DTCHKERR-FILE
      *
               MOVE    WRK-DTCHKERR    TO  DTCHKERR-REC
               WRITE   DTCHKERR-REC
               CLOSE   DTCHKERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-DTCHKERR    TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
           END-IF
      *
           MOVE    1                   TO  FLG-END
           MOVE    1                   TO  FLG-ERR
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    ZERO            TO  JOB-UPDCNT
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           PERFORM 900-DBCOMMIT-SEC
      *     
           DISPLAY "*** ORCDTCHK006 END ***"
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理途中経過表示処理
      *****************************************************************
       800-ORCSJOB-STM-SEC             SECTION.
      *
           MOVE    "STM"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-JOB-YOBI        TO  JOB-YOBI
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCDTCHK006"       TO  JOB-PGID
           MOVE    "入院会計情報抽出"  TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           .
       800-ORCSJOB-STM-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    入院会計検索処理(KEY41)
      *****************************************************************
       900-PTNYUINRRK-KEY41-SEL-SEC    SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK
           INITIALIZE                  PTNYUINRRK-REC
      *
           MOVE    WRK-PARA-HOSPID     TO  PTNYUINRRK-HOSPID
           MOVE    NACCT-PTID          TO  PTNYUINRRK-PTID
           MOVE    ORCBSD01-SRYYM      TO  PTNYUINRRK-TENNYUYMD
           MOVE    "31"                TO  PTNYUINRRK-TENNYUYMD
           MOVE    ORCBSD01-SRYYM      TO  PTNYUINRRK-TENSTUYMD
           MOVE    "01"                TO  PTNYUINRRK-TENSTUYMD
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY41    TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
               INITIALIZE                  PTNYUINRRK-REC
           END-IF
      *
           .
       900-PTNYUINRRK-KEY41-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院会計FETCH処理(KEY41)
      *****************************************************************
       900-PTNYUINRRK-KEY41-FET-SEC     SECTION.
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY41   TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
               INITIALIZE                  PTNYUINRRK-REC
           END-IF
      *
           .
       900-PTNYUINRRK-KEY41-FET-EXT.
           EXIT.
      *****************************************************************
      *    入院会計検索処理(KEY27)
      *****************************************************************
       900-NYUINACCT-KEY27-SEL-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-NYUINACCT
           INITIALIZE                  NYUINACCT-REC
      *
           MOVE    WRK-PARA-HOSPID     TO  NACCT-HOSPID
           MOVE    ORCBSD01-SRYYM      TO  NACCT-SRYYM
           MOVE    "1"                 TO  NACCT-NYUGAIKBN
           MOVE    "5"                 TO  NACCT-ZAISKBKBN
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-NYUINACCT-KEY27    TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
               INITIALIZE                  NYUINACCT-REC
           END-IF
      *
           .
       900-NYUINACCT-KEY27-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院会計FETCH処理(KEY27)
      *****************************************************************
       900-NYUINACCT-KEY27-FET-SEC     SECTION.
      *
           MOVE    PATH-TBL-NYUINACCT-KEY27    TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
               INITIALIZE                  NYUINACCT-REC
           END-IF
      *
           .
       900-NYUINACCT-KEY27-FET-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ取得処理
      *****************************************************************
       900-HKNCOMBI-KEY-SEL-SEC        SECTION.
      *
           MOVE    ZERO                    TO  FLG-HKNCOMBI
      *
           INITIALIZE                          HKNCOMBI-REC
           MOVE    WRK-PARA-HOSPID         TO  COMB-HOSPID
           MOVE    NACCT-PTID              TO  COMB-PTID
           MOVE    WRK-COMB-HKNCOMBINUM    TO  COMB-HKNCOMBINUM
           MOVE    HKNCOMBI-REC            TO  MCPDATA-REC
           MOVE    PATH-TBL-HKNCOMBI-KEY   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC                  =   ZERO )
               MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
           ELSE
               MOVE    1                   TO  FLG-HKNCOMBI
               INITIALIZE                      HKNCOMBI-REC
           END-IF
      *
           MOVE    PATH-TBL-HKNCOMBI-KEY   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-HKNCOMBI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSE-SEC                 SECTION.
      *
      *    MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＤＥＬＥＴＥ処理
      *****************************************************************
       910-DBDELETE-SEC                 SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＳＴＡＲＴ処理
      *****************************************************************
       900-DBSTART-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBSTART-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＣＯＭＭＩＴ処理
      *****************************************************************
       900-DBCOMMIT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBCOMMIT-EXT.
           EXIT.
