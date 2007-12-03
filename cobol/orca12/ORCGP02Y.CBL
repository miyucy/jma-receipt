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
       PROGRAM-ID.             ORCGP02Y.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 患者禁忌薬剤登録画面（Ｐ０２Ｙ）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/12/03    NACL-多々納   新規作成
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
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    患者登録スパ領域
           COPY    "P02COMMON-SPA".
      *    患者画面スパ領域
           COPY    "P02SCR-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-INPUTCD         PIC 9(01).
           03  FLG-PTKINKI         PIC 9(01).
           03  FLG-SRYCDCHG        PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
           03  FLG-INPUT           PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-KANJI           PIC 9(01).
           03  FLG-TENSU-OK        PIC 9(01).
           03  FLG-CHNGARI         PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDK                 PIC 9(04).
           03  IDS                 PIC 9(04).
           03  IDX-TBL             PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PIDMSG              PIC X(100).
           03  WRK-SRYCD               PIC X(09).
           03  WRK-INPUTCD             PIC X(22).
           03  WRK-CD-MCNT             PIC 9(02).
           03  WRK-ICD-CDSYU           PIC X(01).
           03  WRK-CHNGCD              PIC X(09).
      *
           03  WRK-DATA                PIC X(100).
           03  WRK-MAX-CNT             PIC 9(03).
      *
           03  WRK-MCP-WIDGET          PIC X(64).
      *
           03  WRK-TIME.
               05  WRK-THH             PIC 9(02).
               05  WRK-TMM             PIC 9(02).
               05  WRK-TSS             PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-ZZZ             PIC ZZZ.
      *
           03  WRK-P02Y-ROW        PIC S9(09).
           03  FLG-GMN-INIT        PIC  9(01).
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
               05  WRK-THH-H       PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ":".
               05  WRK-TMM-H       PIC Z9.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者禁忌薬剤マスタ
       01  PTKINKI-REC.
           COPY    "CPPTKINKI.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    点数マスタ−
      *01  TNSWK-TENSU-REC.
           COPY    "CPTENSUWK.INC".
      *
      *    入力コードマスタ−
       01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *
      *    老人一般コード変換
       01  SRYCDCHG-REC.
           COPY    "CPSRYCDCHG.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *    検索文字追加
           COPY    "CPORCSADDSIGN.INC".
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
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
           COPY    "P015.INC".
           COPY    "P98.INC".
           COPY    "P981.INC".
      *****COPY    "P99.INC".
           COPY    "P0201.INC".
           COPY    "P982.INC".
           COPY    "P100.INC".
           COPY    "P02X.INC".
           COPY    "P02S.INC".
           COPY    "P02Q.INC".
           COPY    "P02Q1.INC".
           COPY    "P02Y.INC".
           COPY    "P02Y1.INC".
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-P02SCRAREA
           MOVE    SPA-WORK        TO  SPA-P02KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE
      *
      *    画面編集後、表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-P02KYOUTU     TO  SPA-WORK
           MOVE    SPA-AREA          TO  SPA-COMMON
           MOVE    SPA-P02SCRAREA    TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "PERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
      *
               IF      FLG-END             =   ZERO
      *            画面編集
                   PERFORM 500-GMNHEN-SEC
               END-IF
           END-IF
      *
           IF      FLG-END             =   ZERO
               MOVE    "NEW"               TO  MCP-PUTTYPE
               MOVE    "P02Y"              TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
               MOVE    1                   TO  FLG-END
           END-IF
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           EVALUATE    SPA-MOTOPG
      *        確認メッセージ
               WHEN    "PID1"
                   PERFORM 3001-PID1-SYORI-SEC
      *        検索画面より
               WHEN    "P02Y1"
                   PERFORM 3002-P02Y1-INIT-SEC
      *
               WHEN    OTHER
                   PERFORM 3000-SCREEN-INIT-SEC
           END-EVALUATE
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索一覧画面より
      *****************************************************************
       3002-P02Y1-INIT-SEC            SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   10
               IF      SPA-P02Y1-SRYCD (IDX)   NOT =   SPACE
                   MOVE    SPA-P02Y1-SRYCD (IDX)   TO  WRK-SRYCD
      *            患者禁忌薬剤登録処理
                   PERFORM 4121-PTKINKI-INS-SEC
               END-IF
           END-PERFORM
      *
           MOVE    SPACE               TO  SPA-ERRCD
           PERFORM 3000-SCREEN-INIT-SEC
      *
           .
       3002-P02Y1-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期編集処理
      *****************************************************************
       3000-SCREEN-INIT-SEC            SECTION.
      *
      *
           INITIALIZE                      SPA-P02Y-AREA
      *
      *    禁忌薬剤編集
           MOVE    1                   TO  SPA-P02Y-PAGE
           PERFORM 3001-PTKINKI-HENSYU-SEC
           IF      SPA-P02Y-MAX        =   ZERO
               MOVE    2                   TO  SPA-P02Y-CUR
           ELSE
               MOVE    1                   TO  SPA-P02Y-CUR
           END-IF
           .
       3000-SCREEN-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    禁忌薬剤編集処理
      *****************************************************************
       3001-PTKINKI-HENSYU-SEC              SECTION.
      *
           MOVE    1                   TO  FLG-GMN-INIT
           MOVE    ZERO                TO  SPA-P02Y-MAX
           MOVE    ZERO                TO  SPA-P02Y-NEXT
           INITIALIZE                      SPA-P02Y-KINKILIST
      *
           INITIALIZE                      PTKINKI-REC
           MOVE    SPA-HOSPNUM         TO  PTKINKI-HOSPNUM
           MOVE    SPA-GMN-PTID        TO  PTKINKI-PTID
           MOVE    PTKINKI-REC         TO  MCPDATA-REC
           MOVE    "tbl_ptkinki"       TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptkinki"       TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-PTKINKI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTKINKI
               INITIALIZE                      PTKINKI-REC
           END-IF
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDY
           COMPUTE IDS                 =  (SPA-P02Y-PAGE   -  1  )
                                       *   100
                                       +   1
           PERFORM UNTIL  ( FLG-PTKINKI    =   1  )
                   OR     ( IDX            >=  100)
               ADD    1                    TO  IDY
               IF     IDY                  >=  IDS
                   PERFORM 30011-PTKINKI-HEN-SEC
               END-IF
      *
               MOVE    "tbl_ptkinki"       TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-PTKINKI-READ-SEC
           END-PERFORM
           IF     (IDX                 >=  100 )  AND
                  (FLG-PTKINKI         =   ZERO)
               MOVE    1                   TO  SPA-P02Y-NEXT
           END-IF
           MOVE    IDX                 TO  SPA-P02Y-MAX
      *
           MOVE    "tbl_ptkinki"       TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       3001-PTKINKI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    一覧表編集処理
      *****************************************************************
       30011-PTKINKI-HEN-SEC              SECTION.
      *
           ADD     1                   TO  IDX
           MOVE    IDX                 TO  SPA-P02Y-TNUM (IDX)
           MOVE    PTKINKI-SRYCD       TO  SPA-P02Y-TSRYCD(IDX)
      *    点数マスタ検索
           MOVE    PTKINKI-SRYCD       TO  WRK-SRYCD
           PERFORM 910-TENSU-READ-SEC
           IF      FLG-TENSU-OK        =   1
               MOVE    TNS-NAME            TO  SPA-P02Y-TNAME (IDX)
               MOVE    TNS-KANANAME        TO  SPA-P02Y-TKANANAME (IDX)
               MOVE    TNS-YUKOEDYMD       TO  SPA-P02Y-TYUKOEDYMDS(IDX)
               MOVE    TNS-YUKOEDYMD       TO  WRK-SYMD
               PERFORM 800-SE-WAFORMAT-YMDEDIT-SEC
               MOVE    WRK-HENYMD          TO  SPA-P02Y-TYUKOEDYMD(IDX)
      *        経過措置コード
               PERFORM 30011-SRYCDCHG-HEN-SEC
               MOVE    WRK-CHNGCD          TO  SPA-P02Y-TCHNGECD (IDX)
               MOVE    FLG-CHNGARI         TO  SPA-P02Y-TCHNGFLG (IDX)
      *        入力ＣＤ
               MOVE    PTKINKI-SRYCD       TO  WRK-SRYCD
               PERFORM 400211-INPUTCD-HEN-SEC
               MOVE    ICD-INPUTCD         TO  SPA-P02Y-TINPUTCD(IDX)
           END-IF
           .
       30011-PTKINKI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    経過措置コード処理
      *****************************************************************
       30011-SRYCDCHG-HEN-SEC          SECTION.
      *
           INITIALIZE                  SRYCDCHG-REC 
           MOVE    WRK-SRYCD           TO  CHG-IPNSRYCD
           MOVE    SPA-HOSPNUM         TO  CHG-HOSPNUM
      *
           MOVE    SRYCDCHG-REC        TO  MCPDATA-REC
           MOVE    "tbl_srycdchg"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_srycdchg"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 990-SRYCDCHG-READ-SEC
           ELSE
               INITIALIZE                  SRYCDCHG-REC
               MOVE    1               TO  FLG-SRYCDCHG
           END-IF
           MOVE    "tbl_srycdchg"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           MOVE    SPACE               TO  WRK-CHNGCD
           MOVE    ZERO                TO  FLG-CHNGARI
           IF      FLG-SRYCDCHG        =   ZERO
               MOVE    CHG-RJNSRYCD        TO  WRK-CHNGCD
      *        登録の有無判定
               INITIALIZE                      PTKINKI-REC
               MOVE    SPA-HOSPNUM         TO  PTKINKI-HOSPNUM
               MOVE    SPA-GMN-PTID        TO  PTKINKI-PTID
               MOVE    CHG-RJNSRYCD        TO  PTKINKI-SRYCD
               MOVE    PTKINKI-REC         TO  MCPDATA-REC
               MOVE    "tbl_ptkinki"       TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 910-DBSELECT-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    "tbl_ptkinki"       TO  MCP-TABLE
                   MOVE    "key"               TO  MCP-PATHNAME
                   PERFORM 900-PTKINKI-READ-SEC
               ELSE
                   MOVE    1                   TO  FLG-PTKINKI
                   INITIALIZE                      PTKINKI-REC
               END-IF
               MOVE    "tbl_ptkinki"       TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 990-DBCLOSE-SEC
               IF      FLG-PTKINKI         =   ZERO
                   MOVE    1                   TO  FLG-CHNGARI
               ELSE
                   MOVE    ZERO                TO  FLG-CHNGARI
               END-IF
           END-IF
           .
       30011-SRYCDCHG-HEN-EXT.
           EXIT.
      *****************************************************************
      *    入力ＣＤ処理
      *****************************************************************
       400211-INPUTCD-HEN-SEC          SECTION.
      *
           INITIALIZE                  INPUTCD-REC
           MOVE    SPACE               TO  INPUTCD-REC
           MOVE    SPA-HOSPNUM         TO  ICD-HOSPNUM
           MOVE    WRK-SRYCD           TO  ICD-SRYCD
      *
           MOVE    INPUTCD-REC         TO  MCPDATA-REC
           MOVE    "tbl_inputcd"       TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_inputcd"       TO  MCP-TABLE
               MOVE    "key4"              TO  MCP-PATHNAME
               PERFORM 930-INPUTCD-READ-SEC
           ELSE
               MOVE    1               TO  FLG-INPUTCD
               INITIALIZE                  INPUTCD-REC
           END-IF
           MOVE    "tbl_inputcd"       TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       400211-INPUTCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面より処理
      *****************************************************************
       3001-PID1-SYORI-SEC              SECTION.
      *
           EVALUATE    SPA-PIDCD
               WHEN    "0101"
      *            削除
                   IF      SPA-PID1-FLG        =   "OK"
                       PERFORM 4031-DELETE-SEC
                   END-IF
           END-EVALUATE
      *
           MOVE    SPACE               TO  SPA-PIDCD
      *
           .
       3001-PID1-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           IF     (FLG-GMN-INIT        =   1   )  OR
                  (SPA-P02Y-MAX        =   ZERO )
               MOVE    ZERO                TO  WRK-P02Y-ROW
           ELSE
               MOVE    P02Y-ROW            TO  WRK-P02Y-ROW
           END-IF
      *
           MOVE    SPACE               TO  P02Y
           INITIALIZE                      P02Y
      *    コラムリストの位置指定
           IF      WRK-P02Y-ROW    NOT =   ZERO
               MOVE    WRK-P02Y-ROW        TO  P02Y-ROW
           END-IF
      *
           PERFORM   VARYING    IDX   FROM    1   BY  1
                     UNTIL      IDX      >    SPA-P02Y-MAX
               MOVE    SPA-P02Y-TNUM   (IDX)   TO  WRK-ZZZ
               MOVE    WRK-ZZZ                 TO  P02Y-TNUM  (IDX)
               MOVE    SPA-P02Y-TSRYCD (IDX)   TO  P02Y-TSRYCD (IDX)
               MOVE    SPA-P02Y-TINPUTCD(IDX)  TO  P02Y-TINPCD (IDX)
               MOVE    SPA-P02Y-TNAME  (IDX)
                                               TO  P02Y-TNAME (IDX)
               MOVE    SPA-P02Y-TYUKOEDYMD (IDX)
                                               TO  P02Y-TYUKOEDYMD (IDX)
               IF      SPA-P02Y-TCHNGFLG (IDX) =   "1"
                   CONTINUE
               ELSE
                   MOVE    SPA-P02Y-TCHNGECD (IDX)
                                               TO  P02Y-TCHNGCD (IDX)
               END-IF
               IF      SPA-P02Y-TNUM (IDX)     =   SPA-P02Y-SELNUM
                   MOVE    "T"                 TO  P02Y-SELECT (IDX)
                   MOVE    IDX                 TO  P02Y-ROW
               ELSE
                   MOVE    "F"                 TO  P02Y-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-P02Y-MAX        TO  P02Y-COUNT
      *
           MOVE    SPA-P02Y-SELNUM     TO  P02Y-SELNUM
           MOVE    SPA-P02Y-SRYCD      TO  P02Y-SRYCD
           MOVE    SPA-P02Y-SRYCDMEI   TO  P02Y-SRYMEI
           MOVE    SPA-P02Y-KIKAN      TO  P02Y-YUKOKIKAN
           MOVE    SPA-P02Y-KEIKAMSG   TO  P02Y-KEIKAMSG
           MOVE    SPA-P02Y-INPUTCD    TO  P02Y-INPUTCDMSG
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
           IF      SPA-P02Y-CUR        =   ZERO
               EVALUATE    WRK-MCP-WIDGET
                   WHEN    "SELNUM"
                       MOVE    93           TO  SPA-P02Y-CUR
                   WHEN    "SRYCD"
                       MOVE    99           TO  SPA-P02Y-CUR
                   WHEN    OTHER
                       MOVE    1            TO  SPA-P02Y-CUR
               END-EVALUATE
           END-IF
      *
           EVALUATE    SPA-P02Y-CUR
               WHEN    01
                   MOVE    "SELNUM"    TO  MCP-WIDGET
               WHEN    02
                   MOVE    "SRYCD"     TO  MCP-WIDGET
               WHEN    93
                   MOVE    "B03"       TO  MCP-WIDGET
               WHEN    99
                   MOVE    "B12"       TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *    クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 402-CLEAR-SEC
      *    削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 403-DELETE-SYORI-SEC
      *    前頁
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 405-ZENPAGE-SEC
      *    次頁
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 406-NEXTPAGE-SEC
      *    検索
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 408-P02Y1-SYORI-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 412-TOUROKU-SYORI-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-P02Y-CUR
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        選択番号
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 4001-SELNUM-CHK-SEC
      *        リスト選択
               WHEN    ANY             ALSO    "PTKINKILST"
                   PERFORM 4001-KINKLIST-SEL-SEC
               WHEN    OTHER
      *            入力チェック処理
                   PERFORM 410-INPUT-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    一覧表選択処理
      *****************************************************************
       4001-KINKLIST-SEL-SEC          SECTION.
      *
      *    行選択
           MOVE    ZERO                TO  SPA-P02Y-SELNUM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-P02Y-MAX
               IF      P02Y-SELECT (IDX)   =   "T"
                   MOVE    SPA-P02Y-TNUM (IDX)
                                           TO  SPA-P02Y-SELNUM
               END-IF
           END-PERFORM
      *
           IF      SPA-P02Y-SELNUM    NOT =   ZERO
               MOVE    SPA-P02Y-SELNUM        TO  P02Y-SELNUM
               PERFORM 4001-SELNUM-CHK-SEC
           END-IF
      *
           .
       4001-KINKLIST-SEL-EXT.
           EXIT.
      *****************************************************************
      *    選択番号処理
      *****************************************************************
       4001-SELNUM-CHK-SEC                 SECTION.
      *
           MOVE    1                   TO  SPA-P02Y-CUR
           INITIALIZE                  SPA-P02Y-INPUT-G
           MOVE    P02Y-SELNUM         TO  SPA-P02Y-SELNUM
      *
           MOVE    ZERO                TO  IDX-TBL
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-P02Y-MAX
               IF      SPA-P02Y-TNUM (IDX) =   SPA-P02Y-SELNUM
                   MOVE    IDX             TO  IDX-TBL
                   MOVE    SPA-P02Y-MAX    TO  IDX
               END-IF
           END-PERFORM
           MOVE    ZERO                TO  SPA-P02Y-IDX
           IF      SPA-P02Y-SELNUM     =   ZERO
               MOVE    2                   TO  SPA-P02Y-CUR
           ELSE
               IF      IDX-TBL             =   ZERO
                   MOVE    "0001"              TO  SPA-ERRCD
               ELSE
                   MOVE    SPA-P02Y-TSRYCD (IDX-TBL)
                                               TO  SPA-P02Y-SRYCD
                   MOVE    SPA-P02Y-SRYCD      TO  P02Y-SRYCD
                   MOVE    IDX-TBL             TO  SPA-P02Y-IDX
                   PERFORM 4002-SRYCD-CHK-SEC
               END-IF
           END-IF
           .
       4001-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           PERFORM 4002-SRYCD-CHK-SEC
           .
      *
       410-INPUT-CHK-EXT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC          SECTION.
      *
           MOVE    P02Y-SRYCD         TO  SPA-P02Y-SRYCD
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    薬剤コード処理
      *****************************************************************
       4002-SRYCD-CHK-SEC                 SECTION.
      *
           IF     (SPA-P02Y-SRYCD      =   SPA-P02Y-MAE-SRYCD)
             OR   (SPA-P02Y-SRYCD      =   SPACE             )
               MOVE    SPA-P02Y-SRYCD      TO  SPA-P02Y-MAE-SRYCD
               GO      TO      4002-SRYCD-CHK-EXT
           END-IF
      *
           MOVE    2                   TO  SPA-P02Y-CUR
           INITIALIZE                  SPA-P02Y-INPUT-G
      *    全角入力の時、４文字まで
           MOVE    P02Y-SRYCD          TO  WRK-DATA
           MOVE    9                   TO  WRK-MAX-CNT
           PERFORM 810-ORCSKANACHK-SEC
           MOVE    WRK-DATA            TO  SPA-P02Y-SRYCD
      *
           IF     (SPA-P02Y-SRYCD      =   SPACE             )
               MOVE    SPA-P02Y-SRYCD      TO  SPA-P02Y-MAE-SRYCD
               GO      TO      4002-SRYCD-CHK-EXT
           END-IF
      *
      *    "//" 入力の時、検索画面へ
           IF      SPA-P02Y-SRYCD(1:2)  =  "//"
               MOVE    SPACE               TO  WRK-INPUTCD
               PERFORM 408-P02Y1-SYORI-SEC
           ELSE
      *        入力コードチェック
               MOVE    SPA-P02Y-SRYCD      TO  WRK-INPUTCD
               PERFORM 40021-SRYCD-INCHK-SEC
           END-IF
           IF     (FLG-END             =   ZERO  )  AND
                  (SPA-ERRCD           =   SPACE )
               IF      SPA-P02Y-SRYCD(1:1)     =   "6"
                   CONTINUE
               ELSE
                   MOVE    "0007"              TO  SPA-ERRCD
               END-IF
           END-IF
           IF     (FLG-END             =   ZERO  )  AND
                  (SPA-ERRCD           =   SPACE )
      *        薬剤コード編集
               PERFORM 40021-SRYCD-HEN-SEC
           END-IF
           IF     (FLG-END             =   ZERO  )  AND
                  (SPA-ERRCD           =   SPACE )
               MOVE    SPA-P02Y-SRYCD      TO  SPA-P02Y-MAE-SRYCD
               IF      SPA-P02Y-SELNUM     =   ZERO
                   MOVE    99                  TO  SPA-P02Y-CUR
               ELSE
                   MOVE    93                  TO  SPA-P02Y-CUR
               END-IF
           END-IF
           .
       4002-SRYCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *  　入力コードチェック処理
      *****************************************************************
       40021-SRYCD-INCHK-SEC            SECTION.
      *
           MOVE    ZERO               TO  WRK-CD-MCNT
           MOVE    ZERO               TO  FLG-KANJI
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-INPUTCD         TO  KANACHK-MAE-INPUT
           MOVE    9                   TO  KANACHK-MAX-CNT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           MOVE    KANACHK-MAE-INPUT   TO  WRK-INPUTCD
           IF      KANACHK-RC      NOT =   ZERO
      *        全角半角混在エラー
               MOVE    "0003"              TO  SPA-ERRCD
           ELSE
               MOVE    KANACHK-MAX         TO  WRK-CD-MCNT
      *        全角
               IF      KANACHK-SYUBETU     =   2
                   MOVE    1               TO  FLG-KANJI
               ELSE
                   MOVE    ZERO            TO  FLG-KANJI
               END-IF
           END-IF
           IF      SPA-ERRCD           =   SPACE
      *    半角で９文字の時、点数マスタチェックへ
               IF     (WRK-CD-MCNT         =   9    )  AND
                      (FLG-KANJI           =   ZERO )  AND
                      (WRK-INPUTCD         NUMERIC  )
                   CONTINUE
               ELSE
                   PERFORM 400211-INPUTCD-CHK-SEC
                   IF     (FLG-INPUT       =   ZERO ) AND
                          (SPA-ERRCD       =   SPACE )
      *                入力コード検索
                       PERFORM 408-P02Y1-SYORI-SEC
                   END-IF
               END-IF
           END-IF
           .
       40021-SRYCD-INCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力ＣＤ処理
      *****************************************************************
       400211-INPUTCD-CHK-SEC                 SECTION.
      *
           MOVE    ZERO                TO  FLG-INPUT
           MOVE    SPACE               TO  WRK-ICD-CDSYU
           IF      FLG-KANJI           =   1
      *        全角のコードチェック
               MOVE    "J"             TO  WRK-ICD-CDSYU
           ELSE
      *        診療コードチェック
               IF      WRK-INPUTCD(1:1)        =   "P"  OR  "S"
                   MOVE    "0003"              TO  SPA-ERRCD
               ELSE
                   IF     (WRK-CD-MCNT     >   1   AND  <=  9 )  AND
                          (WRK-INPUTCD(1:WRK-CD-MCNT)   NUMERIC    )
                       EVALUATE    WRK-CD-MCNT
                           WHEN    9
      *                    診療行為コード入力
                               MOVE    1           TO  FLG-INPUT
      *                    短縮３桁
                           WHEN    3
                               MOVE    "6"         TO  WRK-ICD-CDSYU
      *                    ４桁
                           WHEN    4
                               MOVE    "4"         TO  WRK-ICD-CDSYU
      *                    ５桁
                           WHEN    5
                               MOVE    "5"         TO  WRK-ICD-CDSYU
      *                    ６桁
                           WHEN    6
                               MOVE    "6"         TO  WRK-ICD-CDSYU
      *
                           WHEN    OTHER
                               MOVE    "A"         TO  WRK-ICD-CDSYU
                       END-EVALUATE
                   ELSE
                       MOVE    "A"         TO  WRK-ICD-CDSYU
                   END-IF
               END-IF
           END-IF
      *
           IF      WRK-ICD-CDSYU   NOT =   SPACE
               PERFORM 4002110-INPUTCD-HEN-SEC
           END-IF
           .
       400211-INPUTCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入力コード処理
      *****************************************************************
       4002110-INPUTCD-HEN-SEC                 SECTION.
      *
           INITIALIZE                  INPUTCD-REC
           MOVE    SPACE               TO  INPUTCD-REC
           MOVE    SPA-HOSPNUM         TO  ICD-HOSPNUM
           MOVE    WRK-ICD-CDSYU       TO  ICD-CDSYU
           MOVE    WRK-INPUTCD         TO  ICD-INPUTCD
           COMPUTE IDK                 =   WRK-CD-MCNT  +  1
           MOVE    "%"                 TO  ICD-INPUTCD(IDK:1)
      *
           MOVE    INPUTCD-REC         TO  MCPDATA-REC
           MOVE    "tbl_inputcd"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               PERFORM 930-INPUTCD-READ-SEC
           ELSE
               MOVE    1               TO  FLG-INPUTCD
           END-IF
           IF     (FLG-INPUTCD         =   ZERO  )  AND
                  (WRK-INPUTCD         =   ICD-INPUTCD )
      *        点数コード決定
               MOVE    ICD-SRYCD           TO  SPA-P02Y-SRYCD
               MOVE    1                   TO  FLG-INPUT
           END-IF
           MOVE    "tbl_inputcd"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       4002110-INPUTCD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    薬剤コード処理
      *****************************************************************
       40021-SRYCD-HEN-SEC                 SECTION.
      *
      *    点数マスタ検索
           MOVE    SPA-P02Y-SRYCD      TO  WRK-SRYCD
           PERFORM 910-TENSU-READ-SEC
           IF      FLG-TENSU-OK        =   1
               MOVE    TNS-NAME            TO  SPA-P02Y-SRYCDMEI
               MOVE    TNS-YUKOEDYMD       TO  WRK-SYMD
               PERFORM 800-SE-WAFORMAT-YMDEDIT-SEC
               STRING  "有効終了日："
                       WRK-HENYMD      DELIMITED  BY  SIZE
                                       INTO    SPA-P02Y-KIKAN
               END-STRING
      *        経過措置コード
               PERFORM 30011-SRYCDCHG-HEN-SEC
               IF     (WRK-CHNGCD      NOT =   SPACE ) AND
                      (FLG-CHNGARI         =   ZERO  )
                   MOVE    WRK-CHNGCD          TO  WRK-SRYCD
                   PERFORM 910-TENSU-READ-SEC
                   MOVE    SPACE               TO  WRK-DATA
                   STRING  "品目移行コード："
                            WRK-CHNGCD     DELIMITED  BY  SPACE
                            "　"           DELIMITED  BY  SIZE
                            TNS-NAME       DELIMITED  BY  SPACE
                                           INTO    WRK-DATA
                   END-STRING
                   MOVE    56                  TO  WRK-MAX-CNT
                   PERFORM 810-ORCSKANACHK-SEC
                   MOVE    WRK-DATA            TO  SPA-P02Y-KEIKAMSG
               END-IF
      *        入力コード
               MOVE    SPA-P02Y-SRYCD      TO  WRK-SRYCD
               PERFORM 400211-INPUTCD-HEN-SEC
               MOVE    SPACE               TO  WRK-DATA
               IF      ICD-INPUTCD     NOT =   SPACE
                   STRING  "入力ＣＤ："
                           ICD-INPUTCD         DELIMITED  BY  SPACE
                                               INTO  WRK-DATA
                   END-STRING
                   MOVE    21                  TO  WRK-MAX-CNT
                   PERFORM 810-ORCSKANACHK-SEC
               END-IF
               MOVE    WRK-DATA            TO  SPA-P02Y-INPUTCD
           ELSE
               MOVE    "0004"          TO  SPA-ERRCD
               MOVE    2               TO  SPA-P02Y-CUR
           END-IF
           .
       40021-SRYCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア処理
      *****************************************************************
       402-CLEAR-SEC             SECTION.
      *
           MOVE    ZERO                TO  SPA-P02Y-SELNUM
           MOVE    ZERO                TO  SPA-P02Y-IDX
           INITIALIZE                      SPA-P02Y-INPUT-G
           MOVE    1                   TO  SPA-P02Y-CUR
           .
      *
       402-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理
      *****************************************************************
       403-DELETE-SYORI-SEC             SECTION.
      *
           IF     (SPA-P02Y-SELNUM     =   ZERO )  OR
                  (SPA-P02Y-SELNUM     >   SPA-P02Y-MAX)  OR
                  (SPA-P02Y-IDX        =   ZERO  )
               MOVE    "0001"              TO  SPA-ERRCD
           ELSE
               IF     (SPA-P02Y-SRYCD      =   SPA-P02Y-TSRYCD
                                                     (SPA-P02Y-IDX))
                   MOVE    "0101"              TO  SPA-PIDCD
               ELSE
                   MOVE    "0002"              TO  SPA-ERRCD
               END-IF
           END-IF
           .
       403-DELETE-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理
      *****************************************************************
       4031-DELETE-SEC             SECTION.
      *
           INITIALIZE                      PTKINKI-REC
           MOVE    SPA-HOSPNUM         TO  PTKINKI-HOSPNUM
           MOVE    SPA-GMN-PTID        TO  PTKINKI-PTID
           MOVE    SPA-P02Y-SRYCD      TO  PTKINKI-SRYCD
      *
           MOVE    PTKINKI-REC         TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "tbl_ptkinki"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF      MCP-RC          NOT =   ZERO 
               MOVE    "1001"              TO  SPA-ERRCD
               DISPLAY "P02Y PTKINKI KEY DEL ERR:"  MCP-RC
                       ",KEY:" PTKINKI-KEY
           END-IF
      *
           IF     SPA-ERRCD            =   SPACE
               PERFORM 410-INIT-SYORI-SEC
           END-IF
           .
       4031-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新後初期編集処理
      *****************************************************************
       410-INIT-SYORI-SEC             SECTION.
      *
           PERFORM  402-CLEAR-SEC
      *    禁忌薬剤編集
           MOVE    1                   TO  SPA-P02Y-PAGE
           PERFORM 3001-PTKINKI-HENSYU-SEC
           IF      SPA-P02Y-MAX        =   ZERO
               MOVE    2                   TO  SPA-P02Y-CUR
           ELSE
               MOVE    1                   TO  SPA-P02Y-CUR
           END-IF
           .
       410-INIT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁処理
      *****************************************************************
        405-ZENPAGE-SEC             SECTION.
      *
           IF      SPA-P02Y-PAGE       >   1
               PERFORM  402-CLEAR-SEC
               COMPUTE SPA-P02Y-PAGE   =   SPA-P02Y-PAGE   -   1
               PERFORM 3001-PTKINKI-HENSYU-SEC
               MOVE    1                   TO  SPA-P02Y-CUR
           ELSE
               MOVE    "0010"              TO  SPA-ERRCD
           END-IF
           .
        405-ZENPAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁処理
      *****************************************************************
        406-NEXTPAGE-SEC             SECTION.
      *
           IF      SPA-P02Y-NEXT       =   1
               PERFORM 402-CLEAR-SEC
               COMPUTE SPA-P02Y-PAGE   =   SPA-P02Y-PAGE   +   1
               PERFORM 3001-PTKINKI-HENSYU-SEC
               MOVE    1                   TO  SPA-P02Y-CUR
           ELSE
               MOVE    "0011"              TO  SPA-ERRCD
           END-IF
           .
        406-NEXTPAGE-EXT.
           EXIT.
      *****************************************************************
      *    検索処理
      *****************************************************************
       408-P02Y1-SYORI-SEC             SECTION.
      *
      *    共通ＳＰＡ編集
           INITIALIZE                  SPA-P02Y1-AREA
           INITIALIZE                  SPA-P02Y1GMN-AREA 
           MOVE    "2"                 TO  SPA-P02Y1-TYPE
      *
           IF      WRK-INPUTCD         NOT =   SPACE
      *        内服
               MOVE    "3"                 TO  SPA-P02Y1-GMN-SYORI
               MOVE    WRK-INPUTCD         TO  SPA-P02Y1-INPUTCD
               MOVE    "1"                 TO  SPA-P02Y1-TYPE
               IF      FLG-KANJI           =   1
                   MOVE    "J"             TO  SPA-P02Y1-CDSYUBETU
               ELSE
                   IF      WRK-INPUTCD(1:1)    NUMERIC
                       EVALUATE    WRK-CD-MCNT
                           WHEN    3
                           WHEN    6
                               MOVE    "6"     TO  SPA-P02Y1-CDSYUBETU
                           WHEN    4
                               MOVE    "4"     TO  SPA-P02Y1-CDSYUBETU
                           WHEN    5
                               MOVE    "5"     TO  SPA-P02Y1-CDSYUBETU
                       END-EVALUATE
                   ELSE
                       MOVE    "A"             TO  SPA-P02Y1-CDSYUBETU
                   END-IF
               END-IF
      *        画面編集
               PERFORM 41011-P02Y1-SET-SEC
           ELSE
      *        画面編集
               PERFORM 41011-P02Y1-SET-SEC
           END-IF
      *
      *
           MOVE    "P02Y"              TO  SPA-MOTOPG
           MOVE    "P02Y1"             TO  SPA-SAKIPG
      *
           IF      SPA-P02Y1-GMN-MAX   =   ZERO
               MOVE    "INPUT"             TO  MCP-WIDGET
           ELSE
               MOVE    "SELNUM01"          TO  MCP-WIDGET
           END-IF
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE
           MOVE   "P02Y1"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       408-P02Y1-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索画面編集処理
      *****************************************************************
       41011-P02Y1-SET-SEC             SECTION.
      *
           MOVE    SPA-P02KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-P02SCRAREA      TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGP02Y1"         USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA.
      *
           MOVE    SPA-COMMON          TO  SPA-AREA.
           MOVE    SPA-FREE            TO  SPA-P02SCRAREA
           MOVE    SPA-WORK            TO  SPA-P02KYOUTU
           .
       41011-P02Y1-SET-EXT.
           EXIT.
      *****************************************************************
      *    登録処理
      *****************************************************************
       412-TOUROKU-SYORI-SEC            SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF     (SPA-ERRCD           =   SPACE )  AND
                  (FLG-END             =   ZERO  )
               IF      SPA-P02Y-SRYCD      =   SPACE
                   MOVE    "0008"          TO  SPA-ERRCD
                   MOVE    2               TO  SPA-P02Y-CUR
               END-IF
           END-IF
           IF     (SPA-ERRCD           =   SPACE )  AND
                  (FLG-END             =   ZERO  )
      *        患者禁忌薬剤登録処理
               MOVE    SPA-P02Y-SRYCD      TO  WRK-SRYCD
               PERFORM 4121-PTKINKI-INS-SEC
           END-IF
      *
           IF    ((SPA-ERRCD           =   SPACE ) OR
                  (SPA-ERRCD           =   "1002"))  AND
                  (FLG-END             =   ZERO  )
               PERFORM 410-INIT-SYORI-SEC
           END-IF
           .
       412-TOUROKU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者禁忌薬剤登録処理
      *****************************************************************
       4121-PTKINKI-INS-SEC           SECTION.
      *
           INITIALIZE                      PTKINKI-REC
           MOVE    SPA-HOSPNUM         TO  PTKINKI-HOSPNUM
           MOVE    SPA-GMN-PTID        TO  PTKINKI-PTID
           MOVE    WRK-SRYCD           TO  PTKINKI-SRYCD
           MOVE    PTKINKI-REC         TO  MCPDATA-REC
           MOVE    "tbl_ptkinki"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptkinki"       TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-PTKINKI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTKINKI
               INITIALIZE                      PTKINKI-REC
           END-IF
           MOVE    "tbl_ptkinki"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
           IF      FLG-PTKINKI         =   1
      *        追加のみ
               INITIALIZE                      PTKINKI-REC
               MOVE    SPA-HOSPNUM         TO  PTKINKI-HOSPNUM
               MOVE    SPA-GMN-PTID        TO  PTKINKI-PTID
               MOVE    WRK-SRYCD           TO  PTKINKI-SRYCD
      *
               MOVE    SMCNDATE-YMD        TO  PTKINKI-CREYMD
               MOVE    SMCNDATE-YMD        TO  PTKINKI-UPYMD
               MOVE    SMCNDATE-HMS        TO  PTKINKI-UPHMS
               MOVE    SPA-OPID            TO  PTKINKI-OPID
      *
               MOVE    PTKINKI-REC         TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "tbl_ptkinki"       TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
