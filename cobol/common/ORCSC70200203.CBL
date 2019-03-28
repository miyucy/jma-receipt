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
       PROGRAM-ID.                 ORCSC70200203.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 診療行為入力
      *  コンポーネント名  : 診療行為チェック、算定（画像診断）
      *                      Ｈ１４．４改正まで
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-多々納   01/05/23  フィルム料、薬剤料計算修正
      * 01.00.02     MCC-多々納   02/03/18  施設不適合追加
      * 01.00.19     NACL-多々納  05/12/14  MONFUNC 対応
      * 03.05.00     NACL-多々納  07/04/XX  グループ診療対応
      *****************************************************************
      *
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
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-ERR             PIC 9(01).
           03  FLG-ARI             PIC 9(01).
           03  FLG-ADD             PIC 9(01).
           03  FLG-ARIOK           PIC 9(01).
           03  FLG-MADOKU          PIC 9(01).
           03  FLG-SEIBETU         PIC 9(01).
           03  FLG-BUIKBN          PIC 9(01).
           03  FLG-JIKASAN         PIC 9(01).
      *    乳幼児加算有り
           03  FLG-NYUYOJI         PIC 9(01).
      *    造影剤加算有り
           03  FLG-ZOEIZAI         PIC 9(01).
      *    自動追加種別
           03  FLG-SATU             PIC 9(01).
      *    ＣＴ有り
           03  FLG-XSEN             PIC 9(01).
           03  FLG-KAKUI            PIC 9(01).
           03  FLG-CTMRI            PIC 9(01).
      *
           03  FLG-SINDAN           PIC 9(01).
      *
           03  FLG-CHK              PIC 9(01).
      *
           03  FLG-SYORI            PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDXS                PIC 9(04).
           03  IDX-Z               PIC 9(04).
           03  IDX-Z2              PIC 9(04).
           03  IDX-T               PIC 9(04).
           03  IDX-S               PIC 9(04).
           03  IDX-SAT             PIC 9(04).
           03  IDX-SAT2            PIC 9(04).
           03  IDX-SAT3            PIC 9(04).
           03  IDX-SYU             PIC 9(04).
           03  IDX-SA              PIC 9(04).
           03  IDX-KAS             PIC 9(04).
      *
           03  IDX-GEN             PIC 9(04).
           03  IDX-GEN2            PIC 9(04).
           03  IDX-NYU             PIC 9(04).
           03  IDX-GAI             PIC 9(04).
      *
           03  IDX-9               PIC 9(04).
           03  IDX-Y               PIC 9(04).
           03  IDX-Y2              PIC 9(02).
           03  IDX-CT              PIC 9(04).
           03  IDX-BUI             PIC 9(04).
      *    ＭＡＸ行
           03  IDX-MAX             PIC 9(04).
      *    Ｘ線の開始行
           03  IDX-HOZ             PIC 9(04).
      *
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MOJI            PIC X(01). 
           03  WRK-SRYCD           PIC X(09). 
           03  WRK-SRYCD-2         PIC X(09). 
           03  WRK-HEN-SRYCD       PIC X(09). 
           03  WRK-TENSUKEI        PIC 9(08).
           03  WRK-KEIMAI          PIC 9(08).
           03  WRK-TENSU           PIC 9(08)V99.
           03  WRK-TENSU1          PIC 9(08).
           03  WRK-IDX             PIC 9(04).
      *
      *    撮影料の点数計
           03  WRK-TENSUKEI1       PIC S9(08)V999.
      *    診断料の点数計
           03  WRK-TENSUKEI2       PIC S9(08)V999.
      *    その他の点数計
           03  WRK-TENSUKEI3       PIC S9(08)V999.
      *
           03  WRK-SYOKEIS         PIC 9(08)V99.
           03  WRK-SYOKEIS2        PIC 9(08)V99.
           03  WRK-SYOKEIS3        PIC 9(08)V999.
           03  WRK-SYOKEI          PIC 9(08).
      *    点数計算用
           03  WRK-KISOTEN-9           PIC 9(07)V9(03).
           03  WRK-KISOTEN             PIC 9(07).
           03  WRK-KISOTEN-G           PIC 9(07).
      *    逓減点数
           03  WRK-GEN-TEN             PIC 9(07)V9(03).
           03  WRK-GENTEN              PIC 9(07)V9(03).
      *    撮影料回数
           03  WRK-CNT-SATUEI          PIC 9(03).
      *
      *    乳幼児加算用ワーク
           03  WRK-NYUYOJI-AREA.
               05  WRK-NYU-BUI     PIC X(01).
               05  WRK-NYU-CD      PIC X(01).
               05  WRK-NYU-FIR     PIC X(01).
               05  WRK-NYU-IDX     PIC 9(04).
               05  WRK-NYU-TEN     PIC 9(08).
      *
               05  WRK-FIRTEN      PIC 9(08).
      *
           03  WRK-TENSUKEIS       PIC 9(08)V999.
           03  WRK-TENSUKEI-9      PIC S9(08).
           03  WRK-TENSUKEI-9G     PIC S9(08).
           03  WRK-TENSUKEI-G      PIC S9(08).
      *
           03  WRK-FIRTEN-KEI      PIC 9(08).
      *
           03  WRK-TENSU-X.
               05  WRK-TENSU-Z     PIC ZZZZZZZZ.
           03  WRK-KAISU-X.
               05  WRK-KAISU-Z     PIC ZZZZ.
      *
      *   きざみ値行為再計算用
           03  WRK-SATU-TEN        PIC 9(08)V9(03).
           03  WRK-KEI-TEN         PIC 9(08)V9(03).
           03  WRK-KEI-TEN1        PIC 9(08)V9(03).
           03  WRK-KEI-TEN2        PIC 9(08).
           03  WRK-SURYO           PIC 9(05)V9(03).
           03  WRK-SURYO-R         REDEFINES   WRK-SURYO.
               05  WRK-SURYO-S1    PIC 9(05).
               05  WRK-SURYO-S2    PIC 9(03).
           03  WRK-KZMTEN          PIC 9(08)V9(03).
      *    撮影料の数量（診断料へ）
           03  WRK-SATUEI-SURYO    PIC 9(05)V9(03).
      *
      *    減コード
           03 WRK-GEN-SRYCD        PIC X(09).
      *
      *    警告メッセージ
           03  WRK-KIDCD           PIC X(04).
      *
           03  WRK-ERRCD           PIC X(04).
      *    保存用
       01  HOZ-SCR-REC.
           COPY    "CPK02SPASCR.INC"  REPLACING
                                       //SPA-// BY //HOZ-//.
      *
      *   Ｘ線同時併施（診断・撮影）
       01  TBL-DOUJI-HEISI-AREA.
      *    特殊撮影
           03  FILLER              PIC X(09)  VALUE   "170005530".
           03  FILLER              PIC X(09)  VALUE   "170005630".
      *    動態撮影
           03  FILLER              PIC X(09)  VALUE   "170005730".
           03  FILLER              PIC X(09)  VALUE   "170005830".
      *    重複撮影
           03  FILLER              PIC X(09)  VALUE   "170006130".
           03  FILLER              PIC X(09)  VALUE   "170006230".
      *    立体撮影
           03  FILLER              PIC X(09)  VALUE   "170006330".
           03  FILLER              PIC X(09)  VALUE   "170006430".
      *    パントモグラフィー
           03  FILLER              PIC X(09)  VALUE   "170006530".
           03  FILLER              PIC X(09)  VALUE   "170006630".
      *    パノララマＸ線
           03  FILLER              PIC X(09)  VALUE   "170006730".
           03  FILLER              PIC X(09)  VALUE   "170006830".
      *    断層撮影
           03  FILLER              PIC X(09)  VALUE   "170006930".
           03  FILLER              PIC X(09)  VALUE   "170007030".
      *    同時多層撮影
           03  FILLER              PIC X(09)  VALUE   "170007130".
           03  FILLER              PIC X(09)  VALUE   "170007200".
      *    回転横断撮影
           03  FILLER              PIC X(09)  VALUE   "170007330".
           03  FILLER              PIC X(09)  VALUE   "170007430".
      *    スポット撮影
           03  FILLER              PIC X(09)  VALUE   "170007530".
           03  FILLER              PIC X(09)  VALUE   "170007630".
      *    狙撃撮影
           03  FILLER              PIC X(09)  VALUE   "170007730".
           03  FILLER              PIC X(09)  VALUE   "170007830".
      *    曲面断層撮影
           03  FILLER              PIC X(09)  VALUE   "170007930".
           03  FILLER              PIC X(09)  VALUE   "170008030".
      *    児頭骨盤不均衡撮影
           03  FILLER              PIC X(09)  VALUE   "170008430".
           03  FILLER              PIC X(09)  VALUE   "170008530".
      *    単純撮影・特殊撮影
           03  FILLER              PIC X(09)  VALUE   "170001910".
           03  FILLER              PIC X(09)  VALUE   "170002010".
      *
       01  TBL-DOUJI-HEISI-R       REDEFINES  TBL-DOUJI-HEISI-AREA.
           03  TBL-DOUJI-OCC       OCCURS   14  INDEXED  TBL-IDX.
               05  TBL-DOUJI-1     PIC X(09).
               05  TBL-DOUJI-2     PIC X(09).
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
      *****COPY    "CPORCMCP.INC".
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
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
           MOVE    ZERO                TO  IDX-MAX
           MOVE    ZERO                TO  IDX-BUI
           MOVE    ZERO                TO  IDX-S
           MOVE    ZERO                TO  IDX-SAT
           MOVE    ZERO                TO  IDX-GEN
           MOVE    ZERO                TO  IDX-GEN2
           MOVE    ZERO                TO  IDX-NYU
           MOVE    1                   TO  IDX-HOZ
      *
           MOVE    ZERO                TO  FLG-END
           MOVE    ZERO                TO  FLG-SATU
           MOVE    ZERO                TO  FLG-BUIKBN
           MOVE    ZERO                TO  FLG-ZOEIZAI
           MOVE    ZERO                TO  FLG-SINDAN
           INITIALIZE                  WRK-NYUYOJI-AREA
           INITIALIZE                  WRK-AREA
      *
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   SPA-MAX-LINE     )   OR
                              (WRK-GMN-INPUTCD (IDX-Z) =   SPACE )  OR
                              (WRK-ERRCD       NOT =   SPACE )
      *
               ADD     1                   TO  IDX-MAX
      *
               IF      WRK-GMN-INPUTCD(IDX-Z)(1:1)     =   "." OR "S"
                   MOVE    WRK-GMN-INPUTCD(IDX-Z)(1:1) TO  WRK-MOJI
               ELSE
                   MOVE    WRK-COM-INPUTCD(IDX-Z)(1:1) TO  WRK-MOJI
                   IF      WRK-COM-INPUTCD(IDX-Z)(1:3) =   "059"
                       MOVE    "7"                     TO  WRK-MOJI
                   END-IF
               END-IF
      *
               EVALUATE    WRK-MOJI
                   WHEN    "8"
                   WHEN    "."
                   WHEN    "S"
                       CONTINUE
      *
                   WHEN    OTHER
      *                編集チェックへ
                       PERFORM 10011-CHK-SEC
               END-EVALUATE
           END-PERFORM
           IF      IDX-SAT             >   ZERO
      *        自動加算を追加する
               PERFORM 1002-JIDO-KASAN-SEC
           END-IF
      *
           IF      WRK-ERRCD           =   SPACE
               MOVE    WRK-KIDCD           TO  WRK-ERRCD
           END-IF
      *
           MOVE    WRK-ERRCD          TO  SPA-ERRCD
      *
           .
       1001-NAI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    明細別内容チェック、自動算定編集処理
      *****************************************************************
       10011-CHK-SEC                  SECTION.
      *
      *    各チェック処理
           EVALUATE    WRK-MOJI
               WHEN    "0"
      *            部位コードチェック
                   IF      WRK-COM-INPUTCD(IDX-Z)(1:3)   =   "002"
                       IF      FLG-BUIKBN      NOT =   ZERO
                           MOVE    "0011"          TO  WRK-ERRCD
                           MOVE    "1"             TO  WRK-COM-CUR
                                                            (IDX-Z)
                       ELSE
                           EVALUATE    WRK-COM-BUIKBN (IDX-Z)
      *                        頭部
                               WHEN    "1"
      *                        躯幹
                               WHEN    "2"
                                   MOVE    2       TO  FLG-BUIKBN
      *                        胸部・腹部
                               WHEN    "5"
                               WHEN    "6"
                                   MOVE    2       TO  FLG-BUIKBN
                                   MOVE    "1"     TO  WRK-NYU-BUI
      *                        脊髄
                               WHEN    "7"
                                   MOVE    2       TO  FLG-BUIKBN
      *                        消化器
                               WHEN    "8"
                                   MOVE    3       TO  FLG-BUIKBN
      *                        その他
                               WHEN    OTHER
                                   MOVE    1       TO  FLG-BUIKBN
                           END-EVALUATE
                       END-IF
                       MOVE    IDX-Z           TO  IDX-BUI
                   END-IF
      *
               WHEN    "1"
      *            撮影料
                   IF      WRK-COM-DATAKBN (IDX-Z) =   "1"
                       EVALUATE    WRK-COM-TNSSRYSYUKBN(IDX-Z)
                           WHEN    "721"
      *                        Ｘ線撮影料
      *                        部位区分があること
                               IF      FLG-BUIKBN      =   ZERO
                                    MOVE    "0036"     TO  WRK-ERRCD
                                    MOVE    "1"        TO  WRK-COM-CUR
                                                                (IDX-Z)
                                    GO      TO      10011-CHK-EXT
                               END-IF
      *
      *                        回数チェック
                               IF      WRK-CNT-SATUEI      =   2
                                    MOVE    "0072"     TO  WRK-ERRCD
                                    MOVE    "1"        TO  WRK-COM-CUR
                                                                (IDX-Z)
                                    GO      TO      10011-CHK-EXT
                               END-IF
                               IF      FLG-SINDAN          =   1
                                   PERFORM 1002-XSEN-END-SEC
                               ELSE
                                   IF      FLG-SINDAN  NOT =   ZERO
                                       MOVE    "0071"  TO  WRK-ERRCD
                                       MOVE    "1"     TO  WRK-COM-CUR
                                                                (IDX-Z)
                                       GO      TO  10011-CHK-EXT
                                   END-IF
      *                            同時併施のチェック等
                                   PERFORM 10013-DOUJI-CHK-SEC
                               END-IF
                               MOVE    1               TO  FLG-SINDAN
                               MOVE    IDX-Z           TO  IDX-SAT
                               ADD     1           TO  WRK-CNT-SATUEI
                           WHEN    "722"
      *                        核医学診断料
                               IF      FLG-SINDAN      NOT =   ZERO
                                   MOVE    "1"         TO  WRK-COM-CUR
                                                                (IDX-Z)
                                   MOVE    "0071"      TO  WRK-ERRCD
                               ELSE
                                   MOVE    2           TO  FLG-SINDAN
                                   MOVE    IDX-Z       TO  IDX-SAT
                               END-IF
      *                       ＣＴ診断料
                           WHEN    "723"
                               IF      FLG-SINDAN      NOT =   ZERO
                                   MOVE    "1"         TO  WRK-COM-CUR
                                                                (IDX-Z)
                                   MOVE    "0071"      TO  WRK-ERRCD
                               ELSE
                                   MOVE    3           TO  FLG-SINDAN
                                   MOVE    IDX-Z       TO  IDX-SAT
                                   MOVE    1           TO  FLG-CTMRI
                               END-IF
      *                       ＭＲＩ診断料
                           WHEN    "724"
                               IF      FLG-SINDAN      NOT =   ZERO
                                   MOVE    "1"         TO  WRK-COM-CUR
                                                                (IDX-Z)
                                   MOVE    "0071"      TO  WRK-ERRCD
                               ELSE
                                   MOVE    3           TO  FLG-SINDAN
                                   MOVE    IDX-Z       TO  IDX-SAT
                                   MOVE    2           TO  FLG-CTMRI
                               END-IF
      *--(01.00.01)----- START
      *                        撮影料
                           WHEN    "711"
                           WHEN    "712"
                           WHEN    "713"
                           WHEN    "714"
                               CONTINUE
      *                        診断料
      ******************** WHEN    OTHER
                           WHEN    "700"
      *                        その他（どの診断料にも付随する）
                               IF      FLG-SINDAN          =   4
                                   PERFORM 1004-ETC-END-SEC
                               ELSE
                                   IF      FLG-SINDAN  NOT =   ZERO
                                       MOVE    "0071"  TO  WRK-ERRCD
                                       MOVE    "1"     TO  WRK-COM-CUR
                                                                (IDX-Z)
      *********************************GO      TO      10011-CHK-EXT
                                   END-IF
                                   GO      TO      10011-CHK-EXT
                               END-IF
                               MOVE    4               TO  FLG-SINDAN
                               MOVE    IDX-Z           TO  IDX-SAT
      *--(01.00.01)----- END  
                       END-EVALUATE
                   END-IF
      *            間接撮影による逓減有り（基準不適合逓減区分以外
                   IF     (WRK-COM-TENSIKIBETU (IDX-Z) =   6 )  AND
                          (WRK-COM-KIJUNTEIGENKBN(IDX-Z)
                                                       =   ZERO ) AND
                          (WRK-COM-AUTOKBN     (IDX-Z) =   SPACE )
                       MOVE    IDX-Z               TO  IDX-GEN
                   END-IF
      ************ IF      WRK-COM-INPUTCD (IDX-Z) =   "170020570"
      *                MOVE    IDX-Z               TO  IDX-GEN
      ************ END-IF
      *            手技料 加算チェック
                   IF      WRK-COM-DATAKBN (IDX-Z) =   "2"
                       PERFORM 10011-KASAN-CHK-SEC
                   END-IF
      *            単純撮影判定（乳幼児加算）の有無
                   IF      WRK-COM-INPUTCD (IDX-Z) =   "170001910"  OR
                                                       "170011650"
                       MOVE    "1"             TO  WRK-NYU-CD
                   END-IF
      *            乳幼児加算（点数)
                   IF      WRK-COM-DATAKBN (IDX-Z) =   "1"
                       MOVE    IDX-Z               TO  IDX-SYU
                       PERFORM 1007-NYUYOJI-SET-SEC
                   END-IF
      *        薬剤
               WHEN    "6"
      *            造影剤
                   IF      WRK-COM-ZOEIZAIKBN(IDX-Z)   =   1
                       MOVE   1                TO  FLG-ZOEIZAI
                   END-IF
      *            麻毒区分
                   IF      WRK-COM-MADOKUKBN (IDX-Z)   =   1
                       MOVE   1                TO  FLG-MADOKU
                   END-IF
      *            生物学的製剤区分
                   IF      WRK-COM-SEIBUTUKBN(IDX-Z)   =   1
                       MOVE   1                TO  FLG-SEIBETU
                   END-IF
      *        器材
               WHEN    "7"
      *            フィルム判定
                   IF      WRK-COM-DATAKBN (IDX-Z)     =   "3"
      *****************特定器材年齢加算区分判定
      *                IF      WRK-COM-TOKUKIZAIAGEKSNKBN (IDX-Z)
      *                                                =   1
      *                    MOVE    "1"                 TO  WRK-NYU-FIR
      *                    ADD     LNK-SC90-FIRTEN     TO  WRK-NYU-TEN
      *                ELSE
      *                    ADD     LNK-SC90-FIRTEN     TO  WRK-FIRTEN
      *                END-IF
      *****************MOVE    IDX-Z           TO  WRK-NYU-IDX
      *                Ｘ線の数量変更の為の枚数集計
                       IF      WRK-COM-BUNGSU (IDX-Z)  =  ZERO
                           MOVE    1               TO  WRK-COM-BUNGSU
                                                               (IDX-Z)
                       END-IF
                       COMPUTE WRK-KEIMAI      =   WRK-KEIMAI
                                               +  (WRK-COM-SURYO(IDX-Z)
                                               *   WRK-COM-BUNGSU
                                                               (IDX-Z))
                   END-IF
      *
      *            酸素・窒素はエラー
                   IF      WRK-COM-TOKUKIZAISBT1 (IDX-Z) =   2
                       MOVE    "0039"          TO  WRK-ERRCD
                       MOVE    "1"             TO  WRK-COM-CUR  (IDX-Z)
                   END-IF
           END-EVALUATE
      *
           .
       10011-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自動加算追加処理
      *****************************************************************
       1002-JIDO-KASAN-SEC        SECTION.
      *
      *    Ｘ線の時、エラーなら診断料の自動発生をおこなう
           IF     (FLG-SINDAN          =   1     )  AND
                  (WRK-ERRCD       NOT =   SPACE )
               PERFORM 10001-XSEN-SINDAN-SEC
           END-IF
      *
           MOVE    SPACE               TO  WRK-HEN-SRYCD
           IF      FLG-SINDAN          =   3
      *        ＣＴ．ＭＲＩの算定用コード編集
               MOVE    IDX-SAT             TO  IDX-Z
               PERFORM 10023-CTMRIHEN-SEC
           END-IF
      *
           IF     (FLG-SINDAN          =   3     )  AND
                  (LNK-ORCSC-PG        =   "K02" )  AND
                  (LNK-ORCSC-SYORIFLG  =   ZERO  )  AND
                  (WRK-HEN-SRYCD   NOT =   SPACE )
      *        ＣＴ．ＭＲＩの手技料変更チェック
               PERFORM 10012-SYUGI-CHK-SEC
               IF      WRK-ERRCD       NOT =   SPACE
                   GO      TO      1002-JIDO-KASAN-EXT
               END-IF
           END-IF
      *
           .
       1002-JIDO-KASAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＴ．ＭＲＩの算定用コード変換処理
      *****************************************************************
       10023-CTMRIHEN-SEC                  SECTION.
      *
      *
           MOVE    SPACE               TO  WRK-HEN-SRYCD
      *    包括逓減区分判定（Ｋ０３でも同様の判定をしている）
           EVALUATE    WRK-COM-HOUKATUTEIGENKBN (IDX-Z)
      *        頭部
               WHEN    "201"
                   MOVE    "099700101"         TO  WRK-HEN-SRYCD
      *        躯幹
               WHEN    "202"
                   MOVE    "099700102"         TO  WRK-HEN-SRYCD
      *        四肢
               WHEN    "203"
                   MOVE    "099700103"         TO  WRK-HEN-SRYCD
           END-EVALUATE
           IF      WRK-HEN-SRYCD       =   SPACE
               MOVE    SPACE           TO  WRK-COM-CHK-SRYCD (IDX-Z)
           ELSE
               MOVE    WRK-HEN-SRYCD   TO  WRK-COM-CHK-SRYCD (IDX-Z)
           END-IF
      *
           .
       10023-CTMRIHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＴ．ＭＲＩの手技料変更チェック処理
      *****************************************************************
       10012-SYUGI-CHK-SEC                  SECTION.
      *
           MOVE    IDX-SAT             TO  IDX-Z
      *
      *****MOVE    SPACE               TO  WRK-HEN-SRYCD
      *    包括逓減区分判定（Ｋ０３でも同様の判定をしている）
      *    EVALUATE    WRK-COM-HOUKATUTEIGENKBN (IDX-Z)
      *        頭部
      *        WHEN    "201"
      *            MOVE    "099700101"         TO  WRK-HEN-SRYCD
      *        躯幹
      *        WHEN    "202"
      *            MOVE    "099700102"         TO  WRK-HEN-SRYCD
      *        四肢
      *        WHEN    "203"
      *            MOVE    "099700103"         TO  WRK-HEN-SRYCD
      *    END-EVALUATE
      *    IF      WRK-HEN-SRYCD       =   SPACE
      *        GO      TO      10012-SYUGI-CHK-EXT
      *    ELSE
      *        MOVE    WRK-HEN-SRYCD   TO  WRK-COM-CHK-SRYCD (IDX-Z)
      *****END-IF
      *
      *    算定履歴チェック
           INITIALIZE                      ORCSC91AREA
           MOVE    "3"                 TO  LNK-SC91-KBN
           MOVE    LNK-ORCSC-SYORIFLG  TO  LNK-SC91-SYORIFLG
           MOVE    WRK-HEN-SRYCD       TO  LNK-SC91-SRYCD
           MOVE    IDX-Z               TO  LNK-SC91-GMN-IDX
           MOVE    LNK-ORCSC-TEISEI-AREA   TO  LNK-SC91-TEISEI-AREA
           CALL    "ORCSC91"       USING
                                       MCPAREA
                                       ORCSC91AREA
                                       WRK-SCR-REC
                                       SPA-AREA
                                       TNS-TENSU-REC
           IF      LNK-SC91-ERRCD      =   "0001"
               MOVE    LNK-SC91-ERRCD      TO  WRK-ERRCD
               MOVE    "1"                 TO  WRK-COM-CUR (IDX-Z)
               GO      TO      10012-SYUGI-CHK-EXT
           END-IF
      *
      *    当月算定なし
           IF      LNK-SC91-CNT        =   ZERO
      *
      *        ＣＴ．ＭＲＩの算定チェック
               IF      WRK-COM-INPUTCD (IDX-Z)     =   "170022290"  OR
                                                       "170022390"  OR
                                                       "170022490"  OR
                                                       "170701470"  OR
                                                       "170701570"  OR
                                                       "170701670"
                   IF     (WRK-COM-KZMFLG (IDX-Z)  =   SPACE )  AND 
                          (LNK-ORCSC-TOROKU    NOT =   "2"   )
                       MOVE    "K003"              TO  WRK-KIDCD
                       MOVE    "1"                 TO  WRK-COM-KZMFLG
                                                             (IDX-Z)
                       MOVE    "2"                 TO  WRK-COM-CUR
                                                             (IDX-Z)
                   END-IF
               END-IF
           ELSE
      *        包括逓減区分判定
               EVALUATE    WRK-COM-HOUKATUTEIGENKBN (IDX-Z)
      *            頭部
                   WHEN    "201"
                       IF      WRK-COM-INPUTCD (IDX-Z) =   "170022290"
                                                       OR  "170701470"
                           CONTINUE
                       ELSE
      *                    （一般）
                           MOVE    "170022290"     TO  WRK-COM-INPUTCD
                                                               (IDX-Z)
                       END-IF
      *            躯幹
                   WHEN    "202"
                       IF      WRK-COM-INPUTCD (IDX-Z) =   "170022390" 
                                                       OR  "170701570"
                           CONTINUE
                       ELSE
      *                    （一般）
                           MOVE    "170022390"     TO  WRK-COM-INPUTCD
                                                                (IDX-Z)
                       END-IF
      *            四肢
                   WHEN    "203"
                       IF      WRK-COM-INPUTCD (IDX-Z) =   "170022490" 
                                                       OR  "170701670"
                           CONTINUE
                       ELSE
      *                    （一般）
                           MOVE    "170022490"     TO  WRK-COM-INPUTCD
                                                               (IDX-Z)
                       END-IF
               END-EVALUATE
      *        診療コード変更
               MOVE    1                   TO  FLG-ARI
               MOVE    IDX-Z               TO  IDX-T
               MOVE    WRK-COM-INPUTCD(IDX-Z)
                                           TO  WRK-SRYCD
               PERFORM 1002-JIDOUSET-SEC
               MOVE    SPACE               TO  WRK-COM-AUTOKBN (IDX-Z)
               IF      FLG-ADD             =   1
      *            変更の診療コードをセット
                   MOVE    WRK-HEN-SRYCD   TO  WRK-COM-CHK-SRYCD(IDX-S)
               END-IF
           END-IF
           .
       10012-SYUGI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    加算料チェック処理
      *****************************************************************
       10011-KASAN-CHK-SEC                  SECTION.
      *
      *    加算データの時、前に手技料があること
           MOVE    ZERO                TO  FLG-ARI
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL       IDX1    >=  IDX-Z
               IF     (WRK-COM-INPUTCD(IDX1)(1:1)  =   "1" )  AND
                      (WRK-COM-DATAKBN(IDX1)   NOT =   "2" )
                   IF      WRK-COM-CHUKSNCD (IDX1)     =
                                               WRK-COM-CHUKSNCD(IDX-Z)
                       MOVE    1               TO  FLG-ARIOK
                   END-IF
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
       10011-KASAN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    同時併施のチェック処理
      *****************************************************************
       10013-DOUJI-CHK-SEC           SECTION.
      *    同時併施のチェック
           SET     TBL-IDX             TO  1
           SEARCH      TBL-DOUJI-OCC   VARYING   TBL-IDX
                   AT  END
                       MOVE    SPACE           TO  WRK-SRYCD
                   WHEN    WRK-COM-INPUTCD (IDX-Z) =   TBL-DOUJI-2
                                                           (TBL-IDX)
                       MOVE    TBL-DOUJI-1 (TBL-IDX)
                                                TO  WRK-SRYCD
           END-SEARCH
      *
      *    特殊撮影以外エラー
           IF     (WRK-COM-INPUTCD (IDX-Z) =   "170002010" )  OR
                  (WRK-SRYCD               =   SPACE )
               CONTINUE
           ELSE
               MOVE    "0070"          TO  WRK-ERRCD
               MOVE    "1"             TO  WRK-COM-CUR (IDX-Z)
           END-IF
           .
      *
       10013-DOUJI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｘ線撮影料終了処理
      *****************************************************************
       1002-XSEN-END-SEC           SECTION.
      *
      *    同時併施のチェック
           SET     TBL-IDX             TO  1
           SEARCH      TBL-DOUJI-OCC   VARYING   TBL-IDX
                   AT   END
                       MOVE    SPACE           TO  WRK-SRYCD
                   WHEN    WRK-COM-INPUTCD (IDX-Z) =   TBL-DOUJI-1
                                                           (TBL-IDX)
                       MOVE    TBL-DOUJI-2 (TBL-IDX)
                                                TO  WRK-SRYCD
           END-SEARCH
      *
      *    単純撮影料の２回目を特殊撮影料へ変換
           IF      WRK-SRYCD       NOT =   SPACE
      *        診療コード変更
               MOVE    1                   TO  FLG-ARI
               MOVE    IDX-Z               TO  IDX-T
               PERFORM 1002-JIDOUSET-SEC
           END-IF
      *    撮影の切り替えフラグ
           MOVE    "K"                 TO  WRK-COM-AUTOKBN (IDX-Z)
      *
      *    診断料加算追加
           MOVE    1                   TO  IDX-HOZ
           PERFORM 10001-XSEN-SINDAN-SEC
      *
           MOVE    ZERO                TO  IDX-SAT
           MOVE    ZERO                TO  IDX-GEN
           MOVE    ZERO                TO  LNK-SC90-BUNGSU
           MOVE    ZERO                TO  LNK-SC90-BUNGSU
           MOVE    ZERO                TO  WRK-KEIMAI
      *    フィルム乳幼児加算領域クリア
           INITIALIZE                  WRK-NYUYOJI-AREA
      *
      *    現在のチェック位置に戻す
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-MAX-LINE
               IF      WRK-COM-AUTOKBN (IDX)   =   "K"
                   MOVE    SPACE           TO  WRK-COM-AUTOKBN (IDX)
                   MOVE    IDX             TO  IDX-Z
                   MOVE    SPA-MAX-LINE    TO  IDX
               END-IF
           END-PERFORM
      *
           MOVE    IDX-Z               TO  IDX-HOZ
           .
       1002-XSEN-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ｘ線撮影料作成処理
      *****************************************************************
       10001-XSEN-SINDAN-SEC           SECTION.
      *
      *    逓減あり
           IF      IDX-GEN2            >   ZERO
               IF      IDX-SAT         =  (IDX-GEN2 -  1 )
                   COMPUTE IDX-SAT2    =   IDX-SAT  +  1
               ELSE
                   MOVE    IDX-SAT         TO  IDX-SAT2
               END-IF
           ELSE
               MOVE    IDX-SAT         TO  IDX-SAT2
           END-IF
      *
           MOVE    IDX-SAT2            TO  IDX-S
           PERFORM 100012-SINDAN-SET-SEC
      *
      *    撮影料の再計算
           MOVE    ZERO                TO  WRK-TENSUKEI
           MOVE    ZERO                TO  WRK-KISOTEN-G
      *    枚数計算
      *****COMPUTE WRK-KEIMAI          =   LNK-SC90-BUNGSU
      *                                *   LNK-SC90-MAISU
      *****MOVE    LNK-SC90-MAISU      TO  WRK-KEIMAI
           INITIALIZE                  ORCSC90AREA
           MOVE    ZERO                TO  IDX-MAX
           PERFORM VARYING     IDX-Z   FROM    IDX-HOZ BY  1
                   UNTIL      (IDX-Z       >   SPA-MAX-LINE  )  OR
                              (WRK-GMN-INPUTCD(IDX-Z)  =   SPACE ) OR
                              (WRK-COM-AUTOKBN(IDX-Z)  =   "K"   )
      *
               MOVE    IDX-Z               TO  IDX-MAX
      *        明細計算
               PERFORM 100013-XSEN-KEI-SEC
      *
               IF      WRK-COM-INPUTCD (IDX-Z)(1:1)    =   "1"
                   IF      WRK-COM-DATAKBN (IDX-Z)     =   "1"
                       EVALUATE    WRK-COM-TNSSRYSYUKBN(IDX-Z)(1:2)
                           WHEN    "72"
      *                    撮影料編集
                               MOVE    ZERO                TO  FLG-SATU
                               PERFORM 100011-STATUEI-RYO-SEC
                           WHEN    "71"
      *                    診断料
                               MOVE    1                   TO  FLG-SATU
                               PERFORM 100011-STATUEI-RYO-SEC
      *                    その他（自動追加は診断料とする）
                           WHEN    OTHER
                               IF      WRK-COM-AUTOKBN (IDX-Z)  =   "2"
                                   MOVE    1               TO  FLG-SATU
                               ELSE
                                   MOVE    ZERO            TO  FLG-SATU
                               END-IF
                               PERFORM 100011-STATUEI-RYO-SEC
                       END-EVALUATE
                   ELSE
                       IF      WRK-COM-SANFLG (IDX-Z) =   ZERO
      *                加算項目
                           MOVE    IDX-Z          TO  IDX-T
                           PERFORM 10071-KASAN-KEI-SEC
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
      *    フィルム点数計算
           PERFORM 1006-FIRTEN-SET-SEC
      *
           .
       10001-XSEN-SINDAN-EXT.
           EXIT.
      *
      *****************************************************************
      *   明細計算処理
      *****************************************************************
       100013-XSEN-KEI-SEC           SECTION.
      *
           IF     (IDX-SAT                 =   IDX-Z  )  AND
                  (WRK-COM-INPUTCD (IDX-Z)(1:1)    =   "1" ) AND
                  (WRK-COM-DATAKBN (IDX-Z)         =   "1" )
      *        撮影料を逓減、乳幼児加算後にきざみ値計算をする
               PERFORM 1000131-SATUEI-KEI-SEC
           ELSE
      *        きざみ値判定（診断料）
               IF     (WRK-COM-INPUTCD (IDX-Z)(1:1)    =   "1" ) AND
                      (WRK-COM-DATAKBN (IDX-Z)         =   "1" )
                   PERFORM 1000133-SINDAN-KEISAN-SEC
               END-IF
           END-IF
      *
      *    明細計算
           MOVE    LNK-ORCSC-KAISU     TO  LNK-SC90-KAISU
           MOVE    "1"                 TO  LNK-SC90-KBN
           MOVE    IDX-Z               TO  LNK-SC90-IDX
           CALL    "ORCSC90"           USING
                                       ORCSC90AREA
                                       WRK-SCR-REC
      *
           MOVE    WRK-COM-INPUTCD (IDX-Z)(1:1)    TO  WRK-MOJI
           IF      WRK-COM-INPUTCD(IDX-Z)(1:3) =   "059"
               MOVE    "7"                     TO  WRK-MOJI
           END-IF
           EVALUATE    WRK-MOJI
      *        器材
               WHEN    "7"
      *            フィルム集計
                   IF      WRK-COM-DATAKBN (IDX-Z)     =   "3"
      *                特定器材年齢加算区分判定
                       IF      WRK-COM-TOKUKIZAIAGEKSNKBN (IDX-Z)
                                                       =   1
                           MOVE    "1"                 TO  WRK-NYU-FIR
                           ADD     LNK-SC90-FIRTEN     TO  WRK-NYU-TEN
                           MOVE    IDX-Z               TO  WRK-NYU-IDX
                       ELSE
                           ADD     LNK-SC90-FIRTEN     TO  WRK-FIRTEN
                       END-IF
                   END-IF
           END-EVALUATE
           .
       100013-XSEN-KEI-EXT.
           EXIT.
      *
      *****************************************************************
      *     撮影料編集処理
      *****************************************************************
       1000131-SATUEI-KEI-SEC          SECTION.
      *
           MOVE    WRK-COM-TEN(IDX-Z)  TO  WRK-SATU-TEN
           MOVE    ZERO                TO  WRK-SATUEI-SURYO
      *
           IF     (WRK-CNT-SATUEI      =   1  )  AND
                  (IDX-GEN             >   ZERO )
               PERFORM VARYING     IDX-Z2  FROM    IDX-SAT BY  1
                   UNTIL      (IDX-Z2      >   SPA-MAX-LINE  )  OR
                              (WRK-GMN-INPUTCD(IDX-Z2)  =   SPACE ) OR
                              (WRK-COM-AUTOKBN(IDX-Z2)  =   "K"   )
                   IF     (WRK-COM-TENSIKIBETU (IDX-Z2) =   6 )  AND
                          (WRK-COM-KIJUNTEIGENKBN(IDX-Z2)
                                                       =   ZERO ) AND
                          (WRK-COM-AUTOKBN    (IDX-Z2) =   SPACE )
      *                間接撮影による逓減計算（診断料）
                       COMPUTE WRK-GENTEN      =   WRK-SATU-TEN
                                           *  (WRK-COM-TEN  (IDX-Z2)
                                           /   100        )
                       COMPUTE WRK-SATU-TEN    =   WRK-SATU-TEN
                                               -   WRK-GENTEN
                       MOVE    1               TO  WRK-COM-SANFLG
                                                          (IDX-Z2)
                       MOVE    SPA-MAX-LINE    TO  IDX-Z2
                   END-IF
               END-PERFORM
           END-IF
      *
      *    乳幼児加算（％加算）
           PERFORM VARYING     IDX-Z2  FROM    IDX-SAT BY  1
                   UNTIL      (IDX-Z2      >   SPA-MAX-LINE  )  OR
                              (WRK-GMN-INPUTCD(IDX-Z2)  =   SPACE ) OR
                              (WRK-COM-AUTOKBN(IDX-Z2)  =   "K"   )
              IF     (WRK-COM-SANFLG(IDX-Z2)  =   2  )  AND
                     (WRK-COM-TENSIKIBETU(IDX-Z2)  =   5  )
                   MOVE    ZERO                TO  WRK-TENSUKEIS
                   COMPUTE WRK-TENSUKEIS       =   WRK-SATU-TEN
                                               *   WRK-COM-TEN (IDX-Z2)
                                               /   100
                   MOVE    1               TO  WRK-COM-SANFLG(IDX-Z2)
                   COMPUTE WRK-SATU-TEN        =   WRK-SATU-TEN
                                               +   WRK-TENSUKEIS
                   MOVE    SPA-MAX-LINE        TO  IDX-Z2
               END-IF
           END-PERFORM
      *
      *    きざみ値判定
           IF     (WRK-COM-INPUTCD (IDX-Z)(1:1)    =   "1" ) AND
                  (WRK-COM-DATAKBN (IDX-Z)         =   "1" ) AND
                  (WRK-COM-KZMCOMPSIKIBETU (IDX-Z) NOT =   ZERO)
      *        きざみ値計算
               PERFORM 1000132-TENSU-KEISAN-SEC
      *        撮影料の数量を保存
               MOVE    WRK-COM-SURYO (IDX-Z)   TO  WRK-SATUEI-SURYO
           ELSE
      *        撮影料
               COMPUTE WRK-TENSUKEI-9      =   WRK-SATU-TEN  + 0.5
               MOVE    WRK-TENSUKEI-9      TO  WRK-COM-KISOTEN(IDX-Z)
           END-IF
      *
           .
       1000131-SATUEI-KEI-EXT.
           EXIT.
      *
      *****************************************************************
      *     診断料その他処理
      *****************************************************************
       1000133-SINDAN-KEISAN-SEC          SECTION.
      *
           MOVE    WRK-COM-TEN  (IDX-Z)    TO  WRK-SATU-TEN
      *
      *    間接撮影による逓減計算
           IF     (WRK-CNT-SATUEI      =   1   )  AND
                  (WRK-COM-TNSSRYSYUKBN(IDX-Z)(1:2)  =  "71" ) AND
                  (IDX-GEN             >   ZERO )
               PERFORM VARYING     IDX-Z2  FROM    IDX-SAT BY  1
                   UNTIL      (IDX-Z2      >   SPA-MAX-LINE  )  OR
                              (WRK-GMN-INPUTCD(IDX-Z2)  =   SPACE ) OR
                              (WRK-COM-AUTOKBN(IDX-Z2)  =   "K"   )
                   IF     (WRK-COM-TENSIKIBETU (IDX-Z2) =   6 )  AND
                          (WRK-COM-KIJUNTEIGENKBN(IDX-Z2)
                                                       =   ZERO ) AND
                          (WRK-COM-AUTOKBN    (IDX-Z2) =   SPACE )
      *                間接撮影による逓減計算（診断料）
                       COMPUTE WRK-GENTEN      =   WRK-SATU-TEN
                                           *  (WRK-COM-TEN  (IDX-Z2)
                                           /   100        )
                       COMPUTE WRK-SATU-TEN    =   WRK-SATU-TEN
                                               -   WRK-GENTEN
                       MOVE    1               TO  WRK-COM-SANFLG
                                                          (IDX-Z2)
                       MOVE    SPA-MAX-LINE        TO  IDX-Z2
                   END-IF
               END-PERFORM
           END-IF
      *
      *    きざみ値判定
           IF     (WRK-COM-INPUTCD (IDX-Z)(1:1)    =   "1" ) AND
                  (WRK-COM-DATAKBN (IDX-Z)         =   "1" ) AND
                  (WRK-COM-KZMCOMPSIKIBETU (IDX-Z) NOT =   ZERO)
      *        撮影料の数量を数量へ
               IF      WRK-SATUEI-SURYO    >   ZERO
                   MOVE    "1"             TO  WRK-COM-SURFLG (IDX-Z)
                   MOVE    WRK-SATUEI-SURYO    TO  WRK-COM-SURYO (IDX-Z)
               END-IF
      *        きざみ値計算
               PERFORM 1000132-TENSU-KEISAN-SEC
           ELSE
               COMPUTE WRK-TENSUKEI-9      =   WRK-SATU-TEN  + 0.5
               MOVE    WRK-TENSUKEI-9      TO  WRK-COM-KISOTEN(IDX-Z)
           END-IF
      *
      *
           .
       1000133-SINDAN-KEISAN-EXT.
           EXIT.
      *
      *****************************************************************
      *     きざみ値計算処理
      *****************************************************************
       1000132-TENSU-KEISAN-SEC          SECTION.
      *
           MOVE    WRK-COM-INPUTCD (IDX-Z)
                                       TO  TNS-SRYCD
           PERFORM 910-TENSU-READ-SEC
      *
      *    数量入力のない時,数量を枚数とする
           IF      WRK-COM-SURFLG (IDX-Z) =   SPACE
               IF      WRK-KEIMAI          >   WRK-COM-KZMJGN
                                                           (IDX-Z)
                   MOVE    WRK-COM-KZMJGN (IDX-Z)
                                               TO  WRK-COM-SURYO
                                                           (IDX-Z)
               ELSE
                   IF      WRK-KEIMAI          =   ZERO
                       MOVE    1               TO  WRK-COM-SURYO
                                                           (IDX-Z)
                   ELSE
                       MOVE    WRK-KEIMAI      TO  WRK-COM-SURYO
                                                           (IDX-Z)
                   END-IF
                END-IF
           END-IF
      *
      *    きざみ値計算
           MOVE    WRK-COM-SURYO (IDX-Z)   TO  WRK-SURYO
           MOVE    ZERO                    TO  WRK-KEI-TEN2
      *    きざみ点数を算定点数の１／２とする
           COMPUTE WRK-KZMTEN          =   WRK-SATU-TEN   /  2
      *    きざみ値判定
           EVALUATE    TRUE
      *            データ≦（下限値−きざみ値）
               WHEN    WRK-SURYO       <=  (TNS-KZMKGN  -  TNS-KZM)
                   IF      TNS-KZMERR          =   2  OR  3
                       MOVE    "0021"          TO  SPA-ERRCD
                   END-IF
      *
      *            下限値＜データ≦上限値
               WHEN     (TNS-KZMKGN        <   WRK-SURYO )   AND
                        (TNS-KZMJGN        >=  WRK-SURYO )
      *            点数計算式１
                   COMPUTE WRK-KEI-TEN1    =  (WRK-SURYO -  TNS-KZMKGN)
                                           /   TNS-KZM
                                           +   0.999
                   MOVE    WRK-KEI-TEN1    TO  WRK-KEI-TEN2
                   COMPUTE WRK-KEI-TEN     =   WRK-SATU-TEN
                                           + ( WRK-KEI-TEN2
                                           *   WRK-KZMTEN )
                   COMPUTE WRK-KEI-TEN2    =   WRK-KEI-TEN    +  0.5
      *
      *            上限値＜データ
               WHEN    TNS-KZMJGN        <   WRK-SURYO
                   IF      TNS-KZMERR        =   0  OR  2
      *            点数計算式１をせず、エラーとする
      ****             MOVE    "0022"        TO  SPA-ERRCD
      *            警告エラーとする
                       MOVE    "K030"            TO  SPA-ERRCD
      *            点数計算式１
                       COMPUTE WRK-KEI-TEN1    =  (WRK-SURYO
                                               -  TNS-KZMKGN)
                                               /   TNS-KZM
                                               +   0.999
                       MOVE    WRK-KEI-TEN1    TO  WRK-KEI-TEN2
                       COMPUTE WRK-KEI-TEN     =   TNS-TEN
                                               + ( WRK-KEI-TEN2
                                               *   TNS-KZMTEN )
                       COMPUTE WRK-KEI-TEN2    =   WRK-KEI-TEN    +  0.5
                   ELSE
      *            点数計算式２
                       COMPUTE WRK-KEI-TEN1    =  (TNS-KZMJGN
                                               -   TNS-KZMKGN)
                                               /   TNS-KZM
                                               +   0.999
                       MOVE    WRK-KEI-TEN1    TO  WRK-KEI-TEN2
                       COMPUTE WRK-KEI-TEN     =   WRK-SATU-TEN
                                               + ( WRK-KEI-TEN2
                                               *   WRK-KZMTEN )
                       COMPUTE WRK-KEI-TEN2    =   WRK-KEI-TEN  +  0.5
                   END-IF
           END-EVALUATE
      *
           IF     (SPA-ERRCD           =   SPACE) OR
                  (SPA-ERRCD(1:1)      =   "K"  )
               IF      WRK-KEI-TEN2        >   ZERO
                   MOVE    WRK-KEI-TEN2    TO  WRK-COM-KISOTEN  (IDX-Z)
               ELSE
                   COMPUTE WRK-TENSUKEI-9  =   WRK-SATU-TEN  + 0.5
                   MOVE    WRK-TENSUKEI-9  TO  WRK-COM-KISOTEN(IDX-Z)
               END-IF
           END-IF
      *
      *
           .
       1000132-TENSU-KEISAN-EXT.
           EXIT.
      *
      *****************************************************************
      *     映像診断用　診断料編集処理
      *****************************************************************
       100011-STATUEI-RYO-SEC          SECTION.
      *
      ***  IF      WRK-CNT-SATUEI      =   1
      *        間接撮影による逓減計算
      *        IF      IDX-GEN         NOT =   ZERO
      *            COMPUTE WRK-GENTEN      =   WRK-COM-KISOTEN(IDX-Z)
      *                                    *  (WRK-COM-KISOTEN(IDX-GEN)
      *                                    /   100        )
      *                                    +   0.5
      *            COMPUTE WRK-COM-KISOTEN (IDX-Z)
      *                                    =   WRK-COM-KISOTEN(IDX-Z)
      *                                    -   WRK-GENTEN
      *        END-IF
      *****END-IF
      *
           IF      FLG-SATU            =   ZERO
      *        撮影料加算
               ADD     WRK-COM-KISOTEN (IDX-Z)    TO  WRK-TENSUKEI1
           ELSE
      *        診断料加算
      *        ２回目の時、100分50　とする
               IF     (WRK-CNT-SATUEI      >   1       )  AND
                      (WRK-COM-TNSSRYSYUKBN (IDX-Z) =   "711" )
                   COMPUTE WRK-TENSU1          =   WRK-COM-KISOTEN
                                                              (IDX-Z)
                                               *   0.5
                                               +   0.5
                   MOVE    WRK-TENSU1          TO  WRK-TENSU
                   ADD     WRK-TENSU           TO  WRK-TENSUKEI2
               ELSE
                   ADD     WRK-COM-KISOTEN (IDX-Z) TO  WRK-TENSUKEI2
               END-IF
           END-IF
      *
           .
       100011-STATUEI-RYO-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    診断料自動加算作成処理
      *****************************************************************
       100012-SINDAN-SET-SEC           SECTION.
      *
           MOVE    SPACE               TO  WRK-SRYCD
      *
      *    診断・撮影同時のチェック
           SET     TBL-IDX             TO  1
           SEARCH      TBL-DOUJI-OCC   VARYING   TBL-IDX
                   AT   END
                       MOVE    SPACE           TO  WRK-SRYCD
                   WHEN    WRK-COM-INPUTCD (IDX-SAT) =   TBL-DOUJI-1
                                                           (TBL-IDX)
                       MOVE    TBL-DOUJI-2 (TBL-IDX)
                                                TO  WRK-SRYCD
                   WHEN    WRK-COM-INPUTCD (IDX-SAT) =   TBL-DOUJI-2
                                                           (TBL-IDX)
                       MOVE    TBL-DOUJI-1 (TBL-IDX)
                                                TO  WRK-SRYCD
           END-SEARCH
           IF     (WRK-SRYCD           =   SPACE      )  OR
                  (WRK-SRYCD           =   "170002010"  OR 
                                           "170001910" )
               MOVE    ZERO                TO  FLG-SYORI
           ELSE
               MOVE    SPACE               TO  WRK-SRYCD
               MOVE    1                   TO  FLG-SYORI
           END-IF
      *
           IF      WRK-COM-INPUTCD (IDX-SAT)   =   "170002010"
      *        特殊撮影の写真診断（２回目以降）
               MOVE    "170000610"         TO  WRK-SRYCD
           ELSE
      *    単純撮影の診断料
               IF      WRK-COM-INPUTCD (IDX-SAT)   =   "170002110"
      *            造影剤使用の診断料
                   MOVE    "170000810"         TO  WRK-SRYCD
               ELSE
                   EVALUATE    FLG-BUIKBN
                       WHEN    1
                       WHEN    3
      *                    その他
                           MOVE    "170000510"         TO  WRK-SRYCD
                       WHEN    2
      *                    頭・胸・腹・脊髄
                           MOVE    "170000410"         TO  WRK-SRYCD
                   END-EVALUATE
               END-IF
           END-IF
           IF      FLG-SYORI           =   1
               MOVE    SPACE               TO  WRK-SRYCD
           END-IF
      *    診断料自動追加
           IF      WRK-SRYCD       NOT =   SPACE
               MOVE    1                   TO  FLG-SATU
               MOVE    IDX-SAT2            TO  IDX-S
               PERFORM 1003-JIDOU-CHK-SEC
               PERFORM 1002-JIDOUSET-SEC
      *
      ******   １回目で間接撮影コードの入力がある時、診断料の後にも追加
      *        IF      (FLG-ADD            =   1    )  AND
      *                (IDX-GEN            >   ZERO )  AND
      *                (WRK-CNT-SATUEI     =   1    )
      *            MOVE    ZERO            TO  FLG-ARI
      **           MOVE    WRK-COM-INPUTCD (IDX-GEN)
      *            MOVE    WRK-GEN-SRYCD   TO  WRK-SRYCD
      *            PERFORM 1002-JIDOUSET-SEC
      ******** END-IF
           END-IF
      *
      *    消化管で造影剤撮影の時、透視診断料の追加（撮影料の上に追加）
           IF     (FLG-BUIKBN          =   3  )   AND
                  (WRK-COM-INPUTCD (IDX-SAT)   =   "170002110" )
               MOVE    "170000310"         TO  WRK-SRYCD
               COMPUTE IDX-S               =   IDX-SAT    -    1
               MOVE    ZERO                TO  FLG-SATU
               PERFORM 1003-JIDOU-CHK-SEC
               PERFORM 1002-JIDOUSET-SEC
           END-IF
      *
           .
       100012-SINDAN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    加算料追加処理
      *****************************************************************
       1002-JIDOUSET-SEC              SECTION.
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
               MOVE    SPACE               TO  WRK-COM-GMNFLG (IDX-S)
           END-IF
           MOVE    LNK-ORCSC-SYORIFLG  TO  LNK-SC92-SYORIFLG
           MOVE    IDX-S               TO  LNK-SC92-GMN-IDX
           MOVE    LNK-ORCSC-PG        TO  LNK-SC92-PG
           MOVE    WRK-SRYCD           TO  LNK-SC92-SRYCD
           MOVE    LNK-ORCSC-NENREI    TO  LNK-SC92-NENREI
           MOVE    LNK-ORCSC-ROUJIN    TO  LNK-SC92-ROUJIN
           MOVE    LNK-ORCSC-LSTSRYKA  TO  LNK-SC92-LSTSRYKA
           MOVE    LNK-ORCSC-LSTSRYKAMEI   TO  LNK-SC92-LSTSRYKAMEI
           MOVE    LNK-ORCSC-TEISEI-AREA   TO  LNK-SC92-TEISEI-AREA
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
               GO      TO      1002-JIDOUSET-EXT
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
      *****ADD     1                   TO  WRK-GMN-MAX
      *
           MOVE    1                   TO  FLG-ADD
           .
       1002-JIDOUSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    自動加算　存在チェック加処理
      *****************************************************************
       1003-JIDOU-CHK-SEC        SECTION.
      *
      *    存在チェック
           MOVE    ZERO                TO  FLG-ARI
           MOVE    ZERO                TO  IDX-T
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL      (IDX1        >   SPA-MAX-LINE   )   OR
                              (FLG-ARI                 =   1    ) OR
                              (WRK-GMN-INPUTCD (IDX1)  =   SPACE )
               IF       WRK-COM-INPUTCD (IDX1) =   WRK-SRYCD
                    MOVE    IDX1           TO  IDX-T
                    MOVE    1              TO  FLG-ARI
               END-IF
               IF     (WRK-SRYCD               =    "170000510"   OR
                                                    "170000410" )  AND
                      (WRK-COM-INPUTCD (IDX1)  =    "170000510"   OR
                                                    "170000410" )
                    MOVE    IDX1           TO  IDX-T
                    MOVE    1              TO  FLG-ARI
               END-IF
           END-PERFORM
           .
       1003-JIDOU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    年齢加算追加処理（共通）
      *****************************************************************
       1007-NYUYOJI-SET-SEC            SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2        >   4       )   OR
                              (WRK-COM-AGEKSNSRYCD(IDX-SYU IDX2)
                                          =   SPACE  OR   ZERO )
               MOVE    WRK-COM-AGEKSNSRYCD (IDX-SYU IDX2)
                                               TO  WRK-SRYCD
               MOVE    IDX-SYU            TO   IDX-T
               MOVE    IDX-SYU            TO   IDX-S
               PERFORM 1003-JIDOU-CHK-SEC
      *        加算追加
               MOVE    3                   TO  FLG-SATU
               PERFORM 1002-JIDOUSET-SEC
               IF      FLG-ADD             =   1
                   MOVE    2                   TO  WRK-COM-SANFLG 
                                                           (IDX-S)
      *            撮影料の乳幼児加算の時、位置保存
                   IF      IDX-SYU             =   IDX-SAT
                       MOVE    IDX-S           TO  IDX-NYU
                   END-IF
                   MOVE    4                   TO  IDX2
               END-IF
           END-PERFORM
      *
           .
       1007-NYUYOJI-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    加算計算処理
      *****************************************************************
       10071-KASAN-KEI-SEC             SECTION.
      *
      *    逓減で基準不適合逓減区分以外はすでに計算
           IF     (WRK-COM-TENSIKIBETU(IDX-T)    =   6 )  AND
                  (WRK-COM-KIJUNTEIGENKBN(IDX-T) =   ZERO)
               GO      TO      10071-KASAN-KEI-EXT
           END-IF
      *
           MOVE    ZERO                TO  WRK-TENSUKEI-9
           MOVE    ZERO                TO  WRK-TENSUKEI-9G
           EVALUATE    WRK-COM-TENSIKIBETU(IDX-T)
      *        撮影料に加算するもの
               WHEN    5
                 IF      WRK-COM-SANFLG (IDX-T)  =   ZERO  OR  2
                   MOVE    ZERO                TO  WRK-TENSUKEIS
                   COMPUTE WRK-TENSUKEIS   =   WRK-COM-KISOTEN(IDX-SAT)
                                           *   WRK-COM-KISOTEN(IDX-T)
                                           /   100
                                           +   0.5
                   MOVE    WRK-TENSUKEIS       TO  WRK-TENSUKEI-9
                 END-IF
      *        基準不適合逓減区分
               WHEN    6
                   MOVE    ZERO                TO  WRK-TENSUKEIS
                   COMPUTE WRK-TENSUKEIS   =   WRK-COM-KISOTEN(IDX-SAT)
                                           *   WRK-COM-KISOTEN(IDX-T)
                                           /   100
      *************************************+   0.5
                   MOVE    WRK-TENSUKEIS       TO  WRK-TENSUKEI-9G
      *        その他の加算するもの
               WHEN    OTHER
                   MOVE    WRK-COM-KISOTEN (IDX-T) TO  WRK-TENSUKEI-9
           END-EVALUATE
      *
      *    計算済フラグ
           MOVE    1                   TO  WRK-COM-SANFLG (IDX-T)
      *
           COMPUTE WRK-TENSUKEI1       =   WRK-TENSUKEI1
                                       +   WRK-TENSUKEI-9
                                       -   WRK-TENSUKEI-9G
      *
           .
       10071-KASAN-KEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数計算編集処理
      *****************************************************************
       1002-TENSU-KEI-SEC                  SECTION.
      *
           MOVE    1                   TO  FLG-END
      *
           EVALUATE    FLG-SINDAN
               WHEN    1
      *            Ｘ線撮影料
                   PERFORM 10001-XSEN-SINDAN-SEC
               WHEN    2
      *            核医学診断料
                   PERFORM 10002-KZKU-SINDAN-SEC
               WHEN    3
      *            ＣＴ・ＭＲＩ診断料
                   PERFORM 10003-CTMRI-SINDAN-SEC
               WHEN    OTHER
      *            その他
                   PERFORM 10004-ETC-SINDAN-SEC
           END-EVALUATE
      *
      *    薬剤点数計算
           PERFORM 1004-SATU-ZAITENU-SEC
      *    特定器材点数計算
           PERFORM 1005-KIZAI-TENSU-SEC
      *
           COMPUTE LNK-SC90-TENSUKEI   =   WRK-TENSUKEI1
                                       +   WRK-TENSUKEI2
                                       +   WRK-TENSUKEI3
      *    各点数編集
           MOVE    LNK-SC90-TENSUKEI   TO  WRK-COM-SYUTEN1
                                                         (IDX-MAX)
      *    薬剤点数
           COMPUTE WRK-COM-YKZTEN (IDX-MAX)
                                       =   LNK-SC90-ZAITEN
                                       +   LNK-SC90-GAITEN
      *    器材点数
           COMPUTE WRK-COM-KIZAITEN(IDX-MAX)
                                       =   LNK-SC90-KIZTEN
                                       +   WRK-FIRTEN-KEI
      *
      *    点数計　計算
           COMPUTE WRK-COM-TENSU (IDX-MAX) =   LNK-SC90-TENSUKEI
                                           +   LNK-SC90-ZAITEN
                                           +   LNK-SC90-GAITEN
                                           +   LNK-SC90-KIZTEN
                                           +   WRK-FIRTEN-KEI
      *    計
           COMPUTE WRK-COM-KEI (IDX-MAX)   =   WRK-COM-TENSU  (IDX-MAX)
                                           *   LNK-ORCSC-KAISU
      *
           .
       1002-TENSU-KEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    核医学診断料作成処理
      *****************************************************************
       10002-KZKU-SINDAN-SEC           SECTION.
      *
      *    撮影料の再計算
           MOVE    ZERO                TO  WRK-TENSUKEI
           MOVE    ZERO                TO  WRK-KISOTEN-G
      *    枚数計算
           MOVE    ZERO                TO  WRK-KEIMAI
      *
           INITIALIZE                  ORCSC90AREA
           MOVE    ZERO                TO  IDX-MAX
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   SPA-MAX-LINE  )  OR
                              (WRK-GMN-INPUTCD(IDX-Z)  =   SPACE )
      *
               ADD     1                   TO  IDX-MAX
      *        明細計算
               PERFORM 100013-XSEN-KEI-SEC
      *
               IF      WRK-COM-INPUTCD (IDX-Z)(1:1)    =   "1"
                   IF      WRK-COM-DATAKBN (IDX-Z)     =   "1"
                       EVALUATE    WRK-COM-TNSSRYSYUKBN(IDX-Z)(1:2)
                           WHEN    "72"
      *                    撮影料編集
                               MOVE    ZERO                TO  FLG-SATU
                               PERFORM 100011-STATUEI-RYO-SEC
                           WHEN    "71"
      *                    診断料
                               MOVE    1                   TO  FLG-SATU
                               PERFORM 100011-STATUEI-RYO-SEC
      *                    その他
                           WHEN    OTHER
                               ADD     WRK-COM-KISOTEN(IDX-Z) 
                                                     TO  WRK-TENSUKEI3
                       END-EVALUATE
                   ELSE
                       IF      WRK-COM-SANFLG (IDX-Z) =   ZERO
      *                    加算項目
                           MOVE    IDX-Z           TO  IDX-T
                           PERFORM 10071-KASAN-KEI-SEC
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
      *    フィルム点数計算
           PERFORM 1006-FIRTEN-SET-SEC
      *
           .
       10002-KZKU-SINDAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＴ・ＭＲＩ診断料作成処理
      *****************************************************************
       10003-CTMRI-SINDAN-SEC           SECTION.
      *
      *    撮影料の再計算
           MOVE    ZERO                TO  WRK-TENSUKEI
      *    枚数計算
           MOVE    ZERO                TO  WRK-KEIMAI
      *
      *    造影剤使用加算料
           IF      FLG-ZOEIZAI         =   1
               IF      FLG-CTMRI           =   1
      *            ＣＴ加算
                   MOVE    "170012070"         TO  WRK-SRYCD
               ELSE
      *            ＭＩＲ加算
                   MOVE    "170020470"         TO  WRK-SRYCD
               END-IF
               MOVE    IDX-SAT             TO  IDX-S
               MOVE    ZERO                TO  FLG-SATU
               PERFORM 1003-JIDOU-CHK-SEC
               PERFORM 1002-JIDOUSET-SEC
           END-IF
      *
      *
           INITIALIZE                  ORCSC90AREA
           MOVE    ZERO                TO  IDX-MAX
           MOVE    ZERO                TO  IDX-KAS
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   SPA-MAX-LINE  )  OR
                              (WRK-GMN-INPUTCD(IDX-Z)  =   SPACE )
      *
               ADD     1                   TO  IDX-MAX
      *        明細計算
               PERFORM 100013-XSEN-KEI-SEC
      *
               IF      WRK-COM-INPUTCD (IDX-Z)(1:1)   =   "1"
                   IF      WRK-COM-DATAKBN (IDX-Z)    =   "1"
                       EVALUATE    WRK-COM-TNSSRYSYUKBN(IDX-Z)(1:2)
                           WHEN    "72"
      *                    撮影料編集
                               MOVE    ZERO                TO  FLG-SATU
                               PERFORM 100011-STATUEI-RYO-SEC
                           WHEN    "71"
      *                    診断料
                               MOVE    1                   TO  FLG-SATU
                               PERFORM 100011-STATUEI-RYO-SEC
      *                    その他
                           WHEN    OTHER
                               ADD     WRK-COM-KISOTEN(IDX-Z) 
                                                     TO  WRK-TENSUKEI3
                       END-EVALUATE
                   END-IF
      *            加算で定額加算の時の集計
                   IF      WRK-COM-DATAKBN (IDX-Z)     =   "2"
                       IF      WRK-COM-TENSIKIBETU(IDX-Z)  =   5
                           MOVE    IDX-Z               TO  IDX-KAS
                       ELSE
                           IF     (WRK-COM-SANFLG (IDX-Z)  =   ZERO  )
                             AND  (WRK-COM-TENSIKIBETU(IDX-Z)
                                                       NOT =   6)
                               ADD     WRK-COM-KISOTEN (IDX-Z)
                                                     TO  WRK-TENSUKEI1
                           END-IF
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
      *    撮影料に％加算する
           IF     (IDX-KAS                 >   ZERO  )  AND
                  (WRK-COM-TENSIKIBETU(IDX-KAS)    =   5 )
               COMPUTE WRK-TENSUKEI        =   WRK-TENSUKEI1
                                           *   WRK-COM-KISOTEN(IDX-KAS)
                                           /   100
                                           +   0.5
               MOVE    WRK-TENSUKEI        TO  WRK-TENSUKEI-9
      *        計算済フラグ
               MOVE    1                   TO  WRK-COM-SANFLG (IDX-KAS)
               COMPUTE WRK-TENSUKEI1       =   WRK-TENSUKEI1
                                           +   WRK-TENSUKEI-9
           END-IF
      *
      *    フィルム点数計算
           PERFORM 1006-FIRTEN-SET-SEC
      *
           .
       10003-CTMRI-SINDAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    その他影料終了処理
      *****************************************************************
       1004-ETC-END-SEC           SECTION.
      *
      *    フィルム点数計算
           PERFORM 1006-FIRTEN-SET-SEC
      *
           MOVE    ZERO                TO  LNK-SC90-BUNGSU
           MOVE    ZERO                TO  LNK-SC90-MAISU
      *    フィルム乳幼児加算領域クリア
           INITIALIZE                  WRK-NYUYOJI-AREA
           .
       1004-ETC-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    その他診断料作成処理
      *****************************************************************
       10004-ETC-SINDAN-SEC           SECTION.
      *    枚数計算
           MOVE    ZERO                TO  WRK-KEIMAI
      *
           INITIALIZE                  ORCSC90AREA
           MOVE    ZERO                TO  IDX-MAX
           PERFORM VARYING     IDX-Z   FROM    1       BY  1
                   UNTIL      (IDX-Z       >   SPA-MAX-LINE  )  OR
                              (WRK-GMN-INPUTCD(IDX-Z)  =   SPACE )
      *
               ADD     1                   TO  IDX-MAX
      *        明細計算
               PERFORM 100013-XSEN-KEI-SEC
      *
               IF      WRK-COM-INPUTCD (IDX-Z)(1:1)    =   "1"
                   IF      WRK-COM-DATAKBN (IDX-Z)     =   "1"
                       ADD     WRK-COM-KISOTEN(IDX-Z)
                                               TO  WRK-TENSUKEI3
                   ELSE
                       IF      WRK-COM-SANFLG (IDX-Z)  =   ZERO
      *                    加算項目
                           MOVE    IDX-Z           TO  IDX-T
                           PERFORM 10071-KASAN-KEI-SEC
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
      *
      *    フィルム点数計算
           PERFORM 1006-FIRTEN-SET-SEC
      *
           .
       10004-ETC-SINDAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    薬剤点数計算処理（映像診断）
      *****************************************************************
       1004-SATU-ZAITENU-SEC         SECTION.
      *
           COMPUTE WRK-SYOKEIS2        =   LNK-SC90-ZAIKEI
                                       +   LNK-SC90-GAIKEI
      *
           MOVE    ZERO                TO  LNK-SC90-ZAIKEI
           MOVE    ZERO                TO  LNK-SC90-GAIKEI
           MOVE    ZERO                TO  WRK-SYOKEIS3
      *
      * =============================================================
      *---// １日分の点数　15点以下 ⇒ 　ZERO                       //
      *-- // １日分の点数　15点超過 ⇒ （１日分の点数−5）/ 10 + 1 //
      *==============================================================
      *
           IF      WRK-SYOKEIS2        <=  15
               MOVE    ZERO            TO  WRK-SYOKEIS3
           ELSE
               COMPUTE WRK-SYOKEIS3    =  (WRK-SYOKEIS2    - 5 )
                                       /   10
           END-IF
      *
           COMPUTE LNK-SC90-ZAITEN     =   WRK-SYOKEIS3   + 0.999
      *
           .
       1004-SATU-ZAITENU-EXT.
           EXIT.
      *****************************************************************
      *    特定器材点数計算（映像診断）
      *****************************************************************
       1005-KIZAI-TENSU-SEC         SECTION.
      *
      *    金額計÷１０　四捨五入
           COMPUTE WRK-SYOKEIS2        =   LNK-SC90-KIZKEI
                                       /   10
                                       +   0.5
           MOVE    WRK-SYOKEIS2        TO  LNK-SC90-KIZTEN
      *
      *
           .
       1005-KIZAI-TENSU-EXT.
           EXIT.
      *
      *****************************************************************
      *    フィルム点数計算処理
      *****************************************************************
       1006-FIRTEN-SET-SEC             SECTION.
      *
      *    乳幼児加算の算定有無
           IF     (WRK-NYU-BUI         =   "1" )  AND
                  (WRK-NYU-CD          =   "1" )  AND
                  (WRK-NYU-FIR         =   "1" )  AND
                  (LNK-ORCSC-NENREI-YY <   6   )
               CONTINUE
           ELSE
      *        乳幼児加算なし
      *            フィルム合計点数
               COMPUTE WRK-TENSUKEIS       =  (WRK-NYU-TEN
                                           +   WRK-FIRTEN  )
                                           /   10
                                           +   0.5
               MOVE    WRK-TENSUKEIS       TO  WRK-TENSUKEI-G
               ADD     WRK-TENSUKEI-G      TO  WRK-FIRTEN-KEI
      *
               IF      FLG-END             =   ZERO
                   MOVE    ZERO                TO  WRK-NYU-TEN
                   MOVE    ZERO                TO  WRK-FIRTEN
               END-IF
      *
               GO      TO      1006-FIRTEN-SET-EXT
           END-IF
      *
      *    乳幼児加算あり
           MOVE    "799990070"         TO  WRK-SRYCD
           MOVE    ZERO                TO  IDX-S
      *
      *    自動加算　存在チェック＆挿入位置セット
           MOVE    ZERO                TO  FLG-ARI
           MOVE    ZERO                TO  WRK-IDX
           PERFORM VARYING     IDX1    FROM    IDX-HOZ  BY  1
                   UNTIL      (IDX1        >   SPA-MAX-LINE     )   OR
                              (WRK-GMN-INPUTCD (IDX1)  =   SPACE )
      *            フィルム判定
               IF     (WRK-COM-INPUTCD (IDX1)(1:1) =   "7"  OR
                       WRK-COM-INPUTCD(IDX-Z)(1:3) =   "059")  AND
                      (WRK-COM-DATAKBN (IDX1)      =   "3" )
                   MOVE    IDX1                TO  IDX-S
               END-IF
               IF      WRK-COM-INPUTCD (IDX1)  =   WRK-SRYCD
                   MOVE    IDX1                TO  IDX-T
                   MOVE    1                   TO  FLG-ARI
               END-IF
           END-PERFORM
      *
           MOVE    WRK-NYU-IDX         TO  IDX-S
           PERFORM 1002-JIDOUSET-SEC
           IF      FLG-ADD             =   1
               ADD     1                   TO  IDX-MAX
           END-IF
      *
      *    加算料編集
           IF      WRK-COM-TENSIKIBETU(IDX-S)  =   5
               COMPUTE WRK-TENSUKEIS       =   WRK-NYU-TEN
                                           *   WRK-COM-KISOTEN (IDX-S)
                                           /   100
                                           +   0.5
               MOVE    WRK-TENSUKEIS       TO  WRK-TENSUKEI-9
           ELSE
               MOVE    ZERO                TO  WRK-TENSUKEI-9
           END-IF
           COMPUTE WRK-TENSUKEI-9      =   WRK-NYU-TEN
                                       +   WRK-TENSUKEI-9
      *
      *    フィルム合計点数
           COMPUTE WRK-TENSUKEIS       =  (WRK-TENSUKEI-9
                                       +   WRK-FIRTEN  )
                                       /   10
                                       +   0.5
           MOVE    WRK-TENSUKEIS       TO  WRK-TENSUKEI-G
           ADD     WRK-TENSUKEI-G      TO  WRK-FIRTEN-KEI
      *
           IF      FLG-END             =   ZERO
               MOVE    ZERO                TO  WRK-NYU-TEN
               MOVE    ZERO                TO  WRK-FIRTEN
           END-IF
      *
           .
       1006-FIRTEN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    全診療行為チェック処理
      *****************************************************************
       200-ALL-SYORI-SEC                SECTION.
      *
           MOVE    ZERO                TO  FLG-JIKASAN
           MOVE    ZERO                TO  IDX-GAI
           MOVE    ZERO                TO  IDX-CT
      *
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   SPA-MAX-LINE     )   OR
                              (SPA-ERRCD           NOT =   SPACE )  OR
                              (WRK-GMN-INPUTCD (IDX-Z) =   SPACE )
      *        時間外緊急院内画像診断加算
               IF      WRK-COM-INPUTCD(IDX-Z)  =   "170016010"
                   MOVE    IDX-Z           TO  IDX-GAI
               END-IF
      *
      *        時間外加算チェック（診察、加算、時間加算のもの）
               IF     (WRK-COM-SRYKBN  (IDX-Z)     =   "11"  OR
                                                       "12"     ) AND
                      (WRK-COM-DATAKBN (IDX-Z)     =   "2"      ) AND
                      (WRK-COM-TIMEKSNKBN(IDX-Z)   NOT =   ZERO  AND
                                                           5    )
                   MOVE    1               TO  FLG-JIKASAN
               END-IF
      *
      *        ＣＴ．ＭＲＩの算定チェック
               IF      WRK-COM-KNSJISGRPKBN (IDX-Z)    =  32
                   PERFORM 2001-CTMRI-CHK-SEC
               END-IF
           END-PERFORM
      *
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      200-ALL-SYORI-EXT
           END-IF
      *
      *    時間外緊急院内画像診断加算有り
           IF      IDX-GAI             >   ZERO
               MOVE    IDX-GAI             TO  IDX-Z
               IF     (FLG-JIKASAN         =   ZERO         )  AND
                      (WRK-COM-KZMFLG (IDX-Z)  =   SPACE    )  AND
                      (LNK-ORCSC-TOROKU    NOT =   "2"   )
                   MOVE    "K001"              TO  SPA-ERRCD
                   MOVE    "2"                 TO  WRK-COM-CUR (IDX-Z)
                   MOVE    "1"                 TO  WRK-COM-KZMFLG
                                                              (IDX-Z)
                   GO      TO      200-ALL-SYORI-EXT
               END-IF
      *        時間入力追加
               MOVE    "840000071"         TO  WRK-SRYCD
               IF      WRK-COM-INPUTCD(IDX-Z + 1)  =   WRK-SRYCD
                   CONTINUE
               ELSE
                   MOVE    ZERO                TO  FLG-SATU
                   MOVE    IDX-Z               TO  IDX-S
                   PERFORM 1003-JIDOU-CHK-SEC
                   PERFORM 1002-JIDOUSET-SEC
               END-IF
           END-IF
      *
           .
       200-ALL-SYORI-EXT.
           EXIT.
      *        
      *****************************************************************
      *    ＣＴ．ＭＲＩの算定チェック処理
      *****************************************************************
       2001-CTMRI-CHK-SEC                SECTION.
      *
      *    算定履歴チェック
           INITIALIZE                      ORCSC91AREA
           MOVE    "3"                 TO  LNK-SC91-KBN
           MOVE    LNK-ORCSC-SYORIFLG  TO  LNK-SC91-SYORIFLG
           MOVE    WRK-COM-CHK-SRYCD (IDX-Z)
                                       TO  LNK-SC91-SRYCD
           MOVE    IDX-Z               TO  LNK-SC91-GMN-IDX
           MOVE    LNK-ORCSC-TEISEI-AREA   TO  LNK-SC91-TEISEI-AREA
           CALL    "ORCSC91"           USING
                                       MCPAREA
                                       ORCSC91AREA
                                       WRK-SCR-REC
                                       SPA-AREA
                                       TNS-TENSU-REC
           IF      LNK-SC91-ERRCD      =   "0001"
               MOVE    LNK-SC91-ERRCD      TO  SPA-ERRCD
               MOVE    "1"                 TO  WRK-COM-CUR (IDX-Z)
               GO      TO      2001-CTMRI-CHK-EXT
           END-IF
      *
      *    当月算定なし
           IF      LNK-SC91-CNT        =  ZERO
      *        ＣＴ．ＭＲＩの算定チェック
               IF      WRK-COM-INPUTCD (IDX-Z)     =   "170022290"  OR
                                                       "170022390"  OR
                                                       "170022490"  OR
                                                       "170701470"  OR
                                                       "170701570"  OR
                                                       "170701670"
                   IF     (WRK-COM-KZMFLG (IDX-Z)      =   SPACE ) AND 
                          (LNK-ORCSC-TOROKU        NOT =   "2"   )
                       MOVE    "K003"              TO  SPA-ERRCD
                       MOVE    "2"                 TO  WRK-COM-CUR
                                                               (IDX-Z)
                       MOVE    "1"                 TO  WRK-COM-KZMFLG
                                                               (IDX-Z)
                       MOVE    IDX-Z               TO  IDX-CT
                   END-IF
               END-IF
           ELSE
               IF      WRK-COM-INPUTCD (IDX-Z)     =   "170022290"  OR
                                                       "170022390"  OR
                                                       "170022490"  OR
                                                       "170701470"  OR
                                                       "170701570"  OR
                                                       "170701670"
                   CONTINUE
               ELSE
      *************MOVE    "0034"              TO  SPA-ERRCD
                   MOVE    "0078"              TO  SPA-ERRCD
                   MOVE    "1"                 TO  WRK-COM-CUR (IDX-Z)
                   MOVE    IDX-Z               TO  IDX-CT
                   MOVE    ZERO                TO  FLG-CHK
                   IF      LNK-SC91-CNT        =   1
      *                画面内にのみ存在する時、後をエラーとする 
                       PERFORM VARYING     IDX-Z2  FROM   IDX-Z   BY  1
                               UNTIL       IDX-Z2  >   SPA-MAX-LINE
                           IF     (IDX-Z2      NOT =   IDX-Z  )  AND
                                  (WRK-COM-CHK-SRYCD (IDX-Z2)
                                                   =  WRK-COM-CHK-SRYCD
                                                               (IDX-Z))
                               MOVE    1              TO  FLG-CHK
                               MOVE    SPA-MAX-LINE   TO  IDX-Z2
                           END-IF
                       END-PERFORM
                       IF      FLG-CHK             =   1
                           MOVE    SPACE           TO  SPA-ERRCD
                           MOVE    ZERO            TO  IDX-CT
                       END-IF
                   END-IF
                   IF      IDX-CT          NOT =   ZERO
                       MOVE    "1"                 TO  WRK-COM-CUR
                                                              (IDX-Z)
                   END-IF
               END-IF
           END-IF
           .
      *
       2001-CTMRI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自動算定処理
      *****************************************************************
       300-AUTO-SYORI-SEC                SECTION.
      *
      *2001.3.21  自動算定を保留事項とする
           GO      TO      300-AUTO-SYORI-EXT.
      *
      *
           MOVE    ZERO                TO  FLG-CTMRI
           MOVE    ZERO                TO  FLG-XSEN
           MOVE    ZERO                TO  FLG-KAKUI
      *
           PERFORM VARYING     IDX-Z   FROM    1   BY  1
                   UNTIL      (IDX-Z       >   SPA-MAX-LINE     )   OR
                              (SPA-ERRCD           NOT =   SPACE )  OR
                              (WRK-GMN-INPUTCD (IDX-Z) =   SPACE )
      *
      *        Ｘ線有り
               IF      WRK-COM-TNSSRYSYUKBN(IDX-Z) =   "721"
                   MOVE    1                       TO  FLG-XSEN
               END-IF
      *
      *        検査等実施判定グループ
               EVALUATE    WRK-COM-KNSJISGRPKBN (IDX-Z)
      *            核医学
                   WHEN    31
                       MOVE    1                   TO  FLG-KAKUI
      *            コンピュータ
                   WHEN    32
                       IF      WRK-COM-TNSSRYSYUKBN(IDX-Z)   =   "710"
      *                    他医撮影
                           MOVE    2                   TO  FLG-CTMRI
                       ELSE
                           MOVE    1                   TO  FLG-CTMRI
                       END-IF
               END-EVALUATE
           END-PERFORM
      *
      *
           MOVE    ZERO                TO  IDXS
      *
      *    画像診断管理加算追加（写真診断）
           IF      FLG-XSEN            =   1
               MOVE    "170020270"         TO  WRK-SRYCD
               MOVE    SPACE               TO  WRK-SRYCD-2
               PERFORM 3002-KASAN-SYORI-SEC
               IF      FLG-ERR             =   ZERO
                   MOVE    "700"           TO  LNK-ORCSC-SRYSYUKBN
                                                         (08 IDXS)
                   MOVE    "70"            TO  LNK-ORCSC-SRYKBN
                                                         (08 IDXS)
               END-IF
           END-IF
      *
      *    核医学診断料加算有り
           IF      FLG-KAKUI           =   1
      *        核医学診断料加算
               MOVE    "170015310"         TO  WRK-SRYCD
               MOVE    SPACE               TO  WRK-SRYCD-2
               PERFORM 3002-KASAN-SYORI-SEC
               IF      FLG-ERR             =   ZERO
                   MOVE    "700"           TO  LNK-ORCSC-SRYSYUKBN
                                                         (08 IDXS)
                   MOVE    "70"            TO  LNK-ORCSC-SRYKBN
                                                         (08 IDXS)
               END-IF
      *        画像診断管理加算（核医学）
               MOVE    "170021370"         TO  WRK-SRYCD
               MOVE    SPACE               TO  WRK-SRYCD-2
               PERFORM 3002-KASAN-SYORI-SEC
               IF      FLG-ERR             =   ZERO
                   MOVE    "700"           TO  LNK-ORCSC-SRYSYUKBN
                                                         (08 IDXS)
                   MOVE    "70"            TO  LNK-ORCSC-SRYKBN
                                                         (08 IDXS)
               END-IF
           END-IF
      *
      *    コンピュータ診断料加算有り
           IF      FLG-CTMRI           =   1
      *        コンピュータ診断料加算有り
               IF      LNK-ORCSC-ROUJIN    =   ZERO
                   MOVE    "170015410"         TO  WRK-SRYCD
                   MOVE    SPACE               TO  WRK-SRYCD-2
               ELSE
                   MOVE    "170700710"         TO  WRK-SRYCD
                   MOVE    SPACE               TO  WRK-SRYCD-2
               END-IF
               PERFORM 3002-KASAN-SYORI-SEC
               IF      FLG-ERR             =   ZERO
                   MOVE    "700"           TO  LNK-ORCSC-SRYSYUKBN
                                                         (08 IDXS)
                   MOVE    "70"            TO  LNK-ORCSC-SRYKBN
                                                         (08 IDXS)
               END-IF
      *        画像診断管理加算（コンピュータ診断）
               IF      LNK-ORCSC-ROUJIN    =   ZERO
                   MOVE    "170021470"         TO  WRK-SRYCD
                   MOVE    SPACE               TO  WRK-SRYCD-2
               ELSE
                   MOVE    "170701270"         TO  WRK-SRYCD
                   MOVE    SPACE               TO  WRK-SRYCD-2
               END-IF
               PERFORM 3002-KASAN-SYORI-SEC
               IF      FLG-ERR             =   ZERO
                   MOVE    "700"           TO  LNK-ORCSC-SRYSYUKBN
                                                         (08 IDXS)
                   MOVE    "70"            TO  LNK-ORCSC-SRYKBN
                                                         (08 IDXS)
               END-IF
           END-IF
      *
      *    他医コンピュータ診断料加算有り
           IF      FLG-CTMRI           =   2
               MOVE    "170019950"         TO  WRK-SRYCD
               MOVE    SPACE               TO  WRK-SRYCD-2
               PERFORM 3002-KASAN-SYORI-SEC
               IF      FLG-ERR             =   ZERO
                   MOVE    "700"           TO  LNK-ORCSC-SRYSYUKBN
                                                         (08 IDXS)
                   MOVE    "70"            TO  LNK-ORCSC-SRYKBN
                                                         (08 IDXS)
               END-IF
      *        画像診断管理加算（他医コンピュータ診断）
               MOVE    "170021470"         TO  WRK-SRYCD
               MOVE    SPACE               TO  WRK-SRYCD-2
               PERFORM 3002-KASAN-SYORI-SEC
               IF      FLG-ERR             =   ZERO
                   MOVE    "700"           TO  LNK-ORCSC-SRYSYUKBN
                                                         (08 IDXS)
                   MOVE    "70"            TO  LNK-ORCSC-SRYKBN
                                                         (08 IDXS)
               END-IF
           END-IF
           .
      *
       300-AUTO-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    加算料算定処理
      *****************************************************************
       3002-KASAN-SYORI-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-ERR
      *
      *    今回入力にないこと
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   SPA-MAX-LINE  )  OR
                              (FLG-ERR              =   1    )   OR
                              (WRK-GMN-INPUTCD(IDX) =   SPACE)
               IF      WRK-COM-INPUTCD(IDX)    =   WRK-SRYCD
                   MOVE    1                   TO  FLG-ERR
               END-IF
           END-PERFORM
           IF      FLG-ERR             =   1
               GO      TO      3002-KASAN-SYORI-EXT
           END-IF
      *
           MOVE    WRK-SRYCD           TO  TNS-SRYCD
           PERFORM 910-TENSU-READ-SEC
           IF      FLG-TENSU       NOT =   ZERO
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    1                   TO  FLG-ERR
               GO      TO      3002-KASAN-SYORI-EXT
           END-IF
      *
      *        算定履歴チェック処理
           IF      TNS-SANTEIRRKKBN    NOT =   ZERO
               PERFORM 3001-SANTEI-CHK-SEC
           END-IF
           IF      FLG-ERR             =   ZERO
               ADD     1               TO  IDXS
               MOVE    WRK-SRYCD       TO  LNK-ORCSC-SRYCD
                                                   (08 IDXS)
               MOVE    TNS-TEN         TO  LNK-ORCSC-TENSU
                                                   (08 IDXS)
      *
      *        加算料算定
               IF      WRK-SRYCD-2     NOT =   SPACE
                   MOVE    WRK-SRYCD-2         TO  TNS-SRYCD
                   PERFORM 910-TENSU-READ-SEC
                   IF      FLG-TENSU       =   ZERO
      *                算定履歴チェック処理
                       IF      TNS-SANTEIRRKKBN    NOT =   ZERO
                           PERFORM 3001-SANTEI-CHK-SEC
                           IF      FLG-ERR             =   ZERO
                               MOVE    WRK-SRYCD-2
                                               TO  LNK-ORCSC-SRYCD-KS
                                                              (08 IDXS)
                               MOVE    TNS-TEN TO  LNK-ORCSC-TENSU-KS
                                                             (08 IDXS)
                           END-IF
                       END-IF 
                    END-IF
                    MOVE    ZERO           TO  FLG-ERR
                END-IF
           END-IF
      *
           .
       3002-KASAN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定履歴チェック処理
      *****************************************************************
       3001-SANTEI-CHK-SEC         SECTION.
      *
           INITIALIZE                      ORCSC91AREA
           MOVE    "2"                 TO  LNK-SC91-KBN
           MOVE    LNK-ORCSC-SYORIFLG  TO  LNK-SC91-SYORIFLG
           MOVE    WRK-SRYCD           TO  LNK-SC91-SRYCD
           MOVE    LNK-ORCSC-TEISEI-AREA   TO  LNK-SC91-TEISEI-AREA
           CALL    "ORCSC91"       USING
                                       MCPAREA
                                       ORCSC91AREA
                                       WRK-SCR-REC
                                       SPA-AREA
                                       TNS-TENSU-REC
      *
           IF      LNK-SC91-ERRCD      =   SPACE
      *        追加あり
               MOVE    ZERO            TO  FLG-ERR
           ELSE
      *        追加なし
               MOVE    1               TO  FLG-ERR
           END-IF
      *
           .
       3001-SANTEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    SPA-SRYYMD          TO  TNS-YUKOSTYMD
           MOVE    SPA-SRYYMD          TO  TNS-YUKOEDYMD
      *
           MOVE    SPA-HOSPNUM         TO  TNS-HOSPNUM
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_tensu"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
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
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクロース処理
      *****************************************************************
       990-DBCLOSE-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
      *
