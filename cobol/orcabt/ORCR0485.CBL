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
       PROGRAM-ID.                 ORCR0485.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト（労災・自賠責）
      *  コンポーネント名  : 月次業務　労災自賠責明細書ファイル作成
      *                      （自賠責保険・印刷データ編集）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/09/20    NACL-門脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-藤原    02/10/03  入外区分・処理区分の追加
      *  01.00.02    NACL-藤原    03/01/09  通し番号の追加のため
      *                                     ＭＯＮＰＥに変更
      *  01.00.03    NACL-門脇    03/02/12  医療機関名の長さ変更のため
      *                                     帳票ＩＤ変更
      *  01.00.04    NACL-門脇    03.03.03  剤番号桁修正対応
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
           SELECT  RECE41-FILE     ASSIGN  RECE41PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE41-KEY
                                   FILE    STATUS  IS  STS-RECE41.
      *                             
           SELECT  RECE43-FILE     ASSIGN  RECE43PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE43-KEY
                                   FILE    STATUS  IS  STS-RECE43.
      *   
           SELECT  RECE47-FILE     ASSIGN  RECE47PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE47-KEY
                                   FILE    STATUS  IS  STS-RECE47.
      *   
           SELECT  RECE471-FILE    ASSIGN  RECE471PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE471-KEY
                                   FILE    STATUS  IS  STS-RECE471.
      *
      *    日付ファイル
      ***  SELECT  RECEYMD-FILE    ASSIGN  RECEYMD
      ***                          FILE    STATUS  IS  STS-RECEYMD.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    保険別患者情報ファイル
       FD  RECE41-FILE.
       01  RECE41-REC.
           COPY    "CPRCF041.INC".
      *
      *    病名ファイル    
       FD  RECE43-FILE.
       01  RECE43-REC.
           COPY    "CPRCF043.INC".
      *
      *    点数摘要欄ファイル
       FD  RECE47-FILE.
       01  RECE47-REC. 
           COPY    "CPRCF047.INC".
      *
      *    金額摘要欄ファイル
       FD  RECE471-FILE.
       01  RECE471-REC. 
           COPY    "CPRCF0471.INC".
      *
      *    日付ファイル
      *FD  RECEYMD-FILE.
      *01  RECEYMD-REC.
      *    03  RECEYMD-CREYMD      PIC X(08).
      *    03  RECEYMD-CREHMS      PIC X(06). 
      *    03  RECEYMD-RECENUM     PIC 9(06). 
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE41//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE43//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE47//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE471//.
      *
      *    日付ファイル 
      ***  COPY    "CPCOMMONDAT2.INC"
      ***                          REPLACING  //RECE01PARA//
      ***                          BY         //RECEYMD//.
      ***  03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    自賠責     
      *****COPY    "HC23.INC".
      *****COPY    "HCM23.INC"     REPLACING  //HCM23//
      *****                        BY         //HC23//.
           COPY    "HCM23V01.INC"  REPLACING  //HCM23V01//
                                   BY         //HC23//.
      *
      *    自賠責（続紙）     
      *****COPY    "HC29.INC".
           COPY    "HCM29.INC"     REPLACING  //HCM29//
                                   BY         //HC29//.
      *
      *    スパ領域
       01  SPA-AREA.
           03  SPA-STS             PIC 9(04).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE41          PIC X(02).
           03  STS-RECE43          PIC X(02).
           03  STS-RECE47          PIC X(02).
           03  STS-RECE471          PIC X(02).
           03  STS-RECEERR         PIC X(02).
      ***  03  STS-RECEYMD         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(03).
           03  FLG-RECE41          PIC 9(01).
           03  FLG-RECE43          PIC 9(01).
           03  FLG-RECE47          PIC 9(01).
           03  FLG-RECE471          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-RECE07          PIC 9(01).
           03  FLG-RECE08          PIC 9(01).
           03  FLG-RECECOM         PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
      *
           03  FLG-KUGIRI          PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
           03  CNT-RECE41          PIC 9(06).
           03  CNT-RECE03          PIC 9(06).
           03  CNT-RECE47          PIC 9(06).
           03  CNT-RECE471         PIC 9(06).
           03  CNT-RECE09          PIC 9(06).
           03  CNT-OUT             PIC 9(06).
           03  CNT-ZAIMEISAISU     PIC 9(03).
           03  CNT-PAGE            PIC 9(03).
           03  CNT-KENSU           PIC 9(03). 
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME.
               05  SYS-THH         PIC 9(02).
               05  SYS-TMM         PIC 9(02).
               05  SYS-TSS         PIC 9(02).
               05  SYS-TDD         PIC 9(02).
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                 PIC 9(04).
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDA                 PIC 9(04).
           03  IDB                 PIC 9(04).
           03  IDX1                PIC 9(02).
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
           03  IDXP                PIC 9(02).
           03  IDY1                PIC 9(03).
           03  IDY2                PIC 9(03).
           03  IDY3                PIC 9(03).
      *
      *    
       01  KEY-AREA                          VALUE   LOW-VALUE.          
           03  KEY-NEW.
               05  KEY-N-HOSPID    PIC  X(24).
               05  KEY-N-SRYYM     PIC  9(06).
               05  KEY-N-NYUGAIKBN PIC  X(01).
               05  KEY-N-PTID      PIC  9(10).
               05  KEY-N-RECEKA    PIC  X(02).
           03  KEY-OLD.
               05  KEY-O-HOSPID    PIC  X(24).
               05  KEY-O-SRYYM     PIC  9(06).
               05  KEY-O-NYUGAIKBN PIC  X(01).
               05  KEY-O-PTID      PIC  9(10).
               05  KEY-O-RECEKA    PIC  X(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM   PIC  X(06).
               05  WRK-PARA-TERMID  PIC  X(16).
               05  WRK-PARA-SYSYMD  PIC  X(08).
               05  WRK-PARA-RECEKBN PIC  X(01).
               05  WRK-PARA-RECEYM  PIC  X(06). 
               05  WRK-PARA-JOBID   PIC  9(07).
               05  WRK-PARA-SHELLID PIC  X(08).
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-RECEERR         PIC X(200).
      *
           03  WRK-RECENUM          PIC 9(06). 
      *
           03  WRK-ERRMSG          PIC X(40).
           03  WRK-NENREI          PIC 9(05).
           03  WRK-NENREI-R        REDEFINES   WRK-NENREI.
               05  WRK-NENREI-R1   PIC 9(03).
               05  WRK-NENREI-R2   PIC 9(02).
           03  WRK-BIRTHDAY.
               05  WRK-BIRTHYM     PIC 9(06).
               05  WRK-BIRTHDD     PIC 9(02). 
      *
           03  WRK-LINE-MAX        PIC 9(03).          
      *
           03  WRK-GOKEI           PIC 9(07).            
      *
           03  WRK-STYMD           PIC X(08).
           03  WRK-EDYMD           PIC X(08).
           03  WRK-STYMDW          PIC X(06).
           03  WRK-EDYMDW          PIC X(06).
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMDG.
               05  WRK-HENGENGO    PIC X(01).
               05  WRK-HENYMD.
                   07  WRK-HENYY   PIC X(02).
                   07  WRK-HENMM   PIC X(02).
                   07  WRK-HENDD   PIC X(02).
      *
           03  WRK-EDIT-AREA.
      *        編集傷病名文字数 
               05  WRK-CLM                     PIC 9(03).
      *        ワーク編集傷病名文字数 
               05  WRK-WCLM                    PIC 9(03).
      *        病名文字数         
               05  WRK-MOJISU                  PIC 9(03).
      *        編集開始位置         
               05  WRK-STCLM                   PIC 9(03).
      *        傷病名欄編集行         
               05  WRK-LINEBYO                 PIC 9(02).
      *        適用欄編集行（点数）               
               05  WRK-LINETEK                 PIC 9(03).
      *        適用欄編集行（金額）               
               05  WRK-LINETEK1                PIC 9(03).
      *         
      *    傷病名編集（傷病名欄）
           03  WRK-BYOMEI1.
      **       05  WRK-BYOMEI1-NAME            PIC X(44).
               05  WRK-BYOMEI1-NAME            PIC X(50).
      *    傷病名編集（適用欄）
           03  WRK-BYOMEI2.  
               05  WRK-BYOMEI2-NAME            PIC X(52).
      *
           03  WRK-WLINETEK                    PIC 9(03).
           03  WRK-R061-ZAINUM-O               PIC 9(08).
           03  WRK-R061-SRYKBN-O               PIC X(02).
      *
      *    レセプトコメント編集
           03  WRK-COMMENT-G.
               05  WRK-COMMENT                 PIC X(50)
                                               OCCURS  8.
           03  WRK-COMM                        PIC X(400).
           03  WRK-COMM1                       PIC X(400).
           03  WRK-COL                         PIC 9(03). 
           03  WRK-RECECOM         PIC 9(01).
           03  WRK-RECEHEN         PIC 9(01).
      *
      *    区切り線
       01  WRK-LINE-AREA.
           03  WRK-KUGIRI1         PIC X(52)   VALUE
               ALL "−".
           03  WRK-KUGIRI2.
               05  FILLER          PIC X(16)   VALUE
                                   "＝＝＝＝＝＝＝＝".
               05  FILLER          PIC X(20)   VALUE
                                   "　金額行為（続き）　".
               05  FILLER          PIC X(16)   VALUE
                                   "＝＝＝＝＝＝＝＝".
      **   03  WRK-KUGIRI3         PIC X(44)   VALUE
      **       ALL "−".
      *
       01  WRK-TENSU-AREA.
           03  WRK-KHNTENZ         PIC ZZZZZZZ.
           03  WRK-KAISUZ          PIC ZZZ.
           03  WRK-TENSUZ          PIC ZZZZZZZ.
           03  WRK-JNISSU          PIC ZZ9.
           03  WRK-TOTALTEN        PIC ZZZ,ZZZ.
           03  WRK-NENREI-X        PIC ZZ9.
           03  WRK-KINGAKUZ        PIC ZZZ,ZZZ.
           03  WRK-ZZZ9            PIC ZZZ9.
           03  WRK-SEIKYUZ         PIC Z,ZZZ,ZZ9.
           03  WRK-Z9              PIC Z9.
           03  WRK-ZZ              PIC ZZ.
           03  WRK-ZZZ             PIC ZZZ.
      *
      *    改行コード
       01  WRK-CONS-RETURN          PIC X(01)   VALUE   X"0A".
      *
       01  WRK-BYOMEI-AREA.     
      *    傷病名最大文字数（傷病名欄）
      **   03  WRK-BYOMEI1-MAX     PIC 9(02)   VALUE   44.
           03  WRK-BYOMEI1-MAX     PIC 9(02)   VALUE   50.
      *    傷病名最大文字数（適用欄）
           03  WRK-BYOMEI2-MAX     PIC 9(02)   VALUE   52.
      *     
      *    適用欄最大行数（点数）
      **   03  WRK-TEKIYOU-LINE    PIC 9(02)   VALUE   30.
           03  WRK-TEKIYOU-LINE    PIC 9(02)   VALUE   26.
      *    適用欄最大行数（金額）
      **   03  WRK-TEKIYOU1-LINE   PIC 9(02)   VALUE   9.
           03  WRK-TEKIYOU1-LINE   PIC 9(02)   VALUE   6.
      *     
      *    傷病名欄最大行数
           03  WRK-BYOMEI-LINE     PIC 9(02)   VALUE   3.
      *     
      *    傷病の経過欄最大行数
      **   03  WRK-KEIKA-HC22-LINE PIC 9(02)   VALUE   4.
           03  WRK-KEIKA-HC23-LINE PIC 9(02)   VALUE   0.
      *     
      *    適用欄最大行数（続紙）
      **   03  WRK-TEKIYOU-HC24-LINE
      **                           PIC 9(03)   VALUE   118.
           03  WRK-TEKIYOU-HC29-LINE
                                   PIC 9(03)   VALUE   110.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK2005.INC".
      *
           COPY    "CPSK4001.INC".
      *
      *    医療機関情報
           COPY    "CPSK1001.INC".
           COPY    "CPSK1002.INC".
      *
           COPY    "CPRCF008.INC".
      *
      *    保険マスタ
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    レセプトコメントマスタ
       01  RECECOM-REC.
           COPY    "CPRECECOM.INC".
      *
      *    レセプト管理     
       01  RECE07-REC. 
           COPY    "CPRCF007.INC".
      *
      *    患者情報
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
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL       SPA-STS     =   2
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  SPA-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SYS-1001-REC
           INITIALIZE                  SYS-1002-REC
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0485"      TO  JOB-PGID
           MOVE    "自賠責保険・印刷データ編集（自賠責）"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
      *    ファイルＯＰＥＮ処理
           MOVE    "RECE410"           TO  RECE41PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE41PARA-TERMID
      *
           MOVE    "RECE430"           TO  RECE43PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE43PARA-TERMID
      *
           MOVE    "RECE470"           TO  RECE47PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE47PARA-TERMID
      *
           MOVE    "RECE471"           TO  RECE471PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE471PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
      ***  MOVE    "RECEYMD"           TO  RECEYMD-FILE-ID
      ***  MOVE    WRK-PARA-TERMID     TO  RECEYMD-TERMID
      *
           OPEN    INPUT               RECE41-FILE
      *
           OPEN    INPUT               RECE43-FILE
      *
           OPEN    INPUT               RECE47-FILE
      *
           OPEN    INPUT               RECE471-FILE
      *   
      ***  OPEN    OUTPUT              RECEYMD-FILE     
      *
      *    システム管理マスタ（医療機関情報）
           PERFORM 120-HOSPINF-GET-SEC
      *
           MOVE    ZERO                TO  WRK-RECENUM
      *
           IF      SPA-STS             =   ZERO
              PERFORM 990-RECE41-READ-SEC
           END-IF
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療機関情報検索
      *****************************************************************
       120-HOSPINF-GET-SEC            SECTION.
      *
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
           ACCEPT  SYS-TIME            FROM    TIME
      *
      **   MOVE    WRK-SYSYMD       TO  RECEYMD-CREYMD
      **   MOVE    SYS-TIME (1:6)   TO  RECEYMD-CREHMS
      *          
      *
      *    医療機関情報
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "1001"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           PERFORM 960-KANRIMST-READ-SEC
           IF      FLG-SYSKANRI     =   ZERO
               MOVE    MCPDATA-REC   TO  SYS-1001-REC
           ELSE    
               MOVE    "医療機関情報が取得できませんでした。"
                                     TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    2               TO  SPA-STS
               GO  TO  120-HOSPINF-GET-EXT
           END-IF    
      *    医療機関情報（所在地ほか）
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "1002"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           PERFORM 960-KANRIMST-READ-SEC
           IF      FLG-SYSKANRI     =   ZERO
               MOVE    MCPDATA-REC      TO  SYS-1002-REC
           ELSE    
               MOVE    "医療機関情報（所在地）が取得できませんでした。"
                                        TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    2               TO  SPA-STS
               GO  TO  120-HOSPINF-GET-EXT
           END-IF    
      *    労災医療機関情報
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "4001"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           PERFORM 960-KANRIMST-READ-SEC
           IF      FLG-SYSKANRI     =   ZERO
               MOVE    MCPDATA-REC      TO  SYS-4001-REC
               IF      SYS-4001-RSIIRYOCDN  =   LOW-VALUE
                   MOVE    SPACE                TO  SYS-4001-RSIIRYOCDN
               END-IF     
           ELSE    
               MOVE    "労災自賠医療機関情報が取得できませんでした。"
                                        TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    2               TO  SPA-STS
               GO  TO  120-HOSPINF-GET-EXT
           END-IF    
           .
       120-HOSPINF-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM         UNTIL   FLG-RECE41     =   1
                           OR      SPA-STS        =   2 
      *
      *        患者情報読込処理      
               PERFORM 2001-PTINF-HEN-SEC 
      *            レセプト種別別件数カウント
               MOVE    ZERO            TO  CNT-KENSU
               MOVE    KEY-NEW         TO  KEY-OLD
               PERFORM         UNTIL   FLG-RECE41     =   1
                               OR      SPA-STS        =   2
                               OR      KEY-NEW    NOT =   KEY-OLD
      *
                   ADD     1                      TO  CNT-KENSU
      *                                      
                   PERFORM 2001-SYORI-SEC
      *
                   PERFORM 990-RECE41-READ-SEC
               END-PERFORM
           END-PERFORM
      *
           MOVE    2               TO  SPA-STS
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *        患者情報読込処理      
      *****************************************************************
        2001-PTINF-HEN-SEC       SECTION.
      *     
      *    診療年月編集
           MOVE    RECE41-SRYYM        TO  WRK-STYMD (1:6)
           MOVE    "01"                TO  WRK-STYMD (7:2)
           MOVE    WRK-STYMD           TO  WRK-SYMD
           PERFORM 31012-SE-WA-YMDEDIT-SEC
           MOVE    WRK-HENYMD          TO  WRK-STYMDW
      *     
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY7-AREA
           MOVE    "71"                TO  LNK-DAY7-IRAI
           MOVE    RECE41-SRYYM        TO  LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-EDYMD 
           MOVE    WRK-EDYMD           TO  WRK-SYMD
           PERFORM 31012-SE-WA-YMDEDIT-SEC
           MOVE    WRK-HENYMD          TO  WRK-EDYMDW
           . 
        2001-PTINF-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       2001-SYORI-SEC                SECTION.
      *
           MOVE    1         TO  CNT-PAGE
           INITIALIZE                  WRK-EDIT-AREA
      *
      *    帳票編集<ヘッダー部>処理
           PERFORM 310-HC101-HEAD-HEN-SEC
      *
      *    帳票編集<点数>処理
           PERFORM 330-HC101-TENSU-HEN-SEC
      *
      *    帳票編集<傷病名>処理
           PERFORM 320-HC101-BYOMEI-HEN-SEC
      *
      *    帳票編集<適用（点数）>処理
           PERFORM 340-HC101-ZAI-HEN-SEC
      *
      *    帳票編集<傷病の経過>処理
           PERFORM 360-HC101-COMMENT-HEN-SEC 
      *
      *    帳票編集<適用（金額）>処理
           PERFORM 350-HC101-ZAI-HEN1-SEC
      *
      *    帳票印刷処理（続紙）
           IF      CNT-PAGE           >   1
               PERFORM 390-PRINT-OUT-SEC
           END-IF    
      *
      *    帳票印刷処理
           IF      SPA-STS            =   ZERO
               MOVE    1                  TO  CNT-PAGE
               PERFORM 390-PRINT-OUT-SEC
           END-IF    
      *
           .
       2001-SYORI-EXT.
           EXIT.
      *     
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       310-HC101-HEAD-HEN-SEC          SECTION.
      *
           MOVE    WRK-TEKIYOU-LINE    TO  WRK-LINE-MAX
      *     
           INITIALIZE                      HC23
      *
      *    対象診療年月
           MOVE     WRK-STYMDW(1:2)    TO  HC23-HAKKOUYY
           MOVE     WRK-STYMDW(3:2)    TO  HC23-HAKKOUMM 
      *    患者番号
           STRING   RECE41-PTNUM   DELIMITED   BY  SPACE
                    " "            DELIMITED   BY  SIZE
                    RECE41-RECEKA  DELIMITED   BY  SPACE
                                   INTO    HC23-PTNUM         
      *    カナ氏名
           MOVE    RECE41-KANANAME     TO  HC23-KANANAME
      *    氏名
           MOVE    RECE41-NAME         TO  HC23-NAME
      *    生年月日
           MOVE    RECE41-BIRTHDAY     TO  WRK-SYMD
           PERFORM 31012-SE-WA-YMDEDIT-SEC
           EVALUATE    WRK-HENGENGO
               WHEN    "M"
                   MOVE    "○"        TO  HC23-TANJYOG(1)
               WHEN    "T"
                   MOVE    "○"        TO  HC23-TANJYOG(2)
               WHEN    "S"
                   MOVE    "○"        TO  HC23-TANJYOG(3)
               WHEN    "H"
                   MOVE    "○"        TO  HC23-TANJYOG(4)
           END-EVALUATE     
           MOVE    WRK-HENYY           TO  HC23-TANJYOYY
      *    性別
           EVALUATE    RECE41-SEX
               WHEN    "1"
                   MOVE    "○"        TO  HC23-SEX(1)
               WHEN    "2"
                   MOVE    "○"        TO  HC23-SEX(2)
           END-EVALUATE     
      *    年齢
           MOVE    RECE41-BIRTHDAY     TO  WRK-BIRTHDAY    
           COMPUTE WRK-NENREI          =   RECE41-SRYYM
                                       -   WRK-BIRTHYM
           MOVE    WRK-NENREI-R1       TO  WRK-NENREI-X
           MOVE    WRK-NENREI-X        TO  HC23-NENREI 
      *    傷病年月日
           MOVE    RECE41-SHOBYOYMD    TO  WRK-SYMD
           PERFORM 31012-SE-WA-YMDEDIT-SEC
           MOVE    WRK-HENYY           TO  HC23-JYUSYOUBIYY
           MOVE    WRK-HENMM           TO  HC23-JYUSYOUBIMM
           MOVE    WRK-HENDD           TO  HC23-JYUSYOUBIDD
      *    初診年月日
           MOVE    RECE41-SHOSHINYMD   TO  WRK-SYMD
           PERFORM 31012-SE-WA-YMDEDIT-SEC
           MOVE    WRK-HENYY           TO  HC23-SYOSHINBIYY
           MOVE    WRK-HENMM           TO  HC23-SYOSHINBIMM
           MOVE    WRK-HENDD           TO  HC23-SYOSHINBIDD
      *    療養開始年月日
           IF      RECE41-RYOSTYMD     <   WRK-STYMD
               MOVE    WRK-STYMDW(1:2)     TO  HC23-STRYY
               MOVE    WRK-STYMDW(3:2)     TO  HC23-STRMM
               MOVE    WRK-STYMDW(5:2)     TO  HC23-STRDD
           ELSE      
               MOVE    RECE41-RYOSTYMD     TO  WRK-SYMD
               PERFORM 31012-SE-WA-YMDEDIT-SEC
               MOVE    WRK-HENYY           TO  HC23-STRYY
               MOVE    WRK-HENMM           TO  HC23-STRMM
               MOVE    WRK-HENDD           TO  HC23-STRDD
           END-IF    
      *    療養終了年月日
           IF      RECE41-RYOEDYMD     >   WRK-EDYMD
               MOVE    WRK-EDYMDW(1:2)     TO  HC23-ENDYY 
               MOVE    WRK-EDYMDW(3:2)     TO  HC23-ENDMM
               MOVE    WRK-EDYMDW(5:2)     TO  HC23-ENDDD
           ELSE      
               MOVE    RECE41-RYOEDYMD     TO  WRK-SYMD
               PERFORM 31012-SE-WA-YMDEDIT-SEC
               MOVE    WRK-HENYY           TO  HC23-ENDYY
               MOVE    WRK-HENMM           TO  HC23-ENDMM
               MOVE    WRK-HENDD           TO  HC23-ENDDD
           END-IF    
      *    実日数
           MOVE    RECE41-JNISSU       TO  WRK-JNISSU
           MOVE    WRK-JNISSU          TO  HC23-JITSUNISSU
      *    転帰事由
           EVALUATE    RECE41-TENKI
               WHEN    "1"
                   MOVE    "○"        TO  HC23-TENKI(1)
               WHEN    "3"
                   MOVE    "○"        TO  HC23-TENKI(2)
               WHEN    "5"
                   MOVE    "○"        TO  HC23-TENKI(3)
               WHEN    "7"
                   MOVE    "○"        TO  HC23-TENKI(4)
               WHEN    "9"
                   MOVE    "○"        TO  HC23-TENKI(5)
           END-EVALUATE    
      *    加算率
           MOVE    RECE41-KSNRATE(2:2) TO  HC23-SEIKYU(1)
                                           HC23-SEIKYU(2)
      *    請求額Ａ
           MOVE    RECE41-TOTALKIN       TO  WRK-SEIKYUZ
           MOVE    WRK-SEIKYUZ           TO  HC23-SEIKYUGAKU(1)
      *    請求額Ｂ
           MOVE    RECE41-TOTALKIN-YAK   TO  WRK-SEIKYUZ
           MOVE    WRK-SEIKYUZ           TO  HC23-SEIKYUGAKU(2) 
      *    請求額Ｃ
           MOVE    RECE41-TOTALKIN2      TO  WRK-SEIKYUZ
           MOVE    WRK-SEIKYUZ           TO  HC23-SEIKYUGAKU(3) 
      *    請求額Ｄ
           MOVE    RECE41-TOTALKIN2-ETC  TO  WRK-SEIKYUZ
           MOVE    WRK-SEIKYUZ           TO  HC23-SEIKYUGAKU(4)
      *    請求額計
           COMPUTE WRK-GOKEI   =    RECE41-TOTALKIN
                               +    RECE41-TOTALKIN-YAK
                               +    RECE41-TOTALKIN2
                               +    RECE41-TOTALKIN2-ETC

           MOVE    WRK-GOKEI             TO  WRK-SEIKYUZ
           MOVE    WRK-SEIKYUZ           TO  HC23-SEIKYUGAKU(5)
      *    通院月
           MOVE    WRK-STYMDW(3:2)     TO  HC23-TSUINMM(1) 
      *    通院日
           PERFORM    VARYING    IDZ    FROM    1   BY   1              
                          UNTIL      IDZ    >     31                    
                 IF    RECE41-TUUIN-DAY(IDZ)                         
                                        NOT =  SPACE                    
                        MOVE    "○"    TO  HC23-TSUIN(1 IDZ)
                 END-IF                                              
           END-PERFORM
      *    通院日数                                         
           MOVE    RECE41-TUUIN-KEI     TO  WRK-Z9
           MOVE    WRK-Z9               TO  HC23-TSUINSUU(1)
      *    請求額
           COMPUTE WRK-GOKEI   =    RECE41-TOTALKIN
                               +    RECE41-TOTALKIN-YAK
                               +    RECE41-TOTALKIN2
                               +    RECE41-TOTALKIN2-ETC
           MOVE    WRK-GOKEI             TO  WRK-SEIKYUZ
           MOVE    WRK-SEIKYUZ           TO  HC23-SEIKYUGAKUTOTAL
      *    所在地
           MOVE    SYS-1002-ADRS       TO  HC23-HOSPJYUSYO
      *    名称
           MOVE    SYS-1001-HOSPNAME   TO  HC23-HOSPNAME
      *    管理者
           MOVE    SYS-1001-KANRINAME  TO  HC23-ISYA
      *    電話番号
           MOVE    SYS-1002-TEL        TO  HC23-TEL
      *    病床数
           MOVE    SYS-1001-BEDSU      TO  WRK-ZZZ9
           MOVE    WRK-ZZZ9            TO  HC23-BYOSYOSU
      *    
           .
       310-HC101-HEAD-HEN-EXT.
           EXIT.
      *     
      *****************************************************************
      *    帳票編集<続紙ヘッダー部>処理
      *****************************************************************
       310-HC29-HEAD-HEN-SEC          SECTION.
      *
           MOVE    WRK-TEKIYOU-HC29-LINE    TO  WRK-LINE-MAX
      *
           INITIALIZE                 HC29
      *      
      *    カナ氏名
           MOVE    RECE41-KANANAME     TO  HC29-KANANAME
      *    氏名
           MOVE    RECE41-NAME         TO  HC29-NAME
      *    患者番号
           STRING   RECE41-PTNUM   DELIMITED   BY  SPACE
                    " "            DELIMITED   BY  SIZE
                    RECE41-RECEKA  DELIMITED   BY  SPACE
                    "-"            DELIMITED   BY  SIZE
                    CNT-PAGE (3:1) DELIMITED   BY  SIZE
                                   INTO    HC29-PTNUM         
      *
           .
       310-HC29-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<傷病名>処理
      *****************************************************************
       320-HC101-BYOMEI-HEN-SEC      SECTION.
      *     
           MOVE    SPACE               TO  WRK-BYOMEI1
                                           WRK-BYOMEI2
      *
      *    傷病の部位編集
      **     IF      RECE41-COMMENT      =   SPACE
      **         CONTINUE
      **     ELSE
      **         ADD     1               TO  WRK-LINEBYO
      **         MOVE    RECE41-COMMENT  TO  HC23-SYOBYO (WRK-LINEBYO)
      **         IF      RECE41-COMMENT (51:)    NOT =   SPACE
      **             ADD     1           TO  WRK-LINEBYO
      **             MOVE    RECE41-COMMENT (51:50)
      **                                 TO  HC23-SYOBYO (WRK-LINEBYO)
      **         END-IF                        
      **         IF      RECE41-COMMENT (100:)    NOT =   SPACE
      **             ADD     1           TO  WRK-LINEBYO
      **             MOVE    RECE41-COMMENT (100:)
      **                                 TO  HC23-SYOBYO (WRK-LINEBYO)
      **         END-IF                        
      **     END-IF
      *
      *    傷病名の編集                    
           INITIALIZE                      RECE43-REC
           MOVE    RECE41-HOSPID       TO  RECE43-HOSPID
           MOVE    RECE41-SRYYM        TO  RECE43-SRYYM
           MOVE    RECE41-NYUGAIKBN    TO  RECE43-NYUGAIKBN
           MOVE    RECE41-PTID         TO  RECE43-PTID
           MOVE    RECE41-RECEKA       TO  RECE43-RECEKA
           MOVE    RECE41-HKNID        TO  RECE43-HKNID
           MOVE    RECE41-TEKSTYMD     TO  RECE43-TEKSTYMD
      *
           START   RECE43-FILE
               KEY IS    >=   RECE43-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE43
               NOT INVALID
                   PERFORM 990-RECE43-NEXT-SEC
           END-START
      *
           PERFORM
               UNTIL  ( FLG-RECE43          =   1                 )
               OR     ( RECE41-HOSPID    NOT =   RECE43-HOSPID    )
               OR     ( RECE41-SRYYM     NOT =   RECE43-SRYYM     )
               OR     ( RECE41-NYUGAIKBN NOT =   RECE43-NYUGAIKBN )
               OR     ( RECE41-PTID      NOT =   RECE43-PTID      )
               OR     ( RECE41-RECEKA    NOT =   RECE43-RECEKA    )
               OR     ( RECE41-HKNID     NOT =   RECE43-HKNID     )
               OR     ( RECE41-TEKSTYMD  NOT =   RECE43-TEKSTYMD  )
      *        病名編集処理
               PERFORM 3210-BYOMEI-SET-SEC
      *
           END-PERFORM
      *
           MOVE    1               TO  FLG-RECE43     
      *
           IF  WRK-LINEBYO      <  WRK-BYOMEI-LINE
               IF  WRK-BYOMEI1-NAME  NOT =   SPACE
                   PERFORM 3221-BYOMEI1-OUT-SEC
               END-IF
           ELSE
               IF  WRK-BYOMEI2-NAME  NOT =   SPACE
                   PERFORM 3222-BYOMEI2-OUT-SEC
               END-IF
           END-IF
      *
           .
       320-HC101-BYOMEI-HEN-EXT.
           EXIT.
      ****************************************************************
      *     病名編集処理
      ****************************************************************
       3210-BYOMEI-SET-SEC           SECTION.
      *
      *    病名をつなげると何桁になるかを計算（，＋病名）
           IF  WRK-CLM           =   ZERO
               MOVE    WRK-CLM   TO  WRK-WCLM
           ELSE
               COMPUTE WRK-WCLM  =   WRK-CLM   +   2
           END-IF
           COMPUTE     WRK-WCLM  =
                      ( RECE43-BYOMEIMOJI  *   2 )  +   WRK-WCLM
      *
           EVALUATE    TRUE
      *        傷病名欄に編集
               WHEN    WRK-LINEBYO     <   WRK-BYOMEI-LINE
                   IF  WRK-WCLM          >   WRK-BYOMEI1-MAX
                       IF  WRK-BYOMEI1  NOT =  SPACE
                           PERFORM 3221-BYOMEI1-OUT-SEC
                       END-IF
                   ELSE
                       IF  WRK-CLM       >   ZERO
      *                    前の病名の直後に編集
                           COMPUTE WRK-STCLM =   WRK-CLM   +    1
                           MOVE    "，"  TO  WRK-BYOMEI1-NAME
                                                           (WRK-STCLM:)
                           COMPUTE WRK-CLM   =   WRK-CLM   +   2
                       END-IF
                   END-IF
      *        適用欄に編集
               WHEN    WRK-LINEBYO     >=  WRK-BYOMEI-LINE
                   IF  WRK-WCLM          >   WRK-BYOMEI2-MAX
                       PERFORM 3222-BYOMEI2-OUT-SEC
                   ELSE
                       IF  WRK-CLM       >   ZERO
      *                    前の病名の直後に編集
                           COMPUTE WRK-STCLM =   WRK-CLM   +   1
                           MOVE    "，"  TO  WRK-BYOMEI2-NAME
                                                       (WRK-STCLM:)
                           COMPUTE WRK-CLM   =   WRK-CLM   +   2
                       END-IF
                   END-IF
           END-EVALUATE
      *
      *    対象病名を編集
           COMPUTE     WRK-STCLM       =   WRK-CLM   +   1
      *     
      *    単病名文字数を計算
           COMPUTE WRK-MOJISU          =   RECE43-BYOMEIMOJI   *   2
      *     
           EVALUATE    TRUE
      *        傷病名欄に編集
               WHEN    WRK-LINEBYO     <   WRK-BYOMEI-LINE
                   MOVE    RECE43-BYOMEI   TO  WRK-BYOMEI1-NAME
                                                          (WRK-STCLM:)
                   IF      WRK-MOJISU       >   WRK-BYOMEI1-MAX
                       PERFORM 3221-BYOMEI1-OUT-SEC
                       IF      WRK-LINEBYO     <   WRK-BYOMEI-LINE 
                           MOVE    RECE43-BYOMEI(51:)
                                                   TO  WRK-BYOMEI1-NAME
                                                          (WRK-STCLM:)
                       ELSE
                           MOVE    RECE43-BYOMEI(51:)
                                                   TO  WRK-BYOMEI2-NAME
                                                          (WRK-STCLM:)
                       END-IF                                   
                   END-IF    
      *        適用欄に編集
               WHEN    WRK-LINEBYO     >=  WRK-BYOMEI-LINE
                   MOVE    RECE43-BYOMEI   TO  WRK-BYOMEI2-NAME
                                                          (WRK-STCLM:)
                   IF      WRK-MOJISU       >   WRK-BYOMEI2-MAX 
                       PERFORM  3222-BYOMEI2-OUT-SEC
                       MOVE    RECE43-BYOMEI(53:)
                                               TO  WRK-BYOMEI2-NAME
                                                          (WRK-STCLM:)
                   END-IF                                       
           END-EVALUATE
      *
           COMPUTE     WRK-CLM           =   WRK-MOJISU
                                         +   WRK-CLM
      *
           PERFORM 990-RECE43-NEXT-SEC
      *
           .
       3210-BYOMEI-SET-EXT.
           EXIT.
      *
      ****************************************************************
      *     傷病名欄出力処理
      ****************************************************************
       3221-BYOMEI1-OUT-SEC        SECTION.
      *
           ADD     1               TO  WRK-LINEBYO
      *
           MOVE    WRK-BYOMEI1     TO  HC23-SYOBYO (WRK-LINEBYO)
      *
      *    クリア
           MOVE    SPACE           TO  WRK-BYOMEI1
           MOVE    ZERO            TO  WRK-CLM
      *
           .
       3221-BYOMEI1-OUT-EXT.
           EXIT.
      ****************************************************************
      *     傷病名 適用欄出力処理
      ****************************************************************
       3222-BYOMEI2-OUT-SEC        SECTION.
      *
      *    適用欄の行カウント
           IF      WRK-LINETEK     >=   WRK-LINE-MAX
               PERFORM 34120-PAGE-SEC
           END-IF    
      *     
           ADD     1               TO  WRK-LINETEK
      *
           INSPECT WRK-BYOMEI2
                           REPLACING    ALL   "  "   BY   "　"
      *
           IF      CNT-PAGE        =   1
               MOVE    WRK-BYOMEI2     TO  HC23-TEKIYO2 (WRK-LINETEK)
           ELSE
               MOVE    WRK-BYOMEI2     TO  HC29-TEKIYO  (WRK-LINETEK)
           END-IF    
      *
      *    クリア
           MOVE    SPACE           TO  WRK-BYOMEI2
           MOVE    ZERO            TO  WRK-CLM
      *
           .
       3222-BYOMEI2-OUT-EXT.
           EXIT.
      *     
      *****************************************************************
      *    帳票編集<適用（金額）>処理
      *****************************************************************
       350-HC101-ZAI-HEN1-SEC      SECTION.
      *
           MOVE    ZERO                TO  CNT-RECE471
                                           WRK-LINETEK1
      *
      * 
           INITIALIZE                      RECE471-REC
           MOVE    RECE41-HOSPID       TO  RECE471-HOSPID
           MOVE    RECE41-SRYYM        TO  RECE471-SRYYM
           MOVE    RECE41-NYUGAIKBN    TO  RECE471-NYUGAIKBN
           MOVE    RECE41-PTID         TO  RECE471-PTID
           MOVE    RECE41-RECEKA       TO  RECE471-RECEKA
           MOVE    RECE41-HKNID        TO  RECE471-HKNID
           MOVE    RECE41-TEKSTYMD     TO  RECE471-TEKSTYMD
      *
           START   RECE471-FILE
               KEY IS    >=   RECE471-KEY
               INVALID
                   MOVE    1            TO  FLG-RECE471
               NOT INVALID
                   PERFORM 990-RECE471-NEXT-SEC
           END-START
      *
           PERFORM UNTIL ( FLG-RECE471          =   1                )
                   OR    ( RECE41-HOSPID   NOT =   RECE471-HOSPID    )
                   OR    ( RECE41-SRYYM    NOT =   RECE471-SRYYM     )
                   OR    ( RECE41-NYUGAIKBN
                                           NOT =   RECE471-NYUGAIKBN )
                   OR    ( RECE41-PTID     NOT =   RECE471-PTID      )
                   OR    ( RECE41-RECEKA   NOT =   RECE471-RECEKA    )
                   OR    ( RECE41-HKNID    NOT =   RECE471-HKNID     )
                   OR    ( RECE41-TEKSTYMD NOT =   RECE471-TEKSTYMD  )
      *
      *        明細
               INSPECT RECE471-TEKIYO-INF
                               REPLACING    ALL   "  "   BY   "　"
      *                         
               EVALUATE    TRUE        
                   WHEN    WRK-LINETEK1        <   WRK-TEKIYOU1-LINE
                       ADD     1                   TO  WRK-LINETEK1
                       MOVE    RECE471-TEKIYO-INF  TO  HC23-TEKIYO1
                                                       (WRK-LINETEK1)
                   WHEN    WRK-LINETEK1        =   WRK-TEKIYOU1-LINE
                       IF      WRK-LINETEK         >   ZERO
                           IF      WRK-LINETEK         >=   WRK-LINE-MAX
                               PERFORM 34120-PAGE-SEC
                           END-IF    
                           ADD     1           TO  WRK-LINETEK
                                                   WRK-LINETEK1
                           IF      CNT-PAGE        =   1 
                               MOVE    WRK-KUGIRI2     TO 
                                               HC23-TEKIYO2(WRK-LINETEK)
                           ELSE
                               MOVE    WRK-KUGIRI2     TO 
                                               HC29-TEKIYO (WRK-LINETEK)
                           END-IF
                       END-IF
                       ADD     1                   TO  WRK-LINETEK
                       IF      WRK-LINETEK          >=   WRK-LINE-MAX
                           PERFORM 34120-PAGE-SEC
                       END-IF    
                       IF      CNT-PAGE        =   1 
                           MOVE    RECE471-TEKIYO-INF  TO
                                               HC23-TEKIYO2(WRK-LINETEK)
                       ELSE
                           MOVE    RECE471-TEKIYO-INF  TO
                                               HC29-TEKIYO (WRK-LINETEK)
                       END-IF
                   WHEN    WRK-LINETEK1        >   WRK-TEKIYOU1-LINE
                       IF      WRK-LINETEK     >=  WRK-LINE-MAX
                           PERFORM 34120-PAGE-SEC
                       END-IF
                       ADD     1                   TO  WRK-LINETEK
                       IF      CNT-PAGE        =   1 
                           MOVE    RECE471-TEKIYO-INF  TO
                                               HC23-TEKIYO2(WRK-LINETEK)
                       ELSE
                           MOVE    RECE471-TEKIYO-INF  TO
                                               HC29-TEKIYO (WRK-LINETEK)
                       END-IF
               END-EVALUATE        
      *
               PERFORM 990-RECE471-NEXT-SEC
           END-PERFORM
      *
           .
       350-HC101-ZAI-HEN1-EXT.
           EXIT.
      *     
      *****************************************************************
      *    帳票編集<点数>処理
      *****************************************************************
       330-HC101-TENSU-HEN-SEC      SECTION.
      *
      *    診療内容・点数（点）
      *
      *    初診                           
           EVALUATE    RECE41-SHOSHINTIME
               WHEN    "1"
                   MOVE  "○"       TO  HC23-SYOSHIN(1)
               WHEN    "2"
                   MOVE  "○"       TO  HC23-SYOSHIN(2)
               WHEN    "3"
                   MOVE  "○"       TO  HC23-SYOSHIN(3)
           END-EVALUATE
      *    乳幼児
           IF          RECE41-SHOSHIN-NYU  =   "1"
                   MOVE  "○"       TO  HC23-SYOSHIN(4)
           END-IF
      *
           PERFORM   VARYING   IDX   FROM    2   BY  1
                     UNTIL     IDX       >   33
      *
               COMPUTE     IDZ  =    IDX   -   1
      * 
      *        <単価>
               EVALUATE    IDX
      *            投薬
                   WHEN    10
                   WHEN    13
                   WHEN    14
                       MOVE    RECE41-KHNTEN(IDX) TO  WRK-KHNTENZ
                       MOVE    WRK-KHNTENZ        TO  HC23-KHNTEN  (IDZ)
               END-EVALUATE
      *        <回数>
               MOVE    RECE41-KAISU(IDX)          TO  WRK-KAISUZ
               MOVE    WRK-KAISUZ                 TO  HC23-KAISU   (IDZ)
           END-PERFORM
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL     IDX       >   33
      *        <手技点数>
               MOVE    RECE41-TENSU(IDX)          TO  WRK-TENSUZ
               MOVE    WRK-TENSUZ                 TO  HC23-KOUTEN  (IDX)
      *        <薬剤等点数>
               MOVE    RECE41-TENSU-YAK(IDX)      TO  WRK-TENSUZ
               MOVE    WRK-TENSUZ                 TO  HC23-YKZTENSU(IDX)
           END-PERFORM
      *
      *    手技点数計
           MOVE    RECE41-TOTALTEN        TO  WRK-TOTALTEN
           MOVE    WRK-TOTALTEN           TO  HC23-KOUTENG
      *    薬剤等点数計
           MOVE    RECE41-TOTALTEN-YAK    TO  WRK-TOTALTEN
           MOVE    WRK-TOTALTEN           TO  HC23-YKZTENSUG
      *
      *    診療内容・金額                     
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL     IDX       >   6
      *        <金額>
               MOVE    RECE41-KINGAKU2(IDX)      TO  WRK-KINGAKUZ
               MOVE    WRK-KINGAKUZ              TO  HC23-KINGAKU (IDX)
           END-PERFORM
      *     
      *    <再診回数>
           MOVE    RECE41-KAISU2 (2)         TO  WRK-ZZ
           MOVE    WRK-ZZ                    TO  HC23-SAISINKAISU
      *     
      *    <指導回数>
           MOVE    RECE41-KAISU2 (3)         TO  WRK-ZZ
           MOVE    WRK-ZZ                    TO  HC23-SHIDOKAISU
      *
      *    診断書料
           MOVE    RECE41-SINDAN-TUU         TO  WRK-ZZZ
           MOVE    WRK-ZZZ                   TO  HC23-SHINDANSYOSUU
      *    診断書金額
           MOVE    RECE41-SINDAN-KIN         TO  WRK-KINGAKUZ
           MOVE    WRK-KINGAKUZ              TO  HC23-SHINDANSYOMONEY
      *    明細書料
           MOVE    RECE41-MEISAI-TUU         TO  WRK-ZZZ
           MOVE    WRK-ZZZ                   TO  HC23-MEISAISYOSUU
      *    明細書金額
           MOVE    RECE41-MEISAI-KIN         TO  WRK-KINGAKUZ
           MOVE    WRK-KINGAKUZ              TO  HC23-MEISAISYOMONEY
      *
           .
       330-HC101-TENSU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<剤>処理
      *****************************************************************
       340-HC101-ZAI-HEN-SEC      SECTION.
      *
      *    摘要欄に既に印刷されている場合、１行あける
           IF  WRK-LINETEK             >   ZERO
      *
               IF  WRK-LINETEK          >=   WRK-LINE-MAX
                   PERFORM 34120-PAGE-SEC
               END-IF    
               ADD     1               TO  WRK-LINETEK
               IF      CNT-PAGE        =   1   
                   MOVE    WRK-KUGIRI1 TO  HC23-TEKIYO2 (WRK-LINETEK)
               ELSE   
                   MOVE    WRK-KUGIRI1 TO  HC29-TEKIYO  (WRK-LINETEK)
               END-IF    
           END-IF
      *
           MOVE    ZERO                TO  WRK-R061-ZAINUM-O
           MOVE    SPACE               TO  WRK-R061-SRYKBN-O
           MOVE    ZERO                TO  CNT-RECE47
      *
      *    パラメータ０６ファイルより編集
           INITIALIZE                      RECE47-REC
           MOVE    RECE41-HOSPID       TO  RECE47-HOSPID
           MOVE    RECE41-SRYYM        TO  RECE47-SRYYM
           MOVE    RECE41-NYUGAIKBN    TO  RECE47-NYUGAIKBN
           MOVE    RECE41-PTID         TO  RECE47-PTID
           MOVE    RECE41-RECEKA       TO  RECE47-RECEKA
           MOVE    RECE41-HKNID        TO  RECE47-HKNID
           MOVE    RECE41-TEKSTYMD     TO  RECE47-TEKSTYMD
      *
           START   RECE47-FILE
               KEY IS    >=   RECE47-KEY
               INVALID
                   MOVE    1            TO  FLG-RECE47
               NOT INVALID
                   PERFORM 990-RECE47-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE47           =   1                  )
               OR     ( RECE41-HOSPID    NOT =   RECE47-HOSPID      )
               OR     ( RECE41-SRYYM     NOT =   RECE47-SRYYM       )
               OR     ( RECE41-NYUGAIKBN NOT =   RECE47-NYUGAIKBN   )
               OR     ( RECE41-PTID      NOT =   RECE47-PTID        )
               OR     ( RECE41-RECEKA    NOT =   RECE47-RECEKA      )
               OR     ( RECE41-HKNID     NOT =   RECE47-HKNID       )
               OR     ( RECE41-TEKSTYMD  NOT =   RECE47-TEKSTYMD    )
      *
               MOVE    ZERO                  TO  FLG-KUGIRI
               IF  RECE47-ZAINUM        NOT =   WRK-R061-ZAINUM-O
                   MOVE    ZERO              TO  CNT-ZAIMEISAISU
               END-IF
               ADD     1                     TO  CNT-ZAIMEISAISU
      *
      *        レセプト０６ファイル編集処理
               PERFORM 3410-RECE47-HENSYU-SEC
      *
               MOVE    RECE47-ZAINUM        TO  WRK-R061-ZAINUM-O
               MOVE    RECE47-SRYKBN        TO  WRK-R061-SRYKBN-O
      *
               PERFORM 990-RECE47-NEXT-SEC
           END-PERFORM
      *
           .
       340-HC101-ZAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    レセプト０６ファイル編集処理
      *****************************************************************
       3410-RECE47-HENSYU-SEC           SECTION.
      *
           IF  CNT-ZAIMEISAISU           =   1
      *        次の行為明細数を追加すると何行になるか
               COMPUTE   WRK-WLINETEK    =   WRK-LINETEK
                                         +   RECE47-ZAIMEISAISU
               IF  CNT-RECE47           >   1
      *            診療区分が変更している場合、診療区切り線分を追加
                   IF  RECE47-SRYKBN    NOT =   WRK-R061-SRYKBN-O
                       ADD     1             TO  WRK-WLINETEK
                       MOVE    1             TO  FLG-KUGIRI
                   END-IF
               END-IF
      *
               IF  WRK-WLINETEK          >         WRK-LINE-MAX

                   PERFORM 34120-PAGE-SEC
      *
      *            区切り線
                   IF  FLG-KUGIRI        =   2
                       PERFORM 34110-KUGIRI-LINE-SEC
                   END-IF
      *            診療区分
                   ADD     1               TO  WRK-LINETEK
                   IF      CNT-PAGE        =   1
                       MOVE    RECE47-SRYKBN  TO  HC23-SRYKBN
                                                       (WRK-LINETEK)
                   ELSE
                       MOVE    RECE47-SRYKBN  TO  HC29-SRYKBN
                                                       (WRK-LINETEK)
                   END-IF                                    
               ELSE
      *            区切り線
                   IF  FLG-KUGIRI    NOT =   ZERO
                       PERFORM 34110-KUGIRI-LINE-SEC
                   END-IF
      *            診療区分
                   ADD     1             TO  WRK-LINETEK
                   IF  RECE47-SRYKBN    NOT =   WRK-R061-SRYKBN-O
                       IF      CNT-PAGE        =   1
                           MOVE    RECE47-SRYKBN  TO  HC23-SRYKBN
                                                       (WRK-LINETEK)
                       ELSE
                           MOVE    RECE47-SRYKBN  TO  HC29-SRYKBN
                                                       (WRK-LINETEK)
                       END-IF                                    
                   END-IF
               END-IF
           ELSE
               ADD     1                 TO  WRK-LINETEK
           END-IF
      *
      *    明細
           INSPECT RECE47-TEKIYO-INF
                           REPLACING    ALL   "  "   BY   "　"
           IF      CNT-PAGE        =   1
               MOVE    RECE47-TEKIYO-INF  TO  HC23-TEKIYO2(WRK-LINETEK)
           ELSE    
               MOVE    RECE47-TEKIYO-INF  TO  HC29-TEKIYO (WRK-LINETEK)
           END-IF    
      *
           .
       3410-RECE47-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    区切り線　編集処理
      *****************************************************************
       34110-KUGIRI-LINE-SEC       SECTION.
      *
           ADD     1               TO  WRK-LINETEK
      *
           IF      CNT-PAGE        =   1
               MOVE    WRK-KUGIRI1 TO  HC23-TEKIYO2 (WRK-LINETEK)
           ELSE    
               MOVE    WRK-KUGIRI1 TO  HC29-TEKIYO  (WRK-LINETEK)
           END-IF    
      *
           .
       34110-KUGIRI-LINE-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    改ページ処理
      *****************************************************************
       34120-PAGE-SEC       SECTION.
      *
      *    帳票印刷処理
           IF      CNT-PAGE      >   1
               PERFORM 390-PRINT-OUT-SEC
           END-IF    
      * 
      *    帳票編集<ヘッダー部>処理
           ADD     1             TO  CNT-PAGE
           PERFORM 310-HC29-HEAD-HEN-SEC
           MOVE    ZERO          TO  WRK-LINETEK
      *
           .
       34120-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<コメント>処理
      *****************************************************************
       360-HC101-COMMENT-HEN-SEC      SECTION.
      *
           MOVE    ZERO                TO  WRK-RECECOM
      *     
           INITIALIZE                      RECECOM-REC
           MOVE    RECE41-HOSPID       TO  RECECOM-HOSPID
           MOVE    RECE41-SRYYM        TO  RECECOM-SRYYM
           MOVE    RECE41-PTID         TO  RECECOM-PTID
      * 
           MOVE    RECECOM-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "RECECOM-KEY1"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "RECECOM-KEY1"      TO  ORC-DBPATH
               PERFORM 900-RECECOM-READ-SEC
           ELSE
               INITIALIZE                  RECECOM-REC
               MOVE    1               TO  FLG-RECECOM
           END-IF
      *
           PERFORM             UNTIL   FLG-RECECOM   =   1
               IF      RECECOM-HKNCOMBI    =   RECE41-HKNCOMBI
                   PERFORM 3601-COMMENT-HENSYU-SEC                 
               END-IF
      *                 
               PERFORM 900-RECECOM-READ-SEC
           END-PERFORM
      *
           .
       360-HC101-COMMENT-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメントの改行コード削除処理
      *****************************************************************
       3601-COMMENT-HENSYU-SEC    SECTION.
      *                                          
           MOVE    RECECOM-COMMENT TO  WRK-COMM
           MOVE    ZERO            TO  WRK-RECEHEN                      
      *
           PERFORM     UNTIL       WRK-RECEHEN  =   1      
      *
               MOVE    SPACE           TO  WRK-COMMENT-G
                                           WRK-COMM1
               MOVE    ZERO            TO  WRK-COL
      *
               IF      WRK-COMM (1:1)  =   WRK-CONS-RETURN
                   MOVE    WRK-COMM (2:)   TO  WRK-COMM1
               ELSE             
                   INSPECT WRK-COMM    TALLYING    WRK-COL
                                               FOR ALL WRK-CONS-RETURN
                   IF      WRK-COL         >   ZERO
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       400
                           IF      WRK-COMM(IDX:1) =   WRK-CONS-RETURN
                               COMPUTE IDY1     =   IDX     -   1
                               COMPUTE IDY2     =   IDX     +   1   
                               MOVE    WRK-COMM (1:IDY1)
                                                TO  WRK-COMMENT-G
                               MOVE    WRK-COMM (IDY2:)
                                                TO  WRK-COMM1
                               MOVE    400      TO  IDX
                           END-IF
                       END-PERFORM                                                                                  
                   ELSE
                       MOVE    WRK-COMM        TO  WRK-COMMENT-G
                       MOVE    1               TO  WRK-RECEHEN
                   END-IF
      *                                       
                   IF      WRK-COMMENT-G   >   SPACE
      *              傷病の経過欄へ編集   
      **             PERFORM VARYING IDX FROM    1   BY  1
      **                     UNTIL   IDX >       WRK-KEIKA-HC23-LINE
      **                   OR      WRK-COMMENT (IDX)   =   SPACE
      **               MOVE    WRK-COMMENT (IDX)
      **                               TO  HC22-KEIKA (IDX)
      **             END-PERFORM
      *              摘要欄に１行あける
                     COMPUTE IDY     =   WRK-KEIKA-HC23-LINE   +   1
                     IF     WRK-COMMENT (IDY)   NOT =   SPACE
                         IF      WRK-RECECOM         =   ZERO
                           MOVE    1               TO  WRK-RECECOM
                           IF  WRK-LINETEK         >   ZERO
                               IF      WRK-LINETEK >=  WRK-LINE-MAX
                                   PERFORM 34120-PAGE-SEC
                               ELSE
                                   ADD     1           TO  WRK-LINETEK
                                   IF      CNT-PAGE    =   1 
                                       MOVE    WRK-KUGIRI1     TO 
                                               HC23-TEKIYO2(WRK-LINETEK)
                                   ELSE
                                       MOVE    WRK-KUGIRI1     TO 
                                               HC29-TEKIYO (WRK-LINETEK)
                                   END-IF
                               END-IF
                           END-IF    
                       END-IF
      *                 
                       PERFORM VARYING IDX FROM    IDY   BY  1
                               UNTIL   IDX >       8
                               OR      WRK-COMMENT (IDX)   =   SPACE
                           IF      WRK-LINETEK      >=
                                                WRK-LINE-MAX
                               PERFORM 34120-PAGE-SEC
                           END-IF
                           ADD     1               TO  WRK-LINETEK
                           IF      CNT-PAGE    =   1 
                               MOVE    WRK-COMMENT (IDX)
                                           TO  HC23-TEKIYO2(WRK-LINETEK)
                           ELSE
                               MOVE    WRK-COMMENT (IDX)
                                           TO  HC29-TEKIYO (WRK-LINETEK)
                           END-IF                
                     END-PERFORM
                   END-IF  
                 END-IF
               END-IF  
               MOVE    WRK-COMM1       TO  WRK-COMM
           END-PERFORM   
      *
           .
       3601-COMMENT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC                SECTION.
      *
      *    レセプト種別不明のとき続紙は出力しない
           IF      RECE41-RECESYUBETU   =   ZERO
           AND     CNT-PAGE             >   1
               GO  TO  390-PRINT-OUT-EXT
           END-IF
      *
      *         
           MOVE    ZERO                 TO  FLG-ERR
      *
           ADD     1                    TO  WRK-RECENUM
      * 
      *    レセプト明細管理ＤＢ
           PERFORM 3901-RECE08-INSERT-SEC
      *
      *    レセプト帳票管理ファイル出力
           IF      FLG-ERR              =   ZERO
               PERFORM 3903-RECE07-WRITE-SEC
           END-IF
      *
           IF      FLG-ERR              =   1
               MOVE    2                    TO  SPA-STS
           END-IF
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細管理ＤＢ
      *****************************************************************
       3901-RECE08-INSERT-SEC        SECTION.
      *
           INITIALIZE                  RECE08-REC
           MOVE    "HC23"              TO  RECE08-PRTID
           MOVE    WRK-PARA-SRYYM      TO  RECE08-RECEYM
           MOVE    WRK-SYSYMD          TO  RECE08-CREYMD
           MOVE    SYS-TIME (1:6)      TO  RECE08-CREHMS
      ***  MOVE    RECEYMD-CREYMD      TO  RECE08-CREYMD
      ***  MOVE    RECEYMD-CREHMS      TO  RECE08-CREHMS
           MOVE    "0"                 TO  RECE08-PREFKBN
           MOVE    "00"                TO  RECE08-PREFNUM
           MOVE    RECE41-TEKSTYMD     TO  RECE08-TEKSTYMD
           MOVE    "4"                 TO  RECE08-TEISYUTUSAKI
      *****IF      RECE41-PTNUM        =   SPACE
      *         MOVE    ZERO                TO  RECE08-RECESYUBETU
      *     ELSE      
               IF      CNT-PAGE            =   1                                 
                   MOVE    RECE41-RECESYUBETU  TO  RECE08-RECESYUBETU
               ELSE
                   MOVE    RECE41-RECESYUBETU  TO  RECE08-RECESYUBETU
                   MOVE    "2"                 TO  RECE08-RECESYUBETU
                                                                (4:1)
               END-IF                                                         
      *****END-IF    
           MOVE    RECE41-PTNUM        TO  RECE08-PTNUM
           PERFORM VARYING IDX FROM    20  BY  -1
                   UNTIL   IDX <       1
               IF      RECE08-PTNUM (IDX:1)    NOT =   SPACE
                   MOVE    1               TO  IDX 
               ELSE  
                   MOVE    "Z"             TO  RECE08-PTNUM (IDX:1)
               END-IF
           END-PERFORM 
           MOVE    RECE41-SRYYM        TO  RECE08-SRYYM
           MOVE    CNT-PAGE            TO  RECE08-RENNUM
           MOVE    WRK-RECENUM         TO  RECE08-RECENUM
           MOVE    RECE08-REC          TO  MCPDATA-REC
           PERFORM 900-RECE08-READ-SEC
           IF      FLG-RECE08          =   ZERO
               DISPLAY "ORCR0485 MCP-RC=" MCP-RC " " RECE08-KEY 
               STRING   "レセプト明細に更新できません　患者番号＝"
                                               DELIMITED  BY  SIZE
                        RECE41-PTNUM           DELIMITED  BY  SIZE  
                                               INTO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                  TO  FLG-ERR
           ELSE    
               MOVE    RECE41-KANANAME     TO  RECE08-KANANAME
      *********MOVE    WRK-RECENUM         TO  RECE08-RECENUM
               MOVE    "2"                 TO  RECE08-NYUGAIKBN
               MOVE    WRK-PARA-TERMID     TO  RECE08-TERMID
               MOVE    ZERO                TO  RECE08-PRTJYUN
                                               RECE08-PRTRENNUM
               IF      CNT-PAGE            =   1                                 
                   MOVE    HC23                TO  RECE08-PRTDATA
      *************MOVE    "HC23"              TO  RECE08-FORMID
      *************MOVE    "HCM23.red"         TO  RECE08-FORMID
                   MOVE    "HCM23V01.red"      TO  RECE08-FORMID
               ELSE
                   MOVE    HC29                TO  RECE08-PRTDATA
      *************MOVE    "HC29"              TO  RECE08-FORMID
                   MOVE    "HCM29.red"         TO  RECE08-FORMID
               END-IF        
               MOVE    "RECEPRT-KEY"       TO  ORC-DBPATH
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    RECE08-REC          TO  MCPDATA-REC
               CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
               IF      MCP-RC     =   ZERO
                   ADD     1                 TO  CNT-OUT 
               ELSE 
                   DISPLAY "ORCR0485 " MCP-RC " " RECE08-KEY 
                   STRING
                        "レセプト明細に更新できませんでした　患者番号＝"
                                               DELIMITED  BY  SIZE
                        RECE41-PTNUM           DELIMITED  BY  SIZE  
                                               INTO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
                   MOVE    1                  TO  FLG-ERR
               END-IF
           END-IF    
           .
       3901-RECE08-INSERT-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力処理
      *****************************************************************
       3903-RECE07-WRITE-SEC        SECTION.
      *
           INITIALIZE                      RECE07-REC
           MOVE    RECE08-PRTID        TO  RECE07-PRTID
           IF      WRK-PARA-SRYYM      =   ZERO
               MOVE    "2"                 TO  RECE07-SYOKBN
           ELSE
               MOVE    "1"                 TO  RECE07-SYOKBN
           END-IF         
           MOVE    RECE08-RECEYM       TO  RECE07-SRYYM
           MOVE    RECE08-CREYMD       TO  RECE07-CREYMD
           MOVE    RECE08-CREHMS       TO  RECE07-CREHMS
           MOVE    RECE08-TEISYUTUSAKI TO  RECE07-TEISYUTUSAKI
           MOVE    RECE08-RECESYUBETU  TO  RECE07-RECESYUBETU
           MOVE    RECE08-NYUGAIKBN    TO  RECE07-NYUGAIKBN
           MOVE    RECE07-REC          TO  MCPDATA-REC 
           PERFORM 900-RECE07-READ-SEC
           IF      FLG-RECE07          =   1
               INITIALIZE                      RECE07-REC
               MOVE    RECE08-PRTID        TO  RECE07-PRTID
               IF      WRK-PARA-SRYYM      =   ZERO
                   MOVE    "2"                 TO  RECE07-SYOKBN
               ELSE
                   MOVE    "1"                 TO  RECE07-SYOKBN
               END-IF         
               MOVE    RECE08-RECEYM       TO  RECE07-SRYYM
               MOVE    RECE08-CREYMD       TO  RECE07-CREYMD
               MOVE    RECE08-CREHMS       TO  RECE07-CREHMS
               MOVE    RECE08-TEISYUTUSAKI TO  RECE07-TEISYUTUSAKI
               MOVE    RECE08-RECESYUBETU  TO  RECE07-RECESYUBETU
               MOVE    1                   TO  RECE07-PAGE
               MOVE    1                   TO  RECE07-KENSU
               MOVE    WRK-PARA-RECEKBN    TO  RECE07-RECEKBN
               MOVE    RECE08-NYUGAIKBN    TO  RECE07-NYUGAIKBN 
               MOVE    RECE08-TERMID       TO  RECE07-TERMID
           ELSE
               ADD     1                   TO  RECE07-PAGE
               IF      CNT-KENSU           =   1
               AND     CNT-PAGE            =   1
                   ADD     1                   TO  RECE07-KENSU
               END-IF
           END-IF
      *
           MOVE    RECE07-REC          TO  MCPDATA-REC
           MOVE    "RECEKANRI-KEY"     TO  ORC-DBPATH
           IF      FLG-RECE07          =   1    
               MOVE    "DBINSERT"          TO  MCP-FUNC 
           ELSE
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           END-IF 
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC      
      *
           IF      MCP-RC     =   ZERO
               CONTINUE
           ELSE
               DISPLAY "ORCR0485 MCP-RC= "  MCP-RC   
               IF      FLG-RECE07         =   1    
               MOVE    "レセプト管理ＤＢに追加できませんでした"
                                               TO  WRK-RECEERR
               ELSE
               MOVE    "レセプト管理ＤＢに更新できませんでした"
                                               TO  WRK-RECEERR
               END-IF 
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                  TO  FLG-ERR
           END-IF
           .
       3903-RECE07-WRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
      *     MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦→和暦日付編集
      *****************************************************************
       31012-SE-WA-YMDEDIT-SEC        SECTION.
      *
           MOVE    SPACE               TO  STS-AREA-DAY
           INITIALIZE                      STS-AREA-DAY
           MOVE    SPACE               TO  LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"   USING   STS-AREA-DAY  LNK-DAY2-AREA
           IF  STS-DAY-RC1             =   ZERO
               MOVE    LNK-DAY2-EDTYMD1-Y  TO  WRK-HENYY
               MOVE    LNK-DAY2-EDTYMD1-M  TO  WRK-HENMM
               MOVE    LNK-DAY2-EDTYMD1-D  TO  WRK-HENDD
               MOVE    LNK-DAY2-EDTYMD1-G  TO  WRK-HENGENGO 
           ELSE
               MOVE    SPACE               TO  WRK-HENYMDG
           END-IF
           .
       31012-SE-WA-YMDEDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *         
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      ***  MOVE    WRK-RECENUM         TO  RECEYMD-RECENUM
      ***  WRITE   RECEYMD-REC
      *          
      *    ファイルＣＬＯＳＥ処理
           CLOSE                       RECE41-FILE
           CLOSE                       RECE43-FILE
           CLOSE                       RECE47-FILE
           CLOSE                       RECE471-FILE
      ***  CLOSE                       RECEYMD-FILE 
      *
      *****IF      CNT-OUT            =   ZERO 
      *****    MOVE    "対象データがありませんでした" TO  WRK-RECEERR
      *****    PERFORM 500-ERR-HENSYU-SEC
      *****END-IF
           DISPLAY "*** ORCR0485 IN   "  CNT-RECE41
           DISPLAY "*** ORCR0485 RECE471= "  CNT-RECE471
           DISPLAY "*** ORCR0485 OUT  "  CNT-OUT
           DISPLAY "*** ORCR0485 END ***"
      ***     ACCEPT  WRK-IN
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       990-RECE41-READ-SEC           SECTION.
      *
           READ    RECE41-FILE       NEXT
               AT  END
                   MOVE    1                   TO  FLG-RECE41
                   MOVE    HIGH-VALUE          TO  KEY-NEW
               NOT AT  END
                   MOVE    ZERO                TO  FLG-RECE41
                   IF      RECE41-PTNUM        =   SPACE
                   OR      RECE41-HKNKBN       =   "4"
                   OR      RECE41-RECESYUBETU  =    "0000"
                       ADD     1                   TO  CNT-RECE41
                       MOVE    RECE41-HOSPID       TO  KEY-N-HOSPID
                       MOVE    RECE41-SRYYM        TO  KEY-N-SRYYM
                       MOVE    RECE41-NYUGAIKBN    TO  KEY-N-NYUGAIKBN
                       MOVE    RECE41-PTID         TO  KEY-N-PTID
                       MOVE    RECE41-RECEKA       TO  KEY-N-RECEKA
                   ELSE
                       GO  TO  990-RECE41-READ-SEC 
                   END-IF        
           END-READ
      *
           .
       990-RECE41-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０３１データ読み
      ****************************************************************
       990-RECE43-NEXT-SEC           SECTION.
      *
           READ    RECE43-FILE      NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE43
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE43
                   IF      RECE43-TENKIKBN     =   "8"
                       GO  TO  990-RECE43-NEXT-SEC
                   END-IF
           END-READ
      *
           .
       990-RECE43-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０６１データ読み
      ****************************************************************
       990-RECE47-NEXT-SEC           SECTION.
      *
           READ    RECE47-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE47
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE47
                   ADD     1         TO  CNT-RECE47
                   IF      RECE47-SRYKBN    =   "54"
                       MOVE    "50"          TO  RECE47-SRYKBN
                   END-IF    
           END-READ
      *
           .
       990-RECE47-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０６１データ読み
      ****************************************************************
       990-RECE471-NEXT-SEC           SECTION.
      *
           READ    RECE471-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE471
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE471
      *             ADD     1         TO  CNT-RECE471
                   IF      RECE471-SRYKBN    =   "54"
                       MOVE    "50"          TO  RECE471-SRYKBN
                   END-IF    
           END-READ
      *
           .
       990-RECE471-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト管理読込処理
      *****************************************************************
       900-RECE07-READ-SEC           SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "RECEKANRI-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "RECEKANRI-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-RECE07
                   MOVE    MCPDATA-REC         TO  RECE07-REC
               ELSE
                   MOVE    1                   TO  FLG-RECE07
               END-IF
           ELSE
               MOVE    1                   TO  FLG-RECE07
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "RECEKANRI-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-RECE07-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト印刷読込処理
      *****************************************************************
       900-RECE08-READ-SEC           SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "RECEPRT-KEY9"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "RECEPRT-KEY9"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-RECE08
               ELSE
                   MOVE    1                   TO  FLG-RECE08
               END-IF
           ELSE
               MOVE    1                   TO  FLG-RECE08
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "RECEPRT-KEY9"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-RECE08-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       960-KANRIMST-READ-SEC         SECTION.
      * 
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           MOVE    WRK-PARA-SRYYM  TO  ORC-DBYMD (1:6)
           MOVE    "01"            TO  ORC-DBYMD (7:2) 
           CALL    "ORCMCPSUB"     USING
                                   MCPAREA
                                   ORCMCPAREA
                                   MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               MOVE    "DBFETCH"       TO  MCP-FUNC
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF      MCP-RC          =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       960-KANRIMST-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプトコメントマスタ　ＲＥＡＤ
      *****************************************************************
       900-RECECOM-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-RECECOM
               MOVE    MCPDATA-REC     TO  RECECOM-REC
           ELSE
               MOVE    1               TO  FLG-RECECOM
           END-IF
           .
       900-RECECOM-READ-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
