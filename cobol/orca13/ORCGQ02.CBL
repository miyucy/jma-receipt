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
       PROGRAM-ID.                     ORCGQ02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者照会
      *  コンポーネント名  : 検索画面（Ｑ０２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/03/19    MCC−太田　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-森脇     02/06/04+-患者番号の追加
      *              MCC-太田     02/06/06+-最終受診日の検索条件を
      *                                   | 範囲指定式に変更
      *                                   +-総件数取得を行う判定方法変更
      *                                   +-確認画面遷移時の編集を変更
      * 01.00.02     MCC-太田     02/06/26+-ジョブ管理ＤＢ追加
      *                                   +-画面ＱＩＤ１を
      *                                   | Ｑ１００に名称変更
      *                                   +-新たにＱＩＤ１を追加
      *                                   +-削除後の保険情報も抽出対象
      *                                   | としていた不具合を修正
      *                                   +-リストに年齢追加
      *                                   +患者の病名をコードからでなく
      *                                   |名称から行うよう修正
      *                                   +診療行為を診療年月を考慮し
      *                                   |て検索を行うよう修正
      *                                   +保険者番号追加
      *                                   +保険の種類追加
      *                                   +保険（公費）入力時、
      *                                   |同時に診療年月日が入力されて
      *                                   |いた場合はビューを検索する
      *                                   |よう修正
      *                                   +受診履歴は基本情報のみ
      *                                   |条件入力された場合に限り
      *                                   |検索を行う
      *                                   +テスト患者区分を条件に追加
      * 01.00.03     MCC-太田     02/09/12+パスをサブプロから取得
      * 01.00.04     NACL-太田    03/05/26+老人一割、２割を追加
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメータファイル
           SELECT  BQ01-FILE   ASSIGN  PRFNAME
                                   ORGANIZATION    IS  SEQUENTIAL.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
      *    パラメータファイル
       FD  BQ01-FILE.
           COPY    "CPBQ01.INC".
      *
       WORKING-STORAGE                 SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "Q01SCR-SPA".
      *
      *    コンスタント値
           COPY    "ENUM-VALUE".
      *
      *    パラメータファイル名
       01  PRFNAME.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(07)   VALUE   "ORCBQ01".
           03  PRFNAME-TERMID      PIC X(64).
           03  PRFNAME-SYSYMD      PIC X(08).
           03  PRFNAME-SYSTIME     PIC 9(08).
           03  FILLER              PIC X(04)   VALUE   ".TXT".
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-EOF                             PIC 9(01).
           03  FLG-PTINF                           PIC 9(01).
           03  FLG-JYOKEN                          PIC 9(01).
           03  FLG-JYOKEN-AND                      PIC 9(01).
           03  FLG-ENTRYCHK                        PIC 9(01).
           03  FLG-JOBEND                          PIC 9(01).
           03  FLG-HKNKOHSEL                       PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDX-LEN                             PIC 9(05).
           03  IDX-KMK1                            PIC 9(05).
           03  IDX-KMK2                            PIC 9(05).
           03  IDX-KMK3                            PIC 9(05).
           03  IDX-SRT1                            PIC 9(05).
           03  IDX-SRT2                            PIC 9(05).
           03  IDX-SRT3                            PIC 9(05).
           03  IDX-GMN                             PIC 9(05).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-TTL-PTINF                       PIC 9(05).
           03  CNT-JYOKEN                          PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-STR                             PIC X(20000).
           03  WRK-STR-LEN                         PIC 9(05).
           03  WRK-STR-PNT                         PIC 9(05).
           03  WRK-KIGO-LEN                        PIC 9(05).
           03  WRK-NUM-LEN                         PIC 9(05).
           03  WRK-PTINF-ADR-LEN                   PIC 9(05).
           03  WRK-PTINF-BANTI-LEN                 PIC 9(05).
           03  WRK-SQL-TBL-NAME                    PIC X(30).
           03  WRK-SQL-PNT                         PIC 9(05).
           03  WRK-SQL                             PIC X(20000).
           03  WRK-SQL-COUNT                       PIC X(20000).
           03  WRK-STK-PTID                        PIC 9(10).
           03  WRK-STSRYYMD                        PIC X(08).
           03  WRK-EDSRYYMD                        PIC X(08).
           03  WRK-STBIRTHDAY                      PIC X(08).
           03  WRK-EDBIRTHDAY                      PIC X(08).
           03  WRK-STLASTYMD                       PIC X(08).
           03  WRK-EDLASTYMD                       PIC X(08).
           03  WRK-EDPTNUM                         PIC X(20).
           03  WRK-ZZZZ9                           PIC ZZZZ9.
           03  WRK-TOTAL                           PIC ZZZ,ZZZ,ZZ9.
           03  WRK-JYOKEN-PNT                      PIC 9(05).
           03  WRK-JYOKEN-TBL.
               05  WRK-JYOKEN                      PIC X(01)
                                                   OCCURS  5.
           03  WRK-NUM                             PIC 9(10).
           03  WRK-KEKKALST-NO-ST                  PIC 9(05).
           03  WRK-KEKKALST-NO-ED                  PIC 9(05).
           03  WRK-QIDMSG                          PIC X(80).
           03  WRK-KANACHK-MAE-INPUT               PIC X(400).
           03  WRK-PROC-FLG                        PIC 9(1).
           03  WRK-SHORIERR                        PIC X(200).
           03  WRK-CALC-YMD1.
               05  WRK-CALC-YY1                    PIC 9(04).
               05  WRK-CALC-MM1                    PIC 9(02).
               05  WRK-CALC-DD1                    PIC 9(02).
      *
           03  WRK-CALC-YMD2.
               05  WRK-CALC-YY2                    PIC 9(04).
               05  WRK-CALC-MM2                    PIC 9(02).
               05  WRK-CALC-DD2                    PIC 9(02).
           03  WRK-AGE-YY                          PIC S9(04).
           03  WRK-AGE-MM                          PIC S9(02).
           03  WRK-AGE-G.
               05  WRK-AGE-Z                       PIC ---9.
               05  WRK-AGE-MEI                     PIC X(04).
           03  WRK-KJYNYMD                         PIC 9(08).
           03  WRK-MCP-WIDGET                      PIC X(64).
      *
       01  WRK-WIDGET-AREA.
           03  WRK-WIDGET                          PIC X(20).
      *
           03  WRK-WIDGET-R1   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R1-DAMMY1            PIC X(01).
               05  WRK-WIDGET1                     PIC 9(01).
               05  WRK-WIDGET-R1-DAMMY2            PIC X(18).
      *
           03  WRK-WIDGET-R2   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R2-DAMMY1            PIC X(02).
               05  WRK-WIDGET2                     PIC 9(01).
               05  WRK-WIDGET-R2-DAMMY2            PIC X(17).
      *
           03  WRK-WIDGET-R3   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R3-DAMMY1            PIC X(03).
               05  WRK-WIDGET3                     PIC 9(01).
               05  WRK-WIDGET-R3-DAMMY2            PIC X(16).
      *
           03  WRK-WIDGET-R4   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R4-DAMMY1            PIC X(04).
               05  WRK-WIDGET4                     PIC 9(01).
               05  WRK-WIDGET-R4-DAMMY2            PIC X(15).
      *
           03  WRK-WIDGET-R5   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R5-DAMMY1            PIC X(05).
               05  WRK-WIDGET5                     PIC 9(01).
               05  WRK-WIDGET-R5-DAMMY2            PIC X(14).
      *
           03  WRK-WIDGET-R6   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R6-DAMMY1            PIC X(06).
               05  WRK-WIDGET6                     PIC 9(01).
               05  WRK-WIDGET-R6-DAMMY2            PIC X(13).
      *
           03  WRK-WIDGET-R7   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R7-DAMMY1            PIC X(07).
               05  WRK-WIDGET7                     PIC 9(01).
               05  WRK-WIDGET-R7-DAMMY2            PIC X(12).
      *
           03  WRK-WIDGET-R8   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R8-DAMMY1            PIC X(08).
               05  WRK-WIDGET8                     PIC 9(01).
               05  WRK-WIDGET-R8-DAMMY2            PIC X(11).
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-PTINF-MAX     PIC  9(05)  VALUE 50.
           03  CONST-KMK-ITEM-AREA.
               05  FILLER          PIC  X(10)  VALUE "ptnum".
               05  FILLER          PIC  X(10)  VALUE "kananame".
               05  FILLER          PIC  X(10)  VALUE "sex".
               05  FILLER          PIC  X(10)  VALUE "birthday".
               05  FILLER          PIC  X(10)  VALUE "home_adrs".
           03  CONST-KMK-ITEM-R    REDEFINES   CONST-KMK-ITEM-AREA.
               05  CONST-KMK-ITEM  PIC  X(10)  OCCURS  5.
      *
           03  CONST-ORDER-AREA.
               05  FILLER          PIC  X(5)   VALUE "asc".
               05  FILLER          PIC  X(5)   VALUE "desc".
           03  CONST-ORDER-R       REDEFINES   CONST-ORDER-AREA.
               05  CONST-ORDER     PIC  X(5)   OCCURS  2.
      *
           03  CONST-JYOKENMEI-AREA.
               05  FILLER          PIC X(10)   VALUE   "基本情報".
               05  FILLER          PIC X(10)   VALUE   "保険".
               05  FILLER          PIC X(10)   VALUE   "公費".
               05  FILLER          PIC X(10)   VALUE   "病名".
               05  FILLER          PIC X(10)   VALUE   "診療行為".
           03  CONST-JYOKENMEI-R   REDEFINES   CONST-JYOKENMEI-AREA.
               05  CONST-JYOKENMEI PIC X(10)   OCCURS  5.
           03  CONST-SHELNAME      PIC X(100)
               VALUE   "scripts/allways/ORCBQ01.sh".
           03  CONST-LINE                          PIC 9(05)
               VALUE   30.
           03  CONST-JOBID                         PIC 9(07)
               VALUE   1.
           03  CONST-JOB-SHELLID                   PIC X(08)
               VALUE   "ORCBQ01".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者マスタ（照会用コピー句）
       01  QUERY-PTINF-REC.
           COPY    "CPQPTINF.INC".
      *    患者マスタ件数取得用（照会用コピー句）
       01  QUERY-PTINF-CNT-REC.
           COPY    "CPQPTINF-CNT.INC".
      *
      *----(01.00.01) LINE ADD START ----------------------------------
      *    シェルテーブル
           COPY    "CPSHELLTBL.INC".
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    照会用ＳＰＡ領域退避サブ
           COPY    "CPQSUB01.INC".
      *
      *    患者一覧印刷パラメタ
           COPY    "CPORCHC28.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    フィアルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "Q01.INC".
           COPY    "Q02.INC".
      *----(01.00.02) LINE ADD START ----------------------------------
           COPY    "Q97.INC".
      *----(01.00.02) LINE ADD END   ----------------------------------
           COPY    "Q98.INC".
           COPY    "Q99.INC".
      *----(01.00.02) LINE ADD START ----------------------------------
           COPY    "Q100.INC".
      *----(01.00.02) LINE ADD END   ----------------------------------
           COPY    "QERR.INC".
           COPY    "QID1.INC".
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
      *----(01.00.02) LINE ADD START ----------------------------------
           INITIALIZE                  FLG-AREA
                                       IDX-AREA
                                       CNT-AREA
                                       WRK-AREA
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-Q01FREE
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
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF  ( FLG-END           =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-Q01FREE     TO  SPA-FREE
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
                                       IDX-AREA
                                       CNT-AREA
                                       WRK-AREA
      *
      *    エラー画面より
           IF  ( SPA-MOTOPG            =   "QERR" )
               MOVE    SPACE           TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *----(01.00.02) LINE ADD START ----------------------------------
               IF    ( FLG-END         =   1 )
                   GO  TO  100-INIT-EXT
               END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      **** 暫定 ****
               IF  ( SPA-ERRCD                 =   "0001" )
      *            MOVE    "条件に該当する患者は存在しませんでした"
      *                            TO  SPA-GMN-Q02-KEKKALST-SRYACT (16)
                   MOVE    "該当患者は存在しませんでした"
                                   TO  SPA-GMN-Q02-KEKKALST-NAME (16)
                   MOVE    16      TO  SPA-GMN-Q02-KEKKA-MAX
               END-IF
      *
               IF  ( SPA-ERRCD                 =   "9999" )
                   MOVE    "検索条件が多すぎます"
                                   TO  SPA-GMN-Q02-KEKKALST-SRYACT (16)
                   MOVE    16      TO  SPA-GMN-Q02-KEKKA-MAX
               END-IF
      **************
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "Q02"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           MOVE    1               TO  SPA-GMN-Q02-CUR
      *
      *    他のＬＤより
           IF  ( LINKAREA      NOT =   SPACE )
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *----(01.00.02) LINE ADD START ----------------------------------
      *    処理確認画面
           WHEN    "Q97"
               GO  TO      300-SCREEN-EXT
      *    出力指示画面
           WHEN    "Q100"
               PERFORM 3001-Q100SPASET-SEC
               GO  TO      300-SCREEN-EXT
      *----(01.00.02) LINE ADD END   ----------------------------------
      *    確認メッセージ画面
           WHEN    "QID1"
               PERFORM 3001-QID1SPASET-SEC
               GO  TO      300-SCREEN-EXT
      *----(01.00.02) LINE ADD START ----------------------------------
      *    情報削除画面
           WHEN    "XB01"
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    LNK-SCRSPA          TO  SPA-Q01FREE
               GO  TO      300-SCREEN-EXT
      *----(01.00.02) LINE ADD END   ----------------------------------
      *    予約登録
           WHEN    "Y01"
      *    受付一覧
           WHEN    "U01"
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    LNK-SCRSPA          TO  SPA-Q01FREE
      *    患者登録
           WHEN    "P02"
      *
      *        退避しておいたＳＰＡの内容を元に戻す
               INITIALIZE                  QSUB01-LNK
               MOVE    SPA-TERMID      TO  QSUB01-TERMID
               MOVE    "I"             TO  QSUB01-KBN
               CALL    "ORCGQSUB01"    USING   QSUB01-LNK
      *
               MOVE    QSUB01-SPA-AREA TO  SPA-Q01FREE
      *
               GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    MOVE    SPACE               TO  SPA-QIDCD
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           MOVE    SPACE               TO  SPA-Q00-QID-AREA
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    ＱＩＤ１戻りスパ編集処理
      *****************************************************************
       3001-QID1SPASET-SEC             SECTION.
      *
      *
           IF    ( SPA-QID1-FLG    =   "OK" )
               CONTINUE
           ELSE
               INITIALIZE  SPA-Q00-QID-AREA
               GO  TO  3001-QID1SPASET-EXT
           END-IF
      *
           EVALUATE    SPA-QIDCD
           WHEN    "6666"
               MOVE    "JOIN"      TO  MCP-PUTTYPE
               PERFORM 210-BACK-SYORI-SEC
      *
           END-EVALUATE
      *
           INITIALIZE  SPA-Q00-QID-AREA
           .
      *
       3001-QID1SPASET-EXT.
           EXIT.
      *****************************************************************
      *    Ｑ１００戻りスパ編集処理
      *****************************************************************
       3001-Q100SPASET-SEC             SECTION.
      *
           IF  ( SPA-Q02-Q100-RTOK-FLG =   ZERO )
               GO  TO  3001-Q100SPASET-EXT
           END-IF
      *
           MOVE    SPA-TERMID          TO  PRFNAME-TERMID
           MOVE    SPA-SYSYMD          TO  PRFNAME-SYSYMD
           ACCEPT  PRFNAME-SYSTIME     FROM    TIME
      *
           OPEN    OUTPUT              BQ01-FILE
      *
           INITIALIZE                  BQ01
      *
           MOVE    SPA-Q02-Q100-PROC-FLG
                                       TO  BQ01-PROC-FLG
           MOVE    SPA-Q02-Q100-FILENAME
                                       TO  BQ01-CSVFILENAME
           MOVE    SPA-GMN-Q02-HYODAI  TO  BQ01-HYODAI
           MOVE    SPA-GMN-Q02-JYOKEN1 TO  BQ01-JYOKEN1
           MOVE    SPA-GMN-Q02-JYOKEN2 TO  BQ01-JYOKEN2
           MOVE    SPA-Q02-Q100-STPAGE
                                       TO  BQ01-STPAGE
           MOVE    SPA-Q02-Q100-EDPAGE
                                       TO  BQ01-EDPAGE
           MOVE    SPA-Q02-Q100-STKNS  TO  BQ01-STKNS
           MOVE    SPA-Q02-Q100-EDKNS  TO  BQ01-EDKNS
      *
      *    年齢
           IF  (   SPA-Q01-AGE-CALC-KBN    =   ZERO )
               MOVE    SPA-SYSYMD      TO  BQ01-KJYNYMD
           ELSE
               MOVE    SPA-Q01-KJYNYMD TO  BQ01-KJYNYMD
           END-IF
      *
           INITIALIZE                  WRK-SQL
           MOVE    1               TO  WRK-SQL-PNT
           MOVE    ZERO            TO  FLG-JYOKEN-AND
                                       FLG-JYOKEN
           PERFORM 3101-SQL-EDIT-SEC
           MOVE    WRK-SQL             TO  BQ01-SQL
      *
           WRITE   BQ01
      *
           CLOSE   BQ01-FILE
      *
      *    ジョブ開始セット処理
           PERFORM 900-JOBKANRI-HENSYU-SEC
      *
      *    印刷用スクリプト処理
      *
      *    フィアルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    CONST-SHELNAME  TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
           MOVE    SPA-Q02-Q100-PROC-FLG
                                   TO  SHELLTBL-ARG1
           MOVE    SPA-Q02-Q100-FILENAME
                                   TO  SHELLTBL-ARG2
           MOVE    PRFNAME         TO  SHELLTBL-ARG3
           MOVE    PRFNAME-TERMID  TO  SHELLTBL-ARG4
           MOVE    PRFNAME-SYSYMD  TO  SHELLTBL-ARG5
           MOVE    PRFNAME-SYSTIME TO  SHELLTBL-ARG6
           MOVE    CONST-JOBID     TO  SHELLTBL-ARG7
           MOVE    CONST-JOB-SHELLID
                                   TO  SHELLTBL-ARG8
      *
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                   MCPAREA
                                   MCPDATA-REC
      *
      *
           .
       3001-Q100SPASET-EXT.
           EXIT.
      *
      *----(01.00.02) LINE ADD END   ----------------------------------
      *----(01.00.02) LINE DEL START ----------------------------------
      *****************************************************************
      *    ＱＩＤ１戻りスパ編集処理
      *****************************************************************
      *3001-QID1SPASET-SEC             SECTION.
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    EVALUATE    SPA-QIDCD
      *    帳票印刷確認
      *    WHEN    "2001"
      *        PERFORM 30011-PRINT-KAKUNIN-SEC
      *
      *    END-EVALUATE
      *
      *    MOVE    SPACE               TO  SPA-QIDCD
      *----(01.00.01) LINE DEL END   ----------------------------------
      *---- (01.00.01) LINE ADD START ---------------------------------
      *    IF  ( SPA-QID1-RTOK-FLG =   ZERO )
      *        GO  TO  310-QID1SPASET-EXT
      *    END-IF
      *
      *    MOVE    SPA-TERMID          TO  PRFNAME-TERMID
      *    MOVE    SPA-SYSYMD          TO  PRFNAME-SYSYMD
      *    ACCEPT  PRFNAME-SYSTIME     FROM    TIME
      *
      *    OPEN    OUTPUT              BQ01-FILE
      *
      *    INITIALIZE                  BQ01
      *
      *    MOVE    SPA-QID1-PROC-FLG   TO  BQ01-PROC-FLG
      *    MOVE    SPA-QID1-FILENAME   TO  BQ01-CSVFILENAME
      *    MOVE    SPA-GMN-Q02-HYODAI  TO  BQ01-HYODAI
      *    MOVE    SPA-GMN-Q02-JYOKEN1 TO  BQ01-JYOKEN1
      *    MOVE    SPA-GMN-Q02-JYOKEN2 TO  BQ01-JYOKEN2
      *    MOVE    SPA-QID1-STPAGE     TO  BQ01-STPAGE
      *    MOVE    SPA-QID1-EDPAGE     TO  BQ01-EDPAGE
      *    MOVE    SPA-QID1-STKNS      TO  BQ01-STKNS
      *    MOVE    SPA-QID1-EDKNS      TO  BQ01-EDKNS
      *
      *    INITIALIZE                  WRK-SQL
      *    MOVE    1               TO  WRK-SQL-PNT
      *    MOVE    ZERO            TO  FLG-JYOKEN-AND
      *                                FLG-JYOKEN
      *    PERFORM 3101-SQL-EDIT-SEC
      *    MOVE    WRK-SQL             TO  BQ01-SQL
      *
      *    WRITE   BQ01
      *
      *    CLOSE   BQ01-FILE
      *
      *    印刷用スクリプト処理
      *    MOVE    CONST-SHELNAME  TO  SHELLTBL-NAME
      *    MOVE    SPA-QID1-PROC-FLG
      *                            TO  SHELLTBL-ARG1
      *    MOVE    SPA-QID1-FILENAME
      *                            TO  SHELLTBL-ARG2
      *    MOVE    PRFNAME         TO  SHELLTBL-ARG3
      *    MOVE    PRFNAME-TERMID  TO  SHELLTBL-ARG4
      *    MOVE    PRFNAME-SYSYMD  TO  SHELLTBL-ARG5
      *    MOVE    PRFNAME-SYSTIME TO  SHELLTBL-ARG6
      *
      *    MOVE    SHELLTBL        TO  MCPDATA-REC
      *    MOVE    "SHELL"         TO  MCP-FUNC
      *    MOVE    PATH-SHELL-SHELL
      *                            TO  MCP-PATH
      *    CALL    "MCPSUB"        USING
      *                            MCPAREA
      *                            MCPDATA-REC
      *
      *---- (01.00.01) LINE ADD END   ---------------------------------
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    カーソルキー制御項目
      *    MOVE   1                TO  SPA-GMN-Q02-CUR
      *----(01.00.01) LINE DEL END   ----------------------------------
      *
      *    .
      *310-QID1SPASET-EXT.
      *    EXIT.
      *
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE DEL START ----------------------------------
      *****************************************************************
      *    印刷確認戻りスパ編集処理
      *****************************************************************
      *30011-PRINT-KAKUNIN-SEC         SECTION.
      *
      *    IF  ( SPA-QID1-FLG  NOT =   "OK" )
      *        GO  TO  30011-PRINT-KAKUNIN-EXT
      *    END-IF
      *
      *    帳票編集サブ呼出
      *    INITIALIZE  ORCHC28AREA
      *
      *    MOVE    SPA-GMN-Q02-HYODAI
      *                            TO  ORCHC28-HYODAI
      *    MOVE    SPA-GMN-Q02-JYOKEN1
      *                            TO  ORCHC28-JYOKEN1
      *    MOVE    SPA-GMN-Q02-JYOKEN2
      *                            TO  ORCHC28-JYOKEN2
      *
      *    IF  ( SPA-GMN-Q02-TOTAL =   SPACE )
      *        MOVE    ZERO
      *                            TO  ORCHC28-PTID-COUNT
      *    ELSE
      *        MOVE    SPA-GMN-Q02-KEKKA-MAX
      *                            TO  ORCHC28-PTID-COUNT
      *    END-IF
      *
      *    PERFORM VARYING IDX1    FROM    1   BY  1
      *        UNTIL     ( IDX1    >   SPA-GMN-Q02-KEKKA-MAX )
      *
      *        MOVE    SPA-GMN-Q02-KEKKALST-NO (IDX1)
      *                            TO  ORCHC28-PTID-SEQ (IDX1)
      *
      *        MOVE    SPA-GMN-Q02-PTINF-PTID (IDX1)
      *                            TO  ORCHC28-PTID (IDX1)
      *
      *    END-PERFORM
      *
      *    CALL    "ORCHC28"       USING   SPA-AREA
      *                                    ORCHC28AREA
      *    .
      *
      *30011-PRINT-KAKUNIN-EXT.
      *    EXIT.
      *
      *----(01.00.01) LINE DEL END   ----------------------------------
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
      *
           MOVE    SPACE           TO  SPA-Q02
      *
           INITIALIZE                  SPA-Q02
      *
      *----(01.00.01) LINE ADD START ----------------------------------
           MOVE    ZERO            TO  SPA-GMN-Q02-TOTAL-GET-FLG
      *----(01.00.01) LINE ADD END   ----------------------------------
      *    画面編集処理
           PERFORM 310-Q02-GMN-EDIT-SEC
      *
      *    カーソルキー制御項目
           MOVE   1                TO  SPA-GMN-Q02-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       310-Q02-GMN-EDIT-SEC            SECTION.
      *
           INITIALIZE                  WRK-SQL
           MOVE    1               TO  WRK-SQL-PNT
           MOVE    ZERO            TO  FLG-JYOKEN-AND
                                       FLG-JYOKEN
      *
           MOVE    SPACE           TO  SPA-GMN-Q02-KEKKATBL
                                       SPA-GMN-Q02-PTINF-AREA
      *
           INITIALIZE                  SPA-GMN-Q02-KEKKATBL
                                       SPA-GMN-Q02-PTINF-AREA
      *
      *    画面条件編集処理
           PERFORM 3101-JYOKEN-EDIT-SEC
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    IF      ( SPA-Q01-EDSRYYMD  =   ZERO )
      *        MOVE    ALL "9"     TO  WRK-EDSRYYMD
      *    ELSE
      *        MOVE    SPA-Q01-EDSRYYMD
      *                            TO  WRK-EDSRYYMD
      *    END-IF
      *
      *    IF      ( SPA-Q01-EDBIRTHDAY
      *                                =   ZERO )
      *        MOVE    ALL "9"     TO  WRK-EDBIRTHDAY
      *    ELSE
      *        MOVE    SPA-Q01-EDBIRTHDAY
      *                            TO  WRK-EDBIRTHDAY
      *    END-IF
      *----(01.00.01) LINE DEL END   ----------------------------------
      *
      *    ＳＱＬ文編集処理
           PERFORM 3101-SQL-EDIT-SEC
      *
      *
           DISPLAY "WRK-SQL  = " WRK-SQL
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *    暫定 組み立てたＳＱＬが１０００バイトを超えた場合
           MOVE     20000          TO   WRK-STR-LEN
           MOVE     WRK-SQL        TO   WRK-STR
      *
      *
           PERFORM 900-STR-LEN-GET-SEC
           IF  ( WRK-STR-LEN       >    15000 )
      *
      *        ＳＱＬ解析限界値オーバー
               MOVE    "9999"      TO  SPA-ERRCD
               GO  TO  310-Q02-GMN-EDIT-EXT
           END-IF
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *    患者マスタ検索処理
           PERFORM 910-PTINF-SELECT-SEC
      *
           IF  ( FLG-PTINF         =   ZERO )
      *        患者マスタ読込処理
               PERFORM 910-PTINF-READ-SEC
           END-IF
      *
           IF  (   FLG-PTINF       =   1 )
      *
      *        該当なしエラー
               MOVE    "0001"      TO  SPA-ERRCD
      *
      *        患者マスタクローズ処理
               PERFORM 910-PTINF-CLOSE-SEC
      *
               GO  TO  310-Q02-GMN-EDIT-EXT
      *
           END-IF
      *
      *    患者マスタ読み飛ばし処理
           PERFORM 910-PTINF-READ-SKIP-SEC
      *
           PERFORM VARYING IDX-GMN FROM    1   BY  1
               UNTIL   (   IDX-GMN     >   200 )
                OR     (   FLG-PTINF   =   1   )
      *
      *        番号
               COMPUTE WRK-NUM     =   SPA-GMN-Q02-SKIP-KNS
                                   +   IDX-GMN
               MOVE    WRK-NUM     TO  WRK-ZZZZ9
               MOVE    WRK-ZZZZ9   TO  SPA-GMN-Q02-KEKKALST-NO
                                                           (IDX-GMN)
      *---- (01.00.01) LINE ADD START --------------------------------
      *
      *        患者番号
               MOVE    QUERY-PTINF-PTNUM 
                                   TO  SPA-GMN-Q02-KEKKALST-PTNUM
                                                           (IDX-GMN)
      *---- (01.00.01) LINE ADD END ----------------------------------
      *
      *        氏名
               MOVE    QUERY-PTINF-NAME
                                   TO  SPA-GMN-Q02-KEKKALST-NAME
                                                           (IDX-GMN)
      *        性別
               EVALUATE    QUERY-PTINF-SEX
               WHEN    "1"
                   MOVE    "男"    TO  SPA-GMN-Q02-KEKKALST-SEX
                                                           (IDX-GMN)
               WHEN    "2"
                   MOVE    "女"    TO  SPA-GMN-Q02-KEKKALST-SEX
                                                           (IDX-GMN)
               END-EVALUATE
      *
      *        誕生日
               INITIALIZE              ORCSGDAYAREA
               MOVE    QUERY-PTINF-BIRTHDAY
                                   TO  SGDAY-INDAY
               CALL    "ORCSGDAY"      USING
                                       ORCSGDAYAREA
               IF  ( SGDAY-RC          =   ZERO )
                   MOVE    SGDAY-OTDAY
                               TO  SPA-GMN-Q02-KEKKALST-BIRTH (IDX-GMN)
               ELSE
                   MOVE    SPACE
                               TO  SPA-GMN-Q02-KEKKALST-BIRTH (IDX-GMN)
               END-IF
      *
      *---- (01.00.02) LINE ADD START --------------------------------
      *        年齢
               IF  (   SPA-Q01-AGE-CALC-KBN    =   ZERO )
                   MOVE    SPA-SYSYMD      TO  WRK-KJYNYMD
               ELSE
                   MOVE    SPA-Q01-KJYNYMD TO  WRK-KJYNYMD
               END-IF
      *
               IF  (   QUERY-PTINF-BIRTHDAY    <   WRK-KJYNYMD )
                   MOVE    QUERY-PTINF-BIRTHDAY
                                           TO  WRK-CALC-YMD1
                   MOVE    WRK-KJYNYMD     TO  WRK-CALC-YMD2
                   PERFORM 3101-AGE-CALC-SEC
               ELSE
                   MOVE    WRK-KJYNYMD     TO  WRK-CALC-YMD1
                   MOVE    QUERY-PTINF-BIRTHDAY
                                           TO  WRK-CALC-YMD2
                   PERFORM 3101-AGE-CALC-SEC
                   COMPUTE WRK-AGE-YY   =   WRK-AGE-YY
                                           *   -1
                   COMPUTE WRK-AGE-MM   =   WRK-AGE-MM
                                           *   -1
               END-IF
      *
               IF    ( WRK-AGE-YY          =   ZERO )
                   MOVE    WRK-AGE-MM      TO  WRK-AGE-Z
                   MOVE    "ヶ月"          TO  WRK-AGE-MEI
               ELSE
                   MOVE    WRK-AGE-YY      TO  WRK-AGE-Z
                   MOVE    "歳"            TO  WRK-AGE-MEI
               END-IF
      *
               MOVE    WRK-AGE-G           TO  SPA-GMN-Q02-KEKKALST-AGE
                                                               (IDX-GMN)
      *
      *---- (01.00.02) LINE ADD START --------------------------------
      *
      *        診療内容（住所を表示）
               MOVE    QUERY-PTINF-HOME-ADRS
                                       TO  WRK-STR
      *
      *        住所の項目長を求める
               MOVE    1               TO  WRK-STR-LEN
               MOVE    SPACE           TO  WRK-STR
               STRING  QUERY-PTINF-HOME-ADRS   DELIMITED   BY  SIZE
               INTO    WRK-STR
               WITH POINTER WRK-STR-LEN
               END-STRING
               COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *        住所の実際の文字列長を求める
               MOVE    QUERY-PTINF-HOME-ADRS TO  WRK-STR
               PERFORM 900-STR-LEN-GET-SEC
               MOVE    WRK-STR-LEN           TO  WRK-PTINF-ADR-LEN
      *
      *        番地の項目長を求める
               MOVE    1               TO  WRK-STR-LEN
               MOVE    SPACE           TO  WRK-STR
               STRING  QUERY-PTINF-HOME-BANTI  DELIMITED   BY  SIZE
               INTO    WRK-STR
               WITH POINTER WRK-STR-LEN
               END-STRING
               COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *        番地の実際の文字列長を求める
               MOVE    QUERY-PTINF-HOME-BANTI  TO  WRK-STR
               PERFORM 900-STR-LEN-GET-SEC
               MOVE    WRK-STR-LEN         TO  WRK-PTINF-BANTI-LEN
      *
               MOVE    1                   TO  WRK-STR-PNT
               IF  ( WRK-PTINF-ADR-LEN     >   0)
                   STRING  QUERY-PTINF-HOME-ADRS 
                                   (1: WRK-PTINF-ADR-LEN)
                                           DELIMITED   BY  SIZE
                           "　"            DELIMITED   BY  SIZE
                   INTO    SPA-GMN-Q02-KEKKALST-SRYACT (IDX-GMN)
                   WITH    POINTER WRK-STR-PNT
                   END-STRING
               END-IF
      *
               IF  ( WRK-PTINF-BANTI-LEN   >   0)
                   STRING  QUERY-PTINF-HOME-BANTI 
                                   (1: WRK-PTINF-BANTI-LEN)
                                           DELIMITED   BY  SIZE
                   INTO    SPA-GMN-Q02-KEKKALST-SRYACT  (IDX-GMN)
                   WITH    POINTER WRK-STR-PNT
                   END-STRING
               END-IF
      *
               MOVE    IDX-GMN     TO  SPA-GMN-Q02-KEKKA-MAX
      *
      *        患者ＩＤ
               MOVE    QUERY-PTINF-PTID
                                   TO  SPA-GMN-Q02-PTINF-PTID (IDX-GMN)
      *
      *        患者マスタ読込処理
               PERFORM 910-PTINF-READ-SEC
      *
           END-PERFORM
      *
      *    総件数編集
      *----(01.00.01) LINE DEL START ----------------------------------
      *    IF  ( SPA-GMN-Q02-SKIP-KNS  =   ZERO )
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           IF  ( SPA-GMN-Q02-TOTAL-GET-FLG =   ZERO )
               MOVE    1              TO   SPA-GMN-Q02-TOTAL-GET-FLG
      *----(01.00.01) LINE ADD END   ----------------------------------
               PERFORM 3101-TOTAL-KNS-EDIT-SEC
           END-IF
      *
           MOVE   FLG-PTINF           TO  SPA-GMN-Q02-FLG-PTINF
      *----(01.00.01) LINE ADD START ----------------------------------
      *    前頁ボタン活性編集
           IF  ( SPA-GMN-Q02-SKIP-KNS      >   0 )
               MOVE    WIDGET-NORMAL       TO  SPA-GMN-Q02-B06-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE  TO  SPA-GMN-Q02-B06-STATE
           END-IF
      *    次頁ボタン活性編集
           IF  ( SPA-GMN-Q02-FLG-PTINF     =   0 )
               MOVE    WIDGET-NORMAL       TO  SPA-GMN-Q02-B07-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE  TO  SPA-GMN-Q02-B07-STATE
           END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *    患者マスタクローズ処理
           PERFORM 910-PTINF-CLOSE-SEC
      *
           .
       310-Q02-GMN-EDIT-EXT.
           EXIT.
      *---- (01.00.02) LINE ADD START --------------------------------
      *****************************************************************
      *    年齢計算処理
      *****************************************************************
       3101-AGE-CALC-SEC               SECTION.
      *
           COMPUTE WRK-AGE-YY          =   WRK-CALC-YY2
                                       -   WRK-CALC-YY1
           IF    ( WRK-CALC-YMD1(5:4)  >   WRK-CALC-YMD2(5:4) )
               COMPUTE WRK-AGE-YY      =   WRK-AGE-YY
                                       -   1
               COMPUTE WRK-AGE-MM      =  (WRK-CALC-MM2    +   12 )
                                       -   WRK-CALC-MM1
           ELSE
               COMPUTE WRK-AGE-MM      =   WRK-CALC-MM2
                                       -   WRK-CALC-MM1
           END-IF
           IF    ( WRK-CALC-DD1        >   WRK-CALC-DD2 )
               COMPUTE WRK-AGE-MM      =   WRK-AGE-MM
                                       -   1
           END-IF
           .
      *
       3101-AGE-CALC-EXT.
           EXIT.
      *---- (01.00.02) LINE ADD END   --------------------------------
      *****************************************************************
      *    条件編集処理
      *****************************************************************
       3101-JYOKEN-EDIT-SEC            SECTION.
      *
           MOVE    SPACE           TO  SPA-GMN-Q02-JYOKEN1
                                       WRK-JYOKEN-TBL
           MOVE    1               TO  WRK-JYOKEN-PNT
      *
           IF  ( SPA-Q01-GTBL (1)  =   "1" )
            OR ( SPA-Q01-GTBL (2)  =   "1" )
            OR ( SPA-Q01-GTBL (3)  =   "1" )
            OR ( SPA-Q01-GTBL (7)  =   "1" )
            OR ( SPA-Q01-GTBL (8)  =   "1" )
               MOVE    "1"         TO  WRK-JYOKEN (1)
           END-IF
      *
           IF  ( SPA-Q01-GTBL (4)  =   "1" )
               MOVE    "1"         TO  WRK-JYOKEN (4)
           END-IF
      *
           IF  ( SPA-Q01-GTBL (5)  =   "1" )
               MOVE    "1"         TO  WRK-JYOKEN (2)
           END-IF
      *
           IF  ( SPA-Q01-GTBL (6)  =   "1" )
               MOVE    "1"         TO  WRK-JYOKEN (3)
           END-IF
      *
           IF  ( SPA-Q01-GTBL (9)  =   "1" )
               MOVE    "1"         TO  WRK-JYOKEN (5)
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF   ( WRK-JYOKEN (IDX1)        =   "1" )
                   IF   ( SPA-GMN-Q02-JYOKEN1  =   SPACE )
                       STRING  CONST-JYOKENMEI (IDX1)
                                                   DELIMITED   BY  SPACE
                       INTO    SPA-GMN-Q02-JYOKEN1
                       WITH    POINTER     WRK-JYOKEN-PNT
                       END-STRING
                   ELSE
                       STRING  "、"                DELIMITED   BY  SIZE
                               CONST-JYOKENMEI (IDX1)
                                                   DELIMITED   BY  SPACE
                       INTO    SPA-GMN-Q02-JYOKEN1
                       WITH    POINTER     WRK-JYOKEN-PNT
                       END-STRING
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
      *
       3101-JYOKEN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    総件数編集処理
      *****************************************************************
       3101-TOTAL-KNS-EDIT-SEC             SECTION.
      *
           IF      ( FLG-PTINF         =   "1" )
               COMPUTE WRK-NUM =   IDX-GMN     -   1
               MOVE    WRK-NUM         TO  WRK-TOTAL
      *----(01.00.01) LINE ADD START ----------------------------------
                                           SPA-GMN-Q02-TOTAL-NUM
      *----(01.00.01) LINE ADD END   ----------------------------------
           ELSE
      *        検索結果件数を取得
      *        INITIALIZE                  MCPAREA
               MOVE    PATH-QUERY-PTINF-CNT-KEY
                                           TO  MCP-PATH
               MOVE    SPACE               TO  QUERY-PTINF-CNT-REC
               MOVE    WRK-SQL-COUNT       TO  QUERY-PTINF-CNT-SQL
               MOVE    QUERY-PTINF-CNT-REC TO  MCPDATA-REC
               PERFORM 910-DB-SELECT-SEC
               IF  (   MCP-RC          NOT =   ZERO    )
                   MOVE    SPACE       TO  SPA-GMN-Q02-TOTAL
                   GO  TO  3101-TOTAL-KNS-EDIT-EXT
               END-IF
      *
               MOVE    MCPDATA-REC     TO  QUERY-PTINF-CNT-REC
               MOVE    QUERY-PTINF-CNT-TOTAL
                                       TO  WRK-TOTAL
      *----(01.00.01) LINE ADD START ----------------------------------
                                           SPA-GMN-Q02-TOTAL-NUM
      *----(01.00.01) LINE ADD END   ----------------------------------
           END-IF
      *
      *    左詰で編集を行う
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL ( IDX1    >   11 )
                OR   ( WRK-TOTAL (IDX1 : 1)    NOT =   SPACE )
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF  ( IDX1         <=   11 )
               MOVE    SPACE   TO  SPA-GMN-Q02-TOTAL
               STRING  "総件数："          DELIMITED   BY    SIZE
                       WRK-TOTAL (IDX1 : ) DELIMITED   BY    SIZE
               INTO    SPA-GMN-Q02-TOTAL
               END-STRING
           END-IF
      *
           .
      *
       3101-TOTAL-KNS-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                           SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *    患者登録へ
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 480-KANJYA-SEC
      *    前頁
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 210-MAE-PAGE-SEC
      *    次頁
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 210-TUGI-PAGE-SEC
      *----(01.00.02) LINE ADD START ----------------------------------
      *    情報削除
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 480-JYOUHOU-DEL-SEC
      *----(01.00.02) LINE ADD END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
      *    ＣＳＶ確認
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 480-CSV-KAKUNIN-SEC
      *----(01.00.01) LINE ADD END   ----------------------------------
      *    印刷確認
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 480-PRINT-KAKUNIN-SEC
      *----(01.00.02) LINE ADD START ----------------------------------
      *    処理確認画面
               WHEN    "CLICKED"       ALSO    "B24"
                   PERFORM 490-KAKUNIN-SEC
      *----(01.00.02) LINE ADD END   ----------------------------------
      *    予約登録へ
      * xx     WHEN    "CLICKED"       ALSO    "B10"
      * xx         PERFORM 480-YOYAKU-SEC
      *    受付一覧へ
      * xx     WHEN    "CLICKED"       ALSO    "B11"
      * xx         PERFORM 490-UKEICHI-SEC
           END-EVALUATE
      *
           .
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                             SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"      ALSO    "HYODAI"
      *            表題チェック
                   MOVE    MCP-WIDGET  TO  WRK-WIDGET
                   PERFORM 4100-HYODAI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "JYOKEN1"
      *            条件上段チェック
                   MOVE    MCP-WIDGET  TO  WRK-WIDGET
                   PERFORM 4101-JYOKEN1-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "JYOKEN2"
      *            条件下段チェック
                   MOVE    MCP-WIDGET  TO  WRK-WIDGET
                   PERFORM 4102-JYOKEN2-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
      *            選択番号チェック
                   MOVE    MCP-WIDGET  TO  WRK-WIDGET
                   PERFORM 4102-SELUM-CHK-SEC
      *        行選択
               WHEN    ANY             ALSO    "KEKKALST"
                   PERFORM 4102-KEKKALSTSEL-SEC
           END-EVALUATE
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＳＱＬ文編集処理
      *****************************************************************
       3101-SQL-EDIT-SEC               SECTION.
      *
      *----(01.00.01) LINE ADD START ----------------------------------
           IF      ( SPA-Q01-STSRYYMD  =   SPACE )
               MOVE    ALL "0"     TO  WRK-STSRYYMD
           ELSE
               MOVE    SPA-Q01-STSRYYMD
                                   TO  WRK-STSRYYMD
           END-IF
      *
           IF      ( SPA-Q01-EDSRYYMD  =   SPACE )
               MOVE    ALL "9"     TO  WRK-EDSRYYMD
           ELSE
               MOVE    SPA-Q01-EDSRYYMD
                                   TO  WRK-EDSRYYMD
           END-IF
      *
           IF      ( SPA-Q01-STBIRTHDAY
                                       =   SPACE )
               MOVE    ALL "0"     TO  WRK-STBIRTHDAY
           ELSE
               MOVE    SPA-Q01-STBIRTHDAY
                                   TO  WRK-STBIRTHDAY
           END-IF
      *
           IF      ( SPA-Q01-EDBIRTHDAY
                                       =   SPACE )
               MOVE    ALL "9"     TO  WRK-EDBIRTHDAY
           ELSE
               MOVE    SPA-Q01-EDBIRTHDAY
                                   TO  WRK-EDBIRTHDAY
           END-IF
      *
           IF      ( SPA-Q01-STLASTYMD =   SPACE )
               MOVE    ALL "0"     TO  WRK-STLASTYMD
           ELSE
               MOVE    SPA-Q01-STLASTYMD
                                   TO  WRK-STLASTYMD
           END-IF
      *
           IF      ( SPA-Q01-EDLASTYMD =   SPACE )
               MOVE    ALL "9"     TO  WRK-EDLASTYMD
           ELSE
               MOVE    SPA-Q01-EDLASTYMD
                                   TO  WRK-EDLASTYMD
           END-IF
      *
           IF      ( SPA-Q01-EDPTNUM   =   SPACE )
               MOVE    ALL "Z"     TO  WRK-EDPTNUM
           ELSE
               MOVE    SPA-Q01-EDPTNUM
                                   TO  WRK-EDPTNUM
           END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *    最終受診日
           IF  ( SPA-Q01-GTBL (3)  =   "1" )
               STRING  ",tbl_srykarrk b"       DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
      *    病名コード
           IF  ( SPA-Q01-GTBL (4)  =   "1" )
               STRING  ",tbl_ptbyomei c"       DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *    保険記号・番号
      *    IF   ( SPA-Q01-GTBL (5)  =   "1" )
      *        STRING  ",tbl_pthkninf d"       DELIMITED  BY  SIZE
      *        INTO    WRK-SQL
      *        WITH    POINTER WRK-SQL-PNT
      *        END-STRING
      *    END-IF
      *
      *    公費保険記号番号・負担者番号
      *    IF   ( SPA-Q01-GTBL (6)  =   "1" )
      *        STRING  ",tbl_ptkohinf e"       DELIMITED  BY  SIZE
      *        INTO    WRK-SQL
      *        WITH    POINTER WRK-SQL-PNT
      *        END-STRING
      *    END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           IF      ((  SPA-Q01-GTBL (5)    =   "1" )
                OR  (  SPA-Q01-GTBL (6)    =   "1" ))
            AND    (   SPA-Q01-GTBL (8)    =   "1" )
               STRING  ",view_Q001 i"          DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           ELSE
      *        保険記号・番号
               IF   ( SPA-Q01-GTBL (5)  =   "1" )
                   STRING  ",tbl_pthkninf d"   DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
      *
      *        公費保険記号番号・負担者番号
               IF   ( SPA-Q01-GTBL (6)  =   "1" )
                   STRING  ",tbl_ptkohinf e"   DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    診察年月日
           IF   ( SPA-Q01-GTBL (8)  =   "1" )
      *----(01.00.02) LINE DEL START ----------------------------------
      *        STRING  ",tbl_jyurrk f"         DELIMITED  BY  SIZE
      *        INTO    WRK-SQL
      *        WITH    POINTER WRK-SQL-PNT
      *        END-STRING
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
               IF    ( SPA-Q01-GTBL (4)  =   "1" )
                OR   ( SPA-Q01-GTBL (5)  =   "1" )
                OR   ( SPA-Q01-GTBL (6)  =   "1" )
                OR   ( SPA-Q01-GTBL (9)  =   "1" )
                   CONTINUE
               ELSE
                   STRING  ",tbl_jyurrk f"         DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
           END-IF
      *
      *    診療行為コード
           IF   ( SPA-Q01-GTBL (9)  =   "1" )
               STRING  ",tbl_sryact g"         DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           STRING  " where a.hospid='"         DELIMITED  BY   SIZE
                   SPA-HOSPID                   DELIMITED  BY  SIZE
                   "' and "                     DELIMITED  BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER WRK-SQL-PNT
           END-STRING
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    患者番号
      *    IF  ( SPA-Q01-GTBL (1)  =   "1" )
      *        MOVE    ZERO            TO  FLG-JYOKEN-AND
      *        PERFORM     3101-PTINF-SQL-EDIT1-SEC
      *        MOVE    1               TO  FLG-JYOKEN
      *    END-IF
      *----(01.00.01) LINE DEL END   ----------------------------------
      *
      *    カナ氏名・漢字氏名
           IF  ( SPA-Q01-GTBL (2)  =   "1" )
               MOVE    FLG-JYOKEN      TO  FLG-JYOKEN-AND
               PERFORM     3101-PTINF-SQL-EDIT2-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    最終受診日
           IF  ( SPA-Q01-GTBL (3)  =   "1" )
               MOVE    ZERO            TO  FLG-JYOKEN-AND
               PERFORM     3101-SRYKARRK-SQL-EDIT-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    病名コード
           IF  ( SPA-Q01-GTBL (4)  =   "1" )
               MOVE    ZERO            TO  FLG-JYOKEN-AND
               PERFORM     3101-PTBYOMEI-SQL-EDIT-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    保険記号・番号
           IF   ( SPA-Q01-GTBL (5)  =   "1" )
      *----(01.00.02) LINE ADD START ----------------------------------
               IF    ( SPA-Q01-GTBL (8)    =   "1" )
                   MOVE    "1"         TO  FLG-HKNKOHSEL
               ELSE
                   MOVE    ZERO        TO  FLG-HKNKOHSEL
               END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
               MOVE    ZERO            TO  FLG-JYOKEN-AND
               PERFORM     3101-PTHKNINF-SQL-EDIT-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    公費保険記号番号・負担者番号
           IF   ( SPA-Q01-GTBL (6)  =   "1" )
      *----(01.00.02) LINE ADD START ----------------------------------
               IF    ( SPA-Q01-GTBL (8)    =   "1" )
                   MOVE    "1"         TO  FLG-HKNKOHSEL
               ELSE
                   MOVE    ZERO        TO  FLG-HKNKOHSEL
               END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
               MOVE    ZERO            TO  FLG-JYOKEN-AND
               PERFORM     3101-PTKOHINF-SQL-EDIT-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *    生年月日・性別・住所・コメント
           IF   ( SPA-Q01-GTBL (7)  =   "1" )
               MOVE    FLG-JYOKEN      TO  FLG-JYOKEN-AND
               PERFORM     3101-PTINF-SQL-EDIT3-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    テスト患者区分
           IF    ( SPA-Q01-CHKTSTPT    =   "F" )
               MOVE    FLG-JYOKEN      TO  FLG-JYOKEN-AND
               PERFORM     3101-PTINF-SQL-EDIT4-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *----(01.00.02) LINE DEL END   ----------------------------------
      *
      *    診察年月日
           IF   ( SPA-Q01-GTBL (8)  =   "1" )
      *----(01.00.02) LINE DEL START ----------------------------------
      *        MOVE    ZERO            TO  FLG-JYOKEN-AND
      *        PERFORM     3101-JYURRK-SQL-EDIT-SEC
      *        MOVE    1               TO  FLG-JYOKEN
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
               IF    ( SPA-Q01-GTBL (4)  =   "1" )
                OR   ( SPA-Q01-GTBL (5)  =   "1" )
                OR   ( SPA-Q01-GTBL (6)  =   "1" )
                OR   ( SPA-Q01-GTBL (9)  =   "1" )
                   CONTINUE
               ELSE
                   MOVE    ZERO            TO  FLG-JYOKEN-AND
                   PERFORM     3101-JYURRK-SQL-EDIT-SEC
                   MOVE    1               TO  FLG-JYOKEN
               END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
           END-IF
      *
      *    診療行為コード
           IF   ( SPA-Q01-GTBL (9)  =   "1" )
               MOVE    ZERO            TO  FLG-JYOKEN-AND
               PERFORM     3101-SRYACT-SQL-EDIT-SEC
               MOVE    1               TO  FLG-JYOKEN
           END-IF
      *
      *----(01.00.01) LINE ADD START ----------------------------------
      *    患者番号
           MOVE    ZERO            TO  FLG-JYOKEN-AND
           PERFORM 3101-PTNUM-SQL-EDIT-SEC
           MOVE    1               TO  FLG-JYOKEN
      *----(01.00.01) LINE ADD END   ----------------------------------
      *    総件数取得用にＳＱＬ文を退避
           MOVE    WRK-SQL         TO  WRK-SQL-COUNT
      *
      *    並べ替え順編集処理
           PERFORM 3102-ORDER-EDIT-SEC
      *
           .
       3101-SQL-EDIT-SEC-EXT.
           EXIT.
      *----(01.00.01) LINE DEL START ----------------------------------
      *****************************************************************
      *    患者マスタ検索条件編集処理１
      *****************************************************************
      *3101-PTINF-SQL-EDIT1-SEC        SECTION.
      *
      *    患者ＩＤ検索条件編集処理
      *    PERFORM 3102-PTID-SELECT-EDIT-SEC
      *
      *    .
      *3101-PTINF-SQL-EDIT1-EXT.
      *    EXIT.
      *----(01.00.01) LINE DEL END   ----------------------------------
      *****************************************************************
      *    患者マスタ検索条件編集処理２
      *****************************************************************
       3101-PTINF-SQL-EDIT2-SEC        SECTION.
      *
      *    カナ氏名検索条件編集処理
           PERFORM 3102-KANANAME-SELECT-EDIT-SEC
      *
      *    漢字氏名検索条件編集処理
           PERFORM 3102-NAME-SELECT-EDIT-SEC
      *
           .
       3101-PTINF-SQL-EDIT2-EXT.
           EXIT.
      *****************************************************************
      *    患者マスタ検索条件編集処理３
      *****************************************************************
       3101-PTINF-SQL-EDIT3-SEC        SECTION.
      *
      *    生年月日検索条件編集処理
           PERFORM 3102-BIRTH-SELECT-EDIT-SEC
      *
      *    性別検索条件編集処理
           PERFORM 3102-SEX-SELECT-EDIT-SEC
      *
      *    住所検索条件編集処理
           PERFORM 3102-HOME-ADRS-SELECT-EDIT-SEC
      *
      *    コメント検索条件編集処理
           PERFORM 3102-COMMENT-SELECT-EDIT-SEC
      *
           .
       3101-PTINF-SQL-EDIT3-EXT.
           EXIT.
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    患者マスタ検索条件編集処理４
      *****************************************************************
       3101-PTINF-SQL-EDIT4-SEC        SECTION.
      *
          MOVE     1               TO  CNT-JYOKEN
      *
          PERFORM  900-SQL-JYOKEN-EDIT2-SEC
      *
          STRING   "(a.tstptnumkbn <> '1')"    DELIMITED   BY  SIZE
          INTO     WRK-SQL
          WITH     POINTER     WRK-SQL-PNT
          END-STRING
      *
          PERFORM  900-SQL-JYOKEN-EDIT3-SEC
           .
       3101-PTINF-SQL-EDIT4-EXT.
           EXIT.
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    診療科履歴マスタ検索条件編集処理
      *****************************************************************
       3101-SRYKARRK-SQL-EDIT-SEC      SECTION.
      *
           MOVE    "b"             TO  WRK-SQL-TBL-NAME
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *    最終受診日検索条件編集
      *----(01.00.01) LINE DEL START ----------------------------------
      *    STRING  "(b.lastymd = '"            DELIMITED   BY  SIZE
      *            SPA-Q01-LASTYMD             DELIMITED   BY  SIZE
      *            "')"                        DELIMITED   BY  SIZE
      *    INTO    WRK-SQL
      *    WITH    POINTER     WRK-SQL-PNT
      *    END-STRING
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           STRING  "((b.lastymd >= '"          DELIMITED   BY  SIZE
                   WRK-STLASTYMD               DELIMITED   BY  SIZE
                   "') and "                   DELIMITED   BY  SIZE
                   "(b.lastymd <= '"           DELIMITED   BY  SIZE
                   WRK-EDLASTYMD               DELIMITED   BY  SIZE
                   "'))"                       DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
      *
           .
       3101-SRYKARRK-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    患者病名マスタ検索条件編集処理
      *****************************************************************
       3101-PTBYOMEI-SQL-EDIT-SEC          SECTION.
      *
           MOVE    "c"             TO  WRK-SQL-TBL-NAME
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *    STRING "((c.sryymd >= '"
      *           WRK-STSRYYMD
      *           "') and (c.sryymd <= '"
      *           WRK-EDSRYYMD
      *           "')) and"
      *    DELIMITED   BY  SIZE
      *    INTO        WRK-SQL
      *    WITH POINTER WRK-SQL-PNT
      *    END-STRING
      *
           STRING "(((c.sryymd <= '"
                  WRK-EDSRYYMD
                  "') and (c.tenkiymd >= '"
                  WRK-STSRYYMD
                  "')) or "
                  "((c.sryymd <= '"
                  WRK-EDSRYYMD
                  "') and (c.tenkiymd = '        '"
                  "))) and "
           DELIMITED   BY  SIZE
           INTO        WRK-SQL
           WITH POINTER WRK-SQL-PNT
           END-STRING
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *        IF  ( SPA-Q01-BYOMEICD (IDX1)   NOT =   SPACE )
      *            COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
      *            PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            IF  ( SPA-Q01-USERBYOMEIFLG (IDX1)  =   "1" )
      *
      *                自院病名コードの場合
      *                STRING
      *                    "(c.byomeiinputcd = '"  DELIMITED   BY  SIZE
      *                    SPA-Q01-BYOMEICD (IDX1) DELIMITED   BY  SPACE
      *                    "')"                    DELIMITED   BY  SIZE
      *                INTO    WRK-SQL
      *                WITH    POINTER WRK-SQL-PNT
      *                END-STRING
      *            ELSE
      *
      *                病名コードの場合
      *                STRING
      *                    "(c.byomeicd_1 = '"     DELIMITED   BY  SIZE
      *                    SPA-Q01-BYOMEICD (IDX1) DELIMITED   BY  SPACE
      *                    "') or"                 DELIMITED   BY  SIZE
      *                    "(c.byomeicd_2 = '"     DELIMITED   BY  SIZE
      *                    SPA-Q01-BYOMEICD (IDX1) DELIMITED   BY  SPACE
      *                    "') or"                 DELIMITED   BY  SIZE
      *                    "(c.byomeicd_3 = '"     DELIMITED   BY  SIZE
      *                    SPA-Q01-BYOMEICD (IDX1) DELIMITED   BY  SPACE
      *                    "') or"                 DELIMITED   BY  SIZE
      *                    "(c.byomeicd_4 = '"     DELIMITED   BY  SIZE
      *                    SPA-Q01-BYOMEICD (IDX1) DELIMITED   BY  SPACE
      *                    "') or"                 DELIMITED   BY  SIZE
      *                    "(c.byomeicd_5 = '"     DELIMITED   BY  SIZE
      *                    SPA-Q01-BYOMEICD (IDX1) DELIMITED   BY  SPACE
      *                    "') or"                 DELIMITED   BY  SIZE
      *                    "(c.byomeicd_6 = '"     DELIMITED   BY  SIZE
      *                    SPA-Q01-BYOMEICD (IDX1) DELIMITED   BY  SPACE
      *                    "')"                    DELIMITED   BY  SIZE
      *                INTO    WRK-SQL
      *                WITH    POINTER WRK-SQL-PNT
      *                END-STRING
      *            END-IF
      *        END-IF
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE DEL START ----------------------------------
               IF  ( SPA-Q01-BYOMEI (IDX1)   NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            病名の項目長を求める
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-BYOMEI (IDX1)
                                               DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            病名の実際の文字列長を求める
                   MOVE    SPA-Q01-BYOMEI (IDX1)
                                               TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
                   MOVE    WRK-STR-LEN         TO  WRK-NUM-LEN
      *
                   STRING
                       "(c.byomei like '"      DELIMITED   BY  SIZE
                       SPA-Q01-BYOMEI (IDX1)   DELIMITED   BY  SPACE
                       "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
      *----(01.00.02) LINE DEL END   ----------------------------------
      *
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       3101-PTBYOMEI-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    患者保険マスタ検索条件編集処理
      *****************************************************************
       3101-PTHKNINF-SQL-EDIT-SEC      SECTION.
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    MOVE    "d"             TO  WRK-SQL-TBL-NAME
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           IF    ( FLG-HKNKOHSEL   =   ZERO )
               MOVE    "d"             TO  WRK-SQL-TBL-NAME
           ELSE
               MOVE    "i"             TO  WRK-SQL-TBL-NAME
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    STRING "((d.tekstymd <= '"
      *           WRK-EDSRYYMD
      *           "') and (d.tekedymd >= '"
      *           WRK-STSRYYMD
      *           "')) and"
      *    DELIMITED   BY  SIZE
      *    INTO        WRK-SQL
      *    WITH POINTER WRK-SQL-PNT
      *    END-STRING
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           IF    ( FLG-HKNKOHSEL   =   "1" )
               STRING "((i.sryymd <= '"
                      WRK-EDSRYYMD
                      "') and (i.sryymd >= '"
                      WRK-STSRYYMD
                      "')) and"
               DELIMITED   BY  SIZE
               INTO        WRK-SQL
               WITH POINTER WRK-SQL-PNT
               END-STRING
           END-IF

           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF  ( SPA-Q01-HKNJANUM (IDX1)
                                           NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *
      *            保険者番号の項目長を求める
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-HKNJANUM (IDX1) 
                                           DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            保険者番号の実際の文字列長を求める
                   MOVE    SPA-Q01-HKNJANUM (IDX1) TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
                   MOVE    WRK-STR-LEN             TO  WRK-KIGO-LEN
      *
                   STRING  "("             DELIMITED   BY  SIZE
                       WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                       ".hknjanum ='"      DELIMITED   BY  SIZE
                       SPA-Q01-HKNJANUM (IDX1)(1: WRK-KIGO-LEN)
                                           DELIMITED   BY  SIZE
                       "')"                DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF  ( SPA-Q01-HKNNUM (IDX1) NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
                   STRING  "("             DELIMITED   BY  SIZE
                       WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                       ".hknnum ='"        DELIMITED   BY  SIZE
                       SPA-Q01-HKNNUM (IDX1)
                                           DELIMITED   BY  SIZE
                       "')"                DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF      ( SPA-Q01-KIGO (IDX1)   NOT =   SPACE )
                OR     ( SPA-Q01-NUM  (IDX1)   NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
                   STRING  "("           DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
                   IF  ( SPA-Q01-KIGO (IDX1)   NOT =   SPACE )
      *                記号の項目長を求める
                       MOVE    1               TO  WRK-STR-LEN
                       MOVE    SPACE           TO  WRK-STR
                       STRING  SPA-Q01-KIGO (IDX1) DELIMITED   BY  SIZE
                       INTO    WRK-STR
                       WITH POINTER WRK-STR-LEN
                       END-STRING
                       COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *                記号の実際の文字列長を求める
                       MOVE    SPA-Q01-KIGO (IDX1) TO  WRK-STR
                       PERFORM 900-STR-LEN-GET-SEC
                       MOVE    WRK-STR-LEN         TO  WRK-KIGO-LEN
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *                STRING  "(d.kigo like '"    DELIMITED   BY  SIZE
      *                    SPA-Q01-KIGO (IDX1)(1: WRK-KIGO-LEN)
      *                                            DELIMITED   BY  SIZE
      *                    "%')"                   DELIMITED   BY  SIZE
      *                INTO    WRK-SQL
      *                WITH    POINTER WRK-SQL-PNT
      *                END-STRING
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
                       STRING  "("                 DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME        DELIMITED   BY  SPACE
                           ".kigo like '"          DELIMITED   BY  SIZE
                           SPA-Q01-KIGO (IDX1)(1: WRK-KIGO-LEN)
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
      *----(01.00.02) LINE ADD END   ----------------------------------
                       IF  ( SPA-Q01-NUM  (IDX1)   NOT =   SPACE )
                           STRING  "and"           DELIMITED   BY  SIZE
                           INTO    WRK-SQL
                           WITH    POINTER WRK-SQL-PNT
                           END-STRING
                       END-IF
                   END-IF
      *
                   IF  ( SPA-Q01-NUM  (IDX1)   NOT =   SPACE )
      *                番号の項目長を求める
                       MOVE    1               TO  WRK-STR-LEN
                       MOVE    SPACE           TO  WRK-STR
                       STRING  SPA-Q01-KIGO (IDX1) DELIMITED   BY  SIZE
                       INTO    WRK-STR
                       WITH POINTER WRK-STR-LEN
                       END-STRING
                       COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *                番号の実際の文字列長を求める
                       MOVE    SPA-Q01-NUM (IDX1) TO  WRK-STR
                       PERFORM 900-STR-LEN-GET-SEC
                       MOVE    WRK-STR-LEN         TO  WRK-NUM-LEN
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *                STRING  "(d.num like '"     DELIMITED   BY  SIZE
      *                        SPA-Q01-NUM  (IDX1)(1: WRK-NUM-LEN)
      *                                            DELIMITED   BY  SIZE
      *                        "%')"               DELIMITED   BY  SIZE
      *                INTO    WRK-SQL
      *                WITH    POINTER WRK-SQL-PNT
      *                END-STRING
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
                       STRING  "("                 DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME        DELIMITED   BY  SPACE
                               ".num like '"       DELIMITED   BY  SIZE
                               SPA-Q01-NUM  (IDX1)(1: WRK-NUM-LEN)
                                                   DELIMITED   BY  SIZE
                               "%')"               DELIMITED   BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
      *----(01.00.02) LINE ADD END   ----------------------------------
                   END-IF
      *
                   STRING  ")"                     DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
      *----(01.00.02) LINE ADD START ----------------------------------
           IF    ( FLG-HKNKOHSEL   =   ZERO )
               STRING "and (d.sakjokbn = ' ')  "
               DELIMITED   BY  SIZE
               INTO        WRK-SQL
               WITH POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       3101-PTHKNINF-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    患者公費マスタ検索条件編集処理
      *****************************************************************
       3101-PTKOHINF-SQL-EDIT-SEC          SECTION.
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    MOVE    "e"             TO  WRK-SQL-TBL-NAME
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           IF    ( FLG-HKNKOHSEL   =   ZERO )
               MOVE    "e"             TO  WRK-SQL-TBL-NAME
           ELSE
               MOVE    "i"             TO  WRK-SQL-TBL-NAME
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    STRING "((e.tekstymd <= '"
      *           WRK-EDSRYYMD
      *           "') and (e.tekedymd >= '"
      *           WRK-STSRYYMD
      *           "')) and"
      *    DELIMITED   BY  SIZE
      *    INTO        WRK-SQL
      *    WITH POINTER WRK-SQL-PNT
      *    END-STRING
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           IF    ( FLG-HKNKOHSEL   =   "1" )
               STRING "((i.sryymd <= '"
                      WRK-EDSRYYMD
                      "') and (i.sryymd >= '"
                      WRK-STSRYYMD
                      "')) and"
               DELIMITED   BY  SIZE
               INTO        WRK-SQL
               WITH POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF  ( SPA-Q01-KOHNUM (IDX1) NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *
      *            保険番号の項目長を求める
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-KOHNUM (IDX1) 
                                           DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            保険番号の実際の文字列長を求める
                   MOVE    SPA-Q01-KOHNUM (IDX1)   TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
                   MOVE    WRK-STR-LEN             TO  WRK-KIGO-LEN
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *            STRING  "(e.kohnum ='"  DELIMITED   BY  SIZE
      *                SPA-Q01-KOHNUM (IDX1)(1: WRK-KIGO-LEN)
      *                                    DELIMITED   BY  SIZE
      *                "')"                DELIMITED   BY  SIZE
      *            INTO    WRK-SQL
      *            WITH    POINTER WRK-SQL-PNT
      *            END-STRING
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
                   IF    ( SPA-Q01-KOHNUM (IDX1)   =   "027" )
                    AND  ( SPA-Q01-PAYKBN (IDX1)   =   "01" OR "02" )
                       STRING  "(("            DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                           ".kohnum ='"        DELIMITED   BY  SIZE
                           SPA-Q01-KOHNUM (IDX1)(1: WRK-KIGO-LEN)
                                               DELIMITED   BY  SIZE
                           "')and("            DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                           ".paykbn ='"        DELIMITED   BY  SIZE
                           SPA-Q01-PAYKBN (IDX1)
                                               DELIMITED   BY  SIZE
                           "'))"               DELIMITED   BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
                   ELSE
                       STRING  "("             DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                           ".kohnum ='"        DELIMITED   BY  SIZE
                           SPA-Q01-KOHNUM (IDX1)(1: WRK-KIGO-LEN)
                                               DELIMITED   BY  SIZE
                           "')"                DELIMITED   BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
                       END-STRING
                   END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           MOVE    ZERO    TO      CNT-JYOKEN
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF  ( SPA-Q01-FTNJANUM  (IDX1)  NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            負担者番号の項目長を求める
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-FTNJANUM (IDX1)
                                               DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            負担者番号の実際の文字列長を求める
                   MOVE    SPA-Q01-FTNJANUM (IDX1) TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
                   MOVE    WRK-STR-LEN         TO  WRK-NUM-LEN
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *            STRING  "(e.ftnjanum like '"
      *                                        DELIMITED   BY  SIZE
      *                    SPA-Q01-FTNJANUM  (IDX1)(1: WRK-NUM-LEN)
      *                                        DELIMITED   BY  SIZE
      *                    "%')"               DELIMITED   BY  SIZE
      *            INTO    WRK-SQL
      *            WITH    POINTER WRK-SQL-PNT
      *            END-STRING
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
                   STRING  "("                 DELIMITED   BY  SIZE
                           WRK-SQL-TBL-NAME    DELIMITED   BY  SPACE
                           ".ftnjanum like '"
                                               DELIMITED   BY  SIZE
                           SPA-Q01-FTNJANUM  (IDX1)(1: WRK-NUM-LEN)
                                               DELIMITED   BY  SIZE
                           "%')"               DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
      *----(01.00.02) LINE ADD START ----------------------------------
           IF    ( FLG-HKNKOHSEL   =   ZERO )
               STRING "and (e.sakjokbn = ' ')  "
               DELIMITED   BY  SIZE
               INTO        WRK-SQL
               WITH POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       3101-PTKOHINF-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴マスタ検索条件編集処理
      *****************************************************************
       3101-JYURRK-SQL-EDIT-SEC        SECTION.
      *
      *
           MOVE    "f"             TO  WRK-SQL-TBL-NAME
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *
      *    最終受診日検索条件編集
           STRING  "(f.sryymd >= '"            DELIMITED   BY  SIZE
                   WRK-STSRYYMD                DELIMITED   BY  SIZE
                   "') and (f.sryymd <= '"     DELIMITED   BY  SIZE
                   WRK-EDSRYYMD                DELIMITED   BY  SIZE
                   "')"                        DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       3101-JYURRK-SQL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタ検索条件編集処理
      *****************************************************************
       3101-SRYACT-SQL-EDIT-SEC        SECTION.
      *
           MOVE    "g"             TO  WRK-SQL-TBL-NAME
           PERFORM 900-SQL-JYOKEN-EDIT1-SEC
      *
      *----(01.00.02) LINE ADD START ----------------------------------
           STRING "((g.sryym <= '"
                  WRK-EDSRYYMD (1:6)
                  "') and (g.sryym >= '"
                  WRK-STSRYYMD  (1:6)
                  "')) and"
           DELIMITED   BY  SIZE
           INTO        WRK-SQL
           WITH POINTER WRK-SQL-PNT
           END-STRING
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
      *
               IF      ( SPA-Q01-SRYCD     (IDX1)  NOT =   SPACE )
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
                   STRING  "(g.srycd1 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "') or"                 DELIMITED   BY  SIZE
                           "(g.srycd2 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "') or"                 DELIMITED   BY  SIZE
                           "(g.srycd3 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "') or"                 DELIMITED   BY  SIZE
                           "(g.srycd4 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "') or"                 DELIMITED   BY  SIZE
                           "(g.srycd5 = '"         DELIMITED   BY  SIZE
                           SPA-Q01-SRYCD (IDX1)    DELIMITED   BY  SIZE
                           "')"                    DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           PERFORM 900-SQL-JYOKEN-EDIT4-SEC
      *
           .
       3101-PTKOHINF-SQL-EDIT-EXT.
           EXIT.
      *----(01.00.01) LINE ADD START ----------------------------------
      *****************************************************************
      *    患者番号マスタ検索条件編集処理
      *****************************************************************
       3101-PTNUM-SQL-EDIT-SEC         SECTION.
      *
           IF  ( FLG-JYOKEN        =   1 )
               STRING " and "      DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER     WRK-SQL-PNT
               END-STRING
           END-IF
      *
           STRING  "((h.hospid='"              DELIMITED   BY  SIZE
                   SPA-HOSPID                  DELIMITED   BY  SIZE
                   "')and("                    DELIMITED   BY  SIZE
                   "h.ptid=a.ptid) "           DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           IF  ( SPA-Q01-GTBL (1)  =   "1" )
               STRING  "and (h.ptnum>='"   DELIMITED  BY  SIZE
                       SPA-Q01-STPTNUM     DELIMITED  BY  SIZE
                       "') and "           DELIMITED  BY  SIZE
                       "(h.ptnum<='"       DELIMITED  BY  SIZE
                       WRK-EDPTNUM         DELIMITED  BY  SIZE
                       "')"                DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           STRING  ")"         DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           .
       3101-PTNUM-SQL-EDIT-EXT.
           EXIT.
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.01) LINE DEL START ----------------------------------
      *****************************************************************
      *    患者ＩＤ検索条件編集処理
      *****************************************************************
      *3102-PTID-SELECT-EDIT-SEC           SECTION.
      *
      *    MOVE    ZERO    TO      CNT-JYOKEN
      *    PERFORM VARYING IDX1    FROM    1   BY  1
      *        UNTIL   (   IDX1    >   5 )
      *
      *        IF  ( SPA-Q01-PTID (IDX1)   NOT =   ZERO )
      *            COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
      *            PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            STRING  "(a.ptid = "            DELIMITED   BY  SIZE
      *                    SPA-Q01-PTID (IDX1)     DELIMITED   BY  SIZE
      *                    ")"                     DELIMITED   BY  SIZE
      *            INTO    WRK-SQL
      *            WITH    POINTER WRK-SQL-PNT
      *            END-STRING
      *        END-IF
      *
      *    END-PERFORM
      *
      *    PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
      *    .
      *3102-PTID-SELECT-EDIT-EXT.
      *    EXIT.
      *----(01.00.01) LINE DEL END   ----------------------------------
      *****************************************************************
      *    カナ氏名検索条件編集処理
      *****************************************************************
       3102-KANANAME-SELECT-EDIT-SEC       SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
               IF  ( SPA-Q01-KANANAME (IDX1)   NOT =   SPACE)
      *
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            カナ氏名の項目長を求める
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-KANANAME (IDX1) DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            カナ氏名の実際の文字列長を求める
                   MOVE    SPA-Q01-KANANAME (IDX1)   TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
      *
                   STRING  "(a.kananame like '"    DELIMITED   BY  SIZE
                           SPA-Q01-KANANAME (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       3102-KANANAME-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    漢字氏名検索条件編集処理
      *****************************************************************
       3102-NAME-SELECT-EDIT-SEC           SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
               IF  ( SPA-Q01-NAME (IDX1)   NOT =   SPACE)
      *
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            カナ氏名の項目長を求める
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-NAME (IDX1)   DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            カナ氏名の実際の文字列長を求める
                   MOVE    SPA-Q01-NAME (IDX1)   TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
      *
                   STRING  "(a.name like '"        DELIMITED   BY  SIZE
                           SPA-Q01-NAME (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
               END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       3102-NAME-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    生年月日検索条件編集処理
      *****************************************************************
       3102-BIRTH-SELECT-EDIT-SEC          SECTION.
      *
           IF      ( SPA-Q01-STBIRTHDAY    =   SPACE )
            AND    ( SPA-Q01-EDBIRTHDAY    =   SPACE )
               GO  TO  3102-BIRTH-SELECT-EDIT-EXT
           END-IF
      *
           MOVE    1                   TO  CNT-JYOKEN
      *
           PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
           STRING  "(birthday >= '"        DELIMITED   BY  SIZE
                   WRK-STBIRTHDAY          DELIMITED   BY  SIZE
                   "') and "               DELIMITED   BY  SIZE
                   "(birthday  <= '"       DELIMITED   BY  SIZE
                   WRK-EDBIRTHDAY          DELIMITED   BY  SIZE
                   "')"                    DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER WRK-SQL-PNT
           END-STRING
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
      *
           .
       3102-BIRTH-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    性別検索条件編集処理
      *****************************************************************
       3102-SEX-SELECT-EDIT-SEC            SECTION.
      *
           IF      ( SPA-Q01-SEX       =   SPACE )
               GO  TO  3102-SEX-SELECT-EDIT-EXT
           END-IF
      *
           MOVE    1                   TO  CNT-JYOKEN
      *
           PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
           STRING  "(sex = '"       DELIMITED   BY  SIZE
                   SPA-Q01-SEX      DELIMITED   BY  SIZE
                   "')"             DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER WRK-SQL-PNT
           END-STRING
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       3102-SEX-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    住所検索条件編集処理
      *****************************************************************
       3102-HOME-ADRS-SELECT-EDIT-SEC      SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
               IF  ( SPA-Q01-JYUSHO (IDX1) NOT =   SPACE)
      *
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            住所の項目長を求める
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-JYUSHO (IDX1)   DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            住所の実際の文字列長を求める
                   MOVE    SPA-Q01-JYUSHO (IDX1)   TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
      *
                   STRING  "(home_adrs like '"     DELIMITED   BY  SIZE
                           SPA-Q01-JYUSHO (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
                END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
           .
       3102-HOME-ADRS-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    コメント検索条件編集処理
      *****************************************************************
       3102-COMMENT-SELECT-EDIT-SEC        SECTION.
      *
           MOVE    ZERO    TO      CNT-JYOKEN
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL   (   IDX1    >   5 )
               IF  ( SPA-Q01-COMMENT (IDX1) NOT =   SPACE)
      *
                   COMPUTE CNT-JYOKEN  =   CNT-JYOKEN  +   1
      *
                   PERFORM 900-SQL-JYOKEN-EDIT2-SEC
      *
      *            コメントの項目長を求める
                   MOVE    1               TO  WRK-STR-LEN
                   MOVE    SPACE           TO  WRK-STR
                   STRING  SPA-Q01-COMMENT (IDX1)  DELIMITED   BY  SIZE
                   INTO    WRK-STR
                   WITH POINTER WRK-STR-LEN
                   END-STRING
                   COMPUTE WRK-STR-LEN =   WRK-STR-LEN -   1
      *
      *            コメントの実際の文字列長を求める
                   MOVE    SPA-Q01-COMMENT (IDX1)  TO  WRK-STR
                   PERFORM 900-STR-LEN-GET-SEC
      *
                   STRING  "(comment_1 like '"     DELIMITED   BY  SIZE
                           SPA-Q01-COMMENT (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')or"                 DELIMITED   BY  SIZE
                           " (comment_2 like '"    DELIMITED   BY  SIZE
                           SPA-Q01-COMMENT (IDX1)(1: WRK-STR-LEN) 
                                                   DELIMITED   BY  SIZE
                           "%')"                   DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
      *
                END-IF
           END-PERFORM
      *
           PERFORM 900-SQL-JYOKEN-EDIT3-SEC
      *
      *
           .
       3102-COMMENT-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    並べ替え順編集処理
      *****************************************************************
       3102-ORDER-EDIT-SEC                 SECTION.
      *
           MOVE    SPA-Q01-KMK (1)     TO  IDX-KMK1
           MOVE    SPA-Q01-KMK (2)     TO  IDX-KMK2
           MOVE    SPA-Q01-KMK (3)     TO  IDX-KMK3
      *
           MOVE    SPA-Q01-NARABE (1)  TO  IDX-SRT1
           MOVE    SPA-Q01-NARABE (2)  TO  IDX-SRT2
           MOVE    SPA-Q01-NARABE (3)  TO  IDX-SRT3
      *
           STRING  " ORDER BY "                DELIMITED   BY  SIZE
                   CONST-KMK-ITEM (IDX-KMK1)   DELIMITED   BY  SPACE
                   " "                         DELIMITED   BY  SIZE
                   CONST-ORDER (IDX-SRT1)
                                               DELIMITED   BY  SPACE
                   ","                         DELIMITED   BY  SIZE
                   CONST-KMK-ITEM (IDX-KMK2)   DELIMITED   BY  SPACE
                   " "                         DELIMITED   BY  SIZE
                   CONST-ORDER (IDX-SRT2)
                                               DELIMITED   BY  SPACE
                   ","                         DELIMITED   BY  SIZE
                   CONST-KMK-ITEM (IDX-KMK3)   DELIMITED   BY  SPACE
                   " "                         DELIMITED   BY  SIZE
                   CONST-ORDER (IDX-SRT3)
                                               DELIMITED   BY  SPACE
           INTO    WRK-SQL
           WITH    POINTER WRK-SQL-PNT
           END-STRING
      *
           .
      *
       3102-ORDER-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    表題チェック
      *****************************************************************
       4100-HYODAI-CHK-SEC         SECTION.
      *
           MOVE    1                   TO  SPA-GMN-Q02-CUR
      *
           MOVE    Q02-HYODAI          TO  SPA-GMN-Q02-HYODAI
      *
      *    全角半角混在チェック
           MOVE    SPA-GMN-Q02-HYODAI
                                       TO  WRK-KANACHK-MAE-INPUT
      *
           PERFORM     800-ENRTRY-CHK-SEC
           IF  ( FLG-ENTRYCHK      NOT =   ZERO )
               MOVE    "0003"          TO  SPA-ERRCD
               GO  TO  4100-HYODAI-CHK-EXIT
           END-IF
      *
           COMPUTE SPA-GMN-Q02-CUR     =   SPA-GMN-Q02-CUR
                                       +   1
      *
           .
       4100-HYODAI-CHK-EXIT.
           EXIT.
      *****************************************************************
      *    条件上段チェック
      *****************************************************************
       4101-JYOKEN1-CHK-SEC        SECTION.
      *
           MOVE    2                   TO  SPA-GMN-Q02-CUR
      *
           MOVE    Q02-JYOKEN1         TO  SPA-GMN-Q02-JYOKEN1
      *
      *    全角半角混在チェック
           MOVE    SPA-GMN-Q02-JYOKEN1
                                       TO  WRK-KANACHK-MAE-INPUT
      *
           PERFORM     800-ENRTRY-CHK-SEC
           IF  ( FLG-ENTRYCHK      NOT =   ZERO )
               MOVE    "0003"          TO  SPA-ERRCD
               GO  TO  4101-JYOKEN1-CHK-EXT
           END-IF
      *
           COMPUTE SPA-GMN-Q02-CUR     =   SPA-GMN-Q02-CUR
                                       +   1
      *
           .
       4101-JYOKEN1-CHK-EXT.
           EXIT.
      *****************************************************************
      *    条件下段チェック
      *****************************************************************
       4102-JYOKEN2-CHK-SEC        SECTION.
      *
           MOVE    3                   TO  SPA-GMN-Q02-CUR
      *
           MOVE    Q02-JYOKEN2         TO  SPA-GMN-Q02-JYOKEN2
      *
      *    全角半角混在チェック
           MOVE    SPA-GMN-Q02-JYOKEN2
                                       TO  WRK-KANACHK-MAE-INPUT
      *
           PERFORM     800-ENRTRY-CHK-SEC
           IF  ( FLG-ENTRYCHK      NOT =   ZERO )
               MOVE    "0003"          TO  SPA-ERRCD
               GO  TO  4102-JYOKEN2-CHK-EXT
           END-IF
      *
           MOVE    4                   TO  SPA-GMN-Q02-CUR
      *
           .
       4102-JYOKEN2-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号チェック
      *****************************************************************
       4102-SELUM-CHK-SEC          SECTION.
      *
           MOVE    4                   TO  SPA-GMN-Q02-CUR
      *
           MOVE    Q02-SELNUM          TO  SPA-GMN-Q02-SELNUM
      *
      *    未入力時はチェックを行わない
           IF  ( SPA-GMN-Q02-SELNUM    =   ZERO )
               MOVE    1               TO  SPA-GMN-Q02-CUR
               GO  TO  4102-SELUM-CHK-EXT
           END-IF
      *
      *    選択番号範囲チェック
           COMPUTE WRK-KEKKALST-NO-ST  =   SPA-GMN-Q02-SKIP-KNS
                                       +   1
      *
           COMPUTE WRK-KEKKALST-NO-ED  =   SPA-GMN-Q02-SKIP-KNS
                                       +   SPA-GMN-Q02-KEKKA-MAX
      *
           IF      ( SPA-GMN-Q02-SELNUM   >=   WRK-KEKKALST-NO-ST )
            AND    ( SPA-GMN-Q02-SELNUM   <=   WRK-KEKKALST-NO-ED )
      *
               COMPUTE SPA-GMN-Q02-KEKKA-SEL
                   =   SPA-GMN-Q02-SELNUM  -  SPA-GMN-Q02-SKIP-KNS
      *
           ELSE
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  4102-SELUM-CHK-EXT
           END-IF
      *
           MOVE    1                   TO  SPA-GMN-Q02-CUR
      *
           .
       4102-SELUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    行選択処理
      *****************************************************************
       4102-KEKKALSTSEL-SEC        SECTION.
      *
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL     ( IDX1    >       200 )
               IF      (  Q02-KEKKALST-SELECT (IDX1)  =   "T"  )
                   COMPUTE SPA-GMN-Q02-SELNUM
                                   =   IDX1
                                   +   SPA-GMN-Q02-SKIP-KNS
                   MOVE    IDX1            TO  SPA-GMN-Q02-KEKKA-SEL
                   MOVE    200             TO  IDX1
               END-IF
           END-PERFORM
      *
           .
       4102-KEKKALSTSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    MOVE    "Q01"               TO  SPA-SAKIPG
      *    MOVE    "Q02"               TO  SPA-MOTOPG
      *
      *    MOVE   "CHANGE"             TO  MCP-PUTTYPE
      *    MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
      *    PERFORM 900-PUT-WINDOW
      *
      *    MOVE    1                   TO  FLG-END
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
      *    ジョブ管理チェック処理
           PERFORM 900-JOBKANRI-CHK-SEC
           IF    ( FLG-JOBEND   =   ZERO )
               MOVE    "6666"          TO  SPA-QIDCD
               STRING  "処理中です【"  DELIMITED  BY  SIZE
                       JOB-SHELLMSG    DELIMITED  BY  SPACE
                       "】"            DELIMITED  BY  SIZE
               INTO  WRK-SHORIERR
               END-STRING
               GO  TO  210-BACK-EXT
           END-IF
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           PERFORM 210-BACK-SYORI-SEC
      *
      *----(01.00.02) LINE ADD END   ----------------------------------
           .
       210-BACK-EXT.
           EXIT.
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      * 
           MOVE    "Q01"               TO  SPA-SAKIPG
           MOVE    "Q02"               TO  SPA-MOTOPG
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
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       210-MAE-PAGE-SEC                SECTION.
      *
           IF  ( SPA-GMN-Q02-SKIP-KNS      >   0 )
               COMPUTE SPA-GMN-Q02-SKIP-KNS    =   SPA-GMN-Q02-SKIP-KNS
                                               -   200
               PERFORM 310-Q02-GMN-EDIT-SEC
               MOVE    ZERO            TO  SPA-GMN-Q02-SELNUM
           END-IF
      *
           .
       210-MAE-PAGE-EXT.
           EXIT.
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       210-TUGI-PAGE-SEC               SECTION.
      *
           IF  ( SPA-GMN-Q02-FLG-PTINF     =   0 )
               COMPUTE SPA-GMN-Q02-SKIP-KNS    =   SPA-GMN-Q02-SKIP-KNS
                                               +   200
               PERFORM 310-Q02-GMN-EDIT-SEC
               MOVE    ZERO            TO  SPA-GMN-Q02-SELNUM
           END-IF
      *
           .
       210-TUGI-PAGE-EXT.
           EXIT.
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    情報削除へ
      *****************************************************************
       480-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-Q01FREE         TO  LNK-SCRSPA
      *
           INITIALIZE                  SPA-KYOTUKEY
      *    画面移行用のパラメタ変更
           MOVE    "Q02"               TO  SPA-MOTOPG
           MOVE    "XB01"              TO  SPA-SAKIPG
      *
           MOVE    CONST-JOB-SHELLID
                                       TO  SPA-JOB-SHELLID
      *
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XB01"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       480-JYOUHOU-DEL-EXT.
           EXIT.
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    予約登録へ
      *****************************************************************
       480-YOYAKU-SEC              SECTION.
      *
      *    戻り時、画面を元へ戻す
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-Q01FREE         TO  LNK-SCRSPA
      *
           INITIALIZE                  SPA-KYOTUKEY
      *    画面移行用のパラメタ変更
           MOVE    "Q02"               TO  SPA-MOTOPG
           MOVE    "Y01"               TO  SPA-SAKIPG
           MOVE    "Q02"               TO  SPA-MOTOPG3
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "Y01    "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       480-YOYAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者登録へ
      *****************************************************************
       480-KANJYA-SEC             SECTION.
      *
      *    画面遷移時のチェック処理
           PERFORM 4801-GAMEN-SENIJI-CHK-SEC
           IF  ( SPA-ERRCD         NOT =   SPACE )
               GO  TO  480-KANJYA-EXT
           END-IF
      *
           COMPUTE IDX1    =   SPA-GMN-Q02-SELNUM
                           -   SPA-GMN-Q02-SKIP-KNS
      *
      *---- (01.00.01) LINE ADD START --------------------------------
      *
      *    患者ＩＤを患者番号に変換
      *     INITIALIZE                  ORCSPTIDAREA
      *     MOVE    SPA-HOSPID          TO  SPTID-HOSPID
      *     MOVE    SPA-GMN-Q02-PTINF-PTID (IDX1)
      *                                 TO  SPTID-PTID
      *
      *     CALL    "ORCSPTID"          USING   ORCSPTIDAREA
      *                                         SPA-1009-TBL
      *
      *     IF  SPTID-RC  NOT  =  ZERO
           IF  SPA-GMN-Q02-KEKKALST-PTNUM (IDX1)  =  SPACE
               MOVE    "1002"          TO  SPA-ERRCD
               GO  TO  480-KANJYA-EXT
           END-IF
      *---- (01.00.01) LINE ADD END ----------------------------------
      *
      *    ＳＰＡの内容を退避
           INITIALIZE                  QSUB01-LNK
           MOVE    SPA-TERMID          TO  QSUB01-TERMID
           MOVE    "O"                 TO  QSUB01-KBN
           MOVE    SPA-Q01FREE         TO  QSUB01-SPA-AREA
      *
           CALL "ORCGQSUB01"           USING   QSUB01-LNK
      *
           INITIALIZE                  SPA-KYOTUKEY
      *
           MOVE    SPA-GMN-Q02-PTINF-PTID (IDX1)
                                       TO  SPA-PTID
      *---- (01.00.01) LINE ADD START --------------------------------
            MOVE  SPA-GMN-Q02-KEKKALST-PTNUM (IDX1)
                                       TO  SPA-PTNUM
      *     MOVE    SPTID-PTNUM         TO  SPA-PTNUM
      *---- (01.00.01) LINE ADD END ----------------------------------
      *
      *    受付と患者検索以外の元をセット
           MOVE    "Q02"               TO  SPA-MOTOPG
           MOVE    "P02"               TO  SPA-SAKIPG
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-Q01FREE         TO  LNK-SCRSPA
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "P02"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       480-KANJYA-EXT.
           EXIT.
      *
      *****************************************************************
      *    受付一覧へ
      *****************************************************************
       490-UKEICHI-SEC             SECTION.
      *
      *    戻り時、画面を元へ戻す
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-Q01FREE         TO  LNK-SCRSPA
      *    画面移行用のパラメタ変更
           MOVE    "Q02"               TO  SPA-MOTOPG
           MOVE    "U01"               TO  SPA-SAKIPG
      *
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "U01"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-UKEICHI-EXT.
           EXIT.
      *
      *----(01.00.01) LINE ADD START ----------------------------------
      *****************************************************************
      *    印刷確認
      *****************************************************************
       480-CSV-KAKUNIN-SEC             SECTION.
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *    ジョブ管理チェック処理
           PERFORM 900-JOBKANRI-CHK-SEC
           IF    ( FLG-JOBEND   =   ZERO )
               MOVE    "7777"          TO  SPA-ERRCD
               MOVE    SPACE           TO  WRK-SHORIERR
               STRING  "処理中です【"  DELIMITED  BY  SIZE
                       JOB-SHELLMSG    DELIMITED  BY  SPACE
                       "】"            DELIMITED  BY  SIZE
               INTO  WRK-SHORIERR
               END-STRING
               GO  TO  480-CSV-KAKUNIN-EXT
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    ZERO            TO  WRK-PROC-FLG
      *
      *----(01.00.02) LINE UPD START ----------------------------------
      *    PERFORM 480-KAKUNIN-CALL-SEC
           PERFORM 480-OUT-SIJI-CALL-SEC
      *----(01.00.02) LINE UPD END   ----------------------------------
      *
           .
       480-CSV-KAKUNIN-EXT.
           EXIT.
      *
      *----(01.00.01) LINE ADD END   ----------------------------------
      *****************************************************************
      *    印刷確認
      *****************************************************************
       480-PRINT-KAKUNIN-SEC           SECTION.
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *    ジョブ管理チェック処理
           PERFORM 900-JOBKANRI-CHK-SEC
           IF    ( FLG-JOBEND   =   ZERO )
               MOVE    "7777"          TO  SPA-ERRCD
               MOVE    SPACE           TO  WRK-SHORIERR
               STRING  "処理中です【"  DELIMITED  BY  SIZE
                       JOB-SHELLMSG    DELIMITED  BY  SPACE
                       "】"            DELIMITED  BY  SIZE
               INTO  WRK-SHORIERR
               END-STRING
               GO  TO  480-PRINT-KAKUNIN-EXT
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    表題全角半角混在チェック
           MOVE    SPA-GMN-Q02-HYODAI  TO  WRK-KANACHK-MAE-INPUT
      *
           PERFORM     800-ENRTRY-CHK-SEC
           IF  ( FLG-ENTRYCHK      NOT =   ZERO )
               MOVE    "0003"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-Q02-CUR
               GO  TO  480-PRINT-KAKUNIN-EXT
           END-IF
      *
      *
      *    条件１全角半角混在チェック
           MOVE    SPA-GMN-Q02-JYOKEN1 TO  WRK-KANACHK-MAE-INPUT
      *
           PERFORM     800-ENRTRY-CHK-SEC
           IF  ( FLG-ENTRYCHK      NOT =   ZERO )
               MOVE    "0003"          TO  SPA-ERRCD
               MOVE    2               TO  SPA-GMN-Q02-CUR
               GO  TO  480-PRINT-KAKUNIN-EXT
           END-IF
      *
      *
      *    条件２全角半角混在チェック
           MOVE    SPA-GMN-Q02-JYOKEN2 TO  WRK-KANACHK-MAE-INPUT
      *
           PERFORM     800-ENRTRY-CHK-SEC
           IF  ( FLG-ENTRYCHK      NOT =   ZERO )
               MOVE    "0003"          TO  SPA-ERRCD
               MOVE    3               TO  SPA-GMN-Q02-CUR
               GO  TO  480-PRINT-KAKUNIN-EXT
           END-IF
      *
      *
      *---- (01.00.01) LINE DEL START --------------------------------
      *    MOVE    "2001"          TO  SPA-QIDCD
      *---- (01.00.01) LINE DEL END   --------------------------------
      *---- (01.00.01) LINE ADD START --------------------------------
      *
           MOVE    1               TO  WRK-PROC-FLG
      *
      *----(01.00.02) LINE UPD START ----------------------------------
      *    PERFORM 480-KAKUNIN-CALL-SEC
           PERFORM 480-OUT-SIJI-CALL-SEC
      *----(01.00.02) LINE UPD END   ----------------------------------
      *---- (01.00.01) LINE ADD END   --------------------------------
      *
           .
       480-PRINT-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認画面
      *****************************************************************
       490-KAKUNIN-SEC                 SECTION.
      *
           MOVE    SPACE           TO  SPA-MOTOPG
           MOVE    SPA-AREA        TO  SPA-COMMON
      *
           MOVE    "LINK"          TO  MCP-STATUS
           MOVE    SPACE           TO  MCP-EVENT
      *
           CALL    "ORCGQ97"       USING
                                   MCPAREA
                                   SPAAREA
                                   LINKAREA
                                   SCRAREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
      *
      *
           MOVE    "B01"           TO  MCP-WIDGET
      *
           MOVE    "Q02"           TO  SPA-MOTOPG
           MOVE    "Q97"           TO  SPA-SAKIPG
      *
           MOVE    "NEW"           TO  MCP-PUTTYPE
           MOVE    "Q97"           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
      *
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *---- (01.00.02) LINE DEL START --------------------------------
      *****************************************************************
      *    確認画面呼出処理
      *****************************************************************
      *480-KAKUNIN-CALL-SEC            SECTION.
      *
      *    MOVE    SPACE           TO  SPA-Q01-QID-AREA
      *    INITIALIZE                  SPA-Q01-QID-AREA
      *
      *    MOVE    WRK-PROC-FLG    TO  SPA-QID1-PROC-FLG
      *    MOVE    1               TO  SPA-QID1-STNUM
      *
      *    IF  ( WRK-PROC-FLG      =   ZERO )
      *        MOVE    SPA-GMN-Q02-TOTAL-NUM
      *                            TO  SPA-QID1-EDNUM
      *    ELSE
      *        COMPUTE SPA-QID1-EDNUM
      *            =   SPA-GMN-Q02-TOTAL-NUM   /   CONST-LINE  +   0.99
      *    END-IF
      *
      *    MOVE    SPACE           TO  SPA-MOTOPG
      *    MOVE    SPA-AREA        TO  SPA-COMMON
      *    MOVE    SPA-Q01FREE     TO  SPA-FREE
      *
      *    MOVE    "LINK"          TO  MCP-STATUS
      *    MOVE    SPACE           TO  MCP-EVENT
      *
      *    CALL    "ORCGQID1"      USING
      *                            MCPAREA
      *                            SPAAREA
      *                            LINKAREA
      *                            SCRAREA
      *
      *
      *    MOVE    SPA-COMMON      TO  SPA-AREA
      *    MOVE    SPA-FREE        TO  SPA-Q01FREE
      *
      *    MOVE  "B12"             TO  MCP-WIDGET
      *
      *    MOVE  "Q02"             TO  SPA-MOTOPG
      *    MOVE  "QID1"            TO  SPA-SAKIPG
      *
      *    MOVE  "NEW"             TO  MCP-PUTTYPE
      *    MOVE  "QID1"            TO  MCP-WINDOW
      *
      *    PERFORM 900-PUT-WINDOW
      *
      *    MOVE  1                 TO  FLG-END
      *    .
      *
      *480-KAKUNIN-CALL-EXT.
      *    EXIT.
      *---- (01.00.02) LINE DEL END   --------------------------------
      *---- (01.00.02) LINE ADD START --------------------------------
      *****************************************************************
      *    出力指示画面呼出処理
      *****************************************************************
       480-OUT-SIJI-CALL-SEC           SECTION.
      *
           MOVE    SPACE           TO  SPA-Q02-Q100-SENI-AREA
           INITIALIZE                  SPA-Q02-Q100-SENI-AREA
      *
           MOVE    WRK-PROC-FLG    TO  SPA-Q02-Q100-PROC-FLG
           MOVE    1               TO  SPA-Q02-Q100-STNUM
      *
           IF  ( WRK-PROC-FLG      =   ZERO )
               MOVE    SPA-GMN-Q02-TOTAL-NUM
                                   TO  SPA-Q02-Q100-EDNUM
           ELSE
               COMPUTE SPA-Q02-Q100-EDNUM
                   =   SPA-GMN-Q02-TOTAL-NUM   /   CONST-LINE  +   0.99
           END-IF
      *
           MOVE    SPACE           TO  SPA-MOTOPG
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-Q01FREE     TO  SPA-FREE
      *
           MOVE    "LINK"          TO  MCP-STATUS
           MOVE    SPACE           TO  MCP-EVENT
      *
           CALL    "ORCGQ100"      USING
                                   MCPAREA
                                   SPAAREA
                                   LINKAREA
                                   SCRAREA
      *
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-Q01FREE
      *
           MOVE  "B12"             TO  MCP-WIDGET
      *
           MOVE  "Q02"             TO  SPA-MOTOPG
           MOVE  "Q100"            TO  SPA-SAKIPG
      *
           MOVE  "NEW"             TO  MCP-PUTTYPE
           MOVE  "Q100"            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE  1                 TO  FLG-END
           .
      *
       480-OUT-SIJI-CALL-EXT.
           EXIT.
      *****************************************************************
      *    処理結果確認画面
      *****************************************************************
      *---- (01.00.02) LINE ADD END   --------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    画面遷移時のチェック処理
      *****************************************************************
       4801-GAMEN-SENIJI-CHK-SEC   SECTION.
      *
      *    選択番号チェック
      *    １．未入力チェック
           IF  ( SPA-GMN-Q02-SELNUM    =   ZERO )
               MOVE    "1001"      TO  SPA-ERRCD
               GO  TO  4801-GAMEN-SENIJI-CHK-EXT
           END-IF
      *
      *    ２．範囲チェック
           COMPUTE WRK-KEKKALST-NO-ST  =   SPA-GMN-Q02-SKIP-KNS
                                       +   1
      *
           COMPUTE WRK-KEKKALST-NO-ED  =   SPA-GMN-Q02-SKIP-KNS
                                       +   SPA-GMN-Q02-KEKKA-MAX
      *
           IF      ( SPA-GMN-Q02-SELNUM   >=   WRK-KEKKALST-NO-ST )
            AND    ( SPA-GMN-Q02-SELNUM   <=   WRK-KEKKALST-NO-ED )
                   CONTINUE
           ELSE
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  4801-GAMEN-SENIJI-CHK-EXT
           END-IF
           .
      *
       4801-GAMEN-SENIJI-CHK-EXT.
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
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
      *---- (01.00.02) LINE ADD START --------------------------------
           IF      SPA-QIDCD       NOT =   SPACE
               PERFORM 520-QIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *---- (01.00.02) LINE ADD END   --------------------------------
      *
      *---- (01.00.01) LINE DEL START --------------------------------
      *    IF      SPA-QIDCD       NOT =   SPACE
      *        PERFORM 520-QIDSET-SEC
      *        GO  TO  500-SET-SCREEN-EXT
      *    END-IF
      *---- (01.00.01) LINE DEL END   --------------------------------
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "Q02"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    WIDGET-NORMAL           TO  Q02-B10-STATE
                                               Q02-B24-STATE
      *---- (01.00.01) LINE ADD START --------------------------------
      *    検索結果件数がゼロ件でない場合はボタンを活性にする
           IF  ( SPA-GMN-Q02-TOTAL-NUM     >   ZERO )
               MOVE    WIDGET-NORMAL       TO  Q02-B05-STATE
                                               Q02-B11-STATE
                                               Q02-B12-STATE
               MOVE    SPA-GMN-Q02-B06-STATE
                                           TO  Q02-B06-STATE
               MOVE    SPA-GMN-Q02-B07-STATE
                                           TO  Q02-B07-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE  TO  Q02-B05-STATE
                                               Q02-B06-STATE
                                               Q02-B07-STATE
                                               Q02-B11-STATE
                                               Q02-B12-STATE
           END-IF
      *
      *---- (01.00.01) LINE ADD END   --------------------------------
      *    表題
           MOVE    SPA-GMN-Q02-HYODAI      TO  Q02-HYODAI
      *    条件上段
           MOVE    SPA-GMN-Q02-JYOKEN1     TO  Q02-JYOKEN1
      *    条件下段
           MOVE    SPA-GMN-Q02-JYOKEN2     TO  Q02-JYOKEN2
      *    検索件数
           MOVE    SPA-GMN-Q02-KEKKA-MAX
                                   TO  Q02-KEKKALST-COUNT
      *    検索結果
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >       SPA-GMN-Q02-KEKKA-MAX)
      *        連番
               MOVE    SPA-GMN-Q02-KEKKALST-NO   (IDX1)
                                   TO  Q02-KEKKALST-NO (IDX1)
      *---- (01.00.01) LINE ADD START --------------------------------
      *
      *        患者番号
               MOVE    SPA-GMN-Q02-KEKKALST-PTNUM   (IDX1)
                                   TO  Q02-KEKKALST-PTNUM (IDX1)
      *---- (01.00.01) LINE ADD END ----------------------------------
      *
      *        氏名
               MOVE    SPA-GMN-Q02-KEKKALST-NAME (IDX1)
                                   TO  Q02-KEKKALST-NAME (IDX1)
      *        性別
               MOVE    SPA-GMN-Q02-KEKKALST-SEX (IDX1)
                                   TO  Q02-KEKKALST-SEX (IDX1)
      *        誕生日
               MOVE    SPA-GMN-Q02-KEKKALST-BIRTH (IDX1)
                                   TO  Q02-KEKKALST-BIRTH (IDX1)
      *---- (01.00.01) LINE ADD START --------------------------------
      *        年齢
               MOVE    SPA-GMN-Q02-KEKKALST-AGE (IDX1)
                                   TO  Q02-KEKKALST-AGE (IDX1)
      *---- (01.00.01) LINE ADD END ----------------------------------
      *        診療内容
               MOVE    SPA-GMN-Q02-KEKKALST-SRYACT (IDX1)
                                   TO  Q02-KEKKALST-SRYACTNAIYO (IDX1)
      *
               IF      ( SPA-GMN-Q02-KEKKA-SEL =   IDX1 )
                   MOVE    "T"     TO  Q02-KEKKALST-SELECT (IDX1)
               ELSE
                   MOVE    "F"     TO  Q02-KEKKALST-SELECT (IDX1)
               END-IF
      *
           END-PERFORM
      *
      *    総件数
           MOVE    SPA-GMN-Q02-TOTAL   TO  Q02-TOTAL
      *
      *    選択番号
           MOVE    SPA-GMN-Q02-SELNUM  TO  Q02-SELNUM
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
           EVALUATE    SPA-GMN-Q02-CUR
      *
      *    表題
           WHEN   001
               MOVE  "HYODAI"      TO  MCP-WIDGET
      *
      *    条件上段
           WHEN   002
               MOVE  "JYOKEN1"     TO  MCP-WIDGET
      *
      *    条件下段
           WHEN   003
               MOVE  "JYOKEN2"     TO  MCP-WIDGET
      *
      *    選択番号
           WHEN   004
               MOVE  "SELNUM"      TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
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
               MOVE    "条件に該当する患者は存在しませんでした"
                                       TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "範囲外の番号が入力されています"
                                       TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "全角文字でのみ入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1001"
               MOVE    "選択番号が未入力です"
                                       TO  SPA-ERRMSG
           WHEN    "1002"
      *---- (01.00.01) LINE ADD START --------------------------------
      *         MOVE    "患者番号取得エラー"
               MOVE    "患者番号が未登録のため遷移できません"
      *---- (01.00.01) LINE ADD END ----------------------------------
                                       TO  SPA-ERRMSG
      *---- (01.00.02) LINE ADD START --------------------------------
           WHEN    "7777"
               MOVE    WRK-SHORIERR    TO  SPA-ERRMSG
      *---- (01.00.02) LINE ADD END ----------------------------------
           END-EVALUATE
      *
           MOVE    SPACE                TO  QERR
           MOVE    SPA-ERRCD            TO  QERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  QERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "Q02"                TO  SPA-MOTOPG
           MOVE    "QERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "QERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *---- (01.00.02) LINE ADD START --------------------------------
      *****************************************************************
      *    確認メッセージ表示処理
      *****************************************************************
       520-QIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-QIDMSG
      *
           EVALUATE    SPA-QIDCD
           WHEN    "6666"
               MOVE    WRK-SHORIERR    TO  WRK-QIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  QID1
           MOVE    SPA-QIDCD           TO  QID1-ID1CODE
           MOVE    WRK-QIDMSG          TO  QID1-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "Q02"               TO  SPA-MOTOPG
           MOVE    "QID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "QID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-QIDSET-EXT.
           EXIT.
      *---- (01.00.02) LINE ADD END   --------------------------------
      *
      *---- (01.00.01) LINE DEL START --------------------------------
      *****************************************************************
      *    確認メッセージ表示処理
      *****************************************************************
      *520-QIDSET-SEC              SECTION.
      *
      *    MOVE    SPACE               TO  WRK-QIDMSG
      *
      *    EVALUATE    SPA-QIDCD
      *    WHEN    "2001"
      *        MOVE    "一覧表示されている患者情報の印刷を行います"
      *                                TO  WRK-QIDMSG
      *    END-EVALUATE
      *
      *    MOVE    SPACE               TO  QID1
      *    MOVE    SPA-QIDCD           TO  QID1-ID1CODE
      *    MOVE    WRK-QIDMSG          TO  QID1-ID1MSG
      *    MOVE    "B12"               TO  MCP-WIDGET
      *
      *    MOVE    "Q02"               TO  SPA-MOTOPG
      *    MOVE    "QID1"              TO  SPA-SAKIPG
      *
      *    MOVE    "NEW"               TO  MCP-PUTTYPE.
      *    MOVE    "QID1"              TO  MCP-WINDOW.
      *
      *    PERFORM 900-PUT-WINDOW.
      *
      *    MOVE    1                   TO  FLG-END
      *
      *    .
      *520-QIDSET-EXT.
      *    EXIT.
      *---- (01.00.01) LINE DEL END   --------------------------------
      *
      *****************************************************************
      *    全角半角混在チェック
      *****************************************************************
       800-ENRTRY-CHK-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-ENTRYCHK
      *
           IF  ( WRK-KANACHK-MAE-INPUT
                                   =   SPACE )
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
      *----(01.00.02) LINE ADD START ----------------------------------
           MOVE    SPACE           TO  ORCSKANACHKAREA
      *----(01.00.02) LINE ADD END   ----------------------------------
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    WRK-KANACHK-MAE-INPUT
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    NOT =   ZERO )
               MOVE    1           TO  FLG-ENTRYCHK
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
      *    全角でない場合はエラーとする。
           IF      ( KANACHK-SYUBETU   NOT =   2 )
               MOVE    1           TO  FLG-ENTRYCHK
           END-IF
      *
           .
       800-ENRTRY-CHK-EXT.
           EXIT.
      *****************************************************************
      *    ＳＱＬ条件編集処理１
      *****************************************************************
       900-SQL-JYOKEN-EDIT1-SEC            SECTION.
      *
           IF  ( FLG-JYOKEN        =   1 )
               STRING " and "      DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER     WRK-SQL-PNT
               END-STRING
           END-IF
      *
           STRING  "(("                        DELIMITED   BY  SIZE
                   WRK-SQL-TBL-NAME            DELIMITED   BY  SPACE
                   ".hospid='"                 DELIMITED   BY  SIZE
                   SPA-HOSPID                  DELIMITED   BY  SIZE
                   "')and("                    DELIMITED   BY  SIZE
                   WRK-SQL-TBL-NAME            DELIMITED   BY  SPACE
                   ".ptid=a.ptid) "            DELIMITED   BY  SIZE
                   "and"                       DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           .
       900-SQL-JYOKEN-EDIT1-EXT.
           EXIT.
      *****************************************************************
      *    ＳＱＬ条件編集処理２
      *****************************************************************
       900-SQL-JYOKEN-EDIT2-SEC            SECTION.
      *
           IF  ( CNT-JYOKEN    =   1 )
               IF  (   FLG-JYOKEN-AND  =   "1" )
                   STRING  " and "         DELIMITED   BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-IF
      *
               STRING  "("                 DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           ELSE
               STRING  "or "               DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
      *
           .
       900-SQL-JYOKEN-EDIT2-EXT.
           EXIT.
      *****************************************************************
      *    ＳＱＬ条件編集処理３
      *****************************************************************
       900-SQL-JYOKEN-EDIT3-SEC            SECTION.
      *
           IF  ( CNT-JYOKEN    >   0 )
               STRING  ")"      DELIMITED   BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
               MOVE    1           TO  FLG-JYOKEN-AND
           END-IF
      *
           .
       900-SQL-JYOKEN-EDIT3-EXT.
           EXIT.
      *****************************************************************
      *    ＳＱＬ条件編集処理４
      *****************************************************************
       900-SQL-JYOKEN-EDIT4-SEC            SECTION.
      *
           STRING  ")"         DELIMITED   BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER     WRK-SQL-PNT
           END-STRING
      *
           .
       900-SQL-JYOKEN-EDIT4-EXT.
           EXIT.
      *****************************************************************
      *    文字列長取得処理
      *****************************************************************
       900-STR-LEN-GET-SEC                 SECTION.
      *
           PERFORM VARYING IDX-LEN FROM    WRK-STR-LEN BY  -1
               UNTIL   ( IDX-LEN   <   1)
                OR     ( WRK-STR (IDX-LEN : 1) NOT =   SPACE)
      *
               CONTINUE
           END-PERFORM
      *
           MOVE    IDX-LEN     TO  WRK-STR-LEN
      *
           .
       900-STR-LEN-GET-EXT.
           EXIT.
      *****************************************************************
      *    患者マスタ検索処理
      *****************************************************************
       910-PTINF-SELECT-SEC            SECTION.
      *
      *    INITIALIZE                  MCPAREA
           MOVE    PATH-QUERY-PTINF-KEY
                                       TO  MCP-PATH
           MOVE    SPACE               TO  QUERY-PTINF-REC
           MOVE    WRK-SQL             TO  QUERY-PTINF-SQL
           MOVE    QUERY-PTINF-REC     TO  MCPDATA-REC
           PERFORM 910-DB-SELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-PTINF
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       910-PTINF-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    患者マスタ読込処理
      *****************************************************************
       910-PTINF-READ-SEC              SECTION.
      *
      *    INITIALIZE              MCPAREA
           MOVE    PATH-QUERY-PTINF-KEY
                                       TO  MCP-PATH
           MOVE    SPACE               TO  MCPDATA-REC
           PERFORM 910-DB-READ-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-PTINF
               MOVE    MCPDATA-REC     TO  QUERY-PTINF-REC
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       910-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者マスタ読み飛ばし処理
      *****************************************************************
       910-PTINF-READ-SKIP-SEC         SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1        >       SPA-GMN-Q02-SKIP-KNS )
                 OR      ( FLG-PTINF   =       "1" )
      *
      *        患者マスタ読込処理
               PERFORM 910-PTINF-READ-SEC
      *
           END-PERFORM
      *
           .
       910-PTINF-READ-SKIP-EXT.
           EXIT.
      *****************************************************************
      *    患者マスタクローズ処理
      *****************************************************************
       910-PTINF-CLOSE-SEC             SECTION.
      *
      *    INITIALIZE              MCPAREA
           MOVE    PATH-QUERY-PTINF-KEY
                                       TO  MCP-PATH
           MOVE    SPACE               TO  MCPDATA-REC
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       910-PTINF-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DB-SELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"    USING   MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DB-READ-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"    USING   MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-FETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                SECTION.
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           CALL    "MCPSUB"    USING   MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    ジョブ開始セット処理
      *****************************************************************
       900-JOBKANRI-HENSYU-SEC         SECTION.
      *
           MOVE    "DEL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CONST-JOBID     TO  JOB-JOBID
           MOVE    CONST-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
      *
           MOVE    "JBS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CONST-JOBID     TO  JOB-JOBID
           MOVE    CONST-JOB-SHELLID
                                   TO  JOB-SHELLID
           MOVE    SPA-TERMID      TO  JOB-TERMID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC
      *
           .
       900-JOBKANRI-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理チェック処理
      *****************************************************************
       900-JOBKANRI-CHK-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-JOBEND
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CONST-JOBID     TO  JOB-JOBID
           MOVE    CONST-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
           IF    ( SJOBKANRI-RETURN    =   ZERO )
               IF    ( JOB-ENDYMD      =   SPACE )
                   CONTINUE
               ELSE
                   MOVE    1           TO  FLG-JOBEND
                   GO  TO  900-JOBKANRI-CHK-EXT
               END-IF
           ELSE
                   MOVE    2           TO  FLG-JOBEND
           END-IF
      *
           .
       900-JOBKANRI-CHK-EXT.
           EXIT.
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE    "PUTWINDOW"     TO  MCP-FUNC.
           CALL    "MCPSUB"    USING   MCPAREA
                                       MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.

      *----(01.00.XX) LINE ADD START ----------------------------------
      *----(01.00.XX) LINE ADD END   ----------------------------------
      *----(01.00.XX) LINE DEL START ----------------------------------
      *----(01.00.XX) LINE DEL END   ----------------------------------
      *----(01.00.XX) LINE UPD START ----------------------------------
      *----(01.00.XX) LINE UPD END   ----------------------------------
