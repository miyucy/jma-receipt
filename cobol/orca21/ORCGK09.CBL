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
       PROGRAM-ID.                 ORCGK09.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為入力
      *  コンポーネント名  : 診療行為選択（ＤＯ）（Ｋ０９）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/05/25    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメタデータ
           SELECT  PARA-FILE       ASSIGN  FILE-NAME2
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-PARA.
      *
      *    ＳＰＡデータ
           SELECT  SPASCR-FILE     ASSIGN  FILE-NAME1
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-SPASCR.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *    パラメタデータ
       FD  PARA-FILE.
       01  PARA-REC.
           03  PARA-KEY.
               05  PARA-FILEMEI         PIC X(08).
               05  PARA-EDANUM          PIC 9(03).
           03  PARA-DATA-REC            PIC X(60000).
      *
      *    ＳＰＡパラメタデータ
       FD  SPASCR-FILE.
       01  SPA-DATA-REC            PIC X(30000).
      *
       WORKING-STORAGE             SECTION.
      *
      * ＳＰＡデータ
       01  FILE-NAME1.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(09)   VALUE   "K09SPASCR".
           03  FILE-TERMID1        PIC X(16)   VALUE   SPACE.
           03  FILLER              PIC X(06)   VALUE   ".TXT".
      *    パラメタファイル名
       01  FILE-NAME2.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(09)   VALUE   "K01PARA".
           03  FILE-TERMID2        PIC X(16)   VALUE   SPACE.
           03  FILLER              PIC X(06)   VALUE   ".TXT".
      *
      *
       01  WRK-DATA-REC.
           03  WRK-DATA            PIC X(30000)
                                   OCCURS  10.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    診療行為用共通パラメタ
           COPY    "K01COMMON-SPA".
      *
      *    画面用共通スパ領域
           COPY    "K02SCR-SPA".
      *
      *    画面スパ領域
       01  SPA-K09.
           03  SPA-K09-AREA.
      *********05  SPA-GMN-PAGE                  PIC 9(02).
      *        05  SPA-MAX-PAGE                  PIC 9(02).
      *        05  SPA-GMN-LINE                  PIC 9(02).
      *********05  SPA-GMN-MAX1                  PIC 9(04).
               05  SPA-GMN-MAX2                  PIC 9(04).
               05  SPA-NAI-MAX2                  PIC 9(04).
               05  SPA-K09GMN-CUR                PIC 9(02).
      *
      *        05  SPA-GMN-RRKTBL.
      *            07  SPA-GMN-RRKTBLREC         OCCURS  100.
      *                09  SPA-GMN-NO            PIC 9(03).
      ****             09  SPA-GMN-SRYYMD        PIC X(10).
               05  SPA-GMN-TBL.
                   07  SPA-GMN-TBLREC  OCCURS  400.
                       09  SPA-GMN-TBANGO      PIC 9(03).
                       09  SPA-GMN-TMEISYO     PIC X(200).
                       09  SPA-GMN-TMEISYO-1   REDEFINES
                                                   SPA-GMN-TMEISYO.
                           11  SPA-GMN-TYOBI0      PIC X(02).
                           11  SPA-GMN-TMEISYO1    PIC X(196).
                       09  SPA-GMN-TMEISYO-2   REDEFINES
                                               SPA-GMN-TMEISYO.
                           11  SPA-GMN-TMEISYO2    PIC X(44).
                           11  SPA-GMN-HEN1.
                               13  SPA-GMN-TSURYOU     PIC X(18).
                               13  SPA-GMN-TTANI1      PIC X(08).
                               13  SPA-GMN-TTANMEI     PIC X(06).
                               13  SPA-GMN-TTANI2      PIC X(04).
                               13  SPA-GMN-TYOBI1      PIC X(14).
                           11  SPA-GMN-HEN2    REDEFINES
                                               SPA-GMN-HEN1.
                               13  SPA-GMN-TZAIKEI     PIC X(40).
      *
                       09  SPA-NAI-TBANGO        PIC  9(03).
      *
      *****    05  SPA-GMN-SELNUM            PIC X(03).
               05  SPA-GMN-DOSEL             PIC X(40).
      *
               05  SPA-NAI-AREA.
      ****         07  SPA-NAI-RRKTBL.
      *                09  SPA-NAI-RRKTBLREC         OCCURS   100.
      *                    11  SPA-NAI-SRYYMD        PIC  X(08).
      *                    11  SPA-NAI-RENNUM        PIC  9(01).
      *                    11  SPA-NAI-DOUJI-RENNUM  PIC  9(01).
      ****         07  SPA-NAI-SELNUM            PIC 9(03).
      *
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBLREC            OCCURS   400.
                           11  SPA-NAI-ZAINUM        PIC  9(08).
                       09  SPA-SEL-IDX               PIC  9(02).
                       09  SPA-SEL-RENNUM            PIC  9(01).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
           03  STS-SRYKBN          PIC X(02).
           03  STS-SPASCR          PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SPASCR          PIC 9(01).
           03  FLG-SRYKBN          PIC 9(01).
           03  FLG-WKSRYACT        PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-PTCOM           PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-INPUTCD         PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
           03  FLG-SP              PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-ARI             PIC 9(01).
           03  FLG-SINKI           PIC 9(01).
           03  FLG-YAKUSOKU        PIC 9(01).
           03  FLG-CHK             PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDG                 PIC 9(04).
           03  IDM                 PIC 9(04).
           03  IDK1                PIC 9(04).
           03  IDK2                PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(02).
           03  IDX-P               PIC 9(04).
           03  IDX-KOUI            PIC 9(04).
           03  IDX-SIN             PIC 9(04).
           03  IDX-ATO             PIC 9(04).
           03  IDX-YAKUZAI         PIC 9(04).
           03  IDX-Y2              PIC 9(02).
      *
           03  IDX-R                   PIC 9(04).
           03  IDX-W                   PIC 9(04).
           03  IDX-KAI                 PIC 9(04).
           03  IDX-STR                 PIC 9(02).
           03  IDX-H                   PIC 9(04).
      *
           03  IDX-S                   PIC 9(04).
           03  IDX-D1                  PIC 9(04).
           03  IDX-D2                  PIC 9(04).
           03  IDX-Z                   PIC 9(04).
           03  IDX-ZAI                 PIC 9(04).
      *
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
      *
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WFIL1       PIC X(01).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WFIL2       PIC X(01).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-BANGO               PIC 9(03).
           03  WRK-DOSELNUM            PIC 9(03).
           03  WRK-BANGO-X             PIC X(03).
      *
           03  WRK-DOSEL.
               05  WRK-DOSEL-OCC   OCCURS   100.
                   07  WRK-DO          PIC X(03).
                   07  WRK-DONUM       PIC 9(03).
                   07  WRK-SEL         PIC X(01).
      *
           03  WRK-DOZAINUM-AREA.
               05  WRK-DOZAINUM-OCC    OCCURS   100.
                   07  WRK-DOZAINUM    PIC 9(08).
      *
           03  HZN-DOZAINUM-AREA.
               05  HZN-DOZAINUM-OCC    OCCURS   100.
                   07  HZN-DOZAINUM    PIC 9(08).
      *
           03  WRK-ZAINUM          PIC 9(08).
           03  WRK-ZAIKAISU        PIC 9(08).
           03  WRK-EDANUM          PIC 9(02).
      *
           03  WRK-TENSU-X.
               05  WRK-TENSU       PIC Z(08).
           03  WRK-KAISU-X.
               05  WRK-KAISU       PIC Z(08).
           03  WRK-KEI-X.
               05  WRK-KEI         PIC Z(08).
           03  WRK-KEI-G           PIC 9(08).
      *
      *    診療行為名称
           03  WRK-SRYSYUMEI       PIC X(40).
      *
           03  WRK-MEISYO          PIC X(40).
      *    数量表示用
           03  WRK-SURYO           PIC 9(05)V9(03).
           03  WRK-SURYO-R         REDEFINES   WRK-SURYO.
               05  WRK-SURYO-S1    PIC 9(05).
               05  WRK-SURYO-S2    PIC 9(03).
           03  WRK-SURYO-X.
               05  WRK-SURYO-Z1    PIC ZZZZZ.
               05  WRK-SURYO-Z1-9  REDEFINES   WRK-SURYO-Z1
                                   PIC ZZZZ9.
               05  WRK-SURYO-Z2    PIC X(01).
               05  WRK-SURYO-Z3    PIC ZZZ.
           03  WRK-SURYO-J         PIC X(18).
      *    分画数画面編集用
           03  WRK-BUNGSU-X.
               05  WRK-BUNGSU-Z    PIC ZZZ.
           03  WRK-BUNGSU-J        PIC X(06).
      *    剤回数等画面編集用
           03  WRK-KAISU-H         PIC X(08).
           03  WRK-KEI-H           PIC X(08).
           03  WRK-ZAIKEI          PIC X(40).
           03  WRK-IDG             PIC 9(04).
           03  WRK-ZAIKEIJ         PIC X(80).
           03  IDJ                 PIC 9(04).
           03  IDJ1                PIC 9(01).
           03  IDJ2                PIC 9(04).
      *
           03  WRK-Z9              PIC Z,ZZZ,ZZZ.
           03  WRK-Z92             PIC --,---,---.
           03  WRK-ZZ              PIC ZZZ.
      *
           03  WRK-KIN             PIC 9(07).
      *
           03  WRK-ZAITEN              PIC 9(08).
           03  WRK-SRYKAISUKEI         PIC 9(03).
           03  WRK-SRYSURYOKEI         PIC 9(07)V9(03).
           03  WRK-MEISAISU            PIC 9(07).
           03  WRK-JIHIMONEY           PIC 9(07).
      *
           03  WRK-SEIKYU              PIC S9(07).
      *
           03  WRK-DENPNUM         PIC 9(07).
           03  WRK-MEIBAN          PIC 9(03).
      *
           03  WRK-ERRMSG          PIC X(40).
      *
           03  WRK-GOKEI-X2.
               05  WRK-GOKEI-Z2    PIC ZZZ,ZZZ,ZZZ.
      *
           03  WRK-PATH                    PIC X(64).
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
      *    診療種別名テーブル
           COPY    "CPORCSSRYSYU.INC".
      *
      *   日本語数字
       01  TBL-SUJI-AREA.
           03  FILLER          PIC X(20)   VALUE
              "１２３４５６７８９０".
       01  TBL-SUJI-R          REDEFINES   TBL-SUJI-AREA.
           03  TBL-SUJI        PIC X(02)   OCCURS   10.
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    ワーク診療行為マスタ−
       01  WKSRYACT-REC.
           COPY    "CPWKSRYACT.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    入力コードマスタ−
       01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *
      *    診療行為マスタ−
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    患者コメント
       01  PTCOM-REC.
           COPY    "CPPTCOM.INC".
      *
      *    診療行為マスタワーク
       01  LNK-WKSRYACT-AREA.
           02  LNK-WKSRYACT-REC      OCCURS   300.
           COPY    "CPWKSRYACT.INC"  REPLACING
                                     //WKSRY-// BY //LNK-WKSRY-//.
       01  LNK-WKSRYACT-MAX           PIC 9(04).
      *
      *    診療行為マスタワーク
       01  WRK-WKSRYACT-REC.
           COPY    "CPWKSRYACT.INC"  REPLACING
                                    //WKSRY-// BY //WRK-WKSRY-//.
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
           COPY    "K01.INC".
           COPY    "K02.INC".
           COPY    "K02N.INC".
           COPY    "K021.INC".
           COPY    "K022.INC".
           COPY    "K023.INC".
           COPY    "K03.INC".
           COPY    "K04.INC".
           COPY    "K05.INC".
           COPY    "K051.INC".
           COPY    "K052.INC".
           COPY    "K06.INC".
           COPY    "K07.INC".
           COPY    "K08.INC".
           COPY    "K09.INC".
           COPY    "K10.INC".
           COPY    "K98.INC".
           COPY    "K99.INC".
           COPY    "K03X.INC".
           COPY    "KERR.INC".
           COPY    "KERR2.INC".
           COPY    "KID1.INC".
           COPY    "KID2.INC".
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
           MOVE    SPA-FREE        TO  SPA-K02
           MOVE    SPA-WORK        TO  SPA-K01KYOUTU
      *
      *    診療種別テーブルセット
           PERFORM 1001-SRYKBN-SET-SEC
      *
      *    画面ＳＰＡ読み込み
           PERFORM 1002-K09SPA-SET-SEC
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
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
           PERFORM 1003-K09SPA-OUT-SEC
      *
           MOVE    SPA-K01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-K02         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    診療種別テーブルセット処理
      *****************************************************************
       1001-SRYKBN-SET-SEC             SECTION.
      * 
      *    診療種別テーブルセット
           CALL    "ORCSSRYSYU"        USING
                                       MSYU-DATA-REC
           .
       1001-SRYKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＳＰＡデータＲＥＡＤ処理
      *****************************************************************
       1002-K09SPA-SET-SEC             SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID1
      *
           OPEN    INPUT               SPASCR-FILE
           IF      STS-SPASCR     NOT =   ZERO
               GO      TO      1002-K09SPA-SET-EXT
           END-IF
      *
           MOVE    SPACE               TO  SPA-K09
           INITIALIZE          SPA-K09
           MOVE    SPACE               TO  WRK-DATA-REC
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
           MOVE    WRK-DATA-REC        TO  SPA-K09
      *
           CLOSE                       SPASCR-FILE
           .
       1002-K09SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＳＰＡデータＷＲＩＴＥ処理
      *****************************************************************
       1003-K09SPA-OUT-SEC             SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID1
      *
           OPEN    OUTPUT              SPASCR-FILE
           IF      STS-SPASCR     NOT =   ZERO
               DISPLAY "K09SPASCR OUT OPEN ERR:"   STS-SPASCR "."
           END-IF
      *
           MOVE    SPA-K09             TO  WRK-DATA-REC
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL      (IDX     >   10  )  OR
                              (WRK-DATA (IDX)     =   SPACE)
      *
               MOVE    WRK-DATA (IDX)      TO  SPA-DATA-REC
               WRITE                       SPA-DATA-REC
               IF      STS-SPASCR     NOT =   ZERO
                   DISPLAY "K09SPASCR OUT WRITE ERR:"   STS-SPASCR "."
                END-IF
           END-PERFORM
      *
           CLOSE                       SPASCR-FILE
           .
       1003-K09SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    DISPLAY "*** ORCSNPL    START  ***"
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "KERR"
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
           MOVE   "NEW"                TO  MCP-PUTTYPE.
           MOVE   "K09"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC             SECTION.
      *
           INITIALIZE                  SPA-K09-AREA
           MOVE    ZERO                TO  SPA-K09-SELOK
      *
      *****PERFORM                 310-SPA-SET-SEC
           IF      SPA-NAI-DOSELNUM    >   ZERO
      *        診察内容編集
               PERFORM 4101-JYURRK-HEN-SEC
               IF      SPA-GMN-MAX2        >   ZERO
                   MOVE    2                   TO  SPA-K09GMN-CUR
               ELSE
                   MOVE
                   "＝＝＝＝＝＝＝＝　表示内容なし　＝＝＝＝＝＝＝＝"
                                               TO  SPA-GMN-TMEISYO (01)
                   MOVE    1                   TO  SPA-GMN-MAX2
                   MOVE    1                   TO  SPA-K09GMN-CUR
               END-IF
           ELSE
               MOVE    1               TO  SPA-K09GMN-CUR
           END-IF
      *
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       310-SPA-SET-SEC                  SECTION.
      *
      *    受診歴を検索する  医療機関、患者ＩＤ
      *****INITIALIZE                  JYURRK-REC
      *    MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
      *    MOVE    SPA-PTID            TO  JYURRK-PTID
      *    MOVE    SPA-SRYKA           TO  JYURRK-SRYKA
      **
      *    MOVE    JYURRK-REC          TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    "JYURRK-KEY7"       TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *    IF      MCP-RC              =   ZERO
      *        MOVE    "JYURRK-KEY7"      TO  ORC-DBPATH
      *        PERFORM 970-JYURRK-READ-SEC
      *    ELSE
      *        INITIALIZE                  JYURRK-REC
      *        MOVE    1               TO  FLG-JYURRK
      *    END-IF
      *
      *    MOVE    ZERO                TO  IDX
      *    PERFORM
      *        UNTIL   (FLG-JYURRK         =   1   )  OR
      *                (SPA-GMN-MAX1       >=  100 )
      *        診療日、連番で１行とする
      *        MOVE    ZERO            TO  IDX-S
      *        PERFORM VARYING     IDX2    FROM    1   BY  1
      *                UNTIL       IDX2    >   SPA-GMN-MAX1
      *            IF     (JYURRK-RENNUM       =   SPA-NAI-RENNUM
      *                                                (IDX2))  AND
      *                   (JYURRK-SRYYMD       =   SPA-NAI-SRYYMD
      *                                                (IDX2))
      *                MOVE    IDX2            TO  IDX-S
      *                MOVE    SPA-GMN-MAX1    TO  IDX2
      *            END-IF
      *        END-PERFORM
      *
      *        IF      IDX-S           =   ZERO
      *            ADD     1               TO  SPA-GMN-MAX1
      *            MOVE    SPA-GMN-MAX1    TO  IDX
      *        ELSE
      *            MOVE    IDX-S           TO  IDX
      *        END-IF
      *
      *        明細項目退避
      *        PERFORM 3101-JYURRK-HEN-SEC
      *
      *        MOVE    "JYURRK-KEY7"    TO  ORC-DBPATH
      *        PERFORM 970-JYURRK-READ-SEC
      *    END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "JYURRK-KEY7"       TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    .
      *310-SPA-SET-EXT.
      *    EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
      *3101-JYURRK-HEN-SEC             SECTION.
      *
      *    MOVE    IDX                 TO  SPA-GMN-NO    (IDX)
      *    連番
      *    MOVE    JYURRK-RENNUM       TO  SPA-NAI-RENNUM(IDX)
      *    連番
      *    MOVE    JYURRK-DOUJI-RENNUM TO  SPA-NAI-DOUJI-RENNUM(IDX)
      *    診察日
      *    MOVE    JYURRK-SRYYMD       TO  SPA-NAI-SRYYMD(IDX)
      *    MOVE    JYURRK-SRYYMD       TO  WRK-SYMD
      *    PERFORM 520-SEIWA-HEN-SEC
      *    MOVE    WRK-HENYMDG         TO  SPA-GMN-SRYYMD (IDX)
      *
      *    MOVE    IDX                 TO  SPA-GMN-MAX1
      *
      *    .
      *3101-JYURRK-HEN-EXT.
      *    EXIT.
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
      *    受診履歴へ
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 450-RIREKI-SEC
      *        登録
               WHEN    "CLICKED"       ALSO    "B12"
                    PERFORM 450-TOROKU-SEC
           END-EVALUATE
          .
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
      *        診療日選択番号
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 410-SELNUM-CHK-SEC
      *        診療日選択
               WHEN    ANY             ALSO    "RRKLIST"
                   PERFORM 430-RRKLIST-CHK-SEC
      *        明細選択
               WHEN    ANY             ALSO    "MEILIST"
                   PERFORM 440-MEILIST-CHK-SEC
      *        剤番号選択
               WHEN    "ACTIVATE"      ALSO    "DOSEL"
                   PERFORM 420-DOSEL-CHK-SEC
           END-EVALUATE
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療日選択番号入力チェック処理
      *****************************************************************
       410-SELNUM-CHK-SEC              SECTION.
      *
           MOVE    1                   TO  SPA-K09GMN-CUR
      *
           MOVE    K09-SELNUM          TO  SPA-GMN-DOSELNUM
           IF      K09-SELNUM          =   SPACE
               MOVE    ZERO                TO  SPA-NAI-DOSELNUM
           ELSE
               INITIALIZE                      ORCSNUMAREA
               MOVE    K09-SELNUM          TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                           ORCSNUMAREA
               IF     (SNUM-RC         NOT =   ZERO  )   OR
                      (SNUM-MINKBN     NOT =   SPACE )   OR
                      (SNUM-SYOKBN     NOT =   SPACE )
                   MOVE    "0001"              TO  SPA-ERRCD
                   GO      TO      410-SELNUM-CHK-EXT
               ELSE
                   MOVE    SNUM-OUTNUM       TO  SPA-NAI-DOSELNUM
               END-IF
           END-IF
           MOVE    SPA-NAI-DOSELNUM    TO  WRK-ZZ
           MOVE    WRK-ZZ              TO  SPA-GMN-DOSELNUM
      *
           IF      SPA-NAI-DOSELNUM    <   01   OR
                                       >   SPA-GMN-MAX1
               MOVE    "0001"              TO  SPA-ERRCD
           ELSE
      *        診察内容編集
               PERFORM 4101-JYURRK-HEN-SEC
               IF      SPA-GMN-MAX2        >   ZERO
                   MOVE    2                   TO  SPA-K09GMN-CUR
               ELSE
                   MOVE
                   "＝＝＝＝＝＝＝＝　表示内容なし　＝＝＝＝＝＝＝＝"
                                               TO  SPA-GMN-TMEISYO (01)
                   MOVE    1                   TO  SPA-GMN-MAX2
                   MOVE    1                   TO  SPA-K09GMN-CUR
               END-IF
           END-IF
      *
           .
       410-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療日選択処理
      *****************************************************************
       430-RRKLIST-CHK-SEC           SECTION.
      *
           MOVE    ZERO                TO  WRK-DOSELNUM
      *
           PERFORM VARYING     IDX   FROM   1   BY  1
                   UNTIL       IDX   >   SPA-GMN-MAX1
              IF      K09-RRKLIST-SELECT(IDX)  =  "T"
                  IF      IDX                  =   SPA-NAI-DOSELNUM
                      CONTINUE
                  ELSE
                      MOVE    SPA-GMN-NO (IDX)    TO  WRK-DOSELNUM
                  END-IF
              END-IF
           END-PERFORM
      *
           IF      WRK-DOSELNUM        >   ZERO
               MOVE    WRK-DOSELNUM        TO  SPA-NAI-DOSELNUM
           END-IF
      *
           IF      SPA-NAI-DOSELNUM    <   01   OR
                                       >   SPA-GMN-MAX1
               CONTINUE
           ELSE
               MOVE    K09-NO  (SPA-NAI-DOSELNUM)
                                           TO  SPA-GMN-DOSELNUM
      *        診察内容編集
               PERFORM 4101-JYURRK-HEN-SEC
               IF      SPA-GMN-MAX2        >   ZERO
                   MOVE    2                   TO  SPA-K09GMN-CUR
               ELSE
                   MOVE
                   "＝＝＝＝＝＝＝＝　表示内容なし　＝＝＝＝＝＝＝＝"
                                               TO  SPA-GMN-TMEISYO (01)
                   MOVE    1                   TO  SPA-GMN-MAX2
                   MOVE    1                   TO  SPA-K09GMN-CUR
               END-IF
           END-IF
      *
           .
       430-RRKLIST-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細選択選択処理
      *****************************************************************
       440-MEILIST-CHK-SEC           SECTION.
      *
           MOVE    ZERO                TO  WRK-BANGO
      *
           PERFORM VARYING     IDX   FROM   1   BY  1
                   UNTIL       IDX   >   SPA-GMN-MAX2
              IF      K09-MEILIST-SELECT(IDX)  =  "T"
                  MOVE    SPA-NAI-TBANGO (IDX)     TO  WRK-BANGO
              END-IF
           END-PERFORM
      *
           IF      WRK-BANGO           =   ZERO
               GO      TO      440-MEILIST-CHK-EXT
           END-IF
      *
           MOVE    WRK-BANGO           TO  WRK-ZZ
           MOVE    SPACE               TO  WRK-BANGO-X
           MOVE    ZERO                TO  IDX-D1
           PERFORM VARYING     IDX-D2  FROM    1   BY  1
                   UNTIL       IDX-D2  >   3
               IF      WRK-ZZ(IDX-D2:1)    NOT =   SPACE
                   ADD     1               TO  IDX-D1
                   MOVE    WRK-ZZ(IDX-D2:1)    TO  WRK-BANGO-X(IDX-D1:1)
               END-IF
           END-PERFORM
      *
           MOVE    SPA-GMN-DOSEL       TO  WRK-DOSEL
           MOVE    SPACE               TO  SPA-GMN-DOSEL
           IF      WRK-DOSEL           =   SPACE
               STRING WRK-BANGO-X         DELIMITED   BY  SPACE
                      INTO                SPA-GMN-DOSEL
               END-STRING
           ELSE
               STRING  WRK-DOSEL           DELIMITED   BY  SPACE
                       ","                 DELIMITED   BY  SIZE
                       WRK-BANGO-X         DELIMITED   BY  SPACE
                      INTO                SPA-GMN-DOSEL
               END-STRING
           END-IF
      *
           .
       440-MEILIST-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    剤番号選択入力チェック処理
      *****************************************************************
       420-DOSEL-CHK-SEC              SECTION.
      *
           MOVE    2                   TO  SPA-K09GMN-CUR
           MOVE    K09-DOSEL           TO  SPA-GMN-DOSEL
      *
           INITIALIZE                      WRK-DOSEL
           MOVE    ZERO                TO  IDX-D1
           MOVE    1                   TO  IDX-D2
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   40  )   OR
                              (SPA-ERRCD   NOT =   SPACE )
               EVALUATE    SPA-GMN-DOSEL(IDX:1)
                   WHEN    ","
                   WHEN    "."
                       IF      IDX-D1          >   ZERO
                           ADD     1               TO  IDX-D2
                           MOVE    ZERO            TO  IDX-D1
                       END-IF
                   WHEN    "*"
                       ADD     1               TO  IDX-D1
                       IF     (IDX-D1          >   1   )  OR
                              (IDX-D2          >   1   )
                           MOVE    "0003"          TO  SPA-ERRCD
                       ELSE
                           MOVE    SPA-GMN-DOSEL(IDX:1)
                                               TO  WRK-DO(IDX-D2)
                                                            (IDX-D1:1)
                       END-IF
                   WHEN    "0"  THRU  "9" 
                       ADD     1               TO  IDX-D1
                       IF      IDX-D1          >   3
                           MOVE    "0002"          TO  SPA-ERRCD
                       ELSE
                           MOVE    SPA-GMN-DOSEL(IDX:1)
                                               TO  WRK-DO(IDX-D2)
                                                            (IDX-D1:1)
                       END-IF
                   WHEN    "-"
                       MOVE    "-"             TO  WRK-SEL(IDX-D2)
                       IF      IDX-D1          >   ZERO
                           ADD     1               TO  IDX-D2
                           MOVE    ZERO            TO  IDX-D1
                       END-IF
                   WHEN    SPACE
                       CONTINUE
                   WHEN    OTHER
                       MOVE    "0002"          TO  SPA-ERRCD
               END-EVALUATE
           END-PERFORM
      *    全件コピー
           IF     (IDX-D2              =   1  )  AND
                  (IDX-D1              =   1  )  AND
                  (WRK-DO(IDX-D2)(1:1) =   "*")
               MOVE    "1"                 TO  WRK-DO(IDX-D2)
               MOVE    "-"                 TO  WRK-SEL(IDX-D2)
               MOVE    SPA-NAI-MAX2(2:3)   TO  WRK-DO(IDX-D2 + 1)
           END-IF
      *
           PERFORM VARYING     IDX-D2      FROM    1   BY  1
                   UNTIL      (IDX-D2      >   100  )  OR
                              (WRK-DO(IDX-D2)  =   SPACE  )  OR
                              (SPA-ERRCD   NOT =   SPACE  )
               INITIALIZE                      ORCSNUMAREA
               MOVE    WRK-DO (IDX-D2)     TO  SNUM-INX
               CALL    "ORCSNUM"           USING
                                           ORCSNUMAREA
               IF     (SNUM-RC         NOT =   ZERO  )   OR
                      (SNUM-MINKBN     NOT =   SPACE )   OR
                      (SNUM-SYOKBN     NOT =   SPACE )
                   MOVE    "0002"              TO  SPA-ERRCD
               ELSE
                   MOVE    SNUM-OUTNUM         TO  WRK-DONUM (IDX-D2)
                   IF      WRK-DONUM (IDX-D2)  >=  01  AND
                                               <=  SPA-NAI-MAX2
                       CONTINUE
                   ELSE
                       MOVE    "0002"          TO  SPA-ERRCD
                   END-IF
      *
                   IF     (IDX-D2          >   1   )  AND
                          (WRK-SEL (IDX-D2 - 1 )   =   "-" )
                       IF      WRK-DONUM (IDX-D2 - 1)  >
                                                   WRK-DONUM(IDX-D2)
                           MOVE    "0002"              TO  SPA-ERRCD
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      420-DOSEL-CHK-EXT
           END-IF
      *
      *
           INITIALIZE                      WRK-DOZAINUM-AREA
           MOVE    ZERO                TO  IDX
           PERFORM VARYING     IDX-D2      FROM    1   BY  1
                   UNTIL      (IDX-D2      >   100  )  OR
                              (WRK-DO(IDX-D2)  =   SPACE  )
               IF     (IDX-D2                  >   1   )  AND
                      (WRK-SEL  (IDX-D2 - 1)   =   "-" )
                   COMPUTE IDX-Z           =   WRK-DONUM (IDX-D2 - 1)
                                           +   1
                   PERFORM VARYING     IDX2    FROM    IDX-Z  BY  1
                           UNTIL       IDX2    >=  WRK-DONUM(IDX-D2)
                       MOVE    IDX2                TO  IDX-ZAI
                       ADD     1                   TO  IDX
                       MOVE    SPA-NAI-ZAINUM (IDX-ZAI)
                                               TO  WRK-DOZAINUM (IDX)
                   END-PERFORM
               END-IF
               MOVE    WRK-DONUM(IDX-D2)       TO  IDX-ZAI
               ADD     1                       TO  IDX
               MOVE    SPA-NAI-ZAINUM (IDX-ZAI)
                                               TO  WRK-DOZAINUM (IDX)
           END-PERFORM
      *
      *    同一剤を削除
           INITIALIZE                      HZN-DOZAINUM-AREA
           MOVE    WRK-DOZAINUM-AREA   TO  HZN-DOZAINUM-AREA
           INITIALIZE                      WRK-DOZAINUM-AREA
           MOVE    ZERO                TO  IDX-H
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL       IDX1    >   IDX
               IF      HZN-DOZAINUM (IDX1) NOT =   ZERO
                   MOVE    ZERO                TO  FLG-CHK
                   PERFORM VARYING     IDX2    FROM    1   BY  1
                           UNTIL  (IDX2        >   100)    OR
                                  (WRK-DOZAINUM (IDX2) =   ZERO ) OR
                                  (FLG-CHK             =   1    )
                       IF       HZN-DOZAINUM (IDX1)    =   WRK-DOZAINUM
                                                                (IDX2)
                           MOVE    1                   TO  FLG-CHK
                       END-IF
                   END-PERFORM
                   IF      FLG-CHK             =   ZERO
                       ADD     1               TO  IDX-H
                       MOVE    HZN-DOZAINUM (IDX1) TO  WRK-DOZAINUM
                                                                (IDX-H)
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      IDX-H               =   ZERO
               CONTINUE
           ELSE
      *        対象診療行為内容編集
               PERFORM 4201-WKSRYACT-SET-SEC
      *        戻る
               PERFORM 210-BACK
           END-IF
      *
           .
       420-DOSEL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *     診察内容編集処理
      *****************************************************************
       4101-JYURRK-HEN-SEC              SECTION.
      *
      *    パラメタファイルより、診療会計マスターを編集
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDG
      *
           INITIALIZE                  SPA-GMN-DOSEL
           MOVE    SPACE               TO  SPA-GMN-TBL
           INITIALIZE                  SPA-GMN-TBL
           INITIALIZE                  SPA-NAI-TBL
           MOVE    ZERO                TO  SPA-GMN-MAX2
           MOVE    ZERO                TO  SPA-NAI-MAX2
      *
      *    受診歴を検索する
           INITIALIZE                  JYURRK-KEY
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-SRYKA           TO  JYURRK-SRYKA
           MOVE    SPA-NAI-RRKYMD(SPA-NAI-DOSELNUM)
                                       TO  JYURRK-SRYYMD
           MOVE    SPA-NAI-RENNUM(SPA-NAI-DOSELNUM)
                                       TO  JYURRK-RENNUM
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY5"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY5"           TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           PERFORM
                   UNTIL    FLG-JYURRK     =   1
               IF      SPA-NAI-DOUJI-RENNUM (SPA-NAI-DOSELNUM)
                                           =   JYURRK-DOUJI-RENNUM
      *
                   PERFORM VARYING     IDX-R   FROM    1   BY  1
                           UNTIL      (IDG             >   400 )  OR
                                      (IDX-R           >   15  )
                       IF      JYURRK-ZAINUM (IDX-R)   NOT =   ZERO
                           PERFORM 41011-ZAISET-HEN-SEC
                       END-IF
                   END-PERFORM
               END-IF
      *
               MOVE    "JYURRK-KEY5"           TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "JYURRK-KEY5"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    最大件数
           MOVE    IDG                 TO  SPA-GMN-MAX2
      *
          .
       4101-JYURRK-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為検索処理
      *****************************************************************
       41011-ZAISET-HEN-SEC           SECTION.
      *     ワーク診療行為のレイアウトへ編集後、画面用編集へ
           MOVE    SPACE               TO  LNK-WKSRYACT-AREA
           MOVE    ZERO                TO  IDX-KOUI
           MOVE    ZERO                TO  IDX-KAI
      *    対象日の位置セット
           MOVE    JYURRK-SRYYMD(7:2)  TO  IDX-STR
           MOVE    IDX-STR             TO  SPA-SEL-IDX
           MOVE    JYURRK-RENNUM       TO  SPA-SEL-RENNUM
      *
           INITIALIZE                  SRYACT-REC
           MOVE    SPA-HOSPID          TO  SRY-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SRY-NYUGAIKBN
           MOVE    SPA-PTID            TO  SRY-PTID
           MOVE    SPA-SRYKA           TO  SRY-SRYKA
           MOVE    JYURRK-SRYYMD(1:6)  TO  SRY-SRYYM
           MOVE    JYURRK-ZAINUM(IDX-R)
                                       TO  SRY-ZAINUM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY2"         TO  ORC-DBPATH
               PERFORM 930-SRYACT-READ-SEC
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           MOVE    ZERO                TO  WRK-ZAINUM
           PERFORM
                   UNTIL   FLG-SRYACT      =   1
      *
      *        初再診を対象外とする
               IF      SRY-SRYKBN          =   "11"  OR  "12"
                   CONTINUE
               ELSE
      *            診療会計検索編集
                   PERFORM 41012-SRYACT-HEN-SEC
      *
      *
                   IF      IDY                 >   ZERO
                       ADD     1               TO  IDX-KOUI
                       MOVE    WKSRYACT-REC    TO  LNK-WKSRYACT-REC
                                                          (IDX-KOUI)
                   END-IF
               END-IF
      *
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 930-SRYACT-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      IDX-KOUI        >   ZERO
      *        剤毎に処理を行う
               ADD     1               TO  SPA-NAI-MAX2
               MOVE    JYURRK-ZAINUM(IDX-R)    TO  SPA-NAI-ZAINUM
                                                        (SPA-NAI-MAX2)
               PERFORM 3101-WKSRYACT-HEN-SEC
           END-IF
      *
           .
       490111-ZAISET-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタを作成する 
      *****************************************************************
       41012-SRYACT-HEN-SEC           SECTION.
      *
           MOVE    ZERO                TO  IDY
           MOVE    ZERO                TO  WRK-ZAIKAISU
      *    剤回数取得
           INITIALIZE                      SRYACCT-REC
           MOVE    SRY-HOSPID          TO  ACCT-HOSPID
           MOVE    SRY-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    SRY-PTID            TO  ACCT-PTID
           MOVE    SRY-SRYKA           TO  ACCT-SRYKA
           MOVE    SRY-SRYYM           TO  ACCT-SRYYM
           MOVE    SRY-SRYKBN          TO  ACCT-SRYKBN
           MOVE    SRY-ZAINUM          TO  ACCT-ZAINUM
      *    主キー読み
           PERFORM 940-SRYACCT-READ-SEC
           IF      FLG-SRYACCT         =   ZERO
      *    回数決定
      *        同日再診の最終回セット
               EVALUATE    SPA-SEL-RENNUM
                   WHEN    1
                       MOVE    ACCT-DAY (2 IDX-STR)    TO  WRK-ZAIKAISU
                   WHEN    2
                       MOVE    ACCT-DAY (3 IDX-STR)    TO  WRK-ZAIKAISU
                   WHEN    OTHER
                       MOVE    ACCT-DAY (4 IDX-STR)    TO  WRK-ZAIKAISU
               END-EVALUATE
           END-IF
      *
           INITIALIZE                  WKSRYACT-REC
      *
      *    回数ゼロは対象外とする
           IF      WRK-ZAIKAISU        =   ZERO
               GO      TO      41012-SRYACT-HEN-EXT
           END-IF
      *
      **** IF      WRK-ZAINUM      NOT =   SRY-ZAINUM
      *        MOVE    ZERO                TO  IDX-KAI
      **** END-IF
      *
           INITIALIZE                  WKSRYACT-REC
           MOVE    SRY-HOSPID          TO  WKSRY-HOSPID
           MOVE    SRY-NYUGAIKBN       TO  WKSRY-NYUGAIKBN
           MOVE    SRY-PTID            TO  WKSRY-PTID
           MOVE    SRY-SRYKA           TO  WKSRY-SRYKA
           MOVE    SRY-SRYYM           TO  WKSRY-SRYYMD(1:6)
           MOVE    SRY-SRYKBN          TO  WKSRY-SRYKBN
           MOVE    SRY-ZAINUM          TO  WKSRY-ZAINUM
           MOVE    SRY-RENNUM          TO  WKSRY-RENNUM
           MOVE    SRY-SRYSYUKBN       TO  WKSRY-SRYSYUKBN
           MOVE    SRY-JIHIMONEYTOTAL  TO  WKSRY-JIHIMONEYTOTAL
      *剤回数計
           MOVE    WRK-ZAIKAISU        TO  WKSRY-ZAIKAIKEI
      *    剤点数計
           MOVE    ACCT-ZAITEN         TO  WKSRY-ZAITENKEI
      *保険組合
           MOVE    ACCT-HKNCOMBI       TO  WKSRY-HKNCOMBI
      *
           MOVE    ZERO                TO  IDX-W
           MOVE    ZERO                TO  IDY
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX         >   5   )   OR
                              (SRY-SRYCD (IDX)     =   SPACE )
      *        登録時の自動算定分は対象外
               IF      SRY-AUTOKBN (IDX)   =   "3"
                   CONTINUE
               ELSE
                   ADD     1                   TO  IDY
                   MOVE    SRY-SRYCD (IDX)     TO  WKSRY-SRYCD    (IDY)
                   MOVE    SRY-SRYSURYO (IDX)  TO  WKSRY-SRYSURYO (IDY)
                   MOVE    SRY-SRYKAISU (IDX)  TO  WKSRY-SRYKAISU (IDY)
                   MOVE    SRY-AUTOKBN  (IDX)  TO  WKSRY-AUTOKBN  (IDY)
                   MOVE    SRY-INPUTNUM (IDX)  TO  WKSRY-INPUTNUM (IDY)
                   MOVE    SRY-JIHIMONEY(IDX)  TO  WKSRY-JIHIMONEY(IDY)
                   IF      SRY-INPUTNUM (IDX)  NOT =   ZERO
                       PERFORM 490111-PTCOM-SET-SEC
                   END-IF
                   MOVE    IDY                 TO  IDX-W
               END-IF
               ADD     1                   TO  IDX-KAI
           END-PERFORM
      *
           IF     (ACCT-MEISAISU       =   IDX-KAI )  AND
                  (IDX-W               >   ZERO    )
               MOVE    WRK-ZAIKAISU        TO  WKSRY-ZAIKAISU (IDX-W)
           END-IF
      *
           .
       41012-SRYACT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    患者コメントから編集する 
      *****************************************************************
       490111-PTCOM-SET-SEC              SECTION.
      *
           MOVE    SRY-HOSPID          TO  PTCOM-HOSPID
           MOVE    SRY-PTID            TO  PTCOM-PTID
           MOVE    SRY-ZAINUM          TO  PTCOM-ZAINUM
           MOVE    SRY-SRYCD (IDX)     TO  PTCOM-SRYCD
           MOVE    SRY-INPUTNUM(IDX)   TO  PTCOM-RENNUM
      *主キーで検索
           PERFORM 950-PTCOM-READ-SEC
           IF      FLG-PTCOM           =   ZERO
               MOVE    PTCOM-INPUTCOMENT   TO  WKSRY-INPUTCOMENT (IDY)
               MOVE    PTCOM-INPUTCHI (1)  TO  WKSRY-INPUTCHI (IDY 1)
               MOVE    PTCOM-INPUTCHI (2)  TO  WKSRY-INPUTCHI (IDY 2)
               MOVE    PTCOM-INPUTCHI (3)  TO  WKSRY-INPUTCHI (IDY 3)
               MOVE    PTCOM-INPUTCHI (4)  TO  WKSRY-INPUTCHI (IDY 4)
           END-IF
           .
       490111-PTCOM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *     診療行為内容編集処理
      *****************************************************************
       3101-WKSRYACT-HEN-SEC              SECTION.
      *
      *    診療コード計計算
           MOVE    ZERO                TO  IDZ
           MOVE    ZERO                TO  FLG-YAKUSOKU
           MOVE    ZERO                TO  WRK-MEISAISU
           MOVE    ZERO                TO  WRK-ZAITEN
           MOVE    ZERO                TO  WRK-SRYKAISUKEI
           MOVE    ZERO                TO  WRK-JIHIMONEY
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   IDX-KOUI
      *
      *        剤点数計
               MOVE    LNK-WKSRY-ZAITENKEI(IDX)    TO  WRK-ZAITEN
      *        回数計
               MOVE    LNK-WKSRY-ZAIKAIKEI(IDX)    TO  WRK-SRYKAISUKEI
      **       自費
               IF      LNK-WKSRY-JIHIMONEYTOTAL (IDX)   NOT =   ZERO
                   MOVE    LNK-WKSRY-JIHIMONEYTOTAL (IDX)
                                                   TO  WRK-JIHIMONEY
               END-IF
      *
      *        剤内１行目
               IF      IDX                 =   1
                   ADD     1               TO  IDG
                   PERFORM 31011-GYO1-HEN-SEC
               END-IF
      *TEST
                  DISPLAY "IDZ:" IDZ
      *TEST
      *
      *        剤明細編集
               PERFORM VARYING     IDZ     FROM    1   BY  1
                       UNTIL      (IDZ         >   5   )  OR
                                  (IDG         >   400 )  OR
                                  (LNK-WKSRY-SRYCD (IDX IDZ) =  SPACE)
      *TEST
                  DISPLAY "IDZ:" IDZ
                           ",IDG:" IDG
                           ",IDX:" IDX
                           ",LNK-WKSRY-SRYCD:" LNK-WKSRY-SRYCD (IDX IDZ)
                           ",WRK-MEISAISU:" WRK-MEISAISU
      *TEST
                   ADD     1                   TO  WRK-MEISAISU
      *            自費の時、金額を表示
                   IF      LNK-WKSRY-SRYKBN (IDX)  =   "95"  OR
                                                       "96"
                       PERFORM 31013-JIHIMEI-HEN-SEC
                   ELSE
                       PERFORM 31012-ZAIMEI-HEN-SEC
                   END-IF
      *            約束セットの時
                   IF      LNK-WKSRY-SRYCD (IDX IDZ)(1:1)   =   "S"
                       MOVE    1                  TO  FLG-YAKUSOKU
                   END-IF
               END-PERFORM
           END-PERFORM
      *
      *    剤点数がゼロの時、自費を点数へ
      *    IF      WRK-ZAITEN          =   ZERO
      *        MOVE   WRK-JIHIMONEY        TO  WRK-ZAITEN
      *    END-IF
      *
      *    診療コードがない時、処理をしない
           IF      WRK-MEISAISU        =   ZERO
               COMPUTE IDZ             =   IDZ     -   1
               GO      TO      3101-WKSRYACT-HEN-EXT
           END-IF
      *
      *    自費の時、計を表示しない
           IF      WRK-JIHIMONEY       >   ZERO
               CONTINUE
           ELSE
      *
      *        剤　点数＊日数　計　編集 （最終行に追加）
               IF      SPA-GMN-HEN1 (IDG)      =   SPACE  OR  ALL "　"
                   CONTINUE
               ELSE
                   ADD    1                    TO  IDG
               END-IF
               PERFORM 31013-INPUTCD-HEN-SEC
               MOVE    WRK-ZAIKEIJ         TO  SPA-GMN-TZAIKEI (IDG)
      *
               INSPECT SPA-GMN-TMEISYO2(IDG)   REPLACING
                                               ALL "  "  BY  "　"
      *        INSPECT SPA-GMN-TYOBI   (IDG)   REPLACING
      *                                        ALL "  "  BY  "　"
               INSPECT SPA-GMN-TZAIKEI (IDG)   REPLACING
                                               ALL "  "  BY  "　"
           END-IF
      *
      *    剤終了編集
           ADD     1                   TO  IDG
           IF      IDG                 >   400
               GO      TO      3101-WKSRYACT-HEN-EXT
           END-IF
           MOVE    ALL "-"             TO  SPA-GMN-TMEISYO (IDG)
      *
            .
       3101-WKSRYACT-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   剤内１行目  編集処理
      *****************************************************************
       31011-GYO1-HEN-SEC                  SECTION.
      *
      *    診療種別区分名称、診療行為区分セット
           SET     MSYU-IDX            TO  1
           SEARCH      MSYU-TBL-OCC    VARYING   MSYU-IDX
                   AT   END
                       MOVE    SPACE       TO  WRK-SRYSYUMEI
                   WHEN    LNK-WKSRY-SRYSYUKBN (IDX) =   MSYU-SRYSYUKBN
                                                      (MSYU-IDX)
                       MOVE    MSYU-SRYMEI (MSYU-IDX)
                                                TO  WRK-SRYSYUMEI
           END-SEARCH
      *
      *    診療種別がない時、診療行為区分より
           IF      LNK-WKSRY-SRYSYUKBN (IDX)   =   SPACE
               SET     MSYU-IDX            TO  1
               SEARCH      MSYU-TBL-OCC    VARYING   MSYU-IDX
                   AT   END
                       MOVE    SPACE           TO  WRK-SRYSYUMEI
                   WHEN    LNK-WKSRY-SRYKBN(IDX)
                                           =   MSYU-SRYKBN(MSYU-IDX)
                       MOVE    MSYU-SRYMEI (MSYU-IDX)
                                               TO  WRK-SRYSYUMEI
               END-SEARCH
           END-IF
      *
           IF      LNK-WKSRY-SRYSYUKBN (IDX)   =   SPACE
               MOVE    SPACE           TO  SPA-GMN-TMEISYO (IDG)
               MOVE    WRK-SRYSYUMEI   TO  SPA-GMN-TMEISYO (IDG)(7:)
           ELSE
               MOVE    "."             TO  SPA-GMN-TMEISYO (IDG)(1:1)
               MOVE    LNK-WKSRY-SRYSYUKBN (IDX)
                                       TO  SPA-GMN-TMEISYO (IDG)(2:3)
               MOVE    WRK-SRYSYUMEI   TO  SPA-GMN-TMEISYO (IDG)(7:)
           END-IF
      *
           INSPECT SPA-GMN-TMEISYO  (IDG)   REPLACING
                                            ALL "  "  BY  "　"
           INSPECT SPA-GMN-TYOBI0   (IDG)   REPLACING
                                            ALL "  "  BY  "　"
      *
      *    番号
           MOVE    SPA-NAI-MAX2        TO  SPA-GMN-TBANGO    (IDG)
           MOVE    SPA-NAI-MAX2        TO  SPA-NAI-TBANGO    (IDG)
      *
           .
       31011-GYO1-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   剤内明細  編集処理
      *****************************************************************
       31012-ZAIMEI-HEN-SEC                  SECTION.
      *
           ADD     1                   TO  IDG
           IF      IDG                 >   400
               GO      TO      31012-ZAIMEI-HEN-EXT
           END-IF
           MOVE    SPA-NAI-MAX2        TO  SPA-NAI-TBANGO    (IDG)
      *
      *    約束セット編集
           IF      LNK-WKSRY-SRYCD (IDX IDZ)(1:1)   =   "S"
               PERFORM 310120-YAKUSOKU-SET-SEC
               GO      TO      31012-ZAIMEI-HEN-EXT
           END-IF
      *
      *    診療コードより診療行為名称を取得
           MOVE    LNK-WKSRY-SRYCD (IDX IDZ)   TO  TNS-SRYCD
           PERFORM 910-TENSU-READ-SEC
           IF      FLG-TENSU       NOT =   ZERO
               MOVE    LNK-WKSRY-SRYCD (IDX IDZ)   TO  TNS-NAME
           END-IF
      *    行為名称
           MOVE    TNS-NAME            TO  SPA-GMN-TMEISYO2(IDG)
      *    薬剤服用コメントの時、再編集
           IF      LNK-WKSRY-SRYCD (IDX IDZ)(1:3)  =   "001"
                PERFORM 3100121-FUKIYO-MEISYO-SEC
                MOVE    WRK-MEISYO    TO  SPA-GMN-TMEISYO2(IDG)
           END-IF
      *
      *    約束の内容の時、再編集
           IF      FLG-YAKUSOKU        =   1
               MOVE    SPA-GMN-TMEISYO2(IDG)   TO  WRK-MEISYO
               MOVE    SPACE               TO  SPA-GMN-TMEISYO2(IDG)
               STRING     "＞"             DELIMITED   BY  SIZE
                          WRK-MEISYO       DELIMITED   BY  SIZE
                          INTO             SPA-GMN-TMEISYO2(IDG)
               END-STRING
           END-IF
      *
      *    コメントの時、内容設定
           IF     (LNK-WKSRY-SRYCD   (IDX IDZ)(1:1)  =   "8"   )  AND
      *DDDDDDDDDD (LNK-WKSRY-INPUTNUM(IDX IDZ)    NOT =   ZERO OR
                  (LNK-WKSRY-INPUTCOMENT(IDX IDZ) NOT =  SPACE )
               MOVE    LNK-WKSRY-INPUTCOMENT(IDX IDZ)
                                           TO  SPA-GMN-TMEISYO2(IDG)
           END-IF
      *
      *    数量（薬剤、器材のとき）
           IF      LNK-WKSRY-SRYCD (IDX IDZ)(1:1)   =   "6"  OR  "7"
               MOVE    LNK-WKSRY-SRYSURYO (IDX IDZ)  TO  WRK-SURYO
               PERFORM 310121-SURYO-HEN-SEC
               MOVE    WRK-SURYO-J         TO  SPA-GMN-TSURYOU (IDG)
               MOVE    TNS-TANINAME        TO  SPA-GMN-TTANI1  (IDG)
           END-IF
      *    分画数
           IF     (LNK-WKSRY-SRYCD (IDX IDZ)(1:1)   =   "7"  )  AND
                  (TNS-DATAKBN             =   3    )  AND
                  (LNK-WKSRY-SRYKAISU (IDX IDZ)      >   ZERO )
               MOVE    LNK-WKSRY-SRYKAISU (IDX IDZ)
                                           TO  WRK-BUNGSU-Z
               PERFORM 310122-BUNGSU-HEN-SEC
               MOVE    WRK-BUNGSU-J        TO  SPA-GMN-TTANMEI (IDG)
               MOVE    "分画"              TO  SPA-GMN-TTANI2  (IDG)
           END-IF
      *
           INSPECT SPA-GMN-TMEISYO2(IDG) REPLACING  ALL "  "  BY  "　"
           INSPECT SPA-GMN-TSURYOU (IDG) REPLACING  ALL "  "  BY  "　"
           INSPECT SPA-GMN-TTANMEI (IDG) REPLACING  ALL "  "  BY  "　"
           INSPECT SPA-GMN-TTANI1  (IDG) REPLACING  ALL "  "  BY  "　"
           INSPECT SPA-GMN-TTANI2  (IDG) REPLACING  ALL "  "  BY  "　"
           INSPECT SPA-GMN-TYOBI1  (IDG) REPLACING  ALL "  "  BY  "　"
      *
      *    コメント以外の最終行セット
           IF      LNK-WKSRY-SRYCD (IDX IDZ)(1:1)   =   "0"  OR  "8"
               CONTINUE
           ELSE
               MOVE    IDG             TO  WRK-IDG
           END-IF
      *
           .
       31012-ZAIMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   剤内明細（自費）  編集処理
      *****************************************************************
       31013-JIHIMEI-HEN-SEC           SECTION.
      *
           ADD     1                   TO  IDG
           IF      IDG                 >   400
               GO      TO      31013-JIHIMEI-HEN-EXT
           END-IF
           MOVE    SPA-NAI-MAX2        TO  SPA-NAI-TBANGO    (IDG)
      *
      *    約束セット編集
           IF      LNK-WKSRY-SRYCD (IDX IDZ)(1:1)   =   "S"
               PERFORM 310120-YAKUSOKU-SET-SEC
               GO      TO      31013-JIHIMEI-HEN-EXT
           END-IF
      *
      *    診療コードより診療行為名称を取得
           MOVE    LNK-WKSRY-SRYCD (IDX IDZ)   TO  TNS-SRYCD
           PERFORM 910-TENSU-READ-SEC
           IF      FLG-TENSU       NOT =   ZERO
               MOVE    LNK-WKSRY-SRYCD (IDX IDZ)   TO  TNS-NAME
           END-IF
      *    行為名称
           MOVE    TNS-NAME            TO  SPA-GMN-TMEISYO2(IDG)
      *
      *    約束の内容の時、再編集
           IF      FLG-YAKUSOKU        =   1
               MOVE    SPA-GMN-TMEISYO2(IDG)   TO  WRK-MEISYO
               MOVE    SPACE               TO  SPA-GMN-TMEISYO2(IDG)
               STRING     "＞"             DELIMITED   BY  SIZE
                          WRK-MEISYO       DELIMITED   BY  SIZE
                          INTO             SPA-GMN-TMEISYO2(IDG)
               END-STRING
           END-IF
      *
      *    コメントの時、内容設定
           IF     (LNK-WKSRY-SRYCD   (IDX IDZ)(1:1)  =   "8"   )  AND
                  (LNK-WKSRY-INPUTCOMENT(IDX IDZ) NOT =  SPACE )
               MOVE    LNK-WKSRY-INPUTCOMENT(IDX IDZ)
                                           TO  SPA-GMN-TMEISYO2(IDG)
           END-IF
      *
      *    計
           MOVE    LNK-WKSRY-JIHIMONEY(IDX IDZ)
                                       TO  WRK-KEI
           MOVE    WRK-KEI                 TO  WRK-ZAIKEI
      *
      *    日本語変換
           MOVE    SPACE               TO  WRK-ZAIKEIJ
           MOVE    1                   TO  IDJ2
           PERFORM VARYING     IDJ     FROM    1  BY  1
                   UNTIL       IDJ     >   40
              EVALUATE     WRK-ZAIKEI (IDJ:1)
                   WHEN    SPACE
                       MOVE    "　"            TO  WRK-ZAIKEIJ (IDJ2:2)
                       ADD     2               TO  IDJ2
                   WHEN    "X"
                       MOVE    "×"            TO  WRK-ZAIKEIJ (IDJ2:2)
                       ADD     2               TO  IDJ2
                   WHEN    "1"  THRU  "9"
                       MOVE    WRK-ZAIKEI (IDJ:1)  TO  IDJ1
                       MOVE    TBL-SUJI (IDJ1)     TO  WRK-ZAIKEIJ
                                                              (IDJ2:2)
                       ADD     2                   TO  IDJ2
                   WHEN    "0"
                       MOVE    TBL-SUJI (10)       TO  WRK-ZAIKEIJ
                                                              (IDJ2:2)
                       ADD     2                   TO  IDJ2
               END-EVALUATE
           END-PERFORM
      *
           IF      LNK-WKSRY-JIHIMONEY(IDX IDZ)    =   ZERO
               MOVE    SPACE               TO  SPA-GMN-TZAIKEI (IDG)
           ELSE
               MOVE    "円"                TO  WRK-ZAIKEIJ(21:2)
               MOVE    WRK-ZAIKEIJ         TO  SPA-GMN-TZAIKEI (IDG)
           END-IF
      *
           INSPECT SPA-GMN-TMEISYO2(IDG) REPLACING  ALL "  "  BY  "　"
      **** INSPECT SPA-GMN-TYOBI   (IDG) REPLACING  ALL "  "  BY  "　"
           INSPECT SPA-GMN-TZAIKEI (IDG) REPLACING  ALL "  "  BY  "　"
      *
      *    コメント以外の最終行セット
           IF      LNK-WKSRY-SRYCD (IDX IDZ)(1:1)   =   "0"  OR  "8"
               CONTINUE
           ELSE
               MOVE    IDG             TO  WRK-IDG
           END-IF
      *
           .
       31013-JIHIMEI-HEN-EXT.
           EXIT.
      *****************************************************************
      *     約束セットの時、再編集処理
      *****************************************************************
       310120-YAKUSOKU-SET-SEC        SECTION.
      *
           MOVE    SPACE               TO  INPUTCD-REC
           MOVE    SPA-HOSPID          TO  ICD-HOSPID
      *    セットの桁数は６とする
           MOVE    "6"                 TO  ICD-CDSYU
           MOVE    LNK-WKSRY-SRYCD (IDX IDZ)(1:6)
                                       TO  ICD-INPUTCD
      *
           PERFORM 930-INPUTCD-READ-SEC
      *
           IF      FLG-INPUTCD         =   ZERO
               MOVE    ICD-DSPNAME         TO  SPA-GMN-TMEISYO2(IDG)
           ELSE
               MOVE    LNK-WKSRY-SRYCD (IDX IDZ)
                                           TO  SPA-GMN-TMEISYO2(IDG)
           END-IF
      *
      *    数量（薬剤、器材のとき）
           MOVE    LNK-WKSRY-SRYSURYO (IDX IDZ)  TO  WRK-SURYO
           PERFORM 310121-SURYO-HEN-SEC
           MOVE    WRK-SURYO-J         TO  SPA-GMN-TSURYOU (IDG)
      *
           .
       310120-YAKUSOKU-SET-EXT.
           EXIT.
      *****************************************************************
      *     薬剤服用コメントの時、再編集処理
      *****************************************************************
       3100121-FUKIYO-MEISYO-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-MEISYO
      *
           STRING     "【"             DELIMITED   BY  SIZE
                      TNS-NAME         DELIMITED   BY  "    "
                      "】"             DELIMITED   BY  SIZE
                      INTO             WRK-MEISYO
           END-STRING
           .
       3100121-FUKIYO-MEISYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    数量表示用編集処理
      *****************************************************************
       310121-SURYO-HEN-SEC            SECTION.
      *
           MOVE    SPACE               TO  WRK-SURYO-X
           MOVE    WRK-SURYO-S1        TO  WRK-SURYO-Z1
      *
           MOVE    ZERO                TO  FLG-SP
           PERFORM VARYING     IDM     FROM    3  BY  -1
                   UNTIL       IDM     <   1
               IF      WRK-SURYO-S2(IDM:1) NOT =   ZERO
                   MOVE    1               TO  FLG-SP
               END-IF
               IF      FLG-SP          =   1
                   MOVE    WRK-SURYO-S2(IDM:1) TO  WRK-SURYO-Z3(IDM:1)
               END-IF
           END-PERFORM
      *
           IF      WRK-SURYO-Z3        NOT =   SPACE
               MOVE    "."                 TO  WRK-SURYO-Z2
               MOVE    WRK-SURYO-S1        TO  WRK-SURYO-Z1-9
           END-IF
      *
      *    日本語変換
           MOVE    SPACE               TO  WRK-SURYO-J
           MOVE    1                   TO  IDJ2
           PERFORM VARYING     IDJ     FROM    1  BY  1
                   UNTIL       IDJ     >   9
              EVALUATE     WRK-SURYO-X (IDJ:1)
                   WHEN    SPACE
                       MOVE    "　"            TO  WRK-SURYO-J (IDJ2:2)
                       ADD     2               TO  IDJ2
                   WHEN    "."
                       MOVE    "．"            TO  WRK-SURYO-J (IDJ2:2)
                       ADD     2               TO  IDJ2
                   WHEN    "1"  THRU  "9"
                       MOVE    WRK-SURYO-X (IDJ:1) TO  IDJ1
                       MOVE    TBL-SUJI (IDJ1)     TO  WRK-SURYO-J
                                                            (IDJ2:2)
                       ADD     2                   TO  IDJ2
                   WHEN    "0"
                       MOVE    TBL-SUJI (10)       TO  WRK-SURYO-J
                                                          (IDJ2:2)
                       ADD     2                   TO  IDJ2
               END-EVALUATE
           END-PERFORM
           .
       310121-SURYO-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    数量表示用編集処理
      *****************************************************************
       310122-BUNGSU-HEN-SEC           SECTION.
      *
      *    日本語変換
           MOVE    SPACE               TO  WRK-BUNGSU-J
           MOVE    1                   TO  IDJ2
           PERFORM VARYING     IDJ     FROM    1  BY  1
                   UNTIL       IDJ     >   3
              EVALUATE     WRK-BUNGSU-X (IDJ:1)
                   WHEN    SPACE
                       MOVE    "　"            TO  WRK-BUNGSU-J(IDJ2:2)
                       ADD     2               TO  IDJ2
                   WHEN    "."
                       MOVE    "．"            TO  WRK-BUNGSU-J(IDJ2:2)
                       ADD     2               TO  IDJ2
                   WHEN    "1"  THRU  "9"
                       MOVE    WRK-BUNGSU-X (IDJ:1)    TO  IDJ1
                       MOVE    TBL-SUJI (IDJ1)     TO  WRK-BUNGSU-J
                                                               (IDJ2:2)
                       ADD     2                   TO  IDJ2
                   WHEN    "0"
                       MOVE    TBL-SUJI (10)       TO  WRK-BUNGSU-J
                                                               (IDJ2:2)
                       ADD     2                   TO  IDJ2
               END-EVALUATE
           END-PERFORM
           .
       310122-BUNSU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   入力コードの画面用再編集処理
      *****************************************************************
       31013-INPUTCD-HEN-SEC                  SECTION.
      *
      *    点数＊回数　計
      *    点数
           MOVE    WRK-ZAITEN          TO  WRK-TENSU
      *
           IF      WRK-SRYKAISUKEI     =   ZERO
               MOVE   1                    TO  WRK-SRYKAISUKEI
           END-IF
           COMPUTE WRK-KEI-G           =   WRK-ZAITEN
                                       *   WRK-SRYKAISUKEI
           MOVE    WRK-KEI-G           TO  WRK-KEI
      *    回数
           MOVE    WRK-SRYKAISUKEI     TO  WRK-KAISU
           MOVE    ZERO                TO  IDK2
           MOVE    SPACE               TO  WRK-ZAIKEI 
           MOVE    SPACE               TO  WRK-KAISU-H 
           MOVE    SPACE               TO  WRK-KEI-H 
           PERFORM VARYING     IDK1    FROM    1   BY  1
                   UNTIL       IDK1    >   8
               IF      WRK-KAISU-X (IDK1:1)    NOT =   SPACE
                   ADD     1           TO  IDK2
                   MOVE    WRK-KAISU-X (IDK1:1)
                                       TO  WRK-KAISU-H (IDK2:1)
               END-IF
           END-PERFORM
      *    計
           MOVE    ZERO                TO  IDK2
           PERFORM VARYING     IDK1    FROM    1   BY  1
                   UNTIL       IDK1    >   8
               IF      WRK-KEI-X   (IDK1:1)    NOT =   SPACE
                   ADD     1           TO  IDK2
                   MOVE    WRK-KEI-X   (IDK1:1)
                                       TO  WRK-KEI-H   (IDK2:1)
               END-IF
           END-PERFORM
      *
           STRING  WRK-TENSU               DELIMITED   BY  SIZE
                   "X"                     DELIMITED   BY  SIZE
                   WRK-KAISU-H             DELIMITED   BY  SPACE
      *DDDDDD      "  "                    DELIMITED   BY  SIZE
      *DDDDDD      WRK-KEI-H               DELIMITED   BY  SPACE
                   INTO                    WRK-ZAIKEI
           END-STRING
      *
      *    日本語変換
           MOVE    SPACE               TO  WRK-ZAIKEIJ
           MOVE    1                   TO  IDJ2
           PERFORM VARYING     IDJ     FROM    1  BY  1
                   UNTIL       IDJ     >   40
              EVALUATE     WRK-ZAIKEI (IDJ:1)
                   WHEN    SPACE
                       MOVE    "　"            TO  WRK-ZAIKEIJ (IDJ2:2)
                       ADD     2               TO  IDJ2
                   WHEN    "X"
                       MOVE    "×"            TO  WRK-ZAIKEIJ (IDJ2:2)
                       ADD     2               TO  IDJ2
                   WHEN    "1"  THRU  "9"
                       MOVE    WRK-ZAIKEI (IDJ:1)  TO  IDJ1
                       MOVE    TBL-SUJI (IDJ1)     TO  WRK-ZAIKEIJ
                                                               (IDJ2:2)
                       ADD     2                   TO  IDJ2
                   WHEN    "0"
                       MOVE    TBL-SUJI (10)       TO  WRK-ZAIKEIJ
                                                               (IDJ2:2)
                       ADD     2                   TO  IDJ2
               END-EVALUATE
           END-PERFORM
      *
      *
           .
       31013-INPUTCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象診療行為内容編集処理
      *****************************************************************
       4201-WKSRYACT-SET-SEC             SECTION.
      *
      *    パラメタ削除
      *     OPEN    I-O                 PARA-FILE
      *    IF      STS-PARA        NOT =   ZERO
      *        MOVE    2                   TO  FLG-PARA
      *    ELSE
      *        MOVE    ZERO                TO  FLG-PARA
      *    END-IF
      *    PERFORM
      *            UNTIL   FLG-PARA    NOT =   ZERO
      *        INITIALIZE                      PARA-REC
      *        MOVE    SPA-TERMID          TO  PARA-TERMID
      *        MOVE    "WKSRYACT"          TO  PARA-FILEMEI
      *        START   PARA-FILE
      *            KEY IS    >=   PARA-KEY
      *            INVALID
      *                MOVE    1               TO  FLG-PARA
      *            NOT INVALID
      *                PERFORM 990-PARA-NEXT-SEC
      *        END-START
      *        IF      (FLG-PARA            =   ZERO       )  AND
      *                (PARA-TERMID         =   SPA-TERMID )  AND
      *                (PARA-FILEMEI        =   "WKSRYACT" )
      *            DELETE                   PARA-FILE    RECORD
      *        ELSE
      *            MOVE    1                TO  FLG-PARA
      *        END-IF
      *    END-PERFORM
      *    CLOSE                       PARA-FILE
      *
      *****OPEN    I-O                 PARA-FILE
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID2
           OPEN    OUTPUT              PARA-FILE
      *
           MOVE    ZERO                TO  WRK-EDANUM
      *
           PERFORM VARYING     IDX-R   FROM    1   BY  1
                   UNTIL      (IDX-R           >   100  )  OR
                              (WRK-DOZAINUM (IDX-R)    =   ZERO  )
               PERFORM 42011-PARA-HEN-SEC
           END-PERFORM
      *
           MOVE    1                   TO  SPA-K09-SELOK
      *
           CLOSE                       PARA-FILE
      *
           .
       4201-WKSRYACT-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為作成処理
      *****************************************************************
       42011-PARA-HEN-SEC           SECTION.
      *
      *     ワーク診療行為のレイアウトへ編集後、画面用編集へ
           MOVE    SPACE               TO  LNK-WKSRYACT-AREA
           MOVE    ZERO                TO  IDX-KOUI
           MOVE    ZERO                TO  IDX-KAI
      *    対象日
           MOVE    SPA-SEL-IDX         TO  IDX-STR
      *
           INITIALIZE                  SRYACT-REC
           MOVE    SPA-HOSPID          TO  SRY-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SRY-NYUGAIKBN
           MOVE    SPA-PTID            TO  SRY-PTID
           MOVE    SPA-SRYKA           TO  SRY-SRYKA
           MOVE    SPA-NAI-RRKYMD(SPA-NAI-DOSELNUM)(1:6)
                                       TO  SRY-SRYYM
           MOVE    WRK-DOZAINUM (IDX-R)
                                       TO  SRY-ZAINUM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY2"         TO  ORC-DBPATH
               PERFORM 930-SRYACT-READ-SEC
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           MOVE    ZERO                TO  WRK-ZAINUM
           PERFORM
                   UNTIL   FLG-SRYACT      =   1
      *
      *        初再診を対象外とする
               IF      SRY-SRYKBN          =   "11"  OR  "12"
                   CONTINUE
               ELSE
      *            診療会計検索編集
                   PERFORM 41012-SRYACT-HEN-SEC
      *
      *            パラメタファイル作成
      ***********  MOVE    SRY-ZAINUM          TO  WRK-ZAINUM
                   MOVE    SPACE               TO  PARA-REC
      *************MOVE    SPA-TERMID          TO  PARA-TERMID
                   MOVE    "WKSRYACT"          TO  PARA-FILEMEI
                   ADD     1                   TO  WRK-EDANUM
                   MOVE    WRK-EDANUM          TO  PARA-EDANUM
                   MOVE    WKSRYACT-REC        TO  PARA-DATA-REC
      *
                   WRITE                       PARA-REC
               END-IF
      *
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 930-SRYACT-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       42011-PARA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴処理へ
      *****************************************************************
       450-RIREKI-SEC            SECTION.
      *
      *    初期画面セット
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-K01KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-K02             TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGK07"           USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-K02
           MOVE    SPA-WORK        TO  SPA-K01KYOUTU
      *
           MOVE    "K07"               TO  SPA-SAKIPG
           MOVE    "K09"               TO  SPA-MOTOPG
      *
           MOVE    SPA-K01KYOUTU       TO  SPA-WORK
      *
           MOVE    SPACE               TO  LINKAREA
      *
      *****MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "K07"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       450-RIREKI-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI-DOSELNUM
           MOVE    SPACE               TO  SPA-GMN-DOSELNUM
      *
           MOVE    SPA-HZN-MOTOPG      TO  SPA-SAKIPG
           MOVE    "K09"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPA-K01KYOUTU       TO  SPA-WORK
      *
      *****MOVE    "BACK"              TO  MCP-PUTTYPE
      ** **MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    "JOIN"              TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       210-BACK-EXT.
           EXIT.
      *****************************************************************
      *    確定　処理
      *****************************************************************
       450-TOROKU-SEC             SECTION.
      *
           PERFORM 420-DOSEL-CHK-SEC
      *
           IF      IDX-H               =   ZERO
      *        戻る
               PERFORM 210-BACK
           END-IF
      *
      *    MOVE    SPA-HZN-MOTOPG      TO  SPA-SAKIPG
      *    MOVE    "K09"               TO  SPA-MOTOPG
      *
      *    MOVE    SPACE               TO  LINKAREA
      *
      *    MOVE    SPA-K01KYOUTU       TO  SPA-WORK
      *
      *    MOVE    "CHANGE"            TO  MCP-PUTTYPE
      *    MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
      *    PERFORM 900-PUT-WINDOW
      *
      *    MOVE    1                   TO  FLG-END
           .
       450-TOROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦和暦編集処理
      *****************************************************************
       520-SEIWA-HEN-SEC             SECTION.
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
           .
       520-SEIWA-HEN-EXT.
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
           MOVE    "K09"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  K09
      *
           PERFORM   VARYING   IDX     FROM    1   BY  1
                     UNTIL     IDX         >   SPA-GMN-MAX1
               MOVE    SPA-GMN-NO     (IDX)    TO  WRK-ZZ
               MOVE    WRK-ZZ                  TO  K09-NO  (IDX)
               MOVE    SPA-GMN-RRKYMD (IDX)    TO  K09-RRKYMD(IDX)
               IF      SPA-GMN-NO (IDX)    =   SPA-NAI-DOSELNUM
                   MOVE    "T"             TO  K09-RRKLIST-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  K09-RRKLIST-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-MAX1        TO  K09-RRKLIST-COUNT
      *
           PERFORM   VARYING   IDX     FROM    1   BY  1
                     UNTIL     IDX         >   SPA-GMN-MAX2
               IF      SPA-GMN-TMEISYO(IDX)(1:1)   =   "-"
                   MOVE    ALL "-"             TO  K09-MNO (IDX)
               ELSE
                   IF      SPA-GMN-TBANGO (IDX)    NOT =   ZERO
                       MOVE    SPA-GMN-TBANGO (IDX)    TO  WRK-ZZ
                       MOVE    WRK-ZZ                  TO  K09-MNO (IDX)
                   END-IF
               END-IF
               MOVE    SPA-GMN-TMEISYO (IDX)   TO  K09-MEISAI (IDX)
           END-PERFORM
           MOVE    SPA-GMN-MAX2        TO  K09-MEILIST-COUNT
      *
      *
           MOVE    SPA-GMN-DOSELNUM    TO  K09-SELNUM
           MOVE    SPA-GMN-DOSEL       TO  K09-DOSEL
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
           EVALUATE    SPA-K09GMN-CUR
               WHEN    01
                   MOVE    "SELNUM"          TO  MCP-WIDGET
               WHEN    02
                   MOVE    "DOSEL"           TO  MCP-WIDGET
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
                   MOVE    "診療日選択入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "番号選択入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "＊は１文字だけです"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  KERR
           MOVE    SPA-ERRCD           TO  KERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  KERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "K09"               TO  SPA-MOTOPG
           MOVE    "KERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "KERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  TNS-YUKOSTYMD
           MOVE    ALL "9"             TO  TNS-YUKOEDYMD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
      *****MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           MOVE    SPA-NAI-RRKYMD(SPA-NAI-DOSELNUM)
                                       TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
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
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター読込
      *****************************************************************
       930-SRYACT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       930-SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスター読込（主キー）
      *****************************************************************
       940-SRYACCT-READ-SEC           SECTION.
      *
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SRYACCT-REC
                   MOVE    ZERO                TO  FLG-SRYACCT
               ELSE
                   MOVE    1                   TO  FLG-SRYACCT
                   INITIALIZE                  SRYACCT-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
               INITIALIZE                  SRYACCT-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       940-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者コメントマスタ読み込み
      *****************************************************************
       950-PTCOM-READ-SEC           SECTION.
      *
      *
           MOVE    PTCOM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTCOM-REC
                   MOVE    ZERO                TO  FLG-PTCOM
               ELSE
                   MOVE    1                   TO  FLG-PTCOM
                   INITIALIZE                  PTCOM-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTCOM
               INITIALIZE                  PTCOM-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       950-PTCOM-READ-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴マスター読込
      *****************************************************************
       970-JYURRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       970-JYURRK-READ-EXT.
           EXIT.
      *****************************************************************
      *    パラメタデータ順読み
      *****************************************************************
       980-PARA-READ-SEC         SECTION.
      *
           READ    PARA-FILE 
               AT  END
                   MOVE    1           TO  FLG-PARA
               NOT AT  END
                   MOVE    ZERO        TO  FLG-PARA
           END-READ
      *
           .
       980-PARA-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタデータ順読み
      *****************************************************************
      *990-PARA-NEXT-SEC           SECTION.
      *
      *    READ    PARA-FILE       NEXT
      *        AT  END
      *            MOVE    1           TO  FLG-PARA
      *        NOT AT  END
      *            MOVE    ZERO        TO  FLG-PARA
      *    END-READ
      *
      *    .
      *990-PARA-NEXT-EXT.
      *    EXIT.
      *
      *****************************************************************
      *    入力コードマスター読込
      *****************************************************************
       930-INPUTCD-READ-SEC         SECTION.
      *
           MOVE    INPUTCD-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  INPUTCD-REC
                   MOVE    ZERO                TO  FLG-INPUTCD
               ELSE
                   INITIALIZE                  INPUTCD-REC
                   MOVE    1                   TO  FLG-INPUTCD
               END-IF
           ELSE
               INITIALIZE                  INPUTCD-REC
               MOVE    1                   TO  FLG-INPUTCD
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "INPUTCD-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       930-INPUTCD-NEXT-EXT.
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
