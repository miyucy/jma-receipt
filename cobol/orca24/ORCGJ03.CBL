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
       PROGRAM-ID.                 ORCGJ03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 会計照会
      *  コンポーネント名  : チェック（Ｊ０３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.00    NACL-多々納  02/09/12  ディレクトリをサブプロへ
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    診療行為コード表名称
      *****SELECT  TENSUKBN-FILE   ASSIGN  "TENSUKBNNAME.TXT"
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
      *    診療種別ファイル名
      *01  FILE-NAME.
      *    03  FILLER          PIC X(16)   VALUE   "/usr/local/orca/".
      *    03  FILLER          PIC X(05)   VALUE   "data/".
      **** 03  FILLER          PIC X(16)   VALUE   "TENSUKBNNAME.TXT".
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
           COPY    "J01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-J03.
           03  SPA-J03-AREA.
               05  SPA-GMN-PAGE                  PIC 9(02).
      *        05  SPA-MAX-PAGE                  PIC 9(02).
005200         05  SPA-GMN-MAX                   PIC 9(04).
005300*        05  SPA-GMN-IDX                   PIC 9(04).
005400         05  SPA-GMN-CUR                   PIC 9(02).
005500*
005600     03  SPA-GMN-AREA.
005700         05  SPA-GMN-SYORI                 PIC 9(04).
005800         05  SPA-GMN-AREA.
006700             07  SPA-GMN-TBL.
006800                 09  SPA-GMN-TBLOCC      OCCURS  6.
006900                     11  SPA-GMN-TBLREC1     OCCURS  100.
007000                         13  SPA-GMN-TSRYYMD     PIC X(09).
007100                         13  SPA-GMN-TNAIYOU1    PIC X(50).
007200                         13  SPA-GMN-TKAISU1     PIC 9(04).
006800                 09  SPA-GMN-TBLOCC2     OCCURS  6.
007300                     11  SPA-GMN-TBLREC2     OCCURS  100.
007400                         13  SPA-GMN-TSRYYYMM    PIC X(06).
007500                         13  SPA-GMN-TNAIYOU2    PIC X(50).
007600                         13  SPA-GMN-TKAISU2     PIC 9(04).
007700                     11  SPA-GMN-TMAX            PIC 9(04).
      *
      *    画面作成時にのみ使用
      *01  WRK-SPA-AREA.
007900         05  SPA-J03NAI-AREA.
008000             07  SPA-NAI-TBL.
008100                 09  SPA-NAI-TBLOCC      OCCURS  6.
008200                     11  SPA-NAI-TBLREC1     OCCURS  100.
008300                         13  SPA-NAI-SRYYMD     PIC X(08).
008400                         13  SPA-NAI-SRYCD1     PIC X(09).
008100                 09  SPA-NAI-TBLOCC2     OCCURS  6.
008500                     11  SPA-GMN-TBLREC2     OCCURS  100.
008600                         13  SPA-NAI-SRYYYMM    PIC X(06).
008700                         13  SPA-NAI-SRYCD2     PIC X(09).
008800*
      *    フラグ領域
       01  STS-AREA.
           03  STS-TENSUKBN        PIC X(02).
      *
010900*    フラグ領域
011000 01  FLG-AREA.
011100     03  FLG-END             PIC 9(01).
011200     03  FLG-SRYACT          PIC 9(01).
011300     03  FLG-HKNMST          PIC 9(01).
011400     03  FLG-HKNKUMI         PIC 9(01).
011500     03  FLG-SRYACCT         PIC 9(01).
011600     03  FLG-TENSU           PIC 9(01).
011700     03  FLG-TENSUKBN        PIC 9(01).
011800     03  FLG-KNJCOM          PIC 9(01).
011900*
012000     03  FLG-NAIYAK          PIC X(01).
012100     03  FLG-TONPUK          PIC X(01).
012200     03  FLG-GAIYAK          PIC X(01).
012300     03  FLG-SP              PIC 9(01).
012400*
012500*    カウント領域
012600 01  CNT-AREA.
012700     03  CNT-ERR             PIC 9(06).
012900*
013000*    システム領域
013100 01  SYS-AREA.
013200     03  SYS-YMD.
013300         05  SYS-YY          PIC 9(02).
013400         05  SYS-MM          PIC 9(02).
013500         05  SYS-DD          PIC 9(02).
013600*
013700*    添字領域
013800 01  IDX-AREA.
013900     03  IDX                 PIC 9(04).
014000     03  IDY                 PIC 9(04).
014100     03  IDZ                 PIC 9(04).
014200     03  IDX1                PIC 9(04).
014300     03  IDX2                PIC 9(04).
014400     03  IDX3                PIC 9(04).
014400     03  IDX-D               PIC 9(04).
           03  IDX-MAX             PIC 9(04).
014500*
014600*    一時領域
014700 01  WRK-AREA.
014800     03  WRK-SYSYMD.
014900         05  WRK-SYSYY       PIC 9(04).
015000         05  WRK-SYSMM       PIC 9(02).
015100         05  WRK-SYSDD       PIC 9(02).
015200     03  WRK-SYMD.
015300         05  WRK-SYY         PIC 9(04).
015400         05  WRK-SMM         PIC 9(02).
015500         05  WRK-SDD         PIC 9(02).
015600     03  WRK-WYMD.
015700         05  WRK-WGO         PIC X(01).
015800         05  WRK-WYY         PIC 9(02).
015900         05  WRK-WMM         PIC 9(02).
016000         05  WRK-WDD         PIC 9(02).
      *    診療日付
           03  WRK-SRYYM.
               05  WRK-SRYYY       PIC 9(04).
               05  WRK-SRYMM       PIC 9(02).
