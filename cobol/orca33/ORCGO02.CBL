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
       PROGRAM-ID.             ORCGO02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院業務
      *  コンポーネント名  : 定期請求作成-個別指示（Ｏ０２）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/08/21    ひさなが　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
006900*    エラーファイル
           SELECT  TEIKIERR-FILE   ASSIGN  TEIKIERR
                                   FILE    STATUS  IS  STS-TEIKIERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
006900*    エラーファイル
       FD  TEIKIERR-FILE.
       01  TEIKIERR-REC            PIC X(200). 

       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01PARA//
                                   BY         //TEIKIERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    レセプト作成指示共通パラメタ
           COPY    "O01COMMON-SPA".
      *
      *   
           COPY    "ENUM-VALUE".
      *
      *    画面用ＳＰＡ
       01  SPA-O02.
           03  SPA-O02-AREA.
               05  SPA-GMN-MAX                     PIC 9(04).
               05  SPA-GMN-PAGE                    PIC 9(02).
               05  SPA-GMN-CUR                     PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-TBL-G           OCCURS   100.
                           11  SPA-GMN-TRENNUM     PIC 9(03).
                           11  SPA-GMN-TPTNUM      PIC X(20).
                           11  SPA-GMN-TNAME       PIC X(50).
                           11  SPA-GMN-TSRYYM      PIC X(06).
                           11  SPA-GMN-TSAKKBN     PIC X(14).
                           11  SPA-GMN-TSKYKIKAN.
                               13  SPA-GMN-TSKYKIKAN-ST
                                               PIC X(09).
                               13  SPA-GMN-TSKYKIKAN-FIL
                                               PIC X(03) VALUE " - ".
                               13  SPA-GMN-TSKYKIKAN-ED
                                               PIC X(09).
                           11  SPA-GMN-TNYUINYMD   PIC X(09).
                           11  SPA-GMN-TTAIINYMD   PIC X(09).
                   07  SPA-GMN-KOUMOKU.
                       09  SPA-GMN-RENNUM          PIC 9(03).
                       09  SPA-GMN-PTNUM           PIC X(20).
                       09  SPA-GMN-NAME            PIC X(50).
                       09  SPA-GMN-SRYYM           PIC X(07).
                       09  SPA-GMN-SAKKBN-G.
                           11  SPA-GMN-SAKKBN      PIC X(01).
                           11  SPA-GMN-F1          PIC X(01).
                           11  SPA-GMN-SAKKBNMEI   PIC X(14).
                   07  SPA-GMN-SAKKBNLST-G.
                       09  SPA-GMN-SAKKBNLST       OCCURS  10.
                           11  SPA-GMN-SAKKBNL     PIC X(01).
                           11  SPA-GMN-F1L         PIC X(01).
                           11  SPA-GMN-SAKKBNMEIL  PIC X(14).
                   07  SPA-GMN-SAKKBN-MAX          PIC 9(02).
      *
               05  SPA-NAI-SELNO                   PIC 9(03).
      *
               05  SPA-NAI-O02-AREA.
                   07  SPA-NAI-HYO-SRYYM           PIC 9(06).
                   07  SPA-NAI-HYO-SRYYMH          PIC X(06).
                   07  SPA-NAI-KOUMOKU.
                       09  SPA-NAI-PTID            PIC 9(10).
                       09  SPA-NAI-SRYYM           PIC 9(06).
                       09  SPA-NAI-SKYSTYMD        PIC X(08).
                       09  SPA-NAI-SKYEDYMD        PIC X(08).
                       09  SPA-NAI-NYUINYMD        PIC X(08).
                       09  SPA-NAI-TAIINYMD        PIC X(08).
                       09  SPA-NAI-SKYINF.
                           11  SPA-NAI-SKYINF-OCC OCCURS   10.
                               13  SPA-NAI-SKYINF-SKYSTYMD
                                                   PIC X(08).
                               13  SPA-NAI-SKYINF-SKYEDYMD
                                                   PIC X(08).
                               13  SPA-NAI-SKYINF-NYUINYMD
                                                   PIC X(08).
                               13  SPA-NAI-SKYINF-TAIINYMD
                                                   PIC X(08).
      * 
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-TBL-G           OCCURS   100.
                           11  SPA-NAI-TPTID       PIC 9(10).
                           11  SPA-NAI-TSRYYM      PIC 9(06).
                           11  SPA-NAI-TSAKKBN     PIC X(01).
                           11  SPA-NAI-TSKYSTYMD   PIC X(08).
                           11  SPA-NAI-TSKYEDYMD   PIC X(08).
                           11  SPA-NAI-TNYUINYMD   PIC X(08).
                           11  SPA-NAI-TTAIINYMD   PIC X(08).
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-PTNYUINRRK      PIC 9(01).
           03  FLG-PTTEIKIRRK      PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-SYUARI          PIC 9(01).
           03  FLG-KIKAN           PIC 9(01).
           03  FLG-GETUMATU        PIC 9(01).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TEIKIERR        PIC X(02).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDX4                PIC 9(04).
      *
      *    画面用ワーク
       01  WRK-GMN-SORT.
           03  WRK-GMN-TBL.
               05  WRK-GMN-TBL-G           OCCURS   100.
                   07  WRK-GMN-TRENNUM     PIC 9(03).
                   07  WRK-GMN-TPTNUM      PIC X(20).
                   07  WRK-GMN-TNAME       PIC X(50).
                   07  WRK-GMN-TSRYYM      PIC X(06).
                   07  WRK-GMN-TSAKKBN     PIC X(14).
                   07  WRK-GMN-TSRYKIKAN   PIC X(21).
                   07  WRK-GMN-TNYUINYMD   PIC X(09).
                   07  WRK-GMN-TTAIINYMD   PIC X(09).
      *
           03  WRK-NAI-TBL.
               05  WRK-NAI-TBL-G           OCCURS   100.
                   07  WRK-NAI-TPTID       PIC 9(10).
                   07  WRK-NAI-TSRYYM      PIC 9(06).
                   07  WRK-NAI-TSAKKBN     PIC X(1).
                   07  WRK-NAI-TSKYSTYMD   PIC X(08).
                   07  WRK-NAI-TSKYEDYMD   PIC X(08).
                   07  WRK-NAI-TNYUINYMD   PIC X(08).
                   07  WRK-NAI-TTAIINYMD   PIC X(08).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MOTOPG          PIC X(08).
           03  WRK-SELNO           PIC 9(03).
           03  WRK-NUM             PIC ZZ9.
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-TEIKIERR        PIC X(200).
           03  WRK-OIDMSG          PIC X(70).
           03  WRK-YM              PIC X(07). 
           03  WRK-PATH            PIC X(64).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SHELL-ARG1.
             05  WRK-SHELL-SRYYM   PIC  X(06).
             05  WRK-SHELL-TERMID  PIC  X(64).
             05  WRK-SHELL-SYSYMD  PIC  X(08).  
           03  WRK-SHELL-ARG3.
             05  WRK-SHELL-ARG3-TBL.
               07  WRK-SHELL-ARG3-OCC    OCCURS  3.
                 09  WRK-SHELL-KIKAN-ST  PIC  X(08).
                 09  WRK-SHELL-KIKAN-ED  PIC  X(08).
                 09  WRK-SHELL-KIKAN-KBN PIC  X(01).
           03  WRK-HENFLG          PIC 9(01).
           03  WRK-KIKAN-AREA.
             05    WRK-KIKAN-MAX         PIC  9(03).
             05    WRK-KIKAN-OCC         OCCURS  3.
               07    WRK-KIKAN-FLG       PIC  9(01).
               07    WRK-KIKAN-SKYSTYMD     PIC  X(08).
               07    WRK-KIKAN-SKYEDYMD     PIC  X(08).
               07    WRK-KIKAN-NYUINYMD     PIC  X(08).
               07    WRK-KIKAN-TAIINYMD     PIC  X(08).
           03  WRK-STDAY                 PIC  9(02).
           03  WRK-GETUMATU-AREA.
             05  WRK-GETUMATU-SKYSTYMD   PIC  X(08).
             05  WRK-GETUMATU-SKYEDYMD   PIC  X(08).
             05  WRK-GETUMATU-NYUINYMD   PIC  X(08).
             05  WRK-GETUMATU-TAIINYMD   PIC  X(08).
           03  WRK-STYMD                 PIC  X(08).
           03  WRK-EDYMD                 PIC  X(08).
           03  WRK-MAX                   PIC  9(05).
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
           03  WRK-HENTIME.
               05  WRK-HH          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-MM          PIC X(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-SS          PIC X(02).
      *
      *    スパ領域（ワーク）
           COPY    "COMMON-SPA     REPLACING  //SPA-//
                                   BY         //WRK-SPA-//.
      *
       01  WRK-SHELL-NAME.
           05  FILLER             PIC X(16) VALUE
                                             "scripts/monthly/".
           05  WRK-SHELL-SHELL    PIC X(20).         
      *
       01  WRK-CONS-AREA.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "TEIKI1".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   1.
           03  WRK-CONS-SAKKBN-MAX PIC 9(02)   VALUE   4.
           03  WRK-CONS-SAKKBN-VAL.
               05                  PIC X(01)   VALUE   "1".
               05                  PIC X(01)   VALUE   " ".
               05                  PIC X(14)   VALUE   "１期".
               05                  PIC X(01)   VALUE   "2".
               05                  PIC X(01)   VALUE   " ".
               05                  PIC X(14)   VALUE   "２期".
               05                  PIC X(01)   VALUE   "3".
               05                  PIC X(01)   VALUE   " ".
               05                  PIC X(14)   VALUE   "３期".
               05                  PIC X(01)   VALUE   "9".
               05                  PIC X(01)   VALUE   " ".
               05                  PIC X(14)   VALUE   "月末一括請求".
           03  WRK-CONS-SAKKBN-R   REDEFINES   WRK-CONS-SAKKBN-VAL.
               05  WRK-CONS-SAKKBNLST OCCURS  4.
                   07  WRK-CONS-SAKKBNL    PIC  X(01).
                   07  WRK-CONS-SAKKBNF1L  PIC  X(01).
                   07  WRK-CONS-SAKKBNMEIL PIC  X(14).
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK5010.INC".
      *
           COPY    "CPSK5011.INC".
      *
           COPY    "CPSK5012.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    患者定期請求履歴
        01 PTTEIKIRRK-REC.
           COPY     "CPPTTEIKIRRK.INC".
      *
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *----(01.00.04) LINE ADD START ----------------------------------
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *----(01.00.04) LINE ADD END   ----------------------------------
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *     
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "O01.INC".
           COPY    "O02.INC".
           COPY    "O03.INC".
           COPY    "O99.INC".
           COPY    "OERR.INC".
           COPY    "OID1.INC".
           COPY    "OID2.INC".
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
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-O02
           MOVE    SPA-WORK        TO  SPA-O01KYOUTU
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
           MOVE    SPA-O01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-O02         TO  SPA-FREE
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
           IF      SPA-MOTOPG          =   "OERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
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
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "O02    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      ***  MOVE    1               TO  SPA-GMN-CUR
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
      *
      *        元の画面へ戻す
               IF      SPA-MOTOPG      =   "XB01"
                   MOVE    LNK-COMMON      TO  SPA-KYOTUKEY
                   MOVE    LNK-SCRSPA      TO  SPA-O02
                   MOVE    SPA-WORK        TO  SPA-O01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
               MOVE    SPA-MOTOPG          TO  WRK-MOTOPG
      *
               IF      WRK-MOTOPG(1:3)     =  "P97"  
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-O02
                   MOVE    SPA-WORK        TO  SPA-O01KYOUTU
                   PERFORM 3101-U01SPASET-SEC
                   GO      TO      300-SCREEN-EXT
               END-IF
      *         
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    作表処理
               WHEN    "OID1"
                   PERFORM 330-OID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
               WHEN    "O99"
                   PERFORM 340-OID2-SET-SEC
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
      *    ＬＤ外の項目入力編集処理
      *****************************************************************
       3101-U01SPASET-SEC              SECTION.
      *
           MOVE    LNK-KYOUTU          TO  WRK-SPA-KYOUTU
      *    受付、患者検索より
           IF      WRK-SPA-PTNUM       NOT =   SPACE
                   MOVE    WRK-SPA-PTNUM   TO  O02-PTNUM
               PERFORM 4103-PTNUM-CHK-SEC
               MOVE    5                   TO  SPA-GMN-CUR
           END-IF
           .
       3101-U01SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
      *
           INITIALIZE              SPA-O02-AREA
      *
           MOVE    SPA-SYSYMD(1:6)     TO  SPA-NAI-HYO-SRYYM
           MOVE    SPA-SYSYMDWH(1:6)   TO  SPA-NAI-HYO-SRYYMH
      *
           MOVE    1               TO  SPA-GMN-PAGE
           MOVE    4               TO  SPA-GMN-CUR
      *
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-OID1-SET-SEC            SECTION.
      *
           IF      SPA-OID1-FLG    =   "OK"
               IF      SPA-OIDCD       =   "6666"
                   MOVE    "JOIN"          TO  MCP-PUTTYPE
                   PERFORM 210-BACK-SYORI-SEC
               ELSE    
                   IF      SPA-OIDCD       =   "1002"
                       PERFORM 450-KOUSHIN-SEC
                   ELSE
                       IF      SPA-OIDCD       =   "1003"
                          PERFORM 460-CLEAR-SEC
                       ELSE
                          PERFORM 480-ZENKAI-HYOUJI-SEC
                       END-IF
                   END-IF
               END-IF
           END-IF    
      *
           MOVE    SPACE           TO  SPA-OID1-FLG
                                       SPA-O99-FLG
           MOVE    SPACE           TO  SPA-OIDCD
           .
       330-OID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ２）ＯＫ処理
      *****************************************************************
       340-OID2-SET-SEC            SECTION.
      *
           IF      SPA-O99-FLG     =   "OK"
               PERFORM 4501-NEXT-GMN-SEC
           END-IF    
      *
           MOVE    SPACE           TO  SPA-OID1-FLG
                                       SPA-O99-FLG
           MOVE    SPACE           TO  SPA-OIDCD
           MOVE    SPACE           TO  SPA-OIDCD2      
           .
       340-OID2-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *       追加
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 420-TUIKA-SEC
      *    変更
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 430-HENKOU-SEC
      *    削除
               WHEN    "CLICKED"       ALSO    "B04"
                   PERFORM 440-SAKUJYO-SEC
      *    クリア
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 460-CLEAR-OID-SEC
      *    前回作成分表示
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 480-ZENKAI-HYOUJI-OID-SEC
      *    氏名検索
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 480-KENSAKU-SEC
      *     情報削除
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-JYOUHOU-DEL-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-TOUROKU-SEC
      *    処理確認
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 490-KAKUNIN-SEC
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
      *
               WHEN    "ACTIVATE"      ALSO    "RENNUM"
                   PERFORM 4102-RENNUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "PTNUM"
                   PERFORM 4103-PTNUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SRYYM"
                   PERFORM 4104-SRYYM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SAKKBN"
                   PERFORM 4105-SAKKBN-CHK-SEC
               WHEN    ANY             ALSO    "TEIKILST"
                   PERFORM 4106-TEIKISEL-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択　入力処理
      *****************************************************************
       4102-RENNUM-CHK-SEC         SECTION.
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
                                       SPA-NAI-KOUMOKU
           INITIALIZE                  SPA-GMN-SAKKBNLST-G
                                       SPA-GMN-SAKKBN-MAX
                                      
           MOVE    ZERO               TO  SPA-NAI-SELNO
      *
           MOVE    3                  TO  SPA-GMN-CUR
      *
           MOVE    O02-RENNUM         TO  SPA-GMN-RENNUM
      *
           IF      SPA-GMN-RENNUM      =   ZERO
               IF      SPA-GMN-MAX         =   100
                   MOVE    "0002"              TO  SPA-ERRCD
               ELSE
                   MOVE    4                   TO  SPA-GMN-CUR
               END-IF
               GO  TO  4102-RENNUM-CHK-EXT
           END-IF
      *
           IF      SPA-GMN-RENNUM      >   SPA-GMN-MAX
               MOVE    "0001"          TO  SPA-ERRCD
               GO      TO      4102-RENNUM-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-RENNUM      TO  SPA-NAI-SELNO
      *
           PERFORM 41021-RENNUM-HENSYU-SEC
      *
           .
       4102-RENNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択項目編集処理
      *****************************************************************
       41021-RENNUM-HENSYU-SEC            SECTION.
      *
           MOVE    SPA-GMN-TPTNUM     (SPA-GMN-RENNUM)
                                       TO  SPA-GMN-PTNUM
           MOVE    SPA-NAI-TPTID      (SPA-GMN-RENNUM)
                                       TO  SPA-NAI-PTID
           MOVE    SPA-GMN-TNAME      (SPA-GMN-RENNUM)
                                       TO  SPA-GMN-NAME
           MOVE    SPA-GMN-TSRYYM     (SPA-GMN-RENNUM)
                                       TO  SPA-GMN-SRYYM
           MOVE    SPA-NAI-TSRYYM     (SPA-GMN-RENNUM)
                                       TO  SPA-NAI-SRYYM
      *
           PERFORM 4150-SAKKBN-SET-SEC
      *
           PERFORM VARYING IDX1    FROM 1  BY  1
                   UNTIL ( IDX1    >    SPA-GMN-SAKKBN-MAX )
               IF    ( SPA-NAI-TSAKKBN (SPA-GMN-RENNUM)
                                       =  SPA-GMN-SAKKBNL (IDX1) )
                   MOVE    SPA-GMN-SAKKBNLST (IDX1)
                                                   TO  SPA-GMN-SAKKBN-G
                   MOVE    SPA-NAI-SKYINF-SKYSTYMD (IDX1)
                                                   TO  SPA-NAI-SKYSTYMD
                   MOVE    SPA-NAI-SKYINF-SKYEDYMD (IDX1)
                                                   TO  SPA-NAI-SKYEDYMD
                   MOVE    SPA-NAI-SKYINF-NYUINYMD (IDX1)
                                                   TO  SPA-NAI-NYUINYMD
                   MOVE    SPA-NAI-SKYINF-TAIINYMD (IDX1)
                                                   TO  SPA-NAI-TAIINYMD
                   MOVE    1                       TO  WRK-HENFLG
                   MOVE    SPA-GMN-SAKKBN-MAX      TO  IDX1
               END-IF
           END-PERFORM
      *
           MOVE    4                   TO  SPA-GMN-CUR 
      *
           .
       41021-RENNUM-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
       4103-PTNUM-CHK-SEC            SECTION.
      *
           INITIALIZE                  SPA-GMN-SAKKBN-G
                                       SPA-GMN-SAKKBNLST-G
                                       SPA-GMN-SAKKBN-MAX
                                       SPA-NAI-SKYINF
      *
           MOVE    4                   TO  SPA-GMN-CUR
      *
      *
           MOVE    O02-PTNUM           TO  SPA-GMN-PTNUM
      *
           MOVE    SPACE               TO  SPA-GMN-NAME
           MOVE    ZERO                TO  SPA-NAI-PTID 
      *
           INITIALIZE                  ORCSPTIDAREA
           MOVE    SPA-HOSPID          TO  SPTID-HOSPID
           MOVE    SPA-GMN-PTNUM       TO  SPTID-PTNUM
           CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                               SPA-1009-TBL
           IF      SPTID-RC        NOT =   ZERO
               MOVE    "0003"          TO  SPA-ERRCD
               GO  TO                  4103-PTNUM-CHK-EXT
           END-IF
           MOVE    SPTID-PTNUM         TO  SPA-GMN-PTNUM
           MOVE    SPTID-PTID          TO  SPA-NAI-PTID
      *
      *    患者マスター存在チェック
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-NAI-PTID        TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           NOT =   ZERO
               MOVE    "0001"              TO  SPA-ERRCD
               GO      TO      4103-PTNUM-CHK-EXT
           END-IF
      *
           MOVE    PTINF-NAME        TO  SPA-GMN-NAME
      *
           MOVE    5                 TO  SPA-GMN-CUR
           .
       4103-PTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求年月チェック処理
      *****************************************************************
       4104-SRYYM-CHK-SEC          SECTION.
      *
           MOVE    5                  TO   SPA-GMN-CUR
      *
           MOVE   O02-SRYYM           TO  SPA-GMN-SRYYM
      *
      *
           IF    ( SPA-GMN-SRYYM      =   SPACE )
               MOVE    SPA-NAI-HYO-SRYYM   TO  SPA-NAI-SRYYM
               MOVE    SPA-NAI-HYO-SRYYMH  TO  SPA-GMN-SRYYM
           ELSE
      *    日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-SRYYM       TO  SGDAY-INDAY
               MOVE    "1"                 TO  SGDAY-INTYPE
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF    ( SGDAY-RC            =   ZERO )
                   MOVE    SGDAY-OTDAY(1:6)    TO  SPA-GMN-SRYYM
                   MOVE    SGDAY-SDAY (1:6)    TO  SPA-NAI-SRYYM
               ELSE
                   MOVE    "0001"          TO  SPA-ERRCD
                   GO  TO  4104-SRYYM-CHK-EXT
               END-IF
           END-IF
      *
      *    作成区分設定処理
           PERFORM 4150-SAKKBN-SET-SEC
           IF    ( SPA-ERRCD   NOT =   SPACE )
               GO  TO  4104-SRYYM-CHK-EXT
           END-IF
      *
           IF    ( SPA-GMN-SAKKBN-MAX      =   1 )
               MOVE    SPA-GMN-SAKKBNLST (1)
                                           TO  SPA-GMN-SAKKBN-G
           END-IF
      *
           MOVE    6                       TO  SPA-GMN-CUR
      *
           .
       4104-SRYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    作成区分  入力処理
      *****************************************************************
       4105-SAKKBN-CHK-SEC                 SECTION.
      *
           INITIALIZE                  SPA-NAI-SKYSTYMD
                                       SPA-NAI-SKYEDYMD
                                       SPA-NAI-NYUINYMD
                                       SPA-NAI-TAIINYMD
      *
           MOVE    6                   TO  SPA-GMN-CUR
      *
           MOVE    O02-SAKKBN          TO  SPA-GMN-SAKKBN-G
      *
           IF      SPA-GMN-SAKKBN      =   SPACE
               MOVE   SPA-GMN-SAKKBNLST (1)
                                       TO  SPA-GMN-SAKKBN-G
           END-IF
      *
           MOVE    ZERO                TO WRK-HENFLG
           PERFORM VARYING IDX1    FROM 1  BY  1
                   UNTIL ( IDX1    >    SPA-GMN-SAKKBN-MAX )
               IF    ( SPA-GMN-SAKKBN   =  SPA-GMN-SAKKBNL (IDX1) )
                   MOVE    SPA-GMN-SAKKBNLST (IDX1)
                                                   TO  SPA-GMN-SAKKBN-G
                   MOVE    SPA-NAI-SKYINF-SKYSTYMD (IDX1)
                                                   TO  SPA-NAI-SKYSTYMD
                   MOVE    SPA-NAI-SKYINF-SKYEDYMD (IDX1)
                                                   TO  SPA-NAI-SKYEDYMD
                   MOVE    SPA-NAI-SKYINF-NYUINYMD (IDX1)
                                                   TO  SPA-NAI-NYUINYMD
                   MOVE    SPA-NAI-SKYINF-TAIINYMD (IDX1)
                                                   TO  SPA-NAI-TAIINYMD
                   MOVE    1                       TO  WRK-HENFLG
                   MOVE    SPA-GMN-SAKKBN-MAX      TO  IDX1
               END-IF
           END-PERFORM
      *
           IF    ( WRK-HENFLG          =   ZERO )
               MOVE    "0001"               TO  SPA-ERRCD
               GO  TO  4105-SAKKBN-CHK-EXT
           END-IF 
      *
           .
       4105-SAKKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       4106-TEIKISEL-SEC       SECTION.
      *
      *    行選択
           MOVE    ZERO                TO  WRK-SELNO
      *
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL     ( IDX1    >       100 )
               IF      O02-SELECT (IDX1)   =   "T"
                   IF    ( IDX1            =   SPA-NAI-SELNO )
                       CONTINUE
                   ELSE        
                       MOVE    IDX1            TO  WRK-SELNO
                       MOVE    100             TO  IDX1
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF    ( WRK-SELNO           >   ZERO )
               MOVE    WRK-SELNO           TO  SPA-NAI-SELNO
           END-IF
      *
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
           INITIALIZE                  SPA-NAI-KOUMOKU
           INITIALIZE                  SPA-GMN-SAKKBNLST-G
                                       SPA-GMN-SAKKBN-MAX
      *
           MOVE    SPA-GMN-TRENNUM (SPA-NAI-SELNO)
                                       TO  SPA-GMN-RENNUM
      *
           PERFORM 41021-RENNUM-HENSYU-SEC
           .
       4106-TEIKISEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    作成区分設定処理
      *****************************************************************
       4150-SAKKBN-SET-SEC                 SECTION.
      *
           INITIALIZE                      SPA-GMN-SAKKBN-G
                                           SPA-GMN-SAKKBNLST-G
                                           SPA-GMN-SAKKBN-MAX
                                           SPA-NAI-SKYINF
                                           WRK-GETUMATU-AREA
      *
           PERFORM 4150-TEIKI-KIKAN-GET-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  4150-SAKKBN-SET-EXT
           END-IF
      *
           MOVE    1                   TO  IDX1
           MOVE    ZERO                TO  FLG-GETUMATU
           MOVE    SPACE               TO  WRK-GETUMATU-SKYSTYMD
           MOVE    WRK-KIKAN-SKYEDYMD (WRK-KIKAN-MAX)
                                       TO  WRK-GETUMATU-SKYEDYMD
           PERFORM UNTIL ( IDX1        >   WRK-KIKAN-MAX )
      *
               MOVE    ZERO                TO  FLG-KIKAN
      *
               MOVE    WRK-KIKAN-SKYEDYMD(IDX1)
                                           TO  WRK-SYMD
               PERFORM 4150-PTNYUINRRK-SEL-SEC
               IF    ( FLG-PTNYUINRRK  =   ZERO )
                   MOVE    WRK-KIKAN-SKYSTYMD (IDX1)  TO  WRK-STYMD
                   MOVE    WRK-KIKAN-SKYEDYMD (IDX1)  TO  WRK-EDYMD
                   PERFORM 4150-SYUNOU-SEL-SEC
                   IF    ( FLG-SYUARI  =   1 )
                       MOVE    1   TO  FLG-KIKAN
                   END-IF
      *            IF    ( PTNYUINRRK-TEIKI-SEIKYUKBN  =   "2" )
      *             AND  ( PTNYUINRRK-TAIINYMD >   WRK-KIKAN-SKYEDYMD
      *                                              (WRK-KIKAN-MAX))
                   IF    ( PTNYUINRRK-TAIINYMD >   WRK-KIKAN-SKYEDYMD
                                                     (WRK-KIKAN-MAX))
                    AND  ( FLG-SYUARI  =   ZERO )
      *                MOVE    1       TO  FLG-KIKAN
                       MOVE    1       TO  FLG-GETUMATU
                       IF    ( PTNYUINRRK-NYUINYMD
                                       <   WRK-KIKAN-SKYSTYMD(1) )
                           MOVE    WRK-KIKAN-SKYSTYMD(1)
                                           TO  WRK-GETUMATU-SKYSTYMD
                       ELSE
                            MOVE    PTNYUINRRK-NYUINYMD
                                           TO  WRK-GETUMATU-SKYSTYMD
                       END-IF
                       MOVE    PTNYUINRRK-NYUINYMD
                                           TO  WRK-GETUMATU-NYUINYMD
                       MOVE    PTNYUINRRK-TAIINYMD
                                           TO  WRK-GETUMATU-TAIINYMD
                   END-IF
                   PERFORM VARYING IDX2    FROM    IDX1    BY  1
                           UNTIL ( IDX2    >   WRK-KIKAN-MAX )
                            OR   ( PTNYUINRRK-TAIINYMD
                                      <   WRK-KIKAN-SKYEDYMD (IDX2))
                       MOVE    FLG-KIKAN   TO  WRK-KIKAN-FLG (IDX2)
                       IF    ( PTNYUINRRK-NYUINYMD
                                      >=   WRK-KIKAN-SKYSTYMD (IDX2))
                         AND ( PTNYUINRRK-NYUINYMD
                                      <=   WRK-KIKAN-SKYEDYMD (IDX2))
                           MOVE    PTNYUINRRK-NYUINYMD
                                           TO  WRK-KIKAN-SKYSTYMD (IDX2)
                       END-IF
                       MOVE    PTNYUINRRK-NYUINYMD
                                           TO  WRK-KIKAN-NYUINYMD (IDX2)
                       MOVE    PTNYUINRRK-TAIINYMD
                                           TO  WRK-KIKAN-TAIINYMD (IDX2)
                       DISPLAY "PTNYUINRRK-NYUINYMD = " 
                                PTNYUINRRK-NYUINYMD
                   END-PERFORM
                   MOVE    IDX2            TO  IDX1
               ELSE
                   MOVE    1               TO  WRK-KIKAN-FLG (IDX1)
                   COMPUTE IDX1    =   IDX1    +   1
               END-IF
      *
           END-PERFORM
      *
      *    患者定期履歴検索
           MOVE    ZERO                TO  FLG-PTTEIKIRRK
           INITIALIZE                  PTTEIKIRRK-REC
           MOVE    SPA-NAI-SRYYM       TO  PTTEIKIRRK-SRYYM
           MOVE    SPA-HOSPID          TO  PTTEIKIRRK-HOSPID
           MOVE    SPA-NAI-PTID        TO  PTTEIKIRRK-PTID
           MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTTEIKIRRK-KEY2"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               PERFORM 910-PTTEIKIRRK-KEY2-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTTEIKIRRK
           END-IF
      *
           PERFORM UNTIL ( FLG-PTTEIKIRRK  NOT =   ZERO )
               MOVE    ZERO            TO  IDX1
               EVALUATE    PTTEIKIRRK-SAKKBN
               WHEN    "1"
                   MOVE    1           TO  IDX1
               WHEN    "2"
                   MOVE    2           TO  IDX1
               WHEN    "3"
                   MOVE    3           TO  IDX1
               WHEN    "9"
                   MOVE    2           TO  FLG-GETUMATU
                   MOVE    PTTEIKIRRK-SKYSTYMD
                                       TO  WRK-GETUMATU-SKYSTYMD
                   MOVE    PTTEIKIRRK-SKYEDYMD
                                       TO  WRK-GETUMATU-SKYEDYMD
               END-EVALUATE
      *
               IF    ( IDX1            >   ZERO )
                   MOVE    ZERO        TO  WRK-KIKAN-FLG   (IDX1)
                   MOVE    PTTEIKIRRK-SKYSTYMD
                                       TO  WRK-KIKAN-SKYSTYMD (IDX1)
                   MOVE    PTTEIKIRRK-SKYEDYMD
                                       TO  WRK-KIKAN-SKYEDYMD (IDX1)
               END-IF
      *
               PERFORM 910-PTTEIKIRRK-KEY2-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTTEIKIRRK-KEY2"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           MOVE    ZERO                TO  IDX2
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >       WRK-KIKAN-MAX )
               IF    ( WRK-KIKAN-FLG (IDX1)    =   ZERO )
                   COMPUTE IDX2    =   IDX2    +   1
                   MOVE    IDX2    TO  SPA-GMN-SAKKBN-MAX
      *
                   MOVE    WRK-CONS-SAKKBNLST (IDX1)
                                   TO  SPA-GMN-SAKKBNLST (IDX2)
                   MOVE    WRK-KIKAN-SKYSTYMD (IDX1)
                                   TO  SPA-NAI-SKYINF-SKYSTYMD (IDX2)
                   MOVE    WRK-KIKAN-SKYEDYMD (IDX1)
                                   TO  SPA-NAI-SKYINF-SKYEDYMD (IDX2)
                   MOVE    WRK-KIKAN-NYUINYMD (IDX1)
                                   TO  SPA-NAI-SKYINF-NYUINYMD (IDX2)
                   MOVE    WRK-KIKAN-TAIINYMD (IDX1)
                                   TO  SPA-NAI-SKYINF-TAIINYMD (IDX2)
               END-IF
           END-PERFORM
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >       SPA-GMN-SAKKBN-MAX )
               DISPLAY "SPA-NAI-SKYINF-SKYSTYMD (" IDX1 ") = "
                        SPA-NAI-SKYINF-SKYSTYMD (IDX1)
               DISPLAY "SPA-NAI-SKYINF-SKYEDYMD (" IDX1 ") = "
                        SPA-NAI-SKYINF-SKYEDYMD (IDX1)
               DISPLAY "SPA-NAI-SKYINF-NYUINYMD (" IDX1 ") = "
                        SPA-NAI-SKYINF-NYUINYMD (IDX1)
               DISPLAY "SPA-NAI-SKYINF-TAIINYMD (" IDX1 ") = "
                        SPA-NAI-SKYINF-TAIINYMD (IDX1)
           END-PERFORM
           DISPLAY "WRK-GETUMATU-SKYSTYMD = " WRK-GETUMATU-SKYSTYMD
           DISPLAY "WRK-GETUMATU-SKYEDYMD = " WRK-GETUMATU-SKYEDYMD
      *
           IF    ( FLG-GETUMATU    =   2 )
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   WRK-KIKAN-MAX )
                   IF    ( WRK-GETUMATU-SKYSTYMD
                               >=  WRK-KIKAN-SKYSTYMD (IDX1) )
                     AND ( WRK-GETUMATU-SKYSTYMD
                               <=  WRK-KIKAN-SKYEDYMD (IDX1) )
                       MOVE    WRK-KIKAN-NYUINYMD (IDX1)
                                   TO  WRK-GETUMATU-NYUINYMD
                       MOVE    WRK-KIKAN-TAIINYMD (IDX1)
                                   TO  WRK-GETUMATU-TAIINYMD
                       MOVE    WRK-KIKAN-MAX
                                   TO  IDX1
                   END-IF
               END-PERFORM
      *
               MOVE    ZERO        TO  WRK-MAX
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   SPA-GMN-SAKKBN-MAX )
                   MOVE    IDX1        TO  WRK-MAX
                   IF    ( WRK-GETUMATU-SKYSTYMD
                               >=  SPA-NAI-SKYINF-SKYSTYMD (IDX1) )
                     AND ( WRK-GETUMATU-SKYSTYMD
                               <=  SPA-NAI-SKYINF-SKYEDYMD (IDX1) )
                       COMPUTE WRK-MAX =   IDX1    -   1
                       PERFORM VARYING IDX2    FROM    IDX1    BY  1
                               UNTIL ( IDX2    >   SPA-GMN-SAKKBN-MAX )
                           INITIALIZE  SPA-NAI-SKYINF-OCC (IDX2)
                                       SPA-GMN-SAKKBNLST  (IDX2)
                       END-PERFORM
                       MOVE    SPA-GMN-SAKKBN-MAX  TO  IDX1
                   END-IF
               END-PERFORM
      *
               MOVE    WRK-MAX         TO  SPA-GMN-SAKKBN-MAX
      *
           END-IF
      *
           IF    ( FLG-GETUMATU    NOT =   ZERO )
               COMPUTE SPA-GMN-SAKKBN-MAX
                   =   SPA-GMN-SAKKBN-MAX  +   1
               MOVE    SPA-GMN-SAKKBN-MAX  TO  IDX2
               MOVE    WRK-CONS-SAKKBNLST (4)
                                   TO  SPA-GMN-SAKKBNLST (IDX2)
               MOVE    WRK-GETUMATU-SKYSTYMD
                                   TO  SPA-NAI-SKYINF-SKYSTYMD (IDX2)
               MOVE    WRK-GETUMATU-SKYEDYMD
                                   TO  SPA-NAI-SKYINF-SKYEDYMD (IDX2)
               MOVE    WRK-GETUMATU-NYUINYMD
                                   TO  SPA-NAI-SKYINF-NYUINYMD (IDX2)
               MOVE    WRK-GETUMATU-TAIINYMD
                                   TO  SPA-NAI-SKYINF-TAIINYMD (IDX2)
           END-IF
      *
           IF    ( SPA-GMN-SAKKBN-MAX  =   ZERO )
               MOVE    "0006"          TO  SPA-ERRCD
           END-IF
      *
           .
       4150-SAKKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    定期請求期間取得処理
      *****************************************************************
       4150-TEIKI-KIKAN-GET-SEC        SECTION.
      *
           INITIALIZE                  WRK-KIKAN-AREA
      *
           INITIALIZE                      SYS-5010-REC
           MOVE    "5010"              TO  SYS-5010-KANRICD
           MOVE    "*"                 TO  SYS-5010-KBNCD
           MOVE    SPA-NAI-SRYYM       TO  ORC-DBYMD
           MOVE    "01"                TO  ORC-DBYMD (7 : 2)
           MOVE    SYS-5010-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-5010-REC
           ELSE
               MOVE    "0007"          TO  SPA-ERRCD
               GO  TO  4150-TEIKI-KIKAN-GET-EXT
           END-IF
      *
           MOVE    1                   TO  WRK-STDAY
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1        >   3 )
                    OR   ( SYS-5010-SEIKYU-DAY (IDX1)  =   ZERO )
      *
               MOVE    IDX1            TO  WRK-KIKAN-MAX
      *
               MOVE    SPA-NAI-SRYYM   TO  WRK-SYMD
               MOVE    WRK-STDAY       TO  WRK-SYMD (7 : 2)
               MOVE    WRK-SYMD        TO  WRK-KIKAN-SKYSTYMD (IDX1)
      *
               IF    ( SYS-5010-SEIKYU-DAY (IDX1)  =   99 )
                   INITIALIZE                  STS-AREA-DAY
                   INITIALIZE                  LNK-DAY1-AREA
                   MOVE    "71"                TO   LNK-DAY7-IRAI
                   MOVE    SPA-NAI-SRYYM       TO   LNK-DAY7-YM
                   CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                       LNK-DAY7-AREA
                   MOVE    LNK-DAY7-KOYOMI
                                       TO  WRK-KIKAN-SKYEDYMD (IDX1)
               ELSE
                   MOVE    SPA-NAI-SRYYM   TO  WRK-SYMD
                   MOVE    SYS-5010-SEIKYU-DAY (IDX1)
                                       TO  WRK-SYMD (7 : 2)
                   MOVE    WRK-SYMD    TO  WRK-KIKAN-SKYEDYMD (IDX1)
      *
                   COMPUTE WRK-STDAY   =   SYS-5010-SEIKYU-DAY (IDX1)
                                       +   1
      *
               END-IF
      *
           END-PERFORM
      *
           .
       4150-TEIKI-KIKAN-GET-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴検索処理
      *****************************************************************
       4150-PTNYUINRRK-SEL-SEC         SECTION.
      *
      *    入院履歴チェック
           INITIALIZE                  PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    SPA-NAI-PTID        TO  PTNYUINRRK-PTID
           MOVE    WRK-SYMD            TO  PTNYUINRRK-NYUINYMD
           MOVE    WRK-SYMD            TO  PTNYUINRRK-TAIINYMD
           PERFORM 900-PTNYUINRRK-KEY10-SEL-SEC
      *
           .
       4150-PTNYUINRRK-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納マスタ検索処理
      *****************************************************************
       4150-SYUNOU-SEL-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUARI
      *
           IF    ( PTNYUINRRK-TAIINYMD =   "99999999" )
               GO  TO  4150-SYUNOU-SEL-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-SYUNOU
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    SPA-NAI-PTID        TO  SYU-PTID
           MOVE    SPA-NAI-SRYYM       TO  SYU-SRYYMD (1 : 6)
           MOVE    "__"                TO  SYU-SRYYMD (7 : 2)
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY6"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               PERFORM 910-SYUNOU-KEY6-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           PERFORM UNTIL ( FLG-SYUARI  =   1 )
                    OR   ( FLG-SYUNOU  =   1 )
               IF    ( SYU-DENPJTIKBN  NOT =   "3" )
                   IF    ( SYU-CREATEKBN   =   "1" )
                    AND  ( SYU-SKYSTYMD   <=   WRK-EDYMD )
                    AND  ( SYU-SKYEDYMD   >=   WRK-STYMD )
                       MOVE    1           TO  FLG-SYUARI
                   END-IF
               END-IF
      *
               PERFORM 910-SYUNOU-KEY6-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY6"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       4150-SYUNOU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC 
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               IF      JOB-ENDYMD      =   SPACE
      *********AND     JOB-TERMID      =   SPA-TERMID
                   MOVE    "6666"          TO  SPA-OIDCD
                   GO  TO  210-BACK-EXT
               END-IF
           END-IF
      *
           PERFORM 210-BACK-SYORI-SEC         
           .
       210-BACK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      *
           MOVE    "O01"               TO  SPA-SAKIPG
           MOVE    "O02"               TO  SPA-MOTOPG
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    追加　処理
      *****************************************************************
       420-TUIKA-SEC                SECTION.
      *
           IF      SPA-GMN-RENNUM      >   ZERO
               MOVE    "0005"              TO  SPA-ERRCD
               GO  TO  420-TUIKA-EXT
           END-IF
      *
           IF      SPA-GMN-MAX      =   100
               MOVE    "0002"               TO  SPA-ERRCD
               GO      TO      420-TUIKA-EXT
           END-IF
      *
           PERFORM 4203-KOMOKUCHK-SEC
           IF      SPA-ERRCD    NOT =   SPACE
               GO  TO  420-TUIKA-EXT
           END-IF    
      *
           COMPUTE IDX2    =   SPA-GMN-MAX  +   1
           PERFORM 4202-INTBL-CHK-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  420-TUIKA-EXT
           END-IF
      *    
           ADD     1                TO  SPA-GMN-MAX
           MOVE    SPA-GMN-MAX      TO
                                SPA-GMN-TRENNUM   (SPA-GMN-MAX)
           MOVE    SPA-GMN-MAX          TO  IDX1
           PERFORM 4201-INTBL-SET-SEC
      *
           MOVE    4                TO  SPA-GMN-CUR  
      *
           .
       420-TUIKA-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4203-KOMOKUCHK-SEC           SECTION.
      *
           MOVE    SPACE                TO  SPA-ERRCD
           MOVE    SPA-GMN-CUR          TO  WRK-GMN-CUR
      * 
           PERFORM 4103-PTNUM-CHK-SEC
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4104-SRYYM-CHK-SEC
           END-IF
           IF      SPA-ERRCD            =   SPACE
               PERFORM 4105-SAKKBN-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD            =   SPACE
               MOVE    WRK-GMN-CUR          TO  SPA-GMN-CUR
           END-IF             
           .
       4203-KOMOKUCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目重複チェック処理
      *****************************************************************
       4202-INTBL-CHK-SEC                SECTION.
      *
           MOVE    SPACE                   TO  SPA-ERRCD
      * 
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL   IDX1    >       100
               IF      IDX1        =   IDX2
                   CONTINUE
               ELSE
                   IF    ( SPA-NAI-TPTID   (IDX1)  =   SPA-NAI-PTID    )
                   AND   ( SPA-GMN-TSRYYM  (IDX1)  =   SPA-GMN-SRYYM   )
                   AND  (( SPA-NAI-TSKYSTYMD (IDX1)
                                              <=   SPA-NAI-SKYEDYMD )
                     AND ( SPA-NAI-TSKYEDYMD (IDX1)
                                              >=   SPA-NAI-SKYSTYMD ))
                       MOVE    "0008"              TO  SPA-ERRCD
                       MOVE    100                 TO  IDX1
                   END-IF
               END-IF
           END-PERFORM
           .                   
       4202-INTBL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目編集処理
      *****************************************************************
       4201-INTBL-SET-SEC                SECTION.
      *
      *
           MOVE    SPA-GMN-PTNUM       TO  SPA-GMN-TPTNUM     (IDX1)
           MOVE    SPA-NAI-PTID        TO  SPA-NAI-TPTID      (IDX1)
           MOVE    SPA-GMN-NAME        TO  SPA-GMN-TNAME      (IDX1)
           MOVE    SPA-GMN-SRYYM       TO  SPA-GMN-TSRYYM     (IDX1)
           MOVE    SPA-NAI-SRYYM       TO  SPA-NAI-TSRYYM     (IDX1)
           MOVE    SPA-GMN-SAKKBNMEI   TO  SPA-GMN-TSAKKBN    (IDX1)
           MOVE    SPA-GMN-SAKKBN      TO  SPA-NAI-TSAKKBN    (IDX1)
           MOVE    SPA-NAI-SKYSTYMD    TO  SPA-NAI-TSKYSTYMD  (IDX1)
           MOVE    SPA-NAI-SKYEDYMD    TO  SPA-NAI-TSKYEDYMD  (IDX1)
           MOVE    SPA-NAI-NYUINYMD    TO  SPA-NAI-TNYUINYMD  (IDX1)
           MOVE    SPA-NAI-TAIINYMD    TO  SPA-NAI-TTAIINYMD  (IDX1)
      *
           MOVE    SPA-NAI-SKYSTYMD    TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-TSKYKIKAN-ST(IDX1)
      *
           MOVE    " - "               TO  SPA-GMN-TSKYKIKAN-FIL(IDX1)
      *
           MOVE    SPA-NAI-SKYEDYMD    TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-TSKYKIKAN-ED(IDX1)
      *
           MOVE    SPA-NAI-NYUINYMD    TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG         TO  SPA-GMN-TNYUINYMD(IDX1)
      *
           IF    ( SPA-NAI-TAIINYMD    =   "99999999" )
               MOVE    "入院中"        TO  SPA-GMN-TTAIINYMD(IDX1)
           ELSE
               MOVE    SPA-NAI-TAIINYMD    TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG     TO  SPA-GMN-TTAIINYMD(IDX1)
           END-IF
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
                                       SPA-NAI-KOUMOKU
           INITIALIZE                  SPA-GMN-SAKKBNLST-G
                                       SPA-GMN-SAKKBN-MAX
           MOVE    ZERO                TO  SPA-NAI-SELNO
      *
          .
       4201-INTBL-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    変更　処理
      *****************************************************************
       430-HENKOU-SEC              SECTION.
      *
           IF      SPA-GMN-RENNUM  =   ZERO
               MOVE    "0004"              TO  SPA-ERRCD
               GO  TO  430-HENKOU-EXT
           END-IF
      *
           PERFORM 4203-KOMOKUCHK-SEC
           IF      SPA-ERRCD    NOT =   SPACE
               GO  TO  430-HENKOU-EXT
           END-IF    
      *
           MOVE    SPA-GMN-RENNUM  TO  IDX2
      *
           PERFORM 4202-INTBL-CHK-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  430-HENKOU-EXT
           END-IF
      *
           MOVE    SPA-GMN-RENNUM  TO  IDX1
      *
           PERFORM 4201-INTBL-SET-SEC
      *
           MOVE    4                   TO  SPA-GMN-CUR 
      *
          .
       430-HENKOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除　処理
      *****************************************************************
       440-SAKUJYO-SEC             SECTION.
      *
           IF      SPA-GMN-RENNUM  =   ZERO
               MOVE    "0004"              TO  SPA-ERRCD
               GO  TO  440-SAKUJYO-EXT
           END-IF
      *
           MOVE    SPA-GMN-RENNUM  TO  IDX1
           INITIALIZE              SPA-GMN-TBL-G (IDX1)
           INITIALIZE              SPA-NAI-TBL-G (IDX1)
      *
           INITIALIZE              WRK-GMN-SORT
           MOVE    SPA-GMN-TBL     TO  WRK-GMN-TBL
           MOVE    SPA-NAI-TBL     TO  WRK-NAI-TBL
           INITIALIZE              SPA-GMN-TBL
           INITIALIZE              SPA-NAI-TBL
           MOVE    ZERO            TO  IDX2
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL       IDX1    >   100
               IF    ( WRK-GMN-TRENNUM  (IDX1) =   ZERO )
                   CONTINUE
               ELSE
                   ADD     1                       TO
                                               IDX2
                   MOVE    WRK-GMN-TBL-G (IDX1)    TO
                                               SPA-GMN-TBL-G (IDX2)
                   MOVE    WRK-NAI-TBL-G (IDX1)    TO
                                               SPA-NAI-TBL-G (IDX2)
                   MOVE    IDX2                    TO
                                               SPA-GMN-TRENNUM(IDX2)
               END-IF
           END-PERFORM
           MOVE    IDX2                TO  SPA-GMN-MAX
      *
           INITIALIZE                  SPA-GMN-KOUMOKU
                                       SPA-NAI-KOUMOKU
           INITIALIZE                  SPA-GMN-SAKKBNLST-G
                                       SPA-GMN-SAKKBN-MAX
      *
           MOVE    4                   TO  SPA-GMN-CUR
      *
          .
       440-SAKUJYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア　確認処理
      *****************************************************************
       460-CLEAR-OID-SEC             SECTION.
      *
           MOVE    "1003"             TO  SPA-OIDCD
          .
       460-CLEAR-OID-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア　処理
      *****************************************************************
       460-CLEAR-SEC             SECTION.
      *
           MOVE    ZERO                  TO  SPA-GMN-MAX
           INITIALIZE                    SPA-GMN-TBL
                                         SPA-NAI-TBL
                                         SPA-GMN-KOUMOKU
                                         SPA-NAI-KOUMOKU
           INITIALIZE                    SPA-GMN-SAKKBNLST-G
                                         SPA-GMN-SAKKBN-MAX
           MOVE    ZERO                  TO  SPA-NAI-SELNO
      *
           MOVE    3                     TO  SPA-GMN-CUR
      *
          .
       460-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    前回作成分表示　確認処理
      *****************************************************************
       480-ZENKAI-HYOUJI-OID-SEC      SECTION.
      *
           MOVE    "1004"             TO  SPA-OIDCD
          .
       460-CLEAR-OID-EXT.
           EXIT.
      *
      *****************************************************************
      *    前回作成分表示　処理
      *****************************************************************
       480-ZENKAI-HYOUJI-SEC             SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI-SELNO
      *
      *    定期請求指示コード
           INITIALIZE                  SYS-5011-REC
           MOVE    "5011"              TO  SYS-5011-KANRICD
           MOVE    "*"                 TO  SYS-5011-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-5011-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC         TO  SYS-5011-REC
               IF    ( SYS-5011-SYOKBN     =   "1" )
                   MOVE    "0011"                 TO  SPA-ERRCD
                   GO  TO  480-ZENKAI-HYOUJI-EXT
               END-IF
           END-IF
      *
      *    定期請求指示（個別指示）コード読み込み
           INITIALIZE                      SYS-5012-REC
           MOVE    "5012"              TO  SYS-5012-KANRICD
           MOVE    ZERO                TO  ORC-DBYMD
           MOVE    SYS-5012-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF    ( MCP-RC               =   ZERO )
               MOVE    "SYSKANRI-KEY2"  TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                  TO  SPA-GMN-MAX
           INITIALIZE                    SPA-GMN-TBL
                                         SPA-NAI-TBL
                                         SPA-GMN-KOUMOKU
                                         SPA-NAI-KOUMOKU
           INITIALIZE                    SPA-GMN-SAKKBNLST-G
                                         SPA-GMN-SAKKBN-MAX
      *
           PERFORM             UNTIL     ( FLG-SYSKANRI    =   1 )
               MOVE    MCPDATA-REC     TO  SYS-5012-REC
               ADD     1               TO  SPA-GMN-MAX
               MOVE    SPA-GMN-MAX     TO  SPA-GMN-TRENNUM(SPA-GMN-MAX)
      *
               PERFORM VARYING IDX1    FROM 1  BY  1
                   UNTIL ( IDX1    >    WRK-CONS-SAKKBN-MAX )
                   IF    ( SYS-5012-SAKKBN  =  WRK-CONS-SAKKBNL (IDX1) )
                       MOVE    WRK-CONS-SAKKBNMEIL (IDX1)
                                       TO  SPA-GMN-TSAKKBN (SPA-GMN-MAX)
                       MOVE    WRK-CONS-SAKKBNL (IDX1)
                                       TO  SPA-NAI-TSAKKBN (SPA-GMN-MAX)
                       MOVE    1                       TO  WRK-HENFLG
                       MOVE    WRK-CONS-SAKKBN-MAX     TO  IDX1
                   END-IF
               END-PERFORM
      *
               MOVE    SYS-5012-PTID   TO  SPA-NAI-TPTID  (SPA-GMN-MAX)
               INITIALIZE                  ORCSPTIDAREA
               MOVE    SPA-HOSPID      TO  SPTID-HOSPID
               MOVE    SPA-NAI-TPTID (SPA-GMN-MAX)
                                       TO  SPTID-PTID
               CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                                SPA-1009-TBL
               IF      SPTID-RC        =   ZERO
                   MOVE    SPTID-PTNUM TO  SPA-GMN-TPTNUM(SPA-GMN-MAX)
               END-IF
               MOVE    SPA-HOSPID      TO  PTINF-HOSPID
               MOVE    SPA-NAI-TPTID (SPA-GMN-MAX)
                                       TO  PTINF-PTID
               PERFORM 900-PTINF-READ-SEC
               IF      FLG-PTINF       =   ZERO
                   MOVE    PTINF-NAME  TO  SPA-GMN-TNAME (SPA-GMN-MAX)
               END-IF
      *
               MOVE    SYS-5012-SRYYM  TO  SPA-NAI-TSRYYM (SPA-GMN-MAX)
               MOVE    SPA-NAI-TSRYYM (SPA-GMN-MAX)
                                       TO  WRK-SYMD(1:6)
               MOVE    "01"            TO  WRK-SYMD(7:2)
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG(1:6)
                                       TO  SPA-GMN-TSRYYM(SPA-GMN-MAX)
      *
               MOVE    SYS-5012-SKYSTYMD
                                   TO  SPA-NAI-TSKYSTYMD(SPA-GMN-MAX)
               MOVE    SYS-5012-SKYEDYMD
                                   TO  SPA-NAI-TSKYEDYMD(SPA-GMN-MAX)
               MOVE    SYS-5012-NYUINYMD
                                   TO  SPA-NAI-TNYUINYMD(SPA-GMN-MAX)
               MOVE    SYS-5012-TAIINYMD
                                   TO  SPA-NAI-TTAIINYMD(SPA-GMN-MAX)
      *
               MOVE    SYS-5012-SKYSTYMD   TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-TSKYKIKAN-ST(SPA-GMN-MAX)
      *
               MOVE    " - "       TO  SPA-GMN-TSKYKIKAN-FIL(IDX1)
      *
               MOVE    SYS-5012-SKYEDYMD   TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-TSKYKIKAN-ED(SPA-GMN-MAX)
      *
               MOVE    SYS-5012-NYUINYMD   TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-TNYUINYMD(SPA-GMN-MAX)
      *
               IF    ( SYS-5012-TAIINYMD   =   "99999999" )
                   MOVE    "入院中"
                                   TO  SPA-GMN-TTAIINYMD(SPA-GMN-MAX)
               ELSE
                   MOVE    SYS-5012-TAIINYMD   TO  WRK-SYMD
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-TTAIINYMD(SPA-GMN-MAX)
               END-IF
      *
               MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           MOVE    3                   TO  SPA-GMN-CUR 
      *
          .
       480-ZENKAI-HYOUJI-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    作表処理
      *****************************************************************
       450-TOUROKU-SEC                SECTION.
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC 
           IF    ( SJOBKANRI-RETURN
                                   =   ZERO )
               IF    ( JOB-ENDYMD      =   SPACE )
                   MOVE    "7777"          TO  SPA-ERRCD
                   MOVE    SPACE           TO  WRK-TEIKIERR
                   STRING  "定期請求作成処理中です【"
                                             DELIMITED  BY  SIZE
                           JOB-SHELLMSG      DELIMITED  BY  SPACE
                           "】"              DELIMITED  BY  SIZE
                                             INTO  WRK-TEIKIERR
                   END-STRING
                   GO  TO  450-TOUROKU-EXT
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-MAX        =   ZERO )
               MOVE    "0010"             TO  SPA-ERRCD
           ELSE
               MOVE    "1002"             TO  SPA-OIDCD
           END-IF
           .
       450-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       450-KOUSHIN-SEC                 SECTION.
      *
      *    定期請求指示更新
           INITIALIZE                  SYS-5011-REC
           MOVE    "5011"              TO  SYS-5011-KANRICD
           MOVE    "*"                 TO  SYS-5011-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-5011-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-5011-REC
           ELSE
               INITIALIZE                      SYS-5011-REC
               MOVE    "5011"              TO  SYS-5011-KANRICD
               MOVE    "*"                 TO  SYS-5011-KBNCD
               MOVE    ALL ZERO            TO  SYS-5011-STYUKYMD
               MOVE    ALL "9"             TO  SYS-5011-EDYUKYMD
           END-IF 
           MOVE    "2"                 TO  SYS-5011-SYOKBN
           MOVE    SYS-5011-REC        TO  MCPDATA-REC
           IF      FLG-SYSKANRI        =   1
               MOVE    "DBINSERT"          TO  MCP-FUNC
           ELSE
              MOVE    "DBUPDATE"          TO  MCP-FUNC
           END-IF
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO 
               MOVE    "1003"              TO  SPA-ERRCD
               DISPLAY "5011 SYSKANRI-KEY =>" SYS-5011-KEY 
               GO  TO  450-KOUSHIN-EXT
           END-IF
      *
      *    個別指示削除処理
           INITIALIZE                  SYS-5012-REC
           MOVE    "5012"              TO  SYS-5012-KANRICD
           MOVE    "001"               TO  SYS-5012-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    SYS-5012-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               INITIALIZE                      SYS-5012-REC
               MOVE    "5012"                  TO  SYS-5012-KANRICD
               MOVE    SYS-5012-REC            TO  MCPDATA-REC
               MOVE    SPA-SYSYMD              TO  ORC-DBYMD
               MOVE    "DBDELETE"              TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY2"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
               IF      MCP-RC              NOT =   ZERO 
                   MOVE    "1001"                  TO  SPA-ERRCD
                   DISPLAY "SYSKANRI-KEY =>" SYS-5012-KEY 
                   GO  TO  450-KOUSHIN-EXT
               END-IF
           END-IF
      *
      *    個別指示登録処理
           PERFORM VARYING IDX1    FROM    1   BY  1
               UNTIL     ( IDX1    >       SPA-GMN-MAX )
                   INITIALIZE                  SYS-5012-REC
                   MOVE    "5012"                  TO  SYS-5012-KANRICD
                   MOVE    IDX1 (2:3)              TO  SYS-5012-KBNCD
                   MOVE    ZERO                    TO  SYS-5012-STYUKYMD
                   MOVE    ALL "9"                 TO  SYS-5012-EDYUKYMD
                   MOVE    SPA-GMN-TPTNUM(IDX1)    TO  SYS-5012-PTNUM
                   MOVE    SPA-NAI-TPTID (IDX1)    TO  SYS-5012-PTID
                   MOVE    SPA-NAI-TSRYYM(IDX1)    TO  SYS-5012-SRYYM
                   MOVE    SPA-NAI-TSAKKBN(IDX1)
                                               TO  SYS-5012-SAKKBN
                   MOVE    SPA-NAI-TSKYSTYMD(IDX1)
                                               TO  SYS-5012-SKYSTYMD
                   MOVE    SPA-NAI-TSKYEDYMD(IDX1)
                                               TO  SYS-5012-SKYEDYMD
                   MOVE    SPA-NAI-TNYUINYMD(IDX1)
                                               TO  SYS-5012-NYUINYMD
                   MOVE    SPA-NAI-TTAIINYMD(IDX1)
                                               TO  SYS-5012-TAIINYMD
                   MOVE    SYS-5012-REC        TO  MCPDATA-REC
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
                   IF    ( MCP-RC          NOT =   ZERO )
                       MOVE    "1002"              TO  SPA-ERRCD
                       DISPLAY "5012 SYSKANRI-KEY =>" SYS-5012-KEY 
                       GO  TO  450-KOUSHIN-EXT
                   END-IF
           END-PERFORM
      *
      *
      *    ジョブ開始セット
           MOVE    "DEL"               TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID  TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  JOB-SHELLID
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA 
                                       JOBKANRI-REC
      *
           MOVE    "JBS"               TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID  TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  JOB-SHELLID
           MOVE    SPA-TERMID          TO  JOB-TERMID                        
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA 
                                       JOBKANRI-REC
      *
           MOVE    "TEIKIERR"          TO  TEIKIERR-FILE-ID
           MOVE    SPA-TERMID          TO  TEIKIERR-TERMID
      *
           OPEN    OUTPUT   TEIKIERR-FILE
           CLOSE   TEIKIERR-FILE
      *
           MOVE    SPACE           TO  SHELLTBL
           MOVE    "teiki1.sh"
                                   TO  WRK-SHELL-SHELL
      *    ファイルデイレクトリ位置指定
           INITIALIZE              ORCSMKPASSAREA
           MOVE    WRK-SHELL-NAME  TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
      *
           MOVE    ZERO            TO  WRK-SHELL-SRYYM
           MOVE    SPA-TERMID      TO  WRK-SHELL-TERMID
           MOVE    SPA-SYSYMD      TO  WRK-SHELL-SYSYMD
           MOVE    WRK-SHELL-ARG1  TO  SHELLTBL-ARG1
           MOVE    "2"             TO  SHELLTBL-ARG2
           MOVE    SPACE           TO  SHELLTBL-ARG3
                                       SHELLTBL-ARG4
                                       SHELLTBL-ARG5
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  SHELLTBL-ARG6
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  SHELLTBL-ARG7
           MOVE    TEIKIERR
                                   TO  SHELLTBL-ARG8
           MOVE    SHELLTBL        TO  MCPDATA-REC
           MOVE    "SHELL"         TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL
                                   TO  MCP-PATH
           CALL    "MCPSUB"        USING
                                       MCPAREA
                                       MCPDATA-REC
      *
      *    自動的に情報確認画面を表示
           PERFORM 490-KAKUNIN-SEC
           .
       450-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷画面へ遷移
      *****************************************************************
       4501-NEXT-GMN-SEC            SECTION.
      *
      *    画面移行用のパラメタ変更
      *
           MOVE    SPA-NAI-TSRYYM (1)  TO  SPA-O01-SRYYM
      *
           MOVE    SPA-O01KYOUTU       TO  SPA-WORK
      * 
           MOVE    "O02"               TO  SPA-MOTOPG
      *
           MOVE    "O03"               TO  SPA-SAKIPG
      *
      ***  MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           MOVE   SPA-SAKIPG           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       4501-NEXT-GMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
           MOVE    SPACE               TO  O99
           MOVE    ZERO                TO  O99-COUNT
                                           O99-PROGRESSBAR-VALUE  
      *
      *    ジョブ管理チェック処理
           MOVE    "CHK"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-JOBID
                                   TO  JOB-JOBID
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA 
                                   JOBKANRI-REC 
           IF      SJOBKANRI-RETURN
                                   =   ZERO
               MOVE    1               TO  IDX1
               MOVE    JOB-JOBID       TO  O99-RENNUM   (IDX1)
               MOVE    JOB-SHELLMSG    TO  O99-SHORINM  (IDX1)
               MOVE    JOB-STARTTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-STARTTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-STARTTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  O99-STARTTIME(IDX1)
               MOVE    JOB-ENDTIME(1:2)
                                       TO  WRK-HH
               MOVE    JOB-ENDTIME(3:2)
                                       TO  WRK-MM
               MOVE    JOB-ENDTIME(5:2)
                                       TO  WRK-SS
               MOVE    WRK-HENTIME     TO  O99-ENDTIME  (IDX1)
               MOVE    JOB-YOBI        TO  O99-ERRMSG   (IDX1)
               IF    ( JOB-ENDYMD      =   SPACE )
                   MOVE    "処理中です"    TO  O99-MSG
               ELSE
                   IF    ( JOB-ERRCD       =   SPACE )
                       CONTINUE
                   ELSE
                       STRING  JOB-YOBI    DELIMITED  BY  SPACE
                               "【"        DELIMITED  BY  SIZE
                              JOB-SHELLMSG DELIMITED  BY  SPACE
                              "】"         DELIMITED  BY  SIZE      
                                           INTO  O99-MSG
                   END-IF                          
               END-IF
               MOVE    IDX1                TO  O99-COUNT
           END-IF
      *
           MOVE    WIDGET-INSENSITIVE   TO  O99-B12-STATE
           IF    ( O99-MSG              =   SPACE )
               IF    ( O99-COUNT            >   ZERO )
                   MOVE    WIDGET-NORMAL        TO  O99-B12-STATE
                   MOVE    "B12"                TO  MCP-WIDGET
                   MOVE    "処理は正常に終了しました"
                                                TO  O99-MSG
               ELSE
                   MOVE    "B01"                TO  MCP-WIDGET
                   MOVE    "該当する処理はありません"
                                                TO  O99-MSG
               END-IF                                 
           ELSE                                        
               MOVE    "B11"                TO  MCP-WIDGET
           END-IF                                 
      *
           MOVE    "O02"                TO  SPA-MOTOPG
           MOVE    "O99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "O99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
           .
       490-KAKUNIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    氏名検索へ
      *****************************************************************
       480-KENSAKU-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-O02             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "O02"               TO  SPA-MOTOPG
           MOVE    "P97"               TO  SPA-SAKIPG
      *
      *    氏名をクリアする
           MOVE    SPACE               TO  SPA-NAME
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    "P97"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       480-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    情報削除画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-O02             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "O02"               TO  SPA-MOTOPG
           MOVE    "XB01"              TO  SPA-SAKIPG
      *
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SPA-JOB-SHELLID
      *          
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XB01   "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-JYOUHOU-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YM          =   SPACE
               MOVE    SPA-NAI-HYO-SRYYM   TO  WRK-SYMD    (1:6)
               MOVE    SPA-NAI-HYO-SRYYMH  TO  WRK-HENYMDG (1:6)
               GO  TO  5002-HIZUKE-CHK-EXT
           END-IF
      * 
           IF      WRK-YM   (1:5)  NOT NUMERIC
               INSPECT     WRK-YM       REPLACING   ALL " " BY  "0"         
               MOVE    WRK-YM(1:1)      TO  WRK-WGO
               MOVE    WRK-YM(2:2)      TO  WRK-WYY
               MOVE    WRK-YM(5:2)      TO  WRK-WMM
           ELSE
               MOVE    WRK-YM(1:5)      TO  WRK-WYMD (1:5)
           END-IF
           MOVE    "01"             TO  WRK-WDD
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY1-AREA
           MOVE    "12"                TO  LNK-DAY1-IRAI
           MOVE    ZERO                TO  LNK-DAY1-YMD
           MOVE    WRK-WYMD            TO  LNK-DAY1-YMD(2:7)
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY1-AREA
           IF      STS-DAY-RC1     NOT =   ZERO
               MOVE    "0001"          TO  SPA-ERRCD
           ELSE
               MOVE    LNK-DAY1-YMD        TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
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
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
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
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-OIDCD       NOT =   SPACE
               PERFORM 520-OIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-OIDCD2      NOT =   SPACE
               PERFORM 530-OIDSET2-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "O02    "           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  O02
      *
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL       IDX1                >   SPA-GMN-MAX
               IF    ( SPA-GMN-TRENNUM    (IDX1)   NOT =   ZERO )
                   MOVE    SPA-GMN-TRENNUM    (IDX1)
                                               TO  WRK-NUM
                   MOVE    WRK-NUM             TO  O02-TRENNUM   (IDX1)
               END-IF
               MOVE    SPA-GMN-TSRYYM     (IDX1)
                                               TO  O02-TSRYYM    (IDX1)
               MOVE    SPA-GMN-TPTNUM     (IDX1)
                                               TO  O02-TPTNUM    (IDX1)
               MOVE    SPA-GMN-TNAME      (IDX1)
                                               TO  O02-TNAME     (IDX1)
               MOVE    SPA-GMN-TSAKKBN    (IDX1)
                                               TO  O02-TSAKKBN   (IDX1)
               MOVE    SPA-GMN-TSKYKIKAN  (IDX1)
                                               TO  O02-TSKYKIKAN (IDX1)
               MOVE    SPA-GMN-TNYUINYMD    (IDX1)
                                               TO  O02-TNYUINYMD (IDX1)
               MOVE    SPA-GMN-TTAIINYMD    (IDX1)
                                               TO  O02-TTAIINYMD (IDX1)
      *
               IF    ( IDX1            =   SPA-NAI-SELNO )
                   MOVE    "T"             TO  O02-SELECT (IDX1)
               ELSE
                   MOVE    "F"             TO  O02-SELECT (IDX1)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-MAX            TO  O02-COUNT
      *
           MOVE    SPA-GMN-RENNUM         TO  O02-RENNUM
           MOVE    SPA-GMN-PTNUM          TO  O02-PTNUM
           MOVE    SPA-GMN-NAME           TO  O02-NAME
           MOVE    SPA-GMN-SRYYM          TO  O02-SRYYM
           MOVE    SPA-GMN-SAKKBN-G       TO  O02-SAKKBN
      *
           MOVE    SPA-GMN-SAKKBN-MAX     TO  O02-SAKKBN-COUNT
           PERFORM VARYING IDX1    FROM   1   BY   1
                   UNTIL ( IDX1    >      SPA-GMN-SAKKBN-MAX )
               MOVE    SPA-GMN-SAKKBNLST (IDX1)
                                   TO     O02-SAKKBNLST (IDX1)
           END-PERFORM
      *
           MOVE    WIDGET-NORMAL          TO  O02-SAKKBN-STATE
                                              O02-SAKKBN-COMBO-STATE
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
           EVALUATE    SPA-GMN-CUR
             WHEN    3
                    MOVE  "RENNUM"     TO  MCP-WIDGET
             WHEN    4
                    MOVE  "PTNUM"      TO  MCP-WIDGET
             WHEN    5
                    MOVE  "SRYYM"      TO  MCP-WIDGET
             WHEN    6
                    MOVE  "SAKKBN"     TO  MCP-WIDGET
             WHEN    7
                    MOVE  "B12"        TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
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
                   MOVE    "追加できません"            TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "ＩＤ取得サブでエラー"      TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "対象のデータを選択してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象のデータが選択してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "対象の入院履歴がありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "定期請求情報が登録されていません"
                                                       TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "期間の重複するデータが存在します"
                                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "対象のデータが入力してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "前回は個別作成のデータではありません"
                                                       TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "定期請求指示コード（個別）が削除できません"
                                                       TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "定期請求指示コード（個別）が更新できません"
                                                       TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "定期請求指示コード（管理）が更新できません"
                                                       TO  SPA-ERRMSG
               WHEN    "7777"
                   MOVE    WRK-TEIKIERR                 TO  SPA-ERRMSG
               WHEN    "9999"
                   MOVE    WRK-TEIKIERR                 TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  OERR
           MOVE    SPA-ERRCD            TO  OERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  OERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "O02"                TO  SPA-MOTOPG
           MOVE    "OERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "OERR"               TO  MCP-WINDOW
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
      *    エラーメッセージ表示理
      *****************************************************************
       520-OIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-OIDMSG
      *
           EVALUATE    SPA-OIDCD
               WHEN    "1002"
                   MOVE    "個別作成で作表します"        TO  WRK-OIDMSG
               WHEN    "1003"
                   MOVE    "入力をすべてクリアします"    TO  WRK-OIDMSG
               WHEN    "1004"
                   MOVE    "前回個別作成分を表示します"  TO  WRK-OIDMSG
               WHEN    "6666"
                   MOVE    "定期請求作成処理中です"      TO  WRK-OIDMSG
               WHEN    "9999"
                   MOVE    WRK-TEIKIERR                  TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  OID1
           MOVE    SPA-OIDCD            TO  OID1-ID1CODE
           MOVE    WRK-OIDMSG           TO  OID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "O02"                TO  SPA-MOTOPG
           MOVE    "OID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "OID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-OIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       530-OIDSET2-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-OIDMSG
      *
           EVALUATE    SPA-OIDCD2
               WHEN    "8888"
                   MOVE    "定期請求作成処理が正常終了しました"
                                                       TO  WRK-OIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  OID2
           MOVE    SPA-OIDCD2           TO  OID2-ID1CODE
           MOVE    WRK-OIDMSG           TO  OID2-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "O02"                TO  SPA-MOTOPG
           MOVE    "OID2"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "OID2"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       530-OIDSET2-EXT.
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
               CALL    "ORCMCPSUB"          USING
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
      *****************************************************************
      *    収納マスタ　ＲＥＡＤ
      *****************************************************************
       910-SYUNOU-KEY6-READ-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUNOU
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY6"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           .
       910-SYUNOU-KEY6-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者定期履歴マスタ　ＲＥＡＤ
      *****************************************************************
       910-PTTEIKIRRK-KEY2-READ-SEC    SECTION.
      *
           MOVE    ZERO                TO  FLG-PTTEIKIRRK
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    "PTTEIKIRRK-KEY2"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTTEIKIRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTTEIKIRRK
           END-IF
           .
       910-PTTEIKIRRK-KEY2-READ-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴マスタ検索処理
      *****************************************************************
       900-PTNYUINRRK-KEY10-SEL-SEC    SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNYUINRRK-KEY10"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    "PTNYUINRRK-KEY10" 
                                       TO  ORC-DBPATH
               MOVE    "DBFETCH"       TO  MCP-FUNC
               CALL    "ORCMCPSUB"     USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
               ELSE
                   MOVE    1           TO  FLG-PTNYUINRRK
               END-IF
           ELSE
               MOVE    1           TO  FLG-PTNYUINRRK
           END-IF
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNYUINRRK-KEY10"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           .
       900-PTNYUINRRK-KEY10-SEL-EXT.
           EXIT.
      *
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
      *
      *
