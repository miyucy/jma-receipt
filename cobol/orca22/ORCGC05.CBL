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
           03  FILE-TERMID         PIC X(16)   VALUE   SPACE.
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
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(01).
           03  IDX2                PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SELNO           PIC 9(04).
           03  WRK-NUM             PIC ZZZ9.
           03  WRK-BYOMEI          PIC X(200).
           03  WRK-SYSYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
      *         
           03  WRK-BYOCOD-AREA.
      *********05  WRK-TBYOCD       PIC X(05)   OCCURS   6.
               05  WRK-TBYOCD       PIC X(07)   OCCURS   6.
               05  WRK-TBYOMEI      PIC X(200)  OCCURS   6.
      *********05  WRK-TRECECD      PIC X(07)   OCCURS   6.
               05  WRK-RECECD-TBL.
                   07  WRK-RECECD  OCCURS  3
                                   PIC X(01).
      *     
           03  WRK-TANDOKU-AREA.
               05  WRK-TANDOKUKBN-BYOMEICD
                                   PIC X(07).
               05  WRK-TANDOKUKBN-BYOMEI
                                   PIC X(80).                    
               05  WRK-TANDOKUKBN-G.
                   07  WRK-TANDOKUKBN 
                                   PIC 9(02)    OCCURS  6.
      *     
           03  WRK-HAISIYMDH       PIC X(22).
      *     
           03  WRK-MOJISU          PIC 9(04).
           03  WRK-NAME            PIC X(15).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(09).
      *
           03  WRK-ERRMSG          PIC X(40).
       01  WRK-HEN-AREA.
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
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
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
           COPY    "CERR.INC".
           COPY    "CID1.INC".
           COPY    "CID2.INC".
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
           MOVE    SPA-COMMON      TO  SPA-AREA.
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
           PERFORM 1003-C05SPA-OUT-SEC
      *
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
      *    DISPLAY "*** ORCGC05    START  ***"
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "CERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      * 
           MOVE  SPACE  TO  LINKAREA
      *
      ***  MOVE  "NEW"      TO  MCP-PUTTYPE.
           MOVE  SPACE      TO  MCP-PUTTYPE.
           MOVE  "C05"      TO  MCP-WINDOW.
      *
           PERFORM  900-PUT-WINDOW.
      *
           MOVE  1          TO  FLG-END
          .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           PERFORM 310-SPASET-SEC
           .
       3OO-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE              SPA-C05
      *
           MOVE    SPA-WORK        TO  SPA-C01KYOUTU
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       6
                   OR      SPA-C01-TBYOMEICD(IDX)  =   SPACE
               MOVE    SPA-C01-TBYOMEICD (IDX) TO  SPA-GMN-BYOCD  (IDX)
               MOVE    SPA-C01-TBYOMEI  (IDX)  TO  SPA-NAI-BYOMEI (IDX)      
      *****    MOVE    SPA-C01-TRECECD   (IDX) TO  SPA-NAI-RECECD (IDX)
               MOVE    IDX                     TO  SPA-MAX-BYOCD2 
           END-PERFORM
      *    編集病名変換処理
           PERFORM 410121-HENBYOMEI-SEC 
      *
           IF      SPA-C01-BYOMEI      =   SPACE 
               MOVE    1               TO  SPA-GMN-CUR
                                           SPA-GMN-PAGE
           ELSE
               MOVE    SPA-C01-BYOMEI  TO  C05-BYOKEN    
               PERFORM 41011-BYOKEN-HEN-SEC
           END-IF    
           .
       310-SPASET-EXT.
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
      *    取消
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 420-SYOKYO-SEC
      *    前画面
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 430-MAEGMN-SEC
      *    次画面
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 440-ATOGMN-SEC
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
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 41012-SELNUM-HEN-SEC
      *
               WHEN    "ACTIVATE"      ALSO    "EDITSORTNUM"
                   PERFORM 41013-HENCD-HEN-SEC
      *
               WHEN    "ACTIVATE"      ALSO    "DELBYOMEICD"
                   PERFORM 41014-SYOBYO-HEN-SEC
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
      *****************************************************************
      *    消去　処理
      *****************************************************************
       420-SYOKYO-SEC             SECTION.
      *
           .
       420-SYOKYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       430-MAEGMN-SEC             SECTION.
      *
           .
       430-MAEGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       440-ATOGMN-SEC             SECTION.
      *
           .
       440-ATOGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確定　処理
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
           MOVE    SPA-C01-MOTOPG      TO  SPA-SAKIPG
           MOVE    "C05"               TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-C01KYOUTU 
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       6
               MOVE    SPA-GMN-BYOCD   (IDX) TO  SPA-C01-TBYOMEICD (IDX) 
           END-PERFORM
           MOVE    SPA-C01KYOUTU       TO  SPA-WORK
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
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       41011-BYOKEN-HEN-SEC        SECTION.
      *
           INITIALIZE                      SPA-GMN-BYOMEI-TBL
                                           SPA-NAI-BYOMEI-TBL
           MOVE    ZERO                TO  SPA-GMN-MAX
           MOVE    ZERO                TO  SPA-GMN-PAGE
      *
           MOVE    C05-BYOKEN          TO  SPA-GMN-BYOKEN
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
           PERFORM  UNTIL     (IDX             >   100 )   OR
                              (FLG-BYOMEI      =   1   )
               PERFORM 410112-BYOMEI-HENSYU-SEC
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
      *---- (01.00.01) LINE DEL START -----------------------------
      **     IF      IDX                 <   100                   
      *    かな検索
      **       INITIALIZE                  BYOMEI-REC
      **       MOVE    SPA-GMN-BYOKEN  TO  BYO-BYOMEIKANA
      **       MOVE    BYOMEI-REC          TO  MCPDATA-REC
      **       MOVE    "DBSELECT"          TO  MCP-FUNC
      **       MOVE    "BYOMEI-KEY3"        TO  ORC-DBPATH
      **     CALL    "ORCMCPSUB"          USING
      **                                 MCPAREA
      **                                 ORCMCPAREA
      **                                 MCPDATA-REC
      **      IF      MCP-RC              =   ZERO
      **          MOVE    "BYOMEI-KEY3"     TO  ORC-DBPATH
      **           PERFORM 900-BYOMEI-READ-SEC
      **       ELSE
      **           INITIALIZE                  BYOMEI-REC
      **           MOVE    1               TO  FLG-BYOMEI
      **       END-IF
      *
      **       PERFORM UNTIL      (IDX             >   100 )   OR
      **                          (FLG-BYOMEI      =   1   )
      **           PERFORM 410112-BYOMEI-HENSYU-SEC
      *
      **           MOVE    "BYOMEI-KEY3"     TO  ORC-DBPATH
      **           PERFORM 900-BYOMEI-READ-SEC
      **       END-PERFORM
      *
      **       MOVE    "DBCLOSE"           TO  MCP-FUNC
      **       MOVE    "BYOMEI-KEY3"       TO  ORC-DBPATH
      **     CALL    "ORCMCPSUB"          USING
      **                                 MCPAREA
      **                                 ORCMCPAREA
      **                                 MCPDATA-REC
      **   END-IF
      *---- (01.00.01) LINE DEL END -------------------------------
      *
           IF      IDX                     >   100
               MOVE    "0005"                  TO  SPA-ERRCD
           END-IF
      *  
           IF      SPA-GMN-MAX     >   ZERO
               COMPUTE SPA-GMN-PAGE    =  (SPA-GMN-MAX  -  1  )
                                       /   20
                                       +   1
           ELSE
               MOVE    1               TO  SPA-GMN-PAGE
           END-IF
      *        選択番号へカーソルを移動させる
           MOVE    2               TO  SPA-GMN-CUR
           .
       41011-BYOKEN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名編集処理
      *****************************************************************
       410112-BYOMEI-HENSYU-SEC            SECTION.
      *
           ADD     1               TO  IDX
      *
           IF      IDX             <=  100 
               MOVE    IDX             TO  SPA-GMN-TBANGO  (IDX)
               MOVE    BYO-BYOMEICD    TO  SPA-GMN-TBYOCD  (IDX)
               MOVE    BYO-BYOMEI      TO  SPA-GMN-TBYOMEI (IDX)
               IF      BYO-IKOSAKICD   =   SPACE
                   CONTINUE
               ELSE
                   MOVE    "　◎"          TO
                                           SPA-GMN-TIKOSAKICD (IDX)
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
      *********MOVE    BYO-RECECD (1)  TO  SPA-NAI-TRECECD (IDX)
      *********IF      BYO-BYOMEICD       >=  "90001"
      *********    EVALUATE    BYO-RECECD (01)
      *********        WHEN    "1000"   THRU   "7999"
      *********            MOVE    "接頭語"    TO  SPA-GMN-TSYUBET(IDX)
      *********        WHEN    "8000"   THRU   "8999"
      *********            MOVE    "接尾語"    TO  SPA-GMN-TSYUBET(IDX)
      *********        WHEN    OTHER
      *********            MOVE    "修飾語"    TO  SPA-GMN-TSYUBET(IDX)
      *********    END-EVALUATE
      *********END-IF
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
               MOVE    IDX             TO  SPA-GMN-MAX
           END-IF
           .
       410112-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択処理
      *****************************************************************
       41012-SELNUM-HEN-SEC        SECTION.
      *
           MOVE    2                    TO  SPA-GMN-CUR
      *
           MOVE    C05-SELNUM           TO  SPA-GMN-SELNUM
      *
      *    選択番号チェック
           IF      SPA-GMN-SELNUM      =   ZERO   OR
                                       >   SPA-GMN-MAX
               MOVE    "0001"          TO  SPA-ERRCD
               GO      TO      41012-SELNUM-HEN-EXT
           END-IF
      *
           MOVE    SPA-GMN-SELNUM      TO  SPA-NAI-SELNO
      *     
           PERFORM 410121-SELNUM-CHK-SEC     
           .
       41012-SELNUM-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号チェック処理
      *****************************************************************
       410121-SELNUM-CHK-SEC        SECTION.
      *
      *    選択数合計チェック
           IF      SPA-MAX-BYOCD2  =   6
               MOVE    "0002"          TO  SPA-ERRCD
               GO      TO      410121-SELNUM-CHK-EXT
           END-IF
           ADD     1               TO  SPA-MAX-BYOCD2
      *
      *  
           MOVE    SPA-GMN-TBYOCD (SPA-GMN-SELNUM)
                                   TO  SPA-GMN-BYOCD (SPA-MAX-BYOCD2)
           MOVE    SPA-GMN-TBYOMEI (SPA-GMN-SELNUM)
                                   TO  SPA-NAI-BYOMEI (SPA-MAX-BYOCD2)
      **** MOVE    SPA-NAI-TRECECD (SPA-GMN-SELNUM)
      ****                         TO  SPA-NAI-RECECD (SPA-MAX-BYOCD2)
      *
           IF      SPA-GMN-THAISIYMD (SPA-GMN-SELNUM)
                                   =   SPACE
               MOVE    SPACE           TO  WRK-HAISIYMDH
           ELSE    
               MOVE    SPA-NAI-THAISIYMDH (SPA-GMN-SELNUM)
                                       TO  WRK-HAISIYMDH
           END-IF                            
      *
      *    編集病名変換処理
           PERFORM 410121-HENBYOMEI-SEC
      *
           MOVE    SPACE           TO  SPA-GMN-BYOKEN
                                       SPA-GMN-BYOMEI-TBL
           MOVE    ZERO            TO  SPA-GMN-SELNUM
           MOVE    ZERO            TO  SPA-GMN-MAX
           MOVE    ZERO            TO  SPA-NAI-SELNO   
      *
           IF      SPA-ERRCD       NOT =   SPACE
               GO  TO  410121-SELNUM-CHK-EXT
           END-IF 
      * 
           IF      SPA-MAX-BYOCD2  =   6
               MOVE    3               TO  SPA-GMN-CUR
           ELSE  
               MOVE    1               TO  SPA-GMN-CUR
           END-IF  
      *
           IF      WRK-HAISIYMDH       =   SPACE
               CONTINUE
           ELSE
               MOVE    "0075"              TO  SPA-ERRCD
           END-IF                     
           .
       410121-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    編集病名変換処理
      *****************************************************************
       410121-HENBYOMEI-SEC        SECTION.
      *
           MOVE    SPACE           TO  SPA-ERRCD 
      *
      *    病名編集
           MOVE    SPACE           TO  WRK-BYOMEI
           STRING    SPA-NAI-BYOMEI (01)      DELIMITED  BY  SPACE
                     "　"                  DELIMITED  BY  SIZE
                     SPA-NAI-BYOMEI (02)      DELIMITED  BY  SPACE
                     "　"                  DELIMITED  BY  SIZE
                     SPA-NAI-BYOMEI (03)      DELIMITED  BY  SPACE
                     "　"                  DELIMITED  BY  SIZE
                     SPA-NAI-BYOMEI (04)      DELIMITED  BY  SPACE
                     "　"                  DELIMITED  BY  SIZE
                     SPA-NAI-BYOMEI (05)      DELIMITED  BY  SPACE
                     "　"                  DELIMITED  BY  SIZE
                     SPA-NAI-BYOMEI (06)      DELIMITED  BY  SPACE
                             INTO          WRK-BYOMEI
           END-STRING
           MOVE    WRK-BYOMEI          TO  SPA-GMN-HENBYO
      *
           MOVE    SPACE           TO  WRK-BYOMEI
           STRING    SPA-NAI-BYOMEI (01)      DELIMITED  BY  SPACE
                     SPA-NAI-BYOMEI (02)      DELIMITED  BY  SPACE
                     SPA-NAI-BYOMEI (03)      DELIMITED  BY  SPACE
                     SPA-NAI-BYOMEI (04)      DELIMITED  BY  SPACE
                     SPA-NAI-BYOMEI (05)      DELIMITED  BY  SPACE
                     SPA-NAI-BYOMEI (06)      DELIMITED  BY  SPACE
                             INTO          WRK-BYOMEI
           END-STRING
      * 
      *　　接尾語・接頭語チェック
           MOVE    SPACE                   TO  WRK-RECECD-TBL
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-BYOCD(IDX)  NOT =   SPACE 
                   EVALUATE    SPA-GMN-BYOCD(IDX)(1:3)
                                       ALSO    SPA-GMN-BYOCD(IDX)(4:1)
                       WHEN    "ZZZ"   ALSO    "1"  THRU    "7"
                           IF      WRK-RECECD (2)    NOT =   SPACE   OR
                                   WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0003"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (1)
                           END-IF            
                       WHEN    "ZZZ"   ALSO    "8"
                           IF       WRK-RECECD (2)        =   SPACE 
                               MOVE    "0003"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (3)
                           END-IF
                       WHEN    OTHER                 
                           IF      WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0003"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (2)
                           END-IF
                   END-EVALUATE
               END-IF
           END-PERFORM
           IF      SPA-ERRCD             NOT =   SPACE                                              
               GO  TO  410121-HENBYOMEI-HEN-EXT
           END-IF
      *
      *   入力病名コード数カウント
           MOVE    ZERO                TO  IDZ
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-BYOCD(IDX)
                                       NOT =   SPACE
               AND     SPA-GMN-BYOCD(IDX)(1:1)
                                       NOT =   "Z"                        
                   ADD     1               TO  IDZ
               END-IF
           END-PERFORM                                    
           IF     IDZ                    >   1
               MOVE    "0056"             TO  SPA-ERRCD
               GO  TO  410121-HENBYOMEI-HEN-EXT
           END-IF             
      *
      *    文字数チェック     
           MOVE    ZERO                TO  WRK-MOJISU
           PERFORM VARYING     IDX     FROM    100 BY  -1
                   UNTIL       IDX     <       1
               IF      WRK-BYOMEI(IDX:1)   NOT =   SPACE
                   MOVE    IDX                 TO  WRK-MOJISU 
                   MOVE    1                   TO  IDX
               END-IF  
           END-PERFORM
           IF      WRK-MOJISU              >   80
               MOVE    "0004"          TO  SPA-ERRCD
               GO  TO  410121-HENBYOMEI-HEN-EXT
           END-IF  
           .
       410121-HENBYOMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名順変更処理
      *****************************************************************
       41013-HENCD-HEN-SEC         SECTION.
      *
           MOVE    4                   TO  SPA-GMN-CUR           
      *
           MOVE    SPACE               TO  WRK-BYOCOD-AREA
           MOVE    ZERO                TO  IDX2
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
               IF      C05-HENCOD (IDX:1)    >=  "1"  AND  <= "6"
                   MOVE    C05-HENCOD(IDX:1) TO  IDX1
                   ADD     1                   TO  IDX2
                   MOVE    SPA-GMN-BYOCD(IDX1)
                                               TO  WRK-TBYOCD    (IDX2)
                   MOVE    SPA-NAI-BYOMEI (IDX1)
                                               TO  WRK-TBYOMEI   (IDX2)
      *************MOVE    SPA-NAI-RECECD (IDX1)
      *************                            TO  WRK-TRECECD   (IDX2)
                   MOVE    SPACE               TO  SPA-GMN-BYOCD (IDX1)
                   MOVE    SPACE               TO  SPA-NAI-BYOMEI(IDX1)
      *************MOVE    SPACE               TO  SPA-NAI-RECECD(IDX1)
               END-IF
           END-PERFORM
      *    残りの病名コードをワークへ保存する
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
               IF      SPA-GMN-BYOCD(IDX)    NOT =   SPACE
                   ADD     1                   TO  IDX2
                   MOVE    SPA-GMN-BYOCD(IDX)
                                               TO  WRK-TBYOCD  (IDX2)
                   MOVE    SPA-NAI-BYOMEI(IDX) TO  WRK-TBYOMEI (IDX2)
      *************MOVE    SPA-NAI-RECECD(IDX) TO  WRK-TRECECD (IDX2)
               END-IF
           END-PERFORM
      *    病名コード再編集処理
           PERFORM 410131-BYOCDSET-SEC
      *
           MOVE    1                       TO  SPA-GMN-CUR      
           .
       41013-HENCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コード再編集処理
      *****************************************************************
       410131-BYOCDSET-SEC          SECTION.
      *    スパ領域へ病名コードを編集
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
               MOVE    WRK-TBYOCD (IDX)     TO  SPA-GMN-BYOCD  (IDX)
               MOVE    WRK-TBYOMEI(IDX)     TO  SPA-NAI-BYOMEI (IDX)
      *********MOVE    WRK-TRECECD(IDX)     TO  SPA-NAI-RECECD (IDX)
           END-PERFORM
      *    編集病名変換処理
           PERFORM 410121-HENBYOMEI-SEC 
           .
       410131-BYOCDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コード削除
      *****************************************************************
       41014-SYOBYO-HEN-SEC        SECTION.
      *
           MOVE    5                       TO  SPA-GMN-CUR      
      *  
           MOVE    C05-SYOBYO          TO  SPA-NAI-SYOBYO
      *
           IF      SPA-NAI-SYOBYO    =   ZERO            OR  
                   SPA-NAI-SYOBYO    >   SPA-MAX-BYOCD2
               MOVE    "0001"                  TO  SPA-ERRCD
               GO      TO      41014-SYOBYO-HEN-EXT
           END-IF
      *
           MOVE    SPA-NAI-SYOBYO  TO  IDX1
           MOVE    SPACE           TO  SPA-GMN-BYOCD (IDX1)
           MOVE    SPACE           TO  SPA-NAI-BYOMEI(IDX1)
      *****MOVE    SPACE           TO  SPA-NAI-RECECD(IDX1)
      *    空白を詰める
           MOVE    SPACE               TO  WRK-BYOCOD-AREA
           MOVE    ZERO                TO  IDX2
                                           SPA-MAX-BYOCD2
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
               IF      SPA-GMN-BYOCD(IDX)    NOT =   SPACE
                   ADD     1               TO  IDX2
                   MOVE    SPA-GMN-BYOCD(IDX)
                                           TO  WRK-TBYOCD  (IDX2)
                   MOVE    SPA-NAI-BYOMEI(IDX)
                                           TO  WRK-TBYOMEI (IDX2)
      *************MOVE    SPA-NAI-RECECD(IDX)
      *************                        TO  WRK-TRECECD (IDX2)
                   MOVE    IDX2            TO  SPA-MAX-BYOCD2
               END-IF
           END-PERFORM
      *    病名コード再編集処理
           PERFORM 410131-BYOCDSET-SEC 
      *
           MOVE    1                       TO  SPA-GMN-CUR      
           .
       41014-SYOBYO-HEN-EXT.
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
                   UNTIL       IDX     >       100
               IF      C05-SELECT (IDX)    =   "T"
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
           MOVE    SPA-GMN-TBANGO (SPA-NAI-SELNO)
                                       TO  SPA-GMN-SELNUM
      *     
           PERFORM 410121-SELNUM-CHK-SEC     
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
           MOVE    SPA-GMN-HENBYO      TO  C05-HENBYO
           MOVE    SPA-GMN-BYOKEN      TO  C05-BYOKEN
           MOVE    SPA-GMN-SELNUM      TO  C05-SELNUM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       100  
                   OR          IDX     >       SPA-GMN-MAX
               MOVE    SPA-GMN-TBANGO  (IDX)   TO  WRK-NUM
               MOVE    WRK-NUM                 TO  C05-TBANGO (IDX)
               MOVE    SPA-GMN-TSYUBET (IDX)   TO  C05-TSYUBET(IDX)
               MOVE    SPA-GMN-TBYOMEI (IDX)   TO  C05-TBYOMEI(IDX)
               MOVE    SPA-GMN-TBYOCD (IDX)    TO  C05-TBYOCD (IDX)
               MOVE    SPA-GMN-TIKOSAKICD (IDX) TO  C05-TIKOSAKICD (IDX)
               MOVE    SPA-GMN-THAISIYMD (IDX)  TO  C05-THAISIYMD (IDX) 
      ****     MOVE    IDX                     TO  C05-COUNT
      *         
               IF      IDX             =   SPA-NAI-SELNO
                   MOVE    "T"             TO  C05-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  C05-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-MAX         TO  C05-COUNT
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
                   OR          SPA-GMN-BYOCD (IDX) = SPACE
               MOVE    SPA-GMN-BYOCD (IDX)   TO  C05-TBYOCD2(IDX)
           END-PERFORM
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
                    MOVE  "SELNUM"       TO  MCP-WIDGET
                WHEN   3
                    MOVE  "B12"          TO  MCP-WIDGET
                WHEN   4
                    MOVE  "EDITSORTNUM"  TO  MCP-WIDGET
                WHEN   5
                    MOVE  "DELBYOMEICD"  TO  MCP-WIDGET
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
                   MOVE    "病名コード選択が６以上です"
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
               WHEN    "0076"
                   STRING   WRK-TANDOKUKBN-BYOMEI  DELIMITED  BY  SPACE
                           "は単独使用禁止の病名です"
                                                   DELIMITED  BY  SIZE
                                                   INTO    SPA-ERRMSG 
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

