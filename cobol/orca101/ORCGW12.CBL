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
       PROGRAM-ID.             ORCGW12.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : レセプト印刷情報（Ｗ１２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/02/26  レセ電区分、レセ電出力先の追加
      *  01.00.02    MCC-藤原     02/03/28  国保ＯＣＲ区分、国保診療報酬請求書
      *                                     区分の追加
      *  01.00.03    MCC-藤原     02/04/03  県単用項目編集プログラム名の追加
      *  01.00.04    MCC-藤原     02/05/13  病名編集区分１（診療科別）の追加
      *  01.00.05    MCC-藤原     02/06/04  転帰日編集区分の追加
      *  01.00.06    MCC-藤原     02/07/04  出力先プリンタ情報の追加
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
       01  SPA-W12.
           03  SPA-W12-AREA.
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
                       09  SPA-GMN-BYOMEIHENKBN-G.
                           11  SPA-GMN-BYOMEIHENKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-BYOMEIHENKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-BYOMEIHENKBN1-G.
                           11  SPA-GMN-BYOMEIHENKBN1
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-BYOMEIHENKBN1MEI
                                              PIC X(20).
                       09  SPA-GMN-TENKIHENKBN-G.
                           11  SPA-GMN-TENKIHENKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-TENKIHENKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-KKHRECEKBN-G.
                           11  SPA-GMN-KKHRECEKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-KKHRECEKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-SYARECEKBN-G.
                           11  SPA-GMN-SYARECEKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-SYARECEKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-RECEDENOUT PIC X(30).              
                       09  SPA-GMN-KKHOCRKBN-G.
                           11  SPA-GMN-KKHOCRKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-KKHOCRKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-PREFPRGID  PIC X(15).              
                       09  SPA-GMN-KKHPRTKBN-G.
                           11  SPA-GMN-KKHPRTKBN
                                              PIC X(01).
                           11  SPA-GMN-F1     PIC X(01).
                           11  SPA-GMN-KKHPRTKBNMEI
                                              PIC X(18).
                       09  SPA-GMN-SYAPRTNM   PIC X(16).              
                       09  SPA-GMN-KKHPRTNM   PIC X(16).              
      *                                        
                   07  SPA-GMN-BYOMEIHENKBNLST        OCCURS  2.
                       09  SPA-GMN-BYOMEIHENKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-BYOMEIHENKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-BYOMEIHENKBN-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-BYOMEIHENKBN1LST       OCCURS  2.
                       09  SPA-GMN-BYOMEIHENKBN1L
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-BYOMEIHENKBN1MEIL
                                              PIC X(20).
                   07  SPA-GMN-BYOMEIHENKBN1-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-TENKIHENKBNLST         OCCURS  2.
                       09  SPA-GMN-TENKIHENKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-TENKIHENKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-TENKIHENKBN-MAX
                                              PIC 9(02).    
      *                                        
                   07  SPA-GMN-KKHRECEKBNLST          OCCURS  3.
                       09  SPA-GMN-KKHRECEKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-KKHRECEKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-KKHRECEKBN-MAX PIC 9(02).    
      *                                        
                   07  SPA-GMN-SYARECEKBNLST          OCCURS  3.
                       09  SPA-GMN-SYARECEKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-SYARECEKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-SYARECEKBN-MAX PIC 9(02).    
      *                                        
                   07  SPA-GMN-KKHOCRKBNLST           OCCURS  2.
                       09  SPA-GMN-KKHOCRKBNL PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-KKHOCRKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-KKHOCRKBN-MAX  PIC 9(02).    
      *                                        
                   07  SPA-GMN-KKHPRTKBNLST           OCCURS  2.
                       09  SPA-GMN-KKHPRTKBNL PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-KKHPRTKBNMEIL
                                              PIC X(18).
                   07  SPA-GMN-KKHPRTKBN-MAX  PIC 9(02).    
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
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    レセプト印刷情報
           COPY  "CPSK2005.INC".
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
           MOVE    SPA-FREE        TO  SPA-W12
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
           MOVE    SPA-W12         TO  SPA-FREE
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
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W12"                TO  MCP-WINDOW
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
           INITIALIZE   SPA-W12-AREA
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
      *     
           MOVE    "0"                 TO  SPA-GMN-BYOMEIHENKBNL    (1)
           MOVE    "連結表示"          TO  SPA-GMN-BYOMEIHENKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-BYOMEIHENKBNL    (2)
           MOVE    "単独表示"          TO  SPA-GMN-BYOMEIHENKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-BYOMEIHENKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-BYOMEIHENKBN1L   (1)
           MOVE    "受診科のみ表示"    TO  SPA-GMN-BYOMEIHENKBN1MEIL(1)
           MOVE    "1"                 TO  SPA-GMN-BYOMEIHENKBN1L   (2)
           MOVE    "全ての診療科分を表示"
                                       TO  SPA-GMN-BYOMEIHENKBN1MEIL(2)
           MOVE    2                   TO  SPA-GMN-BYOMEIHENKBN1-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-TENKIHENKBNL     (1)
           MOVE    "転帰日を表示しない"
                                       TO  SPA-GMN-TENKIHENKBNMEIL  (1)
           MOVE    "1"                 TO  SPA-GMN-TENKIHENKBNL     (2)
           MOVE    "転帰日を表示する"  TO  SPA-GMN-TENKIHENKBNMEIL  (2)
           MOVE    2                   TO  SPA-GMN-TENKIHENKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-KKHRECEKBNL      (1)
           MOVE    "出力なし"          TO  SPA-GMN-KKHRECEKBNMEIL   (1)
           MOVE    "1"                 TO  SPA-GMN-KKHRECEKBNL      (2)
           MOVE    "固定長"            TO  SPA-GMN-KKHRECEKBNMEIL   (2)
           MOVE    "2"                 TO  SPA-GMN-KKHRECEKBNL      (3)
           MOVE    "ＣＳＶ"            TO  SPA-GMN-KKHRECEKBNMEIL   (3)
           MOVE    3                   TO  SPA-GMN-KKHRECEKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-SYARECEKBNL      (1)
           MOVE    "出力なし"          TO  SPA-GMN-SYARECEKBNMEIL   (1)
           MOVE    "1"                 TO  SPA-GMN-SYARECEKBNL      (2)
           MOVE    "固定長"            TO  SPA-GMN-SYARECEKBNMEIL   (2)
           MOVE    "2"                 TO  SPA-GMN-SYARECEKBNL      (3)
           MOVE    "ＣＳＶ"            TO  SPA-GMN-SYARECEKBNMEIL   (3)
           MOVE    3                   TO  SPA-GMN-SYARECEKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-KKHOCRKBNL    (1)
           MOVE    "ＯＣＲなし"        TO  SPA-GMN-KKHOCRKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-KKHOCRKBNL    (2)
           MOVE    "ＯＣＲあり"        TO  SPA-GMN-KKHOCRKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-KKHOCRKBN-MAX 
      *     
           MOVE    "0"                 TO  SPA-GMN-KKHPRTKBNL    (1)
           MOVE    "給付割合なしの様式"
                                       TO  SPA-GMN-KKHPRTKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-KKHPRTKBNL    (2)
           MOVE    "給付割合ありの様式"
                                       TO  SPA-GMN-KKHPRTKBNMEIL (2)
           MOVE    2                   TO  SPA-GMN-KKHPRTKBN-MAX 
      * 
           MOVE    SPACE               TO  SYS-2005-REC
           INITIALIZE                      SYS-2005-REC
           MOVE    "2005"                  TO  SYS-2005-KANRICD
           MOVE    "*"                     TO  SYS-2005-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-2005-REC            TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-2005-REC
      *         
               MOVE    SYS-2005-BYOMEIHENKBN   TO  SPA-GMN-BYOMEIHENKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-BYOMEIHENKBN-MAX
                   IF      SPA-GMN-BYOMEIHENKBN 
                                   =   SPA-GMN-BYOMEIHENKBNL (IDY)
                       MOVE    SPA-GMN-BYOMEIHENKBNLST (IDY)
                                           TO  SPA-GMN-BYOMEIHENKBN-G
                       MOVE    SPA-GMN-BYOMEIHENKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-BYOMEIHENKBN1  TO  SPA-GMN-BYOMEIHENKBN1
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-BYOMEIHENKBN1-MAX
                   IF      SPA-GMN-BYOMEIHENKBN1 
                                   =   SPA-GMN-BYOMEIHENKBN1L (IDY)
                       MOVE    SPA-GMN-BYOMEIHENKBN1LST (IDY)
                                           TO  SPA-GMN-BYOMEIHENKBN1-G
                       MOVE    SPA-GMN-BYOMEIHENKBN1-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-TENKIHENKBN    TO  SPA-GMN-TENKIHENKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-TENKIHENKBN-MAX
                   IF      SPA-GMN-TENKIHENKBN 
                                   =   SPA-GMN-TENKIHENKBNL (IDY)
                       MOVE    SPA-GMN-TENKIHENKBNLST (IDY)
                                           TO  SPA-GMN-TENKIHENKBN-G
                       MOVE    SPA-GMN-TENKIHENKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-KKHRECEKBN TO  SPA-GMN-KKHRECEKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KKHRECEKBN-MAX
                   IF      SPA-GMN-KKHRECEKBN 
                                   =   SPA-GMN-KKHRECEKBNL (IDY)
                       MOVE    SPA-GMN-KKHRECEKBNLST (IDY)
                                           TO  SPA-GMN-KKHRECEKBN-G
                       MOVE    SPA-GMN-KKHRECEKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *         
               MOVE    SYS-2005-SYARECEKBN TO  SPA-GMN-SYARECEKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-SYARECEKBN-MAX
                   IF      SPA-GMN-SYARECEKBN 
                                   =   SPA-GMN-SYARECEKBNL (IDY)
                       MOVE    SPA-GMN-SYARECEKBNLST (IDY)
                                           TO  SPA-GMN-SYARECEKBN-G
                       MOVE    SPA-GMN-SYARECEKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *
               MOVE    SYS-2005-RECEDENOUT TO  SPA-GMN-RECEDENOUT         
      *         
               MOVE    SYS-2005-KKHOCRKBN  TO  SPA-GMN-KKHOCRKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KKHOCRKBN-MAX
                   IF      SPA-GMN-KKHOCRKBN 
                                   =   SPA-GMN-KKHOCRKBNL (IDY)
                       MOVE    SPA-GMN-KKHOCRKBNLST (IDY)
                                           TO  SPA-GMN-KKHOCRKBN-G
                       MOVE    SPA-GMN-KKHOCRKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *
               MOVE    SYS-2005-PREFPRGID (1)
                                           TO  SPA-GMN-PREFPRGID          
      *         
               MOVE    SYS-2005-KKHPRTKBN  TO  SPA-GMN-KKHPRTKBN
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       SPA-GMN-KKHPRTKBN-MAX
                   IF      SPA-GMN-KKHPRTKBN 
                                   =   SPA-GMN-KKHPRTKBNL (IDY)
                       MOVE    SPA-GMN-KKHPRTKBNLST (IDY)
                                           TO  SPA-GMN-KKHPRTKBN-G
                       MOVE    SPA-GMN-KKHPRTKBN-MAX
                                           TO  IDY
                   END-IF                                     
               END-PERFORM
      *
               MOVE    SYS-2005-SYAPRTNM   TO  SPA-GMN-SYAPRTNM         
      *
               MOVE    SYS-2005-KKHPRTNM   TO  SPA-GMN-KKHPRTNM         
           END-IF
      *
           IF     SPA-GMN-BYOMEIHENKBN-G   =   SPACE
               MOVE    SPA-GMN-BYOMEIHENKBNLST (1)
                                           TO  SPA-GMN-BYOMEIHENKBN-G
           END-IF                                              
           IF     SPA-GMN-BYOMEIHENKBN1-G  =   SPACE
               MOVE    SPA-GMN-BYOMEIHENKBN1LST (1)
                                           TO  SPA-GMN-BYOMEIHENKBN1-G
           END-IF                                              
           IF     SPA-GMN-TENKIHENKBN-G    =   SPACE
               MOVE    SPA-GMN-TENKIHENKBNLST (1)
                                           TO  SPA-GMN-TENKIHENKBN-G
           END-IF                                              
           IF     SPA-GMN-KKHRECEKBN-G     =   SPACE
               MOVE    SPA-GMN-KKHRECEKBNLST (1)
                                           TO  SPA-GMN-KKHRECEKBN-G
           END-IF                                              
           IF     SPA-GMN-SYARECEKBN-G     =   SPACE
               MOVE    SPA-GMN-SYARECEKBNLST (1)
                                           TO  SPA-GMN-SYARECEKBN-G
           END-IF                                              
      *
           MOVE    1                   TO  SPA-GMN-CUR
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
               WHEN    "ACTIVATE"      ALSO    "BYOMEIHENKBN"
                   PERFORM 4100-BYOMEIHENKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "KKHRECEKBN"
                   PERFORM 4101-KKHRECEKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SYARECEKBN"
                   PERFORM 4102-SYARECEKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "RECEDENOUT"
                   PERFORM 4103-RECEDENOUT-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "KKHOCRKBN"
                   PERFORM 4104-KKHOCRKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "KKHPRTKBN"
                   PERFORM 4105-KKHPRTKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "PREFPRGID"
                   PERFORM 4106-PREFPRGID-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BYOMEIHENKBN1"
                   PERFORM 4107-BYOMEIHENKBN1-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "TENKIHENKBN"
                   PERFORM 4108-TENKIHENKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SYAPRTNM"
                   PERFORM 4109-SYAPRTNM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "KKHPRTNM"
                   PERFORM 4110-KKHPRTNM-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名編集区分ェック
      *****************************************************************
       4100-BYOMEIHENKBN-CHK-SEC       SECTION.
      *
           MOVE    1                      TO  SPA-GMN-CUR
      *
           MOVE    W12-BYOMEIHENKBN       TO  SPA-GMN-BYOMEIHENKBN-G 
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-BYOMEIHENKBN-MAX
               IF      SPA-GMN-BYOMEIHENKBN 
                                   =   SPA-GMN-BYOMEIHENKBNL (IDY)
                   MOVE    SPA-GMN-BYOMEIHENKBNLST (IDY)
                                           TO  SPA-GMN-BYOMEIHENKBN-G
                   MOVE    SPA-GMN-BYOMEIHENKBN-MAX
                                           TO  IDY
               END-IF                                     
           END-PERFORM
      *     
           IF      SPA-GMN-BYOMEIHENKBNMEI =   SPACE
               MOVE    "0001"                  TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    8                       TO  SPA-GMN-CUR
           END-IF
           .
       4100-BYOMEIHENKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    国保レセプト区分ェック
      *****************************************************************
       4101-KKHRECEKBN-CHK-SEC       SECTION.
      *
           MOVE    3                      TO  SPA-GMN-CUR
      *
           MOVE    W12-KKHRECEKBN         TO  SPA-GMN-KKHRECEKBN-G 
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-KKHRECEKBN-MAX
               IF      SPA-GMN-KKHRECEKBN 
                                   =   SPA-GMN-KKHRECEKBNL (IDY)
                   MOVE    SPA-GMN-KKHRECEKBNLST (IDY)
                                           TO  SPA-GMN-KKHRECEKBN-G
                   MOVE    SPA-GMN-KKHRECEKBN-MAX
                                           TO  IDY
               END-IF                                     
           END-PERFORM
      *     
           IF      SPA-GMN-KKHRECEKBNMEI   =   SPACE
               MOVE    "0002"                  TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    4                       TO  SPA-GMN-CUR
           END-IF
           .
       4101-KKHRECEKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    社保レセプト区分ェック
      *****************************************************************
       4102-SYARECEKBN-CHK-SEC       SECTION.
      *
           MOVE    2                      TO  SPA-GMN-CUR
      *
           MOVE    W12-SYARECEKBN         TO  SPA-GMN-SYARECEKBN-G 
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-SYARECEKBN-MAX
               IF      SPA-GMN-SYARECEKBN 
                                   =   SPA-GMN-SYARECEKBNL (IDY)
                   MOVE    SPA-GMN-SYARECEKBNLST (IDY)
                                           TO  SPA-GMN-SYARECEKBN-G
                   MOVE    SPA-GMN-SYARECEKBN-MAX
                                           TO  IDY
               END-IF                                     
           END-PERFORM
      *     
           IF      SPA-GMN-SYARECEKBNMEI   =   SPACE
               MOVE    "0003"                  TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    3                       TO  SPA-GMN-CUR
           END-IF
           .
       4102-SYARECEKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセ電データ出力先チェック
      *****************************************************************
       4103-RECEDENOUT-CHK-SEC       SECTION.
      *
           MOVE    4                      TO  SPA-GMN-CUR
      *
           MOVE    W12-RECEDENOUT         TO  SPA-GMN-RECEDENOUT 
      *
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    5                      TO  SPA-GMN-CUR
           END-IF
           .
       4103-RECEDENOUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    国保ＯＣＲ印刷区分ェック
      *****************************************************************
       4104-KKHOCRKBN-CHK-SEC       SECTION.
      *
           MOVE    5                  TO  SPA-GMN-CUR
      *
           MOVE    W12-KKHOCRKBN      TO  SPA-GMN-KKHOCRKBN-G 
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-KKHOCRKBN-MAX
               IF      SPA-GMN-KKHOCRKBN
                                   =   SPA-GMN-KKHOCRKBNL (IDY)
                   MOVE    SPA-GMN-KKHOCRKBNLST (IDY)
                                           TO  SPA-GMN-KKHOCRKBN-G
                   MOVE    SPA-GMN-KKHOCRKBN-MAX
                                           TO  IDY
               END-IF                                     
           END-PERFORM
      *     
           IF      SPA-GMN-KKHOCRKBNMEI    =   SPACE
               MOVE    "0004"                  TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    6                       TO  SPA-GMN-CUR
           END-IF
           .
       4104-KKHOCRKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    県単用項目編集プログラム名チェック
      *****************************************************************
       4106-PREFPRGID-CHK-SEC       SECTION.
      *
           MOVE    6                      TO  SPA-GMN-CUR
      *
           MOVE    W12-PREFPRGID          TO  SPA-GMN-PREFPRGID
      *
           IF      SPA-GMN-PREFPRGID      =   SPACE
               CONTINUE
           ELSE     
               IF      SPA-GMN-PREFPRGID(1:1) =   "S"
                   CONTINUE
               ELSE
                  MOVE    "0006"                 TO  SPA-ERRCD
               END-IF
           END-IF            
      *
           IF      SPA-ERRCD              =   SPACE
               MOVE    10                      TO  SPA-GMN-CUR
           END-IF
           .
       4106-PREFPRGID-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    国保診療報酬請求書印刷分チェック
      *****************************************************************
       4105-KKHPRTKBN-CHK-SEC       SECTION.
      *
           MOVE    7                   TO  SPA-GMN-CUR
      *
           MOVE    W12-KKHPRTKBN       TO  SPA-GMN-KKHPRTKBN-G 
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-KKHPRTKBN-MAX
               IF      SPA-GMN-KKHPRTKBN
                                   =   SPA-GMN-KKHPRTKBNL (IDY)
                   MOVE    SPA-GMN-KKHPRTKBNLST (IDY)
                                           TO  SPA-GMN-KKHPRTKBN-G
                   MOVE    SPA-GMN-KKHPRTKBN-MAX
                                           TO  IDY
               END-IF                                     
           END-PERFORM
      *     
           IF      SPA-GMN-KKHPRTKBNMEI    =   SPACE
               MOVE    "0005"                  TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    99                      TO  SPA-GMN-CUR
           END-IF
           .
       4105-KKHPRTKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名編集区分１チェック
      *****************************************************************
       4107-BYOMEIHENKBN1-CHK-SEC       SECTION.
      *
           MOVE    8                       TO  SPA-GMN-CUR
      *
           MOVE    W12-BYOMEIHENKBN1       TO  SPA-GMN-BYOMEIHENKBN1-G 
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-BYOMEIHENKBN1-MAX
               IF      SPA-GMN-BYOMEIHENKBN1 
                                   =   SPA-GMN-BYOMEIHENKBN1L (IDY)
                   MOVE    SPA-GMN-BYOMEIHENKBN1LST (IDY)
                                           TO  SPA-GMN-BYOMEIHENKBN1-G
                   MOVE    SPA-GMN-BYOMEIHENKBN1-MAX
                                           TO  IDY
               END-IF                                     
           END-PERFORM
      *     
           IF      SPA-GMN-BYOMEIHENKBN1MEI =   SPACE
               MOVE    "0001"                  TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    9                       TO  SPA-GMN-CUR
           END-IF
           .
       4107-BYOMEIHENKBN1-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    転帰日編集区分チェック
      *****************************************************************
       4108-TENKIHENKBN-CHK-SEC       SECTION.
      *
           MOVE    9                   TO  SPA-GMN-CUR
      *
           MOVE    W12-TENKIHENKBN     TO  SPA-GMN-TENKIHENKBN-G 
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-TENKIHENKBN-MAX
               IF      SPA-GMN-TENKIHENKBN 
                                   =   SPA-GMN-TENKIHENKBNL (IDY)
                   MOVE    SPA-GMN-TENKIHENKBNLST (IDY)
                                           TO  SPA-GMN-TENKIHENKBN-G
                   MOVE    SPA-GMN-TENKIHENKBN-MAX
                                           TO  IDY
               END-IF                                     
           END-PERFORM
      *     
           IF      SPA-GMN-TENKIHENKBNMEI =   SPACE
               MOVE    "0007"                  TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    2                       TO  SPA-GMN-CUR
           END-IF
           .
       4108-TENKIHENKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    社保出力先プリンタ名チェック
      *****************************************************************
       4109-SYAPRTNM-CHK-SEC       SECTION.
      *
           MOVE    10                     TO  SPA-GMN-CUR
      *
           MOVE    W12-SYAPRTNM           TO  SPA-GMN-SYAPRTNM
      *
           IF      SPA-ERRCD              =   SPACE
               MOVE    11                      TO  SPA-GMN-CUR
           END-IF
           .
       4109-SYAPRTNM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    国保出力先プリンタ名チェック
      *****************************************************************
       4110-KKHPRTNM-CHK-SEC       SECTION.
      *
           MOVE    11                     TO  SPA-GMN-CUR
      *
           MOVE    W12-KKHPRTNM           TO  SPA-GMN-KKHPRTNM
      *
           IF      SPA-ERRCD              =   SPACE
               MOVE    7                      TO  SPA-GMN-CUR
           END-IF
           .
       4110-KKHPRTNM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W12"               TO  SPA-MOTOPG
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
      *       登録前処理
      *****************************************************************
       490-TOUROKU-SEC              SECTION.
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
           MOVE    SPACE               TO  SYS-2005-REC
           INITIALIZE                      SYS-2005-REC
           MOVE    "2005"                  TO  SYS-2005-KANRICD
           MOVE    "*"                     TO  SYS-2005-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-2005-REC            TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-2005-REC
           ELSE
               MOVE    SPACE                   TO  SYS-2005-REC
               INITIALIZE                      SYS-2005-REC
               MOVE    "2005"                  TO  SYS-2005-KANRICD
               MOVE    "*"                     TO  SYS-2005-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD        TO  SYS-2005-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-2005-EDYUKYMD
           MOVE    SPA-GMN-BYOMEIHENKBN    TO  SYS-2005-BYOMEIHENKBN
           MOVE    SPA-GMN-BYOMEIHENKBN1   TO  SYS-2005-BYOMEIHENKBN1
           MOVE    SPA-GMN-TENKIHENKBN     TO  SYS-2005-TENKIHENKBN
           MOVE    SPA-GMN-KKHRECEKBN      TO  SYS-2005-KKHRECEKBN
           MOVE    SPA-GMN-SYARECEKBN      TO  SYS-2005-SYARECEKBN
           MOVE    SPA-GMN-RECEDENOUT      TO  SYS-2005-RECEDENOUT
           MOVE    SPA-GMN-KKHOCRKBN       TO  SYS-2005-KKHOCRKBN
           MOVE    SPA-GMN-KKHPRTKBN       TO  SYS-2005-KKHPRTKBN
           MOVE    SPA-GMN-PREFPRGID       TO  SYS-2005-PREFPRGID (1)
           MOVE    SPA-GMN-SYAPRTNM        TO  SYS-2005-SYAPRTNM
           MOVE    SPA-GMN-KKHPRTNM        TO  SYS-2005-KKHPRTNM
           MOVE    SYS-2005-REC            TO  SYSKANRI-REC
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
           MOVE    SPA-GMN-CUR          TO  WRK-GMN-CUR 
      *
           PERFORM 4100-BYOMEIHENKBN-CHK-SEC
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4107-BYOMEIHENKBN1-CHK-SEC
           END-IF    
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4108-TENKIHENKBN-CHK-SEC
           END-IF    
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4101-KKHRECEKBN-CHK-SEC
           END-IF    
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4102-SYARECEKBN-CHK-SEC
           END-IF    
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4104-KKHOCRKBN-CHK-SEC
           END-IF             
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4106-PREFPRGID-CHK-SEC
           END-IF             
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4105-KKHPRTKBN-CHK-SEC
           END-IF             
      *
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-GMN-CUR          TO  SPA-GMN-CUR
           END-IF             
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
           MOVE    "W12    "           TO  MCP-WINDOW.
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
           MOVE    SPA-GMN-STYUKYMD         TO  W12-YUKOSTYMD
           MOVE    SPA-GMN-EDYUKYMD         TO  W12-YUKOEDYMD
      *
           MOVE    SPA-GMN-BYOMEIHENKBN-G   TO  W12-BYOMEIHENKBN
           MOVE    SPA-GMN-BYOMEIHENKBN1-G  TO  W12-BYOMEIHENKBN1
           MOVE    SPA-GMN-TENKIHENKBN-G    TO  W12-TENKIHENKBN
           MOVE    SPA-GMN-KKHRECEKBN-G     TO  W12-KKHRECEKBN
           MOVE    SPA-GMN-SYARECEKBN-G     TO  W12-SYARECEKBN
           MOVE    SPA-GMN-KKHOCRKBN-G      TO  W12-KKHOCRKBN
           MOVE    SPA-GMN-KKHPRTKBN-G      TO  W12-KKHPRTKBN
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-BYOMEIHENKBN-MAX
               MOVE    SPA-GMN-BYOMEIHENKBNLST (IDY)
                                       TO  W12-BYOMEIHENKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-BYOMEIHENKBN-MAX
                                       TO  W12-BYOMEIHENKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-BYOMEIHENKBN1-MAX
               MOVE    SPA-GMN-BYOMEIHENKBN1LST (IDY)
                                       TO  W12-BYOMEIHENKBN1LST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-BYOMEIHENKBN1-MAX
                                       TO  W12-BYOMEIHENKBN1-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-TENKIHENKBN-MAX
               MOVE    SPA-GMN-TENKIHENKBNLST (IDY)
                                       TO  W12-TENKIHENKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-TENKIHENKBN-MAX
                                       TO  W12-TENKIHENKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-KKHRECEKBN-MAX
               MOVE    SPA-GMN-KKHRECEKBNLST (IDY)
                                       TO  W12-KKHRECEKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-KKHRECEKBN-MAX
                                       TO  W12-KKHRECEKBN-COUNT 
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SYARECEKBN-MAX
               MOVE    SPA-GMN-SYARECEKBNLST (IDY)
                                       TO  W12-SYARECEKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYARECEKBN-MAX
                                       TO  W12-SYARECEKBN-COUNT 
      *
           MOVE    SPA-GMN-RECEDENOUT  TO  W12-RECEDENOUT                                  
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-KKHOCRKBN-MAX
               MOVE    SPA-GMN-KKHOCRKBNLST (IDY)
                                       TO  W12-KKHOCRKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-KKHOCRKBN-MAX
                                       TO  W12-KKHOCRKBN-COUNT 
      *
           MOVE    SPA-GMN-PREFPRGID   TO  W12-PREFPRGID                                  
      *     
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-KKHPRTKBN-MAX
               MOVE    SPA-GMN-KKHPRTKBNLST (IDY)
                                       TO  W12-KKHPRTKBNLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-KKHPRTKBN-MAX
                                       TO  W12-KKHPRTKBN-COUNT 
      *
           MOVE    SPA-GMN-SYAPRTNM    TO  W12-SYAPRTNM                                  
      *
           MOVE    SPA-GMN-KKHPRTNM    TO  W12-KKHPRTNM                                  
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
                   MOVE    "傷病名編集区分入力エラー"    TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "国保レセ電出力区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "社保レセ電出力区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "国保ＯＣＲ出力区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "国保診療報酬請求書区分入力エラー"
                                                         TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE
                       "県単用プログラム名の一桁目はＳで入力して下さい"
                                                         TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "転帰日編集区分入力エラー"    TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W12"                TO  SPA-MOTOPG
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
                   MOVE    "レセプト印刷情報を登録します"
                                                TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W12"                TO  SPA-MOTOPG
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
                    MOVE  "BYOMEIHENKBN"     TO   MCP-WIDGET
                WHEN    3
                    MOVE  "KKHRECEKBN"       TO   MCP-WIDGET
                WHEN    2
                    MOVE  "SYARECEKBN"       TO   MCP-WIDGET
                WHEN    4
                    MOVE  "RECEDENOUT"       TO   MCP-WIDGET
                WHEN    5
                    MOVE  "KKHOCRKBN"        TO   MCP-WIDGET
                WHEN    6
                    MOVE  "PREFPRGID"        TO   MCP-WIDGET
                WHEN    7
                    MOVE  "KKHPRTKBN"        TO   MCP-WIDGET
                WHEN    8
                    MOVE  "BYOMEIHENKBN1"    TO   MCP-WIDGET
                WHEN    9
                    MOVE  "TENKIHENKBN"      TO   MCP-WIDGET
                WHEN    10
                    MOVE  "SYAPRTNM"         TO   MCP-WIDGET
                WHEN    11
                    MOVE  "KKHPRTNM"         TO   MCP-WIDGET
                WHEN    99
                    MOVE  "B12"              TO   MCP-WIDGET
            END-EVALUATE
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