016100*
016200     03  WRK-ZZZ              PIC ZZZ.
016300*    マップ画面行
016400     03  WRK-MAP-INDEX        PIC 9(04).
016500*
016600     03  WRK-ERRMSG          PIC X(40).
016700*
016800*    編集用テーブル
016900 01  WRK-TBL-AREA.
017000     03  WRK-TBL-OCCURS          OCCURS  6.
017100         05  WRK-TBL-OCC2        OCCURS  200.
017200             07  WRK-TBL-SRYCD           PIC X(09).
017300             07  WRK-TBL-SRYYYMM         PIC X(06).
017400             07  WRK-TBL-MEISYO          PIC X(50).
017500*        コード表記 
017600             07  WRK-TBL-KNO.
017700                 09  WRK-TBL-KNOKBN          PIC  X(01).
017800                 09  WRK-TBL-KNONO           PIC  X(03).
017900                 09  WRK-TBL-KNONO2          PIC  X(02).
018000             07  WRK-TBL-OCC3            OCCURS   31.
018100                 09  WRK-TBL-KAISU           PIC 9(02).
018200             07  WRK-TBL-TUKIKAISU           PIC 9(04).
016900 01  WRK-TBL-AREA2.
018300     03  TBL-IDX1                PIC 9(04).
018400     03  TBL-IDX2                PIC 9(04).
018500     03  TBL-IDX3                PIC 9(02).
018500     03  TBL-IDX4                PIC 9(02).
018600*
018700*    ソート編集用テーブル
018800 01  WRK-STBL-AREA.
018900     03  WRK-STBL-OCCURS          OCCURS  6.
019000         05  WRK-STBL-OCC2        OCCURS  200.
019100             07  WRK-STBL-SRYCD           PIC X(09).
019200             07  WRK-STBL-SRYYYMM         PIC X(06).
019300             07  WRK-STBL-MEISYO          PIC X(50).
019400*            コード表記 
019500             07  WRK-STBL-KNO.
019600                 09  WRK-STBL-KNOKBN      PIC  X(01).
019700                 09  WRK-STBL-KNONO       PIC  X(03).
019800                 09  WRK-STBL-KNONO2      PIC  X(02).
019900             07  WRK-STBL-OCC3            OCCURS   31.
020000                 09  WRK-STBL-KAISU       PIC 9(02).
020100             07  WRK-STBL-TUKIKAISU       PIC 9(04).
020200*
018800 01  WRK-STBL-AREA2.
020300     03  WRK-SRYYYMM             PIC X(06).
020400     03  WRK-SRYCD               PIC X(09).
020500     03  WRK-KNO                 PIC X(06).
020600     03  WRK-SRYYMD              PIC X(08).
020700*
020800*    画面用ソート
020900 01  WRK-GMN-AREA.
021000     05  WRK-GMN-TBLREC1     OCCURS  100.
021100         07  WRK-GMN-TSRYYMD     PIC X(09).
021200         07  WRK-GMN-TNAIYOU1    PIC X(50).
021300         07  WRK-GMN-TKAISU1     PIC 9(04).
021400*
021500     05  WRK-NAI-TBLREC1     OCCURS  100.
021600         07  WRK-NAI-SRYYMD     PIC X(08).
021700         07  WRK-NAI-SRYCD      PIC X(09).
021800*
021900 01  WRK-HEN-AREA.
022000     03  WRK-HENYMDG             PIC X(09).
022100     03  WRK-HENYMD.
022200         05  WRK-HGO         PIC X(01).
022300         05  WRK-HYY         PIC 9(02).
022400         05  FILLER          PIC X(01)   VALUE   ".".
022500         05  WRK-HMM         PIC 9(02).
022600         05  FILLER          PIC X(01)   VALUE   ".".
022700         05  WRK-HDD         PIC 9(02).
      *
023800*    コード表名称テーブル
023900*    COPY    "CMKNOMEI.INC".
024000*   コード表名称テーブル
       01  MKNO-DATA-REC.
           03  MKNO-TBL-OCC        OCCURS    350   INDEXED   MKNO-IDX.
               05  MKNO-KNO.
                   07  MKNO-KNOKBN     PIC X(01).
                   07  MKNO-KNONO      PIC 9(03).
                   07  MKNO-KNONO2     PIC 9(02).
               05  MKNO-KNOMEI         PIC X(50).
022800*
022900**************************************************************
023000*    ファイルレイアウト
023100**************************************************************
023200*
023300*    システム管理マスタ
023400     COPY    "CPSYSKANRI.INC".
023500*
023600     COPY    "CPSK1005.INC".
023700*
024100*    点数マスタ−
024200*01  TNS-TENSU-REC.
024300     COPY    "CPTENSU.INC".
024400*
024500*    診療行為マスタ−
024600 01  SRYACT-REC.
024700     COPY    "CPSRYACT.INC".
024800*
024900*    保険組み合わせ
025000 01  HKNCOMBI-REC.
025100     COPY    "CPHKNCOMBI.INC".
025200*
025300*    診療会計マスタ−
025400 01  SRYACCT-REC.
025500     COPY    "CPSRYACCT.INC".
025600*
025700*    患者コメント
025800 01  PTCOM-REC.
025900     COPY    "CPPTCOM.INC".
026000*
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
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
027700*
027800*****************************************************************
027900*    連絡　領域
028000*****************************************************************
028100  LINKAGE                     SECTION.
028200*
028300     COPY    "MCPAREA".
028400     COPY    "ORCA-SPA".
028500*
028600     COPY    "LINKAREA".
028700*
       01  SCRAREA.
           COPY    "J02.INC".
           COPY    "J021.INC".
           COPY    "J022.INC".
           COPY    "J023.INC".
           COPY    "J024.INC".
           COPY    "J03.INC".
           COPY    "J04.INC".
           COPY    "J041.INC".
           COPY    "J042.INC".
           COPY    "J98.INC".
           COPY    "J99.INC".
           COPY    "JERR.INC".
           COPY    "JID1.INC".
029400*
029500 PROCEDURE                   DIVISION    USING
029600     MCPAREA
029700     SPAAREA
029800     LINKAREA
029900     SCRAREA.
030000**************************************************************
030100*    主　　処理
030200**************************************************************
030300 200-PROC-SEC                SECTION.
030400*
030500     MOVE    SPA-COMMON      TO  SPA-AREA
030600     MOVE    SPA-FREE        TO  SPA-J03
030700     MOVE    SPA-WORK        TO  SPA-J01KYOUTU
030800*
030900     MOVE    SPACE           TO  SPA-ERRCD
031000     MOVE    ZERO            TO  FLG-END
031100*
031200     EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
031300         WHEN    "LINK"          ALSO    ANY
031400             PERFORM 100-INIT-SEC
031500*    画面遷移
031600         WHEN     "PUTG"           ALSO   "CLICKED"
031700             PERFORM 200-GMNSENI
031800*    入力
031900*        WHEN      OTHER
032000*            PERFORM 200-ENTRY
032100     END-EVALUATE.
032200*
032300*    画面遷移がない時、画面表示へ
032400     IF      FLG-END             =   ZERO
032500         PERFORM 500-SET-SCREEN
032600     END-IF
032700*
032800     MOVE    SPA-J01KYOUTU   TO  SPA-WORK
032900     MOVE    SPA-AREA        TO  SPA-COMMON
033000     MOVE    SPA-J03         TO  SPA-FREE
033100*
033200     .
033300     EXIT    PROGRAM
033400     .
033500**************************************************************
033600*    初期　処理
033700**************************************************************
033800 100-INIT-SEC                SECTION.
033900*
034000*    DISPLAY "*** ORCGJ03    START  ***"
034100*
034200     INITIALIZE                  FLG-AREA
034400     INITIALIZE                  CNT-AREA
034500     INITIALIZE                  WRK-AREA
      *
      *    診療行為コード表名称セット
           PERFORM 1001-TENSUKBN-SET-SEC
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "JERR"
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
035300     MOVE    SPACE               TO  LINKAREA
035400*
035500*****MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE
035600     MOVE    "J03"               TO  MCP-WINDOW.
035700*
035800     PERFORM 900-PUT-WINDOW.
035900*
036000     MOVE    1                   TO  FLG-END
036100    .
036200 100-INIT-EXT.
036300     EXIT.
      *
      **************************************************************
      *    診療行為コード表名称セット
      **************************************************************
       1001-TENSUKBN-SET-SEC          SECTION.
      *
      *    フィアルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    DATA-FILE           TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01        TO  FILE-NAME
      *
      *    診療行為コード表名称セット
           INITIALIZE                  MKNO-DATA-REC
      *
           OPEN    INPUT               TENSUKBN-FILE
           IF      STS-TENSUKBN    NOT =   ZERO
               DISPLAY "TENSUKBN-FILE OPEN ERR:" STS-TENSUKBN
               GO     TO      1001-TENSUKBN-SET-EXT
           END-IF
      *
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  FLG-TENSUKBN
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
           END-PERFORM
      *
           CLOSE                   TENSUKBN-FILE
      *
           .  
       1001-TENSUKBN-SET-EXT.
           EXIT.
