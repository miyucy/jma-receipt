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
       PROGRAM-ID.                 ORCGM96.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 業務選択
      *  コンポーネント名  : ジョブ管理検索（Ｍ９６）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/05    ひさなが      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    ひさなが     02/06/06  日付表示を更新日が空白なら
      *                                     新規作成日表示に変更
      *
      *  01.00.02    太田         04/02/03  MCPAREAの初期化を削除
      *  01.00.03    NACL-伊藤    04/02/05  M97の追加
      *  01.00.04    NACL-多々納  05/04/04  マスタ更新管理情報の分割
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
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    スパ領域
           COPY    "M00COMMON-SPA".
      *
       01  SPA-M96.
           03  SPA-M96-AREA.
               05  SPA-GMN-KBN         PIC X(03).
               05  SPA-GMN-MAX         PIC 9(04).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-TBLG1.
                       09  SPA-GMN-TBL1    OCCURS  2.
                           11  SPA-GMN-VERSION        PIC  X(64).
                           11  SPA-GMN-DBSVERSION1    PIC  X(64).
                           11  SPA-GMN-DBSVERSION2    PIC  X(64).
                           11  SPA-GMN-CREYMD         PIC  X(09).
                   07  SPA-GMN-TBLG3.
                       09  SPA-GMN-TBL3    OCCURS  99.
                           11  SPA-GMN-MASTNAME       PIC  X(30).
                           11  SPA-GMN-DBRVERSION1    PIC  X(64).
                           11  SPA-GMN-DBRVERSION2    PIC  X(64).
                       09  SPA-GMN-MAX3               PIC 9(04).
                   07  SPA-GMN-TBLG2.
                       09  SPA-GMN-TBL2    OCCURS  2.
                           11  SPA-GMN-STARTYMD       PIC  X(09).
                           11  SPA-GMN-STARTTIME      PIC  X(08).
                           11  SPA-GMN-ENDYMD         PIC  X(09).
                           11  SPA-GMN-ENDTIME        PIC  X(08).
                           11  SPA-GMN-STEPSTARTTIME  PIC  X(08).
                           11  SPA-GMN-STEPENDTIME    PIC  X(08).
      *
                           11  SPA-NAI-ENDYMD         PIC  X(08).
                           11  SPA-NAI-ENDTIME        PIC  X(08).
                   07  SPA-GMN-SELNO2         PIC 9(04).
                   07  SPA-GMN-MSG1-STYLE     PIC X(05).
                   07  SPA-GMN-MSG1           PIC X(62).
      *
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-DBKANRI         PIC 9(01).
           03  FLG-JOBKANRI        PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-INIT            PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX2                PIC 9(02).
           03  ID1                 PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
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
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "CPMKPASS.INC".
      *
       01  SHELL-AREA.
           03  SHELL-NAME          PIC X(33)  VALUE
               "scripts/allways/master_upgrade.sh".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
           COPY  "CPORCSDAY.INC".
           COPY  "CPORCSLNK.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ管理
       01  DBKANRI-REC.
           COPY    "CPDBKANRI.INC".
      *
      *    ジョブ管理
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "ORCA-DBPATH".
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
           COPY    "M00.INC".
           COPY    "M01.INC".
           COPY    "M01N.INC".
           COPY    "M02.INC". 
           COPY    "M95.INC".
           COPY    "M96.INC".
           COPY    "M97.INC".
           COPY    "MERR.INC".
           COPY    "MID1.INC".
           COPY    "MVER.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
                                               MCPAREA
                                               SPAAREA
                                               LINKAREA
                                               SCRAREA.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-M00KYOUTU
           MOVE    SPA-FREE        TO  SPA-M96
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"          ALSO    "CLICKED"
                   PERFORM 200-GMNSENI
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
           MOVE    SPA-M00KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-M96             TO  SPA-FREE
           .
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "MERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
      *        画面編集
               IF      FLG-END             =   ZERO
                   PERFORM 500-GMNHEN-SEC
               END-IF
           END-IF
      *
           IF      FLG-END             =   ZERO
               MOVE   "NEW"                TO  MCP-PUTTYPE
               MOVE   "M96"                TO  MCP-WINDOW
      *
               PERFORM 900-PUT-WINDOW
      *
               MOVE    1                   TO  FLG-END
           END-IF
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    内部画面より
           EVALUATE    SPA-MOTOPG
               WHEN    "MID1"
      *            確認画面より
                   PERFORM 30010-MID1-SET-SEC
                   MOVE    SPACE               TO  SPA-MIDCD
               WHEN    OTHER
                   MOVE    SPA-MOTOPG          TO  SPA-NAI-MOTOPG
                   MOVE    SPACE               TO  SPA-MIDCD
                   PERFORM 310-SPASET-SEC
           END-EVALUATE
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＭＩＤ１）ＯＫ処理
      *****************************************************************
       30010-MID1-SET-SEC          SECTION.
      *
           EVALUATE    SPA-MIDCD
               WHEN    "0101"
      *            削除処理
                   IF      SPA-MID1-FLG        =   "OK"
                       PERFORM 30011-DELETE-SYORI-SEC
                   END-IF
               WHEN    "0202"
      *            マスタ更新処理
                   IF      SPA-MID1-FLG        =   "OK"
                       PERFORM 30012-KOUSIN-SYORI-SEC
                   END-IF
               WHEN    "0301"
      *            終了処理
                   IF      SPA-MID1-FLG        =   "OK"
                       PERFORM 2001-BACK-SYORI-SEC
                   END-IF
           END-EVALUATE
           MOVE    SPACE               TO  SPA-MID1-FLG
           .
       30010-MID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           MOVE    1                   TO  FLG-INIT
           INITIALIZE                  SPA-GMN-AREA
      *    最新情報編集
           PERFORM 310-DBHENSYU-SEC
      *
      *    最新から初期へ
           MOVE    SPA-GMN-VERSION (2)
                                        TO  SPA-GMN-VERSION     (1)
           MOVE    SPA-GMN-DBSVERSION1 (2)
                                        TO  SPA-GMN-DBSVERSION1 (1)
           MOVE    SPA-GMN-DBSVERSION2 (2)
                                        TO  SPA-GMN-DBSVERSION2 (1)
           MOVE    SPA-GMN-CREYMD  (2)
                                        TO  SPA-GMN-CREYMD      (1)
      *
           MOVE    SPA-GMN-STARTYMD     (2)
                                       TO  SPA-GMN-STARTYMD      (1)
           MOVE    SPA-GMN-ENDYMD       (2)
                                       TO  SPA-GMN-ENDYMD        (1)
           MOVE    SPA-GMN-STARTTIME    (2)
                                       TO  SPA-GMN-STARTTIME     (1)
           MOVE    SPA-GMN-ENDTIME      (2)
                                       TO  SPA-GMN-ENDTIME       (1)
           MOVE    SPA-GMN-STEPSTARTTIME(2)
                                       TO  SPA-GMN-STEPSTARTTIME (1)
           MOVE    SPA-GMN-STEPENDTIME  (2)
                                       TO  SPA-GMN-STEPENDTIME   (1)
      *
           MOVE    SPA-NAI-ENDYMD (2)  TO  SPA-NAI-ENDYMD  (1)
           MOVE    SPA-NAI-ENDTIME(2)  TO  SPA-NAI-ENDTIME (1)
      *
           MOVE    1                   TO  SPA-GMN-CUR
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ最新情報編集
      *****************************************************************
       310-DBHENSYU-SEC              SECTION.
      *
           INITIALIZE                  SPA-GMN-TBLG3
      *    ＤＢ管理検索処理
           INITIALIZE                  DBKANRI-REC
           MOVE    DBKANRI-REC         TO  MCPDATA-REC
           MOVE    PATH-TBL-DBKANRI-ALL 
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               PERFORM 900-DBKANRI-READ-SEC
           ELSE
               INITIALIZE                      DBKANRI-REC
               MOVE    1                   TO  FLG-DBKANRI
           END-IF
           PERFORM UNTIL   FLG-DBKANRI     =   1
      *
               EVALUATE    DBKANRI-KANRICD
                   WHEN    "ORCADB00"
                       PERFORM 3101-LIST1-HENSYU-SEC
               END-EVALUATE
               IF      DBKANRI-KANRICD(7:2)    NUMERIC
                   PERFORM 3102-LIST3-HENSYU-SEC
               END-IF
               MOVE    PATH-TBL-DBKANRI-ALL    TO  MCP-PATH
               PERFORM 900-DBKANRI-READ-SEC
           END-PERFORM
           MOVE    PATH-TBL-DBKANRI-ALL    TO  MCP-PATH
           PERFORM 990-DBCLOSE-SEC
      *
      *    ＪＯＢ管理検索
           PERFORM 820-JOBKANRI-READ-SEC
      *
           PERFORM 3103-JOBKANRI-HENSYU2-SEC
      *
           IF      FLG-INIT             =   ZERO
               MOVE    SPACE                TO  SPA-GMN-MSG1
               MOVE    1                    TO  ID1
           ELSE
               MOVE    "前回処理分"         TO  SPA-GMN-MSG1
               MOVE    11                   TO  ID1
           END-IF
           IF      SJOBKANRI-RETURN    =   ZERO
               IF      JOB-ERRCD(1:2)   =   "99"
                   MOVE    "マスタ更新は異常終了しました。"
                                           TO  SPA-GMN-MSG1(ID1:30)
                   MOVE    "red"           TO  SPA-GMN-MSG1-STYLE
               ELSE
                   IF  JOB-ERRCD(1:2)   =   "01"
                       MOVE    "更新データはありませんでした。"
                                             TO  SPA-GMN-MSG1(ID1:30)
                       MOVE    "blue"        TO  SPA-GMN-MSG1-STYLE
                   ELSE
                       IF  (JOB-ENDTIME       NOT =   SPACE)  AND
                           (JOB-ENDYMD        NOT =   SPACE)
                           MOVE    "マスタ更新は正常に終了しました。"
                                                TO  SPA-GMN-MSG1(ID1:32)
                           MOVE    "blue"       TO  SPA-GMN-MSG1-STYLE
                       ELSE
                           MOVE    "マスタ更新中です。"
                                                TO  SPA-GMN-MSG1(ID1:18)
                           MOVE    "blue"       TO  SPA-GMN-MSG1-STYLE
                       END-IF
                   END-IF
               END-IF
           ELSE
               MOVE    SPACE           TO  SPA-GMN-MSG1
           END-IF
           .
       310-DBHENSYU-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ管理情報編集処理
      *****************************************************************
       3101-LIST1-HENSYU-SEC         SECTION.
      *
           MOVE    2                   TO  IDX
           MOVE    DBKANRI-VERSION     TO  SPA-GMN-VERSION     (IDX)
           MOVE    DBKANRI-DBSVERSION1 TO  SPA-GMN-DBSVERSION1 (IDX)
           MOVE    DBKANRI-DBSVERSION2 TO  SPA-GMN-DBSVERSION2 (IDX)
           IF      DBKANRI-UPYMD       =   SPACE
               MOVE    DBKANRI-CREYMD      TO  WRK-SYMD
           ELSE
               MOVE    DBKANRI-UPYMD       TO  WRK-SYMD
           END-IF
           PERFORM 700-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-CREYMD   (IDX)
           .
       3101-LIST1-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    マスタ管理情報編集処理
      *****************************************************************
       3102-LIST3-HENSYU-SEC         SECTION.
      *
           MOVE    DBKANRI-KANRICD(7:2)    TO  IDX2
           ADD     1                       TO  IDX2
      *
           ADD     1                   TO  SPA-GMN-MAX3
           MOVE    DBKANRI-DBRVERSION1 TO  SPA-GMN-DBRVERSION1 (IDX2)
           MOVE    DBKANRI-DBRVERSION2 TO  SPA-GMN-DBRVERSION2 (IDX2)
      *
           EVALUATE    DBKANRI-KANRICD
               WHEN    "ORCADB00"
                   MOVE    "点数マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB01"
                   MOVE    "保険番号マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB02"
                   MOVE    "システム管理マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB03"
                   MOVE    "病名マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB04"
                   MOVE    "チェックマスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB05"
                   MOVE    "一般老人置換マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB06"
                   MOVE    "検査分類マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB07"
                   MOVE    "相互作用マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB08"
                   MOVE    "症状措置マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB09"
                   MOVE    "保険者マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    "ORCADB10"
                   MOVE    "住所マスタ"
                                          TO  SPA-GMN-MASTNAME(IDX2)
               WHEN    OTHER
                   MOVE    DBKANRI-KANRICD
                                          TO  SPA-GMN-MASTNAME(IDX2)
           END-EVALUATE
           .
       3102-LIST3-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理情報編集処理
      *****************************************************************
       3103-JOBKANRI-HENSYU2-SEC         SECTION.
      *
           MOVE    JOB-STARTYMD        TO  WRK-SYMD
           PERFORM 700-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-STARTYMD (2)
      *
           MOVE    JOB-ENDYMD          TO  SPA-NAI-ENDYMD  (2)
           MOVE    JOB-ENDTIME         TO  SPA-NAI-ENDTIME (2)
      *
           MOVE    JOB-ENDYMD          TO  WRK-SYMD
           PERFORM 700-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-ENDYMD (2)
      *
           IF      JOB-STARTTIME       =   SPACE
               MOVE    SPACE           TO  SPA-GMN-STARTTIME (2)
           ELSE
               MOVE    ":"             TO  SPA-GMN-STARTTIME (2)(3:1)
               MOVE    ":"             TO  SPA-GMN-STARTTIME (2)(6:1)
               MOVE    JOB-STARTTIME(1:2)
                                       TO  SPA-GMN-STARTTIME (2)(1:2)
               MOVE    JOB-STARTTIME(3:2)
                                       TO  SPA-GMN-STARTTIME (2)(4:2)
               MOVE    JOB-STARTTIME(5:2)
                                       TO  SPA-GMN-STARTTIME (2)(7:2)
           END-IF.
           IF      JOB-ENDTIME         =   SPACE
               MOVE    SPACE           TO  SPA-GMN-ENDTIME (2)
           ELSE
               MOVE    ":"             TO  SPA-GMN-ENDTIME (2)(3:1)
               MOVE    ":"             TO  SPA-GMN-ENDTIME (2)(6:1)
               MOVE    JOB-ENDTIME(1:2)
                                       TO  SPA-GMN-ENDTIME (2)(1:2)
               MOVE    JOB-ENDTIME(3:2)
                                       TO  SPA-GMN-ENDTIME (2)(4:2)
               MOVE    JOB-ENDTIME(5:2)
                                       TO  SPA-GMN-ENDTIME (2)(7:2)
           END-IF
           IF     JOB-STEPSTARTTIME    =   SPACE
               MOVE    SPACE           TO  SPA-GMN-STEPSTARTTIME (2)
           ELSE
               MOVE    ":"          TO  SPA-GMN-STEPSTARTTIME (2)(3:1)
               MOVE    ":"          TO  SPA-GMN-STEPSTARTTIME (2)(6:1)
               MOVE    JOB-STEPSTARTTIME(1:2)
                                    TO  SPA-GMN-STEPSTARTTIME (2)(1:2)
               MOVE    JOB-STEPSTARTTIME(3:2)
                                    TO  SPA-GMN-STEPSTARTTIME (2)(4:2)
               MOVE    JOB-STEPSTARTTIME(5:2)
                                    TO  SPA-GMN-STEPSTARTTIME (2)(7:2)
           END-IF
           IF      JOB-STEPENDTIME     =   SPACE
               MOVE    SPACE           TO  SPA-GMN-STEPENDTIME (2)
           ELSE
               MOVE    ":"          TO  SPA-GMN-STEPENDTIME (2)(3:1)
               MOVE    ":"          TO  SPA-GMN-STEPENDTIME (2)(6:1)
               MOVE    JOB-STEPENDTIME(1:2)
                                    TO  SPA-GMN-STEPENDTIME (2)(1:2)
               MOVE    JOB-STEPENDTIME(3:2)
                                    TO  SPA-GMN-STEPENDTIME (2)(4:2)
               MOVE    JOB-STEPENDTIME(5:2)
                                    TO  SPA-GMN-STEPENDTIME (2)(7:2)
           END-IF.
           .
       3103-JOBKANRI-HENSYU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        終了
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        情報削除
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 201-DELETE-SEC
      *        情報
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 211-JYOUKYOU-SEC
      *        更新
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 212-UPDATE-SEC
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    情報削除　処理
      *****************************************************************
       201-DELETE-SEC                  SECTION.
      *
      *    ＪＯＢ管理検索
           PERFORM 820-JOBKANRI-READ-SEC
      *
           IF      SJOBKANRI-RETURN    =   ZERO
               MOVE    "0101"              TO  SPA-MIDCD
           ELSE
               MOVE    "0005"              TO  SPA-ERRCD
           END-IF
           .
       201-DELETE-EXT.
           EXIT.
     *
      *****************************************************************
      *    状況処理
      *****************************************************************
       211-JYOUKYOU-SEC                  SECTION.
      *
           MOVE    ZERO                TO  FLG-INIT
      *    最新情報編集
           PERFORM 310-DBHENSYU-SEC
           MOVE    1                   TO  SPA-GMN-CUR
           .
       211-JYOUKYOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    マスタ更新　処理
      *****************************************************************
       212-UPDATE-SEC             SECTION.
      *
      *    ＪＯＢ管理検索
           PERFORM 820-JOBKANRI-READ-SEC
      *
           MOVE    ZERO                 TO  FLG-ERR
           IF      SJOBKANRI-RETURN     =   ZERO
               IF      JOB-ERRCD(1:2)       =   "99"
                                            OR  "01" 
                   CONTINUE
               ELSE
                   IF      (JOB-ENDTIME       NOT =   SPACE)  AND
                           (JOB-ENDYMD        NOT =   SPACE)
                       CONTINUE
                   ELSE
                       MOVE    1                TO  FLG-ERR
                   END-IF
               END-IF
           END-IF
      *
           IF      FLG-ERR             =   1
               MOVE    "0203"              TO  SPA-ERRCD
           ELSE
               MOVE    "0202"              TO  SPA-MIDCD
           END-IF.
      *
       212-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    マスタ更新処理
      *****************************************************************
       30012-KOUSIN-SYORI-SEC                  SECTION.
      *
           PERFORM 820-JOBKANRI-READ-SEC
      *
           IF      SJOBKANRI-RETURN    =   ZERO
      *        ジョブ管理削除
               MOVE    "DEL"               TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    1                   TO  JOB-JOBID
               MOVE    "MSTMNT"            TO  JOB-SHELLID
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
      *    ジョブ管理作成
           MOVE    "JBS"               TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    1                   TO  JOB-JOBID
           MOVE    "MSTMNT"            TO  JOB-SHELLID
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
      *    最新情報編集
           MOVE    ZERO                TO  FLG-INIT
           PERFORM 310-DBHENSYU-SEC
           MOVE    1                   TO  SPA-GMN-CUR
      *    マスタ更新処理
           MOVE    SPACE                TO  SHELLTBL
           INITIALIZE                   ORCSMKPASSAREA
           MOVE    SHELL-NAME           TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"         USING  ORCSMKPASSAREA
           MOVE    MKPASS-OT-01         TO  SHELLTBL-NAME
           MOVE    SHELLTBL             TO  MCPDATA-REC
      *
           MOVE    "SHELL"              TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL     TO  MCP-PATH
           CALL    "MCPSUB"             USING
                                        MCPAREA
                                        MCPDATA-REC
      *
           .
      *
       30012-KOUSIN-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       30011-DELETE-SYORI-SEC                  SECTION.
      *
           PERFORM 820-JOBKANRI-READ-SEC
      *
           IF      SJOBKANRI-RETURN    =   ZERO
               IF      (JOB-ENDTIME    =   SPA-NAI-ENDTIME(2)) AND
                       (JOB-ENDYMD     =   SPA-NAI-ENDYMD (2))
      *    ジョブ管理削除
                   MOVE    "DEL"          TO  SJOBKANRI-MODE
                   INITIALIZE             JOBKANRI-REC
                   MOVE    1              TO  JOB-JOBID
                   MOVE    "MSTMNT"       TO  JOB-SHELLID
                   CALL    "ORCSJOB"      USING
                                          ORCSJOBKANRIAREA
                                          JOBKANRI-REC
                   INITIALIZE             SPA-GMN-TBLG2
                   MOVE    SPACE          TO  SPA-GMN-MSG1
               ELSE
                   MOVE    "0004"         TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       30011-DELETE-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           PERFORM 820-JOBKANRI-READ-SEC
      *
           MOVE    SPACE                TO  SPA-MIDCD
           IF      SJOBKANRI-RETURN     =   ZERO
               IF      JOB-ERRCD(1:2)       =   "99"
                                            OR  "01"
                   CONTINUE
               ELSE
                   IF      (JOB-ENDTIME       NOT =   SPACE)  AND
                           (JOB-ENDYMD        NOT =   SPACE)
                       CONTINUE
                   ELSE
      *            マスタ更新中
                       MOVE    "0301"              TO  SPA-MIDCD
                   END-IF
               END-IF
           END-IF
           IF      SPA-MIDCD           =   SPACE
               PERFORM 2001-BACK-SYORI-SEC
           END-IF
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       2001-BACK-SYORI-SEC             SECTION.
      *
           IF      SPA-NAI-MOTOPG(1:3) =   "M01"
               MOVE    SPA-NAI-MOTOPG      TO  SPA-SAKIPG
           ELSE
               MOVE    "M01"               TO  SPA-SAKIPG
           END-IF
      *
           MOVE    "M96"               TO  SPA-MOTOPG
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
           MOVE    "JOIN"              TO  MCP-PUTTYPE
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       2001-BACK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦和暦編集処理
      *****************************************************************
       700-SEIWA-HEN-SEC             SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"
                                       OR   SPACE
               MOVE    SPACE               TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF.
      *
       700-SEIWA-HEN-EXT.
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
           END-IF
           IF     (SPA-ERRCD           =   SPACE )  AND
                  (SPA-MIDCD       NOT =   SPACE )
               PERFORM 520-MIDSET-SEC
           END-IF
      *
           IF      FLG-END             =   ZERO
               MOVE    SPACE               TO  LINKAREA
               MOVE    "CURRENT"           TO  MCP-PUTTYPE
               MOVE    "M96"               TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
           END-IF
           .
      *
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面内容編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE              M96.
      *
           PERFORM VARYING   IDX   FROM   1   BY   1
                   UNTIL     IDX      >   2
               MOVE    SPA-GMN-VERSION       (IDX) TO  M96-VERSION (IDX)
               MOVE    SPA-GMN-DBSVERSION1   (IDX) TO  M96-DBSVERSION1
                                                                  (IDX)
               MOVE    SPA-GMN-DBSVERSION2   (IDX) TO  M96-DBSVERSION2
                                                                  (IDX)
               MOVE    SPA-GMN-CREYMD        (IDX) TO  M96-CREYMD (IDX)
               MOVE    SPA-GMN-STARTYMD      (IDX) TO  M96-STARTYMD
                                                                  (IDX)
               MOVE    SPA-GMN-STARTTIME     (IDX) TO  M96-STARTTIME
                                                                  (IDX)
               MOVE    SPA-GMN-ENDYMD        (IDX) TO  M96-ENDYMD (IDX)
               MOVE    SPA-GMN-ENDTIME       (IDX) TO  M96-ENDTIME(IDX)
               MOVE    SPA-GMN-STEPSTARTTIME (IDX) TO  M96-STEPSTARTTIME
                                                                  (IDX)
               MOVE    SPA-GMN-STEPENDTIME   (IDX) TO  M96-STEPENDTIME
                                                                  (IDX)
           END-PERFORM
           MOVE    2                   TO  M96-LIST1-COUNT
           MOVE    2                   TO  M96-LIST2-COUNT
      *
           PERFORM VARYING   IDX   FROM   1   BY   1
                   UNTIL     IDX      >   SPA-GMN-MAX3
               MOVE    SPA-GMN-MASTNAME    (IDX) TO  M96-MASTNAME (IDX)
               MOVE    SPA-GMN-DBRVERSION1 (IDX) TO  M96-DBRVERSION1
                                                                  (IDX)
               MOVE    SPA-GMN-DBRVERSION2 (IDX) TO  M96-DBRVERSION2
                                                                  (IDX)
           END-PERFORM
           MOVE    SPA-GMN-MAX3        TO  M96-LIST3-COUNT
      *
           MOVE    SPA-GMN-MSG1            TO  M96-MSG1-VALUE
           MOVE    SPA-GMN-MSG1-STYLE      TO  M96-MSG1-STYLE
      *
           PERFORM 5001-MAPCUR-SEC
           .
      *
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
                   MOVE    "B12"               TO  MCP-WIDGET
           END-EVALUATE
           .
      *
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
            EVALUATE    SPA-ERRCD
                WHEN    "0001"
                    MOVE    "入力エラー"
                                                TO  SPA-ERRMSG
                WHEN    "0203"
                    MOVE    "マスタ更新は実行中です。"
                                                TO  SPA-ERRMSG
                WHEN    "0003"
                    MOVE    "対象が１００件以上あります"
                                                TO  SPA-ERRMSG
                WHEN    "0004"
                    MOVE    "更新処理が実行中の為、削除できません"
                                                TO  SPA-ERRMSG
                WHEN    "0005"
                    MOVE    "ＪＯＢ管理情報は、ありません"
                                                TO  SPA-ERRMSG
                WHEN    OTHER
                    MOVE    SPACE               TO  SPA-ERRMSG
            END-EVALUATE.
      *
           MOVE    SPACE                TO  MERR
           MOVE    SPA-ERRCD            TO  MERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  MERR-ERRMSG
      *
           MOVE    "B01"               TO  MCP-WIDGET.
           MOVE    "M96"               TO  SPA-MOTOPG.
           MOVE    "MERR"              TO  SPA-SAKIPG.
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "MERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
      *
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認メッセージ表示理
      *****************************************************************
       520-MIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  MID1
           EVALUATE    SPA-MIDCD
               WHEN    "0101"
                   MOVE
                   "ＪＯＢ管理情報を削除します。よろしいですか？"
                                       TO  MID1-ID1MSG
               WHEN    "0202"
                   MOVE    "マスタ更新を実行します。よろしいですか？"
                                       TO  MID1-ID1MSG
               WHEN    "0301"
                   MOVE    "マスタ更新中です。よろしいですか？"
                                       TO  MID1-ID1MSG
               WHEN    OTHER
                   MOVE    SPA-MIDCD
                                       TO  MID1-ID1MSG
           END-EVALUATE
      *
           MOVE    SPA-MIDCD           TO  MID1-ID1CODE
      *
           MOVE    "B12"               TO  MCP-WIDGET
           EVALUATE    SPA-MIDCD
               WHEN    "0101"
                   MOVE    "B01"               TO  MCP-WIDGET
           END-EVALUATE
      *
           MOVE    "M96"               TO  SPA-MOTOPG
           MOVE    "MID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "MID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-MIDSET-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理読込
      *****************************************************************
       820-JOBKANRI-READ-SEC     SECTION.
      *
      *    ＪＯＢ管理 
           INITIALIZE                  ORCSJOBKANRIAREA
           MOVE    "CHK"               TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    1                   TO  JOB-JOBID
           MOVE    "MSTMNT"            TO  JOB-SHELLID
      *
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
           IF      SJOBKANRI-RETURN    NOT =   ZERO
               INITIALIZE                  JOBKANRI-REC
           END-IF
      *    日付の再編集
           IF     (JOB-ENDYMD      NOT =   SPACE)  AND
                  (JOB-ENDYMD(7:2)     =   SPACE)
               MOVE    "20"               TO  WRK-SYMD(1:2)
               MOVE    JOB-ENDYMD(1:6)    TO  WRK-SYMD(3:6)
               MOVE    WRK-SYMD           TO  JOB-ENDYMD
           END-IF
           IF     (JOB-STARTYMD    NOT =   SPACE)  AND
                  (JOB-STARTYMD(7:2)   =   SPACE)
               MOVE    "20"               TO  WRK-SYMD(1:2)
               MOVE    JOB-STARTYMD(1:6)  TO  WRK-SYMD(3:6)
               MOVE    WRK-SYMD           TO  JOB-STARTYMD
           END-IF
      *
           .
       820-JOBKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ管理読込み処理
      *****************************************************************
       900-DBKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  DBKANRI-REC
               MOVE    ZERO            TO  FLG-DBKANRI
           ELSE
               INITIALIZE                  DBKANRI-REC
               MOVE    1               TO  FLG-DBKANRI
           END-IF
      *
           .
       900-DBKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    ZERO            TO  MCP-RC
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクロース処理
      *****************************************************************
       990-DBCLOSE-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       990-DBCLOSE-EXT.
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
