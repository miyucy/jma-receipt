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
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCGI20.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院患者検索
      *  コンポーネント名  : 入院患者検索（Ｉ２０）
      *  管理者            : 
      *  02/09/10    NACL−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    02/12/05  診療科９９件対応等
      *  01.00.02    NACL-太田    02/01/14  COPY句の重複定義を修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    病名登録用共通パラメタ
           COPY    "I2COMMON-SPA".
      *
           COPY    "ENUM-VALUE".     
      *
      *    入院患者検索画面ＳＰＡ
       01  SPA-I20-AREA.
           03  SPA-GMN-MAX         PIC 9(04).
           03  SPA-GMN-PAGE        PIC 9(02).
           03  SPA-GMN-CUR         PIC 9(02).
           03  SPA-GMN-AREA.
               05  SPA-GMN-STAGELST        OCCURS  14.
                   07  SPA-GMN-STAGEL      PIC X(02).
                   07  SPA-GMN-F2L         PIC X(01).
                   07  SPA-GMN-STAGEMEIL   PIC X(10).
               05  SPA-GMN-STAGE-MAX       PIC 9(02).    
               05  SPA-GMN-EDAGELST        OCCURS  14.
                   07  SPA-GMN-EDAGEL      PIC X(02).
                   07  SPA-GMN-F2L         PIC X(01).
                   07  SPA-GMN-EDAGEMEIL   PIC X(10).
               05  SPA-GMN-EDAGE-MAX       PIC 9(02).    
               05  SPA-GMN-SRYKALST        OCCURS  99.
                   07  SPA-GMN-SRYKAL      PIC X(02).
                   07  SPA-GMN-F2L         PIC X(01).
                   07  SPA-GMN-SRYKAMEIL   PIC X(20).
               05  SPA-GMN-SRYKA-MAX       PIC 9(02). 
               05  SPA-GMN-BTUNUMLST       OCCURS  50.
                   07  SPA-GMN-BTUNUML     PIC X(02).
                   07  SPA-GMN-F3L         PIC X(01).
                   07  SPA-GMN-BTUNUMMEIL  PIC X(20).
               05  SPA-GMN-BTUNUM-MAX      PIC 9(02). 
               05  SPA-GMN-JOTAILST        OCCURS  5.
                   07  SPA-GMN-JOTAIL      PIC X(01).
                   07  SPA-GMN-F3L         PIC X(01).
                   07  SPA-GMN-JOTAIMEIL   PIC X(12).
               05  SPA-GMN-JOTAI-MAX       PIC 9(02). 
      *             
               05  SPA-GMN-KOUMOKU.   
                   07  SPA-GMN-PTNUM       PIC X(20).
                   07  SPA-GMN-NAME        PIC X(30).
                   07  SPA-GMN-NAME-R      REDEFINES   SPA-GMN-NAME.
                       09  SPA-GMN-NAME-X  PIC X(02)   OCCURS  15.
                   07  SPA-GMN-ADRS        PIC X(100).
                   07  SPA-GMN-STNYUINYMD  PIC X(09).
                   07  SPA-GMN-EDNYUINYMD  PIC X(09).
                   07  SPA-GMN-SELNUM      PIC 9(03).
                   07  SPA-GMN-TOTAL       PIC X(22).
      *                                             
                   07  SPA-GMN-SRYKA-G.
                       09  SPA-GMN-SRYKA       PIC X(02).
                       09  SPA-GMN-F1          PIC X(01).
                       09  SPA-GMN-SRYKAMEI    PIC X(20).
                   07  SPA-GMN-STAGE-G.
                       09  SPA-GMN-STAGE       PIC X(02).
                       09  SPA-GMN-F2          PIC X(01).
                       09  SPA-GMN-STAGEMEI    PIC X(10).
                   07  SPA-GMN-EDAGE-G.
                       09  SPA-GMN-EDAGE       PIC X(02).
                       09  SPA-GMN-F4          PIC X(01).
                       09  SPA-GMN-EDAGEMEI    PIC X(10).
                   07  SPA-GMN-BTUNUM-G.
                       09  SPA-GMN-BTUNUM      PIC X(02).
                       09  SPA-GMN-F3          PIC X(01).
                       09  SPA-GMN-BTUNUMMEI   PIC X(20).
                   07  SPA-GMN-JOTAI-G.
                       09  SPA-GMN-JOTAI       PIC X(01).
                       09  SPA-GMN-F3          PIC X(01).
                       09  SPA-GMN-JOTAIMEI    PIC X(12).
                   07  SPA-GMN-CHKTESTPT       PIC X(1).
      *
               05  SPA-GMN-TBL.
                   07  SPA-GMN-TBLO            OCCURS   200.
                       09  SPA-GMN-TRENNUM     PIC 9(03).
                       09  SPA-GMN-TPTNUM      PIC X(20).
                       09  SPA-GMN-TNAME       PIC X(50).
                       09  SPA-GMN-TSEX        PIC X(02).
                       09  SPA-GMN-TBRMNUM     PIC X(08).
                       09  SPA-GMN-TNYUINYMD   PIC X(09).
                       09  SPA-GMN-TTAIINYMD   PIC X(09).
                       09  SPA-GMN-TSRYKA      PIC X(20).
                       09  SPA-GMN-TGAIHAKU    PIC X(06).
                       09  SPA-GMN-TCOMMENT    PIC X(06).
                       09  SPA-GMN-TADRS       PIC X(50).
      *
           03  SPA-NAI-AREA.
               05  SPA-NAI-KOUMOKU.   
                   07  SPA-NAI-STNYUINYMD      PIC X(08).
                   07  SPA-NAI-EDNYUINYMD      PIC X(08).
                   07  SPA-NAI-STAGE           PIC 9(03).
                   07  SPA-NAI-EDAGE           PIC 9(03).
                   07  SPA-NAI-PTID            PIC 9(05).
                   07  SPA-NAI-SELNUM          PIC 9(03).
                   07  SPA-NAI-TOTAL           PIC 9(05).
      *
               05  SPA-NAI-TBL.
                   07  SPA-NAI-TBLO            OCCURS   200.
                       09  SPA-NAI-TPTID       PIC 9(10).
                       09  SPA-NAI-TBIRTHDAY   PIC 9(08).
                       09  SPA-NAI-TNYUINYMD   PIC X(08).
                       09  SPA-NAI-TTAIINYMD   PIC X(08).
                       09  SPA-NAI-TSRYKA      PIC X(02).
                       09  SPA-NAI-TBTUNUM     PIC X(02).
                       09  SPA-NAI-TKANANAME   PIC X(50).
      *             
               05  SPA-NAI-NAME-MAX        PIC 9(02).                             
      *    入力項目名
           03  SPA-MCP-WIDGET              PIC X(64).
      *   
      *    COPY    "ENUM-VALUE".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-I001            PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
      *     
           03  FLG-CHK             PIC 9(01).
           03  FLG-TOUROKU         PIC 9(01).
           03  FLG-JYOKEN          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                 PIC 9(04).
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
           03  IDX1                PIC 9(04). 
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDX4                PIC 9(04).
           03  IDXA                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MOTOPG          PIC X(08).
           03  WRK-SELNO           PIC 9(03). 
           03  WRK-RENNUM          PIC 9(02).
           03  WRK-WIDGET.
               05  WRK-WIDGET1     PIC X(09).
               05  WRK-WIDGET2     PIC 9(01).  
           03  WRK-YMD             PIC X(10).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-PIN.
               05  PIN9            PIC 9(03).
               05  FILLER          REDEFINES  PIN9.
                   07  PIN10       PIC 9(02).
                   07  PIN1        PIC 9(01).
           03  WRK-PED.
               05  PEDX            PIC X(02)  OCCURS  15.
           03  WRK-PKANA           PIC X(02).
           03  WRK-SQL-PNT         PIC 9(05).
           03  WRK-SQL             PIC X(20000).
           03  WRK-SQL-COUNT       PIC X(20000).
           03  WRK-SYSYMD          PIC 9(08).
           03  WRK-AGE             PIC 9(03).
      *
           03  WRK-HENFLG          PIC X(01).
      *     
           03  WRK-DBPATH          PIC X(64).
      *
           03  WRK-BRMNUM-9        PIC 9(08).
           03  WRK-BRMNUM-Z        PIC ZZZZZZZ9.     
      *
           03  WRK-JYOKEN-AREA.
               05  WRK-NAME        PIC X(100).
               05  WRK-STAGE       PIC 9(03).
               05  WRK-EDAGE       PIC 9(03). 
               05  WRK-ADRS        PIC X(150).
               05  WRK-STBIRTHDAY  PIC 9(08).
               05  WRK-EDBIRTHDAY  PIC 9(08).
               05  WRK-MOJISU1     PIC 9(03).
               05  WRK-MOJISU2     PIC 9(03).
      *         
       01  WRK-HEN-AREA.
           03  WRK-LENGTH          PIC 9(02).
           03  WRK-NENGO           PIC X(04).
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *         
           03  WRK-I2IDMSG         PIC X(80).
           03  WRK-STR-LEFT                        PIC X(500).
           03  WRK-STR-LEFT-Z      REDEFINES       WRK-STR-LEFT.
               05  WRK-STR-LEFT-ZX99               PIC Z(9)9.
               05                                  PIC X(490).
           03  WRK-STR-LEFT-TMP                    PIC X(500).
      *
       01  WRK-CONS-AREA.
           03  WRK-CONS-AGE-TABLE.
               05  FILLER          PIC X(42)   VALUE 
                   "000010020030040050060070080090100110120130".
               05  FILLER          PIC X(42)   VALUE
                   "009019029039049059069079089099109119129139".
           03  WRK-CONS-AGE-TABLE-R    REDEFINES   WRK-CONS-AGE-TABLE.
               05  WRK-CONS-STAGE      PIC 9(03)   OCCURS  14.
               05  WRK-CONS-EDAGE      PIC 9(03)   OCCURS  14.
      *                                      
       01  PIN-TBL-AREA.
           03  KANA-TBL.
               05 FILLER PIC X(20) VALUE "アイウエオ　　　　　".
               05 FILLER PIC X(20) VALUE "カキクケコ　　　　　".
               05 FILLER PIC X(20) VALUE "サシスセソ　　　　　".
               05 FILLER PIC X(20) VALUE "タチツテト　　　　　".
               05 FILLER PIC X(20) VALUE "ナニヌネノ　　　　　".
               05 FILLER PIC X(20) VALUE "ハヒフヘホ　　　　　".
               05 FILLER PIC X(20) VALUE "マミムメモ　　　　　".
               05 FILLER PIC X(20) VALUE "ヤ　ユ　ヨ　　　　　".
               05 FILLER PIC X(20) VALUE "ラリルレロ　　　　　".
               05 FILLER PIC X(20) VALUE "ワヲン゛゜　　　　　".
               05 FILLER PIC X(20) VALUE "ー　　　　　　　　　".
               05 FILLER PIC X(20) VALUE "ＡＧＭＳＹａｇｍｓｙ".
               05 FILLER PIC X(20) VALUE "ＢＨＮＴＺｂｈｎｔｚ".
               05 FILLER PIC X(20) VALUE "ＣＩＯＵ　ｃｉｏｕ　".
               05 FILLER PIC X(20) VALUE "ＤＪＰＶ　ｄｊｐｖ　".
               05 FILLER PIC X(20) VALUE "ＥＫＱＷ　ｅｋｑｗ　".
               05 FILLER PIC X(20) VALUE "ＦＬＲＸ　ｆｌｒｘ　".
           03  KANA-TBL-R          REDEFINES  KANA-TBL.
               05  PKANAX          OCCURS   17.
                   07  PKANA       PIC X(02)  OCCURS  10.
       01  CONST-NAME-MAX          PIC 9(02)  VALUE 15.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK5001.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
       01  I001-REC. 
           COPY    "CPI001.INC".     
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    入院患者照会サブ
           COPY    "CPI2SUB01.INC".
      *
      *   保険算定用年齢・割合計算サブ
           COPY    "CPORCSAGECHK.INC".
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTNUM.INC".
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "I20.INC".
           COPY    "I21.INC".
           COPY    "I2ERR.INC".
           COPY    "I2ID1.INC".
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
           MOVE    SPA-FREE        TO  SPA-I20-AREA
           MOVE    SPA-WORK        TO  SPA-I2KYOUTU
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-I2KYOUTU    TO  SPA-WORK  
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-I20-AREA    TO  SPA-FREE
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
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "I2ERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO      TO      100-INIT-EXT
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
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "I20    "           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
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
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
      *                      
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "I2ID1"
                   PERFORM 330-I2ID1-SET-SEC
                   GO  TO  300-SCREEN-EXT
           WHEN    "I21"
                   MOVE    ZERO            TO  SPA-GMN-SELNUM
                   GO  TO  300-SCREEN-EXT
      *
      *    入院会計照会画面
           WHEN    "I01"
      *
      *        退避しておいたＳＰＡの内容を元に戻す
               INITIALIZE                  I2SUB01-LNK
               MOVE    SPA-TERMID      TO  I2SUB01-TERMID
               MOVE    "I"             TO  I2SUB01-KBN
               CALL    "ORCGI2SUB01"   USING   I2SUB01-LNK
      *
               MOVE    I2SUB01-SCRSPA-AREA
                                       TO  SPA-I20-AREA
               MOVE    I2SUB01-COMMON  TO  SPA-I2KYOUTU
      *
               GO  TO  300-SCREEN-EXT
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
      *
           INITIALIZE              SPA-I20-AREA
                                   SPA-I2KYOUTU
      *
           MOVE    "01"            TO  SPA-GMN-STAGEL        (1)
           MOVE    "02"            TO  SPA-GMN-STAGEL        (2)
           MOVE    "03"            TO  SPA-GMN-STAGEL        (3)
           MOVE    "04"            TO  SPA-GMN-STAGEL        (4)
           MOVE    "05"            TO  SPA-GMN-STAGEL        (5)
           MOVE    "06"            TO  SPA-GMN-STAGEL        (6)
           MOVE    "07"            TO  SPA-GMN-STAGEL        (7)
           MOVE    "08"            TO  SPA-GMN-STAGEL        (8)
           MOVE    "09"            TO  SPA-GMN-STAGEL        (9)
           MOVE    "10"            TO  SPA-GMN-STAGEL        (10)
           MOVE    "11"            TO  SPA-GMN-STAGEL        (11)
           MOVE    "12"            TO  SPA-GMN-STAGEL        (12)
           MOVE    "13"            TO  SPA-GMN-STAGEL        (13)
           MOVE    "14"            TO  SPA-GMN-STAGEL        (14)
           MOVE    "０歳"          TO  SPA-GMN-STAGEMEIL     (1)
           MOVE    "１０歳"        TO  SPA-GMN-STAGEMEIL     (2)
           MOVE    "２０歳"        TO  SPA-GMN-STAGEMEIL     (3)
           MOVE    "３０歳"        TO  SPA-GMN-STAGEMEIL     (4)
           MOVE    "４０歳"        TO  SPA-GMN-STAGEMEIL     (5)
           MOVE    "５０歳"        TO  SPA-GMN-STAGEMEIL     (6)
           MOVE    "６０歳"        TO  SPA-GMN-STAGEMEIL     (7)
           MOVE    "７０歳"        TO  SPA-GMN-STAGEMEIL     (8)
           MOVE    "８０歳"        TO  SPA-GMN-STAGEMEIL     (9)
           MOVE    "９０歳"        TO  SPA-GMN-STAGEMEIL     (10)
           MOVE    "１００歳"      TO  SPA-GMN-STAGEMEIL     (11)
           MOVE    "１１０歳"      TO  SPA-GMN-STAGEMEIL     (12)
           MOVE    "１２０歳"      TO  SPA-GMN-STAGEMEIL     (13)
           MOVE    "１３０歳"      TO  SPA-GMN-STAGEMEIL     (14)
           MOVE    14              TO  SPA-GMN-STAGE-MAX
      *
           MOVE    "01"            TO  SPA-GMN-EDAGEL        (1)
           MOVE    "02"            TO  SPA-GMN-EDAGEL        (2)
           MOVE    "03"            TO  SPA-GMN-EDAGEL        (3)
           MOVE    "04"            TO  SPA-GMN-EDAGEL        (4)
           MOVE    "05"            TO  SPA-GMN-EDAGEL        (5)
           MOVE    "06"            TO  SPA-GMN-EDAGEL        (6)
           MOVE    "07"            TO  SPA-GMN-EDAGEL        (7)
           MOVE    "08"            TO  SPA-GMN-EDAGEL        (8)
           MOVE    "09"            TO  SPA-GMN-EDAGEL        (9)
           MOVE    "10"            TO  SPA-GMN-EDAGEL        (10)
           MOVE    "11"            TO  SPA-GMN-EDAGEL        (11)
           MOVE    "12"            TO  SPA-GMN-EDAGEL        (12)
           MOVE    "13"            TO  SPA-GMN-EDAGEL        (13)
           MOVE    "14"            TO  SPA-GMN-EDAGEL        (14)
           MOVE    "９歳"          TO  SPA-GMN-EDAGEMEIL     (1)
           MOVE    "１９歳"        TO  SPA-GMN-EDAGEMEIL     (2)
           MOVE    "２９歳"        TO  SPA-GMN-EDAGEMEIL     (3)
           MOVE    "３９歳"        TO  SPA-GMN-EDAGEMEIL     (4)
           MOVE    "４９歳"        TO  SPA-GMN-EDAGEMEIL     (5)
           MOVE    "５９歳"        TO  SPA-GMN-EDAGEMEIL     (6)
           MOVE    "６９歳"        TO  SPA-GMN-EDAGEMEIL     (7)
           MOVE    "７９歳"        TO  SPA-GMN-EDAGEMEIL     (8)
           MOVE    "８９歳"        TO  SPA-GMN-EDAGEMEIL     (9)
           MOVE    "９９歳"        TO  SPA-GMN-EDAGEMEIL     (10)
           MOVE    "１０９歳"      TO  SPA-GMN-EDAGEMEIL     (11)
           MOVE    "１１９歳"      TO  SPA-GMN-EDAGEMEIL     (12)
           MOVE    "１２９歳"      TO  SPA-GMN-EDAGEMEIL     (13)
           MOVE    "１３９歳"      TO  SPA-GMN-EDAGEMEIL     (14)
           MOVE    14              TO  SPA-GMN-EDAGE-MAX
      *
           MOVE    ZERO            TO  SPA-GMN-SRYKA-MAX  
      *    
           MOVE    SPACE           TO  SYS-KEY
           MOVE    "1005"          TO  SYS-1005-KANRICD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
      *    システム管理検索
           MOVE    SYS-1005-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       (IDX            >   99   )  OR
                               (FLG-SYSKANRI   =   1    )
               MOVE    MCPDATA-REC           TO  SYS-1005-REC
               MOVE    SYS-1005-KBNCD (1:2)  TO
                                             SPA-GMN-SRYKAL   (IDX)
               MOVE    SYS-1005-SRYKANAME1   TO
                                             SPA-GMN-SRYKAMEIL(IDX)
      *
               MOVE    IDX                   TO  SPA-GMN-SRYKA-MAX  
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    ZERO            TO  SPA-GMN-BTUNUM-MAX  
      *
           MOVE    SPACE           TO  SYS-5001-REC     
           INITIALIZE                  SYS-5001-REC
           MOVE    "5001"          TO  SYS-5001-KANRICD
           MOVE    SPA-SYSYMD      TO  ORC-DBYMD
           MOVE    SYS-5001-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       (IDX            >   50   )  OR
                               (FLG-SYSKANRI   =   1    )
               MOVE    MCPDATA-REC           TO  SYS-5001-REC
               MOVE    SYS-5001-BTU-NUM      TO
                                             SPA-GMN-BTUNUML   (IDX)
               MOVE    SYS-5001-BTU-NAME     TO
                                             SPA-GMN-BTUNUMMEIL(IDX)
      *
               MOVE    IDX                   TO  SPA-GMN-BTUNUM-MAX  
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
      *    状態
           MOVE    "1"                 TO  SPA-GMN-JOTAIL (1)
           MOVE    "2"                 TO  SPA-GMN-JOTAIL (2)
           MOVE    "入院中"            TO  SPA-GMN-JOTAIMEIL (1)
           MOVE    "退院済"            TO  SPA-GMN-JOTAIMEIL (2)
           MOVE    2                   TO  SPA-GMN-JOTAI-MAX
      *
           MOVE    "F"                 TO  SPA-GMN-CHKTESTPT
      *
           MOVE    1                   TO  SPA-GMN-CUR                                 
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-I2ID1-SET-SEC            SECTION.
      *
           IF      SPA-I2ID1-FLG    =   "OK"
               EVALUATE    SPA-I2IDCD
                   WHEN    "1001"
                       PERFORM 450-KENSAKU-SEC
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE           TO  SPA-I2ID1-FLG
           MOVE    SPACE           TO  SPA-I2IDCD
           .
       330-I2ID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
      *    クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 420-CLEAR-SEC
      *    詳細画面
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 440-SYOSAI-SEC
      *    詳細画面
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 440-I01-SENI-SEC
      *    予約登録へ
      ****     WHEN    "CLICKED"       ALSO    "B10"
      ****         PERFORM 480-YOYAKU-SEC
      *    受付一覧へ
      ****     WHEN    "CLICKED"       ALSO    "B11"
      ****         PERFORM 490-UKEICHI-SEC
      *    検索開始
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-KENSAKU-MAE-SEC
      *    テスト患者区分
               WHEN    "CLICKED"       ALSO    "CHKTESTPT"
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
      *            入力個所のセット
                   PERFORM 400-GMN-INPUT-SEC
      *
                   MOVE    ZERO                TO  FLG-TOUROKU
      *            入力チェック処理
                   PERFORM 410-INPUT-CHK-SEC
      *    カナ入力             
               WHEN    OTHER       
                   IF      MCP-EVENT           =   "CLICKED" 
                       IF      MCP-WIDGET (1:2)    =   "BA"
                           IF      MCP-WIDGET (3:3)    NUMERIC
                               MOVE    MCP-WIDGET(3:3)     TO  PIN9
                               PERFORM 410111-PIN-SET-SEC
                           END-IF
                       END-IF
                       EVALUATE    MCP-WIDGET
                       WHEN    "BSP"
                           PERFORM 410114-SPACE-SEC
                       WHEN    "BSH"
                           PERFORM 410112-SHIFT-SEC
                       WHEN    "BAK"
                           PERFORM 410113-BACK-SEC
                       END-EVALUATE
                   END-IF
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
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    保険組合せ選択
               WHEN    ANY             ALSO    "KANJYALST"
                   PERFORM 400-KANJYALST-SEL-SEC
               WHEN    "ACTIVATE"      ALSO    "SELNUM"
                   PERFORM 400-SELNUM-CHK-SEC
               WHEN    OTHER    
      *            入力個所のセット
                   PERFORM 400-GMN-INPUT-SEC
      *
                   MOVE    ZERO                TO  FLG-TOUROKU
      *            入力チェック処理
                   PERFORM 410-INPUT-CHK-SEC
           END-EVALUATE
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       400-KANJYALST-SEL-SEC       SECTION.
      *     
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       SPA-GMN-MAX
               IF      I20-SELECT (IDX)    =   "T"
                   MOVE    IDX                  TO  WRK-SELNO
                   MOVE    SPA-GMN-MAX          TO  IDX
               END-IF
           END-PERFORM
      *
           MOVE    SPA-GMN-TRENNUM (WRK-SELNO)
                                       TO  SPA-GMN-SELNUM
           .
       400-KANJYALST-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択　入力処理
      *****************************************************************
       400-SELNUM-CHK-SEC         SECTION.
      *
           MOVE    12             TO  SPA-GMN-CUR
      *
           MOVE    I20-SELNUM     TO  SPA-GMN-SELNUM
      *
           IF      SPA-GMN-SELNUM >   SPA-GMN-MAX
               MOVE    "0010"          TO  SPA-ERRCD
           END-IF
           .
       400-SELNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       400-GMN-INPUT-SEC          SECTION.
      *
           MOVE    MCP-WIDGET          TO  SPA-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
           .
      *
       400-GMN-INPUT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *     
      *    基本チェック
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *     
      *    関連チェック
           PERFORM 4103-KANREN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  410-INPUT-CHK-EXT
           END-IF
      *
      *    登録時、必須入力チェック
           IF      FLG-TOUROKU         =   1
               PERFORM 4109-TOUROKU-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO  TO  410-INPUT-CHK-EXT
               END-IF
           END-IF
      *
           MOVE    ZERO            TO  SPA-GMN-CUR
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC          SECTION.
      *
           MOVE    I20-PTNUM           TO  SPA-GMN-PTNUM
           MOVE    I20-NAME            TO  SPA-GMN-NAME
           MOVE    I20-STAGE           TO  SPA-GMN-STAGE-G
           MOVE    I20-EDAGE           TO  SPA-GMN-EDAGE-G
           MOVE    I20-ADRS            TO  SPA-GMN-ADRS
           MOVE    I20-STNYUINYMD      TO  SPA-GMN-STNYUINYMD
           MOVE    I20-EDNYUINYMD      TO  SPA-GMN-EDNYUINYMD
           MOVE    I20-SRYKA           TO  SPA-GMN-SRYKA-G
           MOVE    I20-BTUNUM          TO  SPA-GMN-BTUNUM-G
           MOVE    I20-JOTAI           TO  SPA-GMN-JOTAI-G
           MOVE    I20-CHKTESTPT       TO  SPA-GMN-CHKTESTPT
      *
      *****MOVE    I20-SELNUM          TO  SPA-GMN-SELNUM
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC          SECTION.
      * 
      *    患者番号
           PERFORM 41021-PTNUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    患者氏名         
           PERFORM 41022-NAME-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
              GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    開始年齢
           PERFORM 41023-STAGE-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    終了年齢
           PERFORM 41029-EDAGE-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    住所         
           PERFORM 41024-ADRS-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    開始入院日
           PERFORM 41025-STNYUINYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    終了入院日
           PERFORM 41026-EDNYUINYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
              GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    診療科
           PERFORM 41027-SRYKA-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    病棟         
           PERFORM 41028-BTUNUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    状態
           PERFORM 41029-JOTAI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
      *    テスト患者
           PERFORM 41030-CHKTESTPT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO  TO  4102-KIHON-CHK-EXT
           END-IF
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
       41021-PTNUM-CHK-SEC            SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-PTNUM       =   SPACE
      *        CONTINUE
               MOVE    ZERO            TO  SPA-NAI-PTID
           ELSE     
               INITIALIZE                  ORCSPTNUMAREA
               MOVE    SPA-GMN-PTNUM       TO  SPTNUM-PTNUM
               CALL    "ORCSPTNUM"         USING   ORCSPTNUMAREA
                                                   SPA-AREA
               IF      SPTNUM-RC           =   ZERO 
                   MOVE    SPTNUM-PTNUM        TO  SPA-GMN-PTNUM
                   MOVE    SPTNUM-PTID         TO  SPA-NAI-PTID
      *            患者マスター存在チェック
                   MOVE    SPA-HOSPID          TO  PTINF-HOSPID
                   MOVE    SPA-NAI-PTID        TO  PTINF-PTID
                   PERFORM 900-PTINF-READ-SEC
                   IF      FLG-PTINF           NOT =   ZERO
                       MOVE    "0001"              TO  SPA-ERRCD
                   ELSE
                       MOVE    PTINF-NAME          TO  SPA-GMN-NAME
                   END-IF         
               ELSE
                   MOVE    "0001"              TO  SPA-ERRCD
               END-IF
           END-IF        
           . 
       41021-PTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    氏名チェック処理
      *****************************************************************
       41022-NAME-CHK-SEC             SECTION.
      *
           MOVE    2                    TO  SPA-GMN-CUR
      * 
           MOVE    ZERO                 TO  SPA-NAI-NAME-MAX
      *
           IF      SPA-GMN-NAME         =   SPACE
               GO  TO  41022-NAME-CHK-EXT
           END-IF
      *
      *    半角チェック
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI 
           MOVE    SPA-GMN-NAME        TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
           AND     KANACHK-SYUBETU     =   "2"
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-NAME
           ELSE
               MOVE    "0002"              TO  SPA-ERRCD
           END-IF
      *
           IF      SPA-ERRCD          =   SPACE
               PERFORM VARYING IDX FROM    15  BY  -1
                       UNTIL   IDX <       1
                   IF      SPA-GMN-NAME-X (IDX)    NOT =   SPACE
                       MOVE    IDX             TO  SPA-NAI-NAME-MAX
                       MOVE    1               TO  IDX
                   END-IF
               END-PERFORM
           END-IF            
                                       
           .
       41022-NAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始年齢チェック処理
      *****************************************************************
       41023-STAGE-CHK-SEC                SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-STAGE         =   SPACE
               CONTINUE
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-STAGE-MAX
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-STAGE 
                                  =   SPA-GMN-STAGEL (IDY)
                       MOVE    1              TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0003"               TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       41023-STAGE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了年齢チェック処理
      *****************************************************************
       41029-EDAGE-CHK-SEC                SECTION.
      *
           MOVE    4                   TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-EDAGE         =   SPACE
               CONTINUE
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-STAGE-MAX
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-EDAGE 
                                  =   SPA-GMN-STAGEL (IDY)
                       MOVE    1              TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0009"               TO  SPA-ERRCD
               END-IF
           END-IF
      *
           .
       41029-EDAGE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    住所チェック処理
      *****************************************************************
       41024-ADRS-CHK-SEC             SECTION.
      *
           MOVE    5                    TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-ADRS         =   SPACE
               GO  TO  41024-ADRS-CHK-EXT
           END-IF
      *
      *    半角チェック
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI 
           MOVE    SPA-GMN-ADRS        TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
           AND     KANACHK-SYUBETU     =   "2"
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-ADRS
           ELSE
               MOVE    "0004"              TO  SPA-ERRCD
           END-IF
           .
       41024-ADRS-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始入院日チェック処理
      *****************************************************************
       41025-STNYUINYMD-CHK-SEC         SECTION.
      *
           MOVE    6                    TO  SPA-GMN-CUR
      *
           IF     SPA-GMN-STNYUINYMD    =   SPACE
               MOVE    SPACE                TO  SPA-NAI-STNYUINYMD
           ELSE    
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-STNYUINYMD  TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN-STNYUINYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI-STNYUINYMD
               ELSE
                   MOVE    "0005"          TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       41025-STNYUINYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了入院日チェック処理
      *****************************************************************
       41026-EDNYUINYMD-CHK-SEC         SECTION.
      *
           MOVE    7                    TO  SPA-GMN-CUR
      *
           IF     SPA-GMN-EDNYUINYMD    =   SPACE
               MOVE    "99999999"           TO  SPA-NAI-EDNYUINYMD
           ELSE    
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-EDNYUINYMD  TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN-EDNYUINYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI-EDNYUINYMD
               ELSE
                   MOVE    "0006"          TO  SPA-ERRCD
               END-IF
           END-IF    
           .
       41026-EDNYUINYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科入力処理
      *****************************************************************
       41027-SRYKA-CHK-SEC             SECTION.
      *
           MOVE    8                   TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-SRYKA       =   SPACE
               CONTINUE
           ELSE    
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-SRYKA-MAX
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-SRYKA 
                                      =   SPA-GMN-SRYKAL (IDY)
                       MOVE    SPA-GMN-SRYKALST (IDY)
                                          TO  SPA-GMN-SRYKA-G
                       MOVE    1          TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0007"               TO  SPA-ERRCD
               END-IF
           END-IF            
           .
       41027-SRYKA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟入力処理
      *****************************************************************
       41028-BTUNUM-CHK-SEC             SECTION.
      *
           MOVE    9                   TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-BTUNUM      =   SPACE
               CONTINUE
           ELSE    
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-BTUNUM-MAX
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-BTUNUM 
                                      =   SPA-GMN-BTUNUML (IDY)
                       MOVE    SPA-GMN-BTUNUMLST (IDY)
                                         TO  SPA-GMN-BTUNUM-G
                       MOVE    1          TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0008"               TO  SPA-ERRCD
               END-IF
           END-IF            
           .
       41028-BTUNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    状態入力処理
      *****************************************************************
       41029-JOTAI-CHK-SEC             SECTION.
      *
           MOVE    10                  TO  SPA-GMN-CUR
      *
           IF      SPA-GMN-JOTAI      =   SPACE
               CONTINUE
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-JOTAI-MAX
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-JOTAI 
                                      =   SPA-GMN-JOTAIL (IDY)
                       MOVE    SPA-GMN-JOTAILST (IDY)
                                         TO  SPA-GMN-JOTAI-G
                       MOVE    1          TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0009"               TO  SPA-ERRCD
               END-IF
           END-IF
           .
       41029-JOTAI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    テスト患者入力処理
      *****************************************************************
       41030-CHKTESTPT-CHK-SEC         SECTION.
      *
      *
           .
       41030-CHKTESTPT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    関連チェック処理
      *****************************************************************
       4103-KANREN-CHK-SEC             SECTION.
      *
      *    入院日の関連チェック
           PERFORM 41031-KANREN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE 
               GO      TO      4103-KANREN-CHK-EXT
           END-IF
           .
      *
       4103-KANREN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院日の関連チェック
      *****************************************************************
       41031-KANREN-CHK-SEC           SECTION.
      * 
           IF      SPA-NAI-STNYUINYMD    =   ZERO
           OR      SPA-NAI-EDNYUINYMD    =   ZERO
               CONTINUE
           ELSE
               IF      SPA-NAI-STNYUINYMD    <=   SPA-NAI-EDNYUINYMD
                   CONTINUE
               ELSE
                   MOVE    "0000"          TO  SPA-ERRCD    
               END-IF   
           END-IF
           .
       41031-KANREN-CHK-EXT.
           EXIT.
      *
      ****************************************************************
      *    登録前、必須入力チェック処理
      ****************************************************************
       4109-TOUROKU-CHK-SEC      SECTION.
      *
      *    登録時、必須入力チェック
           .
      *
       4109-TOUROKU-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    漢字セット　処理
      *****************************************************************
       410111-PIN-SET-SEC              SECTION.
      *
           MOVE    PIN10               TO  IDX1
           MOVE    PIN1                TO  IDX2
      *
           MOVE    PKANA(IDX1 IDX2)    TO  WRK-PKANA
           IF     (WRK-PKANA           =   "゜"  ) AND
                  (SPA-NAI-NAME-MAX         >   0     )
               EVALUATE    SPA-GMN-NAME-X (SPA-NAI-NAME-MAX)
                   WHEN    "ハ"
                       MOVE    "パ"            TO  WRK-PKANA
                   WHEN    "ヒ"
                       MOVE    "ピ"            TO  WRK-PKANA
                   WHEN    "フ"
                       MOVE    "プ"            TO  WRK-PKANA
                   WHEN    "ヘ"
                       MOVE    "ペ"            TO  WRK-PKANA
                   WHEN    "ホ"
                       MOVE    "ポ"            TO  WRK-PKANA
                   WHEN    OTHER
                       ADD    1                TO  SPA-NAI-NAME-MAX
               END-EVALUATE
           ELSE
               IF    (WRK-PKANA        =   "゛" ) AND
                     (SPA-NAI-NAME-MAX      >   0    )
                   EVALUATE    SPA-GMN-NAME-X (SPA-NAI-NAME-MAX)
                       WHEN    "ウ"
                           MOVE    "ヴ"            TO  WRK-PKANA
                       WHEN    "カ"
                           MOVE    "ガ"            TO  WRK-PKANA
                       WHEN    "キ"
                           MOVE    "ギ"            TO  WRK-PKANA
                       WHEN    "ク"
                           MOVE    "グ"            TO  WRK-PKANA
                       WHEN    "ケ"
                           MOVE    "ゲ"            TO  WRK-PKANA
                       WHEN    "コ"
                           MOVE    "ゴ"            TO  WRK-PKANA
                       WHEN    "サ"
                           MOVE    "ザ"            TO  WRK-PKANA
                       WHEN    "シ"
                           MOVE    "ジ"            TO  WRK-PKANA
                       WHEN    "ス"
                           MOVE    "ズ"            TO  WRK-PKANA
                       WHEN    "セ"
                           MOVE    "ゼ"            TO  WRK-PKANA
                       WHEN    "ソ"
                           MOVE    "ゾ"            TO  WRK-PKANA
                       WHEN    "タ"
                           MOVE    "ダ"            TO  WRK-PKANA
                       WHEN    "チ"
                           MOVE    "ヂ"            TO  WRK-PKANA
                       WHEN    "ツ"
                           MOVE    "ヅ"            TO  WRK-PKANA
                       WHEN    "テ"
                           MOVE    "デ"            TO  WRK-PKANA
                       WHEN    "ト"
                           MOVE    "ド"            TO  WRK-PKANA
                       WHEN    "ハ"
                           MOVE    "バ"            TO  WRK-PKANA
                       WHEN    "ヒ"
                           MOVE    "ビ"            TO  WRK-PKANA
                       WHEN    "フ"
                           MOVE    "ブ"            TO  WRK-PKANA
                       WHEN    "ヘ"
                           MOVE    "ベ"            TO  WRK-PKANA
                       WHEN    "ホ"
                           MOVE    "ボ"            TO  WRK-PKANA
                       WHEN    OTHER
                           ADD    1                TO  SPA-NAI-NAME-MAX
                   END-EVALUATE
               ELSE
                   ADD     1               TO  SPA-NAI-NAME-MAX
               END-IF
           END-IF
      *
           IF    ( SPA-NAI-NAME-MAX    >   CONST-NAME-MAX )
               MOVE    CONST-NAME-MAX      TO  SPA-NAI-NAME-MAX
           ELSE
               MOVE    WRK-PKANA           TO  SPA-GMN-NAME-X
                                                (SPA-NAI-NAME-MAX)
           END-IF
           .
       410111-PIN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    小文字変換　処理
      *****************************************************************
       410112-SHIFT-SEC                    SECTION.
      *
           IF      SPA-NAI-NAME-MAX         =   0
               GO      TO      410112-SHIFT-EXT
           END-IF
      *
           MOVE    SPACE               TO  WRK-PKANA
           EVALUATE    SPA-GMN-NAME-X (SPA-NAI-NAME-MAX)
               WHEN    "ア"
                   MOVE    "ァ"            TO  WRK-PKANA
               WHEN    "イ"
                   MOVE    "ィ"            TO  WRK-PKANA
               WHEN    "ウ"
                   MOVE    "ゥ"            TO  WRK-PKANA
               WHEN    "エ"
                   MOVE    "ェ"            TO  WRK-PKANA
               WHEN    "オ"
                   MOVE    "ォ"            TO  WRK-PKANA
               WHEN    "カ"
                   MOVE    "ヵ"            TO  WRK-PKANA
               WHEN    "ツ"
                   MOVE    "ッ"            TO  WRK-PKANA
               WHEN    "ヤ"
                   MOVE    "ャ"            TO  WRK-PKANA
               WHEN    "ユ"
                   MOVE    "ュ"            TO  WRK-PKANA
               WHEN    "ヨ"
                   MOVE    "ョ"            TO  WRK-PKANA
               WHEN    OTHER
                   PERFORM VARYING IDX1    FROM    12  BY  1
                           UNTIL   IDX1    >       17
                       PERFORM VARYING IDX2    FROM    1   BY  1
                               UNTIL   IDX2    >       5
                           IF      PKANA (IDX1 IDX2)   =   SPACE
                               CONTINUE
                           ELSE
                               IF      SPA-GMN-NAME-X (SPA-NAI-NAME-MAX)
                                           =   PKANA (IDX1 IDX2)
                                   MOVE    PKANA (IDX1 IDX2 + 5 )
                                                   TO  WRK-PKANA
                                   MOVE    5       TO  IDX2
                                   MOVE    17      TO  IDX1
                               END-IF
                           END-IF
                       END-PERFORM
                   END-PERFORM                                                       
           END-EVALUATE
      *
           IF      WRK-PKANA       NOT =   SPACE
               MOVE    WRK-PKANA           TO  SPA-GMN-NAME-X
                                                (SPA-NAI-NAME-MAX)
           END-IF
           .
       410112-SHIFT-EXT.
           EXIT.
      *     
      *****************************************************************
      *    後退　処理
      *****************************************************************
       410113-BACK-SEC                    SECTION.
      *
      *    前の桁を削除
           IF      SPA-NAI-NAME-MAX        >   0
               MOVE    SPACE               TO
                                       SPA-GMN-NAME-X(SPA-NAI-NAME-MAX)
               COMPUTE SPA-NAI-NAME-MAX    =   SPA-NAI-NAME-MAX   -   1
           END-IF
           .
       410113-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    空白　処理
      *****************************************************************
       410114-SPACE-SEC                    SECTION.
      *
           IF    ( SPA-NAI-NAME-MAX    <   CONST-NAME-MAX )
               COMPUTE SPA-NAI-NAME-MAX
                   =   SPA-NAI-NAME-MAX    +   1
               MOVE    "　"    TO  SPA-GMN-NAME-X (SPA-NAI-NAME-MAX)
           ELSE
               MOVE    CONST-NAME-MAX      TO  SPA-NAI-NAME-MAX
           END-IF
           .
       410114-SPACE-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "I20"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  SPA-WORK 
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
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
      *    クリア処理
      *****************************************************************
       420-CLEAR-SEC                   SECTION.
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
                                       SPA-GMN-TBL
                                       SPA-NAI-KOUMOKU
                                       SPA-NAI-TBL
           MOVE    ZERO                TO  SPA-GMN-MAX
                                           SPA-NAI-NAME-MAX                            
      *
           MOVE    "F"                 TO  SPA-GMN-CHKTESTPT
      *
           MOVE    1                   TO  SPA-GMN-CUR
           .
       420-CLEAR-EXT.
           EXIT.
      *    
      *****************************************************************
      *    詳細画面へ
      *****************************************************************
       440-SYOSAI-SEC                   SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    選択番号チェック
           PERFORM 400-SELNUM-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  440-SYOSAI-EXT
           END-IF
      *
      *    選択されていないとき
           IF      SPA-GMN-SELNUM      =   ZERO
               MOVE    "0201"              TO  SPA-ERRCD
               MOVE    12                  TO  SPA-GMN-CUR
               GO  TO  440-SYOSAI-EXT
           END-IF
      *
           MOVE    SPA-GMN-SELNUM      TO  IDX     
      *           
           MOVE    SPACE               TO  I21
      *     
           MOVE    SPA-GMN-TPTNUM (IDX)
                                       TO  I21-PTNUM
           MOVE    SPA-NAI-TKANANAME (IDX)
                                       TO  I21-KANANAME 
           MOVE    SPA-GMN-TNAME (IDX) TO  I21-NAME
           MOVE    SPA-GMN-TSEX  (IDX) TO  I21-SEX
           MOVE    SPA-NAI-TBIRTHDAY (IDX)
                                       TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG         TO  I21-BIRTHDAY
           MOVE    SPA-SYSYMD          TO  WRK-SYSYMD  
           COMPUTE WRK-AGE     =     ( WRK-SYSYMD  -   
                                           SPA-NAI-TBIRTHDAY (IDX) )
                                       /   10000
           MOVE    WRK-AGE             TO  I21-AGE
           MOVE    SPA-GMN-TADRS (IDX) TO  I21-ADRS     
      *
           MOVE    SPACE               TO  SYS-5001-REC     
           INITIALIZE                  SYS-5001-REC
           MOVE    "5001"              TO  SYS-5001-KANRICD
           MOVE    SPA-NAI-TBTUNUM (IDX)
                                       TO  SYS-5001-KBNCD 
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-5001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-5001-REC
               MOVE    SYS-5001-BTU-NAME   TO  I21-BTUNUM
           END-IF    
           MOVE    SPA-GMN-TBRMNUM (IDX)
                                       TO  I21-BRMNUM
           MOVE    "外泊中"            TO  I21-GAIHAKU-VALUE
           MOVE    "red"               TO  I21-GAIHAKU-STYLE                              
           MOVE    "入院中"            TO  I21-JYOTAI1-VALUE
           MOVE    "red"               TO  I21-JYOTAI1-STYLE
           MOVE    "面会謝絶"          TO  I21-JYOTAI2-VALUE
           MOVE    "red"               TO  I21-JYOTAI2-STYLE
           MOVE    "面会拒否"          TO  I21-JYOTAI3-VALUE
           MOVE    "red"               TO  I21-JYOTAI3-STYLE
           MOVE    "感染症（ＭＲＳＡ）"
                                       TO  I21-MSG1-VALUE
           MOVE    "blue"              TO  I21-MSG1-STYLE
           MOVE    "寝たきり"          TO  I21-MSG2-VALUE
           MOVE    "blue"              TO  I21-MSG2-STYLE
           MOVE    "徘徊あり"          TO  I21-MSG3-VALUE
           MOVE    "blue"              TO  I21-MSG3-STYLE
           MOVE    "痴呆"              TO  I21-MSG4-VALUE
           MOVE    "blue"              TO  I21-MSG4-STYLE
           MOVE    "有名人（政治家）なので入院していることを口外"
                                       TO  I21-COMMENT-VALUE 
           MOVE    "しないで下さい"    TO  I21-COMMENT-VALUE (45:)
           MOVE    "green"             TO  I21-COMMENT-STYLE                            
      *    	                        
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "I20"               TO  SPA-MOTOPG
           MOVE    "I21"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE
           MOVE    "I21"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END              
           .
       440-SYOSAI-EXT.
           EXIT.
      *
      *****************************************************************
      *    入退院登録画面へ
      *****************************************************************
       440-I01-SENI-SEC                SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    選択番号チェック
           PERFORM 400-SELNUM-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  440-I01-SENI-EXT
           END-IF
      *
      *    選択されていないとき
           IF      SPA-GMN-SELNUM      =   ZERO
               MOVE    "0201"              TO  SPA-ERRCD
               MOVE    12                  TO  SPA-GMN-CUR
               GO  TO  440-I01-SENI-EXT
           END-IF
      *
           MOVE    SPA-GMN-SELNUM          TO  IDX4
      *
           INITIALIZE                      SPA-KYOTUKEY
                                           SPA-KYOTU-SET
      *
           MOVE    SPA-GMN-TPTNUM  (IDX4)
                                           TO  SPA-PTNUM
           MOVE    SPA-NAI-TPTID   (IDX4)
                                           TO  SPA-PTID
      *
      *    ＳＰＡの内容を退避
           INITIALIZE                  I2SUB01-LNK
           MOVE    SPA-TERMID          TO  I2SUB01-TERMID
           MOVE    "O"                 TO  I2SUB01-KBN
           MOVE    SPA-I20-AREA        TO  I2SUB01-SCRSPA-AREA
           MOVE    SPA-I2KYOUTU        TO  I2SUB01-COMMON
      *
           CALL    "ORCGI2SUB01"       USING   I2SUB01-LNK
      *
      *    入退院登録画面へ遷移する
           MOVE    "I20"               TO  SPA-MOTOPG
           MOVE    "I01"               TO  SPA-SAKIPG
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-I2KYOUTU        TO  SPA-WORK
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-I20-AREA        TO  LNK-SCRSPA
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "I01"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       440-I01-SENI-EXT.
           EXIT.
      *****************************************************************
      *    検索前処理
      *****************************************************************
       450-KENSAKU-MAE-SEC                SECTION.
      *         
      *    入力個所のセット
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
           MOVE    1                   TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    "1001"              TO  SPA-I2IDCD
               CONTINUE
           END-IF
           .
       450-KENSAKU-MAE-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索処理
      *****************************************************************
       450-KENSAKU-SEC                SECTION.
      *
           INITIALIZE                  SPA-GMN-TBL
                                       SPA-NAI-TBL
                                       SPA-GMN-TOTAL
                                       SPA-NAI-TOTAL
      *
           MOVE    ZERO                TO  SPA-GMN-MAX
      *
           PERFORM 4501-SQL-EDIT-SEC
           MOVE    WRK-SQL             TO  WRK-SQL-COUNT
      *
           PERFORM 4503-SQL-ORDER-SEC
      *
           PERFORM 4504-COUNT-GET-SEC
      *
           INITIALIZE                  I001-REC
           MOVE    WRK-SQL             TO  I001-SQL
           MOVE    I001-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "I001-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "I001-KEY"          TO  ORC-DBPATH
               PERFORM 900-I001-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-I001
           END-IF
      *     
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX             >   200  
                   OR      FLG-I001        =   1    
               PERFORM 4502-LIST-HENSYU-SEC
      *
               MOVE    "I001-KEY"              TO  ORC-DBPATH
               PERFORM 900-I001-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "I001-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF      SPA-GMN-MAX         =   ZERO
               MOVE    "対象の患者はありません"
                                           TO  SPA-GMN-TNAME (1)
               MOVE    1                   TO  SPA-GMN-CUR
           ELSE
               MOVE    12                  TO  SPA-GMN-CUR
           END-IF
      *       
           .
       450-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＳＱＬ文編集処理
      *****************************************************************
       4501-SQL-EDIT-SEC               SECTION.
      *
           INITIALIZE                  WRK-JYOKEN-AREA
      *
      *    患者氏名 
           IF      SPA-GMN-NAME        NOT =   SPACE
               MOVE    ZERO                TO  WRK-MOJISU1
               PERFORM VARYING IDX FROM    30   BY  -1
                       UNTIL   IDX <       1
                   IF      SPA-GMN-NAME (IDX:1) NOT =   SPACE
                       MOVE    IDX              TO  WRK-MOJISU1
                       MOVE    1                TO  IDX
                   END-IF
               END-PERFORM
               MOVE    SPA-GMN-NAME        TO  WRK-NAME
               COMPUTE WRK-MOJISU1     =   WRK-MOJISU1    +   1            
               MOVE    "%"                 TO  WRK-NAME (WRK-MOJISU1:1) 
           END-IF                               
      *
      *    開始年齢
           IF      SPA-GMN-STAGE       =   SPACE
               MOVE    ZERO                    TO  WRK-STAGE
           ELSE
               MOVE    SPA-GMN-STAGE           TO  IDX
               MOVE    WRK-CONS-STAGE (IDX)    TO  WRK-STAGE         
           END-IF
      *
      *    終了年齢
           IF      SPA-GMN-EDAGE       =   SPACE
               MOVE    999                     TO  WRK-EDAGE
           ELSE
               MOVE    SPA-GMN-EDAGE           TO  IDX
               MOVE    WRK-CONS-EDAGE (IDX)    TO  WRK-EDAGE         
           END-IF
      *
      *    年齢より生年月日を計算
           MOVE    SPA-SYSYMD          TO  WRK-SYSYMD  
           COMPUTE WRK-EDBIRTHDAY      =   WRK-SYSYMD  - 
                                           WRK-STAGE   *   10000
      *
           IF      WRK-EDAGE           =   999
               MOVE    ZERO                TO  WRK-STBIRTHDAY
           ELSE     
               COMPUTE WRK-STBIRTHDAY      =   WRK-SYSYMD
                                           -  ( WRK-EDAGE + 1 )
                                           *   10000
               INITIALIZE                  STS-AREA-DAY
               INITIALIZE                  LNK-DAY6-AREA
               MOVE    "61"                TO  LNK-DAY6-IRAI
               MOVE    WRK-STBIRTHDAY      TO  LNK-DAY6-KIJUN
               MOVE    "1"                 TO  LNK-DAY6-ZOGENPTN
               MOVE     1                  TO  LNK-DAY6-ZOGEN
               CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN     TO  WRK-STBIRTHDAY
           END-IF    
      *
      *    住所 
           MOVE    SPACE               TO  WRK-ADRS
           IF      SPA-GMN-ADRS        NOT =   SPACE
               MOVE    ZERO                TO  WRK-MOJISU2
               PERFORM VARYING IDX FROM    100 BY  -1
                       UNTIL   IDX <       1
                   IF      SPA-GMN-ADRS   (IDX:1) NOT =   SPACE
                       MOVE    IDX              TO  WRK-MOJISU2
                       MOVE    1                TO  IDX
                   END-IF
               END-PERFORM
               MOVE    SPA-GMN-ADRS        TO  WRK-ADRS
               COMPUTE WRK-MOJISU2     =   WRK-MOJISU2     +   1            
               MOVE    "%"                 TO  WRK-ADRS (WRK-MOJISU2:1) 
           END-IF                               
      *
      *    ＳＱＬ作成
      *
           INITIALIZE                  WRK-SQL
           MOVE    1               TO  WRK-SQL-PNT
      *
           MOVE    ZERO                TO  FLG-JYOKEN
      *     
           IF      SPA-NAI-PTID        >   ZERO
      *        患者ＩＤ
               STRING  "ptid = "       DELIMITED  BY  SIZE
                       SPA-NAI-PTID    DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
               END-STRING
               MOVE    1                   TO  FLG-JYOKEN
           ELSE
      *
      *        患者氏名（前方一致）
               IF      SPA-GMN-NAME        NOT =   SPACE
                   PERFORM 45011-JYOKEN-HENSYU-SEC
                   STRING  "kananame like '"       DELIMITED  BY  SIZE
                           WRK-NAME (1:WRK-MOJISU1)
                                                   DELIMITED  BY  SIZE
                           "'"                     DELIMITED  BY  SIZE                        
                           INTO    WRK-SQL
                           WITH    POINTER WRK-SQL-PNT
                   END-STRING
                   MOVE    1                   TO  FLG-JYOKEN
               END-IF
      *
      *        年齢         
               PERFORM 45011-JYOKEN-HENSYU-SEC
               STRING  "(birthday >= '"        DELIMITED  BY  SIZE
                       WRK-STBIRTHDAY          DELIMITED  BY  SIZE
                       "' and birthday <= '"   DELIMITED  BY  SIZE
                       WRK-EDBIRTHDAY          DELIMITED  BY  SIZE
                       "')"                    DELIMITED  BY  SIZE                        
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
               END-STRING
               MOVE    1                   TO  FLG-JYOKEN
      *
      *        住所（前方一致）
               IF      SPA-GMN-ADRS        NOT =   SPACE
                   PERFORM 45011-JYOKEN-HENSYU-SEC
                   STRING  "home_adrs like '"      DELIMITED  BY  SIZE
                           WRK-ADRS (1:WRK-MOJISU2)
                                                   DELIMITED  BY  SIZE
                           "'"                     DELIMITED  BY  SIZE                        
                           INTO    WRK-SQL
                           WITH    POINTER WRK-SQL-PNT
                   END-STRING
                   MOVE    1                   TO  FLG-JYOKEN
               END-IF
           END-IF
      *
      *    入院日
           PERFORM 45011-JYOKEN-HENSYU-SEC
           STRING  "(nyuinymd >= '"        DELIMITED  BY  SIZE
                   SPA-NAI-STNYUINYMD      DELIMITED  BY  SIZE
                   "' and nyuinymd <= '"   DELIMITED  BY  SIZE
                   SPA-NAI-EDNYUINYMD      DELIMITED  BY  SIZE
                   "')"                    DELIMITED  BY  SIZE                        
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
           END-STRING
           MOVE    1                   TO  FLG-JYOKEN
      *
      *    診療科
           IF      SPA-GMN-SRYKA       =   SPACE
               CONTINUE
           ELSE    
               PERFORM 45011-JYOKEN-HENSYU-SEC
               STRING  "nyuinka = '"       DELIMITED  BY  SIZE
                       SPA-GMN-SRYKA       DELIMITED  BY  SIZE
                       "'"                 DELIMITED  BY  SIZE                        
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
               END-STRING
               MOVE    1                   TO  FLG-JYOKEN
           END-IF    
      *
      *    病棟番号
           IF      SPA-GMN-BTUNUM      =   SPACE
               CONTINUE
           ELSE    
               PERFORM 45011-JYOKEN-HENSYU-SEC
               STRING  "btunum = '"        DELIMITED  BY  SIZE
                       SPA-GMN-BTUNUM      DELIMITED  BY  SIZE
                       "'"                 DELIMITED  BY  SIZE                        
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
               END-STRING
               MOVE    1                   TO  FLG-JYOKEN
           END-IF    
      *
      *    状態
           IF      SPA-GMN-JOTAI      =   SPACE
               CONTINUE
           ELSE
               PERFORM 45011-JYOKEN-HENSYU-SEC
      *
               EVALUATE    SPA-GMN-JOTAI
               WHEN    "1"
                   STRING  "taiinymd = '99999999'"
                           DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               WHEN    "2"
                   STRING  "taiinymd <> '99999999'"
                           DELIMITED  BY  SIZE
                   INTO    WRK-SQL
                   WITH    POINTER WRK-SQL-PNT
                   END-STRING
               END-EVALUATE
      *
               MOVE    1                   TO  FLG-JYOKEN
           END-IF    
      *
      *    テスト患者
           IF      SPA-GMN-CHKTESTPT   =   "T"
               CONTINUE
           ELSE
               PERFORM 45011-JYOKEN-HENSYU-SEC
               STRING  "tstptnumkbn <> '1'"
                       DELIMITED  BY  SIZE
               INTO    WRK-SQL
               WITH    POINTER WRK-SQL-PNT
               END-STRING
               MOVE    1                   TO  FLG-JYOKEN
           END-IF    
           .
       4501-SQL-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    条件編集処理
      *****************************************************************
       45011-JYOKEN-HENSYU-SEC            SECTION.
      *
           IF      FLG-JYOKEN             =   1
               STRING  " and "             DELIMITED  BY  SIZE
                       INTO    WRK-SQL
                       WITH    POINTER WRK-SQL-PNT
               END-STRING
           END-IF
           .
       45011-JYOKEN-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＳＱＬ文編集処理（並べ替え条件）
      *****************************************************************
       4503-SQL-ORDER-SEC                 SECTION.
      *
           STRING  " ORDER BY BRMNUM,PTNUM"
                   DELIMITED  BY  SIZE
           INTO    WRK-SQL
           WITH    POINTER WRK-SQL-PNT
           END-STRING
      *
           .
       4503-SQL-ORDER-EXT.
           EXIT.
      *
      *****************************************************************
      *    件数取得処理
      *****************************************************************
       4504-COUNT-GET-SEC              SECTION.
      *
           MOVE    ZERO                TO  FLG-I001
      *
           INITIALIZE                  I001-REC
           MOVE    WRK-SQL-COUNT       TO  I001-SQL
           MOVE    I001-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "I001-KEY4"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "I001-KEY4"     TO  ORC-DBPATH
               PERFORM 900-I001-READ-SEC
           ELSE
               MOVE    1               TO  FLG-I001
           END-IF
      *
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "I001-KEY4"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF    ( FLG-I001            =   ZERO )
               MOVE    I001-COUNT      TO  SPA-NAI-TOTAL
               MOVE    SPACE           TO  SPA-GMN-TOTAL
               MOVE    I001-COUNT      TO  WRK-STR-LEFT-ZX99
               PERFORM 800-STR-HIDARIZUME-HEN-SEC
               STRING  "件数："            DELIMITED BY SIZE
                       WRK-STR-LEFT        DELIMITED BY SPACE
               INTO    SPA-GMN-TOTAL
               END-STRING
           END-IF
      *
           .
       4504-COUNT-GET-EXT.
           EXIT.
      *****************************************************************
      *    患者病名画面編集処理
      *****************************************************************
       4502-LIST-HENSYU-SEC        SECTION.
      *
           MOVE    IDX             TO  SPA-GMN-MAX
      *
           MOVE    IDX             TO  SPA-GMN-TRENNUM (IDX) 
           MOVE    I001-PTID       TO  SPA-NAI-TPTID   (IDX) 
           INITIALIZE                  ORCSPTIDAREA
           MOVE    SPA-HOSPID      TO  SPTID-HOSPID
           MOVE    I001-PTID       TO  SPTID-PTID
           CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                               SPA-1009-TBL
           IF      SPTID-RC        =   ZERO
               MOVE    SPTID-PTNUM         TO  SPA-GMN-TPTNUM  (IDX)
           END-IF
           MOVE    I001-KANANAME   TO  SPA-NAI-TKANANAME (IDX)
           MOVE    I001-NAME       TO  SPA-GMN-TNAME   (IDX)
           EVALUATE    I001-SEX
               WHEN    "1"
                   MOVE    "男"        TO  SPA-GMN-TSEX    (IDX)
               WHEN    "2"
                   MOVE    "女"        TO  SPA-GMN-TSEX    (IDX)
           END-EVALUATE
           IF      I001-BRMNUM (3:)    NUMERIC
               MOVE    I001-BRMNUM (3:)    TO  WRK-BRMNUM-9
               MOVE    WRK-BRMNUM-9        TO  WRK-BRMNUM-Z
               MOVE    WRK-BRMNUM-Z        TO  SPA-GMN-TBRMNUM (IDX)
           ELSE            
               MOVE    I001-BRMNUM (3:)    TO  SPA-GMN-TBRMNUM (IDX)
           END-IF
           MOVE    I001-BTUNUM     TO  SPA-NAI-TBTUNUM     (IDX)    
           MOVE    I001-NYUINYMD   TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-TNYUINYMD   (IDX)
           MOVE    I001-NYUINYMD   TO  SPA-NAI-TNYUINYMD   (IDX)
           IF    ( I001-TAIINYMD   =   "99999999" )
               MOVE    SPACE           TO  SPA-GMN-TTAIINYMD   (IDX)
           ELSE
               MOVE    I001-TAIINYMD   TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-TTAIINYMD   (IDX)
           END-IF
           MOVE    I001-TAIINYMD       TO  SPA-NAI-TTAIINYMD   (IDX)
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      SPA-GMN-SRYKA-MAX
               IF      I001-NYUINKA   =   SPA-GMN-SRYKAL (IDY)
                   MOVE    SPA-GMN-SRYKAMEIL (IDY)
                                              TO  SPA-GMN-TSRYKA (IDX)
                   MOVE    SPA-GMN-SRYKA-MAX  TO  IDY
               END-IF
           END-PERFORM
           STRING  I001-HOME-ADRS      DELIMITED  BY  SPACE
                   I001-HOME-BANTI     DELIMITED  BY  SPACE
                   INTO    SPA-GMN-TADRS (IDX)
           END-STRING
           MOVE   I001-BIRTHDAY    TO  SPA-NAI-TBIRTHDAY (IDX)          
           .
       4502-LIST-HENSYU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    予約登録へ
      *****************************************************************
       480-YOYAKU-SEC             SECTION.
      *
      *    戻り時、画面を元へ戻す
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-I20-AREA        TO  LNK-SCRSPA
      *    画面移行用のパラメタ変更
           MOVE    "I20"               TO  SPA-MOTOPG
           MOVE    "Y01"               TO  SPA-SAKIPG
           MOVE    "I20"               TO  SPA-MOTOPG3
      *     
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "Y01    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       480-YOYAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    受付一覧へ
      *****************************************************************
       490-UKEICHI-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-I20-AREA        TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "I20"               TO  SPA-MOTOPG
           MOVE    "U01"               TO  SPA-SAKIPG
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "U01    "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-UKEICHI-EXT.
           EXIT.
      *
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
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY          TO  WRK-SYMD
           ELSE
               MOVE    "0017"          TO  SPA-ERRCD
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HGO
               MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
               MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
               MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG
               MOVE    SPACE               TO  WRK-NENGO
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
               MOVE    LNK-DAY2-EDTYMD2-G  TO  WRK-NENGO
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-I2IDCD      NOT =   SPACE
               PERFORM 520-I2IDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "I20    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  I20
      *
           MOVE    SPA-GMN-PTNUM       TO  I20-PTNUM
           MOVE    SPA-GMN-NAME        TO  I20-NAME
           MOVE    SPA-GMN-STAGE-G     TO  I20-STAGE
           MOVE    SPA-GMN-EDAGE-G     TO  I20-EDAGE
           MOVE    SPA-GMN-ADRS        TO  I20-ADRS
           MOVE    SPA-GMN-STNYUINYMD  TO  I20-STNYUINYMD
           MOVE    SPA-GMN-EDNYUINYMD  TO  I20-EDNYUINYMD
           MOVE    SPA-GMN-SRYKA-G     TO  I20-SRYKA
           MOVE    SPA-GMN-BTUNUM-G    TO  I20-BTUNUM
           MOVE    SPA-GMN-JOTAI-G     TO  I20-JOTAI
           MOVE    SPA-GMN-CHKTESTPT   TO  I20-CHKTESTPT
           DISPLAY "I20-CHKTESTPT = " I20-CHKTESTPT
           MOVE    SPA-GMN-SELNUM      TO  I20-SELNUM
           MOVE    SPA-GMN-TOTAL       TO  I20-TOTAL
      *     
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL       IDX         >   SPA-GMN-STAGE-MAX
               MOVE    SPA-GMN-STAGELST (IDX)  TO  I20-STAGELST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-STAGE-MAX     TO  I20-STAGE-COUNT
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL       IDX         >   SPA-GMN-EDAGE-MAX
               MOVE    SPA-GMN-EDAGELST (IDX)  TO  I20-EDAGELST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-EDAGE-MAX     TO  I20-EDAGE-COUNT
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL       IDX         >   SPA-GMN-SRYKA-MAX
               MOVE    SPA-GMN-SRYKALST (IDX)  TO  I20-SRYKALST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-SRYKA-MAX   TO  I20-SRYKA-COUNT
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL       IDX         >   SPA-GMN-BTUNUM-MAX
               MOVE    SPA-GMN-BTUNUMLST (IDX) TO  I20-BTUNUMLST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-BTUNUM-MAX  TO  I20-BTUNUM-COUNT
      *         
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL       IDX         >   SPA-GMN-JOTAI-MAX
               MOVE    SPA-GMN-JOTAILST (IDX) TO  I20-JOTAILST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-JOTAI-MAX  TO  I20-JOTAI-COUNT
      *
           IF      SPA-GMN-MAX             =   ZERO
           AND     SPA-GMN-TNAME (1)   NOT =   SPACE
               MOVE    SPA-GMN-TNAME     (1)   TO  I20-TNAME     (1)
               MOVE    1                       TO  I20-COUNT   
           ELSE       
               PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-MAX
                 MOVE    SPA-GMN-TRENNUM   (IDX) TO  I20-TRENNUM   (IDX)
                 MOVE    SPA-GMN-TPTNUM    (IDX) TO  I20-TPTNUM    (IDX)
                 MOVE    SPA-GMN-TNAME     (IDX) TO  I20-TNAME     (IDX)
                 MOVE    SPA-GMN-TSEX      (IDX) TO  I20-TSEX      (IDX)
                 MOVE    SPA-GMN-TBRMNUM   (IDX) TO  I20-TBRMNUM   (IDX) 
                 MOVE    SPA-GMN-TNYUINYMD (IDX) TO  I20-TNYUINYMD (IDX)
                 MOVE    SPA-GMN-TTAIINYMD (IDX) TO  I20-TTAIINYMD (IDX)
                 MOVE    SPA-GMN-TSRYKA    (IDX) TO  I20-TSRYKA    (IDX)
                 MOVE    SPA-GMN-TGAIHAKU  (IDX) TO  I20-TGAIHAKU  (IDX)
                 MOVE    SPA-GMN-TCOMMENT  (IDX) TO  I20-TCOMMENT  (IDX)
                 MOVE    SPA-GMN-TADRS     (IDX) TO  I20-TADRS     (IDX)
      *         
                 IF      IDX             =   SPA-GMN-SELNUM
                     MOVE    "T"             TO  I20-SELECT (IDX)
                 ELSE
                     MOVE    "F"             TO  I20-SELECT (IDX)
                 END-IF
               END-PERFORM
               MOVE    SPA-GMN-MAX         TO  I20-COUNT   
           END-IF                  
      *
      *    暫定定期に詳細ボタンを非活性にする
           MOVE    WIDGET-INSENSITIVE      TO  I20-B04-STATE
      *         
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
      *    カーソル指定のない時、入力した項目の次へ
           IF      SPA-GMN-CUR         =   ZERO
               PERFORM 50011-INPUT-CUR-SEC
               ADD     1               TO  SPA-GMN-CUR
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE  "PTNUM"           TO  MCP-WIDGET 
               WHEN    2
                   MOVE  "NAME"            TO  MCP-WIDGET 
               WHEN    3
                   MOVE  "STAGE"           TO  MCP-WIDGET 
               WHEN    4
                   MOVE  "EDAGE"           TO  MCP-WIDGET 
               WHEN    5
                   MOVE  "ADRS"            TO  MCP-WIDGET 
               WHEN    6
                   MOVE  "STNYUINYMD"      TO  MCP-WIDGET 
               WHEN    7
                   MOVE  "EDNYUINYMD"      TO  MCP-WIDGET 
               WHEN    8
                   MOVE  "SRYKA"           TO  MCP-WIDGET 
               WHEN    9
                   MOVE  "BTUNUM"          TO  MCP-WIDGET 
               WHEN    10
                   MOVE  "JOTAI"           TO  MCP-WIDGET 
               WHEN    11
                   MOVE  "CHKTESTPT"       TO  MCP-WIDGET 
               WHEN    12
                   MOVE  "SELNUM"          TO  MCP-WIDGET 
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC          SECTION.
      *
           EVALUATE    	SPA-MCP-WIDGET
               WHEN    "PTNUM"
                   MOVE    1                   TO  SPA-GMN-CUR
               WHEN    "NAME"
                   MOVE    2                   TO  SPA-GMN-CUR
               WHEN    "STAGE"
                   MOVE    3                   TO  SPA-GMN-CUR
               WHEN    "EDAGE"
                   MOVE    4                   TO  SPA-GMN-CUR
               WHEN    "ADRS"
                   MOVE    5                   TO  SPA-GMN-CUR
               WHEN    "STNYUINYMD"
                   MOVE    6                   TO  SPA-GMN-CUR
               WHEN    "EDNYUINYMD"
                   MOVE    7                   TO  SPA-GMN-CUR
               WHEN    "SRYKA"
                   MOVE    8                   TO  SPA-GMN-CUR
               WHEN    "BTUNUM"
                   MOVE    9                   TO  SPA-GMN-CUR
               WHEN    "JOTAI"
                   MOVE    11                  TO  SPA-GMN-CUR
               WHEN    "CHKTESTPT"
                   MOVE    11                  TO  SPA-GMN-CUR
           END-EVALUATE
           .
      *
       50011-INPUT-CUR-EXT.
           EXIT.
     *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラーです"            TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "全角のみで入力して下さい"  TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "年齢入力エラー"            TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "全角のみで入力して下さい"  TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "開始入院日入力エラー"      TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "終了入院日入力エラー"      TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "診療科入力エラー"          TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "病棟入力エラー"            TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "状態入力エラー"            TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "該当の番号はありません"    TO  SPA-ERRMSG
      *             
               WHEN    "0101"
                   MOVE    "開始入院日が終了年月日より大きいです" 
                                                       TO  SPA-ERRMSG
      *             
               WHEN    "0201"
                   MOVE    "対象の患者が選択されていません" 
                                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  I2ERR
           MOVE    SPA-ERRCD            TO  I2ERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  I2ERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "I20"                TO  SPA-MOTOPG
           MOVE    "I2ERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "I2ERR"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面表示処理
      *****************************************************************
       520-I2IDSET-SEC              SECTION.
      *
           EVALUATE    SPA-I2IDCD
               WHEN    "1001"
                   MOVE    "検索を開始します"
                                       TO  WRK-I2IDMSG
               WHEN    OTHER
                   MOVE    SPA-ERRCD
                                       TO  WRK-I2IDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  SPA-I2ID1-FLG
      *
           MOVE    SPACE               TO  I2ID1
           MOVE    SPA-I2IDCD          TO  I2ID1-ID1CODE
           MOVE    WRK-I2IDMSG         TO  I2ID1-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "I20"               TO  SPA-MOTOPG
           MOVE    "I2ID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "I2ID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-I2IDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    文字列左詰処理
      *****************************************************************
       800-STR-HIDARIZUME-HEN-SEC      SECTION.
      *
           MOVE    WRK-STR-LEFT    TO  IDXA
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >       500 )
      *
               IF    ( WRK-STR-LEFT (IDXA:1)
                                       NOT =   SPACE )
                   MOVE    WRK-STR-LEFT (IDXA:)
                                           TO  WRK-STR-LEFT-TMP
                   MOVE    WRK-STR-LEFT-TMP
                                           TO  WRK-STR-LEFT
                   MOVE    500             TO  IDXA
               END-IF
      *
           END-PERFORM
      *
           .
       800-STR-HIDARIZUME-HEN-EXT.
           EXIT.
      *****************************************************************
      *    システム管理読込（主キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *     
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
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
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *     
      *****************************************************************
      *    入院患者照会ビュー読込
      *****************************************************************
       900-I001-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  I001-REC
               MOVE    ZERO                TO  FLG-I001
           ELSE
               MOVE    1                   TO  FLG-I001
           END-IF
      *
           .
       900-I001-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込（主キー）
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    ZERO                TO  FLG-PTINF
               ELSE
                   MOVE    1                   TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
