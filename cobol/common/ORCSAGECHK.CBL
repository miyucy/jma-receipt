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
       PROGRAM-ID.             ORCSAGECHK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 保険算定用年齢・割合処理
      *  返却エラーコード  : 00:正常　99:パラメータ不正・対象データなし
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/09/10    NACL- 多々納  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     NACL-多々納  02/10/01  生活保護追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-PTHKNINF        PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
           03  FLG-HKN-ERR         PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-BYMD.
               05  WRK-BYY             PIC 9(04).
               05  WRK-BMM             PIC 9(02).
               05  WRK-BDD             PIC 9(02).
           03  WRK-NENREI-YY           PIC 9(03).
           03  WRK-NENREI-MM           PIC 9(02).
      *
           03  WRK-HKNNUM              PIC X(03).
           03  WRK-PAYKBN              PIC X(02).
      *
           03  WRK-ZZ9                 PIC ZZZ.
      *
           03  WRK-SEIDONAME           PIC X(20).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    共通領域
           COPY    "MCPAREA".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者保険情報
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    患者公費情報
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    保険情報
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSAGECHK.INC".
      *
       PROCEDURE                    DIVISION    USING
           ORCSAGECHKAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  AGECHK-OUT-AREA
           INITIALIZE                  AGECHK-RC
      *
           IF     (AGECHK-HOSPID       =   SPACE   ) OR
                  (AGECHK-PTID         NOT NUMERIC )
               MOVE    99              TO  AGECHK-RC
               GO      TO      000-PROC-EXT
           END-IF
      *    年齢計算
           PERFORM 100-NENREI-SEC
           IF      AGECHK-RC       NOT =   ZERO
               GO      TO      000-PROC-EXT
           END-IF
      *
      *    保険組合番号があるとき、負担割合を算定する
           IF      AGECHK-HKNCOMBINUM  NOT =   SPACE
               PERFORM 200-FTNRATE-SEC
           END-IF
      *
           .
       000-PROC-EXT.
           EXIT.
      *
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    年齢計算処理
      *****************************************************************
       100-NENREI-SEC                SECTION.
      *
      *    患者生年月日
           IF      AGECHK-BIRTHDAY     =   SPACE
      *        患者情報検索
               INITIALIZE                      PTINF-REC
               MOVE    AGECHK-HOSPID       TO  PTINF-HOSPID
               MOVE    AGECHK-PTID         TO  PTINF-PTID
               PERFORM 900-PTINF-READ-SEC
               IF      FLG-PTINF           =   1
                   MOVE    99              TO  AGECHK-RC
                   GO      TO      100-NENREI-EXT
               END-IF
               MOVE    PTINF-BIRTHDAY      TO  WRK-BYMD
           ELSE
               MOVE    AGECHK-BIRTHDAY     TO  WRK-BYMD
           END-IF
      *
      *    １日以外の誕生日の時は、翌月１日を基準とする
           IF      WRK-BDD             >   01
               COMPUTE WRK-BMM         =   WRK-BMM     +   1
               IF      WRK-BMM         >   12
                   COMPUTE WRK-BYY         =   WRK-BYY     +   1
                   MOVE    01              TO  WRK-BMM
               END-IF
               MOVE    01              TO  WRK-BDD
           END-IF
      *
      *    年齢を計算する
           MOVE    AGECHK-SRYYMD       TO  WRK-SYMD
           COMPUTE WRK-NENREI-YY       =   WRK-SYY
                                       -   WRK-BYY
           IF      WRK-BYMD(5:4)       >   WRK-SYMD(5:4)
               COMPUTE WRK-NENREI-YY       =   WRK-NENREI-YY
                                           -   1
               COMPUTE WRK-NENREI-MM       =  (WRK-BMM   +  12 )
                                           -   WRK-SMM
           ELSE
               COMPUTE WRK-NENREI-MM       =   WRK-BMM
                                           -   WRK-SMM
           END-IF
           MOVE    WRK-NENREI-YY       TO  AGECHK-NENREI
      *
           .
       100-NENREI-EXT.
           EXIT.
      *
      *****************************************************************
      *    負担割合を算定処理
      *****************************************************************
       200-FTNRATE-SEC                SECTION.
      *
      *    保険組合マスター編集
           MOVE    SPACE               TO  HKNCOMBI-REC
           INITIALIZE                  HKNCOMBI-REC
           MOVE    AGECHK-HOSPID       TO  COMB-HOSPID
           MOVE    AGECHK-PTID         TO  COMB-PTID
           MOVE    AGECHK-HKNCOMBINUM  TO  COMB-HKNCOMBINUM
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               PERFORM 910-HKNCOMBI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
               INITIALIZE                  HKNCOMBI-REC
           END-IF
           IF      FLG-HKNCOMBI        =   1
               MOVE    99              TO  AGECHK-RC
               GO      TO      200-FTNRATE-EXT
           END-IF
      *
           MOVE    COMB-GAI-KFTNRATE   TO  AGECHK-FTNRATE
           IF      COMB-GAI-KFTNRATE   =   ZERO
               MOVE    SPACE               TO  AGECHK-FTNRATEMEI
           ELSE
               MOVE    COMB-GAI-KFTNRATE   TO  WRK-ZZ9
               MOVE    WRK-ZZ9             TO  AGECHK-FTNRATEMEI(1:3)
               MOVE    "%"                 TO  AGECHK-FTNRATEMEI(4:)
           END-IF
      *    Ｈ１４．１０改正後
      *    ３歳未満の時、２割を上限とする
           IF     (AGECHK-SRYYMD       >=  "20021001") AND
                  (AGECHK-NENREI       <   03        )
               IF      COMB-GAI-KFTNRATE   >   20
                   MOVE    20                  TO  AGECHK-FTNRATE
                   MOVE    " 20%"              TO  AGECHK-FTNRATEMEI
               END-IF
           END-IF
      *
      *    Ｈ１４．１０改正後以下のチェックを行う
           IF      AGECHK-SRYYMD       >=  "20021001"
               CONTINUE
           ELSE
               GO      TO      200-FTNRATE-EXT
           END-IF
      *    ７０歳以上の時、老人であること
           IF      AGECHK-NENREI       <   70
               GO      TO      200-FTNRATE-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
      *    主保険判定
           MOVE    COMB-HKNNUM         TO  WRK-HKNNUM
           MOVE    ZERO                TO  WRK-PAYKBN
           PERFORM 3001-HKNNUM-CHK-SEC
           IF      FLG-HKNNUM          =   ZERO
      *        労災・自費・治験
               IF      HKN-HKNKOHSBTKBN    =   "4"  OR  "8"  OR  "9"
                   MOVE    1                   TO  FLG-OK
                   GO      TO      200-FTNRATE-EXT
               END-IF
      *        保険者編集
               INITIALIZE                  PTHKNINF-REC
               MOVE    AGECHK-HOSPID       TO  PTHKN-HOSPID
               MOVE    AGECHK-PTID         TO  PTHKN-PTID
               MOVE    COMB-HKNID          TO  PTHKN-HKNID
      *
               MOVE    PTHKNINF-REC        TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
                   PERFORM 910-PTHKNINF-READ-SEC
               ELSE
                   MOVE    1               TO  FLG-PTHKNINF
               END-IF
               IF      FLG-PTHKNINF        =   ZERO
                   IF     (PTHKN-HOJOKBN       =   "8"  OR  "9") OR
                          (COMB-HKNNUM         =   "060"  AND
                           PTHKN-HOJOKBN       =   "1"  OR  "2")
                       MOVE    1               TO  FLG-OK
                   END-IF
               END-IF
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           END-IF
           IF      FLG-OK                  =   1
               GO      TO      200-FTNRATE-EXT
           END-IF
      *
      *    生活保護のみの時
           IF     (COMB-HKNNUM         =   SPACE )  AND
                 ((COMB-KOH1HKNNUM     =   "012" )  OR
                  (COMB-KOH2HKNNUM     =   "012" )  OR
                  (COMB-KOH3HKNNUM     =   "012" )  OR
                  (COMB-KOH4HKNNUM     =   "012" ))
               MOVE    1               TO  FLG-OK
               GO      TO      200-FTNRATE-EXT
           END-IF
      *    老人公費で、支払区分がある時
           IF    ((COMB-KOH1HKNNUM     =   "027" )  AND
                  (COMB-KOH1PAYKBN     =   "01" OR "02" ))  OR
                 ((COMB-KOH2HKNNUM     =   "027" )  AND
                  (COMB-KOH2PAYKBN     =   "01" OR "02"  ))  OR
                 ((COMB-KOH3HKNNUM     =   "027" )  AND
                  (COMB-KOH3PAYKBN     =   "01" OR "02" ))  OR
                 ((COMB-KOH4HKNNUM     =   "027" )  AND
                  (COMB-KOH4PAYKBN     =   "01" OR "02" ))
               MOVE    1               TO  FLG-OK
           ELSE
      *        公費１
               IF      COMB-KOH1HKNNUM     NOT =   SPACE
                   MOVE    COMB-KOH1HKNNUM     TO  WRK-HKNNUM
                   MOVE    COMB-KOH1PAYKBN     TO  WRK-PAYKBN
                   PERFORM 3001-HKNNUM-CHK-SEC
                   IF      FLG-HKNNUM          =   ZERO
                       IF      HKN-HKNKOHSBTKBN    =   "3"
                           PERFORM 2001-KOH-CHK-SEC
                           IF      FLG-OK          =   1
                               GO      TO      200-FTNRATE-EXT
                           END-IF
                       END-IF
                   END-IF
               END-IF
      *        公費２
               IF      COMB-KOH2HKNNUM     NOT =   SPACE
                   MOVE    COMB-KOH2HKNNUM     TO  WRK-HKNNUM
                   MOVE    COMB-KOH2PAYKBN     TO  WRK-PAYKBN
                   PERFORM 3001-HKNNUM-CHK-SEC
                   IF      FLG-HKNNUM          =   ZERO
                       IF      HKN-HKNKOHSBTKBN    =   "3"
                           PERFORM 2001-KOH-CHK-SEC
                           IF      FLG-OK          =   1
                               GO      TO      200-FTNRATE-EXT
                           END-IF
                       END-IF
                   END-IF
               END-IF
      *        公費３
               IF      COMB-KOH3HKNNUM     NOT =   SPACE
                   MOVE    COMB-KOH3HKNNUM     TO  WRK-HKNNUM
                   MOVE    COMB-KOH3PAYKBN     TO  WRK-PAYKBN
                   PERFORM 3001-HKNNUM-CHK-SEC
                   IF      FLG-HKNNUM          =   ZERO
                       IF      HKN-HKNKOHSBTKBN    =   "3"
                           PERFORM 2001-KOH-CHK-SEC
                           IF      FLG-OK          =   1
                               GO      TO      200-FTNRATE-EXT
                           END-IF
                       END-IF
                   END-IF
               END-IF
      *        公費４
               IF      COMB-KOH4HKNNUM     NOT =   SPACE
                   MOVE    COMB-KOH4HKNNUM     TO  WRK-HKNNUM
                   MOVE    COMB-KOH4PAYKBN     TO  WRK-PAYKBN
                   PERFORM 3001-HKNNUM-CHK-SEC
                   IF      FLG-HKNNUM          =   ZERO
                       IF      HKN-HKNKOHSBTKBN    =   "3"
                           PERFORM 2001-KOH-CHK-SEC
                           IF      FLG-OK          =   1
                               GO      TO      200-FTNRATE-EXT
                           END-IF
                       END-IF
                   END-IF
               END-IF
      *
           END-IF
           IF      FLG-OK              =   ZERO
               MOVE    1               TO  AGECHK-RJNCHK
           END-IF
      *
           .
       200-FTNRATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費情報処理
      *****************************************************************
       2001-KOH-CHK-SEC         SECTION.
      *
           MOVE    1                   TO  FLG-OK
           .
       2001-KOH-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険情報処理
      *****************************************************************
       3001-HKNNUM-CHK-SEC         SECTION.
      *
           INITIALIZE                  HKNNUM-REC
           MOVE    AGECHK-HOSPID       TO  HKN-HOSPID
           MOVE    AGECHK-SRYYMD       TO  HKN-TEKSTYMD
           MOVE    AGECHK-SRYYMD       TO  HKN-TEKEDYMD
           MOVE    WRK-HKNNUM          TO  HKN-HKNNUM
           MOVE    WRK-PAYKBN          TO  HKN-PAYKBN
      *
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    AGECHK-SRYYMD       TO  ORC-DBYMD
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
               PERFORM 921-HKNNUM-NEXT-SEC
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           .
       3001-HKNNUM-CHK-EXT.
           EXIT.
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
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
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
      ****************************************************************
      *    保険番号マスタ次検索処理
      ****************************************************************
       921-HKNNUM-NEXT-SEC              SECTION.
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
           .
       921-HKNNUM-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    保険マスター読み込み
      *****************************************************************
       910-PTHKNINF-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTHKNINF-REC
               MOVE    ZERO            TO  FLG-PTHKNINF
           ELSE
               INITIALIZE                  PTHKNINF-REC
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
      *
           .
       910-PTHKNINF-READ-EXT.
           EXIT.
      *
      *
