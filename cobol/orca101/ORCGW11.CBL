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
       PROGRAM-ID.                               ORCGW11.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 出力先プリンタ名割り当て
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-多々納   01/11/01  予約一覧を（７）へ追加
      * 01.00.02     MCC-藤原     02/01/11  タグにして、帳票編集区分情報
      *                                     の追加
      * 01.00.03     MCC-太田     02/03/11  一部の帳票ＰＧについて
      *                                     標準提供・独自作成のいずれか
      *                                     を選択できるよう修正
      * 01.00.03     MCC-多々納   02/03/15  後発医薬品名称を追加
      * 01.00.04     MCC-多々納   02/05/02  全角チェックを追加
      * 01.00.05     NACL-森脇    02/08/19  薬剤情報を追加
      * 01.00.06     NACL-太田    02/11/05  入院用オンライン帳票を追加
      * 02.00.01     NACL-多々納  02/11/13  一括入力 
      * 02.00.02     NACL-太田    02/11/05  入院オンライン帳票を個別
      *                                     設定できるよう修正
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
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-W11.
           03  SPA-W11-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(04).
               05  SPA-GMN-CUR         PIC 9(04).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD    PIC X(09).
                   07  SPA-GMN-EDYUKYMD    PIC X(09).
                   07  SPA-GMN-PAGENO      PIC 9(01).
                   07  SPA-GMN-1031-AREA.
                       09  SPA-GMN-TBL.
      *----(01.00.03) LINE UPD START --------------------------
      *----(01.00.05) LINE UPD START --------------------------
      *                    11  SPA-GMN-TBLO        OCCURS  10.
                           11  SPA-GMN-TBL01       OCCURS  10.
                               13  SPA-GMN-TNAME   PIC X(30).
                               13  SPA-GMN-TPRTNM  PIC X(16).
                           11  SPA-GMN-TBL02       OCCURS  4.
                               13  SPA-GMN-TORGPGNM
                                                   PIC X(20).
                               13  SPA-GMN-TORGPGCHK
                                                   PIC X(01).
                               13  SPA-GMN-TCSTPGNM
                                                   PIC X(20).
                               13  SPA-GMN-TCSTPGCHK
                                                   PIC X(01).
      *----(01.00.05) LINE UPD END   --------------------------
      *----(01.00.03) LINE UPD END   --------------------------
      *                    入院帳票
                           11  SPA-GMN-TBL01-N     OCCURS  10.
                               13  SPA-GMN-TNAME-N   PIC X(30).
                               13  SPA-GMN-TPRTNM-N  PIC X(16).
                           11  SPA-GMN-TBL02-N     OCCURS  3.
                               13  SPA-GMN-TORGPGNM-N
                                                   PIC X(20).
                               13  SPA-GMN-TORGPGCHK-N
                                                   PIC X(01).
                               13  SPA-GMN-TCSTPGNM-N
                                                   PIC X(20).
                               13  SPA-GMN-TCSTPGCHK-N
                                                   PIC X(01).
                   07  SPA-GMN-1030-AREA.
                       09  SPA-GMN-SYOHOGEPRTFLG-G.
                           11  SPA-GMN-SYOHOGEPRTFLG
                                                  PIC X(01).
                           11  SPA-GMN-F1         PIC X(01).
                           11  SPA-GMN-SYOHOGEPRTFLGMEI
                                                  PIC X(10).
      *                                        
                       09  SPA-GMN-SYOHOGEPRTFLGLST    OCCURS  2.
                           11  SPA-GMN-SYOHOGEPRTFLGL
                                              PIC X(01).
                           11  SPA-GMN-F1L        PIC X(01).
                           11  SPA-GMN-SYOHOGEPRTFLGMEIL
                                                  PIC X(10).
                       09  SPA-GMN-SYOHOGEPRTFLG-MAX
                                                  PIC 9(02).
      *
                       09  SPA-GMN-SYOHODSPNAME   PIC X(10).
      *
      *    フラグエリア
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
           03  FLG-ENTRYCHK                        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                               PIC 9(04).
           03  IDY                               PIC 9(04).
           03  IDZ                               PIC 9(04).
           03  IDZ1                              PIC 9(04).
      *----(01.00.03) LINE ADD START --------------------------
           03  IDZ2                              PIC 9(04).
      *----(01.00.03) LINE ADD END   --------------------------
           03  IDX1                              PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-WIDMSG          PIC X(70).
      *----(01.00.03) LINE UPD START --------------------------
      *    03  WRK-KBNCD           PIC 9(01).
           03  WRK-KBNCD           PIC 9(08).
      *----(01.00.03) LINE UPD END   --------------------------
           03  WRK-MAX-X.
               05  WRK-MAX         PIC 9(04).                
           03  WRK-YMD             PIC X(09). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
      *----(01.00.03) LINE ADD START --------------------------
      *----(01.00.05) LINE UPD START --------------------------
           03  WRK-ORCAORGCHK-G  OCCURS   4.
               05  WRK-ORCAORGCHK  PIC X(01).
           03  WRK-ORCACSTCHK-G  OCCURS   4.
               05  WRK-ORCACSTCHK  PIC X(01).
      *----(01.00.05) LINE UPD END   --------------------------
      *----(01.00.03) LINE ADD END   --------------------------
      *
           03  WRK-MCP-WIDGET      PIC X(64).
           03  WRK-KANACHK-MAE-INPUT
                                   PIC X(400).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
       01  WRK-WIDGET-AREA.
           03  WRK-WIDGET          PIC X(20).
           03  WRK-WIDGET-R10      REDEFINES  WRK-WIDGET.
               05  FILLER          PIC X(10).
               05  WRK-WIDGET10    PIC 9(02).
               05  FILLER          PIC X(08).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *----(01.00.03) LINE UPD START --------------------------
      *    出力先プリンタ名割り当て情報
      *    COPY  "CPSK1031.INC".
      *
      *    COPY  "CPSK1030.INC".      
      *    帳票編集区分情報
           COPY  "CPSK1030.INC".      
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *    帳票プログラム選択情報
           COPY  "CPSK1032.INC".
      *    出力先プリンタ名割り当て情報（入院）
           COPY  "CPSK1034.INC".
      *    帳票プログラム選択情報 （入院）
           COPY  "CPSK1035.INC".
      *----(01.00.03) LINE UPD END   --------------------------
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "W15.INC".
           COPY    "W20.INC".
           COPY    "W21.INC".
           COPY    "W22.INC".
           COPY    "W23.INC".
           COPY    "W24.INC".
           COPY    "W25.INC".
           COPY    "W26.INC".
           COPY    "W27.INC".
           COPY    "W98.INC".
           COPY    "W99.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
      *
       PROCEDURE                                 DIVISION    USING
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
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W11
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
           MOVE    SPA-W11         TO  SPA-FREE
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "WERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END         =   1
                   GO  TO  100-INIT-EXT
               END-IF 
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               PERFORM 510-GSRAUTH-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W11    "           TO  MCP-WINDOW.
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
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
               WHEN    "WID1"
                   PERFORM 330-WID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
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
           INITIALIZE              SPA-W11-AREA
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
      *
           EVALUATE    SPA-W01-KANRICD
      *
      *    帳票編集区分情報初期処理
           WHEN    "1030"
               PERFORM 3101-SYS1030-SYOKI-SEC
      *
      *    出力先プリンタ割り当て情報
           WHEN    "1031"
               PERFORM 3101-SYS1031-SYOKI-SEC
           END-EVALUATE
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集区分情報初期処理
      *****************************************************************
       3101-SYS1030-SYOKI-SEC          SECTION.
      *
           MOVE    "0"                 TO  SPA-GMN-SYOHOGEPRTFLGL    (1)
           MOVE    "表示しない"        TO  SPA-GMN-SYOHOGEPRTFLGMEIL (1)
           MOVE    "1"                 TO  SPA-GMN-SYOHOGEPRTFLGL    (2)
           MOVE    "表示する"          TO  SPA-GMN-SYOHOGEPRTFLGMEIL (2)
           MOVE    2                   TO  SPA-GMN-SYOHOGEPRTFLG-MAX 
      *
           MOVE    SPACE               TO  SYSKANRI-REC 
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1030"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF  (   FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-1030-REC
               MOVE    SYS-1030-SYOHOGEPRTFLG
                                       TO  SPA-GMN-SYOHOGEPRTFLG
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL ( IDY >   SPA-GMN-SYOHOGEPRTFLG-MAX )
                   IF    ( SPA-GMN-SYOHOGEPRTFLG 
                                   =   SPA-GMN-SYOHOGEPRTFLGL (IDY) )
                       MOVE    SPA-GMN-SYOHOGEPRTFLGLST (IDY)
                                       TO  SPA-GMN-SYOHOGEPRTFLG-G
                       MOVE    SPA-GMN-SYOHOGEPRTFLG-MAX
                                       TO  IDY
                   END-IF 
               END-PERFORM
      *        後発医薬品表示名
               MOVE    SYS-1030-SYOHODSPNAME
                                       TO  SPA-GMN-SYOHODSPNAME
           ELSE
               MOVE    SPA-GMN-SYOHOGEPRTFLGL (1)
                                       TO  SPA-GMN-SYOHOGEPRTFLG
           END-IF
      *
           MOVE    101                 TO  SPA-GMN-CUR
      *
           .
       3101-SYS1030-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    出力先プリンタ割り当て情報
      *****************************************************************
       3101-SYS1031-SYOKI-SEC          SECTION.
      *
      *    帳票名初期処理
           PERFORM 3101-PRTNAME-SYOKI-SEC
      *
           MOVE    SPACE               TO  SYSKANRI-REC 
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1031"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
               PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL  IDX  >       10
                   MOVE    SYS-1031-PRTNM (IDX)
                                       TO  SPA-GMN-TPRTNM (IDX)
               END-PERFORM
      *
           END-IF
      *
           PERFORM 3103-PRGNAME-SYOKI-SEC
      *
           IF    ( SPA-BEDSU   >   ZERO )
               CONTINUE
           ELSE
               GO  TO  3101-SYS1031-SYOKI-EXT
           END-IF
      *
      *    -- 入院帳票 --
      *
      *    帳票名初期処理
           PERFORM 3101-NYU-PRTNAME-SYOKI-SEC
      *
           MOVE    SPACE               TO  SYSKANRI-REC 
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1034"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1034-REC
               PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL  IDX  >       10
                   MOVE    SYS-1034-PRTNM (IDX)
                                       TO  SPA-GMN-TPRTNM-N (IDX)
               END-PERFORM
      *
           END-IF
      *
           PERFORM 3103-NYU-PRGNAME-SYOKI-SEC
      *
           MOVE    1                   TO  SPA-GMN-CUR
           .
       3101-SYS1031-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    帳票名初期処理
      *****************************************************************
       3101-PRTNAME-SYOKI-SEC          SECTION.
      *
           MOVE    "診療録（カルテ１号紙）"
                                       TO  SPA-GMN-TNAME (1)  
           MOVE    "処方せん（院外）"  TO  SPA-GMN-TNAME (2)  
           MOVE    "請求書兼領収書"    TO  SPA-GMN-TNAME (3)  
           MOVE    "診療報酬明細書（レセプト）"
                                       TO  SPA-GMN-TNAME (4)  
           MOVE    "総括表／保険請求書"
                                       TO  SPA-GMN-TNAME (5)  
           MOVE    "各種統計表"        TO  SPA-GMN-TNAME (6)
           MOVE    "予約一覧／予約患者一覧"
                                       TO  SPA-GMN-TNAME (7)
           MOVE    "薬剤情報提供書"    TO  SPA-GMN-TNAME (8)
           MOVE    "支払証明書"        TO  SPA-GMN-TNAME (9)
      *
           .
       3101-PRTNAME-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    帳票名初期処理
      *****************************************************************
       3101-NYU-PRTNAME-SYOKI-SEC      SECTION.
      *
      **   入院帳票
           MOVE    "診療録（カルテ１号紙）"
                                       TO  SPA-GMN-TNAME-N (1)
           MOVE    "退院証明書"        TO  SPA-GMN-TNAME-N (2)
           MOVE    "請求書兼領収書"    TO  SPA-GMN-TNAME-N (3)
      *
           .
       3101-NYU-PRTNAME-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    帳票プログラム名初期処理
      *****************************************************************
       3103-PRGNAME-SYOKI-SEC          SECTION.
      *
           MOVE    "ORCHC01"       TO  SPA-GMN-TORGPGNM (1)
           MOVE    "ORCHC19"       TO  SPA-GMN-TORGPGNM (2)
           MOVE    "ORCHC03"       TO  SPA-GMN-TORGPGNM (3)
           MOVE    "ORCHC30"       TO  SPA-GMN-TORGPGNM (4)
           MOVE    "T"             TO  SPA-GMN-TORGPGCHK(1)
           MOVE    "T"             TO  SPA-GMN-TORGPGCHK(2)
           MOVE    "T"             TO  SPA-GMN-TORGPGCHK(3)
           MOVE    "T"             TO  SPA-GMN-TORGPGCHK(4)
           MOVE    "F"             TO  SPA-GMN-TCSTPGCHK(1)
           MOVE    "F"             TO  SPA-GMN-TCSTPGCHK(2)
           MOVE    "F"             TO  SPA-GMN-TCSTPGCHK(3)
           MOVE    "F"             TO  SPA-GMN-TCSTPGCHK(4)
      *
      *    帳票プログラム選択情報
           MOVE    SPACE               TO  SYSKANRI-REC 
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1032"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-SELECT-SEC
      *
      *    システム管理マスタ読込
           PERFORM 900-SYSKANRI-READ-SEC
      *
           PERFORM VARYING IDZ2    FROM    1   BY  1
                   UNTIL ( IDZ2    >   4   )
                      OR ( FLG-SYSKANRI  NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  SYS-1032-REC

               MOVE    SYS-1032-ORCAORGNM
                                       TO  SPA-GMN-TORGPGNM  (IDZ2)
               MOVE    SYS-1032-ORCAORGCHK
                                       TO  SPA-GMN-TORGPGCHK (IDZ2)
               MOVE    SYS-1032-ORCACSTNM
                                       TO  SPA-GMN-TCSTPGNM  (IDZ2)
               MOVE    SYS-1032-ORCACSTCHK
                                       TO  SPA-GMN-TCSTPGCHK (IDZ2)
      *
      *        システム管理マスタ読込
               PERFORM 900-SYSKANRI-READ-SEC
      *
           END-PERFORM
      *
           PERFORM 900-SYSKANRI-CLOSE-SEC
           .
      *
       3103-PRGNAME-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    入院帳票プログラム名初期処理
      *****************************************************************
       3103-NYU-PRGNAME-SYOKI-SEC      SECTION.
      *
           MOVE    "ORCHCN01"      TO  SPA-GMN-TORGPGNM-N (1)
           MOVE    "ORCHCN02"      TO  SPA-GMN-TORGPGNM-N (2)
           MOVE    "ORCHCN03"      TO  SPA-GMN-TORGPGNM-N (3)
           MOVE    "T"             TO  SPA-GMN-TORGPGCHK-N(1)
           MOVE    "T"             TO  SPA-GMN-TORGPGCHK-N(2)
           MOVE    "T"             TO  SPA-GMN-TORGPGCHK-N(3)
           MOVE    "F"             TO  SPA-GMN-TCSTPGCHK-N(1)
           MOVE    "F"             TO  SPA-GMN-TCSTPGCHK-N(2)
           MOVE    "F"             TO  SPA-GMN-TCSTPGCHK-N(3)
      *
      *    帳票プログラム選択情報
           MOVE    SPACE               TO  SYSKANRI-REC 
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1035"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           PERFORM 900-SYSKANRI-SELECT-SEC
      *
      *    システム管理マスタ読込
           PERFORM 900-SYSKANRI-READ-SEC
      *
      *
           PERFORM VARYING IDZ2    FROM    1   BY  1
                   UNTIL ( IDZ2    >   3   )
                      OR ( FLG-SYSKANRI  NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  SYS-1035-REC
      *
               MOVE    SYS-1035-ORCAORGNM
                                       TO  SPA-GMN-TORGPGNM-N  (IDZ2)
               MOVE    SYS-1035-ORCAORGCHK
                                       TO  SPA-GMN-TORGPGCHK-N (IDZ2)
               MOVE    SYS-1035-ORCACSTNM
                                       TO  SPA-GMN-TCSTPGNM-N  (IDZ2)
               MOVE    SYS-1035-ORCACSTCHK
                                       TO  SPA-GMN-TCSTPGCHK-N (IDZ2)
      *
      *        システム管理マスタ読込
               PERFORM 900-SYSKANRI-READ-SEC
      *
           END-PERFORM
      *
           PERFORM 900-SYSKANRI-CLOSE-SEC
           .
      *
       3103-NYU-PRGNAME-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF      SPA-WID1-FLG    =   "OK"
               PERFORM 490-KOUSHIN-SEC
           ELSE
               EVALUATE    SPA-W01-KANRICD
                   WHEN    "1031"
                       MOVE    1                   TO  SPA-GMN-CUR
                   WHEN    "1030"
                       MOVE    101                 TO  SPA-GMN-CUR
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
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
      *    戻る
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE   "CHANGE"             TO  MCP-PUTTYPE
               PERFORM  210-BACK
      *    標準プログラム選択時
           WHEN    "CLICKED"       ALSO    "ORCAORGCHK01"
           WHEN    "CLICKED"       ALSO    "ORCAORGCHK02"
           WHEN    "CLICKED"       ALSO    "ORCAORGCHK03"
           WHEN    "CLICKED"       ALSO    "ORCAORGCHK04"
               MOVE    MCP-WIDGET  TO      WRK-WIDGET
               PERFORM  4101-ORCAORGCHK-CHK-SEC
      *    カスタマイズプログラム選択時
           WHEN    "CLICKED"       ALSO    "ORCACSTCHK01"
           WHEN    "CLICKED"       ALSO    "ORCACSTCHK02"
           WHEN    "CLICKED"       ALSO    "ORCACSTCHK03"
           WHEN    "CLICKED"       ALSO    "ORCACSTCHK04"
               MOVE    MCP-WIDGET  TO      WRK-WIDGET
               PERFORM  4101-ORCACSTCHK-CHK-SEC
      *    標準プログラム選択時 ＝ 入院 ＝
           WHEN    "CLICKED"       ALSO    "ORCAORGCHK01N"
           WHEN    "CLICKED"       ALSO    "ORCAORGCHK02N"
           WHEN    "CLICKED"       ALSO    "ORCAORGCHK03N"
               MOVE    MCP-WIDGET  TO      WRK-WIDGET
               PERFORM  4101-NYU-ORCAORGCHK-CHK-SEC
      *    カスタマイズプログラム選択時 ＝ 入院 ＝
           WHEN    "CLICKED"       ALSO    "ORCACSTCHK01N"
           WHEN    "CLICKED"       ALSO    "ORCACSTCHK02N"
           WHEN    "CLICKED"       ALSO    "ORCACSTCHK03N"
               MOVE    MCP-WIDGET  TO      WRK-WIDGET
               PERFORM  4101-NYU-ORCACSTCHK-CHK-SEC
      *    確定
           WHEN    "CLICKED"       ALSO    "B12"
               PERFORM  410-KAKUTEI-SEC
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
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC       SECTION.
      *
      *    出力先プリンタ割り当て
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   10
               MOVE    W11-PRTNM (IDX)     TO  SPA-GMN-TPRTNM (IDX)
           END-PERFORM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   4
               MOVE    W11-ORCACSTNM (IDX)
                                           TO  SPA-GMN-TCSTPGNM (IDX)
           END-PERFORM
      *
      *    出力先プリンタ割り当て
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   10
               MOVE    W11-PRTNM (IDX)     TO  SPA-GMN-TPRTNM (IDX)
           END-PERFORM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   4
               MOVE    W11-ORCACSTNM (IDX)
                                           TO  SPA-GMN-TCSTPGNM (IDX)
           END-PERFORM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   10
               MOVE    W11-PRTNM-N (IDX)   TO  SPA-GMN-TPRTNM-N (IDX)
           END-PERFORM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   3
               MOVE    W11-ORCACSTNM-N (IDX)
                                           TO  SPA-GMN-TCSTPGNM-N (IDX)
           END-PERFORM
      *
      *    帳票編集区分
           MOVE    W11-SYOHOGEPRTFLG   TO  SPA-GMN-SYOHOGEPRTFLG-G 
           MOVE    W11-SYOHODSPNAME    TO  SPA-GMN-SYOHODSPNAME
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC       SECTION.
      *
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1031"
      *            出力先プリンタ割り当て
                   PERFORM 4101-PRTNM-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4101-CSTPGNM-SET-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4101-NYU-PRTNM-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4101-NYU-CSTPGNM-SET-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
               WHEN    "1030"
      *            帳票編集区分
                   PERFORM 4100-SYOHOGEPRTFLG-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
                   PERFORM 4200-SYOHODSPNAME-CHK-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO      4102-KIHON-CHK-EXT
                   END-IF
           END-EVALUATE
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W11"               TO  SPA-MOTOPG
      *
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
      *    処方せんＧＥ表示区分チェック
      *****************************************************************
       4100-SYOHOGEPRTFLG-CHK-SEC       SECTION.
      *
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       SPA-GMN-SYOHOGEPRTFLG-MAX
               IF      SPA-GMN-SYOHOGEPRTFLG 
                                   =   SPA-GMN-SYOHOGEPRTFLGL (IDY)
                   MOVE    SPA-GMN-SYOHOGEPRTFLGLST (IDY)
                                           TO  SPA-GMN-SYOHOGEPRTFLG-G
                   MOVE    SPA-GMN-SYOHOGEPRTFLG-MAX
                                           TO  IDY
               END-IF 
           END-PERFORM
      *
           IF      SPA-GMN-SYOHOGEPRTFLGMEI    =   SPACE
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    101                 TO  SPA-GMN-CUR
           END-IF
      *
           .
       4100-SYOHOGEPRTFLG-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    後発医薬品表示名チェック
      *****************************************************************
       4200-SYOHODSPNAME-CHK-SEC       SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN-SYOHODSPNAME    TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
      *        全角以外エラー
               MOVE    "0005"              TO  SPA-ERRCD
               MOVE    102                 TO  SPA-GMN-CUR
           END-IF
      *
           .
       4200-SYOHODSPNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　出力先プリンタ名チェック
      *****************************************************************
       4101-PRTNM-CHK-SEC                         SECTION.
      *
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   10  )
      *
               IF    ( SPA-GMN-TNAME (IDX)     =   SPACE )
               AND   ( SPA-GMN-TPRTNM(IDX) NOT =   SPACE )
                  MOVE     SPACE       TO  SPA-GMN-TPRTNM(IDX)
               END-IF
      *
               MOVE    SPA-GMN-TPRTNM(IDX)
                                       TO  WRK-KANACHK-MAE-INPUT
               PERFORM     800-ENRTRY-CHK-SEC
               IF  ( FLG-ENTRYCHK      NOT =   1 )
                   COMPUTE SPA-GMN-CUR =   IDX
                   MOVE    "0006"          TO  SPA-ERRCD
                   GO  TO  4101-PRTNM-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
           .
       4101-PRTNM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　カスタマイズプログラム名設定処理
      *****************************************************************
       4101-CSTPGNM-SET-SEC            SECTION.
      *
           .
      *
       4101-CSTPGNM-SET-EXT.
           EXIT.
      *****************************************************************
      *  　出力先プリンタ名チェック
      *****************************************************************
       4101-NYU-PRTNM-CHK-SEC          SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   10  )
               IF      SPA-GMN-TNAME-N (IDX)      =   SPACE
               AND     SPA-GMN-TPRTNM-N (IDX) NOT =   SPACE
                   MOVE    SPACE       TO SPA-GMN-TPRTNM-N (IDX)
               END-IF
      *
               MOVE    SPA-GMN-TPRTNM-N(IDX)
                                       TO  WRK-KANACHK-MAE-INPUT
               PERFORM     800-ENRTRY-CHK-SEC
               IF  ( FLG-ENTRYCHK      NOT =   1 )
                   COMPUTE SPA-GMN-CUR =   IDX     +   50
                   MOVE    "0006"          TO  SPA-ERRCD
                   GO  TO  4101-NYU-PRTNM-CHK-EXT
               END-IF
      *
           END-PERFORM
      *
           .
       4101-NYU-PRTNM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *  　カスタマイズプログラム名設定処理
      *****************************************************************
       4101-NYU-CSTPGNM-SET-SEC        SECTION.
      *
      *
           .
      *
       4101-NYU-CSTPGNM-SET-EXT.
           EXIT.
      *****************************************************************
      *  　標準プログラム選択時チェック
      *****************************************************************
       4101-ORCAORGCHK-CHK-SEC         SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET10    TO  IDX1
           IF    ( SPA-GMN-TNAME (IDX1)    =   SPACE )
               MOVE    "T"         TO  SPA-GMN-TORGPGCHK (IDX1)
           ELSE
               MOVE    W11-ORCAORGCHK(IDX1)
                                   TO  SPA-GMN-TORGPGCHK (IDX1)
           END-IF
      *
      *
           .
       4101-ORCAORGCHK-CHK-EXT.
           EXIT.
      *****************************************************************
      *  　カスタマイズプログラム選択時
      *****************************************************************
       4101-ORCACSTCHK-CHK-SEC         SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET10    TO  IDX1
           IF    ( SPA-GMN-TNAME (IDX1)    =   SPACE )
               MOVE    "F"         TO  SPA-GMN-TCSTPGCHK (IDX1)
           ELSE
               MOVE    W11-ORCACSTCHK(IDX1)
                                   TO  SPA-GMN-TCSTPGCHK (IDX1)
           END-IF
      *
      *
           .
       4101-ORCACSTCHK-CHK-EXT.
           EXIT.
      *****************************************************************
      *  　標準プログラム選択時チェック
      *****************************************************************
       4101-NYU-ORCAORGCHK-CHK-SEC     SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET10    TO  IDX1
           IF    ( SPA-GMN-TNAME-N (IDX1)    =   SPACE )
               MOVE    "T"         TO  SPA-GMN-TORGPGCHK-N (IDX1)
           ELSE
               MOVE    W11-ORCAORGCHK-N (IDX1)
                                   TO  SPA-GMN-TORGPGCHK-N (IDX1)
           END-IF
      *
      *
           .
       4101-NYU-ORCAORGCHK-CHK-EXT.
           EXIT.
      *****************************************************************
      *  　カスタマイズプログラム選択時
      *****************************************************************
       4101-NYU-ORCACSTCHK-CHK-SEC     SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
           MOVE    WRK-WIDGET10    TO  IDX1
           IF    ( SPA-GMN-TNAME-N (IDX1)    =   SPACE )
               MOVE    "F"         TO  SPA-GMN-TCSTPGCHK-N (IDX1)
           ELSE
               MOVE    W11-ORCACSTCHK-N (IDX1)
                                   TO  SPA-GMN-TCSTPGCHK-N (IDX1)
           END-IF
      *
      *
           .
       4101-NYU-ORCACSTCHK-CHK-EXT.
           EXIT.
      *****************************************************************
      *    確定
      *****************************************************************
       410-KAKUTEI-SEC           SECTION.
      *
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
           IF      SPA-ERRCD        NOT  =   SPACE
               GO  TO  410-KAKUTEI-EXT
           END-IF
      *
           PERFORM 4901-KANRENCHK-SEC
      *
           IF      SPA-ERRCD        NOT  =   SPACE
               GO  TO  410-KAKUTEI-EXT
           END-IF
      *
           IF      SPA-ERRCD        =   SPACE
               MOVE    "1001"           TO  SPA-WIDCD
           END-IF
           .
       410-KAKUTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
           EVALUATE    SPA-W01-KANRICD
           WHEN    "1031"
               PERFORM 490-SYS-1031-KOUSHIN-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  490-KOUSHIN-EXT
               END-IF
      *
               PERFORM VARYING IDZ2    FROM    1   BY  1
                       UNTIL   ( IDZ2  >   4 )
                   PERFORM 490-SYS-1032-KOUSHIN-SEC
                   IF    ( SPA-ERRCD   NOT =   SPACE )
                       GO  TO  490-KOUSHIN-EXT
                   END-IF
               END-PERFORM
      *
               IF    ( SPA-BEDSU       >   ZERO )
      *
                   PERFORM 490-SYS-1034-KOUSHIN-SEC
                   IF    ( SPA-ERRCD   NOT =   SPACE )
                       GO  TO  490-KOUSHIN-EXT
                   END-IF
      *
                   PERFORM VARYING IDZ2    FROM    1   BY  1
                           UNTIL   ( IDZ2  >   3 )
                       PERFORM 490-SYS-1035-KOUSHIN-SEC
                       IF    ( SPA-ERRCD   NOT =   SPACE )
                           GO  TO  490-KOUSHIN-EXT
                       END-IF
                   END-PERFORM
               END-IF
           WHEN    "1030"
               PERFORM 490-SYS-1030-KOUSHIN-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  490-KOUSHIN-EXT
               END-IF
           END-EVALUATE
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       490-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *       出力先プリンタ割り当て情報
      *****************************************************************
       490-SYS-1031-KOUSHIN-SEC    SECTION.
      *
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                      SYS-1031-REC
           MOVE   "1031"               TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1031-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1031-EDYUKYMD
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL ( IDX >       10 )
               MOVE    SPA-GMN-TPRTNM (IDX)
                                       TO  SYS-1031-PRTNM (IDX)
           END-PERFORM
      *
           MOVE    SYS-1031-REC        TO  SYSKANRI-REC
      *
           PERFORM 490-SYSKANRI-KOUSHIN-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "4001"          TO  SPA-ERRCD
               GO  TO  490-SYS-1031-KOUSHIN-EXT
           END-IF
      *
           .
      *
       490-SYS-1031-KOUSHIN-EXT.
           EXIT.
      *****************************************************************
      *       帳票プログラム選択情報
      *****************************************************************
       490-SYS-1032-KOUSHIN-SEC        SECTION.
      *
           MOVE    IDZ2                TO  WRK-KBNCD
      *
           MOVE    SPACE               TO  SYS-1032-REC
           INITIALIZE                      SYS-1032-REC
           MOVE    "1032"              TO  SYS-1032-KANRICD
           MOVE    WRK-KBNCD           TO  SYS-1032-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1032-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1032-EDYUKYMD
      *
           MOVE    SPA-GMN-TORGPGNM (IDZ2)
                                       TO  SYS-1032-ORCAORGNM
           MOVE    SPA-GMN-TORGPGCHK(IDZ2)
                                       TO  SYS-1032-ORCAORGCHK
           MOVE    SPA-GMN-TCSTPGNM (IDZ2)
                                       TO  SYS-1032-ORCACSTNM
           MOVE    SPA-GMN-TCSTPGCHK(IDZ2)
                                       TO  SYS-1032-ORCACSTCHK
      *
           MOVE    SYS-1032-REC        TO  SYSKANRI-REC
      *
           PERFORM 490-SYSKANRI-KOUSHIN-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "4002"          TO  SPA-ERRCD
               GO  TO  490-SYS-1032-KOUSHIN-EXT
           END-IF
      *
           .
      *
       490-SYS-1032-KOUSHIN-EXT.
           EXIT.
      *****************************************************************
      *       出力先プリンタ割り当て情報（入院）
      *****************************************************************
       490-SYS-1034-KOUSHIN-SEC    SECTION.
      *
           MOVE    SPACE               TO  SYS-1034-REC
           INITIALIZE                      SYS-1034-REC
           MOVE   "1034"               TO  SYS-1034-KANRICD
           MOVE    "*"                 TO  SYS-1034-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1034-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1034-EDYUKYMD
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL ( IDX >       10 )
               MOVE    SPA-GMN-TPRTNM-N (IDX)
                                       TO  SYS-1034-PRTNM (IDX)
           END-PERFORM
      *
           MOVE    SYS-1034-REC        TO  SYSKANRI-REC
      *
           PERFORM 490-SYSKANRI-KOUSHIN-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "4003"          TO  SPA-ERRCD
               GO  TO  490-SYS-1034-KOUSHIN-EXT
           END-IF
      *
           .
      *
       490-SYS-1034-KOUSHIN-EXT.
           EXIT.
      *****************************************************************
      *       帳票プログラム選択情報（入院）
      *****************************************************************
       490-SYS-1035-KOUSHIN-SEC        SECTION.
      *
           MOVE    IDZ2                TO  WRK-KBNCD
      *
           MOVE    SPACE               TO  SYS-1035-REC
           INITIALIZE                      SYS-1035-REC
           MOVE    "1035"              TO  SYS-1035-KANRICD
           MOVE    WRK-KBNCD           TO  SYS-1035-KBNCD
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1035-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1035-EDYUKYMD
      *
           MOVE    SPA-GMN-TORGPGNM-N (IDZ2)
                                       TO  SYS-1035-ORCAORGNM
           MOVE    SPA-GMN-TORGPGCHK-N(IDZ2)
                                       TO  SYS-1035-ORCAORGCHK
           MOVE    SPA-GMN-TCSTPGNM-N (IDZ2)
                                       TO  SYS-1035-ORCACSTNM
           MOVE    SPA-GMN-TCSTPGCHK-N(IDZ2)
                                       TO  SYS-1035-ORCACSTCHK
      *
           MOVE    SYS-1035-REC        TO  SYSKANRI-REC
      *
           PERFORM 490-SYSKANRI-KOUSHIN-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "4004"          TO  SPA-ERRCD
               GO  TO  490-SYS-1035-KOUSHIN-EXT
           END-IF
      *
           .
      *
       490-SYS-1035-KOUSHIN-EXT.
           EXIT.
      *****************************************************************
      *       帳票編集区分
      *****************************************************************
       490-SYS-1030-KOUSHIN-SEC    SECTION.
      *
           MOVE    SPACE               TO  SYS-1030-REC
           INITIALIZE                      SYS-1030-REC
           MOVE    "1030"              TO  SYS-1030-KANRICD
           MOVE    "*"                 TO  SYS-1030-KBNCD
      *
           MOVE    SPA-W01-STYUKYMD    TO  SYS-1030-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD    TO  SYS-1030-EDYUKYMD
           MOVE    SPA-GMN-SYOHOGEPRTFLG
                                       TO SYS-1030-SYOHOGEPRTFLG
      *    後発医薬品表示名称
           MOVE    SPA-GMN-SYOHODSPNAME
                                       TO  SYS-1030-SYOHODSPNAME
      *
           MOVE    SYS-1030-REC        TO  SYSKANRI-REC
      *
           PERFORM 490-SYSKANRI-KOUSHIN-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "4005"          TO  SPA-ERRCD
               GO  TO  490-SYS-1030-KOUSHIN-EXT
           END-IF
           .
      *
       490-SYS-1030-KOUSHIN-EXT.
           EXIT.
      *****************************************************************
      *       システム管理マスタ更新処理
      *****************************************************************
       490-SYSKANRI-KOUSHIN-SEC        SECTION.
      *
           MOVE    SPA-W01-STYUKYMD    TO  ORC-DBYMD
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF  (   FLG-SYSKANRI        =   ZERO )
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           .
      *
       490-SYSKANRI-KOUSHIN-EXT.
           EXIT.
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4901-KANRENCHK-SEC           SECTION.
      *
           MOVE    SPACE                TO  SPA-ERRCD
      *
      *----(01.00.03) LINE ADD START --------------------------
      *    独自開発プログラム名チェック処理
           IF  ( SPA-W01-KANRICD   =   "1031" )
               PERFORM     4901-CSTPGNM-CHK-SEC
               IF    ( SPA-ERRCD   NOT =   SPACE )
                   GO  TO  4901-KANRENCHK-EXT
               END-IF
      *
           END-IF
      *----(01.00.03) LINE ADD END   --------------------------
           .
       4901-KANRENCHK-EXT.
           EXIT.
      *
      *----(01.00.03) LINE ADD START --------------------------
      *----(01.00.05) LINE UPD START --------------------------
      *****************************************************************
      *    独自開発プログラム名チェック処理
      *****************************************************************
       4901-CSTPGNM-CHK-SEC        SECTION.
      *
           PERFORM VARYING IDZ2    FROM    1   BY  1
                   UNTIL   ( IDZ2  >   4 )
      *
               IF  ( SPA-GMN-TCSTPGNM  (IDZ2)     =   SPACE )
                   IF  ( W11-ORCACSTCHK (IDZ2)    =   "F" )
                       CONTINUE
                   ELSE
                       MOVE    "0004"  TO  SPA-ERRCD
                       COMPUTE SPA-GMN-CUR =   IDZ2    +   10
                       MOVE    4       TO  IDZ2
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           PERFORM VARYING IDZ2    FROM    1   BY  1
                   UNTIL   ( IDZ2  >   3 )
      *
               IF  ( SPA-GMN-TCSTPGNM-N  (IDZ2)    =   SPACE )
                   IF  ( W11-ORCACSTCHK-N (IDZ2)   =   "F" )
                       CONTINUE
                   ELSE
                       MOVE    "0004"  TO  SPA-ERRCD
                       COMPUTE SPA-GMN-CUR =   IDZ2    +   60
                       MOVE    4       TO  IDZ2
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
      *
       4901-CSTPGNM-CHK-EXT.
           EXIT.
      *
      *----(01.00.05) LINE UPD END   --------------------------
      *----(01.00.03) LINE ADD END   --------------------------
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           EVALUATE  WRK-YMD(1:8)
               WHEN  ZERO
                   MOVE  ZERO                    TO  WRK-SYMD
                   MOVE  WRK-YMD(1:8)            TO  WRK-HENYMDG
               WHEN  "99999999"
                   MOVE  ALL "9"                 TO  WRK-SYMD
                   MOVE  WRK-YMD(1:8)            TO  WRK-HENYMDG  
               WHEN    OTHER
                   IF      WRK-YMD  (1:7)  NOT NUMERIC
                       INSPECT     WRK-YMD      REPLACING   ALL " "
                                                BY          "0"
                       MOVE    WRK-YMD(1:1)      TO  WRK-WGO
                       MOVE    WRK-YMD(2:2)      TO  WRK-WYY
                       MOVE    WRK-YMD(5:2)      TO  WRK-WMM
                       MOVE    WRK-YMD(8:2)      TO  WRK-WDD
                   ELSE
                       MOVE    WRK-YMD(1:7)      TO  WRK-WYMD 
                   END-IF
      *
                   INITIALIZE                      STS-AREA-DAY
                   INITIALIZE                      LNK-DAY1-AREA
                   MOVE    "12"                TO  LNK-DAY1-IRAI
                   MOVE    ZERO                TO  LNK-DAY1-YMD
                   MOVE    WRK-WYMD            TO  LNK-DAY1-YMD(2:7)
                   CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY1-AREA
                   IF      STS-DAY-RC1     NOT =   ZERO
                       MOVE    "0002"          TO  SPA-ERRCD
                   ELSE
                       MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
                       PERFORM 5002-HIZUKE-HEN-SEC
                   END-IF
           END-EVALUATE        
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   ZERO
               MOVE    WRK-SYMD (1:8)      TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
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
           PERFORM 510-GSRAUTH-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-WIDCD       NOT =   SPACE
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W11    "           TO  MCP-WINDOW.
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
      *     
           MOVE    SPACE               TO  W11
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       10
               MOVE    SPA-GMN-TPRTNM  (IDX)   TO  W11-PRTNM  (IDX)
               MOVE    SPA-GMN-TNAME   (IDX)   TO  W11-DSPNAME(IDX)
           END-PERFORM   
      *
           PERFORM VARYING     IDZ2     FROM    1   BY  1
                   UNTIL       IDZ2     >       4
               MOVE    SPA-GMN-TORGPGNM  (IDZ2)
                                        TO  W11-ORCAORGNM  (IDZ2)
               MOVE    SPA-GMN-TCSTPGNM  (IDZ2)
                                        TO  W11-ORCACSTNM  (IDZ2)
      *
               MOVE    SPA-GMN-TORGPGCHK (IDZ2)
                                        TO  W11-ORCAORGCHK (IDZ2)
      *
               MOVE    SPA-GMN-TCSTPGCHK (IDZ2)
                                        TO  W11-ORCACSTCHK (IDZ2)
           END-PERFORM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >       10
               MOVE    SPA-GMN-TPRTNM-N  (IDX) TO  W11-PRTNM-N  (IDX)
               MOVE    SPA-GMN-TNAME-N   (IDX) TO  W11-DSPNAME-N(IDX)
           END-PERFORM   
      *
           PERFORM VARYING     IDZ2     FROM    1   BY  1
                   UNTIL       IDZ2     >       3
               MOVE    SPA-GMN-TORGPGNM-N  (IDZ2)
                                        TO  W11-ORCAORGNM-N  (IDZ2)
               MOVE    SPA-GMN-TCSTPGNM-N  (IDZ2)
                                        TO  W11-ORCACSTNM-N  (IDZ2)
      *
               MOVE    SPA-GMN-TORGPGCHK-N (IDZ2)
                                        TO  W11-ORCAORGCHK-N (IDZ2)
      *
               MOVE    SPA-GMN-TCSTPGCHK-N (IDZ2)
                                        TO  W11-ORCACSTCHK-N (IDZ2)
           END-PERFORM
      *
           MOVE    SPA-GMN-SYOHOGEPRTFLG-G   TO  W11-SYOHOGEPRTFLG
      *
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >       SPA-GMN-SYOHOGEPRTFLG-MAX
               MOVE    SPA-GMN-SYOHOGEPRTFLGLST (IDY)
                                       TO  W11-SYOHOGEPRTFLGLST (IDY)
           END-PERFORM
           MOVE    SPA-GMN-SYOHOGEPRTFLG-MAX
                                       TO  W11-SYOHOGEPRTFLG-COUNT 
      *
           MOVE    SPA-GMN-SYOHODSPNAME
                                       TO  W11-SYOHODSPNAME
      *
           MOVE    SPA-GMN-STYUKYMD     TO  W11-STYUKYMD
           MOVE    SPA-GMN-EDYUKYMD     TO  W11-EDYUKYMD
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
          IF      SPA-GMN-CUR          =   ZERO
               PERFORM 50011-CUR-SET-SEC
          END-IF
      *
           EVALUATE    SPA-GMN-CUR
                WHEN   1
                    MOVE  "PRTNM01"    TO  MCP-WIDGET
                WHEN   2
                    MOVE  "PRTNM02"    TO  MCP-WIDGET
                WHEN   3
                    MOVE  "PRTNM03"    TO  MCP-WIDGET
                WHEN   4
                    MOVE  "PRTNM04"    TO  MCP-WIDGET
                WHEN   5
                    MOVE  "PRTNM05"    TO  MCP-WIDGET
                WHEN   6
                    MOVE  "PRTNM06"    TO  MCP-WIDGET
                WHEN   7
                    MOVE  "PRTNM07"    TO  MCP-WIDGET
                WHEN   8
                    MOVE  "PRTNM08"    TO  MCP-WIDGET
                WHEN   9
                    MOVE  "PRTNM09"    TO  MCP-WIDGET
                WHEN   10
                    MOVE  "PRTNM10"    TO  MCP-WIDGET
                WHEN   11
                    MOVE  "ORCACSTNM01"
                                       TO  MCP-WIDGET
                WHEN   12
                    MOVE  "ORCACSTNM02"
                                       TO  MCP-WIDGET
                WHEN   13
                    MOVE  "ORCACSTNM03"
                                       TO  MCP-WIDGET
                WHEN   14
                    MOVE  "ORCACSTNM04"
                                       TO  MCP-WIDGET
                WHEN   51
                    MOVE  "PRTNM01N"   TO  MCP-WIDGET
                WHEN   52
                    MOVE  "PRTNM02N"   TO  MCP-WIDGET
                WHEN   53
                    MOVE  "PRTNM03N"   TO  MCP-WIDGET
                WHEN   54
                    MOVE  "PRTNM04N"   TO  MCP-WIDGET
                WHEN   55
                    MOVE  "PRTNM05N"   TO  MCP-WIDGET
                WHEN   56
                    MOVE  "PRTNM06N"   TO  MCP-WIDGET
                WHEN   57
                    MOVE  "PRTNM07N"   TO  MCP-WIDGET
                WHEN   58
                    MOVE  "PRTNM08N"   TO  MCP-WIDGET
                WHEN   59
                    MOVE  "PRTNM09N"   TO  MCP-WIDGET
                WHEN   60
                    MOVE  "PRTNM10N"   TO  MCP-WIDGET
                WHEN   61
                    MOVE  "ORCACSTNM01N"
                                       TO  MCP-WIDGET
                WHEN   62
                    MOVE  "ORCACSTNM02N"
                                       TO  MCP-WIDGET
                WHEN   63
                    MOVE  "ORCACSTNM03N"
                                       TO  MCP-WIDGET
                WHEN   101
                    MOVE  "SYOHOGEPRTFLG"
                                       TO  MCP-WIDGET
                WHEN   102
                    MOVE  "SYOHODSPNAME"
                                       TO  MCP-WIDGET
                 WHEN   999
                    MOVE  "B12"        TO  MCP-WIDGET
           END-EVALUATE
      *
            EVALUATE    SPA-W01-KANRICD
            WHEN    "1031"
                    MOVE    0                TO  W11-PAGENO
            WHEN    "1030"
                    MOVE    1                TO  W11-PAGENO
            END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル編集処理
      *****************************************************************
       50011-CUR-SET-SEC         SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "PRTNM01"
                   MOVE    1           TO  SPA-GMN-CUR
               WHEN    "PRTNM02"
                   MOVE    2           TO  SPA-GMN-CUR
               WHEN    "PRTNM03"
                   MOVE    3           TO  SPA-GMN-CUR
               WHEN    "PRTNM04"
                   MOVE    4           TO  SPA-GMN-CUR
               WHEN    "PRTNM05"
                   MOVE    5           TO  SPA-GMN-CUR
               WHEN    "PRTNM06"
                   MOVE    6           TO  SPA-GMN-CUR
               WHEN    "PRTNM07"
                   MOVE    7           TO  SPA-GMN-CUR
               WHEN    "PRTNM08"
                   MOVE    8           TO  SPA-GMN-CUR
               WHEN    "PRTNM09"
                   MOVE    9           TO  SPA-GMN-CUR
               WHEN    "PRTNM10"
                   MOVE    10          TO  SPA-GMN-CUR
               WHEN    "ORCACSTNM01"
                   MOVE    11          TO  SPA-GMN-CUR
               WHEN    "ORCACSTNM02"
                   MOVE    12          TO  SPA-GMN-CUR
               WHEN    "ORCACSTNM03"
                   MOVE    13          TO  SPA-GMN-CUR
               WHEN    "ORCACSTNM04"
                   MOVE    14          TO  SPA-GMN-CUR
      *
               WHEN    "PRTNM01N"
                   MOVE    51           TO  SPA-GMN-CUR
               WHEN    "PRTNM02N"
                   MOVE    52           TO  SPA-GMN-CUR
               WHEN    "PRTNM03N"
                   MOVE    53           TO  SPA-GMN-CUR
               WHEN    "PRTNM04N"
                   MOVE    54           TO  SPA-GMN-CUR
               WHEN    "PRTNM05N"
                   MOVE    55           TO  SPA-GMN-CUR
               WHEN    "PRTNM06N"
                   MOVE    56           TO  SPA-GMN-CUR
               WHEN    "PRTNM07N"
                   MOVE    57           TO  SPA-GMN-CUR
               WHEN    "PRTNM08N"
                   MOVE    58           TO  SPA-GMN-CUR
               WHEN    "PRTNM09N"
                   MOVE    59           TO  SPA-GMN-CUR
               WHEN    "PRTNM10N"
                   MOVE    60           TO  SPA-GMN-CUR
               WHEN    "ORCACSTNM01N"
                   MOVE    61           TO  SPA-GMN-CUR
               WHEN    "ORCACSTNM02N"
                   MOVE    62           TO  SPA-GMN-CUR
               WHEN    "ORCACSTNM03N"
                   MOVE    63           TO  SPA-GMN-CUR
      *
               WHEN    "SYOHOGEPRTFLG"
                   MOVE    101         TO  SPA-GMN-CUR
               WHEN    "SYOHODSPNAME"
                   MOVE    102         TO  SPA-GMN-CUR
           END-EVALUATE
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "ORCACSTNM04"
               IF    ( SPA-BEDSU       >   ZERO )
                   MOVE    51          TO  SPA-GMN-CUR
               ELSE
                   MOVE    999         TO  SPA-GMN-CUR
               END-IF
           WHEN    "ORCACSTNM03N"
               MOVE    "999"           TO  SPA-GMN-CUR
           WHEN    "SYOHODSPNAME"
               MOVE    "999"           TO  SPA-GMN-CUR
           WHEN    OTHER
               COMPUTE SPA-GMN-CUR     =   SPA-GMN-CUR +   1
           END-EVALUATE
      *
           .
       50011-CUR-SET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    業務権限非活性処理
      *****************************************************************
       510-GSRAUTH-SEC             SECTION.
      *
           MOVE    WIDGET-INSENSITIVE      TO  W11-N01-STATE
                                               W11-N02-STATE
      *             
           EVALUATE    SPA-W01-KANRICD
               WHEN    "1031" 
                   MOVE    WIDGET-NORMAL      TO  W11-N01-STATE
               WHEN    "1030" 
                   MOVE    WIDGET-NORMAL      TO  W11-N02-STATE
           END-EVALUATE
           .
       51O-GSRAUTH-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "処方せんＧＥ表示区分入力エラー"
                                                      TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "プリンタ名入力エラー"     TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "項目に入力がありません"   TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "プログラム名を入力してください"
                                                      TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "後発医薬品表示名称は全角で入力して下さい"
                                           TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "プリンタ名は半角で入力してください"
                                                      TO  SPA-ERRMSG
               WHEN    "4001"  THRU    "4999"
                   MOVE    "更新処理に失敗しました"
                                                      TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W11"                TO  SPA-MOTOPG
           MOVE    "WERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
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
           MOVE    SPACE               TO  WRK-WIDMSG
      *
           EVALUATE    SPA-WIDCD
               WHEN    "1001"
                   MOVE    "登録処理をします"    TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W11"                TO  SPA-MOTOPG
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
      *    全角半角混在チェック
      *****************************************************************
       800-ENRTRY-CHK-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-ENTRYCHK
      *
           IF  ( WRK-KANACHK-MAE-INPUT
                                   =   SPACE )
               MOVE    1           TO  FLG-ENTRYCHK
               GO  TO  800-ENRTRY-CHK-EXT
           END-IF
      *
           MOVE    SPACE           TO  ORCSKANACHKAREA
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    WRK-KANACHK-MAE-INPUT
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
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
      *    管理マスター読込（キー）
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
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
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
      *----(01.00.03) LINE ADD START --------------------------
      *****************************************************************
      *    システム管理マスタ検索処理
      *****************************************************************
       900-SYSKANRI-SELECT-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-SELECT-EXT.
           EXIT.
      * 
      *----(01.00.03) LINE ADD END   --------------------------
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
      *----(01.00.03) LINE ADD START --------------------------
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
      *----(01.00.03) LINE ADD END   --------------------------
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
       900-SYSKANRI-READ-EXT.
           EXIT.
      * 
      *----(01.00.03) LINE ADD START --------------------------
      *****************************************************************
      *    システム管理マスタクローズ処理
      *****************************************************************
       900-SYSKANRI-CLOSE-SEC         SECTION.
      *
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-SYSKANRI-CLOSE-EXT.
           EXIT.
      * 
      *----(01.00.03) LINE ADD END   --------------------------
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.

