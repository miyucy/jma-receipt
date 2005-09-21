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
       PROGRAM-ID.             ORCHXLST.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : チェクマスタ
      *  コンポーネント名  : チェクマスタ一覧表印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/26    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    04/03/01  一括印刷対応
      *  01.00.02    NACL-太田    05/02/04  フォーム変更
      *****************************************************************
      *
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  HC01PARA
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
           COPY    "HCM44.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT                 PIC 9(05).
           03  CNT-TEKCD               PIC 9(05).
           03  CNT-TEKLINE             PIC 9(05).
      *
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA                PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-TENSU               PIC 9(01).
           03  FLG-CHKMST              PIC 9(01).
           03  FLG-CHKSND              PIC 9(01).
           03  FLG-BYOMEI              PIC 9(01).
           03  FLG-OK                  PIC 9(01).
           03  FLG-R3                  PIC 9(01).
           03  FLG-LINE-FEED           PIC 9(01).
           03  FLG-TOTUGO-G.
               05  FLG-KANZEN          PIC 9(01).
               05  FLG-ZENPO           PIC 9(01).
               05  FLG-KOHO            PIC 9(01).
           03  FLG-TOTUGO-R    REDEFINES   FLG-TOTUGO-G.
               05  FLG-TOTUGO          PIC 9(01)
                                       OCCURS  3.
           03  FLG-TEKCD               PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                    PIC 9(05).
           03  IDX2                    PIC 9(05).
           03  IDX-LINE                PIC 9(05).
           03  IDX-LEN                 PIC 9(05).
           03  IDX-CMB                 PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MCP-PATH.
               05  WRK-MCP-BLOCKS      PIC S9(9)   BINARY.
               05  WRK-MCP-RNAME       PIC S9(9)   BINARY.
               05  WRK-MCP-PNAME       PIC S9(9)   BINARY.
           03  WRK-TNS-SRYCD           PIC X(09).
           03  WRK-PAGE                PIC 9(03).
           03  WRK-NAME-G.
               05  WRK-NAME1           PIC X(04).
               05  WRK-NAME            PIC X(100).
           03  WRK-KEY-CD-G.
               05  WRK-KEY-CD-OCC      OCCURS  21.
                   07  WRK-KEY-CD      PIC X(07).
                   07  WRK-KEY-CDSEP   PIC X(01).
           03  WRK-MEISAISTR           PIC X(500).
           03  WRK-SRYNAME             PIC X(50).
           03  WRK-PNT                 PIC 9(05).
           03  WRK-TGPNT               PIC 9(05).
           03  WRK-STR                 PIC X(500).
           03  WRK-STRLEN              PIC 9(05).
           03  WRK-TEKIYOLEN           PIC 9(05).
           03  WRK-BYOMEICD            PIC X(07).
           03  WRK-BYOMEI-G.
               05  WRK-BYOMEI-SP       PIC X(01).
               05  WRK-BYOMEI          PIC X(80).
           03  WRK-MSIBYO-G.
               05  WRK-MSIBYO-MEI      PIC X(80).
           03  WRK-CMB-CD              PIC X(10).
           03  WRK-CMB-ITM-G.
               05  WRK-CMB-ITM         PIC X(200).
      *
       01  KEY-TEKCD                   PIC X(200).
      *
      *    印刷内容
       01  HEAD-01.
           03  FILLER                  PIC X(25)   VALUE   SPACE.
           03  H01-MIDASI              PIC X(80).
           03  FILLER                  PIC X(08)   VALUE   "作成日：".
           03  H01-YY                  PIC 9(04).
           03  FILLER                  PIC X(01)   VALUE   ".".
           03  H01-MM                  PIC Z9.
           03  FILLER                  PIC X(01)   VALUE   ".".
           03  H01-DD                  PIC Z9.
           03  FILLER                  PIC X(04)   VALUE   "  P-".
           03  H01-PCNT                PIC ZZ9.
       01  HEAD-02.
           03  FILLER                  PIC X(10)   VALUE   SPACE.
           03  H02-MIDASI1             PIC X(50).
           03  FILLER                  PIC X(01)   VALUE   SPACE.
           03  H02-MIDASI2             PIC X(100).
           03  H02-MIDASI2-R   REDEFINES   H02-MIDASI2.
               05  H02-MIDASI2R1       PIC X(30).
               05  H02-MIDASI2R2       PIC X(70).
       01  BODY-01.
           03  B01-NYUGAIKBN           PIC X(02).
           03  B01-SRYCD1              PIC X(09).
           03  FILLER                  PIC X(01).
           03  B01-NAME1               PIC X(50).
           03  FILLER                  PIC X(02).
           03  B01-COMPKBN             PIC X(02).
           03  FILLER                  PIC X(02).
           03  B01-TEKIYO              PIC X(90).
           03  B01-TEKIYO-R1           REDEFINES   B01-TEKIYO.
               05  B01-SRYCD2          PIC X(09).
               05  FILLER              PIC X(01).
               05  B01-NAME2           PIC X(80).
           03  B01-TEKIYO-R2           REDEFINES   B01-TEKIYO.
               05  B01-BYOMEICD        PIC X(07).
               05  FILLER              PIC X(01).
               05  B01-BYOMEI          PIC X(82).
           03  B01-TEKIYO-R3           REDEFINES   B01-TEKIYO.
               05  FILLER              PIC X(08).
               05  B01-MEISAI          PIC X(82).
      *
       01  CONST-AREA.
           03  CONST-HCM44-MAX         PIC 9(05)   VALUE   55.
           03  CONST-MEISAI-ST         PIC 9(05)   VALUE   4.
           03  CONST-TEKIYO-MAX        PIC 9(05)   VALUE   90.
           03  CONST-TEKIYO-R3-MAX     PIC 9(05)   VALUE   82.
           03  CONST-MKCD-MAX          PIC 9(05)   VALUE   21.
           03  CONST-CHK-MAX           PIC 9(05)   VALUE   10.
           03  CONST-TOTUGO-MES-MAX    PIC 9(05)   VALUE   3.
           03  CONST-TOTUGO-MES-VAL.
               05  CONST-TOTUGO-KANZEN PIC X(12)   VALUE "完：完全一致".
               05  CONST-TOTUGO-ZENPO  PIC X(12)   VALUE "前：前方一致".
               05  CONST-TOTUGO-KOHO   PIC X(12)   VALUE "後：後方一致".
           03  CONST-TOTUGO-MES-R      REDEFINES   CONST-TOTUGO-MES-VAL.
               05  CONST-TOTUGO-MES    PIC X(12)   OCCURS  3.
      *
      *    病名システム予約コードテーブル
           COPY    "CMBYOMEICD.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *    チェックマスタ−
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *
      *    チェックマスタ−２
       01  CHKSND-REC.
           COPY    "CPCHKSND.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    印刷パラメタ
           COPY    "CPORCSMKPRT.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
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
      *
      *    一覧印刷変換領域
           COPY    "CPORCHXLST.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHXLSTAREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  HXLST-RCD
           INITIALIZE                  HCM44
      *
           PERFORM 800-MCNDATE-SEC
      *
      *    各ＤＢ読込
           PERFORM 100-SYORI-SEC
           IF    ( HXLST-RCD       NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
           MOVE    SPACE           TO  KEY-TEKCD
                                       WRK-SRYNAME
           MOVE    ZERO            TO  CNT-TEKCD
           MOVE    ZERO            TO  WRK-PAGE
           MOVE    CONST-MEISAI-ST TO  IDX-LINE
      *
      *    明細編集処理
           IF    ( HXLST-CHKKBN    =   "1" OR "2" OR "6" )
      *
               PERFORM UNTIL ( FLG-CHKSND  =   1 )
                   PERFORM 200-MEISAI-CHKSND-SYORI-SEC
               END-PERFORM
      *
               MOVE    WRK-MCP-PATH    TO  MCP-PATH
               PERFORM 910-DBCLOSE-SEC
      *
           ELSE
      *
               PERFORM UNTIL ( FLG-CHKMST  =   1 )
                   PERFORM 200-MEISAI-CHKMST-SYORI-SEC
               END-PERFORM
      *
               MOVE    WRK-MCP-PATH    TO  MCP-PATH
               PERFORM 910-DBCLOSE-SEC
      *
           END-IF
      *
      *    印刷処理
           IF    ( IDX-LINE            >   CONST-MEISAI-ST )
               MOVE    ALL "-" TO  HCM44-MOJI (IDX-LINE)
               PERFORM 2200-PAGE-FEED-CHK-SEC
               PERFORM 2100-HEAD-SEC
               IF    ( HXLST-PROCKBN   =   "1" )
                   PERFORM 400-PRINT-SYORI-SEC
               ELSE
                   PERFORM 410-PRINT-SYORI-SEC
               END-IF
           END-IF
      *
           MOVE    CNT-OUT         TO  HXLST-OUT-CNT
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期編集処理
      *****************************************************************
       100-SYORI-SEC                   SECTION.
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                      SYS-1031-REC
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "2"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SRYYMD          TO  ORCSPRTNM-SRYYMD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1031-REC
      *
           MOVE    SPA-SYSYMD(1:4)     TO  H01-YY
           MOVE    SPA-SYSYMD(5:2)     TO  H01-MM
           MOVE    SPA-SYSYMD(7:2)     TO  H01-DD
      *
           IF        ( HXLST-CHKKBN    =   "1" OR "2" OR "6" )
                   PERFORM 1001-CHKSND-SYOKI-SEC
           ELSE
               IF    ( HXLST-CHKKBN    =   "3" OR "4" OR "5" )
                   PERFORM 1001-CHKMST-SYOKI-SEC
               ELSE
                   MOVE    -1          TO  HXLST-RCD
               END-IF
           END-IF
      *
           .
       100-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    初期編集処理（チェックマスタ）
      *****************************************************************
       1001-CHKMST-SYOKI-SEC           SECTION.
      *
           INITIALIZE                  CHK-REC
      *
           EVALUATE    HXLST-CHKKBN
           WHEN    "3"
               MOVE    "3"             TO  CHK-CDKBN
           WHEN    "4" 
           WHEN    "5"
               MOVE    "2"             TO  CHK-CDKBN
           END-EVALUATE
      *
           MOVE    HXLST-CHKKBN        TO  CHK-CHKKBN
           MOVE    HXLST-SRYCD         TO  CHK-SRYCD
      *
           IF    ( HXLST-SRYCD         =   SPACE )
               MOVE    "000000000"     TO  CHK-SRYCD
               MOVE    "999999999"     TO  CHKUP-SRYCD
           ELSE
               IF    ( HXLST-SRYCD-END =   SPACE  )
                OR   ( HXLST-SRYCD     >   HXLST-SRYCD-END )
                   MOVE    HXLST-SRYCD TO  CHKUP-SRYCD
               ELSE
                   MOVE    HXLST-SRYCD-END
                                       TO  CHKUP-SRYCD
               END-IF
           END-IF
      *
           MOVE    SPA-SYSYMD          TO  CHK-YUKOSTYMD
                                           CHK-YUKOEDYMD
      *
           INITIALIZE                  WRK-MCP-PATH
      *
           EVALUATE HXLST-SRTKBN
           WHEN   "1"
               MOVE    PATH-TBL-CHK-KEY10  TO  WRK-MCP-PATH
           WHEN   "2"
               MOVE    PATH-TBL-CHK-KEY8   TO  WRK-MCP-PATH
           WHEN   "3"
               MOVE    PATH-TBL-CHK-KEY9   TO  WRK-MCP-PATH
           WHEN   OTHER
               MOVE    PATH-TBL-CHK-KEY10  TO  WRK-MCP-PATH
           END-EVALUATE
      *
      *
           MOVE    CHK-REC             TO  MCPDATA-REC
           PERFORM 900-CHKMST-SEL-SEC
      *
           EVALUATE    HXLST-CHKKBN
           WHEN    "3"
               MOVE
               "＜　薬剤と禁忌一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "禁忌コード"
                                       TO  H02-MIDASI2
           WHEN    "4" 
               MOVE
               "＜　薬剤と併用禁忌一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "適用薬剤コード"
                                       TO  H02-MIDASI2
           WHEN    "5"
               MOVE
               "＜　同一月に併用算定できない診療行為一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "診療行為コード"
                                       TO  H02-MIDASI1
                   MOVE    "適用診療行為コード"
                                       TO  H02-MIDASI2
           END-EVALUATE
      *
           .
       1001-CHKMST-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    初期編集処理（チェックマスタ２）
      *****************************************************************
       1001-CHKSND-SYOKI-SEC           SECTION.
      *
           INITIALIZE                  CHKSND-REC
      *
           MOVE    "1"                 TO  CHKSND-CDKBN
      *
           MOVE    HXLST-CHKKBN        TO  CHKSND-CHKKBN
           MOVE    HXLST-SRYCD         TO  CHKSND-SRYCD
      *
           IF    ( HXLST-SRYCD         =   SPACE )
               MOVE    "000000000"     TO  CHKSND-SRYCD
               MOVE    "999999999"     TO  CHKSND-UPSRYCD
           ELSE
               IF    ( HXLST-SRYCD-END =   SPACE  )
                OR   ( HXLST-SRYCD     >   HXLST-SRYCD-END )
                   MOVE    HXLST-SRYCD TO  CHKSND-UPSRYCD
               ELSE
                   MOVE    HXLST-SRYCD-END
                                       TO  CHKSND-UPSRYCD
               END-IF
           END-IF
      *
           MOVE    SPA-SYSYMD          TO  CHKSND-YUKOSTYMD
                                           CHKSND-YUKOEDYMD
      *
           INITIALIZE                  WRK-MCP-PATH
      *
           EVALUATE HXLST-SRTKBN
           WHEN   "1"
               MOVE    PATH-TBL-CHKSND-KEY10
                                       TO  WRK-MCP-PATH
           WHEN   "2"
               MOVE    PATH-TBL-CHKSND-KEY8
                                       TO  WRK-MCP-PATH
           WHEN   "3"
               MOVE    PATH-TBL-CHKSND-KEY9
                                       TO  WRK-MCP-PATH
           WHEN   OTHER
               MOVE    PATH-TBL-CHKSND-KEY10
                                       TO  WRK-MCP-PATH
           END-EVALUATE
      *
      *
           MOVE    CHKSND-REC          TO  MCPDATA-REC
           PERFORM 900-CHKSND-SEL-SEC
      *
           EVALUATE    HXLST-CHKKBN
           WHEN    "1"
               MOVE
               "＜　薬剤と病名一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "病名コード"
                                       TO  H02-MIDASI2R1
           WHEN    "2"
               MOVE
               "＜　診療行為と病名一覧表　＞"
                                       TO  H01-MIDASI
                   MOVE    "診療行為コード"
                                       TO  H02-MIDASI1
                   MOVE    "病名コード"
                                       TO  H02-MIDASI2R1
           WHEN    "6"
               MOVE
               "＜　投与禁忌薬剤と病名　＞"
                                       TO  H01-MIDASI
                   MOVE    "薬剤コード"
                                       TO  H02-MIDASI1
                   MOVE    "病名コード"
                                       TO  H02-MIDASI2R1
           END-EVALUATE
      *
           .
       1001-CHKSND-SYOKI-EXT.
           EXIT.
      *****************************************************************
      *    明細編集処理（チェックマスタより）
      *****************************************************************
       200-MEISAI-CHKMST-SYORI-SEC     SECTION.
      *
           IF    ( KEY-TEKCD   NOT =   CHK-SRYCD )
               IF    ( IDX-LINE    >   CONST-MEISAI-ST )
                   MOVE    ALL "-" TO  HCM44-MOJI (IDX-LINE)
                   PERFORM 2200-PAGE-FEED-CHK-SEC
               END-IF
      *
               MOVE    CHK-SRYCD   TO  KEY-TEKCD
      *
               MOVE    ZERO        TO  CNT-TEKCD
      *
               MOVE    CHK-SRYCD   TO  WRK-TNS-SRYCD
               PERFORM 2001-SRYCD-HEN-SEC
               MOVE    WRK-NAME-G  TO  WRK-SRYNAME
      *
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   CONST-CHK-MAX )
      *
               IF    ( CHK-CD (IDX1)   NOT =   SPACE )
      *
                   COMPUTE CNT-TEKCD   =   CNT-TEKCD   +   1
      *
                   INITIALIZE          BODY-01
      *
                   IF    ( CNT-TEKCD   =   1 )
                       MOVE    CHK-SRYCD   TO  B01-SRYCD1
                       MOVE    WRK-SRYNAME TO  B01-NAME1
                   END-IF
      *
                   MOVE    CHK-CD (IDX1)   TO  B01-SRYCD2
      *
                   MOVE    CHK-CD (IDX1)   TO  WRK-TNS-SRYCD
                   PERFORM 2001-SRYCD-HEN-SEC
                   MOVE    WRK-NAME-G      TO  B01-NAME2
      *
                   INSPECT B01-NAME1   REPLACING   ALL "  "  BY  "　"
      *
                   MOVE    BODY-01         TO  HCM44-MOJI (IDX-LINE)
      *
                   PERFORM 2200-PAGE-FEED-CHK-SEC
      *
               END-IF
      *
           END-PERFORM
      *
           PERFORM 900-CHKMST-FET-SEC
      *
           .
       200-MEISAI-CHKMST-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    明細編集処理（チェックマスタ２より）
      *****************************************************************
       200-MEISAI-CHKSND-SYORI-SEC     SECTION.
      *
           IF    ( KEY-TEKCD   NOT =   CHKSND-SRYCD )
               IF    ( IDX-LINE    >   CONST-MEISAI-ST )
                   MOVE    ALL "-" TO  HCM44-MOJI (IDX-LINE)
                   PERFORM 2200-PAGE-FEED-CHK-SEC
               END-IF
      *
               MOVE    CHKSND-SRYCD    TO  KEY-TEKCD
      *
               MOVE    ZERO            TO  CNT-TEKCD
      *
               MOVE    CHKSND-SRYCD    TO  WRK-TNS-SRYCD
               PERFORM 2001-SRYCD-HEN-SEC
               MOVE    WRK-NAME-G  TO  WRK-SRYNAME
      *
           END-IF
      *
           COMPUTE CNT-TEKCD   =   CNT-TEKCD   +   1
      *
           INITIALIZE              BODY-01
      *
           IF    ( CNT-TEKCD   =   1 )
      *
               EVALUATE    CHKSND-NYUGAIKBN
               WHEN    "1"
                   MOVE    "入"       TO  B01-NYUGAIKBN
               WHEN    "2"
                   MOVE    "外"       TO  B01-NYUGAIKBN
               WHEN    OTHER
                   MOVE    "　"       TO  B01-NYUGAIKBN
               END-EVALUATE
      *
               MOVE    CHKSND-SRYCD   TO  B01-SRYCD1
               MOVE    WRK-SRYNAME    TO  B01-NAME1
           END-IF
      *
           EVALUATE    CHKSND-COMPKBN
           WHEN    "2"
               MOVE    "完"           TO  B01-COMPKBN
               MOVE    1              TO  FLG-KANZEN
           WHEN    "3"
               MOVE    "前"           TO  B01-COMPKBN
               MOVE    1              TO  FLG-ZENPO
           WHEN    "4"
               MOVE    "後"           TO  B01-COMPKBN
               MOVE    1              TO  FLG-KOHO
           WHEN    OTHER
               MOVE    "　"           TO  B01-COMPKBN
           END-EVALUATE
      *
           MOVE    CHKSND-CD       TO  WRK-KEY-CD-G
           MOVE    1               TO  WRK-PNT
      *
           IF    ( WRK-KEY-CD (2)  =   SPACE )
               MOVE    WRK-KEY-CD (1)  TO  B01-BYOMEICD
               MOVE    CHKSND-BYOMEI   TO  B01-BYOMEI
           ELSE
               PERFORM 2001-MEISAI-CHKSND-SYORI-SEC
           END-IF
      *
           INSPECT B01-NAME1   REPLACING   ALL "  "  BY  "　"
      *
           MOVE    BODY-01         TO  HCM44-MOJI (IDX-LINE)
           PERFORM 2200-PAGE-FEED-CHK-SEC
      *
           PERFORM 900-CHKSND-FET-SEC
      *
           .
       200-MEISAI-CHKSND-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    明細編集処理（チェックマスタ２より）
      *****************************************************************
       2001-MEISAI-CHKSND-SYORI-SEC    SECTION.
      *
           MOVE    ZERO        TO  FLG-R3
           MOVE    ZERO        TO  FLG-TEKCD
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   CONST-MKCD-MAX )
                    OR   ( WRK-KEY-CD (IDX1)   =   SPACE )
      *
               IF    ( WRK-KEY-CDSEP  (IDX1)   =   "-" )
                   MOVE    "," TO  WRK-KEY-CDSEP  (IDX1)
               END-IF
      *
               MOVE    WRK-KEY-CD-OCC (IDX1)   TO  WRK-MEISAISTR
               PERFORM 20011-MEISAI-CHKSND-SYORI-SEC
      *
           END-PERFORM
      *
           MOVE    CHKSND-BYOMEI   TO  WRK-MEISAISTR
           PERFORM 20011-LINE-FEED-CHK-SEC
           IF    ( FLG-LINE-FEED   =   ZERO )
               MOVE    SPACE           TO  WRK-BYOMEI-G
               MOVE    CHKSND-BYOMEI   TO  WRK-BYOMEI
               MOVE    WRK-BYOMEI-G    TO  WRK-MEISAISTR
               PERFORM 20011-MEISAI-CHKSND-SYORI-SEC
           ELSE
               MOVE    CHKSND-BYOMEI   TO  WRK-MEISAISTR
               PERFORM 20011-MEISAI-CHKSND-SYORI-SEC
           END-IF
      *
      *    INSPECT B01-NAME1   REPLACING   ALL "  "  BY  "　"
      *
      *    MOVE    BODY-01         TO  HCM44-MOJI (IDX-LINE)
      *    PERFORM 2200-PAGE-FEED-CHK-SEC
      *
      *    INITIALIZE                  BODY-01
      *    MOVE    1               TO  WRK-PNT
      *    MOVE    1               TO  FLG-R3
      *
           MOVE    "【"            TO  WRK-MEISAISTR
           PERFORM 20011-MEISAI-CHKSND-SYORI-SEC
      *
           MOVE    1               TO  FLG-TEKCD
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   CONST-MKCD-MAX )
                    OR   ( WRK-KEY-CD (IDX1)   =   SPACE )
      *
               INITIALIZE          WRK-MSIBYO-G
      *
               MOVE    WRK-KEY-CD (IDX1)   TO  WRK-CMB-CD
               PERFORM 2100-YYKBYOCD-CHK-SEC
               IF    ( WRK-CMB-ITM NOT =   SPACE )
                   MOVE    WRK-CMB-ITM TO  WRK-MSIBYO-MEI
               ELSE
                   MOVE    WRK-KEY-CD (IDX1)   TO  WRK-BYOMEICD
                   PERFORM 900-BYOMEI-KEY-SEL-SEC
                   MOVE    BYO-BYOMEI  TO  WRK-MSIBYO-MEI
               END-IF
               IF    ( IDX1    >=  CONST-MKCD-MAX )
                OR   ( WRK-KEY-CD (IDX1 + 1 )  =   SPACE )
                   MOVE    WRK-MSIBYO-G    TO  WRK-MEISAISTR
                   PERFORM 20011-MEISAI-CHKSND-SYORI-SEC
               ELSE
                   INITIALIZE  WRK-MEISAISTR
                   STRING  WRK-MSIBYO-MEI  DELIMITED   BY  SPACE
                           ","             DELIMITED   BY  SIZE
                   INTO    WRK-MEISAISTR
                   END-STRING
                   PERFORM 20011-MEISAI-CHKSND-SYORI-SEC
               END-IF
      *
      *
           END-PERFORM
      *
           MOVE    "】"            TO  WRK-MEISAISTR
           PERFORM 20011-MEISAI-CHKSND-SYORI-SEC
      *
           .
       2001-MEISAI-CHKSND-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    改行チェック処理
      *****************************************************************
       20011-LINE-FEED-CHK-SEC         SECTION.
      *
           MOVE    WRK-MEISAISTR   TO  WRK-STR
           PERFORM 800-STRLEN-CHK-SEC
      *
           COMPUTE WRK-TEKIYOLEN   =   WRK-STRLEN  +   WRK-PNT -   1
      *
           MOVE    ZERO            TO  FLG-LINE-FEED
      *
           IF    (      FLG-R3         =   ZERO )
               IF    (  WRK-TEKIYOLEN  >   CONST-TEKIYO-MAX )
                   MOVE    1       TO  FLG-LINE-FEED
               END-IF
           ELSE
               IF    (  WRK-TEKIYOLEN  >   CONST-TEKIYO-R3-MAX )
                   MOVE    1       TO  FLG-LINE-FEED
               END-IF
           END-IF
      *
           .
       20011-LINE-FEED-CHK-EXT.
           EXIT.
      *****************************************************************
      *    明細編集処理（チェックマスタ２より）
      *****************************************************************
       20011-MEISAI-CHKSND-SYORI-SEC   SECTION.
      *
           PERFORM 20011-LINE-FEED-CHK-SEC
      *
           IF  ( FLG-LINE-FEED         =   1 )
      *
               INSPECT B01-NAME1   REPLACING   ALL "  "  BY  "　"
      *
               MOVE    BODY-01 TO  HCM44-MOJI (IDX-LINE)
               PERFORM 2200-PAGE-FEED-CHK-SEC
               INITIALIZE          BODY-01
               MOVE    1       TO  WRK-PNT
               MOVE    1       TO  FLG-R3
           END-IF
      *
           IF    ( FLG-R3      =   ZERO )
               STRING  WRK-STR (1:WRK-STRLEN)  DELIMITED   BY  SIZE
               INTO    B01-TEKIYO
               WITH    POINTER     WRK-PNT
               END-STRING
           ELSE
               IF    ( FLG-TEKCD   =   ZERO )
                   STRING  WRK-STR (1:WRK-STRLEN)  DELIMITED   BY  SIZE
                   INTO    B01-MEISAI
                   WITH    POINTER     WRK-PNT
                   END-STRING
               ELSE
                   STRING  WRK-STR (1:WRK-STRLEN)  DELIMITED   BY  SIZE
                           " "                     DELIMITED   BY  SIZE
                   INTO    B01-MEISAI
                   WITH    POINTER     WRK-PNT
                   END-STRING
               END-IF
           END-IF
      *
           .
       20011-MEISAI-CHKSND-SYORI-EXT.
           EXIT.
      *****************************************************************
      *   診療コード処理
      *****************************************************************
       2001-SRYCD-HEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-NAME-G
      *
           PERFORM 900-TENSU-KEY4-SEL-SEC
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM UNTIL ( FLG-TENSU   =   1 )
                    OR   ( FLG-OK      =   1 )
      *
               IF    ( TNS-SRYCD(1:1)  =   "1" )
                AND  ( TNS-ROUTEKKBN   =   2   )
      *
                   MOVE    SPACE       TO  WRK-NAME
                   STRING  "［老］"        DELIMITED   BY  SIZE
                           TNS-NAME        DELIMITED   BY  SIZE
                   INTO    WRK-NAME
                   END-STRING
      *
               ELSE
                   MOVE    TNS-NAME    TO  WRK-NAME
               END-IF
      *
               IF     (TNS-YUKOSTYMD  <=  SPA-SYSYMD )  AND
                      (TNS-YUKOEDYMD  >=  SPA-SYSYMD )
                   MOVE    1           TO  FLG-OK
               END-IF
      *
               PERFORM 900-TENSU-KEY4-FET-SEC
      *
           END-PERFORM
      *
           IF    ( FLG-OK              =   ZERO )
               MOVE    "削"            TO  WRK-NAME1
           END-IF
      *
           .
       2001-SRYCD-HEN-EXT.
           EXIT.
      *****************************************************************
      *    予約病名コードチェック処理
      *****************************************************************
       2100-YYKBYOCD-CHK-SEC           SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
      *
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB         >   TBL-BYOMEICD-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( TBL-YYK-BYOMEICD (IDX-CMB)  =   WRK-CMB-CD )
                   MOVE   TBL-YYK-BYOMEI(IDX-CMB)
                                           TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       2100-YYKBYOCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    見出し編集処理
      *****************************************************************
       2100-HEAD-SEC                   SECTION.
      *
           COMPUTE WRK-PAGE    =   WRK-PAGE    +   1
      *
           MOVE    WRK-PAGE            TO  H01-PCNT
           MOVE    HEAD-01             TO  HCM44-MOJI(1)
      *
           IF        ( HXLST-CHKKBN    =   "1" OR "2" OR "6" )
               MOVE    SPACE           TO  H02-MIDASI2R2
               MOVE    1               TO  WRK-TGPNT
               PERFORM VARYING IDX2    FROM    1   BY  1
                       UNTIL ( IDX2    >   CONST-TOTUGO-MES-MAX )
      *
                   IF    ( FLG-TOTUGO (IDX2)   =   1 )
                       STRING CONST-TOTUGO-MES (IDX2)
                                           DELIMITED   BY  SPACE
                              "　"         DELIMITED   BY  SIZE
                       INTO   H02-MIDASI2R2
                       WITH   POINTER  WRK-TGPNT
                       END-STRING
                   END-IF
      *
               END-PERFORM
      *
           END-IF
      *
           MOVE    HEAD-02             TO  HCM44-MOJI(2)
      *
           MOVE     ALL "-"            TO  HCM44-MOJI(3)
      *
      *
           .
       2100-HEAD-EXT.
           EXIT.
      *****************************************************************
      *   改ページチェック処理
      *****************************************************************
       2200-PAGE-FEED-CHK-SEC          SECTION.
      *
           IF    ( IDX-LINE        >=  CONST-HCM44-MAX )
      *
               PERFORM 2100-HEAD-SEC
               IF    ( HXLST-PROCKBN   =   "1" )
                   PERFORM 400-PRINT-SYORI-SEC
               ELSE
                   PERFORM 410-PRINT-SYORI-SEC
               END-IF
      *
               INITIALIZE              HCM44
               MOVE    ZERO        TO  FLG-TOTUGO-G
      *
               MOVE    CONST-MEISAI-ST TO  IDX-LINE
      *
           ELSE
               COMPUTE IDX-LINE    =   IDX-LINE    +   1
           END-IF
      *
           .
       2200-PAGE-FEED-CHK-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理（オンライン印刷）
      *****************************************************************
       400-PRINT-SYORI-SEC             SECTION.
      *
      *    帳票印刷開始処理
           PERFORM 400-SYOKI-PRINT-SEC
      *
      *    帳票印刷処理
           PERFORM 400-PRINT-SEC
      *
           .
       400-PRINT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷開始処理
      *****************************************************************
       400-SYOKI-PRINT-SEC             SECTION.
      *
      *    ファイルＯＰＥＮ
           MOVE    "HC44"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SMCNDATE-HMS        TO  HC01PARA-SYOHMS
      *
           MOVE    WRK-PAGE            TO  HC01PARA-CNT
           OPEN    OUTPUT              PRT-FILE
      *
           .
       400-SYOKI-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       400-PRINT-SEC                SECTION.
      *
      *     印刷用データ出力
            WRITE  HCM44
      *
            CLOSE  PRT-FILE
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
            MOVE   "HCM44.red"         TO  MKPRT-DIA
            MOVE   SPACE               TO  MKPRT-DEF
            MOVE   HC01PARA            TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(6)   TO  MKPRT-PRTNM
            CALL   "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
      *
           COMPUTE CNT-OUT         =   CNT-OUT     +   1
      *
           .
       400-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷処理（一括印刷）
      *****************************************************************
       410-PRINT-SYORI-SEC             SECTION.
      *
           MOVE    HXLST-PRTAREA       TO  ORCSPRTAREA
      *
           MOVE    "HCM44.red"        TO  SPRT-PRTID
           MOVE    HCM44              TO  SPRT-PRTDATA
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
      *        CONTINUE
               COMPUTE CNT-OUT         =   CNT-OUT     +   1
           ELSE
               MOVE    9               TO  HXLST-RCD
           END-IF
      *
           .
       410-PRINT-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           .
       300-END-EXT.
           EXIT.
      *
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
      *    文字列長チェック処理
      *****************************************************************
       800-STRLEN-CHK-SEC              SECTION.
      *
           MOVE    ZERO            TO  WRK-STRLEN
           PERFORM VARYING IDX-LEN     FROM    500 BY  -1
                   UNTIL ( IDX-LEN     <   1 )
                    OR   ( WRK-STRLEN  >   ZERO )
               IF    ( WRK-STR (IDX-LEN  : 1)  NOT =   SPACE )
                   MOVE    IDX-LEN TO  WRK-STRLEN
               END-IF
           END-PERFORM
      *
           .
       800-STRLEN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ検索処理
      *****************************************************************
       900-CHKMST-SEL-SEC              SECTION.
      *
           MOVE    ZERO                TO  FLG-CHKMST
           MOVE    WRK-MCP-PATH        TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  CHK-REC
           ELSE
               INITIALIZE                  CHK-REC
               MOVE    1               TO  FLG-CHKMST
           END-IF
      *
           .
       900-CHKMST-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタFETCH処理
      *****************************************************************
       900-CHKMST-FET-SEC              SECTION.
      *
           MOVE    WRK-MCP-PATH        TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  CHK-REC
           ELSE
               INITIALIZE                  CHK-REC
               MOVE    1               TO  FLG-CHKMST
           END-IF
      *
           .
       900-CHKMST-FET-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２検索処理
      *****************************************************************
       900-CHKSND-SEL-SEC              SECTION.
      *
           MOVE    ZERO                TO  FLG-CHKSND
           MOVE    WRK-MCP-PATH        TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  CHKSND-REC
           ELSE
               INITIALIZE                  CHKSND-REC
               MOVE    1               TO  FLG-CHKSND
           END-IF
      *
           .
       900-CHKSND-SEL-EXT.
           EXIT.
      *****************************************************************
      *    チェックマスタ２FETCH処理
      *****************************************************************
       900-CHKSND-FET-SEC              SECTION.
      *
           MOVE    WRK-MCP-PATH        TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  CHKSND-REC
           ELSE
               INITIALIZE                  CHKSND-REC
               MOVE    1               TO  FLG-CHKSND
           END-IF
      *
           .
       900-CHKSND-FET-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理(KEY4)
      *****************************************************************
       900-TENSU-KEY4-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    WRK-TNS-SRYCD       TO  TNS-SRYCD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-TENSU-KEY4 TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           .
       900-TENSU-KEY4-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタFETCH処理(KEY4)
      *****************************************************************
       900-TENSU-KEY4-FET-SEC          SECTION.
      *
           MOVE    PATH-TBL-TENSU-KEY4 TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           .
       900-TENSU-KEY4-FET-EXT.
           EXIT.
      *****************************************************************
      *    病名検索処理(KEY)
      *****************************************************************
       900-BYOMEI-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-BYOMEI
      *
           INITIALIZE                  BYOMEI-REC
           MOVE    WRK-BYOMEICD    TO  BYO-BYOMEICD
           MOVE    BYOMEI-REC      TO  MCPDATA-REC
           MOVE    PATH-TBL-BYOMEI-KEY     TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC      =   ZERO )
                MOVE    MCPDATA-REC    TO  BYOMEI-REC
           ELSE
                INITIALIZE                 BYOMEI-REC
                MOVE    1              TO  FLG-BYOMEI
           END-IF
      *
           MOVE    PATH-TBL-BYOMEI-KEY TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
      *
       900-BYOMEI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
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
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
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
       911-DBSELECT-EXT.
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
      *    MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
