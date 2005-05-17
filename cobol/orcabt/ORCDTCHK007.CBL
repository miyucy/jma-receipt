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
       PROGRAM-ID.                     ORCDTCHK007.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェック
      *  コンポーネント名  : 患者別チェックリスト
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
      *
      *    データチェック中間ファイル（チェック結果）
           SELECT  DTCHK004-FILE
                                   ASSIGN  DTCHK004PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  DTCHK004-KEY
                                   FILE    STATUS  IS  STS-DTCHK004.
      *
      *    エラーファイル
           SELECT  DTCHKERR-FILE   ASSIGN  DTCHKERRPARA
                                   FILE    STATUS  IS  STS-DTCHKERR.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *    データチェック中間ファイル（チェック結果）
       FD  DTCHK004-FILE.
           COPY    "CPDTCHK004.INC".
      *
      *    エラーファイル
       FD  DTCHKERR-FILE.
       01  DTCHKERR-REC                PIC X(200). 
      *
       WORKING-STORAGE                 SECTION.
      *
           COPY    "HCM402.INC".
      *
      *    エラーファイルファイル名称領域 
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHKERR//.
      *
      *    中間ファイルファイル名称領域 
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHK004//.
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-DTCHK004                            PIC X(02).
           03  STS-DTCHKERR                            PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-ERR                                 PIC 9(01).
           03  FLG-DTCHK004                            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-DTCHK004                            PIC 9(06).
           03  CNT-LINE                                PIC 9(06).
           03  CNT-PAGE1                               PIC 9(06).
           03  CNT-PAGE2                               PIC 9(06).
           03  CNT-PRINT                               PIC 9(06).
           03  CNT-RENBAN                              PIC 9(06).
      *
       01  IDX-AREA.
           03  IDX0                                    PIC 9(05). 
      *
       01  WRK-AREA.
           03  WRK-SYMD                                PIC X(08).
           03  WRK-EDTYMD1                             PIC X(10).
           03  WRK-EDTYMD3                             PIC X(22).
           03  WRK-MAE-INPUT                           PIC X(300).
           03  WRK-OUT-INPUT                           PIC X(300).
           03  WRK-OUT-MAX                             PIC 9(05).
           03  WRK-NYUGAIMES                           PIC X(08).
           03  WRK-SRYYMD.
               05  WRK-SRYYMD-G                        PIC X(04).
               05  WRK-SRYYMD-Y                        PIC X(04).
               05                                      PIC X(02).
               05  WRK-SRYYMD-M                        PIC X(04).
               05                                      PIC X(02).
               05  WRK-SRYYMD-D                        PIC X(04).
               05                                      PIC X(02).
           03  WRK-ZZ9                                 PIC ZZ9.
           03  WRK-Z9                                  PIC Z9.
           03  WRK-HMS.
               05  WRK-HH                              PIC 9(02).
               05  WRK-MM                              PIC 9(02).
               05  WRK-DD                              PIC 9(02).
           03  WRK-ZHMS.
               05  WRK-ZHH                             PIC Z9.
               05  WRK-ZMM                             PIC Z9.
               05  WRK-ZDD                             PIC Z9.
           03  WRK-NENREI                              PIC 9(03).
           03  WRK-DTCHKERR                            PIC X(200).
           03  WRK-SAKYMD-G.
               05  WRK-SAKYMD                          PIC X(22).
               05  WRK-SAKHM                           PIC X(08).
      *
           03  WRK-YMDS1.
               05  WRK-YYS1                            PIC 9(04).
               05  WRK-MMS1                            PIC 9(02).
               05  WRK-DDS1                            PIC 9(02).
           03  WRK-YMDS2.
               05  WRK-YYS2                            PIC 9(04).
               05  WRK-MMS2                            PIC 9(02).
               05  WRK-DDS2                            PIC 9(02).
           03  WRK-SPRT-TITLE                          PIC X(100).
           03  WRK-PAGE-G.
               05  WRK-PAGE1                           PIC ZZZZ9.
               05  WRK-PAGE-SEP                        PIC X(01).
               05  WRK-PAGE2                           PIC Z9.
      *
       01  KEY-AREA.
           03  KEY-NEW.
               05  KEY-N-PTID                          PIC 9(10).
               05  KEY-N-PTNUM                         PIC X(20).
           03  KEY-OLD.
               05  KEY-O-PTID                          PIC 9(10).
               05  KEY-O-PTNUM                         PIC X(20).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                          PIC 9(07).
           03  WRK-PARA-SHELLID                        PIC X(08).
           03  WRK-PARA-HOSPID                         PIC X(24).
      *
      *    データチェック一括処理パラメータ
           COPY    "CPORCBSD01PARA.INC".
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-LINE-MAX                          PIC 9(05)
                                                       VALUE   20.
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
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    半角チェック
           COPY    "CPORCSKANACHK.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
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
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL ( FLG-END =   1 )
      *
           PERFORM 300-END-SEC
      *
           MOVE    FLG-ERR         TO  DTCHK-RC
      *
           EXIT    PROGRAM
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
                                       KEY-AREA
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
           MOVE    "ORCDTCHK007"       TO  JOB-PGID
           MOVE    "チェックリスト作成"
                                       TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
                                           FLG-ERR
      *
      *    データチェック中間ファイル名
           MOVE    "DTCHK004"          TO  DTCHK004-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  DTCHK004-TERMID
      *
      *    初期値設定処理
           PERFORM 1001-INIT-VAL-SET-SEC
      *
           OPEN    INPUT               DTCHK004-FILE
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期値設定処理
      *****************************************************************
       1001-INIT-VAL-SET-SEC           SECTION.
      *
           MOVE    ORCBSD01-SRYYM      TO  WRK-SYMD
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-SRYYMD
      *
           IF    ( ORCBSD01-NYUGAIKBN  =   "1" )
               MOVE    "（入院）"      TO  WRK-NYUGAIMES
           ELSE
               MOVE    "（外来）"      TO  WRK-NYUGAIMES
           END-IF
      *
           MOVE    SPACE               TO  WRK-SPRT-TITLE
           STRING  WRK-EDTYMD3(1:16)           DELIMITED   BY  SIZE
                   "分患者別"                  DELIMITED   BY  SIZE
                   WRK-NYUGAIMES               DELIMITED   BY  SPACE
           INTO    WRK-SPRT-TITLE
           END-STRING
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
           MOVE    ZERO            TO  FLG-DTCHK004
           MOVE    1               TO  CNT-PAGE1
           MOVE    ZERO            TO  CNT-PAGE2
           MOVE    ZERO            TO  CNT-PRINT
           MOVE    ZERO            TO  CNT-RENBAN
      *
      *    チェック結果ファイル読込
           PERFORM 900-DTCHK004-READ-SEC
      *
           MOVE    KEY-NEW         TO  KEY-OLD
      *
           PERFORM UNTIL ( FLG-DTCHK004    =   1 )
                     OR  ( FLG-END         =   1 )
      *
      *        帳票編集<見出し>処理
               PERFORM 210-HEAD-HEN-SEC
      *
               PERFORM UNTIL ( FLG-DTCHK004    =   1 )
                        OR   ( FLG-END         =   1 )
                        OR   ( KEY-NEW     NOT =   KEY-OLD )
                        OR   ( CNT-LINE       >=   CONST-LINE-MAX )
      *
      *            帳票編集<明細>処理
                   PERFORM 220-BODY-HEN-SEC
      *
      *            チェック結果ファイル読込
                   PERFORM 900-DTCHK004-READ-SEC
      *
               END-PERFORM
      *
      *        帳票印刷処理
               PERFORM 290-PRINT-OUT-SEC
      *
               IF    ( KEY-NEW     NOT =   KEY-OLD )
                   MOVE    KEY-NEW     TO  KEY-OLD
                   COMPUTE CNT-PAGE1   =   CNT-PAGE1   +   1
                   MOVE    ZERO        TO  CNT-PAGE2
                   MOVE    ZERO        TO  CNT-RENBAN
               END-IF
      *
           END-PERFORM
      *
           MOVE    1               TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    帳票編集<見出し>処理
      *****************************************************************
       210-HEAD-HEN-SEC                SECTION.
      *
           MOVE    ZERO                TO  CNT-LINE
           COMPUTE CNT-PAGE2   =   CNT-PAGE2       +   1
      *
           INITIALIZE                      HCM402
      *
           MOVE    WRK-SRYYMD (1:16)   TO  HCM402-SRYYM
      *
           MOVE    WRK-NYUGAIMES       TO  HCM402-NYUGAIKBN
      *
           INITIALIZE                      WRK-PAGE-G
           MOVE    CNT-PAGE1           TO  WRK-PAGE1
           MOVE    "-"                 TO  WRK-PAGE-SEP
           MOVE    CNT-PAGE2           TO  WRK-PAGE2
           MOVE    WRK-PAGE-G          TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT       TO  HCM402-PAGE
      *
           MOVE    SPACE               TO  WRK-SAKYMD-G
      *
           MOVE    SMCNDATE-YMD        TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-SAKYMD
      *
           MOVE    SMCNDATE-HMS        TO  WRK-HMS
           MOVE    WRK-HH              TO  WRK-ZHH
           MOVE    WRK-MM              TO  WRK-ZMM
           MOVE    WRK-DD              TO  WRK-ZDD
           MOVE    WRK-ZHMS            TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT       TO  WRK-SAKHM
      *
           STRING  WRK-SAKYMD          DELIMITED   BY  SIZE
                   "　"                DELIMITED   BY  SIZE
                   WRK-SAKHM (1:4)     DELIMITED   BY  SIZE
                   "時"                DELIMITED   BY  SIZE
                   WRK-SAKHM (5:4)     DELIMITED   BY  SIZE
                   "分"                DELIMITED   BY  SIZE
           INTO    HCM402-SAKYMD
           END-STRING
      *
      *    患者番号
           IF    ( DTCHK004-PTNUM      =   SPACE )
               MOVE    DTCHK004-PTID   TO  WRK-MAE-INPUT
           ELSE
               MOVE    DTCHK004-PTNUM  TO  WRK-MAE-INPUT
           END-IF
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT       TO  HCM402-PTNUM
      *
      *    患者氏名
           MOVE    DTCHK004-NAME       TO  HCM402-NAME
      *
      *    年齢
           IF    ( DTCHK004-BIRTHDAY   NOT =   SPACE )
               PERFORM 2201-NENREI-HEN-SEC
               MOVE    WRK-NENREI      TO  WRK-ZZ9
               MOVE    WRK-ZZ9         TO  WRK-MAE-INPUT
               PERFORM 800-ZENKAKU-HEN-SEC
               MOVE    WRK-OUT-INPUT   TO  HCM402-NENREI
           END-IF
      *
           .
       210-HEAD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    帳票編集<明細>処理
      *****************************************************************
       220-BODY-HEN-SEC                SECTION.
      *
           COMPUTE CNT-LINE    =   CNT-LINE    +   1
           COMPUTE CNT-RENBAN  =   CNT-RENBAN  +   1
      *
      *    番号
           MOVE    CNT-RENBAN          TO  WRK-ZZ9
           MOVE    WRK-ZZ9             TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT       TO  HCM402-RENBAN(CNT-LINE)
      *
      *    データチェック内容
           MOVE    DTCHK004-ERRMSG     TO  HCM402-MESG  (CNT-LINE)
      *
           .
       220-BODY-HEN-EXT.
           EXIT.
      *****************************************************************
      *    年齢編集処理
      *****************************************************************
       2201-NENREI-HEN-SEC             SECTION.
      *
           MOVE    ZERO                TO  WRK-NENREI
      *
           MOVE    DTCHK004-BIRTHDAY   TO  WRK-YMDS1
           MOVE    LNK-PRTKANRI-SKYYMD TO  WRK-YMDS2
           COMPUTE WRK-NENREI          =   WRK-YYS2
                                       -   WRK-YYS1
           IF    ( WRK-YMDS1(5:4)      >   WRK-YMDS2(5:4) )
               COMPUTE WRK-NENREI      =   WRK-NENREI
                                       -   1
           END-IF
      *
           .
       2201-NENREI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       290-PRINT-OUT-SEC               SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    2                   TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           MOVE    KEY-O-PTID          TO  SPRT-PTID
           MOVE    LNK-PRTKANRI-SRYYM  TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID 
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
           MOVE   "HCM402.red"         TO  SPRT-PRTID
           MOVE    WRK-SPRT-TITLE      TO  SPRT-TITLE
           MOVE    HCM402              TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF     ( SPRT-RETURN        =   ZERO )
      *
               COMPUTE CNT-PRINT   =   CNT-PRINT   +   1
      *
               IF    ( CNT-PRINT  >=   50 )
                   PERFORM 900-DBCOMMIT-SEC
                   PERFORM 900-DBSTART-SEC
                   MOVE    ZERO    TO  CNT-PRINT
               END-IF
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                       TO  WRK-DTCHKERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       290-PRINT-OUT-EXT.
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
           MOVE    1                   TO  FLG-ERR
           MOVE    1                   TO  FLG-END
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           CLOSE                       DTCHK004-FILE
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
           DISPLAY "*** ORCDTCHK007 END ***"
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    全角変換処理
      *****************************************************************
       800-ZENKAKU-HEN-SEC         SECTION.
      *
           MOVE    SPACE           TO  WRK-OUT-INPUT
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE  WRK-MAE-INPUT     TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF    ( KANACHK-RC      =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-OUT-INPUT
               MOVE    KANACHK-MAX TO  WRK-OUT-MAX
           END-IF
      *
           .
       800-ZENKAKU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC         SECTION.
      *
           MOVE    SPACE               TO  WRK-EDTYMD1
                                           WRK-EDTYMD3
      *
           IF    ( WRK-SYMD            =   SPACE )
               GO  TO  800-SEIWA-HEN-EXT
           END-IF
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"       USING   STS-AREA-DAY
                                           LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-EDTYMD1
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-EDTYMD3
           INSPECT WRK-EDTYMD3     REPLACING  ALL "  "  BY  "　"
      *
           .
       800-SEIWA-HEN-EXT.
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
      *    チェック結果ファイル読込処理
      *****************************************************************
       900-DTCHK004-READ-SEC           SECTION.
      *
           READ    DTCHK004-FILE       NEXT
           AT  END
               MOVE    1               TO  FLG-DTCHK004
           END-READ
      *
           IF    ( FLG-DTCHK004        =   ZERO )
               MOVE    DTCHK004-PTID   TO  KEY-N-PTID
               MOVE    DTCHK004-PTNUM  TO  KEY-N-PTNUM
               COMPUTE CNT-DTCHK004    =   CNT-DTCHK004    +   1
           ELSE
               MOVE    HIGH-VALUE      TO  KEY-NEW
           END-IF
      *
           .
       900-DTCHK004-READ-EXT.
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
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       900-DBSTART-SEC                 SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBSTART-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBCOMMIT-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC.
           .
       900-DBCOMMIT-EXT.
           EXIT.
