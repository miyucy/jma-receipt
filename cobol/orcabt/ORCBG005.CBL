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
       PROGRAM-ID.             ORCBG005.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 長期入院対象患者一覧表
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/05/21    NACL-森脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    03/11/19  患者入院履歴よりデータを取得
      *                                     するよう修正
      *  01.00.02    NACL-太田    03/12/03  通算日数チェックに失敗時
      *                                     処理がループする不具合を修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                 PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"  REPLACING  //RECE01PARA//
                                       BY         //RECEERR//.
           03  FILLER                  PIC X(04)   VALUE   ".dat".
      *
           COPY    "HCMG005.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-RECEERR             PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-PTNYUINRRK          PIC 9(01).
           03  FLG-DBRC                PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE                PIC 9(02).
           03  CNT-PAGE                PIC 9(03).
           03  CNT-BG005               PIC 9(05).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY              PIC 9(02).
               05  SYS-MM              PIC 9(02).
               05  SYS-DD              PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                    PIC 9(05).
           03  IDX2                    PIC 9(05).
           03  IDX3                    PIC 9(05).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID          PIC 9(07).
           03  WRK-PARA-SHELLID        PIC X(08).
           03  WRK-PARA-HOSPID         PIC X(24).
           03  WRK-PARA-KJNYMD         PIC X(08).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-DBPATH              PIC X(100).
           03  WRK-RECEERR             PIC X(200).
           03  WRK-SYMD                PIC X(08).
           03  WRK-EDTYMD1             PIC X(10).
           03  WRK-EDTYMD3             PIC X(22).
           03  WRK-KJNYMD              PIC X(22).
           03  WRK-SYORIYMD            PIC X(22).
           03  WRK-PAGE                PIC ZZ9.
           03  WRK-HCMG005.
               05  WRK-HCMG005-BTUNAME     PIC X(10).
               05  WRK-HCMG005-BRMNUM      PIC X(6).
               05  WRK-HCMG005-SRYKA       PIC X(8).
               05  WRK-HCMG005-PTNUM       PIC X(20).
               05  WRK-HCMG005-NAME        PIC X(30).
               05  WRK-HCMG005-SEX         PIC X(2).
               05  WRK-HCMG005-BIRTHDAY    PIC X(22).
           03  WRK-STR                 PIC X(200).
           03  WRK-LEN                 PIC 9(05).
           03  WRK-SHO                 PIC 9(05).
           03  WRK-AMARI               PIC 9(05).
      *
       01  KEY-AREA.
           03  KEY-BTUNUM              PIC X(02).
           03  KEY-BRMNUM              PIC X(08).
           03  KEY-SRYKA               PIC X(02).
      *
       01  ERR-EDIT-AREA.
           03  ERR-PTNUM               PIC X(20).
           03  ERR-ERRMSG              PIC X(80).
           03  ERR-HEN-ERRMSG          PIC X(80).
      *
       01  CONST-AREA.
           03  CONST-LINE-MAX          PIC 9(05)   VALUE 30.
      *
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報
           COPY    "CPSK1001.INC".
      *
      *    診療科目情報
           COPY    "CPSK1005.INC".
      *
      *    病棟情報
           COPY    "CPSK5001.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    印刷管理
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    印刷用データ
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    病室番号編集サブ
           COPY "CPORCSBRMNUM.INC".
      *
      *    通算日数チェックサブ
           COPY "CPORCSTUSANCHK.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER                  PIC X(256).
      *
      ******************************************************************
      *
       PROCEDURE               DIVISION
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
           PERFORM UNTIL ( FLG-END     =   1 )
               PERFORM 200-MAIN-SEC
           END-PERFORM
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
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
                                       WRK-PARA-HOSPID
                                       WRK-PARA-KJNYMD
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBG005"          TO  JOB-PGID
           MOVE    "長期入院対象患者一覧表"
                                       TO  JOB-SHELLMSG
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
           IF        ( FLG-END         NOT =   ZERO )
               GO  TO  100-INIT-EXT
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC         SECTION.
      *
      *    基準日
           MOVE    WRK-PARA-KJNYMD     TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-KJNYMD
      *
      *    作成日
           MOVE    LNK-PRTKANRI-SKYYMD TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-SYORIYMD
      *
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    ZERO                TO  CNT-PAGE
      *
           MOVE    ZERO                TO  CNT-BG005
      *
      *    患者入院履歴検索
           MOVE    ZERO                TO  FLG-PTNYUINRRK
           INITIALIZE                      PTNYUINRRK-REC
      *
           MOVE    WRK-PARA-HOSPID     TO  PTNYUINRRK-HOSPID
           MOVE    WRK-PARA-KJNYMD     TO  PTNYUINRRK-NYUINYMD
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY28"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF        ( FLG-DBRC        NOT =   ZERO )
               MOVE    1                   TO  FLG-PTNYUINRRK
           ELSE
               MOVE    MCPDATA-REC         TO  PTNYUINRRK-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-PTNYUINRRK  =   1 )
                   OR    ( FLG-END     NOT =   ZERO )
      *
               MOVE    SPACE               TO  HCMG005
      *
      *        ヘッダ編集処理
               PERFORM 210-HEAD-EDIT-SEC
      *
               MOVE    ZERO                TO  CNT-LINE
               PERFORM UNTIL ( FLG-PTNYUINRRK  =   1 )
                       OR    ( CNT-LINE        >=  CONST-LINE-MAX )
                       OR    ( FLG-END     NOT =   ZERO )
      *
      *            明細編集処理
                   PERFORM 210-BODY-EDIT-SEC
                   IF    ( FLG-END     NOT =   ZERO )
                       GO  TO  200-MAIN-EXT
                   END-IF
      *
               END-PERFORM
      *
      *        出力処理
               PERFORM 400-PRINT-OUT-SEC
      *
           END-PERFORM
      *
      *
           MOVE    "PTNYUINRRK-KEY28"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           MOVE    1                   TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       210-HEAD-EDIT-SEC           SECTION.
      *
           COMPUTE CNT-PAGE        =   CNT-PAGE    +   1
      *
           MOVE    WRK-KJNYMD      TO  HCMG005-KJNYMD
      *
           MOVE    WRK-SYORIYMD    TO  HCMG005-SYORIYMD
      *
           MOVE    CNT-PAGE        TO  WRK-PAGE
           MOVE    WRK-PAGE        TO  HCMG005-PAGE
      *
           .
       310-HEAD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    帳票編集<明細部>処理
      *****************************************************************
       210-BODY-EDIT-SEC           SECTION.
      *
           COMPUTE CNT-LINE        =   CNT-LINE    +   1
      *
           MOVE    SPACE           TO  WRK-HCMG005-BTUNAME
                                       WRK-HCMG005-BRMNUM
                                       WRK-HCMG005-SRYKA
                                       WRK-HCMG005-PTNUM
                                       WRK-HCMG005-NAME
                                       WRK-HCMG005-SEX
                                       WRK-HCMG005-BIRTHDAY
      *
           IF        ( CNT-LINE        =   1 )
               OR    ( KEY-BTUNUM  NOT =   PTNYUINRRK-BTUNUM )
               PERFORM 2101-BODY-BTUNAME-EDIT-SEC
           END-IF
      *
           IF        ( CNT-LINE        =   1 )
               OR    ( KEY-BTUNUM  NOT =   PTNYUINRRK-BTUNUM )
               OR    ( KEY-BRMNUM  NOT =   PTNYUINRRK-BRMNUM )
               PERFORM 2101-BODY-BRMNUM-EDIT-SEC
           END-IF
      *
           IF        ( CNT-LINE        =   1 )
               OR    ( KEY-BTUNUM  NOT =   PTNYUINRRK-BTUNUM )
               OR    ( KEY-BRMNUM  NOT =   PTNYUINRRK-BRMNUM )
               OR    ( KEY-SRYKA   NOT =   PTNYUINRRK-NYUINKA )
               PERFORM 2101-BODY-SRYKA-EDIT-SEC
           END-IF
      *
      *    キーを設定
           MOVE    PTNYUINRRK-BTUNUM         TO  KEY-BTUNUM
           MOVE    PTNYUINRRK-BRMNUM         TO  KEY-BRMNUM
           MOVE    PTNYUINRRK-NYUINKA        TO  KEY-SRYKA
      *
      *    病棟名称
           MOVE    WRK-HCMG005-BTUNAME TO  HCMG005-BTUNAME(CNT-LINE)
      *
      *    病室名称
           MOVE    WRK-HCMG005-BRMNUM  TO  HCMG005-BRMNUM(CNT-LINE)
      *
      *    入院科
           MOVE    WRK-HCMG005-SRYKA   TO  HCMG005-SRYKA(CNT-LINE)
      *
      *    患者番号
           PERFORM 2101-BODY-PTINF-EDIT-SEC
           IF        ( WRK-HCMG005-PTNUM(11:1) =   SPACE )
               MOVE    WRK-HCMG005-PTNUM   TO  HCMG005-PTNUM(CNT-LINE)
           ELSE
               MOVE    WRK-HCMG005-PTNUM   TO  HCMG005-PTNUM2(CNT-LINE)
           END-IF
      *
      *    氏名
           MOVE    WRK-HCMG005-NAME    TO  HCMG005-NAME(CNT-LINE)
      *
      *    性別
           MOVE    WRK-HCMG005-SEX     TO  HCMG005-SEX(CNT-LINE)
      *
      *    生年月日
           MOVE    WRK-HCMG005-BIRTHDAY
                                       TO  HCMG005-BIRTHDAY(CNT-LINE)
      *
      *    入院日
           MOVE    PTNYUINRRK-NYUINYMD TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD1         TO  HCMG005-NYUINYMD(CNT-LINE)
      *
      *    通算日数チェックサブ呼出
           INITIALIZE                      ORCSTUSANCHKAREA
           MOVE    WRK-PARA-HOSPID     TO  STUSANCHK-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  STUSANCHK-PTID
           MOVE    PTNYUINRRK-NYUINYMD TO  STUSANCHK-NYUINYMD
           MOVE    WRK-PARA-KJNYMD     TO  STUSANCHK-KJNYMD
           CALL    "ORCSTUSANCHK"          USING
                                           ORCSTUSANCHKAREA
           IF        ( STUSANCHK-RC    NOT =   ZERO )
               MOVE    PTNUM-PTNUM         TO  ERR-PTNUM
               PERFORM 800-ERRMSG-EDIT-SEC
               MOVE    ERR-HEN-ERRMSG      TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  210-BODY-EDIT-EXT
           END-IF
      *
      *    ９１日以上
           IF        ( STUSANCHK-DAY-91-STS    =   ZERO )
               MOVE    STUSANCHK-DAY-91    TO  WRK-SYMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-EDTYMD1         TO  HCMG005-DAY-91(CNT-LINE)
               EVALUATE    STUSANCHK-TSUSAN
               WHEN    0   THRU    59
                   MOVE    "　"            TO  HCMG005-AST-91(CNT-LINE)
               WHEN    60  THRU    91
                   MOVE    "○"            TO  HCMG005-AST-91(CNT-LINE)
               WHEN    OTHER
                   MOVE    "●"            TO  HCMG005-AST-91(CNT-LINE)
               END-EVALUATE
           ELSE
               MOVE    "*********"         TO  HCMG005-DAY-91(CNT-LINE)
           END-IF
      *
      *    １８０日以上
           IF        ( STUSANCHK-DAY-180-STS   =   ZERO )
               MOVE    STUSANCHK-DAY-180   TO  WRK-SYMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-EDTYMD1         TO  HCMG005-DAY-180(CNT-LINE)
               EVALUATE    STUSANCHK-TSUSAN
               WHEN    0   THRU    148
                   MOVE    "　"            TO  HCMG005-AST-180(CNT-LINE)
               WHEN    149 THRU    180
                   MOVE    "○"            TO  HCMG005-AST-180(CNT-LINE)
               WHEN    OTHER
                   MOVE    "●"            TO  HCMG005-AST-180(CNT-LINE)
               END-EVALUATE
           ELSE
               MOVE    "*********"         TO  HCMG005-DAY-180(CNT-LINE)
           END-IF
      *
           COMPUTE CNT-BG005       =   CNT-BG005   +   1
      *
           MOVE    "PTNYUINRRK-KEY28"      TO  WRK-DBPATH
           PERFORM 900-TBL-READ-SEC
           IF        ( FLG-DBRC    NOT =   ZERO )
               MOVE    1                   TO  FLG-PTNYUINRRK
           ELSE
               MOVE    MCPDATA-REC         TO  PTNYUINRRK-REC
           END-IF
      *
           .
       210-BODY-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称編集処理
      *****************************************************************
       2101-BODY-BTUNAME-EDIT-SEC  SECTION.
      *
      *    病棟情報
           INITIALIZE                      SYS-5001-REC
           MOVE    "5001"              TO  SYS-5001-KANRICD
           MOVE    PTNYUINRRK-BTUNUM   TO  SYS-5001-KBNCD
           MOVE    WRK-PARA-KJNYMD     TO  ORC-DBYMD
           MOVE    SYS-5001-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF        ( FLG-DBRC        NOT =   ZERO )
               INITIALIZE                      SYS-5001-REC
           ELSE
               MOVE    MCPDATA-REC         TO  SYS-5001-REC
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           MOVE    SYS-5001-BTU-TANNAME    TO  WRK-HCMG005-BTUNAME
      *
           .
       2101-BODY-BTUNAME-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病室名称編集処理
      *****************************************************************
       2101-BODY-BRMNUM-EDIT-SEC   SECTION.
      *
           INITIALIZE  ORCSBRMNUMAREA
           MOVE   PTNYUINRRK-BRMNUM(3:)
                                       TO  SBRMNUM-IN-BRMNUM
           CALL   "ORCSBRMNUM"         USING
                                       ORCSBRMNUMAREA
      *
           MOVE   SBRMNUM-OT-BRMNUM    TO  WRK-HCMG005-BRMNUM
      *
           .
       2101-BODY-BRMNUM-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    診療科編集処理
      *****************************************************************
       2101-BODY-SRYKA-EDIT-SEC    SECTION.
      *
      *    診療科情報
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    PTNYUINRRK-NYUINKA  TO  SYS-1005-KBNCD
           MOVE    WRK-PARA-KJNYMD     TO  ORC-DBYMD
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF        ( FLG-DBRC        NOT =   ZERO )
               INITIALIZE                      SYS-1005-REC
           ELSE
               MOVE    MCPDATA-REC         TO  SYS-1005-REC
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           MOVE    SYS-1005-SRYKANAME2 TO  WRK-HCMG005-SRYKA
      *
           .
       2101-BODY-SRYKA-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報編集処理
      *****************************************************************
       2101-BODY-PTINF-EDIT-SEC    SECTION.
      *
      *    患者番号読み込み
           INITIALIZE                  PTNUM-REC
           MOVE    PTNYUINRRK-HOSPID   TO  PTNUM-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  PTNUM-PTID
           MOVE    PTNUM-REC       TO  MCPDATA-REC
           MOVE    "PTNUM-KEY"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF        ( FLG-DBRC        NOT =   ZERO )
               INITIALIZE                  PTNUM-REC
           ELSE
               MOVE    MCPDATA-REC     TO  PTNUM-REC
           END-IF
      *
           MOVE    "PTNUM-KEY"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    患者情報読み込み
           INITIALIZE                  PTINF-REC
           MOVE    PTNYUINRRK-HOSPID   TO  PTINF-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  PTINF-PTID
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    "PTINF-KEY"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF        ( FLG-DBRC        NOT =   ZERO )
               INITIALIZE                  PTINF-REC
           ELSE
               MOVE    MCPDATA-REC     TO  PTINF-REC
           END-IF
      *
           MOVE    "PTINF-KEY"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    患者番号
           MOVE    PTNUM-PTNUM     TO  WRK-HCMG005-PTNUM
      *
      *    氏名
           MOVE    PTINF-NAME      TO  WRK-HCMG005-NAME
      *
      *    性別
           EVALUATE    PTINF-SEX
               WHEN    "1"
                   MOVE    "男"        TO  WRK-HCMG005-SEX
               WHEN    "2"
                   MOVE    "女"        TO  WRK-HCMG005-SEX
           END-EVALUATE
      *
      *    生年月日
           MOVE    PTINF-BIRTHDAY  TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD1     TO  WRK-HCMG005-BIRTHDAY
      *
           .
       2101-BODY-PTINF-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       400-PRINT-OUT-SEC           SECTION.
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
           MOVE   "HCMG005.red"        TO  SPRT-PRTID
           MOVE    "長期入院対象患者一覧表"
                                       TO  SPRT-TITLE
           MOVE    HCMG005             TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"               USING
                                           ORCSPRTAREA
           IF          SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           .
       400-PRINT-OUT-EXT.
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
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
           MOVE    1               TO  FLG-END
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
           IF    ( CNT-BG005           =   ZERO )
               MOVE    "処理対象のデータがありませんでした"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           DISPLAY "*** ORCBG005 IN " CNT-BG005  " ***"
           DISPLAY "*** ORCBG005 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
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
       800-SEIWA-HEN-SEC           SECTION.
      *
           MOVE    SPACE           TO  WRK-EDTYMD1
                                       WRK-EDTYMD3
      *
           IF        ( WRK-SYMD        =   SPACE )
               GO  TO  800-SEIWA-HEN-EXT
           END-IF
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-EDTYMD1
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-EDTYMD3
           INSPECT WRK-EDTYMD3     REPLACING  ALL "  "  BY  "　"
      *
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ編集処理
      *****************************************************************
       800-ERRMSG-EDIT-SEC         SECTION.
      *
           MOVE    SPACE           TO  ERR-HEN-ERRMSG
      *
           MOVE    1               TO  WRK-LEN
           MOVE    SPACE           TO  WRK-STR
           STRING  ERR-PTNUM           DELIMITED   BY  SPACE
           INTO    WRK-STR     WITH    POINTER WRK-LEN
           END-STRING
      *
           COMPUTE WRK-LEN         =   WRK-LEN -   1
      *
           MOVE    ZERO            TO  WRK-SHO
                                       WRK-AMARI
           DIVIDE  2   INTO    WRK-LEN GIVING  WRK-SHO
           REMAINDER WRK-AMARI
           END-DIVIDE
      *
           IF    ( WRK-AMARI   =   ZERO )
               STRING  ERR-ERRMSG          DELIMITED   BY  SPACE
                       "［患者番号："      DELIMITED   BY  SIZE
                       ERR-PTNUM           DELIMITED   BY  SPACE
                       "］"                DELIMITED   BY  SIZE
               INTO    ERR-HEN-ERRMSG
               END-STRING
           ELSE
               STRING  ERR-ERRMSG          DELIMITED   BY  SPACE
                       "［患者番号:"       DELIMITED   BY  SIZE
                       ERR-PTNUM           DELIMITED   BY  SPACE
                       "］"                DELIMITED   BY  SIZE
               INTO    ERR-HEN-ERRMSG
               END-STRING
           END-IF
      *
           .
       800-ERRMSG-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
               MOVE    WRK-DBPATH      TO  ORC-DBPATH
               MOVE    "DBFETCH"       TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF        ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1           TO  FLG-DBRC
               END-IF
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       900-TBL-READ-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
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
       900-TBL-CLOSE-SEC           SECTION.
      *
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
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
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
