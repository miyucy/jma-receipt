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
       PROGRAM-ID.                 ORCSRYOCOM.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 療養レセコメント取得サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  06/10/06    NACL−小豆沢  新規作成
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
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-RYOUYOCOM               PIC 9(01).
           03  FLG-RYOYO-NYUIN             PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
      *    添字領域
       01  IDX-AREA.
           03  IDX                         PIC 9(04).
           03  IDX1                        PIC 9(04).
           03  IDX2                        PIC 9(04).
      *
      *    コンスタント値
       01  CONSTANT-AREA.
           03  CONS-RYOYO-NYUIN.
      *        療養病棟入院基本料２（入院基本料Ａ）
               05                          PIC X(09) VALUE "190121310".
      *        療養病棟入院基本料２（入院基本料Ｂ）
               05                          PIC X(09) VALUE "190121410".
      *        療養病棟入院基本料２（入院基本料Ｃ）
               05                          PIC X(09) VALUE "190121510".
      *        療養病棟入院基本料２（入院基本料Ｄ）
               05                          PIC X(09) VALUE "190121610".
      *        療養病棟入院基本料２（入院基本料Ｅ）
               05                          PIC X(09) VALUE "190121710".
      *        療養病棟入院基本料２（特別入院基本料）
               05                          PIC X(09) VALUE "190121810".
      *        療養病棟入院基本料２（入院基本料Ａ）（生活療養）
               05                          PIC X(09) VALUE "190123710".
      *        療養病棟入院基本料２（入院基本料Ｂ）（生活療養）
               05                          PIC X(09) VALUE "190123810".
      *        療養病棟入院基本料２（入院基本料Ｃ）（生活療養）
               05                          PIC X(09) VALUE "190123910".
      *        療養病棟入院基本料２（入院基本料Ｄ）（生活療養）
               05                          PIC X(09) VALUE "190124010".
      *        療養病棟入院基本料２（入院基本料Ｅ）（生活療養）
               05                          PIC X(09) VALUE "190124110".
      *        療養病棟入院基本料２（特別入院基本料）（生活療養）
               05                          PIC X(09) VALUE "190124210".
      *        有床診療所療養病床入院基本料２（入院基本料Ａ）
               05                          PIC X(09) VALUE "190122010".
      *        有床診療所療養病床入院基本料２（入院基本料Ｂ）
               05                          PIC X(09) VALUE "190122110".
      *        有床診療所療養病床入院基本料２（入院基本料Ｃ）
               05                          PIC X(09) VALUE "190122210".
      *        有床診療所療養病床入院基本料２（入院基本料Ｄ）
               05                          PIC X(09) VALUE "190122310".
      *        有床診療所療養病床入院基本料２（入院基本料Ｅ）
               05                          PIC X(09) VALUE "190122410".
      *        有床診療所療養病床入院基本料２（特別入院基本料）
               05                          PIC X(09) VALUE "190122510".
      *        有床診療所療養病床入院基本料２（入院基本料Ａ）（生活療養）
               05                          PIC X(09) VALUE "190124310".
      *        有床診療所療養病床入院基本料２（入院基本料Ｂ）（生活療養）
               05                          PIC X(09) VALUE "190124410".
      *        有床診療所療養病床入院基本料２（入院基本料Ｃ）（生活療養）
               05                          PIC X(09) VALUE "190124510".
      *        有床診療所療養病床入院基本料２（入院基本料Ｄ）（生活療養）
               05                          PIC X(09) VALUE "190124610".
      *        有床診療所療養病床入院基本料２（入院基本料Ｅ）（生活療養）
               05                          PIC X(09) VALUE "190124710".
      *        有床診療所療養病床入院基本料２（特別入院基本料）（生活療養）
               05                          PIC X(09) VALUE "190124810".
           03  CONS-RYOYO-NYUINR      REDEFINES    CONS-RYOYO-NYUIN.
               05  CONS-RYOYO-NYUIN-OCC    OCCURS  24.
                   07  CONS-RYOYO-SRYCD    PIC X(09).
      *
      *    一時領域
       01  WRK-AREA.
      *
      *    診療コード計集計用
           03  WRK-SRYCD-X                 PIC X(09).
           03  WRK-SRYCD-9    REDEFINES    WRK-SRYCD-X
                                           PIC 9(09).
      *
      *    ＡＤＬ点数全角変換領域
       01  TBL-ADLTEN-AREA.
           03  FILLER              PIC X(04)  VALUE "０１".
           03  FILLER              PIC X(04)  VALUE "０２".
           03  FILLER              PIC X(04)  VALUE "０３".
           03  FILLER              PIC X(04)  VALUE "０４".
           03  FILLER              PIC X(04)  VALUE "０５".
           03  FILLER              PIC X(04)  VALUE "０６".
           03  FILLER              PIC X(04)  VALUE "０７".
           03  FILLER              PIC X(04)  VALUE "０８".
           03  FILLER              PIC X(04)  VALUE "０９".
           03  FILLER              PIC X(04)  VALUE "１０".
           03  FILLER              PIC X(04)  VALUE "１１".
           03  FILLER              PIC X(04)  VALUE "１２".
           03  FILLER              PIC X(04)  VALUE "１３".
           03  FILLER              PIC X(04)  VALUE "１４".
           03  FILLER              PIC X(04)  VALUE "１５".
           03  FILLER              PIC X(04)  VALUE "１６".
           03  FILLER              PIC X(04)  VALUE "１７".
           03  FILLER              PIC X(04)  VALUE "１８".
           03  FILLER              PIC X(04)  VALUE "１９".
           03  FILLER              PIC X(04)  VALUE "２０".
           03  FILLER              PIC X(04)  VALUE "２１".
           03  FILLER              PIC X(04)  VALUE "２２".
           03  FILLER              PIC X(04)  VALUE "２３".
           03  FILLER              PIC X(04)  VALUE "２４".
       01  TBL-ADLTEN-AREA-R       REDEFINES  TBL-ADLTEN-AREA.
           03  TBL-ADLTEN          PIC X(04)   OCCURS   24.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
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
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    療養レセプトコメントマスタ−
       01  RYOUYOCOM-REC.
           COPY    "CPRYOCOM.INC".
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
      *    スパ領域
           COPY    "COMMON-SPA".
      *    療養レセコメント取得パラメタ
           COPY    "CPORCSRYOCOM.INC".
      *
       PROCEDURE                   DIVISION    USING
      *     SPA-AREA
           ORCSRYOCOM-AREA
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
           INITIALIZE                  LNK-RYOCOM-HENKYAKU-AREA
           MOVE    ZERO                TO  LNK-RYOCOM-RC
      *
      *    パラメータチェック
           PERFORM 100-PRM-CHK-SEC
           IF    ( LNK-RYOCOM-RC       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
      *    主処理
           IF      LNK-RYOCOM-RC      =    ZERO
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
           IF    ( LNK-RYOCOM-SANTEIYM    =   SPACE )
               MOVE    1               TO  LNK-RYOCOM-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    算定年月チェック
           IF    ( LNK-RYOCOM-SANTEIYM    <   "200610" )
               MOVE    1               TO  LNK-RYOCOM-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *    患者マスター検索
           INITIALIZE                      PTINF-REC
           MOVE    LNK-RYOCOM-HOSPID   TO  PTINF-HOSPID
           MOVE    LNK-RYOCOM-PTID     TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           NOT =   ZERO
               MOVE    2               TO  LNK-RYOCOM-RC
               GO  TO  100-PRM-CHK-EXT
           END-IF
      *
      *
      *    入院中のチェック（入院会計マスター検索）
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-RYOCOM-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-RYOCOM-PTID     TO  NACCT-PTID
           MOVE    LNK-RYOCOM-SANTEIYM TO  NACCT-SRYYM
           MOVE    "5"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           NOT =   ZERO
               MOVE    3               TO  LNK-RYOCOM-RC
           ELSE
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM 910-NYUINACCT-READ-SEC
               IF   FLG-NYUINACCT          NOT =   ZERO
                    MOVE    3              TO  LNK-RYOCOM-RC
               END-IF
           END-IF
      *
      *    入院会計クローズ
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
      *
      *    療養入院算定のチェック（入院会計マスター検索）
           IF      LNK-RYOCOM-RC    =    ZERO
               INITIALIZE                      NYUINACCT-REC
               MOVE    LNK-RYOCOM-HOSPID   TO  NACCT-HOSPID
               MOVE    LNK-RYOCOM-PTID     TO  NACCT-PTID
               MOVE    LNK-RYOCOM-SANTEIYM TO  NACCT-SRYYM
               MOVE    "1"                 TO  NACCT-ZAISKBKBN
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM 910-NYUINACCT-SELECT-SEC
               IF      FLG-NYUINACCT           NOT =   ZERO
                   MOVE    4               TO  LNK-RYOCOM-RC
               ELSE
                   MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
                   MOVE    "key17"             TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-READ-SEC
                   IF   FLG-NYUINACCT          NOT =   ZERO
                        MOVE    4              TO  LNK-RYOCOM-RC
                   ELSE
                        PERFORM   UNTIL  FLG-NYUINACCT    =   1
                            PERFORM   100-PRM-RYOYO-NYUINCHK-SEC
                            MOVE    "tbl_nyuinacct"   TO  MCP-TABLE
                            MOVE    "key17"           TO  MCP-PATHNAME
                            PERFORM 910-NYUINACCT-READ-SEC
                        END-PERFORM
                   END-IF
               END-IF
      *        入院会計クローズ
               MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
               MOVE    "key17"                 TO  MCP-PATHNAME
               PERFORM   910-DB-CLOSE-SEC
      *
               IF   FLG-RYOYO-NYUIN    =   ZERO
                   MOVE    4           TO  LNK-RYOCOM-RC
               END-IF
           END-IF
      *
      *    医療機関情報の取得（ＡＤＬ入力）
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5000"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    LNK-RYOCOM-SANTEIYM TO  SYS-STYUKYMD(1:6)
           MOVE    "01"                TO  SYS-STYUKYMD(7:2)
           MOVE    SYS-STYUKYMD        TO  SYS-EDYUKYMD
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key10"         TO  MCP-PATHNAME
               PERFORM  910-SYSKANRI-READ-SEC
               IF    FLG-SYSKANRI   =    ZERO
                   IF   SYS-5000-ADLINPUTKBN   =   "0"
                       MOVE     5      TO  LNK-RYOCOM-RC
                   END-IF
               END-IF
           END-IF

      *    システム管理クローズ
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    療養病棟（病床）での入院チェック
      *****************************************************************
       100-PRM-RYOYO-NYUINCHK-SEC          SECTION.
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPID        TO  NSRY-HOSPID
           MOVE    NACCT-NYUGAIKBN     TO  NSRY-NYUGAIKBN
           MOVE    NACCT-PTID          TO  NSRY-PTID
           MOVE    NACCT-SRYKA         TO  NSRY-SRYKA
           MOVE    NACCT-SRYYM         TO  NSRY-SRYYM
           MOVE    NACCT-ZAINUM        TO  NSRY-ZAINUM
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-NYUINACT-SELECT-SEC
           IF      FLG-NYUINACT        =   ZERO
               MOVE    "tbl_nyuinact"  TO  MCP-TABLE
               MOVE    "key2"          TO  MCP-PATHNAME
               PERFORM 910-NYUINACT-READ-SEC
               PERFORM   VARYING  IDX   FROM   1   BY  1
                 UNTIL  (IDX      >     24)
                   IF   NSRY-SRYCD(1)   =    CONS-RYOYO-SRYCD(IDX)
                       PERFORM   VARYING  IDX1   FROM   1  BY  1
                         UNTIL  (IDX1    >   31)
                           IF   NACCT-DAY(IDX1)    =   1
                               MOVE "1"  TO  LNK-RYOCOM-NYUINKBN(IDX1)
                               MOVE  1   TO  FLG-RYOYO-NYUIN
                           END-IF
                       END-PERFORM
                   END-IF
               END-PERFORM
           END-IF
      *
           MOVE    "tbl_nyuinact"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       100-PRM-RYOYO-NYUINCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主取得
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *    療養レセプトコメントマスタの情報取得
           INITIALIZE                      RYOUYOCOM-REC
           MOVE    LNK-RYOCOM-HOSPID   TO  RYOCOM-HOSPID
           MOVE    "1"                 TO  RYOCOM-NYUGAIKBN
           MOVE    LNK-RYOCOM-PTID     TO  RYOCOM-PTID
           MOVE    LNK-RYOCOM-SANTEIYM TO  RYOCOM-SRYYM
           MOVE    "tbl_ryocom"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-RYOUYOCOM-SELECT-SEC
           IF      FLG-RYOUYOCOM       NOT =   ZERO
      *         MOVE    5               TO  LNK-RYOCOM-RC
               CONTINUE
           ELSE
               MOVE    "tbl_ryocom"    TO  MCP-TABLE
               MOVE    "key2"          TO  MCP-PATHNAME
               PERFORM 910-RYOUYOCOM-READ-SEC
               IF   FLG-RYOUYOCOM      NOT =   ZERO
      *              MOVE    5          TO  LNK-RYOCOM-RC
                    CONTINUE
               ELSE
                    PERFORM   UNTIL  FLG-RYOUYOCOM    =   1
                        PERFORM   210-RYOCOM-REC-SEC
                        MOVE    "tbl_ryocom"      TO  MCP-TABLE
                        MOVE    "key2"            TO  MCP-PATHNAME
                        PERFORM 910-RYOUYOCOM-READ-SEC
                    END-PERFORM
               END-IF
           END-IF
      *    療養レセプトコメントクローズ
           MOVE    "tbl_ryocom"            TO  MCP-TABLE
           MOVE    "key2"                  TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
      *
      *    取得したＡＤＬ点数を全角変換
           PERFORM   VARYING   IDX   FROM  1  BY  1
             UNTIL   IDX    >   31
               IF   LNK-RYOCOM-NYUINKBN(IDX)  =  "1"
                  MOVE   "840000103"   TO   LNK-RYOCOM-ADL-SRYCD(IDX)
                  ADD    1             TO   LNK-RYOCOM-MEISAISU(IDX)
                  IF   LNK-RYOCOM-ADL-TEN(IDX)   =  ZERO
                      MOVE  "００"     TO
                                       LNK-RYOCOM-ADL-TEN-MOJI(IDX)
                  ELSE
                      MOVE  LNK-RYOCOM-ADL-TEN(IDX)   TO  IDX1
                      MOVE  TBL-ADLTEN(IDX1)
                                   TO  LNK-RYOCOM-ADL-TEN-MOJI(IDX)
                  END-IF
               END-IF
           END-PERFORM
      *
      *    診療コード計の取得
           PERFORM   VARYING   IDX   FROM  1  BY  1
             UNTIL   IDX    >   31
               IF   LNK-RYOCOM-NYUINKBN(IDX)  =  "1"
                  PERFORM   VARYING   IDX1   FROM   1  BY  1
                    UNTIL  (IDX1   >   30)    OR
                           (LNK-RYOCOM-IRYO-SRYCD(IDX IDX1) = SPACE)
                        MOVE   LNK-RYOCOM-IRYO-SRYCD(IDX IDX1)
                                           TO    WRK-SRYCD-X
      *                  ADD    WRK-SRYCD-9 TO
      *                              LNK-RYOCOM-SRYCDTOTAL(IDX)
                        COMPUTE  LNK-RYOCOM-SRYCDTOTAL(IDX)  =
                                 LNK-RYOCOM-SRYCDTOTAL(IDX)  +
                                (WRK-SRYCD-9  *  LNK-RYOCOM-IRYO-ZAINUM
                                                    (IDX IDX1))
                  END-PERFORM
                  MOVE   LNK-RYOCOM-ADL-SRYCD(IDX)  TO  WRK-SRYCD-X
                  ADD    WRK-SRYCD-9   TO  LNK-RYOCOM-SRYCDTOTAL(IDX)
                  COMPUTE   LNK-RYOCOM-SRYCDTOTAL2(IDX)   =
                            LNK-RYOCOM-SRYCDTOTAL(IDX)   +
                            LNK-RYOCOM-ADL-TEN(IDX)
               END-IF
           END-PERFORM
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    療養レセコメントの記録
      *****************************************************************
       210-RYOCOM-REC-SEC            SECTION.
      *
      *    ＡＤＬ点数集計
           IF     (RYOCOM-ZAINUM       >=  1000)     AND
                  (RYOCOM-ZAINUM       <=  1999)
               IF   RYOCOM-MONTH       NOT =     ZERO
                   PERFORM   VARYING  IDX   FROM  1  BY  1
                     UNTIL   IDX      >   31
                       IF   LNK-RYOCOM-NYUINKBN(IDX)  =  "1"
                           ADD   RYOCOM-MONTH  TO
                                        LNK-RYOCOM-ADL-TEN(IDX)
                       END-IF
                   END-PERFORM
               ELSE
                   PERFORM   VARYING  IDX   FROM  1  BY  1
                     UNTIL   IDX      >   31
                       IF   (LNK-RYOCOM-NYUINKBN(IDX)  =  "1")  AND
                            (RYOCOM-DAY(IDX)      NOT =   ZERO)
                           ADD  RYOCOM-DAY(IDX)   TO
                                        LNK-RYOCOM-ADL-TEN(IDX)
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
      *
      *    医療区分集計
           IF     (RYOCOM-ZAINUM       >=  2000)     AND
                  (RYOCOM-ZAINUM       <=  2999)
               IF   RYOCOM-MONTH       NOT =     ZERO
                   PERFORM   VARYING  IDX   FROM  1  BY  1
                     UNTIL   IDX      >   31
                       IF   LNK-RYOCOM-NYUINKBN(IDX)  =  "1"
                           ADD    1   TO    LNK-RYOCOM-MEISAISU(IDX)
                           MOVE   LNK-RYOCOM-MEISAISU(IDX)  TO  IDX2
                           MOVE   RYOCOM-SRYCD  TO
                                        LNK-RYOCOM-IRYO-SRYCD(IDX IDX2)
                           MOVE   RYOCOM-ZAINUM  TO
                                        LNK-RYOCOM-IRYO-ZAINUM(IDX IDX2)
                       END-IF
                   END-PERFORM
               ELSE
                   PERFORM   VARYING  IDX   FROM  1  BY  1
                     UNTIL   IDX      >   31
                       IF   (LNK-RYOCOM-NYUINKBN(IDX)  =  "1")  AND
                            (RYOCOM-DAY(IDX)      NOT =   ZERO)
                           ADD    1   TO    LNK-RYOCOM-MEISAISU(IDX)
                           MOVE   LNK-RYOCOM-MEISAISU(IDX)  TO  IDX2
                           MOVE   RYOCOM-SRYCD  TO
                                        LNK-RYOCOM-IRYO-SRYCD(IDX IDX2)
                           MOVE   RYOCOM-ZAINUM  TO
                                        LNK-RYOCOM-IRYO-ZAINUM(IDX IDX2)
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
      *
           .
       210-RYOCOM-REC-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "tbl_ptinf"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
grpsys         CALL "ORCDBMAIN" USING MCPAREA
                                      MCPDATA-REC
grpsys                                SPA-COMMON
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
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       910-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
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
      *    入院会計マスター検索
      *****************************************************************
       910-NYUINACCT-SELECT-SEC        SECTION.
      *
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
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
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
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
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    NYUINACT-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
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
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
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
      *    療養レセプトコメントマスタ−検索
      *****************************************************************
       910-RYOUYOCOM-SELECT-SEC        SECTION.
      *
grpsys*    MOVE SPA-HOSPNUM TO -HOSPNUM
           MOVE    RYOUYOCOM-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-RYOUYOCOM
           ELSE
               MOVE    1                  TO  FLG-RYOUYOCOM
           END-IF
      *
           .
       910-RYOUYOCOM-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    療養レセプトコメントマスタ−読込
      *****************************************************************
       910-RYOUYOCOM-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  RYOUYOCOM-REC
               MOVE    ZERO               TO  FLG-RYOUYOCOM
           ELSE
               INITIALIZE                     RYOUYOCOM-REC
               MOVE    1                  TO  FLG-RYOUYOCOM
           END-IF
      *
           .
       910-RYOUYOCOM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"      TO  MCP-FUNC
grpsys     CALL "ORCDBMAIN" USING MCPAREA
                                  MCPDATA-REC
grpsys                            SPA-COMMON
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
