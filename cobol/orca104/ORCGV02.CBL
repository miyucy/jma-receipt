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
       PROGRAM-ID.             ORCGV02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 保険番号情報入力
      *  コンポーネント名  : 保険番号情報入力（Ｖ０２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.00.02    MCC-藤原     01/10/09  削除の追加      
      *  01.00.03    MCC-藤原     01/11/14  項目をコンボボックスに変更      
      *  01.00.04    MCC-藤原     02/03/13  負担区分の追加      
      *  01.00.05    MCC-藤原     02/03/22  保険番号マスタの読込みの修正     
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
           COPY    "V01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-V02.
           03  SPA-V02-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(03).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD       PIC X(09).
                   07  SPA-GMN-EDYUKYMD       PIC X(09).
                   07  SPA-GMN-HKNNUM         PIC X(03).
                   07  SPA-GMN-PAYKBN         PIC X(02).
                   07  SPA-GMN-PAGENO         PIC 9(01).
      *             
                   07  SPA-GMN-GAIFTNKBNLST   OCCURS  4.
                       09  SPA-GMN-GAIFTNKBNL PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-GAIFTNKBNMEIL
                                              PIC X(20).
                   07  SPA-GMN-GAIFTNKBN-MAX  PIC 9(01).
                   07  SPA-GMN-GAIYKZFTNKBNLST
                                              OCCURS  4.
                       09  SPA-GMN-GAIYKZFTNKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-GAIYKZFTNKBNMEIL
                                              PIC X(24).
                   07  SPA-GMN-GAIYKZFTNKBN-MAX
                                              PIC 9(01).
                   07  SPA-GMN-NYUFTNKBNLST
                                              OCCURS  4.
                       09  SPA-GMN-NYUFTNKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-NYUFTNKBNMEIL
                                              PIC X(20).
                   07  SPA-GMN-NYUFTNKBN-MAX  PIC 9(01).
                   07  SPA-GMN-NYUSKJRYYKBNLST
                                              OCCURS  4.
                       09  SPA-GMN-NYUSKJRYYKBNL
                                              PIC X(01).
                       09  SPA-GMN-F1L        PIC X(01).
                       09  SPA-GMN-NYUSKJRYYKBNMEIL
                                              PIC X(24).
                   07  SPA-GMN-NYUSKJRYYKBN-MAX
                                              PIC 9(01).
                   07  SPA-GMN-HKNKOHSBTKBNLST    OCCURS  9.
                       09  SPA-GMN-HKNKOHSBTKBNL  PIC X(01).
                       09  SPA-GMN-F1L            PIC X(01).
                       09  SPA-GMN-HKNKOHSBTKBNMEIL
                                                  PIC X(18).
                   07  SPA-GMN-HKNKOHSBTKBN-MAX   PIC 9(01).
                   07  SPA-GMN-KENSNUMCHKKBNLST    OCCURS  2.
                       09  SPA-GMN-KENSNUMCHKKBNL PIC X(01).
                       09  SPA-GMN-F1L            PIC X(01).
                       09  SPA-GMN-KENSNUMCHKKBNMEIL
                                                  PIC X(14).
                   07  SPA-GMN-KENSNUMCHKKBN-MAX  PIC 9(01).
                   07  SPA-GMN-JKYSKENSNUMCHKKBNLST   OCCURS  2.
                       09  SPA-GMN-JKYSKENSNUMCHKKBNL PIC X(01).
                       09  SPA-GMN-F1L            PIC X(01).
                       09  SPA-GMN-JKYSKENSNUMCHKKBNMEIL
                                                  PIC X(14).
                   07  SPA-GMN-JKYSKENSNUMCHKKBN-MAX
                                                  PIC 9(01).
                   07  SPA-GMN-HKNKOHKBNLST       OCCURS  3.
                       09  SPA-GMN-HKNKOHKBNL     PIC X(01).
                       09  SPA-GMN-F1L            PIC X(01).
                       09  SPA-GMN-HKNKOHKBNMEIL  PIC X(08).
                   07  SPA-GMN-HKNKOHKBN-MAX      PIC 9(01).
                   07  SPA-GMN-RECESKYKBNLST      OCCURS  4.
                       09  SPA-GMN-RECESKYKBNL    PIC X(01).
                       09  SPA-GMN-F1L            PIC X(01).
                       09  SPA-GMN-RECESKYKBNMEIL PIC X(22).
                   07  SPA-GMN-RECESKYKBN-MAX     PIC 9(01).
      *
                   07  SPA-GMN-HBTNUM         PIC X(02).
                   07  SPA-GMN-SEIDONAME      PIC X(100).
                   07  SPA-GMN-TANSEIDONAME   PIC X(10).
                   07  SPA-GMN-HKNKOHSBTKBN-G.
                       09  SPA-GMN-HKNKOHSBTKBN   PIC X(01).
                       09  SPA-GMN-F1             PIC X(01).
                       09  SPA-GMN-HKNKOHSBTKBNMEI
                                                  PIC X(18).
                   07  SPA-GMN-KENSNUMCHKKBN-G.
                       09  SPA-GMN-KENSNUMCHKKBN  PIC X(01).
                       09  SPA-GMN-F1             PIC X(01).
                       09  SPA-GMN-KENSNUMCHKKBNMEI
                                                  PIC X(14).
                   07  SPA-GMN-JKYSKENSNUMCHKKBN-G.
                       09  SPA-GMN-JKYSKENSNUMCHKKBN
                                                  PIC X(01).
                       09  SPA-GMN-F1             PIC X(01).
                       09  SPA-GMN-JKYSKENSNUMCHKKBNMEI
                                                  PIC X(14).
                   07  SPA-GMN-HKNKOHKBN-G.
                       09  SPA-GMN-HKNKOHKBN      PIC X(01).
                       09  SPA-GMN-F1             PIC X(01).
                       09  SPA-GMN-HKNKOHKBNMEI   PIC X(08).
                   07  SPA-GMN-GENHKNNUM-G        OCCURS  3.
                       09  SPA-GMN-GENHKNNUM      PIC X(03).
                   07  SPA-GMN-JOKENSTYEAR        PIC 9(03).
                   07  SPA-GMN-JOKENEDYEAR        PIC 9(03).
                   07  SPA-GMN-TENTNK             PIC 9(03).
                   07  SPA-GMN-RECESKYKBN-G.
                       09  SPA-GMN-RECESKYKBN     PIC X(01).
                       09  SPA-GMN-F1             PIC X(01).
                       09  SPA-GMN-RECESKYKBNMEI  PIC X(22).
      *
                   07  SPA-GMN-HKN-AREA-G     OCCURS  4.
                       09  SPA-GMN-GAIFTNKBN-G.
                           11  SPA-GMN-GAIFTNKBN  PIC X(01).
                           11  SPA-GMN-F1         PIC X(01).
                           11  SPA-GMN-GAIFTNKBNMEI
                                                  PIC X(20).
                       09  SPA-GMN-GAIKFTNRATE    PIC 9(03).
                       09  SPA-GMN-GAIKKOTGAK     PIC 9(06).
                       09  SPA-GMN-GAIKJGNGAK     PIC 9(06).
                       09  SPA-GMN-GAIDJGNGAK     PIC 9(06). 
                       09  SPA-GMN-GAIDJGNCNT     PIC 9(02).
                       09  SPA-GMN-GAIMNAIJGNGAK  PIC 9(06).
                       09  SPA-GMN-GAIMGAIJGNGAK  PIC 9(06).
                       09  SPA-GMN-GAIMJGNCNT     PIC 9(02).
                       09  SPA-GMN-GAIYKZFTNKBN-G.
                           11  SPA-GMN-GAIYKZFTNKBN
                                                  PIC X(01).
                           11  SPA-GMN-F1         PIC X(01).
                           11  SPA-GMN-GAIYKZFTNKBNMEI
                                                  PIC X(24).
                       09  SPA-GMN-NYUFTNKBN-G.
                           11  SPA-GMN-NYUFTNKBN  PIC X(01).
                           11  SPA-GMN-F1         PIC X(01).
                           11  SPA-GMN-NYUFTNKBNMEI
                                                  PIC X(20).
                       09  SPA-GMN-NYUKFTNRATE    PIC 9(03).
                       09  SPA-GMN-NYUKKOTGAK     PIC 9(06).
                       09  SPA-GMN-NYUKJGNGAK     PIC 9(06).
                       09  SPA-GMN-NYUDJGNGAK     PIC 9(06). 
                       09  SPA-GMN-NYUDJGNCNT     PIC 9(02).
                       09  SPA-GMN-NYUMJGNGAK     PIC 9(06).
                       09  SPA-GMN-NYUMJGNCNT     PIC 9(02).
                       09  SPA-GMN-NYUSKJRYYKBN-G.
                           11  SPA-GMN-NYUSKJRYYKBN
                                                  PIC X(01).
                           11  SPA-GMN-F1         PIC X(01).
                           11  SPA-GMN-NYUSKJRYYKBNMEI
                                                  PIC X(24).
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-STYUKYMD           PIC 9(08).
                   07  SPA-NAI-EDYUKYMD           PIC 9(08).
      *
      *   
           COPY    "ENUM-VALUE".
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
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
           03  WRK-VIDMSG          PIC X(70). 
           03  WRK-YMD             PIC X(09). 
           03  WRK-GMN-CUR         PIC 9(03).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-PAGENO          PIC 9(01).    
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
       01  HKNNUM-REC.
           COPY  "CPHKNNUM.INC".
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
           COPY    "V01.INC".
           COPY    "V02.INC".
           COPY    "VERR.INC".
           COPY    "VID1.INC".
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
           MOVE    SPA-WORK        TO  SPA-V01KYOUTU
           MOVE    SPA-FREE        TO  SPA-V02
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
           MOVE    SPA-V02         TO  SPA-FREE
           MOVE    SPA-V01KYOUTU   TO  SPA-WORK 
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
           IF      SPA-MOTOPG          =   "VERR"
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
           MOVE    "V02"                TO  MCP-WINDOW
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
               WHEN    "VID1"
                   PERFORM 330-VID1-SET-SEC
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
       330-VID1-SET-SEC            SECTION.
      *
           IF      SPA-VID1-FLG    =   "OK"
               IF      SPA-VIDCD            =   "1002"
                   PERFORM 4031-DEL-SEC
               ELSE
                   PERFORM 490-KOUSHIN-SEC
               END-IF
           END-IF
      *
           MOVE    SPACE           TO  SPA-VID1-FLG
           MOVE    SPACE           TO  SPA-VIDCD      
           .
       330-VID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE   SPA-V02-AREA
      *
           MOVE    SPA-V01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-V01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
           MOVE    SPA-V01-HKNNUM      TO  SPA-GMN-HKNNUM
           MOVE    SPA-V01-PAYKBN      TO  SPA-GMN-PAYKBN
      *
           MOVE    "1"                 TO  SPA-GMN-HKNKOHSBTKBNL    (1)
           MOVE    "主保険"            TO  SPA-GMN-HKNKOHSBTKBNMEIL (1)
           MOVE    "2"                 TO  SPA-GMN-HKNKOHSBTKBNL    (2)
           MOVE    "長期高額療養費"    TO  SPA-GMN-HKNKOHSBTKBNMEIL (2)
           MOVE    "3"                 TO  SPA-GMN-HKNKOHSBTKBNL    (3)
           MOVE    "老人保険"          TO  SPA-GMN-HKNKOHSBTKBNMEIL (3)
           MOVE    "4"                 TO  SPA-GMN-HKNKOHSBTKBNL    (4)
           MOVE    "労災"              TO  SPA-GMN-HKNKOHSBTKBNMEIL (4)
           MOVE    "5"                 TO  SPA-GMN-HKNKOHSBTKBNL    (5)
           MOVE    "生活保護"          TO  SPA-GMN-HKNKOHSBTKBNMEIL (5)
           MOVE    "6"                 TO  SPA-GMN-HKNKOHSBTKBNL    (6)
           MOVE    "単独公費"          TO  SPA-GMN-HKNKOHSBTKBNMEIL (6)
           MOVE    "7"                 TO  SPA-GMN-HKNKOHSBTKBNL    (7)
           MOVE    "一般公費"          TO  SPA-GMN-HKNKOHSBTKBNMEIL (7)
           MOVE    "8"                 TO  SPA-GMN-HKNKOHSBTKBNL    (8)
           MOVE    "自費"              TO  SPA-GMN-HKNKOHSBTKBNMEIL (8)
           MOVE    "9"                 TO  SPA-GMN-HKNKOHSBTKBNL    (9)
           MOVE    "治験"              TO  SPA-GMN-HKNKOHSBTKBNMEIL (9)
           MOVE    9                   TO  SPA-GMN-HKNKOHSBTKBN-MAX
      *
           MOVE    "1"                 TO  SPA-GMN-KENSNUMCHKKBNL   (1)
           MOVE    "チェックする"      TO  SPA-GMN-KENSNUMCHKKBNMEIL(1)
           MOVE    "2"                 TO  SPA-GMN-KENSNUMCHKKBNL   (2)
           MOVE    "チェックしない"    TO  SPA-GMN-KENSNUMCHKKBNMEIL(2)
           MOVE    2                   TO  SPA-GMN-KENSNUMCHKKBN-MAX
      *
           MOVE    "1"                 TO
                                       SPA-GMN-JKYSKENSNUMCHKKBNL   (1)
           MOVE    "チェックする"      TO
                                       SPA-GMN-JKYSKENSNUMCHKKBNMEIL(1)
           MOVE    "2"                 TO
                                       SPA-GMN-JKYSKENSNUMCHKKBNL   (2)
           MOVE    "チェックしない"    TO
                                       SPA-GMN-JKYSKENSNUMCHKKBNMEIL(2)
           MOVE    2                   TO  
                                       SPA-GMN-JKYSKENSNUMCHKKBN-MAX
      *
           MOVE    "1"                 TO  SPA-GMN-HKNKOHKBNL    (1)
           MOVE    "主公費"            TO  SPA-GMN-HKNKOHKBNMEIL (1)
           MOVE    "2"                 TO  SPA-GMN-HKNKOHKBNL    (2)
           MOVE    "補助公費"          TO  SPA-GMN-HKNKOHKBNMEIL (2)
           MOVE    "3"                 TO  SPA-GMN-HKNKOHKBNL    (3)
           MOVE    "主補公費"          TO  SPA-GMN-HKNKOHKBNMEIL (3)
           MOVE    3                   TO  SPA-GMN-HKNKOHKBN-MAX
      *
           MOVE    "0"                 TO  SPA-GMN-RECESKYKBNL   (1)
           MOVE    "社保、国保の両方に印刷"
                                       TO  SPA-GMN-RECESKYKBNMEIL(1)
           MOVE    "1"                 TO  SPA-GMN-RECESKYKBNL   (2)
           MOVE    "社保との併用に限り印刷"
                                       TO  SPA-GMN-RECESKYKBNMEIL(2)
           MOVE    "2"                 TO  SPA-GMN-RECESKYKBNL   (3)
           MOVE    "国保との併用に限り印刷"
                                       TO  SPA-GMN-RECESKYKBNMEIL(3)
           MOVE    "3"                 TO  SPA-GMN-RECESKYKBNL   (4)
           MOVE    "社保、国保とも印刷不可"
                                       TO  SPA-GMN-RECESKYKBNMEIL(4)
           MOVE    4                   TO  SPA-GMN-RECESKYKBN-MAX
      *
           MOVE    "0"                 TO  SPA-GMN-GAIFTNKBNL    (1)
           MOVE    "使用しない"        TO  SPA-GMN-GAIFTNKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-GAIFTNKBNL    (2)
           MOVE    "患者負担あり"      TO  SPA-GMN-GAIFTNKBNMEIL (2)
           MOVE    "2"                 TO  SPA-GMN-GAIFTNKBNL    (3)
           MOVE    "患者負担なし"      TO  SPA-GMN-GAIFTNKBNMEIL (3)
           MOVE    "3"                 TO  SPA-GMN-GAIFTNKBNL    (4)
           MOVE    "患者負担あり（固定）"
                                       TO  SPA-GMN-GAIFTNKBNMEIL (4)
           MOVE    4                   TO  SPA-GMN-GAIFTNKBN-MAX
      *
           MOVE    "0"                 TO  SPA-GMN-GAIYKZFTNKBNL    (1)
           MOVE    "使用しない"        TO  SPA-GMN-GAIYKZFTNKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-GAIYKZFTNKBNL    (2)
           MOVE    "患者負担あり"      TO  SPA-GMN-GAIYKZFTNKBNMEIL (2)
           MOVE    "2"                 TO  SPA-GMN-GAIYKZFTNKBNL    (3)
           MOVE    "患者負担あり（上限あり）"
                                       TO  SPA-GMN-GAIYKZFTNKBNMEIL (3)
           MOVE    "3"                 TO  SPA-GMN-GAIYKZFTNKBNL    (4)
           MOVE    "患者負担なし"      TO  SPA-GMN-GAIYKZFTNKBNMEIL (4)
           MOVE    4                   TO  SPA-GMN-GAIYKZFTNKBN-MAX
      *
           MOVE    "0"                 TO  SPA-GMN-NYUFTNKBNL       (1)
           MOVE    "使用しない"        TO  SPA-GMN-NYUFTNKBNMEIL    (1)
           MOVE    "1"                 TO  SPA-GMN-NYUFTNKBNL       (2)
           MOVE    "患者負担あり"      TO  SPA-GMN-NYUFTNKBNMEIL    (2)
           MOVE    "2"                 TO  SPA-GMN-NYUFTNKBNL       (3)
           MOVE    "患者負担なし"      TO  SPA-GMN-NYUFTNKBNMEIL    (3)
           MOVE    "3"                 TO  SPA-GMN-NYUFTNKBNL       (4)
           MOVE    "患者負担あり（固定）"
                                       TO  SPA-GMN-NYUFTNKBNMEIL    (4)
           MOVE    4                   TO  SPA-GMN-NYUFTNKBN-MAX
      *
           MOVE    "0"                 TO  SPA-GMN-NYUSKJRYYKBNL    (1)
           MOVE    "使用しない"        TO  SPA-GMN-NYUSKJRYYKBNMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-NYUSKJRYYKBNL    (2)
           MOVE    "患者負担あり"      TO  SPA-GMN-NYUSKJRYYKBNMEIL (2)
           MOVE    "2"                 TO  SPA-GMN-NYUSKJRYYKBNL    (3)
           MOVE    "患者負担あり（上限あり）"
                                       TO  SPA-GMN-NYUSKJRYYKBNMEIL (3)
           MOVE    "3"                 TO  SPA-GMN-NYUSKJRYYKBNL    (4)
           MOVE    "患者負担なし"      TO  SPA-GMN-NYUSKJRYYKBNMEIL (4)
           MOVE    4                   TO  SPA-GMN-NYUSKJRYYKBN-MAX
      *
      *    保険番号マスタより編集  
           INITIALIZE                      HKNNUM-REC
           MOVE    SPA-HOSPID              TO  HKN-HOSPID
           MOVE    SPA-V01-HKNNUM          TO  HKN-HKNNUM
           MOVE    SPA-V01-PAYKBN          TO  HKN-PAYKBN
           MOVE    SPA-V01-STYUKYMD        TO  HKN-TEKSTYMD
           MOVE    SPA-V01-EDYUKYMD        TO  HKN-TEKEDYMD
           MOVE    HKNNUM-REC              TO  MCPDATA-REC
           PERFORM 900-HKNNUM-INV-SEC
           IF      FLG-HKNNUM              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNNUM-REC
               MOVE    HKN-HBTNUM          TO  SPA-GMN-HBTNUM
               MOVE    HKN-SEIDONAME       TO  SPA-GMN-SEIDONAME
               MOVE    HKN-TANSEIDONAME    TO  SPA-GMN-TANSEIDONAME
               MOVE    HKN-HKNKOHSBTKBN    TO  SPA-GMN-HKNKOHSBTKBN
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-HKNKOHSBTKBN-MAX
                   IF      SPA-GMN-HKNKOHSBTKBN
                                      =   SPA-GMN-HKNKOHSBTKBNL (IDY)
                       MOVE    SPA-GMN-HKNKOHSBTKBNMEIL (IDY)
                                      TO  SPA-GMN-HKNKOHSBTKBNMEI
                       MOVE    SPA-GMN-HKNKOHSBTKBN-MAX
                                      TO  IDY
                   END-IF
               END-PERFORM
               MOVE    HKN-KENSNUMCHKKBN   TO  SPA-GMN-KENSNUMCHKKBN
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-KENSNUMCHKKBN-MAX
                   IF      SPA-GMN-KENSNUMCHKKBN
                                      =   SPA-GMN-KENSNUMCHKKBNL (IDY)
                       MOVE    SPA-GMN-KENSNUMCHKKBNMEIL (IDY)
                                      TO  SPA-GMN-KENSNUMCHKKBNMEI
                       MOVE    SPA-GMN-KENSNUMCHKKBN-MAX
                                      TO  IDY
                   END-IF
               END-PERFORM
               MOVE    HKN-JKYSKENSNUMCHKKBN   TO 
                                          SPA-GMN-JKYSKENSNUMCHKKBN
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-JKYSKENSNUMCHKKBN-MAX
                   IF      SPA-GMN-JKYSKENSNUMCHKKBN
                                  =   SPA-GMN-JKYSKENSNUMCHKKBNL (IDY)
                       MOVE    SPA-GMN-JKYSKENSNUMCHKKBNMEIL (IDY)
                                      TO  SPA-GMN-JKYSKENSNUMCHKKBNMEI
                       MOVE    SPA-GMN-JKYSKENSNUMCHKKBN-MAX
                                      TO  IDY
                   END-IF
               END-PERFORM
               MOVE    HKN-HKNKOHKBN       TO  SPA-GMN-HKNKOHKBN 
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-HKNKOHKBN-MAX
                   IF      SPA-GMN-HKNKOHKBN
                                          =   SPA-GMN-HKNKOHKBNL (IDY)
                       MOVE    SPA-GMN-HKNKOHKBNMEIL (IDY)
                                      TO  SPA-GMN-HKNKOHKBNMEI
                       MOVE    SPA-GMN-HKNKOHKBN-MAX
                                      TO  IDY
                   END-IF
               END-PERFORM
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       3  
                   MOVE    HKN-GENHKNNUM (IDX)
                                           TO  SPA-GMN-GENHKNNUM (IDX) 
               END-PERFORM 
               MOVE    HKN-JOKEN-STYEAR    TO  SPA-GMN-JOKENSTYEAR
               MOVE    HKN-JOKEN-EDYEAR    TO  SPA-GMN-JOKENEDYEAR 
               MOVE    HKN-TENTNK          TO  SPA-GMN-TENTNK
               MOVE    HKN-RECESKYKBN      TO  SPA-GMN-RECESKYKBN
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-RECESKYKBN-MAX
                   IF      SPA-GMN-RECESKYKBN
                                          =   SPA-GMN-RECESKYKBNL (IDY)
                       MOVE    SPA-GMN-RECESKYKBNMEIL (IDY)
                                          TO  SPA-GMN-RECESKYKBNMEI
                       MOVE    SPA-GMN-RECESKYKBN-MAX
                                          TO  IDY
                   END-IF
               END-PERFORM
      *        
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       4  
                   MOVE    HKN-GAIFTNKBN       (IDX)
                                       TO  SPA-GMN-GAIFTNKBN     (IDX)
                   PERFORM VARYING IDY FROM   1   BY  1
                           UNTIL   IDY >      SPA-GMN-GAIFTNKBN-MAX
                       IF      SPA-GMN-GAIFTNKBN (IDX)
                                          =   SPA-GMN-GAIFTNKBNL (IDY)
                           MOVE    SPA-GMN-GAIFTNKBNMEIL (IDY)
                                          TO  SPA-GMN-GAIFTNKBNMEI(IDX)
                           MOVE    SPA-GMN-GAIFTNKBN-MAX
                                          TO  IDY
                       END-IF
                   END-PERFORM
                   MOVE    HKN-GAIKFTNRATE     (IDX)
                                       TO  SPA-GMN-GAIKFTNRATE   (IDX)
                   MOVE    HKN-GAIKKOTGAK      (IDX)
                                       TO  SPA-GMN-GAIKKOTGAK    (IDX) 
                   MOVE    HKN-GAIKJGNGAK      (IDX)
                                       TO  SPA-GMN-GAIKJGNGAK    (IDX)
                   MOVE    HKN-GAIDJGNGAK      (IDX)
                                       TO  SPA-GMN-GAIDJGNGAK    (IDX)
                   MOVE    HKN-GAIDJGNCNT      (IDX) 
                                       TO  SPA-GMN-GAIDJGNCNT    (IDX)
                   MOVE    HKN-GAIMNAIJGNGAK   (IDX)
                                       TO  SPA-GMN-GAIMNAIJGNGAK (IDX)
                   MOVE    HKN-GAIMGAIJGNGAK   (IDX) 
                                       TO  SPA-GMN-GAIMGAIJGNGAK (IDX)
                   MOVE    HKN-GAIMJGNCNT      (IDX)
                                       TO  SPA-GMN-GAIMJGNCNT    (IDX)
                   MOVE    HKN-GAIYKZFTNKBN    (IDX)
                                       TO  SPA-GMN-GAIYKZFTNKBN  (IDX)
                  PERFORM VARYING IDY FROM   1   BY  1
                           UNTIL   IDY >     SPA-GMN-GAIYKZFTNKBN-MAX
                       IF      SPA-GMN-GAIYKZFTNKBN (IDX)
                                      =   SPA-GMN-GAIYKZFTNKBNL (IDY)
                           MOVE    SPA-GMN-GAIYKZFTNKBNMEIL (IDY)
                                      TO SPA-GMN-GAIYKZFTNKBNMEI(IDX)
                           MOVE    SPA-GMN-GAIYKZFTNKBN-MAX
                                      TO  IDY
                       END-IF
                   END-PERFORM
                   MOVE    HKN-NYUFTNKBN       (IDX)
                                       TO  SPA-GMN-NYUFTNKBN     (IDX)
                   PERFORM VARYING IDY FROM   1   BY  1
                           UNTIL   IDY >      SPA-GMN-NYUFTNKBN-MAX
                       IF      SPA-GMN-NYUFTNKBN (IDX)
                                          =   SPA-GMN-NYUFTNKBNL (IDY)
                           MOVE    SPA-GMN-NYUFTNKBNMEIL (IDY)
                                          TO  SPA-GMN-NYUFTNKBNMEI(IDX)
                           MOVE    SPA-GMN-NYUFTNKBN-MAX
                                          TO  IDY
                       END-IF
                   END-PERFORM
                   MOVE    HKN-NYUKFTNRATE     (IDX) 
                                       TO  SPA-GMN-NYUKFTNRATE   (IDX)
                   MOVE    HKN-NYUKKOTGAK      (IDX)
                                       TO  SPA-GMN-NYUKKOTGAK    (IDX)
                   MOVE    HKN-NYUKJGNGAK      (IDX) 
                                       TO  SPA-GMN-NYUKJGNGAK    (IDX)
                   MOVE    HKN-NYUDJGNGAK      (IDX)
                                       TO  SPA-GMN-NYUDJGNGAK    (IDX)
                   MOVE    HKN-NYUDJGNCNT      (IDX)
                                       TO  SPA-GMN-NYUDJGNCNT    (IDX)
                   MOVE    HKN-NYUMJGNGAK      (IDX)
                                       TO  SPA-GMN-NYUMJGNGAK    (IDX)
                   MOVE    HKN-NYUMJGNCNT      (IDX)
                                       TO  SPA-GMN-NYUMJGNCNT    (IDX)
                   MOVE    HKN-NYUSKJRYYKBN    (IDX)
                                       TO  SPA-GMN-NYUSKJRYYKBN  (IDX)
                   PERFORM VARYING IDY FROM   1   BY  1
                           UNTIL   IDY >      SPA-GMN-NYUSKJRYYKBN-MAX
                       IF      SPA-GMN-NYUSKJRYYKBN (IDX)
                                      =   SPA-GMN-NYUSKJRYYKBNL (IDY)
                           MOVE    SPA-GMN-NYUSKJRYYKBNMEIL (IDY)
                                      TO SPA-GMN-NYUSKJRYYKBNMEI(IDX)
                           MOVE    SPA-GMN-NYUSKJRYYKBN-MAX 
                                      TO  IDY
                       END-IF
                   END-PERFORM
               END-PERFORM 
           END-IF
      *
           MOVE    ZERO                TO  SPA-GMN-PAGENO 
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
                   MOVE   "CHANGE"         TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *    削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 403-DEL-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *    タグ
               WHEN    "CLICKED"       ALSO    "N01"
               WHEN    "CLICKED"       ALSO    "N02"
               WHEN    "CLICKED"       ALSO    "N03"
               WHEN    "CLICKED"       ALSO    "N04"
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
               WHEN    "ACTIVATE"      ALSO    "HBTNUM"
                   PERFORM 4100-HBTNUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SEIDONAME"
                   PERFORM 4101-SEIDONAME-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "TANSEIDONAME"
                   PERFORM 4102-TANSEIDONAME-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNKOHSBTKBN"
                   PERFORM 4103-HKNKOHSBTKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "KENSNUMCHKKBN"
                   PERFORM 4104-KENSNUMCHKKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "JKYSKENSNUMCHKKBN"
                   PERFORM 4105-JKYSKENSNUMCHKKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNKOHKBN"
                   PERFORM 4106-HKNKOHKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "GENHKNNUM1"
               WHEN    "ACTIVATE"      ALSO    "GENHKNNUM2"
               WHEN    "ACTIVATE"      ALSO    "GENHKNNUM3"
                   PERFORM 4107-GENHKNNUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "JOKENSTYEAR"
                   PERFORM 4108-JOKENSTYEAR-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "JOKENEDYEAR"
                   PERFORM 4109-JOKENEDYEAR-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "TENTNK"
                   PERFORM 4110-TENTNK-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "RECESKYKBN"
                   PERFORM 4130-RECESKYKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "GAIFTNKBN1"
               WHEN    "ACTIVATE"      ALSO    "GAIFTNKBN2"
               WHEN    "ACTIVATE"      ALSO    "GAIFTNKBN3"
               WHEN    "ACTIVATE"      ALSO    "GAIFTNKBN4"
                   PERFORM 4111-GAIFTNKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "GAIKFTNRATE1"
               WHEN    "ACTIVATE"      ALSO    "GAIKFTNRATE2"
               WHEN    "ACTIVATE"      ALSO    "GAIKFTNRATE3"
               WHEN    "ACTIVATE"      ALSO    "GAIKFTNRATE4"
                   PERFORM 4112-GAIKFTNRATE-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "GAIKKOTGAK1"
               WHEN    "ACTIVATE"      ALSO    "GAIKKOTGAK2"
               WHEN    "ACTIVATE"      ALSO    "GAIKKOTGAK3"
               WHEN    "ACTIVATE"      ALSO    "GAIKKOTGAK4"
                   PERFORM 4113-GAIKKOTGAK-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "GAIKJGNGAK1"
               WHEN    "ACTIVATE"      ALSO    "GAIKJGNGAK2"
               WHEN    "ACTIVATE"      ALSO    "GAIKJGNGAK3"
               WHEN    "ACTIVATE"      ALSO    "GAIKJGNGAK4"
                   PERFORM 4114-GAIKJGNGAK-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "GAIDJGNGAK1" 
               WHEN    "ACTIVATE"      ALSO    "GAIDJGNGAK2" 
               WHEN    "ACTIVATE"      ALSO    "GAIDJGNGAK3" 
               WHEN    "ACTIVATE"      ALSO    "GAIDJGNGAK4" 
                   PERFORM 4115-GAIDJGNGAK-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "GAIDJGNCNT1"  
               WHEN    "ACTIVATE"      ALSO    "GAIDJGNCNT2"  
               WHEN    "ACTIVATE"      ALSO    "GAIDJGNCNT3"  
               WHEN    "ACTIVATE"      ALSO    "GAIDJGNCNT4"  
                   PERFORM 4116-GAIDJGNCNT-CHK-SEC  
               WHEN    "ACTIVATE"      ALSO    "GAIMNAIJGNGAK1"  
               WHEN    "ACTIVATE"      ALSO    "GAIMNAIJGNGAK2"  
               WHEN    "ACTIVATE"      ALSO    "GAIMNAIJGNGAK3"  
               WHEN    "ACTIVATE"      ALSO    "GAIMNAIJGNGAK4"  
                   PERFORM 4117-GAIMNAIJGNGAK-CHK-SEC                
               WHEN    "ACTIVATE"      ALSO    "GAIMGAIJGNGAK1"  
               WHEN    "ACTIVATE"      ALSO    "GAIMGAIJGNGAK2"  
               WHEN    "ACTIVATE"      ALSO    "GAIMGAIJGNGAK3"  
               WHEN    "ACTIVATE"      ALSO    "GAIMGAIJGNGAK4"  
                   PERFORM 4118-GAIMGAIJGNGAK-CHK-SEC                
               WHEN    "ACTIVATE"      ALSO    "GAIMJGNCNT1"  
               WHEN    "ACTIVATE"      ALSO    "GAIMJGNCNT2"  
               WHEN    "ACTIVATE"      ALSO    "GAIMJGNCNT3"  
               WHEN    "ACTIVATE"      ALSO    "GAIMJGNCNT4"  
                   PERFORM 4119-GAIMJGNCNT-CHK-SEC  
               WHEN    "ACTIVATE"      ALSO    "GAIYKZFTNKBN1"  
               WHEN    "ACTIVATE"      ALSO    "GAIYKZFTNKBN2"  
               WHEN    "ACTIVATE"      ALSO    "GAIYKZFTNKBN3"  
               WHEN    "ACTIVATE"      ALSO    "GAIYKZFTNKBN4"  
                   PERFORM 4120-GAIYKZFTNKBN-CHK-SEC  
               WHEN    "ACTIVATE"      ALSO    "NYUFTNKBN1"
               WHEN    "ACTIVATE"      ALSO    "NYUFTNKBN2"
               WHEN    "ACTIVATE"      ALSO    "NYUFTNKBN3"
               WHEN    "ACTIVATE"      ALSO    "NYUFTNKBN4"
                   PERFORM 4121-NYUFTNKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NYUKFTNRATE1"
               WHEN    "ACTIVATE"      ALSO    "NYUKFTNRATE2"
               WHEN    "ACTIVATE"      ALSO    "NYUKFTNRATE3"
               WHEN    "ACTIVATE"      ALSO    "NYUKFTNRATE4"
                   PERFORM 4122-NYUKFTNRATE-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NYUKKOTGAK1"
               WHEN    "ACTIVATE"      ALSO    "NYUKKOTGAK2"
               WHEN    "ACTIVATE"      ALSO    "NYUKKOTGAK3"
               WHEN    "ACTIVATE"      ALSO    "NYUKKOTGAK4"
                   PERFORM 4123-NYUKKOTGAK-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NYUKJGNGAK1"
               WHEN    "ACTIVATE"      ALSO    "NYUKJGNGAK2"
               WHEN    "ACTIVATE"      ALSO    "NYUKJGNGAK3"
               WHEN    "ACTIVATE"      ALSO    "NYUKJGNGAK4"
                   PERFORM 4124-NYUKJGNGAK-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NYUDJGNGAK1" 
               WHEN    "ACTIVATE"      ALSO    "NYUDJGNGAK2" 
               WHEN    "ACTIVATE"      ALSO    "NYUDJGNGAK3" 
               WHEN    "ACTIVATE"      ALSO    "NYUDJGNGAK4" 
                   PERFORM 4125-NYUDJGNGAK-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NYUDJGNCNT1"  
               WHEN    "ACTIVATE"      ALSO    "NYUDJGNCNT2"  
               WHEN    "ACTIVATE"      ALSO    "NYUDJGNCNT3"  
               WHEN    "ACTIVATE"      ALSO    "NYUDJGNCNT4"  
                   PERFORM 4126-NYUDJGNCNT-CHK-SEC  
               WHEN    "ACTIVATE"      ALSO    "NYUMJGNGAK1"  
               WHEN    "ACTIVATE"      ALSO    "NYUMJGNGAK2"  
               WHEN    "ACTIVATE"      ALSO    "NYUMJGNGAK3"  
               WHEN    "ACTIVATE"      ALSO    "NYUMJGNGAK4"  
                   PERFORM 4127-NYUMJGNGAK-CHK-SEC                
               WHEN    "ACTIVATE"      ALSO    "NYUMJGNCNT1"  
               WHEN    "ACTIVATE"      ALSO    "NYUMJGNCNT2"  
               WHEN    "ACTIVATE"      ALSO    "NYUMJGNCNT3"  
               WHEN    "ACTIVATE"      ALSO    "NYUMJGNCNT4"  
                   PERFORM 4128-NYUMJGNCNT-CHK-SEC  
               WHEN    "ACTIVATE"      ALSO    "NYUSKJRYYKBN1"  
               WHEN    "ACTIVATE"      ALSO    "NYUSKJRYYKBN2"  
               WHEN    "ACTIVATE"      ALSO    "NYUSKJRYYKBN3"  
               WHEN    "ACTIVATE"      ALSO    "NYUSKJRYYKBN4"  
                   PERFORM 4129-NYUSKJRYYKBN-CHK-SEC  
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    法別番号チェック
      *****************************************************************
       4100-HBTNUM-CHK-SEC       SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           MOVE    V02-HBTNUM          TO  SPA-GMN-HBTNUM           
      * 
           MOVE    2                   TO  SPA-GMN-CUR
           .
       4100-HBTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    制度名チェック
      *****************************************************************
       4101-SEIDONAME-CHK-SEC       SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR
      *
           MOVE    V02-SEIDONAME       TO  SPA-GMN-SEIDONAME
      *
           MOVE    3                   TO  SPA-GMN-CUR
           .
       4101-SEIDONAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    短縮制度名チェック
      *****************************************************************
       4102-TANSEIDONAME-CHK-SEC     SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR
      *
           MOVE    V02-TANSEIDONAME    TO  SPA-GMN-TANSEIDONAME
      *                           
           MOVE    4                   TO  SPA-GMN-CUR
           .
       4102-TANSEIDONAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険公費種別区分チェック
      *****************************************************************
       4103-HKNKOHSBTKBN-CHK-SEC     SECTION.
      *
           MOVE    4                   TO  SPA-GMN-CUR
      *
           MOVE    V02-HKNKOHSBTKBN    TO  SPA-GMN-HKNKOHSBTKBN-G
      *
           IF      SPA-GMN-HKNKOHSBTKBNMEI    =   SPACE
              MOVE    "0001"           TO  SPA-ERRCD
           ELSE       
               ADD     1               TO  SPA-GMN-CUR
           END-IF    
           .
       4103-HKNKOHSBTKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    検証番号チェック区分チェック
      *****************************************************************
       4104-KENSNUMCHKKBN-CHK-SEC          SECTION.
      *
           MOVE    5                   TO  SPA-GMN-CUR
      *
           MOVE    V02-KENSNUMCHKKBN   TO  SPA-GMN-KENSNUMCHKKBN-G
      *
           IF      SPA-GMN-KENSNUMCHKKBNMEI    =   SPACE
              MOVE    "0002"           TO  SPA-ERRCD
           ELSE       
               MOVE    7               TO  SPA-GMN-CUR
           END-IF    
           .
       4104-KENSNUMCHKKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    受給者検証番号チェック区分チェック
      *****************************************************************
       4105-JKYSKENSNUMCHKKBN-CHK-SEC          SECTION.
      *
           MOVE    6                   TO  SPA-GMN-CUR
      *
           MOVE    V02-JKYSKENSNUMCHKKBN
                                       TO  SPA-GMN-JKYSKENSNUMCHKKBN-G
      *
           IF      SPA-GMN-JKYSKENSNUMCHKKBNMEI    =   SPACE
              MOVE    "0003"           TO  SPA-ERRCD
           ELSE       
               MOVE    8               TO  SPA-GMN-CUR
           END-IF    
           .
       4105-JKYSKENSNUMCHKKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費主保区分チェック
      *****************************************************************
       4106-HKNKOHKBN-CHK-SEC        SECTION.
      *
           MOVE    7                   TO  SPA-GMN-CUR
      *
           MOVE    V02-HKNKOHKBN       TO  SPA-GMN-HKNKOHKBN-G
      *
           EVALUATE    SPA-GMN-HKNKOHSBTKBN
               WHEN    "6"
                   IF      SPA-GMN-HKNKOHKBNMEI    NOT =   SPACE
                       MOVE    "0004"           TO  SPA-ERRCD
                   END-IF
               WHEN    "7"
                   IF      SPA-GMN-HKNKOHKBNMEI    =   SPACE
                       MOVE    "0010"           TO  SPA-ERRCD
                   END-IF
           END-EVALUATE
      *            
           IF      SPA-ERRCD           =   SPACE       
               MOVE    6                   TO  SPA-GMN-CUR
           END-IF    
           .
       4106-HKNKOHKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    限定保険番号チェック
      *****************************************************************
       4107-GENHKNNUM-CHK-SEC            SECTION.
      *
           MOVE    7                   TO  SPA-GMN-CUR
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GENHKNNUM1"
                   MOVE    1                   TO  IDX
               WHEN    "GENHKNNUM2"
                   MOVE    2                   TO  IDX
               WHEN    "GENHKNNUM3"
                   MOVE    3                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   SPA-GMN-CUR     +   IDX   
      *
           MOVE    V02-GENHKNNUM (IDX)  TO  SPA-GMN-GENHKNNUM (IDX)
      *
           ADD     1                    TO  SPA-GMN-CUR
           .
       4107-GENHKNNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    条件−年齢開始チェック
      *****************************************************************
       4108-JOKENSTYEAR-CHK-SEC        SECTION.
      *
           MOVE    11                   TO  SPA-GMN-CUR
      *
           MOVE    V02-JOKENSTYEAR      TO  SPA-GMN-JOKENSTYEAR
      *
           ADD     1                    TO  SPA-GMN-CUR
           .
       4108-JOKENSTYEAR-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    条件−年齢終了チェック
      *****************************************************************
       4109-JOKENEDYEAR-CHK-SEC            SECTION.
      *
           MOVE    12                  TO  SPA-GMN-CUR
      * 
           MOVE    V02-JOKENEDYEAR     TO  SPA-GMN-JOKENEDYEAR
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
       4109-JOKENEDYEAR-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数単価チェック
      *****************************************************************
       4110-TENTNK-CHK-SEC         SECTION.
      *
           MOVE    13                 TO  SPA-GMN-CUR
      *
           MOVE    V02-TENTNK         TO  SPA-GMN-TENTNK
      *
           MOVE    14                 TO  SPA-GMN-CUR
           .
       4110-TENTNK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト請求チェック
      *****************************************************************
       4130-RECESKYKBN-CHK-SEC         SECTION.
      *
           MOVE    14                  TO  SPA-GMN-CUR
      *
           MOVE    V02-RECESKYKBN      TO  SPA-GMN-RECESKYKBN-G
      *
           IF      SPA-GMN-RECESKYKBNMEI    =   SPACE
              MOVE    "0005"           TO  SPA-ERRCD
           ELSE       
               MOVE    20              TO  SPA-GMN-CUR
           END-IF    
           .
       4130-RECESKYKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来負担区分チェック
      *****************************************************************
       4111-GAIFTNKBN-CHK-SEC       SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIFTNKBN1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIFTNKBN2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIFTNKBN3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIFTNKBN4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   20  
      *
           MOVE    V02-GAIFTNKBN (IDX) TO  SPA-GMN-GAIFTNKBN-G (IDX)
      *     
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      SPA-GMN-GAIFTNKBN-MAX
               IF      SPA-GMN-GAIFTNKBN (IDX)
                                      =   SPA-GMN-GAIFTNKBNL (IDY)
                   MOVE    SPA-GMN-GAIFTNKBNMEIL (IDY)
                                      TO  SPA-GMN-GAIFTNKBNMEI(IDX)
                   MOVE    SPA-GMN-GAIFTNKBN-MAX
                                      TO  IDY
               END-IF
           END-PERFORM
      *
           IF      SPA-GMN-GAIFTNKBNMEI (IDX)  =   SPACE
               MOVE    "0006"           TO  SPA-ERRCD
           ELSE
               IF      SPA-GMN-GAIFTNKBN (IDX) =   "3"
                   IF      SPA-V01-HKNNUM (1:1)    >=  "1" AND <= "8"
                       CONTINUE
                   ELSE
                       MOVE    "0010"              TO  SPA-ERRCD
                   END-IF
               END-IF
      *
           IF      SPA-ERRCD           =   SPACE                           
               ADD     1               TO  SPA-GMN-CUR
           END-IF    
           .
       4111-GAIFTNKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来回負担割合チェック処理
      *****************************************************************
       4112-GAIKFTNRATE-CHK-SEC           SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIKFTNRATE1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIKFTNRATE2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIKFTNRATE3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIKFTNRATE4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   21  
      *
           MOVE    V02-GAIKFTNRATE (IDX)
                                       TO  SPA-GMN-GAIKFTNRATE (IDX)
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
       4112-GAIKFTNRATE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来回固定額チェック処理
      *****************************************************************
       4113-GAIKKOTGAK-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIKKOTGAK1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIKKOTGAK2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIKKOTGAK3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIKKOTGAK4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   22  
      *
           MOVE    V02-GAIKKOTGAK  (IDX)
                                        TO  SPA-GMN-GAIKKOTGAK (IDX)
      *
           ADD     1                    TO  SPA-GMN-CUR
           . 
       4113-GAIKKOTGAK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来回上限額チェック処理
      *****************************************************************
       4114-GAIKJGNGAK-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIKJGNGAK1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIKJGNGAK2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIKJGNGAK3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIKJGNGAK4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   23  
      *
           MOVE    V02-GAIKJGNGAK  (IDX)
                                        TO  SPA-GMN-GAIKJGNGAK (IDX)
      *
           ADD     1                    TO  SPA-GMN-CUR
           .
       4114-GAIKJGNGAK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来日上限額チェック処理
      *****************************************************************
       4115-GAIDJGNGAK-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIDJGNGAK1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIDJGNGAK2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIDJGNGAK3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIDJGNGAK4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   24  
      *
      *
           MOVE    V02-GAIDJGNGAK(IDX)  TO  SPA-GMN-GAIDJGNGAK (IDX)
      *
           ADD     1                    TO  SPA-GMN-CUR
           .
       4115-GAIDJGNGAK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来日上限回数チェック処理
      *****************************************************************
       4116-GAIDJGNCNT-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIDJGNCNT1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIDJGNCNT2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIDJGNCNT3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIDJGNCNT4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   25  
      *
           MOVE    V02-GAIDJGNCNT(IDX) TO  SPA-GMN-GAIDJGNCNT (IDX)
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
       4116-GAIDJGNCNT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来月院内上限額チェック処理
      *****************************************************************
       4117-GAIMNAIJGNGAK-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIMNAIJGNGAK1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIMNAIJGNGAK2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIMNAIJGNGAK3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIMNAIJGNGAK4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   26  
      *
           MOVE    V02-GAIMNAIJGNGAK(IDX)
                                  TO  SPA-GMN-GAIMNAIJGNGAK (IDX)
      *
           ADD     1              TO  SPA-GMN-CUR
           .
       4117-GAIMNAIJGNGAK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来月院外上限額チェック処理
      *****************************************************************
       4118-GAIMGAIJGNGAK-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIMGAIJGNGAK1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIMGAIJGNGAK2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIMGAIJGNGAK3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIMGAIJGNGAK4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   27  
      *
           MOVE    V02-GAIMGAIJGNGAK   (IDX)
                                   TO  SPA-GMN-GAIMGAIJGNGAK (IDX)
      *
           ADD     1               TO  SPA-GMN-CUR
           .
       4118-GAIMGAIJGNGAK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来月上限回数チェック処理
      *****************************************************************
       4119-GAIMJGNCNT-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIMJGNCNT1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIMJGNCNT2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIMJGNCNT3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIMJGNCNT4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   28  
      *
           MOVE    V02-GAIMJGNCNT  (IDX)
                                   TO  SPA-GMN-GAIMJGNCNT (IDX)
      *
           ADD     1               TO  SPA-GMN-CUR
           .
       4119-GAIMJGNCNT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    外来薬剤負担区分チェック処理
      *****************************************************************
       4120-GAIYKZFTNKBN-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "GAIYKZFTNKBN1"
                   MOVE    1                   TO  IDX
               WHEN    "GAIYKZFTNKBN2"
                   MOVE    2                   TO  IDX
               WHEN    "GAIYKZFTNKBN3"
                   MOVE    3                   TO  IDX
               WHEN    "GAIYKZFTNKBN4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   29  
      *
           MOVE    V02-GAIYKZFTNKBN    (IDX)
                                       TO  SPA-GMN-GAIYKZFTNKBN-G(IDX)
      *
           IF      SPA-GMN-GAIYKZFTNKBNMEI (IDX)  =   SPACE
              MOVE    "0007"           TO  SPA-ERRCD
           ELSE       
               ADD     1               TO  SPA-GMN-CUR
           END-IF    
           .
       4120-GAIYKZFTNKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院負担区分チェック
      *****************************************************************
       4121-NYUFTNKBN-CHK-SEC       SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "NYUFTNKBN1"
                   MOVE    1                   TO  IDX
               WHEN    "NYUFTNKBN2"
                   MOVE    2                   TO  IDX
               WHEN    "NYUFTNKBN3"
                   MOVE    3                   TO  IDX
               WHEN    "NYUFTNKBN4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   30  
      *
           MOVE    V02-NYUFTNKBN   (IDX)
                                   TO  SPA-GMN-NYUFTNKBN-G (IDX)
      *
           IF      SPA-GMN-NYUFTNKBNMEI (IDX)  =   SPACE
              MOVE    "0008"           TO  SPA-ERRCD
           ELSE
               IF      SPA-GMN-NYUFTNKBN (IDX) =   "3"
                   IF      SPA-V01-HKNNUM (1:1)    >=  "1" AND <= "8"
                       CONTINUE
                   ELSE
                       MOVE    "0010"              TO  SPA-ERRCD
                   END-IF
               END-IF
      *
           IF      SPA-ERRCD           =   SPACE                           
               ADD     1               TO  SPA-GMN-CUR
           END-IF    
           .
       4121-NYUFTNKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院回負担割合チェック処理
      *****************************************************************
       4122-NYUKFTNRATE-CHK-SEC           SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "NYUKFTNRATE1"
                   MOVE    1                   TO  IDX
               WHEN    "NYUKFTNRATE2"
                   MOVE    2                   TO  IDX
               WHEN    "NYUKFTNRATE3"
                   MOVE    3                   TO  IDX
               WHEN    "NYUKFTNRATE4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   31  
      *
           MOVE    V02-NYUKFTNRATE (IDX)
                                   TO  SPA-GMN-NYUKFTNRATE (IDX)
      *
           ADD     1               TO  SPA-GMN-CUR
           .
       4122-NYUKFTNRATE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院回固定額チェック処理
      *****************************************************************
       4123-NYUKKOTGAK-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "NYUKKOTGAK1"
                   MOVE    1                   TO  IDX
               WHEN    "NYUKKOTGAK2"
                   MOVE    2                   TO  IDX
               WHEN    "NYUKKOTGAK3"
                   MOVE    3                   TO  IDX
               WHEN    "NYUKKOTGAK4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   32  
      *
           MOVE    V02-NYUKKOTGAK(IDX)  TO  SPA-GMN-NYUKKOTGAK (IDX)
      *
           ADD     1                    TO  SPA-GMN-CUR
           . 
       4123-NYUKKOTGAK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院回上限額チェック処理
      *****************************************************************
       4124-NYUKJGNGAK-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "NYUKJGNGAK1"
                   MOVE    1                   TO  IDX
               WHEN    "NYUKJGNGAK2"
                   MOVE    2                   TO  IDX
               WHEN    "NYUKJGNGAK3"
                   MOVE    3                   TO  IDX
               WHEN    "NYUKJGNGAK4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   33  
      *
           MOVE    V02-NYUKJGNGAK(IDX)  TO  SPA-GMN-NYUKJGNGAK (IDX)
      *
           ADD     1                    TO  SPA-GMN-CUR
           .
       4124-NYUKJGNGAK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院月上限額チェック処理
      *****************************************************************
       4125-NYUDJGNGAK-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "NYUDJGNGAK1"
                   MOVE    1                   TO  IDX
               WHEN    "NYUDJGNGAK2"
                   MOVE    2                   TO  IDX
               WHEN    "NYUDJGNGAK3"
                   MOVE    3                   TO  IDX
               WHEN    "NYUDJGNGAK4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   34  
      *
           MOVE    V02-NYUDJGNGAK(IDX)  TO  SPA-GMN-NYUDJGNGAK (IDX)
      *
           ADD     1                    TO  SPA-GMN-CUR
           .
       4125-NYUDJGNGAK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院日上限回数チェック処理
      *****************************************************************
       4126-NYUDJGNCNT-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "NYUDJGNCNT1"
                   MOVE    1                   TO  IDX
               WHEN    "NYUDJGNCNT2"
                   MOVE    2                   TO  IDX
               WHEN    "NYUDJGNCNT3"
                   MOVE    3                   TO  IDX
               WHEN    "NYUDJGNCNT4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   35  
      *
           MOVE    V02-NYUDJGNCNT(IDX)  TO  SPA-GMN-NYUDJGNCNT (IDX)
      *
           ADD     1                    TO  SPA-GMN-CUR
           .
       4126-NYUDJGNCNT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院月院内上限額チェック処理
      *****************************************************************
       4127-NYUMJGNGAK-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "NYUMJGNGAK1"
                   MOVE    1                   TO  IDX
               WHEN    "NYUMJGNGAK2"
                   MOVE    2                   TO  IDX
               WHEN    "NYUMJGNGAK3"
                   MOVE    3                   TO  IDX
               WHEN    "NYUMJGNGAK4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   36
      *
           MOVE    V02-NYUMJGNGAK    (IDX)
                                        TO  SPA-GMN-NYUMJGNGAK (IDX)
      *
           ADD     1                    TO  SPA-GMN-CUR
           .
       4127-NYUMJGNGAK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院月上限回数チェック処理
      *****************************************************************
       4128-NYUMJGNCNT-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "NYUMJGNCNT1"
                   MOVE    1                   TO  IDX
               WHEN    "NYUMJGNCNT2"
                   MOVE    2                   TO  IDX
               WHEN    "NYUMJGNCNT3"
                   MOVE    3                   TO  IDX
               WHEN    "NYUMJGNCNT4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   37  
      *
           MOVE    V02-NYUMJGNCNT(IDX) TO  SPA-GMN-NYUMJGNCNT (IDX)
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
       4128-NYUMJGNCNT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院食事療養費区分チェック処理
      *****************************************************************
       4129-NYUSKJRYYKBN-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "NYUSKJRYYKBN1"
                   MOVE    1                   TO  IDX
               WHEN    "NYUSKJRYYKBN2"
                   MOVE    2                   TO  IDX
               WHEN    "NYUSKJRYYKBN3"
                   MOVE    3                   TO  IDX
               WHEN    "NYUSKJRYYKBN4"
                   MOVE    4                   TO  IDX
           END-EVALUATE 
           COMPUTE SPA-GMN-CUR     =   (IDX -   1) *   30  +   38  
      *
           MOVE    V02-NYUSKJRYYKBN(IDX)
                                   TO  SPA-GMN-NYUSKJRYYKBN-G (IDX)
      *
           IF      SPA-GMN-NYUSKJRYYKBNMEI (IDX)  =   SPACE
              MOVE    "0009"       TO  SPA-ERRCD
           ELSE       
               COMPUTE SPA-GMN-CUR     =   SPA-GMN-CUR     -   18
           END-IF    
           .
       4129-NYUSKJRYYKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    タグ編集処理
      *****************************************************************
       440-TAG-CHANGE-SEC            SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "N01"
                   MOVE   0            TO  WRK-PAGENO
               WHEN    "N02"
                  MOVE    1            TO  WRK-PAGENO
               WHEN    "N03"
                   MOVE   2            TO  WRK-PAGENO
               WHEN    "N04"
                   MOVE   3            TO  WRK-PAGENO
           END-EVALUATE
      *
      *    タグが変わったとき関連チェック
           IF      WRK-PAGENO      NOT =   SPA-GMN-PAGENO
               PERFORM 4900-KANRENCHK-SEC
           END-IF
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-PAGENO           TO  SPA-GMN-PAGENO
               EVALUATE    WRK-PAGENO
                   WHEN    0
                       MOVE    20           TO  SPA-GMN-CUR
                   WHEN    1
                       MOVE    50           TO  SPA-GMN-CUR
                   WHEN    2
                       MOVE    80           TO  SPA-GMN-CUR
                   WHEN    3
                       MOVE    110          TO  SPA-GMN-CUR
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
           MOVE    "V01"               TO  SPA-SAKIPG
           MOVE    "V02"               TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-V01KYOUTU
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
           MOVE    "1002"              TO  SPA-VIDCD
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
           INITIALIZE                      HKNNUM-REC
           MOVE    SPA-HOSPID              TO  HKN-HOSPID
           MOVE    SPA-V01-HKNNUM          TO  HKN-HKNNUM
           MOVE    SPA-V01-PAYKBN          TO  HKN-PAYKBN
           MOVE    SPA-V01-STYUKYMD        TO  HKN-TEKSTYMD
           MOVE    SPA-V01-EDYUKYMD        TO  HKN-TEKEDYMD
           MOVE    HKNNUM-REC              TO  MCPDATA-REC
           MOVE    "DBDELETE"              TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"            TO  ORC-DBPATH
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
           PERFORM 4900-KANRENCHK-SEC
           IF      SPA-ERRCD        =   SPACE
               MOVE    "1001"           TO  SPA-VIDCD
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
           INITIALIZE                      HKNNUM-REC
           MOVE    SPA-HOSPID              TO  HKN-HOSPID
           MOVE    SPA-V01-HKNNUM          TO  HKN-HKNNUM
           MOVE    SPA-V01-PAYKBN          TO  HKN-PAYKBN
           MOVE    SPA-V01-STYUKYMD        TO  HKN-TEKSTYMD
           MOVE    SPA-V01-EDYUKYMD        TO  HKN-TEKEDYMD
           MOVE    HKNNUM-REC              TO  MCPDATA-REC
           PERFORM 900-HKNNUM-INV-SEC
           IF      FLG-HKNNUM              =   ZERO
               MOVE    MCPDATA-REC             TO  HKNNUM-REC
           ELSE
               MOVE    SPACE                   TO  HKNNUM-REC
               INITIALIZE                      HKNNUM-REC
               MOVE    SPA-HOSPID              TO  HKN-HOSPID
               MOVE    SPA-V01-HKNNUM          TO  HKN-HKNNUM
               MOVE    SPA-V01-PAYKBN          TO  HKN-PAYKBN
               MOVE    SPA-V01-STYUKYMD        TO  HKN-TEKSTYMD
           END-IF 
           MOVE    SPA-V01-EDYUKYMD        TO  HKN-TEKEDYMD
           MOVE    SPA-GMN-HBTNUM          TO  HKN-HBTNUM 
           MOVE    SPA-GMN-SEIDONAME       TO  HKN-SEIDONAME 
           MOVE    SPA-GMN-TANSEIDONAME    TO  HKN-TANSEIDONAME 
           MOVE    SPA-GMN-HKNKOHSBTKBN    TO  HKN-HKNKOHSBTKBN 
           MOVE    SPA-GMN-KENSNUMCHKKBN   TO  HKN-KENSNUMCHKKBN 
           MOVE    SPA-GMN-JKYSKENSNUMCHKKBN
                                           TO  HKN-JKYSKENSNUMCHKKBN 
           MOVE    SPA-GMN-HKNKOHKBN       TO  HKN-HKNKOHKBN 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       3  
               MOVE    SPA-GMN-GENHKNNUM (IDX) TO  HKN-GENHKNNUM (IDX)
           END-PERFORM
           MOVE    SPA-GMN-JOKENSTYEAR     TO  HKN-JOKEN-STYEAR 
           MOVE    SPA-GMN-JOKENEDYEAR     TO  HKN-JOKEN-EDYEAR 
           MOVE    SPA-GMN-TENTNK          TO  HKN-TENTNK
           MOVE    SPA-GMN-RECESKYKBN      TO  HKN-RECESKYKBN
      *        
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       4  
               MOVE    SPA-GMN-GAIFTNKBN       (IDX)
                                       TO  HKN-GAIFTNKBN     (IDX)
               MOVE    SPA-GMN-GAIKFTNRATE     (IDX)
                                       TO  HKN-GAIKFTNRATE   (IDX)
               MOVE    SPA-GMN-GAIKKOTGAK      (IDX) 
                                       TO  HKN-GAIKKOTGAK    (IDX) 
               MOVE    SPA-GMN-GAIKJGNGAK      (IDX)
                                       TO  HKN-GAIKJGNGAK    (IDX)
               MOVE    SPA-GMN-GAIDJGNGAK      (IDX)
                                       TO  HKN-GAIDJGNGAK    (IDX)
               MOVE    SPA-GMN-GAIDJGNCNT      (IDX)
                                       TO  HKN-GAIDJGNCNT    (IDX)    
               MOVE    SPA-GMN-GAIMNAIJGNGAK   (IDX)
                                       TO  HKN-GAIMNAIJGNGAK (IDX)    
               MOVE    SPA-GMN-GAIMGAIJGNGAK   (IDX)
                                       TO  HKN-GAIMGAIJGNGAK (IDX)    
               MOVE    SPA-GMN-GAIMJGNCNT      (IDX)
                                       TO  HKN-GAIMJGNCNT    (IDX)    
               MOVE    SPA-GMN-GAIYKZFTNKBN    (IDX)
                                       TO  HKN-GAIYKZFTNKBN  (IDX)    
               MOVE    SPA-GMN-NYUFTNKBN       (IDX)
                                       TO  HKN-NYUFTNKBN     (IDX)   
               MOVE    SPA-GMN-NYUKFTNRATE     (IDX)
                                       TO  HKN-NYUKFTNRATE   (IDX)    
               MOVE    SPA-GMN-NYUKKOTGAK      (IDX)
                                       TO  HKN-NYUKKOTGAK    (IDX)    
               MOVE    SPA-GMN-NYUKJGNGAK      (IDX)
                                       TO  HKN-NYUKJGNGAK    (IDX)    
               MOVE    SPA-GMN-NYUDJGNGAK      (IDX)
                                       TO  HKN-NYUDJGNGAK    (IDX)   
               MOVE    SPA-GMN-NYUDJGNCNT      (IDX)
                                       TO  HKN-NYUDJGNCNT    (IDX)    
               MOVE    SPA-GMN-NYUMJGNGAK      (IDX)
                                       TO  HKN-NYUMJGNGAK    (IDX)    
               MOVE    SPA-GMN-NYUMJGNCNT      (IDX)
                                       TO  HKN-NYUMJGNCNT    (IDX)    
               MOVE    SPA-GMN-NYUSKJRYYKBN    (IDX)
                                       TO  HKN-NYUSKJRYYKBN  (IDX)   
           END-PERFORM 
      *
           MOVE    HKNNUM-REC              TO  MCPDATA-REC
           MOVE    "HKNNUM-KEY"            TO  ORC-DBPATH
           IF      FLG-HKNNUM              =   ZERO
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
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
           MOVE    SPA-GMN-CUR          TO  WRK-GMN-CUR
      *
           EVALUATE    SPA-GMN-PAGENO
               WHEN    0
                   PERFORM 4901-TAG1-CHK-SEC
               WHEN    1
                   PERFORM 4901-TAG2-CHK-SEC
               WHEN    2
                   PERFORM 4901-TAG3-CHK-SEC
               WHEN    3
                   PERFORM 4901-TAG4-CHK-SEC
           END-EVALUATE
      *
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-GMN-CUR          TO SPA-GMN-CUR
           END-IF         
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       本人情報タグの関連チェック処理
      *****************************************************************
       4901-TAG1-CHK-SEC           SECTION.
      *
           MOVE    "GAIFTNKBN1"    TO  MCP-WIDGET
           PERFORM 4111-GAIFTNKBN-CHK-SEC
      *
           IF      SPA-ERRCD       =   SPACE     
               MOVE    "NYUFTNKBN1"    TO  MCP-WIDGET
               PERFORM 4121-NYUFTNKBN-CHK-SEC
           END-IF    
           .
       4901-TAG1-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       家族情報タグの関連チェック処理
      *****************************************************************
       4901-TAG2-CHK-SEC           SECTION.
      *
           MOVE    "GAIFTNKBN2"    TO  MCP-WIDGET
           PERFORM 4111-GAIFTNKBN-CHK-SEC
      *
           IF      SPA-ERRCD       =   SPACE     
               MOVE    "NYUFTNKBN2"    TO  MCP-WIDGET
               PERFORM 4121-NYUFTNKBN-CHK-SEC
           END-IF    
           .
       4901-TAG2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       低所得情報タグの関連チェック処理
      *****************************************************************
       4901-TAG3-CHK-SEC           SECTION.
      *
           MOVE    "GAIFTNKBN3"    TO  MCP-WIDGET
           PERFORM 4111-GAIFTNKBN-CHK-SEC
      *
           IF      SPA-ERRCD       =   SPACE     
               MOVE    "NYUFTNKBN3"    TO  MCP-WIDGET
               PERFORM 4121-NYUFTNKBN-CHK-SEC
           END-IF    
           .
       4901-TAG3-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       定年金情報タグの関連チェック処理
      *****************************************************************
       4901-TAG4-CHK-SEC           SECTION.
      *
           MOVE    "GAIFTNKBN4"    TO  MCP-WIDGET
           PERFORM 4111-GAIFTNKBN-CHK-SEC
      *
           IF      SPA-ERRCD       =   SPACE     
               MOVE    "NYUFTNKBN4"    TO  MCP-WIDGET
               PERFORM 4121-NYUFTNKBN-CHK-SEC
           END-IF    
           .
       4901-TAG4-CHK-EXT.
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
           IF      SPA-VIDCD       NOT =   SPACE
               PERFORM 520-VIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "V02    "           TO  MCP-WINDOW.
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
           MOVE    SPA-GMN-STYUKYMD     TO  V02-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD     TO  V02-EDYUKYMD
           MOVE    SPA-GMN-HKNNUM       TO  V02-HKNNUM
           MOVE    SPA-GMN-PAYKBN       TO  V02-PAYKBN
      * 
           MOVE    SPA-GMN-HBTNUM       TO  V02-HBTNUM
           MOVE    SPA-GMN-SEIDONAME    TO  V02-SEIDONAME
           MOVE    SPA-GMN-TANSEIDONAME TO  V02-TANSEIDONAME
           MOVE    SPA-GMN-HKNKOHSBTKBN-G
                                        TO  V02-HKNKOHSBTKBN
           MOVE    SPA-GMN-KENSNUMCHKKBN-G
                                        TO  V02-KENSNUMCHKKBN
           MOVE    SPA-GMN-JKYSKENSNUMCHKKBN-G
                                        TO  V02-JKYSKENSNUMCHKKBN
           MOVE    SPA-GMN-HKNKOHKBN-G  TO  V02-HKNKOHKBN
           PERFORM VARYING IDX FROM     1  BY  1
                   UNTIL   IDX >        3  
               MOVE    SPA-GMN-GENHKNNUM (IDX) TO  V02-GENHKNNUM (IDX)
           END-PERFORM
           MOVE    SPA-GMN-JOKENSTYEAR  TO  V02-JOKENSTYEAR  
           MOVE    SPA-GMN-JOKENEDYEAR  TO  V02-JOKENEDYEAR
           MOVE    SPA-GMN-TENTNK       TO  V02-TENTNK
           MOVE    SPA-GMN-RECESKYKBN-G TO  V02-RECESKYKBN
      *
           PERFORM VARYING IDX FROM     1  BY  1
                   UNTIL   IDX >        4  
               MOVE    SPA-GMN-GAIFTNKBN-G     (IDX)
                                        TO  V02-GAIFTNKBN     (IDX)
               MOVE    SPA-GMN-GAIKFTNRATE     (IDX)
                                        TO  V02-GAIKFTNRATE   (IDX) 
               MOVE    SPA-GMN-GAIKKOTGAK      (IDX)
                                        TO  V02-GAIKKOTGAK    (IDX) 
               MOVE    SPA-GMN-GAIKJGNGAK      (IDX)
                                        TO  V02-GAIKJGNGAK    (IDX) 
               MOVE    SPA-GMN-GAIDJGNGAK      (IDX)
                                        TO  V02-GAIDJGNGAK    (IDX)
               MOVE    SPA-GMN-GAIDJGNCNT      (IDX)
                                        TO  V02-GAIDJGNCNT    (IDX) 
               MOVE    SPA-GMN-GAIMNAIJGNGAK   (IDX)
                                        TO  V02-GAIMNAIJGNGAK (IDX) 
               MOVE    SPA-GMN-GAIMGAIJGNGAK   (IDX)
                                        TO  V02-GAIMGAIJGNGAK (IDX)
               MOVE    SPA-GMN-GAIMJGNCNT      (IDX)
                                        TO  V02-GAIMJGNCNT    (IDX)
               MOVE    SPA-GMN-GAIYKZFTNKBN-G  (IDX)
                                        TO  V02-GAIYKZFTNKBN  (IDX)
               MOVE    SPA-GMN-NYUFTNKBN-G     (IDX)
                                        TO  V02-NYUFTNKBN     (IDX)
               MOVE    SPA-GMN-NYUKFTNRATE     (IDX)
                                        TO  V02-NYUKFTNRATE   (IDX)
               MOVE    SPA-GMN-NYUKKOTGAK      (IDX)
                                        TO  V02-NYUKKOTGAK    (IDX)
               MOVE    SPA-GMN-NYUKJGNGAK      (IDX)
                                        TO  V02-NYUKJGNGAK    (IDX)
               MOVE    SPA-GMN-NYUDJGNGAK      (IDX)
                                        TO  V02-NYUDJGNGAK    (IDX)
               MOVE    SPA-GMN-NYUDJGNCNT      (IDX)
                                        TO  V02-NYUDJGNCNT    (IDX)
               MOVE    SPA-GMN-NYUMJGNGAK      (IDX)
                                        TO  V02-NYUMJGNGAK    (IDX)
               MOVE    SPA-GMN-NYUMJGNCNT      (IDX)
                                        TO  V02-NYUMJGNCNT    (IDX)
               MOVE    SPA-GMN-NYUSKJRYYKBN-G  (IDX)
                                        TO  V02-NYUSKJRYYKBN  (IDX)
           END-PERFORM
      *     
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX     >   SPA-GMN-HKNKOHSBTKBN-MAX
               MOVE    SPA-GMN-HKNKOHSBTKBNLST (IDX)
                                       TO  V02-HKNKOHSBTKBNLST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-HKNKOHSBTKBN-MAX
                                       TO  V02-HKNKOHSBTKBN-COUNT
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX     >   SPA-GMN-KENSNUMCHKKBN-MAX
               MOVE    SPA-GMN-KENSNUMCHKKBNLST (IDX)
                                       TO  V02-KENSNUMCHKKBNLST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-KENSNUMCHKKBN-MAX
                                       TO  V02-KENSNUMCHKKBN-COUNT
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX     >   SPA-GMN-JKYSKENSNUMCHKKBN-MAX
               MOVE    SPA-GMN-JKYSKENSNUMCHKKBNLST (IDX)
                                   TO  V02-JKYSKENSNUMCHKKBNLST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-JKYSKENSNUMCHKKBN-MAX
                                       TO  V02-JKYSKENSNUMCHKKBN-COUNT
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX     >   SPA-GMN-HKNKOHKBN-MAX
               MOVE    SPA-GMN-HKNKOHKBNLST (IDX)
                                       TO  V02-HKNKOHKBNLST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-HKNKOHKBN-MAX
                                       TO  V02-HKNKOHKBN-COUNT
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX     >   SPA-GMN-RECESKYKBN-MAX
               MOVE    SPA-GMN-RECESKYKBNLST (IDX)
                                       TO  V02-RECESKYKBNLST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-RECESKYKBN-MAX
                                       TO  V02-RECESKYKBN-COUNT
                                                    
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       4
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX     >   SPA-GMN-GAIYKZFTNKBN-MAX
                   MOVE    SPA-GMN-GAIYKZFTNKBNLST (IDX)
                                   TO  V02-GAIYKZFTNKBNLST (IDY IDX)
               END-PERFORM
               MOVE    SPA-GMN-GAIYKZFTNKBN-MAX
                                   TO  V02-GAIYKZFTNKBN-COUNT (IDY)
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-GAIFTNKBN-MAX
                   MOVE    SPA-GMN-GAIFTNKBNLST (IDX)
                                   TO  V02-GAIFTNKBNLST (IDY IDX)
               END-PERFORM
               MOVE    SPA-GMN-GAIFTNKBN-MAX
                                   TO  V02-GAIFTNKBN-COUNT (IDY)
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-NYUFTNKBN-MAX
                  MOVE    SPA-GMN-NYUFTNKBNLST (IDX)
                                   TO  V02-NYUFTNKBNLST (IDY IDX)
               END-PERFORM
               MOVE    SPA-GMN-NYUFTNKBN-MAX
                                   TO  V02-NYUFTNKBN-COUNT (IDY)
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-NYUSKJRYYKBN-MAX
                   MOVE    SPA-GMN-NYUSKJRYYKBNLST (IDX)
                                   TO  V02-NYUSKJRYYKBNLST (IDY IDX)
               END-PERFORM
               MOVE    SPA-GMN-NYUSKJRYYKBN-MAX
                                   TO  V02-NYUSKJRYYKBN-COUNT (IDY)
           END-PERFORM                                         
      *
           MOVE    SPA-GMN-PAGENO       TO  V02-PAGENO      
      *
      *
           MOVE    WIDGET-INSENSITIVE     TO  V02-B03-STATE
      *
           IF      SPA-V01-SELNUM          >   ZERO    
               MOVE    WIDGET-NORMAL      TO  V02-B03-STATE
           END-IF
      *      
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
                   MOVE    "保険公費種別区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "検証番号チェック区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "受給者検証番号チェック区分区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "公費主保区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "レセプト請求区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "外来・負担区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "薬剤負担区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "入院・負担区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "食事療養費入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "該当の保険番号のとき選べない負担区分です"
                                               TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "保険番号マスタの更新処理ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "保険番号マスタの削除処理ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  VERR
           MOVE    SPA-ERRCD            TO  VERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  VERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "V02"                TO  SPA-MOTOPG
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
      *    ガイドメッセージ表示
      *****************************************************************
       520-VIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-VIDMSG
      *
           EVALUATE    SPA-VIDCD
               WHEN    "1001"
                   MOVE    "保険番号マスタを登録します"
                                       TO  WRK-VIDMSG
               WHEN    "1002"
                   MOVE    "保険番号マスタを削除します"
                                       TO  WRK-VIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  VID1
           MOVE    SPA-VIDCD            TO  VID1-ID1CODE
           MOVE    WRK-VIDMSG           TO  VID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "V02"                TO  SPA-MOTOPG
           MOVE    "VID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "VID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-VIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理    
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
          EVALUATE    SPA-GMN-CUR
                WHEN    01
                    MOVE  "HBTNUM"         TO   MCP-WIDGET
                WHEN    02
                    MOVE  "SEIDONAME"      TO   MCP-WIDGET
                WHEN    03
                    MOVE  "TANSEIDONAME"   TO   MCP-WIDGET
                WHEN    04
                    MOVE  "HKNKOHSBTKBN"   TO   MCP-WIDGET
                WHEN    05
                    MOVE  "KENSNUMCHKKBN"  TO   MCP-WIDGET
                WHEN    06
                    MOVE  "JKYSKENSNUMCHKKBN"
                                           TO   MCP-WIDGET
                WHEN    07
                    MOVE  "HKNKOHKBN"      TO   MCP-WIDGET
                WHEN    08
                    MOVE  "GENHKNNUM1"      TO   MCP-WIDGET
                WHEN    09
                    MOVE  "GENHKNNUM2"      TO   MCP-WIDGET
                WHEN    10
                    MOVE  "GENHKNNUM3"      TO   MCP-WIDGET
                WHEN    11
                    MOVE  "JOKENSTYEAR"     TO   MCP-WIDGET
                WHEN    12
                    MOVE  "JOKENEDYEAR"     TO   MCP-WIDGET
                WHEN    13
                    MOVE  "TENTNK"          TO   MCP-WIDGET
                WHEN    14
                    MOVE  "RECESKYKBN"      TO   MCP-WIDGET
      * 
                WHEN    20
                    MOVE  "GAIFTNKBN1"      TO   MCP-WIDGET
                WHEN    21
                    MOVE  "GAIKFTNRATE1"    TO   MCP-WIDGET
                WHEN    22
                    MOVE  "GAIKKOTGAK1"     TO   MCP-WIDGET
                WHEN    23
                    MOVE  "GAIKJGNGAK1"     TO   MCP-WIDGET
                WHEN    24
                    MOVE  "GAIDJGNGAK1"     TO   MCP-WIDGET
                WHEN    25
                    MOVE  "GAIDJGNCNT1"     TO   MCP-WIDGET
                WHEN    26
                    MOVE  "GAIMNAIJGNGAK1"  TO   MCP-WIDGET
                WHEN    27
                    MOVE  "GAIMGAIJGNGAK1"  TO   MCP-WIDGET
                WHEN    28
                    MOVE  "GAIMJGNCNT1"     TO   MCP-WIDGET
                WHEN    29
                    MOVE  "GAIYKZFTNKBN1"   TO   MCP-WIDGET
                WHEN    30
                    MOVE  "NYUFTNKBN1"      TO   MCP-WIDGET
                WHEN    31
                    MOVE  "NYUKFTNRATE1"    TO   MCP-WIDGET
                WHEN    32
                    MOVE  "NYUKKOTGAK1"     TO   MCP-WIDGET
                WHEN    33
                    MOVE  "NYUKJGNGAK1"     TO   MCP-WIDGET
                WHEN    34
                    MOVE  "NYUDJGNGAK1"     TO   MCP-WIDGET
                WHEN    35
                    MOVE  "NYUDJGNCNT1"     TO   MCP-WIDGET
                WHEN    36
                    MOVE  "NYUMJGNGAK1"     TO   MCP-WIDGET
                WHEN    37
                    MOVE  "NYUMJGNCNT1"     TO   MCP-WIDGET
                WHEN    38
                    MOVE  "NYUSKJRYYKBN1"   TO   MCP-WIDGET
      * 
                WHEN    50
                    MOVE  "GAIFTNKBN2"      TO   MCP-WIDGET
                WHEN    51
                    MOVE  "GAIKFTNRATE2"    TO   MCP-WIDGET
                WHEN    52
                    MOVE  "GAIKKOTGAK2"     TO   MCP-WIDGET
                WHEN    53
                    MOVE  "GAIKJGNGAK2"     TO   MCP-WIDGET
                WHEN    54
                    MOVE  "GAIDJGNGAK2"     TO   MCP-WIDGET
                WHEN    55
                    MOVE  "GAIDJGNCNT2"     TO   MCP-WIDGET
                WHEN    56
                    MOVE  "GAIMNAIJGNGAK2"  TO   MCP-WIDGET
                WHEN    57
                    MOVE  "GAIMGAIJGNGAK2"  TO   MCP-WIDGET
                WHEN    58
                    MOVE  "GAIMJGNCNT2"     TO   MCP-WIDGET
                WHEN    59
                    MOVE  "GAIYKZFTNKBN2"   TO   MCP-WIDGET
                WHEN    60
                    MOVE  "NYUFTNKBN2"      TO   MCP-WIDGET
                WHEN    61
                    MOVE  "NYUKFTNRATE2"    TO   MCP-WIDGET
                WHEN    62
                    MOVE  "NYUKKOTGAK2"     TO   MCP-WIDGET
                WHEN    63
                    MOVE  "NYUKJGNGAK2"     TO   MCP-WIDGET
                WHEN    64
                    MOVE  "NYUDJGNGAK2"     TO   MCP-WIDGET
                WHEN    65
                    MOVE  "NYUDJGNCNT2"     TO   MCP-WIDGET
                WHEN    66
                    MOVE  "NYUMJGNGAK2"     TO   MCP-WIDGET
                WHEN    67
                    MOVE  "NYUMJGNCNT2"     TO   MCP-WIDGET
                WHEN    68
                    MOVE  "NYUSKJRYYKBN2"   TO   MCP-WIDGET
      * 
                WHEN    80
                    MOVE  "GAIFTNKBN3"      TO   MCP-WIDGET
                WHEN    81
                    MOVE  "GAIKFTNRATE3"    TO   MCP-WIDGET
                WHEN    82
                    MOVE  "GAIKKOTGAK3"     TO   MCP-WIDGET
                WHEN    83
                    MOVE  "GAIKJGNGAK3"     TO   MCP-WIDGET
                WHEN    84
                    MOVE  "GAIDJGNGAK3"     TO   MCP-WIDGET
                WHEN    85
                    MOVE  "GAIDJGNCNT3"     TO   MCP-WIDGET
                WHEN    86
                    MOVE  "GAIMNAIJGNGAK3"  TO   MCP-WIDGET
                WHEN    87
                    MOVE  "GAIMGAIJGNGAK3"  TO   MCP-WIDGET
                WHEN    88
                    MOVE  "GAIMJGNCNT3"     TO   MCP-WIDGET
                WHEN    89
                    MOVE  "GAIYKZFTNKBN3"   TO   MCP-WIDGET
                WHEN    90
                    MOVE  "NYUFTNKBN3"      TO   MCP-WIDGET
                WHEN    91
                    MOVE  "NYUKFTNRATE3"    TO   MCP-WIDGET
                WHEN    92
                    MOVE  "NYUKKOTGAK3"     TO   MCP-WIDGET
                WHEN    93
                    MOVE  "NYUKJGNGAK3"     TO   MCP-WIDGET
                WHEN    94
                    MOVE  "NYUDJGNGAK3"     TO   MCP-WIDGET
                WHEN    95
                    MOVE  "NYUDJGNCNT3"     TO   MCP-WIDGET
                WHEN    96
                    MOVE  "NYUMJGNGAK3"     TO   MCP-WIDGET
                WHEN    97
                    MOVE  "NYUMJGNCNT3"     TO   MCP-WIDGET
                WHEN    98
                    MOVE  "NYUSKJRYYKBN3"   TO   MCP-WIDGET
      * 
                WHEN    110
                    MOVE  "GAIFTNKBN4"      TO   MCP-WIDGET
                WHEN    111
                    MOVE  "GAIKFTNRATE4"    TO   MCP-WIDGET
                WHEN    112
                    MOVE  "GAIKKOTGAK4"     TO   MCP-WIDGET
                WHEN    113
                    MOVE  "GAIKJGNGAK4"     TO   MCP-WIDGET
                WHEN    114
                    MOVE  "GAIDJGNGAK4"     TO   MCP-WIDGET
                WHEN    115
                    MOVE  "GAIDJGNCNT4"     TO   MCP-WIDGET
                WHEN    116
                    MOVE  "GAIMNAIJGNGAK4"  TO   MCP-WIDGET
                WHEN    117
                    MOVE  "GAIMGAIJGNGAK4"  TO   MCP-WIDGET
                WHEN    118
                    MOVE  "GAIMJGNCNT4"     TO   MCP-WIDGET
                WHEN    119
                    MOVE  "GAIYKZFTNKBN4"   TO   MCP-WIDGET
                WHEN    120
                    MOVE  "NYUFTNKBN4"      TO   MCP-WIDGET
                WHEN    121
                    MOVE  "NYUKFTNRATE4"    TO   MCP-WIDGET
                WHEN    122
                    MOVE  "NYUKKOTGAK4"     TO   MCP-WIDGET
                WHEN    123
                    MOVE  "NYUKJGNGAK4"     TO   MCP-WIDGET
                WHEN    124
                    MOVE  "NYUDJGNGAK4"     TO   MCP-WIDGET
                WHEN    125
                    MOVE  "NYUDJGNCNT4"     TO   MCP-WIDGET
                WHEN    126
                    MOVE  "NYUMJGNGAK4"     TO   MCP-WIDGET
                WHEN    127
                    MOVE  "NYUMJGNCNT4"     TO   MCP-WIDGET
                WHEN    128
                    MOVE  "NYUSKJRYYKBN4"   TO   MCP-WIDGET
            END-EVALUATE
      *
      **      EVALUATE    SPA-GMN-CUR
      **          WHEN    20  THRU    49
      **              MOVE    0                TO  V02-PAGENO
      **          WHEN    50  THRU    79
      **              MOVE    1                TO  V02-PAGENO
      **          WHEN    80  THRU    109
      **              MOVE    2                TO  V02-PAGENO
      **          WHEN    110 THRU    139
      **              MOVE    3                TO  V02-PAGENO
      **      END-EVALUATE      
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
                                        BY          "0"         
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
