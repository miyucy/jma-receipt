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
       PROGRAM-ID.                 ORCSODRNACCT.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院
      *  コンポーネント名  : 電子カルテ入院会計作成
      *  管理者            : 
      *  作成日付    作業者        記述
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  02.07.01    NACL-小豆沢  05.12.06  入院登録時の食事と食堂加算の
      *                                     カレンダークリア対応と、朝食優先
      *                                     の条件追加
      *  02.07.02    NACL-小豆沢  05.12.12  転科、転棟、転室対応
      *  02.07.03    NACL-小豆沢  05.12.13  入院取消対応
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    入退院登録共通領域
           COPY    "I0COMMON-SPA".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                     PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-ORCSDAY                 PIC 9(01).
           03  FLG-NYUKSN                  PIC 9(01).
           03  FLG-HKNCOMBI                PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-TENSU                   PIC 9(01).
           03  FLG-SRYACCT                 PIC 9(01).
           03  FLG-RJN                     PIC 9(01).
           03  FLG-NYUINACCT               PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                         PIC 9(05).
           03  IDX0                        PIC 9(05).
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
           03  IDX3                        PIC 9(05).
           03  IDX4                        PIC 9(05).
           03  IDX5                        PIC 9(05).
           03  IDX6                        PIC 9(05).
           03  IDX7                        PIC 9(05).
           03  IDX8                        PIC 9(05).
           03  IDX9                        PIC 9(05).
           03  IDX10                       PIC 9(05).
           03  IDX11                       PIC 9(05).
           03  IDX12                       PIC 9(05).
           03  IDX13                       PIC 9(05).
           03  IDX14                       PIC 9(05).
           03  IDX15                       PIC 9(05).
           03  IDX16                       PIC 9(05).
           03  START-IDX                   PIC 9(05).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD     PIC X(08).
           03  SYS-TIME    PIC X(06).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-ERRCD                   PIC X(04).
           03  WRK-NAI-I01-IDOYMD          PIC X(08).
           03  WRK-NAI-I01-IDOYMD-MAE      PIC X(08).
           03  WRK-YMD                     PIC X(10). 
           03  WRK-SYMD.
               05  WRK-SYY                 PIC 9(04).
               05  WRK-SMM                 PIC 9(02).
               05  WRK-SDD                 PIC 9(02).
           03  WRK-HENYMDG                 PIC X(09).
      *
           03  WRK-AGE-YY                  PIC S9(04).
           03  WRK-AGE-MM                  PIC S9(02).
           03  WRK-AGE-G.
               05  WRK-AGE-Z               PIC ---9.
               05  WRK-AGE-MEI             PIC X(04).
           03  WRK-BIRTHDAY                PIC X(08).
           03  WRK-SAGAKU.
               05  WRK-SAGAKU-NUM          PIC ZZZZ9.
               05  WRK-SAGAKU-EN           PIC X(02).
           03  WRK-HKNCOMBI                PIC X(100).
           03  WRK-BRMNUM                  PIC X(06).
           03  WRK-BRMNUM-IN               PIC X(06).
           03  WRK-BRMNUM-EDT              PIC X(06).
           03  WRK-BRMNUM-OT               PIC X(06).
           03  WRK-NYUINKA-KEY             PIC X(02).
           03  WRK-BTUNUM-KEY              PIC X(02).
           03  WRK-BRMNUM-KEY              PIC X(08).
           03  WRK-HKNCOMBI-KEY            PIC X(04).
           03  WRK-TOKUTEI-KEY.
               05  WRK-TOKUTEI-KBN-KEY     PIC X(01).
               05  WRK-TOKUTEI-NYUIN-KEY   PIC X(02).
      *
           03  WRK-STYMD                       PIC X(08).
           03  WRK-EDYMD                       PIC X(08).
           03  WRK-NISSU                       PIC 9(05).
           03  WRK-NISSU1                      PIC 9(05).
           03  WRK-NISSU2                      PIC 9(05).
           03  WRK-TSUSAN                      PIC 9(05).
           03  WRK-NYUINNISSU                  PIC 9(05).
           03  WRK-SANTEISTYMD                 PIC X(08).
           03  WRK-SENTEI-STYMD                PIC X(08).
           03  WRK-BIRTHDAY-15                 PIC X(08).
           03  WRK-BIRTHDAY-15R   REDEFINES    WRK-BIRTHDAY-15.
               05  WRK-BIRTHDAY-15Y            PIC 9(04).
               05  WRK-BIRTHDAY-15MD           PIC 9(04).
           03  WRK-ZOGENPTN                PIC X(01).
           03  WRK-ZOGEN                   PIC S9(05).
           03  WRK-KEISANYMD               PIC X(08).
           03  WRK-HKNCOMBINUM             PIC X(04).
           03  WRK-HKNCOMBINUM9   REDEFINES  WRK-HKNCOMBINUM
                                           PIC 9(04).
           03  WRK-SAGAKU-KBN              PIC X(02).
           03  WRK-SAGAKU-KBN9  REDEFINES  WRK-SAGAKU-KBN
                                           PIC 9(02).
           03  WRK-TAIHI-SRYKA             PIC X(02).
      *
      *    医療機関設定の入院料加算チェック用
           03  WRK-NYUKHNKSN-SRYCD         PIC X(09)  OCCURS 20.
           03  WRK-NYUKSNKBN               PIC X(03).
           03  WRK-BTU-NYUKSNKBN           PIC X(03).
           03  WRK-KSN-NYUKSNKBN           PIC X(03).
           03  WRK-STYUKYMD                PIC X(08).
           03  WRK-TAIINYMD.
               05  WRK-TAIINYM             PIC X(06).
               05  WRK-TAIINDD             PIC 9(02).
           03  WRK-MCP-PUTTYPE             PIC X(08).
           03  WRK-ORCHCN01-SYORIKBN       PIC X(01).
           03  WRK-ORCHCN01-PRTKBN         PIC X(01).
           03  WRK-AGECHK-SRYYMD           PIC X(08).
           03  WRK-NACCT-SRYYM             PIC X(08).
           03  WRK-PRINT-PG                PIC X(20).
           03  WRK-ORCSHKN-HKNCOMBINUM     PIC X(04).
           03  WRK-TOKUBETSU-NYUIN         PIC X(01).
      *    会計作成用退避領域
           03  WRK-TAIHI-HKN               PIC 9(03).
           03  WRK-TAIHI-SHOKUJI           PIC 9(03).
           03  IDX-SHOKUJIX                PIC X(02).
           03  IDX-SHOKUJI9   REDEFINES    IDX-SHOKUJIX
                                           PIC 9(02).
           03  IDX-SKJ                     PIC 9(02).
           03  WRK-NYUINCHU-TAIINYMD       PIC X(08).
           03  WRK-ORCHCN01-HKNCOMBINUM    PIC 9(04).
           03  WRK-STIDX                   PIC 9(02).
           03  WRK-EDIDX                   PIC 9(02).
           03  WRK-MIN-YMD.
               05  WRK-MIN-YM              PIC X(06).
               05  WRK-MIN-DD              PIC 9(02).
      *    特定入院料の会計作成後に一般の入院料で会計を作成するための
      *    領域
           03  IPN-NYUKAIKEI-SAKUSEI-FLG   PIC X(01).
           03  IPN-SANTEISTYMD             PIC X(08).
           03  WRK-IPN-HANTEI-YMD1.
               05  WRK-IPN-HANTEI-YM1.
                   07  WRK-IPN-HANTEI-Y1   PIC 9(04).
                   07  WRK-IPN-HANTEI-M1   PIC 9(02).
               05  WRK-IPN-HANTEI-D1       PIC 9(02).
           03  WRK-IPN-HANTEI-YMD2         PIC X(08).
      *    特定入院料の会計作成用に診療コードを退避する領域
           03  WRK-TOKUTEI-SRYCD1          PIC X(09).
           03  WRK-TOKUTEI-SRYCD2          PIC X(09).
           03  WRK-SRYCD                   PIC X(09).
           03  WRK-SHOKAI-NYUINYMD-W       PIC X(10).
           03  WRK-CHK-SHONUM              PIC 9(03).
           03  WRK-I01-I04-PROCKBN         PIC X(01).
           03  WRK-FTN-NYUINYMD            PIC X(08).
           03  WRK-FTN-TAIINYMD            PIC X(08).
           03  WRK-FTN-RRKNUM              PIC 9(03).
           03  WRK-NYUREKILST-SEL          PIC 9(05).
      *
      *    転科／転棟／転室時に食事会計を退避する項目（最大２カ月分）
           03  WRK-TENROOM-SKJ-SRYYMX.
               05  WRK-TENROOM-SKJ-SRYYY9  PIC 9(04).
               05  WRK-TENROOM-SKJ-SRYMM9  PIC 9(02).
           03  WRK-TENROOM-SKJ-TABLE.
               05  WRK-TENROOM-SKJ-TBL     OCCURS  2.
                   07  WRK-TENROOM-SKJ-SRYYM
                                           PIC X(06).
                   07  WRK-TENROOM-SKJ-DD  PIC 9(02).
                   07  WRK-TENROOM-SKJ     PIC 9(03)  OCCURS  31.
           03  WRK-NAI-NYUINYMD.
               05  WRK-NAI-NYUINYM         PIC X(06).
               05  WRK-NAI-NYUINDD         PIC 9(02).
      *
      *    患者年齢算出用エリア
       01  WRK-NENREI-AREA.
           03  WRK-NENREI                  PIC 9(03).
           03  WRK-YMDS1.
               05  WRK-YYS1                PIC 9(04).
               05  WRK-MMS1                PIC 9(02).
               05  WRK-DDS1                PIC 9(02).
           03  WRK-YMDS2.
               05  WRK-YYS2                PIC 9(04).
               05  WRK-MMS2                PIC 9(02).
               05  WRK-DDS2                PIC 9(02).
      *
      *    退院日の同日再入院用ワーク領域
       01  WRK-DOU-AREA.
           03  WRK-DOU-NAI-I01-NYUINYMD      PIC X(08).
           03  WRK-DOU-PTNYUINRRK-TENNYUYMD  PIC X(08).
           03  WRK-DOU-TENNYUYMD             PIC X(08).
           03  FLG-JIINRRK                   PIC 9(01).
      *
      *    食堂加算設定用の退避領域
       01   WRK-SHOKUDOU                   PIC 9(02).
      *
      *    診療所老人医療管理料（転科、転棟）計算エリア
       01  TN-IDX                          PIC 9(02).
       01  WK-TOKUTEI-DAY                  PIC 9(04).
       01  WK-TOKUTEI-DAY2                 PIC 9(04).
      *
      *    外泊食事オーダーの日付退避
       01  WRK-STARTYMD.
           03  WRK-STARTYMD-YM.
               05  WRK-STARTYMD-Y          PIC 9(04).
               05  WRK-STARTYMD-M          PIC 9(02).
           03  WRK-STARTYMD-D              PIC 9(02).
       01  WRK-GETSUMATSU-YMD.
           03  WRK-GETSUMATSU-Y            PIC 9(04).
           03  WRK-GETSUMATSU-M            PIC 9(02).
           03  WRK-GETSUMATSU-D            PIC 9(02).
      *
       01  WRK-ROW.
           03  WRK-NYUREKILST-ROW          PIC S9(9)   BINARY.
      *
      *    スパ領域 ワーク
           COPY    "COMMON-SPA"      REPLACING
                               //SPA-// BY //WRK-SPA-//.
      *
      *    入院履歴ワーク
       01  WKPTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC"  REPLACING
                               //PTNYUINRRK-// BY //WKPTNYUINRRK-//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    （診療科入院科情報）
           COPY    "CPSK1005.INC".
      *    （職員情報）
           COPY    "CPSK1010.INC".
      *
      *    帳票プログラム名
           COPY    "CPSK1035.INC".
      *    （医療機関情報）
           COPY    "CPSK5000.INC".
      *    （病棟情報）
           COPY    "CPSK5001.INC".
      *    （病室情報）
           COPY    "CPSK5002.INC".
      *    （室料差額）
           COPY    "CPSK5113.INC".
      *    （特定入院料−病棟）
           COPY    "CPSK5110.INC".
      *    （特定入院料−病室）
           COPY    "CPSK5111.INC".
      *    
           COPY    "CPSK5013.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者他院歴付加情報
       01  PTTAINFUKA-REC.
           COPY    "CPPTTAINFUKA.INC".
      *
      *    老人一般コード変換
        01  SRYCDCHG-REC.
            COPY    "CPSRYCDCHG.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    入院料加算チェック
       01  NYUKSNCHK-REC.
           COPY    "CPNYUKSNCHK.INC".
      *
      *    選定療養費
       01  SENTEICDCHG-REC.
           COPY    "CPSENTEICDCHG.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    患者公費情報
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    入院登録サブ
           COPY    "CPI0SUB01.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTNUM.INC".
      *
      *    数値号変換サブ
           COPY    "CPORCSNUM.INC".
      *
      *    初期加算算定サブ
           COPY    "CPORCSSYOKIKSN.INC".
      *
      *    入院会計作成サブ
           COPY    "CPORCSNYUACCT.INC".
      *
      *    通算日数取得サブ
           COPY "CPORCSTUSAN.INC".
      *
      *    保険算定用年齢・割合計算サブ
           COPY    "CPORCSAGECHK.INC".
      *
      *    保険組合せ編集サブ
           COPY    "CPORCSHKNSET.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
      *    入院オーダー会計作成
           COPY    "CPORCSODRNACCT.INC".
      *    入院履歴
       01  LNK-PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC"   REPLACING //PTNYUINRRK-//
                                        BY        //LNK-PTNYUINRRK-//.
      *
      *
       PROCEDURE                   DIVISION    USING
                                               SODRNACCT-AREA
                                               LNK-PTNYUINRRK-REC.
      *****************************************************************
      *    主    処    理
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
      *
           DISPLAY "SODRNACCT-ORDERID = " SODRNACCT-ORDERID
           MOVE    SPACE           TO  WRK-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    SODRNACCT-ORDERID
      *       （入院）
               WHEN    "0101"
                   PERFORM   4801-NYUKAIKEI-EDIT-SEC
      *       （退院）
               WHEN    "0102"
                   PERFORM   4801-TAIINKAIKEI-EDIT-SEC
      *       （転科／転棟／転室）
               WHEN    "0103"
               WHEN    "0104"
               WHEN    "0105"
                   PERFORM   4801-TENROOM-EDIT-SEC
                   IF    IPN-NYUKAIKEI-SAKUSEI-FLG   =  "1"
                       PERFORM   4801-TENROOM-EDIT-SEC
                   END-IF
      *       （入院取消）
               WHEN    "0107"
      *       （入院取消−会計含む）
               WHEN    "0108"
                   PERFORM   4801-NYUKAIKEI-ERASE-SEC
      *       （外泊）
               WHEN    "0201"
               WHEN    "0202"
               WHEN    "0203"
               WHEN    "0204"
               WHEN    "0205"
                   PERFORM   4801-GAIHAKU-SEC
      *       （食事）
               WHEN    "0301"
               WHEN    "0302"
               WHEN    "0303"
               WHEN    "0304"
               WHEN    "0305"
                   PERFORM   4801-SHOKUJI-SEC
           END-EVALUATE
      *
           MOVE      ZERO    TO   SODRNACCT-RC
           .
      *
       000-PROC-EXT.
           EXIT    PROGRAM.
      *
      *****************************************************************
      *    入院　会計テーブル編集処理
      *****************************************************************
       4801-NYUKAIKEI-EDIT-SEC         SECTION.
      *
           INITIALIZE                      PTINF-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  PTINF-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC
           IF     MCP-RC    =   ZERO
               MOVE    MCPDATA-REC     TO  PTINF-REC
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           INITIALIZE      ORCSSYOKIKSNAREA
      *
      *    通算日数、算定開始日を求める
           PERFORM 4801-TSUSAN-SANTEI-GET-SEC
           IF    ( WRK-ERRCD    NOT =  SPACE )
               GO  TO  4801-NYUKAIKEI-EDIT-EXT
           END-IF
      *
           MOVE    WRK-TSUSAN      TO  SYOKIKSN-IN-TUSANNISSU
           MOVE    WRK-SANTEISTYMD
                                   TO  SYOKIKSN-IN-SANTEISTYMD
      *
           PERFORM  4801-BTUSEL-SEC
      *
           IF      LNK-PTNYUINRRK-TOKUTEI-NYUIN    NOT =   SPACE
               PERFORM   4801-TOKTEI-NYUIN-SET-SEC
           ELSE
               IF  SYS-5001-BTU-KHNSRYCD      NOT =   SPACE
                   MOVE    SYS-5001-BTU-KHNSRYCD
                                       TO  SYOKIKSN-IN-KHNSRYCD
                   PERFORM   4801-RJNCD-CHG-SEC
                   CALL    "ORCSSYOKIKSN"  USING   ORCSSYOKIKSNAREA
                   IF    ( SYOKIKSN-OT-RC  NOT =   ZERO )
                       MOVE    "4017"      TO  WRK-ERRCD
                       GO  TO  4801-NYUKAIKEI-EDIT-EXT
                   END-IF
               ELSE
                   MOVE    "4018"      TO  WRK-ERRCD
                   GO  TO  4801-NYUKAIKEI-EDIT-EXT
               END-IF
           END-IF
      *
      *    入院会計作成サブの呼出し
           INITIALIZE            ORCSNYUACCT-AREA
           MOVE     "1"     TO   LNK-SCNYUACCT-SYORI-KBN
           MOVE     "1"                TO  SPA-NYUGAIKBN
           MOVE     LNK-PTNYUINRRK-PTID    TO  SPA-PTID
           MOVE     LNK-PTNYUINRRK-NYUINKA TO  SPA-SRYKA
           MOVE    SYOKIKSN-IN-KHNSRYCD
                            TO   LNK-SCNYUACCT-NYUKHN-SRYCD(1)
           MOVE    SYOKIKSN-IN-SANTEISTYMD
                            TO   LNK-SCNYUACCT-STSRYYMD
           PERFORM   VARYING   IDX6   FROM   1   BY   1
               UNTIL (SYOKIKSN-OT-KGNSRYCD(IDX6)  =  SPACE) OR
                     (IDX6   >     7)
               MOVE   SYOKIKSN-OT-KGNSRYCD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-SRYCD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOSTYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-STYUKYMD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOEDYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-EDYUKYMD(IDX6)
           END-PERFORM
      *
      *    通算算定済日数
           MOVE   WRK-TSUSAN    TO  LNK-SCNYUACCT-NYUKHN-NISUU
      *
      *    特定入院で入院料が変更になるコードの対応
      *    診療所老人医療管理料
           IF    SYOKIKSN-IN-KHNSRYCD   =   "190774110"
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                        LNK-SCNYUACCT-NYUKHN-SRYCD(1)
                 MOVE   "190774110"  TO  LNK-SCNYUACCT-KAGEN-SRYCD(1)
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                  TO  LNK-SCNYUACCT-KAGEN-STYUKYMD(1)
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE    13                TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
      *
                 MOVE   "190774210"  TO  LNK-SCNYUACCT-KAGEN-SRYCD(2)
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE     1                TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO LNK-SCNYUACCT-KAGEN-STYUKYMD(2)
                 MOVE    "99999999"
                                  TO LNK-SCNYUACCT-KAGEN-EDYUKYMD(2)
           END-IF
      *
      *    特定入院料で７日まで、１４日まで、それ以降は一般入院料を算定する
      *    場合の診療コードを取得
           PERFORM    4801-TOKUTEI-NYUIN-7-14-SEC
      *
           IF    SYOKIKSN-IN-KHNSRYCD   =   WRK-TOKUTEI-SRYCD1
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                        LNK-SCNYUACCT-NYUKHN-SRYCD(1)
                 MOVE   WRK-TOKUTEI-SRYCD1  
                                  TO  LNK-SCNYUACCT-KAGEN-SRYCD(1)
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                  TO  LNK-SCNYUACCT-KAGEN-STYUKYMD(1)
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE     6                TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
      *
                 MOVE   WRK-TOKUTEI-SRYCD2
                                  TO  LNK-SCNYUACCT-KAGEN-SRYCD(2)
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE     1                TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO LNK-SCNYUACCT-KAGEN-STYUKYMD(2)
                 MOVE    "99999999"
                                  TO LNK-SCNYUACCT-KAGEN-EDYUKYMD(2)
      *          一般入院料の算定開始日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE     14               TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO       IPN-SANTEISTYMD
      *          一般入院会計作成用のフラグ設定
                 MOVE    "1"      TO      IPN-NYUKAIKEI-SAKUSEI-FLG
           END-IF
      *
      *    広範囲熱傷特定集中治療室管理料（６０日上限）
           IF    SYOKIKSN-IN-KHNSRYCD   =   "190024810"
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                        LNK-SCNYUACCT-NYUKHN-SRYCD(1)
                 MOVE   "190024810"  TO  LNK-SCNYUACCT-KAGEN-SRYCD(1)
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                  TO  LNK-SCNYUACCT-KAGEN-STYUKYMD(1)
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE    59                TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
      *          一般入院料の算定開始日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE     60               TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO       IPN-SANTEISTYMD
      *          特定入院期間（６０日経過）した際の一般入院料作成の
      *          可否を判定
                 MOVE    LNK-PTNYUINRRK-TENNYUYMD
                                  TO      WRK-IPN-HANTEI-YMD1
                 IF      WRK-IPN-HANTEI-M1   =   12
                     ADD    1     TO      WRK-IPN-HANTEI-Y1
                     MOVE   1     TO      WRK-IPN-HANTEI-M1
                 ELSE
                     ADD    1     TO      WRK-IPN-HANTEI-M1
                 END-IF
      *          月末日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY7-AREA
                 MOVE    "71"              TO  LNK-DAY7-IRAI
                 MOVE   WRK-IPN-HANTEI-YM1 TO  LNK-DAY7-YM
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY7-AREA
                 MOVE    LNK-DAY7-KOYOMI   TO      WRK-IPN-HANTEI-YMD1
                 MOVE    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                                  TO      WRK-IPN-HANTEI-YMD2
      *          一般入院会計作成用のフラグ設定
                 IF      WRK-IPN-HANTEI-YMD1 > WRK-IPN-HANTEI-YMD2
                     MOVE    "1"   TO     IPN-NYUKAIKEI-SAKUSEI-FLG
                 END-IF
           END-IF
      *
      *    ハイケアユニット入院医療管理料（２１日を限度）
           IF    SYOKIKSN-IN-KHNSRYCD   =   "190117310"
                 MOVE   SPACE       TO   IPN-NYUKAIKEI-SAKUSEI-FLG
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                         LNK-SCNYUACCT-NYUKHN-SRYCD(1)
                 MOVE   "190117310"
                                    TO   LNK-SCNYUACCT-KAGEN-SRYCD(1)
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                  TO  LNK-SCNYUACCT-KAGEN-STYUKYMD(1)
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE    20                TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
      *          一般入院料の算定開始日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE     21               TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO       IPN-SANTEISTYMD
      *          一般入院会計作成用のフラグ設定
                 MOVE    "1"      TO      IPN-NYUKAIKEI-SAKUSEI-FLG
           END-IF
      *
      *-------特定入院対応ここまで-----------------------------------
      *
      *    入院料加算診療コード取り込み
           PERFORM    4801-NYUKSN-GET-SEC
      *
      *    特定入院料区分のセット
           IF      LNK-PTNYUINRRK-TOKUTEI-NYUIN    =   SPACE
               MOVE     "0"     TO  LNK-SCNYUACCT-TOKUTEINYUIN-KBN
           ELSE
               MOVE     "1"     TO  LNK-SCNYUACCT-TOKUTEINYUIN-KBN
           END-IF
      *    外泊
           MOVE   "099999911"   TO  LNK-SCNYUACCT-GAIHAKU-SRYCD
      *    室料差額
           MOVE   "099999912"   TO  LNK-SCNYUACCT-SAGAKU-SRYCD
           IF     LNK-PTNYUINRRK-RM-SAGAKU   =   SPACE
               MOVE    ZERO     TO  LNK-SCNYUACCT-SAGAKU-KBN
           ELSE
               MOVE   LNK-PTNYUINRRK-RM-SAGAKU 
                                TO  WRK-SAGAKU-KBN
               MOVE   WRK-SAGAKU-KBN9
                                TO  LNK-SCNYUACCT-SAGAKU-KBN
           END-IF
      *    食事区分
           MOVE   "099999913"   TO  LNK-SCNYUACCT-SHOKUJI-SRYCD
           MOVE   0             TO  LNK-SCNYUACCT-SHOKUJIKBN
      *    食堂加算
           PERFORM     4801-BTUSEL-SEC
           IF   FLG-SYSKANRI           =    ZERO
               IF   SYS-5001-BTU-SYOKUDOKBN       =    "2"
                    MOVE     "197000570"    TO
                                LNK-SCNYUACCT-SHOKUDO-SRYCD
                    MOVE    0   TO   LNK-SCNYUACCT-SHOKUDO-KBN
               END-IF
           END-IF
      *    保険組合せ
           MOVE   "099999914"   TO  LNK-SCNYUACCT-HKNCOMBINUM-SRYCD
           MOVE   LNK-PTNYUINRRK-HKNCOMBINUM
                                TO  WRK-HKNCOMBINUM
           MOVE   WRK-HKNCOMBINUM9 
                                TO  LNK-SCNYUACCT-HKNCOMBINUM
           MOVE   SPA-SRYKA     TO  WRK-TAIHI-SRYKA
           MOVE   "00"          TO  SPA-SRYKA
           PERFORM 4801-SENTEI-SET-SEC
           MOVE  LNK-PTNYUINRRK-HOSPID   TO  SPA-HOSPID
           MOVE  LNK-PTNYUINRRK-PTID     TO  SPA-PTID
           CALL   "ORCSNYUACCT"  USING   SPA-AREA
                                         ORCSNYUACCT-AREA
           MOVE   WRK-TAIHI-SRYKA TO     SPA-SRYKA
           IF     LNK-SCNYUACCT-RC   NOT =  ZERO
               DISPLAY  "ORCGI01 ORCSNYUACCT ERR RC = "
                         LNK-SCNYUACCT-RC
           END-IF
      *
           IF     IPN-NYUKAIKEI-SAKUSEI-FLG    =   "1"
               MOVE    SPACE   TO   LNK-PTNYUINRRK-TOKUTEI-NYUIN
               MOVE    IPN-SANTEISTYMD   TO   WRK-SANTEISTYMD
               MOVE    IPN-SANTEISTYMD   TO   WRK-NAI-I01-IDOYMD
               MOVE    IPN-SANTEISTYMD   TO   LNK-PTNYUINRRK-TENNYUYMD
                   PERFORM   4801-TENROOM-EDIT-SEC
           END-IF
      *
           .
       4801-NYUKAIKEI-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    特定入院料（７日／１４日／それ以降）の診療コードセット
      *****************************************************************
       4801-TOKUTEI-NYUIN-7-14-SEC         SECTION.
      *
      *特定入院料で７日まで、１４日まで、それ以降は一般入院料を算定する
      *場合の診療コードを取得
      *
           MOVE      SPACE        TO    IPN-NYUKAIKEI-SAKUSEI-FLG
           MOVE      "999999999"  TO    WRK-TOKUTEI-SRYCD1
                                        WRK-TOKUTEI-SRYCD2
           EVALUATE   SYOKIKSN-IN-KHNSRYCD
      *    特定集中治療室管理料
               WHEN   "190024610"
                   MOVE    "190024610"  TO  WRK-TOKUTEI-SRYCD1
                   MOVE    "190074610"  TO  WRK-TOKUTEI-SRYCD2
      *    特定集中治療室管理料（重症者等比率基準未満）
               WHEN   "190116310"
                   MOVE    "190116310"  TO  WRK-TOKUTEI-SRYCD1
                   MOVE    "190116410"  TO  WRK-TOKUTEI-SRYCD2
      *    救命救急入院料１
               WHEN   "190024510"
                   MOVE    "190024510"  TO  WRK-TOKUTEI-SRYCD1
                   MOVE    "190074510"  TO  WRK-TOKUTEI-SRYCD2
      *    救命救急入院料１（高度）
               WHEN   "190110210"
                   MOVE    "190110210"  TO  WRK-TOKUTEI-SRYCD1
                   MOVE    "190110610"  TO  WRK-TOKUTEI-SRYCD2
      *    救命救急入院料１（Ａまたは新設）
               WHEN   "190110310"
                   MOVE    "190110310"  TO  WRK-TOKUTEI-SRYCD1
                   MOVE    "190110710"  TO  WRK-TOKUTEI-SRYCD2
      *    救命救急入院料２
               WHEN   "190024310"
                   MOVE    "190024310"  TO  WRK-TOKUTEI-SRYCD1
                   MOVE    "190024410"  TO  WRK-TOKUTEI-SRYCD2
      *    救命救急入院料２（高度）
               WHEN   "190110410"
                   MOVE    "190110410"  TO  WRK-TOKUTEI-SRYCD1
                   MOVE    "190110810"  TO  WRK-TOKUTEI-SRYCD2
      *    救命救急入院料２（Ａまたは新設）
               WHEN   "190110510"
                   MOVE    "190110510"  TO  WRK-TOKUTEI-SRYCD1
                   MOVE    "190110910"  TO  WRK-TOKUTEI-SRYCD2
      *    一類感染症患者入院医療管理料
               WHEN   "190075510"
                   MOVE    "190075510"  TO  WRK-TOKUTEI-SRYCD1
                   MOVE    "190075610"  TO  WRK-TOKUTEI-SRYCD2
           END-EVALUATE
           .
      *
       4801-TOKUTEI-NYUIN-7-14-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院料加算の取り込み処理
      *****************************************************************
       4801-NYUKSN-GET-SEC         SECTION.
      *
           MOVE   ZERO             TO   IDX8
      *
      *医療機関加算（減算）情報
           INITIALIZE              SYSKANRI-REC
           MOVE    "5000"          TO  SYS-KANRICD
           EVALUATE   SODRNACCT-ORDERID(3:2)
               WHEN   "01"
                   MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                   TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
      **         WHEN   "08"
      **             MOVE   WRK-NAI-I01-IDOYMD
      **                             TO  SYS-STYUKYMD
      **                                 SYS-EDYUKYMD
      **         WHEN   "09"
      **             MOVE   SPA-NAI-I01-MAEIDOYMD
      **                             TO  SYS-STYUKYMD
      **                                 SYS-EDYUKYMD
               WHEN   OTHER
                   MOVE    SPA-SYSYMD
                                   TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
           END-EVALUATE
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
      *
      *    システム管理マスタの医療機関情報より取得
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC
      *
           IF   MCP-RC             =    ZERO
               MOVE    MCPDATA-REC TO   SYS-5000-REC
      *        入院料加算
               PERFORM   VARYING   IDX7   FROM   1  BY  1
                 UNTIL  (SYS-5000-KSNCD(IDX7)    =   SPACE)  OR
                        (IDX7                    >   20)
                    IF   SYS-5000-KSNKBN(IDX7)   =   "2"
                             ADD    1                TO  IDX8
                             MOVE   SYS-5000-KSNCD(IDX7)  TO
                                             WRK-NYUKHNKSN-SRYCD(IDX8)
                    END-IF
               END-PERFORM
      *        地域加算
               IF   SYS-5000-CHIIKIKSN    NOT =   SPACE
                    ADD    1        TO   IDX8
                    MOVE   SYS-5000-CHIIKIKSN   TO
                                             WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
           END-IF
      *
      *    システム管理マスタクローズ
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
      *病棟加算情報
           PERFORM     4801-BTUSEL-SEC
      *
           IF   FLG-SYSKANRI           =    ZERO
      *
      *        看護補助加算
               IF    SYS-5001-BTU-KNGHJOKSN   NOT =   SPACE
                   ADD      1          TO     IDX8
                   EVALUATE     SYS-5001-BTU-KNGHJOKSN
                       WHEN     "01"
                           MOVE  "190103070"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                       WHEN     "02"
                           MOVE  "190103470"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                       WHEN     "03"
                           MOVE  "190103770"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                       WHEN     "04"
                           MOVE  "190103970"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                       WHEN     "05"
                           MOVE  "190104070"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                   END-EVALUATE
               END-IF
      *
      *        夜間勤務等看護加算
               IF    SYS-5001-BTU-YAKANKNGKSN   NOT =   SPACE
                   ADD      1          TO     IDX8
                   EVALUATE     SYS-5001-BTU-YAKANKNGKSN
                       WHEN     "01"
                           MOVE  "190109870"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                       WHEN     "02"
                           MOVE  "190076070"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                       WHEN     "03"
                           MOVE  "190076170"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                       WHEN     "04"
                           MOVE  "190076370"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                       WHEN     "05"
                           MOVE  "190076470"   TO
                                              WRK-NYUKHNKSN-SRYCD(IDX8)
                   END-EVALUATE
               END-IF
      *
      *        小児入院医療管理料加算（保育士１人以上）
               IF    SYS-5001-BTU-HIKSISUKBN   =   "2"
                   ADD      1          TO     IDX8
                   MOVE  "190111370"   TO  WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *
      *        病棟入院料加算
               PERFORM   VARYING   IDX7   FROM   1  BY  1
                 UNTIL  (IDX7                    >   12)
                    IF   IDX7          =       6
      *                 児童思春期精神科入院医療管理加算（２０才未満）
                        IF   SYS-5001-KSNKBN(IDX7)   =   "2"
                             PERFORM   4801-PT-AGE-SEC
                             IF     WRK-NENREI    <      20
                                 ADD    1                TO  IDX8
                                 MOVE   SYS-5001-KSNCD(IDX7)  TO
                                           WRK-NYUKHNKSN-SRYCD(IDX8)
                             END-IF
                        END-IF
                    ELSE
                        IF   IDX7  =  3  OR  4  OR  5
                             CONTINUE
                        ELSE
                            IF   SYS-5001-KSNKBN(IDX7)   =   "2"
                                 ADD    1                TO  IDX8
                                 MOVE   SYS-5001-KSNCD(IDX7)  TO
                                            WRK-NYUKHNKSN-SRYCD(IDX8)
                            END-IF
                        END-IF
                    END-IF
               END-PERFORM
           END-IF
      *
      *病室情報
           PERFORM     4801-BRMSEL-SEC
      *
           IF   FLG-SYSKANRI       =    ZERO
      *        新生児入院医療管理加算
               IF   SYS-5002-SINSEIJI-KBN     =   "2"
                    ADD     1       TO     IDX8
                    MOVE   SYS-5002-SINSEIJI-CD  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        診療所療養病床療養環境加算（１）
               IF   SYS-5002-SNR-RYOYO-KBN(1)     =   "2"
                    ADD     1       TO     IDX8
                    MOVE   SYS-5002-SNR-RYOYO-CD(1)  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        診療所療養病床療養環境加算（２）
               IF   SYS-5002-SNR-RYOYO-KBN(2)     =   "2"
                    ADD     1       TO     IDX8
                    MOVE   SYS-5002-SNR-RYOYO-CD(2)  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        放射線治療病室管理加算
               IF   SYS-5002-HOSYASEN-KBN     =   "2"
                    ADD     1       TO     IDX8
                    MOVE   SYS-5002-HOSYASEN-CD  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        療養環境加算
               IF   SYS-5002-RYOYO-KBN     =   "2"
                    ADD     1       TO     IDX8
                    MOVE   SYS-5002-RYOYO-CD  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        療養病棟療養環境加算１
               IF   SYS-5002-BTU-RYOYO-KBN(1)     =   "2"
                    ADD     1       TO     IDX8
                    MOVE   "190106070"  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        療養病棟療養環境加算２
               IF   SYS-5002-BTU-RYOYO-KBN(2)     =   "2"
                    ADD     1       TO     IDX8
                    MOVE   "190106170"  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        療養病棟療養環境加算３
               IF   SYS-5002-BTU-RYOYO-KBN(3)     =   "2"
                    ADD     1       TO     IDX8
                    MOVE   "190106270"  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        重症者等療養環境特別加算（個室）
               IF   SYS-5002-JYUTOK1-KBN          =   "2"
                    ADD     1       TO     IDX8
                    MOVE   SYS-5002-JYUTOK1-CD  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        重症者等療養環境特別加算（２人部屋）
               IF   SYS-5002-JYUTOK2-KBN          =   "2"
                    ADD     1       TO     IDX8
                    MOVE   SYS-5002-JYUTOK2-CD  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
      *        無菌治療室管理加算
               IF   SYS-5002-MUKIN-KBN            =   "2"
                    ADD     1       TO     IDX8
                    MOVE   SYS-5002-MUKIN-CD  TO
                                   WRK-NYUKHNKSN-SRYCD(IDX8)
               END-IF
           END-IF
      *
      *    入院料と入院料加算の併算定チェック
           MOVE    ZERO            TO     IDX9
           PERFORM    VARYING    IDX8   FROM   1   BY   1
                      UNTIL      (WRK-NYUKHNKSN-SRYCD(IDX8)  =  SPACE)
                         OR      (IDX8   >     20)
                         PERFORM   4801-NYUKSN-CHK-SEC
                         IF     FLG-NYUKSN       =   ZERO   
                             ADD    1                TO  IDX9
                             MOVE   WRK-NYUKHNKSN-SRYCD(IDX8)  TO
                                   LNK-SCNYUACCT-NYUKHNKSN-SRYCD(IDX9)
                         END-IF
           END-PERFORM
      *
           .
      *
       4801-NYUKSN-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院料加算の算定可・不可チェック
      *****************************************************************
       4801-NYUKSN-CHK-SEC         SECTION.
      *
           MOVE    ZERO            TO  FLG-NYUKSN
      *
      **     EVALUATE   WRK-NYUKHNKSN-SRYCD(IDX8)
      *        診療録管理体制加算
      **         WHEN   "190100370"
      **             IF   SODRNACCT-IDOKBN   =  "07" OR "08"
      **                  MOVE   1        TO     FLG-NYUKSN
      **             END-IF
      *            自院での継続入院チェック
      **     END-EVALUATE
      *
      *    入院料加算チェックテーブルによる判定
           INITIALIZE  NYUKSNCHK-REC
      *
           PERFORM   48011-TENSU-SEL-SEC
           MOVE    WRK-BTU-NYUKSNKBN
                                   TO  NYUKSNCHK-NYUINKBN
           PERFORM   48012-TENSU-SEL-SEC
           MOVE    WRK-KSN-NYUKSNKBN
                                   TO  NYUKSNCHK-KSNKBN
           MOVE    SYOKIKSN-IN-SANTEISTYMD    TO  NYUKSNCHK-YUKOSTYMD
                                                  NYUKSNCHK-YUKOEDYMD
      *
           MOVE    "tbl_nyuksnchk" TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           MOVE    NYUKSNCHK-REC   TO  MCPDATA-REC
           PERFORM 900-TBL-SELECT-SEC
           IF      MCP-RC        =   ZERO
               MOVE    MCPDATA-REC TO  NYUKSNCHK-REC
           ELSE
               MOVE   1        TO     FLG-NYUKSN
               GO  TO          4801-NYUKSN-CHK-EXT
           END-IF
      *
           MOVE    "tbl_nyuksnchk"      TO  MCP-TABLE
           MOVE    "key"                TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           IF    ( NYUKSNCHK-CHKKBN    =   "1" OR "2" )
               CONTINUE
           ELSE
               MOVE   1        TO     FLG-NYUKSN
               GO  TO  4801-NYUKSN-CHK-EXT
           END-IF
      *
           .
      *
       4801-NYUKSN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ検索処理（入院料）
      *****************************************************************
       48011-TENSU-SEL-SEC              SECTION.
      *
           MOVE    SPACE           TO  WRK-NYUKSNKBN
           MOVE    SPACE           TO  WRK-TOKUBETSU-NYUIN
      *
           MOVE    ZERO            TO  FLG-TENSU
           INITIALIZE              TNS-TENSU-REC
      *
           IF      LNK-SCNYUACCT-NYUKHN-SRYCD(1) NOT = SPACE
               MOVE   LNK-SCNYUACCT-NYUKHN-SRYCD(1)
                                   TO  TNS-SRYCD
           ELSE
               MOVE   LNK-SCNYUACCT-KAGEN-SRYCD(1)
                                   TO  TNS-SRYCD
           END-IF
           MOVE    SYOKIKSN-IN-SANTEISTYMD    TO  TNS-YUKOSTYMD
                                                  TNS-YUKOEDYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC
           IF    ( MCP-RC        =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
           END-IF
      *
      *    点数マスタクローズ
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           IF    ( FLG-TENSU       NOT =   ZERO )
               GO  TO  48011-TENSU-SEL-EXT
           END-IF
      *
           MOVE    TNS-NYUKHNKSNKBN
                                   TO  WRK-BTU-NYUKSNKBN
      *
      *    特別入院料の判定
           EVALUATE   TNS-NYUKHNKBN
               WHEN   73
               WHEN   74
               WHEN   75
               WHEN   76
               WHEN   77
               WHEN   78
               WHEN   79
                   MOVE    "1"     TO  WRK-TOKUBETSU-NYUIN
           END-EVALUATE
           .
      *
       48011-TENSU-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ検索処理（入院料加算）
      *****************************************************************
       48012-TENSU-SEL-SEC              SECTION.
      *
           MOVE    SPACE           TO  WRK-NYUKSNKBN
      *
           MOVE    ZERO            TO  FLG-TENSU
           INITIALIZE              TNS-TENSU-REC
      *
      *    特別入院料算定時に幼児加算と乳幼児加算の加算コード置き換え
           IF      WRK-TOKUBETSU-NYUIN   =   "1"
               EVALUATE   WRK-NYUKHNKSN-SRYCD(IDX8)
                   WHEN   "190100470"
                       MOVE  "190100570"  TO  WRK-NYUKHNKSN-SRYCD(IDX8)
                   WHEN   "190100770"
                       MOVE  "190100870"  TO  WRK-NYUKHNKSN-SRYCD(IDX8)
               END-EVALUATE
           END-IF
      *
           MOVE    WRK-NYUKHNKSN-SRYCD(IDX8)
                                   TO  TNS-SRYCD
           MOVE    SYOKIKSN-IN-SANTEISTYMD    TO  TNS-YUKOSTYMD
                                                  TNS-YUKOEDYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  TNS-TENSU-REC
           ELSE
               MOVE    1           TO  FLG-TENSU
           END-IF
      *
      *    点数マスタクローズ
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           IF    ( FLG-TENSU       NOT =   ZERO )
               GO  TO  48012-TENSU-SEL-EXT
           END-IF
      *
           MOVE    TNS-NYUKHNKSNKBN
                                   TO  WRK-KSN-NYUKSNKBN
           .
      *
       48012-TENSU-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院患者の年齢算出
      *****************************************************************
       4801-PT-AGE-SEC         SECTION.
      *
           INITIALIZE                      PTINF-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  PTINF-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC
           IF    ( MCP-RC       =   ZERO  )
               MOVE    MCPDATA-REC     TO  PTINF-REC
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           IF      FLG-PTINF           =   1
               MOVE    ZERO            TO  WRK-NENREI
           ELSE
               MOVE   PTINF-BIRTHDAY   TO  WRK-YMDS1
               MOVE   SYOKIKSN-IN-SANTEISTYMD
                                       TO  WRK-YMDS2
               MOVE   ZERO             TO  WRK-NENREI
               COMPUTE  WRK-NENREI     =   WRK-YYS2
                                       -   WRK-YYS1
               IF   WRK-YMDS1(5:4)     >   WRK-YMDS2(5:4)
                    ADD   -1           TO  WRK-NENREI
               END-IF
           END-IF
      *
           .
      *
       4801-PT-AGE-EXT.
           EXIT.
      *
      *****************************************************************
      *     選定療養費診療行為コード取得処理
      *****************************************************************
       4801-SENTEI-SET-SEC         SECTION.
      *
           INITIALIZE  SENTEICDCHG-REC
           MOVE    LNK-SCNYUACCT-NYUKHN-SRYCD(1)
                                   TO  SENCHG-IPNSRYCD
           MOVE    SENTEICDCHG-REC TO  MCPDATA-REC
           MOVE    "tbl_senteicdchg"   TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC
           IF    ( MCP-RC      =   ZERO  )
               MOVE    MCPDATA-REC TO  SENTEICDCHG-REC
           ELSE
               INITIALIZE              SENTEICDCHG-REC
           END-IF
      *
           MOVE    "tbl_senteicdchg"   TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
      **     MOVE    SENCHG-SENTEISRYCD
      **                             TO  LNK-SCNYUACCT-SENTEI-SRYCD
           IF      SENCHG-SENTEISRYCD    NOT =  SPACE
               MOVE    "099999916"   TO  LNK-SCNYUACCT-SENTEI-SRYCD
               MOVE    WRK-SENTEI-STYMD
                                     TO  LNK-SCNYUACCT-SENTEI-STYMD
           END-IF
      *
           INITIALIZE                      PTINF-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  PTINF-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC
           IF    ( MCP-RC    =   ZERO  )
               MOVE    MCPDATA-REC     TO  PTINF-REC
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
      *    １５才未満の患者は選定入院対象外
           DISPLAY "PTINF-BIRTHDAY = " PTINF-BIRTHDAY
           MOVE     PTINF-BIRTHDAY   TO  WRK-BIRTHDAY-15
           ADD      15               TO  WRK-BIRTHDAY-15Y
           DISPLAY  "WRK-SENTEI-STYMD = " WRK-SENTEI-STYMD
           DISPLAY  "WRK-BIRTHDAY-15 = " WRK-BIRTHDAY-15
           IF       WRK-SENTEI-STYMD <=  WRK-BIRTHDAY-15
               MOVE   WRK-BIRTHDAY-15  TO  LNK-SCNYUACCT-SENTEI-STYMD
           END-IF
      *
      *
           .
       4801-SENTEI-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    通算日数取得処理
      *****************************************************************
       4801-TSUSAN-SANTEI-GET-SEC      SECTION.
      *
           INITIALIZE                  WRK-TSUSAN
                                       WRK-SANTEISTYMD
      *
           INITIALIZE                  ORCSTUSANAREA
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  STUSAN-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID TO  STUSAN-PTID
           MOVE    LNK-PTNYUINRRK-TENNYUYMD
                                   TO  STUSAN-KJNYMD
      *    特定入院での算定済日数を取得用
      *    特定集中治療室管理料
      *    救命救急入院料
      *    一類感染症患者入院医療管理料
      *    広範囲熱傷特定集中治療室管理料
      *    ハイケアユニット入院医療管理料
      *    亜急性期入院医療管理料
           IF   LNK-PTNYUINRRK-TOKUTEI-KBN   =   "3"
               EVALUATE   LNK-PTNYUINRRK-TOKUTEI-NYUIN
                   WHEN   "03"
                   WHEN   "04"
                   WHEN   "05"
                       MOVE   "190024510"  TO  STUSAN-TOKUTEI-SRYCD(1)
                       MOVE   "190074510"  TO  STUSAN-TOKUTEI-SRYCD(2)
                       MOVE   "190110210"  TO  STUSAN-TOKUTEI-SRYCD(3)
                       MOVE   "190110610"  TO  STUSAN-TOKUTEI-SRYCD(4)
                       MOVE   "190110310"  TO  STUSAN-TOKUTEI-SRYCD(5)
                       MOVE   "190110710"  TO  STUSAN-TOKUTEI-SRYCD(6)
                   WHEN   "06"
                   WHEN   "07"
                   WHEN   "08"
                       MOVE   "190024310"  TO  STUSAN-TOKUTEI-SRYCD(1)
                       MOVE   "190024410"  TO  STUSAN-TOKUTEI-SRYCD(2)
                       MOVE   "190110410"  TO  STUSAN-TOKUTEI-SRYCD(3)
                       MOVE   "190110810"  TO  STUSAN-TOKUTEI-SRYCD(4)
                       MOVE   "190110510"  TO  STUSAN-TOKUTEI-SRYCD(5)
                       MOVE   "190110910"  TO  STUSAN-TOKUTEI-SRYCD(6)
                   WHEN   "09"
                   WHEN   "16"
                       MOVE   "190024610"  TO  STUSAN-TOKUTEI-SRYCD(1)
                       MOVE   "190074610"  TO  STUSAN-TOKUTEI-SRYCD(2)
                       MOVE   "190116310"  TO  STUSAN-TOKUTEI-SRYCD(3)
                       MOVE   "190116410"  TO  STUSAN-TOKUTEI-SRYCD(4)
                   WHEN   "14"
                       MOVE   "190075510"  TO  STUSAN-TOKUTEI-SRYCD(1)
                       MOVE   "190075610"  TO  STUSAN-TOKUTEI-SRYCD(2)
                   WHEN   "13"
                       MOVE   "190024810"  TO  STUSAN-TOKUTEI-SRYCD(1)
                   WHEN   "17"
                       MOVE   "190117310"  TO  STUSAN-TOKUTEI-SRYCD(1)
                   WHEN   "18"
                       MOVE   "190117410"  TO  STUSAN-TOKUTEI-SRYCD(1)
               END-EVALUATE
           END-IF
           CALL    "ORCSTUSAN"     USING   ORCSTUSANAREA
           IF    ( STUSAN-RC       NOT =   ZERO )
      *         MOVE    "4025"      TO  WRK-ERRCD
               DISPLAY  "WRK-ERRCD = " WRK-ERRCD
      *         GO  TO  4801-TSUSAN-SANTEI-GET-EXT
           END-IF
      *
           COMPUTE WRK-TSUSAN  =   STUSAN-NISSU03  -   1
           MOVE    LNK-PTNYUINRRK-TENNYUYMD
                                   TO  WRK-SANTEISTYMD
      *
           MOVE    WRK-SANTEISTYMD
                                   TO  WRK-YMD
           MOVE    "1"             TO  WRK-ZOGENPTN
           IF    ( STUSAN-KJNYMD-CHK-FLG  =   ZERO )
               COMPUTE WRK-ZOGEN   =   180 -   STUSAN-NISSU04
           ELSE
               COMPUTE WRK-ZOGEN   =   180 - ( STUSAN-NISSU04  -   1 )
           END-IF
      *
           PERFORM 5002-CALENDAR-SEC
           MOVE    WRK-KEISANYMD   TO  WRK-SENTEI-STYMD
      *
           .
       4801-TSUSAN-SANTEI-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟情報検索処理
      *****************************************************************
       4801-BTUSEL-SEC             SECTION.
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    "5001"          TO  SYS-KANRICD
           MOVE    LNK-PTNYUINRRK-BTUNUM
                                   TO  SYS-KBNCD
           EVALUATE   SODRNACCT-ORDERID(3:2)
               WHEN   "01"
               WHEN   "03"
               WHEN   "04"
               WHEN   "05"
                   MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                   TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
      **         WHEN   "08"
      **             MOVE   WRK-NAI-I01-IDOYMD
      **                             TO  SYS-STYUKYMD
      **                                 SYS-EDYUKYMD
      **         WHEN   "09"
      **             MOVE   SPA-NAI-I01-MAEIDOYMD
      **                             TO  SYS-STYUKYMD
      **                                 SYS-EDYUKYMD
               WHEN   OTHER
                   MOVE    SPA-SYSYMD
                                   TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
           END-EVALUATE
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC
           IF    ( MCP-RC    =   ZERO )
               MOVE    MCPDATA-REC
                                  TO  SYS-5001-REC
           ELSE
               MOVE    1          TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       4801-BTUSEL-EXT.
           EXIT.
      *****************************************************************
      *    病室情報検索処理
      *****************************************************************
       4801-BRMSEL-SEC             SECTION.
      *
           INITIALIZE              SYSKANRI-REC
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    "5002"          TO  SYS-KANRICD
           MOVE    LNK-PTNYUINRRK-BRMNUM
                                   TO  SYS-KBNCD
           EVALUATE   SODRNACCT-ORDERID(3:2)
               WHEN   "01"
               WHEN   "03"
               WHEN   "04"
               WHEN   "05"
                   MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                   TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
      **         WHEN   "08"
      **             MOVE   WRK-NAI-I01-IDOYMD
      **                             TO  SYS-STYUKYMD
      **                                 SYS-EDYUKYMD
      **         WHEN   "09"
      **             MOVE   SPA-NAI-I01-MAEIDOYMD
      **                             TO  SYS-STYUKYMD
      **                                 SYS-EDYUKYMD
               WHEN   OTHER
                   MOVE    SPA-SYSYMD
                                   TO  SYS-STYUKYMD
                                       SYS-EDYUKYMD
           END-EVALUATE
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC
           IF    ( MCP-RC    =   ZERO )
               MOVE    MCPDATA-REC
                                  TO  SYS-5002-REC
           ELSE
               MOVE    1          TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       4801-BRMSEL-EXT.
           EXIT.
      *****************************************************************
      *    特定入院料セット処理
      *****************************************************************
       4801-TOKTEI-NYUIN-SET-SEC   SECTION.
      *    病棟
           IF  LNK-PTNYUINRRK-TOKUTEI-KBN   =   "1"
             EVALUATE    LNK-PTNYUINRRK-TOKUTEI-NYUIN
               WHEN    "01"
                       MOVE   "190075810"   TO  SYOKIKSN-IN-KHNSRYCD
             END-EVALUATE
           END-IF
      *    病棟
           IF  LNK-PTNYUINRRK-TOKUTEI-KBN   =   "2"
             EVALUATE    LNK-PTNYUINRRK-TOKUTEI-NYUIN
               WHEN    "01"
                       MOVE   "190111110"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "02"
                       MOVE   "190111210"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "03"
                       MOVE   "190055210"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "04"
                       MOVE   "190055310"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "05"
                       MOVE   "190739910"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "06"
                       MOVE   "190740110"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "07"
                       MOVE   "190055010"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "08"
                       MOVE   "190055110"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "09"
                       MOVE   "190028910"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "10"
                       MOVE   "190111410"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "11"
                       MOVE   "190066910"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "12"
                       MOVE   "190067010"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "13"
                       MOVE   "190075910"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "14"
                       MOVE   "190075810"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "15"
                       MOVE   "190813410"   TO  SYOKIKSN-IN-KHNSRYCD
             END-EVALUATE
           END-IF
      *    病室
           IF  LNK-PTNYUINRRK-TOKUTEI-KBN   =   "3"
             EVALUATE    LNK-PTNYUINRRK-TOKUTEI-NYUIN
               WHEN    "01"
                       MOVE   "190075710"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "02"
                       MOVE   "190774110"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "03"
                       MOVE   "190024510"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "04"
                       MOVE   "190110210"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "05"
                       MOVE   "190110310"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "06"
                       MOVE   "190024310"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "07"
                       MOVE   "190110410"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "08"
                       MOVE   "190110510"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "09"
                       MOVE   "190024610"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "10"
                       MOVE   "190024710"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "11"
                       MOVE   "190066710"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "12"
                       MOVE   "190066810"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "13"
                       MOVE   "190024810"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "14"
                       MOVE   "190075510"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "15"
                       MOVE   "190788810"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "16"
                       MOVE   "190116310"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "17"
                       MOVE   "190117310"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "18"
                       MOVE   "190117410"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "20"
                       MOVE   "190076710"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "21"
                       MOVE   "190076810"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "22"
                       MOVE   "190799410"   TO  SYOKIKSN-IN-KHNSRYCD
               WHEN    "23"
                       MOVE   "190808910"   TO  SYOKIKSN-IN-KHNSRYCD
             END-EVALUATE
           END-IF
      *
           .
       4801-BTU-TOKTEI-NYUIN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院料一般コードから老人コードへの置き換え処理
      *****************************************************************
       4801-RJNCD-CHG-SEC   SECTION.
      *
      *    老人対象患者チェック
           MOVE    SYOKIKSN-IN-SANTEISTYMD
                                   TO  WRK-AGECHK-SRYYMD
           PERFORM 4801-RJN-TAISYO-CHK-SEC
           IF    ( FLG-RJN         =   1 )    AND
                 ( COMB-HKNNUM     NOT =   "971" )  AND
                 ( COMB-HKNNUM     NOT =   "973" )
               INITIALIZE              SRYCDCHG-REC
      *
               MOVE    SYOKIKSN-IN-KHNSRYCD
                                       TO   CHG-IPNSRYCD
               MOVE    SRYCDCHG-REC    TO   MCPDATA-REC
               MOVE    "tbl_srycdchg"  TO   MCP-TABLE
               MOVE    "key2"          TO   MCP-PATHNAME
               PERFORM 900-TBL-SELECT-SEC 
               IF    ( MCP-RC    =   ZERO )
                   MOVE    MCPDATA-REC
                                       TO   SRYCDCHG-REC
                   IF   CHG-RJNSRYCD   NOT =   SPACE
                        MOVE   CHG-RJNSRYCD
                                       TO  SYOKIKSN-IN-KHNSRYCD
                   END-IF
               END-IF
      *
               MOVE    "tbl_srycdchg"  TO   MCP-TABLE
               MOVE    "key2"          TO   MCP-PATHNAME
               PERFORM 910-DB-CLOSE-SEC
           END-IF
      *
           .
       4801-RJNCD-CHG-EXT.
           EXIT.
      *****************************************************************
      *    老人対象患者チェック
      *****************************************************************
       4801-RJN-TAISYO-CHK-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-RJN
      *
      *    入院患者の老人保険判定
           MOVE    ZERO                TO   FLG-HKNCOMBI
           INITIALIZE              HKNCOMBI-REC
      *
           MOVE    LNK-PTNYUINRRK-HOSPID   TO   COMB-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID
                                       TO   COMB-PTID
           IF      SODRNACCT-ORDERID(3:2) =   "07"  OR  "09"
               MOVE    WRK-TAIHI-HKN   TO   COMB-HKNCOMBINUM
           ELSE
               MOVE    LNK-PTNYUINRRK-HKNCOMBINUM
                                       TO   COMB-HKNCOMBINUM
           END-IF
           MOVE    HKNCOMBI-REC        TO   MCPDATA-REC
           MOVE    "tbl_hkncombi"      TO   MCP-TABLE
           MOVE    "key"               TO   MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC 
           IF    ( MCP-RC    =   ZERO )
               MOVE    MCPDATA-REC
                                       TO   HKNCOMBI-REC
           ELSE
               MOVE    1               TO   FLG-HKNCOMBI
           END-IF
      *
           MOVE    "tbl_hkncombi"      TO   MCP-TABLE
           MOVE    "key"               TO   MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           PERFORM  4801-PT-AGE-SEC
      *    入院患者の年齢計算
           INITIALIZE ORCSAGECHKAREA
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  AGECHK-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID
                                       TO  AGECHK-PTID
           MOVE    WRK-AGECHK-SRYYMD
                                       TO  AGECHK-SRYYMD
           MOVE    PTINF-BIRTHDAY
                                       TO  AGECHK-BIRTHDAY
           DISPLAY "AGECHK-SRYYMD" AGECHK-SRYYMD
           DISPLAY "AGECHK-BIRTHDAY" AGECHK-BIRTHDAY
           CALL    "ORCSAGECHK"        USING
                                           ORCSAGECHKAREA
           IF    ( AGECHK-RC       =   ZERO )
               CONTINUE
           ELSE
               INITIALIZE  ORCSAGECHKAREA
           END-IF
      *
      *    老人対象患者判定
           IF    ((FLG-HKNCOMBI     =   ZERO)    AND
                  (COMB-KOH1HKNNUM  =   "027"))      OR
                 ( AGECHK-NENREI   >=    75)         OR
                 ((AGECHK-NENREI   >=    70)     AND
                  (PTINF-BIRTHDAY  <=   "19320930")) OR
                  (AGECHK-ROUJIN    =    1)
               MOVE    1            TO  FLG-RJN
           END-IF
      *
      *    患者公費情報から老人保健の登録チェック
           INITIALIZE                    PTKOHINF-REC
           MOVE    LNK-PTNYUINRRK-HOSPID  TO   PTKOH-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID    TO   PTKOH-PTID
           MOVE    "027"            TO   PTKOH-KOHNUM
           MOVE    WRK-AGECHK-SRYYMD
                                    TO   PTKOH-TEKSTYMD
           MOVE    WRK-AGECHK-SRYYMD
                                    TO   PTKOH-TEKEDYMD
           MOVE    PTKOHINF-REC     TO   MCPDATA-REC
           MOVE    "tbl_ptkohinf"   TO   MCP-TABLE
           MOVE    "key6"           TO   MCP-PATHNAME
           PERFORM 900-TBL-SELECT-SEC 
           IF    ( MCP-RC    =   ZERO )
               MOVE    1            TO  FLG-RJN
           END-IF
           MOVE    "tbl_ptkohinf"   TO   MCP-TABLE
           MOVE    "key6"           TO   MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
           .
       4801-RJN-TAISYO-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ取得処理
      *****************************************************************
       490-HKNCOMBI-GET-SEC            SECTION.
      *
           INITIALIZE                  SPA-KYOTUKEY
                                       SPA-KYOTU-SET
                                       ORCSHKNSETAREA
      *
           MOVE    SPA-SYSYMD          TO  SPA-SRYYMD
           MOVE    "1"                 TO  SPA-NYUGAIKBN
           MOVE    LNK-PTNYUINRRK-PTID     TO  SPA-PTID
           MOVE    PTINF-BIRTHDAY
                                       TO  SPA-BIRTHDAY
           MOVE    "2"                 TO  ORCSHKN-KBN
      *
           CALL    "ORCSHKNSET"        USING   SPA-AREA
                                               ORCSHKNSETAREA
           IF    ( ORCSHKN-ERRCD   NOT =   ZERO )
               INITIALIZE              ORCSHKNSETAREA
               GO  TO  490-HKNCOMBI-GET-EXT
           END-IF
      *
           .
       490-HKNCOMBI-GET-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ編集処理
      *****************************************************************
       490-HKNCOMBI-EDIT-SEC           SECTION.
      *
           MOVE    SPACE                   TO  WRK-HKNCOMBI
           PERFORM VARYING IDX15   FROM 1  BY  1
                   UNTIL ( IDX15   >   ORCSHKN-HKN-MAX )
                     OR  ( IDX15   >   100 )
      *
               IF    ( ORCSHKN-GMN-HKNCOMBINUM (IDX15)
                                   =   WRK-ORCSHKN-HKNCOMBINUM )
                   MOVE    ORCSHKN-GMN-HKNCOMBIMEI (IDX15)
                                           TO  WRK-HKNCOMBI
                   MOVE    ORCSHKN-HKN-MAX TO  IDX15
               END-IF
      *
           END-PERFORM
      *
           .
       490-HKNCOMBI-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HENYMDG
                                           WRK-SYMD
      *
           IF    ( WRK-YMD         =   SPACE )
               GO  TO  5002-HIZUKE-CHK-EXT
           END-IF
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
               MOVE    "0001"          TO  WRK-ERRCD
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    期間算出処理
      *****************************************************************
       5002-KIKAN-CALC-SEC             SECTION.
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
           IF      ( STS-DAY-RC1   NOT =   ZERO )
               MOVE    1           TO  FLG-ORCSDAY
               GO  TO              5002-KIKAN-CALC-EXT
           END-IF
      *
           MOVE    LNK-DAY5-NISSU1     TO  WRK-NISSU1
           MOVE    LNK-DAY5-NISSU2     TO  WRK-NISSU2
      *
           .
       5002-KIKAN-CALC-EXT.
           EXIT.
      *****************************************************************
      *    カレンダー処理
      *****************************************************************
       5002-CALENDAR-SEC               SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
           MOVE    WRK-ZOGENPTN        TO  LNK-DAY6-ZOGENPTN
           MOVE    WRK-ZOGEN           TO  LNK-DAY6-ZOGEN
           CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN     TO  WRK-KEISANYMD
      *
           .
       5002-CALENDAR-EXT.
           EXIT.
      *****************************************************************
      *    転科／転棟／転室時　会計テーブル編集処理
      *****************************************************************
       4801-TENROOM-EDIT-SEC         SECTION.
      *
           MOVE      SPACE        TO    WRK-DOU-TENNYUYMD
           MOVE      SPACE        TO    IPN-NYUKAIKEI-SAKUSEI-FLG
      *
           INITIALIZE      ORCSSYOKIKSNAREA
      *
           MOVE    SPACE   TO   SPA-ERRCD
      *    通算日数、算定開始日を求める
           PERFORM 4801-TSUSAN-SANTEI-GET-SEC
           IF    ( SPA-ERRCD    NOT =  SPACE )
               GO  TO  4801-TENROOM-EDIT-EXT
           END-IF
      *
           MOVE    WRK-TSUSAN      TO  SYOKIKSN-IN-TUSANNISSU
           MOVE    WRK-SANTEISTYMD
                                   TO  SYOKIKSN-IN-SANTEISTYMD
      *
      *    特定集中治療室管理料算定時に特定入院での算定日が１４日を
      *    経過していた場合は一般の入院料算定とする
      *    以下の特定入院料も同様
      *    救命救急入院料
      *    一類感染症患者入院医療管理料
           IF   PTNYUINRRK-TOKUTEI-KBN   =   "3"
               IF   PTNYUINRRK-TOKUTEI-NYUIN   = "03" OR "04" OR "05" OR
                                                 "06" OR "07" OR "08" OR
                                                 "09" OR "14" OR "16"
                   IF   STUSAN-NISSU06   >=   14
                       MOVE    SPACE   TO   LNK-PTNYUINRRK-TOKUTEI-NYUIN
                   END-IF
               END-IF
           END-IF
      *
      *    広範囲熱傷特定集中治療室管理料算定時に特定入院での算定日が６０日を
      *    経過していた場合は一般の入院料算定とする
           IF   PTNYUINRRK-TOKUTEI-KBN   =   "3"
               IF   PTNYUINRRK-TOKUTEI-NYUIN   = "13"
                   IF   STUSAN-NISSU06   >=   60
                       MOVE    SPACE   TO   LNK-PTNYUINRRK-TOKUTEI-NYUIN
                   END-IF
               END-IF
           END-IF
      *
      *    ハイケアユニット入院医療管理料算定時に特定入院での算定日が２１日を
      *    経過していた場合は一般の入院料算定とする
           IF   PTNYUINRRK-TOKUTEI-KBN   =   "3"
               IF   PTNYUINRRK-TOKUTEI-NYUIN   = "17"
                   IF   STUSAN-NISSU06   >=   21
                       MOVE    SPACE   TO   LNK-PTNYUINRRK-TOKUTEI-NYUIN
                   END-IF
               END-IF
           END-IF
      *
      *    亜急性期入院医療管理料算定時に特定入院での算定日が９０日を
      *    経過していた場合は一般の入院料算定とする
           IF   PTNYUINRRK-TOKUTEI-KBN   =   "3"
               IF   PTNYUINRRK-TOKUTEI-NYUIN   = "18"
                   IF   STUSAN-NISSU06   >=   90
                       MOVE    SPACE   TO   LNK-PTNYUINRRK-TOKUTEI-NYUIN
                   END-IF
               END-IF
           END-IF
      *
           IF      LNK-PTNYUINRRK-TOKUTEI-NYUIN    NOT =   SPACE
               PERFORM   4801-TOKTEI-NYUIN-SET-SEC
           ELSE
               PERFORM   4801-BTUSEL-SEC
               IF  SYS-5001-BTU-KHNSRYCD      NOT =   SPACE
                   MOVE    SYS-5001-BTU-KHNSRYCD
                                       TO  SYOKIKSN-IN-KHNSRYCD
                   PERFORM   4801-RJNCD-CHG-SEC
                   CALL    "ORCSSYOKIKSN"  USING   ORCSSYOKIKSNAREA
                   IF    ( SYOKIKSN-OT-RC  NOT =   ZERO )
                       MOVE    "4021"      TO  SPA-ERRCD
                       GO  TO  4801-TENROOM-EDIT-EXT
                   END-IF
               ELSE
                   MOVE    "4022"      TO  SPA-ERRCD
                   GO  TO  4801-TENROOM-EDIT-EXT
               END-IF
           END-IF
      *
      *    入院会計作成前に会計データの食事区分を退避
      *    （異動月分）
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
           MOVE    LNK-PTNYUINRRK-TENNYUYMD(1:6)
                                       TO  NACCT-SRYYM
                                           WRK-TENROOM-SKJ-SRYYMX
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key28"             TO  MCP-PATHNAME
           PERFORM   900-TBL-SELECT-SEC
           IF      MCP-RC            =   ZERO
               MOVE     MCPDATA-REC    TO  NYUINACCT-REC
      *        食事を退避
               MOVE    NACCT-SRYYM     TO  WRK-TENROOM-SKJ-SRYYM(1)
               MOVE    LNK-PTNYUINRRK-TENNYUYMD(7:2)
                                       TO  IDX-SHOKUJIX
               PERFORM   VARYING   IDX-SKJ FROM  IDX-SHOKUJI9  BY  1
                         UNTIL     IDX-SKJ   >   31
                    MOVE   NACCT-DAY(IDX-SKJ)
                                       TO  WRK-TENROOM-SKJ(1 IDX-SKJ)
               END-PERFORM
           ELSE
               MOVE    LNK-PTNYUINRRK-TENNYUYMD(1:6)
                                       TO  WRK-TENROOM-SKJ-SRYYM(1)
               MOVE    LNK-PTNYUINRRK-TENNYUYMD(7:2)
                                       TO  IDX-SHOKUJIX
               PERFORM   VARYING   IDX-SKJ FROM  IDX-SHOKUJI9  BY  1
                         UNTIL     IDX-SKJ   >   31
                    MOVE   ZERO        TO  WRK-TENROOM-SKJ(1 IDX-SKJ)
               END-PERFORM
           END-IF
      *    入院会計マスタクローズ
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key28"             TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *    （異動翌月分）
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
           IF      WRK-TENROOM-SKJ-SRYMM9  =  12
               ADD   1     TO   WRK-TENROOM-SKJ-SRYYY9
               MOVE  1     TO   WRK-TENROOM-SKJ-SRYMM9
           ELSE
               ADD   1     TO   WRK-TENROOM-SKJ-SRYMM9
           END-IF
           MOVE    WRK-TENROOM-SKJ-SRYYMX
                                       TO  NACCT-SRYYM
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key28"             TO  MCP-PATHNAME
           PERFORM   900-TBL-SELECT-SEC
           IF      MCP-RC            =   ZERO
               MOVE     MCPDATA-REC    TO  NYUINACCT-REC
      *        食事を退避
               MOVE    NACCT-SRYYM     TO  WRK-TENROOM-SKJ-SRYYM(2)
               PERFORM   VARYING   IDX-SKJ FROM  1  BY  1
                         UNTIL     IDX-SKJ   >   31
                    MOVE   NACCT-DAY(IDX-SKJ)
                                       TO  WRK-TENROOM-SKJ(2 IDX-SKJ)
               END-PERFORM
           ELSE
               MOVE    SPACE           TO  WRK-TENROOM-SKJ-SRYYM(2)
           END-IF
      *    入院会計マスタクローズ
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key28"             TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
      *    入院会計作成サブの呼出し
           INITIALIZE                     ORCSNYUACCT-AREA
           MOVE    "8"                TO  LNK-SCNYUACCT-SYORI-KBN
           MOVE    "1"                TO  SPA-NYUGAIKBN
           MOVE    PTNYUINRRK-PTID    TO  SPA-PTID
           MOVE    PTNYUINRRK-NYUINKA TO  SPA-SRYKA
           MOVE    SYOKIKSN-IN-KHNSRYCD
                           TO  LNK-SCNYUACCT-NYUKHN-SRYCD(1)
           MOVE    SYOKIKSN-IN-SANTEISTYMD
                           TO   LNK-SCNYUACCT-STSRYYMD
           MOVE    LNK-PTNYUINRRK-TENNYUYMD
                           TO   LNK-SCNYUACCT-EDSRYYMD
           PERFORM   VARYING   IDX6   FROM   1   BY   1
               UNTIL (SYOKIKSN-OT-KGNSRYCD(IDX6)  =  SPACE) OR
                     (IDX6   >     7)
               MOVE   SYOKIKSN-OT-KGNSRYCD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-SRYCD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOSTYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-STYUKYMD(IDX6)
               MOVE   SYOKIKSN-OT-YUKOEDYMD(IDX6)
                         TO  LNK-SCNYUACCT-KAGEN-EDYUKYMD(IDX6)
           END-PERFORM
      *    通算算定済日数
           MOVE   WRK-TSUSAN    TO  LNK-SCNYUACCT-NYUKHN-NISUU
      *
      *    特定入院で入院料が変更になるコードの対応
      *    診療所老人医療管理料
           IF    SYOKIKSN-IN-KHNSRYCD   =   "190774110"
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                         LNK-SCNYUACCT-NYUKHN-SRYCD(1)
                 MOVE   ZERO            TO  TN-IDX
                 IF     STUSAN-NISSU01      <=  14
                     ADD    1           TO  TN-IDX
                     MOVE   "190774110" TO   LNK-SCNYUACCT-KAGEN-SRYCD
                                                               (TN-IDX)
      *              診療所老人医療管理料の１４日以内の終日を再計算
                     MOVE     ZERO      TO   WK-TOKUTEI-DAY
                     COMPUTE  WK-TOKUTEI-DAY  =  14  - STUSAN-NISSU01
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                       TO  LNK-SCNYUACCT-KAGEN-STYUKYMD
                                                               (TN-IDX)
                     INITIALIZE                STS-AREA-DAY
                     INITIALIZE                LNK-DAY6-AREA
                     MOVE    "61"              TO  LNK-DAY6-IRAI
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                               TO  LNK-DAY6-KIJUN
                     MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                     MOVE    WK-TOKUTEI-DAY    TO  LNK-DAY6-ZOGEN
                     CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN
                                        TO LNK-SCNYUACCT-KAGEN-EDYUKYMD
                                                               (TN-IDX)
                 END-IF
      *
                 ADD    1   TO    TN-IDX
      *
                 MOVE   "190774210"  TO  LNK-SCNYUACCT-KAGEN-SRYCD
                                                               (TN-IDX)
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 IF      TN-IDX      =     2
                     MOVE    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                                           TO  LNK-DAY6-KIJUN
                     MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                     MOVE     1                TO  LNK-DAY6-ZOGEN
                     CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN
                                       TO LNK-SCNYUACCT-KAGEN-STYUKYMD
                                                               (TN-IDX)
                 ELSE
                     MOVE    LNK-PTNYUINRRK-TENNYUYMD
                                       TO LNK-SCNYUACCT-KAGEN-STYUKYMD
                                                               (TN-IDX)
                 END-IF
                 MOVE    "99999999"    TO LNK-SCNYUACCT-KAGEN-EDYUKYMD
                                                               (TN-IDX)
           END-IF
      *
      *    老人性痴呆疾患治療病棟入院料
           IF    SYOKIKSN-IN-KHNSRYCD   =   "190739910"
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                         LNK-SCNYUACCT-NYUKHN-SRYCD(1)
                 MOVE   ZERO            TO  TN-IDX
                 IF     STUSAN-NISSU01      <=  90
                     ADD    1           TO  TN-IDX
                     MOVE   "190739910" TO   LNK-SCNYUACCT-KAGEN-SRYCD
                                                               (TN-IDX)
      *              老人性痴呆疾患治療病棟入院料の９０日以内の終日を再計算
                     MOVE     ZERO      TO   WK-TOKUTEI-DAY
                     COMPUTE  WK-TOKUTEI-DAY  =  90  - STUSAN-NISSU01
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                       TO  LNK-SCNYUACCT-KAGEN-STYUKYMD
                                                               (TN-IDX)
                     INITIALIZE                STS-AREA-DAY
                     INITIALIZE                LNK-DAY6-AREA
                     MOVE    "61"              TO  LNK-DAY6-IRAI
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                               TO  LNK-DAY6-KIJUN
                     MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                     MOVE    WK-TOKUTEI-DAY    TO  LNK-DAY6-ZOGEN
                     CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN
                                        TO LNK-SCNYUACCT-KAGEN-EDYUKYMD
                                                               (TN-IDX)
                 END-IF
      *
                 ADD    1   TO    TN-IDX
      *
                 MOVE   "190740010"  TO  LNK-SCNYUACCT-KAGEN-SRYCD
                                                               (TN-IDX)
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 IF      TN-IDX      =     2
                     MOVE    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                                           TO  LNK-DAY6-KIJUN
                     MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                     MOVE     1                TO  LNK-DAY6-ZOGEN
                     CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN
                                       TO LNK-SCNYUACCT-KAGEN-STYUKYMD
                                                               (TN-IDX)
                 ELSE
                     MOVE    LNK-PTNYUINRRK-TENNYUYMD
                                       TO LNK-SCNYUACCT-KAGEN-STYUKYMD
                                                               (TN-IDX)
                 END-IF
                 MOVE    "99999999"    TO LNK-SCNYUACCT-KAGEN-EDYUKYMD
                                                               (TN-IDX)
           END-IF
      *
      *    老人性痴呆疾患治療病棟入院料２
           IF    SYOKIKSN-IN-KHNSRYCD   =   "190813410"
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                         LNK-SCNYUACCT-NYUKHN-SRYCD(1)
                 MOVE   ZERO            TO  TN-IDX
                 IF     STUSAN-NISSU01      <=  90
                     ADD    1           TO  TN-IDX
                     MOVE   "190813410" TO   LNK-SCNYUACCT-KAGEN-SRYCD
                                                               (TN-IDX)
      *              老人性痴呆疾患治療病棟入院料の９０日以内の終日を再計算
                     MOVE     ZERO      TO   WK-TOKUTEI-DAY
                     COMPUTE  WK-TOKUTEI-DAY  =  90  - STUSAN-NISSU01
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                       TO  LNK-SCNYUACCT-KAGEN-STYUKYMD
                                                               (TN-IDX)
                     INITIALIZE                STS-AREA-DAY
                     INITIALIZE                LNK-DAY6-AREA
                     MOVE    "61"              TO  LNK-DAY6-IRAI
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                               TO  LNK-DAY6-KIJUN
                     MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                     MOVE    WK-TOKUTEI-DAY    TO  LNK-DAY6-ZOGEN
                     CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN
                                        TO LNK-SCNYUACCT-KAGEN-EDYUKYMD
                                                               (TN-IDX)
                 END-IF
      *
                 ADD    1   TO    TN-IDX
      *
                 MOVE   "190813510"  TO  LNK-SCNYUACCT-KAGEN-SRYCD
                                                               (TN-IDX)
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 IF      TN-IDX      =     2
                     MOVE    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                                           TO  LNK-DAY6-KIJUN
                     MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                     MOVE     1                TO  LNK-DAY6-ZOGEN
                     CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN
                                       TO LNK-SCNYUACCT-KAGEN-STYUKYMD
                                                               (TN-IDX)
                 ELSE
                     MOVE    LNK-PTNYUINRRK-TENNYUYMD
                                       TO LNK-SCNYUACCT-KAGEN-STYUKYMD
                                                               (TN-IDX)
                 END-IF
                 MOVE    "99999999"    TO LNK-SCNYUACCT-KAGEN-EDYUKYMD
                                                               (TN-IDX)
           END-IF
      *
      *    特定入院料で７日まで、１４日まで、それ以降は一般入院料を算定する
      *    場合の診療コードを取得
           PERFORM    4801-TOKUTEI-NYUIN-7-14-SEC
      *
           MOVE      ZERO               TO  TN-IDX
           IF    SYOKIKSN-IN-KHNSRYCD   =   WRK-TOKUTEI-SRYCD1
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                        LNK-SCNYUACCT-NYUKHN-SRYCD(1)
      *          特定集中治療室管理料の算定可能日数を計算
                 MOVE     ZERO      TO   WK-TOKUTEI-DAY
                                         WK-TOKUTEI-DAY2
                 COMPUTE  WK-TOKUTEI-DAY  =  14  - STUSAN-NISSU06
                 IF       STUSAN-NISSU07  <  7
                     ADD     1        TO     TN-IDX
                     COMPUTE  WK-TOKUTEI-DAY2 =  6   -  STUSAN-NISSU07
                     MOVE   WRK-TOKUTEI-SRYCD1  TO
                                    LNK-SCNYUACCT-KAGEN-SRYCD(TN-IDX)
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD   TO
                                  LNK-SCNYUACCT-KAGEN-STYUKYMD(TN-IDX)
                     INITIALIZE                STS-AREA-DAY
                     INITIALIZE                LNK-DAY6-AREA
                     MOVE    "61"              TO  LNK-DAY6-IRAI
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                               TO  LNK-DAY6-KIJUN
                     MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                     MOVE   WK-TOKUTEI-DAY2    TO  LNK-DAY6-ZOGEN
                     CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN   TO
                                  LNK-SCNYUACCT-KAGEN-EDYUKYMD(TN-IDX)
                 END-IF
      *
                 IF     WK-TOKUTEI-DAY   >=   1
                     ADD     1     TO   TN-IDX
                     MOVE   WRK-TOKUTEI-SRYCD2  TO 
                                    LNK-SCNYUACCT-KAGEN-SRYCD(TN-IDX)
                     INITIALIZE                STS-AREA-DAY
                     INITIALIZE                LNK-DAY6-AREA
                     MOVE    "61"              TO  LNK-DAY6-IRAI
                     IF    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1) NOT = SPACE
                         MOVE    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                                               TO  LNK-DAY6-KIJUN
                         MOVE    "1"           TO  LNK-DAY6-ZOGENPTN
                         MOVE     1            TO  LNK-DAY6-ZOGEN
                         CALL  "ORCSDAY"       USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                         MOVE    LNK-DAY6-KEISAN   TO
                                  LNK-SCNYUACCT-KAGEN-STYUKYMD(TN-IDX)
                     ELSE
                         MOVE  LNK-PTNYUINRRK-TENNYUYMD
                                                   TO  LNK-DAY6-KIJUN
                         MOVE  LNK-PTNYUINRRK-TENNYUYMD
                                                   TO
                                  LNK-SCNYUACCT-KAGEN-STYUKYMD(TN-IDX)
                     END-IF
                     MOVE    "99999999"        TO
                                  LNK-SCNYUACCT-KAGEN-EDYUKYMD(TN-IDX)
                 END-IF
      *          一般入院料の算定開始日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE   WK-TOKUTEI-DAY     TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO       IPN-SANTEISTYMD
      *          一般入院会計作成用のフラグ設定
                 MOVE    "1"      TO      IPN-NYUKAIKEI-SAKUSEI-FLG
           END-IF
      *
      *    広範囲熱傷特定集中治療室管理料
           IF    SYOKIKSN-IN-KHNSRYCD   =   "190024810"
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                        LNK-SCNYUACCT-NYUKHN-SRYCD(1)
      *          広範囲熱傷特定集中治療室管理料の算定可能日数を計算
                 MOVE     ZERO      TO   WK-TOKUTEI-DAY
                 COMPUTE  WK-TOKUTEI-DAY  =  60  - STUSAN-NISSU06
                 IF       STUSAN-NISSU07  <  60
                     MOVE   "190024810"  TO
                                    LNK-SCNYUACCT-KAGEN-SRYCD(1)
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD   TO
                                  LNK-SCNYUACCT-KAGEN-STYUKYMD(1)
                     INITIALIZE                STS-AREA-DAY
                     INITIALIZE                LNK-DAY6-AREA
                     MOVE    "61"              TO  LNK-DAY6-IRAI
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                               TO  LNK-DAY6-KIJUN
                     MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
      *               MOVE   WK-TOKUTEI-DAY     TO  LNK-DAY6-ZOGEN
                     COMPUTE  LNK-DAY6-ZOGEN = WK-TOKUTEI-DAY  -  1
                     CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN   TO
                                  LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                 END-IF
      *          一般入院料の算定開始日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE   WK-TOKUTEI-DAY     TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO       IPN-SANTEISTYMD
      *          特定入院期間（６０日経過）した際の一般入院料作成の
      *          可否を判定
                 MOVE    LNK-PTNYUINRRK-TENNYUYMD
                                  TO      WRK-IPN-HANTEI-YMD1
                 IF      WRK-IPN-HANTEI-M1   =   12
                     ADD    1     TO      WRK-IPN-HANTEI-Y1
                     MOVE   1     TO      WRK-IPN-HANTEI-M1
                 ELSE
                     ADD    1     TO      WRK-IPN-HANTEI-M1
                 END-IF
      *          月末日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY7-AREA
                 MOVE    "71"              TO  LNK-DAY7-IRAI
                 MOVE   WRK-IPN-HANTEI-YM1 TO  LNK-DAY7-YM
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY7-AREA
                 MOVE    LNK-DAY7-KOYOMI   TO      WRK-IPN-HANTEI-YMD1
                 MOVE    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                                  TO      WRK-IPN-HANTEI-YMD2
      *          一般入院会計作成用のフラグ設定
                 IF      WRK-IPN-HANTEI-YMD1 > WRK-IPN-HANTEI-YMD2
                     MOVE    "1"   TO     IPN-NYUKAIKEI-SAKUSEI-FLG
                 END-IF
           END-IF
      *
      *    ハイケアユニット入院医療管理料（２１日を限度）
           IF    SYOKIKSN-IN-KHNSRYCD   =   "190117310"
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                         LNK-SCNYUACCT-NYUKHN-SRYCD(1)
      *          ハイケアユニット入院医療管理料の算定可能日数を計算
                 MOVE     ZERO      TO   WK-TOKUTEI-DAY
                 COMPUTE  WK-TOKUTEI-DAY  =  21  - STUSAN-NISSU06
      *
                 IF     WK-TOKUTEI-DAY   >=   1
                     MOVE   "190117310"  TO 
                                    LNK-SCNYUACCT-KAGEN-SRYCD(1)
                     INITIALIZE                STS-AREA-DAY
                     INITIALIZE                LNK-DAY6-AREA
                     MOVE    "61"              TO  LNK-DAY6-IRAI
                     MOVE    LNK-PTNYUINRRK-TENNYUYMD  TO
                                 LNK-SCNYUACCT-KAGEN-STYUKYMD(1)
                                 LNK-DAY6-KIJUN
                     MOVE    "1"           TO  LNK-DAY6-ZOGENPTN
                     MOVE     WK-TOKUTEI-DAY
                                           TO  LNK-DAY6-ZOGEN
                     CALL  "ORCSDAY"       USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN   TO
                                  LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                 END-IF
      *          一般入院料の算定開始日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE   WK-TOKUTEI-DAY     TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO       IPN-SANTEISTYMD
      *          一般入院会計作成用のフラグ設定
                 MOVE    "1"      TO      IPN-NYUKAIKEI-SAKUSEI-FLG
           END-IF
      *
      *    亜急性期入院医療管理料（９０日を限度）
           IF    SYOKIKSN-IN-KHNSRYCD   =   "190117410"
                 MOVE   SPACE       TO   SYOKIKSN-IN-KHNSRYCD
                                        LNK-SCNYUACCT-NYUKHN-SRYCD(1)
      *          亜急性期入院医療管理料の算定可能日数を計算
                 MOVE     ZERO      TO   WK-TOKUTEI-DAY
                 COMPUTE  WK-TOKUTEI-DAY  =  90  - STUSAN-NISSU06
                 IF       STUSAN-NISSU07  <  90
                     MOVE   "190117410"  TO
                                    LNK-SCNYUACCT-KAGEN-SRYCD(1)
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD   TO
                                  LNK-SCNYUACCT-KAGEN-STYUKYMD(1)
                     INITIALIZE                STS-AREA-DAY
                     INITIALIZE                LNK-DAY6-AREA
                     MOVE    "61"              TO  LNK-DAY6-IRAI
                     MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                               TO  LNK-DAY6-KIJUN
                     MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
      *               MOVE   WK-TOKUTEI-DAY     TO  LNK-DAY6-ZOGEN
                     COMPUTE  LNK-DAY6-ZOGEN = WK-TOKUTEI-DAY  -  1
                     CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY6-AREA
                     MOVE    LNK-DAY6-KEISAN   TO
                                  LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                 END-IF
      *          一般入院料の算定開始日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY6-AREA
                 MOVE    "61"              TO  LNK-DAY6-IRAI
                 MOVE   LNK-PTNYUINRRK-TENNYUYMD
                                           TO  LNK-DAY6-KIJUN
                 MOVE    "1"               TO  LNK-DAY6-ZOGENPTN
                 MOVE   WK-TOKUTEI-DAY     TO  LNK-DAY6-ZOGEN
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
                 MOVE    LNK-DAY6-KEISAN
                                  TO       IPN-SANTEISTYMD
      *          特定入院期間（６０日経過）した際の一般入院料作成の
      *          可否を判定
                 MOVE    LNK-PTNYUINRRK-TENNYUYMD
                                  TO      WRK-IPN-HANTEI-YMD1
                 IF      WRK-IPN-HANTEI-M1   =   12
                     ADD    1     TO      WRK-IPN-HANTEI-Y1
                     MOVE   1     TO      WRK-IPN-HANTEI-M1
                 ELSE
                     ADD    1     TO      WRK-IPN-HANTEI-M1
                 END-IF
      *          月末日を算定
                 INITIALIZE                STS-AREA-DAY
                 INITIALIZE                LNK-DAY7-AREA
                 MOVE    "71"              TO  LNK-DAY7-IRAI
                 MOVE   WRK-IPN-HANTEI-YM1 TO  LNK-DAY7-YM
                 CALL  "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY7-AREA
                 MOVE    LNK-DAY7-KOYOMI   TO      WRK-IPN-HANTEI-YMD1
                 MOVE    LNK-SCNYUACCT-KAGEN-EDYUKYMD(1)
                                  TO      WRK-IPN-HANTEI-YMD2
      *          一般入院会計作成用のフラグ設定
                 IF      WRK-IPN-HANTEI-YMD1 > WRK-IPN-HANTEI-YMD2
                     MOVE    "1"   TO     IPN-NYUKAIKEI-SAKUSEI-FLG
                 END-IF
           END-IF
      *-------特定入院対応ここまで-----------------------------------
      *
      *    入院料加算診療コード取り込み
           PERFORM    4801-NYUKSN-GET-SEC
      *
      *    特定入院料区分のセット
           IF      LNK-PTNYUINRRK-TOKUTEI-NYUIN    =   SPACE
               MOVE     "0"     TO  LNK-SCNYUACCT-TOKUTEINYUIN-KBN
           ELSE
               MOVE     "1"     TO  LNK-SCNYUACCT-TOKUTEINYUIN-KBN
           END-IF
      *    外泊
           MOVE   "099999911"   TO  LNK-SCNYUACCT-GAIHAKU-SRYCD
      *    室料差額
           MOVE   "099999912"   TO  LNK-SCNYUACCT-SAGAKU-SRYCD
           IF     LNK-PTNYUINRRK-RM-SAGAKU   =   SPACE
               MOVE    ZERO     TO  LNK-SCNYUACCT-SAGAKU-KBN
           ELSE
               MOVE   LNK-PTNYUINRRK-RM-SAGAKU 
                                TO  WRK-SAGAKU-KBN
               MOVE   WRK-SAGAKU-KBN9
                                TO  LNK-SCNYUACCT-SAGAKU-KBN
           END-IF
      *    食事区分
           MOVE   "099999913"   TO  LNK-SCNYUACCT-SHOKUJI-SRYCD
           IF     WRK-TAIHI-SHOKUJI    NOT =   ZERO
                  MOVE   WRK-TAIHI-SHOKUJI
                                TO  LNK-SCNYUACCT-SHOKUJIKBN
           ELSE
                  MOVE   0      TO  LNK-SCNYUACCT-SHOKUJIKBN
           END-IF
      *    食堂加算
           PERFORM     4801-BTUSEL-SEC
           IF   FLG-SYSKANRI           =    ZERO
               IF   SYS-5001-BTU-SYOKUDOKBN       =    "2"
                    MOVE     "197000570"    TO
                                LNK-SCNYUACCT-SHOKUDO-SRYCD
                    MOVE    0   TO   LNK-SCNYUACCT-SHOKUDO-KBN
               END-IF
           END-IF
      *    保険組合せ
           MOVE   "099999914"   TO  LNK-SCNYUACCT-HKNCOMBINUM-SRYCD
           MOVE   LNK-PTNYUINRRK-HKNCOMBINUM
                                TO  WRK-HKNCOMBINUM
           MOVE   WRK-HKNCOMBINUM9 
                                TO  LNK-SCNYUACCT-HKNCOMBINUM
      *    転科元入院科
           MOVE   "00"          TO  LNK-SCNYUACCT-MOTO-NYUINKA
      **     MOVE   SPA-GMN-I01-NYUINKA-MOT (1 : 2)
      **                          TO  LNK-SCNYUACCT-MOTO-NYUINKA
           MOVE   SPA-SRYKA     TO  WRK-TAIHI-SRYKA
           MOVE   "00"          TO  SPA-SRYKA
           PERFORM 4801-SENTEI-SET-SEC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  SPA-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  SPA-PTID
           CALL   "ORCSNYUACCT"  USING   SPA-AREA
                                         ORCSNYUACCT-AREA
           MOVE   WRK-TAIHI-SRYKA TO     SPA-SRYKA
           IF     LNK-SCNYUACCT-RC   NOT =  ZERO
               DISPLAY  "ORCGI01 ORCSNYUACCT ERR RC = "
                         LNK-SCNYUACCT-RC
           END-IF
      *
           IF     IPN-NYUKAIKEI-SAKUSEI-FLG    =   "1"
               MOVE    SPACE   TO   LNK-PTNYUINRRK-TOKUTEI-NYUIN
               MOVE    IPN-SANTEISTYMD   TO   WRK-SANTEISTYMD
               MOVE    IPN-SANTEISTYMD   TO   LNK-PTNYUINRRK-TENNYUYMD
               MOVE    IPN-SANTEISTYMD   TO   PTNYUINRRK-TENNYUYMD
           END-IF
      *
      *    入院会計作成後に退避データの食事区分を復元
      *    （異動月分）
           INITIALIZE                      NYUINACCT-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
           MOVE    WRK-TENROOM-SKJ-SRYYM(1)
                                       TO  NACCT-SRYYM
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key28"             TO  MCP-PATHNAME
           PERFORM   900-TBL-SELECT-SEC
           IF      MCP-RC            =   ZERO
               MOVE     MCPDATA-REC    TO  NYUINACCT-REC
      *        食事を復元
               MOVE    LNK-PTNYUINRRK-TENNYUYMD(7:2)
                                       TO  IDX-SHOKUJIX
               PERFORM   VARYING   IDX-SKJ FROM  IDX-SHOKUJI9  BY  1
                         UNTIL     IDX-SKJ   >   31
                    MOVE   WRK-TENROOM-SKJ(1 IDX-SKJ)
                                       TO  NACCT-DAY(IDX-SKJ)
               END-PERFORM
      *        剤回数再セット
               MOVE  ZERO              TO  NACCT-ZAIKAISU
               PERFORM  VARYING   IDX-SKJ FROM  1  BY  1
                         UNTIL     IDX-SKJ   >   31
                   IF   NACCT-DAY(IDX-SKJ)   NOT =  0
                       ADD   1        TO  NACCT-ZAIKAISU
                   END-IF
               END-PERFORM   
           END-IF
           MOVE     NYUINACCT-REC      TO  MCPDATA-REC
           MOVE     "DBUPDATE"         TO  MCP-FUNC
           MOVE     "tbl_nyuinacct"    TO  MCP-TABLE
           MOVE     "key"              TO  MCP-PATHNAME
           CALL     "MONFUNC"          USING  MCPAREA
                                              MCPDATA-REC 
      *    入院会計マスタクローズ
           MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
           MOVE    "key28"             TO  MCP-PATHNAME
           PERFORM 910-DB-CLOSE-SEC
      *
      *    （異動翌月分）
           IF   WRK-TENROOM-SKJ-SRYYM(2)  NOT =   SPACE
               INITIALIZE                      NYUINACCT-REC
               MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
               MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
               MOVE    WRK-TENROOM-SKJ-SRYYM(2)
                                           TO  NACCT-SRYYM
      *
               MOVE    NYUINACCT-REC       TO  MCPDATA-REC
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key28"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-SELECT-SEC
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key28"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               IF      FLG-NYUINACCT       =   ZERO
                   MOVE     MCPDATA-REC    TO  NYUINACCT-REC
      *            食事を復元
                   PERFORM   VARYING   IDX-SKJ FROM  1  BY  1
                             UNTIL     IDX-SKJ   >   31
                        MOVE   WRK-TENROOM-SKJ(2 IDX-SKJ)
                                           TO  NACCT-DAY(IDX-SKJ)
                   END-PERFORM
      *            剤回数再セット
                   MOVE  ZERO              TO  NACCT-ZAIKAISU
                   PERFORM  VARYING   IDX-SKJ FROM  1  BY  1
                            UNTIL     IDX-SKJ   >   31
                       IF   NACCT-DAY(IDX-SKJ)   NOT =  0
                           ADD   1        TO  NACCT-ZAIKAISU
                       END-IF
                   END-PERFORM   
               END-IF
               MOVE     NYUINACCT-REC      TO  MCPDATA-REC
               MOVE     "DBUPDATE"         TO  MCP-FUNC
               MOVE     "tbl_nyuinacct"    TO  MCP-TABLE
               MOVE     "key"              TO  MCP-PATHNAME
               CALL     "MONFUNC"          USING  MCPAREA
                                                  MCPDATA-REC 
      *        入院会計マスタクローズ
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key28"             TO  MCP-PATHNAME
               PERFORM 910-DB-CLOSE-SEC
           END-IF
      *
           .
       4801-TENROOM-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院取消　会計テーブル編集処理
      *****************************************************************
       4801-NYUKAIKEI-ERASE-SEC         SECTION.
      *
           DISPLAY "4801-NYUKAIKEI-ERASE-SEC"
           DISPLAY "PTNYUINRRK-PTID      = " LNK-PTNYUINRRK-PTID
           DISPLAY "PTNYUINRRK-NYUINYMD  = " LNK-PTNYUINRRK-NYUINYMD
           DISPLAY "PTNYUINRRK-TAIINYMD  = " LNK-PTNYUINRRK-TAIINYMD
           DISPLAY "PTNYUINRRK-HKNCOMBINUM  = "
                                         LNK-PTNYUINRRK-HKNCOMBINUM
      *    入院会計作成サブの呼出し
           INITIALIZE            ORCSNYUACCT-AREA
           EVALUATE   SODRNACCT-ORDERID
               WHEN   "0107"
                      MOVE   "5"       TO   LNK-SCNYUACCT-SYORI-KBN
               WHEN   "0108"
                      MOVE   "6"       TO   LNK-SCNYUACCT-SYORI-KBN
           END-EVALUATE
           DISPLAY  "LNK-SCNYUACCT-SYORI-KBN = " 
                     LNK-SCNYUACCT-SYORI-KBN
           MOVE     LNK-PTNYUINRRK-HOSPID  TO  SPA-HOSPID
           MOVE     "1"                    TO  SPA-NYUGAIKBN
           MOVE     LNK-PTNYUINRRK-PTID    TO  SPA-PTID
           MOVE     LNK-PTNYUINRRK-NYUINYMD
                                       TO   LNK-SCNYUACCT-STSRYYMD
      *    保険組合せ
           MOVE   LNK-PTNYUINRRK-HKNCOMBINUM
                                        TO  WRK-HKNCOMBINUM
           MOVE   WRK-HKNCOMBINUM9      TO  LNK-SCNYUACCT-HKNCOMBINUM
           MOVE   SPA-SRYKA     TO  WRK-TAIHI-SRYKA
           MOVE   "00"          TO  SPA-SRYKA
           CALL   "ORCSNYUACCT"  USING   SPA-AREA
                                         ORCSNYUACCT-AREA
           MOVE   WRK-TAIHI-SRYKA TO     SPA-SRYKA
           IF     LNK-SCNYUACCT-RC   NOT =  ZERO
                  DISPLAY  "ORCSNYUACCT ERR RC = "
                            LNK-SCNYUACCT-RC
           END-IF
      *
           .
       4801-NYUKAIKEI-ERASE-EXT.
           EXIT.
      *
      *****************************************************************
      *    退院　会計テーブル編集処理
      *****************************************************************
       4801-TAIINKAIKEI-EDIT-SEC         SECTION.
      *
      *    入院会計作成サブの呼出し
           INITIALIZE            ORCSNYUACCT-AREA
           MOVE     "2"     TO   LNK-SCNYUACCT-SYORI-KBN
           MOVE     "1"                TO  SPA-NYUGAIKBN
           MOVE     LNK-PTNYUINRRK-HOSPID  TO  SPA-HOSPID
           MOVE     LNK-PTNYUINRRK-PTID    TO  SPA-PTID
           MOVE     LNK-PTNYUINRRK-NYUINKA TO  SPA-SRYKA
           MOVE     LNK-PTNYUINRRK-TAIINYMD
                                       TO   LNK-SCNYUACCT-EDSRYYMD
      *    保険組合せ
           MOVE   LNK-PTNYUINRRK-HKNCOMBINUM
                                       TO  WRK-HKNCOMBINUM
           MOVE   WRK-HKNCOMBINUM9     TO  LNK-SCNYUACCT-HKNCOMBINUM
      *     MOVE   SPA-SRYKA           TO  WRK-TAIHI-SRYKA
           MOVE   "00"                 TO  SPA-SRYKA
           CALL   "ORCSNYUACCT"  USING   SPA-AREA
                                         ORCSNYUACCT-AREA
      *     MOVE   WRK-TAIHI-SRYKA TO     SPA-SRYKA
           IF     LNK-SCNYUACCT-RC   NOT =  ZERO
                  DISPLAY  "ORCGI01 ORCSNYUACCT ERR RC = "
                            LNK-SCNYUACCT-RC
           END-IF
      *
           .
       4801-TAIINKAIKEI-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    外泊　会計テーブル編集処理
      *****************************************************************
       4801-GAIHAKU-SEC         SECTION.
      *
      *    外泊のセット
           IF      LNK-PTNYUINRRK-TAIINYMD =   "99999999"
               PERFORM    4801-GAIHAKU-1-SEC
           ELSE
               PERFORM    4801-GAIHAKU-2-SEC
           END-IF
      *
           .
       4801-GAIHAKU-EXT.
           EXIT.
      *****************************************************************
      *    外泊　会計テーブル編集処理（入院中）
      *****************************************************************
       4801-GAIHAKU-1-SEC         SECTION.
      *
      *    入院中患者の外泊データ更新なので、入院会計が存在する会計データに
      *    ついて全て更新を行う
      *
      *    外泊のセット
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
           MOVE    SODRNACCT-STARTYMD(1:6) TO  NACCT-SRYYM
           MOVE    "2"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               MOVE    SODRNACCT-STARTYMD  TO  WRK-STARTYMD
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
      *            開始日のセット
                   IF      NACCT-SRYYM    =   SODRNACCT-STARTYMD(1:6)
                       MOVE   WRK-STARTYMD-D   TO   START-IDX
                   ELSE
                       MOVE   1                TO   START-IDX
                   END-IF
      *            月末日を算定
                   INITIALIZE                STS-AREA-DAY
                   INITIALIZE                LNK-DAY7-AREA
                   MOVE    "71"              TO  LNK-DAY7-IRAI
                   MOVE   NACCT-SRYYM        TO  LNK-DAY7-YM
                   CALL  "ORCSDAY"           USING STS-AREA-DAY
                                                   LNK-DAY7-AREA
                   MOVE   LNK-DAY7-KOYOMI    TO    WRK-GETSUMATSU-YMD
      *            外泊区分のセット
                   PERFORM  VARYING IDX  FROM  START-IDX   BY 1
                                UNTIL   IDX  >    WRK-GETSUMATSU-D
                       EVALUATE   SODRNACCT-ORDERID(3:2)
                           WHEN   "01"
                             MOVE   1    TO   NACCT-DAY(IDX)
                           WHEN   "02"
                             MOVE   2    TO   NACCT-DAY(IDX)
                           WHEN   "03"
                             MOVE   3    TO   NACCT-DAY(IDX)
                           WHEN   "04"
                             MOVE   4    TO   NACCT-DAY(IDX)
                           WHEN   "05"
                             MOVE   0    TO   NACCT-DAY(IDX)
                       END-EVALUATE
                   END-PERFORM
                   MOVE    NYUINACCT-REC   TO   MCPDATA-REC
                   MOVE    "DBUPDATE"      TO   MCP-FUNC
                   MOVE    "tbl_nyuinacct" TO   MCP-TABLE
                   MOVE    "key"           TO   MCP-PATHNAME
                   CALL    "MONFUNC"       USING    MCPAREA
                                                    MCPDATA-REC
      *            入院会計クローズ
                   MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
                   MOVE    "key17"             TO  MCP-PATHNAME
                   PERFORM   910-DB-CLOSE-SEC
      *            次月の会計読み込み
                   MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
                   MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
                   IF      WRK-STARTYMD-M  =   12
                      ADD     1      TO    WRK-STARTYMD-Y
                      MOVE    1      TO    WRK-STARTYMD-M
                   ELSE
                      ADD     1      TO    WRK-STARTYMD-M
                   END-IF
                   MOVE    "2"                     TO  NACCT-ZAISKBKBN
                   MOVE    WRK-STARTYMD-YM         TO  NACCT-SRYYM
                   MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                   MOVE    "key17"                 TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-SELECT-SEC
                   IF      FLG-NYUINACCT    =   ZERO
                       MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                       MOVE    "key17"                 TO  MCP-PATHNAME
                       PERFORM 910-NYUINACCT-READ-SEC
                   END-IF
               END-PERFORM
           END-IF
      *    入院会計クローズ
           MOVE     "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE     "key17"                 TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       4801-GAIHAKU-1-EXT.
           EXIT.
      *****************************************************************
      *    外泊　会計テーブル編集処理（退院済）
      *****************************************************************
       4801-GAIHAKU-2-SEC         SECTION.
      *
      *    退院済患者の外泊データ更新なので、退院日までの会計データについて
      *    更新を行う
      *
      *    外泊のセット
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
           MOVE    SODRNACCT-STARTYMD(1:6) TO  NACCT-SRYYM
           MOVE    "2"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
               MOVE    "key17"             TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               MOVE    SODRNACCT-STARTYMD  TO  WRK-STARTYMD
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)  OR
                      (NACCT-SRYYM    > LNK-PTNYUINRRK-TAIINYMD(1:6))
      *            開始日のセット
                   IF      NACCT-SRYYM      =  SODRNACCT-STARTYMD(1:6)
                       MOVE   WRK-STARTYMD-D   TO   START-IDX
                   ELSE
                       MOVE   1                TO   START-IDX
                   END-IF
      *            月末日を算定
                   INITIALIZE                STS-AREA-DAY
                   INITIALIZE                LNK-DAY7-AREA
                   MOVE    "71"              TO  LNK-DAY7-IRAI
                   MOVE   NACCT-SRYYM        TO  LNK-DAY7-YM
                   CALL  "ORCSDAY"           USING STS-AREA-DAY
                                                   LNK-DAY7-AREA
                   MOVE   LNK-DAY7-KOYOMI    TO    WRK-GETSUMATSU-YMD
      *            退院月については退院日をセット
                   IF   NACCT-SRYYM    =  LNK-PTNYUINRRK-TAIINYMD(1:6)
                       MOVE    LNK-PTNYUINRRK-TAIINYMD
                                             TO    WRK-GETSUMATSU-YMD
                   END-IF
      *            外泊区分のセット
                   PERFORM  VARYING IDX  FROM  START-IDX   BY 1
                                UNTIL   IDX  >    WRK-GETSUMATSU-D
                       EVALUATE   SODRNACCT-ORDERID(3:2)
                           WHEN   "01"
                             MOVE   1    TO   NACCT-DAY(IDX)
                           WHEN   "02"
                             MOVE   2    TO   NACCT-DAY(IDX)
                           WHEN   "03"
                             MOVE   3    TO   NACCT-DAY(IDX)
                           WHEN   "04"
                             MOVE   4    TO   NACCT-DAY(IDX)
                           WHEN   "05"
                             MOVE   0    TO   NACCT-DAY(IDX)
                       END-EVALUATE
                   END-PERFORM
                   MOVE    NYUINACCT-REC   TO   MCPDATA-REC
                   MOVE    "DBUPDATE"      TO   MCP-FUNC
                   MOVE    "tbl_nyuinacct" TO  MCP-TABLE
                   MOVE    "key"           TO  MCP-PATHNAME
                   CALL    "MONFUNC"       USING    MCPAREA
                                                    MCPDATA-REC
      *            入院会計クローズ
                   MOVE     "tbl_nyuinacct"         TO  MCP-TABLE
                   MOVE     "key17"                 TO  MCP-PATHNAME
                   PERFORM   910-DB-CLOSE-SEC
      *            次月の会計読み込み
                   MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
                   MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
                   IF      WRK-STARTYMD-M  =   12
                      ADD     1      TO    WRK-STARTYMD-Y
                      MOVE    1      TO    WRK-STARTYMD-M
                   ELSE
                      ADD     1      TO    WRK-STARTYMD-M
                   END-IF
                   MOVE    "2"                     TO  NACCT-ZAISKBKBN
                   MOVE    WRK-STARTYMD-YM         TO  NACCT-SRYYM
                   MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                   MOVE    "key17"                 TO  MCP-PATHNAME
                   PERFORM 910-NYUINACCT-SELECT-SEC
                   IF      FLG-NYUINACCT    =   ZERO
                       MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
                       MOVE    "key17"                 TO  MCP-PATHNAME
                       PERFORM 910-NYUINACCT-READ-SEC
                   END-IF
               END-PERFORM
           END-IF
      *    入院会計クローズ
           MOVE     "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE     "key17"                 TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
           .
       4801-GAIHAKU-2-EXT.
           EXIT.
      *****************************************************************
      *    食事　会計テーブル編集処理
      *****************************************************************
       4801-SHOKUJI-SEC         SECTION.
      *
      *    食事のセット
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
           MOVE    SODRNACCT-STARTYMD(1:6) TO  NACCT-SRYYM
           MOVE    "4"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key28"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE     "tbl_nyuinacct"    TO  MCP-TABLE
               MOVE     "key28"            TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               IF        FLG-NYUINACCT     =   ZERO
                 IF   NACCT-SRYCDTOTAL  =  99999913
      *            食事区分のセット
                   MOVE    SODRNACCT-STARTYMD      TO  WRK-STARTYMD
                   IF   SODRNACCT-SKJTIME   =  "01"
                     EVALUATE   SODRNACCT-ORDERID(3:2)
                       WHEN   "01"
                           MOVE  1  TO   NACCT-DAY(WRK-STARTYMD-D)
                       WHEN   "02"
                           MOVE  2  TO   NACCT-DAY(WRK-STARTYMD-D)
                       WHEN   "03"
                           MOVE  3  TO   NACCT-DAY(WRK-STARTYMD-D)
                       WHEN   "04"
                           MOVE   4     TO   NACCT-DAY(WRK-STARTYMD-D)
                       WHEN   "05"
                           MOVE  0  TO   NACCT-DAY(WRK-STARTYMD-D)
                     END-EVALUATE
                   ELSE
                     EVALUATE   SODRNACCT-ORDERID(3:2)
                       WHEN   "01"
                           IF     NACCT-DAY(WRK-STARTYMD-D)  =  0
                               MOVE  1  TO   NACCT-DAY(WRK-STARTYMD-D)
                           END-IF
                       WHEN   "02"
                           IF     NACCT-DAY(WRK-STARTYMD-D) =  0    OR
                                                               1    OR
                                                               3
                               MOVE  2  TO   NACCT-DAY(WRK-STARTYMD-D)
                           END-IF
                       WHEN   "03"
                           IF     NACCT-DAY(WRK-STARTYMD-D) =  0  OR 1
                               MOVE  3  TO   NACCT-DAY(WRK-STARTYMD-D)
                           END-IF
                       WHEN   "04"
                           MOVE   4     TO   NACCT-DAY(WRK-STARTYMD-D)
                     END-EVALUATE
                   END-IF
      *            剤回数再セット
                   MOVE  ZERO           TO  NACCT-ZAIKAISU
                   PERFORM  VARYING   IDX-SKJ FROM  1  BY  1
                            UNTIL     IDX-SKJ   >   31
                       IF   NACCT-DAY(IDX-SKJ)   NOT =  0
                           ADD   1        TO  NACCT-ZAIKAISU
                       END-IF
                   END-PERFORM   
      *            食堂加算の編集用に退避
                   MOVE    NACCT-DAY(WRK-STARTYMD-D)  TO WRK-SHOKUDOU
      *
                   MOVE    NYUINACCT-REC   TO   MCPDATA-REC
                   MOVE    "DBUPDATE"      TO   MCP-FUNC
                   MOVE    "tbl_nyuinacct" TO   MCP-TABLE
                   MOVE    "key"           TO   MCP-PATHNAME
                   CALL    "MONFUNC"       USING    MCPAREA
                                                    MCPDATA-REC
      *
                 END-IF
               END-IF
           END-IF
      *    入院会計クローズ
           MOVE     "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE     "key28"                 TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *
      *-------------------食堂加算ここから----------------------------
      *    食事のセット
           INITIALIZE                          NYUINACCT-REC
           MOVE    LNK-PTNYUINRRK-HOSPID   TO  NACCT-HOSPID
           MOVE    LNK-PTNYUINRRK-PTID     TO  NACCT-PTID
           MOVE    SODRNACCT-STARTYMD(1:6) TO  NACCT-SRYYM
           MOVE    "4"                     TO  NACCT-ZAISKBKBN
           MOVE    "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE    "key17"                 TO  MCP-PATHNAME
           PERFORM 910-NYUINACCT-SELECT-SEC
           IF      FLG-NYUINACCT           =   ZERO
               MOVE     "tbl_nyuinacct"    TO  MCP-TABLE
               MOVE     "key17"            TO  MCP-PATHNAME
               PERFORM   910-NYUINACCT-READ-SEC
               PERFORM   UNTIL   (FLG-NYUINACCT    =   1)
                 IF   NACCT-SRYCDTOTAL  =  197000570
      *            食堂加算のセット
                   MOVE    SODRNACCT-STARTYMD      TO  WRK-STARTYMD
                   IF    WRK-SHOKUDOU    NOT =  ZERO
                         MOVE   1   TO   NACCT-DAY(WRK-STARTYMD-D)
                   ELSE
                         MOVE   0   TO   NACCT-DAY(WRK-STARTYMD-D)
                   END-IF
      *            剤回数再セット
                   MOVE  ZERO           TO  NACCT-ZAIKAISU
                   PERFORM  VARYING   IDX-SKJ FROM  1  BY  1
                            UNTIL     IDX-SKJ   >   31
                       IF   NACCT-DAY(IDX-SKJ)   NOT =  0
                           ADD   1        TO  NACCT-ZAIKAISU
                       END-IF
                   END-PERFORM   
      *
                   MOVE    NYUINACCT-REC   TO   MCPDATA-REC
                   MOVE    "DBUPDATE"      TO   MCP-FUNC
                   MOVE    "tbl_nyuinacct" TO   MCP-TABLE
                   MOVE    "key"           TO   MCP-PATHNAME
                   CALL    "MONFUNC"           USING    MCPAREA
                                                        MCPDATA-REC
      *
                 END-IF
                 MOVE    "tbl_nyuinacct"     TO  MCP-TABLE
                 MOVE    "key17"             TO  MCP-PATHNAME
                 PERFORM 910-NYUINACCT-READ-SEC
               END-PERFORM
           END-IF
      *    入院会計クローズ
           MOVE     "tbl_nyuinacct"         TO  MCP-TABLE
           MOVE     "key17"                 TO  MCP-PATHNAME
           PERFORM   910-DB-CLOSE-SEC
      *-------------------食堂加算ここまで----------------------------
           .
       4801-SHOKUJI-EXT.
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
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC              SECTION.
      *
           PERFORM 910-DB-SELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DB-READ-SEC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DB-SELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
      *
           .
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DB-READ-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DB-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター検索
      *****************************************************************
       910-NYUINACCT-SELECT-SEC        SECTION.
      *
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       910-NYUINACCT-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  NYUINACCT-REC
               MOVE    ZERO               TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                     NYUINACCT-REC
               MOVE    1                  TO  FLG-NYUINACCT
           END-IF
      *
           .
       910-NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DB-CLOSE-SEC                SECTION.
      *
           MOVE    "DBCLOSECURSOR"      TO  MCP-FUNC
           CALL    "MONFUNC"            USING
                                        MCPAREA
                                        MCPDATA-REC
      *
           .
       910-DB-CLOSE-EXT.
           EXIT.
