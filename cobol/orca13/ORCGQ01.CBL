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
      * 01.00.03     NACL-太田    02/10/14 +コンパイルエラーチェック
      *                                    |強化対応
      * 01.00.03     NACL-太田    02/10/17 +woody対応
      * 01.00.03     NACL-太田    02/11/27 +病名コードを空白にしたとき、
      *                                    |対応する病名も空白にする
      * 01.00.04     NACL-太田    03/05/26 +老人一割、２割を追加
      * 01.00.05     NACL-太田    02/05/28 +一括入力対応
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
           03  FLG-CHK                             PIC 9(01).
           03  FLG-PTINF                           PIC 9(01).
           03  FLG-ADRS                            PIC 9(01).
           03  FLG-BYOMEI                          PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-INPUTCD                         PIC 9(01).
           03  FLG-USERBYOMEI                      PIC 9(01).
           03  FLG-HKNNUM                          PIC 9(01).
      *
           03  FLG-OK                              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(04).
           03  IDX2                                PIC 9(04).
           03  IDX3                                PIC 9(04).
           03  IDX4                                PIC 9(04).
           03  IDX5                                PIC 9(04).
           03  IDXA                                PIC 9(04).
           03  IDXB                                PIC 9(04).
           03  IDXC                                PIC 9(04).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ADRS                            PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MCP-WIDGET                      PIC X(64).
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
           03  WRK-RDBYOMEI-A-STATE                PIC S9(9)
                                                   BINARY.
           03  WRK-BYOBUNCD                        PIC X(3).
           03  WRK-PTNUM                           PIC X(20).
           03  WRK-PTNUM-WK                        PIC X(20).
           03  WRK-PTNUM-KETA                      PIC 9(05).
           03  WRK-SYS-KETA                        PIC 9(05).
           03  WRK-SYS-KETA2                       PIC 9(05).
           03  WRK-ST                              PIC 9(05).
           03  WRK-IDX                             PIC 9(05).
           03  WRK-ERR-CUR                         PIC 9(05).
           03  WRK-PAGENO                          PIC 9(01).
           03  WRK-JYUSHO-IDX                      PIC 9(03).
      *
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
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
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
           COPY    "Q97.INC".
           COPY    "Q98.INC".
           COPY    "Q99.INC".
           COPY    "Q100.INC".
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
           INITIALIZE                  FLG-AREA
                                       IDX-AREA
                                       CNT-AREA
                                       WRK-AREA
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
       310-Q02SPASET-SEC               SECTION.
      *
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
       310-Q98SPASET-SEC               SECTION.
      *
           IF  ( SPA-Q01-Q98-JYUSHO    NOT =  SPACE )
               MOVE    SPA-Q01-Q98-JYUSHO
                                   TO  SPA-GMN-Q01-JYUSHO
                                           (SPA-Q01-Q98-JYUSHO-IDX)
               MOVE    SPA-Q01-Q98-POST
                                   TO  SPA-GMN-Q01-POST
                                           (SPA-Q01-Q98-JYUSHO-IDX)
               COMPUTE SPA-GMN-Q01-CUR
                                   =   111
                                   + ( SPA-Q01-Q98-JYUSHO-IDX  - 1 ) * 2
                                   +   1
           END-IF
      *
           .
       310-Q98SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｑ９９戻りスパ編集処理
      *****************************************************************
       310-Q99SPASET-SEC               SECTION.
      *
           IF  ( SPA-Q01-Q99-JYUSHO    NOT =  SPACE )
               MOVE    SPA-Q01-Q99-JYUSHO
                                   TO  SPA-GMN-Q01-JYUSHO
                                               (SPA-Q01-Q99-JYUSHO-IDX)
               MOVE    SPA-Q01-Q99-POST
                                   TO  SPA-GMN-Q01-POST
                                               (SPA-Q01-Q99-JYUSHO-IDX)
               COMPUTE SPA-GMN-Q01-CUR
                                   =   111
                                   + ( SPA-Q01-Q99-JYUSHO-IDX  - 1 ) * 2
                                   +   1
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
           MOVE    SPA-SYSYMD          TO  SPA-NAI-Q01-KJYNYMD
      *
      *    テスト患者チェックボックス
           MOVE   "F"                  TO  SPA-GMN-Q01-CHKTSTPT
      *
      *    性別コンボ初期処理
           PERFORM 3101-SEX-CMB-SYOKI-SEC
           MOVE    SPA-GMN-Q01-SEXLST (1)
                                       TO  SPA-GMN-Q01-SEX-G
      *
      *    保険の種類・公費の種類コンボ初期処理
           PERFORM 3101-HKNKOH-CMB-SYOKI-SEC
      *
      *    病名検索コンボ初期処理
           PERFORM 3101-BYOMEI-CMB-SYOKI-SEC
      *
      *    ソートキー項目初期処理
           PERFORM 3101-SORT-KMK-SYOKI-SEC
           MOVE    SPA-GMN-Q01-SORTLST (1)
                                       TO  SPA-GMN-Q01-KMK-G (1)
           MOVE    SPA-GMN-Q01-SORTLST (2)
                                       TO  SPA-GMN-Q01-KMK-G (2)
           MOVE    SPA-GMN-Q01-SORTLST (3)
                                       TO  SPA-GMN-Q01-KMK-G (3)
      *
      *    並び順ラジオボタン初期処理
           PERFORM 3101-RDIO-SYOKI-SEC
      *
      *    カーソルキー制御項目
           MOVE   1                   TO  SPA-GMN-Q01-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    性別コンボ初期処理
      *****************************************************************
       3101-SEX-CMB-SYOKI-SEC          SECTION.
      *
           MOVE    3                   TO  SPA-GMN-Q01-SEXLST-MAX
      *
           PERFORM VARYING IDX5    FROM    1   BY  1
                   UNTIL ( IDX5    >   SPA-GMN-Q01-SEXLST-MAX )
      *
               MOVE    CONST-SEX (IDX5)
                                       TO  SPA-GMN-Q01-SEXLST (IDX5)
      *
           END-PERFORM
	   .
      *
       3101-SEX-CMB-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険の種類・公費の種類コンボ初期処理
      *****************************************************************
       3101-HKNKOH-CMB-SYOKI-SEC       SECTION.
      *
           PERFORM 3101-HKNKOH-CMB-EDIT-SEC
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
      *
           MOVE    SPACE       TO  SPA-GMN-Q01-HKNNUMLST-G
           INITIALIZE              SPA-GMN-Q01-HKNNUMLST-G
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
      *
               IF    ( HKN-HKNKOHSBTKBN    =   "1" OR  "4"
                                           OR  "8" OR  "9" )
                   MOVE    SPA-GMN-Q01-HKNNUMLST-MAX   TO  IDX5
      *            保険
                   IF    ( IDX5            >   ZERO )
                       IF    ( HKN-HKNNUM  
                                   NOT =   SPA-GMN-Q01-HKNNUML (IDX5))
      *                    保険情報編集
                           PERFORM 31011-HKNHEN-SEC
                       END-IF
                   ELSE
      *                保険情報編集
                       PERFORM 31011-HKNHEN-SEC
                   END-IF
      *
               ELSE
      *            公費
                   MOVE    SPA-GMN-Q01-KOHNUMLST-MAX   TO  IDX5
                   IF    ( IDX5            >   ZERO )
                       IF    ( HKN-HKNNUM 
                                       =   SPA-GMN-Q01-KOHNUML (IDX5))
                           IF    ( HKN-HKNNUM   =   "027"  ) 
                             AND ( HKN-PAYKBN   =   "01" OR "02"  )
                               IF ( HKN-PAYKBN
                                    NOT =   SPA-GMN-Q01-PAYKBNL (IDX5))
      *                            公費情報編集
                                   PERFORM 31011-KOHHEN-SEC
                               END-IF
                           END-IF
                       ELSE
      *                    公費情報編集
                           PERFORM 31011-KOHHEN-SEC
                       END-IF
                   ELSE
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
           COMPUTE SPA-GMN-Q01-HKNNUMLST-MAX
               =   SPA-GMN-Q01-HKNNUMLST-MAX   +   1
      *
           MOVE    SPA-GMN-Q01-HKNNUMLST-MAX   TO  IDX5
      *
           MOVE    HKN-HKNNUM          TO  SPA-GMN-Q01-HKNNUML    (IDX5)
           MOVE    HKN-TANSEIDONAME    TO  SPA-GMN-Q01-HKNNUMMEIL (IDX5)
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
           COMPUTE SPA-GMN-Q01-KOHNUMLST-MAX
               =   SPA-GMN-Q01-KOHNUMLST-MAX   +   1
      *
           MOVE    SPA-GMN-Q01-KOHNUMLST-MAX   TO  IDX5
      *
           MOVE    HKN-HKNNUM          TO  SPA-GMN-Q01-KOHNUML (IDX5)
      *
           IF    ( HKN-HKNNUM          =   "027" )
            AND  ( HKN-PAYKBN      NOT =   "01" AND "02" )
               MOVE    "老人保健"      TO  SPA-GMN-Q01-KOHNUMMEIL (IDX5)
           ELSE
               MOVE    HKN-TANSEIDONAME
                                       TO  SPA-GMN-Q01-KOHNUMMEIL (IDX5)
           END-IF
      *
           IF    ( HKN-HKNNUM          =   "027" )
            AND  ( HKN-PAYKBN          =   "01" OR  "02" )
               MOVE    HKN-PAYKBN (2:1)
                                       TO  SPA-GMN-Q01-PAYKBNL (IDX5)
           ELSE
               MOVE    SPACE           TO  SPA-GMN-Q01-PAYKBNL (IDX5)
           END-IF
      *
           .
       31011-KOHHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名検索コンボ初期処理
      *****************************************************************
       3101-BYOMEI-CMB-SYOKI-SEC       SECTION.
      *
           MOVE    "T"             TO  SPA-GMN-Q01-RDBYOMEI-U
           MOVE    "F"             TO  SPA-GMN-Q01-RDBYOMEI-A
           MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-Q01-UBYOMEI-STATE
                                       SPA-GMN-Q01-RDBYOMEI-U-STATE
                                       SPA-GMN-Q01-RDBYOMEI-A-STATE
      *
           MOVE    ZERO            TO  SPA-GMN-Q01-UBYOMEILST-MAX
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
                   MOVE    IDX1    TO  SPA-GMN-Q01-UBYOMEILST-MAX
                   MOVE    USBYO-BYOMEIINPUTCD
                                   TO  SPA-GMN-Q01-UBYOMEIL (IDX1)
                   MOVE    USBYO-BYOMEI
                                   TO  SPA-GMN-Q01-UBYOMEIMEIL (IDX1)
               END-IF
           END-PERFORM
      *
      *    自院病名マスタ−クローズ処理
           PERFORM 31011-USERBYOMEI-CLOSE-SEC
      *
      *    分類コード設定データが存在したかチェック
           IF  ( SPA-GMN-Q01-UBYOMEILST-MAX  =   ZERO )
      *
      *        xxx 存在しなかった場合 xxx
      *        自院病名マスタ−読込処理２（データ存在チェック）
               INITIALIZE              USERBYOMEI-REC
               MOVE    SPA-HOSPID  TO  USBYO-HOSPID
               PERFORM 31012-USERBYOMEI-READ-SEC
      *
      *        分類コードが設定されていないデータが存在したかチェック
               IF  ( FLG-USERBYOMEI    =   ZERO )
                   MOVE    "NON"   TO  SPA-GMN-Q01-UBYOMEIL (1)
                   MOVE    "分類なし"
                                   TO  SPA-GMN-Q01-UBYOMEIMEIL  (1)
                   MOVE    "ALL"   TO  SPA-GMN-Q01-UBYOMEIL (2)
                   MOVE    "すべて"
                                   TO  SPA-GMN-Q01-UBYOMEIMEIL  (2)
                   MOVE    2       TO  SPA-GMN-Q01-UBYOMEILST-MAX
               ELSE
                   MOVE    "F"     TO  SPA-GMN-Q01-RDBYOMEI-U
                   MOVE    "T"     TO  SPA-GMN-Q01-RDBYOMEI-A
                   MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-Q01-UBYOMEI-STATE
                                       SPA-GMN-Q01-RDBYOMEI-U-STATE
                                       SPA-GMN-Q01-RDBYOMEI-A-STATE
               END-IF
           ELSE
      *
      *        xxx 存在した場合 xxx
               MOVE    SPA-GMN-Q01-UBYOMEILST-MAX
                                   TO  IDX1
      *
               COMPUTE IDX1        =   IDX1    +   1
               MOVE    "NON"       TO  SPA-GMN-Q01-UBYOMEIL  (IDX1)
               MOVE    "分類なし"  TO  SPA-GMN-Q01-UBYOMEIMEIL
                                                             (IDX1)
      *
               COMPUTE IDX1        =   IDX1    +   1
               MOVE    "ALL"       TO  SPA-GMN-Q01-UBYOMEIL  (IDX1)
               MOVE    "すべて"    TO  SPA-GMN-Q01-UBYOMEIMEIL
                                                             (IDX1)
      *
               MOVE    IDX1        TO  SPA-GMN-Q01-UBYOMEILST-MAX
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
           MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
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
           MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
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
           MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
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
           MOVE    4                   TO  SPA-GMN-Q01-SORTLST-MAX
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-Q01-SORTLST-MAX )
               MOVE    CONST-KMK-ITEM (IDX1)
                                       TO  SPA-GMN-Q01-SORTLST (IDX1)
           END-PERFORM
      *
           .
       3101-SORT-KMK-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    並び順ラジオボタン初期処理
      *****************************************************************
       3101-RDIO-SYOKI-SEC             SECTION.
      *
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
       3101-RDIO-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                         SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"           ALSO    "B01"
               PERFORM 210-BACK
      *    条件クリア
           WHEN    "CLICKED"           ALSO    "B02"
               PERFORM 480-CLEAR-SEC
      *    予約登録へ
      * xx     WHEN    "CLICKED"       ALSO    "B10"
      * xx         PERFORM 480-YOYAKU-SEC
      *    受付一覧へ
      * xx     WHEN    "CLICKED"       ALSO    "B11"
      * xx         PERFORM 490-UKEICHI-SEC
      *    タブ切替
           WHEN    "CLICKED"           ALSO    "B08"
               PERFORM 480-TABSWITCH-SEC
      *    検索
           WHEN    "CLICKED"           ALSO    "B12"
               PERFORM 490-KENSAKU-SEC
      *    テスト患者チェックボタン
           WHEN    "CLICKED"           ALSO    "CHKTSTPT"
               PERFORM 410-CHKTSTPT-SET-SEC
      *    住所ボタン
           WHEN    "CLICKED"           ALSO    "JYUSHOBT1"
           WHEN    "CLICKED"           ALSO    "JYUSHOBT2"
           WHEN    "CLICKED"           ALSO    "JYUSHOBT3"
           WHEN    "CLICKED"           ALSO    "JYUSHOBT4"
           WHEN    "CLICKED"           ALSO    "JYUSHOBT5"
               MOVE    MCP-WIDGET   TO  WRK-WIDGET
               PERFORM 410-JYUSHO-SET-SEC
      *    病名コード編集
           WHEN    "CLICKED"           ALSO    "BYOBT1"
           WHEN    "CLICKED"           ALSO    "BYOBT2"
           WHEN    "CLICKED"           ALSO    "BYOBT3"
           WHEN    "CLICKED"           ALSO    "BYOBT4"
           WHEN    "CLICKED"           ALSO    "BYOBT5"
               MOVE    MCP-WIDGET   TO  WRK-WIDGET
               PERFORM 420-BYOMEICD-SET-SEC
      *    診療行為コード編集
           WHEN    "CLICKED"           ALSO    "SRYBT1"
           WHEN    "CLICKED"           ALSO    "SRYBT2"
           WHEN    "CLICKED"           ALSO    "SRYBT3"
           WHEN    "CLICKED"           ALSO    "SRYBT4"
           WHEN    "CLICKED"           ALSO    "SRYBT5"
               MOVE    MCP-WIDGET   TO  WRK-WIDGET
               PERFORM 430-SRYCD-SET-SEC
      *    病名検索トグルボタン
           WHEN    "CLICKED"           ALSO    "RDBYOMEI_U"
      *
      *        画面ＳＰＡ編集処理
               PERFORM 4101-GMN-SPA-SET-SEC
      *
               MOVE    WIDGET-NORMAL
                                    TO  SPA-GMN-Q01-UBYOMEI-STATE
               MOVE    "T"          TO  SPA-GMN-Q01-RDBYOMEI-U
               MOVE    "F"          TO  SPA-GMN-Q01-RDBYOMEI-A
           WHEN    "CLICKED"       ALSO    "RDBYOMEI_A"
      *
      *        画面ＳＰＡ編集処理
               PERFORM 4101-GMN-SPA-SET-SEC
      *
               MOVE    WIDGET-INSENSITIVE
                                    TO  SPA-GMN-Q01-UBYOMEI-STATE
               MOVE    SPACE        TO  SPA-GMN-Q01-UBYOMEI-G
               MOVE    "F"          TO  SPA-GMN-Q01-RDBYOMEI-U
               MOVE    "T"          TO  SPA-GMN-Q01-RDBYOMEI-A
               IF  ( SPA-GMN-Q01-CUR   =   301 )
                       MOVE    302  TO  SPA-GMN-Q01-CUR
               END-IF
      *    並び順トグルボタン
           WHEN    "CLICKED"       ALSO    "RDIO11"
           WHEN    "CLICKED"       ALSO    "RDIO12"
           WHEN    "CLICKED"       ALSO    "RDIO21"
           WHEN    "CLICKED"       ALSO    "RDIO22"
           WHEN    "CLICKED"       ALSO    "RDIO31"
           WHEN    "CLICKED"       ALSO    "RDIO32"
               PERFORM 450-RDIO-SET-SEC
      *    タブ
           WHEN    "CLICKED"       ALSO    "N01"
           WHEN    "CLICKED"       ALSO    "N02"
           WHEN    "CLICKED"       ALSO    "N03"
           WHEN    "CLICKED"       ALSO    "N04"
               MOVE    MCP-WIDGET   TO  WRK-WIDGET
      *
               PERFORM 440-TAB-CHANGE-SEC
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
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *
      *    病名分類区分チェック処理
           WHEN    "ACTIVATE"      ALSO    "BYOBUN"
               PERFORM 4118-BYOBUN-CHK-SEC
      *
      *    病名リスト選択チェック
           WHEN    "ACTIVATE"      ALSO    "BYOMEISEL"
               PERFORM 4118-BYOMEISEL-CHK-SEC
      *
      *    病名診療行為リスト選択チェック
           WHEN    "ACTIVATE"      ALSO   "SRYACTSEL"
               PERFORM 4120-SRYACTSEL-CHK-SEC
      *
           WHEN    OTHER
      *
      *        入力個所のセット
               PERFORM 400-GMN-INPUT-SEC
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
      *
           END-EVALUATE
      *
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       400-GMN-INPUT-SEC           SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-Q01-CUR
      *
           .
      *
       400-GMN-INPUT-EXT.
           EXIT.
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC           SECTION.
      *
      *    画面をＳＰＡにセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    開始診療年月チェック
           PERFORM 4100-STSRYYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
      *    終了診療年月チェック
           PERFORM 4101-EDSRYYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
           EVALUATE    SPA-GMN-Q01-PAGENO
      *    基本情報タブ
           WHEN    ZERO
               PERFORM 4101-KHN-INPUT-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
      *    保険　公費タブ
           WHEN    1
               PERFORM 4101-HKN-INPUT-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
      *    病名　診療行為タブ
           WHEN    2
               PERFORM 4101-BYOSRY-INPUT-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
      *    並び順タブ
           WHEN    3
               PERFORM 4101-SRT-INPUT-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
           END-EVALUATE
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC        SECTION.
      *
      *    開始診療年月日
           MOVE    Q01-STSRYYMD            TO  SPA-GMN-Q01-STSRYYMD
      *    終了診療年月日
           MOVE    Q01-EDSRYYMD            TO  SPA-GMN-Q01-EDSRYYMD
      *    開始生年月日
           MOVE    Q01-STBIRTHDAY          TO  SPA-GMN-Q01-STBIRTHDAY
      *    終了生年月日
           MOVE    Q01-EDBIRTHDAY          TO  SPA-GMN-Q01-EDBIRTHDAY
      *    開始年齢
           MOVE    Q01-STAGE               TO  SPA-GMN-Q01-STAGE
      *    終了年齢
           MOVE    Q01-EDAGE               TO  SPA-GMN-Q01-EDAGE
      *    基準日
           MOVE    Q01-KJYNYMD             TO  SPA-GMN-Q01-KJYNYMD
      *    性別
           MOVE    Q01-SEX                 TO  SPA-GMN-Q01-SEX-G
      *    開始最終受診日
           MOVE    Q01-STLASTYMD           TO  SPA-GMN-Q01-STLASTYMD
      *    終了最終受診日
           MOVE    Q01-EDLASTYMD           TO  SPA-GMN-Q01-EDLASTYMD
      *    開始患者番号
           MOVE    Q01-STPTNUM             TO  SPA-GMN-Q01-STPTNUM
      *    終了患者番号
           MOVE    Q01-EDPTNUM             TO  SPA-GMN-Q01-EDPTNUM
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL   IDXB    >       5
      *        郵便番号
               MOVE    Q01-POST    (IDXB)
                                       TO  SPA-GMN-Q01-POST   (IDXB)
      *        住所
               MOVE    Q01-JYUSHO  (IDXB)
                                       TO  SPA-GMN-Q01-JYUSHO  (IDXB)
      *        カナ氏名
               MOVE    Q01-KANANAME(IDXB)
                                       TO  SPA-GMN-Q01-KANANAME(IDXB)
      *        氏名
               MOVE    Q01-NAME    (IDXB)
                                       TO  SPA-GMN-Q01-NAME    (IDXB)
           END-PERFORM
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL   IDXB    >       3
      *
      *        コメント
               MOVE    Q01-COMMENT (IDXB)
                                       TO  SPA-GMN-Q01-COMMENT  (IDXB)
           END-PERFORM
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL   IDXB    >       5
      *
      *        保険者番号
               MOVE    Q01-HKNJANUM(IDXB)
                                       TO  SPA-GMN-Q01-HKNJANUM (IDXB)
      *        保険の種類
               MOVE    Q01-HKNNUM  (IDXB)
                                       TO  SPA-GMN-Q01-HKNNUM-G (IDXB)
      *        記号
               MOVE    Q01-KIGO    (IDXB)
                                       TO  SPA-GMN-Q01-KIGO     (IDXB)
      *
      *        番号
               MOVE    Q01-NUM     (IDXB)
                                       TO  SPA-GMN-Q01-NUM      (IDXB)
      *
      *        公費の種類
               MOVE    Q01-KOHNUM  (IDXB)
                                       TO  SPA-GMN-Q01-KOHNUM-G (IDXB)
      *
      *        負担者番号
               MOVE    Q01-FTNJANUM(IDXB)
                                       TO  SPA-GMN-Q01-FTNJANUM (IDXB)
      *
      *
           END-PERFORM
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL   IDXB    >       5
      *        病名コード
               MOVE    Q01-BYOMEICD(IDXB)
                                       TO  SPA-GMN-Q01-BYOMEICD(IDXB)
      *        病名
               MOVE    Q01-BYOMEI  (IDXB)
                                       TO  SPA-GMN-Q01-BYOMEI  (IDXB)
      *        診療行為コード
               MOVE    Q01-SRYCD(IDXB)
                                       TO  SPA-GMN-Q01-SRYCD(IDXB)
           END-PERFORM
      *
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL   IDXB    >       3
      *
      *       並び順
              MOVE    Q01-CMB-KMK (IDXB)
                                       TO  SPA-GMN-Q01-KMK-G (IDXB)
      *
           END-PERFORM
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    基本情報タブ入力チェック処理
      *****************************************************************
       4101-KHN-INPUT-CHK-SEC          SECTION.
      *
      *    開始生年月日チェック
           PERFORM 4102-STBIRTHDAY-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    終了生年月日チェック
           PERFORM 4103-EDBIRTHDAY-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    開始年齢チェック
           PERFORM 4104-STAGE-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    終了年齢チェック
           PERFORM 4105-EDAGE-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    終了年齢チェック
           PERFORM 4105-EDAGE-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    基準日チェック
           PERFORM 4106-KJYNYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    性別チェック
           PERFORM 4107-SEX-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    開始最終受診日チェック
           PERFORM 4108-STLASTYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    終了最終受診日チェック
           PERFORM 4108-EDLASTYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    開始患者番号チェック
           PERFORM 4109-STPTNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    終了患者番号チェック
           PERFORM 4109-EDPTNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4101-KHN-INPUT-CHK-EXT
           END-IF
      *
      *    郵便番号チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               PERFORM 4110-POST-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                 OR  ( FLG-END     NOT =   ZERO  )
                   GO  TO  4101-KHN-INPUT-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
      *    住所チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               PERFORM 4110-JYUSHO-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-KHN-INPUT-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
      *    カナ氏名チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               PERFORM 4111-KANANAME-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-KHN-INPUT-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
      *    漢字氏名チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               PERFORM 4112-NAME-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-KHN-INPUT-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
      *    コメントチェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   3 )
      *
               PERFORM 4113-COMMENT-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-KHN-INPUT-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
           .
       4101-KHN-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険　公費タブ入力チェック処理
      *****************************************************************
       4101-HKN-INPUT-CHK-SEC          SECTION.
      *
      *    保険者番号チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
               PERFORM 4114-HKNJANUM-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-HKN-INPUT-CHK-EXT
               END-IF
           END-PERFORM
      *
      *    保険の種類チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
               PERFORM 4114-HKNNUM-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-HKN-INPUT-CHK-EXT
               END-IF
           END-PERFORM
      *
      *    記号チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
               PERFORM 4114-KIGO-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-HKN-INPUT-CHK-EXT
               END-IF
           END-PERFORM
      *
      *    番号チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
               PERFORM 4115-NUM-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-HKN-INPUT-CHK-EXT
               END-IF
           END-PERFORM
      *
      *    公費の種類チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
               PERFORM 4116-KOHNUM-CHK-SEC  
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-HKN-INPUT-CHK-EXT
               END-IF
           END-PERFORM
      *
      *    負担者番号チェック処理
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
               PERFORM 4117-FTNJANUM-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-HKN-INPUT-CHK-EXT
               END-IF
           END-PERFORM
      *
           .
       4101-HKN-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病名　診療行為タブ入力チェック処理
      *****************************************************************
       4101-BYOSRY-INPUT-CHK-SEC       SECTION.
      *
      *    病名コードチェック処理
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               PERFORM 4119-BYOMEICD-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-BYOSRY-INPUT-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
      *    病名チェック処理
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               PERFORM 4119-BYOMEI-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-BYOSRY-INPUT-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
      *    診療行為コードチェック処理
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   5 )
      *
               PERFORM 4121-SRYCD-CHK-SEC    
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-BYOSRY-INPUT-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
           .
       4101-BYOSRY-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    並び順タブ入力チェック処理
      *****************************************************************
       4101-SRT-INPUT-CHK-SEC          SECTION.
      *
      *    並び順項目名チェック処理
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   3 )
      *
               PERFORM 4122-KMK-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4101-SRT-INPUT-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
           .
       4101-SRT-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    開始診療年月チェック
      *****************************************************************
       4100-STSRYYMD-CHK-SEC       SECTION.
      *
           MOVE    SPACE               TO  SPA-NAI-Q01-STSRYYMD
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-STSRYYMD  NOT =   SPACE )
               MOVE    SPA-GMN-Q01-STSRYYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-NAI-Q01-STSRYYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-STSRYYMD
               ELSE
                   MOVE    "0101"      TO  SPA-ERRCD
                   MOVE    1           TO  SPA-GMN-Q01-CUR
                   GO  TO  4100-STSRYYMD-CHK-EXT
               END-IF
           END-IF
      *
           .
       4100-STSRYYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    終了診療年月チェック
      *****************************************************************
       4101-EDSRYYMD-CHK-SEC       SECTION.
      *
           MOVE    SPACE               TO  SPA-NAI-Q01-EDSRYYMD
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-EDSRYYMD  NOT =   SPACE )
               MOVE    SPA-GMN-Q01-EDSRYYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD     =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-NAI-Q01-EDSRYYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-EDSRYYMD
               ELSE
                   MOVE    "0101"      TO  SPA-ERRCD
                   MOVE    2           TO  SPA-GMN-Q01-CUR
                   GO  TO  4101-EDSRYYMD-CHK-EXT
               END-IF
           END-IF
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
           MOVE    SPACE               TO  SPA-NAI-Q01-STBIRTHDAY
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-STBIRTHDAY    NOT =   SPACE )
               MOVE    SPA-GMN-Q01-STBIRTHDAY
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD        TO  SPA-NAI-Q01-STBIRTHDAY
                   MOVE    WRK-HENYMDG     TO  SPA-GMN-Q01-STBIRTHDAY
               ELSE
                   MOVE    "0102"          TO  SPA-ERRCD
                   MOVE    101             TO  SPA-GMN-Q01-CUR
                   GO  TO  4102-STBIRTHDAY-CHK-EXT
               END-IF
           END-IF
      *
           .
       4102-STBIRTHDAY-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了生年月日チェック
      *****************************************************************
       4103-EDBIRTHDAY-CHK-SEC     SECTION.
      *
           MOVE    SPACE               TO  SPA-NAI-Q01-EDBIRTHDAY
      *
           MOVE    Q01-EDBIRTHDAY      TO  SPA-GMN-Q01-EDBIRTHDAY
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-EDBIRTHDAY    NOT =   SPACE )
               MOVE    SPA-GMN-Q01-EDBIRTHDAY
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD     =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-NAI-Q01-EDBIRTHDAY
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-EDBIRTHDAY
               ELSE
                   MOVE    "0102"          TO  SPA-ERRCD
                   MOVE    102             TO  SPA-GMN-Q01-CUR
                   GO  TO  4103-EDBIRTHDAY-CHK-EXT
               END-IF
           END-IF
      *
      *
           .
       4103-EDBIRTHDAY-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始年齢チェック
      *****************************************************************
       4104-STAGE-CHK-SEC          SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI-Q01-STAGE
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
                   MOVE    "0103"          TO  SPA-ERRCD
                   MOVE    103             TO  SPA-GMN-Q01-CUR
                   GO  TO  4104-STAGE-CHK-EXT
               ELSE
                   MOVE    SNUM-OUTNUM TO  SPA-NAI-Q01-STAGE
               END-IF
           END-IF
      *
           .
       4104-STAGE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了年齢チェック
      *****************************************************************
       4105-EDAGE-CHK-SEC          SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI-Q01-EDAGE
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
                   MOVE    "0103"          TO  SPA-ERRCD
                   MOVE    104             TO  SPA-GMN-Q01-CUR
                   GO  TO  4105-EDAGE-CHK-EXT
               ELSE
                   MOVE    SNUM-OUTNUM TO  SPA-NAI-Q01-EDAGE
               END-IF
           END-IF
      *
           .
       4105-EDAGE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    基準日チェック
      *****************************************************************
       4106-KJYNYMD-CHK-SEC        SECTION.
      *
      *
           MOVE    SPACE               TO  SPA-NAI-Q01-KJYNYMD
      *
      *    基準日未入力は、システム日付をセット
           IF  ( SPA-GMN-Q01-KJYNYMD   =   SPACE )
               MOVE    SPA-SYSYMDWH    TO  SPA-GMN-Q01-KJYNYMD
               MOVE    SPA-SYSYMD      TO  SPA-NAI-Q01-KJYNYMD
      *
           ELSE
      *        日付妥当性チェック＆編集処理
               MOVE    SPA-GMN-Q01-KJYNYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-NAI-Q01-KJYNYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-KJYNYMD
               ELSE
                   MOVE    "0104"          TO  SPA-ERRCD
                   MOVE    105             TO  SPA-GMN-Q01-CUR
                   GO  TO  4106-KJYNYMD-CHK-EXT
               END-IF
           END-IF
      *
           .
       4106-KJYNYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    性別チェック
      *****************************************************************
       4107-SEX-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-Q01-SEX-G   =   SPACE )
               GO  TO  4107-SEX-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   SPA-GMN-Q01-SEXLST-MAX )
               IF    ( SPA-GMN-Q01-SEX =   SPA-GMN-Q01-SEXL (IDX2))
                   MOVE    1           TO  FLG-CHK
                   MOVE    SPA-GMN-Q01-SEXLST-MAX
                                       TO  IDX2
               END-IF
           END-PERFORM
      *
           IF    ( FLG-CHK         =   ZERO )
               MOVE    "0109"          TO  SPA-ERRCD
               MOVE    106             TO  SPA-GMN-Q01-CUR
               GO TO   4107-SEX-CHK-EXT
           END-IF
      *
           .
       4107-SEX-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始最終受診日チェック
      *****************************************************************
       4108-STLASTYMD-CHK-SEC      SECTION.
      *
           MOVE    SPACE               TO  SPA-NAI-Q01-STLASTYMD
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-STLASTYMD NOT =   SPACE )
               MOVE    SPA-GMN-Q01-STLASTYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-NAI-Q01-STLASTYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-STLASTYMD
               ELSE    
                   MOVE    "0105"          TO  SPA-ERRCD
                   MOVE    107             TO  SPA-GMN-Q01-CUR
                   GO  TO  4108-STLASTYMD-CHK-EXT
               END-IF
           END-IF
      *
           .
       4108-STLASTYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了最終受診日チェック
      *****************************************************************
       4108-EDLASTYMD-CHK-SEC      SECTION.
      *
           MOVE    SPACE               TO  SPA-NAI-Q01-EDLASTYMD
      *
      *    日付妥当性チェック＆編集処理
           IF  ( SPA-GMN-Q01-EDLASTYMD NOT =   SPACE )
               MOVE    SPA-GMN-Q01-EDLASTYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF  ( SPA-ERRCD         =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-NAI-Q01-EDLASTYMD
                   MOVE    WRK-HENYMDG TO  SPA-GMN-Q01-EDLASTYMD
               ELSE    
                   MOVE    "0105"          TO  SPA-ERRCD
                   MOVE    108             TO  SPA-GMN-Q01-CUR
                   GO  TO  4108-EDLASTYMD-CHK-EXT
               END-IF
           END-IF
      *
           .
       4108-EDLASTYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始患者番号チェック処理
      *****************************************************************
       4109-STPTNUM-CHK-SEC            SECTION.
      *
           IF  ( SPA-GMN-Q01-STPTNUM   =   SPACE )
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
               MOVE    109             TO  SPA-GMN-Q01-CUR
               GO  TO                  4109-STPTNUM-CHK-EXT
           END-IF
      *
           MOVE    WRK-PTNUM           TO   SPA-GMN-Q01-STPTNUM
      *
           .
       4109-STPTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了患者番号チェック処理
      *****************************************************************
       4109-EDPTNUM-CHK-SEC            SECTION.
      *
           IF  ( SPA-GMN-Q01-EDPTNUM   =   SPACE )
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
               MOVE    110             TO  SPA-GMN-Q01-CUR
               GO  TO                  4109-EDPTNUM-CHK-EXT
           END-IF
      *
           MOVE    WRK-PTNUM           TO   SPA-GMN-Q01-EDPTNUM
      *
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
               MOVE    "0106"          TO  SPA-ERRCD
           END-IF
      *
           MOVE    WRK-PTNUM-WK        TO  WRK-PTNUM
      *
           .
       41091-KETA-CNT-CHK2-EXT.
           EXIT.
      *
      *****************************************************************
      *    郵便番号チェック処理
      *****************************************************************
       4110-POST-CHK-SEC           SECTION.
      *
           MOVE    IDXA                TO  IDX1
      *
           MOVE    WRK-MCP-WIDGET      TO  WRK-WIDGET
      *
           IF  ( SPA-GMN-Q01-POST(IDX1)   =   SPACE )
               GO  TO  4110-POST-CHK-EXT
           END-IF
      *
           IF    ( WRK-WIDGET     (1:4) =  "POST" )
            AND  ( WRK-WIDGET4          =  IDX1 )
               CONTINUE
           ELSE
               GO  TO  4110-POST-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-Q01-POST (IDX1) (1:1)   =   "/" )
      *
      *        周辺住所検索画面に遷移する
               MOVE    IDX1            TO  WRK-JYUSHO-IDX
               PERFORM 410-Q98-SENI-SEC
               GO  TO  4110-POST-CHK-EXT
           END-IF
      *
      *    住所エリアを初期化
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
               MOVE    WRK-EDITADRS-NAME
                                   TO  SPA-GMN-Q01-JYUSHO  (IDX1)
      *
      *    複数件該当
           WHEN    OTHER
      *
               PERFORM 5011-INPUT-CUR-SEC
      *
      *        住所検索−町域選択画面に遷移する
               MOVE  IDX1          TO  SPA-Q01-Q99-JYUSHO-IDX
               MOVE  SPA-GMN-Q01-POST (IDX1)
                                   TO  SPA-Q01-Q99-POST
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
           .
       4110-POST-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    住所チェック処理
      *****************************************************************
       4110-JYUSHO-CHK-SEC         SECTION.
      *
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
           MOVE    IDXA            TO  IDX1
      *
      *    全角変換処理
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE    SPA-GMN-Q01-KANANAME(IDX1)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  SPA-GMN-Q01-KANANAME(IDX1)
           END-IF
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
           MOVE    IDXA            TO  IDX1
      *
      *    全角変換処理
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE    SPA-GMN-Q01-NAME(IDX1)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  SPA-GMN-Q01-NAME(IDX1)
           END-IF
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
      *
           .
       4113-COMMENT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号チェック処理
      *****************************************************************
       4114-HKNJANUM-CHK-SEC           SECTION.
      *
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
           MOVE    IDXA                TO  IDX1
      *
           COMPUTE WRK-ERR-CUR         =   205 +   IDX1
      *
           IF    ( SPA-GMN-Q01-HKNNUM-G (IDX1) =   SPACE )
               GO  TO  4114-HKNNUM-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   SPA-GMN-Q01-HKNNUMLST-MAX )
               IF    ( SPA-GMN-Q01-HKNNUM (IDX1)
                                       =   SPA-GMN-Q01-HKNNUML (IDX2))
                   MOVE    1           TO  FLG-CHK
                   MOVE    SPA-GMN-Q01-HKNNUMLST-MAX
                                       TO  IDX2
               END-IF
           END-PERFORM
      *
           IF    ( FLG-CHK         =   ZERO )
               MOVE    "0110"          TO  SPA-ERRCD
               MOVE    WRK-ERR-CUR     TO  SPA-GMN-Q01-CUR
               GO TO   4114-HKNNUM-CHK-EXT
           END-IF
      *
      *
           .
       4114-HKNNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    記号チェック処理
      *****************************************************************
       4114-KIGO-CHK-SEC        SECTION.
      *
           MOVE    IDXA            TO  IDX1
      *
      *    全角変換処理
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE    SPA-GMN-Q01-KIGO(IDX1)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  SPA-GMN-Q01-KIGO(IDX1)
           END-IF
      *
           .
       4114-KIGO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号チェック処理
      *****************************************************************
       4115-NUM-CHK-SEC        SECTION.
      *
           MOVE    IDXA            TO  IDX1
      *
      *    全角変換処理
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE    SPA-GMN-Q01-NUM (IDX1)
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  SPA-GMN-Q01-NUM (IDX1)
           END-IF
      *
           .
       4115-NUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費保険番号チェック処理
      *****************************************************************
       4116-KOHNUM-CHK-SEC        SECTION.
      *
           MOVE    IDXA                TO  IDX1
      *
           COMPUTE WRK-ERR-CUR         =   220 +   IDX1
      *
           IF    ( SPA-GMN-Q01-KOHNUM-G (IDX1) =   SPACE )
               GO  TO  4116-KOHNUM-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   SPA-GMN-Q01-KOHNUMLST-MAX )
               IF    ( SPA-GMN-Q01-KOHNUM (IDX1)
                                       =   SPA-GMN-Q01-KOHNUML (IDX2))
                   MOVE    1           TO  FLG-CHK
                   MOVE    SPA-GMN-Q01-KOHNUMLST-MAX
                                       TO  IDX2
               END-IF
           END-PERFORM
      *
           IF    ( FLG-CHK         =   ZERO )
               MOVE    "0111"          TO  SPA-ERRCD
               MOVE    WRK-ERR-CUR     TO  SPA-GMN-Q01-CUR
               GO TO   4116-KOHNUM-CHK-EXT
           END-IF
      *
           .
       4116-KOHNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費負担者番号チェック処理
      *****************************************************************
       4117-FTNJANUM-CHK-SEC        SECTION.
      *
      *
           .
       4117-FTNJANUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名分類区分チェック処理
      *****************************************************************
       4118-BYOBUN-CHK-SEC             SECTION.
      *
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    301                 TO  SPA-GMN-Q01-CUR
      *
           MOVE    Q01-BYOBUN          TO  SPA-GMN-Q01-UBYOMEI-G
      *
           IF  ( SPA-GMN-Q01-UBYOMEI   =   SPACE )
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
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE   302                  TO  SPA-GMN-Q01-CUR
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
               UNTIL     ( IDX2    >   SPA-GMN-Q01-UBYOMEILST-MAX )
      *
               IF  ( SPA-GMN-Q01-UBYOMEI
                                   =   SPA-GMN-Q01-UBYOMEIL (IDX2))
                   MOVE    IDX2        TO  WRK-IDX
                   MOVE    100         TO  IDX2
               END-IF
                   
           END-PERFORM
      *
           IF  ( WRK-IDX           =   ZERO )
               MOVE    "ALL"           TO  WRK-BYOBUNCD
           ELSE
               MOVE    SPA-GMN-Q01-UBYOMEIL (WRK-IDX)
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
           MOVE    IDXA                TO  IDX1
      *
           MOVE    WRK-MCP-WIDGET      TO  WRK-WIDGET
      *
           COMPUTE WRK-ERR-CUR         =   303
                                       + ( IDX1 - 1 ) * 2
      *
           IF    ( WRK-WIDGET (1 : 8)  =   "BYOMEICD" )
            AND  ( WRK-WIDGET8         =   IDX1 )
               CONTINUE
           ELSE
               GO  TO  4119-BYOMEICD-CHK-EXT
           END-IF
      *
           IF  ( SPA-GMN-Q01-BYOMEICD (IDX1)   =   SPACE )
               MOVE    SPACE           TO  SPA-GMN-Q01-BYOMEI  (IDX1)
               MOVE    SPACE           TO  SPA-NAI-Q01-BYOMEI-OLD 
                                                               (IDX1)
               GO  TO  4119-BYOMEICD-CHK-EXT
           END-IF
      *
      *
      *    自院病名マスタ−検索条件編集処理
           PERFORM 4121-USERBYOMEI-SEL-EDIT-SEC
           IF  ( SPA-ERRCD         NOT =   SPACE )
               MOVE    WRK-ERR-CUR     TO  SPA-GMN-Q01-CUR
               GO  TO  4119-BYOMEICD-CHK-EXT
           END-IF
      *
           IF  ( WRK-MOJI              =   ZERO )
               GO  TO  4119-BYOMEICD-CHK-EXT
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
               MOVE    USBYO-BYOMEI
                                   TO  SPA-GMN-Q01-BYOMEI (IDX1)
                                       SPA-NAI-Q01-BYOMEI-OLD
                                                          (IDX1)
           ELSE
               IF  ( WRK-MOJI      =   7 )
                   INITIALIZE              BYOMEI-REC
                   MOVE    SPA-GMN-Q01-BYOMEICD (IDX1)
                                   TO  BYO-BYOMEICD
                   PERFORM 910-BYOMEI-READ-SEC
                   IF  ( FLG-BYOMEI    NOT =   ZERO )
                       MOVE    "0004"      TO  SPA-ERRCD
                       MOVE    WRK-ERR-CUR TO  SPA-GMN-Q01-CUR
                       GO  TO  4119-BYOMEICD-CHK-EXT
                   END-IF
      *
                   MOVE    BYO-BYOMEI
                                   TO  SPA-GMN-Q01-BYOMEI (IDX1)
                                       SPA-NAI-Q01-BYOMEI-OLD (IDX1)
               ELSE
                   MOVE    "0004"      TO  SPA-ERRCD
                   MOVE    WRK-ERR-CUR TO  SPA-GMN-Q01-CUR
                   GO  TO  4119-BYOMEICD-CHK-EXT
               END-IF
           END-IF
      *
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
               MOVE    "0107"          TO  SPA-ERRCD
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
               MOVE    "0107"          TO  SPA-ERRCD
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
      *****************************************************************
      *    病名チェック処理
      *****************************************************************
       4119-BYOMEI-CHK-SEC             SECTION.
      *
           MOVE    IDXA                TO  IDX1
      *
           COMPUTE WRK-ERR-CUR         =   304
                                       + ( IDX1 - 1 ) * 2
      *
           MOVE    WRK-MCP-WIDGET      TO  WRK-WIDGET
      *
           IF    ( SPA-GMN-Q01-BYOMEI (IDX1)
                                       =   SPACE )
            OR   ( SPA-GMN-Q01-BYOMEI (IDX1)
                                       =   SPA-NAI-Q01-BYOMEI-OLD(IDX1))
      *
               IF    ( WRK-WIDGET (1 : 6)
                                           =   "BYOMEI" )
                AND  ( WRK-WIDGET6         =   IDX1 )
                   IF    ( SPA-GMN-Q01-BYOMEI (IDX1)   =   SPACE )
                       MOVE    SPACE   TO  SPA-GMN-Q01-BYOMEICD  (IDX1)
                                           SPA-GMN-Q01-BYOMEI    (IDX1)
                                           SPA-NAI-Q01-BYOMEI-OLD(IDX1)
                   END-IF
               END-IF
      *
               GO  TO  4119-BYOMEI-CHK-EXT
           END-IF
      *
           MOVE    SPACE               TO  SPA-GMN-Q01-BYOMEICD (IDX1)
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
               MOVE    WRK-ERR-CUR     TO  SPA-GMN-Q01-CUR
               GO  TO  4119-BYOMEI-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-Q01-BYOMEI (IDX1)
                                       TO  SPA-NAI-Q01-BYOMEI-OLD (IDX1)
      *
           .
       4119-BYOMEI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療行為名チェック処理
      *****************************************************************
       4120-SRYACTSEL-CHK-SEC        SECTION.
      *
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    313                 TO  SPA-GMN-Q01-CUR
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
           MOVE    IDXA                TO  IDX1
      *
           COMPUTE WRK-ERR-CUR         =   313
                                       +   IDX1
      *
           MOVE    SPACE               TO  SPA-NAI-Q01-SRYCD (IDX1)
           MOVE    SPACE               TO  SPA-GMN-Q01-SRYACT (IDX1)
      *
      *    セットコードでの入力はエラーとする。
           IF  ( SPA-GMN-Q01-SRYCD (IDX1) (1:1)   =   "P"  OR  "S" )
               MOVE    "0007"          TO  SPA-ERRCD
               GO  TO  4121-SRYCD-CHK-EXT
           END-IF
      *
      *    入力コードマスタ−検索条件編集処理
           PERFORM 4121-INPUTCD-SELECT-EDIT-SEC
           IF  ( SPA-ERRCD         NOT =   SPACE )
               GO  TO  4121-SRYCD-CHK-EXT
           END-IF
      *
           IF  ( WRK-MOJI              =   ZERO )
               GO  TO  4121-SRYCD-CHK-EXT
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
               INITIALIZE      TNS-TENSU-REC
               MOVE   ICD-SRYCD
                                   TO  TNS-SRYCD
      *
               MOVE   SPA-SYSYMD
                                   TO  ORC-DBYMD
      *        点数マスタ−読み込み処理
               PERFORM 910-TENSU-READ-02-SEC
               IF  ( FLG-TENSU     =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    "0005"  TO  SPA-ERRCD
                   GO  TO  4121-SRYCD-CHK-EXT
               END-IF
           ELSE
               IF  ( WRK-MOJI      =   9 )
      *
                   INITIALIZE      TNS-TENSU-REC
                   MOVE   WRK-SRYCD    TO  TNS-SRYCD
      *
                   MOVE   SPA-SYSYMD   TO  ORC-DBYMD
      *            点数マスタ−読み込み処理
                   PERFORM 910-TENSU-READ-02-SEC
                   IF  ( FLG-TENSU     =   ZERO )
                       CONTINUE
                   ELSE
                       MOVE    "0005"  TO  SPA-ERRCD
                       GO  TO  4121-SRYCD-CHK-EXT
                   END-IF
               ELSE
                   MOVE    "0005"  TO  SPA-ERRCD
                   GO  TO  4121-SRYCD-CHK-EXT
               END-IF
           END-IF
      *
           MOVE    TNS-SRYCD           TO  SPA-NAI-Q01-SRYCD  (IDX1)
           MOVE    TNS-NAME            TO  SPA-GMN-Q01-SRYACT (IDX1)
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
               MOVE    "0108"          TO  SPA-ERRCD
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
               MOVE    "0108"          TO  SPA-ERRCD
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
           MOVE    IDXA                TO  IDX1
      *
           COMPUTE WRK-ERR-CUR     =   400
                                   +   IDX1
      *
      *    必ず指定されていること。
           IF  ( SPA-GMN-Q01-KMK-G (IDX1)  NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    WRK-ERR-CUR     TO  SPA-GMN-Q01-CUR
               MOVE    "0008"  TO  SPA-ERRCD
               GO  TO  4122-KMK-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   SPA-GMN-Q01-SORTLST-MAX )
               IF    ( SPA-GMN-Q01-KMK (IDX1)
                                       =   SPA-GMN-Q01-SORTL (IDX2))
                   MOVE    1           TO  FLG-CHK
                   MOVE    SPA-GMN-Q01-SORTLST-MAX
                                       TO  IDX2
               END-IF
           END-PERFORM
      *
           IF    ( FLG-CHK         =   ZERO )
               MOVE    "0112"          TO  SPA-ERRCD
               MOVE    WRK-ERR-CUR     TO  SPA-GMN-Q01-CUR
               GO TO   4122-KMK-CHK-EXT
           END-IF
      *
           .
       4122-KMK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    テスト患者チェックボタン編集処理
      *****************************************************************
       410-CHKTSTPT-SET-SEC              SECTION.
      *
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
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
      *****************************************************************
      *    住所編集処理
      *****************************************************************
       410-JYUSHO-SET-SEC              SECTION.
      *
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET8     TO  IDX1
      *
      *    周辺住所検索画面に遷移する
           MOVE    IDX1            TO  WRK-JYUSHO-IDX
           PERFORM 410-Q98-SENI-SEC
      *
           .
       410-JYUSHO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    周辺住所検索画面遷移処理
      *****************************************************************
       410-Q98-SENI-SEC                SECTION.
      *
           PERFORM 5011-INPUT-CUR-SEC
      *
      *    周辺住所検索画面に遷移する
           MOVE    WRK-JYUSHO-IDX  TO  SPA-Q01-Q98-JYUSHO-IDX
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
       410-Q98-SENI-EXT.
           EXIT.
      *****************************************************************
      *    病名コード編集処理
      *****************************************************************
       420-BYOMEICD-SET-SEC            SECTION.
      *
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET5     TO  IDX1
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >       200 )
               IF  ( Q01-BYOLST-SELECT (IDX2)  =   "T" )
      *
                   MOVE    SPA-GMN-Q01-TBYOMEICD (IDX2)
                                   TO  SPA-GMN-Q01-BYOMEICD (IDX1)
                   MOVE    SPA-GMN-Q01-TBYOMEI (IDX2)
                                   TO  SPA-GMN-Q01-BYOMEI (IDX1)
                                       SPA-NAI-Q01-BYOMEI-OLD (IDX1)
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
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET5     TO  IDX1
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >       200 )
               IF  ( Q01-SRYLST-SELECT (IDX2)  =   "T" )
                   MOVE    SPA-GMN-Q01-TSRYCD (IDX2)
                                           TO  SPA-GMN-Q01-SRYCD (IDX1)
                                               SPA-NAI-Q01-SRYCD (IDX1)
                   MOVE    SPA-GMN-Q01-TSRYACT (IDX2)
                                           TO  SPA-GMN-Q01-SRYACT(IDX1)
                   MOVE    200             TO  IDX2
               END-IF
           END-PERFORM
      *
           .
       430-SRYCD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    タブ編集処理
      *****************************************************************
       440-TAB-CHANGE-SEC              SECTION.
      *
           MOVE    WRK-WIDGET2         TO  WRK-PAGENO
      *
           COMPUTE WRK-PAGENO  =   WRK-PAGENO  -   1
      *
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           EVALUATE    SPA-GMN-Q01-PAGENO
           WHEN    0
               PERFORM 4101-KHN-INPUT-CHK-SEC
           WHEN    1
               PERFORM 4101-HKN-INPUT-CHK-SEC
           WHEN    2
               PERFORM 4101-BYOSRY-INPUT-CHK-SEC
           WHEN    3
               PERFORM 4101-SRT-INPUT-CHK-SEC
           END-EVALUATE
      *
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  440-TAB-CHANGE-EXT
           END-IF
      *
           PERFORM 4900-KANRENCHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  440-TAB-CHANGE-EXT
           END-IF
      *
           MOVE    WRK-PAGENO          TO  SPA-GMN-Q01-PAGENO
      *
           EVALUATE    WRK-PAGENO
           WHEN    0
                   MOVE    101         TO  SPA-GMN-Q01-CUR
           WHEN    1
                   MOVE    201         TO  SPA-GMN-Q01-CUR
           WHEN    2
                   MOVE    301         TO  SPA-GMN-Q01-CUR
           WHEN    3
                   MOVE    401         TO  SPA-GMN-Q01-CUR
           END-EVALUATE
      *
           .
       440-TAB-CHANGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    並び順ラジオボタン設定処理
      *****************************************************************
       450-RDIO-SET-SEC                SECTION.
      *
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "RDIO11"
               MOVE    "T"         TO  SPA-GMN-Q01-RDIO1 (1)
               MOVE    "F"         TO  SPA-GMN-Q01-RDIO2 (1)
           WHEN    "RDIO12"
               MOVE    "F"         TO  SPA-GMN-Q01-RDIO1 (1)
               MOVE    "T"         TO  SPA-GMN-Q01-RDIO2 (1)
           WHEN    "RDIO21"
               MOVE    "T"         TO  SPA-GMN-Q01-RDIO1 (2)
               MOVE    "F"         TO  SPA-GMN-Q01-RDIO2 (2)
           WHEN    "RDIO22"
               MOVE    "F"         TO  SPA-GMN-Q01-RDIO1 (2)
               MOVE    "T"         TO  SPA-GMN-Q01-RDIO2 (2)
           WHEN    "RDIO31"
               MOVE    "T"         TO  SPA-GMN-Q01-RDIO1 (3)
               MOVE    "F"         TO  SPA-GMN-Q01-RDIO2 (3)
           WHEN    "RDIO32"
               MOVE    "F"         TO  SPA-GMN-Q01-RDIO1 (3)
               MOVE    "T"         TO  SPA-GMN-Q01-RDIO2 (3)
           END-EVALUATE
      *
           .
       450-RDIO-SET-EXT.
           EXIT.
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
           MOVE        SPACE       TO  SPA-GMN-Q01-STSRYYMD
                                       SPA-GMN-Q01-EDSRYYMD
           MOVE        SPACE       TO  SPA-NAI-Q01-STSRYYMD
                                       SPA-NAI-Q01-EDSRYYMD
      *
           EVALUATE    SPA-GMN-Q01-PAGENO
      *
      *    基本情報
           WHEN    0
               MOVE    101         TO  SPA-GMN-Q01-CUR
      *
               INITIALIZE              SPA-GMN-Q01-KIHON-AREA
                                       SPA-NAI-Q01-KIHON-AREA
      *
      *        基準日開始日和暦
               MOVE    SPA-SYSYMDWH
                                   TO  SPA-GMN-Q01-KJYNYMD
      *        基準日開始日西暦
               MOVE    SPA-SYSYMD  TO  SPA-NAI-Q01-KJYNYMD
      *
      *        性別コンボ
               MOVE    SPA-GMN-Q01-SEXLST (1)
                                   TO  SPA-GMN-Q01-SEX-G
               MOVE    "F"         TO  SPA-GMN-Q01-CHKTSTPT
      *
      *    保険　公費
           WHEN    1
               MOVE    201         TO  SPA-GMN-Q01-CUR
      *
      *
               INITIALIZE              SPA-GMN-Q01-HOKEN-AREA
                                       SPA-NAI-Q01-HOKEN-AREA
      *
      *    病名　診療行為
           WHEN    2
               IF ( SPA-GMN-Q01-UBYOMEI-STATE
                                       =   WIDGET-NORMAL )
                   MOVE    301         TO  SPA-GMN-Q01-CUR
               ELSE
                   MOVE    302         TO  SPA-GMN-Q01-CUR
               END-IF
      *
               MOVE    SPA-GMN-Q01-RDBYOMEI-A-STATE
                                       TO  WRK-RDBYOMEI-A-STATE
      *
               INITIALIZE                  SPA-GMN-Q01-BYOMEI-AREA
                                           SPA-NAI-Q01-BYOMEI-AREA
      *
      *
               IF  ( WRK-RDBYOMEI-A-STATE
                                   =   WIDGET-NORMAL )
                   MOVE    "T"         TO  SPA-GMN-Q01-RDBYOMEI-U
                   MOVE    "F"         TO  SPA-GMN-Q01-RDBYOMEI-A
                   MOVE    WIDGET-NORMAL
                                       TO  SPA-GMN-Q01-UBYOMEI-STATE
                                           SPA-GMN-Q01-RDBYOMEI-U-STATE
                                           SPA-GMN-Q01-RDBYOMEI-A-STATE
      *
               ELSE
                   MOVE    "F"         TO  SPA-GMN-Q01-RDBYOMEI-U
                   MOVE    "T"         TO  SPA-GMN-Q01-RDBYOMEI-A
                   MOVE    WIDGET-INSENSITIVE
                                       TO  SPA-GMN-Q01-UBYOMEI-STATE
                                           SPA-GMN-Q01-RDBYOMEI-U-STATE
                                           SPA-GMN-Q01-RDBYOMEI-A-STATE
               END-IF
      *
      *    並び順
           WHEN    3
               MOVE    401             TO  SPA-GMN-Q01-CUR
      *
               INITIALIZE                  SPA-GMN-Q01-NARABI-AREA
                                           SPA-NAI-Q01-NARABI-AREA
               MOVE    SPA-GMN-Q01-SORTLST (1)
                                       TO  SPA-GMN-Q01-KMK-G (1)
               MOVE    SPA-GMN-Q01-SORTLST (2)
                                       TO  SPA-GMN-Q01-KMK-G (2)
               MOVE    SPA-GMN-Q01-SORTLST (3)
                                       TO  SPA-GMN-Q01-KMK-G (3)
               PERFORM 3101-RDIO-SYOKI-SEC
      *
           END-EVALUATE
      *
           .
       480-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    タブ切替処理
      *****************************************************************
       480-TABSWITCH-SEC           SECTION.
      *
           EVALUATE    SPA-GMN-Q01-PAGENO
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
           PERFORM 440-TAB-CHANGE-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  480-TABSWITCH-EXT
           END-IF
      *
           .
       480-TABSWITCH-EXT.
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
      *    画面ＳＰＡ編集処理
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    開始診療年月基本チェック
           PERFORM 4100-STSRYYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    終了診療年月基本チェック
           PERFORM 4101-EDSRYYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    診療年月日関連チェック
           PERFORM 4900-SRYYMDCHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    -- 基本 --
      *    基本チェック
           PERFORM 4101-KHN-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    ZERO        TO  SPA-GMN-Q01-PAGENO
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    関連チェック
           PERFORM 4901-TAB1-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    ZERO        TO  SPA-GMN-Q01-PAGENO
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    -- 保険　公費 --
      *    基本チェック
           PERFORM 4101-HKN-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    1           TO  SPA-GMN-Q01-PAGENO
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    関連チェック
           PERFORM 4901-TAB2-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    1           TO  SPA-GMN-Q01-PAGENO
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    -- 病名　診療行為 --
      *    基本チェック
           PERFORM 4101-BYOSRY-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    2           TO  SPA-GMN-Q01-PAGENO
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    関連チェック
           PERFORM 4901-TAB3-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    2           TO  SPA-GMN-Q01-PAGENO
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    -- 並び順 --
      *    基本チェック
           PERFORM 4101-SRT-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    3           TO  SPA-GMN-Q01-PAGENO
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    関連チェック
           PERFORM 4901-TAB4-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               MOVE    3           TO  SPA-GMN-Q01-PAGENO
               GO  TO  490-KENSAKU-EXT
           END-IF
      *
      *    遷移情報ＳＰＡ編集処理
           PERFORM 4901-SPASET-SEC
      *
      *    検索該当項目情報設定処理
           PERFORM 4901-GAITOINF-SET-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
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
      *    1.開始診療年月日≠空白かつ
      *      終了診療年月日≠空白のとき、
      *      開始診療年月日≦終了診療年月日であること
           IF      ( SPA-NAI-Q01-STSRYYMD  NOT =   SPACE )
            AND    ( SPA-NAI-Q01-EDSRYYMD  NOT =   SPACE )
               IF  ( SPA-NAI-Q01-STSRYYMD     <=   SPA-NAI-Q01-EDSRYYMD)
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
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRCD
      *
           EVALUATE    SPA-GMN-Q01-PAGENO
               WHEN    0
                   PERFORM 4901-TAB1-CHK-SEC
               WHEN    1
                   PERFORM 4901-TAB2-CHK-SEC
               WHEN    2
                   PERFORM 4901-TAB3-CHK-SEC
               WHEN    3
                   PERFORM 4901-TAB4-CHK-SEC
           END-EVALUATE    
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       基本情報タブの関連チェック処理
      *****************************************************************
       4901-TAB1-CHK-SEC           SECTION.
      *
      *    ＜患者番号＞
      *    1.開始患者番号≠空白かつ
      *      終了患者番号≠空白かつのとき、
      *      開始患者番号≦終了患者番号であること
           IF      ( SPA-GMN-Q01-STPTNUM   NOT =   SPACE )
            AND    ( SPA-GMN-Q01-EDPTNUM   NOT =   SPACE )
               IF  ( SPA-GMN-Q01-STPTNUM      <=  SPA-GMN-Q01-EDPTNUM )
                   CONTINUE
               ELSE
                   MOVE    "1006"      TO   SPA-ERRCD
                   MOVE    109         TO   SPA-GMN-Q01-CUR
                   GO  TO  4901-TAB1-CHK-EXT
               END-IF
           END-IF
      *
      *    ＜生年月日＞
      *    1.開始生年月日≠空白かつ
      *      終了生年月日≠空白のとき、
      *      開始生年月日≦終了生年月日であること
           IF      ( SPA-GMN-Q01-STBIRTHDAY
                                       NOT =   SPACE  )
            AND    ( SPA-GMN-Q01-EDBIRTHDAY
                                       NOT =   SPACE  )
               IF  ( SPA-NAI-Q01-STBIRTHDAY
                                          <=  SPA-NAI-Q01-EDBIRTHDAY )
                   CONTINUE
               ELSE
                   MOVE    "1002"      TO   SPA-ERRCD
                   MOVE    101         TO   SPA-GMN-Q01-CUR
                   GO  TO  4901-TAB1-CHK-EXT
               END-IF
           END-IF
      *
      *    ＜年齢＞
      *    1.開始年齢≠空白かつ
      *      終了年齢≠空白のとき、
      *      開始年齢≦終了年齢であること
           IF      ( SPA-GMN-Q01-STAGE NOT =   SPACE )
            AND    ( SPA-GMN-Q01-EDAGE NOT =   SPACE )
               IF  ( SPA-NAI-Q01-STAGE    <=   SPA-NAI-Q01-EDAGE )
                   CONTINUE
               ELSE
                   MOVE    "1003"      TO   SPA-ERRCD
                   MOVE    103         TO   SPA-GMN-Q01-CUR
                   GO  TO  4901-TAB1-CHK-EXT
               END-IF
           END-IF
      *
      *
      *    ＜生年月日・年齢＞
      *    1.開始生年月日≠空白または
      *      終了生年月日≠空白のとき、
      *      開始年齢＝空白かつ
      *      終了年齢＝空白であること。
           IF  ( SPA-GMN-Q01-STBIRTHDAY    NOT =   SPACE )
            OR ( SPA-GMN-Q01-EDBIRTHDAY    NOT =   SPACE )
               IF      ( SPA-GMN-Q01-STAGE =   SPACE )
                AND    ( SPA-GMN-Q01-EDAGE =   SPACE )
                   CONTINUE
               ELSE
                   MOVE    "1004"      TO  SPA-ERRCD
                   MOVE    101         TO  SPA-GMN-Q01-CUR
                   GO  TO  4901-TAB1-CHK-EXT
               END-IF
           END-IF
      *
      *    ＜年齢・基準日＞
      *    1.開始年齢≠空白または
      *      終了年齢≠空白のとき、
      *      基準日≠空白であること
           IF  ( SPA-GMN-Q01-STAGE         NOT =   SPACE )
            OR ( SPA-GMN-Q01-EDAGE         NOT =   SPACE )
               IF  ( SPA-GMN-Q01-KJYNYMD   NOT =   SPACE )
                   CONTINUE
               ELSE
                   MOVE    "1005"      TO  SPA-ERRCD
                   MOVE    105         TO  SPA-GMN-Q01-CUR
                   GO  TO  4901-TAB1-CHK-EXT
               END-IF
           END-IF
      *
      *    ＜最終受診日＞
      *    1.開始最終受診日≠空白かつ
      *      終了最終受診日≠空白のとき、
      *      開始最終受診日≦最終受診日終了日であること
           IF      ( SPA-GMN-Q01-STLASTYMD NOT =   SPACE )
            AND    ( SPA-GMN-Q01-EDLASTYMD NOT =   SPACE )
               IF  ( SPA-NAI-Q01-STLASTYMD    <=  SPA-NAI-Q01-EDLASTYMD)
                   CONTINUE
               ELSE
                   MOVE    "1008"      TO   SPA-ERRCD
                   MOVE    107         TO   SPA-GMN-Q01-CUR
                   GO  TO  4901-TAB1-CHK-EXT
               END-IF
           END-IF
      *
           .
       4901-TAB1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       遷移情報ＳＰＡ編集処理
      *****************************************************************
       4901-SPASET-SEC             SECTION.
      *
           INITIALIZE              SPA-Q01-Q02-SENI-AREA
      *
      *    診療年月日
           MOVE    SPA-NAI-Q01-STSRYYMD    TO  SPA-Q01-STSRYYMD
           MOVE    SPA-NAI-Q01-EDSRYYMD    TO  SPA-Q01-EDSRYYMD
      *
      *    基本情報
           MOVE    SPA-NAI-Q01-STBIRTHDAY  TO  SPA-Q01-STBIRTHDAY
           MOVE    SPA-NAI-Q01-EDBIRTHDAY  TO  SPA-Q01-EDBIRTHDAY
      *
      *    年齢が入力のとき、生年月日を計算  
      *    ex.2003.04.01現在で１〜２歳の子供が対象の場合、
      *       2000.04.02〜2002.04.01の間の生年月日の子供が対象と
      *       なるように換算する
           IF  (   SPA-GMN-Q01-STAGE   NOT =   SPACE )
      *
               INITIALIZE                  STS-AREA-DAY
               INITIALIZE                  LNK-DAY6-AREA
               MOVE    "61"                TO  LNK-DAY6-IRAI
               MOVE    SPA-NAI-Q01-KJYNYMD TO  LNK-DAY6-KIJUN
               MOVE    "3"                 TO  LNK-DAY6-ZOGENPTN
               COMPUTE LNK-DAY6-ZOGEN  =   SPA-NAI-Q01-STAGE
                                       *   -1
               CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN     TO  SPA-Q01-EDBIRTHDAY
      *
           END-IF
      *
           IF  (   SPA-GMN-Q01-EDAGE   NOT =   SPACE )
      *
               INITIALIZE                  STS-AREA-DAY
               INITIALIZE                  LNK-DAY6-AREA
               MOVE    "61"                TO  LNK-DAY6-IRAI
               MOVE    SPA-NAI-Q01-KJYNYMD TO  LNK-DAY6-KIJUN
               MOVE    "3"                 TO  LNK-DAY6-ZOGENPTN
               COMPUTE LNK-DAY6-ZOGEN  = ( SPA-NAI-Q01-EDAGE   +   1 )
                                       *   -1
               CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN     TO  WRK-YMD
      *
               INITIALIZE                  STS-AREA-DAY
               INITIALIZE                  LNK-DAY6-AREA
               MOVE    "61"                TO  LNK-DAY6-IRAI
               MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
               MOVE    "1"                 TO  LNK-DAY6-ZOGENPTN
               MOVE     1                  TO  LNK-DAY6-ZOGEN
               CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN     TO  SPA-Q01-STBIRTHDAY
           END-IF
      *
           IF    ( SPA-GMN-Q01-STAGE       =   SPACE )
            AND  ( SPA-GMN-Q01-EDAGE       =   SPACE )
               MOVE    ZERO                TO  SPA-Q01-AGE-CALC-KBN
           ELSE
               MOVE    1                   TO  SPA-Q01-AGE-CALC-KBN
           END-IF
      *
           MOVE    SPA-NAI-Q01-KJYNYMD     TO  SPA-Q01-KJYNYMD
           MOVE    SPA-GMN-Q01-SEX         TO  SPA-Q01-SEX
           MOVE    SPA-NAI-Q01-STLASTYMD   TO  SPA-Q01-STLASTYMD
           MOVE    SPA-NAI-Q01-EDLASTYMD   TO  SPA-Q01-EDLASTYMD
           MOVE    SPA-GMN-Q01-STPTNUM     TO  SPA-Q01-STPTNUM
           MOVE    SPA-GMN-Q01-EDPTNUM     TO  SPA-Q01-EDPTNUM
           MOVE    SPA-GMN-Q01-CHKTSTPT    TO  SPA-Q01-CHKTSTPT
      *
           PERFORM VARYING IDXC    FROM    1   BY  1
                   UNTIL ( IDXC    >   5 )
      *
               MOVE    SPA-GMN-Q01-JYUSHO  (IDXC)
                                           TO  SPA-Q01-JYUSHO  (IDXC)
               MOVE    SPA-GMN-Q01-KANANAME(IDXC) 
                                           TO  SPA-Q01-KANANAME(IDXC)
               MOVE    SPA-GMN-Q01-NAME    (IDXC)
                                           TO  SPA-Q01-NAME    (IDXC)
      *
           END-PERFORM
      *
           PERFORM VARYING IDXC    FROM    1   BY  1
                   UNTIL ( IDXC    >   3 )
      *
               MOVE    SPA-GMN-Q01-COMMENT (IDXC)
                                           TO  SPA-Q01-COMMENT (IDXC)
           END-PERFORM
      *
      *    保険　公費
           PERFORM VARYING IDXC    FROM    1   BY  1
                   UNTIL ( IDXC    >   5 )
      *
               MOVE    SPA-GMN-Q01-HKNJANUM(IDXC)
                                           TO  SPA-Q01-HKNJANUM(IDXC)
               MOVE    SPA-GMN-Q01-HKNNUM  (IDXC)
                                           TO  SPA-Q01-HKNNUM  (IDXC)
               MOVE    SPA-GMN-Q01-KIGO    (IDXC)
                                           TO  SPA-Q01-KIGO    (IDXC)
               MOVE    SPA-GMN-Q01-NUM     (IDXC)
                                           TO  SPA-Q01-NUM     (IDXC)
               MOVE    SPA-GMN-Q01-KOHNUM  (IDXC)
                                           TO  SPA-Q01-KOHNUM  (IDXC)
      *
               EVALUATE    SPA-GMN-Q01-PAYKBN  (IDXC)
               WHEN    "1"
                   MOVE    "01"            TO  SPA-Q01-PAYKBN  (IDXC)
               WHEN    "2"
                   MOVE    "02"            TO  SPA-Q01-PAYKBN  (IDXC)
               WHEN    OTHER
                   MOVE    SPACE           TO  SPA-Q01-PAYKBN  (IDXC)
               END-EVALUATE
      *
               MOVE    SPA-GMN-Q01-FTNJANUM(IDXC)
                                           TO  SPA-Q01-FTNJANUM(IDXC)
      *
           END-PERFORM
      *
      *    病名　診療行為
           PERFORM VARYING IDXC    FROM    1   BY  1
                   UNTIL ( IDXC    >   5 )
               MOVE    SPA-GMN-Q01-BYOMEI(IDXC)
                                           TO  SPA-Q01-BYOMEI(IDXC)
               MOVE    SPA-NAI-Q01-SRYCD (IDXC)
                                           TO  SPA-Q01-SRYCD (IDXC)
           END-PERFORM
      *
      *    並び順
           PERFORM VARYING IDXC    FROM    1   BY  1
                   UNTIL ( IDXC    >   3 )
      *
               MOVE    SPA-GMN-Q01-KMK   (IDXC)
                                           TO  SPA-Q01-KMK (IDXC)
      *
               IF  ( SPA-GMN-Q01-RDIO1 (IDXC)  =   "T" )
                   MOVE    1               TO  SPA-Q01-NARABE (IDXC)
               ELSE
                   MOVE    2               TO  SPA-Q01-NARABE (IDXC)
               END-IF
      *
           END-PERFORM
      *
           .
       4901-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *       検索該当項目情報設定処理
      *****************************************************************
       4901-GAITOINF-SET-SEC           SECTION.
      *
           MOVE    SPACE                   TO  SPA-Q01-GAITO-TBL
      *
      *    該当（１）
           IF  ( SPA-Q01-STPTNUM           NOT =   SPACE )
            OR ( SPA-Q01-EDPTNUM           NOT =   SPACE )
               MOVE    "1"                 TO  SPA-Q01-GTBL(1)
      *
           END-IF
      *
      *    該当（２）
           IF  ( SPA-Q01-KANANAME-G        NOT =   SPACE )
            OR ( SPA-Q01-NAME-G            NOT =   SPACE )
      *
               MOVE    "1"                 TO  SPA-Q01-GTBL(2)
      *
           END-IF
      *
      *    該当（３）
           IF  ( SPA-Q01-STLASTYMD         NOT =   SPACE )
            OR ( SPA-Q01-EDLASTYMD         NOT =   SPACE )
               MOVE    "1"                 TO  SPA-Q01-GTBL(3)
           END-IF
      *
      *    該当（４）
           IF  ( SPA-Q01-BYOMEICD-G        NOT =   SPACE )
      *
               MOVE    "1"                 TO  SPA-Q01-GTBL(4)
      *
           END-IF
      *
      *
      *    該当（５）
           IF  ( SPA-Q01-HKNJANUM-G        NOT =   SPACE )
            OR ( SPA-Q01-HKNNUM-G          NOT =   SPACE )
            OR ( SPA-Q01-KIGO-G            NOT =   SPACE )
            OR ( SPA-Q01-NUM-G             NOT =   SPACE )
      *
              MOVE     "1"                 TO  SPA-Q01-GTBL(5)
      *
           END-IF
      *
      *    該当（６）
           IF  ( SPA-Q01-KOHNUM-G          NOT =   SPACE )
            OR ( SPA-Q01-FTNJANUM-G        NOT =   SPACE )
      *
              MOVE     "1"                 TO  SPA-Q01-GTBL(6)
      *
           END-IF
      *
      *    該当（７）
           IF  ( SPA-Q01-JYUSHO-G          NOT =   SPACE )
            OR ( SPA-Q01-COMMENT-G         NOT =   SPACE )
            OR ( SPA-Q01-STBIRTHDAY        NOT =   SPACE )
            OR ( SPA-Q01-EDBIRTHDAY        NOT =   SPACE )
            OR ( SPA-Q01-SEX               NOT =   SPACE )
      *
               MOVE    "1"                 TO  SPA-Q01-GTBL(7)
      *
           END-IF
      *
      *    該当（８）
           IF  ( SPA-Q01-STSRYYMD          NOT =   SPACE  )
            OR ( SPA-Q01-EDSRYYMD          NOT =   SPACE  )
      *
               MOVE    "1"                 TO  SPA-Q01-GTBL(8)
      *
           END-IF
      *
      *    該当（９）
           IF  ( SPA-Q01-SRYCD-G           NOT =   SPACE )
      *
              MOVE     "1"                 TO  SPA-Q01-GTBL(9)
      *
           END-IF
      *
      *    検索条件が未入力のとき
           IF  ( SPA-Q01-GAITO-TBL         =   SPACE )
               MOVE    "1007"              TO  SPA-ERRCD
               GO  TO  4901-GAITOINF-SET-EXT
           END-IF
      *
           .
       4901-GAITOINF-SET-EXT.
           EXIT.
      *****************************************************************
      *       保険・公費情報タブの関連チェック処理
      *****************************************************************
       4901-TAB2-CHK-SEC               SECTION.
      *
           .
       4901-TAB2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       病名・診療行為情報タブの関連チェック処理
      *****************************************************************
       4901-TAB3-CHK-SEC               SECTION.
      *
           .
       4901-TAB3-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       並び順情報タブの関連チェック処理
      *****************************************************************
       4901-TAB4-CHK-SEC               SECTION.
      *
           .
       4901-TAB4-CHK-EXT.
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
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
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
           MOVE    SPA-GMN-Q01-SEX-G       TO  Q01-SEX
      *
           MOVE    SPA-GMN-Q01-SEXLST-MAX  TO  Q01-SEX-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       SPA-GMN-Q01-SEXLST-MAX
               MOVE    SPA-GMN-Q01-SEXLST (IDX1)
                                           TO  Q01-SEX-ITEM (IDX1)
           END-PERFORM
      *
      *    開始最終受診日
           MOVE    SPA-GMN-Q01-STLASTYMD   TO  Q01-STLASTYMD
      *    終了最終受診日
           MOVE    SPA-GMN-Q01-EDLASTYMD   TO  Q01-EDLASTYMD
      *    開始患者番号
           MOVE    SPA-GMN-Q01-STPTNUM     TO  Q01-STPTNUM
      *    終了患者番号
           MOVE    SPA-GMN-Q01-EDPTNUM     TO  Q01-EDPTNUM
      *    テスト患者チェックボタン
           MOVE    SPA-GMN-Q01-CHKTSTPT    TO  Q01-CHKTSTPT
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       5
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
      *        保険者番号
               MOVE    SPA-GMN-Q01-HKNJANUM(IDX1)
                                           TO  Q01-HKNJANUM(IDX1)
      *        保険の種類
               MOVE    SPA-GMN-Q01-HKNNUM-G  (IDX1)
                                           TO  Q01-HKNNUM  (IDX1)
      *        保険記号
               MOVE    SPA-GMN-Q01-KIGO    (IDX1)
                                           TO  Q01-KIGO    (IDX1)
      *
      *        保険番号
               MOVE    SPA-GMN-Q01-NUM     (IDX1)
                                           TO  Q01-NUM     (IDX1)
      *
      *        公費保険番号
               MOVE    SPA-GMN-Q01-KOHNUM-G  (IDX1)
                                           TO  Q01-KOHNUM  (IDX1)
      *
      *        公費負担者番号
               MOVE    SPA-GMN-Q01-FTNJANUM(IDX1)
                                           TO  Q01-FTNJANUM(IDX1)
               MOVE    SPA-GMN-Q01-HKNNUMLST-MAX
                                           TO  Q01-CMB-HKNNUM-COUNT
                                                           (IDX1)
      *
               PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   SPA-GMN-Q01-HKNNUMLST-MAX )
      *
                   MOVE    SPA-GMN-Q01-HKNNUMLST (IDX2)
                               TO  Q01-CMB-HKNNUM-ITEM (IDX1 IDX2)
      *
               END-PERFORM
      *
               MOVE    SPA-GMN-Q01-KOHNUMLST-MAX
                                           TO  Q01-CMB-KOHNUM-COUNT
                                                           (IDX1)
      *
      *
               PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   SPA-GMN-Q01-KOHNUMLST-MAX )
      *
                   MOVE    SPA-GMN-Q01-KOHNUMLST (IDX2)
                               TO  Q01-CMB-KOHNUM-ITEM (IDX1 IDX2)
      *
               END-PERFORM
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
           MOVE    SPA-GMN-Q01-UBYOMEI-G   TO  Q01-BYOBUN
           MOVE    SPA-GMN-Q01-UBYOMEI-STATE
                                           TO  Q01-BYOBUN-STATE
                                               Q01-CMB-BYOBUN-STATE
           MOVE    SPA-GMN-Q01-UBYOMEILST-MAX
                                           TO  Q01-CMB-BYOBUN-COUNT
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-Q01-UBYOMEILST-MAX )
               MOVE    SPA-GMN-Q01-UBYOMEILST (IDX1)
                                           TO  Q01-CMB-BYOBUN-ITEM
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
      *        病名
               MOVE    SPA-GMN-Q01-BYOMEI  (IDX1)
                                           TO  Q01-BYOMEI  (IDX1)
      *        診療行為コード
               MOVE    SPA-GMN-Q01-SRYCD   (IDX1)
                                           TO  Q01-SRYCD(IDX1)
      *        診療行為
               MOVE    SPA-GMN-Q01-SRYACT  (IDX1)
                                           TO  Q01-SRYACT(IDX1)
           END-PERFORM
      *
      *    病名リスト内件数
           MOVE    SPA-GMN-Q01-BYOMEI-MAX  TO  Q01-BYOLST-COUNT
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
      *    行為名検索
           MOVE    SPA-GMN-Q01-SRYACTSEL   TO  Q01-SRYACTSEL
      *
      *    行為名リスト内件数
           MOVE    SPA-GMN-Q01-SRYACT-MAX  TO  Q01-SRYLST-COUNT
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
      *    並び順
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       3
      *
               MOVE    SPA-GMN-Q01-KMK-G (IDX1)
                                           TO  Q01-CMB-KMK (IDX1)
      *
               MOVE   SPA-GMN-Q01-SORTLST-MAX
                                           TO  Q01-CMB-KMK-COUNT (IDX1)
      *
      *        並び順コンボ
               PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL   IDX2    >       SPA-GMN-Q01-SORTLST-MAX
                   MOVE    SPA-GMN-Q01-SORTLST(IDX2)
                                           TO  Q01-CMB-KMK-ITEM
                                                        (IDX1, IDX2)
               END-PERFORM
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
           IF    ( SPA-ERRCD           =   SPACE)
             AND ( SPA-GMN-Q01-CUR     =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
      *
               PERFORM 5011-INPUT-CUR-NEXT-SEC
      *
           END-IF
      *
           PERFORM 5012-CUR-SKIP-SEC
      *
           EVALUATE    SPA-GMN-Q01-CUR
      *
      *    診療年月日
           WHEN   001
               MOVE  "STSRYYMD"    TO  MCP-WIDGET
           WHEN   002
               MOVE  "EDSRYYMD"    TO  MCP-WIDGET
      *
      *    基本情報タブ
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
               MOVE  "STLASTYMD"   TO  MCP-WIDGET
           WHEN   108
               MOVE  "EDLASTYMD"   TO  MCP-WIDGET
           WHEN   109
               MOVE  "STPTNUM"     TO  MCP-WIDGET
           WHEN   110
               MOVE  "EDPTNUM"     TO  MCP-WIDGET
           WHEN   111
               MOVE  "POST1"       TO  MCP-WIDGET
           WHEN   112
               MOVE  "JYUSHO1"     TO  MCP-WIDGET
           WHEN   113
               MOVE  "POST2"       TO  MCP-WIDGET
           WHEN   114
               MOVE  "JYUSHO2"     TO  MCP-WIDGET
           WHEN   115
               MOVE  "POST3"       TO  MCP-WIDGET
           WHEN   116
               MOVE  "JYUSHO3"     TO  MCP-WIDGET
           WHEN   117
               MOVE  "POST4"       TO  MCP-WIDGET
           WHEN   118
               MOVE  "JYUSHO4"     TO  MCP-WIDGET
           WHEN   119
               MOVE  "POST5"       TO  MCP-WIDGET
           WHEN   120
               MOVE  "JYUSHO5"     TO  MCP-WIDGET
           WHEN   121
               MOVE  "KANANAME1"   TO  MCP-WIDGET
           WHEN   122
               MOVE  "KANANAME2"   TO  MCP-WIDGET
           WHEN   123
               MOVE  "KANANAME3"   TO  MCP-WIDGET
           WHEN   124
               MOVE  "KANANAME4"   TO  MCP-WIDGET
           WHEN   125
               MOVE  "KANANAME5"   TO  MCP-WIDGET
           WHEN   126
               MOVE  "NAME1"       TO  MCP-WIDGET
           WHEN   127
               MOVE  "NAME2"       TO  MCP-WIDGET
           WHEN   128
               MOVE  "NAME3"       TO  MCP-WIDGET
           WHEN   129
               MOVE  "NAME4"       TO  MCP-WIDGET
           WHEN   130
               MOVE  "NAME5"       TO  MCP-WIDGET
           WHEN   131
               MOVE  "COMMENT1"    TO  MCP-WIDGET
           WHEN   132
               MOVE  "COMMENT2"    TO  MCP-WIDGET
           WHEN   133
               MOVE  "COMMENT3"    TO  MCP-WIDGET
      *
      *    保険・公費タブ
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
      *
      *    病名・診療行為タブ
           WHEN   301
               MOVE  "BYOBUN"      TO  MCP-WIDGET
           WHEN   302
               MOVE  "BYOMEISEL"   TO  MCP-WIDGET
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
      *
      *    並び順タブ
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
      *    入力個所のセット処理
      *****************************************************************
       5011-INPUT-CUR-SEC          SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
      *
      *    診療年月日
           WHEN   "STSRYYMD"
               MOVE  001           TO  SPA-GMN-Q01-CUR
           WHEN   "EDSRYYMD"
               MOVE  002           TO  SPA-GMN-Q01-CUR
      *
      *    基本情報タブ
           WHEN   "STBIRTHDAY"
               MOVE  101           TO  SPA-GMN-Q01-CUR
           WHEN   "EDBIRTHDAY"
               MOVE  102           TO  SPA-GMN-Q01-CUR
           WHEN   "STAGE"
               MOVE  103           TO  SPA-GMN-Q01-CUR
           WHEN   "EDAGE"
               MOVE  104           TO  SPA-GMN-Q01-CUR
           WHEN   "KJYNYMD"
               MOVE  105           TO  SPA-GMN-Q01-CUR
           WHEN   "SEX"
               MOVE  106           TO  SPA-GMN-Q01-CUR
           WHEN   "STLASTYMD"
               MOVE  107           TO  SPA-GMN-Q01-CUR
           WHEN   "EDLASTYMD"
               MOVE  108           TO  SPA-GMN-Q01-CUR
           WHEN   "STPTNUM"
               MOVE  109           TO  SPA-GMN-Q01-CUR
           WHEN   "EDPTNUM"
               MOVE  110           TO  SPA-GMN-Q01-CUR
           WHEN   "POST1"
               MOVE  111           TO  SPA-GMN-Q01-CUR
           WHEN   "JYUSHO1"
               MOVE  112           TO  SPA-GMN-Q01-CUR
           WHEN   "POST2"
               MOVE  113           TO  SPA-GMN-Q01-CUR
           WHEN   "JYUSHO2"
               MOVE  114           TO  SPA-GMN-Q01-CUR
           WHEN   "POST3"
               MOVE  115           TO  SPA-GMN-Q01-CUR
           WHEN   "JYUSHO3"
               MOVE  116           TO  SPA-GMN-Q01-CUR
           WHEN   "POST4"
               MOVE  117           TO  SPA-GMN-Q01-CUR
           WHEN   "JYUSHO4"
               MOVE  118           TO  SPA-GMN-Q01-CUR
           WHEN   "POST5"
               MOVE  119           TO  SPA-GMN-Q01-CUR
           WHEN   "JYUSHO5"
               MOVE  120           TO  SPA-GMN-Q01-CUR
           WHEN   "KANANAME1"
               MOVE  121           TO  SPA-GMN-Q01-CUR
           WHEN   "KANANAME2"
               MOVE  122           TO  SPA-GMN-Q01-CUR
           WHEN   "KANANAME3"
               MOVE  123           TO  SPA-GMN-Q01-CUR
           WHEN   "KANANAME4"
               MOVE  124           TO  SPA-GMN-Q01-CUR
           WHEN   "KANANAME5"
               MOVE  125           TO  SPA-GMN-Q01-CUR
           WHEN   "NAME1"
               MOVE  126           TO  SPA-GMN-Q01-CUR
           WHEN   "NAME2"
               MOVE  127           TO  SPA-GMN-Q01-CUR
           WHEN   "NAME3"
               MOVE  128           TO  SPA-GMN-Q01-CUR
           WHEN   "NAME4"
               MOVE  129           TO  SPA-GMN-Q01-CUR
           WHEN   "NAME5"
               MOVE  130           TO  SPA-GMN-Q01-CUR
           WHEN   "COMMENT1"
               MOVE  131           TO  SPA-GMN-Q01-CUR
           WHEN   "COMMENT2"
               MOVE  132           TO  SPA-GMN-Q01-CUR
           WHEN   "COMMENT3"
               MOVE  133           TO  SPA-GMN-Q01-CUR
      *
      *    保険・公費タブ
           WHEN   "HKNJANUM1"
               MOVE  201           TO  SPA-GMN-Q01-CUR
           WHEN   "HKNJANUM2"
               MOVE  202           TO  SPA-GMN-Q01-CUR
           WHEN   "HKNJANUM3"
               MOVE  203           TO  SPA-GMN-Q01-CUR
           WHEN   "HKNJANUM4"
               MOVE  204           TO  SPA-GMN-Q01-CUR
           WHEN   "HKNJANUM5"
               MOVE  205           TO  SPA-GMN-Q01-CUR
           WHEN   "HKNNUM1"
               MOVE  206           TO  SPA-GMN-Q01-CUR
           WHEN   "HKNNUM2"
               MOVE  207           TO  SPA-GMN-Q01-CUR
           WHEN   "HKNNUM3"
               MOVE  208           TO  SPA-GMN-Q01-CUR
           WHEN   "HKNNUM4"
               MOVE  209           TO  SPA-GMN-Q01-CUR
           WHEN   "HKNNUM5"
               MOVE  210           TO  SPA-GMN-Q01-CUR
           WHEN   "KIGO1"
               MOVE  211           TO  SPA-GMN-Q01-CUR
           WHEN   "NUM1"
               MOVE  212           TO  SPA-GMN-Q01-CUR
           WHEN   "KIGO2"
               MOVE  213           TO  SPA-GMN-Q01-CUR
           WHEN   "NUM2"
               MOVE  214           TO  SPA-GMN-Q01-CUR
           WHEN   "KIGO3"
               MOVE  215           TO  SPA-GMN-Q01-CUR
           WHEN   "NUM3"
               MOVE  216           TO  SPA-GMN-Q01-CUR
           WHEN   "KIGO4"
               MOVE  217           TO  SPA-GMN-Q01-CUR
           WHEN   "NUM4"
               MOVE  218           TO  SPA-GMN-Q01-CUR
           WHEN   "KIGO5"
               MOVE  219           TO  SPA-GMN-Q01-CUR
           WHEN   "NUM5"
               MOVE  220           TO  SPA-GMN-Q01-CUR
           WHEN   "KOHNUM1"
               MOVE  221           TO  SPA-GMN-Q01-CUR
           WHEN   "KOHNUM2"
               MOVE  222           TO  SPA-GMN-Q01-CUR
           WHEN   "KOHNUM3"
               MOVE  223           TO  SPA-GMN-Q01-CUR
           WHEN   "KOHNUM4"
               MOVE  224           TO  SPA-GMN-Q01-CUR
           WHEN   "KOHNUM5"
               MOVE  225           TO  SPA-GMN-Q01-CUR
           WHEN   "FTNJANUM1"
               MOVE  226           TO  SPA-GMN-Q01-CUR
           WHEN   "FTNJANUM2"
               MOVE  227           TO  SPA-GMN-Q01-CUR
           WHEN   "FTNJANUM3"
               MOVE  228           TO  SPA-GMN-Q01-CUR
           WHEN   "FTNJANUM4"
               MOVE  229           TO  SPA-GMN-Q01-CUR
           WHEN   "FTNJANUM5"
               MOVE  230           TO  SPA-GMN-Q01-CUR
      *
      *    病名・診療行為タブ
           WHEN   "BYOBUN"
               MOVE  301           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEISEL"
               MOVE  302           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEICD1"
               MOVE  303           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEI1"
               MOVE  304           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEICD2"
               MOVE  305           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEI2"
               MOVE  306           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEICD3"
               MOVE  307           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEI3"
               MOVE  308           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEICD4"
               MOVE  309           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEI4"
               MOVE  310           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEICD5"
               MOVE  311           TO  SPA-GMN-Q01-CUR
           WHEN   "BYOMEI5"
               MOVE  312           TO  SPA-GMN-Q01-CUR
           WHEN   "SRYACTSEL"
               MOVE  313           TO  SPA-GMN-Q01-CUR
           WHEN   "SRYCD1"
               MOVE  314           TO  SPA-GMN-Q01-CUR
           WHEN   "SRYCD2"
               MOVE  315           TO  SPA-GMN-Q01-CUR
           WHEN   "SRYCD3"
               MOVE  316           TO  SPA-GMN-Q01-CUR
           WHEN   "SRYCD4"
               MOVE  317           TO  SPA-GMN-Q01-CUR
           WHEN   "SRYCD5"
               MOVE  318           TO  SPA-GMN-Q01-CUR
      *
      *    並び順タブ
           WHEN   "KMK1"
               MOVE  401           TO  SPA-GMN-Q01-CUR
           WHEN   "KMK2"
               MOVE  402           TO  SPA-GMN-Q01-CUR
           WHEN   "KMK3"
               MOVE  403           TO  SPA-GMN-Q01-CUR
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *****************************************************************
      *    次カーソル位置設定処理
      *****************************************************************
       5011-INPUT-CUR-NEXT-SEC         SECTION.
      *
      *    次カーソル位置を設定
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "EDSRYYMD"
      *
               EVALUATE    SPA-GMN-Q01-PAGENO
               WHEN    ZERO
                   MOVE    101     TO  SPA-GMN-Q01-CUR
               WHEN    1
                   MOVE    201     TO  SPA-GMN-Q01-CUR
               WHEN    2
                   MOVE    301     TO  SPA-GMN-Q01-CUR
               WHEN    3
                   MOVE    401     TO  SPA-GMN-Q01-CUR
               END-EVALUATE
      *
           WHEN    "COMMENT3"
           WHEN    "FTNJANUM5"
           WHEN    "SRYCD5"
           WHEN    "KMK3"
               MOVE    1           TO  SPA-GMN-Q01-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                       +   1
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    カーソルスキップ処理
      *****************************************************************
       5012-CUR-SKIP-SEC          SECTION.
      *
           IF    ( SPA-GMN-Q01-CUR =   301 )
               IF    ( SPA-GMN-Q01-UBYOMEI-STATE
                                   =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-Q01-CUR =   SPA-GMN-Q01-CUR
                                           +   1
               END-IF
           END-IF
      *
           .
      *
       5012-CUR-SKIP-EXT.
           EXIT.
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
               MOVE    "患者番号の桁数が違います" 
                                       TO  SPA-ERRMSG
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
           WHEN    "0009"
               MOVE    "全角文字でのみ入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "0101"
               MOVE    "診療年月日入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0102"
               MOVE    "生年月日入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0103"
               MOVE    "年齢入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0104"
               MOVE    "基準日入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0105"
               MOVE    "最終受診療日入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0106"
               MOVE    "患者番号入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0107"
               MOVE    "病名コード入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0108"
               MOVE    "診療行為コード入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0109"
               MOVE    "性別入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0110"
               MOVE    "保険の種類入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0111"
               MOVE    "公費の種類入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0112"
               MOVE    "項目名入力エラー"
                                       TO  SPA-ERRMSG
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
               MOVE    "開始患者番号＞終了患者番号となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1007"
               MOVE    "検索条件が入力されていません"
                                       TO  SPA-ERRMSG
           WHEN    "1008"
               MOVE    "開始最終受診日＞終了最終受診日となっています"
                                       TO  SPA-ERRMSG
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

