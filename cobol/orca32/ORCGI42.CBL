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
       PROGRAM-ID.                 ORCGI42.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院会計照会
      *  コンポーネント名  : チェック（Ｉ４２）
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
      *    診療行為コード表名称
           SELECT  TENSUKBN-FILE   ASSIGN  FILE-NAME
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TENSUKBN.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    診療行為コード表名称
       FD  TENSUKBN-FILE.
       01  TENSUKBN-REC.
           03  TENSU-DATA-REC.
               05  TENSU-KNO.
                   07  TENSU-KNOKBN     PIC X(01).
                   07  TENSU-KNONO      PIC 9(03).
                   07  TENSU-KNONO2     PIC 9(02).
               05  TENSU-KNOMEI         PIC X(50).
      *
       WORKING-STORAGE             SECTION.
      *
       01  FILE-NAME               PIC X(512).
      *
      *    ファイル名
       01  DATA-FILE.
           03  FILLER          PIC X(05)   VALUE   "data/".
           03  FILLER          PIC X(16)   VALUE   "TENSUKBNNAME.TXT".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    会計カード共通パラメタ
           COPY    "I4COMMON-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "I4SCR-SPA".
      *
           COPY    "I4SCR-SPA2".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TENSUKBN        PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-NYUINACT        PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-HKNMST          PIC 9(01).
           03  FLG-HKNKUMI         PIC 9(01).
           03  FLG-NYUINACCT       PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-TENSUKBN        PIC 9(01).
           03  FLG-KNJCOM          PIC 9(01).
      *
           03  FLG-NAIYAK          PIC X(01).
           03  FLG-TONPUK          PIC X(01).
           03  FLG-GAIYAK          PIC X(01).
           03  FLG-SP              PIC 9(01).
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
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDX4                PIC 9(04).
           03  IDX5                PIC 9(04).
           03  IDX-D               PIC 9(04).
           03  IDX-MAX             PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD.
	       05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
      *    診療日付
           03  WRK-SRYYM.
               05  WRK-SRYYY       PIC 9(04).
               05  WRK-SRYMM       PIC 9(02).
      *
           03  WRK-ZZZ             PIC ZZZ.
      *    マップ画面行
           03  WRK-MAP-INDEX       PIC 9(04).
      *
           03  WRK-ERRMSG          PIC X(40).
      *
      *    編集用テーブル
       01  WRK-TBL-AREA.
           03  WRK-TBL-OCCURS                  OCCURS  6.
               05  WRK-TBL-OCC2                OCCURS  200.
                   07  WRK-TBL-SRYCD           PIC X(09).
                   07  WRK-TBL-SRYYYMM         PIC X(06).
                   07  WRK-TBL-MEISYO          PIC X(50).
                   07  WRK-TBL-SRYKBN          PIC X(02).
      *        コード表記 
                   07  WRK-TBL-KNO.
                       09  WRK-TBL-KNOKBN      PIC  X(01).
                       09  WRK-TBL-KNONO       PIC  X(03).
                       09  WRK-TBL-KNONO2      PIC  X(02).
                   07  WRK-TBL-OCC3            OCCURS   31.
                       09  WRK-TBL-KAISU       PIC 9(02).
                   07  WRK-TBL-TUKIKAISU       PIC 9(04).
       01  WRK-TBL-AREA2.
           03  TBL-IDX1                        PIC 9(04).
           03  TBL-IDX2                        PIC 9(04).
           03  TBL-IDX3                        PIC 9(02).
           03  TBL-IDX4                        PIC 9(02).
      *    表示対象診療会計作業
       01  WRK-SRY-TBL.
           03  WRK-SRY-TBL-CHK                 OCCURS  50.
               05  WRK-SRY-NYUGAIKBN           PIC  X(01).
               05  WRK-SRY-SRYKA               PIC  X(02).
               05  WRK-SRY-ZAINUM              PIC  9(08).
               05  WRK-SRY-SRYKBN              PIC  X(02).
      *
      *    ソート編集用テーブル
       01  WRK-STBL-AREA.
           03  WRK-STBL-OCCURS          OCCURS  6.
               05  WRK-STBL-OCC2        OCCURS  200.
                   07  WRK-STBL-SRYCD           PIC X(09).
                   07  WRK-STBL-SRYYYMM         PIC X(06).
                   07  WRK-STBL-MEISYO          PIC X(50).
                   07  WRK-STBL-SRYKBN          PIC X(02).
      *            コード表記 
                   07  WRK-STBL-KNO.
                       09  WRK-STBL-KNOKBN      PIC  X(01).
                       09  WRK-STBL-KNONO       PIC  X(03).
                       09  WRK-STBL-KNONO2      PIC  X(02).
                   07  WRK-STBL-OCC3            OCCURS   31.
                       09  WRK-STBL-KAISU       PIC 9(02).
                   07  WRK-STBL-TUKIKAISU       PIC 9(04).
      *
       01  WRK-STBL-AREA2.
           03  WRK-SRYYYMM             PIC X(06).
           03  WRK-SRYCD               PIC X(09).
           03  WRK-KNO                 PIC X(06).
           03  WRK-SRYYMD              PIC X(08).
      *
      *    画面用ソート
       01  WRK-GMN-AREA.
           05  WRK-GMN-TBLREC1     OCCURS  100.
               07  WRK-GMN-TSRYYMD     PIC X(09).
               07  WRK-GMN-TNAIYOU1    PIC X(50).
               07  WRK-GMN-TKAISU1     PIC 9(04).
      *
           05  WRK-NAI-TBLREC1     OCCURS  100.
               07  WRK-NAI-SRYYMD     PIC X(08).
               07  WRK-NAI-SRYCD      PIC X(09).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG             PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *   コード表名称テーブル
       01  MKNO-DATA-REC.
           03  MKNO-TBL-OCC        OCCURS    350   INDEXED   MKNO-IDX.
               05  MKNO-KNO.
                   07  MKNO-KNOKBN     PIC X(01).
                   07  MKNO-KNONO      PIC 9(03).
                   07  MKNO-KNONO2     PIC 9(02).
               05  MKNO-KNOMEI         PIC X(50).
      *
      **************************************************************
      *    ファイルレイアウト
      **************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1005.INC".
      *
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *
      *    入院行為マスタ−
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    診療行為マスタ−
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    入院会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    患者コメント
       01  PTCOM-REC.
           COPY    "CPPTCOM.INC".
      *
      *****************************************************************
      *    サブプロ用連絡領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *   数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    フィアルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *   ＤＢ検索
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
      **************************************************************
      *    主　　処理
      **************************************************************
       200-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-I42.
           MOVE    SPA-WORK        TO  SPA-I4KYOUTU.
      *
           MOVE    SPACE           TO  SPA-ERRCD.
           MOVE    ZERO            TO  FLG-END.
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF.
      *
           MOVE    SPA-I4KYOUTU    TO  SPA-WORK.
           MOVE    SPA-AREA        TO  SPA-COMMON.
           MOVE    SPA-I42         TO  SPA-FREE.
      *
           EXIT    PROGRAM.
      **************************************************************
      *    初期　処理
      **************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA.
           INITIALIZE                  CNT-AREA.
           INITIALIZE                  WRK-AREA.
      *    診療行為コード表名称セット
           PERFORM 1001-TENSUKBN-SET-SEC
      *    エラー画面より
           IF      SPA-MOTOPG          =   "I4ERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面編集
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF.
      *
           MOVE    SPACE               TO  LNK-KYOUTU.
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "I42"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       100-INIT-EXT.
           EXIT.
      *
      **************************************************************
      *    診療行為コード表名称セット
      **************************************************************
       1001-TENSUKBN-SET-SEC          SECTION.
      *
      *    フィアルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA.
           MOVE    DATA-FILE           TO  MKPASS-IN-01.
           CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA.
           MOVE    MKPASS-OT-01        TO  FILE-NAME.
      *
      *    診療行為コード表名称セット
           INITIALIZE                  MKNO-DATA-REC.
      *
           OPEN    INPUT               TENSUKBN-FILE.
           IF      STS-TENSUKBN    NOT =   ZERO
               DISPLAY "TENSUKBN-FILE OPEN ERR:" STS-TENSUKBN
               GO     TO      1001-TENSUKBN-SET-EXT
           END-IF.
      *
           MOVE    ZERO                TO  IDX.
           MOVE    ZERO                TO  FLG-TENSUKBN.
           PERFORM UNTIL    FLG-TENSUKBN     =   1
               READ                    TENSUKBN-FILE
                   AT  END
                       MOVE    1           TO  FLG-TENSUKBN
                   NOT AT  END
                      ADD     1           TO  IDX
                      IF      IDX         >   350
                           CONTINUE
                       ELSE
                           MOVE    TENSUKBN-REC      TO  MKNO-TBL-OCC
                                                       (IDX)
                       END-IF
               END-READ
           END-PERFORM.
      *
           CLOSE                   TENSUKBN-FILE.
      *
       1001-TENSUKBN-SET-EXT.
           EXIT.
      *
      **************************************************************
      *    初期画面処理
      **************************************************************
       300-SCREEN-SEC              SECTION.
      *
           INITIALIZE              SPA-I42.
      *
           MOVE    LNK-COMMON      TO  SPA-KYOUTU.
           MOVE    LNK-SCRSPA      TO  SPA-I4.
           MOVE    SPA-WORK        TO  SPA-I4KYOUTU.
      *
           PERFORM 310-SPA-SET-SEC.
           MOVE    1               TO  SPA-GMN-SYORI.
      *
           MOVE    1               TO  SPA-GMN-CUR.
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       310-SPA-SET-SEC                 SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN-MAX.
           INITIALIZE                      WRK-TBL-AREA.
           INITIALIZE                      WRK-TBL-AREA2.
      *
      *    当月分
           MOVE    SPA-I40-SRYYMD(1:6) TO  WRK-SRYYM.
           PERFORM 3101-NACCT-SYORI-SEC.
           INITIALIZE                      WRK-SRY-TBL.
           MOVE    ZERO                TO  IDX5.
           PERFORM VARYING     IDX4    FROM    1   BY  1
                   UNTIL       IDX4            >   10
               IF      SPA-5000-DSPCD-41 (IDX4) NOT = SPACE
                   PERFORM 3100-SRYACT-CHK-SEC
               END-IF
           END-PERFORM.
           PERFORM VARYING     IDX4    FROM    1   BY  1
                   UNTIL       IDX4            >   50
               IF      WRK-SRY-NYUGAIKBN (IDX4) NOT = SPACE
                   PERFORM 3101-SACCT-SYORI-SEC
               END-IF
           END-PERFORM.
      *    前月分
           COMPUTE WRK-SRYMM           =   WRK-SRYMM     -   1.
           IF      WRK-SRYMM           =   ZERO
               MOVE    12                  TO  WRK-SRYMM
               COMPUTE WRK-SRYYY           =   WRK-SRYYY      -   1
           END-IF.
           PERFORM 3101-NACCT-SYORI-SEC.
           INITIALIZE                      WRK-SRY-TBL.
           MOVE    ZERO                TO  IDX5.
           PERFORM VARYING     IDX4    FROM    1   BY  1
                   UNTIL       IDX4            >   10
               IF      SPA-5000-DSPCD-41 (IDX4) NOT = SPACE
                   PERFORM 3100-SRYACT-CHK-SEC
               END-IF
           END-PERFORM.
           PERFORM VARYING     IDX4    FROM    1   BY  1
                   UNTIL       IDX4            >   50
               IF      WRK-SRY-NYUGAIKBN (IDX4) NOT = SPACE
                   PERFORM 3101-SACCT-SYORI-SEC
           END-PERFORM.
      *
      *    診療年月・診療コード順にＳＯＲＴ
           PERFORM 310121-SORT-01-SEC.
      *
      *    編集領域からＳＰＡへ
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
               PERFORM 31012-SPA-HEN-SEC
           END-PERFORM.
      *
       310-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスターチェック　処理
      *****************************************************************
       3100-SRYACT-CHK-SEC                 SECTION.
      *
      *    診療行為マスターチェック
           INITIALIZE                       SRYACT-REC.
           MOVE    SPA-HOSPID               TO  SRY-HOSPID.
           MOVE    2                        TO  SRY-NYUGAIKBN.
           MOVE    SPA-GMN-PTID             TO  SRY-PTID.
           MOVE    WRK-SRYYM                TO  SRY-SRYYM.
           MOVE    SPA-5000-DSPCD-41 (IDX4) TO  SRY-SRYCD (1).
           MOVE    SPA-5000-DSPCD-41 (IDX4) TO  SRY-SRYCD (2).
           MOVE    SPA-5000-DSPCD-41 (IDX4) TO  SRY-SRYCD (3).
           MOVE    SPA-5000-DSPCD-41 (IDX4) TO  SRY-SRYCD (4).
           MOVE    SPA-5000-DSPCD-41 (IDX4) TO  SRY-SRYCD (5).
      *
           MOVE    SRYACT-REC               TO  MCPDATA-REC.
           MOVE    "DBSELECT"               TO  MCP-FUNC.
           MOVE    "SRYACT-KEY7"            TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY7"       TO  ORC-DBPATH
               PERFORM 930-SRYACT-RAED-SEC
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF.
      *
           IF      FLG-SRYACCT               =   1
               CONTINUE
           ELSE
               PERFORM UNTIL      (FLG-SRYACCT     =   1)  OR
                                  (IDX5            =   50)
                   ADD     1               TO  IDX5
                   IF      SPA-GMN-SRYKA-I-41     =   SRY-SRYKA
                       MOVE    SRY-NYUGAIKBN TO
                                           WRK-SRY-NYUGAIKBN (IDX5)
                       MOVE    SRY-SRYKA     TO
                                           WRK-SRY-SRYKA (IDX5)
                       MOVE    SRY-ZAINUM    TO
                                           WRK-SRY-ZAINUM (IDX5)
                       MOVE    SRY-SRYKBN    TO
                                           WRK-SRY-SRYKBN (IDX5)
                   END-IF
                   PERFORM 930-SRYACT-RAED-SEC
               END-PERFORM
           END-IF.
      *
           MOVE    "DBCLOSE"          TO  MCP-FUNC.
           MOVE    "SRYACT-KEY7"      TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
       3100-SRYACT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスターから編集処理
      *****************************************************************
       3101-NACCT-SYORI-SEC               SECTION.
      *
      *    入院会計マスターから編集
           INITIALIZE                      NYUINACCT-REC.
           MOVE    SPA-HOSPID          TO  NACCT-HOSPID.
           MOVE    "1"                 TO  NACCT-NYUGAIKBN.
           MOVE    SPA-GMN-PTID        TO  NACCT-PTID.
           MOVE    SPA-I40-SRYKA       TO  NACCT-SRYKA.
           MOVE    WRK-SRYYM           TO  NACCT-SRYYM.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "NYUINACCT-KEY2"    TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACCT-KEY2"    TO  ORC-DBPATH
               PERFORM 900-NYUINACCT-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
           END-IF.
           MOVE    ZERO                TO  IDX.
           PERFORM UNTIL       FLG-NYUINACCT       =   1
      *        診療区分により、処理を決定する
               MOVE    ZERO                TO  IDX
               EVALUATE    NACCT-SRYKBN
      *        診療、入院
                   WHEN    "11"
                   WHEN    "12"
                   WHEN    "90"
                       MOVE    1               TO  IDX
               END-EVALUATE
      *        当月、前月のみ対象とする
               IF      NACCT-SRYYM          =   WRK-SRYYM   OR
                                               SPA-I40-SRYYMD(1:6)
                   CONTINUE
               ELSE
                   MOVE    ZERO                TO  IDX
               END-IF
      *
               IF      IDX             NOT =   ZERO
                   PERFORM 3101-NYUINACCT-SPA-SEC
               END-IF
               MOVE    "NYUINACCT-KEY2"    TO  ORC-DBPATH
               PERFORM 900-NYUINACCT-NEXT-SEC
           END-PERFORM.
      *
           MOVE    "DBCLOSE"          TO  MCP-FUNC.
           MOVE    "NYUINACCT-KEY2"   TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
       3101-NACCT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスターから編集処理
      *****************************************************************
       3101-SACCT-SYORI-SEC               SECTION.
      *
      *    診療会計マスターから編集
           INITIALIZE                       SRYACCT-REC.
           MOVE    SPA-HOSPID               TO  ACCT-HOSPID.
           MOVE    WRK-SRY-NYUGAIKBN (IDX4) TO  ACCT-NYUGAIKBN.
           MOVE    SPA-GMN-PTID             TO  ACCT-PTID.
           MOVE    WRK-SRY-SRYKA (IDX4)     TO  ACCT-SRYKA.
           MOVE    WRK-SRYYM                TO  ACCT-SRYYM.
           MOVE    WRK-SRY-ZAINUM (IDX4)    TO  ACCT-ZAINUM.
           MOVE    WRK-SRY-SRYKBN (IDX4)    TO  ACCT-SRYKBN.
      *
           MOVE    SRYACCT-REC              TO  MCPDATA-REC.
           MOVE    "DBSELECT"               TO  MCP-FUNC.
           MOVE    "SRYACCT-KEY"            TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SRYACCT
           END-IF.
           MOVE    ZERO                TO  IDX.
           PERFORM UNTIL       FLG-SRYACCT       =   1
      *        診療区分により、処理を決定する
               MOVE    ZERO                TO  IDX
               EVALUATE    ACCT-SRYKBN
      *        診療
                   WHEN    "11"
                   WHEN    "12"
                       MOVE    1               TO  IDX
      *        処方
                   WHEN    "21"
                   WHEN    "22"
                   WHEN    "23"
                       MOVE    2               TO  IDX
      *        処置
                   WHEN    "40"
                       MOVE    3               TO  IDX
      *        検査
                   WHEN    "60"
                       MOVE    4               TO  IDX
      *        Ｘ線
                   WHEN    "70"
                       MOVE    5               TO  IDX
      *        リハビリ
                   WHEN    "80"
                       MOVE    6               TO  IDX
               END-EVALUATE
      *        当月、前月のみ対象とする
               IF      ACCT-SRYYM          =   WRK-SRYYM   OR
                                               SPA-I40-SRYYMD(1:6)
                   CONTINUE
               ELSE
                   MOVE    ZERO                TO  IDX
               END-IF
      *
               IF      IDX             NOT =   ZERO
                   PERFORM 3101-SRYACCT-SPA-SEC
               END-IF
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           END-PERFORM.
      *
           MOVE    "DBCLOSE"          TO  MCP-FUNC.
           MOVE    "SRYACCT-KEY"      TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
       3101-SACCT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *   入院会計マスターより画面内容編集処理
      *****************************************************************
       3101-NYUINACCT-SPA-SEC           SECTION.
      *
      *    入院行為マスター読み込み
           INITIALIZE                      NYUINACT-REC.
           MOVE    NACCT-HOSPID        TO  NSRY-HOSPID.
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN.
           MOVE    NACCT-PTID          TO  NSRY-PTID.
           MOVE    NACCT-SRYKA         TO  NSRY-SRYKA.
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM.
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM.
      *    点数検索用日付編集
           MOVE    NACCT-SRYYM         TO  WRK-SYSYMD(1:6).
           MOVE    01                  TO  WRK-SYSDD.
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
               IF      NACCT-DAY (IDX-D)  NOT =   ZERO
                   MOVE    IDX-D           TO  WRK-SYSDD
                   MOVE    31              TO  IDX-D
               END-IF
           END-PERFORM.
      *
           MOVE    NYUINACT-REC        TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "NYUINACT-KEY2"     TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACT-KEY2"     TO  ORC-DBPATH
               PERFORM 930-NYUKOUI-RAED-SEC
           ELSE
               MOVE    1                   TO  FLG-NYUINACT
           END-IF.
      *
           PERFORM UNTIL       FLG-NYUINACT      =   1       
      *        剤明細編集
               PERFORM VARYING     IDZ     FROM    1   BY  1
                       UNTIL      (IDZ         >   5   )  OR
                                  (NSRY-SRYCD (IDZ) =   SPACE)
      *            コメント、薬剤投与、粉砕は対象外
                   IF     (NSRY-SRYCD (IDZ)(1:1)    =   "8"  )  OR
                          (NSRY-SRYCD (IDZ)(1:3)    =   "001")  OR
                          (NSRY-SRYCD (IDZ)         =   "099209901") OR
                          (NSRY-AUTOKBN(IDZ)    NOT =   SPACE )
                       CONTINUE
                   ELSE
      *            点数マスタを取得する
                       MOVE    NSRY-SRYCD (IDZ)    TO  TNS-SRYCD
                       PERFORM 910-TENSU-READ-SEC
                       IF     (FLG-TENSU           =   ZERO  )  AND
                              (TNS-DATAKBN     NOT =   2  AND  3 )
                           PERFORM 31011-NYUKOUI-SPA-SEC
                       END-IF
                   END-IF
               END-PERFORM
      *
               MOVE    "NYUINACT-KEY2"     TO  ORC-DBPATH
               PERFORM 930-NYUKOUI-RAED-SEC
           END-PERFORM.
      *
           MOVE    "DBCLOSE"          TO  MCP-FUNC.
           MOVE    "NYUINACT-KEY2"    TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
       3101-NYUINACCT-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *   診療会計マスターより画面内容編集処理
      *****************************************************************
       3101-SRYACCT-SPA-SEC             SECTION.
      *
      *    診療行為マスター読み込み
           INITIALIZE                      SRYACT-REC.
           MOVE    ACCT-HOSPID         TO  SRY-HOSPID.
           MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN.
           MOVE    ACCT-PTID           TO  SRY-PTID.
           MOVE    ACCT-SRYKA          TO  SRY-SRYKA.
           MOVE    ACCT-SRYYM          TO  SRY-SRYYM.
           MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM.
      *    点数検索用日付編集
           MOVE    ACCT-SRYYM          TO  WRK-SYSYMD(1:6).
           MOVE    01                  TO  WRK-SYSDD.
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
               IF      ACCT-DAY (1 IDX-D)  NOT =   ZERO
                   MOVE    IDX-D           TO  WRK-SYSDD
                   MOVE    31              TO  IDX-D
               END-IF
           END-PERFORM.
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 930-SRYACT-RAED-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYACT
           END-IF.
      *
           PERFORM UNTIL       FLG-SRYACT      =   1       
      *        剤明細編集
               PERFORM VARYING     IDZ     FROM    1   BY  1
                       UNTIL      (IDZ         >   5   )  OR
                                  (SRY-SRYCD (IDZ) =   SPACE)
      *            コメント、薬剤投与、粉砕は対象外
                   IF     (SRY-SRYCD (IDZ)(1:1)    =   "8"  )  OR
                          (SRY-SRYCD (IDZ)(1:3)    =   "001")  OR
                          (SRY-SRYCD (IDZ)         =   "099209901") OR
                          (SRY-AUTOKBN(IDZ)    NOT =   SPACE )
                       CONTINUE
                   ELSE
      *            点数マスタを取得する
                       MOVE    SRY-SRYCD (IDZ)    TO  TNS-SRYCD
                       PERFORM 910-TENSU-READ-SEC
                       IF     (FLG-TENSU           =   ZERO  )  AND
                              (TNS-DATAKBN     NOT =   2  AND  3 )
                           PERFORM 31011-SRYACT-SPA-SEC
                       END-IF
                   END-IF
               END-PERFORM
      *
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 930-SRYACT-RAED-SEC
           END-PERFORM.
      *
           MOVE    "DBCLOSE"          TO  MCP-FUNC.
           MOVE    "SRYACT-KEY2"      TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
       3101-SRYACCT-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *   入院行為ごとの編集処理
      *****************************************************************
       31011-NYUKOUI-SPA-SEC           SECTION.
      *
           IF     IDX               =   1   OR  2
      *        行為別編集
               PERFORM 310111-NYUKOUI-01-SEC 
           ELSE
      *        コード表別編集
               PERFORM 310112-NYUKOUI-02-SEC 
           END-IF.
      *
       3101-NYUKOUI-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *   診療行為ごとの編集処理
      *****************************************************************
       31011-SRYACT-SPA-SEC            SECTION.
      *
           IF     IDX               =   1   OR  2
      *        行為別編集
               PERFORM 310111-SINKOUI-01-SEC 
           ELSE
      *        コード表別編集
               PERFORM 310112-SINKOUI-02-SEC 
           END-IF.
      *
       3101-SRYACT-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *   行為ごとの編集処理
      *****************************************************************
       310111-NYUKOUI-01-SEC           SECTION.
      *
           MOVE    ZERO                TO  TBL-IDX2.
      *    行為より、対象チェック
           PERFORM VARYING     TBL-IDX1    FROM    1   BY  1
                   UNTIL       TBL-IDX1       >    200
               EVALUATE    TRUE
                   WHEN    WRK-TBL-SRYCD (IDX TBL-IDX1)   =   SPACE
                       MOVE    NSRY-SRYCD (IDZ)    TO
                                        WRK-TBL-SRYCD (IDX TBL-IDX1)
                       MOVE    NACCT-SRYKBN        TO
                                        WRK-TBL-SRYKBN (IDX TBL-IDX1)
                       MOVE    NACCT-SRYYM         TO
                                        WRK-TBL-SRYYYMM (IDX TBL-IDX1)
                       MOVE    TNS-NAME            TO
                                        WRK-TBL-MEISYO (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBN       TO
                                        WRK-TBL-KNOKBN (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBNNUM    TO
                                        WRK-TBL-KNONO (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBNNUM-EDA  TO
                                        WRK-TBL-KNONO2 (IDX TBL-IDX1)
                       MOVE    TBL-IDX1            TO  TBL-IDX2
                       MOVE    200                 TO  TBL-IDX1
                   WHEN    (NSRY-SRYCD (IDZ)   =
                                        WRK-TBL-SRYCD (IDX TBL-IDX1))
                       AND (NACCT-SRYYM        =
                                        WRK-TBL-SRYYYMM (IDX TBL-IDX1))
                       MOVE    TBL-IDX1            TO  TBL-IDX2
                       MOVE    200                 TO  TBL-IDX1
               END-EVALUATE
           END-PERFORM.
      *
           IF      TBL-IDX2            =   ZERO
               MOVE    "9999"              TO  SPA-ERRCD
               GO      TO      310111-NYUKOUI-01-EXT
           END-IF.
      *
      *    入院行為回数計算
           PERFORM VARYING     TBL-IDX3    FROM    1   BY  1
                   UNTIL       TBL-IDX3    >   31
      *
               IF      NACCT-DAY(TBL-IDX3)   NOT =   ZERO
                   ADD     1              TO  WRK-TBL-KAISU
                                         (IDX TBL-IDX2 TBL-IDX3)
               END-IF
           END-PERFORM.
      *
       310111-NYUKOUI-01-EXT.
           EXIT.
      *
      *****************************************************************
      *   行為ごとの編集処理
      *****************************************************************
       310111-SINKOUI-01-SEC           SECTION.
      *
           MOVE    ZERO                TO  TBL-IDX2.
      *    行為より、対象チェック
           PERFORM VARYING     TBL-IDX1    FROM    1   BY  1
                   UNTIL       TBL-IDX1       >    200
               EVALUATE    TRUE
                   WHEN    WRK-TBL-SRYCD (IDX TBL-IDX1)   =   SPACE
                       MOVE    SRY-SRYCD (IDZ)     TO
                                        WRK-TBL-SRYCD (IDX TBL-IDX1)
                       MOVE    ACCT-SRYKBN         TO
                                        WRK-TBL-SRYKBN (IDX TBL-IDX1)
                       MOVE    ACCT-SRYYM          TO
                                        WRK-TBL-SRYYYMM (IDX TBL-IDX1)
                       MOVE    TNS-NAME            TO
                                        WRK-TBL-MEISYO (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBN       TO
                                        WRK-TBL-KNOKBN (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBNNUM    TO
                                        WRK-TBL-KNONO (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBNNUM-EDA  TO
                                        WRK-TBL-KNONO2 (IDX TBL-IDX1)
                       MOVE    TBL-IDX1            TO  TBL-IDX2
                       MOVE    200                 TO  TBL-IDX1
                   WHEN    (SRY-SRYCD (IDZ)   =
                                        WRK-TBL-SRYCD (IDX TBL-IDX1))
                       AND (ACCT-SRYYM        =
                                        WRK-TBL-SRYYYMM (IDX TBL-IDX1))
                       MOVE    TBL-IDX1            TO  TBL-IDX2
                       MOVE    200                 TO  TBL-IDX1
               END-EVALUATE
           END-PERFORM.
      *
           IF      TBL-IDX2            =   ZERO
               MOVE    "9999"              TO  SPA-ERRCD
               GO      TO      310111-SINKOUI-01-EXT
           END-IF.
      *
      *    診療行為回数計算
           PERFORM VARYING     TBL-IDX3    FROM    1   BY  1
                   UNTIL       TBL-IDX3    >   31
      *
               IF      ACCT-DAY(1 TBL-IDX3)   NOT =   ZERO
                   ADD     1              TO  WRK-TBL-KAISU
                                         (IDX TBL-IDX2 TBL-IDX3)
               END-IF
           END-PERFORM.
      *
       310111-SINKOUI-01-EXT.
           EXIT.
      *
      *****************************************************************
      *   コード表ごとの編集処理
      *****************************************************************
       310112-NYUKOUI-02-SEC           SECTION.
      *
           MOVE    ZERO                TO  TBL-IDX2.
      *
      *    コード表がない時、対象外
           IF     (TNS-CDKBN-KBN       =   SPACE )  AND
                  (TNS-CDKBN-KBNNUM    =   ZERO  )  AND
                  (TNS-CDKBN-KBNNUM-EDA    =   ZERO  )
               GO      TO      310112-NYUKOUI-02-EXT
           END-IF.
      *
      *    入院行為より、対象チェック
           PERFORM VARYING     TBL-IDX1    FROM    1   BY  1
                   UNTIL       TBL-IDX1       >    200
               EVALUATE    TRUE
                   WHEN    WRK-TBL-KNO   (IDX TBL-IDX1)    =   SPACE
                       MOVE    NSRY-SRYCD (IDZ)    TO  WRK-TBL-SRYCD
                                                       (IDX TBL-IDX1)
                       MOVE    NACCT-SRYYM         TO  WRK-TBL-SRYYYMM
                                                       (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBN       TO  WRK-TBL-KNOKBN
                                                       (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBNNUM    TO  WRK-TBL-KNONO
                                                       (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBNNUM-EDA  TO  WRK-TBL-KNONO2
                                                       (IDX TBL-IDX1)
      *
      *                名称編集
                       PERFORM 3101121-KNO-MEI-SEC
      *
                       MOVE    TBL-IDX1            TO  TBL-IDX2
                       MOVE    200                 TO  TBL-IDX1
                   WHEN    (TNS-CDKBN-KBN     
                                  =   WRK-TBL-KNOKBN(IDX TBL-IDX1))
                       AND (TNS-CDKBN-KBNNUM   
                                  =   WRK-TBL-KNONO(IDX TBL-IDX1))
                       AND (TNS-CDKBN-KBNNUM-EDA   
                                  =   WRK-TBL-KNONO2(IDX TBL-IDX1))
                       AND (NACCT-SRYYM         
                                  =   WRK-TBL-SRYYYMM(IDX TBL-IDX1))
                       MOVE    TBL-IDX1            TO  TBL-IDX2
                       MOVE    200                 TO  TBL-IDX1
               END-EVALUATE
           END-PERFORM.
      *
           IF      TBL-IDX2            =   ZERO
               MOVE    "9999"              TO  SPA-ERRCD
               GO      TO      310112-NYUKOUI-02-EXT
           END-IF.
      *
      *    入院行為回数計算
           PERFORM VARYING     TBL-IDX3    FROM    1   BY  1
                   UNTIL       TBL-IDX3    >   31
      *
               IF      NACCT-DAY(TBL-IDX3)   NOT =   ZERO
                   ADD     1              TO  WRK-TBL-KAISU
                                         (IDX TBL-IDX2 TBL-IDX3)
               END-IF
           END-PERFORM.
      *
       310112-NYUKOUI-02-EXT.
           EXIT.
      *
      *****************************************************************
      *   コード表ごとの編集処理
      *****************************************************************
       310112-SINKOUI-02-SEC           SECTION.
      *
           MOVE    ZERO                TO  TBL-IDX2.
      *
      *    コード表がない時、対象外
           IF     (TNS-CDKBN-KBN       =   SPACE )  AND
                  (TNS-CDKBN-KBNNUM    =   ZERO  )  AND
                  (TNS-CDKBN-KBNNUM-EDA    =   ZERO  )
               GO      TO      310112-SINKOUI-02-EXT
           END-IF.
      *
      *    診療行為より、対象チェック
           PERFORM VARYING     TBL-IDX1    FROM    1   BY  1
                   UNTIL       TBL-IDX1       >    200
               EVALUATE    TRUE
                   WHEN    WRK-TBL-KNO   (IDX TBL-IDX1)    =   SPACE
                       MOVE    SRY-SRYCD (IDZ)     TO  WRK-TBL-SRYCD
                                                       (IDX TBL-IDX1)
                       MOVE    ACCT-SRYYM          TO  WRK-TBL-SRYYYMM
                                                       (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBN       TO  WRK-TBL-KNOKBN
                                                       (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBNNUM    TO  WRK-TBL-KNONO
                                                       (IDX TBL-IDX1)
                       MOVE    TNS-CDKBN-KBNNUM-EDA  TO  WRK-TBL-KNONO2
                                                       (IDX TBL-IDX1)
      *
      *                名称編集
                       PERFORM 3101121-KNO-MEI-SEC
      *
                       MOVE    TBL-IDX1            TO  TBL-IDX2
                       MOVE    200                 TO  TBL-IDX1
                   WHEN    (TNS-CDKBN-KBN     
                                  =   WRK-TBL-KNOKBN(IDX TBL-IDX1))
                       AND (TNS-CDKBN-KBNNUM   
                                  =   WRK-TBL-KNONO(IDX TBL-IDX1))
                       AND (TNS-CDKBN-KBNNUM-EDA   
                                  =   WRK-TBL-KNONO2(IDX TBL-IDX1))
                       AND (ACCT-SRYYM         
                                  =   WRK-TBL-SRYYYMM(IDX TBL-IDX1))
                       MOVE    TBL-IDX1            TO  TBL-IDX2
                       MOVE    200                 TO  TBL-IDX1
               END-EVALUATE
           END-PERFORM.
      *
           IF      TBL-IDX2            =   ZERO
               MOVE    "9999"              TO  SPA-ERRCD
               GO      TO      310112-SINKOUI-02-EXT
           END-IF.
      *
      *    診療行為回数計算
           PERFORM VARYING     TBL-IDX3    FROM    1   BY  1
                   UNTIL       TBL-IDX3    >   31
      *
               IF      ACCT-DAY(1 TBL-IDX3)   NOT =   ZERO
                   ADD     1              TO  WRK-TBL-KAISU
                                         (IDX TBL-IDX2 TBL-IDX3)
               END-IF
           END-PERFORM.
      *
       310112-SINKOUI-02-EXT.
           EXIT.
      *
      *****************************************************************
      *   コード表示名称編集処理
      *****************************************************************
       3101121-KNO-MEI-SEC              SECTION.
      *
           SET     MKNO-IDX            TO  1.
           SEARCH      MKNO-TBL-OCC    VARYING   MKNO-IDX
                   AT   END
                       MOVE    WRK-TBL-KNO   (IDX TBL-IDX1)
                               TO  WRK-TBL-MEISYO(IDX TBL-IDX1)
                   WHEN    WRK-TBL-KNO   (IDX TBL-IDX1)
                                     =   MKNO-KNO    (MKNO-IDX)
                       MOVE    MKNO-KNOMEI (MKNO-IDX)
                               TO  WRK-TBL-MEISYO(IDX TBL-IDX1)
           END-SEARCH. 
      *
       3101121-KNO-MEI-EXT.
           EXIT.
      *
      *****************************************************************
      *   編集領域からＳＰＡへ  編集処理
      *****************************************************************
       31012-SPA-HEN-SEC               SECTION.
      *
           MOVE    ZERO                TO  IDX1.
           MOVE    ZERO                TO  IDX2.
           INITIALIZE                  SPA-I42NAI-AREA.
      *
           PERFORM VARYING     TBL-IDX2    FROM    1   BY  1
                   UNTIL      (TBL-IDX2       >    200     )   OR
                              (IDX1           =    100     )   OR
                              (IDX2           =    100     )   OR
                              (WRK-TBL-SRYCD (IDX TBL-IDX2)
                                              =   SPACE )
               ADD     1               TO  IDX1
               MOVE    WRK-TBL-SRYYYMM (IDX TBL-IDX2)
                                       TO  SPA-NAI-SRYYYMM (IDX IDX1)
               MOVE    WRK-TBL-SRYCD   (IDX TBL-IDX2)
                                       TO  SPA-NAI-SRYCD2 (IDX IDX1)
      *
               MOVE    WRK-TBL-SRYYYMM (IDX TBL-IDX2)
                                           TO  WRK-SYMD(1:6)
               MOVE    01                  TO  WRK-SDD
               PERFORM 41012-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG    TO  SPA-GMN-TSRYYYMM (IDX IDX1)
      *
               MOVE    WRK-TBL-MEISYO  (IDX TBL-IDX2)
                                      TO  SPA-GMN-TNAIYOU2(IDX IDX1)
               PERFORM VARYING     TBL-IDX3    FROM    1   BY  1
                       UNTIL      (TBL-IDX3       >    31      )  OR
                                  (IDX2           =    200     )
                   IF      WRK-TBL-KAISU (IDX TBL-IDX2 TBL-IDX3)
                                                  >    ZERO
                       IF      WRK-TBL-SRYKBN (IDX TBL-IDX2)
                                                  NOT =   "90"
                           ADD     1                TO  IDX2
                           MOVE    SPA-NAI-SRYYYMM (IDX IDX1)
                                                    TO  SPA-NAI-SRYYMD
                                                      (IDX IDX2)(1:6)
                           MOVE    TBL-IDX3         TO  SPA-NAI-SRYYMD
                                                      (IDX IDX2)(7:2)
      *
                           MOVE    SPA-NAI-SRYYMD (IDX IDX2)
                                                    TO  WRK-SYMD
                           PERFORM 41012-SEIWA-HEN-SEC
                           MOVE    WRK-HENYMDG      TO  SPA-GMN-TSRYYMD
                                                           (IDX IDX2)
      *
                           MOVE    WRK-TBL-MEISYO  (IDX TBL-IDX2)
                                                    TO  SPA-GMN-TNAIYOU1
                                                            (IDX IDX2)
                           MOVE    WRK-TBL-SRYCD   (IDX TBL-IDX2)
                                                    TO  SPA-NAI-SRYCD1
                                                            (IDX IDX2)
                           ADD     1                TO  SPA-GMN-TKAISU1
                                                            (IDX IDX2)
                       END-IF
      *
                       ADD     1                  TO  SPA-GMN-TKAISU2
                                                            (IDX IDX1)
                   END-IF
               END-PERFORM
            END-PERFORM.
      *
      *    入院年月日・入院コード順にＳＯＲＴ
           PERFORM 310122-SORT-02-SEC.
      *
       31012-SPA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *   入院年月・入院コード順にＳＯＲＴ  編集処理
      *****************************************************************
       310121-SORT-01-SEC               SECTION.
      *
      *    診療年月・診療コード順にＳＯＲＴ
           INITIALIZE                      WRK-STBL-AREA.
           INITIALIZE                      WRK-STBL-AREA2.
           MOVE    WRK-TBL-AREA        TO  WRK-STBL-AREA.
           INITIALIZE                      WRK-TBL-AREA2.
           INITIALIZE                      WRK-TBL-AREA.
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
      *        入院行為別集計ＳＯＲＴ
               PERFORM 3101211-SORT-011-SEC 
           END-PERFORM.
      *
       310121-SORT-01-EXT.
           EXIT.
      *
      *****************************************************************
      *   入院行為別集計ＳＯＲＴ  編集処理
      *****************************************************************
       3101211-SORT-011-SEC               SECTION.
      *
           PERFORM VARYING     IDX1        FROM    1   BY  1
                   UNTIL       IDX1        >   200
               MOVE    LOW-VALUE           TO  WRK-SRYYYMM
               MOVE    HIGH-VALUE          TO  WRK-SRYCD
               MOVE    ZERO                TO  IDX3
               PERFORM VARYING     IDX2        FROM    1   BY  1
                       UNTIL       IDX2        >   200
                   IF      WRK-STBL-SRYCD (IDX IDX2)    =   SPACE
                       CONTINUE
                   ELSE
                       IF      WRK-STBL-SRYYYMM(IDX IDX2)
                                                   >   WRK-SRYYYMM
                            MOVE    WRK-STBL-SRYCD  (IDX IDX2)  
                                                     TO  WRK-SRYCD
                            MOVE    WRK-STBL-SRYYYMM(IDX IDX2)  
                                                     TO  WRK-SRYYYMM
                            MOVE    IDX2             TO  IDX3
                      ELSE
                          IF     (WRK-STBL-SRYYYMM(IDX IDX2)
                                               =   WRK-SRYYYMM) AND
                                 (WRK-STBL-SRYCD(IDX IDX2)
                                               <   WRK-SRYCD  )
                               MOVE    WRK-STBL-SRYCD  (IDX IDX2)
                                                      TO  WRK-SRYCD
                               MOVE    WRK-STBL-SRYYYMM(IDX IDX2)
                                                      TO  WRK-SRYYYMM
                               MOVE    IDX2           TO  IDX3
                          END-IF
                      END-IF
                   END-IF
               END-PERFORM
      *
               IF      IDX3                >   ZERO
                   MOVE    WRK-STBL-OCC2 (IDX IDX3)
                                          TO  WRK-TBL-OCC2 (IDX IDX1)
                   MOVE    SPACE          TO  WRK-STBL-OCC2(IDX IDX3)
               END-IF
           END-PERFORM.
      *
       3101211-SORT-011-EXT.
           EXIT.
      *
      *****************************************************************
      *   入院年月日・入院コード順にＳＯＲＴ処理
      *****************************************************************
       310122-SORT-02-SEC               SECTION.
      *    ワークへ編集
           INITIALIZE                      WRK-GMN-AREA.
           MOVE    ZERO                TO  IDX-MAX.
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL       IDX1    >    100
               MOVE    SPA-GMN-TBLREC1 (IDX IDX1)
                                            TO  WRK-GMN-TBLREC1 (IDX1)
               MOVE    SPA-NAI-TBLREC1 (IDX IDX1)
                                            TO  WRK-NAI-TBLREC1 (IDX1)
               MOVE    SPACE           TO   SPA-GMN-TBLREC1 (IDX IDX1)
               MOVE    SPACE           TO   SPA-NAI-TBLREC1 (IDX IDX1)
           END-PERFORM.
      *
           PERFORM VARYING     IDX1        FROM    1   BY  1
                   UNTIL       IDX1        >   100
               MOVE    LOW-VALUE           TO  WRK-SRYYMD
               MOVE    HIGH-VALUE          TO  WRK-SRYCD
               MOVE    ZERO                TO  IDX3
               PERFORM VARYING     IDX2        FROM    1   BY  1
                       UNTIL       IDX2        >   100
               IF      WRK-NAI-SRYCD (IDX2)    =   SPACE
                   CONTINUE
               ELSE
                   EVALUATE    TRUE
      *
                       WHEN    WRK-NAI-SRYYMD (IDX2)   >   WRK-SRYYMD
                           MOVE    WRK-NAI-SRYCD  (IDX2)   
                                                       TO  WRK-SRYCD
                           MOVE    WRK-NAI-SRYYMD (IDX2)   
                                                       TO  WRK-SRYYMD
                           MOVE    IDX2                TO  IDX3
      *
                       WHEN   (WRK-NAI-SRYYMD (IDX2)   
                                                =   WRK-SRYYMD )  AND
                              (WRK-NAI-SRYCD  (IDX2)   <   WRK-SRYCD  )
                           MOVE    WRK-NAI-SRYCD  (IDX2)   
                                                TO  WRK-SRYCD
                           MOVE    WRK-NAI-SRYYMD (IDX2)   
                                                TO  WRK-SRYYMD
                           MOVE    IDX2         TO  IDX3
      *                同日に同じ行為の時、削除とする
                       WHEN   (WRK-NAI-SRYYMD (IDX2)   
                                              =   WRK-SRYYMD )  AND
                              (WRK-NAI-SRYCD  (IDX2)   
                                              =   WRK-SRYCD  )
                           MOVE    SPACE  TO  WRK-GMN-TBLREC1 (IDX2)
                           MOVE    SPACE  TO  WRK-NAI-TBLREC1 (IDX2)
                   END-EVALUATE
               END-PERFORM
      *
               IF      IDX3                >   ZERO
                   MOVE    WRK-GMN-TBLREC1 (IDX3)
                                      TO  SPA-GMN-TBLREC1 (IDX IDX1)
                   MOVE    WRK-NAI-TBLREC1 (IDX3)
                                      TO  SPA-NAI-TBLREC1 (IDX IDX1)
                   MOVE    SPACE      TO  WRK-GMN-TBLREC1 (IDX3)
                   MOVE    SPACE      TO  WRK-NAI-TBLREC1 (IDX3)
               END-IF
           END-PERFORM.
      *
       310122-SORT-02-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦和暦編集処理
      *****************************************************************
       41012-SEIWA-HEN-SEC             SECTION.
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
           END-IF.
      *
       41012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
           MOVE    SPACE               TO  I42.
      *
           MOVE    SPA-GMN-PTNUM       TO  I42-PTNUM.
           MOVE    SPA-GMN-KANANAME    TO  I42-KANANAME.
           MOVE    SPA-GMN-NAME        TO  I42-NAME.
           MOVE    SPA-GMN-SEX         TO  I42-SEX.
           MOVE    SPA-GMN-BIRTHDAYW   TO  I42-BIRTHDAY.
           MOVE    SPA-I40-SRYKAMEI    TO  I42-SRYKA.
      *
           IF      SPA-GMN-SYORI       =   ZERO
               MOVE   1                TO  SPA-GMN-SYORI
           END-IF.
           MOVE    SPA-GMN-SYORI       TO  IDX,
           PERFORM   VARYING   IDY     FROM    1   BY  1
                     UNTIL     IDY         >   100
               IF     (IDY             =   1   )   OR
                      (SPA-GMN-TSRYYMD (IDX IDY)
                            NOT =   SPA-GMN-TSRYYMD (IDX IDY - 1))
                   MOVE    SPA-GMN-TSRYYMD (IDX IDY)   
                                       TO  I42-SRYACTYMD-YMD (IDY)
               END-IF
               MOVE    SPA-GMN-TNAIYOU1(IDX IDY)
                                       TO  I42-SRYACTYMD-NAME(IDY)
               IF      SPA-GMN-TNAIYOU1 (IDX IDY) NOT =   SPACE
                   MOVE    IDY         TO  I42-SRYACTYMD-COUNT
               END-IF
           END-PERFORM.
      *
           PERFORM   VARYING   IDY     FROM    1   BY  1
                     UNTIL     IDY         >   100
               IF     (IDY             =   1   )   OR
                      (SPA-GMN-TSRYYYMM (IDX IDY)
                                   NOT =   SPA-GMN-TSRYYYMM
                                                   (IDX IDY - 1))
                   MOVE    SPA-GMN-TSRYYYMM(IDX IDY)   
                                       TO  I42-SRYACTCNT-YM(IDY)
               END-IF
               MOVE    SPA-GMN-TNAIYOU2(IDX IDY)   
                                       TO  I42-SRYACTCNT-NAME(IDY)
               MOVE    SPA-GMN-TKAISU2 (IDX IDY)
                                       TO  WRK-ZZZ
               MOVE    WRK-ZZZ         TO  I42-SRYACTCNT-CNT (IDY)
               IF      SPA-GMN-TNAIYOU2(IDX IDY) NOT =  SPACE
                   MOVE    IDY         TO  I42-SRYACTCNT-COUNT
               END-IF   
           END-PERFORM.
      *
           PERFORM 5001-MAPCUR-SEC.
      *
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *    カーソルセット
           EVALUATE    SPA-GMN-CUR
               WHEN    01
                   MOVE    "B01"           TO  MCP-WIDGET
           END-EVALUATE.
      *
       5001-MAPCUR-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *        （診察）
               WHEN    "CLICKED"       ALSO    "B001"
                   PERFORM 220-SINS
      *        （処方）
               WHEN    "CLICKED"       ALSO    "B002"
                   PERFORM 230-SYOH
      *        （処置）
               WHEN    "CLICKED"       ALSO    "B003"
                   PERFORM 240-SYOC
      *        （検査）
               WHEN    "CLICKED"       ALSO    "B004"
                   PERFORM 250-KENS
      *        （Ｘ線）
               WHEN    "CLICKED"       ALSO    "B005"
                   PERFORM 260-XSEN
      *        （リハビリ）
               WHEN    "CLICKED"       ALSO    "B006"
                   PERFORM 270-RIHA
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "I41"               TO  SPA-SAKIPG.
           MOVE    "I42"               TO  SPA-MOTOPG.
      *
           MOVE    SPA-I4KYOUTU        TO  SPA-WORK.
      *
           MOVE    SPACE               TO  LINKAREA.
           MOVE    SPA-KYOUTU          TO  LNK-COMMON.
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU.
           MOVE    SPA-I4              TO  LNK-SCRSPA.
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE.
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END.
      *
       210-BACK-EXT.
           EXIT.
      *****************************************************************
      *    診察　処理
      *****************************************************************
       220-SINS                    SECTION.
      *
           MOVE    1             TO  SPA-GMN-SYORI.
      *
       220-SINS-EXT.
           EXIT.
      *****************************************************************
      *    処方　処理
      *****************************************************************
       230-SYOH                    SECTION.
      *
           MOVE    2             TO  SPA-GMN-SYORI.
      *
       230-SYOH-EXT.
           EXIT.
      *****************************************************************
      *    処置　処理
      *****************************************************************
       240-SYOC                    SECTION.
      *
           MOVE    3             TO  SPA-GMN-SYORI.
      *
       240-SYOC-EXT.
           EXIT.
      *****************************************************************
      *    検査　処理
      *****************************************************************
       250-KENS                    SECTION.
      *
           MOVE    4             TO  SPA-GMN-SYORI.
      *
       250-KENS-EXT.
           EXIT.
      *****************************************************************
      *    Ｘ線　処理
      *****************************************************************
       260-XSEN                    SECTION.
      *
           MOVE    5             TO  SPA-GMN-SYORI.
      *
       260-XSEN-EXT.
           EXIT.
      *****************************************************************
      *    リハビリ　処理
      *****************************************************************
       270-RIHA                    SECTION.
      *
           MOVE    6             TO  SPA-GMN-SYORI.
      *
       270-RIHA-EXT.
           EXIT.
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC.
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "I42"               TO  MCP-WINDOW.
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
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    OTHER
                   MOVE    SPA-ERRCD
                                       TO  SPA-ERRMSG
           END-EVALUATE.
      *
           MOVE    SPACE               TO  I4ERR.
           MOVE    SPA-ERRCD           TO  I4ERR-ERRCODE.
           MOVE    SPA-ERRMSG          TO  I4ERR-ERRMSG.
           MOVE    "B01"               TO  MCP-WIDGET.
      *
           MOVE    "I42"               TO  SPA-MOTOPG.
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
      *
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  TNS-YUKOSTYMD.
           MOVE    ALL "9"             TO  TNS-YUKOEDYMD.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH.
           MOVE    WRK-SYSYMD          TO  ORC-DBYMD.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
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
           END-IF.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスタＦＥＴＣＨ読込
      *****************************************************************
       900-NYUINACCT-NEXT-SEC       SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  NYUINACCT-REC
               MOVE    ZERO                TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                      NYUINACCT-REC
               MOVE    1                   TO  FLG-NYUINACCT
           END-IF.
      *
       900-NYUINACCT-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスター読込
      *****************************************************************
       900-SRYACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACCT-REC
               MOVE    ZERO                TO  FLG-SRYACCT
           ELSE
               INITIALIZE                      SRYACCT-REC
               MOVE    1                   TO  FLG-SRYACCT
           END-IF.
      *
       900-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院行為マスター読込
      *****************************************************************
       930-NYUKOUI-RAED-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  NYUINACT-REC
               MOVE    ZERO                TO  FLG-NYUINACT
           ELSE
               INITIALIZE                      NYUINACT-REC
               MOVE    1                   TO  FLG-NYUINACT
           END-IF.
      *
       930-NYUKOUI-RAED-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター読込
      *****************************************************************
       930-SRYACT-RAED-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACT-REC
               MOVE    ZERO                TO  FLG-SRYACT
           ELSE
               INITIALIZE                      SRYACT-REC
               MOVE    1                   TO  FLG-SRYACT
           END-IF.
      *
       930-SRYACT-RAED-EXT.
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
