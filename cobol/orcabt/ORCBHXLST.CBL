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
       PROGRAM-ID.             ORCBHXLST.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 随時帳票
      *  コンポーネント名  : チェクマスタ一覧表印刷（一括）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/08/08    NACL−多々納  新規作成
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
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    印刷用データ
           COPY    "HCP7LA.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-RECEERR             PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-PARA                PIC 9(01).
           03  FLG-TENSU               PIC 9(01).
           03  FLG-CHKMST              PIC 9(01).
           03  FLG-BYOMEI              PIC 9(01).
      *
      *
           03  FLG-OK              PIC 9(01).
           03  FLG-PRINT           PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE                PIC 9(03).
           03  CNT-PAGE                PIC 9(05).
           03  CNT-BZ001               PIC 9(05).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX-P               PIC 9(04).
           03  IDY                 PIC 9(04).
      *
           03  IDX2                PIC 9(04).
           03  IDX-MAX             PIC 9(04).
      *
           03  WRK-HEN-MAX         PIC 9(04).
      *
           03  WRK-DBPATH          PIC X(64).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY              PIC 9(02).
               05  SYS-MM              PIC 9(02).
               05  SYS-DD              PIC 9(02).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID          PIC 9(07).
           03  WRK-PARA-SHELLID        PIC X(08).
           03  WRK-PARA-HOSPID         PIC X(24).
           03  WRK-PARA-CHKKBN         PIC X(01).
           03  WRK-PARA-SRYCD          PIC X(09).
           03  WRK-PARA-SRYCD-END      PIC X(09).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR             PIC X(200).
      *
           03  WRK-SYSYMD.
               05  WRK-SYSYY           PIC 9(04).
               05  WRK-SYSMM           PIC 9(02).
               05  WRK-SYSDD           PIC 9(02).
           03  WRK-HENYMDG             PIC X(22).
      *
           03  WRK-PAGE            PIC 9(03).
           03  PCNT                PIC 9(03).
      *
           03  WRK-KEY-SRYCD       PIC  X(09).
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-SRYYMD          PIC X(08).
      *
           03  WRK-SRYCD           PIC X(09).
           03  WRK-BYOMEICD        PIC X(07).
      *
           03  WRK-NAME-G.
               05  WRK-NAME1       PIC X(04).
               05  WRK-NAME        PIC X(100).
      *
      *    印刷内容
       01  HEAD-01.
           03  FILLER                  PIC X(25)   VALUE   SPACE.
           03  H01-MIDASI              PIC X(80).
           03  FILLER                  PIC X(08)   VALUE   "作成日：".
           03  H01-YY                  PIC 9(04).
           03  FILLER                  PIC X(01)   VALUE   ".".
           03  H01-MM                  PIC Z9.
           03  FILLER                  PIC X(01)   VALUE   ".".
           03  H01-DD                  PIC Z9.
           03  FILLER                  PIC X(04)   VALUE   "  P-".
           03  H01-PCNT                PIC ZZ9.
       01  HEAD-02.
           03  FILLER                  PIC X(10)   VALUE   SPACE.
           03  H02-MIDASI1             PIC X(50).
           03  FILLER                  PIC X(01)   VALUE   SPACE.
           03  H02-MIDASI2             PIC X(50).
       01  BODY-01.
           03  B01-SRYCD1              PIC X(09).
           03  B01-YOBI1               PIC X(02).
           03  B01-NAME1               PIC X(50).
           03  FILLER                  PIC X(01).
           03  B01-SRYCD2              PIC X(09).
           03  B01-YOBI2               PIC X(02).
           03  B01-NAME2               PIC X(80).
      *
      *    内容
       01  WRK-HEN-AREA.
           03  WRK-TBL-REC             PIC X(131)   OCCURS  200.
      *
           03  WRK-PAGE-MAX            PIC 9(03).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報
           COPY    "CPSK1009.INC".
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    チェックマスタ−
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
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
      *
      *    全角変換
           COPY    "CPORCSKANACHK.INC".
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
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
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
           PERFORM 200-MAIN-SEC
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
           INITIALIZE                  SYS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
           MOVE    ZERO            TO  CNT-AREA
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
                                       WRK-PARA-CHKKBN
                                       WRK-PARA-SRYCD
                                       WRK-PARA-SRYCD-END
      *TEST
            DISPLAY " WRK-PARA-CHKKBN:"  WRK-PARA-CHKKBN
                   ",WRK-PARA-SRYCD:" WRK-PARA-SRYCD
                   ",WRK-PARA-SRYCD-END:" WRK-PARA-SRYCD-END
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBHXLST"         TO  JOB-PGID
           MOVE    "チェックマスタ一覧一括印刷"
                                       TO  JOB-SHELLMSG
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "RECEERR"       TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  RECEERR-TERMID
      *
      *    初期値セット
           PERFORM 110-SYOKI-SET-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期値セット
      *****************************************************************
       110-SYOKI-SET-SEC           SECTION.
      *
      *    システム日付セット
           INITIALIZE                  SPA-AREA
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  WRK-SYSYMD
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY1-AREA
           MOVE    "11"            TO  LNK-DAY1-IRAI
           MOVE    WRK-SYSYMD      TO  LNK-DAY1-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY1-AREA
           IF      STS-DAY-RC1         =   ZERO
               MOVE    LNK-DAY1-YMD (2:7)  TO  SPA-SYSYMDW
               MOVE    WRK-SYSYMD          TO  SPA-SYSYMD
           END-IF
      *
      *    発行日
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYSYMD      TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
      *
      *    ＳＰＡ設定
           MOVE    WRK-PARA-HOSPID     TO  SPA-HOSPID
      *
           .
       110-SYOKI-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM 2001-SYOKI-SYORI-SEC
      *
      *    編集印刷処理
           PERFORM 200-MEISAI-SYORI-SEC
                   UNTIL       FLG-END     =   1
      *
      *    印刷処理
           IF      IDX-P               >   ZERO
               PERFORM 400-PRINT-SYORI-SEC
           END-IF
      *
             .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期読込み　　処理
      *****************************************************************
       2001-SYOKI-SYORI-SEC                 SECTION.
      *
           MOVE    SPACE               TO  CHK-REC
           INITIALIZE                  CHK-REC
      *
           EVALUATE    WRK-PARA-CHKKBN
               WHEN    "1"
               WHEN    "2"
                   MOVE    "1"             TO  CHK-CDKBN
               WHEN    "3"
                   MOVE    "3"             TO  CHK-CDKBN
               WHEN    "4" 
               WHEN    "5"
                   MOVE    "2"             TO  CHK-CDKBN
               WHEN    OTHER
                   MOVE    1               TO  FLG-END
                   GO      TO      2001-SYOKI-SYORI-EXT
           END-EVALUATE
           MOVE    WRK-PARA-CHKKBN     TO  CHK-CHKKBN
           MOVE    WRK-PARA-SRYCD      TO  CHK-SRYCD
           IF     (WRK-PARA-SRYCD-END  =   SPACE  )  OR
                  (WRK-PARA-SRYCD      >   WRK-PARA-SRYCD-END)
               MOVE    WRK-PARA-SRYCD      TO  CHKUP-SRYCD
           ELSE
               MOVE    WRK-PARA-SRYCD-END  TO  CHKUP-SRYCD
           END-IF
           IF      WRK-PARA-SRYCD      =   SPACE
               MOVE    "CHK-KEY5"          TO  WRK-DBPATH
           ELSE
               MOVE    "CHK-KEY7"          TO  WRK-DBPATH
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHKMST
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-DBPATH          TO  ORC-DBPATH
               PERFORM 950-CHK-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-CHKMST
           END-IF
      *TEST
           DISPLAY "FLG-CKMST:" FLG-CHKMST
                   ",FLG-END:" FLG-END
      *
      *    初期クリア
           MOVE    ZERO                TO  IDX-P
           MOVE    SPACE               TO  HCP7LA
      *
           EVALUATE    WRK-PARA-CHKKBN
               WHEN    "1"
                   MOVE
               "＜　薬剤と病名一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "病名コード"
                                       TO  H02-MIDASI2
               WHEN    "2"
                   MOVE
               "＜　診療行為と病名一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "診療行為コード"
                                       TO  H02-MIDASI1
                   MOVE    "病名コード"
                                       TO  H02-MIDASI2
               WHEN    "3"
                   MOVE
               "＜　薬剤と禁忌一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "禁忌コード"
                                       TO  H02-MIDASI2
               WHEN    "4" 
                   MOVE
               "＜　薬剤と併用禁忌一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "適用薬剤コード"
                                       TO  H02-MIDASI2
               WHEN    "5"
                   MOVE
               "＜　同一月に併用算定できない診療行為一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "診療行為コード"
                                       TO  H02-MIDASI1
                   MOVE    "適用診療行為コード"
                                       TO  H02-MIDASI2
           END-EVALUATE
      *
           MOVE    SPA-SYSYMD(1:4)     TO  H01-YY
           MOVE    SPA-SYSYMD(5:2)     TO  H01-MM
           MOVE    SPA-SYSYMD(7:2)     TO  H01-DD
      *
             .
       2001-SYOKI-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    編集印刷処理
      *****************************************************************
       200-MEISAI-SYORI-SEC            SECTION.
      *
           INITIALIZE                  WRK-HEN-AREA
           MOVE    ZERO                TO  IDX
           MOVE    CHK-SRYCD           TO  WRK-KEY-SRYCD
      *    見出し編集
           MOVE    ZERO                TO  WRK-HEN-MAX
           PERFORM 2001-HEAD-HEN-SEC
      *
           PERFORM 2002-MEISAI-HEN-SEC
                   UNTIL     (FLG-END      =   1  )  OR
                             (CHK-SRYCD   NOT =   WRK-KEY-SRYCD)
      *
      *    最大行数のセット
           MOVE    48                  TO  IDX-MAX
      *
      *    編集処理
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   WRK-HEN-MAX
               IF      IDX-P               >=  IDX-MAX
      *            改ページ
                   PERFORM 400-PRINT-SYORI-SEC
                   MOVE    ZERO                TO  IDX-P
      *            見出し編集
                   ADD     1                   TO  PCNT
                   MOVE    PCNT                TO  H01-PCNT
                   ADD     1                   TO  IDX-P
                   MOVE    HEAD-01             TO  HCP7LA-MOJI  (IDX-P)
                   ADD     1                   TO  IDX-P
                   MOVE    HEAD-02             TO  HCP7LA-MOJI  (IDX-P)
                   ADD     1                   TO  IDX-P
                   MOVE    ALL "-"             TO  HCP7LA-MOJI  (IDX-P)
               END-IF
               ADD     1                   TO  IDX-P
               MOVE    WRK-TBL-REC (IDX)   TO  HCP7LA-MOJI  (IDX-P)
           END-PERFORM
      *
           ADD     1                   TO  IDX-P
           IF      IDX-P               <=  IDX-MAX
               MOVE    ALL "-"             TO  HCP7LA-MOJI  (IDX-P)
           END-IF
      *
           .
       200-MEISAI-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    見出し編集処理
      *****************************************************************
       2001-HEAD-HEN-SEC          SECTION.
      *
      *    見出し編集
           IF      IDX-P               =   ZERO
               ADD     1                   TO  PCNT
               MOVE    PCNT                TO  H01-PCNT
               ADD     1                   TO  WRK-HEN-MAX
               MOVE    HEAD-01             TO  WRK-TBL-REC (WRK-HEN-MAX)
               ADD     1                   TO  WRK-HEN-MAX
               MOVE    HEAD-02             TO  WRK-TBL-REC (WRK-HEN-MAX)
               ADD     1                   TO  WRK-HEN-MAX
               MOVE     ALL "-"            TO  WRK-TBL-REC (WRK-HEN-MAX)
           END-IF
      *
           MOVE    SPACE               TO  BODY-01
           MOVE    CHK-SRYCD           TO  B01-SRYCD1
           MOVE    CHK-SRYCD           TO  WRK-SRYCD
           PERFORM 20023-SRYCD-HEN-SEC
           MOVE    WRK-NAME-G          TO  B01-NAME1
      *
           .
       2001-HEAD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    内容編集処理
      *****************************************************************
       2002-MEISAI-HEN-SEC          SECTION.
      *
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL      (IDX     >   10     )   OR
                              (CHK-CD (IDX)   =   SPACE ) OR
                              (WRK-HEN-MAX    >=  200   )
               MOVE    CHK-CD (IDX)        TO  B01-SRYCD2
               EVALUATE    WRK-PARA-CHKKBN
                   WHEN    "1"
                   WHEN    "2"
      *                病名マスタ読み込み
                       MOVE    CHK-CD (IDX)        TO  WRK-BYOMEICD
                       PERFORM 20024-BYOMEI-HEN-SEC
                   WHEN    "3"
                       CONTINUE
                   WHEN    "4"
                   WHEN    "5"
      *                病名マスタ読み込み
                       MOVE    CHK-CD (IDX)        TO  WRK-SRYCD
                       PERFORM 20023-SRYCD-HEN-SEC
               END-EVALUATE
               MOVE    WRK-NAME-G          TO  B01-NAME2
      *
               INSPECT B01-YOBI1       REPLACING  ALL "  "  BY  "　"
               INSPECT B01-YOBI2       REPLACING  ALL "  "  BY  "　"
               INSPECT B01-NAME1       REPLACING  ALL "  "  BY  "　"
               INSPECT B01-NAME2       REPLACING  ALL "  "  BY  "　"
      *
               ADD     1                   TO  WRK-HEN-MAX
               MOVE    BODY-01             TO  WRK-TBL-REC (WRK-HEN-MAX)
               MOVE    SPACE               TO  BODY-01
           END-PERFORM
      *
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 950-CHK-READ-SEC
      *
           .
       2002-MEISAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *   診療コード処理
      *****************************************************************
       20023-SRYCD-HEN-SEC          SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    WRK-SRYCD           TO  TNS-SRYCD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               PERFORM 910-TENSU-READ-SEC
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    SPACE               TO  WRK-NAME-G
           MOVE    ZERO                TO  FLG-OK
           PERFORM UNTIL    (FLG-TENSU     =   1  )  OR
                            (FLG-OK        =   1  )
               MOVE    TNS-NAME            TO  WRK-NAME
               IF     (TNS-YUKOSTYMD       <=  SPA-SYSYMD )  AND
                      (TNS-YUKOEDYMD       >=  SPA-SYSYMD )
      *            診療日対象分
                   MOVE    1               TO  FLG-OK
               END-IF
               MOVE    "TENSU-KEY4"        TO  ORC-DBPATH
               PERFORM 910-TENSU-READ-SEC
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "削"            TO  WRK-NAME1
           END-IF
      *
           .
       20023-SRYCD-HEN-EXT.
           EXIT.
      *****************************************************************
      *   病名コード処理
      *****************************************************************
       20024-BYOMEI-HEN-SEC          SECTION.
      *
           INITIALIZE                   BYOMEI-REC
           MOVE    WRK-BYOMEICD        TO  BYO-BYOMEICD
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC 
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
               PERFORM 920-BYOMEI-READ-SEC
           ELSE
               INITIALIZE                  BYOMEI-REC
               MOVE    1                   TO  FLG-BYOMEI
           END-IF
           MOVE    BYO-BYOMEI          TO  WRK-NAME-G
      *
           .
       20024-BYOMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       400-PRINT-SYORI-SEC             SECTION.
      *
           ADD     1                   TO  CNT-PAGE
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
           MOVE    "HCP7LA"            TO  SPRT-PRTID
           MOVE    "チェックマスタ一覧表"
                                       TO  SPRT-TITLE
           MOVE    HCP7LA              TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"               USING
                                           ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *
           MOVE    ZERO                TO  IDX-P
           MOVE    SPACE               TO  HCP7LA
      *
           .
       400-PRINT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           IF      CNT-PAGE            =   ZERO
               MOVE    "処理対象のデータがありませんでした"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           DISPLAY "*** ORCBHXLST PAGE:" CNT-PAGE  " ***"
           DISPLAY "*** ORCBHXLST END ***"
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
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
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
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *
           MOVE    1                   TO  FLG-END     
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               MOVE    ZERO                TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *****************************************************************
      *    チェックデータ読込
      *****************************************************************
       950-CHK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  CHK-REC
               MOVE    ZERO                TO  FLG-CHKMST
               MOVE    ZERO                TO  FLG-END
           ELSE
               INITIALIZE                      CHK-REC
               MOVE    1                   TO  FLG-CHKMST
               MOVE    1                   TO  FLG-END
           END-IF
      *
           .
       950-CHK-READ-EXT.
           EXIT.
      *****************************************************************
      *    病名読込
      *****************************************************************
       920-BYOMEI-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  BYOMEI-REC
               MOVE    ZERO                TO  FLG-BYOMEI
           ELSE
               INITIALIZE                      BYOMEI-REC
               MOVE    1                   TO  FLG-BYOMEI
           END-IF
      *
           .
       920-BYOMEI-READ-EXT.
           EXIT.
      *
      *
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
