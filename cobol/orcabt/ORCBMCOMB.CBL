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
       PROGRAM-ID.                 ORCBMCOMB.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : Ｈ１５／４改正対応、保険一括変更
      *  管理者            : 
      *  02/09/30    NACL-多々納    新規作成
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
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
      *
           03  FLG-PARM            PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-PTHKNINF        PIC 9(01).
           03  FLG-PTKOHINF        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PTNUM           PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-RJN             PIC 9(01).
           03  FLG-HKNKOH          PIC 9(01).
           03  FLG-ERR             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(03).
           03  CNT-IN              PIC 9(06).
           03  CNT-OK              PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-SYMD2.
               05  WRK-SYY2         PIC 9(02).
               05  WRK-SMM2         PIC 9(02).
               05  WRK-SDD2         PIC 9(02).
      *
           03  WRK-KENSAKU-AREA.
               05  WRK-KEN-HKNNUM      PIC X(03).
               05  WRK-KEN-TEKSTYMD    PIC X(08).
               05  WRK-KEN-TEKEDYMD    PIC X(08).
               05  WRK-KEN-ERFLG       PIC X(01).
               05  WRK-KEN-SBTKBN      PIC X(01).
               05  WRK-KEN-HOJOKBN     PIC X(01).
               05  WRK-KEN-CONTKBN     PIC X(01).
               05  WRK-KEN-SEIDO       PIC X(10).
               05  WRK-KEN-HKNKOH      PIC 9(01).
               05  WRK-KEN-PAYKBN      PIC X(02).
      *    新組合せパラメタデータ用レイアウト
       01  NC01PARA-REC.
           03  PARA-NC01-REC           PIC X(500).
           03  PARA-NC01-FLG           PIC 9(01).
      *
      *    メッセージ領域
       01  CONS-AREA.
           03  CONS-MES1               PIC X(40) VALUE
               "保険番号マスタ該当なし　　　　　　　　　".
           03  CONS-MES2               PIC X(40) VALUE
               "患者保険マスタに公費が入っている　　　　".
           03  CONS-MES3               PIC X(40) VALUE
               "患者公費マスタに保険が入っている　　　　".
           03  CONS-MES4               PIC X(40) VALUE
               "保険・公費テーブルオーバー　　　　　　　".
           03  CONS-MES5               PIC X(40) VALUE
               "保険番号マスタ該当なし　　　　　　　　　".
           03  CONS-MES6               PIC X(40) VALUE
               "患者番号変換マスタ読込エラー　　　　　　".
      *
      *****************************************************************
      *    ファイル定義
      *****************************************************************
      *
      *    システム管理（医療機関情報基本情報）
           COPY    "CPSK1001.INC".
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *    患者保険情報
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *    患者公費情報せ
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    パラメタ
       01  PARA-REC.
           COPY    "CPPARA.INC".
      *
      *    パラメタ
       01  WRK-PARA-REC.
           COPY    "CPPARA.INC"      REPLACING
                                     //PARA-// BY //WRK-PARA-//.
      *
      *    患者登録スパ領域
           COPY    "P02COMMON-SPA".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
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
      *    スパ領域
           COPY    "COMMON-SPA".
      *    その他連絡領域
       01  LNK-AREA.
           03  LNK-CNT-HKNCOMBI        PIC 9(06).
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           LNK-AREA
           .
      ****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           INITIALIZE                  IDX-AREA
      *
      *    パラメタＤＢクリア
           PERFORM 210-PARA-CLEA-SEC
      *
      *    更新処理
           PERFORM 2001-KOUSIN-SYORI-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       2001-KOUSIN-SYORI-SEC              SECTION.
      *
      *    患者保険情報　検索処理
           PERFORM 220-PTHKNINF-KENSAKU-SEC
      *
      *    患者公費情報　検索処理
           PERFORM 230-PTKOHINF-KENSAKU-SEC
      *
      *    患者番号変換の保存
      *
           INITIALIZE                      PTNUM-REC
           MOVE    SPA-HOSPID          TO  PTNUM-HOSPID
           MOVE    SPA-PTID            TO  PTNUM-PTID
      *
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
               PERFORM 950-PTNUM-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTNUM
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      FLG-PTNUM           =   ZERO
               MOVE    PTNUM-AUTOCOMBINUM  TO  SPA-PTNUM-AUTOCOMBINUM
               MOVE    PTNUM-MANUCOMBINUM  TO  SPA-PTNUM-MANUCOMBINUM
      *        患者番号変換の初期内容保存
               MOVE    PTNUM-AUTOCOMBINUM  TO  SPA-MAE-AUTOCOMBINUM
               MOVE    PTNUM-MANUCOMBINUM  TO  SPA-MAE-MANUCOMBINUM
           ELSE
               INITIALIZE                  SPA-PTNUM-AREA
               INITIALIZE                  SPA-MAE-PTNUM-AREA
           END-IF
      *
      *    組合せ編集処理
           CALL    "ORCGP02W2" USING   SPA-AREA
           IF       SPA-ERRCD          NOT =   SPACE
      *        エラーリスト出力処理
               PERFORM 2220-ERRLST-OUT-SEC
               GO  TO                  2001-KOUSIN-SYORI-EXT
           END-IF
      *    組合せ編集処理
           CALL    "ORCGP02W3" USING   SPA-AREA
                                       SPA-P02KYOUTU
           IF      SPA-ERRCD           NOT =   SPACE
      *        エラーリスト出力処理
               PERFORM 2220-ERRLST-OUT-SEC
               GO  TO                  2001-KOUSIN-SYORI-EXT
           END-IF
      *
      *    保険組合せ　登録処理
           PERFORM 240-HKNCOMBI-UPDATE-SEC
      *
      *    患者番号変換の更新
           PERFORM 260-PTNUM-UPDATE-SEC
      *
           .
       2001-KOUSIN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ削除処理
      *****************************************************************
       210-PARA-CLEA-SEC              SECTION.
      *
      *    パラメタ削除
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "PARA-DEL2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       210-PARA-CLEA-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険情報　検索処理
      *****************************************************************
       220-PTHKNINF-KENSAKU-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-PTHKNINF
           MOVE    SPACE               TO  PTHKNINF-REC
           INITIALIZE                      PTHKNINF-REC
           MOVE    SPA-HOSPID          TO  PTHKN-HOSPID
           MOVE    SPA-PTID            TO  PTHKN-PTID
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTHKNINF-KEY2" TO  ORC-DBPATH
               PERFORM 920-PTHKNINF-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
      *
           PERFORM     UNTIL   FLG-PTHKNINF  =   1
               IF      PTHKN-SAKJOKBN          =   SPACE
                   INITIALIZE                  WRK-KENSAKU-AREA
                   MOVE    PTHKN-HKNNUM    TO  WRK-KEN-HKNNUM
                   MOVE    PTHKN-TEKSTYMD  TO  WRK-KEN-TEKSTYMD
                   MOVE    PTHKN-TEKEDYMD  TO  WRK-KEN-TEKEDYMD
                   MOVE    1               TO  WRK-KEN-HKNKOH
                   MOVE    ZERO            TO  WRK-KEN-PAYKBN
      *            保険確認処理
                   PERFORM 2210-HKNKOH-KAKUNIN-SEC
                   IF      WRK-KEN-ERFLG           =   SPACE
                       ADD     1                   TO  IDX
                       MOVE    SPACE               TO  PARA-REC
                       INITIALIZE                      PARA-REC
                       MOVE    "PTHKNINF"          TO  PARA-FILEMEI
                       MOVE    IDX                 TO  PARA-EDANUM
                       MOVE    PTHKNINF-REC        TO  PARA-DATA-REC
                       PERFORM 400-PARA-INSERT-SEC
                   ELSE
      *                エラーリスト出力処理
                       PERFORM 2220-ERRLST-OUT-SEC
                   END-IF
               END-IF
      *
               MOVE    "PTHKNINF-KEY2" TO  ORC-DBPATH
               PERFORM 920-PTHKNINF-NEXT-SEC
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
       220-PTHKNINF-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費情報　検索処理
      *****************************************************************
       230-PTKOHINF-KENSAKU-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-PTKOHINF
           MOVE    SPACE               TO  PTKOHINF-REC
           INITIALIZE                      PTKOHINF-REC
           MOVE    SPA-HOSPID          TO  PTKOH-HOSPID
           MOVE    SPA-PTID            TO  PTKOH-PTID
           MOVE    PTKOHINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTKOHINF-KEY2" TO  ORC-DBPATH
               PERFORM 930-PTKOHINF-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-PTKOHINF
           END-IF
      *
           PERFORM     UNTIL   FLG-PTKOHINF  =   1
               IF      PTKOH-SAKJOKBN          =   SPACE
                   INITIALIZE                  WRK-KENSAKU-AREA
                   MOVE    PTKOH-KOHNUM    TO  WRK-KEN-HKNNUM
                   MOVE    PTKOH-TEKSTYMD  TO  WRK-KEN-TEKSTYMD
                   MOVE    PTKOH-TEKEDYMD  TO  WRK-KEN-TEKEDYMD
                   MOVE    PTKOH-PAYKBN    TO  WRK-KEN-PAYKBN
                   MOVE    2               TO  WRK-KEN-HKNKOH
      *            保険確認処理
                   PERFORM 2210-HKNKOH-KAKUNIN-SEC
                   IF      WRK-KEN-ERFLG           =   SPACE
                       ADD     1                   TO  IDY
                       MOVE    SPACE               TO  PARA-REC
                       INITIALIZE                      PARA-REC
                       MOVE    "PTKOHINF"          TO  PARA-FILEMEI
                       MOVE    IDY                 TO  PARA-EDANUM
                       MOVE    PTKOHINF-REC        TO  PARA-DATA-REC
                       PERFORM 400-PARA-INSERT-SEC
                   ELSE
      *                エラーリスト出力処理
                       PERFORM 2220-ERRLST-OUT-SEC
                   END-IF
               END-IF
      *
               MOVE    "PTKOHINF-KEY2" TO  ORC-DBPATH
               PERFORM 930-PTKOHINF-NEXT-SEC
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
       230-PTKOHINF-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険公費確認処理
      *****************************************************************
       2210-HKNKOH-KAKUNIN-SEC        SECTION.
      *
           MOVE    ZERO               TO  FLG-HKNNUM
           MOVE    SPACE              TO  HKNNUM-REC
           MOVE    SPA-HOSPID         TO  HKN-HOSPID
           MOVE    WRK-KEN-HKNNUM     TO  HKN-HKNNUM
           IF      WRK-KEN-PAYKBN     =   SPACE
               MOVE    ZERO               TO  WRK-KEN-PAYKBN
           END-IF
      *    老人公費で支払区分が設定されていない時、システム管理より
           IF     (WRK-KEN-PAYKBN     =    ZERO )  AND
                  (WRK-KEN-HKNNUM     =    "027")
               MOVE    SPA-HOSPSBT         TO  HKN-PAYKBN (1:1) 
               MOVE    SPA-ROUPAYKBN       TO  HKN-PAYKBN (2:1)
           ELSE
               MOVE    WRK-KEN-PAYKBN      TO  HKN-PAYKBN
           END-IF
      *
           MOVE    HKNNUM-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"         TO  MCP-FUNC
      *****MOVE    "HKNNUM-KEY2"      TO  ORC-DBPATH
           MOVE    "HKNNUM-KEY7"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"     USING   MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
      ******** MOVE    "HKNNUM-KEY2"   TO  ORC-DBPATH
               MOVE    "HKNNUM-KEY7"   TO  ORC-DBPATH
               PERFORM 950-HKNNUM-NEXT-SEC
               MOVE    "1"             TO  WRK-KEN-ERFLG
           ELSE
               INITIALIZE              HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
               MOVE    "2"             TO  WRK-KEN-ERFLG
           END-IF
      *
           MOVE    ZERO                TO  FLG-RJN
           PERFORM   UNTIL   FLG-HKNNUM    =   1
             IF  ( WRK-KEN-TEKSTYMD        >=  HKN-TEKSTYMD ) AND
                 ( WRK-KEN-TEKEDYMD        <=  HKN-TEKEDYMD )
               IF      HKN-HKNKOHSBTKBN        =   "3"
                   MOVE    1               TO  FLG-RJN
                   MOVE    SPACE           TO  WRK-KEN-ERFLG
                   MOVE    1               TO  FLG-HKNNUM
               ELSE
                   MOVE    SPACE           TO  WRK-KEN-ERFLG
                   MOVE    1               TO  FLG-HKNNUM
               END-IF
             ELSE
               MOVE    "HKNNUM-KEY7"   TO  ORC-DBPATH
               PERFORM 950-HKNNUM-NEXT-SEC
             END-IF
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY7"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    対象支払区分の老人が存在しない場合
           IF  (WRK-KEN-ERFLG          =   "1")  AND
               (FLG-RJN                =   1  )
               MOVE    ZERO               TO  FLG-HKNNUM
               MOVE    SPACE              TO  HKNNUM-REC
               MOVE    SPA-HOSPID         TO  HKN-HOSPID
               MOVE    WRK-KEN-HKNNUM     TO  HKN-HKNNUM
               MOVE    HKNNUM-REC         TO  MCPDATA-REC
               MOVE    "DBSELECT"         TO  MCP-FUNC
               MOVE    "HKNNUM-KEY2"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC             =   ZERO
                   MOVE    "HKNNUM-KEY2"  TO  ORC-DBPATH
                   PERFORM 950-HKNNUM-NEXT-SEC
               ELSE
                   INITIALIZE             HKNNUM-REC
                   MOVE    1              TO  FLG-HKNNUM
               END-IF
      *
               PERFORM   UNTIL   FLG-HKNNUM   =   1
                 IF  ( WRK-KEN-TEKSTYMD       >=  HKN-TEKSTYMD ) AND
                     ( WRK-KEN-TEKEDYMD       <=  HKN-TEKEDYMD )
                     IF  HKN-HKNKOHSBTKBN     =   "3"
                         IF  (HKN-PAYKBN      =   "00")
                             MOVE    SPACE    TO  WRK-KEN-ERFLG
                             MOVE    1              TO  FLG-HKNNUM
                         ELSE
                             PERFORM 950-HKNNUM-NEXT-SEC
                         END-IF
                     ELSE
                         PERFORM 950-HKNNUM-NEXT-SEC
                     END-IF
                 ELSE
                     PERFORM 950-HKNNUM-NEXT-SEC
                 END-IF
               END-PERFORM
               MOVE    "DBCLOSE"          TO  MCP-FUNC
               MOVE    "HKNNUM-KEY2"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-IF
      *    対象の保険番号マスタが見つかった場合
           IF  WRK-KEN-ERFLG              =   SPACE
      *        対象の保険番号が保険のもの
               IF  HKN-HKNKOHSBTKBN       =   "1"  OR  "4"
                                          OR  "8"  OR  "9"
      *        　　患者公費情報のデータ
                   IF  WRK-KEN-HKNKOH     =   2
                       MOVE    "4"        TO  WRK-KEN-ERFLG
                   END-IF
               ELSE
      *        対象の保険番号が公費のもの
      *        　　患者情報情報のデータ
                   IF  WRK-KEN-HKNKOH     =   1
                       MOVE    "3"        TO  WRK-KEN-ERFLG
                   END-IF
               END-IF
           END-IF
      *
           .
       2210-HKNKOH-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタファイル作成処理
      *****************************************************************
       400-PARA-INSERT-SEC           SECTION.
      *
      *    パラメタ登録
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    PARA-REC            TO  WRK-PARA-REC
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PARA
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PARA-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           MOVE    WRK-PARA-REC        TO  PARA-REC
           IF      FLG-PARA            =   1
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "*(ORCBMCOMB)*  PARA INSERT ERR:" MCP-RC
                           ",KEY2:" PARA-KEY
                           ",EDANUM:" PARA-EDANUM
                   MOVE    "9999"              TO  SPA-ERRCD
               END-IF
           ELSE
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "*(ORCBMCOMB)*  PARA UPDATE ERR:" MCP-RC
                           ",KEY2:" PARA-KEY
                           ",EDANUM:" PARA-EDANUM
                   MOVE    "9999"              TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       400-PARA-INSERT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    エラーリスト出力処理
      *****************************************************************
       2220-ERRLST-OUT-SEC                SECTION.
      *
      *
           IF  SPA-ERRCD               =   SPACE
               EVALUATE    WRK-KEN-ERFLG
      *        該当する保険番号なし
               WHEN    "1"
               WHEN    "2"
                   MOVE    "0001"          TO  SPA-ERRCD
                   MOVE    CONS-MES1       TO  SPA-ERRMSG
      *        患者保険マスタに公費が入っている場合
               WHEN    "3"
                   MOVE    "0001"          TO  SPA-ERRCD
                   MOVE    CONS-MES2       TO  SPA-ERRMSG
      *        患者公費マスタに保険が入っている場合
               WHEN    "4"
                   MOVE    "0001"          TO  SPA-ERRCD
                   MOVE    CONS-MES3       TO  SPA-ERRMSG
               WHEN    OTHER
                   MOVE    "0001"          TO  SPA-ERRCD
                   MOVE    CONS-MES6       TO  SPA-ERRMSG
               END-EVALUATE
           ELSE
      *        サブプロ（ORCGP02W2）内でエラー発生
               EVALUATE    SPA-ERRCD
      *        保険・公費テーブル１００件オーバー
               WHEN    "0015"
                   MOVE    CONS-MES4       TO  SPA-ERRMSG
      *        保険・公費　該当なし
               WHEN    "0001"
               WHEN    "0014"
                   MOVE    CONS-MES5       TO  SPA-ERRMSG
               END-EVALUATE
           END-IF
      *
           .
       2220-ERRLST-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号変換の更新処理
      *****************************************************************
       260-PTNUM-UPDATE-SEC             SECTION.
      *
           INITIALIZE                      PTNUM-REC
           MOVE    SPA-HOSPID          TO  PTNUM-HOSPID
           MOVE    SPA-PTID            TO  PTNUM-PTID
      *
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
               PERFORM 950-PTNUM-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTNUM
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      FLG-PTNUM           =   1
               DISPLAY "*(ORCBMCOMB)* PTNUM SELECT ERR[" MCP-RC "]"
                          ",KEY:" PTNUM-KEY   "."
               MOVE    "9999"              TO  SPA-ERRCD
           ELSE
               MOVE    SPA-PTNUM-AUTOCOMBINUM  TO  PTNUM-AUTOCOMBINUM
               MOVE    SPA-PTNUM-MANUCOMBINUM  TO  PTNUM-MANUCOMBINUM
      *
               MOVE    PTNUM-REC           TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "*(ORCBMCOMB)* PTNUM UPD ERR[" MCP-RC "]"
                           ",KEY:" PTNUM-KEY   "."
                   MOVE    "9999"              TO  SPA-ERRCD
               END-IF
           END-IF
           .
       260-PTNUM-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ　登録処理
      *****************************************************************
       240-HKNCOMBI-UPDATE-SEC         SECTION.
      *
      *    削除処理
           PERFORM 250-HKNCOMBI-DELETE-SEC
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "HKNCOMBI"          TO  PARA-FILEMEI
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY2"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1                   TO  FLG-PARA
           END-IF
           PERFORM
               UNTIL   FLG-PARA            =  1
      *
      *        組合せ番号　設定処理
               PERFORM 2410-HKNCOMBINUM-SET-SEC
      *
               MOVE    "PARA-KEY2"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           END-PERFORM
      *
           .
       240-HKNCOMBI-UPDATE-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ　削除処理
      *****************************************************************
       250-HKNCOMBI-DELETE-SEC         SECTION.
      *
      *    削除処理
           MOVE    SPACE               TO  HKNCOMBI-REC
           INITIALIZE                      HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-PTID            TO  COMB-PTID
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-DEL1"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       250-HKNCOMBI-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    組合せ番号　設定処理
      *****************************************************************
       2410-HKNCOMBINUM-SET-SEC        SECTION.
      *
           MOVE    SPACE               TO  HKNCOMBI-REC
           MOVE    PARA-DATA-REC       TO  HKNCOMBI-REC
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           PERFORM 940-HKNCOMBI-READ-SEC
           IF      FLG-HKNCOMBI        =   1
               MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "*(ORCBMCOMB)* HKNCOMBI INS-ERR[" MCP-RC "]"
                   MOVE    "9999"              TO  SPA-ERRCD
              END-IF
           ELSE
               MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "*(ORCBMCOMB)* HKNCOMBI UPD-ERR[" MCP-RC "]"
                   MOVE    "9999"              TO  SPA-ERRCD
               END-IF
           END-IF
           ADD     1                   TO  LNK-CNT-HKNCOMBI
      *
           .
       2410-HKNCOMBINUM-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタＦＥＴＣＨ処理
      *****************************************************************
       900-SYSTEM-NEXT-SEC         SECTION.
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
       900-SYSTEM-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せマスター読み込み
      *****************************************************************
       940-HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-HKNCOMBI
               ELSE
                   MOVE    1               TO  FLG-HKNCOMBI
               END-IF
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       940-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険マスタＦＥＴＣＨ処理
      *****************************************************************
       920-PTHKNINF-NEXT-SEC         SECTION.
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
       920-PTHKNINF-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    患者公費マスタＦＥＴＣＨ処理
      *****************************************************************
       930-PTKOHINF-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTKOHINF-REC
               MOVE    ZERO            TO  FLG-PTKOHINF
           ELSE
               INITIALIZE                  PTKOHINF-REC
               MOVE    1               TO  FLG-PTKOHINF
           END-IF
      *
           .
       930-PTKOHINF-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    保険番号マスタ次検索処理
      *****************************************************************
       950-HKNNUM-NEXT-SEC             SECTION.
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
       950-HKNNUM-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    患者番号変換読み込み
      *****************************************************************
       950-PTNUM-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTNUM-REC
               MOVE    ZERO            TO  FLG-PTNUM
           ELSE
               MOVE    1               TO  FLG-PTNUM
           END-IF
      *
           .
       950-PTNUM-READ-EXT.
           EXIT.
      *****************************************************************
      *    パラメタ情報読み込み
      *****************************************************************
       990-PARA-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PARA-REC
               MOVE    ZERO            TO  FLG-PARA
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           .
       990-PARA-READ-EXT.
           EXIT.
      *
      *
