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
       PROGRAM-ID.             ORCGL01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 日次統計
      *  コンポーネント名  : 日次統計
      *  管理者            :
      *  01/06/19    MCC-森脇　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/09/06  パラメタ項目追加
      *  01.01.02    MCC-藤原     01/09/21  JOINの修正
      *  01.00.03    MCC-藤原     02.03.18  端末ＩＤ
      *                                     X(16)からX(32)に変更
      *  01.00.04    MCC-藤原     02.03/22  パラメタにシステム日付を追加
      *  01.00.05    MCC-森脇     02/04/23  パラメタ空白時日付セット
      *  01.00.06    MCC-藤原     02/04/15  印刷管理・印刷ＤＢ・
      *                                     ジョブ管理ＤＢの追加
      *  01.00.07    MCC-藤原     02/05/15  処理前にジョブ管理を削除する
      *  01.00.08    MCC-藤原     02/06/04  再印刷・情報削除ボタン追加
      *  01.00.09    NACL-藤原    02/07/25  確定のとき自動的に情報確認画面を表示
      *  01.00.10    NACL-藤原    02/09/12  ディレクトリをサブプロへ
      *  01.00.11    NACL-藤原    03/05/12  印刷開始・終了頁の編集の修正
      *  01.00.12    NACL-太田    03/07/02  出力先プリンタサブ追加
      *  01.00.13    NACL-太田    03/07/30  編集パラメータにPTNUM追加
      *  01.00.14    NACL-太田    03/08/05  パラメータを８つまで設定可能
      *                                     に修正
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                 PIC X(200).
      *
       WORKING-STORAGE                 SECTION.
      *
      *    エラーファイル 名称領域
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    日次統計共通パラメタ
           COPY    "L01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-L01.
           03  SPA-L01-AREA.
               05  SPA-GMN-PAGE                PIC 9(02).
               05  SPA-GMN-MAXPAGE             PIC 9(02).
               05  SPA-GMN-MAX                 PIC 9(03).
               05  SPA-GMN-CUR                 PIC 9(03).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-TBL             OCCURS  100.
                       09  SPA-GMN-CHK.
                           11  SPA-GMN-CHK-VALUE
                                               PIC X(01).
                       09  SPA-GMN-NUM         PIC X(03).
                       09  SPA-GMN-HCNAME      PIC X(80).
                       09  SPA-GMN-PRGNAME     PIC X(24).
                       09  SPA-GMN-PARAHYOJI-G OCCURS  8.
                           11  SPA-GMN-PARAHYOJI
                                               PIC X(20).
                       09  SPA-GMN-PARA-TBL.
                           11  SPA-GMN-PARA-G  OCCURS  8.
                               13  SPA-GMN-PARA
                                               PIC X(20).
      *
               05  SPA-NAI-AREA.
                   07  SPA-NAI-TBL             OCCURS  100.
                       09  SPA-NAI-PARA-G      OCCURS  8.
                           11  SPA-NAI-PARA    PIC X(20).
                       09  SPA-NAI-HENPARA-TBL.
                           11  SPA-NAI-HENPARA-G
                                               OCCURS  8.
                               13  SPA-NAI-HENPARA
                                               PIC X(20).
                       09  SPA-NAI-HISSU-KBN-G  OCCURS  8.
                           11  SPA-NAI-HISSU-KBN
                                               PIC X(01).
      *
       01  FLG-AREA.
           03  FLG-END                         PIC 9(01).
           03  FLG-SYSKANRI                    PIC 9(01).
      *
           03  FLG-CHK                         PIC 9(01).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECEERR                     PIC X(02).
      *
       01  IDX-AREA.
           03  IDX                             PIC 9(04).
           03  IDY                             PIC 9(04).
           03  IDZ                             PIC 9(04).
           03  IDZ1                            PIC 9(04).
           03  IDZ2                            PIC 9(04).
           03  IDXA                            PIC 9(04).
           03  IDXB                            PIC 9(04).
           03  IDXC                            PIC 9(04).
           03  IDX1                            PIC 9(04).
           03  IDX2                            PIC 9(04).
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
       01  SHELL-AREA.
           03  SHELL-NAME                      PIC X(25)   VALUE
               "scripts/daily/execoprg.sh".
      *
       01  WRK-AREA.
           03  WRK-ERR-CUR                     PIC 9(03).
           03  WRK-PRTKANRI-RENNUM             PIC 9(04).
           03  WRK-LIDMSG                      PIC X(70).
           03  WRK-YMD                         PIC X(10).
           03  WRK-SYMD.
               05  WRK-SYY                     PIC 9(04).
               05  WRK-SMM                     PIC 9(02).
               05  WRK-SDD                     PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO                     PIC X(01).
               05  WRK-WYY                     PIC 9(02).
               05  WRK-WMM                     PIC 9(02).
               05  WRK-WDD                     PIC 9(02).
           03  WRK-PAGE                        PIC ZZZZZZZZZ9.
      *
           03  WRK-NUM                         PIC 9(03).
      *
           03  WRK-RECEERR                     PIC X(200).
      *
           03  WRK-WIDGET1                     PIC 9(01).
           03  WRK-WIDGET2                     PIC 9(02).
      *
           03  WRK-STPAGE                      PIC 9(05).
           03  WRK-EDPAGE                      PIC 9(05).
           03  WRK-CHK-CUR                     PIC 9(05).
           03  WRK-MCP-WIDGET                  PIC X(64).
           03  WRK-PARA-NUM1                   PIC 9(03).
           03  WRK-PARA-NUM2                   PIC 9(03).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY                      PIC 9(02).
               05  SYS-MM                      PIC 9(02).
               05  SYS-DD                      PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY                   PIC 9(04).
               05  WRK-SYSMM                   PIC 9(02).
               05  WRK-SYSDD                   PIC 9(02).
           03  SYS-TIME                        PIC X(06).
      *
       01  WRK-LNK-AREA.
           COPY    "CPORCSPRTLNK.INC".
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG                     PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO                     PIC X(01).
               05  WRK-HYY                     PIC 9(02).
               05  FILLER                      PIC X(01)   VALUE   ".".
               05  WRK-HMM                     PIC 9(02).
               05  FILLER                      PIC X(01)   VALUE   ".".
               05  WRK-HDD                     PIC 9(02).
           03  WRK-HENTIME.
               05  WRK-HH                      PIC X(02).
               05  FILLER                      PIC X(01)   VALUE   ".".
               05  WRK-MM                      PIC X(02).
               05  FILLER                      PIC X(01)   VALUE   ".".
               05  WRK-SS                      PIC X(02).
      *
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "ORCA-DBPATH".
      *
       01  WRK-CONS-AREA.
      *    パラメータ最大個数
           03  WRK-CONS-PARA-MAX               PIC 9(05) VALUE 8.
      *    最大明細数
           03  WRK-CONS-LINE-MAX               PIC 9(05) VALUE 100.
      *    １画面あたりの最大明細数
           03  WRK-CONS-SCR-MAX                PIC 9(05) VALUE 10.
      *    システム管理ＤＢ（３００３）のキー値
           03  WRK-CONS-3003-KBNCD             PIC X(08) VALUE "051".
      *    印刷管理ＤＢのキー値
           03  WRK-CONS-PRTKANRI-TBL-KEY       PIC X(08) VALUE "DAILY".
           03  WRK-CONS-PRTKANRI-TBL-GROUP     PIC X(14) VALUE SPACE.
      *    ジョブ管理ＤＢのキー値
           03  WRK-CONS-JOB-SHELLID            PIC X(08) VALUE "DAILY".
           03  WRK-CONS-JOB-JOBID              PIC 9(07) VALUE ZERO.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理
           COPY    "CPSK1031.INC".
      *
           COPY    "CPSK3001.INC".
      *
           COPY    "CPSK3003.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
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
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *   画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTNUM.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "L01.INC".
           COPY    "L99.INC".
           COPY    "LERR.INC".
           COPY    "LID1.INC".
           COPY    "LID2.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-L01
           MOVE    SPA-WORK        TO  SPA-L01KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS  ALSO    MCP-EVENT
           WHEN    "LINK"          ALSO    ANY
               PERFORM 100-INIT-SEC
      *    画面遷移
           WHEN     "PUTG"         ALSO   "CLICKED"
               PERFORM 200-GMNSENI
      *    入力
           WHEN      OTHER
               PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF    ( FLG-END         =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-L01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-L01         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "LERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
      *
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "L01"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
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
                   MOVE    LNK-SCRSPA      TO  SPA-L01
                   INITIALIZE              SPA-L01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
      *
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "L99"
               MOVE    ZERO                TO  SPA-GMN-CUR
               MOVE    ZERO                TO  IDX
               MOVE    3                   TO  IDY
               GO  TO  300-SCREEN-EXT
      *    作表処理
           WHEN    "LID1"
               PERFORM 330-LID1-SET-SEC
               GO  TO  300-SCREEN-EXT
           WHEN    "LID2"
               PERFORM 340-LID2-SET-SEC
               GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE                  SPA-L01-AREA
                                       SPA-L01KYOUTU
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL ( IDX >       WRK-CONS-LINE-MAX )
               MOVE    "F"             TO  SPA-GMN-CHK-VALUE (IDX)
           END-PERFORM
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL ( IDX >       WRK-CONS-LINE-MAX )
               MOVE    IDX             TO  WRK-NUM
               MOVE    WRK-NUM         TO  SPA-GMN-NUM (IDX)
           END-PERFORM
      *
      *    パラメータ初期設定
           PERFORM 3101-PARA-SYOKI-SEC
      *
           IF    ( SPA-GMN-MAX         =   ZERO )
               MOVE    1                   TO  SPA-GMN-MAXPAGE
           ELSE
               COMPUTE SPA-GMN-MAXPAGE = ( SPA-GMN-MAX - 1 )
                                       / WRK-CONS-SCR-MAX
                                       + 1
           END-IF
      *
           MOVE    1                   TO  SPA-GMN-PAGE
      *
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメータ初期設定処理
      *****************************************************************
       3101-PARA-SYOKI-SEC              SECTION.
      *
      *    システム管理マスタ読込
           INITIALIZE                      SYS-3001-REC
           MOVE  "3001"                TO  SYS-3001-KANRICD
           MOVE  SYS-3001-REC          TO  MCPDATA-REC
           MOVE  "DBSELECT"            TO  MCP-FUNC
           MOVE  "SYSKANRI-KEY2"       TO  ORC-DBPATH
           MOVE  SPA-SYSYMD            TO  ORC-DBYMD
           CALL  "ORCMCPSUB"           USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               PERFORM 900-SYSKANRI-NEXT-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
      *
               IF    ( SYS-3001-KBNCD(1:3) IS  NUMERIC )
                   MOVE    SYS-3001-KBNCD(1:3) TO  WRK-NUM
                   IF    ( WRK-NUM         >   WRK-CONS-LINE-MAX )
                       CONTINUE
                   ELSE
                       MOVE    SYS-3001-KBNCD(1:3)
                                               TO  WRK-NUM
                       MOVE    WRK-NUM         TO  IDX
                       MOVE    SYS-3001-HCNAME TO  SPA-GMN-HCNAME (IDX)
                       MOVE    SYS-3001-PRGNAME
                                               TO  SPA-GMN-PRGNAME(IDX)
                       PERFORM VARYING IDY FROM    1   BY  1
                               UNTIL ( IDY >   WRK-CONS-PARA-MAX )
                           MOVE    SYS-3001-PARAHYOJI(IDY)
                                       TO  SPA-GMN-PARAHYOJI(IDX IDY)
                           MOVE    SYS-3001-PARA     (IDY)
                                       TO  SPA-NAI-PARA     (IDX IDY)
                           MOVE    SYS-3001-HISSU-KBN(IDY)
                                       TO  SPA-NAI-HISSU-KBN(IDX IDY)
                           IF    ( SPA-NAI-HISSU-KBN(IDX IDY)
                                           =   SPACE   )
                               MOVE    "1"
                                       TO  SPA-NAI-HISSU-KBN(IDX IDY)
                           END-IF
                           DISPLAY "SYS-3001-KBNCD=" SYS-3001-KBNCD
                           DISPLAY "SYS-3001-HISSU-KBN(" IDY ")="
                                    SYS-3001-HISSU-KBN(IDY)
                                    SPA-NAI-HISSU-KBN(IDX IDY)
                           DISPLAY "SPA-NAI-HISSU-KBN(" IDX " " IDY ")="
                                    SPA-NAI-HISSU-KBN(IDX IDY)
                       END-PERFORM
                       IF    ( IDX         >   SPA-GMN-MAX )
                           MOVE    IDX         TO  SPA-GMN-MAX
                       END-IF
                   END-IF
               END-IF
      *
               PERFORM 900-SYSKANRI-NEXT-SEC
      *
           END-PERFORM
      *
           MOVE  "DBCLOSE"                 TO  MCP-FUNC
           MOVE  "SYSKANRI-KEY2"           TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                   USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
      *
           .
       3101-PARA-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    確認画面（ＬＩＤ１）ＯＫ処理
      *****************************************************************
       330-LID1-SET-SEC            SECTION.
      *
           IF    ( SPA-LID1-FLG    =   "OK" )
               EVALUATE    SPA-LIDCD
               WHEN    "6666"
                   MOVE    "JOIN"      TO  MCP-PUTTYPE
                   PERFORM 210-BACK-SYORI-SEC
               WHEN    OTHER
                   PERFORM 490-PRINT-SEC
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE               TO  SPA-LID1-FLG
           MOVE    SPACE               TO  SPA-LIDCD
      *
           .
       330-LID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＬＩＤ２）ＯＫ処理
      *****************************************************************
       340-LID2-SET-SEC            SECTION.
      *
           IF    ( SPA-LID1-FLG    =   "OK" OR "NO" )
               PERFORM 490-PRINT-SEC
           END-IF
      *
           MOVE    SPACE           TO  SPA-LID1-FLG
           MOVE    SPACE           TO  SPA-LIDCD
           .
       340-LID2-SET-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE    "CHANGE"    TO  MCP-PUTTYPE
               PERFORM 210-BACK
      *    クリア
           WHEN    "CLICKED"       ALSO    "B02"
               MOVE    "CHANGE"    TO  MCP-PUTTYPE
               PERFORM 230-CLEAR-SEC
      *    再印刷
           WHEN    "CLICKED"       ALSO    "B05"
               PERFORM 450-REPRINT-SEC
      *    前頁
           WHEN    "CLICKED"       ALSO    "B06"
               PERFORM 460-MAEGMN-SEC
      *    次頁
           WHEN    "CLICKED"       ALSO    "B07"
               PERFORM 470-ATOGMN-SEC
      *    情報削除
           WHEN    "CLICKED"       ALSO    "B11"
               PERFORM 490-JYOUHOU-DEL-SEC
      *    OK
           WHEN    "CLICKED"       ALSO    "B12"
               PERFORM 490-PRINT-MAE-SEC
      *    個別出力
           WHEN    "CLICKED"       ALSO    "CHK01"
           WHEN    "CLICKED"       ALSO    "CHK02"
           WHEN    "CLICKED"       ALSO    "CHK03"
           WHEN    "CLICKED"       ALSO    "CHK04"
           WHEN    "CLICKED"       ALSO    "CHK05"
           WHEN    "CLICKED"       ALSO    "CHK06"
           WHEN    "CLICKED"       ALSO    "CHK07"
           WHEN    "CLICKED"       ALSO    "CHK08"
           WHEN    "CLICKED"       ALSO    "CHK09"
           WHEN    "CLICKED"       ALSO    "CHK10"
               MOVE    MCP-WIDGET (4:2)    TO  WRK-WIDGET2
               MOVE    WRK-WIDGET2         TO  IDX
               PERFORM 420-CHK-CHK-SEC
      *    処理確認
           WHEN    "CLICKED"       ALSO    "B13"
               PERFORM 490-KAKUNIN-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
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
      *
           .
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       400-GMN-INPUT-SEC           SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-CUR
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
      *    入力パラメータ
           PERFORM VARYING IDXC    FROM    1   BY  1
                   UNTIL ( IDXC    >   WRK-CONS-SCR-MAX )
      *
               COMPUTE IDXA    =   (   SPA-GMN-PAGE    -   1 )
                               *   WRK-CONS-SCR-MAX
                               +   IDXC
      *
               PERFORM VARYING IDXB    FROM    1   BY  1
                       UNTIL ( IDXB    >   WRK-CONS-PARA-MAX )
                   MOVE    L01-PARA (IDXC IDXB)
                                   TO  SPA-GMN-PARA(IDXA IDXB)
               END-PERFORM
           END-PERFORM
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
           MOVE    ZERO                        TO  WRK-PARA-NUM1
                                                   WRK-PARA-NUM2
           IF    ( WRK-MCP-WIDGET (1:4)    =   "PARA" )
            AND  ( WRK-MCP-WIDGET (5:3)    IS  NUMERIC )
               MOVE    WRK-MCP-WIDGET (5:2)    TO  WRK-PARA-NUM1
               MOVE    WRK-MCP-WIDGET (7:1)    TO  WRK-PARA-NUM2
           END-IF
      *
           PERFORM VARYING IDXC    FROM    1   BY  1
                   UNTIL ( IDXC    >   WRK-CONS-SCR-MAX )
      *
               COMPUTE IDXA    =   (   SPA-GMN-PAGE    -   1 )
                               *   WRK-CONS-SCR-MAX
                               +   IDXC
      *
               PERFORM VARYING IDXB    FROM    1   BY  1
                       UNTIL ( IDXB    >   WRK-CONS-PARA-MAX )
                   IF    ( SPA-GMN-PARAHYOJI (IDXA IDXB)
                                   NOT =   SPACE )
      *                入力パラメータ
                       PERFORM 4101-PARA-CHK-SEC
                       IF    ( SPA-ERRCD   NOT =   SPACE )
                           GO  TO  4102-KIHON-CHK-EXT
                       END-IF
                   END-IF
               END-PERFORM
           END-PERFORM
      *
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    パラメタチェック
      *****************************************************************
       4101-PARA-CHK-SEC                         SECTION.
      *
      *    エラー時のカーソル位置を決定
           COMPUTE WRK-ERR-CUR =  ( IDXC   -   1 )
                               *  ( WRK-CONS-PARA-MAX + 1 )
                               +  IDXB
                               +  1
      *
           IF    ( SPA-GMN-PARA (IDXA IDXB)    =   SPACE )
               IF    ( SPA-NAI-HISSU-KBN (IDXA IDXB)
                                               =   "1" )
                   IF    ( WRK-MCP-WIDGET (1:4)    =   "PARA" )
                    AND  ( IDXC            =   WRK-PARA-NUM1 )
                    AND  ( IDXB            =   WRK-PARA-NUM2 )
                       PERFORM 41011-PARA-KIHON-SET-SEC
                       IF    ( SPA-ERRCD       NOT =   SPACE )
                           MOVE    WRK-ERR-CUR     TO  SPA-GMN-CUR
                           GO  TO  4101-PARA-CHK-EXT
                       END-IF
                   END-IF
               ELSE
                   MOVE    SPACE           TO  SPA-NAI-HENPARA
                                                       (IDXA IDXB)
               END-IF
           ELSE
               PERFORM 41012-PARA-NAIYO-CHK-SEC
               IF    ( SPA-ERRCD       NOT =   SPACE )
                   MOVE    WRK-ERR-CUR             TO  SPA-GMN-CUR
                   GO  TO  4101-PARA-CHK-EXT
               END-IF
           END-IF
      *
           .
       4101-PARA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    パラメータ基本値設定処理
      *****************************************************************
       41011-PARA-KIHON-SET-SEC        SECTION.
      *
           IF    ( SPA-GMN-CHK-VALUE (IDXA)    =   "F" )
               GO  TO 41011-PARA-KIHON-SET-EXT
           END-IF
      *
           EVALUATE    SPA-NAI-PARA (IDXA IDXB)
           WHEN    "YM"
               MOVE    SPA-SYSYMD  (1:6)
                                       TO  SPA-NAI-HENPARA(IDXA IDXB)
               MOVE    SPA-SYSYMDWH(1:6)
                                       TO  SPA-GMN-PARA   (IDXA IDXB)
           WHEN    "YMD"
               MOVE    SPA-SYSYMD      TO  SPA-NAI-HENPARA(IDXA IDXB)
               MOVE    SPA-SYSYMDWH    TO  SPA-GMN-PARA   (IDXA IDXB)
           WHEN    "PSN1"
               MOVE    0               TO  SPA-NAI-HENPARA(IDXA IDXB)
               MOVE    "0"
                                       TO  SPA-GMN-PARA   (IDXA IDXB)
           WHEN    "PTNUM"
               MOVE    SPACE           TO  SPA-NAI-HENPARA(IDXA IDXB)
               MOVE    SPACE           TO  SPA-GMN-PARA   (IDXA IDXB)
      *    WHEN    OTHER
      *        MOVE    "0002"  TO  SPA-ERRCD
      *        GO  TO  41011-PARA-KIHON-SET-EXT
           END-EVALUATE
      *
           .
       41011-PARA-KIHON-SET-EXT.
           EXIT.
      *****************************************************************
      *    パラメータ入力内容チェック処理
      *****************************************************************
       41012-PARA-NAIYO-CHK-SEC        SECTION.
      *
           EVALUATE    SPA-NAI-PARA (IDXA IDXB)
           WHEN    "YM"
               MOVE    SPA-GMN-PARA (IDXA IDXB)    TO  WRK-YMD
               PERFORM 5003-NENGETSU-CHK-SEC
               IF    ( SPA-ERRCD       =   SPACE )
                   MOVE    WRK-SYMD(1:6)
                                       TO  SPA-NAI-HENPARA (IDXA IDXB)
                   MOVE    WRK-HENYMDG(1:6)
                                       TO  SPA-GMN-PARA    (IDXA IDXB)
               ELSE
                   GO  TO  41012-PARA-NAIYO-CHK-EXT
               END-IF
           WHEN    "YMD"
               MOVE    SPA-GMN-PARA (IDXA IDXB)    TO  WRK-YMD
               PERFORM 5002-HIZUKE-CHK-SEC
               IF    ( SPA-ERRCD       =   SPACE )
                   MOVE    WRK-SYMD    TO  SPA-NAI-HENPARA (IDXA IDXB)
                   MOVE    WRK-HENYMDG TO  SPA-GMN-PARA    (IDXA IDXB)
               ELSE
                   GO  TO  41012-PARA-NAIYO-CHK-EXT
               END-IF
           WHEN    "PSN1"
               IF    ( SPA-GMN-PARA (IDXA IDXB)(1:1)   IS  NUMERIC )
                   IF    ( SPA-GMN-PARA (IDXA IDXB)(2:)    =   SPACE )
                       MOVE    SPA-GMN-PARA(IDXA IDXB)(1:1)
                           TO  SPA-NAI-HENPARA (IDXA IDXB)
                   ELSE
                       MOVE    "0002"  TO  SPA-ERRCD
                       GO  TO  41012-PARA-NAIYO-CHK-EXT
                   END-IF
               ELSE
                   MOVE    "0002"      TO  SPA-ERRCD
                   GO  TO  41012-PARA-NAIYO-CHK-EXT
               END-IF
           WHEN    "PTNUM"
               INITIALIZE                  ORCSPTNUMAREA
               MOVE    SPA-GMN-PARA (IDXA IDXB)
                                       TO  SPTNUM-PTNUM
               CALL    "ORCSPTNUM"         USING   ORCSPTNUMAREA
                                                   SPA-AREA
               IF    ( SPTNUM-RC       NOT =   20 )
                   MOVE    SPTNUM-PTNUM
                                       TO  SPA-NAI-HENPARA (IDXA IDXB)
                                           SPA-GMN-PARA    (IDXA IDXB)
               ELSE
                   MOVE    "0002"      TO  SPA-ERRCD
                   GO  TO  41012-PARA-NAIYO-CHK-EXT
               END-IF
           WHEN    OTHER
               MOVE    SPA-GMN-PARA (IDXA IDXB)
                                       TO  SPA-NAI-HENPARA (IDXA IDXB)
           END-EVALUATE
      *
           .
       41012-PARA-NAIYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理チェック
      *****************************************************************
       4900-JOBKANRICHK-SEC            SECTION.
      *
      *    ジョブ管理チェック
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC         TO  SYS-3003-REC
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL ( IDX >       SYS-3003-JOBID )
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                   IF    ( SJOBKANRI-RETURN
                                           =   ZERO )
                       IF    ( JOB-ENDYMD  =   SPACE )
                           MOVE    "7777"          TO  SPA-ERRCD
                           MOVE    SPACE           TO  WRK-RECEERR
                           STRING  "処理中です【"  DELIMITED  BY  SIZE
                                   JOB-SHELLMSG    DELIMITED  BY  SPACE
                                   "】"            DELIMITED  BY  SIZE
                                                   INTO  WRK-RECEERR
                           MOVE    SYS-3003-JOBID  TO  IDX
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
           .
      *
       4900-JOBKANRICHK-EXT.
           EXIT.
      *****************************************************************
      *    共通関連チェック
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
      *    未入力チェック
           PERFORM 49001-MINYURYOKU-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    いずれかの処理にチェックがはいっていること
           IF    ( FLG-CHK             =   ZERO )
               MOVE    "0005"          TO  SPA-ERRCD
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
           .
      *
       4900-KANRENCHK-EXT.
           EXIT.
      *****************************************************************
      *    未入力チェック
      *****************************************************************
       49001-MINYURYOKU-CHK-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-CHK
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   WRK-CONS-LINE-MAX )
      *
               IF    ( SPA-GMN-CHK-VALUE (IDXA)    =   "T" )
                   MOVE    1       TO  FLG-CHK
                   PERFORM VARYING IDXB    FROM    1   BY  1
                           UNTIL ( IDXB    >   WRK-CONS-PARA-MAX )
      *
                       IF    ( SPA-GMN-PARAHYOJI(IDXA IDXB)
                                                       NOT =   SPACE )
                        AND  ( SPA-GMN-PARA (IDXA IDXB)    =   SPACE )
                        AND  ( SPA-NAI-HISSU-KBN (IDXA IDXB)
                                                           =   "1" )
                           MOVE    "0004"  TO  SPA-ERRCD
                           GO  TO  49001-MINYURYOKU-CHK-EXT
                       END-IF
                   END-PERFORM
               END-IF
           END-PERFORM
      *
           .
      *
       49001-MINYURYOKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC         TO  SYS-3003-REC
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL ( IDX >       SYS-3003-JOBID )
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                   IF    ( SJOBKANRI-RETURN    =   ZERO )
                       IF    ( JOB-ENDYMD      =   SPACE )
      *********        AND     JOB-TERMID      =   SPA-TERMID
                           MOVE    "6666"          TO  SPA-LIDCD
                           GO  TO  210-BACK-EXT
                       END-IF
                   END-IF
               END-PERFORM
           END-IF
      *
           PERFORM 210-BACK-SYORI-SEC
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    クリア　処理
      *****************************************************************
       230-CLEAR-SEC                   SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   WRK-CONS-LINE-MAX )
      *
               MOVE    "F"             TO  SPA-GMN-CHK-VALUE (IDXA)
      *
               PERFORM VARYING IDXB    FROM    1   BY  1
                       UNTIL ( IDXB    >   WRK-CONS-PARA-MAX )
                   MOVE    SPACE       TO  SPA-NAI-HENPARA (IDXA IDXB)
                                           SPA-GMN-PARA    (IDXA IDXB)
               END-PERFORM
           END-PERFORM
      *
           .
       230-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      *
      *
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "L01"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           INITIALIZE                  SPA-KYOTUKEY
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
      *
      *****************************************************************
      *    個別出力処理
      *****************************************************************
       420-CHK-CHK-SEC                 SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           COMPUTE IDZ             =   IDX
                                   + ( SPA-GMN-PAGE    -   1 )
                                   * WRK-CONS-SCR-MAX
      *
           MOVE    L01-CHK-VALUE (IDX) TO  SPA-GMN-CHK-VALUE (IDZ)
      *
           COMPUTE SPA-GMN-CUR   =   ( IDX -   1)
                                 *   ( WRK-CONS-PARA-MAX + 1 )
                                 +     1
                                 +     1
      *
           MOVE    IDZ                 TO  IDXA
           PERFORM VARYING IDXB    FROM    1   BY  1
                       UNTIL ( IDXB    >   WRK-CONS-PARA-MAX )
               IF    ( SPA-GMN-PARAHYOJI (IDXA IDXB)
                                   NOT =   SPACE )
                AND  ( SPA-GMN-PARA (IDXA IDXB)
                                       =   SPACE )
                AND  ( SPA-NAI-HISSU-KBN (IDXA IDXB)  =   "1" )
      *            パラメータ基本値設定
                   PERFORM 41011-PARA-KIHON-SET-SEC
               END-IF
           END-PERFORM
      *
           .
       420-CHK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       460-MAEGMN-SEC             SECTION.
      *
      *    入力チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  460-MAEGMN-EXT
           END-IF
      *
           IF    ( SPA-GMN-PAGE   =   1 )
               MOVE    "0006"          TO  SPA-ERRCD
               GO  TO  460-MAEGMN-EXT
           END-IF
           COMPUTE SPA-GMN-PAGE    =   SPA-GMN-PAGE    -   1
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           .
       460-MAEGMN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       470-ATOGMN-SEC                    SECTION.
      *
      *    入力チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  470-ATOGMN-EXT
           END-IF
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           IF      SPA-GMN-PAGE       =   SPA-GMN-MAXPAGE
               MOVE    "0007"             TO  SPA-ERRCD
               GO  TO  470-ATOGMN-EXT
           END-IF
           COMPUTE SPA-GMN-PAGE   =    SPA-GMN-PAGE    +   1
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           .
       470-ATOGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷前確認処理
      *****************************************************************
       490-PRINT-MAE-SEC                   SECTION.
      *
      *    入力チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-PRINT-MAE-EXT
           END-IF
      *
      *    ジョブ管理チェック
           PERFORM 4900-JOBKANRICHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-PRINT-MAE-EXT
           END-IF
      *
      *    関連チェック
           PERFORM 4900-KANRENCHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  490-PRINT-MAE-EXT
           END-IF
      *
           MOVE    "1001"              TO  SPA-LIDCD
      *
           .
       490-PRINT-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       490-PRINT-SEC                       SECTION.
      *
      *    ＪＯＢＩＤ（３００４）削除処理
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC
               MOVE    SYS-3003-REC        TO  MCPDATA-REC
               MOVE    "DBDELETE"          TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   CONTINUE
               ELSE
                   MOVE    "1005"              TO  SPA-ERRCD
                   GO  TO  490-PRINT-EXT
               END-IF
           END-IF
      *
      *    ジョブ管理削除処理
           MOVE    "ALL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING   ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           IF      SJOBKANRI-RETURN    =   ZERO
               CONTINUE
           ELSE
               MOVE    "1004"              TO  SPA-ERRCD
               GO  TO  490-PRINT-EXT
           END-IF
      *
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
           ACCEPT  SYS-TIME            FROM    TIME
      *
           MOVE    ZERO                TO  WRK-CONS-JOB-JOBID
                                           WRK-PRTKANRI-RENNUM
           MOVE    SPACE               TO  WRK-CONS-PRTKANRI-TBL-GROUP
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    SPA-TERMID          TO  RECEERR-TERMID
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
           IF      ORCSPRTNM-RC    NOT =   ZERO
               INITIALIZE                  SYS-1031-REC
           END-IF
      *
      *    出力先プリンタ名割り当て情報編集
      *    MOVE    SPACE               TO  SYS-1031-REC
      *    INITIALIZE                  SYS-1031-REC
      *    MOVE    "1031"              TO  SYS-1031-KANRICD
      *    MOVE    "*"                 TO  SYS-1031-KBNCD
      *    MOVE    SYS-1031-REC        TO  MCPDATA-REC
      *    PERFORM 900-SYSKANRI-INV-SEC
      *    IF      FLG-SYSKANRI        =   ZERO
      *        MOVE    MCPDATA-REC         TO  SYS-1031-REC
      *    ELSE
      *        INITIALIZE                  SYS-1031-REC
      *    END-IF
      *
           MOVE    WRK-SYSYMD          TO
                                   WRK-CONS-PRTKANRI-TBL-GROUP (1:8)
           MOVE    SYS-TIME            TO
                                   WRK-CONS-PRTKANRI-TBL-GROUP (9:)
      *
           PERFORM VARYING IDY FROM    1       BY  1
                   UNTIL ( IDY             >   WRK-CONS-LINE-MAX )
                   OR    ( SPA-ERRCD   NOT =   SPACE )
               IF      SPA-GMN-CHK-VALUE   (IDY)   =   "T"
      *
                   PERFORM 45011-JOBKANRI-HENSYU-SEC
      *
      *            印刷用スクリプト処理
      *
                   MOVE    SPACE           TO  LNK-PRTKANRI-AREA
                   INITIALIZE                  LNK-PRTKANRI-AREA
                   ADD     1               TO  WRK-PRTKANRI-RENNUM
                   MOVE    WRK-PRTKANRI-RENNUM
                                           TO  LNK-PRTKANRI-RENNUM
                   MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                           TO  LNK-PRTKANRI-TBL-KEY
                   MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                           TO  LNK-PRTKANRI-TBL-GROUP
                   MOVE    "000000"        TO  LNK-PRTKANRI-SRYYM
                   MOVE    SPA-SYSYMD      TO  LNK-PRTKANRI-SKYYMD
                   MOVE    "execoprg.sh"   TO  LNK-PRTKANRI-SHELLID
                   MOVE    ZERO            TO  LNK-PRTKANRI-PRIORITY
                   MOVE    SPA-TERMID      TO  LNK-PRTKANRI-TERMID
                   MOVE    SPA-OPID        TO  LNK-PRTKANRI-OPID
                   MOVE    SYS-1031-PRTNM (6)
                                           TO  LNK-PRTKANRI-PRTNM
      *
                   MOVE    SPACE           TO  SHELLTBL
      *************MOVE    SHELL-NAME      TO  SHELLTBL-NAME
      *            ファイルデイレクトリ位置指定
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
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  SHELLTBL-ARG12
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  SHELLTBL-ARG13
                   MOVE    SPA-HOSPID      TO  SHELLTBL-ARG14
                   MOVE    SPA-GMN-PRGNAME (IDY)
                                           TO  SHELLTBL-ARG15
                   MOVE    SPA-NAI-HENPARA (IDY 1)
                                           TO  SHELLTBL-ARG16
                   MOVE    SPA-NAI-HENPARA (IDY 2)
                                           TO  SHELLTBL-ARG17
                   MOVE    SPA-NAI-HENPARA (IDY 3)
                                           TO  SHELLTBL-ARG18
                   MOVE    SPA-NAI-HENPARA (IDY 4)
                                           TO  SHELLTBL-ARG19
                   MOVE    SPA-NAI-HENPARA (IDY 5)
                                           TO  SHELLTBL-ARG20
                   MOVE    SPA-NAI-HENPARA (IDY 6)
                                           TO  SHELLTBL-ARG21
                   MOVE    SPA-NAI-HENPARA (IDY 7)
                                           TO  SHELLTBL-ARG22
                   MOVE    SPA-NAI-HENPARA (IDY 8)
                                           TO  SHELLTBL-ARG23
                   MOVE    RECEERR         TO  SHELLTBL-ARG24
                   MOVE    SHELLTBL        TO  MCPDATA-REC
                   MOVE    "SHELL"         TO  MCP-FUNC
                   MOVE    PATH-SHELL-SHELL
                                           TO  MCP-PATH
                   CALL    "MCPSUB"        USING
                                               MCPAREA
                                               MCPDATA-REC
               END-IF
           END-PERFORM
      *
      *    印刷処理
      *
           IF     ( SPA-LID1-FLG        =   "OK" )
               PERFORM 45011-JOBKANRI-HENSYU-SEC
      *
               MOVE    0                   TO  WRK-STPAGE
               MOVE    99999               TO  WRK-EDPAGE
      *
               MOVE    SPACE               TO  SHELLTBL
      *****    MOVE    "/usr/local/orca/scripts/allways/print.sh"
      *****                            TO  SHELLTBL-NAME
      *        ファイルデイレクトリ位置指定
               INITIALIZE                  ORCSMKPASSAREA
               MOVE    "/scripts/allways/print.sh"
                                           TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
               MOVE    SPACE               TO  LNK-PRTKANRI-AREA
               INITIALIZE                      LNK-PRTKANRI-AREA
               MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                           TO  LNK-PRTKANRI-TBL-KEY
               MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                           TO  LNK-PRTKANRI-TBL-GROUP
               MOVE    ZERO                TO  LNK-PRTKANRI-RENNUM
               MOVE    ZERO                TO  LNK-PRTKANRI-SHORI-RENNUM
               MOVE    "000000"            TO  LNK-PRTKANRI-SRYYM
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
               MOVE    RECEERR             TO  SHELLTBL-ARG12
               MOVE    WRK-CONS-JOB-JOBID  TO  SHELLTBL-ARG13
               MOVE    WRK-CONS-JOB-SHELLID
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
      *
           PERFORM 45012-JOBID-UPD-SEC
      *
           PERFORM 490-KAKUNIN-SEC
      *
      *    PERFORM VARYING IDZ FROM    1   BY  1
      *            UNTIL ( IDZ >       WRK-CONS-LINE-MAX )
      *        MOVE    "F"             TO  SPA-GMN-CHK-VALUE(IDZ)
      *        INITIALIZE              SPA-GMN-PARA-TBL     (IDZ)
      *                                SPA-NAI-HENPARA-TBL  (IDZ)
      *    END-PERFORM
           .
       490-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ開始セット処理
      *****************************************************************
       45011-JOBKANRI-HENSYU-SEC       SECTION.
      *
           ADD     1               TO  WRK-CONS-JOB-JOBID
      *
           MOVE    "DEL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           MOVE    "JBS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
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
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
      *
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    ZERO                TO  SYS-3003-STYUKYMD
           MOVE    ALL "9"             TO  SYS-3003-EDYUKYMD
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                       TO  SYS-3003-TBL-KEY
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                       TO  SYS-3003-TBL-GROUP
           MOVE    WRK-CONS-JOB-JOBID  TO  SYS-3003-JOBID
      *
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"          TO  MCP-FUNC
           END-IF
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "SYSKANRI 3003  ERR KEY = ["
                                  MCP-RC  " " SYS-3003-KEY  "]"
      *****    MOVE    "1010"          TO  SPA-ERRCD
           END-IF
      *
           .
       45012-JOBID-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    情報削除画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-L01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "L01"               TO  SPA-MOTOPG
           MOVE    "XB01"              TO  SPA-SAKIPG
      *
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SPA-JOB-SHELLID
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
       490-JYOUHOU-DEL-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    再印刷画面へ
      *****************************************************************
       450-REPRINT-SEC             SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-L01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "L01"               TO  SPA-MOTOPG
           MOVE    "XA01"              TO  SPA-SAKIPG
      *
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
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
       450-REPRINT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    SPACE               TO  L99
           MOVE    ZERO                TO  L99-COUNT
      *
           MOVE    SPACE               TO  SYS-3003-REC
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC         TO  SYS-3003-REC
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL ( IDX >       SYS-3003-JOBID )
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
                   IF    ( SJOBKANRI-RETURN    =   ZERO )
                       MOVE    JOB-JOBID       TO  L99-RENNUM   (IDX)
                       MOVE    JOB-SHELLMSG    TO  L99-SHORINM  (IDX)
                       MOVE    JOB-STARTTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-STARTTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-STARTTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  L99-STARTTIME(IDX)
                       MOVE    JOB-ENDTIME(1:2)
                                               TO  WRK-HH
                       MOVE    JOB-ENDTIME(3:2)
                                               TO  WRK-MM
                       MOVE    JOB-ENDTIME(5:2)
                                               TO  WRK-SS
                       MOVE    WRK-HENTIME     TO  L99-ENDTIME  (IDX)
                       MOVE    JOB-UPDCNT      TO  WRK-PAGE
                       MOVE    WRK-PAGE        TO  L99-PAGE     (IDX)
                       MOVE    JOB-YOBI        TO  L99-ERRMSG   (IDX)
                       IF    ( JOB-ENDYMD      =   SPACE )
                           MOVE    "処理中です"    TO  L99-MSG
                       ELSE
                           IF    ( JOB-ERRCD   =   SPACE )
                               CONTINUE
                           ELSE
                               STRING  JOB-YOBI    DELIMITED  BY  SPACE
                                       "【"        DELIMITED  BY  SIZE
                                      JOB-SHELLMSG DELIMITED  BY  SPACE
                                      "】"         DELIMITED  BY  SIZE
                                                   INTO  L99-MSG
                           END-IF
                       END-IF
                       MOVE    IDX             TO  L99-COUNT
                   END-IF
               END-PERFORM
           END-IF
           IF    ( L99-MSG             =   SPACE )
               IF    ( L99-COUNT       >   ZERO )
                   MOVE    "処理は正常に終了しました"
                                                TO  L99-MSG
               ELSE
                   MOVE    "該当する処理はありません"
                                                TO  L99-MSG
               END-IF
           END-IF
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "L01"                TO  SPA-MOTOPG
           MOVE    "L99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "L99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF    ( SPA-ERRCD       NOT =   SPACE )
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF    ( SPA-LIDCD       NOT =   SPACE )
               EVALUATE    SPA-LIDCD
               WHEN    "1001"
                   PERFORM 540-LID2SET-SEC
                   GO  TO  500-SET-SCREEN-EXT
               WHEN    OTHER
                   PERFORM 520-LIDSET-SEC
                   GO  TO  500-SET-SCREEN-EXT
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "L01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    "red"               TO  L01-MARKHISSU-STYLE
           MOVE    "*"                 TO  L01-MARKHISSU
      *
           MOVE    "blue"              TO  L01-MARKNINI-STYLE
           MOVE    "*"                 TO  L01-MARKNINI
      *
           COMPUTE IDY     =   SPA-GMN-PAGE    *   WRK-CONS-SCR-MAX
           COMPUTE IDZ     =   IDY         - ( WRK-CONS-SCR-MAX - 1 )
      *
           MOVE    ZERO                TO  IDX
           PERFORM VARYING     IDZ1     FROM    IDZ   BY  1
                   UNTIL     ( IDZ1     >       IDY )
               ADD     1                        TO  IDX
               MOVE    SPA-GMN-NUM      (IDZ1)  TO  L01-NUM   (IDX)
               MOVE    SPA-GMN-CHK-VALUE(IDZ1)  TO  L01-CHK-VALUE (IDX)
               MOVE    SPA-GMN-HCNAME   (IDZ1)  TO  L01-CHK-LABEL (IDX)
      *
               PERFORM VARYING IDZ2 FROM    1   BY  1
                       UNTIL ( IDZ2 >       WRK-CONS-PARA-MAX )
      *
                   MOVE    SPA-GMN-PARAHYOJI (IDZ1 IDZ2)
                                       TO  L01-PARAHYOJI (IDX IDZ2)
                   MOVE    SPA-GMN-PARA      (IDZ1 IDZ2)
                                       TO  L01-PARA      (IDX IDZ2)
      *
                   MOVE    WIDGET-INSENSITIVE
                                       TO  L01-PARA-STATE(IDX IDZ2)
      *
                   MOVE    SPACE       TO  L01-PARAMARK-STYLE(IDX IDZ2)
                   MOVE    SPACE       TO  L01-PARAMARK      (IDX IDZ2)
                   IF    ( SPA-GMN-PARAHYOJI (IDZ1 IDZ2)
                                           NOT =   SPACE )
                       MOVE    WIDGET-NORMAL
                                       TO  L01-PARA-STATE(IDX IDZ2)
                       IF  ( SPA-NAI-HISSU-KBN(IDZ1 IDZ2)
                                               =   "1" )
                           MOVE    "red"
                                       TO  L01-PARAMARK-STYLE(IDX IDZ2)
                           MOVE    "*" TO  L01-PARAMARK      (IDX IDZ2)
                       ELSE
                           MOVE    "blue"
                                       TO  L01-PARAMARK-STYLE(IDX IDZ2)
                           MOVE    "*" TO  L01-PARAMARK      (IDX IDZ2)
                       END-IF
                   END-IF
               END-PERFORM
      *
               MOVE    WIDGET-INSENSITIVE
                                       TO  L01-CHK-STATE(IDX)
                                           L01-NUM-STATE(IDX)
      *
               IF    ( SPA-GMN-HCNAME   (IDZ1)  NOT =   SPACE )
                   MOVE    WIDGET-NORMAL
                                       TO  L01-NUM-STATE(IDX)
                                           L01-CHK-STATE(IDX)
               END-IF
           END-PERFORM
      *
           IF    ( SPA-GMN-PAGE            =   1 )
               MOVE    WIDGET-INSENSITIVE  TO  L01-B06-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  L01-B06-STATE
           END-IF
      *
           IF    ( SPA-GMN-PAGE            =   SPA-GMN-MAXPAGE )
               MOVE    WIDGET-INSENSITIVE  TO  L01-B07-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  L01-B07-STATE
           END-IF
      *
      *    カーソル位置
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル位置処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           IF    ( SPA-ERRCD           =   SPACE)
             AND ( SPA-GMN-CUR         =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           PERFORM 5012-CUR-SKIP-SEC
      *
           EVALUATE    SPA-GMN-CUR
           WHEN    01
               MOVE    "CHK01"             TO  MCP-WIDGET
           WHEN    02
               MOVE    "PARA011"           TO  MCP-WIDGET
           WHEN    03
               MOVE    "PARA012"           TO  MCP-WIDGET
           WHEN    04
               MOVE    "PARA013"           TO  MCP-WIDGET
           WHEN    05
               MOVE    "PARA014"           TO  MCP-WIDGET
           WHEN    06
               MOVE    "PARA015"           TO  MCP-WIDGET
           WHEN    07
               MOVE    "PARA016"           TO  MCP-WIDGET
           WHEN    08
               MOVE    "PARA017"           TO  MCP-WIDGET
           WHEN    09
               MOVE    "PARA018"           TO  MCP-WIDGET
           WHEN    10
               MOVE    "CHK02"             TO  MCP-WIDGET
           WHEN    11
               MOVE    "PARA021"           TO  MCP-WIDGET
           WHEN    12
               MOVE    "PARA022"           TO  MCP-WIDGET
           WHEN    13
               MOVE    "PARA023"           TO  MCP-WIDGET
           WHEN    14
               MOVE    "PARA024"           TO  MCP-WIDGET
           WHEN    15
               MOVE    "PARA025"           TO  MCP-WIDGET
           WHEN    16
               MOVE    "PARA026"           TO  MCP-WIDGET
           WHEN    17
               MOVE    "PARA027"           TO  MCP-WIDGET
           WHEN    18
               MOVE    "PARA028"           TO  MCP-WIDGET
           WHEN    19
               MOVE    "CHK03"             TO  MCP-WIDGET
           WHEN    20
               MOVE    "PARA031"           TO  MCP-WIDGET
           WHEN    21
               MOVE    "PARA032"           TO  MCP-WIDGET
           WHEN    22
               MOVE    "PARA033"           TO  MCP-WIDGET
           WHEN    23
               MOVE    "PARA034"           TO  MCP-WIDGET
           WHEN    24
               MOVE    "PARA035"           TO  MCP-WIDGET
           WHEN    25
               MOVE    "PARA036"           TO  MCP-WIDGET
           WHEN    26
               MOVE    "PARA037"           TO  MCP-WIDGET
           WHEN    27
               MOVE    "PARA038"           TO  MCP-WIDGET
           WHEN    28
               MOVE    "CHK04"             TO  MCP-WIDGET
           WHEN    29
               MOVE    "PARA041"           TO  MCP-WIDGET
           WHEN    30
               MOVE    "PARA042"           TO  MCP-WIDGET
           WHEN    31
               MOVE    "PARA043"           TO  MCP-WIDGET
           WHEN    32
               MOVE    "PARA044"           TO  MCP-WIDGET
           WHEN    33
               MOVE    "PARA045"           TO  MCP-WIDGET
           WHEN    34
               MOVE    "PARA046"           TO  MCP-WIDGET
           WHEN    35
               MOVE    "PARA047"           TO  MCP-WIDGET
           WHEN    36
               MOVE    "PARA048"           TO  MCP-WIDGET
           WHEN    37
               MOVE    "CHK05"             TO  MCP-WIDGET
           WHEN    38
               MOVE    "PARA051"           TO  MCP-WIDGET
           WHEN    39
               MOVE    "PARA052"           TO  MCP-WIDGET
           WHEN    40
               MOVE    "PARA053"           TO  MCP-WIDGET
           WHEN    41
               MOVE    "PARA054"           TO  MCP-WIDGET
           WHEN    42
               MOVE    "PARA055"           TO  MCP-WIDGET
           WHEN    43
               MOVE    "PARA056"           TO  MCP-WIDGET
           WHEN    44
               MOVE    "PARA057"           TO  MCP-WIDGET
           WHEN    45
               MOVE    "PARA058"           TO  MCP-WIDGET
           WHEN    46
               MOVE    "CHK06"             TO  MCP-WIDGET
           WHEN    47
               MOVE    "PARA061"           TO  MCP-WIDGET
           WHEN    48
               MOVE    "PARA062"           TO  MCP-WIDGET
           WHEN    49
               MOVE    "PARA063"           TO  MCP-WIDGET
           WHEN    50
               MOVE    "PARA064"           TO  MCP-WIDGET
           WHEN    51
               MOVE    "PARA065"           TO  MCP-WIDGET
           WHEN    52
               MOVE    "PARA066"           TO  MCP-WIDGET
           WHEN    53
               MOVE    "PARA067"           TO  MCP-WIDGET
           WHEN    54
               MOVE    "PARA068"           TO  MCP-WIDGET
           WHEN    55
               MOVE    "CHK07"             TO  MCP-WIDGET
           WHEN    56
               MOVE    "PARA071"           TO  MCP-WIDGET
           WHEN    57
               MOVE    "PARA072"           TO  MCP-WIDGET
           WHEN    58
               MOVE    "PARA073"           TO  MCP-WIDGET
           WHEN    59
               MOVE    "PARA074"           TO  MCP-WIDGET
           WHEN    60
               MOVE    "PARA075"           TO  MCP-WIDGET
           WHEN    61
               MOVE    "PARA076"           TO  MCP-WIDGET
           WHEN    62
               MOVE    "PARA077"           TO  MCP-WIDGET
           WHEN    63
               MOVE    "PARA078"           TO  MCP-WIDGET
           WHEN    64
               MOVE    "CHK08"             TO  MCP-WIDGET
           WHEN    65
               MOVE    "PARA081"           TO  MCP-WIDGET
           WHEN    66
               MOVE    "PARA082"           TO  MCP-WIDGET
           WHEN    67
               MOVE    "PARA083"           TO  MCP-WIDGET
           WHEN    68
               MOVE    "PARA084"           TO  MCP-WIDGET
           WHEN    69
               MOVE    "PARA085"           TO  MCP-WIDGET
           WHEN    70
               MOVE    "PARA086"           TO  MCP-WIDGET
           WHEN    71
               MOVE    "PARA087"           TO  MCP-WIDGET
           WHEN    72
               MOVE    "PARA088"           TO  MCP-WIDGET
           WHEN    73
               MOVE    "CHK09"             TO  MCP-WIDGET
           WHEN    74
               MOVE    "PARA091"           TO  MCP-WIDGET
           WHEN    75
               MOVE    "PARA092"           TO  MCP-WIDGET
           WHEN    76
               MOVE    "PARA093"           TO  MCP-WIDGET
           WHEN    77
               MOVE    "PARA094"           TO  MCP-WIDGET
           WHEN    78
               MOVE    "PARA095"           TO  MCP-WIDGET
           WHEN    79
               MOVE    "PARA096"           TO  MCP-WIDGET
           WHEN    80
               MOVE    "PARA097"           TO  MCP-WIDGET
           WHEN    81
               MOVE    "PARA098"           TO  MCP-WIDGET
           WHEN    82
               MOVE    "CHK10"             TO  MCP-WIDGET
           WHEN    83
               MOVE    "PARA101"           TO  MCP-WIDGET
           WHEN    84
               MOVE    "PARA102"           TO  MCP-WIDGET
           WHEN    85
               MOVE    "PARA103"           TO  MCP-WIDGET
           WHEN    86
               MOVE    "PARA104"           TO  MCP-WIDGET
           WHEN    87
               MOVE    "PARA105"           TO  MCP-WIDGET
           WHEN    88
               MOVE    "PARA106"           TO  MCP-WIDGET
           WHEN    89
               MOVE    "PARA107"           TO  MCP-WIDGET
           WHEN    90
               MOVE    "PARA108"           TO  MCP-WIDGET
           WHEN    99
               MOVE    "B12"               TO  MCP-WIDGET
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
           WHEN    "CHK01"
               MOVE    01                  TO  SPA-GMN-CUR
           WHEN    "PARA011"
               MOVE    02                  TO  SPA-GMN-CUR
           WHEN    "PARA012"
               MOVE    03                  TO  SPA-GMN-CUR
           WHEN    "PARA013"
               MOVE    04                  TO  SPA-GMN-CUR
           WHEN    "PARA014"
               MOVE    05                  TO  SPA-GMN-CUR
           WHEN    "PARA015"
               MOVE    06                  TO  SPA-GMN-CUR
           WHEN    "PARA016"
               MOVE    07                  TO  SPA-GMN-CUR
           WHEN    "PARA017"
               MOVE    08                  TO  SPA-GMN-CUR
           WHEN    "PARA018"
               MOVE    09                  TO  SPA-GMN-CUR
           WHEN    "CHK02"
               MOVE    10                  TO  SPA-GMN-CUR
           WHEN    "PARA021"
               MOVE    11                  TO  SPA-GMN-CUR
           WHEN    "PARA022"
               MOVE    12                  TO  SPA-GMN-CUR
           WHEN    "PARA023"
               MOVE    13                  TO  SPA-GMN-CUR
           WHEN    "PARA024"
               MOVE    14                  TO  SPA-GMN-CUR
           WHEN    "PARA025"
               MOVE    15                  TO  SPA-GMN-CUR
           WHEN    "PARA026"
               MOVE    16                  TO  SPA-GMN-CUR
           WHEN    "PARA027"
               MOVE    17                  TO  SPA-GMN-CUR
           WHEN    "PARA028"
               MOVE    18                  TO  SPA-GMN-CUR
           WHEN    "CHK03"
               MOVE    19                  TO  SPA-GMN-CUR
           WHEN    "PARA031"
               MOVE    20                  TO  SPA-GMN-CUR
           WHEN    "PARA032"
               MOVE    21                  TO  SPA-GMN-CUR
           WHEN    "PARA033"
               MOVE    22                  TO  SPA-GMN-CUR
           WHEN    "PARA034"
               MOVE    23                  TO  SPA-GMN-CUR
           WHEN    "PARA035"
               MOVE    24                  TO  SPA-GMN-CUR
           WHEN    "PARA036"
               MOVE    25                  TO  SPA-GMN-CUR
           WHEN    "PARA037"
               MOVE    26                  TO  SPA-GMN-CUR
           WHEN    "PARA038"
               MOVE    27                  TO  SPA-GMN-CUR
           WHEN    "CHK04"
               MOVE    28                  TO  SPA-GMN-CUR
           WHEN    "PARA041"
               MOVE    29                  TO  SPA-GMN-CUR
           WHEN    "PARA042"
               MOVE    30                  TO  SPA-GMN-CUR
           WHEN    "PARA043"
               MOVE    31                  TO  SPA-GMN-CUR
           WHEN    "PARA044"
               MOVE    32                  TO  SPA-GMN-CUR
           WHEN    "PARA045"
               MOVE    33                  TO  SPA-GMN-CUR
           WHEN    "PARA046"
               MOVE    34                  TO  SPA-GMN-CUR
           WHEN    "PARA047"
               MOVE    35                  TO  SPA-GMN-CUR
           WHEN    "PARA048"
               MOVE    36                  TO  SPA-GMN-CUR
           WHEN    "CHK05"
               MOVE    37                  TO  SPA-GMN-CUR
           WHEN    "PARA051"
               MOVE    38                  TO  SPA-GMN-CUR
           WHEN    "PARA052"
               MOVE    39                  TO  SPA-GMN-CUR
           WHEN    "PARA053"
               MOVE    40                  TO  SPA-GMN-CUR
           WHEN    "PARA054"
               MOVE    41                  TO  SPA-GMN-CUR
           WHEN    "PARA055"
               MOVE    42                  TO  SPA-GMN-CUR
           WHEN    "PARA056"
               MOVE    43                  TO  SPA-GMN-CUR
           WHEN    "PARA057"
               MOVE    44                  TO  SPA-GMN-CUR
           WHEN    "PARA058"
               MOVE    45                  TO  SPA-GMN-CUR
           WHEN    "CHK06"
               MOVE    46                  TO  SPA-GMN-CUR
           WHEN    "PARA061"
               MOVE    47                  TO  SPA-GMN-CUR
           WHEN    "PARA062"
               MOVE    48                  TO  SPA-GMN-CUR
           WHEN    "PARA063"
               MOVE    49                  TO  SPA-GMN-CUR
           WHEN    "PARA064"
               MOVE    50                  TO  SPA-GMN-CUR
           WHEN    "PARA065"
               MOVE    51                  TO  SPA-GMN-CUR
           WHEN    "PARA066"
               MOVE    52                  TO  SPA-GMN-CUR
           WHEN    "PARA067"
               MOVE    53                  TO  SPA-GMN-CUR
           WHEN    "PARA068"
               MOVE    54                  TO  SPA-GMN-CUR
           WHEN    "CHK07"
               MOVE    55                  TO  SPA-GMN-CUR
           WHEN    "PARA071"
               MOVE    56                  TO  SPA-GMN-CUR
           WHEN    "PARA072"
               MOVE    57                  TO  SPA-GMN-CUR
           WHEN    "PARA073"
               MOVE    58                  TO  SPA-GMN-CUR
           WHEN    "PARA074"
               MOVE    59                  TO  SPA-GMN-CUR
           WHEN    "PARA075"
               MOVE    60                  TO  SPA-GMN-CUR
           WHEN    "PARA076"
               MOVE    61                  TO  SPA-GMN-CUR
           WHEN    "PARA077"
               MOVE    62                  TO  SPA-GMN-CUR
           WHEN    "PARA078"
               MOVE    63                  TO  SPA-GMN-CUR
           WHEN    "CHK08"
               MOVE    64                  TO  SPA-GMN-CUR
           WHEN    "PARA081"
               MOVE    65                  TO  SPA-GMN-CUR
           WHEN    "PARA082"
               MOVE    66                  TO  SPA-GMN-CUR
           WHEN    "PARA083"
               MOVE    67                  TO  SPA-GMN-CUR
           WHEN    "PARA084"
               MOVE    68                  TO  SPA-GMN-CUR
           WHEN    "PARA085"
               MOVE    69                  TO  SPA-GMN-CUR
           WHEN    "PARA086"
               MOVE    70                  TO  SPA-GMN-CUR
           WHEN    "PARA087"
               MOVE    71                  TO  SPA-GMN-CUR
           WHEN    "PARA088"
               MOVE    72                  TO  SPA-GMN-CUR
           WHEN    "CHK09"
               MOVE    73                  TO  SPA-GMN-CUR
           WHEN    "PARA091"
               MOVE    74                  TO  SPA-GMN-CUR
           WHEN    "PARA092"
               MOVE    75                  TO  SPA-GMN-CUR
           WHEN    "PARA093"
               MOVE    76                  TO  SPA-GMN-CUR
           WHEN    "PARA094"
               MOVE    77                  TO  SPA-GMN-CUR
           WHEN    "PARA095"
               MOVE    78                  TO  SPA-GMN-CUR
           WHEN    "PARA096"
               MOVE    79                  TO  SPA-GMN-CUR
           WHEN    "PARA097"
               MOVE    80                  TO  SPA-GMN-CUR
           WHEN    "PARA098"
               MOVE    81                  TO  SPA-GMN-CUR
           WHEN    "CHK10"
               MOVE    82                  TO  SPA-GMN-CUR
           WHEN    "PARA101"
               MOVE    83                  TO  SPA-GMN-CUR
           WHEN    "PARA102"
               MOVE    84                  TO  SPA-GMN-CUR
           WHEN    "PARA103"
               MOVE    85                  TO  SPA-GMN-CUR
           WHEN    "PARA104"
               MOVE    86                  TO  SPA-GMN-CUR
           WHEN    "PARA105"
               MOVE    87                  TO  SPA-GMN-CUR
           WHEN    "PARA106"
               MOVE    88                  TO  SPA-GMN-CUR
           WHEN    "PARA107"
               MOVE    89                  TO  SPA-GMN-CUR
           WHEN    "PARA108"
               MOVE    90                  TO  SPA-GMN-CUR
           WHEN    "B12"
               MOVE    99                  TO  SPA-GMN-CUR
           END-EVALUATE
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "PARA108"
               MOVE    99                  TO  SPA-GMN-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-CUR =   SPA-GMN-CUR +   1
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *****************************************************************
      *    カーソルスキップ処理
      *****************************************************************
       5012-CUR-SKIP-SEC               SECTION.
      *
      *    非活性項目にカーソルが移動した場合はスキップする
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   WRK-CONS-SCR-MAX )
               COMPUTE WRK-CHK-CUR = ( IDX1    -   1 )
                                   * WRK-CONS-PARA-MAX
                                   + IDX1
               IF    ( SPA-GMN-CUR             = WRK-CHK-CUR  )
                AND  ( L01-CHK-STATE(IDX1)     = WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-CUR =   SPA-GMN-CUR   + 1
               END-IF
      *
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   WRK-CONS-PARA-MAX )
                   COMPUTE WRK-CHK-CUR = WRK-CHK-CUR
                                       + 1
                   IF    ( SPA-GMN-CUR         = WRK-CHK-CUR  )
                    AND  ( L01-PARA-STATE(IDX1 IDX2)
                                               = WIDGET-INSENSITIVE )
                       COMPUTE SPA-GMN-CUR =   SPA-GMN-CUR   + 1
                   END-IF
               END-PERFORM
      *
           END-PERFORM
      *
           IF    ( SPA-GMN-CUR >   90 )
               MOVE    99          TO  SPA-GMN-CUR
           END-IF
      *
           .
      *
       5012-CUR-SKIP-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE                           TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "0002"
               MOVE    "入力エラー"                TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "項目に入力がありません"    TO  SPA-ERRMSG
           WHEN    "0004"
               MOVE    "必須パラメタで入力されてない項目があります"
                                                   TO  SPA-ERRMSG
           WHEN    "0005"
               MOVE    "対象の処理が選択されていません"
                                                   TO  SPA-ERRMSG
           WHEN    "0006"
               MOVE    "前頁はありません"          TO  SPA-ERRMSG
           WHEN    "0007"
               MOVE    "次頁はありません"          TO  SPA-ERRMSG
           WHEN    "1001"
               MOVE    "更新ができませんでした"
                                                   TO  SPA-ERRMSG
           WHEN    "1004"
               MOVE    "ジョブ管理ＤＢが削除できませんでした"
                                                   TO  SPA-ERRMSG
           WHEN    "1005"
               MOVE
                   "システム管理ＤＢ（３００３）が削除できませんでした"
                                                   TO  SPA-ERRMSG
               WHEN    "7777"
                   MOVE    WRK-RECEERR             TO  SPA-ERRMSG
               WHEN    "9999"
                   MOVE    WRK-RECEERR             TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  LERR
           MOVE    SPA-ERRCD           TO  LERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  LERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "L01"               TO  SPA-MOTOPG
           MOVE    "LERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "LERR"              TO  MCP-WINDOW
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
       520-LIDSET-SEC              SECTION.
      *
           MOVE    SPACE                TO  WRK-LIDMSG
      *
           EVALUATE    SPA-LIDCD
           WHEN    "1001"
               MOVE    "選択された帳票の印刷を開始します"
                                        TO  WRK-LIDMSG
           WHEN    "6666"
               MOVE    "処理中です"     TO  WRK-LIDMSG
           WHEN    "8888"
               MOVE    "処理が正常終了しました"
                                        TO  WRK-LIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  LID1
           MOVE    SPA-LIDCD            TO  LID1-ID1CODE
           MOVE    WRK-LIDMSG           TO  LID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "L01"                TO  SPA-MOTOPG
           MOVE    "LID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "LID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       520-LIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       540-LID2SET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-LIDMSG
      *
           EVALUATE    SPA-LIDCD
               WHEN    "1001"
                   MOVE    "選択された帳票の印刷を開始します"
                                        TO  WRK-LIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  LID2
           MOVE    SPA-LIDCD            TO  LID2-ID1CODE
           MOVE    WRK-LIDMSG           TO  LID2-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "L01"                TO  SPA-MOTOPG
           MOVE    "LID2"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "LID2"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       540-LID2SET-EXT.
           EXIT.
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           IF    ( SGDAY-RC            =   ZERO )
               MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY          TO  WRK-SYMD
           ELSE
               MOVE    "0002"              TO  SPA-ERRCD
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    年月チェック・編集処理
      *****************************************************************
       5003-NENGETSU-CHK-SEC         SECTION.
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
               MOVE    "0002"          TO  SPA-ERRCD
           END-IF
           .
       5003-NENGETSU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込処理
      *****************************************************************
       900-SYSKANRI-NEXT-SEC            SECTION.
      *
           MOVE  "DBFETCH"             TO  MCP-FUNC
           MOVE  "SYSKANRI-KEY2"       TO  ORC-DBPATH
           CALL  "ORCMCPSUB"           USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF   ( MCP-RC               =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-3001-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
      *
       120-FECH-EXT.
           EXIT.
      *
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
