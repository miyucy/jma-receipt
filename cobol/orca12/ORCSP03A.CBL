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
       PROGRAM-ID.             ORCSP03A.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 保険入力チェックサブ（Ｐ０２Ｗ１のサブ）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/06/26    MCC-多々納    新規作成
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
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-KAKUTEI         PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDT                 PIC 9(04).
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
      *    検証番号チェック
           03  WRK-MOJ-AREA.
               05  WRK-MOJ-MAX         PIC 9(02).
               05  WRK-MOJ-NXT         PIC 9(02).
      *    保険区分
           03  WRK-HKNJA-HKNNUM        PIC X(03).
      *
           03  WRK-EDANUM          PIC 9(04).
           03  WRK-DAY-AREA.
               05  WRK-DAY-YMD     PIC X(08).
               05  WRK-DAY-ZOGEN   PIC S9(02).
               05  WRK-DAY-PTN     PIC X(01).
           03  WRK-WWYMD           PIC X(10).
      *
      *    半角全角変換
       01  WRK-HENKAN-AREA.
           03  WRK-MAE-INPUT       PIC X(100).
           03  WRK-ATO-INPUT       PIC X(100).
           03  WRK-MAX             PIC 9(04).
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
           03  WRK-HONKA-TBL.
               05  WRK-HONKA-REC-G.
                   07  FILLER        PIC X(06) VALUE "1 本人".
                   07  FILLER        PIC X(06) VALUE "2 家族".
               05  WRK-HONKA-REC-R   REDEFINES   WRK-HONKA-REC-G.
                   07  WRK-HONKA-REC   PIC X(06) OCCURS  2.
      *
           03  WRK-HJO-TBL.
               05  WRK-HJO-REC-G1.
                   07  FILLER        PIC X(06) VALUE "1 職務".
                   07  FILLER        PIC X(06) VALUE "2 下船".
                   07  FILLER        PIC X(06) VALUE "3 通勤".
               05  WRK-HJO-REC-R1     REDEFINES   WRK-HJO-REC-G1.
                   07  WRK-HJO-REC1   PIC X(06) OCCURS  3.
               05  WRK-HJO-REC-G2.
                   07  FILLER        PIC X(06) VALUE "0 無し".
                   07  FILLER        PIC X(06) VALUE "1 １割".
                   07  FILLER        PIC X(06) VALUE "2 ２割".
                   07  FILLER        PIC X(06) VALUE "3 ３割".
               05  WRK-HJO-REC-R2     REDEFINES   WRK-HJO-REC-G2.
                   07  WRK-HJO-REC2   PIC X(06) OCCURS  4.
               05  WRK-HJO-REC-G3.
                   07  FILLER        PIC X(06) VALUE "1 課税".
                   07  FILLER        PIC X(06) VALUE "2 非課".
               05  WRK-HJO-REC-R3     REDEFINES   WRK-HJO-REC-G3.
                   07  WRK-HJO-REC3   PIC X(06) OCCURS  2.
      *
           03  WRK-KEI-TBL.
               05  WRK-KEI-REC-G.
                   07  FILLER        PIC X(06) VALUE "1 継続".
                   07  FILLER        PIC X(06) VALUE "2 任継".
               05  WRK-KEI-REC-R     REDEFINES   WRK-KEI-REC-G.
                   07  WRK-KEI-REC   PIC X(06) OCCURS  2.
      *
           03  WRK-KEI1            PIC X(06)   VALUE  "（継）".
           03  WRK-KEI2            PIC X(06)   VALUE  "（任）".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    保険番号マスタ
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
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
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
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
      *    基本チェック
           PERFORM 100-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      000-PROC-EXT
           END-IF
      *
      *    関連チェックを行う
           PERFORM 200-KANREN-CHK-SEC
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
      *    保険者番号
           PERFORM 100-HKNJANUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *
      *    保険の種類
           PERFORM 1001-HKNNUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *
      *    労災保険の時、以下処理なし
           IF      SPA-GMN-HKNNUM      =   "971"
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *
      *    本家
           PERFORM 1001-HONKZKKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    補助
           PERFORM 1001-HOJOKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    継続
           PERFORM 1001-CONTKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    記号・番号
           PERFORM 1001-KIGO-NUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    資格取得日
           PERFORM 1001-SKKGETYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    適用開始日
           PERFORM 1001-HTEKSTYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    適用終了日
           PERFORM 1001-HTEKEDYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    被保険者
           PERFORM 1001-HIHKNJANAME-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
      *    確認日
           PERFORM 1001-HKAKUNINYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      100-KIHON-CHK-EXT
           END-IF
           .
       100-KIHON-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    保険者番号チェック処理
      ****************************************************************
       100-HKNJANUM-CHK-SEC     SECTION.
      *
      *    未入力判定
           IF      SPA-GMN-HKNJANUM    =   SPACE
               MOVE    SPACE               TO  SPA-HKNJA-AREA
               GO      TO      100-HKNJANUM-CHK-EXT
           END-IF
      *
      *    桁数チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN-HKNJANUM    TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
      *    半角で間に空白がないこと
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-RC2     NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   2     )
               MOVE    "0041"              TO  SPA-ERRCD
               MOVE    8                   TO  SPA-GMN-CUR
               GO      TO      100-HKNJANUM-CHK-EXT
           END-IF
           IF      KANACHK-MAX         =   4  OR  6  OR  8
               CONTINUE
           ELSE
               MOVE    "0041"              TO  SPA-ERRCD
               MOVE    8                   TO  SPA-GMN-CUR
               GO      TO      100-HKNJANUM-CHK-EXT
           END-IF
      *
      *    保険者番号　検索チェック
           INITIALIZE                    HKNJAINF-REC
           MOVE    SPA-HOSPID            TO  HKNJA-HOSPID
           MOVE    SPA-GMN-HKNJANUM      TO  HKNJA-HKNJANUM
      *
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
           MOVE    SPACE               TO  WRK-HKNJA-HKNNUM
      *    保険者番号あり
           IF      FLG-HKNJAINF        =   ZERO
               MOVE    HKNJA-HKNJANAME     TO  SPA-HKNJA-HKNJANAME
               MOVE    HKNJA-ADRS          TO  SPA-HKNJA-ADRS
               MOVE    HKNJA-BANTI         TO  SPA-HKNJA-BANTI
               MOVE    HKNJA-TEL           TO  SPA-HKNJA-TEL
               MOVE    HKNJA-HKNNUM        TO  WRK-HKNJA-HKNNUM
      *        記号が空白以外の時、再編集
               IF     (HKNJA-KIGO      NOT =   SPACE )  AND
                      (SPA-GMN-KIGO        =   SPACE )
                   MOVE    HKNJA-KIGO          TO  SPA-GMN-KIGO
               END-IF
      *
           ELSE
               MOVE    SPACE               TO  SPA-HKNJA-HKNJANAME
               MOVE    SPACE               TO  SPA-HKNJA-ADRS
               MOVE    SPACE               TO  SPA-HKNJA-BANTI
               MOVE    SPACE               TO  SPA-HKNJA-TEL
               MOVE    SPACE               TO  WRK-HKNJA-HKNNUM
      *        保険者番号モジュラス10チェック
               IF      WRK-MOJ-MAX            >   4
                   PERFORM 1001-HKNNUM-CHECK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      100-HKNJANUM-CHK-EXT
                   END-IF
               END-IF
      *
      *        法より編集
               EVALUATE    WRK-MOJ-MAX
                   WHEN    4
      *                政府管掌
                       MOVE    "001"           TO  WRK-HKNJA-HKNNUM
                   WHEN    6
      *                国保
                       MOVE    "060"           TO  WRK-HKNJA-HKNNUM
                   WHEN    8
      *            その他
                       INITIALIZE                  HKNNUM-REC
                       MOVE    SPA-HOSPID          TO  HKN-HOSPID
                       MOVE    SPA-GMN-HKNJANUM(1:2)
                                                   TO  HKN-HBTNUM
                       MOVE    SPA-SYSYMD          TO  HKN-TEKSTYMD
                       MOVE    SPA-SYSYMD          TO  HKN-TEKEDYMD
                       MOVE    HKNNUM-REC          TO  MCPDATA-REC
                       MOVE    "HKNNUM-KEY4"       TO  ORC-DBPATH
                       MOVE    "DBSELECT"          TO  MCP-FUNC
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      MCP-RC              =   ZERO
                           MOVE    "HKNNUM-KEY4"       TO  ORC-DBPATH
                           PERFORM 921-HKNMST-NEXT-SEC
                       ELSE
                           INITIALIZE                  HKNNUM-REC
                           MOVE    1               TO  FLG-HKNNUM
                       END-IF
                       MOVE    "HKNNUM-KEY4"       TO  ORC-DBPATH
                       MOVE    "DBCLOSE"           TO  MCP-FUNC
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                       IF      FLG-HKNNUM          =   ZERO
                           MOVE    HKN-HKNNUM      TO
                                                   WRK-HKNJA-HKNNUM
                       END-IF
               END-EVALUATE
           END-IF
      *
           IF      WRK-HKNJA-HKNNUM    =   SPACE
               GO      TO      100-HKNJANUM-CHK-EXT
           END-IF
      *    更新の時、保険区分変更時、エラーとする
           IF     (SPA-NAI-HKNSTR      >   ZERO      ) AND
                  (SPA-PTHKN-SINKIKBN (SPA-NAI-HKNSTR)
                                       =    SPACE    )
               IF      WRK-HKNJA-HKNNUM    NOT =   SPA-MAE-HKNNUM
                   MOVE    "0042"          TO  SPA-ERRCD
                   MOVE    8               TO  SPA-GMN-CUR
               END-IF
           ELSE
               IF      WRK-HKNJA-HKNNUM    NOT =   SPA-GMN-HKNNUM
      *            労災保険は変更できない
                   IF     (WRK-HKNJA-HKNNUM    =   "971" )  OR
                          (SPA-GMN-HKNNUM      =   "971" )
                       MOVE    "0043"          TO  SPA-ERRCD
                       MOVE    61              TO  SPA-GMN-CUR
                       GO      TO      100-HKNJANUM-CHK-EXT
                   END-IF
      *            保険区分を変更する
                   MOVE    WRK-HKNJA-HKNNUM    TO  SPA-GMN-HKNNUM
               END-IF
           END-IF
           .
      *
       100-HKNJANUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号モジュラス10チェック処理
      *****************************************************************
       1001-HKNNUM-CHECK-SEC           SECTION.
      *
      *    入力された保険者番号をセットすれば、サブプロ内で
      *    検証してくれる (処理区分:2)
           INITIALIZE                      LNK-CHKDGT-AREA
           MOVE    2                   TO  LNK-I-SYORIKBN
           MOVE    SPA-GMN-HKNJANUM    TO  LNK-I-CODE
           CALL    "ORCSCHKDGT"        USING   LNK-CHKDGT-AREA
           IF      LNK-O-ERRCD     NOT =   ZERO
               MOVE    "0040"          TO  SPA-ERRCD
               MOVE    8               TO  SPA-GMN-CUR
           END-IF
      *
          .
       1001-HKNNUM-CHECK-EXT.
           EXIT.
      ****************************************************************
      *    保険の種類チェック処理
      ****************************************************************
       1001-HKNNUM-CHK-SEC     SECTION.
      *
      *    更新の時、保険区分変更時、エラーとする
           IF     (SPA-NAI-HKNSTR      >   ZERO      ) AND
                  (SPA-PTHKN-SINKIKBN (SPA-NAI-HKNSTR)
                                       =   SPACE    )
               IF      SPA-MAE-HKNNUM  NOT =   SPA-GMN-HKNNUM
      *            前の種類へ戻す
                   MOVE    SPA-MAE-HKNNUM      TO  SPA-GMN-HKNNUM
                   PERFORM VARYING     IDX     FROM    1   BY  1
                           UNTIL       IDX     >   SPA-GMN-HKNMAX
                       IF      SPA-GMN-HKNNUML(IDX)  =   SPA-GMN-HKNNUM
                            MOVE    SPA-GMN-HKNNUMLST (IDX)
                                               TO  SPA-GMN-HKNNUM-G
      *                    識別
                           MOVE    SPA-NAI-HKNSBTKBN (IDX)
                                               TO  SPA-NAI-PTHKN-SBTKBN
                           MOVE    SPA-GMN-HKNMAX      TO  IDX
                       END-IF
                   END-PERFORM
                   MOVE    "0042"              TO  SPA-ERRCD
                   MOVE    9                   TO  SPA-GMN-CUR
               END-IF
           ELSE
      *        労災保険は入力できない
               IF     (SPA-NAI-HKNSTR      =   ZERO   ) AND
                      (SPA-GMN-HKNNUM      =   "971"  )
                   MOVE    "0043"          TO  SPA-ERRCD
                   MOVE    61              TO  SPA-GMN-CUR
                   GO      TO      1001-HKNNUM-CHK-EXT
               END-IF
           END-IF
      *    労災保険の時、以下処理なし
           IF      SPA-GMN-HKNNUM      =   "971"
               GO      TO      1001-HKNNUM-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
      *    保険情報
           IF    ( SPA-GMN-HKNNUM  NOT =   SPACE     )  AND
                 ((SPA-NAI-HKNSTR      =   ZERO      ) OR
                  (SPA-PTHKN-SINKIKBN (SPA-NAI-HKNSTR)
                                       =   "1"       ) )
      *        新規の時保険情報
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >   SPA-GMN-HKNMAX
                   IF      SPA-GMN-HKNNUML (IDX)   =   SPA-GMN-HKNNUM
                       MOVE    SPA-GMN-HKNNUMLST (IDX)
                                               TO  SPA-GMN-HKNNUM-G
      *                識別
                       MOVE    SPA-NAI-HKNSBTKBN (IDX)
                                               TO  SPA-NAI-PTHKN-SBTKBN
                       MOVE    SPA-GMN-HKNMAX      TO  IDX
                       MOVE    1                   TO  FLG-CHK
                   END-IF
               END-PERFORM
               IF      FLG-CHK             =   ZERO
                   MOVE    "0044"          TO  SPA-ERRCD
                   MOVE    9               TO  SPA-GMN-CUR
                   GO      TO      1001-HKNNUM-CHK-EXT
               END-IF
           END-IF
      *
      *    本人家族区分等
           IF      SPA-MAE-HKNNUM  NOT =   SPA-GMN-HKNNUM
               PERFORM 31011-HKN-HEN-SEC
           END-IF
           .
      *
       1001-HKNNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    本人家族区分等編集処理
      *****************************************************************
       31011-HKN-HEN-SEC      SECTION.
      *
      *    本人家族
           IF      SPA-GMN-HONKZKKBN-G     =   SPACE
      *        １５歳未満の時、家族とする
               IF      SPA-NAI-NENREI-YY   <=  15
                   MOVE    WRK-HONKA-REC (2)   TO  SPA-GMN-HONKZKKBN-G
               ELSE
                   MOVE    WRK-HONKA-REC (1)   TO  SPA-GMN-HONKZKKBN-G
               END-IF
           END-IF
      *
           INITIALIZE                      SPA-GMN-HONKZKKBN-LIST
           MOVE    ZERO                TO  SPA-GMN-HONKZK-MAX
           PERFORM VARYING     IDT     FROM    1  BY  1
                   UNTIL       IDT     >   2
               MOVE    WRK-HONKA-REC (IDT)
                                       TO  SPA-GMN-HONKZKKBNL (IDT)
               MOVE    IDT             TO  SPA-GMN-HONKZK-MAX
               IF      SPA-GMN-HONKZKKBNL (IDT)(1:1)
                                           =   SPA-GMN-HONKZKKBN
                   MOVE    SPA-GMN-HONKZKKBNL (IDT)
                                           TO  SPA-GMN-HONKZKKBN-G
               END-IF
      *        自官は本人のみ
               IF      SPA-GMN-HKNNUM      =   "007"
                   MOVE    2               TO  IDT
               END-IF
           END-PERFORM
      *
      *    継続区分
           INITIALIZE                      SPA-GMN-CONTKBN-LIST
           IF    ( SPA-NAI-PTHKN-SBTKBN    =   "1"  ) AND
                 ( SPA-GMN-HKNNUM      NOT =   "060"  AND "067" )
               PERFORM VARYING IDT     FROM    1  BY  1
                       UNTIL   IDT     >   2
                   MOVE    WRK-KEI-REC (IDT)
                                           TO  SPA-GMN-CONTKBNL (IDT)
                   IF      WRK-KEI-REC (IDT)(1:1)
                                           =   SPA-GMN-CONTKBN
                       MOVE    SPA-GMN-CONTKBNL (IDT)
                                               TO  SPA-GMN-CONTKBN-G
                   END-IF
                   MOVE    IDT             TO  SPA-GMN-CONT-MAX
               END-PERFORM
           ELSE
               MOVE    ZERO                TO  SPA-GMN-CONT-MAX
           END-IF
      *
      *    負担割合
           INITIALIZE                      SPA-GMN-HOJOKBN-LIST
           EVALUATE    SPA-GMN-HKNNUM
      *        船員
               WHEN    "002"
                   PERFORM VARYING     IDT     FROM    1  BY  1
                           UNTIL       IDT     >   3
                       MOVE    WRK-HJO-REC1 (IDT)
                                           TO  SPA-GMN-HOJOKBNL (IDT)
                       MOVE    IDT         TO  SPA-GMN-HOJO-MAX
                   END-PERFORM
      *        国保
               WHEN    "060"
                   PERFORM VARYING   IDT     FROM    1  BY  1
                         UNTIL       IDT     >   4
                       MOVE    WRK-HJO-REC2 (IDT)
                                           TO  SPA-GMN-HOJOKBNL (IDT)
                       MOVE    IDT         TO  SPA-GMN-HOJO-MAX
                   END-PERFORM
                   IF      SPA-GMN-HOJOKBN     =   SPACE
                       MOVE    "3"             TO  SPA-GMN-HOJOKBN
                   END-IF
      *        その他
               WHEN    OTHER
      *            自費
                   IF      SPA-GMN-HKNNUM (1:2)    =   "98"
                       PERFORM VARYING     IDT     FROM    1  BY  1
                               UNTIL       IDT     >   2
                           MOVE    WRK-HJO-REC3 (IDT)
                                           TO  SPA-GMN-HOJOKBNL (IDT)
                           MOVE    IDT         TO  SPA-GMN-HOJO-MAX
                       END-PERFORM
                       IF      SPA-GMN-HOJOKBN     =   SPACE
                           MOVE    "1"             TO SPA-GMN-HOJOKBN
                       END-IF
                   ELSE
                       MOVE    ZERO        TO  SPA-GMN-HOJO-MAX
                   END-IF
           END-EVALUATE
      *
           PERFORM VARYING     IDT     FROM    1  BY  1
                   UNTIL       IDT     >   SPA-GMN-HOJO-MAX
               IF      SPA-GMN-HOJOKBNL (IDT)(1:1)
                                           =   SPA-GMN-HOJOKBN
                   MOVE    SPA-GMN-HOJOKBNL (IDT)
                                           TO  SPA-GMN-HOJOKBN-G
               END-IF
           END-PERFORM
      *
           .
       31011-HKN-HEN-EXT.
           EXIT.
      *
      ****************************************************************
      *    本人家族区分チェック処理
      ****************************************************************
       1001-HONKZKKBN-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-HONKZKKBN   =   SPACE
               GO      TO      1001-HONKZKKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-HONKZK-MAX
               IF      SPA-GMN-HONKZKKBN   =   SPA-GMN-HONKZKKBNL
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-HONKZKKBNL(IDX)
                                               TO  SPA-GMN-HONKZKKBN-G
                   MOVE    1                   TO  FLG-CHK
           END-PERFORM
           IF     FLG-CHK              =   ZERO
               MOVE    "0045"          TO  SPA-ERRCD
               MOVE    10              TO  SPA-GMN-CUR
           END-IF
      *
           .
       1001-HONKZKKBN-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    補助区分チェック処理
      ****************************************************************
       1001-HOJOKBN-CHK-SEC     SECTION.
      *
           IF      SPA-GMN-HOJOKBN     =   SPACE
               GO      TO      1001-HOJOKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-HOJO-MAX
               IF      SPA-GMN-HOJOKBN     =   SPA-GMN-HOJOKBNL
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-HOJOKBNL(IDX)
                                               TO  SPA-GMN-HOJOKBN-G
                   MOVE    1                   TO  FLG-CHK
               END-IF
           END-PERFORM
           IF     FLG-CHK              =   ZERO
               MOVE    "0046"          TO  SPA-ERRCD
               MOVE    11              TO  SPA-GMN-CUR
           END-IF
      *
           .
       1001-HOJOKBN-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    継続区分チェック処理
      ****************************************************************
       1001-CONTKBN-CHK-SEC     SECTION.
      *
           IF      SPA-GMN-CONTKBN     =   SPACE
               GO      TO      1001-CONTKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-CONT-MAX
               IF      SPA-GMN-CONTKBN     =   SPA-GMN-CONTKBNL
                                                         (IDX)(1:1)
                   MOVE    SPA-GMN-CONTKBNL(IDX)
                                               TO  SPA-GMN-CONTKBN-G
                   MOVE    1                   TO  FLG-CHK
           END-PERFORM
           IF     FLG-CHK              =   ZERO
               MOVE    "0047"          TO  SPA-ERRCD
               MOVE    12              TO  SPA-GMN-CUR
           END-IF
      *
           .
       1001-CONTKBN-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    記号・番号チェック処理
      ****************************************************************
       1001-KIGO-NUM-CHK-SEC     SECTION.
      *
      *    記号全角チェック
           IF      SPA-GMN-KIGO    NOT =   SPACE
               MOVE    SPA-GMN-KIGO        TO  WRK-MAE-INPUT
               PERFORM 890-HALF-ZEN-SEC
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN-KIGO
               IF      FLG-ERR             =   1
                   MOVE    "0048"              TO  SPA-ERRCD
                   MOVE    13                  TO  SPA-GMN-CUR
                   GO      TO      1001-KIGO-NUM-CHK-EXT
               END-IF
           END-IF
      *
      *    番号全角チェック
           IF      SPA-GMN-NUM     NOT =   SPACE
               MOVE    SPA-GMN-NUM         TO  WRK-MAE-INPUT
               PERFORM 890-HALF-ZEN-SEC
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN-NUM
               IF      FLG-ERR             =   1
                   MOVE    "0049"              TO  SPA-ERRCD
                   MOVE    14                  TO  SPA-GMN-CUR
                   GO      TO      1001-KIGO-NUM-CHK-EXT
               END-IF
           END-IF
      *
           .
      *
       1001-KIGO-NUM-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    資格取得日チェック処理
      ****************************************************************
       1001-SKKGETYMD-CHK-SEC     SECTION.
      *
           IF      SPA-GMN-SKKGETYMD   =   SPACE
               MOVE    SPACE               TO  SPA-NAI-SKKGETYMD
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-SKKGETYMD   TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN-SKKGETYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI-SKKGETYMD
               ELSE
                   MOVE    "0050"              TO  SPA-ERRCD
                   MOVE    15                  TO  SPA-GMN-CUR
               END-IF
           END-IF
           .
      *
       1001-SKKGETYMD-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    保険適用開始日チェック処理
      ****************************************************************
       1001-HTEKSTYMD-CHK-SEC       SECTION.
      *
           IF      SPA-GMN-HTEKSTYMD   =   SPACE
               MOVE    SPACE               TO  SPA-NAI-HTEKSTYMD
               GO      TO      1001-HTEKSTYMD-CHK-EXT
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-HTEKSTYMD   TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN-HTEKSTYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI-HTEKSTYMD
               ELSE
                   MOVE    "0051"              TO  SPA-ERRCD
                   MOVE    16                  TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
      *
       1001-HTEKSTYMD-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    保険適用終了日チェック処理
      ****************************************************************
       1001-HTEKEDYMD-CHK-SEC     SECTION.
      *
           IF     (SPA-GMN-HTEKSTYMD   =   SPACE )  AND
                  (SPA-GMN-HTEKEDYMD   =   SPACE )
               GO      TO      1001-HTEKEDYMD-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-HTEKEDYMD   =   SPACE
      *        継続の時、自動で発生する
               IF      SPA-GMN-CONTKBN     =   "1"  OR  "2"
                   PERFORM 41010-KEIKBN-TEKEDYMD-SEC
                   GO      TO      1001-HTEKEDYMD-CHK-EXT
               END-IF
           END-IF
      *
           IF     (SPA-GMN-HTEKEDYMD   =   SPACE ) OR
                  (SPA-GMN-HTEKEDYMD(1:7)  =   "9999999")
               MOVE    "9999999  "         TO  SPA-GMN-HTEKEDYMD
               MOVE    ALL "9"             TO  SPA-NAI-HTEKEDYMD
      *        継続の時、エラーとする
               IF      SPA-GMN-CONTKBN     =   "1"  OR  "2"
                   MOVE    "0053"              TO  SPA-ERRCD
                   MOVE    17                  TO  SPA-GMN-CUR
                   GO      TO      1001-HTEKEDYMD-CHK-EXT
               END-IF
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-HTEKEDYMD   TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN-HTEKEDYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI-HTEKEDYMD
               ELSE
                   MOVE    "0052"              TO  SPA-ERRCD
                   MOVE    17                  TO  SPA-GMN-CUR
                   GO      TO      1001-HTEKEDYMD-CHK-EXT
               END-IF
           END-IF
      *
      *    継続・任継入力時の終了日チェック
      *          開始より(継)..５年、(任)..２年
           IF     (SPA-GMN-CONTKBN     =   "1"  OR  "2" )  AND
                  (SPA-NAI-HTEKSTYMD   NOT =   SPACE    )
               INITIALIZE                  WRK-DAY-AREA
               MOVE    SPA-NAI-HTEKSTYMD   TO  WRK-DAY-YMD
               IF      SPA-GMN-CONTKBN     =   "1"
                   MOVE    5               TO  WRK-DAY-ZOGEN
               ELSE
                   MOVE    2               TO  WRK-DAY-ZOGEN
               END-IF
               MOVE    "3"                 TO  WRK-DAY-PTN
               PERFORM 41010-DAY-ZOGEN-GET-SEC
               IF     (WRK-SYMD        NOT =   SPACE  )  AND
                      (SPA-NAI-HTEKEDYMD   >=  WRK-SYMD)
                   MOVE    "0053"          TO  SPA-ERRCD
                   MOVE    17              TO  SPA-GMN-CUR
                   GO      TO      1001-HTEKEDYMD-CHK-EXT
               END-IF
           END-IF
           .
      *
       1001-HTEKEDYMD-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    被保険者名チェック処理
      ****************************************************************
       1001-HIHKNJANAME-CHK-SEC     SECTION.
      *
      *    新規の時、氏名または、世帯主を編集
           IF      SPA-GMN-HKNNUM      NOT =   SPACE
               IF      SPA-GMN-HIHKNJANAME    =   SPACE
                   IF      SPA-GMN-SETAINUSI   NOT =   SPACE
                       MOVE    SPA-GMN-SETAINUSI
                                             TO  SPA-GMN-HIHKNJANAME
                   ELSE
                       MOVE    SPA-GMN-NAME  TO  SPA-GMN-HIHKNJANAME
                   END-IF
               END-IF
           END-IF
      *    記号全角チェック
           IF      SPA-GMN-HIHKNJANAME    NOT =   SPACE
               MOVE    SPA-GMN-HIHKNJANAME TO  WRK-MAE-INPUT
               PERFORM 890-HALF-ZEN-SEC
               MOVE    WRK-ATO-INPUT       TO  SPA-GMN-HIHKNJANAME
               IF      FLG-ERR             =   1
                   MOVE    "0055"              TO  SPA-ERRCD
                   MOVE    18                  TO  SPA-GMN-CUR
               END-IF
           END-IF
           .
      *
       1001-HIHKNJANAME-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    保険確認日チェック処理
      ****************************************************************
       1001-HKAKUNINYMD-CHK-SEC     SECTION.
      *
           IF     (SPA-GMN-HKNNUM      =   SPACE )  AND
                  (SPA-GMN-HTEKSTYMD   =   SPACE )  AND
                  (SPA-GMN-HKAKUNINYMD =   SPACE )
               GO      TO      1001-HKAKUNINYMD-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-HKAKUNINYMD =   SPACE
               MOVE    SPA-SYSYMDWH        TO  SPA-GMN-HKAKUNINYMD
               MOVE    SPA-SYSYMD          TO  SPA-NAI-HKAKUNINYMD
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-HKAKUNINYMD TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN-HKAKUNINYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI-HKAKUNINYMD
               ELSE
                   MOVE    "0056"              TO  SPA-ERRCD
                   MOVE    19                  TO  SPA-GMN-CUR
                   GO      TO      1001-HKAKUNINYMD-CHK-EXT
               END-IF
           END-IF
      *
           IF      SPA-NAI-HKAKUNINYMD     >   SPA-SYSYMD
               MOVE    "0057"              TO  SPA-ERRCD
               MOVE    19                  TO  SPA-GMN-CUR
           END-IF
      *
           .
      *
       1001-HKAKUNINYMD-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    関連チェック処理
      ****************************************************************
       200-KANREN-CHK-SEC     SECTION.
      *    保険入力なし
           IF      (SPA-GMN-HKNJANUM   =   SPACE  )  AND
                   (SPA-GMN-HKNNUM     =   SPACE  )  AND
                   (SPA-GMN-HONKZKKBN  =   SPACE  )  AND
                   (SPA-GMN-HOJOKBN    =   SPACE  )  AND
                   (SPA-GMN-CONTKBN    =   SPACE  )  AND
                   (SPA-GMN-KIGO       =   SPACE  )  AND
                   (SPA-GMN-NUM        =   SPACE  )  AND
                   (SPA-GMN-SKKGETYMD  =   SPACE  )  AND
                   (SPA-GMN-HTEKSTYMD  =   SPACE  )  AND
                   (SPA-GMN-HTEKEDYMD  =   SPACE  )  AND
                   (SPA-GMN-HIHKNJANAME    =   SPACE  )  AND
                   (SPA-GMN-HKAKUNINYMD    =   SPACE  )
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *
      *    労災保険の時、以下処理なし
           IF      SPA-GMN-HKNNUM      =   "971"
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *    保険入力なし
           IF      (SPA-GMN-HKNNUM     NOT =   SPACE  )  AND
                   (SPA-GMN-HONKZKKBN  NOT =   SPACE  )  AND
                   (SPA-GMN-HTEKSTYMD  NOT =   SPACE  )  AND
                   (SPA-GMN-HTEKEDYMD  NOT =   SPACE  )  AND
                   (SPA-GMN-HKAKUNINYMD  NOT =   SPACE)
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
      *
      *    適応期間範囲チェック
           IF      SPA-NAI-HTEKSTYMD   >=  SPA-NAI-HTEKEDYMD
               MOVE    "0058"          TO  SPA-ERRCD
               MOVE    17              TO  SPA-GMN-CUR
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *    保険を確認
           PERFORM 2002-HNKKIKAN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *    補助区分整合性チェック
           PERFORM 2003-HOJOKBN-SEICHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *    本人家族区分整合性チェック
           PERFORM 2003-HONKAKBN-SEICHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      200-KANREN-CHK-EXT
           END-IF
      *
      *    保険期間重複チェック
           PERFORM 2004-KANREN-HKN-CHECK-SEC
           IF      SPA-ERRCD         NOT =   SPACE
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
           IF      SPA-GMN-HKNNUM      =   SPACE
               MOVE    "0059"          TO  SPA-ERRCD
               MOVE    9               TO  SPA-GMN-CUR
               GO      TO      2001-HISSU-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-HONKZKKBN    =   SPACE
               MOVE    "0045"          TO  SPA-ERRCD
               MOVE    10              TO  SPA-GMN-CUR
               GO      TO      2001-HISSU-CHK-EXT
           END-IF
      *    適用開始日
           IF      SPA-GMN-HTEKSTYMD   =   SPACE
               MOVE    "0062"          TO  SPA-ERRCD
               MOVE    16              TO  SPA-GMN-CUR
               GO      TO      2001-HISSU-CHK-EXT
           END-IF
           .
       2001-HISSU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険確認チェック処理
      *****************************************************************
       2002-HNKKIKAN-CHK-SEC           SECTION.
      *
           MOVE    SPACE               TO  HKNNUM-REC
           MOVE    SPA-HOSPID          TO  HKN-HOSPID
           MOVE    SPA-GMN-HKNNUM      TO  HKN-HKNNUM
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
               IF     (SPA-NAI-HTEKSTYMD   >=  HKN-TEKSTYMD )  AND
                      (SPA-NAI-HTEKEDYMD   <=  HKN-TEKEDYMD )
                   MOVE    1               TO  FLG-CHK
                   MOVE    1               TO  FLG-HKNNUM
               ELSE
                   MOVE    "HKNNUM-KEY2"   TO  ORC-DBPATH
                   PERFORM 921-HKNMST-NEXT-SEC
               END-IF
           END-PERFORM
           IF      FLG-CHK             =   ZERO
      *        マスタの範囲エラー
               MOVE    "0063"          TO  SPA-ERRCD
               MOVE    16              TO  SPA-GMN-CUR
           END-IF
           .
       2002-HNKKIKAN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    補助区分整合性チェック処理
      *****************************************************************
       2003-HOJOKBN-SEICHK-SEC         SECTION.
      *
           IF     (SPA-GMN-HKNNUM      =   "060" )  OR
                  (SPA-GMN-HKNNUM      =   "002" )  OR
                  (SPA-GMN-HKNNUM(1:2) =   "98"  )
               CONTINUE
           ELSE
               IF      SPA-GMN-HOJOKBN NOT =   SPACE
                   MOVE    "0061"          TO  SPA-ERRCD
                   MOVE    11              TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
      *    国保・自費の時必須
           IF      (SPA-GMN-HKNNUM         =   "060")   OR
                   (SPA-NAI-PTHKN-SBTKBN   =   "8"  )
               IF      SPA-GMN-HOJOKBN     =   SPACE
                   MOVE    "0060"          TO  SPA-ERRCD
                   MOVE    11              TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
      *
           .
       2003-HOJOKBN-SEICHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    本人家族区分整合性チェック処理
      *****************************************************************
       2003-HONKAKBN-SEICHK-SEC         SECTION.
      *
      *    本人のみ入力可能チェック
           IF     ( SPA-NAI-PTHKN-SBTKBN   =   "4" OR "8" OR "9")  OR
                  ((SPA-GMN-HKNNUM         =   "002"  )  AND
                   (SPA-GMN-HOJOKBN    NOT =   SPACE  )    )  OR
                  ( SPA-GMN-HKNNUM         =   "007"       )
               IF      SPA-GMN-HONKZKKBN   NOT =   "1"
                   MOVE    "0066"          TO  SPA-ERRCD
                   MOVE    10              TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
       2003-HOJOKBN-SEICHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険期間エラーチェック処理
      *****************************************************************
       2004-KANREN-HKN-CHECK-SEC    SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX             >   SPA-PTHKN-MAX )  OR
                              (SPA-ERRCD   NOT =   SPACE )
               MOVE    ZERO            TO  FLG-CHK
      *        現在表示分、削除分はチェックしない
               IF     (IDX             =   SPA-NAI-HKNSTR ) OR
                      (SPA-PTHKN-SAKJOKBN(IDX)     =   "1" )
                   CONTINUE
               ELSE
      *            範囲の重複
                   IF      (SPA-PTHKN-TEKEDYMD (IDX)
                                           <   SPA-NAI-HTEKSTYMD)  OR
                           (SPA-PTHKN-TEKSTYMD (IDX)
                                           >   SPA-NAI-HTEKEDYMD)
                       CONTINUE
                   ELSE
                       MOVE    1            TO  FLG-CHK
                   END-IF
               END-IF
      *        労災は対象外
               IF     (SPA-GMN-HKNNUM          =   "971" )  OR
                      (SPA-PTHKN-HKNNUM (IDX)  =   "971" )
                   MOVE    ZERO            TO  FLG-CHK
               END-IF
      *
               IF      FLG-CHK         =   1
      *            自費・治験
                   IF     (SPA-NAI-PTHKN-SBTKBN    =   "8" OR "9") OR
                          (SPA-PTHKN-HKN-SBTKBN (IDX)
                                                   =   "8" OR "9")
                       IF     (SPA-NAI-PTHKN-SBTKBN    =   "8" OR "9" )
                         AND  (SPA-GMN-HKNNUM      =   SPA-PTHKN-HKNNUM
                                                            (IDX))
                           MOVE    "0064"          TO  SPA-ERRCD
                           MOVE    16              TO  SPA-GMN-CUR
                       END-IF
                   ELSE
      *            自費・治験以外
      *                継続（同時発生あり）　重複可
                       IF     (SPA-GMN-CONTKBN         =   "1" ) OR
                              (SPA-PTHKN-CONTKBN (IDX) =   "1" )
                           CONTINUE
                       ELSE
      *                    船員
                           IF      (SPA-GMN-HKNNUM       =   "002") AND
                                   (SPA-GMN-HOJOKBN  NOT =   SPACE )
                               IF     (SPA-PTHKN-HKNNUM(IDX)
                                                         =   "002")
                                 AND  (SPA-PTHKN-HOJOKBN (IDX)
                                                   =   SPA-GMN-HOJOKBN)
                                   MOVE    "0064"      TO  SPA-ERRCD
                                   MOVE    16          TO  SPA-GMN-CUR
                               END-IF
                           ELSE
                               IF     (SPA-PTHKN-HKNNUM(IDX)
                                                       =   "002") AND
                                      (SPA-PTHKN-HOJOKBN (IDX)
                                                   NOT =   SPACE )
                                   CONTINUE
                               ELSE
                                   MOVE    "0064"      TO  SPA-ERRCD
                                   MOVE    16          TO  SPA-GMN-CUR
                               END-IF
                           END-IF
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO          2004-KANREN-HKN-CHECK-EXT
           END-IF
      *
            .
       2004-KANREN-HKN-CHECK-EXT.
           EXIT.
      *****************************************************************
      *    継続適用終了日　処理
      *****************************************************************
       41010-KEIKBN-TEKEDYMD-SEC       SECTION.
      *
           INITIALIZE                      WRK-DAY-AREA
           MOVE    SPA-NAI-HTEKSTYMD   TO  WRK-DAY-YMD
           IF      SPA-GMN-CONTKBN     =   "1"
               MOVE    5               TO  WRK-DAY-ZOGEN
           ELSE
               MOVE    2               TO  WRK-DAY-ZOGEN
           END-IF
           MOVE    "3"                 TO  WRK-DAY-PTN
           PERFORM 41010-DAY-ZOGEN-GET-SEC
           IF      WRK-SYMD            =   SPACE
               MOVE    16              TO  SPA-GMN-CUR
               GO      TO              41010-KEIKBN-TEKEDYMD-EXT
           END-IF
           INITIALIZE                  WRK-DAY-AREA
           MOVE    WRK-SYMD            TO  WRK-DAY-YMD
           MOVE    -1                  TO  WRK-DAY-ZOGEN
           MOVE    "1"                 TO  WRK-DAY-PTN
           PERFORM 41010-DAY-ZOGEN-GET-SEC
           IF      WRK-SYMD            =   SPACE
               MOVE    16              TO  SPA-GMN-CUR
               GO      TO              41010-KEIKBN-TEKEDYMD-EXT
           END-IF
           MOVE    WRK-SYMD            TO  SPA-NAI-HTEKEDYMD
           PERFORM 410112-SEIYMDHEN-SEC
           MOVE    WRK-HENYMD          TO  SPA-GMN-HTEKEDYMD
           IF      WRK-HENYMD          =   SPACE
               MOVE    "0024"          TO  SPA-ERRCD
               MOVE    16              TO  SPA-GMN-CUR
           END-IF
      *
           .
       41010-KEIKBN-TEKEDYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    半角空白を全角空白へ変換処理
      *****************************************************************
       890-HALF-ZEN-SEC         SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-MAE-INPUT       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
               MOVE    1                   TO  FLG-ERR
               MOVE    WRK-MAE-INPUT       TO  WRK-ATO-INPUT
           ELSE
               MOVE    KANACHK-OUT-INPUT   TO  WRK-ATO-INPUT
           END-IF
      *
           .
       890-HALF-ZEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦→和暦FORMAT日付編集
      *****************************************************************
       410112-SEIYMDHEN-SEC           SECTION.
      *
           MOVE    SPACE               TO  STS-AREA-DAY
           INITIALIZE                      STS-AREA-DAY
           MOVE    SPACE               TO  LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           IF      STS-DAY-RC1         =   ZERO
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMD
           ELSE
               MOVE    SPACE               TO  WRK-HENYMD
           END-IF
           .
      *
       410112-SEIYMDHEN-EXT.
           EXIT.
      *****************************************************************
      *    日付取得　処理
      *****************************************************************
       41010-DAY-ZOGEN-GET-SEC      SECTION.
      *
           MOVE    SPACE            TO  STS-AREA-DAY
           INITIALIZE                   STS-AREA-DAY
           INITIALIZE                   LNK-DAY6-AREA
           MOVE    "61"             TO  LNK-DAY6-IRAI
           MOVE    WRK-DAY-YMD      TO  LNK-DAY6-KIJUN
           MOVE    WRK-DAY-PTN      TO  LNK-DAY6-ZOGENPTN
           MOVE    WRK-DAY-ZOGEN    TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"    USING   STS-AREA-DAY
                                        LNK-DAY6-AREA
           IF  STS-DAY-RC1          =   ZERO
               MOVE    LNK-DAY6-KEISAN  TO  WRK-SYMD
           ELSE
               MOVE    SPACE            TO  WRK-SYMD
               MOVE    "0021"           TO  SPA-ERRCD
           END-IF
      *
           .
       41010-DAY-ZOGEN-GET-EXT.
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
               MOVE    ZERO                TO  FLG-HKNNUM
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1                   TO  FLG-HKNNUM
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
               MOVE    ZERO                TO  FLG-HKNJAINF
           ELSE
               INITIALIZE               HKNJAINF-REC
               MOVE    1               TO  FLG-HKNJAINF
           END-IF
           .
       900-HKNJAINF-READ-EXT.
           EXIT.
      *
