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
       PROGRAM-ID.             ORCBG029.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 診療区分別指定点数該当患者一覧
      *  管理者            : 
      *  作成日付    作業者        記述
      *  16/08/18    NACL-森脇     新規作成
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
      *    統計用ファイル
           SELECT  TOKEI-FILE          ASSIGN    TOKEIPARA
                                       ORGANIZATION    IS  INDEXED
                                       ACCESS  MODE    IS  DYNAMIC
                                       RECORD  KEY     IS  TOKEI-KEY
                                       FILE    STATUS  IS  STS-TOKEI.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE        ASSIGN  RECEERR
                                       FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    統計用ファイル
       FD  TOKEI-FILE.
       01  TOKEI-REC. 
           03  TOKEI-KEY.
               05  TOKEI-SRYKBN        PIC X(02).
               05  TOKEI-KANANAME      PIC X(50).
               05  TOKEI-PTNUM         PIC X(20).
               05  TOKEI-TEN           PIC 9(10).
               05  TOKEI-SRYCD         PIC X(09).
               05  TOKEI-SRYYMD        PIC X(08).
               05  TOKEI-IDX           PIC 9(02).
           03  TOKEI-NAME              PIC X(50).
           03  TOKEI-NAIYO             PIC X(50).
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                 PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
           COPY    "CPCOMMONDAT2.INC"  REPLACING  //RECE01//
                                       BY         //TOKEI//.
      *
           COPY    "CPRECEERR.INC".
      *
           COPY    "HCMG008.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-TOKEI               PIC X(02).
           03  STS-RECEERR             PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-SRYACCT             PIC 9(01).
           03  FLG-NYUINACCT           PIC 9(01).
           03  FLG-SRYACT              PIC 9(01).
           03  FLG-TENSU               PIC 9(01).
           03  FLG-PTINF               PIC 9(01).
           03  FLG-PTNUM               PIC 9(01).
           03  FLG-TOKEI               PIC 9(01).
           03  FLG-OK                  PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PAGE                PIC 9(03).
           03  CNT-LINE                PIC 9(02).
           03  CNT-TOKEI               PIC 9(05).
           03  CNT-NAIYO               PIC 9(05).
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
           03  IDX                     PIC 9(05).
           03  IDX-D                   PIC 9(02).
           03  IDX-K                   PIC 9(02).
           03  IDX-S                   PIC 9(02).
           03  IDX-Z                   PIC 9(02).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID          PIC 9(07).
           03  WRK-PARA-SHELLID        PIC X(08).
           03  WRK-PARA-HOSPNUM        PIC 9(02).
           03  WRK-PARA-STRYM          PIC X(06).
           03  WRK-PARA-ENDYM          PIC X(06).
           03  WRK-PARA-NYUGAIKBN      PIC X(01).
           03  WRK-PARA-IJYOU          PIC 9(10).
           03  WRK-PARA-IKA            PIC 9(10).
           03  WRK-PARA-SRYKBN-G       OCCURS 5.
               05  WRK-PARA-SRYKBN     PIC X(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR             PIC X(200).
      *
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-HENYMDG             PIC X(22).
           03  WRK-HENYMD              PIC X(09).
      *
           03  WRK-PTID                PIC 9(10).
           03  WRK-SRYKBN              PIC X(02).
           03  WRK-ZAITEN              PIC 9(08).
           03  WRK-SRYYMD              PIC X(08).
           03  WRK-SRYCD               PIC X(09).
      *
           03  WRK-NAIYO-G.
               05  WRK-NAIYO-SRYCD     PIC X(09)   OCCURS 3.
               05  WRK-NAIYO-NAME      PIC X(50)   OCCURS 3.
      *
           03  WRK-PTCNT               PIC 9(10).
           03  WRK-PTNUM               PIC X(20).
      *
           03  WRK-STRYM               PIC X(16).
           03  WRK-ENDYM               PIC X(16).
           03  WRK-IJYOU               PIC X(10).
           03  WRK-IKA                 PIC X(10).
           03  WRK-TANI                PIC X(02).
      *
           03  WRK-Z10                 PIC ZZZZZZZZZ9.
           03  WRK-Z03                 PIC ZZ9.
      *
           03  WRK-HEN-TEN-G.
               05  WRK-HEN-TEN-IN      PIC X(10).
               05  WRK-HEN-TEN-OUT     PIC X(10).
      *
       01  WRK-PRT-AREA.
           03  WRK-PRT-NYUGAIKBN       PIC X(08)   VALUE   SPACE.
           03  WRK-PRT-SRYKBN          PIC X(10)   VALUE   SPACE.
           03  WRK-PRT-JYOKEN          PIC X(30)   VALUE   SPACE.
           03  WRK-PRT-KIKAN           PIC X(36)   VALUE   SPACE.
           03  WRK-PRT-PRTYMD          PIC X(22)   VALUE   SPACE.
           03  WRK-PRT-GOKEI.
               05  FILLER              PIC X(10)   VALUE   "該当患者数".
               05  WRK-PRT-NINZU       PIC X(10)   VALUE   SPACE.
               05  FILLER              PIC X(02)   VALUE   "人".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    診療会計マスタ
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    入院診療会計マスター
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    診療行為マスタ
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *
      *    患者
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
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
      *    指定診療行為件数調サブ２
           COPY    "CPORCSS009.INC".
      *
      *    一時ファイル名編集
           COPY    "CPORCSGETTEMP.INC".
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
       PROCEDURE               DIVISION
                                       USING
                                       COMMAND-PARAM.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           IF    ( FLG-END         =   ZERO )
               PERFORM 200-MAIN-SEC
           END-IF
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
           INITIALIZE                  SPA-AREA
           INITIALIZE                  RECEERR
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
                                       WRK-PARA-STRYM
                                       WRK-PARA-ENDYM
                                       WRK-PARA-NYUGAIKBN
                                       WRK-PARA-IJYOU
                                       WRK-PARA-IKA
                                       WRK-PARA-SRYKBN(1)
                                       WRK-PARA-SRYKBN(2)
                                       WRK-PARA-SRYKBN(3)
                                       WRK-PARA-SRYKBN(4)
                                       WRK-PARA-SRYKBN(5)
           END-UNSTRING
      *
           MOVE    WRK-PARA-HOSPNUM    TO  SPA-HOSPNUM
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    SPA-HOSPNUM         TO  JOB-HOSPNUM
           MOVE    "ORCBG029"          TO  JOB-PGID
           MOVE    "診療区分別指定点数該当患者一覧"
                                       TO  JOB-SHELLMSG
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                                           SPA-AREA
      *
           MOVE    "BG02901"           TO  TOKEIPARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  TOKEIPARA-TERMID
           MOVE    SPA-HOSPNUM         TO  TOKEIPARA-HOSPNUM
      *
           INITIALIZE                      SGETTEMP-AREA
           MOVE    TOKEIPARA-BASENAME  TO  SGETTEMP-BASENAMES(1)
           MOVE    RECEERR             TO  SGETTEMP-BASENAMES(2)
           CALL    "ORCSGETTEMP"           USING
                                           SGETTEMP-AREA
           MOVE    SGETTEMP-FULLNAMES(1)
                                       TO  TOKEIPARA-FULLNAME
           MOVE    SGETTEMP-FULLNAMES(2)
                                       TO  RECEERR
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC         SECTION.
      *
      *    入外区分が１以外ならば
           IF      WRK-PARA-NYUGAIKBN  NOT =   "1"
               MOVE    "2"             TO  WRK-PARA-NYUGAIKBN
           END-IF
      *
      *    終了月セット
           IF      WRK-PARA-ENDYM      =   SPACE
               MOVE    WRK-PARA-STRYM      TO  WRK-PARA-ENDYM
           ELSE
               IF      WRK-PARA-STRYM  >   WRK-PARA-ENDYM
                   MOVE    "日付の範囲が正しくありません"
                                           TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  110-PARA-HENSYU-EXT
               END-IF
           END-IF
      *
      *    入外区分セット
           IF      WRK-PARA-NYUGAIKBN  =   "1"
               MOVE    "（入院）"          TO  WRK-PRT-NYUGAIKBN
           END-IF
           IF      WRK-PARA-NYUGAIKBN  =   "2"
               MOVE    "（外来）"          TO  WRK-PRT-NYUGAIKBN
           END-IF
      *
      *    システム日付セット
           MOVE    LNK-PRTKANRI-SKYYMD TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  WRK-PRT-PRTYMD
      *
      *    点数条件
           IF    ( WRK-PARA-IJYOU  =   ZERO )  AND
                 ( WRK-PARA-IKA    =   ZERO )
               MOVE    "点数を入力してください"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  110-PARA-HENSYU-EXT
           END-IF
      *
           IF      WRK-PARA-IJYOU  NOT =   ZERO
               MOVE    WRK-PARA-IJYOU  TO  WRK-Z10
               MOVE    WRK-Z10         TO  WRK-HEN-TEN-IN
               PERFORM 800-TENSU-HEN-SEC
               MOVE    WRK-HEN-TEN-OUT TO  WRK-IJYOU
           END-IF
      *
           IF      WRK-PARA-IKA    NOT =   ZERO
               MOVE    WRK-PARA-IKA    TO  WRK-Z10
               MOVE    WRK-Z10         TO  WRK-HEN-TEN-IN
               PERFORM 800-TENSU-HEN-SEC
               MOVE    WRK-HEN-TEN-OUT TO  WRK-IKA
           END-IF
      *
           IF    ( WRK-IJYOU       NOT =   SPACE ) AND
                 ( WRK-IKA         NOT =   SPACE )
               STRING  WRK-IJYOU           DELIMITED BY SPACE
                       "点以上〜"          DELIMITED BY SIZE
                       WRK-IKA             DELIMITED BY SPACE
                       "点以下"            DELIMITED BY SIZE
                                           INTO    WRK-PRT-JYOKEN
               END-STRING
           ELSE
               IF    ( WRK-IJYOU       NOT =   SPACE )
                   STRING  WRK-IJYOU           DELIMITED BY SPACE
                           "点以上"            DELIMITED BY SIZE
                                               INTO    WRK-PRT-JYOKEN
                   END-STRING
               END-IF
               IF    ( WRK-IKA         NOT =   SPACE )
                   STRING  WRK-IKA             DELIMITED BY SPACE
                           "点以下"            DELIMITED BY SIZE
                                               INTO    WRK-PRT-JYOKEN
                   END-STRING
               END-IF
           END-IF
      *
      *    開始月セット
           MOVE    WRK-PARA-STRYM      TO  WRK-SYMD(1:6)
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  WRK-STRYM
      *
      *    終了月セット
           MOVE    WRK-PARA-ENDYM      TO  WRK-SYMD(1:6)
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  WRK-ENDYM
      *
           IF    ( WRK-STRYM       NOT =   WRK-ENDYM )
               STRING  WRK-STRYM           DELIMITED BY SPACE
                       "〜"                DELIMITED BY SIZE
                       WRK-ENDYM           DELIMITED BY SPACE
                                           INTO    WRK-PRT-KIKAN
               END-STRING
           ELSE
               MOVE    WRK-STRYM           TO  WRK-PRT-KIKAN
           END-IF
      *
      *    診療区分チェック
           PERFORM VARYING IDX FROM 1 BY 1
                   UNTIL   IDX >   5
               IF    ( WRK-PARA-SRYKBN(IDX)  NOT =   SPACE ) AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "*" )   AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "11" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "12" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "13" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "14" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "20" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "30" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "40" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "50" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "54" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "60" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "70" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "80" )  AND
                     ( WRK-PARA-SRYKBN(IDX)  NOT =   "90" )
                   MOVE    5               TO  IDX
                   MOVE    "正しい診療区分を入力してください"
                                           TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  110-PARA-HENSYU-EXT
               END-IF
           END-PERFORM
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    データをクリアする
           OPEN    OUTPUT              TOKEI-FILE
           CLOSE                       TOKEI-FILE
      *
           OPEN    I-O                 TOKEI-FILE
      *
      *    診療会計集計処理
           PERFORM 210-MAIN-SRYACCT-SEC
      *
           IF    ( WRK-PARA-NYUGAIKBN  =   "1" )
               PERFORM 210-MAIN-NYUINACCT-SEC
           END-IF
      *
           IF      CNT-TOKEI       NOT =   ZERO
      *
               CLOSE                       TOKEI-FILE
               OPEN    INPUT               TOKEI-FILE
      *
      *        統計出力処理
               PERFORM 260-TOKEI-OUT-SEC
           END-IF
      *
           CLOSE                       TOKEI-FILE
      *
           MOVE    1               TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *   診療会計集計処理
      *****************************************************************
       210-MAIN-SRYACCT-SEC        SECTION.
      *
      *    診療会計読み込み
           PERFORM 900-SRYACCT-DBSELECT-SEC
      *
           PERFORM UNTIL   FLG-SRYACCT =   1
               IF    ( ACCT-ZAITEN     >   ZERO )  AND
                     ( ACCT-ZAIKAISU   >   ZERO )
                   MOVE    ACCT-ZAITEN     TO  WRK-ZAITEN
                   MOVE    ACCT-PTID       TO  WRK-PTID
                   MOVE    ACCT-SRYKBN     TO  WRK-SRYKBN
      *            チェック処理
                   PERFORM 230-MAIN-CHK-SYORI-SEC
                   IF      FLG-OK          =   1
      *                診療会計集計処理
                       PERFORM 220-MAIN-SRYACCT-CHK-SEC
                   END-IF
               END-IF
      *        診療会計読み込み
               PERFORM 900-SRYACCT-DBFETCH-SEC
           END-PERFORM
      *
      *    診療会計読み込み
           PERFORM 900-SRYACCT-DBCLOSE-SEC
           .
       210-MAIN-SRYACCT-EXT.
           EXIT.
      *****************************************************************
      *    入院会計集計処理
      *****************************************************************
       210-MAIN-NYUINACCT-SEC      SECTION.
      *
      *    入院会計読み込み
           PERFORM 900-NYUINACCT-DBSELECT-SEC
      *
           PERFORM UNTIL   FLG-NYUINACCT   =   1
               IF    ( NACCT-ZAITEN    >   ZERO )  AND
                     ( NACCT-ZAIKAISU  >   ZERO )
                   MOVE    NACCT-ZAITEN        TO  WRK-ZAITEN
                   MOVE    NACCT-PTID          TO  WRK-PTID
                   MOVE    NACCT-SRYKBN        TO  WRK-SRYKBN
      *            チェック処理
                   PERFORM 230-MAIN-CHK-SYORI-SEC
                   IF      FLG-OK          =   1
                       INITIALIZE              SS009-AREA
                       MOVE    "1"         TO  SS009-EXGAIHAKU
                       CALL    "ORCSS009"      USING
                                               SS009-AREA
                                               NYUINACCT-REC
                                               SPA-AREA
                       IF      SS009-RC        =   ZERO
                           PERFORM VARYING IDX-K   FROM    1   BY  1
                                   UNTIL ( IDX-K
                                               >   SS009-HENKYAKU-MAX )
      *                        入院会計集計処理
                               PERFORM 220-MAIN-NYUINACCT-CHK-SEC
                           END-PERFORM
                       END-IF
                   END-IF
               END-IF
      *        入院会計読み込み
               PERFORM 900-NYUINACCT-DBFETCH-SEC
           END-PERFORM
      *
      *    入院会計読み込み
           PERFORM 900-NYUINACCT-DBCLOSE-SEC
           .
       210-MAIN-SRYACCT-EXT.
           EXIT.
      *****************************************************************
      *   診療会計集計処理
      *****************************************************************
       220-MAIN-SRYACCT-CHK-SEC    SECTION.
      *
           IF    ( ACCT-JIHOKBN    =   "1" )   OR
                 ( ACCT-HKNCOMBI   =   9999 )
               GO  TO  220-MAIN-SRYACCT-CHK-EXT
           END-IF
      *
           IF    ( ACCT-JIHOKBN    = "1" )   AND
                 ( ACCT-TEIGENRATE =  3 OR 4 )
               GO  TO  220-MAIN-SRYACCT-CHK-EXT
           END-IF
      *
           MOVE    ACCT-SRYYM      TO  WRK-SRYYMD(1:6)
           MOVE    SPACE           TO  WRK-NAIYO-G
           MOVE    ZERO            TO  CNT-NAIYO
      *
           PERFORM 900-SRYACT-DBSELECT-SEC
           PERFORM UNTIL   FLG-SRYACT  =   1
               IF      ACCT-SRYKBN     =   SRY-SRYKBN
                   PERFORM VARYING IDX-S   FROM    1   BY  1
                           UNTIL ( IDX-S   >   5 )
                       IF      SRY-SRYCD(IDX-S)    NOT =   SPACE
                           MOVE    SRY-SRYCD(IDX-S)   TO  WRK-SRYCD
                           PERFORM 230-SRYCD-CHK-SYORI-SEC
                       END-IF
                   END-PERFORM
               END-IF
               PERFORM 900-SRYACT-DBFETCH-SEC
           END-PERFORM
           PERFORM 900-SRYACT-DBCLOSE-SEC
      *
           PERFORM VARYING IDX-K FROM  2   BY  1
                   UNTIL   IDX-K >     10
               PERFORM VARYING IDX-D FROM  1   BY  1
                       UNTIL   IDX-D >     31
                   IF      ACCT-DAY(IDX-K IDX-D)   NOT =   ZERO
                       MOVE    IDX-D        TO  WRK-SRYYMD(7:2)
      *                集計処理
                       PERFORM 240-TOKEI-SET-SEC
                   END-IF
               END-PERFORM
           END-PERFORM
           .
       220-MAIN-SRYACCT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院会計集計処理
      *****************************************************************
       220-MAIN-NYUINACCT-CHK-SEC  SECTION.
      *
           MOVE    NACCT-SRYYM     TO  WRK-SRYYMD(1:6)
           MOVE    SPACE           TO  WRK-NAIYO-G
           MOVE    ZERO            TO  CNT-NAIYO
      *
           PERFORM VARYING IDX-S   FROM    1   BY  1
                   UNTIL ( IDX-S   >   20 )
               IF      SS009-SRYCD(IDX-K IDX-S)    NOT =   SPACE
                   MOVE    SS009-SRYCD(IDX-K IDX-S)    TO  WRK-SRYCD
                   PERFORM 230-SRYCD-CHK-SYORI-SEC
               END-IF
           END-PERFORM
      *
           PERFORM VARYING IDX-D FROM  1   BY  1
                   UNTIL   IDX-D >     31
               IF      SS009-DAY(IDX-K IDX-D)  NOT =   ZERO
                   MOVE    IDX-D       TO  WRK-SRYYMD(7:2)
      *            集計処理
                   PERFORM 240-TOKEI-SET-SEC
               END-IF
           END-PERFORM
           .
       220-MAIN-NYUINACCT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    チェック処理
      *****************************************************************
       230-MAIN-CHK-SYORI-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-OK
      *
      *    テスト患者のときは読み飛ばす
           PERFORM 900-PTINF-READ-SEC
           IF    ( FLG-PTINF           =   ZERO )  AND
                 ( PTINF-TSTPTNUMKBN   =   "1"  )
               GO  TO  230-MAIN-CHK-SYORI-EXT
           END-IF
      *
      *    患者番号読み込み
           PERFORM 900-PTNUM-READ-SEC
           IF      FLG-PTNUM       =   1
               GO  TO  230-MAIN-CHK-SYORI-EXT
           END-IF
      *
      *    診療区分チェック
           EVALUATE    TRUE
               WHEN  ( WRK-SRYKBN  =   "90" OR "92" OR "97" )
                   MOVE    "90"        TO  WRK-SRYKBN
               WHEN  ( WRK-SRYKBN(1:1)    =  "2" )
                   MOVE    "20"        TO  WRK-SRYKBN
               WHEN  ( WRK-SRYKBN(1:1)    =  "3" )
                   MOVE    "30"        TO  WRK-SRYKBN
               WHEN  ( WRK-SRYKBN  =   "64" )
                   MOVE    "60"        TO  WRK-SRYKBN
               WHEN  ( WRK-SRYKBN  =   "95" OR "96" )
                   GO  TO  230-MAIN-CHK-SYORI-EXT
           END-EVALUATE
      *
           IF    ( WRK-PARA-SRYKBN(1)  =   "*" )   OR
                 ( WRK-PARA-SRYKBN(1)  =   WRK-SRYKBN )    OR
                 ( WRK-PARA-SRYKBN(2)  =   WRK-SRYKBN )    OR
                 ( WRK-PARA-SRYKBN(3)  =   WRK-SRYKBN )    OR
                 ( WRK-PARA-SRYKBN(4)  =   WRK-SRYKBN )    OR
                 ( WRK-PARA-SRYKBN(5)  =   WRK-SRYKBN )
               MOVE    1           TO  FLG-OK
           ELSE
               GO  TO  230-MAIN-CHK-SYORI-EXT
           END-IF
      *
           MOVE    ZERO            TO  FLG-OK
      *
      *    在点数チェック
           IF    ( WRK-PARA-IJYOU  NOT =   ZERO )  AND
                 ( WRK-PARA-IKA    NOT =   ZERO )
               IF    ( WRK-ZAITEN      >=  WRK-PARA-IJYOU ) AND
                     ( WRK-ZAITEN      <=  WRK-PARA-IKA )
                   MOVE    1           TO  FLG-OK
               END-IF
           ELSE
               IF      WRK-PARA-IJYOU  NOT =   ZERO
                   IF      WRK-ZAITEN      >=  WRK-PARA-IJYOU
                       MOVE    1           TO  FLG-OK
                   END-IF
               END-IF
               IF      WRK-PARA-IKA    NOT =   ZERO
                   IF      WRK-ZAITEN      <=  WRK-PARA-IKA
                       MOVE    1           TO  FLG-OK
                   END-IF
               END-IF
           END-IF
           .
       230-MAIN-CHK-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    チェック処理
      *****************************************************************
       230-SRYCD-CHK-SYORI-SEC     SECTION.
      *
           PERFORM 900-TENSU-READ-SEC
           IF      FLG-TENSU       =   1
               GO  TO  230-SRYCD-CHK-SYORI-EXT
           END-IF
      *
      *    優先順位１
           IF    ( TNS-TEN         >   0 ) AND
                 ( TNS-TENSIKIBETU =   1   OR  3   OR  5 ) AND
                 ( TNS-SRYCD(1:1)  =   "1" )
               IF      WRK-NAIYO-SRYCD(1)  =   SPACE
                   MOVE    TNS-SRYCD   TO  WRK-NAIYO-SRYCD(1)
                   MOVE    TNS-NAME    TO  WRK-NAIYO-NAME(1)
               END-IF
               COMPUTE CNT-NAIYO   =   CNT-NAIYO   +   1
           ELSE
      *        優先順位２
               IF    ( TNS-TEN         >   0 ) AND
                     ( TNS-TENSIKIBETU =   7   OR  9 )
                   IF      WRK-NAIYO-SRYCD(2)  =   SPACE
                       MOVE    TNS-SRYCD   TO  WRK-NAIYO-SRYCD(2)
                       MOVE    TNS-NAME    TO  WRK-NAIYO-NAME(2)
                   END-IF
                   COMPUTE CNT-NAIYO   =   CNT-NAIYO   +   1
               ELSE
      *            優先順位２
                   IF    ( TNS-TEN         >   0 ) 
                       IF      WRK-NAIYO-SRYCD(3)  =   SPACE
                           MOVE    TNS-SRYCD   TO  WRK-NAIYO-SRYCD(3)
                           MOVE    TNS-NAME    TO  WRK-NAIYO-NAME(3)
                       END-IF
                       COMPUTE CNT-NAIYO   =   CNT-NAIYO   +   1
                   END-IF
               END-IF
           END-IF
           .
       230-SRYCD-CHK-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    統計セット処理
      *****************************************************************
       240-TOKEI-SET-SEC           SECTION.
      *
      *    統計データ検索
           INITIALIZE                  TOKEI-REC
           MOVE    WRK-SRYKBN      TO  TOKEI-SRYKBN
           MOVE    PTINF-KANANAME  TO  TOKEI-KANANAME
           MOVE    PTNUM-PTNUM     TO  TOKEI-PTNUM
           MOVE    WRK-ZAITEN      TO  TOKEI-TEN
           MOVE    WRK-SRYYMD      TO  TOKEI-SRYYMD
      *
           IF      WRK-NAIYO-SRYCD(1)  NOT =   SPACE
               MOVE    WRK-NAIYO-SRYCD(1)  TO  TOKEI-SRYCD
               MOVE    WRK-NAIYO-NAME(1)   TO  TOKEI-NAIYO
           ELSE
               IF      WRK-NAIYO-SRYCD(2)  NOT =   SPACE
                   MOVE    WRK-NAIYO-SRYCD(2)  TO  TOKEI-SRYCD
                   MOVE    WRK-NAIYO-NAME(2)   TO  TOKEI-NAIYO
               ELSE
                   MOVE    WRK-NAIYO-SRYCD(3)  TO  TOKEI-SRYCD
                   MOVE    WRK-NAIYO-NAME(3)   TO  TOKEI-NAIYO
               END-IF
           END-IF
           IF      CNT-NAIYO   >   1
               STRING  TOKEI-NAIYO     DELIMITED BY SPACE
                       "　他"          DELIMITED BY SIZE
                                       INTO    TOKEI-NAIYO
               END-STRING
           END-IF
      *
           MOVE    IDX-K           TO  TOKEI-IDX
           MOVE    PTINF-NAME      TO  TOKEI-NAME
      *
           PERFORM 900-TOKEI-READ-SEC
      *
           IF      FLG-TOKEI       =   1
               COMPUTE CNT-TOKEI   =   CNT-TOKEI   +   1
               WRITE   TOKEI-REC
           END-IF
           .
       240-TOKEI-SET-EXT.
           EXIT.
      *****************************************************************
      *    統計出力処理
      *****************************************************************
       260-TOKEI-OUT-SEC           SECTION.
      *
           MOVE    ZERO            TO  CNT-PAGE
           MOVE    ZERO            TO  CNT-LINE
      *
           INITIALIZE                  TOKEI-REC
      *    統計ファイル読み込み
           PERFORM 900-TOKEI-NEXT-SEC
      *
           PERFORM UNTIL ( FLG-TOKEI       =   1  )
               MOVE    TOKEI-SRYKBN    TO  WRK-SRYKBN
               MOVE    ZERO            TO  WRK-PTCNT
               MOVE    SPACE           TO  WRK-PTNUM
      *        診療区分見出し
               PERFORM 310-PRT-HEAD-SEC
               PERFORM UNTIL ( FLG-TOKEI       =   1  )
                       OR    ( TOKEI-SRYKBN    NOT =   WRK-SRYKBN )
      *            明細
                   PERFORM 320-PRT-MEISAI-SEC
      *            統計ファイル読み込み
                   PERFORM 900-TOKEI-NEXT-SEC
               END-PERFORM
      *        合計
               PERFORM 330-PRT-GOKEI-SEC
           END-PERFORM
             .
       260-TOKEI-OUT-EXT.
           EXIT.
      *****************************************************************
      *    見出し
      *****************************************************************
       310-PRT-HEAD-SEC            SECTION.
      *
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   1
           MOVE    ZERO            TO  CNT-LINE
      *
           MOVE    SPACE           TO  HCMG008
      *
           MOVE    CNT-PAGE        TO  WRK-Z03
           MOVE    WRK-Z03         TO  HCMG008-PAGE
      *
           MOVE    WRK-PRT-NYUGAIKBN
                                   TO  HCMG008-NYUGAIKBN
           MOVE    WRK-PRT-JYOKEN  TO  HCMG008-JYOKEN
           MOVE    WRK-PRT-KIKAN   TO  HCMG008-KIKAN
           MOVE    WRK-PRT-PRTYMD  TO  HCMG008-PRTYMD
      *
           EVALUATE    WRK-SRYKBN
               WHEN    "11"
                   MOVE    "初　　診"      TO  HCMG008-SRYKBN
               WHEN    "12"
                   MOVE    "再　　診"      TO  HCMG008-SRYKBN
               WHEN    "13"
                   MOVE    "医学管理"      TO  HCMG008-SRYKBN
               WHEN    "14"
                   MOVE    "在　　宅"      TO  HCMG008-SRYKBN
               WHEN    "20"
                   MOVE    "投　　薬"      TO  HCMG008-SRYKBN
               WHEN    "30"
                   MOVE    "注　　射"      TO  HCMG008-SRYKBN
               WHEN    "40"
                   MOVE    "処　　置"      TO  HCMG008-SRYKBN
               WHEN    "50"
                   MOVE    "手　　術"      TO  HCMG008-SRYKBN
               WHEN    "54"
                   MOVE    "麻　　酔"      TO  HCMG008-SRYKBN
               WHEN    "60"
                   MOVE    "検　　査"      TO  HCMG008-SRYKBN
               WHEN    "70"
                   MOVE    "画像診断"      TO  HCMG008-SRYKBN
               WHEN    "80"
                   MOVE    "そ の 他"      TO  HCMG008-SRYKBN
               WHEN    "90"
                   MOVE    "入　　院"      TO  HCMG008-SRYKBN
               WHEN    "95"
                   MOVE    "自　　費"      TO  HCMG008-SRYKBN
           END-EVALUATE
           .
       310-PRT-HEAD-EXT.
           EXIT.
      *****************************************************************
      *    明細
      *****************************************************************
       320-PRT-MEISAI-SEC          SECTION.
      *
           IF      CNT-LINE        >   52
      *        帳票編集処理
               PERFORM 390-PRINT-OUT-SEC
      *        見出し
               PERFORM 310-PRT-HEAD-SEC
           END-IF
      *
           COMPUTE CNT-LINE    =   CNT-LINE    +   1
      *
           IF      TOKEI-PTNUM     NOT =   WRK-PTNUM
               MOVE    TOKEI-PTNUM     TO  WRK-PTNUM
               MOVE    TOKEI-PTNUM     TO  HCMG008-PTNUM(CNT-LINE)
               MOVE    TOKEI-NAME      TO  HCMG008-NAME(CNT-LINE)
               COMPUTE WRK-PTCNT   =   WRK-PTCNT   +   1
           END-IF
      *
           MOVE    TOKEI-NAIYO     TO  HCMG008-NAIYO(CNT-LINE)
      *
           MOVE    TOKEI-TEN       TO  WRK-Z10
           MOVE    WRK-Z10         TO  HCMG008-TENSU(CNT-LINE)
           MOVE    "点"            TO  HCMG008-TENLBL(CNT-LINE)
      *
           MOVE    TOKEI-SRYYMD    TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMD      TO  HCMG008-SRYYMD(CNT-LINE)
           .
       320-PRT-MEISAI-EXT.
           EXIT.
      *****************************************************************
      *    合計
      *****************************************************************
       330-PRT-GOKEI-SEC           SECTION.
      *
           IF      CNT-LINE        >   52
      *        帳票編集処理
               PERFORM 390-PRINT-OUT-SEC
      *        見出し
               PERFORM 310-PRT-HEAD-SEC
           END-IF
      *
           COMPUTE CNT-LINE    =   CNT-LINE    +   1
      *
           MOVE    WRK-PTCNT       TO  WRK-Z10
           MOVE    WRK-Z10         TO  WRK-PRT-NINZU
           MOVE    WRK-PRT-GOKEI   TO  HCMG008-NAME(CNT-LINE)
      *
      *    印刷処理
           PERFORM 390-PRINT-OUT-SEC
           .
       330-PRT-GOKEI-EXT.
           EXIT.
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC           SECTION.
      *
           INITIALIZE                      ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           MOVE    SPACE               TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
           MOVE    "HCMG008.red"       TO  SPRT-PRTID
           MOVE    "診療区分別指定点数該当患者一覧"
                                       TO  SPRT-TITLE
           MOVE    HCMG008             TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"               USING
                                           ORCSPRTAREA
                                           SPA-AREA
           IF      SPRT-RETURN     =   ZERO
               CONTINUE
           ELSE
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    前ゼロ編集処理
      *****************************************************************
       800-TENSU-HEN-SEC           SECTION.
      *
           MOVE    SPACE           TO  WRK-HEN-TEN-OUT
      *
           PERFORM VARYING IDX-Z   FROM    1   BY  1
                   UNTIL   IDX-Z   >   10
               IF      WRK-HEN-TEN-IN(IDX-Z:1) NOT =   SPACE
                   MOVE    WRK-HEN-TEN-IN(IDX-Z:)
                                       TO  WRK-HEN-TEN-OUT
                   MOVE    10          TO  IDX-Z
               END-IF
           END-PERFORM
           .
       800-TENSU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC           SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMD
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           INSPECT WRK-HENYMDG         REPLACING  ALL "  "  BY  "　"
      *
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT               RECEERR-FILE
           IF      STS-RECEERR     =   ZERO
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
grpsys         MOVE    SPA-HOSPNUM     TO  JOB-HOSPNUM
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
grpsys                                     SPA-AREA
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
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    TOKEIPARA       TO  IF-FILENAME
           CALL    "orcfiledel"        USING
                                       ORCSFDELAREA
      *
           DISPLAY "*** ORCBG029 IN "      CNT-TOKEI
           DISPLAY "*** ORCBG029 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    SPA-HOSPNUM     TO  JOB-HOSPNUM
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
                                       SPA-AREA
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           .
       300-END-EXT.
           EXIT.
      *
     *****************************************************************
      *    統計ファイル読込
      *****************************************************************
       900-TOKEI-READ-SEC          SECTION.
      *
           READ    TOKEI-FILE
               INVALID
                   MOVE    1           TO  FLG-TOKEI
                   
               NOT INVALID
                   MOVE    ZERO        TO  FLG-TOKEI
           END-READ
      *
           .
       900-TOKEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    統計ファイル順読込
      *****************************************************************
       900-TOKEI-NEXT-SEC          SECTION.
      *
           READ    TOKEI-FILE      NEXT
               AT  END
                   MOVE    1           TO  FLG-TOKEI
               NOT AT  END
                   MOVE    ZERO        TO  FLG-TOKEI
           END-READ
           .
       900-TOKEI-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    診療会計マスタ検索
      *****************************************************************
       900-SRYACCT-DBSELECT-SEC    SECTION.
      *
           INITIALIZE                  SRYACCT-REC
           MOVE    SPA-HOSPNUM     TO  ACCT-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN
                                   TO  ACCT-NYUGAIKBN
           MOVE    WRK-PARA-STRYM  TO  ACCT-STSRYYM
           MOVE    WRK-PARA-ENDYM  TO  ACCT-EDSRYYM
           MOVE    "%"             TO  ACCT-SRYKBN
           MOVE    SRYACCT-REC     TO  MCPDATA-REC
      *
           MOVE    "tbl_sryacct"   TO  MCP-TABLE
           MOVE    "key59"         TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
      *
           IF      MCP-RC          =   ZERO
               MOVE    ZERO            TO  FLG-SRYACCT
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACCT
               INITIALIZE                  SRYACCT-REC
           END-IF
           .
       900-SRYACCT-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    診療会計マスタ検索
      *****************************************************************
       900-SRYACCT-DBFETCH-SEC     SECTION.
      *
           MOVE    "tbl_sryacct"   TO  MCP-TABLE
           MOVE    "key59"         TO  MCP-PATHNAME
           PERFORM 900-DBFETCH-SEC
      *
           IF      MCP-RC          =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
               MOVE    ZERO            TO  FLG-SRYACCT
           ELSE
               MOVE    1               TO  FLG-SRYACCT
               INITIALIZE                  SRYACCT-REC
           END-IF
           .
       900-SRYACCT-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    診療会計マスタ検索
      *****************************************************************
       900-SRYACCT-DBCLOSE-SEC     SECTION.
      *
           MOVE    "tbl_sryacct"   TO  MCP-TABLE
           MOVE    "key59"         TO  MCP-PATHNAME
           PERFORM 900-DBCLOSECURSOR-SEC
           .
       900-SRYACCT-DBCLOSE-EXT.
      *****************************************************************
      *    入院会計検索処理
      *****************************************************************
       900-NYUINACCT-DBSELECT-SEC  SECTION.
      *
           INITIALIZE                  NYUINACCT-REC
           MOVE    SPA-HOSPNUM     TO  NACCT-HOSPNUM
           MOVE    WRK-PARA-STRYM  TO  NACCT-SRYYM
           MOVE    WRK-PARA-ENDYM  TO  NACCT-CREYMD
           MOVE    "1"             TO  NACCT-NYUGAIKBN
           MOVE    "5"             TO  NACCT-ZAISKBKBN
           MOVE    NYUINACCT-REC   TO  MCPDATA-REC
      *
           MOVE    "tbl_nyuinacct" TO  MCP-TABLE
           MOVE    "key42"         TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
      *
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
               INITIALIZE                  NYUINACCT-REC
           END-IF
           .
       900-NYUINACCT-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    入院会計FETCH処理
      *****************************************************************
       900-NYUINACCT-DBFETCH-SEC   SECTION.
      *
           MOVE    "tbl_nyuinacct" TO  MCP-TABLE
           MOVE    "key42"         TO  MCP-PATHNAME
           PERFORM 900-DBFETCH-SEC
      *
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
               INITIALIZE                  NYUINACCT-REC
           END-IF
           .
       900-NYUINACCT-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    入院会計マスタ検索
      *****************************************************************
       900-NYUINACCT-DBCLOSE-SEC   SECTION.
      *
           MOVE    "tbl_nyuinacct" TO  MCP-TABLE
           MOVE    "key42"         TO  MCP-PATHNAME
           PERFORM 900-DBCLOSECURSOR-SEC
           .
       900-NYUINACCT-DBCLOSE-EXT.
      *****************************************************************
      *    診療行為マスタ検索
      *****************************************************************
       900-SRYACT-DBSELECT-SEC     SECTION.
      *
           INITIALIZE                  SRYACT-REC
           MOVE    SPA-HOSPNUM     TO  SRY-HOSPNUM
           MOVE    ACCT-NYUGAIKBN
                                   TO  SRY-NYUGAIKBN
           MOVE    ACCT-PTID       TO  SRY-PTID
           MOVE    ACCT-SRYKA      TO  SRY-SRYKA
           MOVE    ACCT-SRYYM      TO  SRY-SRYYM
           MOVE    ACCT-ZAINUM     TO  SRY-ZAINUM
           MOVE    SRYACT-REC      TO  MCPDATA-REC
      *
           MOVE    "tbl_sryact"    TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
      *
           IF      MCP-RC          =   ZERO
               MOVE    ZERO            TO  FLG-SRYACT
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACT
               INITIALIZE                  SRYACT-REC
           END-IF
           .
       900-SRYACT-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタ検索
      *****************************************************************
       900-SRYACT-DBFETCH-SEC      SECTION.
      *
           MOVE    "tbl_sryact"    TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 900-DBFETCH-SEC
      *
           IF      MCP-RC          =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               MOVE    1               TO  FLG-SRYACT
               INITIALIZE                  SRYACT-REC
           END-IF
           .
       900-SRYACT-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタ検索
      *****************************************************************
       900-SRYACT-DBCLOSE-SEC      SECTION.
      *
           MOVE    "tbl_sryact"    TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 900-DBCLOSECURSOR-SEC
           .
       900-SRYACT-DBCLOSE-EXT.
      *****************************************************************
      *    患者情報マスタ読込
      *****************************************************************
       900-PTINF-READ-SEC          SECTION.
      *
           MOVE    SPACE           TO  PTINF-REC
           INITIALIZE                  PTINF-REC
           MOVE    SPA-HOSPNUM     TO  PTINF-HOSPNUM
           MOVE    WRK-PTID        TO  PTINF-PTID
           MOVE    PTINF-REC       TO  MCPDATA-REC
      *
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
      *
           IF      MCP-RC          =   ZERO
               MOVE    ZERO            TO  FLG-PTINF
               MOVE    MCPDATA-REC     TO  PTINF-REC
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-DBCLOSECURSOR-SEC
           .
       900-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者番号マスタ読込
      *****************************************************************
       900-PTNUM-READ-SEC          SECTION.
      *
           INITIALIZE                  PTNUM-REC
           MOVE    SPA-HOSPNUM     TO  PTNUM-HOSPNUM
           MOVE    WRK-PTID        TO  PTNUM-PTID
      *
           MOVE    "tbl_ptnum"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
      *
           IF      MCP-RC          =   ZERO
               MOVE    ZERO            TO  FLG-PTNUM
               MOVE    MCPDATA-REC     TO  PTNUM-REC
           ELSE
               MOVE    1               TO  FLG-PTNUM
               INITIALIZE                  PTNUM-REC
           END-IF
      *
           MOVE    "tbl_ptnum"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-DBCLOSECURSOR-SEC
           .
       900-PTNUM-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ読込
      *****************************************************************
       900-TENSU-READ-SEC          SECTION.
      *
           MOVE    "01"            TO  WRK-SRYYMD(7:2)
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    SPA-HOSPNUM     TO  TNS-HOSPNUM
           MOVE    WRK-SRYCD       TO  TNS-SRYCD
           MOVE    WRK-SRYYMD      TO  TNS-YUKOSTYMD
                                       TNS-YUKOEDYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
      *
           IF      MCP-RC          =   ZERO
               MOVE    ZERO            TO  FLG-TENSU
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               MOVE    1               TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-DBCLOSECURSOR-SEC
           .
       900-TENSU-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC            SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           IF      MCP-RC          =   ZERO
               PERFORM 900-DBFETCH-SEC
           END-IF
           .
       900-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-DBFETCH-SEC             SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           .
       900-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＣＬＯＳＥ処理
      *****************************************************************
       900-DBCLOSECURSOR-SEC       SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           .
       900-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC
           MOVE    LOW-VALUE       TO  MCP-TABLE
           MOVE    LOW-VALUE       TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           MOVE    "DBSTART"       TO  MCP-FUNC
           MOVE    LOW-VALUE       TO  MCP-TABLE
           MOVE    LOW-VALUE       TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           .
       100-DBOPEN-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC
           MOVE    LOW-VALUE       TO  MCP-TABLE
           MOVE    LOW-VALUE       TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC
           MOVE    LOW-VALUE       TO  MCP-TABLE
           MOVE    LOW-VALUE       TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           .
       900-DBDISCONNECT-EXT.
           EXIT.
