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
       PROGRAM-ID.             ORCSFTNJGNCHK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 患者自己負担金レセプト記載判定
      *  管理者            : 
      *  作成日付    作業者        記述
      *****************************************************************
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
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-PTKOHFTN        PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-HKNMST-JGNGAK  PIC 9(06).
           03  WRK-KOHFTN         PIC 9(10).
           03  WRK-PREFNUM        PIC 9(02).
      *
      *    共通領域
           COPY    "MCPAREA".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    患者公費負担
       01  PTKOHFTN-REC.
           COPY    "CPPTKOHFTN.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    システム管理
           COPY    "CPSK1001.INC".
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSFTNJGNCHK.INC".
      *
       PROCEDURE                    DIVISION    USING
           ORCSFTNJGNCHKAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           MOVE    ZERO                TO  LNK-FTNJGNCHK-RC
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
      *    パラメータチェック
           PERFORM   100-PRM-CHK-SEC
           IF       (LNK-FTNJGNCHK-RC   NOT =   ZERO)
               GO   TO   000-PROC-EXT
           END-IF
      *
           IF    LNK-FTNJGNCHK-RC      =   ZERO
               PERFORM   200-MAIN-SEC
           END-IF
           .
       000-PROC-EXT.
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    パラメータチェック
      *****************************************************************
       100-PRM-CHK-SEC                     SECTION.
      *
      *    患者マスター検索
           INITIALIZE                      PTINF-REC
           MOVE    LNK-FTNJGNCHK-HOSPID    TO  PTINF-HOSPID
           MOVE    LNK-FTNJGNCHK-PTID      TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           NOT =   ZERO
               MOVE    10              TO  LNK-FTNJGNCHK-RC
           END-IF
      *
           IF    LNK-FTNJGNCHK-KOHNUM   = SPACE
               MOVE    10              TO  LNK-FTNJGNCHK-RC
           END-IF
      *
           IF    LNK-FTNJGNCHK-KOHID    =  ZERO
               MOVE    10              TO  LNK-FTNJGNCHK-RC
           END-IF
      *
      *    県番号取得
           INITIALIZE                      SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    LNK-FTNJGNCHK-SRYYM TO  ORC-DBYMD(1:6)
           MOVE    "01"                TO  ORC-DBYMD(7:2)
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"    USING    MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC               =  ZERO
               MOVE     "SYSKANRI-KEY" TO  ORC-DBPATH
               PERFORM   SYSKANRI-READ-SEC
               MOVE      SYS-1001-PREFNUM
                                       TO  WRK-PREFNUM
           END-IF
      *    システム管理クローズ
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       100-PRM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主取得
      *****************************************************************
       200-MAIN-SEC            SECTION.
      *
      *    保険番号マスタからレセプト表示区分と負担上限額の取得
           PERFORM    210-HKNNUM-GET-SEC
      *
           IF    HKN-RECEJGNDSPKBN    =   "1"
      *        患者公費負担マスタから負担上限額の取得
               PERFORM    210-PTKOHFTN-GET-SEC
      *        保険の上限額と収納の負担額を比較判定
               PERFORM    210-HANTEI-SEC
           END-IF
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスタからレセプト表示区分と負担上限額の取得
      *****************************************************************
       210-HKNNUM-GET-SEC       SECTION.
      *
           INITIALIZE                           HKNNUM-REC
           MOVE    LNK-FTNJGNCHK-HOSPID TO      HKN-HOSPID
           MOVE    LNK-FTNJGNCHK-KOHNUM TO      HKN-HKNNUM
           MOVE    "HKNNUM-KEY2"        TO      ORC-DBPATH
           PERFORM  910-HKNNUM-SELECT-SEC
           IF      FLG-HKNNUM           =       ZERO
               MOVE    "HKNNUM-KEY2"    TO      ORC-DBPATH
               PERFORM  910-HKNNUM-READ-SEC
               PERFORM  UNTIL
                   ( FLG-HKNNUM          =   1   )   OR
                   ((HKN-TEKSTYMD(1:6)
                                  <=   LNK-FTNJGNCHK-SRYYM) AND
                    (LNK-FTNJGNCHK-SRYYM
                                  <=   HKN-TEKEDYMD(1:6)))
                      PERFORM   910-HKNNUM-READ-SEC
                    END-PERFORM
           END-IF
      *
           IF   FLG-HKNNUM     =    ZERO
               IF    HKN-HON-GAIMNAIJGNGAK   NOT =    ZERO
                   MOVE   HKN-HON-GAIMNAIJGNGAK  TO  WRK-HKNMST-JGNGAK
               END-IF
               IF    HKN-HON-GAIMGAIJGNGAK   NOT =    ZERO
                   MOVE   HKN-HON-GAIMGAIJGNGAK  TO  WRK-HKNMST-JGNGAK
               END-IF
           END-IF
      *
      *    保険番号クローズ
           MOVE    "HKNNUM-KEY2"             TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       210-HKNNUM-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費負担マスタから負担上限額の取得
      *****************************************************************
       210-PTKOHFTN-GET-SEC       SECTION.
      *
           IF ( LNK-FTNJGNCHK-KOHNUM         = "015" OR "016" 
                                                     OR "012"      )
      *
           OR ((LNK-FTNJGNCHK-KOHNUM         = "051"   )  AND
               (LNK-FTNJGNCHK-SRYYM         >= "200310")           )
      *
           OR ((WRK-PREFNUM                  =  13            )  AND
               (LNK-FTNJGNCHK-KOHNUM         = "151" OR "451" )  AND
               (LNK-FTNJGNCHK-SRYYM         >= "200310")           )
      *
                INITIALIZE                           PTKOHFTN-REC
                MOVE    LNK-FTNJGNCHK-HOSPID TO      PTKOHFTN-HOSPID
                MOVE    LNK-FTNJGNCHK-PTID   TO      PTKOHFTN-PTID
                MOVE    LNK-FTNJGNCHK-KOHID  TO      PTKOHFTN-KOHID
                MOVE    "PTKOHFTN-KEY4"      TO      ORC-DBPATH
                PERFORM  910-PTKOHFTN-SELECT-SEC
                IF      FLG-PTKOHFTN         =       ZERO
                    MOVE    "PTKOHFTN-KEY4"  TO      ORC-DBPATH
                    PERFORM  910-PTKOHFTN-READ-SEC
                    PERFORM  UNTIL
                       ( FLG-PTKOHFTN                 =   1   )   OR
                       ((PTKOHFTN-TEKSTYMD(1:6)
                                  <=   LNK-FTNJGNCHK-SRYYM    ) AND
                        (LNK-FTNJGNCHK-SRYYM
                                  <=   PTKOHFTN-TEKEDYMD(1:6)))
                      PERFORM   910-PTKOHFTN-READ-SEC
                    END-PERFORM
                ELSE
                    MOVE    1                TO      FLG-PTKOHFTN
                END-IF
      *
      *         公費上限額セット（暫定）
                IF   FLG-PTKOHFTN  =  ZERO
                    MOVE  PTKOHFTN-GAIJGNGAK  TO  WRK-HKNMST-JGNGAK
                END-IF
      *
      **          IF   FLG-PTKOHFTN  =  ZERO
      **             EVALUATE   KOH-IDX
      **                WHEN  1
      **                  MOVE   PTKOHFTN-GAIJGNGAK  TO   MAX-KIN-KOHI1-M
      **                  MOVE     "1"   TO    COMB-KOH1-GAIJGNKBN
      **                  IF  (LNK-S01-KOUREI-ZAITAKU-KBN   =   "1" ) OR
      **                      (FLG-KOUREI-KBN               =   "1" )
      **                    IF  ( WK-1001-PREFNUM        =     20)
      **                    AND ( COMB-KOH1HKNNUM(1:1)   >=   "1")
      **                    AND ( COMB-KOH1HKNNUM(1:1)   <=   "8")
      **                      CONTINUE
      **                    ELSE
      **                      IF    MAX-KIN-KOHI1-M    >  12000
      **                        MOVE    12000    TO   MAX-KIN-KOHI1-M
      **                      END-IF
      **                      IF    FLG-CHIHOU(1)      =  "1"
      **                         MOVE   SPACE    TO   FLG-CHIHOU(1)
      **                      END-IF
      **                    END-IF
      **                  END-IF
      **                WHEN  2
      **                  MOVE   PTKOHFTN-GAIJGNGAK  TO   MAX-KIN-KOHI2-M
      **                  MOVE     "1"   TO    COMB-KOH2-GAIJGNKBN
      **                  IF  (LNK-S01-KOUREI-ZAITAKU-KBN   =   "1" ) OR
      **                      (FLG-KOUREI-KBN               =   "1" )
      **                    IF  ( WK-1001-PREFNUM        =     20)
      **                    AND ( COMB-KOH2HKNNUM(1:1)   >=   "1")
      **                    AND ( COMB-KOH2HKNNUM(1:1)   <=   "8")
      **                      CONTINUE
      **                    ELSE
      **                      IF    MAX-KIN-KOHI2-M    >  12000
      **                        MOVE    12000    TO   MAX-KIN-KOHI2-M
      **                      END-IF
      **                      IF    FLG-CHIHOU(2)      =  "1"
      **                         MOVE   SPACE    TO   FLG-CHIHOU(2)
      **                      END-IF
      **                    END-IF
      **                  END-IF
      **                WHEN  3
      **                  MOVE   PTKOHFTN-GAIJGNGAK  TO   MAX-KIN-KOHI3-M
      **                  MOVE     "1"   TO    COMB-KOH3-GAIJGNKBN
      **                  IF  (LNK-S01-KOUREI-ZAITAKU-KBN   =   "1" ) OR
      **                      (FLG-KOUREI-KBN               =   "1" )
      **                    IF  ( WK-1001-PREFNUM        =     20)
      **                    AND ( COMB-KOH3HKNNUM(1:1)   >=   "1")
      **                    AND ( COMB-KOH3HKNNUM(1:1)   <=   "8")
      **                      CONTINUE
      **                    ELSE
      **                      IF    MAX-KIN-KOHI3-M    >  12000
      **                        MOVE    12000    TO   MAX-KIN-KOHI3-M
      **                      END-IF
      **                      IF    FLG-CHIHOU(3)      =  "1"
      **                         MOVE   SPACE    TO   FLG-CHIHOU(3)
      **                      END-IF
      **                    END-IF
      **                  END-IF
      **                WHEN  4
      **                  MOVE   PTKOHFTN-GAIJGNGAK  TO   MAX-KIN-KOHI4-M
      **                  MOVE     "1"   TO    COMB-KOH4-GAIJGNKBN
      **                  IF  (LNK-S01-KOUREI-ZAITAKU-KBN   =   "1" ) OR
      **                      (FLG-KOUREI-KBN               =   "1" )
      **                    IF  ( WK-1001-PREFNUM        =     20)
      **                    AND ( COMB-KOH4HKNNUM(1:1)   >=   "1")
      **                    AND ( COMB-KOH4HKNNUM(1:1)   <=   "8")
      **                      CONTINUE
      **                    ELSE
      **                      IF    MAX-KIN-KOHI4-M    >  12000
      **                        MOVE    12000    TO   MAX-KIN-KOHI4-M
      **                      END-IF
      **                      IF    FLG-CHIHOU(4)      =  "1"
      **                         MOVE   SPACE    TO   FLG-CHIHOU(4)
      **                      END-IF
      **                    END-IF
      **                  END-IF
      **             END-EVALUATE
      **          END-IF
      *
      *        患者公費負担クローズ
               MOVE    "PTKOHFTN-KEY4"             TO  ORC-DBPATH
               PERFORM   910-DB-CLOSE-SEC
      *
           END-IF
           .
       210-PTKOHFTN-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険の上限額と収納の負担額を比較判定
      *****************************************************************
       210-HANTEI-SEC            SECTION.
      *
      *収納マスタから該当公費の患者負担額チェック
           MOVE    LNK-FTNJGNCHK-HOSPID    TO  SYU-HOSPID
           MOVE    LNK-FTNJGNCHK-PTID      TO  SYU-PTID
           MOVE    LNK-FTNJGNCHK-NYUGAIKBN TO  SYU-NYUGAIKBN
           MOVE    LNK-FTNJGNCHK-SRYYM     TO  SYU-SRYYMD(1:6)
           MOVE    "__"                    TO  SYU-SRYYMD(7:2)
           MOVE    LNK-FTNJGNCHK-KOHNUM    TO  SYU-KOH-HKNNUM(1)
           MOVE    LNK-FTNJGNCHK-KOHNUM    TO  SYU-KOH-HKNNUM(2)
           MOVE    LNK-FTNJGNCHK-KOHNUM    TO  SYU-KOH-HKNNUM(3)
           MOVE    LNK-FTNJGNCHK-KOHNUM    TO  SYU-KOH-HKNNUM(4)
           MOVE    "SYUNOU-KEY25"          TO  ORC-DBPATH
           PERFORM 910-SYUNOU-SELECT-SEC
           IF      FLG-SYUNOU              NOT =   ZERO
               MOVE    01                  TO  LNK-FTNJGNCHK-RC
               GO  TO  210-HANTEI-EXT
           ELSE
               MOVE    "SYUNOU-KEY25"      TO  ORC-DBPATH
               PERFORM 910-SYUNOU-READ-SEC
               IF   FLG-SYUNOU             =   ZERO
      *            患者負担金の集計
                   MOVE      ZERO          TO      WRK-KOHFTN
                   PERFORM   UNTIL    FLG-SYUNOU  =   1
                       EVALUATE   LNK-FTNJGNCHK-KOHNUM
                           WHEN   SYU-KOH-HKNNUM(1)
                               ADD    SYU-KOH-HKNFTNMONEY(1)
                                                   TO   WRK-KOHFTN
                           WHEN   SYU-KOH-HKNNUM(2)
                               ADD    SYU-KOH-HKNFTNMONEY(2)
                                                   TO   WRK-KOHFTN
                           WHEN   SYU-KOH-HKNNUM(3)
                               ADD    SYU-KOH-HKNFTNMONEY(3)
                                                   TO   WRK-KOHFTN
                           WHEN   SYU-KOH-HKNNUM(4)
                               ADD    SYU-KOH-HKNFTNMONEY(4)
                                                   TO   WRK-KOHFTN
                       END-EVALUATE
                       MOVE    "SYUNOU-KEY25"   TO  ORC-DBPATH
                       PERFORM  910-SYUNOU-READ-SEC
                   END-PERFORM
                   IF   WRK-HKNMST-JGNGAK       >   WRK-KOHFTN
                        MOVE   01               TO  LNK-FTNJGNCHK-RC
                   END-IF
               END-IF
           END-IF
      *
      *    収納クローズ
           MOVE    "SYUNOU-KEY25"           TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
           .
       210-HANTEI-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    システム管理マスター読込
      *****************************************************************
       SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                  SYS-1001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC               =   ZERO
               MOVE    "DBFETCH"        TO  MCP-FUNC
               MOVE    "PTINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"      USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
               IF      MCP-RC           =   ZERO
                   MOVE    MCPDATA-REC  TO  PTINF-REC
                   MOVE    ZERO         TO  FLG-PTINF
               ELSE
                   INITIALIZE               PTINF-REC
                   MOVE    1            TO  FLG-PTINF
               END-IF
           ELSE
               INITIALIZE                   PTINF-REC
               MOVE    1                TO  FLG-PTINF
           END-IF
      *
           MOVE    "PTINF-KEY"          TO  ORC-DBPATH
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスター検索
      *****************************************************************
       910-SYUNOU-SELECT-SEC        SECTION.
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO               TO  FLG-SYUNOU
           ELSE
               MOVE    1                  TO  FLG-SYUNOU
           END-IF
      *
           .
       910-SYUNOU-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       910-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
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
       910-SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスター検索
      *****************************************************************
       910-HKNNUM-SELECT-SEC        SECTION.
      *
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           .
       910-HKNNUM-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスター読込
      *****************************************************************
       910-HKNNUM-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           .
       910-HKNNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費負担マスター検索
      *****************************************************************
       910-PTKOHFTN-SELECT-SEC        SECTION.
      *
           MOVE    PTKOHFTN-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-PTKOHFTN
           ELSE
               MOVE    1               TO  FLG-PTKOHFTN
           END-IF
      *
           .
       910-PTKOHFTN-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費負担マスター読込
      *****************************************************************
       910-PTKOHFTN-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTKOHFTN-REC
               MOVE    ZERO            TO  FLG-PTKOHFTN
           ELSE
               INITIALIZE                  PTKOHFTN-REC
               MOVE    1               TO  FLG-PTKOHFTN
           END-IF
      *
           .
       910-PTKOHFTN-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
      *
       910-DB-CLOSE-EXT.
           EXIT.
