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
      *    マスタ更新シェル領域 
           COPY    "CPCOMMONSHELLMST.INC".
      *
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "ORCA-DBPATH".
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
                           11  SPA-GMN-DBRVERSION1    PIC  X(64).
                           11  SPA-GMN-DBRVERSION2    PIC  X(64).
                           11  SPA-GMN-CREYMD         PIC  X(09).
                   07  SPA-GMN-SELNO1         PIC 9(04).
                   07  SPA-GMN-TBLG2.
                       09  SPA-GMN-TBL2    OCCURS  2.
                           11  SPA-GMN-STARTYMD       PIC  X(09).
                           11  SPA-GMN-STARTTIME      PIC  X(08).
                           11  SPA-GMN-ENDYMD         PIC  X(09).
                           11  SPA-GMN-ENDTIME        PIC  X(08).
                           11  SPA-GMN-STEPSTARTTIME  PIC  X(08).
                           11  SPA-GMN-STEPENDTIME    PIC  X(08).
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
      *
      *    処理区分領域
       01  SKBN-AREA.
           03  SKBN-SYU1           PIC X(03).
           03  SKBN-SYU2           PIC X(03).
           03  SKBN-SYU3           PIC X(03).
           03  SKBN-IDCODE         PIC X(04).
           03  SKBN-RUN            PIC X(03).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
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
       01  WRK-HIKAKU-AREA.
           03  WRK-ENDYMD         PIC  X(09).
           03  WRK-ENDTIME        PIC  X(08).
      *
       01  WRK-JOBKANRI-AREA.
           03  WRK-JOBKANRI-MODE   PIC X(03). 
           03  WRK-JOBKANRI-RETURN PIC S9(03).
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
           COPY  "CPORCSDAY.INC".
           COPY  "CPORCSLNK.INC".
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
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-WORK        TO  SPA-M00KYOUTU.
           IF  SPA-FREE(1:3)   =   "M96"
               MOVE    SPA-FREE        TO  SPA-M96
           END-IF.
      *
           MOVE    SPACE           TO  SPA-ERRCD.
           MOVE    SPACE           TO  SKBN-SYU2.
           MOVE    ZERO            TO  FLG-END.
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
           IF  FLG-END   =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           IF  SKBN-SYU2    =   "END"
               PERFORM 830-GAMENN-SET1-SEC
           END-IF.
      *
           MOVE    SPA-M00KYOUTU   TO  SPA-WORK.
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-M96         TO  SPA-FREE.
      *
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
           INITIALIZE                  FLG-AREA.
           INITIALIZE                  WRK-AREA.
      *
      *    エラー画面より
           IF  SPA-MOTOPG   =   "MERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 202-DISPLAY-SEC
               PERFORM 500-GMNHEN-SEC
           ELSE
      *    確認画面より
               IF  SPA-MOTOPG     =   "MID1"
                   MOVE    SPACE              TO  SPA-MOTOPG
                   IF  SPA-MID1-FLG   =   "OK"
                       MOVE    "RUN"              TO  SKBN-SYU3
                       PERFORM 300-SCREEN-SEC
                       PERFORM 500-GMNHEN-SEC
                   ELSE
                       PERFORM 820-JOBKANRI-READ1-SEC
                       IF  WRK-JOBKANRI-RETURN   =   ZERO
                           PERFORM 202-DISPLAY-SEC
                       ELSE
                           INITIALIZE             SPA-GMN-TBLG2
                           MOVE    SPACE          TO  SPA-GMN-MSG1
                           MOVE    SPACE          TO  SPA-GMN-MSG1-STYLE
                           MOVE    SPACE          TO  SKBN-RUN
                           MOVE    1              TO  SPA-GMN-CUR
                           MOVE    2              TO  SPA-GMN-MAX
                       END-IF
                       PERFORM 500-GMNHEN-SEC
                   END-IF
               ELSE
                   MOVE    SPACE               TO  SPA-MOTOPG
                   INITIALIZE                  SPA-M96
                   MOVE    SPACE               TO  SKBN-SYU1
                   MOVE    SPACE               TO  SKBN-SYU3
                   PERFORM 202-DISPLAY-SEC
                   PERFORM 500-GMNHEN-SEC
               END-IF
           END-IF.
      *
           IF  SPA-ERRCD   =   "0004"
               PERFORM 502-ERRSET-SEC
           ELSE
               PERFORM 830-GAMENN-SET2-SEC
           END-IF.
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF  LINKAREA   NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF.
      *
           PERFORM 310-SPASET-SEC.
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
           IF  (SPA-GMN-KBN    =   "M96")   AND
               (SKBN-SYU1      =   "DEL")   AND
               (SKBN-IDCODE    =   "0201")
               IF  SPA-MID1-FLG   =   "OK"
                   PERFORM 820-JOBKANRI-READ1-SEC
      *
                   IF  (JOB-ENDYMD    NOT =   SPACE)  AND
                       (JOB-ENDYMD(7:2)   =   SPACE)
                       MOVE    "20"               TO  WRK-SYMD(1:2)
                       MOVE    JOB-ENDYMD(1:6)    TO  WRK-SYMD(3:6)
                   ELSE
                       MOVE    JOB-ENDYMD         TO  WRK-SYMD
                   END-IF
                   PERFORM 700-SEIWA-HEN-SEC
                   MOVE    WRK-HENYMDG        TO  WRK-ENDYMD
                   IF  JOB-ENDTIME   =   SPACE
                       MOVE    JOB-ENDTIME        TO  WRK-ENDTIME
                   ELSE
                       MOVE    ":"                TO  WRK-ENDTIME(3:1)
                       MOVE    ":"                TO  WRK-ENDTIME(6:1)
                       MOVE    JOB-ENDTIME(1:2)   TO  WRK-ENDTIME(1:2)
                       MOVE    JOB-ENDTIME(3:2)   TO  WRK-ENDTIME(4:2)
                       MOVE    JOB-ENDTIME(5:2)   TO  WRK-ENDTIME(7:2)
                   END-IF
      *
                   IF  WRK-JOBKANRI-RETURN   =   ZERO
                       IF  (WRK-ENDTIME   =   SPA-GMN-ENDTIME (2)) AND
                           (WRK-ENDYMD    =   SPA-GMN-ENDYMD (2))
      *    ジョブ管理削除
                           MOVE    "DEL"          TO  WRK-JOBKANRI-MODE
                           INITIALIZE             JOBKANRI-REC
                           MOVE    1              TO  JOB-JOBID
                           MOVE    "MSTMNT"       TO  JOB-SHELLID
                           CALL    "ORCSJOB"      USING
                                                  WRK-JOBKANRI-AREA
                                                  JOBKANRI-REC
                           INITIALIZE             SPA-GMN-TBLG2
                           MOVE    SPACE          TO  SPA-GMN-MSG1
                           MOVE    SPACE          TO  SKBN-RUN
                       ELSE
                           MOVE    "0004"         TO  SPA-ERRCD
                       END-IF
                   END-IF
               END-IF
           END-IF.
      *
           IF  (SPA-GMN-KBN    =   "M96")   AND
               (SKBN-SYU1      =   "UPD")   AND
               (SKBN-IDCODE    =   "0202")
               MOVE    SPACE           TO  SPA-GMN-KBN
               PERFORM 202-DISPLAY-SEC
               PERFORM 820-JOBKANRI-READ2-SEC
               IF  (SPA-MID1-FLG   =   "OK")   AND
                   (SKBN-RUN       =   SPACE)
                   PERFORM 203-UPDATE-2-SEC
                   MOVE    "RUN"           TO  SKBN-RUN
               END-IF
           END-IF.
      *
           IF  (SPA-GMN-KBN    =   "M96")   AND
               (SKBN-SYU1      =   "END")
               MOVE    "END"               TO  SKBN-SYU2
               MOVE    1                   TO  FLG-END
           END-IF.
      *
           MOVE    SPACE           TO  SPA-MID1-FLG.
           MOVE    SPACE           TO  SKBN-SYU1.
           MOVE    SPACE           TO  MID1-ID1CODE.
           MOVE    SPACE           TO  SKBN-IDCODE.
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
      *        終了
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        情報削除
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 201-DELETE-SEC
      *        情報
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 820-JOBKANRI-READ2-SEC
                   IF  SKBN-RUN       =   "RUN"
                       MOVE    "RUN"           TO  SKBN-SYU3
                   END-IF
                   PERFORM 202-DISPLAY-SEC
      *        更新
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 203-UPDATE-1-SEC
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
           PERFORM 820-JOBKANRI-READ1-SEC.
      *
           IF  WRK-JOBKANRI-RETURN   =   ZERO
      *
               MOVE    "0201"              TO  SKBN-IDCODE
               MOVE    SPACE               TO  MID1
               MOVE    "0201"              TO  MID1-ID1CODE
               MOVE    "ＪＯＢ管理情報を削除します。よろしいですか？"
                                           TO  MID1-ID1MSG
               MOVE    "DEL"               TO  SKBN-SYU1
               PERFORM 830-GAMENN-SET3-SEC
           ELSE
               MOVE    "0005"              TO  SPA-ERRCD
           END-IF.
      *
       201-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理検索処理
      *****************************************************************
       2011-KANRI-HEN-SEC         SECTION.
      *
           INITIALIZE                  DBKANRI-REC.
           MOVE    "ORCADB00"          TO  DBKANRI-KANRICD.
      *
           MOVE    DBKANRI-REC         TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "DBKANRI-KEY"       TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           IF  MCP-RC   =   ZERO
               PERFORM 810-KANRI-READ1-SEC
               IF  MCP-RC   =   ZERO
                   MOVE    MCPDATA-REC     TO  DBKANRI-REC
                   PERFORM 2012-KANRI-HENSYU1-SEC
               END-IF
           END-IF.
      *    カーソルクロース
           INITIALIZE                  MCPAREA.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "DBKANRI-KEY"       TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "CHK"               TO  WRK-JOBKANRI-MODE.
           INITIALIZE                  JOBKANRI-REC.
           MOVE    1                   TO  JOB-JOBID.
           MOVE    "MSTMNT"            TO  JOB-SHELLID.
      *
           CALL    "ORCSJOB"           USING
                                       WRK-JOBKANRI-AREA
                                       JOBKANRI-REC.
           IF  MCP-RC   NOT =   ZERO
               INITIALIZE                  JOBKANRI-REC
           END-IF.
           PERFORM 2012-KANRI-HENSYU2-SEC.
      *
       2011-KANRI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理編集処理
      *****************************************************************
       2012-KANRI-HENSYU1-SEC         SECTION.
      *
           MOVE    DBKANRI-VERSION     TO  SPA-GMN-VERSION     (2).
           MOVE    DBKANRI-DBSVERSION1 TO  SPA-GMN-DBSVERSION1 (2).
           MOVE    DBKANRI-DBSVERSION2 TO  SPA-GMN-DBSVERSION2 (2).
           MOVE    DBKANRI-DBRVERSION1 TO  SPA-GMN-DBRVERSION1 (2).
           MOVE    DBKANRI-DBRVERSION2 TO  SPA-GMN-DBRVERSION2 (2).
      *修正/*開始*02.06.06*********************************************
      *     IF  (DBKANRI-CREYMD    NOT =   SPACE)  AND
      *         (DBKANRI-CREYMD(7:2)   =   SPACE)
      *         MOVE    "20"                TO  WRK-SYMD(1:2)
      *         MOVE    DBKANRI-CREYMD(1:6) TO  WRK-SYMD(3:6)
      *     ELSE
      *         MOVE    DBKANRI-CREYMD      TO  WRK-SYMD
      *     END-IF.
           IF  DBKANRI-UPYMD    =   SPACE
               IF  (DBKANRI-CREYMD    NOT =   SPACE)  AND
                   (DBKANRI-CREYMD(7:2)   =   SPACE)
                   MOVE    "20"                TO  WRK-SYMD(1:2)
                   MOVE    DBKANRI-CREYMD(1:6) TO  WRK-SYMD(3:6)
               ELSE
                   MOVE    DBKANRI-CREYMD      TO  WRK-SYMD
               END-IF
           ELSE
               IF  DBKANRI-UPYMD(7:2)   =   SPACE
                   MOVE    "20"                TO  WRK-SYMD(1:2)
                   MOVE    DBKANRI-UPYMD(1:6)  TO  WRK-SYMD(3:6)
               ELSE
                   MOVE    DBKANRI-UPYMD       TO  WRK-SYMD
               END-IF
           END-IF.
      *修正/*終了*02.06.06*********************************************
           PERFORM 700-SEIWA-HEN-SEC.
           MOVE    WRK-HENYMDG         TO  SPA-GMN-CREYMD      (2).
      *
       2012-KANRI-HENSYU1-EXT.
           EXIT.
      *
      **********
      *
       2012-KANRI-HENSYU2-SEC         SECTION.
      *
           IF  (JOB-STARTYMD    NOT =   SPACE)  AND
               (JOB-STARTYMD(7:2)   =   SPACE)
               MOVE    "20"              TO  WRK-SYMD(1:2)
               MOVE    JOB-STARTYMD(1:6) TO  WRK-SYMD(3:6)
           ELSE
               MOVE    JOB-STARTYMD      TO  WRK-SYMD
           END-IF.
           PERFORM 700-SEIWA-HEN-SEC.
           MOVE    WRK-HENYMDG       TO  SPA-GMN-STARTYMD (2).
           IF  (JOB-ENDYMD    NOT =   SPACE)  AND
               (JOB-ENDYMD(7:2)   =   SPACE)
               MOVE    "20"              TO  WRK-SYMD(1:2)
               MOVE    JOB-ENDYMD(1:6)   TO  WRK-SYMD(3:6)
           ELSE
               MOVE    JOB-ENDYMD        TO  WRK-SYMD
           END-IF.
           PERFORM 700-SEIWA-HEN-SEC.
           MOVE    WRK-HENYMDG       TO  SPA-GMN-ENDYMD (2).
           IF  JOB-STARTTIME   =   SPACE
               MOVE    JOB-STARTTIME  TO  SPA-GMN-STARTTIME (2)
           ELSE
               MOVE    ":"            TO  SPA-GMN-STARTTIME (2)(3:1)
               MOVE    ":"            TO  SPA-GMN-STARTTIME (2)(6:1)
               MOVE    JOB-STARTTIME(1:2)
                                      TO  SPA-GMN-STARTTIME (2)(1:2)
               MOVE    JOB-STARTTIME(3:2)
                                      TO  SPA-GMN-STARTTIME (2)(4:2)
               MOVE    JOB-STARTTIME(5:2)
                                      TO  SPA-GMN-STARTTIME (2)(7:2)
           END-IF.
           IF  JOB-ENDTIME   =   SPACE
               MOVE    JOB-ENDTIME    TO  SPA-GMN-ENDTIME (2)
           ELSE
               MOVE    ":"            TO  SPA-GMN-ENDTIME (2)(3:1)
               MOVE    ":"            TO  SPA-GMN-ENDTIME (2)(6:1)
               MOVE    JOB-ENDTIME(1:2)
                                      TO  SPA-GMN-ENDTIME (2)(1:2)
               MOVE    JOB-ENDTIME(3:2)
                                      TO  SPA-GMN-ENDTIME (2)(4:2)
               MOVE    JOB-ENDTIME(5:2)
                                      TO  SPA-GMN-ENDTIME (2)(7:2)
           END-IF.
           IF  JOB-STEPSTARTTIME   =   SPACE
               MOVE    JOB-STEPSTARTTIME TO  SPA-GMN-STEPSTARTTIME (2)
           ELSE
               MOVE    ":"          TO  SPA-GMN-STEPSTARTTIME (2)(3:1)
               MOVE    ":"          TO  SPA-GMN-STEPSTARTTIME (2)(6:1)
               MOVE    JOB-STEPSTARTTIME(1:2)
                                    TO  SPA-GMN-STEPSTARTTIME (2)(1:2)
               MOVE    JOB-STEPSTARTTIME(3:2)
                                    TO  SPA-GMN-STEPSTARTTIME (2)(4:2)
               MOVE    JOB-STEPSTARTTIME(5:2)
                                    TO  SPA-GMN-STEPSTARTTIME (2)(7:2)
           END-IF.
           IF  JOB-STEPENDTIME   =   SPACE
               MOVE    JOB-STEPENDTIME TO  SPA-GMN-STEPENDTIME (2)
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
      *
       2012-KANRI-HENSYU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    状況表示　処理
      *****************************************************************
       202-DISPLAY-SEC             SECTION.
      *
           PERFORM 2011-KANRI-HEN-SEC.
      *
           IF  SPA-GMN-KBN    NOT =   "M96"
               MOVE    "M96"            TO  SPA-GMN-KBN
               MOVE    SPA-GMN-VERSION     (2)
                                        TO  SPA-GMN-VERSION     (1)
               MOVE    SPA-GMN-DBSVERSION1 (2)
                                        TO  SPA-GMN-DBSVERSION1 (1)
               MOVE    SPA-GMN-DBSVERSION2 (2)
                                        TO  SPA-GMN-DBSVERSION2 (1)
               MOVE    SPA-GMN-DBRVERSION1 (2)
                                        TO  SPA-GMN-DBRVERSION1 (1)
               MOVE    SPA-GMN-DBRVERSION2 (2)
                                        TO  SPA-GMN-DBRVERSION2 (1)
               MOVE    SPA-GMN-CREYMD      (2)
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
           END-IF.
           IF  SKBN-SYU3   =   "RUN"
               MOVE    SPACE            TO  SPA-GMN-MSG1
               MOVE    1                TO  ID1
           ELSE
               MOVE    "前回処理分"     TO  SPA-GMN-MSG1
               MOVE    11               TO  ID1
           END-IF.
      *
           MOVE    1                   TO  SPA-GMN-CUR.
           MOVE    2                   TO  SPA-GMN-MAX.
      *
           PERFORM 820-JOBKANRI-READ1-SEC.
           IF  WRK-JOBKANRI-RETURN   =   ZERO
               IF  JOB-ERRCD(1:2)   =   "99"
                   MOVE    SPACE           TO  SKBN-RUN
                   MOVE    "マスタ更新は異常終了しました。"
                                           TO  SPA-GMN-MSG1(ID1:30)
                   MOVE    "red"           TO  SPA-GMN-MSG1-STYLE
               ELSE
                   IF  JOB-ERRCD(1:2)   =   "01"
                       MOVE    SPACE         TO  SKBN-RUN
                       MOVE    "更新データはありませんでした。"
                                             TO  SPA-GMN-MSG1(ID1:30)
                       MOVE    "blue"        TO  SPA-GMN-MSG1-STYLE
                   ELSE
                       IF  (JOB-ENDTIME       NOT =   SPACE)  AND
                           (JOB-ENDYMD        NOT =   SPACE)
                           MOVE    SPACE        TO  SKBN-RUN
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
           END-IF.
      *
       202-DISPLAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    マスタ更新　処理
      *****************************************************************
       203-UPDATE-1-SEC             SECTION.
      *
           PERFORM 820-JOBKANRI-READ2-SEC.
      *
           IF  SKBN-RUN   =   "RUN"
               MOVE    SPACE               TO  MERR
               MOVE    "0203"              TO  MERR-ERRCODE
               MOVE    "マスタ更新は実行中です。"
                                           TO  MERR-ERRMSG
               MOVE    "UPD"               TO  SKBN-SYU1
               PERFORM 830-GAMENN-SET4-SEC
           ELSE
               MOVE    "0202"              TO  SKBN-IDCODE
               MOVE    SPACE               TO  MID1
               MOVE    "0202"              TO  MID1-ID1CODE
               MOVE    "マスタ更新を実行します。よろしいですか？"
                                           TO  MID1-ID1MSG
               MOVE    "UPD"               TO  SKBN-SYU1
               PERFORM 830-GAMENN-SET5-SEC
           END-IF.
      *
       203-UPDATE-1-EXT.
           EXIT.
      *
      **********
      *
       203-UPDATE-2-SEC             SECTION.
      *
           PERFORM 820-JOBKANRI-READ1-SEC.
      *
           IF  WRK-JOBKANRI-RETURN   =   ZERO
      *     ジョブ管理削除
               MOVE    "DEL"               TO  WRK-JOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    1                   TO  JOB-JOBID
               MOVE    "MSTMNT"            TO  JOB-SHELLID
               CALL    "ORCSJOB"           USING
                                           WRK-JOBKANRI-AREA
                                           JOBKANRI-REC
           END-IF.
      *
      *    ジョブ管理作成
           MOVE    "JBS"               TO  WRK-JOBKANRI-MODE.
           INITIALIZE                  JOBKANRI-REC.
           MOVE    1                   TO  JOB-JOBID.
           MOVE    "MSTMNT"            TO  JOB-SHELLID.
           CALL    "ORCSJOB"           USING
                                       WRK-JOBKANRI-AREA
                                       JOBKANRI-REC.
      *
           INITIALIZE                  SPA-M96.
           MOVE    "UPD"               TO  SKBN-SYU1.
           PERFORM 202-DISPLAY-SEC.
      *    マスタ更新処理
           MOVE    "master_upgrade.sh" TO  SHELL-SHELL.
      *
           MOVE    SPACE               TO  SHELLTBL.
           MOVE    SHELL-NAME          TO  SHELLTBL-NAME.
           MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1.
           MOVE    SHELL-ARG2          TO  SHELLTBL-ARG2.
           MOVE    SHELL-ARG3          TO  SHELLTBL-ARG3.
           MOVE    SHELL-ARG4          TO  SHELLTBL-ARG4.
           MOVE    SHELLTBL            TO  MCPDATA-REC.
      *
           MOVE    "SHELL"             TO  MCP-FUNC.
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH.
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
       203-UPDATE-2-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           PERFORM 820-JOBKANRI-READ1-SEC.
      *
           IF  WRK-JOBKANRI-RETURN   =   ZERO
               IF  JOB-ERRCD(1:2)   =   "99"
                   PERFORM 830-GAMENN-SET6-SEC
               ELSE
                   IF  JOB-ERRCD(1:2)   =   "01"
                       PERFORM 830-GAMENN-SET6-SEC
                   ELSE
                       IF  (JOB-ENDTIME       NOT =   SPACE)  AND
                           (JOB-ENDYMD        NOT =   SPACE)
                           PERFORM 830-GAMENN-SET6-SEC
                       ELSE
                           MOVE    "0301"              TO  SKBN-IDCODE
                           MOVE    SPACE               TO  MID1
                           MOVE    "0301"              TO  MID1-ID1CODE
                           MOVE    "マスタ更新中です。よろしいですか？"
                                                       TO  MID1-ID1MSG
                           MOVE    "END"               TO  SKBN-SYU1
                           PERFORM 830-GAMENN-SET5-SEC
                       END-IF
                   END-IF
               END-IF
           ELSE
               PERFORM 830-GAMENN-SET6-SEC
           END-IF.
      *
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦和暦編集処理
      *****************************************************************
       700-SEIWA-HEN-SEC             SECTION.
      *
           IF  WRK-SYMD   =   ALL "9"  OR   SPACE
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
           IF  SPA-ERRCD   NOT =   SPACE
               PERFORM 502-ERRSET-SEC
           ELSE
               PERFORM 500-GMNHEN-SEC
               MOVE    SPACE           TO  LINKAREA
               MOVE    "CURRENT"       TO  MCP-PUTTYPE
               MOVE    "M96"           TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
           END-IF.
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
      *
               MOVE    SPA-GMN-VERSION       (IDX) TO  M96-VALUE11 (IDX)
               MOVE    SPA-GMN-DBSVERSION1   (IDX) TO  M96-VALUE12 (IDX)
               MOVE    SPA-GMN-DBSVERSION2   (IDX) TO  M96-VALUE13 (IDX)
               MOVE    SPA-GMN-DBRVERSION1   (IDX) TO  M96-VALUE14 (IDX)
               MOVE    SPA-GMN-DBRVERSION2   (IDX) TO  M96-VALUE15 (IDX)
               MOVE    SPA-GMN-CREYMD        (IDX) TO  M96-VALUE16 (IDX)
               MOVE    SPA-GMN-STARTYMD      (IDX) TO  M96-VALUE21 (IDX)
               MOVE    SPA-GMN-STARTTIME     (IDX) TO  M96-VALUE22 (IDX)
               MOVE    SPA-GMN-ENDYMD        (IDX) TO  M96-VALUE23 (IDX)
               MOVE    SPA-GMN-ENDTIME       (IDX) TO  M96-VALUE24 (IDX)
               MOVE    SPA-GMN-STEPSTARTTIME (IDX) TO  M96-VALUE25 (IDX)
               MOVE    SPA-GMN-STEPENDTIME   (IDX) TO  M96-VALUE26 (IDX)
           END-PERFORM.
      *
           MOVE    SPA-GMN-MAX             TO  M96-COUNT1.
           MOVE    SPA-GMN-MAX             TO  M96-COUNT2.
      *
           MOVE    SPA-GMN-MSG1            TO  M96-VALUE3.
           MOVE    SPA-GMN-MSG1-STYLE      TO  M96-MSG1-STYLE.
      *
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       502-ERRSET-SEC              SECTION.
      *
            EVALUATE    SPA-ERRCD
                WHEN    "0001"
                    MOVE    "入力エラー"
                                                TO  SPA-ERRMSG
                WHEN    "0002"
                    MOVE    "選択番号が有りません"
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
           MOVE    SPACE                TO  MERR.
           MOVE    SPA-ERRCD            TO  MERR-ERRCODE.
           MOVE    SPA-ERRMSG           TO  MERR-ERRMSG.
      *
           PERFORM 830-GAMENN-SET4-SEC.
      *
       502-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理読込
      *****************************************************************
       810-KANRI-READ1-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           MOVE    "DBKANRI-KEY"       TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
       810-KANRI-READ1-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理読込
      *****************************************************************
       820-JOBKANRI-READ1-SEC     SECTION.
      *
           MOVE    "CHK"           TO  WRK-JOBKANRI-MODE.
           INITIALIZE                  JOBKANRI-REC.
           MOVE    1               TO  JOB-JOBID.
           MOVE    "MSTMNT"        TO  JOB-SHELLID.
           CALL    "ORCSJOB"       USING
                                   WRK-JOBKANRI-AREA
                                   JOBKANRI-REC.
      *
       820-JOBKANRI-READ1-EXT.
           EXIT.
      *
      **********
      *
       820-JOBKANRI-READ2-SEC     SECTION.
      *
           MOVE    "CHK"           TO  WRK-JOBKANRI-MODE.
           INITIALIZE                  JOBKANRI-REC.
           MOVE    1               TO  JOB-JOBID.
           MOVE    "MSTMNT"        TO  JOB-SHELLID.
           CALL    "ORCSJOB"       USING
                                   WRK-JOBKANRI-AREA
                                   JOBKANRI-REC.
      *
           IF  WRK-JOBKANRI-RETURN   =   ZERO
               IF  JOB-ERRCD(1:2)   =   "99"
                   MOVE    SPACE           TO  SKBN-RUN
               ELSE
                   IF  JOB-ERRCD(1:2)   =   "01"
                       MOVE    SPACE         TO  SKBN-RUN
                   ELSE
                       IF  (JOB-ENDTIME       NOT =   SPACE)  AND
                           (JOB-ENDYMD        NOT =   SPACE)
                           MOVE    SPACE        TO  SKBN-RUN
                       ELSE
                           MOVE    "RUN"        TO  SKBN-RUN
                       END-IF
                   END-IF
               END-IF
           ELSE
               MOVE    SPACE        TO  SKBN-RUN
           END-IF.
      *
       820-JOBKANRI-READ2-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面情報セット
      *****************************************************************
       830-GAMENN-SET1-SEC        SECTION.
      *
           MOVE    "M01"               TO  SPA-SAKIPG.
           MOVE    "M96"               TO  SPA-MOTOPG.
           MOVE    SPACE               TO  LINKAREA.
           MOVE    "M01"               TO  MCP-WINDOW.
           MOVE    "JOIN"              TO  MCP-PUTTYPE.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       830-GAMENN-SET1-EXT.
           EXIT.
      *
      **********
      *
       830-GAMENN-SET2-SEC        SECTION.
      *
           MOVE    SPACE               TO  LINKAREA.
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "M96"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       830-GAMENN-SET2-EXT.
           EXIT.
      *
      **********
      *
       830-GAMENN-SET3-SEC        SECTION.
      *
           MOVE    "B01"               TO  MCP-WIDGET.
           MOVE    "M96"               TO  SPA-MOTOPG.
           MOVE    "MID1"              TO  SPA-SAKIPG.
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "MID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       830-GAMENN-SET3-EXT.
           EXIT.
      *
      **********
      *
       830-GAMENN-SET4-SEC        SECTION.
      *
           MOVE    "B01"               TO  MCP-WIDGET.
           MOVE    "M96"               TO  SPA-MOTOPG.
           MOVE    "MERR"              TO  SPA-SAKIPG.
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "MERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       830-GAMENN-SET4-EXT.
           EXIT.
      *
      **********
      *
       830-GAMENN-SET5-SEC        SECTION.
      *
           MOVE    "B12"               TO  MCP-WIDGET.
           MOVE    "M96"               TO  SPA-MOTOPG.
           MOVE    "MID1"              TO  SPA-SAKIPG.
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "MID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       830-GAMENN-SET5-EXT.
           EXIT.
      *
      **********
      *
       830-GAMENN-SET6-SEC        SECTION.
      *
           MOVE    "M01"               TO  SPA-SAKIPG.
           MOVE    "M96"               TO  SPA-MOTOPG.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE    "M01"               TO  MCP-WINDOW.
           MOVE    "JOIN"              TO  MCP-PUTTYPE.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       830-GAMENN-SET6-EXT.
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
