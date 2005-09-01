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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCGW13.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 労災医療機関情報（Ｗ１３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    02.09.17  加算率追加
      *  01.00.02    NACL-藤原    02.09.30  指定病院番号の空白チェック修正
      *  02.00.01    NACL-多々納  02/11/14  一括入力 
      *  02.00.02    NACL-太田    03.04.04  文書料（消費税）追加
      *  02.00.03    NACL-太田    04.02.09  自賠責食事療養費追加
      *  02.00.04    NACL-太田    04.09.15  削除ボタン追加
      *  02.00.05    NACL-太田    04.10.07  特定器材等消費税対応
      *  01.00.06    NACL-藤原    05.01.25  固定帯加算等取扱追加
      *  01.00.07    NACL-小豆沢  05.05.25  請求書兼領収書の円建て記載区分
      *                                     を追加
      *  02.06.01    NACL-藤原    05/06/22  自賠責加算率（３桁）対応
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
       01  SPA-W13.
           03  SPA-W13-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD       PIC X(09).
                   07  SPA-GMN-EDYUKYMD       PIC X(09).              
      *
                   07  SPA-GMN-KOUMOKU.
                       09  SPA-GMN-RSIIRYOKBN-G.
                           11  SPA-GMN-RSIIRYOKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-RSIIRYOKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-TENKBN-G.
                           11  SPA-GMN-TENKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-TENKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-RSIIRYOCDN PIC X(40). 
                       09  SPA-GMN-KSNRATE    PIC 9(03).
                       09  SPA-GMN-TAXKBN-G.
                           11  SPA-GMN-TAXKBN PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-TAXKBNMEI
                                              PIC X(08).
                       09  SPA-GMN-SKJKBN-G.
                           11  SPA-GMN-SKJKBN PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SKJKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-KIZAITAXKBN-G.
                           11  SPA-GMN-KIZAITAXKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-KIZAITAXKBNMEI
                                              PIC X(08).
                       09  SPA-GMN-KOTEIKBN-G.
                           11  SPA-GMN-KOTEIKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-KOTEIKBNMEI
                                              PIC X(08).
                       09  SPA-GMN-RSIPRT-G.
                           11  SPA-GMN-RSIPRT
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-RSIPRTMEI
                                              PIC X(08).
                       09  SPA-GMN-LBLKIZAILST
                                              PIC X(60).
                   07  SPA-GMN-KOUMOKU1.
                       09  SPA-GMN-SONSHOUKBN.                 
                           11  SPA-GMN-SONSHOUKBN1
                                              PIC X(02).              
                           11  SPA-GMN-SONSHOUKBN2
                                              PIC X(01).              
                       09  SPA-GMN-SONSHOUNAME
                                              PIC X(60).              
      *                                        
                   07  SPA-GMN-RSIIRYOKBNLST      OCCURS  2.
                       09  SPA-GMN-RSIIRYOKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-RSIIRYOKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-RSIIRYOKBN-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-TENKBNLST          OCCURS  2.
                       09  SPA-GMN-TENKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-TENKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-TENKBN-MAX     PIC 9(02).    
                   07  SPA-GMN-TAXKBNLST      OCCURS  2.
                       09  SPA-GMN-TAXKBNL    PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-TAXKBNMEIL
                                              PIC X(08).
                   07  SPA-GMN-TAXKBN-MAX     PIC 9(02).
      *                                        
                   07  SPA-GMN-SKJKBNLST      OCCURS  2.
                       09  SPA-GMN-SKJKBNL    PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SKJKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-SKJKBN-MAX     PIC 9(02).
      *                                        
                   07  SPA-GMN-KIZAITAXKBNLST OCCURS  2.
                       09  SPA-GMN-KIZAITAXKBNL    PIC X(01).
                       09  SPA-GMN-F1L             PIC X(01).
                       09  SPA-GMN-KIZAITAXKBNMEIL PIC X(08).
                   07  SPA-GMN-KIZAITAXKBN-MAX     PIC 9(02).
      *                                        
                   07  SPA-GMN-KOTEIKBNLST OCCURS  2.
                       09  SPA-GMN-KOTEIKBNL   PIC X(01).
                       09  SPA-GMN-F1L         PIC X(01).
                       09  SPA-GMN-KOTEIKBNMEIL
                                               PIC X(08).
                   07  SPA-GMN-KOTEIKBN-MAX    PIC 9(02).
      *                                        
                   07  SPA-GMN-RSIPRTLST OCCURS  2.
                       09  SPA-GMN-RSIPRTL    PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-RSIPRTMEIL PIC X(08).
                   07  SPA-GMN-RSIPRT-MAX     PIC 9(02).
      *
                   07  SPA-GMN-KIZAITBL.
                       09  SPA-GMN-KIZAITBL-NEXT   PIC 9(01).
                       09  SPA-GMN-KIZAITBL-SEL    PIC 9(03).
                       09  SPA-GMN-KIZAITBL-MAX    PIC 9(03).
                       09  SPA-GMN-KIZAITBL-G      OCCURS  50.
                           11  SPA-GMN-TSRYCD-MARK
                                                   PIC 9(01).
                           11  SPA-GMN-TSRYCD      PIC X(09).
                           11  SPA-GMN-TSRYCDNAME  PIC X(60).
      *                                        
                   07  SPA-GMN-TBL.            
                       09  SPA-GMN-TBL-G      OCCURS  40.
                           11  SPA-GMN-TSONSHOUKBN.
                               13  SPA-GMN-TSONSHOUKBN1
                                              PIC X(02).
                               13  SPA-GMN-TSONSHOUKBN-FL
                                              PIC X(01).
                               13  SPA-GMN-TSONSHOUKBN2
                                              PIC X(01).
                           11  SPA-GMN-TSONSHOUNAME
                                              PIC X(60).
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-STYUKYMD       PIC 9(08).
                   07  SPA-NAI-EDYUKYMD       PIC 9(08).
      *
                   07  SPA-NAI-KIZAITBL-FLG   PIC 9(01).
                   07  SPA-NAI-KIZAITBL-PAGE  PIC 9(05).
      *
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBLO       OCCURS  40.
                           11  SPA-NAI-TSONSHOUKBN.
                               13  SPA-NAI-TSONSHOUKBN1
                                              PIC X(02).
                               13  SPA-NAI-TSONSHOUKBN2
                                              PIC X(01).
      *
                   07  SPA-NAI-KIZAITBL.
                       09  SPA-NAI-KIZAITBL-MAX    PIC 9(03).
                       09  SPA-NAI-KIZAITBL-G      OCCURS  10.
                           11  SPA-NAI-TSRYCD      PIC X(09).
                           11  SPA-NAI-TSRYCDNAME  PIC X(60).
      *
                   07  SPA-MAE-SONSHOUKBN     PIC X(03).
      *
              05  SPA-NAI-SELNO               PIC 9(03).
      *
           COPY    "ENUM-VALUE".
      *
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-OK2             PIC 9(01).
           03  FLG-TOUROKU         PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-KIZAI-MARK      PIC 9(01).
           03  FLG-SONSHOULST-ROW  PIC 9(01).
           03  FLG-KIZAILST-ROW    PIC 9(01).
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
           03  IDX0                PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDX-LST             PIC 9(04).
      *
      *    一時領域
      *
       01  WRK-AREA.
           03  WRK-ZZ9             PIC ZZ9.
           03  WRK-CMB-CD          PIC X(10).
           03  WRK-CMB-ITM-G.
               07  WRK-CMB-ITM     PIC X(200).
           03  WRK-PATH            PIC X(64).
           03  WRK-SELNO           PIC 9(03).
           03  WRK-NUM             PIC 9(02).
           03  WRK-NUM2            PIC 9(03).
           03  WRK-GMN-CUR         PIC 9(02).
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
           03  WRK-KANRICD         PIC X(04).
           03  WRK-STIDX           PIC 9(05).
           03  WRK-EDIDX           PIC 9(05).
           03  WRK-TNS-SRYCD       PIC X(09).
           03  WRK-TNS-YMD         PIC X(08).
           03  WRK-SKIPKNS         PIC 9(05).
           03  WRK-CHK-SRYCD       PIC X(09).
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
       01  WRK-ROW.
           03  WRK-SONSHOUKBN-ROW      PIC S9(9)   BINARY.
           03  WRK-KIZAILST-ROW        PIC S9(9)   BINARY.
      *
       01  SRT-KIZAI-AREA.
           03  SRT-KIZAI-TSRYCD        PIC X(09).
           03  SRT-KIZAI-TSRYCDNAME    PIC X(60).
      *
       01  SRT-SONSHO-AREA.
           05  SRT-SONSHO-GMN-TSONSHOUKBN  PIC X(04).
           05  SRT-SONSHO-NAI-TSONSHOUKBN  PIC X(03).
           05  SRT-SONSHO-TSONSHOUNAME     PIC X(60).
      *
       01  WRK-CONS-LINE-MAX       PIC 9(02)   VALUE   40.
       01  WRK-CONS-KIZAILST-MAX   PIC 9(02)   VALUE   50.
       01  WRK-CONS-SYS-KIZAI-MAX  PIC 9(02)   VALUE   10.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    労災医療機関情報
           COPY  "CPSK4001.INC".
      *    労災保険損傷区分情報
           COPY  "CPSK4002.INC".
      *    自賠責保険　特定器材等消費税対象外コード
           COPY  "CPSK4003.INC".
      *    点数マスタ
           COPY  "CPTENSU.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *    日付サブルーチン領域
      *
           COPY  "CPORCSDAY.INC".
      *
           COPY  "CPORCSLNK.INC".
      *     
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
           COPY    "ORCA-DBPATH".
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
           COPY    "W60.INC".
           COPY    "W61.INC".
           COPY    "W98.INC".
           COPY    "W97.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
           COPY    "WID2.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W13
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
           MOVE    SPA-W13         TO  SPA-FREE
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
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W13"                TO  MCP-WINDOW
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
               IF      SPA-WIDCD            =   "1002"
                   PERFORM 4031-DEL-SEC
               ELSE
                   PERFORM 490-KOUSHIN-SEC
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD
      *
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE   SPA-W13-AREA
      *
           PERFORM 3101-COMBO-SET-SEC
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
      * 
           MOVE    SPACE               TO  SYS-4001-REC
           INITIALIZE                      SYS-4001-REC
           MOVE    "4001"              TO  SYS-4001-KANRICD
           MOVE    "*"                 TO  SYS-4001-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-4001-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  WRK-PATH
      *
           PERFORM 900-SYSKANRI-INV-SEC
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
      *
               MOVE    MCPDATA-REC         TO  SYS-4001-REC
      *
               PERFORM 3001-RSIKHN-HEN-SEC
      *
               PERFORM 3001-SONSHOLIST-HEN-SEC
      *
               PERFORM 3001-KIZAILST-HEN-SEC
      *
           ELSE
      *
               MOVE    ZERO                TO  FLG-OK2
      *
               MOVE    ZERO                TO  FLG-SYSKANRI
               MOVE    SPACE               TO  SYS-4001-REC
               INITIALIZE                      SYS-4001-REC
               MOVE    "4001"              TO  SYS-4001-KANRICD
               MOVE    "*"                 TO  SYS-4001-KBNCD
               MOVE    SYS-4001-REC        TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY8"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC              =   ZERO )
                   MOVE    "SYSKANRI-KEY8" TO  ORC-DBPATH
                   PERFORM 900-SYSKANRI-READ-SEC
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
      *
               PERFORM     UNTIL ( FLG-SYSKANRI    =   1 )
                            OR   ( FLG-OK2         =   1 )
      *
                   MOVE    MCPDATA-REC     TO  SYS-4001-REC
      *
                   IF ( SYS-4001-STYUKYMD  <  SPA-W01-STYUKYMD )
      *
                        MOVE    1          TO  FLG-OK2
      *
                        PERFORM 3001-RSIKHN-HEN-SEC
      *
                        PERFORM 3001-SONSHOLIST-HEN-SEC
      *
                        PERFORM 3001-KIZAILST-HEN-SEC
      *
                   END-IF
      *
                   MOVE    "SYSKANRI-KEY8" TO  ORC-DBPATH
                   PERFORM 900-SYSKANRI-READ-SEC
      *
              END-PERFORM
      *
      *       カーソルクロース
              MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
              MOVE    "SYSKANRI-KEY8"     TO  ORC-DBPATH
              CALL    "ORCMCPSUB"         USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
           END-IF
      *
           IF    ( SPA-GMN-RSIIRYOKBN-G    =   SPACE )
               MOVE    SPA-GMN-RSIIRYOKBNLST (1)
                                               TO  SPA-GMN-RSIIRYOKBN-G
           END-IF
      *
           IF    ( SPA-GMN-TENKBN-G        =   SPACE )
               MOVE    SPA-GMN-TENKBNLST(1)    TO  SPA-GMN-TENKBN-G
           END-IF
      *
           IF    ( SPA-GMN-TAXKBN-G        =   SPACE )
               MOVE    SPA-GMN-TAXKBNLST(1) TO  SPA-GMN-TAXKBN-G
           END-IF
      *
           IF    ( SPA-GMN-SKJKBN-G        =   SPACE )
               MOVE    SPA-GMN-SKJKBNLST(1) TO  SPA-GMN-SKJKBN-G
           END-IF
      *
           IF    ( SPA-GMN-KIZAITAXKBN-G   =   SPACE )
               MOVE    SPA-GMN-KIZAITAXKBNLST(1)
                                            TO  SPA-GMN-KIZAITAXKBN-G
           END-IF
      *
           IF    ( SPA-GMN-KOTEIKBN-G   =   SPACE )
               MOVE    SPA-GMN-KOTEIKBNLST(2)
                                            TO  SPA-GMN-KOTEIKBN-G
           END-IF
      *
           IF    ( SPA-GMN-RSIPRT-G   =   SPACE )
               MOVE    SPA-GMN-RSIPRTLST(1)
                                            TO  SPA-GMN-RSIPRT-G
           END-IF
      *
           MOVE    ZERO                TO  SPA-NAI-KIZAITBL-FLG
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           . 
       31O-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災基本情報編集処理
      *****************************************************************
       3001-RSIKHN-HEN-SEC              SECTION.
      *
           MOVE    SYS-4001-RSIIRYOKBN TO  WRK-CMB-CD
           PERFORM 4200-RSIIRYOKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-RSIIRYOKBN-G
      *
           MOVE    SYS-4001-TENKBN     TO  WRK-CMB-CD
           PERFORM 4200-TENKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-TENKBN-G
      *
           MOVE    SYS-4001-RSIIRYOCDN TO  SPA-GMN-RSIIRYOCDN
      *
           IF      SYS-4001-KSNRATE (1:2)  NOT NUMERIC
               MOVE    ZERO                TO  SYS-4001-KSNRATE
           END-IF                    
           IF      SYS-4001-KSNRATE1 (1:3) NOT NUMERIC
               MOVE    ZERO                TO  SYS-4001-KSNRATE1
           END-IF                    
           IF      SYS-4001-KSNRATE1   =   ZERO
               COMPUTE SYS-4001-KSNRATE1   =   100 +   
                                               SYS-4001-KSNRATE
           END-IF
           MOVE    SYS-4001-KSNRATE1   TO  SPA-GMN-KSNRATE
      *         
           MOVE    SYS-4001-TAXKBN     TO  WRK-CMB-CD
           PERFORM 4200-TAXKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-TAXKBN-G
      *        
           MOVE    SYS-4001-SKJKBN     TO  WRK-CMB-CD
           PERFORM 4200-SKJKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-SKJKBN-G
      *
           MOVE    SYS-4001-TAXKBN-KZI TO  WRK-CMB-CD
           PERFORM 4200-KIZAITAXKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-KIZAITAXKBN-G
      *
           MOVE    SYS-4001-KOTEIKBN   TO  WRK-CMB-CD
           PERFORM 4200-KOTEIKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-KOTEIKBN-G
      *
           MOVE    SYS-4001-RSIPRTKBN  TO  WRK-CMB-CD
           PERFORM 4200-RSIPRTLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-RSIPRT-G
      *
           .
       3001-RSIKHN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    労災損傷リスト情報編集処理
      *****************************************************************
       3001-SONSHOLIST-HEN-SEC          SECTION.
      *
           MOVE        1               TO  FLG-SONSHOULST-ROW
      *
           MOVE    SPACE               TO  SYS-4002-REC
           INITIALIZE                      SYS-4002-REC
           MOVE    "4002"              TO  SYS-4002-KANRICD
           MOVE    SYS-4001-STYUKYMD   TO  ORC-DBYMD
           MOVE    SYS-4002-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM      UNTIL ( FLG-SYSKANRI   =   1 )
                         OR   ( IDX           >=   WRK-CONS-LINE-MAX )
      *
               MOVE    MCPDATA-REC     TO  SYS-4002-REC
               ADD     1               TO  IDX
               MOVE    SYS-4002-KBNCD (1:3)
                                       TO  SPA-NAI-TSONSHOUKBN   (IDX)
               MOVE    SYS-4002-SONSHOUNAME
                                       TO  SPA-GMN-TSONSHOUNAME  (IDX)
               MOVE    SPA-NAI-TSONSHOUKBN1 (IDX)
                                       TO  SPA-GMN-TSONSHOUKBN1  (IDX)
               IF      SPA-NAI-TSONSHOUKBN2 (IDX)
                                                  NOT =   SPACE
                   MOVE    "-"         TO  SPA-GMN-TSONSHOUKBN-FL(IDX)
                   MOVE    SPA-NAI-TSONSHOUKBN2 (IDX)
                                       TO  SPA-GMN-TSONSHOUKBN2  (IDX)
               END-IF
      *
               MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
      *
           END-PERFORM
      *
           MOVE    IDX                 TO  SPA-GMN-MAX
      *
      *    カーソルクロース
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
      *
           .
       3001-SONSHOLIST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    特定器材リスト情報編集処理
      *****************************************************************
       3001-KIZAILST-HEN-SEC          SECTION.
      *
           INITIALIZE                      SPA-GMN-KIZAITBL
                                           SPA-NAI-KIZAITBL
      *
           MOVE    SPACE               TO  SYS-4003-REC
           INITIALIZE                      SYS-4003-REC
           MOVE    "4003"              TO  SYS-4003-KANRICD
           MOVE    "*"                 TO  SYS-4003-KBNCD
           MOVE    SYS-4001-STYUKYMD   TO  ORC-DBYMD
           MOVE    SYS-4003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  WRK-PATH
      *
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-4003-REC
           ELSE
               INITIALIZE                  SYS-4003-REC
           END-IF
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL ( IDX         >   WRK-CONS-SYS-KIZAI-MAX )
                    OR   ( SYS-4003-SRYCD (IDX)
                                       =   SPACE )
      *
               MOVE    SYS-4003-SRYCD (IDX)
                                       TO  WRK-TNS-SRYCD
               MOVE    SPA-W01-STYUKYMD
                                       TO  WRK-TNS-YMD
               PERFORM 900-TENSU-KEY-SEL-SEC
               IF    ( FLG-TENSU       =   ZERO )
      *
                   COMPUTE SPA-NAI-KIZAITBL-MAX
                       =   SPA-NAI-KIZAITBL-MAX
                       +   1
      *
                   IF    ( SPA-NAI-KIZAITBL-MAX
                                       <=  WRK-CONS-SYS-KIZAI-MAX )
                       MOVE    TNS-SRYCD
                           TO  SPA-NAI-TSRYCD (SPA-NAI-KIZAITBL-MAX)
                       MOVE    TNS-NAME
                           TO  SPA-NAI-TSRYCDNAME
                                              (SPA-NAI-KIZAITBL-MAX)
                   END-IF
      *
               END-IF
      *
           END-PERFORM
      *
           PERFORM 3001-KIZAILST-SYS-SEC
      *
           .
       3001-KIZAILST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    システム管理の情報から特定器材リスト編集処理
      *****************************************************************
       3001-KIZAILST-SYS-SEC          SECTION.
      *
           MOVE    1               TO      FLG-KIZAILST-ROW
      *
           INITIALIZE                      SPA-GMN-KIZAITBL
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL ( IDX     >   SPA-NAI-KIZAITBL-MAX )
      *
               MOVE    IDX         TO  SPA-GMN-KIZAITBL-MAX
      *
               MOVE    SPA-NAI-TSRYCD (IDX)
                                   TO  SPA-GMN-TSRYCD (IDX)
               MOVE    SPA-NAI-TSRYCDNAME (IDX)
                                   TO  SPA-GMN-TSRYCDNAME (IDX)
      *
           END-PERFORM
      *
           MOVE    1               TO  SPA-NAI-KIZAITBL-PAGE
           MOVE    ZERO            TO  SPA-GMN-KIZAITBL-NEXT
      *
           .
       3001-KIZAILST-SYS-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタの情報から特定器材リスト編集処理
      *****************************************************************
       3001-KIZAILST-TNS-SEC          SECTION.
      *
           MOVE    1               TO      FLG-KIZAILST-ROW
      *
           COMPUTE WRK-SKIPKNS
               = ( SPA-NAI-KIZAITBL-PAGE   -   1 )
               *   WRK-CONS-KIZAILST-MAX
      *
           INITIALIZE                  SPA-GMN-KIZAITBL
      *
           MOVE    ZERO                TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    "095930000"         TO  TNS-SRYCD
           MOVE    "095939999"         TO  TNSUP-SRYCD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    "TENSU-KEY12S"      TO  ORC-DBPATH
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 900-TENSU-KEY12S-FETCH-SEC
           ELSE
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           PERFORM VARYING IDX3    FROM    1   BY  1
                   UNTIL ( FLG-TENSU   =   1 )
                    OR   ( IDX3       >=       WRK-SKIPKNS )
      *
               PERFORM 900-TENSU-KEY12S-FETCH-SEC
      *
           END-PERFORM
      *
           MOVE    ZERO                TO  IDX3
           PERFORM UNTIL  ( FLG-TENSU  =   1 )
                    OR    ( IDX3       >=  WRK-CONS-KIZAILST-MAX )
      *
               COMPUTE IDX3    =   IDX3    +   1
      *
               MOVE    TNS-SRYCD       TO  SPA-GMN-TSRYCD (IDX3)
               MOVE    TNS-NAME        TO  SPA-GMN-TSRYCDNAME (IDX3)
      *
               PERFORM 30011-KIZAI-MARK-CHK-SEC
               IF    ( FLG-KIZAI-MARK  =   1 )
                   MOVE    1           TO  SPA-GMN-TSRYCD-MARK (IDX3)
               END-IF
      *
               PERFORM 900-TENSU-KEY12S-FETCH-SEC
      *
           END-PERFORM
      *
           MOVE    IDX3                TO  SPA-GMN-KIZAITBL-MAX
      *
           IF    ( FLG-TENSU           =   ZERO )
               MOVE    1               TO  SPA-GMN-KIZAITBL-NEXT
           END-IF
      *
           MOVE    "TENSU-KEY12S"      TO  ORC-DBPATH
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       3001-KIZAILST-TNS-EXT.
           EXIT.
      *****************************************************************
      *    登録済特定器材チェック処理
      *****************************************************************
       30011-KIZAI-MARK-CHK-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-KIZAI-MARK
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0            >   SPA-NAI-KIZAITBL-MAX )
                    OR   ( FLG-KIZAI-MARK  =   1 )
      *
               IF    ( TNS-SRYCD   =   SPA-NAI-TSRYCD (IDX0) )
                   MOVE    1       TO  FLG-KIZAI-MARK
               END-IF
      *
           END-PERFORM
      *
           .
       30011-KIZAI-MARK-CHK-EXT.
           EXIT.
      *****************************************************************
      *    コンボボックス設定処理
      *****************************************************************
       3101-COMBO-SET-SEC              SECTION.
      *
           MOVE    "0"                 TO  SPA-GMN-RSIIRYOKBNL    (1)
           MOVE    "指定なし"          TO  SPA-GMN-RSIIRYOKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-RSIIRYOKBNL    (2)
           MOVE    "指定あり"          TO  SPA-GMN-RSIIRYOKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-RSIIRYOKBN-MAX 
      *     
           MOVE    "1"                 TO  SPA-GMN-TENKBNL      (1)
           MOVE    "１１．５円"        TO  SPA-GMN-TENKBNMEIL   (1)
           MOVE    "2"                 TO  SPA-GMN-TENKBNL      (2)
           MOVE    "１２円"            TO  SPA-GMN-TENKBNMEIL   (2)
           MOVE    2                   TO  SPA-GMN-TENKBN-MAX 
      *     
           MOVE    "1"                 TO  SPA-GMN-TAXKBNL      (1)
           MOVE    "無し"              TO  SPA-GMN-TAXKBNMEIL   (1)
           MOVE    "2"                 TO  SPA-GMN-TAXKBNL      (2)
           MOVE    "有り"              TO  SPA-GMN-TAXKBNMEIL   (2)
           MOVE    2                   TO  SPA-GMN-TAXKBN-MAX 
      *     
           MOVE    "1"                 TO  SPA-GMN-SKJKBNL      (1)
           MOVE    "労災準拠"          TO  SPA-GMN-SKJKBNMEIL   (1)
           MOVE    "2"                 TO  SPA-GMN-SKJKBNL      (2)
           MOVE    "労災準拠×１．２"  TO  SPA-GMN-SKJKBNMEIL   (2)
           MOVE    2                   TO  SPA-GMN-SKJKBN-MAX 
      *     
           MOVE    "1"                 TO  SPA-GMN-SKJKBNL      (1)
           MOVE    "労災準拠"          TO  SPA-GMN-SKJKBNMEIL   (1)
           MOVE    "2"                 TO  SPA-GMN-SKJKBNL      (2)
           MOVE    "労災準拠×１．２"  TO  SPA-GMN-SKJKBNMEIL   (2)
           MOVE    2                   TO  SPA-GMN-SKJKBN-MAX 
      *     
           MOVE    "1"                 TO  SPA-GMN-KIZAITAXKBNL      (1)
           MOVE    "無し"              TO  SPA-GMN-KIZAITAXKBNMEIL   (1)
           MOVE    "2"                 TO  SPA-GMN-KIZAITAXKBNL      (2)
           MOVE    "有り"              TO  SPA-GMN-KIZAITAXKBNMEIL   (2)
           MOVE    2                   TO  SPA-GMN-KIZAITAXKBN-MAX 
      *     
           MOVE    "1"                 TO  SPA-GMN-KOTEIKBNL      (1)
           MOVE    "技術点"            TO  SPA-GMN-KOTEIKBNMEIL   (1)
           MOVE    "2"                 TO  SPA-GMN-KOTEIKBNL      (2)
           MOVE    "薬剤等点"          TO  SPA-GMN-KOTEIKBNMEIL   (2)
           MOVE    2                   TO  SPA-GMN-KOTEIKBN-MAX 
      *     
           MOVE    "1"                 TO  SPA-GMN-RSIPRTL      (1)
           MOVE    "記載なし"          TO  SPA-GMN-RSIPRTMEIL   (1)
           MOVE    "2"                 TO  SPA-GMN-RSIPRTL      (2)
           MOVE    "記載あり"          TO  SPA-GMN-RSIPRTMEIL   (2)
           MOVE    2                   TO  SPA-GMN-RSIPRT-MAX 
      *
           . 
       3101-COMBO-SET-EXT.
           EXIT.
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
      *    削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 403-DEL-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *    特定器材リスト切替
               WHEN    "CLICKED"       ALSO    "BTNCHG"
                   PERFORM 490-KIZAILST-CHG-SEC
      *    特定器材リスト削除処理
               WHEN    "CLICKED"       ALSO    "BTNDEL"
                   PERFORM 490-KIZAILST-DEL-SEC
      *    特定器材リスト次ページ
               WHEN    "CLICKED"       ALSO    "BTNPREV"
                   PERFORM 490-KIZAILST-PREV-SEC
      *    特定器材リスト前ページ
               WHEN    "CLICKED"       ALSO    "BTNNEXT"
                   PERFORM 490-KIZAILST-NEXT-SEC
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
           MOVE    ZERO                TO  FLG-TOUROKU
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        行選択
               WHEN    ANY             ALSO    "SONSHOUKBNLST"
                   PERFORM 41015-LIST1SEL-SEC
      *        行選択
               WHEN    ANY             ALSO    "KIZAILST"
                   PERFORM 41015-KIZAILST-SEC
           END-EVALUATE
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
           MOVE    W13-RSIIRYOKBN      TO  SPA-GMN-RSIIRYOKBN-G
           MOVE    W13-KSNRATE         TO  SPA-GMN-KSNRATE
           MOVE    W13-RSIIRYOCDN      TO  SPA-GMN-RSIIRYOCDN
           MOVE    W13-TENKBN          TO  SPA-GMN-TENKBN-G
           MOVE    W13-TAXKBN          TO  SPA-GMN-TAXKBN-G
           MOVE    W13-SKJKBN          TO  SPA-GMN-SKJKBN-G
           MOVE    W13-KIZAITAXKBN     TO  SPA-GMN-KIZAITAXKBN-G
           MOVE    W13-KOTEIKBN        TO  SPA-GMN-KOTEIKBN-G
           MOVE    W13-RSIPRT          TO  SPA-GMN-RSIPRT-G
      *    損傷区分
           MOVE    W13-SONSHOUKBN1     TO  SPA-GMN-SONSHOUKBN1
           MOVE    W13-SONSHOUKBN2     TO  SPA-GMN-SONSHOUKBN2
           MOVE    W13-SONSHOUNAME     TO  SPA-GMN-SONSHOUNAME
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
           PERFORM 4100-RSIIRYOKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4103-RSIIRYOCDN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-TENKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4102-KSNRATE-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-TAXKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-SKJKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-KIZAITAXKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-KOTEIKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-RSIPRT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4106-SONSHOUKBN1-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4104-SONSHOUKBN2-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4105-SONSHOUNAME-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災指定医療機関区分チェック
      *****************************************************************
       4100-RSIIRYOKBN-CHK-SEC       SECTION.
      *
           MOVE    SPA-GMN-RSIIRYOKBN  TO  WRK-CMB-CD
           PERFORM 4200-RSIIRYOKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    1               TO  SPA-GMN-CUR
               MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-RSIIRYOKBN-G
           END-IF
      *
           .
       4100-RSIIRYOKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    加算率チェック
      *****************************************************************
       4102-KSNRATE-CHK-SEC       SECTION.
      *
           IF     SPA-GMN-KSNRATE   <    100
                MOVE    8           TO    SPA-GMN-CUR
                MOVE    "0005"      TO    SPA-ERRCD
           END-IF
      *
           .
       4102-KSNRATE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    指定医療機関コード（漢字）チェック
      *****************************************************************
       4103-RSIIRYOCDN-CHK-SEC       SECTION.
      *
      *    半角チェック
           IF    ( SPA-GMN-RSIIRYOCDN      NOT =   SPACE )
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-RSIIRYOCDN  TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF    ( KANACHK-RC          =   ZERO )
                AND  ( KANACHK-SYUBETU     =   "2" )
                   MOVE    KANACHK-OUT-INPUT
                                           TO  SPA-GMN-RSIIRYOCDN 
               ELSE
                   IF    ( KANACHK-RC2     =   7 )
                       MOVE    KANACHK-OUT-INPUT
                                           TO  SPA-GMN-RSIIRYOCDN 
                   END-IF
                   MOVE    "0004"          TO  SPA-ERRCD
                   MOVE    2               TO  SPA-GMN-CUR
                   GO  TO  4103-RSIIRYOCDN-CHK-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-RSIIRYOKBN      =   "1" )
               IF    ( SPA-GMN-RSIIRYOCDN  =   SPACE )
                   MOVE    2               TO  SPA-GMN-CUR
                   MOVE    "0003"          TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       4103-RSIIRYOCDN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数単価区分ェック
      *****************************************************************
       4101-TENKBN-CHK-SEC             SECTION.
      *
           IF    ( SPA-GMN-TENKBN      =   SPACE )
               IF    ( SPA-GMN-RSIIRYOKBN  =   "1" )
                   MOVE    "0003"                 TO  SPA-ERRCD
                   MOVE    3                      TO  SPA-GMN-CUR
               END-IF
           ELSE
               MOVE    SPA-GMN-TENKBN      TO  WRK-CMB-CD
               PERFORM 4200-TENKBNLST-CHK-SEC
               IF    ( WRK-CMB-ITM         =   SPACE )
                   MOVE    "0002"          TO  SPA-ERRCD
                   MOVE    3               TO  SPA-GMN-CUR
               ELSE
                   MOVE    WRK-CMB-ITM     TO  SPA-GMN-TENKBN-G
               END-IF
           END-IF
      *
           .
       4101-TENKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    文書料（消費税）チェック
      *****************************************************************
       4101-TAXKBN-CHK-SEC       SECTION.
      *
           IF    ( SPA-GMN-TAXKBN      =   SPACE )
               MOVE    SPA-GMN-TAXKBNLST (1)
                                       TO  SPA-GMN-TAXKBN-G
           ELSE
               MOVE    SPA-GMN-TAXKBN  TO  WRK-CMB-CD
               PERFORM 4200-TAXKBNLST-CHK-SEC
               IF    ( WRK-CMB-ITM         =   SPACE )
                   MOVE    SPA-GMN-TAXKBNLST (1)
                                       TO  SPA-GMN-TAXKBN-G
               ELSE
                   MOVE    WRK-CMB-ITM TO  SPA-GMN-TAXKBN-G
               END-IF
           END-IF
           .
       4101-TAXKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    自賠責食事療養費チェック
      *****************************************************************
       4101-SKJKBN-CHK-SEC       SECTION.
      *
           IF    ( SPA-GMN-SKJKBN      =   SPACE )
               MOVE    SPA-GMN-SKJKBNLST (1)
                                       TO  SPA-GMN-SKJKBN-G
           ELSE
               MOVE    SPA-GMN-SKJKBN  TO  WRK-CMB-CD
               PERFORM 4200-SKJKBNLST-CHK-SEC
               IF    ( WRK-CMB-ITM         =   SPACE )
                   MOVE    SPA-GMN-SKJKBNLST (1)
                                       TO  SPA-GMN-SKJKBN-G
               ELSE
                   MOVE    WRK-CMB-ITM TO  SPA-GMN-SKJKBN-G
               END-IF
           END-IF
           .
       4101-SKJKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特定器材等消費税区分チェック
      *****************************************************************
       4101-KIZAITAXKBN-CHK-SEC        SECTION.
      *
           IF    ( SPA-GMN-KIZAITAXKBN      =   SPACE )
               MOVE    SPA-GMN-KIZAITAXKBNLST (1)
                                       TO  SPA-GMN-KIZAITAXKBN-G
           ELSE
               MOVE    SPA-GMN-KIZAITAXKBN  TO  WRK-CMB-CD
               PERFORM 4200-KIZAITAXKBNLST-CHK-SEC
               IF    ( WRK-CMB-ITM         =   SPACE )
                   MOVE    SPA-GMN-KIZAITAXKBNLST (1)
                                       TO  SPA-GMN-KIZAITAXKBN-G
               ELSE
                   MOVE    WRK-CMB-ITM TO  SPA-GMN-KIZAITAXKBN-G
               END-IF
           END-IF
      *
           .
       4101-KIZAITAXKBN-CHK-EXT.
           EXIT.
      *     
      *****************************************************************
      *    固定帯加算等取扱チェック
      *****************************************************************
       4101-KOTEIKBN-CHK-SEC        SECTION.
      *
           IF    ( SPA-GMN-KOTEIKBN     =   SPACE )
               MOVE    SPA-GMN-KOTEIKBNLST (2)
                                       TO  SPA-GMN-KOTEIKBN-G
           ELSE
               MOVE    SPA-GMN-KOTEIKBN    TO  WRK-CMB-CD
               PERFORM 4200-KOTEIKBNLST-CHK-SEC
               IF    ( WRK-CMB-ITM         =   SPACE )
                   MOVE    SPA-GMN-KOTEIKBNLST (2)
                                       TO  SPA-GMN-KOTEIKBN-G
               ELSE
                   MOVE    WRK-CMB-ITM TO  SPA-GMN-KOTEIKBN-G
               END-IF
           END-IF
      *
           .
       4101-KOTEIKBN-CHK-EXT.
           EXIT.
      *     
      *****************************************************************
      *    労災請求書印字チェック
      *****************************************************************
       4101-RSIPRT-CHK-SEC        SECTION.
      *
           IF    ( SPA-GMN-RSIPRT     =   SPACE )
               MOVE    SPA-GMN-RSIPRTLST (1)
                                       TO  SPA-GMN-RSIPRT-G
           ELSE
               MOVE    SPA-GMN-RSIPRT    TO  WRK-CMB-CD
               PERFORM 4200-RSIPRTLST-CHK-SEC
               IF    ( WRK-CMB-ITM         =   SPACE )
                   MOVE    SPA-GMN-RSIPRTLST (1)
                                       TO  SPA-GMN-RSIPRT-G
               ELSE
                   MOVE    WRK-CMB-ITM TO  SPA-GMN-RSIPRT-G
               END-IF
           END-IF
      *
           .
       4101-RSIPRT-CHK-EXT.
           EXIT.
      *     
      *****************************************************************
      *    損傷区分１チェック
      *****************************************************************
       4106-SONSHOUKBN1-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-SONSHOUKBN1 =   SPACE
               MOVE    SPACE               TO  SPA-GMN-SONSHOUKBN2
               MOVE    SPACE               TO  SPA-GMN-SONSHOUNAME
      ******** MOVE    99                  TO  SPA-GMN-CUR
           ELSE   
               INITIALIZE                  ORCSNUMAREA
               MOVE    SPA-GMN-SONSHOUKBN1 TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                           ORCSNUMAREA
               IF     (SNUM-RC         NOT =   ZERO  )   OR
                      (SNUM-MINKBN     NOT =   SPACE )   OR
                      (SNUM-SYOKBN     NOT =   SPACE )
                   MOVE    "0007"              TO  SPA-ERRCD
                   MOVE    5                   TO  SPA-GMN-CUR
                   GO  TO  4106-SONSHOUKBN1-CHK-EXT
               ELSE
                   MOVE    SNUM-OUTNUM        TO  WRK-NUM
                   MOVE    WRK-NUM            TO  SPA-GMN-SONSHOUKBN1
               END-IF
      *
           END-IF
           .
       4106-SONSHOUKBN1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    損傷区分２区分ェック
      *****************************************************************
       4104-SONSHOUKBN2-CHK-SEC       SECTION.
      *
      *
           IF      SPA-GMN-SONSHOUKBN2 =   SPACE
               CONTINUE
           ELSE
               INITIALIZE              ORCSNUMAREA
               MOVE    SPA-GMN-SONSHOUKBN2 TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                           ORCSNUMAREA
               IF     (SNUM-RC         NOT =   ZERO  )   OR
                      (SNUM-MINKBN     NOT =   SPACE )   OR
                      (SNUM-SYOKBN     NOT =   SPACE )
                   MOVE    "0007"              TO  SPA-ERRCD
                   MOVE    6                   TO  SPA-GMN-CUR
                   GO  TO  4104-SONSHOUKBN2-CHK-EXT
               END-IF
           END-IF
      *
      *    入力変更がない時、そのままとする
           IF      SPA-MAE-SONSHOUKBN      =   SPA-GMN-SONSHOUKBN
               GO  TO  4104-SONSHOUKBN2-CHK-EXT
           ELSE
               MOVE    SPA-GMN-SONSHOUKBN  TO  SPA-MAE-SONSHOUKBN
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-MAX
               IF      SPA-GMN-SONSHOUKBN
                                   =   SPA-NAI-TSONSHOUKBN (IDY)
                   MOVE    SPA-GMN-TSONSHOUNAME (IDY)
                                               TO  SPA-GMN-SONSHOUNAME
                   MOVE    SPA-GMN-MAX     TO  IDY
               END-IF 
           END-PERFORM
           .
       4104-SONSHOUKBN2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    損傷名称チェック
      *****************************************************************
       4105-SONSHOUNAME-CHK-SEC       SECTION.
      *
           IF      (FLG-TOUROKU        =   1 )  OR
                   (WRK-MCP-WIDGET     =   "SONSHOUNAME")
               CONTINUE
           ELSE
               GO  TO  4105-SONSHOUNAME-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-MAX
               IF      SPA-GMN-SONSHOUKBN
                                   =   SPA-NAI-TSONSHOUKBN (IDY)
                   MOVE    IDY             TO  IDX
                   MOVE    SPA-GMN-MAX     TO  IDY
               END-IF
           END-PERFORM
      *
           IF    ( IDX                 =   ZERO )
               IF    ( SPA-GMN-MAX    >=  WRK-CONS-LINE-MAX )
                   MOVE    7                   TO  SPA-GMN-CUR
                   MOVE    "0010"              TO  SPA-ERRCD
                   GO  TO  4105-SONSHOUNAME-CHK-EXT
               END-IF
      *
               COMPUTE SPA-GMN-MAX =   SPA-GMN-MAX +   1
      *
               MOVE    SPA-GMN-MAX         TO  IDX
               MOVE    SPA-GMN-SONSHOUKBN  TO  SPA-NAI-TSONSHOUKBN (IDX)
               MOVE    SPA-GMN-SONSHOUKBN1 TO  SPA-GMN-TSONSHOUKBN1(IDX)
               IF      SPA-GMN-SONSHOUKBN2
                                       NOT =   SPACE
                   MOVE    "-"         TO  SPA-GMN-TSONSHOUKBN-FL  (IDX)
                   MOVE    SPA-GMN-SONSHOUKBN2 
                                       TO  SPA-GMN-TSONSHOUKBN2    (IDX)
               END-IF
               MOVE    SPA-GMN-SONSHOUNAME
                                       TO  SPA-GMN-TSONSHOUNAME (IDX)
               PERFORM 41051-SONSHOLIST-SORT-SEC
           ELSE
               MOVE    SPA-GMN-SONSHOUNAME
                                       TO  SPA-GMN-TSONSHOUNAME (IDX)
               IF    ( SPA-GMN-SONSHOUNAME =   SPACE )
                   COMPUTE WRK-STIDX   =   IDX     +   1
                   PERFORM VARYING IDX1    FROM    WRK-STIDX   BY  1
                           UNTIL ( IDX1    >   SPA-GMN-MAX )
                       MOVE    SPA-GMN-TBL-G  (IDX1)
                                           TO  SPA-GMN-TBL-G (IDX1 - 1)
                       MOVE    SPA-NAI-TBLO   (IDX1)
                                           TO  SPA-NAI-TBLO  (IDX1 - 1)
                   END-PERFORM
      *
                   INITIALIZE              SPA-GMN-TBL-G  (SPA-GMN-MAX)
                                           SPA-NAI-TBLO   (SPA-GMN-MAX)
      *
                   COMPUTE SPA-GMN-MAX =   SPA-GMN-MAX -  1
      *
               END-IF
           END-IF
      *
           INITIALIZE                      SPA-GMN-KOUMOKU1
           MOVE    ZERO                TO  SPA-NAI-SELNO
      *
           .
       4105-SONSHOUNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    損傷区分リストソート処理
      *****************************************************************
       41051-SONSHOLIST-SORT-SEC       SECTION.
      *
           MOVE        1               TO  FLG-SONSHOULST-ROW
      *
           PERFORM VARYING IDX1    FROM    2   BY  1
                   UNTIL ( IDX1    >   SPA-GMN-MAX )
               COMPUTE WRK-STIDX   =   IDX1    -   1
      *
               MOVE    SPA-GMN-TSONSHOUKBN (IDX1)
                                   TO  SRT-SONSHO-GMN-TSONSHOUKBN
               MOVE    SPA-GMN-TSONSHOUNAME (IDX1)
                                   TO  SRT-SONSHO-TSONSHOUNAME
               MOVE    SPA-NAI-TSONSHOUKBN (IDX1)
                                   TO  SRT-SONSHO-NAI-TSONSHOUKBN
      *
               PERFORM VARYING IDX2    FROM    WRK-STIDX   BY  -1
                       UNTIL ( IDX2    <   1 )
                          OR ( SRT-SONSHO-NAI-TSONSHOUKBN
                                       >=  SPA-NAI-TSONSHOUKBN (IDX2) )
      *
                   MOVE    SPA-GMN-TSONSHOUKBN  (IDX2)
                                   TO  SPA-GMN-TSONSHOUKBN  (IDX2 + 1)
                   MOVE    SPA-GMN-TSONSHOUNAME (IDX2)
                                   TO  SPA-GMN-TSONSHOUNAME (IDX2 + 1)
                   MOVE    SPA-NAI-TSONSHOUKBN  (IDX2)
                                   TO  SPA-NAI-TSONSHOUKBN  (IDX2 + 1)
      *
               END-PERFORM
      *
               MOVE    SRT-SONSHO-GMN-TSONSHOUKBN
                                   TO  SPA-GMN-TSONSHOUKBN  (IDX2 + 1)
               MOVE    SRT-SONSHO-TSONSHOUNAME
                                   TO  SPA-GMN-TSONSHOUNAME (IDX2 + 1)
               MOVE    SRT-SONSHO-NAI-TSONSHOUKBN
                                   TO  SPA-NAI-TSONSHOUKBN  (IDX2 + 1)
           END-PERFORM
      *
           .
       41051-SONSHOLIST-SORT-EXT.
           EXIT.
      *****************************************************************
      *    労災指定医療機関区分コンボチェック
      *****************************************************************
       4200-RSIIRYOKBNLST-CHK-SEC      SECTION.
      *
           INITIALIZE                WRK-CMB-ITM-G
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL ( IDY             >   SPA-GMN-RSIIRYOKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( WRK-CMB-CD  =   SPA-GMN-RSIIRYOKBNL (IDY) )
                   MOVE    SPA-GMN-RSIIRYOKBNLST (IDY)
                                           TO  WRK-CMB-ITM
               END-IF
           END-PERFORM
      *
           .
       4200-RSIIRYOKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    点数単価区分コンボェック
      *****************************************************************
       4200-TENKBNLST-CHK-SEC          SECTION.
      *
           INITIALIZE                      WRK-CMB-ITM-G
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL ( IDY >       SPA-GMN-TENKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( WRK-CMB-CD      =   SPA-GMN-TENKBNL (IDY) )
                   MOVE    SPA-GMN-TENKBNLST (IDY)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-TENKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    文書料（消費税）コンボチェック
      *****************************************************************
       4200-TAXKBNLST-CHK-SEC          SECTION.
      *
           INITIALIZE                      WRK-CMB-ITM-G
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL ( IDY >       SPA-GMN-TAXKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( WRK-CMB-CD      =   SPA-GMN-TAXKBNL (IDY) )
                   MOVE    SPA-GMN-TAXKBNLST (IDY)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-TAXKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    自賠責食事療養費コンボチェック
      *****************************************************************
       4200-SKJKBNLST-CHK-SEC          SECTION.
      *
           INITIALIZE                      WRK-CMB-ITM-G
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL ( IDY >       SPA-GMN-SKJKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( WRK-CMB-CD      =   SPA-GMN-SKJKBNL (IDY) )
                   MOVE    SPA-GMN-SKJKBNLST (IDY)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-SKJKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    自賠責特定器材等消費税区分コンボチェック処理
      *****************************************************************
       4200-KIZAITAXKBNLST-CHK-SEC         SECTION.
      *
           INITIALIZE                      WRK-CMB-ITM-G
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL ( IDY >       SPA-GMN-KIZAITAXKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( WRK-CMB-CD      =   SPA-GMN-KIZAITAXKBNL (IDY) )
                   MOVE    SPA-GMN-KIZAITAXKBNLST (IDY)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-KIZAITAXKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    固定帯加算等取扱コンボチェック処理
      *****************************************************************
       4200-KOTEIKBNLST-CHK-SEC         SECTION.
      *
           INITIALIZE                      WRK-CMB-ITM-G
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL ( IDY >       SPA-GMN-KOTEIKBN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( WRK-CMB-CD      =   SPA-GMN-KOTEIKBNL (IDY) )
                   MOVE    SPA-GMN-KOTEIKBNLST (IDY)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-KOTEIKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    労災請求書コンボチェック処理
      *****************************************************************
       4200-RSIPRTLST-CHK-SEC         SECTION.
      *
           INITIALIZE                      WRK-CMB-ITM-G
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL ( IDY >       SPA-GMN-RSIPRT-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( WRK-CMB-CD      =   SPA-GMN-RSIPRTL (IDY) )
                   MOVE    SPA-GMN-RSIPRTLST (IDY)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-RSIPRTLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41015-LIST1SEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-MAX
               IF      W13-SONSHOUKBN-SELECT (IDX)
                                               =   "T"
                   IF      IDX             =   SPA-NAI-SELNO 
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNO
                       MOVE    SPA-GMN-MAX     TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-SELNO 
           END-IF
      *
           MOVE    SPA-NAI-TSONSHOUKBN1 (SPA-NAI-SELNO)
                                       TO  SPA-GMN-SONSHOUKBN1
           MOVE    SPA-NAI-TSONSHOUKBN2 (SPA-NAI-SELNO)
                                       TO  SPA-GMN-SONSHOUKBN2
           MOVE    SPA-GMN-TSONSHOUNAME (SPA-NAI-SELNO)
                                       TO  SPA-GMN-SONSHOUNAME
      *
           MOVE    SPA-GMN-SONSHOUKBN1 TO  W13-SONSHOUKBN1
           MOVE    SPA-GMN-SONSHOUKBN2 TO  W13-SONSHOUKBN2
           MOVE    SPA-GMN-SONSHOUNAME TO  W13-SONSHOUNAME
      *
           .
       41015-LIST1SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理（特定器材リスト）
      *****************************************************************
       41015-KIZAILST-SEC              SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN-KIZAITBL-SEL
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL ( IDX     >       SPA-GMN-KIZAITBL-MAX )
                     OR  ( SPA-GMN-KIZAITBL-SEL
                                   >       ZERO )
      *
               IF    ( W13-KIZAILIST-SELECT (IDX)  =   "T" )
      *
                   MOVE    IDX         TO  SPA-GMN-KIZAITBL-SEL
      *
                   IF    ( SPA-NAI-KIZAITBL-FLG        =   1 )
                       IF    ( SPA-GMN-TSRYCD-MARK (IDX)   =   1 )
                           MOVE    ZERO    TO  SPA-GMN-TSRYCD-MARK (IDX)
                           MOVE    SPA-GMN-TSRYCD (IDX)
                                           TO  WRK-CHK-SRYCD
                           PERFORM 410151-KIZAICD-DEL-SEC
                       ELSE
                           MOVE    IDX     TO  IDX-LST
                           PERFORM 410151-KIZAICD-SET-SEC
                           IF    ( SPA-ERRCD   =   SPACE )
                               MOVE    1   TO  SPA-GMN-TSRYCD-MARK (IDX)
                           END-IF
                       END-IF
                   END-IF
      *
               END-IF
      *
           END-PERFORM
      *
           .
       41015-KIZAILST-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象外特定器材コード設定処理
      *****************************************************************
       410151-KIZAICD-SET-SEC              SECTION.
      *
           IF    ( SPA-NAI-KIZAITBL-MAX   >=   WRK-CONS-SYS-KIZAI-MAX )
               MOVE    "0011"          TO  SPA-ERRCD
               GO  TO  410151-KIZAICD-SET-EXT
           END-IF
      *
           COMPUTE SPA-NAI-KIZAITBL-MAX
               =   SPA-NAI-KIZAITBL-MAX
               +   1
      *
           MOVE    SPA-GMN-TSRYCD (IDX-LST)
                                       TO  SPA-NAI-TSRYCD
                                                 (SPA-NAI-KIZAITBL-MAX)
           MOVE    SPA-GMN-TSRYCDNAME (IDX-LST)
                                       TO  SPA-NAI-TSRYCDNAME
                                                 (SPA-NAI-KIZAITBL-MAX)
      *
           PERFORM VARYING IDX1    FROM    2   BY  1
                   UNTIL ( IDX1    >   SPA-NAI-KIZAITBL-MAX )
      *
               COMPUTE WRK-STIDX   =   IDX1    -   1
      *
               MOVE    SPA-NAI-TSRYCD (IDX1)
                                   TO  SRT-KIZAI-TSRYCD
               MOVE    SPA-NAI-TSRYCDNAME (IDX1)
                                   TO  SRT-KIZAI-TSRYCDNAME
      *
               PERFORM VARYING IDX2    FROM    WRK-STIDX   BY  -1
                       UNTIL ( IDX2    <   1 )
                          OR ( SRT-KIZAI-TSRYCD
                                       >=  SPA-NAI-TSRYCD (IDX2) )
      *
                   MOVE    SPA-NAI-TSRYCD  (IDX2)
                                   TO  SPA-NAI-TSRYCD  (IDX2 + 1)
                   MOVE    SPA-NAI-TSRYCDNAME (IDX2)
                                   TO  SPA-NAI-TSRYCDNAME (IDX2 + 1)
      *
               END-PERFORM
      *
               MOVE    SRT-KIZAI-TSRYCD
                                   TO  SPA-NAI-TSRYCD  (IDX2 + 1)
               MOVE    SRT-KIZAI-TSRYCDNAME
                                   TO  SPA-NAI-TSRYCDNAME (IDX2 + 1)
           END-PERFORM
      *
           .
       410151-KIZAICD-SET-EXT.
           EXIT.
      *****************************************************************
      *    対象外特定器材リストコード削除処理
      *****************************************************************
       410151-KIZAICD-DEL-SEC              SECTION.
      *
           MOVE    ZERO            TO  IDX-LST
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   SPA-NAI-KIZAITBL-MAX  )
                    OR   ( IDX-LST >   ZERO )
      *
               IF    ( WRK-CHK-SRYCD   =   SPA-NAI-TSRYCD (IDX1))
                   MOVE    IDX1    TO  IDX-LST
               END-IF
           END-PERFORM
      *
           IF    ( IDX-LST         >   ZERO )
      *
               COMPUTE WRK-STIDX   =   IDX-LST +   1
      *
               PERFORM VARYING IDX2    FROM    WRK-STIDX    BY  1
                       UNTIL ( IDX2    >   SPA-NAI-KIZAITBL-MAX  )
                   MOVE    SPA-NAI-KIZAITBL-G (IDX2)
                                   TO  SPA-NAI-KIZAITBL-G (IDX2 - 1)
               END-PERFORM
      *
               INITIALIZE  SPA-NAI-KIZAITBL-G (SPA-NAI-KIZAITBL-MAX)
               COMPUTE SPA-NAI-KIZAITBL-MAX
                   =   SPA-NAI-KIZAITBL-MAX    -   1
      *
           END-IF
      *
           .
       410151-KIZAICD-DEL-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W13"               TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-W01KYOUTU
      *
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
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                               SECTION.
      *
           MOVE    "1002"              TO  SPA-WIDCD
      *
           .    
       403-DEL-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       4031-DEL-SEC                              SECTION.
      *
           MOVE    "4001"              TO  WRK-KANRICD
           PERFORM 4032-DEL-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "1004"          TO  SPA-ERRCD
               GO  TO  4031-DEL-EXT
           END-IF
      *
           MOVE    "4002"              TO  WRK-KANRICD
           PERFORM 4032-DEL-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "1005"          TO  SPA-ERRCD
               GO  TO  4031-DEL-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       4031-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理削除処理
      *****************************************************************
       4032-DEL-SEC                        SECTION.
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    WRK-KANRICD             TO  SYS-KANRICD
           MOVE    SPA-W01-STYUKYMD        TO  SYS-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-EDYUKYMD
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           MOVE    "DBDELETE"              TO  MCP-FUNC
           MOVE    PATH-TBL-SYSKANRI-DEL11
                                           TO  MCP-PATH
           CALL    "MCPSUB"                USING
                                           MCPAREA
                                           MCPDATA-REC
      *
           .
       4032-DEL-EXT.
           EXIT.
      *****************************************************************
      *       登録前処理
      *****************************************************************
       490-TOUROKU-SEC              SECTION.
      *
      *    入力チェック処理
           MOVE    1                   TO  FLG-TOUROKU
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      490-TOUROKU-EXT
           END-IF
      *
           PERFORM 4900-KANRENCHK-SEC
           IF      SPA-ERRCD        =   SPACE
              MOVE    "1001"           TO  SPA-WIDCD
           END-IF
      *
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
      *    労災医療機関情報
           MOVE    SPACE               TO  SYS-4001-REC
           INITIALIZE                      SYS-4001-REC
           MOVE    "4001"                  TO  SYS-4001-KANRICD
           MOVE    "*"                     TO  SYS-4001-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-4001-REC            TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"          TO  WRK-PATH
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-4001-REC
           ELSE
               MOVE    SPACE                   TO  SYS-4001-REC
               INITIALIZE                      SYS-4001-REC
               MOVE    "4001"                  TO  SYS-4001-KANRICD
               MOVE    "*"                     TO  SYS-4001-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-4001-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-4001-EDYUKYMD
           MOVE    SPA-GMN-RSIIRYOKBN      TO  SYS-4001-RSIIRYOKBN
           MOVE    SPA-GMN-TENKBN          TO  SYS-4001-TENKBN
           MOVE    SPA-GMN-RSIIRYOCDN      TO  SYS-4001-RSIIRYOCDN
           MOVE    SPA-GMN-KSNRATE         TO  SYS-4001-KSNRATE1
           MOVE    SPA-GMN-TAXKBN          TO  SYS-4001-TAXKBN
           MOVE    SPA-GMN-SKJKBN          TO  SYS-4001-SKJKBN
           MOVE    SPA-GMN-KIZAITAXKBN     TO  SYS-4001-TAXKBN-KZI
           MOVE    SPA-GMN-KOTEIKBN        TO  SYS-4001-KOTEIKBN
           MOVE    SPA-GMN-RSIPRT          TO  SYS-4001-RSIPRTKBN
           MOVE    SYS-4001-REC            TO  SYSKANRI-REC
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
               GO  TO  490-KOUSHIN-EXT
           END-IF      
      *
      *    労災保険損傷区分名称削除処理
           INITIALIZE                  SYS-4002-REC
           MOVE    "4002"              TO  SYS-4002-KANRICD
      *    MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYS-4002-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY2"     TO  WRK-PATH 
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               INITIALIZE                      SYS-4002-REC
               MOVE    "4002"                  TO  SYS-4002-KANRICD
               MOVE    SPA-W01-STYUKYMD        TO  SYS-4002-STYUKYMD
               MOVE    SPA-W01-STYUKYMD        TO  SYS-4002-EDYUKYMD
               MOVE    SYS-4002-REC            TO  MCPDATA-REC
               MOVE    "DBDELETE"              TO  MCP-FUNC
               MOVE    PATH-TBL-SYSKANRI-DEL11
                                               TO  MCP-PATH
               CALL    "MCPSUB"                USING
                                               MCPAREA
                                               MCPDATA-REC
      *
               IF      MCP-RC              NOT =   ZERO 
                   MOVE    "1001"                  TO  SPA-ERRCD
                   DISPLAY "SYSKANRI-KEY =>" SYS-4002-KEY 
                   GO  TO  490-KOUSHIN-EXT
               END-IF
           END-IF
      *
      *    労災保険損傷区分名称登録処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-MAX
               IF      SPA-GMN-TSONSHOUNAME(IDX)
                                       NOT  =   SPACE   
                   INITIALIZE                  SYS-4002-REC
                   MOVE    "4002"              TO  SYS-4002-KANRICD
                   MOVE    SPA-NAI-TSONSHOUKBN (IDX)
                                           TO  SYS-4002-KBNCD
                   MOVE    SPA-W01-STYUKYMD    TO  SYS-4002-STYUKYMD
                   MOVE    SPA-W01-EDYUKYMD    TO  SYS-4002-EDYUKYMD
                   MOVE    SPA-GMN-TSONSHOUNAME(IDX)
                                           TO  SYS-4002-SONSHOUNAME
                   MOVE    SYS-4002-REC        TO  MCPDATA-REC
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
      *
                   IF      MCP-RC          NOT =   ZERO 
                       MOVE    "1002"              TO  SPA-ERRCD
                       DISPLAY "2002 SYSKANRI-KEY =>" SYS-4002-KEY 
                       GO  TO  490-KOUSHIN-EXT
                   END-IF
               END-IF    
           END-PERFORM
      *
           PERFORM 4901-SYS4003-UPD-SEC
           IF    ( SPA-ERRCD           NOT =   SPACE )
               GO  TO  490-KOUSHIN-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       490-KOUSHIN-EXT.
           EXIT.
      *****************************************************************
      *    特定器材等消費税対象外コード更新処理
      *****************************************************************
       4901-SYS4003-UPD-SEC           SECTION.
      *
           INITIALIZE                  SYS-4003-REC
           MOVE    "4003"              TO  SYS-4003-KANRICD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-4003-STYUKYMD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-4003-EDYUKYMD
           MOVE    SYS-4003-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    PATH-TBL-SYSKANRI-DEL11
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF    ( MCP-RC              NOT =   ZERO )
               MOVE    "1005"                  TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-4003-KEY 
               GO  TO  4901-SYS4003-UPD-EXT
           END-IF
      *
           INITIALIZE                      SYS-4003-REC
           MOVE    "4003"              TO  SYS-4003-KANRICD
           MOVE    "*"                 TO  SYS-4003-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-4003-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-4003-EDYUKYMD
      *
      *    特定器材等消費税対象外コード登録処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL ( IDX >       SPA-NAI-KIZAITBL-MAX )
      *
               MOVE    SPA-NAI-TSRYCD (IDX)
                                       TO  SYS-4003-SRYCD (IDX)
           END-PERFORM
      *
           MOVE    SYS-4003-REC        TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    PATH-TBL-SYSKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "1006"          TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-4003-KEY
           END-IF
      *
           .
       4901-SYS4003-UPD-EXT.
           EXIT.
      *****************************************************************
      *    特定器材リスト切替処理
      *****************************************************************
       490-KIZAILST-CHG-SEC           SECTION.
      *
           IF    ( SPA-NAI-KIZAITBL-FLG    =   ZERO )
               MOVE    1               TO  SPA-NAI-KIZAITBL-FLG
               MOVE    1               TO  SPA-NAI-KIZAITBL-PAGE
               PERFORM 3001-KIZAILST-TNS-SEC
           ELSE
               MOVE    ZERO            TO  SPA-NAI-KIZAITBL-FLG
               PERFORM 3001-KIZAILST-SYS-SEC
           END-IF
      *
           .
       490-KIZAILST-CHG-EXT.
           EXIT.
      *****************************************************************
      *    特定器材リスト切替処理
      *****************************************************************
       490-KIZAILST-DEL-SEC           SECTION.
      *
           IF    ( SPA-GMN-KIZAITBL-SEL    >  ZERO )
            AND  ( SPA-GMN-KIZAITBL-SEL    <= SPA-NAI-KIZAITBL-MAX )
               MOVE    SPA-NAI-TSRYCD (SPA-GMN-KIZAITBL-SEL)
                                       TO  WRK-CHK-SRYCD
               PERFORM 410151-KIZAICD-DEL-SEC
               PERFORM 3001-KIZAILST-SYS-SEC
               MOVE    ZERO            TO  FLG-KIZAILST-ROW
           END-IF
      *
           .
       490-KIZAILST-DEL-EXT.
           EXIT.
      *****************************************************************
      *    特定器材リスト前頁処理
      *****************************************************************
       490-KIZAILST-PREV-SEC           SECTION.
      *
           IF    ( SPA-NAI-KIZAITBL-PAGE   >   1 )
               COMPUTE SPA-NAI-KIZAITBL-PAGE
                   =   SPA-NAI-KIZAITBL-PAGE
                   -   1
               PERFORM 3001-KIZAILST-TNS-SEC
           END-IF
      *
           .
       490-KIZAILST-PREV-EXT.
           EXIT.
      *****************************************************************
      *    特定器材リスト次頁処理
      *****************************************************************
       490-KIZAILST-NEXT-SEC           SECTION.
      *
           IF    ( SPA-GMN-KIZAITBL-NEXT   =   1 )
               COMPUTE SPA-NAI-KIZAITBL-PAGE
                   =   SPA-NAI-KIZAITBL-PAGE
                   +   1
               PERFORM 3001-KIZAILST-TNS-SEC
           END-IF
      *
           .
       490-KIZAILST-NEXT-EXT.
           EXIT.
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC           SECTION.
      *
      *    MOVE    SPACE                TO  SPA-ERRCD
      *    MOVE    SPA-GMN-CUR          TO  WRK-GMN-CUR 
      *
      *    PERFORM 4100-RSIIRYOKBN-CHK-SEC
      *    IF      SPA-ERRCD            =   SPACE
      *        PERFORM 4103-RSIIRYOCDN-CHK-SEC
      *    END-IF    
      *    IF      SPA-ERRCD            =   SPACE
      *        PERFORM 4101-TENKBN-CHK-SEC
      *    END-IF    
      *    IF      SPA-ERRCD            =   SPACE
      *        PERFORM 4106-SONSHOUKBN1-CHK-SEC
      *    END-IF             
      *    IF      SPA-ERRCD            =   SPACE
      *        PERFORM 4104-SONSHOUKBN2-CHK-SEC
      *    END-IF             
      *
      *    IF      SPA-ERRCD            =   SPACE
      *        MOVE    WRK-GMN-CUR          TO  SPA-GMN-CUR
      *****END-IF             
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
           MOVE    "W13    "           TO  MCP-WINDOW.
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
           MOVE    W13-SONSHOUKBN-ROW       TO  WRK-SONSHOUKBN-ROW
           MOVE    W13-KIZAILST-ROW         TO  WRK-KIZAILST-ROW
      *
           INITIALIZE                       W13
      *
           IF    ( FLG-SONSHOULST-ROW       =   1 )
               MOVE    ZERO                 TO  W13-SONSHOUKBN-ROW
               MOVE    ZERO                 TO  W13-SONSHOUKBN-ROWATTR
           ELSE
               MOVE    WRK-SONSHOUKBN-ROW   TO  W13-SONSHOUKBN-ROW
               MOVE    ZERO                 TO  W13-SONSHOUKBN-ROWATTR
           END-IF
      *
           IF    ( FLG-KIZAILST-ROW         =   1 )
               MOVE    ZERO                 TO  W13-KIZAILST-ROW
               MOVE    ZERO                 TO  W13-KIZAILST-ROWATTR
           ELSE
               MOVE    WRK-KIZAILST-ROW     TO  W13-KIZAILST-ROW
               MOVE    ZERO                 TO  W13-KIZAILST-ROWATTR
           END-IF
      *
           IF    ( SPA-NAI-KIZAITBL-FLG     =   ZERO )
               MOVE    "※特定器材等消費税有りの場合の対象外コード"
                                            TO  W13-LBLKIZAILST
           ELSE
               MOVE    "※特定器材等のコード"
                                            TO  W13-LBLKIZAILST
           END-IF
      *
           MOVE    SPA-GMN-STYUKYMD         TO  W13-YUKOSTYMD
           MOVE    SPA-GMN-EDYUKYMD         TO  W13-YUKOEDYMD
      *
           MOVE    SPA-GMN-RSIIRYOKBN-G     TO  W13-RSIIRYOKBN
           MOVE    SPA-GMN-KSNRATE          TO  W13-KSNRATE 
           MOVE    SPA-GMN-TENKBN-G         TO  W13-TENKBN
           MOVE    SPA-GMN-TAXKBN-G         TO  W13-TAXKBN
           MOVE    SPA-GMN-SKJKBN-G         TO  W13-SKJKBN
           MOVE    SPA-GMN-KIZAITAXKBN-G    TO  W13-KIZAITAXKBN
           MOVE    SPA-GMN-KOTEIKBN-G       TO  W13-KOTEIKBN
           MOVE    SPA-GMN-RSIPRT-G         TO  W13-RSIPRT
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-RSIIRYOKBN-MAX
               MOVE    SPA-GMN-RSIIRYOKBNLST (IDY)
                                       TO  W13-RSIIRYOKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-RSIIRYOKBN-MAX
                                       TO  W13-RSIIRYOKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-TENKBN-MAX
               MOVE    SPA-GMN-TENKBNLST (IDY)
                                       TO  W13-TENKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-TENKBN-MAX  TO  W13-TENKBN-COUNT 
      *
           MOVE    SPA-GMN-RSIIRYOCDN  TO  W13-RSIIRYOCDN
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-TAXKBN-MAX
               MOVE    SPA-GMN-TAXKBNLST (IDY)
                                       TO  W13-TAXKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-TAXKBN-MAX  TO  W13-TAXKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SKJKBN-MAX
               MOVE    SPA-GMN-SKJKBNLST (IDY)
                                       TO  W13-SKJKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SKJKBN-MAX  TO  W13-SKJKBN-COUNT 
      *
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-KIZAITAXKBN-MAX
               MOVE    SPA-GMN-KIZAITAXKBNLST (IDY)
                                       TO  W13-KIZAITAXKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-KIZAITAXKBN-MAX
                                       TO  W13-KIZAITAXKBN-COUNT
      *
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-KOTEIKBN-MAX
               MOVE    SPA-GMN-KOTEIKBNLST (IDY)
                                       TO  W13-KOTEIKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-KOTEIKBN-MAX
                                       TO  W13-KOTEIKBN-COUNT
      *
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-RSIPRT-MAX
               MOVE    SPA-GMN-RSIPRTLST (IDY)
                                       TO  W13-RSIPRTLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-RSIPRT-MAX
                                       TO  W13-RSIPRT-COUNT
      *
           MOVE    SPA-GMN-SONSHOUKBN1   TO  W13-SONSHOUKBN1
      *
           MOVE    SPA-GMN-SONSHOUKBN2   TO  W13-SONSHOUKBN2
      *
           MOVE    SPA-GMN-SONSHOUNAME   TO  W13-SONSHOUNAME
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-MAX
               MOVE    SPA-GMN-TSONSHOUKBN (IDX)
                                           TO  W13-TSONSHOUKBN (IDX)
               MOVE    SPA-GMN-TSONSHOUNAME(IDX)
                                           TO  W13-TSONSHOUNAME(IDX)
               IF      IDX             =   SPA-NAI-SELNO 
                   MOVE    "T"         TO  W13-SONSHOUKBN-SELECT (IDX)
               ELSE
                   MOVE    "F"         TO  W13-SONSHOUKBN-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-MAX         TO  W13-SONSHOUKBN-COUNT    
      *
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-KIZAITBL-MAX
      *
               COMPUTE WRK-NUM2
                 =   ( SPA-NAI-KIZAITBL-PAGE   -   1 )
                 *   WRK-CONS-KIZAILST-MAX
                 +   IDX
      *
               MOVE    WRK-NUM2            TO  WRK-ZZ9
               MOVE    WRK-ZZ9             TO  W13-TNUM (IDX)
      *
               IF    ( SPA-GMN-TSRYCD-MARK (IDX)   =   1 )
                   MOVE    "*"             TO  W13-TSRYCD-MARK (IDX)
               END-IF
      *
               MOVE    SPA-GMN-TSRYCD(IDX) TO  W13-TSRYCD (IDX)
               MOVE    SPA-GMN-TSRYCDNAME(IDX)
                                           TO  W13-TSRYCDNAME(IDX)
      *
               IF  (   SPA-GMN-KIZAITBL-SEL    =   IDX )
                   MOVE    "T"             TO  W13-KIZAILIST-SELECT(IDX)
               ELSE
                   MOVE    "F"             TO  W13-KIZAILIST-SELECT(IDX)
               END-IF
      *
           END-PERFORM
      *
           MOVE    SPA-GMN-KIZAITBL-MAX    TO  W13-KIZAILST-COUNT
      *
           IF    ( SPA-NAI-KIZAITBL-FLG    =   ZERO )
               IF    ( SPA-GMN-KIZAITBL-SEL    =   ZERO )
                   MOVE    WIDGET-INSENSITIVE
                                           TO  W13-BTNDEL-STATE
               ELSE
                   MOVE    WIDGET-NORMAL   TO  W13-BTNDEL-STATE
               END-IF
           ELSE
               MOVE    WIDGET-INSENSITIVE  TO  W13-BTNDEL-STATE
           END-IF
      *
           IF    ( SPA-NAI-KIZAITBL-PAGE   >   1 )
               MOVE    WIDGET-NORMAL       TO  W13-BTNPREV-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE  TO  W13-BTNPREV-STATE
           END-IF
      *
           IF    ( SPA-GMN-KIZAITBL-NEXT   =   1 )
               MOVE    WIDGET-NORMAL       TO  W13-BTNNEXT-STATE
           ELSE
               MOVE    WIDGET-INSENSITIVE  TO  W13-BTNNEXT-STATE
           END-IF
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    業務権限非活性処理
      *****************************************************************
       510-GSRAUTH-SEC             SECTION.
      *
           MOVE    WIDGET-NORMAL       TO  W13-B03-STATE
      *
           IF    ( SPA-W01-STYUKYMD    =   ZERO )
               MOVE    WIDGET-INSENSITIVE
                                       TO  W13-B03-STATE
           END-IF
      *
           .
       51O-GSRAUTH-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "労災指定医療機関区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "点数単価区分入力エラー"      TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "労災指定のときは入力して下さい"
                                                         TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "全角入力して下さい"        TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "加算率は１００％以上で入力して下さい"
                                                         TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "数字で入力して下さい"        TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "損傷区分をこれ以上追加できません"
                                                         TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "対象外コードをこれ以上追加できません"
                                                         TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "追加ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "追加ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1004"
                   MOVE    "削除ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1005"
                   MOVE    "削除ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1006"
                   MOVE    "追加ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W13"                TO  SPA-MOTOPG
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
                   MOVE    "労災自賠医療機関情報を登録します"
                                                TO  WRK-WIDMSG
               WHEN    "1002"
                   MOVE    "労災自賠医療機関情報を削除します"
                                                TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W13"                TO  SPA-MOTOPG
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
          EVALUATE    SPA-GMN-CUR
                WHEN    1
                    MOVE  "RSIIRYOKBN"     TO   MCP-WIDGET
                WHEN    2
                    MOVE  "RSIIRYOCDN"     TO   MCP-WIDGET
                WHEN    3
                    MOVE  "TENKBN"         TO   MCP-WIDGET
                WHEN    4
                    MOVE  "TAXKBN"         TO   MCP-WIDGET
                WHEN    5
                    MOVE  "SONSHOUKBN1"    TO   MCP-WIDGET
                WHEN    6
                    MOVE  "SONSHOUKBN2"    TO   MCP-WIDGET
                WHEN    7
                    MOVE  "SONSHOUNAME"    TO   MCP-WIDGET
                WHEN    8
                    MOVE  "KSNRATE"        TO   MCP-WIDGET
                WHEN    11
                    MOVE  "SKJKBN"         TO   MCP-WIDGET
                WHEN    12
                    MOVE  "KIZAITAXKBN"    TO   MCP-WIDGET
                WHEN    13
                    MOVE  "KOTEIKBN"       TO   MCP-WIDGET
                WHEN    14
                    MOVE  "RSIPRT"         TO   MCP-WIDGET
                WHEN    99
                    MOVE  "B12"            TO   MCP-WIDGET
            END-EVALUATE
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
               WHEN    "RSIIRYOKBN"
                   MOVE    2               TO  SPA-GMN-CUR
               WHEN    "RSIIRYOCDN"
                   MOVE    3               TO  SPA-GMN-CUR
               WHEN    "TENKBN"
                   MOVE    8               TO  SPA-GMN-CUR
               WHEN    "KSNRATE"
                   MOVE    4               TO  SPA-GMN-CUR
               WHEN    "TAXKBN"
                   MOVE    11              TO  SPA-GMN-CUR
               WHEN    "SKJKBN"
                   MOVE    12              TO  SPA-GMN-CUR
               WHEN    "KIZAITAXKBN"
                   MOVE    13              TO  SPA-GMN-CUR
               WHEN    "KOTEIKBN"
                   MOVE    14              TO  SPA-GMN-CUR
               WHEN    "RSIPRT"
                   MOVE    5               TO  SPA-GMN-CUR
               WHEN    "SONSHOUKBN1"
                   IF      SPA-GMN-SONSHOUKBN1     =   SPACE
                       MOVE    99              TO  SPA-GMN-CUR
                   ELSE
                       MOVE    6               TO  SPA-GMN-CUR
                   END-IF
               WHEN    "SONSHOUKBN2"
                   MOVE    7               TO  SPA-GMN-CUR
               WHEN    "SONSHOUNAME"
                   MOVE    99              TO  SPA-GMN-CUR
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
      *    点数マスタ検索処理
      *****************************************************************
       900-TENSU-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    WRK-TNS-SRYCD   TO  TNS-SRYCD
           MOVE    WRK-TNS-YMD     TO  ORC-DBYMD
      *
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
           MOVE    "TENSU-KEY"     TO  ORC-DBPATH
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF    ( MCP-RC      =   ZERO )
               MOVE    "DBFETCH"   TO  MCP-FUNC
               MOVE    "TENSU-KEY" TO  ORC-DBPATH
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF    ( MCP-RC      =   ZERO )
                   MOVE    MCPDATA-REC
                                   TO  TNS-TENSU-REC
               ELSE
                   MOVE    1       TO  FLG-TENSU
               END-IF
           ELSE
                   MOVE    1       TO  FLG-TENSU
           END-IF
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "TENSU-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    WRK-PATH            TO  ORC-DBPATH
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
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
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
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタKEY2 FETCH処理
      *****************************************************************
       900-TENSU-KEY12S-FETCH-SEC      SECTION.
      *
           MOVE    "TENSU-KEY12S"      TO  ORC-DBPATH
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               MOVE    1               TO  FLG-TENSU
           END-IF
           .
       900-TENSU-KEY12S-FETCH-EXT.
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
