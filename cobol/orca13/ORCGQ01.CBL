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
       PROGRAM-ID.                     ORCGQ01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者照会
      *  コンポーネント名  : 基本情報（Ｑ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/03/19    MCC−太田　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-太田     01/06/04 +性別コンボに男女を追加
      *                                    +診察年月日(F2)クリア対応
      *                                    +最終受診日を範囲指定式に変更
      *                                    +患者番号を範囲指定式に変更
      *                                    +病名追加
      *                                    +診療行為追加
      * 01.00.02     MCC-太田     02/06/26 +ジョブ管理ＤＢ追加
      *                                    +画面ＱＩＤ１を
      *                                    |Ｑ１００に名称変更
      *                                    +新たにＱＩＤ１を追加
      *                                    +病名の初期化不具合を修正
      *                                    +診療行為の初期化不具合を修正
      *                                    +検索結果に年齢を表示させる
      *                                    +最終受診日の未来日入力可に
      *                                    +病名を入力可能に
      *                                    +保険者名を追加
      *                                    +保険の種類を追加
      *                                    +公費の種類をコンボに変更
      *                                    +テスト患者を検索から
      *                                    |外せるようにする
      *                                    +診療行為で、
      *                                    |老人の場合は［老］を付加
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
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
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-PTINF                           PIC 9(01).
           03  FLG-ADRS                            PIC 9(01).
           03  FLG-BYOMEI                          PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-INPUTCD                         PIC 9(01).
           03  FLG-USERBYOMEI                      PIC 9(01).
      *----(01.00.02) LINE ADD START ----------------------------------
           03  FLG-HKNNUM                          PIC 9(01).
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           03  FLG-OK                              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(04).
           03  IDX2                                PIC 9(04).
           03  IDX3                                PIC 9(04).
           03  IDX4                                PIC 9(04).
      *----(01.00.02) LINE ADD START ----------------------------------
           03  IDX5                                PIC 9(04).
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ADRS                            PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SELNO                           PIC 9(03).
           03  WRK-YMD                             PIC X(10). 
           03  WRK-SYMD.
               05  WRK-SYY                         PIC 9(04).
               05  WRK-SMM                         PIC 9(02).
               05  WRK-SDD                         PIC 9(02).
           03  WRK-HENYMDG                         PIC X(09).
           03  WRK-BYOMEICD                        PIC X(20).
           03  WRK-SRYCD                           PIC X(20).
           03  WRK-MOJI                            PIC 9(03).
           03  WRK-CDSYUBETU                       PIC X(01).
           03  WRK-HIZUKE-CALC-AREA.
               05  WRK-HIZUKE-YY                   PIC 9(04).
               05  WRK-HIZUKE-MM                   PIC 9(02).
               05  WRK-HIZUKE-DD                   PIC 9(02).
           03  WRK-EDITADRS-NAME                   PIC X(220).
           03  WRK-IDX                             PIC 9(04).
           03  WRK-BYOBUN-COUNT                    PIC 9(04).
           03  WRK-CNB-BYOBUN-ITEM-AREA.
               05  WRK-CNB-BYOBUNCD                PIC X(3)
                                                   OCCURS  100.
               05  WRK-CNB-BYOBUN-ITEM             PIC X(20)
                                                   OCCURS  100.
           03  WRK-RDBYOMEI-A-STATE                PIC S9(9)
                                                   BINARY.
           03  WRK-BYOBUNCD                        PIC X(3).
      *----(01.00.01) LINE ADD START ----------------------------------
           03  WRK-PTNUM                           PIC X(20).
           03  WRK-PTNUM-WK                        PIC X(20).
           03  WRK-PTNUM-KETA                      PIC 9(05).
           03  WRK-SYS-KETA                        PIC 9(05).
           03  WRK-SYS-KETA2                       PIC 9(05).
           03  WRK-ST                              PIC 9(05).
      *----(01.00.01) LINE ADD END   ----------------------------------
           03  WRK-IDX                             PIC 9(05).
      *
       01  WRK-WIDGET-AREA.
           03  WRK-WIDGET                          PIC X(20).
      *
           03  WRK-WIDGET-R1   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R1-DAMMY1            PIC X(02).
               05  WRK-WIDGET1                     PIC 9(01).
               05  WRK-WIDGET-R1-DAMMY2            PIC X(17).
      *
           03  WRK-WIDGET-R2   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R2-DAMMY1            PIC X(03).
               05  WRK-WIDGET2                     PIC 9(01).
               05  WRK-WIDGET-R2-DAMMY2            PIC X(16).
      *
           03  WRK-WIDGET-R3   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R3-DAMMY1            PIC X(04).
               05  WRK-WIDGET3                     PIC 9(01).
               05  WRK-WIDGET-R3-DAMMY2            PIC X(15).
      *
           03  WRK-WIDGET-R4   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R4-DAMMY1            PIC X(05).
               05  WRK-WIDGET4                     PIC 9(01).
               05  WRK-WIDGET-R4-DAMMY2            PIC X(14).
      *
           03  WRK-WIDGET-R5   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R5-DAMMY1            PIC X(06).
               05  WRK-WIDGET5                     PIC 9(01).
               05  WRK-WIDGET-R5-DAMMY2            PIC X(13).
      *
           03  WRK-WIDGET-R6   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R6-DAMMY1            PIC X(07).
               05  WRK-WIDGET6                     PIC 9(01).
               05  WRK-WIDGET-R6-DAMMY2            PIC X(12).
      *
           03  WRK-WIDGET-R7   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R7-DAMMY1            PIC X(08).
               05  WRK-WIDGET7                     PIC 9(01).
               05  WRK-WIDGET-R7-DAMMY2            PIC X(11).
      *
      *----(01.00.01) LINE ADD START ----------------------------------
      *    固定値領域
       01  CONST-AREA.
           03  CONST-SEX-AREA.
               05  FILLER                          PIC X(10)
                   VALUE   "  すべて　".
               05  FILLER                          PIC X(10)
                   VALUE   "1 男性のみ".
               05  FILLER                          PIC X(10)
                   VALUE   "2 女性のみ".
           03  CONST-SEX-R         REDEFINES       CONST-SEX-AREA.
               05  CONST-SEX                       PIC X(10)
                                                   OCCURS  3.
      *
           03  CONST-KMK-ITEM-AREA.
               05  FILLER                          PIC X(30)
                   VALUE   "1 患者番号".
               05  FILLER                          PIC X(30)
                   VALUE   "2 カナ氏名".
               05  FILLER                          PIC X(30)
                   VALUE   "3 性別".
               05  FILLER                          PIC X(30)
                   VALUE   "4 生年月日".
               05  FILLER                          PIC X(30)
                   VALUE   "5 住所".
               05  FILLER                          PIC X(30)
                   VALUE   SPACE.
               05  FILLER                          PIC X(30)
                   VALUE   SPACE.
               05  FILLER                          PIC X(30)
                   VALUE   SPACE.
               05  FILLER                          PIC X(30)
                   VALUE   SPACE.
               05  FILLER                          PIC X(30)
                   VALUE   SPACE.
      *
           03  CONST-KMK-ITEM-R    REDEFINES       CONST-KMK-ITEM-AREA.
               05  CONST-KMK-ITEM                  PIC X(30)
                                                   OCCURS  10.
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    住所マスター
       01  ADRS-REC.
           COPY    "CPADRS.INC".
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *----(01.00.02) LINE ADD START ----------------------------------
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *----(01.00.02) LINE ADD END   ----------------------------------
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *    自院病名マスター
       01  USERBYOMEI-REC.
           COPY    "CPUSERBYOMEI.INC".
      *    自院マスター
       01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
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
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
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
           INITIALIZE                  IDX-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF  ( SPA-MOTOPG            =   "QERR" )
               MOVE    SPACE           TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "Q01"               TO  MCP-WINDOW
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
      *
      *    他のＬＤより
           IF  ( LINKAREA      NOT =   SPACE )
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    予約登録
      * xx WHEN    "Y01"
      *    受付一覧
      * xx WHEN    "U01"
      * xx     MOVE    LNK-COMMON      TO  SPA-KYOTUKEY
      * xx     MOVE    LNK-SCRSPA      TO  SPA-Q01FREE
      * xx     GO      TO      300-SCREEN-EXT
      *    検索結果画面
           WHEN    "Q02"
               PERFORM 310-Q02SPASET-SEC
               GO      TO      300-SCREEN-EXT
           WHEN    "Q98"
               PERFORM 310-Q98SPASET-SEC
               GO      TO      300-SCREEN-EXT
           WHEN    "Q99"
               PERFORM 310-Q99SPASET-SEC
               GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｑ０２戻りスパ編集処理
      *****************************************************************
       310-Q02SPASET-SEC              SECTION.
      *
      *    年齢から生年月日セットのとき元に戻す
           IF  ( SPA-GMN-Q01-STAGE NOT =   SPACE )
            OR ( SPA-GMN-Q01-EDAGE NOT =   SPACE )
               MOVE    ZERO                TO  SPA-Q01-STBIRTHDAY
                                               SPA-Q01-EDBIRTHDAY
           END-IF
      *
           MOVE    1               TO  SPA-GMN-Q01-CUR
      *
           .
       310-Q02SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｑ９８戻りスパ編集処理
      *****************************************************************
       310-Q98SPASET-SEC              SECTION.
      *
           IF  ( SPA-Q01-JYUSHO3   NOT =  SPACE )
               MOVE    SPA-Q01-JYUSHO3
                                   TO  SPA-GMN-Q01-JYUSHO
                                                   (SPA-Q01-JYUSHO-IDX2)
                                       SPA-Q01-JYUSHO
                                                   (SPA-Q01-JYUSHO-IDX2)
               MOVE    SPA-Q01-POST2
                                   TO  SPA-GMN-Q01-POST
                                                   (SPA-Q01-JYUSHO-IDX2)
           END-IF
      *
           .
       310-Q98SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｑ９９戻りスパ編集処理
      *****************************************************************
       310-Q99SPASET-SEC              SECTION.
      *
           IF  ( SPA-Q01-JYUSHO2   NOT =  SPACE )
               MOVE    SPA-Q01-JYUSHO2
                                   TO  SPA-GMN-Q01-JYUSHO
                                                   (SPA-Q01-JYUSHO-IDX)
                                       SPA-Q01-JYUSHO
                                                   (SPA-Q01-JYUSHO-IDX)
               MOVE    SPA-Q01-POST
                                   TO  SPA-GMN-Q01-POST
                                                   (SPA-Q01-JYUSHO-IDX)
               COMPUTE SPA-GMN-Q01-CUR
                                   =   SPA-GMN-Q01-CUR     +   1
           END-IF
      *
           .
       310-Q99SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-Q01
           INITIALIZE                      SPA-Q01
      *
           MOVE    SPACE               TO  SPA-Q01KYOUTU
           INITIALIZE                      SPA-Q01KYOUTU
      *
      *    タブページ番号
           MOVE    ZERO                TO  SPA-GMN-Q01-PAGENO
      *
      *    基準日開始日和暦
           MOVE    SPA-SYSYMDWH        TO  SPA-GMN-Q01-KJYNYMD
      *    基準日開始日西暦
           MOVE    SPA-SYSYMD          TO  SPA-Q01-KJYNYMD
      *
      *    性別コンボ
      *----(01.00.01) LINE DEL START ----------------------------------
      *    MOVE   "1 男"               TO  SPA-GMN-Q01-SEX-ITEM(1)
      *    MOVE   "2 女"               TO  SPA-GMN-Q01-SEX-ITEM(2)
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           MOVE    CONST-SEX (1)       TO  SPA-GMN-Q01-SEX
           MOVE    CONST-SEX-AREA      TO  SPA-GMN-Q01-SEX-ITEM-AREA
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
      *    テスト患者チェックボックス
           MOVE   "F"                  TO  SPA-GMN-Q01-CHKTSTPT
      *----(01.00.01) LINE DEL END   ----------------------------------
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *    保険の種類・公費の種類コンボ初期処理
           PERFORM 3101-HKNKOH-CMB-SYOKI-SEC
      *----(01.00.02) LINE ADD END   ----------------------------------
      *    病名検索コンボ初期処理
           PERFORM 3101-BYOMEI-CMB-SYOKI-SEC
      *    ソートキー項目初期処理
           PERFORM 3101-SORT-KMK-SYOKI-SEC
      *
      *     カーソルキー制御項目
            MOVE   1                   TO  SPA-GMN-Q01-CUR
           .
       310-SPASET-EXT.
           EXIT.
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    保険の種類・公費の種類コンボ初期処理
      *****************************************************************
       3101-HKNKOH-CMB-SYOKI-SEC       SECTION.
      *
           PERFORM 3101-HKNKOH-CMB-EDIT-SEC
      *
           PERFORM VARYING IDX5    FROM    2   BY  1
               UNTIL     ( IDX5    >   5 )
      *
               MOVE    SPA-GMN-Q01-CNB-HKNNUM-COUNT (1)
                           TO  SPA-GMN-Q01-CNB-HKNNUM-COUNT (IDX5)
               MOVE    SPA-GMN-Q01-CNB-HKNNUM-ITEM-AR (1)
                           TO  SPA-GMN-Q01-CNB-HKNNUM-ITEM-AR (IDX5)
      *
               MOVE    SPA-GMN-Q01-CNB-KOHNUM-COUNT (1)
                           TO  SPA-GMN-Q01-CNB-KOHNUM-COUNT (IDX5)
               MOVE    SPA-GMN-Q01-CNB-KOHNUM-ITEM-AR (1)
                           TO  SPA-GMN-Q01-CNB-KOHNUM-ITEM-AR (IDX5)
      *
           END-PERFORM
      *
           .
       3101-HKNKOH-CMB-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険の種類・公費の種類コンボ初期処理
      *****************************************************************
       3101-HKNKOH-CMB-EDIT-SEC        SECTION.
      *
           MOVE    SPACE       TO  SPA-GMN-Q01-CNB-HKNNUM-ITEM-AR (1)
           INITIALIZE              SPA-GMN-Q01-CNB-HKNNUM-ITEM-AR (1)
      *
           MOVE    SPACE       TO  SPA-GMN-Q01-CNB-KOHNUM-ITEM-AR (1)
           INITIALIZE              SPA-GMN-Q01-CNB-KOHNUM-ITEM-AR (1)
      *
      *    保険番号検索
           PERFORM 31011-HKNNUM-SELECT-SEC
           IF    ( FLG-HKNNUM      =   ZERO )
               CONTINUE
           ELSE
               GO  TO  3101-HKNKOH-CMB-EDIT-EXT
           END-IF
      *
      *    保険番号読み込み
           PERFORM 31011-HKNNUM-READ-SEC
      *
           PERFORM UNTIL ( FLG-HKNNUM      =   1 )
               MOVE    ZERO                TO  FLG-OK
               IF    ( HKN-HKNKOHSBTKBN    =   "1" OR  "4"
                                           OR  "8" OR  "9" )
                   MOVE    SPA-GMN-Q01-CNB-HKNNUM-COUNT (1)
                                           TO  IDX5
      *            保険
                   IF    ( IDX5            >   ZERO )
                       IF    ( HKN-HKNNUM
                               =   SPA-GMN-Q01-CNB-HKNNUM-ITEM (1 IDX5)
                                                               (1 : 3))
                           CONTINUE
                       ELSE
                           MOVE    1               TO  FLG-OK
                       END-IF
                   ELSE
                       MOVE    1               TO  FLG-OK
                   END-IF
      *
                   IF    ( FLG-OK              =   1 )
      *                保険情報編集
                       PERFORM 31011-HKNHEN-SEC
                   END-IF
               ELSE
      *            公費
                   MOVE    SPA-GMN-Q01-CNB-KOHNUM-COUNT  (1)
                                           TO  IDX5
                   IF    ( IDX5            >   ZERO )
                       IF    ( HKN-HKNNUM
                               =   SPA-GMN-Q01-CNB-KOHNUM-ITEM (1 IDX5)
                                                               (1 : 3))
                           CONTINUE
                       ELSE
                           MOVE    1               TO  FLG-OK
                       END-IF
                   ELSE
                       MOVE    1               TO  FLG-OK
                   END-IF
      *
                   IF    ( FLG-OK              =   1 )
      *                公費情報編集
                       PERFORM 31011-KOHHEN-SEC
                   END-IF
               END-IF
      *
      *        保険番号読み込み
               PERFORM 31011-HKNNUM-READ-SEC
           END-PERFORM
      *
      *    保険番号クローズ
           PERFORM 31011-HKNNUM-CLOSE-SEC
      *
           .
       3101-HKNKOH-CMB-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    保険番号マスター検索処理
      *****************************************************************
       31011-HKNNUM-SELECT-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNNUM
           INITIALIZE                  HKNNUM-REC
           MOVE    SPA-HOSPID          TO  HKN-HOSPID
           MOVE    SPA-SYSYMD          TO  HKN-TEKSTYMD
           MOVE    SPA-SYSYMD          TO  HKN-TEKEDYMD
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    "HKNNUM-KEY3"       TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
           IF ( MCP-RC             NOT =   ZERO )
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           .
      *
       31011-HKNNUM-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    保険番号マスター読込処理
      *****************************************************************
       31011-HKNNUM-READ-SEC       SECTION.
      *
           MOVE    "HKNNUM-KEY3"       TO  ORC-DBPATH
      *
           PERFORM 910-DB-READ-SEC
           IF  ( MCP-RC        =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
           ELSE
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           .
      *
       31011-HKNNUM-READ-EXT.
           EXIT.
      *****************************************************************
      *    保険番号マスタークローズ処理
      *****************************************************************
       31011-HKNNUM-CLOSE-SEC      SECTION.
      *
           MOVE    "HKNNUM-KEY3"       TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       31011-HKNNUM-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    保険情報編集処理
      *****************************************************************
       31011-HKNHEN-SEC          SECTION.
      *
           COMPUTE SPA-GMN-Q01-CNB-HKNNUM-COUNT (1)
               =   SPA-GMN-Q01-CNB-HKNNUM-COUNT (1)    +   1
      *
           MOVE    SPA-GMN-Q01-CNB-HKNNUM-COUNT (1)
                                       TO  IDX5
      *
           MOVE    HKN-HKNNUM          TO  SPA-GMN-Q01-CNB-HKNNUM-ITEM 
                                                        (1 IDX5)(1:3)
           MOVE    HKN-TANSEIDONAME    TO  SPA-GMN-Q01-CNB-HKNNUM-ITEM
                                                        (1 IDX5)(5: )
      *
           .
       31011-HKNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費情報編集処理
      *****************************************************************
       31011-KOHHEN-SEC          SECTION.
      *
           COMPUTE SPA-GMN-Q01-CNB-KOHNUM-COUNT (1)
               =   SPA-GMN-Q01-CNB-KOHNUM-COUNT (1)    +   1
      *
           MOVE    SPA-GMN-Q01-CNB-KOHNUM-COUNT (1)
                                       TO  IDX5
      *
           MOVE    HKN-HKNNUM          TO  SPA-GMN-Q01-CNB-KOHNUM-ITEM
                                                        (1 IDX5)(1:3)
           IF    ( HKN-HKNNUM          =   "027" )
               MOVE    "老人保健"      TO  SPA-GMN-Q01-CNB-KOHNUM-ITEM
                                                        (1 IDX5)(5: )
           ELSE
               MOVE    HKN-TANSEIDONAME
                                       TO  SPA-GMN-Q01-CNB-KOHNUM-ITEM
                                                        (1 IDX5)(5: )
           END-IF
      *
           .
       31011-KOHHEN-EXT.
           EXIT.
      *
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    病名検索コンボ初期処理
      *****************************************************************
       3101-BYOMEI-CMB-SYOKI-SEC       SECTION.
      *
           MOVE    "T"             TO  SPA-GMN-Q01-RDBYOMEI-U
           MOVE    "F"             TO  SPA-GMN-Q01-RDBYOMEI-A
           MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-Q01-BYOBUN-STATE
                                       SPA-GMN-Q01-CNB-BYOBUN-STATE
                                       SPA-GMN-Q01-RDBYOMEI-U-STATE
                                       SPA-GMN-Q01-RDBYOMEI-A-STATE
      *
           MOVE    ZERO            TO  SPA-GMN-Q01-CNB-BYOBUN-COUNT
      *
           INITIALIZE                  USERBYOMEI-REC
           MOVE    SPA-HOSPID          TO  USBYO-HOSPID
      *    自院病名マスタ−検索処理
           PERFORM 31011-USERBYOMEI-SELECT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   98)
                OR       ( FLG-USERBYOMEI  NOT =   ZERO )
      *        自院病名マスタ−読込処理
               PERFORM 31011-USERBYOMEI-READ-SEC
               IF  ( FLG-USERBYOMEI    =   ZERO )
                   MOVE    IDX1    TO  SPA-GMN-Q01-CNB-BYOBUN-COUNT
                   MOVE    USBYO-BYOMEIINPUTCD
                                   TO  SPA-GMN-Q01-CNB-BYOBUNCD
                                                               (IDX1)
                   MOVE    USBYO-BYOMEI
                                   TO  SPA-GMN-Q01-CNB-BYOBUN-ITEM
                                                               (IDX1)
               END-IF
           END-PERFORM
      *
      *    自院病名マスタ−クローズ処理
           PERFORM 31011-USERBYOMEI-CLOSE-SEC
      *
      *    分類コード設定データが存在したかチェック
           IF  ( SPA-GMN-Q01-CNB-BYOBUN-COUNT  =   ZERO )
      *
      *        xxx 存在しなかった場合 xxx
      *        自院病名マスタ−読込処理２（データ存在チェック）
               INITIALIZE              USERBYOMEI-REC
               MOVE    SPA-HOSPID  TO  USBYO-HOSPID
               PERFORM 31012-USERBYOMEI-READ-SEC
      *
      *        分類コードが設定されていないデータが存在したかチェック
               IF  ( FLG-USERBYOMEI    =   ZERO )
                   MOVE    "NON"   TO  SPA-GMN-Q01-CNB-BYOBUNCD (1)
                   MOVE    "分類なし"
                                   TO  SPA-GMN-Q01-CNB-BYOBUN-ITEM (1)
                   MOVE    "ALL"   TO  SPA-GMN-Q01-CNB-BYOBUNCD (2)
                   MOVE    "すべて"
                                   TO  SPA-GMN-Q01-CNB-BYOBUN-ITEM (2)
                   MOVE    2       TO  SPA-GMN-Q01-CNB-BYOBUN-COUNT
               ELSE
                   MOVE    "F"     TO  SPA-GMN-Q01-RDBYOMEI-U
                   MOVE    "T"     TO  SPA-GMN-Q01-RDBYOMEI-A
                   MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-Q01-BYOBUN-STATE
                                       SPA-GMN-Q01-CNB-BYOBUN-STATE
                                       SPA-GMN-Q01-RDBYOMEI-U-STATE
                                       SPA-GMN-Q01-RDBYOMEI-A-STATE
               END-IF
           ELSE
      *
      *        xxx 存在した場合 xxx
               MOVE    SPA-GMN-Q01-CNB-BYOBUN-COUNT
                                   TO  IDX1
      *
               COMPUTE IDX1        =   IDX1    +   1
               MOVE    "NON"   TO  SPA-GMN-Q01-CNB-BYOBUNCD (IDX1)
               MOVE    "分類なし"  TO  SPA-GMN-Q01-CNB-BYOBUN-ITEM
                                                               (IDX1)
      *
               COMPUTE IDX1        =   IDX1    +   1
               MOVE    "ALL"   TO  SPA-GMN-Q01-CNB-BYOBUNCD (IDX1)
               MOVE    "すべて"    TO  SPA-GMN-Q01-CNB-BYOBUN-ITEM
                                                               (IDX1)
      *
               MOVE    IDX1        TO  SPA-GMN-Q01-CNB-BYOBUN-COUNT
           END-IF
      *
           .
       3101-BYOMEI-CMB-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    自院病名マスター検索処理
      *****************************************************************
       31011-USERBYOMEI-SELECT-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-USERBYOMEI
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "USERBYOMEI-KEY9"   TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
           IF ( MCP-RC             NOT =   ZERO )
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
           .
      *
       31011-USERBYOMEI-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    自院病名マスター読込処理
      *****************************************************************
       31011-USERBYOMEI-READ-SEC       SECTION.
      *
           MOVE    "USERBYOMEI-KEY9"   TO  ORC-DBPATH
      *
           PERFORM 910-DB-READ-SEC
           IF  ( MCP-RC        =   ZERO )
               MOVE    MCPDATA-REC     TO  USERBYOMEI-REC
           ELSE
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
           .
      *
       31011-USERBYOMEI-READ-EXT.
           EXIT.
      *****************************************************************
      *    自院病名マスタークローズ処理
      *****************************************************************
       31011-USERBYOMEI-CLOSE-SEC      SECTION.
      *
           MOVE    "USERBYOMEI-KEY9"   TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       31011-USERBYOMEI-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    自院病名マスター読込処理２（データ存在チェック）
      *****************************************************************
       31012-USERBYOMEI-READ-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-USERBYOMEI
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "USERBYOMEI-KEY3"   TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
           IF ( MCP-RC             =   ZERO )
               MOVE    "USERBYOMEI-KEY3"
                                       TO  ORC-DBPATH
      *
               PERFORM 910-DB-READ-SEC
               IF  ( MCP-RC        =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1           TO  FLG-USERBYOMEI
               END-IF
           ELSE
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           MOVE    "USERBYOMEI-KEY3"   TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
      *
       31012-USERBYOMEI-READ-EXT.
           EXIT.
      *****************************************************************
      *    ソートキー項目初期処理
      *****************************************************************
       3101-SORT-KMK-SYOKI-SEC             SECTION.
      *
      *    ソートキーコンボに表示させる項目とその中身
      *----(01.00.01) LINE DEL START ----------------------------------
      *    ＜カナ氏名＞
      *     MOVE   "1 カナ氏名"        TO  SPA-GMN-Q01-KMK (1)
      *                                    SPA-GMN-Q01-KMK-ITEM(1, 1)
      *                                    SPA-GMN-Q01-KMK-ITEM(2, 1)
      *                                    SPA-GMN-Q01-KMK-ITEM(3, 1)
      *    ＜性別＞
      *     MOVE   "2 性別"            TO  SPA-GMN-Q01-KMK (2)
      *                                    SPA-GMN-Q01-KMK-ITEM(1, 2)
      *                                    SPA-GMN-Q01-KMK-ITEM(2, 2)
      *                                    SPA-GMN-Q01-KMK-ITEM(3, 2)
      *    ＜生年月日＞
      *     MOVE   "3 生年月日"        TO  SPA-GMN-Q01-KMK (3)
      *                                    SPA-GMN-Q01-KMK-ITEM(1, 3)
      *                                    SPA-GMN-Q01-KMK-ITEM(2, 3)
      *                                    SPA-GMN-Q01-KMK-ITEM(3, 3)
      *    ＜住所＞
      *     MOVE   "4 住所"            TO  SPA-GMN-Q01-KMK-ITEM(1, 4)
      *                                    SPA-GMN-Q01-KMK-ITEM(2, 4)
      *                                    SPA-GMN-Q01-KMK-ITEM(3, 4)
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           MOVE    CONST-KMK-ITEM (1)  TO  SPA-GMN-Q01-KMK (1)
           MOVE    CONST-KMK-ITEM (2)  TO  SPA-GMN-Q01-KMK (2)
           MOVE    CONST-KMK-ITEM (3)  TO  SPA-GMN-Q01-KMK (3)
      *
           MOVE    CONST-KMK-ITEM-AREA
                                       TO  SPA-GMN-Q01-KMK-ITEM-AREA (1)
                                           SPA-GMN-Q01-KMK-ITEM-AREA (2)
                                           SPA-GMN-Q01-KMK-ITEM-AREA (3)
      *----(01.00.01) LINE ADD END   ----------------------------------
      *    ソートキー並び順ラジオボタン
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   3 )
      *
               MOVE    "T"             TO  SPA-GMN-Q01-RDIO1 (IDX1)
               MOVE    "F"             TO  SPA-GMN-Q01-RDIO2 (IDX1)
      *
           END-PERFORM
      *
           .
       3101-SORT-KMK-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                         SECTION.
      *
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *    条件クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 480-CLEAR-SEC
      *    予約登録へ
      * xx     WHEN    "CLICKED"       ALSO    "B10"
      * xx         PERFORM 480-YOYAKU-SEC
      *    受付一覧へ
      * xx     WHEN    "CLICKED"       ALSO    "B11"
      * xx         PERFORM 490-UKEICHI-SEC
      *    タグ切替
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 480-TAGSWITCH-SEC
      *    検索
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-KENSAKU-SEC
      *----(01.00.02) LINE ADD START ----------------------------------
      *    テスト患者チェックボタン
               WHEN    "CLICKED"       ALSO    "CHKTSTPT"
                   PERFORM 410-CHKTSTPT-SET-SEC
      *----(01.00.02) LINE ADD END   ----------------------------------
      *    住所ボタン
               WHEN    "CLICKED"       ALSO    "JYUSHOBT1"
               WHEN    "CLICKED"       ALSO    "JYUSHOBT2"
               WHEN    "CLICKED"       ALSO    "JYUSHOBT3"
               WHEN    "CLICKED"       ALSO    "JYUSHOBT4"
               WHEN    "CLICKED"       ALSO    "JYUSHOBT5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 410-JYUSHO-SET-SEC
      *    病名コード編集
               WHEN    "CLICKED"       ALSO    "BYOBT1"
               WHEN    "CLICKED"       ALSO    "BYOBT2"
               WHEN    "CLICKED"       ALSO    "BYOBT3"
               WHEN    "CLICKED"       ALSO    "BYOBT4"
               WHEN    "CLICKED"       ALSO    "BYOBT5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 420-BYOMEICD-SET-SEC
      *    診療行為コード編集
               WHEN    "CLICKED"       ALSO    "SRYBT1"
               WHEN    "CLICKED"       ALSO    "SRYBT2"
               WHEN    "CLICKED"       ALSO    "SRYBT3"
               WHEN    "CLICKED"       ALSO    "SRYBT4"
               WHEN    "CLICKED"       ALSO    "SRYBT5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 430-SRYCD-SET-SEC
      *    病名検索トグルボタン
               WHEN    "CLICKED"       ALSO    "RDBYOMEI_U"
                   MOVE    WIDGET-NORMAL
                                        TO  SPA-GMN-Q01-BYOBUN-STATE
                                            SPA-GMN-Q01-CNB-BYOBUN-STATE
                   MOVE    "T"          TO  SPA-GMN-Q01-RDBYOMEI-U
                   MOVE    "F"          TO  SPA-GMN-Q01-RDBYOMEI-A
               WHEN    "CLICKED"       ALSO    "RDBYOMEI_A"
                   MOVE    WIDGET-INSENSITIVE
                                        TO  SPA-GMN-Q01-BYOBUN-STATE
                                            SPA-GMN-Q01-CNB-BYOBUN-STATE
                   MOVE    SPACE        TO  SPA-GMN-Q01-BYOBUN
                   MOVE    "F"          TO  SPA-GMN-Q01-RDBYOMEI-U
                   MOVE    "T"          TO  SPA-GMN-Q01-RDBYOMEI-A
                   IF  ( SPA-GMN-Q01-CUR   =   301 )
                       MOVE    302      TO  SPA-GMN-Q01-CUR
                   END-IF
      *    並び順トグルボタン
               WHEN    "CLICKED"       ALSO    "RDIO11"
                   MOVE    "T"          TO  SPA-GMN-Q01-RDIO1 (1)
                   MOVE    "F"          TO  SPA-GMN-Q01-RDIO2 (1)
               WHEN    "CLICKED"       ALSO    "RDIO12"
                   MOVE    "F"          TO  SPA-GMN-Q01-RDIO1 (1)
                   MOVE    "T"          TO  SPA-GMN-Q01-RDIO2 (1)
               WHEN    "CLICKED"       ALSO    "RDIO21"
                   MOVE    "T"          TO  SPA-GMN-Q01-RDIO1 (2)
                   MOVE    "F"          TO  SPA-GMN-Q01-RDIO2 (2)
               WHEN    "CLICKED"       ALSO    "RDIO22"
                   MOVE    "F"          TO  SPA-GMN-Q01-RDIO1 (2)
                   MOVE    "T"          TO  SPA-GMN-Q01-RDIO2 (2)
               WHEN    "CLICKED"       ALSO    "RDIO31"
                   MOVE    "T"          TO  SPA-GMN-Q01-RDIO1 (3)
                   MOVE    "F"          TO  SPA-GMN-Q01-RDIO2 (3)
               WHEN    "CLICKED"       ALSO    "RDIO32"
                   MOVE    "F"          TO  SPA-GMN-Q01-RDIO1 (3)
                   MOVE    "T"          TO  SPA-GMN-Q01-RDIO2 (3)
      *    タグ
               WHEN    "CLICKED"       ALSO    "N01"
               WHEN    "CLICKED"       ALSO    "N02"
               WHEN    "CLICKED"       ALSO    "N03"
               WHEN    "CLICKED"       ALSO    "N04"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
      *
                   PERFORM 440-TAG-CHANGE-SEC
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
      *    基本情報タグ
      *        開始診療年月チェック
               WHEN    "ACTIVATE"      ALSO    "STSRYYMD"
                   PERFORM 4100-STSRYYMD-CHK-SEC
      *        終了診療年月チェック
               WHEN    "ACTIVATE"      ALSO    "EDSRYYMD"
                   PERFORM 4101-EDSRYYMD-CHK-SEC
      *        開始生年月日チェック
               WHEN    "ACTIVATE"      ALSO    "STBIRTHDAY"
                   PERFORM 4102-STBIRTHDAY-CHK-SEC
      *        終了生年月日チェック
               WHEN    "ACTIVATE"      ALSO    "EDBIRTHDAY"
                   PERFORM 4103-EDBIRTHDAY-CHK-SEC
      *        開始年齢チェック
               WHEN    "ACTIVATE"      ALSO    "STAGE"
                   PERFORM 4104-STAGE-CHK-SEC
      *        終了年齢チェック
               WHEN    "ACTIVATE"      ALSO    "EDAGE"
                   PERFORM 4105-EDAGE-CHK-SEC
      *        基準日チェック
               WHEN    "ACTIVATE"      ALSO    "KJYNYMD"
                   PERFORM 4106-KJYNYMD-CHK-SEC
      *        性別チェック
               WHEN    "ACTIVATE"      ALSO    "SEX"
                   PERFORM 4107-SEX-CHK-SEC
      *----(01.00.01) LINE DEL START ----------------------------------
      *        最終受診日チェック
      *        WHEN    "ACTIVATE"      ALSO    "LASTYMD"
      *            PERFORM 4108-LASTYMD-CHK-SEC
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
      *        開始最終受診日チェック
               WHEN    "ACTIVATE"      ALSO    "STLASTYMD"
                   PERFORM 4108-STLASTYMD-CHK-SEC
      *        終了最終受診日チェック
               WHEN    "ACTIVATE"      ALSO    "EDLASTYMD"
                   PERFORM 4108-EDLASTYMD-CHK-SEC
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.01) LINE DEL START ----------------------------------
      *        患者番号チェック
      *        WHEN    "ACTIVATE"      ALSO    "PTNUM1"
      *        WHEN    "ACTIVATE"      ALSO    "PTNUM2"
      *        WHEN    "ACTIVATE"      ALSO    "PTNUM3"
      *        WHEN    "ACTIVATE"      ALSO    "PTNUM4"
      *        WHEN    "ACTIVATE"      ALSO    "PTNUM5"
      *            MOVE    MCP-WIDGET   TO  WRK-WIDGET
      *            PERFORM 4109-PTNUM-CHK-SEC
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
      *        開始患者番号チェック
               WHEN    "ACTIVATE"      ALSO    "STPTNUM"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4109-STPTNUM-CHK-SEC
      *        終了患者番号チェック
               WHEN    "ACTIVATE"      ALSO    "EDPTNUM"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4109-EDPTNUM-CHK-SEC
      *----(01.00.01) LINE ADD END   ----------------------------------
      *        郵便番号チェック
               WHEN    "ACTIVATE"      ALSO    "POST1"
               WHEN    "ACTIVATE"      ALSO    "POST2"
               WHEN    "ACTIVATE"      ALSO    "POST3"
               WHEN    "ACTIVATE"      ALSO    "POST4"
               WHEN    "ACTIVATE"      ALSO    "POST5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4110-POST-CHK-SEC
      *        住所チェック
               WHEN    "ACTIVATE"      ALSO    "JYUSHO1"
               WHEN    "ACTIVATE"      ALSO    "JYUSHO2"
               WHEN    "ACTIVATE"      ALSO    "JYUSHO3"
               WHEN    "ACTIVATE"      ALSO    "JYUSHO4"
               WHEN    "ACTIVATE"      ALSO    "JYUSHO5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4110-JYUSHO-CHK-SEC
      *        カナ氏名チェック
               WHEN    "ACTIVATE"      ALSO    "KANANAME1"
               WHEN    "ACTIVATE"      ALSO    "KANANAME2"
               WHEN    "ACTIVATE"      ALSO    "KANANAME3"
               WHEN    "ACTIVATE"      ALSO    "KANANAME4"
               WHEN    "ACTIVATE"      ALSO    "KANANAME5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4111-KANANAME-CHK-SEC
      *        漢字氏名チェック
               WHEN    "ACTIVATE"      ALSO    "NAME1"
               WHEN    "ACTIVATE"      ALSO    "NAME2"
               WHEN    "ACTIVATE"      ALSO    "NAME3"
               WHEN    "ACTIVATE"      ALSO    "NAME4"
               WHEN    "ACTIVATE"      ALSO    "NAME5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4112-NAME-CHK-SEC
      *        コメントチェック
               WHEN    "ACTIVATE"      ALSO    "COMMENT1"
               WHEN    "ACTIVATE"      ALSO    "COMMENT2"
               WHEN    "ACTIVATE"      ALSO    "COMMENT3"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4113-COMMENT-CHK-SEC
      *    保険　公費タグ
      *----(01.00.02) LINE ADD START ----------------------------------
               WHEN    "ACTIVATE"      ALSO    "HKNJANUM1"
               WHEN    "ACTIVATE"      ALSO    "HKNJANUM2"
               WHEN    "ACTIVATE"      ALSO    "HKNJANUM3"
               WHEN    "ACTIVATE"      ALSO    "HKNJANUM4"
               WHEN    "ACTIVATE"      ALSO    "HKNJANUM5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4114-HKNJANUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNNUM1"
               WHEN    "ACTIVATE"      ALSO    "HKNNUM2"
               WHEN    "ACTIVATE"      ALSO    "HKNNUM3"
               WHEN    "ACTIVATE"      ALSO    "HKNNUM4"
               WHEN    "ACTIVATE"      ALSO    "HKNNUM5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4114-HKNNUM-CHK-SEC
      *----(01.00.02) LINE ADD END   ----------------------------------
               WHEN    "ACTIVATE"      ALSO    "KIGO1"
               WHEN    "ACTIVATE"      ALSO    "KIGO2"
               WHEN    "ACTIVATE"      ALSO    "KIGO3"
               WHEN    "ACTIVATE"      ALSO    "KIGO4"
               WHEN    "ACTIVATE"      ALSO    "KIGO5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4114-KIGO-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NUM1" 
               WHEN    "ACTIVATE"      ALSO    "NUM2" 
               WHEN    "ACTIVATE"      ALSO    "NUM3" 
               WHEN    "ACTIVATE"      ALSO    "NUM4" 
               WHEN    "ACTIVATE"      ALSO    "NUM5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4115-NUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "KOHNUM1"  
               WHEN    "ACTIVATE"      ALSO    "KOHNUM2"  
               WHEN    "ACTIVATE"      ALSO    "KOHNUM3"  
               WHEN    "ACTIVATE"      ALSO    "KOHNUM4"  
               WHEN    "ACTIVATE"      ALSO    "KOHNUM5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4116-KOHNUM-CHK-SEC  
               WHEN    "ACTIVATE"      ALSO    "FTNJANUM1"  
               WHEN    "ACTIVATE"      ALSO    "FTNJANUM2"  
               WHEN    "ACTIVATE"      ALSO    "FTNJANUM3"  
               WHEN    "ACTIVATE"      ALSO    "FTNJANUM4"  
               WHEN    "ACTIVATE"      ALSO    "FTNJANUM5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4117-FTNJANUM-CHK-SEC                
      *    病名　診療行為タグ
               WHEN    "ACTIVATE"      ALSO    "BYOBUN"
                   PERFORM 4118-BYOBUN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BYOMEISEL"
                   PERFORM 4118-BYOMEISEL-CHK-SEC
               WHEN    "ACTIVATE"      ALSO   "BYOMEICD1"
               WHEN    "ACTIVATE"      ALSO   "BYOMEICD2"
               WHEN    "ACTIVATE"      ALSO   "BYOMEICD3"
               WHEN    "ACTIVATE"      ALSO   "BYOMEICD4"
               WHEN    "ACTIVATE"      ALSO   "BYOMEICD5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4119-BYOMEICD-CHK-SEC
      *----(01.00.02) LINE ADD START ----------------------------------
               WHEN    "ACTIVATE"      ALSO   "BYOMEI1"
               WHEN    "ACTIVATE"      ALSO   "BYOMEI2"
               WHEN    "ACTIVATE"      ALSO   "BYOMEI3"
               WHEN    "ACTIVATE"      ALSO   "BYOMEI4"
               WHEN    "ACTIVATE"      ALSO   "BYOMEI5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4119-BYOMEI-CHK-SEC
      *----(01.00.02) LINE ADD END   ----------------------------------
               WHEN    "ACTIVATE"      ALSO   "SRYACTSEL"
                   PERFORM 4120-SRYACTSEL-CHK-SEC
               WHEN    "ACTIVATE"       ALSO   "SRYCD1"  
               WHEN    "ACTIVATE"       ALSO   "SRYCD2"  
               WHEN    "ACTIVATE"       ALSO   "SRYCD3"  
               WHEN    "ACTIVATE"       ALSO   "SRYCD4"  
               WHEN    "ACTIVATE"       ALSO   "SRYCD5"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4121-SRYCD-CHK-SEC    
      *    並び順タグ
               WHEN    "ACTIVATE"       ALSO   "KMK1"  
               WHEN    "ACTIVATE"       ALSO   "KMK2"  
               WHEN    "ACTIVATE"       ALSO   "KMK3"
                   MOVE    MCP-WIDGET   TO  WRK-WIDGET
                   PERFORM 4122-KMK-CHK-SEC
           END-EVALUATE
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始診療年月チェック
      *****************************************************************
       4100-STSRYYMD-CHK-SEC       SECTION.
      *
           MOVE    1                   TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD 
                                                   (SPA-GMN-Q01-CUR)
      *
           MOVE    ZERO                TO  SPA-Q01-STSRYYMD
      *
           MOVE    Q01-STSRYYMD        TO  SPA-GMN-Q01-STSRYYMD
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-STSRYYMD  NOT =   SPACE )
               MOVE    SPA-GMN-Q01-STSRYYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-Q01-STSRYYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-STSRYYMD
               ELSE
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4100-STSRYYMD-CHK-EXT
               END-IF
           END-IF
      *
           MOVE    2                   TO  SPA-GMN-Q01-CUR
      * 
           .
       4100-STSRYYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    終了診療年月チェック
      *****************************************************************
       4101-EDSRYYMD-CHK-SEC       SECTION.
      *
           MOVE    2                   TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    ZERO                TO  SPA-Q01-EDSRYYMD
      *
           MOVE    Q01-EDSRYYMD        TO  SPA-GMN-Q01-EDSRYYMD
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-EDSRYYMD  NOT =   SPACE )
               MOVE    SPA-GMN-Q01-EDSRYYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD     =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-Q01-EDSRYYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-EDSRYYMD
               ELSE
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4101-EDSRYYMD-CHK-EXT
               END-IF
           END-IF
      *
           EVALUATE    Q01-PAGENO
           WHEN    0
               MOVE    101         TO  SPA-GMN-Q01-CUR
           WHEN    1
               MOVE    201         TO  SPA-GMN-Q01-CUR
           WHEN    2
               IF ( SPA-GMN-Q01-BYOBUN-STATE   =   WIDGET-NORMAL )
                   MOVE    301         TO  SPA-GMN-Q01-CUR
               ELSE
                   MOVE    302         TO  SPA-GMN-Q01-CUR
               END-IF
           WHEN    3
               MOVE    401         TO  SPA-GMN-Q01-CUR
           END-EVALUATE
      *
           .
       4101-EDSRYYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始生年月日チェック
      *****************************************************************
       4102-STBIRTHDAY-CHK-SEC     SECTION.
      *
           MOVE    101                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    ZERO                TO  SPA-Q01-STBIRTHDAY
      *
           MOVE    Q01-STBIRTHDAY      TO  SPA-GMN-Q01-STBIRTHDAY
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-STBIRTHDAY    NOT =   SPACE )
               MOVE    SPA-GMN-Q01-STBIRTHDAY
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD        TO  SPA-Q01-STBIRTHDAY
                   MOVE    WRK-HENYMDG     TO  SPA-GMN-Q01-STBIRTHDAY
               ELSE
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4102-STBIRTHDAY-CHK-EXT
               END-IF
           END-IF
      *
      *
           MOVE    102                 TO  SPA-GMN-Q01-CUR
           .
       4102-STBIRTHDAY-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了生年月日チェック
      *****************************************************************
       4103-EDBIRTHDAY-CHK-SEC     SECTION.
      *
           MOVE    102                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    ZERO                TO  SPA-Q01-EDBIRTHDAY
      *
           MOVE    Q01-EDBIRTHDAY      TO  SPA-GMN-Q01-EDBIRTHDAY
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-EDBIRTHDAY    NOT =   SPACE )
               MOVE    SPA-GMN-Q01-EDBIRTHDAY
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD     =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-Q01-EDBIRTHDAY
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-EDBIRTHDAY
               ELSE
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4103-EDBIRTHDAY-CHK-EXT
               END-IF
           END-IF
      *
      *
           MOVE    103                 TO  SPA-GMN-Q01-CUR
           .
       4103-EDBIRTHDAY-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始年齢チェック
      *****************************************************************
       4104-STAGE-CHK-SEC          SECTION.
      *
           MOVE    103                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    Q01-STAGE           TO  SPA-GMN-Q01-STAGE
           MOVE    ZERO                TO  SPA-Q01-STAGE
      *
      *    数値妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-STAGE NOT =   SPACE )
               INITIALIZE                     ORCSNUMAREA
               MOVE    SPA-GMN-Q01-STAGE   TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
               IF  ( SNUM-RC       NOT =   ZERO  )
                OR ( SNUM-MINKBN   NOT =   SPACE )
                OR ( SNUM-SYOKBN   NOT =   SPACE )
                   MOVE    "0001"      TO  SPA-ERRCD
                   PERFORM 510-ERRCD-SET-SEC
                   GO TO   4104-STAGE-CHK-EXT
               ELSE
                   MOVE    SNUM-OUTNUM TO  SPA-Q01-STAGE
               END-IF
           END-IF
      *
           MOVE    104                 TO  SPA-GMN-Q01-CUR
           .
       4104-STAGE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了年齢チェック
      *****************************************************************
       4105-EDAGE-CHK-SEC          SECTION.
      *
           MOVE    104                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    Q01-EDAGE           TO  SPA-GMN-Q01-EDAGE
           MOVE    ZERO                TO  SPA-Q01-EDAGE
      *
      *    数値妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-EDAGE     NOT =   SPACE )
               INITIALIZE                      ORCSNUMAREA
               MOVE    SPA-GMN-Q01-EDAGE   TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
               IF  ( SNUM-RC       NOT =   ZERO  )
                OR ( SNUM-MINKBN   NOT =   SPACE )
                OR ( SNUM-SYOKBN   NOT =   SPACE )
                   MOVE    "0001"      TO  SPA-ERRCD
                   PERFORM 510-ERRCD-SET-SEC
                   GO      TO      4105-EDAGE-CHK-EXT
               ELSE
                   MOVE    SNUM-OUTNUM TO  SPA-Q01-EDAGE
               END-IF
           END-IF
      *
           MOVE    105                 TO  SPA-GMN-Q01-CUR
           .
       4105-EDAGE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    基準日チェック
      *****************************************************************
       4106-KJYNYMD-CHK-SEC        SECTION.
      *
           MOVE    105                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    ZERO                TO  SPA-Q01-KJYNYMD
      *
           MOVE    Q01-KJYNYMD         TO  SPA-GMN-Q01-KJYNYMD
      *
      *    基準日未入力は、システム日付をセット
           IF  ( SPA-GMN-Q01-KJYNYMD   =   SPACE )
               MOVE    SPA-SYSYMDWH    TO  SPA-GMN-Q01-KJYNYMD
               MOVE    SPA-SYSYMD      TO  SPA-Q01-KJYNYMD
      *
           ELSE
      *        日付妥当性チェック＆編集処理
               MOVE    SPA-GMN-Q01-KJYNYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-Q01-KJYNYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-KJYNYMD
               ELSE    
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4106-KJYNYMD-CHK-EXT
               END-IF
           END-IF
      *
           MOVE    106                 TO  SPA-GMN-Q01-CUR
           .
       4106-KJYNYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    性別チェック
      *****************************************************************
       4107-SEX-CHK-SEC            SECTION.
      *
           MOVE    106                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-SEX
      *
           MOVE    Q01-SEX             TO  SPA-GMN-Q01-SEX
      *
           MOVE    SPA-GMN-Q01-SEX (1 : 1)
                                       TO  SPA-Q01-SEX
      *
           MOVE    107                 TO  SPA-GMN-Q01-CUR
           .
       4107-SEX-CHK-EXT.
           EXIT.
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *****************************************************************
      *    最終受診日チェック
      *****************************************************************
      *4108-LASTYMD-CHK-SEC        SECTION.
      *
      *    MOVE    107                 TO  SPA-GMN-Q01-CUR
      *
      *    MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
      *                                                (SPA-GMN-Q01-CUR)
      *
      *    MOVE    ZERO                TO  SPA-Q01-LASTYMD
      *
      *    MOVE    Q01-LASTYMD         TO  SPA-GMN-Q01-LASTYMD
      *
      *    日付妥当性チェック＆編集処理
      *    IF  ( SPA-GMN-Q01-LASTYMD   NOT =   SPACE )
      *        MOVE    SPA-GMN-Q01-LASTYMD TO  WRK-YMD
      *        PERFORM 5002-HIZUKE-CHK-SEC
      *        IF  ( SPA-ERRCD         =   SPACE )
      *            MOVE    WRK-SYMD    TO  SPA-Q01-LASTYMD
      *            MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-LASTYMD
      *        ELSE    
      *            PERFORM 510-ERRCD-SET-SEC
      *            GO  TO  4108-LASTYMD-CHK-EXT
      *        END-IF
      *    END-IF
      *
      *    未来日が入力されていないこと
      *    IF  ( SPA-SYSYMD       >=   SPA-Q01-LASTYMD )
      *        CONTINUE
      *    ELSE
      *        MOVE    "0006"      TO  SPA-ERRCD
      *        PERFORM 510-ERRCD-SET-SEC
      *        GO  TO  4108-LASTYMD-CHK-EXT
      *    END-IF
      *
      *    MOVE    108             TO  SPA-GMN-Q01-CUR
      *    .
      *4108-LASTYMD-CHK-EXT.
      *    EXIT.
      *
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
      *****************************************************************
      *    開始最終受診日チェック
      *****************************************************************
       4108-STLASTYMD-CHK-SEC      SECTION.
      *
           MOVE    107                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    ZERO                TO  SPA-Q01-STLASTYMD
      *
           MOVE    Q01-STLASTYMD       TO  SPA-GMN-Q01-STLASTYMD
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-STLASTYMD NOT =   SPACE )
               MOVE    SPA-GMN-Q01-STLASTYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-Q01-STLASTYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-STLASTYMD
               ELSE    
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4108-STLASTYMD-CHK-EXT
               END-IF
           END-IF
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    未来日が入力されていないこと
      *    IF  ( SPA-SYSYMD       >=   SPA-Q01-STLASTYMD )
      *        CONTINUE
      *    ELSE
      *        MOVE    "0006"      TO  SPA-ERRCD
      *        PERFORM 510-ERRCD-SET-SEC
      *        GO  TO  4108-STLASTYMD-CHK-EXT
      *    END-IF
      *----(01.00.02) LINE DEL END   ----------------------------------
      *
           MOVE    108             TO  SPA-GMN-Q01-CUR
           .
       4108-STLASTYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了最終受診日チェック
      *****************************************************************
       4108-EDLASTYMD-CHK-SEC      SECTION.
      *
           MOVE    108                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    ZERO                TO  SPA-Q01-EDLASTYMD
      *
           MOVE    Q01-EDLASTYMD       TO  SPA-GMN-Q01-EDLASTYMD
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-EDLASTYMD NOT =   SPACE )
               MOVE    SPA-GMN-Q01-EDLASTYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-Q01-EDLASTYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-EDLASTYMD
               ELSE    
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4108-EDLASTYMD-CHK-EXT
               END-IF
           END-IF
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    未来日が入力されていないこと
      *    IF  ( SPA-SYSYMD       >=   SPA-Q01-EDLASTYMD )
      *        CONTINUE
      *    ELSE
      *        MOVE    "0006"      TO  SPA-ERRCD
      *        PERFORM 510-ERRCD-SET-SEC
      *        GO  TO  4108-EDLASTYMD-CHK-EXT
      *    END-IF
      *----(01.00.02) LINE DEL END   ----------------------------------
      *
           MOVE    109             TO  SPA-GMN-Q01-CUR
           .
       4108-EDLASTYMD-CHK-EXT.
           EXIT.
      *
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.01) LINE DEL START ----------------------------------
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
      *4109-PTNUM-CHK-SEC            SECTION.
      *
      *    MOVE    WRK-WIDGET4         TO  IDX1
      *
      *    COMPUTE SPA-GMN-Q01-CUR     =   108
      *                                +   IDX1
      *                                -   1
      *
      *    MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
      *                                                (SPA-GMN-Q01-CUR)
      *
      *    MOVE    ZERO                TO  SPA-Q01-PTID(IDX1)
      *
      *    MOVE    Q01-PTNUM (IDX1)    TO  SPA-GMN-Q01-PTNUM (IDX1)
      *
      *    IF  ( SPA-GMN-Q01-PTNUM(IDX1)   =   SPACE )
      *        COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
      *                                +    1
      *        GO  TO  4109-PTNUM-CHK-EXT
      *    END-IF
      *
      *    INITIALIZE                  ORCSPTIDAREA
      *    MOVE    SPA-HOSPID          TO  SPTID-HOSPID
      *    MOVE    SPA-GMN-Q01-PTNUM(IDX1)
      *                                TO  SPTID-PTNUM
      *    CALL    "ORCSPTID"          USING   ORCSPTIDAREA
      *                                        SPA-1009-TBL
      *    IF  ( SPTID-RC          NOT =   ZERO )
      *        MOVE    "0002"          TO  SPA-ERRCD
      *        PERFORM 510-ERRCD-SET-SEC
      *        GO  TO                  4109-PTNUM-CHK-EXT
      *    END-IF
      *
      *    MOVE    SPTID-PTNUM         TO  SPA-GMN-Q01-PTNUM(IDX1)
      *
      *    患者マスター読込（患者マスター存在チェック）
      *    MOVE    SPA-HOSPID          TO  PTINF-HOSPID
      *    MOVE    SPTID-PTID          TO  PTINF-PTID
      *    PERFORM 900-PTINF-READ-SEC
      *    IF  ( FLG-PTINF         NOT =   ZERO )
      *        MOVE    "0002"          TO  SPA-ERRCD
      *        PERFORM 510-ERRCD-SET-SEC
      *        GO  TO                  4109-PTNUM-CHK-EXT
      *    END-IF
      *
      *    MOVE    SPTID-PTID          TO  SPA-Q01-PTID(IDX1)
      *
      *    COMPUTE SPA-GMN-Q01-CUR     =    SPA-GMN-Q01-CUR
      *                                +    1
      *    .
      *4109-PTNUM-CHK-EXT.
      *    EXIT.
      *
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
      *****************************************************************
      *    開始患者番号チェック処理
      *****************************************************************
       4109-STPTNUM-CHK-SEC            SECTION.
      *
           MOVE    WRK-WIDGET6         TO  IDX1
      *
           MOVE    109                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-STPTNUM
      *
           MOVE    Q01-STPTNUM         TO  SPA-GMN-Q01-STPTNUM
      *
           IF  ( SPA-GMN-Q01-STPTNUM   =   SPACE )
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +    1
               GO  TO  4109-STPTNUM-CHK-EXT
           END-IF
      *
      *    拡張構成か、
      *    自由構成で数字型でない場合は単純に桁数をチェックし、
      *    上記以外は桁数（溢れ）チェック＋ZERO詰め編集を行う
           MOVE    SPACE               TO  WRK-PTNUM
           MOVE    1                   TO  WRK-PTNUM-KETA
      *
           STRING  SPA-GMN-Q01-STPTNUM DELIMITED   BY  SPACE
           INTO    WRK-PTNUM
           WITH    POINTER WRK-PTNUM-KETA
           END-STRING
      *
           COMPUTE WRK-PTNUM-KETA  =   WRK-PTNUM-KETA  -   1
      *
           EVALUATE    SPA-1009-PTNUMKSIKBN    ALSO  SPA-1009-JIYKSIKBN
           WHEN    "3"     ALSO    ANY
           WHEN    "1"     ALSO    NOT "2"
      *
      *        桁数チェック１
               PERFORM 41091-KETA-CNT-CHK1-SEC
      *
           WHEN    OTHER
      *
      *        桁数チェック２
               PERFORM 41091-KETA-CNT-CHK2-SEC
      *
           END-EVALUATE
      *
           IF  ( SPA-ERRCD         NOT =   SPACE )
               PERFORM 510-ERRCD-SET-SEC
               GO  TO                  4109-STPTNUM-CHK-EXT
           END-IF
      *
           MOVE    WRK-PTNUM           TO   SPA-GMN-Q01-STPTNUM
                                            SPA-Q01-STPTNUM
      *
           COMPUTE SPA-GMN-Q01-CUR     =    SPA-GMN-Q01-CUR
                                       +    1
           .
       4109-STPTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了患者番号チェック処理
      *****************************************************************
       4109-EDPTNUM-CHK-SEC            SECTION.
      *
           MOVE    WRK-WIDGET6         TO  IDX1
      *
           MOVE    110                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-EDPTNUM
      *
           MOVE    Q01-EDPTNUM         TO  SPA-GMN-Q01-EDPTNUM
      *
           IF  ( SPA-GMN-Q01-EDPTNUM   =   SPACE )
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +    1
               GO  TO  4109-EDPTNUM-CHK-EXT
           END-IF
      *
      *    拡張構成か、
      *    自由構成で数字型でない場合は単純に桁数をチェックし、
      *    上記以外は桁数（溢れ）チェック＋ZERO詰め編集を行う
           MOVE    SPACE               TO  WRK-PTNUM
           MOVE    1                   TO  WRK-PTNUM-KETA
      *
           STRING  SPA-GMN-Q01-EDPTNUM DELIMITED   BY  SPACE
           INTO    WRK-PTNUM
           WITH    POINTER WRK-PTNUM-KETA
           END-STRING
      *
           COMPUTE WRK-PTNUM-KETA  =   WRK-PTNUM-KETA  -   1
      *
           EVALUATE    SPA-1009-PTNUMKSIKBN    ALSO  SPA-1009-JIYKSIKBN
           WHEN    "3"     ALSO    ANY
           WHEN    "1"     ALSO    NOT "2"
      *
      *        桁数チェック１
               PERFORM 41091-KETA-CNT-CHK1-SEC
      *
           WHEN    OTHER
      *
      *        桁数チェック２
               PERFORM 41091-KETA-CNT-CHK2-SEC
      *
           END-EVALUATE
      *
           IF  ( SPA-ERRCD         NOT =   SPACE )
               PERFORM 510-ERRCD-SET-SEC
               GO  TO                  4109-EDPTNUM-CHK-EXT
           END-IF
      *
           MOVE    WRK-PTNUM           TO   SPA-GMN-Q01-EDPTNUM
                                            SPA-Q01-EDPTNUM
      *
           COMPUTE SPA-GMN-Q01-CUR     =    SPA-GMN-Q01-CUR
                                       +    1
           .
       4109-EDPTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    桁数チェック１
      *****************************************************************
       41091-KETA-CNT-CHK1-SEC             SECTION.
      *
           MOVE    ZERO            TO      WRK-SYS-KETA
                                           WRK-SYS-KETA2
      *
           EVALUATE    SPA-1009-PTNUMKSIKBN
           WHEN    "1"
               MOVE    SPA-1009-JIYKSIKETA
                                   TO      WRK-SYS-KETA
           WHEN    "2"
               MOVE    SPA-1009-HJNKSIRENNUMKETA
                                   TO      WRK-SYS-KETA
               IF  ( SPA-1009-HJNKSINENKBN     =   "1" )
      *            和暦
                   MOVE    3   TO      WRK-SYS-KETA2
               ELSE
      *            西暦
                   MOVE    4   TO      WRK-SYS-KETA2
               END-IF
      *
               EVALUATE    SPA-1009-HJNKSIKBN
               WHEN    "1"
                   COMPUTE WRK-SYS-KETA    =   WRK-SYS-KETA
                                           +   WRK-SYS-KETA2
                                           +   1
               WHEN    "2"
                   COMPUTE WRK-SYS-KETA    =   WRK-SYS-KETA
                                           +   WRK-SYS-KETA2
               WHEN    "3"
                   COMPUTE WRK-SYS-KETA    =   WRK-SYS-KETA
                                           +   1
               WHEN    "4"
                   CONTINUE
               END-EVALUATE
           WHEN    "3"
               COMPUTE WRK-SYS-KETA        =  SPA-1009-KKCKSIMAEKETA
                                           +  SPA-1009-KKCKSIRENNUMKETA
                                           +  SPA-1009-KKCKSIATOKETA
           END-EVALUATE
      *
           IF  ( WRK-PTNUM-KETA    NOT =   WRK-SYS-KETA )
               MOVE    "0002"      TO  SPA-ERRCD
           END-IF
      *
           .
       41091-KETA-CNT-CHK1-EXT.
           EXIT.
      *
      *****************************************************************
      *    桁数チェック２
      *****************************************************************
       41091-KETA-CNT-CHK2-SEC             SECTION.
      *
           MOVE    ZERO            TO      WRK-SYS-KETA
      *
      *    自由構成の桁数編集
           IF  ( SPA-1009-PTNUMKSIKBN  =   "1" )
               MOVE    SPA-1009-JIYKSIKETA
                                   TO      WRK-SYS-KETA
           ELSE
      *
      *        標準構成の桁数
      *        システム管理マスタで設定された桁数をカウント
               MOVE    SPA-1009-HJNKSIRENNUMKETA
                                   TO      WRK-SYS-KETA
               IF  ( SPA-1009-HJNKSIKBN
                                       =   "1"  OR  "2" )
                   EVALUATE    SPA-1009-HJNKSINENKBN
                   WHEN    "1"
                       COMPUTE WRK-SYS-KETA    =   WRK-SYS-KETA  +   3
                   WHEN    "2"
                       COMPUTE WRK-SYS-KETA    =   WRK-SYS-KETA  +   4
                   END-EVALUATE
               END-IF
      *
               IF  ( SPA-1009-HJNKSIKBN    =   "1"  OR  "3" )
                   COMPUTE WRK-SYS-KETA    =   WRK-SYS-KETA  +   1
               END-IF
           END-IF
      *
      *    パラメータ（IN）の患者番号桁数が設定された桁数を超えた場合
           IF  ( WRK-PTNUM-KETA        >   WRK-SYS-KETA )
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO                  41091-KETA-CNT-CHK2-EXT
           END-IF
      *
      *    開始位置算出
           COMPUTE     WRK-ST          =   WRK-SYS-KETA
                                       -   WRK-PTNUM-KETA   +   1
      *
           IF  ( WRK-ST                =   ZERO )  OR
               ( WRK-ST                >   20   )
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO                  41091-KETA-CNT-CHK2-EXT
           END-IF
      *
      *    検索するため、患者番号をゼロ詰編集
           MOVE    ZERO                TO  WRK-PTNUM-WK
           MOVE    WRK-PTNUM  (1:WRK-PTNUM-KETA)
                                       TO  WRK-PTNUM-WK (WRK-ST:)
      *    ニューメリックチェック
           IF    ( WRK-PTNUM-WK (1:WRK-PTNUM-KETA)
                                       IS  NUMERIC )
               CONTINUE
           ELSE
               MOVE    "0001"          TO  SPA-ERRCD
           END-IF
      *
           MOVE    WRK-PTNUM-WK        TO  WRK-PTNUM
      *
           .
       41091-KETA-CNT-CHK2-EXT.
           EXIT.
      *
      *----(01.00.01) LINE ADD END   ----------------------------------
      *****************************************************************
      *    郵便番号チェック処理
      *****************************************************************
       4110-POST-CHK-SEC           SECTION.
      *
           MOVE    WRK-WIDGET3         TO  IDX1
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR     =   113
      *                                + ( IDX1 - 1 ) * 2
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   111
                                       + ( IDX1 - 1 ) * 2
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
           MOVE    Q01-POST (IDX1)     TO  SPA-GMN-Q01-POST (IDX1)
      *
           IF  ( SPA-GMN-Q01-POST(IDX1)   =   SPACE )
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +    1
               GO  TO  4110-POST-CHK-EXT
           END-IF
      *
      *    住所エリアを初期化
           MOVE    SPACE           TO  SPA-GMN-Q01-ERRCD
                                               (SPA-GMN-Q01-CUR + 1)
      *
           MOVE    ZERO                TO  CNT-ADRS
           MOVE    SPACE               TO  WRK-EDITADRS-NAME
           INITIALIZE                  ADRS-REC
      *
           MOVE    SPA-GMN-Q01-POST (IDX1)
                                       TO  ADRS-POST
      *    住所検索処理
           PERFORM 900-ADRS-SELECT-SEC
      *
           PERFORM UNTIL ( FLG-ADRS    =   1 )
                    OR   ( CNT-ADRS    >   1 )
      *
      *        住所読込処理
               PERFORM 900-ADRS-READ-SEC
               IF  ( FLG-ADRS  =   ZERO )
                   COMPUTE CNT-ADRS    =   CNT-ADRS    +   1
                   IF  ( CNT-ADRS      =   1 )
                       MOVE    ADRS-EDITADRS-NAME
                                       TO  WRK-EDITADRS-NAME
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-ADRS-CLOSE-SEC
      *
      *    郵便番号による住所検索チェック
           EVALUATE    CNT-ADRS
      *
      *    該当件数０件
           WHEN    0
               MOVE    SPACE       TO  SPA-GMN-Q01-POST (IDX1)
      *
      *    該当件数１件
           WHEN    1
               MOVE    SPACE       TO  SPA-GMN-Q01-ERRCD
                                               (SPA-GMN-Q01-CUR + 1)
               MOVE    WRK-EDITADRS-NAME
                                   TO  SPA-GMN-Q01-JYUSHO  (IDX1)
                                       SPA-Q01-JYUSHO   (IDX1)
      *
      *    複数件該当
           WHEN    OTHER
      *
      *        住所検索−町域選択画面に遷移する
               MOVE  IDX1          TO  SPA-Q01-JYUSHO-IDX
               MOVE  SPA-GMN-Q01-POST (IDX1)
                                   TO  SPA-Q01-POST
      *
      *
               MOVE    SPACE           TO  SPA-MOTOPG
               MOVE    SPA-AREA        TO  SPA-COMMON
               MOVE    SPA-Q01FREE     TO  SPA-FREE
      *
               MOVE    "LINK"          TO  MCP-STATUS
               MOVE    SPACE           TO  MCP-EVENT
      *
               CALL    "ORCGQ99"      USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA
      *
      *
               MOVE    SPA-COMMON      TO  SPA-AREA
               MOVE    SPA-FREE        TO  SPA-Q01FREE
      *
               MOVE  "SELNUM"      TO  MCP-WIDGET
      *
               MOVE  "Q01"         TO  SPA-MOTOPG
               MOVE  "Q99"         TO  SPA-SAKIPG
      *
               MOVE  "NEW"         TO  MCP-PUTTYPE
               MOVE  "Q99"         TO  MCP-WINDOW
      *
               PERFORM 900-PUT-WINDOW
      *
               MOVE  1             TO  FLG-END
      *
               GO  TO  4110-POST-CHK-EXT
      *
           END-EVALUATE
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
      *
           .
       4110-POST-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    住所チェック処理
      *****************************************************************
       4110-JYUSHO-CHK-SEC         SECTION.
      *
           MOVE    WRK-WIDGET5         TO  IDX1
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR     =   114
      *                                + ( IDX1 - 1 ) * 2
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   112
                                       + ( IDX1 - 1 ) * 2
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-JYUSHO(IDX1)
      *
      *
           MOVE    Q01-JYUSHO(IDX1)    TO  SPA-GMN-Q01-JYUSHO(IDX1)
                                           SPA-Q01-JYUSHO(IDX1)
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
      *
           .
       4110-JYUSHO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    カナ氏名チェック処理
      *****************************************************************
       4111-KANANAME-CHK-SEC       SECTION.
      *
           MOVE    WRK-WIDGET7         TO  IDX1
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR     =   123
      *                                +   IDX1
      *                                -   1
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   121
                                       +   IDX1
                                       -   1
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-KANANAME(IDX1)
      *
      *    全角変換処理
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE    Q01-KANANAME(IDX1)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  SPA-GMN-Q01-KANANAME(IDX1)
                                       SPA-Q01-KANANAME(IDX1)
           ELSE
               MOVE    Q01-KANANAME(IDX1)
                                   TO  SPA-GMN-Q01-KANANAME(IDX1)
                                       SPA-Q01-KANANAME(IDX1)
      *
           END-IF
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
      *
           .
       4111-KANANAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    漢字氏名チェック処理
      *****************************************************************
       4112-NAME-CHK-SEC           SECTION.
      *
           MOVE    WRK-WIDGET3         TO  IDX1
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR     =   128
      *                                +   IDX1
      *                                -   1
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   126
                                       +   IDX1
                                       -   1
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-NAME(IDX1)
      *
      *
      *    全角変換処理
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE    Q01-NAME(IDX1)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  SPA-GMN-Q01-NAME(IDX1)
                                       SPA-Q01-NAME(IDX1)
           ELSE
               MOVE    Q01-NAME(IDX1)
                                   TO  SPA-GMN-Q01-NAME(IDX1)
                                       SPA-Q01-NAME(IDX1)
           END-IF
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
      *
           .
       4112-NAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメントチェック処理
      *****************************************************************
       4113-COMMENT-CHK-SEC        SECTION.
      *
           MOVE    WRK-WIDGET6          TO  IDX1
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR     =   133
      *                                +   IDX1
      *                                -   1
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   131
                                       +   IDX1
                                       -   1
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-COMMENT(IDX1)
      *
      *
           MOVE    Q01-COMMENT(IDX1)   TO  SPA-GMN-Q01-COMMENT(IDX1)
                                           SPA-Q01-COMMENT(IDX1)
      *
      *    ３行目からのカーソルの移動先は診療開始日にする。
           IF  ( IDX1                  =   3 )
               MOVE      1             TO  SPA-GMN-Q01-CUR
           ELSE
      *
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +   1
           END-IF
           .
       4113-COMMENT-CHK-EXT.
           EXIT.
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    保険者番号チェック処理
      *****************************************************************
       4114-HKNJANUM-CHK-SEC           SECTION.
      *
           MOVE    WRK-WIDGET7         TO  IDX1
      *
           COMPUTE SPA-GMN-Q01-CUR     =   201
                                       +   IDX1 - 1
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-HKNJANUM(IDX1)
      *
      *
           MOVE    Q01-HKNJANUM(IDX1)  TO  SPA-GMN-Q01-HKNJANUM(IDX1)
                                           SPA-Q01-HKNJANUM    (IDX1)
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
      *
           .
       4114-HKNJANUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険の種類チェック処理
      *****************************************************************
       4114-HKNNUM-CHK-SEC             SECTION.
      *
           MOVE    WRK-WIDGET5         TO  IDX1
      *
           COMPUTE SPA-GMN-Q01-CUR     =   206
                                       +   IDX1 - 1
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-HKNNUM(IDX1)
      *
      *
           MOVE    Q01-HKNNUM(IDX1)    TO  SPA-GMN-Q01-HKNNUM(IDX1)
           MOVE    Q01-HKNNUM(IDX1)(1:3)
                                       TO  SPA-Q01-HKNNUM    (IDX1)
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
      *
           .
       4114-HKNNUM-CHK-EXT.
           EXIT.
      *
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    記号チェック処理
      *****************************************************************
       4114-KIGO-CHK-SEC        SECTION.
      *
           MOVE    WRK-WIDGET3         TO  IDX1
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR     =   201
      *                                + ( IDX1 - 1 ) * 2
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   211
                                       + ( IDX1 - 1 ) * 2
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-KIGO(IDX1)
      *
      *
           MOVE    Q01-KIGO(IDX1)      TO  SPA-GMN-Q01-KIGO(IDX1)
                                           SPA-Q01-KIGO(IDX1)
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
           .
       4114-KIGO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号チェック処理
      *****************************************************************
       4115-NUM-CHK-SEC        SECTION.
      *
           MOVE    WRK-WIDGET2         TO  IDX1
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR     =   202
      *                                + ( IDX1 - 1 ) * 2
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   212
                                       + ( IDX1 - 1 ) * 2
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-NUM(IDX1)
      *
      *
           MOVE    Q01-NUM(IDX1)       TO  SPA-GMN-Q01-NUM(IDX1)
                                           SPA-Q01-NUM(IDX1)
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
           .
       4115-NUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費保険番号チェック処理
      *****************************************************************
       4116-KOHNUM-CHK-SEC        SECTION.
      *
           MOVE    WRK-WIDGET5         TO  IDX1
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR     =   211
      *                                +   IDX1
      *                                -   1
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   221
                                       +   IDX1
                                       -   1
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-KOHNUM(IDX1)
      *
      *
           MOVE    Q01-KOHNUM(IDX1)    TO  SPA-GMN-Q01-KOHNUM(IDX1)
      *----(01.00.02) LINE DEL START ----------------------------------
      *                                    SPA-Q01-KOHNUM(IDX1)
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           MOVE    Q01-KOHNUM(IDX1)(1:3)
                                       TO  SPA-Q01-KOHNUM(IDX1)
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
           .
       4116-KOHNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費負担者番号チェック処理
      *****************************************************************
       4117-FTNJANUM-CHK-SEC        SECTION.
      *
           MOVE    WRK-WIDGET7         TO  IDX1
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR     =   216
      *                                +   IDX1
      *                                -   1
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   226
                                       +   IDX1
                                       -   1
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-FTNJANUM(IDX1)
      *
      *
           MOVE    Q01-FTNJANUM(IDX1)  TO  SPA-GMN-Q01-FTNJANUM(IDX1)
                                           SPA-Q01-FTNJANUM(IDX1)
      *
      *    ５行目からのカーソルの移動先は診療開始日にする
           IF  ( IDX1                  =   5 )
               MOVE      1             TO  SPA-GMN-Q01-CUR
           ELSE
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +   1
           END-IF
           .
       4117-FTNJANUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名分類区分チェック処理
      *****************************************************************
       4118-BYOBUN-CHK-SEC             SECTION.
      *
           MOVE    301                 TO  SPA-GMN-Q01-CUR
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    Q01-BYOBUN          TO  SPA-GMN-Q01-BYOBUN
      *
           IF  ( SPA-GMN-Q01-BYOBUN    =   SPACE )
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +   1
               GO  TO  4118-BYOBUN-CHK-EXT
           END-IF
      *
           MOVE    "%"                 TO  SPA-GMN-Q01-BYOMEISEL
      *
           MOVE    ZERO                TO  SPA-GMN-Q01-BYOMEI-MAX
                                           SPA-GMN-Q01-BYOMEI-SEL
      *
           MOVE    1                   TO  SPA-GMN-Q01-BYOTBL-FLG
      *    病名編集処理(自院病名)
           PERFORM 4118-USERBYOMEI-LST-EDIT-SEC
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-BYOMEISEL
      *
           IF      ( IDX1             >=   200 )
            AND    ( FLG-USERBYOMEI    =   ZERO )
               MOVE    "0003"          TO  SPA-ERRCD
           END-IF
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
           .
       4118-BYOBUN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病名チェック処理
      *****************************************************************
       4118-BYOMEISEL-CHK-SEC          SECTION.
      *
           MOVE   302                  TO  SPA-GMN-Q01-CUR
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    Q01-BYOMEISEL       TO  SPA-GMN-Q01-BYOMEISEL
      *
           IF  ( SPA-GMN-Q01-BYOMEISEL =   SPACE )
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +   1
               GO  TO  4118-BYOMEISEL-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  SPA-GMN-Q01-BYOMEI-MAX
                                           SPA-GMN-Q01-BYOMEI-SEL
      *
           INITIALIZE                  SPA-GMN-Q01-BYOTBL
      *
           IF  ( SPA-GMN-Q01-RDBYOMEI-U    =   "T" )
               MOVE    1               TO  SPA-GMN-Q01-BYOTBL-FLG
      *
      *        病名編集処理(自院病名)
               PERFORM 4118-USERBYOMEI-LST-EDIT-SEC
      *
               IF      ( IDX1              >=  200 )
                AND    ( FLG-USERBYOMEI    =   ZERO )
                   MOVE    "0003"          TO  SPA-ERRCD
                   GO  TO  4118-BYOMEISEL-CHK-EXT
               END-IF
           ELSE
               MOVE    ZERO            TO  SPA-GMN-Q01-BYOTBL-FLG
      *
      *        病名編集処理(病名)
               PERFORM 4118-BYOMEI-LST-EDIT-SEC
      *
               IF      ( IDX1              >   200 )
                AND    ( FLG-BYOMEI        =   ZERO )
                   MOVE    "0003"          TO  SPA-ERRCD
                   GO  TO  4118-BYOMEISEL-CHK-EXT
               END-IF
           END-IF
      *
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
      *
           .
       4118-BYOMEISEL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名編集処理(自院病名)
      *****************************************************************
       4118-USERBYOMEI-LST-EDIT-SEC        SECTION.
      *
           INITIALIZE                      USERBYOMEI-REC
           MOVE    SPA-HOSPID          TO  USBYO-HOSPID
           MOVE    SPA-GMN-Q01-BYOMEISEL
                                       TO  USBYO-BYOMEI
      *
      *    病名で自院病名マスターを検索
           PERFORM 900-USERBYOMEI-SELECT-SEC
      *
           IF  ( FLG-USERBYOMEI        =   ZERO )
      *        自院病名マスター読込
               PERFORM 900-USERBYOMEI-READ-SEC
           END-IF
      *
           MOVE    ZERO            TO  IDX1
      *
           PERFORM UNTIL      (IDX1               >=   200 )
                    OR        (FLG-USERBYOMEI  NOT =   ZERO )
      *
      *        自院病名編集処理
               PERFORM 41181-USERBYOMEI-HENSYU-SEC
      *
      *        自院病名マスター読込
               PERFORM 900-USERBYOMEI-READ-SEC
      *
           END-PERFORM
      *
           PERFORM 900-USERBYOMEI-CLOSE-SEC
           .
      *
       4118-USERBYOMEI-LST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    自院病名編集処理
      *****************************************************************
       41181-USERBYOMEI-HENSYU-SEC         SECTION.
      *
           MOVE    ZERO            TO  WRK-IDX
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
               UNTIL     ( IDX2    >   SPA-GMN-Q01-CNB-BYOBUN-COUNT )
      *
               IF  ( SPA-GMN-Q01-BYOBUN
                                   =   SPA-GMN-Q01-CNB-BYOBUN-ITEM
                                                                (IDX2))
                   MOVE    IDX2        TO  WRK-IDX
                   MOVE    100         TO  IDX2
               END-IF
                   
           END-PERFORM
      *
           IF  ( WRK-IDX           =   ZERO )
               MOVE    "ALL"           TO  WRK-BYOBUNCD
           ELSE
               MOVE    SPA-GMN-Q01-CNB-BYOBUNCD (WRK-IDX)
                                       TO  WRK-BYOBUNCD
           END-IF
      *
           EVALUATE    TRUE
      *
           WHEN    ( USBYO-BUNRUICD    =   WRK-BYOBUNCD)
      *
           WHEN    ( WRK-BYOBUNCD      =   "NON" )
            AND    ( USBYO-BUNRUICD    =   SPACE )
      *
           WHEN    ( WRK-BYOBUNCD      =   "ALL" )
      *
               COMPUTE IDX1    =   IDX1    +   1
               MOVE    USBYO-BYOMEIINPUTCD
                                      TO  SPA-GMN-Q01-TBYOMEICD(IDX1)
               MOVE    USBYO-BYOMEI   TO  SPA-GMN-Q01-TBYOMEI  (IDX1)
               MOVE    IDX1           TO  SPA-GMN-Q01-BYOMEI-MAX
               MOVE    1              TO  SPA-GMN-Q01-BYOMEI-SEL
           END-EVALUATE
      *
           .
       41181-USERBYOMEI-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    病名編集処理(病名)
      *****************************************************************
       4118-BYOMEI-LST-EDIT-SEC        SECTION.
      *
           INITIALIZE                      BYOMEI-REC
           MOVE    SPA-GMN-Q01-BYOMEISEL
                                       TO  BYO-BYOMEI
                                           BYO-BYOMEIKANA
      *
      *    病名漢字（カナ）で病名マスターを検索
           PERFORM 900-BYOMEI-SELECT-SEC
      *
           IF  ( FLG-BYOMEI        =   ZERO )
      *        病名マスター読込
               PERFORM 900-BYOMEI-READ-SEC
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL      (IDX1            >   200 )   OR
                              (FLG-BYOMEI  NOT =   ZERO )
      *
      *        病名編集処理
               PERFORM 41181-BYOMEI-HENSYU-SEC
      *
      *        病名マスター読込
               PERFORM 900-BYOMEI-READ-SEC
      *
           END-PERFORM
      *
           PERFORM 900-BYOMEI-CLOSE-SEC
           .
      *
       4118-BYOMEI-LST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病名編集処理
      *****************************************************************
       41181-BYOMEI-HENSYU-SEC            SECTION.
      *
           MOVE    BYO-BYOMEICD        TO  SPA-GMN-Q01-TBYOMEICD(IDX1)
           MOVE    BYO-BYOMEI          TO  SPA-GMN-Q01-TBYOMEI  (IDX1)
           MOVE    IDX1                TO  SPA-GMN-Q01-BYOMEI-MAX
           MOVE    1                   TO  SPA-GMN-Q01-BYOMEI-SEL
      *
           .
       41181-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コードチェック処理
      *****************************************************************
       4119-BYOMEICD-CHK-SEC        SECTION.
      *
           MOVE    WRK-WIDGET7         TO  IDX1
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR         =   303
      *                                +   IDX1
      *                                -   1
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   303
                                       + ( IDX1 - 1 ) * 2
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    MOVE    SPACE               TO  SPA-Q01-USERBYOMEIFLG (IDX1)
      *                                    SPA-Q01-BYOMEICD(IDX1)
      *----(01.00.02) LINE DEL END   ----------------------------------
      *
           MOVE    Q01-BYOMEICD(IDX1)  TO  SPA-GMN-Q01-BYOMEICD(IDX1)
      *
           IF  ( SPA-GMN-Q01-BYOMEICD (IDX1)   =   SPACE )
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                   +   1
               GO  TO  4119-BYOMEICD-CHK-EXT
           END-IF
      *
      *
      *    自院病名マスタ−検索条件編集処理
           PERFORM 4121-USERBYOMEI-SEL-EDIT-SEC
           IF  ( SPA-ERRCD         NOT =   SPACE )
               PERFORM 510-ERRCD-SET-SEC
               GO  TO  4119-BYOMEICD-CHK-EXT
           END-IF
      *
           IF  ( WRK-MOJI              =   ZERO )
               COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                           +   1
               GO  TO  4119-BYOMEICD-CHK-EXT
      *
           END-IF
      *
           INITIALIZE                  USERBYOMEI-REC
           MOVE    SPA-HOSPID          TO  USBYO-HOSPID
           MOVE    WRK-CDSYUBETU       TO  USBYO-CDSYU
           MOVE    SPA-GMN-Q01-BYOMEICD(IDX1)
                                       TO  USBYO-BYOMEIINPUTCD
      *
      *    自院病名マスタ−読み込み処理
           PERFORM 910-USERBYOMEI-READ-SEC
      *
      *    自院病名マスタ−に存在せず、
      *    病名コードの桁数が７桁の場合、病名マスターを検索する
      *    病名マスター読み込み（病名コード存在チェック）
           IF  ( FLG-USERBYOMEI    =   ZERO )
      *----(01.00.02) LINE DEL START ----------------------------------
      *        MOVE    "1"         TO  SPA-Q01-USERBYOMEIFLG (IDX1)
      *        MOVE    USBYO-BYOMEIINPUTCD
      *                            TO  SPA-Q01-BYOMEICD (IDX1)
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
               MOVE    USBYO-BYOMEI
                                   TO  SPA-GMN-Q01-BYOMEI (IDX1)
      *----(01.00.01) LINE ADD END   ----------------------------------
           ELSE
               IF  ( WRK-MOJI      =   7 )
                   INITIALIZE              BYOMEI-REC
                   MOVE    SPA-GMN-Q01-BYOMEICD (IDX1)
                                   TO  BYO-BYOMEICD
                   PERFORM 910-BYOMEI-READ-SEC
                   IF  ( FLG-BYOMEI    NOT =   ZERO )
                       MOVE    "0004"      TO  SPA-ERRCD
                       PERFORM 510-ERRCD-SET-SEC
                       GO  TO  4119-BYOMEICD-CHK-EXT
                   END-IF
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *            MOVE    "0"     TO  SPA-Q01-USERBYOMEIFLG (IDX1)
      *            MOVE    SPA-GMN-Q01-BYOMEICD (IDX1)
      *                            TO  SPA-Q01-BYOMEICD(IDX1)
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
                   MOVE    BYO-BYOMEI
                                   TO  SPA-GMN-Q01-BYOMEI (IDX1)
      *----(01.00.01) LINE ADD END   ----------------------------------
               ELSE
                   MOVE    "0004"      TO  SPA-ERRCD
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4119-BYOMEICD-CHK-EXT
               END-IF
           END-IF
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
           .
       4119-BYOMEICD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コードマスタ−検索条件編集処理
      *****************************************************************
       4121-USERBYOMEI-SEL-EDIT-SEC    SECTION.
      *
           MOVE    ZERO                TO  WRK-MOJI
      *
           MOVE    SPA-GMN-Q01-BYOMEICD (IDX1)
                                       TO  WRK-BYOMEICD
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL  (IDX2    >   20  )   OR
                          (WRK-BYOMEICD (IDX2:1)
                                   =   SPACE  )
      *
               COMPUTE WRK-MOJI    =   WRK-MOJI    +   1
      *
           END-PERFORM
      *
           IF  ( WRK-MOJI          =   ZERO )
               GO  TO  4121-USERBYOMEI-SEL-EDIT-EXT
           END-IF
      *
      *    全角半角混在チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    WRK-BYOMEICD    TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    NOT =   ZERO )
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  4121-USERBYOMEI-SEL-EDIT-EXT
           END-IF
      *
           EVALUATE    KANACHK-SYUBETU
           WHEN    1
      *    半角入力
               MOVE    "A"             TO  WRK-CDSYUBETU
      *    全角入力
           WHEN    2
               MOVE    "J"             TO  WRK-CDSYUBETU
           WHEN    OTHER
               MOVE    "0001"          TO  SPA-ERRCD
           END-EVALUATE
      *
           .
      *
       4121-USERBYOMEI-SEL-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    自院病名マスター読込処理
      *****************************************************************
       910-USERBYOMEI-READ-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-USERBYOMEI
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "USERBYOMEI-KEY"    TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
           IF ( MCP-RC             =   ZERO )
               MOVE    "USERBYOMEI-KEY"
                                       TO  ORC-DBPATH
      *
               PERFORM 910-DB-READ-SEC
               IF  ( MCP-RC        =   ZERO )
                   MOVE    MCPDATA-REC TO  USERBYOMEI-REC
               ELSE
                   MOVE    1           TO  FLG-USERBYOMEI
               END-IF
           ELSE
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           MOVE    "USERBYOMEI-KEY"    TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
      *
       910-INPUTCD-READ-EXT.
           EXIT.
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    病名チェック処理
      *****************************************************************
       4119-BYOMEI-CHK-SEC             SECTION.
      *
           MOVE    WRK-WIDGET5         TO  IDX1
      *
           COMPUTE SPA-GMN-Q01-CUR     =   304
                                       + ( IDX1 - 1 ) * 2
      *
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-BYOMEI(IDX1)
      *
           IF    ( Q01-BYOMEI (IDX1)   =   SPACE )
            OR   ( Q01-BYOMEI (IDX1)   =   SPA-GMN-Q01-BYOMEI (IDX1) )
      *
               IF    ( Q01-BYOMEI (IDX1)   =   SPACE )
                   MOVE    SPACE       TO  SPA-GMN-Q01-BYOMEICD (IDX1)
                   MOVE    SPACE       TO  SPA-GMN-Q01-BYOMEI   (IDX1)
               END-IF
      *
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                   +   1
               GO  TO  4119-BYOMEI-CHK-EXT
           END-IF
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-BYOMEICD (IDX1)
           MOVE    Q01-BYOMEI (IDX1)   TO  SPA-GMN-Q01-BYOMEI (IDX1)
      *
      *    半角チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI 
           MOVE    SPA-GMN-Q01-BYOMEI (IDX1)
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF    ( KANACHK-RC          =   ZERO )
            AND  ( KANACHK-SYUBETU     =   "2" )
               CONTINUE
           ELSE
               MOVE    "0009"          TO  SPA-ERRCD
               PERFORM 510-ERRCD-SET-SEC
               GO  TO  4119-BYOMEI-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-Q01-BYOMEI (IDX1)
                                       TO  SPA-Q01-BYOMEI (IDX1)
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
      *
           .
       4119-BYOMEI-CHK-EXT.
           EXIT.
      *----(01.00.02) LINE ADD END   ----------------------------------
      *****************************************************************
      *    診療行為名チェック処理
      *****************************************************************
       4120-SRYACTSEL-CHK-SEC        SECTION.
      *
      *----(01.00.02) LINE UPD START ----------------------------------
      *    MOVE    308                 TO  SPA-GMN-Q01-CUR
           MOVE    313                 TO  SPA-GMN-Q01-CUR
      *----(01.00.02) LINE UPD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    Q01-SRYACTSEL       TO  SPA-GMN-Q01-SRYACTSEL
      *
           IF  ( SPA-GMN-Q01-SRYACTSEL =   SPACE )
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +   1
               GO  TO  4120-SRYACTSEL-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  SPA-GMN-Q01-SRYACT-MAX
                                           SPA-GMN-Q01-SRYACT-SEL
      *
           INITIALIZE                  SPA-GMN-Q01-SRYACTTBL
      *
           MOVE    ZERO                TO  IDX1
      *
      *    点数マスタ検索（診療行為名存在チェック）
           INITIALIZE                  TNS-TENSU-REC
           MOVE    SPA-GMN-Q01-SRYACTSEL
                                       TO  TNS-NAME
                                           TNS-KANANAME
      *
           PERFORM 910-TENSU-SELECT-SEC
      *
           IF  ( FLG-TENSU     =   ZERO )
      *        点数マスタ読込
               PERFORM 910-TENSU-READ-SEC
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL      (IDX1            >   200  )   OR
                              (FLG-TENSU   NOT =   ZERO )
      *
      *        診療行為編集処理
               PERFORM 41201-SRYACT-HENSYU-SEC
      *
      *        点数マスタ読込
               PERFORM 910-TENSU-READ-SEC
      *
           END-PERFORM
      *
      *    点数マスタクローズ
           PERFORM 910-TENSU-CLOSE-SEC
      *
           IF      ( IDX1              >   200 )
            AND    ( FLG-TENSU         =   ZERO )
               MOVE    "0003"              TO  SPA-ERRCD
               GO  TO  4120-SRYACTSEL-CHK-EXT
           END-IF
      *
           COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                       +   1
      *
           .
       4120-SRYACTSEL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為編集処理
      *****************************************************************
       41201-SRYACT-HENSYU-SEC            SECTION.
      * 
           MOVE    TNS-SRYCD           TO  SPA-GMN-Q01-TSRYCD(IDX1)
      * 
           IF     (TNS-ROUTEKKBN       =   2   )
               STRING  "［老］"
                    TNS-NAME               DELIMITED   BY  SIZE
               INTO                        SPA-GMN-Q01-TSRYACT(IDX1)
               END-STRING
           ELSE
               MOVE    TNS-NAME        TO  SPA-GMN-Q01-TSRYACT(IDX1)
           END-IF

           MOVE    IDX1                TO  SPA-GMN-Q01-SRYACT-MAX
           MOVE    1                   TO  SPA-GMN-Q01-SRYACT-SEL
      *
           .
      * 
       41201-SRYACT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為コードチェック処理
      *****************************************************************
       4121-SRYCD-CHK-SEC        SECTION.
      *
           MOVE    WRK-WIDGET4         TO  IDX1
      *
      *----(01.00.02) LINE DEL START ----------------------------------
      *    COMPUTE SPA-GMN-Q01-CUR         =   309
      *                                +   IDX1
      *                                -   1
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           COMPUTE SPA-GMN-Q01-CUR     =   314
                                       +   IDX1
                                       -   1
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    SPACE               TO  SPA-Q01-SRYCD (IDX1)
      *
           MOVE    Q01-SRYCD(IDX1)     TO  SPA-GMN-Q01-SRYCD (IDX1)
      *
      *    セットコードでの入力はエラーとする。
           IF  ( SPA-GMN-Q01-SRYCD (IDX1) (1:1)   =   "P"  OR  "S" )
               MOVE    "0007"  TO  SPA-ERRCD
               PERFORM 510-ERRCD-SET-SEC
               GO  TO  4121-SRYCD-CHK-EXT
           END-IF
      *
      *    入力コードマスタ−検索条件編集処理
           PERFORM 4121-INPUTCD-SELECT-EDIT-SEC
           IF  ( SPA-ERRCD         NOT =   SPACE )
               PERFORM 510-ERRCD-SET-SEC
               GO  TO  4121-SRYCD-CHK-EXT
           END-IF
      *
           IF  ( WRK-MOJI              =   ZERO )
      *
      *----(01.00.02) LINE ADD START ----------------------------------
               MOVE    SPACE           TO  SPA-GMN-Q01-SRYACT (IDX1)
      *----(01.00.02) LINE ADD END   ----------------------------------
               IF  ( IDX1              =   5 )
                   MOVE          1             TO  SPA-GMN-Q01-CUR
               ELSE
                   COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                           +   1
               END-IF
      *
               GO  TO  4121-SRYCD-CHK-EXT
      *
           END-IF
      *
           INITIALIZE              INPUTCD-REC
           MOVE    SPA-HOSPID      TO  ICD-HOSPID
           MOVE    WRK-CDSYUBETU   TO  ICD-CDSYU
           MOVE    WRK-SRYCD       TO  ICD-INPUTCD
      *
      *    入力コードマスタ−読み込み処理
           PERFORM 910-INPUTCD-READ-SEC
      *
      *    入力コードマスターに存在せず、
      *    入力コードの桁数が９桁の場合、点数マスターを検索する
           IF  ( FLG-INPUTCD       =   ZERO )
               MOVE    ICD-SRYCD   TO  SPA-Q01-SRYCD (IDX1)
      *----(01.00.01) LINE ADD START ----------------------------------
               INITIALIZE      TNS-TENSU-REC
               MOVE   ICD-SRYCD
                                   TO  TNS-SRYCD
      *
               MOVE   SPA-SYSYMD
                                   TO  ORC-DBYMD
      *        点数マスタ−読み込み処理
               PERFORM 910-TENSU-READ-02-SEC
               IF  ( FLG-TENSU     =   ZERO )
                   MOVE    TNS-NAME
                                   TO  SPA-GMN-Q01-SRYACT (IDX1)
      *----(01.00.02) LINE ADD START ----------------------------------
               ELSE
                   MOVE    "0005"  TO  SPA-ERRCD
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4121-SRYCD-CHK-EXT
      *----(01.00.02) LINE ADD END   ----------------------------------
               END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
           ELSE
               IF  ( WRK-MOJI      =   9 )
      *
                   INITIALIZE      TNS-TENSU-REC
                   MOVE   WRK-SRYCD
                                   TO  TNS-SRYCD
      *
                   MOVE   SPA-SYSYMD
                                   TO  ORC-DBYMD
      *            点数マスタ−読み込み処理
                   PERFORM 910-TENSU-READ-02-SEC
                   IF  ( FLG-TENSU     =   ZERO )
                       MOVE    WRK-SRYCD
                                       TO  SPA-Q01-SRYCD (IDX1)
      *----(01.00.01) LINE ADD START ----------------------------------
                       MOVE    TNS-NAME
                                       TO  SPA-GMN-Q01-SRYACT (IDX1)
      *----(01.00.01) LINE ADD END   ----------------------------------
                   ELSE
                       MOVE    "0005"  TO  SPA-ERRCD
                       PERFORM 510-ERRCD-SET-SEC
                       GO  TO  4121-SRYCD-CHK-EXT
                   END-IF
               ELSE
                   MOVE    "0005"  TO  SPA-ERRCD
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4121-SRYCD-CHK-EXT
               END-IF
           END-IF
      *
           IF  ( IDX1          =   5 )
               MOVE          1             TO  SPA-GMN-Q01-CUR
           ELSE
               COMPUTE SPA-GMN-Q01-CUR     =   SPA-GMN-Q01-CUR
                                           +   1
           END-IF
      *
           .
       4121-SRYCD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コードマスタ−検索条件編集処理
      *****************************************************************
       4121-INPUTCD-SELECT-EDIT-SEC    SECTION.
      *
           MOVE    ZERO                TO  WRK-MOJI
      *
           MOVE    SPA-GMN-Q01-SRYCD (IDX1)
                                       TO  WRK-SRYCD
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL  (IDX2    >   20  )   OR
                          (WRK-SRYCD (IDX2:1)
                                   =   SPACE  )
      *
               COMPUTE WRK-MOJI    =   WRK-MOJI    +   1
      *
           END-PERFORM
      *
           IF  ( WRK-MOJI          =   ZERO )
               GO  TO  4121-INPUTCD-SELECT-EDIT-EXT
           END-IF
      *
      *    全角半角混在チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    WRK-SRYCD       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    NOT =   ZERO )
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  4121-INPUTCD-SELECT-EDIT-EXT
           END-IF
      *
           EVALUATE    KANACHK-SYUBETU
           WHEN    1
      *        半角入力
               IF  ( WRK-SRYCD (1:WRK-MOJI) IS  NUMERIC )
                   EVALUATE    WRK-MOJI
                   WHEN    4
                       MOVE    "4"     TO  WRK-CDSYUBETU
                   WHEN    5
                       MOVE    "5"     TO  WRK-CDSYUBETU
                   WHEN    6
                   WHEN    3
                        MOVE   "6"     TO  WRK-CDSYUBETU
                   WHEN    OTHER
                       MOVE    "6"     TO  WRK-CDSYUBETU
                   END-EVALUATE
               ELSE
                   MOVE    "A"         TO  WRK-CDSYUBETU
               END-IF
      *    全角入力
           WHEN    2
               MOVE    "J"             TO  WRK-CDSYUBETU
           WHEN    OTHER
               MOVE    "0001"          TO  SPA-ERRCD
           END-EVALUATE
      *
           .
      *
       4121-INPUTCD-SELECT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    並び順項目名チェック処理
      *****************************************************************
       4122-KMK-CHK-SEC                SECTION.
      *
           MOVE    WRK-WIDGET2         TO  IDX1
      *
           COMPUTE SPA-GMN-Q01-CUR     =   401
                                   +   IDX1
                                   -   1
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-ERRCD
                                                       (SPA-GMN-Q01-CUR)
      *
           MOVE    Q01-CNB-KMK (IDX1)
                                   TO  SPA-GMN-Q01-KMK (IDX1)
      *
      *    必ず指定されていること。
           IF  ( SPA-GMN-Q01-KMK (IDX1)    NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "0008"  TO  SPA-ERRCD
               PERFORM 510-ERRCD-SET-SEC
               GO  TO  4122-KMK-CHK-EXT
           END-IF
      *
      *
           IF  ( IDX1              =   3 )
               MOVE      1             TO  SPA-GMN-Q01-CUR
           ELSE
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +   1
           END-IF 
           .
       4122-KMK-CHK-EXT.
           EXIT.
      *
      *----(01.00.01) LINE ADD START ----------------------------------
      *****************************************************************
      *    テスト患者チェックボタン編集処理
      *****************************************************************
       410-CHKTSTPT-SET-SEC              SECTION.
      *
           IF    ( SPA-GMN-Q01-CHKTSTPT  = "T" )
               MOVE    "F"         TO  SPA-GMN-Q01-CHKTSTPT
           ELSE
               MOVE    "T"         TO  SPA-GMN-Q01-CHKTSTPT
           END-IF
      *
           .
      *
       410-CHKTSTPT-SET-EXT.
           EXIT.
      *----(01.00.01) LINE ADD END   ----------------------------------
      *****************************************************************
      *    住所編集処理
      *****************************************************************
       410-JYUSHO-SET-SEC              SECTION.
      *
           MOVE    WRK-WIDGET7     TO  IDX1
      *
           COMPUTE WRK-IDX =   114 + (IDX1 - 1) * 2
      *
      *    住所エリアを初期化
           MOVE    SPACE           TO  SPA-GMN-Q01-ERRCD (WRK-IDX)
      *
      *
      *    周辺住所検索画面に遷移する
           MOVE    IDX1            TO  SPA-Q01-JYUSHO-IDX2
      *
           MOVE    SPACE           TO  SPA-MOTOPG
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-Q01FREE     TO  SPA-FREE
      *
           MOVE    "LINK"          TO  MCP-STATUS
           MOVE    SPACE           TO  MCP-EVENT
      *
           CALL    "ORCGQ98"       USING
                                   MCPAREA
                                   SPAAREA
                                   LINKAREA
                                   SCRAREA
      *
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-Q01FREE
      *
           MOVE  "SELNUM"          TO  MCP-WIDGET
      *
           MOVE  "Q01"             TO  SPA-MOTOPG
           MOVE  "Q98"             TO  SPA-SAKIPG
      *
           MOVE  "NEW"             TO  MCP-PUTTYPE
           MOVE  "Q98"             TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE  1                 TO  FLG-END
      *     
           .
       410-JYUSHO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コード編集処理
      *****************************************************************
       420-BYOMEICD-SET-SEC            SECTION.
      *
           MOVE    WRK-WIDGET4         TO  IDX1
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >       200 )
               IF  ( Q01-BYOLST-SELECT (IDX2)  =   "T" )
                   COMPUTE WRK-IDX =   303 + ( IDX1    -   1 ) *   2
                   MOVE    SPACE   TO  SPA-GMN-Q01-ERRCD (WRK-IDX)
      *
                   MOVE    SPA-GMN-Q01-TBYOMEICD (IDX2)
                                   TO  SPA-GMN-Q01-BYOMEICD (IDX1)
      *----(01.00.02) LINE DEL START ----------------------------------
      *                                SPA-Q01-BYOMEICD (IDX1)
      *            MOVE    SPA-GMN-Q01-BYOTBL-FLG
      *                            TO  SPA-Q01-USERBYOMEIFLG (IDX1)
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
                   MOVE    SPA-GMN-Q01-TBYOMEI (IDX2)
                                   TO  SPA-GMN-Q01-BYOMEI (IDX1)
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
                   MOVE    SPA-GMN-Q01-TBYOMEI (IDX2)
                                   TO  SPA-Q01-BYOMEI (IDX1)
      *----(01.00.02) LINE ADD END   ----------------------------------
                   MOVE    200     TO  IDX2
               END-IF
           END-PERFORM
      *     
           .
       420-BYOMEICD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為コード編集処理
      *****************************************************************
       430-SRYCD-SET-SEC            SECTION.
      *
           MOVE    WRK-WIDGET4     TO  IDX1
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >       200 )
               IF  ( Q01-SRYLST-SELECT (IDX2)  =   "T" )
                   COMPUTE WRK-IDX =   314 + IDX1 - 1
                   MOVE    SPACE   TO  SPA-GMN-Q01-ERRCD (WRK-IDX)
      *
                   MOVE    SPA-GMN-Q01-TSRYCD (IDX2)
                                           TO  SPA-GMN-Q01-SRYCD (IDX1)
                                               SPA-Q01-SRYCD (IDX1)
      *----(01.00.01) LINE ADD START ----------------------------------
                   MOVE    SPA-GMN-Q01-TSRYACT (IDX2)
                                   TO  SPA-GMN-Q01-SRYACT (IDX1)
      *----(01.00.01) LINE ADD END   ----------------------------------
                   MOVE    200             TO  IDX2
               END-IF
           END-PERFORM
      *
           .
       430-SRYCD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    タグ編集処理
      *****************************************************************
       440-TAG-CHANGE-SEC              SECTION.
      *
           MOVE    WRK-WIDGET1         TO  IDX1
      *
           COMPUTE IDX1    =   IDX1    -   1
      *
           MOVE  Q01-PAGENO            TO  SPA-GMN-Q01-PAGENO
      *
      *    タグが変わったときのチェック
           IF  ( Q01-PAGENO    NOT =   IDX1 )
      *
      *        入力時チェック
               PERFORM 4900-INPUTCHK-SEC
      *
               IF  ( SPA-ERRCD     =   SPACE )
      *            関連チェック
                   PERFORM 4900-KANRENCHK-SEC
               END-IF
           END-IF
      *
           IF  ( SPA-ERRCD             =   SPACE )
      *
               MOVE        IDX1        TO  SPA-GMN-Q01-PAGENO
      *
               EVALUATE    IDX1
               WHEN    0
                   MOVE    101         TO  SPA-GMN-Q01-CUR
               WHEN    1
                   MOVE    201         TO  SPA-GMN-Q01-CUR
               WHEN    2
                   IF ( SPA-GMN-Q01-BYOBUN-STATE
                                           =   WIDGET-NORMAL )
                       MOVE    301     TO  SPA-GMN-Q01-CUR
                   ELSE
                       MOVE    302     TO  SPA-GMN-Q01-CUR
                   END-IF
               WHEN    3
                   MOVE    401         TO  SPA-GMN-Q01-CUR
               END-EVALUATE
           END-IF
      *
           .
       440-TAG-CHANGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "Q01"               TO  SPA-MOTOPG
           MOVE    SPACE               TO  SPA-MOTOPG2
           MOVE    SPACE               TO  SPA-MOTOPG3
      *
           MOVE    SPACE               TO  LINKAREA
      *
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    条件クリア処理
      *****************************************************************
       480-CLEAR-SEC               SECTION.
      *
      *----(01.00.01) LINE ADD START ----------------------------------
           MOVE        SPACE       TO  SPA-GMN-Q01-STSRYYMD
                                       SPA-GMN-Q01-EDSRYYMD
           MOVE        ZERO        TO  SPA-Q01-STSRYYMD
                                       SPA-Q01-EDSRYYMD
      *----(01.00.01) LINE ADD END   ----------------------------------
           EVALUATE    Q01-PAGENO
      *
      *    基本情報
           WHEN    0
               MOVE    101         TO  SPA-GMN-Q01-CUR
      *
               MOVE    SPACE       TO  SPA-GMN-Q01-KIHON-AREA
                                       SPA-Q01-KIHON-AREA
      *
               INITIALIZE              SPA-GMN-Q01-KIHON-AREA
                                       SPA-Q01-KIHON-AREA
      *
      *
      *        基準日開始日和暦
               MOVE    SPA-SYSYMDWH
                                   TO  SPA-GMN-Q01-KJYNYMD
      *        基準日開始日西暦
               MOVE    SPA-SYSYMD  TO  SPA-Q01-KJYNYMD
      *
      *        性別コンボ
      *----(01.00.01) LINE DEL START ----------------------------------
      *        MOVE   "1 男"       TO  SPA-GMN-Q01-SEX-ITEM(1)
      *        MOVE   "2 女"       TO  SPA-GMN-Q01-SEX-ITEM(2)
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           MOVE    CONST-SEX (1)       TO  SPA-GMN-Q01-SEX
           MOVE    CONST-SEX-AREA  TO  SPA-GMN-Q01-SEX-ITEM-AREA
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           MOVE    "F"             TO  SPA-GMN-Q01-CHKTSTPT
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    保険　公費
           WHEN    1
               MOVE    201         TO  SPA-GMN-Q01-CUR
      *
               MOVE    SPACE       TO  SPA-GMN-Q01-HOKEN-AREA
                                       SPA-Q01-HOKEN-AREA
      *
               INITIALIZE              SPA-GMN-Q01-HOKEN-AREA
                                       SPA-Q01-HOKEN-AREA
      *
      *----(01.00.02) LINE ADD START ----------------------------------
               PERFORM             3101-HKNKOH-CMB-SYOKI-SEC
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    病名　診療行為
           WHEN    2
               IF ( SPA-GMN-Q01-BYOBUN-STATE
                                       =   WIDGET-NORMAL )
                   MOVE    301         TO  SPA-GMN-Q01-CUR
               ELSE
                   MOVE    302         TO  SPA-GMN-Q01-CUR
               END-IF
      *
               MOVE    SPA-GMN-Q01-CNB-BYOBUN-COUNT
                                   TO  WRK-BYOBUN-COUNT
               MOVE    SPA-GMN-Q01-CNB-BB-ITEM-AREA
                                   TO  WRK-CNB-BYOBUN-ITEM-AREA
               MOVE    SPA-GMN-Q01-RDBYOMEI-A-STATE
                                   TO  WRK-RDBYOMEI-A-STATE
      *
               MOVE    SPACE       TO  SPA-GMN-Q01-BYOMEI-AREA
                                       SPA-Q01-BYOMEI-AREA
      *
               INITIALIZE              SPA-GMN-Q01-BYOMEI-AREA
                                       SPA-Q01-BYOMEI-AREA
               MOVE    WRK-BYOBUN-COUNT
                                       TO  SPA-GMN-Q01-CNB-BYOBUN-COUNT
               MOVE    WRK-CNB-BYOBUN-ITEM-AREA
                                   TO  SPA-GMN-Q01-CNB-BB-ITEM-AREA
      *
               IF  ( WRK-RDBYOMEI-A-STATE
                                   =   WIDGET-NORMAL )
                   MOVE    "T"         TO  SPA-GMN-Q01-RDBYOMEI-U
                   MOVE    "F"         TO  SPA-GMN-Q01-RDBYOMEI-A
                   MOVE    WIDGET-NORMAL
                                       TO  SPA-GMN-Q01-BYOBUN-STATE
                                           SPA-GMN-Q01-CNB-BYOBUN-STATE
                                           SPA-GMN-Q01-RDBYOMEI-U-STATE
                                           SPA-GMN-Q01-RDBYOMEI-A-STATE
      *
               ELSE
                   MOVE    "F"         TO  SPA-GMN-Q01-RDBYOMEI-U
                   MOVE    "T"         TO  SPA-GMN-Q01-RDBYOMEI-A
                   MOVE    WIDGET-INSENSITIVE
                                       TO  SPA-GMN-Q01-BYOBUN-STATE
                                           SPA-GMN-Q01-CNB-BYOBUN-STATE
                                           SPA-GMN-Q01-RDBYOMEI-U-STATE
                                           SPA-GMN-Q01-RDBYOMEI-A-STATE
               END-IF
      *
      *    並び順
           WHEN    3
               MOVE    401         TO  SPA-GMN-Q01-CUR
      *
               MOVE    SPACE       TO  SPA-GMN-Q01-NARABI-AREA
                                       SPA-Q01-NARABI-AREA
      *
               INITIALIZE              SPA-GMN-Q01-NARABI-AREA
                                       SPA-Q01-NARABI-AREA
      *
               PERFORM 3101-SORT-KMK-SYOKI-SEC
      *
           END-EVALUATE
      *
           .
       480-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    タグ切替処理
      *****************************************************************
       480-TAGSWITCH-SEC           SECTION.
      *
           EVALUATE    Q01-PAGENO
           WHEN    0
               MOVE    "N02"       TO  WRK-WIDGET
           WHEN    1
               MOVE    "N03"       TO  WRK-WIDGET
           WHEN    2
               MOVE    "N04"       TO  WRK-WIDGET
           WHEN    3
               MOVE    "N01"       TO  WRK-WIDGET
           END-EVALUATE
      *
           PERFORM 440-TAG-CHANGE-SEC
      *
           .
       480-TAGSWITCH-EXT.
           EXIT.
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
           MOVE    "Q01"               TO  SPA-MOTOPG
           MOVE    "Y01"               TO  SPA-SAKIPG
           MOVE    "Q01"               TO  SPA-MOTOPG3
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
      *    受付一覧へ
      *****************************************************************
       490-UKEICHI-SEC             SECTION.
      *
      *    戻り時、画面を元へ戻す
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-Q01FREE         TO  LNK-SCRSPA
      *    画面移行用のパラメタ変更
           MOVE    "Q01"               TO  SPA-MOTOPG
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
      *****************************************************************
      *    検索処理
      *****************************************************************
       490-KENSAKU-SEC             SECTION.
      *
      *    診療年月日入力時エラーの確認
           IF  (   SPA-GMN-Q01-ERRCD (1)   NOT =   SPACE )
               MOVE    1       TO  SPA-GMN-Q01-CUR
               MOVE    SPA-GMN-Q01-ERRCD (1)
                               TO  SPA-ERRCD
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
           IF  (   SPA-GMN-Q01-ERRCD (2)   NOT =   SPACE )
               MOVE    2       TO  SPA-GMN-Q01-CUR
               MOVE    SPA-GMN-Q01-ERRCD (2)
                               TO  SPA-ERRCD
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    入力項目入力時チェック
           PERFORM 4900-INPUTCHK-SEC
           IF      SPA-ERRCD           NOT =   SPACE
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    診療年月日チェック
           PERFORM 4900-SRYYMDCHK-SEC
           IF      SPA-ERRCD           NOT =   SPACE
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    入力項目関連チェック
           PERFORM 4900-KANRENCHK-SEC
      *
           IF      SPA-ERRCD           NOT =   SPACE
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
           PERFORM 4901-SPASET-SEC
           IF      SPA-ERRCD           NOT =   SPACE
               GO  TO  490-KENSAKU-EXT
           END-IF
      * 
      
           MOVE    "Q01"               TO  SPA-MOTOPG
           MOVE    "Q02"               TO  SPA-SAKIPG
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "Q02    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *       診療年月日チェック処理
      *****************************************************************
       4900-SRYYMDCHK-SEC              SECTION.
      *
      *
      *    診療開始日チェック
      *    1.開始診療年月日≠ZEROかつ
      *      終了診療年月日≠ZEROのとき、
      *      開始診療年月日≦終了診療年月日であること
           IF      ( SPA-Q01-STSRYYMD  NOT =   ZERO )
            AND    ( SPA-Q01-EDSRYYMD  NOT =   ZERO )
               IF  ( SPA-Q01-STSRYYMD     <=   SPA-Q01-EDSRYYMD )
                   CONTINUE
               ELSE
                   MOVE    "1001"      TO   SPA-ERRCD
                   MOVE    1           TO   SPA-GMN-Q01-CUR
                   GO  TO  4900-SRYYMDCHK-EXT
               END-IF
           END-IF
      *
           .
       4900-SRYYMDCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の入力時チェック処理
      *****************************************************************
       4900-INPUTCHK-SEC               SECTION.
      *
           COMPUTE IDX2    = ( Q01-PAGENO  +   1 ) 
                           *   100 +   1
           COMPUTE IDX3    = IDX2  +   100
      *
           PERFORM VARYING IDX4    FROM    IDX2    BY  1
                   UNTIL ( IDX4    >=  IDX3 )
      *
               IF  ( SPA-GMN-Q01-ERRCD (IDX4)  NOT =   SPACE )
                   MOVE    IDX4    TO  SPA-GMN-Q01-CUR
                   MOVE    SPA-GMN-Q01-ERRCD (IDX4)
                                   TO  SPA-ERRCD
      *
                   COMPUTE IDX4    =   IDX4    +   100
      *
               END-IF
      *
           END-PERFORM
      *
           .
      *
       4900-INPUTCHK-EXT.
           EXIT.
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRCD
      *
           EVALUATE    Q01-PAGENO
               WHEN    0
                   PERFORM 4901-TAG1-CHK-SEC
               WHEN    1
                   PERFORM 4901-TAG2-CHK-SEC
               WHEN    2
                   PERFORM 4901-TAG3-CHK-SEC
               WHEN    3
                   PERFORM 4901-TAG4-CHK-SEC
           END-EVALUATE    
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       基本情報タグの関連チェック処理
      *****************************************************************
       4901-TAG1-CHK-SEC           SECTION.
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    ＜患者番号＞
      *    1.患者番号（ｎ）≠空白の場合、
      *      以下の項目はすべて初期値であること。
      *    ・開始生年月日・終了生年月日
      *    ・開始年齢・終了年齢
      *    ・性別
      *    ・住所
      *    ・カナ氏名
      *    ・漢字氏名
      *    ・コメント
      *    IF  ( SPA-Q01-PTID (1)  NOT =   ZERO )
      *     OR ( SPA-Q01-PTID (2)  NOT =   ZERO )
      *     OR ( SPA-Q01-PTID (3)  NOT =   ZERO )
      *     OR ( SPA-Q01-PTID (4)  NOT =   ZERO )
      *     OR ( SPA-Q01-PTID (5)  NOT =   ZERO )
      *        IF      ( SPA-Q01-STBIRTHDAY        =   ZERO  )
      *         AND    ( SPA-Q01-EDBIRTHDAY        =   ZERO  )
      *         AND    ( SPA-GMN-Q01-STAGE         =   SPACE )
      *         AND    ( SPA-GMN-Q01-EDAGE         =   SPACE )
      *         AND    ( SPA-GMN-Q01-SEX           =   SPACE )
      *         AND    ( SPA-GMN-Q01-JYUSHOTBL     =   SPACE )
      *         AND    ( SPA-GMN-Q01-KANANAMETBL   =   SPACE )
      *         AND    ( SPA-GMN-Q01-NAMETBL       =   SPACE )
      *         AND    ( SPA-GMN-Q01-COMMENTTBL    =   SPACE )
      *
      *            CONTINUE
      *        ELSE
      *
      *            カーソル位置設定処理
      *            PERFORM 4902-CUR-POSITION-SET-SEC
      *
      *            MOVE    "1006"      TO      SPA-ERRCD
      *
      *            GO  TO  4901-TAG1-CHK-EXT
      *        END-IF
      *    END-IF
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
      *    ＜患者番号＞
      *    1.開始患者番号≠空白かつ
      *      終了患者番号≠空白かつのとき、
      *      開始患者番号≦終了患者番号であること
           IF      ( SPA-Q01-STPTNUM       NOT =   SPACE )
            AND    ( SPA-Q01-EDPTNUM       NOT =   SPACE )
               IF  ( SPA-Q01-STPTNUM          <=  SPA-Q01-EDPTNUM )
                   CONTINUE
               ELSE
                   MOVE    "1006"      TO   SPA-ERRCD
                   MOVE    109         TO   SPA-GMN-Q01-CUR
                   GO  TO  4901-TAG1-CHK-EXT
               END-IF
           END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *    ＜生年月日＞
      *    1.開始生年月日≠ZEROかつ
      *      終了生年月日≠ZEROのとき、
      *      開始生年月日≦終了生年月日であること
           IF      ( SPA-Q01-STBIRTHDAY    NOT =   ZERO  )
            AND    ( SPA-Q01-EDBIRTHDAY    NOT =   ZERO  )
               IF  ( SPA-Q01-STBIRTHDAY       <=  SPA-Q01-EDBIRTHDAY )
                   CONTINUE
               ELSE
                   MOVE    "1002"      TO   SPA-ERRCD
                   MOVE    101         TO   SPA-GMN-Q01-CUR
                   GO  TO  4901-TAG1-CHK-EXT
               END-IF
           END-IF
      *
      *    ＜年齢＞
      *    1.開始年齢≠空白かつ
      *      終了年齢≠空白のとき、
      *      開始年齢≦終了年齢であること
           IF      ( SPA-GMN-Q01-STAGE NOT =   SPACE )
            AND    ( SPA-GMN-Q01-EDAGE NOT =   SPACE )
               IF  ( SPA-Q01-STAGE        <=   SPA-Q01-EDAGE )
                   CONTINUE
               ELSE
                   MOVE    "1003"      TO   SPA-ERRCD
                   MOVE    103         TO   SPA-GMN-Q01-CUR
                   GO  TO  4901-TAG1-CHK-EXT
               END-IF
           END-IF
      *
      *
      *    ＜生年月日・年齢＞
      *    1.開始生年月日≠ZEROまたは
      *      終了生年月日≠ZEROのとき、
      *      開始年齢＝空白かつ
      *      終了年齢＝空白であること。
           IF  ( SPA-Q01-STBIRTHDAY    NOT =   ZERO )
            OR ( SPA-Q01-EDBIRTHDAY    NOT =   ZERO )
               IF      ( SPA-GMN-Q01-STAGE =   SPACE )
                AND    ( SPA-GMN-Q01-EDAGE =   SPACE )
                   CONTINUE
               ELSE
                   MOVE    "1004"      TO  SPA-ERRCD
                   MOVE    101         TO  SPA-GMN-Q01-CUR
                   GO  TO  4901-TAG1-CHK-EXT
               END-IF
           END-IF
      *
      *    ＜年齢・基準日＞
      *    1.開始年齢≠空白または
      *      終了年齢≠空白のとき、
      *      基準日≠ZEROであること
           IF  ( SPA-GMN-Q01-STAGE     NOT =   SPACE )
            OR ( SPA-GMN-Q01-EDAGE     NOT =   SPACE )
               IF  ( SPA-Q01-KJYNYMD   NOT =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    "1005"      TO  SPA-ERRCD
                   MOVE    105         TO  SPA-GMN-Q01-CUR
                   GO  TO  4901-TAG1-CHK-EXT
               END-IF
           END-IF
      *
      *----(01.00.01) LINE ADD START ----------------------------------
      *    ＜最終受診日＞
      *    1.開始最終受診日≠ZEROかつ
      *      終了最終受診日≠ZEROのとき、
      *      開始最終受診日≦最終受診日終了日であること
           IF      ( SPA-Q01-STLASTYMD     NOT =   ZERO  )
            AND    ( SPA-Q01-EDLASTYMD     NOT =   ZERO  )
               IF  ( SPA-Q01-STLASTYMD        <=  SPA-Q01-EDLASTYMD )
                   CONTINUE
               ELSE
                   MOVE    "1008"      TO   SPA-ERRCD
                   MOVE    107         TO   SPA-GMN-Q01-CUR
                   GO  TO  4901-TAG1-CHK-EXT
               END-IF
           END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
           .
       4901-TAG1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の該当編集・チェック処理
      *****************************************************************
       4901-SPASET-SEC           SECTION.
      *
           MOVE    SPACE                   TO  SPA-Q01-GAITO-TABLE
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    該当（１）
      *    IF  ( SPA-Q01-PTID (1)          NOT =   ZERO )
      *     OR ( SPA-Q01-PTID (2)          NOT =   ZERO )
      *     OR ( SPA-Q01-PTID (3)          NOT =   ZERO )
      *     OR ( SPA-Q01-PTID (4)          NOT =   ZERO )
      *     OR ( SPA-Q01-PTID (5)          NOT =   ZERO )
      *
      *        MOVE    "1"                 TO  SPA-Q01-GTBL(1)
      *
      *    END-IF
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START --------------------------------
      *    該当（１）
           IF  ( SPA-Q01-STPTNUM           NOT =   SPACE )
            OR ( SPA-Q01-EDPTNUM           NOT =   SPACE )
               MOVE    "1"                 TO  SPA-Q01-GTBL(1)
      *
           END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *    該当（２）
           IF  ( SPA-GMN-Q01-KANANAMETBL       NOT =   SPACE )
            OR ( SPA-GMN-Q01-NAMETBL           NOT =   SPACE )
      *
               MOVE    "1"                 TO  SPA-Q01-GTBL(2)
      *
           END-IF
      *
      *    該当（３）
      *----(01.00.01) LINE DEL START ----------------------------------
      *    IF  ( SPA-Q01-LASTYMD           NOT =   ZERO )
      *        MOVE    "1"                 TO  SPA-Q01-GTBL(3)
      *    END-IF
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           IF  ( SPA-Q01-STLASTYMD         NOT =   ZERO )
            OR ( SPA-Q01-EDLASTYMD         NOT =   ZERO )
               MOVE    "1"                 TO  SPA-Q01-GTBL(3)
           END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *    該当（４）
      *----(01.00.01) LINE UPD START ----------------------------------
      *    IF  ( SPA-GMN-Q01-BYOMEICDTBL       NOT =   SPACE )
           IF  ( SPA-GMN-Q01-BYOMEINMTBL   NOT =   SPACE )
      *----(01.00.01) LINE UPD END   ----------------------------------
      *
               MOVE    "1"                 TO  SPA-Q01-GTBL(4)
      *
           END-IF
      *
      *
      *    該当（５）
      *----(01.00.02) LINE DEL START ----------------------------------
      *    IF  ( SPA-GMN-Q01-KIGOTBL           NOT =   SPACE )
      *     OR ( SPA-GMN-Q01-NUMTBL            NOT =   SPACE )
      *
      *       MOVE     "1"                 TO  SPA-Q01-GTBL(5)
      *
      *    END-IF
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD END   ----------------------------------
           IF  ( SPA-Q01-HKNJANUM-G            NOT =   SPACE )
            OR ( SPA-Q01-HKNNUM-G              NOT =   SPACE )
            OR ( SPA-Q01-KIGO-G                NOT =   SPACE )
            OR ( SPA-Q01-NUM-G                 NOT =   SPACE )
      *
              MOVE     "1"                 TO  SPA-Q01-GTBL(5)
      *
           END-IF
      *----(01.00.02) LINE ADD START ----------------------------------
      *
      *    該当（６）
      *----(01.00.02) LINE DEL START ----------------------------------
      *    IF  ( SPA-GMN-Q01-KOHNUMTBL         NOT =   SPACE )
      *     OR ( SPA-GMN-Q01-FTNJANUMTBL       NOT =   SPACE )
      *
      *       MOVE     "1"                 TO  SPA-Q01-GTBL(6)
      *
      *    END-IF
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           IF  ( SPA-Q01-KOHNUM-G              NOT =   SPACE )
            OR ( SPA-Q01-FTNJANUM-G            NOT =   SPACE )
      *
              MOVE     "1"                 TO  SPA-Q01-GTBL(6)
      *
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    該当（７）
           IF  ( SPA-GMN-Q01-JYUSHOTBL         NOT =   SPACE )
            OR ( SPA-GMN-Q01-COMMENTTBL        NOT =   SPACE )
            OR ( SPA-Q01-STBIRTHDAY        NOT =   ZERO  )
            OR ( SPA-Q01-EDBIRTHDAY        NOT =   ZERO  )
            OR ( SPA-GMN-Q01-STAGE         NOT =   SPACE )
            OR ( SPA-GMN-Q01-EDAGE         NOT =   SPACE )
      *----(01.00.01) LINE DEL START ----------------------------------
      *     OR ( SPA-GMN-Q01-SEX               NOT =   SPACE )
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
            OR ( SPA-GMN-Q01-SEX (1:1)         NOT =   SPACE )
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
               MOVE    "1"                 TO  SPA-Q01-GTBL(7)
      *
           END-IF
      *
      *    該当（８）
           IF  ( SPA-Q01-STSRYYMD          NOT =   ZERO  )
            OR ( SPA-Q01-EDSRYYMD          NOT =   ZERO  )
      *
               MOVE    "1"                 TO  SPA-Q01-GTBL(8)
      *
           END-IF
      *
      *    該当（９）
           IF  ( SPA-GMN-Q01-SRYCDTBL          NOT =   SPACE )
      *
              MOVE     "1"                 TO  SPA-Q01-GTBL(9)
      *
           END-IF
      *
      *    検索条件が未入力のとき
           IF  ( SPA-Q01-GAITO-TABLE       =   SPACE )
               MOVE    "1007"              TO  SPA-ERRCD
               GO  TO  4901-SPASET-EXT
           END-IF
      *
      *    年齢が入力のとき、生年月日を計算  
      *    ex.2003.04.01現在で１〜２歳の子供が対象の場合、
      *       2001.04.02〜2002.04.01の間の生年月日の子供が対象と
      *       なるように換算する
           IF  (   SPA-GMN-Q01-STAGE   NOT =   SPACE )
               COMPUTE SPA-Q01-EDBIRTHDAY
                                       =   SPA-Q01-KJYNYMD
                                       -   SPA-Q01-STAGE
                                       *   10000
           END-IF
      *
           IF  (   SPA-GMN-Q01-EDAGE   NOT =   SPACE )
               COMPUTE SPA-Q01-STBIRTHDAY
                                       =   SPA-Q01-KJYNYMD
                                       -  ( SPA-Q01-EDAGE + 1 )
                                       *   10000
               INITIALIZE                  STS-AREA-DAY
               INITIALIZE                  LNK-DAY6-AREA
               MOVE    "61"                TO  LNK-DAY6-IRAI
               MOVE    SPA-Q01-STBIRTHDAY  TO  LNK-DAY6-KIJUN
               MOVE    "1"                 TO  LNK-DAY6-ZOGENPTN
               MOVE     1                  TO  LNK-DAY6-ZOGEN
               CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN     TO  SPA-Q01-STBIRTHDAY
           END-IF
      *----(01.00.02) LINE ADD START ----------------------------------
           IF    ( SPA-GMN-Q01-STAGE       =   SPACE )
            AND  ( SPA-GMN-Q01-EDAGE       =   SPACE )
               MOVE    ZERO                TO  SPA-Q01-AGE-CALC-KBN
           ELSE
               MOVE    1                   TO  SPA-Q01-AGE-CALC-KBN
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
      *    テスト患者チェックボタン
           MOVE    SPA-GMN-Q01-CHKTSTPT    TO  SPA-Q01-CHKTSTPT 
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   3 )
               IF  ( Q01-RDIO1 (IDX1)      =   "T" )
                   MOVE    1               TO  SPA-Q01-NARABE (IDX1)
               ELSE
                   MOVE    2               TO  SPA-Q01-NARABE (IDX1)
               END-IF
           END-PERFORM
      *
           MOVE    SPA-GMN-Q01-KMK (1) (1:1)   TO  SPA-Q01-KMK (1)
           MOVE    SPA-GMN-Q01-KMK (2) (1:1)   TO  SPA-Q01-KMK (2)
           MOVE    SPA-GMN-Q01-KMK (3) (1:1)   TO  SPA-Q01-KMK (3)
           .
       4901-SPASET-EXT.
           EXIT.
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *****************************************************************
      *    カーソル位置設定処理
      *****************************************************************
      *4902-CUR-POSITION-SET-SEC   SECTION.
      *
      *    EVALUATE    TRUE
      *    WHEN    SPA-Q01-STBIRTHDAY  NOT =   ZERO
      *        MOVE    101     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-Q01-EDBIRTHDAY  NOT =   ZERO
      *        MOVE    102     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-STAGE   NOT =   SPACE
      *        MOVE    103     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-EDAGE   NOT =   SPACE
      *        MOVE    104     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-SEX     NOT =   SPACE
      *        MOVE    106     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-JYUSHO (1)
      *                                NOT =   SPACE
      *        MOVE    114     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-JYUSHO (2)
      *                                NOT =   SPACE
      *        MOVE    116     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-JYUSHO (3)
      *                                NOT =   SPACE
      *        MOVE    118     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-JYUSHO (4)
      *                                NOT =   SPACE
      *        MOVE    120     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-JYUSHO (5)
      *                                NOT =   SPACE
      *        MOVE    122     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-KANANAME (1)
      *                                NOT =   SPACE
      *        MOVE    123     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-KANANAME (2)
      *                                NOT =   SPACE
      *        MOVE    124     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-KANANAME (3)
      *                                NOT =   SPACE
      *        MOVE    125     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-KANANAME (4)
      *                                NOT =   SPACE
      *        MOVE    126     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-KANANAME (5)
      *                                NOT =   SPACE
      *        MOVE    127     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-NAME (1)
      *                                NOT =   SPACE
      *        MOVE    128     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-NAME (2)
      *                                NOT =   SPACE
      *        MOVE    129     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-NAME (3)
      *                                NOT =   SPACE
      *        MOVE    130     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-NAME (4)
      *                                NOT =   SPACE
      *        MOVE    131     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-NAME (5)
      *                                NOT =   SPACE
      *        MOVE    132     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-COMMENT (1)
      *                                NOT =   SPACE
      *        MOVE    133     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-COMMENT (2)
      *                                NOT =   SPACE
      *        MOVE    134     TO      SPA-GMN-Q01-CUR
      *
      *    WHEN    SPA-GMN-Q01-COMMENT (3)
      *                                NOT =   SPACE
      *        MOVE    135     TO      SPA-GMN-Q01-CUR
      *
      *    END-EVALUATE
      *
      *    .
      *
      *4902-CUR-POSITION-SET-EXT.
      *    EXIT.
      *----(01.00.01) LINE DEL END   ----------------------------------
      *****************************************************************
      *       保険・公費情報タグの関連チェック処理
      *****************************************************************
       4901-TAG2-CHK-SEC               SECTION.
      *
           .
       4901-TAG2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       病名・診療行為情報タグの関連チェック処理
      *****************************************************************
       4901-TAG3-CHK-SEC               SECTION.
      *
           .
       4901-TAG3-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       並び順情報タグの関連チェック処理
      *****************************************************************
       4901-TAG4-CHK-SEC               SECTION.
      *
           .
       4901-TAG4-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC             SECTION.
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           DISPLAY "SGDAY-INDAY ="     SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           DISPLAY "SGDAY-RC    ="     SGDAY-RC
           IF  ( SGDAY-RC              =   ZERO )
               MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY          TO  WRK-SYMD
           ELSE
               MOVE    "0001"              TO  SPA-ERRCD
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC             SECTION.
      *
           IF  ( WRK-SYMD          =   ALL "9"  OR   ZERO )
               MOVE    WRK-SYMD (1:8)      TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
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
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "Q01"               TO  MCP-WINDOW.
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
      *    タブページ番号
           MOVE    SPA-GMN-Q01-PAGENO      TO  Q01-PAGENO
      *    開始診療年月日
           MOVE    SPA-GMN-Q01-STSRYYMD    TO  Q01-STSRYYMD
      *    終了診療年月日
           MOVE    SPA-GMN-Q01-EDSRYYMD    TO  Q01-EDSRYYMD
      *    開始生年月日
           MOVE    SPA-GMN-Q01-STBIRTHDAY  TO  Q01-STBIRTHDAY
      *    終了生年月日
           MOVE    SPA-GMN-Q01-EDBIRTHDAY  TO  Q01-EDBIRTHDAY
      *    開始年齢
           MOVE    SPA-GMN-Q01-STAGE       TO  Q01-STAGE
      *    終了年齢
           MOVE    SPA-GMN-Q01-EDAGE       TO  Q01-EDAGE
      *    基準日
           MOVE    SPA-GMN-Q01-KJYNYMD     TO  Q01-KJYNYMD
      *    性別
           MOVE    SPA-GMN-Q01-SEX         TO  Q01-SEX
           MOVE    SPA-GMN-Q01-SEX-ITEM (1)
                                           TO  Q01-SEX-ITEM (1)
           MOVE    SPA-GMN-Q01-SEX-ITEM (2)
                                           TO  Q01-SEX-ITEM (2)
      *----(01.00.01) LINE ADD START ----------------------------------
           MOVE    SPA-GMN-Q01-SEX-ITEM (3)
                                           TO  Q01-SEX-ITEM (3)
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.01) LINE DEL START ----------------------------------
      *    MOVE    2                       TO  Q01-SEX-COUNT
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
           MOVE    3                       TO  Q01-SEX-COUNT
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.01) LINE DEL START ----------------------------------
      *    最終受診日
      *    MOVE    SPA-GMN-Q01-LASTYMD     TO  Q01-LASTYMD
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
      *    開始最終受診日
           MOVE    SPA-GMN-Q01-STLASTYMD   TO  Q01-STLASTYMD
      *    終了最終受診日
           MOVE    SPA-GMN-Q01-EDLASTYMD   TO  Q01-EDLASTYMD
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
      *    開始患者番号
           MOVE    SPA-GMN-Q01-STPTNUM     TO  Q01-STPTNUM
      *    終了患者番号
           MOVE    SPA-GMN-Q01-EDPTNUM     TO  Q01-EDPTNUM
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
      *    テスト患者チェックボタン
           MOVE    SPA-GMN-Q01-CHKTSTPT    TO  Q01-CHKTSTPT
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       5
      *----(01.00.01) LINE DEL START ----------------------------------
      *        患者番号
      *        MOVE    SPA-GMN-Q01-PTNUM   (IDX1)
      *                                    TO  Q01-PTNUM   (IDX1)
      *----(01.00.01) LINE DEL END   ----------------------------------
      *
      *        郵便番号
               MOVE    SPA-GMN-Q01-POST   (IDX1)
                                           TO  Q01-POST    (IDX1)
      *        住所
               MOVE    SPA-GMN-Q01-JYUSHO  (IDX1)
                                           TO  Q01-JYUSHO  (IDX1)
      *        カナ氏名
               MOVE    SPA-GMN-Q01-KANANAME(IDX1)
                                           TO  Q01-KANANAME(IDX1)
      *        漢字氏名
               MOVE    SPA-GMN-Q01-NAME    (IDX1)
                                           TO  Q01-NAME    (IDX1)
           END-PERFORM
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       3
      *        コメント
               MOVE    SPA-GMN-Q01-COMMENT (IDX1)
                                           TO  Q01-COMMENT (IDX1)
           END-PERFORM
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       5
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *        保険者番号
               MOVE    SPA-GMN-Q01-HKNJANUM(IDX1)
                                           TO  Q01-HKNJANUM(IDX1)
      *        保険の種類
               MOVE    SPA-GMN-Q01-HKNNUM  (IDX1)
                                           TO  Q01-HKNNUM  (IDX1)
      *----(01.00.02) LINE ADD END   ----------------------------------
      *        保険記号
               MOVE    SPA-GMN-Q01-KIGO    (IDX1)
                                           TO  Q01-KIGO    (IDX1)
      *
      *        保険番号
               MOVE    SPA-GMN-Q01-NUM     (IDX1)
                                           TO  Q01-NUM     (IDX1)
      *
      *        公費保険番号
               MOVE    SPA-GMN-Q01-KOHNUM  (IDX1)
                                           TO  Q01-KOHNUM  (IDX1)
      *
      *        公費負担者番号
               MOVE    SPA-GMN-Q01-FTNJANUM(IDX1)
                                           TO  Q01-FTNJANUM(IDX1)
      *----(01.00.02) LINE ADD START ----------------------------------
               MOVE    SPA-GMN-Q01-CNB-HKNNUM-COUNT (IDX1)
                                           TO  Q01-CNB-HKNNUM-COUNT
                                                           (IDX1)
      *
               PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2        >   Q01-CNB-HKNNUM-COUNT )
      *
                   MOVE    SPA-GMN-Q01-CNB-HKNNUM-ITEM (IDX1 IDX2)
                               TO  Q01-CNB-HKNNUM-ITEM (IDX1 IDX2)
      *
               END-PERFORM
      *
               MOVE    SPA-GMN-Q01-CNB-KOHNUM-COUNT (IDX1)
                                           TO  Q01-CNB-KOHNUM-COUNT
                                                           (IDX1)
      *
               PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2        >   Q01-CNB-KOHNUM-COUNT )
      *
                   MOVE    SPA-GMN-Q01-CNB-KOHNUM-ITEM (IDX1 IDX2)
                               TO  Q01-CNB-KOHNUM-ITEM (IDX1 IDX2)
      *
               END-PERFORM
      *
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           END-PERFORM
      *
      *    病名検索ラジオボタン
           MOVE    SPA-GMN-Q01-RDBYOMEI-U  TO  Q01-RDBYOMEI-U
           MOVE    SPA-GMN-Q01-RDBYOMEI-U-STATE
                                           TO  Q01-RDBYOMEI-U-STATE
           MOVE    SPA-GMN-Q01-RDBYOMEI-A  TO  Q01-RDBYOMEI-A
           MOVE    SPA-GMN-Q01-RDBYOMEI-A-STATE
                                           TO  Q01-RDBYOMEI-A-STATE
      *    病名検索コンボボックス
           MOVE    SPA-GMN-Q01-BYOBUN      TO  Q01-BYOBUN
           MOVE    SPA-GMN-Q01-BYOBUN-STATE
                                           TO  Q01-BYOBUN-STATE
           MOVE    SPA-GMN-Q01-CNB-BYOBUN-STATE
                                           TO  Q01-CNB-BYOBUN-STATE
           MOVE    SPA-GMN-Q01-CNB-BYOBUN-COUNT
                                           TO  Q01-CNB-BYOBUN-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       SPA-GMN-Q01-CNB-BYOBUN-COUNT
               MOVE    SPA-GMN-Q01-CNB-BYOBUN-ITEM (IDX1)
                                           TO  Q01-CNB-BYOBUN-ITEM
                                                               (IDX1)
           END-PERFORM
      *
      *    病名検索
           MOVE    SPA-GMN-Q01-BYOMEISEL   TO  Q01-BYOMEISEL
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       5
      *        病名コード
               MOVE    SPA-GMN-Q01-BYOMEICD(IDX1)
                                           TO  Q01-BYOMEICD(IDX1)
      *----(01.00.01) LINE ADD START ----------------------------------
      *        病名
               MOVE    SPA-GMN-Q01-BYOMEI  (IDX1)
                                           TO  Q01-BYOMEI  (IDX1)
      *----(01.00.01) LINE ADD END   ----------------------------------
      *        診療行為コード
               MOVE    SPA-GMN-Q01-SRYCD(IDX1)
                                           TO  Q01-SRYCD(IDX1)
      *----(01.00.01) LINE ADD START ----------------------------------
      *        診療行為
               MOVE    SPA-GMN-Q01-SRYACT(IDX1)
                                           TO  Q01-SRYACT(IDX1)
      *----(01.00.01) LINE ADD END   ----------------------------------
           END-PERFORM
      *
      *    病名リスト
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       SPA-GMN-Q01-BYOMEI-MAX
      *        病名コード
               MOVE    SPA-GMN-Q01-TBYOMEICD(IDX1)
                                           TO  Q01-BYOLST-BYOMEICD(IDX1)
      *        病名
               MOVE    SPA-GMN-Q01-TBYOMEI  (IDX1)
                                           TO  Q01-BYOLST-BYOMEI  (IDX1)
           END-PERFORM
      *
      *    病名リスト内件数
           MOVE    SPA-GMN-Q01-BYOMEI-MAX      TO  Q01-BYOLST-COUNT
      *
           IF      SPA-GMN-Q01-BYOMEI-SEL  =   1
               MOVE    ALL "F"             TO  Q01-BYOLST-SELECT-TBL
               MOVE    "T"                 TO  Q01-BYOLST-SELECT (1)
               MOVE    ZERO                TO  SPA-GMN-Q01-BYOMEI-SEL
           END-IF
      *
      *    行為名検索
           MOVE    SPA-GMN-Q01-SRYACTSEL   TO  Q01-SRYACTSEL
      *
      *    行為名リスト
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       SPA-GMN-Q01-SRYACT-MAX
      *        行為名コード
               MOVE    SPA-GMN-Q01-TSRYCD(IDX1)
                                           TO  Q01-SRYLST-SRYCD(IDX1)
      *        行為名
               MOVE    SPA-GMN-Q01-TSRYACT  (IDX1)
                                           TO  Q01-SRYLST-SRYACT  (IDX1)
      *
           END-PERFORM
      *
      *    行為名リスト内件数
           MOVE    SPA-GMN-Q01-SRYACT-MAX      TO  Q01-SRYLST-COUNT
      *
           IF      SPA-GMN-Q01-SRYACT-SEL  =   1
               MOVE    ALL "F"             TO  Q01-SRYLST-SELECT-TBL
               MOVE    "T"                 TO  Q01-SRYLST-SELECT (1)
               MOVE    ZERO                TO  SPA-GMN-Q01-SRYACT-SEL
           END-IF
      *
      *    並び順コンボ
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       3
               MOVE    SPA-GMN-Q01-KMK (IDX1)
                                           TO  Q01-CNB-KMK (IDX1)
      *----(01.00.01) LINE ADD START ----------------------------------
      *        MOVE    4                   TO  Q01-CNB-KMK-COUNT (IDX1)
               MOVE    5                   TO  Q01-CNB-KMK-COUNT (IDX1)
      *----(01.00.01) LINE ADD END   ----------------------------------
           END-PERFORM
      *
      *    並び順コンボ
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       4
               MOVE    SPA-GMN-Q01-KMK-ITEM(1, IDX1)
                                           TO  Q01-CNB-KMK-ITEM(1, IDX1)
               MOVE    SPA-GMN-Q01-KMK-ITEM(2, IDX1)
                                           TO  Q01-CNB-KMK-ITEM(2, IDX1)
               MOVE    SPA-GMN-Q01-KMK-ITEM(3, IDX1)
                                           TO  Q01-CNB-KMK-ITEM(3, IDX1)
           END-PERFORM
      *
      *    並び順ボタン
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       3
      *
               MOVE    SPA-GMN-Q01-RDIO1 (IDX1)
                                           TO  Q01-RDIO1 (IDX1)
               MOVE    SPA-GMN-Q01-RDIO2 (IDX1)
                                           TO  Q01-RDIO2 (IDX1)
      *
           END-PERFORM
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
           EVALUATE    SPA-GMN-Q01-CUR
      *
      *    診療年月日
           WHEN   001
               MOVE  "STSRYYMD"    TO  MCP-WIDGET
           WHEN   002
               MOVE  "EDSRYYMD"    TO  MCP-WIDGET
      *
      *    基本情報タグ
           WHEN   101
               MOVE  "STBIRTHDAY"  TO  MCP-WIDGET
           WHEN   102
               MOVE  "EDBIRTHDAY"  TO  MCP-WIDGET
           WHEN   103
               MOVE  "STAGE"       TO  MCP-WIDGET
           WHEN   104
               MOVE  "EDAGE"       TO  MCP-WIDGET
           WHEN   105
               MOVE  "KJYNYMD"     TO  MCP-WIDGET
           WHEN   106
               MOVE  "SEX"         TO  MCP-WIDGET
           WHEN   107
      *----(01.00.01) LINE DEL START ----------------------------------
      *        MOVE  "LASTYMD"     TO  MCP-WIDGET
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
               MOVE  "STLASTYMD"   TO  MCP-WIDGET
           WHEN   108
               MOVE  "EDLASTYMD"   TO  MCP-WIDGET
           WHEN   109
               MOVE  "STPTNUM"     TO  MCP-WIDGET
           WHEN   110
               MOVE  "EDPTNUM"     TO  MCP-WIDGET
      *----(01.00.01) LINE ADD END   ----------------------------------
      *----(01.00.01) LINE DEL START ----------------------------------
      *    WHEN   108
      *        MOVE  "PTNUM1"      TO  MCP-WIDGET
      *    WHEN   109
      *        MOVE  "PTNUM2"      TO  MCP-WIDGET
      *    WHEN   110
      *        MOVE  "PTNUM3"      TO  MCP-WIDGET
      *    WHEN   111
      *        MOVE  "PTNUM4"      TO  MCP-WIDGET
      *    WHEN   112
      *        MOVE  "PTNUM5"      TO  MCP-WIDGET
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   113
           WHEN   111
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "POST1"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   114
           WHEN   112
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "JYUSHO1"     TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   115
           WHEN   113
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "POST2"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   116
           WHEN   114
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "JYUSHO2"     TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   117
           WHEN   115
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "POST3"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   118
           WHEN   116
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "JYUSHO3"     TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   119
           WHEN   117
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "POST4"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   120
           WHEN   118
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "JYUSHO4"     TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   121
           WHEN   119
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "POST5"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   122
           WHEN   120
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "JYUSHO5"     TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   123
           WHEN   121
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "KANANAME1"   TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   124
           WHEN   122
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "KANANAME2"   TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   125
           WHEN   123
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "KANANAME3"   TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   126
           WHEN   124
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "KANANAME4"   TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   127
           WHEN   125
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "KANANAME5"   TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   128
           WHEN   126
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "NAME1"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   129
           WHEN   127
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "NAME2"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   130
           WHEN   128
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "NAME3"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   131
           WHEN   129
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "NAME4"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   132
           WHEN   130
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "NAME5"       TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   133
           WHEN   131
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "COMMENT1"    TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   134
           WHEN   132
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "COMMENT2"    TO  MCP-WIDGET
      *----(01.00.01) LINE UPD START ----------------------------------
      *    WHEN   135
           WHEN   133
      *----(01.00.01) LINE UPD END   ----------------------------------
               MOVE  "COMMENT3"    TO  MCP-WIDGET
      *
      *    保険・公費タグ
      *----(01.00.02) LINE DEL START ----------------------------------
      *    WHEN   201
      *        MOVE  "KIGO1"       TO  MCP-WIDGET
      *    WHEN   202
      *        MOVE  "NUM1"        TO  MCP-WIDGET
      *    WHEN   203
      *        MOVE  "KIGO2"       TO  MCP-WIDGET
      *    WHEN   204
      *        MOVE  "NUM2"        TO  MCP-WIDGET
      *    WHEN   205
      *        MOVE  "KIGO3"       TO  MCP-WIDGET
      *    WHEN   206
      *        MOVE  "NUM3"        TO  MCP-WIDGET
      *    WHEN   207
      *        MOVE  "KIGO4"       TO  MCP-WIDGET
      *    WHEN   208
      *        MOVE  "NUM4"        TO  MCP-WIDGET
      *    WHEN   209
      *        MOVE  "KIGO5"       TO  MCP-WIDGET
      *    WHEN   210
      *        MOVE  "NUM5"        TO  MCP-WIDGET
      *    WHEN   211
      *        MOVE  "KOHNUM1"     TO  MCP-WIDGET
      *    WHEN   212
      *        MOVE  "KOHNUM2"     TO  MCP-WIDGET
      *    WHEN   213
      *        MOVE  "KOHNUM3"     TO  MCP-WIDGET
      *    WHEN   214
      *        MOVE  "KOHNUM4"     TO  MCP-WIDGET
      *    WHEN   215
      *        MOVE  "KOHNUM5"     TO  MCP-WIDGET
      *    WHEN   216
      *        MOVE  "FTNJANUM1"   TO  MCP-WIDGET
      *    WHEN   217
      *        MOVE  "FTNJANUM2"   TO  MCP-WIDGET
      *    WHEN   218
      *        MOVE  "FTNJANUM3"   TO  MCP-WIDGET
      *    WHEN   219
      *        MOVE  "FTNJANUM4"   TO  MCP-WIDGET
      *    WHEN   220
      *        MOVE  "FTNJANUM5"   TO  MCP-WIDGET
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           WHEN   201
               MOVE  "HKNJANUM1"   TO  MCP-WIDGET
           WHEN   202
               MOVE  "HKNJANUM2"   TO  MCP-WIDGET
           WHEN   203
               MOVE  "HKNJANUM3"   TO  MCP-WIDGET
           WHEN   204
               MOVE  "HKNJANUM4"   TO  MCP-WIDGET
           WHEN   205
               MOVE  "HKNJANUM5"   TO  MCP-WIDGET
           WHEN   206
               MOVE  "HKNNUM1"     TO  MCP-WIDGET
           WHEN   207
               MOVE  "HKNNUM2"     TO  MCP-WIDGET
           WHEN   208
               MOVE  "HKNNUM3"     TO  MCP-WIDGET
           WHEN   209
               MOVE  "HKNNUM4"     TO  MCP-WIDGET
           WHEN   210
               MOVE  "HKNNUM5"     TO  MCP-WIDGET
           WHEN   211
               MOVE  "KIGO1"       TO  MCP-WIDGET
           WHEN   212
               MOVE  "NUM1"        TO  MCP-WIDGET
           WHEN   213
               MOVE  "KIGO2"       TO  MCP-WIDGET
           WHEN   214
               MOVE  "NUM2"        TO  MCP-WIDGET
           WHEN   215
               MOVE  "KIGO3"       TO  MCP-WIDGET
           WHEN   216
               MOVE  "NUM3"        TO  MCP-WIDGET
           WHEN   217
               MOVE  "KIGO4"       TO  MCP-WIDGET
           WHEN   218
               MOVE  "NUM4"        TO  MCP-WIDGET
           WHEN   219
               MOVE  "KIGO5"       TO  MCP-WIDGET
           WHEN   220
               MOVE  "NUM5"        TO  MCP-WIDGET
           WHEN   221
               MOVE  "KOHNUM1"     TO  MCP-WIDGET
           WHEN   222
               MOVE  "KOHNUM2"     TO  MCP-WIDGET
           WHEN   223
               MOVE  "KOHNUM3"     TO  MCP-WIDGET
           WHEN   224
               MOVE  "KOHNUM4"     TO  MCP-WIDGET
           WHEN   225
               MOVE  "KOHNUM5"     TO  MCP-WIDGET
           WHEN   226
               MOVE  "FTNJANUM1"   TO  MCP-WIDGET
           WHEN   227
               MOVE  "FTNJANUM2"   TO  MCP-WIDGET
           WHEN   228
               MOVE  "FTNJANUM3"   TO  MCP-WIDGET
           WHEN   229
               MOVE  "FTNJANUM4"   TO  MCP-WIDGET
           WHEN   230
               MOVE  "FTNJANUM5"   TO  MCP-WIDGET
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    病名・診療行為タグ
           WHEN   301
               MOVE  "BYOBUN"      TO  MCP-WIDGET
           WHEN   302
               MOVE  "BYOMEISEL"   TO  MCP-WIDGET
      *----(01.00.02) LINE DEL START ----------------------------------
      *    WHEN   303
      *        MOVE  "BYOMEICD1"   TO  MCP-WIDGET
      *    WHEN   304
      *        MOVE  "BYOMEICD2"   TO  MCP-WIDGET
      *    WHEN   305
      *        MOVE  "BYOMEICD3"   TO  MCP-WIDGET
      *    WHEN   306
      *        MOVE  "BYOMEICD4"   TO  MCP-WIDGET
      *    WHEN   307
      *        MOVE  "BYOMEICD5"   TO  MCP-WIDGET
      *    WHEN   308
      *        MOVE  "SRYACTSEL"   TO  MCP-WIDGET
      *    WHEN   309
      *        MOVE  "SRYCD1"      TO  MCP-WIDGET
      *    WHEN   310
      *        MOVE  "SRYCD2"      TO  MCP-WIDGET
      *    WHEN   311
      *        MOVE  "SRYCD3"      TO  MCP-WIDGET
      *    WHEN   312
      *        MOVE  "SRYCD4"      TO  MCP-WIDGET
      *    WHEN   313
      *        MOVE  "SRYCD5"      TO  MCP-WIDGET
      *----(01.00.02) LINE DEL END   ----------------------------------
      *----(01.00.02) LINE ADD START ----------------------------------
           WHEN   303
               MOVE  "BYOMEICD1"   TO  MCP-WIDGET
           WHEN   304
               MOVE  "BYOMEI1"     TO  MCP-WIDGET
           WHEN   305
               MOVE  "BYOMEICD2"   TO  MCP-WIDGET
           WHEN   306
               MOVE  "BYOMEI2"     TO  MCP-WIDGET
           WHEN   307
               MOVE  "BYOMEICD3"   TO  MCP-WIDGET
           WHEN   308
               MOVE  "BYOMEI3"     TO  MCP-WIDGET
           WHEN   309
               MOVE  "BYOMEICD4"   TO  MCP-WIDGET
           WHEN   310
               MOVE  "BYOMEI4"     TO  MCP-WIDGET
           WHEN   311
               MOVE  "BYOMEICD5"   TO  MCP-WIDGET
           WHEN   312
               MOVE  "BYOMEI5"     TO  MCP-WIDGET
           WHEN   313
               MOVE  "SRYACTSEL"   TO  MCP-WIDGET
           WHEN   314
               MOVE  "SRYCD1"      TO  MCP-WIDGET
           WHEN   315
               MOVE  "SRYCD2"      TO  MCP-WIDGET
           WHEN   316
               MOVE  "SRYCD3"      TO  MCP-WIDGET
           WHEN   317
               MOVE  "SRYCD4"      TO  MCP-WIDGET
           WHEN   318
               MOVE  "SRYCD5"      TO  MCP-WIDGET
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    並び順タグ
           WHEN   401
               MOVE  "KMK1"        TO  MCP-WIDGET
           WHEN   402
               MOVE  "KMK2"        TO  MCP-WIDGET
           WHEN   403
               MOVE  "KMK3"        TO  MCP-WIDGET
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
               MOVE    "入力エラー"    TO  SPA-ERRMSG
           WHEN    "0002"
      *----(01.00.01) LINE DEL START ----------------------------------
      *        MOVE    "この番号の患者は登録されていません" 
      *                                TO  SPA-ERRMSG
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
               MOVE    "患者番号の桁数が違います" 
                                       TO  SPA-ERRMSG
      *----(01.00.01) LINE ADD END   ----------------------------------
           WHEN    "0003"
               MOVE    "対象件数が２００件をオーバーしました" 
                                       TO  SPA-ERRMSG
           WHEN    "0004"
               MOVE    "このコードの病名は登録されていません" 
                                       TO  SPA-ERRMSG
           WHEN    "0005"
               MOVE    "このコードの行為名は登録されていません"
                                       TO  SPA-ERRMSG
           WHEN    "0006"
               MOVE    "未来日は入力できません"
                                       TO  SPA-ERRMSG
           WHEN    "0007"
               MOVE    "セットコードは入力できません"
                                       TO  SPA-ERRMSG
           WHEN    "0008"
               MOVE    "項目を設定してください"
                                       TO  SPA-ERRMSG
      *----(01.00.02) LINE ADD START ----------------------------------
           WHEN    "0009"
               MOVE    "全角文字でのみ入力してください"
                                       TO  SPA-ERRMSG
      *----(01.00.02) LINE ADD END   ----------------------------------
           WHEN    "1001"
               MOVE    "開始診療年月日＞終了診療年月日となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1002"
               MOVE    "開始生年月日＞終了生年月日となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1003"
               MOVE    "開始年齢＞終了年齢となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1004"
               MOVE    "生年月日と年齢は同時に入力できません"
                                       TO  SPA-ERRMSG
           WHEN    "1005"
               MOVE    "年齢を入力する場合、基準日は必須項目です"
                                       TO  SPA-ERRMSG
           WHEN    "1006"
      *----(01.00.01) LINE DEL START ----------------------------------
      *        MOVE    "患者番号と同時には入力できない項目が入力"
      *                                TO  SPA-ERRMSG (1:40)
      *        MOVE    "されています"
      *                                TO  SPA-ERRMSG (41:)
      *----(01.00.01) LINE DEL END   ----------------------------------
      *----(01.00.01) LINE ADD START ----------------------------------
               MOVE    "開始患者番号＞終了患者番号となっています"
                                       TO  SPA-ERRMSG
      *----(01.00.01) LINE ADD END   ----------------------------------
           WHEN    "1007"
               MOVE    "検索条件が入力されていません"
                                       TO  SPA-ERRMSG
      *----(01.00.01) LINE ADD START ----------------------------------
           WHEN    "1008"
               MOVE    "開始最終受診日＞終了最終受診日となっています"
                                       TO  SPA-ERRMSG
      *----(01.00.01) LINE ADD END   ----------------------------------
           END-EVALUATE
      *
           MOVE    SPACE                TO  QERR
           MOVE    SPA-ERRCD            TO  QERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  QERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "Q01"                TO  SPA-MOTOPG
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
      *****************************************************************
      *    エラーコード設定処理
      *****************************************************************
       510-ERRCD-SET-SEC               SECTION.
      *
           MOVE    SPA-ERRCD   TO  SPA-GMN-Q01-ERRCD (SPA-GMN-Q01-CUR)
      *
           .
       510-ERRCD-SET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    患者マスター読込（主キー）
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-PTINF
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
      *
           IF  ( MCP-RC                =   ZERO )
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
      *
               PERFORM 910-DB-READ-SEC
      *
               IF  ( MCP-RC            =   ZERO )
                   MOVE    MCPDATA-REC TO  PTINF-REC
               ELSE
                   MOVE    1           TO  FLG-PTINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    住所マスター検索（郵便番号）
      *****************************************************************
       900-ADRS-SELECT-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-ADRS
           MOVE    ADRS-REC            TO  MCPDATA-REC
           MOVE    "ADRS-KEY4"         TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
      *
           IF  ( MCP-RC            NOT =   ZERO )
               MOVE    1               TO  FLG-ADRS
           END-IF
      *
      *
           .
       900-BYOMEI-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    住所マスター読込（郵便番号）
      *****************************************************************
       900-ADRS-READ-SEC               SECTION.
      *
           MOVE    ZERO                TO  FLG-ADRS
           MOVE    "ADRS-KEY4"         TO  ORC-DBPATH
      *
           PERFORM 910-DB-READ-SEC
      *
           IF  ( MCP-RC                =   ZERO )
               MOVE    MCPDATA-REC     TO  ADRS-REC
           ELSE
               MOVE    1               TO  FLG-ADRS
           END-IF
      *
           .
       900-ADRS-READ-EXT.
           EXIT.
      *****************************************************************
      *    住所マスタークローズ（郵便番号）
      *****************************************************************
       900-ADRS-CLOSE-SEC              SECTION.
      *
           MOVE    "ADRS-KEY4"         TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       900-ADRS-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    自院病名マスター検索処理
      *****************************************************************
       900-USERBYOMEI-SELECT-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-USERBYOMEI
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "USERBYOMEI-KEY8"   TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
           IF ( MCP-RC             NOT =   ZERO )
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
           .
      *
       900-USERBYOMEI-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    自院病名マスター読込処理
      *****************************************************************
       900-USERBYOMEI-READ-SEC         SECTION.
      *
           MOVE    "USERBYOMEI-KEY8"   TO  ORC-DBPATH
      *
           PERFORM 910-DB-READ-SEC
           IF  ( MCP-RC        =   ZERO )
               MOVE    MCPDATA-REC     TO  USERBYOMEI-REC
           ELSE
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
           .
      *
       900-USERBYOMEI-READ-EXT.
           EXIT.
      *****************************************************************
      *    自院病名マスタークローズ処理
      *****************************************************************
       900-USERBYOMEI-CLOSE-SEC      SECTION.
      *
           MOVE    "USERBYOMEI-KEY8"   TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       900-USERBYOMEI-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    病名マスター検索（漢字・カナ名）
      *****************************************************************
       900-BYOMEI-SELECT-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-BYOMEI
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "BYOMEI-KEY2"       TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
      *
           IF  ( MCP-RC            NOT =   ZERO )
               MOVE    1               TO  FLG-BYOMEI
           END-IF
      *
      *
           .
       900-BYOMEI-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    病名マスター読込（漢字・カナ名）
      *****************************************************************
       900-BYOMEI-READ-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-BYOMEI
           MOVE    "BYOMEI-KEY2"       TO  ORC-DBPATH
      *
           PERFORM 910-DB-READ-SEC
      *
           IF  ( MCP-RC                =   ZERO )
               MOVE    MCPDATA-REC     TO  BYOMEI-REC
           ELSE
               MOVE    1               TO  FLG-BYOMEI
           END-IF
      *
           .
       900-BYOMEI-READ-EXT.
           EXIT.
      *****************************************************************
      *    病名マスタークローズ（漢字・カナ名）
      *****************************************************************
       900-BYOMEI-CLOSE-SEC            SECTION.
      *
           MOVE    "BYOMEI-KEY2"       TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       900-BYOMEI-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    病名マスター読込（主キー）
      *****************************************************************
       910-BYOMEI-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-BYOMEI
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
      *
           IF  ( MCP-RC                =   ZERO )
               MOVE    "BYOMEI-KEY"    TO  ORC-DBPATH
      *
               PERFORM 910-DB-READ-SEC
      *
               IF  ( MCP-RC            =   ZERO )
                   MOVE    MCPDATA-REC TO  BYOMEI-REC
               ELSE
                   MOVE    1           TO  FLG-BYOMEI
      *
               END-IF
           ELSE
      *
               MOVE    1               TO  FLG-BYOMEI
           END-IF
      *
           MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
      *
           .
       910-BYOMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター検索（漢字・カナ名）
      *****************************************************************
       910-TENSU-SELECT-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "TENSU-KEY2"        TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
      *
           PERFORM 910-DB-SELECT-SEC
      *
           IF  ( MCP-RC            NOT =   ZERO )
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           .
       910-TENSU-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    点数マスター読込（漢字・カナ名）
      *****************************************************************
       910-TENSU-READ-SEC              SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
           MOVE    "TENSU-KEY2"        TO  ORC-DBPATH
      *
           PERFORM 910-DB-READ-SEC
      *
           IF  ( MCP-RC                =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           .
      *
       910-TENSU-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタークローズ（漢字・カナ名）
      *****************************************************************
       910-TENSU-CLOSE-SEC             SECTION.
      *
           MOVE    "TENSU-KEY2"        TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       910-TENSU-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    入力コードマスター読込処理
      *****************************************************************
       910-INPUTCD-READ-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-INPUTCD
           MOVE    INPUTCD-REC         TO  MCPDATA-REC
           MOVE    "INPUTCD-KEY2"      TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
           IF ( MCP-RC             =   ZERO )
               MOVE    "INPUTCD-KEY2"  TO  ORC-DBPATH
      *
               PERFORM 910-DB-READ-SEC
               IF  ( MCP-RC        =   ZERO )
                   MOVE    MCPDATA-REC TO  INPUTCD-REC
               ELSE
                   MOVE    1           TO  FLG-INPUTCD
               END-IF
           ELSE
               MOVE    1               TO  FLG-INPUTCD
           END-IF
      *
           MOVE    "INPUTCD-KEY2"      TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
      *
       910-INPUTCD-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込処理
      *****************************************************************
       910-TENSU-READ-02-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
      *
           PERFORM 910-DB-SELECT-SEC
           IF ( MCP-RC             =   ZERO )
               MOVE    "TENSU-KEY"     TO  ORC-DBPATH
      *
               PERFORM 910-DB-READ-SEC
               IF  ( MCP-RC        =   ZERO )
                   MOVE    MCPDATA-REC TO  TNS-TENSU-REC
               ELSE
                   MOVE    1           TO  FLG-TENSU
               END-IF
           ELSE
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
      *
           PERFORM 910-DB-CLOSE-SEC
      *
           .
      *
       910-TENSU-READ-02-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DB-SELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
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
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                SECTION.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.

