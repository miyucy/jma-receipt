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
      *
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGI01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院業務
      *  コンポーネント名  : 入退院登録（Ｉ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02.08.09    ひさなが 　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *
      *    画面非表示
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    入退院登録共通領域
           COPY    "I0COMMON-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "I0SCR-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                     PIC 9(01).
           03  FLG-ERR                     PIC 9(01).
           03  FLG-DBRC                    PIC 9(01).
           03  FLG-ENTRYCHK                PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
           03  FLG-HKNCOMBICHK             PIC 9(01).
           03  FLG-SYORIPTN                PIC 9(01).
           03  FLG-TAISYO                  PIC 9(01).
           03  FLG-TAINSOYRI               PIC 9(01).
           03  FLG-UKETUKEGAITO            PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-ORCSDAY                 PIC 9(01).
           03  FLG-JYUHKNCOMBISET          PIC 9(01).
           03  FLG-NYUKSN                  PIC 9(01).
           03  FLG-HKNCOMBI                PIC 9(01).
           03  FLG-TENKA-SRYKA             PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-ZI-SAISIN               PIC 9(01).
           03  FLG-TOKSET-LOOP             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
           03  IDX3                        PIC 9(05).
           03  IDX4                        PIC 9(05).
           03  IDX5                        PIC 9(05).
           03  IDX6                        PIC 9(05).
           03  IDX7                        PIC 9(05).
           03  IDX8                        PIC 9(05).
           03  IDX9                        PIC 9(05).
           03  IDX10                       PIC 9(05).
           03  IDX11                       PIC 9(05).
           03  IDX12                       PIC 9(05).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD     PIC X(08).
           03  SYS-TIME    PIC X(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-I0IDMSG                 PIC X(70). 
           03  WRK-MOTOPG                  PIC X(08).
           03  WRK-YMD                     PIC X(10). 
           03  WRK-SYMD.
               05  WRK-SYY                 PIC 9(04).
               05  WRK-SMM                 PIC 9(02).
               05  WRK-SDD                 PIC 9(02).
           03  WRK-HENYMDG                 PIC X(09).
           03  WRK-KANACHK-MAE-INPUT       PIC X(400).
      *    パス名領域
           03  WRK-DBPATH                  PIC X(20).
           03  WRK-CALC-YMD1.
               05  WRK-CALC-YY1            PIC 9(04).
               05  WRK-CALC-MM1            PIC 9(02).
               05  WRK-CALC-DD1            PIC 9(02).
      *
           03  WRK-CALC-YMD2.
               05  WRK-CALC-YY2            PIC 9(04).
               05  WRK-CALC-MM2            PIC 9(02).
               05  WRK-CALC-DD2            PIC 9(02).
           03  WRK-AGE-YY                  PIC S9(04).
           03  WRK-AGE-MM                  PIC S9(02).
           03  WRK-AGE-G.
               05  WRK-AGE-Z               PIC ---9.
               05  WRK-AGE-MEI             PIC X(04).
           03  WRK-BIRTHDAY                PIC X(08).
           03  WRK-COMBO.
               05  WRK-CMB-CD              PIC X(05).
               05  WRK-CMB-IDX             PIC 9(03).
               05  WRK-CMB-ITM             PIC X(100).
               05  WRK-CMB-ITM2            PIC X(100).
           03  WRK-CNT                     PIC 9(05).
           03  WRK-NUM-EDIT.
               05  WRK-99                  PIC 9(02).
               05  WRK-99999               PIC 9(05).
               05  WRK-999999              PIC 9(06).
               05  WRK-ZZ9                 PIC ZZ9.
               05  WRK-ZZZ9                PIC ZZZ9.
               05  WRK-ZZZZ9               PIC ZZZZ9.
               05  WRK-ZZZZZ9              PIC ZZZZZ9.
           03  WRK-SAGAKU.
               05  WRK-SAGAKU-NUM          PIC ZZZZ9.
               05  WRK-SAGAKU-EN           PIC X(02).
           03  WRK-STR1                    PIC X(20).
           03  WRK-STR2                    PIC X(20).
           03  WRK-IDX1                    PIC 9(05).
           03  WRK-IDX2                    PIC 9(05).
           03  WRK-BTUJYOHO-TBL.
               05  WRK-BTUJYOHO-CNT        PIC 9(05).
               05  WRK-BTUJYOHO-OCC        OCCURS  50
                                           INDEXED BY  WRK-BTUNUM-IDX.
                   07  WRK-BTUJY-BTUNUM    PIC X(02).
                   07  WRK-BTUJY-BRM-SAGAKU
                                           PIC X(02).
           03  WRK-BRM-SAGAKU-CD           PIC X(02).
           03  WRK-HKNCOMBI                PIC X(100).
           03  WRK-FTNRATE                 PIC X(05).
           03  WRK-HKNKBN-MEI              PIC X(02).
           03  WRK-CREYMD                  PIC X(08).
           03  WRK-JTIKBN                  PIC X(01).
           03  WRK-RRKNUM                  PIC 9(03).
           03  WRK-RRKEDANUM               PIC 9(03).
           03  WRK-KJNYMD                  PIC X(08).
           03  WRK-UPDKBN                  PIC X(3).
           03  WRK-TENNYUYMD               PIC X(08).
           03  WRK-TENSTUYMD               PIC X(08).
           03  WRK-BRMNUM                  PIC X(06).
           03  WRK-BRMNUM-IN               PIC X(06).
           03  WRK-BRMNUM-EDT              PIC X(06).
           03  WRK-BRMNUM-OT               PIC X(06).
           03  WRK-NYUINKA-KEY             PIC X(02).
           03  WRK-BTUNUM-KEY              PIC X(02).
           03  WRK-BRMNUM-KEY              PIC X(08).
           03  WRK-REKI-BYOMEI-EDIT-AREA.
               05  WRK-REKI-BYOMEI-EDIT-OCC
                                           OCCURS 50
                                           INDEXED BY  WRK-RRKBYO-IDX.
                   07  WRK-REKI-BYO-ZITA-FLG   PIC 9(01).
                   07  WRK-REKI-BYO-NYUINKA    PIC X(02).
                   07  WRK-REKI-BYO-NYUINYMD   PIC X(08).
                   07  WRK-REKI-BYO-TAIINYMD   PIC X(08).
                   07  WRK-REKI-BYO-RENNUM     PIC 9(02).
                   07  WRK-REKI-BYO-SRYYMD     PIC X(08).
                   07  WRK-REKI-BYO-BYOMEI     PIC X(40).
                   07  WRK-REKI-BYO-TENKIKBN   PIC X(01).
           03  WRK-WIDGET-B07-STT              PIC S9(9)   BINARY.
           03  WRK-WIDGET-B08-STT              PIC S9(9)   BINARY.
           03  WRK-WIDGET-STT                  PIC S9(9)   BINARY.
           03  WRK-STYMD                       PIC X(08).
           03  WRK-EDYMD                       PIC X(08).
           03  WRK-NISSU                       PIC 9(05).
           03  WRK-NISSU1                      PIC 9(05).
           03  WRK-NISSU2                      PIC 9(05).
           03  WRK-TSUSAN                      PIC 9(05).
           03  WRK-NYUINNISSU                  PIC 9(05).
           03  WRK-SANTEISTYMD                 PIC X(08).
           03  WRK-REKI-ZIIN-TBL.
               05  WRK-REKI-ZIIN-CNT           PIC 9(05).
               05  WRK-REKI-ZIIN-OCC           OCCURS  50.
                   07  WRK-REKI-ZIIN-NYUINYMD  PIC X(08).
                   07  WRK-REKI-ZIIN-TAIINYMD  PIC X(08).
           03  WRK-ZOGENPTN                PIC X(01).
           03  WRK-ZOGEN                   PIC S9(05).
           03  WRK-KEISANYMD               PIC X(08).
           03  WRK-HKNCOMBINUM             PIC X(04).
           03  WRK-HKNCOMBINUM9   REDEFINES  WRK-HKNCOMBINUM
                                           PIC 9(04).
           03  WRK-SHONUM                  PIC 9(03).
           03  WRK-SRYKAMEI                PIC X(30).
           03  WRK-TENKA-SRYKA-TBL.
               05  WRK-TENKA-SRYKA-CNT     PIC 9(05).
               05  WRK-TENKA-SRYKA         PIC X(02)
                                           OCCURS 50.
           03  WRK-SAGAKU-KBN              PIC X(02).
           03  WRK-SAGAKU-KBN9  REDEFINES  WRK-SAGAKU-KBN
                                           PIC 9(02).
           03  WRK-ZI-SAISIN-RRKNUM        PIC 9(03).
           03  WRK-ZI-SAISIN-RRKEDANUM     PIC 9(03).
           03  WRK-KANRICD                 PIC X(04).
           03  WRK-KBNCD                   PIC X(08).
           03  WRK-TOKNYUIN-NM             PIC X(40).
           03  WRK-TOKNYUIN-KBN            PIC X(01).
           03  WRK-TOKNYUIN-CD             PIC X(02).
           03  WRK-TAIHI-SRYKA             PIC X(02).
           03  WRK-SKYSTYM                 PIC X(06).
           03  WRK-SYU-SUM-IDX             PIC 9(05).
           03  WRK-TAIINUPDCNT             PIC 9(05).
      *
           03  WRK-MCP-WIDGET      PIC X(64).
           03  WRK-IDOYMD                  PIC X(08).
      *
      *    スパ領域 ワーク
           COPY    "COMMON-SPA"      REPLACING
                               //SPA-// BY //WRK-SPA-//.
      *
      *    患者入院履歴ワーク
       01  WKPTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC"
                                     REPLACING
                               //PTNYUINRRK-// BY //WKPTNYUINRRK-//.
      *
      *    収納ワーク
       01  SUMSYUNOU-REC.
         02 SUMSYUNOU-CNT     PIC 9(05).
         02 SUMSYUNOU-OCC     OCCURS 13.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //SUMSYU-//.
      *    収納合計ワーク
       01  TTLSYUNOU-REC.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //TTLSYU-//.
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    （診療科入院科情報）
           COPY    "CPSK1005.INC".
      *    （職員情報）
           COPY    "CPSK1010.INC".
      *    （医療機関情報）
           COPY    "CPSK5000.INC".
      *    （病棟情報）
           COPY    "CPSK5001.INC".
      *    （病室情報）
           COPY    "CPSK5002.INC".
      *    （室料差額）
           COPY    "CPSK5113.INC".
      *    （特定入院料−病棟）
           COPY    "CPSK5110.INC".
      *    （特定入院料−病室）
           COPY    "CPSK5111.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者病名
       01  PTBYOMEI-REC.
           COPY    "CPPTBYOMEI.INC".
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *    患者他院歴付加情報
       01  PTTAINFUKA-REC.
           COPY    "CPPTTAINFUKA.INC".
      *
      *    受付マスタ
       01  UKETUKE-REC.
           COPY    "CPUKETUKE.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
       01  WKJYURRK-REC.
           COPY    "CPJYURRK.INC"      REPLACING
                                       //JYURRK-// BY //WKJYURRK-//.
      *    老人一般コード変換
        01  SRYCDCHG-REC.
            COPY    "CPSRYCDCHG.INC".
      *   
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    入院登録サブ
           COPY    "CPI0SUB01.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTNUM.INC".
      *
      *    数値号変換サブ
           COPY    "CPORCSNUM.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    初期加算算定サブ
           COPY    "CPORCSSYOKIKSN.INC".
      *
      *    入院会計作成サブ
           COPY    "CPORCSNYUACCT.INC".
      *
      *    負担金計算サブ
       01  LNK-ORCS02-REC.
           COPY  "CPORCS02.INC".
       01  LNK-SYUNOU-REC-T.
         02 LNK-SYUNOU-REC     OCCURS 10.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
      *     テーブルアクセス
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "I01.INC".
           COPY    "I02.INC".
           COPY    "I03.INC".
           COPY    "I04.INC".
           COPY    "I0ERR.INC".
           COPY    "I0ID1.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
                                               MCPAREA
                                               SPAAREA
                                               LINKAREA
                                               SCRAREA.
      *****************************************************************
      *    主    処    理
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-I0FREE.
           MOVE    SPA-WORK        TO  SPA-I0KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD.
           MOVE    ZERO            TO  FLG-END.
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"          ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF  FLG-END   =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-I0KYOUTU    TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-I0FREE      TO  SPA-FREE
           .
      *
       000-PROC-SEC-EXT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
      *    エラー画面より
           IF    ( SPA-MOTOPG          =   "I0ERR" )
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF    ( FLG-END         =   1 )
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
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "I01"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
      *
       100-INIT-EXT.
           EXIT.
      *
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
               IF      WRK-MOTOPG(1:3)     =   "P97"
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-I01
                   MOVE    SPA-WORK        TO  SPA-I0KYOUTU
                   MOVE    1               TO  SPA-GMN-I01-CUR
               END-IF
      *
               IF      WRK-MOTOPG(1:3)     =   "P97"
                   PERFORM 330-P97-SET-SEC
                   GO  TO  300-SCREEN-EXT
               END-IF
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *
      *    確認画面
           WHEN    "I0ID1"
               PERFORM 330-I0ID1-SET-SEC
               MOVE    SPACE       TO  SPA-I0ID1-FLG
               MOVE    SPACE       TO  SPA-I0IDCD
      *
               GO  TO      300-SCREEN-EXT
      *
      *    入院歴表示画面
           WHEN    "I02"
               GO  TO      300-SCREEN-EXT
      *
      *    他院歴表示画面
           WHEN    "I03"
               PERFORM 330-I03-SET-SEC
               GO  TO      300-SCREEN-EXT
      *
      *    請求確認画面
           WHEN    "I04"
               IF    ( SPA-I01-I04-BTN     =   "B12" )
      *            画面を更新後の内容で再表示
                   PERFORM 4101-PTNUM-CHK-SEC
                   DISPLAY "SPA-ERRCD = " SPA-ERRCD
               END-IF
      *
               GO  TO      300-SCREEN-EXT
      *
      *    入院会計照会画面
           WHEN    "I41"
      *
      *        退避しておいたＳＰＡの内容を元に戻す
               INITIALIZE                  I0SUB01-LNK
               MOVE    SPA-TERMID      TO  I0SUB01-TERMID
               MOVE    "I"             TO  I0SUB01-KBN
               CALL    "ORCGI0SUB01"   USING   I0SUB01-LNK
      *
               MOVE    I0SUB01-SCRSPA-AREA
                                       TO  SPA-I0FREE
               MOVE    I0SUB01-COMMON  TO  SPA-I0KYOUTU
      *
               GO  TO  300-SCREEN-EXT
      *    患者登録画面
           WHEN    "P02"
      *        退避しておいたＳＰＡの内容を元に戻す
               INITIALIZE                  I0SUB01-LNK
               MOVE    SPA-TERMID      TO  I0SUB01-TERMID
               MOVE    "I"             TO  I0SUB01-KBN
               CALL    "ORCGI0SUB01"   USING   I0SUB01-LNK
      *
               MOVE    I0SUB01-SCRSPA-AREA
                                       TO  SPA-I0FREE
               MOVE    I0SUB01-COMMON  TO  SPA-I0KYOUTU
      *
               PERFORM 330-P02-SET-SEC
      *
               GO  TO  300-SCREEN-EXT
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
       310-SPASET-SEC              SECTION.
      *
      *    入外区分
           MOVE    "1"             TO  SPA-NYUGAIKBN
      *
           INITIALIZE              I01
                                   SPA-I0FREE
                                   SPA-I0KYOUTU
      *
      *    コンボボックス初期化
           PERFORM 310-CMB-SYOKI-SEC
      *
      *    画面初期化
           PERFORM 420-CLEAR-SEC
      *
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    コンボボックス初期処理
      *****************************************************************
       310-CMB-SYOKI-SEC               SECTION.
      *
           INITIALIZE              SPA-GMN-I01-CMB-DAT-AREA
      *
      *    処理区分コンボ（全て表示）
           PERFORM 310-CMB-SYORIKBN-SET1-SEC
      *
      *    室料差額コンボ
           PERFORM 310-CMB-SAGAKU-SET-SEC
      *
      *    入院科コンボ
           PERFORM 310-CMB-NYUINKA-SET-SEC
      *
      *    初回コンボ
           PERFORM 310-CMB-SHOKAI-SET-SEC
      *
      *    担当医コンボ
           PERFORM 310-CMB-DR-SET-SEC
      *
      *    定期請求コンボ
           PERFORM 310-CMB-SEIKYU-SET-SEC
      *
      *    検索時患者表示コンボ
           PERFORM 310-CMB-DISPKBN-SET-SEC
      *
           .
       310-CMB-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    処理区分コンボ初期処理（全て表示）
      *****************************************************************
       310-CMB-SYORIKBN-SET1-SEC       SECTION.
      *
           INITIALIZE              SPA-GMN-I01-CMB-SYORIKBN
      *
           MOVE    8               TO  SPA-GMN-I01-SYORIKBN-CNT
      *
           MOVE    "01 入院登録"   TO  SPA-GMN-I01-SYORIKBN-ITM (01)
           MOVE    "02 退院登録"   TO  SPA-GMN-I01-SYORIKBN-ITM (02)
           MOVE    "03 変更"       TO  SPA-GMN-I01-SYORIKBN-ITM (03)
           MOVE    "04 照会"       TO  SPA-GMN-I01-SYORIKBN-ITM (04)
           MOVE    "05 入院取消"   TO  SPA-GMN-I01-SYORIKBN-ITM (05)
           MOVE    "06 入院取消（会計含む）"
                                   TO  SPA-GMN-I01-SYORIKBN-ITM (06)
           MOVE    "07 退院取消"   TO  SPA-GMN-I01-SYORIKBN-ITM (07)
           MOVE    "08 転科　転棟　転室"
                                   TO  SPA-GMN-I01-SYORIKBN-ITM (08)
      *
      *
           .
       310-CMB-SYORIKBN-SET1-EXT.
           EXIT.
      *****************************************************************
      *    処理区分コンボ初期処理（初入院）
      *****************************************************************
       310-CMB-SYORIKBN-SET2-SEC       SECTION.
      *
           INITIALIZE              SPA-GMN-I01-CMB-SYORIKBN
      *
           MOVE    1               TO  SPA-GMN-I01-SYORIKBN-CNT
           MOVE    "01 入院登録"   TO  SPA-GMN-I01-SYORIKBN-ITM (01)
      *
      *
           .
       310-CMB-SYORIKBN-SET2-EXT.
           EXIT.
      *****************************************************************
      *    処理区分コンボ初期処理（入院中）
      *****************************************************************
       310-CMB-SYORIKBN-SET3-SEC       SECTION.
      *
           INITIALIZE              SPA-GMN-I01-CMB-SYORIKBN
      *
           MOVE    6               TO  SPA-GMN-I01-SYORIKBN-CNT
      *
           MOVE    "02 退院登録"   TO  SPA-GMN-I01-SYORIKBN-ITM (01)
           MOVE    "03 変更"       TO  SPA-GMN-I01-SYORIKBN-ITM (02)
           MOVE    "04 照会"       TO  SPA-GMN-I01-SYORIKBN-ITM (03)
           MOVE    "05 入院取消"   TO  SPA-GMN-I01-SYORIKBN-ITM (04)
           MOVE    "06 入院取消（会計含む）"
                                   TO  SPA-GMN-I01-SYORIKBN-ITM (05)
           MOVE    "08 転科　転棟　転室"
                                   TO  SPA-GMN-I01-SYORIKBN-ITM (06)
      *
           .
       310-CMB-SYORIKBN-SET3-EXT.
           EXIT.
      *****************************************************************
      *    処理区分コンボ初期処理（入院歴あり−退院済）
      *****************************************************************
       310-CMB-SYORIKBN-SET4-SEC       SECTION.
      *
           INITIALIZE              SPA-GMN-I01-CMB-SYORIKBN
      *
           MOVE    3               TO  SPA-GMN-I01-SYORIKBN-CNT
      *
           MOVE    "01 入院登録"   TO  SPA-GMN-I01-SYORIKBN-ITM (01)
           MOVE    "04 照会"       TO  SPA-GMN-I01-SYORIKBN-ITM (02)
           MOVE    "07 退院取消"   TO  SPA-GMN-I01-SYORIKBN-ITM (03)
      *
           .
       310-CMB-SYORIKBN-SET4-EXT.
           EXIT.
      *****************************************************************
      *    処理区分コンボ初期処理（前回他院歴作成）
      *****************************************************************
       310-CMB-SYORIKBN-SET5-SEC       SECTION.
      *
           INITIALIZE              SPA-GMN-I01-CMB-SYORIKBN
      *
           MOVE    2               TO  SPA-GMN-I01-SYORIKBN-CNT
      *
           MOVE    "01 入院登録"   TO  SPA-GMN-I01-SYORIKBN-ITM (01)
           MOVE    "04 照会"       TO  SPA-GMN-I01-SYORIKBN-ITM (02)
      *
      *
           .
       310-CMB-SYORIKBN-SET5-EXT.
           EXIT.
      *****************************************************************
      *    室料差額コンボ初期処理
      *****************************************************************
       310-CMB-SAGAKU-SET-SEC          SECTION.
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5113"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタ検索処理
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1            >   20 )
                   OR    ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC TO  SYS-5113-REC
      *
               MOVE    IDX1    TO  SPA-GMN-I01-SAGAKU-CNT
               MOVE    SYS-5113-KBNCD (1 : 2)
                           TO  SPA-GMN-I01-SAGAKU-ITM  (IDX1)(1 : 2)
               MOVE    SYS-5113-BRM-SAGAKU-NM
                           TO  WRK-99999
               MOVE    WRK-99999
                               TO  WRK-SAGAKU-NUM
               MOVE    "円"    TO  WRK-SAGAKU-EN
               MOVE    WRK-SAGAKU
                           TO  SPA-GMN-I01-SAGAKU-ITM  (IDX1)(4 : )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ処理
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       310-CMB-SAGAKU-SET-EXT.
           EXIT.
      *****************************************************************
      *    入院科コンボ初期処理
      *****************************************************************
       310-CMB-NYUINKA-SET-SEC         SECTION.
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "1005"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタ検索処理
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1            >   99 )
                   OR    ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC TO  SYS-1005-REC
      *
               MOVE    IDX1    TO  SPA-GMN-I01-NYUINKA-CNT
               MOVE    SYS-1005-KBNCD (1 : 2)
                           TO  SPA-GMN-I01-NYUINKA-ITM (IDX1)(1 : 2)
               MOVE    SYS-1005-SRYKANAME
                           TO  SPA-GMN-I01-NYUINKA-ITM (IDX1)(4 : )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ処理
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       310-CMB-NYUINKA-SET-EXT.
           EXIT.
      *****************************************************************
      *    初回コンボ初期処理
      *****************************************************************
       310-CMB-SHOKAI-SET-SEC          SECTION.
      *
           MOVE    2                   TO  SPA-GMN-I01-SHOKAI-CNT
      *
           MOVE    "1 初回"            TO  SPA-GMN-I01-SHOKAI-ITM (01)
           MOVE    "2 継続"            TO  SPA-GMN-I01-SHOKAI-ITM (02)
      *
           .
       310-CMB-SHOKAI-SET-EXT.
           EXIT.
      *****************************************************************
      *    担当医コンボ初期処理
      *****************************************************************
       310-CMB-DR-SET-SEC              SECTION.
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "1010"          TO  SYS-KANRICD
           MOVE    "1"             TO  SYS-KBNCD
           MOVE    SPA-SYSYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタ検索処理
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1            >   50 )
                   OR    ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC TO  SYS-1010-REC
      *
               MOVE    IDX1    TO  SPA-GMN-I01-DR-CNT (1)
               MOVE    SYS-1010-KBNCD (2 : 4)
                           TO  SPA-GMN-I01-DR-ITM(1 IDX1)(1 : 4)
               MOVE    SYS-1010-NAME
                           TO  SPA-GMN-I01-DR-ITM(1 IDX1)(6 : )
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ処理
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           MOVE    SPA-GMN-I01-CMB-DR-OCC (1)
                                       TO  SPA-GMN-I01-CMB-DR-OCC (2)
                                           SPA-GMN-I01-CMB-DR-OCC (3)
      *
           .
       310-CMB-DR-SET-EXT.
           EXIT.
      *****************************************************************
      *    定期請求コンボ初期処理
      *****************************************************************
       310-CMB-SEIKYU-SET-SEC          SECTION.
      *
           MOVE    2               TO  SPA-GMN-I01-SEIKYU-CNT
      *
           MOVE    "1 医療機関での設定"
                                   TO  SPA-GMN-I01-SEIKYU-ITM (01)
           MOVE    "2 月末時のみ請求  "
                                   TO  SPA-GMN-I01-SEIKYU-ITM (02)
      *
      *
           .
       310-CMB-SEIKYU-SET-EXT.
           EXIT.
      *****************************************************************
      *    検索時患者表示コンボ初期処理
      *****************************************************************
       310-CMB-DISPKBN-SET-SEC         SECTION.
      *
           MOVE    2               TO  SPA-GMN-I01-DISPKBN-CNT
      *
           MOVE    "1 表示可  "    TO  SPA-GMN-I01-DISPKBN-ITM (1)
           MOVE    "2 表示不可"    TO  SPA-GMN-I01-DISPKBN-ITM (2)
      *
      *
           .
       310-CMB-DISPKBN-SET-EXT.
           EXIT.
      *****************************************************************
      *    氏名検索画面（Ｐ９７）からの戻り値設定処理
      *****************************************************************
       330-P97-SET-SEC                 SECTION.
      *
           MOVE    LNK-KYOUTU          TO  WRK-SPA-KYOUTU
      *
      *    人が選ばれなかった場合、
      *    同一の人が選択された場合は、画面内容の変更は行わない
           IF    ( WRK-SPA-PTID    =   ZERO )
             OR  ( WRK-SPA-PTID    =   SPA-NAI-I01-PTID )
               GO  TO  330-P97-SET-EXT
           END-IF
      *
      *    画面初期化
           PERFORM 420-CLEAR-SEC
      *
           MOVE    WRK-SPA-PTID        TO  SPA-NAI-I01-PTID 
           MOVE    WRK-SPA-PTNUM       TO  SPA-GMN-I01-PTNUM
      *
           PERFORM 4101-PTINF-SELECT-SEC
      *
           .
       330-P97-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者登録画面（Ｐ０２）からの戻り値設定処理
      *****************************************************************
       330-P02-SET-SEC                 SECTION.
      *
           IF    ( SPA-ERRMSG(1:2)     =   "NO" )
               GO  TO  330-P02-SET-EXT
           END-IF
      *
           IF    ( SPA-PTID            =   ZERO )
               GO  TO  330-P02-SET-EXT
           END-IF
      *
      *    画面初期化
           PERFORM 420-CLEAR-SEC
      *
           MOVE    SPA-PTID            TO  SPA-NAI-I01-PTID
           MOVE    SPA-PTNUM           TO  SPA-GMN-I01-PTNUM
      *
           PERFORM 4101-PTINF-SELECT-SEC
      *
           .
       330-P02-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（Ｉ０ＩＤ１）からの戻り値設定処理
      *****************************************************************
       330-I0ID1-SET-SEC               SECTION.
      *
           IF    ( SPA-I0ID1-FLG   =   "OK" )
               MOVE    SPACE       TO  WRK-UPDKBN
               EVALUATE    SPA-I0IDCD
      *        入院取消
               WHEN "3001"
      *        入院取消（会計含む）
               WHEN "3002"
                   MOVE    "DEL"   TO  WRK-UPDKBN
                   PERFORM 4801-PTNYUINRRK-UPD-SEC
                   IF    ( SPA-ERRCD       NOT =   SPACE )
                       GO  TO  330-I0ID1-SET-EXT
                   END-IF
      *        退院取消
               WHEN "3003"
                   MOVE    "UPD"   TO  WRK-UPDKBN
                   PERFORM 4801-PTNYUINRRK-UPD-SEC
                   IF    ( SPA-ERRCD       NOT =   SPACE )
                       GO  TO  330-I0ID1-SET-EXT
                   END-IF
               END-EVALUATE
           END-IF
      *
           .
       330-I0ID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    他院歴作成画面から戻った場合の処理
      *****************************************************************
       330-I03-SET-SEC                 SECTION.
      *
      *    戻るボタンで戻ってきた場合は何もしない
           IF    ( SPA-I01-I03-BTN =   "B01" )
               GO  TO  330-I03-SET-EXT
           END-IF
      *
      *    入院歴リストを再編集する
           PERFORM 4101-NYUREKI-EDIT-SEC
      *
      *    最新の入院歴を取得する
           PERFORM 4101-PTNYUINRRK-SEL1-SEC
      *
           IF  (   SPA-I01-I03-SYORIKBN-CD     =   "01" )
      *        入院歴なし（初入院）
               IF  (   FLG-PTNYUINRRK  NOT =   ZERO )
      *            MOVE    WIDGET-INSENSITIVE
      *                                TO  SPA-GMN-I01-B08-STT
                   PERFORM 310-CMB-SYORIKBN-SET2-SEC
                   MOVE    SPA-GMN-I01-SYORIKBN-ITM (01)
                                       TO  SPA-GMN-I01-SYORIKBN
               ELSE
      *            他院歴有り
                   IF    ( PTNYUINRRK-JTIKBN   =   "5" )
      *                MOVE    WIDGET-NORMAL
      *                                TO  SPA-GMN-I01-B08-STT
                       PERFORM 310-CMB-SYORIKBN-SET5-SEC
                       MOVE    SPA-GMN-I01-SYORIKBN-ITM (01)
                                       TO  SPA-GMN-I01-SYORIKBN
                   ELSE
      *                MOVE    WIDGET-INSENSITIVE
      *                                TO  SPA-GMN-I01-B08-STT
                       PERFORM 310-CMB-SYORIKBN-SET4-SEC
                       MOVE    SPA-GMN-I01-SYORIKBN-ITM (01)
                                       TO  SPA-GMN-I01-SYORIKBN
                   END-IF
               END-IF
           ELSE
      *        入院歴なし（初入院）
               IF  (   FLG-PTNYUINRRK  NOT =   ZERO )
                   PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *            MOVE    WIDGET-INSENSITIVE
      *                                TO  SPA-GMN-I01-B08-STT
                   PERFORM 310-CMB-SYORIKBN-SET2-SEC
                   MOVE    SPACE       TO  SPA-GMN-I01-SYORIKBN
               ELSE
      *            他院歴有り
                   IF    ( PTNYUINRRK-JTIKBN   =   "5" )
                       PERFORM 4101-INPUT-AREA-EDIT2-SEC
                       PERFORM 4201-WIDGET-INSENSITIVE-SEC
      *                MOVE    WIDGET-NORMAL
      *                                TO  SPA-GMN-I01-B08-STT
                       PERFORM 310-CMB-SYORIKBN-SET5-SEC
                       MOVE    SPA-GMN-I01-SYORIKBN-ITM (02)
                                       TO  SPA-GMN-I01-SYORIKBN
                   ELSE
                       PERFORM 4101-INPUT-AREA-EDIT-SEC
                       PERFORM 4201-WIDGET-INSENSITIVE-SEC
      *                MOVE    WIDGET-INSENSITIVE
      *                                TO  SPA-GMN-I01-B08-STT
                       PERFORM 310-CMB-SYORIKBN-SET4-SEC
                       MOVE    SPA-GMN-I01-SYORIKBN-ITM (02)
                                       TO  SPA-GMN-I01-SYORIKBN
                   END-IF
               END-IF
           END-IF
      *
           MOVE    WIDGET-NORMAL       TO  SPA-GMN-I01-B07-STT
           MOVE    WIDGET-NORMAL       TO  SPA-GMN-I01-B08-STT
      *
           IF    ( SPA-GMN-I01-NYUREKILST-CNT  >   ZERO )
               MOVE    1           TO  SPA-GMN-I01-NYUREKILST-SEL
                                       SPA-GMN-I01-SELNUM
           END-IF
      *
           .
       330-I03-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                     SECTION.
      *
           IF      ( MCP-WIDGET        =   "B06"   
                                       OR  "B07"
                                       OR  "B12" )
      *        患者番号チェック
               PERFORM 4102-PTNUM-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   PERFORM 420-CLEAR-SEC
                   GO  TO  200-GMNSENI-EXT
               END-IF
      *
           END-IF
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 210-BACK
           WHEN    "CLICKED"       ALSO    "B02"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 420-CLEAR-SEC
           WHEN    "CLICKED"       ALSO    "B03"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 420-MAEPTINF-SET-SEC
           WHEN    "CLICKED"       ALSO    "B06"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 480-NYUINREKI-SEC
           WHEN    "CLICKED"       ALSO    "B07"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 480-TAINREKI-SAKUSEI-SEC
           WHEN    "CLICKED"       ALSO    "B08"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 480-TAINREKI-SYUSEI-SEC
           WHEN    "CLICKED"       ALSO    "B09"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 480-KENSAKU-SEC
           WHEN    "CLICKED"       ALSO    "B12"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 480-TOUROKU-SEC
           WHEN    "CLICKED"       ALSO    "B21"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM 480-NYUINKAIKEI-SEC
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           IF      ( MCP-WIDGET    NOT =   "PTNUM" )
      *        患者番号チェック
               PERFORM 4102-PTNUM-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   PERFORM 420-CLEAR-SEC
                   GO  TO  200-ENTRY-EXT
               END-IF
      *
           END-IF
      *
           MOVE    MCP-WIDGET      TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    患者番号チェック
           WHEN    "ACTIVATE"      ALSO    "PTNUM"
               PERFORM 4101-PTNUM-CHK-SEC
      *    処理区分チェック
           WHEN    "ACTIVATE"      ALSO    "SYORIKBN"
               PERFORM 4101-SYORIKBN-CHK-SEC
           WHEN    OTHER
      *
      *        入力個所のセット
               PERFORM 400-GMN-INPUT-SEC
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
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
       400-GMN-INPUT-SEC          SECTION.
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    入院歴リスト
           WHEN        ANY         ALSO    "NYUREKILST"
               PERFORM 4101-NYUREKILST-SEL-SEC
           WHEN        OTHER
               MOVE    ZERO        TO      SPA-GMN-I01-CUR
      *
           END-EVALUATE
      *
           .
      *
       400-GMN-INPUT-EXT.
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
      *    処理区分チェック
           PERFORM 4102-SYORIKBN-CHK-SEC
           IF    ( SPA-ERRCD NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
      *    自院分のデータを表示している場合のみチェックを行う
           IF    ( SPA-NAI-I01-TAINRRK-FLG   = ZERO )
      *        基本チェック処理
               PERFORM 4102-KIHON-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                 OR  ( FLG-END     NOT =   ZERO  )
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
      *
           END-IF
      *
      *    選択番号チェック処理
           PERFORM 4101-SELNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC            SECTION.
      *
      *    異動日
           MOVE    I01-IDOYMD          TO  SPA-GMN-I01-IDOYMD
      *    病室番号
           MOVE    I01-BRMNUM          TO  SPA-GMN-I01-BRMNUM
      *    病棟名称
           MOVE    I01-BTUNAME         TO  SPA-GMN-I01-BTUNAME
      *    室料差額
           MOVE    I01-SAGAKU          TO  SPA-GMN-I01-SAGAKU
      *    入院日
           MOVE    I01-NYUINYMD        TO  SPA-GMN-I01-NYUINYMD
      *    入院科
           MOVE    I01-NYUINKA         TO  SPA-GMN-I01-NYUINKA
      *    初回
           MOVE    I01-SHOKAI          TO  SPA-GMN-I01-SHOKAI
      *    初回番号
           MOVE    I01-SHONUM          TO  SPA-GMN-I01-SHONUM
      *    初回入院日
           MOVE    I01-LBL-SHONYUINYMD TO  SPA-GMN-I01-LBL-SHONYUINYMD
      *    退院日
           MOVE    I01-TAIINYMD        TO  SPA-GMN-I01-TAIINYMD
      *    担当医
           MOVE    I01-DR (1)          TO  SPA-GMN-I01-DR (1)
           MOVE    I01-DR (2)          TO  SPA-GMN-I01-DR (2)
           MOVE    I01-DR (3)          TO  SPA-GMN-I01-DR (3)
      *    保険組み合わせ
           MOVE    I01-HKNCOMBI        TO  SPA-GMN-I01-HKNCOMBI
      *    特定入院
           MOVE    I01-TOKNYUIN        TO  SPA-GMN-I01-TOKNYUIN
      *    前受け金
           MOVE    I01-MAEUKE          TO  SPA-GMN-I01-MAEUKE
      *    定期請求
           MOVE    I01-SEIKYU          TO  SPA-GMN-I01-SEIKYU
      *    検索時患者表示
           MOVE    I01-DISPKBN         TO  SPA-GMN-I01-DISPKBN
      *    選択番号
           MOVE    I01-SELNUM          TO  SPA-GMN-I01-SELNUM
      *
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
      *    異動日チェック処理
           PERFORM 4101-IDOYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病室番号チェック処理
           IF    ( SPA-GMN-I01-BRMNUM  NOT =   SPA-NAI-I01-BRMNUM-MAE )
               PERFORM 4101-BRMNUM-CHK-SEC
               MOVE    SPA-GMN-I01-BRMNUM
                                       TO  SPA-NAI-I01-BRMNUM-MAE
               MOVE    SPA-ERRCD       TO  SPA-NAI-I01-BRMNUM-ERR
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
           ELSE
               IF    ( SPA-NAI-I01-BRMNUM-ERR
                                   NOT =   SPACE )
                   MOVE    SPA-NAI-I01-BRMNUM-ERR
                                       TO  SPA-ERRCD
                   MOVE    4           TO  SPA-GMN-I01-CUR
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
           END-IF
      *
      *    病棟名称チェック処理
           IF    ( SPA-GMN-I01-BTUNAME
                                       NOT =   SPA-NAI-I01-BTUNAME-MAE )
               PERFORM 4101-BTUNAME-CHK-SEC
               MOVE    SPA-GMN-I01-BTUNAME
                                       TO  SPA-NAI-I01-BTUNAME-MAE
               MOVE    SPA-ERRCD       TO  SPA-NAI-I01-BTUNAME-ERR
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
           ELSE
               IF    ( SPA-NAI-I01-BTUNAME-ERR
                                   NOT =   SPACE )
                   MOVE    SPA-NAI-I01-BTUNAME-ERR
                                       TO  SPA-ERRCD
                   MOVE    5           TO  SPA-GMN-I01-CUR
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
           END-IF
      *
      *    PERFORM 4101-BTUNAME-CHK-SEC
      *    IF    ( SPA-ERRCD   NOT =   SPACE )
      *        GO  TO  4102-KIHON-CHK-EXT
      *    END-IF
      *
      *    室料差額チェック処理
           PERFORM 4101-SAGAKU-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    入院日チェック処理
           PERFORM 4101-NYUINYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    入院科チェック処理
           PERFORM 4101-NYUINKA-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    初回チェック処理
           PERFORM 4101-SHOKAI-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    初回番号チェック処理
           PERFORM 4101-SHONUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    退院日チェック処理
           PERFORM 4101-TAIINYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    担当医チェック処理
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   3   )
      *
               PERFORM 4101-DR-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
      *    保険組み合わせチェック処理
           PERFORM 4101-HKNCOMBI-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    特定入院チェック処理
           PERFORM 4101-TOKNYUIN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    前受け金チェック処理
      *    PERFORM 4101-MAEUKE-CHK-SEC
      *    IF    ( SPA-ERRCD   NOT =   SPACE )
      *        GO  TO  4102-KIHON-CHK-EXT
      *    END-IF
      *
      *    定期請求チェック処理
      *    PERFORM 4101-SEIKYU-CHK-SEC
      *    IF    ( SPA-ERRCD   NOT =   SPACE )
      *        GO  TO  4102-KIHON-CHK-EXT
      *    END-IF
      *
      *    検索時患者表示チェック処理
           PERFORM 4101-DISPKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
       4101-PTNUM-CHK-SEC              SECTION.
      *
           PERFORM  420-CLEAR-SEC
      *
           MOVE    1               TO  SPA-GMN-I01-CUR
      *
           MOVE    SPACE           TO  SPA-GMN-I01-ERRCD (1)
      *
           INITIALIZE                  SPA-NAI-I01-PTID
                                       SPA-GMN-I01-NAME
                                       SPA-NAI-I01-KANANAME
                                       SPA-GMN-I01-SEX
                                       SPA-GMN-I01-BIRTHDAY
                                       SPA-NAI-I01-BIRTHDAY
                                       SPA-GMN-I01-AGE
                                       SPA-KYOTUKEY
      *
           MOVE    I01-PTNUM       TO  SPA-GMN-I01-PTNUM
      *
      *    患者番号が入力されていること
           IF    ( SPA-GMN-I01-PTNUM   =   SPACE )
               MOVE    "1001"      TO  SPA-ERRCD
               PERFORM 510-ERRCD-SET-SEC
               GO  TO  4101-PTNUM-CHK-EXT
           END-IF
      *
      *    ＊のとき、患者新規登録へ
           IF    ( SPA-GMN-I01-PTNUM(1:1)  =   "*" )
               MOVE    "*"                 TO  SPA-PTNUM
               PERFORM 440-KNJADD-SEC
               GO  TO      4101-PTNUM-CHK-EXT
           END-IF
      *
      *    患者番号変換サブ呼び出し
           INITIALIZE                  ORCSPTNUMAREA
           MOVE    SPA-GMN-I01-PTNUM   TO  SPTNUM-PTNUM
           CALL    "ORCSPTNUM"         USING   ORCSPTNUMAREA
                                               SPA-AREA
           EVALUATE    SPTNUM-RC
               WHEN    00
                   MOVE    SPTNUM-PTNUM        TO  SPA-GMN-I01-PTNUM
                   MOVE    SPTNUM-PTID         TO  SPA-NAI-I01-PTID
               WHEN   10
                   MOVE    "0002"              TO  SPA-ERRCD
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4101-PTNUM-CHK-EXT
               WHEN    20
      *            氏名検索へ
                   MOVE    SPACE               TO  LINKAREA
                   MOVE    SPA-KYOUTU          TO  LNK-COMMON
                   MOVE    SPA-I0FREE          TO  LNK-SCRSPA
      *
                   MOVE    "I01"               TO  SPA-MOTOPG
                   MOVE    "P97"               TO  SPA-SAKIPG
                   MOVE    ZERO                TO  SPA-PTID
      *            患者氏名セット
                   MOVE    SPA-GMN-I01-PTNUM   TO  SPA-NAME
                   MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   MOVE    "P97"               TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                   TO  FLG-END
                   GO      TO     4101-PTNUM-CHK-EXT
               WHEN    OTHER
                   MOVE    "0002"              TO  SPA-ERRCD
                   PERFORM 510-ERRCD-SET-SEC
                   GO  TO  4101-PTNUM-CHK-EXT
           END-EVALUATE
      *
      *    患者マスタ検索
           INITIALIZE  PTINF-REC
           MOVE    SPA-HOSPID                  TO  PTINF-HOSPID
           MOVE    SPA-NAI-I01-PTID            TO  PTINF-PTID
           MOVE    PTINF-REC                   TO  MCPDATA-REC
      *
           MOVE    "PTINF-KEY"                 TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
      *
      *        患者情報設定
               PERFORM 4101-PTINF-SET-SEC
      *        IF    ( SPA-NAI-I01-TAINRRK-FLG        =   ZERO )
      *            IF    ( SPA-GMN-I01-HKNCOMBI-CNT   >   ZERO )
      *                CONTINUE
      *            ELSE
      *                MOVE    "1021"      TO  SPA-ERRCD
      *                MOVE    1           TO  SPA-GMN-I01-CUR
      *            END-IF
      *        END-IF
      *
           ELSE
               MOVE    "0002"                  TO  SPA-ERRCD
               PERFORM 510-ERRCD-SET-SEC
           END-IF
      *
      *    患者マスタクローズ
           MOVE    "PTINF-KEY"                 TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *
           .
      *
       4101-PTNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴マスタ検索処理（入力領域表示用）
      *****************************************************************
       4101-PTNYUINRRK-SEL1-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-PTNYUINRRK
           INITIALIZE  PTNYUINRRK-REC
           MOVE    ZERO            TO  SPA-NAI-I01-PTRRKNUM
                                       SPA-NAI-I01-PTRRKEDANUM
      *
           MOVE    SPA-HOSPID      TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-I01-PTID
                                   TO  PTNYUINRRK-PTID
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
      *
      *    入院履歴検索処理
           MOVE    "PTNYUINRRK-KEY3"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
               MOVE    PTNYUINRRK-RRKNUM
                                       TO  SPA-NAI-I01-PTRRKNUM
               MOVE    PTNYUINRRK-RRKEDANUM
                                       TO  SPA-NAI-I01-PTRRKEDANUM
           ELSE
               MOVE    1           TO  FLG-PTNYUINRRK
           END-IF
      *
      *    入院履歴クローズ
           MOVE    "PTNYUINRRK-KEY3"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4101-PTNYUINRRK-SEL1-EXT.
           EXIT.
      *****************************************************************
      *    入力領域編集処理
      *****************************************************************
       4101-INPUT-AREA-EDIT-SEC        SECTION.
      *
      *    入力領域初期化
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           MOVE    ZERO            TO  SPA-NAI-I01-TAINRRK-FLG
      *
      *    前回異動日
           MOVE    PTNYUINRRK-TENNYUYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
      *
           IF      ( PTNYUINRRK-JTIKBN       = "2" OR "3" OR "4" )
            AND    ( PTNYUINRRK-TAIINYMD     = "99999999" )
               MOVE    WRK-HENYMDG TO  SPA-GMN-I01-MAEIDOYMD
           END-IF
      *
           MOVE    WRK-SYMD        TO  SPA-NAI-I01-MAEIDOYMD
      *
      *    保険組み合わせコンボ設定処理
           MOVE    PTNYUINRRK-TENNYUYMD
                                   TO  WRK-KJNYMD
           PERFORM 4101-CMB-HKNCOMBI-SET-SEC
      *
      *    病室番号
           MOVE   PTNYUINRRK-BRMNUM ( 3 : 6 )
                                   TO  WRK-BRMNUM-IN
           PERFORM 4101-BRMNUM-LEFT-EDIT-SEC
           MOVE   WRK-BRMNUM-OT    TO  SPA-GMN-I01-BRMNUM
                                       SPA-NAI-I01-BRMNUM-MAE
                                       SPA-NAI-I01-BRMNUM-MOT
      *
      *    病室情報より病棟コンボ編集
           PERFORM 4101-BRMNUM-SEL-SEC
      *
      *    病棟番号
           MOVE    PTNYUINRRK-BTUNUM
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-BTUNAME-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-BTUNAME
                                       SPA-NAI-I01-BTUNAME-MAE
                                       SPA-NAI-I01-BTUNAME-MOT
      *
      *    入院科
           MOVE    PTNYUINRRK-NYUINKA
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-NYUINKA-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-NYUINKA
                                       SPA-NAI-I01-NYUINKA-MOT
      *
      *    保険組合せ番号
           MOVE    PTNYUINRRK-HKNCOMBINUM
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-HKNCOMBI-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-HKNCOMBI
           MOVE    WRK-CMB-ITM2    TO  SPA-NAI-I01-FTNRATE
      *
      *    入院日
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-NYUINYMD
           MOVE    WRK-SYMD        TO  SPA-NAI-I01-NYUINYMD
      *
      *    退院日
           IF    ( PTNYUINRRK-TAIINYMD     =   "99999999" )
               MOVE    SPACE           TO  SPA-GMN-I01-TAIINYMD
                                           SPA-NAI-I01-TAIINYMD
           ELSE
               MOVE    PTNYUINRRK-TAIINYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-TAIINYMD
               MOVE    WRK-SYMD        TO  SPA-NAI-I01-TAIINYMD
           END-IF
      *
      *    特定入院料コンボ設定処理
           PERFORM 4101-CMB-TOKNYUIN-SET-SEC
      *
      *    特定入院料
           MOVE    SPACE           TO  WRK-CMB-CD
           MOVE    PTNYUINRRK-TOKUTEI-KBN
                                   TO  WRK-CMB-CD (1 : 1)
           MOVE    PTNYUINRRK-TOKUTEI-NYUIN
                                   TO  WRK-CMB-CD (2 : 2)
      *
           PERFORM 4103-CMB-TOKNYUIN-SRH2-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-TOKNYUIN
           MOVE    WRK-CMB-ITM2    TO  SPA-NAI-I01-TOKNYUIN-ORG
      *
      *    室料差額
           MOVE    PTNYUINRRK-RM-SAGAKU
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-SAGAKU-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-SAGAKU
      *
      *    定期請求区分
           MOVE    PTNYUINRRK-TEIKI-SEIKYUKBN
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-SEIKYU-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-SEIKYU
      *
      *    検索表示区分
           MOVE    PTNYUINRRK-KENSAKU-DISPKBN
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-DISPKBN-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-DISPKBN
      *
      *    初回継続区分
           MOVE  PTNYUINRRK-SHOKAIKBN
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-SHOKAI-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-SHOKAI
      *
      *    初回番号
           MOVE    PTNYUINRRK-SHONUM
                                   TO  SPA-GMN-I01-SHONUM
      *    初回入院日
           PERFORM 4101-SHONYUINYMD-EDIT-SEC
      *
      *    担当医１
           MOVE    PTNYUINRRK-DRCD1 (2 : 4)
                                   TO  WRK-CMB-CD
           MOVE    1               TO  IDX1
           PERFORM 4103-CMB-DR-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-DR (1)
      *
      *    担当医２
           MOVE    PTNYUINRRK-DRCD2 (2 : 4) 
                                   TO  WRK-CMB-CD
           MOVE    2               TO  IDX1
           PERFORM 4103-CMB-DR-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-DR (2)
      *
      *    担当医３
           MOVE    PTNYUINRRK-DRCD3 (2 : 4)
                                   TO  WRK-CMB-CD
           MOVE    3               TO  IDX1
           PERFORM 4103-CMB-DR-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-DR (3)
       .
      *
       4101-INPUT-AREA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    初回入院日編集処理
      *****************************************************************
       4101-SHONYUINYMD-EDIT-SEC       SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-I01-NYUREKILST-CNT )
               IF    ( SPA-GMN-I01-SHONUM
                                   =   SPA-GMN-I01-TSHONUM (IDX1))
                   IF    ( SPA-GMN-I01-TSHOKAI (IDX1)  =   "◎" )
                       STRING "入院日 "
                              SPA-GMN-I01-TNYUINYMD (IDX1)
                       DELIMITED   BY  SIZE
                       INTO   SPA-GMN-I01-LBL-SHONYUINYMD
                       END-STRING
                       MOVE    SPA-GMN-I01-NYUREKILST-CNT
                                   TO  IDX1
                   END-IF
               END-IF
      *
           END-PERFORM
       .
      *
       4101-SHONYUINYMD-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入力領域編集処理（他院歴を編集）
      *****************************************************************
       4101-INPUT-AREA-EDIT2-SEC       SECTION.
      *
      *    入力領域初期化
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           MOVE    1               TO  SPA-NAI-I01-TAINRRK-FLG
      *
      *    病棟名称
           MOVE    PTNYUINRRK-BTUNAME
                                   TO  SPA-GMN-I01-BTUNAME
                                       SPA-NAI-I01-BTUNAME-MOT
      *
      *    入院日
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-NYUINYMD
           MOVE    WRK-SYMD        TO  SPA-NAI-I01-NYUINYMD
      *
      *    退院日
           IF    ( PTNYUINRRK-TAIINYMD     =   "99999999" )
               MOVE    SPACE           TO  SPA-GMN-I01-TAIINYMD
                                           SPA-NAI-I01-TAIINYMD
           ELSE
               MOVE    PTNYUINRRK-TAIINYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-TAIINYMD
               MOVE    WRK-SYMD        TO  SPA-NAI-I01-TAIINYMD
           END-IF
      *
      *    初回継続区分
           MOVE  PTNYUINRRK-SHOKAIKBN
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-SHOKAI-SRH-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-SHOKAI
      *
      *    初回番号
           MOVE    PTNYUINRRK-SHONUM
                                   TO  SPA-GMN-I01-SHONUM
      *    初回入院日
           PERFORM 4101-SHONYUINYMD-EDIT-SEC
      *
       .
      *
       4101-INPUT-AREA-EDIT2-EXT.
           EXIT.
      *****************************************************************
      *    病室番号左詰処理
      *****************************************************************
       4101-BRMNUM-LEFT-EDIT-SEC       SECTION.
      *
           IF    ( WRK-BRMNUM-IN (1 : 1)   =   SPACE )
               MOVE    SPACE           TO  WRK-STR1
               MOVE    1               TO  WRK-IDX1
               UNSTRING    WRK-BRMNUM-IN
                   DELIMITED   BY  ALL SPACE
                   INTO    WRK-STR1
                   WITH    POINTER WRK-IDX1
               END-UNSTRING
               MOVE    WRK-BRMNUM-IN (WRK-IDX1 : )
                                       TO  WRK-BRMNUM-EDT
           ELSE
               MOVE    WRK-BRMNUM-IN   TO  WRK-BRMNUM-EDT
           END-IF
      *
           PERFORM VARYING WRK-IDX1    FROM    6   BY  -1
               UNTIL     ( WRK-IDX1    <   1 )
                 OR      ( WRK-BRMNUM-EDT (WRK-IDX1 : 1)
                                   NOT =   SPACE )
               CONTINUE
           END-PERFORM
      *
           IF    ( WRK-IDX1    <   1 )
               MOVE    WRK-BRMNUM-EDT  TO  WRK-BRMNUM-OT
               GO  TO  4101-BRMNUM-LEFT-EDIT-EXT
           END-IF
      *
      *    病室番号が数字の場合前ゼロをとる
           IF    ( WRK-BRMNUM-EDT ( 1 : WRK-IDX1 )
                                       IS  NUMERIC )
               IF    ( WRK-BRMNUM-EDT ( 1 : 1 )
                                       =   ZERO )
                   MOVE    1               TO  WRK-IDX2
                   MOVE    SPACE           TO  WRK-STR1
                   UNSTRING    WRK-BRMNUM-EDT
                       DELIMITED BY  ALL ZERO
                   INTO    WRK-STR1
                   WITH    POINTER WRK-IDX2
                   END-UNSTRING
                   MOVE    WRK-BRMNUM-EDT (WRK-IDX2 : )
                                           TO  WRK-BRMNUM-OT
               ELSE
                   MOVE    WRK-BRMNUM-EDT  TO  WRK-BRMNUM-OT
               END-IF
           ELSE
                   MOVE    WRK-BRMNUM-EDT  TO  WRK-BRMNUM-OT
           END-IF
      *
           .
       4101-BRMNUM-LEFT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴編集処理
      *****************************************************************
       4101-NYUREKI-EDIT-SEC       SECTION.
      *
      *    患者履歴マスタ検索
           PERFORM 4101-PTNYUINRRK-SEL2-SEC
      *
      *    主病名編集処理
           PERFORM 4101-SYUBYOMEI-EDIT-SEC
      *
      *    日数編集処理
           PERFORM 4101-NISSU-EDIT-SEC
      *
           .
       4101-NYUREKI-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴編集処理（入院歴表示用）
      *****************************************************************
       4101-PTNYUINRRK-SEL2-SEC        SECTION.
      *
      *
           INITIALIZE  PTNYUINRRK-REC
                       SPA-GMN-I01-NYUREKILST-AREA
                       SPA-NAI-I01-NYUREKILST-AREA
                       WRK-REKI-BYOMEI-EDIT-AREA
      *
           MOVE    SPA-HOSPID      TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-I01-PTID
                                   TO  PTNYUINRRK-PTID
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
      *
      *    入院履歴検索処理
           MOVE    "PTNYUINRRK-KEY2"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1            >   50   )
               OR        ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
               MOVE    IDX1        TO  SPA-GMN-I01-NYUREKILST-CNT
      *
      *
      *        入院歴リスト編集
               IF    ( PTNYUINRRK-JTIKBN   NOT =   "5" )
                   PERFORM 4101-NYUREKILST-EDIT-SEC
               ELSE
                   PERFORM 4101-NYUREKILST-EDIT2-SEC
               END-IF
      *
      *        入院履歴検索処理
               MOVE    "PTNYUINRRK-KEY2"
                                   TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    入院履歴クローズ
           MOVE    "PTNYUINRRK-KEY2"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4101-PTNYUINRRK-SEL2-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報検索処理
      *****************************************************************
       4101-PTINF-SELECT-SEC              SECTION.
      *
      *    患者マスタ検索
           INITIALIZE  PTINF-REC
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
      *
           MOVE    "PTINF-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
      *
      *        患者情報設定
               PERFORM 4101-PTINF-SET-SEC
           END-IF
      *
      *    患者マスタクローズ
           MOVE    "PTINF-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *
           .
       4101-PTINF-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    患者情報設定処理
      *****************************************************************
       4101-PTINF-SET-SEC              SECTION.
      *
           MOVE    MCPDATA-REC     TO  PTINF-REC
      *    患者ＩＤ
           MOVE    PTINF-PTID      TO  SPA-NAI-I01-PTID
      *    患者氏名
           MOVE    PTINF-NAME      TO  SPA-GMN-I01-NAME
      *    患者カナ氏名
           MOVE    PTINF-KANANAME  TO  SPA-NAI-I01-KANANAME
      *    患者性別
           EVALUATE    PTINF-SEX
           WHEN    "1"
               MOVE    "男"        TO  SPA-GMN-I01-SEX
           WHEN    "2"
               MOVE    "女"        TO  SPA-GMN-I01-SEX
           END-EVALUATE
      *    患者生年月日
           MOVE    PTINF-BIRTHDAY  TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-BIRTHDAY
           MOVE    PTINF-BIRTHDAY  TO  SPA-NAI-I01-BIRTHDAY
      *    患者年齢
           MOVE    PTINF-BIRTHDAY  TO  WRK-BIRTHDAY
           PERFORM 4101-AGE-CALC-SEC
      *
           MOVE    WRK-AGE-G       TO  SPA-GMN-I01-AGE
      *
           MOVE    WIDGET-INSENSITIVE
                                       TO  SPA-GMN-I01-IDOYMD-STT
      *
      *
      *    入院履歴編集処理
           PERFORM 4101-NYUREKI-EDIT-SEC
      *
           MOVE    ZERO                TO  FLG-SYORIPTN
      *
      *    入院履歴マスタ検索処理（入力領域表示用）
           PERFORM 4101-PTNYUINRRK-SEL1-SEC
      *    入院歴なし（初入院）
           IF  (   FLG-PTNYUINRRK  NOT =   ZERO )
               MOVE    1               TO  FLG-SYORIPTN
           ELSE
      *
               EVALUATE    TRUE
      *        他院歴あり
               WHEN    PTNYUINRRK-JTIKBN   =   "5"
                   MOVE    2           TO  FLG-SYORIPTN
      *        入院中
               WHEN    PTNYUINRRK-TAIINYMD =   "99999999"
                   MOVE    3           TO  FLG-SYORIPTN
      *        退院済み
               WHEN    OTHER
                   MOVE    4           TO  FLG-SYORIPTN
               END-EVALUATE
           END-IF
      *
           EVALUATE    FLG-SYORIPTN
           WHEN    1
               MOVE    3           TO  SPA-GMN-I01-CUR
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4101-WIDGET-NYUIN-STT-SEC
      *        保険組み合わせコンボ設定処理
               MOVE    SPA-SYSYMD      TO  WRK-KJNYMD
               PERFORM 4101-CMB-HKNCOMBI-SET-SEC
      *        受付マスタより入院科等を確定する
               MOVE    SPA-SYSYMD  TO  WRK-KJNYMD
               PERFORM 4101-UKETUKE-SEL-SEC
      *        受診履歴検索処理
               MOVE    SPA-SYSYMD  TO  WRK-KJNYMD
               PERFORM 4101-JYURRK-SEL-SEC
               PERFORM 310-CMB-SYORIKBN-SET2-SEC
      *        デフォルトの処理区分に入院登録を設定
               MOVE    SPA-GMN-I01-SYORIKBN-ITM (01)
                                   TO  SPA-GMN-I01-SYORIKBN
           WHEN    2
               MOVE    2           TO  SPA-GMN-I01-CUR
      *
               PERFORM 4101-INPUT-AREA-EDIT2-SEC
               PERFORM 4201-WIDGET-INSENSITIVE-SEC
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-I01-B07-STT
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-I01-B08-STT
               PERFORM 310-CMB-SYORIKBN-SET5-SEC
      *        デフォルトの処理区分に照会を設定
               MOVE    SPA-GMN-I01-SYORIKBN-ITM (02)
                                   TO  SPA-GMN-I01-SYORIKBN
      *
      *
           WHEN    3
               MOVE    2               TO  SPA-GMN-I01-CUR
               PERFORM 4101-INPUT-AREA-EDIT-SEC
               PERFORM 310-CMB-SYORIKBN-SET3-SEC
               PERFORM 4101-WIDGET-HENKOU-STT-SEC
      *        デフォルトの処理区分に変更を設定
               MOVE    SPA-GMN-I01-SYORIKBN-ITM (02)
                                   TO  SPA-GMN-I01-SYORIKBN
           WHEN    4
               MOVE    2               TO  SPA-GMN-I01-CUR
               PERFORM 4101-INPUT-AREA-EDIT-SEC
               PERFORM 4201-WIDGET-INSENSITIVE-SEC
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-I01-B07-STT
               MOVE    WIDGET-NORMAL
                                   TO  SPA-GMN-I01-B08-STT
      *
               PERFORM 310-CMB-SYORIKBN-SET4-SEC
      *        デフォルトの処理区分に照会を設定
               MOVE    SPA-GMN-I01-SYORIKBN-ITM (02)
                                   TO  SPA-GMN-I01-SYORIKBN
      *
           END-EVALUATE
      *
           IF    ( SPA-GMN-I01-NYUREKILST-CNT  >   ZERO )
               MOVE    1           TO  SPA-GMN-I01-NYUREKILST-SEL
                                       SPA-GMN-I01-SELNUM
           END-IF
      *
           MOVE    SPA-GMN-I01-PTNUM   TO  SPA-LAST-PTNUM
           MOVE    SPA-NAI-I01-PTID    TO  SPA-LAST-PTID
      *
           .
      *
       4101-PTINF-SET-EXT.
           EXIT.
      *****************************************************************
      *    受付マスタ検索処理
      *****************************************************************
       4101-UKETUKE-SEL-SEC            SECTION.
      
      *
      *    受付マスタ検索
           MOVE    SPACE               TO  UKETUKE-REC
           INITIALIZE                  UKETUKE-REC
           MOVE    SPA-HOSPID          TO  UKE-HOSPID
           MOVE    WRK-KJNYMD          TO  UKE-UKEYMD
           MOVE    SPA-NAI-I01-PTID    TO  UKE-PTID
      *
           MOVE    UKETUKE-REC         TO  MCPDATA-REC
           MOVE    "UKETUKE-KEY2"      TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           MOVE    ZERO                TO  FLG-UKETUKEGAITO   
      *
           PERFORM UNTIL ( FLG-DBRC    NOT =   ZERO )
               OR        ( FLG-UKETUKEGAITO
                                       NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  UKETUKE-REC
      *
      *        会計のまだの最初の受付を対象とする
               IF    ( UKE-KAIKEITIME  =   ZERO )
                   IF    ( SPA-GMN-I01-NYUINKA =   SPACE   )
                       MOVE    1               TO  FLG-UKETUKEGAITO
                       MOVE    UKE-SRYKA       TO  WRK-CMB-CD
                       PERFORM 4103-CMB-NYUINKA-SRH-SEC
                       MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-NYUINKA
                   END-IF
      *
                   IF    ( SPA-GMN-I01-DR (1)  =   SPACE   )
                       MOVE    UKE-DRCD (2 : 4)
                                               TO  WRK-CMB-CD
                       MOVE    1               TO  IDX1
                       PERFORM 4103-CMB-DR-SRH-SEC
                       MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-DR (1)
                   END-IF
               END-IF
      *
               MOVE    "UKETUKE-KEY2"          TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
           END-PERFORM
      *
           MOVE    "UKETUKE-KEY2"      TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       4101-UKETUKE-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院歴リスト編集処理
      *****************************************************************
       4101-NYUREKILST-EDIT-SEC        SECTION.
      *
      *    自院他院フラグ
           MOVE    ZERO            TO  SPA-NAI-I01-TZITA-FLG (IDX1)
      *
      *    入院歴
           MOVE    PTNYUINRRK-RRKNUM
                                   TO  SPA-NAI-I01-TRRKNUM (IDX1)
      *    選択番号
           MOVE    IDX1            TO  SPA-GMN-I01-TSELNUM (IDX1)
      *
      *    初
           IF    ( PTNYUINRRK-SHOKAIKBN
                                   =   "1" )
               MOVE    "◎"        TO  SPA-GMN-I01-TSHOKAI (IDX1)
           END-IF
      *
      *    初回番号
           MOVE    PTNYUINRRK-SHONUM
                                   TO  SPA-GMN-I01-TSHONUM (IDX1)
      *
      *    病棟
           INITIALIZE  SYSKANRI-REC
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    PTNYUINRRK-BTUNUM
                                   TO  SYS-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5001-REC
               MOVE    SYS-5001-BTU-NAME
                                   TO  SPA-GMN-I01-TBTUNAME (IDX1)
           END-IF
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    病室番号
           IF    ( PTNYUINRRK-BRMNUM (3 : 6)
                                   IS  NUMERIC )
               MOVE    PTNYUINRRK-BRMNUM (3 : 6)
                                   TO   WRK-999999
               MOVE    WRK-999999
                                   TO   WRK-ZZZZZ9
               MOVE    WRK-ZZZZZ9
                                   TO  SPA-GMN-I01-TBRMNUM (IDX1)
           ELSE
               MOVE    PTNYUINRRK-BRMNUM ( 3 : 6 )
                                   TO  SPA-GMN-I01-TBRMNUM (IDX1)
           END-IF
      *
      *    入院日
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-TNYUINYMD (IDX1)
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  SPA-NAI-I01-TNYUINYMD (IDX1)
      *
      *    退院日（最新の情報を取得）
           INITIALIZE              WKPTNYUINRRK-REC
           MOVE    PTNYUINRRK-KEY
                               TO  WKPTNYUINRRK-KEY
           MOVE    WKPTNYUINRRK-REC
                               TO  MCPDATA-REC
      *
           MOVE    "PTNYUINRRK-KEY4"
                               TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  WKPTNYUINRRK-REC
               IF    ( WKPTNYUINRRK-TAIINYMD   =   "99999999" )
                   MOVE    SPACE   TO  SPA-GMN-I01-TTAIINYMD (IDX1)
                                       SPA-NAI-I01-TTAIINYMD (IDX1)
               ELSE
                   MOVE    WKPTNYUINRRK-TAIINYMD
                                       TO  WRK-YMD
                   PERFORM 5002-HIZUKE-CHK-SEC
                   MOVE    WRK-HENYMDG TO  SPA-GMN-I01-TTAIINYMD (IDX1)
                   MOVE    WKPTNYUINRRK-TAIINYMD
                                       TO  SPA-NAI-I01-TTAIINYMD (IDX1)
               END-IF
           END-IF
      *
           MOVE    "PTNYUINRRK-KEY4"
                               TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    診療科
           INITIALIZE  SYSKANRI-REC
           MOVE    "1005"          TO  SYS-KANRICD
           MOVE    PTNYUINRRK-NYUINKA
                                   TO  SYS-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-1005-REC
               MOVE    SYS-1005-SRYKANAME
                                   TO  SPA-GMN-I01-TNYUINKA (IDX1)
           END-IF
           MOVE    "SYSKANRI-KEY"  TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *------------
           MOVE    ZERO            TO  WRK-REKI-BYO-ZITA-FLG (IDX1)
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-REKI-BYO-NYUINYMD  (IDX1)
      *
           IF    ( WKPTNYUINRRK-TAIINYMD   =   "99999999" )
               MOVE    "99999999"
                                   TO  WRK-REKI-BYO-TAIINYMD (IDX1)
           ELSE
               MOVE    WKPTNYUINRRK-TAIINYMD
                                   TO  WRK-REKI-BYO-TAIINYMD (IDX1)
           END-IF
      *
           MOVE    PTNYUINRRK-NYUINKA
                                   TO  WRK-REKI-BYO-NYUINKA (IDX1)
      *
           .
      *
       4101-NYUREKILST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院歴リスト編集処理(他院歴を編集)
      *****************************************************************
       4101-NYUREKILST-EDIT2-SEC       SECTION.
      *
      *    自院他院フラグ
           MOVE    1               TO  SPA-NAI-I01-TZITA-FLG (IDX1)
      *
      *    入院歴
           MOVE    PTNYUINRRK-RRKNUM
                                   TO  SPA-NAI-I01-TRRKNUM (IDX1)
      *    選択番号
           MOVE    IDX1            TO  SPA-GMN-I01-TSELNUM (IDX1)
      *
      *    初
           IF    ( PTNYUINRRK-SHOKAIKBN
                                   =   "1" )
               MOVE    "◎"        TO  SPA-GMN-I01-TSHOKAI (IDX1)
           END-IF
      *
      *    初回番号
           MOVE    PTNYUINRRK-SHONUM
                                   TO  SPA-GMN-I01-TSHONUM (IDX1)
      *
      *    病棟
           MOVE    PTNYUINRRK-BTUNAME
                                   TO  SPA-GMN-I01-TBTUNAME (IDX1)
      *
      *    入院日
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-TNYUINYMD (IDX1)
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  SPA-NAI-I01-TNYUINYMD (IDX1)
      *
      *    退院日（最新の情報を取得）
           IF    ( PTNYUINRRK-TAIINYMD     =   "99999999" )
               MOVE    SPACE       TO  SPA-GMN-I01-TTAIINYMD (IDX1)
                                       SPA-NAI-I01-TTAIINYMD (IDX1)
           ELSE
               MOVE    PTNYUINRRK-TAIINYMD
                                   TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-I01-TTAIINYMD (IDX1)
      *
               MOVE    PTNYUINRRK-TAIINYMD
                                   TO  SPA-NAI-I01-TTAIINYMD (IDX1)
           END-IF
      *
      *    通算対象日数
           MOVE    PTNYUINRRK-TAISYONISSU
                                   TO  SPA-NAI-I01-TTAINTAISYO (IDX1)
      *
      *    病名
           INITIALIZE  PTTAINFUKA-REC
           MOVE    SPA-HOSPID      TO  PTTAINFUKA-HOSPID
           MOVE    PTNYUINRRK-PTID
                                   TO  PTTAINFUKA-PTID
           MOVE    PTNYUINRRK-RRKNUM
                                   TO  PTTAINFUKA-RRKNUM
           MOVE    PTTAINFUKA-REC  TO  MCPDATA-REC
           MOVE    "PTTAINFUKA-KEY"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        =   ZERO )
               MOVE    MCPDATA-REC TO  PTTAINFUKA-REC
               MOVE    PTTAINFUKA-BYOMEI (1)
                                   TO  WRK-REKI-BYO-BYOMEI (IDX1)
           END-IF
      *
           MOVE    "PTTAINFUKA-KEY"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           MOVE    1               TO  WRK-REKI-BYO-ZITA-FLG (IDX1)
           MOVE    SPACE           TO  WRK-REKI-BYO-NYUINYMD  (IDX1)
                                       WRK-REKI-BYO-TAIINYMD (IDX1)
                                       WRK-REKI-BYO-TAIINYMD  (IDX1)
                                       WRK-REKI-BYO-NYUINKA (IDX1)
           .
      *
       4101-NYUREKILST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    主病名編集処理
      *****************************************************************
       4101-SYUBYOMEI-EDIT-SEC        SECTION.
      *
      *    患者病名マスタ検索
           INITIALIZE  PTBYOMEI-REC
           MOVE    SPA-HOSPID          TO  PTBYO-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  PTBYO-PTID
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "PTBYOMEI-KEY3"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM UNTIL ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  PTBYOMEI-REC
      *
      *        入院病名のみを対象とする
               IF    ( PTBYO-NYUGAIKBN =   "1" )
      *            対象の主病名をワークエリアに退避する
                   PERFORM 4101-SYUBYOMEI-TAIHI-SEC
               END-IF
      *
      *        患者病名マスタ読み込み
               MOVE    "PTBYOMEI-KEY3" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    患者病名マスタクローズ
           MOVE    "PTBYOMEI-KEY3"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    入院歴リストの主病名の編集を行う
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-NYUREKILST-CNT )
      *
               IF    ( WRK-REKI-BYO-BYOMEI (IDX1)  NOT =   SPACE )
                   MOVE    WRK-REKI-BYO-BYOMEI (IDX1)
                                       TO  SPA-GMN-I01-TBYOMEI (IDX1)
                   EVALUATE    WRK-REKI-BYO-TENKIKBN (IDX1)
                   WHEN "1"
                       MOVE    "治ゆ"  TO  SPA-GMN-I01-TTENKI (IDX1)
                   WHEN "2"
                       MOVE    "死亡"  TO  SPA-GMN-I01-TTENKI (IDX1)
                   WHEN "3"
                       MOVE    "中止"  TO  SPA-GMN-I01-TTENKI (IDX1)
                   WHEN "4"
                       MOVE    "移行"  TO  SPA-GMN-I01-TTENKI (IDX1)
                   END-EVALUATE
               END-IF
      *
           END-PERFORM
      *
           .
      *
       4101-SYUBYOMEI-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    主病名退避処理
      *****************************************************************
       4101-SYUBYOMEI-TAIHI-SEC        SECTION.
      *
      *    入院時の診療科で、入院期間中に診療開始日がある
      *    主病名で、日付が最も古いものを取得する
           SET     WRK-RRKBYO-IDX  TO  1
           SEARCH  WRK-REKI-BYOMEI-EDIT-OCC
               VARYING WRK-RRKBYO-IDX
           WHEN  ( WRK-RRKBYO-IDX  >  SPA-GMN-I01-NYUREKILST-CNT )
               CONTINUE
           WHEN  ( WRK-REKI-BYO-ZITA-FLG (WRK-RRKBYO-IDX)
                                   =  ZERO             )
             AND ( WRK-REKI-BYO-NYUINYMD (WRK-RRKBYO-IDX)
                                  <=   PTBYO-SRYYMD    )
             AND ( WRK-REKI-BYO-TAIINYMD (WRK-RRKBYO-IDX)
                                  >=   PTBYO-SRYYMD    )
             AND ( WRK-REKI-BYO-NYUINKA  (WRK-RRKBYO-IDX)
                                   =   PTBYO-SRYKA     )
             AND ( PTBYO-SYUBYOFLG =   "1"             )
      *
               MOVE    ZERO        TO  FLG-TAISYO
               EVALUATE    TRUE
               WHEN    ( WRK-REKI-BYO-SRYYMD (WRK-RRKBYO-IDX)
                                   = SPACE )
                   MOVE    1       TO  FLG-TAISYO
               WHEN    ( WRK-REKI-BYO-SRYYMD (WRK-RRKBYO-IDX)
                                   >   PTBYO-SRYYMD    )
                   MOVE    1       TO  FLG-TAISYO
               WHEN    ( WRK-REKI-BYO-SRYYMD (WRK-RRKBYO-IDX)
                                   =   PTBYO-SRYYMD    )
      *            同一日の場合は連番の小さい方を取得
                   IF  ( WRK-REKI-BYO-RENNUM (WRK-RRKBYO-IDX)
                                   >   PTBYO-RENNUM )
                       MOVE    1       TO  FLG-TAISYO
                   END-IF
      *
               END-EVALUATE
      *
      *
               IF    ( FLG-TAISYO  =   "1" )
                   MOVE    PTBYO-RENNUM
                       TO  WRK-REKI-BYO-RENNUM (WRK-RRKBYO-IDX)
                   MOVE    PTBYO-SRYYMD
                       TO  WRK-REKI-BYO-SRYYMD (WRK-RRKBYO-IDX)
                   MOVE    PTBYO-BYOMEI
                       TO  WRK-REKI-BYO-BYOMEI (WRK-RRKBYO-IDX)
                   MOVE    PTBYO-TENKIKBN
                       TO  WRK-REKI-BYO-TENKIKBN (WRK-RRKBYO-IDX)
               END-IF
      *
           END-SEARCH
           .
      *
       4101-SYUBYOMEI-TAIHI-EXT.
           EXIT.
      *****************************************************************
      *    日数編集処理処理
      *****************************************************************
       4101-NISSU-EDIT-SEC             SECTION.
      *
           PERFORM VARYING IDX1
                   FROM    SPA-GMN-I01-NYUREKILST-CNT
                   BY      -1
                   UNTIL ( IDX1    <   1 )
      *
               IF    ( SPA-GMN-I01-TSHOKAI (IDX1)  =   "◎" )
                   MOVE    ZERO    TO  WRK-TSUSAN
                   PERFORM VARYING IDX2    FROM    IDX1    BY  -1
                           UNTIL ( IDX2    <   1 )
      *
                       PERFORM 4101-NISSU-EDIT2-SEC
      *
                   END-PERFORM
               END-IF
           END-PERFORM
      *
           .
       4101-NISSU-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    日数編集処理処理（対象チェック）
      *****************************************************************
       4101-NISSU-EDIT2-SEC            SECTION.
      *
           IF    ( SPA-GMN-I01-TSHONUM (IDX1)
                               NOT     =   SPA-GMN-I01-TSHONUM (IDX2) )
               GO  TO  4101-NISSU-EDIT2-EXT
           END-IF
      *
           IF    ( IDX2    =   1 )
             AND ( SPA-NAI-I01-TNYUINYMD (IDX2)
                               =   SPACE )
               GO  TO  4101-NISSU-EDIT2-EXT
           END-IF
      *
           MOVE    SPA-NAI-I01-TNYUINYMD (IDX2)
                           TO  WRK-STYMD
           MOVE    SPA-NAI-I01-TTAIINYMD (IDX2)
                           TO  WRK-EDYMD
           PERFORM 5002-KIKAN-CALC-SEC
           IF    ( FLG-ORCSDAY =   ZERO )
               IF    ( SPA-NAI-I01-TZITA-FLG (IDX2)
                               =   ZERO )
                   MOVE    WRK-NISSU2
                               TO  WRK-NISSU
      *
                   IF    ( SPA-GMN-I01-NYUREKILST-CNT
                                       >   IDX2 )
                    AND  ( SPA-NAI-I01-TNYUINYMD (IDX2)
                       =   SPA-NAI-I01-TTAIINYMD (IDX2 + 1) )
                       COMPUTE WRK-TSUSAN
                           =   WRK-TSUSAN  +   WRK-NISSU2  -   1
                   ELSE
                       COMPUTE WRK-TSUSAN
                           =   WRK-TSUSAN  +   WRK-NISSU2
                   END-IF
      *
               ELSE
                   MOVE    SPA-NAI-I01-TTAINTAISYO (IDX2)
                               TO  WRK-NISSU
                   IF    ( SPA-GMN-I01-NYUREKILST-CNT
                                       >   IDX2 )
                    AND  ( SPA-NAI-I01-TNYUINYMD (IDX2)
                       =   SPA-NAI-I01-TTAIINYMD (IDX2 + 1)
                    AND    SPA-NAI-I01-TTAINTAISYO (IDX2)
                                       =   WRK-NISSU2 )
                       COMPUTE WRK-TSUSAN
                           =   WRK-TSUSAN
                           +   SPA-NAI-I01-TTAINTAISYO (IDX2)
                           -   1
                   ELSE
                       COMPUTE WRK-TSUSAN
                           =   WRK-TSUSAN
                           +   SPA-NAI-I01-TTAINTAISYO (IDX2)
                   END-IF
      *
               END-IF
               MOVE    WRK-NISSU   TO  WRK-ZZZZ9
               MOVE    WRK-ZZZZ9   TO  SPA-GMN-I01-TNISSU (IDX2)
               MOVE    WRK-TSUSAN  TO  WRK-ZZZZ9
               MOVE    WRK-ZZZZ9   TO  SPA-GMN-I01-TTUSAN (IDX2)
           END-IF
      *
           .
       4101-NISSU-EDIT2-EXT.
           EXIT.
      *****************************************************************
      *    年齢算出処理
      *****************************************************************
       4101-AGE-CALC-SEC               SECTION.
      *
           IF  (   WRK-BIRTHDAY    <   SPA-SYSYMD )
               MOVE    WRK-BIRTHDAY    TO  WRK-CALC-YMD1
               MOVE    SPA-SYSYMD      TO  WRK-CALC-YMD2
           ELSE
               MOVE    SPA-SYSYMD      TO  WRK-CALC-YMD1
               MOVE    WRK-BIRTHDAY    TO  WRK-CALC-YMD2
           END-IF
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
      *
           IF    ( WRK-CALC-DD1        >   WRK-CALC-DD2 )
               COMPUTE WRK-AGE-MM      =   WRK-AGE-MM
                                       -   1
           END-IF
      *
           IF  (   WRK-BIRTHDAY    <   SPA-SYSYMD )
               CONTINUE
           ELSE
               COMPUTE WRK-AGE-YY  =   WRK-AGE-YY
                                   *   -1
               COMPUTE WRK-AGE-MM  =   WRK-AGE-MM
                                   *   -1
           END-IF
      *
           IF    ( WRK-AGE-YY          =   ZERO )
               MOVE    WRK-AGE-MM      TO  WRK-AGE-Z
               MOVE    "ヶ月"          TO  WRK-AGE-MEI
           ELSE
               MOVE    WRK-AGE-YY      TO  WRK-AGE-Z
               MOVE    "才"            TO  WRK-AGE-MEI
           END-IF
      *
           .
       4101-AGE-CALC-EXT.
           EXIT.
      *****************************************************************
      *    保険組み合わせコンボ設定処理
      *****************************************************************
       4101-CMB-HKNCOMBI-SET-SEC       SECTION.
      *
           INITIALIZE                  SPA-GMN-I01-CMB-HKNCOMBI
                                       HKNCOMBI-REC
      *
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  COMB-PTID
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
      *
      *
      *    保険組み合わせマスタ検索
           MOVE    "HKNCOMBI-KEY2"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           MOVE    ZERO                TO  IDX1
           PERFORM UNTIL     ( IDX1           >=   30   )
                   OR        ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
      *
               MOVE    ZERO        TO  FLG-HKNCOMBICHK
               IF    ( COMB-DELKBN         =   "1" )
                   MOVE    1       TO  FLG-HKNCOMBICHK
               ELSE
                   IF    ( COMB-TEKSTYMD      <=   WRK-KJNYMD )
                    AND  ( COMB-TEKEDYMD      >=   WRK-KJNYMD )
                       CONTINUE
                   ELSE
                       MOVE    1   TO  FLG-HKNCOMBICHK
                   END-IF
               END-IF
      *
               IF    ( FLG-HKNCOMBICHK =   ZERO )
                   COMPUTE IDX1    =   IDX1    +   1
      *
                   MOVE    IDX1    TO  SPA-GMN-I01-HKNCOMBI-CNT
      *
                   MOVE    COMB-HKNCOMBINUM
                                   TO  SPA-GMN-I01-HKNCOMBI-ITM
                                                   (IDX1)(1 : 4)
      *
                   PERFORM 4101-HKNCOMBI-EDIT-SEC
      *
                   MOVE    WRK-HKNCOMBI
                                   TO  SPA-GMN-I01-HKNCOMBI-ITM
                                                   (IDX1)(6 : )
                   MOVE    WRK-FTNRATE
                                   TO  SPA-GMN-I01-HKNCOMBI-ITM2
                                                   (IDX1)
      *
               END-IF
      *
      *        保険組み合わせ読込
               MOVE    "HKNCOMBI-KEY2"     TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
           END-PERFORM
      *
      *    保険組み合わせクローズ
           MOVE    "HKNCOMBI-KEY2"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4101-CMB-HKNCOMBI-SET-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       4101-HKNCOMBI-EDIT-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNCOMBI
                                           WRK-FTNRATE
      *
           STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                   INTO                    WRK-HKNCOMBI
           END-STRING
      *
      *    主保険がないとき
           IF    ( COMB-SYU-TANSEIDONAME   =   SPACE )
               MOVE    SPACE           TO  WRK-HKNCOMBI
               STRING  COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                       COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                     DELIMITED  BY  SIZE
                       COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                     DELIMITED  BY  SIZE
                       COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                       INTO                    WRK-HKNCOMBI
           END-IF
      *
      *    労災の時、コメントの追加
           IF    ( COMB-HKNNUM         =   "971" OR "973")
               INITIALIZE                      PTRSIINF-REC
               MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
               MOVE    SPA-NAI-I01-PTID    TO  PTRSI-PTID
               MOVE    COMB-HKNID          TO  PTRSI-HKNID
               MOVE    PTRSIINF-REC        TO  MCPDATA-REC
               MOVE    "PTRSIINF-KEY"      TO  WRK-DBPATH
               PERFORM 900-TBL-SELECT-SEC
               IF    ( FLG-DBRC            =   ZERO )
      *
                   MOVE    MCPDATA-REC     TO  PTRSIINF-REC
      *
                   MOVE    SPACE               TO  WRK-HKNCOMBI
                   MOVE    SPACE               TO  WRK-HKNKBN-MEI
                   EVALUATE    PTRSI-HKNKBN
                   WHEN    "1"
                       MOVE    "短"        TO  WRK-HKNKBN-MEI
                   WHEN    "2"
                       MOVE    "傷"        TO  WRK-HKNKBN-MEI
                   WHEN    "3"
                       MOVE    "ア"        TO  WRK-HKNKBN-MEI
                   END-EVALUATE
                   IF    ( PTRSI-COMMENT   =   SPACE )
                       MOVE    SPACE       TO  WRK-HKNCOMBI
                       STRING COMB-SYU-TANSEIDONAME
                                               DELIMITED   BY  SPACE
                              " "              DELIMITED   BY  SIZE
                              WRK-HKNKBN-MEI   DELIMITED   BY  SPACE
                              INTO              WRK-HKNCOMBI
                       END-STRING
      *
                   ELSE
                       STRING  COMB-SYU-TANSEIDONAME
                                               DELIMITED   BY  SPACE
                           " "                 DELIMITED   BY  SIZE
                           WRK-HKNKBN-MEI      DELIMITED   BY  SPACE
                           "（"                DELIMITED   BY  SIZE
                           PTRSI-COMMENT       DELIMITED   BY  SPACE
                           "）"                DELIMITED   BY  SIZE
                           INTO                WRK-HKNCOMBI
                       END-STRING
                   END-IF
               END-IF
      *        患者保険情報クローズ
               MOVE    "PTRSIINF-KEY"      TO  WRK-DBPATH
               PERFORM 900-TBL-CLOSE-SEC
           END-IF
      *
           MOVE    COMB-GAI-KFTNRATE       TO  WRK-ZZ9
           MOVE    WRK-ZZ9                 TO  WRK-FTNRATE (1 : 3)
           MOVE    "%"                     TO  WRK-FTNRATE (4 : )
      *
           .
       4101-HKNCOMBI-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴検索処理
      *****************************************************************
       4101-JYURRK-SEL-SEC           SECTION.
      *
           MOVE    SPACE           TO  WKJYURRK-REC
      *
      *    受診履歴検索
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID      TO  JYURRK-HOSPID
           MOVE    SPA-NAI-I01-PTID
                                   TO  JYURRK-PTID
           MOVE    WRK-KJNYMD      TO  JYURRK-SRYYMD
           MOVE    JYURRK-REC      TO  MCPDATA-REC
           MOVE    "JYURRK-KEY10"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM
               UNTIL ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC TO  JYURRK-REC  
      *
      *        最後の受診履歴を対象とする（診療日以前のもの）
               IF    ((SPA-GMN-I01-NYUINKA     NOT =   SPACE  )
                  AND (SPA-GMN-I01-NYUINKA-CD      =   JYURRK-SRYKA ) )
                OR    ( SPA-GMN-I01-NYUINKA        =   SPACE        )
                   IF    ( WRK-KJNYMD             >=   JYURRK-SRYYMD )
                           MOVE    JYURRK-REC      TO  WKJYURRK-REC
                   END-IF
               END-IF
      *
      *        受診履歴読込
               MOVE    "JYURRK-KEY10"      TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    受診履歴クローズ
           MOVE    "JYURRK-KEY10"      TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( WKJYURRK-REC        =   SPACE )
      *
               MOVE    ZERO            TO  FLG-JYUHKNCOMBISET
               IF    ( SPA-GMN-I01-HKNCOMBI    =   SPACE )
                   MOVE    1           TO  FLG-JYUHKNCOMBISET
               ELSE
                   MOVE    SPA-GMN-I01-HKNCOMBI-CD
                                       TO  WRK-CMB-CD
                   PERFORM 4103-CMB-HKNCOMBI-SRH-SEC
                   IF    ( WRK-CMB-ITM     NOT =   SPACE )
                       MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-HKNCOMBI
                       MOVE    WRK-CMB-ITM2
                                           TO  SPA-NAI-I01-FTNRATE
                   ELSE
                       MOVE    1       TO  FLG-JYUHKNCOMBISET
                   END-IF
               END-IF
      *
               IF    ( FLG-JYUHKNCOMBISET  =   1 )
                   IF    ( SPA-GMN-I01-HKNCOMBI-CNT
                                           NOT =   ZERO )
                       MOVE    SPA-GMN-I01-HKNCOMBI-ITM (1)
                                           TO  SPA-GMN-I01-HKNCOMBI
                   END-IF
               END-IF
               GO  TO  4101-JYURRK-SEL-EXT
           END-IF
      *
           MOVE    WKJYURRK-REC        TO  JYURRK-REC 
      *
      *    入院科
           IF    ( SPA-GMN-I01-NYUINKA =   SPACE )
               MOVE    JYURRK-SRYKA    TO  WRK-CMB-CD
               PERFORM 4103-CMB-NYUINKA-SRH-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-NYUINKA
           END-IF
      *
      *    主治医
           IF    ( SPA-GMN-I01-DR (1)  =   SPACE )
               MOVE    JYURRK-DRCD (2 : 4) 
                                       TO  WRK-CMB-CD
               MOVE    1               TO  IDX1
               PERFORM 4103-CMB-DR-SRH-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-DR (1)
           END-IF
      *
      *    保険組合せ
           MOVE    ZERO                TO  FLG-JYUHKNCOMBISET
      *
           IF    ( SPA-GMN-I01-HKNCOMBI    =   SPACE )
               MOVE    1               TO  FLG-JYUHKNCOMBISET
           ELSE
               MOVE    SPA-GMN-I01-HKNCOMBI-CD
                                       TO  WRK-CMB-CD
               PERFORM 4103-CMB-HKNCOMBI-SRH-SEC
               IF    ( WRK-CMB-ITM     NOT =   SPACE )
                   MOVE    WRK-CMB-ITM         TO  SPA-GMN-I01-HKNCOMBI
                   MOVE    WRK-CMB-ITM2        TO  SPA-NAI-I01-FTNRATE
               ELSE
                   MOVE    1           TO  FLG-JYUHKNCOMBISET
               END-IF
           END-IF
      *
           IF    ( FLG-JYUHKNCOMBISET  =   1 )
               MOVE    JYURRK-HKNCOMBINUM  TO  WRK-CMB-CD
               PERFORM 4103-CMB-HKNCOMBI-SRH-SEC
               IF    ( WRK-CMB-ITM     NOT =   SPACE )
                   MOVE    WRK-CMB-ITM     TO  SPA-GMN-I01-HKNCOMBI
                   MOVE    WRK-CMB-ITM2    TO  SPA-NAI-I01-FTNRATE
               ELSE
                   IF    ( SPA-GMN-I01-HKNCOMBI-CNT
                                           NOT =   ZERO )
                       MOVE    SPA-GMN-I01-HKNCOMBI-ITM (1)
                                           TO  SPA-GMN-I01-HKNCOMBI
                   END-IF
               END-IF
           END-IF
      *
           .
       4101-JYURRK-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理区分チェック処理
      *****************************************************************
       4101-SYORIKBN-CHK-SEC           SECTION.
      *
           MOVE    2               TO  SPA-GMN-I01-CUR
      *
           MOVE    SPACE           TO  SPA-GMN-I01-ERRCD (2)
      *
           MOVE    I01-SYORIKBN    TO  SPA-GMN-I01-SYORIKBN
      *
           IF    ( SPA-GMN-I01-SYORIKBN    =   SPACE )
               MOVE    "1002"      TO  SPA-ERRCD
               PERFORM 510-ERRCD-SET-SEC
               GO  TO  4101-SYORIKBN-CHK-EXT
           END-IF
      *
      *    処理区分サーチ
           MOVE    SPA-GMN-I01-SYORIKBN-CD
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-SYORIKBN-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-SYORIKBN
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               PERFORM 510-ERRCD-SET-SEC
               MOVE    2           TO  SPA-GMN-I01-CUR
               GO  TO  4101-SYORIKBN-CHK-EXT
           END-IF
      *
           MOVE    SPACE           TO  SPA-GMN-I01-IDOYMD
                                       SPA-NAI-I01-IDOYMD
      *
      *    他院歴ボタンの状態を退避
           MOVE    SPA-GMN-I01-B07-STT
                                   TO  WRK-WIDGET-B07-STT
           MOVE    SPA-GMN-I01-B08-STT
                                   TO  WRK-WIDGET-B08-STT
      *
           INITIALIZE              SPA-GMN-I01-INPUT-AREA
                                   SPA-NAI-I01-INPUT-AREA
      *
      *    入院履歴マスタ検索処理（入力領域表示用）
           PERFORM 4101-PTNYUINRRK-SEL1-SEC
           IF    ( FLG-PTNYUINRRK  =   ZERO  )
      *        入力領域編集処理
               IF    ( PTNYUINRRK-JTIKBN   NOT =   "5" )
                   PERFORM 4101-INPUT-AREA-EDIT-SEC
               ELSE
                   PERFORM 4101-INPUT-AREA-EDIT2-SEC
               END-IF
           END-IF
      *
           IF    ( FLG-PTNYUINRRK  NOT =   ZERO  )
            OR   ( SPA-GMN-I01-SYORIKBN-CD =   "01" )    
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *        保険組み合わせコンボ設定処理
               MOVE    SPA-SYSYMD      TO  WRK-KJNYMD
               PERFORM 4101-CMB-HKNCOMBI-SET-SEC
           END-IF
      *
      *    処理区分応じて画面編集の内容を変更する
           EVALUATE    SPA-GMN-I01-SYORIKBN-CD
      *    入院登録
           WHEN    "01"
      *        受付マスタより入院科等を確定する
               PERFORM 4101-UKETUKE-SEL-SEC
      *        受診履歴検索処理
               PERFORM 4101-JYURRK-SEL-SEC
               PERFORM 4101-WIDGET-NYUIN-STT-SEC
      *    退院登録
           WHEN    "02"
      *
      *        退院日にシステム日付か前回異動日で日付の新しい方を表示
               IF    ( SPA-SYSYMD      >   SPA-NAI-I01-MAEIDOYMD )
                   MOVE    SPA-SYSYMD      TO  WRK-YMD
               ELSE
                   MOVE    SPA-NAI-I01-MAEIDOYMD
                                           TO  WRK-YMD
               END-IF
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-TAIINYMD
               MOVE    WRK-SYMD        TO  SPA-NAI-I01-TAIINYMD
               PERFORM 4101-WIDGET-TAIIN-STT-SEC
      *    変更
           WHEN    "03"
               PERFORM 4101-WIDGET-HENKOU-STT-SEC
      *    照会
           WHEN    "04"
               PERFORM 4201-WIDGET-INSENSITIVE-SEC
      *    転科　転棟　転室
           WHEN    "08"
               PERFORM 4101-WIDGET-TENKA-STT-SEC
      *
      *        異動日にシステム日付か前回異動日で日付の新しい方を表示
               IF    ( SPA-SYSYMD      >   SPA-NAI-I01-MAEIDOYMD )
                   MOVE    SPA-SYSYMD      TO  WRK-YMD
               ELSE
                   MOVE    SPA-NAI-I01-MAEIDOYMD
                                           TO  WRK-YMD
               END-IF
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-IDOYMD
               MOVE    WRK-SYMD        TO  SPA-NAI-I01-IDOYMD
      *
      *    その他
           WHEN    OTHER
               PERFORM 4201-WIDGET-INSENSITIVE-SEC
               MOVE    WIDGET-NORMAL   TO  SPA-GMN-I01-B12-STT
           END-EVALUATE
      *
      *    他院歴ボタンの状態を元にもどす
           MOVE    WRK-WIDGET-B07-STT  TO  SPA-GMN-I01-B07-STT
           MOVE    WRK-WIDGET-B08-STT  TO  SPA-GMN-I01-B08-STT
      *
           IF    ( SPA-GMN-I01-NYUREKILST-CNT  >   ZERO )
               MOVE    1           TO  SPA-GMN-I01-NYUREKILST-SEL
                                       SPA-GMN-I01-SELNUM
           END-IF
      *
      *    保険組合せが存在していること
           IF    ( SPA-GMN-I01-SYORIKBN-CD     =   "01" )
               IF    ( SPA-GMN-I01-HKNCOMBI-CNT   >   ZERO )
                   CONTINUE
               ELSE
                   MOVE    "1021"      TO  SPA-ERRCD
                   MOVE    1           TO  SPA-GMN-I01-CUR
                   GO  TO  4101-SYORIKBN-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "04" )
               MOVE    2               TO  SPA-GMN-I01-CUR
           ELSE
               MOVE    4               TO  SPA-GMN-I01-CUR
           END-IF
      *
           .
      *
       4101-SYORIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院登録時入力可否設定処理
      *****************************************************************
       4101-WIDGET-NYUIN-STT-SEC       SECTION.
      *
           PERFORM 4201-WIDGET-STATE-CLEAR-SEC
      *
           MOVE    WIDGET-INSENSITIVE
                                   TO
                                       SPA-GMN-I01-IDOYMD-STT
                                       SPA-GMN-I01-TAIINYMD-STT
                                       SPA-GMN-I01-SHONUM-STT
      *
           .
      *
       4101-WIDGET-NYUIN-STT-EXT.
           EXIT.
      *****************************************************************
      *    退院登録時入力可否設定処理
      *****************************************************************
       4101-WIDGET-TAIIN-STT-SEC       SECTION.
      *
           PERFORM 4201-WIDGET-STATE-CLEAR-SEC
      *
           MOVE    WIDGET-INSENSITIVE
                                   TO
                                       SPA-GMN-I01-B07-STT
                                       SPA-GMN-I01-B08-STT
                                       SPA-GMN-I01-IDOYMD-STT
                                       SPA-GMN-I01-BRMNUM-STT
                                       SPA-GMN-I01-BTUNAME-STT
                                       SPA-GMN-I01-BTUNAME-ITM-STT
                                       SPA-GMN-I01-SAGAKU-STT
                                       SPA-GMN-I01-SAGAKU-ITM-STT
                                       SPA-GMN-I01-NYUINYMD-STT
                                       SPA-GMN-I01-NYUINKA-STT
                                       SPA-GMN-I01-NYUINKA-ITM-STT
                                       SPA-GMN-I01-SHOKAI-STT
                                       SPA-GMN-I01-SHOKAI-ITM-STT
                                       SPA-GMN-I01-SHONUM-STT
                                       SPA-GMN-I01-DR-STT (1)
                                       SPA-GMN-I01-DR-ITM-STT (1)
                                       SPA-GMN-I01-DR-STT (2)
                                       SPA-GMN-I01-DR-ITM-STT (2)
                                       SPA-GMN-I01-DR-STT (3)
                                       SPA-GMN-I01-DR-ITM-STT (3)
                                       SPA-GMN-I01-HKNCOMBI-STT
                                       SPA-GMN-I01-HKNCOMBI-ITM-STT
                                       SPA-GMN-I01-TOKNYUIN-STT
                                       SPA-GMN-I01-TOKNYUIN-ITM-STT
                                       SPA-GMN-I01-MAEUKE-STT
                                       SPA-GMN-I01-SEIKYU-STT
                                       SPA-GMN-I01-SEIKYU-ITM-STT
                                       SPA-GMN-I01-DISPKBN-STT
                                       SPA-GMN-I01-DISPKBN-ITM-STT
      *
           .
      *
       4101-WIDGET-TAIIN-STT-EXT.
           EXIT.
      *****************************************************************
      *    変更時入力可否設定処理
      *****************************************************************
       4101-WIDGET-HENKOU-STT-SEC       SECTION.
      *
           PERFORM 4201-WIDGET-STATE-CLEAR-SEC
      *
           MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-I01-B07-STT
                                       SPA-GMN-I01-B08-STT
                                       SPA-GMN-I01-IDOYMD-STT
                                       SPA-GMN-I01-BRMNUM-STT
                                       SPA-GMN-I01-BTUNAME-STT
                                       SPA-GMN-I01-BTUNAME-ITM-STT
                                       SPA-GMN-I01-SAGAKU-STT
                                       SPA-GMN-I01-SAGAKU-ITM-STT
                                       SPA-GMN-I01-NYUINYMD-STT
                                       SPA-GMN-I01-NYUINKA-STT
                                       SPA-GMN-I01-NYUINKA-ITM-STT
                                       SPA-GMN-I01-SHOKAI-STT
                                       SPA-GMN-I01-SHOKAI-ITM-STT
                                       SPA-GMN-I01-SHONUM-STT
                                       SPA-GMN-I01-TAIINYMD-STT
                                       SPA-GMN-I01-HKNCOMBI-STT
                                       SPA-GMN-I01-HKNCOMBI-ITM-STT
                                       SPA-GMN-I01-TOKNYUIN-STT
                                       SPA-GMN-I01-TOKNYUIN-ITM-STT
      *
           .
      *
       4101-WIDGET-TAIIN-STT-EXT.
           EXIT.
      *****************************************************************
      *    転科・転棟・転室時入力可否設定処理
      *****************************************************************
       4101-WIDGET-TENKA-STT-SEC       SECTION.
      *
           PERFORM 4201-WIDGET-STATE-CLEAR-SEC
      *
           MOVE    WIDGET-INSENSITIVE
                                   TO
                                       SPA-GMN-I01-B07-STT
                                       SPA-GMN-I01-B08-STT
                                       SPA-GMN-I01-NYUINYMD-STT
                                       SPA-GMN-I01-SHOKAI-STT
                                       SPA-GMN-I01-SHOKAI-ITM-STT
                                       SPA-GMN-I01-SHONUM-STT
                                       SPA-GMN-I01-TAIINYMD-STT
                                       SPA-GMN-I01-MAEUKE-STT
                                       SPA-GMN-I01-SEIKYU-STT
                                       SPA-GMN-I01-SEIKYU-ITM-STT
                                       SPA-GMN-I01-DISPKBN-STT
                                       SPA-GMN-I01-DISPKBN-ITM-STT
      *
           .
      *
       4101-WIDGET-TENKA-STT-EXT.
           EXIT.
      *****************************************************************
      *    異動日チェック処理
      *****************************************************************
       4101-IDOYMD-CHK-SEC             SECTION.
      *
           IF  ( SPA-GMN-I01-SYORIKBN-CD   NOT =   "08" )
               GO  TO  4101-IDOYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-NAI-I01-IDOYMD
                                       TO  WRK-IDOYMD
      *
           IF    ( SPA-GMN-I01-IDOYMD  =   SPACE )
               MOVE    SPA-SYSYMDWH    TO  SPA-GMN-I01-IDOYMD
               MOVE    SPA-SYSYMD      TO  SPA-NAI-I01-IDOYMD
           ELSE
               MOVE    SPA-GMN-I01-IDOYMD
                                       TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
      *
      *            エラーコードを設定（後続の処理は続行）
                   MOVE    "0001"      TO  SPA-ERRCD
                   MOVE    3           TO  SPA-GMN-I01-CUR
                   MOVE    WRK-IDOYMD  TO  WRK-YMD
                   PERFORM 5002-HIZUKE-CHK-SEC
               END-IF
      *
               MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-IDOYMD
               MOVE    WRK-SYMD        TO  SPA-NAI-I01-IDOYMD
           END-IF
      *
           IF  ( SPA-GMN-I01-SYORIKBN-CD   =   "08" )
               MOVE    SPA-NAI-I01-IDOYMD
                                   TO  WRK-KJNYMD
      *        保険組み合わせコンボ初期処理
               PERFORM 4101-CMB-HKNCOMBI-SET-SEC
      *        受付マスタ検索処理
               MOVE    SPA-NAI-I01-IDOYMD
                                   TO  WRK-KJNYMD
               PERFORM 4101-UKETUKE-SEL-SEC
      *        受診履歴検索処理
               MOVE    SPA-NAI-I01-IDOYMD
                                   TO  WRK-KJNYMD
               PERFORM 4101-JYURRK-SEL-SEC
           END-IF
      
      *
           .
      *
       4101-IDOYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室番号チェック処理
      *****************************************************************
       4101-BRMNUM-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-I01-BRMNUM  =   SPACE )
               INITIALIZE  SPA-GMN-I01-CMB-BTUNAME
                           SPA-GMN-I01-BTUNAME
               GO  TO  4101-BRMNUM-CHK-EXT
           END-IF
      *
      *    全角半角混在チェック
           MOVE    SPA-GMN-I01-BRMNUM
                                   TO  WRK-KANACHK-MAE-INPUT
      *
           PERFORM     800-ENRTRY-CHK-SEC
           IF  ( FLG-ENTRYCHK      NOT =   1 )
               MOVE    SPACE           TO  SPA-GMN-I01-BTUNAME
               MOVE    "0003"          TO  SPA-ERRCD
               MOVE    4               TO  SPA-GMN-I01-CUR
               GO  TO  4101-BRMNUM-CHK-EXT
           END-IF
      *
      *    左詰編集を行う
           MOVE    SPA-GMN-I01-BRMNUM  TO  WRK-BRMNUM-IN
           PERFORM 4101-BRMNUM-LEFT-EDIT-SEC
           MOVE    WRK-BRMNUM-OT       TO  SPA-GMN-I01-BRMNUM
      *
      *    間に空白文字が混入していないかチェック
           MOVE    SPACE           TO  WRK-STR1
                                       WRK-STR2
           UNSTRING    SPA-GMN-I01-BRMNUM
               DELIMITED   BY  ALL SPACE
               INTO    WRK-STR1
                       WRK-STR2
           END-UNSTRING
      *
           IF    ( WRK-STR2        NOT =   SPACE )
               MOVE    SPACE           TO  SPA-GMN-I01-BTUNAME
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    4               TO  SPA-GMN-I01-CUR
               GO  TO  4101-BRMNUM-CHK-EXT
           END-IF
      *
      *    病室番号存在チェック
           PERFORM 4101-BRMNUM-SEL-SEC
      *
           EVALUATE    SPA-GMN-I01-BTUNAME-CNT
      *    該当の病室が存在しなかった場合
           WHEN    0
               MOVE    SPACE           TO  SPA-GMN-I01-BTUNAME
               MOVE    "0004"          TO  SPA-ERRCD
               MOVE    4               TO  SPA-GMN-I01-CUR
               GO  TO  4101-BRMNUM-CHK-EXT
      *    該当の病室が１件存在した場合
           WHEN    1
               MOVE    SPA-GMN-I01-BTUNAME-ITM (1)
                                       TO  SPA-GMN-I01-BTUNAME
               MOVE    SPA-GMN-I01-BTUNAME-ITM2 (1)
                                       TO  WRK-BRM-SAGAKU-CD
               MOVE    6               TO  SPA-GMN-I01-CUR
      *    該当の病室が複数件存在した場合
           WHEN    OTHER
               IF    ( SPA-GMN-I01-BTUNAME =   SPACE )
                   MOVE    SPA-GMN-I01-BTUNAME-ITM (1)
                                       TO  SPA-GMN-I01-BTUNAME
                   MOVE    SPA-GMN-I01-BTUNAME-ITM2 (1)
                                       TO  WRK-BRM-SAGAKU-CD
               ELSE
                   MOVE   SPA-GMN-I01-BTUNAME-CD
                                       TO  WRK-CMB-CD
                   PERFORM 4103-CMB-BTUNAME-SRH-SEC
                   IF    ( WRK-CMB-ITM =   SPACE )
                       MOVE    SPA-GMN-I01-BTUNAME-ITM (1)
                                       TO  SPA-GMN-I01-BTUNAME
                       MOVE    SPA-GMN-I01-BTUNAME-ITM2 (1)
                                       TO  WRK-BRM-SAGAKU-CD
                   ELSE
                      MOVE WRK-CMB-ITM TO  SPA-GMN-I01-BTUNAME
                      MOVE WRK-CMB-ITM2
                                       TO  WRK-BRM-SAGAKU-CD
                   END-IF
           END-EVALUATE
      *
      *    室料差額の初期値を設定
           MOVE    WRK-BRM-SAGAKU-CD   TO  WRK-CMB-CD
           PERFORM 4103-CMB-SAGAKU-SRH-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-I01-SAGAKU
      *
      *    特定入院料コンボ設定処理
           PERFORM 4101-CMB-TOKNYUIN-SET-SEC
      *
      *    特定入院料の初期値を設定
           PERFORM 4101-TOKNYUIN-SYOKI-SEC
      *
           .
      *
       4101-BRMNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室検索処理
      *****************************************************************
       4101-BRMNUM-SEL-SEC             SECTION.
      *
           INITIALIZE              SYSKANRI-REC
                                   WRK-BTUJYOHO-TBL
      *
           MOVE    "5002"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD
                                   TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタ検索
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM UNTIL ( FLG-DBRC       NOT =   ZERO )
                   OR    ( WRK-BTUJYOHO-CNT  >= 50  )
      *
               MOVE    MCPDATA-REC TO  SYS-5002-REC
      *
               IF    ( SYS-5002-BRM-NUM
                                               =   SPA-GMN-I01-BRMNUM )
                   COMPUTE WRK-BTUJYOHO-CNT    
                       =   WRK-BTUJYOHO-CNT    +   1
                   MOVE    SYS-5002-KBNCD (1 : 2)
                                               TO  WRK-BTUJY-BTUNUM
                                                   (WRK-BTUJYOHO-CNT)
                   MOVE    SYS-5002-BRM-SAGAKU
                                               TO  WRK-BTUJY-BRM-SAGAKU
                                                   (WRK-BTUJYOHO-CNT)
               END-IF
      *
      *        システム管理マスタ読み込み
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    病棟名検索処理
           PERFORM 4101-BTUNAME-SEL-SEC
      *
           .
       4101-BRMNUM-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟名称設定処理
      *****************************************************************
       4101-BTUNAME-SEL-SEC            SECTION.
      *
      *
           INITIALIZE              SYSKANRI-REC
                                   SPA-GMN-I01-CMB-BTUNAME
      *
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタ検索
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM UNTIL ( FLG-DBRC                NOT = ZERO )
                   OR    ( SPA-GMN-I01-BTUNAME-CNT    >= 50  )
      *
               MOVE    MCPDATA-REC TO  SYS-5001-REC
      *
               SET WRK-BTUNUM-IDX  TO  1
               SEARCH  WRK-BTUJYOHO-OCC    VARYING WRK-BTUNUM-IDX
               WHEN    WRK-BTUJY-BTUNUM (WRK-BTUNUM-IDX)
                                   =   SYS-5001-BTU-NUM
                   COMPUTE SPA-GMN-I01-BTUNAME-CNT
                       =   SPA-GMN-I01-BTUNAME-CNT +   1
      *
                   MOVE    SYS-5001-BTU-NUM
                               TO  SPA-GMN-I01-BTUNAME-ITM
                                    (SPA-GMN-I01-BTUNAME-CNT) (1 : 2)
                   MOVE    SYS-5001-BTU-NAME
                               TO  SPA-GMN-I01-BTUNAME-ITM
                                    (SPA-GMN-I01-BTUNAME-CNT) (4 : )
                   MOVE    WRK-BTUJY-BRM-SAGAKU (WRK-BTUNUM-IDX)
                               TO  SPA-GMN-I01-BTUNAME-ITM2
                                    (SPA-GMN-I01-BTUNAME-CNT)
               WHEN   WRK-BTUJY-BTUNUM (WRK-BTUNUM-IDX)
                                   =   SPACE
                   CONTINUE
               END-SEARCH
      *
      *        システム管理マスタ読み込み
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4101-BTUNAME-SEL-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料コンボ設定処理
      *****************************************************************
       4101-CMB-TOKNYUIN-SET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-I01-CMB-TOKNYUIN
      *
      *    病棟情報からコンボ項目を設定
           MOVE    "5001"          TO  WRK-KANRICD
           MOVE    SPA-GMN-I01-BTUNAME-CD
                                   TO  WRK-KBNCD
           PERFORM 4102-SYSKANRI-SEL-SEC
           IF    ( FLG-SYSKANRI    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5001-REC
               IF    ( SYS-5001-BTU-TOKTEI-NYUIN
                               NOT =   SPACE )
                   MOVE    "5110"      TO  WRK-KANRICD
                   MOVE    SYS-5001-BTU-TOKTEI-NYUIN
                                       TO  WRK-KBNCD
                   PERFORM 4102-SYSKANRI-SEL-SEC
                   IF    ( FLG-SYSKANRI    =   ZERO )
                       MOVE    MCPDATA-REC
                                       TO  SYS-5110-REC
                       MOVE    SYS-5110-BTU-TOKUTEINYUIN-NM
                                       TO  WRK-TOKNYUIN-NM
                       MOVE    "2"     TO  WRK-TOKNYUIN-KBN
                       MOVE    SYS-5110-KBNCD
                                       TO  WRK-TOKNYUIN-CD
                       PERFORM 4101-CMB-TOKNYUIN-DAT-SET-SEC
                   END-IF
               END-IF
           END-IF
      *
      *    病室情報からコンボ項目を設定
           MOVE    "5002"          TO  WRK-KANRICD
           MOVE    SPA-GMN-I01-BTUNAME-CD
                                   TO  WRK-KBNCD (1 : 2)
           MOVE    SPA-GMN-I01-BRMNUM
                                   TO  WRK-BRMNUM
           PERFORM 4800-BRMNUM-EDIT-SEC
           MOVE    WRK-BRMNUM-EDT  TO  WRK-KBNCD (3 : )
           PERFORM 4102-SYSKANRI-SEL-SEC
           IF    ( FLG-SYSKANRI    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5002-REC
               IF    ( SYS-5002-BRM-TOKTEI-NYUIN
                               NOT =   SPACE )
                   MOVE    "5111"      TO  WRK-KANRICD
                   MOVE    SYS-5002-BRM-TOKTEI-NYUIN
                                       TO  WRK-KBNCD
                   PERFORM 4102-SYSKANRI-SEL-SEC
                   IF    ( FLG-SYSKANRI    =   ZERO )
                       MOVE    MCPDATA-REC
                                       TO  SYS-5111-REC
                       MOVE    SYS-5111-BRM-TOKUTEINYUIN-NM
                                       TO  WRK-TOKNYUIN-NM
                       MOVE    "3"     TO  WRK-TOKNYUIN-KBN
                       MOVE    SYS-5111-KBNCD
                                       TO  WRK-TOKNYUIN-CD
                       PERFORM 4101-CMB-TOKNYUIN-DAT-SET-SEC
                   END-IF
               END-IF
           END-IF
      *
      *    短期滞在手術基本料をコンボに設定
           MOVE    "5111"      TO  WRK-KANRICD
           MOVE    "21"        TO  WRK-KBNCD
           PERFORM 4102-SYSKANRI-SEL-SEC
           IF    ( FLG-SYSKANRI    =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-5111-REC
               MOVE    SYS-5111-BRM-TOKUTEINYUIN-NM
                                       TO  WRK-TOKNYUIN-NM
               MOVE    "3"             TO  WRK-TOKNYUIN-KBN
               MOVE    SYS-5111-KBNCD
                                       TO  WRK-TOKNYUIN-CD
               PERFORM 4101-CMB-TOKNYUIN-DAT-SET-SEC
           END-IF
      *
           .
       4101-CMB-TOKNYUIN-SET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理
      *****************************************************************
       4102-SYSKANRI-SEL-SEC       SECTION.
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    WRK-KANRICD     TO  SYS-KANRICD
           MOVE    WRK-KBNCD       TO  SYS-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               CONTINUE
           ELSE
               MOVE    1          TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4102-SYSKANRI-SEL-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料コンボデータセット処理
      *****************************************************************
       4101-CMB-TOKNYUIN-DAT-SET-SEC   SECTION.
      *
           IF    ( WRK-TOKNYUIN-NM     =   SPACE )
               GO  TO  4101-CMB-TOKNYUIN-DAT-SET-EXT
           END-IF
      *
           COMPUTE SPA-GMN-I01-TOKNYUIN-CNT
               =   SPA-GMN-I01-TOKNYUIN-CNT    +   1
           MOVE    SPA-GMN-I01-TOKNYUIN-CNT
                                       TO  IDX10
           MOVE    IDX10               TO  WRK-99
           MOVE    WRK-99              TO  SPA-GMN-I01-TOKNYUIN-ITM
                                                       (IDX10) (1 : 2)
           MOVE    WRK-TOKNYUIN-NM     TO  SPA-GMN-I01-TOKNYUIN-ITM
                                                       (IDX10) (4 : )
           MOVE    WRK-TOKNYUIN-KBN
                                       TO  SPA-GMN-I01-TOKNYUIN-ITM2
                                                       (IDX10) (1 : 1)
           MOVE    WRK-TOKNYUIN-CD
                                       TO  SPA-GMN-I01-TOKNYUIN-ITM2
                                                       (IDX10) (2 : 2)
      *
           .
       4101-CMB-TOKNYUIN-DAT-SET-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料初期値設定処理
      *****************************************************************
       4101-TOKNYUIN-SYOKI-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-TOKSET-LOOP
           INITIALIZE  SPA-GMN-I01-TOKNYUIN
           PERFORM VARYING IDX10
                   FROM    SPA-GMN-I01-TOKNYUIN-CNT    BY  -1
                   UNTIL ( IDX10   <   1 )
                    OR   ( FLG-TOKSET-LOOP NOT =   ZERO )
      *
               IF    ( SPA-GMN-I01-TOKNYUIN-ITM2 (IDX10) (1 : 1)
                                   =   "1" OR  "2" OR  "3" )
                   IF    ( SPA-GMN-I01-TOKNYUIN-ITM2 (IDX10)
                                   =   "321" )
                       CONTINUE
                   ELSE
                       MOVE    SPA-GMN-I01-TOKNYUIN-ITM (IDX10)
                                       TO  SPA-GMN-I01-TOKNYUIN
                       MOVE    SPA-GMN-I01-TOKNYUIN-ITM2 (IDX10)
                                       TO  SPA-NAI-I01-TOKNYUIN-ORG
                       MOVE    1       TO  FLG-TOKSET-LOOP
                   END-IF
               END-IF
      *
           END-PERFORM
      *
      *
           .
       4101-TOKNYUIN-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称チェック処理
      *****************************************************************
       4101-BTUNAME-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-I01-BTUNAME =   SPACE )
               GO  TO  4101-BTUNAME-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-BTUNAME-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-BTUNAME-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-BTUNAME
      *        室料差額のデフォルト値を設定
               MOVE    WRK-CMB-ITM2
                                   TO  WRK-CMB-CD
               PERFORM 4103-CMB-SAGAKU-SRH-SEC
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-SAGAKU
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    5           TO  SPA-GMN-I01-CUR
               GO  TO  4101-BTUNAME-CHK-EXT
           END-IF
      *
      *    特定入院料コンボ設定処理
           PERFORM 4101-CMB-TOKNYUIN-SET-SEC
      *
      *    特定入院料の初期値を設定
           PERFORM 4101-TOKNYUIN-SYOKI-SEC
      *
           .
      *
       4101-BTUNAME-CHK-EXT.
           EXIT.
      *****************************************************************
      *    室料差額チェック処理
      *****************************************************************
       4101-SAGAKU-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-I01-SAGAKU  =   SPACE )
               GO  TO  4101-SAGAKU-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-SAGAKU-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-SAGAKU-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-SAGAKU
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    6           TO  SPA-GMN-I01-CUR
               GO  TO  4101-SAGAKU-CHK-EXT
           END-IF
      *
           .
      *
       4101-SAGAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院日チェック処理
      *****************************************************************
       4101-NYUINYMD-CHK-SEC           SECTION.
      *
           MOVE    SPACE           TO  SPA-NAI-I01-NYUINYMD
      *
           IF    ( SPA-GMN-I01-NYUINYMD    =   SPACE )
      *
      *        入力がない場合、システム日付を設定
               MOVE    SPA-SYSYMD  TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-I01-NYUINYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-I01-NYUINYMD
               GO  TO  4101-NYUINYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-NYUINYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               MOVE    7           TO  SPA-GMN-I01-CUR
               GO  TO  4101-NYUINYMD-CHK-EXT
           END-IF
      *
           MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-NYUINYMD
           MOVE    WRK-SYMD        TO  SPA-NAI-I01-NYUINYMD
      *
           IF  ( SPA-GMN-I01-SYORIKBN-CD   =   "01" )
               MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  WRK-KJNYMD
      *        保険組み合わせコンボ初期処理
               PERFORM 4101-CMB-HKNCOMBI-SET-SEC
      *        受付マスタ検索処理
               MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  WRK-KJNYMD
               PERFORM 4101-UKETUKE-SEL-SEC
      *        受診履歴検索処理
               MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  WRK-KJNYMD
               PERFORM 4101-JYURRK-SEL-SEC
           END-IF
      *
           .
      *
       4101-NYUINYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院科チェック処理
      *****************************************************************
       4101-NYUINKA-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-I01-NYUINKA =   SPACE )
               GO  TO  4101-NYUINKA-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-NYUINKA-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-NYUINKA-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-NYUINKA
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    8           TO  SPA-GMN-I01-CUR
               GO  TO  4101-NYUINKA-CHK-EXT
           END-IF
      *
           .
      *
       4101-NYUINKA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    初回チェック処理
      *****************************************************************
       4101-SHOKAI-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-I01-SHOKAI  =   SPACE )
               GO  TO  4101-SHOKAI-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-SHOKAI-CD
                                       TO  WRK-CMB-CD
           PERFORM 4103-CMB-SHOKAI-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-SHOKAI
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    9           TO  SPA-GMN-I01-CUR
               GO  TO  4101-SHOKAI-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "01" )
               IF    ( SPA-GMN-I01-SHOKAI-CD   =   "2")
                   MOVE    WIDGET-NORMAL
                                           TO  SPA-GMN-I01-SHONUM-STT
               ELSE
                   MOVE    WIDGET-INSENSITIVE
                                           TO  SPA-GMN-I01-SHONUM-STT
                   MOVE    ZERO            TO  SPA-GMN-I01-SHONUM
                   MOVE    SPACE       TO  SPA-GMN-I01-LBL-SHONYUINYMD
               END-IF
           END-IF
      *
           .
      *
       4101-SHOKAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    初回番号チェック処理
      *****************************************************************
       4101-SHONUM-CHK-SEC             SECTION.
      *
           MOVE    SPACE       TO      SPA-GMN-I01-LBL-SHONYUINYMD
      *
           IF    ( SPA-GMN-I01-SHONUM   =   ZERO )
               GO  TO  4101-SHONUM-CHK-EXT
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-I01-NYUREKILST-CNT )
      *
               IF    ( SPA-GMN-I01-TSHONUM (IDX1)
                                   =   SPA-GMN-I01-SHONUM )
                 AND ( SPA-GMN-I01-TSHOKAI (IDX1)  =   "◎" )
      *
                   STRING "入院日 "
                          SPA-GMN-I01-TNYUINYMD (IDX1)
                   DELIMITED   BY  SIZE
                   INTO   SPA-GMN-I01-LBL-SHONYUINYMD
                   END-STRING
      *
               END-IF
      *
           END-PERFORM
      *
           IF    ( SPA-GMN-I01-LBL-SHONYUINYMD =   SPACE         )
               MOVE    10          TO      SPA-GMN-I01-CUR
               MOVE    "0005"      TO      SPA-ERRCD
               GO  TO  4101-SHONUM-CHK-EXT
           END-IF
      *
           .
       4101-SHONUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    退院日チェック処理
      *****************************************************************
       4101-TAIINYMD-CHK-SEC           SECTION.
      *
           MOVE    SPACE           TO  SPA-NAI-I01-TAIINYMD
      *
           IF    ( SPA-GMN-I01-TAIINYMD    =   SPACE )
               GO  TO  4101-TAIINYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-TAIINYMD
                                   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               MOVE    11          TO  SPA-GMN-I01-CUR
               GO  TO  4101-TAIINYMD-CHK-EXT
           END-IF
      *
           MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-TAIINYMD
           MOVE    WRK-SYMD        TO  SPA-NAI-I01-TAIINYMD
      *
           .
      *
       4101-TAIINYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    担当医チェック処理
      *****************************************************************
       4101-DR-CHK-SEC                 SECTION.
      *
           IF    ( SPA-GMN-I01-DR (IDX1)  =   SPACE )
               GO  TO  4101-DR-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-DR-CD (IDX1)
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-DR-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-DR (IDX1)
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               COMPUTE SPA-GMN-I01-CUR =   IDX1    +   11
               GO  TO  4101-DR-CHK-EXT
           END-IF
      *
           .
      *
       4101-DR-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険組合わせチェック処理
      *****************************************************************
       4101-HKNCOMBI-CHK-SEC           SECTION.
      *
           IF    ( SPA-GMN-I01-SYORIKBN-CD    =   "01" OR  "08")
               CONTINUE
           ELSE
               GO  TO  4101-HKNCOMBI-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-I01-HKNCOMBI-CNT   >   ZERO )
               CONTINUE
           ELSE
               MOVE    SPACE       TO  SPA-GMN-I01-HKNCOMBI
               MOVE    "1021"      TO  SPA-ERRCD
               MOVE    15          TO  SPA-GMN-I01-CUR
               GO  TO  4101-HKNCOMBI-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-I01-HKNCOMBI
                                       =   SPACE )
               GO  TO  4101-HKNCOMBI-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-HKNCOMBI-CD
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-HKNCOMBI-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-HKNCOMBI
               MOVE    WRK-CMB-ITM2
                                   TO  SPA-NAI-I01-FTNRATE
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    15          TO  SPA-GMN-I01-CUR
               GO  TO  4101-HKNCOMBI-CHK-EXT
           END-IF
      *
           .
      *
       4101-HKNCOMBI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特定入院チェック処理
      *****************************************************************
       4101-TOKNYUIN-CHK-SEC           SECTION.
      *
           IF    ( SPA-GMN-I01-TOKNYUIN
                                       =   SPACE )
               GO  TO  4101-TOKNYUIN-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-TOKNYUIN-CD
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-TOKNYUIN-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-TOKNYUIN
               MOVE    WRK-CMB-ITM2
                                   TO  SPA-NAI-I01-TOKNYUIN-ORG
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    16          TO  SPA-GMN-I01-CUR
               GO  TO  4101-TOKNYUIN-CHK-EXT
           END-IF
      *
           .
      *
       4101-TOKNYUIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    前受け金チェック処理
      *****************************************************************
       4101-MAEUKE-CHK-SEC             SECTION.
      *
      *
           .
      *
       4101-MAEUKE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    定期請求チェック処理
      *****************************************************************
       4101-SEIKYU-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-I01-SEIKYU
                                       =   SPACE )
               GO  TO  4101-SEIKYU-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-SEIKYU-CD
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-SEIKYU-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-SEIKYU
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    18          TO  SPA-GMN-I01-CUR
               GO  TO  4101-SEIKYU-CHK-EXT
           END-IF
      *
           .
      *
       4101-SEIKYU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    検索時患者表示チェック処理
      *****************************************************************
       4101-DISPKBN-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-I01-DISPKBN
                                       =   SPACE )
               GO  TO  4101-DISPKBN-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-DISPKBN-CD
                                   TO  WRK-CMB-CD
           PERFORM 4103-CMB-DISPKBN-SRH-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM TO  SPA-GMN-I01-DISPKBN
           ELSE
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    19          TO  SPA-GMN-I01-CUR
               GO  TO  4101-DISPKBN-CHK-EXT
           END-IF
      *
           .
      *
       4101-DISPKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号チェック処理
      *****************************************************************
       4101-SELNUM-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-I01-SELNUM  =   ZERO )
               GO  TO  4101-SELNUM-CHK-EXT
           END-IF
      *
      *    入力された番号が存在するかチェック
           IF    ( SPA-GMN-I01-SELNUM  >   SPA-GMN-I01-NYUREKILST-CNT )
               MOVE    "0001"      TO  SPA-ERRCD
               MOVE    100         TO  SPA-GMN-I01-CUR
               GO  TO  4101-SELNUM-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-SELNUM
                                   TO  SPA-GMN-I01-NYUREKILST-SEL
      *
           .
      *
       4101-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院歴リスト選択処理
      *****************************************************************
       4101-NYUREKILST-SEL-SEC         SECTION.
      *
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL     ( IDX1    >   SPA-GMN-I01-NYUREKILST-CNT )
      *
               IF    ( I01-NYUREKILST-SELECT (IDX1)    =   "T"  )
                   MOVE    IDX1        TO  SPA-GMN-I01-NYUREKILST-SEL
                   MOVE    SPA-GMN-I01-TSELNUM (IDX1)
                                       TO  I01-SELNUM
                   MOVE    SPA-GMN-I01-NYUREKILST-CNT
                                       TO  IDX1
               END-IF
      *
           END-PERFORM
      *
           .
      *
       4101-NYUREKILST-SEL-EXT.
           EXIT.
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
       4102-PTNUM-CHK-SEC              SECTION.
      *
      *    患者番号がエラーでないこと
           IF    ( SPA-GMN-I01-ERRCD (1)   NOT =   SPACE )
               MOVE    SPA-GMN-I01-ERRCD (1)
                                   TO  SPA-ERRCD
               MOVE    1           TO  SPA-GMN-I01-CUR
               GO  TO  4102-PTNUM-CHK-EXT
           END-IF
      *
      *    患者番号が入力されていること
           IF    ( SPA-GMN-I01-PTNUM           =   SPACE )
               MOVE    "1001"      TO  SPA-ERRCD
               MOVE    1           TO  SPA-GMN-I01-CUR
               GO  TO  4102-PTNUM-CHK-EXT
           END-IF
      *
           .
      *
       4102-PTNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    処理区分チェック処理
      *****************************************************************
       4102-SYORIKBN-CHK-SEC              SECTION.
      *
      *    処理区分がエラーでないこと
           IF    ( SPA-GMN-I01-ERRCD (2)   NOT =   SPACE )
               MOVE    SPA-GMN-I01-ERRCD (2)
                                   TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-I01-CUR
               GO  TO  4102-SYORIKBN-CHK-EXT
           END-IF
      *
      *    処理区分が入力されていること
           IF    ( SPA-GMN-I01-SYORIKBN    =   SPACE )
               MOVE    "1002"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-I01-CUR
               GO  TO  4102-SYORIKBN-CHK-EXT
           END-IF
      *
      *    処理区分が照会の場合、カーソルは常に処理区分におく
           IF    ( SPA-GMN-I01-SYORIKBN    =   "4" )
               MOVE    2           TO  SPA-GMN-I01-CUR
               GO  TO  4102-SYORIKBN-CHK-EXT
           END-IF
      *
           .
      *
       4102-SYORIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    処理区分サーチ処理
      *****************************************************************
       4103-CMB-SYORIKBN-SRH-SEC   SECTION.
      *
           SET     CMB-IDX01       TO  1
           SEARCH  SPA-GMN-I01-SYORIKBN-ITM
                   VARYING CMB-IDX01
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-SYORIKBN-ITM (CMB-IDX01) (1 : 2)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX01
               MOVE    SPA-GMN-I01-SYORIKBN-ITM (CMB-IDX01)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-I01-SYORIKBN-ITM (CMB-IDX01)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-SYORIKBN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    病棟名サーチ処理
      *****************************************************************
       4103-CMB-BTUNAME-SRH-SEC    SECTION.
      *
           SET     CMB-IDX02       TO  1
           SEARCH  SPA-GMN-I01-BTUNAME-ITM-OCC
                   VARYING CMB-IDX02
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-BTUNAME-ITM (CMB-IDX02) (1 : 2)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX02
               MOVE    SPA-GMN-I01-BTUNAME-ITM (CMB-IDX02)
                                   TO  WRK-CMB-ITM
               MOVE    SPA-GMN-I01-BTUNAME-ITM2 (CMB-IDX02)
                                   TO  WRK-CMB-ITM2
           WHEN    SPA-GMN-I01-BTUNAME-ITM (CMB-IDX02)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-BTUNAME-SRH-EXT.
           EXIT.
      *****************************************************************
      *    室料差額サーチ処理
      *****************************************************************
       4103-CMB-SAGAKU-SRH-SEC     SECTION.
      *
           SET     CMB-IDX03       TO  1
           SEARCH  SPA-GMN-I01-SAGAKU-ITM
                   VARYING CMB-IDX03
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-SAGAKU-ITM (CMB-IDX03) (1 : 2)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX03
               MOVE    SPA-GMN-I01-SAGAKU-ITM (CMB-IDX03)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-I01-SAGAKU-ITM (CMB-IDX03)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-SAGAKU-SRH-EXT.
           EXIT.
      *****************************************************************
      *    入院科サーチ処理
      *****************************************************************
       4103-CMB-NYUINKA-SRH-SEC    SECTION.
      *
           SET     CMB-IDX04       TO  1
           SEARCH  SPA-GMN-I01-NYUINKA-ITM
                   VARYING CMB-IDX04
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-NYUINKA-ITM (CMB-IDX04) (1 : 2)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX04
               MOVE    SPA-GMN-I01-NYUINKA-ITM (CMB-IDX04)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-I01-NYUINKA-ITM (CMB-IDX04)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-NYUINKA-SRH-EXT.
           EXIT.
      *****************************************************************
      *    初回サーチ処理
      *****************************************************************
       4103-CMB-SHOKAI-SRH-SEC     SECTION.
      *
           SET     CMB-IDX05       TO  1
           SEARCH  SPA-GMN-I01-SHOKAI-ITM
                   VARYING CMB-IDX05
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-SHOKAI-ITM (CMB-IDX05) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX05
               MOVE    SPA-GMN-I01-SHOKAI-ITM (CMB-IDX05)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-I01-SHOKAI-ITM (CMB-IDX05)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-SHOKAI-SRH-EXT.
           EXIT.
      *****************************************************************
      *    担当医サーチ処理
      *****************************************************************
       4103-CMB-DR-SRH-SEC         SECTION.
      *
           INITIALIZE              WRK-CMB-ITM
                                   WRK-CMB-IDX
      *
           MOVE    SPA-GMN-I01-DR-CNT (IDX1)
                                   TO  WRK-CNT
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL  (IDX2    >   WRK-CNT )
                   OR     (WRK-CMB-ITM NOT =   SPACE )
                   OR     (SPA-GMN-I01-DR-ITM (IDX1 IDX2)
                                           =   SPACE )
               IF    ( SPA-GMN-I01-DR-ITM (IDX1 IDX2) (1 : 4)
                                   =   WRK-CMB-CD  )
                   MOVE    IDX2    TO  WRK-CMB-IDX
                   MOVE    SPA-GMN-I01-DR-ITM (IDX1 IDX2)
                                   TO  WRK-CMB-ITM
               END-IF
           END-PERFORM
      *
           .
      *
       4103-CMB-DR-SRH-EXT.
           EXIT.
      *****************************************************************
      *    保険組み合わせサーチ処理
      *****************************************************************
       4103-CMB-HKNCOMBI-SRH-SEC   SECTION.
      *
           SET     CMB-IDX07       TO  1
           SEARCH  SPA-GMN-I01-HKNCOMBI-ITM-OCC
                   VARYING CMB-IDX07
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-HKNCOMBI-ITM (CMB-IDX07) (1 : 4)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX07
               MOVE    SPA-GMN-I01-HKNCOMBI-ITM (CMB-IDX07)
                                   TO  WRK-CMB-ITM
               MOVE    SPA-GMN-I01-HKNCOMBI-ITM2 (CMB-IDX07)
                                   TO  WRK-CMB-ITM2
           WHEN    SPA-GMN-I01-HKNCOMBI-ITM (CMB-IDX07)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-HKNCOMBI-SRH-EXT.
           EXIT.
      *****************************************************************
      *    特定入院サーチ処理
      *    コンボに表示されている番号でサーチ
      *****************************************************************
       4103-CMB-TOKNYUIN-SRH-SEC   SECTION.
      *
           SET     CMB-IDX08       TO  1
           SEARCH  SPA-GMN-I01-TOKNYUIN-ITM-OCC
                   VARYING CMB-IDX08
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-TOKNYUIN-ITM (CMB-IDX08) (1 : 2)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX08
               MOVE    SPA-GMN-I01-TOKNYUIN-ITM (CMB-IDX08)
                                   TO  WRK-CMB-ITM
               MOVE    SPA-GMN-I01-TOKNYUIN-ITM2 (CMB-IDX08)
                                   TO  WRK-CMB-ITM2
           WHEN    SPA-GMN-I01-TOKNYUIN-ITM (CMB-IDX08)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-TOKNYUIN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    特定入院サーチ処理２
      *    実際のコードでサーチ
      *****************************************************************
       4103-CMB-TOKNYUIN-SRH2-SEC  SECTION.
      *
           SET     CMB-IDX08       TO  1
           SEARCH  SPA-GMN-I01-TOKNYUIN-ITM-OCC
                   VARYING CMB-IDX08
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-TOKNYUIN-ITM2 (CMB-IDX08)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX08
               MOVE    SPA-GMN-I01-TOKNYUIN-ITM (CMB-IDX08)
                                   TO  WRK-CMB-ITM
               MOVE    SPA-GMN-I01-TOKNYUIN-ITM2 (CMB-IDX08)
                                   TO  WRK-CMB-ITM2
           WHEN    SPA-GMN-I01-TOKNYUIN-ITM2 (CMB-IDX08)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-ITM2
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-TOKNYUIN-SRH2-EXT.
           EXIT.
      *****************************************************************
      *    定期請求サーチ処理
      *****************************************************************
       4103-CMB-SEIKYU-SRH-SEC         SECTION.
      *
           SET     CMB-IDX09       TO  1
           SEARCH  SPA-GMN-I01-SEIKYU-ITM
                   VARYING CMB-IDX09
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-SEIKYU-ITM (CMB-IDX09) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX09
               MOVE    SPA-GMN-I01-SEIKYU-ITM (CMB-IDX09)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-I01-SEIKYU-ITM (CMB-IDX09)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-SEIKYU-SRH-EXT.
           EXIT.
      *****************************************************************
      *    検索時患者表示サーチ処理
      *****************************************************************
       4103-CMB-DISPKBN-SRH-SEC    SECTION.
      *
           SET     CMB-IDX10       TO  1
           SEARCH  SPA-GMN-I01-DISPKBN-ITM
                   VARYING CMB-IDX10
           AT  END
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           WHEN    SPA-GMN-I01-DISPKBN-ITM (CMB-IDX10) (1 : 1)
                                   =   WRK-CMB-CD
               SET WRK-CMB-IDX     TO  CMB-IDX10
               MOVE    SPA-GMN-I01-DISPKBN-ITM (CMB-IDX10)
                                   TO  WRK-CMB-ITM
           WHEN    SPA-GMN-I01-DISPKBN-ITM (CMB-IDX10)
                                   =   SPACE
               INITIALIZE          WRK-CMB-ITM
                                   WRK-CMB-IDX
           END-SEARCH
      *
           .
      *
       4103-CMB-DISPKBN-SRH-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "I01"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  SPA-WORK 
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
      *
       210-BACK-EXT.
           EXIT.
      *****************************************************************
      *    クリア処理
      *****************************************************************
       420-CLEAR-SEC                   SECTION.
      *
           INITIALIZE    SPA-GMN-I01-HEAD-AREA
                         SPA-NAI-I01-HEAD-AREA
                         SPA-GMN-I01-NYUREKILST-AREA
                         SPA-NAI-I01-NYUREKILST-AREA
                         SPA-GMN-I01-ERRCD-TBL
                         SPA-GMN-I01-CMB-BTUNAME
                         SPA-GMN-I01-CMB-HKNCOMBI
      *
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           PERFORM 310-CMB-SYORIKBN-SET1-SEC
      *
           PERFORM 4201-WIDGET-STATE-CLEAR-SEC
      *
           MOVE    1                   TO  SPA-GMN-I01-CUR
      *
           .
      *
       420-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    前回患者設定処理
      *****************************************************************
       420-MAEPTINF-SET-SEC            SECTION.
      *
      *    前回患者が設定されているばあは前回患者を表示する
           IF    ( SPA-LAST-PTNUM  NOT =   SPACE )
               MOVE    SPA-LAST-PTID   TO  SPA-NAI-I01-PTID
               MOVE    SPA-LAST-PTNUM  TO  SPA-GMN-I01-PTNUM
               PERFORM 4101-PTINF-SELECT-SEC 
           END-IF
      *
           .
      *
       420-MAEPTINF-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力領域初期化処理
      *****************************************************************
       4201-INPUT-AREA-CLEAR-SEC       SECTION.
      *
           INITIALIZE              SPA-GMN-I01-INPUT-AREA
                                   SPA-NAI-I01-INPUT-AREA
                                   SPA-GMN-I01-CMB-BTUNAME
                                   SPA-GMN-I01-CMB-HKNCOMBI
      *
           MOVE    SPA-GMN-I01-SHOKAI-ITM (01)
                                       TO  SPA-GMN-I01-SHOKAI
           MOVE    SPA-GMN-I01-SEIKYU-ITM (01)
                                   TO  SPA-GMN-I01-SEIKYU
           MOVE    SPA-GMN-I01-DISPKBN-ITM (1)
                                   TO  SPA-GMN-I01-DISPKBN
      *
      *    入院日にシステム日付を表示
           MOVE    SPA-SYSYMD      TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-I01-NYUINYMD
           MOVE    WRK-SYMD        TO  SPA-NAI-I01-NYUINYMD
      *
           MOVE    ZERO            TO  SPA-GMN-I01-NYUREKILST-SEL
      *
           .
      *
       4201-INPUT-AREA-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面状態初期化処理
      *****************************************************************
       4201-WIDGET-STATE-CLEAR-SEC     SECTION.
      *
           MOVE    WIDGET-NORMAL   TO  SPA-GMN-I01-B07-STT
                                       SPA-GMN-I01-B08-STT
                                       SPA-GMN-I01-B12-STT
                                       SPA-GMN-I01-IDOYMD-STT
                                       SPA-GMN-I01-BRMNUM-STT
                                       SPA-GMN-I01-BTUNAME-STT
                                       SPA-GMN-I01-BTUNAME-ITM-STT
                                       SPA-GMN-I01-SAGAKU-STT
                                       SPA-GMN-I01-SAGAKU-ITM-STT
                                       SPA-GMN-I01-NYUINYMD-STT
                                       SPA-GMN-I01-NYUINKA-STT
                                       SPA-GMN-I01-NYUINKA-ITM-STT
                                       SPA-GMN-I01-SHOKAI-STT
                                       SPA-GMN-I01-SHOKAI-ITM-STT
                                       SPA-GMN-I01-SHONUM-STT
                                       SPA-GMN-I01-TAIINYMD-STT
                                       SPA-GMN-I01-DR-STT (1)
                                       SPA-GMN-I01-DR-ITM-STT (1)
                                       SPA-GMN-I01-DR-STT (2)
                                       SPA-GMN-I01-DR-ITM-STT (2)
                                       SPA-GMN-I01-DR-STT (3)
                                       SPA-GMN-I01-DR-ITM-STT (3)
                                       SPA-GMN-I01-HKNCOMBI-STT
                                       SPA-GMN-I01-HKNCOMBI-ITM-STT
                                       SPA-GMN-I01-TOKNYUIN-STT
                                       SPA-GMN-I01-TOKNYUIN-ITM-STT
                                       SPA-GMN-I01-MAEUKE-STT
                                       SPA-GMN-I01-SEIKYU-STT
                                       SPA-GMN-I01-SEIKYU-ITM-STT
                                       SPA-GMN-I01-DISPKBN-STT
                                       SPA-GMN-I01-DISPKBN-ITM-STT
      *
           .
      *
       4201-WIDGET-STATE-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    画面状態非活性処理
      *****************************************************************
       4201-WIDGET-INSENSITIVE-SEC     SECTION.
      *
           MOVE    WIDGET-INSENSITIVE
                                   TO  SPA-GMN-I01-B07-STT
                                       SPA-GMN-I01-B08-STT
                                       SPA-GMN-I01-B12-STT
                                       SPA-GMN-I01-IDOYMD-STT
                                       SPA-GMN-I01-BRMNUM-STT
                                       SPA-GMN-I01-BTUNAME-STT
                                       SPA-GMN-I01-BTUNAME-ITM-STT
                                       SPA-GMN-I01-SAGAKU-STT
                                       SPA-GMN-I01-SAGAKU-ITM-STT
                                       SPA-GMN-I01-NYUINYMD-STT
                                       SPA-GMN-I01-NYUINKA-STT
                                       SPA-GMN-I01-NYUINKA-ITM-STT
                                       SPA-GMN-I01-SHOKAI-STT
                                       SPA-GMN-I01-SHOKAI-ITM-STT
                                       SPA-GMN-I01-SHONUM-STT
                                       SPA-GMN-I01-TAIINYMD-STT
                                       SPA-GMN-I01-DR-STT (1)
                                       SPA-GMN-I01-DR-ITM-STT (1)
                                       SPA-GMN-I01-DR-STT (2)
                                       SPA-GMN-I01-DR-ITM-STT (2)
                                       SPA-GMN-I01-DR-STT (3)
                                       SPA-GMN-I01-DR-ITM-STT (3)
                                       SPA-GMN-I01-HKNCOMBI-STT
                                       SPA-GMN-I01-HKNCOMBI-ITM-STT
                                       SPA-GMN-I01-TOKNYUIN-STT
                                       SPA-GMN-I01-TOKNYUIN-ITM-STT
                                       SPA-GMN-I01-MAEUKE-STT
                                       SPA-GMN-I01-SEIKYU-STT
                                       SPA-GMN-I01-SEIKYU-ITM-STT
                                       SPA-GMN-I01-DISPKBN-STT
                                       SPA-GMN-I01-DISPKBN-ITM-STT
      *
           .
       4201-WIDGET-INSENSITIVE-EXT.
           EXIT.
      *****************************************************************
      *    患者登録へ
      *****************************************************************
       440-KNJADD-SEC             SECTION.
      *
      *    ＳＰＡの内容を退避
           INITIALIZE                  I0SUB01-LNK
           MOVE    SPA-TERMID          TO  I0SUB01-TERMID
           MOVE    "O"                 TO  I0SUB01-KBN
           MOVE    SPA-I0FREE          TO  I0SUB01-SCRSPA-AREA
           MOVE    SPA-I0KYOUTU        TO  I0SUB01-COMMON
      *
           CALL    "ORCGI0SUB01"       USING   I0SUB01-LNK
      *
           MOVE    "I01"               TO  SPA-MOTOPG
           MOVE    "I01"               TO  SPA-MOTOPG2
           MOVE    "P02"               TO  SPA-SAKIPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           INITIALIZE                      SPA-WORK
           MOVE    SPA-AREA            TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    "P02"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
          .
       440-KNJADD-EXT.
           EXIT.
      *****************************************************************
      *    入院歴画面遷移処理
      *****************************************************************
       480-NYUINREKI-SEC               SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    選択番号未入力チェック
           IF    ( SPA-GMN-I01-SELNUM  =   ZERO )
               MOVE    "1019"      TO  SPA-ERRCD
               MOVE    100         TO  SPA-GMN-I01-CUR
               GO  TO  480-NYUINREKI-EXT
           END-IF
      *
      *    選択番号チェック（基本チェック）
           PERFORM 4101-SELNUM-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  480-NYUINREKI-EXT
           END-IF
      *
           MOVE    SPA-NAI-I01-PTID
                                   TO  SPA-I01-I02-PTID
           MOVE    SPA-NAI-I01-TRRKNUM (SPA-GMN-I01-SELNUM)
                                   TO  SPA-I01-I02-PTRRKNUM
      *
           MOVE    SPACE           TO  SPA-MOTOPG
      *
           MOVE    SPA-I0KYOUTU    TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-I0FREE      TO  SPA-FREE
      *
           MOVE    "LINK"          TO  MCP-STATUS
           MOVE    SPACE           TO  MCP-EVENT
      *
           CALL    "ORCGI02"      USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA
      *
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-I0FREE
           MOVE    SPA-WORK        TO  SPA-I0KYOUTU
      *
           IF    ( SPA-NAI-I01-TZITA-FLG (SPA-GMN-I01-SELNUM)
                                   =   SPACE )
               MOVE    "NYUGAI"        TO  MCP-WIDGET
           ELSE
               MOVE    "B01"           TO  MCP-WIDGET
           END-IF
      *
           MOVE    "I01"           TO  SPA-MOTOPG
           MOVE    "I02"           TO  SPA-SAKIPG
      *
           MOVE    "NEW"           TO  MCP-PUTTYPE
           MOVE    "I02"           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE  1             TO  FLG-END
      *
           .
       480-NYUINREKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    他院歴作成画面遷移処理（作成処理）
      *****************************************************************
       480-TAINREKI-SAKUSEI-SEC        SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    "1"                 TO  SPA-I01-I03-SYORIKBN
           MOVE    SPA-NAI-I01-PTID    TO  SPA-I01-I03-PTID
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK
           INITIALIZE  PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  PTNYUINRRK-PTID
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY9"   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
           MOVE    "PTNYUINRRK-KEY9"   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( FLG-PTNYUINRRK  NOT =   ZERO )
               COMPUTE     SPA-I01-I03-PTRRKNUM    =   1
               COMPUTE     SPA-I01-I03-PTRRKEDANUM =   1
           ELSE
               COMPUTE     SPA-I01-I03-PTRRKNUM    =   PTNYUINRRK-RRKNUM
                                                   +   1
               COMPUTE     SPA-I01-I03-PTRRKEDANUM =   1
           END-IF
      *
           MOVE    SPA-GMN-I01-SYORIKBN-CD
                                   TO  SPA-I01-I03-SYORIKBN-CD
      *
           MOVE    SPA-GMN-I01-NYUREKILST-SEL
                                   TO  IDX1
           IF    ( IDX1            >   ZERO )
            AND  ( IDX1            <=  SPA-GMN-I01-NYUREKILST-CNT )
               MOVE    SPA-GMN-I01-TSHONUM (IDX1)
                                   TO  SPA-I01-I03-SHONUM
           ELSE
               MOVE    ZERO        TO  SPA-I01-I03-SHONUM
           END-IF
      *
           MOVE    ZERO            TO  SPA-I01-I03-TAIINYMD
           IF    ( SPA-I01-I03-SHONUM      NOT =   ZERO )
               PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >    SPA-GMN-I01-NYUREKILST-CNT )
                   IF    ( SPA-I01-I03-SHONUM
                                   =   SPA-GMN-I01-TSHONUM (IDX2) )
                       MOVE    SPA-NAI-I01-TTAIINYMD (IDX2)
                                   TO  SPA-I01-I03-TAIINYMD
                   END-IF
               END-PERFORM
           END-IF
      *
           MOVE    SPACE           TO  SPA-MOTOPG
           MOVE    SPA-I0KYOUTU    TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-I0FREE      TO  SPA-FREE
      *
           MOVE    "LINK"          TO  MCP-STATUS
           MOVE    SPACE           TO  MCP-EVENT
      *
           CALL    "ORCGI03"      USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA
      *
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-I0FREE
           MOVE    SPA-WORK        TO  SPA-I0KYOUTU
      *
           MOVE    "SHOKAI"        TO  MCP-WIDGET
      *
           MOVE    "I01"           TO  SPA-MOTOPG
           MOVE    "I03"           TO  SPA-SAKIPG
      *
           MOVE    "NEW"           TO  MCP-PUTTYPE
           MOVE    "I03"           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE  1             TO  FLG-END
      *
           .
       480-TAINREKI-SAKUSEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    他院歴作成画面遷移処理（修正処理）
      *****************************************************************
       480-TAINREKI-SYUSEI-SEC         SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    歴が選択されていること
           IF    ( SPA-GMN-I01-NYUREKILST-SEL >   ZERO )
            AND  ( SPA-GMN-I01-NYUREKILST-SEL
                              <=   SPA-GMN-I01-NYUREKILST-CNT )
               CONTINUE
           ELSE
               MOVE    "1023"          TO  SPA-ERRCD
               GO  TO  480-TAINREKI-SYUSEI-EXT
           END-IF
      *
           MOVE    SPA-GMN-I01-NYUREKILST-SEL
                                       TO  IDX1
      *
      *    他院歴が選択されていること
           IF    ( SPA-NAI-I01-TZITA-FLG (IDX1)    =   ZERO )
               MOVE    "1023"          TO  SPA-ERRCD
               GO  TO  480-TAINREKI-SYUSEI-EXT
           END-IF
      *
      *    他院歴が最新であること
           COMPUTE IDX3    =   IDX1    -   1
           PERFORM VARYING IDX2    FROM    IDX3    BY  -1
                   UNTIL ( IDX2    <   1 )
                   OR    ( SPA-ERRCD       NOT =   SPACE )
               IF    ( SPA-GMN-I01-TSHONUM (IDX1)
                                   =   SPA-GMN-I01-TSHONUM (IDX2) )
                   MOVE    "1024"  TO  SPA-ERRCD
                   MOVE    ZERO    TO  IDX2
               END-IF
           END-PERFORM
      *
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  480-TAINREKI-SYUSEI-EXT
           END-IF
      *
           MOVE    "2"             TO  SPA-I01-I03-SYORIKBN
           MOVE    SPA-NAI-I01-PTID
                                   TO  SPA-I01-I03-PTID
           MOVE    SPA-NAI-I01-TRRKNUM (IDX1)
                                   TO  SPA-I01-I03-PTRRKNUM
           MOVE    1               TO  SPA-I01-I03-PTRRKEDANUM
           MOVE    SPA-GMN-I01-SYORIKBN-CD
                                   TO  SPA-I01-I03-SYORIKBN-CD
           MOVE    ZERO            TO  SPA-I01-I03-TAIINYMD
           IF    ( SPA-GMN-I01-TSHOKAI (IDX1)  NOT =   "◎" )
               COMPUTE IDX3    =   IDX1    +   1
               PERFORM VARYING IDX2    FROM    IDX3    BY  1
                   UNTIL     ( IDX2    >    SPA-GMN-I01-NYUREKILST-CNT )
                   IF    ( SPA-GMN-I01-TSHONUM (IDX1)
                                   =   SPA-GMN-I01-TSHONUM (IDX2) )
                       MOVE    SPA-NAI-I01-TTAIINYMD (IDX2)
                                   TO  SPA-I01-I03-TAIINYMD
                   END-IF
               END-PERFORM
           END-IF
      *
           MOVE    SPACE           TO  SPA-MOTOPG
           MOVE    SPA-I0KYOUTU    TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-I0FREE      TO  SPA-FREE
      *
           MOVE    "LINK"          TO  MCP-STATUS
           MOVE    SPACE           TO  MCP-EVENT
      *
           CALL    "ORCGI03"      USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA
      *
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-I0FREE
           MOVE    SPA-WORK        TO  SPA-I0KYOUTU
      *
           MOVE    "COMMENT"       TO  MCP-WIDGET
      *
           MOVE    "I01"           TO  SPA-MOTOPG
           MOVE    "I03"           TO  SPA-SAKIPG
      *
           MOVE    "NEW"           TO  MCP-PUTTYPE
           MOVE    "I03"           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE  1             TO  FLG-END
      *
           .
       480-TAINREKI-SYUSEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    氏名検索処理
      *****************************************************************
       480-KENSAKU-SEC                 SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-I0FREE          TO  LNK-SCRSPA
      *
           MOVE    ZERO                TO  SPA-PTID
      *
           MOVE    "I01"               TO  SPA-MOTOPG
           MOVE    "P97"               TO  SPA-SAKIPG
      *    氏名をクリアする
           MOVE    SPACE               TO  SPA-NAME
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    "P97"               TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                   TO  FLG-END
           .
      *
       480-KENSAKU-EXT.
           EXIT.
      *****************************************************************
      *    入院会計照会遷移処理
      *****************************************************************
       480-NYUINKAIKEI-SEC             SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    入院会計照会へ引き継ぐ情報を設定
           PERFORM 4801-NYUINKAIKEI-PARA-SET-SEC
      *
      *    ＳＰＡの内容を退避
           INITIALIZE                  I0SUB01-LNK
           MOVE    SPA-TERMID          TO  I0SUB01-TERMID
           MOVE    "O"                 TO  I0SUB01-KBN
           MOVE    SPA-I0FREE          TO  I0SUB01-SCRSPA-AREA
           MOVE    SPA-I0KYOUTU        TO  I0SUB01-COMMON
      *
           CALL    "ORCGI0SUB01"       USING   I0SUB01-LNK
      *
      *    入院会計照会へ遷移する
           MOVE    "I01"               TO  SPA-MOTOPG
           MOVE    "I41"               TO  SPA-SAKIPG
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-I0KYOUTU        TO  SPA-WORK
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-I0FREE          TO  LNK-SCRSPA
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "I41"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       480-NYUINKAIKEI-EXT.
           EXIT.
      *****************************************************************
      *    会計照会引継情報設定処理
      *****************************************************************
       4801-NYUINKAIKEI-PARA-SET-SEC   SECTION.
      *
           INITIALIZE                      SPA-KYOTUKEY
                                           SPA-KYOTU-SET
      *
      *    入院科を編集
           MOVE    SPACE           TO  WRK-SRYKAMEI
      *
           IF    ( SPA-GMN-I01-NYUINKA NOT =   SPACE )
               MOVE    SPA-GMN-I01-NYUINKA-CD
                                   TO  WRK-CMB-CD
               PERFORM 4103-CMB-NYUINKA-SRH-SEC
               MOVE    WRK-CMB-ITM
                                   TO  WRK-SRYKAMEI
           END-IF
      *
      *    システム日付を診療日付として会計に引き継ぐ
           MOVE    SPA-SYSYMD      TO  SPA-SRYYMD
           MOVE    SPA-SYSYMDWH    TO  SPA-SRYYMDW
      *
      *    入院科が入力されていた場合は会計に引き継ぐ
      *    （患者情報が入力されていた場合に限る）
           IF    ( WRK-SRYKAMEI        NOT =   SPACE )
            AND  ( SPA-NAI-I01-PTID    NOT =   ZERO )
               MOVE    SPA-GMN-I01-NYUINKA-CD
                                   TO  SPA-SRYKA
               MOVE    WRK-SRYKAMEI
                                   TO  SPA-SRYKAMEI
           END-IF
      *
      *    患者情報が入力されていた場合は会計に引継ぐ
           IF    ( SPA-NAI-I01-PTID    NOT =   ZERO )
               MOVE    SPA-NAI-I01-PTID
                                   TO  SPA-PTID
               MOVE    SPA-GMN-I01-PTNUM
                                   TO  SPA-PTNUM
               MOVE    SPA-NAI-I01-KANANAME
                                   TO  SPA-KANANAME
               MOVE    SPA-GMN-I01-NAME
                                   TO  SPA-NAME
               MOVE    SPA-GMN-I01-SEX
                                   TO  SPA-SEX
               MOVE    SPA-GMN-I01-BIRTHDAY
                                   TO  SPA-BIRTHDAYW
               MOVE    SPA-NAI-I01-BIRTHDAY
                                   TO  SPA-BIRTHDAY
           END-IF
      *
           .
       4801-NYUINKAIKEI-PARA-SET-EXT.
           EXIT.
      *****************************************************************
      *    登録処理
      *****************************************************************
       480-TOUROKU-SEC                 SECTION.
      *
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  480-TOUROKU-EXT
           END-IF
      *
           PERFORM 4801-KANREN-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  480-TOUROKU-EXT
           END-IF
      *
           MOVE    SPACE           TO  WRK-UPDKBN
           EVALUATE    SPA-GMN-I01-SYORIKBN-CD
      *    入院登録
           WHEN    "01"
               MOVE    "INS"       TO  WRK-UPDKBN
      *    退院登録
           WHEN    "02"
      *
      *        負担金計算処理
               PERFORM 490-FTNKIN-CALC-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  480-TOUROKU-EXT
               END-IF
      *        請求確認画面遷移処理
               PERFORM 490-I04-SENI-SEC
               GO  TO  480-TOUROKU-EXT
      *    転科・転棟・転室
           WHEN    "08"
               MOVE    "INS"       TO  WRK-UPDKBN
      *    入院取消
           WHEN    "05"
               MOVE    "3001"      TO  SPA-I0IDCD
               GO  TO  480-TOUROKU-EXT
      *    入院取消（会計含む）
           WHEN    "06"
               MOVE    "3002"      TO  SPA-I0IDCD
               GO  TO  480-TOUROKU-EXT
      *    退院取消
           WHEN    "07"
               MOVE    "3003"      TO  SPA-I0IDCD
               GO  TO  480-TOUROKU-EXT
      *    その他
           WHEN    OTHER
               MOVE    "UPD"       TO  WRK-UPDKBN
           END-EVALUATE
      *
           PERFORM 4801-PTNYUINRRK-UPD-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  480-TOUROKU-EXT
           END-IF
      *
           .
      *
       480-TOUROKU-EXT.
           EXIT.
      *****************************************************************
      *    患者履歴マスタ更新処理
      *****************************************************************
       4801-PTNYUINRRK-UPD-SEC     SECTION.
      *
      *    入院履歴データ編集
           PERFORM 4801-PTNYUINRRK-EDIT-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4801-PTNYUINRRK-UPD-EXT
           END-IF
      *
           EVALUATE WRK-UPDKBN
           WHEN    "INS"
      *        入院履歴マスタ追加
               MOVE    "PTNYUINRRK-KEY"
                                       TO  WRK-DBPATH
               MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
               PERFORM 900-TBL-INSERT-SEC
           WHEN    "UPD"
      *        入院履歴マスタ更新
               MOVE    "PTNYUINRRK-KEY"
                                       TO  WRK-DBPATH
               MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
               PERFORM 900-TBL-UPDATE-SEC
           WHEN    "DEL"
      *        入院履歴マスタ削除
               MOVE    "PTNYUINRRK-DEL1"
                                       TO  WRK-DBPATH
               MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
               PERFORM 900-TBL-DELETE-SEC
           END-EVALUATE
      *
           IF    ( FLG-DBRC    NOT =   ZERO )
      *        入院歴を再編集
               PERFORM 4101-NYUREKI-EDIT-SEC
               MOVE    "2005"      TO  SPA-ERRCD
               GO  TO  4801-PTNYUINRRK-UPD-EXT
           END-IF
      *
      *    入院会計テーブルを編集する（入院時・転室時）
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "01"
                                           OR  "08" )
               PERFORM 4801-NYUKAIKEI-EDIT-SEC
               IF    ( SPA-ERRCD       NOT =   SPACE )
                   GO  TO  4801-PTNYUINRRK-UPD-EXT
               END-IF
           END-IF
      *
      *    入院会計テーブルを編集する（入院取消時）
           IF     SPA-GMN-I01-SYORIKBN-CD =   "05"  OR  "06"
               PERFORM 4801-NYUKAIKEI-ERASE-SEC
           END-IF
      *
      *    入院会計テーブルを編集する（退院取消時）
           IF     SPA-GMN-I01-SYORIKBN-CD =   "07"
               PERFORM 4801-TAIINKAIKEI-CANCEL-SEC
           END-IF
      *
      *    入院会計テーブルを編集する（転科／転棟／転室時）
           IF     SPA-GMN-I01-SYORIKBN-CD =   "08"
               PERFORM 4801-TENROOM-EDIT-SEC
           END-IF
      *
      *    患者情報の入院歴番号を更新する
           PERFORM 4801-PTINF-UPD-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4801-PTNYUINRRK-UPD-EXT
           END-IF
      *
      *    前回患者情報を設定
           MOVE SPA-NAI-I01-PTID   TO  SPA-LAST-PTID
           MOVE SPA-GMN-I01-PTNUM  TO  SPA-LAST-PTNUM
      *
      *    画面を更新後の内容で再表示
           PERFORM 4101-PTNUM-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4801-PTNYUINRRK-UPD-EXT
           END-IF
           .
      *
       4801-PTNYUINRRK-UPD-EXT.
           EXIT.
      *****************************************************************
      *    関連チェック処理
      *****************************************************************
       4801-KANREN-CHK-SEC         SECTION.
      *
      *    保険組合せが存在すること
      *    IF    ( SPA-GMN-I01-HKNCOMBI-CNT    >   ZERO )
      *        CONTINUE
      *    ELSE
      *        MOVE    "1021"      TO  SPA-ERRCD
      *        MOVE    1           TO  SPA-GMN-I01-CUR
      *        GO  TO  4801-KANREN-CHK-EXT
      *    END-IF
      *
      *    必須入力チェック
      *    病室番号
           IF    ( SPA-GMN-I01-BRMNUM      =   SPACE )
               MOVE    "1003"      TO  SPA-ERRCD
               MOVE    4           TO  SPA-GMN-I01-CUR
               GO  TO  4801-KANREN-CHK-EXT
           END-IF
      *
      *    病棟名
           IF    ( SPA-GMN-I01-BTUNAME     =   SPACE )
               MOVE    "1004"      TO  SPA-ERRCD
               MOVE    5           TO  SPA-GMN-I01-CUR
               GO  TO  4801-KANREN-CHK-EXT
           END-IF
      *
      *    入院日
           IF    ( SPA-GMN-I01-NYUINYMD    =   SPACE )
               MOVE    "1005"      TO  SPA-ERRCD
               MOVE    7           TO  SPA-GMN-I01-CUR
               GO  TO  4801-KANREN-CHK-EXT
           END-IF
      *
      *    入院科
           IF    ( SPA-GMN-I01-NYUINKA     =   SPACE )
               MOVE    "1006"      TO  SPA-ERRCD
               MOVE    8           TO  SPA-GMN-I01-CUR
               GO  TO  4801-KANREN-CHK-EXT
           END-IF
      *
      *    初回
           IF    ( SPA-GMN-I01-SHOKAI      =   SPACE )
               MOVE    "1007"      TO  SPA-ERRCD
               MOVE    9           TO  SPA-GMN-I01-CUR
               GO  TO  4801-KANREN-CHK-EXT
           END-IF
      *
      *    初回履歴番号
           IF    ( SPA-GMN-I01-SHOKAI-CD   =   "2" )
               IF    ( SPA-GMN-I01-SHONUM  =   ZERO )
                   MOVE    "1022"      TO  SPA-ERRCD
                   MOVE    10          TO  SPA-GMN-I01-CUR
                   GO  TO  4801-KANREN-CHK-EXT
               END-IF
           END-IF
      *
      *    担当医
      ***  IF    ( SPA-GMN-I01-DR (1)         =   SPACE )
      *     AND  ( SPA-GMN-I01-DR (2)         =   SPACE )
      *     AND  ( SPA-GMN-I01-DR (3)         =   SPACE )
      *        MOVE    "1008"      TO  SPA-ERRCD
      *        MOVE    11          TO  SPA-GMN-I01-CUR
      *        GO  TO  4801-KANREN-CHK-EXT
      *    END-IF
      *
      *
      *    保険組合せ
           IF    ( SPA-GMN-I01-HKNCOMBI    =   SPACE )
            AND  ( SPA-GMN-I01-SYORIKBN-CD =   "01" OR "08" )
               MOVE    "1009"      TO  SPA-ERRCD
               MOVE    15          TO  SPA-GMN-I01-CUR
               GO  TO  4801-KANREN-CHK-EXT
           END-IF
      *
      *    定期請求
           IF    ( SPA-GMN-I01-SEIKYU      =   SPACE )
               MOVE    "1010"      TO  SPA-ERRCD
               MOVE    18          TO  SPA-GMN-I01-CUR
               GO  TO  4801-KANREN-CHK-EXT
           END-IF
      *
      *    検索時患者表示
           IF    ( SPA-GMN-I01-DISPKBN     =   SPACE )
               MOVE    "1011"      TO  SPA-ERRCD
               MOVE    19          TO  SPA-GMN-I01-CUR
               GO  TO  4801-KANREN-CHK-EXT
           END-IF
      *
      *    処理区分固有の関連チェック
           EVALUATE    SPA-GMN-I01-SYORIKBN-CD
      *    入院登録
           WHEN    "01"
               PERFORM 4801-NYUIN-TOUROKU-CHK-SEC
      *    退院登録
           WHEN    "02"
               PERFORM 4801-TAIIN-TOUROKU-CHK-SEC
      *    変更
           WHEN    "03"
               PERFORM 4801-HENKOU-CHK-SEC
      *    照会
           WHEN    "04"
               PERFORM 4801-SYOKAI-CHK-SEC
      *    入院取消
           WHEN    "05"
           WHEN    "06"
               PERFORM 4801-NYUIN-TORIKESI-CHK-SEC
      *    退院取消
           WHEN    "07"
               PERFORM 4801-TAIIN-TORIKESI-CHK-SEC
      *    転科　転棟　転室
           WHEN    "08"
               PERFORM 4801-TEKNA-CHK-SEC
           END-EVALUATE
      *
           .
       4801-KANREN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院登録時関連チェック
      *****************************************************************
       4801-NYUIN-TOUROKU-CHK-SEC      SECTION.
      *
      *    前回退院日＜入院日となっていること
           IF    ( SPA-NAI-I01-TTAIINYMD (1) NOT =   SPACE )
               IF    ( SPA-NAI-I01-TTAIINYMD (1)
                                  <    SPA-NAI-I01-NYUINYMD )
                   CONTINUE
               ELSE
                   MOVE    "1018"      TO  SPA-ERRCD
                   MOVE    7           TO  SPA-GMN-I01-CUR
                   GO  TO  4801-NYUIN-TOUROKU-CHK-EXT
               END-IF
           END-IF
      *
           .
       4801-NYUIN-TOUROKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    退院登録時関連チェック
      *****************************************************************
       4801-TAIIN-TOUROKU-CHK-SEC      SECTION.
      *
      *    退院日
           IF    ( SPA-GMN-I01-TAIINYMD    =   SPACE )
               MOVE    "1020"      TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-I01-CUR
               GO  TO  4801-TAIIN-TOUROKU-CHK-EXT
           END-IF
      *
      *    前回異動日が表示されていない場合は入院日と退院日を比較
      *    前回異動日が表示されている場合は前回異動日と退院日を比較
           IF    ( SPA-GMN-I01-MAEIDOYMD  =   SPACE   )
               IF    ( SPA-NAI-I01-NYUINYMD
                                      <=   SPA-NAI-I01-TAIINYMD )
                   CONTINUE
               ELSE
                   MOVE    "1012"      TO  SPA-ERRCD
                   MOVE    11          TO  SPA-GMN-I01-CUR
                   GO  TO  4801-TAIIN-TOUROKU-CHK-EXT
               END-IF
           ELSE
               IF    ( SPA-NAI-I01-MAEIDOYMD
                                      <=   SPA-NAI-I01-TAIINYMD )
                   CONTINUE
               ELSE
                   MOVE    "1013"      TO  SPA-ERRCD
                   MOVE    11          TO  SPA-GMN-I01-CUR
                   GO  TO  4801-TAIIN-TOUROKU-CHK-EXT
               END-IF
           END-IF
      *
      *    前回定期請求日の翌日〜算定開始日の翌月までの
      *    日付が入力されていること
      * *  前回定期請求日の翌日→暫定的に入院日とする * 
           MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  WRK-YMD
           MOVE    "2"             TO  WRK-ZOGENPTN
           MOVE    1               TO  WRK-ZOGEN
           PERFORM 5002-CALENDAR-SEC
      *
           IF    ( SPA-NAI-I01-TAIINYMD (1 : 6)
                                   <= WRK-KEISANYMD (1 : 6) )
               CONTINUE
           ELSE
               MOVE    "1025"      TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-I01-CUR
               GO  TO  4801-TAIIN-TOUROKU-CHK-EXT
           END-IF
      *
           .
       4801-TAIIN-TOUROKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    変更時関連チェック
      *****************************************************************
       4801-HENKOU-CHK-SEC             SECTION.
      *
      *
           .
       4801-HENKOU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    照会時関連チェック
      *****************************************************************
       4801-SYOKAI-CHK-SEC             SECTION.
      *
      *
           .
       4801-SYOKAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院取消時関連チェック
      *****************************************************************
       4801-NYUIN-TORIKESI-CHK-SEC     SECTION.
      *
      *
           .
       4801-NYUIN-TORIKESI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    退院取消時関連チェック
      *****************************************************************
       4801-TAIIN-TORIKESI-CHK-SEC     SECTION.
      *
        
      *
           .
       4801-TAIIN-TORIKESI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    転科　転棟　転室時関連チェック
      *****************************************************************
       4801-TEKNA-CHK-SEC              SECTION.
      *
      *    異動日が入力されていること
           IF    ( SPA-GMN-I01-IDOYMD  =   SPACE )
               MOVE    "1014"      TO  SPA-ERRCD
               MOVE    3           TO  SPA-GMN-I01-CUR
               GO  TO  4801-TEKNA-CHK-EXT
           END-IF
      *
      *    前回異動日が表示されていない場合は入院日と異動日を比較
      *    前回異動日が表示されている場合は前回異動日と異動日を比較
           IF    ( SPA-GMN-I01-MAEIDOYMD  =   SPACE   )
               IF    ( SPA-NAI-I01-NYUINYMD
                                      <=   SPA-NAI-I01-IDOYMD )
                   CONTINUE
               ELSE
                   MOVE    "1015"      TO  SPA-ERRCD
                   MOVE    3           TO  SPA-GMN-I01-CUR
                   GO  TO  4801-TEKNA-CHK-EXT
               END-IF
           ELSE
               IF    ( SPA-NAI-I01-MAEIDOYMD
                                      <=   SPA-NAI-I01-IDOYMD )
                   CONTINUE
               ELSE
                   MOVE    "1016"      TO  SPA-ERRCD
                   MOVE    3           TO  SPA-GMN-I01-CUR
                   GO  TO  4801-TEKNA-CHK-EXT
               END-IF
           END-IF
      *
      *    入院科または、病室番号または、病棟名のいずれかが
      *    変更されていること 
           IF    ( SPA-GMN-I01-NYUINKA =   SPA-NAI-I01-NYUINKA-MOT )
            AND  ( SPA-GMN-I01-BTUNAME =   SPA-NAI-I01-BTUNAME-MOT )
            AND  ( SPA-GMN-I01-BRMNUM  =   SPA-NAI-I01-BRMNUM-MOT  )
                   MOVE    "1017"      TO  SPA-ERRCD
                   MOVE    4           TO  SPA-GMN-I01-CUR
                   GO  TO  4801-TEKNA-CHK-EXT
           END-IF
      *
           .
       4801-TEKNA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴データ編集
      *****************************************************************
       4801-PTNYUINRRK-EDIT-SEC    SECTION.
      *
      *    入院履歴データ編集前処理
           PERFORM 4801-PTNYUINRRK-EDIT-MAE-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4801-PTNYUINRRK-EDIT-EXT
           END-IF
      *
           INITIALIZE              PTNYUINRRK-REC
      *
      *    医療機関ＩＤ
           MOVE    SPA-HOSPID      TO  PTNYUINRRK-HOSPID
      *
      *    患者ＩＤ
           MOVE    SPA-NAI-I01-PTID
                                   TO  PTNYUINRRK-PTID
      *
      *    入院履歴番号（入院１回で＋１ずつ採番）
           MOVE    WRK-RRKNUM      TO  PTNYUINRRK-RRKNUM
      *
      *    入院履歴枝番号（転科・転室・転棟時に採番）
           MOVE    WRK-RRKEDANUM   TO  PTNYUINRRK-RRKEDANUM
      *
           IF    ( WRK-UPDKBN      =   "DEL" )
               GO  TO  4801-PTNYUINRRK-EDIT-EXT
           END-IF
      *
      *    病棟番号
           MOVE    SPA-GMN-I01-BTUNAME-CD
                                   TO  PTNYUINRRK-BTUNUM
           MOVE    SPA-GMN-I01-BTUNAME-CD
                                   TO  PTNYUINRRK-BRMNUM (1 : 2)
      *
      *    病棟名称
      *    MOVE    SPA-GMN-I01-BTUNAME-NM
      *                            TO  PTNYUINRRK-BTUNAME
      *
      *    病室番号
           MOVE    SPA-GMN-I01-BRMNUM
                                   TO  WRK-BRMNUM
      *    病室番号が数字の場合、前ゼロ編集を行う
           PERFORM 4800-BRMNUM-EDIT-SEC
           MOVE    WRK-BRMNUM-EDT  TO  PTNYUINRRK-BRMNUM (3 : 6)
      *    入院科
           MOVE    SPA-GMN-I01-NYUINKA-CD
                                   TO  PTNYUINRRK-NYUINKA
      *    保険組合せ番号
           MOVE    SPA-GMN-I01-HKNCOMBI-CD
                                   TO  PTNYUINRRK-HKNCOMBINUM
      *    入院日
           MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  PTNYUINRRK-NYUINYMD
      *    退院日
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "02" )
               MOVE    SPA-NAI-I01-TAIINYMD
                                   TO  PTNYUINRRK-TAIINYMD
           ELSE
               MOVE    "99999999"  TO  PTNYUINRRK-TAIINYMD
           END-IF
      *
      *    特定入院料区分
           MOVE    SPA-NAI-I01-TOKNYUIN-ORG-KBN
                                   TO  PTNYUINRRK-TOKUTEI-KBN
      *    特定入院料
           MOVE    SPA-NAI-I01-TOKNYUIN-ORG-CD
                                   TO  PTNYUINRRK-TOKUTEI-NYUIN
      *    室料差額
           MOVE    SPA-GMN-I01-SAGAKU-CD
                                   TO  PTNYUINRRK-RM-SAGAKU
      *    定期請求区分
           MOVE    SPA-GMN-I01-SEIKYU-CD
                                   TO  PTNYUINRRK-TEIKI-SEIKYUKBN
      *    検索表示区分
           MOVE    SPA-GMN-I01-DISPKBN-CD
                                   TO  PTNYUINRRK-KENSAKU-DISPKBN
      *    初回継続区分
           MOVE    SPA-GMN-I01-SHOKAI-CD
                                   TO  PTNYUINRRK-SHOKAIKBN
      *    初回番号
           MOVE    WRK-SHONUM
                                   TO  PTNYUINRRK-SHONUM
      *
      *    担当医１
           IF    ( SPA-GMN-I01-DR-CD (1)   NOT =   SPACE )
               MOVE    "1"         TO  PTNYUINRRK-DRCD1 ( 1 : 1 ) 
               MOVE    SPA-GMN-I01-DR-CD (1)
                                   TO  PTNYUINRRK-DRCD1 ( 2 : )
           END-IF
      *    担当医２
           IF    ( SPA-GMN-I01-DR-CD (2)   NOT =   SPACE )
               MOVE    "1"         TO  PTNYUINRRK-DRCD2 ( 1 : 1 ) 
               MOVE    SPA-GMN-I01-DR-CD (2)
                                   TO  PTNYUINRRK-DRCD2 ( 2 : )
           END-IF
      *    担当医３
           IF    ( SPA-GMN-I01-DR-CD (3)   NOT =   SPACE )
               MOVE    "1"         TO  PTNYUINRRK-DRCD3 ( 1 : 1 ) 
               MOVE    SPA-GMN-I01-DR-CD (3)
                                   TO  PTNYUINRRK-DRCD3 ( 2 : )
           END-IF
      *    状態区分
      *    （１：入院　２：転科　３：転棟　４：転室　５：他院歴）
      *    転入日
      *    転出日
           EVALUATE    SPA-GMN-I01-SYORIKBN-CD
      *    入院登録
           WHEN    "01"
               MOVE    "1"         TO  PTNYUINRRK-JTIKBN
               MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  PTNYUINRRK-TENNYUYMD
               MOVE    "99999999"  TO  PTNYUINRRK-TENSTUYMD
      *    退院登録
      *    WHEN    "02"
      *        MOVE    WRK-JTIKBN  TO  PTNYUINRRK-JTIKBN
      *        MOVE    WRK-TENNYUYMD
      *                            TO  PTNYUINRRK-TENNYUYMD
      *        MOVE    SPA-NAI-I01-TAIINYMD
      *                            TO  PTNYUINRRK-TENSTUYMD
      *    退院取消
           WHEN    "07"
               MOVE    WRK-JTIKBN  TO  PTNYUINRRK-JTIKBN
               MOVE    WRK-TENNYUYMD
                                   TO  PTNYUINRRK-TENNYUYMD
               MOVE    "99999999"  TO  PTNYUINRRK-TENSTUYMD
      *    転科　転棟　転室
           WHEN    "08"
      *
               EVALUATE    TRUE
      *        科が変わった場合
               WHEN    WRK-NYUINKA-KEY NOT =   PTNYUINRRK-NYUINKA
                   MOVE    "2"   TO  PTNYUINRRK-JTIKBN
      *        病棟が変わった場合
               WHEN    WRK-BTUNUM-KEY  NOT =   PTNYUINRRK-BTUNUM
                   MOVE    "3"   TO  PTNYUINRRK-JTIKBN
      *        病室が変わった場合
               WHEN    WRK-BRMNUM-KEY  NOT =   PTNYUINRRK-BRMNUM
                   MOVE    "4"   TO  PTNYUINRRK-JTIKBN
               END-EVALUATE
      *
               MOVE    SPA-NAI-I01-IDOYMD
                                   TO  PTNYUINRRK-TENNYUYMD
               MOVE    "99999999"  TO  PTNYUINRRK-TENSTUYMD
      *    その他
           WHEN    OTHER
               MOVE    WRK-JTIKBN  TO  PTNYUINRRK-JTIKBN
               MOVE    WRK-TENNYUYMD
                                   TO  PTNYUINRRK-TENNYUYMD
               MOVE    WRK-TENSTUYMD
                                   TO  PTNYUINRRK-TENSTUYMD
           END-EVALUATE
      *
           IF    ( WRK-UPDKBN      =   "UPD" )
               ACCEPT  SYS-TIME        FROM    TIME
               MOVE    SYS-TIME    TO  PTNYUINRRK-UPHMS
               MOVE    SPA-SYSYMD  TO  PTNYUINRRK-UPYMD
               MOVE    WRK-CREYMD  TO  PTNYUINRRK-CREYMD
           ELSE
               MOVE    SPA-SYSYMD  TO  PTNYUINRRK-CREYMD
           END-IF
      *
           .
      *
       4801-PTNYUINRRK-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院履歴データ編集
      *****************************************************************
       4801-PTNYUINRRK-EDIT-MAE-SEC    SECTION.
      *
           MOVE    SPACE           TO  WRK-CREYMD
                                       WRK-TENNYUYMD
                                       WRK-TENSTUYMD
                                       WRK-NYUINKA-KEY
                                       WRK-BTUNUM-KEY
                                       WRK-BRMNUM-KEY
           MOVE    ZERO            TO  WRK-SHONUM
      *
           MOVE    SPA-NAI-I01-PTRRKNUM
                                   TO  WRK-RRKNUM
           MOVE    SPA-NAI-I01-PTRRKEDANUM
                                   TO  WRK-RRKEDANUM
      *
      *    入院登録で初回の場合、設定する初回番号を求める
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "01" )
            AND  ( SPA-GMN-I01-SHOKAI-CD   =   "1"  )
               PERFORM 4801-SYOKAI-GET-SEC
           ELSE
               COMPUTE WRK-SHONUM      =   SPA-GMN-I01-SHONUM
           END-IF
      *
      *    退院処理時、履歴を遡って退院日を更新する
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "07" )
               PERFORM 4801-TAIINYMD-UPD-SEC
      *
      *        収納データを削除する
               PERFORM 4801-SYUNOU-DEL-SEC
               IF    ( SPA-ERRCD       NOT =   SPACE )
                   GO  TO  4801-PTNYUINRRK-EDIT-MAE-EXT
               END-IF
      *
           END-IF
      *
      *    入院取消時、転科歴をワークに退避する
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "05"  OR  "06" )
               PERFORM 4801-TENKAREKI-TAIHI-SEC
           END-IF
      *
      *    転科・転棟・転室の場合、転出元の歴の転出日に異動日を設定
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "08" )
               PERFORM 4801-TENSYUTU-MOTO-UPD-SEC
               IF    ( SPA-ERRCD       NOT =   SPACE )
                   GO  TO  4801-PTNYUINRRK-EDIT-MAE-EXT
               END-IF
           END-IF
      *
           PERFORM 4801-RRKNUM-EDIT-SEC
      *
      *    入院履歴マスタ検索
           PERFORM 4801-PTNYUINRRK-SEL-SEC
           IF    ( FLG-PTNYUINRRK  =   ZERO )
      *        追加処理時、既にデータが存在する場合はエラーとする
               IF    ( WRK-UPDKBN  =   "INS" )
      *            入院歴を再編集
                   PERFORM 4101-NYUREKI-EDIT-SEC
                   MOVE    "2001"  TO  SPA-ERRCD
                   GO  TO  4801-PTNYUINRRK-EDIT-MAE-EXT
               ELSE
      *
      *            更新データ用に状態区分等を退避
                   MOVE    PTNYUINRRK-JTIKBN
                                   TO  WRK-JTIKBN
                   MOVE    PTNYUINRRK-TENNYUYMD
                                   TO  WRK-TENNYUYMD
                   MOVE    PTNYUINRRK-TENSTUYMD
                                   TO  WRK-TENSTUYMD
                   MOVE    PTNYUINRRK-CREYMD
                                   TO  WRK-CREYMD
               END-IF
           ELSE
      *        更新・削除処理時、対象データが存在しなければエラーとする
               IF    ( WRK-UPDKBN  =   "UPD" OR "DEL")
      *            入院歴を再編集
                   PERFORM 4101-NYUREKI-EDIT-SEC
                   MOVE    "2002"  TO  SPA-ERRCD
                   GO  TO  4801-PTNYUINRRK-EDIT-MAE-EXT
               END-IF
           END-IF
      *
      *
           .
       4801-PTNYUINRRK-EDIT-MAE-EXT.
           EXIT.
      *****************************************************************
      *    初回番号取得処理
      *****************************************************************
       4801-SYOKAI-GET-SEC         SECTION.
      *
      *    入院履歴マスタ検索
           MOVE    ZERO                TO  FLG-PTNYUINRRK
           INITIALIZE  PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  PTNYUINRRK-PTID
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY6"   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO  )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
           MOVE    "PTNYUINRRK-KEY6"   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( FLG-PTNYUINRRK  NOT =   ZERO )
               COMPUTE WRK-SHONUM  =   1
           ELSE
               COMPUTE WRK-SHONUM  =   PTNYUINRRK-SHONUM   +   1
           END-IF
      *
           .
       4801-SYOKAI-GET-EXT.
           EXIT.
      *****************************************************************
      *    退院日更新処理
      *****************************************************************
       4801-TAIINYMD-UPD-SEC       SECTION.
      *
           MOVE    ZERO                TO  WRK-TAIINUPDCNT
      *
      *    入院履歴マスタ検索
           INITIALIZE  PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  PTNYUINRRK-PTID
           MOVE    SPA-NAI-I01-PTRRKNUM
                                       TO  PTNYUINRRK-RRKNUM
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY4"   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
      *    入院歴の退院日を更新する。
           PERFORM UNTIL ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
      *
               COMPUTE WRK-TAIINUPDCNT
                   =   WRK-TAIINUPDCNT +   1
      *
      *        最新歴は別途更新処理を行う
               IF    ( WRK-TAIINUPDCNT =   1 )
                   IF    ( SPA-NAI-I01-PTRRKNUM
                                       =   PTNYUINRRK-RRKNUM )
                    AND  ( SPA-NAI-I01-PTRRKEDANUM
                                       =   PTNYUINRRK-RRKEDANUM )
                       CONTINUE
                   ELSE
                       MOVE    "2004"  TO  SPA-ERRCD
                       GO  TO  4801-TAIINYMD-UPD-EXT
                   END-IF
               ELSE
                   MOVE    "99999999"
                                       TO  PTNYUINRRK-TAIINYMD
                   ACCEPT  SYS-TIME        FROM    TIME
                   MOVE    SYS-TIME    TO  PTNYUINRRK-UPHMS
                   MOVE    SPA-SYSYMD  TO  PTNYUINRRK-UPYMD
      *
                   MOVE    "PTNYUINRRK-KEY"
                                       TO  WRK-DBPATH
                   MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
                   PERFORM 900-TBL-UPDATE-SEC
                   IF    ( FLG-DBRC    NOT =   ZERO )
                       MOVE    "2004"  TO  SPA-ERRCD
                       GO  TO  4801-TAIINYMD-UPD-EXT
                   END-IF
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY4"   TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "PTNYUINRRK-KEY4"   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( WRK-TAIINUPDCNT     =   ZERO )
               MOVE    "2004"  TO  SPA-ERRCD
               GO  TO  4801-TAIINYMD-UPD-EXT
           END-IF
      *
      *
           .
       4801-TAIINYMD-UPD-EXT.
           EXIT.
      *****************************************************************
      *    収納データ削除処理
      *****************************************************************
       4801-SYUNOU-DEL-SEC         SECTION.
      *
           INITIALIZE  SYUNOU-REC
      *
           MOVE    SPA-HOSPID      TO  SYU-HOSPID
           MOVE    SPA-NAI-I01-PTID
                                   TO  SYU-PTID
           MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  SYU-SKYSTYMD
           MOVE    SPA-NAI-I01-TAIINYMD
                                   TO  SYU-SKYEDYMD
           MOVE    SYUNOU-REC      TO  MCPDATA-REC
           MOVE    "SYUNOU-DEL2"   TO  WRK-DBPATH
           PERFORM 900-TBL-DELETE-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    "2009"  TO  SPA-ERRCD
               GO  TO  4801-SYUNOU-DEL-EXT
           END-IF
           .
      *
       4801-SYUNOU-DEL-EXT.
           EXIT.
      *****************************************************************
      *    転科歴退避処理
      *****************************************************************
       4801-TENKAREKI-TAIHI-SEC    SECTION.
      *
           INITIALIZE  WRK-TENKA-SRYKA-TBL
      *
      *    入院履歴マスタ検索
           INITIALIZE  PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  PTNYUINRRK-PTID
           MOVE    SPA-NAI-I01-PTRRKNUM
                                       TO  PTNYUINRRK-RRKNUM
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY4"   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM UNTIL ( FLG-DBRC    NOT =   ZERO )
                   OR    ( WRK-TENKA-SRYKA-CNT
                                          >=  50 )
      *
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
      *
               MOVE    ZERO            TO  FLG-TENKA-SRYKA
               PERFORM VARYING IDX9    FROM    1   BY  1
                       UNTIL ( IDX9    >   50 )
                        OR   ( WRK-TENKA-SRYKA (IDX9) = SPACE )
                        OR   ( FLG-TENKA-SRYKA NOT    = ZERO  )
      *
                   IF    ( WRK-TENKA-SRYKA (IDX9)
                                       =   PTNYUINRRK-NYUINKA )
                       MOVE    1       TO  FLG-TENKA-SRYKA
                   END-IF
      *
               END-PERFORM
      *
               IF    ( FLG-TENKA-SRYKA =   ZERO )
                   COMPUTE WRK-TENKA-SRYKA-CNT
                       =   WRK-TENKA-SRYKA-CNT +   1
                   MOVE    PTNYUINRRK-NYUINKA
                                       TO  WRK-TENKA-SRYKA
                                               (WRK-TENKA-SRYKA-CNT)
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY4"   TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "PTNYUINRRK-KEY4"   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4801-TENKAREKI-TAIHI-EXT.
           EXIT.
      *****************************************************************
      *    転出元歴更新処理
      *****************************************************************
       4801-TENSYUTU-MOTO-UPD-SEC  SECTION.
      *
      *    入院履歴マスタ検索
           PERFORM 4801-PTNYUINRRK-SEL-SEC
           IF    ( FLG-PTNYUINRRK  NOT =   ZERO )
               MOVE    "2003"  TO  SPA-ERRCD
               GO  TO  4801-TENSYUTU-MOTO-UPD-EXT
           END-IF
      *
           MOVE    SPA-NAI-I01-IDOYMD
                               TO  PTNYUINRRK-TENSTUYMD
      *
           ACCEPT  SYS-TIME        FROM    TIME
           MOVE    SYS-TIME    TO  PTNYUINRRK-UPHMS
           MOVE    SPA-SYSYMD  TO  PTNYUINRRK-UPYMD
      *
           MOVE    "PTNYUINRRK-KEY"
                               TO  WRK-DBPATH
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
           PERFORM 900-TBL-UPDATE-SEC
           IF    ( FLG-DBRC    NOT =   ZERO )
               MOVE    "2004"  TO  SPA-ERRCD
               GO  TO  4801-TENSYUTU-MOTO-UPD-EXT
           END-IF
      *
      *    更新データ用に入院科等を退避
           MOVE    PTNYUINRRK-NYUINKA
                               TO  WRK-NYUINKA-KEY
           MOVE    PTNYUINRRK-BTUNUM
                               TO  WRK-BTUNUM-KEY
           MOVE    PTNYUINRRK-BRMNUM
                               TO  WRK-BRMNUM-KEY
      *
           .
       4801-TENSYUTU-MOTO-UPD-EXT.
           EXIT.
      *****************************************************************
      *    入院歴番号採番処理
      *****************************************************************
       4801-RRKNUM-EDIT-SEC        SECTION.
      *
           EVALUATE    SPA-GMN-I01-SYORIKBN-CD
      *    入院
           WHEN    "01"
      *
               MOVE    ZERO                TO  FLG-PTNYUINRRK
               INITIALIZE  PTNYUINRRK-REC
               MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
               MOVE    SPA-NAI-I01-PTID    TO  PTNYUINRRK-PTID
               MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
               MOVE    "PTNYUINRRK-KEY9"   TO  WRK-DBPATH
               PERFORM 900-TBL-SELECT-SEC
               IF    ( FLG-DBRC    =   ZERO )
                   MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
               ELSE
                   MOVE    1               TO  FLG-PTNYUINRRK
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY9"   TO  WRK-DBPATH
               PERFORM 900-TBL-CLOSE-SEC
      *
               IF    ( FLG-PTNYUINRRK  NOT =   ZERO )
                   COMPUTE     WRK-RRKNUM      =   1
                   COMPUTE     WRK-RRKEDANUM   =   1
               ELSE
                   COMPUTE     WRK-RRKNUM      =   PTNYUINRRK-RRKNUM
                                               +   1
                   COMPUTE     WRK-RRKEDANUM   =   1
               END-IF
      *
      *    転科　転棟　転室
           WHEN    "08"
               COMPUTE     WRK-RRKEDANUM   =   WRK-RRKEDANUM   +   1
      *    その他
           WHEN    OTHER
               CONTINUE
           END-EVALUATE
      *
           .
       4801-RRKNUM-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴検索処理
      *****************************************************************
       4801-PTNYUINRRK-SEL-SEC     SECTION.
      *
      *    入院履歴検索
           MOVE    ZERO                TO  FLG-PTNYUINRRK
      *
           INITIALIZE  PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  PTNYUINRRK-PTID
           MOVE    WRK-RRKNUM          TO  PTNYUINRRK-RRKNUM
           MOVE    WRK-RRKEDANUM       TO  PTNYUINRRK-RRKEDANUM
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY"    TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO  )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
      *    入院履歴クローズ
           MOVE    "PTNYUINRRK-KEY"    TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4801-PTNYUINRRK-SEL-EXT.
           EXIT.
      *****************************************************************
      *    病室番号編集処理
      *****************************************************************
       4800-BRMNUM-EDIT-SEC        SECTION.
      *
           MOVE    SPACE       TO  WRK-STR1
           MOVE    1           TO  WRK-IDX1
           STRING  WRK-BRMNUM
               DELIMITED   BY  SPACE
               INTO    WRK-STR1
               WITH    POINTER WRK-IDX1
           END-STRING
      *
           COMPUTE WRK-IDX1    =   WRK-IDX1    -   1
      *
           IF    ( WRK-IDX1    <   1 )
               MOVE    WRK-BRMNUM  TO  WRK-BRMNUM-EDT
               GO  TO  4800-BRMNUM-EDIT-EXT
           END-IF
      *
      *    病室番号が数字の場合ゼロ詰めを行う
           IF    ( WRK-BRMNUM ( 1 : WRK-IDX1 )
                                   IS  NUMERIC )
               COMPUTE WRK-IDX2    =   6   -   WRK-IDX1 + 1
               MOVE    ZERO    TO  WRK-BRMNUM-EDT
               MOVE    WRK-BRMNUM ( 1 : WRK-IDX1 )
                               TO  WRK-BRMNUM-EDT (WRK-IDX2 : WRK-IDX1)
           ELSE
               MOVE    WRK-BRMNUM
                               TO  WRK-BRMNUM-EDT
           END-IF
      *
           .
       4800-BRMNUM-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院　会計テーブル編集処理
      *****************************************************************
       4801-NYUKAIKEI-EDIT-SEC         SECTION.
      *
           INITIALIZE      ORCSSYOKIKSNAREA
      *
      *    通算日数、算定開始日を求める
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "01" )
               PERFORM 4801-NYUTSUSAN-SANTEI-GET-SEC
           ELSE
               PERFORM 4801-IDOTSUSAN-SANTEI-GET-SEC
           END-IF
      *
           MOVE    WRK-TSUSAN      TO  SYOKIKSN-IN-TUSANNISSU
           MOVE    WRK-SANTEISTYMD
                                   TO  SYOKIKSN-IN-SANTEISTYMD
      *
           IF      SPA-GMN-I01-TOKNYUIN-CD    NOT =   SPACE
               PERFORM   4801-TOKTEI-NYUIN-SET-SEC
           ELSE
               IF  SYS-5001-BTU-KHNSRYCD      NOT =   SPACE
                   MOVE    SYS-5001-BTU-KHNSRYCD
                                       TO  SYOKIKSN-IN-KHNSRYCD
                   PERFORM   4801-RJNCD-CHG-SEC
                   CALL    "ORCSSYOKIKSN"  USING   ORCSSYOKIKSNAREA
                   IF    ( SYOKIKSN-OT-RC  NOT =   ZERO )
                       MOVE    "2006"      TO  SPA-ERRCD
                       GO  TO  4801-NYUKAIKEI-EDIT-EXT
                   END-IF
               ELSE
                   MOVE    "2006"      TO  SPA-ERRCD
                   GO  TO  4801-NYUKAIKEI-EDIT-EXT
               END-IF
           END-IF
      *
      *    入院会計作成サブの呼出し
           INITIALIZE            ORCSNYUACCT-AREA
           MOVE     "1"     TO   LNK-SCNYUACCT-SYORI-KBN
           MOVE     "1"                TO  SPA-NYUGAIKBN
           MOVE     PTNYUINRRK-PTID    TO  SPA-PTID
           MOVE     PTNYUINRRK-NYUINKA TO  SPA-SRYKA
           MOVE    SYOKIKSN-IN-KHNSRYCD
                            TO   LNK-SCNYUACCT-NYUKHN-SRYCD(1)
           MOVE    SYOKIKSN-IN-SANTEISTYMD
                            TO   LNK-SCNYUACCT-STSRYYMD
           PERFORM   VARYING   IDX6   FROM   1   BY   1
               UNTIL (SYOKIKSN-OT-KGNSRYCD(IDX6)  =  SPACE) OR
                     (IDX6   >     7)
               MOVE   SYOKIKSN-OT-KGNSRYCD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-SRYCD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOSTYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-STYUKYMD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOEDYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-EDYUKYMD(IDX6)
           END-PERFORM
      *    通算算定済日数
           MOVE   WRK-TSUSAN    TO  LNK-SCNYUACCT-NYUKHN-NISUU
      *    入院料加算診療コード
           IF      SPA-GMN-I01-TOKNYUIN-CD    =   SPACE
               PERFORM    4801-NYUKSN-GET-SEC
           END-IF
      *    外泊
           MOVE   "099999911"   TO  LNK-SCNYUACCT-GAIHAKU-SRYCD
      *    室料差額
           MOVE   "099999912"   TO  LNK-SCNYUACCT-SAGAKU-SRYCD
           IF     PTNYUINRRK-RM-SAGAKU   =   SPACE
               MOVE    ZERO     TO  LNK-SCNYUACCT-SAGAKU-KBN
           ELSE
               MOVE   PTNYUINRRK-RM-SAGAKU 
                                TO  WRK-SAGAKU-KBN
               MOVE   WRK-SAGAKU-KBN9
                                TO  LNK-SCNYUACCT-SAGAKU-KBN
           END-IF
      *    食事区分
           MOVE   "099999913"   TO  LNK-SCNYUACCT-SHOKUJI-SRYCD
           MOVE   1             TO  LNK-SCNYUACCT-SHOKUJIKBN
      *    保険組合せ
           MOVE   "099999914"   TO  LNK-SCNYUACCT-HKNCOMBINUM-SRYCD
           MOVE   PTNYUINRRK-HKNCOMBINUM
                                TO  WRK-HKNCOMBINUM
           MOVE   WRK-HKNCOMBINUM9 
                                TO  LNK-SCNYUACCT-HKNCOMBINUM
           MOVE   SPA-SRYKA     TO  WRK-TAIHI-SRYKA
           MOVE   "00"          TO  SPA-SRYKA
           CALL   "ORCSNYUACCT"  USING   SPA-AREA
                                         ORCSNYUACCT-AREA
           MOVE   WRK-TAIHI-SRYKA TO     SPA-SRYKA
           IF     LNK-SCNYUACCT-RC   NOT =  ZERO
               DISPLAY  "ORCGI01 ORCSNYUACCT ERR RC = "
                         LNK-SCNYUACCT-RC
           END-IF
      *
           .
       4801-NYUKAIKEI-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院料加算の取り込み処理
      *****************************************************************
       4801-NYUKSN-GET-SEC         SECTION.
      *
           INITIALIZE              SYSKANRI-REC
      *
           MOVE    "5000"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタの医療機関情報より取得
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           IF   FLG-DBRC           =    ZERO
               MOVE    MCPDATA-REC TO   SYS-5000-REC
      *        入院料加算
               MOVE   ZERO             TO   IDX8
               PERFORM   VARYING   IDX7   FROM   1  BY  1
                 UNTIL  (SYS-5000-KSNCD(IDX7)    =   SPACE)  OR
                        (IDX7                    >   20)
                    IF   SYS-5000-KSNKBN(IDX7)   =   "2"
                         PERFORM   4801-NYUKSN-CHK-SEC
                         IF     FLG-NYUKSN       =   ZERO   
                             ADD    1                TO  IDX8
                             MOVE   SYS-5000-KSNCD(IDX7)  TO
                                   LNK-SCNYUACCT-NYUKHNKSN-SRYCD(IDX8)
                         END-IF
                    END-IF
               END-PERFORM
      *        地域加算
               IF   SYS-5000-CHIIKIKSN    NOT =   SPACE
                    ADD    1        TO   IDX8
                    MOVE   SYS-5000-CHIIKIKSN   TO
                                   LNK-SCNYUACCT-NYUKHNKSN-SRYCD(IDX8)
               END-IF
           END-IF
           DISPLAY  "LNK-SCNYUACCT-NYUKHNKSN-SRYCD(1) = "
                     LNK-SCNYUACCT-NYUKHNKSN-SRYCD(1)
           DISPLAY  "LNK-SCNYUACCT-NYUKHNKSN-SRYCD(2) = "
                     LNK-SCNYUACCT-NYUKHNKSN-SRYCD(2)
           DISPLAY  "LNK-SCNYUACCT-NYUKHNKSN-SRYCD(3) = "
                     LNK-SCNYUACCT-NYUKHNKSN-SRYCD(3)
           DISPLAY  "LNK-SCNYUACCT-NYUKHNKSN-SRYCD(4) = "
                     LNK-SCNYUACCT-NYUKHNKSN-SRYCD(4)
           DISPLAY  "LNK-SCNYUACCT-NYUKHNKSN-SRYCD(5) = "
                     LNK-SCNYUACCT-NYUKHNKSN-SRYCD(5)
      *
      *    システム管理マスタクローズ
           MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       4801-NYUKSN-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院料加算の算定可・不可チェック
      *****************************************************************
       4801-NYUKSN-CHK-SEC         SECTION.
      *
           MOVE    ZERO            TO  FLG-NYUKSN
      *
           EVALUATE   SYS-5000-KSNCD(IDX7)
      *        診療録管理体制加算
               WHEN   "190100370"
                   IF   SPA-GMN-I01-SYORIKBN-CD   =  "08"
                        MOVE   1        TO     FLG-NYUKSN
                   END-IF
      *            自院での継続入院チェック
           END-EVALUATE
      *
           .
      *
       4801-NYUKSN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院取消　会計テーブル編集処理
      *****************************************************************
       4801-NYUKAIKEI-ERASE-SEC         SECTION.
      *
           PERFORM     VARYING   IDX6   FROM   1   BY   1
                       UNTIL    (WRK-TENKA-SRYKA(IDX6)  =  SPACE)   OR
                                (IDX6       >   50)
                PERFORM  4801-NYUKAIKEI-ERASE-SUB-SEC
           END-PERFORM
      *
           .
       4801-NYUKAIKEI-ERASE-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院取消　会計テーブル編集処理２
      *****************************************************************
       4801-NYUKAIKEI-ERASE-SUB-SEC         SECTION.
      *
      *    入院会計作成サブの呼出し
           INITIALIZE            ORCSNYUACCT-AREA
           MOVE     SPA-GMN-I01-SYORIKBN-CD(2:1)
                                       TO   LNK-SCNYUACCT-SYORI-KBN
           MOVE     "1"                TO  SPA-NYUGAIKBN
           MOVE     PTNYUINRRK-PTID    TO  SPA-PTID
           MOVE     WRK-TENKA-SRYKA(IDX6)
                                       TO  SPA-SRYKA
           MOVE     SPA-NAI-I01-NYUINYMD
                                       TO   LNK-SCNYUACCT-STSRYYMD
      *    保険組合せ
           MOVE   PTNYUINRRK-HKNCOMBINUM
                                        TO  WRK-HKNCOMBINUM
           MOVE   WRK-HKNCOMBINUM9      TO  LNK-SCNYUACCT-HKNCOMBINUM
           MOVE   SPA-SRYKA     TO  WRK-TAIHI-SRYKA
           MOVE   "00"          TO  SPA-SRYKA
           CALL   "ORCSNYUACCT"  USING   SPA-AREA
                                         ORCSNYUACCT-AREA
           MOVE   WRK-TAIHI-SRYKA TO     SPA-SRYKA
           IF     LNK-SCNYUACCT-RC   NOT =  ZERO
                  DISPLAY  "ORCGI01 ORCSNYUACCT ERR RC = "
                            LNK-SCNYUACCT-RC
           END-IF
      *
           .
       4801-NYUKAIKEI-ERASE-SUB-EXT.
           EXIT.
      *
      *****************************************************************
      *    退院取消　会計テーブル編集処理
      *****************************************************************
       4801-TAIINKAIKEI-CANCEL-SEC         SECTION.
      *
      *    退院取消前の会計元データ作成
           INITIALIZE      ORCSSYOKIKSNAREA
      *
      *    通算日数、算定開始日を求める
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "07" )
               PERFORM 4801-NYUTSUSAN-SANTEI-GET-SEC
           ELSE
               PERFORM 4801-IDOTSUSAN-SANTEI-GET-SEC
           END-IF
      *
           MOVE    WRK-TSUSAN      TO  SYOKIKSN-IN-TUSANNISSU
           MOVE    WRK-SANTEISTYMD
                                   TO  SYOKIKSN-IN-SANTEISTYMD
      *
           DISPLAY "SYOKIKSN-IN-TUSANNISSU  = "
                    SYOKIKSN-IN-TUSANNISSU
           DISPLAY "SYOKIKSN-IN-SANTEISTYMD = "
                    SYOKIKSN-IN-SANTEISTYMD
      *
           IF      SPA-GMN-I01-TOKNYUIN-CD    NOT =   SPACE
               PERFORM   4801-TOKTEI-NYUIN-SET-SEC
           ELSE
               IF  SYS-5001-BTU-KHNSRYCD      NOT =   SPACE
                   MOVE    SYS-5001-BTU-KHNSRYCD
                                       TO  SYOKIKSN-IN-KHNSRYCD
                   PERFORM   4801-RJNCD-CHG-SEC
                   CALL    "ORCSSYOKIKSN"  USING   ORCSSYOKIKSNAREA
                   IF    ( SYOKIKSN-OT-RC  NOT =   ZERO )
                       MOVE    "2006"      TO  SPA-ERRCD
                       GO  TO  4801-TAIINKAIKEI-CANCEL-EXT
                   END-IF
               ELSE
                   MOVE    "2006"      TO  SPA-ERRCD
                   GO  TO  4801-TAIINKAIKEI-CANCEL-EXT
               END-IF
           END-IF
      *
      *    入院会計作成サブの呼出し
           INITIALIZE                      ORCSNYUACCT-AREA
           MOVE     "7"                TO  LNK-SCNYUACCT-SYORI-KBN
           MOVE     "1"                TO  SPA-NYUGAIKBN
           MOVE     PTNYUINRRK-PTID    TO  SPA-PTID
           MOVE     PTNYUINRRK-NYUINKA TO  SPA-SRYKA
           MOVE     SPA-NAI-I01-NYUINYMD
                                       TO   LNK-SCNYUACCT-STSRYYMD
           MOVE     SPA-NAI-I01-TAIINYMD
                                       TO   LNK-SCNYUACCT-EDSRYYMD
           MOVE    SYOKIKSN-IN-KHNSRYCD
                            TO   LNK-SCNYUACCT-NYUKHN-SRYCD(1)
           MOVE    SYOKIKSN-IN-SANTEISTYMD
                            TO   LNK-SCNYUACCT-STSRYYMD
           PERFORM   VARYING   IDX6   FROM   1   BY   1
               UNTIL (SYOKIKSN-OT-KGNSRYCD(IDX6)  =  SPACE) OR
                     (IDX6   >     7)
               MOVE   SYOKIKSN-OT-KGNSRYCD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-SRYCD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOSTYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-STYUKYMD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOEDYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-EDYUKYMD(IDX6)
           END-PERFORM
      *    入院料加算診療コード
           IF      SPA-GMN-I01-TOKNYUIN-CD    =   SPACE
               PERFORM    4801-NYUKSN-GET-SEC
           END-IF
      *    外泊
           MOVE   "099999911"   TO  LNK-SCNYUACCT-GAIHAKU-SRYCD
      *    室料差額
           MOVE   "099999912"   TO  LNK-SCNYUACCT-SAGAKU-SRYCD
           IF     PTNYUINRRK-RM-SAGAKU   =   SPACE
               MOVE    ZERO     TO  LNK-SCNYUACCT-SAGAKU-KBN
           ELSE
               MOVE   PTNYUINRRK-RM-SAGAKU 
                                TO  WRK-SAGAKU-KBN
               MOVE   WRK-SAGAKU-KBN9
                                TO  LNK-SCNYUACCT-SAGAKU-KBN
           END-IF
      *    食事区分
           MOVE   "099999913"   TO  LNK-SCNYUACCT-SHOKUJI-SRYCD
           MOVE   1             TO  LNK-SCNYUACCT-SHOKUJIKBN
      *    保険組合せ
           MOVE   "099999914"   TO  LNK-SCNYUACCT-HKNCOMBINUM-SRYCD
           MOVE   PTNYUINRRK-HKNCOMBINUM
                                TO  WRK-HKNCOMBINUM
           MOVE   WRK-HKNCOMBINUM9
                                TO  LNK-SCNYUACCT-HKNCOMBINUM
           MOVE   SPA-SRYKA     TO  WRK-TAIHI-SRYKA
           MOVE   "00"          TO  SPA-SRYKA
           CALL   "ORCSNYUACCT"  USING   SPA-AREA
                                         ORCSNYUACCT-AREA
           MOVE   WRK-TAIHI-SRYKA TO     SPA-SRYKA
           IF     LNK-SCNYUACCT-RC   NOT =  ZERO
                  DISPLAY  "ORCGI01 ORCSNYUACCT ERR RC = "
                            LNK-SCNYUACCT-RC
           END-IF
      *
           .
       4801-TAIINKAIKEI-CANCEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    転科／転棟／転室時　会計テーブル編集処理
      *****************************************************************
       4801-TENROOM-EDIT-SEC         SECTION.
      *
           INITIALIZE      ORCSSYOKIKSNAREA
      *
      *    通算日数、算定開始日を求める
           IF    ( SPA-GMN-I01-SYORIKBN-CD =   "01" )
               PERFORM 4801-NYUTSUSAN-SANTEI-GET-SEC
           ELSE
               PERFORM 4801-IDOTSUSAN-SANTEI-GET-SEC
           END-IF
      *
           MOVE    WRK-TSUSAN      TO  SYOKIKSN-IN-TUSANNISSU
           MOVE    WRK-SANTEISTYMD
                                   TO  SYOKIKSN-IN-SANTEISTYMD
      *
           IF      SPA-GMN-I01-TOKNYUIN-CD    NOT =   SPACE
               PERFORM   4801-TOKTEI-NYUIN-SET-SEC
           ELSE
               IF  SYS-5001-BTU-KHNSRYCD      NOT =   SPACE
                   MOVE    SYS-5001-BTU-KHNSRYCD
                                       TO  SYOKIKSN-IN-KHNSRYCD
                   PERFORM   4801-RJNCD-CHG-SEC
                   CALL    "ORCSSYOKIKSN"  USING   ORCSSYOKIKSNAREA
                   IF    ( SYOKIKSN-OT-RC  NOT =   ZERO )
                       MOVE    "2006"      TO  SPA-ERRCD
                       GO  TO  4801-TENROOM-EDIT-EXT
                   END-IF
               ELSE
                   MOVE    "2006"      TO  SPA-ERRCD
                   GO  TO  4801-TENROOM-EDIT-EXT
               END-IF
           END-IF
      *
      *    入院会計作成サブの呼出し
           INITIALIZE            ORCSNYUACCT-AREA
           MOVE    "8"                TO  LNK-SCNYUACCT-SYORI-KBN
           MOVE    "1"                TO  SPA-NYUGAIKBN
           MOVE    PTNYUINRRK-PTID    TO  SPA-PTID
           MOVE    PTNYUINRRK-NYUINKA TO  SPA-SRYKA
           MOVE    SYOKIKSN-IN-KHNSRYCD
                           TO  LNK-SCNYUACCT-NYUKHN-SRYCD(1)
           MOVE    SYOKIKSN-IN-SANTEISTYMD
                           TO   LNK-SCNYUACCT-STSRYYMD
           MOVE    SPA-NAI-I01-IDOYMD
                           TO   LNK-SCNYUACCT-EDSRYYMD
           PERFORM   VARYING   IDX6   FROM   1   BY   1
               UNTIL (SYOKIKSN-OT-KGNSRYCD(IDX6)  =  SPACE) OR
                     (IDX6   >     7)
               MOVE   SYOKIKSN-OT-KGNSRYCD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-SRYCD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOSTYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-STYUKYMD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOEDYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-EDYUKYMD(IDX6)
               DISPLAY  "IDX6 = " IDX6
           END-PERFORM
      *    通算算定済日数
           MOVE   WRK-TSUSAN    TO  LNK-SCNYUACCT-NYUKHN-NISUU
      *    入院料加算診療コード
           IF      SPA-GMN-I01-TOKNYUIN-CD    =   SPACE
               PERFORM    4801-NYUKSN-GET-SEC
           END-IF
      *    外泊
           MOVE   "099999911"   TO  LNK-SCNYUACCT-GAIHAKU-SRYCD
      *    室料差額
           MOVE   "099999912"   TO  LNK-SCNYUACCT-SAGAKU-SRYCD
           IF     PTNYUINRRK-RM-SAGAKU   =   SPACE
               MOVE    ZERO     TO  LNK-SCNYUACCT-SAGAKU-KBN
           ELSE
               MOVE   PTNYUINRRK-RM-SAGAKU 
                                TO  WRK-SAGAKU-KBN
               MOVE   WRK-SAGAKU-KBN9
                                TO  LNK-SCNYUACCT-SAGAKU-KBN
           END-IF
      *    食事区分
           MOVE   "099999913"   TO  LNK-SCNYUACCT-SHOKUJI-SRYCD
           MOVE   1             TO  LNK-SCNYUACCT-SHOKUJIKBN
      *    保険組合せ
           MOVE   "099999914"   TO  LNK-SCNYUACCT-HKNCOMBINUM-SRYCD
           MOVE   PTNYUINRRK-HKNCOMBINUM
                                TO  WRK-HKNCOMBINUM
           MOVE   WRK-HKNCOMBINUM9 
                                TO  LNK-SCNYUACCT-HKNCOMBINUM
      *    転科元入院科
           MOVE   "00"          TO  LNK-SCNYUACCT-MOTO-NYUINKA
      **     MOVE   SPA-GMN-I01-NYUINKA-MOT (1 : 2)
      **                          TO  LNK-SCNYUACCT-MOTO-NYUINKA
           MOVE   SPA-SRYKA     TO  WRK-TAIHI-SRYKA
           MOVE   "00"          TO  SPA-SRYKA
           CALL   "ORCSNYUACCT"  USING   SPA-AREA
                                         ORCSNYUACCT-AREA
           MOVE   WRK-TAIHI-SRYKA TO     SPA-SRYKA
           IF     LNK-SCNYUACCT-RC   NOT =  ZERO
               DISPLAY  "ORCGI01 ORCSNYUACCT ERR RC = "
                         LNK-SCNYUACCT-RC
           END-IF
      *
           .
       4801-TENROOM-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    通算日数、算定開始日取得処理（入院登録時）
      *****************************************************************
       4801-NYUTSUSAN-SANTEI-GET-SEC   SECTION.
      *
           INITIALIZE                  WRK-TSUSAN
                                       WRK-SANTEISTYMD
      *
      *    歴をさかのぼり通算の対象となるデータを抽出する
           INITIALIZE    WRK-REKI-ZIIN-TBL
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   50 )
               IF    ( SPA-NAI-I01-TZITA-FLG (IDX1)
                                                   =   ZERO )
                AND  ( SPA-GMN-I01-TSHONUM (IDX1)
                                   =   PTNYUINRRK-SHONUM )
      *
                   COMPUTE WRK-REKI-ZIIN-CNT
                       =   WRK-REKI-ZIIN-CNT   +   1
      *
                   MOVE    WRK-REKI-ZIIN-CNT   TO  IDX2
                   MOVE    SPA-NAI-I01-TNYUINYMD (IDX1)
                                   TO  WRK-REKI-ZIIN-NYUINYMD (IDX2)
                   MOVE    SPA-NAI-I01-TTAIINYMD (IDX1)
                                   TO  WRK-REKI-ZIIN-TAIINYMD (IDX2)
      *
                  IF    ( SPA-GMN-I01-TSHOKAI (IDX1)  =   "◎" )
                      MOVE    50              TO  IDX1
                  END-IF
      *
               END-IF
           END-PERFORM
      *
      *    入院日が前回退院日と同日の場合は、翌日を算定開始日に設定する
           IF    ( SPA-GMN-I01-NYUREKILST-CNT  >   ZERO )
            AND  ( SPA-NAI-I01-TZITA-FLG (1)   =   ZERO )
            AND  ( PTNYUINRRK-NYUINYMD
                                   =   SPA-NAI-I01-TTAIINYMD (1) )
               MOVE    PTNYUINRRK-NYUINYMD
                                   TO WRK-YMD
               MOVE    "1"         TO WRK-ZOGENPTN
               MOVE    1           TO WRK-ZOGEN
               PERFORM 5002-CALENDAR-SEC
               MOVE    WRK-KEISANYMD
                                   TO  WRK-SANTEISTYMD
           ELSE
               MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-SANTEISTYMD
           END-IF
      *
      *    今回が初回の場合、または過去に他院歴しかない場合は、
      *    以下の処理は行わない
           IF    ( PTNYUINRRK-SHOKAIKBN    =   "1" )
             OR  ( WRK-REKI-ZIIN-CNT      <=  ZERO )
               GO  TO  4801-NYUTSUSAN-SANTEI-GET-EXT
           END-IF
      *
           PERFORM VARYING IDX1
                   FROM    WRK-REKI-ZIIN-CNT
                   BY      -1
                   UNTIL ( IDX1    <   1 )
      *
               MOVE    WRK-REKI-ZIIN-NYUINYMD (IDX1)
                               TO  WRK-STYMD
               MOVE    WRK-REKI-ZIIN-TAIINYMD (IDX1)
                               TO  WRK-EDYMD
               PERFORM 5002-KIKAN-CALC-SEC
               IF    ( FLG-ORCSDAY =   ZERO )
                   IF    ( WRK-REKI-ZIIN-CNT
                                           >   IDX1 )
                    AND  ( WRK-REKI-ZIIN-NYUINYMD (IDX1)
                       =   WRK-REKI-ZIIN-TAIINYMD (IDX1 + 1) )
                       COMPUTE WRK-TSUSAN
                           =   WRK-TSUSAN  +   WRK-NISSU2  -   1
                   ELSE
                       COMPUTE WRK-TSUSAN
                           =   WRK-TSUSAN  +   WRK-NISSU2
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       4801-NYUTSUSAN-SANTEI-GET-EXT.
           EXIT.
      *****************************************************************
      *    通算日数、算定開始日取得処理（転科・転棟・転室時）
      *****************************************************************
       4801-IDOTSUSAN-SANTEI-GET-SEC   SECTION.
      *
           INITIALIZE                  WRK-NYUINNISSU
                                       WRK-TSUSAN
                                       WRK-SANTEISTYMD
      *
      *    入院日から（異動日当日を含まない）異動日までの日数を求める
      *    （入院日数とする）
           MOVE    PTNYUINRRK-NYUINYMD
                                       TO  WRK-STYMD
           MOVE    PTNYUINRRK-TENNYUYMD
                                       TO  WRK-EDYMD
           PERFORM 5002-KIKAN-CALC-SEC
           MOVE    WRK-NISSU1          TO  WRK-NYUINNISSU
      *
      *    歴をさかのぼり通算の対象となるデータを抽出する
           INITIALIZE    WRK-REKI-ZIIN-TBL
           PERFORM VARYING IDX1    FROM    2   BY  1
               UNTIL     ( IDX1    >   50 )
               IF    ( SPA-NAI-I01-TZITA-FLG (IDX1)
                                                   =   ZERO )
                AND  ( SPA-GMN-I01-TSHONUM (IDX1)
                                   =   PTNYUINRRK-SHONUM )
      *
                   COMPUTE WRK-REKI-ZIIN-CNT
                       =   WRK-REKI-ZIIN-CNT   +   1
      *
                   MOVE    WRK-REKI-ZIIN-CNT   TO  IDX2
                   MOVE    SPA-NAI-I01-TNYUINYMD (IDX1)
                                   TO  WRK-REKI-ZIIN-NYUINYMD (IDX2)
                   MOVE    SPA-NAI-I01-TTAIINYMD (IDX1)
                                   TO  WRK-REKI-ZIIN-TAIINYMD (IDX2)
      *
                  IF    ( SPA-GMN-I01-TSHOKAI (IDX1)  =   "◎" )
                      MOVE    50              TO  IDX1
                  END-IF
      *
               END-IF
           END-PERFORM
      *
      *    異動日が前回退院日と同日の場合は、翌日を算定開始日に設定する
           IF    ( SPA-GMN-I01-NYUREKILST-CNT  >   1 )
            AND  ( SPA-NAI-I01-TZITA-FLG (2)   =   ZERO )
            AND  ( PTNYUINRRK-TENNYUYMD
                                   =   SPA-NAI-I01-TTAIINYMD (2) )
               MOVE    PTNYUINRRK-TENNYUYMD
                                   TO WRK-YMD
               MOVE    "1"         TO WRK-ZOGENPTN
               MOVE    1           TO WRK-ZOGEN
               PERFORM 5002-CALENDAR-SEC
               MOVE    WRK-KEISANYMD
                                   TO  WRK-SANTEISTYMD
           ELSE
      *        異動日が前回退院日と同日で無い場合は、異動日を算定開始日
      *        に設定する。
      *        通算日数は入院日と前回退院日が同日の場合は、
      *        歴を遡って求めた通算日数＋入院日数−１
      *        そうでない場合、通算日数＋入院日数を通算日数に設定する
               MOVE    PTNYUINRRK-TENNYUYMD
                                   TO  WRK-SANTEISTYMD
               IF    ( SPA-GMN-I01-NYUREKILST-CNT  >   1 )
                AND  ( SPA-NAI-I01-TZITA-FLG (2)   =   ZERO )
                AND  ( PTNYUINRRK-NYUINYMD
                                   =   SPA-NAI-I01-TTAIINYMD (2) )
                   COMPUTE WRK-TSUSAN
                       =   WRK-TSUSAN  +   WRK-NYUINNISSU  -   1
               ELSE
                   COMPUTE WRK-TSUSAN
                       =   WRK-TSUSAN  +   WRK-NYUINNISSU
               END-IF
           END-IF
      *
      *    今回が初回の場合、または過去に他院歴しかない場合は、
      *    以下の処理は行わない
           IF    ( PTNYUINRRK-SHOKAIKBN    =   "1" )
             OR  ( WRK-REKI-ZIIN-CNT      <=  ZERO )
               GO  TO  4801-IDOTSUSAN-SANTEI-GET-EXT
           END-IF
      *
           PERFORM VARYING IDX1
                   FROM    WRK-REKI-ZIIN-CNT
                   BY      -1
                   UNTIL ( IDX1    <   1 )
      *
               MOVE    WRK-REKI-ZIIN-NYUINYMD (IDX1)
                               TO  WRK-STYMD
               MOVE    WRK-REKI-ZIIN-TAIINYMD (IDX1)
                               TO  WRK-EDYMD
               PERFORM 5002-KIKAN-CALC-SEC
               IF    ( FLG-ORCSDAY =   ZERO )
                   IF    ( WRK-REKI-ZIIN-CNT
                                           >   IDX1 )
                    AND  ( WRK-REKI-ZIIN-NYUINYMD (IDX1)
                       =   WRK-REKI-ZIIN-TAIINYMD (IDX1 + 1) )
                       COMPUTE WRK-TSUSAN
                           =   WRK-TSUSAN  +   WRK-NISSU2  -   1
                   ELSE
                       COMPUTE WRK-TSUSAN
                           =   WRK-TSUSAN  +   WRK-NISSU2
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       4801-IDOTSUSAN-SANTEI-GET-EXT.
           EXIT.
      *****************************************************************
      *    病棟情報検索処理
      *****************************************************************
       4801-BTUSEL-SEC             SECTION.
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    PTNYUINRRK-BTUNUM
                                   TO  SYS-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC
                                  TO  SYS-5001-REC
           ELSE
               MOVE    1          TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4801-BTUSEL-EXT.
           EXIT.
      *****************************************************************
      *    病室情報検索処理
      *****************************************************************
       4801-BRMSEL-SEC             SECTION.
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    "5002"          TO  SYS-KANRICD
           MOVE    PTNYUINRRK-BRMNUM
                                   TO  SYS-KBNCD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC
                                  TO  SYS-5002-REC
           ELSE
               MOVE    1          TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "SYSKANRI-KEY10"
                                   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       4801-BRMSEL-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料セット処理
      *****************************************************************
       4801-TOKTEI-NYUIN-SET-SEC   SECTION.
      *    病棟
           IF  PTNYUINRRK-TOKUTEI-KBN   =   "1"
             EVALUATE    PTNYUINRRK-TOKUTEI-NYUIN
               WHEN    "01"
                       MOVE   "190075810"   TO  SYOKIKSN-IN-KHNSRYCD
             END-EVALUATE
           END-IF
      *    病棟
           IF  PTNYUINRRK-TOKUTEI-KBN   =   "2"
             EVALUATE    PTNYUINRRK-TOKUTEI-NYUIN
               WHEN    "01"
                       MOVE   "190111110"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "02"
                       MOVE   "190111210"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "03"
                       MOVE   "190055210"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "04"
                       MOVE   "190055310"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "05"
                       MOVE   "190739910"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "06"
                       MOVE   "190740110"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "07"
                       MOVE   "190055010"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "08"
                       MOVE   "190055110"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "09"
                       MOVE   "190028910"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "10"
                       MOVE   "190111410"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "11"
                       MOVE   "190066910"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "12"
                       MOVE   "190067010"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "13"
                       MOVE   "190075910"   TO  SYOKIKSN-IN-KHNSRYCD
             END-EVALUATE
           END-IF
      *    病室
           IF  PTNYUINRRK-TOKUTEI-KBN   =   "3"
             EVALUATE    PTNYUINRRK-TOKUTEI-NYUIN
               WHEN    "01"
                       MOVE   "190075710"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "02"
                       MOVE   "190774110"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "03"
                       MOVE   "190024510"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "04"
                       MOVE   "190024310"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "05"
                       MOVE   "190024610"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "06"
                       MOVE   "190024710"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "07"
                       MOVE   "190066710"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "08"
                       MOVE   "190066810"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "09"
                       MOVE   "190024810"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "10"
                       MOVE   "190075510"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "11"
                       MOVE   "190788810"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "20"
                       MOVE   "190076710"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "21"
                       MOVE   "190076810"   TO  SYOKIKSN-IN-KHNSRYCD
             END-EVALUATE
           END-IF
      *
           .
       4801-BTU-TOKTEI-NYUIN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院料一般コードから老人コードへの置き換え処理
      *****************************************************************
       4801-RJNCD-CHG-SEC   SECTION.
      *
      *    入院患者の老人判定
           INITIALIZE              HKNCOMBI-REC
           MOVE    ZERO            TO   FLG-HKNCOMBI
      *
           MOVE    SPA-HOSPID      TO   COMB-HOSPID
           MOVE    SPA-NAI-I01-PTID
                                   TO   COMB-PTID
           MOVE    SPA-GMN-I01-HKNCOMBI-CD
                                   TO   COMB-HKNCOMBINUM
           MOVE    HKNCOMBI-REC         TO   MCPDATA-REC
           MOVE    "HKNCOMBI-KEY"       TO   WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC 
           IF    ( FLG-DBRC    =   ZERO )
               MOVE    MCPDATA-REC
                                   TO   HKNCOMBI-REC
           ELSE
               MOVE    1           TO   FLG-HKNCOMBI
           END-IF
      *
           MOVE    "HKNCOMBI-KEY"  TO   WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    老人保険対象患者であれば入院診療コードの置き換え
           IF     (FLG-HKNCOMBI     =   ZERO)    AND
                  (COMB-KOH1HKNNUM  =   "027")
               INITIALIZE              SRYCDCHG-REC
      *
               MOVE    SYOKIKSN-IN-KHNSRYCD
                                       TO   CHG-IPNSRYCD
               MOVE    SRYCDCHG-REC    TO   MCPDATA-REC
               MOVE    "SRYCDCHG-KEY2" TO   WRK-DBPATH
               PERFORM 900-TBL-SELECT-SEC 
               IF    ( FLG-DBRC    =   ZERO )
                   MOVE    MCPDATA-REC
                                       TO   SRYCDCHG-REC
                   IF   CHG-RJNSRYCD   NOT =   SPACE
                        MOVE   CHG-RJNSRYCD
                                       TO  SYOKIKSN-IN-KHNSRYCD
                   END-IF
               END-IF
      *
               MOVE    "SRYCDCHG-KEY2" TO   WRK-DBPATH
               PERFORM 900-TBL-CLOSE-SEC
           END-IF
      *
           .
       4801-RJNCD-CHG-EXT.
           EXIT.
      *****************************************************************
      *    患者情報更新処理
      *****************************************************************
       4801-PTINF-UPD-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-ZI-SAISIN
      *    入院歴より最新の歴情報を取得
           INITIALIZE  PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  PTNYUINRRK-PTID
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY3"   TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM UNTIL ( FLG-DBRC        NOT =   ZERO )
                   OR    ( FLG-ZI-SAISIN   NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
      *
               IF    ( PTNYUINRRK-JTIKBN   NOT =   "5" )
                   MOVE    1           TO  FLG-ZI-SAISIN
                   MOVE    PTNYUINRRK-RRKNUM
                                       TO  WRK-ZI-SAISIN-RRKNUM
                   MOVE    PTNYUINRRK-RRKEDANUM
                                       TO  WRK-ZI-SAISIN-RRKEDANUM
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY3"   TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
           END-PERFORM
      *
           MOVE    "PTNYUINRRK-KEY3"   TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    患者マスタ検索
           MOVE    ZERO                TO  FLG-PTINF
           INITIALIZE  PTINF-REC
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-NAI-I01-PTID    TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
      *
           MOVE    "PTINF-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF     ( FLG-DBRC           =  ZERO )
               MOVE    MCPDATA-REC     TO  PTINF-REC
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
      *    患者マスタクローズ
           MOVE    "PTINF-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( FLG-PTINF           NOT =   ZERO )
               MOVE    "2007"          TO  SPA-ERRCD
               GO  TO  4801-PTINF-UPD-EXT
           END-IF
      *
      *    患者情報の入院歴番号を更新する
           IF    ( FLG-ZI-SAISIN       =   1 )
               MOVE   WRK-ZI-SAISIN-RRKNUM
                                       TO  PTINF-RRKNUM
               MOVE   WRK-ZI-SAISIN-RRKEDANUM
                                       TO  PTINF-RRKEDANUM
           ELSE
               MOVE    ZERO            TO  PTINF-RRKNUM
                                           PTINF-RRKEDANUM
           END-IF
      *
      *    患者情報更新
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "PTINF-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-UPDATE-SEC
           IF     ( FLG-DBRC       NOT =  ZERO )
               MOVE    "2007"          TO  SPA-ERRCD
               GO  TO  4801-PTINF-UPD-EXT
           END-IF
      *
           .
       4801-PTINF-UPD-EXT.
           EXIT.
      *****************************************************************
      *    負担金計算処理
      *****************************************************************
       490-FTNKIN-CALC-SEC             SECTION.
      *
      *    通算日数を求める
           MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  WRK-STYMD
      *    暫定的に入院日を設定（実際は請求開始日）
           MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  WRK-EDYMD
           PERFORM 5002-KIKAN-CALC-SEC
           IF    ( FLG-ORCSDAY     NOT =   ZERO )
               MOVE    "2008"      TO  SPA-ERRCD
               GO  TO  490-FTNKIN-CALC-EXT
           END-IF
      *
           MOVE    SPACE           TO  LNK-ORCS02-REC
                                       LNK-SYUNOU-REC-T
      *
           INITIALIZE                  LNK-ORCS02-REC
                                       LNK-SYUNOU-REC-T
      *
           MOVE    SPA-HOSPID      TO  LNK-S02-HOSPID
           MOVE    "1"             TO  LNK-S02-NYUGAIKBN
           MOVE    SPA-NAI-I01-PTID
                                   TO  LNK-S02-PTID
           MOVE    WRK-NISSU1      TO  LNK-S02-NYUIN-TSUSAN-NISSU
      *    暫定的に入院日を設定（実際は請求開始日）
           MOVE    SPA-NAI-I01-NYUINYMD
                                   TO  LNK-S02-SKYSTYMD
           MOVE    SPA-NAI-I01-TAIINYMD
                                   TO  LNK-S02-SKYEDYMD
           DISPLAY "LNK-S02-HOSPID             = " LNK-S02-HOSPID
           DISPLAY "LNK-S02-NYUGAIKBN          = " LNK-S02-NYUGAIKBN
           DISPLAY "LNK-S02-PTID               = " LNK-S02-PTID
           DISPLAY "LNK-S02-NYUIN-TSUSAN-NISSU = "
                    LNK-S02-NYUIN-TSUSAN-NISSU
           DISPLAY "LNK-S02-SKYSTYMD           = " LNK-S02-SKYSTYMD
           DISPLAY "LNK-S02-SKYEDYMD           = " LNK-S02-SKYEDYMD
           CALL    "ORCSNYUFTN"    USING
                                   MCPAREA
                                   LNK-ORCS02-REC
                                   LNK-SYUNOU-REC-T
           DISPLAY "LNK-S02-RC = " LNK-S02-RC
           IF    ( LNK-S02-RC      NOT =   ZERO )
               MOVE    "2008"      TO  SPA-ERRCD
               GO  TO  490-FTNKIN-CALC-EXT
           END-IF
      *
           PERFORM VARYING IDX11   FROM    1   BY  1
                   UNTIL ( IDX11   >   10 )
      *
               DISPLAY "LNK-SYU-SKYMONEY (" IDX11" ) = "
                        LNK-SYU-SKYMONEY ( IDX11 )
      *
           END-PERFORM
      *    収納データ退避処理
           PERFORM 490-SYUNOU-TAIHI-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-FTNKIN-CALC-EXT
           END-IF
      *
           .
       490-FTNKIN-CALC-EXT.
           EXIT.
      *****************************************************************
      *    収納データ退避処理
      *****************************************************************
       490-SYUNOU-TAIHI-SEC            SECTION.
      *
           MOVE    LOW-VALUE       TO  WRK-SKYSTYM
           MOVE    SPACE           TO  SUMSYUNOU-REC
                                       TTLSYUNOU-REC
           INITIALIZE                  SUMSYUNOU-REC
                                       TTLSYUNOU-REC
      *
           PERFORM VARYING IDX11   FROM    1   BY  1
                   UNTIL ( IDX11           >   10 )
                   OR    ( SUMSYUNOU-CNT    >=  13 )
                   OR    ( LNK-SYU-SKYSTYMD (IDX11)    =   SPACE )
      *
               IF    ( LNK-SYU-SKYSTYMD (IDX11) (1 : 6)
                                   NOT =   WRK-SKYSTYM )
      *
                   MOVE    LNK-SYU-SKYSTYMD (IDX11) (1 : 6)
                                   TO      WRK-SKYSTYM
                   COMPUTE SUMSYUNOU-CNT
                                       =   SUMSYUNOU-CNT +   1
                   MOVE    SUMSYUNOU-CNT
                                   TO  WRK-SYU-SUM-IDX
      *
                   MOVE    1       TO    SPA-I0-SYUNOU-TTLDAT-FLG
                                                 (WRK-SYU-SUM-IDX)
      *
                   MOVE    LNK-SYU-SKYSTYMD (IDX11)
                                   TO   WRK-YMD
                   PERFORM 5002-HIZUKE-CHK-SEC
                   MOVE    WRK-HENYMDG (1 : 6)
                           TO SPA-I0-SYUNOU-YM-W (WRK-SYU-SUM-IDX)
                   MOVE    WRK-SYMD    (1 : 6)
                           TO SPA-I0-SYUNOU-YM-S (WRK-SYU-SUM-IDX)
               END-IF
      *
               IF    ( SUMSYUNOU-CNT <   13 )
                   COMPUTE SUMSYUNOU-CNT    =   SUMSYUNOU-CNT +   1
      *
                   MOVE    0       TO    SPA-I0-SYUNOU-TTLDAT-FLG
                                                 (SUMSYUNOU-CNT)
      *
                   MOVE    SPA-I0-SYUNOU-YM-W (WRK-SYU-SUM-IDX)
                                       TO  SPA-I0-SYUNOU-YM-W
                                                 (SUMSYUNOU-CNT)
                   MOVE    SPA-I0-SYUNOU-YM-S (WRK-SYU-SUM-IDX)
                                       TO  SPA-I0-SYUNOU-YM-S
                                                 (SUMSYUNOU-CNT)
      *
      *            保険組み合わせ名称取得
                   INITIALIZE              HKNCOMBI-REC
                   MOVE    ZERO            TO   FLG-HKNCOMBI
      *
                   MOVE    SPA-HOSPID      TO   COMB-HOSPID
                   MOVE    SPA-NAI-I01-PTID
                                           TO   COMB-PTID
                   MOVE    LNK-SYU-HKNCOMBINUM (IDX11)
                                           TO   COMB-HKNCOMBINUM
                   MOVE    HKNCOMBI-REC    TO   MCPDATA-REC
                   MOVE    "HKNCOMBI-KEY"  TO   WRK-DBPATH
                   PERFORM 900-TBL-SELECT-SEC 
                   IF    ( FLG-DBRC    =   ZERO )
                       MOVE    MCPDATA-REC
                                           TO   HKNCOMBI-REC
                   ELSE
                       MOVE    1           TO   FLG-HKNCOMBI
                   END-IF
      *
                   MOVE    "HKNCOMBI-KEY"  TO   WRK-DBPATH
                   PERFORM 900-TBL-CLOSE-SEC
      *
                   IF    ( FLG-HKNCOMBI    =    ZERO )
                       PERFORM 4101-HKNCOMBI-EDIT-SEC
                       MOVE    WRK-HKNCOMBI
                                           TO  SPA-I0-SYUNOU-HKNCOMBI
                                                        (SUMSYUNOU-CNT)
                   END-IF
      *
                   MOVE    LNK-SYUNOU-REC (IDX11)
                                       TO  SUMSYUNOU-OCC (SUMSYUNOU-CNT)
      *            保険料
                   PERFORM VARYING     IDX12   FROM    1   BY  1
                           UNTIL       IDX12   >   11
                     COMPUTE SUMSYU-HKNTEN   (WRK-SYU-SUM-IDX IDX12)
                         =   SUMSYU-HKNTEN   (WRK-SYU-SUM-IDX IDX12)
                         +   LNK-SYU-HKNTEN (IDX11 IDX12)
                     COMPUTE TTLSYU-HKNTEN (IDX12)
                         =   TTLSYU-HKNTEN (IDX12)
                         +   LNK-SYU-HKNTEN (IDX11 IDX12)
      *
                     COMPUTE SUMSYU-TGMONEY   (WRK-SYU-SUM-IDX IDX12)
                         =   SUMSYU-TGMONEY   (WRK-SYU-SUM-IDX IDX12)
                         +   LNK-SYU-TGMONEY (IDX11 IDX12)
                     COMPUTE TTLSYU-TGMONEY  (IDX12)
                         =   TTLSYU-TGMONEY  (IDX12)
                         +   LNK-SYU-TGMONEY (IDX11 IDX12)
      *
                     COMPUTE SUMSYU-TGMONEY-TAX (WRK-SYU-SUM-IDX IDX12)
                         =   SUMSYU-TGMONEY-TAX (WRK-SYU-SUM-IDX IDX12)
                         +   LNK-SYU-TGMONEY-TAX (IDX11 IDX12)
                     COMPUTE TTLSYU-TGMONEY-TAX  (IDX12)
                         =   TTLSYU-TGMONEY-TAX  (IDX12)
                         +   LNK-SYU-TGMONEY-TAX (IDX11 IDX12)
                   END-PERFORM
      *
      *            保険適用金額
                   COMPUTE SUMSYU-HKNTEKMONEY   (WRK-SYU-SUM-IDX)
                       =   SUMSYU-HKNTEKMONEY   (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-HKNTEKMONEY (IDX11)
                   COMPUTE TTLSYU-HKNTEKMONEY
                       =   TTLSYU-HKNTEKMONEY
                       +   LNK-SYU-HKNTEKMONEY (IDX11)
      *
      *            老人一部負担金
                   COMPUTE SUMSYU-RJN-FTN    (WRK-SYU-SUM-IDX)
                       =   SUMSYU-RJN-FTN    (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-RJN-FTN  (IDX11)
                   COMPUTE TTLSYU-RJN-FTN
                       =   TTLSYU-RJN-FTN
                       +   LNK-SYU-RJN-FTN  (IDX11)
      *
      *            公費一部負担金
                   COMPUTE SUMSYU-KOH-FTN    (WRK-SYU-SUM-IDX)
                       =   SUMSYU-KOH-FTN    (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-KOH-FTN  (IDX11)
                   COMPUTE TTLSYU-KOH-FTN
                       =   TTLSYU-KOH-FTN
                       +   LNK-SYU-KOH-FTN  (IDX11)
      *
      *            自費
                   COMPUTE SUMSYU-JIHI-1   (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-1   (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-1 (IDX11)
                   COMPUTE TTLSYU-JIHI-1
                       =   TTLSYU-JIHI-1
                       +   LNK-SYU-JIHI-1 (IDX11)
      *
                   COMPUTE SUMSYU-JIHI-2   (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-2   (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-2 (IDX11)
                   COMPUTE TTLSYU-JIHI-2
                       =   TTLSYU-JIHI-2
                       +   LNK-SYU-JIHI-2 (IDX11)
      *
                   COMPUTE SUMSYU-JIHI-3   (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-3   (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-3 (IDX11)
                   COMPUTE TTLSYU-JIHI-3
                       =   TTLSYU-JIHI-3
                       +   LNK-SYU-JIHI-3 (IDX11)
      *
                   COMPUTE SUMSYU-JIHI-4   (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-4   (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-4 (IDX11)
                   COMPUTE TTLSYU-JIHI-4
                       =   TTLSYU-JIHI-4
                       +   LNK-SYU-JIHI-4 (IDX11)
      *
                   COMPUTE SUMSYU-JIHI-5   (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-5   (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-5 (IDX11)
                   COMPUTE TTLSYU-JIHI-5
                       =   TTLSYU-JIHI-5
                       +   LNK-SYU-JIHI-5 (IDX11)
      *
      *            自費計
                   COMPUTE SUMSYU-JIHI-TOTAL   (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-TOTAL   (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-TOTAL (IDX11)
                   COMPUTE TTLSYU-JIHI-TOTAL
                       =   TTLSYU-JIHI-TOTAL
                       +   LNK-SYU-JIHI-TOTAL (IDX11)
      *
      *            自費（消費税あり）
                   COMPUTE SUMSYU-JIHI-1-TAX    (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-1-TAX    (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-1-TAX  (IDX11)
                   COMPUTE TTLSYU-JIHI-1-TAX
                       =   TTLSYU-JIHI-1-TAX
                       +   LNK-SYU-JIHI-1-TAX  (IDX11)
      *
                   COMPUTE SUMSYU-JIHI-2-TAX    (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-2-TAX    (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-2-TAX  (IDX11)
                   COMPUTE TTLSYU-JIHI-2-TAX
                       =   TTLSYU-JIHI-2-TAX
                       +   LNK-SYU-JIHI-2-TAX  (IDX11)
      *
                   COMPUTE SUMSYU-JIHI-3-TAX    (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-3-TAX    (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-3-TAX  (IDX11)
                   COMPUTE TTLSYU-JIHI-3-TAX
                       =   TTLSYU-JIHI-3-TAX
                       +   LNK-SYU-JIHI-3-TAX  (IDX11)
      *
                   COMPUTE SUMSYU-JIHI-4-TAX    (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-4-TAX    (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-4-TAX  (IDX11)
                   COMPUTE TTLSYU-JIHI-4-TAX
                       =   TTLSYU-JIHI-4-TAX
                       +   LNK-SYU-JIHI-4-TAX  (IDX11)
      *
                   COMPUTE SUMSYU-JIHI-5-TAX    (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-5-TAX    (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-5-TAX  (IDX11)
                   COMPUTE TTLSYU-JIHI-5-TAX
                       =   TTLSYU-JIHI-5-TAX
                       +   LNK-SYU-JIHI-5-TAX  (IDX11)
      *
      *            自費計（消費税あり）
                   COMPUTE SUMSYU-JIHI-TOTAL-TAX (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-TOTAL-TAX (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-TOTAL-TAX (IDX11)
                   COMPUTE TTLSYU-JIHI-TOTAL-TAX
                       =   TTLSYU-JIHI-TOTAL-TAX
                       +   LNK-SYU-JIHI-TOTAL-TAX (IDX11)
      *
      *            自費消費税
                   COMPUTE SUMSYU-JIHI-TAX  (WRK-SYU-SUM-IDX)
                       =   SUMSYU-JIHI-TAX  (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-JIHI-TAX  (IDX11)
                   COMPUTE TTLSYU-JIHI-TAX
                       =   TTLSYU-JIHI-TAX
                       +   LNK-SYU-JIHI-TAX  (IDX11)
      *
      *            労災初診
                   COMPUTE SUMSYU-RSISHOSHIN-MONEY (WRK-SYU-SUM-IDX)
                       =   SUMSYU-RSISHOSHIN-MONEY (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-RSISHOSHIN-MONEY (IDX11)
                   COMPUTE TTLSYU-RSISHOSHIN-MONEY
                       =   TTLSYU-RSISHOSHIN-MONEY
                       +   LNK-SYU-RSISHOSHIN-MONEY (IDX11)
      *
      *            労災再診
                   COMPUTE SUMSYU-RSISAISHIN-MONEY (WRK-SYU-SUM-IDX)
                       =   SUMSYU-RSISAISHIN-MONEY (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-RSISAISHIN-MONEY (IDX11)
                   COMPUTE TTLSYU-RSISAISHIN-MONEY
                       =   TTLSYU-RSISAISHIN-MONEY
                       +   LNK-SYU-RSISAISHIN-MONEY (IDX11)
      *
      *            労災指導
                   COMPUTE SUMSYU-RSISDO-MONEY  (WRK-SYU-SUM-IDX)
                       =   SUMSYU-RSISDO-MONEY  (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-RSISDO-MONEY (IDX11)
                   COMPUTE TTLSYU-RSISDO-MONEY
                       =   TTLSYU-RSISDO-MONEY
                       +   LNK-SYU-RSISDO-MONEY (IDX11)
      *
      *            労災その他
                   COMPUTE SUMSYU-RSIETC-MONEY (WRK-SYU-SUM-IDX)
                       =   SUMSYU-RSIETC-MONEY (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-RSIETC-MONEY (IDX11)
                   COMPUTE TTLSYU-RSIETC-MONEY
                       =   TTLSYU-RSIETC-MONEY
                       +   LNK-SYU-RSIETC-MONEY (IDX11)
      *
      *            食事療養費
                   COMPUTE SUMSYU-RYOYOHI-SKJ (WRK-SYU-SUM-IDX)
                       =   SUMSYU-RYOYOHI-SKJ (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-RYOYOHI-SKJ (IDX11)
                   COMPUTE TTLSYU-RYOYOHI-SKJ
                       =   TTLSYU-RYOYOHI-SKJ
                       +   LNK-SYU-RYOYOHI-SKJ (IDX11)
      *
      *            食事負担額
                   COMPUTE SUMSYU-SKYMONEY-SKJ (WRK-SYU-SUM-IDX)
                       =   SUMSYU-SKYMONEY-SKJ (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-SKYMONEY-SKJ (IDX11)
                   COMPUTE TTLSYU-SKYMONEY-SKJ
                       =   TTLSYU-SKYMONEY-SKJ
                       +   LNK-SYU-SKYMONEY-SKJ (IDX11)
      *
      *            室料差額
                   COMPUTE SUMSYU-RMSAGAKU (WRK-SYU-SUM-IDX)
                       =   SUMSYU-RMSAGAKU (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-RMSAGAKU (IDX11)
                   COMPUTE TTLSYU-RMSAGAKU
                       =   TTLSYU-RMSAGAKU
                       +   LNK-SYU-RMSAGAKU (IDX11)
      *
      *            請求金額
                   COMPUTE SUMSYU-SKYMONEY (WRK-SYU-SUM-IDX)
                       =   SUMSYU-SKYMONEY (WRK-SYU-SUM-IDX)
                       +   LNK-SYU-SKYMONEY (IDX11)
                   COMPUTE TTLSYU-SKYMONEY
                       =   TTLSYU-SKYMONEY
                       +   LNK-SYU-SKYMONEY (IDX11)
      *
               END-IF
      *
           END-PERFORM
      *
      *    ゼロ件の場合はエラーとする
           IF    ( SUMSYUNOU-CNT    <=  ZERO )
               MOVE    "2008"      TO  SPA-ERRCD
               GO  TO  490-SYUNOU-TAIHI-EXT
           END-IF
      *
           COMPUTE SUMSYUNOU-CNT    =   SUMSYUNOU-CNT +   1
      *
      *    テーブル最大件数オーバー時はエラーとする
           IF    ( SUMSYUNOU-CNT    >   13 )
               MOVE    "2008"      TO  SPA-ERRCD
               GO  TO  490-SYUNOU-TAIHI-EXT
           END-IF
      *
      *
           MOVE    SUMSYUNOU-CNT    TO  SPA-I0-SYUNOU-CNT
      *
           MOVE    2               TO  SPA-I0-SYUNOU-TTLDAT-FLG
                                                   (SUMSYUNOU-CNT)
           MOVE    "999999"        TO  SPA-I0-SYUNOU-YM-S
                                                   (SUMSYUNOU-CNT)
           MOVE    "999999"        TO  SPA-I0-SYUNOU-YM-W
                                                   (SUMSYUNOU-CNT)
           MOVE    TTLSYUNOU-REC   TO  SUMSYUNOU-OCC (SUMSYUNOU-CNT)
      *
           PERFORM VARYING IDX11   FROM    1   BY  1
                   UNTIL ( IDX11   >   SPA-I0-SYUNOU-CNT )
      *
               MOVE    SUMSYUNOU-OCC (IDX11)
                                   TO  SPA-I0-SYUNOU-DAT (IDX11)
      *
           END-PERFORM
      *
           .
       490-SYUNOU-TAIHI-EXT.
           EXIT.
      *****************************************************************
      *    請求確認画面遷移処理
      *****************************************************************
       490-SYUNOU-SUM-SEC              SECTION.
      *
      *
       490-SYUNOU-SUM-EXT.
           EXIT.
      *****************************************************************
      *    請求確認画面遷移処理
      *****************************************************************
       490-I04-SENI-SEC                SECTION.
      *
      *
           MOVE    "I01"               TO  SPA-MOTOPG
           MOVE    "I04"               TO  SPA-SAKIPG
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   SPA-SAKIPG           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
      *
       490-I04-SENI-EXT.
           EXIT.
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
           IF    ( SPA-I0IDCD      NOT =   SPACE )
               PERFORM 520-I0IDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "I01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面内容編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
      *    患者番号
           MOVE    SPA-GMN-I01-PTNUM       TO  I01-PTNUM
      *    患者氏名
           MOVE    SPA-GMN-I01-NAME        TO  I01-NAME
      *    患者性別
           MOVE    SPA-GMN-I01-SEX         TO  I01-SEX
      *    患者誕生日
           MOVE    SPA-GMN-I01-BIRTHDAY    TO  I01-BIRTHDAY
      *    患者年齢
           MOVE    SPA-GMN-I01-AGE         TO  I01-AGE
      *    処理区分
           MOVE    SPA-GMN-I01-SYORIKBN    TO  I01-SYORIKBN
           MOVE    SPA-GMN-I01-SYORIKBN-CNT
                                           TO  I01-SYORIKBN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-SYORIKBN-CNT )
               MOVE    SPA-GMN-I01-SYORIKBN-ITM (IDX1)
                                           TO  I01-SYORIKBN-ITM (IDX1)
           END-PERFORM
      *
      *    異動日
           MOVE    SPA-GMN-I01-IDOYMD      TO  I01-IDOYMD
      *
      *    前回異動日
           MOVE    SPA-GMN-I01-MAEIDOYMD   TO  I01-MAEIDOYMD
      *
      *    病室番号
           MOVE    SPA-GMN-I01-BRMNUM      TO  I01-BRMNUM
      *    病棟名
           MOVE    SPA-GMN-I01-BTUNAME     TO  I01-BTUNAME
           MOVE    SPA-GMN-I01-BTUNAME-CNT TO  I01-BTUNAME-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-BTUNAME-CNT )
               MOVE    SPA-GMN-I01-BTUNAME-ITM (IDX1)
                                           TO  I01-BTUNAME-ITM (IDX1)
           END-PERFORM
      *
      *    室料差額
           MOVE    SPA-GMN-I01-SAGAKU      TO  I01-SAGAKU
           MOVE    SPA-GMN-I01-SAGAKU-CNT  TO  I01-SAGAKU-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-SAGAKU-CNT )
               MOVE    SPA-GMN-I01-SAGAKU-ITM (IDX1)
                                           TO  I01-SAGAKU-ITM (IDX1)
           END-PERFORM
      *
      *    入院日
           MOVE    SPA-GMN-I01-NYUINYMD    TO  I01-NYUINYMD
      *    入院科
           MOVE    SPA-GMN-I01-NYUINKA     TO  I01-NYUINKA
           MOVE    SPA-GMN-I01-NYUINKA-CNT TO  I01-NYUINKA-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-NYUINKA-CNT )
               MOVE    SPA-GMN-I01-NYUINKA-ITM (IDX1)
                                           TO  I01-NYUINKA-ITM (IDX1)
           END-PERFORM
      *
      *    初回
           MOVE    SPA-GMN-I01-SHOKAI      TO  I01-SHOKAI
           MOVE    SPA-GMN-I01-SHOKAI-CNT  TO  I01-SHOKAI-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-SHOKAI-CNT )
               MOVE    SPA-GMN-I01-SHOKAI-ITM (IDX1)
                                           TO  I01-SHOKAI-ITM (IDX1)
           END-PERFORM
      *
      *    初回番号
           MOVE    SPA-GMN-I01-SHONUM      TO  I01-SHONUM
      *
      *    初回入院日
           MOVE    SPA-GMN-I01-LBL-SHONYUINYMD
                                           TO  I01-LBL-SHONYUINYMD
      *
      *    退院日
           MOVE    SPA-GMN-I01-TAIINYMD    TO  I01-TAIINYMD
      *
      *    担当医
           PERFORM VARYING IDX1   FROM     1   BY  1
               UNTIL     ( IDX1   >    3   )
               MOVE    SPA-GMN-I01-DR (IDX1)
                                           TO  I01-DR (IDX1)
               MOVE    SPA-GMN-I01-DR-CNT (IDX1)
                                           TO  I01-DR-CNT (IDX1)
                                               WRK-CNT
               PERFORM VARYING IDX2   FROM     1   BY  1
                   UNTIL     ( IDX2   >    WRK-CNT )
                   MOVE    SPA-GMN-I01-DR-ITM (IDX1 IDX2)
                                   TO  I01-DR-ITM (IDX1 IDX2)
               END-PERFORM
           END-PERFORM
      *
      *    保険組合わせ
           MOVE    SPA-GMN-I01-HKNCOMBI    TO  I01-HKNCOMBI
           MOVE    SPA-GMN-I01-HKNCOMBI-CNT
                                           TO  I01-HKNCOMBI-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-HKNCOMBI-CNT   )
               MOVE    SPA-GMN-I01-HKNCOMBI-ITM (IDX1)
                                           TO  I01-HKNCOMBI-ITM (IDX1)
           END-PERFORM
      *
      *    特定入院料
           MOVE    SPA-GMN-I01-TOKNYUIN    TO  I01-TOKNYUIN
           MOVE    SPA-GMN-I01-TOKNYUIN-CNT
                                           TO  I01-TOKNYUIN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-TOKNYUIN-CNT   )
               MOVE    SPA-GMN-I01-TOKNYUIN-ITM (IDX1)
                                           TO  I01-TOKNYUIN-ITM (IDX1)
           END-PERFORM
      *
      *    前受け金
           MOVE    SPA-GMN-I01-MAEUKE      TO  I01-MAEUKE
      *
      *    定期請求
           MOVE    SPA-GMN-I01-SEIKYU      TO  I01-SEIKYU
           MOVE    SPA-GMN-I01-SEIKYU-CNT  TO  I01-SEIKYU-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-SEIKYU-CNT   )
               MOVE    SPA-GMN-I01-SEIKYU-ITM (IDX1)
                                           TO  I01-SEIKYU-ITM (IDX1)
           END-PERFORM
      *
      *    検索時患者表示
           MOVE    SPA-GMN-I01-DISPKBN     TO  I01-DISPKBN
           MOVE    SPA-GMN-I01-DISPKBN-CNT TO  I01-DISPKBN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-I01-DISPKBN-CNT   )
               MOVE    SPA-GMN-I01-DISPKBN-ITM (IDX1)
                                           TO  I01-DISPKBN-ITM (IDX1)
           END-PERFORM
      *
      *    選択番号
           MOVE    SPA-GMN-I01-SELNUM      TO  I01-SELNUM
      *
      *    入院歴リスト
           MOVE    SPA-GMN-I01-NYUREKILST-CNT
                                           TO  I01-NYUREKILST-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL ( IDX1    >   SPA-GMN-I01-NYUREKILST-CNT )
               MOVE    SPA-GMN-I01-TSELNUM (IDX1)
                                       TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9        TO  I01-TSELNUM (IDX1)
               MOVE    SPA-GMN-I01-TSHOKAI (IDX1)
                                       TO  I01-TSHOKAI (IDX1)
               MOVE    SPA-GMN-I01-TSHONUM (IDX1)
                                       TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9
                                       TO  I01-TSHONUM (IDX1)
               MOVE    SPA-GMN-I01-TBTUNAME (IDX1)
                                       TO  I01-TBTUNAME (IDX1)
               MOVE    SPA-GMN-I01-TBRMNUM (IDX1)
                                       TO  I01-TBRMNUM (IDX1)
               MOVE    SPA-GMN-I01-TBRMNUM (IDX1)
                                       TO  I01-TBRMNUM (IDX1)
               MOVE    SPA-GMN-I01-TNYUINYMD (IDX1)
                                       TO  I01-TNYUINYMD (IDX1)
               MOVE    SPA-GMN-I01-TTAIINYMD (IDX1)
                                       TO  I01-TTAIINYMD (IDX1)
               MOVE    SPA-GMN-I01-TNYUINKA (IDX1)
                                       TO  I01-TNYUINKA (IDX1)
               MOVE    SPA-GMN-I01-TBYOMEI (IDX1)
                                       TO  I01-TBYOMEI (IDX1)
               MOVE    SPA-GMN-I01-TTENKI (IDX1)
                                       TO  I01-TTENKI (IDX1)
               MOVE    SPA-GMN-I01-TNISSU (IDX1)
                                       TO  I01-TNISSU (IDX1)
               MOVE    SPA-GMN-I01-TTUSAN (IDX1)
                                       TO  I01-TTUSAN (IDX1)
      *
               IF    ( SPA-GMN-I01-NYUREKILST-SEL  =   IDX1)
                   MOVE    "T"         TO  I01-NYUREKILST-SELECT (IDX1)
               ELSE
                   MOVE    "F"         TO  I01-NYUREKILST-SELECT (IDX1)
               END-IF
      *
           END-PERFORM
      *
      *    項目状態編集
           PERFORM 500-GMNHEN-STATE-EDIT-SEC
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目状態編集処理
      *****************************************************************
       500-GMNHEN-STATE-EDIT-SEC       SECTION.
      *
      *    他院歴作成ボタン
           MOVE    SPA-GMN-I01-B07-STT
                                       TO  I01-B07-STT
      *    他院歴修正ボタン
           MOVE    SPA-GMN-I01-B08-STT
                                       TO  I01-B08-STT
      *    登録ボタン
           MOVE    SPA-GMN-I01-B12-STT
                                       TO  I01-B12-STT
      *    異動日
           MOVE    SPA-GMN-I01-IDOYMD-STT
                                       TO  I01-IDOYMD-STT
      *    病室番号
           MOVE    SPA-GMN-I01-BRMNUM-STT
                                       TO  I01-BRMNUM-STT
      *    病棟名
           MOVE    SPA-GMN-I01-BTUNAME-STT
                                       TO  I01-BTUNAME-STT
           MOVE    SPA-GMN-I01-BTUNAME-ITM-STT
                                       TO  I01-BTUNAME-ITM-STT
      *    室料差額
           MOVE    SPA-GMN-I01-SAGAKU-STT
                                       TO  I01-SAGAKU-STT
           MOVE    SPA-GMN-I01-SAGAKU-ITM-STT
                                       TO  I01-SAGAKU-ITM-STT
      *    入院日
           MOVE    SPA-GMN-I01-NYUINYMD-STT
                                       TO  I01-NYUINYMD-STT
      *    入院科
           MOVE    SPA-GMN-I01-NYUINKA-STT
                                       TO  I01-NYUINKA-STT
           MOVE    SPA-GMN-I01-NYUINKA-ITM-STT
                                       TO  I01-NYUINKA-ITM-STT
      *    初回
           MOVE    SPA-GMN-I01-SHOKAI-STT
                                       TO  I01-SHOKAI-STT
           MOVE    SPA-GMN-I01-SHOKAI-ITM-STT
                                       TO  I01-SHOKAI-ITM-STT
      *    初回番号
           MOVE    SPA-GMN-I01-SHONUM-STT
                                       TO  I01-SHONUM-STT
      *    退院日
           MOVE    SPA-GMN-I01-TAIINYMD-STT
                                       TO  I01-TAIINYMD-STT
      *    担当医
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   3   )
               MOVE    SPA-GMN-I01-DR-STT (IDX1)
                                       TO  I01-DR-STT (IDX1)
               MOVE    SPA-GMN-I01-DR-ITM-STT (IDX1)
                                       TO  I01-DR-ITM-STT (IDX1)
           END-PERFORM
      *    保険組合わせ
           MOVE    SPA-GMN-I01-HKNCOMBI-STT
                                       TO  I01-HKNCOMBI-STT
           MOVE    SPA-GMN-I01-HKNCOMBI-ITM-STT
                                       TO  I01-HKNCOMBI-ITM-STT
      *    特定入院料
           MOVE    SPA-GMN-I01-TOKNYUIN-STT
                                       TO  I01-TOKNYUIN-STT
           MOVE    SPA-GMN-I01-TOKNYUIN-ITM-STT
                                       TO  I01-TOKNYUIN-ITM-STT
      *    前受け金
           MOVE    SPA-GMN-I01-MAEUKE-STT
                                       TO  I01-MAEUKE-STT
      *    定期請求
           MOVE    SPA-GMN-I01-SEIKYU-STT
                                       TO  I01-SEIKYU-STT
           MOVE    SPA-GMN-I01-SEIKYU-ITM-STT
                                       TO  I01-SEIKYU-ITM-STT
      *    検索時患者表示
           MOVE    SPA-GMN-I01-DISPKBN-STT
                                       TO  I01-DISPKBN-STT
           MOVE    SPA-GMN-I01-DISPKBN-ITM-STT
                                       TO  I01-DISPKBN-ITM-STT
      *
           .
       500-GMNHEN-STATE-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC              SECTION.
      *
           IF     (SPA-ERRCD           =   SPACE)  AND
                  (SPA-GMN-I01-CUR     =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   1   )
                   MOVE    "PTNUM"         TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   2   )
                   MOVE    "SYORIKBN"      TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   3   )
               IF  ( SPA-GMN-I01-IDOYMD-STT    =   WIDGET-NORMAL )
                   MOVE    "IDOYMD"        TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   4   )
               IF  ( SPA-GMN-I01-BRMNUM-STT    =   WIDGET-NORMAL )
                   MOVE    "BRMNUM"        TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   5   )
               IF  ( SPA-GMN-I01-BTUNAME-STT   =   WIDGET-NORMAL )
                   MOVE    "BTUNAME"       TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   6   )
               IF  ( SPA-GMN-I01-SAGAKU-STT    =   WIDGET-NORMAL )
                   MOVE    "SAGAKU"        TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   7   )
               IF  ( SPA-GMN-I01-NYUINYMD-STT  =   WIDGET-NORMAL )
                   MOVE    "NYUINYMD"      TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   8   )
               IF  ( SPA-GMN-I01-NYUINKA-STT   =   WIDGET-NORMAL )
                   MOVE    "NYUINKA"       TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   9   )
               IF  ( SPA-GMN-I01-SHOKAI-STT    =   WIDGET-NORMAL )
                   MOVE    "SHOKAI"        TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
      *    初回選択番号
           IF    ( SPA-GMN-I01-CUR =   10  )
               IF  ( SPA-GMN-I01-SHONUM-STT    =   WIDGET-NORMAL )
                   MOVE    "SHONUM"        TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   11  )
               IF  ( SPA-GMN-I01-TAIINYMD-STT  =   WIDGET-NORMAL )
                   MOVE    "TAIINYMD"      TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   12  )
               IF  ( SPA-GMN-I01-DR-STT (1)    =   WIDGET-NORMAL )
                   MOVE    "DR1"           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   13  )
               IF  ( SPA-GMN-I01-DR-STT (2)    =   WIDGET-NORMAL )
                   MOVE    "DR2"           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   14  )
               IF  ( SPA-GMN-I01-DR-STT (3)    =   WIDGET-NORMAL )
                   MOVE    "DR3"           TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   15  )
               IF  ( SPA-GMN-I01-HKNCOMBI-STT  =   WIDGET-NORMAL )
                   MOVE    "HKNCOMBI"      TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   16  )
               IF  ( SPA-GMN-I01-TOKNYUIN-STT  =   WIDGET-NORMAL )
                   MOVE    "TOKNYUIN"      TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
               END-IF
           END-IF
      *
      *??? xx 暫定 xx 前受け金にはカーソルを飛ばさないようにする xx
           IF    ( SPA-GMN-I01-CUR =   17  )
               COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
           END-IF
      *??? IF    ( SPA-GMN-I01-CUR =   17  )
      *???     IF  ( SPA-GMN-I01-MAEUKE-STT    =   WIDGET-NORMAL )
      *???         MOVE    "MAEUKE"        TO  MCP-WIDGET
      *???         GO  TO  5001-MAPCUR-EXT
      *???     ELSE
      *???         COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
      *???     END-IF
      *??? END-IF
      *
      *??? xx 暫定 xx 定期請求区分にはカーソルを飛ばさないようにする xx
           IF    ( SPA-GMN-I01-CUR =   18  )
               COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
           END-IF
      *??? IF    ( SPA-GMN-I01-CUR =   18  )
      *???     IF  ( SPA-GMN-I01-SEIKYU-STT    =   WIDGET-NORMAL )
      *???         MOVE    "SEIKYU"        TO  MCP-WIDGET
      *???         GO  TO  5001-MAPCUR-EXT
      *???     ELSE
      *???         COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR +   1
      *???     END-IF
      *??? END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   19  )
               IF  ( SPA-GMN-I01-DISPKBN-STT   =   WIDGET-NORMAL )
                   MOVE    "DISPKBN"       TO  MCP-WIDGET
                   GO  TO  5001-MAPCUR-EXT
               ELSE
                   MOVE    212             TO  SPA-GMN-I01-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   100  )
               MOVE    "SELNUM"        TO  MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   206  )
               MOVE    "B06"           TO  MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           IF    ( SPA-GMN-I01-CUR =   212  )
               MOVE    "B12"           TO  MCP-WIDGET
               GO  TO  5001-MAPCUR-EXT
           END-IF
      *
           .
      *
       5001-MAPCUR-EXT.
           EXIT.
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       5011-INPUT-CUR-SEC          SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "IDOYMD"
               MOVE    003             TO  SPA-GMN-I01-CUR
           WHEN    "BRMNUM"
               MOVE    004             TO  SPA-GMN-I01-CUR
           WHEN    "BTUNAME"
               MOVE    005             TO  SPA-GMN-I01-CUR
           WHEN    "SAGAKU"
               MOVE    006             TO  SPA-GMN-I01-CUR
           WHEN    "NYUINYMD"
               MOVE    007             TO  SPA-GMN-I01-CUR
           WHEN    "NYUINKA"
               MOVE    008             TO  SPA-GMN-I01-CUR
           WHEN    "SHOKAI"
               MOVE    009             TO  SPA-GMN-I01-CUR
           WHEN    "SHONUM"
               MOVE    010             TO  SPA-GMN-I01-CUR
           WHEN    "TAIINYMD"
               MOVE    011             TO  SPA-GMN-I01-CUR
           WHEN    "DR1"
               MOVE    012             TO  SPA-GMN-I01-CUR
           WHEN    "DR2"
               MOVE    013             TO  SPA-GMN-I01-CUR
           WHEN    "DR3"
               MOVE    014             TO  SPA-GMN-I01-CUR
           WHEN    "HKNCOMBI"
               MOVE    015             TO  SPA-GMN-I01-CUR
           WHEN    "TOKNYUIN"
               MOVE    016             TO  SPA-GMN-I01-CUR
           WHEN    "MAEUKE"
               MOVE    017             TO  SPA-GMN-I01-CUR
           WHEN    "SEIKYU"
               MOVE    018             TO  SPA-GMN-I01-CUR
           WHEN    "DISPKBN"
               MOVE    019             TO  SPA-GMN-I01-CUR
           WHEN    "SELNUM"
               MOVE    100             TO  SPA-GMN-I01-CUR
           END-EVALUATE
      *
      *    次カーソル位置を設定
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "DISPKBN"
               MOVE    212             TO  SPA-GMN-I01-CUR
           WHEN    "SELNUM"
               MOVE    206             TO  SPA-GMN-I01-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-I01-CUR =   SPA-GMN-I01-CUR
                                           +   1
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
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
               MOVE    "該当の患者は存在しません"
                                       TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "半角文字でのみ入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "0004"
               MOVE    "該当の病室は存在しません"
                                       TO  SPA-ERRMSG
           WHEN    "0005"
               MOVE    "初歴を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "1001"
               MOVE    "患者番号を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1002"
               MOVE    "処理区分を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "1003"
               MOVE    "病室番号を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1004"
               MOVE    "病棟名を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1005"
               MOVE    "入院日を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1006"
               MOVE    "入院科を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1007"
               MOVE    "初回を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1008"
               MOVE    "担当医を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1009"
               MOVE    "保険組合せを入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1010"
               MOVE    "定期請求を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1011"
               MOVE    "検索時患者表示を入力して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1012"
               MOVE    "退院日＜入院日となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1013"
               MOVE    "退院日＜前回異動日となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1014"
               MOVE    "異動日が入力されていません"
                                       TO  SPA-ERRMSG
           WHEN    "1015"
               MOVE    "異動日＜入院日となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1016"
               MOVE    "異動日＜前回異動日となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1017"
               MOVE    "入院科（病棟または病室）を変更してください"
                                       TO  SPA-ERRMSG
           WHEN    "1018"
               MOVE    "入院日≦前回退院日となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1019"
               MOVE    "入院歴を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "1020"
               MOVE    "退院日を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1021"
               MOVE    "保険組合せがありません。処理できません"
                                       TO  SPA-ERRMSG
           WHEN    "1022"
               MOVE    "継続元の歴番号を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1023"
               MOVE    "他院歴を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "1024"
               MOVE    "選択歴より新しい歴が存在するため修正でき"
                                       TO  SPA-ERRMSG (1 : 40)
               MOVE    "ません"        TO  SPA-ERRMSG (41 : )
           WHEN    "1025"
               MOVE    "定期請求が行われていないため、負担金計算"
                                       TO  SPA-ERRMSG (1 : 40)
               MOVE    "は行えません"  TO  SPA-ERRMSG (41 : )
           WHEN    "2001"
               MOVE    "登録処理に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "2002"
               MOVE    "更新処理に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "2003"
               MOVE    "更新処理に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "2004"
               MOVE    "更新処理に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "2005"
               MOVE    "更新処理に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "2006"
               MOVE    "更新処理に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "2007"
               MOVE    "更新処理に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "2008"
               MOVE    "負担金計算処理に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "2009"
               MOVE    "更新処理に失敗しました"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  I0ERR
           MOVE    SPA-ERRCD            TO  I0ERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  I0ERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "I01"                TO  SPA-MOTOPG
           MOVE    "I0ERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "I0ERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *****************************************************************
      *    エラーコード設定処理
      *****************************************************************
       510-ERRCD-SET-SEC               SECTION.
      *
           MOVE    SPA-ERRCD   TO  SPA-GMN-I01-ERRCD (SPA-GMN-I01-CUR)
      *
           .
       510-ERRCD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-I0IDSET-SEC             SECTION.
      *
           EVALUATE    SPA-I0IDCD
           WHEN    "3001"
               MOVE    "入院情報を削除します（会計情報は残ります）"
                                       TO  WRK-I0IDMSG
           WHEN    "3002"
               MOVE    "入院情報を削除します"
                                       TO  WRK-I0IDMSG (1 : 20)
               MOVE    "（会計情報も併せて削除します）"
                                       TO  WRK-I0IDMSG (21 : )
           WHEN    "3003"
               MOVE    "退院取消を行います"
                                       TO  WRK-I0IDMSG
           END-EVALUATE
      *
      *
           MOVE    SPACE                TO  I0ID1
           MOVE    SPA-I0IDCD           TO  I0ID1-ID1CODE
           MOVE    WRK-I0IDMSG          TO  I0ID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "I01"                TO  SPA-MOTOPG
           MOVE    "I0ID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "I0ID1"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       520-I0IDSET-EXT.
           EXIT.
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HENYMDG
                                           WRK-SYMD
      *
           IF    ( WRK-YMD         =   SPACE )
               GO  TO  5002-HIZUKE-CHK-EXT
           END-IF
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           IF  ( SGDAY-RC              =   ZERO )
               MOVE    SGDAY-OTDAY     TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY      TO  WRK-SYMD
           ELSE
               MOVE    "0001"          TO  SPA-ERRCD
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    期間算出処理
      *****************************************************************
       5002-KIKAN-CALC-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-ORCSDAY
                                           WRK-NISSU1
                                           WRK-NISSU2
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY5-AREA
           MOVE    "51"                TO  LNK-DAY5-IRAI
           MOVE    WRK-STYMD           TO  LNK-DAY5-START
           MOVE    WRK-EDYMD           TO  LNK-DAY5-END
           CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                           LNK-DAY5-AREA
           IF      ( STS-DAY-RC1   NOT =   ZERO )
               MOVE    1           TO  FLG-ORCSDAY
               GO  TO              5002-KIKAN-CALC-EXT
           END-IF
      *
           MOVE    LNK-DAY5-NISSU1     TO  WRK-NISSU1
           MOVE    LNK-DAY5-NISSU2     TO  WRK-NISSU2
      *
           .
       5002-KIKAN-CALC-EXT.
           EXIT.
      *****************************************************************
      *    カレンダー処理
      *****************************************************************
       5002-CALENDAR-SEC               SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
           MOVE    WRK-ZOGENPTN        TO  LNK-DAY6-ZOGENPTN
           MOVE    WRK-ZOGEN           TO  LNK-DAY6-ZOGEN
           CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN     TO  WRK-KEISANYMD
      *
           .
       5002-CALENDAR-EXT.
           EXIT.
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
           MOVE    SPACE           TO  ORCSKANACHKAREA
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
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-SELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    WRK-DBPATH  TO  ORC-DBPATH
               PERFORM 910-DB-READ-SEC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1       TO  FLG-DBRC
               END-IF
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       900-TBL-READ-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-READ-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル更新処理
      *****************************************************************
       900-TBL-UPDATE-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-UPDATE-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    テーブル追加処理
      *****************************************************************
       900-TBL-INSERT-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-INSERT-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル削除処理
      *****************************************************************
       900-TBL-DELETE-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-DELETE-SEC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-DELETE-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-TBL-CLOSE-SEC               SECTION.
      *
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ削除処理
      *****************************************************************
       910-DB-DELETE-SEC               SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ更新処理
      *****************************************************************
       910-DB-UPDATE-SEC               SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ追加処理
      *****************************************************************
       910-DB-INSERT-SEC               SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-INSERT-EXT.
           EXIT.
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

