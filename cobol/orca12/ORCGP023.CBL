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
       PROGRAM-ID.             ORCGP023.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 紹介情報（Ｐ０２３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01/06/13  登録後、診療行為遷移を追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
      *    パラメタデータ
      *    SELECT  PARA-FILE       ASSIGN  FILE-NAME1
      *                            ORGANIZATION    IS  INDEXED
      *                            ACCESS  MODE    IS  DYNAMIC
      *                            RECORD  KEY     IS  PAR-KEY
      *                            FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *    パラメタデータ
      *FD  PARA-FILE.
      *01  PARA-REC.
      *    03  PAR-KEY.
      *        05  PAR-FILEMEI         PIC X(08).
      *        05  PAR-EDANUM          PIC 9(04).
      *    03  PAR-DATA-REC            PIC X(3000).
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    パラメタファイル名
       01  FILE-NAME1.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(07)   VALUE   "P01PARA".
           03  FILE-TERMID1        PIC X(32)   VALUE   SPACE.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    患者登録スパ領域
           COPY    "P02COMMON-SPA".
      *    患者画面スパ領域
           COPY    "P02SCR-SPA".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PARA            PIC 9(01).
           03  FLG-END             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
      *
           03  WRK-HENTIME.
               05  WRK-THH         PIC 99.
               05  FILLER          PIC X(01)   VALUE  ":".
               05  WRK-TMM         PIC 99.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
       01  LNK-SYKRRK-AREA.
         02  LNK-SYKRRK-REC          OCCURS   13.
             COPY  "CPSYKRRK.INC" REPLACING //SYK-// BY //LNK-SYK-//.
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   患者番号変換サブ
      *     COPY    "CPORCSPTID.INC".
      *   数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "P02.INC".
           COPY    "P02A.INC".
      *****COPY    "P02B.INC".
      *****COPY    "P02C.INC".
           COPY    "P02D.INC".
           COPY    "P02E.INC".
           COPY    "P02F.INC".
           COPY    "P014.INC".
           COPY    "P98.INC".
           COPY    "P981.INC".
           COPY    "P99.INC".
           COPY    "P0201.INC".
           COPY    "P982.INC".
           COPY    "P100.INC".
           COPY    "PERR.INC".
           COPY    "PID1.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-P02SCRAREA
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  SPA-FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"         ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
           IF      SPA-FLG-END         =   ZERO
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-P02SCRAREA  TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  SPA-P023-AREA
      *
      *    初期画面編集
           PERFORM 300-SCREEN-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    パラメタファイル検索処理
           PERFORM 320-PARAFILE-KENSAKU-SEC
      *
           MOVE    SPA-WORK        TO  SPA-P02KYOUTU
      *
      *    初期画面編集
           PERFORM 310-SPASET-SEC
      *
           .
       3OO-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタファイル検索処理
      *****************************************************************
       320-PARAFILE-KENSAKU-SEC             SECTION.
      *
      *    パラメタファイルより編集
      *    MOVE    ZERO                TO  FLG-PARA
      *    MOVE    SPA-TERMID          TO  FILE-TERMID1
      *    OPEN    INPUT                   PARA-FILE
      *    INITIALIZE                      PAR-KEY
      *    START   PARA-FILE
      *        KEY IS    >=   PAR-KEY
      *        INVALID
      *            MOVE    "1"         TO  FLG-PARA
      *        NOT INVALID
      *            PERFORM 990-PARA-NEXT-SEC
      *    END-START
      *
      *    MOVE    ZERO                TO  SPA-GMN23-MAX
      *    PERFORM    UNTIL   FLG-PARA        =   1
      *        EVALUATE    PAR-FILEMEI
      *            WHEN    "SYKRRK"
      *                ADD     1             TO  SPA-GMN23-MAX
      *                MOVE    PAR-DATA-REC  TO  LNK-SYKRRK-REC
      *                                              (SPA-GMN23-MAX)
      *        END-EVALUATE
      *
      *        PERFORM 990-PARA-NEXT-SEC
      *    END-PERFORM
      *****CLOSE                       PARA-FILE
      *
           .
       320-PARAFILE-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
      *     MOVE    LNK-PTINF-REC      TO  SPA-PTINF-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX      >    13  )
                     OR      ( IDX      >    SPA-GMN23-MAX )
             MOVE    LNK-SYK-SYKKBN (IDX)  TO  SPA-GMN23-SYKKBN (IDX)
             MOVE    LNK-SYK-SYKYMD (IDX)  TO  SPA-GMN23-SYKYMD (IDX)
             MOVE    LNK-SYK-SYKIRYID (IDX)
                                    TO  SPA-GMN23-SYKIRYID      (IDX)
             MOVE    LNK-SYK-SYKIRYNAME (IDX)
                                    TO  SPA-GMN23-SYKIRYNAME    (IDX)
             MOVE    LNK-SYK-SYKKA  (IDX)  TO  SPA-GMN23-SYKKA  (IDX)
      *       MOVE    LNK-SYK-DOCTOR (IDX)  TO  SPA-GMN23-DOCTOR (IDX)
             MOVE    LNK-SYK-SOAP   (IDX)  TO  SPA-GMN23-SOAP   (IDX)
      *
             MOVE    LNK-SYK-SYKYMD (IDX)  TO  WRK-SYMD
             PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
             MOVE    WRK-HENYMD     TO  SPA-GMN23-SYKYMDW       (IDX)
           END-PERFORM
           .
       31O-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
      *U     MOVE    SPACE               TO  P023
      *
      *    PERFORM   VARYING   IDX   FROM    1   BY  1
      *              UNTIL   ( IDX      >    13  )
      *              OR      ( IDX      >    SPA-GMN23-MAX )
      *U       MOVE    SPA-GMN23-SYKKBN (IDX)  TO  P023-SYKKBN (IDX)
      *U       MOVE    SPA-GMN23-SYKYMDW(IDX)  TO  P023-SYKYMDW(IDX)
      *U       MOVE    SPA-GMN23-SYKIRYID (IDX)
      *U                                     TO  P023-SYKIRYID   (IDX)
      *U       MOVE    SPA-GMN23-SYKIRYNAME (IDX)
      *U                                     TO  P023-SYKIRYNAME (IDX)
      *U       MOVE    SPA-GMN23-SYKKA  (IDX)  TO  P023-SYKKA  (IDX)
      *U*       MOVE    SPA-GMN23-DOCTOR (IDX)  TO  P023-DOCTOR (IDX)
      *U       MOVE    SPA-GMN23-SOAP   (IDX)  TO  P023-SOAP   (IDX)
      *    END-PERFORM
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    01
                   MOVE    "SELNUM"         TO  MCP-WIDGET
               WHEN    02
                   MOVE    "TSYKYMD"        TO  MCP-WIDGET
               WHEN    03
                   MOVE    "TSYKKBN"        TO  MCP-WIDGET
               WHEN    04
                   MOVE    "THOSPID"        TO  MCP-WIDGET
               WHEN    05
                   MOVE    "THOSPNAME"      TO  MCP-WIDGET
               WHEN    06
                   MOVE    "TSYKKA"         TO  MCP-WIDGET
               WHEN    07
                   MOVE    "TDOCTOR"        TO  MCP-WIDGET
               WHEN    08
                   MOVE    "TSOAP"          TO  MCP-WIDGET
               WHEN    09
                   MOVE    "B12"            TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    次画面（所得者画面）
               WHEN    "CLICKED"       ALSO    "B08"  
                   PERFORM 480-JIGAMEN-SEC
      *    確定
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 490-TOUROKU-SEC
      *    確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      **    紹介情報 更新
      *         WHEN    "CLICKED"       ALSO    "BH1"
      *             PERFORM 210-SYKUP-SEC
      **
      **    紹介情報 削除
      *         WHEN    "CLICKED"       ALSO    "BH2"
      *             PERFORM 220-SYKDEL-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    次画面（保険公費入力画面）へ
      *****************************************************************
       480-JIGAMEN-SEC             SECTION.
      *
      *
           .
       480-JIGAMEN-EXT.
           EXIT.
      *****************************************************************
      *    登録処理
      *****************************************************************
       490-TOUROKU-SEC             SECTION.
      *
      *
           .
       490-TOUROKU-EXT.
           EXIT.
      *****************************************************************
      *    紹介情報 更新処理
      *****************************************************************
       210-SYKUP-SEC            SECTION.
      *
           ADD     1            TO  SPA-GMN23-MAX
           .
      *
       210-SYKUP-EXT.
           EXIT.
      *
      *****************************************************************
      *    紹介情報 削除処理
      *****************************************************************
       220-SYKDEL-SEC            SECTION.
      *
           IF  SPA-GMN23-MAX       >   ZERO
               COMPUTE   SPA-GMN23-MAX    =   SPA-GMN23-MAX   -   1
           END-IF
           .
      *
       220-SYKDEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタへ保存処理
      *****************************************************************
       500-SPA-PARA-SEC              SECTION.
      *
           INITIALIZE                LNK-SYKRRK-AREA
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX      >    13  )
                     OR      ( IDX      >    SPA-GMN23-MAX )
      *
             MOVE    SPA-HOSPID              TO  LNK-SYK-HOSPID(IDX)
             MOVE    SPA-PTID                TO  LNK-SYK-PTID  (IDX)
             MOVE    SPA-GMN23-SYKKBN (IDX)  TO  LNK-SYK-SYKKBN(IDX)
             MOVE    SPA-GMN23-SYKYMD (IDX)  TO  LNK-SYK-SYKYMD(IDX)
             MOVE    SPA-GMN23-SYKIRYID (IDX)
                                         TO  LNK-SYK-SYKIRYID  (IDX)
             MOVE    SPA-GMN23-SYKIRYNAME (IDX)
                                         TO  LNK-SYK-SYKIRYNAME(IDX)
             MOVE    SPA-GMN23-SYKKA  (IDX)  TO  LNK-SYK-SYKKA (IDX)
             MOVE    SPA-GMN23-SOAP   (IDX)  TO  LNK-SYK-SOAP  (IDX)
             MOVE    SPA-TERMID              TO  LNK-SYK-TERMID(IDX)
             MOVE    SPA-OPID                TO  LNK-SYK-OPID  (IDX)
           END-PERFORM
      *
           .
       500-SPA-PARA-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       4902-KOSIN-SEC              SECTION.
      *
      *    パラメータデータ（紹介履歴のみ）削除
           PERFORM 4903-PARA-DEL-SEC
      *
      *    パラメータ出力処理
           PERFORM 4904-PARA-OUT-SEC
      *
           .
       4902-KOSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメータ  出力処理
      *****************************************************************
       4904-PARA-OUT-SEC                   SECTION.
      *
      **** MOVE    SPA-TERMID          TO  FILE-TERMID1
      *    OPEN    I-O                 PARA-FILE
      *    PERFORM   VARYING   IDX   FROM    1   BY  1
      *              UNTIL   ( IDX      >    13  )
      *              OR      ( IDX      >    SPA-GMN23-MAX )
      *        MOVE    SPACE                TO  PARA-REC
      *        INITIALIZE                       PARA-REC
      *
      *        MOVE    "SYKRRK"             TO  PAR-FILEMEI
      *        MOVE    IDX                  TO  PAR-EDANUM
      *        MOVE    LNK-SYKRRK-REC (IDX) TO  PAR-DATA-REC
      *        WRITE   PARA-REC
      *    END-PERFORM
      *****CLOSE     PARA-FILE
      *
           .
       4904-PARA-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメータデータ　削除（紹介履歴のみ）処理
      *****************************************************************
       4903-PARA-DEL-SEC                   SECTION.
      *
      **** MOVE    ZERO                TO  FLG-PARA
      *    MOVE    SPA-TERMID          TO  FILE-TERMID1
      *    OPEN    I-O                     PARA-FILE
      *    INITIALIZE                      PAR-KEY
      *    MOVE    "SYKRRK"            TO  PAR-FILEMEI
      *    START   PARA-FILE
      *        KEY IS    >=   PAR-KEY
      *        INVALID
      *            MOVE    "1"         TO  FLG-PARA
      *        NOT INVALID
      *            PERFORM 990-PARA-NEXT-SEC
      *    END-START
      *
      *    PERFORM    UNTIL ( FLG-PARA         =   1  )
      *               OR    ( PAR-FILEMEI  NOT =   "SYKRRK"   )
      *        DELETE  PARA-FILE               RECORD
      *        PERFORM 990-PARA-NEXT-SEC
      *    END-PERFORM
      *****CLOSE                       PARA-FILE
      *
           .
       4903-PARA-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    選択番号
           WHEN    "ACTIVATE"      ALSO    "SELNUM"
               PERFORM 4210-SELNUM-CHK-SEC
               MOVE    2           TO  SPA-GMN-CUR
      *    紹介年月日
           WHEN    "ACTIVATE"      ALSO    "TSYKYMD"
      *U         MOVE    P023-TSYKYMD    TO  SPA-GMN23-TSYKYMD
               MOVE    3               TO  SPA-GMN-CUR
      *    紹介元先区分
           WHEN    "ACTIVATE"      ALSO    "TSYKKBN"
      *U         MOVE    P023-TSYKKBN    TO  SPA-GMN23-TSYKKBN
               MOVE    4               TO  SPA-GMN-CUR
      *    医療機関番号
           WHEN    "ACTIVATE"      ALSO    "TSYKIRYID"
      *U         MOVE    P023-TSYKIRYID  TO  SPA-GMN23-TSYKIRYID
               MOVE    5               TO  SPA-GMN-CUR
      *    医療機関名称
           WHEN    "ACTIVATE"      ALSO    "TSYKIRYNAME"
      *U         MOVE    P023-TSYKIRYNAME    TO  SPA-GMN23-TSYKIRYNAME
               MOVE    6               TO  SPA-GMN-CUR
      *    紹介科
           WHEN    "ACTIVATE"      ALSO    "TSYKKA"
      *U         MOVE    P023-TSYKKA     TO  SPA-GMN23-TSYKKA
               MOVE    7               TO  SPA-GMN-CUR
      **    ドクター
      *     WHEN    "ACTIVATE"      ALSO    "TDOCTOR"
      *U*         MOVE    P023-TDOCTOR    TO  SPA-GMN23-TDOCTOR
      *         MOVE    8               TO  SPA-GMN-CUR
      *    ＳＯＡＰ
           WHEN    "ACTIVATE"      ALSO    "TSOAP"
      *U         MOVE    P023-TSOAP      TO  SPA-GMN23-TSOAP
               MOVE    9               TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号入力処理
      *****************************************************************
       4210-SELNUM-CHK-SEC             SECTION.
      *
      *U     MOVE    P023-SELNUM     TO  SPA-GMN-SELNUM
      *U     IF      P023-SELNUM     NOT =   SPACE
      *        INITIALIZE                      ORCSNUMAREA
      *        MOVE    SPA-GMN-SELNUM       TO  SNUM-INX
      *        CALL    "ORCSNUM"                USING
      *                                         ORCSNUMAREA
      *        IF     (SNUM-RC         NOT =   ZERO  )   OR
      *               (SNUM-MINKBN     NOT =   SPACE )   OR
      *               (SNUM-SYOKBN     NOT =   SPACE )
      *            MOVE    "0001"          TO  SPA-ERRCD
      *            GO      TO              4210-SELNUM-CHK-EXT
      *        ELSE
      *            MOVE    SNUM-OUTNUM     TO  SPA-NAI-SELNUM
      *        END-IF
      *        MOVE    2                   TO  SPA-GMN-CUR
      *U     END-IF
           .
       4210-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦→和暦FORMAT日付編集
      *****************************************************************
       410112-SE-WAFORMAT-YMDEDIT-SEC             SECTION.
      *
           MOVE    SPACE               TO  STS-AREA-DAY
           INITIALIZE                      STS-AREA-DAY
           MOVE    SPACE               TO  LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"    USING   STS-AREA-DAY  LNK-DAY2-AREA
           IF    STS-DAY-RC1            =   ZERO
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMD
           ELSE
               MOVE    SPACE               TO  WRK-HENYMD
           END-IF
           .
       410112-SE-WAFORMAT-YMDEDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRMSG-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラー"        TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "登録できません"    TO  SPA-ERRMSG
           END-EVALUATE
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *****************************************************************
      *    パラメタファイル検索処理
      *****************************************************************
      *980-PARA-READ-SEC             SECTION.
      *
      *    READ    PARA-FILE
      *        INVALID
      *            MOVE    1           TO  FLG-PARA
      *        NOT INVALID
      *            MOVE    ZERO        TO  FLG-PARA
      *    END-READ
      *
      *    .
      *980-PARA-READ-EXT.
      *    EXIT.
      *
      *****************************************************************
      *    パラメタデータ順読み
      *****************************************************************
      *990-PARA-NEXT-SEC           SECTION.
      *
      *    READ    PARA-FILE       NEXT
      *        AT  END
      *            MOVE    1           TO  FLG-PARA
      *        NOT AT  END
      *            MOVE    ZERO        TO  FLG-PARA
      *    END-READ
      *
      *    .
      *990-PARA-NEXT-EXT.
      *    EXIT.
      *
      ****************************************************************
      **    ＰＵＴ　処理
      ****************************************************************
      * 900-PUT-WINDOW              SECTION.
      **
      *     MOVE   "PUTWINDOW"       TO  MCP-FUNC.
      *     CALL   "MCPDCSUB"   USING
      *          MCPAREA.
      **
      *     .
      * 900-PUT-WINDOW-EXT.
      *     EXIT.