036400*
036500**************************************************************
036600*    初期画面処理
036700**************************************************************
036800 300-SCREEN-SEC              SECTION.
036900*
037000     INITIALIZE              SPA-J03
038200*
038300     MOVE    SPA-WORK        TO  SPA-J01KYOUTU
038400*
038500     PERFORM 310-SPA-SET-SEC
           MOVE    1             TO  SPA-GMN-SYORI
      *
           MOVE    1               TO  SPA-GMN-CUR
039300     .
039400 300-SCREEN-EXT.
039500     EXIT.
039600*
039700*****************************************************************
039800*    画面編集処理
039900*****************************************************************
040000 310-SPA-SET-SEC                 SECTION.
040800*
040900     MOVE    ZERO                TO  SPA-GMN-MAX
041000     INITIALIZE                      WRK-TBL-AREA
           INITIALIZE                      WRK-TBL-AREA2
      *
      *    当月分
      **** MOVE    SPA-SYSYMD(1:6)     TO  WRK-SRYYM
           MOVE    SPA-J02-SRYYMD(1:6) TO  WRK-SRYYM
           PERFORM 3101-ACCT-SYORI-SEC
      *    前月分
           COMPUTE WRK-SRYMM           =   WRK-SRYMM     -   1
           IF      WRK-SRYMM           =   ZERO
               MOVE    12                  TO  WRK-SRYMM
               COMPUTE WRK-SRYYY           =   WRK-SRYYY      -   1
           END-IF
           PERFORM 3101-ACCT-SYORI-SEC
046200*
046300*    診療年月・診療コード順にＳＯＲＴ
046400     PERFORM 310121-SORT-01-SEC
046500*
046600*    編集領域からＳＰＡへ
046700     PERFORM VARYING     IDX     FROM    1   BY  1
046800             UNTIL       IDX     >   6
046900         PERFORM 31012-SPA-HEN-SEC
047000     END-PERFORM
047100*
047200     .
047300 310-SPA-SET-EXT.
047400     EXIT.
047500*
      *
      *****************************************************************
039800*    診療会計マスターから編集処理
039900*****************************************************************
040000 3101-ACCT-SYORI-SEC                SECTION.
040800*
041200*    診療会計マスターから編集
041300     INITIALIZE                      SRYACCT-REC
041400     MOVE    SPA-HOSPID          TO  ACCT-HOSPID
041500     MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
041600     MOVE    SPA-GMN-PTID        TO  ACCT-PTID
041700     MOVE    SPA-J01-SRYKA       TO  ACCT-SRYKA
           MOVE    WRK-SRYYM           TO  ACCT-SRYYM
041800*
041900     MOVE    SRYACCT-REC         TO  MCPDATA-REC
042000     MOVE    "DBSELECT"          TO  MCP-FUNC
042100     MOVE    "SRYACCT-KEY2"      TO  ORC-DBPATH
042100*****MOVE    "SRYACCT-KEY4"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
042500     IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY2"      TO  ORC-DBPATH
      *********MOVE    "SRYACCT-KEY4"      TO  ORC-DBPATH
045700         PERFORM 900-SRYACCT-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-SRYACCT
           END-IF
042600     MOVE    ZERO                TO  IDX
042700     PERFORM UNTIL       FLG-SRYACCT       =   1
042900*        診療区分により、処理を決定する
043000         MOVE    ZERO                TO  IDX
043100         EVALUATE    ACCT-SRYKBN
043200*                診療
043300             WHEN    "11"
043400             WHEN    "12"
043500                 MOVE    1               TO  IDX
043600*                処方
043700             WHEN    "21"
043800             WHEN    "22"
043900             WHEN    "23"
044000                 MOVE    2               TO  IDX
044100*                処置
044200             WHEN    "40"
044300                 MOVE    3               TO  IDX
044400*                検査
044500             WHEN    "60"
044600                 MOVE    4               TO  IDX
044700*                Ｘ線
044800             WHEN    "70"
044900                 MOVE    5               TO  IDX
045000*                リハビリ
045100             WHEN    "80"
045200                 MOVE    6               TO  IDX
045300         END-EVALUATE
      *        当月、前月のみ対象とする
               IF      ACCT-SRYYM          =   WRK-SRYYM   OR
      *****************************************SPA-SYSYMD(1:6)
                                               SPA-J02-SRYYMD(1:6)
                   CONTINUE
               ELSE
                   MOVE    ZERO                TO  IDX
               END-IF
      *
045400         IF      IDX             NOT =   ZERO
045500             PERFORM 3101-SRYACCT-SPA-SEC
045600         END-IF
042800         MOVE    "SRYACCT-KEY2"      TO  ORC-DBPATH
042800*********MOVE    "SRYACCT-KEY4"      TO  ORC-DBPATH
045700         PERFORM 900-SRYACCT-NEXT-SEC
045800     END-PERFORM
      *
042000     MOVE    "DBCLOSE"          TO  MCP-FUNC
042100     MOVE    "SRYACCT-KEY2"     TO  ORC-DBPATH
042100*****MOVE    "SRYACCT-KEY4"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
046200*
047200     .
047300 3101-ACCT-SYORI-EXT.
047400     EXIT.
047500*
047600*****************************************************************
047700*   診療会計マスターより画面内容編集処理
047800*****************************************************************
047900 3101-SRYACCT-SPA-SEC             SECTION.
048000*
048100*    診療行為マスター読み込み
048200     INITIALIZE                      SRYACT-REC
048300     MOVE    ACCT-HOSPID         TO  SRY-HOSPID
048400     MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN
048500     MOVE    ACCT-PTID           TO  SRY-PTID
048600     MOVE    ACCT-SRYKA          TO  SRY-SRYKA
048700     MOVE    ACCT-SRYYM          TO  SRY-SRYYM
048800     MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM
      *    点数検索用日付編集
           MOVE    ACCT-SRYYM          TO  WRK-SYSYMD(1:6)
           MOVE    01                  TO  WRK-SYSDD
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
               IF      ACCT-DAY (1 IDX-D)  NOT =   ZERO
                   MOVE    IDX-D           TO  WRK-SYSDD
                   MOVE    31              TO  IDX-D
               END-IF
           END-PERFORM
