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
       PROGRAM-ID.                 ORCSC80200204.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為入力
      *  コンポーネント名  : 診療行為チェック、算定（その他）
      *                      Ｈ１４．４改正対応
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-多々納   02/04/16  労災用追加
      * 01.00.02     NACL-多々納  02/10/03  労災加算なしの追加
      * 01.00.03     NACL-多々納  02/11/20  自賠責器材追加
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
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-CHKMST          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-ERR             PIC 9(01).
           03  FLG-CHK             PIC 9(01).
           03  FLG-SP              PIC 9(01).
           03  FLG-ARI             PIC 9(01).
           03  FLG-ARIOK           PIC 9(01).
           03  FLG-NAIYAK          PIC 9(01).
           03  FLG-TONPUK          PIC 9(01).
           03  FLG-GAIYAK          PIC 9(01).
           03  FLG-MADOKU          PIC 9(01).
           03  FLG-ZAI             PIC 9(01).
           03  FLG-NAIYAK2         PIC 9(01).
           03  FLG-TONPUK2         PIC 9(01).
           03  FLG-GAIYAK2         PIC 9(01).
      *
           03  FLG-YAKJYO          PIC 9(01).
           03  FLG-ADD             PIC 9(01).
      *    施設基準不適合
           03  FLG-KIJUNN          PIC 9(01).
      *    早期リハビリあり
           03  FLG-SOUKI           PIC 9(01).
           03  FLG-SOUKI-ALL       PIC 9(01).
      *    手技料計算フラグ
           03  FLG-SYUGI           PIC 9(01).
      *    労災用
           03  FLG-RIHA            PIC 9(01).
      *    労災加算あり
           03  FLG-ROU-ARI         PIC 9(01).
           03  FLG-ROUSAI          PIC 9(01).
      *
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDXS                PIC 9(04).
           03  IDX-Z               PIC 9(04).
           03  IDX-S               PIC 9(04).
           03  IDX-C               PIC 9(04).
           03  IDX-K               PIC 9(04).
           03  IDX-SA              PIC 9(04).
           03  IDX-MAX             PIC 9(04).
      *
           03  IDX-SYU             PIC 9(04).
           03  HZN-IDX             PIC 9(04).
      *
           03  IDX-Y               PIC 9(04).
           03  IDX-T               PIC 9(04).
           03  IDX-R               PIC 9(04).
           03  IDX-R1              PIC 9(04).
           03  IDX-R2              PIC 9(04).
           03  IDX-R3              PIC 9(04).
           03  IDX-RG              PIC 9(04).
           03  IDX-RR              PIC 9(04).
      *
           03  IDX-Z2              PIC 9(04).
           03  IDX-RSI             PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SRYCD           PIC X(09).
           03  WRK-SRYCD2          PIC X(09).
      *    減額診療コード（労災）
           03  WRK-GEN-SRYCD       PIC X(09).
      *
           03  WRK-MOJI            PIC X(01). 
      *
           03  WRK-ERRCD           PIC X(04). 
      *
           03  WRK-SYOKEIS         PIC 9(08)V99.
           03  WRK-SYOKEIS2        PIC 9(08)V99.
           03  WRK-SYOKEI          PIC 9(08).
      *
           03  WRK-ZAIKEI          PIC 9(08)V99.
           03  WRK-GAIKEI          PIC 9(08)V99.
           03  WRK-GAITEN          PIC 9(08).
           03  WRK-KIZKEI          PIC 9(08).
           03  WRK-KIZTEN          PIC 9(08).
           03  WRK-FIRTEN          PIC 9(08).
           03  WRK-MAISU           PIC 9(08).
           03  WRK-KEIMAI          PIC 9(08).
           03  WRK-KAISU           PIC 9(04).
           03  WRK-DAYCNT          PIC 9(03).
           03  WRK-TUKI-CNT        PIC 9(03).
      *
           03  WRK-TENSUKEI        PIC 9(08)V99.
           03  WRK-TENSUKEI-9      PIC S9(08).
           03  WRK-TENSUKEI-G      PIC S9(08).
           03  WRK-TENSUKEI-K      PIC S9(08).
           03  WRK-TENSUKEI-RSI    PIC S9(08).
           03  WRK-TENGAKEI-G      PIC S9(10).
           03  WRK-TENGAKEI-K      PIC S9(10).
      *
           03  WRK-GOK-TENSUKEI        PIC S9(10).
           03  WRK-GOK-TENGAKEI        PIC S9(10).
      *
           03  WRK-IDX             PIC 9(04).
      *
           03  WRK-RIGAKU-KBN      PIC X(01).
           03  WRK-RIGAKU-KBN2     PIC X(01).
           03  WRK-RIGAKU-RYO      PIC X(01).
           03  WRK-RIGAKU-RYO1     PIC X(01).
           03  WRK-RIGAKU-RYO2     PIC X(01).
           03  WRK-RIGAKU-RYO3     PIC X(01).
           03  WRK-RIGAKU-RYOS     PIC X(01).
           03  WRK-RIGAK-CNT       PIC 9(03).
           03  WRK-RIGAK-CNT1      PIC 9(03).
           03  WRK-RIGAK-CNT2      PIC 9(03).
           03  WRK-RIGAK-CNT3      PIC 9(03).
           03  WRK-RIGAK-CNTALL    PIC 9(03).
      *
           03  WRK-RIGAKU-SYORI    PIC X(01).
      *
           03  WRK-RIGAKU-CNT-AREA.
               05  WRK-R-DCNT-S        PIC 9(03).
               05  WRK-R-DCNT-K        PIC 9(03).
               05  WRK-R-TCNT-S        PIC 9(03).
               05  WRK-R-TCNT-K        PIC 9(03).
      *
               05  WRK-S-DCNT-S        PIC 9(03).
               05  WRK-S-DCNT-K        PIC 9(03).
               05  WRK-S-TCNT-S        PIC 9(03).
               05  WRK-S-TCNT-K        PIC 9(03).
      *
               05  WRK-G-DCNT-S        PIC 9(03).
               05  WRK-G-DCNT-K        PIC 9(03).
               05  WRK-G-TCNT-S        PIC 9(03).
               05  WRK-G-TCNT-K        PIC 9(03).
      *
           03  WRK-RIGAK-CNTS      PIC 9(03).
           03  WRK-RIGAK-CNTG      PIC 9(03).
      *
           03  WRK-RIG-CNT         PIC 9(03).
      *    理学最大単位
           03  WRK-RIGAK-MAX       PIC 9(03).
      *
           03   WRK-SYOYMD.
                05   WRK-SYO-YY    PIC 9(04).
                05   WRK-SYO-MM    PIC 9(02).
                05   WRK-SYO-DD    PIC 9(02).
      *
      *    自賠責金額用
           03  WRK-KINGAK          PIC 9(08).
           03  FLG-JIHI            PIC 9(01).
      *
      *    保存用
       01  HOZ-SCR-REC.
           COPY    "CPK02SPASCR.INC"  REPLACING
                                       //SPA-// BY //HOZ-//.
      *
      *    保険別算定履歴テーブル
           COPY   "CMSANTEITBL.INC".
      *
       01  FLG-RIGAKU              PIC 9(01).
      *
      *    労災用、早期リハビリテーション加算テーブル
       01  TBL-RIHABIRI-AREA.
           03  FILLER              PIC X(09)   VALUE   "180022970".
           03  FILLER              PIC X(09)   VALUE   "180023070".
           03  FILLER              PIC X(09)   VALUE   "180023100".
           03  FILLER              PIC X(09)   VALUE   "180023270".
           03  FILLER              PIC X(09)   VALUE   "180023370".
           03  FILLER              PIC X(09)   VALUE   "180023470".
           03  FILLER              PIC X(09)   VALUE   "180023570".
      *
           03  FILLER              PIC X(09)   VALUE   "180024070".
           03  FILLER              PIC X(09)   VALUE   "180024170".
           03  FILLER              PIC X(09)   VALUE   "180024270".
           03  FILLER              PIC X(09)   VALUE   "180024370".
           03  FILLER              PIC X(09)   VALUE   "180024470".
           03  FILLER              PIC X(09)   VALUE   "180024570".
           03  FILLER              PIC X(09)   VALUE   "180024670".
      *
           03  FILLER              PIC X(09)   VALUE   "180707670".
           03  FILLER              PIC X(09)   VALUE   "180707770".
           03  FILLER              PIC X(09)   VALUE   "180707870".
           03  FILLER              PIC X(09)   VALUE   "180707970".
           03  FILLER              PIC X(09)   VALUE   "180708570".
           03  FILLER              PIC X(09)   VALUE   "180708670".
           03  FILLER              PIC X(09)   VALUE   "180708770".
           03  FILLER              PIC X(09)   VALUE   "180708870".
      *    労災
           03  FILLER              PIC X(09)   VALUE   "101800040".
           03  FILLER              PIC X(09)   VALUE   "101800050".
           03  FILLER              PIC X(09)   VALUE   "101800060".
           03  FILLER              PIC X(09)   VALUE   "101800070".
      *
       01  TBL-RIHABIRI-AREA-R       REDEFINES   TBL-RIHABIRI-AREA.
           03  TBL-RIHABIRI-OCC      OCCURS   26  INDEXED   TBL-RIDX.
               05  TBL-RIHA-SRYCD      PIC X(09).
      *
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ（施設基準）
           COPY    "CPSK1006.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    チェックマスタ−
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *
      *    診療行為算定編集パラメタ
           COPY    "CPORCSC90.INC".
      *
      *    診療行為算定歴チェックパラメタ
           COPY    "CPORCSC91.INC".
      *
      *    診療行為点数編集・基本チェック
           COPY    "CPORCSC92.INC".
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
           COPY    "MCPAREA".
      *
      *    診療行為算定用共通パラメタ
           COPY    "CPORCSC00.INC".
      *
       01  WRK-SCR-REC.
           COPY    "CPK02SPASCR.INC"  REPLACING
                                       //SPA-// BY //WRK-//.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           ORCSC00AREA
           WRK-SCR-REC
           SPA-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
      *
           EVALUATE    LNK-ORCSC-KBN
      *        剤別　チェック、編集、自動算定
               WHEN    "1"
                   PERFORM 100-SEL-SYORI-SEC
      *        全体のチェック
               WHEN    "2"
                   PERFORM 200-ALL-SYORI-SEC
      *        自動算定
               WHEN    "3"
                   PERFORM 300-AUTO-SYORI-SEC
               WHEN    OTHER
                   MOVE    "1001"          TO  SPA-ERRCD
           END-EVALUATE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    剤別のチェック、編集、自動算定処理
      *****************************************************************
       100-SEL-SYORI-SEC                SECTION.
      *
      *    チェック、自動算定
           PERFORM 1001-NAI-CHK-SEC
           IF     (WRK-GMN-INPUTCD(IDX-MAX)(1:1)
                                       =   "."   )  OR
                  (SPA-ERRCD       NOT =   SPACE )
               GO      TO      100-SEL-SYORI-EXT
           END-IF
      *
      *    点数計算
           PERFORM 1002-TENSU-KEI-SEC
      *
           .
       100-SEL-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細別内容チェック、自動算定編集処理
      *****************************************************************
       1001-NAI-CHK-SEC                  SECTION.
      *
      *    剤内に早期リハビリ存在チェック
           PERFORM 10010-SOUKI-CHK-SEC
      *
           MOVE    ZERO                TO  IDX-MAX
           MOVE    ZERO                TO  IDX-SYU
           INITIALIZE                  WRK-AREA
      *
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   200     )   OR
                              (WRK-GMN-INPUTCD (IDX-Z) =   SPACE )
      *
               ADD     1                   TO  IDX-MAX
      *
               IF      WRK-GMN-INPUTCD(IDX-Z)(1:1)     =   "." OR "S"
                                                               OR "*"
                   MOVE    WRK-GMN-INPUTCD(IDX-Z)(1:1) TO  WRK-MOJI
               ELSE
                   MOVE    WRK-COM-INPUTCD(IDX-Z)(1:1) TO  WRK-MOJI
                   IF      WRK-COM-INPUTCD(IDX-Z)(1:3) =   "059"
                       MOVE    "7"                     TO  WRK-MOJI
                   END-IF
               END-IF
      *        労災加算振替え
               IF      WRK-COM-INPUTCD(IDX-Z)  =   "099509901"
                   MOVE    "1"                 TO  WRK-MOJI
               END-IF
      *
               EVALUATE    WRK-MOJI
                   WHEN    "0"
                   WHEN    "8"
                   WHEN    "."
                   WHEN    "S"
                   WHEN    "*"
                       CONTINUE
      *
                   WHEN    OTHER
      *                編集チェックへ
                       PERFORM 10011-CHK-SEC
               END-EVALUATE
           END-PERFORM
      *
           MOVE    WRK-ERRCD          TO  SPA-ERRCD
      *
           .
       1001-NAI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    剤内早期リハビリ存在チェック処理
      *****************************************************************
       10010-SOUKI-CHK-SEC                  SECTION.
      *
           MOVE    ZERO                TO  FLG-SOUKI-ALL
      *
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   200     )   OR
                              (FLG-SOUKI-ALL           =   1   )  OR
                              (WRK-GMN-INPUTCD (IDX-Z) =   SPACE )
               MOVE    WRK-COM-INPUTCD (IDX-Z) TO  WRK-SRYCD
               PERFORM 20011-SOUKI-CHK-SEC
               IF      FLG-SOUKI           =   1
                   MOVE    1               TO  FLG-SOUKI-ALL
               END-IF
           END-PERFORM
      *
           .
       10010-SOUKI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細別内容チェック、自動算定編集処理
      *****************************************************************
       10011-CHK-SEC                  SECTION.
      *
      *    各チェック処理
           EVALUATE    WRK-MOJI
               WHEN    "1"
      *            乳幼児の自動加算を追加する
                   PERFORM 10011-NENREI-SET-SEC
      *            施設基準不適合チェック
                   IF      WRK-COM-KIJUNTEIGENKBN(IDX-Z)
                                               NOT =   ZERO
                       PERFORM 100111-KIJUNN-CHK-SEC
                   END-IF
      *            労災の時、労災加算の算定
                   IF      SPA-HKNKBN          =   1
                       PERFORM 100113-RSIHKN-SYORI-SEC
                   ELSE
                       IF      WRK-COM-DATAKBN (IDX-Z) =   "1"
      *                    理学療法の逓減チェック
                           MOVE    SPACE               TO  WRK-GEN-SRYCD
                           IF      LNK-ORCSC-PG        =   "K02"
                               PERFORM 100112-RIGAKU-CHK-SEC
                           END-IF
                       END-IF
                   END-IF
      *
      *            精神通院の逓減チェック
                   IF      LNK-ORCSC-PG        =   "K02"
                       PERFORM 100113-SEISIN-CHK-SEC
                   END-IF
      *
      *            加算チェック
                   IF      WRK-COM-DATAKBN (IDX-Z) =   "2"
                       PERFORM 1005-KASAN-CHK-SEC
                   END-IF
      *        器材
               WHEN    "7"
                   IF      WRK-COM-DATAKBN (IDX-Z) =   "3"
      *                フィルムの時エラー
                       MOVE    "0047"          TO  WRK-ERRCD
                       MOVE    "1"             TO  WRK-COM-CUR (IDX-Z)
                   END-IF
           END-EVALUATE
      *
           .
       10011-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    加算料チェック処理
      *****************************************************************
       1005-KASAN-CHK-SEC                  SECTION.
      *
      *    加算データの時、前に手技料があること
           MOVE    ZERO                TO  FLG-ARI
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL       IDX1    >=  IDX-Z
               IF     (WRK-COM-INPUTCD(IDX1)(1:1)  =   "1" )  AND
                      (WRK-COM-DATAKBN(IDX1)   NOT =   "2" )
                   MOVE    1               TO  FLG-ARI
                   MOVE    IDX-Z           TO  IDX1
               END-IF
           END-PERFORM
      *
           IF      FLG-ARI             =   ZERO
               MOVE    "0013"          TO  WRK-ERRCD
               MOVE    "1"             TO  WRK-COM-CUR (IDX-Z)
           END-IF
      *
           .
       1005-KASAN-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    施設基準不適合チェック加算処理
      *****************************************************************
       100111-KIJUNN-CHK-SEC           SECTION.
      *
      *    手技の時、適合チェック
           IF      WRK-COM-KIJUNTEIGENKBN (IDX-Z)  =   2  OR  3
               PERFORM 1001111-SSTKIJUN-CHK-SEC
      *        施設基準適応
               IF      FLG-ERR             =   ZERO
                   MOVE    1               TO  FLG-KIJUNN
                   GO      TO      100111-KIJUNN-CHK-EXT
               END-IF
      *        施設基準不適応
               IF     (WRK-COM-KIJUNTEIGENKBN (IDX-Z)  =   2 )  OR
                     ((WRK-COM-KIJUNTEIGENKBN (IDX-Z)  =   3   ) AND
                      (LNK-ORCSC-NENREI-YY             =   ZERO))
                   MOVE    2                   TO  FLG-KIJUNN
      *            施設基準不適合（放射線）（他の加算はないこととする）
                   MOVE    IDX-Z               TO  IDX-S
                   MOVE    "180025270"         TO  WRK-SRYCD
                   IF      WRK-COM-INPUTCD (IDX-Z + 1) =   WRK-SRYCD
                       CONTINUE
                   ELSE
                       MOVE    IDX-Z           TO  IDX-S
                       MOVE    ZERO            TO  FLG-ARI
                       PERFORM 1002-KASAN-SET-SEC
                  END-IF
              END-IF
           END-IF
      *
      *    加算の時、対象の手技が有ること
           IF      WRK-COM-KIJUNTEIGENKBN (IDX-Z)  =   1
               IF      FLG-KIJUNN          =   ZERO
                   MOVE    "0073"          TO  WRK-ERRCD
                   MOVE    "1"             TO  WRK-COM-CUR (IDX-Z)
               END-IF
           END-IF
           .
       100111-KIJUNN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    施設基準不適応チェック処理
      *****************************************************************
       1001111-SSTKIJUN-CHK-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-ERR
      *    施設基準情報検索
           MOVE    SPACE               TO  SYS-1006-REC
           MOVE    "1006"              TO  SYS-1006-KANRICD
           MOVE    "1"                 TO  SYS-1006-KBNCD
           MOVE    ZERO                TO  SYS-1006-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1006-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1006-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1006-REC
           ELSE
               INITIALIZE                  SYS-1006-REC
           END-IF
      *
      *    基準不適合逓減対象施設基準
           MOVE    WRK-COM-KIJUNTEIGENCD (IDX-Z)
                                       TO  IDY
           IF      SYS-1006-SSTKIJUN (IDY) =   1
               CONTINUE
           ELSE
               MOVE    1               TO  FLG-ERR
           END-IF
      *
           .
       1001111-SSTKIJUN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    理学療法の逓減チェック処理
      *****************************************************************
       100112-RIGAKU-CHK-SEC            SECTION.
      *
           SET     TBL-SAN             TO  1
           SEARCH      TBL-SANTEI-OCC  VARYING   TBL-SAN
                   AT  END
                       MOVE    ZERO            TO  FLG-RIGAKU
                       MOVE    SPACE           TO  WRK-RIGAKU-KBN
                       MOVE    SPACE           TO  WRK-RIGAKU-RYO
                   WHEN    WRK-COM-INPUTCD (IDX-Z)
                                               =   TBL-SANTEI-SRYCD
                                                           (TBL-SAN)
                       MOVE    TBL-RIGAKU-KBN   (TBL-SAN)
                                               TO  WRK-RIGAKU-KBN
                       MOVE    TBL-RIGAKU-RYO   (TBL-SAN)
                                               TO  WRK-RIGAKU-RYO
                       MOVE    1               TO  FLG-RIGAKU
           END-SEARCH
           IF      FLG-RIGAKU          =   ZERO
               GO      TO      100112-RIGAKU-CHK-EXT
           END-IF
      *
      *    当日算定済みのすべてのリハビリカウント
           PERFORM 2001-RIGAKU-CNT-CHK-SEC
      *
           MOVE    WRK-COM-INPUTCD (IDX-Z) TO  WRK-SRYCD
      *
           MOVE    SPACE               TO  WRK-RIGAKU-RYO2
      *
      *    同一理学チェック（１日単位チェック）
           MOVE    ZERO                TO  IDX-RG
           MOVE    ZERO                TO  WRK-RIG-CNT
           MOVE    ZERO                TO  WRK-TUKI-CNT
           MOVE    ZERO                TO  WRK-DAYCNT
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   6
               IF      LNK-ORCSC-RIGAKU-SRYCD(IDX) =   WRK-SRYCD
                   MOVE     LNK-ORCSC-RIGAKU-CNT (IDX)
                                               TO  WRK-RIG-CNT
                   MOVE     IDX                TO  IDX-RG
                   MOVE     6                  TO  IDX
               ELSE
                   IF      LNK-ORCSC-RIGAKU-SRYCD(IDX)  =  SPACE
                       MOVE    IDX             TO  IDX-RG
                       MOVE    WRK-SRYCD       TO
                                         LNK-ORCSC-RIGAKU-SRYCD(IDX-RG)
                       MOVE     6                  TO  IDX
                   ELSE
                       MOVE    LNK-ORCSC-RIGAKU-SRYCD(IDX)
                                                   TO  WRK-SRYCD2
                       PERFORM 10011312-RIGAKU-SERCH-SEC
      *                療法が同じ時、単位を集計する
                       IF      (WRK-RIGAKU-RYO     =   WRK-RIGAKU-RYO2)
                          AND  (WRK-RIGAKU-KBN     =   WRK-RIGAKU-KBN2)
                           MOVE    LNK-ORCSC-RIGAKU-CNT (IDX)
                                                   TO  WRK-RIG-CNT
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
      *    当日・当月分
           EVALUATE    WRK-RIGAKU-RYO  ALSO  WRK-RIGAKU-KBN
      *        個別の理学
               WHEN    "K"             ALSO  "R"
                   ADD     WRK-R-TCNT-K      TO  WRK-TUKI-CNT
                   ADD     WRK-R-DCNT-K      TO  WRK-DAYCNT
      *        集団の理学
               WHEN    "S"             ALSO  "R"
                   ADD     WRK-R-TCNT-S      TO  WRK-TUKI-CNT
                   ADD     WRK-R-DCNT-S      TO  WRK-DAYCNT
      *        個別の作業
               WHEN    "K"             ALSO  "S"
                   ADD     WRK-S-TCNT-K      TO  WRK-TUKI-CNT
                   ADD     WRK-S-DCNT-K      TO  WRK-DAYCNT
      *        集団の作業
               WHEN    "S"             ALSO  "S"
                   ADD     WRK-S-TCNT-S      TO  WRK-TUKI-CNT
                   ADD     WRK-S-DCNT-S      TO  WRK-DAYCNT
      *        個別の言語
               WHEN    "K"             ALSO  "G"
                   ADD     WRK-G-TCNT-K      TO  WRK-TUKI-CNT
                   ADD     WRK-G-DCNT-K      TO  WRK-DAYCNT
      *        集団の言語
               WHEN    "S"             ALSO  "G"
                   ADD     WRK-G-TCNT-S      TO  WRK-TUKI-CNT
                   ADD     WRK-G-DCNT-S      TO  WRK-DAYCNT
           END-EVALUATE
      *
      *    個別・集団療法チェック
           IF      WRK-RIGAKU-RYO2 NOT =   SPACE
               IF      WRK-RIGAKU-RYO      =   WRK-RIGAKU-RYO2
                   CONTINUE
               ELSE
                   MOVE    "0093"          TO  WRK-ERRCD
                   MOVE    "1"             TO  WRK-COM-CUR (IDX-Z)
                   GO      TO      100112-RIGAKU-CHK-EXT
               END-IF
           END-IF
      *
      *    算定履歴チェック処理
           INITIALIZE                  ORCSC91AREA
           MOVE    LNK-ORCSC-SYORIFLG  TO  LNK-SC91-SYORIFLG
           MOVE    WRK-SRYCD           TO  LNK-SC91-SRYCD
           MOVE    "3"                 TO  LNK-SC91-KBN
           MOVE    IDX-Z               TO  LNK-SC91-GMN-IDX
           MOVE    LNK-ORCSC-KAISU     TO  LNK-SC91-KAISU
           MOVE    LNK-ORCSC-TEISEI-AREA   TO  LNK-SC91-TEISEI-AREA
           MOVE    1                   TO  LNK-SC91-CHKFLG
           CALL    "ORCSC91"           USING    MCPAREA
                                                ORCSC91AREA
                                                WRK-SCR-REC
                                                SPA-AREA
                                                TNS-TENSU-REC
      *    上限日チェック
           COMPUTE WRK-DAYCNT          =   LNK-ORCSC-KAISU
                                       +   WRK-DAYCNT
                                       +   WRK-RIG-CNT
           IF     WRK-DAYCNT           >   LNK-SC91-DAYMAXCNT
               MOVE    "0091"          TO  WRK-ERRCD
               MOVE    "1"             TO  WRK-COM-CUR (IDX-Z)
               GO      TO      100112-RIGAKU-CHK-EXT
           END-IF
      *
      *    労災の時、理学療法の逓減は傷病発生３月以降とする
           IF     (SPA-HKNKBN          =   1        )  AND
                  (SPA-SRYYMD          <   SPA-RSI-SHOBYOYMD3)
      *        理学療法の同一日の上限回数
               ADD      LNK-ORCSC-KAISU    TO  LNK-ORCSC-RIGAKU-CNT
                                                             (IDX-RG)
               GO      TO      100112-RIGAKU-CHK-EXT
           END-IF
      *
      *    当月単位集計
           COMPUTE WRK-TUKI-CNT        =   WRK-TUKI-CNT
                                       +   WRK-RIG-CNT
           IF      WRK-RIGAKU-RYO      =   "K"
      *      厚生労働大臣が定める患者以外の時、逓減を行う
             IF     FLG-SOUKI-ALL        =   ZERO
      *        個別逓減チェック
               IF     WRK-TUKI-CNT         >=  10
      *            逓減あり
                   PERFORM 11122-RIGAKU-TEIGEN-SEC
               ELSE
                   IF     (WRK-TUKI-CNT    +   LNK-ORCSC-KAISU)
                                            >   10
                       MOVE    "0081"          TO  WRK-ERRCD
                       MOVE    "1"             TO  WRK-COM-CUR (IDX-Z)
                       GO      TO      100112-RIGAKU-CHK-EXT
                   END-IF
               END-IF
             END-IF
           ELSE
      *        集団療法は、月８単位
               IF     (WRK-TUKI-CNT    +   LNK-ORCSC-KAISU)
                                           >   8
                   MOVE    "0084"          TO  WRK-ERRCD
                   MOVE    "1"             TO  WRK-COM-CUR (IDX-Z)
                   GO      TO      100112-RIGAKU-CHK-EXT
               END-IF
           END-IF
      *    理学療法の同一日の上限回数
           ADD      LNK-ORCSC-KAISU    TO  LNK-ORCSC-RIGAKU-CNT
                                                             (IDX-RG)
      *
           .
       100112-RIGAKU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    個別療法逓減処理（共通）
      *****************************************************************
       11122-RIGAKU-TEIGEN-SEC            SECTION.
      *
           MOVE    IDX-Z               TO  IDX-S
           IF      WRK-GEN-SRYCD       =   SPACE
               IF      LNK-ORCSC-ROUJIN    =   ZERO
                   MOVE    "180025370"         TO  WRK-SRYCD
               ELSE
                   MOVE    "180709070"         TO  WRK-SRYCD
               END-IF
           ELSE
               MOVE    WRK-GEN-SRYCD           TO  WRK-SRYCD
           END-IF
           IF      WRK-COM-INPUTCD (IDX-Z + 1) =   WRK-SRYCD
               CONTINUE
           ELSE
               MOVE    IDX-Z           TO  IDX-S
               MOVE    ZERO            TO  FLG-ARI
               PERFORM 1002-KASAN-SET-SEC
           END-IF
      *
           .
       11122-RIGAKU-TEIGEN-EXT.
           EXIT.
      *
      *****************************************************************
      *     精神通院の逓減チェック処理
      *****************************************************************
       100113-SEISIN-CHK-SEC            SECTION.
      *
           IF      WRK-COM-INPUTCD (IDX-Z) =   "180012210"  OR
                                               "180012310"  OR
                                               "180020570"
               CONTINUE
           ELSE
               GO     TO      100113-SEISIN-CHK-EXT
           END-IF
      *
      *    初診算定日から６月以内
           IF      LNK-ORCSC-SYOYMD    =   SPACE
               MOVE    SPA-SRYYMD          TO  LNK-ORCSC-SYOYMD
           END-IF
           MOVE    LNK-ORCSC-SYOYMD    TO  WRK-SYOYMD
           COMPUTE WRK-SYO-MM          =   WRK-SYO-MM    +   6
           IF      WRK-SYO-MM          >   12
               COMPUTE WRK-SYO-YY      =   WRK-SYO-YY    +   1
               COMPUTE WRK-SYO-MM      =   WRK-SYO-MM    -   12
           END-IF
      *
           EVALUATE    WRK-COM-INPUTCD(IDX-Z)
               WHEN    "180012210"
               WHEN    "180012310"
                   IF      SPA-SRYYMD          <   WRK-SYOYMD
      *            逓減あり
                       MOVE    IDX-Z               TO  IDX-S
                       MOVE    "180020570"         TO  WRK-SRYCD
                       IF      WRK-COM-INPUTCD (IDX-Z + 1) =   WRK-SRYCD
                           CONTINUE
                       ELSE
                           MOVE    IDX-Z           TO  IDX-S
                           MOVE    ZERO            TO  FLG-ARI
                           PERFORM 1002-KASAN-SET-SEC
                       END-IF
                   END-IF
               WHEN    "180020570"
      *            逓減チェック
                   IF      WRK-COM-INPUTCD (IDX-Z - 1)
                                               =   "180012210"  OR
                                                   "180012310"
                       IF      SPA-SRYYMD      >   WRK-SYOYMD
                           MOVE    "0082"      TO  WRK-ERRCD
                           MOVE    "1"         TO  WRK-COM-CUR
                                                           (IDX-Z)
                       END-IF
                   ELSE
                       MOVE    "0083"      TO  WRK-ERRCD
                       MOVE    "1"         TO  WRK-COM-CUR (IDX-Z)
                   END-IF
           END-EVALUATE
      *
           .
       100113-SEISIN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災加算の算定処理
      *****************************************************************
       100113-RSIHKN-SYORI-SEC        SECTION.
      *
           MOVE    IDX-Z               TO  HZN-IDX
      *
      *    理学療法の逓減は、傷病発生３月以降
           IF     (WRK-COM-DATAKBN (IDX-Z) =   "1"  )
      *        減額診療コード（労災）
               MOVE    "101800030"         TO  WRK-GEN-SRYCD
      *        理学療法の逓減チェック
               IF      LNK-ORCSC-PG        =   "K02"
                   PERFORM 100112-RIGAKU-CHK-SEC
                   MOVE    HZN-IDX             TO  IDX-Z
               END-IF
           END-IF
      *
      *    早期リハビリ加算は対象外
           MOVE    WRK-COM-INPUTCD (IDX-Z) TO  WRK-SRYCD
           PERFORM 20011-SOUKI-CHK-SEC
           IF      FLG-SOUKI           =   1
               GO      TO      100113-RSIHKN-SYORI-EXT
           END-IF
      *
      *    労災の時、加算なし
           IF      WRK-COM-INPUTCD(IDX-Z)(1:3) =   "101"
               GO      TO      100113-RSIHKN-SYORI-EXT
           END-IF
      *
           MOVE    SPACE                TO  WRK-SRYCD
           MOVE    ZERO                 TO  FLG-ROUSAI
      *    労災用　区分番号
           IF      WRK-COM-CDKBN-KBN (IDX-Z)  =   "H"
               EVALUATE    WRK-COM-CDKBN-KBNNUM (IDX-Z)
                   WHEN    "001"
                   WHEN    "002"
                   WHEN    "003"
                   WHEN    "004"
                   WHEN    "005"
                       EVALUATE    SPA-RSI-SISIKBN
                           WHEN    1
                           WHEN    2
      *                        １．５倍
                               MOVE    "101800010"      TO  WRK-SRYCD
                       END-EVALUATE
                       MOVE    1                    TO  FLG-ROUSAI
               END-EVALUATE
           END-IF
      *
      *    既に他の労災加算が入力されている時は自動算定しない
           MOVE    ZERO                TO  FLG-ROU-ARI
           COMPUTE IDX-Z2              =   IDX-Z     +   1
           PERFORM VARYING     IDX1    FROM    IDX-Z2    BY  1
                   UNTIL      (IDX1        >   200     )   OR
                              (FLG-ROU-ARI             =   1    ) OR
                              (WRK-GMN-INPUTCD (IDX1)  =   SPACE )
               IF       WRK-COM-INPUTCD (IDX1) =   "101800010"  OR
                                                   "099509901"
                   IF      WRK-COM-AUTOKBN (IDX1)  =   SPACE
                        MOVE    1                  TO  FLG-ROU-ARI
                   END-IF
               END-IF
               IF     (WRK-COM-INPUTCD (IDX1)(1:1) =  "1" ) AND
                      (WRK-COM-DATAKBN (IDX1)      =  "1" )
                  MOVE    200              TO  IDX1
               END-IF
           END-PERFORM
           IF      FLG-ROU-ARI         =   1
               IF      FLG-ROUSAI          =   ZERO
                   MOVE    "8004"          TO  WRK-ERRCD
                   MOVE    "1"             TO  WRK-COM-CUR (IDX1 - 1)
               END-IF
               GO      TO      100113-RSIHKN-SYORI-EXT
           END-IF
           IF      WRK-SRYCD           =   SPACE
               GO      TO      100113-RSIHKN-SYORI-EXT
           END-IF
      *
      *    加算料チェック処理（次ぎの手技料の前に）
           MOVE    ZERO                TO  FLG-ARI
           MOVE    ZERO                TO  IDX-T
           COMPUTE IDX-Z2              =   IDX-Z     +   1
           PERFORM VARYING     IDX1    FROM    IDX-Z2    BY  1
                   UNTIL      (IDX1        >   200     )   OR
                              (FLG-ARI                 =   1    ) OR
                              (WRK-GMN-INPUTCD (IDX1)  =   SPACE )
               IF       WRK-COM-INPUTCD (IDX1) =   WRK-SRYCD
                   MOVE    IDX1            TO  IDX-T
                   MOVE    1               TO  FLG-ARI
               ELSE
                   IF     (WRK-COM-INPUTCD (IDX1)(1:1) =  "1" ) AND
                          (WRK-COM-DATAKBN (IDX1)      =  "2" )
                      MOVE    IDX1             TO  IDX-T
                   END-IF
                   IF     (WRK-COM-INPUTCD (IDX1)(1:1) =  "1" ) AND
                          (WRK-COM-DATAKBN (IDX1)      =  "1" )
                      MOVE    200              TO  IDX1
                   END-IF
               END-IF
           END-PERFORM
      *
           IF      FLG-ARI             =   ZERO
               IF      IDX-T           =   ZERO
                   MOVE    IDX-Z           TO  IDX-S
               ELSE
                   MOVE    IDX-T           TO  IDX-S
               END-IF
           END-IF
      *
      *    加算料追加処理
           PERFORM 1002-KASAN-SET-SEC
           IF      FLG-ADD             =   1
               MOVE    2               TO  WRK-COM-SANFLG (IDX-S)
           END-IF
           .
       100113-RSIHKN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    理学療法テーブル検索処理
      *****************************************************************
       10011312-RIGAKU-SERCH-SEC            SECTION.
      *
      *
           SET     TBL-SAN             TO  1
           SEARCH      TBL-SANTEI-OCC  VARYING   TBL-SAN
                   AT  END
                       MOVE    SPACE           TO  WRK-RIGAKU-RYOS
                       MOVE    SPACE           TO  WRK-RIGAKU-KBN2
                   WHEN    WRK-SRYCD2          =   TBL-SANTEI-SRYCD
                                                           (TBL-SAN)
                       MOVE    TBL-RIGAKU-KBN   (TBL-SAN)
                                               TO  WRK-RIGAKU-KBN2
                       MOVE    TBL-RIGAKU-RYO   (TBL-SAN)
                                               TO  WRK-RIGAKU-RYOS
           END-SEARCH
      *
           IF      WRK-RIGAKU-KBN      =   WRK-RIGAKU-KBN2
               MOVE    WRK-RIGAKU-RYOS     TO  WRK-RIGAKU-RYO2
           END-IF
           .
       10011312-RIGAKU-SERCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    年齢加算追加処理（共通）
      *****************************************************************
       10011-NENREI-SET-SEC            SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2        >   4       )   OR
                              (WRK-COM-AGEKSNSRYCD(IDX-Z IDX2)
                                               =   SPACE  OR
                                                   ZERO )
      *        加算追加
               MOVE    WRK-COM-AGEKSNSRYCD (IDX-Z IDX2)  TO  WRK-SRYCD
      *        加算料チェック処理
               PERFORM 100111-KASAN-CHK-SEC
      *        加算料追加処理
               MOVE    IDX-Z               TO  IDX-S
               PERFORM 1002-KASAN-SET-SEC
               IF      FLG-ADD             =   1
                   MOVE    4                   TO  IDX2
               END-IF
           END-PERFORM
      *
           .
       10011-NENREI-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    自動加算　存在チェック加処理
      *****************************************************************
       100111-KASAN-CHK-SEC        SECTION.
      *
      *    時間自動加算　存在チェック
           MOVE    ZERO                TO  FLG-ARI
           MOVE    ZERO                TO  IDX-T
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL      (IDX1        >   200     )   OR
                              (FLG-ARI                 =   1    ) OR
                              (WRK-GMN-INPUTCD (IDX1)  =   SPACE )
               IF       WRK-COM-INPUTCD (IDX1) =   WRK-SRYCD
                    MOVE    IDX1           TO  IDX-T
                    MOVE    1              TO  FLG-ARI
               END-IF
           END-PERFORM
           .
       100111-KASAN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    加算料追加処理
      *****************************************************************
       1002-KASAN-SET-SEC              SECTION.
      *
           MOVE    ZERO                TO  FLG-ADD
      *
           IF      FLG-ARI             =   ZERO
               ADD     1               TO  IDX-S
           ELSE
               MOVE    IDX-T           TO  IDX-S
           END-IF
      *
      *    点数マスタ編集・基本チェック
           MOVE    WRK-SCR-REC         TO  HOZ-SCR-REC
           INITIALIZE                  ORCSC92AREA
           IF      FLG-ARI             =   ZERO
               MOVE    "1"                 TO  LNK-SC92-KBN
           ELSE
               MOVE    SPACE               TO  WRK-COM-CHKFLG (IDX-S)
           END-IF
           MOVE    LNK-ORCSC-SYORIFLG  TO  LNK-SC92-SYORIFLG
           MOVE    IDX-S               TO  LNK-SC92-GMN-IDX
           MOVE    WRK-SRYCD           TO  LNK-SC92-SRYCD
           MOVE    LNK-ORCSC-NENREI    TO  LNK-SC92-NENREI
           MOVE    LNK-ORCSC-ROUJIN    TO  LNK-SC92-ROUJIN
           MOVE    LNK-ORCSC-LSTSRYKA  TO  LNK-SC92-LSTSRYKA
           MOVE    LNK-ORCSC-LSTSRYKAMEI   TO  LNK-SC92-LSTSRYKAMEI
           MOVE    LNK-ORCSC-TEISEI-AREA TO  LNK-SC92-TEISEI-AREA
           CALL    "ORCSC92"           USING
                                       MCPAREA
                                       ORCSC92AREA
                                       WRK-SCR-REC
                                       SPA-AREA
      *
      *    エラーの時、追加なし
           IF     (SPA-ERRCD           NOT =   SPACE )  OR
                  (LNK-SC92-ERRAREA    NOT =   SPACE )
               MOVE    SPACE               TO  SPA-ERRCD
               MOVE    HOZ-SCR-REC         TO  WRK-SCR-REC
               IF      FLG-ARI             =   ZERO
                   COMPUTE IDX-S           =   IDX-S
                                           -   1
               END-IF
               GO      TO      1002-KASAN-SET-EXT
           END-IF
      *
           MOVE    WRK-COM-SRYKBN (IDX-S - 1)
                                       TO  WRK-COM-SRYKBN(IDX-S)
           MOVE    SPACE               TO  WRK-GMN-SRYKBN(IDX-S)
           MOVE    WRK-COM-SRYSYUKBN (IDX-S - 1)
                                       TO  WRK-COM-SRYSYUKBN(IDX-S)
      *
      *    自動追加分（入力時に追加）
           MOVE    "2"                 TO  WRK-COM-AUTOKBN (IDX-S)
      *
           ADD     1                   TO  WRK-GMN-MAX
      *
           MOVE    1                   TO  FLG-ADD
           ADD     1                   TO  IDX-Z
           .
       1002-KASAN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数計算編集処理
      *****************************************************************
       1002-TENSU-KEI-SEC                  SECTION.
      *
           MOVE    ZERO                TO  IDX-MAX
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  ORCSC90AREA
      *
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   200     )   OR
                              (SPA-ERRCD       NOT =   SPACE )  OR
                              (WRK-GMN-INPUTCD (IDX-Z) =   SPACE )
      *
               ADD     1                   TO  IDX-MAX
      *
               MOVE    SPACE               TO  WRK-GMN-SURYO (IDX-Z)
               MOVE    SPACE               TO  WRK-GMN-TENSU (IDX-Z)
               MOVE    SPACE               TO  WRK-GMN-KAISU (IDX-Z)
               MOVE    ZERO                TO  WRK-GMN-KEI   (IDX-Z)
      *
      *
               IF      WRK-GMN-INPUTCD(IDX-Z)(1:1)     =   "."  OR  "S"
                                                               OR "*"
                   MOVE    WRK-GMN-INPUTCD(IDX-Z)(1:1) TO  WRK-MOJI
               ELSE
                   MOVE    WRK-COM-INPUTCD(IDX-Z)(1:1) TO  WRK-MOJI
                   IF      WRK-COM-INPUTCD(IDX-Z)(1:3) =   "059"
                       MOVE    "7"                     TO  WRK-MOJI
                   END-IF
               END-IF
      *
               EVALUATE    WRK-MOJI
                   WHEN    "0"
      *                自賠責
                       PERFORM 10021-JIHI-KEI-SEC
                   WHEN    "8"
                   WHEN    "."
                   WHEN    "S"
                   WHEN    "*"
                       CONTINUE
      *
                   WHEN    OTHER
      *                編集チェックへ
                       PERFORM 10021-KEISAN-SEC
               END-EVALUATE
           END-PERFORM
      *
      *    最終行
      *    薬剤点数計算
           MOVE    "2"                 TO  LNK-SC90-KBN
           MOVE    IDX-MAX             TO  LNK-SC90-IDX
           CALL    "ORCSC90"           USING
                                       ORCSC90AREA
                                       WRK-SCR-REC
      *
      *    割合加算
      *****PERFORM 1006-KASAN-SET-SEC
      *    手技料の計算
           IF      IDX-SYU             >   ZERO
               MOVE    2               TO  FLG-SYUGI
               COMPUTE IDX-Z           =   IDX-MAX    +  1
               PERFORM 100212-TENSUKEI-SEC
           END-IF
      *
           COMPUTE LNK-SC90-TENSUKEI   =   LNK-SC90-TENSUKEI
                                       +   LNK-SC90-TENGAKEI
      *    各点数編集
           MOVE    LNK-SC90-TENSUKEI   TO  WRK-COM-SYUTEN1 (IDX-MAX)
           COMPUTE WRK-COM-YKZTEN (IDX-MAX)
                                       =   LNK-SC90-ZAITEN
                                       +   LNK-SC90-GAITEN
      *    器材点数
           MOVE    LNK-SC90-KIZTEN     TO  WRK-COM-KIZAITEN (IDX-MAX)
      *
      *    点数計　計算
           COMPUTE WRK-COM-TENSU (IDX-MAX) =   LNK-SC90-TENSUKEI
                                           +   LNK-SC90-ZAITEN
                                           +   LNK-SC90-GAITEN
                                           +   LNK-SC90-KIZTEN
      *    計
           COMPUTE WRK-COM-KEI (IDX-MAX)   =   WRK-COM-TENSU  (IDX-MAX)
                                           *   LNK-ORCSC-KAISU
      *    セット用合計点数
           MOVE    WRK-COM-KEI  (IDX-MAX)  TO  LNK-ORCSC-ZAIKEI
           MOVE    WRK-COM-TENSU(IDX-MAX)  TO  LNK-ORCSC-ZAITEN
      *
      *
           .
       1002-TENSU-KEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    自賠責計算処理
      *****************************************************************
       10021-JIHI-KEI-SEC                  SECTION.
      *
           IF      WRK-COM-INPUTCD(IDX-Z)(1:5) =   "09591"  OR
                                                   "09592"  OR
                                                   "09593"
               CONTINUE
           ELSE
               GO      TO      10021-JIHI-KEI-EXT
           END-IF
      *
      *    自賠責明細料・診断料
           COMPUTE WRK-COM-KISOTEN(IDX-Z)  =   WRK-COM-TEN (IDX-Z)
                                           /   10
      *
           ADD     WRK-COM-KISOTEN (IDX-Z) TO  LNK-SC90-TENGAKEI
      *    回数
           MOVE    LNK-ORCSC-KAISU         TO  WRK-COM-KAISU (IDX-Z)
      *
           MOVE    SPACE                   TO  WRK-COM-KEIFLG (IDX-Z)
      *
           .
       10021-JIHI-KEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数計算処理
      *****************************************************************
       10021-KEISAN-SEC                  SECTION.
      *
      *    手技料判定
           IF      (WRK-MOJI                   =   "1"  )  AND
                   (WRK-COM-DATAKBN (IDX-Z)    =   "1"  )
               IF      IDX-SYU             >   ZERO
      *            手技料の計算
                   MOVE    1               TO  FLG-SYUGI
                   PERFORM 100212-TENSUKEI-SEC
               END-IF
               MOVE    IDX-Z               TO  IDX-SYU
           END-IF
      *
           MOVE    LNK-ORCSC-KAISU     TO  LNK-SC90-KAISU
           MOVE    "1"                 TO  LNK-SC90-KBN
           MOVE    IDX-Z               TO  LNK-SC90-IDX
           CALL    "ORCSC90"           USING
                                       ORCSC90AREA
                                       WRK-SCR-REC
      *
      *****手技料判定
      *    IF      (WRK-MOJI                   =   "1"  )  AND
      *            (WRK-COM-DATAKBN (IDX-Z)    =   "1"  )
      *        MOVE    IDX-Z               TO  IDX-SYU
      *****END-IF
      *
           .
       10021-KEISAN-EXT.
           EXIT.
      *****************************************************************
      *    手技料の計算処理
      *****************************************************************
       100212-TENSUKEI-SEC             SECTION.
      *
           MOVE    IDX-Z               TO  HZN-IDX
           PERFORM 1006-KASAN-SET-SEC
      *    手技料の合計を編集する
           MOVE    LNK-SC90-TENSUKEI   TO  WRK-COM-SYUTEN2 (IDX-SYU)
      *
      *    労災の外来管理加算読み替え処理
           IF      SPA-HKNKBN          =   1
      *        回数を掛けた点数で判定する
      *          （２単位以上の時、読み替えはないはず）
               COMPUTE WRK-SYOKEI      =   WRK-COM-SYUTEN2 (IDX-SYU)
                                       *   LNK-ORCSC-KAISU
               IF     (WRK-COM-RSIGIRI (IDX-SYU)
                                           =   1  )  AND
                      (WRK-SYOKEI          <   LNK-ORCSC-GAIRAI-TEN)
                   MOVE     LNK-ORCSC-GAIRAI-TEN
                                           TO  LNK-SC90-TENSUKEI
               END-IF
           END-IF
      *
      *
           ADD     LNK-SC90-TENSUKEI   TO  WRK-GOK-TENSUKEI
           ADD     LNK-SC90-TENGAKEI   TO  WRK-GOK-TENGAKEI
           MOVE    ZERO                TO  LNK-SC90-TENSUKEI
           MOVE    ZERO                TO  LNK-SC90-TENGAKEI
      *
      *    最後の手技料時に、以下の計算を行う
           IF      FLG-SYUGI           =   2
               MOVE    WRK-GOK-TENSUKEI    TO  LNK-SC90-TENSUKEI
               MOVE    WRK-GOK-TENGAKEI    TO  LNK-SC90-TENGAKEI
           END-IF
      *
           .
       100212-TENSUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    割合加算計算処理
      *****************************************************************
       1006-KASAN-SET-SEC              SECTION.
      *
           MOVE    ZERO                TO  WRK-TENSUKEI-G
           MOVE    ZERO                TO  WRK-TENSUKEI-K
      *
           PERFORM VARYING     IDX     FROM    IDX-SYU  BY  1
                   UNTIL       IDX         >=  HZN-IDX
      *        労災を対象外とする
      **     IF      WRK-COM-INPUTCD(IDX)(1:3)       =   "101"
      *        CONTINUE
      **     ELSE
      *        手技料の点数を所定点数とする
      *        ％加算
             IF       (WRK-COM-INPUTCD(IDX)(1:3)   NOT =   "101") AND
                      (WRK-COM-INPUTCD(IDX)(1:1)   =   "1" )  AND
                      (WRK-COM-TENSIKIBETU(IDX)    =   5   )  AND
                      (WRK-COM-SANFLG     (IDX)    =   ZERO)
                   MOVE    ZERO                TO  WRK-TENSUKEI
                   COMPUTE WRK-TENSUKEI        =   WRK-COM-KISOTEN
                                                             (IDX-SYU)
                                               *   WRK-COM-KISOTEN(IDX)
                                               /   100
                                               +   0.5
                   MOVE    WRK-TENSUKEI        TO  WRK-TENSUKEI-9
                   ADD     WRK-TENSUKEI-9      TO  WRK-TENSUKEI-K
               END-IF
      *        ％減算（労災減算も計算する）
               IF     (WRK-COM-INPUTCD(IDX)(1:1)   =   "1" )  AND
                      (WRK-COM-TENSIKIBETU(IDX)    =   6   )  AND
                      (WRK-COM-SANFLG     (IDX)    =   ZERO)
                   MOVE    ZERO                TO  WRK-TENSUKEI
                   COMPUTE WRK-TENSUKEI        =   WRK-COM-KISOTEN
                                                             (IDX-SYU)
                                               *   WRK-COM-KISOTEN(IDX)
                                               /   100
                   MOVE    WRK-TENSUKEI        TO  WRK-TENSUKEI-9
                   ADD     WRK-TENSUKEI-9      TO  WRK-TENSUKEI-G
               END-IF
      *******END-IF
           END-PERFORM
      *
      *    労災の時、労災加算
           IF      SPA-HKNKBN          =   1
               PERFORM 10061-RSIKASAN-SET-SEC
           END-IF
      *
      *
           COMPUTE LNK-SC90-TENSUKEI   =   LNK-SC90-TENSUKEI
                                       +   WRK-TENSUKEI-K
                                       -   WRK-TENSUKEI-G
      *
           .
       1006-KASAN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災割合加算計算処理
      *****************************************************************
       10061-RSIKASAN-SET-SEC           SECTION.
      *
           MOVE    ZERO                TO  WRK-TENSUKEI-RSI
           MOVE    ZERO                TO  IDX-RSI
      *    労災加算対象点数集計
           PERFORM VARYING     IDX     FROM    IDX-SYU  BY  1
                   UNTIL       IDX         >=  HZN-IDX
      *
      *        手技料の点数を所定点数とする
      *        ％加算
               IF     (WRK-COM-INPUTCD(IDX)(1:3)   =   "101")  AND
                      (WRK-COM-TENSIKIBETU(IDX)    =   5   )  AND
                      (WRK-COM-SANFLG     (IDX)    =   2   )
                   MOVE    ZERO                TO  WRK-TENSUKEI
                   COMPUTE WRK-TENSUKEI        =  (WRK-COM-KISOTEN
                                                             (IDX-SYU)
                                               -   WRK-TENSUKEI-G )
                                               *   WRK-COM-KISOTEN(IDX)
                                               /   100
                                               +   0.5
                   MOVE    WRK-TENSUKEI        TO  WRK-TENSUKEI-9
                   ADD     WRK-TENSUKEI-9      TO  WRK-TENSUKEI-RSI
               END-IF
           END-PERFORM
      *
           COMPUTE LNK-SC90-TENSUKEI   =   LNK-SC90-TENSUKEI
                                       +   WRK-TENSUKEI-RSI
      *
           .
       10061-RSIKASAN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    全診療行為チェック処理
      *****************************************************************
       200-ALL-SYORI-SEC                SECTION.
      *
      *    チェックは診療行為入力のみとする
           IF      LNK-ORCSC-PG        =   "K02"
               CONTINUE
           ELSE
               GO      TO      200-ALL-SYORI-EXT
           END-IF
      *
           INITIALIZE                  WRK-AREA
      *
      *    リハビリのチェックは、発生３月以降より
      **** IF     (SPA-SRYYMD          <   SPA-RSI-HASSYOYMD3)  AND
      *    IF     (SPA-SRYYMD          <   SPA-RSI-SHOBYOYMD3)  AND
      *           (SPA-HKNKBN          =   1        )
      *        GO      TO      200-ALL-SYORI-EXT
      *****END-IF
      *
      *    当日算定済みのすべてのリハビリカウント
           PERFORM 2001-RIGAKU-CNT-CHK-SEC
      *
           MOVE    ZERO                TO  IDX-R
           MOVE    ZERO                TO  IDX-R1
           MOVE    ZERO                TO  IDX-R2
           MOVE    ZERO                TO  IDX-R3
           MOVE    SPACE               TO  WRK-RIGAKU-SYORI
           MOVE    ZERO                TO  FLG-SOUKI-ALL
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   200     )   OR
                              (WRK-GMN-INPUTCD (IDX-Z) =   SPACE ) OR
                              (SPA-ERRCD       NOT =   SPACE )
      *        理学療法のチェック
               SET     TBL-SAN             TO  1
               SEARCH      TBL-SANTEI-OCC  VARYING   TBL-SAN
                       AT  END
                           MOVE    ZERO        TO  FLG-RIGAKU
                           MOVE    SPACE       TO  WRK-RIGAKU-KBN
                           MOVE    SPACE       TO  WRK-RIGAKU-RYO
                   WHEN    WRK-COM-INPUTCD (IDX-Z)
                                               =   TBL-SANTEI-SRYCD
                                                           (TBL-SAN)
                       MOVE    1               TO  FLG-RIGAKU
                       MOVE    TBL-RIGAKU-KBN   (TBL-SAN)
                                               TO  WRK-RIGAKU-KBN
                       MOVE    TBL-RIGAKU-RYO   (TBL-SAN)
                                               TO  WRK-RIGAKU-RYO
                       MOVE    TBL-RIGAKU-RYO   (TBL-SAN)
                                               TO  WRK-RIGAKU-SYORI
               END-SEARCH
      *        個別・集団理学療法のチェック
               EVALUATE    WRK-RIGAKU-KBN
                   WHEN    "R"
                       IF     (WRK-RIGAKU-RYO1 NOT =   SPACE  )  AND
                              (WRK-RIGAKU-RYO  NOT =   WRK-RIGAKU-RYO1)
                           MOVE    "0093"          TO  SPA-ERRCD
                           MOVE    "1"             TO  WRK-COM-CUR
                                                             (IDX-Z)
                       END-IF
                       ADD     WRK-COM-KAISU(IDX-Z)  TO  WRK-RIGAK-CNT1
                       MOVE    IDX-Z               TO  IDX-R1
                   WHEN    "S"
                       IF     (WRK-RIGAKU-RYO2 NOT =   SPACE  )  AND
                              (WRK-RIGAKU-RYO  NOT =   WRK-RIGAKU-RYO2)
                           MOVE    "0093"          TO  SPA-ERRCD
                           MOVE    "1"             TO  WRK-COM-CUR
                                                             (IDX-Z)
                       END-IF
                       ADD     WRK-COM-KAISU(IDX-Z)  TO  WRK-RIGAK-CNT2
                       MOVE    IDX-Z               TO  IDX-R2
                   WHEN    "G"
                       IF     (WRK-RIGAKU-RYO3 NOT =   SPACE  )  AND
                              (WRK-RIGAKU-RYO  NOT =   WRK-RIGAKU-RYO3)
                           MOVE    "0093"          TO  SPA-ERRCD
                           MOVE    "1"             TO  WRK-COM-CUR
                                                             (IDX-Z)
                       END-IF
                       ADD     WRK-COM-KAISU(IDX-Z)  TO  WRK-RIGAK-CNT3
                       MOVE    IDX-Z               TO  IDX-R3
               END-EVALUATE
      *
      *********IF     (FLG-RIGAKU          =   1  )  AND
      *               (SPA-ERRCD           =   SPACE)
      *            ADD     WRK-COM-KAISU (IDX-Z)   TO  WRK-RIGAK-CNT
      *            MOVE    IDX-Z               TO  IDX-R
      *********END-IF
      *        厚生労働大臣が定める患者のチェック
               MOVE    WRK-COM-INPUTCD (IDX-Z) TO  WRK-SRYCD
               PERFORM 20011-SOUKI-CHK-SEC
               IF      FLG-SOUKI           =   1
                   MOVE    FLG-SOUKI           TO  FLG-SOUKI-ALL
               END-IF
      *
           END-PERFORM
      *
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      200-ALL-SYORI-EXT
           END-IF
      *
           IF      IDX-R1          NOT =   ZERO
               MOVE    IDX-R1          TO  IDX-RR
           END-IF
           IF     (IDX-R2          NOT =   ZERO) AND
                  (IDX-R2              >   IDX-RR)
               MOVE    IDX-R2          TO  IDX-RR
           END-IF
           IF     (IDX-R3          NOT =   ZERO) AND
                  (IDX-R3              >   IDX-RR)
               MOVE    IDX-R3          TO  IDX-RR
           END-IF
      *
      *    個別療法
           COMPUTE WRK-RIGAK-CNTALL    =   WRK-RIGAK-CNT1
                                       +   WRK-R-DCNT-K
                                       +   WRK-RIGAK-CNT2
                                       +   WRK-G-DCNT-K
                                       +   WRK-RIGAK-CNT3
                                       +   WRK-S-DCNT-K
                                       +   WRK-R-DCNT-S
                                       +   WRK-S-DCNT-S
                                       +   WRK-G-DCNT-S
           IF      FLG-SOUKI-ALL       =   1
      *        早期リハビリ加算あり１日最大６単位とする
               MOVE    6               TO  WRK-RIGAK-MAX
           ELSE
      *       １日最大４単位とする
               MOVE    4               TO  WRK-RIGAK-MAX
           END-IF
           IF      WRK-RIGAK-CNTALL    >   WRK-RIGAK-MAX
               MOVE    "0092"          TO  SPA-ERRCD
               MOVE    "1"             TO  WRK-COM-CUR (IDX-RR)
           END-IF
      *
           .
       200-ALL-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    早期リハビリ加算処理
      *****************************************************************
       20011-SOUKI-CHK-SEC         SECTION.
      *
      *    早期リハビリ加算
           SET     TBL-RIDX            TO  1
           SEARCH      TBL-RIHABIRI-OCC    VARYING   TBL-RIDX
                   AT  END
                       MOVE    ZERO            TO  FLG-SOUKI
                   WHEN    WRK-SRYCD           =   TBL-RIHA-SRYCD
                                                           (TBL-RIDX)
                       MOVE    1               TO  FLG-SOUKI
           END-SEARCH
      *
           .
       20011-SOUKI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    当日算定済みのすべての理学療法カウント処理
      *****************************************************************
       2001-RIGAKU-CNT-CHK-SEC         SECTION.
      *
           INITIALIZE                  WRK-RIGAKU-CNT-AREA
      *
      *    当日算定済みのすべての理学療法カウント 
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   28
               SET     TBL-SAN             TO  IDX
               MOVE    TBL-SANTEI-SRYCD (TBL-SAN)
                                           TO  WRK-SRYCD
      *
      *        算定履歴チェック処理
               INITIALIZE                  ORCSC91AREA
               MOVE    LNK-ORCSC-SYORIFLG  TO  LNK-SC91-SYORIFLG
               MOVE    WRK-SRYCD           TO  LNK-SC91-SRYCD
               MOVE    "4"                 TO  LNK-SC91-KBN
               MOVE    1                   TO  LNK-SC91-GMN-IDX
               MOVE    ZERO                TO  LNK-SC91-KAISU
               MOVE    LNK-ORCSC-TEISEI-AREA
                                           TO  LNK-SC91-TEISEI-AREA
               MOVE    1                   TO  LNK-SC91-CHKFLG
               CALL    "ORCSC91"           USING    MCPAREA
                                               ORCSC91AREA
                                               WRK-SCR-REC
                                               SPA-AREA
                                               TNS-TENSU-REC
      *
      *        上限日集計
               EVALUATE    TBL-RIGAKU-KBN (TBL-SAN)
                   WHEN    "R"
      *            理学
                       IF      TBL-RIGAKU-RYO(TBL-SAN) =   "S"
                           COMPUTE WRK-R-TCNT-S    =   WRK-R-TCNT-S
                                                   +   LNK-SC91-CNT
                                                   -   LNK-SC91-ATO-CNT
                           COMPUTE WRK-R-DCNT-S    =   WRK-R-DCNT-S
                                                   +   LNK-SC91-DAYCNT
                       ELSE
                           COMPUTE WRK-R-TCNT-K    =   WRK-R-TCNT-K
                                                   +   LNK-SC91-CNT
                                                   -   LNK-SC91-ATO-CNT
                           COMPUTE WRK-R-DCNT-K    =   WRK-R-DCNT-K
                                                   +   LNK-SC91-DAYCNT
                       END-IF
                       IF      LNK-SC91-DAYCNT     >   ZERO
                           MOVE    TBL-RIGAKU-RYO (TBL-SAN)
                                                   TO  WRK-RIGAKU-RYO1
                       END-IF
                   WHEN    "S"
      *            作業
                       IF      TBL-RIGAKU-RYO(TBL-SAN) =   "S"
                           COMPUTE WRK-S-TCNT-S    =   WRK-S-TCNT-S
                                                   +   LNK-SC91-CNT
                                                   -   LNK-SC91-ATO-CNT
                           COMPUTE WRK-S-DCNT-S    =   WRK-S-DCNT-S
                                                   +   LNK-SC91-DAYCNT
                       ELSE
                           COMPUTE WRK-S-TCNT-K    =   WRK-S-TCNT-K
                                                   +   LNK-SC91-CNT
                                                   -   LNK-SC91-ATO-CNT
                           COMPUTE WRK-S-DCNT-K    =   WRK-S-DCNT-K
                                                   +   LNK-SC91-DAYCNT
                       END-IF
                       IF      LNK-SC91-DAYCNT     >   ZERO
                           MOVE    TBL-RIGAKU-RYO (TBL-SAN)
                                                   TO  WRK-RIGAKU-RYO2
                       END-IF
                   WHEN    "G"
      *            言語
                       IF      TBL-RIGAKU-RYO(TBL-SAN) =   "S"
                           COMPUTE WRK-G-TCNT-S    =   WRK-G-TCNT-S
                                                   +   LNK-SC91-CNT
                                                   -   LNK-SC91-ATO-CNT
                           COMPUTE WRK-G-DCNT-S    =   WRK-G-DCNT-S
                                                   +   LNK-SC91-DAYCNT
                       ELSE
                           COMPUTE WRK-G-TCNT-K    =   WRK-G-TCNT-K
                                                   +   LNK-SC91-CNT
                                                   -   LNK-SC91-ATO-CNT
                           COMPUTE WRK-G-DCNT-K    =   WRK-G-DCNT-K
                                                   +   LNK-SC91-DAYCNT
                       END-IF
                       IF      LNK-SC91-DAYCNT     >   ZERO
                           MOVE    TBL-RIGAKU-RYO (TBL-SAN)
                                                   TO  WRK-RIGAKU-RYO3
                       END-IF
               END-EVALUATE
           END-PERFORM
      *
           .
       2001-RIGAKU-CNT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自動算定処理
      *****************************************************************
       300-AUTO-SYORI-SEC              SECTION.
      *
           .
       300-AUTO-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  TNS-YUKOSTYMD
           MOVE    ALL "9"             TO  TNS-YUKOEDYMD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-KANRIMST-READ-SEC         SECTION.
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
       900-KANRIMST-READ-EXT.
           EXIT.
      *
      *
