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
       IDENTIFICATION                            DIVISION.
       PROGRAM-ID.                               ORCGW01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : システム管理情報設定（Ｗ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/04/20  クリアボタン追加
      *  01.02.01    MCC-藤原     01/05/22  自動算定情報画面の追加
      *  01.02.02    MCC-藤原     01/06/04  レセプト作成指示画面の追加
      *                                     区分コードの見出し
      *  01.02.03    MCC-多々納   01/07/03  日付入力チェックサブ追加
      *  01.02.04    MCC-森脇     01/07/13  W10の追加
      *  01.02.05    MCC-藤原     01/09/14  管理コードをCOMBOに修正
      *  01.03.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.03.02    MCC-藤原     01/09/25  クリア処理の修正      
      *  01.03.03    MCC-藤原     01/09/27  区分コードの数字チェック追加      
      *  01.03.04    MCC-藤原     01/10/01  出力先プリンタ名割り当ての追加      
      *  01.03.05    MCC-藤原     02/01/10  レセプト印刷情報の追加      
      *  01.03.06    MCC-藤原     02/01/11  帳票編集区分情報の追加     
      *  01.04.01    MCC-藤原     02/02/01  入力エラーの時の確定のチェック     
      *  01.04.02    MCC-藤原     02/03/11  月次統計パラメタの追加     
      *  01.04.03    MCC-藤原     02/04/01  区分コードをコンボボックスに変更     
      *  01.04.04    MCC-藤原     02/04/12  労災医療機関情報の追加     
      *  01.04.05    MCC-藤原     02/04/24  県単独事業情報の追加     
      *  01.05.01    MCC-森脇     02/05/23  チェック機能制御情報の追加
      *  01.05.02    NACL-藤原    02/10/04  区分コードの最大行を２００に変更
      *  01.05.03    NACL-多々納  02/11/12  コード桁数チェック追加
      *                                     一括入力へ
      *  01.05.04    NACL-多々納  02/11/25  ベット数より入院表示判定
      *  01.05.05    NACL-藤原    02/11/27  W15の追加
      *  01.05.06    NACL-藤原    02/11/28  2004 レセプト種別情報を表示しない
      *  01.05.07    NACL-太田    03/03/05  9800 排他制御情報追加
      *  01.05.08    NACL-多々納  03/05/27  診療内容追加（１０１２）
      *  01.05.09    NACL-多々納  03/06/10  無床診療所に排他制御追加
      *  01.05.10    NACL-太田    03/07/08  1027 割引率情報の区分コード表示を
      *                                     修正
      *  01.05.11    NACL-多々納  03/07/11  出力先プリンタ割り当て修正
      *  01.05.12    NACL-多々納  03/07/29  claim接続を入院へも追加
      *  01.05.13    NACL-多々納  03/09/19  区分登録を桁数分編集へ
      *  01.05.14    NACL-多々納  03/10/00  診療行為自動設定へ、
      *                                     患者登録機能情報追加
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-W01.
           03  SPA-W01-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-TBLO          OCCURS  100.
                           11  SPA-GMN-TBANGO     PIC 9(03).
                           11  SPA-GMN-TSTYUKYMD  PIC X(09).
                           11  SPA-GMN-TEDYUKYMD  PIC X(09).  
      *---- (01.02.04) LINE ADD START --------------------------------
                   07  SPA-GMN-KANRICDLST         OCCURS  50.
                       09  SPA-GMN-KANRICDL       PIC X(04).
                       09  SPA-GMN-F1L            PIC X(01).
                       09  SPA-GMN-KANRICDMEIL    PIC X(30).
                   07  SPA-GMN-KANRICD-MAX        PIC 9(02).
      *---- (01.02.04) LINE ADD START --------------------------------
                   07  SPA-GMN-KOUMOKU.
                       09  SPA-GMN-KBNCDLST       OCCURS  200.
                           11  SPA-GMN-KBNCDL     PIC X(08).
                           11  SPA-GMN-F1L        PIC X(01).
                           11  SPA-GMN-KBNCDMEIL  PIC X(26).
                       09  SPA-GMN-KBNCD-MAX      PIC 9(03).    
      *---- (01.02.04) LINE MOD START --------------------------------
      ***              09  SPA-GMN-KANRICD        PIC X(04).
      ***              09  SPA-GMN-NAME           PIC X(30).
                       09  SPA-GMN-KANRICD-G.
                           11  SPA-GMN-KANRICD    PIC X(04).
                           11  SPA-GMN-F1         PIC X(01).
                           11  SPA-GMN-KANRICDMEI PIC X(30).
      *---- (01.02.04) LINE MOD END   --------------------------------
                       09  SPA-GMN-KBNCD-G.
                           11  SPA-GMN-KBNCD      PIC X(08).
                           11  SPA-GMN-F1         PIC X(01).
                           11  SPA-GMN-KBNCDMEI   PIC X(26).
      *---- (01.02.02) LINE ADD START --------------------------------
                       09  SPA-GMN-MIDASI         PIC X(20).
      *---- (01.02.02) LINE ADD END   --------------------------------
                       09  SPA-GMN-KOUMOKU1. 
                           11  SPA-GMN-SELNUM     PIC 9(03).
                           11  SPA-GMN-STYUKYMD   PIC X(10).
                           11  SPA-GMN-EDYUKYMD   PIC X(10).
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-KANRICD            PIC X(04).
                   07  SPA-NAI-KBNCD              PIC X(08).
                   07  SPA-NAI-KOUMOKU.
                       09  SPA-NAI-STYUKYMD       PIC 9(08).
                       09  SPA-NAI-EDYUKYMD       PIC 9(08).
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBLO    OCCURS  100.
                           11  SPA-NAI-TSTYUKYMD  PIC 9(08).
                           11  SPA-NAI-TEDYUKYMD  PIC 9(08).  
      *
              05  SPA-NAI-SELNO                   PIC 9(03).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                            PIC 9(01).
           03  FLG-SYSKANRI                       PIC 9(01).
           03  FLG-TOUROKU                        PIC 9(01).
      *
           03  FLG-CHK                            PIC 9(01).
      *
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                               PIC 9(04).
           03  IDY                               PIC 9(04).
           03  IDZ                               PIC 9(04).
           03  IDX-MAX                           PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SELNO           PIC 9(03).
           03  WRK-HENFLG          PIC 9(01).
           03  WRK-LEN             PIC 9(01).
           03  WRK-WIDMSG          PIC X(70). 
      *
      *****03  WRK-YMD             PIC X(09). 
           03  WRK-YMD             PIC X(10). 
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
      *
           03  WRK-IN              PIC 9(03).
           03  WRK-CODE-MAX        PIC 9(03).
      *    入力項目名
           03  WRK-MCP-WIDGET          PIC X(64).
           03  WRK-RATE-AREA.
               05  WRK-RATE-EDIT.
                   07  WRK-RATE-EDITZ  PIC ZZZZZZZ.
                   07  WRK-RATE-TANI   PIC X(04).
               05  WRK-RATE-EDIT-R  REDEFINES    WRK-RATE-EDIT.
                   07  WRK-RATE-EDITR  PIC X(11).
      *
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *             
      *    管理コード一覧
       01  TBL-KANRICD-AREA.
           03  FILLER              PIC X(35)   VALUE
               "1001 医療機関情報ー基本".
           03  FILLER              PIC X(35)   VALUE
               "1002 医療機関情報ー所在地、連絡先".
           03  FILLER              PIC X(35)   VALUE
               "1003 医療機関情報ー広告".
           03  FILLER              PIC X(35)   VALUE
               "1005 診療科目情報".
           03  FILLER              PIC X(35)   VALUE
               "1006 施設基準情報".
           03  FILLER              PIC X(35)   VALUE
      ******** "1007 自動算定情報".
               "1007 自動算定・チェック機能制御情報".
      *****03  FILLER              PIC X(35)   VALUE
      ******   "1008 チェック機能制御情報".
           03  FILLER              PIC X(35)   VALUE
               "1009 患者番号構成管理情報".
           03  FILLER              PIC X(35)   VALUE
               "1010 職員情報".
           03  FILLER              PIC X(35)   VALUE
               "1012 診療内容情報".
           03  FILLER              PIC X(35)   VALUE
               "1013 請求書自費名称情報".
           03  FILLER              PIC X(35)   VALUE
               "1017 患者登録機能情報".
           03  FILLER              PIC X(35)   VALUE
               "1018 患者状態コメント情報".
           03  FILLER              PIC X(35)   VALUE
               "1019 患者状態コメント情報".
           03  FILLER              PIC X(35)   VALUE
               "1020 患者状態コメント情報".
           03  FILLER              PIC X(35)   VALUE
               "1026 減免事由情報".
           03  FILLER              PIC X(35)   VALUE
               "1027 割引率情報".
           03  FILLER              PIC X(35)   VALUE
               "1030 帳票編集区分情報".
           03  FILLER              PIC X(35)   VALUE
               "1031 出力先プリンタ割り当て情報".
           03  FILLER              PIC X(35)   VALUE
               "1033 県内扱い保険者情報".
           03  FILLER              PIC X(35)   VALUE
               "1036 高額請求資料用薬剤分類情報".
           03  FILLER              PIC X(35)   VALUE
               "2003 レセプト作成指示（印刷順）情報".
           03  FILLER              PIC X(35)   VALUE
               "2005 レセプト・総括印刷情報".
           03  FILLER              PIC X(35)   VALUE
               "3001 統計帳票出力情報（日次）".
           03  FILLER              PIC X(35)   VALUE
               "3002 統計帳票出力情報（月次）".
           03  FILLER              PIC X(35)   VALUE
               "3004 県単独事業情報".
           03  FILLER              PIC X(35)   VALUE
               "4001 労災自賠医療機関情報".
      *
       01  TBL-KANRICD-AREAR           REDEFINES   TBL-KANRICD-AREA.
           03  TBL-KANRICD-TBL         OCCURS   26.
               05  TBL-KANRICD             PIC X(04).
               05  TBL-FILLER              PIC X(01).
               05  TBL-KANRICDMEI          PIC X(30).
       01  TBL-KANRICD-MAX                 PIC 9(04)   VALUE   26.
      *
      *外来のみ
       01  TBL-KANRICD-G-AREA.
           03  FILLER              PIC X(35)   VALUE
               "9000 ＣＬＡＩＭ接続情報".
           03  FILLER              PIC X(35)   VALUE
               "9800 排他制御情報".
       01  TBL-KANRICD-G-AREAR         REDEFINES   TBL-KANRICD-G-AREA.
           03  TBL-KANRICD-G-TBL           OCCURS   2.
               05  TBL-KANRICD-G           PIC X(04).
               05  TBL-FILLER              PIC X(01).
               05  TBL-KANRICDMEI-G        PIC X(30).
       01  TBL-KANRICDG-MAX                 PIC 9(04)   VALUE   2.
      *
      *入院のみ
       01  TBL-KANRICD-N-AREA.
           03  FILLER              PIC X(35)   VALUE
               "5000 医療機関情報−入院基本".
           03  FILLER              PIC X(35)   VALUE
               "5001 病棟管理情報".
           03  FILLER              PIC X(35)   VALUE
               "5002 病室管理情報".
           03  FILLER              PIC X(35)   VALUE
               "5003 病棟入院基本料加算情報".
           03  FILLER              PIC X(35)   VALUE
               "5004 病室入院基本料加算情報".
           03  FILLER              PIC X(35)   VALUE
               "5005 入院用管理マスタ設定".
           03  FILLER              PIC X(35)   VALUE
               "5006 病棟選定入院料情報".
           03  FILLER              PIC X(35)   VALUE
               "5010 定期請求情報".
           03  FILLER              PIC X(35)   VALUE
               "9000 ＣＬＡＩＭ接続情報".
           03  FILLER              PIC X(35)   VALUE
               "9800 排他制御情報".
      *
       01  TBL-KANRICD-N-AREAR         REDEFINES   TBL-KANRICD-N-AREA.
           03  TBL-KANRICD-N-TBL           OCCURS   10.
               05  TBL-KANRICD-N           PIC X(04).
               05  TBL-FILLER              PIC X(01).
               05  TBL-KANRICDMEI-N        PIC X(30).
       01  TBL-KANRICDN-MAX                PIC 9(04)   VALUE   10.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1001.INC".
      *
           COPY    "CPSK1002.INC".
      *
           COPY    "CPSK1003.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK1010.INC".
      *
           COPY    "CPSK1012.INC".
      *
           COPY    "CPSK1013.INC".
      *
           COPY    "CPSK1018.INC".
      *
           COPY    "CPSK1026.INC".
      *
           COPY    "CPSK1027.INC".
      *
           COPY    "CPSK3001.INC".
      *
           COPY    "CPSK3002.INC".
      *
           COPY    "CPSK2003.INC".
      *
           COPY    "CPSK2004.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *----(01.02.03) LINE ADD START ----------------------------------
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *----(01.02.03) LINE ADD END   ----------------------------------
      *
      *
      *    ＤＢ検索
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           COPY    "W01.INC".
           COPY    "W02.INC".
           COPY    "W03.INC".
           COPY    "W04.INC".
           COPY    "W05.INC".
           COPY    "W06.INC".
           COPY    "W07.INC". 
      *---- (01.02.02) LINE ADD START --------------------------------
           COPY    "W08.INC". 
           COPY    "W09.INC".
      *---- (01.02.02) LINE ADD END   --------------------------------
      *----(01.02.04) LINE ADD START ----------------------------------
           COPY    "W10.INC".
      *----(01.02.04) LINE ADD END ------------------------------------
           COPY    "W11.INC".
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W16.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W28.INC".
           COPY    "W98.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
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
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU 
           MOVE    SPA-FREE        TO  SPA-W01
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
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-W01         TO  SPA-FREE
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
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "WERR"
               MOVE    SPACE               TO  SPA-MOTOPG
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
      ***  MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
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
           MOVE    1               TO  SPA-GMN-CUR
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           PERFORM 310-SPASET-SEC
      *
           MOVE    1               TO  SPA-GMN-PAGE
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
      *
           INITIALIZE              SPA-W01-AREA
                                   SPA-W01KYOUTU
           MOVE    ZERO                TO  IDX-MAX
      *    共通の編集
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   TBL-KANRICD-MAX )  OR
                              (IDX-MAX     >=  50  )
               ADD     1                   TO  IDX-MAX
               MOVE    TBL-KANRICD (IDX)   TO  SPA-GMN-KANRICDL
                                                           (IDX-MAX)
               MOVE    TBL-KANRICDMEI(IDX) TO  SPA-GMN-KANRICDMEIL
                                                           (IDX-MAX)
           END-PERFORM
      *
      *    入院はベット数がある時のみ
           IF      SPA-BEDSU           =   ZERO
      *        外来分
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL      (IDX         >   TBL-KANRICDG-MAX) OR
                                  (IDX-MAX     >=  50  )
                   ADD     1                   TO  IDX-MAX
                   MOVE    TBL-KANRICD-G (IDX) TO  SPA-GMN-KANRICDL
                                                           (IDX-MAX)
                   MOVE    TBL-KANRICDMEI-G(IDX)
                                               TO  SPA-GMN-KANRICDMEIL
                                                            (IDX-MAX)
               END-PERFORM
               MOVE    IDX-MAX             TO  SPA-GMN-KANRICD-MAX
               MOVE    1                   TO  SPA-GMN-CUR
               GO      TO        310-SPASET-EXT
           END-IF
      *
      *    入院分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX         >   TBL-KANRICDN-MAX )  OR
                              (IDX-MAX     >=  50  )
               ADD     1                   TO  IDX-MAX
               MOVE    TBL-KANRICD-N (IDX) TO  SPA-GMN-KANRICDL
                                                           (IDX-MAX)
               MOVE    TBL-KANRICDMEI-N(IDX) TO  SPA-GMN-KANRICDMEIL
                                                           (IDX-MAX)
           END-PERFORM
           MOVE    IDX-MAX             TO  SPA-GMN-KANRICD-MAX
           MOVE    1                   TO  SPA-GMN-CUR
      *
      *
      *D   MOVE    "1001"                  TO  SPA-GMN-KANRICDL (1) 
      *    MOVE    "医療機関情報ー基本"    TO  SPA-GMN-KANRICDMEIL(1)
      *    MOVE    "1002"                  TO  SPA-GMN-KANRICDL (2)
      *    MOVE    "医療機関情報ー所在地、連絡先"
      *                                    TO  SPA-GMN-KANRICDMEIL(2)
      *    MOVE    "1003"                  TO  SPA-GMN-KANRICDL (3)
      *    MOVE    "医療機関情報ー広告"    TO  SPA-GMN-KANRICDMEIL(3) 
      *    MOVE    "1005"                  TO  SPA-GMN-KANRICDL (4)
      *    MOVE    "診療科目情報"          TO  SPA-GMN-KANRICDMEIL(4)
      *    MOVE    "1006"                  TO  SPA-GMN-KANRICDL (5)
      *    MOVE    "施設基準情報"          TO  SPA-GMN-KANRICDMEIL(5)
      *    MOVE    "1007"                  TO  SPA-GMN-KANRICDL (6)
      *    MOVE    "自動算定情報"          TO  SPA-GMN-KANRICDMEIL(6)
      *---- (01.05.01) LINE ADD START --------------------------------
      *    MOVE    "1008"                  TO  SPA-GMN-KANRICDL (7)
      *    MOVE    "チェック機能制御情報"  TO  SPA-GMN-KANRICDMEIL(7)
      *---- (01.05.01) LINE ADD END ----------------------------------
      *    MOVE    "1009"                  TO  SPA-GMN-KANRICDL (8)
      *    MOVE    "患者番号構成管理情報"  TO  SPA-GMN-KANRICDMEIL(8)
      *    MOVE    "1010"                  TO  SPA-GMN-KANRICDL (9)
      *    MOVE    "職員情報"              TO  SPA-GMN-KANRICDMEIL(9)
      *    MOVE    "1013"                  TO  SPA-GMN-KANRICDL (10)
      *    MOVE    "請求書自費名称情報"    TO  SPA-GMN-KANRICDMEIL(10)
      *    MOVE    "1018"                  TO  SPA-GMN-KANRICDL (11)
      *    MOVE    "患者状態コメント情報"  TO  SPA-GMN-KANRICDMEIL(11)
      *    MOVE    "1019"                  TO  SPA-GMN-KANRICDL (12)
      *    MOVE    "患者状態コメント情報"  TO  SPA-GMN-KANRICDMEIL(12)
      *    MOVE    "1020"                  TO  SPA-GMN-KANRICDL (13)
      *    MOVE    "患者状態コメント情報"  TO  SPA-GMN-KANRICDMEIL(13)
      *    MOVE    "1026"                  TO  SPA-GMN-KANRICDL (14)
      *    MOVE    "減免事由情報"          TO  SPA-GMN-KANRICDMEIL(14)
      *    MOVE    "1027"                  TO  SPA-GMN-KANRICDL (15)
      *    MOVE    "割引率情報"            TO  SPA-GMN-KANRICDMEIL(15)
      *    MOVE    "1030"                  TO  SPA-GMN-KANRICDL (16)
      *    MOVE    "帳票編集区分情報"      TO  SPA-GMN-KANRICDMEIL(16)
      *    MOVE    "1031"                  TO  SPA-GMN-KANRICDL (17)
      *    MOVE    "出力先プリンタ割り当て情報"
      *                                    TO  SPA-GMN-KANRICDMEIL(17)
      *    MOVE    "1033"                  TO  SPA-GMN-KANRICDL (18)
      *    MOVE    "県内扱い保険者情報"    TO  SPA-GMN-KANRICDMEIL(18)
      *    MOVE    "2003"                  TO  SPA-GMN-KANRICDL (19)
      *    MOVE    "レセプト作成指示（印刷順）情報"
      *                                    TO  SPA-GMN-KANRICDMEIL(19)
      *****MOVE    "2004"                  TO  SPA-GMN-KANRICDL (20)
      *****MOVE    "レセプト種別情報"      TO  SPA-GMN-KANRICDMEIL(20)
      *    MOVE    "2005"                  TO  SPA-GMN-KANRICDL (20)
      *    MOVE    "レセプト・総括印刷情報"
      *                                    TO  SPA-GMN-KANRICDMEIL(20)
      *    MOVE    "3001"                  TO  SPA-GMN-KANRICDL (21)
      *    MOVE    "統計帳票出力情報（日次）"
      *                                    TO  SPA-GMN-KANRICDMEIL(21)
      *    MOVE    "3002"                  TO  SPA-GMN-KANRICDL (22)
      *    MOVE    "統計帳票出力情報（月次）"
      *                                    TO  SPA-GMN-KANRICDMEIL(22)
      *    MOVE    "3004"                  TO  SPA-GMN-KANRICDL (23)
      *    MOVE    "県単独事業情報"        TO  SPA-GMN-KANRICDMEIL(23)
      *    MOVE    "4001"                  TO  SPA-GMN-KANRICDL (24)
      *****MOVE    "労災医療機関情報"
      *    MOVE    "労災自賠医療機関情報"  TO  SPA-GMN-KANRICDMEIL(24)
      *    MOVE    "9000"                  TO  SPA-GMN-KANRICDL (25)
      *****MOVE    "労災医療機関情報"
      *    MOVE    "ＣＬＡＩＭ接続情報"    TO  SPA-GMN-KANRICDMEIL(25)
      *
      *    入院はベット数がある時のみ
      *    IF      SPA-BEDSU           =   ZERO
      *        MOVE    25                  TO  SPA-GMN-KANRICD-MAX
      *        MOVE    1                   TO  SPA-GMN-CUR
      *        GO      TO        310-SPASET-EXT
      *    END-IF
      *
      *    MOVE    "5000"                  TO  SPA-GMN-KANRICDL (25)
      *    MOVE    "医療機関情報−入院基本"
      *                                    TO  SPA-GMN-KANRICDMEIL(25)
      *    MOVE    "5001"                  TO  SPA-GMN-KANRICDL (26)
      *    MOVE    "病棟管理情報"          TO  SPA-GMN-KANRICDMEIL(26)
      *    MOVE    "5002"                  TO  SPA-GMN-KANRICDL (27)
      *    MOVE    "病室管理情報"          TO  SPA-GMN-KANRICDMEIL(27)
      *    MOVE    "5003"                  TO  SPA-GMN-KANRICDL (28)
      *    MOVE    "病棟入院基本料加算情報"
      *                                    TO  SPA-GMN-KANRICDMEIL(28)
      *    MOVE    "5004"                  TO  SPA-GMN-KANRICDL (29)
      *    MOVE    "病室入院基本料加算情報"
      *                                    TO  SPA-GMN-KANRICDMEIL(29)
      *    MOVE    "5005"                  TO  SPA-GMN-KANRICDL (30)
      *    MOVE    "入院用管理マスタ設定"  TO  SPA-GMN-KANRICDMEIL(30)
      *    MOVE    "5006"                  TO  SPA-GMN-KANRICDL (31)
      *    MOVE    "病棟選定入院料情報"    TO  SPA-GMN-KANRICDMEIL(31)
      *    MOVE    "5010"                  TO  SPA-GMN-KANRICDL (32)
      *    MOVE    "定期請求情報"          TO  SPA-GMN-KANRICDMEIL(32)
      ***  排他 INS ST
      *    MOVE    "9800"                  TO  SPA-GMN-KANRICDL (33)
      *    MOVE    "排他制御情報"          TO  SPA-GMN-KANRICDMEIL(33)
      ***  排他 INS ED
      *
      ***  排他 UPD ST
      *    MOVE    31                      TO  SPA-GMN-KANRICD-MAX
      **** MOVE    33                      TO  SPA-GMN-KANRICD-MAX
      ***  排他 UPD ED
      *
      *****MOVE    1               TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                           SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO      MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM  210-BACK
      *---- (01.00.01) LINE ADD START --------------------------------
      *        クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 402-CLEAR-SEC
      *---- (01.00.01) LINE ADD END ----------------------------------
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM  410-KAKUTEI-SEC
           END-EVALUATE
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
      *        管理コード
               WHEN    "ACTIVATE"       ALSO    "KANRICD"
                   PERFORM  4104-KANRICD-CHK-SEC
      *        選択番号
               WHEN    "ACTIVATE"       ALSO    "SELNUM"
                   PERFORM  4101-SELNUM-CHK-SEC
      *        区分コード
               WHEN    "ACTIVATE"       ALSO    "KBNCD"
                   PERFORM  4105-KBNCD-CHK-SEC
      *        一括分
               WHEN    "ACTIVATE"       ALSO    ANY
                   PERFORM 400-ENTRY-SYORI-SEC
      *        行選択
               WHEN    ANY             ALSO    "TENSU_LIST"
                   PERFORM 41015-LIST1SEL-SEC
           END-EVALUATE
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "M02"               TO  SPA-SAKIPG
           MOVE    "W01"               TO  SPA-MOTOPG
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
      *    一括分　入力処理
      *****************************************************************
       400-ENTRY-SYORI-SEC       SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
           MOVE    ZERO                TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       400-ENTRY-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
           IF      FLG-TOUROKU         =   1
      *        更新前
               PERFORM 4101-KAKUTEI-CHK-SEC
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC       SECTION.
      *
           MOVE    W01-STYUKYMD       TO  SPA-GMN-STYUKYMD
           MOVE    W01-EDYUKYMD       TO  SPA-GMN-EDYUKYMD
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC       SECTION.
      *
      *    有効開始年月日
           PERFORM 4102-STYUKYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    有効終了年月日
           PERFORM 4103-EDYUKYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択　入力処理
      *****************************************************************
       4101-SELNUM-CHK-SEC       SECTION.
      *
           MOVE    2               TO  SPA-GMN-CUR
      *     
           INITIALIZE                  SPA-GMN-KOUMOKU1
                                       SPA-NAI-KOUMOKU
                                       SPA-NAI-SELNO
      *
           MOVE    W01-SELNUM             TO  SPA-GMN-SELNUM
      *
      *    選択番号チェック
           IF      SPA-GMN-SELNUM      =   ZERO
               MOVE    3                   TO  SPA-GMN-CUR 
               GO  TO  4101-SELNUM-CHK-EXT 
           ELSE
               IF      SPA-GMN-SELNUM      >=  1
               AND     SPA-GMN-SELNUM      <=  SPA-GMN-MAX
                   CONTINUE 
               ELSE
                   MOVE    "0001"                  TO  SPA-ERRCD
                   GO  TO  4101-SELNUM-CHK-EXT 
               END-IF
           END-IF   
      *
           MOVE    SPA-GMN-SELNUM      TO  SPA-NAI-SELNO
      *
           PERFORM 41011-SELNUM-HENSYU-SEC               
           .
       4101-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号編集処理
      *****************************************************************
       41011-SELNUM-HENSYU-SEC           SECTION.
      *
           MOVE    SPA-GMN-TSTYUKYMD(SPA-GMN-SELNUM)
                                       TO  SPA-GMN-STYUKYMD
           MOVE    SPA-NAI-TSTYUKYMD(SPA-GMN-SELNUM)
                                       TO  SPA-NAI-STYUKYMD
           MOVE    SPA-GMN-TEDYUKYMD(SPA-GMN-SELNUM)
                                       TO  SPA-GMN-EDYUKYMD
           MOVE    SPA-NAI-TEDYUKYMD(SPA-GMN-SELNUM)
                                       TO  SPA-NAI-EDYUKYMD
      *
           MOVE    3                   TO  SPA-GMN-CUR 
           .
       41011-SELNUM-HENSYU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    有効開始年月日チェック処理
      *****************************************************************
       4102-STYUKYMD-CHK-SEC          SECTION.
      *
      *
      **** MOVE    W01-STYUKYMD       TO  SPA-GMN-STYUKYMD
      *     
           MOVE    ZERO               TO  SPA-NAI-STYUKYMD 
      *
           IF      SPA-GMN-STYUKYMD   =   SPACE
               IF      WRK-MCP-WIDGET     =   "STYUKYMD"
                   MOVE    "00000000"         TO  SPA-GMN-STYUKYMD
               END-IF
               GO  TO  4102-STYUKYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-STYUKYMD   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-SYMD             TO  SPA-NAI-STYUKYMD 
               MOVE    WRK-HENYMDG          TO  SPA-GMN-STYUKYMD
           ELSE
               MOVE    3                  TO  SPA-GMN-CUR
               GO  TO  4102-STYUKYMD-CHK-EXT
           END-IF
      *
      *****MOVE    4                   TO  SPA-GMN-CUR
      *
           .
       4102-STYUKYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    有効終了年月日チェック処理
      *****************************************************************
       4103-EDYUKYMD-CHK-SEC          SECTION.
      *
      **** MOVE    4                  TO  SPA-GMN-CUR
      *
      **** MOVE   W01-EDYUKYMD        TO  SPA-GMN-EDYUKYMD
      *
      *
           IF      SPA-GMN-EDYUKYMD   =   SPACE
               IF      WRK-MCP-WIDGET     =   "EDYUKYMD"
                   MOVE    "99999999"         TO  SPA-GMN-EDYUKYMD
               ELSE
                   MOVE    ZERO               TO  SPA-NAI-EDYUKYMD
                   GO  TO  4103-EDYUKYMD-CHK-EXT
               END-IF
           END-IF
      *
           MOVE    SPA-GMN-EDYUKYMD    TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-SYMD            TO  SPA-NAI-EDYUKYMD 
               MOVE    WRK-HENYMDG         TO  SPA-GMN-EDYUKYMD
           ELSE
               MOVE    4                   TO  SPA-GMN-CUR
               GO  TO  4103-EDYUKYMD-CHK-EXT
           END-IF
      *
           IF     (SPA-GMN-STYUKYMD    NOT =   SPACE )  AND
                  (SPA-GMN-EDYUKYMD    NOT =   SPACE )
               IF      SPA-NAI-STYUKYMD    >   SPA-NAI-EDYUKYMD
                   MOVE    "0020"              TO  SPA-ERRCD
                   MOVE    4                   TO  SPA-GMN-CUR
               END-IF
           END-IF
      *****MOVE    12                 TO  SPA-GMN-CUR
      *
           .
       4103-EDYUKYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理コード　入力処理
      *****************************************************************
       4104-KANRICD-CHK-SEC       SECTION.
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
                                       SPA-GMN-TBL
                                       SPA-NAIB-AREA
                                       SPA-NAI-SELNO 
           MOVE    ZERO            TO  SPA-GMN-MAX
      *
           MOVE    W01-KANRICD     TO  SPA-GMN-KANRICD-G
      *
           IF      SPA-GMN-KANRICD =   SPACE
               MOVE    "0005"          TO  SPA-ERRCD
               GO  TO  4104-KANRICD-CHK-EXT 
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KANRICD-MAX
                       OR      WRK-HENFLG  =   1
                   IF      SPA-GMN-KANRICD =   SPA-GMN-KANRICDL (IDY)
                       MOVE    SPA-GMN-KANRICDLST (IDY)
                                           TO  SPA-GMN-KANRICD-G
                       MOVE    1           TO  WRK-HENFLG
                   END-IF                                     
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0005"                  TO  SPA-ERRCD
                   GO  TO  4104-KANRICD-CHK-EXT
               END-IF     
           END-IF
      *
           MOVE    SPA-GMN-KANRICD        TO  SPA-NAI-KANRICD
      *     
           EVALUATE    SPA-GMN-KANRICD
               WHEN    "1005"
               WHEN    "1010"
               WHEN    "1012"
               WHEN    "1013"
               WHEN    "1018"
               WHEN    "1019"
               WHEN    "1020"
               WHEN    "1026"
               WHEN    "1027"
      *---- (01.02.04) LINE ADD START --------------------------------
               WHEN    "3001"
               WHEN    "3002"
      *---- (01.02.04) LINE ADD END ----------------------------------
      *---- (01.02.02) LINE ADD START --------------------------------
               WHEN    "2003"
               WHEN    "2004"
                   EVALUATE    SPA-GMN-KANRICD
                       WHEN    "1005"
                           MOVE    "診療科目コード"
                                                   TO  SPA-GMN-MIDASI
                       WHEN    "1010"
                           MOVE    "職員コード　　"
                                                   TO  SPA-GMN-MIDASI
                       WHEN    "2003"
                           MOVE    "レセプト出力順"
                                                   TO  SPA-GMN-MIDASI
                       WHEN    "2004"
                           MOVE    "レセプト種別　"
                                                   TO  SPA-GMN-MIDASI
                       WHEN    OTHER
                           MOVE    "区分コード　　"
                                                   TO  SPA-GMN-MIDASI
                   END-EVALUATE 
      *---- (01.02.02) LINE ADD END   --------------------------------
                   PERFORM 41041-KBNCD-HENSYU-SEC
                   MOVE    5               TO  SPA-GMN-CUR
                   GO  TO  4104-KANRICD-CHK-EXT
               WHEN    "1036"
               WHEN    "5001"
               WHEN    "5002"
               WHEN    "5003"
               WHEN    "5004"
               WHEN    "5005"
               WHEN    "5006"
                   MOVE    SPACE           TO  SPA-GMN-KBNCD
                   MOVE    12              TO  SPA-GMN-CUR
                   GO  TO  4104-KANRICD-CHK-EXT
      *        出力先プリンタ割り当て
               WHEN    "1031"
                   PERFORM 41041-1031-HEN-SEC
                   MOVE    12                      TO  SPA-GMN-CUR
                   GO  TO  4104-KANRICD-CHK-EXT
               WHEN    OTHER
                   MOVE    SPACE           TO  SPA-GMN-KBNCD 
           END-EVALUATE         
      
      *    システム管理読み込み
           MOVE    SPACE               TO  SYS-KEY
           MOVE    SPA-GMN-KANRICD     TO  SYS-KANRICD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   FLG-SYSKANRI   =   1
                               OR      IDX            >=  100
               MOVE    MCPDATA-REC        TO  SYSKANRI-REC
               IF (   (SYS-KBNCD (1:1)        =   "*" OR  "1" )
                  AND (SYS-KANRICD        NOT =   "3004"      ))      
               OR (   (SYS-KBNCD (1:4)        =   "0001"  )
                  AND (SYS-KANRICD            =   "3004"      ))      
                   ADD     1              TO  IDX
                   MOVE    IDX            TO  SPA-GMN-TBANGO    (IDX)
                   MOVE    SYS-STYUKYMD   TO  SPA-NAI-TSTYUKYMD (IDX)
                   MOVE    SYS-STYUKYMD   TO  WRK-SYMD
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG    TO  SPA-GMN-TSTYUKYMD (IDX)
                   MOVE    SYS-EDYUKYMD   TO  SPA-NAI-TEDYUKYMD (IDX)
                   MOVE    SYS-EDYUKYMD   TO  WRK-SYMD
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG    TO  SPA-GMN-TEDYUKYMD (IDX)
                   MOVE    IDX            TO  SPA-GMN-MAX
               END-IF   
      *
               MOVE    "SYSKANRI-KEY5"    TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           EVALUATE    SPA-GMN-MAX
               WHEN    ZERO
                   MOVE    3                       TO  SPA-GMN-CUR
               WHEN    1
                   MOVE    SPA-GMN-TSTYUKYMD (1)   TO  SPA-GMN-STYUKYMD
                   MOVE    SPA-NAI-TSTYUKYMD (1)   TO  SPA-NAI-STYUKYMD
                   MOVE    SPA-GMN-TEDYUKYMD (1)   TO  SPA-GMN-EDYUKYMD
                   MOVE    SPA-NAI-TEDYUKYMD (1)   TO  SPA-NAI-EDYUKYMD
                   MOVE    1                       TO  SPA-GMN-SELNUM
                                                       SPA-NAI-SELNO
                   MOVE    12                      TO  SPA-GMN-CUR
               WHEN    OTHER
                   MOVE    2                       TO  SPA-GMN-CUR
           END-EVALUATE
           .
       4104-KANRICD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力先プリンタ割り当て編集処理
      *****************************************************************
       41041-1031-HEN-SEC              SECTION.
      *
      *    システム管理読み込み
           MOVE    SPACE               TO  SYS-KEY
           MOVE    SPA-GMN-KANRICD     TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY4"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY4"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   FLG-SYSKANRI   =   1
                               OR      IDX            >=  100
               MOVE    MCPDATA-REC        TO  SYSKANRI-REC
               ADD     1                  TO  IDX
               MOVE    IDX                TO  SPA-GMN-TBANGO    (IDX)  
               MOVE    SYS-STYUKYMD       TO  SPA-NAI-TSTYUKYMD (IDX)
               MOVE    SYS-STYUKYMD       TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG        TO  SPA-GMN-TSTYUKYMD (IDX)
               MOVE    SYS-EDYUKYMD       TO  SPA-NAI-TEDYUKYMD (IDX)
               MOVE    SYS-EDYUKYMD       TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG         TO  SPA-GMN-TEDYUKYMD (IDX)
               MOVE    IDX                 TO  SPA-GMN-MAX
      *
               MOVE    "SYSKANRI-KEY4"       TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY4"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           EVALUATE    SPA-GMN-MAX
               WHEN    ZERO
                   MOVE    3                       TO  SPA-GMN-CUR
               WHEN    1
                   MOVE    SPA-GMN-TSTYUKYMD (1)   TO  SPA-GMN-STYUKYMD
                   MOVE    SPA-NAI-TSTYUKYMD (1)   TO  SPA-NAI-STYUKYMD
                   MOVE    SPA-GMN-TEDYUKYMD (1)   TO  SPA-GMN-EDYUKYMD
                   MOVE    SPA-NAI-TEDYUKYMD (1)   TO  SPA-NAI-EDYUKYMD
                   MOVE    1                       TO  SPA-GMN-SELNUM
                                                       SPA-NAI-SELNO
                   MOVE    12                      TO  SPA-GMN-CUR
               WHEN    OTHER
                   MOVE    2                       TO  SPA-GMN-CUR
           END-EVALUATE           
           .
       41041-1031-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    区分コード編集処理
      *****************************************************************
       41041-KBNCD-HENSYU-SEC   SECTION.
      *    システム管理読み込み
           MOVE    SPACE               TO  SYS-KEY
           MOVE    SPA-GMN-KANRICD     TO  SYS-KANRICD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY6"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY6"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   FLG-SYSKANRI   =   1
                               OR      IDX            >=  200
               ADD     1              TO  IDX
               MOVE    MCPDATA-REC        TO  SYSKANRI-REC
               MOVE    SYS-KBNCD          TO  SPA-GMN-KBNCDL (IDX)
               EVALUATE    SPA-GMN-KANRICD
                   WHEN    "1005"
                       MOVE    SYSKANRI-REC   TO  SYS-1005-REC
                       MOVE    SYS-1005-SRYKANAME (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
                   WHEN    "1010"
                       MOVE    SYSKANRI-REC   TO  SYS-1010-REC
                       MOVE    SYS-1010-NAME (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
      *            診療内容
                   WHEN    "1012"
                       MOVE    SYSKANRI-REC   TO  SYS-1012-REC
                       MOVE    SYS-1012-SRYNAIYO (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
      *
                   WHEN    "1013"
                       MOVE    SYSKANRI-REC   TO  SYS-1013-REC
                       MOVE    SYS-1013-JIHINAME (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
                   WHEN    "1018"
                   WHEN    "1019"
                   WHEN    "1020"
                       MOVE    SYSKANRI-REC   TO  SYS-1018-REC
                       MOVE    SYS-1018-CONDITION-BODY (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
                   WHEN    "1026"
                       MOVE    SYSKANRI-REC   TO  SYS-1026-REC
                       MOVE    SYS-1026-DISCOUNT-BODY (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
                   WHEN    "1027"
                       MOVE    SYSKANRI-REC   TO  SYS-1027-REC
                       MOVE    SPACE          TO  WRK-RATE-AREA
                       MOVE    SYS-1027-DISCOUNT-RATE
                                              TO  WRK-RATE-EDITZ
                       EVALUATE    SYS-1027-TEIRITU
                       WHEN    "0"
                           MOVE    "該当なし" TO  WRK-RATE-EDIT-R
                       WHEN    "1"
                           MOVE    "(%)"      TO  WRK-RATE-TANI
                       WHEN    "2"
                           MOVE    "(円)"     TO  WRK-RATE-TANI
                       END-EVALUATE
                       MOVE    WRK-RATE-AREA  TO  SPA-GMN-KBNCDMEIL(IDX)
                   WHEN    "3001"
                       MOVE    SYSKANRI-REC   TO  SYS-3001-REC
                       MOVE    SYS-3001-HCNAME (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
                   WHEN    "3002"
                       MOVE    SYSKANRI-REC   TO  SYS-3002-REC
                       MOVE    SYS-3002-HCNAME (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
                   WHEN    "2003"
                       MOVE    SYSKANRI-REC   TO  SYS-2003-REC
                       MOVE    SYS-2003-SYURUINAME (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
                   WHEN    "2004"
                       MOVE    SYSKANRI-REC   TO  SYS-2004-REC
                       MOVE    SYS-2004-SYUBETUNAME (1:26)
                                              TO  SPA-GMN-KBNCDMEIL(IDX)
               END-EVALUATE
      *
               MOVE    "SYSKANRI-KEY6"    TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY6"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    IDX                 TO  SPA-GMN-KBNCD-MAX
      *
           IF      IDX                 >   ZERO
               MOVE    SPA-GMN-KBNCDLST (1)    TO  SPA-GMN-KBNCD-G
           END-IF           
           .
       41041-KBNCD-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    区分コード　入力処理
      *****************************************************************
       4105-KBNCD-CHK-SEC       SECTION.
      *
           MOVE    5               TO  SPA-GMN-CUR
      *
           INITIALIZE                  SPA-GMN-KOUMOKU1
                                       SPA-GMN-TBL
                                       SPA-GMN-KBNCD-G
                                       SPA-NAI-KOUMOKU
                                       SPA-NAI-SELNO 
                                       SPA-NAI-KBNCD
           MOVE    ZERO           TO  SPA-GMN-MAX 
      *
           MOVE    W01-KBNCD           TO  SPA-GMN-KBNCD-G
      *
      *    区分コードの桁数
           MOVE    ZERO                TO  WRK-LEN
           PERFORM VARYING IDZ     FROM    1   BY  1
                   UNTIL   IDZ     >   35
               IF      SPA-GMN-KBNCD-G(IDZ:1)  NOT =   SPACE
                   ADD     1               TO  WRK-LEN
               ELSE
                   MOVE    35              TO  IDZ
               END-IF
           END-PERFORM
      *
           MOVE    ZERO                TO  WRK-CODE-MAX
           EVALUATE    SPA-GMN-KANRICD
               WHEN    "1005"
               WHEN    "1012"
               WHEN    "1018"
               WHEN    "1019"
               WHEN    "1020"
               WHEN    "1026"
               WHEN    "1027"
      *---- (01.02.02) LINE ADD START --------------------------------
      *********WHEN    "2003"
      *---- (01.02.02) LINE ADD END   --------------------------------
                   MOVE    2                   TO  WRK-CODE-MAX
      ***********  IF      WRK-LEN         NOT =   2
                   IF      WRK-LEN             >   2
                       MOVE    "0008"          TO  SPA-ERRCD
                       GO  TO  4105-KBNCD-CHK-EXT
                   END-IF
               WHEN    "1013"
                   MOVE    2                   TO  WRK-CODE-MAX
                   IF      WRK-LEN         NOT =   2
                       MOVE    "0008"          TO  SPA-ERRCD
                       GO  TO  4105-KBNCD-CHK-EXT
                   END-IF
                   IF      SPA-GMN-KBNCD (1:1) NOT =   "1" AND "2"
                       MOVE    "0009"          TO  SPA-ERRCD
                       GO  TO  4105-KBNCD-CHK-EXT
                   END-IF
                   IF      SPA-GMN-KBNCD (2:1)     <   "1"     OR
                           SPA-GMN-KBNCD (2:1)     >   "5" 
                       MOVE    "0010"          TO  SPA-ERRCD
                       GO  TO  4105-KBNCD-CHK-EXT
                   END-IF
               WHEN    "1010"
                   MOVE    5                   TO  WRK-CODE-MAX
                   IF      WRK-LEN         NOT =   5
                       MOVE    "0011"          TO  SPA-ERRCD
                       GO  TO  4105-KBNCD-CHK-EXT
                   END-IF
                   IF    ( SPA-GMN-KBNCD (1:1) =   "1" OR  "2"  OR 
                                                   "3" OR  "4"  OR
                                                   "5" ) OR
                           SPA-GMN-KBNCD       =   "00001"
                       CONTINUE
                   ELSE  
                       MOVE    "0012"          TO  SPA-ERRCD
                       GO  TO  4105-KBNCD-CHK-EXT
                   END-IF
      *---- (01.02.02) LINE ADD START --------------------------------
               WHEN    "2004"
                   MOVE    4                   TO  WRK-CODE-MAX
                   IF      WRK-LEN             >   4
                       MOVE    "0013"          TO  SPA-ERRCD
                       GO  TO  4105-KBNCD-CHK-EXT
                   END-IF
      *---- (01.02.02) LINE ADD END   --------------------------------
      *---- (01.02.04) LINE ADD START --------------------------------
               WHEN    "3001"
               WHEN    "3002"
               WHEN    "2003"
                   MOVE    3                   TO  WRK-CODE-MAX
                   IF      WRK-LEN             >  3
                       MOVE    "0014"          TO  SPA-ERRCD
                       GO  TO  4105-KBNCD-CHK-EXT
                   END-IF
      *---- (01.02.04) LINE ADD END ----------------------------------
               WHEN    OTHER
                   MOVE    SPACE           TO  SPA-GMN-KBNCD
                   MOVE    "0002"          TO  SPA-ERRCD
                   MOVE    1               TO  SPA-GMN-CUR 
                   GO  TO  4105-KBNCD-CHK-EXT
           END-EVALUATE
      *         
           IF      SPA-GMN-KBNCD           =   SPACE
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  4105-KBNCD-CHK-EXT
           END-IF
      *
           INITIALIZE                  ORCSNUMAREA
           MOVE    SPA-GMN-KBNCD(1:WRK-LEN)
                                       TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0007"                  TO  SPA-ERRCD
               GO  TO  4105-KBNCD-CHK-EXT
           ELSE
               COMPUTE WRK-IN          =   15  -   WRK-CODE-MAX
                                       +   1
               MOVE    SPACE           TO  SPA-GMN-KBNCD
               MOVE    SNUM-OUTEDT(WRK-IN:WRK-CODE-MAX)
                                       TO  SPA-GMN-KBNCD(1:WRK-CODE-MAX)
           END-IF
      *
           MOVE    ZERO               TO  WRK-HENFLG
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-KBNCD-MAX
                   OR      WRK-HENFLG  =   1
               IF      SPA-GMN-KBNCD   =   SPA-GMN-KBNCDL (IDY)
                   MOVE    SPA-GMN-KBNCDLST (IDY)
                                           TO  SPA-GMN-KBNCD-G
                   MOVE    1           TO  WRK-HENFLG
               END-IF                                     
           END-PERFORM
      *    新規の時名称を空白にする
           IF      WRK-HENFLG          =   ZERO
               MOVE    SPACE               TO  SPA-GMN-KBNCDMEI
           END-IF
      *
           MOVE    SPA-GMN-KBNCD       TO  SPA-NAI-KBNCD
      *
      *    システム管理読み込み
           MOVE    SPACE               TO  SYS-KEY
           MOVE    SPA-GMN-KANRICD     TO  SYS-KANRICD
           MOVE    SPA-GMN-KBNCD       TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY4"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY4"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   FLG-SYSKANRI   =   1
                               OR      IDX            >=  100
               MOVE    MCPDATA-REC        TO  SYSKANRI-REC
               ADD     1                  TO  IDX
               MOVE    IDX                TO  SPA-GMN-TBANGO    (IDX)  
               MOVE    SYS-STYUKYMD       TO  SPA-NAI-TSTYUKYMD (IDX)
               MOVE    SYS-STYUKYMD       TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG        TO  SPA-GMN-TSTYUKYMD (IDX)
               MOVE    SYS-EDYUKYMD       TO  SPA-NAI-TEDYUKYMD (IDX)
               MOVE    SYS-EDYUKYMD       TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG         TO  SPA-GMN-TEDYUKYMD (IDX)
               MOVE    IDX                 TO  SPA-GMN-MAX
      *
               MOVE    "SYSKANRI-KEY4"       TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY4"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           EVALUATE    SPA-GMN-MAX
               WHEN    ZERO
                   MOVE    3                       TO  SPA-GMN-CUR
               WHEN    1
                   MOVE    SPA-GMN-TSTYUKYMD (1)   TO  SPA-GMN-STYUKYMD
                   MOVE    SPA-NAI-TSTYUKYMD (1)   TO  SPA-NAI-STYUKYMD
                   MOVE    SPA-GMN-TEDYUKYMD (1)   TO  SPA-GMN-EDYUKYMD
                   MOVE    SPA-NAI-TEDYUKYMD (1)   TO  SPA-NAI-EDYUKYMD
                   MOVE    1                       TO  SPA-GMN-SELNUM
                                                       SPA-NAI-SELNO
                   MOVE    12                      TO  SPA-GMN-CUR
               WHEN    OTHER
                   MOVE    2                       TO  SPA-GMN-CUR
           END-EVALUATE           
           .
       4105-KBNCD-CHK-EXT.
           EXIT.
      *---- (01.00.01) LINE ADD START ---------------------------------
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41015-LIST1SEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       100
               IF      W01-SELECT (IDX)    =   "T"
                   IF      IDX             =   SPA-NAI-SELNO 
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNO
                       MOVE    100             TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-SELNO 
           END-IF
      *
           MOVE    SPA-NAI-SELNO      TO  SPA-GMN-SELNUM 
      *
           PERFORM 41011-SELNUM-HENSYU-SEC               
           .
       41015-LIST1SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目クリア
      *****************************************************************
       402-CLEAR-SEC                   SECTION.
      *
      *
           INITIALIZE              SPA-GMN-MAX
                                   SPA-GMN-TBL
                                   SPA-GMN-KOUMOKU
                                   SPA-NAIB-AREA  
      *
           MOVE    1               TO  SPA-GMN-CUR
           .
       402-CLEAR-EXT.
           EXIT.
      *---- (01.00.01) LINE ADD END -----------------------------------
      *
      *****************************************************************
      *    確定
      *****************************************************************
       410-KAKUTEI-SEC           SECTION.
      *
           IF    ( SPA-GMN-KANRICD     =   "1036"
             OR                            "5001"
             OR                            "5002" 
             OR                            "5003" 
             OR                            "5004" 
             OR                            "5005"
             OR                            "5006")
               CONTINUE
           ELSE
      *        入力チェック
               MOVE    1                   TO  FLG-TOUROKU
               PERFORM 410-INPUT-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  410-KAKUTEI-EXT
               END-IF
           END-IF
      *
           MOVE    SPA-W01KYOUTU       TO  SPA-WORK
      *
           EVALUATE    SPA-GMN-KANRICD
               WHEN    "1001"
               WHEN    "1002"
               WHEN    "1003" 
               WHEN    "1012"
               WHEN    "1013"
               WHEN    "1018"
               WHEN    "1019"
               WHEN    "1020" 
               WHEN    "1026"
               WHEN    "1027"
                   MOVE    "W02"               TO  SPA-SAKIPG
               WHEN    "1005" 
                   MOVE    "W05"               TO  SPA-SAKIPG
               WHEN    "1006" 
                   MOVE    "W03"               TO  SPA-SAKIPG
               WHEN    "1009" 
                   MOVE    "W04"               TO  SPA-SAKIPG
               WHEN    "1010" 
                   MOVE    "W06"               TO  SPA-SAKIPG
               WHEN    "1007" 
      *---- (01.05.01) LINE ADD START --------------------------------
      *********WHEN    "1008"
               WHEN    "1017"
      *---- (01.05.01) LINE ADD END ----------------------------------
                   MOVE    "W07"               TO  SPA-SAKIPG
      *---- (01.02.04) LINE ADD START --------------------------------
               WHEN    "3001"
               WHEN    "3002"
                   MOVE    "W10"               TO  SPA-SAKIPG
      *---- (01.02.04) LINE ADD END ----------------------------------
      *---- (01.02.02) LINE ADD START --------------------------------
               WHEN    "2003"
                   MOVE    "W09"               TO  SPA-SAKIPG
               WHEN    "2004"
                   MOVE    "W08"               TO  SPA-SAKIPG
      *---- (01.02.02) LINE ADD END   --------------------------------
              WHEN    "1030"
              WHEN    "1031"
                   MOVE    "W11"               TO  SPA-SAKIPG
               WHEN    "2005"
                   MOVE    "W12"               TO  SPA-SAKIPG
               WHEN    "4001"
                   MOVE    "W13"               TO  SPA-SAKIPG
               WHEN    "3004"
                   MOVE    "W14"               TO  SPA-SAKIPG
               WHEN    "1033"
                   MOVE    "W15"               TO  SPA-SAKIPG
               WHEN    "1036"
                   MOVE    "W16"               TO  SPA-SAKIPG
               WHEN    "5000"
                   MOVE    "W24"               TO  SPA-SAKIPG
               WHEN    "5001"
                   MOVE    "W20"               TO  SPA-SAKIPG
               WHEN    "5002"
                   MOVE    "W21"               TO  SPA-SAKIPG
               WHEN    "5003"
                   MOVE    "W26"               TO  SPA-SAKIPG
               WHEN    "5004"
                   MOVE    "W27"               TO  SPA-SAKIPG
               WHEN    "5005"
                   MOVE    "W22"               TO  SPA-SAKIPG
               WHEN    "5006"
                   MOVE    "W28"               TO  SPA-SAKIPG
               WHEN    "5010"
                   MOVE    "W23"               TO  SPA-SAKIPG
               WHEN    "9000"
                   MOVE    "W99"               TO  SPA-SAKIPG
      *        排他 INS ST
               WHEN    "9800"
                   MOVE    "W98"               TO  SPA-SAKIPG
      *        排他 INS ED
           END-EVALUATE
           MOVE    "W01"               TO  SPA-MOTOPG
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   SPA-SAKIPG           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       410-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定ボタン押下時チェック処理
      *****************************************************************
       4101-KAKUTEI-CHK-SEC        SECTION.
      *
           IF      SPA-NAI-KANRICD     =   SPACE
               MOVE    1                   TO  SPA-GMN-CUR
               MOVE    "0003"              TO  SPA-ERRCD
               GO  TO  4101-KAKUTEI-CHK-EXT
           END-IF
           IF      SPA-NAI-STYUKYMD        =   ZERO
               IF      SPA-GMN-STYUKYMD(1:8)   =   ALL "0"
                   CONTINUE
               ELSE
                   MOVE    3                   TO  SPA-GMN-CUR
                   MOVE    "0003"              TO  SPA-ERRCD
                   GO  TO  4101-KAKUTEI-CHK-EXT
               END-IF
           END-IF
           IF      SPA-NAI-EDYUKYMD    =   ZERO
               IF      SPA-GMN-EDYUKYMD    =   SPACE
                   MOVE    ALL "9"             TO  SPA-NAI-EDYUKYMD
                   MOVE    "99999999"          TO  SPA-GMN-EDYUKYMD
               ELSE
                   MOVE    4                   TO  SPA-GMN-CUR
                   MOVE    "0003"              TO  SPA-ERRCD
                   GO  TO  4101-KAKUTEI-CHK-EXT
               END-IF
           END-IF
      *
           EVALUATE    SPA-GMN-KANRICD
               WHEN    "1005"
               WHEN    "1010"
               WHEN    "1012"
               WHEN    "1013"
               WHEN    "1018"
               WHEN    "1019"
               WHEN    "1020"
               WHEN    "1026"
               WHEN    "1027"
      *---- (01.02.04) LINE ADD START --------------------------------
               WHEN    "3001"
               WHEN    "3002"
      *---- (01.02.04) LINE ADD END ----------------------------------
      *---- (01.02.02) LINE ADD START --------------------------------
               WHEN    "2003"
               WHEN    "2004"
      *---- (01.02.02) LINE ADD END   --------------------------------
                   IF      SPA-NAI-KBNCD       =   SPACE
                       MOVE    5                   TO  SPA-GMN-CUR
                       MOVE    "0003"              TO  SPA-ERRCD
                       GO  TO  4101-KAKUTEI-CHK-EXT
                   END-IF
           END-EVALUATE         
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-MAX
                   OR      SPA-ERRCD   NOT =   SPACE
               IF      SPA-GMN-SELNUM      =   IDX 
      *            選択された内容の開始日が変更された場合
                   IF      SPA-NAI-STYUKYMD    =   SPA-NAI-TSTYUKYMD
                                                               (IDX)
                       MOVE    ZERO            TO  FLG-CHK
                   ELSE
                       MOVE    1               TO  FLG-CHK
                   END-IF
               ELSE
                   MOVE    1               TO  FLG-CHK
               END-IF
               IF      FLG-CHK             =   1
                   IF     (SPA-NAI-TEDYUKYMD (IDX)
                                           <   SPA-NAI-STYUKYMD )  OR
                          (SPA-NAI-TSTYUKYMD (IDX)
                                           >   SPA-NAI-EDYUKYMD )
                       CONTINUE
                   ELSE
                       MOVE    "0004"              TO  SPA-ERRCD 
                   END-IF
      *************IF     (SPA-NAI-STYUKYMD
      *                                    >=  SPA-NAI-TSTYUKYMD (IDX))
      *            AND    (SPA-NAI-STYUKYMD
      *                                    <=  SPA-NAI-TEDYUKYMD (IDX))
      *                MOVE    "0004"              TO  SPA-ERRCD 
      *            END-IF
      *            IF      SPA-NAI-EDYUKYMD
      *                                    >=  SPA-NAI-TSTYUKYMD (IDX)
      *            AND     SPA-NAI-EDYUKYMD
      *                                    <=  SPA-NAI-TEDYUKYMD (IDX)
      *                MOVE    "0004"              TO  SPA-ERRCD 
      ************ END-IF
               END-IF
           END-PERFORM 
           IF      SPA-ERRCD           NOT =   SPACE
               MOVE    3                   TO  SPA-GMN-CUR
               GO  TO  4101-KAKUTEI-CHK-EXT
           END-IF      
      *                   
      *    画面移行用のパラメタ
           INITIALIZE                  SPA-W01KYOUTU
           MOVE    SPA-GMN-KANRICD     TO  SPA-W01-KANRICD
           EVALUATE    SPA-GMN-KANRICD
               WHEN    "1005"
               WHEN    "1010"
               WHEN    "1012"
               WHEN    "1013"
               WHEN    "1018"
               WHEN    "1019"
               WHEN    "1020" 
               WHEN    "1026"
               WHEN    "1027"
      *---- (01.02.04) LINE ADD START --------------------------------
               WHEN    "3001"
               WHEN    "3002"
      *---- (01.02.04) LINE ADD END ----------------------------------
      *---- (01.02.02) LINE ADD START --------------------------------
               WHEN    "2003"
               WHEN    "2004"
      *---- (01.02.02) LINE ADD END   --------------------------------
                   MOVE    SPA-GMN-KBNCD       TO  SPA-W01-KBNCD
           END-EVALUATE         
           MOVE    SPA-NAI-STYUKYMD    TO  SPA-W01-STYUKYMD
           MOVE    SPA-NAI-EDYUKYMD    TO  SPA-W01-EDYUKYMD 
           MOVE    SPA-GMN-STYUKYMD    TO  SPA-W01-STYUKYMDH
           MOVE    SPA-GMN-EDYUKYMD    TO  SPA-W01-EDYUKYMDH
           MOVE    SPA-GMN-SELNUM      TO  SPA-W01-SELNUM
           IF      SPA-GMN-SELNUM      >   ZERO
               MOVE    SPA-NAI-TSTYUKYMD (SPA-GMN-SELNUM)
                                           TO  SPA-W01-SEL-STYUKYMD
               MOVE    SPA-NAI-TEDYUKYMD (SPA-GMN-SELNUM)
                                           TO  SPA-W01-SEL-EDYUKYMD
           END-IF
      *
           .
       4101-KAKUTEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           EVALUATE  WRK-YMD(1:8)
               WHEN  ZERO
                   MOVE  ZERO                    TO  WRK-SYMD
                   MOVE  WRK-YMD(1:8)            TO  WRK-HENYMDG
               WHEN  "99999999"
                   MOVE  ALL "9"                 TO  WRK-SYMD
                   MOVE  WRK-YMD(1:8)            TO  WRK-HENYMDG  
               WHEN    OTHER
      *----(01.00.03) LINE ADD START --------------------------------
      *            日付画面チェックサブ
                   INITIALIZE                      ORCSGDAYAREA
                   MOVE    WRK-YMD             TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"          USING
                                               ORCSGDAYAREA
                   IF      SGDAY-RC            =   ZERO
                       MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
                       MOVE    SGDAY-SDAY          TO  WRK-SYMD
                   ELSE
                       MOVE    "0002"              TO  SPA-ERRCD
                   END-IF
      *----(01.00.03) LINE ADD END   --------------------------------
           END-EVALUATE        
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   ZERO
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
           MOVE    "W01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  W01
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-MAX
               MOVE    SPA-GMN-TBANGO    (IDX) TO  W01-TSELNUM  (IDX)
               MOVE    SPA-GMN-TSTYUKYMD (IDX) TO  W01-TSTYUKYMD(IDX)
               MOVE    SPA-GMN-TEDYUKYMD (IDX) TO  W01-TEDYUKYMD(IDX)
               MOVE    IDX                     TO  W01-COUNT
               IF      IDX             =   SPA-NAI-SELNO 
                   MOVE    "T"             TO  W01-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  W01-SELECT (IDX)
               END-IF
           END-PERFORM   
           MOVE    SPA-GMN-MAX         TO  W01-COUNT
      *
           MOVE    SPA-GMN-SELNUM      TO  W01-SELNUM
           MOVE    SPA-GMN-STYUKYMD    TO  W01-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD    TO  W01-EDYUKYMD
      *    管理コード
           MOVE    SPA-GMN-KANRICD-G   TO  W01-KANRICD
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL   IDX >       SPA-GMN-KANRICD-MAX
               MOVE    SPA-GMN-KANRICDLST (IDX)
                                       TO  W01-KANRICD-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN-KANRICD-MAX TO  W01-KANRICD-COUNT
      *    区分コード
           MOVE    SPA-GMN-KBNCD-G     TO  W01-KBNCD
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL   IDX >       SPA-GMN-KBNCD-MAX
               MOVE    SPA-GMN-KBNCDLST (IDX)
                                       TO  W01-KBNCD-ITEM (IDX)
           END-PERFORM    
           MOVE    SPA-GMN-KBNCD-MAX   TO  W01-KBNCD-COUNT
           MOVE    SPA-GMN-MIDASI      TO  W01-MIDASI
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
      *    入力項目名
           IF      SPA-GMN-CUR         =   ZERO
               EVALUATE    WRK-MCP-WIDGET
                   WHEN    "STYUKYMD"
                       MOVE    4               TO  SPA-GMN-CUR
                   WHEN    "EDYUKYMD"
                       MOVE    12              TO  SPA-GMN-CUR
                   WHEN    OTHER
                       MOVE    1               TO  SPA-GMN-CUR
               END-EVALUATE
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
                WHEN   1
                    MOVE  "KANRICD"    TO  MCP-WIDGET
                WHEN   2
                    MOVE  "SELNUM"     TO  MCP-WIDGET
                WHEN   3
                    MOVE  "STYUKYMD"   TO  MCP-WIDGET
                WHEN   4
                    MOVE  "EDYUKYMD"   TO  MCP-WIDGET
                WHEN   5
                    MOVE  "KBNCD"      TO  MCP-WIDGET
                WHEN   12
                    MOVE  "B12"        TO  MCP-WIDGET
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
                   MOVE    "選択番号が有りません"     TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "入力エラー"               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "エラーがある項目があります"
                                                      TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "有効期間が重複します"     TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "管理コードがちがいます"   TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "区分コードの長さがちがいます" 
                                                      TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "数字で入力して下さい"     TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "区分コードは２桁です。"   TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "１桁目は１から２を入力して下さい"
                                                      TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "２桁目は１から５を入力して下さい"
                                                      TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "職員コードは５桁で入力して下さい"
                                                      TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "１桁目は１から５を入力して下さい"
                                                      TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE    "レセプト種別は４桁で入力して下さい"
                                                      TO  SPA-ERRMSG
               WHEN    "0014"
                   MOVE    "レセプト情報は３桁で入力して下さい"
                                                      TO  SPA-ERRMSG
               WHEN    "0020"
                   MOVE    "有効開始日＜有効終了日で入力して下さい"
                                                      TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W01"                TO  SPA-MOTOPG
           MOVE    "WERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WERR"               TO  MCP-WINDOW
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
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-READ-EXT.
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

