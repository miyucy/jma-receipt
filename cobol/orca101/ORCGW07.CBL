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
       PROGRAM-ID.             ORCGW07.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 自動算定情報（Ｗ０７）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/06/05  薬剤情報提供料の追加
      *  01.00.02    MCC-藤原     01/09/11  削除処理の修正 
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.01.02    MCC-藤原     01/11/26  項目をコンボボックスに変更
      *  01.02.01    MCC-森脇     02/05/23  チェック機能制御情報の追加
      *  01.02.02    NACL-多々納  02/10/10  外来管理加算チェック追加
      *  01.02.03    NACL-多々納  02/10/31  外来管理加算チェック区分追加
      *  01.02.04    NACL-多々納  02/11/13  一括入力 
      *  01.02.05    NACL-多々納  02/11/20  チェック機能制御初期設定変更
      *  01.02.05    NACL-多々納  03/02/19  療養担当手当て追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
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
       01  SPA-W07.
           03  SPA-W07-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD       PIC X(09).
                   07  SPA-GMN-EDYUKYMD       PIC X(09).  
      *---- (01.02.01) LINE MOD START --------------------------------
                   07  SPA-GMN-PAGENO         PIC 9(01). 
      *
                   07  SPA-GMN-1007-AREA.           
      *---- (01.00.01) LINE MOD START --------------------------------
      ***              09  SPA-GMN-CHOKI          PIC 9(01).
                       09  SPA-GMN-DATA-TBL       OCCURS  5.
      *************        11  SPA-GMN-DATA       PIC 9(01).
      *---- (01.00.01) LINE MOD END   --------------------------------
                           11  SPA-GMN-DATA-G.
                               13  SPA-GMN-DATA       PIC X(01).
                               13  SPA-GMN-F1         PIC X(01).
                               13  SPA-GMN-DATAMEI    PIC X(10).
      *
                   07  SPA-GMN-1008-AREA.
      *                相互作用チェック期間
                       09  SPA-GMN-KIKAN               PIC 9(02).
      *                外来管理加算チェック
                       09  SPA-GMN-GAIKANRIKBN-G.
                           11  SPA-GMN-GAIKANRIKBN-CHK   PIC X(01).
                           11  SPA-GMN-GAIKANRIKBN-H     PIC X(01).
                           11  SPA-GMN-GAIKANRIKBN-MEI   PIC X(20).
                       09  SPA-GMN-GAIKANRIKBN-COMB.
                           11  SPA-GMN-GAIKANRIKBN-LIST  PIC X(22)
                                                         OCCURS  3.
      *
      *---- (01.02.01) LINE MOD END ----------------------------------
                   07  SPA-GMN-DATALST                    OCCURS  2.
                       09  SPA-GMN-DATAL      PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-DATAMEIL   PIC X(10).
                   07  SPA-GMN-DATA-MAX       PIC 9(02).    
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-STYUKYMD       PIC 9(08).
                   07  SPA-NAI-EDYUKYMD       PIC 9(08).
      *
           COPY    "ENUM-VALUE".
      *
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
      *
      *    カウント領域
      *
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
      *
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
      *
       01  WRK-AREA.
      *---- (01.00.01) LINE ADD START --------------------------------
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-WIDGET.
               05  WRK-WIDGET1     PIC X(04).
               05  WRK-WIDGET2     PIC X(02).
      *---- (01.00.01) LINE ADD END   --------------------------------
           03  WRK-WIDMSG          PIC X(70). 
           03  WRK-YMD             PIC X(09). 
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
           03  WRK-MCP-WIDGET      PIC X(64).
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
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    自動算定情報
           COPY  "CPSK1007.INC".
      *    チェック機能制御
           COPY  "CPSK1008.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
      *
           COPY  "CPORCSDAY.INC".
      *
           COPY  "CPORCSLNK.INC".
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
      *
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
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W98.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
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
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W07
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
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
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-W07         TO  SPA-FREE
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
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               PERFORM 510-GSRAUTH-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      * 
      ***  MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W07"                TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                    TO  FLG-END
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
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
               WHEN    "WID1"
                   PERFORM 330-WID1-SET-SEC
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
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF      SPA-WID1-FLG    =   "OK"
      *---- (01.05.01) LINE MOD START --------------------------------
               EVALUATE      SPA-WIDCD 
                   WHEN   "1001"
                       PERFORM  491-KOUSHIN-1007-SEC
                   WHEN   "1002"
                       PERFORM  4032-DEL-1007-SEC
                   WHEN   "1003"
                       PERFORM  491-KOUSHIN-1008-SEC
                   WHEN   "1004"
                       PERFORM  4032-DEL-1008-SEC
               END-EVALUATE
           ELSE
               EVALUATE    SPA-W01-KANRICD
                   WHEN    "1007"
                       MOVE    2            TO  SPA-GMN-CUR
                   WHEN    "1008"
                       MOVE    10           TO  SPA-GMN-CUR
               END-EVALUATE
           END-IF
      *---- (01.05.01) LINE MOD  --------------------------------
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD      
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE   SPA-W07
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
      *
           MOVE    "0"                 TO  SPA-GMN-DATAL    (1)
           MOVE    "算定しない"        TO  SPA-GMN-DATAMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-DATAL    (2)
           MOVE    "算定する"          TO  SPA-GMN-DATAMEIL (2)
           MOVE    2                   TO  SPA-GMN-DATA-MAX 
      *
           MOVE    "0:チェックなし"    TO  SPA-GMN-GAIKANRIKBN-LIST
                                                                  (1)
           MOVE    "1:チェックあり"    TO  SPA-GMN-GAIKANRIKBN-LIST
                                                                  (2)
           MOVE    "2:自動発生なし"    TO  SPA-GMN-GAIKANRIKBN-LIST
                                                                  (3)
      *
      *---- (01.05.01) LINE MOD START --------------------------------
           MOVE    SPACE               TO  SYSKANRI-REC 
           INITIALIZE                      SYSKANRI-REC
           MOVE    SPA-W01-KANRICD     TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               EVALUATE    SPA-W01-KANRICD
      *            自動算定割り当て情報
                   WHEN    "1007"
                       MOVE    MCPDATA-REC    TO  SYS-1007-REC
      *---- (01.00.01) LINE MOD START --------------------------------
      ***              MOVE    SYS-1007-SANTEI (IDX:1) 
      **                                        TO  SPA-GMN-CHOKI
                       PERFORM VARYING IDX FROM    1   BY  1
      *********************UNTIL   IDX >       4
                           UNTIL   IDX >       5
                           MOVE    SYS-1007-SANTEI (IDX:1)
                                               TO  SPA-GMN-DATA (IDX)
                           PERFORM VARYING IDY    FROM    1   BY  1
                               UNTIL   IDY     >  SPA-GMN-DATA-MAX
                               IF      SPA-GMN-DATA (IDX)
                                               =   SPA-GMN-DATAL (IDY)
                                   MOVE    SPA-GMN-DATALST (IDY)
                                               TO SPA-GMN-DATA-G (IDX)
                                   MOVE    SPA-GMN-DATA-MAX    TO  IDY
                               END-IF
                           END-PERFORM
                       END-PERFORM
      *---- (01.00.01) LINE MOD END   --------------------------------
      *            チェック機能制御割り当て情報
                   WHEN    "1008"
                       MOVE    MCPDATA-REC     TO  SYS-1008-REC
                       MOVE    SYS-1008-INTERACT-KIKAN 
                                               TO  SPA-GMN-KIKAN
      *                外来管理加算チェック
                       MOVE    SYS-1008-GAIKANRIKBN-CHK
                                           TO  SPA-GMN-GAIKANRIKBN-CHK
               END-EVALUATE
           END-IF
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007"
                   CONTINUE
               WHEN    "1008"
                   IF      SPA-GMN-GAIKANRIKBN-CHK   =   SPACE
                       MOVE    "1"     TO  SPA-GMN-GAIKANRIKBN-CHK
                   END-IF
                   EVALUATE    SPA-GMN-GAIKANRIKBN-CHK
                       WHEN    "1"
                           MOVE    SPA-GMN-GAIKANRIKBN-LIST (2)
                                               TO  SPA-GMN-GAIKANRIKBN-G
                       WHEN    "2"
                           MOVE    SPA-GMN-GAIKANRIKBN-LIST (3)
                                               TO  SPA-GMN-GAIKANRIKBN-G
                       WHEN    OTHER
                           MOVE    SPA-GMN-GAIKANRIKBN-LIST (1)
                                               TO  SPA-GMN-GAIKANRIKBN-G
                   END-EVALUATE
           END-EVALUATE
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007"
                   MOVE    2                  TO  SPA-GMN-CUR
               WHEN    "1008"
                   MOVE    10                 TO  SPA-GMN-CUR
           END-EVALUATE
      *
           . 
       31O-SPASET-EXT.
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
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *        削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM  403-DEL-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
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
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
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
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
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
      *    調剤基コード
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               MOVE    W07-DATA (IDX)      TO  SPA-GMN-DATA-G (IDX)
           END-PERFORM
      *    相互作用
           MOVE    W07-KIKAN           TO  SPA-GMN-KIKAN
           MOVE    W07-GAIKANRIKBN     TO  SPA-GMN-GAIKANRIKBN-G
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
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007"
      *            調剤技術基本料チェック
                   PERFORM 4100-DATA-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
               WHEN    "1008"
      *            相互作用チェック期間
                   PERFORM 4100-KIKAN-CHK2-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
      *            外来管理加算チェック
                   PERFORM 4101-GAIKANRIKBN-CHK2-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
           END-EVALUATE
      *
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    調剤技術基本料チェック
      *****************************************************************
       4100-DATA-CHK-SEC       SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
      ************ UNTIL      (IDX     >   4   )  OR
                   UNTIL      (IDX     >   5   )  OR
                              (SPA-ERRCD   NOT =   SPACE )
               MOVE    ZERO                TO  FLG-OK
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   SPA-GMN-DATA-MAX
                   IF      SPA-GMN-DATA (IDX)  =   SPA-GMN-DATAL(IDY)
                       MOVE    SPA-GMN-DATALST (IDY)
                                               TO  SPA-GMN-DATA-G(IDX)
                       MOVE    1               TO  FLG-OK
                   END-IF
               END-PERFORM
               IF      FLG-OK             =   ZERO
                   EVALUATE    IDX
                       WHEN    1
                           MOVE    "0001"             TO SPA-ERRCD
                       WHEN    2
                           MOVE    "0002"             TO SPA-ERRCD
                       WHEN    3
                           MOVE    "0003"             TO SPA-ERRCD
                       WHEN    4
                           MOVE    "0004"             TO SPA-ERRCD
                       WHEN    5
                           MOVE    "0008"             TO SPA-ERRCD
                   END-EVALUATE
                   MOVE    IDX             TO  SPA-GMN-CUR
                   ADD     1               TO  SPA-GMN-CUR
               END-IF
           END-PERFORM
           .
       4100-DATA-CHK-EXT.
           EXIT.
      *---- (01.00.01) LINE MOD END    --------------------------------
      *
      *---- (01.05.01) LINE MOD START  --------------------------------
      *****************************************************************
      *    相互作用チェック期間チェック処理
      *****************************************************************
       4100-KIKAN-CHK2-SEC       SECTION.
      *
          .
       4100-KIKAN-CHK2-EXT.
           EXIT.
      *
      *---- (01.05.01) LINE MOD END  ----------------------------------
      *****************************************************************
      *    外来管理加算チェック処理
      *****************************************************************
       4101-GAIKANRIKBN-CHK2-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-GAIKANRIKBN-CHK
                                      =   SPA-GMN-GAIKANRIKBN-LIST(IDX)
                                                                (1:1)
                   MOVE    SPA-GMN-GAIKANRIKBN-LIST(IDX)
                                          TO  SPA-GMN-GAIKANRIKBN-G
                   MOVE    1              TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    11              TO  SPA-GMN-CUR
               MOVE    "0006"          TO  SPA-ERRCD
               GO      TO      4101-GAIKANRIKBN-CHK2-EXT
           END-IF
      *
          .
       4101-GAIKANRIKBN-CHK2-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W07"               TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-W01KYOUTU
      *
      ***  MOVE   "CHANGE"             TO  MCP-PUTTYPE
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
      *---- (01.05.01) LINE MOD START  --------------------------------
      *****************************************************************
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                               SECTION.
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007"
                   MOVE    "1002"              TO  SPA-WIDCD
               WHEN    "1008"
                   MOVE    "1004"              TO  SPA-WIDCD
           END-EVALUATE
      *
           .    
       403-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理１００７
      *****************************************************************
       4032-DEL-1007-SEC                         SECTION.
      *
           MOVE    SPACE               TO  SYS-1007-REC
           INITIALIZE                      SYS-1007-REC
           MOVE    "1007"                  TO  SYS-1007-KANRICD
           MOVE    "*"                     TO  SYS-1007-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1007-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1007-EDYUKYMD
           MOVE    SYS-1007-REC            TO  MCPDATA-REC
           MOVE    "DBDELETE"              TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"                  TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-1007-KEY 
               GO  TO  4032-DEL-1007-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       4032-DEL-1007-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理１００８
      *****************************************************************
       4032-DEL-1008-SEC                         SECTION.
      *
               MOVE    SPACE               TO  SYS-1008-REC
           INITIALIZE                      SYS-1008-REC
           MOVE    "1008"                  TO  SYS-1008-KANRICD
           MOVE    "*"                     TO  SYS-1008-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1008-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1008-EDYUKYMD
           MOVE    SYS-1008-REC            TO  MCPDATA-REC
           MOVE    "DBDELETE"              TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"                  TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-1008-KEY 
               GO  TO  4032-DEL-1008-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       4032-DEL-1008-EXT.
           EXIT.
      *
      *---- (01.05.01) LINE MOD END  ----------------------------------
      *****************************************************************
      *       登録前処理
      *****************************************************************
       490-TOUROKU-SEC              SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      490-TOUROKU-EXT
           END-IF
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007"
                   PERFORM 4900-KANRENCHK-SEC
                   IF      SPA-ERRCD        =   SPACE
                       MOVE    "1001"           TO  SPA-WIDCD
                   END-IF
               WHEN    "1008"
                   IF      SPA-ERRCD        =   SPACE
                       MOVE    "1003"           TO  SPA-WIDCD
                   END-IF
          END-EVALUATE
      *     
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      ******************************************************************
      *       登録処理
      *****************************************************************
       491-KOUSHIN-1007-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYS-1007-REC
           INITIALIZE                      SYS-1007-REC
           MOVE    "1007"                  TO  SYS-1007-KANRICD
           MOVE    "*"                     TO  SYS-1007-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-1007-REC            TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-1007-REC
           ELSE
               MOVE    SPACE                   TO  SYS-1007-REC
               INITIALIZE                      SYS-1007-REC
               MOVE    "1007"                  TO  SYS-1007-KANRICD
               MOVE    "*"                     TO  SYS-1007-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1007-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1007-EDYUKYMD
      *---- (01.00.01) LINE MOD START   --------------------------------
      ***  MOVE    SPA-GMN-CHOKI           TO  SYS-1007-SANTEI (1:1)
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       5
               MOVE    SPA-GMN-DATA (IDX)  TO  SYS-1007-SANTEI (IDX:1)
           END-PERFORM 
      *---- (01.00.01) LINE MOD END     --------------------------------
           MOVE    SYS-1007-REC            TO  SYSKANRI-REC
      *     
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"                  TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-1007-EXT
           END-IF      
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       490-KOUSHIN-1007-EXT.
           EXIT.
      *
      ******************************************************************
      *       登録処理
      *****************************************************************
       491-KOUSHIN-1008-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYS-1008-REC
           INITIALIZE                      SYS-1008-REC
           MOVE    "1008"                  TO  SYS-1008-KANRICD
           MOVE    "*"                     TO  SYS-1008-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-1008-REC            TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-1008-REC
           ELSE
               MOVE    SPACE                   TO  SYS-1008-REC
               INITIALIZE                      SYS-1008-REC
               MOVE    "1008"                  TO  SYS-1008-KANRICD
               MOVE    "*"                     TO  SYS-1008-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1008-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1008-EDYUKYMD
           MOVE    SPA-GMN-KIKAN           TO  SYS-1008-INTERACT-KIKAN
           MOVE    SPA-GMN-GAIKANRIKBN-CHK TO  SYS-1008-GAIKANRIKBN-CHK
      *
           MOVE    SYS-1008-REC            TO  SYSKANRI-REC
      *     
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"                  TO  SPA-ERRCD
               DISPLAY "W07 ERR:" MCP-RC
                        ",MCP-FUNC:" MCP-FUNC
                        ",ORC-DBPATH:" ORC-DBPATH
               GO  TO  490-KOUSHIN-1008-EXT
           END-IF      
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       490-KOUSHIN-1008-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC           SECTION.
      *---- (01.00.01) LINE MOD START   --------------------------------
      *
           MOVE    SPACE                TO  SPA-ERRCD
           MOVE    SPA-GMN-CUR          TO  WRK-GMN-CUR 
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       4
                   OR      SPA-ERRCD   NOT =   SPACE
               PERFORM 4100-DATA-CHK-SEC
           END-PERFORM
      *
           IF      SPA-ERRCD            =   SPACE
               IF      SPA-GMN-DATA (3)     =   "1"
               AND     SPA-GMN-DATA (4)     =   "1"
                   MOVE    "0005"               TO  SPA-ERRCD
                   MOVE    4                    TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-GMN-CUR          TO  SPA-GMN-CUR
           END-IF             
      *---- (01.00.01) LINE MOD END     --------------------------------
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
           PERFORM 510-GSRAUTH-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-WIDCD       NOT =   SPACE
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W07    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  W07
      *
           MOVE    SPA-GMN-STYUKYMD         TO  W07-YUKOSTYMD
           MOVE    SPA-GMN-EDYUKYMD         TO  W07-YUKOEDYMD
      *
      *---- (01.00.01) LINE MOD START   --------------------------------
      ***  MOVE    SPA-GMN-CHOKI            TO  W07-CHOKI
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       5 
               MOVE    SPA-GMN-DATA-G (IDX) TO  W07-DATA (IDX)
           END-PERFORM
      *---- (01.00.01) LINE MOD END     --------------------------------
      *     
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       5 
               PERFORM VARYING IDY     FROM    1   BY  1
                       UNTIL   IDY     >       2
                   MOVE    SPA-GMN-DATALST (IDY)
                                       TO  W07-DATALST (IDX IDY)
               END-PERFORM
               MOVE    SPA-GMN-DATA-MAX    TO  W07-COUNT (IDX)
           END-PERFORM    
      *
           MOVE  SPA-GMN-KIKAN  TO  W07-KIKAN
      *    外来管理加算チェック
           MOVE    SPA-GMN-GAIKANRIKBN-G   TO  W07-GAIKANRIKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-GAIKANRIKBN-LIST (IDX)
                                       TO  W07-GAIKANRIKBN-ITEM(IDX)
           END-PERFORM
           MOVE    3                   TO  W07-GAIKANRIKBN-COUNT
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *---- (01.05.01) LINE MOD START   -------------------------------
      *****************************************************************
      *    業務権限非活性処理
      *****************************************************************
       510-GSRAUTH-SEC             SECTION.
      *
           MOVE    WIDGET-INSENSITIVE      TO  W07-B03-STATE
                                               W07-TG1-STATE
                                               W07-TG2-STATE
      *
           IF      SPA-W01-SELNUM          >   ZERO    
               MOVE    WIDGET-NORMAL       TO  W07-B03-STATE
           END-IF 
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1007" 
                   MOVE    WIDGET-NORMAL      TO  W07-TG1-STATE
               WHEN    "1008" 
                   MOVE    WIDGET-NORMAL      TO  W07-TG2-STATE
           END-EVALUATE
           .
       51O-GSRAUTH-EXT.
           EXIT.
      *
      *---- (01.05.01) LINE MOD END   --------------------------------
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "調剤技術基本料入力エラー"    TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "薬剤情報提供料（一般）入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE
                       "薬剤情報提供料（老人手帳記載あり）入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE
                       "薬剤情報提供料（老人手帳記載なし）入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE
                 "薬剤情報提供料（老人手帳記載）は両方の選択できません"
                                                         TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "外来管理加算チェック区分がありません。"
                                                         TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE
                       "療養担当手当（北海道）入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "更新ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    OTHER
                   MOVE    SPA-ERRCD
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W07"                TO  SPA-MOTOPG
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
      *    ガイドメッセージ表示
      *****************************************************************
       520-WIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-WIDMSG
      *
           EVALUATE    SPA-WIDCD
               WHEN    "1001"
                   MOVE    "自動算定情報を登録します"    TO  WRK-WIDMSG
               WHEN    "1002"
                   MOVE    "自動算定情報を削除します"    TO  WRK-WIDMSG
               WHEN    "1003"
                   MOVE    "チェック機能制御情報を登録します" 
                                                         TO  WRK-WIDMSG
               WHEN    "1004"
                   MOVE    "チェック機能制御情報を削除します"  
                                                         TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W07"                TO  SPA-MOTOPG
           MOVE    "WID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-WIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理    
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
          IF      SPA-GMN-CUR          =   ZERO
               PERFORM 50011-CUR-SET-SEC
          END-IF
      *
      *---- (01.00.01) LINE MOD START   --------------------------------
          EVALUATE    SPA-GMN-CUR
                WHEN    2
                    MOVE  "DATA01"           TO   MCP-WIDGET
                WHEN    3
                    MOVE  "DATA02"           TO   MCP-WIDGET
                WHEN    4
                    MOVE  "DATA03"           TO   MCP-WIDGET
                WHEN    5
                    MOVE  "DATA04"           TO   MCP-WIDGET
                WHEN    6
                    MOVE  "DATA05"           TO   MCP-WIDGET
      *---- (01.05.01) LINE MOD START   --------------------------------
                WHEN    10
                    MOVE  "KIKAN"            TO   MCP-WIDGET
                WHEN    11
                    MOVE  "GAIKANRIKBN"      TO   MCP-WIDGET
                WHEN    99
                    MOVE  "B12"              TO   MCP-WIDGET
            END-EVALUATE
      *---- (01.00.01) LINE MOD END     --------------------------------
      *
            EVALUATE    SPA-GMN-CUR
                WHEN    2   THRU    5
                WHEN    6
                    MOVE    0                TO  W07-PAGENO
                WHEN    10  THRU    11
                    MOVE    1                TO  W07-PAGENO
            END-EVALUATE
      *
      *---- (01.05.01) LINE MOD END   ----------------------------------
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル編集処理
      *****************************************************************
       50011-CUR-SET-SEC         SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "DATA01"
                   MOVE    3           TO  SPA-GMN-CUR
               WHEN    "DATA02"
                   MOVE    4           TO  SPA-GMN-CUR
               WHEN    "DATA03"
                   MOVE    5           TO  SPA-GMN-CUR
               WHEN    "DATA04"
                   MOVE    6           TO  SPA-GMN-CUR
               WHEN    "DATA05"
                   MOVE    99          TO  SPA-GMN-CUR
               WHEN    "KIKAN"
                   MOVE    11          TO  SPA-GMN-CUR
               WHEN    "GAIKANRIKBN"
                   MOVE    99          TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
       50011-CUR-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YMD  (1:7)  NOT NUMERIC
               INSPECT     WRK-YMD      REPLACING   ALL " " BY  "0"
               MOVE    WRK-YMD(1:1)     TO  WRK-WGO
               MOVE    WRK-YMD(2:2)     TO  WRK-WYY
               MOVE    WRK-YMD(5:2)     TO  WRK-WMM
               MOVE    WRK-YMD(8:2)     TO  WRK-WDD
           ELSE
               MOVE    WRK-YMD(1:7)     TO  WRK-WYMD
           END-IF
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY1-AREA
           MOVE    "12"                TO  LNK-DAY1-IRAI
           MOVE    ZERO                TO  LNK-DAY1-YMD
           MOVE    WRK-WYMD            TO  LNK-DAY1-YMD(2:7)
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY1-AREA
           IF      STS-DAY-RC1     NOT =   ZERO
               MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HGO
               MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
               MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
               MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
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
      *
