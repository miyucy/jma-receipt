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
       PROGRAM-ID.                 ORCSSKJKEEP.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 食事負担据え置き対象取得（平成２８年改定）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  16/02/16    NACL−小豆沢  新規作成
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
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
           03  FLG-TANKI2                  PIC 9(01).
           03  FLG-HKNCOMBI                PIC 9(01).
           03  FLG-TENSU                   PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-SEISIN-CHK              PIC 9(01).
      *    添字領域
       01  IDX-AREA.
           03  IDX                         PIC 9(04).
           03  IDX1                        PIC 9(04).
           03  IDX-ST                      PIC 9(02).
           03  IDX-ED                      PIC 9(02).
           03  IDX-TK3                     PIC 9(02).
           03  IDX-SYS                     PIC 9(03).
      *
      *    コンスタント値
       01  CONSTANT-AREA.
      *    難病公費番号
           03   CONS-NANBYO                PIC X(03) VALUE "054".
      *    小児慢性特定疾患公費番号
           03   CONS-SHOUNI                PIC X(03) VALUE "052".
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-HKNCOMBI-DAY            PIC 9(03)   OCCURS  31.
           03  WRK-GAIHAKU-SRYCD           PIC X(09).
      *
      *    精神病棟の番号退避領域
           03  WRK-CHKBTU-TAIHI-TBL        OCCURS   300.
               05  WRK-CHKBTU-NUM          PIC X(03).
               05  WRK-CHKBTU-STYUKYMD     PIC X(08).
               05  WRK-CHKBTU-EDYUKYMD     PIC X(08).
      *
      *    ２７年４月１日から２８年４月１日に精神病棟入院期間の入院履歴番号
           03  WRK-RRKNUM                  PIC 9(03).
           03  WRK-NYUINYMD                PIC X(08).
           03  WRK-NYUINYMDR   REDEFINES   WRK-NYUINYMD.
               05  WRK-NYUIN-YYMM          PIC 9(06).
               05  WRK-NYUIN-DD            PIC 9(02).
           03  WRK-TAIINYMD                PIC X(08).
           03  WRK-TAIINYMDR   REDEFINES   WRK-TAIINYMD.
               05  WRK-TAIIN-YYMM          PIC 9(06).
               05  WRK-TAIIN-DD            PIC 9(02).
      *
           03  WRK-MATCH                   PIC X(02).
      *
      *    同日再入院日の翌日取得用
           03  WRK-DOUJITSU-YMD            PIC X(08).
           03  WRK-DOUJITSU-YMDR    REDEFINES   WRK-DOUJITSU-YMD.
               05  WRK-DOUJITSU-YYMM       PIC 9(06).
               05  WRK-DOUJITSU-DD         PIC 9(02).
      *
      *    同日再入院日の翌日取得用
           03  WRK-YOKUJITSU-YMD          PIC 9(08).
           03  WRK-YOKUJITSU-YMDR   REDEFINES   WRK-YOKUJITSU-YMD.
               05  WRK-YOKUJITSU-YYMM      PIC 9(06).
               05  WRK-YOKUJITSU-DD        PIC 9(02).
      *
      *    月末日取得用
           03  WRK-GETSUMATSU-YMD.
               05  WRK-GETSUMATSU-YY       PIC 9(04).
               05  WRK-GETSUMATSU-MM       PIC 9(02).
               05  WRK-GETSUMATSU-DD       PIC 9(02).
      *
      *    短期滞在以外で入院料を算定している日
           03  WRK-TANKI-IGAI              PIC X(01)  OCCURS 31.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1001.INC".
           COPY    "CPSK5000.INC".
           COPY    "CPSK5001.INC".
      *
      *    入院診療会計マスタ−
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為マスター
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    診療行為マスター
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    患者入院履歴マスタ−
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
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
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "CPORCSSKJKEEP.INC".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           ORCSSKJKEEP-AREA
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  LNK-SKJKEEP-HENKYAKU-AREA
           MOVE    ZERO            TO  LNK-SKJKEEP-RC
      *
      *    パラメータチェック
           PERFORM 100-PRM-CHK-SEC
           IF    ( LNK-SKJKEEP-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    主処理
           IF      LNK-SKJKEEP-RC      =    ZERO
               PERFORM 200-MAIN-SEC
           END-IF
      *
           PERFORM    VARYING IDX   FROM   1   BY  1
                      UNTIL IDX   >   31
             DISPLAY "IDX = " IDX " LNK-SKJKEEP-KBN = "
                       LNK-SKJKEEP-KBN(IDX)
           END-PERFORM
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
           IF     (LNK-SKJKEEP-SANTEIYM     =  SPACE)      OR
                  (LNK-SKJKEEP-SANTEIYM    <=  "201603")
               MOVE    1                  TO  LNK-SKJKEEP-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    患者マスター検索
           INITIALIZE                         PTINF-REC
           MOVE    LNK-SKJKEEP-HOSPNUM     TO  PTINF-HOSPNUM
           MOVE    LNK-SKJKEEP-PTID        TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF              NOT =   ZERO
               MOVE    2                  TO  LNK-SKJKEEP-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    入院中のチェック（入院会計の保険組合せ検索）
           INITIALIZE                         NYUINACCT-REC
           MOVE    LNK-SKJKEEP-HOSPNUM     TO  NACCT-HOSPNUM
           MOVE    LNK-SKJKEEP-PTID        TO  NACCT-PTID
           MOVE    LNK-SKJKEEP-SANTEIYM    TO  NACCT-SRYYM
           MOVE    "5"                    TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"        TO  MCP-TABLE
           MOVE    "key17"                TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT          NOT =   ZERO
               MOVE    3                  TO  LNK-SKJKEEP-RC
           ELSE
               MOVE    "tbl_nyuinacct"    TO  MCP-TABLE
               MOVE    "key17"            TO  MCP-PATHNAME
               PERFORM 910-NYUINACCT-READ-SEC
               IF   FLG-NYUINACCT         NOT =   ZERO
                    MOVE    3             TO  LNK-SKJKEEP-RC
               ELSE
                   PERFORM    VARYING IDX   FROM   1   BY  1
                      UNTIL IDX   >   31
                        IF  NACCT-DAY(IDX)  NOT =   ZERO
                            MOVE  NACCT-DAY(IDX)
                                          TO   WRK-HKNCOMBI-DAY(IDX)
                        END-IF
                   END-PERFORM
               END-IF
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"        TO  MCP-TABLE
           MOVE    "key17"                TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主取得
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *    月末日を取得
           INITIALIZE                         STS-AREA-DAY
           INITIALIZE                         LNK-DAY7-AREA
           MOVE    "71"                   TO  LNK-DAY7-IRAI
           MOVE    LNK-SKJKEEP-SANTEIYM
                                          TO  LNK-DAY7-YM
           CALL    "ORCSDAY"          USING   STS-AREA-DAY
                                              LNK-DAY7-AREA
           IF      STS-DAY-RC1            =   ZERO
               MOVE    LNK-DAY7-KOYOMI    TO  WRK-GETSUMATSU-YMD
           END-IF
      *
      *    精神病床長期入院の判定は病院だけなので、システム管理テーブル
      *    を判定
           MOVE    ZERO                TO  FLG-SEISIN-CHK
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1001"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    LNK-SKJKEEP-SANTEIYM
                                       TO  SYS-STYUKYMD(1:6)
           MOVE    "01"                TO  SYS-STYUKYMD(7:2)
           MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
           MOVE    LNK-SKJKEEP-HOSPNUM
                                       TO  SYS-HOSPNUM
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   910-SYSKANRI-SELECT-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key10"         TO  MCP-PATHNAME
               PERFORM  910-SYSKANRI-READ-SEC
               IF   FLG-SYSKANRI       =   ZERO
                  MOVE   SYSKANRI-REC  TO  SYS-1001-REC
                  IF     SYS-1001-HOSPSBT  =   1
                      MOVE   1         TO  FLG-SEISIN-CHK
                  END-IF
               END-IF
           END-IF
      *    システム管理クローズ
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
      *
      *    入院履歴より２７年４月１日以前から２８年４月１まで継続して
      *    精神病床に入院しているか判定
           IF    FLG-SEISIN-CHK     =     1
               PERFORM    210-SEISIN-CHK-SEC
           END-IF
      *
      *    難病等の入院判定（診療行為で難病等に関わる診療が有る場合も対象）
           PERFORM    220-NANBYO-CHK-SEC
      *
      *
      *
      **     PERFORM   VARYING  IDX    FROM  1  BY  1 
      **       UNTIL   IDX   >   31
      **         DISPLAY "IDX = " IDX
      **         DISPLAY "LNK-SKJKEEP-KBN = " LNK-SKJKEEP-KBN(IDX)
      **         DISPLAY "LNK-SKJKEEP-TANKI2-KBN = "
      **                  LNK-SKJKEEP-TANKI2-KBN(IDX)
      **       DISPLAY "DOUJITSU = " LNK-SKJKEEP-DOUJITSU-KBN(IDX)
      **       DISPLAY "HKNHEN   = " LNK-SKJKEEP-DOUJITSU-HKNHENKBN(IDX)
      **       DISPLAY "TAI-SKJ  = " LNK-SKJKEEP-DOUJITSU-T-SKJKBN(IDX)
      **       DISPLAY "TAI-HKN  = " LNK-SKJKEEP-DOUJITSU-T-HKNCOMBI(IDX)
      **       DISPLAY "TAI-HKNSYU=" LNK-SKJKEEP-DOUJITSU-T-HKNSYU(IDX)
      **       DISPLAY "NYU-SKJ  = " LNK-SKJKEEP-DOUJITSU-SKJKBN(IDX)
      **       DISPLAY "NYU-HKN  = " LNK-SKJKEEP-DOUJITSU-HKNCOMBI(IDX)
      **       DISPLAY "NYU-HKNSYU=" LNK-SKJKEEP-DOUJITSU-HKNSYU(IDX)
      **     END-PERFORM
      **     DISPLAY   "WRK-YOKUJITSU-YMD = " WRK-YOKUJITSU-YMD
      *
      *     IF       LNK-SKJKEEP-TBL   =    SPACE
      *         MOVE     4              TO   LNK-SKJKEEP-RC
      *     END-IF
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    精神病床据え置き判定
      *****************************************************************
       210-SEISIN-CHK-SEC            SECTION.
      *
      *    事前に病棟情報（システム管理）から精神病棟の病棟番号を
      *    取得しておく
           MOVE    ZERO                TO  IDX-SYS
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5001"              TO  SYS-KANRICD
           MOVE    LNK-SKJKEEP-HOSPNUM
                                       TO  SYS-HOSPNUM
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM   910-SYSKANRI-SELECT-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key5"          TO  MCP-PATHNAME
               PERFORM  910-SYSKANRI-READ-SEC
               PERFORM  UNTIL  (FLG-SYSKANRI   =   1)  OR
                               (IDX-SYS        =   300)
                 MOVE   SYSKANRI-REC   TO  SYS-5001-REC
                 IF   SYS-5001-BTU-SBT =   "02"
                    ADD    1           TO  IDX-SYS
                    MOVE   SYS-5001-KBNCD(1:2)
                                       TO  WRK-CHKBTU-NUM(IDX-SYS)
                    MOVE   SYS-5001-STYUKYMD
                                       TO  WRK-CHKBTU-STYUKYMD(IDX-SYS)
                    MOVE   SYS-5001-EDYUKYMD
                                       TO  WRK-CHKBTU-EDYUKYMD(IDX-SYS)
                 END-IF
                 MOVE    "tbl_syskanri" TO  MCP-TABLE
                 MOVE    "key5"         TO  MCP-PATHNAME
                 PERFORM  910-SYSKANRI-READ-SEC
               END-PERFORM
           END-IF
      *    システム管理クローズ
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           DISPLAY "WRK-CHKBTU-NUM(1) = " WRK-CHKBTU-NUM(1)
           DISPLAY "WRK-CHKBTU-NUM(2) = " WRK-CHKBTU-NUM(2)
           DISPLAY "WRK-CHKBTU-NUM(3) = " WRK-CHKBTU-NUM(3)
           DISPLAY "WRK-CHKBTU-NUM(4) = " WRK-CHKBTU-NUM(4)
           DISPLAY "WRK-CHKBTU-NUM(5) = " WRK-CHKBTU-NUM(5)
      *
      *    入院履歴より２７年４月１日以前から２８年４月１日まで継続して
      *    精神病床に入院しているか判定
           MOVE    ZERO                   TO  WRK-RRKNUM
           INITIALIZE                         PTNYUINRRK-REC
           MOVE    LNK-SKJKEEP-HOSPNUM    TO  PTNYUINRRK-HOSPNUM
           MOVE    LNK-SKJKEEP-PTID       TO  PTNYUINRRK-PTID
           MOVE    "20150401"             TO  PTNYUINRRK-NYUINYMD
           MOVE    "20160401"             TO  PTNYUINRRK-TAIINYMD
           MOVE    "tbl_ptnyuinrrk"       TO  MCP-TABLE
           MOVE    "key24"                TO  MCP-PATHNAME
           PERFORM 910-PTNYUINRRK-SELECT-SEC
           IF      FLG-PTNYUINRRK         =   ZERO
               MOVE    "tbl_ptnyuinrrk"   TO  MCP-TABLE
               MOVE    "key24"            TO  MCP-PATHNAME
               PERFORM   910-PTNYUINRRK-READ-SEC
               DISPLAY    "========  FLG-PTNYUINRRK(1) = "
                                     FLG-PTNYUINRRK
               IF      FLG-PTNYUINRRK     =   ZERO
                   MOVE    PTNYUINRRK-RRKNUM     TO  WRK-RRKNUM
                   MOVE    PTNYUINRRK-NYUINYMD   TO  WRK-NYUINYMD
                   MOVE    PTNYUINRRK-TAIINYMD   TO  WRK-TAIINYMD
      *
                   INITIALIZE                        PTNYUINRRK-REC
                   MOVE    LNK-SKJKEEP-HOSPNUM   TO  PTNYUINRRK-HOSPNUM
                   MOVE    LNK-SKJKEEP-PTID      TO  PTNYUINRRK-PTID
                   MOVE    WRK-RRKNUM            TO  PTNYUINRRK-RRKNUM
                   MOVE    "tbl_ptnyuinrrk"      TO  MCP-TABLE
                   MOVE    "key67"               TO  MCP-PATHNAME
                   PERFORM 910-PTNYUINRRK-SELECT-SEC
                   IF      FLG-PTNYUINRRK         =   ZERO
                       MOVE    "tbl_ptnyuinrrk"   TO  MCP-TABLE
                       MOVE    "key67"            TO  MCP-PATHNAME
                       PERFORM   910-PTNYUINRRK-READ-SEC
                       DISPLAY    "========  FLG-PTNYUINRRK(2) = "
                                             FLG-PTNYUINRRK
                       PERFORM   UNTIL   (FLG-PTNYUINRRK   =   1)  OR
                                         (WRK-MATCH        =  "NG")
                           MOVE     SPACE             TO  WRK-MATCH
                           DISPLAY "PTNYUINRRK-RRKNUM = "
                                    PTNYUINRRK-RRKNUM
                           DISPLAY "PTNYUINRRK-TENNYUYMD = "
                                    PTNYUINRRK-TENNYUYMD
                           DISPLAY "PTNYUINRRK-TENSTUYMD = "
                                    PTNYUINRRK-TENSTUYMD
                           IF ((PTNYUINRRK-TENNYUYMD  <= "20150401") AND
                               (PTNYUINRRK-TENSTUYMD  >= "20150401"))
                                                                     OR
                              ((PTNYUINRRK-TENNYUYMD  >= "20150401") AND
                               (PTNYUINRRK-TENSTUYMD  <= "20160401"))
                                                                     OR
                              ((PTNYUINRRK-TENNYUYMD  <= "20160401") AND
                               (PTNYUINRRK-TENSTUYMD  >= "20160401"))
                               PERFORM    VARYING   IDX1  FROM  1  BY  1
                                 UNTIL   (IDX1      >     IDX-SYS)
                                  IF   WRK-CHKBTU-NUM(IDX1)  = 
                                                      PTNYUINRRK-BTUNUM
                                      MOVE   "OK"     TO   WRK-MATCH
                                  END-IF
                               END-PERFORM
                               IF    WRK-MATCH         =   SPACE
                                   MOVE   "NG"         TO  WRK-MATCH
                               END-IF
                           END-IF
                           MOVE    "tbl_ptnyuinrrk"   TO  MCP-TABLE
                           MOVE    "key67"            TO  MCP-PATHNAME
                           PERFORM 910-PTNYUINRRK-READ-SEC
                       END-PERFORM
                   END-IF
      *
      *            患者入院履歴クローズ
                   MOVE    "tbl_ptnyuinrrk"        TO  MCP-TABLE
                   MOVE    "key67"                 TO  MCP-PATHNAME
                   PERFORM   900-CLOSE-SEC
               END-IF
           END-IF
      *
      *    患者入院履歴クローズ
           MOVE    "tbl_ptnyuinrrk"        TO  MCP-TABLE
           MOVE    "key24"                 TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           DISPLAY    "WRK-MATCH = " WRK-MATCH
      *
           IF        WRK-MATCH           =      "OK"
               IF    WRK-TAIINYMD        =   "99999999"
                   PERFORM    VARYING   IDX1  FROM  1  BY  1
                     UNTIL   (IDX1      >     WRK-GETSUMATSU-DD)
                        MOVE   "2"      TO    LNK-SKJKEEP-KBN(IDX1)
                   END-PERFORM
               ELSE
                   IF    WRK-TAIIN-YYMM  <    LNK-SKJKEEP-SANTEIYM
                       CONTINUE
                   ELSE
                     IF  WRK-TAIIN-YYMM  >    LNK-SKJKEEP-SANTEIYM
                         PERFORM    VARYING   IDX1  FROM  1  BY  1
                            UNTIL   (IDX1      >     WRK-GETSUMATSU-DD)
                            MOVE   "2"      TO    LNK-SKJKEEP-KBN(IDX1)
                         END-PERFORM
                     ELSE
      *                  退院月＝算定月
                         PERFORM    VARYING   IDX1  FROM  1  BY  1
                            UNTIL   (IDX1      >     WRK-TAIIN-DD)
                            MOVE   "2"      TO    LNK-SKJKEEP-KBN(IDX1)
                         END-PERFORM
                     END-IF
                   END-IF
               END-IF
           END-IF
           .
       210-SEISIN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    難病等公費診療を判定
      *****************************************************************
       220-NANBYO-CHK-SEC            SECTION.
      *
      *    入院会計テーブル（初期処理で参照した保険組合せから）
           PERFORM    VARYING IDX1   FROM   1   BY  1
             UNTIL    IDX1   >   31
                IF  WRK-HKNCOMBI-DAY(IDX1)  NOT =   ZERO
                    INITIALIZE                    HKNCOMBI-REC
                    MOVE   LNK-SKJKEEP-HOSPNUM    TO  COMB-HOSPNUM
                    MOVE   LNK-SKJKEEP-PTID       TO  COMB-PTID
                    MOVE   WRK-HKNCOMBI-DAY(IDX1) TO  COMB-HKNCOMBINUM
                    MOVE   "tbl_hkncombi"         TO  MCP-TABLE
                    MOVE    "key"                 TO  MCP-PATHNAME
                    PERFORM 910-HKNCOMBI-SELECT-SEC
                    IF   FLG-HKNCOMBI       =   ZERO
                         MOVE  "tbl_hkncombi"     TO  MCP-TABLE
                         MOVE  "key"              TO  MCP-PATHNAME
                         PERFORM   910-HKNCOMBI-READ-SEC
                         IF  FLG-HKNCOMBI         =  ZERO
                             IF  (COMB-KOHHKNNUM(1) = "054")  OR
                                 (COMB-KOHHKNNUM(2) = "054")  OR
                                 (COMB-KOHHKNNUM(3) = "054")  OR
                                 (COMB-KOHHKNNUM(4) = "054")
                                MOVE   "1"  TO   LNK-SKJKEEP-KBN(IDX1)
                             END-IF
                             IF  (COMB-KOHHKNNUM(1) = "052")  OR
                                 (COMB-KOHHKNNUM(2) = "052")  OR
                                 (COMB-KOHHKNNUM(3) = "052")  OR
                                 (COMB-KOHHKNNUM(4) = "052")
                                MOVE   "1"  TO   LNK-SKJKEEP-KBN(IDX1)
                             END-IF
                         END-IF
                    END-IF
      *             保険組合せクローズ
                    MOVE    "tbl_hkncombi"  TO  MCP-TABLE
                    MOVE    "key"           TO  MCP-PATHNAME
                    PERFORM   900-CLOSE-SEC
                END-IF
           END-PERFORM
      *
           .
       220-NANBYO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院診療行為取得
      *****************************************************************
       210-NYUINACT-GET-SEC            SECTION.
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPNUM       TO  NSRY-HOSPNUM
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-NYUINACT-SELECT-SEC
           IF      FLG-NYUINACT        =   ZERO
               MOVE    "tbl_nyuinact"  TO  MCP-TABLE
               MOVE    "key9"          TO  MCP-PATHNAME
               PERFORM   910-NYUINACT-READ-SEC
           END-IF
      *
      *    入院行為クローズ
           MOVE     "tbl_nyuinact"     TO  MCP-TABLE
           MOVE     "key9"             TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           .
       210-NYUINACT-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター検索
      *****************************************************************
       910-SYSKANRI-SELECT-SEC        SECTION.
      *
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-SYSKANRI
           ELSE
               MOVE    1                  TO  FLG-SYSKANRI
           END-IF
      *
           .
       910-SYSKANRI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       910-SYSKANRI-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  SYSKANRI-REC
               MOVE    ZERO               TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                     SYSKANRI-REC
               MOVE    1                  TO  FLG-SYSKANRI
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
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptinf"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM   900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC TO  PTINF-REC
                   MOVE    ZERO        TO  FLG-PTINF
               ELSE
                   INITIALIZE              PTINF-REC
                   MOVE    1           TO  FLG-PTINF
               END-IF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者入院履歴マスター検索
      *****************************************************************
       910-PTNYUINRRK-SELECT-SEC        SECTION.
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
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
       910-PTNYUINRRK-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PTNYUINRRK-REC
               MOVE    ZERO                TO  FLG-PTNYUINRRK
           ELSE
               INITIALIZE                      PTNYUINRRK-REC
               MOVE    1                   TO  FLG-PTNYUINRRK
           END-IF
      *
           .
       910-PTNYUINRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター検索
      *****************************************************************
       910-NYUINACCT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
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
           PERFORM   900-DBFETCH-SEC
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
           PERFORM   900-DBSELECT-SEC
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
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  NYUINACT-REC
               MOVE    ZERO                TO  FLG-NYUINACT
           ELSE
               INITIALIZE                      NYUINACT-REC
               MOVE    1                   TO  FLG-NYUINACT
           END-IF
           .
       910-NYUINACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスター検索
      *****************************************************************
       910-SRYACCT-SELECT-SEC        SECTION.
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-SRYACCT
           ELSE
               MOVE    1                  TO  FLG-SRYACCT
           END-IF
      *
           .
       910-SRYACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスター読込
      *****************************************************************
       910-SRYACCT-READ-SEC        SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  SRYACCT-REC
               MOVE    ZERO               TO  FLG-SRYACCT
           ELSE
               INITIALIZE                     SRYACCT-REC
               MOVE    1                  TO  FLG-SRYACCT
           END-IF
      *
           .
       910-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター検索
      *****************************************************************
       910-SRYACT-SELECT-SEC        SECTION.
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-SRYACT
           ELSE
               MOVE    1                  TO  FLG-SRYACT
           END-IF
      *
           .
       910-SRYACT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター読込
      *****************************************************************
       910-SRYACT-READ-SEC         SECTION.
      *
           PERFORM   900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACT-REC
               MOVE    ZERO                TO  FLG-SRYACT
           ELSE
               INITIALIZE                      SRYACT-REC
               MOVE    1                   TO  FLG-SRYACT
           END-IF
      *
           .
       910-SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター検索
      *****************************************************************
       910-HKNCOMBI-SELECT-SEC        SECTION.
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           PERFORM   900-DBSELECT-SEC
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
           PERFORM   900-DBFETCH-SEC
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
      *    点数マスター読込（主キー）
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_tensu"     TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM   900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC TO  TNS-TENSU-REC
                   MOVE    ZERO        TO  FLG-TENSU
               ELSE
                   MOVE    1           TO  FLG-TENSU
                   INITIALIZE              TNS-TENSU-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM   900-CLOSE-SEC
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"      TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
      *
           .
      *
       900-CLOSE-EXT.
           EXIT.
