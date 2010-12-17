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
       PROGRAM-ID.             ORCDTCKMAIN.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト
      *  コンポーネント名  : 月次業務　データチェック主プロ
      *                    : リアルタイムプレビュー用
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    NACL−竹田　　新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *
       DATA                    DIVISION.
      *
       WORKING-STORAGE             SECTION.
      *
       01  LNK-TIMEOFDAY       PIC X(100).
      *
      *    エラーファイル 名称領域 
           COPY    "CPERRFL.INC"   REPLACING  //ERRFLPARA//
                                   BY         //RECEERR//.
      *
      *    カウント領域
       01  FLG-AREA.
           03  FLG-SYUNOU                              PIC 9(01).
           03  FLG-SYUMEI                              PIC 9(01).
           03  FLG-SYUTTL                              PIC 9(01).
           03  FLG-JYURRK                              PIC 9(01).
           03  FLG-SRYACCT                             PIC 9(01).
           03  FLG-SRYACT                              PIC 9(01).
           03  FLG-SANTEI                              PIC 9(01).
           03  FLG-SRYKARRK                            PIC 9(01).
           03  FLG-PTCOM                               PIC 9(01).
           03  FLG-PRVKANRI                            PIC 9(01).
      *
      *    一時領域
      *
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-A1.
                   07  WRK-PARA-A1-1                   PIC  X(06).
                   07  WRK-PARA-A1-2                   PIC  X(16).
                   07  WRK-PARA-A1-3                   PIC  X(08).
               05  WRK-PARA-A2                         PIC  X(01).
               05  WRK-PARA-A3                         PIC  X(01).
               05  WRK-PARA-A4                         PIC  X(100).
               05  WRK-PARA-A5                         PIC  9(07).
               05  WRK-PARA-A6                         PIC  X(08).
               05  WRK-PARA-A7                         PIC  X(15).
               05  WRK-PARA-A8                         PIC  X(06).
               05  WRK-PARA-A9                         PIC  X(08).
               05  WRK-PARA-A10                        PIC  X(08).
               05  WRK-PARA-A11                        PIC  X(02).
      *
               05  WRK-PARA-A12                        PIC  X(01).
               05  WRK-PARA-A13                        PIC  X(01).
               05  WRK-PARA-A14                        PIC  X(01).
      *
               05  WRK-PARA-A15                        PIC  X(16).
               05  WRK-PARA-A16                        PIC  X(16).
               05  WRK-PARA-A17                        PIC  9(04).
               05  WRK-PARA-A18                        PIC  X(08).
               05  WRK-PARA-A19                        PIC  X(14).
               05  WRK-PARA-A20                        PIC  9(04).
               05  WRK-PARA-A21                        PIC  X(06).
               05  WRK-PARA-A22                        PIC  X(08).
               05  WRK-PARA-A23                        PIC  X(20).
               05  WRK-PARA-A24                        PIC  9(04).
               05  WRK-PARA-A25                        PIC  X(64).
               05  WRK-PARA-A26                        PIC  X(16).
               05  WRK-PARA-A27                        PIC  X(16).
               05  WRK-PARA-A28                        PIC  X(34).
               05  WRK-PARA-A29                        PIC  X(34).
               05  WRK-PARA-A35                        PIC  X(01).
      *
               05  WRK-PARA-PTID                       PIC  9(10).
               05  WRK-PARA-NYUGAIKBN                  PIC  X(01).
               05  WRK-PARA-HKNKBN                     PIC  X(01).
               05  WRK-PARA-SHORI-KBN                  PIC  X(01).
               05  WRK-PARA-HOSPID                     PIC  X(24).
               05  WRK-PARA-HOSPNUM                    PIC  9(02).
               05  WRK-PARA-PRTKBN                     PIC  X(01).
      *
           03  WRK-PARA0.
               05  WRK-PARA0-A1.
                   07  WRK-PARA0-A1-1                  PIC  X(06).
                   07  WRK-PARA0-A1-2                  PIC  X(16).
                   07  WRK-PARA0-A1-3                  PIC  X(08).
               05  WRK-PARA0-A2                        PIC  X(01).
               05  WRK-PARA0-A3                        PIC  X(01).
               05  WRK-PARA0-A5                        PIC  9(07).
               05  WRK-PARA0-A6                        PIC  X(08).
               05  WRK-PARA0-A7                        PIC  9(10).
               05  WRK-PARA0-A8                        PIC  X(06).
      *
           03  WRK-PARA1.
               05  WRK-PARA1-A1.
                   07  WRK-PARA1-A1-1                  PIC  X(06).
                   07  WRK-PARA1-A1-2                  PIC  X(16).
                   07  WRK-PARA1-A1-3                  PIC  X(08).
               05  WRK-PARA1-A3                        PIC  X(01).
               05  WRK-PARA1-A5                        PIC  9(07).
               05  WRK-PARA1-A6                        PIC  X(08).
           03  WRK-PARA2.
               05  WRK-PARA2-A1.
                   07  WRK-PARA2-A1-1                  PIC  X(06).
                   07  WRK-PARA2-A1-2                  PIC  X(16).
                   07  WRK-PARA2-A1-3                  PIC  X(08).
               05  WRK-PARA2-A5                        PIC  9(07).
               05  WRK-PARA2-A6                        PIC  X(08).
      *
           03  WRK-PARA3.
               05  WRK-PARA3-A9                        PIC  X(08).
               05  WRK-PARA3-A10                       PIC  X(08).
               05  WRK-PARA3-A1.
                   07  WRK-PARA3-A1-1                  PIC  X(06).
                   07  WRK-PARA3-A1-2                  PIC  X(16).
                   07  WRK-PARA3-A1-3                  PIC  X(08).
               05  WRK-PARA3-A2                        PIC  X(01).
               05  WRK-PARA3-A3                        PIC  X(01).
               05  WRK-PARA3-A8                        PIC  X(06).
               05  WRK-PARA3-A5                        PIC  9(07).
               05  WRK-PARA3-A6                        PIC  X(08).
      *
           03  WRK-PARA4.
               05  WRK-PARA4-A9                        PIC  X(08).
               05  WRK-PARA4-A10                       PIC  X(08).
               05  WRK-PARA4-A1.
                   07  WRK-PARA4-A1-1                  PIC  X(06).
                   07  WRK-PARA4-A1-2                  PIC  X(16).
                   07  WRK-PARA4-A1-3                  PIC  X(08).
               05  WRK-PARA4-A3                        PIC  X(01).
               05  WRK-PARA4-A8                        PIC  X(06).
               05  WRK-PARA4-A5                        PIC  9(07).
               05  WRK-PARA4-A6                        PIC  X(08).
      *
           03  WRK-ARG                 PIC X(512).
           03  IDX                     PIC 9(10).
      *
           03  WRK-PTID-X.
               05  WRK-PTID            PIC 9(10).
      *
           03  WRK-SRYYMD.
               05  WRK-SRYYM           PIC X(06).
               05  WRK-SRYDD           PIC X(02).
      *  
           03  WRK-ZAINUM              PIC 9(08).
           03  WRK-STPAGE              PIC 9(05).
           03  WRK-EDPAGE              PIC 9(05).
      *
       01  WRK-AREA2.
           COPY    "CPORCSPRTLNK.INC".
        01  WRK-CONS-AREA.
      *    帳票出力用パラメタ  
           03  WRK-CONS-ARG.       
               05  WRK-CONS-ARG-PRTID  PIC X(04)   VALUE   "HC06".
               05  WRK-CONS-ARG-SRYYM  PIC X(06)   VALUE   "999999".
               05  WRK-CONS-ARG-CREYMD PIC X(08).
               05  WRK-CONS-ARG-CREHMS PIC X(06).
               05  WRK-CONS-ARG-PREFKBN
                                       PIC X(01)   VALUE   "0".
               05  WRK-CONS-ARG-TEISYUTUSAKI
                                       PIC X(01)   VALUE   "0".
               05  WRK-CONS-ARG-RECESYUBETU
                                       PIC X(04)   VALUE   "0000".
               05  WRK-CONS-ARG-NYUGAIKBN
                                       PIC X(01).
               05  WRK-CONS-ARG-PRTJYUN
                                       PIC X(02)   VALUE   "05".
      *
           03  WRK-CONS-SRYYM-200609   PIC 9(06)   VALUE   200609.      
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    医療機関情報
           COPY  "CPSK1001.INC".
      *    医療機関情報
           COPY  "CPSK1005.INC".
      *
      *    患者番号構成管理情報
           COPY    "CPSK1009.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納明細
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *    収納合計マスタ
       01  SYUTTL-REC.
           COPY    "CPSYUTOTAL.INC".
      *
      *    受診履歴マスタ
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    会計マスタ
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    会計付加情報マスタ
       01  SRYACCTPLUS-REC.
           COPY    "CPSRYACCTPLUS.INC".
      *
      *    診療行為マスタ
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    算定マスタ
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    診療科履歴マスタ
       01  SRYKARRK-REC.
           COPY    "CPSRYKARRK.INC".
      *
      *    患者コメントマスタ
       01  PTCOM-REC.
           COPY    "CPPTCOM.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    プレビュー管理マスタ
           COPY    "CPPRVKANRI.INC".
      *    チェックマスタ４
           COPY    "CPCHK004.INC".
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    フィアルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
           COPY    "COMMON-SPA".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           EXIT   PROGRAM
      *    STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  WRK-AREA
                                       FLG-AREA
                                       SPA-AREA
      *
      *    ＤＢオープン処理
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING    COMMAND-PARAM   DELIMITED BY ","
                                   INTO  WRK-PARA-A1
                                         WRK-PARA-A2
                                         WRK-PARA-A3
                                         WRK-PARA-A5
                                         WRK-PARA-A6
                                         WRK-PARA-A7
                                         LNK-PRTKANRI-SRYYM
                                         WRK-PARA-A9
                                         WRK-PARA-A10
                                         WRK-PARA-A11
                                         WRK-PARA-A12
                                         WRK-PARA-A13
                                         WRK-PARA-A14
                                         WRK-PARA-A15
                                         WRK-PARA-A16
                                         LNK-PRTKANRI-RENNUM
                                         LNK-PRTKANRI-TBL-KEY
                                         LNK-PRTKANRI-TBL-GROUP
                                         LNK-PRTKANRI-SHORI-RENNUM
                                         LNK-PRTKANRI-SRYYM
                                         LNK-PRTKANRI-SKYYMD
                                         LNK-PRTKANRI-SHELLID
                                         LNK-PRTKANRI-PRIORITY
                                         LNK-PRTKANRI-TERMID
                                         LNK-PRTKANRI-OPID
                                         LNK-PRTKANRI-PRTNM
                                         WRK-PARA-A28
                                         WRK-PARA-A29
                                         WRK-PARA-PTID
                                         WRK-PARA-NYUGAIKBN
                                         WRK-PARA-HKNKBN
                                         WRK-PARA-SHORI-KBN
                                         WRK-PARA-HOSPNUM
                                         WRK-PARA-A35
                                         WRK-PARA-PRTKBN 
                                         RECEERR
           END-UNSTRING
           MOVE    WRK-PARA-HOSPNUM    TO  SPA-HOSPNUM
      *
           PERFORM 20010-PRVDATA-DEL-SEC
      *    前回分削除(存在すれば)
           PERFORM 200101-PRVDATA-DEL-SEC
      *    一旦 COMMIT 
           PERFORM 900-DBCOMMIT-SEC
      *
      *  
           PERFORM 100-DBOPEN-SEC
      *    CHK004 ダミー作成
           PERFORM 20011-CHK004-DB-MAKE-SEC
      *
           MOVE     WRK-PARA-A1    TO  WRK-PARA0-A1
           MOVE     WRK-PARA-A2    TO  WRK-PARA0-A2
           MOVE     WRK-PARA-A3    TO  WRK-PARA0-A3
           MOVE     WRK-PARA-A5    TO  WRK-PARA0-A5
           MOVE     WRK-PARA-A6    TO  WRK-PARA0-A6
           MOVE     WRK-PARA-PTID  TO  WRK-PARA0-A7
           MOVE     LNK-PRTKANRI-SRYYM
                                   TO  WRK-PARA0-A8
                                       WRK-PARA-A8
      *
           MOVE     WRK-PARA-A1    TO  WRK-PARA1-A1
           MOVE     WRK-PARA-A3    TO  WRK-PARA1-A3
           MOVE     WRK-PARA-A5    TO  WRK-PARA1-A5
           MOVE     WRK-PARA-A6    TO  WRK-PARA1-A6
      *
           MOVE     WRK-PARA-A1    TO  WRK-PARA2-A1
           MOVE     WRK-PARA-A5    TO  WRK-PARA2-A5
           MOVE     WRK-PARA-A6    TO  WRK-PARA2-A6
      *
           MOVE     WRK-PARA-A1    TO  WRK-PARA3-A1
           MOVE     WRK-PARA-A2    TO  WRK-PARA3-A2
           MOVE     WRK-PARA-A3    TO  WRK-PARA3-A3
           MOVE     WRK-PARA-A5    TO  WRK-PARA3-A5
           MOVE     WRK-PARA-A6    TO  WRK-PARA3-A6
           MOVE     LNK-PRTKANRI-SRYYM
                                   TO  WRK-PARA3-A8
           MOVE     WRK-PARA-A9    TO  WRK-PARA3-A9
           MOVE     WRK-PARA-A10   TO  WRK-PARA3-A10
      *
           MOVE     WRK-PARA-A1    TO  WRK-PARA4-A1
           MOVE     WRK-PARA-A3    TO  WRK-PARA4-A3
           MOVE     WRK-PARA-A5    TO  WRK-PARA4-A5
           MOVE     WRK-PARA-A6    TO  WRK-PARA4-A6
           MOVE     LNK-PRTKANRI-SRYYM
                                   TO  WRK-PARA4-A8
           MOVE     WRK-PARA-A9    TO  WRK-PARA4-A9
           MOVE     WRK-PARA-A10   TO  WRK-PARA4-A10
      *
      *    作成日・時間の設定
           MOVE    WRK-PARA-A9     TO  WRK-CONS-ARG-CREYMD
           MOVE    WRK-PARA-A10    TO  WRK-CONS-ARG-CREHMS
           MOVE    WRK-PARA-NYUGAIKBN
                                   TO  WRK-CONS-ARG-NYUGAIKBN
      *
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           IF      WRK-PARA-SHORI-KBN  NOT  =  ZERO
               PERFORM 20011-REAL-DB-MAKE-SEC
           END-IF
      *
           PERFORM 2001-DTCHK-PARA-SEC
      *
           IF      WRK-PARA-SHORI-KBN  NOT  =  ZERO
      *    ＤＢオープン処理(もう少し整理)
                   PERFORM 100-DBOPEN-SEC
                   PERFORM 20011-TMPDB-DELETE-SEC
                   PERFORM 900-DBCOMMIT-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    医保（入院外）処理
      *****************************************************************
       2001-DTCHK-PARA-SEC                SECTION.
      *
           DISPLAY "LNK-PRTKANRI-RENNUM       = " LNK-PRTKANRI-RENNUM
           DISPLAY "LNK-PRTKANRI-TBL-KEY      = " LNK-PRTKANRI-TBL-KEY
           DISPLAY "LNK-PRTKANRI-TBL-GROUP    = " LNK-PRTKANRI-TBL-GROUP
           DISPLAY "LNK-PRTKANRI-SHORI-RENNUM = "
                                              LNK-PRTKANRI-SHORI-RENNUM
           DISPLAY "LNK-PRTKANRI-SRYYM        = " LNK-PRTKANRI-SRYYM
           DISPLAY "LNK-PRTKANRI-SKYYMD       = " LNK-PRTKANRI-SKYYMD
           DISPLAY "LNK-PRTKANRI-SHELLID      = " LNK-PRTKANRI-SHELLID
           DISPLAY "LNK-PRTKANRI-PRIORITY     = " LNK-PRTKANRI-PRIORITY
           DISPLAY "LNK-PRTKANRI-TERMID       = " LNK-PRTKANRI-TERMID
           MOVE     SPACE       TO WRK-ARG
           MOVE    WRK-PARA-PTID       TO  WRK-PTID-X
           MOVE    WRK-PTID            TO  LNK-PRTKANRI-TBL-GROUP
           STRING   LNK-PRTKANRI-RENNUM    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-TBL-KEY   DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-TBL-GROUP DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-SHORI-RENNUM 
                                           DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-SRYYM     DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-SKYYMD    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-SHELLID   DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-PRIORITY  DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-TERMID    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-OPID      DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-PRTNM     DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    LNK-PRTKANRI-TBL-KEY   DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    SPA-HOSPNUM            DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                    RECEERR                DELIMITED   BY  SPACE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-IKTKBT
                    "2"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-SRYYM
                    LNK-PRTKANRI-SRYYM     DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-NYUGAIKBN
                    WRK-PARA-NYUGAIKBN     DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-CHKKBN-G
                    "222222222222222222"   DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-SYAHOPROCKBN
                    "1"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-KOKUHOPROCKBN
                    "1"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-RSIPROCKBN
                    "1"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-JBIPROCKBN
                    "1"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-JIHIPROCKBN
                    "1"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-INGAIPROCKBN
                    "1"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-PRTSRTKBN
                    "2"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-PRTPTLSTKBN
                    "2"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-SRYYMDKBN
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-STSRYYMD
                    "00"                   DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-EDSRYYMD
                    "00"                   DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-KGIPROCKBN
                    "1"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
      *  ORCBSD01-KOUKIPROCKBN
                    "1"                    DELIMITED   BY  SIZE
                    ","                    DELIMITED   BY  SIZE
                                   INTO    WRK-ARG
           END-STRING
           DISPLAY "ORCDTCHK000 start = [" WRK-ARG "]"
           CALL    "ORCDTCHK000"       USING
                                       WRK-ARG
      *
               MOVE    0                   TO  WRK-STPAGE
               MOVE    99999               TO  WRK-EDPAGE
      *
               MOVE    SPACE               TO  SHELLTBL
      *
      *        ファイルデイレクトリ位置指定
               INITIALIZE                  ORCSMKPASSAREA
               MOVE    "/scripts/allways/print_prv.sh"
                                           TO  MKPASS-IN-01
               CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
               MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
               DISPLAY "shell = "  SHELLTBL-NAME
      *        MOVE    SPACE               TO  LNK-PRTKANRI-AREA
      *        INITIALIZE                      LNK-PRTKANRI-AREA
               MOVE    2                   TO  LNK-PRTKANRI-RENNUM
               MOVE    ZERO                TO  LNK-PRTKANRI-SHORI-RENNUM
               MOVE    SPA-SRYYMD(1:6)     TO  LNK-PRTKANRI-SRYYM
               MOVE    SPA-SYSYMD          TO  LNK-PRTKANRI-SKYYMD
               MOVE    "print_prv.sh"      TO  LNK-PRTKANRI-SHELLID
               MOVE    ZERO                TO  LNK-PRTKANRI-PRIORITY
      *        MOVE    SPA-TERMID          TO  LNK-PRTKANRI-TERMID
               MOVE    ALL "Z"             TO  LNK-PRTKANRI-TERMID
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                           TO  
                                           LNK-PRTKANRI-TERMID(1:10)
               MOVE    SPA-OPID            TO  LNK-PRTKANRI-OPID
               MOVE    LNK-PRTKANRI-RENNUM TO  SHELLTBL-ARG1
               MOVE    LNK-PRTKANRI-TBL-KEY
                                           TO  SHELLTBL-ARG2
               DISPLAY "arg2 = "  SHELLTBL-ARG2
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                           TO  SHELLTBL-ARG3
               MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                           TO  SHELLTBL-ARG4
               MOVE    LNK-PRTKANRI-SRYYM  TO  SHELLTBL-ARG5
               MOVE    LNK-PRTKANRI-SKYYMD TO  SHELLTBL-ARG6
               MOVE    LNK-PRTKANRI-SHELLID
                                           TO  SHELLTBL-ARG7
               MOVE    LNK-PRTKANRI-PRIORITY
                                           TO  SHELLTBL-ARG8
               MOVE    LNK-PRTKANRI-TERMID TO  SHELLTBL-ARG9
               MOVE    LNK-PRTKANRI-OPID   TO  SHELLTBL-ARG10
               MOVE    LNK-PRTKANRI-PRTNM  TO  SHELLTBL-ARG11
      *
               MOVE    RECEERR             TO  SHELLTBL-ARG12
               MOVE    "DUMMY"             TO  SHELLTBL-ARG13
               MOVE    "RECEPTX"
                                           TO  SHELLTBL-ARG14
               MOVE    WRK-STPAGE          TO  SHELLTBL-ARG15
               MOVE    WRK-EDPAGE          TO  SHELLTBL-ARG16
               MOVE    "3"                 TO  SHELLTBL-ARG17
               MOVE    SPA-HOSPNUM         TO  SHELLTBL-ARG18
               MOVE    SHELLTBL            TO  MCPDATA-REC
               MOVE    "SHELL"             TO  MCP-FUNC
               MOVE    "shell"             TO  MCP-TABLE
               MOVE    "shell"             TO  MCP-PATHNAME
               CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
               DISPLAY "shell mcp rc = " MCP-RC
               PERFORM 900-DBCOMMIT-SEC
           .
       2001-DTCHK-PARA-EXT.
           EXIT.
      *
      *****************************************************************
      *    前回分削除(存在すれば)
      *****************************************************************
       20010-PRVDATA-DEL-SEC         SECTION.
      *
           INITIALIZE                  PRVKANRI-REC
           MOVE    "RECEPTX"           TO  PRVKANRI-TBL-KEY
           MOVE    WRK-PARA-PTID       TO  WRK-PTID-X
           MOVE    WRK-PTID            TO  PRVKANRI-TBL-GROUP
