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
       PROGRAM-ID.             ORCGC05.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 病名登録
      *  コンポーネント名  : 病名検索（Ｃ０５）
      *  管理者            : 
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.04.23  漢字名称・カナ名称を同時に読み込む    
      *  01.00.02    MCC-藤原     01/09/11  選択番号の編集    
      *  01.01.01    MCC-藤原     01/09/20  JOINの修正      
      *  01.01.02    MCC-藤原     01/11/05  C01の削除
      *  01.01.03    MCC-藤原     01/11/13  病名コードを７桁に変更     
      *  01.02.01    MCC-藤原     01/11/21  ORCMCPSUBへ変更  
      *  01.02.02    MCC-藤原     01/12/18  検索病名ありのとき検索処理をする
      *  01.02.03    MCC-藤原     02/05/08  半角チェック追加
      *
      *  01.03.01    NACL-藤原    02/08/20  新傷病名マスタ対応
      *  01.03.02    NACL-藤原    02/11/25  複数端末での戻り先の修正
      *                                     ＳＰＡパラメタファイルの
      *                                     端末ＩＤ変更
      *
      *  新患者病名マスタ対応
      *  01.04.01    NACL-藤原    03/12/17  前・次頁対応
      *                                     移行先の確認画面追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    ＳＰＡデータ
           SELECT  SPASCR-FILE     ASSIGN  FILE-NAME1
                                   ORGANIZATION    IS  LINE
                                                       SEQUENTIAL 
                                   FILE    STATUS  IS  STS-SPASCR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    ＳＰＡパラメタデータ
       FD  SPASCR-FILE.
       01  SPA-DATA-REC            PIC X(40000).
      *
      *
       WORKING-STORAGE             SECTION.
      *
      * ＳＰＡパラメタデータ
       01  FILE-NAME1.
           03  FILLE               PIC X(18)   VALUE
                                               "/var/tmp/C05SPASCR".
      *****03  FILE-TERMID         PIC X(16)   VALUE   SPACE.
           03  FILE-TERMID         PIC X(64)   VALUE   SPACE.
           03  FILLER              PIC X(04)   VALUE   ".TXT".
      *
       01  WRK-DATA-REC.
           03  WRK-DATA            PIC X(40000)
                                   OCCURS  10.
      * 
       01  SPA-SCR-REC.
           COPY    "CPC05SPASCR.INC".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    病名登録用共通パラメタ
           COPY    "C01COMMON-SPA".
      *
      *    病名登録用画面ＳＰＡ
           COPY    "C02SCR-SPA".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-SPASCR          PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-KNJBYO          PIC 9(01).
           03  FLG-BYOMEI          PIC 9(01).
           03  FLG-GKOU            PIC 9(02).
           03  FLG-BYOCD           PIC 9(01).
           03  FLG-KANJI           PIC 9(01).
           03  FLG-SPASCR          PIC 9(01).
      *
           03  FLG-END2            PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(05).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SELNO           PIC 9(04).
           03  WRK-NUM             PIC ZZZZ9.
           03  WRK-STR             PIC 9(05).
           03  WRK-BANGO           PIC 9(05).
           03  WRK-HAISIYMDH       PIC X(22).
           03  WRK-CIDMSG          PIC X(100).
      *
      *    並びかえ用ワーク
           03  WRK-GMN-BYOMEICD-G.
               05  WRK-GMN-TBYOMEICD1
                                   PIC X(07).
               05  WRK-GMN-TBYOMEI1
                                   PIC X(200).
      *     
           03  WRK-MOJISU          PIC 9(04).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(09).
      *
           03  WRK-ERRMSG          PIC X(40).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
       01  WRK-CONS-AREA.
      *    病名コード数
           03  WRK-CONS-BYOMEICD-MAX
                                   PIC 9(02)   VALUE   21.
      *    病名一覧行数
           03  WRK-CONS-BYOMEI-MAX         PIC 9(03)   VALUE   100.
      *
      *    病名システム予約コードテーブル
           COPY    "CMBYOMEICD.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    病名コード検索サブ
           COPY    "CPORCSBYOMEI.INC".
      *
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *****COPY    "MCPAREA.INC".
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "C02.INC".
           COPY    "C03.INC".
           COPY    "C04.INC".
           COPY    "C05.INC".
           COPY    "C06.INC".
           COPY    "C07.INC".
           COPY    "C08.INC".
           COPY    "C09.INC".
           COPY    "C10.INC".
           COPY    "CERR.INC".
           COPY    "CID1.INC".
           COPY    "CID2.INC".
           COPY    "CID3.INC".
           COPY    "CID4.INC".
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
           MOVE    SPA-WORK        TO  SPA-C01KYOUTU
           MOVE    SPA-FREE        TO  SPA-C02FREE
      *
      *    画面ＳＰＡ読み込み
           PERFORM 1002-C05SPA-SET-SEC
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
      *    画面ＳＰＡ書込み
           IF      FLG-END2            =   ZERO
               PERFORM 1003-C05SPA-OUT-SEC
           END-IF
      *
           MOVE    SPA-C01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-C02FREE     TO  SPA-FREE
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    ＳＰＡデータセット処理
      *****************************************************************
      *
       1002-C05SPA-SET-SEC             SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID
      *
           OPEN    INPUT               SPASCR-FILE
           IF      STS-SPASCR     NOT =   ZERO
               GO      TO         1002-C05SPA-SET-EXT
           END-IF
      *
           INITIALIZE          SPA-SCR-REC
           INITIALIZE          WRK-DATA-REC
           MOVE    ZERO                TO  FLG-SPASCR
           MOVE    ZERO                TO  IDX
           PERFORM UNTIL       FLG-SPASCR  =   1
               READ    SPASCR-FILE
                   AT  END
                       MOVE   1            TO  FLG-SPASCR
                   NOT AT  END
                       ADD    1            TO  IDX
                       MOVE   SPA-DATA-REC     TO  WRK-DATA (IDX)
               END-READ
           END-PERFORM
      *
           MOVE    WRK-DATA-REC        TO  SPA-SCR-REC
      *
           CLOSE                       SPASCR-FILE
           .
       1002-C05SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＳＰＡデータＷＲＩＴＥ処理
      *****************************************************************
       1003-C05SPA-OUT-SEC             SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID
      *
           OPEN    OUTPUT              SPASCR-FILE
           IF      STS-SPASCR     NOT =   ZERO
               DISPLAY "C05SPASCR OUT OPEN ERR:"   STS-SPASCR
      ***         STOP    " "
           END-IF
           MOVE    SPA-SCR-REC         TO  WRK-DATA-REC
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL      (IDX     >   10  )  OR
                              (WRK-DATA (IDX)     =   SPACE)
      *
               MOVE    WRK-DATA (IDX)      TO  SPA-DATA-REC
               WRITE                       SPA-DATA-REC
               IF      STS-SPASCR     NOT =   ZERO
                   DISPLAY "C05SPASCR OUT WRITE ERR:"   STS-SPASCR
      ***             STOP    " "
                END-IF
           END-PERFORM
      *
           CLOSE                       SPASCR-FILE
           .
       1003-C05SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面より
           IF      SPA-MOTOPG      =   "CERR"
               MOVE    SPACE           TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      * 
           MOVE  SPACE             TO  LINKAREA
      *
           MOVE  SPACE             TO  MCP-PUTTYPE.
           MOVE  "C05"             TO  MCP-WINDOW.
      *
           PERFORM  900-PUT-WINDOW.
      *
           MOVE  1                 TO  FLG-END
          .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           EVALUATE    TRUE
      *            病名移行確認画面より
               WHEN    SPA-MOTOPG(1:4)  =  "CID2"
                   PERFORM 340-CID2-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE              SPA-C05
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       WRK-CONS-BYOMEICD-MAX
                   OR      SPA-C01-TBYOMEICD(IDX)  =   SPACE
               MOVE    SPA-C01-TBYOMEICD (IDX)
                                           TO  SPA-GMN-TBYOMEICD1(IDX)
               MOVE    SPA-C01-TBYOMEI   (IDX)
                                           TO  SPA-GMN-TBYOMEI1  (IDX)      
               MOVE    IDX                 TO  SPA-GMN-BYOMEICD-MAX
           END-PERFORM
      *
      *    編集病名変換処理
           PERFORM 410121-HENBYOMEI-SEC 
      *
           MOVE    1               TO  SPA-GMN-CUR
                                       SPA-GMN-PAGE
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *     病名移行確認画面よりの処理
      *****************************************************************
       340-CID2-SET-SEC                  SECTION.
      *
           EVALUATE    SPA-CIDCD2
               WHEN    "0101"
      *            選択病名移行処理
                   IF      SPA-CID2-FLG    =   "OK"
                       MOVE    SPA-C05-IKOSAKI-INDEX
                                           TO  IDZ
                       MOVE    SPA-C05-IKOSAKI-BYOMEICD
                                           TO  SPA-GMN-TBYOMEICD1(IDZ)
                       MOVE    SPA-C05-IKOSAKI-BYOMEI
                                           TO  SPA-GMN-TBYOMEI1  (IDZ)
                   END-IF              
      *            編集病名変換処理
                   PERFORM 410121-HENBYOMEI-SEC
      *
                   PERFORM 420-CLEAR-SEC
      *
                   IF      SPA-GMN-BYOMEICD-MAX  
                                           =   WRK-CONS-BYOMEICD-MAX
                       MOVE    3               TO  SPA-GMN-CUR
                   END-IF  
           END-EVALUATE
      *     
           MOVE    SPACE           TO  SPA-CIDCD2
           .
       340-CID2-SET-EXT.
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
                   PERFORM 210-BACK
      *    クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 420-CLEAR-SEC
      *    選択番号１へ移動
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 430-SELNUM1-SET-SEC
      *    選択番号２へ移動
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 440-SELNUM2-SET-SEC
      *    前画面
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 460-MAEGMN-SEC
      *    次画面
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 470-ATOGMN-SEC
      *    コード消去
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 490-BYOMEICD-DELETE-SEC
      *    ↑移動
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 490-BYOMEICD-DOWN-SEC
      *    ↓移動
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-BYOMEICD-UP-SEC
      *    確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-KAKUTEI-SEC
           END-EVALUATE
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"      ALSO    "BYOMEIKEN"
                   PERFORM 41011-BYOKEN-HEN-SEC
      *
               WHEN    "ACTIVATE"      ALSO    "SELNUM1"
                   PERFORM 41012-SELNUM1-HEN-SEC
      *
               WHEN    "ACTIVATE"      ALSO    "SELNUM2"
                   PERFORM 41013-SELNUM2-HEN-SEC
      *
               WHEN    ANY             ALSO    "BYOMEICDLST"
                   PERFORM 41014-BYOMEICDSEL-SEC
      *        病名行選択
               WHEN    ANY             ALSO    "BYOMEILST"
                   PERFORM 41015-BYOMEISEL-SEC
           END-EVALUATE
           .
       200-ENTRY-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
      *    ファイルクリア
           MOVE    SPA-TERMID          TO  FILE-TERMID
           MOVE    ZERO                TO  IF-RESULT
           MOVE    FILE-NAME1          TO  IF-FILENAME
           CALL    "orcfiledel"        USING
                                       ORCSFDELAREA
           MOVE    1                   TO  FLG-END2
      *
           MOVE    SPA-C01-MOTOPG      TO  SPA-SAKIPG
           MOVE    "C05"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  SPA-C01KYOUTU
           MOVE    SPA-C01KYOUTU       TO  SPA-WORK
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア処理
      *****************************************************************
       420-CLEAR-SEC             SECTION.
      *
           INITIALIZE                  SPA-GMN-BYOKEN
                                       SPA-GMN-BYOMEI-TBL
                                       SPA-NAI-BYOMEI-TBL
           MOVE    ZERO            TO  SPA-GMN-SELNUM1
                                       SPA-GMN-SELNUM2
           MOVE    ZERO            TO  SPA-GMN-BYOMEI-MAX
           MOVE    ZERO            TO  SPA-NAI-SELNO1
                                       SPA-NAI-SELNO2
                                       SPA-GMN-NEXT
                                       SPA-GMN-PAGE
      *
           MOVE    1               TO  SPA-GMN-CUR   
           .
       420-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号１へ移動処理
      *****************************************************************
       430-SELNUM1-SET-SEC         SECTION.
      *
           MOVE    2               TO  SPA-GMN-CUR   
           .
       430-SELNUM1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号２へ移動処理
      *****************************************************************
       440-SELNUM2-SET-SEC         SECTION.
      *
           MOVE    4               TO  SPA-GMN-CUR   
           .
       440-SELNUM2-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       460-MAEGMN-SEC             SECTION.
      *
           IF    ( SPA-GMN-PAGE        =   1    )
           OR    ( SPA-GMN-BYOMEI-MAX  =   ZERO )
               GO      TO      460-MAEGMN-EXT
           END-IF
      *
           COMPUTE SPA-GMN-PAGE    =   SPA-GMN-PAGE    -   1
      *
           INITIALIZE                      SPA-GMN-BYOMEI-TBL
                                           SPA-NAI-BYOMEI-TBL
           MOVE    ZERO                TO  SPA-GMN-BYOMEI-MAX
                                           SPA-NAI-SELNO1
                                           SPA-GMN-SELNUM1
      *    検索処理
           PERFORM 410112-BYOMEI-LST-SEC
           .
       460-MAEGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       470-ATOGMN-SEC             SECTION.
      *
           IF    ( SPA-GMN-NEXT        =   ZERO )
           OR    ( SPA-GMN-BYOMEI-MAX  =   ZERO )
               GO      TO      470-ATOGMN-EXT
           END-IF
      *
           ADD     1                   TO  SPA-GMN-PAGE
      *
           INITIALIZE                      SPA-GMN-BYOMEI-TBL
                                           SPA-NAI-BYOMEI-TBL
           MOVE    ZERO                TO  SPA-GMN-BYOMEI-MAX
                                           SPA-NAI-SELNO1
                                           SPA-GMN-SELNUM1
      *    検索処理
           PERFORM 410112-BYOMEI-LST-SEC
           .
       470-ATOGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    コード消去処理
      *****************************************************************
       490-BYOMEICD-DELETE-SEC         SECTION.
      *
           IF      SPA-NAI-SELNO2      =   ZERO
               GO  TO  490-BYOMEICD-DELETE-EXT
           END-IF
      *
           MOVE    SPA-GMN-SELNUM2     TO  IDX
      *     
           PERFORM VARYING IDY     FROM    IDX BY  1
                   UNTIL   IDY     >       21
                   OR      SPA-GMN-TBYOMEICD1 (IDY)
                                   =   SPACE
               MOVE    SPACE       TO  SPA-GMN-BYOMEICD-G (IDY)
               IF      IDY             <   21
                   COMPUTE IDX1     =   IDY    +   1
                   MOVE    SPA-GMN-BYOMEICD-G (IDX1)
                                       TO  SPA-GMN-BYOMEICD-G (IDY)
               END-IF   
           END-PERFORM
      *
           COMPUTE SPA-GMN-BYOMEICD-MAX    =   SPA-GMN-BYOMEICD-MAX
                                               -   1
           MOVE    ZERO            TO  SPA-GMN-SELNUM2
                                       SPA-NAI-SELNO2        
      *
      *    編集病名変換処理
           PERFORM 410121-HENBYOMEI-SEC
           .
       490-BYOMEICD-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    コード↑移動処理
      *****************************************************************
       490-BYOMEICD-DOWN-SEC             SECTION.
      *
           IF      SPA-NAI-SELNO2      <   2
               GO  TO  490-BYOMEICD-DOWN-EXT
           END-IF
      *
           MOVE    SPA-NAI-SELNO2      TO  IDX
      *     
           MOVE    SPA-GMN-BYOMEICD-G (IDX)
                                       TO  WRK-GMN-BYOMEICD-G
           COMPUTE IDX1     =   IDX    -   1
           MOVE    SPA-GMN-BYOMEICD-G (IDX1)
                                       TO  SPA-GMN-BYOMEICD-G (IDX)
           MOVE    WRK-GMN-BYOMEICD-G  TO  SPA-GMN-BYOMEICD-G (IDX1)
      *
           MOVE    ZERO            TO  SPA-GMN-SELNUM2
                                       SPA-NAI-SELNO2        
      *
      *    編集病名変換処理
           PERFORM 410121-HENBYOMEI-SEC
           .
       490-BYOMEICD-DOWN-EXT.
           EXIT.
      *
      *****************************************************************
      *    コード↓移動処理
      *****************************************************************
       490-BYOMEICD-UP-SEC             SECTION.
      *
           IF      SPA-NAI-SELNO2      =   ZERO    OR
                                           SPA-GMN-BYOMEICD-MAX
               GO  TO  490-BYOMEICD-UP-EXT
           END-IF
      *
           MOVE    SPA-NAI-SELNO2      TO  IDX
      *     
           MOVE    SPA-GMN-BYOMEICD-G (IDX)
                                       TO  WRK-GMN-BYOMEICD-G
           COMPUTE IDX1     =   IDX    +   1
           MOVE    SPA-GMN-BYOMEICD-G (IDX1)
                                       TO  SPA-GMN-BYOMEICD-G (IDX)
           MOVE    WRK-GMN-BYOMEICD-G  TO  SPA-GMN-BYOMEICD-G (IDX1)
      *
           MOVE    ZERO            TO  SPA-GMN-SELNUM2
                                       SPA-NAI-SELNO2        
      *
      *    編集病名変換処理
           PERFORM 410121-HENBYOMEI-SEC
           .
       490-BYOMEICD-UP-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定処理
      *****************************************************************
       450-KAKUTEI-SEC             SECTION.
      *
      *    編集病名変換処理
           PERFORM 410121-HENBYOMEI-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE    1                   TO  SPA-GMN-CUR  
               GO  TO  450-KAKUTEI-EXT
           END-IF 
      *
      *    ファイルクリア
           MOVE    SPA-TERMID          TO  FILE-TERMID
           MOVE    ZERO                TO  IF-RESULT
           MOVE    FILE-NAME1          TO  IF-FILENAME
           CALL    "orcfiledel"        USING
                                       ORCSFDELAREA
           MOVE    1                   TO  FLG-END2
      *
           MOVE    SPA-C01-MOTOPG      TO  SPA-SAKIPG
           MOVE    "C05"               TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-C01KYOUTU 
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       WRK-CONS-BYOMEICD-MAX
               MOVE    SPA-GMN-TBYOMEICD1 (IDX)
                                       TO  SPA-C01-TBYOMEICD (IDX) 
           END-PERFORM
           MOVE    SPA-GMN-HENBYO      TO  SPA-C01-BYOMEI
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   SPA-SAKIPG           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       450-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       41011-BYOKEN-HEN-SEC        SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR
      *
           INITIALIZE                      SPA-GMN-BYOMEI-TBL
                                           SPA-NAI-BYOMEI-TBL
           MOVE    ZERO                TO  SPA-GMN-BYOMEI-MAX
           MOVE    ZERO                TO  SPA-GMN-PAGE
                                           SPA-NAI-SELNO1
                                           SPA-GMN-SELNUM1
                                           SPA-GMN-NEXT
      *
           MOVE    C05-BYOMEIKEN          TO  SPA-GMN-BYOKEN
      *
           IF      SPA-GMN-BYOKEN      =   SPACE
               MOVE    3                   TO  SPA-GMN-CUR
               GO  TO  41011-BYOKEN-HEN-EXT
           END-IF 
      *
           MOVE    ZERO                TO  IDX
      *
      *    半角チェック
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI 
           MOVE    SPA-GMN-BYOKEN      TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
           AND     KANACHK-SYUBETU     =   "2"
               CONTINUE
           ELSE
               MOVE    "0071"              TO  SPA-ERRCD
               GO  TO  41011-BYOKEN-HEN-EXT
           END-IF
      *
           MOVE    1               TO  SPA-GMN-PAGE
           PERFORM 410112-BYOMEI-LST-SEC
      *
      *    選択番号へカーソルを移動させる
           IF      SPA-GMN-BYOMEI-MAX  >   ZERO
               MOVE    2               TO  SPA-GMN-CUR
           END-IF
           .
       41011-BYOKEN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名一覧編集処理
      *****************************************************************
       410112-BYOMEI-LST-SEC           SECTION.
      *      
           INITIALIZE                  BYOMEI-REC
           MOVE    SPA-GMN-BYOKEN      TO  BYO-BYOMEI
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "BYOMEI-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "BYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-SEC
           ELSE
               INITIALIZE                  BYOMEI-REC
               MOVE    1               TO  FLG-BYOMEI
           END-IF
      *
           COMPUTE WRK-STR         = ( SPA-GMN-PAGE  -  1 )
                                   *   WRK-CONS-BYOMEI-MAX
                                   +   1
      *
           MOVE    ZERO                TO  IDX
                                           IDX2
                                           SPA-GMN-MAX
           PERFORM     UNTIL     ( IDX         >   WRK-CONS-BYOMEI-MAX )
                       OR        ( FLG-BYOMEI  =   1                   )
      *
               ADD     1               TO  IDX2
               IF      IDX2            >=  WRK-STR
                   PERFORM 4101121-BYOMEI-HENSYU-SEC
               END-IF
      *
      *
               MOVE    "BYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "BYOMEI-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF    ( IDX                 >=  WRK-CONS-BYOMEI-MAX )  AND
                 ( FLG-BYOMEI          =   ZERO                )
               MOVE    1                   TO  SPA-GMN-NEXT
           ELSE
               MOVE    ZERO                TO  SPA-GMN-NEXT
           END-IF
      *
      *    選択番号へカーソルを移動させる
           MOVE    2               TO  SPA-GMN-CUR
           .
       410112-BYOMEI-LST-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名編集処理
      *****************************************************************
       4101121-BYOMEI-HENSYU-SEC            SECTION.
      *
           ADD     1               TO  IDX
      *
           IF      IDX             <=  WRK-CONS-BYOMEI-MAX
               MOVE    IDX2            TO  SPA-GMN-TBANGO  (IDX)
               MOVE    BYO-BYOMEICD    TO  SPA-GMN-TBYOCD  (IDX)
               MOVE    BYO-BYOMEI      TO  SPA-GMN-TBYOMEI (IDX)
               IF      BYO-IKOSAKICD   =   SPACE
                   CONTINUE
               ELSE
                   MOVE    "  ◎"          TO  SPA-GMN-TIKOSAKICD (IDX)
                   MOVE    BYO-IKOSAKICD   TO  SPA-NAI-TIKOSAKICD (IDX)
               END-IF
               IF      BYO-HAISIYMD    =   SPACE   OR  ALL "9"
                   CONTINUE
               ELSE
                   MOVE    BYO-HAISIYMD    TO  SPA-NAI-THAISIYMD (IDX)
                   MOVE    SPA-NAI-THAISIYMD (IDX)
                                           TO  WRK-SYMD
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG     TO  SPA-GMN-THAISIYMD (IDX)
                   MOVE    LNK-DAY2-EDTYMD3
                                           TO  SPA-NAI-THAISIYMDH(IDX)
               END-IF    
               IF      BYO-BYOMEICD(1:1)  =  "Z"
                   EVALUATE    BYO-BYOMEICD (4:1)
                       WHEN    "1"   THRU   "7"
                           MOVE    "接頭語"    TO  SPA-GMN-TSYUBET(IDX)
                       WHEN    "8"
                           MOVE    "接尾語"    TO  SPA-GMN-TSYUBET(IDX)
                       WHEN    "9"
                           MOVE    "歯科"      TO  SPA-GMN-TSYUBET(IDX)
                   END-EVALUATE
               END-IF
               MOVE    IDX             TO  SPA-GMN-BYOMEI-MAX
           END-IF
           .
       4101121-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択１処理
      *****************************************************************
       41012-SELNUM1-HEN-SEC        SECTION.
      *
           MOVE    2                    TO  SPA-GMN-CUR
      *
           MOVE    C05-SELNUM1          TO  SPA-GMN-SELNUM1
           MOVE    ZERO                 TO  SPA-NAI-SELNO2
      *
           IF      SPA-GMN-SELNUM1     =   ZERO
               MOVE    2                   TO  SPA-GMN-CUR
               GO  TO  41012-SELNUM1-HEN-EXT
           END-IF
      *
           COMPUTE WRK-BANGO       =   SPA-GMN-SELNUM1
                                   - ( SPA-GMN-PAGE    -   1 )
                                       *   WRK-CONS-BYOMEI-MAX
      *
      *    選択番号チェック
           IF    ( WRK-BANGO       >   WRK-CONS-BYOMEI-MAX )
           OR    ( WRK-BANGO       <   1                   )
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  41012-SELNUM1-HEN-EXT
           END-IF
      *
           MOVE    WRK-BANGO       TO  SPA-NAI-SELNO1
      *     
           PERFORM 410121-SELNUM1-CHK-SEC     
           .
       41012-SELNUM1-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号１チェック処理
      *****************************************************************
       410121-SELNUM1-CHK-SEC        SECTION.
      *
      *    選択数合計チェック
           IF      SPA-GMN-BYOMEICD-MAX
                                   =   WRK-CONS-BYOMEICD-MAX
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  410121-SELNUM1-CHK-EXT
           END-IF
           ADD     1               TO  SPA-GMN-BYOMEICD-MAX
      *
      *  
           MOVE    SPA-GMN-TBYOCD (SPA-NAI-SELNO1)    TO
                              SPA-GMN-TBYOMEICD1 (SPA-GMN-BYOMEICD-MAX)
           MOVE    SPA-GMN-TBYOMEI (SPA-NAI-SELNO1)   TO
                              SPA-GMN-TBYOMEI1   (SPA-GMN-BYOMEICD-MAX)
      *
           IF      SPA-NAI-TIKOSAKICD (SPA-NAI-SELNO1)
                               NOT =   SPACE
               MOVE    SPA-NAI-TIKOSAKICD (SPA-NAI-SELNO1)
                                       TO  BYO-BYOMEICD
               PERFORM 900-BYOMEI-INV-SEC
               IF      FLG-BYOMEI          =   ZERO
                   MOVE    SPA-GMN-TBYOMEICD1 (SPA-GMN-BYOMEICD-MAX)
                                           TO  SPA-C05-IKOMOTO-BYOMEICD
                   MOVE    SPA-GMN-TBYOMEI1   (SPA-GMN-BYOMEICD-MAX)
                                           TO  SPA-C05-IKOMOTO-BYOMEI
                   MOVE    SPA-NAI-TIKOSAKICD (SPA-NAI-SELNO1)
                                           TO  SPA-C05-IKOSAKI-BYOMEICD
                   MOVE    BYO-BYOMEI      TO  SPA-C05-IKOSAKI-BYOMEI
                   MOVE    SPA-GMN-BYOMEICD-MAX
                                           TO  SPA-C05-IKOSAKI-INDEX                    
                   MOVE    "0101"      TO  SPA-CIDCD2
                   GO  TO  410121-SELNUM1-CHK-EXT
               END-IF
           END-IF
      *
           IF      SPA-GMN-THAISIYMD (SPA-NAI-SELNO1)
                                   =   SPACE
               MOVE    SPACE           TO  WRK-HAISIYMDH
           ELSE    
               MOVE    SPA-NAI-THAISIYMDH (SPA-NAI-SELNO1)
                                       TO  WRK-HAISIYMDH
               MOVE    "0075"              TO  SPA-ERRCD
           END-IF                            
      *
      *    編集病名変換処理
           PERFORM 410121-HENBYOMEI-SEC
      *
           PERFORM 420-CLEAR-SEC
      *
           IF      SPA-GMN-BYOMEICD-MAX  
                                   =   WRK-CONS-BYOMEICD-MAX
               MOVE    3               TO  SPA-GMN-CUR
           END-IF  
           .
       410121-SELNUM1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択２処理
      *****************************************************************
       41013-SELNUM2-HEN-SEC        SECTION.
      *
           MOVE    4                    TO  SPA-GMN-CUR
      *
           MOVE    C05-SELNUM2          TO  SPA-GMN-SELNUM2
           MOVE    ZERO                 TO  SPA-NAI-SELNO2
      *
      *    選択番号チェック
           IF    ( SPA-GMN-SELNUM2      =   ZERO                 )
           OR    ( SPA-GMN-SELNUM2      >   SPA-GMN-BYOMEICD-MAX )
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  41013-SELNUM2-HEN-EXT
           END-IF
      *
           MOVE    SPA-GMN-SELNUM2      TO  SPA-NAI-SELNO2
      *     
           .
       41013-SELNUM2-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    編集病名変換処理
      *****************************************************************
       410121-HENBYOMEI-SEC        SECTION.
      *
           INITIALIZE               ORCSBYOMEIAREA
           MOVE    "2"             TO  LNK-BYO-SYORI
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       WRK-CONS-BYOMEICD-MAX
                   OR      SPA-GMN-TBYOMEICD1 (IDX)  
                                       =   SPACE 
               MOVE    SPA-GMN-TBYOMEICD1 (IDX)
                                      TO  LNK-BYO-TBYOMEICD (IDX)
           END-PERFORM
           CALL    "ORCSBYOMEI"     USING    ORCSBYOMEIAREA
      *
      *    病名編集
           MOVE    LNK-BYO-BYOMEI      TO  SPA-GMN-HENBYO
      *
      *    接尾語・接頭語チェック
           IF      LNK-BYO-BYOMEICD-ERR    =   2   OR  3
               MOVE    "0003"          TO  SPA-ERRCD
           END-IF
      *
      *   入力病名コード数カウント
           IF      LNK-BYO-BYOMEICD-ERR    =   9
               MOVE    "0056"          TO  SPA-ERRCD
           END-IF
      *
           IF      LNK-BYO-KANACHK-ERR     =   2
               MOVE    "0004"          TO  SPA-ERRCD
           END-IF
           .
       410121-HENBYOMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41014-BYOMEICDSEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       WRK-CONS-BYOMEICD-MAX
               IF      C05-BYOMEICDLST-SELECT (IDX)    
                                           =   "T"
                   IF      IDX                 =   SPA-NAI-SELNO2
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNO
                       MOVE    WRK-CONS-BYOMEI-MAX     TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-SELNO2
           END-IF
      *
           MOVE    SPA-NAI-SELNO2      TO  SPA-GMN-SELNUM2
      *     
           .
       41015-BYOMEISEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41015-BYOMEISEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       WRK-CONS-BYOMEI-MAX
               IF      C05-SELECT (IDX)    =   "T"
                   IF      IDX             =   SPA-NAI-SELNO1
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNO
                       MOVE    WRK-CONS-BYOMEI-MAX     TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-SELNO1
           END-IF
      *
           MOVE    SPA-GMN-TBANGO (SPA-NAI-SELNO1)
                                       TO  SPA-GMN-SELNUM1
      *     
           PERFORM 410121-SELNUM1-CHK-SEC     
           .
       41015-BYOMEISEL-EXT.
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
           IF      SPA-CIDCD2      NOT =   SPACE
               PERFORM 530-CIDSET2-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "C05    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  C05
      *
           MOVE    SPA-GMN-HENBYO      TO  C05-EDITBYOMEI
           MOVE    SPA-GMN-BYOKEN      TO  C05-BYOMEIKEN
           MOVE    SPA-GMN-SELNUM1     TO  C05-SELNUM1
           MOVE    SPA-GMN-SELNUM2     TO  C05-SELNUM2
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       WRK-CONS-BYOMEI-MAX
                   OR          IDX     >       SPA-GMN-BYOMEI-MAX
               MOVE    SPA-GMN-TBANGO  (IDX)   TO  WRK-NUM
               MOVE    WRK-NUM                 TO  C05-TBANGO     (IDX)
               MOVE    SPA-GMN-TSYUBET   (IDX) TO  C05-TSYUBET    (IDX)
               MOVE    SPA-GMN-TBYOMEI   (IDX) TO  C05-TBYOMEI    (IDX)
               MOVE    SPA-GMN-TBYOCD    (IDX) TO  C05-TBYOCD     (IDX)
               MOVE    SPA-GMN-TIKOSAKICD(IDX) TO  C05-TIKOSAKICD (IDX)
               MOVE    SPA-GMN-THAISIYMD (IDX) TO  C05-THAISIYMD  (IDX) 
      *         
               IF      IDX             =   SPA-NAI-SELNO1
                   MOVE    "T"             TO  C05-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  C05-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-BYOMEI-MAX      TO  C05-COUNT
           MOVE    ZERO                    TO  C05-ROW
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-BYOMEICD-MAX
               MOVE    IDX                 TO  WRK-NUM
               MOVE    WRK-NUM (4:2)       TO  C05-TBANGO1     (IDX)
               MOVE    SPA-GMN-TBYOMEICD1 (IDX)
                                           TO  C05-TBYOMEICD1  (IDX)
               MOVE    SPA-GMN-TBYOMEI1   (IDX)
                                           TO  C05-TBYOMEI1    (IDX)
      *         
               IF      IDX             =   SPA-NAI-SELNO2
                   MOVE    "T"         TO  C05-BYOMEICDLST-SELECT (IDX)
               ELSE
                   MOVE    "F"         TO  C05-BYOMEICDLST-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-BYOMEICD-MAX
                                       TO  C05-BYOMEICDLST-COUNT
           MOVE    ZERO                TO  C05-BYOMEICDLST-ROW
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
                    MOVE  "BYOMEIKEN"    TO  MCP-WIDGET
                WHEN   2
                    MOVE  "SELNUM1"      TO  MCP-WIDGET
                WHEN   3
                    MOVE  "B12"          TO  MCP-WIDGET
                WHEN   4
                    MOVE  "SELNUM2"      TO  MCP-WIDGET
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
                   MOVE    "選択番号が有りません"  
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "病名コード選択が２２以上です"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "病名コード順がエラーです"
                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "病名が長すぎます"
                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象の病名が１００件以上あります"
                                       TO  SPA-ERRMSG
               WHEN    "0056"
                   MOVE    "複数病名の入力はできません"
                                       TO  SPA-ERRMSG
               WHEN    "0071"
                   MOVE    "全角入力して下さい"
                                       TO  SPA-ERRMSG
               WHEN    "0075"
                   MOVE    "選択された病名はマスター上で"
                                       TO  SPA-ERRMSG
                   MOVE    WRK-HAISIYMDH
                                       TO  SPA-ERRMSG (29:22)
                   MOVE    "で廃止の扱いとなっています。"
                                       TO  SPA-ERRMSG (51:)
           END-EVALUATE
      *
           MOVE    SPACE                TO  WRK-HAISIYMDH     
      *
           MOVE    SPACE                TO  CERR
           MOVE    SPA-ERRCD            TO  CERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  CERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "C05"                TO  SPA-MOTOPG
           MOVE    "CERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "CERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名移行確認画面表示処理
      *****************************************************************
       530-CIDSET2-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-CID2-FLG
      *
           EVALUATE    SPA-CIDCD2
               WHEN    "0101"
                   MOVE    "選択された病名はマスター上で移行"
                                       TO  WRK-CIDMSG
                   MOVE    "病名の扱いとなっています。"
                                       TO  WRK-CIDMSG (33:)
           END-EVALUATE
      *
           MOVE    SPACE               TO  CID2
           MOVE    WRK-CIDMSG          TO  CID2-MSG
           MOVE    SPA-C05-IKOMOTO-BYOMEICD
                                       TO  CID2-BYOMEICD1
           MOVE    SPA-C05-IKOMOTO-BYOMEI  
                                       TO  CID2-BYOMEI1
           MOVE    SPA-C05-IKOSAKI-BYOMEICD
                                       TO  CID2-BYOMEICD2
           MOVE    SPA-C05-IKOSAKI-BYOMEI
                                       TO  CID2-BYOMEI2
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "C05"               TO  SPA-MOTOPG
           MOVE    "CID2"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "CID2"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       530-CIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-INV-SEC         SECTION.
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-BYOMEI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-BYOMEI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-BYOMEI
               MOVE    MCPDATA-REC     TO  BYOMEI-REC
           ELSE
              MOVE    1               TO  FLG-BYOMEI
           END-IF
           .
       900-BYOMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *

