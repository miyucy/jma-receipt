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
       PROGRAM-ID.                 ORCGXF01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : メモ登録入力
      *  コンポーネント名  : メモ登録（ＸＦ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/08/XX    NACL-多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    画面色等
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    画面スパ領域
           COPY    "XF01SCR-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PTMEMOINF       PIC 9(01).
           03  FLG-EXAMPLE         PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-TOROKU          PIC 9(01).
           03  FLG-OK              PIC 9(01).
      *
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX-S               PIC 9(04).
           03  IDX-S2              PIC 9(04).
           03  IDS                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD            PIC X(08).
           03  WRK-ZZZ             PIC ZZZ.
      *
           03  WRK-SRYKA-G.
               05  WRK-SRYKA       PIC X(02).
               05  WRK-SRYKAF      PIC X(01).
               05  WRK-SRYKA-MEI   PIC X(12).
           03  WRK-RENNUM          PIC 9(02).
           03  WRK-MEMOKBN         PIC 9(01).
           03  WRK-MEMO            PIC X(1000).
           03  WRK-MEMO-WK         PIC X(1000).
      *
           03  WRK-SELNUM          PIC 9(03).
      *    コラムリスト位置
           03  WRK-XF01-ROW            PIC S9(09).
           03  FLG-GMN-INIT            PIC  9(01).
      *
           03  WRK-MCP-WIDGET          PIC X(68).
           03  WRK-PATHNAME            PIC X(68).
      *
           03  WRK-XFIDMSG             PIC X(80).
      *TEST
      *
            03  WRK-MEMO-01           PIC X(100).
            03  WRK-MEMO-02           PIC X(100).
            03  WRK-MEMO-03           PIC X(100).
            03  WRK-MEMO-04           PIC X(100).
            03  WRK-MEMO-05           PIC X(100).
            03  CTR-1           PIC 9(03).
            03  CTR-2           PIC 9(03).
            03  CTR-3           PIC 9(03).
            03  CTR-4           PIC 9(03).
            03  CTR-5           PIC 9(03).
            03  PTR-A           PIC 9(03).
      *    年齢計算
       01  WRK-NENREI-AREA.
           03  WRK-YMDS1.
               05  WRK-YYS1            PIC 9(04).
               05  WRK-MMS1            PIC 9(02).
               05  WRK-DDS1            PIC 9(02).
           03  WRK-YMDS2.
               05  WRK-YYS2            PIC 9(04).
               05  WRK-MMS2            PIC 9(02).
               05  WRK-DDS2            PIC 9(02).
           03  WRK-NENREI.
               05  WRK-NENREI-YY       PIC 9(04).
               05  WRK-NENREI-MM       PIC 9(02).
               05  WRK-NENREI-DD       PIC 9(02).
      *    年齢表示
       01  WRK-NENREI-G.
           03  WRK-NENREI-Z        PIC ZZ9.
           03  WRK-NENREI-MEI      PIC X(04).
       01  WRK-NENREI-GR           REDEFINES   WRK-NENREI-G.
           03  WRK-NENREI-ZN       PIC Z9.
           03  WRK-NENREI-MEIN     PIC X(08).
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
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *
      *    COPY    "CPSK1001.INC".
      *
           COPY    "CPSK1005.INC".
      *
      *    患者メモ登録
       01  PTMEMOINF-REC.
           COPY    "CPPTMEMOINF.INC".
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
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
           COPY    "CPORCXKANACONV.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
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
           COPY    "XF01.INC".
           COPY    "XF011.INC".
           COPY    "XFERR.INC".
           COPY    "XFID1.INC".
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
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON          TO  SPA-AREA
      *****MOVE    SPA-WORK            TO  SPA-XF01KYOUTU
           MOVE    SPA-FREE            TO  SPA-XF01
      *
           MOVE    SPACE               TO  SPA-ERRCD
           MOVE    ZERO                TO  FLG-END
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
      **** MOVE    SPA-XF01KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA             TO  SPA-COMMON
           MOVE    SPA-XF01             TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "XFERR"
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
               MOVE    SPACE               TO  LNK-KYOUTU
      *
               MOVE   SPACE                TO  MCP-PUTTYPE
               MOVE   "XF01"               TO  MCP-WINDOW
               PERFORM 900-PUT-WINDOW
      *
               MOVE    1                   TO  FLG-END
           END-IF
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
           IF      LNK-KYOUTU      NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-AREA
           END-IF
      *
      *    内部画面より
           EVALUATE    SPA-MOTOPG
               WHEN    "XF011"
      *            文例選択より
                   MOVE    4                   TO  SPA-GMN-CUR
               WHEN    "XFID1"
      *            確認画面より
                   PERFORM 3002-XFID1-SET-SEC
               WHEN    OTHER
                   PERFORM 3001-SPA-INIT-SEC
           END-EVALUATE
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＸＤＩＤ１）ＯＫ処理
      *****************************************************************
       3002-XFID1-SET-SEC          SECTION.
      *
           EVALUATE    SPA-XFIDCD
               WHEN    "0001"
      *            登録の確認
                   IF      SPA-XFID1-FLG      =   "OK"
                       PERFORM 2121-TOUROKU-SYORI-SEC
                   ELSE
                       MOVE    1               TO  SPA-GMN-CUR
                   END-IF
               WHEN    "0002"
      *            コメント削除の確認
                   IF      SPA-XFID1-FLG      =   "OK"
                       PERFORM 2401-MEMO-DELSYORI-SEC
                   ELSE
                       MOVE    1                   TO  SPA-GMN-CUR
                   END-IF
               WHEN    "0003"
               WHEN    "0004"
      *            当日コメントの確認
                   PERFORM 42011-SELMEMO-SYORI-SEC
               WHEN    "0101"
      *            コメント１登録の確認
                   IF      SPA-XFID1-FLG      =   "OK"
                       PERFORM 21201-MEMO01-ADD-SEC
                   ELSE
                       MOVE    1                   TO  SPA-GMN-CUR
                   END-IF
               WHEN    "0102"
      *            コメント１削除の確認
                   IF      SPA-XFID1-FLG      =   "OK"
                       PERFORM 21201-MEMO01-DEL-SEC
                   ELSE
                       MOVE    1                   TO  SPA-GMN-CUR
                   END-IF
               WHEN    "0103"
                   IF      SPA-XFID1-FLG      =   "OK"
                       PERFORM 21201-MEMO02-ADD-SEC
                   ELSE
                       MOVE    3                   TO  SPA-GMN-CUR
                   END-IF
               WHEN    "0104"
      *            コメント１登録の確認
                   IF      SPA-XFID1-FLG      =   "OK"
                       PERFORM 21201-MEMO02-DEL-SEC
                   ELSE
                       MOVE    3                   TO  SPA-GMN-CUR
                   END-IF
           END-EVALUATE
           MOVE    SPACE               TO  SPA-XFIDCD
      *
           .
       3002-XFID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面編集処理
      *****************************************************************
       3001-SPA-INIT-SEC             SECTION.
      *
           INITIALIZE                  SPA-XF01
           MOVE    SPA-MOTOPG          TO  SPA-HZN-MOTOPG
      *
           MOVE    SPA-PTID            TO  SPA-GMN-PTID
           MOVE    SPA-PTNUM           TO  SPA-GMN-PTNUM
           MOVE    SPA-NAME            TO  SPA-GMN-NAME
           MOVE    SPA-BIRTHDAYW       TO  SPA-GMN-BIRTHDAY
           MOVE    SPA-SEX             TO  SPA-GMN-SEX
      *
      *    年齢計算
           MOVE    SPA-BIRTHDAY        TO  WRK-YMDS1
           MOVE    SPA-SYSYMD          TO  WRK-YMDS2
           COMPUTE WRK-NENREI-YY       =   WRK-YYS2
                                       -   WRK-YYS1
           IF      WRK-YMDS1(5:4)      >   WRK-YMDS2(5:4)
               COMPUTE WRK-NENREI-YY   =   WRK-NENREI-YY
                                           -   1
               COMPUTE WRK-NENREI-MM   =  (WRK-MMS2  +  12 )
                                           -   WRK-MMS1
           ELSE
               COMPUTE WRK-NENREI-MM   =   WRK-MMS2
                                           -   WRK-MMS1
           END-IF
           IF      WRK-DDS1            >   WRK-DDS2
               COMPUTE WRK-NENREI-MM   =   WRK-NENREI-MM
                                           -   1
           END-IF
      *    画面表示用
           IF      WRK-NENREI-YY       =   ZERO
               MOVE    WRK-NENREI-MM       TO  WRK-NENREI-ZN
               MOVE    "ヶ月"              TO  WRK-NENREI-MEIN
           ELSE
               MOVE    WRK-NENREI-YY       TO  WRK-NENREI-Z
               MOVE    "才"                TO  WRK-NENREI-MEI
           END-IF
           MOVE    WRK-NENREI-G        TO  SPA-GMN-NENREI
      *
           MOVE    SPA-SYSYMD          TO  SPA-NAI-SYSYMD
      *
           PERFORM 310-SPA-SET-SEC
      *
           IF      SPA-HZN-MOTOPG      =   "U02"
               MOVE    3               TO  SPA-GMN-CUR
           ELSE
               MOVE    1               TO  SPA-GMN-CUR
           END-IF
           .
       3001-SPA-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面編集処理
      *****************************************************************
       310-SPA-SET-SEC             SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    SPA-NAI-SYSYMD      TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  SPA-GMN-SYSYMD
      *
      *    診療科
           PERFORM 3102-SRYKA-HEN-SEC
      *    患者コメント一覧編集
           MOVE    ZERO                TO  SPA-GMN-NEXT
           MOVE    1                   TO  SPA-GMN-PAGE
           MOVE    2                   TO  SPA-NAI-MEMOKBN
           PERFORM 3101-PTMEMO-LIST-SEC
      *    患者コメント初期編集
           PERFORM 3103-PTMEMO-HEN-SEC
      *
           MOVE    1                   TO  SPA-GMN-CUR
           .
       310-SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    患者コメント一覧編集処理
      *****************************************************************
       3101-PTMEMO-LIST-SEC          SECTION.
      *
           INITIALIZE                      SPA-GMN-TBLG
           MOVE    ZERO                TO  SPA-GMN-SELNUM
      *
      *    患者メモ検索
           MOVE    SPACE               TO  PTMEMOINF-REC
           INITIALIZE                  PTMEMOINF-REC
           MOVE    SPA-HOSPNUM         TO  PTMEMOINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTMEMOINF-PTID
           MOVE    SPA-NAI-MEMOKBN     TO  PTMEMOINF-MEMOKBN
      *
           MOVE    PTMEMOINF-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    "key3"              TO  MCP-PATHNAME
               PERFORM 910-PTMEMOINF-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTMEMOINF
               INITIALIZE                  PTMEMOINF-REC
           END-IF
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDX-S2
           MOVE    ZERO                TO  SPA-GMN-NEXT
           IF      SPA-GMN-PAGE        =   ZERO
               MOVE    1               TO  SPA-GMN-PAGE
           END-IF
           COMPUTE IDX-S               =  (SPA-GMN-PAGE  -  1 )
                                       *   100
                                       +   1
           PERFORM UNTIL       (FLG-PTMEMOINF  =   1 )
               ADD     1               TO  IDX-S2
               IF      IDX-S2          >=  IDX-S
                   ADD     1                   TO  IDX
                   IF      IDX                 >   100
                       MOVE    1               TO  SPA-GMN-NEXT
                       MOVE    1               TO  FLG-PTMEMOINF
                   ELSE
                       PERFORM 3101-PTMEMOINF-SPAHEN-SEC
                   END-IF
               END-IF
      *
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    "key3"              TO  MCP-PATHNAME
               PERFORM 910-PTMEMOINF-READ-SEC
           END-PERFORM
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       3101-PTMEMO-LIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科名称編集処理
      *****************************************************************
       3101-PTMEMOINF-SPAHEN-SEC        SECTION.
      *
           MOVE    IDX                 TO  SPA-TBL-MAX
           MOVE    IDX                 TO  SPA-GMN-TNUM (IDX)
           MOVE    PTMEMOINF-SYSYMD    TO  SPA-NAI-TSYSYMD (IDX)
           MOVE    PTMEMOINF-RENNUM    TO  SPA-NAI-TRENNUM (IDX)
           MOVE    PTMEMOINF-SRYKA     TO  SPA-NAI-TSRYKA  (IDX)
           MOVE    PTMEMOINF-MEMO      TO  SPA-GMN-TMEMO   (IDX)
      *
           MOVE    PTMEMOINF-SYSYMD    TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-TSYSYMD (IDX)
      *
           MOVE    PTMEMOINF-SRYKA     TO  WRK-SRYKA
           PERFORM 31011-SRYKAMEI-HEN-SEC
           MOVE    WRK-SRYKA-MEI       TO  SPA-GMN-TSRYKA (IDX)
           .
       3101-PTMEMOINF-SPAHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科名称編集処理
      *****************************************************************
       31011-SRYKAMEI-HEN-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-SRYKA-MEI
           PERFORM VARYING     IDS     FROM    1   BY  1
                   UNTIL       IDS     >    SPA-SRYKA-MAX
               IF      SPA-GMN-SRYKAL (IDS)    =   WRK-SRYKA
                   MOVE    SPA-GMN-SRYKAMEIL (IDS)
                                           TO  WRK-SRYKA-MEI
                   MOVE    SPA-SRYKA-MAX   TO  IDS
               END-IF
           END-PERFORM
           IF      WRK-SRYKA-MEI       =   SPACE
               MOVE    WRK-SRYKA       TO  WRK-SRYKA-MEI
           END-IF
           .
       31011-SRYKAMEI-HEN-EXT.
      *
           EXIT.
      *****************************************************************
      *    患者コメント初期編集処理
      *****************************************************************
       3103-PTMEMO-HEN-SEC        SECTION.
      *
           INITIALIZE                  SPA-GMN-INPUT
      *    メモ１
           MOVE    1                   TO  WRK-MEMOKBN
           PERFORM 31031-PTMEMOINF-HEN-SEC
           MOVE    WRK-MEMO            TO  SPA-GMN-MEMO01
           IF      WRK-SRYKA       NOT =   SPACE
               PERFORM 31011-SRYKAMEI-HEN-SEC
               MOVE    WRK-SRYKA-G         TO  SPA-GMN-SRYKA01-G
           ELSE
      *        当日登録なし
               MOVE    SPA-GMN-SRYKA-LIST (1)  TO  SPA-GMN-SRYKA01-G
           END-IF
           MOVE    WRK-RENNUM          TO  SPA-NAI-RENNUM01
      *    メモ２
           MOVE    2                   TO  WRK-MEMOKBN
           PERFORM 31031-PTMEMOINF-HEN-SEC
           MOVE    WRK-MEMO            TO  SPA-GMN-MEMO02
           IF      WRK-SRYKA       NOT =   SPACE
               PERFORM 31011-SRYKAMEI-HEN-SEC
               MOVE    WRK-SRYKA-G         TO  SPA-GMN-SRYKA02-G
           ELSE
      *        当日登録なし
               MOVE    SPA-GMN-SRYKA-LIST (1)  TO  SPA-GMN-SRYKA02-G
           END-IF
           MOVE    WRK-RENNUM          TO  SPA-NAI-RENNUM02
      *
           .
       3103-PTMEMO-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者メモ検索編集処理
      *****************************************************************
       31031-PTMEMOINF-HEN-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-MEMO
           MOVE    SPACE               TO  WRK-SRYKA-G
           MOVE    ZERO                TO  WRK-RENNUM
      *
           MOVE    SPACE               TO  PTMEMOINF-REC
           INITIALIZE                  PTMEMOINF-REC
           MOVE    SPA-HOSPNUM         TO  PTMEMOINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTMEMOINF-PTID
           MOVE    WRK-MEMOKBN         TO  PTMEMOINF-MEMOKBN
           MOVE    SPA-NAI-SYSYMD      TO  PTMEMOINF-SYSYMD
      *
           MOVE    PTMEMOINF-REC      TO  MCPDATA-REC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-PTMEMOINF-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTMEMOINF
               INITIALIZE                  PTMEMOINF-REC
           END-IF
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      FLG-PTMEMOINF       =   ZERO
               MOVE    PTMEMOINF-RENNUM    TO  WRK-RENNUM
               MOVE    PTMEMOINF-SRYKA     TO  WRK-SRYKA
               MOVE    PTMEMOINF-MEMO      TO  WRK-MEMO
           END-IF
           .
       31031-PTMEMOINF-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科編集処理
      *****************************************************************
       3102-SRYKA-HEN-SEC        SECTION.
      *
           INITIALIZE                   SPA-GMN-SRYKA-LISTG
      *
      *    最初に全科指定を挿入
           ADD     1                   TO  SPA-SRYKA-MAX
           MOVE    "00"                TO  SPA-GMN-SRYKAL
                                                  (SPA-SRYKA-MAX)
           MOVE    "全科"              TO  SPA-GMN-SRYKAMEIL
                                                  (SPA-SRYKA-MAX)
      *    診療科
           MOVE    SPACE               TO  SYS-1005-REC
           MOVE    SPA-HOSPNUM         TO  SYS-1005-HOSPNUM
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SPA-NAI-SYSYMD      TO  SYS-1005-STYUKYMD
           MOVE    SYS-1005-STYUKYMD   TO  SYS-1005-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM
                   UNTIL      (FLG-SYSKANRI   =   1    )
                       OR     (SPA-SRYKA-MAX   >=  41 )
               ADD     1                   TO  SPA-SRYKA-MAX
      *
               MOVE    MCPDATA-REC         TO  SYS-1005-REC
               MOVE    SYS-1005-KBNCD(1:2) TO  SPA-GMN-SRYKAL
                                                   (SPA-SRYKA-MAX)
               MOVE    SYS-1005-SRYKANAME1 TO  SPA-GMN-SRYKAMEIL
                                                   (SPA-SRYKA-MAX)
      *
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       3102-SRYKA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦和暦編集処理
      *****************************************************************
       800-SEIWA-HEN-SEC             SECTION.
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
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
      *    コラムリスト位置保存
           IF      FLG-GMN-INIT        =   1
               MOVE    ZERO                TO  WRK-XF01-ROW
           ELSE
               MOVE    XF01-ROW            TO  WRK-XF01-ROW
           END-IF
      *
           MOVE    SPACE               TO  XF01
      *
      *    コラムリストの位置指定
           MOVE    ZERO                TO  XF01-ROW
           IF      WRK-XF01-ROW    NOT =   ZERO
               MOVE    WRK-XF01-ROW        TO  XF01-ROW
           END-IF
      *
      *    画面編集
           MOVE    SPA-GMN-PTNUM       TO  XF01-PTNUM
           MOVE    SPA-GMN-NAME        TO  XF01-NAME
           MOVE    SPA-GMN-SEX         TO  XF01-SEX
           MOVE    SPA-GMN-BIRTHDAY    TO  XF01-BIRTHDAY
           MOVE    SPA-GMN-NENREI      TO  XF01-NENREI
      *
           MOVE    SPA-GMN-SYSYMD      TO  XF01-SYSYMD
      *
           MOVE    SPA-GMN-MEMO01      TO  XF01-MEMO01
           MOVE    SPA-GMN-MEMO02      TO  XF01-MEMO02
      *
           IF      SPA-NAI-RENNUM01    =   ZERO
               MOVE    "（新規）"         TO  XF01-SYORI01-VALUE
               MOVE    "black"            TO  XF01-SYORI01-STYLE
           ELSE
               MOVE    "（更新）"         TO  XF01-SYORI01-VALUE
               MOVE    "blue"             TO  XF01-SYORI01-STYLE
           END-IF
           IF      SPA-NAI-RENNUM02   =   ZERO
               MOVE    "（新規）"         TO  XF01-SYORI02-VALUE
               MOVE    "black"            TO  XF01-SYORI02-STYLE
           ELSE
               MOVE    "（更新）"         TO  XF01-SYORI02-VALUE
               MOVE    "blue"             TO  XF01-SYORI02-STYLE
           END-IF
      *
      *    診療科１
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-SRYKA-MAX
               MOVE    SPA-GMN-SRYKA-LIST (IDX)
                                           TO  XF01-SRYKA01-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-SRYKA-MAX      TO  XF01-SRYKA01-COUNT
           MOVE    SPA-GMN-SRYKA01-G  TO  XF01-SRYKA01
      *    診療科２
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-SRYKA-MAX
               MOVE    SPA-GMN-SRYKA-LIST (IDX)
                                           TO  XF01-SRYKA02-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-SRYKA-MAX      TO  XF01-SRYKA02-COUNT
           MOVE    SPA-GMN-SRYKA02-G  TO  XF01-SRYKA02
      *
      *    一覧表
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-TBL-MAX
               MOVE    SPA-GMN-TNUM    (IDX)  TO  WRK-ZZZ
               MOVE    WRK-ZZZ                TO  XF01-TRENNUM (IDX)
               MOVE    SPA-GMN-TSYSYMD (IDX)  TO  XF01-TSYSYMD (IDX)
               MOVE    SPA-GMN-TSRYKA  (IDX)  TO  XF01-TSRYKA  (IDX)
               MOVE    SPA-GMN-TMEMO   (IDX)  TO  XF01-TMEMO   (IDX)
      *
               MOVE    "F"             TO  XF01-MEMOLIST-SELECT (IDX)
               IF      SPA-GMN-TNUM    (IDX)  =    SPA-GMN-SELNUM
                   MOVE    "T"         TO  XF01-MEMOLIST-SELECT (IDX)
                   IF      XF01-ROW        =   ZERO
                       MOVE    IDX             TO  XF01-ROW
                   END-IF
               END-IF
           END-PERFORM
           MOVE    SPA-TBL-MAX        TO  XF01-MEMOLIST-COUNT
           IF      SPA-NAI-MEMOKBN    =   1
               MOVE    "【　メ　モ　１　】"   TO  XF01-MIDASI-VALUE
               MOVE    "blue"                 TO  XF01-MIDASI-STYLE
           ELSE
               MOVE    "【　メ　モ　２　】"   TO  XF01-MIDASI-VALUE
               MOVE    "blue"                 TO  XF01-MIDASI-STYLE
           END-IF
      *
           MOVE    SPA-GMN-SELNUM     TO  XF01-SELNUM
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
           IF      SPA-GMN-CUR        =   ZERO
               PERFORM 50011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE    "SRYKA01"           TO  MCP-WIDGET
               WHEN    2
                   MOVE    "MEMO01"            TO  MCP-WIDGET
               WHEN    3
                   MOVE    "SRYKA02"           TO  MCP-WIDGET
               WHEN    4
                   MOVE    "MEMO02"            TO  MCP-WIDGET
               WHEN    5
                   MOVE    "SELNUM"            TO  MCP-WIDGET
               WHEN    99
                   MOVE    "B12"               TO  MCP-WIDGET
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
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "SRYKA01"
                   MOVE    2           TO  SPA-GMN-CUR
               WHEN    "MEMO01"
                   MOVE    3           TO  SPA-GMN-CUR
               WHEN    "SRYKA02"
                   MOVE    4           TO  SPA-GMN-CUR
               WHEN    "MEMO02"
                   MOVE    99          TO  SPA-GMN-CUR
               WHEN    OTHER
                   MOVE    1           TO  SPA-GMN-CUR
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
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 220-CLREA-SEC
      *        削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 240-DELETE-SEC
      *        一覧切替え
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 240-CHENGE-SEC
      *        前日
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 250-BACK-DAY-SEC
      *        次日
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 280-NEXT-DAY-SEC
      *        前頁
               WHEN    "CLICKED"       ALSO    "B06S"
                   PERFORM 260-BACK-PAGE-SEC
      *        次頁
               WHEN    "CLICKED"       ALSO    "B07S"
                   PERFORM 270-NEXT-PAGE-SEC
      *        メモ１登録
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 260-MEMO1-TOROKU-SEC
      *        メモ２登録
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 270-MEMO2-TOROKU-SEC
      *        メモ１削除
               WHEN    "CLICKED"       ALSO    "B05S"
                   PERFORM 260-MEMO1-DEL-SEC
      *        メモ２削除
               WHEN    "CLICKED"       ALSO    "B08S"
                   PERFORM 260-MEMO2-DEL-SEC
      *        メモ１へ
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 290-MEMO01-SEC
      *        メモ２へ
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 2100-MEMO02-SEC
      *        文例選択画面へ
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 2110-BUNREI-FX011-SEC
      *        登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 212-TOUROKU-SEC
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
      *        診療科
               WHEN    "ACTIVATE"      ALSO    "SRYKA01"
                   PERFORM 400-SRYKA01-SEC
      *        診療科
               WHEN    "ACTIVATE"      ALSO    "SRYKA02"
                   PERFORM 400-SRYKA02-SEC
      *        選択番号
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 420-SELNUM-SEC
      *        明細選択
               WHEN    ANY             ALSO    "MEMOLIST"
                   PERFORM 440-MEMOLIST-SEC
      *        その他
               WHEN    OTHER
                   PERFORM 490-ENTRY-SYORI-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    文例選択処理
      *****************************************************************
       2110-BUNREI-FX011-SEC             SECTION.
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
           MOVE    1                   TO  SPA-GMN-CUR
      *
           MOVE    SPACE               TO  SPA-MOTOPG
      *
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-XF01            TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGXF011"         USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA.
      *
           MOVE    SPA-COMMON          TO  SPA-AREA
           MOVE    SPA-FREE            TO  SPA-XF01
      *
      *    カーソル移動
           MOVE    "SELNUM"            TO  MCP-WIDGET
      *
           MOVE    "XF01"              TO  SPA-MOTOPG
           MOVE    "XF011"             TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "XF011"             TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       2110-BUNREI-FX011-EXT.
           EXIT.
      *
      *****************************************************************
      *    メモ１確定処理
      *****************************************************************
       260-MEMO1-TOROKU-SEC            SECTION.
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
      *    診療科チェック
           MOVE    1                   TO  FLG-TOROKU
           PERFORM 400-SRYKA01-SEC
           MOVE    1                   TO  SPA-GMN-CUR
      *
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-NAI-SYSYMD  NOT =   SPA-SYSYMD
                   MOVE    "0011"              TO  SPA-ERRCD
               END-IF
           END-IF
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-GMN-MEMO01      =   SPACE
                   MOVE    "0010"              TO  SPA-ERRCD
               END-IF
           END-IF
           IF      SPA-ERRCD           =   SPACE
               MOVE    "0101"              TO  SPA-XFIDCD
           END-IF
      *
           .
       260-MEMO1-TOROKU-EXT.
           EXIT.
      *****************************************************************
      *    メモ１確定処理
      *****************************************************************
       260-MEMO1-DEL-SEC             SECTION.
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
           MOVE    1                   TO  FLG-TOROKU
           PERFORM 400-SRYKA01-SEC
           MOVE    1                   TO  SPA-GMN-CUR
      *
           IF      SPA-NAI-RENNUM01    =   ZERO
               MOVE    "0012"              TO  SPA-ERRCD
           END-IF
           IF      SPA-ERRCD           =   SPACE
               MOVE    "0102"              TO  SPA-XFIDCD
           END-IF
      *
           .
       260-MEMO1-DEL-EXT.
           EXIT.
      *****************************************************************
      *    メモ１確定処理
      *****************************************************************
       260-MEMO2-DEL-SEC             SECTION.
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
           MOVE    1                   TO  FLG-TOROKU
           PERFORM 400-SRYKA02-SEC
           MOVE    1                   TO  SPA-GMN-CUR
      *
           IF      SPA-NAI-RENNUM02    =   ZERO
               MOVE    "0012"              TO  SPA-ERRCD
           END-IF
           IF      SPA-ERRCD           =   SPACE
               MOVE    "0104"              TO  SPA-XFIDCD
           END-IF
      *
           .
       260-MEMO2-DEL-EXT.
           EXIT.
      *****************************************************************
      *    メモ１確定処理
      *****************************************************************
       270-MEMO2-TOROKU-SEC             SECTION.
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
           MOVE    1                   TO  FLG-TOROKU
           PERFORM 400-SRYKA02-SEC
           MOVE    3                   TO  SPA-GMN-CUR
      *
           IF      SPA-NAI-SYSYMD  NOT =   SPA-SYSYMD
               MOVE    "0011"              TO  SPA-ERRCD
           END-IF
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-GMN-MEMO02      =   SPACE
                   MOVE    "0010"              TO  SPA-ERRCD
               END-IF
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    "0103"              TO  SPA-XFIDCD
           END-IF
      *
           .
       270-MEMO2-TOROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    メモ１確定処理
      *****************************************************************
       290-MEMO01-SEC                    SECTION.
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
           MOVE    1                   TO  SPA-GMN-CUR
      *
           .
       290-MEMO01-EXT.
           EXIT.
      *****************************************************************
      *    メモ２確定処理
      *****************************************************************
       2100-MEMO02-SEC                    SECTION.
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
           MOVE    3                   TO  SPA-GMN-CUR
      *
           .
       2100-MEMO02-EXT.
           EXIT.
      *****************************************************************
      *    診療科処理
      *****************************************************************
       400-SRYKA01-SEC                 SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           IF     (XF01-SRYKA01    NOT =   SPA-GMN-SRYKA01-G)
             AND  (SPA-NAI-MEMOKBN     =   1                )
               MOVE    ZERO                TO  SPA-GMN-SELNUM
           END-IF
      *
           MOVE    XF01-SRYKA01        TO  SPA-GMN-SRYKA01-G
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING    IDX      FROM    1   BY  1
                   UNTIL     (IDX      >   SPA-SRYKA-MAX )
                          OR (FLG-OK   =   1    )
               IF      SPA-GMN-SRYKA01     =   SPA-GMN-SRYKAL (IDX)
                   MOVE    SPA-GMN-SRYKA-LIST (IDX)
                                           TO  SPA-GMN-SRYKA01-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0001"              TO  SPA-ERRCD
           ELSE
               MOVE    2                   TO  SPA-GMN-CUR
               MOVE    SPA-GMN-SRYKA01     TO  WRK-SRYKA
               MOVE    1                   TO  WRK-MEMOKBN
               PERFORM 4001-PTMEMO-HEN-SEC
      *        登録前に連番の再設定
               IF      FLG-TOROKU          =   1
                   IF      WRK-RENNUM          =   SPA-NAI-RENNUM01
                       CONTINUE
                   ELSE
                       MOVE    WRK-RENNUM      TO  SPA-NAI-RENNUM01
                   END-IF
               ELSE
                   IF      WRK-RENNUM          =   ZERO
                       MOVE    ZERO                TO  SPA-NAI-RENNUM01
                       MOVE    SPACE               TO  SPA-GMN-MEMO01
                   ELSE
                       MOVE    WRK-MEMO            TO  SPA-GMN-MEMO01
                       MOVE    WRK-RENNUM          TO  SPA-NAI-RENNUM01
                   END-IF
               END-IF
           END-IF
      *
           .
       400-SRYKA01-EXT.
           EXIT.
      *****************************************************************
      *    患者メモ検索編集処理
      *****************************************************************
       4001-PTMEMO-HEN-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-MEMO
           MOVE    ZERO                TO  WRK-RENNUM
      *
           MOVE    SPACE               TO  PTMEMOINF-REC
           INITIALIZE                  PTMEMOINF-REC
           MOVE    SPA-HOSPNUM         TO  PTMEMOINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTMEMOINF-PTID
           MOVE    WRK-MEMOKBN         TO  PTMEMOINF-MEMOKBN
           MOVE    WRK-SRYKA           TO  PTMEMOINF-SRYKA
           MOVE    SPA-NAI-SYSYMD      TO  PTMEMOINF-SYSYMD
      *
           MOVE    PTMEMOINF-REC      TO  MCPDATA-REC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    "key4"              TO  MCP-PATHNAME
               PERFORM 910-PTMEMOINF-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTMEMOINF
               INITIALIZE                  PTMEMOINF-REC
           END-IF
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      FLG-PTMEMOINF       =   ZERO
               MOVE    PTMEMOINF-RENNUM    TO  WRK-RENNUM
               MOVE    PTMEMOINF-MEMO      TO  WRK-MEMO
           END-IF
           .
       4001-PTMEMO-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療科０２処理
      *****************************************************************
       400-SRYKA02-SEC                 SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR
      *
           IF     (XF01-SRYKA02    NOT =   SPA-GMN-SRYKA02-G)
             AND  (SPA-NAI-MEMOKBN     =   2                )
               MOVE    ZERO                TO  SPA-GMN-SELNUM
           END-IF
      *
           MOVE    XF01-SRYKA02        TO  SPA-GMN-SRYKA02-G
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING    IDX      FROM    1   BY  1
                   UNTIL     (IDX      >   SPA-SRYKA-MAX )
                          OR (FLG-OK   =   1    )
               IF      SPA-GMN-SRYKA02     =   SPA-GMN-SRYKAL (IDX)
                   MOVE    SPA-GMN-SRYKA-LIST (IDX)
                                           TO  SPA-GMN-SRYKA02-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0003"              TO  SPA-ERRCD
           ELSE
               MOVE    4                   TO  SPA-GMN-CUR
               MOVE    SPA-GMN-SRYKA02     TO  WRK-SRYKA
               MOVE    2                   TO  WRK-MEMOKBN
               PERFORM 4001-PTMEMO-HEN-SEC
      *        登録前に連番の再設定
               IF      FLG-TOROKU          =   1
                   IF      WRK-RENNUM          =   SPA-NAI-RENNUM02
                       CONTINUE
                   ELSE
                       MOVE    WRK-RENNUM      TO  SPA-NAI-RENNUM02
                   END-IF
               ELSE
                   IF      WRK-RENNUM          =   ZERO
                       MOVE    ZERO                TO  SPA-NAI-RENNUM02
                       MOVE    SPACE               TO  SPA-GMN-MEMO02
                   ELSE
                       MOVE    WRK-MEMO            TO  SPA-GMN-MEMO02
                       MOVE    WRK-RENNUM          TO  SPA-NAI-RENNUM02
                   END-IF
               END-IF
           END-IF
      *
           .
       400-SRYKA02-EXT.
           EXIT.
      *****************************************************************
      *    選択番号処理
      *****************************************************************
       420-SELNUM-SEC                 SECTION.
      *
           MOVE    5                   TO  SPA-GMN-CUR
      *
           MOVE    XF01-SELNUM         TO  SPA-GMN-SELNUM
      *
           IF      SPA-GMN-SELNUM      >   SPA-TBL-MAX
               MOVE    "0005"              TO  SPA-ERRCD
           ELSE
               IF      SPA-GMN-SELNUM      >   ZERO
                   PERFORM 4201-HENKOU-SYORI-SEC
               END-IF
           END-IF
           .
       420-SELNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号処理
      *****************************************************************
       4201-HENKOU-SYORI-SEC                 SECTION.
      *
           MOVE    SPA-GMN-SELNUM      TO  IDX
      *
           IF      SPA-SYSYMD          =   SPA-NAI-SYSYMD
               IF      SPA-NAI-TSYSYMD (IDX)   =   SPA-SYSYMD
                   MOVE    "0003"              TO  SPA-XFIDCD
               ELSE
                   MOVE    "0004"              TO  SPA-XFIDCD
               END-IF
           ELSE
               MOVE    "0004"              TO  SPA-XFIDCD
           END-IF
           .
       4201-HENKOU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号処理
      *****************************************************************
       42011-SELMEMO-SYORI-SEC            SECTION.
      *
           MOVE    SPA-GMN-SELNUM      TO  IDX
      *
      *    当日なら内容編集・以外はメモ複写
           MOVE    SPACE               TO  PTMEMOINF-REC
           INITIALIZE                  PTMEMOINF-REC
           MOVE    SPA-HOSPNUM         TO  PTMEMOINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTMEMOINF-PTID
           MOVE    SPA-NAI-MEMOKBN     TO  PTMEMOINF-MEMOKBN
           MOVE    SPA-NAI-TSYSYMD (IDX)
                                       TO  PTMEMOINF-SYSYMD
           MOVE    SPA-NAI-TSRYKA (IDX)
                                       TO  PTMEMOINF-SRYKA
           MOVE    SPA-NAI-TRENNUM (IDX)
                                       TO  PTMEMOINF-RENNUM
      *
           MOVE    PTMEMOINF-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 910-PTMEMOINF-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTMEMOINF
               INITIALIZE                  PTMEMOINF-REC
           END-IF
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      SPA-XFIDCD          =   "0003"
      *****IF      SPA-NAI-SYSYMD      =   SPA-NAI-TSYSYMD (IDX)
               IF      SPA-XFID1-FLG      =   "OK"
      *            当日コメントの更新
                   PERFORM 420111-SELMEMO-UPD-SEC
               ELSE
      *            コメントの置換
                   PERFORM 420112-SELMEMO-CHG-SEC
               END-IF
           ELSE
               IF      SPA-XFID1-FLG      =   "OK"
      *            メントの置換
                   PERFORM 420112-SELMEMO-CHG-SEC
               ELSE
      *            メントの追加
                   PERFORM 420113-SELMEMO-ADD-SEC
               END-IF
           END-IF
           MOVE    SPACE               TO  SPA-XFIDCD
           MOVE    SPACE               TO  SPA-XFID1-FLG
      *
           .
       4201-HENKOU-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    当日コメントの更新処理
      *****************************************************************
       420111-SELMEMO-UPD-SEC                 SECTION.
      *
           MOVE    PTMEMOINF-SRYKA     TO  WRK-SRYKA
           PERFORM 31011-SRYKAMEI-HEN-SEC
           IF      SPA-NAI-MEMOKBN     =   1
               MOVE    PTMEMOINF-SRYKA     TO  SPA-GMN-SRYKA01
               MOVE    WRK-SRYKA-G         TO  SPA-GMN-SRYKA01-G
               MOVE    PTMEMOINF-RENNUM    TO  SPA-NAI-RENNUM01
               MOVE    PTMEMOINF-MEMO      TO  SPA-GMN-MEMO01
               MOVE    2                   TO  SPA-GMN-CUR
           ELSE
               MOVE    PTMEMOINF-SRYKA     TO  SPA-GMN-SRYKA02
               MOVE    WRK-SRYKA-G         TO  SPA-GMN-SRYKA02-G
               MOVE    PTMEMOINF-RENNUM    TO  SPA-NAI-RENNUM02
               MOVE    PTMEMOINF-MEMO      TO  SPA-GMN-MEMO02
               MOVE    4                   TO  SPA-GMN-CUR
           END-IF
      *
           .
       420111-SELMEMO-UPD-EXT.
           EXIT.
      *****************************************************************
      *    コメントの置換処理
      *****************************************************************
       420112-SELMEMO-CHG-SEC                 SECTION.
      *
           IF      SPA-NAI-MEMOKBN     =   1
               MOVE    PTMEMOINF-MEMO      TO  SPA-GMN-MEMO01
               MOVE    2                   TO  SPA-GMN-CUR
           ELSE
               MOVE    PTMEMOINF-MEMO      TO  SPA-GMN-MEMO02
               MOVE    4                   TO  SPA-GMN-CUR
           END-IF
           MOVE    ZERO                TO  SPA-GMN-SELNUM
      *
           .
       420112-SELMEMO-CHG-EXT.
           EXIT.
      *****************************************************************
      *    コメントの追加処理
      *****************************************************************
       420113-SELMEMO-ADD-SEC                 SECTION.
      *
           IF      SPA-NAI-MEMOKBN     =   1
               MOVE    SPA-GMN-MEMO01      TO  WRK-MEMO
           ELSE
               MOVE    SPA-GMN-MEMO02      TO  WRK-MEMO
           END-IF
      *    コメント追加
           MOVE    SPACE               TO  WRK-MEMO-WK
           STRING  WRK-MEMO            DELIMITED   BY  SPACE
                   PTMEMOINF-MEMO      DELIMITED   BY  SPACE
                   INTO                WRK-MEMO-WK
           END-STRING
      *
           INITIALIZE                  ORCXKANACONVAREA
           MOVE    1000                TO  KANACONV-LEN
           MOVE    1000                TO  KANACONV-STLEN
           MOVE    0                   TO  KANACONV-CONV-FLAG
           MOVE    0                   TO  KANACONV-CHAR-TYPE
           MOVE    WRK-MEMO-WK         TO  KANACONV-INDATA
           CALL    "kanaconv"          USING ORCXKANACONVAREA
           MOVE    KANACONV-OUTDATA    TO  WRK-MEMO-WK
           IF      SPA-NAI-MEMOKBN     =   1
               MOVE    WRK-MEMO-WK         TO  SPA-GMN-MEMO01
               MOVE    2                   TO  SPA-GMN-CUR
           ELSE
               MOVE    WRK-MEMO-WK         TO  SPA-GMN-MEMO02
               MOVE    4                   TO  SPA-GMN-CUR
           END-IF
           MOVE    ZERO                TO  SPA-GMN-SELNUM
      *
           .
       420113-SELMEMO-ADD-EXT.
           EXIT.
      *****************************************************************
      *    明細選択処理
      *****************************************************************
       440-MEMOLIST-SEC                 SECTION.
      *
           MOVE    ZERO                TO  WRK-SELNUM
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL       IDX     >   SPA-TBL-MAX
               IF      XF01-MEMOLIST-SELECT (IDX)  =  "T"
                   MOVE    SPA-GMN-TNUM  (IDX)
                                               TO  WRK-SELNUM
              END-IF
           END-PERFORM
      *
           IF      WRK-SELNUM      NOT =   ZERO
               MOVE    WRK-SELNUM          TO  XF01-SELNUM
               PERFORM 420-SELNUM-SEC
           END-IF
      *
           .
       440-MEMOLIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    その他処理
      *****************************************************************
       490-ENTRY-SYORI-SEC                   SECTION.
      *
      *    入力個所のセット
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
           .
       490-ENTRY-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェックと別画面処理
      *****************************************************************
       4901-INPUT-CHK-SEC          SECTION.
      *
      *    入力個所のセット
           MOVE    XF01-MEMO01         TO  SPA-GMN-MEMO01
           MOVE    XF01-MEMO02         TO  SPA-GMN-MEMO02
      *
      *    メモ０１
           PERFORM 49011-MEMO01-CHK-SEC
      *    メモ０２
           IF      SPA-ERRCD           =   SPACE
               PERFORM 49012-MEMO02-CHK-SEC
           END-IF
      *
           .
       4901-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    メモ０１チェック処理
      *****************************************************************
       49011-MEMO01-CHK-SEC                   SECTION.
      *
           IF      SPA-GMN-MEMO01      =   SPACE
               CONTINUE
           ELSE
               MOVE    SPA-GMN-MEMO01      TO  WRK-MEMO
               PERFORM 800-MEMO-CHK-SEC
               MOVE    WRK-MEMO            TO  SPA-GMN-MEMO01
           END-IF
      *
           .
       49011-MEMO01-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    メモ０２チェック処理
      *****************************************************************
       49012-MEMO02-CHK-SEC                   SECTION.
      *
           IF      SPA-GMN-MEMO02      =   SPACE
               CONTINUE
           ELSE
               MOVE    SPA-GMN-MEMO02      TO  WRK-MEMO
               PERFORM 800-MEMO-CHK-SEC
               MOVE    WRK-MEMO            TO  SPA-GMN-MEMO02
           END-IF
      *
           .
       49012-MEMO02-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    メモ内容チェック処理
      *****************************************************************
       800-MEMO-CHK-SEC             SECTION.
      *
      *    全角変換
      *    INITIALIZE                  ORCSKANACHKAREA
      *    MOVE    "2"                 TO  KANACHK-SYORI
      *    出力桁数
      *    MOVE    800                 TO  KANACHK-MAX-CNT
      *    MOVE    WRK-MEMO            TO  KANACHK-MAE-INPUT
      *    CALL    "ORCSKANACHK"       USING
      *                                ORCSKANACHKAREA
      *    MOVE    KANACHK-MAE-INPUT   TO  WRK-MEMO
      *    IF     (KANACHK-RC      NOT =   ZERO  )
      *        CONTINUE
      *    ELSE
      *        MOVE    KANACHK-OUT-INPUT   TO  WRK-MEMO
      *    END-IF
      *
           INITIALIZE                  ORCXKANACONVAREA
           MOVE    1000                TO  KANACONV-LEN
           MOVE    1000                TO  KANACONV-STLEN
           MOVE    0                   TO  KANACONV-CONV-FLAG
           MOVE    0                   TO  KANACONV-CHAR-TYPE
           MOVE    WRK-MEMO            TO  KANACONV-INDATA
           CALL    "kanaconv"          USING ORCXKANACONVAREA
           MOVE    KANACONV-OUTDATA    TO  WRK-MEMO
      *
           .
       800-MEMO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア　処理
      *****************************************************************
       220-CLREA-SEC                   SECTION.
      *
           IF      SPA-GMN-SELNUM      =   ZERO
               MOVE    SPA-SYSYMD          TO  SPA-NAI-SYSYMD
               PERFORM 310-SPA-SET-SEC
               MOVE    1                   TO  SPA-GMN-CUR
           ELSE
               MOVE    ZERO                TO  SPA-GMN-SELNUM
               MOVE    1                   TO  SPA-GMN-CUR
           END-IF
           .
       220-CLREA-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録　処理
      *****************************************************************
       212-TOUROKU-SEC                   SECTION.
      *
      *    入力チェック処理
           PERFORM 4901-INPUT-CHK-SEC
      *
           MOVE    1                   TO  FLG-TOROKU
           IF      SPA-ERRCD           =   SPACE
               PERFORM 400-SRYKA02-SEC
           END-IF
           IF      SPA-ERRCD           =   SPACE
               PERFORM 400-SRYKA02-SEC
           END-IF
      *
           IF      SPA-NAI-SYSYMD  NOT =   SPA-SYSYMD
               MOVE    "0011"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-CUR
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               IF     (SPA-GMN-MEMO01      =   SPACE )   AND
                      (SPA-GMN-MEMO02      =   SPACE )
                   MOVE    "0010"              TO  SPA-ERRCD
                   MOVE    2                   TO  SPA-GMN-CUR
               ELSE
                   MOVE    "0001"              TO  SPA-XFIDCD
               END-IF
           END-IF
      *
           .
       212-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録　処理
      *****************************************************************
       2121-TOUROKU-SYORI-SEC          SECTION.
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *    メモ１
           IF      SPA-GMN-MEMO01  NOT =   SPACE
               MOVE    1                   TO  WRK-MEMOKBN
               MOVE    SPA-GMN-MEMO01      TO  WRK-MEMO
               MOVE    SPA-GMN-SRYKA01     TO  WRK-SRYKA
               MOVE    SPA-NAI-RENNUM01    TO  WRK-RENNUM
               PERFORM 21121-PTMEMOINF-SYORI-SEC
           END-IF
      *    メモ２
           IF      SPA-GMN-MEMO02  NOT =   SPACE
               MOVE    2                   TO  WRK-MEMOKBN
               MOVE    SPA-GMN-MEMO02      TO  WRK-MEMO
               MOVE    SPA-GMN-SRYKA02     TO  WRK-SRYKA
               MOVE    SPA-NAI-RENNUM02    TO  WRK-RENNUM
               PERFORM 21121-PTMEMOINF-SYORI-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
      *        患者コメント一覧編集
               MOVE    1                   TO  SPA-GMN-PAGE
               MOVE    2                   TO  SPA-NAI-MEMOKBN
               PERFORM 3101-PTMEMO-LIST-SEC
      *        患者コメント初期編集
               PERFORM 3103-PTMEMO-HEN-SEC
               MOVE    1                   TO  SPA-GMN-CUR
           END-IF
      *
           .
       2121-TOUROKU-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    患者メモ登録処理
      *****************************************************************
       21121-PTMEMOINF-SYORI-SEC           SECTION.
      *
           MOVE    SPACE               TO  PTMEMOINF-REC
           INITIALIZE                  PTMEMOINF-REC
           MOVE    SPA-HOSPNUM         TO  PTMEMOINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTMEMOINF-PTID
           MOVE    WRK-MEMOKBN         TO  PTMEMOINF-MEMOKBN
           MOVE    SPA-NAI-SYSYMD      TO  PTMEMOINF-SYSYMD
           MOVE    WRK-SRYKA           TO  PTMEMOINF-SRYKA
           MOVE    WRK-RENNUM          TO  PTMEMOINF-RENNUM
           IF      WRK-RENNUM          =   ZERO
               MOVE    "key2"              TO  WRK-PATHNAME
           ELSE
               MOVE    "key"               TO  WRK-PATHNAME
           END-IF
      *
           MOVE    PTMEMOINF-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    WRK-PATHNAME        TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    WRK-PATHNAME        TO  MCP-PATHNAME
               PERFORM 910-PTMEMOINF-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTMEMOINF
               INITIALIZE                  PTMEMOINF-REC
           END-IF
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    WRK-PATHNAME        TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *    新規登録
           IF      WRK-RENNUM          =   ZERO
               IF      FLG-PTMEMOINF       =   ZERO
                   MOVE    PTMEMOINF-RENNUM    TO  WRK-RENNUM
               END-IF
               ADD     1                   TO  WRK-RENNUM
               PERFORM 21121-PTMEMOINF-INS-SEC
           ELSE
               IF      FLG-PTMEMOINF       =   ZERO
                   PERFORM 21121-PTMEMOINF-UPD-SEC
               ELSE
                   PERFORM 21121-PTMEMOINF-INS-SEC
               END-IF
           END-IF
      *
           .
       2121-TOUROKU-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    患者メモ登録処理
      *****************************************************************
       21121-PTMEMOINF-INS-SEC           SECTION.
      *
           MOVE    SPACE               TO  PTMEMOINF-REC
           INITIALIZE                  PTMEMOINF-REC
           MOVE    SPA-HOSPNUM         TO  PTMEMOINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTMEMOINF-PTID
           MOVE    WRK-MEMOKBN         TO  PTMEMOINF-MEMOKBN
           MOVE    SPA-NAI-SYSYMD      TO  PTMEMOINF-SYSYMD
           MOVE    WRK-SRYKA           TO  PTMEMOINF-SRYKA
           MOVE    WRK-RENNUM          TO  PTMEMOINF-RENNUM
           MOVE    WRK-MEMO            TO  PTMEMOINF-MEMO
      *
           MOVE    SMCNDATE-YMD        TO  PTMEMOINF-CREYMD
           MOVE    SMCNDATE-YMD        TO  PTMEMOINF-UPYMD
           MOVE    SMCNDATE-HMS        TO  PTMEMOINF-UPHMS
           MOVE    SPA-OPID            TO  PTMEMOINF-OPID
      *
           MOVE    PTMEMOINF-REC       TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "XF01 PTMEMOINF INS ERR:" MCP-RC
                           ",KEY:"   PTMEMOINF-KEY    "."
               MOVE    "0020"              TO  SPA-ERRCD
           END-IF
      *
           .
       21121-PTMEMOINF-INS-EXT.
           EXIT.
      *****************************************************************
      *    患者メモ更新処理
      *****************************************************************
       21121-PTMEMOINF-UPD-SEC           SECTION.
      *
      *    更新
           MOVE    WRK-MEMO            TO  PTMEMOINF-MEMO
      *
           MOVE    SMCNDATE-YMD        TO  PTMEMOINF-UPYMD
           MOVE    SMCNDATE-HMS        TO  PTMEMOINF-UPHMS
           MOVE    SPA-OPID            TO  PTMEMOINF-OPID
      *
           MOVE    PTMEMOINF-REC       TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "XF01 PTMEMOINF UPD ERR:" MCP-RC
                           ",KEY:"   PTMEMOINF-KEY    "."
               MOVE    "0020"              TO  SPA-ERRCD
           END-IF
           .
       21121-PTMEMOINF-UPD-EXT.
           EXIT.
      *****************************************************************
      *    コメント１登録処理
      *****************************************************************
       21201-MEMO01-ADD-SEC            SECTION.
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *    メモ１
           MOVE    1                   TO  WRK-MEMOKBN
           MOVE    SPA-GMN-MEMO01      TO  WRK-MEMO
           MOVE    SPA-GMN-SRYKA01     TO  WRK-SRYKA
           MOVE    SPA-NAI-RENNUM01    TO  WRK-RENNUM
           PERFORM 21121-PTMEMOINF-SYORI-SEC
      *
      *    再表示
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-NAI-MEMOKBN     =   1
                   MOVE    1                   TO  SPA-GMN-PAGE
                   PERFORM 3101-PTMEMO-LIST-SEC
               END-IF
      *        患者コメント初期編集
               PERFORM 3103-PTMEMO-HEN-SEC
           END-IF
           .
       21201-MEMO01-ADD-EXT.
           EXIT.
      *****************************************************************
      *    コメント１登録処理
      *****************************************************************
       21201-MEMO01-DEL-SEC            SECTION.
      *
           MOVE    1                   TO  WRK-MEMOKBN
           MOVE    SPA-GMN-MEMO01      TO  WRK-MEMO
           MOVE    SPA-GMN-SRYKA01     TO  WRK-SRYKA
           MOVE    SPA-NAI-RENNUM01    TO  WRK-RENNUM
           PERFORM 21201-PTMEMOINF-DEL-SEC
      *    再表示
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-NAI-MEMOKBN     =   1
                   MOVE    1                   TO  SPA-GMN-PAGE
                   PERFORM 3101-PTMEMO-LIST-SEC
               END-IF
      *        患者コメント初期編集
               PERFORM 3103-PTMEMO-HEN-SEC
           END-IF
      *
           .
       21201-MEMO01-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント削除処理
      *****************************************************************
       21201-PTMEMOINF-DEL-SEC                   SECTION.
      *
           MOVE    SPACE               TO  PTMEMOINF-REC
           INITIALIZE                  PTMEMOINF-REC
           MOVE    SPA-HOSPNUM         TO  PTMEMOINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTMEMOINF-PTID
           MOVE    WRK-MEMOKBN         TO  PTMEMOINF-MEMOKBN
           MOVE    SPA-NAI-SYSYMD      TO  PTMEMOINF-SYSYMD
           MOVE    WRK-SRYKA           TO  PTMEMOINF-SRYKA
           MOVE    WRK-RENNUM          TO  PTMEMOINF-RENNUM
      *
           MOVE    PTMEMOINF-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 910-PTMEMOINF-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTMEMOINF
               INITIALIZE                  PTMEMOINF-REC
           END-IF
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      FLG-PTMEMOINF       =   ZERO
               MOVE    PTMEMOINF-REC       TO  MCPDATA-REC
               MOVE    "DBDELETE"          TO  MCP-FUNC
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               CALL    "ORCDBMAIN"         USING   MCPAREA
                                                   MCPDATA-REC
                                                   SPA-AREA
               IF      MCP-RC          NOT =   ZERO
                    DISPLAY "XF01 PTMEMOINF DEL ERR:" MCP-RC 
                               ",KEY:"   PTMEMOINF-KEY    "."
                   MOVE    "0021"          TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       21201-PTMEMOINF-DEL-EXT.
           EXIT.
      *****************************************************************
      *    コメント１登録処理
      *****************************************************************
       21201-MEMO02-ADD-SEC            SECTION.
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *    メモ１
           MOVE    2                   TO  WRK-MEMOKBN
           MOVE    SPA-GMN-MEMO02      TO  WRK-MEMO
           MOVE    SPA-GMN-SRYKA02     TO  WRK-SRYKA
           MOVE    SPA-NAI-RENNUM02    TO  WRK-RENNUM
           PERFORM 21121-PTMEMOINF-SYORI-SEC
      *    再表示
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-NAI-MEMOKBN     =   2
                   MOVE    1                   TO  SPA-GMN-PAGE
                   PERFORM 3101-PTMEMO-LIST-SEC
               END-IF
      *        患者コメント初期編集
               PERFORM 3103-PTMEMO-HEN-SEC
           END-IF
           .
       21201-MEMO02-ADD-EXT.
           EXIT.
      *****************************************************************
      *    コメント１登録処理
      *****************************************************************
       21201-MEMO02-DEL-SEC            SECTION.
      *
           MOVE    2                   TO  WRK-MEMOKBN
           MOVE    SPA-GMN-MEMO02      TO  WRK-MEMO
           MOVE    SPA-GMN-SRYKA02     TO  WRK-SRYKA
           MOVE    SPA-NAI-RENNUM02    TO  WRK-RENNUM
           PERFORM 21201-PTMEMOINF-DEL-SEC
      *    再表示
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-NAI-MEMOKBN     =   2
                   MOVE    1                   TO  SPA-GMN-PAGE
                   PERFORM 3101-PTMEMO-LIST-SEC
               END-IF
      *        患者コメント初期編集
               PERFORM 3103-PTMEMO-HEN-SEC
           END-IF
           .
       21201-MEMO02-DEL-EXT.
           EXIT.
      *****************************************************************
      *    一覧切替え　処理
      *****************************************************************
       240-CHENGE-SEC                   SECTION.
      *
           IF      SPA-NAI-MEMOKBN     =   1
               MOVE    2               TO  SPA-NAI-MEMOKBN
           ELSE
               MOVE    1               TO  SPA-NAI-MEMOKBN
           END-IF
           MOVE    1                   TO  SPA-GMN-PAGE
           PERFORM 3101-PTMEMO-LIST-SEC
      *
           .
       240-CHENGE-EXT.
           EXIT.
      *****************************************************************
      *    コメント削除　処理
      *****************************************************************
       240-DELETE-SEC                   SECTION.
      *
           IF     (SPA-NAI-RENNUM01    =   ZERO )  AND
                  (SPA-NAI-RENNUM02    =   ZERO )
               MOVE    "0013"              TO  SPA-ERRCD
           ELSE
               MOVE    "0002"              TO  SPA-XFIDCD
           END-IF
           .
       240-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント１日分削除処理
      *****************************************************************
       2401-MEMO-DELSYORI-SEC          SECTION.
      *
           PERFORM 24011-PTMEMOINF-ALLDEL-SEC
      *
      *    再表示
           IF      SPA-ERRCD           =   SPACE
               PERFORM 310-SPA-SET-SEC
           END-IF
           .
       2401-MEMO-DELSYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント削除処理
      *****************************************************************
       24011-PTMEMOINF-ALLDEL-SEC                   SECTION.
      *
           MOVE    SPACE               TO  PTMEMOINF-REC
           INITIALIZE                  PTMEMOINF-REC
           MOVE    SPA-HOSPNUM         TO  PTMEMOINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTMEMOINF-PTID
           MOVE    SPA-NAI-SYSYMD      TO  PTMEMOINF-SYSYMD
      *
           MOVE    PTMEMOINF-REC       TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "del2"              TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF      MCP-RC          NOT =   ZERO
                DISPLAY "XF01 PTMEMOINF DEL ERR:" MCP-RC 
                           ",KEY:"   PTMEMOINF-KEY    "."
               MOVE    "0021"          TO  SPA-ERRCD
           END-IF
      *
           .
       24011-PTMEMOINF-ALLDEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    前日分処理
      *****************************************************************
       250-BACK-DAY-SEC               SECTION.
      *
           INITIALIZE                     STS-AREA-DAY
           INITIALIZE                     LNK-DAY6-AREA
           MOVE    "61"                   TO  LNK-DAY6-IRAI
           MOVE    SPA-NAI-SYSYMD         TO  LNK-DAY6-KIJUN
           MOVE    "1"                    TO  LNK-DAY6-ZOGENPTN
           MOVE    -1                     TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"              USING   STS-AREA-DAY
                                                  LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN        TO  SPA-NAI-SYSYMD
      *
           PERFORM 310-SPA-SET-SEC
           .
      *
       250-BACK-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    次日分処理
      *****************************************************************
       280-NEXT-DAY-SEC               SECTION.
      *
           INITIALIZE                     STS-AREA-DAY
           INITIALIZE                     LNK-DAY6-AREA
           MOVE    "61"                   TO  LNK-DAY6-IRAI
           MOVE    SPA-NAI-SYSYMD         TO  LNK-DAY6-KIJUN
           MOVE    "1"                    TO  LNK-DAY6-ZOGENPTN
           MOVE    1                      TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"              USING   STS-AREA-DAY
                                                  LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN        TO  SPA-NAI-SYSYMD
      *
           PERFORM 310-SPA-SET-SEC
           .
      *
       280-NEXT-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁処理
      *****************************************************************
       260-BACK-PAGE-SEC               SECTION.
      *
           IF      SPA-GMN-PAGE       >   1
               COMPUTE SPA-GMN-PAGE       =   SPA-GMN-PAGE
                                           -   1
               PERFORM 3101-PTMEMO-LIST-SEC
            END-IF
           .
      *
       260-BACK-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁処理
      *****************************************************************
       270-NEXT-PAGE-SEC               SECTION.
      *
           IF      SPA-GMN-NEXT       =   1
               COMPUTE SPA-GMN-PAGE       =   SPA-GMN-PAGE
                                          +   1
               PERFORM 3101-PTMEMO-LIST-SEC
            END-IF
           .
      *
       270-NEXT-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    LNK-COMMON          TO  SPA-KYOUTU
      *
           MOVE    SPA-HZN-MOTOPG      TO  SPA-SAKIPG
           MOVE    "XF01"              TO  SPA-MOTOPG
      *
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
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
           IF      SPA-XFIDCD       NOT =   SPACE
               PERFORM 520-XFID1SET-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
      *****MOVE    SPACE               TO  LINKAREA
           MOVE    SPACE               TO  LNK-KYOUTU
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE
           MOVE    "XF01"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
           .
       500-SET-SCREEN-EXT.
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
                   MOVE    "診療科１選択エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "メモ１エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "診療科２選択エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "メモ２エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "選択番号がありません。"
                                       TO  SPA-ERRMSG
               WHEN    "0011"
                   STRING  "システム日付ではありません。"
                           "削除のみ行って下さい。"
                                       DELIMITED  BY  SIZE
                                       INTO    SPA-ERRMSG
                   END-STRING
               WHEN    "0012"
                   STRING  "新規のメモです。削除はできません。"
                                       DELIMITED  BY  SIZE
                                       INTO    SPA-ERRMSG
                   END-STRING
               WHEN    "0010"
                   STRING  "メモの内容が登録されていません。"
                                       DELIMITED  BY  SIZE
                                       INTO    SPA-ERRMSG
                   END-STRING
               WHEN    "0013"
                   STRING  "削除するメモがありません。"
                                       DELIMITED  BY  SIZE
                                       INTO    SPA-ERRMSG
                   END-STRING
               WHEN    "0020"
                   MOVE    "更新エラーです。"
                                       TO  SPA-ERRMSG
               WHEN    "0021"
                   MOVE    "削除エラーです。"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  XFERR
           MOVE    SPA-ERRCD           TO  XFERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  XFERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "XF01"              TO  SPA-MOTOPG
           MOVE    "XFERR"             TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "XFERR"             TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-XFID1SET-SEC              SECTION.
      *
           EVALUATE    SPA-XFIDCD
               WHEN    "0001"
                   STRING  "表示されている内容でメモを"
                           "登録します。よろしいですか？"
                                       DELIMITED  BY  SIZE
                                       INTO    WRK-XFIDMSG
                   END-STRING
               WHEN    "0002"
                   STRING  "表示されている日のメモをすべて削除します。"
                           "よろしいですか？"
                                       DELIMITED  BY  SIZE
                                       INTO    WRK-XFIDMSG
                   END-STRING
               WHEN    "0003"
                   STRING  "メモの更新ならＯＫ を メモ内容複写ならＮＯ"
                           "を選択して下さい。"
                                       DELIMITED  BY  SIZE
                                       INTO    WRK-XFIDMSG
                   END-STRING
               WHEN    "0004"
                   STRING  "メモ内容の置換ならＯＫ を 追加ならＮＯ"
                           "を選択して下さい。"
                                       DELIMITED  BY  SIZE
                                       INTO    WRK-XFIDMSG
                   END-STRING
               WHEN    "0101"
                   STRING  "表示されているメモ１を登録します。"
                           "よろしいですか？"
                                       DELIMITED  BY  SIZE
                                       INTO    WRK-XFIDMSG
                   END-STRING
               WHEN    "0102"
                   STRING  "表示されているメモ１を削除します。"
                           "よろしいですか？"
                                       DELIMITED  BY  SIZE
                                       INTO    WRK-XFIDMSG
                   END-STRING
               WHEN    "0103"
                   STRING  "表示されているメモ２を登録します。"
                           "よろしいですか？"
                                       DELIMITED  BY  SIZE
                                       INTO    WRK-XFIDMSG
                   END-STRING
               WHEN    "0104"
                   STRING  "表示されているメモ２を削除します。"
                           "よろしいですか？"
                                       DELIMITED  BY  SIZE
                                       INTO    WRK-XFIDMSG
                   END-STRING
               WHEN    OTHER
                   MOVE    SPA-XFIDCD
                                       TO  WRK-XFIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  SPA-XFID1-FLG
      *
           MOVE    SPACE               TO  XFID1
           MOVE    SPA-XFIDCD          TO  XFID1-ID1CODE
           MOVE    WRK-XFIDMSG         TO  XFID1-ID1MSG
      *
           MOVE    "戻る"              TO  XFID1-B01
           MOVE    "ＯＫ"              TO  XFID1-B12
           EVALUATE    SPA-XFIDCD
               WHEN    "0003"
               WHEN    "0004"
                   MOVE    "ＮＯ"          TO  XFID1-B01
           END-EVALUATE
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "XF01"              TO  SPA-MOTOPG
           MOVE    "XFID1"             TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "XFID1"             TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-XFID1SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
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
      *    患者メモ読込処理
      *****************************************************************
       910-PTMEMOINF-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PTMEMOINF-REC
               MOVE    ZERO                TO  FLG-PTMEMOINF
           ELSE
               INITIALIZE                      PTMEMOINF-REC
               MOVE    1                   TO  FLG-PTMEMOINF
           END-IF
      *
           .
       910-PTMEMOINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクロース処理
      *****************************************************************
       990-DBCLOSE-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
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
           MOVE   "PUTWINDOW"          TO  MCP-FUNC.
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