grpsys     MOVE    SPA-HOSPNUM         TO  PRVKANRI-HOSPNUM
           MOVE    PRVKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_prvkanri"      TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC             =   ZERO
               MOVE    "tbl_prvkanri"      TO  MCP-TABLE
               MOVE    "key8"              TO  MCP-PATHNAME
               PERFORM 900-PRVKANRI-FET-SEC
           ELSE
               MOVE    1               TO  FLG-PRVKANRI
           END-IF
      *
           MOVE    "tbl_prvkanri"      TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
           .
       20010-PRVDATA-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    前回分削除(存在すれば)
      *****************************************************************
       200101-PRVDATA-DEL-SEC        SECTION.
      *
           IF      FLG-PRVKANRI         =   ZERO
               DISPLAY "RECEMAIN PRV EXIST !!"
               DISPLAY "PAGE = [" PRVKANRI-PAGE "]"
      *        MOVE    PRVKANRI-PAGE   TO  MAX-PAGE-CNT
      *        PERFORM 100-DBOPEN-SEC
               MOVE    LNK-PRTKANRI-SRYYM
                                       TO  WRK-SRYYM
      *
               CALL    "ORCSPRVPSDEL"   USING
grpsys                                  WRK-PARA-HOSPNUM
                                        WRK-PTID
                                        WRK-SRYYM
                                        WRK-PARA-HKNKBN