048900*
049000     MOVE    SRYACT-REC          TO  MCPDATA-REC
049100     MOVE    "DBSELECT"          TO  MCP-FUNC
049200     MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
049600     IF      MCP-RC              =   ZERO
049700         MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
049800         PERFORM 930-SINKOUI-RAED-SEC
049900     ELSE
050000         MOVE    1                   TO  FLG-SRYACT
050100     END-IF
050200*
050300     PERFORM UNTIL       FLG-SRYACT      =   1       
050400*        剤明細編集
050500         PERFORM VARYING     IDZ     FROM    1   BY  1
050600                 UNTIL      (IDZ         >   5   )  OR
050700                            (SRY-SRYCD (IDZ) =   SPACE )
050800*            コメント、薬剤投与、粉砕は対象外
050900             IF     (SRY-SRYCD (IDZ)(1:1)    =   "8"  )  OR
051000                    (SRY-SRYCD (IDZ)(1:3)    =   "001")  OR
051000                    (SRY-SRYCD (IDZ)         =   "099209901") OR
051100                    (SRY-AUTOKBN(IDZ)    NOT =   SPACE )
051200                 CONTINUE
051300             ELSE
051400*            点数マスタを取得する
051500                 MOVE    SRY-SRYCD (IDZ)     TO  TNS-SRYCD
051600                 PERFORM 910-TENSU-READ-SEC
051700                 IF     (FLG-TENSU           =   ZERO  )  AND
051800                        (TNS-DATAKBN     NOT =   2  AND  3 )
051900                     PERFORM 31011-SINKOUI-SPA-SEC
052000                 END-IF
052100             END-IF
052200         END-PERFORM
052300*
049700         MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
052400         PERFORM 930-SINKOUI-RAED-SEC
052500     END-PERFORM
      *
042000     MOVE    "DBCLOSE"          TO  MCP-FUNC
042100     MOVE    "SRYACT-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
046200*
052700     .
052800 3101-SRYACCT-SPA-EXT.
052900     EXIT.
053000*
053100*****************************************************************
053200*   診療行為ごとの編集処理
053300*****************************************************************
053400 31011-SINKOUI-SPA-SEC           SECTION.
053500*
053600     IF      IDX             =   1   OR  2
053700*        診療行為別編集
053800         PERFORM 310111-SINKOUI-01-SEC 
053900     ELSE
054000*        コード表別編集
054100         PERFORM 310112-SINKOUI-02-SEC 
054200     END-IF
054300*
054400     .
054500 3101-SRYACCT-SPA-EXT.
054600     EXIT.
054700*
054800*****************************************************************
054900*   診療行為ごとの編集処理
055000*****************************************************************
055100 310111-SINKOUI-01-SEC           SECTION.
055200*
055300     MOVE    ZERO                TO  TBL-IDX2
055400*    診療行為より、対象チェック
055500     PERFORM VARYING     TBL-IDX1    FROM    1   BY  1
055600             UNTIL       TBL-IDX1       >    200
055700         EVALUATE    TRUE
055800             WHEN    WRK-TBL-SRYCD (IDX TBL-IDX1)    =   SPACE
055900                 MOVE    SRY-SRYCD (IDZ)     TO  WRK-TBL-SRYCD
056000                                                  (IDX TBL-IDX1)
056100                 MOVE    ACCT-SRYYM          TO  WRK-TBL-SRYYYMM
056200                                                  (IDX TBL-IDX1)
056300                 MOVE    TNS-NAME            TO  WRK-TBL-MEISYO
056400                                                  (IDX TBL-IDX1)
056500                 MOVE    TNS-CDKBN-KBN       TO  WRK-TBL-KNOKBN
056600                                                  (IDX TBL-IDX1)
056700                 MOVE    TNS-CDKBN-KBNNUM    TO  WRK-TBL-KNONO
056800                                                  (IDX TBL-IDX1)
056900                 MOVE    TNS-CDKBN-KBNNUM-EDA  TO  WRK-TBL-KNONO2
057000                                                  (IDX TBL-IDX1)
057100                 MOVE    TBL-IDX1            TO  TBL-IDX2
057200                 MOVE    200                 TO  TBL-IDX1
057300             WHEN    (SRY-SRYCD (IDZ)    =   WRK-TBL-SRYCD
057400                                                 (IDX TBL-IDX1))
057500                AND  (ACCT-SRYYM         =   WRK-TBL-SRYYYMM
057600                                                 (IDX TBL-IDX1))
057700                 MOVE    TBL-IDX1            TO  TBL-IDX2
057800                 MOVE    200                 TO  TBL-IDX1
057900         END-EVALUATE
058000     END-PERFORM
058100*
058200     IF      TBL-IDX2            =   ZERO
058300         MOVE    "9999"              TO  SPA-ERRCD
058400         GO      TO      310111-SINKOUI-01-EXT
058500     END-IF
058600*
058700*    診療行為回数計算
058800     PERFORM VARYING     TBL-IDX4    FROM    2   BY  1
058900             UNTIL       TBL-IDX4    >   4
059000*
058800         PERFORM VARYING     TBL-IDX3    FROM    1   BY  1
058900                 UNTIL       TBL-IDX3    >   31
059000*
059100             IF      ACCT-DAY(TBL-IDX4 TBL-IDX3)
                                          NOT =   ZERO
