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
       PROGRAM-ID.             ORCGX91.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : チェックマスタ情報設定
      *  コンポーネント名  : チェックマスタ出力設定画面（Ｘ９１）
      *  管理者            : 
      *  04/02/27    NACL-太田    新規作成
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
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //CHKMERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    画面活性非活性
           COPY    "ENUM-VALUE".
      *
      *    SHELL用
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    点数マスタ設定用共通パラメタ
           COPY    "X01COMMON-SPA".
      *
      *    第一画面ＳＰＡエリア
           COPY    "X01SCR-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-X91.
           03  SPA-X91-AREA.
               05  SPA-GMN-CUR             PIC 9(03).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-CHK-VAL.
                       09  SPA-GMN-CHKYKZBYO   PIC X(01).
                       09  SPA-GMN-CHKSRYBYO   PIC X(01).
                       09  SPA-GMN-CHKYKZHEI   PIC X(01).
                       09  SPA-GMN-CHKSRYHEI   PIC X(01).
                   07  SPA-GMN-CHK-R   REDEFINES   SPA-GMN-CHK-VAL.
                       09  SPA-GMN-CHKKBN      PIC X(01)   OCCURS  4.
                   07  SPA-GMN-CHKSRYRANGE     PIC X(01).
                   07  SPA-GMN-STSRYCD         PIC X(09).
                   07  SPA-GMN-STSRYNAME       PIC X(100).
                   07  SPA-GMN-EDSRYCD         PIC X(09).
                   07  SPA-GMN-SYU1        PIC X(01).
                   07  SPA-GMN-SYU2        PIC X(01).
                   07  SPA-GMN-SYU3        PIC X(01).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-SRYCD-EXSIT-FLG
                                               PIC 9(01).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-KANJI               PIC 9(01).
           03  FLG-KENSAKU             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                    PIC 9(05).
           03  IDX1                    PIC 9(05).
      *      
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY              PIC 9(02).
               05  SYS-MM              PIC 9(02).
               05  SYS-DD              PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY           PIC 9(04).
               05  WRK-SYSMM           PIC 9(02).
               05  WRK-SYSDD           PIC 9(02).
           03  SYS-TIME                PIC X(06).
      *
       01  WRK-AREA.
           03  WRK-MCP-WIDGET          PIC X(64).
           03  WRK-MOTOPG              PIC X(08).
           03  WRK-PRTKANRI-RENNUM     PIC 9(04).
           03  WRK-SHORIERR            PIC X(200).
           03  WRK-XIDMSG              PIC X(70).
           03  WRK-PAGE                PIC ZZZZZZZZZ9.
      *
           03  WRK-STPAGE              PIC 9(05).
           03  WRK-EDPAGE              PIC 9(05).
      *
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-HENTIME.
               05  WRK-HH              PIC X(02).
               05  FILLER              PIC X(01)   VALUE   ".".
               05  WRK-MM              PIC X(02).
               05  FILLER              PIC X(01)   VALUE   ".".
               05  WRK-SS              PIC X(02).
           03  WRK-CHKKBN              PIC X(01).
           03  WRK-SRTKBN              PIC X(01).
           03  WRK-INPUTCD             PIC X(09).
           03  WRK-CD-MCNT             PIC 9(02).
           03  WRK-STR-IN              PIC X(500).
           03  WRK-STR-OUT             PIC X(500).
           03  WRK-STR-LEN             PIC 9(8).
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
       01  WRK-LNK-AREA.
           COPY    "CPORCSPRTLNK.INC".
      *
      *
       01  WRK-CONS-AREA.
           03  WRK-CONS-CHKKBN-MAX     PIC 9(02)   VALUE   4.
           03  WRK-CONS-CHKKBN-VAL.
               05                      PIC X(01)   VALUE   "1".
               05                      PIC X(01)   VALUE   "2".
               05                      PIC X(01)   VALUE   "4".
               05                      PIC X(01)   VALUE   "5".
           03  WRK-CONS-CHKKBN-R       REDEFINES   WRK-CONS-CHKKBN-VAL.
               05  WRK-CONS-CHKKBN     PIC X(01)   OCCURS  4.
      *    システム管理ＤＢ（３００３）のキー値  
           03  WRK-CONS-3003-KBNCD     PIC X(08)   VALUE   "103".
      *    印刷管理ＤＢのキー値  
           03  WRK-CONS-PRTKANRI-TBL-KEY
                                       PIC X(08)   VALUE   "CHKMST".
           03  WRK-CONS-PRTKANRI-TBL-GROUP
                                       PIC X(14)   VALUE   SPACE.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID    PIC X(08)   VALUE   "CHKMST".
           03  WRK-CONS-JOB-JOBID      PIC 9(07)   VALUE   ZERO.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1031.INC".
      *
           COPY    "CPSK3003.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    チェック
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
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
           COPY    "X01.INC".
           COPY    "X02.INC".
           COPY    "X91.INC".
           COPY    "X97.INC".
           COPY    "X98.INC". 
           COPY    "XERR.INC".
           COPY    "XID1.INC".
           COPY    "XID2.INC".
      *
       PROCEDURE                                 DIVISION    USING
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
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-WORK        TO  SPA-X01KYOUTU
           MOVE    SPA-FREE        TO  SPA-X01FREE
           MOVE    SPA-X01SONOTA   TO  SPA-X91
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS  ALSO    MCP-EVENT
           WHEN    "LINK"          ALSO    ANY
               PERFORM 100-INIT-SEC
      *    画面遷移
           WHEN     "PUTG"         ALSO    "CLICKED"
               PERFORM 200-GMNSENI
      *    入力
           WHEN      OTHER
               PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF    ( FLG-END         =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-X01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-X91         TO  SPA-X01SONOTA
           MOVE    SPA-X01FREE     TO  SPA-FREE
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
      *    エラー画面より
           IF    ( SPA-MOTOPG          =   "XERR" )
               MOVE    SPACE       TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF    ( FLG-END     =   1 )
                   GO  TO  100-INIT-EXT
               END-IF
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  LINKAREA
      *
      *
      ***  MOVE    "NEW"           TO  MCP-PUTTYPE.
           MOVE    SPACE           TO  MCP-PUTTYPE.
           MOVE    "X91"           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1               TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF    ( LINKAREA        NOT =   SPACE )
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    SPA-MOTOPG          TO  WRK-MOTOPG
      *
      *        元の画面へ戻す
               IF    ( WRK-MOTOPG      =   "XA01"  OR  "XB01" )
                   MOVE    LNK-COMMON      TO  SPA-KYOTUKEY
                   MOVE    LNK-SCRSPA      TO  SPA-X91
                   MOVE    SPA-WORK        TO  SPA-X01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
      *
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
      *
               MOVE    SPACE               TO  SPA-XID1-FLG
               MOVE    SPACE               TO  SPA-XIDCD
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "X97"
               GO  TO      300-SCREEN-EXT
           WHEN    "X98"
               PERFORM 320-X98SPASET-SEC
               GO  TO      300-SCREEN-EXT
      *    作表処理
           WHEN    "XID1"
               PERFORM 330-XID1-SET-SEC
               GO  TO      300-SCREEN-EXT
           WHEN    "XID2"
               PERFORM 350-XID2-SET-SEC
               GO  TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC                  SECTION.
      *
           INITIALIZE                  SPA-X91
      *
           MOVE    "F"             TO  SPA-GMN-CHKYKZBYO
           MOVE    "F"             TO  SPA-GMN-CHKSRYBYO
           MOVE    "F"             TO  SPA-GMN-CHKYKZHEI
           MOVE    "F"             TO  SPA-GMN-CHKSRYHEI
      *
           MOVE    "F"             TO  SPA-GMN-CHKSRYRANGE
      *
           MOVE    "T"             TO  SPA-GMN-SYU1
      *
           MOVE    "F"             TO  SPA-GMN-SYU2
           MOVE    "F"             TO  SPA-GMN-SYU3
      *
           MOVE   1                TO  SPA-GMN-CUR 
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為コードセット処理
      *****************************************************************
       320-X98SPASET-SEC          SECTION.
      *
           IF    ( SPA-X98-SRYCD   NOT =   SPACE )
               MOVE    SPA-X98-SRYCD   TO  SPA-GMN-STSRYCD
               PERFORM 4101-STSRYCD-CHK-SEC
               MOVE    7               TO  SPA-GMN-CUR
           ELSE
               MOVE    6               TO  SPA-GMN-CUR
           END-IF
      *
           .
       320-X98SPASET-EXT.
           EXIT.
      *****************************************************************
      *    確認画面ＯＫ処理
      *****************************************************************
       330-XID1-SET-SEC            SECTION.
      *
           IF    ( SPA-XID1-FLG    =   "OK" )
               EVALUATE    SPA-XIDCD
               WHEN    "6666"
                   MOVE    "JOIN"  TO  MCP-PUTTYPE
                   PERFORM 210-BACK-SYORI-SEC
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE           TO  SPA-XID1-FLG
           MOVE    SPACE           TO  SPA-XIDCD
      *
           .
       330-XID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＺＩＤ２）ＯＫ処理
      *****************************************************************
       350-XID2-SET-SEC            SECTION.
      *
           IF    ( SPA-XID1-FLG    =   "OK"    OR  "NO" )
               PERFORM 490-PRINT-SEC
           END-IF
      *
           MOVE    SPACE           TO  SPA-XID1-FLG
           MOVE    SPACE           TO  SPA-XIDCD
      *
           .
       350-XID2-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                     SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE   "CHANGE"     TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *    クリア
           WHEN    "CLICKED"       ALSO    "B02"
               PERFORM 310-SPASET-SEC
      *    再印刷
           WHEN    "CLICKED"       ALSO    "B05"
               PERFORM 4101-GMN-SPA-SET-SEC
               PERFORM 450-REPRINT-SEC
      *    情報削除
           WHEN    "CLICKED"       ALSO    "B11"
               PERFORM 4101-GMN-SPA-SET-SEC
               PERFORM 490-JYOUHOU-DEL-SEC
      *    印刷
           WHEN    "CLICKED"       ALSO    "B12"
               PERFORM 490-PRINT-MAE-SEC
      *    処理確認
           WHEN    "CLICKED"       ALSO    "B13"
               PERFORM 4101-GMN-SPA-SET-SEC
               PERFORM 490-KAKUNIN-SEC
      *
      *    薬剤と病名チェックボタン
           WHEN    "CLICKED"       ALSO    "CHKYKZBYO"
               MOVE    X91-CHKYKZBYO   TO  SPA-GMN-CHKYKZBYO
               PERFORM 4101-GMN-SPA-SET-SEC
               PERFORM 41011-CHKMST-CHK-SEC
               MOVE    2               TO  SPA-GMN-CUR
      *
      *    診療行為と病名チェックボタン
           WHEN    "CLICKED"       ALSO    "CHKSRYBYO"
               MOVE    X91-CHKSRYBYO   TO  SPA-GMN-CHKSRYBYO
               PERFORM 4101-GMN-SPA-SET-SEC
               PERFORM 41011-CHKMST-CHK-SEC
               MOVE    3               TO  SPA-GMN-CUR
      *
      *    薬剤と併用禁忌チェックボタン
           WHEN    "CLICKED"       ALSO    "CHKYKZHEI"
               MOVE    X91-CHKYKZHEI   TO  SPA-GMN-CHKYKZHEI
               PERFORM 4101-GMN-SPA-SET-SEC
               PERFORM 41011-CHKMST-CHK-SEC
               MOVE    4               TO  SPA-GMN-CUR
      *
      *    診療行為の併用算定チェックボタン
           WHEN    "CLICKED"       ALSO    "CHKSRYHEI"
               MOVE    X91-CHKSRYHEI   TO  SPA-GMN-CHKSRYHEI
               PERFORM 4101-GMN-SPA-SET-SEC
               PERFORM 41011-CHKMST-CHK-SEC
               MOVE    5               TO  SPA-GMN-CUR
      *
      *    診療行為範囲指定チェックボタン
           WHEN    "CLICKED"       ALSO    "CHKSRYRANGE"
               PERFORM 4101-CHKSRYRANGE-CHK-SEC
      *
      *    出力順指定
           WHEN    "CLICKED"       ALSO    "SYU1"
           WHEN    "CLICKED"       ALSO    "SYU2"
           WHEN    "CLICKED"       ALSO    "SYU3"
               PERFORM 4101-GMN-SPA-SET-SEC
               MOVE    X91-SYU1        TO  SPA-GMN-SYU1
               MOVE    X91-SYU2        TO  SPA-GMN-SYU2
               MOVE    X91-SYU3        TO  SPA-GMN-SYU3
               MOVE    212             TO  SPA-GMN-CUR
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
      *
      *    EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    WHEN    "ACTIVATE"      ALSO    "??????"
      *            PERFORM 4100-??????-CHK-SEC
      *    WHEN    OTHER
      *
               MOVE    ZERO            TO  SPA-GMN-CUR
      *
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
      *
      *    END-EVALUATE
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC            SECTION.
      *
           MOVE    X91-STSRYCD     TO  SPA-GMN-STSRYCD
           MOVE    X91-EDSRYCD     TO  SPA-GMN-EDSRYCD
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
      *    開始診療行為コードチェック
           PERFORM 4101-STSRYCD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
            OR   ( FLG-END         =   1 )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    終了診療行為コードチェック
           PERFORM 4101-EDSRYCD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
            OR   ( FLG-END         =   1 )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始診療行為コードチェック
      *****************************************************************
       4101-STSRYCD-CHK-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-KENSAKU
           MOVE    ZERO                TO  FLG-KANJI
      *
           MOVE    ZERO                TO  WRK-CD-MCNT
           MOVE    SPACE               TO  WRK-INPUTCD
      *
           MOVE    ZERO                TO  SPA-NAI-SRYCD-EXSIT-FLG
      *
           IF    ( SPA-GMN-STSRYCD     =   SPACE )
               GO  TO  4101-STSRYCD-CHK-EXT
           END-IF
      *
      *    "/"が入力された場合は検索画面へ
           IF    ( SPA-GMN-STSRYCD(1:1)    =   "/" )
               PERFORM 490-KENSAKU-SEC
               GO  TO  4101-STSRYCD-CHK-EXT
           END-IF
      *
      *    全角チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN-STSRYCD     TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF    ( KANACHK-RC      NOT =   ZERO )
      *        全角半角混在エラー
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    6               TO  SPA-GMN-CUR
               GO  TO   4101-STSRYCD-CHK-EXT
           ELSE
               MOVE    KANACHK-MAX     TO  WRK-CD-MCNT
      *        全角
               IF    ( KANACHK-SYUBETU =   2 )
                   MOVE    1           TO  FLG-KANJI
                   MOVE    SPACE       TO  SPA-GMN-STSRYCD(9:)
               ELSE
                   MOVE    ZERO        TO  FLG-KANJI
               END-IF
           END-IF
      *
      *    ９桁コード入力以外は検索画面へ
           IF    ( WRK-CD-MCNT         =   9  )
            AND  ( FLG-KANJI           =   ZERO )
            AND  ( SPA-GMN-STSRYCD         NUMERIC  )
                CONTINUE
           ELSE
               MOVE    SPA-GMN-STSRYCD TO  WRK-INPUTCD
               PERFORM 490-KENSAKU-SEC
               GO  TO  4101-STSRYCD-CHK-EXT
           END-IF
      *
           INITIALIZE                      TNS-TENSU-REC
           MOVE    SPA-GMN-STSRYCD     TO  TNS-SRYCD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "TENSU-KEY24"       TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
      *
      *        チェックマスタチェック
               PERFORM 41011-CHKMST-CHK-SEC
           ELSE
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "TENSU-KEY24"       TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           MOVE    TNS-NAME            TO  SPA-GMN-STSRYNAME
      *
           .
       4101-STSRYCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタチェック
      *****************************************************************
       41011-CHKMST-CHK-SEC            SECTION.
      *
           MOVE    ZERO            TO  SPA-NAI-SRYCD-EXSIT-FLG
      *
           IF    ( SPA-GMN-STSRYNAME   =   SPACE )
               GO  TO  41011-CHKMST-CHK-EXT
           END-IF
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   WRK-CONS-CHKKBN-MAX )
                    OR   ( SPA-NAI-SRYCD-EXSIT-FLG
                                   =   1 )
      *
               IF    ( SPA-GMN-CHKKBN (IDX0)   =   "T" )
                   INITIALIZE                  CHK-REC
                   MOVE    WRK-CONS-CHKKBN (IDX0)
                                       TO  CHK-CHKKBN
                   MOVE    SPA-GMN-STSRYCD TO  CHK-SRYCD
                   MOVE    CHK-REC         TO  MCPDATA-REC
                   MOVE    SPA-SYSYMD      TO  ORC-DBYMD
                   MOVE    "CHK-KEY2"      TO  ORC-DBPATH
                   PERFORM 910-DBSELECT-SEC
                   IF    ( MCP-RC          =   ZERO )
                       MOVE    1           TO  SPA-NAI-SRYCD-EXSIT-FLG
                   END-IF
      *
                   MOVE    "CHK-KEY2"      TO  ORC-DBPATH
                   PERFORM 910-DBCLOSE-SEC
               END-IF
      *
           END-PERFORM
      *
           .
       41011-CHKMST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    終了診療行為コードチェック
      *****************************************************************
       4101-EDSRYCD-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-EDSRYCD     =   SPACE )
               GO  TO  4101-EDSRYCD-CHK-EXT
           END-IF
      *
      *    全角チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN-STSRYCD     TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF    ( KANACHK-RC      NOT =   ZERO )
      *        全角半角混在エラー
               MOVE    "0002"          TO  SPA-ERRCD
               MOVE    7               TO  SPA-GMN-CUR
               GO  TO   4101-EDSRYCD-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-EDSRYCD (9:)    =   SPACE )
               IF    ( SPA-GMN-EDSRYCD (1:3)   =   "999" )
                   MOVE    "999999999" TO  SPA-GMN-EDSRYCD
               END-IF
           END-IF
      *
           .
       4101-EDSRYCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    関連チェック処理
      *****************************************************************
       4101-KANREN-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-CHKYKZBYO   =   "F")
            AND  ( SPA-GMN-CHKSRYBYO   =   "F")
            AND  ( SPA-GMN-CHKYKZHEI   =   "F")
            AND  ( SPA-GMN-CHKSRYHEI   =   "F")
               MOVE    "0100"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-CUR
               GO  TO  4101-KANREN-CHK-EXT
           END-IF
      *
      *    診療行為コードで絞り込むが選択されている場合のチェック
           IF    ( SPA-GMN-CHKSRYRANGE =   "T" )
      *
               IF    ( SPA-GMN-STSRYCD NOT =   SPACE )
      *            開始診療行為コードの桁数をチェック
                   MOVE    SPA-GMN-STSRYCD TO  WRK-STR-IN
                   PERFORM 800-LENGTH-CHK-SEC
                   IF    ( WRK-STR-LEN     NOT =   9 )
                       MOVE    "0101"      TO  SPA-ERRCD
                       MOVE    6           TO  SPA-GMN-CUR
                       GO  TO  4101-KANREN-CHK-EXT
                   END-IF
               ELSE
                       MOVE    "0102"      TO  SPA-ERRCD
                       MOVE    6           TO  SPA-GMN-CUR
                       GO  TO  4101-KANREN-CHK-EXT
               END-IF
      *
      *        終了診療行為コードの桁数をチェック
               IF    ( SPA-GMN-EDSRYCD NOT =   SPACE )
                   MOVE    SPA-GMN-EDSRYCD TO  WRK-STR-IN
                   PERFORM 800-LENGTH-CHK-SEC
                   IF    ( WRK-STR-LEN     NOT =   9 )
                       MOVE    "0103"      TO  SPA-ERRCD
                       MOVE    7           TO  SPA-GMN-CUR
                       GO  TO  4101-KANREN-CHK-EXT
                   END-IF
      *
                   IF    ( SPA-GMN-STSRYCD <=  SPA-GMN-EDSRYCD )
                       CONTINUE
                   ELSE
                       MOVE    "0104"      TO  SPA-ERRCD
                       MOVE    6           TO  SPA-GMN-CUR
                       GO  TO  4101-KANREN-CHK-EXT
                   END-IF
               ELSE
                   IF    ( SPA-GMN-STSRYNAME   =   SPACE )
                       MOVE    "0105"      TO  SPA-ERRCD
                       MOVE    6           TO  SPA-GMN-CUR
                       GO  TO  4101-KANREN-CHK-EXT
                   END-IF
               END-IF
           END-IF
      *
           .
       4101-KANREN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療行為範囲指定チェックボタンチェック処理
      *****************************************************************
       4101-CHKSRYRANGE-CHK-SEC            SECTION.
      *
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    X91-CHKSRYRANGE     TO  SPA-GMN-CHKSRYRANGE
      *
           IF    ( SPA-GMN-CHKSRYRANGE =   "F" )
               INITIALIZE              SPA-GMN-STSRYCD
                                       SPA-GMN-STSRYNAME
                                       SPA-GMN-EDSRYCD
           END-IF
      *
           MOVE    6                   TO  SPA-GMN-CUR
      *
           .
       4101-CHKSRYRANGE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-3003-REC 
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0 >      SYS-3003-JOBID )
      *
      *            ジョブ管理チェック処理
                   MOVE    "CHK"       TO  SJOBKANRI-MODE
                   INITIALIZE              JOBKANRI-REC
                   MOVE    IDX0        TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                       TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                   IF    ( SJOBKANRI-RETURN
                                           =   ZERO )
                       IF    ( JOB-ENDYMD      =   SPACE )
      *********        AND     JOB-TERMID      =   SPA-TERMID
                           MOVE    "6666"  TO  SPA-XIDCD
                           GO  TO  210-BACK-EXT
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
           PERFORM 210-BACK-SYORI-SEC
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      * 
           MOVE    "X01"               TO  SPA-SAKIPG
           MOVE    "X91"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    再印刷画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-X91             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "X91"               TO  SPA-MOTOPG
           MOVE    "XB01"              TO  SPA-SAKIPG
      *
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SPA-JOB-SHELLID
      *          
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XB01   "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-JYOUHOU-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索画面へ
      *****************************************************************
       490-KENSAKU-SEC                 SECTION.
      *
      *    共通ＳＰＡ編集
           INITIALIZE                  SPA-X98-AREA
           MOVE    "2"                 TO  SPA-X98-TYPE
      *
           INITIALIZE                  SPA-X98GMN-AREA
           IF    ( WRK-INPUTCD         NOT =   SPACE )
               MOVE    WRK-INPUTCD     TO  SPA-X98-INPUTCD
               MOVE    "1"             TO  SPA-X98-TYPE
               IF    ( FLG-KANJI       =   1 )
                   MOVE    "J"         TO  SPA-X98-CDSYUBETU
               ELSE
                   IF    ( WRK-INPUTCD(1:1)    NUMERIC )
                       EVALUATE    WRK-CD-MCNT
                       WHEN    3
                       WHEN    6
                           MOVE    "6"     TO  SPA-X98-CDSYUBETU
                       WHEN    4
                           MOVE    "4"     TO  SPA-X98-CDSYUBETU
                       WHEN    5
                           MOVE    "5"     TO  SPA-X98-CDSYUBETU
                       END-EVALUATE
                   ELSE
                       MOVE    "A"         TO  SPA-X98-CDSYUBETU
                   END-IF
               END-IF
               MOVE    "2"                 TO  SPA-X98-GMN-KBN
      *        画面編集
               PERFORM 41011-X98-SET-SEC
           ELSE
      *        画面編集
               MOVE    "2"                 TO  SPA-X98-GMN-KBN
               PERFORM 41011-X98-SET-SEC
           END-IF
      *
           MOVE    "X91"               TO  SPA-MOTOPG
           MOVE    "X98"               TO  SPA-SAKIPG
           MOVE    "X91"               TO  SPA-X98-MOTOPG
      *
           IF    ( SPA-X98-GMN-MAX     =   ZERO )
               MOVE    "INPUT"         TO  MCP-WIDGET
           ELSE
               MOVE    "SELNUM"        TO  MCP-WIDGET
           END-IF
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE
           MOVE   "X98    "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-JYOUHOU-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索画面編集処理
      *****************************************************************
       41011-X98-SET-SEC               SECTION.
      *
           MOVE    SPA-X01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-X91         TO  SPA-X01SONOTA
           MOVE    SPA-X01FREE     TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGX98"           USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-X01KYOUTU 
           MOVE    SPA-FREE        TO  SPA-X01FREE
           MOVE    SPA-X01SONOTA   TO  SPA-X91
      *
           .
       41011-X98-SET-EXT.
           EXIT.
      *****************************************************************
      *    再印刷画面へ
      *****************************************************************
       450-REPRINT-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-X91             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "X91"               TO  SPA-MOTOPG
           MOVE    "XA01"              TO  SPA-SAKIPG
      *
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                       TO  SPA-PRTKANRI-TBL-KEY
      *          
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XA01   "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       450-REPRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷前確認処理
      *****************************************************************
       490-PRINT-MAE-SEC                   SECTION.
      *
      *    入力チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-PRINT-MAE-EXT
           END-IF
      *
      *    関連チェック
           PERFORM 4101-KANREN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-PRINT-MAE-EXT
           END-IF
      *
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
               PERFORM VARYING IDX0 FROM    1   BY  1
                       UNTIL ( IDX0 >       SYS-3003-JOBID )
      *
      *            ジョブ管理チェック処理
                   MOVE    "CHK"       TO  SJOBKANRI-MODE
                   INITIALIZE              JOBKANRI-REC
                   MOVE    IDX0        TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                       TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                   IF    ( SJOBKANRI-RETURN
                                           =   ZERO )
                       IF    ( JOB-ENDYMD  =   SPACE )
                           MOVE    "7777"          TO  SPA-ERRCD
                           MOVE    SPACE           TO  WRK-SHORIERR
                           STRING  "処理中です【"  DELIMITED  BY  SIZE
                                   JOB-SHELLMSG    DELIMITED  BY  SPACE
                                   "】"            DELIMITED  BY  SIZE
                                                   INTO  WRK-SHORIERR
                           MOVE    SYS-3003-JOBID  TO  IDX0
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
           IF   ( SPA-ERRCD        NOT =   SPACE )
               GO  TO  490-PRINT-MAE-EXT
           END-IF
      *
           MOVE    "1001"              TO  SPA-XIDCD
      *
           .
       490-PRINT-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       490-PRINT-SEC                       SECTION.
      * 
      *    ＪＯＢＩＤ（３００４）削除処理
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
               MOVE    SYS-3003-REC    TO  MCPDATA-REC
               MOVE    "DBDELETE"      TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    "1005"      TO  SPA-ERRCD
                   GO  TO  490-PRINT-EXT
               END-IF
           END-IF
      * 
      *    ジョブ管理削除処理
           MOVE    "ALL"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING   ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           IF    ( SJOBKANRI-RETURN    =   ZERO )
               CONTINUE
           ELSE
               MOVE    "1004"          TO  SPA-ERRCD
               GO  TO  490-PRINT-EXT
           END-IF
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                      SYS-1031-REC
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "2"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SYSYMD          TO  ORCSPRTNM-SRYYMD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1031-REC
           IF    ( ORCSPRTNM-RC    NOT =   ZERO )
               INITIALIZE                  SYS-1031-REC
           END-IF 
      *
      *    印刷処理
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
           ACCEPT  SYS-TIME            FROM    TIME
      *
           MOVE    ZERO                TO  WRK-CONS-JOB-JOBID
                                           WRK-PRTKANRI-RENNUM
           MOVE    SPACE               TO  WRK-CONS-PRTKANRI-TBL-GROUP
           MOVE    WRK-SYSYMD          TO
                                       WRK-CONS-PRTKANRI-TBL-GROUP (1:8)
           MOVE    SYS-TIME            TO
                                       WRK-CONS-PRTKANRI-TBL-GROUP (9:)
      *
           MOVE    "CHKMERR"           TO  CHKMERR-FILE-ID
           MOVE    SPA-TERMID          TO  CHKMERR-TERMID
      *
           MOVE    SPACE               TO  WRK-SRTKBN
      *
           EVALUATE    TRUE
           WHEN  ( SPA-GMN-SYU1        =   "T" )
               MOVE    "1"             TO  WRK-SRTKBN
           WHEN  ( SPA-GMN-SYU2        =   "T" )
               MOVE    "2"             TO  WRK-SRTKBN
           WHEN  ( SPA-GMN-SYU3        =   "T" )
               MOVE    "3"             TO  WRK-SRTKBN
           END-EVALUATE
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   WRK-CONS-CHKKBN-MAX )
      *
               IF    ( SPA-GMN-CHKKBN (IDX0)   =   "T" )
                   MOVE    WRK-CONS-CHKKBN (IDX0)
                                       TO  WRK-CHKKBN
                       PERFORM 4901-PRINT-SYORI-SEC
               END-IF
      *
           END-PERFORM
      *
      *    印刷処理
      *
           IF    ( SPA-XID1-FLG        =   "OK" )
      *
               PERFORM 45011-JOBKANRI-HENSYU-SEC
      *
               MOVE    0                   TO  WRK-STPAGE
               MOVE    99999               TO  WRK-EDPAGE
      *
               MOVE    SPACE               TO  SHELLTBL
      *
      *        ファイルデイレクトリ位置指定
               INITIALIZE                  ORCSMKPASSAREA
               MOVE    "scripts/allways/print.sh"
                                           TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
               MOVE    SPACE               TO  LNK-PRTKANRI-AREA
               INITIALIZE                      LNK-PRTKANRI-AREA
               MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                           TO  LNK-PRTKANRI-TBL-KEY
               MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                           TO  LNK-PRTKANRI-TBL-GROUP
               MOVE    ZERO                TO  LNK-PRTKANRI-RENNUM
               MOVE    ZERO                TO  LNK-PRTKANRI-SHORI-RENNUM
               MOVE    SPA-SYSYMD(1:6)     TO  LNK-PRTKANRI-SRYYM
               MOVE    SPA-SYSYMD          TO  LNK-PRTKANRI-SKYYMD
               MOVE    "print.sh"          TO  LNK-PRTKANRI-SHELLID
               MOVE    ZERO                TO  LNK-PRTKANRI-PRIORITY
               MOVE    SPA-TERMID          TO  LNK-PRTKANRI-TERMID
               MOVE    SPA-OPID            TO  LNK-PRTKANRI-OPID
               MOVE    LNK-PRTKANRI-RENNUM TO  SHELLTBL-ARG1
               MOVE    LNK-PRTKANRI-TBL-KEY
                                           TO  SHELLTBL-ARG2
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                           TO  SHELLTBL-ARG3
               MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                           TO  SHELLTBL-ARG4
               MOVE    LNK-PRTKANRI-SRYYM  TO  SHELLTBL-ARG5
               MOVE    LNK-PRTKANRI-SKYYMD TO  SHELLTBL-ARG6
               MOVE    LNK-PRTKANRI-SHELLID
                                           TO  SHELLTBL-ARG7
               MOVE    LNK-PRTKANRI-PRIORITY
                                           TO  SHELLTBL-ARG8
               MOVE    LNK-PRTKANRI-TERMID TO  SHELLTBL-ARG9
               MOVE    LNK-PRTKANRI-OPID   TO  SHELLTBL-ARG10
               MOVE    LNK-PRTKANRI-PRTNM  TO  SHELLTBL-ARG11
      *
               MOVE    CHKMERR             TO  SHELLTBL-ARG12
               MOVE    WRK-CONS-JOB-JOBID  TO  SHELLTBL-ARG13
               MOVE    WRK-CONS-JOB-SHELLID
                                           TO  SHELLTBL-ARG14
               MOVE    WRK-STPAGE          TO  SHELLTBL-ARG15
               MOVE    WRK-EDPAGE          TO  SHELLTBL-ARG16
               MOVE    SHELLTBL            TO  MCPDATA-REC
               MOVE    "SHELL"             TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                           MCPDATA-REC
           END-IF
      *
      *    ＪＯＢＩＤ更新処理
           PERFORM 45012-JOBID-UPD-SEC
      *
           PERFORM 490-KAKUNIN-SEC
      *
           .
       490-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷編集処理
      *****************************************************************
       4901-PRINT-SYORI-SEC            SECTION.
      *
           PERFORM 45011-JOBKANRI-HENSYU-SEC
      *
           MOVE    SPACE           TO  SHELLTBL 
      *
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    "scripts/allways/chkmst.sh"
                                   TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
           MOVE    SPACE           TO  LNK-PRTKANRI-AREA
           INITIALIZE                  LNK-PRTKANRI-AREA
           ADD     1               TO  WRK-PRTKANRI-RENNUM
           MOVE    WRK-PRTKANRI-RENNUM
                                   TO  LNK-PRTKANRI-RENNUM
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                   TO  LNK-PRTKANRI-TBL-KEY 
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                   TO  LNK-PRTKANRI-TBL-GROUP
           MOVE    "000000"        TO  LNK-PRTKANRI-SRYYM
           MOVE    SPA-SYSYMD      TO  LNK-PRTKANRI-SKYYMD
           MOVE    "chkmst.sh"     TO  LNK-PRTKANRI-SHELLID
           MOVE    ZERO            TO  LNK-PRTKANRI-PRIORITY
           MOVE    SPA-TERMID      TO  LNK-PRTKANRI-TERMID
           MOVE    SPA-OPID        TO  LNK-PRTKANRI-OPID
           MOVE    SYS-1031-PRTNM (6)
                                   TO  LNK-PRTKANRI-PRTNM
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  SHELLTBL-ARG1
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  SHELLTBL-ARG2
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  SHELLTBL-ARG3
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  SHELLTBL-ARG4
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  SHELLTBL-ARG5
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  SHELLTBL-ARG6
           MOVE    LNK-PRTKANRI-SHELLID
                                   TO  SHELLTBL-ARG7
           MOVE    LNK-PRTKANRI-PRIORITY
                                   TO  SHELLTBL-ARG8
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SHELLTBL-ARG9
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SHELLTBL-ARG10
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SHELLTBL-ARG11
      *
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG12
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG13
           MOVE    SPA-HOSPID      TO  SHELLTBL-ARG14
           MOVE    WRK-CHKKBN      TO  SHELLTBL-ARG15
           MOVE    WRK-SRTKBN      TO  SHELLTBL-ARG16
           MOVE    SPA-GMN-STSRYCD TO  SHELLTBL-ARG17
           MOVE    SPA-GMN-EDSRYCD TO  SHELLTBL-ARG18
           MOVE    CHKMERR         TO  SHELLTBL-ARG19
      *
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "ERROR MCP-RC=" MCP-RC 
           END-IF
           .
      *
       4501-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ開始セット処理
      *****************************************************************
       45011-JOBKANRI-HENSYU-SEC       SECTION.
      *
           ADD     1               TO  WRK-CONS-JOB-JOBID
      *       
           MOVE    "DEL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
      *
           MOVE    "JBS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           MOVE    SPA-TERMID      TO  JOB-TERMID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
      *
           .
       45011-JOBKANRI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＪＯＢＩＤ更新処理
      *****************************************************************
       45012-JOBID-UPD-SEC    SECTION.
      *
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
      *       
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    ZERO                TO  SYS-3003-STYUKYMD
           MOVE    ALL "9"             TO  SYS-3003-EDYUKYMD
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                       TO  SYS-3003-TBL-KEY
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                       TO  SYS-3003-TBL-GROUP
           MOVE    WRK-CONS-JOB-JOBID  TO  SYS-3003-JOBID
      *
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    "DBUPDATE"      TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"      TO  MCP-FUNC
           END-IF
      *
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          NOT =   ZERO )
               DISPLAY "SYSKANRI 3003  ERR KEY = ["
                                  MCP-RC  " " SYS-3003-KEY  "]"
           END-IF
      *
           .
       45012-JOBID-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
           MOVE    SPACE               TO  X97
           MOVE    ZERO                TO  X97-COUNT
      *
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-3003-REC 
               PERFORM VARYING IDX0 FROM   1   BY  1
                       UNTIL ( IDX0 >      SYS-3003-JOBID )
      *
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX0            TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
                   IF    ( SJOBKANRI-RETURN    =   ZERO )
      *
                       MOVE    JOB-JOBID       TO  X97-RENNUM   (IDX0)
                       MOVE    JOB-SHELLMSG    TO  X97-SHORINM  (IDX0)
                       MOVE    JOB-STARTTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-STARTTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-STARTTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  X97-STARTTIME(IDX0)
                       MOVE    JOB-ENDTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-ENDTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-ENDTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  X97-ENDTIME  (IDX0)
                       MOVE    JOB-UPDCNT      TO  WRK-PAGE
                       MOVE    WRK-PAGE        TO  X97-PAGE     (IDX0)
                       MOVE    JOB-YOBI        TO  X97-ERRMSG   (IDX0)
                       IF    ( JOB-ENDYMD      =   SPACE )
                           MOVE    "処理中です"    TO  X97-MSG
                       ELSE
                           IF    ( JOB-ERRCD   =   SPACE )
                               CONTINUE
                           ELSE
                               MOVE    SPACE   TO  X97-MSG
                               STRING
                                   JOB-YOBI        DELIMITED  BY  SPACE
                                   "【"            DELIMITED  BY  SIZE
                                   JOB-SHELLMSG    DELIMITED  BY  SPACE
                                   "】"            DELIMITED  BY  SIZE
                               INTO    X97-MSG
                               END-STRING
                           END-IF
                       END-IF
                       MOVE    IDX0        TO  X97-COUNT
                   END-IF
               END-PERFORM
           END-IF
      *
           IF    ( X97-MSG             =   SPACE )
               IF    ( X97-COUNT       >   ZERO )
                   MOVE    "処理は正常に終了しました"
                                       TO  X97-MSG
               ELSE
                   MOVE    "該当する処理はありません"
                                       TO  X97-MSG
               END-IF
           END-IF
      *
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "X91"               TO  SPA-MOTOPG
           MOVE    "X97"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "X97"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF    ( SPA-ERRCD       NOT =   SPACE )
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF    ( SPA-XIDCD       NOT =   SPACE )
               EVALUATE    SPA-XIDCD
               WHEN    "1001"
                   PERFORM 540-XID2SET-SEC
                   GO  TO  500-SET-SCREEN-EXT
               WHEN    OTHER
                   PERFORM 520-XIDSET-SEC
                   GO  TO  500-SET-SCREEN-EXT
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "X91    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE                      X91
      *
           MOVE    SPA-GMN-CHKYKZBYO   TO  X91-CHKYKZBYO
           MOVE    SPA-GMN-CHKSRYBYO   TO  X91-CHKSRYBYO
           MOVE    SPA-GMN-CHKYKZHEI   TO  X91-CHKYKZHEI
           MOVE    SPA-GMN-CHKSRYHEI   TO  X91-CHKSRYHEI
           MOVE    SPA-GMN-CHKSRYRANGE TO  X91-CHKSRYRANGE
           MOVE    SPA-GMN-STSRYCD     TO  X91-STSRYCD
           MOVE    SPA-GMN-STSRYNAME   TO  X91-STSRYNAME
           MOVE    SPA-GMN-EDSRYCD     TO  X91-EDSRYCD
           MOVE    SPA-GMN-SYU1        TO  X91-SYU1
           MOVE    SPA-GMN-SYU2        TO  X91-SYU2
           MOVE    SPA-GMN-SYU3        TO  X91-SYU3
      *
           MOVE    "black"             TO  X91-STSRYNAME-STYLE
           IF    ( SPA-NAI-SRYCD-EXSIT-FLG
                                       =   ZERO )
               MOVE    "blue"          TO  X91-STSRYNAME-STYLE
           END-IF
      *
           IF    ( SPA-GMN-CHKSRYRANGE =   "T" )
               MOVE    WIDGET-NORMAL   TO  X91-STSRYCD-STATE
                                           X91-STSRYNAME-STATE
                                           X91-EDSRYCD-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE
                                       TO  X91-STSRYCD-STATE
                                           X91-STSRYNAME-STATE
                                           X91-EDSRYCD-STATE
           END-IF
      *
      *    カーソル位置
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル位置処理
      *****************************************************************
       5001-MAPCUR-SEC                 SECTION.
      *
           IF    ( SPA-ERRCD           =   SPACE )
             AND ( SPA-GMN-CUR         =   ZERO  )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           PERFORM 50012-CUR-SKIP-SEC
      *
           EVALUATE    SPA-GMN-CUR
           WHEN    01
               MOVE    "CHKYKZBYO"     TO  MCP-WIDGET
           WHEN    02
               MOVE    "CHKSRYBYO"     TO  MCP-WIDGET
           WHEN    03
               MOVE    "CHKYKZHEI"     TO  MCP-WIDGET
           WHEN    04
               MOVE    "CHKSRYHEI"     TO  MCP-WIDGET
           WHEN    05
               MOVE    "CHKSRYRANGE"   TO  MCP-WIDGET
           WHEN    06
               MOVE    "STSRYCD"       TO  MCP-WIDGET
           WHEN    07
               MOVE    "EDSRYCD"       TO  MCP-WIDGET
           WHEN    08
               MOVE    "SYU1"          TO  MCP-WIDGET
           WHEN    09
               MOVE    "SYU2"          TO  MCP-WIDGET
           WHEN    10
               MOVE    "SYU3"          TO  MCP-WIDGET
           WHEN    212
               MOVE    "B12"           TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       5011-INPUT-CUR-SEC              SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "CHKYKZBYO"
               MOVE    01              TO  SPA-GMN-CUR
           WHEN    "CHKSRYBYO"
               MOVE    02              TO  SPA-GMN-CUR
           WHEN    "CHKYKZHEI"
               MOVE    03              TO  SPA-GMN-CUR
           WHEN    "CHKSRYHEI"
               MOVE    04              TO  SPA-GMN-CUR
           WHEN    "CHKSRYRANGE"
               MOVE    05              TO  SPA-GMN-CUR
           WHEN    "STSRYCD"
               MOVE    06              TO  SPA-GMN-CUR
           WHEN    "EDSRYCD"
               MOVE    07              TO  SPA-GMN-CUR
           WHEN    "SYU1"
               MOVE    08              TO  SPA-GMN-CUR
           WHEN    "SYU2"
               MOVE    09              TO  SPA-GMN-CUR
           WHEN    "SYU3"
               MOVE    10              TO  SPA-GMN-CUR
           END-EVALUATE
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SYU1"
           WHEN    "SYU2"
           WHEN    "SYU3"
      *
               MOVE    212             TO  SPA-GMN-CUR
           WHEN    OTHER
      *
               COMPUTE SPA-GMN-CUR     =   SPA-GMN-CUR +   1
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *****************************************************************
      *    カーソルスキップ処理
      *****************************************************************
       50012-CUR-SKIP-SEC              SECTION.
      *
           IF    ( SPA-GMN-CUR         =   6 )
               IF   ( X91-STSRYCD-STATE    =   WIDGET-INSENSITIVE )
                   MOVE    8           TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
      *
       50012-CUR-SKIP-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC                  SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "0001"
               MOVE    "開始診療行為コード入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "終了診療行為コード入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0100"
               MOVE    "印刷するチェック項目を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "0101"
               MOVE    "開始診療行為コードを９桁で入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "0102"
               MOVE    "開始診療行為コードが未入力です"
                                       TO  SPA-ERRMSG
           WHEN    "0103"
               MOVE    "終了診療行為コードを９桁で入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "0104"
               MOVE    "診療行為コードの範囲指定に誤りがあります"
                                       TO  SPA-ERRMSG
           WHEN    "0105"
               MOVE    "点数マスタに診療行為コードが登録されていません"
                                       TO  SPA-ERRMSG
           WHEN    "1004"
               MOVE    "ジョブ管理ＤＢが削除できませんでした"
                                       TO  SPA-ERRMSG
           WHEN    "1005"
               MOVE
                   "システム管理ＤＢ（３００３）削除できませんでした"
                                       TO  SPA-ERRMSG
           WHEN    "7777"
               MOVE    WRK-SHORIERR    TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  XERR
           MOVE    SPA-ERRCD           TO  XERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  XERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "X91"               TO  SPA-MOTOPG
           MOVE    "XERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "XERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-XIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-XIDMSG
      *
           EVALUATE    SPA-XIDCD
           WHEN    "6666"
               MOVE    "印刷処理中です"
                                       TO  WRK-XIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  XID1
           MOVE    SPA-XIDCD           TO  XID1-ID1CODE
           MOVE    WRK-XIDMSG          TO  XID1-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "X91"               TO  SPA-MOTOPG
           MOVE    "XID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "XID1"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-XIDSET-EXT.
           EXIT.
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       540-XID2SET-SEC                 SECTION.
      *
           MOVE    SPACE               TO  WRK-XIDMSG
      *
           EVALUATE    SPA-XIDCD
           WHEN    "1001"
               MOVE    "設定内容に従い帳票を印刷します"
                                       TO  WRK-XIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  XID2
           MOVE    SPA-XIDCD           TO  XID2-ID1CODE
           MOVE    WRK-XIDMSG          TO  XID2-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "X91"               TO  SPA-MOTOPG
           MOVE    "XID2"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "XID2"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       540-XID2SET-EXT.
           EXIT.
      *****************************************************************
      *    文字列長チェック（先頭から半角空白があらわれるまで）
      *****************************************************************
       800-LENGTH-CHK-SEC              SECTION.
      *
           MOVE    SPACE           TO  WRK-STR-OUT
           MOVE    1               TO  WRK-STR-LEN
      *
           STRING  WRK-STR-IN      DELIMITED   BY  SPACE
           INTO    WRK-STR-OUT
           WITH    POINTER         WRK-STR-LEN
           END-STRING
      *
           COMPUTE WRK-STR-LEN     =   WRK-STR-LEN     -   1
      *
           .
       800-LENGTH-CHK-EXT.
           EXIT.
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    ZERO        TO  FLG-SYSKANRI
               ELSE
                   MOVE    1           TO  FLG-SYSKANRI
               END-IF
           ELSE
                   MOVE    1           TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
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
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"          TO  MCP-FUNC.
           CALL   "ORCMCPSUB"      USING   MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
