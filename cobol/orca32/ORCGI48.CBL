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
       PROGRAM-ID.                 ORCGI48.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院会計照会 
      *  コンポーネント名  : 診療行為一覧選択サブ（Ｉ４８）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02.09.19    ひさなが      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *
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
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    会計照会共通パラメタ
           COPY    "I4COMMON-SPA".
      *
      *    画面スパ領域
           COPY    "I4SCR-SPA4".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-INPUTCD         PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-ERR             PIC 9(01).
      *
           03  FLG-KANJI           PIC 9(01).
           03  FLG-KANA            PIC 9(01).
      *
           03  FLG-SYURYOU         PIC 9(01).
           03  FLG-MAX             PIC 9(01).
      *
           03  FLG-HENSYU          PIC 9(01).
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
           03  IDX-1               PIC 9(01).
      *
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDXC                PIC 9(04).
      *
           03  ID1                 PIC 9(04).
           03  ID2                 PIC 9(04).
      *
           03  IDX-K               PIC 9(04).
      *
           03  IDX-KAI             PIC 9(04).
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
           03  WRK-GMN-SELNO       PIC 9(03).
           03  WRK-NOZ             PIC ZZ9.
           03  WRK-TENSUS-X.
               05  WRK-TENSUS      PIC ZZZZZZ9.99.
      *
           03  WRK-INPUTCD         PIC X(22).
           03  WRK-GRP-MEI         PIC X(40).
           03  WRK-GRP-MEI-X       PIC X(40).
      *
           03  WRK-NAI-SELNUM-G.
               05  WRK-NAI-SELNUM  PIC 9(03)   OCCURS   5.
           03  WRK-GMN-SELNUM-G.
               05  WRK-GMN-SELNUM  PIC X(03)   OCCURS   5.
           03  WRK-I48-SRYCD-G.
               05  WRK-I48-SRYCD   PIC X(09)   OCCURS   5.
      *
           03  WRK-PATH            PIC X(64).
      *
           03  WRK-KETA            PIC 9(04).
      *
           03  WRK-HEN-NAME        PIC X(70).
           03  WRK-KENSA-HEN       PIC X(02).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
           03  WRK-WIDGET          PIC X(03).
           03  WRK-WIDGET-SW       PIC X(01).
           03  WRK-INPUTCD-W       PIC X(22).
      *
      *
      *    検査等実施判断グループ区分テーブル
       01  WRK-TBL-GRP.
           03  FILLER              PIC X(02)   VALUE   "01".
           03  FILLER              PIC X(40)   VALUE
                     "尿・糞便等検査".
           03  FILLER              PIC X(20)   VALUE
                     "尿・糞便等検査".
           03  FILLER              PIC X(02)   VALUE   "02".
           03  FILLER              PIC X(40)   VALUE   "血液学的検査".
           03  FILLER              PIC X(20)   VALUE   "血液学的検査".
           03  FILLER              PIC X(02)   VALUE   "31".
           03  FILLER              PIC X(40)   VALUE
                     "生化学的検査（１）（包括）".
           03  FILLER              PIC X(20)   VALUE
                     "生（１）（包括）".
           03  FILLER              PIC X(02)   VALUE   "32".
           03  FILLER              PIC X(40)   VALUE
                     "生化学的検査（１）（包括以外）".
           03  FILLER              PIC X(20)   VALUE
                     "生（１）（包括以外）".
           03  FILLER              PIC X(02)   VALUE   "41".
           03  FILLER              PIC X(40)   VALUE
                     "生化学的検査（２）（包括）".
           03  FILLER              PIC X(20)   VALUE
                     "生（２）（包括）".
           03  FILLER              PIC X(02)   VALUE   "42".
           03  FILLER              PIC X(40)   VALUE
                     "生化学的検査（２）（包括以外）".
           03  FILLER              PIC X(20)   VALUE
                     "生（２）（包括以外）".
           03  FILLER              PIC X(02)   VALUE   "05".
           03  FILLER              PIC X(40)   VALUE   "免疫学的検査".
           03  FILLER              PIC X(20)   VALUE   "免疫学的検査".
           03  FILLER              PIC X(02)   VALUE   "06".
           03  FILLER              PIC X(40)   VALUE
                     "微生物学的検査".
           03  FILLER              PIC X(20)   VALUE
                     "微生物学的検査".
           03  FILLER              PIC X(02)   VALUE   "07".
           03  FILLER              PIC X(40)   VALUE   "病理学的検査".
           03  FILLER              PIC X(20)   VALUE   "病理学的検査".
           03  FILLER              PIC X(02)   VALUE   "08".
           03  FILLER              PIC X(40)   VALUE
                     "基本的検体検査実施料".
           03  FILLER              PIC X(20)   VALUE
                     "基本的検体検査".
           03  FILLER              PIC X(02)   VALUE   "11".
           03  FILLER              PIC X(40)   VALUE
                     "呼吸循環機能検査".
           03  FILLER              PIC X(20)   VALUE
                     "呼吸循環機能検査".
           03  FILLER              PIC X(02)   VALUE   "12".
           03  FILLER              PIC X(40)   VALUE   "超音波検査".
           03  FILLER              PIC X(20)   VALUE   "超音波検査".
           03  FILLER              PIC X(02)   VALUE   "13".
           03  FILLER              PIC X(40)   VALUE
                     "監視装置による諸検査".
           03  FILLER              PIC X(20)   VALUE
                     "監視装置による諸検査".
           03  FILLER              PIC X(02)   VALUE   "14".
           03  FILLER              PIC X(40)   VALUE   "脳波検査".
           03  FILLER              PIC X(20)   VALUE   "脳波検査".
           03  FILLER              PIC X(02)   VALUE   "15".
           03  FILLER              PIC X(40)   VALUE   "神経・筋検査".
           03  FILLER              PIC X(20)   VALUE   "神経・筋検査".
           03  FILLER              PIC X(02)   VALUE   "16".
           03  FILLER              PIC X(40)   VALUE
                     "耳鼻咽喉科学的検査".
           03  FILLER              PIC X(20)   VALUE
                     "耳鼻咽喉科学的検査".
           03  FILLER              PIC X(02)   VALUE   "17".
           03  FILLER              PIC X(40)   VALUE   "眼科学的検査".
           03  FILLER              PIC X(20)   VALUE   "眼科学的検査".
           03  FILLER              PIC X(02)   VALUE   "18".
           03  FILLER              PIC X(40)   VALUE
                     "臨床心理神経心理検査".
           03  FILLER              PIC X(20)   VALUE
                     "臨床心理神経心理検査".
           03  FILLER              PIC X(02)   VALUE   "19".
           03  FILLER              PIC X(40)   VALUE   "負荷試験".
           03  FILLER              PIC X(20)   VALUE   "負荷試験".
           03  FILLER              PIC X(02)   VALUE   "20".
           03  FILLER              PIC X(40)   VALUE
                     "ラジオアイソトープを用いた諸検査".
           03  FILLER              PIC X(20)   VALUE
                     "ラジオアイソトープ".
           03  FILLER              PIC X(02)   VALUE   "21".
           03  FILLER              PIC X(40)   VALUE   "内視鏡検査".
           03  FILLER              PIC X(20)   VALUE   "内視鏡検査".
           03  FILLER              PIC X(02)   VALUE   "22".
           03  FILLER              PIC X(40)   VALUE
                     "診断穿刺検体採取料".
           03  FILLER              PIC X(20)   VALUE
                     "診断穿刺検体採取料".
           03  FILLER              PIC X(02)   VALUE   "98".
           03  FILLER              PIC X(40)   VALUE   "労災検査".
           03  FILLER              PIC X(20)   VALUE   "労災検査".
           03  FILLER              PIC X(02)   VALUE   "99".
           03  FILLER              PIC X(40)   VALUE   "その他の検査".
           03  FILLER              PIC X(20)   VALUE   "その他の検査".
       01  WRK-TBL-GRP-R           REDEFINES   WRK-TBL-GRP.
           03  TBL-GRP-OCC         OCCURS  24  INDEXED  BY  TBL-IDX.
               05  TBL-GRP-KBN     PIC X(02).
               05  TBL-GRP-MEI     PIC X(40).
               05  TBL-GRP-RMEI    PIC X(20).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *
      *    入力コードマスタ−
       01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
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
           COPY    "I41.INC".
           COPY    "I42.INC".
           COPY    "I43.INC".
           COPY    "I44.INC".
           COPY    "I45.INC".
           COPY    "I46.INC".
           COPY    "I47.INC".
           COPY    "I48.INC".
           COPY    "I49.INC".
           COPY    "I4ERR.INC".
           COPY    "I4ID1.INC".
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
           MOVE    SPA-FREE        TO  SPA-I44-I48.
           MOVE    SPA-WORK        TO  SPA-I4KYOUTU.
      *
           MOVE    SPACE           TO  SPA-ERRCD.
           MOVE    ZERO            TO  FLG-END.
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
           END-IF.
      *
           MOVE    SPA-I4KYOUTU       TO  SPA-WORK.
           MOVE    SPA-AREA           TO  SPA-COMMON.
           MOVE    SPA-I44-I48        TO  SPA-FREE.
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA.
           INITIALIZE                  CNT-AREA.
           INITIALIZE                  WRK-AREA.
      *    エラー画面より
           IF      SPA-MOTOPG          =   "I4ERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               MOVE    WRK-INPUTCD-W       TO  WRK-INPUTCD
           ELSE
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF.
      *
           MOVE    SPACE               TO  LNK-KYOUTU.
      *
           PERFORM 5001-MAPCUR-SEC.
      *
           MOVE   "NEW"                TO  MCP-PUTTYPE.
           MOVE   "I48"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC             SECTION.
      *    J04 で初期化する
           MOVE    SPA-I48-INPUTCD     TO  SPA-I48-GMN-INPUT.
           MOVE    SPA-I48-INPUTCD     TO  WRK-INPUTCD.
           MOVE    ZERO                TO  SPA-I48-NEXT.
      *
      *    リストボックス
      **     MOVE    "1:内服薬"          TO  SPA-I48-JIINLST (1).
      **     MOVE    "2:外用薬"          TO  SPA-I48-JIINLST (2).
      **     MOVE    "3:注射薬"          TO  SPA-I48-JIINLST (3).
           MOVE    "1:処置"            TO  SPA-I48-JIINLST (1).
           MOVE    "2:診察"            TO  SPA-I48-JIINLST (2).
           MOVE    "3:注射"            TO  SPA-I48-JIINLST (3).
           MOVE    "4:手術・麻酔"      TO  SPA-I48-JIINLST (4).
           MOVE    "5:画像診断"        TO  SPA-I48-JIINLST (5).
           MOVE    "6:その他"          TO  SPA-I48-JIINLST (6).
           MOVE    SPACE               TO  SPA-I48-JIIN-G.
      *
      *    ユーザー登録他
      **     MOVE    "1:用法"            TO  SPA-I48-USERLST (1).
      **     MOVE    "2:部位"            TO  SPA-I48-USERLST (2).
      **     MOVE    "3:その他"          TO  SPA-I48-USERLST (3).
           MOVE    "1:コメント"        TO  SPA-I48-USERLST (1).
           MOVE    "2:労災"            TO  SPA-I48-USERLST (2).
           MOVE    SPACE               TO  SPA-I48-USER-G.
      *
           IF      (SPA-I48-GMN-INPUT  =   SPACE )  AND
                   (SPA-I48-GMN-SYORI  =   SPACE )
               CONTINUE
           ELSE
               MOVE    SPACE               TO  WRK-WIDGET
               PERFORM                     310-SPA-SET-SEC
               IF       WRK-WIDGET-SW         =   "1"
                   MOVE   "B09"                TO  WRK-WIDGET
               END-IF
               MOVE    SPACE               TO  SPA-ERRCD
           END-IF.
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       310-SPA-SET-SEC                 SECTION.
      *
           INITIALIZE                  SPA-I48-GMN-TBL.
           MOVE    ZERO                TO  SPA-I48-GMN-MAX.
           MOVE    ZERO                TO  FLG-MAX.
           MOVE    SPACE               TO  WRK-WIDGET-SW.
      *
           IF       SPA-I48-TYPE         =   "1"
               PERFORM 3101-INPUTCD-SET-SEC
           END-IF.
           IF     (SPA-I48-GMN-MAX     =   ZERO  )  AND
                  (SPA-I48-CDSYUBETU   =   "J"   )  OR
                  (SPA-I48-GMN-SYORI   =   "8"  OR  "9"  OR  "U")
               MOVE    "1"                 TO  WRK-WIDGET-SW
               PERFORM 3102-TENSU-SET-SEC
      *        点数マスタ検索時、自院がゼロ件の時、全体を検索
               IF     (SPA-I48-GMN-ALL     =   SPACE)  AND
                      (SPA-I48-GMN-MAX     =   ZERO)
                   MOVE    "1"             TO  SPA-I48-GMN-ALL
                   PERFORM 3102-TENSU-SET-SEC
               END-IF
           END-IF.
      *
           IF      SPA-I48-GMN-MAX     =   ZERO
               MOVE    6                   TO  SPA-GMN-CUR4
               MOVE    "0004"              TO  SPA-ERRCD
           ELSE
               MOVE    1                   TO  SPA-GMN-CUR4
               IF      FLG-MAX         NOT =   ZERO
                   MOVE    "0005"              TO  SPA-ERRCD
               ELSE
                   MOVE    ZERO                TO  SPA-I48-NEXT
               END-IF
           END-IF.
      *
       310-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *     入力コードマスタ−より編集
      *****************************************************************
       3101-INPUTCD-SET-SEC            SECTION.
      *
           MOVE    ZERO                TO  WRK-CNT-ENT.
      *    セットの時、種別コードは６とする
           IF      SPA-I48-GMN-INPUT(1:1)  =   "P"  OR  "S"
               MOVE    "6"                 TO  SPA-I48-CDSYUBETU
           END-IF.
      *
      *    入力コードの桁数計算
           MOVE    ZERO                TO  WRK-KETA.
           PERFORM VARYING     IDX-K   FROM    20   BY  -1
                   UNTIL       IDX-K   <   1
               IF      SPA-I48-GMN-INPUT(IDX-K:1)  NOT =   SPACE
                   MOVE    IDX-K           TO  WRK-KETA
                   MOVE    1               TO  IDX-K
               END-IF
           END-PERFORM.
           IF      WRK-KETA            =   20
               MOVE    "INPUTCD-KEY2"      TO  WRK-PATH
           ELSE
               MOVE    "INPUTCD-KEY"       TO  WRK-PATH
           END-IF.
      *
           MOVE    SPACE               TO  INPUTCD-REC.
           MOVE    SPA-HOSPID          TO  ICD-HOSPID.
           MOVE    SPA-I48-CDSYUBETU   TO  ICD-CDSYU.
           MOVE    SPA-I48-GMN-INPUT   TO  ICD-INPUTCD.
      *
           MOVE    INPUTCD-REC         TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    WRK-PATH            TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM                     930-INPUTCD-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-INPUTCD
           END-IF.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
               UNTIL      (IDX             >   200 )   OR
                          (FLG-INPUTCD     =   1   )
      *
               PERFORM 31011-INPUTCD-CHK-SEC
               IF      FLG-OK              =   1
                   IF     (ICD-DSPNAME     NOT =   SPACE )  AND
                          (ICD-SRYCD(1:1)      =   "S"  OR  "P")
      *
                       ADD     1               TO  WRK-CNT-ENT
                       MOVE    IDX             TO  SPA-I48-GMN-NO
                                                                  (IDX)
                       MOVE    ICD-INPUTCD     TO  SPA-I48-GMN-INPUTCD
                                                                  (IDX)
                       MOVE    ICD-SRYCD       TO  SPA-I48-GMN-SRYCD
                                                                  (IDX)
                       MOVE    ICD-DSPNAME     TO  SPA-I48-GMN-NAME
                                                                  (IDX)
                   ELSE
      *                点数マスタより編集
                       INITIALIZE              TNS-TENSU-REC
                       MOVE    ICD-SRYCD       TO  TNS-SRYCD
                       MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
                       MOVE    "DBSELECT"      TO  MCP-FUNC
                       MOVE    "TENSU-KEY"     TO  ORC-DBPATH
                       MOVE    SPA-SRYYMD      TO  ORC-DBYMD
                       CALL    "ORCMCPSUB"     USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                       IF      MCP-RC              =   ZERO
                           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
                           PERFORM                 910-TENSU-READ-SEC
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
      *
                           ADD     1               TO  WRK-CNT-ENT
                           MOVE    IDX             TO  SPA-I48-GMN-NO
                                                                (IDX)
                           MOVE    ICD-INPUTCD     TO
                                                   SPA-I48-GMN-INPUTCD
                                                                (IDX)
                           MOVE    ICD-SRYCD       TO  SPA-I48-GMN-SRYCD
                                                                (IDX)
                           PERFORM 31021-TENSU-CHK-SEC
                           IF      FLG-CHK         =   ZERO
                               MOVE    TNS-NAME
                                               TO  SPA-I48-GMN-NAME
                                                                (IDX)
                               MOVE    TNS-TEN
                                               TO  SPA-I48-GMN-KISOTEN
                                                                (IDX)
      *                        薬剤・器材の時単位
                               IF      TNS-SRYCD (1:1) =   "6"  OR  "7"
                                   MOVE    TNS-TANINAME    TO
                                               SPA-I48-GMN-TANI(IDX)
                               END-IF
      *
      *                        診療行為で老人の時、再編集
                               IF     (TNS-SRYCD(1:1)      =   "1") AND
                                      (TNS-ROUTEKKBN       =   2  )
                                   MOVE    SPACE   TO  SPA-I48-GMN-NAME
                                                                (IDX)
                                   STRING  "［老］"
                                     TNS-NAME      DELIMITED   BY  SIZE
                                     INTO        SPA-I48-GMN-NAME(IDX)
                                   END-STRING
                               END-IF
                           ELSE
                               INITIALIZE          SPA-I48-GMN-TBLREC
                                                                (IDX)
                               COMPUTE IDX             =   IDX    -   1
                               COMPUTE WRK-CNT-ENT     =   WRK-CNT-ENT
                                                       -   1
                           END-IF
                       END-IF
                   END-IF
               END-IF
      *
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM                     930-INPUTCD-READ-SEC
           END-PERFORM.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    WRK-PATH            TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    WRK-CNT-ENT         TO  SPA-I48-GMN-MAX.
      *
       3101-INPUTCD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    同一コードチェック処理
      *****************************************************************
       31011-INPUTCD-CHK-SEC                 SECTION.
      *
           MOVE    ZERO                TO  FLG-OK.
           MOVE    ZERO                TO  FLG-ERR.
      *
           PERFORM VARYING     IDXC    FROM    1   BY  1
               UNTIL      (IDXC        >   200 )   OR
                          (SPA-I48-GMN-SRYCD(IDXC)
                                       =   SPACE)   OR
                          (FLG-ERR     =   1   )
               IF      ICD-SRYCD       =   SPA-I48-GMN-SRYCD(IDXC)
                   MOVE    1               TO  FLG-ERR
               END-IF
           END-PERFORM.
           IF      FLG-ERR             =   ZERO
               MOVE    1                   TO  FLG-OK
           END-IF.
      *
       31011-INPUTCD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ−より編集
      *****************************************************************
       3102-TENSU-SET-SEC                 SECTION.
      *
           MOVE    ZERO                TO  WRK-CNT-ENT.
           MOVE    ZERO                TO  FLG-MAX.
      *
      *    ユーザー登録分
           IF      SPA-I48-GMN-SYORI   =   "U"
               CONTINUE
           ELSE
      *
               IF      SPA-I48-GMN-ALL     =   SPACE
      *        自院分のみ
      **             EVALUATE    SPA-I48-GMN-SYORI
      *            内服
      **                 WHEN    "3"
      **                     MOVE    "TENSU-KEY51J"       TO  WRK-PATH
      *            外用
      **                 WHEN    "4"
      **                     MOVE    "TENSU-KEY52J"       TO  WRK-PATH
      *            注射
      **                 WHEN    "5"
      **                     MOVE    "TENSU-KEY53J"       TO  WRK-PATH
      *            器材
      **                 WHEN    "7"
      **                     MOVE    "TENSU-KEY6J"        TO  WRK-PATH
      *            診療行為
      **                 WHEN    "8"
                           MOVE    "TENSU-KEY7J"        TO  WRK-PATH
      *            検査
      **                 WHEN    "9"
      **                     MOVE    "TENSU-KEY42JK"      TO  WRK-PATH
      *            内服
      **                 WHEN    OTHER
      **                     MOVE    "3"             TO  SPA-I48-GMN-SYORI
      **                     MOVE    "TENSU-KEY51J"  TO  WRK-PATH
      **             END-EVALUATE
               ELSE
      *        全体分
      **             EVALUATE    SPA-I48-GMN-SYORI
      *            内服
      **                 WHEN    "3"
      **                     MOVE    "TENSU-KEY51"       TO  WRK-PATH
      *            外用
      **                 WHEN    "4"
      **                     MOVE    "TENSU-KEY52"       TO  WRK-PATH
      *            注射
      **                 WHEN    "5"
      **                     MOVE    "TENSU-KEY53"       TO  WRK-PATH
      *            器材
      **                 WHEN    "7"
      **                     MOVE    "TENSU-KEY6"        TO  WRK-PATH
      *            診療行為
      **                 WHEN    "8"
                           MOVE    "TENSU-KEY7"        TO  WRK-PATH
      *            検査
      **                 WHEN    "9"
      **                     MOVE    "TENSU-KEY42K"      TO  WRK-PATH
      *            内服
      **                 WHEN    OTHER
      **                     MOVE    "3"             TO  SPA-I48-GMN-SYORI
      **                     MOVE    "TENSU-KEY51"   TO  WRK-PATH
      **             END-EVALUATE
               END-IF
           END-IF.
      *
           INITIALIZE                      TNS-TENSU-REC.
           IF      SPA-I48-GMN-SYORI   =   "9"
               MOVE    SPA-I48-NAI-KENSANO TO  TNS-KNSJISGRPKBN
           ELSE
               MOVE    WRK-INPUTCD         TO  TNS-NAME
               MOVE    WRK-INPUTCD         TO  TNS-KANANAME
           END-IF.
      *
      *    ユーザー登録分
           IF      SPA-I48-GMN-SYORI   =   "U"
               PERFORM 31021-ETC-PATH-SET-SEC
           ELSE
               IF     (SPA-I48-GMN-SYORI   NOT =   "9"  )  AND
                      (WRK-INPUTCD             =   SPACE)
                   MOVE    ZERO                TO  SPA-I48-GMN-MAX
                   GO      TO      3102-TENSU-SET-EXT
               END-IF
           END-IF.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    WRK-PATH            TO  ORC-DBPATH.
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM                     910-TENSU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF.
      *
           MOVE    ZERO                TO  IDX2.
           MOVE    ZERO                TO  IDX.
           PERFORM
               UNTIL      (IDX         >    200)   OR
                          (FLG-TENSU   =   1   )
      *
      *        点数マスタチェック
               PERFORM 31021-TENSU-CHK-SEC
      *        検査で包括判定がある時の判定
      **         IF      SPA-I48-GMN-SYORI   =   "9"
      **             EVALUATE    SPA-I48-NAI-HOUKATU
      **                 WHEN    "1"
      *                    包括あり
      **                     IF      TNS-HOUKNSKBN       =   ZERO
      **                         MOVE    1               TO  FLG-CHK
      **                     END-IF
      **                 WHEN    "2"
      *                    包括なし
      **                     IF      TNS-HOUKNSKBN   NOT =   ZERO
      **                         MOVE    1               TO  FLG-CHK
      **                     END-IF
      **             END-EVALUATE
      **         END-IF
      *
               IF      FLG-CHK             =   ZERO
                   ADD     1               TO  IDX2
      *            次ページの時、表示分は読み飛ばし
                   IF      IDX2            >=  SPA-I48-NEXT
                       PERFORM 31021-TENSU-HEN-SEC
                   END-IF
               END-IF
      *
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM                     910-TENSU-READ-SEC
           END-PERFORM.
      *
           MOVE    WRK-CNT-ENT         TO  SPA-I48-GMN-MAX.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    WRK-PATH            TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
      *    労災分表示の時、残りのマスタを表示する
           EVALUATE    SPA-I48-GMN-SYORI3
               WHEN    "U2"
                   PERFORM 31022-RSI-HENSYU-SEC
           END-EVALUATE.
      *
      *    点数マスタで対象が有った時、タイプを変更する
           IF      SPA-I48-GMN-MAX     >   ZERO
               MOVE    "2"             TO  SPA-I48-TYPE
           END-IF.
      *
       3102-TENSU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ユーザー登録、自院採用分処理
      *****************************************************************
       31021-ETC-PATH-SET-SEC          SECTION.
      *
           EVALUATE    SPA-I48-GMN-SYORI3
               WHEN    "J1"
      *            自院・内服
      **             MOVE    "TENSU-KEY11M1"      TO  WRK-PATH
      **             MOVE    "600000000"          TO  TNS-SRYCD
      **             MOVE    "699999999"          TO  TNSUP-SRYCD
      **             MOVE    "1"                  TO  TNS-YKZKBN
      **             MOVE    "1"                  TO  SPA-I48-GMN-ALL
      **         WHEN    "J2"
      *            自院・外用
      **             MOVE    "TENSU-KEY11M1"      TO  WRK-PATH
      **             MOVE    "600000000"          TO  TNS-SRYCD
      **             MOVE    "699999999"          TO  TNSUP-SRYCD
      **             MOVE    "6"                  TO  TNS-YKZKBN
      **             MOVE    "1"                  TO  SPA-I48-GMN-ALL
      **         WHEN    "J3"
      *            自院・注射
      **             MOVE    "TENSU-KEY11M1"      TO  WRK-PATH
      **             MOVE    "600000000"          TO  TNS-SRYCD
      **             MOVE    "699999999"          TO  TNSUP-SRYCD
      **             MOVE    "4"                  TO  TNS-YKZKBN
      **             MOVE    "1"                  TO  SPA-I48-GMN-ALL
               WHEN    "J1"
      *            自院・処置
                   MOVE    "TENSU-KEY12M1"      TO  WRK-PATH
                   MOVE    "140000000"          TO  TNS-SRYCD
                   MOVE    "149999999"          TO  TNSUP-SRYCD
                   MOVE    "1"                  TO  SPA-I48-GMN-ALL
               WHEN    "J2"
      *            自院・診察
                   MOVE    "TENSU-KEY12M1"      TO  WRK-PATH
                   MOVE    "1"                  TO  SPA-I48-GMN-ALL
                   MOVE    "110000000"          TO  TNS-SRYCD
                   MOVE    "119999999"          TO  TNSUP-SRYCD
               WHEN    "J3"
      *            自院・注射
                   MOVE    "TENSU-KEY12M1"      TO  WRK-PATH
                   MOVE    "1"                  TO  SPA-I48-GMN-ALL
                   MOVE    "130000000"          TO  TNS-SRYCD
                   MOVE    "139999999"          TO  TNSUP-SRYCD
               WHEN    "J4"
      *            自院・手術
                   MOVE    "TENSU-KEY12M1"      TO  WRK-PATH
                   MOVE    "1"                  TO  SPA-I48-GMN-ALL
                   MOVE    "150000000"          TO  TNS-SRYCD
                   MOVE    "159999999"          TO  TNSUP-SRYCD
               WHEN    "J5"
      *            自院・画像診断
                   MOVE    "TENSU-KEY12M1"      TO  WRK-PATH
                   MOVE    "1"                  TO  SPA-I48-GMN-ALL
                   MOVE    "170000000"          TO  TNS-SRYCD
                   MOVE    "179999999"          TO  TNSUP-SRYCD
               WHEN    "J6"
      *            自院・その他
                   MOVE    "TENSU-KEY12M1"      TO  WRK-PATH
                   MOVE    "1"                  TO  SPA-I48-GMN-ALL
                   MOVE    "180000000"          TO  TNS-SRYCD
                   MOVE    "199999999"          TO  TNSUP-SRYCD
               WHEN    "U1"
      *            自院・コメント
                   MOVE    "TENSU-KEY12S"       TO  WRK-PATH
                   MOVE    "1"                  TO  SPA-I48-GMN-ALL
                   MOVE    "800000000"          TO  TNS-SRYCD
                   MOVE    "899999999"          TO  TNSUP-SRYCD
      **         WHEN    "U1"
      *            用法
      **             MOVE    "TENSU-KEY12S"       TO  WRK-PATH
      **             MOVE    "001000000"          TO  TNS-SRYCD
      **             MOVE    "001999999"          TO  TNSUP-SRYCD
      **             MOVE    "1"                  TO  SPA-I48-GMN-ALL
      **         WHEN    "U2"
      *            部位
      **             MOVE    "TENSU-KEY12S"       TO  WRK-PATH
      **             MOVE    "002000000"          TO  TNS-SRYCD
      **             MOVE    "002999999"          TO  TNSUP-SRYCD
      **             MOVE    "1"                  TO  SPA-I48-GMN-ALL
      **         WHEN    "U3"
      *            その他
      **             MOVE    "TENSU-KEY12S"       TO  WRK-PATH
      **             MOVE    "003000000"          TO  TNS-SRYCD
      **             MOVE    "098999999"          TO  TNSUP-SRYCD
      **             MOVE    "1"                  TO  SPA-I48-GMN-ALL
               WHEN    "U2"
      *            労災診察
                   MOVE    "TENSU-KEY12S"       TO  WRK-PATH
                   MOVE    "100000000"          TO  TNS-SRYCD
                   MOVE    "109999999"          TO  TNSUP-SRYCD
                   MOVE    "1"                  TO  SPA-I48-GMN-ALL
           END-EVALUATE.
      *
       31021-ETC-PATH-SET-EXT.
           EXIT.
      *****************************************************************
      *    労災分表示処理
      *****************************************************************
       31022-RSI-HENSYU-SEC                  SECTION.
      *
           PERFORM VARYING     IDX-KAI     FROM    1   BY  1
                   UNTIL       IDX-KAI     >   4
               INITIALIZE                      TNS-TENSU-REC
               EVALUATE    IDX-KAI
                   WHEN    1
      *            器材
                       MOVE    "TENSU-KEY12S"       TO  WRK-PATH
                       MOVE    "788888000"          TO  TNS-SRYCD
                       MOVE    "788888999"          TO  TNSUP-SRYCD
                   WHEN    2
      *            コメント１
                       MOVE    "TENSU-KEY12S"       TO  WRK-PATH
                       MOVE    "820800000"          TO  TNS-SRYCD
                       MOVE    "820899999"          TO  TNSUP-SRYCD
                   WHEN    3
      *            コメント２
                       MOVE    "TENSU-KEY12S"       TO  WRK-PATH
                       MOVE    "830800000"          TO  TNS-SRYCD
                       MOVE    "830899999"          TO  TNSUP-SRYCD
                   WHEN    4
      *            コメント３
                       MOVE    "TENSU-KEY12S"       TO  WRK-PATH
                       MOVE    "840800000"          TO  TNS-SRYCD
                       MOVE    "840899999"          TO  TNSUP-SRYCD
               END-EVALUATE
      *
               MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    WRK-PATH            TO  ORC-DBPATH
               MOVE    SPA-SRYYMD          TO  ORC-DBYMD
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
               PERFORM
                    UNTIL      (IDX         >    200 )   OR
                               (FLG-TENSU   =   1   )
      *
      *            点数マスタチェック
                   PERFORM 31021-TENSU-CHK-SEC
      *
                   IF      FLG-CHK             =   ZERO
                       ADD     1               TO  IDX2
      *                次ページの時、表示分は読み飛ばし
                       IF      IDX2            >=  SPA-I48-NEXT
                           PERFORM 31021-TENSU-HEN-SEC
                       END-IF
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
           END-PERFORM.
      *
           MOVE    WRK-CNT-ENT         TO  SPA-I48-GMN-MAX.
      *
       31022-RSI-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタチェック処理
      *****************************************************************
       31021-TENSU-CHK-SEC                  SECTION.
      *
           MOVE    ZERO                TO  FLG-CHK.
      *
      *    病院診療所区分判定
           IF      (TNS-HOSPSRYKBN     =   ZERO        )  OR
                   (TNS-HOSPSRYKBN     =   SPA-HOSPSBT )
               CONTINUE
           ELSE
               MOVE   1                TO  FLG-CHK
           END-IF.
      *
      *    老人区分判定
           IF      (TNS-ROUTEKKBN      =   ZERO        )   OR
                   ((TNS-ROUTEKKBN      =   1          )  AND
                    (SPA-ROUJIN         =   ZERO       ))  OR
                   ((TNS-ROUTEKKBN      =   2          )  AND
                    (SPA-ROUJIN         =   1          ))
               CONTINUE
           ELSE
               MOVE   1                TO  FLG-CHK
           END-IF.
      *
      *    入外区分
           IF      (TNS-NYUGAITEKKBN      =   ZERO        )  OR
                   (TNS-NYUGAITEKKBN      =   SPA-NYUGAIKBN)
               CONTINUE
           ELSE
               MOVE   1                TO  FLG-CHK
           END-IF.
      *
      *    診療区分
           IF      (TNS-SRYKBN            =   "90" )  OR
                   (TNS-SRYKBN            =   "99" )
               CONTINUE
           ELSE
               MOVE   1                TO  FLG-CHK
           END-IF.
      *
       31021-TENSU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ編集処理
      *****************************************************************
       31021-TENSU-HEN-SEC                  SECTION.
      *
           ADD     1                   TO  IDX.
      *    ２００件オーバーチェック
           IF      IDX                 >   200
               MOVE    1                   TO  FLG-MAX
               MOVE    IDX2                TO  SPA-I48-NEXT
               GO      TO      31021-TENSU-HEN-EXT
           END-IF.
      *
           ADD     1                   TO  WRK-CNT-ENT.
           MOVE    IDX2                TO  SPA-I48-GMN-NO   (IDX).
           MOVE    TNS-SRYCD           TO  SPA-I48-GMN-INPUTCD
                                                            (IDX).
           MOVE    TNS-SRYCD           TO  SPA-I48-GMN-SRYCD(IDX).
           MOVE    TNS-NAME            TO  SPA-I48-GMN-NAME
                                                             (IDX).
           MOVE    TNS-TEN             TO  SPA-I48-GMN-KISOTEN
                                                            (IDX).
      *     薬剤・器材の時単位
           IF      TNS-SRYCD (1:1)     =   "6"  OR  "7"
               MOVE    TNS-TANINAME        TO  SPA-I48-GMN-TANI(IDX)
           END-IF.
      *
      *    診療行為で老人の時、再編集
           IF     (TNS-ROUTEKKBN       =   2   )
               MOVE    SPACE               TO  SPA-I48-GMN-NAME(IDX)
               STRING  "［老］"
                       TNS-NAME            DELIMITED   BY  SIZE
                       INTO                    SPA-I48-GMN-NAME(IDX)
               END-STRING
           END-IF.
      *
      *    検査の時、包括の編集
      **     IF      SPA-I48-GMN-SYORI   =   "9"
      **         EVALUATE    TNS-HOUKNSKBN
      **             WHEN    01
      *                血液化学検査の包括
      **                 MOVE    "★"            TO  WRK-KENSA-HEN
      **             WHEN    02
      *                内分泌学検査の包括
      **                 MOVE    "★"            TO  WRK-KENSA-HEN
      **             WHEN    03
      *                肝炎ウイルス関連検査の包括
      **                 MOVE    "★"            TO  WRK-KENSA-HEN
      **             WHEN    04
      *                腫瘍マーカーの包括
      **                 MOVE    "●"            TO  WRK-KENSA-HEN
      **             WHEN    05
      *                ４以外の腫瘍マーカーの包括
      **                 MOVE    "◆"            TO  WRK-KENSA-HEN
      **             WHEN    06
      *                出血・凝固検査の包括
      **                 MOVE    "★"            TO  WRK-KENSA-HEN
      **             WHEN    07
      *                自己抗体検査の包括
      **                 MOVE    "◆"            TO  WRK-KENSA-HEN
      **             WHEN    OTHER
      **                 MOVE    SPACE           TO  WRK-KENSA-HEN
      **         END-EVALUATE
      **         MOVE    SPA-I48-GMN-NAME(IDX)   TO  WRK-HEN-NAME
      **         MOVE    SPACE               TO  SPA-I48-GMN-NAME(IDX)
      **         STRING  WRK-KENSA-HEN       DELIMITED   BY  SIZE
      **                 WRK-HEN-NAME        DELIMITED   BY  SIZE
      **                 INTO                    SPA-I48-GMN-NAME(IDX)
      **         END-STRING
      **     END-IF.
      *
       31021-TENSU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  I48.
           INITIALIZE                      I48.
      *
           MOVE    SPA-I48-GMN-INPUT   TO  I48-INPUT.
      *
           IF     (SPA-I48-TYPE        =   "1" )  AND
                  (SPA-I48-CDSYUBETU   =   "6" )
               MOVE    SPACE               TO  SPA-I48-GMN-SYORI
               IF      SPA-I48-GMN-INPUT(1:1)  =   "P"  OR  "S"
                   MOVE    "P"                 TO  SPA-I48-GMN-SYORI
               END-IF
           END-IF.
           IF     (SPA-I48-TYPE        =   "1" )  AND
                  (SPA-I48-CDSYUBETU   =   "A" )
               MOVE    SPACE               TO  SPA-I48-GMN-SYORI
           END-IF.
      *
           EVALUATE    SPA-I48-GMN-SYORI
      *        内服
      **         WHEN    "3"
      **             IF      SPA-I48-GMN-ALL     =   SPACE
      **                 MOVE    "内服（自院）" 
      **                                         TO  I48-SENTAKU
      **             ELSE
      **                 MOVE    "内服（全体）" 
      **                                         TO  I48-SENTAKU
      **             END-IF
      *        外用
      **         WHEN    "4"
      **             IF      SPA-I48-GMN-ALL     =   SPACE
      **                 MOVE    "外用（自院）" 
      **                                         TO  I48-SENTAKU
      **             ELSE
      **                 MOVE    "外用（全体）" 
      **                                         TO  I48-SENTAKU
      **             END-IF
      *        注射
      **         WHEN    "5"
      **             IF      SPA-I48-GMN-ALL     =   SPACE
      **                 MOVE    "注射（自院）" 
      **                                         TO  I48-SENTAKU
      **             ELSE
      **                 MOVE    "注射（全体）" 
      **                                         TO  I48-SENTAKU
      **             END-IF
      *        器材
      **         WHEN    "7"
      **             IF      SPA-I48-GMN-ALL     =   SPACE
      **                 MOVE    "器材（自院）" 
      **                                         TO  I48-SENTAKU
      **             ELSE
      **                 MOVE    "器材（全体）" 
      **                                         TO  I48-SENTAKU
      **             END-IF
      *        診療行為
               WHEN    "8"
                   IF      SPA-I48-GMN-ALL     =   SPACE
                       MOVE    "診療行為（自院）" 
                                               TO  I48-SENTAKU
                   ELSE
                       MOVE    "診療行為（全体）" 
                                               TO  I48-SENTAKU
                   END-IF
      *        検査
      **         WHEN    "9"
      **             MOVE    "検査"              TO  I48-SENTAKU
      **             IF      SPA-I48-NAI-KENSANO     NOT =   ZERO
      **                 PERFORM 5010-GRPMEI-SET-SEC
      **                 MOVE    WRK-GRP-MEI-X       TO  I48-SENTAKU
      **             END-IF
      *        セット
               WHEN    "P"
                   MOVE    "セット"            TO  I48-SENTAKU
      *        ユーザー登録
               WHEN    "U"
                   EVALUATE    SPA-I48-GMN-SYORI3
      **                 WHEN    "J1"
      **                     MOVE    "自院採用（内服）"
      **                                         TO  I48-SENTAKU
      **                 WHEN    "J2"
      **                     MOVE    "自院採用（外用）"
      **                                         TO  I48-SENTAKU
      **                 WHEN    "J3"
      **                     MOVE    "自院採用（注射）"
      **                                         TO  I48-SENTAKU
                       WHEN    "J1"
                           MOVE    "自院採用（処置）"
                                               TO  I48-SENTAKU
                       WHEN    "J2"
                           MOVE    "自院採用（診察）"
                                               TO  I48-SENTAKU
                       WHEN    "J3"
                           MOVE    "自院採用（注射）"
                                               TO  I48-SENTAKU
                       WHEN    "J4"
                           MOVE    "自院採用（手術・麻酔）"
                                               TO  I48-SENTAKU
                       WHEN    "J5"
                           MOVE    "自院採用（画像診断）"
                                               TO  I48-SENTAKU
                       WHEN    "J6"
                           MOVE    "自院採用（その他）"
                                               TO  I48-SENTAKU
      **                 WHEN    "U1"
      **                     MOVE    "用法（全体）"
      **                                         TO  I48-SENTAKU
      **                 WHEN    "U2"
      **                     MOVE    "撮影部位（全体）"
      **                                         TO  I48-SENTAKU
      **                 WHEN    "U3"
      **                     MOVE    "ユーザー登録（その他）"
      **                                         TO  I48-SENTAKU
                       WHEN    "U1"
                           MOVE    "コメント（全体）"
                                               TO  I48-SENTAKU
                       WHEN    "U2"
                           MOVE    "労災"
                                               TO  I48-SENTAKU
                   END-EVALUATE
      *        その他
               WHEN    OTHER
                   MOVE    "入力コード全体（自院）"
                                              TO  I48-SENTAKU
           END-EVALUATE.
      *
      *    漢字入力で、入力コードで検索
           IF     (SPA-I48-TYPE        =   "1" )  AND
                  (SPA-I48-CDSYUBETU   =   "J" )
               MOVE    "入力コード全体（自院）"
                                              TO  I48-SENTAKU
           END-IF.
      *
           PERFORM VARYING   IDX       FROM    1   BY  1
                   UNTIL     IDX       >   SPA-I48-GMN-MAX
               MOVE    IDX                 TO  WRK-NOZ
               MOVE    WRK-NOZ             TO  I48-NO  (IDX)
               MOVE    IDX                 TO  SPA-I48-NAI-NO(IDX)
      *        検査判断の時、区分を編集
               IF     (SPA-I48-GMN-SYORI       =   "9" )  AND
                      (SPA-I48-GMN-SYORI2      =   SPACE)
                   MOVE    SPA-I48-GMN-NO-X (IDX)
                                               TO  I48-NO (IDX)
                   IF      SPA-I48-GMN-NO-X (IDX)(3:1)   =   SPACE
                       MOVE    ZERO            TO  SPA-I48-NAI-NO(IDX)
                       MOVE    SPA-I48-GMN-NO-X (IDX)(1:2)
                                               TO  SPA-I48-NAI-NO(IDX)
                                                                (2:2)
                   ELSE
                       MOVE    SPA-I48-GMN-NO-X (IDX)
                                               TO  SPA-I48-NAI-NO(IDX)
                   END-IF
               END-IF
      *
               MOVE    SPA-I48-GMN-NAME (IDX)  TO  I48-NAME (IDX)
               IF    ((SPA-I48-GMN-KISOTEN(IDX)    =   ZERO  )  AND
                      (SPA-I48-GMN-SRYCD(IDX)(1:1) =   "S" OR "P")) OR
                     ((SPA-I48-GMN-SYORI           =   "9"   )  AND
                      (SPA-I48-GMN-SYORI2          =   SPACE ))
      *            セット一覧の時、セットコードを単価へ
                   IF      SPA-I48-GMN-SRYCD (IDX)(1:1)
                                                   =   "P" OR "S"
                        MOVE    SPA-I48-GMN-SRYCD (IDX)
                                               TO  I48-KISOTEN (IDX)
                   END-IF
               ELSE
                   MOVE    SPA-I48-GMN-KISOTEN(IDX)
                                               TO  WRK-TENSUS
                   MOVE    WRK-TENSUS          TO  I48-KISOTEN (IDX)
               END-IF
      *
               MOVE    SPA-I48-GMN-TANI (IDX)  TO  I48-TANI (IDX)
           END-PERFORM.
      *
           MOVE    SPA-I48-GMN-MAX     TO  I48-COUNT.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   5
               IF      SPA-I48-NAI-SELNUM(IDX) NOT =   ZERO
                   MOVE    SPA-I48-NAI-SELNUM(IDX)     TO  WRK-NOZ
                   MOVE    WRK-NOZ                 TO  I48-SELNUM (IDX)
               END-IF
           END-PERFORM.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   10
               IF      SPA-I48-JIINLST (IDX)   NOT =   SPACE
                   MOVE    SPA-I48-JIINLST(IDX) TO  I48-JIIN-ITEM(IDX)
                   MOVE    IDX                  TO  I48-JIIN-COUNT
               END-IF
           END-PERFORM.
           IF     (SPA-I48-GMN-SYORI   =   "U"  )  AND
                  (SPA-I48-GMN-SYORI3(1:1)  =   "J")
               MOVE    SPA-I48-JIIN-G      TO  I48-JIIN
           ELSE
               MOVE    SPACE               TO  SPA-I48-JIIN-G
           END-IF.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   10
               IF      SPA-I48-USERLST (IDX)   NOT =   SPACE
                   MOVE    SPA-I48-USERLST(IDX) TO  I48-USER-ITEM(IDX)
                   MOVE    IDX                  TO  I48-USER-COUNT
               END-IF
           END-PERFORM.
           IF     (SPA-I48-GMN-SYORI   =   "U"  )  AND
                  (SPA-I48-GMN-SYORI3(1:1)  =   "U")
               MOVE    SPA-I48-USER-G      TO  I48-USER
           ELSE
               MOVE    SPACE               TO  SPA-I48-USER-G
           END-IF.
      *
           PERFORM 5001-MAPCUR-SEC.
      *
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    検査グループ名称編集処理
      *****************************************************************
       5010-GRPMEI-SET-SEC             SECTION.
      *
      *
           SET     TBL-IDX            TO  1.
           SEARCH      TBL-GRP-OCC     VARYING   TBL-IDX
                   AT  END
                       MOVE    SPACE           TO  WRK-GRP-MEI
                   WHEN    SPA-I48-NAI-KENSANO =
                                               TBL-GRP-KBN (TBL-IDX)
                       MOVE    TBL-GRP-RMEI  (TBL-IDX)
                                                TO  WRK-GRP-MEI
           END-SEARCH.
           MOVE    SPACE               TO  WRK-GRP-MEI-X.
           IF      SPA-I48-GMN-ALL     =   SPACE
               STRING      WRK-GRP-MEI     DELIMITED  BY  SPACE
                           "（自院）"      DELIMITED  BY  SIZE
                           INTO            WRK-GRP-MEI-X
           ELSE
               STRING      WRK-GRP-MEI     DELIMITED  BY  SPACE
                           "（全体）"      DELIMITED  BY  SIZE
                           INTO            WRK-GRP-MEI-X
           END-IF.
      *
       5010-GRPMEI-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-GMN-CUR4
               WHEN    01
                   MOVE    "SELNUM1"       TO  MCP-WIDGET
               WHEN    02
                   MOVE    "SELNUM2"       TO  MCP-WIDGET
               WHEN    03
                   MOVE    "SELNUM3"       TO  MCP-WIDGET
               WHEN    04
                   MOVE    "SELNUM4"       TO  MCP-WIDGET
               WHEN    05
                   MOVE    "SELNUM5"       TO  MCP-WIDGET
               WHEN    06
                   MOVE    "INPUT"         TO  MCP-WIDGET
               WHEN    07
                   MOVE    "JIIN"          TO  MCP-WIDGET
               WHEN    08
                   MOVE    "USER"          TO  MCP-WIDGET
           END-EVALUATE.
      *
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
                   MOVE    SPACE               TO  SPA-I48-SRYCD-G
                   PERFORM 210-BACK
      *        内服
      **         WHEN    "CLICKED"       ALSO    "B02"
      **             PERFORM 230-NAIFUKU-SEC
      *        外用
      **         WHEN    "CLICKED"       ALSO    "B03"
      **             PERFORM 240-GAIYOU-SEC
      *        注射
      **         WHEN    "CLICKED"       ALSO    "B04"
      **             PERFORM 250-CHUUSYA-SEC
      *        器材
      **         WHEN    "CLICKED"       ALSO    "B05"
      **             PERFORM 270-KIZAI-SEC
      *        診療行為
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 280-SINRYOU-SEC
      *        検査
      **         WHEN    "CLICKED"       ALSO    "B08"
      **             PERFORM 290-KENSA-SEC
      *        全体
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 290-ALL-SEL-SEC
      *        部分
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 291-BUB-SEC
      *        後方
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 292-ATO-SEC
      *        次ページ
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 270-NEXT-SEC
           END-EVALUATE.
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
               WHEN    "ACTIVATE"      ALSO    "SELNUM1"
               WHEN    "ACTIVATE"      ALSO    "SELNUM2"
               WHEN    "ACTIVATE"      ALSO    "SELNUM3"
               WHEN    "ACTIVATE"      ALSO    "SELNUM4"
               WHEN    "ACTIVATE"      ALSO    "SELNUM5"
                   MOVE    MCP-WIDGET(7:1)     TO  IDX-1
                   PERFORM 41011-SELNUM-ALLCHK-SEC
      *        行選択
               WHEN    ANY             ALSO    "LIST"
                   PERFORM 41012-LISTSEL-SEC
      *        自院入力
               WHEN    "ACTIVATE"      ALSO    "JIIN"
                   PERFORM 41014-JIIN-CHK-SEC
      *        ユーザー
               WHEN    "ACTIVATE"      ALSO    "USER"
                   PERFORM 41014-USER-CHK-SEC
           END-EVALUATE.
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    キー入力　処理
      *****************************************************************
       41013-INPUT-CHK-SEC                SECTION.
      *
           MOVE    6                   TO  SPA-GMN-CUR4.
      *
           MOVE    I48-INPUT           TO  SPA-I48-GMN-INPUT.
           MOVE    ZERO                TO  FLG-KANJI.
           MOVE    ZERO                TO  FLG-KANA.
           MOVE    ZERO                TO  WRK-MOJI.
      *
           INITIALIZE                  ORCSKANACHKAREA.
           MOVE    "1"                 TO  KANACHK-SYORI.
           MOVE    SPA-I48-GMN-INPUT   TO  KANACHK-MAE-INPUT.
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA.
           IF      KANACHK-RC      NOT =   ZERO
      *        全角半角混在エラー
               MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               MOVE    KANACHK-MAX     TO  WRK-MOJI
      *        全角
               IF      KANACHK-SYUBETU     =   2
                   MOVE    1               TO  FLG-KANJI
               ELSE
                   MOVE    ZERO            TO  FLG-KANJI
               END-IF
           END-IF.
      *
           IF     (WRK-MOJI            =   ZERO  )  OR
                  ((FLG-KANJI           =   1    ) AND
                   (FLG-KANA            =   1    ))
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO                  41013-INPUT-CHK-EXT
           END-IF.
      *
           IF      FLG-KANJI           =   1
      *        全角入力（点数マスタより）
               MOVE    "J"                 TO  SPA-I48-CDSYUBETU
               MOVE    "1"                 TO  SPA-I48-TYPE
               MOVE    SPACE               TO  SPA-I48-GMN-ALL
           ELSE
               MOVE    SPACE               TO  SPA-I48-GMN-ALL
      *        半角入力（入力セットマスタより）
               MOVE    "1"                 TO  SPA-I48-TYPE
      *       全桁数字、”Ｐ、Ｓ”で始まるものは、コード種別を桁数で決定
               MOVE    SPACE               TO  SPA-I48-GMN-SYORI
               IF     (SPA-I48-GMN-INPUT(1:WRK-MOJI)   NUMERIC)  OR
                      (SPA-I48-GMN-INPUT(1:1) =   "P"  OR "S")
                   EVALUATE    WRK-MOJI
                       WHEN    4
                           MOVE    "4"         TO  SPA-I48-CDSYUBETU
                       WHEN    5
                           MOVE    "5"         TO  SPA-I48-CDSYUBETU
                       WHEN    3
                       WHEN    6
                           MOVE    "6"         TO  SPA-I48-CDSYUBETU
                       WHEN    1
                           MOVE    "6"         TO  SPA-I48-CDSYUBETU
                   END-EVALUATE
               ELSE
                   MOVE    "A"             TO  SPA-I48-CDSYUBETU
               END-IF
           END-IF.
           MOVE    1                   TO  SPA-GMN-CUR4.
      *    ＳＰＡセット
           MOVE    ZERO                TO  SPA-I48-NEXT.
           PERFORM                     310-SPA-SET-SEC.
      *
       41013-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択　処理（全体）
      *****************************************************************
       41011-SELNUM-ALLCHK-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-HENSYU.
      *
           IF     (I48-SELNUM (2)   NOT =   SPACE)  OR
                  (I48-SELNUM (3)   NOT =   SPACE)  OR
                  (I48-SELNUM (4)   NOT =   SPACE)  OR
                  (I48-SELNUM (5)   NOT =   SPACE)
               MOVE    "0003"          TO  SPA-ERRCD
               GO      TO      41011-SELNUM-ALLCHK-EXT
           END-IF.
      *
           PERFORM VARYING     IDX-1   FROM   1   BY   1
                   UNTIL      (IDX-1       >   5  )  OR
                              (FLG-HENSYU  =   1  )
               PERFORM 41011-SELNUM-CHK-SEC
           END-PERFORM.
      *
       41011-SELNUM-ALLCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択　処理
      *****************************************************************
       41011-SELNUM-CHK-SEC                SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR4.
      *
      *    ＊ 入力時、全対象とする
           IF      I48-SELNUM(IDX-1)   =   "*  "  OR
                                           " * "  OR
                                           "  *" 
               IF     (SPA-I48-GMN-SYORI   =   "9"   AND
                       SPA-I48-GMN-SYORI2  =   SPACE )
                   CONTINUE
               ELSE
      *            入力コードより編集の時、内服（Ｆ２）とする
      **             IF      SPA-I48-TYPE        =   "1" 
      **                 PERFORM 230-NAIFUKU-SEC
      **             ELSE
                       MOVE    "1"                 TO  SPA-I48-GMN-ALL
                       INITIALIZE              SPA-I48-NAI-SELNUM-G
                       INITIALIZE              SPA-I48-GMN-SELNUM-G
                       MOVE    SPACE           TO  SPA-I48-SRYCD-G
      *                ＳＰＡセット
                       MOVE    ZERO                TO  SPA-I48-NEXT
                       PERFORM                     310-SPA-SET-SEC
      **             END-IF
                   GO      TO      41011-SELNUM-CHK-EXT
               END-IF
           END-IF.
      *
           MOVE    I48-SELNUM(IDX-1)   TO  SPA-I48-GMN-SELNUM (IDX-1).
      *    選択番号入力
           INITIALIZE                      ORCSNUMAREA.
           MOVE    I48-SELNUM(IDX-1)   TO  SNUM-INX.
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA.
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN         =   "1"   )   OR
                  (SNUM-SYOKBN         =   "1"   )
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    IDX-1               TO  SPA-GMN-CUR4
               GO      TO      41011-SELNUM-CHK-EXT
           ELSE
               MOVE    SNUM-OUTNUM     TO  SPA-I48-NAI-SELNUM(IDX-1)
           END-IF.
      *    １件のみとき、１とする
           IF     (SPA-I48-GMN-MAX     =   1  )  AND
                  (IDX-1               =   1  )  AND
                  (SPA-I48-NAI-SELNUM(IDX-1)   =  ZERO)
               MOVE    1               TO  SPA-I48-NAI-SELNUM(IDX-1)
           END-IF.
      *
           MOVE    ZERO                TO  WRK-SELNO.
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-I48-GMN-MAX
               IF      SPA-I48-NAI-NO (IDX)    =   SPA-I48-NAI-SELNUM
                                                            (IDX-1)
                   MOVE    IDX             TO  WRK-SELNO
                   MOVE    200             TO  IDX
               END-IF
           END-PERFORM.
      *
      *    検査チェック
      **     IF      SPA-I48-GMN-SYORI   =   "9"
      **         IF      SPA-I48-GMN-SYORI2  =   SPACE
      **             PERFORM 41013-KENSA-GRP-SEC
      **         ELSE
      **             PERFORM 41014-KENSA-SEL-SEC
      **         END-IF
      **     ELSE
               PERFORM 41012-SRYCD-SEL-SEC
      **     END-IF.
      *
       41011-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療コード選択処理
      *****************************************************************
       41012-SRYCD-SEL-SEC       SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR4.
           IF     (SPA-I48-NAI-SELNUM(IDX-1)
                                       NOT =   ZERO ) AND
                  (IDX-1               NOT =   1    ) 
               MOVE    "0003"          TO  SPA-ERRCD
           ELSE
               PERFORM 41011-SELNO-SEC
           END-IF.
      *
           IF      SPA-ERRCD           =   SPACE
      *         戻るへ
                PERFORM 210-BACK
           END-IF.
      *
       41012-SRYCD-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    検査グループ選択処理
      *****************************************************************
       41013-KENSA-GRP-SEC             SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR4.
      *
           IF     (SPA-I48-NAI-SELNUM(IDX-1)
                                       NOT =   ZERO ) AND
                  (IDX-1               NOT =   1     ) 
               MOVE    "0003"          TO  SPA-ERRCD
               GO      TO      41013-KENSA-GRP-EXT
           ELSE
               IF      SPA-I48-NAI-SELNUM(IDX-1)   =   ZERO
                   GO      TO      41013-KENSA-GRP-EXT
               END-IF
           END-IF.
      *
           IF      WRK-SELNO           =   ZERO
               MOVE    "0002"              TO  SPA-ERRCD
               GO      TO      41013-KENSA-GRP-EXT
           END-IF.
           MOVE    SPA-I48-GMN-NO-X(WRK-SELNO)  TO  SPA-I48-NAI-KENSA.
           EVALUATE    SPA-I48-NAI-KENSANO
               WHEN    31
               WHEN    41
      *            包括
                   MOVE    "1"                 TO  SPA-I48-NAI-HOUKATU
               WHEN    32
               WHEN    42
      *            包括外
                   MOVE    "2"                 TO  SPA-I48-NAI-HOUKATU
               WHEN    OTHER
      *            その他
                   MOVE    SPACE               TO  SPA-I48-NAI-HOUKATU
           END-EVALUATE.
      *
           PERFORM 5010-GRPMEI-SET-SEC.
           IF      WRK-GRP-MEI         =   SPACE
               MOVE    "0001"              TO  SPA-ERRCD
           ELSE
               MOVE    "1"                 TO  SPA-I48-GMN-SYORI2
               MOVE    SPACE               TO  SPA-I48-TYPE
               INITIALIZE                      SPA-I48-GMN-SELNUM-G
               INITIALIZE                      SPA-I48-NAI-SELNUM-G
               MOVE    SPACE               TO  SPA-I48-SRYCD-G
      *        ＳＰＡセット
               MOVE    ZERO                TO  SPA-I48-NEXT
               PERFORM 310-SPA-SET-SEC
           END-IF.
      *
       41013-KENSA-GRP-EXT.
           EXIT.
      *
      *****************************************************************
      *    検査選択処理
      *****************************************************************
       41014-KENSA-SEL-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-SYURYOU.
           IF      SPA-I48-NAI-SELNUM(IDX-1)   =   ZERO
               IF     (IDX-1               =   5   )  OR
                     ((IDX-1               <   5   )  AND
                      (SPA-I48-NAI-SELNUM(IDX-1 + 1)  =   ZERO))
                   IF      IDX-1           >   1
                       MOVE    1               TO  FLG-SYURYOU
                   END-IF
               END-IF
               PERFORM 410141-TBL-SAIHEN-SEC
           ELSE
               PERFORM 41011-SELNO-SEC
               IF      SPA-ERRCD           =  SPACE
                   IF     (IDX-1           =   5   )  OR
                          (IDX-1           =   SPA-I48-GMN-MAX)
                       MOVE    1               TO  FLG-SYURYOU
                   ELSE
                       COMPUTE SPA-GMN-CUR4    =   IDX-1   +   1
                   END-IF
               ELSE
                   MOVE    IDX-1               TO  SPA-GMN-CUR4
               END-IF
           END-IF.
      *
           IF      SPA-ERRCD           =   SPACE
               IF      FLG-SYURYOU         =   1
      *             戻るへ
                    PERFORM 210-BACK
               END-IF
           END-IF.
      *
       41014-KENSA-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択空白削除処理
      *****************************************************************
       410141-TBL-SAIHEN-SEC       SECTION.
      *
           MOVE    ZERO                TO  IDX1.
           MOVE    SPA-I48-NAI-SELNUM-G    TO  WRK-NAI-SELNUM-G.
           MOVE    SPA-I48-GMN-SELNUM-G    TO  WRK-GMN-SELNUM-G.
           MOVE    SPA-I48-SRYCD-G     TO  WRK-I48-SRYCD-G.
      *
           INITIALIZE                  SPA-I48-GMN-SELNUM-G.
           INITIALIZE                  SPA-I48-NAI-SELNUM-G.
           INITIALIZE                  SPA-I48-SRYCD-G.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL       IDX2    >   5
               IF      WRK-NAI-SELNUM (IDX2)   =   ZERO
                   CONTINUE
               ELSE
                   ADD     1               TO  IDX1
                   MOVE    WRK-GMN-SELNUM (IDX2)
                                           TO  SPA-I48-GMN-SELNUM(IDX1)
                   MOVE    WRK-NAI-SELNUM (IDX2)
                                           TO  SPA-I48-NAI-SELNUM(IDX1)
                   MOVE    WRK-I48-SRYCD (IDX2)
                                           TO  SPA-I48-SRYCD   (IDX1)
                   MOVE    IDX1            TO  IDX
               END-IF
           END-PERFORM.
      *
           COMPUTE SPA-GMN-CUR4        =   IDX1    +   1.
      *
       410141-TBL-SAIHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41012-LISTSEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO.
           MOVE    ZERO                TO  WRK-GMN-SELNO.
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   200
               IF      I48-SELECT (IDX)    =   "T"
                   MOVE    SPA-I48-GMN-NO(IDX)  TO  WRK-GMN-SELNO
                   MOVE    IDX                  TO  WRK-SELNO
                   MOVE    200             TO  IDX
               END-IF
           END-PERFORM.
      *
           IF      WRK-SELNO           <   01  OR
                                       >   SPA-I48-GMN-MAX
               MOVE    "0002"          TO  SPA-ERRCD
               GO      TO              41012-LISTSEL-EXT
           END-IF.
      *
           MOVE    ZERO                TO  IDX-1.
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL       IDX2    >   5
               IF      SPA-I48-NAI-SELNUM(IDX2)    =   ZERO
                   MOVE    IDX2                TO  IDX-1
                   MOVE    WRK-SELNO           TO  SPA-I48-NAI-SELNUM
                                                                (IDX-1)
                   MOVE    WRK-GMN-SELNO       TO  SPA-I48-GMN-SELNUM
                                                                (IDX-1)
                   MOVE    5                   TO  IDX2
               END-IF
           END-PERFORM.
           IF      IDX-1               =  ZERO
               MOVE    "0002"          TO  SPA-ERRCD
               GO      TO              41012-LISTSEL-EXT
           END-IF.
      *
      *    検査チェック
      **     IF      SPA-I48-GMN-SYORI   =   "9"
      **         IF      SPA-I48-GMN-SYORI2  =   SPACE
      **             PERFORM 41013-KENSA-GRP-SEC
      **         ELSE
      **             PERFORM 41014-KENSA-SEL-SEC
      **         END-IF
      **     ELSE
               PERFORM 41012-SRYCD-SEL-SEC
      **     END-IF.
      *
       41012-LISTSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細選択編集処理
      *****************************************************************
       41011-SELNO-SEC       SECTION.
      *
           IF      WRK-SELNO           <   01  OR
                                       >   SPA-I48-GMN-MAX
               MOVE    "0002"          TO  SPA-ERRCD
               GO      TO              41011-SELNO-EXT
           END-IF.
      *
           MOVE    WRK-SELNO           TO  IDX.
      *
           MOVE    SPA-I48-GMN-SRYCD (IDX)
                                       TO  SPA-I48-SRYCD (IDX-1).
      *
       41011-SELNO-EXT.
           EXIT.
      *
      *****************************************************************
      *    内服薬剤選択処理
      *****************************************************************
      ** 230-NAIFUKU-SEC                   SECTION.
      *
      **     MOVE    "3"                 TO  SPA-I48-GMN-SYORI.
      **     MOVE    "2"                 TO  SPA-I48-TYPE.
      *
      **     INITIALIZE                      SPA-I48-NAI-SELNUM-G.
      **     INITIALIZE                      SPA-I48-GMN-SELNUM-G.
      **     MOVE    SPACE               TO  SPA-I48-SRYCD-G.
      **     MOVE    SPACE               TO  SPA-I48-GMN-ALL.
      **     MOVE    ZERO                TO  SPA-I48-NEXT.
      *    ＳＰＡセット
      **     PERFORM                     310-SPA-SET-SEC.
      *
      ** 230-NAIFUKU-EXT.
      **     EXIT.
      *
      *****************************************************************
      *    外用薬選択処理
      *****************************************************************
      ** 240-GAIYOU-SEC                   SECTION.
      *
      **     MOVE    "4"                 TO  SPA-I48-GMN-SYORI.
      **     MOVE    "2"                 TO  SPA-I48-TYPE.
      *
      **     INITIALIZE                      SPA-I48-NAI-SELNUM-G.
      **     INITIALIZE                      SPA-I48-GMN-SELNUM-G.
      **     MOVE    SPACE               TO  SPA-I48-SRYCD-G.
      **     MOVE    SPACE               TO  SPA-I48-GMN-ALL.
      *    ＳＰＡセット
      **     MOVE    ZERO                TO  SPA-I48-NEXT.
      **     PERFORM                     310-SPA-SET-SEC.
      *
      ** 240-GAIYOU-EXT.
      **     EXIT.
      *
      *****************************************************************
      *    注射薬選択処理
      *****************************************************************
      ** 250-CHUUSYA-SEC                   SECTION.
      *
      **     MOVE    "5"                 TO  SPA-I48-GMN-SYORI.
      **     MOVE    "2"                 TO  SPA-I48-TYPE.
      *
      **     INITIALIZE                      SPA-I48-NAI-SELNUM-G.
      **     INITIALIZE                      SPA-I48-GMN-SELNUM-G.
      **     MOVE    SPACE               TO  SPA-I48-SRYCD-G.
      **     MOVE    SPACE               TO  SPA-I48-GMN-ALL.
      *    ＳＰＡセット
      **     MOVE    ZERO                TO  SPA-I48-NEXT.
      **     PERFORM                     310-SPA-SET-SEC.
      *
      ** 250-CHUUSYA-EXT.
      **     EXIT.
      *
      *****************************************************************
      *    器材選択処理
      *****************************************************************
      ** 270-KIZAI-SEC                   SECTION.
      *
      **     MOVE    "7"                 TO  SPA-I48-GMN-SYORI.
      **     MOVE    "2"                 TO  SPA-I48-TYPE.
      *
      **     INITIALIZE                      SPA-I48-NAI-SELNUM-G.
      **     INITIALIZE                      SPA-I48-GMN-SELNUM-G.
      **     MOVE    SPACE               TO  SPA-I48-SRYCD-G.
      **     MOVE    SPACE               TO  SPA-I48-GMN-ALL.
      *    ＳＰＡセット
      **     MOVE    ZERO                TO  SPA-I48-NEXT.
      **     PERFORM                     310-SPA-SET-SEC.
      *
      ** 270-KIZAI-EXT.
      **     EXIT.
      *
      *****************************************************************
      *    診療行為選択処理
      *****************************************************************
       280-SINRYOU-SEC                   SECTION.
      *
           MOVE    "8"                 TO  SPA-I48-GMN-SYORI.
           MOVE    "2"                 TO  SPA-I48-TYPE.
      *
           INITIALIZE                      SPA-I48-NAI-SELNUM-G.
           INITIALIZE                      SPA-I48-GMN-SELNUM-G.
           MOVE    SPACE               TO  SPA-I48-SRYCD-G.
           MOVE    SPACE               TO  SPA-I48-GMN-ALL.
      *    ＳＰＡセット
           MOVE    ZERO                TO  SPA-I48-NEXT.
           PERFORM                     310-SPA-SET-SEC.
      *
       280-SINRYOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院入力分処理
      *****************************************************************
       41014-JIIN-CHK-SEC              SECTION.
      *
           MOVE    7                   TO  SPA-GMN-CUR4.
      *
           MOVE    I48-JIIN            TO  SPA-I48-JIIN-G.
      *
           EVALUATE    SPA-I48-JIIN
               WHEN    "1"
                   MOVE    "J1"            TO  SPA-I48-GMN-SYORI3
               WHEN    "2"
                   MOVE    "J2"            TO  SPA-I48-GMN-SYORI3
               WHEN    "3"
                   MOVE    "J3"            TO  SPA-I48-GMN-SYORI3
               WHEN    "4"
                   MOVE    "J4"            TO  SPA-I48-GMN-SYORI3
               WHEN    "5"
                   MOVE    "J5"            TO  SPA-I48-GMN-SYORI3
               WHEN    "6"
                   MOVE    "J6"            TO  SPA-I48-GMN-SYORI3
      **         WHEN    "7"
      **             MOVE    "J7"            TO  SPA-I48-GMN-SYORI3
      **         WHEN    "8"
      **             MOVE    "J8"            TO  SPA-I48-GMN-SYORI3
      **         WHEN    "9"
      **             MOVE    "J9"            TO  SPA-I48-GMN-SYORI3
               WHEN    OTHER
                   MOVE    "0010"          TO  SPA-ERRCD
                   GO      TO      41014-JIIN-CHK-EXT
           END-EVALUATE.
      *
           MOVE    "U"                 TO  SPA-I48-GMN-SYORI.
           MOVE    "2"                 TO  SPA-I48-TYPE.
      *
           INITIALIZE                      SPA-I48-NAI-SELNUM-G.
           INITIALIZE                      SPA-I48-GMN-SELNUM-G.
           MOVE    SPACE               TO  SPA-I48-SRYCD-G.
           MOVE    SPACE               TO  SPA-I48-GMN-ALL.
      *    ＳＰＡセット
           MOVE    ZERO                TO  SPA-I48-NEXT.
           PERFORM                     310-SPA-SET-SEC.
      *
       41014-JIIN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ユーザー登録分処理
      *****************************************************************
       41014-USER-CHK-SEC              SECTION.
      *
           MOVE    8                   TO  SPA-GMN-CUR4.
      *
           MOVE    I48-USER            TO  SPA-I48-USER-G.
      *
           EVALUATE    SPA-I48-USER
               WHEN    "1"
                   MOVE    "U1"            TO  SPA-I48-GMN-SYORI3
               WHEN    "2"
                   MOVE    "U2"            TO  SPA-I48-GMN-SYORI3
      **         WHEN    "3"
      **             MOVE    "U3"            TO  SPA-I48-GMN-SYORI3
      **         WHEN    "4"
      **             MOVE    "U4"            TO  SPA-I48-GMN-SYORI3
      **         WHEN    "5"
      **             MOVE    "U5"            TO  SPA-I48-GMN-SYORI3
               WHEN    OTHER
                   MOVE    "0011"          TO  SPA-ERRCD
                   GO      TO      41014-USER-CHK-EXT
           END-EVALUATE.
      *
           MOVE    "U"                 TO  SPA-I48-GMN-SYORI.
           MOVE    "2"                 TO  SPA-I48-TYPE.
      *
           INITIALIZE                      SPA-I48-NAI-SELNUM-G.
           INITIALIZE                      SPA-I48-GMN-SELNUM-G.
           MOVE    SPACE               TO  SPA-I48-SRYCD-G.
           MOVE    SPACE               TO  SPA-I48-GMN-ALL.
      *    ＳＰＡセット
           MOVE    ZERO                TO  SPA-I48-NEXT.
           PERFORM                     310-SPA-SET-SEC.
      *
       41014-USER-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    検査選択処理
      *****************************************************************
      ** 290-KENSA-SEC                   SECTION.
      *
      **     MOVE    "9"                 TO  SPA-I48-GMN-SYORI.
      **     MOVE    SPACE               TO  SPA-I48-GMN-SYORI2.
      **     MOVE    SPACE               TO  SPA-I48-GMN-SYORI3.
      **     MOVE    "2"                 TO  SPA-I48-TYPE.
      **     MOVE    SPACE               TO  SPA-I48-GMN-ALL.
      *
      *    ＳＰＡセット
      **     INITIALIZE                  SPA-I48-GMN-TBL.
      **     MOVE    ZERO                TO  SPA-I48-GMN-MAX.
      **     INITIALIZE                      SPA-I48-NAI-SELNUM-G.
      **     INITIALIZE                      SPA-I48-GMN-SELNUM-G.
      **     MOVE    SPACE               TO  SPA-I48-SRYCD-G.
      *
      **     PERFORM VARYING     IDX     FROM    1   BY  1
      **             UNTIL       IDX     >   24
      *
      **         SET     TBL-IDX                 TO  IDX
      **         MOVE    TBL-GRP-KBN (TBL-IDX)   TO  SPA-I48-GMN-NO-X
      **                                                         (IDX)
      **         MOVE    TBL-GRP-MEI (TBL-IDX)   TO  SPA-I48-GMN-NAME
      **                                                         (IDX)
      **     END-PERFORM.
      *
      **     MOVE    24                  TO  SPA-I48-GMN-MAX.
      *
      **     MOVE    1                   TO  SPA-GMN-CUR4.
      *
      ** 290-KENSAU-EXT.
      **     EXIT.
      *
      *****************************************************************
      *    全体一致処理
      *****************************************************************
       290-ALL-SEL-SEC                   SECTION.
      *
           MOVE    SPA-I48-GMN-INPUT   TO  WRK-INPUTCD.
           IF     (SPA-I48-GMN-SYORI   =   "9"   )   AND
                  (SPA-I48-GMN-SYORI2  =   SPACE )
               CONTINUE
           ELSE
               IF      WRK-WIDGET        =   MCP-WIDGET
                   MOVE    "1"                 TO  SPA-I48-GMN-ALL
               ELSE
                   MOVE    SPACE               TO  SPA-I48-GMN-ALL
               END-IF
      *        入力コードより編集の時、内服（Ｆ２）とする
      **         IF      SPA-I48-TYPE        =   "1" 
      **             PERFORM 230-NAIFUKU-SEC
      **         ELSE
                   INITIALIZE                  SPA-I48-NAI-SELNUM-G
                   INITIALIZE                  SPA-I48-GMN-SELNUM-G
                   MOVE    SPACE               TO  SPA-I48-SRYCD-G
                   MOVE    ZERO                TO  SPA-I48-NEXT
      ***             
               MOVE    SPACE               TO  SPA-I48-TYPE
      ***             
      *            ＳＰＡセット
                   PERFORM                     310-SPA-SET-SEC
      **         END-IF
      *
               IF       WRK-WIDGET-SW         =   "1"
                   MOVE   MCP-WIDGET           TO  WRK-WIDGET
               END-IF
           END-IF.
      *
       290-ALL-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    次ページ処理
      *****************************************************************
       270-NEXT-SEC                   SECTION.
      *
           IF      SPA-I48-NEXT       >   ZERO
      *        ＳＰＡセット
               PERFORM                     3102-TENSU-SET-SEC
           ELSE
               MOVE    "0006"              TO  SPA-ERRCD
           END-IF.
      *
       270-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    部分一致処理
      *****************************************************************
       291-BUB-SEC                   SECTION.
      *
      *    全角入力時、のみ
           IF      SPA-I48-CDSYUBETU   NOT =   "J"
               GO      TO      291-BUB-EXT
           END-IF.
      *    検査以外の時のみ
           IF      SPA-I48-GMN-SYORI   =   "9"
               GO      TO      291-BUB-EXT
           END-IF.
      *
           MOVE    SPACE               TO  WRK-INPUTCD.
           STRING  "＊"                DELIMITED  BY  SIZE
                   SPA-I48-GMN-INPUT   DELIMITED  BY  SPACE
                   "＊"                DELIMITED  BY  SIZE
                                       INTO    WRK-INPUTCD
           END-STRING.
      *
           IF      WRK-WIDGET        =   MCP-WIDGET
               MOVE    "1"                 TO  SPA-I48-GMN-ALL
           ELSE
               MOVE    SPACE               TO  SPA-I48-GMN-ALL
           END-IF.
      *    入力コードより編集の時、内服（Ｆ２）とする
      **     IF      SPA-I48-TYPE        =   "1" 
      **         PERFORM 230-NAIFUKU-SEC
      **     ELSE
               INITIALIZE                  SPA-I48-NAI-SELNUM-G
               INITIALIZE                  SPA-I48-GMN-SELNUM-G
               MOVE    SPACE               TO  SPA-I48-SRYCD-G
               MOVE    ZERO                TO  SPA-I48-NEXT
      ***             
               MOVE    SPACE               TO  SPA-I48-TYPE
      ***
      *        ＳＰＡセット
               PERFORM                     310-SPA-SET-SEC
      **     END-IF.
      *
           IF       WRK-WIDGET-SW         =   "1"
               MOVE   MCP-WIDGET           TO  WRK-WIDGET
           END-IF.
      *
       291-BUB-EXT.
           EXIT.
      ****************************************************************
      *    後分一致処理
      *****************************************************************
       292-ATO-SEC                   SECTION.
      *
      *    全角入力時、のみ
           IF      SPA-I48-CDSYUBETU   NOT =   "J"
               GO      TO      292-ATO-EXT
           END-IF.
      *    検査以外の時のみ
           IF      SPA-I48-GMN-SYORI   =   "9"
               GO      TO      292-ATO-EXT
           END-IF.
      *
           MOVE    SPACE               TO  WRK-INPUTCD.
           STRING  "＊"                DELIMITED  BY  SIZE
                   SPA-I48-GMN-INPUT   DELIMITED  BY  SPACE
                                       INTO    WRK-INPUTCD
           END-STRING.
      *
           IF      WRK-WIDGET        =   MCP-WIDGET
               MOVE    "1"                 TO  SPA-I48-GMN-ALL
           ELSE
               MOVE    SPACE               TO  SPA-I48-GMN-ALL
           END-IF.
      *    入力コードより編集の時、内服（Ｆ２）とする
      **     IF      SPA-I48-TYPE        =   "1" 
      **         PERFORM 230-NAIFUKU-SEC
      **     ELSE
               INITIALIZE                  SPA-I48-NAI-SELNUM-G
               INITIALIZE                  SPA-I48-GMN-SELNUM-G
               MOVE    SPACE               TO  SPA-I48-SRYCD-G
               MOVE    ZERO                TO  SPA-I48-NEXT
      ***             
               MOVE    SPACE               TO  SPA-I48-TYPE
      ***
      *        ＳＰＡセット
               PERFORM                     310-SPA-SET-SEC
      **     END-IF.
      *
           IF       WRK-WIDGET-SW         =   "1"
               MOVE   MCP-WIDGET           TO  WRK-WIDGET
           END-IF.
      *
       292-ATO-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "I44"               TO  SPA-SAKIPG.
           MOVE    "I48"               TO  SPA-MOTOPG.
      *
           MOVE    "JOIN"              TO  MCP-PUTTYPE.
           MOVE    "I44"               TO  MCP-WINDOW.
      *
           MOVE    SPA-I4KYOUTU        TO  SPA-WORK.
      *
           MOVE    SPA-KYOUTU          TO  LNK-COMMON.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC.
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF.
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "I48"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    WRK-INPUTCD         TO  WRK-INPUTCD-W.
      *
           MOVE    SPACE               TO  SPA-ERRMSG.
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "選択番号入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE
                   "検査以外の時、最初の選択番号位置のみの入力可能です"
                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE
                   "対象データがありません。"
                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE
                   "対象データが２００件以上あります。"
                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE
                   "次ページはありません。"
                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE
                   "自院採用区分がありません。"
                                       TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE
                   "ユーザー登録区分がありません。"
                                       TO  SPA-ERRMSG
               WHEN    "0020"
                   MOVE
                   "種別の違うデータです。選択できません。"
                                       TO  SPA-ERRMSG
           END-EVALUATE.
      *
           MOVE    SPACE               TO  I4ERR.
           MOVE    SPA-ERRCD           TO  I4ERR-ERRCODE.
           MOVE    SPA-ERRMSG          TO  I4ERR-ERRMSG.
           MOVE    "B01"               TO  MCP-WIDGET.
      *
           MOVE    "I48"               TO  SPA-MOTOPG.
           MOVE    "I4ERR"             TO  SPA-SAKIPG.
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "I4ERR"             TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       510-ERRSET-EXT.
           EXIT.
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               MOVE    ZERO                TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF.
      *
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力コードマスター読込
      *****************************************************************
       930-INPUTCD-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  INPUTCD-REC
               MOVE    ZERO                TO  FLG-INPUTCD
           ELSE
               INITIALIZE                      INPUTCD-REC
               MOVE    1                   TO  FLG-INPUTCD
           END-IF.
      *
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
       900-PUT-WINDOW-EXT.
           EXIT.
      *
