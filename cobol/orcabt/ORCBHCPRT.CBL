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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBHCPRT.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : オンライン帳票
      *  コンポーネント名  : オンライン帳票印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  08/10/08    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      *  Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    パラメタ退避ファイル
           SELECT  PARA-FILE       ASSIGN  OPPARA00
                                   ORGANIZATION    IS  SEQUENTIAL
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *(LINE SEQUENTIAL でなく)SEQUENTIALファイルで実際のファイルより大きい
      *領域をREDORD句で定義するとREADに失敗するため、1バイトで定義する。
       FD  PARA-FILE.
       01  PARA-REC                PIC X(1).
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PARA            PIC 9(01).
      *
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
           COPY    "CPCOMMONDAT5.INC"  REPLACING
                                       //TEIKI01PARA// BY //OPPARA00//.
      *
           COPY    "CPCOMMONDAT5.INC"  REPLACING
                                       //TEIKI01PARA// BY //OPPARA01//.
      *
           COPY    "CPCOMMONDAT5.INC"  REPLACING
                                       //TEIKI01PARA// BY //OPPARA02//.
      *
           COPY    "CPCOMMONDAT5.INC"  REPLACING
                                       //TEIKI01PARA// BY //OPPARA03//.
      *
           COPY    "CPCOMMONDAT5.INC"  REPLACING
                                       //TEIKI01PARA// BY //OPPARA04//.
      *
           COPY    "CPCOMMONDAT5.INC"  REPLACING
                                       //TEIKI01PARA// BY //OPPARA05//.
      *
       01  IDX-AREA.
           03  IDX1                    PIC 9(06).
      *
       01  WRK-AREA.
           03  WRK-STR                 PIC X(300000).
           03  WRK-PRINT-PG            PIC X(20).
      *
       01  WRK-PARA-AREA.
      *
           03  WRK-PARA-PGID           PIC X(20).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
           COPY    "CPONPRTID.INC".
      *
           COPY    "COMMON-SPA".
      *
      *    処方箋共通パラメタ
           COPY    "CPORCHC19.INC".
      *
      *    入院カルテ出力パラメタ
           COPY    "CPORCHCN01.INC".
      *
      *    入院請求書兼領収書共通パラメタ
           COPY    "CPORCHCN03.INC".
      *
      *    入院診療費明細書パラメタ
           COPY    "CPORCHCN04.INC".
      *
      *    外来カルテパラメタ
           COPY    "CPORCHC01.INC".
      *
      *    請求書兼領収書パラメタ
           COPY    "CPORCHC03.INC".
      *
      *    薬情一覧印刷パラメタ
           COPY    "CPORCHC30.INC".
      *
      *    カルテ３号様式（外来）パラメタ
           COPY    "CPORCHC33.INC".
      *
      *    診療費明細書パラメタ
           COPY    "CPORCHC04.INC".
      *
      *    お薬手帳パラメタ
           COPY    "CPORCHC62.INC".
      *
      *    入院処方箋パラメタ
           COPY    "CPORCHC501.INC".
      *
      *    注射処方箋パラメタ
           COPY    "CPORCHC502.INC".
      *
      *    入院指示箋パラメタ
           COPY    "CPORCHC503.INC".
      *
      *    薬情一覧印刷パラメタ
           COPY    "CPORCHCN30.INC".
      *
      *    お薬手帳パラメタ
           COPY    "CPORCHCN62.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "CPCOMMAND-PARAM.INC".
      *
       PROCEDURE                   DIVISION    USING
           COMMAND-PARAM
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           PERFORM 100-DBOPEN-SEC
      *
           INITIALIZE                  STS-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO    WRK-PARA-PGID
                                               OPPARA01
                                               OPPARA02
                                               OPPARA03
                                               OPPARA04
                                               OPPARA05
           END-UNSTRING
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           EVALUATE   WRK-PARA-PGID
      *
           WHEN    ONPRTID-ORCHCM19
               PERFORM 210-ORCHCM19-SEC
      *
           WHEN    ONPRTID-ORCHCN01
               PERFORM 210-ORCHCN01-SEC
      *
           WHEN    ONPRTID-ORCHCN02
               PERFORM 210-ORCHCN02-SEC
      *
           WHEN    ONPRTID-ORCHCN03
               PERFORM 210-ORCHCN03-SEC
      *
           WHEN    ONPRTID-ORCHCN04
               PERFORM 210-ORCHCN04-SEC
      *
           WHEN    ONPRTID-ORCHC01
               PERFORM 210-ORCHC01-SEC
      *
           WHEN    ONPRTID-ORCHC03
               PERFORM 210-ORCHC03-SEC
      *
           WHEN    ONPRTID-ORCHC30
               PERFORM 210-ORCHC30-SEC
      *
           WHEN    ONPRTID-ORCHC33
               PERFORM 210-ORCHC33-SEC
      *
           WHEN    ONPRTID-ORCHC04
               PERFORM 210-ORCHC04-SEC
      *
           WHEN    ONPRTID-ORCHC62
               PERFORM 210-ORCHC62-SEC
      *
           WHEN    ONPRTID-ORCHCN33
               PERFORM 210-ORCHCN33-SEC
      *
           WHEN    ONPRTID-ORCHC501
               PERFORM 210-ORCHC501-SEC
      *
           WHEN    ONPRTID-ORCHC502
               PERFORM 210-ORCHC502-SEC
      *
           WHEN    ONPRTID-ORCHC503
               PERFORM 210-ORCHC503-SEC
      *
           WHEN    ONPRTID-ORCHCN30
               PERFORM 210-ORCHCN30-SEC
      *
           WHEN    ONPRTID-ORCHCN62
               PERFORM 210-ORCHCN62-SEC
           END-EVALUATE
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    処方箋発行パラメタ
      *****************************************************************
       210-ORCHCM19-SEC                SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC19AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000002"          TO  ORCSPRTNM-KBNCD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC19AREA
      *
           .
       210-ORCHCM19-EXT.
           EXIT.
      *****************************************************************
      *    入院カルテ発行処理
      *****************************************************************
       210-ORCHCN01-SEC                SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHCN01AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000001"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHCN01AREA
      *
           .
       210-ORCHCN01-EXT.
           EXIT.
      *****************************************************************
      *    退院証明書発行処理
      *****************************************************************
       210-ORCHCN02-SEC                SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  PTNYUINRRK-REC
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000002"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       PTNYUINRRK-REC
      *
           .
       210-ORCHCN02-EXT.
           EXIT.
      *****************************************************************
      *    入院請求書兼領収書発行処理
      *****************************************************************
       210-ORCHCN03-SEC                SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHCN03AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000003"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       ORCHCN03AREA
                                       SPA-AREA
      *
           .
       210-ORCHCN03-EXT.
           EXIT.
      *****************************************************************
      *    入院診療費明細書発行処理
      *****************************************************************
       210-ORCHCN04-SEC                SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHCN04AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000008"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHCN04AREA
      *
           .
       210-ORCHCN04-EXT.
           EXIT.
      *****************************************************************
      *    外来カルテ発行処理
      *****************************************************************
       210-ORCHC01-SEC                 SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC01AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000001"          TO  ORCSPRTNM-KBNCD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC01AREA
      *
           .
       210-ORCHC01-EXT.
           EXIT.
      *****************************************************************
      *    請求書兼領収書発行処理
      *****************************************************************
       210-ORCHC03-SEC                 SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC03AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000003"          TO  ORCSPRTNM-KBNCD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC03AREA
      *
           .
       210-ORCHC03-EXT.
           EXIT.
      *****************************************************************
      *    薬情一覧発行処理
      *****************************************************************
       210-ORCHC30-SEC                 SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC30AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000004"          TO  ORCSPRTNM-KBNCD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC30AREA
      *
           .
       210-ORCHC30-EXT.
           EXIT.
      *****************************************************************
      *    カルテ３号様式（外来）発行処理
      *****************************************************************
       210-ORCHC33-SEC                 SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC33AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000005"          TO  ORCSPRTNM-KBNCD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC33AREA
      *
           .
       210-ORCHC33-EXT.
           EXIT.
      *****************************************************************
      *    診療費明細書発行処理
      *****************************************************************
       210-ORCHC04-SEC                 SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC04AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000008"          TO  ORCSPRTNM-KBNCD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC04AREA
      *
           .
       210-ORCHC04-EXT.
           EXIT.
      *****************************************************************
      *    お薬手帳発行処理
      *****************************************************************
       210-ORCHC62-SEC                 SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC62AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000009"          TO  ORCSPRTNM-KBNCD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC62AREA
      *
           .
       210-ORCHC62-EXT.
           EXIT.
      *****************************************************************
      *    カルテ３号（入院)発行処理
      *****************************************************************
       210-ORCHCN33-SEC                SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC33AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000004"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC33AREA
      *
           .
       210-ORCHCN33-EXT.
           EXIT.
      *****************************************************************
      *    入院処方箋発行処理
      *****************************************************************
       210-ORCHC501-SEC                SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC501AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000005"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC501AREA
      *
           .
       210-ORCHC501-EXT.
           EXIT.
      *****************************************************************
      *    注射処方箋発行処理
      *****************************************************************
       210-ORCHC502-SEC                SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC502AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000006"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC502AREA
      *
           .
       210-ORCHC502-EXT.
           EXIT.
      *****************************************************************
      *    入院指示箋発行処理
      *****************************************************************
       210-ORCHC503-SEC                SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHC503AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000007"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHC503AREA
      *
           .
       210-ORCHC503-EXT.
           EXIT.
      *****************************************************************
      *    薬情一覧発行処理
      *****************************************************************
       210-ORCHCN30-SEC                 SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHCN30AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000009"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHCN30AREA
      *
           .
       210-ORCHCN30-EXT.
           EXIT.
      *****************************************************************
      *    お薬手帳発行処理
      *****************************************************************
       210-ORCHCN62-SEC                 SECTION.
      *
           MOVE    OPPARA01        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  SPA-AREA
      *
           MOVE    OPPARA02        TO  OPPARA00
           PERFORM 800-GET-PAPA-SEC
           MOVE    WRK-STR         TO  ORCHCN62AREA
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "00000010"          TO  ORCSPRTNM-KBNCD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           PERFORM 800-ORCSPRTNM-SEC
      *
           CALL    WRK-PRINT-PG        USING
                                       SPA-AREA
                                       ORCHCN62AREA
      *
           .
       210-ORCHCN62-EXT.
           EXIT.
      *****************************************************************
      *    パラメタ取得処理
      *****************************************************************
       800-GET-PAPA-SEC                SECTION.
      *
           DISPLAY "OPPARA00 =" OPPARA00
           MOVE    SPACE           TO  WRK-STR
           MOVE    1               TO  IDX1
      *
           OPEN    INPUT   PARA-FILE
           DISPLAY "STS-PARA =" STS-PARA
      *
           PERFORM 900-READ-PARA-SEC
           DISPLAY "STS-PARA -" STS-PARA
      *
           PERFORM UNTIL ( FLG-PARA    NOT =   ZERO )
      *
               STRING  PARA-REC        DELIMITED   BY  SIZE
               INTO    WRK-STR
               WITH    POINTER IDX1
               END-STRING
      *
               PERFORM 900-READ-PARA-SEC
      *
           END-PERFORM
      *
           CLOSE   PARA-FILE
      *
      *    以下
      *    アサイン名を変数にして同じFD句で別ファイルをREADし、
      *    さらにレコード長が前ファイル＞後ファイルの場合、後ファイルのレコードの後
      *    に前ファイル内容が残る現象の対処
      *    今回はINPUTのRECが1バイトなので本当は不要
      *    OPEN    OUTPUT  PARA-FILE
      *    MOVE    SPACE           TO  PARA-REC
      *    WRITE   PARA-REC
      *    CLOSE   PARA-FILE
      *
           .
       800-GET-PAPA-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
            PERFORM 900-DBDISCONNECT-SEC
      *
            .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    オンライン帳票名取得サブ
      *****************************************************************
       800-ORCSPRTNM-SEC               SECTION.
      *
           INITIALIZE                      WRK-PRINT-PG
           INITIALIZE                      SYSKANRI-REC
      *
           MOVE    "1"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SYSYMD          TO  ORCSPRTNM-SRYYMD
      *
           CALL    "ORCSPRTNM"         USING
                                       ORCSPRTNMAREA
                                       SPA-AREA
                                       SYSKANRI-REC
           IF    ( ORCSPRTNM-RC        =   ZERO )
              MOVE ORCSPRTNM-PRTPG     TO  WRK-PRINT-PG
           ELSE
              MOVE WRK-PARA-PGID       TO  WRK-PRINT-PG
           END-IF
      *
            .
       800-ORCSPRTNM-EXT.
           EXIT.
      *****************************************************************
      *    パラメタ読込処理
      *****************************************************************
       900-READ-PARA-SEC               SECTION.
      *
           MOVE    ZERO            TO  FLG-PARA
      *
           READ    PARA-FILE
           AT  END
               MOVE    1           TO  FLG-PARA
           END-READ
      *
           .
       900-READ-PARA-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           CALL    "ORCDBMAIN"     USING
                                   MCPAREA
                                   MCPDATA-REC
                                   SPA-AREA
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBSTART"       TO  MCP-FUNC.
           CALL    "ORCDBMAIN"     USING
                                   MCPAREA
                                   MCPDATA-REC
                                   SPA-AREA
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　切断処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           CALL    "ORCDBMAIN"     USING
                                   MCPAREA
                                   MCPDATA-REC
                                   SPA-AREA
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "ORCDBMAIN"     USING
                                   MCPAREA
                                   MCPDATA-REC
                                   SPA-AREA
      *
           .
       900-DBDISCONNECT-EXT.
           EXIT.
