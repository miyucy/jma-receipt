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
       PROGRAM-ID.                 ORCGF01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : バックアップ
      *  コンポーネント名  : バックアップ（Ｆ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/12/03    ひさなが 　   新規作成
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
      *
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    バックアップ条件用ファイル 
           SELECT  FIF00-FILE      ASSIGN  FIF00PARA
                                   FILE    STATUS  IS  STS-FIF00.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    バックアップ条件用ファイル
       FD  FIF00-FILE.
       01  FIF00-REC               PIC X(260).
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    バックアップ条件用ファイル 名称領域 
           COPY    "CPCOMMONDAT4.INC"
                                   REPLACING  //ORCGD//
                                   BY         //FIF00//.
      *
      *    バックアップ シェル領域
           COPY    "CPCOMMONSHELLUP.INC".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       01  SPA-F01.
           03  SPA-F01-AREA.
               05  SPA-GMN-PAGE               PIC 9(02).
               05  SPA-GMN-MAX-A              PIC 9(03).
               05  SPA-GMN-MAX-B              PIC 9(03).
               05  SPA-GMN-CUR                PIC 9(02).
               05  SPA-GMN-KBN                PIC X(02).
               05  SPA-GMN-RUN                PIC 9(01).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-FILE-ID        PIC X(128).
                   07  SPA-GMN-TBLG.
                       09  SPA-GNM-TBL2       OCCURS  60.
                           11  SPA-GMN-MSG    PIC X(20).
                           11  SPA-GMN-BTN    PIC X(01).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
       01  SPA-WRK-AREA.
           03  SPA-WRK-WRK         PIC X(13).
           03  SPA-WRK-FILE-ID     PIC X(128).
           03  SPA-WRK-TBLG1       PIC X(1260).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
      *
      *    エンドステータス領域
       01  STS-AREA.
           03  STS-FIF00           PIC X(02).
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
               "指定された条件でバックアップ中のためしばらくお待ちくださ
      -        "い。".
           03  T-MESSAGE-02        PIC X(32)   VALUE
               "指定された条件でのバックアップは".
           03  T-MESSAGE-03        PIC X(16)   VALUE
               "に終了しました。".
           03  T-MESSAGE-04        PIC X(20)   VALUE
               "作成テーブル未設定。".
           03  T-MESSAGE-05        PIC X(44)   VALUE
               "指定された条件でバックアップ処理を行います。".
      *
      *    作業テーブル名称領域
       01  WK-TBL.
           03  WK-TBLSET       OCCURS  60.
               05  WK-TBL-MSG-1      PIC X(20).
               05  WK-TBL-MSG-2      PIC X(20).
               05  WK-TBL-MSG-3      PIC X(20).
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
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
           COPY    "F01.INC".
           COPY    "FERR.INC".
           COPY    "FID1.INC".
           COPY    "FID2.INC".
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
           MOVE    SPA-FREE        TO  SPA-F01.
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
                   IF  SPA-GMN-RUN   =   ZERO   OR   2
                       PERFORM 200-ENTRY
                   ELSE
                       MOVE    "F01"               TO  SPA-MOTOPG
                       MOVE    "FID2"              TO  SPA-SAKIPG
                       MOVE    "NEW"               TO  MCP-PUTTYPE
                       MOVE    "FID2"              TO  MCP-WINDOW
                       PERFORM 900-PUT-WINDOW
                       MOVE    1                   TO  FLG-END
                   END-IF
           END-EVALUATE.
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-F01         TO  SPA-FREE.
      *
       000-PROC-SEC-EXT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  FLG-AREA.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "FERR" OR "FID1" OR "FID2"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5011-MAPCUR-SEC
               IF  (SPA-GMN-RUN   =   ZERO   OR   2)   AND
                   (SPA-GMN-KBN   =   "OK")
                   MOVE    "CHK"               TO  WRK-JOBKANRI-MODE
                   INITIALIZE                      JOBKANRI-REC
                   MOVE    1                   TO  JOB-JOBID
                   MOVE    "ORCBSF1"           TO  JOB-SHELLID
                   MOVE    ALL "*"             TO  JOB-TERMID
                   CALL    "ORCSJOB"           USING
                                               WRK-JOBKANRI-AREA  
                                               JOBKANRI-REC
                   IF  WRK-JOBKANRI-RETURN   =   ZERO
                       INITIALIZE                      WRK-JOBKANRI-AREA
                       MOVE    "DEL"               TO  WRK-JOBKANRI-MODE
                       INITIALIZE                      JOBKANRI-REC
                       MOVE    1                   TO  JOB-JOBID
                       MOVE    "ORCBSF1"           TO  JOB-SHELLID
                       MOVE    ALL "*"             TO  JOB-TERMID
                       CALL    "ORCSJOB"           USING
                                                   WRK-JOBKANRI-AREA
                                                   JOBKANRI-REC
                   END-IF
                   INITIALIZE                      WRK-JOBKANRI-AREA
                   MOVE    "JBS"               TO  WRK-JOBKANRI-MODE
                   INITIALIZE                      JOBKANRI-REC
                   MOVE    1                   TO  JOB-JOBID
                   MOVE    "ORCBSF1"           TO  JOB-SHELLID
                   MOVE    ALL "*"             TO  JOB-TERMID
                   MOVE    "媒体変換"          TO  JOB-SHELLMSG
                   CALL    "ORCSJOB"           USING
                                               WRK-JOBKANRI-AREA
                                               JOBKANRI-REC
                   PERFORM T-000-READWRIT-SEC
                   PERFORM T-000-WRITABLE-SEC
                   MOVE    1                   TO  FLG-END
                   MOVE    SPACE               TO  SPA-MOTOPG
                   MOVE    SPACE               TO  SPA-GMN-KBN
               END-IF
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF.
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "F01"               TO  MCP-WINDOW.
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
           INITIALIZE              SPA-F01.
      *
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    LNK-SCRSPA          TO  SPA-WRK-AREA
           END-IF.
      *
           MOVE    1                       TO  SPA-GMN-CUR.
      *    テーブル名称セット
           MOVE    SPACE                   TO  SPA-GMN-TBLG.
           MOVE    SPACE                   TO  WK-TBL.
           MOVE    46                      TO  SPA-GMN-MAX-A.
           MOVE    "/home/orca/orcadb.out" TO  SPA-GMN-FILE-ID.
           MOVE    "SYSKANRI            "  TO  WK-TBL-MSG-1 (01).
           MOVE    "tbl_syskanri        "  TO  WK-TBL-MSG-2 (01).
           MOVE    "CHKBTN1             "  TO  WK-TBL-MSG-3 (01).
           MOVE    "BYOMEI              "  TO  WK-TBL-MSG-1 (02).
           MOVE    "tbl_byomei          "  TO  WK-TBL-MSG-2 (02).
           MOVE    "CHKBTN2             "  TO  WK-TBL-MSG-3 (02).
           MOVE    "CHK                 "  TO  WK-TBL-MSG-1 (03).
           MOVE    "tbl_chk             "  TO  WK-TBL-MSG-2 (03).
           MOVE    "CHKBTN3             "  TO  WK-TBL-MSG-3 (03).
           MOVE    "INPUTCD             "  TO  WK-TBL-MSG-1 (04).
           MOVE    "tbl_inputcd         "  TO  WK-TBL-MSG-2 (04).
           MOVE    "CHKBTN4             "  TO  WK-TBL-MSG-3 (04).
           MOVE    "HKNCOMBI            "  TO  WK-TBL-MSG-1 (05).
           MOVE    "tbl_hkncombi        "  TO  WK-TBL-MSG-2 (05).
           MOVE    "CHKBTN5             "  TO  WK-TBL-MSG-3 (05).
           MOVE    "HKNNUM              "  TO  WK-TBL-MSG-1 (06).
           MOVE    "tbl_hknnum          "  TO  WK-TBL-MSG-2 (06).
           MOVE    "CHKBTN6             "  TO  WK-TBL-MSG-3 (06).
           MOVE    "INPUTSET            "  TO  WK-TBL-MSG-1 (07).
           MOVE    "tbl_inputset        "  TO  WK-TBL-MSG-2 (07).
           MOVE    "CHKBTN7             "  TO  WK-TBL-MSG-3 (07).
           MOVE    "ADRS                "  TO  WK-TBL-MSG-1 (08).
           MOVE    "tbl_adrs            "  TO  WK-TBL-MSG-2 (08).
           MOVE    "CHKBTN8             "  TO  WK-TBL-MSG-3 (08).
           MOVE    "JYURRK              "  TO  WK-TBL-MSG-1 (09).
           MOVE    "tbl_jyurrk          "  TO  WK-TBL-MSG-2 (09).
           MOVE    "CHKBTN9             "  TO  WK-TBL-MSG-3 (09).
           MOVE    "SRYKARRK            "  TO  WK-TBL-MSG-1 (10).
           MOVE    "tbl_srykarrk        "  TO  WK-TBL-MSG-2 (10).
           MOVE    "CHKBTN10            "  TO  WK-TBL-MSG-3 (10).
           MOVE    "PTBYOMEI            "  TO  WK-TBL-MSG-1 (11).
           MOVE    "tbl_ptbyomei        "  TO  WK-TBL-MSG-2 (11).
           MOVE    "CHKBTN11            "  TO  WK-TBL-MSG-3 (11).
           MOVE    "PTCOM               "  TO  WK-TBL-MSG-1 (12).
           MOVE    "tbl_ptcom           "  TO  WK-TBL-MSG-2 (12).
           MOVE    "CHKBTN12            "  TO  WK-TBL-MSG-3 (12).
           MOVE    "PTNUM               "  TO  WK-TBL-MSG-1 (13).
           MOVE    "tbl_ptnum           "  TO  WK-TBL-MSG-2 (13).
           MOVE    "CHKBTN13            "  TO  WK-TBL-MSG-3 (13).
           MOVE    "PTHKNINF            "  TO  WK-TBL-MSG-1 (14).
           MOVE    "tbl_pthkninf        "  TO  WK-TBL-MSG-2 (14).
           MOVE    "CHKBTN14            "  TO  WK-TBL-MSG-3 (14).
           MOVE    "PTKOHINF            "  TO  WK-TBL-MSG-1 (15).
           MOVE    "tbl_ptkohinf        "  TO  WK-TBL-MSG-2 (15).
           MOVE    "CHKBTN15            "  TO  WK-TBL-MSG-3 (15).
           MOVE    "PTINF               "  TO  WK-TBL-MSG-1 (16).
           MOVE    "tbl_ptinf           "  TO  WK-TBL-MSG-2 (16).
           MOVE    "CHKBTN16            "  TO  WK-TBL-MSG-3 (16).
           MOVE    "KYUSEIRRK           "  TO  WK-TBL-MSG-1 (17).
           MOVE    "tbl_kyuseirrk       "  TO  WK-TBL-MSG-2 (17).
           MOVE    "CHKBTN17            "  TO  WK-TBL-MSG-3 (17).
           MOVE    "SRYACCT             "  TO  WK-TBL-MSG-1 (18).
           MOVE    "tbl_sryacct         "  TO  WK-TBL-MSG-2 (18).
           MOVE    "CHKBTN18            "  TO  WK-TBL-MSG-3 (18).
           MOVE    "SRYACT              "  TO  WK-TBL-MSG-1 (19).
           MOVE    "tbl_sryact          "  TO  WK-TBL-MSG-2 (19).
           MOVE    "CHKBTN19            "  TO  WK-TBL-MSG-3 (19).
           MOVE    "SYUMEI              "  TO  WK-TBL-MSG-1 (20).
           MOVE    "tbl_syumei          "  TO  WK-TBL-MSG-2 (20).
           MOVE    "CHKBTN20            "  TO  WK-TBL-MSG-3 (20).
           MOVE    "SYUNOU              "  TO  WK-TBL-MSG-1 (21).
           MOVE    "tbl_syunou          "  TO  WK-TBL-MSG-2 (21).
           MOVE    "CHKBTN21            "  TO  WK-TBL-MSG-3 (21).
           MOVE    "TSYRRK              "  TO  WK-TBL-MSG-1 (22).
           MOVE    "tbl_tsyrrk          "  TO  WK-TBL-MSG-2 (22).
           MOVE    "CHKBTN22            "  TO  WK-TBL-MSG-3 (22).
           MOVE    "TENSU               "  TO  WK-TBL-MSG-1 (23).
           MOVE    "tbl_tensu           "  TO  WK-TBL-MSG-2 (23).
           MOVE    "CHKBTN23            "  TO  WK-TBL-MSG-3 (23).
           MOVE    "UKETUKE             "  TO  WK-TBL-MSG-1 (24).
           MOVE    "tbl_uketuke         "  TO  WK-TBL-MSG-2 (24).
           MOVE    "CHKBTN24            "  TO  WK-TBL-MSG-3 (24).
           MOVE    "YYK                 "  TO  WK-TBL-MSG-1 (25).
           MOVE    "tbl_yyk             "  TO  WK-TBL-MSG-2 (25).
           MOVE    "CHKBTN25            "  TO  WK-TBL-MSG-3 (25).
           MOVE    "SYKRRK              "  TO  WK-TBL-MSG-1 (26).
           MOVE    "tbl_sykrrk          "  TO  WK-TBL-MSG-2 (26).
           MOVE    "CHKBTN26            "  TO  WK-TBL-MSG-3 (26).
           MOVE    "TNKRRK              "  TO  WK-TBL-MSG-1 (27).
           MOVE    "tbl_tnkrrk          "  TO  WK-TBL-MSG-2 (27).
           MOVE    "CHKBTN27            "  TO  WK-TBL-MSG-3 (27).
           MOVE    "SANTEI              "  TO  WK-TBL-MSG-1 (28).
           MOVE    "tbl_santei          "  TO  WK-TBL-MSG-2 (28).
           MOVE    "CHKBTN28            "  TO  WK-TBL-MSG-3 (28).
           MOVE    "RECEPRT             "  TO  WK-TBL-MSG-1 (29).
           MOVE    "tbl_receprt         "  TO  WK-TBL-MSG-2 (29).
           MOVE    "CHKBTN29            "  TO  WK-TBL-MSG-3 (29).
           MOVE    "SEIKYU              "  TO  WK-TBL-MSG-1 (30).
           MOVE    "tbl_seikyu          "  TO  WK-TBL-MSG-2 (30).
           MOVE    "CHKBTN30            "  TO  WK-TBL-MSG-3 (30).
           MOVE    "TENSUPLUS           "  TO  WK-TBL-MSG-1 (31).
           MOVE    "tbl_tensuplus       "  TO  WK-TBL-MSG-2 (31).
           MOVE    "CHKBTN31            "  TO  WK-TBL-MSG-3 (31).
           MOVE    "HKNJAINF            "  TO  WK-TBL-MSG-1 (32).
           MOVE    "tbl_hknjainf        "  TO  WK-TBL-MSG-2 (32).
           MOVE    "CHKBTN32            "  TO  WK-TBL-MSG-3 (32).
           MOVE    "SRYCDCHG            "  TO  WK-TBL-MSG-1 (33).
           MOVE    "tbl_srycdchg        "  TO  WK-TBL-MSG-2 (33).
           MOVE    "CHKBTN33            "  TO  WK-TBL-MSG-3 (33).
           MOVE    "USERBYOMEI          "  TO  WK-TBL-MSG-1 (34).
           MOVE    "tbl_userbyomei      "  TO  WK-TBL-MSG-2 (34).
           MOVE    "CHKBTN34            "  TO  WK-TBL-MSG-3 (34).
           MOVE    "JOBKANRI            "  TO  WK-TBL-MSG-1 (35).
           MOVE    "tbl_jobkanri        "  TO  WK-TBL-MSG-2 (35).
           MOVE    "CHKBTN35            "  TO  WK-TBL-MSG-3 (35).
           MOVE    "EXAMPLE             "  TO  WK-TBL-MSG-1 (36).
           MOVE    "tbl_example         "  TO  WK-TBL-MSG-2 (36).
           MOVE    "CHKBTN36            "  TO  WK-TBL-MSG-3 (36).
           MOVE    "RECECOM             "  TO  WK-TBL-MSG-1 (37).
           MOVE    "tbl_rececom         "  TO  WK-TBL-MSG-2 (37).
           MOVE    "CHKBTN37            "  TO  WK-TBL-MSG-3 (37).
           MOVE    "DBKANRI             "  TO  WK-TBL-MSG-1 (38).
           MOVE    "tbl_dbkanri         "  TO  WK-TBL-MSG-2 (38).
           MOVE    "CHKBTN38            "  TO  WK-TBL-MSG-3 (38).
           MOVE    "RECEKANRI           "  TO  WK-TBL-MSG-1 (39).
           MOVE    "tbl_recekanri       "  TO  WK-TBL-MSG-2 (39).
           MOVE    "CHKBTN39            "  TO  WK-TBL-MSG-3 (39).
           MOVE    "PTRSIINF            "  TO  WK-TBL-MSG-1 (40).
           MOVE    "tbl_ptrsiinf        "  TO  WK-TBL-MSG-2 (40).
           MOVE    "CHKBTN40            "  TO  WK-TBL-MSG-3 (40).
           MOVE    "PRTKANRI            "  TO  WK-TBL-MSG-1 (41).
           MOVE    "tbl_prtkanri        "  TO  WK-TBL-MSG-2 (41).
           MOVE    "CHKBTN41            "  TO  WK-TBL-MSG-3 (41).
           MOVE    "PRTDATA             "  TO  WK-TBL-MSG-1 (42).
           MOVE    "tbl_prtdata         "  TO  WK-TBL-MSG-2 (42).
           MOVE    "CHKBTN42            "  TO  WK-TBL-MSG-3 (42).
           MOVE    "INTERACT            "  TO  WK-TBL-MSG-1 (43).
           MOVE    "tbl_interact        "  TO  WK-TBL-MSG-2 (43).
           MOVE    "CHKBTN43            "  TO  WK-TBL-MSG-3 (43).
           MOVE    "SSKIJYO             "  TO  WK-TBL-MSG-1 (44).
           MOVE    "tbl_sskijyo         "  TO  WK-TBL-MSG-2 (44).
           MOVE    "CHKBTN44            "  TO  WK-TBL-MSG-3 (44).
           MOVE    "JINMEI              "  TO  WK-TBL-MSG-1 (45).
           MOVE    "tbl_jinmei          "  TO  WK-TBL-MSG-2 (45).
           MOVE    "CHKBTN45            "  TO  WK-TBL-MSG-3 (45).
           MOVE    "MONTHLYNUM          "  TO  WK-TBL-MSG-1 (46).
           MOVE    "tbl_monthlynum      "  TO  WK-TBL-MSG-2 (46).
           MOVE    "CHKBTN46            "  TO  WK-TBL-MSG-3 (46).
      *一時作業テーブルのため次のテーブルはバックアップの対象外とする
      *     MOVE    "BD001               "  TO  WK-TBL-MSG-1 (**).
      *     MOVE    "view_bd001          "  TO  WK-TBL-MSG-2 (**).
      *     MOVE    "BD002               "  TO  WK-TBL-MSG-1 (**).
      *     MOVE    "view_bd002          "  TO  WK-TBL-MSG-2 (**).
      *     MOVE    "WKSRYACT            "  TO  WK-TBL-MSG-1 (**).
      *     MOVE    "tbl_wksryact        "  TO  WK-TBL-MSG-2 (**).
      *     MOVE    "PARA                "  TO  WK-TBL-MSG-1 (**).
      *     MOVE    "tbl_para            "  TO  WK-TBL-MSG-2 (**).
      *     MOVE    "QPTINF              "  TO  WK-TBL-MSG-1 (**).
      *     MOVE    "query_ptinf         "  TO  WK-TBL-MSG-2 (**).
      *     MOVE    "QPTINFC             "  TO  WK-TBL-MSG-1 (**).
      *     MOVE    "query_ptinf_cnt     "  TO  WK-TBL-MSG-2 (**).
      ************************************************************
      *
           PERFORM 310-SPASET-SEC.
      *
           PERFORM T-000-SETTABLE-SEC.
      *
           PERFORM T-000-READCHEK-SEC.
           IF  SPA-WRK-AREA   NOT =   SPACE
               MOVE    SPA-WRK-AREA            TO  SPA-F01-AREA
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
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 530-RIDSET3-SEC
               WHEN    "CLICKED"       ALSO    "B12"
                   IF      SPA-GMN-MAX-B       =   ZERO
                       MOVE    "0001"              TO  SPA-ERRCD
                       PERFORM 500-SET-SCREEN
                   ELSE
                       PERFORM 530-RIDSET2-SEC
                   END-IF
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 530-RIDSET2-SEC
               WHEN    "ACTIVATE"      ALSO    "FILENAME"
               WHEN    "CLICKED"       ALSO    "FILENAME"
                   PERFORM T-000-NAMECHEK-SEC
               WHEN    "CLICKED"       ALSO    "CHKBTN1"
               WHEN    "CLICKED"       ALSO    "CHKBTN2"
               WHEN    "CLICKED"       ALSO    "CHKBTN3"
               WHEN    "CLICKED"       ALSO    "CHKBTN4"
               WHEN    "CLICKED"       ALSO    "CHKBTN5"
               WHEN    "CLICKED"       ALSO    "CHKBTN6"
               WHEN    "CLICKED"       ALSO    "CHKBTN7"
               WHEN    "CLICKED"       ALSO    "CHKBTN8"
               WHEN    "CLICKED"       ALSO    "CHKBTN9"
               WHEN    "CLICKED"       ALSO    "CHKBTN10"
               WHEN    "CLICKED"       ALSO    "CHKBTN11"
               WHEN    "CLICKED"       ALSO    "CHKBTN12"
               WHEN    "CLICKED"       ALSO    "CHKBTN13"
               WHEN    "CLICKED"       ALSO    "CHKBTN14"
               WHEN    "CLICKED"       ALSO    "CHKBTN15"
               WHEN    "CLICKED"       ALSO    "CHKBTN16"
               WHEN    "CLICKED"       ALSO    "CHKBTN17"
               WHEN    "CLICKED"       ALSO    "CHKBTN18"
               WHEN    "CLICKED"       ALSO    "CHKBTN19"
               WHEN    "CLICKED"       ALSO    "CHKBTN20"
               WHEN    "CLICKED"       ALSO    "CHKBTN21"
               WHEN    "CLICKED"       ALSO    "CHKBTN22"
               WHEN    "CLICKED"       ALSO    "CHKBTN23"
               WHEN    "CLICKED"       ALSO    "CHKBTN24"
               WHEN    "CLICKED"       ALSO    "CHKBTN25"
               WHEN    "CLICKED"       ALSO    "CHKBTN26"
               WHEN    "CLICKED"       ALSO    "CHKBTN27"
               WHEN    "CLICKED"       ALSO    "CHKBTN28"
               WHEN    "CLICKED"       ALSO    "CHKBTN29"
               WHEN    "CLICKED"       ALSO    "CHKBTN30"
               WHEN    "CLICKED"       ALSO    "CHKBTN31"
               WHEN    "CLICKED"       ALSO    "CHKBTN32"
               WHEN    "CLICKED"       ALSO    "CHKBTN33"
               WHEN    "CLICKED"       ALSO    "CHKBTN34"
               WHEN    "CLICKED"       ALSO    "CHKBTN35"
               WHEN    "CLICKED"       ALSO    "CHKBTN36"
               WHEN    "CLICKED"       ALSO    "CHKBTN37"
               WHEN    "CLICKED"       ALSO    "CHKBTN38"
               WHEN    "CLICKED"       ALSO    "CHKBTN39"
               WHEN    "CLICKED"       ALSO    "CHKBTN40"
               WHEN    "CLICKED"       ALSO    "CHKBTN41"
               WHEN    "CLICKED"       ALSO    "CHKBTN42"
               WHEN    "CLICKED"       ALSO    "CHKBTN43"
               WHEN    "CLICKED"       ALSO    "CHKBTN44"
               WHEN    "CLICKED"       ALSO    "CHKBTN45"
               WHEN    "CLICKED"       ALSO    "CHKBTN46"
               WHEN    "CLICKED"       ALSO    "CHKBTN47"
               WHEN    "CLICKED"       ALSO    "CHKBTN48"
               WHEN    "CLICKED"       ALSO    "CHKBTN49"
               WHEN    "CLICKED"       ALSO    "CHKBTN50"
               WHEN    "CLICKED"       ALSO    "CHKBTN51"
               WHEN    "CLICKED"       ALSO    "CHKBTN52"
               WHEN    "CLICKED"       ALSO    "CHKBTN53"
               WHEN    "CLICKED"       ALSO    "CHKBTN54"
               WHEN    "CLICKED"       ALSO    "CHKBTN55"
               WHEN    "CLICKED"       ALSO    "CHKBTN56"
               WHEN    "CLICKED"       ALSO    "CHKBTN57"
               WHEN    "CLICKED"       ALSO    "CHKBTN58"
               WHEN    "CLICKED"       ALSO    "CHKBTN59"
               WHEN    "CLICKED"       ALSO    "CHKBTN60"
                   PERFORM T-000-CLICKED-SEC
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
               WHEN    "ACTIVATE"      ALSO    "FILENAME"
                   PERFORM T-000-NAMECHEK-SEC
               WHEN    "ACTIVATE"      ALSO    "CHKBTN1"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN2"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN3"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN4"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN5"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN6"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN7"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN8"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN9"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN10"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN11"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN12"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN13"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN14"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN15"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN16"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN17"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN18"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN19"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN20"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN21"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN22"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN23"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN24"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN25"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN26"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN27"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN28"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN29"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN30"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN31"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN32"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN33"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN34"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN35"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN36"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN37"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN38"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN39"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN40"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN41"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN42"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN43"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN44"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN45"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN46"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN47"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN48"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN49"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN50"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN51"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN52"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN53"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN54"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN55"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN56"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN57"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN58"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN59"
               WHEN    "ACTIVATE"      ALSO    "CHKBTN60"
                   PERFORM T-000-CLICKED-SEC
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
           MOVE    "F01"               TO  SPA-MOTOPG.
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
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF.
      *
           MOVE    SPACE           TO  LINKAREA.
           MOVE    "CURRENT"       TO  MCP-PUTTYPE.
           MOVE    "F01"           TO  MCP-WINDOW.
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
           MOVE    SPACE                 TO  F01.
      *
           MOVE    SPA-GMN-FILE-ID       TO  F01-FILENAME.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    SPA-GMN-MAX-A
               MOVE    SPA-GMN-MSG (IDX1)   TO  F01-CHKMSG  (IDX1)
               MOVE    SPA-GMN-BTN (IDX1)   TO  F01-CHKBTN  (IDX1)
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
           IF      MCP-WIDGET       =   "FILENAME"
               MOVE    1                              TO  SPA-GMN-CUR
           END-IF.
      *
           IF      SPA-GMN-CUR > 60
               MOVE    "B12"                          TO  MCP-WIDGET
           ELSE
               MOVE    WK-TBL-MSG-3 (SPA-GMN-CUR)     TO  MCP-WIDGET
           END-IF.
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
               WHEN    OTHER
                   MOVE    SPACE               TO  SPA-ERRMSG
           END-EVALUATE.
      *
           MOVE    SPACE               TO  FERR.
           MOVE    SPA-ERRCD           TO  F01-ERRCODE.
           MOVE    SPA-ERRMSG          TO  F01-ERRMSG.
           MOVE    "B01"               TO  MCP-WIDGET.
      *
           MOVE    "F01"               TO  SPA-MOTOPG.
           MOVE    "FERR"              TO  SPA-SAKIPG.
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "FERR"              TO  MCP-WINDOW.
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
           MOVE    "ORCBSF1"          TO  JOB-SHELLID.
           MOVE    ALL "*"            TO  JOB-TERMID.
           CALL    "ORCSJOB"          USING
                                      WRK-JOBKANRI-AREA  
                                      JOBKANRI-REC.
           MOVE    SPACE              TO  FID2.
           MOVE    ZERO               TO  SPA-GMN-RUN.
           IF  WRK-JOBKANRI-RETURN   =   ZERO
               IF  JOB-ENDYMD            =   SPACE
                   MOVE    "7777"             TO  FID2-ID2CODE
                   MOVE    T-MESSAGE-01       TO  FID2-ID2MSG
                   MOVE    1                  TO  SPA-GMN-RUN
               ELSE
                   IF  MCP-WIDGET             =   "B13"
                       MOVE    "8888"             TO  FID2-ID2CODE
                       MOVE    T-MESSAGE-02       TO  FID2-ID2MSG(1:32)
                       MOVE    JOB-ENDTIME(1:2)   TO  FID2-ID2MSG(33:2)
                       MOVE    "時"               TO  FID2-ID2MSG(35:2)
                       MOVE    JOB-ENDTIME(3:2)   TO  FID2-ID2MSG(37:2)
                       MOVE    "分"               TO  FID2-ID2MSG(39:2)
                       MOVE    T-MESSAGE-03       TO  FID2-ID2MSG(41:16)
                       MOVE    2                  TO  SPA-GMN-RUN
                   END-IF
               END-IF
               IF  MCP-WIDGET   =   "B01"   OR   "B13"
                   MOVE    "F01"               TO  SPA-MOTOPG
                   MOVE    "FID2"              TO  SPA-SAKIPG
                   MOVE    "NEW"               TO  MCP-PUTTYPE
                   MOVE    "FID2"              TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                   TO  FLG-END
               END-IF
           END-IF.
      *
           IF  MCP-WIDGET             =   "B12"
               IF  SPA-GMN-RUN        NOT =   1
                   MOVE    "1001"                TO  FID1-ID1CODE
                   MOVE    T-MESSAGE-05          TO  FID1-ID1MSG
                   MOVE    "F01"                 TO  SPA-MOTOPG
                   MOVE    "FID1"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "FID1"                TO  MCP-WINDOW
               ELSE
                   MOVE    "F01"                 TO  SPA-MOTOPG
                   MOVE    "FID2"                TO  SPA-SAKIPG
                   MOVE    "NEW"                 TO  MCP-PUTTYPE
                   MOVE    "FID2"                TO  MCP-WINDOW
               END-IF
               MOVE    SPA-AREA              TO  SPA-COMMON
               MOVE    SPA-F01               TO  SPA-FREE
               PERFORM 900-PUT-WINDOW
               MOVE    1                     TO  FLG-END
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
           MOVE    "F01"               TO  SPA-MOTOPG.
           MOVE    "XB01"              TO  SPA-SAKIPG.
           INITIALIZE                  SPA-KYOTUKEY.
           INITIALIZE                  SPA-WORK.
           MOVE    "ORCBSF1"           TO  SPA-JOB-SHELLID.
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE    SPA-F01-AREA        TO  LNK-SCRSPA.
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
           CALL   "ORCMCPSUB"                   USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイル名確認 処理
      *****************************************************************
       T-000-NAMECHEK-SEC                SECTION.
      *
           MOVE    F01-FILENAME            TO  SPA-GMN-FILE-ID.
      *
       T-000-NAMECHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェックボタンクリック 処理
      *****************************************************************
       T-000-CLICKED-SEC                 SECTION.
      *
           MOVE    61                TO  SPA-GMN-CUR.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    60
               IF  MCP-WIDGET  =  WK-TBL-MSG-3 (IDX1)
                   EVALUATE    SPA-GMN-BTN (IDX1)
                       WHEN    "T"
                               MOVE    "F"
                                       TO  SPA-GMN-BTN (IDX1)
                               COMPUTE  SPA-GMN-MAX-B
                                        = SPA-GMN-MAX-B - 1
                       WHEN    OTHER
                               MOVE    "T"
                                       TO  SPA-GMN-BTN (IDX1)
                               COMPUTE  SPA-GMN-MAX-B
                                        =  SPA-GMN-MAX-B  +  1
                   END-EVALUATE
                   COMPUTE  IDX2 = IDX1 + 1
                   PERFORM VARYING IDX3  FROM  IDX2  BY 1
                           UNTIL   IDX3  >    60
                           IF  SPA-GMN-MSG (IDX3)  NOT =  SPACE
                               MOVE    IDX3
                                       TO  SPA-GMN-CUR
                               MOVE    61
                                       TO  IDX3
                           END-IF
                   END-PERFORM
                   MOVE    61                          TO  IDX1
               END-IF
           END-PERFORM.
      *
       T-000-CLICKED-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル バックアップ処理
      *****************************************************************
       T-000-WRITABLE-SEC                SECTION.
      *
           IF      SPA-GMN-MAX-A = SPA-GMN-MAX-B
      *修正/*開始*02.09.13*********************************************
      *         MOVE    "orcbsf02.sh"     TO  SHELL-SHELL
               INITIALIZE                    ORCSMKPASSAREA
               MOVE    "scripts/allways/orcbsf02.sh"
                                         TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"      USING  ORCSMKPASSAREA
               MOVE    MKPASS-OT-01      TO  SHELL-NAME
      *修正/*終了*02.09.13*********************************************
               MOVE    "ALL-TABLE"       TO  SHELL-T-NAME
               MOVE    "ALL-TABLE"       TO  SHELL-C-NAME
               MOVE    "ALL-TABLE"       TO  SHELL-W-NAME
               MOVE    SPA-GMN-FILE-ID   TO  SHELL-O-NAME
               MOVE    "0"               TO  SHELL-KBEN
               MOVE    SHELL-NAME        TO  SHELLTBL-NAME
               MOVE    SHELL-ARG1        TO  SHELLTBL-ARG1
               MOVE    SHELL-ARG2        TO  SHELLTBL-ARG2
               MOVE    SHELL-ARG3        TO  SHELLTBL-ARG3
               MOVE    SHELL-ARG4        TO  SHELLTBL-ARG4
               MOVE    SHELL-ARG5        TO  SHELLTBL-ARG5
               MOVE    SHELL-ARG6        TO  SHELLTBL-ARG6
               MOVE    SHELLTBL          TO  MCPDATA-REC
               MOVE    "SHELL"           TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL  TO  MCP-PATH
               CALL    "MCPSUB"          USING
                                         MCPAREA
                                         MCPDATA-REC
           ELSE
               MOVE    SPACE             TO  SHELL-KBEN
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >    SPA-GMN-MAX-A
                   IF      SPA-GMN-BTN (IDX1) = "T"
      *修正/*開始*02.09.13*********************************************
      *                 MOVE    "orcbsf01.sh"       TO  SHELL-SHELL
                       INITIALIZE                  ORCSMKPASSAREA
                       MOVE    "scripts/allways/orcbsf01.sh"
                                                   TO  MKPASS-IN-01
                       CALL    "ORCSMKPASS"        USING  ORCSMKPASSAREA
                       MOVE    MKPASS-OT-01        TO  SHELL-NAME
      *修正/*終了*02.09.13*********************************************
                       MOVE    WK-TBL-MSG-2 (IDX1) TO  SHELL-T-NAME
                       MOVE    "CNV-TABLE"         TO  SHELL-C-NAME
                       MOVE    "OUT-TABLE-WK"      TO  SHELL-W-NAME
                       MOVE    SPA-GMN-FILE-ID     TO  SHELL-O-NAME
                       IF      SHELL-KBEN = SPACE
                           MOVE    "0"                TO  SHELL-KBEN
                       ELSE
                           MOVE    "1"                TO  SHELL-KBEN
                       END-IF
                       MOVE    SHELL-NAME        TO  SHELLTBL-NAME
                       MOVE    SHELL-ARG1        TO  SHELLTBL-ARG1
                       MOVE    SHELL-ARG2        TO  SHELLTBL-ARG2
                       MOVE    SHELL-ARG3        TO  SHELLTBL-ARG3
                       MOVE    SHELL-ARG4        TO  SHELLTBL-ARG4
                       MOVE    SHELL-ARG5        TO  SHELLTBL-ARG5
                       MOVE    SHELL-ARG6        TO  SHELLTBL-ARG6
                       MOVE    SHELLTBL          TO  MCPDATA-REC
                       MOVE    "SHELL"           TO  MCP-FUNC
                       MOVE    PATH-SHELL-SHELL  TO  MCP-PATH
                       CALL    "MCPSUB"          USING
                                                 MCPAREA
                                                 MCPDATA-REC
                   END-IF
               END-PERFORM
      *修正/*開始*02.09.13*********************************************
      *         MOVE    "orcbsf03.sh"     TO  SHELL-SHELL
               INITIALIZE                ORCSMKPASSAREA
               MOVE    "scripts/allways/orcbsf03.sh"
                                         TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"      USING  ORCSMKPASSAREA
               MOVE    MKPASS-OT-01      TO  SHELL-NAME
      *修正/*終了*02.09.13*********************************************
               MOVE    "OUT-TABLE-WK"    TO  SHELL-T-NAME
               MOVE    "OUT-TABLE-WK"    TO  SHELL-C-NAME
               MOVE    "OUT-TABLE-WK"    TO  SHELL-W-NAME
               MOVE    SPA-GMN-FILE-ID   TO  SHELL-O-NAME
               MOVE    "1"               TO  SHELL-KBEN
               MOVE    SHELL-NAME        TO  SHELLTBL-NAME
               MOVE    SHELL-ARG1        TO  SHELLTBL-ARG1
               MOVE    SHELL-ARG2        TO  SHELLTBL-ARG2
               MOVE    SHELL-ARG3        TO  SHELLTBL-ARG3
               MOVE    SHELL-ARG4        TO  SHELLTBL-ARG4
               MOVE    SHELL-ARG5        TO  SHELLTBL-ARG5
               MOVE    SHELL-ARG6        TO  SHELLTBL-ARG6
               MOVE    SHELLTBL          TO  MCPDATA-REC
               MOVE    "SHELL"           TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL  TO  MCP-PATH
               CALL    "MCPSUB"          USING
                                         MCPAREA
                                         MCPDATA-REC
           END-IF.
      *
       T-000-WRITABLE-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル名称 セット処理
      *****************************************************************
       T-000-SETTABLE-SEC                SECTION.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    SPA-GMN-MAX-A
               MOVE    WK-TBL-MSG-1 (IDX1) TO  SPA-GMN-MSG (IDX1)
               MOVE    "F"                 TO  SPA-GMN-BTN (IDX1)
           END-PERFORM.
      *
           COMPUTE  IDX2 = SPA-GMN-MAX-A + 1.
      *
           PERFORM VARYING IDX1  FROM  IDX2  BY 1
                   UNTIL   IDX1  >    60
               MOVE    SPACE               TO  SPA-GMN-MSG (IDX1)
               MOVE    SPACE               TO  SPA-GMN-BTN (IDX1)
           END-PERFORM.
      *
       T-000-SETTABLE-EXT.
           EXIT.
      *
      *****************************************************************
      *    バックアップ条件 入力処理
      *****************************************************************
       T-000-READCHEK-SEC                SECTION.
      *
           MOVE    ZERO              TO  SPA-GMN-MAX-B.
           MOVE    "ORCF00.CNV"      TO  FIF00PARA-FILE.
           MOVE    1                 TO  SPA-GMN-CUR.
      *
           OPEN    INPUT                   FIF00-FILE.
      *
           IF      STS-FIF00 = ZERO
               READ    FIF00-FILE
                       NOT  AT  END
                            PERFORM VARYING IDX1  FROM  1  BY 1
                                    UNTIL   IDX1  >    60
                                MOVE    SPACE
                                        TO  SPA-GMN-BTN (IDX1)
                                IF  (FIF00-REC(IDX1:1)      = "*")
                                AND (SPA-GMN-MSG (IDX1) NOT = SPACE)
                                    MOVE    "T"
                                            TO  SPA-GMN-BTN (IDX1)
                                    COMPUTE  SPA-GMN-MAX-B
                                             = SPA-GMN-MAX-B + 1
                                END-IF
                            END-PERFORM
                            MOVE    FIF00-REC(62:128)
                                   TO  SPA-GMN-FILE-ID
               END-READ
               CLOSE                           FIF00-FILE
           END-IF.
      *
       T-000-READCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    バックアップ条件 出力処理
      *****************************************************************
       T-000-READWRIT-SEC                SECTION.
      *
           OPEN    OUTPUT                  FIF00-FILE.
      *
           MOVE    SPACE               TO  FIF00-REC.
      *
           PERFORM VARYING IDX1  FROM  1  BY 1
                   UNTIL   IDX1  >    SPA-GMN-MAX-A
               IF  SPA-GMN-BTN (IDX1)   =   "T"
                   MOVE    "*"                 TO  FIF00-REC(IDX1:1)
               END-IF
           END-PERFORM.
           MOVE    SPA-GMN-FILE-ID     TO  FIF00-REC(62:128).
      *
           WRITE   FIF00-REC.
      *
           CLOSE                           FIF00-FILE.
      *
       T-000-READWRIT-EXT.
           EXIT.
      *
