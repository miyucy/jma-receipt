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
       PROGRAM-ID.             ORCSP01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 患者番号発行サブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/12/04    MCC-多々納    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
      *INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-KANRIMST        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
           03  IDX4                PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PTNUM1          PIC X(20).
           03  WRK-PTNUM2          PIC X(20).
           03  WRK-PTNUM3          PIC X(20).
      *
           03  WRK-KETA            PIC 9(04).
           03  WRK-KETA2           PIC 9(04).
           03  WRK-KETAN           PIC 9(04).
           03  WRK-CODSU           PIC 9(04).
           03  WRK-RENNUM          PIC 9(10).
      *
           03  WRK-RENNUM-X        PIC X(10).
      *
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
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1009.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号変換（管理）
       01  PTNUM-REC.
           COPY  "CPPTNUM.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   チェックデジット
           COPY    "CPORCCHKDGT.INC".
      *
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    パラメタ
           COPY    "CPORCSP01.INC".
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           ORCSP01AREA
           SPA-AREA.
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
      *
      *    患者番号採番検索
           PERFORM 980-PTGETNUM-GET-SEC
           IF    FLG-KANRIMST      NOT =   ZERO
               MOVE    "1011"          TO  SPA-ERRCD
               DISPLAY "P012 SYS1009(PTGETNUM)ERR:" MCP-RC  "."
           END-IF
      *
           EVALUATE    ORCSP01-SYORI
      *        患者番号発行
               WHEN    "1"
               WHEN    "3"
                   PERFORM 100-HAKKOU-SEC
      *        患者番号チェック
               WHEN    "2"
                   PERFORM 200-CHECK-SEC
           END-EVALUATE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    患者番号発行処理
      *****************************************************************
       100-HAKKOU-SEC               SECTION.
      *
      *    連番の更新
           PERFORM 1001-RENNUM-SEC
      *
      *    患者番号取得
           PERFORM 320-PTNUM-SET-SEC
      *
           EVALUATE    SYS-1009-PTNUMKSIKBN
      *        2:標準構成
               WHEN    "2"
                   MOVE    SPACE               TO  ORCSP01-PTNUM
                   MOVE    SPACE               TO  ORCSP01-PTNUM1
                   MOVE    SPACE               TO  ORCSP01-PTNUM2
                   MOVE    SPACE               TO  ORCSP01-PTNUM3
                   STRING  WRK-PTNUM1  DELIMITED  BY  " "
                           WRK-PTNUM2  DELIMITED  BY  " "
                           WRK-PTNUM3  DELIMITED  BY  " "
                        INTO            ORCSP01-PTNUM
                   END-STRING
      *        3:拡張構成
               WHEN    "3"
                   MOVE    SPACE               TO  ORCSP01-PTNUM
                   MOVE    WRK-PTNUM1          TO  ORCSP01-PTNUM1
                   MOVE    WRK-PTNUM2          TO  ORCSP01-PTNUM2
                   MOVE    WRK-PTNUM3          TO  ORCSP01-PTNUM3
           END-EVALUATE
      *
      *    登録済みかのチェック
           IF      ORCSP01-PTNUM   NOT =   SPACE
               INITIALIZE                      ORCSPTIDAREA
               MOVE    SPA-HOSPID          TO  SPTID-HOSPID
               MOVE    ORCSP01-PTNUM       TO  SPTID-PTNUM
               CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                               SPA-1009-TBL
               IF      SPTID-RC            =   ZERO
      *            既に患者番号が登録されている場合、再度取得
                   GO      TO              100-HAKKOU-SEC
               END-IF
           END-IF
      *
           .
       100-HAKKOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    再発行処理
      *****************************************************************
       1001-RENNUM-SEC               SECTION.
      *
      *    患者ＩＤ発行（再発行以外の時）
           IF      ORCSP01-SYORI   NOT =   "3"
               COMPUTE SYS-1009-PTID       =   SYS-1009-PTID  +   1
               MOVE    SYS-1009-PTID       TO  ORCSP01-PTID
           END-IF
      *
           COMPUTE   SYS-1009-RENNUM   =   SYS-1009-RENNUM  +   1
      *
      *    患者番号採番  更新
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC         NOT  =   ZERO
               MOVE    "1011"          TO  SPA-ERRCD
               DISPLAY "P012 SYSKANRI UPDATE:" MCP-RC "."
           END-IF
      *
      *
           .
       1001-RENNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号取得処理
      *****************************************************************
       320-PTNUM-SET-SEC               SECTION.
      *
           EVALUATE    SYS-1009-PTNUMKSIKBN
      *    ● 2:標準構成
           WHEN    "2"
               EVALUATE    SYS-1009-HJNKSIKBN
      *        <年 + 連番号 + 検証番号>
               WHEN    "1"
                   INITIALIZE                     LNK-CHKDGT-AREA
                   IF  SYS-1009-HJNKSINENKBN  =   "1"
      *                和暦
                       MOVE    SPA-SYSYMDW(1:3)   TO  WRK-PTNUM1
                   ELSE
      *                西暦
                       MOVE    SPA-SYSYMD (1:4)   TO  WRK-PTNUM1
                   END-IF
                   IF  SYS-1009-HJNKSIRENNUMKETA  <=  10
                       COMPUTE     IDY    =   10
                                          -   SYS-1009-HJNKSIRENNUMKETA
                       ADD         1      TO  IDY
                       MOVE    SYS-1009-RENNUM
                                   (IDY:SYS-1009-HJNKSIRENNUMKETA)
                                          TO  WRK-PTNUM2 (1:)
                   ELSE
                       MOVE    ALL "0"    TO  WRK-PTNUM2
                                          (1:SYS-1009-HJNKSIRENNUMKETA)
                       COMPUTE     IDY    =   SYS-1009-HJNKSIRENNUMKETA
                                          -   10
                       ADD         1      TO  IDY
                       MOVE    SYS-1009-RENNUM (1:10)
                                          TO  WRK-PTNUM2 (IDY:10)
                   END-IF
                   MOVE    1              TO  LNK-I-SYORIKBN
                   STRING  WRK-PTNUM1 DELIMITED  BY  " "
                           WRK-PTNUM2 DELIMITED  BY  " "
                           INTO           LNK-I-CODE
                   END-STRING
                   CALL    "ORCSCHKDGT"   USING   LNK-CHKDGT-AREA
                   IF      LNK-O-ERRCD    =   ZERO
                       MOVE    LNK-O-CHKDGT   TO  WRK-PTNUM3 (1:1)
                   ELSE
                       MOVE    "1010"          TO  SPA-ERRCD
                   END-IF
      *        <年 + 連番号>
               WHEN   "2"
                   IF  SYS-1009-HJNKSINENKBN     =   "1"
      *                和暦
                       MOVE    SPA-SYSYMDW(1:3)  TO  WRK-PTNUM1
                   ELSE
      *                西暦
                       MOVE    SPA-SYSYMD (1:4)  TO  WRK-PTNUM1
                   END-IF
                   IF  SYS-1009-HJNKSIRENNUMKETA <=  10
                       COMPUTE   IDY   =   10
                                       -   SYS-1009-HJNKSIRENNUMKETA
                       ADD         1       TO  IDY
                       MOVE    SYS-1009-RENNUM
                                (IDY:SYS-1009-HJNKSIRENNUMKETA)
                                           TO  WRK-PTNUM2 (1:)
                   ELSE
                       MOVE    ALL "0"     TO  WRK-PTNUM2
                                    (1:SYS-1009-HJNKSIRENNUMKETA)
                       COMPUTE IDY     =   SYS-1009-HJNKSIRENNUMKETA
                                       -   10
                       ADD     1           TO  IDY
                       MOVE    SYS-1009-RENNUM (1:10)
                                           TO  WRK-PTNUM2 (IDY:10)
                   END-IF
      *
      *        <連番号 + 検証番号>
               WHEN   "3"
                   MOVE    SPACE           TO  WRK-PTNUM1
                   IF  SYS-1009-HJNKSIRENNUMKETA   <=  10
                       COMPUTE   IDY   =   10
                                       -   SYS-1009-HJNKSIRENNUMKETA
                       ADD         1       TO  IDY
                       MOVE    SYS-1009-RENNUM
                                    (IDY:SYS-1009-HJNKSIRENNUMKETA)
                                           TO  WRK-PTNUM1 (1:)
                   ELSE
                       MOVE    ALL "0"     TO  WRK-PTNUM1
                                    (1:SYS-1009-HJNKSIRENNUMKETA)
                       COMPUTE IDY     =   SYS-1009-HJNKSIRENNUMKETA
                                       -   10
                       ADD     1           TO  IDY
                       MOVE    SYS-1009-RENNUM (1:10)
                                           TO  WRK-PTNUM1 (IDY:10)
                   END-IF
                   INITIALIZE                   LNK-CHKDGT-AREA
                   MOVE    1                TO  LNK-I-SYORIKBN
                   MOVE    WRK-PTNUM1   TO  LNK-I-CODE
                   CALL    "ORCSCHKDGT"     USING   LNK-CHKDGT-AREA
                   IF      LNK-O-ERRCD      =   ZERO
                       MOVE    LNK-O-CHKDGT TO  WRK-PTNUM2 (1:1)
                   END-IF
      *
      *        <連番号>
               WHEN   "4"
                   IF  SYS-1009-HJNKSIRENNUMKETA   <=   10
                       COMPUTE IDY     =   10
                                       -   SYS-1009-HJNKSIRENNUMKETA
                       ADD     1           TO  IDY
                       MOVE    SYS-1009-RENNUM
                                      (IDY:SYS-1009-HJNKSIRENNUMKETA)
                                           TO  WRK-PTNUM1
                   ELSE
                       MOVE    ALL "0"     TO  WRK-PTNUM1
                                        (1:SYS-1009-HJNKSIRENNUMKETA)
                       COMPUTE IDY     =   SYS-1009-HJNKSIRENNUMKETA
                                       -   10
                       ADD     1           TO  IDY
                       MOVE    SYS-1009-RENNUM (1:10)
                                           TO  WRK-PTNUM1 (IDY:10)
                   END-IF
               WHEN   OTHER
                   MOVE    "1010"          TO  SPA-ERRCD
               END-EVALUATE
      *
      *
      *    ● 3:拡張構成
           WHEN    "3"
               EVALUATE    SYS-1009-KKCKSIKBN
      *        <フリー + 連番号 + フリー>
               WHEN    "1"
                   IF  SYS-1009-KKCKSIRENNUMKETA  <=  10
                       COMPUTE     IDY    =   10
                                          -   SYS-1009-KKCKSIRENNUMKETA
                       ADD         1      TO  IDY
                       MOVE    SYS-1009-RENNUM
                               (IDY:SYS-1009-KKCKSIRENNUMKETA)
                                          TO  WRK-PTNUM2 (1:)
                   ELSE
                       MOVE    ALL "0"    TO  WRK-PTNUM2
                                          (1:SYS-1009-KKCKSIRENNUMKETA)
                       COMPUTE     IDY    =   SYS-1009-KKCKSIRENNUMKETA
                                          -   10
                       ADD         1      TO  IDY
                       MOVE    SYS-1009-RENNUM (1:10)
                                          TO  WRK-PTNUM2 (IDY:10)
                   END-IF
      *        <フリー + 連番号>
               WHEN   "2"
                   IF  SYS-1009-KKCKSIRENNUMKETA <=  10
                       COMPUTE   IDY    =   10
                                        -   SYS-1009-KKCKSIRENNUMKETA
                       ADD         1        TO  IDY
                       MOVE    SYS-1009-RENNUM
                                    (IDY:SYS-1009-KKCKSIRENNUMKETA)
                                            TO  WRK-PTNUM2 (1:)
                   ELSE
                       MOVE    ALL "0"     TO  WRK-PTNUM2
                                    (1:SYS-1009-KKCKSIRENNUMKETA)
                       COMPUTE IDY     =   SYS-1009-KKCKSIRENNUMKETA
                                       -   10
                       ADD     1           TO  IDY
                       MOVE    SYS-1009-RENNUM (1:10)
                                           TO  WRK-PTNUM2 (IDY:10)
                   END-IF
      *
      *        <連番号 + フリー>
               WHEN   "3"
                   IF  SYS-1009-KKCKSIRENNUMKETA <=  10
                       COMPUTE   IDY    =   10
                                        -   SYS-1009-KKCKSIRENNUMKETA
                       ADD         1        TO  IDY
                       MOVE    SYS-1009-RENNUM
                                    (IDY:SYS-1009-KKCKSIRENNUMKETA)
                                            TO  WRK-PTNUM1 (1:)
                   ELSE
                       MOVE    ALL "0"      TO  WRK-PTNUM1
                                    (1:SYS-1009-KKCKSIRENNUMKETA)
                       COMPUTE   IDY    =   SYS-1009-KKCKSIRENNUMKETA
                                        -   10
                       ADD         1        TO  IDY
                       MOVE    SYS-1009-RENNUM (1:10)
                                            TO  WRK-PTNUM1 (IDY:10)
                   END-IF
      *
               WHEN   OTHER
                   MOVE    "1010"          TO  SPA-ERRCD
               END-EVALUATE
           WHEN    OTHER
               MOVE    "1010"          TO  SPA-ERRCD
           END-EVALUATE
      *
           .
       320-PTNUM-SET-EXT.
           EXIT.
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
       200-CHECK-SEC               SECTION.
      *
      *    桁数チェック
           MOVE    ZERO                TO  WRK-CODSU
           PERFORM VARYING     IDX     FROM    20  BY  -1
                   UNTIL       IDX         <   1
               IF      ORCSP01-PTNUM(IDX:1)    NOT =   SPACE
                   MOVE    IDX                 TO  WRK-CODSU
                   MOVE    1                   TO  IDX
               END-IF
           END-PERFORM
      *
           EVALUATE    SYS-1009-PTNUMKSIKBN
               WHEN    "1"
                   MOVE    SYS-1009-JIYKSIKETA     TO  WRK-KETA
               WHEN    "2"
                   MOVE    SYS-1009-HJNKSIRENNUMKETA   TO  WRK-KETA
                   IF      SYS-1009-HJNKSINENKBN   =   "1"
      *                和暦
                       MOVE    3                  TO  WRK-KETA2
                   ELSE
      *                西暦
                       MOVE    4                  TO  WRK-KETA2
                   END-IF
                   EVALUATE    SYS-1009-HJNKSIKBN
                       WHEN    "1"
                           COMPUTE WRK-KETA    =   WRK-KETA
                                               +   WRK-KETA2
                                               +   1
                       WHEN    "2"
                           COMPUTE WRK-KETA    =   WRK-KETA
                                               +   WRK-KETA2
                       WHEN    "3"
                           COMPUTE WRK-KETA    =   WRK-KETA
                                               +   1
                       WHEN    "4"
                           CONTINUE
                   END-EVALUATE
               WHEN    "3"
                   COMPUTE WRK-KETA        =  SYS-1009-KKCKSIMAEKETA
                                           +  SYS-1009-KKCKSIRENNUMKETA
                                           +  SYS-1009-KKCKSIATOKETA
           END-EVALUATE
           IF      WRK-CODSU       NOT =   WRK-KETA
               MOVE    "1005"          TO  SPA-ERRCD
               GO      TO      200-CHECK-EXT
           END-IF
      *
      *    連番チェック
           EVALUATE    SYS-1009-PTNUMKSIKBN
      *        自由構成
               WHEN    "1"
      *            数字チェック
                   IF     (SYS-1009-JIYKSIKBN  =   "2"  )  AND
                          (ORCSP01-PTNUM(1:WRK-KETA)    NOT NUMERIC)
                       MOVE    "1006"          TO  SPA-ERRCD
                   END-IF
      *        標準構成
               WHEN    "2"
                   MOVE    SPACE               TO  WRK-RENNUM-X
                   MOVE    SYS-1009-HJNKSIRENNUMKETA   TO  WRK-KETA
                   COMPUTE WRK-KETAN       =   WRK-KETA2   +   1
                   EVALUATE    SYS-1009-HJNKSIKBN
                       WHEN    "1"
                       WHEN    "2"
                           MOVE    ORCSP01-PTNUM (WRK-KETAN:WRK-KETA)
                                               TO  WRK-RENNUM-X
                       WHEN    "3"
                       WHEN    "4"
                           MOVE    ORCSP01-PTNUM (1:WRK-KETA)
                                               TO  WRK-RENNUM-X
                   END-EVALUATE
                   PERFORM 2002-SNUM-SEC
                   IF      SYS-1009-RENNUM     <   WRK-RENNUM
                       MOVE    "1008"          TO  SPA-ERRCD
                       GO      TO      200-CHECK-EXT
                   END-IF
      *
      *            検証番号チェック
                   EVALUATE    SYS-1009-HJNKSIKBN
                       WHEN    "1"
                       WHEN    "3"
                           IF     (ORCSP01-PTNUM (WRK-CODSU:1)
                                                   NUMERIC   )  OR
                                  (ORCSP01-PTNUM (WRK-CODSU:1)
                                                   =   "*"  OR  "?" )
                               PERFORM 2001-KENBAN-CHK-SEC
                           ELSE
                               MOVE    "1007"      TO  SPA-ERRCD
                           END-IF
                   END-EVALUATE
      *        拡張構成
               WHEN    "3"
                   COMPUTE WRK-KETA        =  SYS-1009-KKCKSIMAEKETA
                                           +  1
                   MOVE    SPACE               TO  WRK-RENNUM-X
                   MOVE    ORCSP01-PTNUM
                                (WRK-KETA:SYS-1009-KKCKSIRENNUMKETA)
                                               TO  WRK-RENNUM-X
                   PERFORM 2002-SNUM-SEC
                   IF      SYS-1009-RENNUM     <    WRK-RENNUM
                       MOVE    "1008"          TO  SPA-ERRCD
                       GO      TO      200-CHECK-EXT
                   END-IF
           END-EVALUATE
      *
      *
           IF      SPA-ERRCD       =   SPACE
               IF      ORCSP01-PTID    =   ZERO
      *            患者ＩＤの取得
                   PERFORM 2001-PTID-SET-SEC
               END-IF
           END-IF
           .
       200-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    数字変換取得処理
      *****************************************************************
       2002-SNUM-SEC               SECTION.
      *
           MOVE    ZERO                TO  WRK-RENNUM
           INITIALIZE                      ORCSNUMAREA
           MOVE    WRK-RENNUM-X        TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF      SNUM-RC         NOT =   ZERO
               MOVE    ZERO                TO  WRK-RENNUM
           ELSE
               MOVE    SNUM-OUTNUM         TO  WRK-RENNUM
           END-IF
           .
       2002-SNUM-EXT.
           EXIT.
      *****************************************************************
      *    患者ＩＤの取得処理
      *****************************************************************
       2001-PTID-SET-SEC               SECTION.
      *
      *    患者ＩＤ発行（再発行以外の時）
           IF      ORCSP01-SYORI   NOT =   "3"
               COMPUTE SYS-1009-PTID       =   SYS-1009-PTID  +   1
               MOVE    SYS-1009-PTID       TO  ORCSP01-PTID
           END-IF
      *
      *    患者番号採番  更新
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC         NOT  =   ZERO
               MOVE    "1011"          TO  SPA-ERRCD
               DISPLAY "P012 SYSKANRI UPDATE:" MCP-RC "."
           END-IF
      *
      *
           .
       2001-PTID-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    検証番号チェック検索処理
      *****************************************************************
       2001-KENBAN-CHK-SEC          SECTION.
      *
           INITIALIZE                   LNK-CHKDGT-AREA
           IF      ORCSP01-PTNUM (WRK-CODSU:1)
                                       =   "*"  OR  "?"
               COMPUTE IDX2            =   WRK-CODSU    -  1
               MOVE    ORCSP01-PTNUM (1:IDX2)
                                            TO  LNK-I-CODE
               MOVE    1                    TO  LNK-I-SYORIKBN
           ELSE
               MOVE    ORCSP01-PTNUM        TO  LNK-I-CODE
               MOVE    2                    TO  LNK-I-SYORIKBN
           END-IF
      *
           CALL    "ORCSCHKDGT"     USING   LNK-CHKDGT-AREA
           IF      LNK-O-ERRCD         =   ZERO
               IF      ORCSP01-PTNUM (WRK-CODSU:1)
                                           =   "*"  OR  "?"
                   MOVE    LNK-O-CODE      TO  ORCSP01-PTNUM
               END-IF
           ELSE
               MOVE    "1007"              TO  SPA-ERRCD
           END-IF
      *
           .
       2001-KENBAN-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    患者番号採番検索
      *****************************************************************
       980-PTGETNUM-GET-SEC          SECTION.
      *
           INITIALIZE                  SYS-1009-REC.
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
      *
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-KANRIMST
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       980-PTGETNUM-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       960-KANRIMST-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1009-REC
               MOVE    ZERO                TO  FLG-KANRIMST
           ELSE
               MOVE    1                   TO  FLG-KANRIMST
           END-IF
      *
           .
       960-KANRIMST-READ-EXT.
           EXIT.
      *
