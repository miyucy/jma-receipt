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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGX98.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : チェックマスタ情報設定
      *  コンポーネント名  : 診療行為一覧選択サブ（Ｘ９８）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01.05.29  一致等のボタンの追加
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    チェックマスタ情報設定用共通パラメタ
           COPY    "X01COMMON-SPA".
      *
      *    チェックマスタ情報用画面スパ
           COPY    "X01SCR-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-INPUTCD         PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-BYOMEI          PIC 9(01).
      *
           03  FLG-KANJI           PIC 9(01).
           03  FLG-KANA            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
           03  CNT-ENT             PIC 9(06).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
           03  ID1                 PIC 9(04).
           03  ID2                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-SEYMD.
               05  WRK-SEYY        PIC 9(04).
               05  WRK-SEMM        PIC 9(02).
               05  WRK-SEDD        PIC 9(02).
      *
           03  WRK-CNT-ENT         PIC 9(04).
           03  WRK-MOJI            PIC 9(04).
           03  WRK-MAP-INDEX       PIC 9(03).
           03  WRK-SELNO           PIC 9(04).
           03  WRK-NOZ             PIC ZZ9.
           03  WRK-TENSUS-X.
               05  WRK-TENSUS      PIC ZZZZ9.99.
      *
           03  WRK-INPUTCD         PIC X(22).
      *
      *
           03  WRK-PATH            PIC X(64).
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
      *    診療種別名テーブル
      *D   COPY    "CMSRYSYU.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    入力コードマスタ−
       01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
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
           COPY    "X01.INC".
           COPY    "X02.INC".
           COPY    "X98.INC".
           COPY    "XERR.INC".
           COPY    "XID1.INC".
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
           MOVE    SPA-WORK        TO  SPA-X01KYOUTU 
           MOVE    SPA-FREE        TO  SPA-X01FREE
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
           MOVE    SPA-X01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-X01FREE     TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "XERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           PERFORM 5001-MAPCUR-SEC
      *
      ***  MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE   "X98"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC             SECTION.
      *
      ***     INITIALIZE                  SPA-X98GMN-AREA
      *
           MOVE    ZERO                TO  SPA-X98-RC
      *
           MOVE    2                   TO  SPA-X98-GMN-CUR
            .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       310-SPA-SET-SEC                 SECTION.
      *
           INITIALIZE                  SPA-X98-GMN-TBL
           MOVE    ZERO                TO  SPA-X98-GMN-MAX
      *
           IF      SPA-X98-GMN-KBN     =   SPACE
               MOVE    "2"                 TO  SPA-X98-GMN-KBN
           END-IF
      *
           EVALUATE    SPA-X98-GMN-KBN
               WHEN    "1"
                       PERFORM 3101-BYOMEICD-SET-SEC
               WHEN    "2"
                   IF      SPA-X98-TYPE    =   "1"
                       PERFORM 3101-INPUTCD-SET-SEC
                   END-IF
                   IF      SPA-X98-GMN-MAX     =   ZERO
                       PERFORM 3102-TENSU-SET-SEC
                   END-IF
           END-EVALUATE
      *
           .
       310-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *     入力コードマスタ−より編集
      *****************************************************************
       3101-BYOMEICD-SET-SEC            SECTION.
      *
           MOVE    ZERO                TO  IDX
      *
           IF      SPA-X98-GMN-INPUT   =   SPACE
               MOVE    ZERO            TO  SPA-X98-GMN-MAX
               GO      TO      3101-BYOMEICD-SET-EXT
           END-IF
      *
           INITIALIZE                  BYOMEI-REC
           MOVE    SPA-X98-GMN-INPUT   TO  BYO-BYOMEI
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
           PERFORM  UNTIL     (IDX             >   200  )   OR
                              (FLG-BYOMEI      =   1 )
               ADD     1               TO  IDX
               IF      IDX             <=  200
                   MOVE    IDX             TO  SPA-X98-GMN-NO    (IDX)
                   MOVE    BYO-BYOMEICD    TO  SPA-X98-GMN-SRYCD (IDX)
                   MOVE    BYO-BYOMEI      TO  SPA-X98-GMN-NAME  (IDX)
      *
                   MOVE    IDX             TO  SPA-X98-GMN-MAX
               END-IF
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
           IF      IDX                     >   200
               MOVE    "0005"                  TO  SPA-ERRCD
           END-IF
      *
           .
       3101-BYOMEICD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *     入力コードマスタ−より編集
      *****************************************************************
       3101-INPUTCD-SET-SEC            SECTION.
      *
           MOVE    "1"                 TO  SPA-X98-TYPE
           MOVE    ZERO                TO  WRK-CNT-ENT
      *
           MOVE    SPACE               TO  INPUTCD-REC
           MOVE    SPA-HOSPID          TO  ICD-HOSPID
           MOVE    SPA-X98-CDSYUBETU   TO  ICD-CDSYU
           MOVE    SPA-X98-GMN-INPUT   TO  ICD-INPUTCD
      *
           MOVE    INPUTCD-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
               PERFORM                     930-INPUTCD-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-INPUTCD
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM
               UNTIL      (IDX         >   200 )   OR
                          (FLG-INPUTCD     =   1   )
      *
      *        セットは対象外
            IF      ICD-SRYCD(1:1)     =   "S"  OR  "P"
               CONTINUE
            ELSE
      *
               ADD     1                   TO  WRK-CNT-ENT
               ADD     1                   TO  IDX
               MOVE    IDX                 TO  SPA-X98-GMN-NO   (IDX)
               MOVE    ICD-INPUTCD         TO  SPA-X98-GMN-INPUTCD
                                                                (IDX)
               MOVE    ICD-SRYCD           TO  SPA-X98-GMN-SRYCD(IDX)
      *
      ******** IF      ICD-DSPNAME     NOT =   SPACE
      *            MOVE    ICD-DSPNAME     TO  SPA-X98-GMN-NAME(IDX)
      ******** ELSE
      *            点数マスタより編集
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    ICD-SRYCD           TO  TNS-SRYCD
                   MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
                   MOVE    "DBSELECT"          TO  MCP-FUNC
                   MOVE    "TENSU-KEY"         TO  ORC-DBPATH
                   MOVE    SPA-SYSYMD          TO  ORC-DBYMD
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC              =   ZERO
                       MOVE    "TENSU-KEY"         TO  ORC-DBPATH
                       PERFORM                     910-TENSU-READ-SEC
                   ELSE
                       MOVE    1                   TO  FLG-TENSU
                   END-IF
                   MOVE    "DBCLOSE"           TO  MCP-FUNC
                   MOVE    "TENSU-KEY"         TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
                   IF      FLG-TENSU           =   ZERO
                       MOVE    TNS-NAME        TO  SPA-X98-GMN-NAME
                                                                (IDX)
                       MOVE    TNS-TEN         TO  SPA-X98-GMN-KISOTEN
                                                                (IDX)
                   END-IF
      *********END-IF
      *
             END-IF
      *
               MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
               PERFORM                     930-INPUTCD-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    WRK-CNT-ENT         TO  SPA-X98-GMN-MAX
      *
      *
           IF      IDX                     >   200
               MOVE    "0005"                  TO  SPA-ERRCD
           END-IF
           .
       3101-INPUTCD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ−より編集
      *****************************************************************
       3102-TENSU-SET-SEC                 SECTION.
      *
           MOVE    "2"                 TO  SPA-X98-TYPE
           MOVE    ZERO                TO  WRK-CNT-ENT
           IF      SPA-X98-GMN-SYORI   =   SPACE
               MOVE    "4"                 TO  SPA-X98-GMN-SYORI
           END-IF
      *
           EVALUATE    SPA-X98-GMN-SYORI
      *        主キー
               WHEN    SPACE
                   MOVE    "TENSU-KEY2"        TO  WRK-PATH
      *        医薬品
               WHEN    "4"
                   MOVE    "TENSU-KEY5"        TO  WRK-PATH
      *        器材
               WHEN    "6"
                   MOVE    "TENSU-KEY6"        TO  WRK-PATH
      *        診療行為
               WHEN    "8"
                   MOVE    "TENSU-KEY7"        TO  WRK-PATH
           END-EVALUATE
      *
           IF      SPA-X98-GMN-INPUT   =   SPACE
               MOVE    ZERO            TO  SPA-X98-GMN-MAX
               GO      TO      3102-TENSU-SET-EXT
           END-IF
      *
           INITIALIZE                      TNS-TENSU-REC
           MOVE    SPA-X98-GMN-INPUT   TO  TNS-NAME
           MOVE    SPA-X98-GMN-INPUT   TO  TNS-KANANAME
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM                     910-TENSU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM
               UNTIL      (IDX         >    200 )   OR
                          (FLG-TENSU   =   1   )
      *
      *        病院診療所区分判定
               IF      (TNS-HOSPSRYKBN     =   ZERO        )  OR
                       (TNS-HOSPSRYKBN     =   SPA-HOSPSBT )
                   PERFORM 31021-TENSU-HEN-SEC
               END-IF
      *
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM                     910-TENSU-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    WRK-CNT-ENT         TO  SPA-X98-GMN-MAX
      *
           IF      IDX                     >   200
               MOVE    "0005"                  TO  SPA-ERRCD
           END-IF
      *
           .
       3102-TENSU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ編集処理
      *****************************************************************
       31021-TENSU-HEN-SEC                  SECTION.
      *
           ADD     1                   TO  IDX
      *
           IF      IDX                 <=  200
               ADD     1                   TO  WRK-CNT-ENT
               MOVE    IDX                 TO  SPA-X98-GMN-NO   (IDX)
               MOVE    TNS-SRYCD           TO  SPA-X98-GMN-INPUTCD
                                                                (IDX)
               MOVE    TNS-SRYCD           TO  SPA-X98-GMN-SRYCD(IDX)
               MOVE    TNS-NAME            TO  SPA-X98-GMN-NAME
                                                                (IDX)
               MOVE    TNS-TEN             TO  SPA-X98-GMN-KISOTEN
                                                            (IDX)
      *
      *    診療行為で老人の時、再編集
               IF     (SPA-X98-GMN-SYORI   =   "8" )  AND
                      (TNS-ROUTEKKBN       =   2   )
                   MOVE    SPACE           TO  SPA-X98-GMN-NAME(IDX)
                   STRING  "［老］"
                           TNS-NAME        DELIMITED   BY  SIZE
                           INTO            SPA-X98-GMN-NAME(IDX)
                   END-STRING
               END-IF
           END-IF
      *
           .
       31021-TENSU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  X98
      *
           MOVE    SPA-X98-GMN-INPUT   TO  X98-INPUT
      *
           EVALUATE    SPA-X98-GMN-SYORI
      *        医薬品
               WHEN    "4"
                   MOVE    "医薬品"            TO  X98-SENTAKU
      *        器材
               WHEN    "6"
                   MOVE    "器材"              TO  X98-SENTAKU
      *        診療行為
               WHEN    "8"
                   MOVE    "診療行為"          TO  X98-SENTAKU
      *        その他
               WHEN    OTHER
                   MOVE    "病名"              TO  X98-SENTAKU
           END-EVALUATE
      *
           IF      SPA-X98-TYPE        =   "1"
               MOVE    "自院分"        TO  X98-SENTAKU
           END-IF
      *
      *
           EVALUATE    SPA-X98-TYPE
               WHEN    "2" 
                   PERFORM VARYING   IDX       FROM    1   BY  1
                           UNTIL     IDX       >   SPA-X98-GMN-MAX
      *            分類入力時、分類コードを番号へ
      *****************IF      SPA-X98-CDSYUBETU       =   "6"
      *                    MOVE    SPA-X98-GMN-INPUTCD (IDX)(4:3)
      *                                        TO  X98-NO  (IDX)
      *                    MOVE    SPA-X98-GMN-INPUTCD (IDX)(4:3)
      *                                        TO  SPA-X98-NAI-NO(IDX)
      *****************ELSE
                           MOVE    IDX         TO  WRK-NOZ
                           MOVE    WRK-NOZ     TO  X98-NO  (IDX)
                           MOVE    IDX         TO  SPA-X98-NAI-NO(IDX)
      *****************END-IF
      *
                       MOVE    SPA-X98-GMN-NAME (IDX)
                                               TO  X98-NAME (IDX)
                       IF     (SPA-X98-GMN-KISOTEN(IDX)
                                                   =   ZERO  )  AND
                              (SPA-X98-GMN-INPUTCD(IDX)(1:1)
                                                   =   "S"   )
                           CONTINUE
                       ELSE
                           MOVE    SPA-X98-GMN-KISOTEN(IDX)
                                               TO  WRK-TENSUS
                           MOVE    WRK-TENSUS  TO  X98-KISOTEN (IDX)
                       END-IF
                   END-PERFORM
               WHEN    "1"
               WHEN    SPACE
                   PERFORM VARYING   IDX       FROM    1   BY  1
                           UNTIL     IDX       >   SPA-X98-GMN-MAX
                       MOVE    IDX             TO  WRK-NOZ
                       MOVE    WRK-NOZ         TO  X98-NO  (IDX)
                       MOVE    IDX             TO  SPA-X98-NAI-NO(IDX)
                       MOVE    SPA-X98-GMN-NAME (IDX)
                                               TO  X98-NAME (IDX)
                   END-PERFORM
           END-EVALUATE    
      *
           MOVE    SPA-X98-GMN-MAX     TO  X98-COUNT
      *
           MOVE    SPA-X98-GMN-SELNUM  TO  X98-SELNUM
      *
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-X98-GMN-CUR
               WHEN    01
                   MOVE    "SELNUM"        TO  MCP-WIDGET
               WHEN    02
                   MOVE    "INPUT"         TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        医薬品
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 240-YAKUHIN-SEC
      *        器材
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 260-KIZAI-SEC
      *        診療行為
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 280-SINRYOU-SEC
      *        病名
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 285-BYOMEI-SEC
      *        前方
               WHEN    "CLICKED"       ALSO    "BMAE"
                   PERFORM 290-MAE-SEC
      *        部分
               WHEN    "CLICKED"       ALSO    "BBUB"
                   PERFORM 291-BUB-SEC
      *        後方
               WHEN    "CLICKED"       ALSO    "BATO"
                   PERFORM 292-ATO-SEC
           END-EVALUATE
          .
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        キー入力
               WHEN    "ACTIVATE"      ALSO    "INPUT"
                   PERFORM 41013-INPUT-CHK-SEC
      *        番号入力
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 41011-SELNUM-CHK-SEC
      *        行選択
               WHEN    ANY             ALSO    "LIST"
                   PERFORM 41012-LISTSEL-SEC
           END-EVALUATE
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    キー入力　処理
      *****************************************************************
       41013-INPUT-CHK-SEC                SECTION.
      *
           MOVE    2               TO  SPA-X98-GMN-CUR
      *
           IF      X98-INPUT           =   SPA-X98-GMN-INPUT
               MOVE    1               TO  SPA-X98-GMN-CUR
               GO      TO      41013-INPUT-CHK-EXT
           END-IF
      *
           MOVE    X98-INPUT           TO  SPA-X98-GMN-INPUT
      *
           EVALUATE    SPA-X98-GMN-KBN
               WHEN    "1"
                   MOVE    SPACE           TO  SPA-X98-GMN-SYORI
               WHEN    "2"
                   MOVE    ZERO                TO  FLG-KANJI
                   MOVE    ZERO                TO  FLG-KANA
                   MOVE    ZERO                TO  WRK-MOJI
      *
                   INITIALIZE                  ORCSKANACHKAREA
                   MOVE    "1"                 TO  KANACHK-SYORI
                   MOVE    SPA-X98-GMN-INPUT   TO  KANACHK-MAE-INPUT
                   CALL    "ORCSKANACHK"       USING
                                               ORCSKANACHKAREA
                   IF      KANACHK-RC      NOT =   ZERO
      *                全角半角混在エラー
                       MOVE    "0001"          TO  SPA-ERRCD
                   ELSE
                       MOVE    KANACHK-MAX     TO  WRK-MOJI
      *                全角
                       IF      KANACHK-SYUBETU     =   2
                           MOVE    1               TO  FLG-KANJI
                       ELSE
                           MOVE    ZERO            TO  FLG-KANJI
                       END-IF
                   END-IF
      * 
      *************PERFORM VARYING IDX     FROM    1   BY  1
      *                    UNTIL  (IDX         >   22     )  OR
      *                           (SPA-X98-GMN-INPUT(IDX:1)
      *                                        =   SPACE  )
      *
      *                ADD     1                   TO  WRK-MOJI
      *                IF      SPA-X98-GMN-INPUT(IDX:1)
      *                                       >=  X"A1"
      *                    MOVE    1              TO  FLG-KANJI
      *                ELSE
      *                    IF       SPA-X98-GMN-INPUT(IDX:1)
      *                                           IS  ALPHABETIC
      *                        MOVE    1          TO  FLG-KANA
      *                    END-IF
      *                END-IF
      *************END-PERFORM
                   IF     (WRK-MOJI            =   ZERO  )  OR
                          (FLG-KANJI           =   1     AND
                           FLG-KANA            =   1     )
                       MOVE    "0001"          TO  SPA-ERRCD
                       GO  TO                  41013-INPUT-CHK-EXT
                   END-IF
      *
                   IF      FLG-KANJI           =   1
      *                全角入力（点数マスタより）
                       MOVE    "1"                 TO  SPA-X98-TYPE
                       MOVE    "J"                 TO  SPA-X98-CDSYUBETU
                   ELSE
      *                半角入力（入力セットマスタより）
                       IF       SPA-X98-GMN-INPUT(1:WRK-MOJI)  NUMERIC
                           EVALUATE    WRK-MOJI
                               WHEN    4
                                   MOVE    "4"     TO  SPA-X98-CDSYUBETU
                               WHEN    5
                                   MOVE    "5"     TO  SPA-X98-CDSYUBETU
                               WHEN    6
                               WHEN    3
                                   MOVE    "6"     TO  SPA-X98-CDSYUBETU
                               WHEN    OTHER
                                   MOVE    "6"     TO  SPA-X98-CDSYUBETU
                           END-EVALUATE
                       ELSE
                           MOVE    "A"             TO  SPA-X98-CDSYUBETU
                       END-IF
                       MOVE    "1"                 TO  SPA-X98-TYPE
                   END-IF
           END-EVALUATE
           MOVE    1                   TO  SPA-X98-GMN-CUR
      *
      *    ＳＰＡセット
           PERFORM                     310-SPA-SET-SEC
      *
      *
           .
       41013-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択　処理
      *****************************************************************
       41011-SELNUM-CHK-SEC                SECTION.
      *
           IF      X98-SELNUM(1:1)     =   "*"
               IF       SPA-X98-GMN-KBN    =   "2"
                   PERFORM 3102-TENSU-SET-SEC
               ELSE
                   MOVE    "0002"          TO  SPA-ERRCD
               END-IF
               GO      TO      41011-SELNUM-CHK-EXT
           END-IF
      *
           IF      X98-SELNUM          =   SPACE
               MOVE    2               TO  SPA-X98-GMN-CUR
               GO      TO      41011-SELNUM-CHK-EXT
           END-IF
      *
           MOVE    X98-SELNUM          TO  SPA-X98-GMN-SELNUM
      *    選択番号入力
           INITIALIZE                      ORCSNUMAREA
           MOVE    X98-SELNUM          TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN         =   "1"   )   OR
                  (SNUM-SYOKBN         =   "1"   )
               MOVE    "0001"              TO  SPA-ERRCD
           ELSE
               MOVE    SNUM-OUTNUM         TO  SPA-X98-NAI-SELNUM
           END-IF
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   200
               IF      SPA-X98-NAI-NO (IDX)    =   SPA-X98-NAI-SELNUM
                   MOVE    IDX             TO  WRK-SELNO
                   MOVE    200             TO  IDX
               END-IF
           END-PERFORM
      *
           PERFORM 41011-SELNO-SEC
           .
       41011-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41012-LISTSEL-SEC       SECTION.
      *        行選択
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   200
               IF      X98-SELECT (IDX)    =   "T"
                   MOVE    IDX             TO  WRK-SELNO
                   MOVE    200             TO  IDX
               END-IF
           END-PERFORM
      *
           PERFORM 41011-SELNO-SEC
           .
       41012-LISTSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細選択編集処理
      *****************************************************************
       41011-SELNO-SEC       SECTION.
      *
           IF      WRK-SELNO           <   01  OR
                                       >   SPA-X98-GMN-MAX
               MOVE    "0002"          TO  SPA-ERRCD
               GO      TO              41011-SELNO-EXT
           END-IF
      *
           MOVE    WRK-SELNO           TO  IDX
           MOVE    SPA-X98-GMN-SRYCD (IDX)
                                       TO  SPA-X98-SRYCD
           MOVE    SPA-X98-GMN-NAME  (IDX)
                                       TO  SPA-X98-NAME
      *
           PERFORM 210-BACK
      *
          .
       41011-SELNO-EXT.
           EXIT.
      *
      *****************************************************************
      *    医薬品選択処理
      *****************************************************************
       240-YAKUHIN-SEC                   SECTION.
      *
           IF      SPA-X98-GMN-INPUT   =   SPACE
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-X98-GMN-CUR
               GO  TO  240-YAKUHIN-EXT
           END-IF
      *
           MOVE    "2"                 TO  SPA-X98-TYPE
           MOVE    "2"                 TO  SPA-X98-GMN-KBN
           MOVE    "4"                 TO  SPA-X98-GMN-SYORI
      *
      *    ＳＰＡセット
           PERFORM                     310-SPA-SET-SEC
      *
          .
       240-YAKUHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    医薬品選択処理
      *****************************************************************
       260-KIZAI-SEC                   SECTION.
      *
           IF      SPA-X98-GMN-INPUT   =   SPACE
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-X98-GMN-CUR
               GO  TO  260-KIZAI-EXT
           END-IF
      *
           MOVE    "2"                 TO  SPA-X98-GMN-KBN
           MOVE    "2"                 TO  SPA-X98-TYPE
           MOVE    "6"                 TO  SPA-X98-GMN-SYORI
      *
      *    ＳＰＡセット
           PERFORM                     310-SPA-SET-SEC
      *
          .
       260-KIZAI-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名行為選択処理
      *****************************************************************
       285-BYOMEI-SEC                   SECTION.
      *
           IF      SPA-X98-GMN-INPUT   =   SPACE
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-X98-GMN-CUR
               GO  TO  285-BYOMEI-EXT
           END-IF
      *
           MOVE    "1"                 TO  SPA-X98-GMN-KBN
           MOVE    SPACE               TO  SPA-X98-GMN-SYORI
      *
      *    ＳＰＡセット
           PERFORM                     310-SPA-SET-SEC
      *
          .
       285-BYOMEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為選択処理
      *****************************************************************
       280-SINRYOU-SEC                   SECTION.
      *
           IF      SPA-X98-GMN-INPUT   =   SPACE
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-X98-GMN-CUR
               GO  TO  280-SINRYOU-EXT
           END-IF
      *
           MOVE    "2"                 TO  SPA-X98-GMN-KBN
           MOVE    "8"                 TO  SPA-X98-GMN-SYORI
           MOVE    "2"                 TO  SPA-X98-TYPE
      *
      *    ＳＰＡセット
           PERFORM                     310-SPA-SET-SEC
      *
          .
       280-SINRYOU-EXT.
           EXIT.
      *****************************************************************
      *    前方一致処理
      *****************************************************************
       290-MAE-SEC                   SECTION.
      *
      *    全角入力時、のみ
           IF      SPA-X98-CDSYUBETU   NOT =   SPACE
               GO      TO      290-MAE-EXT
           END-IF
      *
           INSPECT SPA-X98-GMN-INPUT   REPLACING  ALL "＊"  BY  SPACE
           MOVE    SPACE               TO  WRK-INPUTCD
           MOVE    ZERO                TO  ID2
           PERFORM VARYING     ID1     FROM    1   BY  1
                   UNTIL       ID1     >   22
               IF      SPA-X98-GMN-INPUT(ID1:1)    NOT =   SPACE
                   ADD     1               TO  ID2
                   MOVE    SPA-X98-GMN-INPUT(ID1:1)
                                           TO  WRK-INPUTCD(ID2:1)
               END-IF
           END-PERFORM
      *
           MOVE    WRK-INPUTCD         TO  SPA-X98-GMN-INPUT
      *
      *    ＳＰＡセット
           MOVE    "2"                 TO  SPA-X98-TYPE
           PERFORM                     310-SPA-SET-SEC
      *
          .
       290-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    部分一致処理
      *****************************************************************
       291-BUB-SEC                   SECTION.
      *
      *    全角入力時、のみ
           IF      SPA-X98-CDSYUBETU   NOT =   SPACE
               GO      TO      291-BUB-EXT
           END-IF
      *
           INSPECT SPA-X98-GMN-INPUT   REPLACING  ALL "＊"  BY  SPACE
           MOVE    SPACE               TO  WRK-INPUTCD
           MOVE    ZERO                TO  ID2
           PERFORM VARYING     ID1     FROM    1   BY  1
                   UNTIL       ID1     >   22
               IF      SPA-X98-GMN-INPUT(ID1:1)    NOT =   SPACE
                   ADD     1               TO  ID2
                   MOVE    SPA-X98-GMN-INPUT(ID1:1)
                                           TO  WRK-INPUTCD(ID2:1)
               END-IF
           END-PERFORM
      *
           MOVE    SPACE               TO  SPA-X98-GMN-INPUT
           STRING  "＊"                DELIMITED  BY  SIZE
                   WRK-INPUTCD         DELIMITED  BY  SPACE
                   "＊"                DELIMITED  BY  SIZE
                                       INTO    SPA-X98-GMN-INPUT
           END-STRING
      *
      *    ＳＰＡセット
           MOVE    "2"                 TO  SPA-X98-TYPE
           PERFORM                     310-SPA-SET-SEC
      *
          .
       291-BUB-EXT.
           EXIT.
      *****************************************************************
      *    後分一致処理
      *****************************************************************
       292-ATO-SEC                   SECTION.
      *
      *    全角入力時、のみ
           IF      SPA-X98-CDSYUBETU   NOT =   SPACE
               GO      TO      292-ATO-EXT
           END-IF
      *
           INSPECT SPA-X98-GMN-INPUT   REPLACING  ALL "＊"  BY  SPACE
           MOVE    SPACE               TO  WRK-INPUTCD
           MOVE    ZERO                TO  ID2
           PERFORM VARYING     ID1     FROM    1   BY  1
                   UNTIL       ID1     >   22
               IF      SPA-X98-GMN-INPUT(ID1:1)    NOT =   SPACE
                   ADD     1               TO  ID2
                   MOVE    SPA-X98-GMN-INPUT(ID1:1)
                                           TO  WRK-INPUTCD(ID2:1)
               END-IF
           END-PERFORM
      *
           MOVE    SPACE               TO  SPA-X98-GMN-INPUT
           STRING  "＊"                DELIMITED  BY  SIZE
                   WRK-INPUTCD         DELIMITED  BY  SPACE
                                       INTO    SPA-X98-GMN-INPUT
           END-STRING
      *
      *    ＳＰＡセット
           MOVE    "2"                 TO  SPA-X98-TYPE
           PERFORM                     310-SPA-SET-SEC
      *
          .
       292-ATO-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    SPA-X98-MOTOPG      TO  SPA-SAKIPG
           MOVE    "X98"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
      ***  MOVE    "BACK"              TO  MCP-PUTTYPE
           MOVE    "JOIN"              TO  MCP-PUTTYPE
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
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "X98"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
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
                   MOVE    "入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "選択番号入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "検索対象が２００件以上あります"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
      *
           MOVE    SPACE               TO  XERR
           MOVE    SPA-ERRCD           TO  XERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  XERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "X98"               TO  SPA-MOTOPG
           MOVE    "XERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "XERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
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
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               MOVE    ZERO                TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コードマスター読込
      *****************************************************************
       930-INPUTCD-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  INPUTCD-REC
               MOVE    ZERO                TO  FLG-INPUTCD
           ELSE
               INITIALIZE                      INPUTCD-REC
               MOVE    1                   TO  FLG-INPUTCD
           END-IF
      *
           .
       920-INPUTCD-NEXT-EXT.
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
