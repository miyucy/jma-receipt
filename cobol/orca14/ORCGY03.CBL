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
       PROGRAM-ID.             ORCGY03.
1     *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 予約登録
      *  コンポーネント名  : 予約一覧、未院一覧（Ｙ０３）　
      *                     （Ｙ０１のサブ）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−    　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01.05.18  表題の修正
      *                                     医療機関ＩＤをスパよりセット
      *  01.00.02    MCC-藤原     01/05/24  患者番号ゼロ詰め処理
      *  01.00.03    NACL-多々納  03/05/19  診療内容・ドクター選択追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    予約用ワークスパ領域
           COPY    "Y01COMMON-SPA".
      *    スパ領域
       01  SPA-Y03.
           03  SPA-STS                 PIC 9(04).
      *    03  SPA-ERRCD               PIC X(04).
           03  SPA-CTLSEQ              PIC 9(02).
      *
           03  SPA-Y03-AREA.
               05  SPA-GMN-PAGE            PIC 9(02).
               05  SPA-GMN-LINE            PIC 9(02).
               05  SPA-GMN-MAX             PIC 9(02).
               05  SPA-GMN-CUR             PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SINYMD      PIC X(12).
                   07  SPA-GMN-MIDASI      PIC X(12).
      *
                   07  SPA-GMN-SINRYO.
                       09  SPA-GMN-SINRYOCD    PIC X(02).
                       09  SPA-GMN-SK1         PIC X(01).
                       09  SPA-GMN-SINRYOMEI   PIC X(18).
                   07  SPA-GMN-SINRYOLST       PIC X(21)   OCCURS  31.
                   07  SPA-SINRYO-MAX          PIC 9(04).
      *
                   07  SPA-GMN-DRNAME.
                       09  SPA-GMN-DRCD        PIC X(04).
                       09  SPA-GMN-D1          PIC X(01).
                       09  SPA-GMN-DRCDMEI     PIC X(24).
                   07  SPA-GMN-DRNAMELST       OCCURS  50.
                       09  SPA-GMN-DRNCDL      PIC X(04).
                       09  SPA-GMN-D1L         PIC X(01).
                       09  SPA-GMN-DRNAMEMEIL  PIC X(24).
                   07  SPA-DRCD-MAX            PIC 9(04).
      *
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-TBLO    OCCURS  100.
                           11  SPA-GMN-TBANGO      PIC 9(03).
                           11  SPA-GMN-TYYKTIME    PIC X(04).
                           11  SPA-GMN-TSRYKA      PIC X(20).
                           11  SPA-GMN-TSINRYO     PIC X(08).
                           11  SPA-GMN-TDRNAME     PIC X(20).
                           11  SPA-GMN-TKNJNAME    PIC X(30).
                           11  SPA-GMN-TPTNUM      PIC X(20).
                           11  SPA-GMN-TRENRAKU    PIC X(10).
                           11  SPA-GMN-TRAIIN      PIC X(04).
                   07  SPA-GMN-SELBAN          PIC 9(04).
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-SINYMD          PIC X(08).
                   07  SPA-NAI-DRNCD           PIC X(05).
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBLO    OCCURS  100.
                           11  SPA-NAI-TSRYKA      PIC X(02).
                           11  SPA-NAI-TKYYKTIME   PIC X(04). 
                           11  SPA-NAI-TSINRYO     PIC X(02).
                           11  SPA-NAI-TDRNCD      PIC X(05).
                           11  SPA-NAI-TRAIIN      PIC X(01).
                           11  SPA-NAI-TYYKID      PIC 9(02).
                           11  SPA-NAI-TRENRAKU    PIC X(01).
                           11  SPA-NAI-TPTID       PIC 9(10).
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC X(03).
           03  FLG-YYK             PIC X(01).
           03  FLG-KNJHEN          PIC X(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
           03  FLG-SYORI           PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
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
           03  IDX-D               PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-PTNUM           PIC X(20).
      *
           03  WRK-ERRMSG          PIC X(40).
      *
           03  WRK-PATH                PIC X(64).
      *
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
           03  WRK-HENTIME.
               05                  PIC X(01)   VALUE   SPACE.
               05  WRK-HTIME1      PIC X(02).
               05  WRK-HK1         PIC X(01).
               05  WRK-HTIME2      PIC X(02).
               05                  PIC X(01)   VALUE   SPACE.
      *    テーブルソート用ワーク
       01  WRK-SORT-AREA.
           03  WRK-YYKTIME         PIC X(04).
           03  WRK-YYKID           PIC X(02).
           03  WRK-IDX             PIC 9(04).
           03  WRK-GMN-TBL.
               05  WRK-GMN-TBLO    OCCURS  100.
                   07  WRK-GMN-TBANGO      PIC 9(03).
                   07  WRK-GMN-TYYKTIME    PIC X(04).
                   07  WRK-GMN-TSRYKA      PIC X(20).
                   07  WRK-GMN-TSINRYO     PIC X(08).
                   07  WRK-GMN-TDRNAME     PIC X(20).
                   07  WRK-GMN-TKNJNAME    PIC X(30).
                   07  WRK-GMN-TKNJNO      PIC X(20).
                   07  WRK-GMN-TRENRAKU    PIC X(10).
                   07  WRK-GMN-TRAIIN      PIC X(04).
      *
           03  WRK-NAI-TBL.
               05  WRK-NAI-TBLO    OCCURS  100.
                   07  WRK-NAI-TSRYKA      PIC X(02).
                   07  WRK-NAI-TKYYKTIME   PIC X(04).  
                   07  WRK-NAI-TSINRYO     PIC X(02).
                   07  WRK-NAI-TDRNCD      PIC X(05).
                   07  WRK-NAI-TRAIIN      PIC X(01).
                   07  WRK-NAI-TYYKID      PIC 9(02).
                   07  WRK-NAI-TRENRAKU    PIC X(01).
                   07  WRK-NAI-TKNJID      PIC X(10).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    診療内容情報
           COPY    "CPSK1012.INC".
      *    診療科
           COPY    "CPSK1005.INC".
      *    職員情報
           COPY    "CPSK1010.INC".
      *    予約確認
           COPY    "CPSK0051.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    予約マスター
       01  YYK-REC.
           COPY    "CPYYK.INC".
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
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
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
           COPY    "Y01.INC".
      *****COPY    "Y02.INC".
           COPY    "Y03.INC".
           COPY    "Y04.INC".
           COPY    "YERR.INC".
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
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-Y03
           MOVE    SPA-WORK        TO  SPA-Y01KYOUTU  
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"           ALSO   "CLICKED"
                   PERFORM 210-GMNSENI
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
           MOVE    SPA-Y01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-Y03         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "YERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
      *    画面編集
           MOVE    SPACE                TO  LNK-KYOUTU
      *
      *****MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "Y03"                TO  MCP-WINDOW
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
           INITIALIZE              SPA-Y03-AREA
      *
           IF      LNK-KYOUTU         NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
           MOVE    SPA-WORK                TO  SPA-Y01KYOUTU
      *
           MOVE    ZERO                TO  SPA-GMN-SELBAN
      *    MOVE    ZERO                TO  SPA-NAI-SELBAN
      *
      *
           MOVE    SPA-Y01-YYKYMDS     TO  SPA-NAI-SINYMD
           MOVE    SPA-Y01-YYKYMDS     TO  WRK-SYMD
           COMPUTE WRK-HYY         =   WRK-SYY   -  1988
           MOVE    "H"             TO  WRK-HGO
           MOVE    WRK-SMM         TO  WRK-HMM
           MOVE    WRK-SDD         TO  WRK-HDD
           MOVE    WRK-HENYMD      TO  SPA-GMN-SINYMD
      *
           IF      SPA-Y01-YYKID   NOT =   ZERO
               MOVE    "（未院分）"    TO  SPA-GMN-MIDASI
           END-IF
      *
      *
      *    診療内容をＳＰＡにセット
           MOVE    SPACE               TO  SYS-1012-REC
           MOVE    "1012"              TO  SYS-1012-KANRICD
           MOVE    SPA-Y01-YYKYMDS     TO  ORC-DBYMD
      *    システム管理検索
           MOVE    SYS-1012-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYS-1012-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  SPA-SINRYO-MAX
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL      (IDX             >=  30  )   OR
                              (FLG-SYSKANRI    =   1   )
      *
               MOVE    MCPDATA-REC       TO  SYS-1012-REC
               ADD      1                TO  SPA-SINRYO-MAX
               MOVE    SYS-1012-KBNCD    TO  SPA-GMN-SINRYOCD
               MOVE    SPACE             TO  SPA-GMN-SK1
               MOVE    SYS-1012-SRYNAIYODSP
                                         TO  SPA-GMN-SINRYOMEI
               MOVE    SPA-GMN-SINRYO    TO  SPA-GMN-SINRYOLST (IDX)
      *
               MOVE    "SYSKANRI-KEY2"         TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *    全体
           ADD     1                   TO  SPA-SINRYO-MAX
           MOVE    "00"                TO  SPA-GMN-SINRYOLST
                                                   (SPA-SINRYO-MAX)
                                                   (1:2)
           MOVE    SPACE               TO  SPA-GMN-SINRYOLST
                                                   (SPA-SINRYO-MAX)
                                                   (3:1)
           MOVE    "全体"              TO  SPA-GMN-SINRYOLST
                                                   (SPA-SINRYO-MAX)
                                                   (4:)
      *    職員情報をＳＰＡにセット
           MOVE    SPACE               TO  SYS-1010-REC
           MOVE    "1010"              TO  SYS-1010-KANRICD
           MOVE    SPA-Y01-YYKYMDS     TO  ORC-DBYMD
      *    システム管理検索
           MOVE    SYS-1010-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYS-1010-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  SPA-DRCD-MAX
           MOVE    ZERO                TO  IDX
           PERFORM
                   UNTIL      (IDX               >=  49  )   OR
                              (FLG-SYSKANRI      =   1   )
      *
               MOVE    MCPDATA-REC      TO  SYS-1010-REC
               IF      SYS-1010-KBNCD(1:1) =   "1"
                   ADD     1                   TO  IDX
                   MOVE    SYS-1010-KBNCD(2:4) TO  SPA-GMN-DRCD
                   MOVE    SPACE               TO  SPA-GMN-D1
                   MOVE    SYS-1010-NAME       TO  SPA-GMN-DRCDMEI
                   MOVE    SPA-GMN-DRNAME      TO  SPA-GMN-DRNAMELST
                                                               (IDX)
                   ADD     1                   TO  SPA-DRCD-MAX
               END-IF
      *
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           ADD     1                   TO  SPA-DRCD-MAX
           MOVE    "9999"              TO  SPA-GMN-DRNAMELST
                                                (SPA-DRCD-MAX)(1:4)
           MOVE    SPACE               TO  SPA-GMN-DRNAMELST
                                                (SPA-DRCD-MAX)(5:1)
           MOVE    "指定なし"          TO  SPA-GMN-DRNAMELST
                                                (SPA-DRCD-MAX)(6:)
      *
           MOVE    SPA-Y01-SRYNAIYOG   TO  SPA-GMN-SINRYO
           MOVE    SPA-Y01-DRNAME      TO  SPA-GMN-DRNAME
           MOVE    SPA-Y01-DRCD        TO  SPA-NAI-DRNCD
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL      (IDX-D   >   SPA-SINRYO-MAX )
               IF     SPA-GMN-SINRYOCD     =   SPA-GMN-SINRYOLST(IDX-D)
                                                            (1:2)
                   MOVE    SPA-GMN-SINRYOLST(IDX-D) 
                                               TO  SPA-GMN-SINRYO
                   MOVE    SPA-SINRYO-MAX      TO  IDX-D
                   MOVE    1                   TO  FLG-CHK
               END-IF
           END-PERFORM
     *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL      (IDX-D   >   SPA-DRCD-MAX )
               IF      SPA-NAI-DRNCD(2:4)  =   SPA-GMN-DRNCDL(IDX-D)
                   MOVE    SPA-GMN-DRNAMELST(IDX-D)
                                           TO  SPA-GMN-DRNAME
                   MOVE    SPA-DRCD-MAX    TO  IDX-D
                   MOVE    1                   TO  FLG-CHK
               END-IF
           END-PERFORM
      *
           PERFORM 310-SPASET-SEC
      *
           MOVE    1               TO  SPA-GMN-PAGE
           MOVE    1               TO  SPA-GMN-CUR
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    予約マスタ編集処理
      *****************************************************************
       310-SPASET-SEC           SECTION.
      *
           INITIALIZE                  SPA-GMN-TBL
           INITIALIZE                  SPA-NAI-TBL
      *
      *    予約一覧編集
           INITIALIZE                  YYK-KEY
           INITIALIZE                  YYK-REC
           MOVE    SPA-HOSPID          TO  YYK-HOSPID
           MOVE    SPA-Y01-YYKYMDS     TO  YYK-YYKYMD
           MOVE    SPA-GMN-SINRYOCD    TO  YYK-SRYNAIYO
           MOVE    SPA-NAI-DRNCD       TO  YYK-DRCD
           IF     (SPA-GMN-SINRYOCD    =   "00"  )  OR
                  (SPA-NAI-DRNCD(2:4)  =   "9999")
               MOVE    "YYK-KEY5"          TO  WRK-PATH
           ELSE
               MOVE    "YYK-KEY3"          TO  WRK-PATH
           END-IF
      *
           MOVE    YYK-REC             TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 900-YOYAKU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-YYK
           END-IF
           MOVE    ZERO                TO  IDX
           PERFORM
                   UNTIL       FLG-YYK      =   1
               MOVE    ZERO                TO  FLG-SYORI
               IF     (SPA-GMN-SINRYOCD    =   "00"  )  OR
                      (SPA-NAI-DRNCD(2:4)   =   "9999")
                   IF      SPA-GMN-SINRYOCD    NOT =   "00"
                       IF      SPA-GMN-SINRYOCD    =  YYK-SRYNAIYO
                           MOVE    1           TO  FLG-SYORI
                       END-IF
                   END-IF
                   IF      SPA-NAI-DRNCD(2:4)   NOT =   "9999"
                       IF      SPA-NAI-DRNCD        =  YYK-DRCD
                           MOVE    1           TO  FLG-SYORI
                       END-IF
                   END-IF
                   IF     (SPA-GMN-SINRYOCD    =   "00"  )  AND
                          (SPA-NAI-DRNCD(2:4)   =   "9999")
                       MOVE    1           TO  FLG-SYORI
                   END-IF
               ELSE
                   MOVE    1               TO  FLG-SYORI
               END-IF
               IF      FLG-SYORI           =   1
      *
                   IF     (YYK-YYKID       >   ZERO           )  AND
                          ((SPA-Y01-YYKID      =   ZERO  )  OR
                          ((SPA-Y01-YYKID  NOT =   ZERO  ) AND
                           (YYK-RAIINZUMI      =   SPACE )) )
                       PERFORM 3101-YOYAKU-HEN-SEC
                   END-IF
               END-IF
      *
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 900-YOYAKU-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
                                        MCPDATA-REC
      *
           MOVE    IDX             TO  SPA-GMN-MAX
      *
           PERFORM 3001-TBL-SORT-SEC
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    予約マスタ編集処理
      *****************************************************************
       3101-YOYAKU-HEN-SEC           SECTION.
      *
           ADD     1               TO  IDX
           MOVE    IDX             TO  SPA-GMN-TBANGO  (IDX)
           MOVE    YYK-KEYYYKTIME  TO  SPA-NAI-TKYYKTIME (IDX)
           MOVE    YYK-YYKTIME     TO  SPA-GMN-TYYKTIME(IDX)
           MOVE    YYK-SRYKA       TO  SPA-NAI-TSRYKA  (IDX)
           MOVE    YYK-SRYNAIYO    TO  SPA-NAI-TSINRYO (IDX)
           MOVE    YYK-DRCD        TO  SPA-NAI-TDRNCD  (IDX)
           MOVE    YYK-NAME        TO  SPA-GMN-TKNJNAME(IDX)
           MOVE    YYK-PTID        TO  SPA-NAI-TPTID   (IDX)
      *
           PERFORM 3001-PTNUM-HENSYU-SEC
           MOVE    WRK-PTNUM       TO  SPA-GMN-TPTNUM (IDX)
      *
           MOVE    YYK-KAKREN      TO  SPA-NAI-TRENRAKU(IDX)
           MOVE    YYK-RAIINZUMI   TO  SPA-NAI-TRAIIN  (IDX)
           MOVE    YYK-YYKID       TO  SPA-NAI-TYYKID  (IDX)
           IF      YYK-RAIINZUMI       =   "1"
               MOVE    "来院"          TO  SPA-GMN-TRAIIN(IDX)
           END-IF
      *
      *    ドクター
           MOVE    ZERO                TO  IDX-D
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL      (IDX-D   >   SPA-DRCD-MAX )
               IF     YYK-DRCD(2:4)        =   SPA-GMN-DRNCDL(IDX-D)
                   MOVE    SPA-GMN-DRNAMEMEIL(IDX-D)
                                           TO  SPA-GMN-TDRNAME (IDX)
                   MOVE    SPA-DRCD-MAX    TO  IDX-D
               END-IF
           END-PERFORM
      *
      *    診療内容
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL      (IDX-D   >   SPA-SINRYO-MAX )
               IF     YYK-SRYNAIYO         =   SPA-GMN-SINRYOLST(IDX-D)
                                                            (1:2)
                   MOVE    SPA-GMN-SINRYOLST(IDX-D) (4:)
                                           TO  SPA-GMN-TSINRYO(IDX)
                   MOVE    SPA-SINRYO-MAX  TO  IDX-D
               END-IF
           END-PERFORM
      *
      *    診療科
           MOVE    SPACE               TO  SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    YYK-SRYKA           TO  SYS-1005-KBNCD
           MOVE    SPA-NAI-SINYMD      TO  ORC-DBYMD
      *
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1005-REC
               MOVE    SYS-1005-SRYKANAME2 TO  SPA-GMN-TSRYKA(IDX)
           END-IF
      *
      *    予約確認連絡コード
           MOVE    SPACE               TO  SYS-0051-REC
           MOVE    "0051"              TO  SYS-0051-KANRICD
           MOVE    YYK-KAKREN          TO  SYS-0051-KBNCD
           MOVE    SPA-NAI-SINYMD      TO  ORC-DBYMD
      *
           MOVE    SYS-0051-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-0051-REC
               MOVE    SYS-0051-YYKKAKNAME TO  SPA-GMN-TRENRAKU(IDX)
           END-IF
           .
       3101-YOYAKU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスタ編集処理
      *****************************************************************
       3001-PTNUM-HENSYU-SEC           SECTION.
      *
      *    患者番号変換より、患者IDより患者NOを取得する
      *
           INITIALIZE                      ORCSPTIDAREA
      *----(01.00.01) LINE MOD START ---------------------------------
      *    MOVE    ALL "1"             TO  SPTID-HOSPID
           MOVE    SPA-HOSPID          TO  SPTID-HOSPID
      *----(01.00.01) LINE MOD END ----------------------------------- 
           MOVE    YYK-PTID            TO  SPTID-PTID
      *
           CALL    "ORCSPTID"          USING  ORCSPTIDAREA
      *----(01.00.02) LINE ADD START ----------------------------------
                                              SPA-1009-TBL
      *----(01.00.02) LINE ADD END   ----------------------------------
           IF      SPTID-RC        NOT =   ZERO
               MOVE    SPACE           TO  WRK-PTNUM
           ELSE
               MOVE    SPTID-PTNUM     TO  WRK-PTNUM
           END-IF
      *
           .
       3001-PTNUM-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＯＲＴ処理
      *****************************************************************
       3001-TBL-SORT-SEC              SECTION.
      *
           INITIALIZE                  WRK-SORT-AREA
           MOVE    SPA-GMN-TBL         TO  WRK-GMN-TBL
           MOVE    SPA-NAI-TBL         TO  WRK-NAI-TBL
           INITIALIZE                  SPA-GMN-TBL
           INITIALIZE                  SPA-NAI-TBL
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX
               MOVE    HIGH-VALUE          TO  WRK-YYKTIME
               MOVE    HIGH-VALUE          TO  WRK-YYKID
               MOVE    ZERO                TO  WRK-IDX
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   SPA-GMN-MAX
                   IF      WRK-GMN-TBANGO (IDY)  =   ZERO
                       CONTINUE
                   ELSE
                       IF      WRK-GMN-TYYKTIME (IDY)  <  WRK-YYKTIME
                           MOVE    WRK-GMN-TYYKTIME (IDY)
                                               TO  WRK-YYKTIME
                           MOVE    WRK-NAI-TYYKID   (IDY)
                                               TO  WRK-YYKID
                           MOVE    IDY         TO  WRK-IDX
                       END-IF
                   END-IF
               END-PERFORM
               IF      WRK-IDX         >   ZERO
                   MOVE    WRK-GMN-TBLO (WRK-IDX)
                                           TO  SPA-GMN-TBLO(IDX)
                   MOVE    WRK-NAI-TBLO (WRK-IDX)
                                           TO  SPA-NAI-TBLO(IDX)
                   MOVE    IDX             TO  SPA-GMN-TBANGO (IDX)
                   INITIALIZE              WRK-GMN-TBLO (WRK-IDX)
                   INITIALIZE              WRK-NAI-TBLO (WRK-IDX)
               END-IF
           END-PERFORM
      *
           .
       3001-TBL-SORT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
           MOVE    SPACE               TO  Y03
      *
           MOVE    SPA-GMN-SINYMD      TO  Y03-SRYMD
      *----(01.00.01) LINE ADD START ----------------------------------
           MOVE    SPA-GMN-MIDASI      TO  Y03-HYODAI
      *
           PERFORM VARYING     IDX     FROM    1  BY  1
                   UNTIL       IDX     >   SPA-SINRYO-MAX
               MOVE    SPA-GMN-SINRYOLST (IDX)
                                           TO  Y03-SRYNAIY-ITEM(IDX)
           END-PERFORM
           MOVE    SPA-SINRYO-MAX      TO  Y03-SRYNAIY-COUNT
           MOVE    SPA-GMN-SINRYO      TO  Y03-SRYNAIYO
      *
           PERFORM VARYING     IDX     FROM    1  BY  1
                   UNTIL       IDX     >  SPA-DRCD-MAX
               MOVE    SPA-GMN-DRNAMELST (IDX)
                                           TO  Y03-DRNAME-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-DRCD-MAX        TO  Y03-DRNAME-COUNT
           MOVE    SPA-GMN-DRNAME      TO  Y03-DRNAME
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX             >   SPA-GMN-MAX
               IF  SPA-GMN-TBANGO  (IDX)       NOT = ZERO
                   MOVE    SPA-GMN-TBANGO  (IDX)
                                               TO  Y03-TNUM (IDX)
               END-IF
               IF      SPA-GMN-TYYKTIME(IDX)   NOT =   SPACE
                   MOVE    SPA-GMN-TYYKTIME(IDX)(1:2)
                                           TO  Y03-TYYKTIME(IDX)(1:2)
                   MOVE    ":"             TO  Y03-TYYKTIME(IDX)(3:1)
                   MOVE    SPA-GMN-TYYKTIME(IDX)(3:2)
                                           TO  Y03-TYYKTIME(IDX)(4:2)
               END-IF
               MOVE    SPA-GMN-TSRYKA  (IDX)
                                               TO  Y03-TSRYKA  (IDX)
               MOVE    SPA-GMN-TSINRYO (IDX)
                                               TO  Y03-TSRYNAIYO (IDX)
               MOVE    SPA-GMN-TDRNAME (IDX)
                                               TO  Y03-TDRNAME (IDX)
               MOVE    SPA-GMN-TKNJNAME(IDX)   TO  Y03-TNAME(IDX)
               MOVE    SPA-GMN-TPTNUM  (IDX)   TO  Y03-TPTNUM  (IDX)
               MOVE    SPA-GMN-TRENRAKU(IDX)
                                               TO  Y03-TRENRAKU(IDX)
               MOVE    SPA-GMN-TRAIIN  (IDX)
                                               TO  Y03-TRAIIN  (IDX)
           END-PERFORM
           MOVE    SPA-GMN-MAX         TO  Y03-COUNT
      *
           PERFORM 5001-MAPCUR-SEC
      *
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       210-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *    一覧印刷
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 460-YYKICHI-SEC
      *    前ページ表示
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 430-MAEGMN-SEC
      *    次ページ表示
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 440-ATOGMN-SEC
           END-EVALUATE
      *
           .
       210-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "Y03"               TO  SPA-MOTOPG
           MOVE    "Y01"               TO  SPA-SAKIPG
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    "Y01"               TO  MCP-WINDOW
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
           MOVE    SPACE               TO  LNK-KYOUTU
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "Y03    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        診療内容
               WHEN    "ACTIVATE"      ALSO    "SRYNAIYO"
                   PERFORM 201-SRYNAIYO-HEN-SEC
      *        ドクタ−入力
               WHEN    "ACTIVATE"      ALSO    "DRNAME"
                   PERFORM 202-DRNAME-HEN-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *****************************************************************
      *    診療内容　　入力処理
      *****************************************************************
       201-SRYNAIYO-HEN-SEC       SECTION.
      *
           MOVE    Y03-SRYNAIYO        TO  SPA-GMN-SINRYO
      *
      *    診療内容
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL      (IDX-D   >   SPA-SINRYO-MAX )
               IF     SPA-GMN-SINRYOCD     =   SPA-GMN-SINRYOLST(IDX-D)
                                                            (1:2)
                   MOVE    SPA-GMN-SINRYOLST(IDX-D) 
                                               TO  SPA-GMN-SINRYO
                   MOVE    SPA-SINRYO-MAX      TO  IDX-D
                   MOVE    1                   TO  FLG-CHK
               END-IF
           END-PERFORM
           IF      FLG-CHK             =   ZERO
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    1                   TO  SPA-GMN-CUR
           ELSE
      *        画面再編集
               PERFORM 310-SPASET-SEC
               MOVE    2                   TO  SPA-GMN-CUR
           END-IF
          .
       201-SRYNAIYO-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ドクター　入力処理
      *****************************************************************
       202-DRNAME-HEN-SEC       SECTION.
      *
           MOVE    Y03-DRNAME          TO  SPA-GMN-DRNAME
      *
      *    診療内容
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL      (IDX-D   >   SPA-DRCD-MAX )
               IF      SPA-GMN-DRCD        =   SPA-GMN-DRNCDL(IDX-D)
                   MOVE    SPA-GMN-DRNAMELST(IDX-D)
                                           TO  SPA-GMN-DRNAME
                   MOVE    SPA-DRCD-MAX    TO  IDX-D
                   MOVE    1                   TO  FLG-CHK
               END-IF
           END-PERFORM
           IF      FLG-CHK             =   ZERO
               MOVE    "0002"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-CUR
           ELSE
               MOVE    "1"                 TO  SPA-NAI-DRNCD(1:1)
               MOVE    SPA-GMN-DRCD        TO  SPA-NAI-DRNCD(2:)
      *        画面再編集
               PERFORM 310-SPASET-SEC
               MOVE    3                   TO  SPA-GMN-CUR
           END-IF
          .
       202-DRNAME-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    一覧印刷　処理
      *****************************************************************
       460-YYKICHI-SEC           SECTION.
      *
          MOVE     SPA-GMN-SINRYOCD    TO  SPA-Y03-SRYNAIYO
          MOVE     SPA-NAI-DRNCD       TO  SPA-Y03-DRCD
      *
           CALL    "ORCHC14"       USING  MCPAREA
                                          SPA-AREA
                                          SPA-Y01KYOUTU 
           .
       460-YYKICHI-EXT.
           EXIT.
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       430-MAEGMN-SEC             SECTION.
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "Y03    "                  TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW
           .
       430-MAEGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       440-ATOGMN-SEC             SECTION.
      *
           .
       440-ATOGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
          EVALUATE    SPA-GMN-CUR
                WHEN    01
                    MOVE  "SRYNAIYO"    TO   MCP-WIDGET
                WHEN    02
                    MOVE  "DRNAME"      TO   MCP-WIDGET
                WHEN    OTHER
                    MOVE  "B01"         TO   MCP-WIDGET
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
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "診療内容が有りません"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "ドクターが有りません"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  YERR
           MOVE    SPA-ERRCD            TO  YERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  YERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "Y03"                TO  SPA-MOTOPG
           MOVE    "YERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "YERR"               TO  MCP-WINDOW
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
      *    予約マスター読込
      *****************************************************************
       900-YOYAKU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-YYK
               MOVE    MCPDATA-REC         TO  YYK-REC
           ELSE
               MOVE    1                   TO  FLG-YYK
           END-IF
           .
      *
       900-YOYAKU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-READ-EXT.
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
