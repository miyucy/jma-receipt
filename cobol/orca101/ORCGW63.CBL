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
       PROGRAM-ID.                     ORCGW63.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : データチェック機能情報３
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/04/01    NACL−森脇    新規作成
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
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
      *    コンスタント値
           COPY    "ENUM-VALUE".
      *
      *    画面用ＳＰＡ
       01  SPA-W63.
           03  SPA-GMN-AREA.
               05  SPA-GMN-CUR         PIC 9(03).
               05  SPA-GMN-GMN-AREA.
                   07  SPA-GMN-CLIST-AREA.
                       09  SPA-GMN-CLIST-MAX       PIC 9(03).
                       09  SPA-GMN-CHECKLIST       OCCURS  200.
                           11  SPA-GMN-TNUM        PIC 9(3).
                           11  SPA-GMN-THKNJANUM   PIC X(08).
                           11  SPA-GMN-TJYKNKBN    PIC X(04).
                           11  SPA-GMN-THKNJANAME  PIC X(60).
                           11  SPA-GMN-THKNNUM     PIC X(20).
                           11  SPA-GMN-TKIGOCHK    PIC X(10).
                           11  SPA-GMN-TSTYUKYMD   PIC X(09).
                           11  SPA-GMN-TEDYUKYMD   PIC X(09).
                   07  SPA-GMN-SELNUM              PIC 9(03).
                   07  SPA-GMN-INPUT-AREA.
                       09  SPA-GMN-HKNJANUM        PIC X(10).
                       09  SPA-GMN-HKNJANAME       PIC X(100).
                       09  SPA-GMN-JYKNKBN-G.
                           11  SPA-GMN-JYKNKBN     PIC X(01).
                           11  FILLER              PIC X(01).
                           11  SPA-GMN-JYKNKBNMEI  PIC X(14).
                       09  SPA-GMN-HKNNUM-G.
                           11  SPA-GMN-HKNNUM      PIC X(03).
                           11  FILLER              PIC X(01).
                           11  SPA-GMN-HKNNUMMEI   PIC X(16).
                       09  SPA-GMN-KIGO-G.
                           11  SPA-GMN-KIGO        PIC X(01).
                           11  FILLER              PIC X(01).
                           11  SPA-GMN-KIGOMEI     PIC X(14).
                       09  SPA-GMN-STYUKYMD        PIC X(09).
                       09  SPA-GMN-EDYUKYMD        PIC X(09).
      *
               05  SPA-GMN-CMB-AREA.
                   07  SPA-GMN-JYKNKBNLST-G.
                       09  SPA-GMN-JYKNKBN-MAX     PIC 9(03).
                       09  SPA-GMN-JYKNKBNLST      OCCURS  5.
                           11  SPA-GMN-JYKNKBNL    PIC X(01).
                           11  FILLER              PIC X(01).
                           11  SPA-GMN-JYKNKBNMEIL PIC X(14).
                   07  SPA-GMN-HKNNUMLST-G.
                       09  SPA-GMN-HKNNUM-MAX      PIC 9(03).
                       09  SPA-GMN-HKNNUMLST       OCCURS  50.
                           11  SPA-GMN-HKNNUML     PIC X(03).
                           11  FILLER              PIC X(01).
                           11  SPA-GMN-HKNNUMMEIL  PIC X(16).
                   07  SPA-GMN-KIGOLST-G.
                       09  SPA-GMN-KIGO-MAX        PIC 9(03).
                       09  SPA-GMN-KIGOLST         OCCURS  5.
                           11  SPA-GMN-KIGOL       PIC X(01).
                           11  FILLER              PIC X(01).
                           11  SPA-GMN-KIGOMEIL    PIC X(14).
      *
               05  SPA-NAI-AREA.
                   07  SPA-NAI-CLIST-AREA.
                       09  SPA-NAI-CLIST           OCCURS  200.
                           11  SPA-NAI-TJYKNKBN    PIC X(01).
                           11  SPA-NAI-THKNNUM     PIC X(03).
                           11  SPA-NAI-TKIGO       PIC X(01).
                           11  SPA-NAI-TSTYUKYMD   PIC X(08).
                           11  SPA-NAI-TEDYUKYMD   PIC X(08).
                           11  SPA-NAI-TKBNCD      PIC X(08).
                   07  SPA-NAI-INPUT-AREA.
                       09  SPA-NAI-STYUKYMD        PIC X(08).
                       09  SPA-NAI-EDYUKYMD        PIC X(08).
                       09  SPA-NAI-HKNJANUMLEN     PIC 9(05).
      *
               05  SPA-MOT-AREA.
                   07  SPA-MOT-KBNCD           PIC X(08).
                   07  SPA-MOT-STYUKYMD        PIC X(08).
                   07  SPA-MOT-EDYUKYMD        PIC X(08).
                   07  SPA-MOT-HKNJANUM        PIC X(03).
                   07  SPA-MOT-JYKNKBN         PIC X(01).
                   07  SPA-MOT-HKNNUM          PIC X(03).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-CHK004          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
           03  FLG-DABURI          PIC 9(01).
           03  FLG-SKIP            PIC 9(01).
           03  FLG-CLIST-ROW       PIC 9(01).
           03  FLG-HIZUKE          PIC 9(01).
           03  FLG-KANACHK         PIC S9(9)   BINARY.
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                PIC 9(05).
           03  IDX-CMB             PIC 9(05).
           03  IDX-LST             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-WIDMSG          PIC X(70).
      *
           03  WRK-YMD             PIC X(10).
           03  WRK-SYMD            PIC X(08).
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-STYUKYMD        PIC X(08).
           03  WRK-EDYUKYMD        PIC X(08).
      *
           03  WRK-UPDKBN          PIC X(03).
           03  WRK-MCP-WIDGET      PIC X(64).
           03  WRK-CMB-CD          PIC X(10).
           03  WRK-CMB-ITM-G.
               05  WRK-CMB-ITM     PIC X(200).
           03  WRK-HKNJANUM        PIC X(08).
           03  WRK-KANACHK-DATA    PIC X(1000).
           03  WRK-KANACHK-MAXLEN  PIC 9(05).
           03  WRK-KBNCD-G.
               05  WRK-KBNCD       PIC 9(06).
               05  WRK-KBNCDFL     PIC X(02).
           03  WRK-ZZ9             PIC ZZ9.
      *
       01  WRK-ROW.
           05  WRK-CLIST-ROW       PIC S9(9)   BINARY.
      *
       01  CONST-AREA.
           03  CONST-CLIST-MAX     PIC 9(05)   VALUE   200.
           03  CONST-INSERT        PIC X(03)   VALUE   "INS".
           03  CONST-UPDATE        PIC X(03)   VALUE   "UPD".
           03  CONST-DELETE        PIC X(03)   VALUE   "DEL".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    チェック排除情報
           COPY  "CPSK1040.INC".
      *
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    保険者情報
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
      *
      *    チェックマスタ４
           COPY    "CPCHK004.INC".
      *
           COPY    "CPCK1102.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    文字妥当性チェック
           COPY    "CPORCXKANACONV.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
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
           COPY    "W08.INC".
           COPY    "W09.INC".
           COPY    "W10.INC".
           COPY    "W11.INC".
           COPY    "W111.INC".
           COPY    "W12.INC".
           COPY    "W121.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W16.INC".
           COPY    "W17.INC".
           COPY    "W18.INC".
           COPY    "W19.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W28.INC".
           COPY    "W29.INC".
           COPY    "W30.INC".
           COPY    "W31.INC".
           COPY    "W60.INC".
           COPY    "W61.INC".
           COPY    "W62.INC".
           COPY    "W63.INC".
           COPY    "W98.INC".
           COPY    "W981.INC".
           COPY    "W97.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
           COPY    "WID2.INC".
      *
       PROCEDURE               DIVISION    USING
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
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W63
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS  ALSO    MCP-EVENT
           WHEN    "LINK"      ALSO    ANY
               PERFORM 100-INIT-SEC
      *    画面遷移
           WHEN    "PUTG"      ALSO    "CLICKED"
               PERFORM 200-GMNSENI
      *    入力
           WHEN    OTHER
               PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF    ( FLG-END             =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-W63         TO  SPA-FREE
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK 
           MOVE    SPA-AREA        TO  SPA-COMMON
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面より
           IF    ( SPA-MOTOPG          =   "WERR" )
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF    ( FLG-END             =   1 )
                   GO  TO  100-INIT-EXT
               END-IF 
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF    ( SPA-ERRCD       NOT =   SPACE )
      *            エラーメッセージ表示処理
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  LINKAREA
      *
           MOVE    SPACE           TO  MCP-PUTTYPE
           MOVE    "W63    "       TO  MCP-WINDOW
      *
      *    ＰＵＴ　処理
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
           .
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
               MOVE    LNK-KYOUTU      TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "WID1"
      *        確認画面ＯＫ処理
               PERFORM 330-WID1-SET-SEC
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
      *    確認画面（ＷＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF    ( SPA-WID1-FLG    =   "OK" )
               EVALUATE    SPA-WIDCD
               WHEN "3001"
      *            削除処理
                   PERFORM 481-SAKUJO-SEC
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD
      *
           .
       330-WID1-SET-EXT.
           EXIT.
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE                  SPA-W63
      *
           PERFORM 420-CLEAR-SEC
      *
      *    チェック排除情報リスト編集処理
           PERFORM 3101-CLIST-SET-SEC
           MOVE    1               TO  FLG-CLIST-ROW
      *
      *    カーソル位置をセット
           IF    ( SPA-GMN-CLIST-MAX   >   ZERO )
               MOVE    001             TO  SPA-GMN-CUR
           ELSE
               MOVE    002             TO  SPA-GMN-CUR
           END-IF
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    コンボ設定処理
      *****************************************************************
       3101-COMBO-SET-SEC          SECTION.
      *
           PERFORM 31011-JYKNKBNLST-SET-SEC
      *
           PERFORM 31011-HKNNUMLST-SET-SEC
      *
           PERFORM 31011-KIGOLST-SET-SEC
      *
           .
       3101-COMBO-SET-EXT.
           EXIT.
      *****************************************************************
      *    一致条件コンボ設定処理
      *****************************************************************
       31011-JYKNKBNLST-SET-SEC        SECTION.
      *
           INITIALIZE              SPA-GMN-JYKNKBNLST-G
      *
           MOVE    "0"             TO  SPA-GMN-JYKNKBNL(1)
           MOVE    "1"             TO  SPA-GMN-JYKNKBNL(2)
           MOVE    "2"             TO  SPA-GMN-JYKNKBNL(3)
           MOVE    "完全一致"      TO  SPA-GMN-JYKNKBNMEIL(1)
           MOVE    "前方一致"      TO  SPA-GMN-JYKNKBNMEIL(2)
           MOVE    "指定なし"      TO  SPA-GMN-JYKNKBNMEIL(3)
      *
           MOVE    3               TO  SPA-GMN-JYKNKBN-MAX
      *
           .
       31011-JYKNKBNLST-SET-EXT.
           EXIT.
      *****************************************************************
      *    一致条件コンボ設定処理
      *****************************************************************
       31011-HKNNUMLST-SET-SEC         SECTION.
      *
           INITIALIZE              SPA-GMN-HKNNUMLST-G
      *
           PERFORM 900-HKNNUM-KEY3-SEL-SEC
      *
           PERFORM UNTIL ( FLG-HKNNUM  NOT =   ZERO )
                    OR   ( SPA-GMN-HKNNUM-MAX
                                          >=   50   )
               IF    ( HKN-HKNKOHSBTKBN    =   "1" OR  "4"
                                           OR  "8" OR  "9" )
                   MOVE    SPA-GMN-HKNNUM-MAX
                                           TO  IDX-CMB
      *            保険
                   IF    ( IDX-CMB         >   ZERO )
                       IF    ( HKN-HKNNUM  NOT =   SPA-GMN-HKNNUML
                                                             (IDX-CMB))
      *                    保険情報編集
                           PERFORM 310111-HKNNUM-SET-SEC
                       END-IF
                   ELSE
      *                保険情報編集
                       PERFORM 310111-HKNNUM-SET-SEC
                   END-IF
               END-IF
      *
               PERFORM 900-HKNNUM-KEY3-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_hknnum"            TO  MCP-TABLE
           MOVE    "key3"                  TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       31011-HKNNUMLST-SET-EXT.
           EXIT.
      *****************************************************************
      *    保険の種類設定処理
      *****************************************************************
       310111-HKNNUM-SET-SEC           SECTION.
      *
           COMPUTE SPA-GMN-HKNNUM-MAX  =   SPA-GMN-HKNNUM-MAX  +   1
      *
           MOVE    SPA-GMN-HKNNUM-MAX  TO  IDX-CMB
      *
           MOVE    HKN-HKNNUM          TO  SPA-GMN-HKNNUML   (IDX-CMB)
           MOVE    HKN-TANSEIDONAME    TO  SPA-GMN-HKNNUMMEIL(IDX-CMB)
      *
           .
       310111-HKNNUM-SET-EXT.
           EXIT.
      *****************************************************************
      *    記号コンボ設定処理
      *****************************************************************
       31011-KIGOLST-SET-SEC       SECTION.
      *
           INITIALIZE              SPA-GMN-KIGOLST-G
      *
           MOVE    "0"             TO  SPA-GMN-KIGOL(1)
           MOVE    "1"             TO  SPA-GMN-KIGOL(2)
           MOVE    "チェックする"  TO  SPA-GMN-KIGOMEIL(1)
           MOVE    "チェックしない"
                                   TO  SPA-GMN-KIGOMEIL(2)
      *
           MOVE    2               TO  SPA-GMN-KIGO-MAX
      *
           .
       31011-KIGOLST-SET-EXT.
           EXIT.
      *****************************************************************
      *    チェック排除情報リスト編集処理
      *****************************************************************
       3101-CLIST-SET-SEC          SECTION.
      *
           INITIALIZE                  SPA-GMN-CLIST-AREA
                                       SPA-NAI-CLIST-AREA
      *
           INITIALIZE                  CK4-1102-REC
           MOVE    "1102"          TO  CK4-1102-KANRICD
           MOVE    CK4-1102-REC    TO  CHK004-REC
           PERFORM 900-CHK004-KEY3-SEL-SEC
           MOVE    CHK004-REC       TO  CK4-1102-REC
      *
           MOVE    ZERO            TO  SPA-GMN-CLIST-MAX
           PERFORM UNTIL ( FLG-CHK004       =   1  )
                   OR    ( IDX-LST        >=  CONST-CLIST-MAX )
      *
               COMPUTE SPA-GMN-CLIST-MAX
                   =   SPA-GMN-CLIST-MAX   +  1
      *
               MOVE    SPA-GMN-CLIST-MAX
                                   TO  IDX-LST
      *
               MOVE    IDX-LST     TO  SPA-GMN-TNUM(IDX-LST)
      *
               MOVE    CK4-1102-HKNJANUM
                                   TO  SPA-GMN-THKNJANUM(IDX-LST)
               EVALUATE    CK4-1102-JYKNKBN
               WHEN    "0"
                   MOVE    "完全"      TO  SPA-GMN-TJYKNKBN(IDX-LST)
               WHEN    "1"
                   MOVE    "前方"      TO  SPA-GMN-TJYKNKBN(IDX-LST)
               WHEN    "2"
                   MOVE    "　　"      TO  SPA-GMN-TJYKNKBN(IDX-LST)
               END-EVALUATE
               MOVE    CK4-1102-JYKNKBN
                                   TO  SPA-NAI-TJYKNKBN(IDX-LST)
      *
               IF    ( CK4-1102-JYKNKBN    =   "0" )
                   MOVE    CK4-1102-HKNJANUM
                                   TO  WRK-HKNJANUM
                   PERFORM 900-HKNJAINF-KEY-SEL-SEC
                   MOVE    HKNJA-HKNJANAME
                                   TO  SPA-GMN-THKNJANAME(IDX-LST)
               END-IF
      *
               PERFORM 900-HKNNUM-KEY-SEL-SEC
               MOVE    HKN-TANSEIDONAME
                                   TO  SPA-GMN-THKNNUM   (IDX-LST)
               MOVE    CK4-1102-HKNNUM
                                   TO  SPA-NAI-THKNNUM   (IDX-LST)
      *
               IF    ( CK4-1102-KIGOCHK    =   "0" )
                   MOVE    "　○"    TO  SPA-GMN-TKIGOCHK  (IDX-LST)
               ELSE
                   MOVE    "　−"    TO  SPA-GMN-TKIGOCHK  (IDX-LST)
               END-IF
               MOVE    CK4-1102-KIGOCHK
                                   TO  SPA-NAI-TKIGO     (IDX-LST)
      *
               MOVE    CK4-1102-STYUKYMD   TO  WRK-YMD
               PERFORM 800-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-TSTYUKYMD(IDX-LST)
               MOVE    WRK-SYMD        TO  SPA-NAI-TSTYUKYMD(IDX-LST)
      *
               MOVE    CK4-1102-EDYUKYMD   TO  WRK-YMD
               PERFORM 800-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-TEDYUKYMD(IDX-LST)
               MOVE    WRK-SYMD        TO  SPA-NAI-TEDYUKYMD(IDX-LST)
      *
               MOVE    CK4-1102-KBNCD  TO  SPA-NAI-TKBNCD   (IDX-LST)
      *
               PERFORM 900-CHK004-KEY3-FET-SEC
               MOVE    CHK004-REC       TO  CK4-1102-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-CLIST-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                 SECTION.
      *
           MOVE    MCP-WIDGET      TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
           WHEN    "CLICKED"       ALSO    "B01"
               PERFORM 210-BACK
           WHEN    "CLICKED"       ALSO    "B02"
               PERFORM 420-CLEAR-SEC
           WHEN    "CLICKED"       ALSO    "B06"
               PERFORM 480-TUIKA-SEC
           WHEN    "CLICKED"       ALSO    "B07"
               PERFORM 480-HENKOU-SEC
           WHEN    "CLICKED"       ALSO    "B08"
               PERFORM 480-SAKUJO-SEC
           END-EVALUATE
           .
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           MOVE    MCP-WIDGET      TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
           WHEN    "ACTIVATE"  ALSO    "SELNUM"
               PERFORM 4100-SELNUM-CHK-SEC
           WHEN    ANY         ALSO    "CHECKLIST"
               PERFORM 4100-CLIST-SET-SEC
           WHEN    OTHER
               MOVE    ZERO        TO  SPA-GMN-CUR
               PERFORM 4101-INPUT-SET-SEC
           END-EVALUATE
      *
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号編集処理
      *****************************************************************
       4100-SELNUM-CHK-SEC         SECTION.
      *
           MOVE    W63-SELNUM      TO  SPA-GMN-SELNUM
      *
           IF    ( SPA-GMN-SELNUM      =   ZERO )
               PERFORM 420-CLEAR-SEC
           ELSE
               PERFORM 4101-SELNUM-CHK-SEC
               IF    ( SPA-ERRCD       =  SPACE )
                   MOVE    SPA-GMN-SELNUM  TO  IDX-LST
                   PERFORM 420-INPUT-LIST-SET-SEC
               END-IF
           END-IF
      *
           MOVE    ZERO            TO  SPA-GMN-CUR
      *
           .
      *
       4100-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェックリスト編集処理
      *****************************************************************
       4100-CLIST-SET-SEC          SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-SELNUM
      *
           PERFORM VARYING IDX-LST FROM    1   BY  1
                   UNTIL ( IDX-LST     >       SPA-GMN-CLIST-MAX )
                    OR   ( SPA-GMN-SELNUM    NOT   =   ZERO )
      *
               IF    ( W63-CHECKLIST-SELECT(IDX-LST)   =   "T" )
                   PERFORM 420-INPUT-LIST-SET-SEC
                   MOVE    IDX-LST         TO  SPA-GMN-SELNUM
               END-IF
           END-PERFORM
      *
           .
      *
       4100-CLIST-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    リストの内容をセット処理
      *****************************************************************
       420-INPUT-LIST-SET-SEC      SECTION.
      *
           INITIALIZE                  SPA-GMN-INPUT-AREA
                                       SPA-NAI-INPUT-AREA
                                       SPA-MOT-AREA
      *
           INITIALIZE                  CK4-1102-REC
           MOVE    "1102"          TO  CK4-1102-KANRICD
           MOVE    SPA-NAI-TKBNCD   (IDX-LST)
                                   TO  CK4-1102-KBNCD
           MOVE    SPA-NAI-TSTYUKYMD(IDX-LST)
                                   TO  CK4-1102-STYUKYMD
                                       CK4-1102-EDYUKYMD
           MOVE    CK4-1102-REC    TO  CHK004-REC
           PERFORM 900-CHK004-KEY-SEL-SEC
           MOVE    CHK004-REC       TO  CK4-1102-REC
      *
           MOVE    CK4-1102-STYUKYMD
                                   TO  WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-STYUKYMD
           MOVE    WRK-SYMD        TO  SPA-NAI-STYUKYMD
      *
           MOVE    CK4-1102-EDYUKYMD
                                   TO  WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-EDYUKYMD
           MOVE    WRK-SYMD        TO  SPA-NAI-EDYUKYMD
      *
           PERFORM 31011-HKNNUMLST-SET-SEC
      *
           MOVE    CK4-1102-HKNJANUM
                                   TO  SPA-GMN-HKNJANUM
           MOVE    CK4-1102-JYKNKBN
                                   TO  WRK-CMB-CD
           PERFORM 4200-JYKNKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-JYKNKBN-G
      *
           IF    ( SPA-GMN-JYKNKBN =   "0" )
               MOVE    SPA-GMN-HKNJANUM
                                   TO  WRK-HKNJANUM
               PERFORM 900-HKNJAINF-KEY-SEL-SEC
               MOVE    HKNJA-HKNJANAME
                                   TO  SPA-GMN-HKNJANAME
           END-IF
      *
           MOVE    CK4-1102-HKNNUM TO  WRK-CMB-CD
           PERFORM 4200-HKNNUMLST-CHK-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-HKNNUM-G
      *
           MOVE    CK4-1102-KIGOCHK    TO  WRK-CMB-CD
           PERFORM 4200-KIGOLST-CHK-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-KIGO-G
      *
           MOVE    CK4-1102-KBNCD  TO  SPA-MOT-KBNCD
           MOVE    CK4-1102-STYUKYMD
                                   TO  SPA-MOT-STYUKYMD
           MOVE    CK4-1102-EDYUKYMD
                                   TO  SPA-MOT-EDYUKYMD
      *
           MOVE    CK4-1102-HKNJANUM
                                   TO  SPA-MOT-HKNJANUM
           MOVE    CK4-1102-JYKNKBN
                                   TO  SPA-MOT-JYKNKBN
           MOVE    CK4-1102-HKNNUM
                                   TO  SPA-MOT-HKNNUM
      *
           .
       420-INPUT-LIST-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       4101-INPUT-SET-SEC          SECTION.
      *
           MOVE    W63-STYUKYMD    TO  SPA-GMN-STYUKYMD
           MOVE    W63-EDYUKYMD    TO  SPA-GMN-EDYUKYMD
           MOVE    W63-HKNJANUM    TO  SPA-GMN-HKNJANUM
           MOVE    W63-JYKNKBN     TO  SPA-GMN-JYKNKBN-G
           MOVE    W63-HKNNUM      TO  SPA-GMN-HKNNUM-G
           MOVE    W63-KIGO        TO  SPA-GMN-KIGO-G
      *
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
      *
           .
       4101-INPUT-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC          SECTION.
      *
      *    選択番号チェック
           PERFORM 4101-SELNUM-CHK-SEC
      *
      *    有効期間開始日チェック
           IF    ( SPA-ERRCD   =   SPACE )
               PERFORM 4101-STYUKYMD-CHK-SEC
           END-IF
      *
      *    有効期間終了日チェック
           IF    ( SPA-ERRCD   =   SPACE )
               PERFORM 4101-EDYUKYMD-CHK-SEC
           END-IF
      *
      *    一致条件チェック
           IF    ( SPA-ERRCD   =   SPACE )
               PERFORM 4101-JYKNKBN-CHK-SEC
           END-IF
      *
      *    保険者番号チェック
           IF    ( SPA-ERRCD   =   SPACE )
               PERFORM 4101-HKNJANUM-CHK-SEC
           END-IF
      *
      *    保険の種類チェック
           IF    ( SPA-ERRCD   =   SPACE )
               PERFORM 4101-HKNNUM-CHK-SEC
           END-IF
      *
      *    記号チェック
           IF    ( SPA-ERRCD   =   SPACE )
               PERFORM 4101-KIGO-CHK-SEC
           END-IF
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号チェック処理
      *****************************************************************
       4101-SELNUM-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-SELNUM      =   ZERO )
               CONTINUE
           ELSE
               IF    ( SPA-GMN-SELNUM  >   SPA-GMN-CLIST-MAX )
                   MOVE    "0001"      TO  SPA-ERRCD
                   MOVE    001         TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
      *
           .
      *
       4101-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    有効開始日チェック処理
      *****************************************************************
       4101-STYUKYMD-CHK-SEC      SECTION.
      *
      *    空白ならばALL"0"をセットする
           IF    ( SPA-GMN-STYUKYMD       =   SPACE )
            OR   ( SPA-GMN-STYUKYMD (1:3) =  "000" )
               MOVE    "00000000"      TO  SPA-GMN-STYUKYMD
                                           SPA-NAI-STYUKYMD
           END-IF
      *
           MOVE    SPA-NAI-STYUKYMD    TO  WRK-STYUKYMD
      *
           MOVE    SPACE               TO  SPA-NAI-STYUKYMD
      *
           MOVE    SPA-GMN-STYUKYMD    TO  WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           IF    ( FLG-HIZUKE          =   ZERO )
               MOVE    WRK-HENYMDG     TO  SPA-GMN-STYUKYMD
               MOVE    WRK-SYMD        TO  SPA-NAI-STYUKYMD
      *
               IF    ( WRK-MCP-WIDGET  =   "STYUKYMD" )
      *            保険の種類コンボの内容を再セット
                   PERFORM 31011-HKNNUMLST-SET-SEC
               END-IF
           ELSE
               MOVE    WRK-STYUKYMD    TO  WRK-YMD
               PERFORM 800-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-STYUKYMD
               MOVE    WRK-SYMD        TO  SPA-NAI-STYUKYMD
               MOVE    "0006"          TO  SPA-ERRCD
               MOVE    006             TO  SPA-GMN-CUR
           END-IF
      *
      *
           .
      *
       4101-STYUKYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    有効終了日チェック処理
      *****************************************************************
       4101-EDYUKYMD-CHK-SEC      SECTION.
      *
           IF    ( SPA-GMN-EDYUKYMD   =   SPACE )
             OR  ( SPA-GMN-STYUKYMD (1:3) =  "999" )
               MOVE    "99999999"      TO  SPA-GMN-EDYUKYMD
                                           SPA-NAI-EDYUKYMD
           END-IF
      *
           MOVE    SPA-NAI-EDYUKYMD   TO  WRK-EDYUKYMD
      *
           MOVE    SPA-GMN-EDYUKYMD   TO  WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           IF    ( FLG-HIZUKE          =   ZERO )
               MOVE    WRK-HENYMDG     TO  SPA-GMN-EDYUKYMD
               MOVE    WRK-SYMD        TO  SPA-NAI-EDYUKYMD
           ELSE
               MOVE    WRK-EDYUKYMD    TO  WRK-YMD
               PERFORM 800-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-EDYUKYMD
               MOVE    WRK-SYMD        TO  SPA-NAI-EDYUKYMD
               MOVE    "0007"          TO  SPA-ERRCD
               MOVE    007             TO  SPA-GMN-CUR
           END-IF
      *
           .
      *
       4101-EDYUKYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    一致条件区分チェック処理
      *****************************************************************
       4101-JYKNKBN-CHK-SEC            SECTION.
      *
           MOVE    SPA-GMN-JYKNKBN     TO  WRK-CMB-CD
           PERFORM 4200-JYKNKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    "0"             TO  WRK-CMB-CD
               PERFORM 4200-JYKNKBNLST-CHK-SEC
               MOVE    WRK-CMB-ITM         TO  SPA-GMN-JYKNKBN-G
           ELSE
               MOVE    WRK-CMB-ITM         TO  SPA-GMN-JYKNKBN-G
           END-IF
      *
           IF    ( SPA-GMN-JYKNKBN     =   "2" )
               MOVE    SPACE           TO  SPA-GMN-HKNJANUM
           END-IF
      *
           .
      *
       4101-JYKNKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険者番号チェック処理
      *****************************************************************
       4101-HKNJANUM-CHK-SEC           SECTION.
      *
           MOVE    SPACE               TO  SPA-GMN-HKNJANAME
           MOVE    ZERO                TO  SPA-NAI-HKNJANUMLEN
      *
           MOVE    SPA-GMN-HKNJANUM    TO  WRK-KANACHK-DATA
           PERFORM 800-HANKAKU-CHK-SEC
           MOVE    WRK-KANACHK-DATA    TO  SPA-GMN-HKNJANUM
           IF    ( FLG-KANACHK         =   ZERO )
               MOVE    WRK-KANACHK-MAXLEN
                                       TO  SPA-NAI-HKNJANUMLEN
               IF    ( SPA-GMN-JYKNKBN     =   "0" )
                   MOVE    SPA-GMN-HKNJANUM
                                   TO  WRK-HKNJANUM
                   PERFORM 900-HKNJAINF-KEY-SEL-SEC
                   MOVE    HKNJA-HKNJANAME
                                   TO  SPA-GMN-HKNJANAME
                   MOVE    HKNJA-HKNNUM
                                   TO  WRK-CMB-CD
                   PERFORM 4200-HKNNUMLST-CHK-SEC
                   IF    ( WRK-CMB-CD  NOT =   SPACE )
                       MOVE    WRK-CMB-ITM
                                   TO  SPA-GMN-HKNNUM-G
                   END-IF
               END-IF
           ELSE
                   MOVE    "0002"      TO  SPA-ERRCD
                   MOVE    002         TO  SPA-GMN-CUR
           END-IF
      *
           .
      *
       4101-HKNJANUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険の種類チェック処理
      *****************************************************************
       4101-HKNNUM-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-HKNNUM-G   =    SPACE )
               CONTINUE
           ELSE
               MOVE    SPA-GMN-HKNNUM     TO  WRK-CMB-CD
               PERFORM 4200-HKNNUMLST-CHK-SEC
               IF    ( WRK-CMB-ITM    =   SPACE )
                   MOVE    "0004"         TO  SPA-ERRCD
                   MOVE    4              TO  SPA-GMN-CUR
               ELSE
                   MOVE    WRK-CMB-ITM    TO  SPA-GMN-HKNNUM-G
               END-IF
           END-IF
      *
           .
      *
       4101-HKNNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    記号チェック処理
      *****************************************************************
       4101-KIGO-CHK-SEC               SECTION.
      *
           MOVE    SPA-GMN-KIGO        TO  WRK-CMB-CD
           PERFORM 4200-KIGOLST-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    "0"             TO  WRK-CMB-CD
               PERFORM 4200-KIGOLST-CHK-SEC
               MOVE    WRK-CMB-ITM         TO  SPA-GMN-KIGO-G
           ELSE
               MOVE    WRK-CMB-ITM         TO  SPA-GMN-KIGO-G
           END-IF
      *
           .
      *
       4101-KIGO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "W01"           TO  SPA-SAKIPG
           MOVE    "W63"           TO  SPA-MOTOPG
      *
           MOVE    "CHANGE"        TO  MCP-PUTTYPE
           MOVE    "W01"           TO  MCP-WINDOW
      *
      *    ＰＵＴ　処理
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    条件クリア処理
      *****************************************************************
       420-CLEAR-SEC                   SECTION.
      *
           INITIALIZE                  SPA-GMN-SELNUM
                                       SPA-GMN-INPUT-AREA
                                       SPA-NAI-INPUT-AREA
                                       SPA-MOT-AREA
      *
      *    有効開始日
           MOVE    SPA-SYSYMD      TO  WRK-YMD
           MOVE    "01"            TO  WRK-YMD (7:2)
           PERFORM 800-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-STYUKYMD
           MOVE    WRK-SYMD        TO  SPA-NAI-STYUKYMD
      *
      *    有効終了日
           MOVE    "99999999"      TO  SPA-GMN-EDYUKYMD
                                       SPA-NAI-EDYUKYMD
      *
      *    コンボ項目設定処理
           PERFORM 3101-COMBO-SET-SEC
      *
           MOVE    SPA-GMN-JYKNKBNLST(1)
                                   TO  SPA-GMN-JYKNKBN-G
      *
           MOVE    SPA-GMN-KIGOLST(1)
                                   TO  SPA-GMN-KIGO-G
      *
      *    カーソル位置セット
           IF    ( SPA-GMN-CLIST-MAX   >   ZERO )
               MOVE    001         TO  SPA-GMN-CUR
           ELSE
               MOVE    002         TO  SPA-GMN-CUR
           END-IF
      *
           .
       420-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    追加処理
      *****************************************************************
       480-TUIKA-SEC               SECTION.
      *
      *    入力時チェック
           PERFORM 4101-INPUT-SET-SEC
      *
           MOVE    CONST-INSERT    TO  WRK-UPDKBN
      *
      *    関連チェック
           IF    ( SPA-ERRCD       =   SPACE )
               PERFORM 4900-KANRENCHK-SEC
           END-IF
      *
      *    履歴チェック
           IF    ( SPA-ERRCD       =   SPACE )
               PERFORM 4901-RIREKI-CHK-SEC
           END-IF
      *
      *    チェック排除情報セット処理
           IF    ( SPA-ERRCD       =   SPACE )
               PERFORM 4701-KOUMOKU-SET-SEC
           END-IF
      *
      *    チェック排除情報マスタ追加
           IF    ( SPA-ERRCD       =   SPACE )
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD    TO  CK4-1102-CREYMD
                                           CK4-1102-UPYMD
               MOVE    SMCNDATE-HMS    TO  CK4-1102-UPHMS
               MOVE    CK4-1102-REC    TO  MCPDATA-REC
               MOVE    "tbl_chk004"    TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM 910-DBINSERT-SEC
               IF    ( MCP-RC              =   ZERO )
      *
                   PERFORM 3101-CLIST-SET-SEC
                   MOVE    2           TO  FLG-CLIST-ROW
      *
                   PERFORM 420-CLEAR-SEC
      *
                   IF    ( SPA-GMN-CLIST-MAX   >=  CONST-CLIST-MAX )
                       MOVE    "1005"  TO  SPA-ERRCD
                   END-IF
               ELSE
      *            追加失敗エラー
                   MOVE   "4001"           TO  SPA-ERRCD
                   MOVE    002             TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
       480-TUIKA-EXT.
           EXIT.
      *****************************************************************
      *    チェック排除情報セット処理
      *****************************************************************
       4701-KOUMOKU-SET-SEC        SECTION.
      *
           IF    ( WRK-UPDKBN      =   CONST-UPDATE )
               INITIALIZE                  CK4-1102-REC
               MOVE    "1102"          TO  CK4-1102-KANRICD
               MOVE    SPA-MOT-KBNCD   TO  CK4-1102-KBNCD
               MOVE    SPA-MOT-STYUKYMD
                                       TO  CK4-1102-STYUKYMD
                                           CK4-1102-EDYUKYMD
               MOVE    CK4-1102-REC    TO  CHK004-REC
               PERFORM 900-CHK004-KEY-SEL-SEC
               MOVE    CHK004-REC       TO  CK4-1102-REC
           ELSE
               INITIALIZE                  CK4-1102-REC
               MOVE    "1102"          TO  CK4-1102-KANRICD
               IF    ( WRK-KBNCD-G =   LOW-VALUE )
                   MOVE    1           TO  WRK-KBNCD
               ELSE
                   COMPUTE WRK-KBNCD   =   WRK-KBNCD   +   1
               END-IF
               MOVE    WRK-KBNCD-G     TO  CK4-1102-KBNCD
      *
           END-IF
      *
           MOVE    SPA-NAI-STYUKYMD    TO  CK4-1102-STYUKYMD
           MOVE    SPA-NAI-EDYUKYMD    TO  CK4-1102-EDYUKYMD
           MOVE    SPA-GMN-HKNJANUM    TO  CK4-1102-HKNJANUM
           MOVE    SPA-NAI-HKNJANUMLEN TO  CK4-1102-HKNJANUMLEN
           MOVE    SPA-GMN-JYKNKBN     TO  CK4-1102-JYKNKBN
           MOVE    SPA-GMN-HKNNUM      TO  CK4-1102-HKNNUM
           MOVE    SPA-GMN-KIGO        TO  CK4-1102-KIGOCHK
      *
           .    
       4701-KOUMOKU-SET-EXT.
           EXIT.
      *****************************************************************
      *    変更処理
      *****************************************************************
       480-HENKOU-SEC              SECTION.
      *
      *    入力時チェック
           PERFORM 4101-INPUT-SET-SEC
      *
           MOVE    CONST-UPDATE    TO  WRK-UPDKBN
      *
      *    関連チェック
           IF    ( SPA-ERRCD       =   SPACE )
               PERFORM 4900-KANRENCHK-SEC
           END-IF
      *
      *    履歴チェック
           IF    ( SPA-ERRCD       =   SPACE )
               PERFORM 4901-RIREKI-CHK-SEC
           END-IF
      *
      *    チェック排除情報セット処理
           IF    ( SPA-ERRCD       =   SPACE )
               PERFORM 4701-KOUMOKU-SET-SEC
           END-IF
      *
      *    更新用キーをセット
           IF    ( SPA-ERRCD       =   SPACE )
               PERFORM 800-MCNDATE-SEC
               MOVE    SMCNDATE-YMD        TO  CK4-1102-UPYMD
               MOVE    SMCNDATE-HMS        TO  CK4-1102-UPHMS
               MOVE    CK4-1102-REC        TO  CHK004-REC
               MOVE    "1102"              TO  CHK004-UPKANRICD
               MOVE    SPA-MOT-KBNCD       TO  CHK004-UPKBNCD
               MOVE    SPA-MOT-STYUKYMD    TO  CHK004-UPSTYUKYMD
               MOVE    SPA-MOT-EDYUKYMD    TO  CHK004-UPEDYUKYMD
      *
               MOVE    CHK004-REC           TO  MCPDATA-REC
               MOVE    "tbl_chk004"        TO  MCP-TABLE
               MOVE    "upd1"              TO  MCP-PATHNAME
               PERFORM 910-DBUPDATE-SEC
               IF    ( MCP-RC          =   ZERO )
      *
      *            チェック排除情報リスト編集処理
                   PERFORM 3101-CLIST-SET-SEC
      *
      *            入力項目を初期化する
                   PERFORM 420-CLEAR-SEC
               ELSE
      *            更新失敗エラー
                   MOVE   "4002"           TO  SPA-ERRCD
                   MOVE    002             TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
       480-HENKOU-EXT.
           EXIT.
      *****************************************************************
      *    削除確認処理
      *****************************************************************
       480-SAKUJO-SEC              SECTION.
      *
           MOVE    CONST-DELETE    TO  WRK-UPDKBN
      *
      *    入力項目の関連チェック処理
           PERFORM 4900-KANRENCHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  480-SAKUJO-EXT
           END-IF
      *
      *    削除するか確認する
           MOVE    "3001"          TO  SPA-WIDCD
      *
           .
       480-SAKUJO-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       481-SAKUJO-SEC                  SECTION.
      *
           INITIALIZE                      CK4-1102-REC
           MOVE    "1102"              TO  CK4-1102-KANRICD
           MOVE    SPA-MOT-KBNCD       TO  CK4-1102-KBNCD
           MOVE    SPA-MOT-STYUKYMD    TO  CK4-1102-STYUKYMD
           MOVE    SPA-MOT-EDYUKYMD    TO  CK4-1102-EDYUKYMD
           MOVE    CK4-1102-REC        TO  MCPDATA-REC
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC              =   ZERO )
      *        チェック排除情報リスト編集処理
               PERFORM 3101-CLIST-SET-SEC
      *        入力項目を初期化する
               PERFORM 420-CLEAR-SEC
           ELSE
      *        削除失敗エラー
               MOVE    "4003"          TO  SPA-ERRCD
               MOVE    002             TO  SPA-GMN-CUR
           END-IF
      *
           .    
       481-SAKUJO-EXT.
           EXIT.
      *
      *****************************************************************
      *    一致条件コンボチェック処理
      *****************************************************************
       4200-JYKNKBNLST-CHK-SEC         SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-JYKNKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-JYKNKBNL (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-JYKNKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-JYKNKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険番号コンボチェック処理
      *****************************************************************
       4200-HKNNUMLST-CHK-SEC         SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-HKNNUM-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-HKNNUML (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-HKNNUMLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-HKNNUMLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    記号コンボチェック処理
      *****************************************************************
       4200-KIGOLST-CHK-SEC            SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-KIGO-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-KIGOL (IDX-CMB)
                                       =   WRK-CMB-CD )
                   MOVE    SPA-GMN-KIGOLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-KIGOLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC          SECTION.
      *
           IF    ( SPA-ERRCD           =   SPACE )
               IF  ( SPA-NAI-EDYUKYMD     <   SPA-NAI-STYUKYMD )
                   MOVE    "1002"          TO  SPA-ERRCD
                   MOVE    007             TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-ERRCD           =   SPACE )
               IF    ( SPA-GMN-SELNUM  =   ZERO )
                   IF    ( WRK-UPDKBN      =   CONST-INSERT )
                       CONTINUE
                   ELSE
                       MOVE    "1001"          TO  SPA-ERRCD
                       MOVE    001             TO  SPA-GMN-CUR
                   END-IF
               ELSE
                   IF    ( WRK-UPDKBN      =   CONST-UPDATE )
                     OR  ( WRK-UPDKBN      =   CONST-DELETE )
                       CONTINUE
                   ELSE
                       MOVE    "1003"          TO  SPA-ERRCD
                       MOVE    001             TO  SPA-GMN-CUR
                   END-IF
               END-IF
           END-IF
      *
           IF    ( SPA-ERRCD           =   SPACE )
               IF    ( SPA-GMN-JYKNKBN =   "0" )
                   IF    ( SPA-GMN-HKNJANUM    =   SPACE )
                       MOVE    "1007"          TO  SPA-ERRCD
                       MOVE    002             TO  SPA-GMN-CUR
                   ELSE
                       IF    ( SPA-GMN-HKNJANAME   =   SPACE )
                           MOVE    "1008"      TO  SPA-ERRCD
                           MOVE    002         TO  SPA-GMN-CUR
                       END-IF
                   END-IF
               END-IF
           END-IF
      *
           IF    ( SPA-ERRCD               =   SPACE )
               IF    ( SPA-GMN-HKNNUM-G    =   SPACE )
                   MOVE    "1009"      TO  SPA-ERRCD
                   MOVE    004         TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    履歴チェック処理
      *****************************************************************
       4901-RIREKI-CHK-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-DABURI
           MOVE    LOW-VALUE           TO  WRK-KBNCD-G
      *
           INITIALIZE                  CK4-1102-REC
           MOVE    "1102"          TO  CK4-1102-KANRICD
           MOVE    CK4-1102-REC    TO  CHK004-REC
           PERFORM 900-CHK004-KEY3-SEL-SEC
           MOVE    CHK004-REC       TO  CK4-1102-REC
      *
           PERFORM UNTIL ( FLG-CHK004   NOT =   ZERO )
      *
               IF    ( CK4-1102-KBNCD  >   WRK-KBNCD-G )
                   MOVE    CK4-1102-KBNCD  TO  WRK-KBNCD-G
               END-IF
      *
               IF        ( WRK-UPDKBN          =   CONST-UPDATE )
                   AND   ( SPA-MOT-KBNCD       =   CK4-1102-KBNCD )
                   AND   ( SPA-MOT-STYUKYMD    =   CK4-1102-STYUKYMD )
                   AND   ( SPA-MOT-EDYUKYMD    =   CK4-1102-EDYUKYMD )
                       CONTINUE
               ELSE
                   IF    ( SPA-GMN-HKNJANUM    =   CK4-1102-HKNJANUM )
                    AND  ( SPA-GMN-JYKNKBN     =   CK4-1102-JYKNKBN  )
                    AND  ( SPA-GMN-HKNNUM      =   CK4-1102-HKNNUM   )
                    AND  ((SPA-NAI-EDYUKYMD   >=   CK4-1102-STYUKYMD )
                     AND  (SPA-NAI-STYUKYMD   <=   CK4-1102-EDYUKYMD ))
                       MOVE     1              TO  FLG-DABURI
                   END-IF
               END-IF
      *
               PERFORM 900-CHK004-KEY3-FET-SEC
               MOVE    CHK004-REC       TO  CK4-1102-REC
      *
      *
           END-PERFORM
      *
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           IF    ( FLG-DABURI    =   1 )
               MOVE    "1004"          TO  SPA-ERRCD
               MOVE    006             TO  SPA-GMN-CUR
           END-IF
      *
           .
       4901-RIREKI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
      *    画面編集処理
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
      *        エラーメッセージ表示処理
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-WIDCD       NOT =   SPACE
      *        ガイドメッセージ表示処理
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE
           MOVE    "W63    "           TO  MCP-WINDOW
      *
      *    ＰＵＴ　処理
           PERFORM 900-PUT-WINDOW
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    W63-CHECKLIST-ROW   TO  WRK-CLIST-ROW
      *
           INITIALIZE                  W63
      *
           IF    ( SPA-GMN-CLIST-MAX   >=  CONST-CLIST-MAX )
               MOVE    WIDGET-INSENSITIVE
                                   TO  W63-B06-STATE
           ELSE
               MOVE    WIDGET-NORMAL
                                   TO  W63-B06-STATE
           END-IF
      *
           PERFORM VARYING IDX-LST     FROM    1   BY  1
                   UNTIL ( IDX-LST     >       SPA-GMN-CLIST-MAX )
      *
               MOVE    SPA-GMN-TNUM  (IDX-LST)
                                       TO  WRK-ZZ9
               MOVE    WRK-ZZ9         TO  W63-TNUM (IDX-LST)
               MOVE    SPA-GMN-THKNJANUM (IDX-LST)
                                       TO  W63-THKNJANUM (IDX-LST)
               MOVE    SPA-GMN-TJYKNKBN  (IDX-LST)
                                       TO  W63-TJYKNKBN  (IDX-LST)
               MOVE    SPA-GMN-THKNJANAME(IDX-LST)
                                       TO  W63-THKNJANAME(IDX-LST)
               MOVE    SPA-GMN-THKNNUM   (IDX-LST)
                                       TO  W63-THKNNUM   (IDX-LST)
               MOVE    SPA-GMN-TKIGOCHK  (IDX-LST)
                                       TO  W63-TKIGOCHK  (IDX-LST)
               MOVE    SPA-GMN-TSTYUKYMD (IDX-LST)
                                       TO  W63-TSTYUKYMD (IDX-LST)
               MOVE    SPA-GMN-TEDYUKYMD (IDX-LST)
                                       TO  W63-TEDYUKYMD (IDX-LST)
      *
               IF    ( IDX-LST         =   SPA-GMN-SELNUM )
                   MOVE    "T"         TO  W63-CHECKLIST-SELECT(IDX-LST)
               ELSE
                   MOVE    "F"         TO  W63-CHECKLIST-SELECT(IDX-LST)
               END-IF
           END-PERFORM
      *
           MOVE    SPA-GMN-CLIST-MAX   TO  W63-CHECKLIST-COUNT
      *
           MOVE    SPA-GMN-SELNUM      TO  W63-SELNUM
      *
           MOVE    SPA-GMN-STYUKYMD    TO  W63-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD    TO  W63-EDYUKYMD
           MOVE    SPA-GMN-HKNJANUM    TO  W63-HKNJANUM
           MOVE    SPA-GMN-HKNJANAME   TO  W63-HKNJANAME
      *
           MOVE    SPA-GMN-JYKNKBN-G   TO  W63-JYKNKBN
           MOVE    SPA-GMN-JYKNKBN-MAX TO  W63-JYKNKBN-COUNT
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-JYKNKBN-MAX )
      *
               MOVE    SPA-GMN-JYKNKBNLST (IDX-CMB)
                                       TO  W63-JYKNKBN-ITEM (IDX-CMB)
      *
           END-PERFORM
      *
           MOVE    SPA-GMN-HKNNUM-G    TO   W63-HKNNUM
           MOVE    SPA-GMN-HKNNUM-MAX  TO   W63-HKNNUM-COUNT
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >       SPA-GMN-HKNNUM-MAX )
      *
               MOVE    SPA-GMN-HKNNUMLST (IDX-CMB)
                                       TO  W63-HKNNUM-ITEM (IDX-CMB)
      *
           END-PERFORM
      *
           MOVE    SPA-GMN-KIGO-G      TO   W63-KIGO
           MOVE    SPA-GMN-KIGO-MAX    TO   W63-KIGO-COUNT
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >       SPA-GMN-KIGO-MAX )
      *
               MOVE    SPA-GMN-KIGOLST (IDX-CMB)
                                       TO  W63-KIGO-ITEM (IDX-CMB)
      *
           END-PERFORM
      *
      *  
           EVALUATE    FLG-CLIST-ROW
           WHEN    1
               MOVE    ZERO               TO   W63-CHECKLIST-ROW
               MOVE    ZERO               TO   W63-CHECKLIST-ROWATTR
           WHEN    2
               MOVE    SPA-GMN-CLIST-MAX  TO   W63-CHECKLIST-ROW
               MOVE    1                  TO   W63-CHECKLIST-ROWATTR
           WHEN    OTHER
               MOVE    WRK-CLIST-ROW      TO   W63-CHECKLIST-ROW
               MOVE    ZERO               TO   W63-CHECKLIST-ROWATTR
           END-EVALUATE
      *
      *    カーソルセット
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
           IF     (SPA-ERRCD           =   SPACE)
              AND (SPA-GMN-CUR         =   ZERO )
      *        入力個所のセット処理
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           PERFORM 5012-SKIP-CUR-SEC
      *
      *    カーソルセット
           EVALUATE    SPA-GMN-CUR
           WHEN    001
               MOVE    "SELNUM"        TO  MCP-WIDGET
           WHEN    002
               MOVE    "HKNJANUM"      TO  MCP-WIDGET
           WHEN    003
               MOVE    "JYKNKBN"       TO  MCP-WIDGET
           WHEN    004
               MOVE    "HKNNUM"        TO  MCP-WIDGET
           WHEN    005
               MOVE    "KIGO"          TO  MCP-WIDGET
           WHEN    006
               MOVE    "STYUKYMD"      TO  MCP-WIDGET
           WHEN    007
               MOVE    "EDYUKYMD"      TO  MCP-WIDGET
           WHEN    201
               MOVE    "B01"           TO  MCP-WIDGET
           WHEN    202
               MOVE    "B02"           TO  MCP-WIDGET
           WHEN    206
               MOVE    "B06"           TO  MCP-WIDGET
           WHEN    207
               MOVE    "B07"           TO  MCP-WIDGET
           WHEN    208
               MOVE    "B08"           TO  MCP-WIDGET
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
      *    入力箇所からカーソルをセット
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SELNUM"
               MOVE    002             TO  SPA-GMN-CUR
           WHEN    "HKNJANUM"
               MOVE    003             TO  SPA-GMN-CUR
           WHEN    "JYKNKBN"
               MOVE    004             TO  SPA-GMN-CUR
           WHEN    "HKNNUM"
               MOVE    005             TO  SPA-GMN-CUR
           WHEN    "KIGO"
               MOVE    006             TO  SPA-GMN-CUR
           WHEN    "STYUKYMD"
               MOVE    007             TO  SPA-GMN-CUR
           WHEN    "EDYUKYMD"
               IF    ( SPA-GMN-SELNUM  =   ZERO )
                   MOVE    206         TO  SPA-GMN-CUR
               ELSE
                   MOVE    207         TO  SPA-GMN-CUR
               END-IF
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソルスキップ処理
      *****************************************************************
       5012-SKIP-CUR-SEC           SECTION.
      *
           IF  ( SPA-GMN-CUR           =   206 )
               IF  ( W63-B06-STATE     =   WIDGET-INSENSITIVE )
                   MOVE    207         TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
      *
       5012-SKIP-CUR-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ表示処理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE           TO  SPA-ERRMSG
      *
      *    エラーメッセージセット
           EVALUATE    SPA-ERRCD
           WHEN    "0001"
               MOVE    "選択番号入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "保険者番号入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "一致条件入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0004"
               MOVE    "保険の種類入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0005"
               MOVE    "記号抜けチェック区分入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0006"
               MOVE    "有効期間開始日入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "0007"
               MOVE    "有効期間終了日入力エラー"
                                           TO  SPA-ERRMSG
           WHEN    "1001"
               MOVE    "選択番号を入力してください"
                                           TO  SPA-ERRMSG
           WHEN    "1002"
               MOVE    "有効開始日付より前の日付になっています"
                                           TO  SPA-ERRMSG
           WHEN    "1003"
               MOVE    "対象のデータが選択されています"
                                           TO  SPA-ERRMSG
           WHEN    "1004"
               MOVE    "有効期間の重複するデータが存在します"
                                           TO  SPA-ERRMSG
           WHEN    "1005"
               MOVE    "追加可能最大件数に達しました"
                                           TO  SPA-ERRMSG
           WHEN    "1006"
               MOVE    "該当するデータが既に存在します"
                                           TO  SPA-ERRMSG
           WHEN    "1007"
               MOVE    "保険者番号を入力してください"
                                           TO  SPA-ERRMSG
           WHEN    "1008"
               MOVE    "該当する保険者が存在しません"
                                           TO  SPA-ERRMSG
           WHEN    "1009"
               MOVE    "保険の種類を入力してください"
                                           TO  SPA-ERRMSG
           WHEN    "4001"      THRU        "4999"
               MOVE    "更新処理に失敗しました"
                                           TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE           TO  WERR
           MOVE    SPA-ERRCD       TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG      TO  WERR-ERRMSG
           MOVE    "B01"           TO  MCP-WIDGET
      *
           MOVE    "W63"           TO  SPA-MOTOPG
           MOVE    "WERR"          TO  SPA-SAKIPG
      *
           MOVE    "NEW"           TO  MCP-PUTTYPE
           MOVE    "WERR"          TO  MCP-WINDOW
      *
      *    ＰＵＴ　処理
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示処理
      *****************************************************************
       520-WIDSET-SEC              SECTION.
      *
      *    確認メッセージセット
           EVALUATE    SPA-WIDCD
           WHEN    "3001"
               MOVE    "削除します。よろしいですか"
                                   TO  WRK-WIDMSG
           END-EVALUATE
      *
      *
           MOVE    SPACE           TO  WID1
           MOVE    SPA-WIDCD       TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG      TO  WID1-ID1MSG
           MOVE    "B12"           TO  MCP-WIDGET
      *
           MOVE    "W63"           TO  SPA-MOTOPG
           MOVE    "WID1"          TO  SPA-SAKIPG
      *
           MOVE    "NEW"           TO  MCP-PUTTYPE
           MOVE    "WID1"          TO  MCP-WINDOW
      *
      *    ＰＵＴ　処理
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1               TO  FLG-END
      *
           .
       520-WIDSET-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC             SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       800-HIZUKE-CHK-SEC          SECTION.
      *
           MOVE    SPACE           TO  WRK-HENYMDG
                                       WRK-SYMD
      *
           MOVE    ZERO            TO  FLG-HIZUKE
      *
           IF    ( WRK-YMD             =   "00000000" )
             OR  ( WRK-YMD             =   "99999999" )
               MOVE    WRK-YMD     TO  WRK-HENYMDG
                                           WRK-SYMD
           ELSE
      *
               INITIALIZE                  ORCSGDAYAREA
               MOVE    WRK-YMD     TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF    ( SGDAY-RC            =   ZERO )
                   MOVE    SGDAY-OTDAY TO  WRK-HENYMDG
                   MOVE    SGDAY-SDAY  TO  WRK-SYMD
               ELSE
                   MOVE    1           TO  FLG-HIZUKE
               END-IF
      *
           END-IF
      *
           .
       800-HIZUKE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    半角ェック
      *****************************************************************
       800-HANKAKU-CHK-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-KANACHK
      *
           INITIALIZE                  ORCXKANACONVAREA
      *
           MOVE    300                 TO  KANACONV-LEN
           MOVE    1000                TO  KANACONV-STLEN
           MOVE    0                   TO  KANACONV-CONV-FLAG
           MOVE    112                 TO  KANACONV-CHAR-TYPE
           MOVE    WRK-KANACHK-DATA    TO  KANACONV-INDATA
           CALL    "kanaconv"          USING ORCXKANACONVAREA
           MOVE    KANACONV-RETURN     TO  FLG-KANACHK
           MOVE    KANACONV-OUTDATA    TO  WRK-KANACHK-DATA
           MOVE    KANACONV-MAXLEN     TO  WRK-KANACHK-MAXLEN
      *
           .
       800-HANKAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険番号情報検索処理(KEY3)
      *****************************************************************
       900-HKNNUM-KEY3-SEL-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNNUM
      *
           INITIALIZE                      HKNNUM-REC
           MOVE    SPA-HOSPID          TO  HKN-HOSPID
           MOVE    SPA-NAI-STYUKYMD    TO  HKN-TEKSTYMD
                                           HKN-TEKEDYMD
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
      *
           MOVE    "tbl_hknnum"        TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF ( MCP-RC                 =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
           ELSE
               MOVE    1               TO  FLG-HKNNUM
               INITIALIZE                  HKNNUM-REC
           END-IF
      *
           .
       900-HKNNUM-KEY3-SEL-EXT.
           EXIT.
      *****************************************************************
      *    保険番号情報FETCH処理(KEY3)
      *****************************************************************
       900-HKNNUM-KEY3-FET-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNNUM
      *
           MOVE    "tbl_hknnum"        TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF ( MCP-RC                 =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
           ELSE
               MOVE    1               TO  FLG-HKNNUM
               INITIALIZE                  HKNNUM-REC
           END-IF
      *
           .
       900-HKNNUM-KEY3-FET-EXT.
           EXIT.
      *****************************************************************
      *    保険番号情報検索処理(KEY)
      *****************************************************************
       900-HKNNUM-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNNUM
      *
           INITIALIZE                      HKNNUM-REC
           MOVE    SPA-HOSPID          TO  HKN-HOSPID
           MOVE    CK4-1102-HKNNUM     TO  HKN-HKNNUM
           MOVE    CK4-1102-STYUKYMD   TO  HKN-TEKSTYMD
                                           HKN-TEKEDYMD
           MOVE    "00"                TO  HKN-PAYKBN
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "tbl_hknnum"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF ( MCP-RC                 =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
           ELSE
               MOVE    1               TO  FLG-HKNNUM
               INITIALIZE                  HKNNUM-REC
           END-IF
      *
           MOVE    "tbl_hknnum"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-HKNNUM-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    保険番号情報検索処理(KEY)
      *****************************************************************
       900-HKNJAINF-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNJAINF
      *
           INITIALIZE                      HKNJAINF-REC
           MOVE    SPA-HOSPID          TO  HKNJA-HOSPID
           MOVE    WRK-HKNJANUM        TO  HKNJA-HKNJANUM
           MOVE    HKNJAINF-REC        TO  MCPDATA-REC
           MOVE    "tbl_hknjainf"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF ( MCP-RC                 =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNJAINF-REC
           ELSE
               MOVE    1               TO  FLG-HKNJAINF
               INITIALIZE                  HKNJAINF-REC
           END-IF
      *
           MOVE    "tbl_hknjainf"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-HKNJAINF-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ４検索処理(KEY)
      *****************************************************************
       900-CHK004-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK004
      *
           MOVE    CHK004-REC           TO  MCPDATA-REC
      *
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF ( MCP-RC                 =   ZERO )
               MOVE    MCPDATA-REC     TO  CHK004-REC
           ELSE
               MOVE    1               TO  FLG-CHK004
               INITIALIZE                  CHK004-REC
           END-IF
      *
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-CHK004-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ４検索処理(KEY3)
      *****************************************************************
       900-CHK004-KEY3-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK004
      *
           MOVE    CHK004-REC           TO  MCPDATA-REC
      *
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF ( MCP-RC                 =   ZERO )
               MOVE    MCPDATA-REC     TO  CHK004-REC
           ELSE
               MOVE    1               TO  FLG-CHK004
               INITIALIZE                  CHK004-REC
           END-IF
      *
           .
       900-CHK004-KEY3-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ４検索処理(KEY3)
      *****************************************************************
       900-CHK004-KEY3-FET-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK004
      *
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF ( MCP-RC                 =   ZERO )
               MOVE    MCPDATA-REC     TO  CHK004-REC
           ELSE
               MOVE    1               TO  FLG-CHK004
               INITIALIZE                  CHK004-REC
           END-IF
      *
           .
       900-CHK004-KEY3-FET-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＤＥＬＥＴＥ処理
      *****************************************************************
       910-DBDELETE-SEC                 SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＵＰＤＡＴＥ処理
      *****************************************************************
       910-DBUPDATE-SEC                SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"          TO  MCP-FUNC.
           CALL   "MONFUNC"            USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
