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
       PROGRAM-ID.             ORCBCHKKNS1.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : チェックマスタ２設定
      *                      適応病名マスタ->チェックマスタ２
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/12/20    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  03.01.00    NACL-太田    06.07.27  MONFUNC対応
      *  03.05.00    NACL-太田    07.06.07  グループ診療対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    診療行為コードワーク
           SELECT  SRYCD-FILE      ASSIGN   BCHKKNS101PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS   MODE   IS  DYNAMIC
                                   RECORD   KEY    IS  SRYCD-KEY
                                   FILE     STATUS IS  STS-SRYCD.
      *
      *    確認リスト
           SELECT  HCMSL80-FILE    ASSIGN   BCHKKNS102PARA
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
      *    診療行為コードワーク
       FD  SRYCD-FILE.
       01  SRYCD-REC.
           03  SRYCD-KEY           PIC X(09).
           03  SRYCD-FLG           PIC X(01).
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
      *    診療行為コードワーク
           COPY    "CPCOMMONDAT2.INC"
                                           REPLACING   //RECE01//
                                           BY          //BCHKKNS101//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    確認リストファイル
           COPY    "CPCOMMONDAT2.INC"
                                           REPLACING   //RECE01//
                                           BY          //BCHKKNS102//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-RECEERR                 PIC X(02).
           03  STS-SRYCD                   PIC X(02).
           03  STS-HCMSL80                 PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-INPUTCD                         PIC 9(01).
           03  FLG-SRYACT                          PIC 9(01).
           03  FLG-CHKSND                          PIC 9(01).
           03  FLG-TEKBYO                          PIC 9(01).
           03  FLG-SRYCD                           PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-HCMSL80                         PIC 9(01).
           03  FLG-EXIST                           PIC 9(01).
           03  FLG-HAISHI                          PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-SRYCD                           PIC 9(08).
           03  CNT-LINE                            PIC 9(08).
           03  CNT-PAGE                            PIC 9(08).
           03  CNT-RENNUM                          PIC 9(08).
           03  CNT-OUTPUT                          PIC 9(08).
           03  CNT-SYORI                           PIC 9(08).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                                PIC 9(05).
           03  IDXI                                PIC 9(05).
           03  IDXE                                PIC 9(05).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID                      PIC 9(07).
           03  WRK-PARA-SHELLID                    PIC X(08).
           03  WRK-PARA-HOSPNUM                    PIC 9(02).
           03  RECEERR                             PIC X(100).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SRYCD                           PIC X(09).
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
               05  WRK-STR-LEFT-FL                 PIC X(490).
           03  WRK-STR-LEFT-TMP                    PIC X(500).
      *        全角編集用項目
           03  WRK-N.
               05  WRK-KNS-N                       PIC X(10).
               05  WRK-TIME-N                      PIC X(16).
           03  WRK-CHKKBNMEI                       PIC X(20).
           03  WRK-KEY-CD-G.
               05  WRK-KEY-CD-OCC                  OCCURS  21.
                   07  WRK-KEY-CD                  PIC X(07).
                   07  WRK-KEY-CDSEP               PIC X(01).
           03  WRK-IKOCD                           PIC X(07).
           03  WRK-TBYOMEICD-G.
               05  WRK-TBYOMEICD                   PIC X(07)
                                                   OCCURS  21.
      *
       01  CONST-AREA.
           03  CONST-MKCD-MAX                  PIC 9(05)   VALUE 21.
           03  CONST-LINE-MAX                  PIC 9(05)   VALUE 80.
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
      *    印刷管理
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    印刷用データ
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *    入力コード
       01  ICD-REC.
           COPY    "CPINPUTCD.INC".
      *
      *    診療行為マスタ
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    チェックマスター２
       01  CHKSND-REC.
           COPY    "CPCHKSND.INC".
      *
      *    適応病名マスタ
       01  TEKIOUBYOMEI-REC.
           COPY    "CPTEKIOUBYOMEI.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    病名編集サブ
           COPY    "CPORCSBYOMEI.INC".
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
       PROCEDURE                       DIVISION
                                       USING
                                       COMMAND-PARAM.
      *
      *****************************************************************
      *    主　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
           .
       000-PROC-EXT.
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SPA-AREA
      *
           INITIALIZE                  WRK-PARA
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
      *
           MOVE    WRK-PARA-HOSPNUM    TO  SPA-HOSPNUM
      *
           MOVE    "適応病名情報更新（検査）"
                                       TO  WRK-TITLE
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBCHKKNS1"       TO  JOB-PGID
           MOVE    WRK-TITLE           TO  JOB-SHELLMSG
      *
           MOVE    WRK-PARA-HOSPNUM    TO  JOB-HOSPNUM
           PERFORM 800-ORCSJOB-SEC
      *
           MOVE    WRK-PARA-HOSPNUM    TO  BCHKKNS101PARA-HOSPNUM
           MOVE    "BCHKK01"           TO  BCHKKNS101PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  BCHKKNS101PARA-TERMID
      *
           MOVE    WRK-PARA-HOSPNUM    TO  BCHKKNS102PARA-HOSPNUM
           MOVE    "BCHKK02"           TO  BCHKKNS102PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  BCHKKNS102PARA-TERMID
      *
           PERFORM 2004-HEAD-HEN-SEC
      *
           OPEN    OUTPUT              HCMSL80-FILE
      *
           OPEN    OUTPUT              SRYCD-FILE
           CLOSE   SRYCD-FILE
      *
           PERFORM 800-MCNDATE-SEC
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    入力コード有を対象にチェックマスタ２情報登録
           PERFORM 2001-ICD-TO-CHKSND-SEC
      *
      *    診療行為マスタより対象診療コード抽出
           PERFORM 2002-SRYACT-OUT-SEC
      *    対象診療コードよりチェックマスタ２情報登録
           PERFORM 2002-SRYACT-TO-CHKSND-SEC
      *
      *    確認ファイル出力処理
           PERFORM 2004-HCMSL80-OUT-SEC
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    入力コード対象処理
      *****************************************************************
       2001-ICD-TO-CHKSND-SEC      SECTION.
      *
           OPEN    I-O                 SRYCD-FILE
      *
           PERFORM 900-ICD-ALL-SEL-SEC
      *
           PERFORM UNTIL ( FLG-INPUTCD NOT =   ZERO )
      *
             IF  ICD-SRYCD(1:2)        =   "16"
                 MOVE    ICD-SRYCD     TO  WRK-SRYCD
                 PERFORM 900-SRYCD-KREAD-SEC
                 IF  FLG-SRYCD         =   1
                     MOVE  WRK-SRYCD   TO  SRYCD-KEY
                     MOVE  "1"         TO  SRYCD-FLG
                     WRITE SRYCD-REC
      *
                     PERFORM 900-TEKIOUBYOMEI-KEY2-SEL-SEC
                     IF  FLG-TEKBYO    =   ZERO
                         PERFORM 900-CHKSND-KEY6-SEL-SEC
                         IF  FLG-CHKSND =  1
                             PERFORM 2003-KNS-TO-CHKSND-SEC
                         ELSE
                             PERFORM 2004-CHKSND-EXIST-HEN-SEC
                         END-IF
                     END-IF
      *
                     MOVE    "tbl_tekioubyomei"  TO   MCP-TABLE
                     MOVE    "key2"              TO   MCP-PATHNAME
                     PERFORM 910-DBCLOSECURSOR-SEC
                 END-IF
             END-IF
      *
             PERFORM 900-ICD-ALL-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_inputcd"       TO   MCP-TABLE
           MOVE    "all"               TO   MCP-PATHNAME
      *
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           CLOSE   SRYCD-FILE
           .
       2001-ICD-TO-CHKSND-EXT.
           EXIT.
      *****************************************************************
      *    対象診療コードファイル作成
      *****************************************************************
       2002-SRYACT-OUT-SEC             SECTION.
      *
           OPEN    I-O                 SRYCD-FILE
      *
           PERFORM 900-SRYACT-KEY13-SEL-SEC
      *
           PERFORM UNTIL ( FLG-SRYACT  NOT =  ZERO )
      *
               IF  SRY-SRYKBN          =  "60" OR "64"
                   PERFORM VARYING IDX0  FROM  1  BY  1
                           UNTIL ( IDX0  >  5 )
                            OR   ( SRY-SRYCD (IDX0) =  SPACE )
                       IF  SRY-SRYCD(IDX0)(1:2)  =  "16"
                           MOVE  SRY-SRYCD(IDX0)  TO WRK-SRYCD
                           PERFORM 900-SRYCD-KREAD-SEC
                           IF    FLG-SRYCD   =   1
                                 MOVE  WRK-SRYCD
                                             TO  SRYCD-KEY
                                 MOVE  SPACE TO  SRYCD-FLG
                                 WRITE SRYCD-REC
                           END-IF
                       END-IF
                   END-PERFORM
               END-IF
      *
               PERFORM 900-SRYACT-KEY13-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_sryact"        TO   MCP-TABLE
           MOVE    "key13"             TO   MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           CLOSE   SRYCD-FILE
           .
       2002-SRYACT-OUT-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ情報移動処理
      *****************************************************************
       2002-SRYACT-TO-CHKSND-SEC       SECTION.
      *
           OPEN    INPUT               SRYCD-FILE
      *
           PERFORM 900-SRYCD-READ-SEC
      *
           PERFORM UNTIL ( FLG-SRYCD   NOT =   ZERO )
      *
               PERFORM 2004-SYORI-KEIKA-HEN-SEC
      *
               MOVE    SRYCD-KEY       TO   WRK-SRYCD
               PERFORM 900-TEKIOUBYOMEI-KEY2-SEL-SEC
               IF  FLG-TEKBYO          =    ZERO
                   PERFORM 900-CHKSND-KEY6-SEL-SEC
                   IF  FLG-CHKSND      =    1
                       PERFORM 2003-KNS-TO-CHKSND-SEC
                   ELSE
                       PERFORM 2004-CHKSND-EXIST-HEN-SEC
                   END-IF
               END-IF
      *
               MOVE    "tbl_tekioubyomei"  TO   MCP-TABLE
               MOVE    "key2"              TO   MCP-PATHNAME
               PERFORM 910-DBCLOSECURSOR-SEC
      *
               PERFORM 900-SRYCD-READ-SEC
      *
           END-PERFORM
      *
           CLOSE   SRYCD-FILE
           .
       2002-SRYACT-TO-CHKSND-EXT.
           EXIT.
      *****************************************************************
      *    適応病名マスタからチェックマスタ２作成
      *****************************************************************
       2003-KNS-TO-CHKSND-SEC          SECTION.
      *
           MOVE    ZERO                TO  CNT-RENNUM
      *
           PERFORM UNTIL ( FLG-TEKBYO  NOT =   ZERO )
      *
               MOVE    ZERO        TO  FLG-HAISHI
      *
               INITIALIZE                      ORCSBYOMEIAREA
               MOVE    "1"                 TO  LNK-BYO-SYORI
               MOVE    TEKBYO-BYOMEI       TO  LNK-BYO-BYOMEI
               CALL    "ORCSBYOMEI"    USING   ORCSBYOMEIAREA
                                               SPA-AREA
               IF    ( LNK-BYO-BYOMEIHENFLG    =   SPACE ) 
                   IF    ( LNK-BYO-IKOSAKICD   NOT =   SPACE )
                       MOVE    SPACE       TO  WRK-TBYOMEICD-G
                       PERFORM VARYING IDX0 FROM 1 BY 1
                               UNTIL ( IDX0 >   CONST-MKCD-MAX )
                                OR   ( LNK-BYO-TBYOMEICD (IDX0)
                                            = SPACE )
                           MOVE    LNK-BYO-TBYOMEICD (IDX0)
                                           TO  WRK-TBYOMEICD (IDX0)
                       END-PERFORM
                       MOVE    LNK-BYO-IKOSAKICD   TO  WRK-IKOCD
                       MOVE    LNK-BYO-IKOSAKICD-INDEX
                                                   TO  IDXI
                       INITIALIZE              ORCSBYOMEIAREA
                       MOVE    "2"         TO  LNK-BYO-SYORI
                       PERFORM VARYING IDX0 FROM 1 BY 1
                               UNTIL ( IDX0 >   CONST-MKCD-MAX )
                                OR   ( WRK-TBYOMEICD (IDX0)    = SPACE )
                           MOVE WRK-TBYOMEICD (IDX0)
                                           TO  LNK-BYO-TBYOMEICD (IDX0)
                       END-PERFORM
                       MOVE    WRK-IKOCD   TO  LNK-BYO-TBYOMEICD (IDXI)
                       CALL    "ORCSBYOMEI"    USING   ORCSBYOMEIAREA
                                                       SPA-AREA
                   ELSE
                       IF    ( LNK-BYO-HAISIYMD-ERR  NOT   =   ZERO )
                           MOVE    1       TO  FLG-HAISHI
                       END-IF
                   END-IF
               END-IF
      *
               IF    ( FLG-HAISHI      =   ZERO )
      *
                   INITIALIZE              CHKSND-REC
      *
                   MOVE    WRK-PARA-HOSPNUM TO CHKSND-HOSPNUM
                   MOVE    "2"             TO  CHKSND-CHKKBN
                   MOVE    WRK-SRYCD       TO  CHKSND-SRYCD
                   MOVE    "00000000"      TO  CHKSND-YUKOSTYMD
                   MOVE    "99999999"      TO  CHKSND-YUKOEDYMD
                   MOVE    "1"             TO  CHKSND-CDKBN
                   COMPUTE CNT-RENNUM      =   CNT-RENNUM  +   1
                   MOVE    CNT-RENNUM      TO  CHKSND-RENNUM
      *
                   PERFORM 400-CD-KEY-SEC
                   MOVE    WRK-KEY-CD-G    TO  CHKSND-CD
      *
                   MOVE    LNK-BYO-BYOMEI  TO  CHKSND-BYOMEI
                   MOVE    "1"             TO  CHKSND-COMPKBN
                   MOVE    "1"             TO  CHKSND-UTAGAIKBN
                   MOVE    LNK-BYO-BYOMEIHENFLG
                                           TO  CHKSND-BYOMEIHENFLG
      *
                   MOVE    SMCNDATE-YMD    TO  CHKSND-CREYMD
                                               CHKSND-UPYMD
                   MOVE    SMCNDATE-HMS    TO  CHKSND-UPHMS
      *
                   MOVE    CHKSND-REC      TO  MCPDATA-REC
                   MOVE    "tbl_chksnd"    TO   MCP-TABLE
                   MOVE    "key"           TO   MCP-PATHNAME
                   PERFORM 910-DBINSERT-SEC
               END-IF
      *
               PERFORM 900-TEKIOUBYOMEI-KEY2-FET-SEC
      *
           END-PERFORM
      *
           IF    ( CNT-RENNUM          >   ZERO )
               COMPUTE CNT-SYORI       =   CNT-SYORI  +  1
           END-IF
      *
           .
      *
       2003-KNS-TO-CHKSND-EXT.
           EXIT.
      *****************************************************************
      *    処理経過編集処理
      *****************************************************************
       2004-SYORI-KEIKA-HEN-SEC        SECTION.
      *
           MOVE    ZERO                TO  WRK-SHO
                                           WRK-AMARI
           DIVIDE  50      INTO        CNT-SRYCD
                           GIVING      WRK-SHO
                           REMAINDER   WRK-AMARI
           END-DIVIDE
      *
           IF    ( WRK-AMARI           NOT =   ZERO )
               GO  TO  2004-SYORI-KEIKA-HEN-EXT
           END-IF
      *
           MOVE    CNT-SRYCD           TO  WRK-STR-LEFT-ZX99
           PERFORM 800-STR-HIDARIZUME-HEN-SEC
           MOVE    WRK-STR-LEFT        TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT       TO  WRK-KNS-N
           MOVE    SPACE               TO  WRK-MAE-INPUT
           MOVE    SMCNDATE-HMS(1:2)   TO  WRK-MAE-INPUT(1:2)
           MOVE    "."                 TO  WRK-MAE-INPUT(3:1)
           MOVE    SMCNDATE-HMS(3:2)   TO  WRK-MAE-INPUT(4:2)
           MOVE    "."                 TO  WRK-MAE-INPUT(6:1)
           MOVE    SMCNDATE-HMS(5:2)   TO  WRK-MAE-INPUT(7:2)
           MOVE    WRK-MAE-INPUT       TO  WRK-TIME-N
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
           MOVE    "ORCBCHKKNS1"       TO  JOB-PGID
           MOVE    WRK-TITLE           TO  JOB-SHELLMSG
      *
           MOVE    WRK-PARA-HOSPNUM    TO  JOB-HOSPNUM
           PERFORM 800-ORCSJOB-SEC
           .
       2004-SYORI-KEIKA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ヘッダ情報編集処理
      *****************************************************************
       2004-HEAD-HEN-SEC               SECTION.
      *
           COMPUTE CNT-PAGE            =   CNT-PAGE    +   1
      *
           MOVE    CNT-PAGE            TO  WRK-ZZZZ9
      *
           INITIALIZE                  HCMSL80
      *
           STRING
               "＊＊　適用病名情報更新確認リスト（検査：登録済）＊＊＊"
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
           MOVE    2                   TO  CNT-LINE
           .
       2004-HEAD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ既登録編集処理
      *****************************************************************
       2004-CHKSND-EXIST-HEN-SEC       SECTION.
      *
           MOVE    WRK-SRYCD           TO  WRK-TNS-SRYCD
           MOVE    SMCNDATE-YMD        TO  WRK-TNS-YMD
           PERFORM 2004-SRYNAME-HEN-SEC
           MOVE    WRK-MEMO            TO  HCMSL80-MOJI (CNT-LINE)
           PERFORM 2004-LINE-CNT-SEC
           .
       2004-CHKSND-EXIST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為名称編集処理
      *****************************************************************
       2004-SRYNAME-HEN-SEC            SECTION.
      *
           MOVE    "診療行為と病名："      TO  WRK-CHKKBNMEI
      *
           INITIALIZE                  WRK-MEMO
      *
           PERFORM 900-TENSU-KEY-SEL-SEC
      *
           IF      FLG-TENSU       NOT =   ZERO
                   MOVE    "00000000"  TO  WRK-TNS-YMD
                   PERFORM 900-TENSU-KEY-SEL-SEC
           END-IF
      *
           STRING  WRK-CHKKBNMEI   DELIMITED   BY  SPACE
                   WRK-TNS-SRYCD   DELIMITED   BY  SIZE
                   " "             DELIMITED   BY  SIZE
                   TNS-NAME        DELIMITED   BY  SPACE
                   " "             DELIMITED   BY  SIZE
                   TNS-YUKOSTYMD   DELIMITED   BY  SIZE
                   "-"             DELIMITED   BY  SIZE
                   TNS-YUKOEDYMD   DELIMITED   BY  SIZE
                   INTO    WRK-MEMO
           END-STRING
           .
       2004-SRYNAME-HEN-EXT.
           EXIT.
      *****************************************************************
      *    確認情報ファイル出力処理
      *****************************************************************
       2004-HCMSL80-OUT-SEC            SECTION.
      *
           IF    ( CNT-LINE            >   2 )
               WRITE   HCMSL80
           END-IF
      *
           CLOSE   HCMSL80-FILE
      *
           OPEN    INPUT               HCMSL80-FILE
      *
           MOVE    ZERO                TO  FLG-HCMSL80
      *
           PERFORM 900-HCMSL80-READ-SEC
      *
           PERFORM UNTIL ( FLG-HCMSL80 NOT =   ZERO )
      *
               PERFORM 2004-PRINT-SEC
      *
               PERFORM 900-HCMSL80-READ-SEC
      *
           END-PERFORM
      *
           CLOSE   HCMSL80-FILE
           .
       2004-HCMSL80-OUT-EXT.
           EXIT.
      *****************************************************************
      *    行カウント処理
      *****************************************************************
       2004-LINE-CNT-SEC                SECTION.
      *
           IF    ( CNT-LINE            >=   CONST-LINE-MAX )
               WRITE   HCMSL80
               PERFORM 2004-HEAD-HEN-SEC
           ELSE
               COMPUTE CNT-LINE        =   CNT-LINE    +   2
           END-IF
           .
       2004-LINE-CNT-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       2004-PRINT-SEC                  SECTION.
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
           MOVE    "適用病名情報更新確認リスト（検査）"
                                       TO  SPRT-TITLE
           MOVE    HCMSL80             TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
                                       SPA-AREA
           IF    ( SPRT-RETURN         =   ZERO )
               COMPUTE CNT-OUTPUT      =   CNT-OUTPUT  +   1
           ELSE
               DISPLAY "ORCSPRT ERR!!"
           END-IF
           .
       2004-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *    ファイル削除
           PERFORM 800-FILE-DEL-SEC
      *
           DISPLAY "CNT-SYORI =" CNT-SYORI
           IF    ( CNT-SYORI           =   ZERO )
               MOVE    "処理対象のデータがありませんでした"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           ELSE
               IF    ( CNT-OUTPUT      >   ZERO )
                   MOVE    "確認リストを確認してください"
                                       TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
               END-IF
           END-IF
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-OUTPUT      TO  JOB-UPDCNT
           MOVE    WRK-PARA-HOSPNUM    TO  JOB-HOSPNUM
           PERFORM 800-ORCSJOB-SEC
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    適用コード編集処理
      *****************************************************************
       400-CD-KEY-SEC                  SECTION.
      *
           INITIALIZE                  WRK-KEY-CD-G
      *
           PERFORM VARYING IDX0        FROM    1   BY  1
                   UNTIL ( IDX0        >  CONST-MKCD-MAX )
                    OR   ( LNK-BYO-TBYOMEICD (IDX0)    =   SPACE )
      *
               MOVE    LNK-BYO-TBYOMEICD (IDX0)
                                      TO  WRK-KEY-CD    (IDX0)
               IF    ( IDX0           >   1 )
                   MOVE    "-"        TO  WRK-KEY-CDSEP (IDX0 - 1)
               END-IF
      *
           END-PERFORM
           .
       400-CD-KEY-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC              SECTION.
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
               MOVE    WRK-PARA-HOSPNUM    TO  JOB-HOSPNUM
               PERFORM 800-ORCSJOB-SEC
           END-IF
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理サブ
      *****************************************************************
       800-ORCSJOB-SEC                 SECTION.
      *
           MOVE    WRK-PARA-HOSPNUM    TO  JOB-HOSPNUM
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA 
                                       JOBKANRI-REC
                                       SPA-AREA
      *
           .
      *
       800-ORCSJOB-EXT.
           EXIT.
      *****************************************************************
      *    全角変換処理
      *****************************************************************
       800-ZENKAKU-HEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-OUT-INPUT
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
           MOVE  WRK-MAE-INPUT         TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF    ( KANACHK-RC          =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                       TO  WRK-OUT-INPUT
               MOVE    KANACHK-MAX     TO  WRK-OUT-MAX
           END-IF
           .
       800-ZENKAKU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    文字列左詰処理
      *****************************************************************
       800-STR-HIDARIZUME-HEN-SEC      SECTION.
      *
           MOVE    WRK-STR-LEFT        TO  IDXE
           PERFORM VARYING IDXE        FROM    1   BY  1
                   UNTIL ( IDXE        >       500 )
      *
               IF    ( WRK-STR-LEFT (IDXE:1)
                                       NOT =   SPACE )
                   MOVE    WRK-STR-LEFT (IDXE:)
                                       TO  WRK-STR-LEFT-TMP
                   MOVE    WRK-STR-LEFT-TMP
                                       TO  WRK-STR-LEFT
                   MOVE    500         TO  IDXE
               END-IF
      *
           END-PERFORM
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
           MOVE    BCHKKNS101PARA  TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    BCHKKNS102PARA  TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
           .
       800-FILE-DEL-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC                 SECTION.
      *
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
           .
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    診療行為コードワークファイル読込み処理
      *****************************************************************
       900-SRYCD-READ-SEC              SECTION.
      *
           READ    SRYCD-FILE          NEXT
               AT  END
                   MOVE    1           TO  FLG-SRYCD
               NOT AT  END
                   MOVE    ZERO        TO  FLG-SRYCD
                   IF      SRYCD-FLG   NOT =   SPACE
                           GO          TO  900-SRYCD-READ-SEC
                   END-IF
                   COMPUTE CNT-SRYCD   =   CNT-SRYCD  +  1
           END-READ
           .
       900-SRYCD-READ-EXT.
           EXIT.
      *****************************************************************
      *    診療行為コードワークファイル読込み処理
      *****************************************************************
       900-SRYCD-KREAD-SEC             SECTION.
      *
           MOVE    WRK-SRYCD           TO  SRYCD-KEY
      *
           READ    SRYCD-FILE
               INVALID
                   MOVE    1           TO  FLG-SRYCD
               NOT INVALID
                   MOVE    ZERO        TO  FLG-SRYCD
           END-READ
           .
       900-SRYCD-KREAD-EXT.
           EXIT.
      *****************************************************************
      *    確認ファイルリスト読込み処理
      *****************************************************************
       900-HCMSL80-READ-SEC            SECTION.
      *
           READ    HCMSL80-FILE
               AT  END
                   MOVE    1           TO  FLG-HCMSL80
           END-READ
           .
       900-HCMSL80-READ-EXT.
           EXIT.
      *****************************************************************
      *    入力コード　抽出
      *****************************************************************
       900-ICD-ALL-SEL-SEC             SECTION.
      *
           INITIALIZE                  ICD-REC
           MOVE    ZERO                TO  FLG-INPUTCD
      *
           MOVE    WRK-PARA-HOSPNUM    TO  ICD-HOSPNUM
           MOVE    ICD-REC             TO  MCPDATA-REC
           MOVE    "tbl_inputcd"       TO  MCP-TABLE
           MOVE    "all"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  ICD-REC
           ELSE
               MOVE    1               TO  FLG-INPUTCD
           END-IF
           .
       900-ICD-ALL-SEL-EXT.
           EXIT.
      *****************************************************************
      *     入力コード　読み込み
      *****************************************************************
       900-ICD-ALL-FET-SEC             SECTION.
      *
           MOVE    "tbl_inputcd"       TO   MCP-TABLE
           MOVE    "all"               TO   MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  ICD-REC
           ELSE
               MOVE    1               TO  FLG-INPUTCD
           END-IF
           .
       900-ICD-ALL-FET-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタ　抽出
      *****************************************************************
       900-SRYACT-KEY13-SEL-SEC          SECTION.
      *
           INITIALIZE                  SRYACT-REC
           MOVE    ZERO                TO  FLG-SRYACT
           MOVE    "160000000"         TO  SRY-SRYCD (1)
           MOVE    "169999999"         TO  SRY-SRYCD (2)
      *
           MOVE    WRK-PARA-HOSPNUM    TO  SRY-HOSPNUM
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "tbl_sryact"        TO  MCP-TABLE
           MOVE    "key13"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACT
           END-IF
           .
       900-SRYACT-KEY13-SEL-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタ　読み込み
      *****************************************************************
       900-SRYACT-KEY13-FET-SEC          SECTION.
      *
           MOVE    "tbl_sryact"        TO   MCP-TABLE
           MOVE    "key13"             TO   MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACT
           END-IF
           .
       900-SRYACT-KEY13-FET-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２情報検索(KEY6)
      *****************************************************************
       900-CHKSND-KEY6-SEL-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-CHKSND
      *
           INITIALIZE                  CHKSND-REC
           MOVE    WRK-PARA-HOSPNUM    TO  CHKSND-HOSPNUM
           MOVE    "2"                 TO  CHKSND-CHKKBN
           MOVE    WRK-SRYCD           TO  CHKSND-SRYCD
           MOVE    CHKSND-REC          TO  MCPDATA-REC
           MOVE    "tbl_chksnd"        TO   MCP-TABLE
           MOVE    "key6"              TO   MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  CHKSND-REC
           ELSE
               INITIALIZE              CHKSND-REC
               MOVE    1               TO  FLG-CHKSND
           END-IF
      *
           MOVE    "tbl_chksnd"        TO   MCP-TABLE
           MOVE    "key6"              TO   MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-CHKSND-KEY6-SEL-EXT.
           EXIT.
      *****************************************************************
      *    適応病名マスタ情報検索(KEY2)
      *****************************************************************
       900-TEKIOUBYOMEI-KEY2-SEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-TEKBYO
      *
           INITIALIZE                  TEKIOUBYOMEI-REC
           MOVE    "2"                 TO  TEKBYO-CHKKBN
           MOVE    WRK-SRYCD           TO  TEKBYO-SRYCD
           MOVE    TEKIOUBYOMEI-REC    TO  MCPDATA-REC
           MOVE    "tbl_tekioubyomei"  TO   MCP-TABLE
           MOVE    "key2"              TO   MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  TEKIOUBYOMEI-REC
           ELSE
               INITIALIZE              TEKIOUBYOMEI-REC
               MOVE    1               TO  FLG-TEKBYO
           END-IF
           .
       900-TEKIOUBYOMEI-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    適応病名マスタ情報FETCH(KEY2)
      *****************************************************************
       900-TEKIOUBYOMEI-KEY2-FET-SEC       SECTION.
      *
           MOVE    "tbl_tekioubyomei"  TO   MCP-TABLE
           MOVE    "key2"              TO   MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  TEKIOUBYOMEI-REC
           ELSE
               INITIALIZE              TEKIOUBYOMEI-REC
               MOVE    1               TO  FLG-TEKBYO
           END-IF
           .
      *
       900-TEKIOUBYOMEI-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理(KEY)
      *****************************************************************
       900-TENSU-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    WRK-TNS-SRYCD       TO  TNS-SRYCD
           MOVE    WRK-TNS-YMD         TO  TNS-YUKOSTYMD
                                           TNS-YUKOEDYMD
           MOVE    WRK-PARA-HOSPNUM    TO  TNS-HOSPNUM
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO   MCP-TABLE
           MOVE    "key"               TO   MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               MOVE    1               TO  FLG-TENSU
               INITIALIZE              TNS-TENSU-REC
           END-IF
      *
           MOVE    "tbl_tensu"         TO   MCP-TABLE
           MOVE    "key"               TO   MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
           .
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF        ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                  SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       100-DBOPEN-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　切断処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       900-DBDISCONNECT-EXT.
           EXIT.

