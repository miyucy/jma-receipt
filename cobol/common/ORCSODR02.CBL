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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCSODR02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : オーダー編集（退院）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/11/11    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
       WORKING-STORAGE                 SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PTNYUINRRK          PIC 9(01).
           03  FLG-NYUINACCT           PIC 9(01).
           03  FLG-ORDER               PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-SYUNOU              PIC 9(01).
           03  FLG-SYUMEI              PIC 9(01).
           03  FLG-SRYACCT             PIC 9(01).
           03  FLG-PTINF               PIC 9(01).
           03  FLG-END                 PIC 9(01).
           03  FLG-ORCSNUM             PIC 9(01).
           03  FLG-ENTRYCHK            PIC 9(01).
           03  FLG-ITEM-CHK-G.
               05  FLG-ITEM-CHK        PIC 9(01)   OCCURS  20.
           03  FLG-TEIKIARI            PIC 9(01).
           03  FLG-SYUARI              PIC 9(01).
           03  FLG-ACCTARI             PIC 9(01).
           03  FLG-TEIKIJOB            PIC 9(01).
           03  FLG-ORCSDAY             PIC 9(01).
           03  FLG-PTTEIKIRRK          PIC 9(01).
           03  FLG-SYUDAY              PIC 9(01).
           03  FLG-HIT                 PIC 9(01).
           03  FLG-HKNCOMBI            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-TAIINCD             PIC 9(05).
           03  CNT-NYUINKA             PIC 9(05).
           03  CNT-HKNCOMBI            PIC 9(05).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                    PIC 9(05).
           03  IDX1                    PIC 9(05).
           03  IDX2                    PIC 9(05).
           03  IDX3                    PIC 9(05).
           03  IDX4                    PIC 9(05).
           03  IDXA                    PIC 9(05).
           03  IDX-SYU                 PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-KANACHK-MAE-INPUT   PIC X(500).
           03  WRK-SYS-KANRICD         PIC X(04).
           03  WRK-SYS-KBNCD           PIC X(08).
           03  WRK-SAGAKU              PIC 9(08).
           03  WRK-SNUM-INX            PIC X(26).
           03  WRK-SNUM-OUTNUM         PIC 9(12).
           03  WRK-RRKNUM              PIC 9(03).
           03  WRK-SHONUM              PIC 9(03).
           03  WRK-SKYSTYMD            PIC X(08).
           03  WRK-KIJUNYMD            PIC X(08).
           03  WRK-ZOGENPTN            PIC X(01).
           03  WRK-ZOGEN               PIC S9(05).
           03  WRK-KEISANYMD           PIC X(08).
           03  WRK-NYUINYMD            PIC X(08).
           03  WRK-TAIINYMD.
               05  WRK-TAIINYM         PIC X(06).
               05  WRK-TAIINDD         PIC 9(02).
           03  WRK-STYMD               PIC X(08).
           03  WRK-EDYMD               PIC X(08).
           03  WRK-NISSU1              PIC 9(05).
           03  WRK-NISSU2              PIC 9(05).
           03  WRK-SYMD                PIC X(08).
           03  WRK-DENPNUM             PIC 9(07).
           03  WRK-DENPNUM-X           PIC X(08).
           03  WRK-NYUINKA             PIC X(02).
           03  WRK-BTUNUM              PIC X(02).
           03  WRK-BRMNUM              PIC X(08).
           03  WRK-DRCD                PIC X(04).
           03  WRK-DENPEDANUM          PIC 9(03).
           03  WRK-SKYMONEY            PIC  S9(07).
           03  WRK-TAIINCD             PIC X(02).
           03  WRK-INF                 PIC 9(02).
           03  WRK-COMBI-HKNCOMBI      PIC 9(04).
      *
       01  ITEM-AREA.
           03  ITEM-TAIINCD            PIC X(02).
           03  ITEM-NYUINKA            PIC X(02).
           03  ITEM-HKNCOMBI           PIC 9(04).
      *
       01  ERRCD-AREA.
           03  ERRCD-ITEM              PIC X(04).
           03  ERRCD-ERRCD             PIC X(04).
           03  ERRCD-ORDER             PIC X(04).
      *
       01  CONST-AREA.
           03  CONST-SYU-MAX           PIC 9(05)   VALUE   10.
           03  CONST-JOB-SHELLID       PIC X(08)   VALUE   "TEIKI1".
           03  CONST-JOB-JOBID         PIC 9(07)   VALUE   1.
      *
      *
      *    入院CLAIM項目IDコピー句
           COPY    "CPNCLAIMID.INC".
      *
      *    患者入院履歴ワーク
       01  WKPTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC"  REPLACING  //PTNYUINRRK-//
                                       BY         //WKPTNYUINRRK-//.
      *
      *    患者入院履歴退避
       01  TRRK-REC.
           COPY    "CPPTNYUINRRK.INC"  REPLACING  //PTNYUINRRK-//
                                       BY         //TRRK-//.
      *
      *    定期請求履歴集計用ワーク
       01  SUMTEIKIRRK-REC.
         02    SUMTEIKIRRK-MAX         PIC 9(05).
         02    SUMTEIKIRRK-OCC     OCCURS 50.
           COPY  "CPTEIKIRRK.INC"  REPLACING  //TEIKIRRK-//
                                           BY //SUMTEIKIRRK-//.
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1005.INC".
           COPY    "CPSK0042.INC".
           COPY    "CPSK5013.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    オーダーテーブル
       01  ORDER-REC.
           COPY    "CPORDER.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    日別収納マスター
       01  SYUDAY-REC.
           COPY    "CPSYUDAY.INC".
      *
      *    収納明細マスター
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    患者定期請求履歴
        01 PTTEIKIRRK-REC.
           COPY     "CPPTTEIKIRRK.INC".
      *
      *    定期請求履歴
        01 TEIKIRRK-REC.
           COPY     "CPTEIKIRRK.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    オーダー共通サブ
           COPY    "CPORCSODRS01.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *    カナチェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    日報キー取得サブ
           COPY "CPORCSDAILYKEY.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    病室名称編集
           COPY    "CPORCSBRMNUM.INC".
      *
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *
      *    負担金計算サブ
       01  LNK-ORCS02-REC.
           COPY  "CPORCS02.INC".
       01  LNK-SYUNOU-REC-T.
         02 LNK-SYUNOU-REC     OCCURS 10.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
       01  LNK-SYUDAY-REC-T.
         02 LNK-SYUDAY-REC     OCCURS 10.
           COPY  "CPSYUDAY.INC"  REPLACING  //SDAY-// BY //LNK-SDAY-//.
      *
      *    入院会計作成サブ
           COPY    "CPORCSODRNACCT.INC".
       01  LNK-PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC"  REPLACING  //PTNYUINRRK-//
                                       BY         //LNK-PTNYUINRRK-//.
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                         SECTION.
      *
      *    入院異動チェックサブ
           COPY    "CPORCSODR.INC".
       01  LNK-ORDER-REC.
           02  LNK-ORDER-MAX           PIC 9(03).
           02  LNK-ORDER-OCC           OCCURS   30.
           COPY    "CPORDER.INC"       REPLACING  //ORDER-//
                                       BY         //LNK-ORDER-//.
      *
      ******************************************************************
      *
       PROCEDURE                       DIVISION
                                       USING
                                               SODR-AREA
                                               LNK-ORDER-REC.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           IF    ( FLG-END     =   ZERO )
               PERFORM 200-MAIN-SEC
           END-IF
      *
           PERFORM 300-END-SEC
      *
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  ERRCD-AREA
           INITIALIZE                  ITEM-AREA
      *
           INITIALIZE                  TRRK-REC
           INITIALIZE                  SPA-AREA
           INITIALIZE                  SODR-OT
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           PERFORM 2001-INPUT-CHK-SEC
      *
      *
           IF    ( ERRCD-ITEM      =   SPACE )
               PERFORM 2002-KANREN-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
            AND  ( ERRCD-ITEM      =   SPACE )
               PERFORM 2101-ORCSNYUFTN-CALL-SEC
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
            AND  ( ERRCD-ITEM      =   SPACE )
               PERFORM VARYING IDX-SYU     FROM    1   BY  1
                       UNTIL ( IDX-SYU         >   CONST-SYU-MAX )
                        OR   ( LNK-SYU-SKYSTYMD(IDX-SYU)
                                               =   SPACE )
                        OR   ( ERRCD-ORDER NOT =   SPACE )
      *
                   PERFORM 2101-SYUNOU-HEN-SEC
      *
               END-PERFORM
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
            AND  ( ERRCD-ITEM      =   SPACE )
      *
               IF    ( FLG-END =   ZERO )
                   PERFORM 2101-PTNYUINRRK-UPDATE-SEC
               END-IF
      *
               IF    ( FLG-END =   ZERO )
                   IF    ( FLG-SYUARI      =   1 )
                       PERFORM 2101-TORIKESI-KOUSHIN-SEC
                   END-IF
               END-IF
      *
               IF    ( FLG-END =   ZERO )
                   PERFORM 2101-ORCSODRNACCT-CALL-SEC
               END-IF
      *
               PERFORM VARYING IDX-SYU     FROM    1   BY  1
                       UNTIL ( IDX-SYU         >   CONST-SYU-MAX )
                        OR   ( LNK-SYU-SKYSTYMD(IDX-SYU)
                                               =   SPACE )
                        OR   ( FLG-END         =   1 )
      *
      *            収納マスタ更新処理
                   PERFORM 2102-SYUNOU-UPD-SEC
      *
               END-PERFORM
      *
               IF    ( FLG-END =   ZERO )
                   PERFORM 2101-PTINF-UPDATE-SEC
               END-IF
      *
               IF    ( FLG-END  =   ZERO )
                   IF    ( SODR-PROCKBN    =   "1" )
                       PERFORM 2101-ORDER-RECONF-SEC
                   END-IF
               END-IF
      *
               IF    ( FLG-END =   ZERO )
                   PERFORM 2101-ORDER-INSERT-SEC
               END-IF
           ELSE
      *
               IF    ( SODR-PROCKBN    =   "1" )
                       PERFORM 2101-ERRINF-HEN-SEC
               ELSE
                   IF    ( FLG-END  =   ZERO )
                       PERFORM 2101-ORDER-INSERT-SEC
                   END-IF
               END-IF
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    項目チェック処理
      *****************************************************************
       2001-INPUT-CHK-SEC              SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   LNK-ORDER-MAX )
      *
               EVALUATE    LNK-ORDER-ITEMID (IDXA)
               WHEN    NCLAIMID-TAIINCDID
                   PERFORM 20011-TAIINCD-CHK-SEC
               WHEN    NCLAIMID-NYUINKAID
                   PERFORM 20011-NYUINKA-CHK-SEC
               WHEN    NCLAIMID-HKNCOMBIID
                   PERFORM 20011-HKNCOMBI-CHK-SEC
               END-EVALUATE
      *
           END-PERFORM
      *
           .
       2001-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    退院事由チェック処理
      *****************************************************************
       20011-TAIINCD-CHK-SEC           SECTION.
      *
           COMPUTE CNT-TAIINCD     =   CNT-TAIINCD +   1
      *
           IF    ( CNT-TAIINCD     =   1 )
      *
               IF    ( LNK-ORDER-ITEM (IDXA)   =   SPACE )
                   CONTINUE
               ELSE
                   PERFORM 200111-TAIINCD-CHK-SEC
               END-IF
           ELSE
      *
                   MOVE    "2002"  TO   ERRCD-ERRCD
                   PERFORM 2100-ITEM-WRN-SET-SEC
           END-IF
      *
           .
       20011-TAIINCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    退院事由チェック処理
      *****************************************************************
       200111-TAIINCD-CHK-SEC          SECTION.
      *
           MOVE    "5013"      TO  WRK-SYS-KANRICD
           MOVE    LNK-ORDER-ITEM (IDXA)
                               TO  WRK-SYS-KBNCD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           IF    ( FLG-SYSKANRI    =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5013-REC
           END-IF
      *
           MOVE    ZERO            TO  FLG-HIT
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                     OR  ( ITEM-TAIINCD    NOT =   SPACE    )
      *
               IF    ( LNK-ORDER-REMARKS (IDXA)
                                   =   SYS-5013-NAME )
                   MOVE    SYS-5013-KBNCD
                                   TO  ITEM-TAIINCD
               END-IF
      *
               MOVE    PATH-TBL-SYSKANRI-KEY2
                                   TO   MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  SYS-5013-REC
               ELSE
                   MOVE    1           TO  FLG-SYSKANRI
                   INITIALIZE          SYS-5013-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-SYSKANRI-KEY2
                                       TO   MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( ITEM-TAIINCD            =   SPACE )
               MOVE    "2001"  TO   ERRCD-ERRCD
               PERFORM 2100-ITEM-WRN-SET-SEC
           END-IF
      *
           .
       200111-TAIINCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院科チェック処理
      *****************************************************************
       20011-NYUINKA-CHK-SEC           SECTION.
      *
           COMPUTE CNT-NYUINKA  =   CNT-NYUINKA  +   1
      *
           IF    ( CNT-NYUINKA  =   1 )
      *
               MOVE    "1005"          TO  WRK-SYS-KANRICD
               MOVE    LNK-ORDER-ITEM (IDXA)
                                       TO  WRK-SYS-KBNCD
               PERFORM 900-SYSKANRI-KEY10-SEL-SEC
               IF    ( FLG-SYSKANRI    =   ZERO )
                   MOVE    MCPDATA-REC TO  SYS-1005-REC
      *
                   MOVE    LNK-ORDER-ITEM (IDXA)
                                       TO  ITEM-NYUINKA
      *
               ELSE
                   MOVE    "2020"      TO  ERRCD-ERRCD
                   PERFORM 2100-ITEM-ERR-SET-SEC
               END-IF
      *
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "2021"      TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       20011-NYUINKA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せチェック処理
      *****************************************************************
       20011-HKNCOMBI-CHK-SEC           SECTION.
      *
           COMPUTE CNT-HKNCOMBI  =   CNT-HKNCOMBI  +   1
      *
           IF    ( CNT-HKNCOMBI  =   1 )
      *
               MOVE    LNK-ORDER-ITEM (IDXA)
                                       TO  WRK-COMBI-HKNCOMBI
               PERFORM 900-HKNCOMBI-KEY-SEL-SEC
               IF    ( FLG-HKNCOMBI        =   ZERO )
                   IF    ( COMB-DELKBN NOT =   "1" )
                     AND ( SODR-SRYYMD    >=  COMB-TEKSTYMD )
                     AND ( SODR-SRYYMD    <=  COMB-TEKEDYMD )
      *
                       MOVE    LNK-ORDER-ITEM (IDXA)
                                       TO  ITEM-HKNCOMBI
                   ELSE
                       MOVE    "2022"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                    END-IF
               ELSE
                       MOVE    "2022"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
               END-IF
      *
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "2023"      TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       20011-HKNCOMBI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    項目未処理状態設定処理
      *****************************************************************
       2100-ITEM-UNPROCSTS-SET-SEC        SECTION.
      *
           MOVE    "3"             TO  LNK-ORDER-STATUS-ITEM (IDXA)
      *
           .
       2100-ITEM-UNPROCSTS-SET-EXT.
           EXIT.
      *****************************************************************
      *    項目チェックエラー設定処理
      *****************************************************************
       2100-ITEM-ERR-SET-SEC           SECTION.
      *
           IF    ( ERRCD-ITEM      =   SPACE )
               MOVE    ERRCD-ERRCD TO  ERRCD-ITEM
           END-IF
      *
           IF  ( LNK-ORDER-STATUS-ITEM (IDXA)  =   SPACE )
               MOVE    "2"     TO  LNK-ORDER-STATUS-ITEM (IDXA)
           END-IF
      *
           MOVE    ERRCD-ERRCD TO  LNK-ORDER-ERRCD-ITEM (IDXA)
      *
           .
       2100-ITEM-ERR-SET-EXT.
           EXIT.
      *****************************************************************
      *    項目チェック警告エラー設定処理
      *****************************************************************
       2100-ITEM-WRN-SET-SEC           SECTION.
      *
           IF    ( LNK-ORDER-STATUS-ITEM (IDXA)    =   SPACE )
               MOVE    "1"         TO  LNK-ORDER-STATUS-ITEM (IDXA)
           END-IF
      *
           MOVE    ERRCD-ERRCD     TO  LNK-ORDER-ERRCD-ITEM (IDXA)
      *
           .
       2100-ITEM-WRN-SET-EXT.
           EXIT.
      *****************************************************************
      *    関連チェック処理
      *****************************************************************
       2002-KANREN-CHK-SEC             SECTION.
      *
           IF    ( ERRCD-ORDER     =   SPACE )
      *        入院科チェック処理
               PERFORM 20021-NYUINKA-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
      *        保険組合せチェック処理
               PERFORM 20021-HKNCOMBI-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
      *        定期請求処理中チェック
               PERFORM 20021-TEIKI-JOB-CHK-SEC
               IF    ( FLG-TEIKIJOB    =   1 )
                   MOVE    "2003"      TO  ERRCD-ORDER
               END-IF
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
      *        入院履歴チェック処理
               PERFORM 20021-NYUINRRK-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
               IF    ( FLG-SYUARI      =   1 )
                   IF    ( SODR-INF-CANCEL >=  1 )
                       CONTINUE
                   ELSE
                       MOVE    1           TO  WRK-INF
                       MOVE    "2004"      TO  ERRCD-ORDER
                   END-IF
               END-IF
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
               PERFORM 20021-SRYACCT-CHK-SEC
               IF    ( FLG-ACCTARI     =   1 )
                   IF    ( SODR-INF-CANCEL >=  2 )
                       CONTINUE
                   ELSE
                       MOVE    2           TO  WRK-INF
                       MOVE    "2005"      TO  ERRCD-ORDER
                   END-IF
               END-IF
           END-IF
      *
           .
       2002-KANREN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院科チェック処理
      *****************************************************************
       20021-NYUINKA-CHK-SEC          SECTION.
      *
           IF    ( ITEM-NYUINKA        =   SPACE )
               MOVE    "2020"          TO  ERRCD-ORDER
           END-IF
      *
           .
       20021-NYUINKA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せチェック処理
      *****************************************************************
       20021-HKNCOMBI-CHK-SEC          SECTION.
      *
           IF    ( ITEM-HKNCOMBI       =   ZERO )
               MOVE    "2022"          TO  ERRCD-ORDER
           END-IF
      *
           .
       20021-HKNCOMBI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    定期請求処理中チェック
      *****************************************************************
       20021-TEIKI-JOB-CHK-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-TEIKIJOB
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    CONST-JOB-JOBID     TO  JOB-JOBID
           MOVE    CONST-JOB-SHELLID   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
           IF    ( SJOBKANRI-RETURN    =   ZERO )
               IF    ( JOB-ENDYMD      =   SPACE )
                   MOVE    1           TO  FLG-TEIKIJOB
               END-IF
           END-IF
      *
           .
       20021-TEIKI-JOB-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴チェック処理
      *****************************************************************
       20021-NYUINRRK-CHK-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-PTNYUINRRK
      *
           INITIALIZE                  PTNYUINRRK-REC
           MOVE    SODR-HOSPID     TO  PTNYUINRRK-HOSPID
           MOVE    SODR-PTID       TO  PTNYUINRRK-PTID
      *
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY3
                                   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               MOVE    1           TO  FLG-PTNYUINRRK
           END-IF
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY3
                                   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-PTNYUINRRK  =   1 )
               MOVE    "2006"      TO  ERRCD-ORDER
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
           MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
                                       TRRK-REC
      *
           MOVE    PTNYUINRRK-RRKNUM
                                   TO  WRK-RRKNUM
      *
      *    入院中であること
           IF    ( PTNYUINRRK-TAIINYMD NOT =   "99999999" )
               MOVE    "2007"      TO  ERRCD-ORDER
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
           IF    ( PTNYUINRRK-TENSTUYMD    =   "99999999" )
               IF    ( PTNYUINRRK-NYUINYMD >  SODR-SRYYMD )
                   MOVE    "2008"  TO  ERRCD-ORDER
                   GO  TO  20021-NYUINRRK-CHK-EXT
               END-IF
           ELSE
               IF    ( PTNYUINRRK-TENSTUYMD    >  SODR-SRYYMD )
                   MOVE    "2009"  TO  ERRCD-ORDER
                   GO  TO  20021-NYUINRRK-CHK-EXT
               END-IF
           END-IF
      *
      *    同日再入院の場合、入院日≠退院日となっていること
           IF    ( PTNYUINRRK-DOUJITSUKBN   =   "1" )
               IF    ( PTNYUINRRK-NYUINYMD  =   SODR-SRYYMD )
                   MOVE    "2019"  TO  ERRCD-ORDER
                   GO  TO  20021-NYUINRRK-CHK-EXT
               END-IF
           END-IF
      *
      *    定期請求との関連チェック
      *    請求開始日取得処理
           PERFORM 20021-SKYSTYMD-GET-SEC
           IF    ( ERRCD-ORDER     NOT =   SPACE )
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
      *    前回定期請求日の翌日（あるいは入院日）
      *    〜算定開始日の翌月までの
      *    日付が入力されていること
           MOVE    WRK-SKYSTYMD        TO  WRK-KIJUNYMD
           MOVE    "2"                 TO  WRK-ZOGENPTN
           MOVE    1                   TO  WRK-ZOGEN
           PERFORM 800-CALENDAR-SEC
           IF    ( SODR-SRYYMD (1 : 6)
                                   <= WRK-KEISANYMD (1 : 6) )
               CONTINUE
           ELSE
               MOVE    "2010"      TO  ERRCD-ORDER
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
      *    月途中の定期請求終了後...(1)、
      *    定期請求区分を「2 月末時のみ請求」に変更された場合、
      *    (1)で作成された収納が未入金であること
           IF    ( PTNYUINRRK-TEIKI-SEIKYUKBN  =   "2" )
             AND ( FLG-TEIKIARI                =   1 )
             AND ( WRK-SKYSTYMD            NOT =   "01" )
      *
               PERFORM 20021-TEIKI-SYU-CHK-SEC
               IF    ( ERRCD-ORDER         NOT =   SPACE )
                   GO  TO  20021-NYUINRRK-CHK-EXT
               END-IF
      *
           END-IF
      *
      *    退院月に会計テーブルが存在していること
           PERFORM 900-NYUINACCT-KEY17-SEL-SEC
           IF    ( FLG-NYUINACCT   NOT =   ZERO )
               MOVE    "2011"          TO  ERRCD-ORDER
           END-IF
      *
           .
       20021-NYUINRRK-CHK-EXT.
           EXIT.
      *****************************************************************
      *    請求期間開始日取得処理
      *****************************************************************
       20021-SKYSTYMD-GET-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-TEIKIARI
      *
           MOVE    SPACE               TO  WRK-SKYSTYMD
      *
           INITIALIZE                      PTTEIKIRRK-REC
           MOVE    PTNYUINRRK-HOSPID   TO  PTTEIKIRRK-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  PTTEIKIRRK-PTID
           MOVE    PTNYUINRRK-RRKNUM   TO  PTTEIKIRRK-RRKNUM
           MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-PTTEIKIRRK-KEY7    TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTTEIKIRRK-REC
               IF    ( PTTEIKIRRK-SKYEDYMD
                                       >=  SODR-SRYYMD )
                   MOVE    "2012"      TO  ERRCD-ORDER
                   GO  TO  20021-SKYSTYMD-GET-EXT
               END-IF
      *
               MOVE    PTTEIKIRRK-SKYEDYMD
                                       TO  WRK-KIJUNYMD
               MOVE    "1"             TO  WRK-ZOGENPTN
               MOVE    1               TO  WRK-ZOGEN
               PERFORM 800-CALENDAR-SEC
               MOVE    WRK-KEISANYMD   TO  WRK-SKYSTYMD
      *
               MOVE    1               TO  FLG-TEIKIARI
      *
           END-IF
      *
           MOVE    PATH-TBL-PTTEIKIRRK-KEY7    TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( WRK-SKYSTYMD        =   SPACE )
               MOVE    PTNYUINRRK-NYUINYMD
                                           TO  WRK-SKYSTYMD
               IF    ( PTNYUINRRK-DOUJITSUKBN   =   "1" )
                   MOVE    WRK-SKYSTYMD    TO  WRK-KIJUNYMD
                   MOVE    "1"             TO  WRK-ZOGENPTN
                   MOVE    1               TO  WRK-ZOGEN
                   PERFORM 800-CALENDAR-SEC
                   MOVE    WRK-KEISANYMD   TO  WRK-SKYSTYMD
               END-IF
           END-IF
      *
           .
       20021-SKYSTYMD-GET-EXT.
           EXIT.
      *****************************************************************
      *    定期請求で作成された収納をチェック
      *****************************************************************
       20021-TEIKI-SYU-CHK-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUNOU
           INITIALIZE                  SYUNOU-REC
           MOVE    PTNYUINRRK-HOSPID   TO  SYU-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  SYU-PTID
           MOVE    "1"                 TO  SYU-NYUGAIKBN
           MOVE    WRK-SKYSTYMD        TO  SYU-SKYSTYMD
           MOVE    SODR-SRYYMD         TO  SYU-SKYEDYMD
           MOVE    PTNYUINRRK-RRKNUM   TO  SYU-NYUIN-RRKNUM
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUNOU-KEY5
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
               INITIALIZE              SYUNOU-REC
           END-IF
      *
           PERFORM UNTIL   ( FLG-SYUNOU    NOT =   ZERO )
                    OR     ( ERRCD-ORDER   NOT =   SPACE )
      *
               IF    ( SYU-DENPJTIKBN  NOT =   "3" )
                   MOVE    1           TO  FLG-SYUARI
                   IF    ( SYU-NYUKIN-TOTAL    >   ZERO )
                       MOVE    "2013"  TO  ERRCD-ORDER
                   END-IF
               END-IF
      *
               MOVE    PATH-TBL-SYUNOU-KEY5
                                       TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  SYUNOU-REC
               ELSE
                   MOVE    1           TO  FLG-SYUNOU
                   INITIALIZE          SYUNOU-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-SYUNOU-KEY5    TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20021-TEIKI-SYU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    診療会計チェック処理
      *****************************************************************
       20021-SRYACCT-CHK-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-ACCTARI
      *
           MOVE    SODR-SRYYMD         TO  WRK-TAIINYMD
      *
           MOVE    ZERO                TO  FLG-SRYACCT
      *
           INITIALIZE                      SRYACCT-REC
           MOVE    SODR-HOSPID         TO  ACCT-HOSPID
           MOVE    "1"                 TO  ACCT-NYUGAIKBN
           MOVE    SODR-PTID           TO  ACCT-PTID
           MOVE    WRK-TAIINYM         TO  ACCT-SRYYM
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    PATH-TBL-SRYACCT-KEY15
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC 
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
           ELSE
               MOVE    1               TO  FLG-SRYACCT
               INITIALIZE                  SRYACCT-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SRYACCT     NOT =   ZERO )
                   OR    ( FLG-ACCTARI     NOT =   ZERO )
      *
               IF    ( ACCT-SRYCDTOTAL =   120001110
                  OR                       120000410 )
                   CONTINUE
               ELSE
                   IF    ( WRK-TAIINYM     =   ACCT-SRYYM )
                       COMPUTE IDX0        =   WRK-TAIINDD +   1
                   ELSE
                       COMPUTE IDX0        =   1
                   END-IF
      *
                   PERFORM UNTIL ( IDX0               >   31 )
                           OR    ( FLG-ACCTARI    NOT =   ZERO )
      *
                       IF    ( ACCT-DAY (1 IDX0)      >   ZERO )
                           MOVE    1       TO  FLG-ACCTARI
                       END-IF
      *
                       COMPUTE IDX0        =   IDX0    +   1
      *
                   END-PERFORM
               END-IF
      *
               MOVE    PATH-TBL-SRYACCT-KEY15
                                       TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  SRYACCT-REC
               ELSE
                   MOVE    1           TO  FLG-SRYACCT
                   INITIALIZE              SRYACCT-REC
               END-IF
           END-PERFORM
      *
           MOVE    PATH-TBL-SRYACCT-KEY15
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20021-SRYACCT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    収納情報編集処理
      *****************************************************************
       2101-SYUNOU-HEN-SEC             SECTION.
      *
           MOVE    LNK-SYUNOU-REC (IDX-SYU)    TO  SYUNOU-REC
      *
           IF    ( WRK-SKYSTYMD  (1:6) NOT =   SODR-SRYYMD (1:6) )
               IF    ( WRK-SKYSTYMD (1:6)  =   SYU-SKYSTYMD (1:6))
                   MOVE    WRK-SKYSTYMD        TO  SYU-SKYSTYMD
                   MOVE    WRK-SKYSTYMD        TO  WRK-SYMD
                   PERFORM 800-GETUMATU-SEC
                   MOVE    WRK-SYMD            TO  SYU-SKYEDYMD
               END-IF
               IF    ( SODR-SRYYMD (1:6)   =   SYU-SKYEDYMD (1:6) )
                   MOVE    SODR-SRYYMD (1:6)   TO  SYU-SKYSTYMD(1:6)
                   MOVE    "01"                TO  SYU-SKYSTYMD(7:2)
                   MOVE    SODR-SRYYMD         TO  SYU-SKYEDYMD
               END-IF
           ELSE
               MOVE    WRK-SKYSTYMD            TO  SYU-SKYSTYMD
               MOVE    SODR-SRYYMD             TO  SYU-SKYEDYMD
           END-IF
      *
      *    請求時最終履歴取得処理
           PERFORM 21011-SEILASTRRK-SET-SEC
           IF    ( ERRCD-ORDER     NOT =   SPACE )
               GO  TO  2101-SYUNOU-HEN-EXT
           END-IF
      *
           MOVE    WRK-NYUINKA     TO  SYU-SRYKA
           MOVE    WRK-BRMNUM      TO  SYU-ROOMNUM
           MOVE    WRK-BTUNUM      TO  SYU-BYOTONUM
           MOVE    WRK-DRCD        TO  SYU-DRCD
      *
           IF    ( SYU-SKYMONEY        =   ZERO )
               MOVE    SPACE       TO  SYU-DENPJTIKBN
           ELSE
               IF    ( SYU-SKYMONEY   <=  SYU-NYUKIN-TOTAL )
                   MOVE    "1"     TO  SYU-DENPJTIKBN
               ELSE
                   MOVE    "2"     TO  SYU-DENPJTIKBN
               END-IF
           END-IF
      *
           MOVE    TRRK-RRKNUM     TO  SYU-NYUIN-RRKNUM
      *
           MOVE    SYUNOU-REC      TO  LNK-SYUNOU-REC (IDX-SYU)
      *
           .
       2101-SYUNOU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    請求時最終履歴取得処理
      *****************************************************************
       21011-SEILASTRRK-SET-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-NYUINKA
                                           WRK-BTUNUM
                                           WRK-BRMNUM
                                           WRK-DRCD
      *
      *    入院履歴マスタ検索
           MOVE    ZERO                TO  FLG-PTNYUINRRK
           INITIALIZE  PTNYUINRRK-REC
           MOVE    SODR-HOSPID         TO  PTNYUINRRK-HOSPID
           MOVE    SODR-PTID           TO  PTNYUINRRK-PTID
           MOVE    TRRK-RRKNUM         TO  PTNYUINRRK-RRKNUM
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY4
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
               INITIALIZE                  PTNYUINRRK-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-PTNYUINRRK  NOT =   ZERO )
                    OR   ( WRK-NYUINKA     NOT =   SPACE )
      *
               IF    ( PTNYUINRRK-TENNYUYMD
                                       <=  SYU-SKYEDYMD )
                AND  ( PTNYUINRRK-TENSTUYMD
                                       >=  SYU-SKYEDYMD )
                   MOVE    PTNYUINRRK-NYUINKA
                                       TO  WRK-NYUINKA
                   MOVE    PTNYUINRRK-BTUNUM
                                       TO  WRK-BTUNUM
                   MOVE    PTNYUINRRK-BRMNUM
                                       TO  WRK-BRMNUM
                   MOVE    PTNYUINRRK-DRCD1 (2 : 4)
                                       TO  WRK-DRCD
               END-IF
      *
               MOVE    PATH-TBL-PTNYUINRRK-KEY4
                                       TO  MCP-PATH
               PERFORM 910-DBSELECT-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
               ELSE
                   MOVE    1           TO  FLG-PTNYUINRRK
                   INITIALIZE              PTNYUINRRK-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY4
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( WRK-NYUINKA         =   SPACE )
               MOVE    "2014"          TO  ERRCD-ORDER
           END-IF
      *
           .
       21011-SEILASTRRK-SET-EXT.
           EXIT.
      *****************************************************************
      *    入院負担金計算処理
      *****************************************************************
       2101-ORCSNYUFTN-CALL-SEC        SECTION.
      *
      *    通算日数を求める
           MOVE    TRRK-NYUINYMD   TO  WRK-STYMD
      *
      *    請求開始日（入院日または前回定期請求終了日の翌日）を設定
           MOVE    WRK-SKYSTYMD    TO  WRK-EDYMD
           PERFORM 800-KIKAN-CALC-SEC
           IF    ( FLG-ORCSDAY     NOT =   ZERO )
               MOVE    "2015"      TO  ERRCD-ORDER
               GO  TO  2101-ORCSNYUFTN-CALL-EXT
           END-IF
      *
           INITIALIZE                  LNK-ORCS02-REC
                                       LNK-SYUNOU-REC-T
                                       LNK-SYUDAY-REC-T
      *
           MOVE    SODR-HOSPID     TO  LNK-S02-HOSPID
           MOVE    "1"             TO  LNK-S02-NYUGAIKBN
           MOVE    SODR-PTID       TO  LNK-S02-PTID
           MOVE    WRK-NISSU1      TO  LNK-S02-NYUIN-TSUSAN-NISSU
      *
      *    請求開始日（入院日または前回定期請求終了日の翌日）を設定
           MOVE    WRK-SKYSTYMD    TO  LNK-S02-SKYSTYMD
           MOVE    SODR-SRYYMD     TO  LNK-S02-SKYEDYMD
           MOVE    SODR-SRYYMD     TO  LNK-S02-SYSYMD
           MOVE    "1"             TO  LNK-S02-SYORI-KBN
           CALL    "ORCSNYUFTN"    USING
                                   SPA-AREA
                                   LNK-ORCS02-REC
                                   LNK-SYUNOU-REC-T
                                   LNK-SYUDAY-REC-T
           IF    ( LNK-S02-RC      = ZERO )
               IF    ( LNK-SYU-SKYSTYMD(1) =   SPACE )
                   MOVE    "2016"      TO  ERRCD-ORDER
               END-IF
           ELSE
               EVALUATE LNK-S02-RC
               WHEN    13
                   MOVE    "2017"      TO  ERRCD-ORDER
               WHEN    OTHER
                   MOVE    "2018"      TO  ERRCD-ORDER
               END-EVALUATE
           END-IF
      *
           .
       2101-ORCSNYUFTN-CALL-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴更新処理
      *****************************************************************
       2101-PTNYUINRRK-UPDATE-SEC      SECTION.
      *
           MOVE    TRRK-REC        TO  PTNYUINRRK-REC
           MOVE    SODR-SRYYMD     TO  PTNYUINRRK-TAIINYMD
                                       PTNYUINRRK-TENSTUYMD
      *
           MOVE    ITEM-TAIINCD    TO  PTNYUINRRK-TAIINCD
      *
           MOVE    SODR-OPID       TO  PTNYUINRRK-OPID
           MOVE    SODR-UPYMD      TO  PTNYUINRRK-UPYMD
           MOVE    SODR-UPHMS      TO  PTNYUINRRK-UPHMS
      *
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-UPD2
                                   TO  MCP-PATH
           PERFORM 910-DBUPDATE-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               DISPLAY "ORCSDR02 ERROR:PTNYUINRRK UPDATE ERR 1"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
               GO  TO  2101-PTNYUINRRK-UPDATE-EXT
           END-IF
      *
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-UPD3
                                   TO  MCP-PATH
           PERFORM 910-DBUPDATE-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               DISPLAY "ORCSDR02 ERROR:PTNYUINRRK UPDATE ERR 2"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
               GO  TO  2101-PTNYUINRRK-UPDATE-EXT
           END-IF
      *
           MOVE    PTNYUINRRK-REC      TO  TRRK-REC
      *
           .
       2101-PTNYUINRRK-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    請求取消更新処理
      *****************************************************************
       2101-TORIKESI-KOUSHIN-SEC       SECTION.
      *
      *    患者定期請求履歴を削除する
           IF    ( FLG-END         =   ZERO )
               PERFORM 2101-PTTEIKIRRK-DEL-SEC
           END-IF
      *
      *    定期請求履歴を更新する
           IF    ( FLG-END         =   ZERO )
               PERFORM 2101-TEIKIRRK-UPD-SEC
           END-IF
      *
      *    収納データを更新する
           IF    ( FLG-END         =   ZERO )
               PERFORM 2101-SYUNOU-UPD-SEC
           END-IF
      *
           .
       2101-TORIKESI-KOUSHIN-EXT.
           EXIT.
      *****************************************************************
      *    収納データ更新処理
      *****************************************************************
       2101-SYUNOU-UPD-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUNOU
      *
           INITIALIZE  SYUNOU-REC
           MOVE    SODR-HOSPID         TO  SYU-HOSPID
           MOVE    SODR-PTID           TO  SYU-PTID
           MOVE    "1"                 TO  SYU-NYUGAIKBN
           MOVE    WRK-SKYSTYMD        TO  SYU-SKYSTYMD
           MOVE    SODR-SRYYMD         TO  SYU-SKYEDYMD
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUNOU-KEY5
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
               INITIALIZE                  SYUNOU-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SYUNOU  NOT =   ZERO )
                    OR   ( FLG-END     NOT =   ZERO )
      *
               IF    ( SYU-NYUIN-RRKNUM    =   TRRK-RRKNUM )
                AND  ( SYU-DENPJTIKBN  NOT =   "3" )
      *
      *            収納明作成処理
                   PERFORM 2101-SYUMEI-SAKUSEI-SEC
                   IF    ( FLG-END     =   ZERO )
      *
      *                請求取消として収納データを更新
                       MOVE    ZERO            TO  SYU-SKYMONEY
                       MOVE    "3"             TO  SYU-DENPJTIKBN
      *
                       MOVE    SODR-OPID       TO  SYU-OPID
                       MOVE    SODR-UPYMD      TO  SYU-UPYMD
                       MOVE    SODR-UPHMS      TO  SYU-UPHMS
      *
                       MOVE    SYUNOU-REC      TO  MCPDATA-REC
                       MOVE    PATH-TBL-SYUNOU-KEY
                                               TO  MCP-PATH
                       PERFORM 910-DBUPDATE-SEC
                       IF    ( MCP-RC      NOT =   ZERO )
                           DISPLAY "ORCSDR02 ERROR:SYUNOU UPDATE ERR"
                           " PTID="        SODR-PTID
                           " KARTE-KEY="   SODR-UID8
                           MOVE    1           TO  FLG-END
                       END-IF
                   END-IF
               END-IF
      *
               MOVE    PATH-TBL-SYUNOU-KEY5
                                       TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC     TO  SYUNOU-REC
               ELSE
                   MOVE    1               TO  FLG-SYUNOU
                   INITIALIZE                  SYUNOU-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-SYUNOU-KEY5    TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
      *
       2101-SYUNOU-UPD-EXT.
           EXIT.
      *****************************************************************
      *    収納明細作成処理
      *****************************************************************
       2101-SYUMEI-SAKUSEI-SEC         SECTION.
      *
           COMPUTE WRK-SKYMONEY    =   SYU-SKYMONEY        *   -1
      *
      *    伝票番号枝番を求める
           MOVE    ZERO                TO  FLG-SYUMEI
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUMEI-KEY7
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    ZERO            TO  FLG-SYUMEI
               MOVE    MCPDATA-REC     TO  SYUMEI-REC
           ELSE
               MOVE    1               TO  FLG-SYUMEI
               INITIALIZE                  SYUMEI-REC
           END-IF
      *
           COMPUTE WRK-DENPEDANUM  =   SMEI-DENPEDANUM +   1
      *
      *
           MOVE    PATH-TBL-SYUMEI-KEY7
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
      *伝票番号
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
      *伝票番号枝番
           MOVE    WRK-DENPEDANUM      TO  SMEI-DENPEDANUM
      *入金連番
           MOVE    ZERO                TO  SMEI-NYUKINRENNUM
      *診療科
           MOVE    SYU-SRYKA           TO  SMEI-SRYKA
      *伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *請求発行日（発行日の西暦）
           MOVE    SPACE               TO  SMEI-SKYPRINTYMD
      *請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *領収書発行日
           MOVE    SPACE               TO  SMEI-RYOSYUPRINTYMD
      *領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *請求金額
           MOVE    WRK-SKYMONEY        TO  SMEI-SKYMONEY
      *
      *入返金区分
           MOVE    SPACE               TO  SMEI-NYUHEN-KBN
      *入返金額
           MOVE    ZERO                TO  SMEI-NYUHEN-MONEY
      *入返金日
           MOVE    SODR-UKEYMD         TO  SMEI-NYUHEN-YMD
      *入金方法
           MOVE    "00"                TO  SMEI-NYUKIN-HOHO
      *状態区分
           MOVE    "5"                 TO  SMEI-JOUTAIKBN
      *
      *    追加対象のデータが既に存在しないかチェック
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUMEI-KEY TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               DISPLAY "ORCSDR02 ERROR:SYUMEI INSERT CHK ERR 1"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
               GO  TO  2101-SYUMEI-SAKUSEI-EXT
           END-IF
      *
           MOVE    PATH-TBL-SYUMEI-KEY TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           MOVE    SODR-OPID           TO  SMEI-OPID
           MOVE    SODR-UPYMD          TO  SMEI-CREYMD
                                           SMEI-UPYMD
           MOVE    SODR-UPHMS          TO  SMEI-CREHMS
                                           SMEI-UPHMS
      *
           MOVE    SMEI-CREYMD         TO  SDAILYKEY-CREYMD
           MOVE    SMEI-CREHMS         TO  SDAILYKEY-CREHMS
           MOVE    SMEI-NYUHEN-YMD     TO  SDAILYKEY-BASEYMD
           PERFORM 800-DAILYKEY-SEC
           MOVE    SDAILYKEY-DAILYKEY  TO  SMEI-DAILYKEY
      *
      *    収納明細追加
           MOVE    PATH-TBL-SYUMEI-KEY TO  MCP-PATH
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               DISPLAY "ORCSDR02 ERROR:SYUMEI INSERT ERR 1"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
           END-IF
      *
           .
       2101-SYUMEI-SAKUSEI-EXT.
           EXIT.
      *****************************************************************
      *    患者定期請求履歴削除処理
      *****************************************************************
       2101-PTTEIKIRRK-DEL-SEC         SECTION.
      *
           INITIALIZE  SUMTEIKIRRK-REC
           MOVE    ZERO                TO  FLG-PTTEIKIRRK
      *
           INITIALIZE  PTTEIKIRRK-REC
           MOVE    SODR-HOSPID         TO  PTTEIKIRRK-HOSPID
           MOVE    SODR-PTID           TO  PTTEIKIRRK-PTID
           MOVE    WRK-SKYSTYMD        TO  PTTEIKIRRK-SKYSTYMD
           MOVE    SODR-SRYYMD         TO  PTTEIKIRRK-SKYEDYMD
           MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-PTTEIKIRRK-KEY4
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTTEIKIRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTTEIKIRRK
               INITIALIZE  PTTEIKIRRK-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-PTTEIKIRRK  NOT =   ZERO )
      *
               IF    ( PTTEIKIRRK-RRKNUM       =   TRRK-RRKNUM )
      *
      *            定期履歴管理情報集計
                   PERFORM 21011-TEIKIRRK-SUM-SEC
               END-IF
      *
               MOVE    PATH-TBL-PTTEIKIRRK-KEY4
                                       TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC              =   ZERO )
                   MOVE    MCPDATA-REC TO  PTTEIKIRRK-REC
               ELSE
                   MOVE    1           TO  FLG-PTTEIKIRRK
                   INITIALIZE  PTTEIKIRRK-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-PTTEIKIRRK-KEY4
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
      *    患者請求履歴削除
           INITIALIZE  PTTEIKIRRK-REC
           MOVE    SODR-HOSPID         TO  PTTEIKIRRK-HOSPID
           MOVE    SODR-PTID           TO  PTTEIKIRRK-PTID
           MOVE    WRK-SKYSTYMD        TO  PTTEIKIRRK-SKYSTYMD
           MOVE    SODR-SRYYMD         TO  PTTEIKIRRK-SKYEDYMD
           MOVE    TRRK-RRKNUM         TO  PTTEIKIRRK-RRKNUM
           MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-PTTEIKIRRK-DEL3
                                       TO  MCP-PATH
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               DISPLAY "ORCSDR02 ERROR:PTTEIKIRRK DELETE ERR"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
           END-IF
      *
           .
       2101-PTTEIKIRRK-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    定期請求管理情報集計（マイナス分）
      *****************************************************************
       21011-TEIKIRRK-SUM-SEC          SECTION.
      *
           INITIALIZE  SYUNOU-REC
      *
           MOVE    SODR-HOSPID         TO  SYU-HOSPID
           MOVE    SODR-PTID           TO  SYU-PTID
           MOVE    "1"                 TO  SYU-NYUGAIKBN
           MOVE    PTTEIKIRRK-DENPNUM  TO  SYU-DENPNUM
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUNOU-KEY TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
           ELSE
               INITIALIZE                  SYUNOU-REC
           END-IF
      *
           MOVE    PATH-TBL-SYUNOU-KEY TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
      *    定期請求管理情報集計（マイナス分）
           PERFORM VARYING IDX1   FROM    1   BY  1
                   UNTIL ( IDX1   >   100 )
               EVALUATE SUMTEIKIRRK-SRYYM (IDX1)
                                   ALSO    SUMTEIKIRRK-SAKKBN (IDX1)
               WHEN    SPACE       ALSO    ANY
                   MOVE    PTTEIKIRRK-SRYYM
                                   TO  SUMTEIKIRRK-SRYYM   (IDX1)
                   MOVE    PTTEIKIRRK-SAKKBN
                                   TO  SUMTEIKIRRK-SAKKBN  (IDX1)
                   MOVE    PTTEIKIRRK-SKYSTYMD
                                   TO  SUMTEIKIRRK-SKYSTYMD(IDX1)
                   MOVE    PTTEIKIRRK-SKYEDYMD
                                   TO  SUMTEIKIRRK-SKYEDYMD(IDX1)
                   COMPUTE SUMTEIKIRRK-SKYTEN (IDX1)
                       =   SYU-TOTAL-HKNTEN    *   -1
                   COMPUTE SUMTEIKIRRK-SKYMONEY (IDX1)
                       =   SYU-SKYMONEY        *   -1
                   COMPUTE SUMTEIKIRRK-MAX
                       =   SUMTEIKIRRK-MAX     +   1
                   MOVE    100         TO  IDX1
               WHEN    PTTEIKIRRK-SRYYM
                                   ALSO    PTTEIKIRRK-SAKKBN
                   COMPUTE SUMTEIKIRRK-SKYTEN (IDX1)
                       =   SUMTEIKIRRK-SKYTEN (IDX1)
                       + ( SYU-TOTAL-HKNTEN    *  -1 )
                   COMPUTE SUMTEIKIRRK-SKYMONEY (IDX1)
                       =   SUMTEIKIRRK-SKYMONEY (IDX1)
                       + ( SYU-SKYMONEY        *  -1 )
                   MOVE    100         TO  IDX1
               END-EVALUATE
           END-PERFORM
      *
           .
       21011-TEIKIRRK-SUM-EXT.
           EXIT. 
      *****************************************************************
      *    定期請求履歴更新処理
      *****************************************************************
       2101-TEIKIRRK-UPD-SEC           SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1        >   SUMTEIKIRRK-MAX )
                    OR   ( FLG-END NOT =   ZERO )
      *
               INITIALIZE  TEIKIRRK-REC
      *
               MOVE    SUMTEIKIRRK-OCC (IDX1)
                                       TO  TEIKIRRK-REC
      *
               MOVE    TEIKIRRK-REC    TO  MCPDATA-REC
               MOVE    PATH-TBL-TEIKIRRK-KEY
                                       TO  MCP-PATH
               PERFORM 910-DBSELECT-SEC
      *        更新対象のデータがすでに存在する場合は更新
      *        存在しない場合は追加
               IF    ( MCP-RC        =   ZERO )
                   MOVE    MCPDATA-REC TO  TEIKIRRK-REC
      *
                   COMPUTE TEIKIRRK-SKYTEN
                       =   TEIKIRRK-SKYTEN
                       +   SUMTEIKIRRK-SKYTEN   (IDX1)
      *
                   COMPUTE TEIKIRRK-SKYMONEY
                       =   TEIKIRRK-SKYMONEY
                       +   SUMTEIKIRRK-SKYMONEY (IDX1)
      *
                   MOVE    SODR-OPID       TO  TEIKIRRK-OPID
                   MOVE    SODR-UPYMD      TO  TEIKIRRK-UPYMD
                   MOVE    SODR-UPHMS      TO  TEIKIRRK-UPHMS
      *
      *            定期請求管理データ更新
                   MOVE    TEIKIRRK-REC    TO  MCPDATA-REC
                   MOVE    PATH-TBL-TEIKIRRK-KEY
                                           TO  MCP-PATH
                   PERFORM 910-DBUPDATE-SEC
                   IF    ( MCP-RC      NOT =   ZERO )
                       DISPLAY "ORCSDR02 ERROR:TEIKIRRK UPDATE ERR"
                               " PTID="        SODR-PTID
                               " KARTE-KEY="   SODR-UID8
                       MOVE    1           TO  FLG-END
                   END-IF
               ELSE
      *
                   MOVE    SODR-OPID       TO  TEIKIRRK-OPID
                   MOVE    SODR-UPYMD      TO  TEIKIRRK-CREYMD
                                               TEIKIRRK-UPYMD
                   MOVE    SODR-UPHMS      TO  TEIKIRRK-UPHMS
      *
                   MOVE    TEIKIRRK-REC    TO  MCPDATA-REC
                   MOVE    PATH-TBL-TEIKIRRK-KEY
                                           TO  MCP-PATH
                   PERFORM 910-DBINSERT-SEC
                   IF    ( MCP-RC      NOT =   ZERO )
                       DISPLAY "ORCSDR02 ERROR:TEIKIRRK INSERT ERR"
                               " PTID="        SODR-PTID
                               " KARTE-KEY="   SODR-UID8
                       MOVE    1           TO  FLG-END
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       2101-TEIKIRRK-UPD-EXT.
           EXIT. 
      *****************************************************************
      *    エラー情報編集処理
      *****************************************************************
       2101-ERRINF-HEN-SEC             SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   LNK-ORDER-MAX )
      *
               MOVE    ERRCD-ORDER TO  LNK-ORDER-ERRCD-ORDER (IDXA)
      *
           END-PERFORM
      *
           .
       2101-ERRINF-HEN-EXT.
           EXIT.
      *****************************************************************
      *    オーダー情報再編成処理
      *****************************************************************
       2101-ORDER-RECONF-SEC           SECTION.
      *
           CALL    "ORCSODRS01"        USING   SODR-AREA
                                               SODRS01-AREA
                                               LNK-ORDER-REC
           MOVE    SODRS01-RC      TO  FLG-END
      *
           .
       2101-ORDER-RECONF-EXT.
           EXIT.
      *****************************************************************
      *    オーダー追加処理
      *****************************************************************
       2101-ORDER-INSERT-SEC           SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   LNK-ORDER-MAX )
                    OR   ( FLG-END =   1 )
      *
               PERFORM 21011-ORDER-HEN-SEC
      *
           END-PERFORM
      *
           .
       2101-ORDER-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    オーダー編集処理
      *****************************************************************
       21011-ORDER-HEN-SEC             SECTION.
      *
           MOVE    LNK-ORDER-OCC (IDXA)    TO  ORDER-REC
      *
           IF    ( ERRCD-ITEM          =   SPACE )
            AND  ( ERRCD-ORDER         =   SPACE )
               MOVE    TRRK-RRKNUM     TO  ORDER-RRKNUM
               MOVE    TRRK-RRKEDANUM  TO  ORDER-RRKEDANUM
               MOVE    "0"             TO  ORDER-STATUS-ORDER
           ELSE
               MOVE    "2"             TO  ORDER-STATUS-ORDER
           END-IF
      *
           MOVE    ERRCD-ORDER         TO  ORDER-ERRCD-ORDER
      *
           IF    ( LNK-ORDER-ITEMID (IDXA)
                                       =   NCLAIMID-TAIINCDID
                                       OR  NCLAIMID-NYUINKAID
                                       OR  NCLAIMID-HKNCOMBIID
                                           )
               CONTINUE
           ELSE
               MOVE    "3"             TO  ORDER-STATUS-ITEM
               MOVE    "2901"          TO  ORDER-ERRCD-ITEM
           END-IF
      *
           IF    ( SODR-PROCKBN    =   "1" )
               MOVE    "1"             TO  ORDER-MODIFY
           END-IF
      *
           MOVE    SODR-OPID           TO  ORDER-OPID
           MOVE    SODR-UPYMD          TO  ORDER-CREYMD
                                           ORDER-UPYMD
           MOVE    SODR-UPHMS          TO  ORDER-UPHMS
      *
      *
           PERFORM 900-ORDER-KEY-SEL-SEC
           IF    ( FLG-ORDER           =   ZERO )
               DISPLAY "ORCSDR02 ERROR:ORDER INSERT CHK ERR"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
               GO  TO  21011-ORDER-HEN-EXT
           END-IF
      *
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-ORDER-KEY  TO  MCP-PATH
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               DISPLAY "ORCSDR02 ERROR:ORDER INSERT ERR"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
           END-IF
      *
           .
       21011-ORDER-HEN-EXT.
           EXIT.
      *****************************************************************
      *    入院会計作成サブ呼出
      *****************************************************************
       2101-ORCSODRNACCT-CALL-SEC      SECTION.
      *
           INITIALIZE                  SODRNACCT-AREA
           MOVE    SODR-ORDERID    TO  SODRNACCT-ORDERID
           MOVE    SODR-OPID       TO  SODRNACCT-OPID
           MOVE    SODR-UPYMD      TO  SODRNACCT-UPYMD
           MOVE    SODR-UPHMS      TO  SODRNACCT-UPHMS
           MOVE    TRRK-REC        TO  LNK-PTNYUINRRK-REC

      *
           CALL    "ORCSODRNACCT"      USING
                                       SODRNACCT-AREA
                                       LNK-PTNYUINRRK-REC
           IF    ( SODRNACCT-RC    NOT =   ZERO )
               MOVE    1           TO  FLG-END
           END-IF
      *
           .
       2101-ORCSODRNACCT-CALL-EXT.
           EXIT.
      *****************************************************************
      *    収納更新処理
      *****************************************************************
       2102-SYUNOU-UPD-SEC             SECTION.
      *
           MOVE    LNK-SYUNOU-REC (IDX-SYU)
                                   TO  SYUNOU-REC
      *
      *    伝票番号取得処理
           PERFORM 21021-DENPNUM-GET-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  2102-SYUNOU-UPD-EXT
           END-IF
      *
           MOVE    WRK-DENPNUM     TO  SYU-DENPNUM
      *
      *    更新前チェック（既に重複するデータがある場合はエラー）
           MOVE   ZERO             TO  FLG-SYUNOU
           MOVE    SYUNOU-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUNOU-KEY
                                   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               MOVE    1           TO  FLG-SYUNOU
           END-IF
      *
           MOVE    PATH-TBL-SYUNOU-KEY
                                   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-SYUNOU      =   ZERO )
               DISPLAY "ORCSDR02 ERROR:SYUNOU INSERT CHK ERR"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
               GO  TO  2102-SYUNOU-UPD-EXT
           END-IF
      *
           MOVE    SODR-OPID       TO  SYU-OPID
           MOVE    SODR-UPYMD      TO  SYU-CREYMD
                                       SYU-UPYMD
           MOVE    SODR-UPHMS      TO  SYU-UPHMS
      *
           MOVE    SYUNOU-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUNOU-KEY
                                   TO  MCP-PATH
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               DISPLAY "ORCSDR02 ERROR:SYUNOU INSERT ERR"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
               GO  TO  2102-SYUNOU-UPD-EXT
           END-IF
      *
      *    日別収納マスタ更新処理
           PERFORM 2102-SYUDAY-UPD-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  2102-SYUNOU-UPD-EXT
           END-IF
      *
      *    収納明細マスタ更新処理
           PERFORM 2102-SYUMEI-UPD-SEC
           IF    ( FLG-END     NOT =   ZERO )
               GO  TO  2102-SYUNOU-UPD-EXT
           END-IF
      *
           .
       2102-SYUNOU-UPD-EXT.
           EXIT.
      *****************************************************************
      *    日別収納マスタ更新処理
      *****************************************************************
       2102-SYUDAY-UPD-SEC         SECTION.
      *
           MOVE    LNK-SYUDAY-REC (IDX-SYU)
                                       TO  SYUDAY-REC
      *
           IF    ( SDAY-DAYINFFLG      =   "1" )
      *
               MOVE    SYU-DENPNUM     TO  SDAY-DENPNUM
      *
      *        更新前チェック（既に重複するデータがある場合はエラー）
               MOVE    ZERO            TO  FLG-SYUDAY
               MOVE    SYUDAY-REC      TO  MCPDATA-REC
               MOVE    PATH-TBL-SYUDAY-KEY
                                       TO  MCP-PATH
               PERFORM 910-DBSELECT-SEC
               IF    ( MCP-RC      NOT =   ZERO )
                   MOVE    1           TO  FLG-SYUDAY
               END-IF
      *
               MOVE    PATH-TBL-SYUDAY-KEY
                                       TO  MCP-PATH
               PERFORM 910-DBCLOSE-SEC
      *
               IF    ( FLG-SYUDAY      =   ZERO )
                   DISPLAY "ORCSDR02 ERROR:SYUDAY INSERT CHK ERR"
                           " PTID="        SODR-PTID
                           " KARTE-KEY="   SODR-UID8
                   MOVE    1               TO  FLG-END
                   GO  TO  2102-SYUDAY-UPD-EXT
               END-IF
      *
               MOVE    SODR-OPID       TO  SDAY-OPID
               MOVE    SODR-UPYMD      TO  SDAY-CREYMD
                                           SDAY-UPYMD
               MOVE    SODR-UPHMS      TO  SDAY-UPHMS
      *
               MOVE    SYUDAY-REC      TO  MCPDATA-REC
               MOVE    PATH-TBL-SYUDAY-KEY
                                       TO  MCP-PATH
               PERFORM 910-DBINSERT-SEC
               IF    ( MCP-RC      NOT =   ZERO )
                   DISPLAY "ORCSDR02 ERROR:SYUDAY INSERT ERR"
                           " PTID="        SODR-PTID
                           " KARTE-KEY="   SODR-UID8
                   MOVE    1               TO  FLG-END
               END-IF
           END-IF
      *
           .
      *
       2102-SYUDAY-UPD-EXT.
           EXIT.
      *****************************************************************
      *    収納明細マスタ更新処理
      *****************************************************************
       2102-SYUMEI-UPD-SEC             SECTION.
      *
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
      *
      *    伝票番号
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
      *    伝票番号枝番
           MOVE    01                  TO  SMEI-DENPEDANUM
      *    診療科
           MOVE    SYU-SRYKA           TO  SMEI-SRYKA
      *    伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *    請求発行日（発行日の西暦）
           MOVE    SODR-UKEYMD         TO  SMEI-SKYPRINTYMD
      *    請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *    領収書発行日
           MOVE    SMEI-SKYPRINTYMD    TO  SMEI-RYOSYUPRINTYMD
      *    領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *    請求金額
           MOVE    SYU-SKYMONEY        TO  SMEI-SKYMONEY
      *    入返金日
           MOVE    SMEI-SKYPRINTYMD    TO  SMEI-NYUHEN-YMD
      *    入金連番
           MOVE    01                  TO  SMEI-NYUKINRENNUM
      *
      *    入金額がゼロの時、入金力なし
           IF    ( SYU-NYUKIN-TOTAL    =   ZERO )
               CONTINUE
           ELSE
      *        入返金区分
               MOVE    "1"             TO  SMEI-NYUHEN-KBN
      *        入返金額
               MOVE    SYU-NYUKIN-TOTAL
                                       TO  SMEI-NYUHEN-MONEY
      *        入金方法
               MOVE    "01"            TO  SMEI-NYUKIN-HOHO
           END-IF
      *
      *    状態区分
           IF    ( SYU-SKYMONEY        =   ZERO )
               MOVE    SPACE               TO  SMEI-JOUTAIKBN
           ELSE
               IF   (  SYU-SKYMONEY    >   SYU-NYUKIN-TOTAL )
                   MOVE    "9"             TO  SMEI-JOUTAIKBN
               ELSE
                   MOVE    "1"             TO  SMEI-JOUTAIKBN
               END-IF
           END-IF
      *
      *    更新前チェック（既に重複するデータがある場合はエラー）
           MOVE   ZERO             TO  FLG-SYUMEI
           MOVE    SYUMEI-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUMEI-KEY
                                   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               MOVE    1           TO  FLG-SYUMEI
           END-IF
      *
           MOVE    PATH-TBL-SYUMEI-KEY
                                   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-SYUMEI      =   ZERO )
               DISPLAY "ORCSDR02 ERROR:SYUMEI INSERT CHK ERR 2"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1           TO  FLG-END
               GO  TO  2102-SYUMEI-UPD-EXT
           END-IF
      *
      *
           MOVE    SODR-OPID       TO  SMEI-OPID
           MOVE    SODR-UPYMD          TO  SMEI-CREYMD
                                           SMEI-UPYMD
           MOVE    SODR-UPHMS          TO  SMEI-CREHMS
                                           SMEI-UPHMS
      *
           MOVE    SMEI-CREYMD         TO  SDAILYKEY-CREYMD
           MOVE    SMEI-CREHMS         TO  SDAILYKEY-CREHMS
           MOVE    SMEI-NYUHEN-YMD     TO  SDAILYKEY-BASEYMD
           PERFORM 800-DAILYKEY-SEC
           MOVE    SDAILYKEY-DAILYKEY  TO  SMEI-DAILYKEY
      *
           MOVE    SYUMEI-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUMEI-KEY
                                   TO  MCP-PATH
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC      NOT =   ZERO )
               DISPLAY "ORCSDR02 ERROR:SYUMEI INSERT ERR 2"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1           TO  FLG-END
               GO  TO  2102-SYUMEI-UPD-EXT
           END-IF
      *
           .
       2102-SYUMEI-UPD-EXT.
           EXIT.
      *****************************************************************
      *    伝票番号取得処理
      *****************************************************************
       21021-DENPNUM-GET-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
                                           WRK-DENPNUM
      *
           INITIALIZE                  SYS-0042-REC
           MOVE    "0042"              TO  SYS-0042-KANRICD
           MOVE    "*%"                TO  SYS-0042-KBNCD
           MOVE    SODR-SRYYMD         TO  SYS-0042-STYUKYMD
                                           SYS-0042-EDYUKYMD
      *
           MOVE    SYS-0042-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-SYSKANRI-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-0042-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYS-0042-REC
           END-IF
      *
           MOVE    PATH-TBL-SYSKANRI-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    SYS-0042-DENPNUMMAX-NYU
                                       TO  WRK-DENPNUM-X
               IF    ( WRK-DENPNUM-X   =   SPACE )
                   MOVE    ZERO        TO  SYS-0042-DENPNUMMAX-NYU
               ELSE
                   MOVE    WRK-DENPNUM-X
                                       TO  SYS-0042-DENPNUMMAX-NYU
               END-IF
      *
               COMPUTE SYS-0042-DENPNUMMAX-NYU
                   =   SYS-0042-DENPNUMMAX-NYU +   1
      *
               MOVE    SYS-0042-DENPNUMMAX-NYU
                                           TO  WRK-DENPNUM
      *
               MOVE    SODR-OPID           TO  SYS-0042-OPID
               MOVE    SODR-UPYMD          TO  SYS-0042-UPYMD
               MOVE    SODR-UPHMS          TO  SYS-0042-UPHMS
      *
               MOVE    SYS-0042-REC        TO  MCPDATA-REC
               MOVE    PATH-TBL-SYSKANRI-KEY
                                           TO  MCP-PATH
               PERFORM 910-DBUPDATE-SEC
               IF    ( MCP-RC          NOT =   ZERO )
                   DISPLAY "ORCSDR02 ERROR:DENPNUM UPDATE ERR"
                           " PTID="        SODR-PTID
                           " KARTE-KEY="   SODR-UID8
                   MOVE    1               TO  FLG-END
               END-IF
           ELSE
                   DISPLAY "ORCSDR02 ERROR:DENPNUM SELECT ERR"
                           " PTID="        SODR-PTID
                           " KARTE-KEY="   SODR-UID8
                   MOVE    1               TO  FLG-END
           END-IF
      *
           .
       21021-DENPNUM-GET-EXT.
           EXIT.
      *****************************************************************
      *    患者情報更新処理
      *****************************************************************
       2101-PTINF-UPDATE-SEC           SECTION.
      *
      *    入院歴より最新の歴情報を取得
           INITIALIZE  PTNYUINRRK-REC
           MOVE    SODR-HOSPID         TO  PTNYUINRRK-HOSPID
           MOVE    SODR-PTID           TO  PTNYUINRRK-PTID
           MOVE    PTNYUINRRK-REC    TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY35   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               INITIALIZE      PTNYUINRRK-REC
           END-IF
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY35   TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
      *    患者マスタ検索
           MOVE    ZERO                TO  FLG-PTINF
           INITIALIZE  PTINF-REC
           MOVE    SODR-HOSPID         TO  PTINF-HOSPID
           MOVE    SODR-PTID           TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
      *
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTINF-REC
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
      *    患者マスタクローズ
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-PTINF           NOT =   ZERO )
               DISPLAY "ORCSDR02 ERROR:PTINF UPDATE CHK ERR"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
               GO  TO  2101-PTINF-UPDATE-EXT
           END-IF
      *
      *    患者情報の入院歴番号を更新する
           MOVE   PTNYUINRRK-RRKNUM
                                       TO  PTINF-RRKNUM
           MOVE   PTNYUINRRK-RRKEDANUM
                                       TO  PTINF-RRKEDANUM
      *
           MOVE    SODR-OPID           TO  PTINF-OPID
           MOVE    SODR-UPYMD          TO  PTINF-UPYMD
           MOVE    SODR-UPHMS          TO  PTINF-UPHMS
      *
      *    患者情報更新
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBUPDATE-SEC
           IF     ( MCP-RC         NOT =  ZERO )
               DISPLAY "ORCSDR02 ERROR:PTINF UPDATE ERR"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
           END-IF
      *
           .
       2101-PTINF-UPDATE-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
           IF    ( ERRCD-ITEM      =   SPACE )
            AND  ( ERRCD-ORDER     =   SPACE )
                   MOVE    SPACE       TO  SODR-ERRCD
           ELSE
               IF    ( ERRCD-ITEM  =   SPACE )
                   MOVE    ERRCD-ORDER TO  SODR-ERRCD
               ELSE
                   MOVE    ERRCD-ITEM  TO  SODR-ERRCD
               END-IF
           END-IF
      *
           MOVE    WRK-INF         TO  SODR-INF
      *
           MOVE    FLG-END         TO  SODR-RC
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    半角文字チェック
      *****************************************************************
       800-HANKAKU-CHK-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-ENTRYCHK
      *
           IF  ( WRK-KANACHK-MAE-INPUT
                                   =   SPACE )
               GO  TO  800-HANKAKU-CHK-EXT
           END-IF
      *
           MOVE    SPACE           TO  ORCSKANACHKAREA
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    WRK-KANACHK-MAE-INPUT
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    =   ZERO )
               IF      ( KANACHK-SYUBETU   NOT =   1 )
                   MOVE    1       TO  FLG-ENTRYCHK
               END-IF
           ELSE
                   MOVE    1       TO  FLG-ENTRYCHK
           END-IF
      *
           .
       800-HANKAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    数値変換処理
      *****************************************************************
       800-ORCSNUM-SEC                 SECTION.
      *
           MOVE    ZERO                TO  FLG-ORCSNUM
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    WRK-SNUM-INX        TO  SNUM-INX
           CALL    "ORCSNUM"           USING   ORCSNUMAREA
           IF    ( SNUM-RC         NOT =   ZERO  )
            OR   ( SNUM-MINKBN     NOT =   SPACE )
            OR   ( SNUM-SYOKBN     NOT =   SPACE )
               MOVE    1               TO  FLG-ORCSNUM
           ELSE
               MOVE    SNUM-OUTNUM     TO  WRK-SNUM-OUTNUM
           END-IF
      *
           .
      *
       800-ORCSNUM-EXT.
           EXIT.
      *****************************************************************
      *    カレンダー処理
      *****************************************************************
       800-CALENDAR-SEC                SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    WRK-KIJUNYMD        TO  LNK-DAY6-KIJUN
           MOVE    WRK-ZOGENPTN        TO  LNK-DAY6-ZOGENPTN
           MOVE    WRK-ZOGEN           TO  LNK-DAY6-ZOGEN
           CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN     TO  WRK-KEISANYMD
      *
           .
       800-CALENDAR-EXT.
           EXIT.
      *****************************************************************
      *    期間算出処理
      *****************************************************************
       800-KIKAN-CALC-SEC              SECTION.
      *
           MOVE    ZERO                TO  FLG-ORCSDAY
                                           WRK-NISSU1
                                           WRK-NISSU2
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY5-AREA
           MOVE    "51"                TO  LNK-DAY5-IRAI
           MOVE    WRK-STYMD           TO  LNK-DAY5-START
           MOVE    WRK-EDYMD           TO  LNK-DAY5-END
           CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                           LNK-DAY5-AREA
           IF      ( STS-DAY-RC1       =   ZERO )
               MOVE    LNK-DAY5-NISSU1 TO  WRK-NISSU1
               MOVE    LNK-DAY5-NISSU2 TO  WRK-NISSU2
           ELSE
               MOVE    1               TO  FLG-ORCSDAY
           END-IF
      *
           .
       800-KIKAN-CALC-EXT.
           EXIT.
      *****************************************************************
      *    月末日取得処理
      *****************************************************************
       800-GETUMATU-SEC      SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY1-AREA
           MOVE    "71"                TO   LNK-DAY7-IRAI
           MOVE    WRK-SYMD (1 : 6)    TO   LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                       LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-SYMD
      *
           .
       800-GETUMATU-EXT.
            EXIT.
      *****************************************************************
      *    日報キー取得サブ
      *****************************************************************
       800-DAILYKEY-SEC         SECTION.
      *
           CALL    "ORCSDAILYKEY"   USING   SDAILYKEYAREA
      *
           .
      *
       800-DAILYKEY-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-SEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           INITIALIZE                      SYSKANRI-REC
      *
           MOVE    WRK-SYS-KANRICD     TO  SYS-KANRICD
           MOVE    SODR-SRYYMD         TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-SYSKANRI-KEY2
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理(KEY10)
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           INITIALIZE                      SYSKANRI-REC
      *
           MOVE    WRK-SYS-KANRICD     TO  SYS-KANRICD
           MOVE    WRK-SYS-KBNCD       TO  SYS-KBNCD
           MOVE    SODR-SRYYMD         TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-SYSKANRI-KEY10
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    PATH-TBL-SYSKANRI-KEY10
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-SYSKANRI-KEY10-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴検索処理(KEY)
      *****************************************************************
       900-PTNYUINRRK-KEY-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-PTNYUINRRK-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    オーダー検索処理(KEY)
      *****************************************************************
       900-ORDER-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-ORDER
      *
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-ORDER-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-ORDER
           END-IF
      *
           MOVE    PATH-TBL-ORDER-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-ORDER-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    オーダー検索処理(KEY2)
      *****************************************************************
       900-ORDER-KEY2-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-ORDER
      *
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-ORDER-KEY2 TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-ORDER
           END-IF
      *
           MOVE    PATH-TBL-ORDER-KEY2 TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-ORDER-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院会計検索処理(KEY17)
      *****************************************************************
       900-NYUINACCT-KEY17-SEL-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-NYUINACCT
      *
           INITIALIZE                      NYUINACCT-REC
           MOVE    SODR-HOSPID         TO  NACCT-HOSPID
           MOVE    SODR-PTID           TO  NACCT-PTID
           MOVE    SODR-SRYYMD (1:6)   TO  NACCT-SRYYM
           MOVE    "1"                 TO  NACCT-ZAISKBKBN
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-NYUINACCT-KEY17
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           MOVE    PATH-TBL-NYUINACCT-KEY17
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-NYUINACCT-KEY17-SEL-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ検索処理(KEY)
      *****************************************************************
       900-HKNCOMBI-KEY-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNCOMBI
      *
           INITIALIZE                      HKNCOMBI-REC
           MOVE    SODR-HOSPID         TO  COMB-HOSPID
           MOVE    SODR-PTID           TO  COMB-PTID
           MOVE    WRK-COMBI-HKNCOMBI  TO  COMB-HKNCOMBINUM
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-HKNCOMBI-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
           ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
      *
           MOVE    PATH-TBL-HKNCOMBI-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-HKNCOMBI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
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
      *    ＤＢ検索処理
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
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
           CALL    "MCPSUB"            USING
                                       MCPAREA
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
      *    MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢインサート処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ更新処理
      *****************************************************************
       910-DBUPDATE-SEC                SECTION.
      *
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ削除処理
      *****************************************************************
       910-DBDELETE-SEC                SECTION.
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
