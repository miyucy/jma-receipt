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
       PROGRAM-ID.             ORCR0870.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト入院（労災・自賠責）
      *  コンポーネント名  : 月次業務　労災自賠責明細書ファイル作成
      *                      （レセプトコメント編集） 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/06/01    NACL-門脇　    新規作成
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
           SELECT  RECE82-FILE     ASSIGN  RECE82PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE82-KEY
                                   FILE    STATUS  IS  STS-RECE82.
      *
           SELECT  RECE84-FILE     ASSIGN  RECE84PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE84-KEY
                                   FILE    STATUS  IS  STS-RECE84.
      *
           SELECT  RECE85-FILE     ASSIGN  RECE85PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE85-KEY
                                   FILE    STATUS  IS  STS-RECE85.
      *
           SELECT  RECE841-FILE    ASSIGN  RECE841PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE841-KEY
                                   FILE    STATUS  IS  STS-RECE841.
           SELECT  RECE8441-FILE   ASSIGN  RECE841PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE8441-KEY
                                   FILE    STATUS  IS  STS-RECE841.
      *
           SELECT  RECE851-FILE    ASSIGN  RECE851PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE851-KEY
                                   FILE    STATUS  IS  STS-RECE851.
           SELECT  RECE8551-FILE   ASSIGN  RECE851PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE8551-KEY
                                   FILE    STATUS  IS  STS-RECE851.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       FD  RECE82-FILE.
       01  RECE82-REC.
           COPY    "CPRCF082.INC".
      *
       FD  RECE84-FILE.
       01  RECE84-REC.
           COPY    "CPRCF084.INC".
      *
       FD  RECE85-FILE.
       01  RECE85-REC.
           COPY    "CPRCF085.INC".
      *
       FD  RECE841-FILE.
       01  RECE841-REC. 
           COPY    "CPRCF084.INC"  REPLACING   //RECE84//
                                   BY          //RECE841//.
      *
       FD  RECE851-FILE.
       01  RECE851-REC. 
           COPY    "CPRCF085.INC"  REPLACING   //RECE85//
                                   BY          //RECE851//.
      *
       FD  RECE8441-FILE.
       01  RECE8441-REC. 
           COPY    "CPRCF084.INC"  REPLACING   //RECE84//
                                   BY          //RECE8441//.
      *
       FD  RECE8551-FILE.
       01  RECE8551-REC. 
           COPY    "CPRCF085.INC"  REPLACING   //RECE85//
                                   BY          //RECE8551//.
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE82//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE84//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE85//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE841//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE851//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE82          PIC X(02).
           03  STS-RECE84          PIC X(02).
           03  STS-RECE841         PIC X(02).
           03  STS-RECE85          PIC X(02).
           03  STS-RECE851         PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE84          PIC 9(01).
           03  FLG-RECE85          PIC 9(01).
           03  FLG-FIRST           PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
      *
           03  FLG-YAKUKAN-COMMENT PIC 9(01).
           03  FLG-WRKRECE85       PIC 9(01).
           03  FLG-COMMENT         PIC 9(02).
           03  FLG-ARI             PIC 9(01).
           03  FLG-NYU-RENZOKU     PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE82          PIC 9(06).
           03  CNT-RECE84          PIC 9(06).
           03  CNT-RECE85          PIC 9(06).
           03  CNT-RIHA            PIC 9(06).
           03  CNT-IN-COMMIT       PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  DAY-IDX             PIC 9(04).
           03  DAY-IDX2            PIC 9(02).
           03  IDX-RECE85          PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM              PIC  X(06).
               05  WRK-PARA-TERMID             PIC  X(16).
               05  WRK-PARA-SYSYMD             PIC  X(08).
               05  WRK-PARA-JOBID              PIC  9(07).
               05  WRK-PARA-SHELLID            PIC  X(08).
      *
           03  WRK-RENNUM          PIC 9(02).
           03  WRK-CNT-MEISAI      PIC 9(04).
           03  WRK-KETA            PIC 9(04).
           03  WRK-KETA-TAIHI      PIC 9(04).
           03  WRK-KETA2           PIC 9(04).
           03  WRK-RECEERR         PIC X(200).
      *
           03  WRK-TUKI-YAKUKAN    PIC 9(02).
           03  WRK-DAY-YAKUKAN     PIC 9(02).
      *
           03  TBL-SANTEI-DAY.
               05  TB-SANTEI-DAY   PIC 9(02)   OCCURS  31.
      *
           03  TBL-NYU-DAY.
               05  TBL-NYU-DAY-OCC             OCCURS  31.
                 07  TBL-NYU-DAY-ST  PIC 9(02).
                 07  TBL-NYU-DAY-ED  PIC 9(02).
                 07  TBL-NYU-DAY-CD  PIC X(09).
      *
           03  WRK-ZENYYMM           PIC 9(06).
      *
       01  WRK-RECE84-REC. 
           COPY    "CPRCF084.INC"  REPLACING   //RECE84//
                                   BY          //WRK-RECE84//.
      *
       01  WRK-RECE85-REC. 
           COPY    "CPRCF085.INC"  REPLACING   //RECE85//
                                   BY          //WRK-RECE85//.
      *
       01  COM-RECE85-REC. 
           COPY    "CPRCF085.INC"  REPLACING   //RECE85//
                                   BY          //COM//.
      *
       01  WRK-SRYACTINF-AREA.
           03  WRK-SRYACTINF                   OCCURS  50.
               05  WK-RECE85-SRYCD           PIC  X(09).
               05  WK-RECE85-SRYSURYO        PIC  9(05)V9(03).
               05  WK-RECE85-SRYKAISU        PIC  9(03).
               05  WK-RECE85-TANICD          PIC  9(03).
               05  WK-RECE85-TANIMOJISU      PIC  9(01).
               05  WK-RECE85-TANINAME        PIC  X(24).
               05  WK-RECE85-TENSIKIBETU     PIC  9(01).
               05  WK-RECE85-TEN             PIC  9(09)V9(02).
               05  WK-RECE85-MEISKYFLG       PIC  X(01).
               05  WK-RECE85-AUTOKBN         PIC  X(01).
               05  WK-RECE85-INPUTNUM        PIC  9(03).
               05  WK-RECE85-TENTTLKBN       PIC  9(03).
      *
       01  WRK-NAMEINF-AREA.
           03  WRK-NAMEINF                     OCCURS 50.         
               05  WK-RECE85-YUKOKETA        PIC  9(02).
               05  WK-RECE85-NAME            PIC  X(200).
      *
       01  WRK-SIKFLGINF-AREA.
           03  WRK-SIKFLGINF                   OCCURS 50.         
               05  WK-RECE85-SIKFLG          PIC  X(01).
      *
       01  WRK-DATAKBNINF-AREA.
           03  WRK-DATAKBNINF                  OCCURS 50.         
               05  WK-RECE85-DATAKBN         PIC  9(01).
      *
       01  WRK-HOUKNSKBNINF-AREA.                                       XXX
           03  WRK-HOUKNSKBNINF                OCCURS 50.               XXX
               05  WK-RECE85-HOUKNSKBN       PIC  9(02).                XXX
      *
       01  WRK-KNSJISKBNINF-AREA.                                       XXX
           03  WRK-KNSJISKBNINF                OCCURS 50.               XXX
               05  WK-RECE85-KNSJISKBN       PIC  9(01).                XXX
      *
       01  WRK-CDKBNINF-AREA.                                           XXX
           03  WRK-CDKBNINF                    OCCURS 50.               XXX
               05  WK-RECE85-CDKBN-KBN        PIC  X(01).               XXX
               05  WK-RECE85-CDKBN-SYO        PIC  9(01).               XXX
               05  WK-RECE85-CDKBN-BU         PIC  9(02).               XXX
               05  WK-RECE85-CDKBN-KBNNUM     PIC  9(03).               XXX
               05  WK-RECE85-CDKBN-KBNNUM-EDA PIC  9(02).               XXX
               05  WK-RECE85-CDKBN-KOUBAN     PIC  9(02).               XXX
               05  WK-RECE85-KOUHYOJYUNNUM    PIC  9(09).               XXX
      *
       01  WRK-FREE-AREA2.                                              
           03  WRK-FREEINF2                    OCCURS 50.               
               05  WK-FREE-YUKOKETA2         PIC  9(02).                
               05  WK-FREE-NAME2             PIC  X(200).               
      *
      *理学療法剤番号退避領域
       01  WRK-TAIHI-ZAINUM.
           03  WRK-RIGA1-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA1-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA2-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA2-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA3-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA3-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA4-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA4-KO-ZAINUM           PIC  9(08).   
           03  WRK-SAGYO1-SHU-ZAINUM         PIC  9(08).   
           03  WRK-SAGYO2-SHU-ZAINUM         PIC  9(08).   
           03  WRK-SAGYO1-KO-ZAINUM          PIC  9(08).   
           03  WRK-SAGYO2-KO-ZAINUM          PIC  9(08).   
           03  WRK-GENGO1-SHU-ZAINUM         PIC  9(08).   
           03  WRK-GENGO1-KO-ZAINUM          PIC  9(08).   
           03  WRK-GENGO2-SHU-ZAINUM         PIC  9(08).   
           03  WRK-GENGO2-KO-ZAINUM          PIC  9(08).   
      *
       01  WRK-TAIHI-ZAINUM-R     REDEFINES   WRK-TAIHI-ZAINUM.
            03  WRK-RIHA-ZAINUM   PIC 9(08)   OCCURS   16.       
      *
      *理学療法実施カレンダー
       01  WRK-RIGAKU-AREA.
           03  WRK-RIGA1-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA1-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA2-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA2-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA3-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA3-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA4-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA4-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO1-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO2-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO1-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO2-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO1-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO1-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO2-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO2-KO                 PIC  X(01)  OCCURS 31.   
      *
       01  WRK-RIGAKU-R        REDEFINES     WRK-RIGAKU-AREA.
           02  WRK-RIGAKU-OCC                OCCURS   16.
             03  WRK-RIGAKU-OCC2             OCCURS   31.
               04  WRK-RIGAKU                PIC  X(01).
      *
      *    日付全角変換領域
       01  TBL-DAY-AREA.
           03  FILLER              PIC X(04)  VALUE "　１".
           03  FILLER              PIC X(04)  VALUE "　２".
           03  FILLER              PIC X(04)  VALUE "　３".
           03  FILLER              PIC X(04)  VALUE "　４".
           03  FILLER              PIC X(04)  VALUE "　５".
           03  FILLER              PIC X(04)  VALUE "　６".
           03  FILLER              PIC X(04)  VALUE "　７".
           03  FILLER              PIC X(04)  VALUE "　８".
           03  FILLER              PIC X(04)  VALUE "　９".
           03  FILLER              PIC X(04)  VALUE "１０".
           03  FILLER              PIC X(04)  VALUE "１１".
           03  FILLER              PIC X(04)  VALUE "１２".
           03  FILLER              PIC X(04)  VALUE "１３".
           03  FILLER              PIC X(04)  VALUE "１４".
           03  FILLER              PIC X(04)  VALUE "１５".
           03  FILLER              PIC X(04)  VALUE "１６".
           03  FILLER              PIC X(04)  VALUE "１７".
           03  FILLER              PIC X(04)  VALUE "１８".
           03  FILLER              PIC X(04)  VALUE "１９".
           03  FILLER              PIC X(04)  VALUE "２０".
           03  FILLER              PIC X(04)  VALUE "２１".
           03  FILLER              PIC X(04)  VALUE "２２".
           03  FILLER              PIC X(04)  VALUE "２３".
           03  FILLER              PIC X(04)  VALUE "２４".
           03  FILLER              PIC X(04)  VALUE "２５".
           03  FILLER              PIC X(04)  VALUE "２６".
           03  FILLER              PIC X(04)  VALUE "２７".
           03  FILLER              PIC X(04)  VALUE "２８".
           03  FILLER              PIC X(04)  VALUE "２９".
           03  FILLER              PIC X(04)  VALUE "３０".
           03  FILLER              PIC X(04)  VALUE "３１".
       01  TBL-DAY-AREA-R          REDEFINES   TBL-DAY-AREA.
           03  TBL-DAY             PIC X(04)   OCCURS   31.
      *
       01  MAX-MEISAISU            PIC 9(07).
      *
      *    固定値
       01  CONST-AREA.
      *    薬剤管理指導料
           03  CONS-YAKUKAN-COMMENT  PIC X(09) VALUE "120001610".
      *    算定日コメント
           03  CONS-SANTEI-COMMENT1  PIC X(09) VALUE "840000058".
           03  CONS-SANTEI-COMMENT2  PIC X(09) VALUE "840000065".
      *
      *   リハビリ診療行為テーブル
       01  TBL-RIHA-AREA.
           03  FILLER          PIC X(09)   VALUE    "180706910".
           03  FILLER          PIC X(09)   VALUE    "180022210".
           03  FILLER          PIC X(09)   VALUE    "180706810".
           03  FILLER          PIC X(09)   VALUE    "180022110".
           03  FILLER          PIC X(09)   VALUE    "180707110".
           03  FILLER          PIC X(09)   VALUE    "180022410".
           03  FILLER          PIC X(09)   VALUE    "180707010".
           03  FILLER          PIC X(09)   VALUE    "180022310".
           03  FILLER          PIC X(09)   VALUE    "180707310".
           03  FILLER          PIC X(09)   VALUE    "180022610".
           03  FILLER          PIC X(09)   VALUE    "180707210".
           03  FILLER          PIC X(09)   VALUE    "180022510".
           03  FILLER          PIC X(09)   VALUE    "180707510".
           03  FILLER          PIC X(09)   VALUE    "180022810".
           03  FILLER          PIC X(09)   VALUE    "180707410".
           03  FILLER          PIC X(09)   VALUE    "180022710".
           03  FILLER          PIC X(09)   VALUE    "180708210".
           03  FILLER          PIC X(09)   VALUE    "180023710".
           03  FILLER          PIC X(09)   VALUE    "180708410".
           03  FILLER          PIC X(09)   VALUE    "180023910".
           03  FILLER          PIC X(09)   VALUE    "180708110".
           03  FILLER          PIC X(09)   VALUE    "180023610".
           03  FILLER          PIC X(09)   VALUE    "180708310".
           03  FILLER          PIC X(09)   VALUE    "180023810".
           03  FILLER          PIC X(09)   VALUE    "180024910".
           03  FILLER          PIC X(09)   VALUE    "180024810".
           03  FILLER          PIC X(09)   VALUE    "180025110".
           03  FILLER          PIC X(09)   VALUE    "180025010".
      *
       01  TBL-RIHA-R          REDEFINES   TBL-RIHA-AREA.
            03  TBL-RIHA       PIC X(09)   OCCURS   28.       
      *
       01  TBL-RIHA-MAX        PIC 9(02)   VALUE    28.  
      *
      *    パス名領域
       01  WRK-PATH                        PIC X(64).
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    診療行為
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *     
      *    数値変換サブ
           COPY    "CPORCSNUM.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
                   UNTIL   FLG-END  =  1
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
           INITIALIZE                  CNT-AREA
      *
           MOVE    COMMAND-PARAM   TO  WRK-PARA
      *
      *    ファイルＯＰＥＮ処理
      *
           PERFORM 110-FILE-OPEN-SEC
           PERFORM 120-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0870"      TO  JOB-PGID
           MOVE    "コメント編集（労災・自賠責）"
                                   TO  JOB-SHELLMSG   
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 990-RECE82-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＯＰＥＮ処理
      *****************************************************************
       110-FILE-OPEN-SEC          SECTION.
      *
           MOVE    "RECE820"           TO  RECE82PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE82PARA-TERMID
      *
           MOVE    "RECE84W"           TO  RECE84PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE84PARA-TERMID
      *
           MOVE    "RECE850"           TO  RECE85PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE85PARA-TERMID
      *
           MOVE    "RECE84A"           TO  RECE841PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE841PARA-TERMID
      *
           MOVE    "RECE85A"           TO  RECE851PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE851PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE82-FILE
      *
           OPEN    INPUT               RECE84-FILE
      *
           OPEN    INPUT               RECE85-FILE
      *
           OPEN    OUTPUT              RECE8441-FILE
           CLOSE                       RECE8441-FILE
      *
           OPEN    OUTPUT              RECE8551-FILE
           CLOSE                       RECE8551-FILE
      *
           OPEN    OUTPUT              RECE841-FILE
      *
           OPEN    OUTPUT              RECE851-FILE
      *
           .
       110-FILE-OPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           INITIALIZE                      WRK-RIGAKU-AREA
           INITIALIZE                      WRK-TAIHI-ZAINUM
      *
           IF   RECE82-COMCNTFLG   =   "1"
             INITIALIZE                      RECE84-REC
             MOVE    RECE82-HOSPID       TO  RECE84-HOSPID
             MOVE    RECE82-SRYYM        TO  RECE84-SRYYM
             MOVE    RECE82-NYUGAIKBN    TO  RECE84-NYUGAIKBN
             MOVE    RECE82-PTID         TO  RECE84-PTID
             MOVE    RECE82-RECEKA       TO  RECE84-RECEKA
             MOVE    RECE82-HKNID        TO  RECE84-HKNID
             MOVE    RECE82-TEKSTYMD     TO  RECE84-TEKSTYMD
             MOVE    ZERO                TO  RECE84-ZAINUM
      *
             START   RECE84-FILE
                 KEY IS    >=   RECE84-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE84
                 NOT INVALID
                     PERFORM 990-RECE84-NEXT-SEC
             END-START
             PERFORM
               UNTIL  ( FLG-RECE84           =   1                   )
               OR     ( RECE82-HOSPID    NOT =   RECE84-HOSPID       )
               OR     ( RECE82-SRYYM     NOT =   RECE84-SRYYM        )
               OR     ( RECE82-NYUGAIKBN NOT =   RECE84-NYUGAIKBN    )
               OR     ( RECE82-PTID      NOT =   RECE84-PTID         )
               OR     ( RECE82-RECEKA    NOT =   RECE84-RECEKA       )
               OR     ( RECE82-HKNID     NOT =   RECE84-HKNID        )
               OR     ( RECE82-TEKSTYMD  NOT =   RECE84-TEKSTYMD     )
      *
               IF   RECE82-HKNKBN    NOT  =  "4"                        
                  EVALUATE      RECE84-SRYKBN
                      WHEN      "80"
      *               （リハビリのカウント）
                         PERFORM    2001-RIHA-COUNT-SEC
                  END-EVALUATE
               ELSE                                                     
                  EVALUATE      RECE84-SRYKBN  
                      WHEN      "40"                                    
      *               （リハビリのカウント）                            
                         PERFORM    2001-RIHA-COUNT-SEC                 
                  END-EVALUATE                                          
               END-IF                                                   
               PERFORM 990-RECE84-NEXT-SEC
             END-PERFORM
           END-IF
      *
      *    他保険にて入院料算定済みのコメント
      *
           IF   RECE82-NYUINRYOFLG   NOT =   SPACE
      *
              PERFORM   2001-NYUINRYO-COMMENT-SEC
      *
           END-IF
      *
           INITIALIZE                      RECE84-REC
           MOVE    RECE82-HOSPID       TO  RECE84-HOSPID
           MOVE    RECE82-SRYYM        TO  RECE84-SRYYM
           MOVE    RECE82-NYUGAIKBN    TO  RECE84-NYUGAIKBN
           MOVE    RECE82-PTID         TO  RECE84-PTID
           MOVE    RECE82-RECEKA       TO  RECE84-RECEKA
           MOVE    RECE82-HKNID        TO  RECE84-HKNID
           MOVE    RECE82-TEKSTYMD     TO  RECE84-TEKSTYMD
           MOVE    ZERO                TO  RECE84-ZAINUM
      *
           START   RECE84-FILE
               KEY IS    >=   RECE84-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE84
               NOT INVALID
                   PERFORM 990-RECE84-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE84           =   1                   )
               OR     ( RECE82-HOSPID    NOT =   RECE84-HOSPID       )
               OR     ( RECE82-SRYYM     NOT =   RECE84-SRYYM        )
               OR     ( RECE82-NYUGAIKBN NOT =   RECE84-NYUGAIKBN    )
               OR     ( RECE82-PTID      NOT =   RECE84-PTID         )
               OR     ( RECE82-RECEKA    NOT =   RECE84-RECEKA       )
               OR     ( RECE82-HKNID     NOT =   RECE84-HKNID        )
               OR     ( RECE82-TEKSTYMD  NOT =   RECE84-TEKSTYMD     )
      *
               IF   RECE82-HKNKBN    NOT  =  "4"                        
                 EVALUATE      RECE84-SRYKBN                   
                   WHEN      "13"
                      MOVE   ZERO   TO  FLG-COMMENT
      *            （薬剤管理指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-YAKUKANSIDO-HANTEI-SEC
                      END-IF
      *            （入院栄養食事指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-NYUEIYOSIDO-HANTEI-SEC
                      END-IF
      *            （退院前訪問指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-HOUMONSIDO-HANTEI-SEC
                      END-IF
      *            （傷病手当金意見書交付料交付日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-SYOBYO-HANTEI-SEC
                      END-IF
      *            （療養費同意書交付料交付日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-RYOYO-HANTEI-SEC
                      END-IF
      *            （退院時服薬指導加算算定時の
      *              前月薬剤管理指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-TAIIN-HANTEI-SEC
                      END-IF
      *
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2009-RECE84-WRITE-SEC
                      END-IF
                   WHEN      "50"
      *            （手術日のセット）
                      PERFORM    2001-SHUJUTSU-HANTEI-SEC
                   WHEN      "70"
      *            （ＣＴ・ＭＲＩ実施日のセット）
                      PERFORM    2001-CTMRI-HANTEI-SEC
                   WHEN      "80"
                      MOVE   ZERO   TO  FLG-COMMENT
      *            （精神科退院前訪問指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-HOUMONSIDO-SEISIN-HANTEI-SEC
                      END-IF
      *            （リハビリのセット）
                      IF   FLG-COMMENT  =  ZERO
                        MOVE    ZERO     TO    FLG-ARI
                        PERFORM   VARYING   IDX    FROM   1   BY   1
                            UNTIL   (IDX             >      16)
                             OR     (FLG-ARI         =       1)
                          IF  RECE84-ZAINUM  =  WRK-RIHA-ZAINUM(IDX)
                              MOVE    1    TO   FLG-ARI 
                          END-IF
                        END-PERFORM
                        IF  FLG-ARI  =  1
                            MOVE      99   TO   FLG-COMMENT
                            PERFORM   2001-RIHA-COMMENT-SEC
                        END-IF
                      END-IF
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM       2009-RECE84-WRITE-SEC
                      END-IF
                   WHEN      "90"                                       
                   WHEN      "92"
                      EVALUATE    RECE84-ZAISKBKBN
                        WHEN   "2"
                          PERFORM   2001-NYU-COMMENT-SEC
                        WHEN   "6"
                          MOVE   ZERO   TO  FLG-COMMENT
                          IF   FLG-COMMENT  =  ZERO
                             PERFORM   2001-KAKURI-HANTEI-SEC
                          END-IF
                          IF   FLG-COMMENT  =  ZERO
                             PERFORM   2001-CHIRYO-HANTEI-SEC
                          END-IF
                          IF   FLG-COMMENT  =  ZERO
                             PERFORM   2009-RECE84-WRITE-SEC
                          END-IF
                        WHEN   OTHER
                         PERFORM    2009-RECE84-WRITE-SEC
                      END-EVALUATE
                   WHEN   OTHER
                         PERFORM    2009-RECE84-WRITE-SEC
                 END-EVALUATE
               ELSE                                                     
                 EVALUATE      RECE84-SRYKBN                            
                   WHEN      "13"                                       
                      MOVE   ZERO   TO  FLG-COMMENT
      *            （薬剤管理指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-YAKUKANSIDO-HANTEI-SEC
                      END-IF
      *            （入院栄養食事指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-NYUEIYOSIDO-HANTEI-SEC
                      END-IF
      *            （退院前訪問指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-HOUMONSIDO-HANTEI-SEC
                      END-IF
      *            （傷病手当金意見書交付料交付日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-SYOBYO-HANTEI-SEC
                      END-IF
      *            （療養費同意書交付料交付日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-RYOYO-HANTEI-SEC
                      END-IF
      *            （退院時服薬指導加算算定時の
      *              前月薬剤管理指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-TAIIN-HANTEI-SEC
                      END-IF
      *
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2009-RECE84-WRITE-SEC
                      END-IF
                   WHEN      "40"          
                      MOVE   ZERO   TO  FLG-COMMENT
      *            （精神科退院前訪問指導料算定日のセット）
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM    2001-HOUMONSIDO-SEISIN-HANTEI-SEC
                      END-IF
      *            （リハビリのセット）
                      IF   FLG-COMMENT  =  ZERO
                        MOVE    ZERO     TO    FLG-ARI
                        PERFORM   VARYING   IDX    FROM   1   BY   1
                            UNTIL   (IDX             >      16)
                             OR     (FLG-ARI         =       1)
                          IF  RECE84-ZAINUM  =  WRK-RIHA-ZAINUM(IDX)
                              MOVE    1    TO   FLG-ARI 
                          END-IF
                        END-PERFORM
                        IF  FLG-ARI  =  1
                            MOVE      99   TO   FLG-COMMENT
                            PERFORM   2001-RIHA-COMMENT-SEC
                        END-IF
                      END-IF
                      IF   FLG-COMMENT  =  ZERO
                        PERFORM       2009-RECE84-WRITE-SEC
                      END-IF
                   WHEN      "50"                                       
      *            （手術日のセット）                                   
                      PERFORM    2001-SHUJUTSU-HANTEI-SEC               
                   WHEN      "70"
      *            （ＣＴ・ＭＲＩ実施日のセット）
                      PERFORM    2001-CTMRI-HANTEI-SEC
                   WHEN      "90"                                       
                   WHEN      "92"
                      EVALUATE    RECE84-ZAISKBKBN
                        WHEN   "2"
                          PERFORM   2001-NYU-COMMENT-SEC
                        WHEN   "6"
                          MOVE   ZERO   TO  FLG-COMMENT
                          IF   FLG-COMMENT  =  ZERO
                             PERFORM   2001-KAKURI-HANTEI-SEC
                          END-IF
                          IF   FLG-COMMENT  =  ZERO
                             PERFORM   2001-CHIRYO-HANTEI-SEC
                          END-IF
                          IF   FLG-COMMENT  =  ZERO
                             PERFORM   2009-RECE84-WRITE-SEC
                          END-IF
                        WHEN   OTHER
                          PERFORM   2009-RECE84-WRITE-SEC
                      END-EVALUATE
                   WHEN   OTHER                                         
                         PERFORM    2009-RECE84-WRITE-SEC
                 END-EVALUATE                                           
               END-IF                                                   
      *
               PERFORM 990-RECE84-NEXT-SEC
      *
           END-PERFORM
      *
      *
           PERFORM 990-RECE82-READ-SEC
      *
           IF  CNT-IN-COMMIT   =    300
                 MOVE  ZERO          TO      CNT-IN-COMMIT
                 PERFORM 900-DBCOMMIT-SEC
                 PERFORM 900-DBSTART-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    リハビリのカウント
      *****************************************************************
       2001-RIHA-COUNT-SEC          SECTION.
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                     UNTIL   ( IDX           >   TBL-RIHA-MAX )
      *
              INITIALIZE                        SRYACT-REC
              MOVE    RECE84-HOSPID     TO      SRY-HOSPID
              MOVE    RECE84-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE84-PTID       TO      SRY-PTID
              MOVE    RECE84-SRYYM      TO      SRY-SRYYM
              MOVE    RECE84-ZAINUM     TO      SRY-ZAINUM
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (1)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (2)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (3)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (4)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (5)
      *
              MOVE    SRYACT-REC        TO      MCPDATA-REC
              PERFORM 900-SRYACT-READ-SEC
              IF      FLG-SRYACT        =       ZERO
                  EVALUATE    IDX
                      WHEN   1  
                      WHEN   2
                          MOVE    1    TO    IDX2   
                      WHEN   3  
                      WHEN   4
                          MOVE    2    TO    IDX2   
                      WHEN   5  
                      WHEN   6
                          MOVE    3    TO    IDX2   
                      WHEN   7  
                      WHEN   8
                          MOVE    4    TO    IDX2   
                      WHEN   9  
                      WHEN  10
                          MOVE    5    TO    IDX2   
                      WHEN  11  
                      WHEN  12
                          MOVE    6    TO    IDX2   
                      WHEN  13  
                      WHEN  14
                          MOVE    7    TO    IDX2   
                      WHEN  15  
                      WHEN  16
                          MOVE    8    TO    IDX2   
                      WHEN  17  
                      WHEN  18
                          MOVE    9    TO    IDX2   
                      WHEN  19  
                      WHEN  20
                          MOVE   10    TO    IDX2   
                      WHEN  21  
                      WHEN  22
                          MOVE   11    TO    IDX2   
                      WHEN  23  
                      WHEN  24
                          MOVE   12    TO    IDX2   
                      WHEN  25  
                          MOVE   13    TO    IDX2
                      WHEN  26
                          MOVE   14    TO    IDX2   
                      WHEN  27  
                          MOVE   15    TO    IDX2
                      WHEN  28
                          MOVE   16    TO    IDX2   
                 END-EVALUATE
                 IF  RECE84-ZAINUM  >  WRK-RIHA-ZAINUM(IDX2)
                     MOVE  RECE84-ZAINUM  TO  WRK-RIHA-ZAINUM(IDX2)
                 END-IF
                 PERFORM  VARYING   IDX1  FROM  1  BY  1
                          UNTIL     IDX1  >   31
                     IF   RECE84-KAISU(1 IDX1)  NOT = ZERO
                          MOVE  "1"  TO  WRK-RIGAKU(IDX2 IDX1)
                     END-IF
                 END-PERFORM
              END-IF
           END-PERFORM
      *
           .
       2001-RIHA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    他保険にて入院料算定済みのコメント編集
      *****************************************************************
       2001-NYUINRYO-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE841-REC
           MOVE    RECE82-HOSPID       TO  RECE841-HOSPID
           MOVE    RECE82-SRYYM        TO  RECE841-SRYYM
           MOVE    RECE82-NYUGAIKBN    TO  RECE841-NYUGAIKBN
           MOVE    RECE82-PTID         TO  RECE841-PTID
           MOVE    RECE82-RECEKA       TO  RECE841-RECEKA
           MOVE    RECE82-HKNID        TO  RECE841-HKNID
           MOVE    RECE82-TEKSTYMD     TO  RECE841-TEKSTYMD
           MOVE    99999999            TO  RECE841-ZAINUM
           MOVE    "90"                TO  RECE841-SRYKBN
      *
           MOVE    1                   TO  RECE841-MEISAISU
      *
           WRITE   RECE841-REC
           ADD     1                   TO  CNT-RECE84
      *
           INITIALIZE                      RECE851-REC
           MOVE    RECE82-HOSPID       TO  RECE851-HOSPID
           MOVE    RECE82-SRYYM        TO  RECE851-SRYYM
           MOVE    RECE82-NYUGAIKBN    TO  RECE851-NYUGAIKBN
           MOVE    RECE82-PTID         TO  RECE851-PTID
           MOVE    RECE82-RECEKA       TO  RECE851-RECEKA
           MOVE    RECE82-HKNID        TO  RECE851-HKNID
           MOVE    RECE82-TEKSTYMD     TO  RECE851-TEKSTYMD
           MOVE    99999999            TO  RECE851-ZAINUM
           MOVE    "90"                TO  RECE851-SRYKBN
      *    コメントの挿入
           MOVE    SPACE               TO  COM-RECE85-REC
           INITIALIZE                      COM-RECE85-REC
           MOVE    "810000001"         TO  COM-SRYCD(1)
           MOVE     ZERO               TO  COM-SRYSURYO(1)
           MOVE     11                 TO  COM-YUKOKETA(1)
           MOVE    "他保険にて入院料算定済" 
                                       TO  COM-NAME(1)
      *
           MOVE    COM-SRYACTINF(1)    TO  RECE851-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)      TO  RECE851-NAMEINF(1)
      *
           MOVE     "1"                TO  RECE851-SIKFLG(1)
      *
           WRITE   RECE851-REC
           ADD     1                   TO  CNT-RECE85
      *
           .
       2001-NYUINRYO-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    薬剤管理指導料があるか判定
      *****************************************************************
       2001-YAKUKANSIDO-HANTEI-SEC          SECTION.
      *
           IF      RECE84-FLG-YAKUKAN-COMMENT   =    "1"
                MOVE       3       TO     FLG-COMMENT
                PERFORM    2002-SHUJUTSU-ETC-COMMENT-SEC
           END-IF
      *
           .
       2001-YAKUKANSIDO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院栄養食事指導料があるか判定
      *****************************************************************
       2001-NYUEIYOSIDO-HANTEI-SEC          SECTION.
      *
           IF      RECE84-FLG-NYUEIYO-COMMENT   =    "1"
                MOVE       3       TO     FLG-COMMENT
                PERFORM    2002-SHUJUTSU-ETC-COMMENT-SEC
           END-IF
      *
           .
       2001-NYUEIYOSIDO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    退院前訪問指導料があるか判定
      *****************************************************************
       2001-HOUMONSIDO-HANTEI-SEC          SECTION.
      *
           IF      RECE84-FLG-HOUMON-COMMENT   =    "1"
                MOVE       3       TO     FLG-COMMENT
                PERFORM    2002-SHUJUTSU-ETC-COMMENT-SEC
           END-IF
      *
           .
       2001-HOUMONSIDO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    傷病手当金意見書交付料があるか判定
      *****************************************************************
       2001-SYOBYO-HANTEI-SEC          SECTION.
      *
           IF      RECE84-FLG-SYOBYO-COMMENT   =    "1"
               MOVE    4                 TO  FLG-COMMENT
               PERFORM 2002-SHUJUTSU-ETC-COMMENT-SEC
           END-IF
      *
           .
       2001-SYOBYO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    療養費同意書交付料があるか判定
      *****************************************************************
       2001-RYOYO-HANTEI-SEC          SECTION.
      *
           IF      RECE84-FLG-RYOYO-COMMENT    =    "1"
               MOVE    4                 TO     FLG-COMMENT
               PERFORM 2002-SHUJUTSU-ETC-COMMENT-SEC
           END-IF
      *
           .
       2001-RYOYO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    精神科退院前訪問指導料があるか判定
      *****************************************************************
       2001-HOUMONSIDO-SEISIN-HANTEI-SEC          SECTION.
      *
           IF      RECE84-FLG-HOUSEI-COMMENT   =    "1"
                MOVE       3       TO     FLG-COMMENT
                PERFORM    2002-SHUJUTSU-ETC-COMMENT-SEC
           END-IF
      *
           .
       2001-HOUMONSIDO-SEISIN-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント編集
      *****************************************************************
       2002-SHUJUTSU-ETC-COMMENT-SEC          SECTION.
      *
           PERFORM   2003-SANTEI-DAY-SEC
      *
           MOVE       ZERO       TO   IDZ                               
           INITIALIZE            WRK-FREE-AREA2                         
      *
           PERFORM   2003-FREE-COMMENT-SEC                              
      *
      *    ※明細が５以上の場合
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPID       TO  RECE85-HOSPID
           MOVE    RECE84-SRYYM        TO  RECE85-SRYYM
           MOVE    RECE84-NYUGAIKBN    TO  RECE85-NYUGAIKBN
           MOVE    RECE84-PTID         TO  RECE85-PTID
           MOVE    RECE84-RECEKA       TO  RECE85-RECEKA
           MOVE    RECE84-HKNID        TO  RECE85-HKNID
           MOVE    RECE84-TEKSTYMD     TO  RECE85-TEKSTYMD
           MOVE    RECE84-ZAINUM       TO  RECE85-ZAINUM
           START   RECE85-FILE
                 KEY IS    >=   RECE85-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE85
                 NOT INVALID
                     PERFORM 990-RECE85-NEXT-SEC
                     MOVE    RECE85-REC  TO  WRK-RECE85-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                 TO  IDX-RECE85
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-SIKFLGINF-AREA
           INITIALIZE                       WRK-SIKFLGINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
           MOVE    SPACE                TO  WRK-HOUKNSKBNINF-AREA       XXX
           INITIALIZE                       WRK-HOUKNSKBNINF-AREA       XXX
           MOVE    SPACE                TO  WRK-KNSJISKBNINF-AREA       XXX
           INITIALIZE                       WRK-KNSJISKBNINF-AREA       XXX
           MOVE    SPACE                TO  WRK-CDKBNINF-AREA           XXX
           INITIALIZE                       WRK-CDKBNINF-AREA           XXX
      *
           MOVE    RECE84-MEISAISU      TO  MAX-MEISAISU
      *
           MOVE    SPACE               TO  COM-RECE85-REC
           INITIALIZE                      COM-RECE85-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                COMPUTE  MAX-MEISAISU        =   MAX-MEISAISU  +  1
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE    "1"               TO  COM-SIKFLG(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF
                                                         (MAX-MEISAISU)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(MAX-MEISAISU)
                MOVE   COM-SIKFLGINF(1)   TO  WRK-SIKFLGINF
                                                         (MAX-MEISAISU)
           END-PERFORM 
      *
           PERFORM
             UNTIL  ( FLG-RECE85           =   1                   )
             OR     ( RECE84-HOSPID    NOT =   RECE85-HOSPID       )
             OR     ( RECE84-SRYYM     NOT =   RECE85-SRYYM        )
             OR     ( RECE84-NYUGAIKBN NOT =   RECE85-NYUGAIKBN    )
             OR     ( RECE84-PTID      NOT =   RECE85-PTID         )
             OR     ( RECE84-RECEKA    NOT =   RECE85-RECEKA       )
             OR     ( RECE84-HKNID     NOT =   RECE85-HKNID        )
             OR     ( RECE84-TEKSTYMD  NOT =   RECE85-TEKSTYMD     )
             OR     ( RECE84-ZAINUM    NOT =   RECE85-ZAINUM       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE85-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE85
                  MOVE   RECE85-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE85)
                  MOVE   RECE85-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE85)
                  MOVE   RECE85-SIKFLGINF(IDX)   TO
                                           WRK-SIKFLGINF(IDX-RECE85)     
                  MOVE   RECE85-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE85)
                  MOVE   RECE85-HOUKNSKBNINF(IDX) TO                    XXX
                                           WRK-HOUKNSKBNINF(IDX-RECE85) XXX
                  MOVE   RECE85-KNSJISKBNINF(IDX) TO                    XXX
                                           WRK-KNSJISKBNINF(IDX-RECE85) XXX
                  MOVE   RECE85-CDKBNINF(IDX) TO                        XXX
                                           WRK-CDKBNINF(IDX-RECE85)     XXX
             END-PERFORM 
      *
             PERFORM 990-RECE85-NEXT-SEC
      *
           END-PERFORM
      *
      *    手術日コメントを含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE85
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE85
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE85  =    1
      *
                  INITIALIZE                        RECE851-REC
                  MOVE    WRK-RECE85-KEY       TO   RECE851-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE851-RENNUM
                  MOVE    WRK-RECE85-PTNUM     TO   RECE851-PTNUM
                  MOVE    WRK-RECE85-SRYKA     TO   RECE851-SRYKA
                  MOVE    WRK-RECE85-SRYKBN    TO   RECE851-SRYKBN
                  MOVE    WRK-RECE85-SRYSYUKBN TO   RECE851-SRYSYUKBN
                  MOVE    WRK-RECE85-JIHIMONEY TO   RECE851-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE85   =   1)
                     ADD         1             TO    IDX-RECE85
                     IF  WK-RECE85-SRYCD(IDX-RECE85) = SPACE
                         MOVE    1             TO    FLG-WRKRECE85
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE85)
                                          TO   RECE851-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE85)
                                          TO   RECE851-NAMEINF(IDX)
                         MOVE  WRK-SIKFLGINF(IDX-RECE85)
                                          TO   RECE851-SIKFLGINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE85)
                                          TO   RECE851-DATAKBNINF(IDX)
                         MOVE  WRK-HOUKNSKBNINF(IDX-RECE85)             XXX
                                        TO   RECE851-HOUKNSKBNINF(IDX)  XXX
                         MOVE  WRK-KNSJISKBNINF(IDX-RECE85)             XXX
                                        TO   RECE851-KNSJISKBNINF(IDX)  XXX
                         MOVE  WRK-CDKBNINF(IDX-RECE85)                 XXX
                                        TO   RECE851-CDKBNINF(IDX)      XXX
      *
                         IF    WRK-SIKFLGINF(IDX-RECE85)  =  "1"
                              ADD    1    TO   WRK-CNT-MEISAI
                         END-IF    
      *
                     END-IF  
                  END-PERFORM
                  WRITE   RECE851-REC
                  ADD     1                    TO  CNT-RECE85
           END-PERFORM     
      *
           MOVE    RECE84-REC        TO      RECE841-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE841-MEISAISU
           WRITE   RECE841-REC
           ADD     1                 TO      CNT-RECE84
      *
           .
       2002-SHUJUTSU-ETC-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定日の確定
      *****************************************************************
       2003-SANTEI-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-SANTEI-DAY
      *
           MOVE    ZERO          TO  DAY-IDX
           PERFORM    VARYING    IDX  FROM   1   BY   1
                      UNTIL     (IDX      >   31)  OR
                                (DAY-IDX  >   31)
               IF    RECE84-KAISU(1 IDX)  NOT =  ZERO
                   ADD   1     TO   DAY-IDX
                   MOVE  IDX   TO  TB-SANTEI-DAY(DAY-IDX)
               END-IF
           END-PERFORM
           .
       2003-SANTEI-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付の編集
      *****************************************************************
       2003-FREE-COMMENT-SEC          SECTION.                         
      *
           ADD      1          TO    IDZ
      *
           EVALUATE   FLG-COMMENT
              WHEN    1
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "手術"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
              WHEN    2
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "実施"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
              WHEN    3
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "算定"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
              WHEN    4
                 MOVE     4          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "交付"  TO    WK-FREE-NAME2(IDZ)(1:WRK-KETA)
           END-EVALUATE
      *
           MOVE      ZERO          TO  FLG-FIRST
      *
           PERFORM   VARYING   IDX    FROM   1   BY   1
                          UNTIL   (IDX                 >    31)
                           OR     (TB-SANTEI-DAY(IDX)  =  ZERO)
      *
                 IF  FLG-FIRST  =  ZERO
                    IF  TB-SANTEI-DAY(IDX)     <  10 
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "　"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)(3:2)     
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    "日"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                    ELSE
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                       MOVE    "　"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                       MOVE    TBL-DAY(IDY)     
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                       ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                       COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                       MOVE    "日"
                           TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                    END-IF
                    MOVE      1              TO  FLG-FIRST
                 ELSE
                    IF  TB-SANTEI-DAY(IDX)     <  10 
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  25
                          PERFORM  2004-FREE-COMMENT-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "、"
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "、"
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  24 OR 25
                          PERFORM  2004-FREE-COMMENT-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "日"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2) 
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)(3:2)     
                                    TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "日"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2) 
                       END-IF
                    ELSE
      *
                       MOVE   TB-SANTEI-DAY(IDX)  TO  IDY
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  25
                          PERFORM  2004-FREE-COMMENT-KAIGYO-SEC
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    "、"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    "、"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       END-IF
      *
                       IF    WK-FREE-YUKOKETA2(IDZ)  =  23 OR 24 OR 25
                          PERFORM  2004-FREE-COMMENT-KAIGYO-SEC
                          ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  1
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "日"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       ELSE
                          ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)     
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "日"
                                   TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       END-IF
                    END-IF
                 END-IF
      *
           END-PERFORM
           .
       2003-FREE-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付の編集（改行）
      *****************************************************************
       2004-FREE-COMMENT-KAIGYO-SEC          SECTION.                  
      *
           ADD      1              TO  IDZ
      *
           MOVE    WRK-KETA-TAIHI  TO  WRK-KETA
           MOVE    WRK-KETA2       TO  WK-FREE-YUKOKETA2(IDZ)
           MOVE    ALL "　"        TO  WK-FREE-NAME2(IDZ)(1:WRK-KETA)
      *
           .
       2004-FREE-COMMENT-KAIGYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    退院時服薬指導加算を算定時、当月に薬剤管理指導料がなく、前月
      *    に薬剤管理指導料があるか判定
      *****************************************************************
       2001-TAIIN-HANTEI-SEC          SECTION.
      *
           MOVE      ZERO            TO      WRK-TUKI-YAKUKAN
           MOVE      ZERO            TO      WRK-DAY-YAKUKAN
      *
           IF      RECE84-FLG-TAIIN-COMMENT   =    "1"
      *
             MOVE      ZERO            TO      FLG-YAKUKAN-COMMENT
      *
             INITIALIZE                        SRYACT-REC
             MOVE    RECE84-HOSPID     TO      SRY-HOSPID
             MOVE    RECE84-NYUGAIKBN  TO      SRY-NYUGAIKBN
             MOVE    RECE84-PTID       TO      SRY-PTID
             MOVE    RECE84-SRYYM      TO      SRY-SRYYM
             MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (1)
             MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (2)
             MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (3)
             MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (4)
             MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (5)
      *
             MOVE    SRYACT-REC        TO      MCPDATA-REC
             MOVE    "DBSELECT"        TO      MCP-FUNC
             MOVE    "SRYACT-KEY7"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
             IF      MCP-RC               =       ZERO
                 MOVE    "SRYACT-KEY7"   TO      ORC-DBPATH
                 PERFORM  900-SRYACT-READ-NEXT-SEC
                 IF      FLG-SRYACT  =  ZERO
                     MOVE    1         TO      FLG-YAKUKAN-COMMENT
                 END-IF
             END-IF
      *
             MOVE    "DBCLOSE"         TO      MCP-FUNC
             MOVE    "SRYACT-KEY7"     TO      ORC-DBPATH
             CALL    "ORCMCPSUB"       USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
             IF      FLG-YAKUKAN-COMMENT   =   ZERO
      *
               MOVE      ZERO            TO      WRK-ZENYYMM
      *
               MOVE      ZERO            TO      FLG-YAKUKAN-COMMENT
      *
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY6-AREA
               MOVE    "61"                TO  LNK-DAY6-IRAI
               MOVE    RECE84-SRYYM        TO  LNK-DAY6-KIJUN(1:6)
               MOVE    "01"                TO  LNK-DAY6-KIJUN(7:2)
               MOVE    "2"                 TO  LNK-DAY6-ZOGENPTN
               MOVE     -1                 TO  LNK-DAY6-ZOGEN
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN(1:6)
                                           TO  WRK-ZENYYMM
      *
               INITIALIZE                        SRYACT-REC
               MOVE    RECE84-HOSPID     TO      SRY-HOSPID
               MOVE    RECE84-NYUGAIKBN  TO      SRY-NYUGAIKBN
               MOVE    RECE84-PTID       TO      SRY-PTID
               MOVE    WRK-ZENYYMM       TO      SRY-SRYYM
               MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (1)
               MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (2)
               MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (3)
               MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (4)
               MOVE    CONS-YAKUKAN-COMMENT  TO  SRY-SRYCD (5)
      *
               MOVE    SRYACT-REC        TO      MCPDATA-REC
               MOVE    "DBSELECT"        TO      MCP-FUNC
               MOVE    "SRYACT-KEY7"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
               IF      MCP-RC               =       ZERO
                   MOVE    "SRYACT-KEY7"   TO      ORC-DBPATH
                   PERFORM  900-SRYACT-READ-NEXT-SEC
                   PERFORM  UNTIL   FLG-SRYACT           =  1
      *
                     INITIALIZE                     SRYACCT-REC
                     MOVE    SRY-HOSPID     TO      ACCT-HOSPID
                     MOVE    SRY-NYUGAIKBN  TO      ACCT-NYUGAIKBN
                     MOVE    SRY-PTID       TO      ACCT-PTID
                     MOVE    SRY-SRYKA      TO      ACCT-SRYKA
                     MOVE    SRY-SRYYM      TO      ACCT-SRYYM
                     MOVE    SRY-ZAINUM     TO      ACCT-ZAINUM
      *
                     MOVE    SRYACCT-REC    TO      MCPDATA-REC
                     MOVE    "DBSELECT"     TO      MCP-FUNC
                     MOVE    "SRYACCT-KEY5" TO      ORC-DBPATH
                     CALL    "ORCMCPSUB"       USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
      *
                     IF  MCP-RC                =  ZERO
                         MOVE    "DBFETCH"      TO      MCP-FUNC
                         MOVE    "SRYACCT-KEY5" TO      ORC-DBPATH
                         CALL    "ORCMCPSUB"           USING
                                                       MCPAREA
                                                       ORCMCPAREA
                                                       MCPDATA-REC
                         IF      MCP-RC        =       ZERO
      *
                           MOVE    MCPDATA-REC  TO  SRYACCT-REC
      *
                           PERFORM    VARYING    IDX  FROM   1   BY   1
                                UNTIL      IDX      >   31
                             IF    ACCT-DAY(1 IDX)  NOT =  ZERO
                                IF    IDX   >   WRK-DAY-YAKUKAN
                                    MOVE  IDX   TO  WRK-DAY-YAKUKAN
                                END-IF
                             END-IF
                           END-PERFORM
      *
                         END-IF
                     END-IF
      *
                     MOVE    "DBCLOSE"         TO      MCP-FUNC
                     MOVE    "SRYACCT-KEY5"    TO      ORC-DBPATH
                     CALL    "ORCMCPSUB"       USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
      *
                     MOVE     "SRYACT-KEY7"   TO   ORC-DBPATH
                     PERFORM   900-SRYACT-READ-NEXT-SEC
      *
                   END-PERFORM
               END-IF
      *
               MOVE    "DBCLOSE"         TO      MCP-FUNC
               MOVE    "SRYACT-KEY7"     TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
             END-IF
      *
           END-IF
      *
           IF      WRK-DAY-YAKUKAN    NOT   =   ZERO
                MOVE       99             TO   FLG-COMMENT
                MOVE    WRK-ZENYYMM(5:2)  TO   WRK-TUKI-YAKUKAN
                PERFORM    2002-TAIIN-COMMENT-SEC
           END-IF
      *
           .
       2001-TAIIN-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    退院時服薬指導加算を算定時の前月薬剤管理指導料のコメント編集
      *****************************************************************
       2002-TAIIN-COMMENT-SEC          SECTION.
      *
           MOVE       RECE84-REC       TO  RECE841-REC
           ADD     1                   TO  RECE841-MEISAISU
           WRITE      RECE841-REC
           ADD     1                   TO  CNT-RECE84
      *
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPID       TO  RECE85-HOSPID
           MOVE    RECE84-SRYYM        TO  RECE85-SRYYM
           MOVE    RECE84-NYUGAIKBN    TO  RECE85-NYUGAIKBN
           MOVE    RECE84-PTID         TO  RECE85-PTID
           MOVE    RECE84-RECEKA       TO  RECE85-RECEKA
           MOVE    RECE84-HKNID        TO  RECE85-HKNID
           MOVE    RECE84-TEKSTYMD     TO  RECE85-TEKSTYMD
           MOVE    RECE84-ZAINUM       TO  RECE85-ZAINUM
           START   RECE85-FILE
                 KEY IS    >=   RECE85-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE85
                 NOT INVALID
                     PERFORM 990-RECE85-NEXT-SEC
           END-START
      *
           MOVE    RECE85-REC       TO      RECE851-REC
           MOVE    RECE85-SRYACTINF(1)  TO  RECE851-SRYACTINF(1)
           MOVE    RECE85-SRYACTINF(2)  TO  RECE851-SRYACTINF(3)
           MOVE    RECE85-SRYACTINF(3)  TO  RECE851-SRYACTINF(4)
           MOVE    RECE85-SRYACTINF(4)  TO  RECE851-SRYACTINF(5)
           MOVE    RECE85-NAMEINF(1)    TO  RECE851-NAMEINF(1)
           MOVE    RECE85-NAMEINF(2)    TO  RECE851-NAMEINF(3)
           MOVE    RECE85-NAMEINF(3)    TO  RECE851-NAMEINF(4)
           MOVE    RECE85-NAMEINF(4)    TO  RECE851-NAMEINF(5)
           MOVE    RECE85-SIKFLGINF(1)  TO  RECE851-SIKFLGINF(1)
           MOVE    RECE85-SIKFLGINF(2)  TO  RECE851-SIKFLGINF(3)
           MOVE    RECE85-SIKFLGINF(3)  TO  RECE851-SIKFLGINF(4)
           MOVE    RECE85-SIKFLGINF(4)  TO  RECE851-SIKFLGINF(5)
           MOVE    RECE85-DATAKBNINF(1) TO  RECE851-DATAKBNINF(1)
           MOVE    RECE85-DATAKBNINF(2) TO  RECE851-DATAKBNINF(3)
           MOVE    RECE85-DATAKBNINF(3) TO  RECE851-DATAKBNINF(4)
           MOVE    RECE85-DATAKBNINF(4) TO  RECE851-DATAKBNINF(5)
           MOVE    RECE85-HOUKNSKBNINF(1) TO  RECE851-HOUKNSKBNINF(1)   XXX
           MOVE    RECE85-HOUKNSKBNINF(2) TO  RECE851-HOUKNSKBNINF(3)   XXX
           MOVE    RECE85-HOUKNSKBNINF(3) TO  RECE851-HOUKNSKBNINF(4)   XXX
           MOVE    RECE85-HOUKNSKBNINF(4) TO  RECE851-HOUKNSKBNINF(5)   XXX
           MOVE    RECE85-KNSJISKBNINF(1) TO  RECE851-KNSJISKBNINF(1)   XXX
           MOVE    RECE85-KNSJISKBNINF(2) TO  RECE851-KNSJISKBNINF(3)   XXX
           MOVE    RECE85-KNSJISKBNINF(3) TO  RECE851-KNSJISKBNINF(4)   XXX
           MOVE    RECE85-KNSJISKBNINF(4) TO  RECE851-KNSJISKBNINF(5)   XXX
           MOVE    RECE85-CDKBNINF(1)   TO  RECE851-CDKBNINF(1)         XXX
           MOVE    RECE85-CDKBNINF(2)   TO  RECE851-CDKBNINF(3)         XXX
           MOVE    RECE85-CDKBNINF(3)   TO  RECE851-CDKBNINF(4)         XXX
           MOVE    RECE85-CDKBNINF(4)   TO  RECE851-CDKBNINF(5)         XXX
      *
           MOVE    SPACE                TO  RECE851-SRYACTINF(2)
           INITIALIZE                       RECE851-SRYACTINF(2)
           MOVE    "810000001"          TO  RECE851-SRYCD(2)
           MOVE    ZERO                 TO  RECE851-SRYSURYO(2)
           MOVE    16                   TO  RECE851-YUKOKETA(2)
           MOVE    "薬剤管理指導料算定　　　月　　日"
                                        TO  RECE851-NAME(2)
           MOVE     WRK-TUKI-YAKUKAN    TO  DAY-IDX
           MOVE     TBL-DAY(DAY-IDX)    TO  RECE851-NAME(2)(21:4)
           MOVE     WRK-DAY-YAKUKAN     TO  DAY-IDX
           MOVE     TBL-DAY(DAY-IDX)    TO  RECE851-NAME(2)(27:4)
      *
           MOVE     "1"                 TO  RECE851-SIKFLG(2)
      *
           WRITE    RECE851-REC
           ADD      1                   TO  CNT-RECE85
      *
           .
       2002-TAIIN-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日のコメントがあるか判定
      *****************************************************************
       2001-SHUJUTSU-HANTEI-SEC          SECTION.
      *
           IF     RECE84-FLG-SHUJUTU-COMMENT   =    SPACE
               MOVE       1       TO     FLG-COMMENT
               PERFORM    2002-SHUJUTSU-ETC2-COMMENT-SEC
           ELSE
               PERFORM    2009-RECE84-WRITE-SEC
           END-IF
      *
           .
       2001-SHUJUTSU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＴ・ＭＲＩがあるか判定
      *****************************************************************
       2001-CTMRI-HANTEI-SEC          SECTION.
      *
           IF      RECE84-FLG-CTMRI-COMMENT   =    "1"
                MOVE       2       TO     FLG-COMMENT
                PERFORM    2002-SHUJUTSU-ETC2-COMMENT-SEC
           ELSE
                PERFORM    2009-RECE84-WRITE-SEC
           END-IF
      *
           .
       2001-CTMRI-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント編集２
      *****************************************************************
       2002-SHUJUTSU-ETC2-COMMENT-SEC          SECTION.
      *
           PERFORM   2003-SANTEI-DAY-SEC
      *
           MOVE       ZERO       TO   IDZ                               
           INITIALIZE            WRK-FREE-AREA2                         
      *
           PERFORM  2003-FREE-COMMENT-SEC                              
      *
      *    ※明細が５以上の場合
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPID       TO  RECE85-HOSPID
           MOVE    RECE84-SRYYM        TO  RECE85-SRYYM
           MOVE    RECE84-NYUGAIKBN    TO  RECE85-NYUGAIKBN
           MOVE    RECE84-PTID         TO  RECE85-PTID
           MOVE    RECE84-RECEKA       TO  RECE85-RECEKA
           MOVE    RECE84-HKNID        TO  RECE85-HKNID
           MOVE    RECE84-TEKSTYMD     TO  RECE85-TEKSTYMD
           MOVE    RECE84-ZAINUM       TO  RECE85-ZAINUM
           START   RECE85-FILE
                 KEY IS    >=   RECE85-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE85
                 NOT INVALID
                     PERFORM 990-RECE85-NEXT-SEC
                     MOVE    RECE85-REC  TO  WRK-RECE85-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                 TO  IDX-RECE85
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-SIKFLGINF-AREA
           INITIALIZE                       WRK-SIKFLGINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
           MOVE    SPACE                TO  WRK-HOUKNSKBNINF-AREA       XXX
           INITIALIZE                       WRK-HOUKNSKBNINF-AREA       XXX
           MOVE    SPACE                TO  WRK-KNSJISKBNINF-AREA       XXX
           INITIALIZE                       WRK-KNSJISKBNINF-AREA       XXX
           MOVE    SPACE                TO  WRK-CDKBNINF-AREA           XXX
           INITIALIZE                       WRK-CDKBNINF-AREA           XXX
      *
           MOVE    SPACE               TO  COM-RECE85-REC
           INITIALIZE                      COM-RECE85-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                ADD    1                  TO  IDX-RECE85
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE    "1"               TO  COM-SIKFLG(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF(IDX-RECE85)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(IDX-RECE85)
                MOVE   COM-SIKFLGINF(1)   TO  WRK-SIKFLGINF(IDX-RECE85)
           END-PERFORM 
      *
           PERFORM
             UNTIL  ( FLG-RECE85           =   1                   )
             OR     ( RECE84-HOSPID    NOT =   RECE85-HOSPID       )
             OR     ( RECE84-SRYYM     NOT =   RECE85-SRYYM        )
             OR     ( RECE84-NYUGAIKBN NOT =   RECE85-NYUGAIKBN    )
             OR     ( RECE84-PTID      NOT =   RECE85-PTID         )
             OR     ( RECE84-RECEKA    NOT =   RECE85-RECEKA       )
             OR     ( RECE84-HKNID     NOT =   RECE85-HKNID        )
             OR     ( RECE84-TEKSTYMD  NOT =   RECE85-TEKSTYMD     )
             OR     ( RECE84-ZAINUM    NOT =   RECE85-ZAINUM       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE85-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE85
                  MOVE   RECE85-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE85)
                  MOVE   RECE85-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE85)
                  MOVE   RECE85-SIKFLGINF(IDX)   TO
                                           WRK-SIKFLGINF(IDX-RECE85)     
                  MOVE   RECE85-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE85)
                  MOVE   RECE85-HOUKNSKBNINF(IDX) TO                    XXX
                                           WRK-HOUKNSKBNINF(IDX-RECE85) XXX
                  MOVE   RECE85-KNSJISKBNINF(IDX) TO                    XXX
                                           WRK-KNSJISKBNINF(IDX-RECE85) XXX
                  MOVE   RECE85-CDKBNINF(IDX) TO                        XXX
                                           WRK-CDKBNINF(IDX-RECE85)     XXX
             END-PERFORM 
      *
             PERFORM 990-RECE85-NEXT-SEC
      *
           END-PERFORM
      *
      *    手術日コメントを含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE85
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE85
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE85  =    1
      *
                  INITIALIZE                        RECE851-REC
                  MOVE    WRK-RECE85-KEY       TO   RECE851-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE851-RENNUM
                  MOVE    WRK-RECE85-PTNUM     TO   RECE851-PTNUM
                  MOVE    WRK-RECE85-SRYKA     TO   RECE851-SRYKA
                  MOVE    WRK-RECE85-SRYKBN    TO   RECE851-SRYKBN
                  MOVE    WRK-RECE85-SRYSYUKBN TO   RECE851-SRYSYUKBN
                  MOVE    WRK-RECE85-JIHIMONEY TO   RECE851-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE85   =   1)
                     ADD         1             TO    IDX-RECE85
                     IF  WK-RECE85-SRYCD(IDX-RECE85) = SPACE
                         MOVE    1             TO    FLG-WRKRECE85
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE85)
                                          TO   RECE851-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE85)
                                          TO   RECE851-NAMEINF(IDX)
                         MOVE  WRK-SIKFLGINF(IDX-RECE85)
                                          TO   RECE851-SIKFLGINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE85)
                                          TO   RECE851-DATAKBNINF(IDX)
                         MOVE  WRK-HOUKNSKBNINF(IDX-RECE85)             XXX
                                        TO   RECE851-HOUKNSKBNINF(IDX)  XXX
                         MOVE  WRK-KNSJISKBNINF(IDX-RECE85)             XXX
                                        TO   RECE851-KNSJISKBNINF(IDX)  XXX
                         MOVE  WRK-CDKBNINF(IDX-RECE85)                 XXX
                                        TO   RECE851-CDKBNINF(IDX)      XXX
      *
                         IF    WRK-SIKFLGINF(IDX-RECE85)  =  "1"
                              ADD    1    TO   WRK-CNT-MEISAI
                         END-IF    
      *
                     END-IF  
                  END-PERFORM
                  WRITE   RECE851-REC
                  ADD     1                    TO  CNT-RECE85
           END-PERFORM     
      *
           MOVE    RECE84-REC        TO      RECE841-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE841-MEISAISU
           WRITE   RECE841-REC
           ADD     1                 TO      CNT-RECE84
      *
           .
       2002-SHUJUTSU-ETC2-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    リハビリのコメント編集
      *****************************************************************
       2001-RIHA-COMMENT-SEC          SECTION.
      *
           MOVE    RECE84-REC        TO      RECE841-REC
           ADD     1                 TO      RECE841-MEISAISU
           WRITE   RECE841-REC
           ADD     1                 TO      CNT-RECE84
      *
      *      ※明細が５以上の場合
             INITIALIZE                      RECE85-REC
             MOVE    RECE84-HOSPID       TO  RECE85-HOSPID
             MOVE    RECE84-SRYYM        TO  RECE85-SRYYM
             MOVE    RECE84-NYUGAIKBN    TO  RECE85-NYUGAIKBN
             MOVE    RECE84-PTID         TO  RECE85-PTID
             MOVE    RECE84-RECEKA       TO  RECE85-RECEKA
             MOVE    RECE84-HKNID        TO  RECE85-HKNID
             MOVE    RECE84-TEKSTYMD     TO  RECE85-TEKSTYMD
             MOVE    RECE84-ZAINUM       TO  RECE85-ZAINUM
             START   RECE85-FILE
                 KEY IS    >=   RECE85-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE85
                 NOT INVALID
                     PERFORM 990-RECE85-NEXT-SEC
                     MOVE    RECE85-REC  TO  WRK-RECE85-REC
             END-START
      *
      *      ＲＥＣＥ０５ファイルの内容をテーブルに退避
             MOVE    ZERO                 TO  IDX-RECE85
             MOVE    SPACE                TO  WRK-SRYACTINF-AREA
             INITIALIZE                       WRK-SRYACTINF-AREA
             MOVE    SPACE                TO  WRK-NAMEINF-AREA
             INITIALIZE                       WRK-NAMEINF-AREA
             MOVE    SPACE                TO  WRK-SIKFLGINF-AREA
             INITIALIZE                       WRK-SIKFLGINF-AREA
             MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
             INITIALIZE                       WRK-DATAKBNINF-AREA
             MOVE    SPACE                TO  WRK-HOUKNSKBNINF-AREA     XXX
             INITIALIZE                       WRK-HOUKNSKBNINF-AREA     XXX
             MOVE    SPACE                TO  WRK-KNSJISKBNINF-AREA     XXX
             INITIALIZE                       WRK-KNSJISKBNINF-AREA     XXX
             MOVE    SPACE                TO  WRK-CDKBNINF-AREA         XXX
             INITIALIZE                       WRK-CDKBNINF-AREA         XXX
      *      リハビリコメントの挿入
      *      ADD     1                    TO  IDX-RECE85
             MOVE    SPACE                TO  COM-RECE85-REC
             INITIALIZE                       COM-RECE85-REC
             MOVE    "810000001"          TO  COM-SRYCD(1)
             MOVE    ZERO                 TO  COM-SRYSURYO(1)
             MOVE    7                    TO  COM-YUKOKETA(1)
             MOVE    "実施日数　　日"     TO  COM-NAME(1)
             MOVE    "1"                  TO  COM-SIKFLG(1) 
             MOVE    ZERO                 TO  CNT-RIHA
             EVALUATE   RECE84-ZAINUM
                 WHEN   WRK-RIGA1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-SHU(IDX) NOT = SPACE
                                ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   OTHER
                        CONTINUE
             END-EVALUATE
             IF      CNT-RIHA             NOT =    ZERO
               MOVE    CNT-RIHA             TO  DAY-IDX
               MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(9:4)
               COMPUTE  MAX-MEISAISU        =   RECE84-MEISAISU  +  1
               MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                     (MAX-MEISAISU)
               MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                     (MAX-MEISAISU)
               MOVE    COM-SIKFLGINF(1)     TO  WRK-SIKFLGINF
                                                     (MAX-MEISAISU)
             END-IF
      *
             PERFORM
               UNTIL  ( FLG-RECE85           =   1                   )
               OR     ( RECE84-HOSPID    NOT =   RECE85-HOSPID       )
               OR     ( RECE84-SRYYM     NOT =   RECE85-SRYYM        )
               OR     ( RECE84-NYUGAIKBN NOT =   RECE85-NYUGAIKBN    )
               OR     ( RECE84-PTID      NOT =   RECE85-PTID         )
               OR     ( RECE84-RECEKA    NOT =   RECE85-RECEKA       )
               OR     ( RECE84-HKNID     NOT =   RECE85-HKNID        )
               OR     ( RECE84-TEKSTYMD  NOT =   RECE85-TEKSTYMD     )
               OR     ( RECE84-ZAINUM    NOT =   RECE85-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE85-SRYCD(IDX) =   SPACE )
                    ADD    1             TO      IDX-RECE85
                    MOVE   RECE85-SRYACTINF(IDX) TO
                                             WRK-SRYACTINF(IDX-RECE85)
                    MOVE   RECE85-NAMEINF(IDX)   TO
                                             WRK-NAMEINF(IDX-RECE85)
                    MOVE   RECE85-SIKFLGINF(IDX)   TO
                                             WRK-SIKFLGINF(IDX-RECE85)     
                    MOVE   RECE85-DATAKBNINF(IDX) TO
                                             WRK-DATAKBNINF(IDX-RECE85)
                    MOVE   RECE85-HOUKNSKBNINF(IDX) TO                  XXX
                                           WRK-HOUKNSKBNINF(IDX-RECE85) XXX
                    MOVE   RECE85-KNSJISKBNINF(IDX) TO                  XXX
                                           WRK-KNSJISKBNINF(IDX-RECE85) XXX
                    MOVE   RECE85-CDKBNINF(IDX) TO                      XXX
                                           WRK-CDKBNINF(IDX-RECE85)     XXX
               END-PERFORM 
      *
               PERFORM 990-RECE85-NEXT-SEC
      *
             END-PERFORM
      *
      *      リハビリコメントを含んだ内容で中間ファイルの再作成
             MOVE       ZERO             TO      FLG-WRKRECE85
             MOVE       ZERO             TO      IDX
             MOVE       ZERO             TO      IDX-RECE85
             MOVE       ZERO             TO      WRK-RENNUM
             PERFORM    UNTIL     FLG-WRKRECE85  =    1
                    INITIALIZE                        RECE851-REC
                    MOVE    WRK-RECE85-KEY       TO   RECE851-KEY
                    ADD     1                    TO   WRK-RENNUM
                    MOVE    WRK-RENNUM           TO   RECE851-RENNUM
                    MOVE    WRK-RECE85-PTNUM     TO   RECE851-PTNUM
                    MOVE    WRK-RECE85-SRYKA     TO   RECE851-SRYKA
                    MOVE    WRK-RECE85-SRYKBN    TO   RECE851-SRYKBN
                    MOVE    WRK-RECE85-SRYSYUKBN TO   RECE851-SRYSYUKBN
                    MOVE    WRK-RECE85-JIHIMONEY TO   RECE851-JIHIMONEY
                    PERFORM  VARYING   IDX   FROM   1   BY   1
                             UNTIL   (IDX       >    5)   OR
                                     (FLG-WRKRECE85   =   1)
                       ADD         1             TO    IDX-RECE85
                       IF  WK-RECE85-SRYCD(IDX-RECE85) = SPACE
                           MOVE    1             TO    FLG-WRKRECE85
                       ELSE
                           MOVE  WRK-SRYACTINF(IDX-RECE85)
                                            TO   RECE851-SRYACTINF(IDX)  
                           MOVE  WRK-NAMEINF(IDX-RECE85)
                                            TO   RECE851-NAMEINF(IDX)
                           MOVE  WRK-SIKFLGINF(IDX-RECE85)
                                            TO   RECE851-SIKFLGINF(IDX)
                           MOVE  WRK-DATAKBNINF(IDX-RECE85)
                                        TO   RECE851-DATAKBNINF(IDX)
                           MOVE  WRK-HOUKNSKBNINF(IDX-RECE85)           XXX
                                        TO   RECE851-HOUKNSKBNINF(IDX)  XXX
                           MOVE  WRK-KNSJISKBNINF(IDX-RECE85)           XXX
                                        TO   RECE851-KNSJISKBNINF(IDX)  XXX
                           MOVE  WRK-CDKBNINF(IDX-RECE85)               XXX
                                        TO   RECE851-CDKBNINF(IDX)      XXX
                       END-IF  
                    END-PERFORM
                    WRITE   RECE851-REC
                    ADD     1                    TO  CNT-RECE85
             END-PERFORM     
      *
           .
       2001-RIHA-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊日のコメント編集
      *    精神科隔離病室管理加算（入院料加算）のコメント編集
      *****************************************************************
       2001-NYU-COMMENT-SEC          SECTION.
      *
           PERFORM     2002-NYU-DAY-SEC
      *
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPID       TO  RECE85-HOSPID
           MOVE    RECE84-SRYYM        TO  RECE85-SRYYM
           MOVE    RECE84-NYUGAIKBN    TO  RECE85-NYUGAIKBN
           MOVE    RECE84-PTID         TO  RECE85-PTID
           MOVE    RECE84-RECEKA       TO  RECE85-RECEKA
           MOVE    RECE84-HKNID        TO  RECE85-HKNID
           MOVE    RECE84-TEKSTYMD     TO  RECE85-TEKSTYMD
           MOVE    RECE84-ZAINUM       TO  RECE85-ZAINUM
           START   RECE85-FILE
                 KEY IS    >=   RECE85-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE85
                 NOT INVALID
                     PERFORM 990-RECE85-NEXT-SEC
                     MOVE    RECE85-REC  TO  WRK-RECE85-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                 TO  IDX-RECE85
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-SIKFLGINF-AREA
           INITIALIZE                       WRK-SIKFLGINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
           MOVE    SPACE                TO  WRK-HOUKNSKBNINF-AREA       XXX
           INITIALIZE                       WRK-HOUKNSKBNINF-AREA       XXX
           MOVE    SPACE                TO  WRK-KNSJISKBNINF-AREA       XXX
           INITIALIZE                       WRK-KNSJISKBNINF-AREA       XXX
           MOVE    SPACE                TO  WRK-CDKBNINF-AREA           XXX
           INITIALIZE                       WRK-CDKBNINF-AREA           XXX
      *
           MOVE    RECE84-MEISAISU      TO  MAX-MEISAISU
      *
      *    算定日コメントの挿入
           PERFORM  VARYING      IDX    FROM  1   BY   1
                    UNTIL       (IDX    >     31)      OR
                                (TBL-NYU-DAY-ST(IDX)  =  ZERO)
      *        ADD     1                    TO  IDX-RECE85
               COMPUTE  MAX-MEISAISU        =   MAX-MEISAISU  +  1
               MOVE    SPACE                TO  COM-RECE85-REC
               INITIALIZE                       COM-RECE85-REC
               MOVE    TBL-NYU-DAY-CD(IDX)  TO  COM-SRYCD(1)
               MOVE    ZERO                 TO  COM-SRYSURYO(1)
               IF    TBL-NYU-DAY-CD(IDX)  =  CONS-SANTEI-COMMENT1
                 MOVE    4                  TO  COM-YUKOKETA(1)
                 MOVE    "　　　日"         TO  COM-NAME(1)
                 MOVE    TBL-NYU-DAY-ST(IDX) 
                                            TO  DAY-IDX
                 MOVE    TBL-DAY(DAY-IDX)   TO  COM-NAME(1)(3:4)
               ELSE
                 MOVE    8                  TO  COM-YUKOKETA(1)
                 MOVE    "　　　日〜　　日" TO  COM-NAME(1)
                 MOVE    TBL-NYU-DAY-ST(IDX) 
                                            TO  DAY-IDX
                 MOVE    TBL-DAY(DAY-IDX)   TO  COM-NAME(1)(3:4)
                 MOVE    TBL-NYU-DAY-ED(IDX) 
                                            TO  DAY-IDX
                 MOVE    TBL-DAY(DAY-IDX)   TO  COM-NAME(1)(11:4)
               END-IF
               MOVE    "1"                  TO  COM-SIKFLG(1) 
               MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                     (MAX-MEISAISU)
               MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                     (MAX-MEISAISU)
               MOVE    COM-SIKFLGINF(1)     TO  WRK-SIKFLGINF
                                                     (MAX-MEISAISU)
           END-PERFORM
      *
           PERFORM
             UNTIL  ( FLG-RECE85           =   1                   )
             OR     ( RECE84-HOSPID    NOT =   RECE85-HOSPID       )
             OR     ( RECE84-SRYYM     NOT =   RECE85-SRYYM        )
             OR     ( RECE84-NYUGAIKBN NOT =   RECE85-NYUGAIKBN    )
             OR     ( RECE84-PTID      NOT =   RECE85-PTID         )
             OR     ( RECE84-RECEKA    NOT =   RECE85-RECEKA       )
             OR     ( RECE84-TEKSTYMD  NOT =   RECE85-TEKSTYMD     )
             OR     ( RECE84-ZAINUM    NOT =   RECE85-ZAINUM       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE85-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE85
                  MOVE   RECE85-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE85)
                  MOVE   RECE85-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE85)     
                  MOVE   RECE85-SIKFLGINF(IDX) TO
                                           WRK-SIKFLGINF(IDX-RECE85)  
                  MOVE   RECE85-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE85)
                  MOVE   RECE85-HOUKNSKBNINF(IDX) TO                    XXX
                                           WRK-HOUKNSKBNINF(IDX-RECE85) XXX
                  MOVE   RECE85-KNSJISKBNINF(IDX) TO                    XXX
                                           WRK-KNSJISKBNINF(IDX-RECE85) XXX
                  MOVE   RECE85-CDKBNINF(IDX) TO                        XXX
                                           WRK-CDKBNINF(IDX-RECE85)     XXX
             END-PERFORM 
      *
             PERFORM 990-RECE85-NEXT-SEC
      *
           END-PERFORM
      *
      *    算定日コメントを含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE85
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE85
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE85  =    1
                  INITIALIZE                        RECE851-REC
                  MOVE    WRK-RECE85-KEY       TO   RECE851-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE851-RENNUM
                  MOVE    WRK-RECE85-PTNUM     TO   RECE851-PTNUM
                  MOVE    WRK-RECE85-SRYKA     TO   RECE851-SRYKA
                  MOVE    WRK-RECE85-SRYKBN    TO   RECE851-SRYKBN
                  MOVE    WRK-RECE85-SRYSYUKBN TO   RECE851-SRYSYUKBN
                  MOVE    WRK-RECE85-JIHIMONEY TO   RECE851-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE85   =   1)
                     ADD         1             TO    IDX-RECE85
                     IF  WK-RECE85-SRYCD(IDX-RECE85) = SPACE
                         MOVE    1             TO    FLG-WRKRECE85
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE85)
                                          TO   RECE851-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE85)
                                          TO   RECE851-NAMEINF(IDX)
                         MOVE  WRK-SIKFLGINF(IDX-RECE85)
                                          TO   RECE851-SIKFLGINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE85)
                                        TO   RECE851-DATAKBNINF(IDX)
                         MOVE  WRK-HOUKNSKBNINF(IDX-RECE85)             XXX
                                        TO   RECE851-HOUKNSKBNINF(IDX)  XXX
                         MOVE  WRK-KNSJISKBNINF(IDX-RECE85)             XXX
                                        TO   RECE851-KNSJISKBNINF(IDX)  XXX
                         MOVE  WRK-CDKBNINF(IDX-RECE85)                 XXX
                                        TO   RECE851-CDKBNINF(IDX)      XXX
      *
                         IF    WRK-SIKFLGINF(IDX-RECE85)  =  "1"
                              ADD    1    TO   WRK-CNT-MEISAI
                         END-IF    
                     END-IF  
                  END-PERFORM
                  WRITE   RECE851-REC
                  ADD     1                    TO  CNT-RECE85
           END-PERFORM     
      *
           MOVE    RECE84-REC        TO      RECE841-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE841-MEISAISU
           WRITE   RECE841-REC
           ADD     1                 TO      CNT-RECE84
      *
           .
       2001-NYU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊日の確定
      *    精神科隔離病室管理加算日（入院料加算）の確定
      *****************************************************************
       2002-NYU-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-NYU-DAY
      *
           MOVE    ZERO          TO  DAY-IDX
           MOVE    ZERO          TO  FLG-NYU-RENZOKU
      *
           PERFORM    VARYING    IDX  FROM   1   BY   1
                      UNTIL     (IDX      >   31)  OR
                                (DAY-IDX  >   31)
                IF    RECE84-KAISU(1 IDX)   =  ZERO
                      MOVE  ZERO  TO  FLG-NYU-RENZOKU
                ELSE
                      IF    FLG-NYU-RENZOKU  =  ZERO
                         ADD   1     TO  DAY-IDX
                         MOVE  IDX   TO  TBL-NYU-DAY-ST(DAY-IDX)
                      END-IF
                      MOVE  IDX      TO  TBL-NYU-DAY-ED(DAY-IDX)
                      MOVE  1        TO  FLG-NYU-RENZOKU
                END-IF
           END-PERFORM
      *
           PERFORM    VARYING    DAY-IDX  FROM   1   BY   1
                      UNTIL  (DAY-IDX                      >   31)  OR
                             (TBL-NYU-DAY-ST(DAY-IDX)  = ZERO)
                IF    TBL-NYU-DAY-ST(DAY-IDX) 
                                    =   TBL-NYU-DAY-ED(DAY-IDX)
                      MOVE  CONS-SANTEI-COMMENT1
                                    TO  TBL-NYU-DAY-CD(DAY-IDX)
                ELSE
                      MOVE  CONS-SANTEI-COMMENT2
                                    TO  TBL-NYU-DAY-CD(DAY-IDX)
                END-IF
           END-PERFORM
      *
           .
       2002-NYU-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    精神科隔離病室管理加算（入院料加算）があるか判定
      *    （診療行為入力）
      *****************************************************************
       2001-KAKURI-HANTEI-SEC          SECTION.
      *
           IF      RECE84-FLG-KAKURI-COMMENT    =    "1"
               MOVE       99      TO     FLG-COMMENT
               PERFORM   2001-NYU-COMMENT-SEC
           END-IF
      *
           .
       2001-KAKURI-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災治療計画加算（入院料加算）があるか判定
      *    （診療行為入力）
      *****************************************************************
       2001-CHIRYO-HANTEI-SEC          SECTION.
      *
           IF      RECE84-FLG-CHIRYO-COMMENT    =    "1"
               MOVE       99      TO     FLG-COMMENT
               PERFORM   2002-CHIRYO-COMMENT-SEC
           END-IF
      *
           .
       2001-CHIRYO-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災治療計画加算のコメント編集
      *****************************************************************
       2002-CHIRYO-COMMENT-SEC          SECTION.
      *
           PERFORM    2003-SANTEI-DAY-SEC
      *
           MOVE       RECE84-REC       TO  RECE841-REC
           ADD     1                   TO  RECE841-MEISAISU
           WRITE      RECE841-REC
           ADD     1                   TO  CNT-RECE84
      *
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPID       TO  RECE85-HOSPID
           MOVE    RECE84-SRYYM        TO  RECE85-SRYYM
           MOVE    RECE84-NYUGAIKBN    TO  RECE85-NYUGAIKBN
           MOVE    RECE84-PTID         TO  RECE85-PTID
           MOVE    RECE84-RECEKA       TO  RECE85-RECEKA
           MOVE    RECE84-HKNID        TO  RECE85-HKNID
           MOVE    RECE84-TEKSTYMD     TO  RECE85-TEKSTYMD
           MOVE    RECE84-ZAINUM       TO  RECE85-ZAINUM
           START   RECE85-FILE
                 KEY IS    >=   RECE85-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE85
                 NOT INVALID
                     PERFORM 990-RECE85-NEXT-SEC
           END-START
      *
           MOVE    RECE85-REC       TO      RECE851-REC
           MOVE    RECE85-SRYACTINF(1)  TO  RECE851-SRYACTINF(1)
           MOVE    RECE85-SRYACTINF(2)  TO  RECE851-SRYACTINF(3)
           MOVE    RECE85-SRYACTINF(3)  TO  RECE851-SRYACTINF(4)
           MOVE    RECE85-SRYACTINF(4)  TO  RECE851-SRYACTINF(5)
           MOVE    RECE85-NAMEINF(1)    TO  RECE851-NAMEINF(1)
           MOVE    RECE85-NAMEINF(2)    TO  RECE851-NAMEINF(3)
           MOVE    RECE85-NAMEINF(3)    TO  RECE851-NAMEINF(4)
           MOVE    RECE85-NAMEINF(4)    TO  RECE851-NAMEINF(5)
           MOVE    RECE85-SIKFLGINF(1)  TO  RECE851-SIKFLGINF(1)
           MOVE    RECE85-SIKFLGINF(2)  TO  RECE851-SIKFLGINF(3)
           MOVE    RECE85-SIKFLGINF(3)  TO  RECE851-SIKFLGINF(4)
           MOVE    RECE85-SIKFLGINF(4)  TO  RECE851-SIKFLGINF(5)
           MOVE    RECE85-DATAKBNINF(1) TO  RECE851-DATAKBNINF(1)
           MOVE    RECE85-DATAKBNINF(2) TO  RECE851-DATAKBNINF(3)
           MOVE    RECE85-DATAKBNINF(3) TO  RECE851-DATAKBNINF(4)
           MOVE    RECE85-DATAKBNINF(4) TO  RECE851-DATAKBNINF(5)
           MOVE    RECE85-HOUKNSKBNINF(1) TO  RECE851-HOUKNSKBNINF(1)   XXX
           MOVE    RECE85-HOUKNSKBNINF(2) TO  RECE851-HOUKNSKBNINF(3)   XXX
           MOVE    RECE85-HOUKNSKBNINF(3) TO  RECE851-HOUKNSKBNINF(4)   XXX
           MOVE    RECE85-HOUKNSKBNINF(4) TO  RECE851-HOUKNSKBNINF(5)   XXX
           MOVE    RECE85-KNSJISKBNINF(1) TO  RECE851-KNSJISKBNINF(1)   XXX
           MOVE    RECE85-KNSJISKBNINF(2) TO  RECE851-KNSJISKBNINF(3)   XXX
           MOVE    RECE85-KNSJISKBNINF(3) TO  RECE851-KNSJISKBNINF(4)   XXX
           MOVE    RECE85-KNSJISKBNINF(4) TO  RECE851-KNSJISKBNINF(5)   XXX
           MOVE    RECE85-CDKBNINF(1)   TO  RECE851-CDKBNINF(1)         XXX
           MOVE    RECE85-CDKBNINF(2)   TO  RECE851-CDKBNINF(3)         XXX
           MOVE    RECE85-CDKBNINF(3)   TO  RECE851-CDKBNINF(4)         XXX
           MOVE    RECE85-CDKBNINF(4)   TO  RECE851-CDKBNINF(5)         XXX
      *
           MOVE    SPACE                TO  RECE851-SRYACTINF(2)
           INITIALIZE                       RECE851-SRYACTINF(2)
           MOVE    "810000001"          TO  RECE851-SRYCD(2)
           MOVE    ZERO                 TO  RECE851-SRYSURYO(2)
           MOVE    9                    TO  RECE851-YUKOKETA(2)
           MOVE    "算定　　　月　　日" TO  RECE851-NAME(2)
           MOVE     RECE82-SRYYM(5:2)   TO  DAY-IDX2
           MOVE     TBL-DAY(DAY-IDX2)   TO  RECE851-NAME(2)(7:4)
           MOVE     TB-SANTEI-DAY(1)    TO  DAY-IDX2
           MOVE     TBL-DAY(DAY-IDX2)   TO  RECE851-NAME(2)(13:4)
      *
           MOVE     "1"                 TO  RECE851-SIKFLG(2)
      *
           WRITE    RECE851-REC
           ADD      1                   TO  CNT-RECE85
      *
           .
       2002-CHIRYO-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイル出力処理
      *****************************************************************
       2009-RECE84-WRITE-SEC      SECTION.
      *
           MOVE    RECE84-REC      TO  RECE841-REC
           WRITE   RECE841-REC
           ADD     1               TO  CNT-RECE84
      *
           PERFORM 20091-RECE85-TENSOU-SEC
           .
       2009-RECE84-WRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０５出力処理
      *****************************************************************
       20091-RECE85-TENSOU-SEC     SECTION.
      *
           INITIALIZE                      RECE85-REC
           MOVE    RECE84-HOSPID       TO  RECE85-HOSPID
           MOVE    RECE84-SRYYM        TO  RECE85-SRYYM
           MOVE    RECE84-NYUGAIKBN    TO  RECE85-NYUGAIKBN
           MOVE    RECE84-PTID         TO  RECE85-PTID
           MOVE    RECE84-RECEKA       TO  RECE85-RECEKA
           MOVE    RECE84-HKNID        TO  RECE85-HKNID
           MOVE    RECE84-TEKSTYMD     TO  RECE85-TEKSTYMD
           MOVE    RECE84-ZAINUM       TO  RECE85-ZAINUM
           START   RECE85-FILE
               KEY IS    >=   RECE85-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE85
               NOT INVALID
                   PERFORM 990-RECE85-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE85           =   1                   )
               OR     ( RECE84-HOSPID    NOT =   RECE85-HOSPID       )
               OR     ( RECE84-SRYYM     NOT =   RECE85-SRYYM        )
               OR     ( RECE84-NYUGAIKBN NOT =   RECE85-NYUGAIKBN    )
               OR     ( RECE84-PTID      NOT =   RECE85-PTID         )
               OR     ( RECE84-RECEKA    NOT =   RECE85-RECEKA       )
               OR     ( RECE84-HKNID     NOT =   RECE85-HKNID        )
               OR     ( RECE84-TEKSTYMD  NOT =   RECE85-TEKSTYMD     )
               OR     ( RECE84-ZAINUM    NOT =   RECE85-ZAINUM       )
      *
      *
               MOVE          RECE85-REC       TO      RECE851-REC
               WRITE         RECE851-REC
               ADD     1                 TO  CNT-RECE85
      *
               PERFORM 990-RECE85-NEXT-SEC
      *
           END-PERFORM
      *
           .
       20091-RECE85-TENSOU-EXT.
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
      *    ファイルＣＬＯＳＥ処理
           PERFORM 310-FILE-CLOSE-SEC
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
           DISPLAY "RECE82  IN  " CNT-RECE82  
           DISPLAY "RECE84  CNT " CNT-RECE84  
           DISPLAY "RECE85  CNT " CNT-RECE85  
           DISPLAY "*** ORCR0870 END ***"
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＣＬＯＳＥ処理
      *****************************************************************
       310-FILE-CLOSE-SEC              SECTION.
      *
           CLOSE                       RECE82-FILE
      *
           CLOSE                       RECE84-FILE
      *
           CLOSE                       RECE85-FILE
      *
           CLOSE                       RECE841-FILE     
           CLOSE                       RECE851-FILE     
      *
           .
       310-FILE-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       990-RECE82-READ-SEC           SECTION.
      *
           READ    RECE82-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
               NOT AT  END
                   ADD     1           TO  CNT-RECE82
                   ADD     1           TO  CNT-IN-COMMIT
                   MOVE    ZERO        TO  FLG-END
           END-READ
      *
           .
       990-RECE82-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０４データ読み
      ****************************************************************
       990-RECE84-NEXT-SEC           SECTION.
      *
           READ    RECE84-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE84
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE84
           END-READ
      *
           .
       990-RECE84-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０５データ読み
      ****************************************************************
       990-RECE85-NEXT-SEC           SECTION.
      *
           READ    RECE85-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE85
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE85
           END-READ
      *
           .
       990-RECE85-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスタ読み込み
      *****************************************************************
       900-SRYACT-READ-SEC         SECTION.
      *
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC         TO  SRYACT-REC
                   MOVE    ZERO                TO  FLG-SRYACT
               ELSE
                   MOVE    1                   TO  FLG-SRYACT
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SRYACT
           END-IF
      *
           MOVE    "DBCLOSE"         TO  MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
           .
       900-SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為読込
      *****************************************************************
       900-SRYACT-READ-NEXT-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       900-SRYACT-READ-NEXT-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       120-DBOPEN-SEC                SECTION.
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
       900-DBDISCONNECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　ＣＯＭＭＩＴ処理
      *****************************************************************
       900-DBCOMMIT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"          USING
                                        MCPAREA
                                        MCPDATA-REC.
      *
           .
       900-DBCOMMIT-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　ＳＴＡＲＴ処理
      *****************************************************************
       900-DBSTART-SEC                SECTION.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBSTART-EXT.
           EXIT.