grpsys                                  SPA-AREA
      *
      *
      *        PERFORM 900-DBCOMMIT-SEC
           ELSE
               DISPLAY "RECEMAIM PRV NO DATA !!"
           END-IF
      *
           .
       20010-PRVDATA-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理(収納)
      *****************************************************************
       20011-SYUNOU-DB-MAKE-SEC      SECTION.
           EVALUATE    SYU-CREYMD
               WHEN    "99999999"
                   MOVE    "DBDELETE"   TO      MCP-FUNC
                   MOVE    "tbl_syunou" TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *
               WHEN    "88888888"
                   MOVE    "DBUPDATE"   TO      MCP-FUNC
                   MOVE    "tbl_syunou" TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *
               WHEN      OTHER
                   MOVE    "DBINSERT"   TO      MCP-FUNC
                   MOVE    "tbl_syunou" TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
           END-EVALUATE
           PERFORM  900-REALDB-INS-SEC
           .
       20011-SYUNOU-DB-MAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理(収納明細)
      *****************************************************************
       20011-SYUMEI-DB-MAKE-SEC      SECTION.
           EVALUATE    SMEI-CREYMD
               WHEN    "99999999"
                   MOVE    "DBDELETE"   TO      MCP-FUNC
                   MOVE    "tbl_syumei" TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *
               WHEN    "88888888"
                   MOVE    "DBUPDATE"   TO      MCP-FUNC
                   MOVE    "tbl_syumei" TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *
               WHEN      OTHER
                   MOVE    "DBINSERT"   TO      MCP-FUNC
                   MOVE    "tbl_syumei" TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
           END-EVALUATE
           PERFORM  900-REALDB-INS-SEC
           .
       20011-SYUMEI-DB-MAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理(収納トータル)
      *****************************************************************
       20011-SYUTOTAL-DB-MAKE-SEC      SECTION.
           EVALUATE    SYUTTL-CREYMD
               WHEN    "99999999"
                   MOVE    "DBDELETE"   TO      MCP-FUNC
                   MOVE    "tbl_syutotal"
                                        TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *
               WHEN    "88888888"
                   MOVE    "DBUPDATE"   TO      MCP-FUNC
                   MOVE    "tbl_syutotal"
                                        TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *
               WHEN      OTHER
                   MOVE    "DBINSERT"   TO      MCP-FUNC
                   MOVE    "tbl_syutotal"
                                        TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
           END-EVALUATE
           PERFORM  900-REALDB-INS-SEC
           .
       20011-SYUTOTAL-DB-MAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理(会計)
      *****************************************************************
       20011-SRYACCT-DB-MAKE-SEC      SECTION.
           EVALUATE    ACCT-CREYMD
               WHEN    "99999999"
                   MOVE    "DBDELETE"   TO      MCP-FUNC
                   MOVE    "tbl_sryacct"
                                        TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *    
               WHEN    "88888888"
                   MOVE    "DBUPDATE"   TO      MCP-FUNC
      *---> test   MOVE    "DBDELETE"   TO      MCP-FUNC
                   MOVE    "tbl_sryacct"
                                        TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *    
               WHEN      OTHER
                   MOVE    "DBINSERT"   TO      MCP-FUNC
                   MOVE    "tbl_sryacct"
                                        TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
           END-EVALUATE
           PERFORM  900-REALDB-INS-SEC
           .
       20011-SRYACCT-DB-MAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理(受診履歴)
      *****************************************************************
       20011-JYURRK-DB-MAKE-SEC      SECTION.
           EVALUATE    JYURRK-CREYMD
               WHEN    "99999999"
                   MOVE    "DBDELETE"   TO      MCP-FUNC
                   MOVE    "tbl_jyurrk" TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *    
               WHEN    "88888888"
                   MOVE    "DBUPDATE"   TO      MCP-FUNC
                   MOVE    "tbl_jyurrk" TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *    
               WHEN      OTHER
                   MOVE    "DBINSERT"   TO      MCP-FUNC
                   MOVE    "tbl_jyurrk" TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
           END-EVALUATE
           PERFORM  900-REALDB-INS-SEC
           .
       20011-JYURRK-DB-MAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理(患者コメント)
      *****************************************************************
       20011-PTCOM-DB-MAKE-SEC      SECTION.
           EVALUATE    PTCOM-CREYMD
               WHEN    "99999999"
                   MOVE    "DBDELETE"   TO      MCP-FUNC
                   MOVE    "tbl_ptcom"  TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *    
               WHEN    "999del11"
                   MOVE    "DBDELETE"   TO      MCP-FUNC
                   MOVE    "tbl_ptcom"  TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *    
               WHEN    "88888888"
                   MOVE    "DBUPDATE"   TO      MCP-FUNC
                   MOVE    "tbl_ptcom"  TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
      *    
               WHEN      OTHER
                   MOVE    "DBINSERT"   TO      MCP-FUNC
                   MOVE    "tbl_ptcom"  TO      MCP-TABLE
                   MOVE    "key"        TO      MCP-PATHNAME
           END-EVALUATE
           PERFORM  900-REALDB-INS-SEC
           .
       20011-PTCOM-DB-MAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理
      *****************************************************************
       20011-REAL-DB-DELETE-SEC      SECTION.
      *受診履歴削除
           DISPLAY "real db(jyurrk) delete st  "
                   " "  LNK-TIMEOFDAY(1:20)
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      JYURRK-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      JYURRK-NYUGAIKBN
           MOVE    WRK-PARA-PTID        TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      JYURRK-PTID
           MOVE    WRK-PARA-A8          TO      WRK-SRYYM
           MOVE    "% "                 TO      WRK-SRYDD
           MOVE    WRK-SRYYMD           TO      JYURRK-SRYYMD
           MOVE    JYURRK-REC           TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_jyurrk"         TO      MCP-TABLE
           MOVE    "del2"               TO      MCP-PATHNAME