059200                 ADD     1              TO  WRK-TBL-KAISU
059300                                       (IDX TBL-IDX2 TBL-IDX3)
059400             END-IF
059500         END-PERFORM
059500     END-PERFORM
059600*
059700     .
059800 310111-SINKOUI-01-EXT.
059900     EXIT.
060000*
060100*****************************************************************
060200*   コード表ごとの編集処理
060300*****************************************************************
060400 310112-SINKOUI-02-SEC           SECTION.
060500*
060600     MOVE    ZERO                TO  TBL-IDX2
060700*
060800*    コード表がない時、対象外
060900     IF     (TNS-CDKBN-KBN       =   SPACE )  AND
061000            (TNS-CDKBN-KBNNUM    =   ZERO  )  AND
061100            (TNS-CDKBN-KBNNUM-EDA    =   ZERO  )
061200         GO      TO      310112-SINKOUI-02-EXT
061300     END-IF
061400*
061500*    診療行為より、対象チェック
061600     PERFORM VARYING     TBL-IDX1    FROM    1   BY  1
061700             UNTIL       TBL-IDX1       >    200
061800         EVALUATE    TRUE
061900             WHEN    WRK-TBL-KNO   (IDX TBL-IDX1)    =   SPACE
062000                 MOVE    SRY-SRYCD (IDZ)     TO  WRK-TBL-SRYCD
062100                                                 (IDX TBL-IDX1)
062200                 MOVE    ACCT-SRYYM          TO  WRK-TBL-SRYYYMM
062300                                                 (IDX TBL-IDX1)
062400                 MOVE    TNS-CDKBN-KBN       TO  WRK-TBL-KNOKBN
062500                                                 (IDX TBL-IDX1)
062600                 MOVE    TNS-CDKBN-KBNNUM    TO  WRK-TBL-KNONO
062700                                                 (IDX TBL-IDX1)
062800                 MOVE    TNS-CDKBN-KBNNUM-EDA  TO  WRK-TBL-KNONO2
062900                                                 (IDX TBL-IDX1)
063000*
063100*                名称編集
063200                 PERFORM 3101121-KNO-MEI-SEC
063300*
063400                 MOVE    TBL-IDX1            TO  TBL-IDX2
063500                 MOVE    200                 TO  TBL-IDX1
063600             WHEN    (TNS-CDKBN-KBN     
063700                            =   WRK-TBL-KNOKBN(IDX TBL-IDX1))
063800                AND  (TNS-CDKBN-KBNNUM   
063900                            =   WRK-TBL-KNONO(IDX TBL-IDX1))
064000                AND  (TNS-CDKBN-KBNNUM-EDA   
064100                            =   WRK-TBL-KNONO2(IDX TBL-IDX1))
064200                AND  (ACCT-SRYYM         
064300                            =   WRK-TBL-SRYYYMM(IDX TBL-IDX1))
064400                 MOVE    TBL-IDX1            TO  TBL-IDX2
064500                 MOVE    200                 TO  TBL-IDX1
064600         END-EVALUATE
064700     END-PERFORM
064800*
064900     IF      TBL-IDX2            =   ZERO
065000         MOVE    "9999"              TO  SPA-ERRCD
065100         GO      TO      310112-SINKOUI-02-EXT
065200     END-IF
065300*
065400*    診療行為回数計算
058800     PERFORM VARYING     TBL-IDX4    FROM    2   BY  1
058900             UNTIL       TBL-IDX4    >   4
059000*
058800         PERFORM VARYING     TBL-IDX3    FROM    1   BY  1
058900                 UNTIL       TBL-IDX3    >   31
059000*
059100             IF      ACCT-DAY(TBL-IDX4 TBL-IDX3)
                                          NOT =   ZERO
059200                 ADD     1              TO  WRK-TBL-KAISU
059300                                       (IDX TBL-IDX2 TBL-IDX3)
059400             END-IF
059500         END-PERFORM
059500     END-PERFORM
066300*
066400     .
066500 310112-SINKOUI-02-EXT.
066600     EXIT.
066700*
066800*****************************************************************
066900*   コード表示名称編集処理
067000*****************************************************************
067100 3101121-KNO-MEI-SEC              SECTION.
067200*
067300     SET     MKNO-IDX            TO  1
067400     SEARCH      MKNO-TBL-OCC    VARYING   MKNO-IDX
067500             AT   END
067600                 MOVE    WRK-TBL-KNO   (IDX TBL-IDX1)
067700                         TO  WRK-TBL-MEISYO(IDX TBL-IDX1)
067800             WHEN    WRK-TBL-KNO   (IDX TBL-IDX1)
067900                               =   MKNO-KNO    (MKNO-IDX)
068000                 MOVE    MKNO-KNOMEI (MKNO-IDX)
068100                         TO  WRK-TBL-MEISYO(IDX TBL-IDX1)
068200     END-SEARCH 
068300*
068400     .
068500 3101121-KNO-MEI-EXT.
068600     EXIT.
068700*
068800*****************************************************************
068900*   編集領域からＳＰＡへ  編集処理
069000*****************************************************************
069100 31012-SPA-HEN-SEC               SECTION.
069200*
069300     MOVE    ZERO                TO  IDX1
069400     MOVE    ZERO                TO  IDX2
           INITIALIZE                  SPA-NAI-AREA
           INITIALIZE                  SPA-J03NAI-AREA
069500*
069600     PERFORM VARYING     TBL-IDX2    FROM    1   BY  1
069700             UNTIL      (TBL-IDX2       >    200     )   OR
                              (IDX1           =    100     )   OR
                              (IDX2           =    100     )   OR
069800                        (WRK-TBL-SRYCD (IDX TBL-IDX2)
                                              =   SPACE )
069900         ADD     1               TO  IDX1
070000         MOVE    WRK-TBL-SRYYYMM (IDX TBL-IDX2)
070100                                 TO  SPA-NAI-SRYYYMM (IDX IDX1)
070200         MOVE    WRK-TBL-SRYCD   (IDX TBL-IDX2)
070300                                 TO  SPA-NAI-SRYCD2 (IDX IDX1)
070400*
070500         MOVE    WRK-TBL-SRYYYMM (IDX TBL-IDX2)
070600                                     TO  WRK-SYMD(1:6)
070700         MOVE    01                  TO  WRK-SDD
070800         PERFORM 41012-SEIWA-HEN-SEC
070900         MOVE    WRK-HENYMDG    TO  SPA-GMN-TSRYYYMM (IDX IDX1)
071000*
071100         MOVE    WRK-TBL-MEISYO  (IDX TBL-IDX2)
071200                                TO  SPA-GMN-TNAIYOU2(IDX IDX1)
071300         PERFORM VARYING     TBL-IDX3    FROM    1   BY  1
071400                 UNTIL      (TBL-IDX3       >    31      )  OR
                                  (IDX2           =    200     )
071500             IF      WRK-TBL-KAISU (IDX TBL-IDX2 TBL-IDX3)
071600                                            >    ZERO
071700                 ADD     1                  TO  IDX2
071800                 MOVE    SPA-NAI-SRYYYMM (IDX IDX1)
071900                                            TO  SPA-NAI-SRYYMD
072000                                                (IDX IDX2)(1:6)
072100                 MOVE    TBL-IDX3           TO  SPA-NAI-SRYYMD
072200                                                (IDX IDX2)(7:2)
072300*
072400                 MOVE    SPA-NAI-SRYYMD (IDX IDX2)
072500                                            TO  WRK-SYMD
072600                 PERFORM 41012-SEIWA-HEN-SEC
072700                 MOVE    WRK-HENYMDG        TO  SPA-GMN-TSRYYMD
072800                                                     (IDX IDX2)
072900*
073000                 MOVE    WRK-TBL-MEISYO  (IDX TBL-IDX2)
073100                                           TO  SPA-GMN-TNAIYOU1
073200                                                      (IDX IDX2)
073300                 MOVE    WRK-TBL-SRYCD   (IDX TBL-IDX2)
073400                                            TO  SPA-NAI-SRYCD1
073500                                                      (IDX IDX2)
073600                 ADD     1                  TO  SPA-GMN-TKAISU1
073700                                                      (IDX IDX2)
073800*
073900                 ADD     1                  TO  SPA-GMN-TKAISU2
074000                                                      (IDX IDX1)
074100             END-IF
074200         END-PERFORM
074300      END-PERFORM
074400*
074500*    診療年月日・診療コード順にＳＯＲＴ
074600     PERFORM 310122-SORT-02-SEC
074700*
074800     .
074900 31012-SPA-HEN-EXT.
075000     EXIT.
075100*
075200*****************************************************************
075300*   診療年月・診療コード順にＳＯＲＴ  編集処理
075400*****************************************************************
075500 310121-SORT-01-SEC               SECTION.
075600*
075700*    診療年月・診療コード順にＳＯＲＴ
075800     INITIALIZE                      WRK-STBL-AREA
075800     INITIALIZE                      WRK-STBL-AREA2
075900     MOVE    WRK-TBL-AREA        TO  WRK-STBL-AREA
           INITIALIZE                      WRK-TBL-AREA2
