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
           03  FLG-HIZUKE-ERR          PIC 9(01).
           03  FLG-WKPTNYUINRRK        PIC 9(01).
           03  FLG-HKNCOMBI            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-NYUKBN              PIC 9(05).
           03  CNT-SYOKAI              PIC 9(05).
           03  CNT-BTUNUM              PIC 9(05).
           03  CNT-BRMNUM              PIC 9(05).
           03  CNT-SAGAKU              PIC 9(05).
           03  CNT-DR                  PIC 9(05).
           03  CNT-TOKNYUIN            PIC 9(05).
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
           03  WRK-YMD                 PIC X(10).
           03  WRK-ZOGENPTN            PIC X(01).
           03  WRK-ZOGEN               PIC S9(05).
           03  WRK-SYMD                PIC X(08).
           03  WRK-KEISANYMD           PIC X(08).
           03  WRK-HENYMDG             PIC X(10).
           03  WRK-NYUINCHU-TAIINYMD   PIC X(08).
           03  WRK-COMBI-HKNCOMBI      PIC 9(04).
      *
       01  ITEM-AREA.
           03  ITEM-NYUKBN             PIC X(02).
           03  ITEM-SYOKAI             PIC X(02).
           03  ITEM-LASTNYINYMD        PIC X(08).
           03  ITEM-SYONUM             PIC 9(03).
           03  ITEM-BTUNUM             PIC X(02).
           03  ITEM-BRMNUM             PIC X(08).
           03  ITEM-SAGAKUCD           PIC X(02).
           03  ITEM-TOKNYUIN-G.
               05  ITEM-TOKNYUIN-KBN   PIC X(01).
               05  ITEM-TOKNYUIN-NYUIN PIC X(02).
           03  ITEM-TOKNYUINCD         PIC X(09).
           03  ITEM-SANTEICD           PIC X(09).
           03  ITEM-DRCD-G.
               05  ITEM-DRCD-MAX       PIC 9(02).
               05  ITEM-DRCD           PIC X(05)   OCCURS  3.
           03  ITEM-SHONUM             PIC 9(03).
           03  ITEM-DOUJITSUKBN        PIC X(01).
           03  ITEM-NYUINKA            PIC X(02).
           03  ITEM-HKNCOMBI           PIC 9(04).
      *
       01  ERRCD-AREA.
           03  ERRCD-ITEM              PIC X(04).
           03  ERRCD-ERRCD             PIC X(04).
           03  ERRCD-ORDER             PIC X(04).
      *
       01  CONST-AREA.
           03  CONST-TOKNYUIN-MAX      PIC 9(05)   VALUE   38.
           03  CONST-TOKNYUIN-VAL.
               05  PIC    X(03)        VALUE   "101".
               05  PIC    X(09)        VALUE   "190075810".
               05  PIC    X(03)        VALUE   "201".
               05  PIC    X(09)        VALUE   "190111110".
               05  PIC    X(03)        VALUE   "202".
               05  PIC    X(09)        VALUE   "190111210".
               05  PIC    X(03)        VALUE   "203".
               05  PIC    X(09)        VALUE   "190055210".
               05  PIC    X(03)        VALUE   "204".
               05  PIC    X(09)        VALUE   "190055310".
               05  PIC    X(03)        VALUE   "205".
               05  PIC    X(09)        VALUE   "190739910".
               05  PIC    X(03)        VALUE   "206".
               05  PIC    X(09)        VALUE   "190740110".
               05  PIC    X(03)        VALUE   "207".
               05  PIC    X(09)        VALUE   "190055010".
               05  PIC    X(03)        VALUE   "208".
               05  PIC    X(09)        VALUE   "190055110".
               05  PIC    X(03)        VALUE   "209".
               05  PIC    X(09)        VALUE   "190028910".
               05  PIC    X(03)        VALUE   "210".
               05  PIC    X(09)        VALUE   "190111410".
               05  PIC    X(03)        VALUE   "211".
               05  PIC    X(09)        VALUE   "190066910".
               05  PIC    X(03)        VALUE   "212".
               05  PIC    X(09)        VALUE   "190067010".
               05  PIC    X(03)        VALUE   "213".
               05  PIC    X(09)        VALUE   "190075910".
               05  PIC    X(03)        VALUE   "214".
               05  PIC    X(09)        VALUE   "190075810".
               05  PIC    X(03)        VALUE   "215".
               05  PIC    X(09)        VALUE   "190813410".
               05  PIC    X(03)        VALUE   "301".
               05  PIC    X(09)        VALUE   "190075710".
               05  PIC    X(03)        VALUE   "302".
               05  PIC    X(09)        VALUE   "190774110".
               05  PIC    X(03)        VALUE   "303".
               05  PIC    X(09)        VALUE   "190024510".
               05  PIC    X(03)        VALUE   "304".
               05  PIC    X(09)        VALUE   "190110210".
               05  PIC    X(03)        VALUE   "305".
               05  PIC    X(09)        VALUE   "190110310".
               05  PIC    X(03)        VALUE   "306".
               05  PIC    X(09)        VALUE   "190024310".
               05  PIC    X(03)        VALUE   "307".
               05  PIC    X(09)        VALUE   "190110410".
               05  PIC    X(03)        VALUE   "308".
               05  PIC    X(09)        VALUE   "190110510".
               05  PIC    X(03)        VALUE   "309".
               05  PIC    X(09)        VALUE   "190024610".
               05  PIC    X(03)        VALUE   "310".
               05  PIC    X(09)        VALUE   "190024710".
               05  PIC    X(03)        VALUE   "311".
               05  PIC    X(09)        VALUE   "190066710".
               05  PIC    X(03)        VALUE   "312".
               05  PIC    X(09)        VALUE   "190066810".
               05  PIC    X(03)        VALUE   "313".
               05  PIC    X(09)        VALUE   "190024810".
               05  PIC    X(03)        VALUE   "314".
               05  PIC    X(09)        VALUE   "190075510".
               05  PIC    X(03)        VALUE   "315".
               05  PIC    X(09)        VALUE   "190788810".
               05  PIC    X(03)        VALUE   "316".
               05  PIC    X(09)        VALUE   "190116310".
               05  PIC    X(03)        VALUE   "317".
               05  PIC    X(09)        VALUE   "190117310".
               05  PIC    X(03)        VALUE   "318".
               05  PIC    X(09)        VALUE   "190117410".
               05  PIC    X(03)        VALUE   "320".
               05  PIC    X(09)        VALUE   "190076710".
               05  PIC    X(03)        VALUE   "321".
               05  PIC    X(09)        VALUE   "190076810".
               05  PIC    X(03)        VALUE   "322".
               05  PIC    X(09)        VALUE   "190799410".
               05  PIC    X(03)        VALUE   "323".
               05  PIC    X(09)        VALUE   "190808910".
           03  CONST-TOKNYUIN-R    REDEFINES    CONST-TOKNYUIN-VAL.
               05  CONST-TOKNYUIN-OCC  OCCURS   38.
                   07  CONST-TOKNYUIN-G        PIC X(03).
                   07  CONST-TOKNYUINCD        PIC X(09).
           03  CONST-ITEMNUM-MAX               PIC 9(05)   VALUE 30.
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
           COPY    "CPSK1005.INC".
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
           INITIALIZE                  TRRK-REC
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
           IF    ( ERRCD-ITEM   =   SPACE )
               PERFORM 2002-KANREN-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ORDER  =   SPACE )
            AND  ( ERRCD-ITEM   =   SPACE )
      *
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
                   IF    ( SODR-PROCKBN    =   "1" )
                       PERFORM 2101-ORDER-RECONF-SEC
                   END-IF
               END-IF
      *
               IF    ( FLG-END  =   ZERO )
                  PERFORM 2101-ORDER-INSERT-SEC
               END-IF
           ELSE
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
               WHEN    NCLAIMID-NYUKBNID
                   PERFORM 20011-NYUKBN-CHK-SEC
               WHEN    NCLAIMID-SYOKAIID
                   PERFORM 20011-SYOKAI-CHK-SEC
               WHEN    NCLAIMID-BTUNUMID
                   PERFORM 20011-BTUNUM-CHK-SEC
               WHEN    NCLAIMID-BRMNUMID
                   PERFORM 20011-BRMNUM-CHK-SEC
               WHEN    NCLAIMID-SAGAKUID
                   PERFORM 20011-SAGAKU-CHK-SEC
               WHEN    NCLAIMID-DRID
                   PERFORM 20011-DR-CHK-SEC
               WHEN    NCLAIMID-TOKNYUINID
                   PERFORM 20011-TOKNYUIN-CHK-SEC
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
      *    入院区分チェック処理
      *****************************************************************
       20011-NYUKBN-CHK-SEC            SECTION.
      *
           COMPUTE CNT-NYUKBN  =   CNT-NYUKBN  +   1
      *
           IF    ( CNT-NYUKBN  =   1 )
      *
               EVALUATE    LNK-ORDER-ITEM (IDXA)
               WHEN    "01"
               WHEN    "02"
                   MOVE    LNK-ORDER-ITEM (IDXA)
                                   TO  ITEM-NYUKBN
               WHEN    OTHER
                   MOVE    "1001"  TO  ERRCD-ERRCD
                   PERFORM 2100-ITEM-ERR-SET-SEC
               END-EVALUATE
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "1002"  TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       20011-NYUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    継続区分チェック処理
      *****************************************************************
       20011-SYOKAI-CHK-SEC            SECTION.
      *
           COMPUTE CNT-SYOKAI  =   CNT-SYOKAI  +   1
      *
           IF    ( CNT-SYOKAI  =   1 )
      *
               EVALUATE    LNK-ORDER-ITEM (IDXA)
               WHEN    SPACE
                   CONTINUE
               WHEN    "01"
                   MOVE    LNK-ORDER-ITEM (IDXA)
                                           TO  ITEM-SYOKAI
                   MOVE    LNK-ORDER-REMARKS (IDXA)
                                           TO  WRK-YMD
                   INSPECT WRK-YMD REPLACING  ALL "-" BY  "."
                   PERFORM 800-SEIWA-HEN-SEC
                   IF    ( FLG-HIZUKE-ERR  NOT =   ZERO )
                       MOVE    "1021"      TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   ELSE
                       MOVE    WRK-SYMD    TO  ITEM-LASTNYINYMD
                   END-IF
               WHEN    OTHER
                   MOVE    "1003"  TO  ERRCD-ERRCD
                   PERFORM 2100-ITEM-ERR-SET-SEC
               END-EVALUATE
      *
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "1004"  TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       20011-SYOKAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟コードチェック処理
      *****************************************************************
       20011-BTUNUM-CHK-SEC            SECTION.
      *
           COMPUTE CNT-BTUNUM  =   CNT-BTUNUM  +   1
      *
           IF    ( CNT-BTUNUM  =   1 )
      *
               MOVE    "5001"          TO  WRK-SYS-KANRICD
               MOVE    LNK-ORDER-ITEM (IDXA)
                                       TO  WRK-SYS-KBNCD
               PERFORM 900-SYSKANRI-KEY10-SEL-SEC
               IF    ( FLG-SYSKANRI    =   ZERO )
                   MOVE    MCPDATA-REC TO  SYS-5001-REC
      *
                   MOVE    LNK-ORDER-ITEM (IDXA)
                                       TO  ITEM-BTUNUM
      *
                   MOVE    SYS-5001-BTU-KHNSRYCD
                                       TO  ITEM-SANTEICD
      *
               ELSE
                   MOVE    "1005"      TO  ERRCD-ERRCD
                   PERFORM 2100-ITEM-ERR-SET-SEC
               END-IF
      *
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "1006"      TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       20011-BTUNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室コードチェック処理
      *****************************************************************
       20011-BRMNUM-CHK-SEC            SECTION.
      *
           COMPUTE CNT-BRMNUM  =   CNT-BRMNUM  +   1
      *
           IF    ( CNT-BRMNUM  =   1 )
      *
               MOVE    "5002"      TO  WRK-SYS-KANRICD
               MOVE    ITEM-BTUNUM (1:2)
                                   TO  WRK-SYS-KBNCD (1:2)
      *
               INITIALIZE          ORCSBRMNUMAREA
               MOVE    "2"         TO  SBRMNUM-IN-PROCKBN
               MOVE    LNK-ORDER-ITEM (IDXA)
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
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "1008"  TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       20011-BRMNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    室料差額チェック処理
      *****************************************************************
       20011-SAGAKU-CHK-SEC            SECTION.
      *
           COMPUTE CNT-SAGAKU  =   CNT-SAGAKU  +   1
      *
           IF    ( CNT-SAGAKU  =   1 )
      *
               IF    ( LNK-ORDER-ITEM (IDXA)   =   SPACE )
                   CONTINUE
               ELSE
                   PERFORM 200111-SAGAKUCD-CHK-SEC
               END-IF
      *
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "1009"      TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       20011-SAGAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    室料差額コードチェック処理
      *****************************************************************
       200111-SAGAKUCD-CHK-SEC         SECTION.
      *
           MOVE    LNK-ORDER-ITEM (IDXA)
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
           COMPUTE CNT-DR  =   CNT-DR  +   1
           COMPUTE ITEM-DRCD-MAX   =   ITEM-DRCD-MAX   +   1
      *
           IF    ( CNT-DR  <=  3 )
      *
               IF    ( LNK-ORDER-ITEM (IDXA)   =   SPACE )
                   CONTINUE
               ELSE
                   MOVE    "1010"      TO  WRK-SYS-KANRICD
                   MOVE    LNK-ORDER-ITEM (IDXA)
                                       TO  WRK-SYS-KBNCD
      *
                   PERFORM 900-SYSKANRI-KEY10-SEL-SEC
                   IF    ( FLG-SYSKANRI    =   ZERO )
                       MOVE    LNK-ORDER-ITEM (IDXA)
                                   TO  ITEM-DRCD (ITEM-DRCD-MAX)
                   ELSE
                       MOVE    "1012"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
               END-IF
      *
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "1013"  TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       20011-DR-CHK-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料チェック処理
      *****************************************************************
       20011-TOKNYUIN-CHK-SEC          SECTION.
      *
           COMPUTE CNT-TOKNYUIN    =   CNT-TOKNYUIN    +   1
      *
           IF    ( CNT-TOKNYUIN    =   1 )
               IF    ( LNK-ORDER-ITEM (IDXA)   =   SPACE )
                   CONTINUE
               ELSE
      *
                   MOVE    SPACE       TO  ITEM-TOKNYUIN-G
                                           ITEM-TOKNYUINCD
                   PERFORM VARYING IDX0    FROM    1   BY  1
                           UNTIL ( IDX0    >   CONST-TOKNYUIN-MAX )
                            OR   ( ITEM-TOKNYUIN-G NOT =   SPACE )
      *
                       IF    ( CONST-TOKNYUIN-G (IDX0)
                                       =   LNK-ORDER-ITEM  (IDXA) )
                           MOVE    CONST-TOKNYUIN-G (IDX0)
                                       TO  ITEM-TOKNYUIN-G
                           MOVE    CONST-TOKNYUINCD (IDX0)
                                       TO  ITEM-TOKNYUINCD
                       END-IF
      *
                   END-PERFORM
      *
                   IF    ( ITEM-TOKNYUIN-G =   SPACE )
                       MOVE    "1023"      TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                   END-IF
      *
               END-IF
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "1022"      TO  ERRCD-ERRCD
               PERFORM 2100-ITEM-ERR-SET-SEC
           END-IF
      *
           .
       20011-TOKNYUIN-CHK-EXT.
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
                   MOVE    "1019"      TO  ERRCD-ERRCD
                   PERFORM 2100-ITEM-ERR-SET-SEC
               END-IF
      *
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "1028"      TO  ERRCD-ERRCD
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
                       MOVE    "1020"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
                    END-IF
               ELSE
                       MOVE    "1020"  TO  ERRCD-ERRCD
                       PERFORM 2100-ITEM-ERR-SET-SEC
               END-IF
      *
           ELSE
               PERFORM 2100-ITEM-UNPROCSTS-SET-SEC
               MOVE    "1029"      TO  ERRCD-ERRCD
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
      *    関連チェック処理
      *****************************************************************
       2002-KANREN-CHK-SEC             SECTION.
      *
           IF    ( ERRCD-ORDER     =   SPACE )
      *        入院区分チェック処理
               PERFORM 20021-NYUKBN-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
      *        病棟チェック処理
               PERFORM 20021-BTUNUM-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
      *        病室チェック処理
               PERFORM 20021-BRMNUM-CHK-SEC
           END-IF
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
      *        継続区分チェック処理
               PERFORM 20021-SYOKAI-CHK-SEC
           END-IF
      *
           IF    ( ERRCD-ORDER     =   SPACE )
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
       20021-NYUKBN-CHK-SEC          SECTION.
      *
           EVALUATE    ITEM-NYUKBN
           WHEN    SPACE
               MOVE    "1001"          TO  ERRCD-ORDER
           WHEN    "01"
               IF    ( ITEM-TOKNYUIN-G NOT =   SPACE )
                   MOVE    "1014"      TO  ERRCD-ORDER
               END-IF
           WHEN    "02"
               IF    ( ITEM-TOKNYUIN-G     =   SPACE )
                   MOVE    "1030"      TO  ERRCD-ORDER
               END-IF
           END-EVALUATE
      *
           .
       20021-NYUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟チェック処理
      *****************************************************************
       20021-BTUNUM-CHK-SEC          SECTION.
      *
           IF    ( ITEM-BTUNUM         =   SPACE )
               MOVE    "1005"          TO  ERRCD-ORDER
           END-IF
      *
           .
       20021-BTUNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室チェック処理
      *****************************************************************
       20021-BRMNUM-CHK-SEC          SECTION.
      *
           IF    ( ITEM-BRMNUM         =   SPACE )
               MOVE    "1007"          TO  ERRCD-ORDER
           END-IF
      *
           .
       20021-BRMNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院科チェック処理
      *****************************************************************
       20021-NYUINKA-CHK-SEC           SECTION.
      *
           IF    ( ITEM-NYUINKA    =   SPACE )
               MOVE    "1019"          TO  ERRCD-ORDER
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
           IF    ( ITEM-HKNCOMBI   =   ZERO )
               MOVE    "1020"          TO  ERRCD-ORDER
           END-IF
      *
           .
       20021-HKNCOMBI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    継続区分チェック処理
      *****************************************************************
       20021-SYOKAI-CHK-SEC            SECTION.
      *
           IF    ( ITEM-SYOKAI         =   "01" )
      *
               INITIALIZE              PTNYUINRRK-REC
               MOVE    SODR-HOSPID TO  PTNYUINRRK-HOSPID
               MOVE    SODR-PTID   TO  PTNYUINRRK-PTID
               MOVE    ITEM-LASTNYINYMD
                                   TO  PTNYUINRRK-NYUINYMD
               PERFORM 900-PTNYUINRRK-KEY39-SEL-SEC
               IF    ( FLG-PTNYUINRRK  =   ZERO )
                   MOVE    PTNYUINRRK-SHONUM
                                   TO  ITEM-SHONUM
               ELSE
                   MOVE    "1024"  TO  ERRCD-ORDER
               END-IF
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
               MOVE    "1016"          TO  ERRCD-ORDER
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
      *    入院日≦前回退院日でないこと
      *    前回退院日≦入院日となっていること
      *    前歴が自（他）院歴の場合は前回退院日＜入院日となっていること
           IF    ( PTNYUINRRK-JTIKBN    =  "5" OR  "6" )
      *
               IF    ( PTNYUINRRK-TAIINYMD
                                  <     SODR-SRYYMD )
                   CONTINUE
               ELSE
                   MOVE    "1017"      TO  ERRCD-ORDER
                   GO  TO  20021-NYUINRRK-CHK-EXT
               END-IF
      *
      *        前回自院歴チェック
               PERFORM 200211-ZENKAI-ZIINRRK-CHK-SEC
               IF    ( ERRCD-ORDER     NOT =   SPACE )
                   GO  TO  20021-NYUINRRK-CHK-EXT
               END-IF
           ELSE
               IF    ( PTNYUINRRK-TAIINYMD
                                  <=    SODR-SRYYMD )
                   CONTINUE
               ELSE
                   MOVE    "1027"      TO  ERRCD-ORDER
                   GO  TO  20021-NYUINRRK-CHK-EXT
               END-IF
      *
               IF    ( PTNYUINRRK-TAIINYMD =   SODR-SRYYMD )
                   MOVE    "1"         TO  ITEM-DOUJITSUKBN
               END-IF
      *
           END-IF
      *
      *    入院料が取得できていない場合
           IF    ( ITEM-SANTEICD       =   SPACE )
            AND  ( ITEM-TOKNYUINCD     =   SPACE )
               MOVE    "1018"          TO  ERRCD-ORDER
               GO  TO  20021-NYUINRRK-CHK-EXT
           END-IF
      *
           .
       20021-NYUINRRK-CHK-EXT.
           EXIT.
      *****************************************************************
      *    前回自院歴チェック
      *****************************************************************
       200211-ZENKAI-ZIINRRK-CHK-SEC   SECTION.
      *
      *    前回入院歴（自院分）をチェック
           MOVE    ZERO                TO  FLG-WKPTNYUINRRK
      *
           INITIALIZE      WKPTNYUINRRK-REC
           MOVE    SODR-HOSPID          TO  WKPTNYUINRRK-HOSPID
           MOVE    SODR-PTID            TO  WKPTNYUINRRK-PTID
      *
           MOVE    SODR-SRYYMD         TO  WRK-YMD
           MOVE    "1"                 TO  WRK-ZOGENPTN
           MOVE    -1                  TO  WRK-ZOGEN
           PERFORM 800-CALENDAR-SEC
           MOVE    WRK-KEISANYMD       TO  WKPTNYUINRRK-NYUINYMD
                                           WRK-NYUINCHU-TAIINYMD
      *
           MOVE    WKPTNYUINRRK-REC    TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY12
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-WKPTNYUINRRK
           ELSE
               MOVE    MCPDATA-REC     TO  WKPTNYUINRRK-REC
           END-IF
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY12
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-WKPTNYUINRRK    NOT =   ZERO )
               GO  TO  200211-ZENKAI-ZIINRRK-CHK-EXT
           END-IF
      *
      *    前歴の自院歴が「入院中」の場合
           IF    ( WKPTNYUINRRK-JTIKBN         =   "6" )
            AND  ( WKPTNYUINRRK-NYUINCHUKBN    =   "1" )
      *
      *        継続入院であること
               IF    ( ITEM-SYOKAI     NOT =   "01" )
                   MOVE    "1025"      TO  ERRCD-ORDER
                   GO TO   200211-ZENKAI-ZIINRRK-CHK-EXT
               END-IF
      *
      *        初回番号が等しいこと
               IF    ( WKPTNYUINRRK-SHONUM NOT =   ITEM-SHONUM )
                   MOVE    "1025"      TO  ERRCD-ORDER
                   GO TO   200211-ZENKAI-ZIINRRK-CHK-EXT
               END-IF
      *
      *        自院歴の退院日の翌日が入院日となっていること
               IF    ( WKPTNYUINRRK-TAIINYMD
                                   NOT =   WRK-NYUINCHU-TAIINYMD )
                   MOVE    "1026"      TO  ERRCD-ORDER
                   GO TO   200211-ZENKAI-ZIINRRK-CHK-EXT
               END-IF
           END-IF
      *
           .
       200211-ZENKAI-ZIINRRK-CHK-EXT.
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
           IF    ( ITEM-SYOKAI     =   SPACE )
               PERFORM 21011-SYONUM-GET-SEC
           END-IF
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
           MOVE    ITEM-NYUINKA    TO  PTNYUINRRK-NYUINKA
      *
      *    保険組合せ番号
           MOVE    ITEM-HKNCOMBI   TO  PTNYUINRRK-HKNCOMBINUM
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
           MOVE    ITEM-TOKNYUIN-KBN
                                   TO  PTNYUINRRK-TOKUTEI-KBN
      *
      *    特定入院料
           MOVE    ITEM-TOKNYUIN-NYUIN
                                   TO  PTNYUINRRK-TOKUTEI-NYUIN
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
           IF    ( ITEM-SYOKAI     =   SPACE )
               MOVE    "1"         TO  PTNYUINRRK-SHOKAIKBN
           ELSE
               MOVE    "2"         TO  PTNYUINRRK-SHOKAIKBN
           END-IF
      *
      *    初回番号
           MOVE    ITEM-SHONUM     TO  PTNYUINRRK-SHONUM
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
           MOVE    ITEM-DOUJITSUKBN
                                   TO  PTNYUINRRK-DOUJITSUKBN
      *
           MOVE    SODR-OPID       TO  PTNYUINRRK-OPID
           MOVE    SODR-UPYMD      TO  PTNYUINRRK-CREYMD
                                       PTNYUINRRK-UPYMD
           MOVE    SODR-UPHMS      TO  PTNYUINRRK-UPHMS
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
           MOVE    ZERO                TO  ITEM-SHONUM
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
               COMPUTE ITEM-SHONUM =   WKPTNYUINRRK-SHONUM +   1
           ELSE
               COMPUTE ITEM-SHONUM =   1
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
                                       =   NCLAIMID-NYUKBNID
                                       OR  NCLAIMID-SYOKAIID
                                       OR  NCLAIMID-BTUNUMID
                                       OR  NCLAIMID-BRMNUMID
                                       OR  NCLAIMID-SAGAKUID
                                       OR  NCLAIMID-DRID
                                       OR  NCLAIMID-TOKNYUINID 
                                       OR  NCLAIMID-NYUINKAID
                                       OR  NCLAIMID-HKNCOMBIID
                                           )
               CONTINUE
           ELSE
               MOVE    "3"             TO  ORDER-STATUS-ITEM
               MOVE    "1901"          TO  ORDER-ERRCD-ITEM
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
           MOVE    SODR-ORDERID    TO  SODRNACCT-ORDERID
           MOVE    SODR-OPID       TO  SODRNACCT-OPID
           MOVE    SODR-UPYMD      TO  SODRNACCT-UPYMD
           MOVE    SODR-UPHMS      TO  SODRNACCT-UPHMS
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
           MOVE    SODR-OPID           TO  PTINF-OPID
           MOVE    SODR-UPYMD          TO  PTINF-UPYMD
           MOVE    SODR-UPHMS          TO  PTINF-UPHMS
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
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-HIZUKE-ERR
           MOVE    SPACE               TO  WRK-SYMD
                                           WRK-HENYMDG
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           IF  ( SGDAY-RC              =   ZERO )
               MOVE    SGDAY-OTDAY     TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY      TO  WRK-SYMD
           ELSE
               MOVE    1               TO  FLG-HIZUKE-ERR
           END-IF
      *
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    カレンダー処理
      *****************************************************************
       800-CALENDAR-SEC                SECTION.
      *
      *    増減パターン 1:日／2:月／3:年
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
           MOVE    WRK-ZOGENPTN        TO  LNK-DAY6-ZOGENPTN
           MOVE    WRK-ZOGEN           TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN     TO  WRK-KEISANYMD
      *
           .
       800-CALENDAR-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴検索処理(KEY39)
      *****************************************************************
       900-PTNYUINRRK-KEY39-SEL-SEC    SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-PTNYUINRRK-KEY39
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               INITIALIZE                  PTNYUINRRK-REC
               MOVE    1               TO  FLG-PTNYUINRRK
           END-IF
      *
           MOVE    PATH-TBL-PTNYUINRRK-KEY39
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-PTNYUINRRK-KEY39-SEL-EXT.
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
      *    オーダー検索処理(KEY3)
      *****************************************************************
       900-ORDER-KEY3-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-ORDER
      *
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-ORDER-KEY3 TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  ORDER-REC
           ELSE
               INITIALIZE                  ORDER-REC
               MOVE    1               TO  FLG-ORDER
           END-IF
      *
           .
       900-ORDER-KEY3-SEL-EXT.
           EXIT.
      *****************************************************************
      *    オーダーFETCH処理(KEY3)
      *****************************************************************
       900-ORDER-KEY3-FET-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-ORDER
      *
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-ORDER-KEY3 TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  ORDER-REC
           ELSE
               INITIALIZE                  ORDER-REC
               MOVE    1               TO  FLG-ORDER
           END-IF
      *
           .
       900-ORDER-KEY3-FET-EXT.
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