grpsys     PERFORM 900-ORCDBMAIN-SEC
           DISPLAY "real db(jyurrk) delete ed  "
                   " "  LNK-TIMEOFDAY(1:20)
      *診療会計削除
           DISPLAY "real db(sryacct) delete st  "
                   " "  LNK-TIMEOFDAY(1:20)
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      ACCT-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      ACCT-NYUGAIKBN
           MOVE    WRK-PARA-PTID        TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      ACCT-PTID
           MOVE    WRK-PARA-A8          TO      ACCT-SRYYM
           DISPLAY "WRK-PARA-A8 = " WRK-PARA-A8
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_sryacct"        TO      MCP-TABLE
           MOVE    "del3"               TO      MCP-PATHNAME
grpsys     PERFORM 900-ORCDBMAIN-SEC
           DISPLAY "real db(sryacct) delete ed  "
                   " "  LNK-TIMEOFDAY(1:20)
           PERFORM 200111-REAL-SRYACY-DB-DELETE2-SEC
           DISPLAY "real db(sryact) del ed  "
                   " "  LNK-TIMEOFDAY(1:20)
      *算定履歴削除
           DISPLAY "real db(santei) del ed  "
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      SANTEI-HOSPNUM
           MOVE    WRK-PARA-PTID        TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      SANTEI-PTID
           MOVE    WRK-PARA-A8          TO      SANTEI-SRYYM
           MOVE    SANTEI-REC           TO      MCPDATA-REC
           MOVE    "tbl_santei"         TO  MCP-TABLE
           MOVE    "del1"               TO  MCP-PATHNAME
           MOVE    "DBDELETE"           TO      MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
           .
       20011-REAL-DB-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理
      *****************************************************************
       200111-REAL-SRYACY-DB-DELETE2-SEC   SECTION.
      *
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      SRY-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      SRY-NYUGAIKBN
           MOVE    WRK-PARA-PTID        TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      SRY-PTID
           MOVE    WRK-PARA-A8          TO      SRY-SRYYM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "tbl_sryact"         TO  MCP-TABLE
           MOVE    "key4"               TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_sryact"         TO  MCP-TABLE
               MOVE    "key4"               TO  MCP-PATHNAME
               PERFORM  900-ACTPRV-READ-SEC
               PERFORM  UNTIL
                        (FLG-SRYACT         =    1)
                   MOVE    SRYACT-REC  TO      MCPDATA-REC
                   MOVE    "DBDELETE"  TO      MCP-FUNC
                   MOVE    "tbl_sryact"         TO  MCP-TABLE
                   MOVE    "key"                TO  MCP-PATHNAME
                   PERFORM  900-REALDB-INS-SEC
      *
                   MOVE    "tbl_sryact"         TO  MCP-TABLE
                   MOVE    "key4"               TO  MCP-PATHNAME
                   PERFORM  900-ACTPRV-READ-SEC
               END-PERFORM
           END-IF 
      *
           MOVE    "tbl_sryact"         TO  MCP-TABLE
           MOVE    "key4"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       200111-REAL-SRYACY-DB-DELETE2-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理(チェックマスタ４)
      *****************************************************************
       20011-CHK004-DB-MAKE-SEC        SECTION.
           DISPLAY "chk004 org delete start"
           MOVE    WRK-PARA-HOSPNUM    TO      CHK004-HOSPNUM
           MOVE    "2001"              TO      CHK004-KANRICD
           MOVE    "10000001"          TO      CHK004-KBNCD
           MOVE    WRK-PTID            TO      CHK004-PTID
           MOVE    CHK004-REC          TO      MCPDATA-REC
           DISPLAY "hospnum = " CHK004-HOSPNUM
           DISPLAY "ptid    = " CHK004-PTID
           MOVE    "DBDELETE"          TO      MCP-FUNC
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "del3"              TO  MCP-PATHNAME
           PERFORM  900-REALDB-INS-SEC
           DISPLAY "chk004 insert start"
           MOVE    WRK-PARA-HOSPNUM    TO      CHK004-HOSPNUM
           MOVE    "2001"              TO      CHK004-KANRICD
           MOVE    "10000001"          TO      CHK004-KBNCD
           MOVE    WRK-PARA-PTID       TO      WRK-PTID-X
           MOVE    WRK-PTID            TO      CHK004-PTID
           MOVE    "00000000"          TO      CHK004-STYUKYMD
           MOVE    "99999999"          TO      CHK004-EDYUKYMD
           MOVE    " 1"                TO      CHK004-KANRITBL
           MOVE    CHK004-REC          TO      MCPDATA-REC
           MOVE    "DBINSERT"          TO      MCP-FUNC
           MOVE    "tbl_chk004"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM  900-REALDB-INS-SEC
           DISPLAY "chk004 insert end  "
           .
       20011-CHK004-DB-MAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    実ＤＢ更新処理
      *****************************************************************
       20011-REAL-DB-MAKE-SEC        SECTION.
           DISPLAY "real db make st  "
                   " "  LNK-TIMEOFDAY(1:20)
           PERFORM 20011-REAL-DB-DELETE-SEC
      *収納マスタ関係は、負担金を捨てるということで一時コメントアウト
      *※ 但し、収納金額を見て負担者番号の出し入れをしているのも無視
      *   される。(どうする)
      *収納マスタ
      **   MOVE    WRK-PARA-HOSPNUM      TO      SYU-HOSPNUM
      **   MOVE    WRK-PARA-NYUGAIKBN   TO      SYU-NYUGAIKBN
      **   MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
      **   MOVE    WRK-PTID             TO      SYU-PTID
      **   MOVE    SYUNOU-REC           TO      MCPDATA-REC
      **   MOVE    "DBSELECT"           TO      MCP-FUNC
      **   MOVE    PATH-TBL-SYUNOU-PRV-KEY2
      **                                TO      MCP-PATH
      **   DISPLAY "take syunou read "
      **                        WRK-PARA-HOSPNUM WRK-PTID
      **   CALL    "MCPSUB"             USING
      **                                MCPAREA
      **                                MCPDATA-REC
      **   IF      MCP-RC               =       ZERO
      **       MOVE    PATH-TBL-SYUNOU-PRV-KEY2
      **                                TO      MCP-PATH
      **       PERFORM  900-SYUNOUPRV-READ-SEC
      **       PERFORM  UNTIL
      **                (FLG-SYUNOU             =    1)
      **           MOVE    SYUNOU-REC   TO      MCPDATA-REC
      **           PERFORM 20011-SYUNOU-DB-MAKE-SEC
      **           MOVE    PATH-TBL-SYUNOU-PRV-KEY2
      **                                TO      MCP-PATH
      **           PERFORM  900-SYUNOUPRV-READ-SEC
      **       END-PERFORM
      **   ELSE
      **                DISPLAY "take syunou read err  "
      **                        WRK-PARA-HOSPNUM WRK-PTID
      **   END-IF
      *
      *--------------------------------------------------
      *収納明細マスタ
      **   MOVE    WRK-PARA-HOSPNUM      TO      SMEI-HOSPNUM
      **   MOVE    WRK-PARA-NYUGAIKBN   TO      SMEI-NYUGAIKBN
      **   MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
      **   MOVE    WRK-PTID             TO      SMEI-PTID
      **   MOVE    SYUMEI-REC           TO      MCPDATA-REC
      **   MOVE    "DBSELECT"           TO      MCP-FUNC
      **   MOVE    PATH-TBL-SYUMEI-PRV-KEY2
      **                                TO      MCP-PATH
      **   DISPLAY "take syumei read  "
      **                        WRK-PARA-HOSPNUM WRK-PTID
      **   CALL    "MCPSUB"             USING
      **                                MCPAREA
      **                                MCPDATA-REC
      **   IF      MCP-RC               =       ZERO
      **       MOVE    PATH-TBL-SYUMEI-PRV-KEY2
      **                                TO      MCP-PATH
      **       PERFORM  900-SYUMEIPRV-READ-SEC
      **       PERFORM  UNTIL
      **                (FLG-SYUMEI             =    1)
      **           MOVE    SYUMEI-REC   TO      MCPDATA-REC
      **           PERFORM 20011-SYUMEI-DB-MAKE-SEC
      **           MOVE    PATH-TBL-SYUMEI-PRV-KEY2
      **                                TO      MCP-PATH
      **           PERFORM  900-SYUMEIPRV-READ-SEC
      **       END-PERFORM
      **   ELSE
      **                DISPLAY "take syumei read err  "
      **                        WRK-PARA-HOSPNUM WRK-PTID
      **   END-IF
      *
      *--------------------------------------------------
      *--------------------------------------------------
      *収納トータルマスタ
      **   MOVE    WRK-PARA-HOSPNUM      TO      SYUTTL-HOSPNUM
      **   MOVE    WRK-PARA-NYUGAIKBN   TO      SYUTTL-NYUGAIKBN
      **   MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
      **   MOVE    WRK-PTID             TO      SYUTTL-PTID
      **   MOVE    SYUTTL-REC           TO      MCPDATA-REC
      **   MOVE    "DBSELECT"           TO      MCP-FUNC
      **   MOVE    PATH-TBL-SYUTOTAL-PRV-KEY2
      **                                TO      MCP-PATH
      **   DISPLAY "take syuttl read  "
      **                        WRK-PARA-HOSPNUM WRK-PTID
      **   CALL    "MCPSUB"             USING
      **                                MCPAREA
      **                                MCPDATA-REC
      **   IF      MCP-RC               =       ZERO
      **       MOVE    PATH-TBL-SYUTOTAL-PRV-KEY2
      **                                TO      MCP-PATH
      **       PERFORM  900-SYUTTLPRV-READ-SEC
      **       PERFORM  UNTIL
      **                (FLG-SYUTTL             =    1)
      **           MOVE    SYUTTL-REC   TO      MCPDATA-REC
      **           PERFORM 20011-SYUMEI-DB-MAKE-SEC
      **           MOVE    PATH-TBL-SYUTOTAL-PRV-KEY2
      **                                TO      MCP-PATH
      **           PERFORM  900-SYUTTLPRV-READ-SEC
      **       END-PERFORM
      **   ELSE
      **                DISPLAY "take syuttl read err  "
      **                        WRK-PARA-HOSPNUM WRK-PTID
      **   END-IF
      *
      *--------------------------------------------------
      *会計マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      ACCT-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      ACCT-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      ACCT-PTID
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "tbl_sryacct_prv"    TO  MCP-TABLE
           MOVE    "key40"              TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_sryacct_prv"    TO  MCP-TABLE
               MOVE    "key40"              TO  MCP-PATHNAME
               PERFORM  900-ACCTPRV-READ-SEC
               PERFORM  UNTIL
                        (FLG-SRYACCT         =    1)
                   MOVE    SRYACCT-REC  TO      MCPDATA-REC
                   PERFORM 20011-SRYACCT-DB-MAKE-SEC
      * 
                   MOVE    "tbl_sryacct_prv"    TO  MCP-TABLE
                   MOVE    "key40"              TO  MCP-PATHNAME
                   PERFORM  900-ACCTPRV-READ-SEC
               END-PERFORM
           ELSE
                        DISPLAY "take acct read err  "
                                WRK-PARA-HOSPNUM WRK-PTID
           END-IF
      *--------------------------------------------------
      * ★ DBCLOSECURSOR
           MOVE    "tbl_sryacct_prv"    TO  MCP-TABLE
           MOVE    "key40"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *--------------------------------------------------
      *診療行為マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      SRY-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      SRY-NYUGAIKBN
           MOVE    WRK-PARA-PTID        TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      SRY-PTID
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "tbl_sryact_prv"     TO  MCP-TABLE
           MOVE    "key12"              TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_sryact_prv"     TO  MCP-TABLE
               MOVE    "key12"              TO  MCP-PATHNAME
               PERFORM  900-ACTPRV-READ-SEC
               PERFORM  UNTIL
                        (FLG-SRYACT         =    1)
                   MOVE    SRYACT-REC  TO      MCPDATA-REC
                   MOVE    "DBINSERT"   TO      MCP-FUNC
                   MOVE    "tbl_sryact"         TO  MCP-TABLE
                   MOVE    "key"                TO  MCP-PATHNAME
                   PERFORM  900-REALDB-INS-SEC
      *
                   MOVE    "tbl_sryact_prv"     TO  MCP-TABLE
                   MOVE    "key12"              TO  MCP-PATHNAME
                   PERFORM  900-ACTPRV-READ-SEC
               END-PERFORM
           ELSE
                        DISPLAY "take act read err  "
                                WRK-PARA-HOSPNUM WRK-PTID
           END-IF
      *--------------------------------------------------
      * ★ DBCLOSECURSOR
           MOVE    "tbl_sryact_prv"     TO  MCP-TABLE
           MOVE    "key12"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *--------------------------------------------------
      *算定履歴マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      SANTEI-HOSPNUM
      *    MOVE    WRK-PARA-NYUGAIKBN   TO      SANTEI-NYUGAIKBN
           MOVE    ZERO                 TO      SANTEI-NYUGAIKBN
           MOVE    WRK-PARA-PTID        TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      SANTEI-PTID
           MOVE    SANTEI-REC           TO      MCPDATA-REC
           MOVE    "tbl_santei_prv"     TO  MCP-TABLE
           MOVE    "key2"               TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_santei_prv"     TO  MCP-TABLE
               MOVE    "key2"               TO  MCP-PATHNAME
               PERFORM  900-SANTEIPRV-READ-SEC
               PERFORM  UNTIL
                        (FLG-SANTEI         =    1)
                   MOVE    SANTEI-REC   TO      MCPDATA-REC
                   MOVE    "DBINSERT"   TO      MCP-FUNC
                   MOVE    "tbl_santei" TO  MCP-TABLE
                   MOVE    "key"        TO  MCP-PATHNAME
                   PERFORM  900-REALDB-INS-SEC
      *
                MOVE    "tbl_santei_prv"     TO  MCP-TABLE
                MOVE    "key2"               TO  MCP-PATHNAME
                PERFORM  900-SANTEIPRV-READ-SEC
               END-PERFORM
           ELSE
                        DISPLAY "take santei read err  "
                                WRK-PARA-HOSPNUM WRK-PTID
           END-IF
      *--------------------------------------------------
      * ★ DBCLOSECURSOR
           MOVE    "tbl_santei_prv"     TO  MCP-TABLE
           MOVE    "key2"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *--------------------------------------------------
      *受診履歴マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      JYURRK-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      JYURRK-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      JYURRK-PTID
           MOVE    JYURRK-REC           TO      MCPDATA-REC
           MOVE    "tbl_jyurrk_prv"     TO  MCP-TABLE
           MOVE    "key30"              TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_jyurrk_prv"     TO  MCP-TABLE
               MOVE    "key30"              TO  MCP-PATHNAME
               PERFORM  900-JYURRKPRV-READ-SEC
               PERFORM  UNTIL
                        (FLG-JYURRK         =    1)
                   MOVE    JYURRK-REC   TO      MCPDATA-REC
                   PERFORM  20011-JYURRK-DB-MAKE-SEC
      *
                   MOVE    "tbl_jyurrk_prv"     TO  MCP-TABLE
                   MOVE    "key30"              TO  MCP-PATHNAME
                   PERFORM  900-JYURRKPRV-READ-SEC
               END-PERFORM
           ELSE
                        DISPLAY "take jyurrk read err  "
                                WRK-PARA-HOSPNUM WRK-PTID
           END-IF
      *--------------------------------------------------
      * ★ DBCLOSECURSOR
           MOVE    "tbl_jyurrk_prv"     TO  MCP-TABLE
           MOVE    "key30"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *--------------------------------------------------
      *診療科履歴マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      KARRK-HOSPNUM
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      KARRK-PTID
           MOVE    SRYKARRK-REC         TO      MCPDATA-REC
           MOVE    "tbl_srykarrk_prv"   TO  MCP-TABLE
           MOVE    "key2"               TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_srykarrk_prv"   TO  MCP-TABLE
               MOVE    "key2"               TO  MCP-PATHNAME
               PERFORM  900-SRYKARRKPRV-READ-SEC
               PERFORM  UNTIL
                        (FLG-SRYKARRK      =    1)
