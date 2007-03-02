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
       IDENTIFICATION                            DIVISION.
       PROGRAM-ID.                               ORCGW21.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 病室管理
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/08/20    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 00.00.01     NACL−太田   02/11/29  有効開始日を基準にシス管の
      *                                     情報を取得するよう修正
      * 00.00.02     NACL−太田   03/01/29  有効開始日のチェック追加
      *                                     入院中患者チェック追加
      * 00.00.03     NACL-太田    03/06/10  重症者等療養環境特別加算、
      *                                     無菌治療室管理加算を追加
      * 01.00.01     NACL-太田    03.11.17  更新日付編集対応
      *****************************************************************
      *
       ENVIRONMENT                               DIVISION.
       CONFIGURATION                             SECTION.
       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
      *    コンスタント値
           COPY    "ENUM-VALUE".
      *
      *    画面用ＳＰＡ
           COPY    "W20SCR-SPA".
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-NYUKHN                          PIC 9(01).
           03  FLG-ENTRYCHK                        PIC 9(01).
           03  FLG-BRM-NUM                         PIC 9(01).
           03  FLG-KIKAN-DABURI                    PIC 9(01).
           03  FLG-UPD-KBN                         PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-DBRC                            PIC 9(01).
           03  FLG-PTNYUINRRK                      PIC 9(01).
           03  FLG-SYS5002                         PIC 9(01).
           03  FLG-TARGET                          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDX4                                PIC 9(05).
           03  IDX-CMB                             PIC 9(05).
           03  IDX-BRMLST                          PIC 9(05).
           03  FLG-INPUT-AREA                      PIC 9(01).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MCP-WIDGET                      PIC X(64). 
           03  WRK-WIDMSG                          PIC X(70). 
           03  WRK-MAX                             PIC 9(05).
           03  WRK-YMD                             PIC X(10). 
           03  WRK-SYMD.
               05  WRK-SYY                         PIC 9(04).
               05  WRK-SMM                         PIC 9(02).
               05  WRK-SDD                         PIC 9(02).
           03  WRK-HENYMDG                         PIC X(09).
           03  WRK-KANACHK-INPUT               PIC X(400).
           03  WRK-SYS5002-KBNCD.
               05  WRK-SYS5002-BTUNUM             PIC X(02).
               05  WRK-SYS5002-BRMNUM             PIC X(06).
           03  WRK-ZZZ9                            PIC ZZZ9.
           03  WRK-ZZZZ9                           PIC ZZZZ9.
           03  WRK-99999                           PIC 9(05).
           03  WRK-999999                          PIC 9(06).
           03  WRK-ZZZZZ9                          PIC Z(5)9.
           03  WRK-ZZZZZZZZZ9                      PIC Z(9)9.
           03  WRK-CMB-CD                          PIC X(10).
           03  WRK-CMB-ITM-G.
               05  WRK-CMB-ITM                     PIC X(200).
               05  WRK-CMB-ITM2                    PIC X(200).
               05  WRK-CMB-ITM3                    PIC X(200).
               05  WRK-CMB-ITM4                    PIC X(200).
               05  WRK-CMB-ITM5                    PIC X(200).
           03  WRK-KJNYMD                          PIC X(08).
           03  WRK-STR1                            PIC X(20).
           03  WRK-STR2                            PIC X(20).
           03  WRK-IDX1                            PIC 9(05).
           03  WRK-IDX2                            PIC 9(05).
           03  WRK-IDX3                            PIC 9(05).
           03  WRK-BRMNUM                          PIC X(06).
           03  WRK-BRMNUM-KEY                      PIC X(06).
           03  WRK-BRMNUM-IN                       PIC X(06).
           03  WRK-BRMNUM-OT                       PIC X(06).
           03  WRK-SELNUM                          PIC 9(05).
           03  WRK-TOKNYUIN                        PIC X(02).
           03  WRK-KHNSRYCD                        PIC X(09).
           03  WRK-KJN-YUKSTYMD                    PIC X(08).
           03  WRK-BTU-YUKSTYMD                    PIC X(08).
           03  WRK-YUKOSTYMD                       PIC X(08).
           03  WRK-YUKOEDYMD                       PIC X(08).
           03  WRK-TNSYMD                          PIC X(08).
           03  WRK-TNSSRYCD                        PIC X(09).
           03  WRK-HEN-SAGAKU.
               05  WRK-HEN-SAGAKU-Z9               PIC ZZZZ9.
               05  WRK-HEN-SAGAKU-EN               PIC X(02).
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-H180401           PIC X(08) VALUE "20060401".
           03  CONST-H180701           PIC X(08) VALUE "20060701".
           03  CONST-SINSEIJI          PIC X(09) VALUE "190109770".
           03  CONST-SNR-RYOYO-VAL.
               05                      PIC X(09) VALUE "190106370".
               05                      PIC X(09) VALUE "190106470".
           03  CONST-SNR-RYOYO-R REDEFINES   CONST-SNR-RYOYO-VAL.
               05  CONST-SNR-RYOYO
                                       PIC X(09) OCCURS 2.
           03  CONST-HOSYASEN          PIC X(09) VALUE "190106670".
           03  CONST-RYOYO             PIC X(09) VALUE "190105570".
           03  CONST-BTU-RYOYO-VAL.
               05                      PIC X(09) VALUE "190106070".
               05                      PIC X(09) VALUE "190106170".
               05                      PIC X(09) VALUE "190106270".
           03  CONST-BTU-RYOYO-R   REDEFINES   CONST-BTU-RYOYO-VAL.
               05  CONST-BTU-RYOYO     PIC X(09) OCCURS 3.
           03  CONST-BTU-RYOYO-H18     PIC X(09) VALUE "190120210".
           03  CONST-JYUTOK1           PIC X(09) VALUE "190105870".
           03  CONST-JYUTOK2           PIC X(09) VALUE "190105970".
           03  CONST-MUKIN             PIC X(09) VALUE "190106570".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    病棟管理
           COPY  "CPSK5001.INC".
      *    病室管理
           COPY  "CPSK5002.INC".
      *    診療科コード
           COPY  "CPSK1005.INC".
      *    病室種別
           COPY  "CPSK5108.INC".
      *    特定入院料（病棟）
           COPY  "CPSK5110.INC".
      *    特定入院料（病室）
           COPY  "CPSK5111.INC".
      *    室料差額
           COPY  "CPSK5113.INC".
      *    性別特定
           COPY  "CPSK5109.INC".
      *    点数マスタ
           COPY  "CPTENSU.INC".
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY  "CPPTNYUINRRK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    画面日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    病室名編集
           COPY    "CPORCSBRMNUM.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    部分一致文字列編集
           COPY    "CPORCSADDSIGN.INC".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "W01.INC".
           COPY    "W02.INC".
           COPY    "W03.INC".
           COPY    "W04.INC".
           COPY    "W05.INC".
           COPY    "W06.INC".
           COPY    "W07.INC". 
           COPY    "W08.INC". 
           COPY    "W09.INC".
           COPY    "W10.INC".
           COPY    "W11.INC".
           COPY    "W111.INC".
           COPY    "W12.INC".
           COPY    "W121.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W16.INC".
           COPY    "W17.INC".
           COPY    "W18.INC".
           COPY    "W19.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W28.INC".
           COPY    "W29.INC".
           COPY    "W30.INC".
           COPY    "W31.INC".
           COPY    "W32.INC".
           COPY    "W60.INC".
           COPY    "W61.INC".
           COPY    "W62.INC".
           COPY    "W63.INC".
           COPY    "W98.INC".
           COPY    "W981.INC".
           COPY    "W97.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
           COPY    "WID2.INC".
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W20FREE
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS  ALSO    MCP-EVENT
           WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
           WHEN    "PUTG"          ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
           WHEN    OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF    ( FLG-END         =   ZERO )
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-W20FREE     TO  SPA-FREE
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK 
           MOVE    SPA-AREA        TO  SPA-COMMON
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    エラー画面より
           IF    ( SPA-MOTOPG      =   "WERR" )
               MOVE    SPA-GMN-W21-MOTOPG
                                       TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF    ( FLG-END         =   1 )
                   GO  TO  100-INIT-EXT
               END-IF 
      *
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
           MOVE    "W21    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
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
               MOVE    LNK-KYOUTU      TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "W20"
               IF    ( SPA-MOTOPG2     =   "W21" )
                   MOVE    "W01"       TO  SPA-MOTOPG
                   MOVE    SPACE       TO  SPA-MOTOPG2
                                           SPA-MOTOPG3
      *
      *            病棟情報取得処理
                   PERFORM 3101-SYS-5001-GET-SEC
                   MOVE    SPA-GMN-W21-BTUNUM
                                       TO  WRK-CMB-CD
                   PERFORM 4200-BTUNUMLST-CHK-SEC
                   IF    ( WRK-CMB-ITM =   SPACE )
                       GO  TO  300-SCREEN-EXT
                   END-IF
      *
                   MOVE    WRK-CMB-ITM     TO  SPA-GMN-W21-BTUNUM-G
                   MOVE    WRK-CMB-ITM2    TO  WRK-TOKNYUIN
                   MOVE    WRK-CMB-ITM3    TO  WRK-KHNSRYCD
                   MOVE    WRK-CMB-ITM4    TO  WRK-BTU-YUKSTYMD
                   MOVE    WRK-CMB-ITM5    TO  SPA-NAI-W21-BTUSBT
      *
      *            入院基本料編集処理
                   PERFORM 3101-BTU-KHNRYO-EDIT-SEC
      *
                   GO  TO  300-SCREEN-EXT
               ELSE
                   PERFORM 310-SPASET-SEC
      *            病棟情報設定処理
                   PERFORM 310-BTU-SET-SEC
                   GO  TO  300-SCREEN-EXT
               END-IF
           WHEN    "WID1"
               MOVE    SPA-GMN-W21-MOTOPG
                                       TO  SPA-MOTOPG
               PERFORM 330-WID1-SET-SEC
               GO  TO      300-SCREEN-EXT
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
           INITIALIZE              SPA-W21-AREA
      *
      *    病棟情報取得処理
           PERFORM 3101-SYS-5001-GET-SEC
      *
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           MOVE    1               TO  SPA-GMN-W21-CUR
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟名称設定処理（病棟画面より遷移時）
      *****************************************************************
       310-BTU-SET-SEC                 SECTION.
      *
      *    クリア処理
           PERFORM 420-CLEAR-SEC
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-W20-W21-BTUNUM
                                   TO  WRK-CMB-CD
           PERFORM 4200-BTUNUMLST-CHK-SEC
           IF    ( WRK-CMB-ITM   =   SPACE )
               GO  TO  310-BTU-SET-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W21-BTUNUM-G
           MOVE    WRK-CMB-ITM2    TO  WRK-TOKNYUIN
           MOVE    WRK-CMB-ITM3    TO  WRK-KHNSRYCD
           MOVE    WRK-CMB-ITM4    TO  WRK-BTU-YUKSTYMD
           MOVE    WRK-CMB-ITM5    TO  SPA-NAI-W21-BTUSBT
      *
      *    入院基本料編集処理
           PERFORM 3101-BTU-KHNRYO-EDIT-SEC
      *
      *    病室管理情報検索（病室リストに表示）
           PERFORM 3101-SYS-5002-GET-SEC
      *
           IF    ( SPA-GMN-W21-BRMLST-MAX  >   ZERO )
               MOVE    2           TO  SPA-GMN-W21-CUR
           ELSE
               MOVE    3           TO  SPA-GMN-W21-CUR
           END-IF
      *
           .
       310-BTU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院基本料編集処理
      *****************************************************************
       3101-BTU-KHNRYO-EDIT-SEC    SECTION.
      *
           IF    ( WRK-TOKNYUIN    =   SPACE )
               MOVE    WRK-KHNSRYCD        TO  WRK-TNSSRYCD
               MOVE    WRK-BTU-YUKSTYMD    TO  WRK-TNSYMD
               PERFORM 900-TENSU-KEY-SEL-SEC
               MOVE    TNS-NAME        TO  SPA-GMN-W21-BTUKHNRYO
           ELSE
      *
               INITIALIZE                  SYSKANRI-REC
               MOVE    "5110"          TO  SYS-KANRICD
               MOVE    WRK-TOKNYUIN    TO  SYS-KBNCD
               MOVE    WRK-BTU-YUKSTYMD
                                       TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
               PERFORM 900-SYSKANRI-KEY10-SEL-SEC
               MOVE    SYSKANRI-REC     TO  SYS-5110-REC
               MOVE    SYS-5110-BTU-TOKUTEINYUIN-NM
                                        TO  SPA-GMN-W21-BTUKHNRYO
      *
           END-IF
      *
           .
       3101-BTU-KHNRYO-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    コンボボックス初期処理（病棟コンボを除く）
      *****************************************************************
       3101-CMB-SYOKI-SEC          SECTION.
      *
      *    診療科コード取得処理
           PERFORM 3101-SYS-1005-GET-SEC
      *
      *    病室種別取得処理
           PERFORM 3101-SYS-5108-GET-SEC
      *
      *    特定入院料（病室）取得処理
           PERFORM 3101-SYS-5111-GET-SEC
      *
      *    室料差額取得処理
           PERFORM 3101-SYS-5113-GET-SEC
      *
      *    性別特定取得処理
           PERFORM 3101-SYS-5109-GET-SEC
      *
           IF    ( SPA-NAI-W21-YUKOSTYMD  >=   CONST-H180701 )
            AND  ( SPA-NAI-W21-BTUSBT      =   "04" OR "09" )
      *        入院基本料コンボ設定処理
               PERFORM 3101-KHNRYO-GET-SEC
           END-IF
      *
           .
       3101-CMB-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟情報取得処理
      *****************************************************************
       3101-SYS-5001-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-BTUNUMLST-G
                       SPA-NAI-W21-BTUINFLST-G
      *
      *    システム管理マスタ検索処理
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    SPA-SYSYMD      TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-5001-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI        NOT =   ZERO )
                    OR   ( SPA-GMN-W21-BTUNUM-MAX >=   50 )
      *
               COMPUTE SPA-GMN-W21-BTUNUM-MAX
                   =   SPA-GMN-W21-BTUNUM-MAX  +   1
      *
               MOVE    SPA-GMN-W21-BTUNUM-MAX
                                   TO  IDX1
      *
               MOVE    SYS-5001-KBNCD
                                   TO  SPA-GMN-W21-BTUNUML (IDX1)
               MOVE    SYS-5001-BTU-NAME
                                   TO  SPA-GMN-W21-BTUNUMMEIL    (IDX1)
               MOVE    SYS-5001-BTU-TOKTEI-NYUIN
                                   TO  SPA-NAI-W21-BTUINF-TOKNYUIN
                                                                 (IDX1)
               MOVE    SYS-5001-BTU-KHNSRYCD
                                   TO  SPA-NAI-W21-BTUINF-KHNSRYCD
                                                                 (IDX1)
               MOVE    SYS-5001-STYUKYMD
                                   TO  SPA-NAI-W21-BTUINF-STYUKYMD
                                                                 (IDX1)
               MOVE    SYS-5001-BTU-SBT
                                   TO  SPA-NAI-W21-BTUINF-SBT    (IDX1)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC    TO  SYS-5001-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-SYS-5001-GET-EXT.
           EXIT.
      *****************************************************************
      *    診療科コード取得処理
      *****************************************************************
       3101-SYS-1005-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-SRYKALST-G
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "1005"              TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-1005-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( SPA-GMN-W21-SRYKA-MAX   >=  99 )
      *
               COMPUTE SPA-GMN-W21-SRYKA-MAX
                   =   SPA-GMN-W21-SRYKA-MAX   +   1
               MOVE    SPA-GMN-W21-SRYKA-MAX
                                       TO  IDX1
               MOVE    SYS-1005-KBNCD
                                   TO  SPA-GMN-W21-SRYKAL (IDX1)
               MOVE    SYS-1005-SRYKANAME
                                   TO  SPA-GMN-W21-SRYKAMEIL (IDX1)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC        TO  SYS-1005-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-SYS-1005-GET-EXT.
           EXIT.
      *****************************************************************
      *    病室種別取得処理
      *****************************************************************
       3101-SYS-5108-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-SBTLST-G
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5108"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-5108-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( SPA-GMN-W21-SBT-MAX >=  15 )
      *
               COMPUTE SPA-GMN-W21-SBT-MAX
                   =   SPA-GMN-W21-SBT-MAX +   1
               MOVE    SPA-GMN-W21-SBT-MAX
                                   TO  IDX1
      *
               MOVE    SYS-5108-KBNCD
                                   TO  SPA-GMN-W21-SBTL   (IDX1)
               MOVE    SYS-5108-BRM-SBT-NM
                                   TO  SPA-GMN-W21-SBTMEIL(IDX1)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC    TO  SYS-5108-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-SYS-5108-GET-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料取得処理
      *****************************************************************
       3101-SYS-5111-GET-SEC       SECTION.
      *
           INITIALIZE              SPA-GMN-W21-TOKNYUINLST-G
                                   SPA-NAI-W21-TOKNYUINLST-G
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5111"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-5111-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( SPA-GMN-W21-TOKNYUIN-MAX >=  30 )
      *
               IF    ( SYS-5111-BRM-NYUINRYOKBN    =  "01"  )
                AND  ( SYS-5111-SEIKATU-RYOKBN     =  SPACE )
                   COMPUTE SPA-GMN-W21-TOKNYUIN-MAX
                       =   SPA-GMN-W21-TOKNYUIN-MAX    +   1
                   MOVE    SPA-GMN-W21-TOKNYUIN-MAX
                                       TO  IDX1
      *
                   MOVE    SYS-5111-KBNCD
                                       TO  SPA-GMN-W21-TOKNYUINL(IDX1)
                   MOVE    SYS-5111-BRM-TOKUTEINYUIN-NM
                                       TO  SPA-GMN-W21-TOKNYUINMEIL
                                                                (IDX1)
                   MOVE    SYS-5111-BRM-TOKUTEINYUIN-NM2
                                       TO  SPA-NAI-W21-TOKNYUINL(IDX1)
               END-IF
      *
      *        システム管理マスタ読込処理
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC    TO  SYS-5111-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-SYS-5111-GET-EXT.
           EXIT.
      *****************************************************************
      *    室料差額取得処理
      *****************************************************************
       3101-SYS-5113-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-SAGAKULST-G
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5113"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-5113-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( SPA-GMN-W21-SAGAKU-MAX  >=  30 )
      *
               COMPUTE SPA-GMN-W21-SAGAKU-MAX
                   =   SPA-GMN-W21-SAGAKU-MAX  +   1
               MOVE    SPA-GMN-W21-SAGAKU-MAX
                                   TO  IDX1
      *
               MOVE    SYS-5113-KBNCD
                                   TO  SPA-GMN-W21-SAGAKUL (IDX1)
               MOVE    SYS-5113-BRM-SAGAKU-NM
                                   TO  WRK-99999
               INITIALIZE          WRK-HEN-SAGAKU
               MOVE    WRK-99999   TO  WRK-HEN-SAGAKU-Z9
               MOVE    "円"        TO  WRK-HEN-SAGAKU-EN
               MOVE    WRK-HEN-SAGAKU
                                   TO  SPA-GMN-W21-SAGAKUMEIL (IDX1)
      *
      *        システム管理マスタ読込処理
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC    TO  SYS-5113-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-SYS-5113-GET-EXT.
           EXIT.
      *****************************************************************
      *    性別特定取得処理
      *****************************************************************
       3101-SYS-5109-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-SEXLST-G
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5109"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-5109-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
                    OR   ( SPA-GMN-W21-SEX-MAX >=  10 )
      *
               COMPUTE SPA-GMN-W21-SEX-MAX
                   =   SPA-GMN-W21-SEX-MAX +   1
               MOVE    SPA-GMN-W21-SEX-MAX
                                   TO  IDX1
      *
               MOVE    SYS-5109-KBNCD
                                   TO  SPA-GMN-W21-SEXL (IDX1)
               MOVE    SYS-5109-BRM-SEX-NM
                                   TO  SPA-GMN-W21-SEXMEIL (IDX1)
      *
      *        システム管理マスタ読込処理
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC    TO  SYS-5109-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-SYS-5109-GET-EXT.
           EXIT.
      *****************************************************************
      *    入院料取得処理
      *****************************************************************
       3101-KHNRYO-GET-SEC           SECTION.
      *
           INITIALIZE                SPA-GMN-W21-KHNRYOLST-G
                                     SPA-NAI-W21-KHNRYOLST-G
      *
      *
           INITIALIZE                  SYSKANRI-REC
           MOVE    "5111"          TO  SYS-KANRICD
           MOVE    WRK-KJN-YUKSTYMD    TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-5111-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
      *
               MOVE    ZERO        TO  FLG-TARGET
      *
               IF    ( SPA-NAI-W21-BTUSBT          =   "04" )
                AND  ( SYS-5111-BRM-NYUINRYOKBN    =   "05" )
                AND  ( SYS-5111-SEIKATU-RYOKBN     =   SPACE )
                   MOVE    1       TO  FLG-TARGET
               END-IF
      *
               IF    ( SPA-NAI-W21-BTUSBT          =   "09" )
                AND  ( SYS-5111-BRM-NYUINRYOKBN    =   "06" )
                AND  ( SYS-5111-SEIKATU-RYOKBN     =   SPACE )
                   MOVE    1       TO  FLG-TARGET
               END-IF
      *
               IF    ( FLG-TARGET          =   1 )
                   COMPUTE SPA-GMN-W21-KHNRYO-MAX
                       =   SPA-GMN-W21-KHNRYO-MAX    +   1
                   MOVE    SPA-GMN-W21-KHNRYO-MAX
                                       TO  IDX1
      *
                   MOVE    SYS-5111-KBNCD
                                       TO  SPA-GMN-W21-KHNRYOL(IDX1)
                   MOVE    SYS-5111-BRM-TOKUTEINYUIN-NM
                                       TO  SPA-GMN-W21-KHNRYOMEIL
                                                                (IDX1)
                   MOVE    SYS-5111-SRYCD
                                       TO  SPA-NAI-W21-KHNRYOL(IDX1)
               END-IF
      *
      *        システム管理マスタ読込処理
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC    TO  SYS-5111-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       3101-KHNRYO-GET-EXT.
           EXIT.
      *****************************************************************
      *    病室管理情報検索処理
      *****************************************************************
       3101-SYS-5002-GET-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-BRMLST
      *
           INITIALIZE  SYSKANRI-REC
           MOVE    "5002"          TO  SYS-KANRICD
           MOVE    SPA-GMN-W21-BTUNUM
                                   TO  SYS-KBNCD
           INITIALIZE                  ORCSADDSIGNAREA
           MOVE    SPA-GMN-W21-BTUNUM
                                   TO  SADDSIGN-STR
           CALL    "ORCSADDSIGN"       USING   ORCSADDSIGNAREA
           MOVE    SADDSIGN-STR    TO  SYS-KBNCD
           MOVE    SPA-SYSYMD      TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY9-SEL-SEC
           MOVE    MCPDATA-REC     TO  SYS-5002-REC
           MOVE    FLG-SYSKANRI    TO  FLG-SYS5002
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYS5002 NOT =   ZERO )
                 OR      ( IDX1    >=  200 )
      *
               COMPUTE SPA-GMN-W21-BRMLST-MAX
                   =   SPA-GMN-W21-BRMLST-MAX  +   1
               MOVE    SPA-GMN-W21-BRMLST-MAX
                                   TO  IDX1
      *
      *        病室リスト編集
               PERFORM 3102-BRMLST-EDIT-SEC
      *
               PERFORM 900-SYSKANRI-KEY9-FET-SEC
               MOVE    MCPDATA-REC     TO  SYS-5002-REC
               MOVE    FLG-SYSKANRI    TO  FLG-SYS5002
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
      *
           .
       3101-SYS-5002-GET-EXT.
           EXIT.
      *****************************************************************
      *    病室リスト編集処理
      *****************************************************************
       3102-BRMLST-EDIT-SEC            SECTION.
      *
      *    選択番号
           MOVE    IDX1    TO  SPA-GMN-W21-TSELNUM (IDX1)
      *    病室番号
           IF    ( SYS-5002-KBNCD ( 3 : )
                           IS  NUMERIC )
               MOVE    SYS-5002-KBNCD ( 3 : )
                           TO   WRK-999999
               MOVE    WRK-999999
                           TO   WRK-ZZZZZ9
               MOVE    WRK-ZZZZZ9
                           TO  SPA-GMN-W21-TBRMNUM (IDX1)
           ELSE
               MOVE    SYS-5002-BRM-NUM
                           TO  SPA-GMN-W21-TBRMNUM (IDX1)
           END-IF
      *
           MOVE    SYS-5002-BRM-NUM
                           TO  SPA-GMN-W21-TBRMNUM2 (IDX1)
      *
      *    病室種別
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5108"              TO  SYS-KANRICD
           MOVE    SYS-5002-BRM-SBT    TO  SYS-KBNCD
           MOVE    SYS-5002-STYUKYMD   TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-5108-REC
           MOVE    SYS-5108-BRM-SBT-NM TO  SPA-GMN-W21-TSBT (IDX1)
      *
      *    特定入院料
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5111"              TO  SYS-KANRICD
           MOVE    SYS-5002-BRM-TOKTEI-NYUIN
                                       TO  SYS-KBNCD
           MOVE    SYS-5002-STYUKYMD   TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-5111-REC
           MOVE    SYS-5111-BRM-TOKUTEINYUIN-NM2
                                       TO  SPA-GMN-W21-TTOKNYUIN (IDX1)
      *
      *    収容人数
           MOVE    SYS-5002-BRM-NINZU
                           TO  SPA-GMN-W21-TNINZU (IDX1)
      *
      *    室料差額
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5113"              TO  SYS-KANRICD
           MOVE    SYS-5002-BRM-SAGAKU TO  SYS-KBNCD
           MOVE    SYS-5002-STYUKYMD   TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    SYSKANRI-REC    TO  SYS-5113-REC
               MOVE    SYS-5113-BRM-SAGAKU-NM
                                       TO  WRK-99999
               MOVE    WRK-99999       TO  SPA-GMN-W21-TSAGAKU (IDX1)
           END-IF
      *
      *    性別特定
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5109"              TO  SYS-KANRICD
           MOVE    SYS-5002-BRM-SEX    TO  SYS-KBNCD
           MOVE    SYS-5002-STYUKYMD   TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-5109-REC
           MOVE    SYS-5109-BRM-SEX-NM
                                       TO  SPA-GMN-W21-TSEX (IDX1)
      *
      *    内線番号
           MOVE    SYS-5002-BRM-NAITEL
                           TO  SPA-GMN-W21-TNAITEL (IDX1)
      *
      *    診療科
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1005"              TO  SYS-KANRICD
           MOVE    SYS-5002-BRM-KA     TO  SYS-KBNCD
           MOVE    SYS-5002-STYUKYMD   TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-1005-REC
           MOVE    SYS-1005-SRYKANAME  TO  SPA-GMN-W21-TSRYKA (IDX1)
      *
      *    入院基本料
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5111"              TO  SYS-KANRICD
           MOVE    SYS-5002-KHNKBNCD (2:2)
                                       TO  SYS-KBNCD
           MOVE    SYS-5002-STYUKYMD   TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-5111-REC
           MOVE    SYS-5111-BRM-TOKUTEINYUIN-NM2
                                       TO  SPA-GMN-W21-TKHNRYO(IDX1)
      *
      *    有効開始日
           MOVE    SYS-5002-STYUKYMD
                           TO  WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG
                           TO  SPA-GMN-W21-TYUKOSTYMD (IDX1)
      *
      *    有効終了日
           MOVE    SYS-5002-EDYUKYMD
                           TO  WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG
                           TO  SPA-GMN-W21-TYUKOEDYMD (IDX1)
      *
           .
       3102-BRMLST-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入力項目領域編集処理
      *****************************************************************
       4100-INPUT-AREA-EDIT-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-INPUT-AREA
      *
      *    病室情報検索処理
           PERFORM 4200-BRM-SEL-SEC
           IF    ( FLG-SYSKANRI    NOT =   ZERO )
               MOVE    1           TO  FLG-INPUT-AREA
               GO  TO  4100-INPUT-AREA-EDIT-EXT
           END-IF
      *
      *    有効開始日
           MOVE    SYS-5002-STYUKYMD
                                   TO  SPA-NAI-W21-YUKOSTYMD
                                       SPA-NAI-W21-YUKOSTYMD-OLD
                                       WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W21-YUKOSTYMD
      *
      *    有効終了日
           MOVE    SYS-5002-EDYUKYMD
                                   TO  SPA-NAI-W21-YUKOEDYMD
                                       SPA-NAI-W21-YUKOEDYMD-OLD
                                       WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-W21-YUKOEDYMD
      *
      *    システム管理情報再設定処理
           PERFORM 4100-SYSKANRI-RESET-SEC
      *
      *    区分コード
           MOVE    SYS-5002-KBNCD
                                   TO  SPA-NAI-W21-5002-KBNCD
      *
      *    選択番号１
           MOVE    WRK-SELNUM      TO  SPA-GMN-W21-SELNUM1
      *
      *    病室番号
           MOVE    SYS-5002-BRM-NUM
                                   TO  SPA-GMN-W21-BRMNUM
                                       SPA-NAI-W21-BRMNUM-OLD
      *
      *    病室種別
           MOVE    SYS-5002-BRM-SBT
                                   TO  WRK-CMB-CD
           PERFORM 4200-SBTLST-CHK-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W21-SBT-G
      *
      *    特定入院料
           MOVE    SYS-5002-BRM-TOKTEI-NYUIN
                                   TO  WRK-CMB-CD
           PERFORM 4200-TOKNYUINLST-CHK-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W21-TOKNYUIN-G
      *
      *    収容人数
           MOVE    SYS-5002-BRM-NINZU
                                   TO  SPA-GMN-W21-NINZU
      *
      *    室料差額
           MOVE    SYS-5002-BRM-SAGAKU
                                   TO  WRK-CMB-CD
           PERFORM 4200-SAGAKULST-CHK-SEC
           MOVE    WRK-CMB-ITM   TO  SPA-GMN-W21-SAGAKU-G
      *
      *    性別特定
           MOVE    SYS-5002-BRM-SEX
                                   TO  WRK-CMB-CD
           PERFORM 4200-SEXLST-CHK-SEC
           MOVE    WRK-CMB-ITM   TO  SPA-GMN-W21-SEX-G
      *
      *    内線番号
           MOVE    SYS-5002-BRM-NAITEL
                                   TO  SPA-GMN-W21-NAITEL
      *
      *    診療科
           MOVE    SYS-5002-BRM-KA TO  WRK-CMB-CD
           PERFORM 4200-SRYKALST-CHK-SEC
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W21-SRYKA-G
      *
      *    入院基本料
           MOVE    SYS-5002-KHNKBNCD (2:2)
                                   TO  WRK-CMB-CD
           PERFORM 4200-KHNRYOLST-CHK-SEC
           IF    ( WRK-CMB-ITM     NOT =   SPACE )
               MOVE    WRK-CMB-ITM             TO  SPA-GMN-W21-KHNRYO-G
               MOVE    WRK-CMB-ITM2            TO  SPA-NAI-W21-KHNSRYCD
               MOVE    SPA-NAI-W21-KHNSRYCD    TO  WRK-TNSSRYCD
               MOVE    SPA-NAI-W21-YUKOSTYMD   TO  WRK-TNSYMD
               PERFORM 900-TENSU-KEY-SEL-SEC
               MOVE    TNS-TEN                 TO  SPA-GMN-W21-KHNTEN
           END-IF
      *
           .
       4100-INPUT-AREA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病室情報検索処理
      *****************************************************************
       4200-BRM-SEL-SEC                SECTION.
      *
           INITIALIZE              SYS-5002-REC
           MOVE    "5002"          TO  SYS-5002-KANRICD
           MOVE    SPA-GMN-W21-BTUNUM
                                   TO  WRK-SYS5002-BTUNUM
           PERFORM 4100-BRMNUM-KEY-EDIT-SEC
           MOVE    WRK-BRMNUM-KEY  TO  WRK-SYS5002-BRMNUM
           MOVE    WRK-SYS5002-KBNCD
                                   TO  SYS-5002-KBNCD
           MOVE    WRK-KJNYMD      TO  SYS-5002-STYUKYMD
                                       SYS-5002-EDYUKYMD
           MOVE    SYS-5002-REC    TO  SYSKANRI-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-5002-REC
      *
           .
       4200-BRM-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    履歴領域編集処理
      *****************************************************************
       4100-RIREKI-AREA-EDIT-SEC       SECTION.
      *
           INITIALIZE      SPA-GMN-W21-RIREKILST
                           SPA-NAI-W21-RIREKILST
      *
      *    病室情報検索
           PERFORM 4100-BRM-SEL-SEC
           IF   (  FLG-SYSKANRI    =   ZERO )
               CONTINUE
           ELSE
               GO  TO  4100-RIREKI-AREA-EDIT-EXT
           END-IF
      *
           MOVE    SPA-GMN-W21-BRMLST-SEL
                                       TO  SPA-NAI-W21-RIREKILST-SELNUM
      *
           MOVE    SPA-GMN-W21-BRMNUM
                                       TO  SPA-NAI-W21-RIREKILST-BRMNUM
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    NOT =   ZERO )
                 OR      ( IDX1        >   20 )
      *
               MOVE    IDX1            TO  SPA-GMN-W21-RIREKILST-MAX
      *
      *        選択番号
               MOVE    IDX1            TO  SPA-GMN-W21-TRSELNUM (IDX1) 
      *
      *        有効開始日
               MOVE    SYS-5002-STYUKYMD
                                   TO  SPA-NAI-W21-TRYUKOSTYMD (IDX1)
                                           WRK-YMD
               PERFORM 800-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-W21-TRYUKOSTYMD (IDX1)
      *
      *        有効終了日
               MOVE    SYS-5002-EDYUKYMD
                                   TO  SPA-NAI-W21-TRYUKOEDYMD (IDX1)
                                       WRK-YMD
               PERFORM 800-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-W21-TRYUKOEDYMD (IDX1)
      *
               IF    ( SPA-NAI-W21-YUKOSTYMD-OLD
                                   =   SPA-NAI-W21-TRYUKOSTYMD (IDX1))
                AND  ( SPA-NAI-W21-YUKOEDYMD-OLD
                                   =   SPA-NAI-W21-TRYUKOEDYMD (IDX1))
                   MOVE    IDX1    TO  SPA-GMN-W21-SELNUM2
                   MOVE    IDX1    TO  SPA-GMN-W21-RIREKILST-SEL
               END-IF
      *
      *        病棟データ読込処理
               PERFORM 4100-BRM-FET-SEC
      *
           END-PERFORM
      *
      *    病棟データクローズ処理
           PERFORM 4100-BRM-CLOSECURSOR-SEC
           .
      *
      *
       4100-RIREKI-AREA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF    ( SPA-WID1-FLG    =   "OK" )
               EVALUATE    SPA-WIDCD
               WHEN "2001"
                       PERFORM 421-SAKUJO-SEC
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD      
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                           SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           EVALUATE    MCP-EVENT       ALSO      MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM  210-BACK
      *    クリア
           WHEN    "CLICKED"       ALSO    "B02"
               PERFORM 420-CLEAR-SEC
      *    追加
           WHEN    "CLICKED"       ALSO    "B06"
               PERFORM 420-TUIKA-SEC
      *    変更
           WHEN    "CLICKED"       ALSO    "B07"
               PERFORM 420-HENKOU-SEC
      *    削除
           WHEN    "CLICKED"       ALSO    "B08"
               PERFORM 420-SAKUJO-SEC
      *    病棟管理情報画面へ
           WHEN    "CLICKED"       ALSO    "B09"
               IF  ( SPA-MOTOPG    =       "W01" )
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 420-BYOTO-KANRI-SENI-SEC
               END-IF
           END-EVALUATE
           .
      *
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                             SECTION.
      *
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    病棟名称
           WHEN    "ACTIVATE"      ALSO    "BTU_NAME"
               PERFORM 4100-BTUNUM-CHK-SEC
      *    選択番号１
           WHEN    "ACTIVATE"      ALSO    "SELNUM1"
               PERFORM 4100-SELNUM1-CHK-SEC
      *    選択番号
           WHEN    "ACTIVATE"      ALSO    "SELNUM2"
               PERFORM 4100-SELNUM2-CHK-SEC
      *    病室リスト
           WHEN    ANY             ALSO    "BRMLST"
               PERFORM 4100-BRMLST-CHK-SEC
      *    履歴リスト
           WHEN    ANY             ALSO    "RIREKILST"
               PERFORM 4100-RIREKILST-CHK-SEC
           WHEN    OTHER
      *
      *        入力個所のセット
               PERFORM 400-GMN-INPUT-SEC
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
           END-EVALUATE
      *
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       400-GMN-INPUT-SEC          SECTION.
      *
           MOVE    ZERO        TO      SPA-GMN-W21-CUR
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
      *    病室番号
           MOVE    W21-BRM-NUM     TO  SPA-GMN-W21-BRMNUM
      *
      *    病室種別
           MOVE    W21-BRM-SBT     TO  SPA-GMN-W21-SBT-G
      *
      *    特定入院料
           MOVE    W21-BRM-TOKUTEINYUIN
                                   TO  SPA-GMN-W21-TOKNYUIN-G
      *
      *    収容人数
           MOVE    W21-BRM-NINZU   TO  SPA-GMN-W21-NINZU
      *
      *    室料差額
           MOVE    W21-BRM-SAGAKU
                                   TO  SPA-GMN-W21-SAGAKU-G
      *
      *    性別特定
           MOVE    W21-BRM-SEX     TO  SPA-GMN-W21-SEX-G
      *
      *    内線番号
           MOVE    W21-BRM-NAITEL  TO  SPA-GMN-W21-NAITEL
      *
      *    診療科
           MOVE    W21-BRM-KA      TO  SPA-GMN-W21-SRYKA-G
      *
      *    入院基本料
           MOVE    W21-KHNRYO      TO  SPA-GMN-W21-KHNRYO-G
      *
      *    有効期間開始日
           MOVE    W21-YUKOSTYMD   TO  SPA-GMN-W21-YUKOSTYMD
      *
      *    有効期間終了日
           MOVE    W21-YUKOEDYMD   TO  SPA-GMN-W21-YUKOEDYMD
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
      *    病棟名称チェック処理
           PERFORM 4101-BTUNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               PERFORM 420-CLEAR-SEC
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    有効期間開始日チェック処理
           PERFORM 4100-YUKOSTYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    有効期間終了日チェック処理
           PERFORM 4100-YUKOEDYMD-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病室番号チェック処理
           PERFORM 4100-BRMNUM-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    病室種別チェック処理
           PERFORM 4100-SBT-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    特定入院料チェック処理
           PERFORM 4100-TOKNYUIN-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    収容人数チェック処理
           PERFORM 4100-NINZU-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    室料差額チェック処理
           PERFORM 4100-SAGAKU-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    性別特定チェック処理
           PERFORM 4100-SEX-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    内線番号チェック処理
           PERFORM 4100-NAITEL-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    診療科チェック処理
           PERFORM 4100-SRYKA-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
      *    入院基本料チェック処理
           PERFORM 4100-KHNRYO-CHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    SPA-MOTOPG          TO  SPA-SAKIPG
           MOVE    SPA-MOTOPG2         TO  SPA-MOTOPG3
           MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           MOVE    "W21"               TO  SPA-MOTOPG
      *
      ***  MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    条件クリア処理
      *****************************************************************
       420-CLEAR-SEC               SECTION.
      *
           INITIALIZE  SPA-GMN-W21-RIREKILST
                       SPA-NAI-W21-RIREKILST
                       SPA-GMN-W21-BRMLST
      *
           PERFORM 4201-HEAD-AREA-CLEAR-SEC
      *
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           MOVE    1               TO  SPA-GMN-W21-CUR
      *
           .
       420-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    追加処理
      *****************************************************************
       420-TUIKA-SEC               SECTION.
      *
      *    入力項目入力時チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    共通関連チェック
           PERFORM 4900-KANRENCHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    既存の履歴データをチェックし、期間の重複したデータが
      *    存在しないこと
           MOVE    1                   TO  FLG-UPD-KBN
           PERFORM 4100-RIREKI-CHK-SEC
           IF   ( FLG-KIKAN-DABURI NOT =   ZERO )
               MOVE    "1104"          TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    病室情報追加編集処理
           PERFORM 4201-BRM-INSERT-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    病棟リストを再編集する
           PERFORM 3101-SYS-5002-GET-SEC
      *
           PERFORM 4100-BRM-NUM-LSTSEL-SEC
           IF    ( FLG-BRM-NUM =   ZERO )
               MOVE    IDX-BRMLST  TO  SPA-GMN-W21-BRMLST-SEL
           END-IF
      *
      *    履歴リストを再編集する
           PERFORM 4100-RIREKI-AREA-EDIT-SEC
           MOVE    ZERO            TO  SPA-GMN-W21-RIREKILST-SEL
      *
      *    入力項目を初期化する
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
      *    病棟リスト最大件数チェック
           IF    ( SPA-GMN-W21-BRMLST-MAX  >=  200 )
               MOVE    "1001"      TO  SPA-ERRCD
           END-IF
      *
           .
       420-TUIKA-EXT.
           EXIT.
      *****************************************************************
      *    変更処理
      *****************************************************************
       420-HENKOU-SEC                  SECTION.
      *
      *    入力項目入力時チェック
           PERFORM 410-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    選択番号が入力されていること
           IF    ( SPA-GMN-W21-SELNUM1 NOT =   ZERO )
               CONTINUE
           ELSE
               MOVE    "1105"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-W21-CUR
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    病室番号が変更されていないこと
           IF    ( SPA-GMN-W21-BRMNUM     =   SPA-NAI-W21-BRMNUM-OLD )
               CONTINUE
           ELSE
               MOVE    "1106"      TO  SPA-ERRCD
               MOVE    3           TO  SPA-GMN-W21-CUR
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    共通関連チェック
           PERFORM 4900-KANRENCHK-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    有効期間の開始日と終了日が同時に変更されていないこと
           IF    ( SPA-NAI-W21-YUKOSTYMD
                               NOT =   SPA-NAI-W21-YUKOSTYMD-OLD )
            AND
                 ( SPA-NAI-W21-YUKOEDYMD
                               NOT =   SPA-NAI-W21-YUKOEDYMD-OLD )
               MOVE    "1107"      TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    既存の履歴データをチェックし、期間の重複したデータが
      *    存在しないこと
           MOVE    2                   TO  FLG-UPD-KBN
           PERFORM 4100-RIREKI-CHK-SEC
           IF   ( FLG-KIKAN-DABURI NOT =   ZERO )
               MOVE    "1104"          TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    病室リスト更新処理
           PERFORM 4201-BRM-UPDATE-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  420-HENKOU-EXT
           END-IF
      *
      *    病室リストを再編集する
           PERFORM 3101-SYS-5002-GET-SEC
      *
           PERFORM 4100-BRM-NUM-LSTSEL-SEC
           IF    ( FLG-BRM-NUM =   ZERO )
               MOVE    IDX-BRMLST
                                   TO  SPA-GMN-W21-BRMLST-SEL
      *        履歴リストを再編集する
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
               MOVE    ZERO        TO  SPA-GMN-W21-RIREKILST-SEL
      *
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
           ELSE
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
           END-IF
      *
           .
       420-HENKOU-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       420-SAKUJO-SEC                  SECTION.
      *
      *    選択番号が入力されていること
           IF    ( SPA-GMN-W21-SELNUM1 NOT =   ZERO )
               CONTINUE
           ELSE
               MOVE    "1105"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-W21-CUR
               GO  TO  420-SAKUJO-EXT
           END-IF
      *
      *    範囲内の選択番号が入力されていること
           IF    ( SPA-GMN-W21-SELNUM1 <=  SPA-GMN-W21-BRMLST-MAX )
               CONTINUE
           ELSE
               MOVE    "1008"      TO  SPA-ERRCD
               MOVE    2           TO  SPA-GMN-W21-CUR
               GO  TO  420-SAKUJO-EXT
           END-IF
      *
      *    入院中の患者が存在しないかチェック
           PERFORM 900-PTNYUINRRK-KEY15-SEL-SEC
           IF    ( FLG-PTNYUINRRK  =   ZERO )
               MOVE    "1108"      TO  SPA-ERRCD
               GO  TO  420-SAKUJO-EXT
           END-IF
      *
           MOVE    "2001"          TO  SPA-WIDCD
      *
           .
       420-SAKUJO-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       421-SAKUJO-SEC                  SECTION.
      *
      *    病室情報削除処理
           PERFORM  4201-BRM-DELETE-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  421-SAKUJO-EXT
           END-IF
      *
      *    病室リストを再編集する
           PERFORM 3101-SYS-5002-GET-SEC
      *
           PERFORM 4100-BRM-NUM-LSTSEL-SEC
           IF    ( FLG-BRM-NUM =   ZERO )
               MOVE    IDX-BRMLST  TO  SPA-GMN-W21-BRMLST-SEL
      *        履歴リストを再編集する
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
               MOVE    ZERO        TO  SPA-GMN-W21-RIREKILST-SEL
      *
      *        入力項目を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
           ELSE
      *        画面を初期化する
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
           END-IF
           .
       421-SAKUJO-EXT.
           EXIT.
      *****************************************************************
      *    病棟管理遷移処理
      *****************************************************************
       420-BYOTO-KANRI-SENI-SEC        SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    SPA-GMN-W21-BTUNUM  TO  SPA-W20-W21-BTUNUM
      *
           MOVE    "W20"               TO  SPA-SAKIPG
           MOVE    "W21"               TO  SPA-MOTOPG
           MOVE    "W01"               TO  SPA-MOTOPG2
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       420-BYOTO-KANRI-SENI-EXT.
           EXIT.
      *****************************************************************
      *    履歴チェック処理
      *****************************************************************
       4100-RIREKI-CHK-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-KIKAN-DABURI
      *
      *    病棟情報検索処理
           PERFORM 4100-BRM-SEL-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-SYSKANRI    NOT =   ZERO )
      *
      *        有効期間が重複するデータがないかチェック
      *        （変更処理の場合、元データは対象外とする）
               IF    ( FLG-UPD-KBN           =  2 )
                AND  ( SPA-NAI-W21-BRMNUM-OLD
                                             =   SYS-5002-BRM-NUM  )
                AND  ( SPA-NAI-W21-YUKOSTYMD-OLD
                                             =   SYS-5002-STYUKYMD )
                AND  ( SPA-NAI-W21-YUKOEDYMD-OLD
                                             =   SYS-5002-EDYUKYMD )
                   CONTINUE
               ELSE
                   IF    ( SPA-NAI-W21-YUKOEDYMD
                                             <   SYS-5002-STYUKYMD )
                     OR  ( SPA-NAI-W21-YUKOSTYMD
                                             >   SYS-5002-EDYUKYMD )
                       CONTINUE
                   ELSE
                       MOVE    1             TO  FLG-KIKAN-DABURI
                   END-IF
               END-IF
      *
      *        病棟データ読込処理
               PERFORM 4100-BRM-FET-SEC
      *
           END-PERFORM
      *
      *    病棟データクローズ処理
           PERFORM 4100-BRM-CLOSECURSOR-SEC
           .
      *
       4100-RIREKI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室情報検索処理
      *****************************************************************
       4100-BRM-SEL-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           INITIALIZE                      SYS-5002-REC
           MOVE    "5002"              TO  SYS-5002-KANRICD
      *
           MOVE    SPA-GMN-W21-BTUNUM  TO  WRK-SYS5002-BTUNUM
           MOVE    SPA-GMN-W21-BRMNUM  TO  WRK-BRMNUM
           PERFORM 4100-BRMNUM-KEY-EDIT-SEC
           MOVE    WRK-BRMNUM-KEY      TO  WRK-SYS5002-BRMNUM
      *
           MOVE    WRK-SYS5002-KBNCD   TO  SYS-5002-KBNCD
           MOVE    SYS-5002-REC        TO  SYSKANRI-REC
           PERFORM 900-SYSKANRI-KEY8-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-5002-REC
      *
           .
       4100-BRM-SEL-EXT.
           EXIT.
      *****************************************************************
      *    病室情報読込処理
      *****************************************************************
       4100-BRM-FET-SEC               SECTION.
      *
           PERFORM 900-SYSKANRI-KEY8-FET-SEC
           MOVE    SYSKANRI-REC        TO  SYS-5002-REC
      *
           .
       4100-BRM-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病室情報クローズ処理
      *****************************************************************
       4100-BRM-CLOSECURSOR-SEC              SECTION.
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       4100-BRM-CLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    病室番号左詰処理
      *****************************************************************
       4100-BRM-NUM-LEFT-EDIT-SEC      SECTION.
      *
           INITIALIZE                  ORCSBRMNUMAREA
           MOVE    "1"             TO  SBRMNUM-IN-PROCKBN
           MOVE    WRK-BRMNUM-IN   TO  SBRMNUM-IN-BRMNUM
           CALL    "ORCSBRMNUM"    USING   ORCSBRMNUMAREA
           MOVE    SBRMNUM-OT-BRMNUM
                                   TO  WRK-BRMNUM-OT
      *
           .
       4100-BRM-NUM-LEFT-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病室番号キー作成処理
      *****************************************************************
       4100-BRMNUM-KEY-EDIT-SEC       SECTION.
      *
           INITIALIZE                  ORCSBRMNUMAREA
           MOVE    "2"             TO  SBRMNUM-IN-PROCKBN
           MOVE    WRK-BRMNUM      TO  SBRMNUM-IN-BRMNUM
           CALL    "ORCSBRMNUM"    USING   ORCSBRMNUMAREA
           MOVE    SBRMNUM-OT-BRMNUM
                                   TO  WRK-BRMNUM-KEY
      *
           .
       4100-BRMNUM-KEY-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病室情報更新処理
      *****************************************************************
       4201-BRM-UPDATE-SEC             SECTION.
      *
      *    アップデート対象のデータを読み直す
           MOVE    SPA-GMN-W21-BRMNUM
                                   TO  WRK-BRMNUM
           MOVE    SPA-NAI-W21-YUKOSTYMD-OLD
                                   TO  WRK-KJNYMD
           PERFORM 4200-BRM-SEL-SEC
           IF   ( FLG-SYSKANRI     NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  4201-BRM-UPDATE-EXT
           END-IF
      *
      *    病室情報編集処理
           PERFORM 4201-BRM-EDIT-SEC
      *
           MOVE    SYS-5002-REC    TO  SYSKANRI-REC
           MOVE    SYS-5002-KANRICD
                                   TO  SYSUP-KANRICD
           MOVE    SPA-NAI-W21-5002-KBNCD
                                   TO  SYSUP-KBNCD
           MOVE    SPA-NAI-W21-YUKOSTYMD-OLD
                                   TO  SYSUP-STYUKYMD
           MOVE    SPA-NAI-W21-YUKOEDYMD-OLD
                                   TO  SYSUP-EDYUKYMD
      *
           PERFORM 800-MCNDATE-SEC
           MOVE    SMCNDATE-YMD    TO  SYS-UPYMD
           MOVE    SMCNDATE-HMS    TO  SYS-UPHMS
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "upd1"          TO  MCP-PATHNAME
           PERFORM 910-DBUPDATE-SEC
           IF   (  MCP-RC          NOT =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
           END-IF
           .
      *
       4201-BRM-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    病室情報追加処理
      *****************************************************************
       4201-BRM-INSERT-SEC             SECTION.
      *
      *    更新対象のデータが既に存在しないかチェック
           MOVE    SPA-GMN-W21-BRMNUM
                                   TO  WRK-BRMNUM
           MOVE    SPA-NAI-W21-YUKOSTYMD
                                   TO  WRK-KJNYMD
           PERFORM 4200-BRM-SEL-SEC
           IF   ( FLG-SYSKANRI     =   ZERO )
               MOVE    "1201"      TO  SPA-ERRCD
               GO  TO  4201-BRM-INSERT-EXT
           END-IF
      *
           MOVE    SPACE       TO  SYS-5002-REC
           INITIALIZE              SYS-5002-REC
      *
      *    病室情報編集処理
           PERFORM 4201-BRM-EDIT-SEC
      *
      *    病室加算情報編集処理
           PERFORM 4201-BRM-KSN-EDIT-SEC
      *
           PERFORM 800-MCNDATE-SEC
           MOVE    SMCNDATE-YMD    TO  SYS-5002-CREYMD
                                       SYS-5002-UPYMD
           MOVE    SMCNDATE-HMS    TO  SYS-5002-UPHMS
      *
           MOVE    SYS-5002-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBINSERT-SEC
           IF   (  MCP-RC          NOT =   ZERO )
               MOVE    "1202"      TO  SPA-ERRCD
           END-IF
      *
           .
      *
       4201-BRM-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    病室情報削除処理
      *****************************************************************
       4201-BRM-DELETE-SEC             SECTION.
      *
           INITIALIZE              SYS-5002-REC
           MOVE    "5002"          TO  SYS-5002-KANRICD
           MOVE    SPA-NAI-W21-5002-KBNCD
                                   TO  SYS-5002-KBNCD
           MOVE    SPA-NAI-W21-YUKOSTYMD-OLD
                                   TO  SYS-5002-STYUKYMD
           MOVE    SPA-NAI-W21-YUKOEDYMD-OLD
                                   TO  SYS-5002-EDYUKYMD
           MOVE    SYS-5002-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBDELETE-SEC
           IF   (  MCP-RC          NOT =   ZERO )
               MOVE    "1203"      TO  SPA-ERRCD
           END-IF
      *
           .
       4201-BRM-DELETE-EXT.
           EXIT.
      *****************************************************************
      *    病室情報編集処理
      *****************************************************************
       4201-BRM-EDIT-SEC               SECTION.
      *
      *    MOVE    SPACE       TO  SYS-5002-REC
      *    INITIALIZE              SYS-5002-REC
      *
      *    管理コード
           MOVE    "5002"      TO  SYS-5002-KANRICD
      *
      *    区分コード
           MOVE    SPA-GMN-W21-BTUNUM
                               TO  WRK-SYS5002-BTUNUM
      *
           MOVE    SPA-GMN-W21-BRMNUM
                               TO  WRK-BRMNUM
           PERFORM 4100-BRMNUM-KEY-EDIT-SEC
           MOVE    WRK-BRMNUM-KEY
                               TO  WRK-SYS5002-BRMNUM
      *
           MOVE    WRK-SYS5002-KBNCD
                               TO  SYS-5002-KBNCD
      *
      *    有効開始年月日
           MOVE    SPA-NAI-W21-YUKOSTYMD
                               TO  SYS-5002-STYUKYMD
      *
      *    有効終了年月日
           MOVE    SPA-NAI-W21-YUKOEDYMD
                               TO  SYS-5002-EDYUKYMD
      *
      *    病室番号
           MOVE    SPA-GMN-W21-BRMNUM
                               TO  SYS-5002-BRM-NUM
      *
      *    病室種別
           MOVE    SPA-GMN-W21-SBT
                               TO  SYS-5002-BRM-SBT
      *
      *    特定入院料
           MOVE    SPA-GMN-W21-TOKNYUIN
                               TO  SYS-5002-BRM-TOKTEI-NYUIN
      *
      *    収容人数
           MOVE    SPA-GMN-W21-NINZU
                               TO  SYS-5002-BRM-NINZU
      *
      *    室料差額
           MOVE    SPA-GMN-W21-SAGAKU
                               TO  SYS-5002-BRM-SAGAKU
      *
      *    性別特定
           MOVE    SPA-GMN-W21-SEX
                               TO  SYS-5002-BRM-SEX
      *
      *    内線番号
           MOVE    SPA-GMN-W21-NAITEL
                               TO  SYS-5002-BRM-NAITEL
      *
      *    診療科
           MOVE    SPA-GMN-W21-SRYKA
                               TO  SYS-5002-BRM-KA
      *
      *    入院基本料
           MOVE    SPA-NAI-W21-KHNSRYCD
                               TO  SYS-5002-KHNSRYCD
           MOVE    "3"         TO  SYS-5002-KHNKBNCD (1:1)
           MOVE    SPA-GMN-W21-KHNRYO
                               TO  SYS-5002-KHNKBNCD (2:2)
      *
           .
       4201-BRM-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病室情報編集処理
      *****************************************************************
       4201-BRM-KSN-EDIT-SEC           SECTION.
      *
      *    --  加算情報に初期値を設定  --
      *
      *    新生児入院医療管理加算
           MOVE    CONST-SINSEIJI  TO  SYS-5002-SINSEIJI-CD
           MOVE    "1"             TO  SYS-5002-SINSEIJI-KBN
      *
      *    診療所療養病床療養環境加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   2 )
               MOVE    CONST-SNR-RYOYO (IDX1)
                                   TO  SYS-5002-SNR-RYOYO-CD  (IDX1)
               MOVE    "1"         TO  SYS-5002-SNR-RYOYO-KBN (IDX1)
           END-PERFORM
      *
      *    放射線治療病室管理加算
           MOVE    CONST-HOSYASEN  TO  SYS-5002-HOSYASEN-CD
           MOVE    "1"             TO  SYS-5002-HOSYASEN-KBN
      *
      *    療養環境加算
           MOVE    CONST-RYOYO     TO  SYS-5002-RYOYO-CD
           MOVE    "1"             TO  SYS-5002-RYOYO-KBN
      *
      *    療養病棟療養環境加算
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   3 )
               MOVE    CONST-BTU-RYOYO (IDX1)
                                   TO  SYS-5002-BTU-RYOYO-CD  (IDX1)
               MOVE    "1"         TO  SYS-5002-BTU-RYOYO-KBN (IDX1)
           END-PERFORM
      *
      *    重症者等療養環境特別加算（個室）
           MOVE    CONST-JYUTOK1   TO  SYS-5002-JYUTOK1-CD
      *
      *    重症者等療養環境特別加算（２人部屋）
           MOVE    CONST-JYUTOK2   TO  SYS-5002-JYUTOK2-CD
      *
      *    無菌治療室管理加算
           MOVE    CONST-MUKIN     TO  SYS-5002-MUKIN-CD
      *
           IF    ( SPA-NAI-W20-YUKOSTYMD   >=  CONST-H180401 )
      *        療養病棟療養環境加算
               MOVE    CONST-BTU-RYOYO-H18
                                   TO  SYS-5002-BTU-RYOYO-H18-CD
               MOVE    "1"         TO  SYS-5002-BTU-RYOYO-H18-KBN
           END-IF
      *
           .
       4201-BRM-KSN-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称
      *****************************************************************
       4100-BTUNUM-CHK-SEC           SECTION.
      *
           MOVE    ZERO        TO  SPA-GMN-W21-CUR
      *
      *    クリア処理
           PERFORM 420-CLEAR-SEC
      *
           MOVE    SPACE       TO  SPA-GMN-W21-BTUKHNRYO
      *
           MOVE    W21-BTU-NAME    TO  SPA-GMN-W21-BTUNUM-G
      *
           PERFORM 4101-BTUNUM-CHK-SEC
           IF   (  SPA-ERRCD   NOT =   SPACE )
               GO  TO  4100-BTUNUM-CHK-EXT
           END-IF
      *
      *    入院基本料編集処理
           PERFORM 3101-BTU-KHNRYO-EDIT-SEC
      *
      *    病室管理情報検索（病室リストに表示）
           PERFORM 3101-SYS-5002-GET-SEC
      *
           MOVE    ZERO        TO  SPA-GMN-W21-CUR
      *
           .
      *
       4100-BTUNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟名称
      *****************************************************************
       4101-BTUNUM-CHK-SEC           SECTION.
      *
           IF    ( SPA-GMN-W21-BTUNUM-G
                                   =   SPACE )
               MOVE    "1006"      TO  SPA-ERRCD
               MOVE    1           TO  SPA-GMN-W21-CUR
               GO  TO  4101-BTUNUM-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-BTUNUM
                                   TO  WRK-CMB-CD
           PERFORM 4200-BTUNUMLST-CHK-SEC
           IF    ( WRK-CMB-ITM   =   SPACE )
               MOVE    "1007"      TO  SPA-ERRCD
               MOVE    1           TO  SPA-GMN-W21-CUR
               GO  TO  4101-BTUNUM-CHK-EXT
           END-IF
      *
           MOVE    WRK-CMB-ITM     TO  SPA-GMN-W21-BTUNUM-G
           MOVE    WRK-CMB-ITM2    TO  WRK-TOKNYUIN
           MOVE    WRK-CMB-ITM3    TO  WRK-KHNSRYCD
           MOVE    WRK-CMB-ITM4    TO  WRK-BTU-YUKSTYMD
           MOVE    WRK-CMB-ITM5    TO  SPA-NAI-W21-BTUSBT
           .
      *
       4101-BTUNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号１
      *****************************************************************
       4100-SELNUM1-CHK-SEC            SECTION.
      *
           MOVE    ZERO        TO  SPA-GMN-W21-CUR
      *
           MOVE    W21-SELNUM1 TO  SPA-GMN-W21-SELNUM1
      *
           IF    ( SPA-GMN-W21-SELNUM1 =   ZERO )
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
               MOVE    3           TO  SPA-GMN-W21-CUR
               GO  TO  4100-SELNUM1-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-W21-SELNUM1 <=  SPA-GMN-W21-BRMLST-MAX )
               CONTINUE
           ELSE
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
               MOVE    W21-SELNUM1     TO  SPA-GMN-W21-SELNUM1
               MOVE    "1008"          TO  SPA-ERRCD
               GO  TO  4100-SELNUM1-CHK-EXT
           END-IF
      *
      *    入力項目領域編集処理
           MOVE    SPA-GMN-W21-TBRMNUM2 (SPA-GMN-W21-SELNUM1)
                                       TO  WRK-BRMNUM
           MOVE    SPA-SYSYMD          TO  WRK-KJNYMD
      *
      *    入力領域初期化
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
      *    履歴領域初期化
           PERFORM 4201-RIREKI-AREA-CLEAR-SEC
      *
      *    入力データ編集処理
           MOVE    W21-SELNUM1         TO  WRK-SELNUM
           PERFORM 4100-INPUT-AREA-EDIT-SEC
           IF    ( FLG-INPUT-AREA  =   ZERO )
      *
               MOVE    W21-SELNUM1 TO  SPA-GMN-W21-BRMLST-SEL
      *
      *        履歴データ編集処理
               PERFORM 4100-RIREKI-AREA-EDIT-SEC
           ELSE
               PERFORM 4201-INPUT-AREA-CLEAR-SEC
               PERFORM 4201-RIREKI-AREA-CLEAR-SEC
               MOVE    W21-SELNUM1 TO  SPA-GMN-W21-SELNUM1
           END-IF
      *
           MOVE    ZERO            TO  SPA-GMN-W21-CUR
      *
           .
      *
       4100-SELNUM1-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室番号
      *****************************************************************
       4100-BRMNUM-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-W21-BRMNUM =   SPACE   )
               GO  TO  4100-BRMNUM-CHK-EXT
           END-IF
      *
      *    全角半角混在チェック
           MOVE    SPA-GMN-W21-BRMNUM  TO  WRK-KANACHK-INPUT
      *
           PERFORM 800-ENRTRY-CHK-SEC
           MOVE    WRK-KANACHK-INPUT   TO  SPA-GMN-W21-BRMNUM
           IF  ( FLG-ENTRYCHK      NOT =   1 )
               MOVE    3               TO  SPA-GMN-W21-CUR
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  4100-BRMNUM-CHK-EXT
           END-IF
      *
      *    左詰編集を行う
           MOVE    SPA-GMN-W21-BRMNUM TO  WRK-BRMNUM-IN
           PERFORM 4100-BRM-NUM-LEFT-EDIT-SEC
           MOVE    WRK-BRMNUM-OT      TO  SPA-GMN-W21-BRMNUM
      *
      *    間に空白文字が混入していないかチェック
           MOVE    SPACE           TO  WRK-STR1
                                       WRK-STR2
           UNSTRING    SPA-GMN-W21-BRMNUM
           DELIMITED   BY  ALL SPACE
           INTO        WRK-STR1
                       WRK-STR2
           END-UNSTRING
      *
           IF    ( WRK-STR2        NOT =   SPACE )
               MOVE    3               TO  SPA-GMN-W21-CUR
               MOVE    "0002"          TO  SPA-ERRCD
           END-IF
      *
           .
      *
       4100-BRMNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室種別
      *****************************************************************
       4100-SBT-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-W21-SBT-G   =   SPACE )
               GO  TO  4100-SBT-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-SBT TO  WRK-CMB-CD
           PERFORM 4200-SBTLST-CHK-SEC
           IF    ( WRK-CMB-ITM   =   SPACE )
               MOVE    4           TO  SPA-GMN-W21-CUR
               MOVE    "0003"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W21-SBT-G
           END-IF
      *
      *
           .
      *
       4100-SBT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料
      *****************************************************************
       4100-TOKNYUIN-CHK-SEC   SECTION.
      *
           IF    ( SPA-GMN-W21-TOKNYUIN-G  =   SPACE )
               GO  TO  4100-TOKNYUIN-CHK-EXT
           END-IF
      *
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-TOKNYUIN
                                   TO  WRK-CMB-CD
           PERFORM 4200-TOKNYUINLST-CHK-SEC
           IF    ( WRK-CMB-ITM   =   SPACE )
               MOVE    5           TO  SPA-GMN-W21-CUR
               MOVE    "0004"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W21-TOKNYUIN-G
           END-IF
      *
      *
           .
      *
       4100-TOKNYUIN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    収容人数
      *****************************************************************
       4100-NINZU-CHK-SEC          SECTION.
      *
      *
           .
      *
       4100-NINZU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    室料差額
      *****************************************************************
       4100-SAGAKU-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-W21-SAGAKU-G
                                    =   SPACE )
               GO  TO  4100-SAGAKU-CHK-EXT
           END-IF
      *
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-SAGAKU
                                   TO  WRK-CMB-CD
           PERFORM 4200-SAGAKULST-CHK-SEC
           IF    ( WRK-CMB-ITM   =   SPACE )
               MOVE    7           TO  SPA-GMN-W21-CUR
               MOVE    "0006"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W21-SAGAKU-G
           END-IF
      *
      *
           .
      *
       4100-SAGAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    性別特定
      *****************************************************************
       4100-SEX-CHK-SEC            SECTION.
      *
           IF    ( SPA-GMN-W21-SEX-G   =   SPACE )
               GO  TO  4100-SEX-CHK-EXT
           END-IF
      *
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-SEX TO  WRK-CMB-CD
           PERFORM 4200-SEXLST-CHK-SEC
           IF    ( WRK-CMB-ITM   =   SPACE )
               MOVE    8           TO  SPA-GMN-W21-CUR
               MOVE    "0007"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W21-SEX-G
           END-IF
      *
      *
           .
      *
       4100-SEX-CHK-EXT.
           EXIT.
      *****************************************************************
      *    内線番号
      *****************************************************************
       4100-NAITEL-CHK-SEC         SECTION.
      *
           IF    ( SPA-GMN-W21-NAITEL  =   SPACE   )
               GO  TO  4100-NAITEL-CHK-EXT
           END-IF
      *
      *    全角半角混在チェック
           MOVE    SPA-GMN-W21-NAITEL  TO  WRK-KANACHK-INPUT
           PERFORM 800-ENRTRY-CHK-SEC
           MOVE    WRK-KANACHK-INPUT   TO  SPA-GMN-W21-NAITEL
           IF  ( FLG-ENTRYCHK      NOT =   1 )
               MOVE    9               TO  SPA-GMN-W21-CUR
               MOVE    "0002"          TO  SPA-ERRCD
           END-IF
      *
           .
      *
       4100-NAITEL-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療科
      *****************************************************************
       4100-SRYKA-CHK-SEC   SECTION.
      *
           IF    ( SPA-GMN-W21-SRYKA-G     =   SPACE )
               GO  TO  4100-SRYKA-CHK-EXT
           END-IF
      *
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-SRYKA
                                   TO  WRK-CMB-CD
           PERFORM 4200-SRYKALST-CHK-SEC
           IF    ( WRK-CMB-ITM   =   SPACE )
               MOVE    10          TO  SPA-GMN-W21-CUR
               MOVE    "0009"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM TO  SPA-GMN-W21-SRYKA-G
           END-IF
      *
      *
           .
      *
       4100-SRYKA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料チェック処理
      *****************************************************************
       4100-KHNRYO-CHK-SEC             SECTION.
      *
           INITIALIZE                  SPA-NAI-W21-KHNSRYCD
                                       SPA-GMN-W21-KHNTEN
      *
           IF    ( SPA-GMN-W21-KHNRYO-G    =   SPACE )
               GO  TO  4100-KHNRYO-CHK-EXT
           END-IF
      *
      *    該当コードのデータが存在するかチェック
           MOVE    SPA-GMN-W21-KHNRYO
                                   TO  WRK-CMB-CD
           PERFORM 4200-KHNRYOLST-CHK-SEC
           IF    ( WRK-CMB-ITM   =   SPACE )
               MOVE    13          TO  SPA-GMN-W21-CUR
               MOVE    "0010"      TO  SPA-ERRCD
           ELSE
               MOVE    WRK-CMB-ITM             TO  SPA-GMN-W21-KHNRYO-G
               MOVE    WRK-CMB-ITM2            TO  SPA-NAI-W21-KHNSRYCD
               MOVE    SPA-NAI-W21-KHNSRYCD    TO  WRK-TNSSRYCD
               MOVE    SPA-NAI-W21-YUKOSTYMD   TO  WRK-TNSYMD
               PERFORM 900-TENSU-KEY-SEL-SEC
               MOVE    TNS-TEN                 TO  SPA-GMN-W21-KHNTEN
           END-IF
      *
      *
           .
      *
       4100-KHNRYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    有効期間開始日
      *****************************************************************
       4100-YUKOSTYMD-CHK-SEC          SECTION.
      *
           MOVE    SPA-NAI-W21-YUKOSTYMD
                                   TO  WRK-YUKOSTYMD
           MOVE    SPACE           TO  SPA-NAI-W21-YUKOSTYMD
      *
      *    日付妥当性チェック＆編集処理
           IF    ( SPA-GMN-W21-YUKOSTYMD   =   SPACE )
               MOVE    SPA-SYSYMDWH (1 : 6)
                                       TO  SPA-GMN-W21-YUKOSTYMD (1 : 6)
               MOVE    ". 1"           TO  SPA-GMN-W21-YUKOSTYMD (7 : 3)
               MOVE    SPA-SYSYMD   (1 : 6)
                                       TO  SPA-NAI-W21-YUKOSTYMD (1 : 6)
               MOVE    "01"            TO  SPA-NAI-W21-YUKOSTYMD (7 : 2)
      *
      *        システム管理情報再設定
               PERFORM 4100-SYSKANRI-RESET-SEC
               GO  TO  4100-YUKOSTYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W21-YUKOSTYMD
                                   TO  WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           IF  ( SPA-ERRCD         =   SPACE )
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W21-YUKOSTYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W21-YUKOSTYMD
           ELSE
               MOVE    WRK-YUKOSTYMD
                                   TO  WRK-YMD
               PERFORM 800-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W21-YUKOSTYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W21-YUKOSTYMD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  4100-YUKOSTYMD-CHK-EXT
           END-IF
      *
           IF    ( SPA-NAI-W21-YUKOSTYMD   <   "20020401" )
               MOVE    "0100"      TO  SPA-ERRCD
               MOVE    "H14. 4. 1" TO  SPA-GMN-W21-YUKOSTYMD
               MOVE    "20020401"  TO  SPA-NAI-W21-YUKOSTYMD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  4100-YUKOSTYMD-CHK-EXT
           END-IF
      *
           IF    ( SPA-NAI-W21-YUKOSTYMD
                               NOT =   SPA-NAI-W21-YUKOSTYMD-MOT )
      *        システム管理情報再設定
               PERFORM 4100-SYSKANRI-RESET-SEC
           END-IF
      *
           .
      *
       4100-YUKOSTYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    有効期間終了日
      *****************************************************************
       4100-YUKOEDYMD-CHK-SEC           SECTION.
      *
           MOVE    SPA-NAI-W21-YUKOEDYMD
                                   TO  WRK-YUKOEDYMD
           MOVE    SPACE           TO  SPA-NAI-W21-YUKOEDYMD
      *
      *    日付妥当性チェック＆編集処理
           IF    ( SPA-GMN-W21-YUKOEDYMD   =   SPACE )
               MOVE    "99999999"  TO  SPA-GMN-W21-YUKOEDYMD
                                       SPA-NAI-W21-YUKOEDYMD
               GO  TO  4100-YUKOEDYMD-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W21-YUKOEDYMD
                                   TO  WRK-YMD
           PERFORM 800-HIZUKE-CHK-SEC
           IF  ( SPA-ERRCD         =   SPACE )
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W21-YUKOEDYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W21-YUKOEDYMD
           ELSE
               MOVE    WRK-YUKOEDYMD
                                   TO  WRK-YMD
               PERFORM 800-HIZUKE-CHK-SEC
               MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-W21-YUKOEDYMD
               MOVE    WRK-SYMD    TO  SPA-NAI-W21-YUKOEDYMD
               MOVE    12          TO  SPA-GMN-W21-CUR
               GO  TO  4100-YUKOEDYMD-CHK-EXT
           END-IF
      *
           .
      *
       4100-YUKOEDYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    選択番号２
      *****************************************************************
       4100-SELNUM2-CHK-SEC            SECTION.
      *
           MOVE    ZERO            TO  SPA-GMN-W21-CUR
      *
           MOVE    W21-SELNUM2     TO  SPA-GMN-W21-SELNUM2
      *
           IF  (   SPA-GMN-W21-SELNUM2 =   ZERO )
               MOVE    3           TO  SPA-GMN-W21-CUR
               GO  TO  4100-SELNUM2-CHK-EXT
           END-IF
      *
      *    範囲内の番号が選択されていること
           IF    ( SPA-GMN-W21-SELNUM2 >   SPA-GMN-W21-RIREKILST-MAX )
               MOVE    100         TO  SPA-GMN-W21-CUR
               MOVE    "1008"      TO  SPA-ERRCD
               GO  TO  4100-SELNUM2-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-W21-SELNUM2 TO  SPA-GMN-W21-RIREKILST-SEL
      *
      *    入力項目領域編集処理
           MOVE    SPA-NAI-W21-RIREKILST-BRMNUM
                                   TO  WRK-BRMNUM
           MOVE    SPA-NAI-W21-TRYUKOSTYMD (SPA-GMN-W21-SELNUM2)
                                   TO  WRK-KJNYMD
      *
      *    入力領域初期化
           PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
           PERFORM 4100-INPUT-AREA-EDIT-SEC
      *
           MOVE    SPA-NAI-W21-RIREKILST-SELNUM
                                   TO  SPA-GMN-W21-SELNUM1
           MOVE    W21-SELNUM2     TO  SPA-GMN-W21-SELNUM2
      *
           MOVE    ZERO            TO  SPA-GMN-W21-CUR
      *
           .
      *
       4100-SELNUM2-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室リスト
      *****************************************************************
       4100-BRMLST-CHK-SEC             SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   200 )
      *
               IF    ( W21-BRMLST-SEL  (IDX2)  =   "T" )
      *
      *            入力項目領域編集処理
                   MOVE    SPA-GMN-W21-TBRMNUM2 (IDX2)
                                           TO  WRK-BRMNUM
                   MOVE    SPA-SYSYMD      TO  WRK-KJNYMD
      *
      *            入力領域初期化
                   PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
      *            履歴領域初期化
                   PERFORM 4201-RIREKI-AREA-CLEAR-SEC
      *
      *            入力データ編集処理
                   MOVE    IDX2            TO  WRK-SELNUM
                   PERFORM 4100-INPUT-AREA-EDIT-SEC
      *
                   MOVE    IDX2    TO  SPA-GMN-W21-BRMLST-SEL
      *
      *            履歴データ編集処理
                   PERFORM 4100-RIREKI-AREA-EDIT-SEC
      *
                   MOVE    200     TO  IDX2
               END-IF
           END-PERFORM
      *
           MOVE    3               TO  SPA-GMN-W21-CUR
      *
           .
       4100-BRMLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    履歴リスト
      *****************************************************************
       4100-RIREKILST-CHK-SEC      SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL     ( IDX2    >   20 )
               IF    ( W21-RIREKILST-SEL (IDX2)
                                       =   "T" )
      *
      *            入力項目領域編集処理
                   MOVE    SPA-NAI-W21-RIREKILST-BRMNUM
                                       TO  WRK-BRMNUM
                   MOVE    SPA-NAI-W21-TRYUKOSTYMD (IDX2)
                                       TO  WRK-KJNYMD
      *
      *            入力領域初期化
                   PERFORM 4201-INPUT-AREA-CLEAR-SEC
      *
                   PERFORM 4100-INPUT-AREA-EDIT-SEC
      *
                   MOVE    SPA-NAI-W21-RIREKILST-SELNUM
                                       TO  SPA-GMN-W21-SELNUM1
                   MOVE    IDX2        TO  SPA-GMN-W21-RIREKILST-SEL
                                           SPA-GMN-W21-SELNUM2
      *
                   MOVE    20          TO  IDX2
               END-IF
           END-PERFORM
      *
           MOVE    3                   TO  SPA-GMN-W21-CUR
      *
           .
       4100-RIREKILST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    ヘッダ情報初期化処理
      *****************************************************************
       4201-HEAD-AREA-CLEAR-SEC        SECTION.
      *
           INITIALIZE  SPA-GMN-W21-HEAD-AREA
                       SPA-NAI-W21-HEAD-AREA
      *
           .
      *
       4201-HEAD-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    入力情報領域初期化処理
      *****************************************************************
       4201-INPUT-AREA-CLEAR-SEC       SECTION.
      *
           INITIALIZE  SPA-GMN-W21-INPUT-AREA
                       SPA-NAI-W21-INPUT-AREA
      *
      *    有効期間の開始日と終了日を設定
           MOVE    SPA-SYSYMDWH (1 : 6)
                                   TO  SPA-GMN-W21-YUKOSTYMD (1 : 6)
           MOVE    ". 1"           TO  SPA-GMN-W21-YUKOSTYMD (7 : 3)
           MOVE    SPA-SYSYMD   (1 : 6)
                                   TO  SPA-NAI-W21-YUKOSTYMD (1 : 6)
           MOVE    "01"            TO  SPA-NAI-W21-YUKOSTYMD (7 : 2)
      *
           MOVE    "99999999"      TO  SPA-GMN-W21-YUKOEDYMD
                                       SPA-NAI-W21-YUKOEDYMD
      *
      *    システム管理情報再設定処理
           PERFORM 4100-SYSKANRI-RESET-SEC
      *
           MOVE    2               TO  SPA-GMN-W21-CUR
           .
      *
       4201-INPUT-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *   履歴情報領域初期化処理
      *****************************************************************
       4201-RIREKI-AREA-CLEAR-SEC      SECTION.
      *
           INITIALIZE  SPA-GMN-W21-RIREKILST
                       SPA-NAI-W21-RIREKILST
           MOVE    ZERO            TO  SPA-GMN-W21-BRMLST-SEL
      *
           .
      *
       4201-RIREKI-AREA-CLEAR-EXT.
           EXIT.
      *****************************************************************
      *    システム管理情報再設定処理
      *****************************************************************
       4100-SYSKANRI-RESET-SEC         SECTION.
      *
      *    コンボ初期処理
           MOVE    SPA-NAI-W21-YUKOSTYMD
                                   TO  WRK-KJN-YUKSTYMD
           PERFORM 3101-CMB-SYOKI-SEC
      *
           MOVE    SPA-NAI-W21-YUKOSTYMD
                                   TO  SPA-NAI-W21-YUKOSTYMD-MOT
           .
      *
       4100-SYSKANRI-RESET-EXT.
           EXIT.
      *****************************************************************
      *    病室番号入力チェック
      *****************************************************************
       4900-BRMNUM-INPUT-CHK-SEC      SECTION.
      *
      *    病室番号が入力されていること
           IF    ( SPA-GMN-W21-BRMNUM     NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1101"          TO  SPA-ERRCD
               MOVE   3                TO  SPA-GMN-W21-CUR
           END-IF
      *
           .
       4900-BRMNUM-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    共通関連チェック
      *****************************************************************
       4900-KANRENCHK-SEC              SECTION.
      *
      *    病室番号が入力されていること
           PERFORM 4900-BRMNUM-INPUT-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間開始日が入力されていること
           IF    ( SPA-NAI-W21-YUKOSTYMD NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1102"      TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間終了日が入力されていること
           IF    ( SPA-NAI-W21-YUKOEDYMD NOT =   SPACE )
               CONTINUE
           ELSE
               MOVE    "1103"      TO  SPA-ERRCD
               MOVE    12          TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間開始日≦有効期間終了日となっていること
           IF    ( SPA-NAI-W21-YUKOSTYMD <=  SPA-NAI-W21-YUKOEDYMD )
               CONTINUE
           ELSE
               MOVE    "1004"      TO  SPA-ERRCD
               MOVE    11          TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    有効期間終了日が過去日付でないこと
           IF    ( SPA-NAI-W21-YUKOEDYMD >=  SPA-SYSYMD  )
               CONTINUE
           ELSE
               MOVE    "1005"      TO  SPA-ERRCD
               MOVE    12          TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
      *    収容人数が１以上であること
           IF    ( SPA-GMN-W21-NINZU   >   0 )
               CONTINUE
           ELSE
               MOVE    "1009"      TO  SPA-ERRCD
               MOVE    6           TO  SPA-GMN-W21-CUR
               GO  TO  4900-KANRENCHK-EXT
           END-IF
      *
           .
      *
       4900-KANRENCHK-EXT.
           EXIT.
      *****************************************************************
      *       病室番号検索処理
      *****************************************************************
       4100-BRM-NUM-LSTSEL-SEC         SECTION.
      *
           MOVE    1               TO  FLG-BRM-NUM
           MOVE    ZERO            TO  IDX-BRMLST
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( FLG-BRM-NUM =   ZERO )
                OR       ( IDX1    >   SPA-GMN-W21-BRMLST-MAX )
      *
               IF    ( SPA-GMN-W21-BRMNUM
                                   =   SPA-GMN-W21-TBRMNUM2 (IDX1) )
                   MOVE    ZERO    TO  FLG-BRM-NUM
                   MOVE    IDX1    TO  IDX-BRMLST
               END-IF
      *
           END-PERFORM
      *
           .
      *
       4100-BRM-NUM-LSTSEL-EXT.
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
           IF    ( SPA-WIDCD       NOT =   SPACE )
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W21    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE                  W21
      *
           IF    ( SPA-MOTOPG      =   "W01" )
               MOVE    "病棟"      TO  W21-B09
           END-IF
      *
      *    病棟名称コンボ
           MOVE    SPA-GMN-W21-BTUNUM-G    TO  W21-BTU-NAME
           MOVE    SPA-GMN-W21-BTUNUM-MAX  TO  W21-BTU-NAME-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BTU-NAME-CNT )
                MOVE   SPA-GMN-W21-BTUNUMLST (IDX1)
                                   TO  W21-BTU-NAME-ITM (IDX1)
           END-PERFORM
      *
      *    病棟入院基本料
           MOVE    SPA-GMN-W21-BTUKHNRYO   TO  W21-BTU-KHNRYO
      *
      *    選択番号１
           MOVE    SPA-GMN-W21-SELNUM1     TO  W21-SELNUM1
      *
      *    病室番号
           MOVE    SPA-GMN-W21-BRMNUM      TO  W21-BRM-NUM
      *
      *    病室種別コンボ
           MOVE    SPA-GMN-W21-SBT-G       TO  W21-BRM-SBT
           MOVE    SPA-GMN-W21-SBT-MAX     TO  W21-BRM-SBT-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-SBT-CNT )
                MOVE   SPA-GMN-W21-SBTLST (IDX1)
                                   TO  W21-BRM-SBT-ITM (IDX1)
           END-PERFORM
      *
      *    特定入院料コンボ
           MOVE    SPA-GMN-W21-TOKNYUIN-G
                                       TO  W21-BRM-TOKUTEINYUIN
           MOVE    SPA-GMN-W21-TOKNYUIN-MAX
                                       TO  W21-BRM-TOKUTEINYUIN-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-TOKUTEINYUIN-CNT )
                MOVE   SPA-GMN-W21-TOKNYUINLST (IDX1)
                                   TO  W21-BRM-TOKUTEINYUIN-ITM (IDX1)
           END-PERFORM
      *
      *    収容人数
           MOVE    SPA-GMN-W21-NINZU       TO  W21-BRM-NINZU
      *
      *    室料差額コンボ
           MOVE    SPA-GMN-W21-SAGAKU-G    TO  W21-BRM-SAGAKU
           MOVE    SPA-GMN-W21-SAGAKU-MAX  TO  W21-BRM-SAGAKU-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-SAGAKU-CNT )
                MOVE   SPA-GMN-W21-SAGAKULST (IDX1)
                                   TO  W21-BRM-SAGAKU-ITM (IDX1)
           END-PERFORM
      *
      *    性別特定コンボ
           MOVE    SPA-GMN-W21-SEX-G       TO  W21-BRM-SEX
           MOVE    SPA-GMN-W21-SEX-MAX     TO  W21-BRM-SEX-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-SEX-CNT )
                MOVE   SPA-GMN-W21-SEXLST (IDX1)
                                   TO  W21-BRM-SEX-ITM (IDX1)
           END-PERFORM
      *
      *    内線番号
           MOVE    SPA-GMN-W21-NAITEL      TO  W21-BRM-NAITEL
      *
      *    病室科名コンボ
           MOVE    SPA-GMN-W21-SRYKA-G     TO  W21-BRM-KA
           MOVE    SPA-GMN-W21-SRYKA-MAX   TO  W21-BRM-KA-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRM-KA-CNT )
                MOVE   SPA-GMN-W21-SRYKALST (IDX1)
                                   TO  W21-BRM-KA-ITM (IDX1)
           END-PERFORM
      *
      *    入院基本料コンボ
           MOVE    SPA-GMN-W21-KHNRYO-G     TO  W21-KHNRYO
           MOVE    SPA-GMN-W21-KHNRYO-MAX   TO  W21-KHNRYO-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-KHNRYO-CNT )
                MOVE   SPA-GMN-W21-KHNRYOLST (IDX1)
                                   TO  W21-KHNRYO-ITM (IDX1)
           END-PERFORM
      *
           MOVE    SPA-GMN-W21-KHNTEN      TO  W21-KHNTEN
      *
      *    有効期間開始日
           MOVE    SPA-GMN-W21-YUKOSTYMD   TO  W21-YUKOSTYMD
      *
      *    有効期間終了日
           MOVE    SPA-GMN-W21-YUKOEDYMD   TO  W21-YUKOEDYMD
      *
      *    選択番号２
           MOVE    SPA-GMN-W21-SELNUM2     TO  W21-SELNUM2
      *
      *    病室リスト
           MOVE    SPACE                   TO  W21-BRMLST-TBL
      *
           MOVE    SPA-GMN-W21-BRMLST-MAX  TO  W21-BRMLST-CNT
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   W21-BRMLST-CNT )
      *
               MOVE    SPA-GMN-W21-TSELNUM  (IDX1)
                                       TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9
                                       TO  W21-TSELNUM  (IDX1)
               STRING  "    "
                       SPA-GMN-W21-TBRMNUM (IDX1)
                       DELIMITED   BY  SIZE
               INTO    W21-TBRM-NUM (IDX1)
               END-STRING
      *
               MOVE    SPA-GMN-W21-TSBT (IDX1)
                                       TO  W21-TBRM-SBT (IDX1)
               MOVE    SPA-GMN-W21-TTOKNYUIN (IDX1)
                                       TO  W21-TBRM-TOKUTEINYUIN (IDX1)
               MOVE    SPA-GMN-W21-TNINZU (IDX1)
                                       TO  WRK-ZZZZZZZZZ9
               MOVE    WRK-ZZZZZZZZZ9
                                       TO  W21-TBRM-NINZU (IDX1)
               MOVE    SPA-GMN-W21-TSAGAKU (IDX1)
                                       TO  WRK-ZZZZZZZZZ9
               MOVE    WRK-ZZZZZZZZZ9
                                       TO  W21-TBRM-SAGAKU (IDX1)
               MOVE    SPA-GMN-W21-TSEX (IDX1)
                                       TO  W21-TBRM-SEX (IDX1)
               MOVE    SPA-GMN-W21-TNAITEL (IDX1)
                                       TO  W21-TBRM-NAITEL (IDX1)
               MOVE    SPA-GMN-W21-TSRYKA  (IDX1)
                                       TO  W21-TBRM-KA (IDX1)
               MOVE    SPA-GMN-W21-TKHNRYO  (IDX1)
                                       TO  W21-TKHNRYO (IDX1)
               MOVE    SPA-GMN-W21-TYUKOSTYMD (IDX1)
                                       TO  W21-TYUKOSTYMD (IDX1)
               MOVE    SPA-GMN-W21-TYUKOEDYMD (IDX1)
                                       TO  W21-TYUKOEDYMD (IDX1)
      *
               IF    ( SPA-GMN-W21-BRMLST-SEL  =   IDX1 )
                   MOVE    "T"         TO  W21-BRMLST-SEL (IDX1)
               ELSE
                   MOVE    "F"         TO  W21-BRMLST-SEL (IDX1)
               END-IF
      *
           END-PERFORM
      *
      *    履歴リスト
           INITIALIZE                      W21-RIREKILST-TBL
           MOVE    SPA-GMN-W21-RIREKILST-MAX
                                       TO  W21-RIREKILST-CNT
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >   SPA-GMN-W21-RIREKILST-MAX )
      *
               MOVE    SPA-GMN-W21-TRSELNUM (IDX1)
                                       TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9        TO  W21-TRSELNUM (IDX1)
      *
               STRING  SPA-GMN-W21-TRYUKOSTYMD (IDX1)
                       " 〜 "
                       SPA-GMN-W21-TRYUKOEDYMD (IDX1)
                       DELIMITED   BY  SIZE
               INTO    W21-TRIREKI (IDX1)
               END-STRING
      *
               IF    ( IDX1    =   SPA-GMN-W21-RIREKILST-SEL )
                   MOVE    "T"         TO  W21-RIREKILST-SEL (IDX1)
               ELSE
                   MOVE    "F"         TO  W21-RIREKILST-SEL (IDX1)
               END-IF
      *
           END-PERFORM
      *
           IF    ( SPA-NAI-W21-YUKOSTYMD  >=   CONST-H180701 )
            AND  ( SPA-NAI-W21-BTUSBT      =   "04" OR "09" )
               MOVE    "入院基本料"    TO  W21-LBLKHNRYO1
               MOVE    "点"            TO  W21-LBLKHNRYO2
           END-IF
      *
           IF    ( SPA-SYSYMD             >=   CONST-H180701 )
            AND  ( SPA-NAI-W21-BTUSBT      =   "04" OR "09" )
               MOVE    "入院基本料"    TO  W21-TKHNRYO-TITLE
           END-IF
      *
      *    項目状態編集
           PERFORM 500-GMNHEN-STATE-EDIT-SEC
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目状態編集処理
      *****************************************************************
       500-GMNHEN-STATE-EDIT-SEC       SECTION.
      *
           MOVE    WIDGET-NORMAL       TO  W21-B02-STATE
                                           W21-B05-STATE
                                           W21-B06-STATE
                                           W21-B07-STATE
                                           W21-B08-STATE
                                           W21-B09-STATE
                                           W21-B12-STATE
                                           W21-BRM-NUM-STT
                                           W21-BRM-SBT-STT
                                           W21-BRM-SBT-ITM-STT
                                           W21-BRM-TOKUTEINYUIN-STT
                                           W21-BRM-TOKUTEINYUIN-ITM-STT
                                           W21-BRM-NINZU-STT
                                           W21-BRM-SAGAKU-STT
                                           W21-BRM-SAGAKU-ITM-STT
                                           W21-BRM-SEX-STT
                                           W21-BRM-SEX-ITM-STT
                                           W21-BRM-NAITEL-STT
                                           W21-BRM-KA-STT
                                           W21-BRM-KA-ITM-STT
                                           W21-YUKOSTYMD-STT
                                           W21-YUKOEDYMD-STT
                                           W21-KHNRYO-STT
                                           W21-KHNRYO-ITM-STT
                                           W21-KHNTEN-STT
      *
      *
           IF    ( SPA-GMN-W21-BRMLST-MAX  >=  200 )
               MOVE    WIDGET-INSENSITIVE  TO  W21-B06-STATE
           END-IF
      *
           IF    ( SPA-NAI-W21-YUKOEDYMD-OLD   NOT =  SPACE )
            AND  ( SPA-NAI-W21-YUKOEDYMD-OLD       <  SPA-SYSYMD )
               MOVE    WIDGET-INSENSITIVE
                                       TO  W21-BRM-NUM-STT
                                           W21-BRM-SBT-STT
                                           W21-BRM-SBT-ITM-STT
                                           W21-BRM-TOKUTEINYUIN-STT
                                           W21-BRM-TOKUTEINYUIN-ITM-STT
                                           W21-BRM-NINZU-STT
                                           W21-BRM-SAGAKU-STT
                                           W21-BRM-SAGAKU-ITM-STT
                                           W21-BRM-SEX-STT
                                           W21-BRM-SEX-ITM-STT
                                           W21-BRM-NAITEL-STT
                                           W21-BRM-KA-STT
                                           W21-BRM-KA-ITM-STT
                                           W21-YUKOSTYMD-STT
                                           W21-YUKOEDYMD-STT
                                           W21-B06-STATE
                                           W21-B07-STATE
                                           W21-B08-STATE
           END-IF
      *
           IF    ( SPA-NAI-W21-YUKOSTYMD  >=   CONST-H180701 )
            AND  ( SPA-NAI-W21-BTUSBT      =   "04" OR "09" )
                   CONTINUE
            ELSE
               MOVE    WIDGET-INSENSITIVE
                                       TO  W21-KHNRYO-STT
                                           W21-KHNRYO-ITM-STT
                                           W21-KHNTEN-STT
           END-IF
      *
           .
       500-GMNHEN-STATE-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           IF     (SPA-ERRCD           =   SPACE)  AND
                  (SPA-GMN-W21-CUR     =   ZERO )
               PERFORM 5011-INPUT-CUR-SEC
           END-IF
      *
           PERFORM 5012-SKIP-CUR-SEC
      *
           EVALUATE    SPA-GMN-W21-CUR
           WHEN    001
               MOVE    "BTU_NAME"          TO  MCP-WIDGET
           WHEN    002
               MOVE    "SELNUM1"           TO  MCP-WIDGET
           WHEN    003
               MOVE    "BRM_NUM"           TO  MCP-WIDGET
           WHEN    004
               MOVE    "BRM_SBT"           TO  MCP-WIDGET
           WHEN    005
               MOVE    "BRM_TOKUTEINYUIN"  TO  MCP-WIDGET
           WHEN    006
               MOVE    "BRM_NINZU"         TO  MCP-WIDGET
           WHEN    007
               MOVE    "BRM_SAGAKU"        TO  MCP-WIDGET
           WHEN    008
               MOVE    "BRM_SEX"           TO  MCP-WIDGET
           WHEN    009
               MOVE    "BRM_NAITEL"        TO  MCP-WIDGET
           WHEN    010
               MOVE    "BRM_KA"            TO  MCP-WIDGET
           WHEN    011
               MOVE    "YUKOSTYMD"         TO  MCP-WIDGET
           WHEN    012
               MOVE    "YUKOEDYMD"         TO  MCP-WIDGET
           WHEN    013
               MOVE    "KHNRYO"            TO  MCP-WIDGET
           WHEN    100
               MOVE    "SELNUM2"           TO  MCP-WIDGET
           WHEN    206
               MOVE    "B06"               TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       5011-INPUT-CUR-SEC          SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "BTU_NAME"
               MOVE    002             TO  SPA-GMN-W21-CUR
           WHEN    "SELNUM1"
               MOVE    003             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_NUM"
               MOVE    004             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_SBT"
               MOVE    005             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_TOKUTEINYUIN"
               MOVE    006             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_NINZU"
               MOVE    007             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_SAGAKU"
               MOVE    008             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_SEX"
               MOVE    009             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_NAITEL"
               MOVE    010             TO  SPA-GMN-W21-CUR
           WHEN    "BRM_KA"
               MOVE    013             TO  SPA-GMN-W21-CUR
           WHEN    "KHNRYO"
               MOVE    011             TO  SPA-GMN-W21-CUR
           WHEN    "YUKOSTYMD"
               MOVE    012             TO  SPA-GMN-W21-CUR
           WHEN    "YUKOEDYMD"
               MOVE    206             TO  SPA-GMN-W21-CUR
           WHEN    "SELNUM2"
               MOVE    003             TO  SPA-GMN-W21-CUR
           END-EVALUATE
      *
           .
      *
       5011-INPUT-CUR-EXT.
           EXIT.
      *****************************************************************
      *    画面カーソルスキップ処理
      *****************************************************************
       5012-SKIP-CUR-SEC           SECTION.
      *
           IF    ( SPA-GMN-W21-CUR =   3 )
               IF    ( W21-BRM-NUM-STT =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   4
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   4 )
               IF    ( W21-BRM-SBT-ITM-STT
                                       =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   5
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   5 )
               IF    ( W21-BRM-TOKUTEINYUIN-STT
                                       =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   6
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   6 )
               IF    ( W21-BRM-NINZU-STT
                                       =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   7
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   7 )
               IF    ( W21-BRM-SAGAKU-STT
                                       =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   8
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   8 )
               IF    ( W21-BRM-SEX-STT
                                       =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   9
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   9 )
               IF    ( W21-BRM-NAITEL-STT
                                       =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   10
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   10 )
               IF    ( W21-BRM-KA-STT
                                       =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   13
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   13 )
               IF    ( W21-KHNRYO-STT
                                       =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   11
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   11 )
               IF    ( W21-YUKOSTYMD-STT
                                       =   WIDGET-INSENSITIVE )
                   COMPUTE SPA-GMN-W21-CUR =   13
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-W21-CUR =   12 )
               IF    ( W21-YUKOEDYMD-STT
                                       =   WIDGET-INSENSITIVE )
                   MOVE    206         TO   SPA-GMN-W21-CUR
               END-IF
           END-IF
      *
           IF    ( W21-BRM-NUM-STT     =   WIDGET-INSENSITIVE )
               MOVE    100             TO  SPA-GMN-W21-CUR
           END-IF
      *
           .
       5012-SKIP-CUR-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "0001"
               MOVE    "選択番号入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0002"
               MOVE    "病室番号入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0003"
               MOVE    "病室種別入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0004"
               MOVE    "特定入院料入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0005"
               MOVE    "収容人数入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0006"
               MOVE    "室料差額入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0007"
               MOVE    "性別特定入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0008"
               MOVE    "内線番号入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0009"
               MOVE    "診療科入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0010"
               MOVE    "入院基本料入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0011"
               MOVE    "有効期間開始日入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0012"
               MOVE    "有効期間終了日入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0013"
               MOVE    "室歴番号入力エラー"
                                       TO  SPA-ERRMSG
           WHEN    "0100"
               MOVE    SPACE           TO  SPA-ERRMSG
               STRING  "有効開始日は平成１４年４月１日以降にして"
                       "ください"
                       DELIMITED   BY  SIZE
               INTO    SPA-ERRMSG
               END-STRING
           WHEN    "1001"
               MOVE    "追加可能最大件数に達しました"
                                       TO  SPA-ERRMSG
           WHEN    "1002"
               MOVE    "変更対象の病棟は存在しません"
                                       TO  SPA-ERRMSG
           WHEN    "1003"
               MOVE    "削除対象の病棟は存在しません"
                                       TO  SPA-ERRMSG
           WHEN    "1004"
               MOVE    "有効期間開始日＞有効期間終了日となっています"
                                       TO  SPA-ERRMSG
           WHEN    "1005"
               MOVE    SPACE           TO  SPA-ERRMSG
               STRING  "有効期間終了日が過去日となるデータの"
                       "追加・変更は行えません"
                       DELIMITED   BY  SIZE
               INTO    SPA-ERRMSG
               END-STRING
           WHEN    "1006"
               MOVE    "病棟名称を選択して下さい"
                                       TO  SPA-ERRMSG
           WHEN    "1007"
               MOVE    "入力番号に該当する病棟は存在しません"
                                       TO  SPA-ERRMSG
           WHEN    "1008"
               MOVE    "範囲内の選択番号を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1009"
               MOVE    "収容人数に１以上を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1101"
               MOVE     "病室番号を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1102"
               MOVE     "有効期間開始日を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1103"
               MOVE     "有効期間終了日を入力してください"
                                       TO  SPA-ERRMSG
           WHEN    "1104"
               MOVE    "有効期間の重複するデータが存在します"
                                       TO  SPA-ERRMSG
           WHEN    "1105"
               MOVE    "病室を選択してください"
                                       TO  SPA-ERRMSG
           WHEN    "1106"
               MOVE    "病室番号の変更はできません"
                                       TO  SPA-ERRMSG
           WHEN    "1107"
               MOVE    "有効期間の開始日と終了日は同時に変更できません"
                                       TO  SPA-ERRMSG
           WHEN    "1108"
               MOVE    "入院中の患者が存在するため削除できません"
                                       TO  SPA-ERRMSG
           WHEN    "1201"
               MOVE    "更新できませんでした"
                                       TO  SPA-ERRMSG
           WHEN    "1202"
               MOVE    "追加できませんでした"
                                       TO  SPA-ERRMSG
           WHEN    "1203"
               MOVE    "削除できませんでした"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPA-MOTOPG          TO  SPA-GMN-W21-MOTOPG
      *
           MOVE    SPACE               TO  WERR
           MOVE    SPA-ERRCD           TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  WERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "W21"               TO  SPA-MOTOPG
           MOVE    "WERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "WERR"              TO  MCP-WINDOW
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
       520-WIDSET-SEC              SECTION.
      *
           EVALUATE    SPA-WIDCD
           WHEN    "2001"
               MOVE    "該当の病室を削除します。よろしいですか"
                                        TO  WRK-WIDMSG
           END-EVALUATE
      *
      *
           MOVE    SPA-MOTOPG           TO  SPA-GMN-W21-MOTOPG
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W21"                TO  SPA-MOTOPG
           MOVE    "WID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-WIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟コンボボックスチェック処理
      *****************************************************************
       4200-BTUNUMLST-CHK-SEC          SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W21-BTUNUM-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W21-BTUNUML (IDX-CMB)
                                       =   WRK-CMB-CD )
      *
                   MOVE    SPA-GMN-W21-BTUNUMLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM
      *
                   MOVE    SPA-NAI-W21-BTUINF-TOKNYUIN (IDX-CMB)
                                   TO  WRK-CMB-ITM2
      *
                   MOVE    SPA-NAI-W21-BTUINF-KHNSRYCD (IDX-CMB)
                                   TO  WRK-CMB-ITM3
      *
                   MOVE    SPA-NAI-W21-BTUINF-STYUKYMD (IDX-CMB)
                                   TO  WRK-CMB-ITM4
                   MOVE    SPA-NAI-W21-BTUINF-SBT (IDX-CMB)
                                   TO  WRK-CMB-ITM5
               END-IF
      *
           END-PERFORM
      *
           .
       4200-BTUNUMLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療科コンボボックスチェック処理
      *****************************************************************
       4200-SRYKALST-CHK-SEC               SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W21-SRYKA-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W21-SRYKAL (IDX-CMB)
                                       =   WRK-CMB-CD )
      *
                   MOVE    SPA-GMN-W21-SRYKALST   (IDX-CMB)
                                   TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-SRYKALST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院基本料コンボボックスチェック処理
      *****************************************************************
       4200-KHNRYOLST-CHK-SEC          SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W21-KHNRYO-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W21-KHNRYOL (IDX-CMB)
                                       =   WRK-CMB-CD )
      *
                   MOVE    SPA-GMN-W21-KHNRYOLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM
                   MOVE    SPA-NAI-W21-KHNRYOLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM2
               END-IF
      *
           END-PERFORM
      *
           .
       4200-KHNRYOLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室種別コンボボックスチェック処理
      *****************************************************************
       4200-SBTLST-CHK-SEC                 SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W21-SBT-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W21-SBTL (IDX-CMB)
                                       =   WRK-CMB-CD )
      *
                   MOVE    SPA-GMN-W21-SBTLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-SBTLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料コンボボックスチェック処理
      *****************************************************************
       4200-TOKNYUINLST-CHK-SEC    SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W21-TOKNYUIN-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W21-TOKNYUINL (IDX-CMB)
                                       =   WRK-CMB-CD )
      *
                   MOVE    SPA-GMN-W21-TOKNYUINLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM
      *
                   MOVE    SPA-NAI-W21-TOKNYUINL   (IDX-CMB)
                                   TO  WRK-CMB-ITM2
               END-IF
      *
           END-PERFORM
      *
           .
       4200-TOKNYUINLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    室料差額コンボボックスチェック処理
      *****************************************************************
       4200-SAGAKULST-CHK-SEC          SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W21-SAGAKU-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W21-SAGAKUL (IDX-CMB)
                                       =   WRK-CMB-CD )
      *
                   MOVE    SPA-GMN-W21-SAGAKULST   (IDX-CMB)
                                   TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-SAGAKULST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    性別コンボボックスチェック処理
      *****************************************************************
       4200-SEXLST-CHK-SEC         SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB >   SPA-GMN-W21-SEX-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( SPA-GMN-W21-SEXL (IDX-CMB)
                                       =   WRK-CMB-CD )
      *
                   MOVE    SPA-GMN-W21-SEXLST   (IDX-CMB)
                                   TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       4200-SEXLST-CHK-EXT.
           EXIT.
      *****************************************************************
      *    全角半角混在チェック
      *****************************************************************
       800-ENRTRY-CHK-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-ENTRYCHK
      *
           IF  ( WRK-KANACHK-INPUT
                                   =   SPACE )
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
           MOVE    SPACE           TO  ORCSKANACHKAREA
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    WRK-KANACHK-INPUT
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-KANACHK-INPUT
           IF      ( KANACHK-RC    NOT =   ZERO )
               MOVE    9           TO  FLG-ENTRYCHK
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
           MOVE    KANACHK-SYUBETU TO  FLG-ENTRYCHK
      *
           .
       800-ENRTRY-CHK-EXT.
           EXIT.
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       800-HIZUKE-CHK-SEC             SECTION.
      *
           IF    ( WRK-YMD         =   "00000000" 
                                   OR  "99999999" )
               MOVE    WRK-YMD     TO  WRK-HENYMDG
                                       WRK-SYMD
           ELSE
               INITIALIZE                  ORCSGDAYAREA
               MOVE    WRK-YMD         TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
               IF  ( SGDAY-RC          =   ZERO )
                   MOVE    SGDAY-OTDAY TO  WRK-HENYMDG
                   MOVE    SGDAY-SDAY  TO  WRK-SYMD
               ELSE
                   MOVE    "0001"      TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       800-HIZUKE-CHK-EXT.
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
      *    点数マスタ検索処理(KEY)
      *****************************************************************
       900-TENSU-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
      *
           MOVE    WRK-TNSSRYCD        TO  TNS-SRYCD
           MOVE    WRK-TNSYMD          TO  TNS-YUKOSTYMD
                                           TNS-YUKOEDYMD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               MOVE    1               TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-TENSU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY10)
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYSKANRI-KEY10-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-SEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-FET-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY8)
      *****************************************************************
       900-SYSKANRI-KEY8-SEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY8-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY8)
      *****************************************************************
       900-SYSKANRI-KEY8-FET-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY8-FET-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY9)
      *****************************************************************
       900-SYSKANRI-KEY9-SEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY9-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY9)
      *****************************************************************
       900-SYSKANRI-KEY9-FET-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key9"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY9-FET-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴検索処理(KEY15)
      *****************************************************************
       900-PTNYUINRRK-KEY15-SEL-SEC    SECTION.
      *
           MOVE    ZERO            TO  FLG-PTNYUINRRK
      *
           INITIALIZE                  PTNYUINRRK-REC
           MOVE    SPA-HOSPID      TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-W21-5002-KBNCD
                                   TO  PTNYUINRRK-BRMNUM
           MOVE    SPA-NAI-W21-YUKOEDYMD-OLD
                                   TO  PTNYUINRRK-NYUINYMD
           MOVE    SPA-NAI-W21-YUKOSTYMD-OLD
                                   TO  PTNYUINRRK-TAIINYMD
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
           MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
           MOVE    "key15"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
               INITIALIZE                  PTNYUINRRK-REC
           END-IF
      *
           MOVE    "tbl_ptnyuinrrk"    TO  MCP-TABLE
           MOVE    "key15"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-PTNYUINRRK-KEY15-SEL-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC          SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       910-DBFETCH-SEC            SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ追加処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ更新処理
      *****************************************************************
       910-DBUPDATE-SEC                SECTION.
      *
           MOVE    "DBUPDATE"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ削除処理
      *****************************************************************
       910-DBDELETE-SEC                SECTION.
      *
           MOVE    "DBDELETE"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW                  SECTION.
      *
           MOVE   LOW-VALUE         TO  MCP-TABLE
                                        MCP-PATHNAME
           MOVE   "PUTWINDOW"       TO  MCP-FUNC
           CALL   "MONFUNC"         USING
                                    MCPAREA
                                    MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *
