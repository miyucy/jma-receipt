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
       PROGRAM-ID.             ORCGP025.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 各種履歴（Ｐ０２５）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-太田     01/05/11  日付変換後ゼロ表示変更
      *  01.00.02    MCC-多々納   01/06/13  登録後、診療行為遷移を追加
      *  01.00.03    MCC-多々納   01/07/03  日付入力チェックサブ追加
      *  02.00.01    NACL-多々納  02/07/31  パラメタファイルをＤＢへ
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
      *    パラメタデータ
      *    SELECT  PARA-FILE       ASSIGN  FILE-NAME1
      *                            ORGANIZATION    IS  INDEXED
      *                            ACCESS  MODE    IS  DYNAMIC
      *                            RECORD  KEY     IS  PAR-KEY
      *                            FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *    パラメタデータ
      *FD  PARA-FILE.
      *01  PARA-REC.
      *    03  PAR-KEY.
      *        05  PAR-FILEMEI         PIC X(08).
      *        05  PAR-EDANUM          PIC 9(04).
      *    03  PAR-DATA-REC            PIC X(3000).
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    パラメタファイル名
      *01  FILE-NAME1.
      *    03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
      *    03  FILLER              PIC X(07)   VALUE   "P01PARA".
      *    03  FILE-TERMID1        PIC X(32)   VALUE   SPACE.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    患者登録スパ領域
           COPY    "P02COMMON-SPA".
      *    患者画面スパ領域
           COPY    "P02SCR-SPA".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
           03  STS-JYURRK          PIC X(02).
           03  STS-SRYKARRK        PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PARA            PIC 9(01).
           03  FLG-END             PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-SRYKARRK        PIC 9(01).
           03  FLG-KANRIMST        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-SRYKA           PIC X(02).
           03  WRK-ZENYMD          PIC X(08).
           03  WRK-RENBAN          PIC ZZZ9.
           03  WRK-RENNUMZ         PIC ZZZZ.
           03  WRK-IDX             PIC 9(04).
           03  WRK-KYU-MAX         PIC 9(02).
      *
           03  WRK-SELNUM          PIC 9(04).
      *
      *    03  WRK-GMN-KYU-TBL.
      *        05  WRK-GMN-KYU-REC               OCCURS  10.
      *            09  WRK-GMN-KYU-CHGYMDW       PIC X(10).
      *            09  WRK-GMN-KYU-CHGYMD        PIC X(08).
      *            09  WRK-GMN-KYU-KANANAME      PIC X(30).
      *            09  WRK-GMN-KYU-NAME          PIC X(30).
      *            09  WRK-GMN-KYU-NICKNAME      PIC X(20).
      *            09  WRK-GMN-KYU-DELKBN        PIC X(01).
      *
           03  WRK-JYURRK-AREA.
               05  WRK-JYURRK-REC                OCCURS 50.
                   07  WRK-JYURRK-SRYKA          PIC X(02).
                   07  WRK-JYURRK-SRYYMD         PIC X(08).
                   07  WRK-JYURRK-SRYKBN-G.
                       09  WRK-JYURRK-SRYKBN     OCCURS 11  PIC X(02).
      *----(01.00.01) LINE ADD START --------------------------------
           03  WRK-WWYMD           PIC X(10).
      *----(01.00.01) LINE ADD END   --------------------------------
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
      *
           03  WRK-HENTIME.
               05  WRK-THH         PIC 99.
               05  FILLER          PIC X(01)   VALUE  ":".
               05  WRK-TMM         PIC 99.
      *
           03  WRK-HEN-SRYKBN-TBL.
               05  WRK-HEN-SRYKBN-G.
                   07  FILLER      PIC X(08)   VALUE  "01診察  ".
                   07  FILLER      PIC X(08)   VALUE  "02内服  ".
                   07  FILLER      PIC X(08)   VALUE  "03頓服  ".
                   07  FILLER      PIC X(08)   VALUE  "04外用  ".
                   07  FILLER      PIC X(08)   VALUE  "05注射  ".
                   07  FILLER      PIC X(08)   VALUE  "06処置  ".
                   07  FILLER      PIC X(08)   VALUE  "07手術  ".
                   07  FILLER      PIC X(08)   VALUE  "08麻酔  ".
                   07  FILLER      PIC X(08)   VALUE  "09検査  ".
                   07  FILLER      PIC X(08)   VALUE  "10画像  ".
                   07  FILLER      PIC X(08)   VALUE  "11その他".
               05  WRK-HEN-SRYKBN-R   REDEFINES   WRK-HEN-SRYKBN-G.
                   07  WRK-HEN-SRYKBN-REC      OCCURS  11.
                       09  WRK-HEN-SRYKBN  PIC X(02).
                       09  WRK-HEN-SRYNAME PIC X(06).
      *
       01  WRK-HENKAN-AREA.
           03  WRK-MAE-INPUT       PIC X(400).
           03  WRK-ATO-INPUT       PIC X(400).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    診療科目情報
           COPY    "CPSK1005.INC".
      *
      *    診療科履歴
       01  SRYKARRK-REC.
           COPY    "CPSRYKARRK.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
       01  LNK-KYUSEIRRK-AREA.
           02  LNK-KYUSEIRRK-REC          OCCURS   10.
           COPY    "CPKYUSEIRRK.INC"
                              REPLACING  //KYUSEI// BY //LNK-KYU//.
      **********************  REPLACING  //KYUSEI-// BY //LNK-KYU-//.
      *        変更前の開始日・終了日（更新時使用）
      *        03  LNK-KYU-KEY-O.
      *            05  LNK-KYU-HOSPID-O       PIC X(24).
      *            05  LNK-KYU-PTID-O         PIC 9(10).
      *            05  LNK-KYU-CHGYMD-O       PIC X(08).
      *
      *
      *    パラメタテーブル
       01  PARA-REC.
           COPY    "CPPARA.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   数字変換領域
           COPY    "CPORCSNUM.INC".
      *----(01.00.03) LINE ADD START ----------------------------------
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *----(01.00.03) LINE ADD END   ----------------------------------
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
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "P02.INC".
           COPY    "P02A.INC".
      *****COPY    "P02B.INC".
      *****COPY    "P02C.INC".
           COPY    "P02D.INC".
           COPY    "P02E.INC".
           COPY    "P02F.INC".
           COPY    "P014.INC".
           COPY    "P98.INC".
           COPY    "P981.INC".
           COPY    "P99.INC".
           COPY    "P0201.INC".
           COPY    "P982.INC".
           COPY    "P100.INC".
           COPY    "PERR.INC".
           COPY    "PID1.INC".
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
           MOVE    SPA-FREE        TO  SPA-P02SCRAREA
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  SPA-FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"         ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
           IF      SPA-FLG-END         =   ZERO
      *
               PERFORM 5001-MAPCUR-SEC
      *********PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-P02SCRAREA  TO  SPA-FREE
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
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
      *    初期画面編集
           PERFORM 300-SCREEN-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    パラメタファイル検索処理
      *****PERFORM 320-PARAFILE-KENSAKU-SEC
      *
           MOVE    SPA-WORK        TO  SPA-P02KYOUTU
      *
      *    初期画面編集
           PERFORM 310-SPASET-SEC
      *
           MOVE    1       TO  SPA-GMN25-CUR
      *
           .
       3OO-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタファイル検索処理
      *****************************************************************
      *320-PARAFILE-KENSAKU-SEC             SECTION.
      *
      *    パラメタファイルより編集
      *    MOVE    ZERO                TO  FLG-PARA
      *    MOVE    SPA-TERMID          TO  FILE-TERMID1
      *    OPEN    INPUT                   PARA-FILE
      *    INITIALIZE                      PAR-KEY
      *    START   PARA-FILE
      *        KEY IS    >=   PAR-KEY
      *        INVALID
      *            MOVE    1           TO  FLG-PARA
      *        NOT INVALID
      *            PERFORM 990-PARA-NEXT-SEC
      *    END-START
      *
      *    MOVE    ZERO            TO  SPA-NAI25-KYU-MAX
      *    MOVE    ZERO            TO  SPA-NAI25-EDA-MAX
      *
      *    PERFORM    UNTIL   ( FLG-PARA        =   1 )
      *        EVALUATE    PAR-FILEMEI
      *        WHEN    "KYUSEI"
      *            IF  PAR-EDANUM             <=  10
      *                MOVE    PAR-DATA-REC    TO  LNK-KYUSEIRRK-REC
      *                                                (PAR-EDANUM)
      *                MOVE    PAR-EDANUM      TO  SPA-NAI25-KYU-MAX
      *                MOVE    PAR-EDANUM      TO  SPA-NAI25-EDA-MAX
      *            ELSE
      *                DISPLAY "P025*<320> KYU-TBL 10 OVER ***"
      *            END-IF
      *        END-EVALUATE
      *
      *        PERFORM 990-PARA-NEXT-SEC
      *    END-PERFORM
      *    CLOSE                       PARA-FILE
      *
      *    .
      *320-PARAFILE-KENSAKU-EXT.
      *    EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           MOVE    ZERO            TO  SPA-NAI25-JYU-MAX
           INITIALIZE                  SPA-GMN25-JYU-TBL
      *
      *    旧姓履歴スパ初期編集処理
      *****PERFORM 311-KYUSEIRRK-SPASET-SEC
      *
      *    診療科履歴スパ初期編集処理
           PERFORM 312-SRYKARRK-SPASET-SEC
      *
           .
       31O-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    旧姓履歴スパ初期編集処理
      *****************************************************************
      *311-KYUSEIRRK-SPASET-SEC              SECTION.
      *
      *    PERFORM     VARYING     IDX   FROM    1   BY  1
      *                UNTIL      (IDX           >   10)
      *                OR         (IDX           >   SPA-NAI25-KYU-MAX)
      *        MOVE    LNK-KYU-CHGYMD (IDX)
      *                                TO  SPA-GMN25-KYU-CHGYMD(IDX)
      *        MOVE    LNK-KYU-CHGYMD (IDX)   TO  WRK-SYMD
      *        PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
      *        MOVE    WRK-HENYMD      TO  SPA-GMN25-KYU-CHGYMDW (IDX)
      *        MOVE    LNK-KYU-KANANAME(IDX)
      *                                TO  SPA-GMN25-KYU-KANANAME(IDX)
      *        MOVE    LNK-KYU-NAME(IDX)
      *                                TO  SPA-GMN25-KYU-NAME    (IDX)
      *        MOVE    LNK-KYU-NICKNAME(IDX)
      *                                TO  SPA-GMN25-KYU-NICKNAME(IDX)
      *        MOVE    LNK-KYU-CREYMD (IDX)
      *                                TO  SPA-GMN25-KYU-CREYMD  (IDX)
      *        MOVE    LNK-KYU-UPYMD(IDX)
      *                                TO  SPA-GMN25-KYU-UPYMD   (IDX)
      *        IF  LNK-KYU-UPYMD (IDX) =   ALL "9"
      *            MOVE    "1"         TO  SPA-GMN25-KYU-DELKBN  (IDX)
      *        ELSE
      *            MOVE    SPACE       TO  SPA-GMN25-KYU-DELKBN  (IDX)
      *        END-IF
      *    END-PERFORM
      *    .
      *311-KYUSEIRRK-SPASET-EXT.
      *    EXIT.
      *
      *****************************************************************
      *    診療科履歴スパ初期編集処理
      *****************************************************************
       312-SRYKARRK-SPASET-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-SRYKARRK
           MOVE    SPACE               TO  SRYKARRK-REC
           MOVE    SPA-HOSPID          TO  KARRK-HOSPID
           MOVE    SPA-GMN-PTID        TO  KARRK-PTID
           MOVE    SRYKARRK-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYKARRK-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYKARRK-KEY2" TO  ORC-DBPATH
               PERFORM 960-SRYKARRK-NEXT-SEC
           ELSE
               INITIALIZE              SRYKARRK-REC
               MOVE    1               TO  FLG-SRYKARRK
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM     UNTIL   ( FLG-SRYKARRK      =     1 )
                       OR      ( IDX               =    30 )
             IF     (KARRK-SRYKA     =   SPACE )  OR
                    (KARRK-LASTYMD   =   SPACE )
                CONTINUE
             ELSE
               ADD     1               TO  IDX
               MOVE    KARRK-SRYKA     TO  SPA-NAI25-SRY-SRYKA    (IDX)
               MOVE    KARRK-SYOSINYMD1
                                       TO  SPA-NAI25-SRY-SYOSINYMD(IDX)
               MOVE    KARRK-SYOSINYMD1    TO  WRK-SYMD
               PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
               MOVE    WRK-HENYMD      TO  SPA-GMN25-SRY-SYOSINYMD(IDX)
               MOVE    KARRK-LASTYMD   TO  SPA-NAI25-SRY-LASTYMD  (IDX)
               MOVE    KARRK-LASTYMD   TO  WRK-SYMD
               PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
               MOVE    WRK-HENYMD      TO  SPA-GMN25-SRY-LASTYMD  (IDX)
      *        診療科名称取得
               PERFORM 3120-SRYKA-GET-SEC
               MOVE    SYS-1005-SRYKANAME1
                                       TO  SPA-GMN25-SRY-SRYKA    (IDX)
             END-IF
      *
               MOVE    "SRYKARRK-KEY2" TO  ORC-DBPATH
               PERFORM 960-SRYKARRK-NEXT-SEC
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYKARRK-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           MOVE    IDX                 TO  SPA-NAI25-SRY-MAX
      *
           IF  SPA-NAI25-SRY-MAX       =   1
               MOVE    1               TO  SPA-NAI25-SELNUM2
      *        受診２ﾃｰﾌﾞﾙ編集
               MOVE    SPA-NAI25-SRY-SRYKA(1)  TO  WRK-SRYKA
      **        １年前の年月日取得
      *         PERFORM 4221-ZENYMD-GET-SEC
      *         MOVE    WRK-SYMD        TO  WRK-ZENYMD
      *　    　受診履歴２編集
               PERFORM 4222-JYURRK-SPASET-SEC
               MOVE    ZERO            TO  SPA-NAI25-SELNUM2
           END-IF
      *
           .
       312-SRYKARRK-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科名称取得処理
      *****************************************************************
       3120-SRYKA-GET-SEC              SECTION.
      *
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    KARRK-SRYKA         TO  SYS-1005-KBNCD
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    WRK-SYMD            TO  ORC-DBYMD
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
           ELSE
               MOVE    1               TO  FLG-KANRIMST
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           .
       3120-SRYKA-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-GMN25-CUR
               WHEN    01
                   MOVE    "P025_SELNUM1"    TO  MCP-WIDGET
               WHEN    02
                   MOVE    "P025_THENYMD"    TO  MCP-WIDGET
               WHEN    03
                   MOVE    "P025_TKANANAME"  TO  MCP-WIDGET
               WHEN    04
                   MOVE    "P025_TNAME"      TO  MCP-WIDGET
               WHEN    05
                   MOVE    "P025_TNICKNAME"  TO  MCP-WIDGET
               WHEN    06
                   MOVE    "BR1"             TO  MCP-WIDGET
               WHEN    07
                   MOVE    "BR2"             TO  MCP-WIDGET
               WHEN    08
                   MOVE    "P025_SELNUM2"    TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    登録
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 490-TOUROKU-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *    旧姓 更新処理
               WHEN    "CLICKED"       ALSO    "BR1"
                   PERFORM 460-KYUSEI-UPDATE-SEC
      *    旧姓 削除処理
               WHEN    "CLICKED"       ALSO    "BR2"
                   PERFORM 470-KYUSEI-DELETE-SEC
      *
               WHEN    "CLICKED"       ALSO     ANY
                   PERFORM 4101-BETUGAMEN-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    タグ変更・別画面切替　表示処理
      *****************************************************************
       4101-BETUGAMEN-SEC          SECTION.
      *
           EVALUATE    MCP-WIDGET
      *    自画面
      *        WHEN    "N08"
      *            パラメタファイル検索処理
      *************PERFORM 320-PARAFILE-KENSAKU-SEC
      *            旧姓履歴スパ初期編集処理
      *************PERFORM 311-KYUSEIRRK-SPASET-SEC
      *    他画面
               WHEN    OTHER
                   PERFORM 490-TOUROKU-SEC
           END-EVALUATE
           .
       4101-BETUGAMEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       490-TOUROKU-SEC                 SECTION.
      *
      *    登録チェック処理
           PERFORM 4901-TOUROKU-CHECK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO              490-TOUROKU-EXT
           END-IF
      *
      *****パラメタファイル再検索処理
      *    INITIALIZE                  LNK-KYUSEIRRK-AREA
      *****PERFORM 320-PARAFILE-KENSAKU-SEC
      *
      *    画面の内容を患者マスター保存へ
           PERFORM 500-GMN-SPA-HEN-SEC
      *
      *    パラメタデータ出力
      *****PERFORM 520-PARA-OUT-SEC
      *
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録チェック処理
      *****************************************************************
       4901-TOUROKU-CHECK-SEC         SECTION.
      *
           PERFORM     VARYING     IDX   FROM    1   BY  1
                       UNTIL      (IDX       >   10)
                       OR         (IDX       >   SPA-NAI25-EDA-MAX)
                       OR         (SPA-ERRCD     NOT =   SPACE )
      *
             IF  SPA-GMN25-KYU-DELKBN (IDX)    =   SPACE
      *
                 COMPUTE     IDZ               =   IDX    +   1
                 PERFORM     VARYING   IDY   FROM   IDZ   BY  1
                             UNTIL    (IDY     >   10)
                             OR       (IDY     >   SPA-NAI25-EDA-MAX)
                             OR       (SPA-ERRCD   NOT =   SPACE )
      *
                     IF  ( SPA-GMN25-KYU-DELKBN (IDY)  =   SPACE )  AND
                         ( SPA-GMN25-KYU-CHGYMD (IDX)
                                         =   SPA-GMN25-KYU-CHGYMD(IDY))
                         MOVE    "2517"      TO  SPA-ERRCD
                     END-IF
                 END-PERFORM
             END-IF
           END-PERFORM
           .
       4901-TOUROKU-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面の内容を旧姓履歴保存へ
      *****************************************************************
       500-GMN-SPA-HEN-SEC         SECTION.
      *
      *    全データ
           PERFORM     VARYING   IDX   FROM    1   BY  1
                       UNTIL     IDX   >   SPA-NAI25-EDA-MAX
      *
      *********MOVE    SPACE           TO  LNK-KYU-KEY-O(IDX)
      *
      *        削除データの場合
               IF  SPA-GMN25-KYU-DELKBN (IDX)  =   "1"
                   MOVE    ALL "9"     TO  LNK-KYU-UPYMD   (IDX)
               ELSE
      *            変更年月日変更時、名称など転送
                   IF  ( SPA-GMN25-KYU-CHGYMD  (IDX)
                                   NOT =   LNK-KYU-CHGYMD  (IDX)) OR
                       ( SPA-GMN25-KYU-KANANAME(IDX)
                                   NOT =   LNK-KYU-KANANAME(IDX)) OR
                       ( SPA-GMN25-KYU-NAME    (IDX)
                                   NOT =   LNK-KYU-NAME    (IDX)) OR
                       ( SPA-GMN25-KYU-NICKNAME(IDX)
                                   NOT =   LNK-KYU-NICKNAME(IDX))
      *                変更前キー転送
                       MOVE    LNK-KYU-KEY (IDX)
      *************************************TO  LNK-KYU-KEY-O   (IDX)
                                           TO  LNK-KYUUP-KEY   (IDX)
                       MOVE    SPA-GMN25-KYU-UPYMD (IDX)
                                           TO  LNK-KYU-UPYMD   (IDX)
                       MOVE    SPA-GMN25-KYU-CHGYMD  (IDX)
                                           TO  LNK-KYU-CHGYMD  (IDX)
                       MOVE    SPA-GMN25-KYU-KANANAME(IDX)
                                           TO  LNK-KYU-KANANAME(IDX)
                       MOVE    SPA-GMN25-KYU-NAME    (IDX)
                                           TO  LNK-KYU-NAME    (IDX)
                       MOVE    SPA-GMN25-KYU-NICKNAME(IDX)
                                           TO  LNK-KYU-NICKNAME(IDX)
                       MOVE    SPA-TERMID  TO  LNK-KYU-TERMID  (IDX)
                       MOVE    SPA-OPID    TO  LNK-KYU-OPID    (IDX)
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       500-GMN-SPA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタデータ出力
      *****************************************************************
      *520-PARA-OUT-SEC             SECTION.
      *
      *    MOVE    SPA-TERMID          TO  FILE-TERMID1
      *    OPEN    I-O                 PARA-FILE
      *    PERFORM     VARYING   IDX   FROM    1   BY  1
      *                UNTIL     IDX       >   SPA-NAI25-EDA-MAX
      *        MOVE    "KYUSEI"            TO  PAR-FILEMEI
      *        MOVE    IDX                 TO  PAR-EDANUM
      *        PERFORM 980-PARA-READ-SEC
      *        MOVE    "KYUSEI"            TO  PAR-FILEMEI
      *        MOVE    IDX                 TO  PAR-EDANUM
      *        MOVE    LNK-KYUSEIRRK-REC (IDX)
      *                                    TO  PAR-DATA-REC
      *        IF      FLG-PARA            =   ZERO
      *            REWRITE   PARA-REC
      *        ELSE
      *            WRITE     PARA-REC
      *        END-IF
      *    END-PERFORM
      *    CLOSE                     PARA-FILE
      *    .
      *
      *520-PARA-OUT-EXT.
      *****EXIT.
      *
      *****************************************************************
      *    保険情報処理
      *****************************************************************
       460-KYUSEI-UPDATE-SEC          SECTION.
      *
      *チェック
           IF  SPA-NAI25-SELNUM       =   ZERO
               MOVE    "2501"         TO  SPA-ERRCD
      *----(01.00.01) LINE ADD START -------------------------------
               MOVE    1              TO  SPA-GMN25-CUR
      *----(01.00.01) LINE ADD END   -------------------------------
               GO  TO                 460-KYUSEI-UPDATE-EXT
           END-IF
           MOVE    ZERO               TO  WRK-IDX
           PERFORM     VARYING   IDX  FROM    1   BY  1
                       UNTIL    (IDX      >   10)
                       OR       (IDX      >   SPA-NAI25-KYU-MAX)
             IF  SPA-GMN25-KYU-DELKBN (IDX)    =   SPACE
               ADD     1              TO  WRK-IDX 
             END-IF
           END-PERFORM
           IF  SPA-NAI25-SELNUM       >   WRK-IDX
               MOVE    "2502"         TO  SPA-ERRCD
               GO  TO                 460-KYUSEI-UPDATE-EXT
           END-IF
      *必須入力チェック
           IF  (SPA-GMN25-TKYU-CHGYMD    =   SPACE)   AND
               (SPA-GMN25-TKYU-KANANAME  =   SPACE)   AND
               (SPA-GMN25-TKYU-NAME      =   SPACE)
               MOVE    "2507"         TO  SPA-ERRCD
               GO  TO                 460-KYUSEI-UPDATE-EXT
           END-IF
      *----(01.00.01) LINE ADD START -------------------------------
      *    変更年月日
           PERFORM 4230-CHGYMD-CHECK-SEC
           IF  SPA-ERRCD          NOT =   SPACE
               GO  TO                 460-KYUSEI-UPDATE-EXT
           END-IF
      *    カナ氏名
           PERFORM 4230-TKANANAME-CHECK-SEC
           IF  SPA-ERRCD          NOT =   SPACE
               GO  TO                 460-KYUSEI-UPDATE-EXT
           END-IF
      *    漢字氏名
           PERFORM 4230-TNAME-CHECK-SEC
           IF  SPA-ERRCD          NOT =   SPACE
               GO  TO                 460-KYUSEI-UPDATE-EXT
           END-IF
      *    通称
           PERFORM 4230-TNICKNAME-CHECK-SEC
           IF  SPA-ERRCD          NOT =   SPACE
               GO  TO                 460-KYUSEI-UPDATE-EXT
           END-IF
      *    必須チェック
           IF  (SPA-GMN25-TKYU-KANANAME  =   SPACE)   OR
               (SPA-GMN25-TKYU-NAME      =   SPACE)
               MOVE    "2507"         TO  SPA-ERRCD
               IF  SPA-GMN25-TKYU-NAME   =   SPACE
                   MOVE    4             TO  SPA-GMN25-CUR
               END-IF
               IF  SPA-GMN25-TKYU-KANANAME   =   SPACE
                   MOVE    3             TO  SPA-GMN25-CUR
               END-IF
               GO  TO                 460-KYUSEI-UPDATE-EXT
           END-IF
      *----(01.00.01) LINE ADD END   -------------------------------
      *同一年月日チェック
           MOVE    ZERO               TO  WRK-IDX
           MOVE    ZERO               TO  IDY
           PERFORM     VARYING   IDX  FROM    1   BY  1
                       UNTIL    (IDX      >   10)
                       OR       (IDX      >   SPA-NAI25-KYU-MAX)
                       OR       (IDY      >   ZERO )
             IF  SPA-GMN25-KYU-DELKBN (IDX)   =   SPACE
               ADD     1              TO  WRK-IDX
               IF  WRK-IDX            =   SPA-NAI25-SELNUM
                   MOVE    IDX        TO  IDY
               END-IF
             END-IF
           END-PERFORM
           PERFORM     VARYING   IDX  FROM    1   BY  1
                       UNTIL    (IDX      >   10)
                       OR       (IDX      >   SPA-NAI25-KYU-MAX)
               IF  IDX           NOT  =   IDY
                   IF  SPA-GMN25-TKYU-CHGYMD
                                      =   SPA-GMN25-KYU-CHGYMD(IDX)
                       MOVE    "2517"     TO  SPA-ERRCD
                       GO  TO             460-KYUSEI-UPDATE-EXT
                   END-IF
               END-IF
           END-PERFORM
      *
      *スパテーブルに追加転送
           PERFORM     VARYING    IDX     FROM    1   BY  1
                       UNTIL      IDX         >   10
               IF  IDX                =   IDY
                   MOVE    SPA-GMN25-TKYU-CHGYMDW
                                      TO  SPA-GMN25-KYU-CHGYMDW (IDX)
                   MOVE    SPA-GMN25-TKYU-CHGYMD
                                      TO  SPA-GMN25-KYU-CHGYMD  (IDX)
                   MOVE    SPA-GMN25-TKYU-KANANAME
                                      TO  SPA-GMN25-KYU-KANANAME(IDX)
                   MOVE    SPA-GMN25-TKYU-NAME
                                      TO  SPA-GMN25-KYU-NAME    (IDX)
                   MOVE    SPA-GMN25-TKYU-NICKNAME
                                      TO  SPA-GMN25-KYU-NICKNAME(IDX)
                   MOVE    SPA-SYSYMD TO  SPA-GMN25-KYU-UPYMD   (IDX)
               END-IF
           END-PERFORM
      *
           MOVE    SPACE              TO  SPA-GMN25-TKYUSEI-REC
           MOVE    SPACE              TO  SPA-GMN25-SELNUM
           MOVE    ZERO               TO  SPA-NAI25-SELNUM
           MOVE    1                  TO  SPA-GMN25-CUR
           .
       460-KYUSEI-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険情報削除処理
      *****************************************************************
       470-KYUSEI-DELETE-SEC         SECTION.
      *
      *チェック
           IF  SPA-NAI25-SELNUM      =   ZERO
               MOVE    "2501"        TO  SPA-ERRCD
      *----(01.00.01) LINE ADD START -------------------------------
               MOVE    1             TO  SPA-GMN25-CUR
      *----(01.00.01) LINE ADD END   -------------------------------
               GO  TO                470-KYUSEI-DELETE-EXT
           END-IF
           MOVE    ZERO              TO  WRK-IDX
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL    (IDX       >   10)
                     OR       (IDX       >   SPA-NAI25-KYU-MAX)
             IF  SPA-GMN25-KYU-DELKBN (IDX)   =   SPACE
               ADD     1             TO  WRK-IDX 
             END-IF
           END-PERFORM
           IF  SPA-NAI25-SELNUM      >   WRK-IDX
               MOVE    "2502"        TO  SPA-ERRCD
               GO  TO                470-KYUSEI-DELETE-EXT
           END-IF
      *旧姓ﾃｰﾌﾞﾙとの内容確認
           MOVE    ZERO              TO  WRK-IDX
           MOVE    ZERO              TO  IDY
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL    (IDX       >   10)
                     OR       (IDX       >   SPA-NAI25-KYU-MAX)
                     OR       (IDY       >   ZERO )
             IF  SPA-GMN25-KYU-DELKBN (IDX)    =   SPACE
               ADD     1             TO  WRK-IDX
               IF  WRK-IDX           =   SPA-NAI25-SELNUM
                   MOVE    IDX       TO  IDY
               END-IF
             END-IF
           END-PERFORM
           IF  (SPA-GMN25-TKYU-CHGYMD
                                 =   SPA-GMN25-KYU-CHGYMD  (IDY))  AND
               (SPA-GMN25-TKYU-KANANAME
                                 =   SPA-GMN25-KYU-KANANAME(IDY))  AND
               (SPA-GMN25-TKYU-NAME  =   SPA-GMN25-KYU-NAME  (IDY))
               CONTINUE
           ELSE
               MOVE    "2506"        TO  SPA-ERRCD
               GO  TO                470-KYUSEI-DELETE-EXT
           END-IF
      *
           MOVE    "1"               TO  SPA-GMN25-KYU-DELKBN(IDY)
      *
           MOVE    SPACE                   TO  SPA-GMN25-TKYUSEI-REC
           MOVE    SPACE                   TO  SPA-GMN25-SELNUM
           MOVE    ZERO                    TO  SPA-NAI25-SELNUM
      *
           .
       470-KYUSEI-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    [旧姓]選択番号
           WHEN    "ACTIVATE"      ALSO    "P025_SELNUM1"
               PERFORM 4210-KYU-SELNUM-SEC
      *    [旧姓]選択番号選択
               WHEN    ANY         ALSO    "P025_KYUSEILIST"
               PERFORM 4210-KYU-LIST-SEC
      *    変更年月日
           WHEN    "ACTIVATE"      ALSO    "P025_THENYMD"
               PERFORM 4230-CHGYMD-CHECK-SEC
      *    カナ氏名
           WHEN    "ACTIVATE"      ALSO    "P025_TKANANAME"
               PERFORM 4230-TKANANAME-CHECK-SEC
      *    漢字氏名
           WHEN    "ACTIVATE"      ALSO    "P025_TNAME"
               PERFORM 4230-TNAME-CHECK-SEC
      *    通称
           WHEN    "ACTIVATE"      ALSO    "P025_TNICKNAME"
               PERFORM 4230-TNICKNAME-CHECK-SEC
      *    選択番号２
           WHEN    "ACTIVATE"      ALSO    "P025_SELNUM2"
               PERFORM 4220-JYU-SELNUM-SEC
      *    選択番号２
           WHEN    ANY             ALSO    "P025_JYUSINLIST1"
               PERFORM 4220-JYU-LIST-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC          SECTION.
      *
           MOVE    P02-P025-SELNUM1    TO  SPA-GMN25-SELNUM
           MOVE    P02-P025-THENYMD    TO  SPA-GMN25-TKYU-CHGYMDW
           MOVE    P02-P025-TKANANAME  TO  SPA-GMN25-TKYU-KANANAME
           MOVE    P02-P025-TNAME      TO  SPA-GMN25-TKYU-NAME
           MOVE    P02-P025-TNICKNAME  TO  SPA-GMN25-TKYU-NICKNAME
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    変更年月日　入力処理
      *****************************************************************
       4230-CHGYMD-CHECK-SEC          SECTION.
      *
      *----(01.00.01) LINE MOD START --------------------------------
      *     MOVE    P02-P025-THENYMD       TO  SPA-GMN25-TKYU-CHGYMDW
           MOVE    P02-P025-THENYMD       TO  WRK-WWYMD
           IF  ( WRK-WWYMD                =   SPACE )  AND
               ( SPA-GMN25-SELNUM         =   SPACE )
               MOVE    SPACE              TO  SPA-GMN25-TKYU-CHGYMDW
               MOVE    SPACE              TO  SPA-GMN25-TKYU-CHGYMD
               MOVE    3                  TO  SPA-GMN25-CUR
               GO  TO                     4230-CHGYMD-CHECK-EXT
           END-IF
      *----(01.00.04) LINE ADD START --------------------------------
      *    日付画面チェックサブ
           MOVE    2                   TO  SPA-GMN25-CUR
           INITIALIZE                      ORCSGDAYAREA
           MOVE    P02-P025-THENYMD    TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  SPA-GMN25-TKYU-CHGYMDW
               MOVE    SGDAY-SDAY          TO  SPA-GMN25-TKYU-CHGYMD
               MOVE    3                   TO  SPA-GMN25-CUR
           ELSE
               MOVE    P02-P025-THENYMD    TO  SPA-GMN25-TKYU-CHGYMDW
               MOVE    "2503"              TO  SPA-ERRCD
           END-IF
      *
           .
       4230-CHGYMD-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    カナ氏名処理
      *****************************************************************
       4230-TKANANAME-CHECK-SEC         SECTION.
      *
           MOVE    P02-P025-TKANANAME  TO  SPA-GMN25-TKYU-KANANAME
      *    半角空白を全角空白へ
           MOVE    SPA-GMN25-TKYU-KANANAME TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-ATO-INPUT   TO  SPA-GMN25-TKYU-KANANAME
               MOVE    4                   TO  SPA-GMN25-CUR
           ELSE
               MOVE    3                   TO  SPA-GMN25-CUR
           END-IF
      *
           .
       4230-TKANANAME-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    漢字氏名処理
      *****************************************************************
       4230-TNAME-CHECK-SEC         SECTION.
      *
           MOVE    P02-P025-TNAME      TO  SPA-GMN25-TKYU-NAME
      *    半角空白を全角空白へ
           MOVE    SPA-GMN25-TKYU-NAME TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN25-TKYU-NAME
               MOVE    5                   TO  SPA-GMN25-CUR
           ELSE
               MOVE    4                   TO  SPA-GMN25-CUR
           END-IF
      *
           .
       4230-TNAME-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    通称氏名処理
      *****************************************************************
       4230-TNICKNAME-CHECK-SEC         SECTION.
      *
           MOVE    P02-P025-TNICKNAME      TO  SPA-GMN25-TKYU-NICKNAME
      *    半角空白を全角空白へ
           MOVE    SPA-GMN25-TKYU-NICKNAME TO  WRK-MAE-INPUT
           PERFORM 890-HALF-ZEN-SEC
           IF      SPA-ERRCD           =   SPACE
               MOVE    WRK-ATO-INPUT   TO  SPA-GMN25-TKYU-NICKNAME
               MOVE    6                   TO  SPA-GMN25-CUR
           ELSE
               MOVE    5                   TO  SPA-GMN25-CUR
           END-IF
      *
           .
       4230-TNICKNAME-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    半角空白を全角空白へ変換処理
      *****************************************************************
       890-HALF-ZEN-SEC         SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-MAE-INPUT       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
               MOVE    "2530"              TO  SPA-ERRCD
               MOVE    WRK-MAE-INPUT       TO  WRK-ATO-INPUT
           ELSE
               MOVE    KANACHK-OUT-INPUT   TO  WRK-ATO-INPUT
           END-IF
      *
           .
       890-HALF-ZEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    旧姓履歴選択番号入力処理
      *****************************************************************
       4210-KYU-SELNUM-SEC             SECTION.
      *
           MOVE    P02-P025-SELNUM1    TO  SPA-GMN25-SELNUM
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN25-SELNUM    TO  SNUM-INX
           CALL    "ORCSNUM"               USING
                                           ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "2502"          TO  SPA-ERRCD
      *----(01.00.01) LINE ADD START -------------------------------
               MOVE    1               TO  SPA-GMN25-CUR
      *----(01.00.01) LINE ADD END   -------------------------------
               GO      TO              4210-KYU-SELNUM-EXT
           ELSE
               MOVE    SNUM-OUTNUM     TO  SPA-NAI25-SELNUM
               MOVE    SNUM-OUTNUM     TO  WRK-RENNUMZ
               MOVE    WRK-RENNUMZ     TO  SPA-GMN25-SELNUM
           END-IF
      *
           IF  SPA-NAI25-SELNUM        =   ZERO
      *----(01.00.01) LINE ADD START -------------------------------
      *        必須入力チェック
               IF  ( SPA-GMN25-TKYU-CHGYMD   =   SPACE )  AND
                   ( SPA-GMN25-TKYU-KANANAME =   SPACE )  AND
                   ( SPA-GMN25-TKYU-NAME     =   SPACE )
                   MOVE    2           TO  SPA-GMN25-CUR
               ELSE
      *----(01.00.01) LINE ADD END   -------------------------------
                   MOVE    "2504"      TO  SPA-ERRCD
      *----(01.00.01) LINE ADD START -------------------------------
                   MOVE    1           TO  SPA-GMN25-CUR
               END-IF
      *----(01.00.01) LINE ADD END   -------------------------------
               GO      TO              4210-KYU-SELNUM-EXT
           END-IF
      *
           MOVE    ZERO                TO  WRK-IDX
           MOVE    ZERO                TO  IDY
           PERFORM     VARYING   IDX   FROM    1   BY  1
                       UNTIL    (IDX       >   10)
                       OR       (IDX       >   SPA-NAI25-KYU-MAX)
             IF  SPA-GMN25-KYU-DELKBN (IDX)    =   SPACE
                 ADD     1             TO  WRK-IDX
                 IF  WRK-IDX           =   SPA-NAI25-SELNUM
                     MOVE    IDX       TO  IDY
                 END-IF
             END-IF
           END-PERFORM
           IF  SPA-NAI25-SELNUM        >   WRK-IDX
               MOVE    "2502"          TO  SPA-ERRCD
               GO      TO              4210-KYU-SELNUM-EXT
           END-IF
      *
           INITIALIZE                  SPA-GMN25-TKYUSEI-REC
           MOVE    SPA-GMN25-KYU-CHGYMDW  (IDY)
                                       TO  SPA-GMN25-TKYU-CHGYMDW
           MOVE    SPA-GMN25-KYU-CHGYMD   (IDY)
                                       TO  SPA-GMN25-TKYU-CHGYMD
           MOVE    SPA-GMN25-KYU-KANANAME (IDY)
                                       TO  SPA-GMN25-TKYU-KANANAME
           MOVE    SPA-GMN25-KYU-NAME     (IDY)
                                       TO  SPA-GMN25-TKYU-NAME
           MOVE    SPA-GMN25-KYU-NICKNAME (IDY)
                                       TO  SPA-GMN25-TKYU-NICKNAME
           MOVE    2                   TO  SPA-GMN25-CUR
           .
       4210-KYU-SELNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    [旧姓]選択番号選択処理
      *****************************************************************
       4210-KYU-LIST-SEC            SECTION.
      *
           MOVE    ZERO                TO  WRK-SELNUM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX       >   SPA-NAI25-KYU-MAX
               IF      P02-P025-KYUSEILIST-SELECT (IDX)  =   "T"
                   IF      IDX               =   SPA-NAI25-SELNUM
                       CONTINUE
                   ELSE
                       MOVE    IDX               TO  WRK-SELNUM
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      WRK-SELNUM      NOT =   ZERO
               MOVE    WRK-SELNUM          TO  SPA-NAI25-SELNUM
           END-IF
      *
           IF      SPA-NAI25-SELNUM   NOT =   ZERO
               MOVE     SPA-NAI25-SELNUM      TO   WRK-RENBAN
               MOVE     WRK-RENBAN            TO   P02-P025-SELNUM1
               PERFORM 4210-KYU-SELNUM-SEC
           END-IF
      *
          .
       4210-KYU-LIST-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    受診履歴選択番号入力処理
      *****************************************************************
       4220-JYU-SELNUM-SEC             SECTION.
      *
           MOVE    P02-P025-SELNUM2    TO  SPA-GMN25-SELNUM2
           INITIALIZE                      ORCSNUMAREA
           MOVE    SPA-GMN25-SELNUM2   TO  SNUM-INX
           CALL    "ORCSNUM"               USING
                                           ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "2508"          TO  SPA-ERRCD
               GO      TO              4220-JYU-SELNUM-EXT
           ELSE
               MOVE    SNUM-OUTNUM     TO  SPA-NAI25-SELNUM2
               MOVE    SNUM-OUTNUM     TO  WRK-RENNUMZ
               MOVE    WRK-RENNUMZ     TO  SPA-GMN25-SELNUM2
           END-IF
      *
           IF  SPA-NAI25-SELNUM2       =   ZERO
               MOVE    "2508"          TO  SPA-ERRCD
               GO  TO                  4220-JYU-SELNUM-EXT
           END-IF
           IF  SPA-NAI25-SELNUM2       >   SPA-NAI25-SRY-MAX
               MOVE    "2508"          TO  SPA-ERRCD
               GO  TO                  4220-JYU-SELNUM-EXT
           END-IF
      *
      *    受診２ﾃｰﾌﾞﾙ編集
           MOVE    SPA-NAI25-SRY-SRYKA (SPA-NAI25-SELNUM2)
                                       TO  WRK-SRYKA
      *
      **    １年前の年月日取得
      *     PERFORM 4221-ZENYMD-GET-SEC
      *     MOVE    WRK-SYMD            TO  WRK-ZENYMD
      *
      *　　受診履歴２編集
           PERFORM 4222-JYURRK-SPASET-SEC
           MOVE    8                    TO  SPA-GMN25-CUR
           .
       4220-JYU-SELNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴選択処理
      *****************************************************************
       4220-JYU-LIST-SEC            SECTION.
      *
           MOVE    ZERO                TO  WRK-SELNUM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX       >   SPA-NAI25-SRY-MAX
               IF      P02-P025-JYUSINLIST1-SELECT (IDX)  =   "T"
                   IF      IDX               =   SPA-NAI25-SELNUM2
                       CONTINUE
                   ELSE
                       MOVE    IDX               TO  WRK-SELNUM
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      WRK-SELNUM      NOT =   ZERO
               MOVE    WRK-SELNUM          TO  SPA-NAI25-SELNUM2
           END-IF
      *
           IF      SPA-NAI25-SELNUM2   NOT =   ZERO
               MOVE     SPA-NAI25-SELNUM2     TO   WRK-RENBAN
               MOVE     WRK-RENBAN            TO   P02-P025-SELNUM2
               PERFORM 4220-JYU-SELNUM-SEC
           END-IF
      *
          .
       4220-JYU-LIST-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    受診履歴スパ編集処理
      *****************************************************************
       4222-JYURRK-SPASET-SEC            SECTION.
      *
           MOVE    ZERO                  TO  SPA-NAI25-JYU-MAX
           INITIALIZE                        SPA-GMN25-JYU-TBL
      *
           MOVE    ZERO                  TO  FLG-JYURRK
           MOVE    SPACE                 TO  JYURRK-REC
           MOVE    SPA-HOSPID            TO  JYURRK-HOSPID
           MOVE    SPA-GMN-PTID          TO  JYURRK-PTID
           MOVE    WRK-SRYKA             TO  JYURRK-SRYKA
      *
           MOVE    JYURRK-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"            TO  MCP-FUNC
           MOVE    "JYURRK-KEY7"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"                USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           IF      MCP-RC                =   ZERO
               MOVE    "JYURRK-KEY7"     TO  ORC-DBPATH
               PERFORM 970-JYURRK-NEXT-SEC
           ELSE
               INITIALIZE                JYURRK-REC
               MOVE    1                 TO  FLG-JYURRK
           END-IF
      *
           MOVE    ZERO                  TO  IDX
           PERFORM   UNTIL   ( FLG-JYURRK    =   1  )
                     OR      ( IDX           =   50 )
      *      受診履歴
      *       IF  WRK-ZENYMD              <=  JYURRK-SRYYMD
                 ADD     1               TO  IDX
                 MOVE    JYURRK-SRYYMD   TO  WRK-SYMD
                 PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
                 MOVE    WRK-HENYMD      TO  SPA-GMN25-JYU-SRYYMD (IDX)
                 MOVE    SPA-GMN25-SRY-SRYKA (SPA-NAI25-SELNUM2)
                                         TO  SPA-GMN25-JYU-SRYKA  (IDX)
                 PERFORM     VARYING     IDZ   FROM    1   BY  1
                             UNTIL       IDZ       >   11
                     IF  JYURRK-SRYKBN (IDZ)   NOT =   SPACE
                         IF  SPA-GMN25-JYU-SRYKBN(IDX) =   SPACE
                             MOVE    WRK-HEN-SRYNAME (IDZ)
                                         TO  SPA-GMN25-JYU-SRYKBN (IDX)
                         ELSE
                             STRING  SPA-GMN25-JYU-SRYKBN(IDX)
                                           DELIMITED   BY  " "
                                     "  "  DELIMITED   BY  SIZE
                                     WRK-HEN-SRYNAME (IDZ)
                                           DELIMITED   BY  " "
                                     INTO  SPA-GMN25-JYU-SRYKBN   (IDX)
                             END-STRING
                         END-IF
                     END-IF
                 END-PERFORM
      *       END-IF
             MOVE    "JYURRK-KEY7"       TO  ORC-DBPATH
             PERFORM 970-JYURRK-NEXT-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"             TO  MCP-FUNC
           MOVE    "JYURRK-KEY7"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"                USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
      *
           MOVE    IDX                   TO  SPA-NAI25-JYU-MAX
      *
           .
       4222-JYURRK-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    １年前年月日取得処理
      *****************************************************************
       4221-ZENYMD-GET-SEC             SECTION.
      *
           MOVE    SPACE               TO  STS-AREA-DAY
           INITIALIZE                      STS-AREA-DAY
           MOVE    SPACE               TO  LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    SPA-SYSYMD          TO  LNK-DAY6-KIJUN
           MOVE    "3"                 TO  LNK-DAY6-ZOGENPTN
           MOVE    -1                  TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"    USING  STS-AREA-DAY  LNK-DAY6-AREA
           IF    STS-DAY-RC1           =   ZERO
               MOVE    LNK-DAY6-KEISAN     TO  WRK-SYMD
           ELSE
               MOVE    SPACE               TO  WRK-SYMD
           END-IF
           .
       4221-ZENYMD-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦→和暦FORMAT日付編集
      *****************************************************************
       410112-SE-WAFORMAT-YMDEDIT-SEC  SECTION.
      *
           MOVE    SPACE               TO  STS-AREA-DAY
           INITIALIZE                      STS-AREA-DAY
           MOVE    SPACE               TO  LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"    USING   STS-AREA-DAY  LNK-DAY2-AREA
           IF  STS-DAY-RC1             =   ZERO
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMD
           ELSE
               MOVE    SPACE               TO  WRK-HENYMD
           END-IF
           .
       410112-SE-WAFORMAT-YMDEDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦→和暦FORMAT日付編集
      *****************************************************************
       410113-WA-FOMAT-YMDEDIT-SEC     SECTION.
      *
           MOVE    SPACE               TO  STS-AREA-DAY
           INITIALIZE                      STS-AREA-DAY
           MOVE    SPACE               TO  LNK-DAY2-AREA
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "22"                TO  LNK-DAY2-IRAI
           MOVE    WRK-WYMD            TO  LNK-DAY2-YMD (2:7)
           CALL    "ORCSDAY"    USING  STS-AREA-DAY  LNK-DAY2-AREA
           IF  STS-DAY-RC1             =   ZERO
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMD
           ELSE
               MOVE    SPACE               TO  WRK-HENYMD
           END-IF
           .
       410113-WA-FOMAT-YMDEDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦→西暦日付編集
      *****************************************************************
       410114-WA-SE-YMDEDIT-SEC        SECTION.
      *
           MOVE    SPACE               TO  STS-AREA-DAY
           INITIALIZE                      STS-AREA-DAY
           MOVE    SPACE               TO  LNK-DAY1-AREA
           MOVE    "12"                TO  LNK-DAY1-IRAI
           MOVE    ZERO                TO  LNK-DAY1-YMD
           MOVE    WRK-WYMD            TO  LNK-DAY1-YMD (2:7)
           CALL    "ORCSDAY"    USING  STS-AREA-DAY  LNK-DAY1-AREA
           IF  STS-DAY-RC1             =   ZERO
               MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
           ELSE
               MOVE    SPACE               TO  WRK-SYMD
           END-IF
           .
       410114-WA-SE-YMDEDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       960-KANRIMST-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1005-REC
               MOVE    ZERO                TO  FLG-KANRIMST
           ELSE
               MOVE    1                   TO  FLG-KANRIMST
           END-IF
      *
           .
       960-KANRIMST-READ-EXT.
           EXIT.
      *****************************************************************
      *    診療科履歴ＦＥＴＣＨ処理
      *****************************************************************
       960-SRYKARRK-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYKARRK-REC
               MOVE    ZERO                TO  FLG-SRYKARRK
           ELSE
               INITIALIZE                  SRYKARRK-REC
               MOVE    1                   TO  FLG-SRYKARRK
           END-IF
           .
       960-SRYKARRK-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴ＦＥＴＣＨ処理
      *****************************************************************
       970-JYURRK-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  JYURRK-REC
               MOVE    ZERO                TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1                   TO  FLG-JYURRK
           END-IF
           .
       970-JYURRK-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタファイル検索処理
      *****************************************************************
      *980-PARA-READ-SEC             SECTION.
      *
      *    パラメタファイルより編集
      *    READ    PARA-FILE
      *        INVALID
      *            MOVE    1           TO  FLG-PARA
      *        NOT INVALID
      *            MOVE    ZERO        TO  FLG-PARA
      *    END-READ
      *
      *    .
      *980-PARA-READ-EXT.
      *    EXIT.
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
      ***************************************************************
      *    ＰＵＴ　処理
      ***************************************************************
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
