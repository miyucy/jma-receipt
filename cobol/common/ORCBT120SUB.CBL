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
       PROGRAM-ID.                 ORCBT120SUB.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 日次統計用入院情報取得サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/12/15    NACL−小豆沢  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
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
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-NYUINACCT               PIC 9(01).
           03  FLG-NYUINACT                PIC 9(01).
           03  FLG-SRYACCT                 PIC 9(01).
           03  FLG-SRYACT                  PIC 9(01).
           03  FLG-TENSU                   PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-HKNCOMBI                PIC 9(01).
           03  FLG-RJN                     PIC 9(01).
           03  FLG-ROUSAI                  PIC 9(01).
           03  FLG-RYAKU                   PIC 9(01).
           03  FLG-OK                      PIC 9(01).
           03  FLG-KSN                     PIC 9(01).
           03  FLG-SENTEI-SET              PIC 9(01).
           03  FLG-SENTEICDCHG             PIC 9(01).
           03  FLG-TENSUWRK                PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
      *    添字領域
       01  IDX-AREA.
           03  IDX                         PIC 9(04).
           03  IDX1                        PIC 9(04).
           03  IDX2                        PIC 9(04).
           03  IDX3                        PIC 9(04).
           03  IDX4                        PIC 9(04).
           03  IDX5                        PIC 9(04).
           03  IDX6                        PIC 9(04).
           03  IDX7                        PIC 9(04).
           03  KSN-IDX                     PIC 9(04).
           03  GENSAN-IDX                  PIC 9(04).
           03  GENSAN-IDX2                 PIC 9(04).
           03  IDV                         PIC 9(02).
           03  TSY90-IDX                   PIC 9(02).
           03  ETC-IDX                     PIC 9(02).
           03  IDX-ST                      PIC 9(02).
           03  IDX-ED                      PIC 9(02).
      *
      *    コンスタント値
       01  CONSTANT-AREA.
      *    入院診療計画未実施減算
           03  CONS-KEIKAKU-GENSAN1        PIC X(09) VALUE "190080470".
           03  CONS-KEIKAKU-GENSAN2        PIC X(09) VALUE "190799670".
      *    院内感染防止対策未実施減算
           03  CONS-INNAI-GENSAN1          PIC X(09) VALUE "190080570".
           03  CONS-INNAI-GENSAN2          PIC X(09) VALUE "190799770".
      *    医療安全管理体制未整備減算
           03  CONS-ANZEN-GENSAN1          PIC X(09) VALUE "190111690".
           03  CONS-ANZEN-GENSAN2          PIC X(09) VALUE "190809090".
      *    褥瘡対策未実施減算
           03  CONS-JYOKU-GENSAN1          PIC X(09) VALUE "190111790".
           03  CONS-JYOKU-GENSAN2          PIC X(09) VALUE "190809190".
      *    日常生活障害加算
           03  CONS-NICHIJOU-KSN1          PIC X(09) VALUE "190109170".
           03  CONS-NICHIJOU-KSN2          PIC X(09) VALUE "190807570".
      *    痴呆加算
           03  CONS-CHIHOU-KSN1            PIC X(09) VALUE "190109270".
           03  CONS-CHIHOU-KSN2            PIC X(09) VALUE "190808670".
      *    褥瘡患者管理加算
           03  CONS-JYOKU-KSN1             PIC X(09) VALUE "190116990".
           03  CONS-JYOKU-KSN2             PIC X(09) VALUE "190813390".
      *    特定抗精神病薬治療管理加算
           03  CONS-TOKUSEIYAKU-KSN        PIC X(09) VALUE "190117570".
      *    その他診療行為で入力した入院料加算
           03  CONS-ETCNYUIN-TBL.
             05  CONS-ETCNYUIN-KSN         PIC X(09)  OCCURS 10.
      *    点数マスタ読み込みワーク用
           03  TTNS-CONST-MAX              PIC 9(03) VALUE 200.
      *
      *    一時領域
       01  WRK-AREA.
      *
      *    算定日退避
           03  WRK-SANTEIYMD.
               05  WRK-SANTEIYM.
                   07  WRK-SANTEIYY            PIC 9(04).
                   07  WRK-SANTEIMM            PIC 9(02).
               05  WRK-SANTEIDD                PIC 9(02).
      *
      *    前日算定日
           03  WRK-MAE-SANTEIYMD.
               05  WRK-MAE-SANTEIYM.
                   07  WRK-MAE-SANTEIYY        PIC 9(04).
                   07  WRK-MAE-SANTEIMM        PIC 9(02).
               05  WRK-MAE-SANTEIDD            PIC 9(02).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
           COPY    "CPSK1005.INC".
           COPY    "CPSK5000.INC".
      *
      *    入院診療会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為マスター
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    保険算定用年齢・割合計算サブ
           COPY    "CPORCSAGECHK.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    日次統計用入院情報パラメタ
           COPY    "CPORCBT120SUB.INC".
      *
       PROCEDURE                   DIVISION    USING
      *     SPA-AREA
            ORCBT120SUB-AREA
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
           INITIALIZE                  LNK-ORCBT120SUB-HENKYAKU-AREA
           INITIALIZE                  CONS-ETCNYUIN-TBL
           MOVE    ZERO                TO  LNK-ORCBT120SUB-RC
      *
      *    パラメータチェック
           PERFORM 100-PRM-CHK-SEC
           IF    ( LNK-ORCBT120SUB-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    主処理
           IF      LNK-ORCBT120SUB-RC      =    ZERO
               PERFORM 200-MAIN-SEC
           END-IF
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    パラメータチェック
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
      *    算定年月チェック
           IF    ( LNK-ORCBT120SUB-SANTEIYMD    =   SPACE )
               MOVE    1               TO  LNK-ORCBT120SUB-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    患者マスター検索
           INITIALIZE                      PTINF-REC
           MOVE    LNK-ORCBT120SUB-HOSPID   TO  PTINF-HOSPID
           MOVE    LNK-ORCBT120SUB-PTID     TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           NOT =   ZERO
               MOVE    2               TO  LNK-ORCBT120SUB-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    診療科チェック
           IF     LNK-ORCBT120SUB-SRYKA    NOT =   SPACE
               CONTINUE
           ELSE
               MOVE    3               TO  LNK-ORCBT120SUB-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    入院中のチェック（入院会計マスター検索）
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-ORCBT120SUB-HOSPID  TO  NACCT-HOSPID
           MOVE    LNK-ORCBT120SUB-PTID    TO  NACCT-PTID
           MOVE    LNK-ORCBT120SUB-SANTEIYMD(1:6)
                                           TO  NACCT-SRYYM
           MOVE    "5"                     TO  NACCT-ZAISKBKBN
           MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           NOT =   ZERO
               MOVE    4               TO  LNK-ORCBT120SUB-RC
               GO  TO  100-PRM-CHK-EXT
           ELSE
               MOVE    "NYUINACCT-KEY17"   TO  ORC-DBPATH
               PERFORM 910-NYUINACCT-READ-SEC
               IF   FLG-NYUINACCT          NOT =   ZERO
                    MOVE    4              TO  LNK-ORCBT120SUB-RC
                    GO  TO  100-PRM-CHK-EXT
               ELSE
                    MOVE       LNK-ORCBT120SUB-SANTEIYMD
                                           TO  WRK-SANTEIYMD
                    IF     NACCT-DAY(WRK-SANTEIDD)   =  ZERO
                        MOVE   4              TO  LNK-ORCBT120SUB-RC
                    END-IF
               END-IF
           END-IF
      *
      *    入院会計クローズ
           MOVE    "NYUINACCT-KEY17"           TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主取得
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *入院科／入退院区分／病棟番号／病室番号／退院事由／ドクターの取得
           INITIALIZE                           PTNYUINRRK-REC
           MOVE    LNK-ORCBT120SUB-HOSPID   TO  PTNYUINRRK-HOSPID
           MOVE    LNK-ORCBT120SUB-PTID     TO  PTNYUINRRK-PTID
           MOVE    "PTNYUINRRK-KEY3"        TO  ORC-DBPATH
           PERFORM 910-PTNYUINRRK-SELECT-SEC
           IF      FLG-PTNYUINRRK            =   ZERO
               MOVE     "PTNYUINRRK-KEY3"   TO  ORC-DBPATH
               PERFORM   910-PTNYUINRRK-READ-SEC
               PERFORM   UNTIL   (FLG-PTNYUINRRK    =   1)
                   IF   PTNYUINRRK-JTIKBN    =    "5" OR "6"
                       CONTINUE
                   ELSE
                       IF   (PTNYUINRRK-TENNYUYMD <=
                               LNK-ORCBT120SUB-SANTEIYMD)   AND
                            (PTNYUINRRK-TENSTUYMD >=
                               LNK-ORCBT120SUB-SANTEIYMD)
      *                    入院科
                           MOVE    PTNYUINRRK-NYUINKA
                                         TO  LNK-ORCBT120SUB-NYUINKA
      *                    入退院区分
                           MOVE   3      TO  LNK-ORCBT120SUB-NYUIN-KBN
                           IF    LNK-ORCBT120SUB-SANTEIYMD  =  
                                                   PTNYUINRRK-NYUINYMD
                               MOVE   1  TO  LNK-ORCBT120SUB-NYUIN-KBN
                           END-IF
                           IF    LNK-ORCBT120SUB-SANTEIYMD  =  
                                                   PTNYUINRRK-TAIINYMD
                               MOVE   2  TO  LNK-ORCBT120SUB-NYUIN-KBN
                           END-IF
      *                    病棟番号
                           MOVE   PTNYUINRRK-BTUNUM
                                         TO  LNK-ORCBT120SUB-BTUNUM
      *                    病室番号
                           MOVE   PTNYUINRRK-BRMNUM(3:6)
                                         TO  LNK-ORCBT120SUB-BRMNUM
      *                    退院事由
                           MOVE   PTNYUINRRK-TAIINCD
                                         TO  LNK-ORCBT120SUB-TAIINCD
      *                    医師コード
                           MOVE   PTNYUINRRK-DRCD1
                                         TO  LNK-ORCBT120SUB-DRCD
                       END-IF
                   END-IF
                   MOVE    "PTNYUINRRK-KEY3"   TO  ORC-DBPATH
                   PERFORM 910-PTNYUINRRK-READ-SEC
               END-PERFORM
           ELSE
               MOVE     5      TO      LNK-ORCBT120SUB-RC
           END-IF
      *    患者入院履歴クローズ
           MOVE    "PTNYUINRRK-KEY3"           TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
      *前日入院科／前日病棟番号／前日病室番号の取得
      *    前日日の算定
           INITIALIZE                           STS-AREA-DAY
           INITIALIZE                           LNK-DAY6-AREA
           MOVE    "61"                     TO  LNK-DAY6-IRAI
           MOVE    LNK-ORCBT120SUB-SANTEIYMD TO LNK-DAY6-KIJUN
           MOVE    -1                       TO  LNK-DAY6-ZOGENPTN
           CALL    "ORSCDAY"                USING  STS-AREA-DAY
                                                   LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN          TO  WRK-MAE-SANTEIYMD
      *    入院履歴の検索
           INITIALIZE                           PTNYUINRRK-REC
           MOVE    LNK-ORCBT120SUB-HOSPID   TO  PTNYUINRRK-HOSPID
           MOVE    LNK-ORCBT120SUB-PTID     TO  PTNYUINRRK-PTID
           MOVE    "PTNYUINRRK-KEY3"        TO  ORC-DBPATH
           PERFORM 910-PTNYUINRRK-SELECT-SEC
           IF      FLG-PTNYUINRRK            =   ZERO
               MOVE     "PTNYUINRRK-KEY3"   TO  ORC-DBPATH
               PERFORM   910-PTNYUINRRK-READ-SEC
               PERFORM   UNTIL   (FLG-PTNYUINRRK    =   1)
                   IF   PTNYUINRRK-JTIKBN    =    "5" OR "6"
                       CONTINUE
                   ELSE
                       IF   (PTNYUINRRK-TENNYUYMD <=
                               WRK-MAE-SANTEIYMD)   AND
                            (PTNYUINRRK-TENSTUYMD >=
                               WRK-MAE-SANTEIYMD)
      *                    入院科
                           MOVE    PTNYUINRRK-NYUINKA
                                       TO  LNK-ORCBT120SUB-MAE-NYUINKA
      *                    病棟番号
                           MOVE   PTNYUINRRK-BTUNUM
                                       TO  LNK-ORCBT120SUB-MAE-BTUNUM
      *                    病室番号
                           MOVE   PTNYUINRRK-BRMNUM(3:6)
                                       TO  LNK-ORCBT120SUB-MAE-BRMNUM
                       END-IF
                   END-IF
                   MOVE    "PTNYUINRRK-KEY3"       TO  ORC-DBPATH
                   PERFORM 910-PTNYUINRRK-READ-SEC
               END-PERFORM
           ELSE
               MOVE     5      TO      LNK-ORCBT120SUB-RC
           END-IF
      *    患者入院履歴クローズ
           MOVE    "PTNYUINRRK-KEY3"           TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
      *    レセ電入院科の取得(算定日）
           MOVE    SPACE               TO  SYS-1005-REC
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    LNK-ORCBT120SUB-NYUINKA
                                       TO  SYS-1005-KBNCD
           MOVE    LNK-ORCBT120SUB-SANTEIYMD
                                       TO  ORC-DBYMD
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
                   MOVE    MCPDATA-REC         TO  SYS-1005-REC
      *            レセ電診療科
                   IF      SYS-1005-RECESRYKA  =   SPACE
                       MOVE    SPACE       TO  
                                         LNK-ORCBT120SUB-RECENYUINKA
                   ELSE
                       MOVE    SYS-1005-RECESRYKA
                                     TO  LNK-ORCBT120SUB-RECENYUINKA
                   END-IF
               END-IF
           END-IF
      *
      *    レセ電入院科の取得(前算定日）
           MOVE    SPACE               TO  SYS-1005-REC
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    LNK-ORCBT120SUB-MAE-NYUINKA
                                       TO  SYS-1005-KBNCD
           MOVE    LNK-ORCBT120SUB-SANTEIYMD
                                       TO  ORC-DBYMD
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
                   MOVE    MCPDATA-REC         TO  SYS-1005-REC
      *            レセ電診療科
                   IF      SYS-1005-RECESRYKA  =   SPACE
                       MOVE    SPACE       TO  
                                     LNK-ORCBT120SUB-MAE-RECENYUINKA
                   ELSE
                       MOVE    SYS-1005-RECESRYKA
                                 TO  LNK-ORCBT120SUB-MAE-RECENYUINKA
                   END-IF
               END-IF
           END-IF
      *
      *入院時の外泊取得
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-ORCBT120SUB-HOSPID  TO  NACCT-HOSPID
           MOVE    LNK-ORCBT120SUB-PTID    TO  NACCT-PTID
           MOVE    LNK-ORCBT120SUB-SANTEIYMD(1:6)
                                           TO  NACCT-SRYYM
           MOVE    "2"                     TO  NACCT-ZAISKBKBN
           MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE     "NYUINACCT-KEY17"  TO  ORC-DBPATH
               PERFORM   910-NYUINACCT-READ-SEC
               MOVE    NACCT-DAY(WRK-SANTEIDD)
                                 TO  LNK-ORCBT120SUB-GAIHAKU-KBN
           END-IF
      *    入院会計クローズ
           MOVE    "NYUINACCT-KEY17"       TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
      *食事情報の取得（入院会計）
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-ORCBT120SUB-HOSPID  TO  NACCT-HOSPID
           MOVE    LNK-ORCBT120SUB-PTID    TO  NACCT-PTID
           MOVE    LNK-ORCBT120SUB-SANTEIYMD(1:6)
                                           TO  NACCT-SRYYM
           MOVE    "NYUINACCT-KEY23"       TO  ORC-DBPATH
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE     "NYUINACCT-KEY23"  TO  ORC-DBPATH
               PERFORM   910-NYUINACCT-READ-SEC
               MOVE    NACCT-DAY(WRK-SANTEIDD)
                                 TO  LNK-ORCBT120SUB-SKJ-KBN
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       910-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-5000-REC
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                      SYS-5000-REC
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
       910-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC TO  PTINF-REC
                   MOVE    ZERO        TO  FLG-PTINF
               ELSE
                   INITIALIZE              PTINF-REC
                   MOVE    1           TO  FLG-PTINF
               END-IF
           ELSE
               INITIALIZE                 PTINF-REC
               MOVE    1              TO  FLG-PTINF
           END-IF
      *
           MOVE    "PTINF-KEY"        TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター検索
      *****************************************************************
       910-NYUINACCT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       910-NYUINACCT-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  NYUINACCT-REC
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                     NYUINACCT-REC
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター検索
      *****************************************************************
       910-NYUINACT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-NYUINACT
           ELSE
               MOVE    1                  TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為マスター読込
      *****************************************************************
       910-NYUINACT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  NYUINACT-REC
               MOVE    ZERO                TO  FLG-NYUINACT
           ELSE
               INITIALIZE                      NYUINACT-REC
               MOVE    1                   TO  FLG-NYUINACT
           END-IF
      *
           .
       910-NYUINACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター検索
      *****************************************************************
       910-HKNCOMBI-SELECT-SEC        SECTION.
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-HKNCOMBI
           ELSE
               MOVE    1                  TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-SELECT-EXT.
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
               MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
               MOVE    ZERO                TO  FLG-HKNCOMBI
           ELSE
               INITIALIZE                      HKNCOMBI-REC
               MOVE    1                   TO  FLG-HKNCOMBI
           END-IF
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者入院履歴マスター検索
      *****************************************************************
       910-PTNYUINRRK-SELECT-SEC        SECTION.
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-PTNYUINRRK
           ELSE
               MOVE    1                  TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       910-PTNYUINRRK-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者入院履歴マスター読込
      *****************************************************************
       910-PTNYUINRRK-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  PTNYUINRRK-REC
               MOVE    ZERO               TO  FLG-PTNYUINRRK
           ELSE
               INITIALIZE                     PTNYUINRRK-REC
               MOVE    1                  TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       910-PTNYUINRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
