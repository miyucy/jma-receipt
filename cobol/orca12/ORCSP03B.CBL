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
       PROGRAM-ID.             ORCSP03B.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 公費入力チェックサブ（Ｐ０２Ｗ１のサブ）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/06/27    MCC-多々納    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
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
           03  FLG-END             PIC X(03).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-KENSYO          PIC 9(01).
           03  FLG-RJN             PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-OK2             PIC 9(01).
           03  FLG-KAKUTEI         PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX-K               PIC 9(04).
           03  IDX-K2              PIC 9(04).
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDK2                PIC 9(02).
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
      *     エラー位置
           03  WRK-ERR-CUR         PIC 9(02).
      *
           03  WRK-ERRMSG          PIC X(40).
           03  WRK-GMN-LINE        PIC 9(04).
           03  WRK-EDANUM          PIC 9(04).
      *
           03  WRK-N-IDX           PIC 9(04).
      *
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-BASEYMD.
               05  WRK-BYY         PIC 9(04).
               05  WRK-BMM         PIC 9(02).
               05  WRK-BDD         PIC 9(02).
           03  WRK-YMD65.
               05  WRK-B65YY       PIC 9(04).
               05  WRK-B65MM       PIC 9(02).
               05  WRK-B65DD       PIC 9(02).
           03  WRK-YMD70.
               05  WRK-B70YY       PIC 9(04).
               05  WRK-B70MM       PIC 9(02).
               05  WRK-B70DD       PIC 9(02).
      *
           03  WRK-KENSAKU-AREA.
               05  WRK-KEN-HKNNUM    PIC X(03).
               05  WRK-KEN-TEKSTYMD  PIC X(08).
               05  WRK-KEN-TEKEDYMD  PIC X(08).
               05  WRK-KEN-ERFLG     PIC X(01).
      *    検証番号チェック
           03  WRK-MOJ-AREA.
               05  WRK-MOJ-MAX     PIC 9(02).
               05  WRK-MOJ-NXT     PIC 9(02).
      *    年齢算出
           03  WRK-NENREI.
               05  WRK-NENREI-YY   PIC 9(03).
           03  WRK-YMDS1.
               05  WRK-YYS1        PIC 9(04).
               05  WRK-MMS1        PIC 9(02).
               05  WRK-DDS1        PIC 9(02).
           03  WRK-YMDS2.
               05  WRK-YYS2        PIC 9(04).
               05  WRK-MMS2        PIC 9(02).
               05  WRK-DDS2        PIC 9(02).
           03  WRK-STYEAR          PIC 9(03).
           03  WRK-EDYEAR          PIC 9(03).
      *
           03  WRK-IDX-AREA.
               05  WRK-IDX         PIC 9(04)  OCCURS   3.
      *
           03  WRK-MAE-KOHNUM      PIC X(03).
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
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    保険者号マスタ
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   数字変換領域
           COPY    "CPORCSNUM.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   チェックデジット
           COPY    "CPORCCHKDGT.INC".
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    患者登録スパ領域
           COPY    "P02COMMON-SPA".
      *    患者画面スパ領域
           COPY    "P02SCR-SPA".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           SPA-P02SCRAREA
           SPA-P02KYOUTU
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
           PERFORM VARYING     IDX-K   FROM    1   BY  1
                   UNTIL      (IDX-K       >   3   )  OR
                              (SPA-ERRCD   NOT =   SPACE )
      *        基本チェック
               PERFORM 100-KIHON-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   COMPUTE SPA-GMN-CUR     =   SPA-GMN-CUR
                                           +  ((IDX-K  -   1  )  *  6 )
               END-IF
           END-PERFORM
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      000-PROC-EXT
           END-IF
      *
      *    確定処理の時、関連チェックを行う
           PERFORM VARYING     IDX-K   FROM    1   BY  1
                   UNTIL      (IDX-K       >   3   )  OR
                              (SPA-ERRCD   NOT =   SPACE )
               PERFORM 200-KANREN-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   COMPUTE SPA-GMN-CUR     =   SPA-GMN-CUR
                                           +  ((IDX-K  -   1  )  *  6 )
               END-IF
           END-PERFORM
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      000-PROC-EXT
           END-IF
      *
      *    すべてのエラーがない時、公費期間重複チェック
           IF      SPA-HKNKOH-FLG      =   1
               PERFORM 300-KANREN-KOH-CHECK-SEC
           END-IF
      *
           .
       000-PROC-EXT.
           EXIT.
      *
           EXIT    PROGRAM
           .
      *
      ****************************************************************
      *    基本チェック処理
      ****************************************************************
       100-KIHON-CHK-SEC     SECTION.
      *
      *    負担者番号
           PERFORM 1001-FTNJANUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *
      *    公費
           PERFORM 1001-KOHNUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    受給者番号
           PERFORM 1001-JKYSNUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    適用開始日
           PERFORM 1001-KTEKSTYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    適用終了日
           PERFORM 1001-KTEKEDYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    確認日
           PERFORM 1001-KKAKUNINYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
           .
       100-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    負担者番号入力処理
      *****************************************************************
       1001-FTNJANUM-CHK-SEC           SECTION.
      *
      *    未入力
           IF      SPA-GMN-FTNJANUM (IDX-K)  =   SPACE
               GO      TO      1001-FTNJANUM-CHK-EXT
           END-IF
      *
      *    桁数チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN-FTNJANUM (IDX-K)
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
      *    半角で間に空白がないこと
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-RC2     NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   2     )
               MOVE    "0071"              TO  SPA-ERRCD
               MOVE    20                  TO  SPA-GMN-CUR
               GO      TO      1001-FTNJANUM-CHK-EXT
           END-IF
           IF     (KANACHK-MAX         <=  1   )  OR
                  (KANACHK-MAX         >   8   )
               MOVE    "0071"              TO  SPA-ERRCD
               MOVE    20                  TO  SPA-GMN-CUR
               GO      TO      1001-FTNJANUM-CHK-EXT
           END-IF
      *
      *    保険者番号　検索チェック
           INITIALIZE                    HKNJAINF-REC
           MOVE    SPA-HOSPID            TO  HKNJA-HOSPID
           MOVE    SPA-GMN-FTNJANUM (IDX-K)
                                         TO  HKNJA-HKNJANUM
           MOVE    HKNJAINF-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"            TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
               PERFORM 900-HKNJAINF-READ-SEC
           ELSE
               INITIALIZE                  HKNJAINF-REC
               MOVE    1               TO  FLG-HKNJAINF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    保険者番号あり
           IF      FLG-HKNJAINF        =   ZERO
               MOVE    HKNJA-HKNNUM        TO  WRK-MAE-KOHNUM
           ELSE
               EVALUATE    SPA-GMN-FTNJANUM(IDX-K)(1:2)
      *            老人
                   WHEN    "27"
                       MOVE    "027"              TO  WRK-MAE-KOHNUM
      *            特定
                   WHEN    "51"
                       EVALUATE    SPA-GMN-FTNJANUM(IDX-K)(5:3)
                           WHEN    "601"
                               MOVE    "091"      TO  WRK-MAE-KOHNUM
                           WHEN    "602"
                               MOVE    "051"      TO  WRK-MAE-KOHNUM
                           WHEN    OTHER
                               MOVE    "0021"     TO  SPA-ERRCD
                               GO      TO      1001-FTNJANUM-CHK-EXT
                       END-EVALUATE
      *            その他
                   WHEN    OTHER
      *                法別番号より公費種類を決定する
                       PERFORM 10011-HKNNUM-SET-SEC
               END-EVALUATE
           END-IF
      *
           IF      WRK-MAE-KOHNUM      =   SPACE
               GO      TO      1001-FTNJANUM-CHK-EXT
           END-IF
      *    更新の時、保険区分変更時、エラーとする
           MOVE    SPA-NAI-PTKOH-EDANUM (IDX-K)    TO  IDX-K2
           IF     (IDX-K2                  >   ZERO      ) AND
                  (SPA-PTKOH-SINKIKBN (IDX-K2)
                                           =   SPACE    )  AND
                  (SPA-MAE-KOHNUM (IDX-K)
                                       NOT =   SPACE    )
               IF      WRK-MAE-KOHNUM  NOT =   SPA-MAE-KOHNUM(IDX-K)
                   MOVE    "0074"          TO  SPA-ERRCD
                   MOVE    20              TO  SPA-GMN-CUR
               END-IF
           ELSE
               MOVE    WRK-MAE-KOHNUM      TO  SPA-GMN-KOHNUM(IDX-K)
           END-IF
      *
           .
       1001-FTNJANUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    法別番号より公費種類処理
      *****************************************************************
       10011-HKNNUM-SET-SEC           SECTION.
      *
           INITIALIZE                  HKNNUM-REC
           MOVE    SPA-HOSPID          TO  HKN-HOSPID
           MOVE    SPA-GMN-FTNJANUM(IDX-K) (1:2)
                                       TO  HKN-HBTNUM
           MOVE    SPA-SYSYMD          TO  HKN-TEKSTYMD
           MOVE    SPA-SYSYMD          TO  HKN-TEKEDYMD
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "HKNNUM-KEY4"       TO  ORC-DBPATH
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY4"       TO  ORC-DBPATH
               PERFORM 921-HKNMST-NEXT-SEC
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1                   TO  FLG-HKNNUM
           END-IF
           MOVE    ZERO                TO  FLG-OK
           PERFORM UNTIL     FLG-HKNNUM    =   1
               IF      HKN-HKNNUM      =   SPA-MAE-KOHNUM (IDX-K)
                   MOVE    1               TO  FLG-OK
               ELSE
                   MOVE    HKN-HKNNUM      TO  WRK-MAE-KOHNUM
               END-IF
      *
               MOVE    "HKNNUM-KEY4"       TO  ORC-DBPATH
               PERFORM 921-HKNMST-NEXT-SEC
           END-PERFORM
      *
           IF     FLG-OK               =   1
               MOVE    SPACE           TO  WRK-MAE-KOHNUM
           END-IF
      *
           .
       10011-HKNNUM-SET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    公費の種類チェック処理
      *****************************************************************
       1001-KOHNUM-CHK-SEC           SECTION.
      *
      *    更新の時、保険区分変更時、エラーとする
           MOVE    SPA-NAI-PTKOH-EDANUM (IDX-K)    TO  IDX-K2
           IF     (IDX-K2                  >   ZERO      ) AND
                  (SPA-PTKOH-SINKIKBN (IDX-K2)
                                           =    SPACE    ) AND
                  (SPA-MAE-KOHNUM (IDX-K)  NOT =   SPACE )
               IF      SPA-GMN-KOHNUM(IDX-K)
                                       NOT =   SPA-MAE-KOHNUM(IDX-K)
      *            前の公費へ戻す
                   MOVE    SPA-MAE-KOHNUM-G (IDX-K)
                                           TO  SPA-GMN-KOHNUM-G(IDX-K)
                   MOVE    "0074"          TO  SPA-ERRCD
                   MOVE    22              TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF      SPA-GMN-KOHNUM(IDX-K)   =   SPACE
               GO      TO      1001-KOHNUM-CHK-EXT
           END-IF
      *
      *    新規の時、チェック・編集
           IF     (IDX-K2              =   ZERO    )  OR
                  (SPA-PTKOH-SINKIKBN (IDX-K2)
                                       =   "1"      )
               PERFORM 41011-HKNNUM-SYORI-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   MOVE    21              TO  SPA-GMN-CUR
                   GO      TO                  1001-KOHNUM-CHK-EXT
               END-IF
           END-IF
           .
      *
       1001-KOHNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    公費の種類選択チェック・編集処理
      *****************************************************************
       41011-HKNNUM-SYORI-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-KOHMAX
               IF      SPA-GMN-KOHNUM(IDX-K)
                                      =    SPA-GMN-KOHNUML (IDX)
                   MOVE    SPA-GMN-KOHNUMLST (IDX)
                                           TO  SPA-GMN-KOHNUM-G(IDX-K)
      *
                   MOVE    SPA-NAI-KOHSBTKBN (IDX)
                                           TO  SPA-NAI-PTKOH-SBTKBN
                                                              (IDX-K)
                   MOVE    SPA-GMN-KOHMAX      TO  IDX
                   MOVE    1                   TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0072"              TO  SPA-ERRCD
           END-IF
      *
      *    老人保健で適用開始日未入力時、年齢チェックを行う
           IF     (SPA-NAI-PTKOH-SBTKBN(IDX-K) =   "3"  ) AND
                  (SPA-GMN-KTEKSTYMD (IDX-K)   =   SPACE) AND
                  (SPA-NAI-BIRTHDAY        NOT =   SPACE)
               PERFORM 410111-RJN-SYSYMD-CHK-SEC
           END-IF
      *
           .
       41011-HKNNUM-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    老人年齢チェック（システム日付）処理
      *****************************************************************
       410111-RJN-SYSYMD-CHK-SEC       SECTION.
      *
      *    生年月日から基準日を求める
      *    １日ならば生年月日、１日以外ならば生年月日の翌月１日
           MOVE    SPA-NAI-BIRTHDAY     TO  WRK-BASEYMD
           IF      SPA-NAI-BIRTHDAY (7:2)   NOT =   "01"
               PERFORM 4910-BIRTH-AFTER1MON-GET-SEC
               IF      SPA-ERRCD        NOT =   SPACE
                   GO  TO               410111-RJN-SYSYMD-CHK-EXT
               END-IF
           END-IF
      *    ６５歳を迎える日
           MOVE    WRK-BASEYMD         TO  WRK-YMD65
           COMPUTE WRK-B65YY           =   WRK-B65YY   +   65
      *    ７０歳を迎える日
           MOVE    WRK-BASEYMD         TO  WRK-YMD70
           COMPUTE WRK-B70YY           =   WRK-B70YY   +   70
      *    ６５歳を迎える日−１月を対象とする
           COMPUTE WRK-B65MM           =   WRK-B65MM   -   1
           IF      WRK-B65MM           =   ZERO
               COMPUTE WRK-B65YY           =   WRK-B65YY   -   1
               MOVE    12                  TO  WRK-B65MM
           END-IF
      *
           EVALUATE    TRUE
      *    エラー
               WHEN    ( SPA-SYSYMD  <   WRK-YMD65 )
                   MOVE    "0087"           TO  SPA-ERRCD
                   MOVE    21               TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
       410111-RJN-SYSYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    受給者番号入力　処理
      *****************************************************************
       1001-JKYSNUM-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-JKYSNUM (IDX-K) =   SPACE
               GO      TO      1001-JKYSNUM-CHK-EXT
           END-IF
      *
      *    半角・全角のチェックと桁数判定
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN-JKYSNUM (IDX-K)
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC      NOT =   ZERO
      *        半角・全角混在エラー
               MOVE    "0075"              TO  SPA-ERRCD
               MOVE    22                  TO  SPA-GMN-CUR
               GO      TO          1001-JKYSNUM-CHK-EXT
           END-IF
           IF      KANACHK-RC2     NOT =   ZERO
      *        入力文字エラー
               MOVE    "0076"         TO  SPA-ERRCD
               MOVE    22                  TO  SPA-GMN-CUR
               GO  TO                 1001-JKYSNUM-CHK-EXT
           END-IF
           IF      KANACHK-MAX         <=  1
               MOVE    "0076"              TO  SPA-ERRCD
               MOVE    22                  TO  SPA-GMN-CUR
           END-IF
      *
           .
       1001-JKYSNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    適応開始入力　処理
      *****************************************************************
       1001-KTEKSTYMD-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-KTEKSTYMD(IDX-K)    =   SPACE
               GO      TO      1001-KTEKSTYMD-CHK-EXT
           END-IF
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    SPA-GMN-KTEKSTYMD(IDX-K)
                                       TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  SPA-GMN-KTEKSTYMD(IDX-K)
               MOVE    SGDAY-SDAY          TO  SPA-NAI-KTEKSTYMD(IDX-K)
           ELSE
               MOVE    "0077"              TO  SPA-ERRCD
               MOVE    23                  TO  SPA-GMN-CUR
           END-IF
           .
       1001-KTEKSTYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力　処理
      *****************************************************************
       1001-KTEKEDYMD-CHK-SEC           SECTION.
      *
           IF     (SPA-GMN-KTEKSTYMD(IDX-K)    =   SPACE ) AND
                  (SPA-GMN-KTEKEDYMD(IDX-K)    =   SPACE )
               GO      TO      1001-KTEKEDYMD-CHK-EXT
           END-IF
      *
           IF     (SPA-GMN-KTEKEDYMD(IDX-K)    =   SPACE) OR
                  (SPA-GMN-KTEKEDYMD(IDX-K)(1:7)   =   "9999999" )
               MOVE    "9999999  "     TO  SPA-GMN-KTEKEDYMD(IDX-K)
               MOVE    ALL "9"         TO  SPA-NAI-KTEKEDYMD(IDX-K)
           ELSE
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-KTEKEDYMD(IDX-K)
                                           TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY     TO  SPA-GMN-KTEKEDYMD(IDX-K)
                   MOVE    SGDAY-SDAY      TO  SPA-NAI-KTEKEDYMD(IDX-K)
               ELSE
                   MOVE    SPACE           TO  SPA-NAI-KTEKEDYMD(IDX-K)
                   MOVE    "0078"              TO  SPA-ERRCD
                   MOVE    24                  TO  SPA-GMN-CUR
               END-IF
           END-IF
           .
       1001-KTEKEDYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認日付入力　処理
      *****************************************************************
       1001-KKAKUNINYMD-CHK-SEC           SECTION.
      *
           IF     (SPA-GMN-KTEKSTYMD(IDX-K)    =   SPACE ) AND
                  (SPA-GMN-KTEKEDYMD(IDX-K)    =   SPACE ) AND
                  (SPA-GMN-KKAKUNINYMD(IDX-K)  =   SPACE )
               GO      TO      1001-KKAKUNINYMD-CHK-EXT
           END-IF
      *
      *
           IF      SPA-GMN-KKAKUNINYMD(IDX-K)  =   SPACE
               MOVE    SPA-SYSYMD          TO  SPA-NAI-KKAKUNINYMD
                                                              (IDX-K)
               MOVE    SPA-SYSYMDWH        TO  SPA-GMN-KKAKUNINYMD
                                                              (IDX-K)
           ELSE
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-KKAKUNINYMD(IDX-K)
                                           TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY     TO  SPA-GMN-KKAKUNINYMD
                                                              (IDX-K)
                   MOVE    SGDAY-SDAY      TO  SPA-NAI-KKAKUNINYMD
                                                              (IDX-K)
               ELSE
                   MOVE    SPACE           TO  SPA-NAI-KKAKUNINYMD
                                                              (IDX-K)
                   MOVE    "0079"          TO  SPA-ERRCD
                   MOVE    25              TO  SPA-GMN-CUR
                   GO  TO                  1001-KKAKUNINYMD-CHK-EXT
               END-IF
               IF      SPA-NAI-KKAKUNINYMD(IDX-K)
                                           >   SPA-SYSYMD
                   MOVE    "0080"          TO  SPA-ERRCD
                   MOVE    25              TO  SPA-GMN-CUR
                   GO  TO                  1001-KKAKUNINYMD-CHK-EXT
               END-IF
           END-IF
           .
       1001-KKAKUNINYMD-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    関連チェック処理
      ****************************************************************
       200-KANREN-CHK-SEC     SECTION.
      *
      *    保険入力なし
           IF      (SPA-GMN-FTNJANUM (IDX-K)   =   SPACE  )  AND
                   (SPA-GMN-KOHNUM   (IDX-K)   =   SPACE  )  AND
                   (SPA-GMN-JKYSNUM  (IDX-K)   =   SPACE  )  AND
                   (SPA-GMN-KTEKSTYMD (IDX-K)  =   SPACE  )  AND
                   (SPA-GMN-KTEKEDYMD (IDX-K)  =   SPACE  )  AND
                   (SPA-GMN-KKAKUNINYMD(IDX-K) =   SPACE  )
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *
      *    保険入力あり
           IF      (SPA-GMN-KOHNUM   (IDX-K)   NOT =   SPACE  )  AND
                   (SPA-GMN-KTEKSTYMD (IDX-K)  NOT =   SPACE  )  AND
                   (SPA-GMN-KTEKEDYMD (IDX-K)  NOT =   SPACE  )  AND
                   (SPA-GMN-KKAKUNINYMD(IDX-K) NOT =   SPACE  )
               MOVE    1               TO  FLG-KAKUTEI
           ELSE
               MOVE    ZERO            TO  FLG-KAKUTEI
           END-IF
      *
      *    必須入力チェック
           IF      SPA-HKNKOH-FLG      =   1
               PERFORM 2001-HISSU-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO      TO      200-KANREN-CHK-EXT
               END-IF
           END-IF
      *
      *    すべての項目が入力済みの時、以下のチェックを行う
           IF      FLG-KAKUTEI         =   ZERO
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *    保険を確認
           IF      SPA-GMN-KOHNUM(IDX-K)   NOT =   SPACE
               PERFORM 2002-KOHKIKAN-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO      TO      200-KANREN-CHK-EXT
               END-IF
           END-IF
      *    負担者番号・受給者番号チェック
           PERFORM 2002-FTNJANUM-KANREN-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *    適応期間範囲チェック
           IF      SPA-NAI-KTEKSTYMD(IDX-K)
                                       >=  SPA-NAI-KTEKEDYMD(IDX-K)
               MOVE    "0081"          TO  SPA-ERRCD
               MOVE    23              TO  SPA-GMN-CUR
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *
      *    年齢チェック（生年月日登録時）
           IF      SPA-NAI-BIRTHDAY    =   SPACE
               GO      TO      200-KANREN-CHK-EXT
           END-IF
           IF      HKN-HKNKOHSBTKBN    =   "3"
      *        老人保険年齢チェック
               PERFORM 2004-RJN-TAISYOAGE-CHECK-SEC
           ELSE
      *        年齢チェック（老人年齢チェック以外）
               PERFORM 2003-NENREI-CHECK-SEC
           END-IF
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *
           .
       200-KANREN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    必須入力チェック処理
      *****************************************************************
       2001-HISSU-CHK-SEC           SECTION.
      *
           IF      SPA-GMN-KOHNUM (IDX-K)  =   SPACE
               MOVE    "0073"          TO  SPA-ERRCD
               MOVE    21              TO  SPA-GMN-CUR
               GO      TO      2001-HISSU-CHK-EXT
           END-IF
      *
      *    適用開始日
           IF      SPA-GMN-KTEKSTYMD (IDX-K)   =   SPACE
               MOVE    "0062"          TO  SPA-ERRCD
               MOVE    23              TO  SPA-GMN-CUR
               GO      TO      2001-HISSU-CHK-EXT
           END-IF
           .
       2001-HISSU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険確認チェック処理
      *****************************************************************
       2002-KOHKIKAN-CHK-SEC           SECTION.
      *
           MOVE    ZERO                TO  WRK-STYEAR
           MOVE    ZERO                TO  WRK-EDYEAR
      *
           MOVE    SPACE               TO  HKNNUM-REC
           MOVE    SPA-HOSPID          TO  HKN-HOSPID
           MOVE    SPA-GMN-KOHNUM(IDX-K)
                                       TO  HKN-HKNNUM
      *
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY2"   TO  ORC-DBPATH
               PERFORM 921-HKNMST-NEXT-SEC
           ELSE
               INITIALIZE              HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM
               UNTIL   FLG-HKNNUM      =   1
               MOVE    2                   TO  FLG-CHK
               IF     (SPA-NAI-KTEKSTYMD (IDX-K)
                                            >=  HKN-TEKSTYMD )  AND
                      (SPA-NAI-KTEKEDYMD (IDX-K)
                                            <=  HKN-TEKEDYMD )
                   IF      HKN-HKNKOHSBTKBN    =   "3"
      *            老人の時、支払区分のチェック
                       MOVE    1               TO  FLG-RJN
                       IF      (HKN-PAYKBN (1:1)   =   SPA-HOSPSBT)  AND
                               (HKN-PAYKBN (2:1)   =   SPA-ROUPAYKBN)
                           MOVE    HKN-JOKEN-STYEAR    TO  WRK-STYEAR
                           MOVE    HKN-JOKEN-EDYEAR    TO  WRK-EDYEAR
                           MOVE    1                   TO  FLG-HKNNUM
                           MOVE    1                   TO  FLG-CHK
                       END-IF
                   ELSE
                       MOVE    HKN-JOKEN-STYEAR    TO  WRK-STYEAR
                       MOVE    HKN-JOKEN-EDYEAR    TO  WRK-EDYEAR
                       MOVE    1                   TO  FLG-CHK
                       MOVE    1                   TO  FLG-HKNNUM
                   END-IF
               END-IF
      *
               IF      FLG-HKNNUM          =   ZERO
                   MOVE    "HKNNUM-KEY2"   TO  ORC-DBPATH
                   PERFORM 921-HKNMST-NEXT-SEC
               END-IF
           END-PERFORM
           IF      FLG-CHK             =   ZERO
      *        マスタなし
               MOVE    "0072"          TO  SPA-ERRCD
               MOVE    21              TO  SPA-GMN-CUR
           END-IF
           IF      FLG-CHK             =   2
      *        適応期間エラー
               MOVE    "0091"          TO  SPA-ERRCD
               MOVE    23              TO  SPA-GMN-CUR
           END-IF
      *
           .
       2002-KOHKIKAN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    負担者番号・受給者番号チェック処理
      *****************************************************************
       2002-FTNJANUM-KANREN-SEC           SECTION.
      *
      *    保険番号が検索済みとする
      *
      *    負担者番号入力チェック（長期）
           IF      HKN-HKNKOHSBTKBN    =   "2"
               IF      SPA-GMN-FTNJANUM(IDX-K) NOT  =   SPACE
                   MOVE    "0082"          TO  SPA-ERRCD
                   MOVE    20              TO  SPA-GMN-CUR
                   GO      TO      2002-FTNJANUM-KANREN-EXT
               END-IF
           END-IF
      *    負担者番号モジュラス10チェック
           IF      HKN-KENSNUMCHKKBN   =   "1"
               PERFORM 4911-FTNJANUM-CHECK-SEC
               IF      SPA-ERRCD       NOT =  SPACE
                   GO      TO      2002-FTNJANUM-KANREN-EXT
               END-IF
           END-IF
      *    受給者番号入力チェック（長期）
           IF      HKN-HKNKOHSBTKBN    =   "2"
               IF     SPA-GMN-JKYSNUM (IDX-K) NOT  =   SPACE
                   MOVE    "0082"          TO  SPA-ERRCD
                   MOVE    20              TO  SPA-GMN-CUR
                   GO      TO      2002-FTNJANUM-KANREN-EXT
               END-IF
           END-IF
      *    受給者番号モジュラス10チェック
           IF      HKN-JKYSKENSNUMCHKKBN   =   "1"
               PERFORM 4912-JKYSNUM-CHECK-SEC
               IF      SPA-ERRCD       NOT =  SPACE
                   GO      TO      2002-FTNJANUM-KANREN-EXT
               END-IF
           END-IF
      *
           .
       2002-FTNJANUM-KANREN-EXT.
           EXIT.
      *
      *****************************************************************
      *    負担者番号モジュラス10チェック処理
      *****************************************************************
       4911-FTNJANUM-CHECK-SEC        SECTION.
      *
           IF      SPA-GMN-FTNJANUM (IDX-K)    =   SPACE
               GO      TO      4911-FTNJANUM-CHECK-EXT
           END-IF
      *
      *    入力された保険者番号をセットすれば、サブプロ内で
      *    検証してくれる (処理区分:2)
           INITIALIZE                       LNK-CHKDGT-AREA
           MOVE    2                   TO   LNK-I-SYORIKBN
           MOVE    SPA-GMN-FTNJANUM (IDX-K)
                                       TO   LNK-I-CODE
           CALL    "ORCSCHKDGT"    USING    LNK-CHKDGT-AREA
           IF      LNK-O-ERRCD     NOT =   ZERO
               MOVE    "0083"          TO  SPA-ERRCD
               MOVE    20              TO  SPA-GMN-CUR
           END-IF
      *
          .
       4911-FTNJANUM-CHECK-EXT.
           EXIT.
      *****************************************************************
      *    受給者番号モジュラス10チェック処理
      *****************************************************************
       4912-JKYSNUM-CHECK-SEC        SECTION.
      *
           IF     SPA-GMN-JKYSNUM (IDX-K)  =   SPACE
               GO  TO               4912-JKYSNUM-CHECK-EXT
           END-IF
      *
      *    入力された保険者番号をセットすれば、サブプロ内で
      *    検証してくれる (処理区分:2)
           INITIALIZE                      LNK-CHKDGT-AREA
           MOVE    2                   TO  LNK-I-SYORIKBN
           MOVE    SPA-GMN-JKYSNUM (IDX-K)
                                       TO  LNK-I-CODE
           CALL    "ORCSCHKDGT"    USING   LNK-CHKDGT-AREA
           IF      LNK-O-ERRCD     NOT =   ZERO
               MOVE    "0084"          TO  SPA-ERRCD
               MOVE    22              TO  SPA-GMN-CUR
               GO  TO               4912-JKYSNUM-CHECK-EXT
           END-IF
      *
          .
       4912-JKYSNUM-CHECK-EXT.
           EXIT.
      *****************************************************************
      *    年齢チェック（老人年齢チェック以外）処理
      *****************************************************************
       2003-NENREI-CHECK-SEC          SECTION.
      *    年齢チェックなし
           IF      (WRK-STYEAR         =   ZERO    )  AND
                   (WRK-EDYEAR         =   ALL "9" )
               GO      TO      2003-NENREI-CHECK-EXT
           END-IF
           IF      SPA-NAI-KTEKEDYMD (IDX-K)   =   ALL "9"
               MOVE    "0085"          TO  SPA-ERRCD
               MOVE    24              TO  SPA-GMN-CUR
               GO      TO      2003-NENREI-CHECK-EXT
           END-IF
      *
           IF      SPA-NAI-BIRTHDAY    =   SPACE
               MOVE    "0016"          TO  SPA-ERRCD
               MOVE    23              TO  SPA-GMN-CUR
               GO      TO      2003-NENREI-CHECK-EXT
           END-IF
      *    生年月日から基準日を求める
      *      １日ならば生年月日、１日以外ならば生年月日の翌月１日
           MOVE    SPA-NAI-BIRTHDAY    TO  WRK-YMDS1
           IF      SPA-NAI-BIRTHDAY (7:2)  NOT =   "01"
               PERFORM 4910-BIRTH-AFTER1MON-GET-SEC
               MOVE    WRK-BASEYMD    TO  WRK-YMDS1
           END-IF
           PERFORM   VARYING   IDX    FROM    1   BY  1
                     UNTIL   ( IDX            >   2 )
                     OR      ( SPA-ERRCD  NOT =   SPACE )
               IF    IDX                  =   1
                   MOVE    SPA-NAI-KTEKSTYMD(IDX-K) TO  WRK-YMDS2
               ELSE
                   MOVE    SPA-NAI-KTEKEDYMD(IDX-K) TO  WRK-YMDS2
               END-IF
               COMPUTE   WRK-NENREI-YY    =   WRK-YYS2
                                          -   WRK-YYS1
               IF  WRK-YMDS1 (5:4)        >   WRK-YMDS2 (5:4)
                   COMPUTE WRK-NENREI-YY  =   WRK-NENREI-YY
                                          -   1
               END-IF
      *
               IF  ( WRK-NENREI-YY        <   WRK-STYEAR )  OR
                   ( WRK-NENREI-YY        >   WRK-EDYEAR )
                   MOVE    "0086"         TO  SPA-ERRCD
                   MOVE    23              TO  SPA-GMN-CUR
               END-IF
           END-PERFORM
      *
          .
       2003-NENREI-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    老人保険年齢チェック処理
      *****************************************************************
       2004-RJN-TAISYOAGE-CHECK-SEC     SECTION.
      *
      *    生年月日から基準日を求める
      *      １日ならば生年月日、１日以外ならば生年月日の翌月１日
           MOVE    SPA-NAI-BIRTHDAY     TO  WRK-BASEYMD
           IF      SPA-NAI-BIRTHDAY (7:2)   NOT =   "01"
               PERFORM 4910-BIRTH-AFTER1MON-GET-SEC
               IF      SPA-ERRCD        NOT =   SPACE
                   GO  TO               2004-RJN-TAISYOAGE-CHECK-EXT
               END-IF
           END-IF
      *    ６５歳を迎える日
           MOVE      WRK-BASEYMD        TO  WRK-YMD65
           COMPUTE   WRK-B65YY          =   WRK-B65YY   +   65
      *    ７０歳を迎える日
           MOVE      WRK-BASEYMD        TO  WRK-YMD70
           COMPUTE   WRK-B70YY          =   WRK-B70YY   +   70
      *
           EVALUATE    TRUE
           WHEN    ( SPA-NAI-KTEKSTYMD(IDX-K)  >=  WRK-YMD70 )
               CONTINUE
      *    警告
           WHEN    ( SPA-NAI-KTEKSTYMD(IDX-K)  <   WRK-YMD70 )  AND
                   ( SPA-NAI-KTEKSTYMD(IDX-K)  >=  WRK-YMD65 )
               IF      SPA-NAI-AGE65 (IDX-K)   =   ZERO
                   MOVE    "K001"           TO  SPA-ERRCD
                   MOVE    23               TO  SPA-GMN-CUR
                   MOVE    1                TO  SPA-NAI-AGE65 (IDX-K)
               END-IF
      *    エラー
           WHEN    ( SPA-NAI-KTEKSTYMD(IDX-K)  <   WRK-YMD65 )
               MOVE    "0087"           TO  SPA-ERRCD
               MOVE    23               TO  SPA-GMN-CUR
               GO      TO               2004-RJN-TAISYOAGE-CHECK-EXT
           END-EVALUATE
      *
           .
       2004-RJN-TAISYOAGE-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費期間重複チェック処理
      *****************************************************************
       300-KANREN-KOH-CHECK-SEC    SECTION.
      *
           MOVE    ZERO                 TO  WRK-IDX-AREA
      *    今回入力分でチェックする
           PERFORM VARYING     IDX-K    FROM    1   BY  1
                   UNTIL      (IDX-K        >   3   )  OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF      SPA-GMN-KOHNUM(IDX-K)   NOT =   SPACE
                   MOVE    SPA-NAI-PTKOH-EDANUM (IDX-K)
                                               TO  WRK-IDX (IDX-K)
                   PERFORM 3001-INPUT-KOH-CHK-SEC
               END-IF
               IF      SPA-ERRCD       NOT =   SPACE
                   COMPUTE SPA-GMN-CUR     =   SPA-GMN-CUR
                                           +  ((IDX-K  -   1  )  *  6 )
               END-IF
           END-PERFORM
      *
      *    ＴＢＬでチェックする
           PERFORM VARYING     IDX-K    FROM    1   BY  1
                   UNTIL      (IDX-K        >   3   )  OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF      SPA-GMN-KOHNUM(IDX-K)   NOT =   SPACE
                   PERFORM 3002-TBL-KOH-CHK-SEC
               END-IF
               IF      SPA-ERRCD       NOT =   SPACE
                   COMPUTE SPA-GMN-CUR     =   SPA-GMN-CUR
                                           +  ((IDX-K  -   1  )  *  6 )
               END-IF
           END-PERFORM
      *
           .
       300-KANREN-KOH-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費期間重複チェック処理（今回入力分）
      *****************************************************************
       3001-INPUT-KOH-CHK-SEC    SECTION.
      *
           PERFORM VARYING     IDK2     FROM    1   BY  1
                   UNTIL      (IDK2         >   3   )  OR
                              (SPA-ERRCD   NOT =   SPACE )
               IF     (SPA-GMN-KOHNUM(IDK2)    NOT =   SPACE) AND
                      (IDX-K                   NOT =   IDK2 )
                   IF      (SPA-NAI-KTEKEDYMD (IDX-K)
                                       <   SPA-NAI-KTEKSTYMD(IDK2) ) OR
                           (SPA-NAI-KTEKSTYMD (IDX-K)
                                       >   SPA-NAI-KTEKEDYMD(IDK2) )
                       CONTINUE
                   ELSE
                       IF      SPA-GMN-KOHNUM (IDX-K)
                                           =   SPA-GMN-KOHNUM(IDK2)
                           MOVE    "0088"      TO  SPA-ERRCD
                           MOVE    23          TO  SPA-GMN-CUR
                       END-IF
                       IF      (SPA-NAI-PTKOH-SBTKBN (IDX-K) =  "3") AND
                               (SPA-NAI-PTKOH-SBTKBN (IDK2)  =  "3")
                           MOVE    "0088"      TO  SPA-ERRCD
                           MOVE    23          TO  SPA-GMN-CUR
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       3001-INPUT-KOH-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費期間重複チェック処理（ＴＢＬ分）
      *****************************************************************
       3002-TBL-KOH-CHK-SEC    SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX             >   SPA-PTKOH-MAX )  OR
                              (SPA-ERRCD   NOT =   SPACE )
               MOVE    ZERO            TO  FLG-CHK
      *        現在表示分、削除分はチェックしない
               IF     (IDX             =   WRK-IDX (1) OR
                                           WRK-IDX (2)  OR
                                           WRK-IDX (3) ) OR
                      (SPA-PTKOH-SAKJOKBN(IDX)     =   "1" )
                   CONTINUE
               ELSE
      *            範囲の重複
                   IF      (SPA-PTKOH-TEKEDYMD (IDX)
                                       <   SPA-NAI-KTEKSTYMD(IDX-K)) OR
                           (SPA-PTKOH-TEKSTYMD (IDX)
                                       >   SPA-NAI-KTEKEDYMD(IDX-K))
                       CONTINUE
                   ELSE
                       MOVE    1            TO  FLG-CHK
                   END-IF
               END-IF
      *
               IF      FLG-CHK         =   1
      *            [公費]期間重複チェック
                   IF     (SPA-GMN-KOHNUM (IDX-K)
                                       =   SPA-PTKOH-KOHNUM (IDX))  OR
                         ((SPA-NAI-PTKOH-SBTKBN (IDX-K) =   "3")  AND
                          (SPA-PTKOH-HKN-SBTKBN (IDX)   =   "3"))
                       MOVE    "0088"      TO  SPA-ERRCD
                       MOVE    23          TO  SPA-GMN-CUR
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       3002-TBL-KOH-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    誕生日の翌月取得処理
      *****************************************************************
       4910-BIRTH-AFTER1MON-GET-SEC     SECTION.
      *
           MOVE    SPACE            TO  STS-AREA-DAY
           INITIALIZE                   STS-AREA-DAY
           INITIALIZE                   LNK-DAY6-AREA
           MOVE    "61"             TO  LNK-DAY6-IRAI
           MOVE    SPA-NAI-BIRTHDAY TO  LNK-DAY6-KIJUN
           MOVE    "01"             TO  LNK-DAY6-KIJUN(7:2)
           MOVE    "2"              TO  LNK-DAY6-ZOGENPTN
           MOVE    1                TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"    USING   STS-AREA-DAY
                                        LNK-DAY6-AREA
           IF  STS-DAY-RC1          =   ZERO
               MOVE    LNK-DAY6-KEISAN  TO  WRK-BASEYMD
           ELSE
               MOVE    SPACE            TO  WRK-BASEYMD
               MOVE    "0008"           TO  SPA-ERRCD
           END-IF
      *
           .
       4910-BIRTH-AFTER1MON-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスタ次検索処理
      *****************************************************************
       921-HKNMST-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE              HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           .
       921-HKNMST-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号マスタ次検索処理
      *****************************************************************
       900-HKNJAINF-READ-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNJAINF-REC
               MOVE    ZERO            TO  FLG-HKNJAINF
           ELSE
               INITIALIZE              HKNJAINF-REC
               MOVE    1               TO  FLG-HKNJAINF
           END-IF
           .
       900-HKNJAINF-READ-EXT.
           EXIT.
      *
