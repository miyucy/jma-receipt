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
       PROGRAM-ID.                               ORCGZ04.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 点数マスタ設定
      *  コンポーネント名  : 点数マスタ医薬品設定画面（Ｚ０４）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01/07/03  日付入力チェックサブ追加
      *  01.00.02    MCC-多々納   01/07/18  正式名称等追加
      *  01.01.03    MCC-藤原     01/09/26  JOINの修正      
      *  01.01.04    MCC-藤原     01/10/31  項目をコンボボックスに変更
      *                                     単位名称を削除      
      *  01.01.05    MCC-多々納   02/03/17  後発医薬品追加
      *  01.01.06    MCC-多々納   02/07/18  服用方法画面追加
      *  01.01.07    NACL-多々納  02/10/09  半角空白→全角空白追加
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                                      DIVISION.
       FILE                                      SECTION.
      *
       WORKING-STORAGE                           SECTION.
      *   
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    点数マスタ設定用共通パラメタ
           COPY    "Z01COMMON-SPA".
      *
      *    第一画面ＳＰＡエリア
           COPY    "Z01SCR-SPA".
      *
       01  SPA-Z04.
      *
      *    第四画面ＳＰＡエリア
           03  SPA-GMN-AREA.
               05  SPA-GMN-SRYCDH              PIC X(09).
               05  SPA-GMN-NAMEH               PIC X(100).
               05  SPA-GMN-YUKOSTYMDH          PIC X(09).
               05  SPA-GMN-YUKOEDYMDH          PIC X(09).
      * 
               05  SPA-GMN-TENSIKIBETULST      OCCURS  3.
                   07  SPA-GMN-TENSIKIBETUL    PIC X(01).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-TENSIKIBETUMEIL PIC X(18).
               05  SPA-GMN-OLDTENSKBLST        OCCURS  3.
                   07  SPA-GMN-OLDTENSKBL      PIC X(01).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-OLDTENSKBMEIL   PIC X(18).
      *********05  SPA-GMN-TANICDLST           OCCURS  59.
               05  SPA-GMN-TANICDLST           OCCURS  90.
                   07  SPA-GMN-TANICDL         PIC X(03).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-TANICDMEIL      PIC X(10).
               05  SPA-GMN-MADOKUKBNLST        OCCURS  5.
                   07  SPA-GMN-MADOKUKBNL      PIC X(01).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-MADOKUKBNMEIL   PIC X(14).
               05  SPA-GMN-SINKEIHAKAIKBNLST   OCCURS  2.
                   07  SPA-GMN-SINKEIHAKAIKBNL PIC X(01).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-SINKEIHAKAIKBNMEIL
                                               PIC X(16).
               05  SPA-GMN-SEIBUTUGAKUKBNLST   OCCURS  2.
                   07  SPA-GMN-SEIBUTUGAKUKBNL PIC X(01).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-SEIBUTUGAKUKBNMEIL
                                               PIC X(30).
               05  SPA-GMN-ZOEIZAIKBNLST       OCCURS  3.
                   07  SPA-GMN-ZOEIZAIKBNL     PIC X(01).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-ZOEIZAIKBNMEIL  PIC X(24).
               05  SPA-GMN-YKZKBNLST           OCCURS  6.
                   07  SPA-GMN-YKZKBNL         PIC X(01).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-YKZKBNMEIL      PIC X(14).
               05  SPA-GMN-ZAIGATAKBNLST       OCCURS  4.
                   07  SPA-GMN-ZAIGATAKBNL     PIC X(01).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-ZAIGATAKBNMEIL  PIC X(34).
      *        後発医薬品
               05  SPA-GMN-KOUHATUKBNLST       OCCURS  2.
                   07  SPA-GMN-KOUHATUKBNL     PIC X(01).
                   07  SPA-GMN-F1L             PIC X(01).
                   07  SPA-GMN-KOUHATUKBNMEIL  PIC X(20).
               05  SPA-GMN-KOUHATUKBN-G.
                   07  SPA-GMN-KOUHATUKBN      PIC X(01).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-KOUHATUKBNMEI   PIC X(20).
      *
               05  SPA-GMN-YUKOSTYMD           PIC X(10).
               05  SPA-GMN-YUKOEDYMD           PIC X(10).
               05  SPA-GMN-KANANAME            PIC X(100).
               05  SPA-GMN-NAME                PIC X(100).
               05  SPA-GMN-FORMALNAME          PIC X(200).
               05  SPA-GMN-SHONAME             PIC X(100).
               05  SPA-GMN-TEN                 PIC 9(8)V9(2).
               05  SPA-GMN-TENSIKIBETU-G.
                   07  SPA-GMN-TENSIKIBETU     PIC X(01).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-TENSIKIBETUMEI  PIC X(18).
               05  SPA-GMN-OLDTEN              PIC 9(8)V9(2).
               05  SPA-GMN-OLDTENSKB-G.
                   07  SPA-GMN-OLDTENSKB       PIC X(01).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-OLDTENSKBMEI    PIC X(18).
               05  SPA-GMN-TANICD-G.
                   07  SPA-GMN-TANICD          PIC X(03).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-TANICDMEI       PIC X(10).
      *******  05  SPA-GMN-TANINAME            PIC X(24).
               05  SPA-GMN-MADOKUKBN-G.
                   07  SPA-GMN-MADOKUKBN       PIC X(01).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-MADOKUKBNMEI    PIC X(14).
               05  SPA-GMN-SINKEIHAKAIKBN-G.
                   07  SPA-GMN-SINKEIHAKAIKBN  PIC X(01).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-SINKEIHAKAIKBNMEI
                                               PIC X(16).
               05  SPA-GMN-SEIBUTUGAKUKBN-G.
                   07  SPA-GMN-SEIBUTUGAKUKBN  PIC X(01).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-SEIBUTUGAKUKBNMEI
                                               PIC X(30).
               05  SPA-GMN-ZOEIZAIKBN-G.
                   07  SPA-GMN-ZOEIZAIKBN      PIC X(01).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-ZOEIZAIKBNMEI   PIC X(24).
               05  SPA-GMN-CSYYOURYO           PIC 9(5).
               05  SPA-GMN-YKZKBN-G.
                   07  SPA-GMN-YKZKBN          PIC X(01).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-YKZKBNMEI       PIC X(14).
               05  SPA-GMN-ZAIGATAKBN-G.
                   07  SPA-GMN-ZAIGATAKBN      PIC X(01).
                   07  SPA-GMN-F1              PIC X(01).
                   07  SPA-GMN-ZAIGATAKBNMEI   PIC X(34).
               05  SPA-GMN-LONGTOYOKBN         PIC 9(1).
               05  SPA-GMN-KOUHYOJYUNNUM       PIC 9(09).
               05  SPA-GMN-YAKKAKJNCD          PIC X(12).
               05  SPA-GMN-SYUSAISKB           PIC 9(1).
               05  SPA-GMN-SYOMEIKANREN        PIC X(09).
               05  SPA-GMN-KEIKASOCHIYMD       PIC X(09).
               05  SPA-GMN-INPCHKKBN           PIC 9(01).
      *
               05  SPA-GMN-CUR                 PIC X(30).
      *
      *    第四画面内容
           03  SPA-NAI-AREA.
               05  SPA-NAI-YUKOSTYMD           PIC X(08).
               05  SPA-NAI-YUKOEDYMD           PIC X(08).
               05  SPA-NAI-KEIKASOCHIYMD       PIC X(08).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                           PIC 9(01).
           03  FLG-TENSU                         PIC 9(01).
           03  FLG-TENSUPLUS                     PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR                           PIC 9(06).
           03  CNT-PAGE                          PIC 9(02).
           03  CNT-ERRCHK                        PIC 9(03).
           03  CNT-STRING                        PIC 9(03).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDXX                              PIC 9(02).
           03  IDXY                              PIC 9(02).
           03  IDXZ                              PIC 9(02).
           03  IDX                               PIC 9(04).
      *
      *    ワーク領域
       01  WRK-AREA.
           03  WRK-GMN-CUR                       PIC X(30).
           03  WRK-ZIDMSG                        PIC X(70).
           03  WRK-SNUM-INX                      PIC X(26).
           03  WRK-STRINGTBL.
               05  WRK-STRING                    PIC X(01)  OCCURS 200.
           03  WRK-LNKYMD                        PIC X(10).
           03  WRK-WYMD.
               05  WRK-WGO                       PIC X(01).
               05  WRK-WYY                       PIC 9(02).
               05  WRK-WMM                       PIC 9(02).
               05  WRK-WDD                       PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-YMD             PIC X(08).
           03  WRK-OTYMD           PIC X(08).
      *
           03  WRK-MAE-INPUT       PIC X(400).
           03  WRK-OUT-INPUT       PIC X(400).
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
      *    単位の項目順テーブル
           COPY    "CMTANICD.INC".
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *    点数マスタ付加コード
        01 TENSUPLUS-REC.
           COPY    "CPTENSUPLUS.INC".
      *    入力コード
        01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
             COPY    "CPORCSNUM.INC".
      *----(01.00.01) LINE ADD START ----------------------------------
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
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
           COPY    "Z01.INC".
           COPY    "Z02.INC".
           COPY    "Z03.INC".
           COPY    "Z04.INC".
           COPY    "Z05.INC".
           COPY    "Z06.INC".
           COPY    "Z90.INC".
           COPY    "Z91.INC".
           COPY    "Z97.INC".
           COPY    "Z98.INC".
           COPY    "Z99.INC".
           COPY    "ZERR.INC".
           COPY    "ZID1.INC".
           COPY    "ZID2.INC".
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
       000-PROC-SEC                              SECTION.
      *
           MOVE    SPA-COMMON                    TO  SPA-AREA.
           MOVE    SPA-WORK                      TO  SPA-Z01KYOUTU
           MOVE    SPA-FREE                      TO  SPA-Z01FREE
           MOVE    SPA-Z01SONOTA                 TO  SPA-Z04
      *
           MOVE    SPACE                         TO  SPA-ERRCD.
           MOVE    ZERO                          TO  FLG-END.
      *
           EVALUATE    MCP-STATUS       ALSO    MCP-EVENT
               WHEN    "LINK"           ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI-SEC
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY-SEC
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END                       =   ZERO
               PERFORM 500-SET-SCREEN-SEC
           END-IF.
      *    
      *    
           MOVE    SPA-Z01KYOUTU                 TO  SPA-WORK
           MOVE    SPA-AREA                      TO  SPA-COMMON
           MOVE    SPA-Z04                       TO  SPA-Z01SONOTA 
           MOVE    SPA-Z01FREE                   TO  SPA-FREE
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                              SECTION.
      *
      *    DISPLAY "*** ORCSNPL    START  ***"
      *
           INITIALIZE                            FLG-AREA.
           INITIALIZE                            CNT-AREA.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "ZERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END         =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE  SPA-GMN-CUR           TO  MCP-WIDGET
      *
           MOVE    SPACE               TO  LINKAREA.
      *
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "Z04"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           EVALUATE    SPA-MOTOPG
      *    更新処理
               WHEN    "ZID1"
                   PERFORM 330-ZID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
      *    入力ＣＤより
               WHEN    "Z99"
      *
                  MOVE  "YUKOSTYMD"             TO  SPA-GMN-CUR
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
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *    点数マスタ該当データ読み出し
           INITIALIZE                 SPA-GMN-AREA
      *
           MOVE    SPA-Z01-SRYCD      TO  SPA-GMN-SRYCDH
      *
           MOVE    SPA-Z01-YUKOSTYMD  TO  SPA-NAI-YUKOSTYMD
           IF      SPA-Z01-SYORIKBN   =   2
               MOVE  SPA-Z01-YUKOSTYMDH   TO  SPA-GMN-YUKOSTYMDH
           END-IF
           MOVE    SPA-Z01-YUKOSTYMDH TO  SPA-GMN-YUKOSTYMD
      *
           MOVE    SPA-Z01-YUKOEDYMD  TO  SPA-NAI-YUKOEDYMD
           IF      SPA-Z01-SYORIKBN       =   2
               MOVE  SPA-Z01-YUKOEDYMDH       TO  SPA-GMN-YUKOEDYMDH
           END-IF
           MOVE  SPA-Z01-YUKOEDYMDH   TO  SPA-GMN-YUKOEDYMD
      *
           MOVE    "1"                TO  SPA-GMN-TENSIKIBETUL   (1) 
           MOVE    "金額"             TO  SPA-GMN-TENSIKIBETUMEIL(1)
           MOVE    "2"                TO  SPA-GMN-TENSIKIBETUL   (2)
           MOVE    "都道府県購入価格" TO  SPA-GMN-TENSIKIBETUMEIL(2)
           MOVE    "7"                TO  SPA-GMN-TENSIKIBETUL   (3)
           MOVE    "減点"             TO  SPA-GMN-TENSIKIBETUMEIL(3)
      *
           MOVE    "1"                TO  SPA-GMN-OLDTENSKBL     (1) 
           MOVE    "金額"             TO  SPA-GMN-OLDTENSKBMEIL  (1)
           MOVE    "2"                TO  SPA-GMN-OLDTENSKBL     (2)
           MOVE    "都道府県購入価格" TO  SPA-GMN-OLDTENSKBMEIL  (2)
           MOVE    "7"                TO  SPA-GMN-OLDTENSKBL     (3)
           MOVE    "減点"             TO  SPA-GMN-OLDTENSKBMEIL  (3)
      *
           MOVE    "0"                TO  SPA-GMN-MADOKUKBNL     (1) 
           MOVE    "なし"             TO  SPA-GMN-MADOKUKBNMEIL  (1)
           MOVE    "1"                TO  SPA-GMN-MADOKUKBNL     (2)
           MOVE    "麻薬"             TO  SPA-GMN-MADOKUKBNMEIL  (2)
           MOVE    "2"                TO  SPA-GMN-MADOKUKBNL     (3) 
           MOVE    "毒薬"             TO  SPA-GMN-MADOKUKBNMEIL  (3)
           MOVE    "3"                TO  SPA-GMN-MADOKUKBNL     (4)
           MOVE    "覚せい剤原料"     TO  SPA-GMN-MADOKUKBNMEIL  (4)
           MOVE    "5"                TO  SPA-GMN-MADOKUKBNL     (5) 
           MOVE    "向精神薬"         TO  SPA-GMN-MADOKUKBNMEIL  (5)
      *
           MOVE    "0"                TO  SPA-GMN-SINKEIHAKAIKBNL   (1)
           MOVE    "なし"             TO  SPA-GMN-SINKEIHAKAIKBNMEIL(1)
           MOVE    "1"                TO  SPA-GMN-SINKEIHAKAIKBNL   (2)
           MOVE    "神経破壊剤"       TO  SPA-GMN-SINKEIHAKAIKBNMEIL(2)
      *
           MOVE    "0"                TO  SPA-GMN-SEIBUTUGAKUKBNL   (1)
           MOVE    "なし"             TO  SPA-GMN-SEIBUTUGAKUKBNMEIL(1)
           MOVE    "1"                TO  SPA-GMN-SEIBUTUGAKUKBNL   (2)
           MOVE    "生物学的製剤加算対象品目"
                                      TO  SPA-GMN-SEIBUTUGAKUKBNMEIL(2)
      *
           MOVE    "0"                TO  SPA-GMN-ZOEIZAIKBNL    (1) 
           MOVE    "なし"             TO  SPA-GMN-ZOEIZAIKBNMEIL (1)
           MOVE    "1"                TO  SPA-GMN-ZOEIZAIKBNL    (2)
           MOVE    "造影剤"           TO  SPA-GMN-ZOEIZAIKBNMEIL (2)
           MOVE    "2"                TO  SPA-GMN-ZOEIZAIKBNL    (3) 
           MOVE    "造影補助剤"       TO  SPA-GMN-ZOEIZAIKBNMEIL (3)
      *
           MOVE    "1"                TO  SPA-GMN-YKZKBNL        (1) 
           MOVE    "内用薬"           TO  SPA-GMN-YKZKBNMEIL     (1)
           MOVE    "3"                TO  SPA-GMN-YKZKBNL        (2)
           MOVE    "その他"           TO  SPA-GMN-YKZKBNMEIL     (2)
           MOVE    "4"                TO  SPA-GMN-YKZKBNL        (3) 
           MOVE    "注射薬"           TO  SPA-GMN-YKZKBNMEIL     (3)
           MOVE    "6"                TO  SPA-GMN-YKZKBNL        (4)
           MOVE    "外用薬"           TO  SPA-GMN-YKZKBNMEIL     (4)
           MOVE    "8"                TO  SPA-GMN-YKZKBNL        (5) 
           MOVE    "歯科用薬剤"       TO  SPA-GMN-YKZKBNMEIL     (5)
           MOVE    "9"                TO  SPA-GMN-YKZKBNL        (6) 
           MOVE    "歯科特定薬剤"     TO  SPA-GMN-YKZKBNMEIL     (6)
      *
           MOVE    "0"                TO  SPA-GMN-ZAIGATAKBNL    (1) 
           MOVE    "散剤、顆粒剤（細粒剤）、液剤以外"
                                      TO  SPA-GMN-ZAIGATAKBNMEIL (1)
           MOVE    "1"                TO  SPA-GMN-ZAIGATAKBNL    (2)
           MOVE    "散剤"             TO  SPA-GMN-ZAIGATAKBNMEIL (2)
           MOVE    "2"                TO  SPA-GMN-ZAIGATAKBNL    (3) 
           MOVE    "顆粒剤（細粒剤）" TO  SPA-GMN-ZAIGATAKBNMEIL (3)
           MOVE    "3"                TO  SPA-GMN-ZAIGATAKBNL    (4)
           MOVE    "液剤"             TO  SPA-GMN-ZAIGATAKBNMEIL (4)
      *
           MOVE    "0"                TO  SPA-GMN-KOUHATUKBNL    (1) 
           MOVE    "後発医薬品以外"
                                      TO  SPA-GMN-KOUHATUKBNMEIL (1)
           MOVE    "1"                TO  SPA-GMN-KOUHATUKBNL    (2) 
           MOVE    "後発医薬品"       TO  SPA-GMN-KOUHATUKBNMEIL (2)
      *
           PERFORM VARYING IDXX    FROM    1   BY  1
      ************ UNTIL   IDXX    >       59
                   UNTIL   IDXX    >       MTANI-MAX
               MOVE    MTANI-TANICD  (IDXX)
                                       TO  SPA-GMN-TANICDL   (IDXX)
               MOVE    MTANI-TANINAME(IDXX)
                                       TO  SPA-GMN-TANICDMEIL(IDXX)
           END-PERFORM
      *         
           MOVE    SPA-GMN-TENSIKIBETULST (1)
                                      TO  SPA-GMN-TENSIKIBETU-G
           MOVE    SPA-GMN-OLDTENSKBLST (1)
                                      TO  SPA-GMN-OLDTENSKB-G
           MOVE    SPA-GMN-TANICDLST      (1)
                                      TO  SPA-GMN-TANICD-G
           MOVE    SPA-GMN-MADOKUKBNLST   (1)
                                      TO  SPA-GMN-MADOKUKBN-G
           MOVE    SPA-GMN-SINKEIHAKAIKBNLST(1)
                                      TO  SPA-GMN-SINKEIHAKAIKBN-G
           MOVE    SPA-GMN-SEIBUTUGAKUKBNLST(1)
                                      TO  SPA-GMN-SEIBUTUGAKUKBN-G
           MOVE    SPA-GMN-ZOEIZAIKBNLST  (1)
                                      TO  SPA-GMN-ZOEIZAIKBN-G
           MOVE    SPA-GMN-YKZKBNLST (1)
                                      TO  SPA-GMN-YKZKBN-G
           MOVE    SPA-GMN-ZAIGATAKBNLST  (1)
                                      TO  SPA-GMN-ZAIGATAKBN-G
      *
           MOVE    SPA-GMN-KOUHATUKBNLST  (1)
                                      TO  SPA-GMN-KOUHATUKBN-G
      *
      *
           INITIALIZE                            TNS-TENSU-REC
           MOVE  SPA-Z01-SRYCD                   TO  TNS-SRYCD
      *****IF  SPA-Z01-SYORIKBN                  =   2
      *        MOVE  SPA-Z01-YUKOSTYMD           TO  TNS-YUKOSTYMD
      *        MOVE  SPA-Z01-YUKOEDYMD           TO  TNS-YUKOEDYMD
      *****ELSE
               IF  SPA-Z01-SELNUM                 =   ZERO
                   MOVE  ALL "9"                 TO  TNS-YUKOSTYMD
                   MOVE  ALL "9"                 TO  TNS-YUKOEDYMD
               ELSE
                   MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOSTYMD
                   MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOEDYMD
               END-IF
      *****END-IF
           PERFORM  811-TENSUSEL-SEC
      *
           IF  MCP-RC                      =   ZERO
               PERFORM  812-TENSUFET-SEC
               IF  MCP-RC                      =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    TNS-NAME            TO  SPA-GMN-NAMEH
      *
                   MOVE    TNS-KANANAME        TO  SPA-GMN-KANANAME
                   MOVE    TNS-NAME            TO  SPA-GMN-NAME
                   MOVE    TNS-FORMALNAME      TO  SPA-GMN-FORMALNAME
                   MOVE    TNS-TEN             TO  SPA-GMN-TEN
                   MOVE    TNS-TENSIKIBETU     TO  SPA-GMN-TENSIKIBETU
                   PERFORM VARYING IDXX    FROM    1   BY  1
                           UNTIL   IDXX    >       3
                       IF      SPA-GMN-TENSIKIBETU 
                                       =   SPA-GMN-TENSIKIBETUL (IDXX)
                           MOVE    SPA-GMN-TENSIKIBETULST (IDXX)
                                           TO  SPA-GMN-TENSIKIBETU-G
                           MOVE    3       TO  IDXX
                       END-IF
                   END-PERFORM
                   MOVE    TNS-OLDTEN          TO  SPA-GMN-OLDTEN
                   MOVE    TNS-OLDTENSKB       TO  SPA-GMN-OLDTENSKB
                   PERFORM VARYING IDXX    FROM    1   BY  1
                           UNTIL   IDXX    >       3
                       IF      SPA-GMN-OLDTENSKB 
                                       =   SPA-GMN-OLDTENSKBL (IDXX)
                           MOVE    SPA-GMN-OLDTENSKBLST (IDXX)
                                               TO  SPA-GMN-OLDTENSKB-G
                           MOVE    3            TO  IDXX
                       END-IF
                   END-PERFORM
                   MOVE    TNS-TANICD          TO  SPA-GMN-TANICD
                   MOVE    TNS-TANINAME        TO  SPA-GMN-TANICDMEI
                   MOVE    TNS-MADOKUKBN       TO  SPA-GMN-MADOKUKBN
                   PERFORM VARYING IDXX    FROM    1   BY  1
                           UNTIL   IDXX    >       5
                       IF      SPA-GMN-MADOKUKBN  
                                       =   SPA-GMN-MADOKUKBNL (IDXX)
                           MOVE    SPA-GMN-MADOKUKBNLST (IDXX)
                                                TO  SPA-GMN-MADOKUKBN-G
                           MOVE    5            TO  IDXX
                       END-IF
                   END-PERFORM
                   MOVE    TNS-SINKEIHAKAIKBN  TO
                                               SPA-GMN-SINKEIHAKAIKBN
                   PERFORM VARYING IDXX    FROM    1   BY  1
                           UNTIL   IDXX    >       2
                       IF      SPA-GMN-SINKEIHAKAIKBN  
                                           =   SPA-GMN-SINKEIHAKAIKBNL
                                                             (IDXX)
                           MOVE    SPA-GMN-SINKEIHAKAIKBNLST (IDXX)
                                                TO
                                            SPA-GMN-SINKEIHAKAIKBN-G
                           MOVE    2            TO  IDXX
                       END-IF
                   END-PERFORM
                   MOVE    TNS-SEIBUTUGAKUKBN  TO
                                               SPA-GMN-SEIBUTUGAKUKBN
                   PERFORM VARYING IDXX    FROM    1   BY  1
                           UNTIL   IDXX    >       2
                       IF      SPA-GMN-SEIBUTUGAKUKBN  
                                       =   SPA-GMN-SEIBUTUGAKUKBNL
                                                            (IDXX)
                           MOVE    SPA-GMN-SEIBUTUGAKUKBNLST (IDXX)
                                           TO  SPA-GMN-SEIBUTUGAKUKBN-G
                           MOVE    2           TO  IDXX
                       END-IF
                   END-PERFORM
                   MOVE    TNS-ZOEIZAIKBN      TO  SPA-GMN-ZOEIZAIKBN
                   PERFORM VARYING IDXX    FROM    1   BY  1
                           UNTIL   IDXX    >       3
                       IF      SPA-GMN-ZOEIZAIKBN  
                                       =   SPA-GMN-ZOEIZAIKBNL(IDXX)
                           MOVE    SPA-GMN-ZOEIZAIKBNLST (IDXX)
                                               TO  SPA-GMN-ZOEIZAIKBN-G
                           MOVE    3           TO  IDXX
                       END-IF
                   END-PERFORM
                   MOVE    TNS-CSYYOURYO       TO  SPA-GMN-CSYYOURYO
                   MOVE    TNS-YKZKBN          TO  SPA-GMN-YKZKBN
                   PERFORM VARYING IDXX    FROM    1   BY  1
                           UNTIL   IDXX    >       6
                       IF      SPA-GMN-YKZKBN 
                                           =   SPA-GMN-YKZKBNL (IDXX)
                           MOVE    SPA-GMN-YKZKBNLST (IDXX)
                                               TO  SPA-GMN-YKZKBN-G
                           MOVE    6           TO  IDXX
                       END-IF
                   END-PERFORM
                   MOVE    TNS-ZAIGATAKBN      TO  SPA-GMN-ZAIGATAKBN
                   PERFORM VARYING IDXX    FROM    1   BY  1
                           UNTIL   IDXX    >       4
                       IF      SPA-GMN-ZAIGATAKBN 
                                       =   SPA-GMN-ZAIGATAKBNL(IDXX)
                           MOVE    SPA-GMN-ZAIGATAKBNLST (IDXX)
                                               TO  SPA-GMN-ZAIGATAKBN-G
                           MOVE    4           TO  IDXX
                       END-IF
                   END-PERFORM
      *            後発医薬品
                   MOVE    TNS-KOUHATUKBN      TO  SPA-GMN-KOUHATUKBN
                   PERFORM VARYING IDXX    FROM    1   BY  1
                           UNTIL   IDXX    >       2
                       IF      SPA-GMN-KOUHATUKBN 
                                       =   SPA-GMN-KOUHATUKBNL(IDXX)
                           MOVE    SPA-GMN-KOUHATUKBNLST (IDXX)
                                               TO  SPA-GMN-KOUHATUKBN-G
                           MOVE    2           TO  IDXX
                       END-IF
                   END-PERFORM
      *
                   MOVE    TNS-LONGTOYOKBN     TO  SPA-GMN-LONGTOYOKBN
                   MOVE    TNS-KOUHYOJYUNNUM   TO
                                               SPA-GMN-KOUHYOJYUNNUM
                   MOVE    TNS-YAKKAKJNCD      TO  SPA-GMN-YAKKAKJNCD
                   MOVE    TNS-SYUSAISKB       TO  SPA-GMN-SYUSAISKB
                   MOVE    TNS-SYOMEIKANREN    TO  SPA-GMN-SYOMEIKANREN
                   MOVE    TNS-KEIKASOCHIYMD   TO
                                               SPA-GMN-KEIKASOCHIYMD
      *
                   MOVE    TNS-KEIKASOCHIYMD   TO  WRK-LNKYMD
                   MOVE    TNS-KEIKASOCHIYMD   TO  SPA-NAI-YUKOSTYMD
                   PERFORM  832-YMDCONV21-SEC
                   MOVE  WRK-HENYMDG           TO
                                               SPA-GMN-KEIKASOCHIYMD
      *
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF
           PERFORM  813-TENSUCLS-SEC
      *
      *    点数マスタ付加情報検索
           IF      FLG-TENSU           =   ZERO
               MOVE    SPACE               TO  TENSUPLUS-REC
               MOVE    TNS-SRYCD           TO  TNSP-SRYCD
               MOVE    TNS-YUKOSTYMD       TO  TNSP-YUKOSTYMD
               MOVE    TNS-YUKOEDYMD       TO  TNSP-YUKOEDYMD
      *
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC               =   ZERO
                   MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
                   PERFORM 990-TENSUPLUS-READ-SEC
                   IF      FLG-TENSUPLUS       =   ZERO
                       PERFORM  3002-SPASET-TENSUPLUS-SEC
                   END-IF
               END-IF
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           END-IF
      *
           MOVE  "YUKOSTYMD"             TO  SPA-GMN-CUR
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ情報をＳＰＡにセット（点数マスタ付加情報）
      *****************************************************************
       3002-SPASET-TENSUPLUS-SEC       SECTION.
      *    入力チェック区分
           MOVE    TNSP-INPCHKKBN      TO  SPA-GMN-INPCHKKBN
      *    処方名
           MOVE    TNSP-SHONAME        TO  SPA-GMN-SHONAME
           .
      *
       3002-SPASET-TENSUPLUS-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-ZID1-SET-SEC            SECTION.
      *
           IF      SPA-ZID1-FLG    =   "OK"
               IF      SPA-ZIDCD            =   "0001"
                   PERFORM  4031-DEL-SEC
               ELSE
                   PERFORM  4121-TOUROKU-SEC
               END-IF
           END-IF
      *
           IF      SPA-ERRCD       NOT =  SPACE
               PERFORM 510-ERRSET-SEC
           END-IF
      *
           MOVE    SPACE           TO  SPA-ZID1-FLG
           MOVE    SPACE           TO  SPA-ZIDCD      
           .
       330-ZID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI-SEC                           SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE  "CHANGE"      TO  MCP-PUTTYPE
                   PERFORM  401-BACK-SEC
      *        削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM  403-DEL-SEC
      *        入力コード設定
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM  405-INPUTCD-SEC
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM  412-TOUROKU-SEC
           END-EVALUATE
           .
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY-SEC                             SECTION.
      *
           IF  MCP-EVENT                         =  "ACTIVATE"
               MOVE  ZERO                        TO  CNT-ERRCHK
               PERFORM  500-ERRCHK-SEC
           END-IF
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       401-BACK-SEC                              SECTION.
      *
           MOVE  "Z01"                           TO  SPA-SAKIPG.
      *
           MOVE  "Z04"                           TO  SPA-MOTOPG.
      *
      ***  MOVE  "CHANGE"                        TO  MCP-PUTTYPE.
           MOVE  SPA-SAKIPG                      TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       401-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                               SECTION.
      *
           MOVE    "0001"              TO  SPA-ZIDCD
      *
           .    
       403-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理
      *****************************************************************
       4031-DEL-SEC                              SECTION.
      *
      *    点数マスタ削除
           MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
           MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOSTYMD
           MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOEDYMD
           PERFORM  816-TENSUDEL-SEC
           IF     MCP-RC               NOT =   ZERO
               DISPLAY "TNS DEL ERR!!"
               MOVE    "0015"                TO  SPA-ERRCD
               GO      TO      4031-DEL-EXT
           END-IF
      *
      *    点数付加情報削除
           MOVE    SPA-Z01-SRYCD       TO  TNSP-SRYCD
           MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOSTYMD
           MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOEDYMD
           MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    入力コード削除
           IF     (SPA-Z01-SELNUM      =   1    )  AND
                  (SPA-Z01-MAX         =   1    )
               MOVE  SPA-HOSPID                  TO  ICD-HOSPID
               MOVE  SPA-Z01-SRYCD               TO  ICD-SRYCD
               MOVE  INPUTCD-REC                 TO  MCPDATA-REC
               MOVE  "DBDELETE"                  TO  MCP-FUNC
               MOVE  "INPUTCD-KEY4"              TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
           END-IF
      *
      *
           MOVE  "JOIN"      TO  MCP-PUTTYPE
           PERFORM  401-BACK-SEC
           .
       4031-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コード　設定処理
      *****************************************************************
       405-INPUTCD-SEC                              SECTION.
      *
      *
           MOVE    SPA-Z01KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-Z04             TO  SPA-Z01SONOTA
           MOVE    SPA-Z01FREE         TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGZ99"           USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA
      *
           MOVE    SPA-COMMON          TO  SPA-AREA
           MOVE    SPA-WORK            TO  SPA-Z01KYOUTU
           MOVE    SPA-FREE            TO  SPA-Z01FREE
           MOVE    SPA-Z01SONOTA       TO  SPA-Z04
      *
      *    初期カーソル
           MOVE    "INPUTCD01"         TO  MCP-WIDGET
      *
           MOVE    "Z99"               TO  SPA-SAKIPG.
           MOVE    "Z04"               TO  SPA-MOTOPG.
      *
           MOVE    SPA-MOTOPG          TO  SPA-Z99GMN-MOTOPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       405-INPUTCD-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       412-TOUROKU-SEC                           SECTION.
      *    エラーチェック
           PERFORM  VARYING  CNT-ERRCHK
                    FROM  1  BY  1  UNTIL  CNT-ERRCHK  >  27
               PERFORM  500-ERRCHK-SEC
               IF  SPA-ERRCD                 NOT =  SPACE
                   GO                            TO  412-TOUROKU-EXT
               END-IF
           END-PERFORM
      *
           IF  SPA-ERRCD                     =  SPACE
               MOVE  "B12"                   TO  MCP-WIDGET
               MOVE  WRK-GMN-CUR             TO  SPA-GMN-CUR    
           END-IF
      *
           IF  SPA-GMN-YUKOSTYMD               =  SPACE  OR
               SPA-GMN-YUKOEDYMD               =  SPACE
               MOVE    "YUKOSTYMD"               TO  SPA-GMN-CUR
               MOVE    "0005"                    TO  SPA-ERRCD
               GO                                TO  412-TOUROKU-EXT
           END-IF
      *
           IF  SPA-NAI-YUKOSTYMD               >= SPA-NAI-YUKOEDYMD
               MOVE    "YUKOSTYMD"               TO  SPA-GMN-CUR
               MOVE    "0005"                    TO  SPA-ERRCD
               GO                                TO  412-TOUROKU-EXT
           END-IF
      *
      *
      *    有効期限範囲チェック
           IF      SPA-Z01-SYORIKBN    =   2
      *        前チェック
               IF      SPA-Z01-SELNUM      >   1
                   MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM - 1)
                                           TO  WRK-YMD
      *            対象日＋１日
                   PERFORM 800-DAYSET-SEC
                   IF      SPA-NAI-YUKOSTYMD   NOT =   WRK-OTYMD
                       MOVE    "YUKOSTYMD"         TO  SPA-GMN-CUR
                       MOVE    "0011"              TO  SPA-ERRCD
                       GO      TO      412-TOUROKU-EXT
                   END-IF
               END-IF
      *        後チェック
               IF      SPA-Z01-SELNUM      <   SPA-Z01-MAX
                   MOVE    SPA-NAI-YUKOEDYMD
                                           TO  WRK-YMD
      *            対象日＋１日
                   PERFORM 800-DAYSET-SEC
                   IF      SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM + 1)
                                               NOT =   WRK-OTYMD
                       MOVE    "YUKOEDYMD"         TO  SPA-GMN-CUR
                       MOVE    "0011"              TO  SPA-ERRCD
                       GO      TO      412-TOUROKU-EXT
                   END-IF
               END-IF
           END-IF
      *
           IF  SPA-Z01-SYORIKBN                  =  3
               IF  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM) >=
                   SPA-NAI-YUKOSTYMD
                   MOVE    "YUKOSTYMD"           TO  SPA-GMN-CUR
                   MOVE    "0008"                TO  SPA-ERRCD
                   GO                            TO  412-TOUROKU-EXT
               END-IF
      *
               IF  SPA-NAI-YUKOEDYMD    NOT    =  99999999
                   MOVE    "YUKOEDYMD"           TO  SPA-GMN-CUR
                   MOVE    "0010"                TO  SPA-ERRCD
                   GO                            TO  412-TOUROKU-EXT
               END-IF
           END-IF
      *
           IF  SPA-GMN-NAME                    =  SPACE
               MOVE    "NAME"                    TO  SPA-GMN-CUR
               MOVE    "0001"                    TO  SPA-ERRCD
               GO                                TO  412-TOUROKU-EXT
           END-IF
      *
           MOVE    "0002"                        TO  SPA-ZIDCD
           .    
       412-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       4121-TOUROKU-SEC                          SECTION.
      *
      *
      *    改正時処理
           IF  SPA-Z01-SYORIKBN                  =  3
      *
      *        データＵＰＤＡＴＥ
               INITIALIZE                        TNS-TENSU-REC
      *
               MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
               MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOSTYMD
               MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                  TO  TNS-YUKOEDYMD
               PERFORM  811-TENSUSEL-SEC
      *
               IF  MCP-RC                        =   ZERO
                   PERFORM  812-TENSUFET-SEC
                   IF  MCP-RC                    =   ZERO
                       MOVE  MCPDATA-REC         TO  TNS-TENSU-REC
                       MOVE  SPA-NAI-YUKOSTYMD TO  WRK-LNKYMD
                       PERFORM  833-YMDCONV61-SEC
                       IF  STS-DAY-RC1            =  ZERO
                           MOVE  WRK-SYMD        TO  TNS-YUKOEDYMD
                       ELSE
                           MOVE    "YUKOSTYMD"   TO  SPA-GMN-CUR
                           MOVE    "0004"        TO  SPA-ERRCD
                          GO                     TO  4121-TOUROKU-EXT
                       END-IF
                       MOVE  SPA-Z01-SRYCD       TO  TNSUP-SRYCD
                       MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOSTYMD
                       MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOEDYMD
                       PERFORM  815-TENSUUPD-SEC
                       IF  MCP-RC          NOT   =   ZERO
                           MOVE    "B12"         TO  SPA-GMN-CUR
                           MOVE    "0009"        TO  SPA-ERRCD
                           PERFORM  813-TENSUCLS-SEC
                           GO                    TO  4121-TOUROKU-EXT
                       END-IF
                   ELSE
                       MOVE    "B12"             TO  SPA-GMN-CUR
                       MOVE    "0009"            TO  SPA-ERRCD
                       PERFORM  813-TENSUCLS-SEC
                       GO                        TO  4121-TOUROKU-EXT
                   END-IF
               ELSE
                   MOVE    "B12"                 TO  SPA-GMN-CUR
                   MOVE    "0009"                TO  SPA-ERRCD
                   PERFORM  813-TENSUCLS-SEC
                   GO                            TO  4121-TOUROKU-EXT
               END-IF
               PERFORM  813-TENSUCLS-SEC
           END-IF
      *
      *　  登録処理
           IF  SPA-Z01-SYORIKBN                  =  2
      *        データＵＰＤＡＴＥ
               INITIALIZE                        TNS-TENSU-REC
      *
               MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
               MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOSTYMD
               MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                  TO  TNS-YUKOEDYMD
               PERFORM  811-TENSUSEL-SEC
      *
               IF  MCP-RC                        =   ZERO
                   PERFORM  812-TENSUFET-SEC
                   IF  MCP-RC                    =   ZERO
                       MOVE  MCPDATA-REC         TO  TNS-TENSU-REC
                       MOVE  SPA-NAI-YUKOSTYMD   TO  TNS-YUKOSTYMD
                       MOVE  SPA-NAI-YUKOEDYMD   TO  TNS-YUKOEDYMD
                       PERFORM  4121-KOUMOKUISO-SEC
                       MOVE  SPA-Z01-SRYCD       TO  TNSUP-SRYCD
                       MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOSTYMD
                       MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOEDYMD
                       PERFORM  815-TENSUUPD-SEC
                       IF  MCP-RC          NOT   =   ZERO
                           DISPLAY "Z04 UPD ERR:"    MCP-RC
                                            ",KEY:"  TNSUP-KEY
                           MOVE    "B12"         TO  SPA-GMN-CUR
                           MOVE    "0009"        TO  SPA-ERRCD
                           PERFORM  813-TENSUCLS-SEC
                           GO                    TO  4121-TOUROKU-EXT
                       END-IF
                   ELSE
                       DISPLAY "Z04 FETHCH ERR:"    MCP-RC
                                            ",KEY:"  TNSUP-KEY
                       MOVE    "B12"             TO  SPA-GMN-CUR
                       MOVE    "0009"            TO  SPA-ERRCD
                       PERFORM  813-TENSUCLS-SEC
                       GO                        TO  4121-TOUROKU-EXT
                   END-IF
               ELSE
                   DISPLAY "Z04 SELECT ERR:"    MCP-RC
                                            ",KEY:"  TNSUP-KEY
                   MOVE    "B12"                 TO  SPA-GMN-CUR
                   MOVE    "0009"                TO  SPA-ERRCD
                   PERFORM  813-TENSUCLS-SEC
                   GO                            TO  4121-TOUROKU-EXT
               END-IF
               PERFORM  813-TENSUCLS-SEC
           ELSE
      *        データＩＮＳＥＲＴ
               INITIALIZE                        TNS-TENSU-REC
               MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
               MOVE  SPA-NAI-YUKOSTYMD         TO  TNS-YUKOSTYMD
               MOVE  SPA-NAI-YUKOEDYMD         TO  TNS-YUKOEDYMD
               PERFORM  4121-KOUMOKUISO-SEC
               PERFORM  814-TENSUINS-SEC
               IF  MCP-RC                   NOT  =   ZERO
                   DISPLAY "Z04 INS ERR:"    MCP-RC
                                            ",KEY:"  TNSUP-KEY
                   MOVE    "B12"                 TO  SPA-GMN-CUR
                   MOVE    "0009"                TO  SPA-ERRCD
                   GO                            TO  4121-TOUROKU-EXT
               END-IF
           END-IF
      *
      *    点数マスタ付加情報更新
           PERFORM 4129-TENSUPLUS-UPD-SEC
      *
      *    入力コード更新
           CALL    "ORCGZS01"          USING
                                       MCPAREA
                                       SPAAREA
           IF      SPA-ERRCD           NOT =   SPACE
                 GO                    TO  4121-TOUROKU-EXT
           END-IF
      *    前画面に戻る
           MOVE    "JOIN"          TO  MCP-PUTTYPE
           PERFORM  401-BACK-SEC
           .
       4121-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       4121-KOUMOKUISO-SEC                       SECTION.
      *
           MOVE  SPA-GMN-KANANAME              TO  TNS-KANANAME
                                                   WRK-STRINGTBL
           MOVE  100                           TO  CNT-STRING
           PERFORM  891-STRCOUNT-SEC
           MOVE  CNT-STRING                    TO  TNS-KANAYUKOKETA
           MOVE  SPA-GMN-NAME                  TO  TNS-NAME
                                                   WRK-STRINGTBL
           MOVE  100                           TO  CNT-STRING
           PERFORM  891-STRCOUNT-SEC
           MOVE  CNT-STRING                    TO  TNS-YUKOKETA
      *
           MOVE  SPA-GMN-FORMALNAME            TO  TNS-FORMALNAME
                                                   WRK-STRINGTBL
           MOVE  200                           TO  CNT-STRING
           PERFORM 891-STRCOUNT-SEC
           MOVE  CNT-STRING                    TO  TNS-FORMALYUKOKETA
      *
           MOVE  SPA-GMN-TEN                   TO  TNS-TEN
      *
           MOVE  SPA-GMN-TENSIKIBETU           TO  TNS-TENSIKIBETU
           MOVE  SPA-GMN-OLDTEN                TO  TNS-OLDTEN
           MOVE  SPA-GMN-OLDTENSKB             TO  TNS-OLDTENSKB
           MOVE  SPA-GMN-TANICD                TO  TNS-TANICD
      ***  MOVE  SPA-GMN-TANINAME              TO  TNS-TANINAME
           MOVE  SPA-GMN-TANICDMEI             TO  TNS-TANINAME
           MOVE  SPA-GMN-MADOKUKBN             TO  TNS-MADOKUKBN
           MOVE  SPA-GMN-SINKEIHAKAIKBN        TO  TNS-SINKEIHAKAIKBN
           MOVE  SPA-GMN-SEIBUTUGAKUKBN        TO  TNS-SEIBUTUGAKUKBN
           MOVE  SPA-GMN-ZOEIZAIKBN            TO  TNS-ZOEIZAIKBN
           MOVE  SPA-GMN-CSYYOURYO             TO  TNS-CSYYOURYO
           MOVE  SPA-GMN-YKZKBN                TO  TNS-YKZKBN
           MOVE  SPA-GMN-ZAIGATAKBN            TO  TNS-ZAIGATAKBN
           MOVE  SPA-GMN-KOUHATUKBN            TO  TNS-KOUHATUKBN
           MOVE  SPA-GMN-LONGTOYOKBN           TO  TNS-LONGTOYOKBN
           MOVE  SPA-GMN-KOUHYOJYUNNUM         TO  TNS-KOUHYOJYUNNUM
           MOVE  SPA-GMN-YAKKAKJNCD            TO  TNS-YAKKAKJNCD
           MOVE  SPA-GMN-SYUSAISKB             TO  TNS-SYUSAISKB
           MOVE  SPA-GMN-SYOMEIKANREN          TO  TNS-SYOMEIKANREN
           MOVE  SPA-NAI-KEIKASOCHIYMD         TO  TNS-KEIKASOCHIYMD
      *
           .
      *
       4121-KOUMOKUISO-EXT.
           EXIT.
      *
      *****************************************************************
      *     点数マスタ付加情報更新処理
      *****************************************************************
       4129-TENSUPLUS-UPD-SEC                       SECTION.
      *
      *    点数マスタ付加情報検索
           IF      SPA-Z01-SYORIKBN    =   2  OR  3
               MOVE    SPACE               TO  TENSUPLUS-REC
               MOVE    SPA-Z01-SRYCD       TO  TNSP-SRYCD
               MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                           TO  TNSP-YUKOSTYMD
               MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                           TO  TNSP-YUKOEDYMD
      *
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC               =   ZERO
                   MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
                   PERFORM 990-TENSUPLUS-READ-SEC
               ELSE
                   MOVE    1               TO  FLG-TENSUPLUS
               END-IF
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           END-IF
      *
      *    有効期限更新
           IF      FLG-TENSUPLUS       =   ZERO
               EVALUATE    SPA-Z01-SYORIKBN
                   WHEN    3
      *                改正時処理
                       MOVE    WRK-SYMD            TO  TNSP-YUKOEDYMD
      *
                       MOVE    SPA-Z01-SRYCD       TO  TNSPUP-SRYCD
                       MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOSTYMD
                       MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOEDYMD
                       MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "TENSUPLUS-UPD1"    TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC           NOT =   ZERO
                           MOVE    "0016"          TO  SPA-ERRCD
                           GO      TO      4129-TENSUPLUS-UPD-EXT
                       END-IF
                   WHEN    2
      *                更新時処理
                       MOVE    SPA-NAI-YUKOSTYMD   TO  TNSP-YUKOSTYMD
                       MOVE    SPA-NAI-YUKOEDYMD   TO  TNSP-YUKOEDYMD
                       PERFORM 41291-TENSUPLUS-HEN-SEC
      *
                       MOVE    SPA-Z01-SRYCD       TO  TNSPUP-SRYCD
                       MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOSTYMD
                       MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOEDYMD
                       MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "TENSUPLUS-UPD1"    TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC           NOT =   ZERO
                           MOVE    "0016"          TO  SPA-ERRCD
                           GO      TO      4129-TENSUPLUS-UPD-EXT
                       END-IF
               END-EVALUATE
           END-IF
      *
      *    新規追加
           IF     (FLG-TENSUPLUS       =   1   )  OR
                  (SPA-Z01-SYORIKBN    =   3  OR  1 )
               INITIALIZE                      TENSUPLUS-REC
               MOVE    SPA-Z01-SRYCD       TO  TNSP-SRYCD
               MOVE    SPA-NAI-YUKOSTYMD   TO  TNSP-YUKOSTYMD
               MOVE    SPA-NAI-YUKOEDYMD   TO  TNSP-YUKOEDYMD
               PERFORM 41291-TENSUPLUS-HEN-SEC
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC             NOT  =   ZERO
                   MOVE    "B12"          TO  SPA-GMN-CUR
                   MOVE    "0016"         TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       4129-TENSUPLUS-UPD-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *  点数マスタ付加情報編集
      *****************************************************************
       41291-TENSUPLUS-HEN-SEC          SECTION.
      *
           MOVE  SPA-GMN-SHONAME               TO  TNSP-SHONAME
                                                   WRK-STRINGTBL
           MOVE  100                           TO  CNT-STRING
           PERFORM  891-STRCOUNT-SEC
           MOVE  CNT-STRING                    TO  TNSP-SHOYUKOKETA
      *
           MOVE  SPA-GMN-INPCHKKBN             TO  TNSP-INPCHKKBN
           .
       41291-TENSUPLUS-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *  　項目別エラーチェック
      *****************************************************************
       500-ERRCHK-SEC                            SECTION.
      *
           EVALUATE  TRUE
      *        有効開始年月日チェック
               WHEN  MCP-WIDGET = "YUKOSTYMD"    OR CNT-ERRCHK = 1
                   PERFORM  501-YUKOSTYMDCHK-SEC
      *        有効終了年月日チェック
               WHEN  MCP-WIDGET = "YUKOEDYMD"    OR CNT-ERRCHK = 2
                   PERFORM  502-YUKOEDYMDCHK-SEC
      *        カナ名称チェック
               WHEN  MCP-WIDGET = "KANANAME"     OR CNT-ERRCHK = 3
                   MOVE    "NAME"              TO  SPA-GMN-CUR
                   MOVE    Z04-KANANAME        TO  SPA-GMN-KANANAME
                   MOVE    SPA-GMN-KANANAME    TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   MOVE    WRK-OUT-INPUT       TO  SPA-GMN-KANANAME
                   IF      SPA-ERRCD       NOT =   SPACE
                       MOVE    "KANANAME"          TO  SPA-GMN-CUR
                   END-IF
      *        名称チェック
               WHEN  MCP-WIDGET = "NAME"         OR CNT-ERRCHK = 4
                   MOVE    "FORMALNAME"        TO  SPA-GMN-CUR
                   MOVE    Z04-NAME            TO  SPA-GMN-NAME
                   MOVE    SPA-GMN-NAME        TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   MOVE    WRK-OUT-INPUT       TO  SPA-GMN-NAME
                   IF      SPA-ERRCD       NOT =   SPACE
                       MOVE    "NAME"          TO  SPA-GMN-CUR
                   END-IF
      *        処方名称
               WHEN  MCP-WIDGET = "SHONAME"      OR CNT-ERRCHK = 5
                   MOVE    "TEN"               TO  SPA-GMN-CUR
                   MOVE    Z04-SHONAME         TO  SPA-GMN-SHONAME
                   MOVE    SPA-GMN-SHONAME     TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   MOVE    WRK-OUT-INPUT       TO  SPA-GMN-SHONAME
                   IF      SPA-ERRCD       NOT =   SPACE
                       MOVE    "SHONAME"           TO  SPA-GMN-CUR
                   END-IF
      *        金額
               WHEN  MCP-WIDGET = "TEN"          OR CNT-ERRCHK = 6
                   MOVE  "TENSIKIBETU"       TO  SPA-GMN-CUR
                   MOVE  Z04-TEN             TO  SPA-GMN-TEN
      *        金額種別
               WHEN  MCP-WIDGET = "TENSIKIBETU"  OR CNT-ERRCHK = 7
                   MOVE  "TENSIKIBETU"       TO  SPA-GMN-CUR
                   MOVE  Z04-TENSIKIBETU     TO  SPA-GMN-TENSIKIBETU-G
                   IF      SPA-GMN-TENSIKIBETUMEI    =   SPACE
                       MOVE    "0017"             TO  SPA-ERRCD
                   ELSE    
                       MOVE  "OLDTEN"        TO  SPA-GMN-CUR
                   END-IF    
      *        旧金額
               WHEN  MCP-WIDGET = "OLDTEN"       OR CNT-ERRCHK = 8
                   MOVE  "OLDTENSKB"         TO  SPA-GMN-CUR
                   MOVE  Z04-OLDTEN          TO  SPA-GMN-OLDTEN
      *        旧金額種別
               WHEN  MCP-WIDGET = "OLDTENSKB"    OR CNT-ERRCHK = 9
                   MOVE  "OLDTENSKB"         TO  SPA-GMN-CUR
                   MOVE  Z04-OLDTENSKB       TO  SPA-GMN-OLDTENSKB-G
                   IF      SPA-GMN-OLDTENSKBMEI  =   SPACE
                       MOVE    "0018"             TO  SPA-ERRCD
                   ELSE    
                       MOVE  "TANICD"        TO  SPA-GMN-CUR
                   END-IF    
      *        単位コード
               WHEN  MCP-WIDGET = "TANICD"       OR CNT-ERRCHK = 10
                   PERFORM 5012-TANICD-CHK-SEC
      *****    単位コード
      *****    WHEN  MCP-WIDGET = "TANINAME"     OR CNT-ERRCHK = 24
      *****        MOVE  "MADOKUKBN"         TO  SPA-GMN-CUR
      *****        MOVE  Z04-TANINAME        TO  SPA-GMN-TANINAME
      *        麻毒
               WHEN  MCP-WIDGET = "MADOKUKBN"    OR CNT-ERRCHK = 11
                   MOVE  "MADOKUKBN"         TO  SPA-GMN-CUR
                   MOVE  Z04-MADOKUKBN       TO  SPA-GMN-MADOKUKBN-G
                   IF      SPA-GMN-MADOKUKBNMEI  =   SPACE
                       MOVE    "0019"            TO  SPA-ERRCD
                   ELSE    
                       MOVE  "SINKEIHAKAIKBN"    TO  SPA-GMN-CUR
                   END-IF    
      *        神経破壊剤
               WHEN  MCP-WIDGET = "SINKEIHAKAIKBN"  OR CNT-ERRCHK = 12
                   MOVE  "SINKEIHAKAIKBN"    TO  SPA-GMN-CUR
                   MOVE  Z04-SINKEIHAKAIKBN  TO 
                                             SPA-GMN-SINKEIHAKAIKBN-G
                   IF      SPA-GMN-SINKEIHAKAIKBNMEI  =   SPACE
                       MOVE    "0020"            TO  SPA-ERRCD
                   ELSE    
                       MOVE  "SEIBUTUGAKUKBN"    TO  SPA-GMN-CUR
                   END-IF    
      *        生物学的区分
               WHEN  MCP-WIDGET = "SEIBUTUGAKUKBN"  OR CNT-ERRCHK = 13
                   MOVE  "SEIBUTUGAKUKBN"        TO  SPA-GMN-CUR
                   MOVE  Z04-SEIBUTUGAKUKBN      TO
                                             SPA-GMN-SEIBUTUGAKUKBN-G
                   IF      SPA-GMN-SEIBUTUGAKUKBNMEI  =   SPACE
                       MOVE    "0021"            TO  SPA-ERRCD
                   ELSE    
                       MOVE  "ZOEIZAIKBN"        TO  SPA-GMN-CUR
                   END-IF    
      *        造影剤
               WHEN  MCP-WIDGET = "ZOEIZAIKBN"   OR CNT-ERRCHK = 14
                   MOVE  "ZOEIZAIKBN"          TO  SPA-GMN-CUR
                   MOVE  Z04-ZOEIZAIKBN        TO  SPA-GMN-ZOEIZAIKBN-G
                   IF      SPA-GMN-ZOEIZAIKBNMEI =   SPACE
                       MOVE    "0022"          TO  SPA-ERRCD
                   ELSE    
                       MOVE  "CSYYOURYO"       TO  SPA-GMN-CUR
                   END-IF    
      *        注射容量
               WHEN  MCP-WIDGET = "CSYYOURYO"    OR CNT-ERRCHK = 15
                   MOVE  "YKZKBN"                TO  SPA-GMN-CUR
                   MOVE  Z04-CSYYOURYO           TO  SPA-GMN-CSYYOURYO
      *        薬剤
               WHEN  MCP-WIDGET = "YKZKBN"       OR CNT-ERRCHK = 16
                   MOVE  "YKZKBN"                TO  SPA-GMN-CUR
                   MOVE  Z04-YKZKBN              TO  SPA-GMN-YKZKBN-G
                   IF      SPA-GMN-YKZKBNMEI     =   SPACE
                       MOVE    "0023"            TO  SPA-ERRCD
                   ELSE    
                       MOVE  "ZAIGATAKBN"        TO  SPA-GMN-CUR
                   END-IF    
      *        剤型
               WHEN  MCP-WIDGET = "ZAIGATAKBN"   OR CNT-ERRCHK = 17
                   MOVE  "ZAIGATAKBN"          TO  SPA-GMN-CUR
                   MOVE  Z04-ZAIGATAKBN        TO  SPA-GMN-ZAIGATAKBN-G
                   IF      SPA-GMN-ZAIGATAKBNMEI =   SPACE
                       MOVE    "0024"          TO  SPA-ERRCD
                   ELSE    
                       MOVE  "LONGTOYOKBN"     TO  SPA-GMN-CUR
                   END-IF    
      *        長期投与
               WHEN  MCP-WIDGET = "LONGTOYOKBN"  OR CNT-ERRCHK = 18
                   MOVE  "KOUHATUKBN"        TO  SPA-GMN-CUR
                   MOVE  Z04-LONGTOYOKBN     TO  SPA-GMN-LONGTOYOKBN
      *        後発医薬品
               WHEN  MCP-WIDGET = "KOUHATUKBN"   OR CNT-ERRCHK = 27
                   MOVE  "KOUHATUKBN"          TO  SPA-GMN-CUR
                   MOVE  Z04-KOUHATUKBN        TO  SPA-GMN-KOUHATUKBN-G
                   IF      SPA-GMN-KOUHATUKBNMEI =   SPACE
                       MOVE    "0025"          TO  SPA-ERRCD
                   ELSE    
                       MOVE  "KOUHYOJYUNNUM"     TO  SPA-GMN-CUR
                   END-IF    
      *        公表順序番号
               WHEN  MCP-WIDGET = "KOUHYOJYUNNUM"  OR CNT-ERRCHK = 19
                   MOVE  "YAKKAKJNCD"        TO  SPA-GMN-CUR
                   MOVE  Z04-KOUHYOJYUNNUM   TO  SPA-GMN-KOUHYOJYUNNUM
      *        薬価基準
               WHEN  MCP-WIDGET = "YAKKAKJNCD"   OR CNT-ERRCHK = 20
                   MOVE  "SYUSAISKB"             TO  SPA-GMN-CUR
                   MOVE  Z04-YAKKAKJNCD          TO  SPA-GMN-YAKKAKJNCD
      *        収載方式等識別
               WHEN  MCP-WIDGET = "SYUSAISKB"    OR CNT-ERRCHK = 21
                   MOVE  "SYOMEIKANREN"        TO  SPA-GMN-CUR
                   MOVE  Z04-SYUSAISKB         TO  SPA-GMN-SYUSAISKB
      *        商品名等関連
               WHEN  MCP-WIDGET = "SYOMEIKANREN" OR CNT-ERRCHK = 22
                   MOVE  "KEIKASOCHIYMD"       TO  SPA-GMN-CUR
                   MOVE  Z04-SYOMEIKANREN      TO  SPA-GMN-SYOMEIKANREN
      *        経過措置年月日
               WHEN  MCP-WIDGET = "KEIKASOCHIYMD" OR CNT-ERRCHK = 23
      *************MOVE  "B12"                 TO  SPA-GMN-CUR
                   MOVE  "INPCHKKBN"       TO  SPA-GMN-CUR
                   MOVE  Z04-KEIKASOCHIYMD TO  SPA-GMN-KEIKASOCHIYMD
                   PERFORM  523-KEIKASOCHIYMDCHK-SEC
      *        正式名称
               WHEN  MCP-WIDGET = "FORMALNAME"  OR CNT-ERRCHK = 25
                   MOVE  "SHONAME"              TO  SPA-GMN-CUR
                   MOVE  Z04-FORMALNAME         TO  SPA-GMN-FORMALNAME
                   MOVE    SPA-GMN-FORMALNAME   TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   MOVE    WRK-OUT-INPUT       TO  SPA-GMN-FORMALNAME
                   IF      SPA-ERRCD       NOT =   SPACE
                       MOVE    "FORMALNAME"        TO  SPA-GMN-CUR
                   END-IF
      *        入力チェック区分
               WHEN  MCP-WIDGET = "INPCHKKBN"   OR CNT-ERRCHK = 26
                   MOVE  "B12"                  TO  SPA-GMN-CUR
                   MOVE  Z04-INPCHKKBN          TO  SPA-GMN-INPCHKKBN
       END-EVALUATE.
      *
       500-ERRCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    半角チェック処理
      *****************************************************************
       400-ZENCHK-SEC             SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-MAE-INPUT       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
      *        全角半角混在エラー
               MOVE    "0030"              TO  SPA-ERRCD
               MOVE    WRK-MAE-INPUT       TO  WRK-OUT-INPUT 
           ELSE
               MOVE    KANACHK-OUT-INPUT   TO  WRK-OUT-INPUT 
           END-IF
           .
      *
       400-ZENCHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *  　有効開始年月日チェック
      *****************************************************************
       501-YUKOSTYMDCHK-SEC                      SECTION.
      *
           MOVE  "YUKOSTYMD"             TO  SPA-GMN-CUR
      *
           MOVE  Z04-YUKOSTYMD           TO  SPA-GMN-YUKOSTYMD
      *
           IF  SPA-GMN-YUKOSTYMD                 =  SPACE
               MOVE    "0000000"                 TO  SPA-GMN-YUKOSTYMD
           END-IF.
      *
           MOVE  SPA-GMN-YUKOSTYMD               TO  WRK-LNKYMD
           PERFORM  831-YMDCONV12-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-SYMD            TO  SPA-NAI-YUKOSTYMD
               MOVE    WRK-LNKYMD          TO  SPA-GMN-YUKOSTYMD
           ELSE
                GO      TO      501-YUKOSTYMDCHK-EXT
           END-IF
      *****IF  STS-DAY-RC1                       =  ZERO
      *         MOVE  WRK-SYMD                   TO  SPA-NAI-YUKOSTYMD
      *    ELSE
      *         MOVE    "0004"                   TO  SPA-ERRCD
      *         GO      TO      501-YUKOSTYMDCHK-EXT
      *    END-IF
      *
      *    MOVE  SPA-NAI-YUKOSTYMD               TO  WRK-LNKYMD
      *    PERFORM  832-YMDCONV21-SEC
      *****MOVE  WRK-HENYMDG                     TO  SPA-GMN-YUKOSTYMD
      *
           MOVE  "YUKOEDYMD"             TO  SPA-GMN-CUR
           .
      *
       501-YUKOSTYMDCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　有効終了年月日チェック
      *****************************************************************
       502-YUKOEDYMDCHK-SEC                      SECTION.
      *
           MOVE  "YUKOEDYMD"                     TO  SPA-GMN-CUR
      *
           MOVE  Z04-YUKOEDYMD                   TO  SPA-GMN-YUKOEDYMD
      *
           IF  SPA-GMN-YUKOEDYMD                 =  SPACE
               MOVE   "9999999"                  TO  SPA-GMN-YUKOEDYMD
           END-IF.
      *
           MOVE  SPA-GMN-YUKOEDYMD               TO  WRK-LNKYMD
           PERFORM  831-YMDCONV12-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-SYMD            TO  SPA-NAI-YUKOEDYMD
               MOVE    WRK-LNKYMD          TO  SPA-GMN-YUKOEDYMD
           ELSE
               GO      TO      502-YUKOEDYMDCHK-EXT
           END-IF
      *****IF  STS-DAY-RC1                 =  ZERO
      *        MOVE  WRK-SYMD              TO  SPA-NAI-YUKOEDYMD
      *    ELSE
      *        MOVE    "0004"              TO  SPA-ERRCD
      *        GO                          TO  502-YUKOEDYMDCHK-EXT
      *    END-IF
      *
      *    MOVE  SPA-NAI-YUKOEDYMD         TO  WRK-LNKYMD
      *    PERFORM  832-YMDCONV21-SEC
      *****MOVE  WRK-HENYMDG               TO  SPA-GMN-YUKOEDYMD
      *
           MOVE  "KANANAME"              TO  SPA-GMN-CUR
           .
      *
       502-YUKOEDYMDCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　経過措置年月日チェック
      *****************************************************************
       523-KEIKASOCHIYMDCHK-SEC                  SECTION.
      *
           IF    SPA-GMN-KEIKASOCHIYMD   =  SPACE
               MOVE  ZERO            TO  SPA-GMN-KEIKASOCHIYMD(1:7)
               MOVE  ZERO            TO  SPA-NAI-KEIKASOCHIYMD
           ELSE
               MOVE  SPA-GMN-KEIKASOCHIYMD     TO  WRK-LNKYMD
               PERFORM  831-YMDCONV12-SEC
               IF      SPA-ERRCD           =   SPACE
                   MOVE    WRK-SYMD        TO  SPA-NAI-KEIKASOCHIYMD
                   MOVE    WRK-LNKYMD      TO  SPA-GMN-KEIKASOCHIYMD
               ELSE
                   MOVE    "KEIKASOCHIYMD"       TO  SPA-GMN-CUR
                   GO      TO      523-KEIKASOCHIYMDCHK-EXT
               END-IF
      *********IF  STS-DAY-RC1                   =  ZERO
      *            MOVE  WRK-SYMD          TO  SPA-NAI-KEIKASOCHIYMD
      *        ELSE
      *            MOVE    "KEIKASOCHIYMD" TO  SPA-GMN-CUR
      *            MOVE    "0004"          TO  SPA-ERRCD
      *            GO                      TO  523-KEIKASOCHIYMDCHK-EXT
      *        END-IF
      *        MOVE  SPA-NAI-KEIKASOCHIYMD TO  WRK-LNKYMD
      *        PERFORM  832-YMDCONV21-SEC
      *********MOVE  WRK-HENYMDG           TO  SPA-GMN-KEIKASOCHIYMD
           END-IF
           .
      *
       523-KEIKASOCHIYMDCHK-EXT.
           EXIT.
      *        
      *****************************************************************
      *  　単位コードチェック
      *****************************************************************
       5012-TANICD-CHK-SEC                      SECTION.
      *
           MOVE    "TANICD"            TO  SPA-GMN-CUR
           MOVE    Z04-TANICD          TO  SPA-GMN-TANICD-G
      *
           IF      SPA-GMN-TANICD      =   SPACE
               MOVE    ZERO            TO  SPA-GMN-TANICD
           END-IF
      *
           IF      SPA-GMN-TANICDMEI   =   SPACE
               MOVE    "0013"              TO  SPA-ERRCD
           ELSE
      *****    MOVE    "TANINAME"          TO  SPA-GMN-CUR
               MOVE    "MADOKUKBN"         TO  SPA-GMN-CUR
           END-IF
           .
      *
       5012-TANICD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN-SEC             SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-ZIDCD       NOT =   SPACE
               PERFORM 520-ZIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE  SPA-GMN-CUR           TO  MCP-WIDGET
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "Z04    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面セット処理
      *****************************************************************
       500-GMNHEN-SEC                            SECTION.
      *     画面ワークエリアにセット
           INITIALIZE                  Z04.
      *
           MOVE  SPA-GMN-SRYCDH        TO  Z04-SRYCDH
           MOVE  SPA-GMN-NAMEH         TO  Z04-NAMEH
           MOVE  SPA-GMN-YUKOSTYMDH    TO  Z04-YUKOSTYMDH
           MOVE  SPA-GMN-YUKOEDYMDH    TO  Z04-YUKOEDYMDH
      *                                         
           MOVE  SPA-GMN-YUKOSTYMD     TO  Z04-YUKOSTYMD
           MOVE  SPA-GMN-YUKOEDYMD     TO  Z04-YUKOEDYMD
           MOVE  SPA-GMN-KANANAME      TO  Z04-KANANAME
           MOVE  SPA-GMN-NAME          TO  Z04-NAME
           MOVE  SPA-GMN-FORMALNAME    TO  Z04-FORMALNAME
           MOVE  SPA-GMN-SHONAME       TO  Z04-SHONAME
           MOVE  SPA-GMN-TEN           TO  Z04-TEN
           MOVE  SPA-GMN-TENSIKIBETU-G TO  Z04-TENSIKIBETU
           MOVE  SPA-GMN-OLDTEN        TO  Z04-OLDTEN
           MOVE  SPA-GMN-OLDTENSKB-G   TO  Z04-OLDTENSKB
           MOVE  SPA-GMN-TANICD-G      TO  Z04-TANICD
      **** MOVE  SPA-GMN-TANINAME      TO  Z04-TANINAME
           MOVE  SPA-GMN-MADOKUKBN-G   TO  Z04-MADOKUKBN
           MOVE  SPA-GMN-SINKEIHAKAIKBN-G
                                       TO  Z04-SINKEIHAKAIKBN
           MOVE  SPA-GMN-SEIBUTUGAKUKBN-G
                                       TO  Z04-SEIBUTUGAKUKBN
           MOVE  SPA-GMN-ZOEIZAIKBN-G  TO  Z04-ZOEIZAIKBN
           MOVE  SPA-GMN-CSYYOURYO     TO  Z04-CSYYOURYO
           MOVE  SPA-GMN-YKZKBN-G      TO  Z04-YKZKBN
           MOVE  SPA-GMN-ZAIGATAKBN-G  TO  Z04-ZAIGATAKBN
      *    後発医薬品
           MOVE  SPA-GMN-KOUHATUKBN-G  TO  Z04-KOUHATUKBN
           MOVE  SPA-GMN-LONGTOYOKBN   TO  Z04-LONGTOYOKBN
           MOVE  SPA-GMN-KOUHYOJYUNNUM TO  Z04-KOUHYOJYUNNUM
           MOVE  SPA-GMN-YAKKAKJNCD    TO  Z04-YAKKAKJNCD
           MOVE  SPA-GMN-SYUSAISKB     TO  Z04-SYUSAISKB
           MOVE  SPA-GMN-SYOMEIKANREN  TO  Z04-SYOMEIKANREN
           MOVE  SPA-GMN-KEIKASOCHIYMD TO  Z04-KEIKASOCHIYMD
      *     
           PERFORM VARYING IDXX    FROM    1   BY  1
                   UNTIL   IDXX    >       3
               MOVE    SPA-GMN-TENSIKIBETULST (IDXX)
                                       TO  Z04-TENSIKIBETULST   (IDXX)
           END-PERFORM
           MOVE    3                   TO  Z04-TENSIKIBETU-COUNT
           PERFORM VARYING IDXX    FROM    1   BY  1
                   UNTIL   IDXX    >       3
               MOVE    SPA-GMN-OLDTENSKBLST(IDXX)
                                       TO  Z04-OLDTENSKBLST (IDXX)
           END-PERFORM    
           MOVE    3                   TO  Z04-OLDTENSKB-COUNT
      *
           MOVE    ZERO                TO  IDX
           PERFORM VARYING IDXX    FROM    1   BY  1
      ************ UNTIL   IDXX    >       59
                   UNTIL   IDXX    >       90
               IF      SPA-GMN-TANICDLST(IDXX)  NOT =   SPACE
                   ADD     1               TO  IDX
                   MOVE    SPA-GMN-TANICDLST(IDXX)
                                           TO  Z04-TANICDLST   (IDX)
                   MOVE    IDX             TO  Z04-TANICD-COUNT
               END-IF
           END-PERFORM
      *
           PERFORM VARYING IDXX    FROM    1   BY  1
                   UNTIL   IDXX    >       5
               MOVE    SPA-GMN-MADOKUKBNLST (IDXX)
                                       TO  Z04-MADOKUKBNLST   (IDXX)
           END-PERFORM
           MOVE    5                   TO  Z04-MADOKUKBN-COUNT 
           PERFORM VARYING IDXX    FROM    1   BY  1
                   UNTIL   IDXX    >       2
               MOVE    SPA-GMN-SINKEIHAKAIKBNLST(IDXX)
                                       TO  Z04-SINKEIHAKAIKBNLST (IDXX)
           END-PERFORM    
           MOVE    2                   TO  Z04-SINKEIHAKAIKBN-COUNT
           PERFORM VARYING IDXX    FROM    1   BY  1
                   UNTIL   IDXX    >       2
               MOVE    SPA-GMN-SEIBUTUGAKUKBNLST(IDXX)
                                       TO  Z04-SEIBUTUGAKUKBNLST(IDXX)
           END-PERFORM    
           MOVE    2                   TO  Z04-SEIBUTUGAKUKBN-COUNT
           PERFORM VARYING IDXX    FROM    1   BY  1
                   UNTIL   IDXX    >       3
               MOVE    SPA-GMN-ZOEIZAIKBNLST (IDXX)
                                       TO  Z04-ZOEIZAIKBNLST   (IDXX)
           END-PERFORM
           MOVE    3                   TO  Z04-ZOEIZAIKBN-COUNT 
           PERFORM VARYING IDXX    FROM    1   BY  1
                   UNTIL   IDXX    >       6
               MOVE    SPA-GMN-YKZKBNLST(IDXX)
                                       TO  Z04-YKZKBNLST (IDXX)
           END-PERFORM    
           MOVE    6                   TO  Z04-YKZKBN-COUNT 
           PERFORM VARYING IDXX    FROM    1   BY  1
                   UNTIL   IDXX    >       4
               MOVE    SPA-GMN-ZAIGATAKBNLST(IDXX)
                                       TO  Z04-ZAIGATAKBNLST   (IDXX)
           END-PERFORM    
           MOVE    4                   TO  Z04-ZAIGATAKBN-COUNT
      *    後発医薬品
           PERFORM VARYING IDXX    FROM    1   BY  1
                   UNTIL   IDXX    >       2
               MOVE    SPA-GMN-KOUHATUKBNLST(IDXX)
                                       TO  Z04-KOUHATUKBN-ITEM  (IDXX)
           END-PERFORM
           MOVE    2                   TO  Z04-KOUHATUKBN-COUNT
      *
           MOVE  SPA-GMN-INPCHKKBN     TO  Z04-INPCHKKBN
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
      **     EVALUATE    SPA-GMN-CUR
      **          WHEN   1
      **              MOVE  "STYUKYMD"   TO  MCP-WIDGET
      **     END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示処理
      *****************************************************************
       510-ERRSET-SEC                            SECTION.
           MOVE    SPACE                         TO  SPA-ERRMSG.
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "漢字名称を入力してください"
                                                 TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "数字のみ入力可能です"
                                                 TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "　"
                                                 TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "投入された年月日に誤りがあります"
                                                 TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "年月日の大小関係に誤りがあります"
                                                 TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "有効年月日を入力してください"
                                                 TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "有効年月日が重複しています"
                                                 TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "登録処理が失敗しました"
                                                 TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "改正の終了年月日はＡＬＬ９のみ入力できます"
                                                 TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE    "単位の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0015"
                   MOVE    "削除処理が失敗しました"
                                                 TO  SPA-ERRMSG
               WHEN    "0016"
                   MOVE    "点数マスタ付加情報が更新できません"
                                                 TO  SPA-ERRMSG
               WHEN    "0017"
                   MOVE    "金額種別の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0018"
                   MOVE    "旧金額種別の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0019"
                   MOVE    "麻毒の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0020"
                   MOVE    "神経破壊剤の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0021"
                   MOVE    "生物学的製剤の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0022"
                   MOVE    "造影剤の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0023"
                   MOVE    "薬剤の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0024"
                   MOVE    "剤型の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0025"
                   MOVE    "後発医薬品の入力がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0030"
                   MOVE    "すべて全角で入力して下さい。"
                                                 TO  SPA-ERRMSG
           END-EVALUATE.
      *
           MOVE    SPACE                         TO  ZERR
           MOVE    SPA-ERRCD                     TO  ZERR-ERRCODE
           MOVE    SPA-ERRMSG                TO  ZERR-ERRMSG
      *
           MOVE    "Z04"                         TO  SPA-MOTOPG
           MOVE    "ZERR"                        TO  SPA-SAKIPG
      *
           MOVE    "NEW"                         TO  MCP-PUTTYPE
           MOVE    "ZERR"                        TO  MCP-WINDOW
           MOVE    "B01"                         TO  MCP-WIDGET
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                             TO  FLG-END
           .    
      *
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-ZIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-ZIDMSG
      *
           EVALUATE    SPA-ZIDCD
               WHEN    "0001"
                   MOVE    "削除します。よろしいですか？"
                                                       TO  WRK-ZIDMSG
               WHEN    "0002"
                   MOVE    "更新します。よろしいですか？"
                                                       TO  WRK-ZIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  ZID1
           MOVE    SPA-ZIDCD            TO  ZID1-ID1CODE
           MOVE    WRK-ZIDMSG           TO  ZID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "Z04"                TO  SPA-MOTOPG
           MOVE    "ZID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "ZID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END 
      *
           .
       520-ZIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　処理
      *****************************************************************
      *
      *****************************************************************
      *    点数マスタＳＥＬＥＣＴ処理（診療行為、有効期間）
      *****************************************************************
       811-TENSUSEL-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  TNS-YUKOSTYMD               TO  ORC-DBYMD
           MOVE  "DBSELECT"                  TO  MCP-FUNC
           MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                 USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
           .
      *
       811-TENSUSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＦＥＴＣＨ処理（診療行為、有効期間）
      *****************************************************************
       812-TENSUFET-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBFETCH"                   TO  MCP-FUNC
           MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                 USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
           .
      *
       812-TENSUFET-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＣＬＯＳＥ処理（診療行為、有効期間）
      *****************************************************************
       813-TENSUCLS-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBCLOSE"                   TO  MCP-FUNC
           MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           .
      *
       813-TENSUCLS-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＩＮＳ処理
      *****************************************************************
       814-TENSUINS-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBINSERT"                  TO  MCP-FUNC
           MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           .
      *
       814-TENSUINS-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＵＰＤ処理
      *****************************************************************
       815-TENSUUPD-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBUPDATE"                  TO  MCP-FUNC
           MOVE  "TENSU-UPD1"                TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           .
      *
       815-TENSUUPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＤＥＬ処理
      *****************************************************************
       816-TENSUDEL-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBDELETE"                  TO  MCP-FUNC
           MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           .
      *
       816-TENSUDEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ付加情報読込
      *****************************************************************
       990-TENSUPLUS-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TENSUPLUS-REC
               MOVE    ZERO            TO  FLG-TENSUPLUS
           ELSE
               INITIALIZE                  TENSUPLUS-REC
               MOVE    1               TO  FLG-TENSUPLUS
           END-IF
           .
      *
       990-TENSUPLUS-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    日付変換　処理
      *****************************************************************
      *****************************************************************
      *     対象日＋１日計算処理
      *****************************************************************
       800-DAYSET-SEC                  SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           EVALUATE    WRK-YMD
               WHEN    ZERO
                   MOVE    ZERO            TO  WRK-OTYMD
               WHEN    "99999999"
                   MOVE    ALL "9"         TO  WRK-OTYMD
               WHEN    OTHER
                   INITIALIZE                  STS-AREA-DAY
                   INITIALIZE                  LNK-DAY6-AREA
                   MOVE    "61"                TO  LNK-DAY6-IRAI
                   MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
                   MOVE    "1"                 TO  LNK-DAY6-ZOGENPTN
                   MOVE    1                   TO  LNK-DAY6-ZOGEN
                   CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                  MOVE    LNK-DAY6-KEISAN      TO  WRK-OTYMD
           END-EVALUATE
      *
           .
       800-DAYSET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *   和暦年月日→西暦年月日（機能１２）
      *****************************************************************
       831-YMDCONV12-SEC                         SECTION.
      *
           INITIALIZE                            STS-AREA-DAY
           EVALUATE  WRK-LNKYMD(1:7)
               WHEN  ZERO
                   MOVE  ZERO                    TO  WRK-SYMD
               WHEN  "9999999"
                   MOVE  ALL "9"                 TO  WRK-SYMD
               WHEN  OTHER
      *
      ************IF  WRK-LNKYMD(1:7)           NOT NUMERIC
      *                MOVE    WRK-LNKYMD(1:1)   TO  WRK-WGO
      *                MOVE    WRK-LNKYMD(2:2)   TO  WRK-WYY
      *                MOVE    WRK-LNKYMD(5:2)   TO  WRK-WMM
      *                MOVE    WRK-LNKYMD(8:2)   TO  WRK-WDD
      *                INSPECT  WRK-WYMD  REPLACING   ALL " " BY  "0"
      *            ELSE
      *                MOVE    WRK-LNKYMD(1:7)   TO  WRK-WYMD
      *            END-IF
      *            INITIALIZE                    LNK-DAY1-AREA
      *            MOVE  "12"                    TO  LNK-DAY1-IRAI
      *            MOVE  ZERO                    TO  LNK-DAY1-YMD
      *            MOVE  WRK-WYMD                TO  LNK-DAY1-YMD(2:7)
      *            CALL  "ORCSDAY"               USING   STS-AREA-DAY
      *                                          LNK-DAY1-AREA
      *            IF      STS-DAY-RC1           =   ZERO
      *                MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
      *************END-IF
      *----(01.00.01) LINE ADD START --------------------------------
      *            日付画面チェックサブ
                   INITIALIZE                      ORCSGDAYAREA
                   MOVE    WRK-LNKYMD          TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"          USING
                                               ORCSGDAYAREA
                   IF      SGDAY-RC            =   ZERO
                       MOVE    SGDAY-OTDAY         TO  WRK-LNKYMD
                       MOVE    SGDAY-SDAY          TO  WRK-SYMD
                   ELSE
                       MOVE    "0004"              TO  SPA-ERRCD
                   END-IF
      *----(01.00.01) LINE ADD END   --------------------------------
           END-EVALUATE
           .
      *
       831-YMDCONV12-EXT.
           EXIT.
      *
      *****************************************************************
      *   西暦→和暦（機能２１）
      *****************************************************************
       832-YMDCONV21-SEC                          SECTION.
      *
      *
           INITIALIZE                            STS-AREA-DAY
           EVALUATE  WRK-LNKYMD(1:8)
               WHEN  ZERO 
               WHEN  "99999999"
                   MOVE    WRK-LNKYMD            TO  WRK-HENYMDG
               WHEN  OTHER
                  INITIALIZE                     STS-AREA-DAY
                  INITIALIZE                     LNK-DAY2-AREA
                  MOVE  "21"                     TO  LNK-DAY2-IRAI
                  MOVE  WRK-LNKYMD(1:8)          TO  LNK-DAY2-YMD
                  CALL  "ORCSDAY"                USING   STS-AREA-DAY
                                                 LNK-DAY2-AREA
                  MOVE    LNK-DAY2-EDTYMD1       TO  WRK-HENYMDG
           END-EVALUATE
           .
      *
       832-YMDCONV21-EXT.
           EXIT.
      *
      *****************************************************************
      *   西暦→日数１日マイナス（機能６１）
      *****************************************************************
       833-YMDCONV61-SEC                          SECTION.
      *
           INITIALIZE                            STS-AREA-DAY
           EVALUATE  WRK-LNKYMD(1:8)
               WHEN  ZERO
                   MOVE  ZERO                    TO  WRK-SYMD
               WHEN  "99999999"
                   MOVE  ALL "9"                 TO  WRK-SYMD
               WHEN  OTHER
                  INITIALIZE                     STS-AREA-DAY
                  INITIALIZE                     LNK-DAY6-AREA
                  MOVE  "61"                     TO  LNK-DAY6-IRAI
                  MOVE  WRK-LNKYMD(1:8)          TO  LNK-DAY6-KIJUN
                  MOVE  "1"                      TO  LNK-DAY6-ZOGENPTN
                  MOVE  -1                       TO  LNK-DAY6-ZOGEN
                  CALL  "ORCSDAY"                USING   STS-AREA-DAY
                                                 LNK-DAY6-AREA
                  MOVE    LNK-DAY6-KEISAN        TO  WRK-SYMD
           END-EVALUATE
           .
      *
       833-YMDCONV61-EXT.
           EXIT.
      *
      *****************************************************************
      *   文字数カウント処理（全角のみ）
      *****************************************************************
       891-STRCOUNT-SEC                         SECTION.
      *
           PERFORM  UNTIL  WRK-STRING(CNT-STRING)  NOT  =  SPACE
                    OR  CNT-STRING  =  1
               COMPUTE  CNT-STRING  =  CNT-STRING  -  1
           END-PERFORM
      *
           IF  CNT-STRING                        =  1
               MOVE  ZERO                        TO  CNT-STRING
           ELSE
               COMPUTE  CNT-STRING               =  CNT-STRING  /  2
           END-IF
           .
       891-STRCOUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW                            SECTION.
      *
           MOVE   "PUTWINDOW"                    TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                     USING  MCPAREA
                                                         ORCMCPAREA
                                                         MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