grpsys*            MOVE SPA-HOSPNUM TO -HOSPNUM
                   MOVE    SRYKARRK-REC TO      MCPDATA-REC
                   IF  KARRK-CREYMD         =       "99999999"
                       MOVE    "DBDELETE"   TO      MCP-FUNC
                   ELSE
                       IF  KARRK-CREYMD     =       "88888888"
                           MOVE    "DBUPDATE"   TO      MCP-FUNC
                       ELSE
                           MOVE    "DBINSERT"   TO      MCP-FUNC
                       END-IF
                   END-IF
                   MOVE    "tbl_srykarrk"       TO  MCP-TABLE
                   MOVE    "key"                TO  MCP-PATHNAME
                   PERFORM  900-REALDB-INS-SEC
      *
                   MOVE    "tbl_srykarrk_prv"   TO  MCP-TABLE
                   MOVE    "key2"               TO  MCP-PATHNAME
                   PERFORM  900-SRYKARRKPRV-READ-SEC
               END-PERFORM
           ELSE
                        DISPLAY "take srykarrk read err  "
                                WRK-PARA-HOSPNUM WRK-PTID
           END-IF
      *--------------------------------------------------
      * ★ DBCLOSECURSOR
           MOVE    "tbl_srykarrk_prv"   TO  MCP-TABLE
           MOVE    "key2"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *--------------------------------------------------
      *患者コメントマスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      PTCOM-HOSPNUM
           MOVE    WRK-PARA-PTID        TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      PTCOM-PTID
           MOVE    PTCOM-REC            TO      MCPDATA-REC
           MOVE    "tbl_ptcom_prv"      TO  MCP-TABLE
           MOVE    "key3"               TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
      *
           MOVE    ZERO                 TO      WRK-ZAINUM
      *
           IF      MCP-RC               =       ZERO
               MOVE    "tbl_ptcom_prv"      TO  MCP-TABLE
               MOVE    "key3"               TO  MCP-PATHNAME
               PERFORM  900-PTCOMPRV-READ-SEC
               PERFORM  UNTIL
                        (FLG-PTCOM      =    1)
                   IF  WRK-ZAINUM       NOT =       PTCOM-ZAINUM
                       MOVE    PTCOM-ZAINUM TO      WRK-ZAINUM
                       MOVE    PTCOM-REC    TO      MCPDATA-REC
                       MOVE    "DBDELETE"   TO      MCP-FUNC
                       MOVE    "tbl_ptcom"  TO  MCP-TABLE
                       MOVE    "del11"      TO  MCP-PATHNAME
                       PERFORM  900-REALDB-INS-SEC
                       IF      MCP-RC       NOT  =  ZERO
                           DISPLAY "take ptcom del er " PTCOM-REC(1:100)
                       END-IF
                   END-IF
                   MOVE    PTCOM-REC    TO      MCPDATA-REC
                   IF  PTCOM-CREYMD         =       "99999999"
                       MOVE    "DBDELETE"   TO      MCP-FUNC
                   ELSE
                       IF  PTCOM-CREYMD     =       "88888888"
                           MOVE    "DBUPDATE"   TO      MCP-FUNC
                       ELSE
                           MOVE    "DBINSERT"   TO      MCP-FUNC
                       END-IF
                   END-IF
                   MOVE    "tbl_ptcom"     TO  MCP-TABLE
                   MOVE    "key"           TO  MCP-PATHNAME
                   PERFORM  900-REALDB-INS-SEC
                   IF      MCP-RC       NOT  =  ZERO
                       DISPLAY "take ptcom ins er " PTCOM-REC(1:100)
                   END-IF
      *
                   MOVE    "tbl_ptcom_prv"      TO  MCP-TABLE
                   MOVE    "key3"               TO  MCP-PATHNAME
                   PERFORM  900-PTCOMPRV-READ-SEC
               END-PERFORM
           ELSE
                        DISPLAY "take ptcom read err  "
                                WRK-PARA-HOSPNUM WRK-PTID
           END-IF
      *--------------------------------------------------
      * ★ DBCLOSECURSOR
           MOVE    "tbl_ptcom_prv"      TO  MCP-TABLE
           MOVE    "key3"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *--------------------------------------------------
      *
           DISPLAY "real db make ed  "
                   " "  LNK-TIMEOFDAY(1:20)
           .
       20011-REAL-DB-MAKE-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納読込
      *****************************************************************
       900-SYUNOUPRV-READ-SEC           SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       900-SYUNOUPRV-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細読込
      *****************************************************************
       900-SYUMEIPRV-READ-SEC           SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUMEI-REC
               MOVE    ZERO            TO  FLG-SYUMEI
           ELSE
               INITIALIZE                  SYUMEI-REC
               MOVE    1               TO  FLG-SYUMEI
           END-IF
      *
           .
       900-SYUMEIPRV-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納トータル読込
      *****************************************************************
       900-SYUTTLPRV-READ-SEC           SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUTTL-REC
               MOVE    ZERO            TO  FLG-SYUTTL
           ELSE
               INITIALIZE                  SYUTTL-REC
               MOVE    1               TO  FLG-SYUTTL
           END-IF
      *
           .
       900-SYUTTLPRV-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    会計読込
      *****************************************************************
       900-ACCTPRV-READ-SEC            SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
               MOVE    ZERO            TO  FLG-SRYACCT
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           .
       900-ACCTPRV-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為読込
      *****************************************************************
       900-ACTPRV-READ-SEC             SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       900-ACTPRV-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴読込
      *****************************************************************
       900-JYURRKPRV-READ-SEC          SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       900-JYURRKPRV-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定履歴読込
      *****************************************************************
       900-SANTEIPRV-READ-SEC          SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SANTEI-REC
               MOVE    ZERO            TO  FLG-SANTEI
           ELSE
               INITIALIZE                  SANTEI-REC
               MOVE    1               TO  FLG-SANTEI
           END-IF
      *
           .
       900-SANTEIPRV-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科履歴読込
      *****************************************************************
       900-SRYKARRKPRV-READ-SEC        SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYKARRK-REC
               MOVE    ZERO            TO  FLG-SRYKARRK
           ELSE
               INITIALIZE                  SRYKARRK-REC
               MOVE    1               TO  FLG-SRYKARRK
           END-IF
      *
           .
       900-SRYKARRKPRV-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者コメント読込
      *****************************************************************
       900-PTCOMPRV-READ-SEC           SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTCOM-REC
               MOVE    ZERO            TO  FLG-PTCOM 
           ELSE
               INITIALIZE                  PTCOM-REC
               MOVE    1               TO  FLG-PTCOM
           END-IF
      *
           .
       900-PTCOMPRV-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    本体DB更新処理
      *****************************************************************
       900-REALDB-INS-SEC            SECTION.
      *
