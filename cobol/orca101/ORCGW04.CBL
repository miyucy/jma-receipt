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
       PROGRAM-ID.             ORCGW04.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 患者番号構成管理情報（Ｗ０４）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.01.02    MCC-藤原     01/11/27  自由構成区分追加
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
       01  SPA-W04.
           03  SPA-W04-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD       PIC X(09).
                   07  SPA-GMN-EDYUKYMD       PIC X(09).
                   07  SPA-GMN-NEN            PIC X(04).
                   07  SPA-GMN-RENNUM         PIC 9(10).
                   07  SPA-GMN-PTID           PIC 9(10).              
                   07  SPA-GMN-PAGENO         PIC 9(01).
                   07  SPA-GMN-PTNUMKSIKBN    PIC X(01).
                   07  SPA-GMN-JIYKSI-AREA.
                       09  SPA-GMN-JIYKSIKBN      PIC X(01).
                       09  SPA-GMN-JIYKSIKETA     PIC 9(02).
                   07  SPA-GMN-HJNKSI-AREA.
                       09  SPA-GMN-HJNKSIKBN      PIC X(01).
                       09  SPA-GMN-HJNKSINENKBN   PIC X(01).
                       09  SPA-GMN-HJNKSIRENNUMKBN
                                                  PIC X(01).
                       09  SPA-GMN-HJNKSIRENNUMKETA
                                                  PIC 9(02). 
                   07  SPA-GMN-KKCKSI-AREA.
                       09  SPA-GMN-KKCKSIKBN      PIC X(01).
                       09  SPA-GMN-KKCKSIMAEKETA  PIC 9(02).
                       09  SPA-GMN-KKCKSIRENNUMKETA
                                                  PIC 9(02).
                       09  SPA-GMN-KKCKSIATOKETA  PIC 9(02).
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-STYUKYMD           PIC 9(08).
                   07  SPA-NAI-EDYUKYMD           PIC 9(08).
      *
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
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
           03  WRK-TOTAL           PIC 9(03).
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
      *    診療内容情報
           COPY  "CPSK1009.INC".
      *
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
           COPY    "WERR.INC".
           COPY    "WID1.INC".
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
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W04
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
           MOVE    SPA-W04         TO  SPA-FREE
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
           MOVE    "W04"                TO  MCP-WINDOW
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
               PERFORM 490-KOUSHIN-SEC
           END-IF
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
           INITIALIZE   SPA-W04-AREA
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
      * 
           MOVE    SPACE               TO  SYS-1009-REC
           INITIALIZE                      SYS-1009-REC
           MOVE    "1009"                  TO  SYS-1009-KANRICD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-1009-REC            TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1009-REC
               MOVE    SYS-1009-PTNUMKSIKBN
                                           TO  SPA-GMN-PTNUMKSIKBN
               MOVE    SYS-1009-JIYKSIKBN  TO  SPA-GMN-JIYKSIKBN
               MOVE    SYS-1009-JIYKSIKETA TO  SPA-GMN-JIYKSIKETA
               MOVE    SYS-1009-HJNKSIKBN  TO  SPA-GMN-HJNKSIKBN
               MOVE    SYS-1009-HJNKSINENKBN
                                           TO  SPA-GMN-HJNKSINENKBN
               MOVE    SYS-1009-HJNKSIRENNUMKBN
                                           TO  SPA-GMN-HJNKSIRENNUMKBN
               MOVE    SYS-1009-HJNKSIRENNUMKETA
                                           TO  SPA-GMN-HJNKSIRENNUMKETA
               MOVE    SYS-1009-KKCKSIKBN  TO  SPA-GMN-KKCKSIKBN 
               MOVE    SYS-1009-KKCKSIMAEKETA
                                           TO  SPA-GMN-KKCKSIMAEKETA
               MOVE    SYS-1009-KKCKSIRENNUMKETA
                                           TO  SPA-GMN-KKCKSIRENNUMKETA
               MOVE    SYS-1009-KKCKSIATOKETA
                                           TO  SPA-GMN-KKCKSIATOKETA
               MOVE    SYS-1009-NEN        TO  SPA-GMN-NEN
               MOVE    SYS-1009-RENNUM     TO  SPA-GMN-RENNUM  
               MOVE    SYS-1009-PTID       TO  SPA-GMN-PTID
           ELSE
               MOVE    SPA-SYSYMD (1:4)    TO  SPA-GMN-NEN
           END-IF     
      *  
            MOVE    1                   TO  SPA-GMN-CUR
            EVALUATE    SPA-GMN-PTNUMKSIKBN
                WHEN    "1"
                    MOVE    0               TO  SPA-GMN-PAGENO
                WHEN    "2"
                    MOVE    1               TO  SPA-GMN-PAGENO
                WHEN    "3"
                    MOVE    2               TO  SPA-GMN-PAGENO
                WHEN    OTHER
                    MOVE    0               TO  SPA-GMN-PAGENO 
           END-EVALUATE    
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
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *    タグ
               WHEN    "CLICKED"       ALSO    "N01"
               WHEN    "CLICKED"       ALSO    "N02"
               WHEN    "CLICKED"       ALSO    "N03"
                   PERFORM 440-TAG-CHANGE-SEC
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
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *
               WHEN    "ACTIVATE"      ALSO    "PTNUMKSIKBN"
                   PERFORM 4101-PTNUMKSIKBN-CHK-SEC
      *    自由構成情報タグ
               WHEN    "ACTIVATE"      ALSO    "JIYKSIKBN"
                   PERFORM 4120-JIYKSIKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "JIYKSIKETA"
                   PERFORM 4100-JIYKSIKETA-CHK-SEC
      *    標準構成情報タグ
               WHEN    "ACTIVATE"      ALSO    "HJNKSIKBN"
                   PERFORM 4112-HJNKSIKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HJNKSINENKBN"
                   PERFORM 4113-HJNKSINENKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HJNKSIRENNUMKBN"
                   PERFORM 4114-HJNKSIRENNUMKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HJNKSIRENNUMKETA" 
                   PERFORM 4115-HJNKSIRENNUMKETA-CHK-SEC
      *    拡張構成情報タグ
               WHEN    "ACTIVATE"      ALSO    "KKCKSIKBN"  
                   PERFORM 4116-KKCKSIKBN-CHK-SEC  
               WHEN    "ACTIVATE"      ALSO    "KKCKSIMAEKETA"  
                   PERFORM 4117-KKCKSIMAEKETA-CHK-SEC                
               WHEN    "ACTIVATE"      ALSO    "KKCKSIRENNUMKETA"  
                   PERFORM 4118-KKCKSIRENNUMKETA-CHK-SEC                
               WHEN    "ACTIVATE"      ALSO    "KKCKSIATOKETA"  
                   PERFORM 4119-KKCKSIATOKETA-CHK-SEC                
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号構成区分チェック
      *****************************************************************
       4101-PTNUMKSIKBN-CHK-SEC       SECTION.
      *
           MOVE    1                      TO  SPA-GMN-CUR
      *
           MOVE    W04-PTNUMKSIKBN        TO  SPA-GMN-PTNUMKSIKBN
      *
           EVALUATE    SPA-GMN-PTNUMKSIKBN
               WHEN    "1"
                   MOVE    ZERO          TO  SPA-GMN-PAGENO
                   MOVE    11            TO  SPA-GMN-CUR
                   INITIALIZE            SPA-GMN-HJNKSI-AREA
                   INITIALIZE            SPA-GMN-KKCKSI-AREA
               WHEN    "2"
                   MOVE    1             TO  SPA-GMN-PAGENO
                   MOVE    03            TO  SPA-GMN-CUR
                   INITIALIZE            SPA-GMN-JIYKSI-AREA
                   INITIALIZE            SPA-GMN-KKCKSI-AREA
               WHEN    "3"
                   MOVE    2             TO  SPA-GMN-PAGENO
                   MOVE    07            TO  SPA-GMN-CUR
                   INITIALIZE            SPA-GMN-JIYKSI-AREA
                   INITIALIZE            SPA-GMN-HJNKSI-AREA
               WHEN    OTHER
                   MOVE    "0001"            TO  SPA-ERRCD
           END-EVALUATE
           .
       4101-PTNUMKSIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自由構成区分チェック
      *****************************************************************
       4120-JIYKSIKBN-CHK-SEC       SECTION.
      *
           MOVE    11               TO  SPA-GMN-CUR
      *
           MOVE    W04-JIYKSIKBN          TO  SPA-GMN-JIYKSIKBN           
           EVALUATE    SPA-GMN-JIYKSIKBN
               WHEN    "0"
               WHEN    "1"
               WHEN    "2"
                   MOVE    2                  TO  SPA-GMN-CUR
               WHEN    OTHER    
                   MOVE    "0001"             TO  SPA-ERRCD
           END-EVALUATE
           .
       4120-JIYKSIKETA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自由構成桁数チェック
      *****************************************************************
       4100-JIYKSIKETA-CHK-SEC       SECTION.
      *
           MOVE    2                      TO  SPA-GMN-CUR
      *
           MOVE    W04-JIYKSIKETA         TO  SPA-GMN-JIYKSIKETA           
           IF      SPA-GMN-JIYKSIKETA     >   ZERO
               MOVE    99                      TO  SPA-GMN-CUR
           ELSE
               MOVE    "0001"               TO  SPA-ERRCD
           END-IF
           .
       4100-JIYKSIKETA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    標準構成区分チェック処理
      *****************************************************************
       4112-HJNKSIKBN-CHK-SEC           SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR
      *
           MOVE    W04-HJNKSIKBN            TO  SPA-GMN-HJNKSIKBN
      *
           EVALUATE    SPA-GMN-HJNKSIKBN
               WHEN    "1" THRU "4"
                   MOVE    4                   TO  SPA-GMN-CUR
               WHEN    OTHER
                       MOVE    "0001"            TO  SPA-ERRCD
           END-EVALUATE
           .
       4112-HJNKSIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    標準構成年区分チェック処理
      *****************************************************************
       4113-HJNKSINENKBN-CHK-SEC        SECTION.
      *
           MOVE    4                    TO  SPA-GMN-CUR
      *
           MOVE    W04-HJNKSINENKBN     TO  SPA-GMN-HJNKSINENKBN
      *
           EVALUATE    SPA-GMN-HJNKSINENKBN
               WHEN    "1" 
               WHEN    "2"
                   MOVE    5                   TO  SPA-GMN-CUR
               WHEN    OTHER
                       MOVE    "0001"          TO  SPA-ERRCD
           END-EVALUATE
           . 
       4113-HJNKSINENKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    標準構成連番初期化区分チェック処理
      *****************************************************************
       4114-HJNKSIRENNUMKBN-CHK-SEC        SECTION.
      *
           MOVE    5                    TO  SPA-GMN-CUR
      *
           MOVE    W04-HJNKSIRENNUMKBN  TO  SPA-GMN-HJNKSIRENNUMKBN
      *
           EVALUATE    SPA-GMN-HJNKSIRENNUMKBN
               WHEN    "1" 
               WHEN    "2"
                   MOVE    6                   TO  SPA-GMN-CUR
               WHEN    OTHER
                       MOVE    "0001"          TO  SPA-ERRCD
           END-EVALUATE
           .
       4114-HJNKSIRENNUMKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    標準構成連番号桁数チェック処理
      *****************************************************************
       4115-HJNKSIRENNUMKETA-CHK-SEC        SECTION.
      *
           MOVE    6                       TO  SPA-GMN-CUR
      *
           MOVE    W04-HJNKSIRENNUMKETA    TO  SPA-GMN-HJNKSIRENNUMKETA
           IF      SPA-GMN-HJNKSIRENNUMKETA    >   ZERO
               MOVE    99                      TO  SPA-GMN-CUR
           ELSE
               MOVE    "0001"               TO  SPA-ERRCD
           END-IF
           .
       4115-HJNKSIRENNUMKETA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    拡張構成区分チェック処理
      *****************************************************************
       4116-KKCKSIKBN-CHK-SEC        SECTION.
      *
           MOVE    7                 TO  SPA-GMN-CUR
      *
           MOVE    W04-KKCKSIKBN            TO  SPA-GMN-KKCKSIKBN
      *
           EVALUATE    SPA-GMN-KKCKSIKBN
               WHEN    "1" 
               WHEN    "2"
               WHEN    "3"
                   MOVE    8                   TO  SPA-GMN-CUR
               WHEN    OTHER
                       MOVE    "0001"          TO  SPA-ERRCD
           END-EVALUATE
           .
       4116-KKCKSIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    拡張構成前桁数チェック処理
      *****************************************************************
       4117-KKCKSIMAEKETA-CHK-SEC        SECTION.
      *
           MOVE    8                    TO  SPA-GMN-CUR
      *
           MOVE    W04-KKCKSIMAEKETA    TO  SPA-GMN-KKCKSIMAEKETA
      *
           MOVE    9                    TO  SPA-GMN-CUR
           .
       4117-KKCKSIMAEKETA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    標準構成連番号桁数チェック処理
      *****************************************************************
       4118-KKCKSIRENNUMKETA-CHK-SEC       SECTION.
      *
           MOVE    9                       TO  SPA-GMN-CUR
      *
           MOVE    W04-KKCKSIRENNUMKETA    TO  SPA-GMN-KKCKSIRENNUMKETA
           IF      SPA-GMN-KKCKSIRENNUMKETA    >   ZERO
               MOVE    10                      TO  SPA-GMN-CUR
           ELSE
               MOVE    "0001"               TO  SPA-ERRCD
           END-IF
           .
       4118-KKCKSIRENNUMKETA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    拡張構成前桁数チェック処理
      *****************************************************************
       4119-KKCKSIATOKETA-CHK-SEC        SECTION.
      *
           MOVE    10                   TO  SPA-GMN-CUR
      *
           MOVE    W04-KKCKSIATOKETA    TO  SPA-GMN-KKCKSIATOKETA
      *
           MOVE    99                   TO  SPA-GMN-CUR
           .
       4119-KKCKSIATOKETA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ｼタグ編集処理
      *****************************************************************
       440-TAG-CHANGE-SEC            SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "N01"
                   MOVE   0            TO  IDX
               WHEN    "N02"
                  MOVE    1            TO  IDX
               WHEN    "N03"
                   MOVE   2            TO  IDX
           END-EVALUATE
      *
      *    タグが変わったとき関連チェック
           IF      IDX              NOT =   SPA-GMN-PAGENO
               IF      SPA-GMN-PTNUMKSIKBN  =   "1" OR  "2" OR  "3"
                   MOVE    "0005"               TO  SPA-ERRCD
                   GO  TO  440-TAG-CHANGE-EXT
               END-IF
               PERFORM 4900-KANRENCHK-SEC
           END-IF
           IF      SPA-ERRCD            =   SPACE
               MOVE    IDX                  TO  SPA-GMN-PAGENO
               EVALUATE    IDX
                   WHEN    0
                       MOVE    1            TO  SPA-GMN-CUR
                   WHEN    1
                       MOVE    20           TO  SPA-GMN-CUR
                   WHEN    2
                       MOVE    30           TO  SPA-GMN-CUR
               END-EVALUATE
           END-IF        
           .
       440-TAG-CHANGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W04"               TO  SPA-MOTOPG
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
      *****************************************************************
      *       登録前処理
      *****************************************************************
       490-TOUROKU-SEC              SECTION.
      *
           PERFORM 4900-KANRENCHK-SEC
           IF      SPA-ERRCD        =   SPACE
              MOVE    "1001"           TO  SPA-WIDCD
              IF    SPA-GMN-NEN            NOT =   SPA-SYSYMD (1:4)
                  IF     (SPA-GMN-PTNUMKSIKBN      =   "2")   AND
                         (SPA-GMN-HJNKSIRENNUMKBN  =   "1")
                      MOVE    "1011"           TO  SPA-WIDCD
                  ELSE
                      MOVE    "1010"           TO  SPA-WIDCD
                  END-IF
               END-IF  
           END-IF
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYS-1009-REC
           INITIALIZE                      SYS-1009-REC
           MOVE    "1009"                  TO  SYS-1009-KANRICD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-1009-REC            TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-1009-REC
           ELSE
               MOVE    SPACE                   TO  SYS-1009-REC
               INITIALIZE                      SYS-1009-REC
               MOVE   "1009"                   TO  SYS-1009-KANRICD
               MOVE    "*"                     TO  SYS-1009-KBNCD
               MOVE    SPA-W01-STYUKYMD        TO  SYS-1009-STYUKYMD
               MOVE    SPA-W01-EDYUKYMD        TO  SYS-1009-EDYUKYMD
               MOVE    SPA-GMN-NEN             TO  SYS-1009-NEN
           END-IF
      *
          IF    SPA-GMN-NEN            NOT =   SPA-SYSYMD (1:4)
              MOVE    SPA-SYSYMD(1:4)          TO  SYS-1009-NEN
              IF     (SPA-GMN-PTNUMKSIKBN      =   "2")   AND
                     (SPA-GMN-HJNKSIRENNUMKBN  =   "1")
                  MOVE    ZERO                 TO  SYS-1009-RENNUM
              END-IF
          END-IF
           MOVE    SPA-GMN-PTNUMKSIKBN      TO  SYS-1009-PTNUMKSIKBN 
           MOVE    SPA-GMN-JIYKSIKBN        TO  SYS-1009-JIYKSIKBN 
           MOVE    SPA-GMN-JIYKSIKETA       TO  SYS-1009-JIYKSIKETA 
           MOVE    SPA-GMN-HJNKSIKBN        TO  SYS-1009-HJNKSIKBN 
           MOVE    SPA-GMN-HJNKSINENKBN     TO  SYS-1009-HJNKSINENKBN
           MOVE    SPA-GMN-HJNKSIRENNUMKBN  TO
                                            SYS-1009-HJNKSIRENNUMKBN
           MOVE    SPA-GMN-HJNKSIRENNUMKETA TO
                                            SYS-1009-HJNKSIRENNUMKETA
           MOVE    SPA-GMN-KKCKSIKBN        TO  SYS-1009-KKCKSIKBN 
           MOVE    SPA-GMN-KKCKSIMAEKETA    TO  SYS-1009-KKCKSIMAEKETA
           MOVE    SPA-GMN-KKCKSIRENNUMKETA TO
                                            SYS-1009-KKCKSIRENNUMKETA
           MOVE    SPA-GMN-KKCKSIATOKETA    TO  SYS-1009-KKCKSIATOKETA
      *
           MOVE    SYS-1009-REC            TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1003"                  TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-EXT
           END-IF      
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       490-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC           SECTION.
      *
           MOVE    SPACE                TO  SPA-ERRCD
      *
           EVALUATE    W04-PAGENO
               WHEN    0
                   PERFORM 4901-TAG1-CHK-SEC
               WHEN    1
                   PERFORM 4901-TAG2-CHK-SEC
               WHEN    2
                   PERFORM 4901-TAG3-CHK-SEC
           END-EVALUATE
      *
           IF      SPA-ERRCD             =   SPACE     
               IF      WRK-TOTAL             >   20
                   MOVE    "0003"                TO  SPA-ERRCD
               END-IF
           END-IF
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       自由構成タグの関連チェック処理
      *****************************************************************
       4901-TAG1-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-JIYKSIKETA       >   ZERO     AND
                   SPA-GMN-JIYKSIKBN        =   "0" OR  "1" OR  "2"
               CONTINUE
           ELSE        
               MOVE    "0001"               TO  SPA-ERRCD
           END-IF
      *
           IF     (SPA-GMN-HJNKSIKBN        =   SPACE)   AND
                  (SPA-GMN-HJNKSINENKBN     =   SPACE)   AND
                  (SPA-GMN-HJNKSIRENNUMKBN  =   SPACE)   AND
                  (SPA-GMN-HJNKSIRENNUMKETA =   ZERO)
               CONTINUE
           ELSE
               MOVE    "0002"               TO  SPA-ERRCD
           END-IF
      *  
           IF     (SPA-GMN-KKCKSIKBN        =   SPACE)   AND
                  (SPA-GMN-KKCKSIMAEKETA    =   ZERO )   AND
                  (SPA-GMN-KKCKSIRENNUMKETA =   ZERO )   AND
                  (SPA-GMN-KKCKSIATOKETA    =   ZERO)
               CONTINUE
           ELSE
               MOVE    "0002"               TO  SPA-ERRCD
           END-IF
           IF      SPA-ERRCD                =   SPACE
               MOVE    SPA-GMN-JIYKSIKETA   TO  WRK-TOTAL
           END-IF
      *
           .
       4901-TAG1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       標準構成タグの関連チェック処理
      *****************************************************************
       4901-TAG2-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-HJNKSIKBN        =   "1" OR "2" OR
                                                "3" OR "4"
               CONTINUE
           ELSE
               MOVE    "0001"               TO  SPA-ERRCD
           END-IF
           IF      SPA-GMN-HJNKSINENKBN     =   "1" OR "2"
               CONTINUE
           ELSE
               MOVE    "0001"               TO  SPA-ERRCD
           END-IF
           IF      SPA-GMN-HJNKSIRENNUMKBN  =   "1" OR "2"
               CONTINUE
           ELSE
               MOVE    "0001"               TO  SPA-ERRCD
           END-IF
           IF      SPA-GMN-HJNKSIRENNUMKETA =   ZERO
               MOVE    "0001"               TO  SPA-ERRCD
           END-IF
      *
           IF      SPA-GMN-JIYKSIKETA   NOT =   ZERO     AND 
                   SPA-GMN-JIYKSIKBN    NOT =   SPACE
               MOVE    "0002"               TO  SPA-ERRCD
           END-IF
      *  
           IF     (SPA-GMN-KKCKSIKBN        =   SPACE)   AND
                  (SPA-GMN-KKCKSIMAEKETA    =   ZERO )   AND
                  (SPA-GMN-KKCKSIRENNUMKETA =   ZERO )   AND
                  (SPA-GMN-KKCKSIATOKETA    =   ZERO)
               CONTINUE
           ELSE
               MOVE    "0002"               TO  SPA-ERRCD
           END-IF
      *
           IF      SPA-ERRCD                =   SPACE
               IF      SPA-GMN-HJNKSIKBN        =   "1"  OR  "2"
                   IF      SPA-GMN-HJNKSINENKBN     =   "1"
                       MOVE    3                    TO  WRK-TOTAL
                   ELSE
                       MOVE    4                    TO  WRK-TOTAL
                   END-IF
               END-IF
               COMPUTE WRK-TOTAL           =   WRK-TOTAL
                                           +   SPA-GMN-HJNKSIRENNUMKETA
               IF      SPA-GMN-HJNKSIKBN   =   "1"  OR  "3"
                   COMPUTE WRK-TOTAL           =   WRK-TOTAL   +   1
               END-IF
           END-IF
           .
       4901-TAG2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       拡張構成タグの関連チェック処理
      *****************************************************************
       4901-TAG3-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-KKCKSIKBN     =   "1" OR "2" OR "3"
               CONTINUE
           ELSE
               MOVE    "0001"            TO  SPA-ERRCD
           END-IF
           IF      SPA-GMN-KKCKSIRENNUMKETA   =   ZERO
               MOVE    "0001"            TO  SPA-ERRCD
           END-IF
           EVALUATE    SPA-GMN-KKCKSIKBN
               WHEN    "1"
                   IF  (SPA-GMN-KKCKSIMAEKETA  =   ZERO)  OR
                       (SPA-GMN-KKCKSIATOKETA  =   ZERO)
                       MOVE    "0001"            TO  SPA-ERRCD
                   END-IF
               WHEN    "2"
                   IF  (SPA-GMN-KKCKSIMAEKETA      =   ZERO)  OR
                       (SPA-GMN-KKCKSIATOKETA  NOT =   ZERO)
                       MOVE    "0001"            TO  SPA-ERRCD
                   END-IF
               WHEN    "3"
                   IF  (SPA-GMN-KKCKSIMAEKETA  NOT =   ZERO)  OR
                       (SPA-GMN-KKCKSIATOKETA      =   ZERO)
                       MOVE    "0001"            TO  SPA-ERRCD
                   END-IF
           END-EVALUATE
      *
           IF      SPA-GMN-JIYKSIKETA   NOT =   ZERO     AND
                   SPA-GMN-JIYKSIKBN    NOT =   SPACE
               MOVE    "0002"            TO  SPA-ERRCD
           END-IF
      *
           IF     (SPA-GMN-HJNKSIKBN        =   SPACE)   AND
                  (SPA-GMN-HJNKSINENKBN     =   SPACE)   AND
                  (SPA-GMN-HJNKSIRENNUMKBN  =   SPACE)   AND
                  (SPA-GMN-HJNKSIRENNUMKETA =   ZERO)
               CONTINUE
           ELSE
               MOVE    "0002"               TO  SPA-ERRCD
           END-IF
      *
           IF      SPA-ERRCD                =   SPACE
               COMPUTE WRK-TOTAL        =   SPA-GMN-KKCKSIMAEKETA
                                        +   SPA-GMN-KKCKSIRENNUMKETA
                                        +   SPA-GMN-KKCKSIATOKETA
           END-IF
           .
       4901-TAG3-CHK-EXT.
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
           IF      SPA-WIDCD       NOT =   SPACE
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W04    "           TO  MCP-WINDOW.
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
      *
           MOVE    SPA-GMN-STYUKYMD         TO  W04-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD         TO  W04-EDYUKYMD
           MOVE    SPA-GMN-NEN              TO  W04-NEN
           MOVE    SPA-GMN-PTID             TO  W04-PTID
           MOVE    SPA-GMN-RENNUM           TO  W04-RENNUM
      * 
           MOVE    SPA-GMN-PTNUMKSIKBN      TO  W04-PTNUMKSIKBN
           MOVE    SPA-GMN-JIYKSIKETA       TO  W04-JIYKSIKETA
           MOVE    SPA-GMN-JIYKSIKBN        TO  W04-JIYKSIKBN
           MOVE    SPA-GMN-HJNKSIKBN        TO  W04-HJNKSIKBN
           MOVE    SPA-GMN-HJNKSINENKBN     TO  W04-HJNKSINENKBN  
           MOVE    SPA-GMN-HJNKSIRENNUMKBN  TO  W04-HJNKSIRENNUMKBN
           MOVE    SPA-GMN-HJNKSIRENNUMKETA TO  W04-HJNKSIRENNUMKETA
           MOVE    SPA-GMN-KKCKSIKBN        TO  W04-KKCKSIKBN
           MOVE    SPA-GMN-KKCKSIMAEKETA    TO  W04-KKCKSIMAEKETA
           MOVE    SPA-GMN-KKCKSIRENNUMKETA TO  W04-KKCKSIRENNUMKETA
           MOVE    SPA-GMN-KKCKSIATOKETA    TO  W04-KKCKSIATOKETA
      *
           MOVE    SPA-GMN-PAGENO           TO  W04-PAGENO
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
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
                   MOVE    "入力エラー"        TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "入力できない項目に入力があります"
                                               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "合計桁数が長すぎます"
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE
                       "患者番号構成区分を変更して画面を移動して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W04"                TO  SPA-MOTOPG
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
                   MOVE    "患者番号構成管理情報を登録します"
                                       TO  WRK-WIDMSG
               WHEN    "1010"
                   MOVE    "年が変わったので変更して登録します"
                                       TO  WRK-WIDMSG
               WHEN    "1011"
                   MOVE    "連番号を初期化して登録します"
                                       TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W04"                TO  SPA-MOTOPG
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
          EVALUATE    SPA-GMN-CUR
                WHEN    1
                    MOVE  "PTNUMKSIKBN"      TO   MCP-WIDGET
                WHEN    2
                    MOVE  "JIYKSIKETA"       TO   MCP-WIDGET
                WHEN    3
                    MOVE  "HJNKSIKBN"        TO   MCP-WIDGET
                WHEN    4
                    MOVE  "HJNKSINENKBN"     TO   MCP-WIDGET
                WHEN    5
                    MOVE  "HJNKSIRENNUMKBN"  TO   MCP-WIDGET
                WHEN    6
                    MOVE  "HJNKSIRENNUMKETA" TO   MCP-WIDGET
                WHEN    7
                    MOVE  "KKCKSIKBN"        TO   MCP-WIDGET
                WHEN    8
                    MOVE  "KKCKSIMAEKETA"    TO   MCP-WIDGET
                WHEN    9
                    MOVE  "KKCKSIRENNUMKETA" TO   MCP-WIDGET
                WHEN    10
                    MOVE  "KKCKSIATOKETA"    TO   MCP-WIDGET
                WHEN    11
                    MOVE  "JIYKSIKBN"        TO   MCP-WIDGET
                WHEN    99
                    MOVE  "B12"              TO   MCP-WIDGET
            END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YMD  (1:7)  NOT NUMERIC
               INSPECT     WRK-YMD      REPLACING   ALL " "
                                                    BY  "0"   
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
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
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
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
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
