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
       PROGRAM-ID.             ORCBCHKSND.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : チェックマスタ２設定
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/02/03    NACL-太田     新規作成
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
      *    チェックマスタ
           SELECT  CHK-FILE        ASSIGN   BCHKSND01PARA
                   ORGANIZATION    LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-CHK.
      *
      *    確認リスト
           SELECT  HCMSL80-FILE    ASSIGN   BCHKSND02PARA
                   ORGANIZATION    LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-HCMSL80.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    チェックマスタ
       FD  CHK-FILE.
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *
      *    確認リスト
       FD  HCMSL80-FILE.
           COPY    "HCMSL80.INC".
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    チェックマスタファイル
           COPY    "CPCOMMONDAT2.INC"
                                           REPLACING   //RECE01//
                                           BY          //BCHKSND01//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    確認リストファイル
           COPY    "CPCOMMONDAT2.INC"
                                           REPLACING   //RECE01//
                                           BY          //BCHKSND02//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"      REPLACING  //RECE01PARA//
                                           BY         //RECEERR//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-RECEERR                 PIC X(02).
           03  STS-CHK                     PIC X(02).
           03  STS-HCMSL80                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-ERR                             PIC 9(01).
           03  FLG-CHKMST                          PIC 9(01).
           03  FLG-CHK-KEY2                        PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-CHKSND                          PIC 9(01).
           03  FLG-INSERR                          PIC 9(01).
           03  FLG-BYOMEI                          PIC 9(01).
           03  FLG-HCMSL80                         PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-CHKMST                          PIC 9(08).
           03  CNT-LINE                            PIC 9(08).
           03  CNT-PAGE                            PIC 9(08).
           03  CNT-RENNUM                          PIC 9(08).
           03  CNT-OUTPUT                          PIC 9(08).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                                PIC 9(05).
           03  IDX1                                PIC 9(05).
           03  IDXE                                PIC 9(05).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                      PIC 9(07).
           03  WRK-PARA-SHELLID                    PIC X(08).
           03  WRK-PARA-HOSPID                     PIC X(24).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR                         PIC X(200).
           03  WRK-ZZZZ9-G.
               05  WRK-ZZZZ9                       PIC ZZZZ9.
           03  WRK-TNS-SRYCD                       PIC X(09).
           03  WRK-TNS-YMD                         PIC X(08).
           03  WRK-BYOMEICD                        PIC X(07).
           03  WRK-MEMO                            PIC X(500).
           03  WRK-TITLE                           PIC X(100).
           03  WRK-STR                             PIC X(200).
           03  WRK-LEN                             PIC 9(05).
           03  WRK-SHO                             PIC 9(05).
           03  WRK-AMARI                           PIC 9(05).
           03  WRK-MAE-INPUT                       PIC X(300).
           03  WRK-OUT-INPUT                       PIC X(300).
           03  WRK-OUT-MAX                         PIC 9(05).
           03  WRK-STR-LEFT                        PIC X(500).
           03  WRK-STR-LEFT-Z      REDEFINES       WRK-STR-LEFT.
               05  WRK-STR-LEFT-ZX99               PIC Z(9)9.
               05                                  PIC X(490).
           03  WRK-STR-LEFT-TMP                    PIC X(500).
      *        全角編集用項目
           03  WRK-N.
               05  WRK-KNS-N                       PIC X(10).
               05  WRK-TIME-N                      PIC X(16).
           03  WRK-CHKKBNMEI                       PIC X(20).
      *
       01  WKCHK-KEY-AREA.
           03  WKCHK-KEY-N.
               05  WKCHK-CHKKBN                    PIC  X(01).
               05  WKCHK-SRYCD                     PIC  X(09).
               05  WKCHK-YUKOSTYMD                 PIC  X(08).
               05  WKCHK-YUKOEDYMD                 PIC  X(08).
               05  WKCHK-CDKBN                     PIC  X(01).
           03  WKCHK-KEY-O.
               05  WKCHK-CHKKBN                    PIC  X(01).
               05  WKCHK-SRYCD                     PIC  X(09).
               05  WKCHK-YUKOSTYMD                 PIC  X(08).
               05  WKCHK-YUKOEDYMD                 PIC  X(08).
               05  WKCHK-CDKBN                     PIC  X(01).
      *
       01  WKCHK-REC                               PIC X(2000).
      *
       01  CONST-AREA.
           03  CONST-CHK-MAX                   PIC 9(05)   VALUE 10.
           03  CONST-LINE-MAX                  PIC 9(05)   VALUE 80.
      *
       01  MES-AREA.
           03  MES-MES01.
               05  PIC X(40)
                   VALUE   "　移行先マスタに登録済みでした    ".
               05  PIC X(40)
                   VALUE   "（移行元マスタから削除しました）  ".
           03  MES-MES02.
               05  PIC X(40)
                   VALUE   "　＜移行元マスタの病名＞          ".
           03  MES-MES03.
               05  PIC X(40)
                   VALUE   "　移行先マスタの更新に失敗しました".
           03  MES-MES04.
               05  PIC X(40)
                   VALUE   "　移行元マスタの更新に失敗しました".
      *
           COPY    "CPSHELLTBL.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
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
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *    チェックマスター２
       01  CHKSND-REC.
           COPY    "CPCHKSND.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    印刷ＤＢ制御サブ
           COPY    "CPORCSPRT.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                         SECTION.
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
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
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
           INITIALIZE                  WKCHK-KEY-AREA
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
      *
           MOVE    "適用病名情報更新"  TO  WRK-TITLE
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBCHKSND"        TO  JOB-PGID
           MOVE    WRK-TITLE           TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "BCHKS01"           TO  BCHKSND01PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  BCHKSND01PARA-TERMID
      *
           MOVE    "BCHKS02"           TO  BCHKSND02PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  BCHKSND02PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
           MOVE    ZERO                TO  FLG-END
      *
           PERFORM 800-MCNDATE-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    チェックマスタ情報ファイル作成
           PERFORM 2001-CHK-OUT-SEC
      *
      *    チェックマスタ情報移動処理
           PERFORM 2001-CHK-MOV-SEC
      *
      *    確認ファイル出力処理
           PERFORM 2001-HCMSL80-OUT-SEC
      *
           MOVE    1                   TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェックマスタ情報ファイル作成
      *****************************************************************
       2001-CHK-OUT-SEC            SECTION.
      *
           MOVE    SPACE               TO  WKCHK-KEY-AREA
      *
           OPEN    OUTPUT          CHK-FILE
      *
           PERFORM 900-CHK-KEY13-SEL-SEC
      *
           PERFORM UNTIL ( FLG-CHKMST  NOT =   ZERO )
      *
               MOVE    CHK-KEY         TO  WKCHK-KEY-N
      *
               IF    ( WKCHK-KEY-O     NOT =   WKCHK-KEY-N )
                   WRITE   CHK-REC
                   MOVE    WKCHK-KEY-N TO  WKCHK-KEY-O
               END-IF
      *
               PERFORM 900-CHK-KEY13-FET-SEC
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-CHK-KEY13  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           CLOSE   CHK-FILE
      *
           .
       2001-CHK-OUT-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ情報移動処理
      *****************************************************************
       2001-CHK-MOV-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-CHKMST
           MOVE    ZERO            TO  CNT-CHKMST
           MOVE    ZERO            TO  FLG-ERR
      *
           MOVE    ZERO            TO  CNT-PAGE
      *
           PERFORM 20011-HEAD-HEN-SEC
      *
           OPEN    INPUT               CHK-FILE
           OPEN    OUTPUT              HCMSL80-FILE
      *
           PERFORM 900-CHK-READ-SEC
      *
           PERFORM UNTIL ( FLG-CHKMST  NOT =   ZERO )
      *
               PERFORM 2101-SYORI-KEIKA-HEN-SEC
      *
               PERFORM 2001-CHKSND-SAKUSEI-SEC
      *
               PERFORM 900-CHK-READ-SEC
      *
           END-PERFORM
      *
           IF    ( CNT-LINE        >   2 )
               WRITE   HCMSL80
           END-IF
      *
           CLOSE   CHK-FILE
           CLOSE   HCMSL80-FILE
      *
           .
       2001-CHK-MOV-EXT.
           EXIT.
      *****************************************************************
      *    ヘッダ情報編集処理
      *****************************************************************
       20011-HEAD-HEN-SEC              SECTION.
      *
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   1
      *
           MOVE    CNT-PAGE        TO  WRK-ZZZZ9
      *
           INITIALIZE                  HCMSL80
      *
           STRING
               "＊＊＊＊　適用病名情報更新確認リスト　＊＊＊"
                                                   DELIMITED   BY  SIZE
               "（作成日："                        DELIMITED   BY  SIZE
               LNK-PRTKANRI-SKYYMD(1:4)            DELIMITED   BY  SIZE
               "."                                 DELIMITED   BY  SIZE
               LNK-PRTKANRI-SKYYMD(5:2)            DELIMITED   BY  SIZE
               "."                                 DELIMITED   BY  SIZE
               LNK-PRTKANRI-SKYYMD(7:2)            DELIMITED   BY  SIZE
               "）"                                DELIMITED   BY  SIZE
               "PAGE "                             DELIMITED   BY  SIZE
               WRK-ZZZZ9-G                         DELIMITED   BY  SIZE
           INTO    HCMSL80-MOJI (1)
           END-STRING
      *
           MOVE    2               TO  CNT-LINE
      *
           .
       20011-HEAD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    処理経過編集処理
      *****************************************************************
       2101-SYORI-KEIKA-HEN-SEC        SECTION.
      *
           MOVE    ZERO            TO  WRK-SHO
                                       WRK-AMARI
           DIVIDE  50          INTO    CNT-CHKMST GIVING  WRK-SHO
           REMAINDER WRK-AMARI
           END-DIVIDE
      *
           IF    ( WRK-AMARI       NOT =   ZERO )
               GO  TO  2101-SYORI-KEIKA-HEN-EXT
           END-IF
      *
           MOVE    CNT-CHKMST      TO  WRK-STR-LEFT-ZX99
           PERFORM 800-STR-HIDARIZUME-HEN-SEC
           MOVE    WRK-STR-LEFT    TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT   TO  WRK-KNS-N
           PERFORM 800-MCNDATE-SEC
           MOVE    SPACE           TO  WRK-MAE-INPUT
           MOVE    SMCNDATE-HMS(1:2)
                                   TO  WRK-MAE-INPUT(1:2)
           MOVE    "."             TO  WRK-MAE-INPUT(3:1)
           MOVE    SMCNDATE-HMS(3:2)
                                   TO  WRK-MAE-INPUT(4:2)
           MOVE    "."             TO  WRK-MAE-INPUT(6:1)
           MOVE    SMCNDATE-HMS(5:2)
                                   TO  WRK-MAE-INPUT(7:2)
           MOVE    WRK-MAE-INPUT   TO  WRK-TIME-N
      *
      *    ステップ途中処理
           MOVE    "STM"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           STRING  "処理件数："        DELIMITED BY SIZE
                   WRK-KNS-N           DELIMITED BY SPACE
                   "件　"              DELIMITED BY SIZE
                   WRK-TIME-N          DELIMITED BY SPACE
           INTO    JOB-YOBI
           END-STRING
           MOVE    ZERO                TO  JOB-UPDCNT
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBCHKSND"        TO  JOB-PGID
           MOVE    WRK-TITLE           TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           .
       2101-SYORI-KEIKA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２作成処理
      *****************************************************************
       2001-CHKSND-SAKUSEI-SEC         SECTION.
      *
           PERFORM 900-CHKSND-KEY3-SEL-SEC
           IF    ( FLG-CHKSND      =   ZERO )
      *
               MOVE    CHK-REC     TO  WKCHK-REC
               PERFORM 20011-BYO-INF-HEN-SEC
               MOVE    WKCHK-REC   TO  CHK-REC
      *
               PERFORM 20011-CHKMST-DEL-SEC
           ELSE
      *
               MOVE    CHK-REC     TO  WKCHK-REC
               PERFORM 20011-CHK-TO-CHKSND-SEC
               MOVE    WKCHK-REC   TO  CHK-REC
      *
               IF    ( FLG-INSERR  =   ZERO )
                   PERFORM 20011-CHKMST-DEL-SEC
               END-IF
           END-IF
      *
           .
       2001-CHKSND-SAKUSEI-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ情報編集処理
      *****************************************************************
       20011-CHKMST-DEL-SEC        SECTION.
      *
           MOVE    CHK-REC              TO  MCPDATA-REC
           MOVE    PATH-TBL-CHK-DEL11   TO  MCP-PATH
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    CHK-SRYCD       TO  WRK-TNS-SRYCD
               MOVE    CHK-YUKOSTYMD   TO  WRK-TNS-YMD
               PERFORM 2200-SRYNAME-HEN-SEC
               MOVE    WRK-MEMO        TO  HCMSL80-MOJI (CNT-LINE)
               PERFORM 250-LINE-CNT-SEC
               MOVE    MES-MES04       TO  HCMSL80-MOJI (CNT-LINE)
               PERFORM 250-LINE-CNT-SEC
           END-IF
      *
           .
       20011-CHKMST-DEL-EXT.
           EXIT.
      *****************************************************************
      *    削除対象チェックマスタ病名編集処理
      *****************************************************************
       20011-BYO-INF-HEN-SEC           SECTION.
      *
           MOVE    CHK-SRYCD       TO  WRK-TNS-SRYCD
           MOVE    CHK-YUKOSTYMD   TO  WRK-TNS-YMD
           PERFORM 2200-SRYNAME-HEN-SEC
           MOVE    WRK-MEMO        TO  HCMSL80-MOJI (CNT-LINE)
           PERFORM 250-LINE-CNT-SEC
      *
           MOVE    MES-MES01       TO  HCMSL80-MOJI (CNT-LINE)
           PERFORM 250-LINE-CNT-SEC
      *
           MOVE    MES-MES02       TO  HCMSL80-MOJI (CNT-LINE)
           PERFORM 250-LINE-CNT-SEC
      *
           PERFORM 900-CHK-KEY2-SEL-SEC
      *
           PERFORM UNTIL ( FLG-CHK-KEY2    NOT =   ZERO )
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   CONST-CHK-MAX )
                   IF    ( CHK-CD (IDX0)   NOT =   SPACE )
                       MOVE    CHK-CD (IDX0)   TO  WRK-BYOMEICD
                       PERFORM 900-BYOMEI-KEY-SEL-SEC
      *
                       STRING  "　"            DELIMITED   BY  SPACE
                               CHK-CD (IDX0)   DELIMITED   BY  SPACE
                               " "             DELIMITED   BY  SIZE
                               BYO-BYOMEI      DELIMITED   BY  SPACE
                       INTO    HCMSL80-MOJI (CNT-LINE)
                       END-STRING
      *
                       PERFORM 250-LINE-CNT-SEC
      *
                   END-IF
               END-PERFORM
      *
               PERFORM 900-CHK-KEY2-FET-SEC
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-CHK-KEY2   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-BYO-INF-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２作成処理
      *****************************************************************
       20011-CHK-TO-CHKSND-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-INSERR
      *
           PERFORM 900-CHK-KEY2-SEL-SEC
      *
           MOVE    ZERO                TO  CNT-RENNUM
      *
           PERFORM UNTIL ( FLG-CHK-KEY2    NOT =   ZERO )
                    OR   ( FLG-INSERR      NOT =   ZERO )
      *
               INITIALIZE              CHKSND-REC
      *
               MOVE    CHK-CHKKBN      TO  CHKSND-CHKKBN
               MOVE    CHK-SRYCD       TO  CHKSND-SRYCD
               MOVE    CHK-YUKOSTYMD   TO  CHKSND-YUKOSTYMD
               MOVE    CHK-YUKOEDYMD   TO  CHKSND-YUKOEDYMD
               MOVE    CHK-CDKBN       TO  CHKSND-CDKBN
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   CONST-CHK-MAX )
                        OR   ( FLG-INSERR      NOT =   ZERO )
      *
                   IF    ( CHK-CD (IDX0)   NOT =   SPACE )
      *
                       COMPUTE CNT-RENNUM  =   CNT-RENNUM  +   1
                       MOVE    CNT-RENNUM      TO  CHKSND-RENNUM
                       MOVE    CHK-CD (IDX0)   TO  CHKSND-CD
                       MOVE    CHK-CD (IDX0)   TO  WRK-BYOMEICD
                       PERFORM 900-BYOMEI-KEY-SEL-SEC
                       MOVE    BYO-BYOMEI      TO  CHKSND-BYOMEI
                       MOVE    "1"             TO  CHKSND-COMPKBN
                       MOVE    SPACE           TO  CHKSND-BYOMEIHENFLG
                       PERFORM 800-MCNDATE-SEC
                       MOVE    SMCNDATE-YMD    TO  CHKSND-CREYMD
                                                   CHKSND-UPYMD
                       MOVE    SMCNDATE-HMS    TO  CHKSND-UPHMS
      *
                       MOVE    CHKSND-REC      TO  MCPDATA-REC
                       MOVE    PATH-TBL-CHKSND-KEY TO  MCP-PATH
                       PERFORM 910-DBINSERT-SEC
                       IF    ( MCP-RC      NOT =   ZERO )
                           MOVE    1           TO  FLG-INSERR
                           PERFORM 910-DBCOMMIT-SEC
                           PERFORM 20011-CHKSND-ERR-SEC
                       END-IF
      *
                   END-IF
               END-PERFORM
      *
               IF    ( FLG-INSERR      =   ZERO )
                   PERFORM 900-CHK-KEY2-FET-SEC
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-CHK-KEY2   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-INSERR           =  ZERO )
               IF    ( CNT-RENNUM      <=  ZERO )
                   MOVE    1           TO  FLG-INSERR
                   PERFORM 20011-CHKSND-ERR-SEC
               END-IF
           END-IF
      *
           .
       20011-CHK-TO-CHKSND-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２追加失敗時のメッセージ編集処理
      *****************************************************************
       20011-CHKSND-ERR-SEC            SECTION.
      *
           MOVE    CHK-SRYCD       TO  WRK-TNS-SRYCD
           MOVE    CHK-YUKOSTYMD   TO  WRK-TNS-YMD
           PERFORM 2200-SRYNAME-HEN-SEC
           MOVE    WRK-MEMO        TO  HCMSL80-MOJI (CNT-LINE)
           PERFORM 250-LINE-CNT-SEC
      *
           MOVE    MES-MES03       TO  HCMSL80-MOJI (CNT-LINE)
           PERFORM 250-LINE-CNT-SEC
      *
      *
           .
       20011-CHKSND-ERR-EXT.
           EXIT.
      *****************************************************************
      *    診療行為名称編集処理
      *****************************************************************
       2200-SRYNAME-HEN-SEC            SECTION.
      *
           MOVE    SPACE           TO  WRK-CHKKBNMEI
           IF    ( CHK-CHKKBN      =   "1" )
               MOVE    "薬剤と病名："
                                   TO  WRK-CHKKBNMEI
           ELSE
               MOVE    "診療行為と病名："
                                   TO  WRK-CHKKBNMEI
           END-IF
      *
           INITIALIZE                  WRK-MEMO
      *
           PERFORM 900-TENSU-KEY-SEL-SEC
      *
           STRING  WRK-CHKKBNMEI   DELIMITED   BY  SPACE
                   CHK-SRYCD       DELIMITED   BY  SIZE
                   " "             DELIMITED   BY  SIZE
                   TNS-NAME        DELIMITED   BY  SPACE
                   " "             DELIMITED   BY  SIZE
                   CHK-YUKOSTYMD   DELIMITED   BY  SIZE
                   "-"             DELIMITED   BY  SIZE
                   CHK-YUKOEDYMD   DELIMITED   BY  SIZE
           INTO    WRK-MEMO
           END-STRING
      *
           .
       2200-SRYNAME-HEN-EXT.
           EXIT.
      *****************************************************************
      *    確認情報ファイル出力処理
      *****************************************************************
       2001-HCMSL80-OUT-SEC            SECTION.
      *
           OPEN    INPUT   HCMSL80-FILE
      *
           MOVE    ZERO            TO  FLG-HCMSL80
      *
           PERFORM 900-HCMSL80-READ-SEC
      *
           PERFORM UNTIL ( FLG-HCMSL80     NOT =   ZERO )
      *
               PERFORM 250-PRINT-SEC
      *
               PERFORM 900-HCMSL80-READ-SEC
      *
           END-PERFORM
      *
           CLOSE   HCMSL80-FILE
      *
           .
       2001-HCMSL80-OUT-EXT.
           EXIT.
      *****************************************************************
      *    行カウント処理
      *****************************************************************
       250-LINE-CNT-SEC                SECTION.
      *
           IF    ( CNT-LINE       >=   CONST-LINE-MAX )
               WRITE   HCMSL80
               PERFORM 20011-HEAD-HEN-SEC
           ELSE
               COMPUTE CNT-LINE    =   CNT-LINE    +   1
           END-IF
      *
           .
       250-LINE-CNT-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       250-PRINT-SEC                   SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
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
           MOVE   "HCMSL80.red"        TO  SPRT-PRTID
           MOVE    "適用病名情報更新確認リスト"
                                       TO  SPRT-TITLE
           MOVE    HCMSL80             TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF    ( SPRT-RETURN         =   ZERO )
               COMPUTE CNT-OUTPUT  =   CNT-OUTPUT  +   1
           ELSE
               DISPLAY "ORCSPRT ERR!!"
           END-IF
      *
           .
       250-PRINT-EXT.
           EXIT.
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
      *    ファイル削除
           PERFORM 800-FILE-DEL-SEC
      *
           IF    ( CNT-CHKMST      =   ZERO )
               MOVE    "処理対象のデータがありませんでした"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           ELSE
               IF    ( CNT-OUTPUT  >   ZERO )
                   MOVE    "確認リストを確認してください"
                                   TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
               END-IF
           END-IF
      *
           DISPLAY "*** BCHKSND01 IN " CNT-CHKMST  " ***"
           DISPLAY "*** BCHKSND01 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-OUTPUT      TO  JOB-UPDCNT
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
      *    文字列左詰処理
      *****************************************************************
       800-STR-HIDARIZUME-HEN-SEC      SECTION.
      *
           MOVE    WRK-STR-LEFT    TO  IDXE
           PERFORM VARYING IDXE    FROM    1   BY  1
                   UNTIL ( IDXE    >       500 )
      *
               IF    ( WRK-STR-LEFT (IDXE:1)
                                       NOT =   SPACE )
                   MOVE    WRK-STR-LEFT (IDXE:)
                                           TO  WRK-STR-LEFT-TMP
                   MOVE    WRK-STR-LEFT-TMP
                                           TO  WRK-STR-LEFT
                   MOVE    500             TO  IDXE
               END-IF
      *
           END-PERFORM
      *
           .
       800-STR-HIDARIZUME-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ファイル削除処理
      *****************************************************************
       800-FILE-DEL-SEC            SECTION.
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    BCHKSND01PARA   TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    BCHKSND02PARA   TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
           .
       800-FILE-DEL-EXT.
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
      *    チェックマスタファイル読込み処理
      *****************************************************************
       900-CHK-READ-SEC                SECTION.
      *
           READ    CHK-FILE
           AT  END
               MOVE    1               TO  FLG-CHKMST
           END-READ
      *
           IF    ( FLG-CHKMST          =   ZERO )
               COMPUTE CNT-CHKMST  =   CNT-CHKMST  +   1
           END-IF
      *
           .
       900-CHK-READ-EXT.
           EXIT.
      *****************************************************************
      *    確認ファイルリスト読込み処理
      *****************************************************************
       900-HCMSL80-READ-SEC            SECTION.
      *
           READ    HCMSL80-FILE
           AT  END
               MOVE    1               TO  FLG-HCMSL80
           END-READ
      *
           .
       900-HCMSL80-READ-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ情報検索(KEY2)
      *****************************************************************
       900-CHK-KEY2-SEL-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK-KEY2
      *
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    PATH-TBL-CHK-KEY2   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  CHK-REC
           ELSE
               MOVE    1           TO  FLG-CHK-KEY2
           END-IF
      *
           .
       900-CHK-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ情報ＦＥＴＣＨ処理(KEY2)
      *****************************************************************
       900-CHK-KEY2-FET-SEC           SECTION.
      *
           MOVE    PATH-TBL-CHK-KEY2  TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  CHK-REC
           ELSE
               MOVE    1           TO  FLG-CHK-KEY2
           END-IF
      *
           .
       900-CHK-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ情報検索(KEY13)
      *****************************************************************
       900-CHK-KEY13-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-CHKMST
      *
           INITIALIZE                  CHK-REC
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    PATH-TBL-CHK-KEY13  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  CHK-REC
           ELSE
               INITIALIZE              CHK-REC
               MOVE    1           TO  FLG-CHKMST
           END-IF
      *
           .
       900-CHK-KEY13-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ情報ＦＥＴＣＨ処理(KEY13)
      *****************************************************************
       900-CHK-KEY13-FET-SEC           SECTION.
      *
           MOVE    PATH-TBL-CHK-KEY13  TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  CHK-REC
           ELSE
               INITIALIZE              CHK-REC
               MOVE    1           TO  FLG-CHKMST
           END-IF
      *
           .
       900-CHK-KEY13-FET-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２情報検索(KEY3)
      *****************************************************************
       900-CHKSND-KEY3-SEL-SEC         SECTION.
      *
           MOVE    ZERO            TO  FLG-CHKSND
      *
           INITIALIZE                  CHKSND-REC
           MOVE    CHK-CHKKBN      TO  CHKSND-CHKKBN
           MOVE    CHK-SRYCD       TO  CHKSND-SRYCD
           MOVE    CHK-YUKOEDYMD   TO  CHKSND-YUKOSTYMD
           MOVE    CHK-YUKOSTYMD   TO  CHKSND-YUKOEDYMD
           MOVE    CHK-CDKBN       TO  CHKSND-CDKBN
      *
           MOVE    CHKSND-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-CHKSND-KEY3
                                   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  CHKSND-REC
           ELSE
               INITIALIZE              CHKSND-REC
               MOVE    1           TO  FLG-CHKSND
           END-IF
      *
           MOVE    PATH-TBL-CHKSND-KEY3
                                   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-CHKSND-KEY3-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理(KEY)
      *****************************************************************
       900-TENSU-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    WRK-TNS-SRYCD   TO  TNS-SRYCD
           MOVE    WRK-TNS-YMD     TO  TNS-YUKOSTYMD
                                       TNS-YUKOEDYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
           MOVE    PATH-TBL-TENSU-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
               INITIALIZE              TNS-TENSU-REC
           END-IF
      *
           MOVE    PATH-TBL-TENSU-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    病名検索処理(KEY)
      *****************************************************************
       900-BYOMEI-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-BYOMEI
      *
           INITIALIZE                  BYOMEI-REC
           MOVE    WRK-BYOMEICD    TO  BYO-BYOMEICD
           MOVE    BYOMEI-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-BYOMEI-KEY     TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC      =   ZERO )
                MOVE    MCPDATA-REC    TO  BYOMEI-REC
           ELSE
                INITIALIZE                 BYOMEI-REC
                MOVE    1              TO  FLG-BYOMEI
           END-IF
      *
           MOVE    PATH-TBL-BYOMEI-KEY TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
      *
       900-BYOMEI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC          SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       910-DBFETCH-SEC            SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       910-DBCLOSE-SEC           SECTION.
      *
      *    暫定的にコメント化
      *    MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
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
      *    ＤＢ　ＣＯＭＭＩＴ処理
      *****************************************************************
       910-DBCOMMIT-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       910-DBCOMMIT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　切断処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           MOVE    LOW-VALUE           TO  MCP-PATH
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-DBDISCONNECT-EXT.
           EXIT.
