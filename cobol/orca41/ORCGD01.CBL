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
      *
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGD01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : データチェックサブ
      *  コンポーネント名  : データチェック条件入力
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01.07.13    ひさなが 　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    ひさなが     01/11/08  実日数の確認追加
      *  01.00.01    ひさなが     02/01/25  診療年が和暦の場合西暦変換
      *  01.00.01    ひさなが     02/03/18  薬剤、適応病名のチェク追加
      *  01.00.02    ひさなが     02/05/10  ジョブ管理検索追加
      *  01.00.02    ひさなが     02/05/10  半角チェックの追加
      *  01.00.02    ひさなが     02/06/26  印刷管理・印刷ＤＢ追加
      *  01.00.03    ひさなが     02/09/13  ディレクトリをサブプロへ
      *  01.00.04    ひさなが     03/04/17  入院時保険組合せチェック
      *  01.00.05    ひさなが     03/05/13  ボタンが押せない場合修正
      *  01.00.06    ひさなが     03/06/06  病名コード抜けのチェク追加
      *  01.00.07    ひさなが     03/07/29  チェック内容全件印刷追加
      *  01.00.08    ひさなが     03/08/26  院外処方、自費の指示追加
      *  01.00.09    ひさなが     03/09/11  処理メッセージ修正
      *                                     指示に含まないを追加
      *  01.00.10    NACL-太田    03/11/19  シェルパラメータの変更他
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラー用ファイル 名称領域 
           COPY    "CPCOMMONDAT6.INC"
                                   REPLACING  //DTCHK//
                                   BY         //DTCHKERR//.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    データチェック共通パラメタ
           COPY    "D01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-D01.
           03  SPA-D01-AREA.
               05  SPA-GMN-D01-CUR                         PIC 9(03).
               05  SPA-GMN-D01-AREA.
                   07  SPA-GMN-D01-INPUT-AREA.
                       09  SPA-GMN-D01-SRYYM               PIC X(07).
                       09  SPA-GMN-D01-NYUGAIKBN-G.
                           11  SPA-GMN-D01-NYUGAIKBN       PIC X(01).
                           11                              PIC X(01).
                           11  SPA-GMN-D01-NYUGAIKBNMEI    PIC X(18).
                       09  SPA-GMN-D01-CHKKBN-OCC          OCCURS  18.
                           11  SPA-GMN-D01-CHKKBN-G.
                               13  SPA-GMN-D01-CHKKBN      PIC X(01).
                               13                          PIC X(01).
                               13  SPA-GMN-D01-CHKKBNMEI   PIC X(18).
                       09  SPA-GMN-D01-JIHIPROCKBN-G.
                           11  SPA-GMN-D01-JIHIPROCKBN     PIC X(01).
                           11                              PIC X(01).
                           11  SPA-GMN-D01-JIHIPROCKBNMEI  PIC X(18).
                       09  SPA-GMN-D01-INGAIPROCKBN-G.
                           11  SPA-GMN-D01-INGAIPROCKBN    PIC X(01).
                           11                              PIC X(01).
                           11  SPA-GMN-D01-INGAIPROCKBNMEI PIC X(18).
                   07  SPA-GMN-D01-CHKMSG-OCC              OCCURS  18.
                       09  SPA-GMN-D01-CHKMSG              PIC X(40).
                   07  SPA-GMN-D01-JIHIPROCMSG             PIC X(40).
                   07  SPA-GMN-D01-INGAIPROCMSG            PIC X(40).
                   07  SPA-GMN-D01-NYUGAIKBNLST-G.
                       09  SPA-GMN-D01-NYUGAIKBN-MAX       PIC 9(03).
                       09  SPA-GMN-D01-NYUGAIKBNLST        OCCURS  5.
                           11  SPA-GMN-D01-NYUGAIKBNL      PIC X(01).
                           11                              PIC X(01).
                           11  SPA-GMN-D01-NYUGAIKBNMEIL   PIC X(18).
                   07  SPA-GMN-D01-CHKKBNLST-G.
                       09  SPA-GMN-D01-CHKKBN-MAX          PIC 9(03).
                       09  SPA-GMN-D01-CHKKBNLST           OCCURS  5.
                           11  SPA-GMN-D01-CHKKBNL         PIC X(01).
                           11                              PIC X(01).
                           11  SPA-GMN-D01-CHKKBNMEIL      PIC X(18).
                   07  SPA-GMN-D01-JIHIPROCKBNLST-G.
                       09  SPA-GMN-D01-JIHIPROCKBN-MAX     PIC 9(03).
                       09  SPA-GMN-D01-JIHIPROCKBNLST      OCCURS  5.
                           11  SPA-GMN-D01-JIHIPROCKBNL    PIC X(01).
                           11                              PIC X(01).
                           11  SPA-GMN-D01-JIHIPROCKBNMEIL PIC X(18).
                   07  SPA-GMN-D01-INGAIPROCKBNLST-G.
                       09  SPA-GMN-D01-INGAIPROCKBN-MAX    PIC 9(03).
                       09  SPA-GMN-D01-INGAIPROCKBNLST     OCCURS  5.
                           11  SPA-GMN-D01-INGAIPROCKBNL   PIC X(01).
                           11                              PIC X(01).
                           11  SPA-GMN-D01-INGAIPROCKBNMEIL
                                                           PIC X(18).
               05  SPA-NAIB-D01-AREA.
                   07  SPA-NAI-D01-INPUT-AREA.
                       09  SPA-NAI-D01-SRYYM               PIC X(06).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                     PIC 9(01).
           03  FLG-ERR                     PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-HIZUKE-ERR              PIC 9(01).
      *
      *    エンドステータス領域
       01  STS-AREA.
           03  STS-DID1                    PIC X(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                        PIC 9(05).
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
           03  IDXA                        PIC 9(05).
           03  IDXB                        PIC 9(05).
           03  IDX-CMB                     PIC 9(05).
      *
      *    作業領域
       01  WRK-AREA.
           03  WRK-PRTKANRI-RENNUM         PIC 9(04).
           03  WRK-CMB-CD                  PIC X(10).
           03  WRK-CMB-ITM-G.
               07  WRK-CMB-ITM             PIC X(200).
           03  WRK-MCP-WIDGET              PIC X(64).
           03  WRK-ERR-CUR                 PIC 9(03).
           03  WRK-YMD                     PIC X(10).
           03  WRK-SYMD                    PIC X(08).
           03  WRK-HENYMDG                 PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO                 PIC X(01).
               05  WRK-HYY                 PIC 9(02).
               05  FILLER                  PIC X(01)   VALUE   ".".
               05  WRK-HMM                 PIC 9(02).
               05  FILLER                  PIC X(01)   VALUE   ".".
               05  WRK-HDD                 PIC 9(02).
           03  WRK-HENTIME.
               05  WRK-HH                  PIC X(02).
               05  FILLER                  PIC X(01)   VALUE   ".".
               05  WRK-MM                  PIC X(02).
               05  FILLER                  PIC X(01)   VALUE   ".".
               05  WRK-SS                  PIC X(02).
           03  WRK-ERRMSG                  PIC X(200).
           03  WRK-DIDMSG                  PIC X(200).
           03  WRK-STPAGE                  PIC 9(05).
           03  WRK-EDPAGE                  PIC 9(05).
           03  WRK-PAGE                    PIC ZZZZZZZZZ9.
           03  WRK-EDTYMD1                 PIC X(10).
           03  WRK-EDTYMD3                 PIC X(22).
           03  WRK-Z9                      PIC Z9.
      *
       01  CONST-AREA.
           03  CONST-LINE                  PIC X(40)   VALUE
               "＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿".
           03  CONST-CHKKBN-MAX            PIC 9(03)   VALUE   14.
           03  CONST-CHKMSG-VAL.
               05                          PIC X(40)   VALUE
               "保険者番号抜け".
               05                          PIC X(40)   VALUE
               "被保険者記号・番号抜け".
               05                          PIC X(40)   VALUE
               "公費負担者番号・受給者番号抜け".
               05                          PIC X(40)   VALUE
               "保険適応年齢".
               05                          PIC X(40)   VALUE
               "患者病名".
               05                          PIC X(40)   VALUE
               "診療開始日".
               05                          PIC X(40)   VALUE
               "疑い病名".
               05                          PIC X(40)   VALUE
               "薬剤と病名".
               05                          PIC X(40)   VALUE
               "診療行為と病名".
               05                          PIC X(40)   VALUE
               "併用禁忌の薬剤".
               05                          PIC X(40)   VALUE
               "併用算定の診療行為".
               05                          PIC X(40)   VALUE
               "実日数".
               05                          PIC X(40)   VALUE
               "患者氏名".
               05                          PIC X(40)   VALUE
               "保険組合せ有効期間".
           03  CONST-CHKMSG-R              REDEFINES   CONST-CHKMSG-VAL.
               05  CONST-CHKMSG            PIC X(40)   OCCURS  14.
           03  CONST-JIHIPROCMSG           PIC X(40)   VALUE
               "自費保険患者の処理".
           03  CONST-INGAIPROCMSG          PIC X(40)   VALUE
               "院外処方の処理".
      *
      *    システム管理ＤＢ（３００３）のキー値
           03  CONST-3003-KBNCD            PIC X(08) VALUE "041".
      *    印刷管理ＤＢのキー値
           03  CONST-PRTKANRI-TBL-KEY      PIC X(08) VALUE "ORCBSD1".
           03  CONST-PRTKANRI-TBL-GROUP    PIC X(14) VALUE SPACE.
      *    ジョブ管理ＤＢのキー値
           03  CONST-JOB-SHELLID           PIC X(08) VALUE "ORCBSD1".
           03  CONST-JOB-JOBID             PIC 9(07) VALUE ZERO.
      *
      *
       01  WRK-LNK-AREA.
           COPY    "CPORCSPRTLNK.INC".
      *
      *    データチェック一括処理パラメータ
           COPY    "CPORCBSD01PARA.INC".
      *
       01  SHELL-AREA.
           03  SHELL-NAME                  PIC X(50)   VALUE
               "scripts/allways/orcbsd01.sh".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理
           COPY    "CPSK1031.INC".
           COPY    "CPSK3003.INC".
      *
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    フィアルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
      *     テーブルアクセス
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "D01.INC".
           COPY    "D99.INC".
           COPY    "DERR.INC".
           COPY    "DID1.INC".
           COPY    "DID2.INC".
      *
      *
       PROCEDURE                       DIVISION    USING
                                                   MCPAREA
                                                   SPAAREA
                                                   LINKAREA
                                                   SCRAREA.
      *****************************************************************
      *    主    処    理
      *****************************************************************
      *
       000-PROC-SEC                    SECTION.
      *
           INITIALIZE                      FLG-AREA
                                           IDX-AREA
                                           WRK-AREA
      *
           MOVE    SPA-COMMON          TO  SPA-AREA.
           MOVE    SPA-WORK            TO  SPA-D01KYOUTU
           MOVE    SPA-FREE            TO  SPA-D01
      *
           MOVE    SPACE               TO  SPA-ERRCD
           MOVE    ZERO                TO  FLG-END
      *
           EVALUATE    MCP-STATUS  ALSO    MCP-EVENT
           WHEN    "LINK"          ALSO    ANY
               PERFORM 100-INIT-SEC
      *    画面遷移
           WHEN    "PUTG"          ALSO    "CLICKED"
               PERFORM 200-GMNSENI
      *    入力
           WHEN    OTHER
               PERFORM 200-ENTRY
           END-EVALUATE
      *
      *    画面遷移がない時、画面表示へ
           IF    ( FLG-END             =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-D01KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-D01             TO  SPA-FREE
           .
      *
       000-PROC-SEC-EXT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
      *    エラー画面より
           IF    ( SPA-MOTOPG          =   "DERR" )
               MOVE    SPACE           TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF    ( FLG-END         =   1 )
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "D01    "           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
      *
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF    ( LINKAREA        NOT =   SPACE )
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
      *
      *        元の画面へ戻す
               IF    ( SPA-MOTOPG      =   "XA01"  OR  "XB01" )
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-D01
                   MOVE    SPA-WORK        TO  SPA-D01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
      *
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    確認画面１
           WHEN    "DID1"
               PERFORM 330-DID1-SET-SEC
               GO  TO  300-SCREEN-EXT
      *    確認画面２
           WHEN    "DID2"
               PERFORM 340-DID2-SET-SEC
               GO      TO      300-SCREEN-EXT
      *    処理結果画面
           WHEN    "D99"
               GO  TO  300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC.
      *
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC                  SECTION.
      *
           INITIALIZE                      SPA-D01
                                           SPA-D01KYOUTU
      *
      *    入外区分コンボ編集
           PERFORM 3101-NYUGAIKBNLST-HEN-SEC
      *
      *    チェック項目名編集
           PERFORM 3101-CHKMSG-HEN-SEC
      *
      *    チェック項目コンボ編集
           PERFORM 3101-CHKKBNLST-HEN-SEC
      *
      *    自費保険者の処理項目コンボ編集処理
           PERFORM 3101-JIHIPROCKBNLST-HEN-SEC
      *
      *    院外処方の処理項目コンボ編集処理
           PERFORM 3101-INGAIPROCKBNLST-HEN-SEC
      *
           MOVE    CONST-JIHIPROCMSG   TO  SPA-GMN-D01-JIHIPROCMSG
           MOVE    CONST-INGAIPROCMSG  TO  SPA-GMN-D01-INGAIPROCMSG
      *
      *
           PERFORM 420-CLEAR-SEC
      *
           MOVE    1                   TO  SPA-GMN-D01-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入外区分コンボ編集処理
      *****************************************************************
       3101-NYUGAIKBNLST-HEN-SEC       SECTION.
      *
           INITIALIZE                      SPA-GMN-D01-NYUGAIKBNLST-G
      *
           IF      SPA-BEDSU       >   ZERO
               MOVE    "1"             TO  SPA-GMN-D01-NYUGAIKBNL    (1)
               MOVE    "入院"          TO  SPA-GMN-D01-NYUGAIKBNMEIL (1)
               MOVE    "2"             TO  SPA-GMN-D01-NYUGAIKBNL    (2)
               MOVE    "入院外"        TO  SPA-GMN-D01-NYUGAIKBNMEIL (2)
               MOVE    2               TO  SPA-GMN-D01-NYUGAIKBN-MAX
           ELSE
               MOVE    "2"             TO  SPA-GMN-D01-NYUGAIKBNL    (1)
               MOVE    "入院外"        TO  SPA-GMN-D01-NYUGAIKBNMEIL (1)
               MOVE    1               TO  SPA-GMN-D01-NYUGAIKBN-MAX
           END-IF
      *
           IF    ( SPA-BEDSU           >   ZERO )
               MOVE    2               TO  SPA-GMN-D01-NYUGAIKBN-MAX
               MOVE    "1"             TO  SPA-GMN-D01-NYUGAIKBNL    (1)
               MOVE    "入院"          TO  SPA-GMN-D01-NYUGAIKBNMEIL (1)
               MOVE    "2"             TO  SPA-GMN-D01-NYUGAIKBNL    (2)
               MOVE    "外来"          TO  SPA-GMN-D01-NYUGAIKBNMEIL (2)
           ELSE
               MOVE    1               TO  SPA-GMN-D01-NYUGAIKBN-MAX
               MOVE    "2"             TO  SPA-GMN-D01-NYUGAIKBNL    (1)
               MOVE    "外来"          TO  SPA-GMN-D01-NYUGAIKBNMEIL (1)
           END-IF
      *
           .
       3101-NYUGAIKBNLST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェック項目名編集処理
      *****************************************************************
       3101-CHKMSG-HEN-SEC             SECTION.
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   CONST-CHKKBN-MAX )
      *
               MOVE    IDX0            TO  WRK-Z9
               MOVE    CONST-LINE      TO  SPA-GMN-D01-CHKMSG (IDX0)
               STRING  WRK-Z9              DELIMITED   BY  SIZE
                       ". "                DELIMITED   BY  SIZE
                       CONST-CHKMSG (IDX0) DELIMITED   BY  SPACE
               INTO    SPA-GMN-D01-CHKMSG (IDX0)
               END-STRING
      *
           END-PERFORM
      *
           .
       3101-CHKMSG-HEN-EXT.
           EXIT.
      *****************************************************************
      *    チェック項目コンボ編集処理
      *****************************************************************
       3101-CHKKBNLST-HEN-SEC          SECTION.
      *
           INITIALIZE                      SPA-GMN-D01-CHKKBNLST-G
           MOVE    2                   TO  SPA-GMN-D01-CHKKBN-MAX
      *
           MOVE    "1"                 TO  SPA-GMN-D01-CHKKBNL    (1)
           MOVE    "確認　印刷"        TO  SPA-GMN-D01-CHKKBNMEIL (1)
           MOVE    "2"                 TO  SPA-GMN-D01-CHKKBNL    (2)
           MOVE    "確認　全印刷"      TO  SPA-GMN-D01-CHKKBNMEIL (2)
      *
           .
       3101-CHKKBNLST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    自費保険者の処理項目コンボ編集処理
      *****************************************************************
       3101-JIHIPROCKBNLST-HEN-SEC     SECTION.
      *
           INITIALIZE                  SPA-GMN-D01-JIHIPROCKBNLST-G
           MOVE    3               TO  SPA-GMN-D01-JIHIPROCKBN-MAX
      *
           MOVE    " "             TO  SPA-GMN-D01-JIHIPROCKBNL    (1)
           MOVE    "含まない"      TO  SPA-GMN-D01-JIHIPROCKBNMEIL (1)
           MOVE    "1"             TO  SPA-GMN-D01-JIHIPROCKBNL    (2)
           MOVE    "自費保険患者を含む"
                                   TO  SPA-GMN-D01-JIHIPROCKBNMEIL (2)
           MOVE    "2"             TO  SPA-GMN-D01-JIHIPROCKBNL    (3)
           MOVE    "自費保険患者のみ"
                                   TO  SPA-GMN-D01-JIHIPROCKBNMEIL (3)
      *
           .
       3101-JIHIPROCKBNLST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    院外処方の処理項目コンボ編集処理
      *****************************************************************
       3101-INGAIPROCKBNLST-HEN-SEC    SECTION.
      *
           INITIALIZE                  SPA-GMN-D01-INGAIPROCKBNLST-G
           MOVE    3               TO  SPA-GMN-D01-INGAIPROCKBN-MAX
      *
           MOVE    " "             TO  SPA-GMN-D01-INGAIPROCKBNL    (1)
           MOVE    "含まない"      TO  SPA-GMN-D01-INGAIPROCKBNMEIL (1)
           MOVE    "1"             TO  SPA-GMN-D01-INGAIPROCKBNL    (2)
           MOVE    "院外処方を含む"
                                   TO  SPA-GMN-D01-INGAIPROCKBNMEIL (2)
           MOVE    "2"             TO  SPA-GMN-D01-INGAIPROCKBNL    (3)
           MOVE    "院外処方のみ"  TO  SPA-GMN-D01-INGAIPROCKBNMEIL (3)
      *
           .
       3101-INGAIPROCKBNLST-HEN-EXT.
           EXIT.
      *****************************************************************
      *    確認画面（ＤＩＤ１）ＯＫ処理
      *****************************************************************
       330-DID1-SET-SEC            SECTION.
      *
           IF    ( SPA-DID1-FLG    =   "OK" )
               EVALUATE    SPA-DIDCD
               WHEN    "6666"
                   MOVE    "JOIN"      TO  MCP-PUTTYPE
                   PERFORM 210-BACK-SYORI-SEC
               WHEN    OTHER
                   PERFORM 490-PRINT-SEC
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE               TO  SPA-DID1-FLG
           MOVE    SPACE               TO  SPA-DIDCD
      *
           .
       330-DID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＤＩＤ２）ＯＫ処理
      *****************************************************************
       340-DID2-SET-SEC            SECTION.
      *
           IF    ( SPA-DID1-FLG    =   "OK" OR "NO" )
               PERFORM 490-PRINT-SEC
           END-IF
      *
           MOVE    SPACE           TO  SPA-DID1-FLG
           MOVE    SPACE           TO  SPA-DIDCD
           .
       340-DID2-SET-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       490-PRINT-SEC                       SECTION.
      *
      *    ＪＯＢＩＤ（３００３）削除処理
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    CONST-3003-KBNCD    TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
               MOVE    SYS-3003-REC    TO  MCPDATA-REC
               MOVE    "DBDELETE"      TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    "4001"      TO  SPA-ERRCD
                   GO  TO  490-PRINT-EXT
               END-IF
           END-IF
      *
      *    ジョブ管理削除処理
           MOVE    "ALL"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    CONST-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING   ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           IF    ( SJOBKANRI-RETURN    =   ZERO )
               CONTINUE
           ELSE
               MOVE    "4002"          TO  SPA-ERRCD
               GO  TO  490-PRINT-EXT
           END-IF
      *
           MOVE    ZERO                TO  CONST-JOB-JOBID
                                           WRK-PRTKANRI-RENNUM
           MOVE    SPACE               TO  CONST-PRTKANRI-TBL-GROUP
      *
           MOVE    "DTCHKERR"          TO  DTCHKERR-FILE-ID
           MOVE    SPA-TERMID          TO  DTCHKERR-TERMID
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                      SYS-1031-REC
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "2"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SYSYMD          TO  ORCSPRTNM-SRYYMD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1031-REC
           IF    ( ORCSPRTNM-RC    NOT =   ZERO )
               INITIALIZE                  SYS-1031-REC
           END-IF
      *
           PERFORM 800-MCNDATE-SEC
           MOVE    SMCNDATE-YMD        TO
                                   CONST-PRTKANRI-TBL-GROUP (1:8)
           MOVE    SMCNDATE-HMS        TO
                                   CONST-PRTKANRI-TBL-GROUP (9:)
      *
           PERFORM 45011-JOBKANRI-HENSYU-SEC
      *
      *    印刷用スクリプト処理
           MOVE    SPACE               TO  LNK-PRTKANRI-AREA
           INITIALIZE                      LNK-PRTKANRI-AREA
      *
           COMPUTE WRK-PRTKANRI-RENNUM
               =   WRK-PRTKANRI-RENNUM     +   1
      *
           MOVE    WRK-PRTKANRI-RENNUM
                                   TO  LNK-PRTKANRI-RENNUM
           MOVE    CONST-PRTKANRI-TBL-KEY
                                   TO  LNK-PRTKANRI-TBL-KEY
           MOVE    CONST-PRTKANRI-TBL-GROUP
                                   TO  LNK-PRTKANRI-TBL-GROUP
           MOVE    SPA-NAI-D01-SRYYM
                                   TO  LNK-PRTKANRI-SRYYM
           MOVE    SPA-SYSYMD      TO  LNK-PRTKANRI-SKYYMD
           MOVE    "orcbsd01.sh"   TO  LNK-PRTKANRI-SHELLID
           MOVE    ZERO            TO  LNK-PRTKANRI-PRIORITY
           MOVE    SPA-TERMID      TO  LNK-PRTKANRI-TERMID
           MOVE    SPA-OPID        TO  LNK-PRTKANRI-OPID
           MOVE    SYS-1031-PRTNM (11)
                                   TO  LNK-PRTKANRI-PRTNM
      *
           INITIALIZE                  ORCBSD01PARA
           MOVE    SPA-NAI-D01-SRYYM
                                   TO  ORCBSD01-SRYYM
           MOVE    SPA-GMN-D01-NYUGAIKBN
                                   TO  ORCBSD01-NYUGAIKBN
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   CONST-CHKKBN-MAX )
      *
               IF    ( SPA-GMN-D01-CHKKBN (IDX0)   =   SPACE )
                   MOVE    ZERO    TO  ORCBSD01-CHKKBN (IDX0)
               ELSE
                   MOVE    SPA-GMN-D01-CHKKBN (IDX0)
                                   TO  ORCBSD01-CHKKBN (IDX0)
               END-IF
      *
           END-PERFORM
      *
           IF    ( SPA-GMN-D01-JIHIPROCKBN     =   SPACE )
               MOVE    ZERO        TO  ORCBSD01-JIHIPROCKBN
           ELSE
               MOVE    SPA-GMN-D01-JIHIPROCKBN
                                   TO  ORCBSD01-JIHIPROCKBN
           END-IF
      *
           IF    ( SPA-GMN-D01-INGAIPROCKBN    =   SPACE )
               MOVE    ZERO        TO  ORCBSD01-INGAIPROCKBN
           ELSE
               MOVE    SPA-GMN-D01-INGAIPROCKBN
                                   TO  ORCBSD01-INGAIPROCKBN
           END-IF
      *
           MOVE    SPACE           TO  SHELLTBL
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    SHELL-NAME      TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
           MOVE    LNK-PRTKANRI-RENNUM
                                           TO  SHELLTBL-ARG1
           MOVE    LNK-PRTKANRI-TBL-KEY
                                           TO  SHELLTBL-ARG2
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                           TO  SHELLTBL-ARG3
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                           TO  SHELLTBL-ARG4
           MOVE    LNK-PRTKANRI-SRYYM
                                           TO  SHELLTBL-ARG5
           MOVE    LNK-PRTKANRI-SKYYMD
                                           TO  SHELLTBL-ARG6
           MOVE    LNK-PRTKANRI-SHELLID
                                           TO  SHELLTBL-ARG7
           MOVE    LNK-PRTKANRI-PRIORITY
                                           TO  SHELLTBL-ARG8
           MOVE    LNK-PRTKANRI-TERMID
                                           TO  SHELLTBL-ARG9
           MOVE    LNK-PRTKANRI-OPID
                                           TO  SHELLTBL-ARG10
           MOVE    LNK-PRTKANRI-PRTNM
                                           TO  SHELLTBL-ARG11
      *
           MOVE    CONST-JOB-JOBID
                                           TO  SHELLTBL-ARG12
           MOVE    CONST-JOB-SHELLID
                                           TO  SHELLTBL-ARG13
           MOVE    SPA-HOSPID              TO  SHELLTBL-ARG14
      *
           MOVE    DTCHKERRPARA            TO  SHELLTBL-ARG15
      *
           MOVE    ORCBSD01-SRYYM          TO  SHELLTBL-ARG16
      *
           MOVE    ORCBSD01-NYUGAIKBN      TO  SHELLTBL-ARG17
      *
           MOVE    ORCBSD01-CHKKBN-G       TO  SHELLTBL-ARG18
      *
           MOVE    ORCBSD01-JIHIPROCKBN    TO  SHELLTBL-ARG19
      *
           MOVE    ORCBSD01-INGAIPROCKBN   TO  SHELLTBL-ARG20
      *
           MOVE    SHELLTBL                TO  MCPDATA-REC
           MOVE    "SHELL"                 TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                           TO  MCP-PATH
           CALL    "MCPSUB"    USING
                               MCPAREA
                               MCPDATA-REC
      *
      *    印刷処理
           IF     ( SPA-DID1-FLG        =   "OK" )
               PERFORM 45011-JOBKANRI-HENSYU-SEC
      *
               MOVE    0                   TO  WRK-STPAGE
               MOVE    99999               TO  WRK-EDPAGE
      *
               MOVE    SPACE               TO  SHELLTBL
      *
      *        ファイルデイレクトリ位置指定
               INITIALIZE                  ORCSMKPASSAREA
               MOVE    "/scripts/allways/print.sh"
                                           TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
               MOVE    SPACE               TO  LNK-PRTKANRI-AREA
               INITIALIZE                      LNK-PRTKANRI-AREA
               MOVE    CONST-PRTKANRI-TBL-KEY
                                           TO  LNK-PRTKANRI-TBL-KEY
               MOVE    CONST-PRTKANRI-TBL-GROUP
                                           TO  LNK-PRTKANRI-TBL-GROUP
               MOVE    ZERO                TO  LNK-PRTKANRI-RENNUM
               MOVE    ZERO                TO  LNK-PRTKANRI-SHORI-RENNUM
               MOVE    SPA-NAI-D01-SRYYM   TO  LNK-PRTKANRI-SRYYM
               MOVE    SPA-SYSYMD          TO  LNK-PRTKANRI-SKYYMD
               MOVE    "print.sh"          TO  LNK-PRTKANRI-SHELLID
               MOVE    ZERO                TO  LNK-PRTKANRI-PRIORITY
               MOVE    SPA-TERMID          TO  LNK-PRTKANRI-TERMID
               MOVE    SPA-OPID            TO  LNK-PRTKANRI-OPID
               MOVE    LNK-PRTKANRI-RENNUM TO  SHELLTBL-ARG1
               MOVE    LNK-PRTKANRI-TBL-KEY
                                           TO  SHELLTBL-ARG2
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                           TO  SHELLTBL-ARG3
               MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                           TO  SHELLTBL-ARG4
               MOVE    LNK-PRTKANRI-SRYYM  TO  SHELLTBL-ARG5
               MOVE    LNK-PRTKANRI-SKYYMD TO  SHELLTBL-ARG6
               MOVE    LNK-PRTKANRI-SHELLID
                                           TO  SHELLTBL-ARG7
               MOVE    LNK-PRTKANRI-PRIORITY
                                           TO  SHELLTBL-ARG8
               MOVE    LNK-PRTKANRI-TERMID TO  SHELLTBL-ARG9
               MOVE    LNK-PRTKANRI-OPID   TO  SHELLTBL-ARG10
               MOVE    LNK-PRTKANRI-PRTNM  TO  SHELLTBL-ARG11
      *
               MOVE    DTCHKERRPARA        TO  SHELLTBL-ARG12
               MOVE    CONST-JOB-JOBID     TO  SHELLTBL-ARG13
               MOVE    CONST-JOB-SHELLID
                                           TO  SHELLTBL-ARG14
               MOVE    WRK-STPAGE          TO  SHELLTBL-ARG15
               MOVE    WRK-EDPAGE          TO  SHELLTBL-ARG16
               MOVE    SHELLTBL            TO  MCPDATA-REC
               MOVE    "SHELL"             TO  MCP-FUNC
               MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
               CALL    "MCPSUB"            USING
                                           MCPAREA
                                           MCPDATA-REC
           END-IF
      *
      *    ＪＯＢＩＤ更新処理
           PERFORM 45012-JOBID-UPD-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-PRINT-EXT
           END-IF
      *
           PERFORM 490-SYORIKAKUNIN-SEC
      *
           .
       490-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ開始セット処理
      *****************************************************************
       45011-JOBKANRI-HENSYU-SEC       SECTION.
      *
           COMPUTE CONST-JOB-JOBID     =   CONST-JOB-JOBID +   1
      *
           MOVE    "DEL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CONST-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    CONST-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           MOVE    "JBS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    CONST-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    CONST-JOB-SHELLID
                                   TO  JOB-SHELLID
           MOVE    SPA-TERMID      TO  JOB-TERMID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           .
       45011-JOBKANRI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＪＯＢＩＤ更新処理
      *****************************************************************
       45012-JOBID-UPD-SEC    SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    CONST-3003-KBNCD    TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    CONST-3003-KBNCD    TO  SYS-3003-KBNCD
           MOVE    ZERO                TO  SYS-3003-STYUKYMD
           MOVE    ALL "9"             TO  SYS-3003-EDYUKYMD
           MOVE    CONST-PRTKANRI-TBL-KEY
                                       TO  SYS-3003-TBL-KEY
           MOVE    CONST-PRTKANRI-TBL-GROUP
                                       TO  SYS-3003-TBL-GROUP
           MOVE    CONST-JOB-JOBID     TO  SYS-3003-JOBID
      *
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    "DBUPDATE"      TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"      TO  MCP-FUNC
           END-IF
      *
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "4003"          TO  SPA-ERRCD
               GO  TO  45012-JOBID-UPD-EXT
           END-IF
      *
           .
       45012-JOBID-UPD-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                     SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
           WHEN    "CLICKED"       ALSO    "B01"
      *        戻る
               MOVE   "CHANGE"         TO  MCP-PUTTYPE
               PERFORM 210-BACK
           WHEN    "CLICKED"       ALSO    "B02"
      *        クリア
               PERFORM 420-CLEAR-SEC
           WHEN    "CLICKED"       ALSO    "B03"
      *        確認
               PERFORM 430-KAKUNIN-SEC
           WHEN    "CLICKED"       ALSO    "B04"
      *        確認全印刷
               PERFORM 440-KAKUNIN-ALL-SEC
           WHEN    "CLICKED"       ALSO    "B05"
      *        再印刷
               PERFORM 450-REPRINT-SEC
           WHEN    "CLICKED"       ALSO    "B11"
      *        情報削除
               PERFORM 490-JYOUHOU-DEL-SEC
           WHEN    "CLICKED"       ALSO    "B12"
      *        確定
               PERFORM 490-KAKUTEI-SEC
           WHEN    "CLICKED"       ALSO    "B12S"
      *        処理確認
               PERFORM 490-SYORIKAKUNIN-SEC
           END-EVALUATE.
      *
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
      *    EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    WHEN    "XXXX"
      *        入力個所のセット
      *        PERFORM 400-GMN-INPUT-SEC
      *        入力チェック処理
      *        PERFORM 410-INPUT-CHK-SEC
      *    END-EVALUATE
      *
      *    入力個所のセット
           PERFORM 400-GMN-INPUT-SEC
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       400-GMN-INPUT-SEC           SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-D01-CUR
      *
           .
      *
       400-GMN-INPUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
             OR  ( FLG-END     NOT =   ZERO  )
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC            SECTION.
      *
      *    処理年月
           MOVE    D01-SRYYM           TO  SPA-GMN-D01-SRYYM
      *
      *    入外区分
           MOVE    D01-NYUGAIKBN       TO  SPA-GMN-D01-NYUGAIKBN-G
      *
      *    チェック項目
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   CONST-CHKKBN-MAX )
      *
               MOVE    D01-CHKKBN (IDX0)
                                       TO  SPA-GMN-D01-CHKKBN-G (IDX0)
      *
           END-PERFORM
      *
      *    自費保険者の処理項目
           MOVE    D01-JIHIPROCKBN     TO  SPA-GMN-D01-JIHIPROCKBN-G
      *    院外処方の処理項目
           MOVE    D01-INGAIPROCKBN    TO  SPA-GMN-D01-INGAIPROCKBN-G
      *
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
      *    診療年月チェック
           PERFORM 4101-SRYYM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    入外区分処理チェック
           PERFORM 4101-NYUGAIKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    チェック項目チェック
           PERFORM VARYING IDXA    FROM    1   BY  1
                       UNTIL ( IDXA    >   CONST-CHKKBN-MAX )
      *
               PERFORM 4101-CHKKBN-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4102-KIHON-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
      *    自費保険者の処理項目チェック
           PERFORM 4101-JIHIPROCKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    院外処方の処理項目チェック
           PERFORM 4101-INGAIPROCKBN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療年月チェック
      *****************************************************************
       4101-SRYYM-CHK-SEC              SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI-D01-SRYYM
      *
           IF    ( SPA-GMN-D01-SRYYM   =   SPACE )
               MOVE    SPA-SYSYMDWH(1:6)   TO  SPA-GMN-D01-SRYYM
               MOVE    SPA-SYSYMD(1:6)     TO  SPA-NAI-D01-SRYYM
               GO  TO  4101-SRYYM-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-D01-SRYYM   TO  WRK-YMD
           PERFORM 5003-NENGETSU-CHK-SEC
           IF    ( FLG-HIZUKE-ERR  NOT =   ZERO )
               MOVE    1               TO  SPA-GMN-D01-CUR
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  4101-SRYYM-CHK-EXT
           END-IF
      *
           MOVE    WRK-HENYMDG (1:6)   TO  SPA-GMN-D01-SRYYM
           MOVE    WRK-SYMD    (1:6)   TO  SPA-NAI-D01-SRYYM
      *
           .
       4101-SRYYM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入外区分チェック
      *****************************************************************
       4101-NYUGAIKBN-CHK-SEC          SECTION.
      *
           MOVE    SPA-GMN-D01-NYUGAIKBN   TO  WRK-CMB-CD
           PERFORM 4200-NYUGAIKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM             =   SPACE )
               MOVE    "2"                 TO  WRK-CMB-CD
               PERFORM 4200-NYUGAIKBNLST-CHK-SEC
               MOVE    WRK-CMB-ITM         TO  SPA-GMN-D01-NYUGAIKBN-G
           ELSE
               MOVE    WRK-CMB-ITM         TO  SPA-GMN-D01-NYUGAIKBN-G
           END-IF
      *
           .
       4101-NYUGAIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    チェック項目チェック
      *****************************************************************
       4101-CHKKBN-CHK-SEC             SECTION.
      *
           COMPUTE WRK-ERR-CUR     =   IDXA    +   2
      *
           IF    ( SPA-GMN-D01-CHKKBN-G (IDXA) =   SPACE )
               GO  TO  4101-CHKKBN-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-D01-CHKKBN (IDXA)
                                       TO  WRK-CMB-CD
           PERFORM 4200-CHKKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    WRK-ERR-CUR     TO  SPA-GMN-D01-CUR
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  4101-CHKKBN-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-D01-CHKKBN-G (IDXA)
      *
           .
       4101-CHKKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    自費保険者の処理項目チェック処理
      *****************************************************************
       4101-JIHIPROCKBN-CHK-SEC        SECTION.
      *
           MOVE    SPA-GMN-D01-JIHIPROCKBN
                                       TO  WRK-CMB-CD
           PERFORM 4200-JIHIPROCKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    SPACE           TO  WRK-CMB-CD
               PERFORM 4200-JIHIPROCKBNLST-CHK-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-D01-JIHIPROCKBN-G
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-D01-JIHIPROCKBN-G
           END-IF
      *
           .
       4101-JIHIPROCKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    院外処方の処理項目チェック処理
      *****************************************************************
       4101-INGAIPROCKBN-CHK-SEC        SECTION.
      *
           MOVE    SPA-GMN-D01-INGAIPROCKBN
                                       TO  WRK-CMB-CD
           PERFORM 4200-INGAIPROCKBNLST-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    SPACE           TO  WRK-CMB-CD
               PERFORM 4200-INGAIPROCKBNLST-CHK-SEC
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-D01-INGAIPROCKBN-G
           ELSE
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-D01-INGAIPROCKBN-G
           END-IF
      *
           .
       4101-INGAIPROCKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    CONST-3003-KBNCD    TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
               PERFORM VARYING IDX0 FROM   1   BY  1
                       UNTIL ( IDX0 >      SYS-3003-JOBID )
      *            ジョブ管理チェック処理
                   MOVE    "CHK"       TO  SJOBKANRI-MODE
                   INITIALIZE              JOBKANRI-REC
                   MOVE    IDX0        TO  JOB-JOBID
                   MOVE    CONST-JOB-SHELLID
                                       TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                   IF    ( SJOBKANRI-RETURN    =   ZERO )
                       IF    ( JOB-ENDYMD      =   SPACE )
      *********        AND     JOB-TERMID      =   SPA-TERMID
                           MOVE    "6666"      TO  SPA-DIDCD
                           GO  TO  210-BACK-EXT
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
           PERFORM 210-BACK-SYORI-SEC
           .
      *
       210-BACK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      *
      *
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "D01"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           INITIALIZE                      SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    クリア処理
      *****************************************************************
       420-CLEAR-SEC                   SECTION.
      *
           INITIALIZE                      SPA-GMN-D01-INPUT-AREA
                                           SPA-NAI-D01-INPUT-AREA
      *
           MOVE    SPA-SYSYMDWH(1:6)   TO  SPA-GMN-D01-SRYYM
           MOVE    SPA-SYSYMD(1:6)     TO  SPA-NAI-D01-SRYYM
      *
      *    入外区分のデフォルトを外来として設定
           MOVE    "2"                 TO  WRK-CMB-CD
           PERFORM 4200-NYUGAIKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-D01-NYUGAIKBN-G
      *
           MOVE    SPACE               TO  WRK-CMB-CD
           PERFORM 4200-JIHIPROCKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-D01-JIHIPROCKBN-G
      *
           MOVE    SPACE               TO  WRK-CMB-CD
           PERFORM 4200-INGAIPROCKBNLST-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SPA-GMN-D01-INGAIPROCKBN-G
      *
           MOVE    1                   TO  SPA-GMN-D01-CUR
      *
           .
      *
       420-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    確認
      *****************************************************************
       430-KAKUNIN-SEC                 SECTION.
      *
           MOVE    "1"                 TO  WRK-CMB-CD
           PERFORM 4200-CHKKBNLST-CHK-SEC
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   CONST-CHKKBN-MAX )
      *
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-D01-CHKKBN-G (IDX0)
      *
           END-PERFORM
      *
           .
      *
       430-KAKUNIN-EXT.
           EXIT.
      *****************************************************************
      *    確認全印刷
      *****************************************************************
       440-KAKUNIN-ALL-SEC             SECTION.
      *
           MOVE    "2"                 TO  WRK-CMB-CD
           PERFORM 4200-CHKKBNLST-CHK-SEC
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   CONST-CHKKBN-MAX )
      *
               MOVE    WRK-CMB-ITM     TO  SPA-GMN-D01-CHKKBN-G (IDX0)
      *
           END-PERFORM
      *
           .
      *
       440-KAKUNIN-ALL-EXT.
           EXIT.
      *****************************************************************
      *    再印刷処理
      *****************************************************************
       450-REPRINT-SEC                 SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-D01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "D01"               TO  SPA-MOTOPG
           MOVE    "XA01"              TO  SPA-SAKIPG
      *
           MOVE    CONST-PRTKANRI-TBL-KEY
                                       TO  SPA-PRTKANRI-TBL-KEY
      *
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XA01   "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
      *
       450-REPRINT-EXT.
           EXIT.
      *****************************************************************
      *    情報削除
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-D01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "D01"               TO  SPA-MOTOPG
           MOVE    "XB01"              TO  SPA-SAKIPG
      *
           MOVE    CONST-JOB-SHELLID   TO  SPA-JOB-SHELLID
      *
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XB01   "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
      *
       490-JYOUHOU-DEL-EXT.
           EXIT.
      *****************************************************************
      *    確定
      *****************************************************************
       490-KAKUTEI-SEC                 SECTION.
      *
      *    入力チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-KAKUTEI-EXT
           END-IF
      *
      *    ジョブ管理チェック
           PERFORM 4900-JOBKANRICHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-KAKUTEI-EXT
           END-IF
      *
      *    関連チェック
           PERFORM 4900-KANRENCHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-KAKUTEI-EXT
           END-IF
      *
           MOVE    "1001"              TO  SPA-DIDCD
      *
           .
      *
       490-KAKUTEI-EXT.
           EXIT.
      *****************************************************************
      *    処理確認
      *****************************************************************
       490-SYORIKAKUNIN-SEC            SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    SPACE               TO  D99
           MOVE    ZERO                TO  D99-COUNT
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    CONST-3003-KBNCD    TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >       SYS-3003-JOBID )
      *
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX0            TO  JOB-JOBID
                   MOVE    CONST-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                   IF    ( SJOBKANRI-RETURN    =   ZERO )
                       MOVE    JOB-JOBID       TO  D99-RENNUM   (IDX0)
                       MOVE    JOB-SHELLMSG    TO  D99-SHORINM  (IDX0)
                       MOVE    JOB-STARTTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-STARTTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-STARTTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  D99-STARTTIME(IDX0)
                       MOVE    JOB-ENDTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-ENDTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-ENDTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  D99-ENDTIME  (IDX0)
                       MOVE    JOB-UPDCNT      TO  WRK-PAGE
                       MOVE    WRK-PAGE        TO  D99-PAGE     (IDX0)
                       MOVE    JOB-YOBI        TO  D99-ERRMSG   (IDX0)
                       IF    ( JOB-ENDYMD      =   SPACE )
                           MOVE    "処理中です"    TO  D99-MSG
                       ELSE
                           IF    ( JOB-ERRCD   =   SPACE )
                               CONTINUE
                           ELSE
                               MOVE   SPACE        TO  D99-MSG
                               STRING  JOB-YOBI    DELIMITED  BY  SPACE
                                       "【"        DELIMITED  BY  SIZE
                                      JOB-SHELLMSG DELIMITED  BY  SPACE
                                      "】"         DELIMITED  BY  SIZE
                               INTO  D99-MSG
                               END-STRING
                           END-IF
                       END-IF
                       MOVE    IDX0            TO  D99-COUNT
                   END-IF
               END-PERFORM
           END-IF
      *
           IF    ( D99-MSG             =   SPACE )
               IF    ( D99-COUNT       >   ZERO )
                   MOVE    "処理は正常に終了しました"
                                               TO  D99-MSG
               ELSE
                   MOVE    "該当する処理はありません"
                                               TO  D99-MSG
               END-IF
           END-IF
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "D01"               TO  SPA-MOTOPG
           MOVE    "D99"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "D99"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
      *
       490-SYORIKAKUNIN-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理チェック処理
      *****************************************************************
       4900-JOBKANRICHK-SEC            SECTION.
      *
      *    ジョブ管理チェック
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    CONST-3003-KBNCD    TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           ELSE
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-3003-REC
               PERFORM VARYING IDX0 FROM   1   BY  1
                       UNTIL ( IDX0 >      SYS-3003-JOBID )
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX0            TO  JOB-JOBID
                   MOVE    CONST-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                   IF    ( SJOBKANRI-RETURN
                                           =   ZERO )
                       IF    ( JOB-ENDYMD  =   SPACE )
                           MOVE    "7777"          TO  SPA-ERRCD
                           MOVE    SPACE           TO  WRK-ERRMSG
                           STRING  "指定された条件でチェック実行中"
                                               DELIMITED  BY  SIZE
                                   "のためしばらくお待ちください"
                                               DELIMITED  BY  SIZE
                           INTO  WRK-ERRMSG
                           END-STRING
                           MOVE    SYS-3003-JOBID  TO  IDX0
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
           .
       4900-JOBKANRICHK-EXT.
           EXIT.
      *****************************************************************
      *    関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
      *    診療年月が入力されていること
           IF    ( SPA-GMN-D01-SRYYM   =   SPACE )
               MOVE    1               TO  SPA-GMN-D01-CUR
               MOVE    "1001"          TO  SPA-ERRCD
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    確認項目がいずれか一つは入力されていること
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0        >   CONST-CHKKBN-MAX )
                    OR   ( SPA-GMN-D01-CHKKBN (IDX0)
                                   NOT =   SPACE )
                CONTINUE
           END-PERFORM
      *
           IF    ( IDX0    >   CONST-CHKKBN-MAX )
               MOVE    "1002"          TO  SPA-ERRCD
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *****************************************************************
      *    入外区分コンボチェック処理
      *****************************************************************
       4200-NYUGAIKBNLST-CHK-SEC       SECTION.
      *
           MOVE    SPACE               TO  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
               UNTIL ( IDX-CMB     >   SPA-GMN-D01-NYUGAIKBN-MAX )
                OR   ( WRK-CMB-CD  =   SPA-GMN-D01-NYUGAIKBNL (IDX-CMB))
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX-CMB     <=  SPA-GMN-D01-NYUGAIKBN-MAX )
               MOVE    SPA-GMN-D01-NYUGAIKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
           END-IF
      *
           .
       4200-NYUGAIKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    チェック項目コンボチェック処理
      *****************************************************************
       4200-CHKKBNLST-CHK-SEC          SECTION.
      *
           MOVE    SPACE               TO  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
               UNTIL ( IDX-CMB     >   SPA-GMN-D01-CHKKBN-MAX )
                OR   ( WRK-CMB-CD  =   SPA-GMN-D01-CHKKBNL (IDX-CMB))
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX-CMB     <=  SPA-GMN-D01-CHKKBN-MAX )
               MOVE    SPA-GMN-D01-CHKKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
           END-IF
      *
           .
       4200-CHKKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    自費保険者の処理項目コンボチェック処理
      *****************************************************************
       4200-JIHIPROCKBNLST-CHK-SEC     SECTION.
      *
           MOVE    SPACE               TO  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
               UNTIL ( IDX-CMB     >   SPA-GMN-D01-JIHIPROCKBN-MAX )
                OR   ( WRK-CMB-CD  =   SPA-GMN-D01-JIHIPROCKBNL
                                                           (IDX-CMB))
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX-CMB     <=  SPA-GMN-D01-JIHIPROCKBN-MAX )
               MOVE    SPA-GMN-D01-JIHIPROCKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
           END-IF
      *
           .
       4200-JIHIPROCKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    院外処方の処理項目コンボチェック処理
      *****************************************************************
       4200-INGAIPROCKBNLST-CHK-SEC    SECTION.
      *
           MOVE    SPACE               TO  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
               UNTIL ( IDX-CMB     >   SPA-GMN-D01-INGAIPROCKBN-MAX )
                OR   ( WRK-CMB-CD  =   SPA-GMN-D01-INGAIPROCKBNL
                                                           (IDX-CMB))
      *
               CONTINUE
      *
           END-PERFORM
      *
           IF    ( IDX-CMB     <=  SPA-GMN-D01-INGAIPROCKBN-MAX )
               MOVE    SPA-GMN-D01-INGAIPROCKBNLST (IDX-CMB)
                                       TO  WRK-CMB-ITM
           END-IF
      *
           .
       4200-INGAIPROCKBNLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN                  SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF    ( SPA-ERRCD       NOT =   SPACE )
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF    ( SPA-DIDCD       NOT =   SPACE )
               EVALUATE    SPA-DIDCD
               WHEN    "1001"
                   PERFORM 520-DID2SET-SEC
                   GO  TO  500-SET-SCREEN-EXT
               WHEN    OTHER
                   PERFORM 520-DID1SET-SEC
                   GO  TO  500-SET-SCREEN-EXT
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "D01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面内容編集処理
      *****************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           INITIALIZE                      D01
      *
      *    診療年月
           MOVE    SPA-GMN-D01-SRYYM   TO  D01-SRYYM
      *
      *    入外区分
           MOVE    SPA-GMN-D01-NYUGAIKBN-G
                                       TO  D01-NYUGAIKBN
      *
      *    入外区分コンボ
           MOVE    SPA-GMN-D01-NYUGAIKBN-MAX
                                       TO  D01-NYUGAIKBN-COUNT
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   SPA-GMN-D01-NYUGAIKBN-MAX )
      *
               MOVE    SPA-GMN-D01-NYUGAIKBNLST (IDXA)
                                       TO  D01-NYUGAIKBN-ITEM (IDXA)
      *
           END-PERFORM
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   CONST-CHKKBN-MAX )
      *
      *        チェック項目名
               MOVE    SPA-GMN-D01-CHKMSG (IDXA)
                                       TO  D01-CHKMSG (IDXA)
      *        チェック項目
               MOVE    SPA-GMN-D01-CHKKBN-G (IDXA)
                                       TO  D01-CHKKBN (IDXA)
      *
      *        チェック項目コンボ
               MOVE    SPA-GMN-D01-CHKKBN-MAX
                                       TO  D01-CHKKBN-COUNT (IDXA)
      *
               PERFORM VARYING IDXB    FROM    1   BY  1
                       UNTIL ( IDXB    >   SPA-GMN-D01-CHKKBN-MAX )
      *
                   MOVE    SPA-GMN-D01-CHKKBNLST (IDXB)
                                       TO  D01-CHKKBN-ITEM (IDXA IDXB)
      *
               END-PERFORM
      *
           END-PERFORM
      *
      *    自費保険者の処理項目名
           MOVE    SPA-GMN-D01-JIHIPROCMSG
                                       TO  D01-JIHIPROCMSG
      *    院外処方の処理項目名
           MOVE    SPA-GMN-D01-INGAIPROCMSG
                                       TO  D01-INGAIPROCMSG
      *
      *    自費保険者の処理項目
           MOVE    SPA-GMN-D01-JIHIPROCKBN-G
                                       TO  D01-JIHIPROCKBN
      *
      *    自費保険者の処理項目コンボ
           MOVE    SPA-GMN-D01-JIHIPROCKBN-MAX
                                       TO  D01-JIHIPROCKBN-COUNT
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   SPA-GMN-D01-JIHIPROCKBN-MAX )
      *
               MOVE    SPA-GMN-D01-JIHIPROCKBNLST (IDXA)
                                       TO  D01-JIHIPROCKBN-ITEM (IDXA)
      *
           END-PERFORM
      *
      *    院外処方の処理項目
           MOVE    SPA-GMN-D01-INGAIPROCKBN-G
                                       TO  D01-INGAIPROCKBN
      *
      *    院外処方の処理項目コンボ
           MOVE    SPA-GMN-D01-INGAIPROCKBN-MAX
                                       TO  D01-INGAIPROCKBN-COUNT
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   SPA-GMN-D01-INGAIPROCKBN-MAX )
      *
               MOVE    SPA-GMN-D01-INGAIPROCKBNLST (IDXA)
                                       TO  D01-INGAIPROCKBN-ITEM (IDXA)
      *
           END-PERFORM
      *
      *    カーソル位置
           PERFORM 5001-MAPCUR-SEC
           .
      *
       500-GMNHEN-EXT.
           EXIT.
      *****************************************************************
      *    カーソル位置処理
      *****************************************************************
       5001-MAPCUR-SEC                 SECTION.
      *
           IF    ( SPA-ERRCD           =   SPACE)
             AND ( SPA-GMN-D01-CUR     =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-D01-CUR
           WHEN    01
               MOVE    "SRYYM"         TO  MCP-WIDGET
           WHEN    02
               MOVE    "NYUGAIKBN"     TO  MCP-WIDGET
           WHEN    03
               MOVE    "CHKKBN01"      TO  MCP-WIDGET
           WHEN    04
               MOVE    "CHKKBN02"      TO  MCP-WIDGET
           WHEN    05
               MOVE    "CHKKBN03"      TO  MCP-WIDGET
           WHEN    06
               MOVE    "CHKKBN04"      TO  MCP-WIDGET
           WHEN    07
               MOVE    "CHKKBN05"      TO  MCP-WIDGET
           WHEN    08
               MOVE    "CHKKBN06"      TO  MCP-WIDGET
           WHEN    09
               MOVE    "CHKKBN07"      TO  MCP-WIDGET
           WHEN    10
               MOVE    "CHKKBN08"      TO  MCP-WIDGET
           WHEN    11
               MOVE    "CHKKBN09"      TO  MCP-WIDGET
           WHEN    12
               MOVE    "CHKKBN10"      TO  MCP-WIDGET
           WHEN    13
               MOVE    "CHKKBN11"      TO  MCP-WIDGET
           WHEN    14
               MOVE    "CHKKBN12"      TO  MCP-WIDGET
           WHEN    15
               MOVE    "CHKKBN13"      TO  MCP-WIDGET
           WHEN    16
               MOVE    "CHKKBN14"      TO  MCP-WIDGET
           WHEN    17
               MOVE    "CHKKBN15"      TO  MCP-WIDGET
           WHEN    18
               MOVE    "CHKKBN16"      TO  MCP-WIDGET
           WHEN    19
               MOVE    "CHKKBN17"      TO  MCP-WIDGET
           WHEN    20
               MOVE    "CHKKBN18"      TO  MCP-WIDGET
           WHEN    51
               MOVE    "JIHIPROCKBN"   TO  MCP-WIDGET
           WHEN    52
               MOVE    "INGAIPROCKBN"  TO  MCP-WIDGET
           WHEN    212
               MOVE    "B12"           TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       5011-INPUT-CUR-SEC              SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SRYYM"
               MOVE    01              TO  SPA-GMN-D01-CUR
           WHEN    "NYUGAIKBN"
               MOVE    02              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN01"
               MOVE    03              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN02"
               MOVE    04              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN03"
               MOVE    05              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN04"
               MOVE    06              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN05"
               MOVE    07              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN06"
               MOVE    08              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN07"
               MOVE    09              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN08"
               MOVE    10              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN09"
               MOVE    11              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN10"
               MOVE    12              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN11"
               MOVE    13              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN12"
               MOVE    14              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN13"
               MOVE    15              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN14"
               MOVE    16              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN15"
               MOVE    17              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN16"
               MOVE    18              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN17"
               MOVE    19              TO  SPA-GMN-D01-CUR
           WHEN    "CHKKBN18"
               MOVE    20              TO  SPA-GMN-D01-CUR
           WHEN    "JIHIPROCKBN"
               MOVE    51              TO  SPA-GMN-D01-CUR
           WHEN    "INGAIPROCKBN"
               MOVE    52              TO  SPA-GMN-D01-CUR
           END-EVALUATE
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "CHKKBN14"
           WHEN    "CHKKBN15"
           WHEN    "CHKKBN16"
           WHEN    "CHKKBN17"
           WHEN    "CHKKBN18"
               MOVE    51              TO  SPA-GMN-D01-CUR
           WHEN    "INGAIPROCKBN"
               MOVE    212             TO  SPA-GMN-D01-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-D01-CUR =   SPA-GMN-D01-CUR +   1
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC                  SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "0001"
               MOVE    "診療年月入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "確認項目入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "1001"
               MOVE    "診療年月を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1002"
               MOVE    "確認項目を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "4001"              THRU    "4999"
               MOVE    "更新処理に失敗しました"
                                       TO  SPA-ERRMSG
           WHEN    "7777"
               MOVE    WRK-ERRMSG      TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  DERR
           MOVE    SPA-ERRCD           TO  DERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  DERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "D01"               TO  SPA-MOTOPG
           MOVE    "DERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "DERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-DID1SET-SEC                 SECTION.
      *
           MOVE    SPACE               TO  WRK-DIDMSG
      *
           EVALUATE    SPA-DIDCD
           WHEN    "6666"
               MOVE    "処理中です"    TO  WRK-DIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  DID1
           MOVE    SPA-DIDCD           TO  DID1-ID1CODE
           MOVE    WRK-DIDMSG          TO  DID1-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "D01"               TO  SPA-MOTOPG
           MOVE    "DID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "DID1"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-DID1SET-EXT.
           EXIT.
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-DID2SET-SEC                 SECTION.
      *
           MOVE    SPACE               TO  WRK-DIDMSG
      *
           EVALUATE    SPA-DIDCD
           WHEN    "1001"
               MOVE    SPA-NAI-D01-SRYYM
                                       TO  WRK-YMD
               MOVE    "01"            TO  WRK-YMD(7:2)
               PERFORM 800-SEIWA-HEN-SEC
               STRING  WRK-EDTYMD3 (1:16)  DELIMITED   BY  SIZE
                       "分チェック処理を行います"
                                           DELIMITED   BY  SIZE
               INTO    WRK-DIDMSG
               END-STRING
           END-EVALUATE
      *
           MOVE    SPACE               TO  DID2
           MOVE    SPA-DIDCD           TO  DID2-ID1CODE
           MOVE    WRK-DIDMSG          TO  DID2-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "D01"               TO  SPA-MOTOPG
           MOVE    "DID2"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "DID2"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-DID2SET-EXT.
           EXIT.
      *****************************************************************
      *    年月チェック・編集処理
      *****************************************************************
       5003-NENGETSU-CHK-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-HIZUKE-ERR
      *
           MOVE    SPACE               TO  WRK-HENYMDG
                                           WRK-SYMD
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    "1"                 TO  SGDAY-INTYPE
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           IF    ( SGDAY-RC            =   ZERO )
               MOVE    SGDAY-OTDAY     TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY      TO  WRK-SYMD
           ELSE
               MOVE    1               TO  FLG-HIZUKE-ERR
           END-IF
      *
           .
       5003-NENGETSU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC         SECTION.
      *
           MOVE    SPACE               TO  WRK-EDTYMD1
                                           WRK-EDTYMD3
      *
           IF    ( WRK-YMD             =   SPACE )
               GO  TO  800-SEIWA-HEN-EXT
           END-IF
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-YMD             TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"       USING   STS-AREA-DAY
                                           LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-EDTYMD1
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-EDTYMD3
           INSPECT WRK-EDTYMD3     REPLACING  ALL "  "  BY  "　"
      *
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"          TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