076000     INITIALIZE                      WRK-TBL-AREA
076100     PERFORM VARYING     IDX     FROM    1   BY  1
076200             UNTIL       IDX     >   6
076300*        診療行為別集計ＳＯＲＴ
076400         PERFORM 3101211-SORT-011-SEC 
076500     END-PERFORM 
076600*
076700     .
076800 310121-SORT-01-EXT.
076900     EXIT.
077000*
077100*****************************************************************
077200*   診療行為別集計ＳＯＲＴ  編集処理
077300*****************************************************************
077400 3101211-SORT-011-SEC               SECTION.
077500*
077600     PERFORM VARYING     IDX1        FROM    1   BY  1
077700             UNTIL       IDX1        >   200
077800         MOVE    LOW-VALUE           TO  WRK-SRYYYMM
077900         MOVE    HIGH-VALUE          TO  WRK-SRYCD
078000         MOVE    ZERO                TO  IDX3
078100         PERFORM VARYING     IDX2        FROM    1   BY  1
078200                 UNTIL       IDX2        >   200
078300             IF      WRK-STBL-SRYCD (IDX IDX2)    =   SPACE
078400                 CONTINUE
078500             ELSE
078600                 IF      WRK-STBL-SRYYYMM(IDX IDX2)
078700                                             >   WRK-SRYYYMM
078800                      MOVE    WRK-STBL-SRYCD  (IDX IDX2)  
078900                                               TO  WRK-SRYCD
079000                      MOVE    WRK-STBL-SRYYYMM(IDX IDX2)  
079100                                               TO  WRK-SRYYYMM
079200                      MOVE    IDX2             TO  IDX3
079300                ELSE
079400                    IF     (WRK-STBL-SRYYYMM(IDX IDX2)
079500                                         =   WRK-SRYYYMM) AND
079600                           (WRK-STBL-SRYCD(IDX IDX2)
079700                                         <   WRK-SRYCD  )
079800                         MOVE    WRK-STBL-SRYCD  (IDX IDX2)
079900                                                TO  WRK-SRYCD
080000                         MOVE    WRK-STBL-SRYYYMM(IDX IDX2)
080100                                                TO  WRK-SRYYYMM
080200                         MOVE    IDX2           TO  IDX3
080300                    END-IF
080400                END-IF
080500             END-IF
080600         END-PERFORM
080700*
080800         IF      IDX3                >   ZERO
080900             MOVE    WRK-STBL-OCC2 (IDX IDX3)
081000                                    TO  WRK-TBL-OCC2 (IDX IDX1)
081100             MOVE    SPACE          TO  WRK-STBL-OCC2(IDX IDX3)
081200         END-IF
081300     END-PERFORM
081400*
081500     .
081600 3101211-SORT-011-EXT.
081700     EXIT.
081800*
081900*****************************************************************
082000*   診療年月日・診療コード順にＳＯＲＴ処理
082100*****************************************************************
082200 310122-SORT-02-SEC               SECTION.
082400*    ワークへ編集
082500     INITIALIZE                      WRK-GMN-AREA
           MOVE    ZERO                TO  IDX-MAX
082600     PERFORM VARYING     IDX1    FROM    1   BY  1
082700             UNTIL       IDX1    >    100
082800         MOVE    SPA-GMN-TBLREC1 (IDX IDX1)
082900                                      TO  WRK-GMN-TBLREC1 (IDX1)
083000         MOVE    SPA-NAI-TBLREC1 (IDX IDX1)
083100                                      TO  WRK-NAI-TBLREC1 (IDX1)
083200*        INITIALIZE                   SPA-GMN-TBLREC1 (IDX IDX1)
083300*        INITIALIZE                   SPA-NAI-TBLREC1 (IDX IDX1)
               MOVE    SPACE           TO   SPA-GMN-TBLREC1 (IDX IDX1)
083300         MOVE    SPACE           TO   SPA-NAI-TBLREC1 (IDX IDX1)
083400     END-PERFORM
083500*
083600     PERFORM VARYING     IDX1        FROM    1   BY  1
083700             UNTIL       IDX1        >   100
083800         MOVE    LOW-VALUE           TO  WRK-SRYYMD
083900         MOVE    HIGH-VALUE          TO  WRK-SRYCD
084000         MOVE    ZERO                TO  IDX3
084100         PERFORM VARYING     IDX2        FROM    1   BY  1
084200                 UNTIL       IDX2        >   100
084300         IF      WRK-NAI-SRYCD (IDX2)    =   SPACE
084400             CONTINUE
084500         ELSE
084600             EVALUATE    TRUE
084700*
084800                 WHEN    WRK-NAI-SRYYMD (IDX2)   >   WRK-SRYYMD
084900                     MOVE    WRK-NAI-SRYCD  (IDX2)   
085000                                                 TO  WRK-SRYCD
085100                     MOVE    WRK-NAI-SRYYMD (IDX2)   
085200                                                 TO  WRK-SRYYMD
085300                     MOVE    IDX2                TO  IDX3
085400*
085500                 WHEN   (WRK-NAI-SRYYMD (IDX2)   
085600                                          =   WRK-SRYYMD )  AND
085700                        (WRK-NAI-SRYCD  (IDX2)   <   WRK-SRYCD  )
085800                     MOVE    WRK-NAI-SRYCD  (IDX2)   
085900                                          TO  WRK-SRYCD
086000                     MOVE    WRK-NAI-SRYYMD (IDX2)   
086100                                          TO  WRK-SRYYMD
086200                     MOVE    IDX2         TO  IDX3
086300*                同日に同じ行為の時、削除とする
086400                 WHEN   (WRK-NAI-SRYYMD (IDX2)   
086500                                        =   WRK-SRYYMD )  AND
086600                        (WRK-NAI-SRYCD  (IDX2)   
086700                                        =   WRK-SRYCD  )
086800                     MOVE    SPACE  TO  WRK-GMN-TBLREC1 (IDX2)
086900                     MOVE    SPACE  TO  WRK-NAI-TBLREC1 (IDX2)
087000             END-EVALUATE
087100         END-PERFORM
087200*
087300         IF      IDX3                >   ZERO
087400             MOVE    WRK-GMN-TBLREC1 (IDX3)
087500                                TO  SPA-GMN-TBLREC1 (IDX IDX1)
087600             MOVE    WRK-NAI-TBLREC1 (IDX3)
087700                                TO  SPA-NAI-TBLREC1 (IDX IDX1)
087800             MOVE    SPACE      TO  WRK-GMN-TBLREC1 (IDX3)
087900             MOVE    SPACE      TO  WRK-NAI-TBLREC1 (IDX3)
088000         END-IF
088100     END-PERFORM
088200     .
088300 310122-SORT-02-EXT.
088400     EXIT.
088500*
088600*****************************************************************
088700*    西暦和暦編集処理
088800*****************************************************************
088900 41012-SEIWA-HEN-SEC             SECTION.
089000*
089100     IF      WRK-SYMD            =   ALL "9"  OR   SPACE
089200         MOVE    SPACE               TO  WRK-HGO
089300         MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
089400         MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
089500         MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
089600         MOVE    WRK-HENYMD          TO  WRK-HENYMDG
089700     ELSE
089800         INITIALIZE                      STS-AREA-DAY
089900         INITIALIZE                      LNK-DAY2-AREA
090000         MOVE    "21"                TO  LNK-DAY2-IRAI
090100         MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
090200         CALL    "ORCSDAY"           USING   STS-AREA-DAY
090300                                             LNK-DAY2-AREA
090400         MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
090500     END-IF
090600     .
090700 41012-SEIWA-HEN-EXT.
090800     EXIT.
090900*
091000*****************************************************************
091100*    画面編集処理
091200*****************************************************************
091300 500-GMNHEN-SEC                  SECTION.
091400     MOVE    SPACE               TO  J03
091500*
091600     MOVE    SPA-GMN-PTNUM       TO  J03-PTNUM
091700     MOVE    SPA-GMN-KANANAME    TO  J03-KANANAME
091800     MOVE    SPA-GMN-NAME        TO  J03-NAME
091900     MOVE    SPA-GMN-SEX         TO  J03-SEX
092000     MOVE    SPA-GMN-BIRTHDAYW   TO  J03-BIRTHDAY
092100     MOVE    SPA-J01-SRYKAMEI    TO  J03-SRYKA
092200*
           IF      SPA-GMN-SYORI       =   ZERO
               MOVE   1                TO  SPA-GMN-SYORI
           END-IF 
