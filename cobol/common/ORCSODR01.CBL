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
       PROGRAM-ID.                     ORCSODR01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : オーダー編集（入院）
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
           03  FLG-ORDER               PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-PTINF               PIC 9(01).
           03  FLG-END                 PIC 9(01).
           03  FLG-ORCSNUM             PIC 9(01).
           03  FLG-ENTRYCHK            PIC 9(01).
           03  FLG-ITEM-CHK-G.
               05  FLG-ITEM-CHK        PIC 9(01)   OCCURS  20.
      *
      *    カウント領域
      *01  CNT-AREA.
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                    PIC 9(05).
           03  IDX1                    PIC 9(05).
           03  IDX2                    PIC 9(05).
           03  IDX3                    PIC 9(05).
           03  IDX4                    PIC 9(05).
           03  IDXA                    PIC 9(05).
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
      *
       01  ITEM-AREA.
           03  ITEM-NYUKBN             PIC X(02).
           03  ITEM-SYOKAI             PIC X(02).
           03  ITEM-BTUNUM             PIC X(02).
           03  ITEM-BRMNUM             PIC X(08).
           03  ITEM-SAGAKUCD           PIC X(02).
           03  ITEM-SANTEICD           PIC X(09).
           03  ITEM-DRCD-G.
               05  ITEM-DRCD-MAX       PIC 9(02).
               05  ITEM-DRCD           PIC X(05)   OCCURS  3.
      *
       01  ERRCD-AREA.
           03  ERRCD-ERRCD             PIC X(04).
           03  ERRCD-ZAI               PIC X(04).
      *
      *    入院CLAIM項目IDコピー句
           COPY    "CPNCLAIMID.INC".
      *
      *    患者入院履歴退避
       01  TRRK-REC.
           COPY    "CPPTNYUINRRK.INC"  REPLACING  //PTNYUINRRK-//
                                       BY         //TRRK-//.
      *
      *    患者入院履歴ワーク
       01  WKPTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC"  REPLACING  //PTNYUINRRK-//
                                       BY         //WKPTNYUINRRK-//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1010.INC".
           COPY    "CPSK5001.INC".
           COPY    "CPSK5002.INC".
           COPY    "CPSK5113.INC".
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
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    カナチェックパラメタ
           COPY    "CPORCSKANACHK.INC".
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
      *    入院会計作成サブ
           COPY    "CPORCSODRNACCT.INC".
       01  LNK-PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC"  REPLACING  //PTNYUINRRK-//
                                       BY         //LNK-PTNYUINRRK-//.
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
           02  LNK-ORDER-OCC           OCCURS   20.
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
      *    INITIALIZE                  CNT-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  ERRCD-AREA
           INITIALIZE                  ITEM-AREA
           INITIALIZE                  TRRK-REC
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
           IF    ( ERRCD-ZAI    =   SPACE )
               PERFORM 2002-KANREN-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ZAI    =   SPACE )
               IF    ( FLG-END  =   ZERO )
                   PERFORM 2101-PTNYUINRRK-INSERT-SEC
               END-IF
      *
               IF    ( FLG-END  =   ZERO )
                  PERFORM 2101-ORCSODRNACCT-CALL-SEC
               END-IF
      *
               IF    ( FLG-END  =   ZERO )
                  PERFORM 2101-PTINF-UPDATE-SEC
               END-IF
      *
               IF    ( FLG-END  =   ZERO )
                  PERFORM 2101-ORDER-INSERT-SEC
               END-IF
           ELSE
               IF    ( FLG-END  =   ZERO )
                  PERFORM 2101-ORDER-INSERT-SEC
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
           PERFORM 20011-NYUKBN-CHK-SEC
      *
           PERFORM 20011-SYOKAI-CHK-SEC
      *
           PERFORM 20011-BTUNUM-CHK-SEC
      *
           PERFORM 20011-BRMNUM-CHK-SEC
      *
           PERFORM 20011-SAGAKU-CHK-SEC
      *
           PERFORM 20011-DR-CHK-SEC
      *
           .
       2001-INPUT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院区分チェック処理
      *****************************************************************
       20011-NYUKBN-CHK-SEC            SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   LNK-ORDER-MAX )
      *
               IF    ( LNK-ORDER-SRYSKBKBN (IDXA)
                                   =   NCLAIMID-NYUKBNID )
      *
                   EVALUATE    LNK-ORDER-SRYCD (IDXA)
                   WHEN    "01"
                   WHEN    "02"
                       MOVE    LNK-ORDER-SRYCD (IDXA)
                                       TO  ITEM-NYUKBN
                   WHEN    OTHER
                       MOVE    "1001"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-EVALUATE
      *
                   IF    ( SODR-NYUKBN-FLG NOT =   ZERO )
                       MOVE    "1002"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
      *
               END-IF
      *
           END-PERFORM
      *
           .
       20011-NYUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    継続区分チェック処理
      *****************************************************************
       20011-SYOKAI-CHK-SEC            SECTION.
      *
           MOVE    "00"                TO  ITEM-SYOKAI
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   LNK-ORDER-MAX )
      *
               IF    ( LNK-ORDER-SRYSKBKBN (IDXA)
                                   =   NCLAIMID-SYOKAIID )
      *
                   EVALUATE    LNK-ORDER-SRYCD (IDXA)
                   WHEN    "01"
                       MOVE    LNK-ORDER-SRYCD (IDXA)
                                       TO  ITEM-SYOKAI
                   WHEN    OTHER
                       MOVE    "1003"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-EVALUATE
      *
                   IF    ( SODR-SYOKAI-FLG NOT =   ZERO )
                       MOVE    "1004"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
      *
               END-IF
      *
           END-PERFORM
      *
           .
       20011-SYOKAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟コードチェック処理
      *****************************************************************
       20011-BTUNUM-CHK-SEC            SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   LNK-ORDER-MAX )
      *
               IF    ( LNK-ORDER-SRYSKBKBN (IDXA)
                                   =   NCLAIMID-BTUNUMID )
      *
                   MOVE    "5001"      TO  WRK-SYS-KANRICD
                   MOVE    LNK-ORDER-SRYCD (IDXA)
                                       TO  WRK-SYS-KBNCD
                   PERFORM 900-SYSKANRI-KEY10-SEL-SEC
                   IF    ( FLG-SYSKANRI    =   ZERO )
                       MOVE    MCPDATA-REC TO  SYS-5001-REC
      *
                       MOVE    LNK-ORDER-SRYCD (IDXA)
                                       TO  ITEM-BTUNUM
      *
                       MOVE    SYS-5001-BTU-KHNSRYCD
                                       TO  ITEM-SANTEICD
      *
                   ELSE
                       MOVE    "1005"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
      *
                   IF    ( SODR-BTUNUM-FLG NOT =   ZERO )
                       MOVE    "1006"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       20011-BTUNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室コードチェック処理
      *****************************************************************
       20011-BRMNUM-CHK-SEC            SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   LNK-ORDER-MAX )
      *
               IF    ( LNK-ORDER-SRYSKBKBN (IDXA)
                                   =   NCLAIMID-BRMNUMID )
      *
                   MOVE    "5002"      TO  WRK-SYS-KANRICD
                   MOVE    ITEM-BTUNUM (1:2)
                                       TO  WRK-SYS-KBNCD (1:2)
      *
                   INITIALIZE          ORCSBRMNUMAREA
                   MOVE    "2"         TO  SBRMNUM-IN-PROCKBN
                   MOVE    LNK-ORDER-SRYCD (IDXA)
                                       TO  SBRMNUM-IN-BRMNUM
                   CALL    "ORCSBRMNUM"    USING   ORCSBRMNUMAREA
      *
                   MOVE    SBRMNUM-OT-BRMNUM
                                       TO  WRK-SYS-KBNCD (3:)
      *
                   PERFORM 900-SYSKANRI-KEY10-SEL-SEC
                   IF    ( FLG-SYSKANRI    =   ZERO )
                       MOVE    WRK-SYS-KBNCD
                                       TO  ITEM-BRMNUM
                   ELSE
                       MOVE    "1007"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
      *
                   IF    ( SODR-BRMNUM-FLG NOT =   ZERO )
                       MOVE    "1008"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       20011-BRMNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    室料差額チェック処理
      *****************************************************************
       20011-SAGAKU-CHK-SEC            SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   LNK-ORDER-MAX )
      *
               IF    ( LNK-ORDER-SRYSKBKBN (IDXA)
                                   =   NCLAIMID-SAGAKUID )
      *
                   PERFORM 200111-SAGAKUCD-CHK-SEC
      *
                   IF    ( SODR-SAGAKU-FLG NOT =   ZERO )
                       MOVE    "1009"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
      *
               END-IF
      *
           END-PERFORM
      *
           .
       20011-SAGAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    室料差額コードチェック処理
      *****************************************************************
       200111-SAGAKUCD-CHK-SEC         SECTION.
      *
           MOVE    LNK-ORDER-SRYCD (IDXA)
                                   TO  WRK-SNUM-INX
           PERFORM 800-ORCSNUM-SEC
           IF    ( FLG-ORCSNUM     NOT =   ZERO )
               MOVE    "1010"      TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           MOVE    WRK-SNUM-OUTNUM TO  WRK-SAGAKU
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           INITIALIZE                  SYS-5113-REC
           MOVE    "5113"          TO  SYS-5113-KANRICD
           MOVE    SODR-SRYYMD     TO  SYS-5113-STYUKYMD
                                       SYS-5113-EDYUKYMD
      *
           MOVE    SYS-5113-REC    TO  MCPDATA-REC
           MOVE    PATH-TBL-SYSKANRI-KEY2  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC      =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5113-REC
           ELSE
               MOVE    1           TO  FLG-SYSKANRI
               INITIALIZE              SYS-5113-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SYSKANRI        =   1 )
                    OR   ( ITEM-SAGAKUCD   NOT =   SPACE )
      *
               IF    ( WRK-SAGAKU  =   SYS-5113-BRM-SAGAKU-NM )
                   MOVE    SYS-5113-KBNCD
                                   TO  ITEM-SAGAKUCD
               END-IF
      *
               MOVE    PATH-TBL-SYSKANRI-KEY2  TO  MCP-PATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC      =   ZERO )
                   MOVE    MCPDATA-REC TO  SYS-5113-REC
               ELSE
                   MOVE    1           TO  FLG-SYSKANRI
                   INITIALIZE              SYS-5113-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-SYSKANRI-KEY2  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( ITEM-SAGAKUCD   =   SPACE )
               MOVE    "1011"      TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       200111-SAGAKUCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    担当医チェック処理
      *****************************************************************
       20011-DR-CHK-SEC                SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   LNK-ORDER-MAX )
      *
               IF    ( LNK-ORDER-SRYSKBKBN (IDXA)
                                   =   NCLAIMID-DRID )
      *
                   MOVE    "1010"      TO  WRK-SYS-KANRICD
                   MOVE    LNK-ORDER-SRYCD (IDXA)
                                       TO  WRK-SYS-KBNCD
      *
                   PERFORM 900-SYSKANRI-KEY10-SEL-SEC
                   IF    ( FLG-SYSKANRI    =   ZERO )
                       IF    ( ITEM-DRCD-MAX   <   3 )
                           COMPUTE ITEM-DRCD-MAX
                               =   ITEM-DRCD-MAX   +   1
                           MOVE    LNK-ORDER-SRYCD (IDXA)
                               TO  ITEM-DRCD (ITEM-DRCD-MAX)
                       END-IF
                   ELSE
                       MOVE    "1012"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
      *
                   IF    ( SODR-DR-FLG NOT =   ZERO )
                       MOVE    "1013"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
      *
               END-IF
      *
           END-PERFORM
      *
           .
       20011-DR-CHK-EXT.
           EXIT.
      *****************************************************************
      *    項目チェックエラー設定処理
      *****************************************************************
       2100-ITEM-ERR-SET-SEC           SECTION.
      *
           IF    ( ERRCD-ZAI      =   SPACE )
               MOVE    ERRCD-ERRCD TO  ERRCD-ZAI
           END-IF
      *
           IF    ( LNK-ORDER-ERRCD-ITEM (IDXA) =   SPACE )
               MOVE    ERRCD-ERRCD TO  LNK-ORDER-ERRCD-ITEM (IDXA)
           END-IF
      *
           .
       2100-ITEM-ERR-SET-EXT.
           EXIT.
      *****************************************************************
      *    関連チェック処理
      *****************************************************************
       2002-KANREN-CHK-SEC             SECTION.
      *
           IF    ( ERRCD-ZAI       =   SPACE )
      *        入院区分チェック処理
               PERFORM 20021-NYUKBN-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ZAI       =   SPACE )
      *        継続区分チェック処理
               PERFORM 20021-SYOKAI-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ZAI       =   SPACE )
      *        入院履歴チェック処理
               PERFORM 20021-NYUINRRK-CHK-SEC
           END-IF
      *
           .
       2002-KANREN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院区分チェック処理
      *****************************************************************
       20021-NYUKBN-CHK-SEC            SECTION.
      *
           IF    ( ITEM-NYUKBN     NOT =   "01" )
               MOVE    "1014"          TO  ERRCD-ZAI
           END-IF
      *
           .
       20021-NYUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    継続区分チェック処理
      *****************************************************************
       20021-SYOKAI-CHK-SEC            SECTION.
      *
           IF    ( ITEM-SYOKAI     NOT =   "00" )
               MOVE    "1015"          TO  ERRCD-ZAI
           END-IF
      *
           .
       20021-SYOKAI-CHK-EXT.
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
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
           MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
      *
      *    入院中で無いこと
           IF    ( PTNYUINRRK-TAIINYMD =   "99999999" )
               MOVE    "1016"          TO  ERRCD-ZAI
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
      *    入院日≦前回退院日でないこと
           IF    (  SODR-SRYYMD        =   PTNYUINRRK-TAIINYMD )
               MOVE    "1017"          TO  ERRCD-ZAI
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
      *    （暫）一般の入院料が取得できていない場合
           IF    ( ITEM-SANTEICD       =   SPACE )
               MOVE    "1018"          TO  ERRCD-ZAI
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
           .
       20021-NYUINRRK-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴追加処理
      *****************************************************************
       2101-PTNYUINRRK-INSERT-SEC      SECTION.
      *
      *    履歴番号取得処理
           PERFORM 21011-RRKNUM-GET-SEC
      *
      *    初回番号取得処理
           PERFORM 21011-SYONUM-GET-SEC
      *
           INITIALIZE                  PTNYUINRRK-REC
      *
      *    医療機関ＩＤ
           MOVE    SODR-HOSPID     TO  PTNYUINRRK-HOSPID
      *
      *    患者ＩＤ
           MOVE    SODR-PTID       TO  PTNYUINRRK-PTID
      *
      *    入院履歴番号（入院１回で＋１ずつ採番）
           MOVE    WRK-RRKNUM      TO  PTNYUINRRK-RRKNUM
      *
      *    入院履歴枝番号（転科・転室・転棟時に採番）
           MOVE    1               TO  PTNYUINRRK-RRKEDANUM
      *
      *    病棟番号
           MOVE    ITEM-BTUNUM     TO  PTNYUINRRK-BTUNUM
      *
      *    病室番号
           MOVE    ITEM-BRMNUM     TO  PTNYUINRRK-BRMNUM
      *
      *    入院科
           MOVE    SODR-SRYKA      TO  PTNYUINRRK-NYUINKA
      *
      *    保険組合せ番号
           MOVE    SODR-HKNCOMBI   TO  PTNYUINRRK-HKNCOMBINUM
      *
      *    入院日
           MOVE    SODR-SRYYMD     TO  PTNYUINRRK-NYUINYMD
      *
      *    退院日
           MOVE    "99999999"      TO  PTNYUINRRK-TAIINYMD
      *
      *    退院事由
           MOVE    SPACE           TO  PTNYUINRRK-TAIINCD
      *
      *    特定入院料区分
           MOVE    SPACE           TO  PTNYUINRRK-TOKUTEI-KBN
      *
      *    特定入院料
           MOVE    SPACE           TO  PTNYUINRRK-TOKUTEI-NYUIN
      *
      *    室料差額
           MOVE    ITEM-SAGAKUCD   TO  PTNYUINRRK-RM-SAGAKU
      *
      *    定期請求区分
           MOVE    "1"             TO  PTNYUINRRK-TEIKI-SEIKYUKBN
      *
      *    検索表示区分
           MOVE    "1"             TO  PTNYUINRRK-KENSAKU-DISPKBN
      *
      *    初回継続区分
           MOVE    "1"             TO  PTNYUINRRK-SHOKAIKBN
      *
      *    初回番号
           MOVE    WRK-SHONUM      TO  PTNYUINRRK-SHONUM
      *
      *    担当医１
           MOVE    ITEM-DRCD (1)   TO  PTNYUINRRK-DRCD1
      *
      *    担当医２
           MOVE    ITEM-DRCD (2)   TO  PTNYUINRRK-DRCD2
      *
      *    担当医３
           MOVE    ITEM-DRCD (3)   TO  PTNYUINRRK-DRCD3
      *
           MOVE    "1"             TO  PTNYUINRRK-JTIKBN
           MOVE    SODR-SRYYMD     TO  PTNYUINRRK-TENNYUYMD
           MOVE    "99999999"      TO  PTNYUINRRK-TENSTUYMD
      *
      *    入院中区分 ("0"固定)
           MOVE    "0"             TO  PTNYUINRRK-NYUINCHUKBN
      *
           MOVE    "CLAIM"         TO  PTNYUINRRK-TERMID
           MOVE    SODR-UKEYMD     TO  PTNYUINRRK-CREYMD
                                       PTNYUINRRK-UPYMD
           MOVE    SODR-UKEHMS     TO  PTNYUINRRK-UPHMS
      *
           PERFORM 900-PTNYUINRRK-KEY-SEL-SEC
           IF    ( FLG-PTNYUINRRK      =   ZERO )
               DISPLAY "ORCSDR01 ERROR:PTNYUINRRK INSERT CHK ERR"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
               GO  TO  2101-PTNYUINRRK-INSERT-EXT
           END-IF
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               DISPLAY "ORCSDR01 ERROR:PTNYUINRRK INSERT ERR"
                       " PTID="        SODR-PTID
                       " KARTE-KEY="   SODR-UID8
               MOVE    1               TO  FLG-END
           END-IF
      *
           MOVE    PTNYUINRRK-REC      TO  TRRK-REC
      *
           .
       2101-PTNYUINRRK-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    履歴番号取得処理
      *****************************************************************
       21011-RRKNUM-GET-SEC            SECTION.
      *
           MOVE    ZERO                TO  WRK-RRKNUM
      *
           INITIALIZE                      WKPTNYUINRRK-REC
      *
           MOVE    SODR-HOSPID       TO  WKPTNYUINRRK-HOSPID
           MOVE    SODR-PTID         TO  WKPTNYUINRRK-PTID
      *
           MOVE    WKPTNYUINRRK-REC    TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY9
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC      =   ZERO )
               MOVE    MCPDATA-REC     TO  WKPTNYUINRRK-REC
               COMPUTE WRK-RRKNUM  =   WKPTNYUINRRK-RRKNUM +   1
           ELSE
               COMPUTE WRK-RRKNUM  =   1
           END-IF
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY9
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       21011-RRKNUM-GET-EXT.
           EXIT.
      *****************************************************************
      *    初回番号取得処理
      *****************************************************************
       21011-SYONUM-GET-SEC            SECTION.
      *
           MOVE    ZERO                TO  WRK-SHONUM
      *
      *    入院履歴マスタ検索
           INITIALIZE                      WKPTNYUINRRK-REC
           MOVE    SODR-HOSPID       TO  WKPTNYUINRRK-HOSPID
           MOVE    SODR-PTID         TO  WKPTNYUINRRK-PTID
      *
           MOVE    WKPTNYUINRRK-REC    TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY6
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC      =   ZERO )
               MOVE    MCPDATA-REC     TO  WKPTNYUINRRK-REC
               COMPUTE WRK-SHONUM  =   WKPTNYUINRRK-SHONUM +   1
           ELSE
               COMPUTE WRK-SHONUM  =   1
           END-IF
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY6
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       21011-SYONUM-GET-EXT.
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
           IF    ( ERRCD-ZAI           =   SPACE )
               MOVE    TRRK-RRKNUM     TO  ORDER-SRYKAISU
               MOVE    TRRK-RRKEDANUM  TO  ORDER-ZAIKAISU
               MOVE    "0"             TO  ORDER-STATUS
           ELSE
               MOVE    "1"             TO  ORDER-STATUS
           END-IF
      *
           MOVE    ERRCD-ZAI           TO  ORDER-ERRCD-ZAI
      *
           IF    ( LNK-ORDER-SRYSKBKBN (IDXA)
                                       =   NCLAIMID-ORDERID
                                       OR  NCLAIMID-NYUKBNID
                                       OR  NCLAIMID-SYOKAIID
                                       OR  NCLAIMID-BTUNUMID
                                       OR  NCLAIMID-BRMNUMID
                                       OR  NCLAIMID-SAGAKUID
                                       OR  NCLAIMID-DRID     )
               CONTINUE
           ELSE
               MOVE    "1901"          TO  ORDER-ERRCD-ITEM
           END-IF
      *
           MOVE    "CLAIM"             TO  ORDER-OPID
           MOVE    SODR-UKEYMD         TO  ORDER-CREYMD
                                           ORDER-UPYMD
           MOVE    SODR-UKEHMS         TO  ORDER-UPHMS
      *
      *
           PERFORM 900-ORDER-KEY-SEL-SEC
           IF    ( FLG-ORDER           =   ZERO )
               DISPLAY "ORCSDR01 ERROR:ORDER INSERT CHK ERR"
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
               DISPLAY "ORCSDR01 ERROR:ORDER INSERT ERR"
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
           MOVE    SODR-IDOKBN     TO  SODRNACCT-IDOKBN
           MOVE    ITEM-NYUKBN     TO  SODRNACCT-NYUKBN
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
               DISPLAY "ORCSDR01 ERROR:PTINF UPDATE CHK ERR"
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
           MOVE    "CLAIM"             TO  PTINF-TERMID
           MOVE    SODR-UKEYMD         TO  PTINF-UPYMD
           MOVE    SODR-UKEHMS         TO  PTINF-UPHMS
      *
      *    患者情報更新
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBUPDATE-SEC
           IF     ( MCP-RC         NOT =  ZERO )
               DISPLAY "ORCSDR01 ERROR:PTINF UPDATE ERR"
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