grpsys         CALL    "ORCDBMAIN"         USING   MCPAREA
                                                   MCPDATA-REC
                                                   SPA-AREA
               IF      MCP-RC          NOT =   ZERO 
                   MOVE    "1001"              TO  SPA-ERRCD
                   DISPLAY "P02Y PTKINKI KEY INS ERR:"  MCP-RC
                       ",KEY:" PTKINKI-KEY
               END-IF
           ELSE
               MOVE    "1002"              TO  SPA-ERRCD
           END-IF
           .
       4121-PTKINKI-INS-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "P02Y"              TO  SPA-MOTOPG
           MOVE    "P02"               TO  SPA-SAKIPG
      *
           MOVE    SPACE               TO  LNK-KYOUTU
      *
           MOVE    "JOIN"              TO  MCP-PUTTYPE
           MOVE    "P02"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           MOVE    ZERO                TO  SPA-FLG-END
           MOVE    "P02"               TO  SPA-P02-GAMEN
      *
           .
       210-BACK-EXT.
           EXIT.
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO      TO              500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-PIDCD       NOT =   SPACE
               PERFORM 520-JIDSET-SEC
               GO      TO              500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "P02Y"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "選択番号入力エラー"    TO  SPA-ERRMSG
               WHEN    "0002"
                   STRING  "選択後に薬剤コードが変更されています。"
                           "再度、選択して下さい。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0003"
                   STRING  "薬剤コード入力エラー。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0004"
                   STRING  "薬剤コードは点数マスタに存在しません。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0007"
                   STRING  "薬剤コードではありません。"
                           "登録できません。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0008"
                   STRING  "薬剤コードを入力して下さい。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0010"
                   STRING  "前頁はありません。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0011"
                   STRING  "次頁はありません。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "1001"
                   MOVE    "患者禁忌薬剤データ更新ができませんでした。"
                                                   TO  SPA-ERRMSG
               WHEN    "1002"
                   STRING  "既に患者禁忌薬剤に登録されています。"
                           "登録しませんでした。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
           END-EVALUATE
      *
           MOVE    SPACE               TO  PERR
           MOVE    SPA-ERRCD           TO  PERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  PERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "P02Y"              TO  SPA-MOTOPG
           MOVE    "PERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "PERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-JIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-PIDMSG
           EVALUATE    SPA-PIDCD
               WHEN    "0101"
                   STRING  "選択した薬剤コードを削除します。"
                           "よろしいですか？"  DELIMITED  BY  SIZE
                                               INTO  WRK-PIDMSG
                   END-STRING
               WHEN    OTHER
                   MOVE    SPA-PIDCD
                                       TO  WRK-PIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  SPA-PID1-FLG
      *
           MOVE    SPACE               TO  PID1
           MOVE    SPA-PIDCD           TO  PID1-ID1CODE
           MOVE    WRK-PIDMSG          TO  PID1-ID1MSG
      *
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "P02Y"              TO  SPA-MOTOPG
           MOVE    "PID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "PID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-JIDSET-EXT.
           EXIT.
      *****************************************************************
      *    西暦→和暦FORMAT日付編集
      *****************************************************************
       800-SE-WAFORMAT-YMDEDIT-SEC  SECTION.
      *
           EVALUATE    WRK-SYMD
               WHEN    "00000000"
               WHEN    "99999999"
                   MOVE    WRK-SYMD        TO  WRK-HENYMD
               WHEN    OTHER
                   MOVE    SPACE               TO  STS-AREA-DAY
                   INITIALIZE                      STS-AREA-DAY
                   MOVE    SPACE               TO  LNK-DAY2-AREA
                   MOVE    "21"                TO  LNK-DAY2-IRAI
                   MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
                   CALL    "ORCSDAY"           USING
                                               STS-AREA-DAY
                                               LNK-DAY2-AREA
                   IF      STS-DAY-RC1             =   ZERO
                       MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMD
                   ELSE
                       MOVE    SPACE               TO  WRK-HENYMD
                   END-IF
           END-EVALUATE
           .
       800-SE-WAFORMAT-YMDEDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    全角チェック処理
      *****************************************************************
       810-ORCSKANACHK-SEC         SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-DATA            TO  KANACHK-MAE-INPUT
           MOVE    WRK-MAX-CNT         TO  KANACHK-MAX-CNT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           MOVE    KANACHK-MAE-INPUT   TO  WRK-DATA
           .
       810-ORCSKANACHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    老人一般コード変換読込
      *****************************************************************
       990-SRYCDCHG-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYCDCHG-REC
               MOVE    ZERO                TO  FLG-SRYCDCHG
           ELSE
               INITIALIZE                      SRYCDCHG-REC
               MOVE    1                   TO  FLG-SRYCDCHG
           END-IF
      *
           .
       990-SRYCDCHG-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者禁忌薬剤マスタ読込処理
      *****************************************************************
       900-PTKINKI-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTKINKI-REC
               MOVE    ZERO            TO  FLG-PTKINKI
           ELSE
               INITIALIZE                  PTKINKI-REC
               MOVE    1               TO  FLG-PTKINKI
           END-IF
           .
       900-PTKINKI-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           INITIALIZE                      TNS-TENSU-REC
           MOVE    WRK-SRYCD           TO  TNS-SRYCD
           MOVE    SPA-HOSPNUM         TO  TNS-HOSPNUM
           MOVE    SPA-SYSYMD          TO  TNS-YUKOSTYMD
           MOVE    SPA-SYSYMD          TO  TNS-YUKOEDYMD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_tensu"         TO  MCP-TABLE
               MOVE    "key4"              TO  MCP-PATHNAME
               PERFORM 9110-TENSU-READ-SEC
           END-IF
           MOVE    ZERO                TO  FLG-TENSU-OK
           PERFORM UNTIL  (FLG-TENSU       =   1 ) OR
                          (FLG-TENSU-OK    =   1 )
               IF     (TNS-YUKOSTYMD       <=  SPA-SYSYMD ) AND
                      (TNS-YUKOEDYMD       >=  SPA-SYSYMD )
                   MOVE    1                   TO  FLG-TENSU-OK
                   MOVE    1                   TO  FLG-TENSU
               ELSE
                   MOVE    2                   TO  FLG-TENSU-OK
                   MOVE    TNS-TENSU-REC       TO  TNSWK-TENSU-REC
               END-IF
               IF      FLG-TENSU           =   ZERO
                   MOVE    "tbl_tensu"         TO  MCP-TABLE
                   MOVE    "key4"              TO  MCP-PATHNAME
                   PERFORM 9110-TENSU-READ-SEC
               END-IF
           END-PERFORM
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *    当日期間外
           IF      FLG-TENSU-OK        =   2
               MOVE    TNSWK-TENSU-REC     TO  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU-OK
           END-IF
          .
       910-TENSU-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ読込処理
      *****************************************************************
       9110-TENSU-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               MOVE    ZERO                TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
           .
       9110-TENSU-READ-EXT.
           EXIT.
      *****************************************************************
      *    入力コードマスター読込
      *****************************************************************
       930-INPUTCD-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  INPUTCD-REC
               MOVE    ZERO                TO  FLG-INPUTCD
           ELSE
               INITIALIZE                  INPUTCD-REC
               MOVE    1                   TO  FLG-INPUTCD
           END-IF
      *
           .
       930-INPUTCD-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       990-DBCLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE    "PUTWINDOW"         TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