092300     MOVE    SPA-GMN-SYORI       TO  IDX
092400     PERFORM   VARYING   IDY     FROM    1   BY  1
092500               UNTIL     IDY         >   100
092600         IF     (IDY             =   1   )   OR
092700                (SPA-GMN-TSRYYMD (IDX IDY)
092800                      NOT =   SPA-GMN-TSRYYMD (IDX IDY - 1) )
092900             MOVE    SPA-GMN-TSRYYMD (IDX IDY)   
093000                                 TO  J03-SRYACTYMD-YMD (IDY)
093100         END-IF
093200         MOVE    SPA-GMN-TNAIYOU1(IDX IDY)
093300                                 TO  J03-SRYACTYMD-NAME(IDY)
               IF      SPA-GMN-TNAIYOU1 (IDX IDY) NOT =   SPACE
                   MOVE    IDY         TO  J03-SRYACTYMD-COUNT
               END-IF
           END-PERFORM
      *
092400     PERFORM   VARYING   IDY     FROM    1   BY  1
092500               UNTIL     IDY         >   100
093400         IF     (IDY             =   1   )   OR
093500                (SPA-GMN-TSRYYYMM (IDX IDY)
093600                             NOT =   SPA-GMN-TSRYYYMM
                                                   (IDX IDY - 1) )
093700             MOVE    SPA-GMN-TSRYYYMM(IDX IDY)   
093800                                 TO  J03-SRYACTCNT-YM(IDY)
093900         END-IF
094000         MOVE    SPA-GMN-TNAIYOU2(IDX IDY)   
094100                                 TO  J03-SRYACTCNT-NAME(IDY)
094200         MOVE    SPA-GMN-TKAISU2 (IDX IDY)
                                       TO  WRK-ZZZ
               MOVE    WRK-ZZZ         TO  J03-SRYACTCNT-CNT (IDY)
               IF      SPA-GMN-TNAIYOU2(IDX IDY) NOT =  SPACE
                   MOVE    IDY         TO  J03-SRYACTCNT-COUNT
               END-IF   
094400     END-PERFORM
094500*
094600*    頁数セット
094700*    IF      SPA-GMN-TMAX (SPA-GMN-SYORI)    >   ZERO
094800*        COMPUTE SPA-MAX-PAGE   =  (SPA-GMN-TMAX (SPA-GMN-SYORI)
094900*                               -   1  )
095000*                               /   20     +   1
095100*    ELSE
095200*        MOVE    1               TO  SPA-MAX-PAGE
095300*    END-IF
      *
           PERFORM 5001-MAPCUR-SEC
095400     .
095500 500-GMNHEN-EXT.
095600     EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *    カーソルセット
           EVALUATE    SPA-GMN-CUR
               WHEN    01
                   MOVE    "B01"           TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
095700*****************************************************************
095800*    画面遷移処理
095900*****************************************************************
096000 200-GMNSENI                   SECTION.
096100*
096200     EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
096300*        戻る
096400         WHEN    "CLICKED"       ALSO    "B01"
096500             PERFORM 210-BACK
096600*        （診察）
096700         WHEN    "CLICKED"       ALSO    "B001"
096800             PERFORM 220-SINS
096900*        （処方）
097000         WHEN    "CLICKED"       ALSO    "B002"
097100             PERFORM 230-SYOH
097200*        （処置）
097300         WHEN    "CLICKED"       ALSO    "B003"
097400             PERFORM 240-SYOC
097500*        （検査）
097600         WHEN    "CLICKED"       ALSO    "B004"
097700             PERFORM 250-KENS
097800*        （Ｘ線）
097900         WHEN    "CLICKED"       ALSO    "B005"
098000             PERFORM 260-XSEN
098100*        （リハビリ）
098200         WHEN    "CLICKED"       ALSO    "B006"
098300             PERFORM 270-RIHA
098400     END-EVALUATE
098500     .
098600 200-GMNSENI-EXT.
098700     EXIT.
098800*****************************************************************
098900*    戻る　処理
099000*****************************************************************
099100 210-BACK                    SECTION.
099200*
099300     MOVE    "J02"               TO  SPA-SAKIPG
099400     MOVE    "J03"               TO  SPA-MOTOPG
099500*
099600     MOVE    SPA-J01KYOUTU       TO  SPA-WORK
099700*
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
099800*****MOVE    "JOIN"              TO  MCP-PUTTYPE
099900     MOVE    SPA-SAKIPG          TO  MCP-WINDOW
100000*
100100     PERFORM 900-PUT-WINDOW
100200*
100300     MOVE    1                   TO  FLG-END
100400*
100500     .
100600 210-BACK-EXT.
100700     EXIT.
100800*****************************************************************
100900*    診察　処理
101000*****************************************************************
101100 220-SINS                    SECTION.
101200*
101300     MOVE    1             TO  SPA-GMN-SYORI
101400*
101500*    PERFORM 500-GMNHEN-SEC
101800*
101900*    MOVE    "CURRENT"           TO  MCP-PUTTYPE.
102000*    MOVE    "J03    "           TO  MCP-WINDOW.
102100*
102200*    PERFORM 900-PUT-WINDOW.
102300     .
102400 220-SINS-EXT.
102500     EXIT.
102600*****************************************************************
102700*    処方　処理
102800*****************************************************************
102900 230-SYOH                    SECTION.
103000*
103100     MOVE    2             TO  SPA-GMN-SYORI
103200*
103300*    PERFORM 500-GMNHEN-SEC
103600*
103700*    MOVE    "CURRENT"           TO  MCP-PUTTYPE.
103800*    MOVE    "J03    "           TO  MCP-WINDOW.
103900*
104000*    PERFORM 900-PUT-WINDOW.
104100     .
104200 230-SYOH-EXT.
104300     EXIT.
104400*****************************************************************
104500*    処置　処理
104600*****************************************************************
104700 240-SYOC                    SECTION.
104800*
104900     MOVE    3             TO  SPA-GMN-SYORI
105000*
105100*    PERFORM 500-GMNHEN-SEC
105400*
105500*    MOVE    "CURRENT"           TO  MCP-PUTTYPE.
105600*    MOVE    "J03    "           TO  MCP-WINDOW.
105700*
105800*    PERFORM 900-PUT-WINDOW.
105900     .
106000 240-SYOC-EXT.
106100     EXIT.
106200*****************************************************************
106300*    検査　処理
106400*****************************************************************
106500 250-KENS                    SECTION.
106600*
106700     MOVE    4             TO  SPA-GMN-SYORI
106800*
106900*    PERFORM 500-GMNHEN-SEC
107200*
107300*    MOVE    "CURRENT"           TO  MCP-PUTTYPE.
107400*    MOVE    "J03    "           TO  MCP-WINDOW.
107500*
107600*    PERFORM 900-PUT-WINDOW.
107700     .
107800 250-KENS-EXT.
107900     EXIT.
108000*****************************************************************
108100*    Ｘ線　処理
108200*****************************************************************
108300 260-XSEN                    SECTION.
108400*
108500     MOVE    5             TO  SPA-GMN-SYORI
108600*
108700*    PERFORM 500-GMNHEN-SEC
109000*
109100*    MOVE    "CURRENT"           TO  MCP-PUTTYPE.
109200*    MOVE    "J03    "           TO  MCP-WINDOW.
109300*
109400*    PERFORM 900-PUT-WINDOW.
109500     .
109600 260-XSEN-EXT.
109700     EXIT.
109800*****************************************************************
109900*    リハビリ　処理
110000*****************************************************************
110100 270-RIHA                    SECTION.
110200*
110300     MOVE    6             TO  SPA-GMN-SYORI
110400*
110500*    PERFORM 500-GMNHEN-SEC
110800*
110900*    MOVE    "CURRENT"           TO  MCP-PUTTYPE.
111000*    MOVE    "J03    "           TO  MCP-WINDOW.
111100*
111200*    PERFORM 900-PUT-WINDOW.
111300     .
111400 270-RIHA-EXT.
111500     EXIT.
111600*****************************************************************
111700*    自画面編集処理
111800*****************************************************************
111900 500-SET-SCREEN              SECTION.
112000*
112100     PERFORM 500-GMNHEN-SEC
      *
      *D   IF      SPA-ERRCD       NOT =   SPACE
      *D       PERFORM 510-ERRSET-SEC
      *D       GO      TO      500-SET-SCREEN-EXT
      *D   END-IF
112400*
112500     MOVE    "CURRENT"           TO  MCP-PUTTYPE.
112600     MOVE    "J03    "           TO  MCP-WINDOW.
112700*
112800     PERFORM 900-PUT-WINDOW.
112900     .
113000 500-SET-SCREEN-EXT.
113100     EXIT.
113200*
113300*****************************************************************
113400*    エラーメッセージ表示理
113500*****************************************************************
113600 510-ERRSET-SEC              SECTION.
113700*
113800     EVALUATE    SPA-ERRCD
113900         WHEN    "0001"
114000             MOVE    "入力エラー"
114100                                 TO  SPA-ERRMSG
114200         WHEN    OTHER
114300             MOVE    SPA-ERRCD
114400                                 TO  SPA-ERRMSG
114500     END-EVALUATE
      *
           MOVE    SPACE               TO  JERR
           MOVE    SPA-ERRCD           TO  JERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  JERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "J03"               TO  SPA-MOTOPG
           MOVE    "JERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "JERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
114600     .
114700 510-ERRSET-EXT.
114800     EXIT.
114900*****************************************************************
115000*    点数マスター読込
115100*****************************************************************
115200 910-TENSU-READ-SEC         SECTION.
115300*
115400     MOVE    ZERO                TO  TNS-YUKOSTYMD
115500     MOVE    ALL "9"             TO  TNS-YUKOEDYMD
115600*
115700     MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
115800     MOVE    "DBSELECT"          TO  MCP-FUNC
115900     MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           MOVE    WRK-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
116300     IF      MCP-RC              =   ZERO
116400         MOVE    "DBFETCH"           TO  MCP-FUNC
116500         MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
116900         IF      MCP-RC              =   ZERO
117000             MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
117100             MOVE    ZERO                TO  FLG-TENSU
117200         ELSE
117300             INITIALIZE                  TNS-TENSU-REC
117400             MOVE    1                   TO  FLG-TENSU
117500         END-IF
117600     ELSE
117700         INITIALIZE                  TNS-TENSU-REC
117800         MOVE    1                   TO  FLG-TENSU
117900     END-IF
118000*
118100     MOVE    "DBCLOSE"           TO  MCP-FUNC
118200     MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
118600*
118700     .
118800 910-TENSU-READ-EXT.
118900     EXIT.
119000*
119100*****************************************************************
119200*    診療会計マスタＦＥＴＣＨ読込
119300*****************************************************************
119400 900-SRYACCT-NEXT-SEC         SECTION.
119500*
119600     MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
120000     IF      MCP-RC              =   ZERO
120100         MOVE    MCPDATA-REC         TO  SRYACCT-REC
120200         MOVE    ZERO                TO  FLG-SRYACCT
120300     ELSE
120400         INITIALIZE                      SRYACCT-REC
120500         MOVE    1                   TO  FLG-SRYACCT
120600     END-IF
120700*
120800     .
120900 900-SRYACCT-NEXT-EXT.
121000     EXIT.
121100*****************************************************************
121200*    診療行為マスター読込
121300*****************************************************************
121400 930-SINKOUI-RAED-SEC        SECTION.
121500*
121600     MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
122000     IF      MCP-RC              =   ZERO
122100         MOVE    MCPDATA-REC         TO  SRYACT-REC
122200         MOVE    ZERO                TO  FLG-SRYACT
122300     ELSE
122400         INITIALIZE                      SRYACT-REC
122500         MOVE    1                   TO  FLG-SRYACT
122600     END-IF
122700*
122800     .
122900 930-SINKOUI-RAED-EXT.
123000     EXIT.
126400*****************************************************************
126500*    ＰＵＴ　処理
126600*****************************************************************
126700 900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
127300     .
127400 900-PUT-WINDOW-EXT.
127500     EXIT.
127600*
