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
       PROGRAM-ID.                               ORCGV01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 保険番号情報入力
      *  コンポーネント名  : 保険番号情報入力（Ｖ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01/07/03  日付入力チェックサブ追加
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.00.02    MCC-藤原     01/10/09  共通ＳＰＡの項目追加     
      *  01.02.01    MCC-藤原     02/02/01  入力エラーの時の確定のチェック     
      *  01.02.02    MCC-藤原     02/02/21  支払区分の初期値のセット     
      *  01.02.03    MCC-藤原     02/03/22  選択番号未入力のときの遷移修正     
      *  01.02.04    NACL-多々納  02/12/19  リスト選択修正
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
           COPY    "V01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-V01.
           03  SPA-V01-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-TBLO    OCCURS  100.
                           11  SPA-GMN-TBANGO     PIC 9(03).
                           11  SPA-GMN-TPAYKBN    PIC X(02). 
                           11  SPA-GMN-TSTYUKYMD  PIC X(09).
                           11  SPA-GMN-TEDYUKYMD  PIC X(09).  
                   07  SPA-GMN-HKNNUM             PIC X(03).
                   07  SPA-GMN-KOUMOKU.
                       09  SPA-GMN-SELNUM         PIC 9(03).
                       09  SPA-GMN-STYUKYMD       PIC X(10).
                       09  SPA-GMN-EDYUKYMD       PIC X(10).
                       09  SPA-GMN-TANSEIDONAME   PIC X(10).
                       09  SPA-GMN-PAYKBN         PIC X(02). 
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-HKNNUM             PIC X(03).
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
      *   
           COPY    "ENUM-VALUE".
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                            PIC 9(01).
           03  FLG-HKNNUM                         PIC 9(01).

      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                               PIC 9(04).
           03  IDY                               PIC 9(04).
           03  IDZ                               PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SELNO           PIC 9(03).
           03  WRK-WIDMSG          PIC X(70). 
           03  WRK-YMD             PIC X(10). 
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
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
       01  HKNNUM-REC.
           COPY  "CPHKNNUM.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *----(01.00.01) LINE ADD START ----------------------------------
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *    ＤＢ検索
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
           COPY    "V01.INC".
           COPY    "V02.INC".
           COPY    "VERR.INC".
           COPY    "VID1.INC".
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
           MOVE    SPA-WORK        TO  SPA-V01KYOUTU 
           MOVE    SPA-FREE        TO  SPA-V01
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
           MOVE    SPA-V01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-V01         TO  SPA-FREE
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
           IF      SPA-MOTOPG          =   "VERR"
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
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "V01    "           TO  MCP-WINDOW.
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
           INITIALIZE              SPA-V01-AREA
                                   SPA-V01KYOUTU
           MOVE    1               TO  SPA-GMN-CUR
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
      *        保険番号
               WHEN    "ACTIVATE"       ALSO    "HKNNUM"
                   PERFORM  4104-HKNNUM-CHK-SEC
      *        選択番号
               WHEN    "ACTIVATE"       ALSO    "SELNUM"
                   PERFORM  4101-SELNUM-CHK-SEC
      *        支払区分
               WHEN    "ACTIVATE"       ALSO    "PAYKBN"
                   PERFORM  4105-PAYKBN-CHK-SEC
      *        有効開始年月日
               WHEN    "ACTIVATE"       ALSO    "STYUKYMD"
                   PERFORM  4102-STYUKYMD-CHK-SEC
      *        有効終了年月日
               WHEN    "ACTIVATE"       ALSO    "EDYUKYMD"
                   PERFORM  4103-EDYUKYMD-CHK-SEC
      *        行選択
               WHEN    ANY             ALSO    "LIST"
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
           MOVE    "V01"               TO  SPA-MOTOPG
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
      *    番号選択　入力処理
      *****************************************************************
       4101-SELNUM-CHK-SEC       SECTION.
      *
           MOVE    2               TO  SPA-GMN-CUR
      *
           INITIALIZE                     SPA-GMN-KOUMOKU
                                          SPA-NAI-KOUMOKU
                                          SPA-NAI-SELNO
      *
           MOVE    V01-SELNUM             TO  SPA-GMN-SELNUM
      *
      *    選択番号チェック
           IF      SPA-GMN-SELNUM      =   ZERO
               IF      SPA-GMN-HKNNUM  =   "027"
                   MOVE    5                   TO  SPA-GMN-CUR
               ELSE
                   MOVE    ZERO                TO  SPA-GMN-PAYKBN
                   MOVE    3                   TO  SPA-GMN-CUR
               END-IF         
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
           MOVE    SPA-GMN-TPAYKBN  (SPA-GMN-SELNUM)
                                       TO  SPA-GMN-PAYKBN
      * 
           INITIALIZE                      HKNNUM-REC
           MOVE    SPA-HOSPID              TO  HKN-HOSPID
           MOVE    SPA-GMN-HKNNUM          TO  HKN-HKNNUM
           MOVE    SPA-GMN-PAYKBN          TO  HKN-PAYKBN
           MOVE    SPA-NAI-STYUKYMD        TO  HKN-TEKSTYMD
           MOVE    SPA-NAI-EDYUKYMD        TO  HKN-TEKEDYMD
           MOVE    HKNNUM-REC              TO  MCPDATA-REC
           PERFORM 900-HKNNUM-INV-SEC
           IF      FLG-HKNNUM              =   ZERO
               MOVE    MCPDATA-REC             TO  HKNNUM-REC
               MOVE    HKN-TANSEIDONAME        TO  SPA-GMN-TANSEIDONAME
           END-IF
      *
           MOVE    3                   TO  SPA-GMN-CUR 
           .
       41011-SELNUM-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    有効開始年月日チェック処理
      *****************************************************************
       4102-STYUKYMD-CHK-SEC          SECTION.
      *
           MOVE    3                  TO  SPA-GMN-CUR
      *
           MOVE   V01-STYUKYMD        TO  SPA-GMN-STYUKYMD
      *
           MOVE    ZERO               TO  SPA-NAI-STYUKYMD     
      *
           IF      SPA-GMN-STYUKYMD   =   SPACE
               MOVE    "00000000"         TO  SPA-GMN-STYUKYMD
           END-IF
      *
           MOVE    SPA-GMN-STYUKYMD   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-SYMD             TO  SPA-NAI-STYUKYMD 
               MOVE    WRK-HENYMDG          TO  SPA-GMN-STYUKYMD
           ELSE    
               GO  TO  4102-STYUKYMD-CHK-EXT
           END-IF
      *
           MOVE    4                   TO  SPA-GMN-CUR
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
           MOVE    4                  TO  SPA-GMN-CUR
      *
           MOVE   V01-EDYUKYMD        TO  SPA-GMN-EDYUKYMD
      *
           MOVE    ZERO               TO  SPA-NAI-EDYUKYMD     
      *
           IF      SPA-GMN-EDYUKYMD   =   SPACE
               MOVE    "99999999"         TO  SPA-GMN-EDYUKYMD
           END-IF
      *
           MOVE    SPA-GMN-EDYUKYMD   TO  WRK-YMD
           PERFORM 5002-HIZUKE-CHK-SEC
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-SYMD             TO  SPA-NAI-EDYUKYMD 
               MOVE    WRK-HENYMDG          TO  SPA-GMN-EDYUKYMD
           ELSE    
               GO  TO  4103-EDYUKYMD-CHK-EXT
           END-IF
      *
           MOVE    12                 TO  SPA-GMN-CUR
      *
           .
       4103-EDYUKYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号　入力処理
      *****************************************************************
       4104-HKNNUM-CHK-SEC       SECTION.
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
                                       SPA-GMN-MAX
                                       SPA-GMN-TBL
                                       SPA-NAIB-AREA
                                       SPA-NAI-SELNO 
      *
           MOVE    V01-HKNNUM     TO  SPA-GMN-HKNNUM
      * 
           INITIALIZE                      HKNNUM-REC
           MOVE    SPA-HOSPID              TO  HKN-HOSPID
           MOVE    SPA-GMN-HKNNUM          TO  HKN-HKNNUM
           MOVE    HKNNUM-REC              TO  MCPDATA-REC
           MOVE    "DBSELECT"              TO  MCP-FUNC
           MOVE    "HKNNUM-KEY2"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"                  USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY2"     TO  ORC-DBPATH
               PERFORM 900-HKNNUM-READ-SEC
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   FLG-HKNNUM   =   1
                               OR      IDX            >=  100
               MOVE    MCPDATA-REC        TO  HKNNUM-REC
               ADD     1                  TO  IDX
               MOVE    IDX                TO  SPA-GMN-TBANGO    (IDX)
               MOVE    HKN-PAYKBN         TO  SPA-GMN-TPAYKBN   (IDX)
               MOVE    HKN-TEKSTYMD       TO  SPA-NAI-TSTYUKYMD (IDX)
               MOVE    HKN-TEKSTYMD       TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG        TO  SPA-GMN-TSTYUKYMD (IDX)
               MOVE    HKN-TEKEDYMD       TO  SPA-NAI-TEDYUKYMD (IDX)
               MOVE    HKN-TEKEDYMD       TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG        TO  SPA-GMN-TEDYUKYMD (IDX)
               MOVE    IDX                TO  SPA-GMN-MAX
      *
               MOVE    "HKNNUM-KEY2"      TO  ORC-DBPATH
               PERFORM 900-HKNNUM-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           MOVE    SPA-GMN-HKNNUM      TO  SPA-NAI-HKNNUM
      *     
           EVALUATE    SPA-GMN-MAX
               WHEN    ZERO
                   IF      SPA-GMN-HKNNUM  =   "027"
                       MOVE    5                   TO  SPA-GMN-CUR
                   ELSE
                       MOVE    ZERO                TO  SPA-GMN-PAYKBN
                       MOVE    3                   TO  SPA-GMN-CUR
                   END-IF         
               WHEN    1
                   MOVE    SPA-GMN-TSTYUKYMD (1)   TO  SPA-GMN-STYUKYMD
                   MOVE    SPA-NAI-TSTYUKYMD (1)   TO  SPA-NAI-STYUKYMD
                   MOVE    SPA-GMN-TEDYUKYMD (1)   TO  SPA-GMN-EDYUKYMD
                   MOVE    SPA-NAI-TEDYUKYMD (1)   TO  SPA-NAI-EDYUKYMD
                   MOVE    SPA-GMN-TPAYKBN   (1)   TO  SPA-GMN-PAYKBN
                   MOVE    HKN-TANSEIDONAME        TO
                                                   SPA-GMN-TANSEIDONAME
                   MOVE    1                       TO  SPA-GMN-SELNUM
                   MOVE    1                       TO  SPA-NAI-SELNO 
                   MOVE    12                      TO  SPA-GMN-CUR
               WHEN    OTHER
                   MOVE    2                       TO  SPA-GMN-CUR
           END-EVALUATE           
           .
       4104-HKNNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    支払区分　入力処理
      *****************************************************************
       4105-PAYKBN-CHK-SEC       SECTION.
      *
           MOVE    5               TO  SPA-GMN-CUR
      *
           MOVE    V01-PAYKBN           TO  SPA-GMN-PAYKBN
      *
           IF      SPA-GMN-PAYKBN  =   SPACE
               MOVE    ZERO           TO  SPA-GMN-PAYKBN
           END-IF            
      *
           MOVE    3                  TO  SPA-GMN-CUR
           .
       4105-PAYKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41015-LIST1SEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-MAX
               IF      V01-SELECT (IDX)    =   "T"
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
           MOVE    SPA-NAI-SELNO      TO  SPA-GMN-SELNUM 
      *
           PERFORM 41011-SELNUM-HENSYU-SEC               
           .
       41015-LIST1SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定
      *****************************************************************
       410-KAKUTEI-SEC           SECTION.
      *
      *
           IF      SPA-NAI-STYUKYMD        =   ZERO
               IF      SPA-GMN-STYUKYMD(1:8)   =   ALL "0"
                   CONTINUE
               ELSE    
                   MOVE    1                   TO  SPA-GMN-CUR
                   MOVE    "0006"              TO  SPA-ERRCD
                   GO  TO  410-KAKUTEI-EXT
               END-IF
           END-IF    
           IF      SPA-NAI-EDYUKYMD    =   ZERO
           OR      SPA-NAI-HKNNUM      =   SPACE
               MOVE    1                   TO  SPA-GMN-CUR
               MOVE    "0006"              TO  SPA-ERRCD
               GO  TO  410-KAKUTEI-EXT
           END-IF
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-MAX
                   OR      SPA-ERRCD   NOT =   SPACE
               IF      SPA-GMN-SELNUM      =   IDX 
                   CONTINUE
               ELSE
                   IF      SPA-GMN-PAYKBN  =   SPA-GMN-TPAYKBN   (IDX)
                       IF      SPA-NAI-STYUKYMD
                                           >=  SPA-NAI-TSTYUKYMD (IDX)
                       AND     SPA-NAI-STYUKYMD
                                           <=  SPA-NAI-TEDYUKYMD (IDX)
                           MOVE    "0004"      TO  SPA-ERRCD 
                       END-IF
                       IF      SPA-NAI-EDYUKYMD
                                           >=  SPA-NAI-TSTYUKYMD (IDX)
                       AND     SPA-NAI-EDYUKYMD
                                           <=  SPA-NAI-TEDYUKYMD (IDX)
                           MOVE    "0004"              TO  SPA-ERRCD 
                       END-IF
                   END-IF    
               END-IF
           END-PERFORM 
           IF      SPA-ERRCD           NOT =   SPACE
               MOVE    2                   TO  SPA-GMN-CUR
               GO  TO  410-KAKUTEI-EXT
           END-IF      
      *                   
      *    画面移行用のパラメタ
           INITIALIZE                  SPA-V01KYOUTU
           MOVE    SPA-GMN-HKNNUM      TO  SPA-V01-HKNNUM
           IF      SPA-GMN-PAYKBN      =   SPACE
               MOVE    "00"                TO  SPA-V01-PAYKBN
           ELSE    
               MOVE    SPA-GMN-PAYKBN      TO  SPA-V01-PAYKBN
           END-IF    
           MOVE    SPA-NAI-STYUKYMD    TO  SPA-V01-STYUKYMD
           MOVE    SPA-NAI-EDYUKYMD    TO  SPA-V01-EDYUKYMD 
           MOVE    SPA-GMN-STYUKYMD    TO  SPA-V01-STYUKYMDH
           MOVE    SPA-GMN-EDYUKYMD    TO  SPA-V01-EDYUKYMDH
           MOVE    SPA-GMN-SELNUM      TO  SPA-V01-SELNUM  
           MOVE    SPA-V01KYOUTU       TO  SPA-WORK
      *
           MOVE    "V02"               TO  SPA-SAKIPG
           MOVE    "V01"               TO  SPA-MOTOPG
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
      ****         IF      WRK-YMD  (1:7)  NOT NUMERIC
      *                 INSPECT     WRK-YMD      REPLACING   ALL " " BY  "0"         
      *                 MOVE    WRK-YMD(1:1)      TO  WRK-WGO
      *                 MOVE    WRK-YMD(2:2)      TO  WRK-WYY
      *                 MOVE    WRK-YMD(5:2)      TO  WRK-WMM
      *                 MOVE    WRK-YMD(8:2)      TO  WRK-WDD
      *             ELSE
      *                 MOVE    WRK-YMD(1:7)      TO  WRK-WYMD 
      *             END-IF
      *
      *             INITIALIZE                      STS-AREA-DAY
      *             INITIALIZE                      LNK-DAY1-AREA
      *             MOVE    "12"                TO  LNK-DAY1-IRAI
      *             MOVE    ZERO                TO  LNK-DAY1-YMD
      *             MOVE    WRK-WYMD            TO  LNK-DAY1-YMD(2:7)
      *             CALL    "ORCSDAY"           USING   STS-AREA-DAY
      *                                                 LNK-DAY1-AREA
      *             IF      STS-DAY-RC1     NOT =   ZERO
      *                 MOVE    "0002"          TO  SPA-ERRCD
      *             ELSE
      *                 MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
      *                 PERFORM 5002-HIZUKE-HEN-SEC
      **********    END-IF
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
           MOVE    "V01    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  V01
      *
           MOVE    ZERO                TO  V01-COUNT
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-MAX
               MOVE    SPA-GMN-TBANGO     (IDX)
                                          TO  V01-TBANGO   (IDX)
               MOVE    SPA-GMN-TPAYKBN    (IDX)
                                          TO  V01-TPAYKBN  (IDX)
               MOVE    SPA-GMN-TSTYUKYMD  (IDX)
                                          TO  V01-TSTYUKYMD(IDX)
               MOVE    SPA-GMN-TEDYUKYMD  (IDX)
                                          TO  V01-TEDYUKYMD(IDX)
               MOVE    IDX                TO  V01-COUNT
               IF      IDX             =   SPA-NAI-SELNO 
                   MOVE    "T"             TO  V01-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  V01-SELECT (IDX)
               END-IF
           END-PERFORM   
           MOVE    SPA-GMN-SELNUM      TO  V01-SELNUM
           MOVE    SPA-GMN-STYUKYMD    TO  V01-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD    TO  V01-EDYUKYMD
           MOVE    SPA-GMN-HKNNUM      TO  V01-HKNNUM
           MOVE    SPA-GMN-TANSEIDONAME
                                       TO  V01-TANSEIDONAME
           MOVE    SPA-GMN-PAYKBN      TO  V01-PAYKBN
      *
      *
           IF      SPA-NAI-HKNNUM     =   "027"
           AND     SPA-GMN-SELNUM     =   ZERO
               MOVE    WIDGET-NORMAL      TO  V01-PAYKBN-STATE
           ELSE         
               MOVE    WIDGET-INSENSITIVE TO  V01-PAYKBN-STATE
           END-IF
      *      
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
           EVALUATE    SPA-GMN-CUR
                WHEN   1
                    MOVE  "HKNNUM"    TO  MCP-WIDGET
                WHEN   2
                    MOVE  "SELNUM"     TO  MCP-WIDGET
                WHEN   3
                    MOVE  "STYUKYMD"   TO  MCP-WIDGET
                WHEN   4
                    MOVE  "EDYUKYMD"   TO  MCP-WIDGET
                WHEN   5
                    MOVE  "PAYKBN"      TO  MCP-WIDGET
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
                   MOVE    "項目に入力がありません"   TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "有効期間が重複します"     TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "管理コードがちがいます"   TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "エラーがある項目があります"
                                                      TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  VERR
           MOVE    SPA-ERRCD            TO  VERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  VERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "V01"                TO  SPA-MOTOPG
           MOVE    "VERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "VERR"               TO  MCP-WINDOW
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
      *    管理マスター読込（キー）
      *****************************************************************
       900-HKNNUM-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNNUM
               ELSE
                   MOVE    1                   TO  FLG-HKNNUM
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNNUM
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-HKNNUM-INV-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-HKNNUM-READ-SEC         SECTION.
      *
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           .
       900-HKNNUM-READ-EXT.
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

