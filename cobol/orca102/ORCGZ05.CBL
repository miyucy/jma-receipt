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
       PROGRAM-ID.                               ORCGZ05.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 点数マスタ設定
      *  コンポーネント名  : 点数マスタ特定器材設定画面（Ｚ０５）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01/07/03  日付入力チェックサブ追加
      *  01.00.02    MCC-多々納   01/07/18  正式名称等追加
      *  01.01.01    MCC-藤原     01/09/26  JOINの修正      
      *  01.01.02    MCC-多々納   02/07/18  服用方法画面追加
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                                      DIVISION.
       FILE                                      SECTION.
      *
       WORKING-STORAGE                           SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    点数マスタ設定用共通パラメタ
           COPY    "Z01COMMON-SPA".
      *
      *    第一画面ＳＰＡエリア
           COPY    "Z01SCR-SPA".
      *
       01  SPA-Z05.
      *
      *    第五画面ＳＰＡエリア
           03  SPA-GMN-AREA.
               05  SPA-GMN-SRYCDH              PIC X(09).
               05  SPA-GMN-NAMEH               PIC X(100).
               05  SPA-GMN-YUKOSTYMDH          PIC X(09).
               05  SPA-GMN-YUKOEDYMDH          PIC X(09).
               05  SPA-GMN-YUKOSTYMD           PIC X(10).
               05  SPA-GMN-YUKOEDYMD           PIC X(10).
               05  SPA-GMN-KANANAME            PIC X(100).
               05  SPA-GMN-NAME                PIC X(100).
               05  SPA-GMN-FORMALNAME          PIC X(200).
               05  SPA-GMN-TEN                 PIC 9(8)V9(2).
      *
               05  SPA-GMN-TENSIKIBETU-G.
                   07  SPA-GMN-TENSIKIBETU         PIC 9(1).
                   07  SPA-GMN-F1                  PIC X(1).
                   07  SPA-GMN-TENSIKIBETUMEI      PIC X(20).
               05  SPA-GMN-TENSIKIBETUCOB-G.
                   07  SPA-GMN-TENSIKIBETUCOB      PIC X(26)
                                                   OCCURS   7.
      *
               05  SPA-GMN-JGNTEN              PIC 9(7).
               05  SPA-GMN-OLDTEN              PIC 9(8)V9(2).
      *
               05  SPA-GMN-OLDTENSKB-G.
                   07  SPA-GMN-OLDTENSKB           PIC 9(1).
                   07  SPA-GMN-F1                  PIC X(1).
                   07  SPA-GMN-OLDTENSKBMEI        PIC X(20).
               05  SPA-GMN-OLDTENSKBCOB-G.
                   07  SPA-GMN-OLDTENSKBCOB        PIC X(26)
                                                   OCCURS   7.
      *
               05  SPA-GMN-TANICD-G.
                   07  SPA-GMN-TANICD              PIC X(3).
                   07  SPA-GMN-F3                  PIC X(1).
                   07  SPA-GMN-TANINAME            PIC X(26).
               05  SPA-GMN-TANICDCOB-G.
                   07  SPA-GMN-TANICDCOB           PIC X(30)
                                                   OCCURS   90.
      *
               05  SPA-GMN-TOKUKIZAIAGEKSNKBN-G.
                   07  SPA-GMN-TOKUKIZAIAGEKSNKBN  PIC 9(1).
                   07  SPA-GMN-F3                  PIC X(1).
                   07  SPA-GMN-TOKUIZAIMEI         PIC X(26).
               05  SPA-GMN-TOKUKIZAIAGEKSNCOB-G.
                   07  SPA-GMN-TOKUKIZAIAGEKSNCOB  PIC X(30)
                                                   OCCURS   2.
      *
               05  SPA-GMN-KGNAGE              PIC X(2).
               05  SPA-GMN-JGNAGE              PIC X(2).
      *
               05  SPA-GMN-MEIUSESKB-G.
                   07  SPA-GMN-MEIUSESKB           PIC 9(1).
                   07  SPA-GMN-F3                  PIC X(1).
                   07  SPA-GMN-MEIUSESKBMEI        PIC X(26).
               05  SPA-GMN-MEIUSESKBCOB-G.
                   07  SPA-GMN-MEIUSESKBCOB        PIC X(30)
                                                   OCCURS   2.
      *
               05  SPA-GMN-SANSOKBN-G.
                   07  SPA-GMN-SANSOKBN            PIC 9(1).
                   07  SPA-GMN-F3                  PIC X(1).
                   07  SPA-GMN-SANSOKBNMEI         PIC X(26).
               05  SPA-GMN-SANSOKBNCOB-G.
                   07  SPA-GMN-SANSOKBNCOB         PIC X(30)
                                                   OCCURS   2.
      *
               05  SPA-GMN-TOKUKIZAISBT1-G.
                   07  SPA-GMN-TOKUKIZAISBT1       PIC 9(1).
                   07  SPA-GMN-F3                  PIC X(1).
                   07  SPA-GMN-TOKUKIZAISBT1MEI    PIC X(26).
               05  SPA-GMN-TOKUKIZAISBT1COB-G.
                   07  SPA-GMN-TOKUKIZAISBT1COB    PIC X(30)
                                                   OCCURS   3.
      *
               05  SPA-GMN-TOKUKIZAISBT2-G.
                   07  SPA-GMN-TOKUKIZAISBT2       PIC 9(1).
                   07  SPA-GMN-F3                  PIC X(1).
                   07  SPA-GMN-TOKUKIZAISBT2MEI    PIC X(26).
               05  SPA-GMN-TOKUKIZAISBT2COB-G.
                   07  SPA-GMN-TOKUKIZAISBT2COB    PIC X(30)
                                                   OCCURS   3.
      *
               05  SPA-GMN-DATAKBN-G.
                   07  SPA-GMN-DATAKBN             PIC 9(1).
                   07  SPA-GMN-F3                  PIC X(1).
                   07  SPA-GMN-DATAKBNMEI          PIC X(14).
               05  SPA-GMN-DATAKBNCOB-G.
                   07  SPA-GMN-DATAKBNCOB          PIC X(16)
                                                   OCCURS   3.
      *
               05  SPA-GMN-KOUHYOJYUNNUM       PIC 9(9).
               05  SPA-GMN-INPCHKKBN           PIC 9(1).
               05  SPA-GMN-CUR                 PIC X(30).
      *
      *    第五画面内容
           03  SPA-NAI-AREA.
               05  SPA-NAI-YUKOSTYMD           PIC X(08).
               05  SPA-NAI-YUKOEDYMD           PIC X(08).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                           PIC 9(01).
           03  FLG-OK                            PIC 9(01).
      *
           03  FLG-TENSU                         PIC 9(01).
           03  FLG-TENSUPLUS                     PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR                           PIC 9(06).
           03  CNT-PAGE                          PIC 9(02).
           03  CNT-ERRCHK                        PIC 9(03).
           03  CNT-STRING                        PIC 9(03).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                               PIC 9(02).
           03  IDX-1                             PIC 9(02).
           03  IDX-2                             PIC 9(02).
           03  IDXX                              PIC 9(02).
           03  IDXY                              PIC 9(02).
           03  IDXZ                              PIC 9(02).
      *
      *    ワーク領域
       01  WRK-AREA.
           03  WRK-GMN-CUR                       PIC X(30).
           03  WRK-ZIDMSG                        PIC X(70).
           03  WRK-STRINGTBL.
               05  WRK-STRING                    PIC X(01)  OCCURS 200.
           03  WRK-LNKYMD                        PIC X(10).
           03  WRK-WYMD.
               05  WRK-WGO                       PIC X(01).
               05  WRK-WYY                       PIC 9(02).
               05  WRK-WMM                       PIC 9(02).
               05  WRK-WDD                       PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-YMD             PIC X(08).
           03  WRK-OTYMD           PIC X(08).
      *
           03  WRK-MAE-INPUT       PIC X(400).
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
      *    単位の項目順テーブル
           COPY    "CMTANICD.INC".
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *    点数マスタ付加コード
        01 TENSUPLUS-REC.
           COPY    "CPTENSUPLUS.INC".
      *    入力コード
        01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *----(01.00.01) LINE ADD START ----------------------------------
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *----(01.00.01) LINE ADD END   ----------------------------------
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
      *    連絡領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "Z01.INC".
           COPY    "Z02.INC".
           COPY    "Z03.INC".
           COPY    "Z04.INC".
           COPY    "Z05.INC".
           COPY    "Z06.INC".
           COPY    "Z90.INC".
           COPY    "Z91.INC".
           COPY    "Z97.INC".
           COPY    "Z98.INC".
           COPY    "Z99.INC".
           COPY    "ZERR.INC".
           COPY    "ZID1.INC".
           COPY    "ZID2.INC".
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
       000-PROC-SEC                              SECTION.
      *
           MOVE    SPA-COMMON                    TO  SPA-AREA.
           MOVE    SPA-WORK                      TO  SPA-Z01KYOUTU
           MOVE    SPA-FREE                      TO  SPA-Z01FREE
           MOVE    SPA-Z01SONOTA                 TO  SPA-Z05
      *
           MOVE    SPACE                         TO  SPA-ERRCD.
           MOVE    ZERO                          TO  FLG-END.
      *
           MOVE    SPACE                         TO  SPA-ERRCD.
           MOVE    ZERO                          TO  FLG-END.
      *
           EVALUATE    MCP-STATUS       ALSO    MCP-EVENT
               WHEN    "LINK"           ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI-SEC
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY-SEC
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END                       =   ZERO
               PERFORM 500-SET-SCREEN-SEC
           END-IF.
      *    
           MOVE    SPA-Z01KYOUTU                 TO  SPA-WORK
           MOVE    SPA-AREA                      TO  SPA-COMMON
           MOVE    SPA-Z05                       TO  SPA-Z01SONOTA 
           MOVE    SPA-Z01FREE                   TO  SPA-FREE
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                              SECTION.
      *
      *    DISPLAY "*** ORCSNPL    START  ***"
      *
           INITIALIZE                            FLG-AREA.
           INITIALIZE                            CNT-AREA.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "ZERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END         =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE  SPA-GMN-CUR           TO  MCP-WIDGET
      *
           MOVE    SPACE                         TO  LINKAREA.
      *
      ***  MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "Z05"                         TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           EVALUATE    SPA-MOTOPG
      *    更新処理
               WHEN    "ZID1"
                   PERFORM 330-ZID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
      *    入力ＣＤより
               WHEN    "Z99"
                   MOVE  "YUKOSTYMD"             TO  SPA-GMN-CUR
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
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *    点数マスタ該当データ読み出し
           INITIALIZE                            SPA-GMN-AREA
      *
           MOVE  SPA-Z01-SRYCD                   TO  SPA-GMN-SRYCDH
      *
           MOVE  SPA-Z01-YUKOSTYMD               TO  SPA-NAI-YUKOSTYMD
           IF  SPA-Z01-SYORIKBN                  =  2
               MOVE  SPA-Z01-YUKOSTYMDH          TO  SPA-GMN-YUKOSTYMDH
           END-IF
           MOVE  SPA-Z01-YUKOSTYMDH              TO  SPA-GMN-YUKOSTYMD
      *
           MOVE  SPA-Z01-YUKOEDYMD               TO  SPA-NAI-YUKOEDYMD
           IF  SPA-Z01-SYORIKBN                  =  2
                MOVE  SPA-Z01-YUKOEDYMDH         TO  SPA-GMN-YUKOEDYMDH
           END-IF
           MOVE  SPA-Z01-YUKOEDYMDH              TO  SPA-GMN-YUKOEDYMD
      *
           INITIALIZE                            TNS-TENSU-REC
           MOVE  SPA-Z01-SRYCD                   TO  TNS-SRYCD
      *****IF  SPA-Z01-SYORIKBN                  =   2
      *        MOVE  SPA-Z01-YUKOSTYMD           TO  TNS-YUKOSTYMD
      *        MOVE  SPA-Z01-YUKOEDYMD           TO  TNS-YUKOEDYMD
      *****ELSE
               IF  SPA-Z01-SELNUM                 =   ZERO
                   MOVE  ALL "9"                 TO  TNS-YUKOSTYMD
                   MOVE  ALL "9"                 TO  TNS-YUKOEDYMD
               ELSE
                   MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOSTYMD
                   MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOEDYMD
               END-IF
      *****END-IF
           PERFORM  811-TENSUSEL-SEC
      *
           IF  MCP-RC                            =   ZERO
               PERFORM  812-TENSUFET-SEC
               IF  MCP-RC                        =   ZERO
                   MOVE  MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
                   PERFORM 3001-TENSU-SET-SEC
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *    各リストボックス編集
           PERFORM 30012-COB-HEN-SEC
      *
      *****PERFORM  813-TENSUCLS-SEC
      *    点数マスタ付加情報検索
           IF      FLG-TENSU           =   ZERO
               MOVE    SPACE               TO  TENSUPLUS-REC
               MOVE    TNS-SRYCD           TO  TNSP-SRYCD
               MOVE    TNS-YUKOSTYMD       TO  TNSP-YUKOSTYMD
               MOVE    TNS-YUKOEDYMD       TO  TNSP-YUKOEDYMD
      *
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC               =   ZERO
                   MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
                   PERFORM 990-TENSUPLUS-READ-SEC
                   IF      FLG-TENSUPLUS       =   ZERO
                       MOVE    TNSP-INPCHKKBN  TO  SPA-GMN-INPCHKKBN
                   END-IF
               END-IF
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           END-IF
      *
      *
           MOVE  "YUKOSTYMD"             TO  SPA-GMN-CUR
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ情報をＳＰＡにセット
      *****************************************************************
       3001-TENSU-SET-SEC                     SECTION.
      *
           MOVE    TNS-NAME            TO  SPA-GMN-NAMEH
      *
           MOVE    TNS-KANANAME        TO  SPA-GMN-KANANAME
           MOVE    TNS-NAME            TO  SPA-GMN-NAME
           MOVE    TNS-FORMALNAME      TO  SPA-GMN-FORMALNAME
           MOVE    TNS-TEN             TO  SPA-GMN-TEN
           MOVE    TNS-TENSIKIBETU     TO  SPA-GMN-TENSIKIBETU
           MOVE    TNS-TENSIKIBETU     TO  SPA-GMN-TENSIKIBETU
           MOVE    TNS-JGNTEN          TO  SPA-GMN-JGNTEN
           MOVE    TNS-OLDTEN          TO  SPA-GMN-OLDTEN
           MOVE    TNS-OLDTENSKB       TO  SPA-GMN-OLDTENSKB
           MOVE    TNS-TANICD          TO  SPA-GMN-TANICD
           MOVE    TNS-TANINAME        TO  SPA-GMN-TANINAME
           MOVE    TNS-TOKUKIZAIAGEKSNKBN
                                       TO  SPA-GMN-TOKUKIZAIAGEKSNKBN
           MOVE    TNS-KGNAGE          TO  SPA-GMN-KGNAGE
           MOVE    TNS-JGNAGE          TO  SPA-GMN-JGNAGE
           MOVE    TNS-MEIUSESKB       TO  SPA-GMN-MEIUSESKB
           MOVE    TNS-SANSOKBN        TO  SPA-GMN-SANSOKBN
           MOVE    TNS-TOKUKIZAISBT1   TO  SPA-GMN-TOKUKIZAISBT1
           MOVE    TNS-TOKUKIZAISBT2   TO  SPA-GMN-TOKUKIZAISBT2
           MOVE    TNS-KOUHYOJYUNNUM   TO  SPA-GMN-KOUHYOJYUNNUM
           MOVE    TNS-DATAKBN         TO  SPA-GMN-DATAKBN  
      *
           .
       3001-TENSU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *   各リストボックス編集処理
      *****************************************************************
       30012-COB-HEN-SEC            SECTION.
      *
      *    データ区分
           MOVE    "0 なし"            TO  SPA-GMN-DATAKBNCOB (1)
           MOVE    "3 フィルム"        TO  SPA-GMN-DATAKBNCOB (2)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-DATAKBN     =   SPA-GMN-DATAKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-DATAKBNCOB (IDX)
                                           TO  SPA-GMN-DATAKBN-G
                   MOVE    2               TO  IDX
               END-IF
           END-PERFORM
      *    データ規格
           MOVE    1               TO  IDX-1
           MOVE    "000 "          TO  SPA-GMN-TANICDCOB(IDX-1)
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       MTANI-MAX
               ADD     1               TO  IDX-1
               MOVE    MTANI-TANICD  (IDX)
                                       TO  SPA-GMN-TANICDCOB(IDX-1)(1:3)
               MOVE    MTANI-TANINAME(IDX)
                                       TO  SPA-GMN-TANICDCOB(IDX-1)(5:)
           END-PERFORM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   90
               IF      SPA-GMN-TANICD     =   SPA-GMN-TANICDCOB
                                                         (IDX)(1:3)
                   MOVE    SPA-GMN-TANICDCOB (IDX)
                                           TO  SPA-GMN-TANICD-G
                   MOVE    90              TO  IDX
               END-IF
           END-PERFORM
      *
      *    点数識別
           MOVE    "0     "            TO  SPA-GMN-TENSIKIBETUCOB (1)
           MOVE    "1 金額"            TO  SPA-GMN-TENSIKIBETUCOB (2)
           MOVE    "2 都道府県購入価格"
                                       TO  SPA-GMN-TENSIKIBETUCOB (3)
           MOVE    "5 ％加算"          TO  SPA-GMN-TENSIKIBETUCOB (4)
           MOVE    "9 乗算割合"        TO  SPA-GMN-TENSIKIBETUCOB (5)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   7
               IF      SPA-GMN-TENSIKIBETU =   SPA-GMN-TENSIKIBETUCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-TENSIKIBETUCOB (IDX)
                                           TO  SPA-GMN-TENSIKIBETU-G
                   MOVE    7               TO  IDX
               END-IF
           END-PERFORM
      *
      *    旧点数識別
           MOVE    "0     "            TO  SPA-GMN-OLDTENSKBCOB (1)
           MOVE    "1 金額"            TO  SPA-GMN-OLDTENSKBCOB (2)
           MOVE    "2 都道府県購入価格"
                                       TO  SPA-GMN-OLDTENSKBCOB (3)
           MOVE    "5 ％加算"          TO  SPA-GMN-OLDTENSKBCOB (4)
           MOVE    "9 乗算割合"        TO  SPA-GMN-OLDTENSKBCOB (5)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      SPA-GMN-OLDTENSKB =   SPA-GMN-OLDTENSKBCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-OLDTENSKBCOB (IDX)
                                           TO  SPA-GMN-OLDTENSKB-G
                   MOVE    5               TO  IDX
               END-IF
           END-PERFORM
      *
      *    加算年齢
           MOVE    "0 年齢加算なし"    TO  SPA-GMN-TOKUKIZAIAGEKSNCOB(1)
           MOVE    "1 年齢加算あり"    TO  SPA-GMN-TOKUKIZAIAGEKSNCOB(2)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-TOKUKIZAIAGEKSNKBN
                                       =   SPA-GMN-TOKUKIZAIAGEKSNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-TOKUKIZAIAGEKSNCOB (IDX)
                                       TO  SPA-GMN-TOKUKIZAIAGEKSNKBN-G
                   MOVE    2               TO  IDX
               END-IF
           END-PERFORM
      *    名称識別
           MOVE    "0 通常"            TO  SPA-GMN-MEIUSESKBCOB(1)
           MOVE    "1 医療機関登録"    TO  SPA-GMN-MEIUSESKBCOB(2)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-MEIUSESKB
                                       =   SPA-GMN-MEIUSESKBCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-MEIUSESKBCOB (IDX)
                                       TO  SPA-GMN-MEIUSESKB-G
                   MOVE    2               TO  IDX
               END-IF
           END-PERFORM
      *
      *    酸素
           MOVE    "0 酸素、窒素以外"
                                     TO  SPA-GMN-SANSOKBNCOB (1)
           MOVE    "1 酸素、窒素に係わるもの"
                                     TO  SPA-GMN-SANSOKBNCOB (2)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               IF      SPA-GMN-SANSOKBN    =   SPA-GMN-SANSOKBNCOB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-SANSOKBNCOB (IDX)
                                           TO  SPA-GMN-SANSOKBN-G
                   MOVE    2               TO  IDX
               END-IF
           END-PERFORM
      *
      *    特定器材１
           MOVE    "0 通常"
                                         TO  SPA-GMN-TOKUKIZAISBT1COB(1)
           MOVE    "2 酸素"
                                         TO  SPA-GMN-TOKUKIZAISBT1COB(2)
           MOVE    "3 高線量率イリジウム"
                                         TO  SPA-GMN-TOKUKIZAISBT1COB(3)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               IF      SPA-GMN-TOKUKIZAISBT1
                                           =   SPA-GMN-TOKUKIZAISBT1COB
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-TOKUKIZAISBT1COB (IDX)
                                           TO  SPA-GMN-TOKUKIZAISBT1-G
                   MOVE    3               TO  IDX
               END-IF
           END-PERFORM
      *
      *    特定器材２
           MOVE    "0 通常"            TO  SPA-GMN-TOKUKIZAISBT2COB (1)
           MOVE    SPA-GMN-TOKUKIZAISBT2COB (1)
                                       TO  SPA-GMN-TOKUKIZAISBT2-G
           .
      *
       30012-COB-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-ZID1-SET-SEC            SECTION.
      *
           IF      SPA-ZID1-FLG    =   "OK"
               IF      SPA-ZIDCD            =   "0001"
                   PERFORM  4031-DEL-SEC
               ELSE
                   PERFORM  4121-TOUROKU-SEC
               END-IF
           END-IF
      *
           IF      SPA-ERRCD       NOT =  SPACE
               PERFORM 510-ERRSET-SEC
           END-IF
      *
           MOVE    SPACE           TO  SPA-ZID1-FLG
           MOVE    SPACE           TO  SPA-ZIDCD      
           .
       330-ZID1-SET-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI-SEC                           SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE  "CHANGE"      TO  MCP-PUTTYPE
                   PERFORM  401-BACK-SEC
      *        削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM  403-DEL-SEC
      *        入力コード設定
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM  405-INPUTCD-SEC
      *        確定
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM  412-TOUROKU-SEC
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY-SEC                             SECTION.
      *
           IF  MCP-EVENT                         =  "ACTIVATE"
               MOVE  ZERO                        TO  CNT-ERRCHK
               PERFORM  500-ERRCHK-SEC
           END-IF
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       401-BACK-SEC                              SECTION.
      *
           MOVE  "Z01"                           TO  SPA-SAKIPG.
      *
           MOVE  "Z05"                           TO  SPA-MOTOPG.
      *
      ***  MOVE  "CHANGE"                        TO  MCP-PUTTYPE.
           MOVE  SPA-SAKIPG                      TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       401-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                               SECTION.
      *
           MOVE    "0001"              TO  SPA-ZIDCD
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
      *
           MOVE    SPA-Z01-SRYCD       TO  TNS-SRYCD
           MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOSTYMD
           MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOEDYMD
           PERFORM  816-TENSUDEL-SEC
           IF     MCP-RC               NOT =   ZERO
               DISPLAY "TNS DEL ERR!!"
               MOVE    "0015"                TO  SPA-ERRCD
               GO      TO      4031-DEL-EXT
           END-IF
      *
      *    点数付加情報削除
           MOVE    SPA-Z01-SRYCD       TO  TNSP-SRYCD
           MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOSTYMD
           MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                       TO  TNSP-YUKOEDYMD
           MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    入力コード削除
           IF     (SPA-Z01-SELNUM      =   1    )  AND
                  (SPA-Z01-MAX         =   1    )
               MOVE  SPA-HOSPID                  TO  ICD-HOSPID
               MOVE  SPA-Z01-SRYCD               TO  ICD-SRYCD
               MOVE  INPUTCD-REC                 TO  MCPDATA-REC
               MOVE  "DBDELETE"                  TO  MCP-FUNC
               MOVE  "INPUTCD-KEY4"              TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
           END-IF
      *
           MOVE  "JOIN"      TO  MCP-PUTTYPE
           PERFORM  401-BACK-SEC
           .
       4031-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コード　設定処理
      *****************************************************************
       405-INPUTCD-SEC                              SECTION.
      *
      *
           MOVE    SPA-Z01KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-Z05             TO  SPA-Z01SONOTA
           MOVE    SPA-Z01FREE         TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGZ99"           USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA
      *
           MOVE    SPA-COMMON          TO  SPA-AREA
           MOVE    SPA-WORK            TO  SPA-Z01KYOUTU
           MOVE    SPA-FREE            TO  SPA-Z01FREE
           MOVE    SPA-Z01SONOTA       TO  SPA-Z05
      *
      *    初期カーソル
           MOVE    "INPUTCD01"         TO  MCP-WIDGET
      *
           MOVE    "Z99"               TO  SPA-SAKIPG.
           MOVE    "Z05"               TO  SPA-MOTOPG.
      *
           MOVE    SPA-MOTOPG          TO  SPA-Z99GMN-MOTOPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                             TO  FLG-END.
       405-INPUTCD-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       412-TOUROKU-SEC                           SECTION.
      *    エラーチェック
           MOVE    SPA-GMN-CUR                   TO  WRK-GMN-CUR 
           PERFORM  VARYING  CNT-ERRCHK
                    FROM  1  BY  1  UNTIL  CNT-ERRCHK  >  23
               PERFORM  500-ERRCHK-SEC
               IF  SPA-ERRCD                 NOT =  SPACE
                   GO                            TO  412-TOUROKU-EXT
               END-IF
           END-PERFORM
           IF  SPA-ERRCD                     =  SPACE
               MOVE  "B12"                   TO  MCP-WIDGET
               MOVE  WRK-GMN-CUR             TO  SPA-GMN-CUR    
           END-IF
      *
           IF  SPA-GMN-YUKOSTYMD               =  SPACE  OR
               SPA-GMN-YUKOEDYMD               =  SPACE
               MOVE    "YUKOSTYMD"               TO  SPA-GMN-CUR
               MOVE    "0005"                    TO  SPA-ERRCD
               GO                                TO  412-TOUROKU-EXT
           END-IF
      *
           IF  SPA-NAI-YUKOSTYMD               >= SPA-NAI-YUKOEDYMD
               MOVE    "YUKOSTYMD"               TO  SPA-GMN-CUR
               MOVE    "0005"                    TO  SPA-ERRCD
               GO                                TO  412-TOUROKU-EXT
           END-IF
      *
      *    有効期限範囲チェック
           IF      SPA-Z01-SYORIKBN    =   2
      *        前チェック
               IF      SPA-Z01-SELNUM      >   1
                   MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM - 1)
                                           TO  WRK-YMD
      *            対象日＋１日
                   PERFORM 800-DAYSET-SEC
                   IF      SPA-NAI-YUKOSTYMD   NOT =   WRK-OTYMD
                       MOVE    "YUKOSTYMD"         TO  SPA-GMN-CUR
                       MOVE    "0011"              TO  SPA-ERRCD
                       GO      TO      412-TOUROKU-EXT
                   END-IF
               END-IF
      *        後チェック
               IF      SPA-Z01-SELNUM      <   SPA-Z01-MAX
                   MOVE    SPA-NAI-YUKOEDYMD
                                           TO  WRK-YMD
      *            対象日＋１日
                   PERFORM 800-DAYSET-SEC
                   IF      SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM + 1)
                                               NOT =   WRK-OTYMD
                       MOVE    "YUKOEDYMD"         TO  SPA-GMN-CUR
                       MOVE    "0011"              TO  SPA-ERRCD
                       GO      TO      412-TOUROKU-EXT
                   END-IF
               END-IF
           END-IF
      *
      *
           IF  SPA-Z01-SYORIKBN                  =  3
               IF  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM) >=
                   SPA-NAI-YUKOSTYMD
                   MOVE    "YUKOSTYMD"           TO  SPA-GMN-CUR
                   MOVE    "0008"                TO  SPA-ERRCD
                   GO                            TO  412-TOUROKU-EXT
               END-IF
      *
               IF  SPA-NAI-YUKOEDYMD    NOT    =  99999999
                   MOVE    "YUKOEDYMD"           TO  SPA-GMN-CUR
                   MOVE    "0010"                TO  SPA-ERRCD
                   GO                            TO  412-TOUROKU-EXT
               END-IF
           END-IF
      *
           IF  SPA-GMN-NAME                    =  SPACE
               MOVE    "NAME"                    TO  SPA-GMN-CUR
               MOVE    "0001"                    TO  SPA-ERRCD
               GO                                TO  412-TOUROKU-EXT
           END-IF
      *
           MOVE    "0002"                        TO  SPA-ZIDCD
           .    
       412-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       4121-TOUROKU-SEC                          SECTION.
      *
      *
      *    改正時処理
           IF  SPA-Z01-SYORIKBN                  =  3
      *
      *        データＵＰＤＡＴＥ
               INITIALIZE                        TNS-TENSU-REC
      *
               MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
               MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOSTYMD
               MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOEDYMD
               PERFORM  811-TENSUSEL-SEC
      *
               IF  MCP-RC                        =   ZERO
                   PERFORM  812-TENSUFET-SEC
                   IF  MCP-RC                    =   ZERO
                       MOVE  MCPDATA-REC         TO  TNS-TENSU-REC
                       MOVE  SPA-NAI-YUKOSTYMD TO  WRK-LNKYMD
                       PERFORM  833-YMDCONV61-SEC
                       IF  STS-DAY-RC1            =  ZERO
                           MOVE  WRK-SYMD        TO  TNS-YUKOEDYMD
                       ELSE
                           MOVE    "YUKOSTYMD"   TO  SPA-GMN-CUR
                           MOVE    "0004"        TO  SPA-ERRCD
                          GO                     TO  4121-TOUROKU-EXT
                       END-IF
                       MOVE  SPA-Z01-SRYCD       TO  TNSUP-SRYCD
                       MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOSTYMD
                       MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOEDYMD
                       PERFORM  815-TENSUUPD-SEC
                       IF  MCP-RC          NOT   =   ZERO
                           MOVE    "B12"         TO  SPA-GMN-CUR
                           MOVE    "0009"        TO  SPA-ERRCD
                           PERFORM  813-TENSUCLS-SEC
                           GO                    TO  4121-TOUROKU-EXT
                       END-IF
                   ELSE
                       MOVE    "B12"             TO  SPA-GMN-CUR
                       MOVE    "0009"            TO  SPA-ERRCD
                       PERFORM  813-TENSUCLS-SEC
                       GO                        TO  4121-TOUROKU-EXT
                   END-IF
               ELSE
                   MOVE    "B12"                 TO  SPA-GMN-CUR
                   MOVE    "0009"                TO  SPA-ERRCD
                   PERFORM  813-TENSUCLS-SEC
                   GO                            TO  4121-TOUROKU-EXT
               END-IF
               PERFORM  813-TENSUCLS-SEC
           END-IF
      *
      *　  登録処理
           IF  SPA-Z01-SYORIKBN                  =  2
      *        データＵＰＤＡＴＥ
               INITIALIZE                        TNS-TENSU-REC
      *
               MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
               MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOSTYMD
               MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNS-YUKOEDYMD
               PERFORM  811-TENSUSEL-SEC
      *
               IF  MCP-RC                        =   ZERO
                   PERFORM  812-TENSUFET-SEC
                   IF  MCP-RC                    =   ZERO
                       MOVE  MCPDATA-REC         TO  TNS-TENSU-REC
                       MOVE  SPA-NAI-YUKOSTYMD TO  TNS-YUKOSTYMD
                       MOVE  SPA-NAI-YUKOEDYMD TO  TNS-YUKOEDYMD
                       PERFORM  4121-KOUMOKUISO-SEC
                       MOVE  SPA-Z01-SRYCD       TO  TNSUP-SRYCD
                       MOVE  SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOSTYMD
                       MOVE  SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                 TO  TNSUP-YUKOEDYMD
                       PERFORM  815-TENSUUPD-SEC
                       IF  MCP-RC          NOT   =   ZERO
                           MOVE    "B12"         TO  SPA-GMN-CUR
                           MOVE    "0009"        TO  SPA-ERRCD
                           PERFORM  813-TENSUCLS-SEC
                           GO                    TO  4121-TOUROKU-EXT
                       END-IF
                   ELSE
                       MOVE    "B12"             TO  SPA-GMN-CUR
                       MOVE    "0009"            TO  SPA-ERRCD
                       PERFORM  813-TENSUCLS-SEC
                       GO                        TO  4121-TOUROKU-EXT
                   END-IF
               ELSE
                   MOVE    "B12"                 TO  SPA-GMN-CUR
                   MOVE    "0009"                TO  SPA-ERRCD
                   PERFORM  813-TENSUCLS-SEC
                   GO                            TO  4121-TOUROKU-EXT
               END-IF
               PERFORM  813-TENSUCLS-SEC
           ELSE
      *        データＩＮＳＥＲＴ
               INITIALIZE                        TNS-TENSU-REC
               MOVE  SPA-Z01-SRYCD               TO  TNS-SRYCD
               MOVE  SPA-NAI-YUKOSTYMD         TO  TNS-YUKOSTYMD
               MOVE  SPA-NAI-YUKOEDYMD         TO  TNS-YUKOEDYMD
               PERFORM  4121-KOUMOKUISO-SEC
               PERFORM  814-TENSUINS-SEC
               IF  MCP-RC                   NOT  =   ZERO
                   MOVE    "B12"                 TO  SPA-GMN-CUR
                   MOVE    "0009"                TO  SPA-ERRCD
                   GO                            TO  4121-TOUROKU-EXT
               END-IF
           END-IF
           IF      SPA-ERRCD                   NOT =   SPACE
               GO                            TO  4121-TOUROKU-EXT
           END-IF
      *
      *    点数マスタ付加情報更新
           PERFORM 4129-TENSUPLUS-UPD-SEC
      *
      *  入力コード更新
           CALL    "ORCGZS01"                    USING
                                                 MCPAREA
                                                 SPAAREA
           IF      SPA-ERRCD                   NOT =   SPACE
               GO                            TO  4121-TOUROKU-EXT
           END-IF
      *  前画面に戻る
           MOVE  "JOIN"      TO  MCP-PUTTYPE
           PERFORM  401-BACK-SEC
           .
       4121-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       4121-KOUMOKUISO-SEC                       SECTION.
      *
           MOVE  SPA-GMN-KANANAME          TO  TNS-KANANAME
                                               WRK-STRINGTBL
           MOVE  100                       TO  CNT-STRING
           PERFORM  891-STRCOUNT-SEC
           MOVE  CNT-STRING                TO  TNS-KANAYUKOKETA
      *
           MOVE  SPA-GMN-NAME              TO  TNS-NAME
                                               WRK-STRINGTBL
           MOVE  100                       TO  CNT-STRING
           PERFORM  891-STRCOUNT-SEC
           MOVE  CNT-STRING                TO  TNS-YUKOKETA
      *
           MOVE  SPA-GMN-FORMALNAME        TO  TNS-FORMALNAME
                                               WRK-STRINGTBL
           MOVE  200                       TO  CNT-STRING
           PERFORM  891-STRCOUNT-SEC
           MOVE  CNT-STRING                TO  TNS-FORMALYUKOKETA
      *
           MOVE  SPA-GMN-TEN               TO  TNS-TEN
           MOVE  SPA-GMN-TENSIKIBETU       TO  TNS-TENSIKIBETU
           MOVE  SPA-GMN-JGNTEN            TO  TNS-JGNTEN
           MOVE  SPA-GMN-OLDTEN            TO  TNS-OLDTEN
           MOVE  SPA-GMN-OLDTENSKB         TO  TNS-OLDTENSKB
           MOVE  SPA-GMN-TANICD            TO  TNS-TANICD
           MOVE  SPA-GMN-TANINAME          TO  TNS-TANINAME
           MOVE  SPA-GMN-TOKUKIZAIAGEKSNKBN
                                           TO  TNS-TOKUKIZAIAGEKSNKBN
           MOVE  SPA-GMN-KGNAGE            TO  TNS-KGNAGE
           MOVE  SPA-GMN-JGNAGE            TO  TNS-JGNAGE
           MOVE  SPA-GMN-MEIUSESKB         TO  TNS-MEIUSESKB
           MOVE  SPA-GMN-SANSOKBN          TO  TNS-SANSOKBN
           MOVE  SPA-GMN-TOKUKIZAISBT1     TO  TNS-TOKUKIZAISBT1
           MOVE  SPA-GMN-TOKUKIZAISBT2     TO  TNS-TOKUKIZAISBT2
           MOVE  SPA-GMN-KOUHYOJYUNNUM     TO  TNS-KOUHYOJYUNNUM
           MOVE  SPA-GMN-DATAKBN           TO  TNS-DATAKBN  
           .
       4121-KOUMOKUISO-EXT.
           EXIT.
      *
      *****************************************************************
      *     点数マスタ付加情報更新処理
      *****************************************************************
       4129-TENSUPLUS-UPD-SEC                       SECTION.
      *
      *    点数マスタ付加情報検索
           IF      SPA-Z01-SYORIKBN    =   2  OR  3
               MOVE    SPACE               TO  TENSUPLUS-REC
               MOVE    SPA-Z01-SRYCD       TO  TNSP-SRYCD
               MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                           TO  TNSP-YUKOSTYMD
               MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                           TO  TNSP-YUKOEDYMD
      *
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC               =   ZERO
                   MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
                   PERFORM 990-TENSUPLUS-READ-SEC
               ELSE
                   MOVE    1               TO  FLG-TENSUPLUS
               END-IF
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           END-IF
      *
      *    有効期限更新
           IF      FLG-TENSUPLUS       =   ZERO
               EVALUATE    SPA-Z01-SYORIKBN
                   WHEN    3
      *                改正時処理
                       MOVE    WRK-SYMD            TO  TNSP-YUKOEDYMD
      *
                       MOVE    SPA-Z01-SRYCD       TO  TNSPUP-SRYCD
                       MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOSTYMD
                       MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOEDYMD
                       MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "TENSUPLUS-UPD1"    TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC           NOT =   ZERO
                           MOVE    "0016"          TO  SPA-ERRCD
                           GO      TO      4129-TENSUPLUS-UPD-EXT
                       END-IF
                   WHEN    2
      *                更新時処理
                       MOVE    SPA-NAI-YUKOSTYMD   TO  TNSP-YUKOSTYMD
                       MOVE    SPA-NAI-YUKOEDYMD   TO  TNSP-YUKOEDYMD
                       PERFORM 41291-TENSUPLUS-HEN-SEC
      *
                       MOVE    SPA-Z01-SRYCD       TO  TNSPUP-SRYCD
                       MOVE    SPA-Z01-TYUKOSTYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOSTYMD
                       MOVE    SPA-Z01-TYUKOEDYMD(SPA-Z01-SELNUM)
                                                   TO  TNSPUP-YUKOEDYMD
                       MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "TENSUPLUS-UPD1"    TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC           NOT =   ZERO
                           MOVE    "0016"          TO  SPA-ERRCD
                           GO      TO      4129-TENSUPLUS-UPD-EXT
                       END-IF
               END-EVALUATE
           END-IF
      *
      *    新規追加
           IF     (FLG-TENSUPLUS       =   1   )  OR
                  (SPA-Z01-SYORIKBN    =   3  OR  1 )
               INITIALIZE                      TENSUPLUS-REC
               MOVE    SPA-Z01-SRYCD       TO  TNSP-SRYCD
               MOVE    SPA-NAI-YUKOSTYMD   TO  TNSP-YUKOSTYMD
               MOVE    SPA-NAI-YUKOEDYMD   TO  TNSP-YUKOEDYMD
               PERFORM 41291-TENSUPLUS-HEN-SEC
               MOVE    TENSUPLUS-REC       TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "TENSUPLUS-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC             NOT  =   ZERO
                   MOVE    "B12"          TO  SPA-GMN-CUR
                   MOVE    "0016"         TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       4129-TENSUPLUS-UPD-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *  点数マスタ付加情報編集
      *****************************************************************
       41291-TENSUPLUS-HEN-SEC          SECTION.
      *
      *
           MOVE    SPA-GMN-INPCHKKBN       TO  TNSP-INPCHKKBN
           .
       41291-TENSUPLUS-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *  　項目別エラーチェック
      *****************************************************************
       500-ERRCHK-SEC                            SECTION.
      *
           EVALUATE  TRUE
      *        有効開始年月日チェック
               WHEN  MCP-WIDGET = "YUKOSTYMD"    OR CNT-ERRCHK = 1
                   PERFORM  501-YUKOSTYMDCHK-SEC
      *        有効終了年月日チェック
               WHEN  MCP-WIDGET = "YUKOEDYMD"    OR CNT-ERRCHK = 2
                   PERFORM  502-YUKOEDYMDCHK-SEC
      *        カナ名称チェック
               WHEN  MCP-WIDGET = "KANANAME"     OR CNT-ERRCHK = 3
                   MOVE    "NAME"              TO  SPA-GMN-CUR
                   MOVE    Z05-KANANAME        TO  SPA-GMN-KANANAME
                   MOVE    SPA-GMN-KANANAME    TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       MOVE    "KANANAME"          TO  SPA-GMN-CUR
                   END-IF
      *        名称チェック
               WHEN  MCP-WIDGET = "NAME"         OR CNT-ERRCHK = 4
      *************MOVE  "TEN"                   TO  SPA-GMN-CUR
                   MOVE    "FORMALNAME"        TO  SPA-GMN-CUR
                   MOVE    Z05-NAME            TO  SPA-GMN-NAME
                   MOVE    SPA-GMN-NAME        TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       MOVE    "NAME"          TO  SPA-GMN-CUR
                   END-IF
      *        正式名称
               WHEN  MCP-WIDGET = "FORMALNAME"   OR CNT-ERRCHK = 21
                   MOVE    "TEN"               TO  SPA-GMN-CUR
                   MOVE    Z05-FORMALNAME      TO  SPA-GMN-FORMALNAME
                   MOVE    SPA-GMN-FORMALNAME  TO  WRK-MAE-INPUT
                   PERFORM 400-ZENCHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       MOVE    "FORMALNAME"        TO  SPA-GMN-CUR
                   END-IF
      *        金額
               WHEN  MCP-WIDGET = "TEN"          OR CNT-ERRCHK = 5
                   MOVE  "TENSIKIBETU"           TO  SPA-GMN-CUR
                   MOVE  Z05-TEN                 TO  SPA-GMN-TEN
      *        金額種別
               WHEN  MCP-WIDGET = "TENSIKIBETU"  OR CNT-ERRCHK = 6
                   MOVE  "JGNTEN"            TO  SPA-GMN-CUR
                   MOVE  Z05-TENSIKIBETU     TO  SPA-GMN-TENSIKIBETU-G
      *        上限点数
               WHEN  MCP-WIDGET = "JGNTEN"       OR CNT-ERRCHK = 7
                   MOVE  "OLDTEN"                TO  SPA-GMN-CUR
                   MOVE  Z05-JGNTEN              TO  SPA-GMN-JGNTEN
      *        旧金額
               WHEN  MCP-WIDGET = "OLDTEN"       OR CNT-ERRCHK = 8
                   MOVE  "OLDTENSKB"             TO  SPA-GMN-CUR
                   MOVE  Z05-OLDTEN              TO  SPA-GMN-OLDTEN
      *        旧金額種別
               WHEN  MCP-WIDGET = "OLDTENSKB"    OR CNT-ERRCHK = 9
                   MOVE  "TANICD"                TO  SPA-GMN-CUR
                   MOVE  Z05-OLDTENSKB           TO  SPA-GMN-OLDTENSKB-G
      *        単位コード
               WHEN  MCP-WIDGET = "TANICD"       OR CNT-ERRCHK = 10
                   PERFORM 5012-TANICD-CHK-SEC
      *        単位名称
      *        WHEN  MCP-WIDGET = "TANINAME"     OR CNT-ERRCHK = 20
      *            MOVE  "DATAKBN"               TO  SPA-GMN-CUR
      *            MOVE  Z05-TANINAME            TO  SPA-GMN-TANINAME
      *        データ区分
               WHEN  MCP-WIDGET = "DATAKBN"      OR CNT-ERRCHK = 19
                   MOVE  "TOKUKIZAIAGEKSNKBN"    TO  SPA-GMN-CUR
                   MOVE  Z05-DATAKBN             TO  SPA-GMN-DATAKBN-G
      *        年齢加算
               WHEN  MCP-WIDGET = "TOKUKIZAIAGEKSNKBN"
                                                 OR CNT-ERRCHK = 11
                   MOVE  "KGNAGE"                TO  SPA-GMN-CUR
                   MOVE  Z05-TOKUKIZAIAGEKSNKBN  TO
                                         SPA-GMN-TOKUKIZAIAGEKSNKBN-G
      *        下限年齢
               WHEN  MCP-WIDGET = "KGNAGE"       OR CNT-ERRCHK = 12
                   MOVE  "JGNAGE"                TO  SPA-GMN-CUR
                   MOVE  Z05-KGNAGE              TO  SPA-GMN-KGNAGE
                   PERFORM 5002-KGNAGE-CHK-SEC
      *        上限年齢
               WHEN  MCP-WIDGET = "JGNAGE"       OR CNT-ERRCHK = 13
                   MOVE  "MEIUSESKB"             TO  SPA-GMN-CUR
                   MOVE  Z05-JGNAGE              TO  SPA-GMN-JGNAGE
                   PERFORM 5003-JGNAGE-CHK-SEC
      *        名称識別
               WHEN  MCP-WIDGET = "MEIUSESKB"    OR CNT-ERRCHK = 14
                   MOVE  "SANSOKBN"              TO  SPA-GMN-CUR
                   MOVE  Z05-MEIUSESKB           TO  SPA-GMN-MEIUSESKB-G
      *        酸素等
               WHEN  MCP-WIDGET = "SANSOKBN"     OR CNT-ERRCHK = 15
                   MOVE  "TOKUKIZAISBT1"         TO  SPA-GMN-CUR
                   MOVE  Z05-SANSOKBN            TO  SPA-GMN-SANSOKBN-G
      *        特定器材種別１
               WHEN  MCP-WIDGET = "TOKUKIZAISBT1"  OR CNT-ERRCHK = 16
                   MOVE  "TOKUKIZAISBT2"     TO  SPA-GMN-CUR
                   MOVE  Z05-TOKUKIZAISBT1   TO  SPA-GMN-TOKUKIZAISBT1-G
      *        特定器材種別２
               WHEN  MCP-WIDGET = "TOKUKIZAISBT2"  OR CNT-ERRCHK = 17
                   MOVE  "KOUHYOJYUNNUM"     TO  SPA-GMN-CUR
                   MOVE  Z05-TOKUKIZAISBT2   TO  SPA-GMN-TOKUKIZAISBT2-G
      *        公表順序番号
               WHEN  MCP-WIDGET = "KOUHYOJYUNNUM"  OR CNT-ERRCHK = 18
      *************MOVE  "B12"               TO  SPA-GMN-CUR
                   MOVE  "INPCHKKBN"         TO  SPA-GMN-CUR
                   MOVE  Z05-KOUHYOJYUNNUM   TO  SPA-GMN-KOUHYOJYUNNUM
      *        入力チェック区分
               WHEN  MCP-WIDGET = "INPCHKKBN"      OR CNT-ERRCHK = 23
                   MOVE  "B12"                   TO  SPA-GMN-CUR
                   MOVE  Z05-INPCHKKBN           TO  SPA-GMN-INPCHKKBN
       END-EVALUATE.
      *
       500-ERRCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    半角チェック処理
      *****************************************************************
       400-ZENCHK-SEC             SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-MAE-INPUT       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
      *        全角半角混在エラー
               MOVE    "0017"              TO  SPA-ERRCD
           END-IF
           .
      *
       400-ZENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　有効開始年月日チェック
      *****************************************************************
       501-YUKOSTYMDCHK-SEC                      SECTION.
      *
           MOVE  "YUKOSTYMD"             TO  SPA-GMN-CUR
           MOVE  Z05-YUKOSTYMD           TO  SPA-GMN-YUKOSTYMD
      *
           IF  SPA-GMN-YUKOSTYMD                 =  SPACE
               MOVE    "0000000"                 TO  SPA-GMN-YUKOSTYMD
           END-IF.
      *
           MOVE  SPA-GMN-YUKOSTYMD               TO  WRK-LNKYMD
           PERFORM  831-YMDCONV12-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-SYMD            TO  SPA-NAI-YUKOSTYMD
               MOVE    WRK-LNKYMD          TO  SPA-GMN-YUKOSTYMD
           ELSE
               GO      TO      501-YUKOSTYMDCHK-EXT
           END-IF
      *****IF  STS-DAY-RC1                       =  ZERO
      *         MOVE  WRK-SYMD                   TO  SPA-NAI-YUKOSTYMD
      *    ELSE
      *         MOVE    "0004"                   TO  SPA-ERRCD
      *         GO      TO      501-YUKOSTYMDCHK-EXT
      *    END-IF
      *
      *    MOVE  SPA-NAI-YUKOSTYMD               TO  WRK-LNKYMD
      *    PERFORM  832-YMDCONV21-SEC
      *****MOVE  WRK-HENYMDG                     TO  SPA-GMN-YUKOSTYMD
           MOVE  "YUKOEDYMD"             TO  SPA-GMN-CUR
           .
      *
       501-YUKOSTYMDCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　有効終了年月日チェック
      *****************************************************************
       502-YUKOEDYMDCHK-SEC                      SECTION.
      *
           MOVE  "YUKOEDYMD"             TO  SPA-GMN-CUR
           MOVE  Z05-YUKOEDYMD           TO  SPA-GMN-YUKOEDYMD
      *
           IF  SPA-GMN-YUKOEDYMD                 =  SPACE
               MOVE   "9999999"                  TO  SPA-GMN-YUKOEDYMD
           END-IF.
      *
           MOVE  SPA-GMN-YUKOEDYMD               TO  WRK-LNKYMD
           PERFORM  831-YMDCONV12-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-SYMD            TO  SPA-NAI-YUKOEDYMD
               MOVE    WRK-LNKYMD          TO  SPA-GMN-YUKOEDYMD
           ELSE
                GO      TO      502-YUKOEDYMDCHK-EXT
           END-IF
      *****IF  STS-DAY-RC1                       =  ZERO
      *        MOVE  WRK-SYMD                    TO  SPA-NAI-YUKOEDYMD
      *    ELSE
      *        MOVE    "0004"                    TO  SPA-ERRCD
      *        GO                                TO  502-YUKOEDYMDCHK-EXT
      *    END-IF
      *
      *    MOVE  SPA-NAI-YUKOEDYMD               TO  WRK-LNKYMD
      *    PERFORM  832-YMDCONV21-SEC
      *****MOVE  WRK-HENYMDG                     TO  SPA-GMN-YUKOEDYMD
           MOVE  "KANANAME"              TO  SPA-GMN-CUR
           .
      *
       502-YUKOEDYMDCHK-EXT.
           EXIT.
      *        
      *****************************************************************
      *  　単位コードチェック
      *****************************************************************
       5012-TANICD-CHK-SEC                      SECTION.
      *
           MOVE    "TANICD"            TO  SPA-GMN-CUR
           MOVE    Z05-TANICD          TO  SPA-GMN-TANICD-G
      *
           IF      SPA-GMN-TANICD      =   SPACE
               MOVE    ZERO            TO  SPA-GMN-TANICD
           END-IF
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN-TANICD      TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0002"                  TO  SPA-ERRCD
               GO      TO              5012-TANICD-CHK-EXT
           ELSE
               MOVE    SNUM-OUTEDT(13:3)       TO  SPA-GMN-TANICD
           END-IF
      *
      **** IF      SPA-GMN-TANICD      =   ZERO
      *        MOVE    SPACE               TO  SPA-GMN-TANINAME
      *        MOVE    "TANINAME"          TO  SPA-GMN-CUR
      *        GO      TO              5012-TANICD-CHK-EXT
      **** END-IF
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   90  )   OR
                              (FLG-OK  =   1   )
               IF      SPA-GMN-TANICD     =   SPA-GMN-TANICDCOB
                                                         (IDX)(1:3)
                   MOVE    SPA-GMN-TANICDCOB (IDX)
                                           TO  SPA-GMN-TANICD-G
                   MOVE    1               TO  FLG-OK
                   MOVE    90              TO  IDX
               END-IF
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "0013"              TO  SPA-ERRCD
           END-IF
           IF      SPA-ERRCD           =   SPACE
      *********MOVE    "TANINAME"          TO  SPA-GMN-CUR
               MOVE    "DATAKBN"           TO  SPA-GMN-CUR
           END-IF
           .
      *
       5012-TANICD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　下限年齢チェック
      *****************************************************************
       5002-KGNAGE-CHK-SEC                      SECTION.
      *
           IF      SPA-GMN-KGNAGE      =   SPACE
               MOVE    ZERO            TO  SPA-GMN-KGNAGE
           END-IF
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN-KGNAGE      TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0002"                  TO  SPA-ERRCD
               MOVE    "KGNAGE"                TO  SPA-GMN-CUR
           ELSE
               MOVE    SNUM-OUTEDT(14:2)       TO  SPA-GMN-KGNAGE
           END-IF
           .
      *
       5002-KGNAGE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　上限年齢チェック
      *****************************************************************
       5003-JGNAGE-CHK-SEC                      SECTION.
      *
           IF      SPA-GMN-JGNAGE      =   SPACE
               MOVE    ZERO            TO  SPA-GMN-JGNAGE
           END-IF
      *
           IF      SPA-GMN-JGNAGE      =   "AA"
               CONTINUE
           ELSE
               INITIALIZE                      ORCSNUMAREA
               MOVE    SPA-GMN-JGNAGE      TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                           ORCSNUMAREA
               IF     (SNUM-RC         NOT =   ZERO  )   OR
                      (SNUM-MINKBN     NOT =   SPACE )   OR
                      (SNUM-SYOKBN     NOT =   SPACE )
                   MOVE    "0002"              TO  SPA-ERRCD
                   MOVE    "JGNAGE"                TO  SPA-GMN-CUR
               ELSE
                   MOVE    SNUM-OUTEDT(14:2)       TO  SPA-GMN-JGNAGE
               END-IF
           END-IF
           .
      *
       5003-JGNAGE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN-SEC             SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-ZIDCD       NOT =   SPACE
               PERFORM 520-ZIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE  SPA-GMN-CUR           TO  MCP-WIDGET
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "Z05    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面セット処理
      *****************************************************************
       500-GMNHEN-SEC                            SECTION.
      *     画面ワークエリアにセット
           INITIALIZE                            Z05.
      *
           MOVE  SPA-GMN-SRYCDH                TO  Z05-SRYCDH
           MOVE  SPA-GMN-NAMEH                 TO  Z05-NAMEH
           MOVE  SPA-GMN-YUKOSTYMDH            TO  Z05-YUKOSTYMDH
           MOVE  SPA-GMN-YUKOEDYMDH            TO  Z05-YUKOEDYMDH
           MOVE  SPA-GMN-YUKOSTYMD             TO  Z05-YUKOSTYMD
           MOVE  SPA-GMN-YUKOEDYMD             TO  Z05-YUKOEDYMD
           MOVE  SPA-GMN-KANANAME              TO  Z05-KANANAME
           MOVE  SPA-GMN-NAME                  TO  Z05-NAME
           MOVE  SPA-GMN-FORMALNAME            TO  Z05-FORMALNAME
           MOVE  SPA-GMN-TEN                   TO  Z05-TEN
           MOVE  SPA-GMN-TENSIKIBETU-G         TO  Z05-TENSIKIBETU
           MOVE  SPA-GMN-JGNTEN                TO  Z05-JGNTEN
           MOVE  SPA-GMN-OLDTEN                TO  Z05-OLDTEN
           MOVE  SPA-GMN-OLDTENSKB-G           TO  Z05-OLDTENSKB
           MOVE  SPA-GMN-TANICD-G              TO  Z05-TANICD
     ******MOVE  SPA-GMN-TANINAME              TO  Z05-TANINAME
           MOVE  SPA-GMN-TOKUKIZAIAGEKSNKBN-G  TO
                                               Z05-TOKUKIZAIAGEKSNKBN
           MOVE  SPA-GMN-KGNAGE                TO  Z05-KGNAGE
           MOVE  SPA-GMN-JGNAGE                TO  Z05-JGNAGE
           MOVE  SPA-GMN-MEIUSESKB-G           TO  Z05-MEIUSESKB
           MOVE  SPA-GMN-SANSOKBN-G            TO  Z05-SANSOKBN
           MOVE  SPA-GMN-TOKUKIZAISBT1-G       TO  Z05-TOKUKIZAISBT1
           MOVE  SPA-GMN-TOKUKIZAISBT2-G       TO  Z05-TOKUKIZAISBT2
           MOVE  SPA-GMN-KOUHYOJYUNNUM         TO  Z05-KOUHYOJYUNNUM
           MOVE  SPA-GMN-DATAKBN-G             TO  Z05-DATAKBN
      *
           MOVE  SPA-GMN-INPCHKKBN             TO  Z05-INPCHKKBN
      *
      *    データ区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-DATAKBNCOB (IDX)
                                           TO  Z05-DATAKBN-ITEM (IDX)
               MOVE    IDX                 TO  Z05-DATAKBN-COUNT
           END-PERFORM
      *    データ規格
           MOVE    ZERO                TO  IDX-1
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   90
               IF      SPA-GMN-TANICDCOB (IDX) NOT =   SPACE
                   ADD     1               TO  IDX-1
                   MOVE    SPA-GMN-TANICDCOB (IDX)
                                           TO  Z05-TANICD-ITEM (IDX-1)
                   MOVE    IDX-1           TO  Z05-TANICD-COUNT
               END-IF
           END-PERFORM
      *    点数識別
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               MOVE    SPA-GMN-TENSIKIBETUCOB (IDX)
                                       TO  Z05-TENSIKIBETU-ITEM (IDX)
               MOVE    IDX             TO  Z05-TENSIKIBETU-COUNT
           END-PERFORM
      *     旧点数識別
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               MOVE    SPA-GMN-OLDTENSKBCOB (IDX)
                                           TO  Z05-OLDTENSKB-ITEM (IDX)
               MOVE    IDX                 TO  Z05-OLDTENSKB-COUNT
           END-PERFORM
      *
      *    加算年齢
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-TOKUKIZAIAGEKSNCOB (IDX)
                                           TO  Z05-TOKUKIZAIAGEKSN-ITEM
                                                                (IDX)
               MOVE    IDX                 TO  Z05-TOKUKIZAIAGEKSN-COUNT
           END-PERFORM
      *    名称識別
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-MEIUSESKBCOB (IDX)
                                           TO  Z05-MEIUSESKB-ITEM
                                                                (IDX)
               MOVE    IDX                 TO  Z05-MEIUSESKB-COUNT
           END-PERFORM
      *    加算年齢
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   2
               MOVE    SPA-GMN-SANSOKBNCOB (IDX)
                                           TO  Z05-SANSOKBN-ITEM
                                                                (IDX)
               MOVE    IDX                 TO  Z05-SANSOKBN-COUNT
           END-PERFORM
      *    特定器材１
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    SPA-GMN-TOKUKIZAISBT1COB (IDX)
                                           TO  Z05-TOKUKIZAISBT1-ITEM
                                                                (IDX)
               MOVE    IDX                 TO  Z05-TOKUKIZAISBT1-COUNT
           END-PERFORM
      *    特定器材１
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   1
               MOVE    SPA-GMN-TOKUKIZAISBT2COB (IDX)
                                           TO  Z05-TOKUKIZAISBT2-ITEM
                                                                (IDX)
               MOVE    IDX                 TO  Z05-TOKUKIZAISBT2-COUNT
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
      **     EVALUATE    SPA-GMN-CUR
      **          WHEN   1
      **              MOVE  "STYUKYMD"   TO  MCP-WIDGET
      **     END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示処理
      *****************************************************************
       510-ERRSET-SEC                            SECTION.
           MOVE    SPACE                         TO  SPA-ERRMSG.
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "漢字名称を入力してください"
                                                 TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "数字のみ入力可能です"
                                                 TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "　"
                                                 TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "投入された年月日に誤りがあります"
                                                 TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "年月日の大小関係に誤りがあります"
                                                 TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "有効年月日を入力してください"
                                                 TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "有効年月日が重複しています"
                                                 TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "登録処理が失敗しました"
                                                 TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "改正の終了年月日はＡＬＬ９のみ入力できます"
                                                 TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE    "単位がありません"
                                                 TO  SPA-ERRMSG
               WHEN    "0015"
                   MOVE    "削除処理が失敗しました"
                                                 TO  SPA-ERRMSG
               WHEN    "0016"
                   MOVE    "点数マスタ付加情報が更新できません"
                                                 TO  SPA-ERRMSG
                WHEN    "0017"
                   MOVE    "すべて全角で入力して下さい。"
                                                 TO  SPA-ERRMSG
          END-EVALUATE.
      *
           MOVE    SPACE                         TO  ZERR
           MOVE    SPA-ERRCD                     TO  ZERR-ERRCODE
           MOVE    SPA-ERRMSG                TO  ZERR-ERRMSG
      *
           MOVE    "Z05"                         TO  SPA-MOTOPG
           MOVE    "ZERR"                        TO  SPA-SAKIPG
      *
           MOVE    "NEW"                         TO  MCP-PUTTYPE
           MOVE    "ZERR"                        TO  MCP-WINDOW
           MOVE    "B01"                         TO  MCP-WIDGET
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                             TO  FLG-END    
           .
      *
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-ZIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-ZIDMSG
      *
           EVALUATE    SPA-ZIDCD
               WHEN    "0001"
                   MOVE    "削除します。よろしいですか？"
                                                       TO  WRK-ZIDMSG
               WHEN    "0002"
                   MOVE    "更新します。よろしいですか？"
                                                       TO  WRK-ZIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  ZID1
           MOVE    SPA-ZIDCD            TO  ZID1-ID1CODE
           MOVE    WRK-ZIDMSG           TO  ZID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "Z05"                TO  SPA-MOTOPG
           MOVE    "ZID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "ZID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-ZIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　処理
      *****************************************************************
      *
      *****************************************************************
      *    点数マスタＳＥＬＥＣＴ処理（診療行為、有効期間）
      *****************************************************************
       811-TENSUSEL-SEC                          SECTION.
               MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
               MOVE  TNS-YUKOSTYMD               TO  ORC-DBYMD
               MOVE  "DBSELECT"                  TO  MCP-FUNC
               MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
               CALL  "ORCMCPSUB"                  USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
           .
      *
       811-TENSUSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＦＥＴＣＨ処理（診療行為、有効期間）
      *****************************************************************
       812-TENSUFET-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBFETCH"                   TO  MCP-FUNC
           MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           .                                   
      *
       812-TENSUFET-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＣＬＯＳＥ処理（診療行為、有効期間）
      *****************************************************************
       813-TENSUCLS-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBCLOSE"                   TO  MCP-FUNC
           MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           .
      *
       813-TENSUCLS-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＩＮＳ処理
      *****************************************************************
       814-TENSUINS-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBINSERT"                  TO  MCP-FUNC
           MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           .
      *
       814-TENSUINS-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＵＰＤ処理
      *****************************************************************
       815-TENSUUPD-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBUPDATE"                  TO  MCP-FUNC
           MOVE  "TENSU-UPD1"                TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           .
      *
       815-TENSUUPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタＤＥＬ処理
      *****************************************************************
       816-TENSUDEL-SEC                          SECTION.
           MOVE  TNS-TENSU-REC               TO  MCPDATA-REC
           MOVE  "DBDELETE"                  TO  MCP-FUNC
           MOVE  "TENSU-KEY"                 TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           .
      *
       816-TENSUDEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ付加情報読込
      *****************************************************************
       990-TENSUPLUS-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TENSUPLUS-REC
               MOVE    ZERO            TO  FLG-TENSUPLUS
           ELSE
               INITIALIZE                  TENSUPLUS-REC
               MOVE    1               TO  FLG-TENSUPLUS
           END-IF
           .
      *
       990-TENSUPLUS-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    日付変換　処理
      *****************************************************************
      *****************************************************************
      *     対象日＋１日計算処理
      *****************************************************************
       800-DAYSET-SEC                  SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           EVALUATE    WRK-YMD
               WHEN    ZERO
                   MOVE    ZERO            TO  WRK-OTYMD
               WHEN    "99999999"
                   MOVE    ALL "9"         TO  WRK-OTYMD
               WHEN    OTHER
                   INITIALIZE                  STS-AREA-DAY
                   INITIALIZE                  LNK-DAY6-AREA
                   MOVE    "61"                TO  LNK-DAY6-IRAI
                   MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
                   MOVE    "1"                 TO  LNK-DAY6-ZOGENPTN
                   MOVE    1                   TO  LNK-DAY6-ZOGEN
                   CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                  MOVE    LNK-DAY6-KEISAN      TO  WRK-OTYMD
           END-EVALUATE
      *
           .
       800-DAYSET-EXT.
           EXIT.
      *
      *****************************************************************
      *   和暦年月日→西暦年月日（機能１２）
      *****************************************************************
       831-YMDCONV12-SEC                         SECTION.
      *
           INITIALIZE                            STS-AREA-DAY
           EVALUATE  WRK-LNKYMD(1:7)
               WHEN  ZERO
                   MOVE  ZERO                    TO  WRK-SYMD
               WHEN  "9999999"
                   MOVE  ALL "9"                 TO  WRK-SYMD
               WHEN  OTHER
      *
      *************IF  WRK-LNKYMD(1:7)           NOT NUMERIC
      *                MOVE    WRK-LNKYMD(1:1)   TO  WRK-WGO
      *                MOVE    WRK-LNKYMD(2:2)   TO  WRK-WYY
      *                MOVE    WRK-LNKYMD(5:2)   TO  WRK-WMM
      *                MOVE    WRK-LNKYMD(8:2)   TO  WRK-WDD
      *                INSPECT  WRK-WYMD  REPLACING   ALL " " BY  "0"
      *            ELSE
      *                MOVE    WRK-LNKYMD(1:7)   TO  WRK-WYMD
      *            END-IF
      *            INITIALIZE                    LNK-DAY1-AREA
      *            MOVE  "12"                    TO  LNK-DAY1-IRAI
      *            MOVE  ZERO                    TO  LNK-DAY1-YMD
      *            MOVE  WRK-WYMD                TO  LNK-DAY1-YMD(2:7)
      *            CALL  "ORCSDAY"               USING   STS-AREA-DAY
      *                                          LNK-DAY1-AREA
      *            IF      STS-DAY-RC1           =   ZERO
      *                MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
      *************END-IF
      *----(01.00.01) LINE ADD START --------------------------------
      *            日付画面チェックサブ
                   INITIALIZE                      ORCSGDAYAREA
                   MOVE    WRK-LNKYMD          TO  SGDAY-INDAY
                   CALL    "ORCSGDAY"          USING
                                               ORCSGDAYAREA
                   IF      SGDAY-RC            =   ZERO
                       MOVE    SGDAY-OTDAY         TO  WRK-LNKYMD
                       MOVE    SGDAY-SDAY          TO  WRK-SYMD
                   ELSE
                       MOVE    "0004"              TO  SPA-ERRCD
                   END-IF
      *----(01.00.01) LINE ADD END   --------------------------------
           END-EVALUATE
           .
      *
       831-YMDCONV12-EXT.
           EXIT.
      *
      *****************************************************************
      *   西暦→和暦（機能２１）
      *****************************************************************
       832-YMDCONV21-SEC                          SECTION.
      *
      *
           INITIALIZE                            STS-AREA-DAY
           EVALUATE  WRK-LNKYMD(1:8)
               WHEN  ZERO 
               WHEN  "99999999"
                   MOVE    WRK-LNKYMD            TO  WRK-HENYMDG
               WHEN  OTHER
                  INITIALIZE                     STS-AREA-DAY
                  INITIALIZE                     LNK-DAY2-AREA
                  MOVE  "21"                     TO  LNK-DAY2-IRAI
                  MOVE  WRK-LNKYMD(1:8)          TO  LNK-DAY2-YMD
                  CALL  "ORCSDAY"                USING   STS-AREA-DAY
                                                 LNK-DAY2-AREA
                  MOVE    LNK-DAY2-EDTYMD1       TO  WRK-HENYMDG
           END-EVALUATE
           .
      *
       832-YMDCONV21-EXT.
           EXIT.
      *
      *****************************************************************
      *   西暦→日数１日マイナス（機能６１）
      *****************************************************************
       833-YMDCONV61-SEC                          SECTION.
      *
           INITIALIZE                            STS-AREA-DAY
           EVALUATE  WRK-LNKYMD(1:8)
               WHEN  ZERO
                   MOVE  ZERO                    TO  WRK-SYMD
               WHEN  "99999999"
                   MOVE  ALL "9"                 TO  WRK-SYMD
               WHEN  OTHER
                  INITIALIZE                     STS-AREA-DAY
                  INITIALIZE                     LNK-DAY6-AREA
                  MOVE  "61"                     TO  LNK-DAY6-IRAI
                  MOVE  WRK-LNKYMD(1:8)          TO  LNK-DAY6-KIJUN
                  MOVE  "1"                      TO  LNK-DAY6-ZOGENPTN
                  MOVE  -1                       TO  LNK-DAY6-ZOGEN
                  CALL  "ORCSDAY"                USING   STS-AREA-DAY
                                                 LNK-DAY6-AREA
                  MOVE    LNK-DAY6-KEISAN        TO  WRK-SYMD
           END-EVALUATE
           .
      *
       833-YMDCONV61-EXT.
           EXIT.
      *
      *****************************************************************
      *   文字数カウント処理（全角のみ）
      *****************************************************************
       891-STRCOUNT-SEC                         SECTION.
      *
           PERFORM  UNTIL  WRK-STRING(CNT-STRING)  NOT  =  SPACE
                    OR  CNT-STRING  =  1
               COMPUTE  CNT-STRING  =  CNT-STRING  -  1
           END-PERFORM
      *
           IF  CNT-STRING                        =  1
               MOVE  ZERO                        TO  CNT-STRING
           ELSE
               COMPUTE  CNT-STRING               =  CNT-STRING  /  2
           END-IF
           .
       891-STRCOUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW                            SECTION.
      *
           MOVE   "PUTWINDOW"                    TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                     USING  MCPAREA
                                                         ORCMCPAREA
                                                         MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