grpsys     PERFORM 900-ORCDBMAIN-SEC
           IF      MCP-RC         NOT  =   ZERO
               INITIALIZE                  MCPDATA-REC
               DISPLAY "INS ERR = " MCP-RC
           END-IF
      *
           .
       900-REALDB-INS-EXT.
           EXIT.
      *
      *****************************************************************
      *    テンポラリDB削除処理
      *****************************************************************
       20011-TMPDB-DELETE-SEC        SECTION.
      *収納マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      SYU-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      SYU-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      SYU-PTID
           MOVE    SYUNOU-REC           TO      MCPDATA-REC
           DISPLAY "take tmp db delete syunou st = " SYU-PTID "," 
                                           SYU-HOSPNUM ","
                                           SYU-NYUGAIKBN
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_syunou_prv"     TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           PERFORM  900-REALDB-INS-SEC
      *
      *収納明細マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      SMEI-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      SMEI-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      SMEI-PTID
           MOVE    SYUMEI-REC           TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_syumei_prv"     TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           DISPLAY "take tmp db delete syumei st = " SYU-PTID "," 
           PERFORM  900-REALDB-INS-SEC
      *
      *収納トータルマスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      SYUTTL-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      SYUTTL-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      SYUTTL-PTID
           MOVE    SYUTTL-REC           TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           DISPLAY "take tmp db delete syutotal st = " SYUTTL-PTID "," 
           MOVE    "tbl_syutotal_prv"   TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           PERFORM  900-REALDB-INS-SEC
      *
      *会計マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      ACCT-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      ACCT-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      ACCT-PTID
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_sryacct_prv"    TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           DISPLAY "take tmp db delete acct st = " SYU-PTID "," 
           PERFORM  900-REALDB-INS-SEC
      *
      *診療行為マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      SRY-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      SRY-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      SRY-PTID
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_sryact_prv"     TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           DISPLAY "take tmp db delete act st = " SYU-PTID "," 
           PERFORM  900-REALDB-INS-SEC
      *
      *算定履歴マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      SANTEI-HOSPNUM
      *    MOVE    WRK-PARA-NYUGAIKBN   TO      SANTEI-NYUGAIKBN
           MOVE    ZERO                 TO      SANTEI-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      SANTEI-PTID
           MOVE    SANTEI-REC           TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_santei_prv"     TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           DISPLAY "take tmp db delete santei st = " SYU-PTID "," 
           PERFORM  900-REALDB-INS-SEC
      *
      *受診履歴マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      JYURRK-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      JYURRK-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      JYURRK-PTID
           MOVE    JYURRK-REC           TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_jyurrk_prv"     TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           DISPLAY "take tmp db delete jyurr st = " SYU-PTID "," 
           PERFORM  900-REALDB-INS-SEC
      *
      *診療科履歴マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      KARRK-HOSPNUM
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      KARRK-PTID
           MOVE    SRYKARRK-REC         TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_srykarrk_prv"   TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           DISPLAY "take tmp db delete srykarr st = " SYU-PTID "," 
           PERFORM  900-REALDB-INS-SEC
      *
      *患者コメントマスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      PTCOM-HOSPNUM
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      PTCOM-PTID
           MOVE    PTCOM-REC            TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_ptcom_prv"      TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           DISPLAY "take tmp db delete ptcom st = " SYU-PTID "," 
           PERFORM  900-REALDB-INS-SEC
      *
      *患者マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      PTINF-HOSPNUM
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      PTINF-PTID
           MOVE    PTINF-REC            TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_ptinf_prv"      TO  MCP-TABLE
           MOVE    "delprv"             TO  MCP-PATHNAME
           DISPLAY "take tmp db delete ptinf st = " SYU-PTID "," 
           PERFORM  900-REALDB-INS-SEC
      *診療行為付加情報マスタ
