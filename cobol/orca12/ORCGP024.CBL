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
       PROGRAM-ID.             ORCGP024.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 所得者情報（Ｐ０２４）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-太田     01/05/10  日付変換後ゼロ表示変更
      *  01.00.02    MCC-多々納   01/06/13  登録後、診療行為遷移を追加
      *  01.00.04    MCC-太田     01/05/10  日付変換後ゼロ表示変更
      *  01.00.05    MCC-多々納   01/07/02  日付入力チェックサブ追加
      *  02.00.00    NACL-多々納  02/07/30  インターフェース変更
      *  02.00.01    NACL-多々納  03/02/13  食事標準負担減額日追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメタデータ
      *    SELECT  PARA-FILE       ASSIGN  FILE-NAME1
      *                            ORGANIZATION    IS  INDEXED
      *                            ACCESS  MODE    IS  DYNAMIC
      *                            RECORD  KEY     IS  PAR-KEY
      *                            FILE    STATUS  IS  STS-PARA.
      *
       DATA                        DIVISION.
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
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PARA            PIC 9(01).
           03  FLG-END             PIC 9(01).
      *
           03  FLG-TOUROKU         PIC 9(01).
           03  FLG-IN-TNKSELNUM    PIC 9(01).
           03  FLG-IN-TSYSELNUM    PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-RENNUMZ         PIC ZZZZ.
           03  WRK-NAIBU-IDX-AREA.
               05  WRK-G-IDX       PIC 9(04).
               05  WRK-N-IDX       PIC 9(04).
      *        1:所得テーブル /2:年金テーブル
               05  WRK-W-TBL       PIC 9(01).
           03  WRK-TSY-SMAX        PIC 9(04).
           03  WRK-TNK-SMAX        PIC 9(04).
           03  WRK-TSY-MAX         PIC 9(04).
           03  WRK-TNK-MAX         PIC 9(04).
      *----(01.00.01) LINE ADD START --------------------------------
           03  WRK-WWYMD           PIC X(10).
      *----(01.00.01) LINE ADD END   --------------------------------
           03  WRK-SELNUM          PIC 9(04).
      *    入力項目名
           03  WRK-MCP-WIDGET          PIC X(64).
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
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    パラメタテーブル
       01  PARA-REC.
           COPY    "CPPARA.INC".
      *
      *   低所得者履歴
      *
       01  LNK-TSY-AREA.
           02  LNK-TSY-REC           OCCURS  20.
           COPY    "CPTSYRRK.INC"
                            REPLACING  //TSYRRK-// BY //LNK-TSY-//.
      *
      *   年金履歴
      *
       01  LNK-TNK-AREA.
           02  LNK-TNK-REC           OCCURS  10.
           COPY    "CPTNKRRK.INC"
                              REPLACING  //TNKRRK-// BY //LNK-TNK-//.
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
      *----(01.00.04) LINE ADD START ----------------------------------
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *----(01.00.04) LINE ADD END   ----------------------------------
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
           COPY    "P02X.INC".
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
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
           PERFORM 320-PARAFILE-KENSAKU-SEC
      *
           MOVE    SPA-WORK        TO  SPA-P02KYOUTU
      *
      *    初期画面編集
           PERFORM 310-SPASET-SEC
      *
           MOVE    1       TO  SPA-GMN24-CUR
      *
           .
       3OO-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタファイル検索処理
      *****************************************************************
       320-PARAFILE-KENSAKU-SEC             SECTION.
      *
           MOVE    ZERO                TO  SPA-TNK-MAX
           MOVE    ZERO                TO  SPA-TSY-MAX
           INITIALIZE                  LNK-TSY-AREA
           INITIALIZE                  LNK-TNK-AREA
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "TNKRRK"            TO  PARA-FILEMEI
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY2"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           PERFORM
               UNTIL   FLG-PARA            =   1
               IF      PARA-EDANUM         <=  10
                   MOVE    PARA-DATA-REC   TO  LNK-TNK-REC
                                                         (PARA-EDANUM)
                   MOVE    PARA-EDANUM     TO  SPA-TNK-MAX
               END-IF
               MOVE    "PARA-KEY2"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           END-PERFORM
      *
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "TSYRRK"            TO  PARA-FILEMEI
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY2"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           PERFORM
               UNTIL   FLG-PARA            =   1
               IF      PARA-EDANUM         <=  20
                   MOVE    PARA-DATA-REC   TO  LNK-TSY-REC
                                                         (PARA-EDANUM)
                   MOVE    PARA-EDANUM     TO  SPA-TSY-MAX
               END-IF
               MOVE    "PARA-KEY2"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           END-PERFORM
      *
           .
       320-PARAFILE-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
      *    低所得者編集
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL     ( IDX     >   20 )
                   OR        ( IDX     >   SPA-TSY-MAX )
      *
               MOVE    LNK-TSY-NINSTYMD (IDX)
                                         TO  SPA-GMN24-TSYDPSTYMD (IDX)
               MOVE    LNK-TSY-NINSTYMD (IDX)  TO  WRK-SYMD
               PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
               MOVE    WRK-HENYMD        TO  SPA-GMN24-TSYDPSTYMDW(IDX)
      *
               MOVE    LNK-TSY-NINEDYMD (IDX)
                                         TO  SPA-GMN24-TSYDPEDYMD (IDX)
               MOVE    LNK-TSY-NINEDYMD (IDX)  TO  WRK-SYMD
               IF  WRK-SYMD              =   ALL "9"
                   MOVE    ALL "9"  TO  SPA-GMN24-TSYDPEDYMDW(IDX)(1:7)
               ELSE
                   PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
                   MOVE    WRK-HENYMD    TO  SPA-GMN24-TSYDPEDYMDW(IDX)
               END-IF
      *
               MOVE    LNK-TSY-SKJGNSTYMD (IDX)
                                         TO  SPA-GMN24-TSYLSKJGNSTYMD
                                                              (IDX)
               MOVE    LNK-TSY-SKJGNSTYMD (IDX)  TO  WRK-SYMD
               IF      WRK-SYMD            =   SPACE
                   MOVE    SPACE       TO  SPA-GMN24-TSYLSKJGNSTYMDW
                                                           (IDX)(1:7)
               ELSE
                   PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
                   MOVE    WRK-HENYMD    TO  SPA-GMN24-TSYLSKJGNSTYMDW
                                                                (IDX)
               END-IF
           END-PERFORM
      *
      *    年金編集
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL     ( IDX     >   10 )
                   OR        ( IDX     >   SPA-TNK-MAX )
      *
               MOVE    LNK-TNK-STYMD (IDX)
                                       TO  SPA-GMN24-TNKDPSTYMD (IDX)
               MOVE    LNK-TNK-STYMD (IDX) TO  WRK-SYMD
               PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
               MOVE    WRK-HENYMD      TO  SPA-GMN24-TNKDPSTYMDW(IDX)
      *
               MOVE    LNK-TNK-EDYMD (IDX)
                                       TO  SPA-GMN24-TNKDPEDYMD (IDX)
               MOVE    LNK-TNK-EDYMD (IDX) TO  WRK-SYMD
               IF  WRK-SYMD            =    ALL "9"
                   MOVE    ALL "9" TO  SPA-GMN24-TNKDPEDYMDW(IDX)(1:7)
               ELSE
                   PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
                   MOVE    WRK-HENYMD  TO  SPA-GMN24-TNKDPEDYMDW(IDX)
               END-IF
           END-PERFORM
           .
       31O-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
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
      *    カーソル指定のない時、入力した項目の次ぎへ
           IF     (SPA-ERRCD           =   SPACE)  AND
                  (SPA-GMN24-CUR       =   ZERO )
               PERFORM 50011-INPUT-CUR-SEC
               ADD     1               TO  SPA-GMN24-CUR
           END-IF
      *
           EVALUATE    SPA-GMN24-CUR
               WHEN    01
                   MOVE    "P024_TSRSELNUM"     TO  MCP-WIDGET
               WHEN    02
                   MOVE    "P024_TSYSTYMD"      TO  MCP-WIDGET
               WHEN    03
                   MOVE    "P024_TSYEDYMD"      TO  MCP-WIDGET
               WHEN   12
                   MOVE    "P024_TSYSKJGNSTYMD"      TO  MCP-WIDGET
               WHEN    04
                   MOVE    "BT1"                TO  MCP-WIDGET
               WHEN    05
                   MOVE    "BT2"                TO  MCP-WIDGET
               WHEN    06
                   MOVE    "P024_TNKSELNUM"     TO  MCP-WIDGET
               WHEN    07
                   MOVE    "P024_TNKSTYMD"      TO  MCP-WIDGET
               WHEN    08
                   MOVE    "P024_TNKEDYMD"      TO  MCP-WIDGET
               WHEN    09
                   MOVE    "BN1"                TO  MCP-WIDGET
               WHEN    10
                   MOVE    "BN2"                TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC          SECTION.
      *
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "P024_TSYLIST"
                   MOVE    1           TO  SPA-GMN24-CUR
               WHEN    "P024_TSRSELNUM"
                   MOVE    1           TO  SPA-GMN24-CUR
               WHEN    "P024_TSYSTYMD"
                   MOVE    2           TO  SPA-GMN24-CUR
               WHEN    "P024_TSYEDYMD"
                   MOVE    11          TO  SPA-GMN24-CUR
               WHEN    "P024_TSYSKJGNSTYMD"
                   MOVE    3            TO  SPA-GMN24-CUR
      *
               WHEN    "P024_TNKLIST"
                   MOVE    6           TO  SPA-GMN24-CUR
               WHEN    "P024_TNKSELNUM"
                   MOVE    6           TO  SPA-GMN24-CUR
               WHEN    "P024_TNKSTYMD"
                   MOVE    7           TO  SPA-GMN24-CUR
               WHEN    "P024_TNKEDYMD"
                   MOVE    8           TO  SPA-GMN24-CUR
           END-EVALUATE
      *
           .
      *
       50011-INPUT-CUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    登録処理
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
      *    低所得更新
               WHEN    "CLICKED"       ALSO    "BT1"
                   PERFORM 411-TSKRRK-KOUSIN-SEC
      *    低所得削除
               WHEN    "CLICKED"       ALSO    "BT2"
                   PERFORM 412-TSKRREK-DELETE-SEC
      *    年金更新
               WHEN    "CLICKED"       ALSO    "BN1"
                   PERFORM 413-TNKRRK-KOUSIN-SEC
      *    年金削除
               WHEN    "CLICKED"       ALSO    "BN2"
                   PERFORM 414-TNKRRK-DELETE-SEC
      *
      *     以外はエラー
               WHEN    "CLICKED"       ALSO     ANY
                   MOVE    "0110"          TO  SPA-ERRCD
                   MOVE    1               TO  SPA-GMN24-CUR
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    低所得者／更新
      *****************************************************************
       411-TSKRRK-KOUSIN-SEC           SECTION.
      *
           MOVE    1                   TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF  SPA-ERRCD           NOT =   SPACE
               GO      TO              411-TSKRRK-KOUSIN-EXT
           END-IF
      *
      *
           IF      SPA-GMN24-TSYSELNUM =   ZERO  OR  SPACE
               COMPUTE SPA-NAI24-TSYSELNUM =   SPA-TSY-MAX   +   1
               ADD     1               TO  SPA-TSY-MAX
               IF      SPA-TSY-MAX         >   20
                   MOVE   "0008"       TO  SPA-ERRCD
      *----(01.00.01) LINE ADD START --------------------------------
                   MOVE    2           TO  SPA-GMN24-CUR
      *----(01.00.01) LINE ADD END   --------------------------------
                   COMPUTE SPA-TSY-MAX =   SPA-TSY-MAX   -   1
                   GO     TO           411-TSKRRK-KOUSIN-EXT
               END-IF
               MOVE    SPA-TSY-MAX     TO  WRK-N-IDX
           END-IF
           MOVE    WRK-N-IDX           TO  IDX
           MOVE    SPA-GMN24-TSYSTYMDW TO  SPA-GMN24-TSYDPSTYMDW(IDX)
           MOVE    SPA-GMN24-TSYEDYMDW TO  SPA-GMN24-TSYDPEDYMDW(IDX)
           MOVE    SPA-GMN24-TSYSTYMD  TO  SPA-GMN24-TSYDPSTYMD (IDX)
           MOVE    SPA-GMN24-TSYEDYMD  TO  SPA-GMN24-TSYDPEDYMD (IDX)
           MOVE    SPA-GMN24-TSYSKJGNSTYMDW
                                       TO  SPA-GMN24-TSYLSKJGNSTYMDW
                                                                (IDX)
           MOVE    SPA-GMN24-TSYSKJGNSTYMD
                                       TO  SPA-GMN24-TSYLSKJGNSTYMD
                                                                (IDX)
      *
           INITIALIZE                  SPA-GMN24-TSYS-AREA
      *
           MOVE    2                   TO  SPA-GMN24-CUR
      *
           .
       411-TSKRRK-KOUSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    低所得者／削除
      *****************************************************************
       412-TSKRREK-DELETE-SEC          SECTION.
      *
           IF   SPA-NAI24-TSYSELNUM    =   ZERO  OR  SPACE
                GO      TO             412-TSKRREK-DELETE-EXT
           END-IF
      *
           INITIALIZE                  WRK-NAIBU-IDX-AREA
           MOVE    SPA-NAI24-TSYSELNUM TO  WRK-G-IDX
           MOVE    1                   TO  WRK-W-TBL
           PERFORM 4501-NAIBU-IDX-GET-SEC
           IF  WRK-N-IDX               =   ZERO
               MOVE    "2401"          TO  SPA-ERRCD
      *----(01.00.01) LINE ADD START --------------------------------
               MOVE    1               TO  SPA-GMN24-CUR
      *----(01.00.01) LINE ADD END   --------------------------------
               GO      TO              412-TSKRREK-DELETE-EXT
           END-IF
           MOVE    "1"                 TO  SPA-GMN24-TSYDELKBN
                                                     (WRK-N-IDX)
      *
           INITIALIZE                  SPA-GMN24-TSYS-AREA
      *
           MOVE    2                   TO  SPA-GMN24-CUR
      *
           .
       412-TSKRREK-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    年金／更新
      *****************************************************************
       413-TNKRRK-KOUSIN-SEC           SECTION.
      *
           MOVE    2                   TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF  SPA-ERRCD           NOT =   SPACE
               GO      TO              413-TNKRRK-KOUSIN-EXT
           END-IF
      *
      *
           IF      SPA-GMN24-TNKSELNUM =   ZERO  OR  SPACE
               COMPUTE SPA-NAI24-TNKSELNUM =   SPA-TNK-MAX   +   1
               ADD     1               TO  SPA-TNK-MAX
               IF  SPA-TNK-MAX         >   10
                   MOVE   "0008"       TO  SPA-ERRCD
      *----(01.00.01) LINE ADD START --------------------------------
                   MOVE    6           TO  SPA-GMN24-CUR
      *----(01.00.01) LINE ADD END   --------------------------------
                   COMPUTE SPA-TNK-MAX =   SPA-TNK-MAX   -   1
                   GO     TO           413-TNKRRK-KOUSIN-EXT
               END-IF
               MOVE    SPA-TNK-MAX     TO  WRK-N-IDX
           END-IF
           MOVE    WRK-N-IDX           TO  IDX
           MOVE    SPA-GMN24-TNKSTYMDW TO  SPA-GMN24-TNKDPSTYMDW(IDX)
           MOVE    SPA-GMN24-TNKEDYMDW TO  SPA-GMN24-TNKDPEDYMDW(IDX)
           MOVE    SPA-GMN24-TNKSTYMD  TO  SPA-GMN24-TNKDPSTYMD (IDX)
           MOVE    SPA-GMN24-TNKEDYMD  TO  SPA-GMN24-TNKDPEDYMD (IDX)
      *
           INITIALIZE                  SPA-GMN24-TNK-AREA
      *
           MOVE    7                   TO  SPA-GMN24-CUR
           .
       413-TNKRRK-KOUSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    年金／削除
      *****************************************************************
       414-TNKRRK-DELETE-SEC           SECTION.
      *
           IF   SPA-NAI24-TNKSELNUM    =   ZERO  OR  SPACE
                GO      TO             414-TNKRRK-DELETE-EXT
           END-IF
      *
           INITIALIZE                  WRK-NAIBU-IDX-AREA
           MOVE    SPA-NAI24-TNKSELNUM TO  WRK-G-IDX
           MOVE    2                   TO  WRK-W-TBL
           PERFORM 4501-NAIBU-IDX-GET-SEC
           IF  WRK-N-IDX               =   ZERO
               MOVE    "2406"          TO  SPA-ERRCD
               MOVE    6               TO  SPA-GMN24-CUR
               GO      TO              414-TNKRRK-DELETE-EXT
           END-IF
           MOVE    "1"                 TO  SPA-GMN24-TNKDELKBN
                                                     (WRK-N-IDX)
      *
           INITIALIZE                  SPA-GMN24-TNK-AREA
      *
           MOVE    7                   TO  SPA-GMN24-CUR
           .
       414-TNKRRK-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       490-TOUROKU-SEC             SECTION.
      *
      *    所得・年金レコード数を一時退避
           MOVE    SPA-TSY-MAX     TO  WRK-TSY-SMAX
           MOVE    SPA-TNK-MAX     TO  WRK-TNK-SMAX
      *    パラメタファイル再検索処理
           INITIALIZE                  LNK-TNK-AREA
           INITIALIZE                  LNK-TSY-AREA
           PERFORM 320-PARAFILE-KENSAKU-SEC
      *    初期表示時の所得・年金レコード数を保存
           MOVE    SPA-TSY-MAX     TO  WRK-TSY-MAX
           MOVE    SPA-TNK-MAX     TO  WRK-TNK-MAX
           MOVE    WRK-TSY-SMAX    TO  SPA-TSY-MAX
           MOVE    WRK-TNK-SMAX    TO  SPA-TNK-MAX
      *
      *    画面内容をパラメタ出力処理
           PERFORM 500-SPA-PARA-TSYRRK-SEC
           PERFORM 500-SPA-PARA-TNKRRK-SEC
      *
           .
       490-TOUROKU-EXT.
           EXIT.
      *****************************************************************
      *    低所得者画面の内容をパラメタへ保存
      *****************************************************************
       500-SPA-PARA-TSYRRK-SEC         SECTION.
      *
           MOVE    ZERO                TO  IDY
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL     ( IDX         >   20          )
                   OR        ( IDX         >   SPA-TSY-MAX )
               MOVE    SPACE               TO  LNK-TSY-KEY-O   (IDX)
      *        初期表示時の所得レコード数以内の場合
               IF  IDX                     <=  WRK-TSY-MAX
      *            削除データの場合
                   IF  SPA-GMN24-TSYDELKBN(IDX)   =   "1"
                       MOVE    ALL "9"     TO  LNK-TSY-UPYMD      (IDX)
                   ELSE
      *                変更前キー転送
                       MOVE    LNK-TSY-HOSPID (IDX)
                                           TO  LNK-TSY-HOSPID-O   (IDX)
                       MOVE    LNK-TSY-PTID   (IDX)
                                           TO  LNK-TSY-PTID-O     (IDX)
                       MOVE    LNK-TSY-NINSTYMD (IDX)
                                           TO  LNK-TSY-NINSTYMD-O (IDX)
      *                認定期間変更時、変更年月日・更新年月日転送
                       IF  ( SPA-GMN24-TSYDPSTYMD(IDX)
                                   NOT =   LNK-TSY-NINSTYMD(IDX)) OR
                           ( SPA-GMN24-TSYDPEDYMD(IDX)
                                   NOT =   LNK-TSY-NINEDYMD(IDX)) OR
                           ( SPA-GMN24-TSYLSKJGNSTYMD(IDX)
                                   NOT =   LNK-TSY-SKJGNSTYMD(IDX))
                           MOVE    SPA-SYSYMD  TO  LNK-TSY-UPYMD  (IDX)
                           MOVE    SPA-GMN24-TSYDPSTYMD (IDX)
                                           TO  LNK-TSY-NINSTYMD   (IDX)
                           MOVE    SPA-GMN24-TSYDPEDYMD (IDX)
                                           TO  LNK-TSY-NINEDYMD   (IDX)
                           MOVE    SPA-GMN24-TSYLSKJGNSTYMD (IDX)
                                           TO  LNK-TSY-SKJGNSTYMD (IDX)
                       END-IF
                   END-IF
                   MOVE    IDX             TO  IDY
                   PERFORM 510-PARA-TSYRRK-OUT-SEC
               ELSE
      *        初期表示時の所得レコード数を超える場合
                   IF  SPA-GMN24-TSYDELKBN (IDX)   =   SPACE
                       ADD     1               TO  IDY
      *
                       INITIALIZE                  LNK-TSY-REC (IDY)
                       MOVE    SPA-HOSPID      TO  LNK-TSY-HOSPID (IDY)
                       MOVE    SPA-GMN-PTID    TO  LNK-TSY-PTID (IDY)
                       MOVE    SPA-GMN24-TSYDPSTYMD (IDX)
                                           TO  LNK-TSY-NINSTYMD   (IDY)
                       MOVE    SPA-GMN24-TSYDPEDYMD (IDX)
                                           TO  LNK-TSY-NINEDYMD   (IDY)
                       MOVE    SPA-GMN24-TSYLSKJGNSTYMD (IDX)
                                           TO  LNK-TSY-SKJGNSTYMD
                                                                 (IDY)
                       MOVE    SPA-TERMID      TO  LNK-TSY-TERMID (IDY)
                       MOVE    SPA-SYSYMD      TO  LNK-TSY-CREYMD (IDY)
                       PERFORM 510-PARA-TSYRRK-OUT-SEC
                   END-IF
               END-IF
           END-PERFORM
           .
      *
       500-SPA-PARA-TSYRRK-EXT.
           EXIT.
           .
      *****************************************************************
      *    低所得者画面の内容をパラメタへ保存
      *****************************************************************
       510-PARA-TSYRRK-OUT-SEC         SECTION.
      *
      *    パラメタ登録
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "TSYRRK"            TO  PARA-FILEMEI
           MOVE    IDY                 TO  PARA-EDANUM
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PARA
           END-IF
           IF      FLG-PARA            =   1
               INITIALIZE                      PARA-REC
               MOVE    "P02"               TO  PARA-GYOUMUID
               MOVE    SPA-TERMID          TO  PARA-TERMID
               MOVE    "TSYRRK"            TO  PARA-FILEMEI
               MOVE    IDY                 TO  PARA-EDANUM
      *
               MOVE    LNK-TSY-REC(IDY)    TO  PARA-DATA-REC
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02 PARA INSERT ERR:"  MCP-RC
                           ",KEY2:" PARA-KEY(1:42)
               END-IF
           ELSE
               MOVE    LNK-TSY-REC(IDY)    TO  PARA-DATA-REC
      *
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02 PARA UPDATE ERR:"  MCP-RC
                           ",KEY2:" PARA-KEY(1:42)
               END-IF
           END-IF
      *
           .
       510-PARA-TSYRRK-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    年金画面の内容をパラメタへ保存
      *****************************************************************
       500-SPA-PARA-TNKRRK-SEC         SECTION.
      *
           MOVE    ZERO                TO  IDY
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL     ( IDX         >   10          )
                   OR        ( IDX         >   SPA-TNK-MAX )
               MOVE    SPACE               TO  LNK-TNK-KEY-O(IDX)
      *        初期表示時の所得レコード数以内の場合
               IF  IDX                     <=  WRK-TNK-MAX
      *            削除データの場合
                   IF  SPA-GMN24-TNKDELKBN(IDX)   =   "1"
                       MOVE    ALL "9"     TO  LNK-TNK-UPYMD   (IDX)
                   ELSE
      *                変更前キー転送
                       MOVE    LNK-TNK-HOSPID (IDX)
                                           TO  LNK-TNK-HOSPID-O(IDX)
                       MOVE    LNK-TNK-PTID (IDX)
                                           TO  LNK-TNK-PTID-O  (IDX)
                       MOVE    LNK-TNK-STYMD (IDX)
                                           TO  LNK-TNK-STYMD-O (IDX)
      *                認定期間変更時、変更年月日・更新年月日転送
                       IF  (SPA-GMN24-TNKDPSTYMD(IDX)
                                   NOT =   LNK-TNK-STYMD(IDX))  OR
                           (SPA-GMN24-TNKDPEDYMD(IDX)
                                   NOT =   LNK-TNK-EDYMD(IDX))
                         MOVE    SPA-SYSYMD  TO  LNK-TNK-UPYMD (IDX)
                         MOVE    SPA-GMN24-TNKDPSTYMD (IDX)
                                           TO  LNK-TNK-STYMD   (IDX)
                         MOVE    SPA-GMN24-TNKDPEDYMD (IDX)
                                           TO  LNK-TNK-EDYMD   (IDX)
                       END-IF
                   END-IF
                   MOVE    IDX             TO  IDY
                   PERFORM 510-PARA-TNKRRK-OUT-SEC
               ELSE
      *        初期表示時の所得レコード数を超える場合
                   IF  SPA-GMN24-TNKDELKBN (IDX)   =   SPACE
                       ADD     1               TO  IDY
      *
                       INITIALIZE                  LNK-TNK-REC (IDY)
                       MOVE    SPA-HOSPID      TO  LNK-TNK-HOSPID (IDY)
                       MOVE    SPA-GMN-PTID    TO  LNK-TNK-PTID   (IDY)
                       MOVE    SPA-GMN24-TNKDPSTYMD (IDX)
                                               TO  LNK-TNK-STYMD  (IDY)
                       MOVE    SPA-GMN24-TNKDPEDYMD (IDX)
                                               TO  LNK-TNK-EDYMD  (IDY)
                       MOVE    SPA-TERMID      TO  LNK-TNK-TERMID (IDY)
                       MOVE    SPA-SYSYMD      TO  LNK-TNK-CREYMD (IDY)
                       PERFORM 510-PARA-TNKRRK-OUT-SEC
                   END-IF
               END-IF
           END-PERFORM
           .
      *
       500-SPA-PARA-TNKRRK-EXT.
           EXIT.
           .
      *****************************************************************
      *    低所得者画面の内容をパラメタへ保存
      *****************************************************************
       510-PARA-TNKRRK-OUT-SEC         SECTION.
      *
      *    パラメタ登録
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "TNKRRK"            TO  PARA-FILEMEI
           MOVE    IDY                 TO  PARA-EDANUM
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PARA
           END-IF
           IF      FLG-PARA            =   1
               INITIALIZE                      PARA-REC
               MOVE    "P02"               TO  PARA-GYOUMUID
               MOVE    SPA-TERMID          TO  PARA-TERMID
               MOVE    "TNKRRK"            TO  PARA-FILEMEI
               MOVE    IDY                 TO  PARA-EDANUM
      *
               MOVE    LNK-TNK-REC(IDY)    TO  PARA-DATA-REC
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02 PARA INSERT ERR:"  MCP-RC
                           ",KEY2:" PARA-KEY(1:42)
               END-IF
           ELSE
               MOVE    LNK-TNK-REC(IDY)    TO  PARA-DATA-REC
      *
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02 PARA UPDATE ERR:"  MCP-RC
                           ",KEY2:" PARA-KEY(1:42)
               END-IF
           END-IF
      *
      *
           .
       510-PARA-TNKRRK-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
      *    入力個所のセット
           PERFORM 400-GMN-INPUT-SEC
      *
           MOVE    ZERO                TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       400-GMN-INPUT-SEC          SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN24-CUR
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    低所得　選択番号選択
               WHEN    ANY             ALSO    "P024_TSYLIST"
                   PERFORM 41012-TSYLIST-SEC
      *    低年金　選択番号選択
               WHEN    ANY             ALSO    "P024_TNKLIST"
                   PERFORM 41012-TNKLIST-SEC
           END-EVALUATE
           .
      *
       400-GMN-INPUT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    低所得者選択
      *****************************************************************
       41012-TSYLIST-SEC           SECTION.
      *
      *
           MOVE    ZERO                TO  WRK-SELNUM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX       >   SPA-TSY-MAX
               IF      P02-P024-TSYLIST-SELECT (IDX)  =   "T"
                   IF      IDX               =   SPA-NAI24-TSYSELNUM
                       CONTINUE
                   ELSE
                       MOVE    IDX               TO  WRK-SELNUM
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      WRK-SELNUM      NOT =   ZERO
               MOVE    WRK-SELNUM          TO  SPA-NAI24-TSYSELNUM
           END-IF
      *
           IF      SPA-NAI24-TSYSELNUM NOT =   ZERO
               MOVE     SPA-NAI24-TSYSELNUM    TO   WRK-RENNUMZ
               MOVE     WRK-RENNUMZ        TO   P02-P024-TSRSELNUM
               MOVE    2                   TO  SPA-GMN24-CUR
           END-IF
      *
           .
       41012-TSYLIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    年金／選択番号選択
      *****************************************************************
       41012-TNKLIST-SEC           SECTION.
      *
      *
           MOVE    ZERO                TO  WRK-SELNUM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX       >   SPA-TNK-MAX
               IF      P02-P024-TNKLIST-SELECT (IDX)  =   "T"
                   IF      IDX               =   SPA-NAI24-TNKSELNUM
                       CONTINUE
                   ELSE
                       MOVE    IDX               TO  WRK-SELNUM
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      WRK-SELNUM      NOT =   ZERO
               MOVE    WRK-SELNUM          TO  SPA-NAI24-TNKSELNUM
           END-IF
      *
           IF      SPA-NAI24-TNKSELNUM   NOT =   ZERO
               MOVE     SPA-NAI24-TNKSELNUM    TO   WRK-RENNUMZ
               MOVE     WRK-RENNUMZ        TO  P02-P024-TNKSELNUM
               MOVE    7                   TO  SPA-GMN24-CUR
           END-IF
      *
           .
       41012-TNKLIST-EXT.
           EXIT.
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェックと別画面処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
      *    登録時、必須入力チェック
           IF      FLG-TOUROKU     NOT =   ZERO
               PERFORM 4109-TOUROKU-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO      TO      410-INPUT-CHK-EXT
               END-IF
           END-IF
      *
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC          SECTION.
      *
      *    低所得　選択番号
           IF      P02-P024-TSRSELNUM  =   SPA-MAE24-TSYSELNUM
               MOVE    ZERO                TO  FLG-IN-TSYSELNUM
           ELSE
               MOVE    1                   TO  FLG-IN-TSYSELNUM
           END-IF
           MOVE    P02-P024-TSRSELNUM  TO  SPA-GMN24-TSYSELNUM
           MOVE    P02-P024-TSYSTYMD   TO  SPA-GMN24-TSYSTYMDW
           MOVE    P02-P024-TSYEDYMD   TO  SPA-GMN24-TSYEDYMDW
           MOVE    P02-P024-TSYSKJGNSTYMD  TO  SPA-GMN24-TSYSKJGNSTYMDW
      *
      *    低年金　選択番号
           IF      P02-P024-TNKSELNUM  =   SPA-MAE24-TNKSELNUM
               MOVE    ZERO                TO  FLG-IN-TNKSELNUM
           ELSE
               MOVE    1                   TO  FLG-IN-TNKSELNUM
           END-IF
           MOVE    P02-P024-TNKSELNUM  TO  SPA-GMN24-TNKSELNUM
           MOVE    P02-P024-TNKSTYMD   TO  SPA-GMN24-TNKSTYMDW
           MOVE    P02-P024-TNKEDYMD   TO  SPA-GMN24-TNKEDYMDW
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェックと別画面処理
      *****************************************************************
       4102-KIHON-CHK-SEC          SECTION.
      *
      *    低所得　選択番号
           PERFORM 41012-TSYSELNUM-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    低所得開始年月日
           PERFORM 41012-TSYSTYMD-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    低所得終了年月日
           PERFORM 41012-TSYEDYMD-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    食事標準負担減額開始日
           PERFORM 41012-TSYSKJGNSTYMD-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    低年金　選択番号
           PERFORM 41012-NENINSELNUM-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    低年金開始年月日
           PERFORM 41012-TNKSTYMD-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *    低年金終了年月日
           PERFORM 41012-TNKEDYMD-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    低所得者／選択番号 
      *****************************************************************
       41012-TSYSELNUM-SEC           SECTION.
      *
           IF      SPA-GMN24-TSYSELNUM =   SPACE
               MOVE    SPA-GMN24-TSYSELNUM TO  SPA-MAE24-TSYSELNUM
               MOVE    ZERO                TO  SPA-NAI24-TSYSELNUM
               GO      TO               41012-TSYSELNUM-EXT
           END-IF
      *
           INITIALIZE                       ORCSNUMAREA
           MOVE    SPA-GMN24-TSYSELNUM  TO  SNUM-INX
           CALL    "ORCSNUM"                USING
                                            ORCSNUMAREA
           IF     (SNUM-RC          NOT =   ZERO  )   OR
                  (SNUM-MINKBN      NOT =   SPACE )   OR
                  (SNUM-SYOKBN      NOT =   SPACE )
               MOVE    "2401"              TO  SPA-ERRCD
               MOVE    1                   TO  SPA-GMN24-CUR
               GO      TO                  41012-TSYSELNUM-EXT
           ELSE
               MOVE    SNUM-OUTNUM         TO  SPA-NAI24-TSYSELNUM
               MOVE    SNUM-OUTNUM         TO  WRK-RENNUMZ
               MOVE    WRK-RENNUMZ         TO  SPA-GMN24-TSYSELNUM
           END-IF
      *
           MOVE    SPA-GMN24-TSYSELNUM     TO  SPA-MAE24-TSYSELNUM
           IF      FLG-IN-TSYSELNUM    =   ZERO
               GO      TO      41012-TSYSELNUM-EXT
           END-IF
      *
      *    削除データを除く内部インデックスを取得
           INITIALIZE                   WRK-NAIBU-IDX-AREA
           MOVE    SPA-NAI24-TSYSELNUM  TO  WRK-G-IDX
           MOVE    1                    TO  WRK-W-TBL
           PERFORM 4501-NAIBU-IDX-GET-SEC
           IF      WRK-N-IDX            =   ZERO
               MOVE    "2401"           TO  SPA-ERRCD
               MOVE    SPACE            TO  SPA-GMN24-TSYSTYMDW
               MOVE    SPACE            TO  SPA-GMN24-TSYSTYMD
               MOVE    SPACE            TO  SPA-GMN24-TSYEDYMDW
               MOVE    SPACE            TO  SPA-GMN24-TSYEDYMD
               MOVE    SPACE            TO  SPA-GMN24-TSYSKJGNSTYMDW
               MOVE    SPACE            TO  SPA-GMN24-TSYSKJGNSTYMD
           ELSE
               MOVE  SPA-GMN24-TSYDPSTYMDW (WRK-N-IDX)
                                        TO  SPA-GMN24-TSYSTYMDW
               MOVE  SPA-GMN24-TSYDPEDYMDW (WRK-N-IDX)
                                        TO  SPA-GMN24-TSYEDYMDW
               MOVE  SPA-GMN24-TSYDPSTYMD  (WRK-N-IDX)
                                        TO  SPA-GMN24-TSYSTYMD
               MOVE  SPA-GMN24-TSYDPEDYMD  (WRK-N-IDX)
                                        TO  SPA-GMN24-TSYEDYMD
               MOVE  SPA-GMN24-TSYLSKJGNSTYMDW (WRK-N-IDX)
                                        TO  SPA-GMN24-TSYSKJGNSTYMDW
               MOVE  SPA-GMN24-TSYLSKJGNSTYMD (WRK-N-IDX)
                                        TO  SPA-GMN24-TSYSKJGNSTYMD
           END-IF
           .
       41012-TSYSELNUM-EXT.
           EXIT.
      *****************************************************************
      *    低所得者／開始年月日 4121120--->H12.11.20
      *****************************************************************
       41012-TSYSTYMD-SEC           SECTION.
      *
           IF      SPA-GMN24-TSYSTYMDW =   SPACE
               MOVE    SPACE               TO  SPA-GMN24-TSYSTYMDW
               MOVE    SPACE               TO  SPA-GMN24-TSYSTYMD
               GO  TO                   41012-TSYSTYMD-EXT
           END-IF
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    SPA-GMN24-TSYSTYMDW     TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  SPA-GMN24-TSYSTYMDW
               MOVE    SGDAY-SDAY          TO  SPA-GMN24-TSYSTYMD
           ELSE
               MOVE    "2402"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN24-CUR
           END-IF
           .
       41012-TSYSTYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    低所得者／終了年月日 4121120--->H12.11.20
      *****************************************************************
       41012-TSYEDYMD-SEC           SECTION.
      *
           IF    ( SPA-GMN24-TSYEDYMDW     =   SPACE )  AND
                 ( SPA-GMN24-TSYSTYMDW     =   SPACE )
               MOVE    SPACE               TO  SPA-GMN24-TSYEDYMDW
               MOVE    SPACE               TO  SPA-GMN24-TSYEDYMD
               GO  TO                     41012-TSYEDYMD-EXT
           END-IF
      *----(01.00.04) LINE ADD START --------------------------------
           IF     ((SPA-GMN24-TSYEDYMDW(1:7)   =   ALL "9" ) AND
                   (SPA-GMN24-TSYEDYMDW(8:)    =   SPACE   ))  OR
                  ( SPA-GMN24-TSYEDYMDW        =   SPACE    )
               MOVE    SPACE               TO  SPA-GMN24-TSYEDYMDW(1:7)
               MOVE    ALL "9"             TO  SPA-GMN24-TSYEDYMDW(1:7)
               MOVE    ALL "9"             TO  SPA-GMN24-TSYEDYMD
               GO  TO                      41012-TSYEDYMD-EXT
           END-IF
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    SPA-GMN24-TSYEDYMDW     TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  SPA-GMN24-TSYEDYMDW
               MOVE    SGDAY-SDAY          TO  SPA-GMN24-TSYEDYMD
           ELSE
               MOVE    "2403"              TO  SPA-ERRCD
               MOVE    3                   TO  SPA-GMN24-CUR
               GO  TO                   41012-TSYEDYMD-EXT
           END-IF
      *
           IF  SPA-GMN24-TSYSTYMD       <  SPA-GMN24-TSYEDYMD
               CONTINUE
           ELSE
               MOVE    "2404"              TO  SPA-ERRCD
               MOVE    3                   TO  SPA-GMN24-CUR
           END-IF
      *
           .
       41012-TSYEDYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    低所得者／食事標準負担減額開始日
      *****************************************************************
       41012-TSYSKJGNSTYMD-SEC           SECTION.
      *
           IF      SPA-GMN24-TSYSKJGNSTYMDW    =   SPACE
               MOVE    SPACE               TO  SPA-GMN24-TSYSKJGNSTYMD
               GO      TO      41012-TSYSKJGNSTYMD-EXT
           END-IF
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    SPA-GMN24-TSYSKJGNSTYMDW
                                       TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  SPA-GMN24-TSYSKJGNSTYMDW
               MOVE    SGDAY-SDAY          TO  SPA-GMN24-TSYSKJGNSTYMD
           ELSE
               MOVE    "2413"              TO  SPA-ERRCD
               MOVE    12                  TO  SPA-GMN24-CUR
               GO  TO                   41012-TSYSKJGNSTYMD-EXT
           END-IF
      *
           IF     (SPA-GMN24-TSYSTYMD  <=  SPA-GMN24-TSYSKJGNSTYMD) AND
                  (SPA-GMN24-TSYEDYMD  >=  SPA-GMN24-TSYSKJGNSTYMD)
               CONTINUE
           ELSE
               MOVE    "2414"              TO  SPA-ERRCD
               MOVE    12                  TO  SPA-GMN24-CUR
           END-IF
      *
           .
       41012-TSYSKJGNSTYMD-EXT.
           EXIT.
      *****************************************************************
      *    年金／選択番号 
      *****************************************************************
       41012-NENINSELNUM-SEC           SECTION.
      *
           IF  SPA-GMN24-TNKSELNUM     =   SPACE
               MOVE    SPA-GMN24-TNKSELNUM TO  SPA-MAE24-TNKSELNUM
               MOVE    ZERO                TO  SPA-NAI24-TNKSELNUM
               GO      TO               41012-NENINSELNUM-EXT
           END-IF
      *
           INITIALIZE                       ORCSNUMAREA
           MOVE    SPA-GMN24-TNKSELNUM  TO  SNUM-INX
           CALL    "ORCSNUM"                USING
                                            ORCSNUMAREA
           IF     (SNUM-RC          NOT =   ZERO  )   OR
                  (SNUM-MINKBN      NOT =   SPACE )   OR
                  (SNUM-SYOKBN      NOT =   SPACE )
               MOVE    "2406"           TO  SPA-ERRCD
               MOVE    6                TO  SPA-GMN24-CUR
               GO      TO               41012-NENINSELNUM-EXT
           ELSE
               MOVE    SNUM-OUTNUM      TO  SPA-NAI24-TNKSELNUM
               MOVE    SNUM-OUTNUM      TO  WRK-RENNUMZ
               MOVE    WRK-RENNUMZ      TO  SPA-GMN24-TNKSELNUM
           END-IF
      *
           MOVE    SPA-GMN24-TNKSELNUM TO  SPA-MAE24-TNKSELNUM
           IF      FLG-IN-TNKSELNUM    =   ZERO
               GO      TO               41012-NENINSELNUM-EXT
           END-IF
      *
      *    削除データを除く内部インデックスを取得
           INITIALIZE                   WRK-NAIBU-IDX-AREA
           MOVE    SPA-NAI24-TNKSELNUM  TO  WRK-G-IDX
           MOVE    2                    TO  WRK-W-TBL
           PERFORM 4501-NAIBU-IDX-GET-SEC
           IF  WRK-N-IDX                =   ZERO
               MOVE    "2406"           TO  SPA-ERRCD
               MOVE    6                TO  SPA-GMN24-CUR
               MOVE    SPACE            TO  SPA-GMN24-TNKSTYMDW
               MOVE    SPACE            TO  SPA-GMN24-TNKEDYMDW
               MOVE    SPACE            TO  SPA-GMN24-TNKSTYMD
               MOVE    SPACE            TO  SPA-GMN24-TNKEDYMD
           ELSE
               MOVE  SPA-GMN24-TNKDPSTYMDW (WRK-N-IDX)
                                        TO  SPA-GMN24-TNKSTYMDW
               MOVE  SPA-GMN24-TNKDPEDYMDW (WRK-N-IDX)
                                        TO  SPA-GMN24-TNKEDYMDW
               MOVE  SPA-GMN24-TNKDPSTYMD  (WRK-N-IDX)
                                        TO  SPA-GMN24-TNKSTYMD
               MOVE  SPA-GMN24-TNKDPEDYMD  (WRK-N-IDX)
                                        TO  SPA-GMN24-TNKEDYMD
           END-IF
           .
       41012-NENINSELNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    年金／開始年月日 4121120--->H12.11.20
      *****************************************************************
       41012-TNKSTYMD-SEC       SECTION.
      *
           IF      SPA-GMN24-TNKSTYMDW =   SPACE
               MOVE    SPACE               TO  SPA-GMN24-TNKSTYMDW
               MOVE    SPACE               TO  SPA-GMN24-TNKSTYMD
               GO  TO                   41012-TNKSTYMD-EXT
           END-IF
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    SPA-GMN24-TNKSTYMDW     TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  SPA-GMN24-TNKSTYMDW
               MOVE    SGDAY-SDAY          TO  SPA-GMN24-TNKSTYMD
           ELSE
               MOVE    7                   TO  SPA-GMN24-CUR
               MOVE    "2407"              TO  SPA-ERRCD
           END-IF
            .
       41012-TNKSTYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    年金／終了年月日 4121120--->H12.11.20
      *****************************************************************
       41012-TNKEDYMD-SEC           SECTION.
      *
           IF     (SPA-GMN24-TNKEDYMDW    =   SPACE )  AND
                  (SPA-GMN24-TNKSTYMDW    =   SPACE )
               MOVE    SPACE              TO  SPA-GMN24-TNKEDYMDW
               MOVE    SPACE              TO  SPA-GMN24-TNKEDYMD
               GO  TO                     41012-TNKEDYMD-EXT
           END-IF
      *----(01.00.04) LINE ADD START --------------------------------
           IF    ((SPA-GMN24-TNKEDYMDW(1:7)   =   ALL "9" )  AND
                  (SPA-GMN24-TNKEDYMDW(8:)    =   SPACE   ) )  OR
                 ( SPA-GMN24-TNKEDYMDW        =   SPACE     )
               MOVE    ALL "9"             TO  SPA-GMN24-TNKEDYMDW (1:7)
               MOVE    ALL "9"             TO  SPA-GMN24-TNKEDYMD
               GO  TO                      41012-TNKEDYMD-EXT
           END-IF
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    SPA-GMN24-TNKEDYMDW     TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  SPA-GMN24-TNKEDYMDW
               MOVE    SGDAY-SDAY          TO  SPA-GMN24-TNKEDYMD
           ELSE
               MOVE    8                   TO  SPA-GMN24-CUR
               MOVE    "2408"              TO  SPA-ERRCD
               GO  TO                   41012-TNKEDYMD-EXT
           END-IF
      *
           IF      SPA-GMN24-TNKSTYMD  <  SPA-GMN24-TNKEDYMD
               CONTINUE
           ELSE
               MOVE    "2409"              TO  SPA-ERRCD
               MOVE    8                   TO  SPA-GMN24-CUR
           END-IF
           .
       41012-TNKEDYMD-EXT.
           EXIT.
      *
      ****************************************************************
      **    登録前関連チェック処理
      ****************************************************************
       4109-TOUROKU-CHK-SEC             SECTION.
      *    所得履歴登録
           IF      FLG-TOUROKU         =   1
               PERFORM 41091-SYOTOKU-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO      TO      4109-TOUROKU-CHK-EXT
               END-IF
           END-IF
      *    老年福祉年金履歴登録
           IF      FLG-TOUROKU         =   2
               PERFORM 41092-RFUKUSI-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO      TO      4109-TOUROKU-CHK-EXT
               END-IF
           END-IF
      *
           .
       4109-TOUROKU-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      **    所得履歴登録前チェック処理
      ****************************************************************
       41091-SYOTOKU-CHK-SEC             SECTION.
      *
           IF     (SPA-GMN24-TSYSTYMD  =   SPACE )  OR
                  (SPA-GMN24-TSYEDYMD  =   SPACE )
               MOVE    "2411"          TO  SPA-ERRCD
               MOVE     2              TO  SPA-GMN24-CUR
               GO      TO      41091-SYOTOKU-CHK-EXT
           END-IF
      *
           INITIALIZE                  WRK-NAIBU-IDX-AREA
           MOVE    SPA-NAI24-TSYSELNUM TO  WRK-G-IDX
           MOVE    1                   TO  WRK-W-TBL
           PERFORM 4501-NAIBU-IDX-GET-SEC
           PERFORM VARYING     IDX     FROM    1  BY  1
                   UNTIL       IDX     >   SPA-TSY-MAX
               IF  ( SPA-GMN24-TSYDELKBN(IDX)   =   SPACE )  AND
                   ( WRK-N-IDX              NOT =   IDX   )
      *        表示明細中に入力開始・終了日を含むデータが存在しないこと
                   IF  ( SPA-GMN24-TSYEDYMD
                                       <   SPA-GMN24-TSYDPSTYMD(IDX)) OR
                       ( SPA-GMN24-TSYSTYMD
                                       >   SPA-GMN24-TSYDPEDYMD(IDX))
                       CONTINUE
                   ELSE
                       MOVE   "2405"       TO  SPA-ERRCD
                       MOVE    2           TO  SPA-GMN24-CUR
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       41091-SYOTOKU-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      **    所得履歴登録前チェック処理
      ****************************************************************
       41092-RFUKUSI-CHK-SEC             SECTION.
      *
      *
           IF     (SPA-GMN24-TNKSTYMD  =   SPACE )  OR
                  (SPA-GMN24-TNKEDYMD  =   SPACE )
               MOVE    "2412"          TO  SPA-ERRCD
               MOVE    7               TO  SPA-GMN24-CUR
               GO      TO      41092-RFUKUSI-CHK-EXT
           END-IF
      *
      *    表示明細中に同開始日が存在しないこと
           INITIALIZE                  WRK-NAIBU-IDX-AREA
           MOVE    SPA-NAI24-TNKSELNUM TO  WRK-G-IDX
           MOVE    2                   TO  WRK-W-TBL
           PERFORM 4501-NAIBU-IDX-GET-SEC
           PERFORM VARYING     IDX     FROM    1  BY  1
                   UNTIL       IDX     >   SPA-TNK-MAX
             IF  ( SPA-GMN24-TNKDELKBN(IDX)   =   SPACE )  AND
                 ( WRK-N-IDX              NOT =   IDX   )
      *        表示明細中に入力開始・終了日を含むデータが存在しないこと
               IF  ( SPA-GMN24-TNKEDYMD < SPA-GMN24-TNKDPSTYMD(IDX)) OR
                   ( SPA-GMN24-TNKSTYMD > SPA-GMN24-TNKDPEDYMD(IDX))
                   CONTINUE
               ELSE
                   MOVE   "2410"       TO  SPA-ERRCD
      *----(01.00.01) LINE ADD START --------------------------------
                   MOVE    7           TO  SPA-GMN24-CUR
      *----(01.00.01) LINE ADD END   --------------------------------
                   GO      TO          41092-RFUKUSI-CHK-EXT
               END-IF
             END-IF
           END-PERFORM
      *
           .
       41092-RFUKUSI-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      **    内部インデックス取得処理　（削除データ除く）
      ****************************************************************
       4501-NAIBU-IDX-GET-SEC             SECTION.
      **
      * / WRK-G-IDX...画面上インデックス
      *   WRK-N-IDX...削除データ除く内部的なインデックス
      *
           MOVE    ZERO                   TO  WRK-N-IDX
           MOVE    ZERO                   TO  IDY
           EVALUATE    WRK-W-TBL
      *    所得テーブルより取得
           WHEN    1
               PERFORM   VARYING   IDX    FROM    1   BY  1
                         UNTIL    (IDX            >   20         )
                         OR       (IDX            >   SPA-TSY-MAX)
                         OR       (WRK-N-IDX      >   ZERO       )
                 IF  SPA-GMN24-TSYDELKBN (IDX)    =   SPACE
                     ADD     1                    TO  IDY
                     IF      IDY                  =   WRK-G-IDX
                         MOVE    IDX              TO  WRK-N-IDX
                     END-IF
                 END-IF
               END-PERFORM
      *
      *    年金テーブルより取得
           WHEN    2
               PERFORM   VARYING   IDX    FROM    1   BY  1
                         UNTIL    (IDX            >   10         )
                         OR       (IDX            >   SPA-TNK-MAX)
                         OR       (WRK-N-IDX      >   ZERO       )
                 IF  SPA-GMN24-TNKDELKBN (IDX)    =   SPACE
                     ADD     1                    TO  IDY
                     IF      IDY                  =   WRK-G-IDX
                         MOVE    IDX              TO  WRK-N-IDX
                     END-IF
                 END-IF
               END-PERFORM
           END-EVALUATE
           .
       4501-NAIBU-IDX-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦→和暦FORMAT日付編集
      *****************************************************************
       410112-SE-WAFORMAT-YMDEDIT-SEC             SECTION.
      *
           MOVE    SPACE               TO  STS-AREA-DAY
           INITIALIZE                      STS-AREA-DAY
           MOVE    SPACE               TO  LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"        USING  STS-AREA-DAY
                                           LNK-DAY2-AREA
           IF    STS-DAY-RC1            =   ZERO
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
           CALL    "ORCSDAY"    USING   STS-AREA-DAY  LNK-DAY2-AREA
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
           CALL    "ORCSDAY"    USING   STS-AREA-DAY  LNK-DAY1-AREA
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
      *    パラメタ情報読み込み
      *****************************************************************
       990-PARA-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PARA-REC
               MOVE    ZERO            TO  FLG-PARA
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           .
       990-PARA-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタファイル検索処理
      *****************************************************************
      *980-PARA-READ-SEC             SECTION.
      *
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
