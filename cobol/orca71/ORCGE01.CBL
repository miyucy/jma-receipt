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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGE01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＣＳＶ作成
      *  コンポーネント名  : ＣＳＶ作成（Ｅ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/09/15    ひさなが 　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     ひさなが     02/02/04  ジョブ管理テーブルの追加
      *                                     雛形テーブルの追加
      *                                     レセプトコメントの追加
      * 01.00.02     ひさなが     02/04/23  患者労災保険テーブルの追加
      * 01.00.03     ひさなが     02/05/10  ジョブ管理検索追加
      * 01.00.04     ひさなが     02/05/29  相互作用テーブルの追加
      *                                     機序テーブルの追加
      *                                     人名テーブルの追加
      *                                     月代り受給者番号の追加
      * 01.00.05     ひさなが     02/09/13  ディレクトリをサブプロへ
      * 01.00.06     ひさなが     03/05/12  入院関連テーブルの追加
      *
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    ＣＳＶ作成条件用ファイル 
           SELECT  EIE00-FILE      ASSIGN  EIE00PARA
                                   FILE    STATUS  IS  STS-EIE00.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    ＣＳＶ作成条件用ファイル
       FD  EIE00-FILE.
       01  EIE00-REC               PIC X(50).
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    ＣＳＶ作成条件用ファイル 名称領域
           COPY    "CPCOMMONDAT4.INC"
                                   REPLACING  //ORCGD//
                                   BY         //EIE00//.
      *
      *    抽出項目用ファイル 名称領域
       01  EIE01PARA.
           03  FILLER               PIC  X(50).
       01  EIE01PARA-NAME.
           03  FILLER               PIC  X(07) VALUE
               "record/".
           03  EIE01-FILE-ID        PIC  X(23).
      *
      *    抽出項目１〜９０ファイル 名称領域
           COPY    "CPCOMMONDAT4.INC"
                                   REPLACING  //ORCGD//
                                   BY         //EIE02//.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       01  SPA-E01.
           03  SPA-E01-AREA.
               05  SPA-GMN-PAGE               PIC 9(02).
               05  SPA-GMN-MAX-A              PIC 9(03).
               05  SPA-GMN-MAX-B              PIC 9(03).
               05  SPA-GMN-CUR                PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-TBLG.
                       09  SPA-GNM-TBL2       OCCURS  90.
                           11  SPA-GMN-MSG-A  PIC X(20).
                           11  SPA-GMN-BTN-A  PIC X(01).
                           11  SPA-GMN-TBL-A  PIC X(20).
                           11  SPA-GMN-KBN1-A PIC X(01).
                           11  SPA-GMN-KBN2-A PIC X(01).
                           11  SPA-GMN-MSG-B  PIC X(20).
                           11  SPA-GMN-BTN-B  PIC X(01).
                           11  SPA-GMN-TBL-B  PIC X(20).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
       01  SPA-WRK-AREA.
           03  SPA-WRK-TBLG1       PIC X(7578).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SEL             PIC X(01).
           03  FLG-RUN             PIC 9(01).
      *
      *    エンドステータス領域
       01  STS-AREA.
           03  STS-EIE00           PIC X(02).
           03  STS-EIE01           PIC X(02).
           03  STS-EIE02           PIC X(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(03).
           03  IDX2                PIC 9(03).
           03  IDX3                PIC 9(03).
      *
      *    メッセージ領域
       01  T-MESSAGE-AREA.
           03  T-MESSAGE-01        PIC X(60)   VALUE
               "指定された条件でＣＳＶ出力中のためしばらくお待ちください
      -        "。  ".
           03  T-MESSAGE-02        PIC X(30)   VALUE
               "指定された条件でのＣＳＶ出力は".
           03  T-MESSAGE-03        PIC X(16)   VALUE
               "に終了しました。".
           03  T-MESSAGE-04        PIC X(20)   VALUE
               "作成テーブル未設定。".
           03  T-MESSAGE-05        PIC X(18)   VALUE
               "条件設定途中です。".
      *
      *    作業テーブル名称領域
       01  WK-TBL.
           03  WK-TBLSET       OCCURS  90.
               05  WK-TBL-MSG-C      PIC X(20).
               05  WK-TBL-NAME-C     PIC X(20).
               05  WK-TBL-BTN-C      PIC X(01).
      *
      *    ジョブ管理
       01  WRK-JOBKANRI-AREA.
           03  WRK-JOBKANRI-MODE       PIC X(03).
           03  WRK-JOBKANRI-RETURN     PIC S9(03).
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    フィアルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
      *     テーブルアクセス
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "E01.INC".
           COPY    "E02.INC".
           COPY    "EERR.INC".
           COPY    "EID1.INC".
           COPY    "EID2.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
                                               MCPAREA
                                               SPAAREA
                                               LINKAREA
                                               SCRAREA.
      *****************************************************************
      *    主    処    理
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-E01.
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
                   PERFORM 530-RIDSET2-SEC
                   IF  FLG-RUN   =   ZERO   OR   2
                       PERFORM 200-ENTRY
                   END-IF
           END-EVALUATE.
      *    画面遷移がない時、画面表示へ
           IF  FLG-END   =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-E01         TO  SPA-FREE.
      *
       000-PROC-SEC-EXT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
           INITIALIZE                  FLG-AREA.
      *
      *    エラー画面より
           IF  SPA-MOTOPG   =   "EERR" OR "EID1" OR "EID2"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5011-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >   SPA-GMN-MAX-A
               IF  E01-SELECT1 (IDX1)   =   "T"
                   MOVE    "A"              TO  FLG-SEL
                   MOVE    91               TO  IDX1
               END-IF
           END-PERFORM.
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >   SPA-GMN-MAX-B
               IF  E01-SELECT2 (IDX1)   =   "T"
                   MOVE    "D"              TO  FLG-SEL
                   MOVE    91               TO  IDX1
               END-IF
           END-PERFORM.
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "E01"               TO  MCP-WINDOW.
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
       300-SCREEN-SEC              SECTION.
      *
           INITIALIZE              SPA-E01.
      *
      *    他のＬＤより
           IF  LINKAREA   NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    LNK-SCRSPA          TO  SPA-WRK-AREA
           END-IF.
      *
           MOVE    1                       TO  SPA-GMN-CUR.
      *    テーブル名称セット
           MOVE    SPACE                   TO  SPA-GMN-TBLG.
           MOVE    SPACE                   TO  WK-TBL.
           MOVE    "SYSKANRI            "  TO  WK-TBL-MSG-C(01).
           MOVE    "tbl_syskanri.db     "  TO  WK-TBL-NAME-C(01).
           MOVE    "BYOMEI              "  TO  WK-TBL-MSG-C(02).
           MOVE    "tbl_byomei.db       "  TO  WK-TBL-NAME-C(02).
           MOVE    "CHK                 "  TO  WK-TBL-MSG-C(03).
           MOVE    "tbl_chk.db          "  TO  WK-TBL-NAME-C(03).
           MOVE    "INPUTCD             "  TO  WK-TBL-MSG-C(04).
           MOVE    "tbl_inputcd.db      "  TO  WK-TBL-NAME-C(04).
           MOVE    "HKNCOMBI            "  TO  WK-TBL-MSG-C(05).
           MOVE    "tbl_hkncombi.db     "  TO  WK-TBL-NAME-C(05).
           MOVE    "HKNNUM              "  TO  WK-TBL-MSG-C(06).
           MOVE    "tbl_hknnum.db       "  TO  WK-TBL-NAME-C(06).
           MOVE    "INPUTSET            "  TO  WK-TBL-MSG-C(07).
           MOVE    "tbl_inputset.db     "  TO  WK-TBL-NAME-C(07).
           MOVE    "ADRS                "  TO  WK-TBL-MSG-C(08).
           MOVE    "tbl_adrs.db         "  TO  WK-TBL-NAME-C(08).
           MOVE    "JYURRK              "  TO  WK-TBL-MSG-C(09).
           MOVE    "tbl_jyurrk.db       "  TO  WK-TBL-NAME-C(09).
           MOVE    "SRYKARRK            "  TO  WK-TBL-MSG-C(10).
           MOVE    "tbl_srykarrk.db     "  TO  WK-TBL-NAME-C(10).
           MOVE    "PTBYOMEI            "  TO  WK-TBL-MSG-C(11).
           MOVE    "tbl_ptbyomei.db     "  TO  WK-TBL-NAME-C(11).
           MOVE    "PTCOM               "  TO  WK-TBL-MSG-C(12).
           MOVE    "tbl_ptcom.db        "  TO  WK-TBL-NAME-C(12).
           MOVE    "PTNUM               "  TO  WK-TBL-MSG-C(13).
           MOVE    "tbl_ptnum.db        "  TO  WK-TBL-NAME-C(13).
           MOVE    "PTHKNINF            "  TO  WK-TBL-MSG-C(14).
           MOVE    "tbl_pthkninf.db     "  TO  WK-TBL-NAME-C(14).
           MOVE    "PTKOHINF            "  TO  WK-TBL-MSG-C(15).
           MOVE    "tbl_ptkohinf.db     "  TO  WK-TBL-NAME-C(15).
           MOVE    "PTINF               "  TO  WK-TBL-MSG-C(16).
           MOVE    "tbl_ptinf.db        "  TO  WK-TBL-NAME-C(16).
           MOVE    "KYUSEIRRK           "  TO  WK-TBL-MSG-C(17).
           MOVE    "tbl_kyuseirrk.db    "  TO  WK-TBL-NAME-C(17).
           MOVE    "SRYACCT             "  TO  WK-TBL-MSG-C(18).
           MOVE    "tbl_sryacct.db      "  TO  WK-TBL-NAME-C(18).
           MOVE    "SRYACT              "  TO  WK-TBL-MSG-C(19).
           MOVE    "tbl_sryact.db       "  TO  WK-TBL-NAME-C(19).
           MOVE    "SYUMEI              "  TO  WK-TBL-MSG-C(20).
           MOVE    "tbl_syumei.db       "  TO  WK-TBL-NAME-C(20).
           MOVE    "SYUNOU              "  TO  WK-TBL-MSG-C(21).
           MOVE    "tbl_syunou.db       "  TO  WK-TBL-NAME-C(21).
           MOVE    "TSYRRK              "  TO  WK-TBL-MSG-C(22).
           MOVE    "tbl_tsyrrk.db       "  TO  WK-TBL-NAME-C(22).
           MOVE    "TENSU               "  TO  WK-TBL-MSG-C(23).
           MOVE    "tbl_tensu.db        "  TO  WK-TBL-NAME-C(23).
           MOVE    "UKETUKE             "  TO  WK-TBL-MSG-C(24).
           MOVE    "tbl_uketuke.db      "  TO  WK-TBL-NAME-C(24).
           MOVE    "YYK                 "  TO  WK-TBL-MSG-C(25).
           MOVE    "tbl_yyk.db          "  TO  WK-TBL-NAME-C(25).
           MOVE    "SYKRRK              "  TO  WK-TBL-MSG-C(26).
           MOVE    "tbl_sykrrk.db       "  TO  WK-TBL-NAME-C(26).
           MOVE    "TNKRRK              "  TO  WK-TBL-MSG-C(27).
           MOVE    "tbl_tnkrrk.db       "  TO  WK-TBL-NAME-C(27).
           MOVE    "SANTEI              "  TO  WK-TBL-MSG-C(28).
           MOVE    "tbl_santei.db       "  TO  WK-TBL-NAME-C(28).
           MOVE    "RECEPRT             "  TO  WK-TBL-MSG-C(29).
           MOVE    "tbl_receprt.db      "  TO  WK-TBL-NAME-C(29).
           MOVE    "SEIKYU              "  TO  WK-TBL-MSG-C(30).
           MOVE    "tbl_seikyu.db       "  TO  WK-TBL-NAME-C(30).
           MOVE    "TENSUPLUS           "  TO  WK-TBL-MSG-C(31).
           MOVE    "tbl_tensuplus.db    "  TO  WK-TBL-NAME-C(31).
           MOVE    "HKNJAINF            "  TO  WK-TBL-MSG-C(32).
           MOVE    "tbl_hknjainf.db     "  TO  WK-TBL-NAME-C(32).
           MOVE    "SRYCDCHG            "  TO  WK-TBL-MSG-C(33).
           MOVE    "tbl_srycdchg.db     "  TO  WK-TBL-NAME-C(33).
           MOVE    "USERBYOMEI          "  TO  WK-TBL-MSG-C(34).
           MOVE    "tbl_userbyomei.db   "  TO  WK-TBL-NAME-C(34).
           MOVE    "JOBKANRI            "  TO  WK-TBL-MSG-C(35).
           MOVE    "tbl_jobkanri.db     "  TO  WK-TBL-NAME-C(35).
           MOVE    "EXAMPLE             "  TO  WK-TBL-MSG-C(36).
           MOVE    "tbl_example.db      "  TO  WK-TBL-NAME-C(36).
           MOVE    "RECECOM             "  TO  WK-TBL-MSG-C(37).
           MOVE    "tbl_rececom.db      "  TO  WK-TBL-NAME-C(37).
           MOVE    "DBKANRI             "  TO  WK-TBL-MSG-C(38).
           MOVE    "tbl_dbkanri.db      "  TO  WK-TBL-NAME-C(38).
           MOVE    "RECEKANRI           "  TO  WK-TBL-MSG-C(39).
           MOVE    "tbl_recekanri.db    "  TO  WK-TBL-NAME-C(39).
           MOVE    "PTRSIINF            "  TO  WK-TBL-MSG-C(40).
           MOVE    "tbl_ptrsiinf.db     "  TO  WK-TBL-NAME-C(40).
           MOVE    "PRTKANRI            "  TO  WK-TBL-MSG-C(41).
           MOVE    "tbl_prtkanri.db     "  TO  WK-TBL-NAME-C(41).
           MOVE    "PRTDATA             "  TO  WK-TBL-MSG-C(42).
           MOVE    "tbl_prtdata.db      "  TO  WK-TBL-NAME-C(42).
           MOVE    "INTERACT            "  TO  WK-TBL-MSG-C(43).
           MOVE    "tbl_interact.db     "  TO  WK-TBL-NAME-C(43).
           MOVE    "SSKIJYO             "  TO  WK-TBL-MSG-C(44).
           MOVE    "tbl_sskijyo.db      "  TO  WK-TBL-NAME-C(44).
           MOVE    "JINMEI              "  TO  WK-TBL-MSG-C(45).
           MOVE    "tbl_jinmei.db       "  TO  WK-TBL-NAME-C(45).
           MOVE    "MONTHLYNUM          "  TO  WK-TBL-MSG-C(46).
           MOVE    "tbl_monthlynum.db   "  TO  WK-TBL-NAME-C(46).
      *修正/*開始*03.05.12*********************************************
           MOVE    "KENSASORT           "  TO  WK-TBL-MSG-C(47).
           MOVE    "tbl_kensasort.db    "  TO  WK-TBL-NAME-C(47).
           MOVE    "KOHSKY              "  TO  WK-TBL-MSG-C(48).
           MOVE    "tbl_kohsky.db       "  TO  WK-TBL-NAME-C(48).
           MOVE    "LDMAP               "  TO  WK-TBL-MSG-C(49).
           MOVE    "tbl_ldmap.db        "  TO  WK-TBL-NAME-C(49).
           MOVE    "LOCK                "  TO  WK-TBL-MSG-C(50).
           MOVE    "tbl_lock.db         "  TO  WK-TBL-NAME-C(50).
           MOVE    "PTKOHFTN            "  TO  WK-TBL-MSG-C(51).
           MOVE    "tbl_ptkohftn.db     "  TO  WK-TBL-NAME-C(51).
           MOVE    "YAKUJYO             "  TO  WK-TBL-MSG-C(52).
           MOVE    "tbl_yakujyo.db      "  TO  WK-TBL-NAME-C(52).
           MOVE    "BD001               "  TO  WK-TBL-MSG-C(53).
           MOVE    "view_bd001.db       "  TO  WK-TBL-NAME-C(53).
           MOVE    "BD002               "  TO  WK-TBL-MSG-C(54).
           MOVE    "view_bd002.db       "  TO  WK-TBL-NAME-C(54).
           MOVE    "I001                "  TO  WK-TBL-MSG-C(55).
           MOVE    "view_I001.db        "  TO  WK-TBL-NAME-C(55).
           MOVE    "Q001                "  TO  WK-TBL-MSG-C(56).
           MOVE    "view_Q001.db        "  TO  WK-TBL-NAME-C(56).
           IF  SPA-BEDSU   >   ZERO
               MOVE    "NYUINACCT           "  TO  WK-TBL-MSG-C(57)
               MOVE    "tbl_nyuinacct.db    "  TO  WK-TBL-NAME-C(57)
               MOVE    "NYUINACT            "  TO  WK-TBL-MSG-C(58)
               MOVE    "tbl_nyuinact.db     "  TO  WK-TBL-NAME-C(58)
               MOVE    "NYUINKHN            "  TO  WK-TBL-MSG-C(59)
               MOVE    "tbl_nyuinkhn.db     "  TO  WK-TBL-NAME-C(59)
               MOVE    "NYUINRYAKUSHO       "  TO  WK-TBL-MSG-C(60)
               MOVE    "tbl_nyuinryakusho.db"  TO  WK-TBL-NAME-C(60)
               MOVE    "NYUKSNCHK           "  TO  WK-TBL-MSG-C(61)
               MOVE    "tbl_nyuksnchk.db    "  TO  WK-TBL-NAME-C(61)
               MOVE    "PTNYUINRRK          "  TO  WK-TBL-MSG-C(62)
               MOVE    "tbl_ptnyuinrrk.db   "  TO  WK-TBL-NAME-C(62)
               MOVE    "PTTAINFUKA          "  TO  WK-TBL-MSG-C(63)
               MOVE    "tbl_pttainfuka.db   "  TO  WK-TBL-NAME-C(63)
               MOVE    "PTTEIKIRRK          "  TO  WK-TBL-MSG-C(64)
               MOVE    "tbl_ptteikirrk.db   "  TO  WK-TBL-NAME-C(64)
               MOVE    "SENTEICDCHG         "  TO  WK-TBL-MSG-C(65)
               MOVE    "tbl_senteicdchg.db  "  TO  WK-TBL-NAME-C(65)
               MOVE    "TEIKIKANRI          "  TO  WK-TBL-MSG-C(66)
               MOVE    "tbl_teikikanri.db   "  TO  WK-TBL-NAME-C(66)
               MOVE    "TEIKIPRT            "  TO  WK-TBL-MSG-C(67)
               MOVE    "tbl_teikiprt.db     "  TO  WK-TBL-NAME-C(67)
               MOVE    "TEIKIRRK            "  TO  WK-TBL-MSG-C(68)
               MOVE    "tbl_teikirrk.db     "  TO  WK-TBL-NAME-C(68)
           END-IF.
      *修正/*終了*03.05.12*********************************************
      *一時作業テーブルのため次のテーブルはコンバートの対象外とする
      *     MOVE    "WKSRYACT            "  TO  WK-TBL-MSG-C(**).
      *     MOVE    "tbl_wksryact.db     "  TO  WK-TBL-NAME-C(**).
      *     MOVE    "PARA                "  TO  WK-TBL-MSG-C(**).
      *     MOVE    "tbl_para.db         "  TO  WK-TBL-NAME-C(**).
      ************************************************************
      *
           PERFORM 310-SPASET-SEC.
      *
           PERFORM T-000-READCHEK-SEC.
      *
           PERFORM T-000-SETTABLE-SEC.
      *
           IF  SPA-WRK-AREA   NOT =   SPACE
               MOVE    SPA-WRK-AREA            TO  SPA-E01-AREA
           END-IF.
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-NAI-MOTOPG.
      *
           MOVE    1                   TO  SPA-GMN-CUR.
      *
           MOVE    1                   TO  SPA-GMN-PAGE.
      *
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM T-001-CHUSYUTU-SEC
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM T-001-TORIYAME-SEC
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM T-002-CHUSYUTU-SEC
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM T-002-TORIYAME-SEC
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 530-RIDSET3-SEC
               WHEN    "CLICKED"       ALSO    "B12"
                   IF  FLG-SEL   NOT =   SPACE
                       MOVE    "0002"              TO    SPA-ERRCD
                       PERFORM 500-SET-SCREEN
                   ELSE
                       IF  SPA-GMN-MAX-B   =   ZERO
                           MOVE    "0001"              TO    SPA-ERRCD
                           PERFORM 500-SET-SCREEN
                       ELSE
                           PERFORM 530-RIDSET2-SEC
                           IF  FLG-RUN   =   ZERO   OR   2
                               OPEN    OUTPUT                EIE00-FILE
                               PERFORM T-000-RECECHEK-SEC
                               CLOSE                         EIE00-FILE
      *
                               MOVE    "E01"             TO  SPA-MOTOPG
                               MOVE    "E02"             TO  SPA-SAKIPG
                               INITIALIZE                SPA-KYOTUKEY
                               INITIALIZE                SPA-WORK
                               MOVE    SPACE             TO  LINKAREA
                               MOVE    SPA-KYOUTU        TO  LNK-KYOUTU
                               MOVE   "CHANGE"           TO  MCP-PUTTYPE
                               MOVE   "E02"              TO  MCP-WINDOW
      *
                               PERFORM 900-PUT-WINDOW
      *
                               MOVE    1                 TO  FLG-END
                           END-IF
                       END-IF
                   END-IF
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 530-RIDSET2-SEC
               WHEN      ANY           ALSO    "CLIST1"
                   PERFORM T-000-CLST1CHK-SEC
               WHEN      ANY           ALSO    "CLIST2"
                   PERFORM T-000-CLST2CHK-SEC
               WHEN    OTHER
                   MOVE    1                   TO  SPA-GMN-CUR
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN      ANY           ALSO    "CLIST1"
                   PERFORM T-000-CLST1CHK-SEC
               WHEN      ANY           ALSO    "CLIST2"
                   PERFORM T-000-CLST2CHK-SEC
               WHEN    OTHER
                   MOVE    1                   TO  SPA-GMN-CUR
           END-EVALUATE.
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "M01"               TO  SPA-SAKIPG.
           MOVE    SPACE               TO  SPA-MOTOPG2.
           MOVE    "E01"               TO  SPA-MOTOPG.
      *
           MOVE    SPACE               TO  LINKAREA. 
           INITIALIZE                  SPA-KYOTUKEY.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
           MOVE    "CHANGE"            TO  MCP-PUTTYPE.
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
           IF  SPA-ERRCD   NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF.
      *
           MOVE    SPACE           TO  LINKAREA.
           MOVE    "CURRENT"       TO  MCP-PUTTYPE.
           MOVE    "E01"           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面内容編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE                 TO  E01.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    SPA-GMN-MAX-A
               MOVE    SPA-GMN-MSG-A (IDX1)   TO  E01-VALUE1  (IDX1)
               MOVE    SPA-GMN-BTN-A (IDX1)   TO  E01-SELECT1 (IDX1)
               MOVE    IDX1                   TO  E01-COUNT1
           END-PERFORM.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    SPA-GMN-MAX-B
               MOVE    SPA-GMN-MSG-B (IDX1)   TO  E01-VALUE2  (IDX1)
               MOVE    SPA-GMN-BTN-B (IDX1)   TO  E01-SELECT2 (IDX1)
               MOVE    IDX1                   TO  E01-COUNT2
           END-PERFORM.
      *
           PERFORM 5011-MAPCUR-SEC.
      *
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5011-MAPCUR-SEC              SECTION.
      *
           MOVE    "B12"           TO  MCP-WIDGET.
      *
       5011-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG.
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    T-MESSAGE-04        TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    T-MESSAGE-05        TO  SPA-ERRMSG
               WHEN    OTHER
                   MOVE    SPACE               TO  SPA-ERRMSG
           END-EVALUATE.
      *
           MOVE    SPACE               TO  EERR.
           MOVE    SPA-ERRCD           TO  EERR-ERRCODE.
           MOVE    SPA-ERRMSG          TO  EERR-ERRMSG.
           MOVE    "B01"               TO  MCP-WIDGET.
      *
           MOVE    "E01"               TO  SPA-MOTOPG.
           MOVE    "EERR"              TO  SPA-SAKIPG.
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "EERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認メッセージ表示理
      *****************************************************************
       530-RIDSET2-SEC              SECTION.
      *
      *    ジョブ管理チェック処理
      *
           MOVE    "CHK"              TO  WRK-JOBKANRI-MODE.
           INITIALIZE                     JOBKANRI-REC.
           MOVE    1                  TO  JOB-JOBID.
           MOVE    "ORCBSE1"          TO  JOB-SHELLID.
           MOVE    ALL "*"            TO  JOB-TERMID.
           CALL    "ORCSJOB"          USING
                                      WRK-JOBKANRI-AREA  
                                      JOBKANRI-REC.
           MOVE    SPACE              TO  EID2.
           MOVE    ZERO               TO  FLG-RUN.
           IF  WRK-JOBKANRI-RETURN   =   ZERO
               IF  JOB-ENDYMD   =   SPACE
                   MOVE    "7777"             TO  EID2-ID2CODE
                   MOVE    T-MESSAGE-01       TO  EID2-ID2MSG
                   MOVE    1                  TO  FLG-RUN
               ELSE
                   IF  MCP-WIDGET   =   "B13"
                       MOVE    "8888"             TO  EID2-ID2CODE
                       MOVE    T-MESSAGE-02       TO  EID2-ID2MSG(1:30)
                       MOVE    JOB-ENDTIME(1:2)   TO  EID2-ID2MSG(31:2)
                       MOVE    "時"               TO  EID2-ID2MSG(33:2)
                       MOVE    JOB-ENDTIME(3:2)   TO  EID2-ID2MSG(35:2)
                       MOVE    "分"               TO  EID2-ID2MSG(37:2)
                       MOVE    T-MESSAGE-03       TO  EID2-ID2MSG(39:16)
                       MOVE    2                  TO  FLG-RUN
                   END-IF
               END-IF
               IF  MCP-WIDGET   =   "B01"   OR   "B12"   OR   "B13"
                   MOVE    "E01"               TO  SPA-MOTOPG
                   MOVE    "EID2"              TO  SPA-SAKIPG
                   MOVE    "NEW"               TO  MCP-PUTTYPE
                   MOVE    "EID2"              TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                   TO  FLG-END
               END-IF
           END-IF.
      *
       530-RIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理表示理
      *****************************************************************
       530-RIDSET3-SEC              SECTION.
      *
      *    画面移行用のパラメタ変更
           MOVE    "E01"               TO  SPA-MOTOPG.
           MOVE    "XB01"              TO  SPA-SAKIPG.
           INITIALIZE                  SPA-KYOTUKEY.
           INITIALIZE                  SPA-WORK.
           MOVE    "ORCBSE1"           TO  SPA-JOB-SHELLID.
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE    SPA-E01-AREA        TO  LNK-SCRSPA.
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "XB01"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       530-RIDSET3-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"                   TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                    USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０３クリック 処理
      *****************************************************************
       T-001-CHUSYUTU-SEC                SECTION.
      *
           IF  FLG-SEL   =   "A"
               MOVE    ZERO                   TO    IDX2
               MOVE    ZERO                   TO    IDX3
      *
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >   SPA-GMN-MAX-A
                   IF  SPA-GMN-BTN-A (IDX1)   =   "T"
                       COMPUTE  IDX2          = IDX2          + 1
                       COMPUTE  SPA-GMN-MAX-B = SPA-GMN-MAX-B + 1
                       MOVE    SPA-GMN-MSG-A (IDX1)
                                       TO  SPA-GMN-MSG-B (SPA-GMN-MAX-B)
                       MOVE    SPA-GMN-TBL-A (IDX1)
                                       TO  SPA-GMN-TBL-B (SPA-GMN-MAX-B)
                       MOVE    "F"     TO  SPA-GMN-BTN-A (IDX1)
                   ELSE
                       COMPUTE  IDX3 = IDX3 + 1
                       MOVE    SPA-GMN-MSG-A (IDX1)
                                       TO  SPA-GMN-MSG-A (IDX3)
                       MOVE    SPA-GMN-TBL-A (IDX1)
                                       TO  SPA-GMN-TBL-A (IDX3)
                   END-IF
               END-PERFORM
      *         
               COMPUTE  IDX3 = SPA-GMN-MAX-A + 1
      *
               PERFORM VARYING IDX1  FROM  IDX3  BY 1
                       UNTIL   IDX1  >   90
                   MOVE    SPACE            TO  SPA-GMN-MSG-A (IDX1)
                   MOVE    SPACE            TO  SPA-GMN-TBL-A (IDX1)
                   MOVE    "F"              TO  SPA-GMN-BTN-A (IDX1)
               END-PERFORM
      *
               COMPUTE  SPA-GMN-MAX-A = SPA-GMN-MAX-A - IDX2
               MOVE    SPACE             TO  FLG-SEL
           END-IF.
      *
       T-001-CHUSYUTU-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０４クリック 処理
      *****************************************************************
       T-001-TORIYAME-SEC                SECTION.
      *
           IF  FLG-SEL   =   "D"
               MOVE    ZERO             TO  IDX2
               MOVE    ZERO             TO  IDX3
      *
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >   SPA-GMN-MAX-B
                   IF  SPA-GMN-BTN-B (IDX1)   =   "T"
                       COMPUTE  IDX2 = IDX2 + 1
                       MOVE    "F"     TO  SPA-GMN-BTN-B (IDX1)
                   ELSE
                       COMPUTE  IDX3 = IDX3 + 1
                       MOVE    SPA-GMN-MSG-B (IDX1)
                                       TO  SPA-GMN-MSG-B (IDX3)
                       MOVE    SPA-GMN-TBL-B (IDX1)
                                       TO  SPA-GMN-TBL-B (IDX3)
                   END-IF
               END-PERFORM
      *         
               COMPUTE  IDX3 = SPA-GMN-MAX-B + 1
      *
               PERFORM VARYING IDX1  FROM  IDX3  BY 1
                       UNTIL   IDX1  >   90
                   MOVE    SPACE            TO  SPA-GMN-MSG-B (IDX1)
                   MOVE    SPACE            TO  SPA-GMN-TBL-B (IDX1)
                   MOVE    "F"              TO  SPA-GMN-BTN-B (IDX1)
               END-PERFORM
      *
               COMPUTE  SPA-GMN-MAX-B = SPA-GMN-MAX-B - IDX2
               MOVE    SPACE             TO  FLG-SEL
               PERFORM T-000-SETTABLE-SEC
      *
           END-IF.
      *
       T-001-TORIYAME-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０５クリック 処理
      *****************************************************************
       T-002-CHUSYUTU-SEC                SECTION.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >   SPA-GMN-MAX-A
               COMPUTE  SPA-GMN-MAX-B = SPA-GMN-MAX-B + 1
               MOVE    SPA-GMN-MSG-A (IDX1)
                                       TO  SPA-GMN-MSG-B (SPA-GMN-MAX-B)
               MOVE    SPA-GMN-TBL-A (IDX1)
                                       TO  SPA-GMN-TBL-B (SPA-GMN-MAX-B)
               MOVE    SPACE           TO  SPA-GMN-MSG-A (IDX1)
               MOVE    SPACE           TO  SPA-GMN-TBL-A (IDX1)
               MOVE    "F"             TO  SPA-GMN-BTN-A (IDX1)
           END-PERFORM.
      *
           MOVE    ZERO                   TO  SPA-GMN-MAX-A.
           MOVE    SPACE                  TO  FLG-SEL.
      *
       T-002-CHUSYUTU-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｂ０６クリック 処理
      *****************************************************************
       T-002-TORIYAME-SEC                SECTION.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >   SPA-GMN-MAX-B
               MOVE    SPACE            TO  SPA-GMN-MSG-B (IDX1)
               MOVE    SPACE            TO  SPA-GMN-TBL-B (IDX1)
               MOVE    "F"              TO  SPA-GMN-BTN-B (IDX1)
           END-PERFORM.
      *
           MOVE    ZERO             TO  SPA-GMN-MAX-B.
           MOVE    SPACE            TO  FLG-SEL.
           PERFORM T-000-SETTABLE-SEC.
      *
       T-002-TORIYAME-EXT.
           EXIT.
      *
      *****************************************************************
      *    左項目クリック 処理
      *****************************************************************
       T-000-CLST1CHK-SEC                SECTION.
      *
           IF  FLG-SEL   =   " "  OR  "A"
               MOVE    SPACE            TO  FLG-SEL
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >   SPA-GMN-MAX-A
                   MOVE    E01-SELECT1 (IDX1)
                           TO  SPA-GMN-BTN-A (IDX1)
                   IF  E01-SELECT1 (IDX1)   =   "T"
                       MOVE    "A"              TO  FLG-SEL
                   END-IF
               END-PERFORM
           END-IF.
      *
       T-000-CLST1CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    右項目クリック 処理
      *****************************************************************
       T-000-CLST2CHK-SEC                SECTION.
      *
           IF  FLG-SEL   =   " "  OR  "D"
               MOVE    SPACE            TO  FLG-SEL
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >   SPA-GMN-MAX-B
                   MOVE    E01-SELECT2 (IDX1)
                           TO  SPA-GMN-BTN-B (IDX1)
                   IF  E01-SELECT2 (IDX1)   =   "T"
                       MOVE    "D"              TO  FLG-SEL
                   END-IF
               END-PERFORM
           END-IF.
      *
       T-000-CLST2CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    テーブル名称 セット処理
      *****************************************************************
       T-000-SETTABLE-SEC                SECTION.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    90
               IF  WK-TBL-MSG-C (IDX1)   NOT =   SPACE
                   MOVE    "F"               TO  WK-TBL-BTN-C (IDX1)
               END-IF
           END-PERFORM.
      *
           IF      SPA-GMN-MAX-B  NOT =  ZERO
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >   SPA-GMN-MAX-B
                   PERFORM VARYING IDX2  FROM  1  BY 1
                           UNTIL   IDX2  >   90
                       IF  SPA-GMN-MSG-B (IDX1)  =  WK-TBL-MSG-C (IDX2)
                           MOVE    "T"       TO  WK-TBL-BTN-C (IDX2)
                           MOVE    91        TO  IDX2
                       END-IF
                   END-PERFORM
               END-PERFORM
           END-IF.
      *
           MOVE    ZERO             TO  IDX3.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >   90
               EVALUATE    WK-TBL-BTN-C (IDX1)
                   WHEN    "T"
                       MOVE    "F"       TO  WK-TBL-BTN-C (IDX1)
                   WHEN    "F"
                       COMPUTE  IDX3  =  IDX3  +  1
                       MOVE    IDX3      TO  SPA-GMN-MAX-A
                       MOVE    WK-TBL-MSG-C (IDX1)
                                         TO  SPA-GMN-MSG-A (IDX3)
                       MOVE    WK-TBL-NAME-C (IDX1)
                                         TO  SPA-GMN-TBL-A (IDX3)
               END-EVALUATE
           END-PERFORM.
      *         
           COMPUTE  IDX3 = SPA-GMN-MAX-A + 1.
      *
           PERFORM VARYING IDX1  FROM  IDX3  BY 1
                   UNTIL   IDX1  >   90
               MOVE    SPACE            TO  SPA-GMN-MSG-A (IDX1)
               MOVE    SPACE            TO  SPA-GMN-TBL-A (IDX1)
               MOVE    "F"              TO  SPA-GMN-BTN-A (IDX1)
           END-PERFORM.
      *
       T-000-SETTABLE-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    確認条件 出力処理
      *****************************************************************
       T-000-RECECHEK-SEC                SECTION.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    SPA-GMN-MAX-B
               MOVE    SPACE                 TO  EIE00-REC
               MOVE    SPA-GMN-MSG-B (IDX1)  TO  EIE00-REC(1:20)
               MOVE    "*"                   TO  EIE00-REC(22:1)
               MOVE    SPACE                 TO  EIE00-REC(24:1)
               MOVE    SPA-GMN-TBL-B (IDX1)  TO  EIE00-REC(26:20)
               WRITE   EIE00-REC
           END-PERFORM.
      *
       T-000-RECECHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＳＶ作成条件 入力処理
      *****************************************************************
       T-000-READCHEK-SEC                SECTION.
      *
           MOVE    ZERO                    TO  SPA-GMN-MAX-B.
           MOVE    SPACE                   TO  FLG-SEL
           MOVE    "ORCE00.CNV"            TO  EIE00PARA-FILE.
      *
           OPEN    INPUT                   EIE00-FILE.
      *
           IF      STS-EIE00         =   ZERO
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >    90
                   READ    EIE00-FILE
                           AT   END
                                MOVE    91    TO  IDX1
                           NOT  AT  END
                                MOVE    EIE00-REC(1:20)
                                              TO  SPA-GMN-MSG-B (IDX1)
                                MOVE    EIE00-REC(26:20)
                                              TO  SPA-GMN-TBL-B (IDX1)
                                MOVE    IDX1  TO  SPA-GMN-MAX-B
                   END-READ
               END-PERFORM
               CLOSE                           EIE00-FILE
           END-IF.
      *
       T-000-READCHEK-EXT.
           EXIT.
      *