grpsys     MOVE    WRK-PARA-HOSPNUM     TO      ACCTP-HOSPNUM
           MOVE    WRK-PARA-NYUGAIKBN   TO      ACCTP-NYUGAIKBN
           MOVE    WRK-PARA-PTID         TO      WRK-PTID-X
           MOVE    WRK-PTID             TO      ACCTP-PTID
           MOVE    SRYACCTPLUS-REC      TO      MCPDATA-REC
           MOVE    "DBDELETE"           TO      MCP-FUNC
           MOVE    "tbl_sryacctplus_prv"
                                        TO  MCP-TABLE
           MOVE    "del1"               TO  MCP-PATHNAME
           DISPLAY "take tmp db delete ptinf st = " SYU-PTID "," 
           PERFORM  900-REALDB-INS-SEC
      *
           .
       20011-TMPDB-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷管理ＤＢ読み込み
      *****************************************************************
       900-PRVKANRI-FET-SEC            SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PRVKANRI-REC
               MOVE    ZERO                TO  FLG-PRVKANRI
           ELSE
               MOVE    1                   TO  FLG-PRVKANRI
           END-IF
           .
       900-PRVKANRI-FET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢオープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBOPEN"            TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBSTART"           TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBCOMMIT-SEC                SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBCOMMIT"          TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBCOMMIT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
      *    MOVE    "ROLLBACK"          TO  MCP-FUNC.
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC.
      *    DISPLAY "rollback mcp-rc = " MCP-RC
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBDISCONNECT-EXT.
           EXIT.
