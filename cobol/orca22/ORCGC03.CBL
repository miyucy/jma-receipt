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
       PROGRAM-ID.             ORCGC03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 病名登録
      *  コンポーネント名  : 自院病名登録（Ｃ０３）
      *  管理者            : 
      *  01/12/11    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/12/19  修飾語コードの入力方法の変更    
      *                                     病名コード未入力のとき病名へ移動
      *  01.00.02    MCC-藤原     02/01/31  病名よりレセ電コードに変換
      *  01.00.03    MCC-藤原     02/02/05  コラムリスト４００に変更
      *  01.00.04    MCC-藤原     02/04/11  8002"の疑い"の病名コードのとき
      *                                     疑いフラグに１をセット
      *                                     病名コードに"//"入力の時病名検索へ
      *  01.00.05    MCC-森脇     02/04/25  リスト出力処理を追加
      *  01.00.06    MCC-藤原     02/05/08  半角チェック追加
      *  01.00.07    MCC-多々納   02/05/08  半角チェック時、半角空白を
      *                                     全角空白へ置換えの追加
      *  01.00.08    MCC-藤原     02/05/17  コラムリスト700に変更
      *  01.00.09    MCC-藤原     02/07/05  病名コード空白の時コードをつめる
      *  01.00.10    MCC-藤原     02/07/08  皮膚科特定疾患（３）をコンボから削除
      *  01.00.11    NACL-藤原     2/08/08  入力コードの重複チェックを
      *                                     入力時にも追加
      *
      *  01.01.01    NACL-藤原    02/08/20  新傷病名マスタ対応
      *  01.01.02    NACL-藤原    02/09/12  ディレクトリをサブプロへ
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
       01  SPA-DATA-REC            PIC X(30000).
      *
      *
       WORKING-STORAGE             SECTION.
      *
      * ＳＰＡパラメタデータ
       01  FILE-NAME1.
           03  FILLE               PIC X(18)   VALUE
                                               "/var/tmp/C03SPASCR".
           03  FILE-TERMID         PIC X(16)   VALUE   SPACE.
           03  FILLER              PIC X(04)   VALUE   ".TXT".
      *
       01  WRK-DATA-REC.
           03  WRK-DATA            PIC X(30000)
                                   OCCURS  10.
      * 
       01  SPA-SCR-REC.
           COPY    "CPC03SPASCR.INC".
      *   
           COPY    "ENUM-VALUE".
      *
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH". 
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
           03  FLG-BYOMEI          PIC 9(01).
           03  FLG-USERBYOMEI      PIC 9(01).
           03  FLG-SPASCR          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDW                 PIC 9(04).
           03  IDX1                PIC 9(04). 
           03  IDX2                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-CIDMSG          PIC X(100).
           03  WRK-NUM             PIC ZZ9.
           03  WRK-HENFLG          PIC 9(01).
           03  WRK-SELNO           PIC 9(03). 
           03  WRK-RENNUM          PIC 9(02).
           03  WRK-GMN-TBL         PIC X(1000).
           03  WRK-NAI-TBL         PIC X(1000). 
           03  WRK-WIDGET.
               05  WRK-WIDGET1     PIC X(09).
               05  WRK-WIDGET2     PIC 9(01).  
           03  WRK-LENGTH          PIC 9(02).
           03  WRK-BYOMEI-AREA.
               05  WRK-BYOMEI      PIC X(100).
               05  WRK-CHARTBYOMEI PIC X(100).
               05  WRK-UTAGAIFLG   PIC X(01).
               05  WRK-RECECD-TBL.
                   07  WRK-RECECD  OCCURS  3
                                   PIC X(01).
               05  WRK-MOJISU      PIC 9(02).
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
           03  WRK-BYOMEICD-KENSAKU-AREA.
               05  WRK-BYOMEICD    PIC X(07).
               05  WRK-IKOSAKICD   PIC X(07).
               05  WRK-HAISIYMD    PIC X(08).
               05  WRK-BYO-MAX     PIC 9(01).
               05  WRK-BYO-BYOMEICD-G.
                   07  WRK-BYO-BYOMEICD 
                                   PIC X(07)    OCCURS  3.
                   07  WRK-BYO-IKOSAKICD 
                                   PIC X(07)    OCCURS  3.
                   07  WRK-BYO-HAISIYMD 
                                   PIC X(08)    OCCURS  3.
      *                             
           03  WRK-DBPATH          PIC X(64).
      *     
           03  WRK-HAISIYMDH       PIC X(22).
      *
           03  WRK-SORT-TBL.
               05  WRK-SORT-BYOMEICD-G.
                   07  WRK-SORT-BYOMEICD    OCCURS  6
                                            PIC X(07).
               05  WRK-SORT-BYOMEI-TBL.
                   07  WRK-SORT-BYOMEI-G    OCCURS  6.  
                       09  WRK-SORT-BYOMEI  PIC X(50).
                       09  WRK-SORT-UTAGAIFLG
                                           PIC X(01).
                       09  WRK-SORT-TOKSKNCD 
                                           PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
       01  WRK-TBL-MAX             PIC 9(03)   VALUE   700.
      *    未コード化傷病名コード
       01  WRK-CONS-BYOMEICD       PIC X(07)   VALUE   "0000999".                                     
      *    の疑い
       01  WRK-CONS-UTAGAI         PIC X(07)   VALUE   "ZZZ8002".                                     
      *
       01  WRK-HEN-AREA.
           03  WRK-NENGO           PIC X(04).
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *   印刷用呼出SHELL
       01  SHELL-AREA.
           03  SHELL-NAME          PIC X(27)   VALUE
               "scripts/allways/orhcml09.sh".
           03  SHELL-TERMID        PIC X(32).
           03  SHELL-SYSYMD        PIC X(8).
           03  SHELL-HOSPID        PIC X(24).   
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *    自院病名マスタ−
       01  USERBYOMEI-REC.
           COPY    "CPUSERBYOMEI.INC".
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
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
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
      *****COPY    "MCPAREA.INC".
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
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
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-C01KYOUTU
           MOVE    SPA-FREE        TO  SPA-C02FREE
      *
      *    画面ＳＰＡ読み込み
           PERFORM 1002-C03SPA-SET-SEC
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
           PERFORM 1003-C03SPA-OUT-SEC
      *
           MOVE    SPA-C01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-C02FREE     TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    ＳＰＡデータセット処理
      *****************************************************************
      *
       1002-C03SPA-SET-SEC             SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID
      *
           OPEN    INPUT               SPASCR-FILE
           IF      STS-SPASCR     NOT =   ZERO
               GO      TO         1002-C03SPA-SET-EXT
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
       1002-C03SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    ＳＰＡデータＷＲＩＴＥ処理
      *****************************************************************
       1003-C03SPA-OUT-SEC             SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID
      *
           OPEN    OUTPUT              SPASCR-FILE
           IF      STS-SPASCR     NOT =   ZERO
               DISPLAY "C03SPASCR OUT OPEN ERR:"   STS-SPASCR
               GO  TO  1003-C03SPA-SET-EXT
      ***         STOP    " "
           END-IF
           MOVE    SPACE              TO         WRK-DATA-REC
      *
           MOVE    SPA-SCR-REC        TO  WRK-DATA-REC 
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL      (IDX     >   10  )  OR
                              (WRK-DATA (IDX)     =   SPACE)
      *
               MOVE    WRK-DATA (IDX)      TO  SPA-DATA-REC
               WRITE                       SPA-DATA-REC
               IF      STS-SPASCR     NOT =   ZERO
                   DISPLAY "C03SPASCR OUT WRITE ERR:"   STS-SPASCR
                   GO  TO  1003-C03SPA-SET-EXT
      ***          STOP    " "
                END-IF
           END-PERFORM
      *
           CLOSE                       SPASCR-FILE
           .
       1003-C03SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
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
               IF      FLG-END             =   1
                   GO      TO      100-INIT-EXT
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
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "C03    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           MOVE    SPA-WORK        TO  SPA-C01KYOUTU
      *
           EVALUATE    TRUE
      *            病名検索より
               WHEN    SPA-MOTOPG(1:3)  =  "C05"
                   PERFORM 320-C04SPASET-SEC
                   MOVE    12              TO  SPA-GMN-CUR
                   GO      TO      300-SCREEN-EXT
      *            確認画面より
               WHEN    SPA-MOTOPG(1:4)  =  "CID1"
                   PERFORM 330-CID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
      *            病名移行確認画面より
               WHEN    SPA-MOTOPG(1:4)  =  "CID2"
                   PERFORM 340-CID2-SET-SEC
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
      *     確認画面よりの処理
      *****************************************************************
       330-CID1-SET-SEC                  SECTION.
      *
           EVALUATE    CID1-ID1CODE
               WHEN    "0101"
      *            戻るの確認
                   IF      SPA-CID1-FLG        =   "OK"
                       MOVE    1                   TO  SPA-GMN-CUR
                       MOVE    SPACE               TO  SPA-C03-UPDFLG
                       PERFORM 210-BACK
                   ELSE
                       MOVE    1                   TO  SPA-GMN-CUR
                   END-IF
      *
               WHEN    "0102"
      *            印刷の確認
                   IF      SPA-CID1-FLG        =   "OK"
                       MOVE    1                   TO  SPA-GMN-CUR
                       PERFORM 470-PRINT-SEC
                   ELSE
                       MOVE    1                   TO  SPA-GMN-CUR
                   END-IF
      * 
           END-EVALUATE
           .
       330-CID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *     病名移行確認画面よりの処理
      *****************************************************************
       340-CID2-SET-SEC                  SECTION.
      *
           EVALUATE    SPA-CIDCD2
               WHEN    "0101"
                   IF      SPA-CID2-FLG    =   "OK"
                       MOVE    SPA-C03-IKOSAKI-INDEX
                                           TO  IDZ
                       MOVE    SPA-C03-IKOSAKI-BYOMEICD
                                           TO  SPA-GMN-BYOMEICD(IDZ)
                       MOVE    SPA-GMN-BYOMEICD(IDZ)
                                           TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                   END-IF
                   PERFORM 4101111-BYOMEI-SELECT-HENSYU-SEC              
                   PERFORM 41021-BYOMEI-HENSYU-SEC
               WHEN    "0103"
                   IF      SPA-CID2-FLG    =   "OK"
                       MOVE    SPA-C03-IKOSAKI-INDEX
                                           TO  IDZ
                       MOVE    SPA-C03-IKOSAKI-BYOMEICD
                                           TO  SPA-GMN-BYOMEICD(IDZ)
                       MOVE    SPA-GMN-BYOMEICD(IDZ)
                                           TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                   END-IF
                   PERFORM 41021-BYOMEICD-HENSYU-SEC
               WHEN    "0105"
                   IF      SPA-CID2-FLG    =   "OK"
                       MOVE    SPA-C03-IKOSAKI-INDEX
                                           TO  IDZ
                       MOVE    SPA-C03-IKOSAKI-BYOMEICD
                                           TO  SPA-GMN-BYOMEICD(IDZ)
                       MOVE    SPA-GMN-BYOMEICD(IDZ)
                                           TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                   END-IF
                   PERFORM 41021-BYOMEICD-HENSYU-SEC
           END-EVALUATE
      *     
           MOVE    SPACE           TO  SPA-CIDCD2
           .
       340-CID2-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE                  SPA-C03-AREA
      *
      *    疑い
           MOVE    "1"             TO  SPA-GMN-UTAGAIFLGL       (1)
           MOVE    "疑い"          TO  SPA-GMN-UTAGAIFLGMEIL    (1)
           MOVE    "2"             TO  SPA-GMN-UTAGAIFLGL       (2)
           MOVE    "急性"          TO  SPA-GMN-UTAGAIFLGMEIL    (2)
           MOVE    "3"             TO  SPA-GMN-UTAGAIFLGL       (3)
           MOVE    "急性かつ疑い"  TO  SPA-GMN-UTAGAIFLGMEIL    (3)
           MOVE    3               TO  SPA-GMN-UTAGAIFLG-MAX
      *
           MOVE    "03"            TO  SPA-GMN-MANSEIKBNL       (1)
           MOVE    "皮膚科特定疾患指導管理料(１)"
                                   TO  SPA-GMN-MANSEIKBNMEIL    (1)
           MOVE    "皮膚（１）"    TO  SPA-GMN-MANSEIKBNTANL    (1)
           MOVE    "04"            TO  SPA-GMN-MANSEIKBNL       (2)
           MOVE    "皮膚科特定疾患指導管理料(２)"
                                   TO  SPA-GMN-MANSEIKBNMEIL    (2)
           MOVE    "皮膚（２）"    TO  SPA-GMN-MANSEIKBNTANL    (2)
           MOVE    "05"            TO  SPA-GMN-MANSEIKBNL       (3)
           MOVE    "特定疾患療養指導料／老人慢性疾患生活指導料"
                                   TO  SPA-GMN-MANSEIKBNMEIL    (3)
           MOVE    "老人"          TO  SPA-GMN-MANSEIKBNTANL    (3)
      *****MOVE    "07"            TO  SPA-GMN-MANSEIKBNL       (4)
      *    MOVE    "皮膚科特定疾患指導管理料(３)"
      *                            TO  SPA-GMN-MANSEIKBNMEIL    (4)
      *    MOVE    "皮膚（３）"    TO  SPA-GMN-MANSEIKBNTANL    (4)
      *****MOVE    4               TO  SPA-GMN-MANSEIKBN-MAX
           MOVE    3               TO  SPA-GMN-MANSEIKBN-MAX
      *
           MOVE    "1"             TO  SPA-GMN-HKNBYOMEIFLGL    (1)
           MOVE    "保険病名"      TO  SPA-GMN-HKNBYOMEIFLGMEIL (1)
           MOVE    1               TO  SPA-GMN-HKNBYOMEIFLG-MAX
      *
      *    分類一覧
           PERFORM 3102-BUNRUI-LST-SEC
      *
      *    自院病名一覧
           PERFORM 3101-USERBYOMEI-LST-SEC
      *
           MOVE    1                   TO  SPA-GMN-CUR
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    分類一覧 編集処理
      *****************************************************************
       3102-BUNRUI-LST-SEC         SECTION.
      *
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDY
      *
      *    分類コード ’Ｃ’のもの
           INITIALIZE                  USERBYOMEI-REC
           MOVE    SPA-HOSPID          TO  USBYO-HOSPID
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           ELSE
               INITIALIZE                  USERBYOMEI-REC
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           PERFORM UNTIL       (FLG-USERBYOMEI   =   1    )  OR
                               (IDX              >=  100  )
      *
               ADD     1                   TO  IDX
               IF      USBYO-BYOMEIINPUTCD NOT =   SPACE
                   MOVE    USBYO-BYOMEIINPUTCD(1:3)
                                           TO  SPA-GMN-BBUNRUICD(IDX)
               END-IF                            
               MOVE    USBYO-BYOMEI        TO  SPA-GMN-BBUNRUIMEI(IDX)
      *
               MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           END-PERFORM
      *
           MOVE    IDX                 TO  SPA-GMN-BUNRUI-MAX
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       3102-BUNRUI-LST-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名一覧 編集処理
      *****************************************************************
       3101-USERBYOMEI-LST-SEC         SECTION.
      *
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDY
      *
      *    分類コード ’Ａ’，’Ｊ’のもの
           INITIALIZE                  USERBYOMEI-REC
           MOVE    SPA-HOSPID          TO  USBYO-HOSPID
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY3"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "USERBYOMEI-KEY3"   TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           ELSE
               INITIALIZE                  USERBYOMEI-REC
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           PERFORM UNTIL       (FLG-USERBYOMEI   =   1            )  OR
                               (IDX              >=  WRK-TBL-MAX  )
      *
               ADD     1               TO  IDX
               PERFORM 31011-USERBYOMEI-SPA-SEC
      *
               MOVE    "USERBYOMEI-KEY3"   TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           END-PERFORM
      *
           MOVE    IDX                 TO  SPA-GMN-MAX
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY3"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       3101-USERBYOMEI-LST-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名マスター情報 編集処理
      *****************************************************************
       31011-USERBYOMEI-SPA-SEC     SECTION.
      *
           MOVE    IDX                 TO  SPA-NAI-TRENNUM (IDX)
                                           SPA-GMN-TBANGO  (IDX)
      *コード種別
           MOVE    USBYO-CDSYU         TO  SPA-NAI-TCDSYU (IDX)
      *病名入力コード
           MOVE    USBYO-BYOMEIINPUTCD TO  SPA-GMN-TBYOMEIINPUTCD (IDX)
      *分類コード
           MOVE    USBYO-BUNRUICD      TO  SPA-NAI-TBUNRUICD (IDX)
      *表示連番
           MOVE    USBYO-DSPSEQ        TO  SPA-GMN-TDSPSEQ   (IDX)
      *病名コード数
           MOVE    USBYO-BYOMEICDSU    TO  SPA-NAI-TBYOMEICDSU (IDX)
      *病名コード
           MOVE    USBYO-BYOMEICD-G    TO  SPA-NAI-TBYOMEICD-G (IDX)
      *疑いフラグ
           MOVE    USBYO-UTAGAIFLG     TO  SPA-NAI-TUTAGAIFLG (IDX)
      *慢性区分
           MOVE    USBYO-MANSEIKBN     TO  SPA-NAI-TMANSEIKBN (IDX)
      *病名
           MOVE    USBYO-BYOMEI        TO  SPA-GMN-TBYOMEI     (IDX)
      *病名
           MOVE    USBYO-BYOMEIMOJI    TO  SPA-NAI-TBYOMEIMOJI (IDX)
      *カルテ病名
           MOVE    USBYO-CHARTBYOMEI   TO  SPA-GMN-TCHARTBYOMEI (IDX)
      *カルテ病名
           MOVE    USBYO-CHARTBYOMEIMOJI
                                   TO  SPA-NAI-TCHARTBYOMEIMOJI (IDX)
      *病名編集フラグ
           MOVE    USBYO-BYOMEIHENFLG  TO  SPA-NAI-TBYOMEIHENFLG(IDX)
      *保険病名フラグ
           MOVE    USBYO-HKNBYOMEIFLG  TO  SPA-NAI-THKNBYOMEIFLG(IDX)
      *
      *    分類名
           IF      USBYO-BUNRUICD  NOT =   SPACE
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   SPA-GMN-BUNRUI-MAX
                   IF      SPA-GMN-BBUNRUICD(IDY)  =   USBYO-BUNRUICD
                       MOVE    SPA-GMN-BBUNRUIMEI(IDY)
                                           TO  SPA-GMN-TBUNRUIMEI(IDX)
                       MOVE    SPA-GMN-BUNRUI-MAX  TO  IDY
                   END-IF
               END-PERFORM
           END-IF
      *
      *    疑いフラグ
           IF      USBYO-UTAGAIFLG  NOT =   SPACE
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   SPA-GMN-UTAGAIFLG-MAX
                   IF      SPA-GMN-UTAGAIFLGLST(IDY)(1:1)
                                               =   USBYO-UTAGAIFLG
                       MOVE    SPA-GMN-UTAGAIFLGLST(IDY)(3:)
                                           TO  SPA-GMN-TUTAGAIFLG (IDX)
                       MOVE    SPA-GMN-UTAGAIFLG-MAX  TO  IDY
                   END-IF
               END-PERFORM
           END-IF
      *
      *    慢性
           IF      USBYO-MANSEIKBN  NOT =   SPACE
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   SPA-GMN-MANSEIKBN-MAX
                   IF      SPA-GMN-MANSEIKBNLST(IDY)(1:2)
                                               =   USBYO-MANSEIKBN
                       MOVE    SPA-GMN-MANSEIKBNTANL(IDY)
                                           TO  SPA-GMN-TMANSEIKBN (IDX)
                       MOVE    SPA-GMN-MANSEIKBN-MAX   TO  IDY
                   END-IF
               END-PERFORM
           END-IF
      *
      *    保険病名フラグ
           IF      USBYO-HKNBYOMEIFLG  =   "1"
               MOVE    "保険病名"      TO  SPA-GMN-THKNBYOMEIFLG (IDX)
           END-IF
      *
           .
       31011-USERBYOMEI-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名セット処理
      *****************************************************************
       320-C04SPASET-SEC          SECTION.
      *
           IF      SPA-C01KYOUTU       =   SPACE
               GO  TO  320-C04SPASET-EXT
           END-IF
      *   
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       6      
               MOVE    SPA-C01-TBYOMEICD (IDZ)
                                       TO  SPA-GMN-BYOMEICD(IDZ)
               MOVE    SPA-GMN-BYOMEICD (IDZ)
                                           TO  BYO-BYOMEICD
               PERFORM 410111-BYOMEI-HENSYU-SEC
           END-PERFORM
      *
           PERFORM 41021-BYOMEI-HENSYU-SEC
      *
           MOVE    9                   TO  SPA-GMN-CUR     
           .
       320-C04SPASET-EXT.
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
                   MOVE    "CHANGE"    TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *    クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 410-CLEAR-SEC
      *    病名検索へ
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 600-C05-SYORI-SEC
      *    追加
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 420-TUIKA-SEC
      *    変更
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 430-HENKOU-SEC
      *    削除
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 440-SAKUJYO-SEC
      *    リスト
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 460-LIST-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-TOUROKU-SEC
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
               WHEN    "ACTIVATE"      ALSO    "BANGO"
                   PERFORM 41001-BANGO-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BYOMEIINPUTCD"
                   PERFORM 41002-BYOMEIINPUT-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BUNRUICD"
                   PERFORM 41003-BUNRUICD-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BUNRUIMEI"
                   PERFORM 41004-BUNRUIMEI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_1"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_2"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_3"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_4"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_5"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_6"
                   PERFORM 4102-BYOMEI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BYOMEI"
                   PERFORM 41013-BYOMEI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "CHARTBYOMEI"
                   PERFORM 41022-CHARTBYOMEI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "UTAGAIFLG"
                   PERFORM 4104-UTAGAI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "MANSEIFLG"
                   PERFORM 4106-MANSEI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNBYOMEIFLG"
                   PERFORM 41014-HKNBYOMEIFLG-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "DSPSEQ"
                   PERFORM 41010-DSPSEQ-CHK-SEC
      *        病名行選択
               WHEN    ANY             ALSO    "BYOMEILST"
                   PERFORM 41020-BYOMEISEL-SEC
      *        分類選択
               WHEN    ANY             ALSO    "BUNRUILST"
                   PERFORM 41021-BUNRUILST-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名番号選択処理
      *****************************************************************
       41001-BANGO-CHK-SEC            SECTION.
      *
           MOVE    1                  TO  SPA-GMN-CUR
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
                                       SPA-NAI-KOUMOKU
                                       SPA-NAI-SELNO 
      *
           MOVE    C03-BANGO           TO  SPA-GMN-BANGO
      *
           IF      SPA-GMN-BANGO       =   ZERO
               IF      SPA-GMN-MAX         =   WRK-TBL-MAX
                   MOVE    "0034"              TO  SPA-ERRCD
               ELSE
                   MOVE    2                   TO  SPA-GMN-CUR
               END-IF
               GO  TO  41001-BANGO-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-BANGO       >   SPA-GMN-MAX
               MOVE    "0012"          TO  SPA-ERRCD
               GO      TO      41001-BANGO-CHK-EXT
           END-IF
      *
           PERFORM 410111-BYOMEI-SELECT-SEC
      *
           .
       41001-BANGO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択病名編集処理
      *****************************************************************
       410111-BYOMEI-SELECT-SEC         SECTION.
      *
           MOVE    SPACE               TO  WRK-HAISIYMDH
      *      
           MOVE    SPA-NAI-TBUNRUICD (SPA-GMN-BANGO)
                                   TO SPA-GMN-BUNRUICD
      *
           MOVE    SPA-GMN-TBUNRUIMEI(SPA-GMN-BANGO)
                                   TO  SPA-GMN-BUNRUIMEI
      *
           MOVE    SPA-GMN-TBYOMEIINPUTCD (SPA-GMN-BANGO)
                                   TO  SPA-GMN-BYOMEIINPUTCD                                                          
      *
           PERFORM VARYING IDZ     FROM    1   BY  1
                   UNTIL   IDZ     >       6 
               MOVE    SPA-NAI-TBYOMEICD (SPA-GMN-BANGO IDZ)
                                   TO  SPA-GMN-BYOMEICD(IDZ)
               MOVE    SPA-GMN-BYOMEICD (IDZ)
                                   TO  BYO-BYOMEICD
               PERFORM 410111-BYOMEI-HENSYU-SEC
               IF      FLG-BYOMEI          =   ZERO
                   IF      BYO-BYOMEICD (1:1)  NOT =   "Z"
                   AND     SPA-NAI-TBYOMEIHENFLG (SPA-GMN-BANGO)
                                                   =   SPACE
                       IF      BYO-IKOSAKICD       =   SPACE
                         IF      BYO-HAISIYMD        =   ALL "9"
                                                     OR  SPACE
                           CONTINUE
                         ELSE
                           MOVE    BYO-HAISIYMD    TO  WRK-SYMD
                           PERFORM 5002-HIZUKE-HEN-SEC
                           MOVE    LNK-DAY2-EDTYMD3
                                                   TO  WRK-HAISIYMDH
                         END-IF        
                       ELSE
                         MOVE    BYO-IKOSAKICD   TO  BYO-BYOMEICD
                         MOVE    ZERO            TO  FLG-BYOMEI
                         PERFORM 900-BYOMEI-READ-SEC
                         IF      FLG-BYOMEI          =   ZERO
                           MOVE    SPA-GMN-BYOMEICD (IDZ)
                                                   TO
                                               SPA-C03-IKOMOTO-BYOMEICD
                           MOVE    SPA-NAI-BYOMEI   (IDZ)
                                                   TO
                                               SPA-C03-IKOMOTO-BYOMEI
                           MOVE    BYO-BYOMEICD    TO
                                               SPA-C03-IKOSAKI-BYOMEICD
                           MOVE    BYO-BYOMEI      TO
                                               SPA-C03-IKOSAKI-BYOMEI
                           MOVE    IDZ       TO  SPA-C03-IKOSAKI-INDEX                  
                           MOVE    "0101"    TO  SPA-CIDCD2
                         END-IF    
                       END-IF
                   END-IF
               END-IF                
           END-PERFORM
      *
           IF      SPA-CIDCD2      NOT   =   SPACE
               GO  TO  410111-BYOMEI-SELECT-EXT
           END-IF
      *
           PERFORM 4101111-BYOMEI-SELECT-HENSYU-SEC              
      *
           IF      WRK-HAISIYMDH       =   SPACE
               CONTINUE
           ELSE
               MOVE    "0075"              TO  SPA-ERRCD
           END-IF                     
           .
       410111-BYOMEI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *   入力病名コード数カウント処理
      *****************************************************************
       4101111-BYOMEI-SELECT-HENSYU-SEC      SECTION.
      *      
      *      
           MOVE    SPA-GMN-TBYOMEI       (SPA-GMN-BANGO)
                                       TO  SPA-GMN-BYOMEI
      *      
           MOVE    SPA-GMN-TCHARTBYOMEI  (SPA-GMN-BANGO)
                                       TO  SPA-GMN-CHARTBYOMEI
      *                                 
           MOVE    SPA-NAI-TBYOMEIHENFLG (SPA-GMN-BANGO)
                                       TO  SPA-NAI-BYOMEIHENFLG
           IF      SPA-NAI-BYOMEIHENFLG  =   "1" 
               MOVE    "病名編集"      TO  SPA-GMN-BYOMEIHENFLG
           END-IF    
      *                                 
           MOVE    SPA-NAI-TBYOMEIMOJI   (SPA-GMN-BANGO)
                                       TO  SPA-NAI-BYOMEIMOJI
      *
           MOVE    SPA-NAI-TUTAGAIFLG (SPA-GMN-BANGO)
                                       TO  SPA-GMN-UTAGAIFLG
           MOVE    SPA-GMN-TUTAGAIFLG (SPA-GMN-BANGO)
                                       TO  SPA-GMN-UTAGAIFLGMEI
      *                                 
           IF      SPA-NAI-TMANSEIKBN (SPA-GMN-BANGO)
                                       NOT =   ZERO
               MOVE    SPA-NAI-TMANSEIKBN (SPA-GMN-BANGO)
                                           TO  SPA-GMN-MANSEIKBN
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-MANSEIKBN-MAX
                   IF      SPA-GMN-MANSEIKBN 
                                  =   SPA-GMN-MANSEIKBNL (IDY)
                       MOVE    SPA-GMN-MANSEIKBNLST (IDY)
                                          TO  SPA-GMN-MANSEIKBN-G
                   END-IF
               END-PERFORM
           END-IF
      *                                 
           MOVE    SPA-NAI-THKNBYOMEIFLG (SPA-GMN-BANGO)
                                        TO  SPA-GMN-HKNBYOMEIFLG 
           MOVE    SPA-GMN-THKNBYOMEIFLG (SPA-GMN-BANGO)
                                        TO  SPA-GMN-HKNBYOMEIFLGMEI
      *
           MOVE    SPA-GMN-TDSPSEQ (SPA-GMN-BANGO)
                                       TO  SPA-GMN-DSPSEQ
      *
           MOVE    SPA-NAI-TCDSYU (SPA-GMN-BANGO)
                                       TO  SPA-NAI-CDSYU
      *
           MOVE    3                   TO  SPA-GMN-CUR 
      *
           .
       4101111-BYOMEI-SELECT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスタ編集処理
      *****************************************************************
       410111-BYOMEI-HENSYU-SEC          SECTION.
      *
           INITIALIZE                    SPA-NAI-BYOMEI-G(IDZ)
      *
           MOVE    ZERO                  TO  FLG-BYOMEI
      *  
           IF      BYO-BYOMEICD      NOT =   SPACE             
               PERFORM 900-BYOMEI-READ-SEC
      *
               IF      FLG-BYOMEI        =   ZERO
                   IF      BYO-BYOMEICD  =   WRK-CONS-BYOMEICD
                       MOVE    SPACE         TO  SPA-NAI-BYOMEI (IDZ)
                   ELSE                           
                       MOVE    BYO-BYOMEI    TO  SPA-NAI-BYOMEI (IDZ)
                   END-IF    
                   MOVE    BYO-UTAGAIFLG TO  SPA-NAI-UTAGAIFLG(IDZ)
                   IF      BYO-BYOMEICD  =   WRK-CONS-UTAGAI
                       MOVE    "1"       TO  SPA-NAI-UTAGAIFLG(IDZ)
                   END-IF    
                   MOVE    BYO-TOKSKNCD  TO  SPA-NAI-TOKSKNCD (IDZ)
               ELSE
                   MOVE    "■■■"      TO  SPA-NAI-BYOMEI   (IDZ)
               END-IF
           END-IF 
           .
       410111-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コードチェック処理
      *****************************************************************
       4102-BYOMEI-CHK-SEC          SECTION.
      *
           MOVE    4               TO  SPA-GMN-CUR
      *
           MOVE    SPACE           TO  WRK-HAISIYMDH     
      *
           MOVE    MCP-WIDGET      TO  WRK-WIDGET
           MOVE    WRK-WIDGET2     TO  IDZ
      *
           COMPUTE SPA-GMN-CUR     =   SPA-GMN-CUR    +   IDZ
      *
      *    病名検索へ
           IF      C03-BYOMEICD (IDZ)(1:2) =   "//"
               PERFORM 600-C05-SYORI-SEC
               GO  TO  4102-BYOMEI-CHK-EXT
           END-IF     
      *
      *    未コード化傷病名入力のとき
           IF      C03-BYOMEICD (IDZ)
                                   =   WRK-CONS-BYOMEICD
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       6
                   IF      SPA-GMN-BYOMEICD (IDX)
                                          NOT =  SPACE
                   AND     IDX            NOT =   IDZ                       
                       MOVE    "0062"      TO  SPA-ERRCD
                       MOVE    6           TO  IDX
                   END-IF
               END-PERFORM                                    
           ELSE
      *        未コード化傷病名が既に入力のとき
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       6
                   IF      SPA-GMN-BYOMEICD(IDX)
                                       =   WRK-CONS-BYOMEICD
                       MOVE    "0063"      TO  SPA-ERRCD
                   END-IF
               END-PERFORM                                    
           END-IF
      *             
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE    SPA-GMN-BYOMEICD (IDZ)
                                   TO  C03-BYOMEICD (IDZ)
               GO  TO  4102-BYOMEI-CHK-EXT
           END-IF
      *
           INITIALIZE          SPA-NAI-BYOMEI-G (IDZ)
      *
           MOVE    C03-BYOMEICD (IDZ)  TO  SPA-GMN-BYOMEICD(IDZ)
      *
           IF      SPA-GMN-BYOMEICD(IDZ)(1:1)
                                       =   "."
               MOVE    "ZZZ"           TO  SPA-GMN-BYOMEICD(IDZ)(1:3)
               MOVE    C03-BYOMEICD(IDZ)(2:)
                                       TO  SPA-GMN-BYOMEICD(IDZ)(4:) 
           END-IF                                                       
      *
           MOVE    ZERO                TO  WRK-LENGTH                    
           PERFORM VARYING IDX FROM    7   BY  -1
                   UNTIL   IDX <       1
               IF      SPA-GMN-BYOMEICD(IDZ)(IDX:1)
                                   NOT =   SPACE
                   MOVE    IDX             TO  WRK-LENGTH
                   MOVE    1               TO  IDX
               END-IF
           END-PERFORM
      *
      *     空白の時コードをずらす
           IF      WRK-LENGTH          =   ZERO         
               PERFORM VARYING IDX FROM    IDZ BY  1
                       UNTIL   IDX >       6
                   IF      IDX             =   6
                       INITIALIZE          SPA-NAI-BYOMEI-G (IDX)
                                           SPA-GMN-BYOMEICD (IDX)
                   ELSE
                       COMPUTE IDW     =   IDX     +   1
                       MOVE    SPA-NAI-BYOMEI-G (IDW)
                                       TO  SPA-NAI-BYOMEI-G (IDX)
                       MOVE    SPA-GMN-BYOMEICD (IDW)
                                       TO  SPA-GMN-BYOMEICD (IDX)
                   END-IF                     
               END-PERFORM
           ELSE    
      *        病名マスタ読み込み
               MOVE    SPA-GMN-BYOMEICD (IDZ) TO  BYO-BYOMEICD
               PERFORM 410111-BYOMEI-HENSYU-SEC
               IF      FLG-BYOMEI       NOT =   ZERO
                   MOVE    "1000"           TO  SPA-ERRCD
               ELSE
                   IF      BYO-IKOSAKICD       =   SPACE
                       IF      BYO-HAISIYMD        =   ALL "9"
                                                   OR  SPACE
                           CONTINUE
                       ELSE
                           MOVE    BYO-HAISIYMD    TO  WRK-SYMD
                           PERFORM 5002-HIZUKE-HEN-SEC
                           MOVE    LNK-DAY2-EDTYMD3
                                                   TO  WRK-HAISIYMDH
                       END-IF        
                   ELSE
                       MOVE    BYO-IKOSAKICD   TO  BYO-BYOMEICD
                       MOVE    ZERO                  TO  FLG-BYOMEI
                       PERFORM 900-BYOMEI-READ-SEC
                       IF      FLG-BYOMEI          =   ZERO
                           MOVE    SPA-GMN-BYOMEICD (IDZ)
                                                   TO
                                               SPA-C03-IKOMOTO-BYOMEICD
                           MOVE    SPA-NAI-BYOMEI   (IDZ)
                                                   TO
                                               SPA-C03-IKOMOTO-BYOMEI
                           MOVE    BYO-BYOMEICD    TO
                                               SPA-C03-IKOSAKI-BYOMEICD
                           MOVE    BYO-BYOMEI      TO
                                               SPA-C03-IKOSAKI-BYOMEI
                           MOVE    IDZ         TO  SPA-C03-IKOSAKI-INDEX                    
                           MOVE    "0103"      TO  SPA-CIDCD2
                           GO  TO  4102-BYOMEI-CHK-EXT
                       END-IF    
                   END-IF        
               END-IF
           END-IF                               
      *
           PERFORM 41021-BYOMEICD-HENSYU-SEC
           .
       4102-BYOMEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コード編集処理
      *****************************************************************
       41021-BYOMEICD-HENSYU-SEC      SECTION.
      *
      *    病名編集処理
           PERFORM 41021-BYOMEI-HENSYU-SEC
      *
           IF      SPA-ERRCD           NOT =   SPACE     
               GO  TO  4102-BYOMEI-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-BYOMEICD (IDZ)  =   SPACE                                    
               MOVE    11                  TO  SPA-GMN-CUR
           ELSE
               IF      SPA-GMN-CUR         =   5
               AND     SPA-GMN-BYOMEICD-G  =   SPACE
                   MOVE    11                  TO  SPA-GMN-CUR
               ELSE                                   
                   IF      SPA-GMN-CUR         =   5
                   AND     SPA-GMN-BYOMEICD(1) =   WRK-CONS-BYOMEICD
                       MOVE    11                  TO  SPA-GMN-CUR
                   ELSE
                       IF      WRK-LENGTH          =   ZERO
                           CONTINUE
                       ELSE    
                           ADD     1                   TO  SPA-GMN-CUR
                       END-IF    
                   END-IF
               END-IF    
           END-IF      
      *
           IF      WRK-HAISIYMDH       =   SPACE
               CONTINUE
           ELSE
               MOVE    "0075"              TO  SPA-ERRCD
           END-IF                     
           .
       41021-BYOMEICD-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コード編集チェック処理
      *****************************************************************
       41021-BYOMEI-HENSYU-SEC        SECTION.
      *
      *    未コード化傷病名のとき
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6 
               IF      SPA-GMN-BYOMEICD (IDX)
                                       =   WRK-CONS-BYOMEICD
                   GO  TO  41021-BYOMEI-HENSYU-EXT
               END-IF
           END-PERFORM                                
      *
           MOVE    ZERO                TO  SPA-NAI-BYOMEIMOJI
      *　　病名編集
           MOVE    SPACE               TO  WRK-BYOMEI
           STRING  SPA-NAI-BYOMEI (1) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (2) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (3) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (4) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (5) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (6) DELIMITED  BY  SPACE
                              INTO          WRK-BYOMEI
           END-STRING
           MOVE    WRK-BYOMEI          TO  SPA-GMN-BYOMEI
      *
      *    疑いフラグ編集
           MOVE    SPACE               TO  SPA-GMN-UTAGAIFLG-G 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
                   OR      SPA-GMN-UTAGAIFLG   =   "3"
               EVALUATE    SPA-NAI-UTAGAIFLG   (IDX)
                   WHEN    "1"
                       IF      SPA-GMN-UTAGAIFLG   =   "2"
                           MOVE    "3"     TO  SPA-GMN-UTAGAIFLG
                        ELSE
                           MOVE    SPA-NAI-UTAGAIFLG(IDX)
                                           TO  SPA-GMN-UTAGAIFLG
                        END-IF    
                   WHEN    "2"
                       IF      SPA-GMN-UTAGAIFLG   =   "1"
                           MOVE    "3"     TO  SPA-GMN-UTAGAIFLG
                        ELSE
                           MOVE    SPA-NAI-UTAGAIFLG(IDX)
                                           TO  SPA-GMN-UTAGAIFLG
                       END-IF
                   WHEN    "3"
                       MOVE    "3"         TO  SPA-GMN-UTAGAIFLG
                END-EVALUATE
           END-PERFORM
           PERFORM 5001-UTAGAIFLG-HENSYU-SEC
      *            
      *    慢性区分編集
           MOVE    SPACE               TO  SPA-GMN-MANSEIKBN-G  
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-NAI-TOKSKNCD (IDX)   NOT =   ZERO
                   MOVE    SPA-NAI-TOKSKNCD (IDX)
                                           TO  SPA-GMN-MANSEIKBN
                   MOVE    6               TO  IDX
               END-IF   
           END-PERFORM
           PERFORM 5001-MANSEIKBN-HENSYU-SEC
      *
      *    病名コードエラーの時以下の処理はしない
           IF      SPA-ERRCD            NOT =   SPACE     
               GO  TO  41021-BYOMEI-HENSYU-EXT
           END-IF
      * 
      *　　接尾語・接頭語チェック
           MOVE    SPACE                   TO  WRK-RECECD-TBL
      * 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-BYOMEICD(IDX)     NOT =   SPACE 
                   EVALUATE    SPA-GMN-BYOMEICD(IDX)(1:1)
                               ALSO    SPA-GMN-BYOMEICD(IDX)(4:1)
                       WHEN    "Z"         ALSO    "1"  THRU    "7"
                           IF      WRK-RECECD (2)    NOT =   SPACE   OR
                                   WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (1)
                           END-IF            
                       WHEN    "Z"         ALSO    "8"  THRU    "8"
                           IF      WRK-RECECD (2)    =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (3)
                           END-IF
                       WHEN    OTHER                 
                           IF      WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (2)
                           END-IF
                   END-EVALUATE
               END-IF
           END-PERFORM
           IF      SPA-ERRCD             NOT =   SPACE
               GO  TO  41021-BYOMEI-HENSYU-EXT
           END-IF
      *
      *   入力病名コード数カウント
           MOVE    ZERO                TO  IDX1
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-BYOMEICD(IDX)
                                       NOT =   SPACE
               AND     SPA-GMN-BYOMEICD(IDX)(1:1)
                                       NOT =   "Z"                        
                   ADD     1               TO  IDX1
               END-IF
           END-PERFORM                                    
           IF     IDX1                    >   1
               MOVE    "0056"             TO  SPA-ERRCD
               GO  TO  41021-BYOMEI-HENSYU-EXT
           END-IF             
      *
      *    文字チェック     
           PERFORM VARYING     IDX     FROM    1   BY  2
                   UNTIL       IDX     >       100
                   OR  WRK-BYOMEI(IDX:2)       =   SPACE
               IF      WRK-BYOMEI(IDX:2)   =   "■"
                   MOVE    "0035"          TO  SPA-ERRCD
                   GO  TO  41021-BYOMEI-HENSYU-EXT
              END-IF
           END-PERFORM
      *
      *    文字数チェック     
           MOVE    ZERO                TO  WRK-MOJISU
           IF      WRK-RECECD (1)    NOT =   SPACE   AND
                   WRK-RECECD (2)        =   SPACE   AND
                   WRK-RECECD (3)        =   SPACE
               CONTINUE                
           ELSE
               PERFORM VARYING     IDX     FROM    100 BY  -1
                       UNTIL       IDX     <       1
                   IF      WRK-BYOMEI(IDX:1)   NOT =   SPACE
                       MOVE    IDX                 TO  WRK-MOJISU 
                       MOVE    1                   TO  IDX
                   END-IF  
               END-PERFORM
               IF      WRK-MOJISU              >   80
                   MOVE    "0007"          TO  SPA-ERRCD
                   GO  TO  41021-BYOMEI-HENSYU-EXT
               END-IF
           END-IF    
      *
      *    病名文字数編集
           COMPUTE WRK-MOJISU   =   WRK-MOJISU  /   2        
           MOVE    WRK-MOJISU          TO  SPA-NAI-BYOMEIMOJI
      *
      *    病名編集フラグセット
           MOVE    SPACE                   TO  SPA-GMN-BYOMEIHENFLG
                                               SPA-NAI-BYOMEIHENFLG
           .
       41021-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名入力コードチェック処理
      *****************************************************************
       41002-BYOMEIINPUT-CHK-SEC          SECTION.
      *
           MOVE    2                  TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-BANGO      >   ZERO
               IF      C03-BYOMEIINPUTCD  NOT =   SPA-GMN-BYOMEIINPUTCD
               AND     SPA-NAI-TRENNUM (SPA-GMN-BANGO)    >   ZERO
                   MOVE   "0050"              TO  SPA-ERRCD
                   GO  TO  41002-BYOMEIINPUT-CHK-EXT
               END-IF
           END-IF    
      *
      *    半角チェック
           IF      C03-BYOMEIINPUTCD   =   SPACE
               CONTINUE
           ELSE    
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    C03-BYOMEIINPUTCD   TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-RC2         =   ZERO
                   MOVE    KANACHK-OUT-INPUT   TO  C03-BYOMEIINPUTCD
      ************ CONTINUE
               ELSE
                   MOVE    "0072"              TO  SPA-ERRCD
                   GO  TO  41002-BYOMEIINPUT-CHK-EXT
               END-IF
           END-IF    
      *                  
           MOVE    C03-BYOMEIINPUTCD  TO  SPA-GMN-BYOMEIINPUTCD
      *
           MOVE    ZERO               TO  WRK-LENGTH
      *      
           PERFORM VARYING IDX FROM    10  BY  -1
                   UNTIL   IDX <       1
               IF      SPA-GMN-BYOMEIINPUTCD(IDX:1)
                                   NOT =   SPACE
                   MOVE    IDX             TO  WRK-LENGTH
                   MOVE    1               TO  IDX
               END-IF
           END-PERFORM                                    
           IF      WRK-LENGTH          =   7   OR  ZERO
               MOVE    "0009"              TO  SPA-ERRCD
           END-IF    
      *
           IF      SPA-ERRCD            NOT =   SPACE     
               GO  TO  41002-BYOMEIINPUT-CHK-EXT
           END-IF
      *
      *****IF      SPA-GMN-BYOMEIINPUTCD(1:1)
      *****                         >=  X"A1"
           IF      KANACHK-SYUBETU  =   "2"    
              MOVE    "J"               TO  SPA-NAI-CDSYU
           ELSE
              MOVE    "A"               TO  SPA-NAI-CDSYU
           END-IF           
      *
      *    
           IF      SPA-GMN-BANGO      =   ZERO
               COMPUTE IDY     =   SPA-GMN-MAX  +   1
               PERFORM 4202-INTBL-CHK-SEC
               IF      SPA-ERRCD            NOT =   SPACE     
                   GO  TO  41002-BYOMEIINPUT-CHK-EXT
               END-IF
           END-IF      
      *
           MOVE    3                   TO  SPA-GMN-CUR
           .
       41002-BYOMEIINPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    分類コードチェック処理
      *****************************************************************
       41003-BUNRUICD-CHK-SEC          SECTION.
      *
           MOVE    3                  TO  SPA-GMN-CUR
      *         
           MOVE    C03-BUNRUICD       TO  SPA-GMN-BUNRUICD
      *
           IF      SPA-GMN-BUNRUICD   =   SPACE
               MOVE    SPACE              TO  SPA-GMN-BUNRUIMEI
           ELSE
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-BUNRUI-MAX
                   IF      SPA-GMN-BUNRUICD
                                           =   SPA-GMN-BBUNRUICD (IDX)
                       MOVE    SPA-GMN-BBUNRUIMEI  (IDX)
                                               TO  SPA-GMN-BUNRUIMEI
                       MOVE    SPA-GMN-BUNRUI-MAX  
                                               TO  IDX
                   END-IF
               END-PERFORM
           END-IF    
      *
           ADD     1                       TO  SPA-GMN-CUR
           .
       41003-BUNRUICD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    分類名チェック処理
      *****************************************************************
       41004-BUNRUIMEI-CHK-SEC          SECTION.
      *
           MOVE    4                  TO  SPA-GMN-CUR
      *
           IF      C03-BUNRUIMEI      =   SPACE
               CONTINUE
           ELSE    
      *       半角チェック
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    C03-BUNRUIMEI       TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "2"
                   MOVE    KANACHK-OUT-INPUT   TO  C03-BUNRUIMEI
               ELSE
                   MOVE    "0071"              TO  SPA-ERRCD
                   GO  TO  41004-BUNRUIMEI-CHK-EXT
               END-IF
           END-IF
      *         
           MOVE    C03-BUNRUIMEI      TO  SPA-GMN-BUNRUIMEI
      *
           IF      SPA-ERRCD               =   SPACE         
               ADD     1                       TO  SPA-GMN-CUR
           END-IF    
           .
       41004-BUNRUIMEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    表示連番チェック処理
      *****************************************************************
       41010-DSPSEQ-CHK-SEC          SECTION.
      *
           MOVE    16                 TO  SPA-GMN-CUR
      *         
           MOVE    C03-DSPSEQ         TO  SPA-GMN-DSPSEQ
      *
           IF      SPA-GMN-DSPSEQ     =   ZERO
               MOVE    50                 TO  SPA-GMN-DSPSEQ
           END-IF              
      *
           MOVE    3                  TO  SPA-GMN-CUR
           .
       41010-DSPSEQ-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    疑い　入力処理
      *****************************************************************
       4104-UTAGAI-CHK-SEC                SECTION.
      *        
           MOVE    13                      TO  SPA-GMN-CUR
      *
           MOVE    SPA-GMN-UTAGAIFLG  TO  WRK-UTAGAIFLG 
           MOVE    C03-UTAGAIFLG          TO  SPA-GMN-UTAGAIFLG-G
      *
           IF      SPA-GMN-UTAGAIFLG  =   WRK-UTAGAIFLG
               MOVE    14                   TO  SPA-GMN-CUR
               GO  TO  4104-UTAGAI-CHK-EXT
           END-IF
      *
           PERFORM 5001-UTAGAIFLG-HENSYU-SEC
           IF      SPA-GMN-UTAGAIFLG =   SPACE
               CONTINUE
           ELSE
               IF      SPA-GMN-UTAGAIFLGMEI   =   SPACE    
                  MOVE    "0018"               TO  SPA-ERRCD
                  GO  TO  4104-UTAGAI-CHK-EXT
               END-IF
           END-IF    
      *        
           MOVE    14                   TO  SPA-GMN-CUR
           GO  TO  4104-UTAGAI-CHK-EXT
      *     
      *    以下の処理は中止         
      *    疑い・急性の病名コードの削除
           IF      SPA-GMN-UTAGAIFLG   =   "3"
               CONTINUE
           ELSE 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       6
                   IF      SPA-NAI-UTAGAIFLG   (IDX)   =   SPACE
                       CONTINUE
                   ELSE
                       EVALUATE    SPA-GMN-UTAGAIFLG
                           WHEN    "1"
                           WHEN    "2"
                               IF      SPA-NAI-UTAGAIFLG(IDX)
                                       NOT =   SPA-GMN-UTAGAIFLG
                                 INITIALIZE  SPA-NAI-BYOMEI-G(IDX)
                                 MOVE    SPACE       
                                         TO  SPA-GMN-BYOMEICD(IDX)
                               END-IF
                           WHEN    SPACE
                               INITIALIZE SPA-NAI-BYOMEI-G(IDX)
                               MOVE    SPACE
                                       TO  SPA-GMN-BYOMEICD(IDX) 
                       END-EVALUATE
                   END-IF 
               END-PERFORM
           END-IF 
      *
           INITIALIZE                   WRK-SORT-TBL
           MOVE    SPA-GMN-BYOMEICD-G  TO  WRK-SORT-BYOMEICD-G
           MOVE    SPA-NAI-BYOMEI-TBL  TO  WRK-SORT-BYOMEI-TBL
           INITIALIZE                          SPA-GMN-BYOMEICD-G
           INITIALIZE                          SPA-NAI-BYOMEI-TBL
           MOVE    ZERO                    TO  IDY     
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      WRK-SORT-BYOMEICD (IDX) =   SPACE
                   CONTINUE
               ELSE
                   ADD     1           TO  IDY
                   MOVE    WRK-SORT-BYOMEICD (IDX)
                                       TO  SPA-GMN-BYOMEICD (IDY)
                   MOVE    WRK-SORT-BYOMEI-G (IDX)
                                       TO  SPA-NAI-BYOMEI-G (IDY)
               END-IF
           END-PERFORM
      *
      *    病名編集
           MOVE    SPACE                    TO  WRK-BYOMEI
           STRING  SPA-NAI-BYOMEI (1) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (2) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (3) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (4) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (5) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (6) DELIMITED  BY  SPACE
                              INTO          WRK-BYOMEI
           END-STRING
           MOVE    WRK-BYOMEI               TO  SPA-GMN-BYOMEI
      *
      * 
      *　　接尾語・接頭語チェック
           MOVE    SPACE                   TO  WRK-RECECD-TBL
      * 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-BYOMEICD(IDX)     NOT =   SPACE 
                   EVALUATE    SPA-GMN-BYOMEICD(IDX)(1:1)
                               ALSO    SPA-GMN-BYOMEICD(IDX)(4:1)
                       WHEN    "Z"         ALSO    "1"  THRU    "7"
                           IF      WRK-RECECD (2)    NOT =   SPACE   OR
                                   WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (1)
                           END-IF            
                       WHEN    "Z"         ALSO    "8"  THRU    "8"
                           IF      WRK-RECECD (2)        =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (3)
                           END-IF
                       WHEN    OTHER                 
                           IF      WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (2)
                           END-IF
                   END-EVALUATE
               END-IF
           END-PERFORM
           IF      SPA-ERRCD             NOT =   SPACE
               GO  TO  4104-UTAGAI-CHK-EXT
           END-IF
      *
      *    文字数チェック     
           MOVE    ZERO                TO  WRK-MOJISU
           IF      WRK-RECECD (1)    NOT =   SPACE   AND
                   WRK-RECECD (2)        =   SPACE   AND
                   WRK-RECECD (3)        =   SPACE
               CONTINUE                
           ELSE
               PERFORM VARYING     IDX     FROM    100 BY  -1
                       UNTIL       IDX     <       1
                   IF      WRK-BYOMEI(IDX:1)   NOT =   SPACE
                       MOVE    IDX                 TO  WRK-MOJISU 
                       MOVE    1                   TO  IDX
                   END-IF  
               END-PERFORM
           END-IF
      *         
           COMPUTE WRK-MOJISU   =   WRK-MOJISU  /   2        
           MOVE    WRK-MOJISU          TO  SPA-NAI-BYOMEIMOJI
      *
      *    病名編集フラグセット
           MOVE    SPACE                   TO  SPA-GMN-BYOMEIHENFLG
                                               SPA-NAI-BYOMEIHENFLG
      *        
           MOVE    14                   TO  SPA-GMN-CUR
           .
       4104-UTAGAI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    慢性　入力処理
      *****************************************************************
       4106-MANSEI-CHK-SEC                SECTION.
      *   
           MOVE    14                   TO  SPA-GMN-CUR
      *
           MOVE    C03-MANSEIFLG        TO  SPA-GMN-MANSEIKBN-G
      *
           PERFORM 5001-MANSEIKBN-HENSYU-SEC
           IF      SPA-GMN-MANSEIKBN =   SPACE
               CONTINUE
           ELSE
               IF      SPA-GMN-MANSEIKBNMEI   =   SPACE    
                  MOVE    "0021"               TO  SPA-ERRCD
                  GO  TO  4106-MANSEI-CHK-EXT
               END-IF
           END-IF    
      *
      *
           IF      SPA-ERRCD              =   SPACE
               MOVE    15                   TO  SPA-GMN-CUR
           END-IF
           .
       4106-MANSEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名  入力処理
      *****************************************************************
       41013-BYOMEI-CHK-SEC             SECTION.
      *
           MOVE    11                   TO  SPA-GMN-CUR
      *
           MOVE    C03-BYOMEI           TO  SPA-GMN-BYOMEI
      *     
           MOVE    ZERO                 TO  SPA-NAI-BYOMEIMOJI
      *
           IF      SPA-GMN-BYOMEI       =   SPACE
               INITIALIZE                   SPA-GMN-BYOMEICD-G
                                            SPA-NAI-BYOMEI-TBL
               MOVE    SPACE            TO  SPA-NAI-BYOMEIHENFLG
                                            SPA-GMN-BYOMEIHENFLG
               MOVE    ZERO             TO  SPA-NAI-BYOMEIMOJI
               MOVE    ZERO             TO  SPA-NAI-BYOMEICD-MAX
               MOVE    12               TO  SPA-GMN-CUR
               GO  TO  41013-BYOMEI-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-BYOMEI (81:) NOT =   SPACE
               MOVE    "0007"              TO  SPA-ERRCD
               GO  TO  41013-BYOMEI-CHK-EXT
           END-IF
      *     
      *    半角チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI 
           MOVE    SPA-GMN-BYOMEI      TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
           AND     KANACHK-SYUBETU     =   "2"
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-BYOMEI
           ELSE
               MOVE    "0071"              TO  SPA-ERRCD
               GO  TO  41013-BYOMEI-CHK-EXT
           END-IF
      *     
      *    病名のみ入力のとき検索処理をする
      *    （病名コード未入力、または未コード化傷病名コードのとき）
           IF      SPA-GMN-BYOMEICD-G   =   SPACE
           OR      SPA-GMN-BYOMEICD (1) =   WRK-CONS-BYOMEICD
               MOVE    SPACE        TO  SPA-GMN-BYOMEICD-G
               PERFORM 410131-BYOMEI-KENSAKU-SEC
               IF      WRK-BYO-MAX      >   ZERO
                   MOVE    SPACE        TO  SPA-GMN-BYOMEICD-G
                   MOVE    ZERO         TO  IDZ
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       3
                       IF      WRK-BYO-BYOMEICD (IDX)
                                                   NOT =   SPACE
                           ADD     1           TO  IDZ
                           MOVE    WRK-BYO-BYOMEICD (IDX)
                                       TO  SPA-GMN-BYOMEICD (IDZ)
                           MOVE    SPA-GMN-BYOMEICD (IDZ)
                                       TO  BYO-BYOMEICD
                           PERFORM 410111-BYOMEI-HENSYU-SEC
      *                         
                           IF      SPA-GMN-BYOMEICD (IDZ)(1:1)
                                                       NOT =   "Z"     
                               IF      WRK-BYO-IKOSAKICD (IDX)
                                                           =   SPACE
                                   IF      WRK-BYO-HAISIYMD (IDX)
                                                           =   ALL "9"
                                                           OR  SPACE
                                       CONTINUE
                                   ELSE
                                       MOVE    WRK-BYO-HAISIYMD (IDX)
                                                   TO  WRK-SYMD
                                       PERFORM 5002-HIZUKE-HEN-SEC
                                       MOVE    LNK-DAY2-EDTYMD3
                                                   TO  WRK-HAISIYMDH
                                   END-IF        
                               ELSE                            
                                   MOVE    SPA-GMN-BYOMEICD (IDZ) 
                                           TO  SPA-C03-IKOMOTO-BYOMEICD
                                   MOVE    SPA-NAI-BYOMEI   (IDZ) 
                                           TO  SPA-C03-IKOMOTO-BYOMEI
                                   MOVE    WRK-BYO-IKOSAKICD (IDX)
                                           TO  BYO-BYOMEICD
                                   PERFORM 900-BYOMEI-READ-SEC
                                   IF      FLG-BYOMEI          =   ZERO
                                       MOVE    BYO-BYOMEICD    TO
                                               SPA-C03-IKOSAKI-BYOMEICD
                                       MOVE    BYO-BYOMEI      TO
                                               SPA-C03-IKOSAKI-BYOMEI
                                       MOVE    IDX             TO
                                               SPA-C03-IKOSAKI-INDEX                    
                                       MOVE    "0105"          TO
                                               SPA-CIDCD2
                                   END-IF
                               END-IF  
                           END-IF    
                       END-IF    
                   END-PERFORM
                   PERFORM 41021-BYOMEI-HENSYU-SEC
                   MOVE    12              TO  SPA-GMN-CUR
      *             
                   IF      SPA-CIDCD2          =   SPACE
                   AND     WRK-HAISIYMDH   NOT =   SPACE
                       MOVE    "0075"          TO  SPA-ERRCD
                   END-IF    
                   GO  TO  41013-BYOMEI-CHK-EXT
               END-IF    
           END-IF        
      *
      *    文字チェック     
           PERFORM VARYING     IDX     FROM    1   BY  2
                   UNTIL       IDX     >       80
                   OR  SPA-GMN-BYOMEI(IDX:2)   =   SPACE
               IF      SPA-GMN-BYOMEI(IDX:2)   =   "■"
                   MOVE    "0035"          TO  SPA-ERRCD 
                   GO  TO  41013-BYOMEI-CHK-EXT
              END-IF
           END-PERFORM
      *
      *    病名文字数編集
           MOVE    ZERO                TO  WRK-MOJISU
           PERFORM VARYING     IDX     FROM    80  BY  -1
                   UNTIL       IDX     <       1
               IF      SPA-GMN-BYOMEI(IDX:1)   NOT =   SPACE
                   MOVE    IDX                 TO  WRK-MOJISU 
                   MOVE    1                   TO  IDX
               END-IF  
           END-PERFORM
      *
           COMPUTE WRK-MOJISU   =   WRK-MOJISU  /   2        
           MOVE    WRK-MOJISU           TO  SPA-NAI-BYOMEIMOJI
      *
      *    病名編集フラグ編集
           MOVE    SPACE               TO  WRK-BYOMEI
           STRING  SPA-NAI-BYOMEI (1) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (2) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (3) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (4) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (5) DELIMITED  BY  SPACE
                   SPA-NAI-BYOMEI (6) DELIMITED  BY  SPACE
                              INTO          WRK-BYOMEI
           END-STRING
           IF      WRK-BYOMEI           NOT =   SPA-GMN-BYOMEI 
               MOVE    "1"              TO  SPA-NAI-BYOMEIHENFLG
               MOVE    " 病名編集"      TO  SPA-GMN-BYOMEIHENFLG
           ELSE
               MOVE    SPACE            TO  SPA-GMN-BYOMEIHENFLG
                                            SPA-NAI-BYOMEIHENFLG
           END-IF
      *
      *    病名のみ入力のときは未コード化傷病名コードをセット
           IF      SPA-GMN-BYOMEICD-G   =   SPACE
           AND     SPA-GMN-BYOMEI   NOT =   SPACE    
               MOVE    WRK-CONS-BYOMEICD    TO  SPA-GMN-BYOMEICD(1)
               MOVE    SPA-GMN-BYOMEICD (1) TO  BYO-BYOMEICD
               MOVE    1                    TO  IDZ
               PERFORM 410111-BYOMEI-HENSYU-SEC
           END-IF          
      *
           MOVE    12                   TO  SPA-GMN-CUR
           .
       41013-BYOMEI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       410131-BYOMEI-KENSAKU-SEC       SECTION.
      *         
      *    病名文字数編集
           MOVE    ZERO                TO  WRK-MOJISU
           PERFORM VARYING     IDX     FROM    80  BY  -1
                   UNTIL       IDX     <       1
               IF      SPA-GMN-BYOMEI(IDX:1)   NOT =   SPACE
                   MOVE    IDX                 TO  WRK-MOJISU 
                   MOVE    1                   TO  IDX
               END-IF  
           END-PERFORM
      *
           INITIALIZE                  WRK-BYOMEICD-KENSAKU-AREA
      *
      *    病名で検索
           MOVE    "BYOMEI-KEY4"       TO  WRK-DBPATH
           INITIALIZE                  BYOMEI-REC
           MOVE    SPA-GMN-BYOMEI  TO  BYO-BYOMEI
           PERFORM 410131-BYOKEN-HEN-SEC
           IF      IDX                 =   1
               MOVE    WRK-BYOMEICD        TO  WRK-BYO-BYOMEICD (1)
               MOVE    WRK-IKOSAKICD       TO  WRK-BYO-IKOSAKICD(1)
               MOVE    WRK-HAISIYMD        TO  WRK-BYO-HAISIYMD (1) 
               MOVE    1                   TO  WRK-BYO-MAX
               GO  TO  410131-BYOMEI-KENSAKU-EXT
           END-IF
      *
      *    接頭語の検索
           MOVE    1                   TO  IDZ
           PERFORM VARYING IDW FROM    8   BY  -2 
                   UNTIL   IDW <       1
               IF      IDW             >   WRK-MOJISU
                   CONTINUE
               ELSE
                   MOVE    "BYOMEI-KEY5"       TO  WRK-DBPATH
                   INITIALIZE                  BYOMEI-REC
                   MOVE    SPA-GMN-BYOMEI(1:IDW)  
                                               TO  BYO-BYOMEI
                   PERFORM 410131-BYOKEN-HEN-SEC
                   IF      IDX                 =   1
                       MOVE    WRK-BYOMEICD
                                           TO  WRK-BYO-BYOMEICD (1)
                       MOVE    WRK-IKOSAKICD
                                           TO  WRK-BYO-IKOSAKICD(1)
                       MOVE    WRK-HAISIYMD
                                           TO  WRK-BYO-HAISIYMD (1) 
                       MOVE    1           TO  WRK-BYO-MAX
                       COMPUTE IDZ     =   IDW     +   1
                       MOVE    2               TO  IDW
                   END-IF
               END-IF
           END-PERFORM
      *
      *    接頭語以降の病名で検索
           IF      IDZ                 >   1                 
               MOVE    "BYOMEI-KEY4"       TO  WRK-DBPATH
               INITIALIZE                  BYOMEI-REC
               MOVE    SPA-GMN-BYOMEI (IDZ:)
                                           TO  BYO-BYOMEI
               PERFORM 410131-BYOKEN-HEN-SEC
               IF      IDX                 =   1
                   MOVE    WRK-BYOMEICD    TO  WRK-BYO-BYOMEICD (2)
                   MOVE    WRK-IKOSAKICD   TO  WRK-BYO-IKOSAKICD(2)
                   MOVE    WRK-HAISIYMD    TO  WRK-BYO-HAISIYMD (2) 
                   ADD     1               TO  WRK-BYO-MAX
                   GO  TO  410131-BYOMEI-KENSAKU-EXT
               END-IF
           END-IF    
      *
      *    接尾語の確認
           COMPUTE IDW     =   WRK-MOJISU   -   5
           IF      SPA-GMN-BYOMEI (IDW:6)   =   "の疑い"
               ADD     1                   TO  WRK-BYO-MAX
               MOVE    "ZZZ8002"           TO
                                           WRK-BYO-BYOMEICD (3)
           ELSE    
               COMPUTE IDW     =   WRK-MOJISU   -   3
               IF      SPA-GMN-BYOMEI (IDW:4)   =   "疾患"
                   ADD     1               TO  WRK-BYO-MAX
                   MOVE    "ZZZ8010"       TO  
                                           WRK-BYO-BYOMEICD (3)
               ELSE    
                   COMPUTE IDW     =   WRK-MOJISU   -   1
                   IF      SPA-GMN-BYOMEI (IDW:2)   =   "症"
                       ADD     1           TO  WRK-BYO-MAX
                       MOVE    "ZZZ8011"   TO   
                                           WRK-BYO-BYOMEICD (3)
                   ELSE    
                       IF      SPA-GMN-BYOMEI (IDW:2)   =   "病"
                           ADD     1       TO  WRK-BYO-MAX
                           MOVE    "ZZZ8036"   TO 
                                           WRK-BYO-BYOMEICD (3)
                       ELSE
                           INITIALIZE      WRK-BYOMEICD-KENSAKU-AREA
                           GO  TO  410131-BYOMEI-KENSAKU-EXT
                       END-IF
                   END-IF
               END-IF        
           END-IF
      *
      *    接頭語・接尾語以外の病名がないとき             
           IF      IDW                 =   IDZ    
      ****     INITIALIZE                  WRK-BYOMEICD-KENSAKU-AREA
               GO  TO  410131-BYOMEI-KENSAKU-EXT
           END-IF
      *
      *    接頭語・接尾語以外の病名より検索             
           COMPUTE IDW     =   IDW     -   IDZ
           MOVE    "BYOMEI-KEY4"       TO  WRK-DBPATH
           INITIALIZE                  BYOMEI-REC
           MOVE    SPA-GMN-BYOMEI (IDZ:IDW)
                                       TO  BYO-BYOMEI
           PERFORM 410131-BYOKEN-HEN-SEC
           IF      IDX                 =   1
               MOVE    WRK-BYOMEICD    TO  WRK-BYO-BYOMEICD (2)
               MOVE    WRK-IKOSAKICD   TO  WRK-BYO-IKOSAKICD(2)
               MOVE    WRK-HAISIYMD    TO  WRK-BYO-HAISIYMD (2) 
               ADD     1               TO  WRK-BYO-MAX
               GO  TO  410131-BYOMEI-KENSAKU-EXT
           END-IF
      *
      *     
           INITIALIZE                  WRK-BYOMEICD-KENSAKU-AREA
           .
       410131-BYOMEI-KENSAKU-EXT.
           EXIT.
      *     
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       410131-BYOKEN-HEN-SEC        SECTION.
      * 
           MOVE    SPACE               TO  WRK-BYOMEICD
      *
           MOVE    ZERO                TO  IDX
      * 
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-DBPATH            TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-N-SEC
           ELSE
               INITIALIZE                  BYOMEI-REC
               MOVE    1               TO  FLG-BYOMEI
           END-IF
      *
           PERFORM  UNTIL     (IDX             >   1   )   OR
                              (FLG-BYOMEI      =   1   )
               ADD     1                   TO  IDX                
               IF      IDX                 =   1               
                   MOVE    BYO-BYOMEICD        TO  WRK-BYOMEICD
                   MOVE    BYO-IKOSAKICD       TO  WRK-IKOSAKICD
                   MOVE    BYO-HAISIYMD        TO  WRK-HAISIYMD
               ELSE
                   MOVE    SPACE               TO  WRK-BYOMEICD    
               END-IF
      *
               MOVE    WRK-DBPATH                TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-N-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-DBPATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       410131-BYOKEN-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    カルテ病名  入力処理
      *****************************************************************
       41022-CHARTBYOMEI-CHK-SEC             SECTION.
      *
           MOVE    12                   TO  SPA-GMN-CUR
      *
           MOVE    C03-CHARTBYOMEI      TO  SPA-GMN-CHARTBYOMEI
      *
           MOVE    ZERO                 TO  SPA-NAI-CHARTBYOMEIMOJI
      
      *    半角チェック
      *
           IF      SPA-GMN-CHARTBYOMEI  =   SPACE
               CONTINUE
           ELSE    
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-CHARTBYOMEI TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "2"
                   MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-CHARTBYOMEI
               ELSE
                   MOVE    "0071"              TO  SPA-ERRCD
                   GO  TO  41013-BYOMEI-CHK-EXT
               END-IF
           END-IF    
      *
      *    病名文字数編集
           MOVE    ZERO                TO  WRK-MOJISU
           PERFORM VARYING     IDX     FROM    80  BY  -1
                   UNTIL       IDX     <       1
               IF      SPA-GMN-CHARTBYOMEI(IDX:1)   NOT =   SPACE
                   MOVE    IDX                 TO  WRK-MOJISU 
                   MOVE    1                   TO  IDX
               END-IF  
           END-PERFORM
      *
           COMPUTE WRK-MOJISU   =   WRK-MOJISU  /   2        
           MOVE    WRK-MOJISU           TO  SPA-NAI-CHARTBYOMEIMOJI
      *
           MOVE    13                   TO  SPA-GMN-CUR
           .
       41013-BYOMEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険病名フラグ　入力処理
      *****************************************************************
       41014-HKNBYOMEIFLG-CHK-SEC                SECTION.
      *   
           MOVE    15                   TO  SPA-GMN-CUR
      *
           MOVE    C03-HKNBYOMEIFLG     TO  SPA-GMN-HKNBYOMEIFLG-G
      *
           IF      SPA-GMN-HKNBYOMEIFLG   =   SPACE
               CONTINUE
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-HKNBYOMEIFLG 
                               =   SPA-GMN-HKNBYOMEIFLGL (IDY)
                       MOVE    SPA-GMN-HKNBYOMEIFLGLST (IDY)
                                      TO  SPA-GMN-HKNBYOMEIFLG-G
                       MOVE    1      TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0028"               TO  SPA-ERRCD
                   GO  TO  41014-HKNBYOMEIFLG-CHK-EXT
               END-IF
           END-IF
      *     
           MOVE    16                   TO  SPA-GMN-CUR
           .
       41014-HKNBYOMEIFLG-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41020-BYOMEISEL-SEC       SECTION.
      *          
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
               IF      C03-BYOMEILST-SELECT (IDX)    =   "T"
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
           INITIALIZE                 SPA-GMN-KOUMOKU
                                      SPA-NAI-KOUMOKU
      *
           MOVE    SPA-GMN-TBANGO (SPA-NAI-SELNO)
                                       TO  SPA-GMN-BANGO
      *                                 
           PERFORM 410111-BYOMEI-SELECT-SEC     
           .
       41020-BYOMEISEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41021-BUNRUILST-SEC       SECTION.
      *          
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-BUNRUI-MAX
               IF      C03-BUNRUI-SELECT (IDX)    =   "T"
                   MOVE    IDX                  TO  WRK-SELNO
                   MOVE    SPA-GMN-BUNRUI-MAX   TO  IDX
               END-IF
           END-PERFORM
      *
           MOVE    SPA-GMN-BBUNRUICD (WRK-SELNO)
                                       TO  SPA-GMN-BUNRUICD
           MOVE    SPA-GMN-BBUNRUIMEI(WRK-SELNO)
                                       TO  SPA-GMN-BUNRUIMEI                           
           .
       41021-BUNRUISEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
           IF      SPA-C03-UPDFLG          =   "1"
               MOVE    "0101"          TO  SPA-CIDCD
               GO      TO      210-BACK-EXT
           END-IF
      *
           MOVE    "C02"               TO  SPA-SAKIPG
           MOVE    "C03"               TO  SPA-MOTOPG
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
      *    追加　処理
      *****************************************************************
       420-TUIKA-SEC                SECTION.
      *
           IF      SPA-GMN-BANGO  >   ZERO
               MOVE    "0005"              TO  SPA-ERRCD
               GO  TO  420-TUIKA-EXT
           END-IF
      *
           IF      SPA-GMN-MAX      =   WRK-TBL-MAX
               MOVE    "0034"               TO  SPA-ERRCD
               GO      TO      420-TUIKA-EXT
           END-IF
      *
           IF      SPA-GMN-BYOMEIINPUTCD  =   SPACE
               MOVE    "0049"               TO  SPA-ERRCD
               GO      TO      420-TUIKA-EXT
           END-IF
      *
           IF      SPA-NAI-BYOMEIMOJI   =   ZERO
               IF      SPA-GMN-BYOMEI       =   SPACE
                   MOVE    "0010"               TO  SPA-ERRCD
               ELSE    
                   MOVE    "0011"               TO  SPA-ERRCD
               END-IF    
               GO      TO      420-TUIKA-EXT
           END-IF
      *
           IF      SPA-GMN-CHARTBYOMEI  =   SPACE
               CONTINUE
           ELSE    
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-CHARTBYOMEI TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "2"
                   MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-CHARTBYOMEI
               ELSE
                   MOVE    "0071"              TO  SPA-ERRCD
                   MOVE    12                  TO  SPA-GMN-CUR
                   GO      TO      420-TUIKA-EXT
               END-IF
           END-IF    
      *
      *    単独病名チェック
           IF      SPA-NAI-BYOMEIHENFLG    =   SPACE
               INITIALIZE                  WRK-TANDOKU-AREA
      *            
               PERFORM VARYING IDZ FROM    1   BY  1
                       UNTIL   IDZ >       6    
                       OR      SPA-GMN-BYOMEICD(IDZ)
                                           =   SPACE
                   MOVE    SPA-GMN-BYOMEICD (IDZ)
                                           TO  BYO-BYOMEICD
                   PERFORM 900-BYOMEI-READ-SEC
                   MOVE    BYO-TANDOKUKBN  TO  WRK-TANDOKUKBN (IDZ)
               END-PERFORM
      *     
               MOVE    ZERO                TO  IDX
               PERFORM VARYING IDZ FROM    1   BY  1
                       UNTIL   IDZ >       6
                       OR      SPA-GMN-BYOMEICD (IDZ)  
                                       =   SPACE
                   IF      WRK-TANDOKUKBN (IDZ)    =   ZERO   
                       MOVE    1                   TO  IDX
                   ELSE
                       MOVE    SPA-GMN-BYOMEICD (IDZ)
                                           TO  WRK-TANDOKUKBN-BYOMEICD  
                       MOVE    SPA-NAI-BYOMEI   (IDZ)
                                           TO  WRK-TANDOKUKBN-BYOMEI  
                   END-IF   
               END-PERFORM
               IF      IDX                 =   ZERO
                   MOVE    "0076"              TO  SPA-ERRCD  
                   GO  TO  420-TUIKA-EXT
               END-IF
           END-IF    
      *
           COMPUTE IDY     =   SPA-GMN-MAX  +   1
           PERFORM 4202-INTBL-CHK-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  420-TUIKA-EXT
           END-IF
      *    
           ADD     1                TO  SPA-GMN-MAX
           MOVE    SPA-GMN-MAX      TO
                                SPA-GMN-TBANGO   (SPA-GMN-MAX)
      *
           MOVE    SPA-GMN-MAX          TO  IDX
           PERFORM 4201-INTBL-SET-SEC
      *
      *    診療開始日別に並び替え
      ***  PERFORM 4203-INTBL-SORT-SEC
      *     
      *     
           MOVE    1                TO  SPA-GMN-CUR  
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-C03-UPDFLG
      *
           .
       420-TUIKA-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目重複チェック処理
      *****************************************************************
       4202-INTBL-CHK-SEC                SECTION.
      *
           MOVE    SPACE                   TO  SPA-ERRCD
      * 
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       WRK-TBL-MAX
               IF      IDX         =   IDY 
                   CONTINUE
               ELSE
                   IF      SPA-GMN-TBYOMEIINPUTCD (IDX)
                                           =   SPA-GMN-BYOMEIINPUTCD
                       MOVE    "0002"              TO  SPA-ERRCD
                       MOVE    WRK-TBL-MAX         TO  IDX
                   END-IF
               END-IF
           END-PERFORM
           .                   
       4202-INTBL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目編集処理
      *****************************************************************
       4201-INTBL-SET-SEC                SECTION.
      *
           EVALUATE   MCP-WIDGET
               WHEN    "B06"
                   MOVE    1           TO  SPA-NAI-TUPDFLG (IDX)
               WHEN    "B07"
                   IF      SPA-NAI-TRENNUM (IDX)   =   ZERO
                       MOVE    1       TO  SPA-NAI-TUPDFLG (IDX)
                   ELSE
                       MOVE    2       TO  SPA-NAI-TUPDFLG (IDX)
                   END-IF
           END-EVALUATE
      *
           MOVE    SPA-GMN-BUNRUICD TO  SPA-NAI-TBUNRUICD (IDX)
           MOVE    SPA-GMN-BUNRUIMEI
                                    TO  SPA-GMN-TBUNRUIMEI(IDX)
           MOVE    SPA-GMN-BYOMEIINPUTCD
                                    TO  SPA-GMN-TBYOMEIINPUTCD(IDX)                          
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       6
               MOVE    SPA-GMN-BYOMEICD(IDY)
                                    TO  SPA-NAI-TBYOMEICD(IDX IDY)
           END-PERFORM
           MOVE    SPA-GMN-BYOMEI   TO  SPA-GMN-TBYOMEI(IDX)
           MOVE    SPA-GMN-CHARTBYOMEI
                                    TO  SPA-GMN-TCHARTBYOMEI (IDX) 
      *
           MOVE    SPA-GMN-UTAGAIFLG
                                    TO  SPA-NAI-TUTAGAIFLG (IDX)
           MOVE    SPA-GMN-UTAGAIFLGMEI
                                    TO  SPA-GMN-TUTAGAIFLG (IDX)
           MOVE    SPA-GMN-MANSEIKBN
                                    TO  SPA-NAI-TMANSEIKBN (IDX)
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-MANSEIKBN-MAX
               IF      SPA-GMN-MANSEIKBN 
                                   =   SPA-GMN-MANSEIKBNL (IDY)
                   MOVE    SPA-GMN-MANSEIKBNTANL (IDY)
                                   TO  SPA-GMN-TMANSEIKBN (IDX)
                   MOVE    SPA-GMN-MANSEIKBN-MAX      TO  IDY
               END-IF
           END-PERFORM         
           MOVE    SPA-NAI-BYOMEIHENFLG
                                    TO  SPA-NAI-TBYOMEIHENFLG (IDX)
           MOVE    SPA-NAI-BYOMEIMOJI
                                    TO  SPA-NAI-TBYOMEIMOJI   (IDX)
           MOVE    SPA-GMN-HKNBYOMEIFLG
                                    TO  SPA-NAI-THKNBYOMEIFLG (IDX)
           MOVE    SPA-GMN-HKNBYOMEIFLGMEI
                                    TO  SPA-GMN-THKNBYOMEIFLG (IDX)
           IF      SPA-GMN-DSPSEQ   =   ZERO
               MOVE    50               TO  SPA-GMN-TDSPSEQ (IDX)
           ELSE                                        
               MOVE    SPA-GMN-DSPSEQ   TO  SPA-GMN-TDSPSEQ (IDX)
           END-IF                             
           MOVE    SPA-NAI-CDSYU    TO  SPA-NAI-TCDSYU  (IDX)                         
      *
      *
      *    分類名一覧編集処理
           PERFORM 4204-BUNRUI-TBLSET-SEC
      *     
           INITIALIZE               SPA-GMN-KOUMOKU
                                    SPA-NAI-KOUMOKU
                                    SPA-NAI-SELNO
           MOVE    SPACE            TO  WRK-HAISIYMDH
      *
          .
       4201-INTBL-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    表示連番・入力コード別に並び替え処理
      *****************************************************************
       4203-INTBL-SORT-SEC         SECTION.
      *
           IF      SPA-GMN-MAX             >   ZERO 
      *
               COMPUTE IDX1    =   SPA-GMN-MAX -   1
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       IDX1
                   COMPUTE IDX2    =   IDX     +   1
                   PERFORM VARYING IDY FROM    IDX2    BY  1
                           UNTIL   IDY >       SPA-GMN-MAX 
                       IF      SPA-NAI-TKEY (IDX)   >
                                           SPA-NAI-TKEY (IDY)
                           MOVE    SPA-GMN-TBLO (IDX)
                                           TO  WRK-GMN-TBL
                           MOVE    SPA-GMN-TBLO (IDY)
                                           TO  SPA-GMN-TBLO (IDX)
                           MOVE    WRK-GMN-TBL
                                           TO  SPA-GMN-TBLO (IDY)
                           MOVE    SPA-NAI-TBLO (IDX)
                                           TO  WRK-NAI-TBL
                           MOVE    SPA-NAI-TBLO (IDY)
                                           TO  SPA-NAI-TBLO (IDX)
                           MOVE    WRK-NAI-TBL
                                           TO  SPA-NAI-TBLO (IDY)
                       END-IF
                   END-PERFORM    
               END-PERFORM
      *
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-MAX
                   MOVE    IDX             TO  SPA-GMN-TBANGO (IDX)
               END-PERFORM                 
           END-IF    
      *
          .
       4203-INTBL-SORT-EXT.
           EXIT.
      *
      *****************************************************************
      *    分類名一覧編集処理
      *****************************************************************
       4204-BUNRUI-TBLSET-SEC              SECTION.
      *
           MOVE    ZERO                    TO  IDY
           IF      SPA-GMN-BUNRUICD    NOT =   ZERO
               PERFORM VARYING     IDZ     FROM    1   BY  1
                       UNTIL       IDZ     >   SPA-GMN-BUNRUI-MAX
                   IF      SPA-GMN-BBUNRUICD(IDZ)  =   SPA-GMN-BUNRUICD
                       MOVE    IDZ                 TO  IDY
                       MOVE    SPA-GMN-BUNRUI-MAX  TO  IDZ
                   END-IF
               END-PERFORM
      *                  
               IF      IDY                 =   ZERO
                   ADD     1               TO  SPA-GMN-BUNRUI-MAX
                   MOVE    SPA-GMN-BUNRUI-MAX
                                           TO  IDY
                   MOVE    SPA-GMN-BUNRUICD
                                           TO  SPA-GMN-BBUNRUICD (IDY)
                   MOVE    SPA-GMN-BUNRUIMEI
                                           TO  SPA-GMN-BBUNRUIMEI(IDY)
               ELSE    
                   MOVE    SPA-GMN-BUNRUIMEI
                                           TO  SPA-GMN-BBUNRUIMEI(IDY)
               END-IF      
           END-IF
          .
       4204-BUNRUI-TBLSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新　処理
      *****************************************************************
       430-HENKOU-SEC              SECTION.
      *
           IF      SPA-GMN-BANGO  =   ZERO
               MOVE    "0004"              TO  SPA-ERRCD
               GO  TO  430-HENKOU-EXT
           END-IF
      *
           IF      SPA-GMN-BYOMEIINPUTCD  =   SPACE
               MOVE    "0049"               TO  SPA-ERRCD
               GO      TO      430-HENKOU-EXT
           END-IF
      *
           IF      SPA-NAI-BYOMEIMOJI   =   ZERO
               IF      SPA-GMN-BYOMEI       =   SPACE
                   MOVE    "0010"               TO  SPA-ERRCD
               ELSE    
                   MOVE    "0011"               TO  SPA-ERRCD
               END-IF    
               GO      TO      430-HENKOU-EXT
           END-IF
      *
           IF      SPA-GMN-CHARTBYOMEI  =   SPACE
               CONTINUE
           ELSE    
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-CHARTBYOMEI TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "2"
                   MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-CHARTBYOMEI
               ELSE
                   MOVE    "0071"              TO  SPA-ERRCD
                   MOVE    12                  TO  SPA-GMN-CUR
               GO      TO      430-HENKOU-EXT
               END-IF
           END-IF    
      *
      *    単独病名チェック
           IF      SPA-NAI-BYOMEIHENFLG    =   SPACE
               INITIALIZE                  WRK-TANDOKU-AREA
      *            
               PERFORM VARYING IDZ FROM    1   BY  1
                       UNTIL   IDZ >       6    
                       OR      SPA-GMN-BYOMEICD(IDZ)
                                           =   SPACE
                   MOVE    SPA-GMN-BYOMEICD (IDZ)
                                           TO  BYO-BYOMEICD
                   PERFORM 900-BYOMEI-READ-SEC
                   MOVE    BYO-TANDOKUKBN  TO  WRK-TANDOKUKBN (IDZ)
               END-PERFORM
      *     
               MOVE    ZERO                TO  IDX
               PERFORM VARYING IDZ FROM    1   BY  1
                       UNTIL   IDZ >       6
                       OR      SPA-GMN-BYOMEICD (IDZ)  
                                           =   SPACE
                   IF      WRK-TANDOKUKBN (IDZ)    =   ZERO   
                       MOVE    1                   TO  IDX
                   ELSE
                       MOVE    SPA-GMN-BYOMEICD (IDZ)
                                           TO  WRK-TANDOKUKBN-BYOMEICD  
                       MOVE    SPA-NAI-BYOMEI   (IDZ)
                                           TO  WRK-TANDOKUKBN-BYOMEI  
                   END-IF   
                END-PERFORM
               IF      IDX                 =   ZERO
                   MOVE    "0076"              TO  SPA-ERRCD  
                   GO  TO  430-HENKOU-EXT
               END-IF
           END-IF    
      * 
           MOVE    SPA-GMN-BANGO  TO  IDY
      *
           PERFORM 4202-INTBL-CHK-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  430-HENKOU-EXT
           END-IF
      *
           MOVE    SPA-GMN-BANGO  TO  IDX
      *
           PERFORM 4201-INTBL-SET-SEC
      *
      *        診療開始日別に並び替え
      ***  PERFORM 4203-INTBL-SORT-SEC
      *
           MOVE    1                   TO  SPA-GMN-CUR 
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-C03-UPDFLG
      *
          .
       430-HENKOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除　処理
      *****************************************************************
       440-SAKUJYO-SEC             SECTION.
      *
           IF      SPA-GMN-BANGO  =   ZERO
               MOVE    "0004"              TO  SPA-ERRCD
               GO  TO  440-SAKUJYO-EXT
           END-IF
      *
           MOVE    SPA-GMN-BANGO  TO  IDX
      *
           IF      SPA-NAI-TRENNUM (IDX)  =   ZERO
               CONTINUE
           ELSE
               ADD     1                TO  SPA-DEL-MAX
               MOVE    SPA-DEL-MAX      TO  IDZ  
               MOVE    SPA-GMN-TBYOMEIINPUTCD (IDX)
                                    TO  SPA-DEL-TBYOMEIINPUTCD (IDZ)
               MOVE    SPA-NAI-TCDSYU (IDX)
                                    TO  SPA-DEL-TCDSYU         (IDZ)
           END-IF 
      *
           INITIALIZE              SPA-GMN-TBLO (IDX)
           INITIALIZE              SPA-NAI-TBLO (IDX)
      *
           PERFORM VARYING     IDX1    FROM    IDX     BY  1
                   UNTIL       IDX1    =   SPA-GMN-MAX
               COMPUTE IDX2    =   IDX1    +   1
               MOVE    SPA-GMN-TBLO (IDX2) TO
                                               SPA-GMN-TBLO  (IDX1)
               MOVE    SPA-NAI-TBLO (IDX2) TO
                                               SPA-NAI-TBLO  (IDX1)
               MOVE    IDX1                    TO
                                               SPA-GMN-TBANGO(IDX1)
               INITIALIZE          SPA-GMN-TBLO (IDX2)
               INITIALIZE          SPA-NAI-TBLO (IDX2)
           END-PERFORM
      *
           COMPUTE SPA-GMN-MAX     =   SPA-GMN-MAX     -   1
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
                                       SPA-NAI-KOUMOKU
      *
      *        診療開始日別に並び替え
      ***  PERFORM 4203-INTBL-SORT-SEC
      *
           MOVE    1                   TO  SPA-GMN-CUR  
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-C03-UPDFLG
      *
          .
       440-SAKUJYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録　処理
      *****************************************************************
       450-TOUROKU-SEC                SECTION.
      *
           IF     (SPA-GMN-BANGO       NOT =   ZERO  )
             OR   (SPA-GMN-BYOMEICD-G  NOT =   SPACE )
               MOVE    "0051"             TO  SPA-ERRCD
               GO  TO  450-TOUROKU-EXT
           END-IF
      *
      *    更新済
           MOVE    SPACE            TO  SPA-C03-UPDFLG
      *
      *    自院病名マスター（分類名登録）
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-BUNRUI-MAX
                   INITIALIZE              USERBYOMEI-REC
                   MOVE    SPA-HOSPID          TO  USBYO-HOSPID
                   MOVE    "C"                 TO  USBYO-CDSYU
                   MOVE    SPA-GMN-BBUNRUICD(IDX)
                                               TO  USBYO-BYOMEIINPUTCD
                   PERFORM 900-USBYO-INV-SEC
                   IF      FLG-USERBYOMEI      =   1
                       INITIALIZE              USERBYOMEI-REC
                       MOVE    SPA-HOSPID      TO  USBYO-HOSPID
                       MOVE    "C"             TO  USBYO-CDSYU
                       MOVE    SPA-GMN-BBUNRUICD(IDX)
                                               TO  USBYO-BYOMEIINPUTCD
                   END-IF
                   MOVE    SPA-GMN-BBUNRUIMEI (IDX)
                                               TO  USBYO-BYOMEI
                   IF      FLG-USERBYOMEI      =   1                            
                       MOVE    "DBINSERT"          TO  MCP-FUNC
                   ELSE                            
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                   END-IF    
                   MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
                   MOVE    "USERBYOMEI-KEY"    TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO 
                       MOVE    "1005"              TO  SPA-ERRCD
                       DISPLAY "UPD USBYOMEI-KEY =>" USBYO-KEY 
                       GO  TO  450-TOUROKU-EXT
                   END-IF
           END-PERFORM    
                   
      *
      *    自院病名マスター削除
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-DEL-MAX
               INITIALIZE                      USBYO-KEY
               MOVE    SPA-HOSPID              TO  USBYO-HOSPID
               MOVE    SPA-DEL-TCDSYU  (IDX)   TO  USBYO-CDSYU
               MOVE    SPA-DEL-TBYOMEIINPUTCD (IDX) 
                                               TO  USBYO-BYOMEIINPUTCD 
               MOVE    USERBYOMEI-REC          TO  MCPDATA-REC
               MOVE    "DBDELETE"              TO  MCP-FUNC
               MOVE    "USERBYOMEI-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
               IF      MCP-RC              NOT =   ZERO 
                   MOVE    "1002"                  TO  SPA-ERRCD
                   DISPLAY "USERBYOMEI-KEY =>" USBYO-KEY 
                   GO  TO  450-TOUROKU-EXT
               END-IF
           END-PERFORM
      *
      *    自院病名マスター追加
      *
           IF      SPA-GMN-MAX             >   ZERO 
      *
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >       SPA-GMN-MAX
      * 
                   EVALUATE    SPA-NAI-TUPDFLG (IDX)
                     WHEN    ZERO
                       CONTINUE
                     WHEN    1     
                       INITIALIZE              USERBYOMEI-REC
                       MOVE    SPA-HOSPID          TO  USBYO-HOSPID
                       MOVE    SPA-NAI-TCDSYU(IDX)
                                                   TO  USBYO-CDSYU
                       MOVE    SPA-GMN-TBYOMEIINPUTCD(IDX)
                                               TO  USBYO-BYOMEIINPUTCD
                       PERFORM 4501-USERBYOMEI-HENSYU-SEC
      *
                       MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
                       MOVE    "DBINSERT"          TO  MCP-FUNC
                       MOVE    "USERBYOMEI-KEY"    TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                       IF      MCP-RC          NOT =   ZERO 
                           MOVE    "1004"              TO  SPA-ERRCD
                           DISPLAY "INS USERBYOMEI-KEY =>" USBYO-KEY 
                           GO  TO  450-TOUROKU-EXT
                       END-IF
                     WHEN    2
                       INITIALIZE              USERBYOMEI-REC
                       MOVE    SPA-HOSPID          TO  USBYO-HOSPID
                       MOVE    SPA-NAI-TCDSYU(IDX)
                                                   TO  USBYO-CDSYU
                       MOVE    SPA-GMN-TBYOMEIINPUTCD(IDX)
                                               TO  USBYO-BYOMEIINPUTCD
                       PERFORM 900-USBYO-INV-SEC
                       IF      FLG-USERBYOMEI        =   1
                           MOVE    "1003"          TO  SPA-ERRCD
                           DISPLAY "INV USBYOMEI-KEY =>" USBYO-KEY 
                           GO  TO  450-TOUROKU-EXT
                       END-IF
                       PERFORM 4501-USERBYOMEI-HENSYU-SEC
                       MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "USERBYOMEI-KEY"    TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                       IF      MCP-RC          NOT =   ZERO 
                           MOVE    "1001"              TO  SPA-ERRCD
                           DISPLAY "UPD USBYOMEI-KEY =>" USBYO-KEY 
                           GO  TO  450-TOUROKU-EXT
                       END-IF
                   END-EVALUATE
               END-PERFORM
           END-IF     
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       450-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録　処理
      *****************************************************************
       4501-USERBYOMEI-HENSYU-SEC                SECTION.
      *
           IF      SPA-NAI-TBUNRUICD(IDX)  NOT =   ZERO
               MOVE    SPA-NAI-TBUNRUICD(IDX)
                                           TO  USBYO-BUNRUICD
           ELSE
               MOVE    SPACE               TO  USBYO-BUNRUICD
           END-IF                                    
           MOVE    SPA-GMN-TDSPSEQ  (IDX)
                                       TO  USBYO-DSPSEQ
      *                                 
           MOVE    ZERO                TO  IDZ 
           MOVE    ZERO                TO  USBYO-BYOMEICDSU
           MOVE    SPACE               TO  USBYO-BYOMEICD-G
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL       IDY     >       6
               IF      SPA-NAI-TBYOMEICD (IDX IDY) 
                                           NOT =   SPACE
                   ADD     1               TO  USBYO-BYOMEICDSU
                   ADD     1               TO  IDZ 
                   MOVE    SPA-NAI-TBYOMEICD (IDX IDY)
                                           TO  USBYO-BYOMEICD (IDZ)
               END-IF
           END-PERFORM
           MOVE    SPA-NAI-TUTAGAIFLG (IDX)
                                           TO  USBYO-UTAGAIFLG
           MOVE    SPA-NAI-TMANSEIKBN (IDX)
                                           TO  USBYO-MANSEIKBN
           MOVE    SPA-GMN-TBYOMEI(IDX)
                                       TO  USBYO-BYOMEI
           MOVE    SPA-NAI-TBYOMEIMOJI(IDX)
                                       TO  USBYO-BYOMEIMOJI
           MOVE    SPA-GMN-TCHARTBYOMEI(IDX)
                                       TO  USBYO-CHARTBYOMEI
           MOVE    SPA-NAI-TCHARTBYOMEIMOJI(IDX)
                                       TO  USBYO-CHARTBYOMEIMOJI
           MOVE    SPA-NAI-TBYOMEIHENFLG  (IDX)
                                       TO  USBYO-BYOMEIHENFLG
      *
           MOVE    SPA-NAI-THKNBYOMEIFLG  (IDX)
                                       TO  USBYO-HKNBYOMEIFLG
           .
       4501-USERBYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    リスト出力前　処理
      *****************************************************************
       460-LIST-SEC             SECTION.
      *
           IF  SPA-GMN-BYOMEI-TBL NOT = SPACE
               MOVE    "0102"             TO  SPA-CIDCD
           ELSE
               MOVE    "1031"             TO  SPA-ERRCD
               GO  TO  460-LIST-EXT
           END-IF
      *
           .
       460-LIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    リスト出力　処理
      *****************************************************************
       470-PRINT-SEC             SECTION.
      *
      * 印刷用スクリプト処理
           MOVE    SPA-TERMID      TO  SHELL-TERMID     
           MOVE    SPA-SYSYMD      TO  SHELL-SYSYMD  
           MOVE    SPA-HOSPID      TO  SHELL-HOSPID  
      *
      *****MOVE    SHELL-NAME      TO  SHELLTBL-NAME
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    SHELL-NAME      TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
           MOVE    SHELL-TERMID    TO  SHELLTBL-ARG1
           MOVE    SHELL-SYSYMD    TO  SHELLTBL-ARG2
           MOVE    SHELL-HOSPID    TO  SHELLTBL-ARG3
      *    
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                   MCPAREA
                                   MCPDATA-REC 
           .
      *
       470-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア処理
      *****************************************************************
       410-CLEAR-SEC                   SECTION.
      *
           INITIALIZE               SPA-GMN-KOUMOKU
                                    SPA-NAI-KOUMOKU
                                    SPA-NAI-SELNO
      *
           MOVE    SPACE            TO  WRK-HAISIYMDH
      *                                   
           MOVE    1                TO  SPA-GMN-CUR
      *
           .
       410-CLEAR-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    病名検索へ
      *****************************************************************
       600-C05-SYORI-SEC           SECTION.
      *
      *    画面移行用のパラメタ変更
      *    受付と患者検索以外の元をセット
           MOVE    "C05"               TO  SPA-SAKIPG
      *
           INITIALIZE                  SPA-C01KYOUTU
           MOVE    "C03"               TO  SPA-C01-MOTOPG
           MOVE    ZERO                TO  IDY
      * 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-BYOMEICD (IDX)  NOT =   SPACE
                   ADD     1               TO  IDY              
                   MOVE    SPA-GMN-BYOMEICD (IDX)
                                           TO  SPA-C01-TBYOMEICD (IDY)
                   MOVE    SPA-NAI-BYOMEI   (IDX)
                                           TO  SPA-C01-TBYOMEI   (IDY)
               END-IF                              
           END-PERFORM 
      *
           MOVE    SPA-C01KYOUTU       TO  SPA-WORK
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "C05    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
      *
           .
       600-C05-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    疑いフラグ編集処理
      *****************************************************************
       5001-UTAGAIFLG-HENSYU-SEC       SECTION.
      *
           MOVE    ZERO               TO  WRK-HENFLG
      *     
           IF      SPA-GMN-UTAGAIFLG  =   SPACE
               MOVE    1                  TO  WRK-HENFLG
           ELSE
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-UTAGAIFLG 
                                  =   SPA-GMN-UTAGAIFLGL (IDY)
                       MOVE    SPA-GMN-UTAGAIFLGLST (IDY)
                                          TO  SPA-GMN-UTAGAIFLG-G
                       MOVE    1          TO  WRK-HENFLG
                   END-IF
               END-PERFORM
           END-IF
      *
           .
       5001-UTAGAIFLG-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    慢性フラグ編集処理
      *****************************************************************
       5001-MANSEIKBN-HENSYU-SEC       SECTION.
      *
           MOVE    ZERO               TO  WRK-HENFLG
      *     
           IF      SPA-GMN-MANSEIKBN  =   SPACE
               MOVE    1                  TO  WRK-HENFLG
           ELSE
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-MANSEIKBN 
                                  =   SPA-GMN-MANSEIKBNL (IDY)
                       MOVE    SPA-GMN-MANSEIKBNLST (IDY)
                                          TO  SPA-GMN-MANSEIKBN-G
                       MOVE    1          TO  WRK-HENFLG
                   END-IF
               END-PERFORM
           END-IF
      *
           .
       5001-MANSEIKBN-HENSYU-EXT.
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
           IF      SPA-CIDCD       NOT =   SPACE
               PERFORM 520-JIDSET-SEC
               GO      TO      500-SET-SCREEN-EXT
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
           MOVE    "C03    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  C03
      *
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
               MOVE    SPA-GMN-TBANGO    (IDX)
                                           TO  WRK-NUM
               MOVE    WRK-NUM             TO  C03-TBANGO    (IDX)
               MOVE    SPA-GMN-TBUNRUIMEI    (IDX)
                                           TO  C03-TBUNRUIMEI(IDX)
               MOVE    SPA-GMN-TBYOMEIINPUTCD(IDX)
                                           TO  C03-TBYOMEIINPUTCD(IDX)
               MOVE    SPA-GMN-TBYOMEI    (IDX)
                                           TO  C03-TBYOMEI   (IDX)
               MOVE    SPA-GMN-TCHARTBYOMEI (IDX)
                                           TO  C03-TCHARTBYOMEI(IDX)
               MOVE    SPA-GMN-TMANSEIKBN (IDX)
                                           TO  C03-TMANSEIFLG(IDX)
               MOVE    SPA-GMN-TUTAGAIFLG (IDX)
                                           TO  C03-TUTAGAIFLG(IDX)
               MOVE    SPA-GMN-THKNBYOMEIFLG (IDX)
                                           TO  C03-THKNBYOMEIFLG (IDX)
               MOVE    SPA-GMN-TDSPSEQ (IDX)
                                           TO  C03-TDSPSEQ (IDX)
      *
               
               IF      IDX             =   SPA-NAI-SELNO
                   MOVE    "T"         TO  C03-BYOMEILST-SELECT (IDX)
               ELSE
                   MOVE    "F"         TO  C03-BYOMEILST-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-MAX         TO  C03-BYOMEILST-COUNT
      *
           MOVE    SPA-GMN-BANGO          TO  C03-BANGO
           MOVE    SPA-GMN-BUNRUICD       TO  C03-BUNRUICD
           MOVE    SPA-GMN-BUNRUIMEI      TO  C03-BUNRUIMEI
           MOVE    SPA-GMN-BYOMEIINPUTCD  TO  C03-BYOMEIINPUTCD
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL       IDX     >      6
               MOVE    SPA-GMN-BYOMEICD(IDX)  TO  C03-BYOMEICD (IDX)
           END-PERFORM
           MOVE    SPA-GMN-BYOMEI         TO  C03-BYOMEI
           MOVE    SPA-GMN-CHARTBYOMEI    TO  C03-CHARTBYOMEI
           MOVE    SPA-GMN-BYOMEIHENFLG   TO  C03-BYOMEIHENFLG
      *
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-BUNRUI-MAX
               MOVE    SPA-GMN-BBUNRUICD (IDX) TO  C03-BBUNRUICD (IDX)
               MOVE    SPA-GMN-BBUNRUIMEI(IDX) TO  C03-BBUNRUIMEI(IDX)
           END-PERFORM    
           MOVE    SPA-GMN-BUNRUI-MAX    TO  C03-BUNRUI-COUNT
      *
           MOVE    SPA-GMN-UTAGAIFLG-G TO  C03-UTAGAIFLG
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-UTAGAIFLGL  (IDX)  =   SPACE
               MOVE    SPA-GMN-UTAGAIFLGLST (IDX)
                                           TO  C03-UTAGAIFLG-ITEM (IDX)
               MOVE    IDX                 TO  C03-UTAGAIFLG-COUNT    
           END-PERFORM
      *
           MOVE    SPA-GMN-MANSEIKBN-G TO  C03-MANSEIFLG
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-MANSEIKBNL  (IDX)  =   SPACE
               MOVE    SPA-GMN-MANSEIKBNLST (IDX)
                                           TO  C03-MANSEIFLG-ITEM (IDX)
               MOVE    IDX                 TO  C03-MANSEIFLG-COUNT
           END-PERFORM
      *
           MOVE    SPA-GMN-HKNBYOMEIFLG-G TO  C03-HKNBYOMEIFLG
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-HKNBYOMEIFLGL(IDX) =   SPACE
               MOVE    SPA-GMN-HKNBYOMEIFLGLST (IDX)
                                       TO  C03-HKNBYOMEIFLG-ITEM (IDX)
               MOVE    IDX             TO  C03-HKNBYOMEIFLG-COUNT
           END-PERFORM
      *
           MOVE    SPA-GMN-DSPSEQ      TO  C03-DSPSEQ
               
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
             WHEN    1
                     MOVE  "BANGO"      TO  MCP-WIDGET
             WHEN    3
                     MOVE  "BUNRUICD"   TO  MCP-WIDGET
             WHEN    4
                     MOVE  "BUNRUIMEI"  TO  MCP-WIDGET
             WHEN    2
                     MOVE  "BYOMEIINPUTCD"
                                        TO  MCP-WIDGET
             WHEN    5
                     MOVE  "BYOMEICD_1" TO  MCP-WIDGET
             WHEN    6
                     MOVE  "BYOMEICD_2" TO  MCP-WIDGET
             WHEN    7
                     MOVE  "BYOMEICD_3" TO  MCP-WIDGET
             WHEN    8
                     MOVE  "BYOMEICD_4" TO  MCP-WIDGET
             WHEN    9
                     MOVE  "BYOMEICD_5" TO  MCP-WIDGET
             WHEN    10
                     MOVE  "BYOMEICD_6" TO  MCP-WIDGET
             WHEN    11
                     MOVE  "BYOMEI"     TO  MCP-WIDGET
             WHEN    12
                     MOVE  "CHARTBYOMEI"
                                        TO  MCP-WIDGET
             WHEN    13
                     MOVE  "UTAGAIFLG"  TO  MCP-WIDGET
             WHEN    14
                     MOVE  "MANSEIFLG"  TO  MCP-WIDGET
             WHEN    15
                     MOVE  "HKNBYOMEIFLG"
                                        TO  MCP-WIDGET
             WHEN    16
                     MOVE  "DSPSEQ"     TO  MCP-WIDGET
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
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラーです"            TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "既に同一病名入力コードが存在します" 
                                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "対象のデータを選択してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象のデータが選択してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "病名コード順がエラーです"  TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "病名が長すぎます"          TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "項目に入力がありません"    TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "病名入力コード入力エラー" 
                                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "病名が入力されていません"  TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE
                       "病名コードまたは病名の入力にエラーがあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "病名番号入力エラー"        TO  SPA-ERRMSG
               WHEN    "0014"
                   MOVE    "数字で入力してください"    TO  SPA-ERRMSG
               WHEN    "0018"
                   MOVE    "疑い入力エラー"            TO  SPA-ERRMSG
               WHEN    "0021"
                   MOVE    "慢性区分入力エラー"        TO  SPA-ERRMSG
               WHEN    "0028"
                   MOVE    "保険病名入力エラー"        TO  SPA-ERRMSG
               WHEN    "0029"
                   MOVE    "基本病名が入力してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0034"
                   MOVE    "これ以上追加できません"    TO  SPA-ERRMSG
               WHEN    "0035"
                   MOVE    "不明の病名コードが入力されています"
                                                       TO  SPA-ERRMSG
               WHEN    "0049"
                   MOVE    "病名入力コードが未入力です"
                                                       TO  SPA-ERRMSG
               WHEN    "0050"
                   MOVE
                       "既に登録済みの病名入力コードは変更できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0051"
                   MOVE    "入力の途中です"            TO  SPA-ERRMSG
               WHEN    "0056"
                   MOVE    "複数病名の入力はできません"
                                                       TO  SPA-ERRMSG
               WHEN    "0062"
                   MOVE
               "未コード化傷病名は他のコードといっしょに入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0063"
                   MOVE
                 "未コード化傷病名が入力されているので入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0071"
                   MOVE    "全角入力して下さい"        TO  SPA-ERRMSG
               WHEN    "0072"
                   MOVE    "全角または半角のみで入力して下さい" 
                                                       TO  SPA-ERRMSG
               WHEN    "0075"
                   MOVE    "入力された病名はマスター上で"
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
               WHEN    "1000"
                   MOVE    "病名コードが有りません"    TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新処理でエラーになりました"
                                                       TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除処理でエラーになりました"
                                                       TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "自院病名マスタが存在しません"
                                                       TO  SPA-ERRMSG
               WHEN    "1004"
                   MOVE    "追加処理でエラーになりました"
                                                       TO  SPA-ERRMSG
               WHEN    "1005"
                   MOVE    "分類名の更新処理でエラーになりました"
                                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  CERR
           MOVE    SPA-ERRCD            TO  CERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  CERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "C03"                TO  SPA-MOTOPG
           MOVE    "CERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "CERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-JIDSET-SEC              SECTION.
      *
           EVALUATE    SPA-CIDCD
               WHEN    "0101"
                   MOVE    "内容が修正されています。"
                                       TO  WRK-CIDMSG
                   MOVE    "ＯＫで修正分は反映されずに終了します"
                                       TO  WRK-CIDMSG (25:)
               WHEN    "0102"
                   MOVE    "自院病名一覧を出力します。"
                                       TO  WRK-CIDMSG
               WHEN    OTHER
                   MOVE    SPA-ERRCD
                                       TO  WRK-CIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  SPA-CID1-FLG
      *
           MOVE    SPACE               TO  CID1
           MOVE    SPA-CIDCD           TO  CID1-ID1CODE
           MOVE    WRK-CIDMSG          TO  CID1-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "C03"               TO  SPA-MOTOPG
           MOVE    "CID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "CID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-JIDSET-EXT.
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
               WHEN    "0103"
                   MOVE    "あなたの入力された病名はマスター上で移行"
                                       TO  WRK-CIDMSG
                   MOVE    "病名の扱いとなっています。"
                                       TO  WRK-CIDMSG (41:)
               WHEN    "0105"
                   MOVE    "あなたの入力された病名はマスター上で移行"
                                       TO  WRK-CIDMSG
                   MOVE    "病名の扱いとなっています。"
                                       TO  WRK-CIDMSG (41:)
           END-EVALUATE
      *
           MOVE    SPACE               TO  CID2
           MOVE    WRK-CIDMSG          TO  CID2-MSG
           MOVE    SPA-C03-IKOMOTO-BYOMEICD
                                       TO  CID2-BYOMEICD1
           MOVE    SPA-C03-IKOMOTO-BYOMEI  
                                       TO  CID2-BYOMEI1
           MOVE    SPA-C03-IKOSAKI-BYOMEICD
                                       TO  CID2-BYOMEICD2
           MOVE    SPA-C03-IKOSAKI-BYOMEI
                                       TO  CID2-BYOMEI2
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "C03"               TO  SPA-MOTOPG
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
               MOVE    SPACE               TO  WRK-NENGO
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
               MOVE    LNK-DAY2-EDTYMD2-G  TO  WRK-NENGO
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名マスター読込（主キー）
      *****************************************************************
       900-USBYO-INV-SEC         SECTION.
      *
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "USERBYOMEI-KEY"    TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-USERBYOMEI
               INITIALIZE                  USERBYOMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-USBYO-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者病名マスター読込
      *****************************************************************
       900-USBYO-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  USERBYOMEI-REC
               MOVE    ZERO            TO  FLG-USERBYOMEI
           ELSE
               INITIALIZE                  USERBYOMEI-REC
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           .
       900-USBYO-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-READ-SEC         SECTION.
      *
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  BYOMEI-REC
                   MOVE    ZERO                TO  FLG-BYOMEI
               ELSE
                   MOVE    1                   TO  FLG-BYOMEI
                   INITIALIZE                  BYOMEI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-BYOMEI
               INITIALIZE                  BYOMEI-REC
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
       900-BYOMEI-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-READ-N-SEC         SECTION.
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
       900-BYOMEI-READ-N-EXT.
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
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *
