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
       PROGRAM-ID.                 ORCSC95.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為入力
      *  コンポーネント名  : 初期ＳＰＡ編集処理(K01,K02で使用）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/08/03    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   02/04/10  労災追加
      *  01.00.02    NACL-多々納  02/08/06  アフターケア用追加
      *  01.00.03    NACL-多々納  02/09/11  自賠責追加
      *  01.00.04    NACL−多々納 02/10/10  外来管理加算チェックの有無
      *  01.00.05    NACL−多々納 02/10/18  入院追加
      *****************************************************************
      *
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメタデータ
           SELECT  PARA-FILE       ASSIGN  FILE-NAME2
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    パラメタデータ
       FD  PARA-FILE.
       01  PARA-REC.
           03  PARA-KEY.
               05  PARA-FILEMEI         PIC X(08).
               05  PARA-EDABAN          PIC 9(03).
           03  PARA-DATA-REC            PIC X(5000).
      *
       WORKING-STORAGE             SECTION.
      *
      *    パラメタファイル名
       01  FILE-NAME2.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(09)   VALUE   "K01PARA".
           03  FILE-TERMID2        PIC X(32)   VALUE   SPACE.
           03  FILLER              PIC X(06)   VALUE   ".TXT".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-WKSRYACT        PIC 9(01).
           03  FLG-HKNMST          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-PTCOM           PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-UKETUKE         PIC 9(01).
           03  FLG-SRYKARRK        PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-PTBYOMEI        PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-PTRSIINF        PIC 9(01).
      *
           03  FLG-SYSKANRIOK      PIC 9(01).
           03  FLG-HKNCOMBICHK     PIC 9(01).
           03  FLG-WKSYORI         PIC 9(01).
           03  FLG-SYORI           PIC 9(01).
      *
           03  FLG-DRCDOK          PIC 9(01).
           03  FLG-NO              PIC 9(01).
      *
           03  FLG-JIKAN           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX-W               PIC 9(04).
           03  IDX-KAI             PIC 9(04).
           03  IDX-STR             PIC 9(02).
           03  IDX-R               PIC 9(04).
           03  IDXS                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX-SRY             PIC 9(04).
           03  IDX-TEI             PIC 9(04).
           03  IDX-HKN             PIC 9(04).
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
      *
           03  WRK-DRCD            PIC X(05).
           03  WRK-SRYKA           PIC X(02).
           03  WRK-SRYKAMEI        PIC X(20).
      *
           03  WRK-SRYYYMM         PIC X(06).
           03  WRK-HKNCOMBI        PIC X(100).
           03  WRK-HKNKBN-MEI      PIC X(02).
      *
           03  WRK-ZAINUM          PIC 9(08).
           03  WRK-ZAIKAISU        PIC 9(08).
           03  WRK-EDABAN          PIC 9(02).
      *剤番号
           03  WRK-ZAINUM-TBL.
               05  WRK-ZAINUM-G        OCCURS   50.
                   07  WRK-TZAINUM         PIC  9(08)
                                            OCCURS 15.
           03  WRK-RRK-SRYYMD          PIC  X(08).
           03  WRK-RRK-DENPNUM         PIC  9(07).
      *  診療履歴保存
           03  WRK-CONTKBN-AREA.
               05  WRK-CONTKBN-TBL      OCCURS    3.
                   07  WRK-CONTKBN-NUM      PIC X(04).
                   07  WRK-CONTKBN-TEN      PIC X(01).
           03  IDX-JYU                 PIC 9(04).
           03  WRK-IDX                 PIC 9(04).
      *    初診料算定チェック
           03  FLG-TENKI               PIC 9(01).
           03  FLG-CHIYU               PIC 9(01).
           03  WRK-TENKIYMD            PIC X(08).
      *    剤点数　集計
           03  WRK-ZAITENKEI           PIC 9(11).
      *
           03  WRK-PATH            PIC X(64).
      *
           03  WRK-ZZ9             PIC ZZZ.
      *    未収金
           03  WRK-MISYU           PIC S9(08).
           03  WRK-CHIYUYMD        PIC X(08).
      *    合計点数
           03  WRK-GOK-TENSU       PIC 9(11).
      *
           03  WRK-HEN-SRYCD       PIC X(09).
      *
           03  WRK-JYURRK-REC      PIC X(5000).
      *
      *他科受診科有り
       01  WRK-TAKA-SRYKA-AREA.
           03  WRK-TAKA-SRYKA          PIC  X(02)
                                               OCCURS  10.
      *他保険受診科有り
       01  WRK-TA-HKNCOMBI-AREA.
           03  WRK-TA-HKNCOMBI         PIC  9(04)
                                               OCCURS  10.
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK1006.INC".
      *
           COPY    "CPSK1010.INC".
      *
           COPY    "CPSK1001.INC".
      *
           COPY    "CPSK1007.INC".
      *
           COPY    "CPSK1008.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *    診療行為マスタ−
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    ワーク診療行為マスタ−
       01  WKSRYACT-REC.
           COPY    "CPWKSRYACT.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者コメント
       01  PTCOM-REC.
           COPY    "CPPTCOM.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *    受診履歴
       01  HZN-JYURRK-REC.
           COPY    "CPJYURRK.INC"    REPLACING
                                     //JYURRK-// BY //HZN-JYURRK-//.
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    受付
       01  UKETUKE-REC.
           COPY    "CPUKETUKE.INC".
      *
      *    診療科履歴
       01  SRYKARRK-REC.
           COPY    "CPSRYKARRK.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    患者病名
       01  PTBYOMEI-REC.
           COPY    "CPPTBYOMEI.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *    点数マスタ付加コード
        01 TENSUPLUS-REC.
           COPY    "CPTENSUPLUS.INC".
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    保険年齢・負担割合算定サブ
           COPY    "CPORCSAGECHK.INC".
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
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    診療行為用共通パラメタ
           COPY    "K01COMMON-SPA".
      *
      *    診療行為入力 共通画面ＳＰＡ
           COPY    "K02SCR-SPA".
      *
      *    初期ＳＰＡ編集処理パラメタ
           COPY    "CPORCSC95.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           ORCSC95AREA
           SPA-AREA
           SPA-K01KYOUTU
           SPA-K02
           .
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
           EVALUATE    LNK-SC95-KBN
      *        共通ＳＰＡ編集（外来）
               WHEN    "1"
                   PERFORM 100-K01KYOUTU-SEC
      *        共通ＳＰＡ編集（入院）
               WHEN    "9"
                   PERFORM 900-K01KYOUTU-SEC
      *        共通ＳＰＡ編集、ワーク診療行為作成
               WHEN    "2"
      *********WHEN    "5"
               WHEN    "8"
                   IF      LNK-SC95-PG     =   "K02"
      *                患者の確定している時、患者情報のセット
                       PERFORM 1001-SPA-JYUSIN-SEC
                   END-IF
                   PERFORM 110-K02SYOSIN-SEC
                   PERFORM 200-WKSRYACT-SYORI-SEC
      *        入院のＳＰＡ編集、ワーク診療行為作成
               WHEN    "5"
                   PERFORM 500-NYUIN-SPASET-SEC
      *        ワーク診療行為作成
               WHEN    "3"
                   PERFORM 200-WKSRYACT-SYORI-SEC
      *        訂正時ワーク診療行為作成
               WHEN    "4"
                   PERFORM 300-WKSRYACT-SYORI-SEC
               WHEN    "6"
      *           未収金額編集
                   PERFORM 49011-MISYU-HEN-SEC
      *        保険区分変更時
               WHEN    "7"
      *            保険組合せが使用できるかのチェック
                   PERFORM 100131-HKNCOMBI-CHK-SEC
      *********    IF      SPA-SYORIFLG        =   ZERO
                       PERFORM 200-WKSRYACT-SYORI-SEC
      ***********  END-IF
           END-EVALUATE
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    共通ＳＰＡ編集処理
      *****************************************************************
       100-K01KYOUTU-SEC            SECTION.
      *
           INITIALIZE                  SPA-K01KYOUTU
      *
      *    診療日
           MOVE    LNK-SC95-SRYYMDG    TO  SPA-SRYYMDW
           MOVE    LNK-SC95-SRYYMD     TO  SPA-SRYYMD
      *
      *    システム管理検索（医療機関情報）
           MOVE    SPACE               TO  SYS-1001-REC
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1001-REC
               INITIALIZE                  SYS-1001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
      *
      *        院外処方せん発行フラグ
               MOVE    SYS-1001-SYOHOPRTFLG    TO  SPA-SYOHOPRTFLG
      *        前回処方表示フラグ
               MOVE    SYS-1001-ZENSYOHOFLG    TO  SPA-ZENSYOHOFLG
      *        処方区分
               MOVE    SYS-1001-SYOHOKBN       TO  SPA-SYOHOKBN
      ******** 病床数
      *********MOVE    SYS-1001-BEDSU          TO  SPA-BEDSU
      *        薬剤情報発行フラグ
               MOVE    SYS-1001-YAKUJYOPRTFLG  TO  SPA-YAKJYOPRTFLG
               IF      SYS-1001-YAKUJYOPRTFLG  =   SPACE
                   MOVE    ZERO                TO  SPA-YAKJYOPRTFLG
               END-IF
           END-IF
      *
      *
      *    システム管理検索（チェック機能制御情報）
           MOVE    SPACE               TO  SYS-1008-REC
           INITIALIZE                  SYS-1008-REC
           MOVE    "1008"              TO  SYS-1008-KANRICD
           MOVE    "*"                 TO  SYS-1008-KBNCD
           MOVE    SYS-1008-REC        TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1008-REC
               INITIALIZE                  SYS-1008-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1008-REC
      *
      *        相互作用チェック期間
               MOVE    SYS-1008-INTERACT-KIKAN TO  SPA-INTERACT-KIKAN
      *
      *        外来管理加算チェック
               MOVE    SYS-1008-GAIKANRIKBN-CHK
                                           TO  SPA-GAIKANRIKBN-CHK
      *        初期は、チェックありとする
               IF      SYS-1008-GAIKANRIKBN-CHK    =   SPACE
                   MOVE    "1"             TO  SPA-GAIKANRIKBN-CHK
               END-IF
           ELSE
               MOVE    ZERO                    TO  SPA-INTERACT-KIKAN
           END-IF
      *
      *    診療科
           MOVE    SPACE               TO  SYS-KEY
           MOVE    SPACE               TO  SYS-1005-REC
           INITIALIZE                  SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    ZERO                TO  SYS-1005-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1005-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1005-REC
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       (IDX            >   10   )  OR
                               (FLG-SYSKANRI   =   1    )
               MOVE    MCPDATA-REC           TO  SYS-1005-REC
               MOVE    SYS-1005-KBNCD (1:2)  TO  SPA-GMN-SRYKAL   (IDX)
               MOVE    SYS-1005-SRYKANAME1   TO  SPA-GMN-SRYKAMEIL(IDX)
               MOVE    IDX                   TO  SPA-SRYKA-MAX
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           END-PERFORM
      *    カーソルクロース
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    入外区分
           MOVE    "2"                 TO  SPA-NYUGAIKBN
      *    分散
           MOVE    "0"                 TO  SPA-BUNSAN
      *    院外処方区分
           MOVE    SPA-SYOHOKBN        TO  SPA-INGAIKBN
      *
      *    小児科外来診療科編集
           MOVE    SPACE               TO  SYS-1006-REC
           INITIALIZE                      SYS-1006-REC
           MOVE    "1006"              TO  SYS-1006-KANRICD
           MOVE    "1"                 TO  SYS-1006-KBNCD
           MOVE    ZERO                TO  SYS-1006-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1006-EDYUKYMD
      *    システム管理検索（施設基準）
           MOVE    SYS-1006-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1006-REC
               INITIALIZE                  SYS-1006-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1006-REC
               IF      SYS-1006-SSTKIJUN (121) =   1
                   MOVE    1               TO  SPA-SYONIKA
               END-IF
      *
               IF      SYS-1006-SSTKIJUN (128) =   1
                   MOVE    1               TO  SPA-ROUMANSEI
               END-IF
      *        時間外特例医療機関
               IF      SYS-1006-SSTKIJUN (011) =   1
                   MOVE    1               TO  SPA-JIKANTOKU
               END-IF
      *
           END-IF
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    システム管理検索（施設基準）
           MOVE    SPACE               TO  SYS-1007-REC
           INITIALIZE                  SYS-1007-REC
           MOVE    "1007"              TO  SYS-1007-KANRICD
           MOVE    "*"                 TO  SYS-1007-KBNCD
           MOVE    SYS-1007-REC        TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1007-REC
               INITIALIZE                  SYS-1007-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1007-REC
      *
               MOVE    SYS-1007-SANTEI (1:1)   TO  SPA-CHOKI-FLG
               MOVE    SYS-1007-SANTEI (2:1)   TO  SPA-YAKJYO-1
               MOVE    SYS-1007-SANTEI (3:1)   TO  SPA-YAKJYO-2
               MOVE    SYS-1007-SANTEI (4:1)   TO  SPA-YAKJYO-3
      *        療養担当手当
               MOVE    SYS-1007-SANTEI (5:1)   TO  SPA-RYOYOU-FLG
           END-IF
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *
           .
       100-K01KYOUTU-EXT.
           EXIT.
      *
      *****************************************************************
      *    共通ＳＰＡ編集処理（入院）
      *****************************************************************
       900-K01KYOUTU-SEC            SECTION.
      *
           INITIALIZE                  SPA-K01KYOUTU
      *
      *    診療日
           MOVE    LNK-SC95-SRYYMDG    TO  SPA-SRYYMDW
           MOVE    LNK-SC95-SRYYMD     TO  SPA-SRYYMD
      *
      *    システム管理検索（医療機関情報）
           MOVE    SPACE               TO  SYS-1001-REC
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1001-REC
               INITIALIZE                  SYS-1001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
      *
      *        院外処方せん発行フラグ
               MOVE    SYS-1001-SYOHOPRTFLG    TO  SPA-SYOHOPRTFLG
      *        前回処方表示フラグ（しないとする）
      *********MOVE    SYS-1001-ZENSYOHOFLG    TO  SPA-ZENSYOHOFLG
               MOVE    "1"                     TO  SPA-ZENSYOHOFLG
      *        処方区分（すべて院内とする）
      *********MOVE    SYS-1001-SYOHOKBN       TO  SPA-SYOHOKBN
               MOVE    "0"                     TO  SPA-SYOHOKBN
      *        病床数
      *********MOVE    SYS-1001-BEDSU          TO  SPA-BEDSU
      *        薬剤情報発行フラグ
               MOVE    SYS-1001-YAKUJYOPRTFLG  TO  SPA-YAKJYOPRTFLG
               IF      SYS-1001-YAKUJYOPRTFLG  =   SPACE
                   MOVE    ZERO                TO  SPA-YAKJYOPRTFLG
               END-IF
           END-IF
      *
      *
      *    システム管理検索（チェック機能制御情報）
           MOVE    SPACE               TO  SYS-1008-REC
           INITIALIZE                  SYS-1008-REC
           MOVE    "1008"              TO  SYS-1008-KANRICD
           MOVE    "*"                 TO  SYS-1008-KBNCD
           MOVE    SYS-1008-REC        TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1008-REC
               INITIALIZE                  SYS-1008-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1008-REC
      *
      *        相互作用チェック期間
               MOVE    SYS-1008-INTERACT-KIKAN TO  SPA-INTERACT-KIKAN
      *
      *        外来管理加算チェック
               MOVE    SYS-1008-GAIKANRIKBN-CHK
                                           TO  SPA-GAIKANRIKBN-CHK
      *        初期は、チェックありとする
               IF      SYS-1008-GAIKANRIKBN-CHK    =   SPACE
                   MOVE    "1"             TO  SPA-GAIKANRIKBN-CHK
               END-IF
           ELSE
               MOVE    ZERO                    TO  SPA-INTERACT-KIKAN
           END-IF
      *
      *    診療科
           MOVE    SPACE               TO  SYS-KEY
           MOVE    SPACE               TO  SYS-1005-REC
           INITIALIZE                  SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    ZERO                TO  SYS-1005-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1005-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1005-REC
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       (IDX            >   10   )  OR
                               (FLG-SYSKANRI   =   1    )
               MOVE    MCPDATA-REC           TO  SYS-1005-REC
               MOVE    SYS-1005-KBNCD (1:2)  TO  SPA-GMN-SRYKAL   (IDX)
               MOVE    SYS-1005-SRYKANAME1   TO  SPA-GMN-SRYKAMEIL(IDX)
               MOVE    IDX                   TO  SPA-SRYKA-MAX
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           END-PERFORM
      *    カーソルクロース
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    入外区分
           MOVE    "1"                 TO  SPA-NYUGAIKBN
      *    分散
           MOVE    "0"                 TO  SPA-BUNSAN
      *    院外処方区分
           MOVE    SPA-SYOHOKBN        TO  SPA-INGAIKBN
      *
      *    小児科外来診療科編集
           MOVE    SPACE               TO  SYS-1006-REC
           INITIALIZE                      SYS-1006-REC
           MOVE    "1006"              TO  SYS-1006-KANRICD
           MOVE    "1"                 TO  SYS-1006-KBNCD
           MOVE    ZERO                TO  SYS-1006-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1006-EDYUKYMD
      *    システム管理検索（施設基準）
           MOVE    SYS-1006-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1006-REC
               INITIALIZE                  SYS-1006-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1006-REC
               IF      SYS-1006-SSTKIJUN (121) =   1
                   MOVE    1               TO  SPA-SYONIKA
               END-IF
      *
               IF      SYS-1006-SSTKIJUN (128) =   1
                   MOVE    1               TO  SPA-ROUMANSEI
               END-IF
      *        時間外特例医療機関
               IF      SYS-1006-SSTKIJUN (011) =   1
                   MOVE    1               TO  SPA-JIKANTOKU
               END-IF
      *
           END-IF
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    システム管理検索（施設基準）
           MOVE    SPACE               TO  SYS-1007-REC
           INITIALIZE                  SYS-1007-REC
           MOVE    "1007"              TO  SYS-1007-KANRICD
           MOVE    "*"                 TO  SYS-1007-KBNCD
           MOVE    SYS-1007-REC        TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1007-REC
               INITIALIZE                  SYS-1007-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1007-REC
      *
               MOVE    SYS-1007-SANTEI (1:1)   TO  SPA-CHOKI-FLG
               MOVE    SYS-1007-SANTEI (2:1)   TO  SPA-YAKJYO-1
               MOVE    SYS-1007-SANTEI (3:1)   TO  SPA-YAKJYO-2
               MOVE    SYS-1007-SANTEI (4:1)   TO  SPA-YAKJYO-3
           END-IF
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *
           .
       900-K01KYOUTU-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者の受診履歴編集処理
      *****************************************************************
       1001-SPA-JYUSIN-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-HKNCOMBIMEI
           MOVE    SPACE               TO  SPA-FTNRATEMEI
      *
           IF     (SPA-GMN-SRYKA       =   SPACE      ) AND
                  (SPA-SYSYMD          =   SPA-SRYYMD ) AND
                  (SPA-SYORIFLG        =   ZERO       )
      *        受付マスタより、診療科、ドクターの決定
               PERFORM 10014-UKETUKE-CHK-SEC
           END-IF
      *
      *    受診履歴より、診療科等を確定する
           PERFORM 10011-JYURRK-SEC
      *
      *    診療科、ドクター名称編集
           PERFORM 10012-SYSKAN-SEC
      *
      *    保険組合せ名称編集
           PERFORM 10013-HKNCOMBI-SEC
      *
      *    前回患者保存
           MOVE    SPA-PTID            TO  SPA-LAST-PTID
           MOVE    SPA-PTNUM           TO  SPA-LAST-PTNUM
      *
           .
       1001-SPA-JYUSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    受付マスタより、診療科等を確定する
      *****************************************************************
       10014-UKETUKE-CHK-SEC        SECTION.
      *
      *    受付マスタ検索
           MOVE    SPACE               TO  UKETUKE-REC
           INITIALIZE                  UKETUKE-REC
           MOVE    SPA-HOSPID          TO  UKE-HOSPID
           MOVE    SPA-SYSYMD          TO  UKE-UKEYMD
           MOVE    SPA-PTID            TO  UKE-PTID
      *
           MOVE    UKETUKE-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "UKETUKE-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "UKETUKE-KEY2"      TO  ORC-DBPATH
               PERFORM 900-UKETUKE-READ-SEC
           ELSE
               MOVE    SPACE               TO  UKETUKE-REC
               INITIALIZE                  UKETUKE-REC
               MOVE    1                   TO  FLG-UKETUKE
           END-IF
           PERFORM UNTIL  (FLG-UKETUKE     =   1  )
      **********   OR     (SPA-DRCD    NOT =   SPACE )
      *        会計のまだの最初の受付を対象とする
               IF      UKE-KAIKEITIME      =   ZERO
                   MOVE    UKE-SRYKA           TO  SPA-SRYKA
                   MOVE    UKE-DRCD            TO  SPA-DRCD
                   MOVE    1                   TO  FLG-UKETUKE
      *************IF      SPA-SRYKA           =   SPACE
      *                MOVE    UKE-SRYKA           TO  SPA-SRYKA
      *                MOVE    UKE-DRCD            TO  SPA-DRCD
      *                MOVE    1                   TO  FLG-UKETUKE
      *            ELSE
      *                IF      SPA-SRYKA           =   UKE-SRYKA
      *                    MOVE    UKE-DRCD            TO  SPA-DRCD
      *                    MOVE    1                   TO  FLG-UKETUKE
      *                END-IF
      *************END-IF
               END-IF
               IF      FLG-UKETUKE         =   ZERO
                   MOVE    "UKETUKE-KEY2"      TO  ORC-DBPATH
                   PERFORM 900-UKETUKE-READ-SEC
               END-IF
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "UKETUKE-KEY2"      TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
       10014-UKETUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診歴より、診療科等を確定する
      *****************************************************************
       10011-JYURRK-SEC        SECTION.
      *
      *    受診歴を検索する 医療機関、患者ＩＤ，診療科の最終レコードを対象
      *
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-SRYYMD          TO  JYURRK-SRYYMD
           MOVE    SPACE               TO  JYURRK-SRYKA
      *
           MOVE    "JYURRK-KEY10"       TO  WRK-PATH
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               MOVE    SPACE               TO  JYURRK-REC
               INITIALIZE                  JYURRK-REC
               MOVE    1                   TO  FLG-JYURRK
           END-IF
      *
           MOVE    SPACE               TO  WRK-JYURRK-REC
           MOVE    SPACE               TO  HZN-JYURRK-REC
           MOVE    ZERO                TO  IDX-JYU
           MOVE    SPACE               TO  WRK-TAKA-SRYKA-AREA
           MOVE    ZERO                TO  IDX-SRY
           INITIALIZE                      SPA-TA-HKNCOMBI-AREA
           MOVE    ZERO                TO  IDX-HKN
           PERFORM
               UNTIL    FLG-JYURRK         =   1
      *
      *        最後の受診履歴を対象とする（診療日以前のもの）
               IF    ((SPA-SRYKA       NOT =   SPACE  )  AND
                      (SPA-SRYKA           =   JYURRK-SRYKA ) )  OR
                     ( SPA-SRYKA           =   SPACE          )
                   IF      SPA-SRYYMD          >=   JYURRK-SRYYMD
      *                訂正の時、選択した連番 
                       IF     (SPA-SYORIFLG        =   ZERO    )   OR
                             ((SPA-SYORIFLG        =   1          )
                          AND (SPA-RENNUM          =   JYURRK-RENNUM)
                          AND (SPA-DOUJI-RENNUM    =
                                                   JYURRK-DOUJI-RENNUM))
                           MOVE    JYURRK-REC      TO  WRK-JYURRK-REC
                       END-IF
                   END-IF
      *
      *        継続のチェック
                   IF     (SPA-SRYYMD          =   JYURRK-SRYYMD) AND
                          (JYURRK-DOUJI-RENNUM NOT =   ZERO     )
                       PERFORM 100111-CONTKBN-HANTEI-SEC
                   END-IF
               END-IF
      *
      *        診療日の受診内容を保存
               IF      SPA-SRYYMD          =   JYURRK-SRYYMD
                   PERFORM 100111-DOUJI-JYURRK-SEC
               END-IF
      *
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    WRK-PATH            TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    同日再診日のセット
           IF      HZN-JYURRK-SRYYMD   =   SPACE
               MOVE    SPACE               TO  SPA-RRK-LSTYMD
               MOVE    SPACE               TO  SPA-LSTSRYKA
               MOVE    SPACE               TO  SPA-RRK-LSTSRYKA
           ELSE
               MOVE    HZN-JYURRK-SRYYMD   TO  SPA-RRK-LSTYMD
               MOVE    HZN-JYURRK-SRYKA    TO  SPA-LSTSRYKA
               MOVE    HZN-JYURRK-SRYKA    TO  SPA-RRK-LSTSRYKA
           END-IF
      *
           MOVE    WRK-JYURRK-REC      TO  JYURRK-REC
      *
      *    診療科
           IF      SPA-SRYKA           =   SPACE
               MOVE    JYURRK-SRYKA        TO  SPA-SRYKA
           END-IF
      *    同日診療科保存
           MOVE    SPACE               TO  SPA-TAKA-SRYKA-R
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   10   )  OR
                              (WRK-TAKA-SRYKA (IDX)    =   SPACE )
               IF      WRK-TAKA-SRYKA (IDX)    =   SPA-SRYKA
                   CONTINUE
               ELSE
                   PERFORM VARYING     IDX2    FROM    1   BY  1
                           UNTIL       IDX2    >   10
                       IF     (SPA-TAKA-SRYKA(IDX2)    =   SPACE  )  OR
                              (SPA-TAKA-SRYKA(IDX2)    =
                                                   WRK-TAKA-SRYKA(IDX))
                           MOVE    WRK-TAKA-SRYKA (IDX)    TO
                                                   SPA-TAKA-SRYKA (IDX2)
                           MOVE    10              TO  IDX2
                       END-IF
                   END-PERFORM
               END-IF
           END-PERFORM
      *
      *    受診歴なし
           IF      JYURRK-REC          =   SPACE
               GO      TO      10011-JYURRK-EXT
           END-IF
      *    ドクター
           IF      SPA-DRCD            =   SPACE
               MOVE    JYURRK-DRCD         TO  SPA-DRCD
           END-IF
      *    保険組合せ（中途終了分選択時は選択済み）
           IF     (LNK-SC95-KBN        =   "8"  )  OR
                  (SPA-SYORIFLG        =   1    )
               CONTINUE
           ELSE
               MOVE    JYURRK-HKNCOMBINUM  TO  SPA-HKNCOMBINUM
           END-IF
      *
      *    最終受診履歴
           MOVE    JYURRK-RENNUM       TO  LNK-SC95-LAST-RENNUM
      *
           .
       10011-JYURRK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療日の受診内容を保存処理
      *****************************************************************
       100111-DOUJI-JYURRK-SEC        SECTION.
      *
      *    訂正の時、訂正分以前のもの
           IF      (SPA-SYORIFLG        =   1       )  AND
                   (SPA-SRYKA           =   JYURRK-SRYKA ) AND
                   ((SPA-RENNUM          =   JYURRK-RENNUM   AND
                     SPA-DOUJI-RENNUM    =   JYURRK-DOUJI-RENNUM)
                OR  (SPA-RENNUM          <   JYURRK-RENNUM  ))
               CONTINUE
           ELSE
      *
               IF      SPA-SRYKA           =   JYURRK-SRYKA
                   MOVE    JYURRK-REC          TO  HZN-JYURRK-REC
               ELSE
                   IF      HZN-JYURRK-REC      =   SPACE
                       MOVE    JYURRK-REC      TO  HZN-JYURRK-REC
                   END-IF
      *            労災の時、同じ保険であること
                   IF     ((HZN-JYURRK-HKNKBN  =   "1"  OR "2")  AND
                           (HZN-JYURRK-HKNCOMBINUM
                                               =   JYURRK-HKNCOMBINUM))
                       OR ((HZN-JYURRK-HKNKBN   =   ZERO) AND
                           (JYURRK-HKNKBN       =   ZERO))
                       ADD      1              TO  IDX-SRY
                       MOVE    JYURRK-SRYKA    TO  WRK-TAKA-SRYKA
                                                              (IDX-SRY)
                   END-IF
               END-IF
      *        保険組合せ編集
               PERFORM VARYING     IDX-HKN     FROM    1   BY  1
                       UNTIL       IDX-HKN     >   10
                   IF     SPA-TA-HKNCOMBI (IDX-HKN)    =   ZERO
                       MOVE    JYURRK-HKNCOMBINUM
                                               TO  SPA-TA-HKNCOMBI
                                                              (IDX-HKN)
                   END-IF
                   IF      SPA-TA-HKNCOMBI (IDX-HKN)
                                               =   JYURRK-HKNCOMBINUM
                       MOVE    10              TO  IDX-HKN
                   END-IF
               END-PERFORM
           END-IF
           .
       100111-DOUJI-JYURRK-EXT.
           EXIT.
      *
      *****************************************************************
      *    継続区分判定処理
      *****************************************************************
       100111-CONTKBN-HANTEI-SEC        SECTION.
      *
      *    収納テーブル読み込み
           MOVE    SPACE               TO  SYUNOU-REC
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    JYURRK-DENPNUM      TO  SYU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY"       TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYUNOU-REC
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
           IF      FLG-SYUNOU          =   ZERO
      *        伝票状態区分
               IF      SYU-DENPJTIKBN      =   "7"
      *            同時診療伝票番号
                   MOVE    SYU-DOUJI-DENPNUM  TO
                                              LNK-SC95-DOUJI-DENPNUM
      *            受診連番
                   MOVE    JYURRK-DOUJI-RENNUM
                                              TO  LNK-SC95-DOUJI-RENNUM
      *
                   ADD     1                  TO  IDX-JYU
                   MOVE    JYURRK-HKNCOMBINUM TO  LNK-SC95-DOUJI-HKNNUM
                                                             (IDX-JYU)
               END-IF
           END-IF
      *
           .
       100111-CONTKBN-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理より編集処理
      *****************************************************************
       10012-SYSKAN-SEC        SECTION.
      *
      *    診療科
      *    MOVE    SPACE               TO  SYS-1005-REC
      *    INITIALIZE                  SYS-1005-REC
      *    MOVE    "1005"              TO  SYS-1005-KANRICD
      *    MOVE    ZERO                TO  SYS-1005-STYUKYMD
      *    MOVE    ALL "9"             TO  SYS-1005-EDYUKYMD
      *    システム管理検索
      *    MOVE    SYS-1005-REC        TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *    MOVE    SPA-SRYYMD          TO  ORC-DBYMD
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *    IF      MCP-RC              =   ZERO
      *        MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *        PERFORM 900-KANRIMST-READ-SEC
      *    ELSE
      *        MOVE    SPACE               TO  SYS-1005-REC
      *        INITIALIZE                  SYS-1005-REC
      *        MOVE    1               TO  FLG-SYSKANRI
      *    END-IF
      *    MOVE    SPACE               TO  WRK-SRYKA
      *    MOVE    SPACE               TO  WRK-SRYKAMEI
      *    PERFORM
      *        UNTIL   FLG-SYSKANRI        =   1
      *        MOVE    MCPDATA-REC         TO  SYS-1005-REC
      *        IF      WRK-SRYKA           =   SPACE
      *            MOVE    SYS-1005-KBNCD (1:2)    TO  WRK-SRYKA
      *            MOVE    SYS-1005-SRYKANAME1     TO  WRK-SRYKAMEI
      *        END-IF
      *        IF      SPA-SRYKA           =   SPACE
      *            MOVE    SYS-1005-KBNCD (1:2)    TO  SPA-SRYKA
      *        END-IF
      *        IF      SPA-SRYKA           =   SYS-1005-KBNCD (1:2)
      *            MOVE    SYS-1005-SRYKANAME1 TO  SPA-SRYKAMEI
      *            MOVE    1                   TO  FLG-SYSKANRI
      *        END-IF
      *
      *        IF      FLG-SYSKANRI        =   ZERO
      *            MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
      *            PERFORM 900-KANRIMST-READ-SEC
      *        END-IF
      *    END-PERFORM
      *    カーソルクロース
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *****                            MCPDATA-REC
           MOVE    SPACE               TO  SPA-SRYKAMEI
      *    診療科
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX             >   SPA-SRYKA-MAX
               IF      SPA-SRYKA       =   SPA-GMN-SRYKAL   (IDX)
                   MOVE    SPA-GMN-SRYKAMEIL(IDX)  TO  SPA-SRYKAMEI
                   MOVE    SPA-SRYKA-MAX           TO  IDX
               END-IF
           END-PERFORM
      *    前回の診療科がなかった時、最初の診療科
           IF      SPA-SRYKAMEI        =   SPACE
               MOVE    SPA-GMN-SRYKAL(01)      TO  SPA-SRYKA
               MOVE    SPA-GMN-SRYKAMEIL(01)   TO  SPA-SRYKAMEI
           END-IF
      *
      *
      *    職員情報（ドクター）
           MOVE    SPACE               TO  SYS-1010-REC
           INITIALIZE                  SYS-1010-REC
           MOVE    "1010"              TO  SYS-1010-KANRICD
           MOVE    ZERO                TO  SYS-1010-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1010-EDYUKYMD
           MOVE    "1"                 TO  SYS-1010-KBNCD(1:1)
      *    システム管理検索
           MOVE    SYS-1010-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
      *??  MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
      *???     MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-1010-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    SPACE               TO  WRK-DRCD
           MOVE    ZERO                TO  FLG-DRCDOK
           PERFORM
                   UNTIL      (FLG-SYSKANRI    =   1 )  OR
                              (FLG-DRCDOK      =   1 )
               MOVE    MCPDATA-REC             TO  SYS-1010-REC
               IF      SYS-1010-KBNCD(1:1)     =   "1"
                   IF      WRK-DRCD            =   SPACE
                       MOVE    SYS-1010-KBNCD(1:5) TO  WRK-DRCD
                   END-IF
                   IF      SPA-DRCD            =   SPACE
                       MOVE    SYS-1010-KBNCD(1:5) TO  SPA-DRCD
                   END-IF
                   IF      SPA-DRCD            =   SYS-1010-KBNCD(1:5)
                       MOVE    1                   TO  FLG-DRCDOK
                   END-IF
               END-IF
      *
               IF      FLG-DRCDOK      =   ZERO
      *???******   MOVE    "SYSKANRI-KEY2"    TO  ORC-DBPATH
                   MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
                   PERFORM 900-KANRIMST-READ-SEC
               END-IF
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *    前回のドクターがなかった時、最初の診療科
           IF      FLG-DRCDOK          =   ZERO
               MOVE    WRK-DRCD            TO  SPA-DRCD
           END-IF
           .
       10012-SYSKAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       10013-HKNCOMBI-SEC        SECTION.
      *
      *
           INITIALIZE                  SPA-GMN-HKNCOMBI-LISTG
           MOVE    ZERO                TO  FLG-HKNCOMBICHK
      *
      *    保険組合マスター編集
           MOVE    SPACE               TO  HKNCOMBI-REC
           INITIALIZE                  HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-PTID            TO  COMB-PTID
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
               PERFORM 910-HKNCOMBI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
               INITIALIZE                  HKNCOMBI-REC
           END-IF
           PERFORM
                   UNTIL      (FLG-HKNCOMBI        =   1      )  OR
                              (SPA-HKN-MAX         >=  15     )
      *
      *        対象の保険組合せのみ編集
               MOVE    ZERO                TO  FLG-HKNCOMBICHK
               IF      COMB-DELKBN         =   "1"
                   CONTINUE
               ELSE
                   IF      (SPA-SRYYMD         >=  COMB-TEKSTYMD )  AND
                           (SPA-SRYYMD         <=  COMB-TEKEDYMD )
                       MOVE    1                   TO  FLG-HKNCOMBICHK
                   END-IF
               END-IF
      *
                IF      FLG-HKNCOMBICHK    =    1
                   ADD     1                   TO  SPA-HKN-MAX
                   MOVE    COMB-HKNCOMBINUM    TO  SPA-GMN-THKNCOMBINUM
                                                          (SPA-HKN-MAX)
      *
                   MOVE    COMB-HKNID          TO  SPA-NAI-HKNID
                                                          (SPA-HKN-MAX)
                   MOVE    COMB-HKNNUM         TO  SPA-NAI-HKNNUM
                                                          (SPA-HKN-MAX)
                   MOVE    COMB-KOH1HKNNUM     TO  SPA-NAI-KOH1HKNNUM
                                                          (SPA-HKN-MAX)
                   MOVE    COMB-KOH2HKNNUM     TO  SPA-NAI-KOH2HKNNUM 
                                                          (SPA-HKN-MAX)
                   MOVE    COMB-KOH3HKNNUM     TO  SPA-NAI-KOH3HKNNUM
                                                          (SPA-HKN-MAX)
                   MOVE    COMB-KOH4HKNNUM     TO  SPA-NAI-KOH4HKNNUM 
                                                          (SPA-HKN-MAX)
                   MOVE    COMB-GAI-KFTNRATE   TO  SPA-NAI-TFTNRATE
                                                          (SPA-HKN-MAX)
      *
                   IF      COMB-GAI-KFTNRATE   =   ZERO
                       MOVE    SPACE           TO  SPA-GMN-TFTNRATEMEI
                                                          (SPA-HKN-MAX)
                   ELSE
                       MOVE    COMB-GAI-KFTNRATE   TO  WRK-ZZ9
                       MOVE    WRK-ZZ9         TO  SPA-GMN-TFTNRATEMEI
                                                          (SPA-HKN-MAX)
                                                          (1:3)
                       MOVE    "%"             TO  SPA-GMN-TFTNRATEMEI
                                                          (SPA-HKN-MAX)
                                                          (4:)
                   END-IF
      *
                   PERFORM 1001311-HKNCOMBI-HEN-SEC
                   MOVE    WRK-HKNCOMBI        TO  SPA-GMN-THKNCOMBIMEI
                                                          (SPA-HKN-MAX)
               END-IF
      *
               MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
               PERFORM 910-HKNCOMBI-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    保険組合せが使用できるかのチェック
           PERFORM 100131-HKNCOMBI-CHK-SEC
      *
           .
       10013-HKNCOMBI-EXT.
      *
           EXIT.
      *
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       100131-HKNCOMBI-CHK-SEC             SECTION.
      *
      *    前回の保険組合せが使用できるかのチェック
           MOVE    ZERO                TO  FLG-HKNCOMBICHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-HKN-MAX
               IF      SPA-HKNCOMBINUM     =   SPA-GMN-THKNCOMBINUM
                                                         (IDX)
                   MOVE    1               TO  FLG-HKNCOMBICHK
      *
                   MOVE    SPA-GMN-HKN-LIST (IDX)
                                           TO  SPA-GMN-HKNCOMBI-G
                   MOVE    SPA-GMN-TFTNRATEMEI (IDX)
                                           TO  SPA-GMN-FTNRATEMEI
      *            労災判定
                   IF      SPA-NAI-HKNNUM (IDX)    =   "971"
                                                   OR  "973"
                       MOVE    1                   TO  SPA-HKNKBN
                   ELSE
                       MOVE    ZERO                TO  SPA-HKNKBN
                   END-IF
                   MOVE    SPA-NAI-HKNID (IDX)
                                           TO  SPA-HKNID
                   MOVE    SPA-NAI-RSI-HKNKBN (IDX)
                                           TO  SPA-RSI-HKNKBN
               END-IF
           END-PERFORM
      *    前回の保険組合せが使用できない時、１件目
           IF      FLG-HKNCOMBICHK     =   ZERO
               MOVE    SPA-GMN-THKNCOMBINUM (01)
                                           TO  SPA-HKNCOMBINUM
      *
               MOVE    SPA-GMN-HKN-LIST (01)
                                           TO  SPA-GMN-HKNCOMBI-G
               MOVE    SPA-GMN-TFTNRATEMEI (01)
                                           TO  SPA-GMN-FTNRATEMEI
      *        労災判定
               IF      SPA-NAI-HKNNUM (01)     =   "971"
                                               OR  "973"
                   MOVE    1                   TO  SPA-HKNKBN
               ELSE
                   MOVE    ZERO                TO  SPA-HKNKBN
               END-IF
               MOVE    SPA-NAI-HKNID (01)  TO  SPA-HKNID
               MOVE    SPA-NAI-RSI-HKNKBN (01)
                                           TO  SPA-RSI-HKNKBN
           END-IF
      *
      *    保険算定年齢チェック等
           INITIALIZE                  ORCSAGECHKAREA
           MOVE    SPA-HOSPID          TO  AGECHK-HOSPID
           MOVE    SPA-PTID            TO  AGECHK-PTID
           MOVE    SPA-SRYYMD          TO  AGECHK-SRYYMD
      **** MOVE    SPA-BIRTHDAY        TO  AGECHK-BIRTHDAY
           MOVE    SPA-HKNCOMBINUM     TO  AGECHK-HKNCOMBINUM
           CALL    "ORCSAGECHK"        USING
                                       ORCSAGECHKAREA
           IF      AGECHK-FTNRATE  NOT =   ZERO
      *        負担率
               MOVE    AGECHK-FTNRATEMEI   TO  SPA-GMN-FTNRATEMEI
               MOVE    AGECHK-FTNRATEMEI   TO  SPA-FTNRATEMEI
               MOVE    AGECHK-FTNRATE      TO  SPA-GMN-FTNRATE
               MOVE    AGECHK-FTNRATE      TO  SPA-FTNRATE
           END-IF
           MOVE    ZERO                TO  SPA-RJN-ERR
      *
      *    老人でＨ１４．１０の保険変更がない時
           IF      AGECHK-RJNCHK       =   1
               MOVE    "1027"              TO  SPA-ERRCD
               MOVE    1                   TO  SPA-RJN-ERR
           END-IF
      *
      *    老人でＨ１４．１０の保険変更がない時
           IF      AGECHK-RJNCHK       =   2
               MOVE    1                   TO  SPA-NAI-ROUFLG
           END-IF
      *
           .
       100131-HKNCOMBI-CHK-EXT.
      *
           EXIT.
      *
      *****************************************************************
      *    保険組合せ名称編集処理
      *****************************************************************
       1001311-HKNCOMBI-HEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNCOMBI
      *
           STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                   " "                     DELIMITED  BY  SIZE
                   COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBI
           END-STRING
      *    主保険がない時
           IF      COMB-SYU-TANSEIDONAME   =   SPACE
               MOVE    SPACE               TO  WRK-HKNCOMBI
               STRING  COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                     DELIMITED  BY  SIZE
                       COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                     DELIMITED  BY  SIZE
                       COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                     DELIMITED  BY  SIZE
                       COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBI
               END-STRING
           END-IF
      *
      *    労災の時、コメントの追加
           IF      COMB-HKNNUM         =   "971"  OR  "973"
      *        患者保険情報検索
               INITIALIZE                      PTRSIINF-REC
               MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
               MOVE    SPA-PTID            TO  PTRSI-PTID
               MOVE    COMB-HKNID          TO  PTRSI-HKNID
               MOVE    PTRSIINF-REC        TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "PTRSIINF-KEY"     TO  ORC-DBPATH
                   PERFORM 993-PTRSIINF-NEXT-SEC
               ELSE
                   INITIALIZE                      PTRSIINF-REC
                   MOVE    1                   TO  FLG-PTRSIINF
               END-IF
               MOVE    SPACE               TO  WRK-HKNKBN-MEI
               EVALUATE    PTRSI-HKNKBN
                   WHEN    "1"
                       MOVE    "短"        TO  WRK-HKNKBN-MEI
                   WHEN    "2"
                       MOVE    "傷"        TO  WRK-HKNKBN-MEI
                   WHEN    "3"
                       MOVE    "ア"        TO  WRK-HKNKBN-MEI
               END-EVALUATE
               IF      PTRSI-COMMENT       =   SPACE
                   MOVE    SPACE               TO  WRK-HKNCOMBI
                   STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                           " "                     DELIMITED  BY  SIZE
                           WRK-HKNKBN-MEI          DELIMITED  BY  SPACE
                           INTO              WRK-HKNCOMBI
                   END-STRING
               ELSE
                   MOVE    SPACE               TO  WRK-HKNCOMBI
                   STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                           " "                     DELIMITED  BY  SIZE
                           WRK-HKNKBN-MEI          DELIMITED  BY  SPACE
                           "（"                    DELIMITED  BY  SIZE
                           PTRSI-COMMENT           DELIMITED  BY  SPACE
                           "）"                    DELIMITED  BY  SIZE
                           INTO              WRK-HKNCOMBI
                   END-STRING
               END-IF
      *
      *        四肢区分
               MOVE    PTRSI-SISIKBN       TO  SPA-NAI-RSI-SISIKBN
                                                          (SPA-HKN-MAX)
      *        傷病年月日
               IF      PTRSI-HKNKBN        =   "1"  OR  "2"  OR  "4"
                   MOVE    PTRSI-SHOBYOYMD     TO  SPA-NAI-RSI-SHOBYOYMD
                                                          (SPA-HKN-MAX)
               ELSE
                   MOVE    PTRSI-SINSATUYMD    TO  SPA-NAI-RSI-SHOBYOYMD
                                                          (SPA-HKN-MAX)
               END-IF
      *        労災区分
               MOVE    PTRSI-HKNKBN        TO  SPA-NAI-RSI-HKNKBN
                                                          (SPA-HKN-MAX)
           END-IF
           .
       1001311-HKNCOMBI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｋ０２初画面用編集処理
      *****************************************************************
       110-K02SYOSIN-SEC              SECTION.
      *
      *    患者マスター読み込み
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-PTID            TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           =   1
               INITIALIZE                  SPA-KYOTUKEY
               MOVE    SPA-GMN-PTNUM       TO  SPA-PTNUM
               MOVE    SPA-GMN-PTID        TO  SPA-PTID
               INITIALIZE                  SPA-K02-AREA
               MOVE    SPA-PTNUM           TO  SPA-GMN-PTNUM
               MOVE    SPA-PTID            TO  SPA-GMN-PTID
               MOVE    SPA-SYSYMD          TO  SPA-SRYYMD
               MOVE    SPA-SYSYMDWH        TO  SPA-SRYYMDW
               MOVE    SPA-SRYYMDW         TO  SPA-GMN-SRYYMD
               MOVE    SPA-SRYYMD          TO  SPA-NAI-SRYYMD
               GO      TO      110-K02SYOSIN-EXT
           END-IF
           MOVE    PTINF-KANANAME      TO  SPA-KANANAME
           MOVE    PTINF-NAME          TO  SPA-NAME
           EVALUATE    PTINF-SEX
               WHEN    "1"
                   MOVE    "男"                TO  SPA-SEX
               WHEN    "2"
                   MOVE    "女"                TO  SPA-SEX
           END-EVALUATE
      *
           MOVE    PTINF-BIRTHDAY      TO  SPA-BIRTHDAY
           MOVE    PTINF-BIRTHDAY      TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-BIRTHDAYW
      *
      *    初診日、最終診察日
           MOVE    SPACE               TO  SPA-SYOYMD 
           MOVE    SPACE               TO  SPA-LSTYMD 
           PERFORM 1101-HKN-SYOYMD-SET-SEC
      *
      *    最終算定診療科
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX             >   SPA-SRYKA-MAX
               IF      SPA-LSTSRYKA        =   SPA-GMN-SRYKAL   (IDX)
                   MOVE    SPA-GMN-SRYKAMEIL(IDX)  TO  SPA-LSTSRYKAMEI
                   MOVE    SPA-SRYKA-MAX           TO  IDX
               END-IF
           END-PERFORM
      *    禁忌情報設定
           PERFORM 401011-TABOO-SET-SEC
      *
      *    未収金額編集
           PERFORM 49011-MISYU-HEN-SEC
      *
      *    特定疾患の有無検索
           PERFORM 11011-TOKUTEI-SYORI-SEC
      *
      *    診療月の累計点数編集
      *****PERFORM 49012-ZAITENTOTAL-SEC
      *
           .
       110-K02SYOSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    禁忌情報設定処理
      *****************************************************************
       401011-TABOO-SET-SEC         SECTION.
      *
           INITIALIZE                  SPA-GMN-TABOO-TBL
           MOVE    ZERO                TO  IDX
      *    禁忌１
           IF      PTINF-TABOO-1   NOT =   SPACE
                ADD     1                  TO  IDX
                MOVE    "禁忌："           TO  SPA-GMN-TABOO (IDX)
                MOVE    PTINF-TABOO-1      TO  SPA-GMN-TABOO (IDX)
                                                             (7:50)
                IF      PTINF-TABOO-1(51:62)   NOT =   SPACE
                    ADD     1                  TO  IDX
                    MOVE    PTINF-TABOO-1(51:62)
                                               TO  SPA-GMN-TABOO (IDX)
                END-IF
                IF      PTINF-TABOO-1(113:62)  NOT =   SPACE
                    ADD     1                  TO  IDX
                    MOVE    PTINF-TABOO-1(113:62)
                                               TO  SPA-GMN-TABOO (IDX)
                END-IF
                IF      PTINF-TABOO-1(175:)    NOT =   SPACE
                    ADD     1                  TO  IDX
                    MOVE    PTINF-TABOO-1(175:)
                                               TO  SPA-GMN-TABOO (IDX)
                END-IF
           END-IF
      *    禁忌２
           IF      PTINF-TABOO-2   NOT =   SPACE
               ADD     1                  TO  IDX
               MOVE    PTINF-TABOO-2      TO  SPA-GMN-TABOO (IDX)
               IF      PTINF-TABOO-2(63:)     NOT =   SPACE
                   ADD     1                  TO  IDX
                   MOVE    PTINF-TABOO-2(63:)
                                               TO  SPA-GMN-TABOO (IDX)
               END-IF
               IF      PTINF-TABOO-2(125:)     NOT =   SPACE
                   ADD     1                   TO  IDX
                   MOVE    PTINF-TABOO-2(125:)
                                               TO  SPA-GMN-TABOO (IDX)
               END-IF
               IF      PTINF-TABOO-2(187:)     NOT =   SPACE
                   ADD     1                   TO  IDX
                   MOVE    PTINF-TABOO-2(187:)
                                               TO  SPA-GMN-TABOO (IDX)
               END-IF
           END-IF
      *    アレルギー１
           IF      PTINF-ALLERGY-1   NOT =   SPACE
                ADD     1                  TO  IDX
                MOVE    "アレルギー："     TO  SPA-GMN-TABOO (IDX)
                MOVE    PTINF-ALLERGY-1    TO  SPA-GMN-TABOO (IDX)
                                                             (13:)
                IF      PTINF-ALLERGY-1(51:)   NOT =   SPACE
                    ADD     1                  TO  IDX
                    MOVE    PTINF-ALLERGY-1(51:) TO  SPA-GMN-TABOO (IDX)
                END-IF
                IF      PTINF-ALLERGY-1(113:)  NOT =   SPACE
                    ADD     1                  TO  IDX
                    MOVE    PTINF-ALLERGY-1(113:)
                                               TO  SPA-GMN-TABOO (IDX)
                END-IF
                IF      PTINF-ALLERGY-1(175:)  NOT =   SPACE
                    ADD     1                  TO  IDX
                    MOVE    PTINF-ALLERGY-1(175:)
                                               TO  SPA-GMN-TABOO (IDX)
                END-IF
           END-IF
      *    アレルギー２
           IF      PTINF-ALLERGY-2 NOT =   SPACE
               ADD     1                   TO  IDX
               MOVE    PTINF-ALLERGY-2     TO  SPA-GMN-TABOO (IDX)
               IF      PTINF-ALLERGY-2(63:)     NOT =   SPACE
                   ADD     1                   TO  IDX
                   MOVE    PTINF-ALLERGY-2(63:)
                                               TO  SPA-GMN-TABOO (IDX)
               END-IF
               IF      PTINF-ALLERGY-2(125:)   NOT =   SPACE
                   ADD     1                   TO  IDX
                   MOVE    PTINF-ALLERGY-2(125:)
                                               TO  SPA-GMN-TABOO (IDX)
               END-IF
               IF      PTINF-ALLERGY-2(187:)   NOT =   SPACE
                   ADD     1                   TO  IDX
                   MOVE    PTINF-ALLERGY-2(187:)
                                               TO  SPA-GMN-TABOO (IDX)
               END-IF
           END-IF
      *    感染症１
           IF      PTINF-KANSENSYO-1   NOT =   SPACE
                ADD     1                  TO  IDX
                MOVE    "感染症："         TO  SPA-GMN-TABOO (IDX)
                MOVE    PTINF-KANSENSYO-1  TO  SPA-GMN-TABOO (IDX)
                                                             (9:)
                IF      PTINF-KANSENSYO-1(55:) NOT =   SPACE
                    ADD     1                  TO  IDX
                    MOVE    PTINF-KANSENSYO-1(55:)
                                               TO  SPA-GMN-TABOO (IDX)
                END-IF
                IF      PTINF-KANSENSYO-1(117:)    NOT =   SPACE
                    ADD     1                  TO  IDX
                    MOVE    PTINF-KANSENSYO-1(117:)
                                               TO  SPA-GMN-TABOO (IDX)
                END-IF
                IF      PTINF-KANSENSYO-1(178:)    NOT =   SPACE
                    ADD     1                  TO  IDX
                    MOVE    PTINF-KANSENSYO-1(178:)
                                               TO  SPA-GMN-TABOO (IDX)
                END-IF
           END-IF
      *    感染症２
           IF      PTINF-KANSENSYO-2   NOT =   SPACE
               ADD     1                   TO  IDX
               MOVE    PTINF-KANSENSYO-2   TO  SPA-GMN-TABOO (IDX)
               IF      PTINF-KANSENSYO-2(63:)  NOT =   SPACE
                   ADD     1                   TO  IDX
                   MOVE    PTINF-KANSENSYO-2(63:)
                                               TO  SPA-GMN-TABOO (IDX)
               END-IF
               IF      PTINF-KANSENSYO-2(125:) NOT =   SPACE
                   ADD     1                   TO  IDX
                   MOVE    PTINF-KANSENSYO-2(125:)
                                               TO  SPA-GMN-TABOO (IDX)
               END-IF
               IF      PTINF-KANSENSYO-2(187:) NOT =   SPACE
                   ADD     1                   TO  IDX
                   MOVE    PTINF-KANSENSYO-2(187:)
                                               TO  SPA-GMN-TABOO (IDX)
               END-IF
           END-IF
           MOVE    IDX                 TO  SPA-TABOO-MAX
      *
           .
       401011-TABOO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険 初診日、最終診察日編集処理
      *****************************************************************
       1101-HKN-SYOYMD-SET-SEC             SECTION.
      *
      *    診療科歴を検索
           MOVE    SPACE               TO  SRYKARRK-REC
           INITIALIZE                  SRYKARRK-REC
           MOVE    SPA-HOSPID          TO  KARRK-HOSPID
           MOVE    SPA-PTID            TO  KARRK-PTID
      *D   MOVE    SPA-SRYKA           TO  KARRK-SRYKA
      *
           MOVE    SRYKARRK-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYKARRK-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYKARRK-KEY2"     TO  ORC-DBPATH
               PERFORM 975-SRYKARRK-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYKARRK
               MOVE    SPACE               TO  SRYKARRK-REC
               INITIALIZE                  SRYKARRK-REC
           END-IF
           PERFORM UNTIL       FLG-SRYKARRK    =   1
      *
               IF      KARRK-SRYKA         =   SPACE
                   CONTINUE
               ELSE
      *
      *        初診算定日
               IF     (KARRK-SYOSINYMD2 NOT =  SPACE      ) AND
                      (KARRK-SYOSINYMD2    >=  SPA-SYOYMD )
                   MOVE    KARRK-SYOSINYMD2    TO  SPA-SYOYMD
               END-IF
      *        最終受診日
               IF     (KARRK-LASTYMD   NOT =   SPACE      ) AND
                      (KARRK-LASTYMD       >=  SPA-LSTYMD )
                   MOVE    KARRK-LASTYMD       TO  SPA-LSTYMD
                   MOVE    KARRK-SRYKA         TO  SPA-LSTSRYKA
               END-IF
      *
               END-IF
      *
               MOVE    "SRYKARRK-KEY2"     TO  ORC-DBPATH
               PERFORM 975-SRYKARRK-READ-SEC
           END-PERFORM
      *
      ***  MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYKARRK-KEY2"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      ****                             MCPDATA-REC
           IF      SPA-RRK-LSTSRYKA    NOT =   SPACE
               MOVE    SPA-RRK-LSTSRYKA    TO  SPA-LSTSRYKA
           END-IF
      *
           MOVE    SPACE               TO  WRK-TENKIYMD
           MOVE    ZERO                TO  FLG-TENKI
           MOVE    ZERO                TO  FLG-CHIYU
      *----(01.00.01) LINE UPD START ----------------------------------
           MOVE    SPACE               TO  WRK-CHIYUYMD
      *----(01.00.01) LINE INS END   ----------------------------------
      *
      *    患者病名検索
           MOVE    SPACE               TO  PTBYOMEI-REC
           INITIALIZE                  PTBYOMEI-REC
           MOVE    SPA-HOSPID          TO  PTBYO-HOSPID
           MOVE    SPA-PTID            TO  PTBYO-PTID
      *
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTBYOMEI-KEY3"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTBYOMEI-KEY3"     TO  ORC-DBPATH
               PERFORM 980-PTBYOMEI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTBYOMEI
               MOVE    SPACE               TO  PTBYOMEI-REC
               INITIALIZE                  PTBYOMEI-REC
           END-IF
           PERFORM UNTIL       FLG-PTBYOMEI    =   1
              IF      PTBYO-SRYYMD        <   SPA-SRYYMD
                   EVALUATE    PTBYO-TENKIKBN
      *                治癒
                       WHEN    "1"
      *****************  IF      PTBYO-TENKIYMD  <=  SPA-SRYYMD
                         IF      PTBYO-TENKIYMD  <   SPA-SRYYMD
                           MOVE    1               TO  FLG-CHIYU
      *----(01.00.01) LINE ADD START ----------------------------------
                           IF      PTBYO-TENKIYMD  >=  WRK-CHIYUYMD
                               MOVE    PTBYO-TENKIYMD  TO  WRK-CHIYUYMD
                           END-IF
                         END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
      *                継続
                       WHEN    " "
                           MOVE    1           TO  FLG-TENKI
      *                中止
                       WHEN    "3"
      ****************** IF      PTBYO-TENKIYMD  <=  SPA-SRYYMD
                         IF      PTBYO-TENKIYMD  <   SPA-SRYYMD
                           IF      PTBYO-TENKIYMD  >=  WRK-TENKIYMD
                               MOVE    PTBYO-TENKIYMD  TO  WRK-TENKIYMD
                           END-IF
                         END-IF
                   END-EVALUATE
               END-IF
               MOVE    "PTBYOMEI-KEY3"     TO  ORC-DBPATH
               PERFORM 980-PTBYOMEI-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "PTBYOMEI-KEY3"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *----(01.00.01) LINE ADD START ----------------------------------
      *    治癒の最終日の判定（最終来院日より前なら治癒でない）
           IF      WRK-CHIYUYMD    NOT =   SPACE
               IF      WRK-CHIYUYMD        <   SPA-LSTYMD
                   MOVE    ZERO                TO  FLG-CHIYU
                   MOVE    SPA-LSTYMD          TO  WRK-CHIYUYMD
               END-IF
           END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *    最終転帰日のチェック
           IF      WRK-TENKIYMD    NOT =   SPACE
      *        １月後算定
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY6-AREA
               MOVE    "61"                TO  LNK-DAY6-IRAI
               MOVE    WRK-TENKIYMD        TO  LNK-DAY6-KIJUN
               MOVE    "2"                 TO  LNK-DAY6-ZOGENPTN
               MOVE    1                   TO  LNK-DAY6-ZOGEN
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
               IF      STS-DAY-RC1         =   ZERO
      *            1ヶ月以内なら継続中
                   IF      LNK-DAY6-KOYOMI     >=  SPA-SRYYMD
                       MOVE    1               TO  FLG-TENKI
                       MOVE    ZERO            TO  FLG-CHIYU
                   ELSE
      *D                MOVE    ZERO           TO  FLG-TENKI
                       IF      WRK-CHIYUYMD        <   WRK-TENKIYMD
                           MOVE    1               TO  FLG-CHIYU
                       END-IF
                   END-IF
               END-IF
           END-IF
      *
      *    初診料算定有無
           IF      SPA-SYOYMD          =   SPACE
      *            初診算定
               MOVE    1               TO  SPA-SYOSIN
           ELSE
               IF     (FLG-CHIYU       =   1   )  AND
                      (FLG-TENKI       =   ZERO)
      *            初診算定
                   MOVE    1                   TO  SPA-SYOSIN
               ELSE
      *            初診算定なし
                   MOVE    ZERO                TO  SPA-SYOSIN
               END-IF
           END-IF
      *
      *    初診料算定日が診療日の時、再診とする
           IF      SPA-SYOSIN          =   1
               IF      SPA-SYOYMD          =   SPA-SRYYMD
                   OR  SPA-SRYYMD          =   SPA-LSTYMD
                   MOVE    ZERO            TO  SPA-SYOSIN
               END-IF
           END-IF
      *
           .
       1101-HKN-SYOYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災保険 初診日、最終診察日編集処理
      *****************************************************************
       1102-RSI-SYOYMD-SET-SEC             SECTION.
      *
      *    該当の保険のみ受診歴を検索する
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                  JYURRK-KEY
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-GMN-HKNCOMBINUM TO  JYURRK-HKNCOMBINUM
      *
           MOVE    "JYURRK-KEY15"      TO  WRK-PATH
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               MOVE    SPACE               TO  JYURRK-REC
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
           PERFORM
                   UNTIL    FLG-JYURRK     =   1
      *        初診算定日
               IF     (SPA-SYOYMD          =   SPACE      )  OR
                      (JYURRK-SRYYMD       <   SPA-SYOYMD )
                   MOVE    JYURRK-SRYYMD       TO  SPA-SYOYMD
               END-IF
      *        最終受診日
               IF      JYURRK-SRYYMD       >=  SPA-LSTYMD
                   MOVE    JYURRK-SRYYMD       TO  SPA-LSTYMD
                   MOVE    JYURRK-SRYKA        TO  SPA-LSTSRYKA
               END-IF
      *        同日再診のチェック
               IF      SPA-SRYYMD          =   JYURRK-SRYYMD
                   IF      SPA-GMN-SRYKA   NOT =   JYURRK-SRYKA
                       MOVE    JYURRK-SRYYMD   TO  SPA-RRK-LSTYMD
                       MOVE    JYURRK-SRYKA    TO  SPA-RRK-LSTSRYKA
                   END-IF
               END-IF
      *
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
      *    初診料算定有無
           IF      SPA-SYOYMD          =   SPACE
      *            初診算定
               MOVE    1                   TO  SPA-SYOSIN
           ELSE
      *            初診算定なし
               MOVE    ZERO                TO  SPA-SYOSIN
           END-IF
      *
           .
       1102-RSI-SYOYMD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    未収金額編集処理
      *****************************************************************
       49011-MISYU-HEN-SEC             SECTION.
      *
      *    収納テーブル読み込み
           MOVE    SPACE               TO  SYUNOU-REC
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYUNOU-REC
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           MOVE    ZERO                TO  SPA-MISYUMONEY
           PERFORM
               UNTIL     FLG-SYUNOU    =   1
               COMPUTE WRK-MISYU       =   SYU-SKYMONEY
                                       -   SYU-NYUKIN-TOTAL
               ADD     WRK-MISYU           TO  SPA-MISYUMONEY
      *
               MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYUNOU-KEY2"       TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
           .
       49011-MISYU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    特定疾患の有無検索編集処理
      *****************************************************************
       11011-TOKUTEI-SYORI-SEC             SECTION.
      *
           MOVE    ZERO                TO  SPA-TOKUTEI
           MOVE    ZERO                TO  SPA-TOKUTEI-F
           MOVE    ZERO                TO  SPA-TOKUTEIFLG
      *
      *    特定疾患の有無検索
           MOVE    SPACE               TO  PTBYOMEI-REC
           INITIALIZE                  PTBYOMEI-REC
           MOVE    SPA-HOSPID          TO  PTBYO-HOSPID
           MOVE    SPA-PTID            TO  PTBYO-PTID
           MOVE    SPA-SRYKA           TO  PTBYO-SRYKA
      *
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 980-PTBYOMEI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTBYOMEI
               MOVE    SPACE               TO  PTBYOMEI-REC
               INITIALIZE                  PTBYOMEI-REC
           END-IF
           PERFORM UNTIL      (FLG-PTBYOMEI    =   1 )  OR
                              (SPA-TOKUTEI     =   1 )
      *            特定疾患の有無
              IF      PTBYO-SRYYMD        <=   SPA-SRYYMD
      *            特定疾患の有無
                   IF      PTBYO-MANSEIKBN     =   05
                       IF     (PTBYO-TENKIKBN      =   SPACE )  OR
                              (PTBYO-TENKIYMD      >   SPA-SRYYMD)
                           MOVE    1               TO  SPA-TOKUTEI
                        END-IF
                   END-IF
      *            皮膚科特定疾患の有無
                   IF      PTBYO-MANSEIKBN     =   03  OR  04
                       IF     (PTBYO-TENKIKBN      =   SPACE )  OR
                              (PTBYO-TENKIYMD      >   SPA-SRYYMD)
                           IF      SPA-TOKUTEI-F       =   03
                               CONTINUE
                           ELSE
                               MOVE    PTBYO-MANSEIKBN
                                                   TO  SPA-TOKUTEI-F
                           END-IF
                        END-IF
                   END-IF
               END-IF
               MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 980-PTBYOMEI-READ-SEC
           END-PERFORM
           .
       11011-TOKUTEI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療月の累計点数編集処理
      *****************************************************************
      *49012-ZAITENTOTAL-SEC             SECTION.
      *
      *    診療会計検索
      *    MOVE    SPACE               TO  SRYACCT-REC
      *    INITIALIZE                      SRYACCT-REC
      *    MOVE    SPA-HOSPID          TO  ACCT-HOSPID
      *    MOVE    SPA-NYUGAIKBN       TO  ACCT-NYUGAIKBN
      *    MOVE    SPA-PTID            TO  ACCT-PTID
      *    MOVE    SPA-SRYKA           TO  ACCT-SRYKA
      *    MOVE    SPA-SRYYMD(1:6)     TO  ACCT-SRYYM
      *
      *    MOVE    SRYACCT-REC         TO  MCPDATA-REC
      *    MOVE    "DBSELECT"          TO  MCP-FUNC
      *    MOVE    "SRYACCT-KEY2"      TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *    IF      MCP-RC              =   ZERO
      *        MOVE    "SRYACCT-KEY2"      TO  ORC-DBPATH
      *        PERFORM 945-SRYACCT-NEXT-SEC
      *    ELSE
      *        MOVE    1                   TO  FLG-SRYACCT
      *    END-IF
      *
      *    MOVE    ZERO                TO  SPA-ZAITENTOTAL
      *    PERFORM UNTIL     FLG-SRYACCT   =   1
      *
      *        IF     (ACCT-ZAITEN          =   ZERO )  OR
      *               (ACCT-ZAIKAISU        =   ZERO )
      *            CONTINUE
      *        ELSE
      *            COMPUTE SPA-ZAITENTOTAL  =   SPA-ZAITENTOTAL
      *                                     +  (ACCT-ZAITEN
      *                                     *   ACCT-ZAIKAISU )
      *        END-IF
      *
      *        MOVE    "SRYACCT-KEY2"      TO  ORC-DBPATH
      *        PERFORM 945-SRYACCT-NEXT-SEC
      *    END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACCT-KEY2"      TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    .
      *49012-ZAITENTOTAL-EXT.
      *    EXIT.
      *
      *****************************************************************
      *    入院ＳＰＡ編集、ワーク診療行為作成処理
      *****************************************************************
       500-NYUIN-SPASET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-HKNCOMBIMEI
           MOVE    SPACE               TO  SPA-FTNRATEMEI
      *
      *    診療科、ドクター名称編集
           PERFORM 10012-SYSKAN-SEC
      *
      *    保険組合せ名称編集
           PERFORM 10013-HKNCOMBI-SEC
      *
      *    前回患者保存
           MOVE    SPA-PTID            TO  SPA-LAST-PTID
           MOVE    SPA-PTNUM           TO  SPA-LAST-PTNUM
      *
           PERFORM 110-K02SYOSIN-SEC
      *
           PERFORM 200-WKSRYACT-SYORI-SEC
           .
       500-NYUIN-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ワーク診療行為作成処理
      *****************************************************************
       200-WKSRYACT-SYORI-SEC              SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID2
      *
           OPEN    OUTPUT              PARA-FILE
      **   MOVE    SPACE               TO  PARA-REC
      **   WRITE   PARA-REC
      *
      *    ワーク診療行為データから作成 
           PERFORM 4902-WKBUNSAN-SEC
      *
      *    前回処方かつ、分散入力がなかったとき、
      *    診療診療行為マスタより作成
           IF     (FLG-WKSYORI         =   ZERO )  AND
                  (SPA-ZENSYOHOFLG     =   0    )  AND
      *           再診の時のみ
                  (SPA-SYOSIN          =   0    )
                PERFORM 4901-PARA-OUT-SEC
           END-IF
      *
           CLOSE                       PARA-FILE
      *
      *    前回患者番号のセット
           MOVE    SPA-PTNUM           TO  SPA-LAST-PTNUM
           MOVE    SPA-PTID            TO  SPA-LAST-PTID
      *
          .
       200-WKSRYACT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    訂正ワーク診療行為作成処理
      *****************************************************************
       300-WKSRYACT-SYORI-SEC              SECTION.
      *
           MOVE    ZERO                TO  WRK-GOK-TENSU
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID2
      *
           OPEN    OUTPUT              PARA-FILE
      **   MOVE    SPACE               TO  PARA-REC
      **   WRITE   PARA-REC
      *
           PERFORM 4901-PARA-OUT-SEC
      *
           CLOSE                       PARA-FILE
      *
           MOVE    WRK-GOK-TENSU       TO  LNK-SC95-GOK-TENSU
      *
      *    患者情報の再セット
           PERFORM 1001-SPA-JYUSIN-SEC
      *
      *    特定疾患の有無検索
           PERFORM 11011-TOKUTEI-SYORI-SEC
      *
      *    保険組合せが使用できるかのチェック
           PERFORM 100131-HKNCOMBI-CHK-SEC
      *
      *    継続のチェック
      *    収納テーブル読み込み
           MOVE    SPACE               TO  SYUNOU-REC
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-PTID            TO  SYU-PTID
           MOVE    SPA-DENPNUM         TO  SYU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY"       TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYUNOU-REC
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
           IF      FLG-SYUNOU          =   ZERO
      *        伝票状態区分
               MOVE    SYU-CONTKBN         TO  SPA-CONTKBN
               MOVE    SYU-DENPJTIKBN      TO  SPA-DENPJTIKBN
               MOVE    SYU-DOUJI-DENPNUM   TO  SPA-DOUJI-DENPNUM
           END-IF
      *
      *    診療月の累計点数編集
      *****PERFORM 49012-ZAITENTOTAL-SEC
      *
          .
       300-WKSRYACT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスタを作成する 
      *****************************************************************
       4901-PARA-OUT-SEC               SECTION.
      *
           IF     (LNK-SC95-RRKYMD     =   SPACE)  OR
                  (LNK-SC95-RENNUM     =   ZERO )
               PERFORM 4901-RRKNASI-SET-SEC
           ELSE
               PERFORM 4902-RRKARI-SET-SEC
           END-IF
      *
           IF      FLG-SYORI           =   1
               PERFORM 49011-ZAISET-SEC
           END-IF
      *
          .
       4901-PARA-OUT-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタを作成する（受診歴選択なし） 
      *****************************************************************
       4901-RRKNASI-SET-SEC            SECTION.
      *
           MOVE    SPACE               TO  WRK-RRK-SRYYMD
           MOVE    ZERO                TO  WRK-RRK-DENPNUM
           INITIALIZE                      WRK-ZAINUM-TBL
      *    受診歴を検索する
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                  JYURRK-KEY
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-SRYKA           TO  JYURRK-SRYKA
           MOVE    SPA-SRYYMD          TO  JYURRK-SRYYMD
      *
      *****MOVE    "JYURRK-KEY3"       TO  WRK-PATH
           MOVE    "JYURRK-KEY11"      TO  WRK-PATH
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               MOVE    SPACE               TO  JYURRK-REC
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           MOVE    ZERO                TO  FLG-SYORI
           MOVE    ZERO                TO  IDX-JYU
           PERFORM
                   UNTIL    FLG-JYURRK     =   1
               IF      (JYURRK-SRYYMD      <=  SPA-SRYYMD     ) AND
                       (JYURRK-HKNCOMBINUM =   SPA-HKNCOMBINUM)
                   IF     (JYURRK-SRYYMD       =   WRK-RRK-SRYYMD ) AND
                          (JYURRK-DENPNUM      =   WRK-RRK-DENPNUM)
                       ADD     1               TO  IDX-JYU
                   ELSE
                       INITIALIZE                  WRK-ZAINUM-TBL
                       MOVE    1                   TO  IDX-JYU
                   END-IF
                   IF      IDX-JYU                 >   50
                       CONTINUE
                   ELSE
                       MOVE    JYURRK-SRYYMD       TO  WRK-RRK-SRYYMD
                       MOVE    JYURRK-DENPNUM      TO  WRK-RRK-DENPNUM
                       MOVE    JYURRK-ZAINUM-G     TO  WRK-ZAINUM-G
                                                          (IDX-JYU)
                       MOVE    1                   TO  FLG-SYORI
                   END-IF
               END-IF
               IF      JYURRK-SRYYMD       >   SPA-SRYYMD
                   MOVE    1                   TO  FLG-JYURRK
               ELSE
      *
                   MOVE    WRK-PATH            TO  ORC-DBPATH
                  PERFORM 970-JYURRK-READ-SEC
               END-IF
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE     WRK-PATH           TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
          .
       4901-RRKNASI-SET-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタを作成する（受診歴選択あり） 
      *****************************************************************
       4902-RRKARI-SET-SEC            SECTION.
      *
           MOVE    LNK-SC95-RRKYMD     TO  WRK-RRK-SRYYMD
           INITIALIZE                      WRK-ZAINUM-TBL
      *    受診歴を検索する
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                  JYURRK-KEY
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-PTID            TO  JYURRK-PTID
           MOVE    SPA-NYUGAIKBN       TO  JYURRK-NYUGAIKBN
           MOVE    SPA-SRYKA           TO  JYURRK-SRYKA
           MOVE    LNK-SC95-RRKYMD     TO  JYURRK-SRYYMD
           MOVE    LNK-SC95-RENNUM     TO  JYURRK-RENNUM
      *
           MOVE    "JYURRK-KEY5"       TO  WRK-PATH
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               MOVE    SPACE               TO  JYURRK-REC
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           MOVE    ZERO                TO  FLG-SYORI
           MOVE    ZERO                TO  IDX-JYU
           PERFORM
                   UNTIL    FLG-JYURRK     =   1
               MOVE    ZERO                TO  FLG-NO
      *        訂正処理時、同日連番の同じもの
               IF      LNK-SC95-KBN        =   "4"
                  IF      LNK-SC95I-DOUJI-RENNUM
                                               =   JYURRK-DOUJI-RENNUM
                       CONTINUE
                   ELSE
                       MOVE    1               TO  FLG-NO
                   END-IF
               END-IF
      *
               IF      FLG-NO              =   ZERO
                   ADD     1                   TO  IDX-JYU
                   IF      IDX-JYU                 >   50
                       CONTINUE
                   ELSE
                       MOVE    JYURRK-ZAINUM-G     TO  WRK-ZAINUM-G
                                                            (IDX-JYU)
                       MOVE    1                   TO  FLG-SYORI
                   END-IF
      *        訂正処理時、ドクター、保険組合せ、伝票番号を取得する
                   IF      LNK-SC95-KBN        =   "4"
                       MOVE    JYURRK-DRCD         TO  SPA-DRCD
                       MOVE    JYURRK-HKNCOMBINUM  TO  SPA-HKNCOMBINUM
                       MOVE    JYURRK-DENPNUM      TO  SPA-DENPNUM
                  END-IF
               END-IF
      *
               MOVE    WRK-PATH            TO  ORC-DBPATH
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE     WRK-PATH           TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
          .
       4902-RRKARI-SET-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタを作成する 
      *****************************************************************
       49011-ZAISET-SEC           SECTION.
      *
           MOVE    ZERO                TO  IDX-TEI
           INITIALIZE                  SPA-K02-TEISEI-AREA
      *
           MOVE    ZERO                TO  WRK-EDABAN
           MOVE    ZERO                TO  FLG-JIKAN
      *
           PERFORM VARYING     IDX-JYU     FROM    1   BY  1
                   UNTIL      (IDX-JYU     >   50   )
             IF    WRK-ZAINUM-G (IDX-JYU)  NOT =   ZERO
      *
               PERFORM VARYING     IDX-R   FROM    1   BY  1
                       UNTIL      (IDX-R           >   15  )
                   IF     (WRK-TZAINUM (IDX-JYU IDX-R)
                                                 =   ZERO  )
                       CONTINUE
                   ELSE
                       PERFORM 490111-ZAISET-HEN-SEC
                   END-IF
               END-PERFORM
             END-IF
           END-PERFORM
      *
          .
       49011-ZAISET-EXT.
           EXIT.
           .
      *****************************************************************
      *    診療行為マスタを作成する 
      *****************************************************************
       490111-ZAISET-HEN-SEC           SECTION.
      *
      *
           MOVE    SPACE               TO  SRYACT-REC
           INITIALIZE                  SRYACT-REC
           MOVE    SPA-HOSPID          TO  SRY-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  SRY-NYUGAIKBN
           MOVE    SPA-PTID            TO  SRY-PTID
           MOVE    SPA-SRYKA           TO  SRY-SRYKA
           MOVE    WRK-RRK-SRYYMD(1:6) TO  SRY-SRYYM
           MOVE    WRK-TZAINUM (IDX-JYU IDX-R)
                                       TO  SRY-ZAINUM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY2"         TO  ORC-DBPATH
               PERFORM 930-SRYACT-READ-SEC
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           MOVE    ZERO                TO  WRK-ZAINUM
           MOVE    ZERO                TO  WRK-IDX
           PERFORM
                   UNTIL   FLG-SRYACT      =   1
      *
      *        訂正処理時以外、診察を対象外とする
               IF    ( SRY-SRYKBN(1:1)     =   "1"  )  AND
                     ( LNK-SC95-KBN    NOT =   "4"  )
                   CONTINUE
               ELSE
      *
                   PERFORM 49011-SRYACT-HEN-SEC
      *            剤回数がゼロの時、対象外
                   IF      WKSRY-ZAIKAIKEI     =   ZERO
                       CONTINUE
                   ELSE
      *
                       MOVE    SRY-ZAINUM          TO  WRK-ZAINUM
                       MOVE    SPACE               TO  PARA-REC
                       MOVE    "WKSRYACT"          TO  PARA-FILEMEI
                       ADD     1                   TO  WRK-EDABAN
                       MOVE    WRK-EDABAN          TO  PARA-EDABAN
                       MOVE    WKSRYACT-REC        TO  PARA-DATA-REC
      *
                       WRITE                       PARA-REC
                   END-IF
               END-IF
      *
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 930-SRYACT-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
          .
       490111-ZAISET-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタを作成する 
      *****************************************************************
       49011-SRYACT-HEN-SEC           SECTION.
      *
           MOVE    ZERO                TO  WRK-ZAIKAISU
      *    剤回数取得
           MOVE    SPACE               TO  SRYACCT-REC
           INITIALIZE                      SRYACCT-REC
           MOVE    SRY-HOSPID          TO  ACCT-HOSPID
           MOVE    SRY-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    SRY-PTID            TO  ACCT-PTID
           MOVE    SRY-SRYKA           TO  ACCT-SRYKA
           MOVE    SRY-SRYYM           TO  ACCT-SRYYM
           MOVE    SRY-SRYKBN          TO  ACCT-SRYKBN
           MOVE    SRY-ZAINUM          TO  ACCT-ZAINUM
      *    主キー読み
           PERFORM 940-SRYACCT-READ-SEC
           IF      FLG-SRYACCT         =   ZERO
      *    回数決定
               MOVE    WRK-RRK-SRYYMD(7:2)     TO  IDX-STR
      *        診療連番のある時、連番の回数
               EVALUATE    LNK-SC95-RENNUM
                   WHEN    ZERO
      *            同日再診の最終回セット
                       EVALUATE    TRUE
                         WHEN    ACCT-DAY (4 IDX-STR)    >   ZERO
                           MOVE    ACCT-DAY(4 IDX-STR) TO  WRK-ZAIKAISU
                         WHEN    ACCT-DAY (3 IDX-STR)    >   ZERO
                           MOVE    ACCT-DAY(3 IDX-STR) TO  WRK-ZAIKAISU
                         WHEN    ACCT-DAY (2 IDX-STR)    >   ZERO
                           MOVE    ACCT-DAY(2 IDX-STR) TO  WRK-ZAIKAISU
                     END-EVALUATE
                   WHEN    1
                       MOVE    ACCT-DAY(2 IDX-STR) TO  WRK-ZAIKAISU
                   WHEN    2
                       MOVE    ACCT-DAY(3 IDX-STR) TO  WRK-ZAIKAISU
                   WHEN    OTHER
                       MOVE    ACCT-DAY(4 IDX-STR) TO  WRK-ZAIKAISU
               END-EVALUATE
           END-IF
      *
      *
           IF      WRK-ZAINUM      NOT =   SRY-ZAINUM
               MOVE    ZERO                TO  IDX-KAI
      *
      *        対象分の合計点数計算
               COMPUTE WRK-GOK-TENSU       =   WRK-GOK-TENSU
                                           +  (ACCT-ZAITEN
                                           *   WRK-ZAIKAISU )
           END-IF
      *
           MOVE    SPACE               TO  WKSRYACT-REC
           INITIALIZE                  WKSRYACT-REC
           MOVE    SRY-HOSPID          TO  WKSRY-HOSPID
           MOVE    SRY-NYUGAIKBN       TO  WKSRY-NYUGAIKBN
           MOVE    SRY-PTID            TO  WKSRY-PTID
           MOVE    SRY-SRYKA           TO  WKSRY-SRYKA
           MOVE    SRY-SRYYM           TO  WKSRY-SRYYMD(1:6)
           MOVE    SRY-SRYKBN          TO  WKSRY-SRYKBN
           MOVE    SRY-ZAINUM          TO  WKSRY-ZAINUM
           MOVE    SRY-RENNUM          TO  WKSRY-RENNUM
           MOVE    SRY-SRYSYUKBN       TO  WKSRY-SRYSYUKBN
           MOVE    SRY-JIHIMONEYTOTAL  TO  WKSRY-JIHIMONEYTOTAL
      *剤回数計
           MOVE    WRK-ZAIKAISU        TO  WKSRY-ZAIKAIKEI
      *剤点数
           MOVE    ACCT-ZAITEN         TO  WKSRY-ZAITENKEI
      *保険組合
           MOVE    ACCT-HKNCOMBI       TO  WKSRY-HKNCOMBI
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX         >   5   )   OR
                              (SRY-SRYCD (IDX)     =   SPACE )
      *
               MOVE    SRY-SRYCD (IDX)     TO  WKSRY-SRYCD    (IDX)
               MOVE    SRY-SRYSURYO (IDX)  TO  WKSRY-SRYSURYO (IDX)
               MOVE    SRY-SRYKAISU (IDX)  TO  WKSRY-SRYKAISU (IDX)
               MOVE    SRY-AUTOKBN  (IDX)  TO  WKSRY-AUTOKBN  (IDX)
               MOVE    SRY-INPUTNUM (IDX)  TO  WKSRY-INPUTNUM (IDX)
               MOVE    SRY-JIHIMONEY(IDX)  TO  WKSRY-JIHIMONEY (IDX)
               IF      SRY-INPUTNUM (IDX)  NOT =   ZERO
                   PERFORM 490111-PTCOM-SET-SEC
               END-IF
               MOVE    IDX                 TO  IDX-W
               ADD     1                   TO  IDX-KAI
      *        訂正の時、時間外の自動発生の有無
               IF      LNK-SC95-KBN        =   "4"
      *            時間外区分あり
                   IF     SRY-AUTOKBN  (IDX)   =   "A" OR "B" OR "C"
                                                       OR "D"
                       PERFORM 49012-JIKAN-SYORI-SEC
                   END-IF
               END-IF
      *    点滴判定
               IF      SRY-SRYKBN          =   "33" 
                   MOVE    SPACE               TO  TNS-TENSU-REC
                   MOVE    SRY-SRYCD (IDX)     TO  TNS-SRYCD
                   PERFORM 910-TENSU-READ-SEC
                   IF     (SRY-SRYCD (IDX)(1:1)    =   "1"  ) AND
                          (TNS-DATAKBN             =   "1"  )
                       MOVE    1               TO  LNK-SC95-TENTEKI
                   END-IF
                   IF      SRY-SRYCD (IDX)(1:1)    =   "6"
                       COMPUTE LNK-SC95-CHUSYA =   LNK-SC95-CHUSYA
                                               +  (TNS-CSYYOURYO
                                               *   SRY-SRYSURYO(IDX))
                   END-IF
               END-IF
      *
      *        訂正の時、診療コードと回数をセット
               IF     (LNK-SC95-KBN        =   "4" )  OR
                      (SRY-SRYCD (IDX)(1:1)    =   "1" )
                   MOVE    SPACE               TO  TNS-TENSU-REC
                   MOVE    SRY-SRYCD (IDX)     TO  TNS-SRYCD
                   PERFORM 910-TENSU-READ-SEC
                   IF      TNS-SANTEIRRKKBN    NOT=   ZERO
                       ADD     1               TO  IDX-TEI
                       MOVE    SRY-SRYCD (IDX) TO  SPA-K02-TEI-SRYCD
                                                             (IDX-TEI)
                       MOVE    WRK-ZAIKAISU    TO  SPA-K02-TEI-KAISU
                                                             (IDX-TEI)
                   END-IF
      *            ＣＴ・ＭＲＩの時、コード変更
                   IF      TNS-SRYSYUKBN   =   "723"  OR  "724"
                                           OR  "713"  OR  "714"
                       PERFORM 490111-CTMRT-HEN-SEC
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           IF      ACCT-MEISAISU        =   IDX-KAI
               MOVE    WRK-ZAIKAISU        TO  WKSRY-ZAIKAISU (IDX-W)
           END-IF
      *
      *
           .
       49011-SRYACT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ＣＴ・ＭＲＩの時、コード算定履歴用編集処理
      *****************************************************************
       490111-CTMRT-HEN-SEC              SECTION.
      *
      *    包括逓減区分判定（Ｋ０２、３でも同様の判定をしている）
           MOVE    SPACE               TO  WRK-HEN-SRYCD
           EVALUATE    TNS-HOUKATUTEIGENKBN
      *        頭部
               WHEN    "201"
                   MOVE    "099700101"         TO  WRK-HEN-SRYCD
      *        躯幹
               WHEN    "202"
                   MOVE    "099700102"         TO  WRK-HEN-SRYCD
      *        四肢
               WHEN    "203"
                   MOVE    "099700103"        TO  WRK-HEN-SRYCD
           END-EVALUATE
      *
           IF      WRK-HEN-SRYCD   NOT =   SPACE
               IF      TNS-SANTEIRRKKBN        =   ZERO
                   ADD     1                   TO  IDX-TEI
               END-IF
               MOVE    WRK-HEN-SRYCD       TO  SPA-K02-TEI-SRYCD
                                                            (IDX-TEI)
               MOVE    WRK-ZAIKAISU        TO  SPA-K02-TEI-KAISU
                                                            (IDX-TEI)
           END-IF
      *
           .
       490111-CTMRT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    患者コメントから編集する
      *****************************************************************
       490111-PTCOM-SET-SEC              SECTION.
      *
           MOVE    SRY-HOSPID          TO  PTCOM-HOSPID
           MOVE    SRY-PTID            TO  PTCOM-PTID
           MOVE    SRY-ZAINUM          TO  PTCOM-ZAINUM
           MOVE    SRY-SRYCD (IDX)     TO  PTCOM-SRYCD
           MOVE    SRY-INPUTNUM(IDX)   TO  PTCOM-RENNUM
      *主キーで検索
           PERFORM 950-PTCOM-READ-SEC
           IF      FLG-PTCOM           =   ZERO
               MOVE    PTCOM-INPUTCOMENT   TO  WKSRY-INPUTCOMENT (IDX)
               MOVE    PTCOM-INPUTCHI (1)  TO  WKSRY-INPUTCHI (IDX 1)
               MOVE    PTCOM-INPUTCHI (2)  TO  WKSRY-INPUTCHI (IDX 2)
               MOVE    PTCOM-INPUTCHI (3)  TO  WKSRY-INPUTCHI (IDX 3)
               MOVE    PTCOM-INPUTCHI (4)  TO  WKSRY-INPUTCHI (IDX 4)
           END-IF
           .
       490111-PTCOM-SET-EXT.
           EXIT.
      *****************************************************************
      *    時間外のチェック、作成処理
      *****************************************************************
       49012-JIKAN-SYORI-SEC               SECTION.
      *
           EVALUATE    SRY-AUTOKBN  (IDX)
               WHEN    "A"
                   MOVE    "1"             TO  WKSRY-INPUTCD(IDX)
                                                                (1:1)
               WHEN    "B"
                   MOVE    "2"             TO  WKSRY-INPUTCD(IDX)
                                                                (1:1)
               WHEN    "C"
                   MOVE    "3"             TO  WKSRY-INPUTCD(IDX)
                                                                (1:1)
               WHEN    "D"
                   MOVE    "4"             TO  WKSRY-INPUTCD(IDX)
                                                                (1:1)
           END-EVALUATE
           MOVE    WKSRY-SRYCD (IDX)   TO  WKSRY-INPUTCD (IDX)(3:)
           MOVE    SPACE               TO  WKSRY-AUTOKBN  (IDX)
      *
           .
       49012-JIKAN-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    ワーク診療行為マスタを作成する 
      *****************************************************************
       4902-WKBUNSAN-SEC               SECTION.
      *
           MOVE    ZERO               TO  FLG-WKSYORI
      *    対象の保険組合せの保存
           MOVE    ZERO                TO  SPA-WKSRY-HKNCOMBI
      *
           MOVE    SPACE               TO  WRK-SRYYYMM
           MOVE    SPACE               TO  WKSRYACT-REC
           INITIALIZE                  WKSRYACT-REC
           MOVE    SPA-HOSPID          TO  WKSRY-HOSPID
           MOVE    SPA-NYUGAIKBN       TO  WKSRY-NYUGAIKBN
           MOVE    SPA-PTID            TO  WKSRY-PTID
           MOVE    SPA-SRYKA           TO  WKSRY-SRYKA
           MOVE    SPA-SRYYMD          TO  WKSRY-SRYYMD
           MOVE    SPA-HKNCOMBINUM     TO  WKSRY-HKNCOMBI
      *
           MOVE    WKSRYACT-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "WKSRYACT-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "WKSRYACT-KEY2"   TO  ORC-DBPATH
               PERFORM 940-WKSINKOUI-READ-SEC
           ELSE
               INITIALIZE                  WKSRYACT-REC
               MOVE    1               TO  FLG-WKSRYACT
           END-IF
           MOVE    ZERO                TO  WRK-EDABAN
           PERFORM
               UNTIL   FLG-WKSRYACT   =   1
               IF      WKSRY-HKNCOMBI      =   SPA-HKNCOMBINUM
                   MOVE    SPACE               TO  PARA-REC
                   MOVE    "WKSRYACT"          TO  PARA-FILEMEI
                   ADD     1                   TO  WRK-EDABAN
                   MOVE    WRK-EDABAN          TO  PARA-EDABAN
      *
      *            ワーク診療行為マスタからの作成判定とする
                   MOVE    "WKSRYACT"          TO  WKSRY-TERMID
      *
                   MOVE    WKSRYACT-REC        TO  PARA-DATA-REC
                   WRITE                       PARA-REC
      *
      *            継続区分が入力値と同じ時、前回の伝票内容をパラメタへ
                   IF      WKSRY-CONTKBN       =   "1"  OR  "2" 
      ***************AND  (SPA-GMN-CONTKBN NOT =   SPACE        )
                       MOVE    WKSRY-DOUJI-DENPNUM
                                               TO  SPA-DOUJI-DENPNUM
                       MOVE    WKSRY-DOUJI-RENNUM
                                               TO  SPA-DOUJI-RENNUM
                       MOVE    WKSRY-CONTKBN   TO  SPA-CONTKBN
                   END-IF
      *
                   MOVE    1               TO  FLG-WKSYORI
      *            対象の保険組合せの保存
                   MOVE    WKSRY-HKNCOMBI      TO  SPA-WKSRY-HKNCOMBI
               END-IF
      *
               MOVE    "WKSRYACT-KEY2"     TO  ORC-DBPATH
               PERFORM 940-WKSINKOUI-READ-SEC
           END-PERFORM
      *
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "WKSRYACT-KEY2"     TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
          .
       4902-WKBUNSAN-EXT.
           EXIT.
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
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-KANRIMST-READ-SEC         SECTION.
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
       900-KANRIMST-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    受付マスタ読み込み処理
      *****************************************************************
       900-UKETUKE-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  UKETUKE-REC
               MOVE    ZERO            TO  FLG-UKETUKE
           ELSE
               INITIALIZE                  UKETUKE-REC
               MOVE    1               TO  FLG-UKETUKE
           END-IF
      *
           .
       900-UKETUKE-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    患者マスター読込（主キー）
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    ZERO                TO  FLG-PTINF
               ELSE
                   MOVE    1                   TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "PTINF-KEY"         TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター読込
      *****************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
               MOVE    ZERO            TO  FLG-HKNCOMBI
           ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター読込
      *****************************************************************
       930-SRYACT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       930-SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ワーク診療行為データ読込
      *****************************************************************
       940-WKSINKOUI-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  WKSRYACT-REC
               MOVE    ZERO            TO  FLG-WKSRYACT
           ELSE
               INITIALIZE                  WKSRYACT-REC
               MOVE    1               TO  FLG-WKSRYACT
           END-IF
      *
           .
       940-WKSINKOUI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスター読込（主キー）
      *****************************************************************
       940-SRYACCT-READ-SEC           SECTION.
      *
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SRYACCT-REC
                   MOVE    ZERO                TO  FLG-SRYACCT
               ELSE
                   MOVE    1                   TO  FLG-SRYACCT
                   INITIALIZE                  SRYACCT-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
               INITIALIZE                  SRYACCT-REC
           END-IF
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SRYACCT-KEY"       TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
       940-SRYACCT-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    診療会計マスター読込
      *****************************************************************
       945-SRYACCT-NEXT-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACCT-REC
               MOVE    ZERO                TO  FLG-SRYACCT
           ELSE
               MOVE    1                   TO  FLG-SRYACCT
               INITIALIZE                  SRYACCT-REC
           END-IF
           .
       945-SRYACCT-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者コメントマスタ読み込み
      *****************************************************************
       950-PTCOM-READ-SEC           SECTION.
      *
      *
           MOVE    PTCOM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTCOM-REC
                   MOVE    ZERO                TO  FLG-PTCOM
               ELSE
                   MOVE    1                   TO  FLG-PTCOM
                   INITIALIZE                  PTCOM-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTCOM
               INITIALIZE                  PTCOM-REC
           END-IF
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
       950-PTCOM-READ-EXT.
           EXIT.
      *****************************************************************
      *    受診履歴マスター読込
      *****************************************************************
       970-JYURRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       970-JYURRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科歴データ主キー検索
      *****************************************************************
       975-SRYKARRK-READ-SEC           SECTION.
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
               MOVE    1                   TO  FLG-SRYKARRK
               INITIALIZE                  SRYKARRK-REC
           END-IF
      *
           .
       975-SRYKARRK-READ-EXT.
           EXIT.
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       980-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       980-SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者病名読込
      *****************************************************************
       980-PTBYOMEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTBYOMEI-REC
               MOVE    ZERO            TO  FLG-PTBYOMEI
           ELSE
               INITIALIZE                  PTBYOMEI-REC
               MOVE    1               TO  FLG-PTBYOMEI
           END-IF
      *
           .
       980-PTBYOMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  TNS-YUKOSTYMD
           MOVE    ALL "9"             TO  TNS-YUKOEDYMD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
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
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者労災保険情報読み込み
      *****************************************************************
       993-PTRSIINF-NEXT-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTRSIINF-REC
               MOVE    ZERO            TO  FLG-PTRSIINF
           ELSE
               INITIALIZE                  PTRSIINF-REC
               MOVE    1               TO  FLG-PTRSIINF
           END-IF
      *
           .
       993-PTRSIINF-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタデータ順読み
      *****************************************************************
       990-PARA-NEXT-SEC           SECTION.
      *
           READ    PARA-FILE       NEXT
               AT  END
                   MOVE    1           TO  FLG-PARA
               NOT AT  END
                   MOVE    ZERO        TO  FLG-PARA
           END-READ
      *
           .
       990-PARA-NEXT-EXT.
           EXIT.
      *
      *
