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
       PROGRAM-ID.             ORCGW10.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 統計帳票出力情報（Ｗ１０）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/07/12    MCC−森脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/09/06  パラメタ項目追加
      *  01.00.02    MCC-藤原     01/09/11  削除処理の修正 
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.01.02    MCC-藤原     02/03/11  月次統計パラメタの追加     
      *  01.01.03    NACL-多々納  02/11/13  一括入力 
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
       01  SPA-W10.
           03  SPA-W10-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(03).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD       PIC X(09).
                   07  SPA-GMN-EDYUKYMD       PIC X(09).
                   07  SPA-GMN-PAGENO         PIC 9(01).
                   07  SPA-GMN-3001-AREA.
                       09  SPA-GMN-HCNUM      PIC 9(03).
                       09  SPA-GMN-HCNAME     PIC X(80).
                       09  SPA-GMN-PRGNAME    PIC X(24).
                       09  SPA-GMN-PARA-G     OCCURS  8.
                           11  SPA-GMN-PARAHYOJI
                                              PIC X(20).
                           11  SPA-GMN-PARA   PIC X(10).
                       09  SPA-GMN-OPTHISSU-KBN-G
                                               OCCURS  8.
                           11  SPA-GMN-OPTHISSU
                                              PIC X(01).
                           11  SPA-GMN-OPTNINI
                                              PIC X(01).
                   07  SPA-GMN-3002-AREA.
                       09  SPA-GMN-HCNUM1     PIC 9(03).
                       09  SPA-GMN-HCNAME1    PIC X(80).
                       09  SPA-GMN-PRGNAME1   PIC X(24).
                       09  SPA-GMN-PARA1-G    OCCURS  8.
                           11  SPA-GMN-PARAHYOJI1
                                              PIC X(20).
                           11  SPA-GMN-PARA1  PIC X(10).
                       09  SPA-GMN-OPTHISSU-KBN1-G
                                               OCCURS  8.
                           11  SPA-GMN-OPTHISSU1
                                              PIC X(01).
                           11  SPA-GMN-OPTNINI1
                                              PIC X(01).
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-STYUKYMD           PIC 9(08).
                   07  SPA-NAI-EDYUKYMD           PIC 9(08).
      *   
           COPY    "ENUM-VALUE".
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-TOUROKU         PIC 9(01).
           03  FLG-ZENKAKU         PIC 9(01).
           03  FLG-HANKAKU         PIC 9(01).
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
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
      *
       01  WRK-AREA.
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
           03  WRK-MCP-WIDGET      PIC X(64).
           03  WRK-MAE-INPUT       PIC X(200).
           03  WRK-OUT-INPUT       PIC X(200).
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
       01  WRK-WIDGET-AREA.
           03  WRK-WIDGET                          PIC X(20).
      *
           03  WRK-WIDGET-R7   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R7-DAMMY1            PIC X(07).
               05  WRK-WIDGET7                     PIC 9(02).
               05  WRK-WIDGET-R7-DAMMY2            PIC X(11).
      *
           03  WRK-WIDGET-R8   REDEFINES   WRK-WIDGET.
               05  WRK-WIDGET-R8-DAMMY1            PIC X(08).
               05  WRK-WIDGET8                     PIC 9(02).
               05  WRK-WIDGET-R8-DAMMY2            PIC X(10).
      *
       01  CONST-AREA.
           03  CONST-3001-PARA-MAX PIC 9(05)   VALUE 8.
           03  CONST-3002-PARA-MAX PIC 9(05)   VALUE 8.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *
           COPY    "CPSK3001.INC".
      *
           COPY    "CPSK3002.INC".
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
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
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
           MOVE    SPA-FREE        TO  SPA-W10
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
           MOVE    SPA-W10         TO  SPA-FREE
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
           MOVE    "W10"                TO  MCP-WINDOW
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
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           INITIALIZE   SPA-W10-AREA
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL ( IDX >       CONST-3001-PARA-MAX )
               MOVE    "T"             TO  SPA-GMN-OPTHISSU (IDX)
               MOVE    "F"             TO  SPA-GMN-OPTNINI  (IDX)
           END-PERFORM
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL ( IDX >       CONST-3002-PARA-MAX )
               MOVE    "T"             TO  SPA-GMN-OPTHISSU1(IDX)
               MOVE    "F"             TO  SPA-GMN-OPTNINI1 (IDX)
           END-PERFORM
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD 
      * 
           INITIALIZE                      SYS-3001-REC
           MOVE    SPA-W01-KANRICD     TO  SYS-3001-KANRICD
           MOVE    SPA-W01-KBNCD       TO  SYS-3001-KBNCD
           MOVE    SYS-3001-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
      *     
           EVALUATE    SPA-W01-KANRICD
               WHEN    "3001"    
                   IF      FLG-SYSKANRI            =   ZERO
                       MOVE    MCPDATA-REC         TO  SYS-3001-REC
                       MOVE    SYS-3001-KBNCD(1:3) TO  SPA-GMN-HCNUM
                       MOVE    SYS-3001-HCNAME     TO  SPA-GMN-HCNAME
                       MOVE    SYS-3001-PRGNAME    TO  SPA-GMN-PRGNAME
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       CONST-3001-PARA-MAX
                           MOVE    SYS-3001-PARAHYOJI(IDX)
                                           TO  SPA-GMN-PARAHYOJI(IDX)
                           MOVE    SYS-3001-PARA     (IDX)
                                           TO  SPA-GMN-PARA     (IDX)
                           IF    ( SYS-3001-HISSU-KBN(IDX)
                                                   =   SPACE OR "1" )
                               MOVE    "T"         TO  SPA-GMN-OPTHISSU
                                                                 (IDX)
                               MOVE    "F"         TO  SPA-GMN-OPTNINI
                                                                 (IDX)
                           ELSE
                               MOVE    "F"         TO  SPA-GMN-OPTHISSU
                                                                 (IDX)
                               MOVE    "T"         TO  SPA-GMN-OPTNINI
                                                                 (IDX)
                           END-IF
                       END-PERFORM
                   ELSE
                       MOVE    SPA-W01-KBNCD(1:3)  TO  SPA-GMN-HCNUM
                   END-IF
                   MOVE    1                   TO  SPA-GMN-CUR
               WHEN    "3002"    
                   IF      FLG-SYSKANRI            =   ZERO
                       MOVE    MCPDATA-REC         TO  SYS-3002-REC
                       MOVE    SYS-3002-KBNCD(1:3) TO  SPA-GMN-HCNUM1
                       MOVE    SYS-3002-HCNAME     TO  SPA-GMN-HCNAME1
                       MOVE    SYS-3002-PRGNAME    TO  SPA-GMN-PRGNAME1
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       CONST-3002-PARA-MAX
                           MOVE    SYS-3002-PARAHYOJI(IDX)
                                           TO  SPA-GMN-PARAHYOJI1(IDX)
                           MOVE    SYS-3002-PARA     (IDX)
                                           TO  SPA-GMN-PARA1     (IDX)
                           IF    ( SYS-3002-HISSU-KBN(IDX)
                                                   =   SPACE OR "1" )
                               MOVE    "T"         TO  SPA-GMN-OPTHISSU1
                                                                 (IDX)
                               MOVE    "F"         TO  SPA-GMN-OPTNINI1
                                                                 (IDX)
                           ELSE
                               MOVE    "F"         TO  SPA-GMN-OPTHISSU1
                                                                 (IDX)
                               MOVE    "T"         TO  SPA-GMN-OPTNINI1
                                                                 (IDX)
                           END-IF
                       END-PERFORM
                   ELSE
                       MOVE    SPA-W01-KBNCD(1:3)  TO  SPA-GMN-HCNUM1
                   END-IF
                   MOVE    101                 TO  SPA-GMN-CUR
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
      *    削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 403-DEL-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *    必須オプションボタン
               WHEN    "CLICKED"       ALSO    "OPTHISSU01"
               WHEN    "CLICKED"       ALSO    "OPTHISSU02"
               WHEN    "CLICKED"       ALSO    "OPTHISSU03"
               WHEN    "CLICKED"       ALSO    "OPTHISSU04"
               WHEN    "CLICKED"       ALSO    "OPTHISSU05"
               WHEN    "CLICKED"       ALSO    "OPTHISSU06"
               WHEN    "CLICKED"       ALSO    "OPTHISSU07"
               WHEN    "CLICKED"       ALSO    "OPTHISSU08"
                   MOVE    MCP-WIDGET  TO      WRK-WIDGET
                   PERFORM 4201-OPTHISSU-CHK-SEC
               WHEN    "CLICKED"       ALSO    "OPTHISSU011"
               WHEN    "CLICKED"       ALSO    "OPTHISSU021"
               WHEN    "CLICKED"       ALSO    "OPTHISSU031"
               WHEN    "CLICKED"       ALSO    "OPTHISSU041"
               WHEN    "CLICKED"       ALSO    "OPTHISSU051"
               WHEN    "CLICKED"       ALSO    "OPTHISSU061"
               WHEN    "CLICKED"       ALSO    "OPTHISSU071"
               WHEN    "CLICKED"       ALSO    "OPTHISSU081"
                   MOVE    MCP-WIDGET  TO      WRK-WIDGET
                   PERFORM 4211-OPTHISSU-CHK-SEC
      *    任意オプションボタン
               WHEN    "CLICKED"       ALSO    "OPTNINI01"
               WHEN    "CLICKED"       ALSO    "OPTNINI02"
               WHEN    "CLICKED"       ALSO    "OPTNINI03"
               WHEN    "CLICKED"       ALSO    "OPTNINI04"
               WHEN    "CLICKED"       ALSO    "OPTNINI05"
               WHEN    "CLICKED"       ALSO    "OPTNINI06"
               WHEN    "CLICKED"       ALSO    "OPTNINI07"
               WHEN    "CLICKED"       ALSO    "OPTNINI08"
                   MOVE    MCP-WIDGET  TO      WRK-WIDGET
                   PERFORM 4202-OPTNINI-CHK-SEC
               WHEN    "CLICKED"       ALSO    "OPTNINI011"
               WHEN    "CLICKED"       ALSO    "OPTNINI021"
               WHEN    "CLICKED"       ALSO    "OPTNINI031"
               WHEN    "CLICKED"       ALSO    "OPTNINI041"
               WHEN    "CLICKED"       ALSO    "OPTNINI051"
               WHEN    "CLICKED"       ALSO    "OPTNINI061"
               WHEN    "CLICKED"       ALSO    "OPTNINI071"
               WHEN    "CLICKED"       ALSO    "OPTNINI081"
                   MOVE    MCP-WIDGET  TO      WRK-WIDGET
                   PERFORM 4212-OPTNINI-CHK-SEC
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
      *    日次統計情報
           MOVE    W10-HCNAME          TO  SPA-GMN-HCNAME
           MOVE    W10-PROGNAME        TO  SPA-GMN-PRGNAME
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL       IDZ     >   CONST-3001-PARA-MAX
               MOVE    W10-PARAHYOJI (IDZ) TO  SPA-GMN-PARAHYOJI(IDZ)
               MOVE    W10-PARA (IDZ)      TO  SPA-GMN-PARA(IDZ)
           END-PERFORM
      *    月次統計情報
           MOVE    W10-HCNAME1         TO  SPA-GMN-HCNAME1
           MOVE    W10-PROGNAME1       TO  SPA-GMN-PRGNAME1
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL       IDZ     >   CONST-3002-PARA-MAX
               MOVE    W10-PARAHYOJI1(IDZ) TO  SPA-GMN-PARAHYOJI1(IDZ)
               MOVE    W10-PARA1(IDZ)      TO  SPA-GMN-PARA1(IDZ)
           END-PERFORM
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
               WHEN    "3001"
      *            日次統計情報チェック
                   PERFORM 4101-HCNAME-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4102-PRGNAME-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4103-PARAHYOJI-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4104-PARA-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
               WHEN    "3002"
      *            月次統計情報
                   PERFORM 4111-HCNAME-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4112-PRGNAME-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4113-PARAHYOJI-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4114-PARA-CHK-SEC
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
      *    帳票名チェック（日次統計情報）
      *****************************************************************
       4101-HCNAME-CHK-SEC       SECTION.
      *
           MOVE    SPA-GMN-HCNAME      TO  WRK-MAE-INPUT
           PERFORM 5002-ZENKAKU-CHK-SEC
           IF    ( FLG-ZENKAKU NOT =   ZERO )
               MOVE    "0002"          TO  SPA-ERRCD
               MOVE    1               TO  SPA-GMN-CUR
               GO  TO  4101-HCNAME-CHK-EXT
           END-IF
      *
           MOVE    WRK-OUT-INPUT       TO  SPA-GMN-HCNAME
      *
           .
       4101-HCNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    プログラム名チェック（日次統計情報）
      *****************************************************************
       4102-PRGNAME-CHK-SEC     SECTION.
      *
           MOVE    SPA-GMN-PRGNAME     TO  WRK-MAE-INPUT
           PERFORM 5002-HANKAKU-CHK-SEC
           IF    ( FLG-HANKAKU NOT =   ZERO )
               MOVE    "0003"          TO  SPA-ERRCD
               MOVE    3               TO  SPA-GMN-CUR
               GO  TO  4102-PRGNAME-CHK-EXT
           END-IF
      *
           .
       4102-PRGNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ表示名称チェック（日次統計情報）
      *****************************************************************
       4103-PARAHYOJI-CHK-SEC     SECTION.
      *
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL     ( IDZ         >   CONST-3001-PARA-MAX )
                          OR ( SPA-ERRCD   NOT =   SPACE )
               IF      SPA-GMN-PARAHYOJI(IDZ)  =   SPACE
                   MOVE    SPACE           TO  SPA-GMN-PARA (IDZ)
                   MOVE    "T"             TO  SPA-GMN-OPTHISSU (IDZ)
                   MOVE    "F"             TO  SPA-GMN-OPTNINI  (IDZ)
               ELSE
                   MOVE    SPA-GMN-PARAHYOJI(IDZ)
                                           TO  WRK-MAE-INPUT
                   PERFORM 5002-ZENKAKU-CHK-SEC
                   IF    ( FLG-ZENKAKU NOT =   ZERO )
                       MOVE    "0004"          TO  SPA-ERRCD
                   END-IF
               END-IF
      *
               IF      SPA-ERRCD       NOT =   SPACE
                       COMPUTE SPA-GMN-CUR
                           =   ( IDZ - 1 ) * 2 + 4
               END-IF
      *
           END-PERFORM
      *
           .
       4103-PARAHYOJI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタチェック（日次統計情報）
      *****************************************************************
       4104-PARA-CHK-SEC     SECTION.
      *
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL      (IDZ     >   CONST-3001-PARA-MAX   )   OR
                              (SPA-ERRCD   NOT =   SPACE )
               MOVE    SPA-GMN-PARA (IDZ)  TO  WRK-MAE-INPUT
               PERFORM 5002-HANKAKU-CHK-SEC
               IF    ( FLG-HANKAKU NOT =   ZERO )
                   MOVE    "0005"          TO  SPA-ERRCD
               END-IF
               IF      SPA-ERRCD       NOT =   SPACE
                   COMPUTE SPA-GMN-CUR
                       =   ( IDZ - 1 ) * 2 + 5
               END-IF
           END-PERFORM
      *
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4104-PARA-CHK-EXT
           END-IF
      *
           IF      FLG-TOUROKU         =   ZERO
               GO      TO      4104-PARA-CHK-EXT
           END-IF
      *
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL      (IDZ     >   CONST-3001-PARA-MAX   )   OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF      SPA-GMN-PARAHYOJI(IDZ)  =   SPACE
                   IF      SPA-GMN-PARA (IDZ)  NOT =   SPACE
                       MOVE    "0001"              TO  SPA-ERRCD
                   END-IF
               ELSE
                   IF      SPA-GMN-PARA (IDZ)   =   SPACE
                       MOVE    "0001"           TO  SPA-ERRCD
                   END-IF
               END-IF
               IF      SPA-ERRCD       NOT =   SPACE
                   COMPUTE SPA-GMN-CUR
                       =   ( IDZ - 1 ) * 2 + 5
               END-IF
           END-PERFORM
           .
       4104-PARA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    必須オプションボタンチェック
      *****************************************************************
       4201-OPTHISSU-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET8         TO  IDZ
      *
           IF    ( SPA-GMN-PARAHYOJI(IDZ)  =   SPACE )
               MOVE    "T"             TO  SPA-GMN-OPTHISSU (IDZ)
               MOVE    "F"             TO  SPA-GMN-OPTNINI  (IDZ)
           ELSE
               MOVE    W10-OPTHISSU (IDZ)
                                       TO  SPA-GMN-OPTHISSU (IDZ)
               MOVE    W10-OPTNINI  (IDZ)
                                       TO  SPA-GMN-OPTNINI  (IDZ)
           END-IF
      *
           .
       4201-OPTHISSU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    必須オプションボタンチェック
      *****************************************************************
       4211-OPTHISSU-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET8         TO  IDZ
      *
           IF    ( SPA-GMN-PARAHYOJI1(IDZ)  =   SPACE )
               MOVE    "T"             TO  SPA-GMN-OPTHISSU1 (IDZ)
               MOVE    "F"             TO  SPA-GMN-OPTNINI1  (IDZ)
           ELSE
               MOVE    W10-OPTHISSU1 (IDZ)
                                       TO  SPA-GMN-OPTHISSU1 (IDZ)
               MOVE    W10-OPTNINI1  (IDZ)
                                       TO  SPA-GMN-OPTNINI1  (IDZ)
           END-IF
      *
           .
       4211-OPTHISSU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    任意オプションボタンチェック
      *****************************************************************
       4202-OPTNINI-CHK-SEC        SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET7         TO  IDZ
      *
           IF    ( SPA-GMN-PARAHYOJI(IDZ)  =   SPACE )
               MOVE    "T"             TO  SPA-GMN-OPTHISSU (IDZ)
               MOVE    "F"             TO  SPA-GMN-OPTNINI  (IDZ)
           ELSE
               MOVE    W10-OPTHISSU (IDZ)
                                       TO  SPA-GMN-OPTHISSU (IDZ)
               MOVE    W10-OPTNINI  (IDZ)
                                       TO  SPA-GMN-OPTNINI  (IDZ)
           END-IF
      *
           .
       4202-OPTNINI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    任意オプションボタンチェック
      *****************************************************************
       4212-OPTNINI-CHK-SEC        SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET7         TO  IDZ
      *
           IF    ( SPA-GMN-PARAHYOJI1(IDZ)  =   SPACE )
               MOVE    "T"             TO  SPA-GMN-OPTHISSU1(IDZ)
               MOVE    "F"             TO  SPA-GMN-OPTNINI1 (IDZ)
           ELSE
               MOVE    W10-OPTHISSU1 (IDZ)
                                      TO  SPA-GMN-OPTHISSU1(IDZ)
               MOVE    W10-OPTNINI1  (IDZ)
                                      TO  SPA-GMN-OPTNINI1 (IDZ)
           END-IF
      *
           .
       4212-OPTNINI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票名チェック（月次統計情報）
      *****************************************************************
       4111-HCNAME-CHK-SEC       SECTION.
      *
           MOVE    SPA-GMN-HCNAME1     TO  WRK-MAE-INPUT
           PERFORM 5002-ZENKAKU-CHK-SEC
           IF    ( FLG-ZENKAKU NOT =   ZERO )
               MOVE    "0002"          TO  SPA-ERRCD
               MOVE    101             TO  SPA-GMN-CUR
               GO  TO  4111-HCNAME-CHK-EXT
           END-IF
      *
           MOVE    WRK-OUT-INPUT       TO  SPA-GMN-HCNAME1
      *
           .
       4111-HCNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    プログラム名チェック（月次統計情報）
      *****************************************************************
       4112-PRGNAME-CHK-SEC     SECTION.
      *
           MOVE    SPA-GMN-PRGNAME1     TO  WRK-MAE-INPUT
           PERFORM 5002-HANKAKU-CHK-SEC
           IF    ( FLG-HANKAKU NOT =   ZERO )
               MOVE    "0003"          TO  SPA-ERRCD
               MOVE    103             TO  SPA-GMN-CUR
               GO  TO  4112-PRGNAME-CHK-EXT
           END-IF
      *
           .
       4112-PRGNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ表示名称チェック（月次統計情報）
      *****************************************************************
       4113-PARAHYOJI-CHK-SEC     SECTION.
      *
      *
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL      (IDZ     >   CONST-3002-PARA-MAX   )   OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF      SPA-GMN-PARAHYOJI1(IDZ)  =   SPACE
                   MOVE    SPACE           TO  SPA-GMN-PARA1 (IDZ)
               ELSE
                   MOVE    SPA-GMN-PARAHYOJI1(IDZ)
                                           TO  WRK-MAE-INPUT
                   PERFORM 5002-ZENKAKU-CHK-SEC
                   IF    ( FLG-ZENKAKU NOT =   ZERO )
                       MOVE    "0004"          TO  SPA-ERRCD
                   END-IF
               END-IF
      *
               IF      SPA-ERRCD       NOT =   SPACE
                       COMPUTE SPA-GMN-CUR
                           =   ( IDZ - 1 ) * 2 + 104
               END-IF
           END-PERFORM
           .
       4113-PARAHYOJI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタチェック（月次統計情報）
      *****************************************************************
       4114-PARA-CHK-SEC     SECTION.
      *
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL      (IDZ     >   CONST-3002-PARA-MAX   )   OR
                              (SPA-ERRCD   NOT =   SPACE )
      *
               MOVE    SPA-GMN-PARA1 (IDZ) TO  WRK-MAE-INPUT
               PERFORM 5002-HANKAKU-CHK-SEC
               IF    ( FLG-HANKAKU NOT =   ZERO )
                   MOVE    "0005"          TO  SPA-ERRCD
               END-IF
               IF      SPA-ERRCD       NOT =   SPACE
                   COMPUTE SPA-GMN-CUR
                       =   ( IDZ - 1 ) * 2 + 105
               END-IF
      *
           END-PERFORM
      *
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4114-PARA-CHK-EXT
           END-IF
      *
           IF      FLG-TOUROKU         =   ZERO
               GO      TO      4114-PARA-CHK-EXT
           END-IF
      *
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL      (IDZ     >   CONST-3002-PARA-MAX   )   OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF      SPA-GMN-PARAHYOJI1(IDZ) =   SPACE
                   IF      SPA-GMN-PARA1 (IDZ) NOT =   SPACE
                       MOVE    "0001"              TO  SPA-ERRCD
                   END-IF
               ELSE
                   IF      SPA-GMN-PARA1 (IDZ)  =   SPACE
                       MOVE    "0001"           TO  SPA-ERRCD
                   END-IF
               END-IF
               IF      SPA-ERRCD       NOT =   SPACE
                   COMPUTE SPA-GMN-CUR
                       =   ( IDZ - 1 ) * 2 + 105
               END-IF
           END-PERFORM
           .
       4114-PARA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W10"               TO  SPA-MOTOPG
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
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                               SECTION.
      *
           MOVE    "1002"              TO  SPA-WIDCD
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
           MOVE    SPACE               TO  SYS-3001-REC
           INITIALIZE                      SYS-3001-REC
           MOVE    SPA-W01-KANRICD         TO  SYS-3001-KANRICD
           MOVE    SPA-W01-KBNCD           TO  SYS-3001-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  SYS-3001-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-3001-EDYUKYMD
           MOVE    SYS-3001-REC            TO  MCPDATA-REC
           MOVE    "DBDELETE"              TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"                  TO  SPA-ERRCD
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
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
      *
           MOVE    SPACE                   TO  SYS-3001-REC 
           INITIALIZE                      SYS-3001-REC
           MOVE    SPA-W01-KANRICD         TO  SYS-3001-KANRICD
           MOVE    SPA-W01-KBNCD           TO  SYS-3001-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-3001-REC            TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "3001"     
                   IF      FLG-SYSKANRI        =   ZERO
                       MOVE    MCPDATA-REC     TO  SYS-3001-REC
                   ELSE
                       MOVE    SPACE           TO  SYS-3001-REC
                       INITIALIZE                  SYS-3001-REC
                       MOVE    SPA-W01-KANRICD TO  SYS-3001-KANRICD
                       MOVE   SPA-W01-KBNCD    TO  SYS-3001-KBNCD
                   END-IF 
                   MOVE    SPA-W01-STYUKYMD    TO  SYS-3001-STYUKYMD
                   MOVE    SPA-W01-EDYUKYMD    TO  SYS-3001-EDYUKYMD
                   MOVE    SPA-GMN-HCNAME      TO  SYS-3001-HCNAME 
                   MOVE    SPA-GMN-PRGNAME     TO  SYS-3001-PRGNAME
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       CONST-3001-PARA-MAX
                       MOVE    SPA-GMN-PARAHYOJI (IDX)
                                           TO  SYS-3001-PARAHYOJI(IDX)
                       MOVE    SPA-GMN-PARA (IDX)
                                           TO  SYS-3001-PARA     (IDX)
                       IF    ( SPA-GMN-PARAHYOJI (IDX) NOT = SPACE )
                           IF    ( SPA-GMN-OPTHISSU(IDX)   =   "T" )
                               MOVE    "1" TO  SYS-3001-HISSU-KBN(IDX)
                           ELSE
                               MOVE    "2" TO  SYS-3001-HISSU-KBN(IDX)
                           END-IF
                       ELSE
                               MOVE    SPACE
                                           TO  SYS-3001-HISSU-KBN(IDX)
                       END-IF
                   END-PERFORM
                   MOVE    SYS-3001-REC         TO  SYSKANRI-REC
               WHEN    "3002"     
                   IF      FLG-SYSKANRI        =   ZERO
                       MOVE    MCPDATA-REC     TO  SYS-3002-REC
                   ELSE
                       MOVE    SPACE           TO  SYS-3002-REC
                       INITIALIZE                  SYS-3002-REC
                       MOVE    SPA-W01-KANRICD TO  SYS-3002-KANRICD
                       MOVE   SPA-W01-KBNCD    TO  SYS-3002-KBNCD
                   END-IF 
                   MOVE    SPA-W01-STYUKYMD    TO  SYS-3002-STYUKYMD
                   MOVE    SPA-W01-EDYUKYMD    TO  SYS-3002-EDYUKYMD
                   MOVE    SPA-GMN-HCNAME1     TO  SYS-3002-HCNAME 
                   MOVE    SPA-GMN-PRGNAME1    TO  SYS-3002-PRGNAME
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       CONST-3002-PARA-MAX
                       MOVE    SPA-GMN-PARAHYOJI1(IDX)
                                           TO  SYS-3002-PARAHYOJI(IDX)
                       MOVE    SPA-GMN-PARA1     (IDX)
                                           TO  SYS-3002-PARA     (IDX)
                       IF    ( SPA-GMN-PARAHYOJI1 (IDX) NOT = SPACE )
                           IF    ( SPA-GMN-OPTHISSU1(IDX)   =   "T" )
                               MOVE    "1" TO  SYS-3002-HISSU-KBN(IDX)
                           ELSE
                               MOVE    "2" TO  SYS-3002-HISSU-KBN(IDX)
                           END-IF
                       ELSE
                               MOVE    SPACE
                                           TO  SYS-3002-HISSU-KBN(IDX)
                       END-IF
                   END-PERFORM
                   MOVE    SYS-3002-REC         TO  SYSKANRI-REC
           END-EVALUATE       
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
               MOVE    "1001"                  TO  SPA-ERRCD
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
           EVALUATE    SPA-W01-KANRICD
               WHEN    "3001"     
                   PERFORM 4901-TAG1-CHK-SEC
               WHEN    "3002"     
                   PERFORM 4902-TAG2-CHK-SEC
           END-EVALUATE        
      *   
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       日次統計情報タグの関連チェック処理
      *****************************************************************
       4901-TAG1-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-HCNAME      =   SPACE    
           OR      SPA-GMN-PRGNAME     =   SPACE   
               MOVE  "0099"                TO  SPA-ERRCD
               MOVE   1                    TO  SPA-GMN-CUR
               GO  TO  4901-TAG1-CHK-EXT
           END-IF
      *
           .
       4901-TAG1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       月次統計情報タグの関連チェック処理
      *****************************************************************
       4902-TAG2-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-HCNAME1     =   SPACE    
           OR      SPA-GMN-PRGNAME1    =   SPACE   
               MOVE  "0099"                TO  SPA-ERRCD
               MOVE   101                  TO  SPA-GMN-CUR
               GO  TO  4902-TAG2-CHK-EXT
           END-IF
      *
           .
       4902-TAG2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
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
           MOVE    "W10    "           TO  MCP-WINDOW.
      *     
           PERFORM 900-PUT-WINDOW.
      *
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPA-GMN-STYUKYMD     TO  W10-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD     TO  W10-EDYUKYMD
      *
      *    日次統計情報 
           MOVE    SPA-GMN-HCNUM        TO  W10-HCNUM
           MOVE    SPA-GMN-HCNAME       TO  W10-HCNAME
           MOVE    SPA-GMN-PRGNAME      TO  W10-PROGNAME
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       CONST-3001-PARA-MAX
               MOVE    SPA-GMN-PARAHYOJI (IDX)
                                              TO  W10-PARAHYOJI(IDX)
               MOVE    SPA-GMN-PARA (IDX)     TO  W10-PARA     (IDX)
               MOVE    SPA-GMN-OPTHISSU (IDX)
                                        TO  W10-OPTHISSU (IDX)
               MOVE    SPA-GMN-OPTNINI  (IDX)
                                        TO  W10-OPTNINI  (IDX)
           END-PERFORM
      *
      *    月次統計情報 
           MOVE    SPA-GMN-HCNUM1       TO  W10-HCNUM1
           MOVE    SPA-GMN-HCNAME1      TO  W10-HCNAME1
           MOVE    SPA-GMN-PRGNAME1     TO  W10-PROGNAME1
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       CONST-3002-PARA-MAX
               MOVE    SPA-GMN-PARAHYOJI1(IDX)
                                              TO  W10-PARAHYOJI1(IDX)
               MOVE    SPA-GMN-PARA1(IDX)     TO  W10-PARA1     (IDX)
               MOVE    SPA-GMN-OPTHISSU1 (IDX)
                                        TO  W10-OPTHISSU1 (IDX)
               MOVE    SPA-GMN-OPTNINI1  (IDX)
                                        TO  W10-OPTNINI1  (IDX)
           END-PERFORM
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
           MOVE    WIDGET-INSENSITIVE     TO  W10-B03-STATE
      *
           IF      SPA-W01-SELNUM          >   ZERO    
               MOVE    WIDGET-NORMAL      TO  W10-B03-STATE
           END-IF
      *      
           MOVE    WIDGET-INSENSITIVE     TO  W10-N01-STATE
                                              W10-N02-STATE
      *             
           EVALUATE    SPA-W01-KANRICD
               WHEN    "3001"
                   MOVE    WIDGET-NORMAL   TO  W10-N01-STATE
               WHEN    "3002" 
                   MOVE    WIDGET-NORMAL   TO  W10-N02-STATE
           END-EVALUATE
           .
       51O-GSRAUTH-EXT.
           EXIT.
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
                   MOVE    "帳票名は全角で指定してください" 
                                               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "プログラム名は半角で指定してください" 
                                               TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "帳票パラメータ名は全角で指定してください" 
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "帳票パラメータＩＤは半角で指定してください" 
                                               TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新処理ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除処理ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W10"                TO  SPA-MOTOPG
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
                   MOVE    "登録処理をします"    TO  WRK-WIDMSG
               WHEN    "1002"
                   MOVE    "削除処理をします"    TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W10"                TO  SPA-MOTOPG
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
      *         日次統計情報    
                WHEN    01
                    MOVE  "HCNAME"         TO   MCP-WIDGET
                WHEN    03
                    MOVE  "PROGNAME"       TO   MCP-WIDGET
                WHEN    04
                    MOVE  "PARAHYOJI1"     TO   MCP-WIDGET
                WHEN    05
                    MOVE  "PARA1"          TO   MCP-WIDGET
                WHEN    06
                    MOVE  "PARAHYOJI2"     TO   MCP-WIDGET
                WHEN    07
                    MOVE  "PARA2"          TO   MCP-WIDGET
                WHEN    08
                    MOVE  "PARAHYOJI3"     TO   MCP-WIDGET
                WHEN    09
                    MOVE  "PARA3"          TO   MCP-WIDGET
                WHEN    10
                    MOVE  "PARAHYOJI4"     TO   MCP-WIDGET
                WHEN    11
                    MOVE  "PARA4"          TO   MCP-WIDGET
                WHEN    12
                    MOVE  "PARAHYOJI5"     TO   MCP-WIDGET
                WHEN    13
                    MOVE  "PARA5"          TO   MCP-WIDGET
                WHEN    14
                    MOVE  "PARAHYOJI6"     TO   MCP-WIDGET
                WHEN    15
                    MOVE  "PARA6"          TO   MCP-WIDGET
                WHEN    16
                    MOVE  "PARAHYOJI7"     TO   MCP-WIDGET
                WHEN    17
                    MOVE  "PARA7"          TO   MCP-WIDGET
                WHEN    18
                    MOVE  "PARAHYOJI8"     TO   MCP-WIDGET
                WHEN    19
                    MOVE  "PARA8"          TO   MCP-WIDGET
      *         月次統計情報    
                WHEN    101
                    MOVE  "HCNAME1"        TO   MCP-WIDGET
                WHEN    103
                    MOVE  "PROGNAME1"      TO   MCP-WIDGET
                WHEN    104
                    MOVE  "PARAHYOJI11"    TO   MCP-WIDGET
                WHEN    105
                    MOVE  "PARA11"         TO   MCP-WIDGET
                WHEN    106
                    MOVE  "PARAHYOJI21"    TO   MCP-WIDGET
                WHEN    107
                    MOVE  "PARA21"         TO   MCP-WIDGET
                WHEN    108
                    MOVE  "PARAHYOJI31"    TO   MCP-WIDGET
                WHEN    109
                    MOVE  "PARA31"         TO   MCP-WIDGET
                WHEN    110
                    MOVE  "PARAHYOJI41"    TO   MCP-WIDGET
                WHEN    111
                    MOVE  "PARA41"         TO   MCP-WIDGET
                WHEN    112
                    MOVE  "PARAHYOJI51"    TO   MCP-WIDGET
                WHEN    113
                    MOVE  "PARA51"         TO   MCP-WIDGET
                WHEN    114
                    MOVE  "PARAHYOJI61"    TO   MCP-WIDGET
                WHEN    115
                    MOVE  "PARA61"         TO   MCP-WIDGET
                WHEN    116
                    MOVE  "PARAHYOJI71"    TO   MCP-WIDGET
                WHEN    117
                    MOVE  "PARA71"         TO   MCP-WIDGET
                WHEN    118
                    MOVE  "PARAHYOJI81"    TO   MCP-WIDGET
                WHEN    119
                    MOVE  "PARA81"         TO   MCP-WIDGET
      *
                WHEN    999
                    MOVE  "B12"            TO   MCP-WIDGET
            END-EVALUATE
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1   THRU    100
                   MOVE    0               TO  W10-PAGENO
               WHEN    101  THRU   200
                   MOVE    1               TO  W10-PAGENO
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
               WHEN    "HCNAME"
                   MOVE    3           TO  SPA-GMN-CUR
               WHEN    "PROGNAME"
                   MOVE    4           TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI1"
                   MOVE    5           TO  SPA-GMN-CUR
               WHEN    "PARA1 "
                   MOVE    6           TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI2 "
                   MOVE    7           TO  SPA-GMN-CUR
               WHEN    "PARA2 "
                   MOVE    8           TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI3 "
                   MOVE    9           TO  SPA-GMN-CUR
               WHEN    "PARA3 "
                   MOVE    10          TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI4 "
                   MOVE    11          TO  SPA-GMN-CUR
               WHEN    "PARA4 "
                   MOVE    12          TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI5 "
                   MOVE    13          TO  SPA-GMN-CUR
               WHEN    "PARA5 "
                   MOVE    14          TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI6 "
                   MOVE    15          TO  SPA-GMN-CUR
               WHEN    "PARA6 "
                   MOVE    16          TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI7 "
                   MOVE    17          TO  SPA-GMN-CUR
               WHEN    "PARA7 "
                   MOVE    18          TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI8 "
                   MOVE    19          TO  SPA-GMN-CUR
               WHEN    "PARA8 "
                   MOVE    999         TO  SPA-GMN-CUR
      *
               WHEN    "HCNAME1"
                   MOVE    103         TO  SPA-GMN-CUR
               WHEN    "PROGNAME1"
                   MOVE    104         TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI11"
                   MOVE    105         TO  SPA-GMN-CUR
               WHEN    "PARA11"
                   MOVE    106         TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI21"
                   MOVE    107         TO  SPA-GMN-CUR
               WHEN    "PARA21"
                   MOVE    108         TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI31"
                   MOVE    109         TO  SPA-GMN-CUR
               WHEN    "PARA31"
                   MOVE    110         TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI41"
                   MOVE    111         TO  SPA-GMN-CUR
               WHEN    "PARA41"
                   MOVE    112         TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI51"
                   MOVE    113         TO  SPA-GMN-CUR
               WHEN    "PARA51"
                   MOVE    114         TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI61"
                   MOVE    115         TO  SPA-GMN-CUR
               WHEN    "PARA61"
                   MOVE    116         TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI71"
                   MOVE    117         TO  SPA-GMN-CUR
               WHEN    "PARA71"
                   MOVE    118         TO  SPA-GMN-CUR
               WHEN    "PARAHYOJI81"
                   MOVE    119         TO  SPA-GMN-CUR
               WHEN    "PARA81"
                   MOVE    999         TO  SPA-GMN-CUR
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
      *    全角チェック処理
      *****************************************************************
       5002-ZENKAKU-CHK-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-ZENKAKU
           MOVE    SPACE               TO  WRK-OUT-INPUT
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-MAE-INPUT       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
               MOVE    1               TO  FLG-ZENKAKU
           ELSE
               MOVE    KANACHK-OUT-INPUT
                                       TO  WRK-OUT-INPUT
           END-IF
      *
           .
       5002-ZENKAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    半角チェック処理
      *****************************************************************
       5002-HANKAKU-CHK-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-HANKAKU
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-MAE-INPUT       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   2     )
               MOVE    1               TO  FLG-HANKAKU
           END-IF
      *
           .
       5002-HANKAKU-CHK-EXT.
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
