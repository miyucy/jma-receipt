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
       PROGRAM-ID.             ORCR0660.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト（入院）
      *  コンポーネント名  : レセプトコメント編集
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/12/13    NaCl-門脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-門脇    03.03.31  薬剤管理指導料の算定日編集
      *  01.00.02    NACL-門脇    03.04.04  入院栄養食事指導料の算定日編集
      *                                     退院前訪問指導料の算定日編集
      *                                     精神科退院前訪問指導料の算定日編集
      *                                     傷病手当金意見書交付料の交付日編集
      *                                     療養費同意書交付料の交付日編集
      *  01.00.03    NACL-門脇    03.04.08  退院時服薬指導加算算定時の
      *                                     前月薬剤管理指導料の算定日編集
      *  01.00.04    NACL-門脇    03.04.24  輸血はコメント編集対象外とする
      *  01.00.05    NACL-門脇    03.05.28  受診履歴キーの変更
      *  01.00.06    NACL-門脇    03.06.19  複数診療科受診の編集修正
      *  01.00.07    NACL-門脇    03.08.20  公費受診日のコメント編集
      *  01.00.08    NACL-門脇    03.09.24  コメント編集修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
           SELECT  RECE62-FILE     ASSIGN  RECE62PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE62-KEY
                                   FILE    STATUS  IS  STS-RECE62.
      *
           SELECT  RECE64-FILE     ASSIGN  RECE64PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE64-KEY
                                   FILE    STATUS  IS  STS-RECE64.
      *
           SELECT  RECE65-FILE     ASSIGN  RECE65PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE65-KEY
                                   FILE    STATUS  IS  STS-RECE65.
      *
           SELECT  RECE641-FILE    ASSIGN  RECE641PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE641-KEY
                                   FILE    STATUS  IS  STS-RECE641.
           SELECT  RECE6441-FILE   ASSIGN  RECE641PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE6441-KEY
                                   FILE    STATUS  IS  STS-RECE641.
      *
           SELECT  RECE651-FILE    ASSIGN  RECE651PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE651-KEY
                                   FILE    STATUS  IS  STS-RECE651.
           SELECT  RECE6551-FILE   ASSIGN  RECE651PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE6551-KEY
                                   FILE    STATUS  IS  STS-RECE651.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    レセプト０２データ
       FD  RECE62-FILE.
       01  RECE62-REC.
           COPY    "CPRCF062.INC".
      *
      *    レセプト０４データ
       FD  RECE64-FILE.
       01  RECE64-REC.
           COPY    "CPRCF064.INC".
      *
      *    レセプト０５データ
       FD  RECE65-FILE.
       01  RECE65-REC.
           COPY    "CPRCF065.INC".
      *
       FD  RECE641-FILE.
       01  RECE641-REC. 
           COPY    "CPRCF064.INC"  REPLACING   //RECE64//
                                   BY          //RECE641//.
      *
       FD  RECE651-FILE.
       01  RECE651-REC. 
           COPY    "CPRCF065.INC"  REPLACING   //RECE65//
                                   BY          //RECE651//.
      *
       FD  RECE6441-FILE.
       01  RECE6441-REC. 
           COPY    "CPRCF064.INC"  REPLACING   //RECE64//
                                   BY          //RECE6441//.
      *
       FD  RECE6551-FILE.
       01  RECE6551-REC. 
           COPY    "CPRCF065.INC"  REPLACING   //RECE65//
                                   BY          //RECE6551//.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE62//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE64//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE65//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE641//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE651//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
       01  SPA2-AREA.
           03  SPA-STS              PIC 9(04).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE62          PIC X(02).
           03  STS-RECE64          PIC X(02).
           03  STS-RECE641         PIC X(02).
           03  STS-RECE65          PIC X(02).
           03  STS-RECE651         PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE62          PIC 9(01).
           03  FLG-RECE64          PIC 9(01).
           03  FLG-RECE65          PIC 9(01).
           03  FLG-YAKUKAN-COMMENT PIC 9(01).
           03  FLG-COMMENT         PIC 9(02).
           03  FLG-WRKRECE65       PIC 9(01).
           03  FLG-FIRST           PIC 9(01).
           03  FLG-ARI             PIC 9(01).
           03  FLG-NYU-RENZOKU     PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE62          PIC 9(06).
           03  CNT-RECE64          PIC 9(06).
           03  CNT-RECE65          PIC 9(06).
           03  CNT-RIHA            PIC 9(06).
           03  CNT-IN-COMMIT       PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  DAY-IDX             PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDY2                PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX-RECE65          PIC 9(04).
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
           03  WRK-KOHBUNRI        PIC 9(01).
           03  WRK-RECEERR         PIC X(200).
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
           03  WRK-TUKI-YAKUKAN      PIC 9(02).
           03  WRK-DAY-YAKUKAN       PIC 9(02).
      *
       01  WRK-RECE64-REC. 
           COPY    "CPRCF064.INC"  REPLACING   //RECE64//
                                   BY          //WRK-RECE64//.
      *
       01  WRK-RECE65-REC. 
           COPY    "CPRCF065.INC"  REPLACING   //RECE65//
                                   BY          //WRK-RECE65//.
      *
       01  COM-RECE65-REC. 
           COPY    "CPRCF065.INC"  REPLACING   //RECE65//
                                   BY          //COM//.
      *
       01  WRK-SRYACTINF-AREA.
           03  WRK-SRYACTINF                   OCCURS  50.
               05  WK-RECE65-SRYCD           PIC  X(09).
               05  WK-RECE65-SRYSURYO        PIC  9(05)V9(03).
               05  WK-RECE65-SRYKAISU        PIC  9(03).
               05  WK-RECE65-TANICD          PIC  9(03).
               05  WK-RECE65-TANIMOJISU      PIC  9(01).
               05  WK-RECE65-TANINAME        PIC  X(24).
               05  WK-RECE65-TENSIKIBETU     PIC  9(01).
               05  WK-RECE65-TEN             PIC  9(09)V9(02).
               05  WK-RECE65-MEISKYFLG       PIC  X(01).
               05  WK-RECE65-AUTOKBN         PIC  X(01).
               05  WK-RECE65-INPUTNUM        PIC  9(03).
               05  WK-RECE65-TENTTLKBN       PIC  9(03).
      *
       01  WRK-NAMEINF-AREA.
           03  WRK-NAMEINF                     OCCURS 50.         
               05  WK-RECE65-YUKOKETA        PIC  9(02).
               05  WK-RECE65-NAME            PIC  X(200).
      *
       01  WRK-DATAKBNINF-AREA.
           03  WRK-DATAKBNINF                  OCCURS 50.         
               05  WK-RECE65-DATAKBN         PIC  9(01).
      *
       01  WRK-FREE-AREA2.                                              
           03  WRK-FREEINF2                    OCCURS 50.               
               05  WK-FREE-YUKOKETA2         PIC  9(02).                
               05  WK-FREE-NAME2             PIC  X(200).               
      *
      *理学療法剤番号退避領域
       01  WRK-TAIHI-ZAINUM.
           03  WRK-TAIHI-ZAINUM-T              OCCURS  5.
               05  WRK-RIGA1-SHU-ZAINUM      PIC  9(08).   
               05  WRK-RIGA1-KO-ZAINUM       PIC  9(08).   
               05  WRK-RIGA2-SHU-ZAINUM      PIC  9(08).   
               05  WRK-RIGA2-KO-ZAINUM       PIC  9(08).   
               05  WRK-RIGA3-SHU-ZAINUM      PIC  9(08).   
               05  WRK-RIGA3-KO-ZAINUM       PIC  9(08).   
               05  WRK-RIGA4-SHU-ZAINUM      PIC  9(08).   
               05  WRK-RIGA4-KO-ZAINUM       PIC  9(08).   
               05  WRK-SAGYO1-SHU-ZAINUM     PIC  9(08).   
               05  WRK-SAGYO2-SHU-ZAINUM     PIC  9(08).   
               05  WRK-SAGYO1-KO-ZAINUM      PIC  9(08).   
               05  WRK-SAGYO2-KO-ZAINUM      PIC  9(08).   
               05  WRK-GENGO1-SHU-ZAINUM     PIC  9(08).   
               05  WRK-GENGO1-KO-ZAINUM      PIC  9(08).   
               05  WRK-GENGO2-SHU-ZAINUM     PIC  9(08).   
               05  WRK-GENGO2-KO-ZAINUM      PIC  9(08).   
      *
       01  WRK-TAIHI-ZAINUM-R     REDEFINES   WRK-TAIHI-ZAINUM.
           03  WRK-RIHA-ZAINUM-T               OCCURS  5.
               05  WRK-RIHA-ZAINUM   PIC 9(08)   OCCURS   16.       
      *
      *理学療法実施カレンダー
       01  WRK-RIGAKU-AREA.
           03  WRK-RIGAKU-T                    OCCURS  5.
             05  WRK-RIGA1-SHU                 PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA1-KO                  PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA2-SHU                 PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA2-KO                  PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA3-SHU                 PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA3-KO                  PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA4-SHU                 PIC  X(01)  OCCURS 31.   
             05  WRK-RIGA4-KO                  PIC  X(01)  OCCURS 31.   
             05  WRK-SAGYO1-SHU                PIC  X(01)  OCCURS 31.   
             05  WRK-SAGYO2-SHU                PIC  X(01)  OCCURS 31.   
             05  WRK-SAGYO1-KO                 PIC  X(01)  OCCURS 31.   
             05  WRK-SAGYO2-KO                 PIC  X(01)  OCCURS 31.   
             05  WRK-GENGO1-SHU                PIC  X(01)  OCCURS 31.   
             05  WRK-GENGO1-KO                 PIC  X(01)  OCCURS 31.   
             05  WRK-GENGO2-SHU                PIC  X(01)  OCCURS 31.   
             05  WRK-GENGO2-KO                 PIC  X(01)  OCCURS 31.   
      *
       01  WRK-RIGAKU-R        REDEFINES     WRK-RIGAKU-AREA.
           02  WRK-RIGAKU-OCC                  OCCURS    5.
             03  WRK-RIGAKU-OCC2               OCCURS   16.
               04  WRK-RIGAKU-OCC3             OCCURS   31.
                 05  WRK-RIGAKU                PIC  X(01).
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
           03  CONS-YAKUKAN-COMMENT PIC X(09)  VALUE "120001610".
      *    算定日コメント
           03  CONS-SANTEI-COMMENT1  PIC X(09) VALUE "840000058".
           03  CONS-SANTEI-COMMENT2  PIC X(09) VALUE "840000065".
      *
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
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
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
                   UNTIL   SPA-STS  =   2
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
           INITIALIZE                  SPA2-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
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
           MOVE    "ORCR0660"      TO  JOB-PGID
           MOVE    "コメント編集"    TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 990-RECE62-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＯＰＥＮ処理
      *****************************************************************
       110-FILE-OPEN-SEC          SECTION.
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           MOVE    "RECE620"           TO  RECE62PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE62PARA-TERMID
      *
           MOVE    "RECE64W"           TO  RECE64PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE64PARA-TERMID
      *
           MOVE    "RECE650"           TO  RECE65PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE65PARA-TERMID
      *
           MOVE    "RECE641"           TO  RECE641PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE641PARA-TERMID
      *
           MOVE    "RECE651"           TO  RECE651PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE651PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE62-FILE
      *
           OPEN    INPUT               RECE64-FILE
      *
           OPEN    INPUT               RECE65-FILE
      *
           OPEN    OUTPUT              RECE6441-FILE
           CLOSE                       RECE6441-FILE
      *
           OPEN    OUTPUT              RECE6551-FILE
           CLOSE                       RECE6551-FILE
      *
           OPEN    OUTPUT              RECE641-FILE
      *
           OPEN    OUTPUT              RECE651-FILE
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
           IF   RECE62-COMCNTFLG   =   "1"
      *
             INITIALIZE                      RECE64-REC
             MOVE    RECE62-HOSPID       TO  RECE64-HOSPID
             MOVE    RECE62-SRYYM        TO  RECE64-SRYYM
             MOVE    RECE62-NYUGAIKBN    TO  RECE64-NYUGAIKBN
             MOVE    RECE62-PTID         TO  RECE64-PTID
             MOVE    RECE62-RECEKA       TO  RECE64-RECEKA
             MOVE    RECE62-TEISYUTUSAKI TO  RECE64-TEISYUTUSAKI
             MOVE    RECE62-RECESYUBETU  TO  RECE64-RECESYUBETU
             MOVE    RECE62-HKNJANUM-KEY TO  RECE64-HKNJANUM
             MOVE    RECE62-HOJOKBN-KEY  TO  RECE64-HOJOKBN
             MOVE    RECE62-TEKSTYMD     TO  RECE64-TEKSTYMD
             MOVE    ZERO                TO  RECE64-ZAINUM
      *
             START   RECE64-FILE
                 KEY IS    >=   RECE64-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE64
                 NOT INVALID
                     PERFORM 990-RECE64-NEXT-SEC
             END-START
             PERFORM
               UNTIL  ( FLG-RECE64           =   1                   )
               OR     ( RECE62-HOSPID    NOT =   RECE64-HOSPID       )
               OR     ( RECE62-SRYYM     NOT =   RECE64-SRYYM        )
               OR     ( RECE62-NYUGAIKBN NOT =   RECE64-NYUGAIKBN    )
               OR     ( RECE62-PTID      NOT =   RECE64-PTID         )
               OR     ( RECE62-RECEKA    NOT =   RECE64-RECEKA       )
               OR     ( RECE62-TEISYUTUSAKI
                                         NOT =   RECE64-TEISYUTUSAKI )
               OR     ( RECE62-RECESYUBETU
                                         NOT =   RECE64-RECESYUBETU  )
               OR     ( RECE62-HKNJANUM-KEY
                                         NOT =   RECE64-HKNJANUM     )
               OR     ( RECE62-HOJOKBN-KEY
                                         NOT =   RECE64-HOJOKBN      )
               OR     ( RECE62-TEKSTYMD  NOT =   RECE64-TEKSTYMD     )
      *
               EVALUATE      RECE64-SRYKBN
                   WHEN      "80"
      *            （リハビリのカウント）
                      PERFORM    2001-RIHA-COUNT-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE64-NEXT-SEC
      *
             END-PERFORM
      *
           END-IF
      *
      *    他保険にて入院料算定済みのコメント
      *
           IF   RECE62-NYUINRYOFLG   NOT =   SPACE
      *
              PERFORM   2001-NYUINRYO-COMMENT-SEC
      *
           END-IF
      *
      *    公費受診日のコメント
      *
           IF   RECE62-KOHJNISSUTBLINF    =   ALL " "
              CONTINUE
           ELSE
              PERFORM   2001-KOHJYUSIN-COMMENT-SEC
           END-IF
      *
      *    パラメータ０４ファイルより編集
           INITIALIZE                      RECE64-REC
           MOVE    RECE62-HOSPID       TO  RECE64-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE64-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE64-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE64-PTID
           MOVE    RECE62-RECEKA       TO  RECE64-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE64-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE64-RECESYUBETU
           MOVE    RECE62-HKNJANUM-KEY TO  RECE64-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE64-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE64-TEKSTYMD
           MOVE    ZERO                TO  RECE64-ZAINUM
      *
           START   RECE64-FILE
               KEY IS    >=   RECE64-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE64
               NOT INVALID
                   PERFORM 990-RECE64-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE64           =   1                   )
               OR     ( RECE62-HOSPID    NOT =   RECE64-HOSPID       )
               OR     ( RECE62-SRYYM     NOT =   RECE64-SRYYM        )
               OR     ( RECE62-NYUGAIKBN NOT =   RECE64-NYUGAIKBN    )
               OR     ( RECE62-PTID      NOT =   RECE64-PTID         )
               OR     ( RECE62-RECEKA    NOT =   RECE64-RECEKA       )
               OR     ( RECE62-TEISYUTUSAKI
                                         NOT =   RECE64-TEISYUTUSAKI )
               OR     ( RECE62-RECESYUBETU
                                         NOT =   RECE64-RECESYUBETU  )
               OR     ( RECE62-HKNJANUM-KEY
                                         NOT =   RECE64-HKNJANUM     )
               OR     ( RECE62-HOJOKBN-KEY
                                         NOT =   RECE64-HOJOKBN      )
               OR     ( RECE62-TEKSTYMD  NOT =   RECE64-TEKSTYMD     )
      *
               EVALUATE      RECE64-SRYKBN
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
                      IF   FLG-COMMENT  =  ZERO
                        MOVE       RECE64-REC    TO   RECE641-REC
                        WRITE      RECE641-REC
                        ADD     1          TO      CNT-RECE64
                        PERFORM    2001-RECE65-TENSOU-SEC
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
                         COMPUTE  WRK-KOHBUNRI 
                                 =    RECE64-KOHBUNRI  +  1
                         MOVE    ZERO     TO    FLG-ARI
                         PERFORM   VARYING   IDX    FROM   1   BY   1
                              UNTIL   (IDX             >      16)
                               OR     (FLG-ARI         =       1)
                           IF  RECE64-ZAINUM  =  
                                   WRK-RIHA-ZAINUM(WRK-KOHBUNRI IDX)
                               MOVE    1    TO   FLG-ARI 
                           END-IF
                         END-PERFORM
                         IF  FLG-ARI  =  1
                             MOVE      99   TO   FLG-COMMENT
                             PERFORM   2001-RIHA-COMMENT-SEC
                         END-IF
                      END-IF
                      IF   FLG-COMMENT  =  ZERO
                             MOVE    RECE64-REC    TO   RECE641-REC
                             WRITE   RECE641-REC
                             ADD     1       TO      CNT-RECE64
                             PERFORM    2001-RECE65-TENSOU-SEC
                      END-IF
                   WHEN      "90"                                       
                   WHEN      "92"
                      EVALUATE    RECE64-ZAISKBKBN
                        WHEN   "2"
                          PERFORM   2001-NYU-COMMENT-SEC
                        WHEN   "6"
                          PERFORM   2001-KAKURI-HANTEI-SEC
                        WHEN   OTHER
                          MOVE       RECE64-REC    TO   RECE641-REC     
                          WRITE      RECE641-REC                        
                          ADD     1          TO      CNT-RECE64         
                          PERFORM    2001-RECE65-TENSOU-SEC
                      END-EVALUATE
                   WHEN   OTHER
                      MOVE       RECE64-REC    TO   RECE641-REC
                      WRITE      RECE641-REC
                      ADD     1          TO      CNT-RECE64
                      PERFORM    2001-RECE65-TENSOU-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE64-NEXT-SEC
      *
           END-PERFORM
      *
      *
           PERFORM 990-RECE62-READ-SEC
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
              MOVE    RECE64-HOSPID     TO      SRY-HOSPID
              MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
              MOVE    RECE64-PTID       TO      SRY-PTID
              MOVE    RECE64-SRYYM      TO      SRY-SRYYM
              MOVE    RECE64-ZAINUM     TO      SRY-ZAINUM
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (1)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (2)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (3)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (4)
              MOVE    TBL-RIHA(IDX)     TO      SRY-SRYCD (5)
      *
              MOVE    SRYACT-REC        TO      MCPDATA-REC
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
                     COMPUTE  WRK-KOHBUNRI 
                                 =    RECE64-KOHBUNRI  +  1
                     IF  RECE64-ZAINUM  >  
                                     WRK-RIHA-ZAINUM(WRK-KOHBUNRI IDX2)
                         MOVE  RECE64-ZAINUM  TO  
                                     WRK-RIHA-ZAINUM(WRK-KOHBUNRI IDX2)
                     END-IF
                     PERFORM  VARYING   IDX1  FROM  1  BY  1
                              UNTIL     IDX1  >   31
                         IF   RECE64-KAISU(1 IDX1)  NOT = ZERO
                              MOVE  "1"  TO  
                                    WRK-RIGAKU(WRK-KOHBUNRI IDX2 IDX1)
                         END-IF
                     END-PERFORM
                  END-IF
              END-IF
      *
              INITIALIZE                        MCPAREA
              MOVE    "DBCLOSE"         TO      MCP-FUNC
              MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
              CALL    "ORCMCPSUB"       USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
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
           INITIALIZE                      RECE641-REC
           MOVE    RECE62-HOSPID       TO  RECE641-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE641-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE641-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE641-PTID
           MOVE    RECE62-RECEKA       TO  RECE641-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE641-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE641-RECESYUBETU
           MOVE    RECE62-HKNJANUM-KEY TO  RECE641-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE641-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE641-TEKSTYMD
           MOVE    99999999            TO  RECE641-ZAINUM
           MOVE    "90"                TO  RECE641-SRYKBN
      *
           MOVE    1                   TO  RECE641-MEISAISU
      *
           WRITE   RECE641-REC
           ADD     1                   TO  CNT-RECE64
      *
           INITIALIZE                      RECE651-REC
           MOVE    RECE62-HOSPID       TO  RECE651-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE651-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE651-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE651-PTID
           MOVE    RECE62-RECEKA       TO  RECE651-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE651-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE651-RECESYUBETU
           MOVE    RECE62-HKNJANUM-KEY TO  RECE651-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE651-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE651-TEKSTYMD
           MOVE    99999999            TO  RECE651-ZAINUM
           MOVE    "90"                TO  RECE651-SRYKBN
      *    コメントの挿入
           MOVE    SPACE               TO  COM-RECE65-REC
           INITIALIZE                      COM-RECE65-REC
           MOVE    "810000001"         TO  COM-SRYCD(1)
           MOVE     ZERO               TO  COM-SRYSURYO(1)
           MOVE     11                 TO  COM-YUKOKETA(1)
           MOVE    "他保険にて入院料算定済" 
                                       TO  COM-NAME(1)
      *
           MOVE    COM-SRYACTINF(1)    TO  RECE651-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)      TO  RECE651-NAMEINF(1)
           WRITE   RECE651-REC
           ADD     1                   TO  CNT-RECE65
      *
           .
       2001-NYUINRYO-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費受診日のコメント編集
      *****************************************************************
       2001-KOHJYUSIN-COMMENT-SEC          SECTION.
      *
           INITIALIZE                TBL-NYU-DAY
      *
           MOVE    ZERO          TO  DAY-IDX
           MOVE    ZERO          TO  FLG-NYU-RENZOKU
      *
           PERFORM    VARYING    IDX  FROM   1   BY   1
                      UNTIL     (IDX      >   31)  OR
                                (DAY-IDX  >   31)
                IF   RECE62-KOHJNISSUTBL(IDX)   = SPACE
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
           MOVE       ZERO       TO   IDZ
           INITIALIZE            WRK-FREE-AREA2
      *
           MOVE       5          TO   FLG-COMMENT
      *
           PERFORM  2001-FREE-COMMENT3-SEC
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                TO  IDX-RECE65
           MOVE    SPACE               TO  WRK-SRYACTINF-AREA
           INITIALIZE                      WRK-SRYACTINF-AREA
           MOVE    SPACE               TO  WRK-NAMEINF-AREA
           INITIALIZE                      WRK-NAMEINF-AREA
      *
           MOVE    SPACE               TO  COM-RECE65-REC
           INITIALIZE                      COM-RECE65-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                ADD    1                  TO  IDX-RECE65
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF(IDX-RECE65)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(IDX-RECE65)
           END-PERFORM 
      *
      *    受診日の編集を含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE65
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE65
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE65  =    1
                INITIALIZE                       RECE651-REC
                MOVE    RECE62-HOSPID        TO  RECE651-HOSPID
                MOVE    RECE62-SRYYM         TO  RECE651-SRYYM
                MOVE    RECE62-NYUGAIKBN     TO  RECE651-NYUGAIKBN
                MOVE    RECE62-PTID          TO  RECE651-PTID
                MOVE    RECE62-RECEKA        TO  RECE651-RECEKA
                MOVE    RECE62-TEISYUTUSAKI  TO  RECE651-TEISYUTUSAKI
                MOVE    RECE62-RECESYUBETU   TO  RECE651-RECESYUBETU
                MOVE    RECE62-HKNJANUM-KEY  TO  RECE651-HKNJANUM
                MOVE    RECE62-HOJOKBN-KEY   TO  RECE651-HOJOKBN
                MOVE    RECE62-TEKSTYMD      TO  RECE651-TEKSTYMD
                MOVE    99999980             TO  RECE651-ZAINUM
                MOVE    "99"                 TO  RECE651-SRYKBN
                ADD     1                    TO  WRK-RENNUM
                MOVE    WRK-RENNUM           TO  RECE651-RENNUM
                PERFORM  VARYING   IDX   FROM   1   BY   1
                         UNTIL   (IDX       >    5)   OR
                                 (FLG-WRKRECE65   =   1)
                   ADD         1             TO    IDX-RECE65
                   IF  WK-RECE65-SRYCD(IDX-RECE65) = SPACE
                       MOVE    1             TO    FLG-WRKRECE65
                   ELSE
                       MOVE  WRK-SRYACTINF(IDX-RECE65)
                                        TO   RECE651-SRYACTINF(IDX)  
                       MOVE  WRK-NAMEINF(IDX-RECE65)
                                        TO   RECE651-NAMEINF(IDX)
                       ADD   1          TO   WRK-CNT-MEISAI
                   END-IF  
                END-PERFORM
                WRITE   RECE651-REC
                ADD     1                    TO  CNT-RECE65
           END-PERFORM
      *
      *
           INITIALIZE                      RECE641-REC
           MOVE    RECE62-HOSPID       TO  RECE641-HOSPID
           MOVE    RECE62-SRYYM        TO  RECE641-SRYYM
           MOVE    RECE62-NYUGAIKBN    TO  RECE641-NYUGAIKBN
           MOVE    RECE62-PTID         TO  RECE641-PTID
           MOVE    RECE62-RECEKA       TO  RECE641-RECEKA
           MOVE    RECE62-TEISYUTUSAKI TO  RECE641-TEISYUTUSAKI
           MOVE    RECE62-RECESYUBETU  TO  RECE641-RECESYUBETU
           MOVE    RECE62-HKNJANUM-KEY TO  RECE641-HKNJANUM
           MOVE    RECE62-HOJOKBN-KEY  TO  RECE641-HOJOKBN
           MOVE    RECE62-TEKSTYMD     TO  RECE641-TEKSTYMD
           MOVE    99999980            TO  RECE641-ZAINUM
           MOVE    "99"                TO  RECE641-SRYKBN
      *
           MOVE    WRK-CNT-MEISAI      TO  RECE641-MEISAISU
      *
           WRITE   RECE641-REC
           ADD     1                   TO  CNT-RECE64
      *
           .
       2001-KOHJYUSIN-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    薬剤管理指導料があるか判定
      *****************************************************************
       2001-YAKUKANSIDO-HANTEI-SEC          SECTION.
      *
           IF      RECE64-FLG-YAKUKAN-COMMENT   =    "1"
                MOVE       3       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
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
           IF      RECE64-FLG-NYUEIYO-COMMENT   =    "1"
                MOVE       3       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
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
           IF      RECE64-FLG-HOUMON-COMMENT   =    "1"
                MOVE       3       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
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
           IF      RECE64-FLG-SYOBYO-COMMENT   =    "1"
                MOVE       4       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
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
           IF      RECE64-FLG-RYOYO-COMMENT    =    "1"
                MOVE       4       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
           END-IF
      *
           .
       2001-RYOYO-HANTEI-EXT.
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
           IF      RECE64-FLG-TAIIN-COMMENT   =    "1"
      *
             MOVE      ZERO            TO      FLG-YAKUKAN-COMMENT
      *
             INITIALIZE                        SRYACT-REC
             MOVE    RECE64-HOSPID     TO      SRY-HOSPID
             MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
             MOVE    RECE64-PTID       TO      SRY-PTID
             MOVE    RECE64-SRYYM      TO      SRY-SRYYM
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
                 PERFORM  SRYACT-READ-SEC
                 IF      FLG-SRYACT  =  ZERO
                     MOVE    1         TO      FLG-YAKUKAN-COMMENT
                 END-IF
             END-IF
      *
             INITIALIZE                        MCPAREA
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
               MOVE    RECE64-SRYYM        TO  LNK-DAY6-KIJUN(1:6)
               MOVE    "01"                TO  LNK-DAY6-KIJUN(7:2)
               MOVE    "2"                 TO  LNK-DAY6-ZOGENPTN
               MOVE     -1                 TO  LNK-DAY6-ZOGEN
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN(1:6)
                                           TO  WRK-ZENYYMM
      *
               INITIALIZE                        SRYACT-REC
               MOVE    RECE64-HOSPID     TO      SRY-HOSPID
               MOVE    RECE64-NYUGAIKBN  TO      SRY-NYUGAIKBN
               MOVE    RECE64-PTID       TO      SRY-PTID
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
                   PERFORM  SRYACT-READ-SEC
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
                     INITIALIZE                        MCPAREA
                     MOVE    "DBCLOSE"         TO      MCP-FUNC
                     MOVE    "SRYACCT-KEY5"    TO      ORC-DBPATH
                     CALL    "ORCMCPSUB"       USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
      *
                     MOVE     "SRYACT-KEY7"   TO   ORC-DBPATH
                     PERFORM   SRYACT-READ-SEC
      *
                   END-PERFORM
               END-IF
      *
               INITIALIZE                        MCPAREA
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
                PERFORM    2001-TAIIN-COMMENT-SEC
           END-IF
      *
           .
       2001-TAIIN-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日のコメントがあるか判定
      *****************************************************************
       2001-SHUJUTSU-HANTEI-SEC          SECTION.
      *
           IF     RECE64-FLG-SHUJUTU-COMMENT   =    SPACE
                MOVE       1       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC-COMMENT-SEC
           ELSE
                MOVE       RECE64-REC    TO   RECE641-REC
                WRITE      RECE641-REC
                ADD     1          TO      CNT-RECE64
                PERFORM    2001-RECE65-TENSOU-SEC
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
           IF      RECE64-FLG-CTMRI-COMMENT   =    "1"
                MOVE       2       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC-COMMENT-SEC
           ELSE
                MOVE       RECE64-REC    TO   RECE641-REC
                WRITE      RECE641-REC
                ADD     1          TO      CNT-RECE64
                PERFORM    2001-RECE65-TENSOU-SEC
           END-IF
      *
           .
       2001-CTMRI-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    精神科退院前訪問指導料があるか判定
      *****************************************************************
       2001-HOUMONSIDO-SEISIN-HANTEI-SEC          SECTION.
      *
           IF      RECE64-FLG-HOUSEI-COMMENT   =    "1"
                MOVE       3       TO     FLG-COMMENT
                PERFORM    2001-SHUJUTSU-ETC2-COMMENT-SEC
           END-IF
      *
           .
       2001-HOUMONSIDO-SEISIN-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    退院時服薬指導加算を算定時の前月薬剤管理指導料のコメント編集
      *****************************************************************
       2001-TAIIN-COMMENT-SEC          SECTION.
      *
           MOVE       RECE64-REC       TO  RECE641-REC
           ADD     1                   TO  RECE641-MEISAISU
           WRITE      RECE641-REC
           ADD     1                   TO  CNT-RECE64
      *
           INITIALIZE                      RECE65-REC
           MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
           MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
           MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
           MOVE    RECE64-PTID         TO  RECE65-PTID
           MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
           MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
           MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
           MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
           MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
           MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
           MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
           MOVE    RECE64-ZAIREN       TO  RECE65-ZAIREN
           START   RECE65-FILE
                 KEY IS    >=   RECE65-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE65
                 NOT INVALID
                     PERFORM 990-RECE65-NEXT-SEC
           END-START
      *
           MOVE    RECE65-REC       TO      RECE651-REC
           MOVE    RECE65-SRYACTINF(1)  TO  RECE651-SRYACTINF(1)
           MOVE    RECE65-SRYACTINF(2)  TO  RECE651-SRYACTINF(3)
           MOVE    RECE65-SRYACTINF(3)  TO  RECE651-SRYACTINF(4)
           MOVE    RECE65-SRYACTINF(4)  TO  RECE651-SRYACTINF(5)
           MOVE    RECE65-NAMEINF(1)    TO  RECE651-NAMEINF(1)
           MOVE    RECE65-NAMEINF(2)    TO  RECE651-NAMEINF(3)
           MOVE    RECE65-NAMEINF(3)    TO  RECE651-NAMEINF(4)
           MOVE    RECE65-NAMEINF(4)    TO  RECE651-NAMEINF(5)
           MOVE    RECE65-DATAKBNINF(1) TO  RECE651-DATAKBNINF(1)
           MOVE    RECE65-DATAKBNINF(2) TO  RECE651-DATAKBNINF(3)
           MOVE    RECE65-DATAKBNINF(3) TO  RECE651-DATAKBNINF(4)
           MOVE    RECE65-DATAKBNINF(4) TO  RECE651-DATAKBNINF(5)
      *
           MOVE    SPACE                TO  RECE651-SRYACTINF(2)
           INITIALIZE                       RECE651-SRYACTINF(2)
           MOVE    "810000001"          TO  RECE651-SRYCD(2)
           MOVE    ZERO                 TO  RECE651-SRYSURYO(2)
           MOVE    16                   TO  RECE651-YUKOKETA(2)
           MOVE    "薬剤管理指導料算定　　　月　　日"
                                        TO  RECE651-NAME(2)
           MOVE     WRK-TUKI-YAKUKAN    TO  DAY-IDX
           MOVE     TBL-DAY(DAY-IDX)    TO  RECE651-NAME(2)(21:4)
           MOVE     WRK-DAY-YAKUKAN     TO  DAY-IDX
           MOVE     TBL-DAY(DAY-IDX)    TO  RECE651-NAME(2)(27:4)
           WRITE    RECE651-REC
           ADD      1                   TO  CNT-RECE65
      *
           .
       2001-TAIIN-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日等のコメント編集（差込：上）
      *****************************************************************
       2001-SHUJUTSU-ETC-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SANTEI-DAY-SEC
      *
           MOVE       ZERO       TO   IDZ                               
           INITIALIZE            WRK-FREE-AREA2                         
      *
           PERFORM  2001-FREE-COMMENT2-SEC                              
      *
      *    ※明細が５以上の場合
           INITIALIZE                      RECE65-REC
           MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
           MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
           MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
           MOVE    RECE64-PTID         TO  RECE65-PTID
           MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
           MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
           MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
           MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
           MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
           MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
           MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
           MOVE    RECE64-ZAIREN       TO  RECE65-ZAIREN
           START   RECE65-FILE
                 KEY IS    >=   RECE65-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE65
                 NOT INVALID
                     PERFORM 990-RECE65-NEXT-SEC
                     MOVE    RECE65-REC  TO  WRK-RECE65-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                 TO  IDX-RECE65
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
      *
           MOVE    SPACE               TO  COM-RECE65-REC
           INITIALIZE                      COM-RECE65-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                ADD    1                  TO  IDX-RECE65
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF(IDX-RECE65)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(IDX-RECE65)
           END-PERFORM 
      *
           PERFORM
             UNTIL  ( FLG-RECE65           =   1                   )
             OR     ( RECE64-HOSPID    NOT =   RECE65-HOSPID       )
             OR     ( RECE64-SRYYM     NOT =   RECE65-SRYYM        )
             OR     ( RECE64-NYUGAIKBN NOT =   RECE65-NYUGAIKBN    )
             OR     ( RECE64-PTID      NOT =   RECE65-PTID         )
             OR     ( RECE64-RECEKA    NOT =   RECE65-RECEKA       )
             OR     ( RECE64-TEISYUTUSAKI
                                       NOT =   RECE65-TEISYUTUSAKI )
             OR     ( RECE64-RECESYUBETU
                                       NOT =   RECE65-RECESYUBETU  )
             OR     ( RECE64-HKNJANUM  NOT =   RECE65-HKNJANUM     )
             OR     ( RECE64-HOJOKBN   NOT =   RECE65-HOJOKBN      )
             OR     ( RECE64-TEKSTYMD  NOT =   RECE65-TEKSTYMD     )
             OR     ( RECE64-ZAINUM    NOT =   RECE65-ZAINUM       )
             OR     ( RECE64-ZAIREN    NOT =   RECE65-ZAIREN       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE65-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE65
                  MOVE   RECE65-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE65)
                  MOVE   RECE65-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE65)     
                  MOVE   RECE65-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE65)
             END-PERFORM 
      *
             PERFORM 990-RECE65-NEXT-SEC
      *
           END-PERFORM
      *
      *    手術日コメントを含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE65
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE65
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE65  =    1
                  INITIALIZE                        RECE651-REC
                  MOVE    WRK-RECE65-KEY       TO   RECE651-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE651-RENNUM
                  MOVE    WRK-RECE65-KOHBUNRI  TO   RECE651-KOHBUNRI
                  MOVE    WRK-RECE65-PTNUM     TO   RECE651-PTNUM
                  MOVE    WRK-RECE65-SRYKA     TO   RECE651-SRYKA
                  MOVE    WRK-RECE65-SRYKBN    TO   RECE651-SRYKBN
                  MOVE    WRK-RECE65-SRYSYUKBN TO   RECE651-SRYSYUKBN
                  MOVE    WRK-RECE65-JIHIMONEY TO   RECE651-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE65   =   1)
                     ADD         1             TO    IDX-RECE65
                     IF  WK-RECE65-SRYCD(IDX-RECE65) = SPACE
                         MOVE    1             TO    FLG-WRKRECE65
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE65)
                                          TO   RECE651-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE65)
                                          TO   RECE651-NAMEINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE65)
                                          TO   RECE651-DATAKBNINF(IDX)
                         ADD   1          TO   WRK-CNT-MEISAI
                     END-IF  
                  END-PERFORM
                  WRITE   RECE651-REC
                  ADD     1                    TO  CNT-RECE65
           END-PERFORM     
      *
           MOVE    RECE64-REC        TO      RECE641-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE641-MEISAISU
           WRITE   RECE641-REC
           ADD     1                 TO      CNT-RECE64
      *
           .
       2001-SHUJUTSU-ETC-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日等のコメント編集２（差込：下）
      *****************************************************************
       2001-SHUJUTSU-ETC2-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SANTEI-DAY-SEC
      *
           MOVE       ZERO       TO   IDZ                               
           INITIALIZE            WRK-FREE-AREA2                         
      *
           PERFORM  2001-FREE-COMMENT2-SEC                              
      *
      *    ※明細が５以上の場合
           INITIALIZE                      RECE65-REC
           MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
           MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
           MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
           MOVE    RECE64-PTID         TO  RECE65-PTID
           MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
           MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
           MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
           MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
           MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
           MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
           MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
           MOVE    RECE64-ZAIREN       TO  RECE65-ZAIREN
           START   RECE65-FILE
                 KEY IS    >=   RECE65-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE65
                 NOT INVALID
                     PERFORM 990-RECE65-NEXT-SEC
                     MOVE    RECE65-REC  TO  WRK-RECE65-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                 TO  IDX-RECE65
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
      *
           MOVE    RECE64-MEISAISU      TO  MAX-MEISAISU
      *
           MOVE    SPACE               TO  COM-RECE65-REC
           INITIALIZE                      COM-RECE65-REC
      *
           PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX                >   50    )
                         OR      ( WK-FREE-NAME2(IDX) =   SPACE )
                COMPUTE  MAX-MEISAISU        =   MAX-MEISAISU  +  1
                MOVE   "810000001"        TO  COM-SRYCD(1)
                MOVE   ZERO               TO  COM-SRYSURYO(1)
                MOVE   COM-SRYACTINF(1)   TO  WRK-SRYACTINF
                                                         (MAX-MEISAISU)
                MOVE   WRK-FREEINF2(IDX)  TO  WRK-NAMEINF(MAX-MEISAISU)
           END-PERFORM 
      *
           PERFORM
             UNTIL  ( FLG-RECE65           =   1                   )
             OR     ( RECE64-HOSPID    NOT =   RECE65-HOSPID       )
             OR     ( RECE64-SRYYM     NOT =   RECE65-SRYYM        )
             OR     ( RECE64-NYUGAIKBN NOT =   RECE65-NYUGAIKBN    )
             OR     ( RECE64-PTID      NOT =   RECE65-PTID         )
             OR     ( RECE64-RECEKA    NOT =   RECE65-RECEKA       )
             OR     ( RECE64-TEISYUTUSAKI
                                       NOT =   RECE65-TEISYUTUSAKI )
             OR     ( RECE64-RECESYUBETU
                                       NOT =   RECE65-RECESYUBETU  )
             OR     ( RECE64-HKNJANUM  NOT =   RECE65-HKNJANUM     )
             OR     ( RECE64-HOJOKBN   NOT =   RECE65-HOJOKBN      )
             OR     ( RECE64-TEKSTYMD  NOT =   RECE65-TEKSTYMD     )
             OR     ( RECE64-ZAINUM    NOT =   RECE65-ZAINUM       )
             OR     ( RECE64-ZAIREN    NOT =   RECE65-ZAIREN       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE65-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE65
                  MOVE   RECE65-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE65)
                  MOVE   RECE65-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE65)     
                  MOVE   RECE65-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE65)
             END-PERFORM 
      *
             PERFORM 990-RECE65-NEXT-SEC
      *
           END-PERFORM
      *
      *    手術日コメントを含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE65
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE65
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE65  =    1
                  INITIALIZE                        RECE651-REC
                  MOVE    WRK-RECE65-KEY       TO   RECE651-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE651-RENNUM
                  MOVE    WRK-RECE65-KOHBUNRI  TO   RECE651-KOHBUNRI
                  MOVE    WRK-RECE65-PTNUM     TO   RECE651-PTNUM
                  MOVE    WRK-RECE65-SRYKA     TO   RECE651-SRYKA
                  MOVE    WRK-RECE65-SRYKBN    TO   RECE651-SRYKBN
                  MOVE    WRK-RECE65-SRYSYUKBN TO   RECE651-SRYSYUKBN
                  MOVE    WRK-RECE65-JIHIMONEY TO   RECE651-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE65   =   1)
                     ADD         1             TO    IDX-RECE65
                     IF  WK-RECE65-SRYCD(IDX-RECE65) = SPACE
                         MOVE    1             TO    FLG-WRKRECE65
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE65)
                                          TO   RECE651-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE65)
                                          TO   RECE651-NAMEINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE65)
                                          TO   RECE651-DATAKBNINF(IDX)
                         ADD   1          TO   WRK-CNT-MEISAI
                     END-IF  
                  END-PERFORM
                  WRITE   RECE651-REC
                  ADD     1                    TO  CNT-RECE65
           END-PERFORM     
      *
           MOVE    RECE64-REC        TO      RECE641-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE641-MEISAISU
           WRITE   RECE641-REC
           ADD     1                 TO      CNT-RECE64
      *
           .
       2001-SHUJUTSU-ETC2-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定日の確定
      *****************************************************************
       2001-SANTEI-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-SANTEI-DAY
      *
           MOVE    ZERO           TO  DAY-IDX
           PERFORM    VARYING    IDX  FROM   1   BY   1
                      UNTIL     (IDX      >   31)  OR
                                (DAY-IDX  >   31)
                IF    RECE64-KAISU(1 IDX)  NOT =  ZERO
                      ADD   1     TO  DAY-IDX
                      MOVE  IDX   TO  TB-SANTEI-DAY(DAY-IDX)
                END-IF
           END-PERFORM
      *
           .
       2001-SANTEI-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日等の日付の編集
      *****************************************************************
       2001-FREE-COMMENT2-SEC          SECTION.                         
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
                          PERFORM  2001-FREE-COMMENT2-KAIGYO-SEC
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
                          PERFORM  2001-FREE-COMMENT2-KAIGYO-SEC
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
                          PERFORM  2001-FREE-COMMENT2-KAIGYO-SEC
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
                          PERFORM  2001-FREE-COMMENT2-KAIGYO-SEC
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
       2001-FREE-COMMENT2-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日等の日付の編集（改行）
      *****************************************************************
       2001-FREE-COMMENT2-KAIGYO-SEC          SECTION.                  
      *
           ADD      1              TO  IDZ
      *
           MOVE    WRK-KETA-TAIHI  TO  WRK-KETA
           MOVE    WRK-KETA2       TO  WK-FREE-YUKOKETA2(IDZ)
           MOVE    ALL "　"        TO  WK-FREE-NAME2(IDZ)(1:WRK-KETA)
      *
           .
       2001-FREE-COMMENT2-KAIGYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費受診日の日付の編集
      *****************************************************************
       2001-FREE-COMMENT3-SEC          SECTION.                         
      *
           ADD      1          TO    IDZ
      *
           EVALUATE   FLG-COMMENT
              WHEN    5
                 MOVE     3          TO    WRK-KETA
                                           WRK-KETA-TAIHI
                 MOVE     2          TO    WRK-KETA2
                 MOVE    WRK-KETA2   TO    WK-FREE-YUKOKETA2(IDZ)
                 MOVE    "福祉"  TO    WK-FREE-NAME2(IDZ)(1:4)
           END-EVALUATE
      *
           MOVE      ZERO          TO  FLG-FIRST
      *
           PERFORM   VARYING   IDX    FROM   1   BY   1
                          UNTIL   (IDX                  >    31 )
                           OR     (TBL-NYU-DAY-ST(IDX)  =   ZERO)
      *
                 IF  TBL-NYU-DAY-CD(IDX)   =  CONS-SANTEI-COMMENT1
      *
                       MOVE   TBL-NYU-DAY-ST(IDX) TO  IDY
      *
                       IF  FLG-FIRST  =  ZERO
                         ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                         COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                         MOVE    "　"
                             TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                         MOVE  1  TO  FLG-FIRST 
                       ELSE
                         IF    WK-FREE-YUKOKETA2(IDZ)  =  25
                           PERFORM  2001-FREE-COMMENT3-KAIGYO-SEC
                         ELSE
                           ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                           COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                           MOVE    "、"
                             TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                         END-IF
                       END-IF
      *
                       IF  TBL-NYU-DAY-ST(IDX)     <  10 
                          IF    WK-FREE-YUKOKETA2(IDZ)  =
                                                       24 OR 25
                            PERFORM  2001-FREE-COMMENT3-KAIGYO-SEC
                          END-IF
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
                          IF    WK-FREE-YUKOKETA2(IDZ)  =
                                                 23 OR 24 OR 25
                            PERFORM  2001-FREE-COMMENT3-KAIGYO-SEC
                          END-IF
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
      *
                 ELSE
      *
                       MOVE   TBL-NYU-DAY-ST(IDX) TO  IDY
                       MOVE   TBL-NYU-DAY-ED(IDX) TO  IDY2
      *
                       IF  FLG-FIRST  =  ZERO
                         ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                         COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                         MOVE    "　"
                             TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                         MOVE  1  TO  FLG-FIRST 
                       ELSE
                         IF    WK-FREE-YUKOKETA2(IDZ)  =  25
                           PERFORM  2001-FREE-COMMENT3-KAIGYO-SEC
                         ELSE
                           ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                           COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                           MOVE    "、"
                             TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                         END-IF
                       END-IF
      *
                       IF  TBL-NYU-DAY-ST(IDX)     <  10 
                          IF  TBL-NYU-DAY-ED(IDX)  <  10
                            IF    WK-FREE-YUKOKETA2(IDZ)  =  
                                       21 OR 22 OR 23 OR 24 OR 25
                              PERFORM  2001-FREE-COMMENT3-KAIGYO-SEC
                            END-IF
                            ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                            COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                            MOVE    TBL-DAY(IDY)(3:2)     
                                TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                            ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                            COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                            MOVE    "日〜"
                                TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                            ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                            COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                            MOVE    TBL-DAY(IDY2)(3:2)     
                                TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                            ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                            COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                            MOVE    "日"
                                TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                          ELSE
                            IF    WK-FREE-YUKOKETA2(IDZ)  =  
                                 20 OR 21 OR 22 OR 23 OR 24 OR 25
                              PERFORM  2001-FREE-COMMENT3-KAIGYO-SEC
                            END-IF
                            ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                            COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                            MOVE    TBL-DAY(IDY)(3:2)     
                                TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
      *
                            ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                            COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                            MOVE    "日〜"
                                TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                            ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                            COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                            MOVE    TBL-DAY(IDY2)
                                TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                            ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                            COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                            MOVE    "日"
                                TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                          END-IF
                       ELSE
                          IF    WK-FREE-YUKOKETA2(IDZ)  =  
                               19 OR 20 OR 21 OR 22 OR 23 OR 24 OR 25
                              PERFORM  2001-FREE-COMMENT3-KAIGYO-SEC
                          END-IF
                          ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  2
                          MOVE    TBL-DAY(IDY)     
                              TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                          ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "日〜"
                              TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                          ADD   2  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    TBL-DAY(IDY2)
                              TO  WK-FREE-NAME2(IDZ)(WRK-KETA:4)
      *
                          ADD   1  TO  WK-FREE-YUKOKETA2(IDZ)
                          COMPUTE  WRK-KETA   =  WRK-KETA   +  4
                          MOVE    "日"
                              TO  WK-FREE-NAME2(IDZ)(WRK-KETA:2)
                       END-IF
      *
                 END-IF
      *
           END-PERFORM
           .
       2001-FREE-COMMENT3-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費受診日の日付の編集（改行）
      *****************************************************************
       2001-FREE-COMMENT3-KAIGYO-SEC          SECTION.                  
      *
           ADD      1              TO  IDZ
      *
           MOVE    WRK-KETA-TAIHI  TO  WRK-KETA
           MOVE    WRK-KETA2       TO  WK-FREE-YUKOKETA2(IDZ)
           MOVE    ALL "　"        TO  WK-FREE-NAME2(IDZ)(1:4)
      *
           .
       2001-FREE-COMMENT3-KAIGYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    リハビリのコメント編集
      *****************************************************************
       2001-RIHA-COMMENT-SEC          SECTION.
      *
           MOVE    RECE64-REC        TO      RECE641-REC
           ADD     1                 TO      RECE641-MEISAISU
           WRITE   RECE641-REC
           ADD     1                 TO      CNT-RECE64
      *
      *      ※明細が５以上の場合
             INITIALIZE                      RECE65-REC
             MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
             MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
             MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
             MOVE    RECE64-PTID         TO  RECE65-PTID
             MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
             MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
             MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
             MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
             MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
             MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
             MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
             MOVE    RECE64-ZAIREN       TO  RECE65-ZAIREN
             START   RECE65-FILE
                 KEY IS    >=   RECE65-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE65
                 NOT INVALID
                     PERFORM 990-RECE65-NEXT-SEC
                     MOVE    RECE65-REC  TO  WRK-RECE65-REC
             END-START
      *
      *      ＲＥＣＥ０５ファイルの内容をテーブルに退避
             MOVE    ZERO                 TO  IDX-RECE65
             MOVE    SPACE                TO  WRK-SRYACTINF-AREA
             INITIALIZE                       WRK-SRYACTINF-AREA
             MOVE    SPACE                TO  WRK-NAMEINF-AREA
             INITIALIZE                       WRK-NAMEINF-AREA
             MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
             INITIALIZE                       WRK-DATAKBNINF-AREA
      *      リハビリコメントの挿入
      *      ADD     1                    TO  IDX-RECE65
             MOVE    SPACE                TO  COM-RECE65-REC
             INITIALIZE                       COM-RECE65-REC
             MOVE    "810000001"          TO  COM-SRYCD(1)
             MOVE    ZERO                 TO  COM-SRYSURYO(1)
             MOVE    7                    TO  COM-YUKOKETA(1)
             MOVE    "実施日数　　日"     TO  COM-NAME(1)
             MOVE    ZERO                 TO  CNT-RIHA
             EVALUATE   RECE64-ZAINUM
                 WHEN   WRK-RIGA1-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-SHU(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-SHU(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-SHU(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-SHU(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA1-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-KO(WRK-KOHBUNRI IDX) 
                                                     NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-KO(WRK-KOHBUNRI IDX) 
                                                     NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-KO(WRK-KOHBUNRI IDX) 
                                                     NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-KO(WRK-KOHBUNRI IDX) 
                                                     NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-SHU(WRK-KOHBUNRI IDX) 
                                                       NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-SHU(WRK-KOHBUNRI IDX) 
                                                       NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-KO(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-KO(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-SHU(WRK-KOHBUNRI IDX) 
                                                       NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-SHU-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-SHU(WRK-KOHBUNRI IDX) 
                                                       NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-KO(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-KO-ZAINUM(WRK-KOHBUNRI)
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-KO(WRK-KOHBUNRI IDX) 
                                                      NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   OTHER
                        CONTINUE
             END-EVALUATE
             IF      CNT-RIHA             NOT =    ZERO
               MOVE    CNT-RIHA             TO  DAY-IDX
               MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(9:4)
               COMPUTE  MAX-MEISAISU        =   RECE64-MEISAISU  +  1
               MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                     (MAX-MEISAISU)
               MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                     (MAX-MEISAISU)
             END-IF
      *
             PERFORM
               UNTIL  ( FLG-RECE65           =   1                   )
               OR     ( RECE64-HOSPID    NOT =   RECE65-HOSPID       )
               OR     ( RECE64-SRYYM     NOT =   RECE65-SRYYM        )
               OR     ( RECE64-NYUGAIKBN NOT =   RECE65-NYUGAIKBN    )
               OR     ( RECE64-PTID      NOT =   RECE65-PTID         )
               OR     ( RECE64-RECEKA    NOT =   RECE65-RECEKA       )
               OR     ( RECE64-TEISYUTUSAKI
                                         NOT =   RECE65-TEISYUTUSAKI )
               OR     ( RECE64-RECESYUBETU
                                         NOT =   RECE65-RECESYUBETU  )
               OR     ( RECE64-HKNJANUM  NOT =   RECE65-HKNJANUM     )
               OR     ( RECE64-HOJOKBN   NOT =   RECE65-HOJOKBN      )
               OR     ( RECE64-TEKSTYMD  NOT =   RECE65-TEKSTYMD     )
               OR     ( RECE64-ZAINUM    NOT =   RECE65-ZAINUM       )
               OR     ( RECE64-ZAIREN    NOT =   RECE65-ZAIREN       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE65-SRYCD(IDX) =   SPACE )
                    ADD    1             TO      IDX-RECE65
                    MOVE   RECE65-SRYACTINF(IDX) TO
                                             WRK-SRYACTINF(IDX-RECE65)
                    MOVE   RECE65-NAMEINF(IDX)   TO
                                             WRK-NAMEINF(IDX-RECE65)     
                    MOVE   RECE65-DATAKBNINF(IDX) TO
                                             WRK-DATAKBNINF(IDX-RECE65)
               END-PERFORM 
      *
               PERFORM 990-RECE65-NEXT-SEC
      *
             END-PERFORM
      *
      *      リハビリコメントを含んだ内容で中間ファイルの再作成
             MOVE       ZERO             TO      FLG-WRKRECE65
             MOVE       ZERO             TO      IDX
             MOVE       ZERO             TO      IDX-RECE65
             MOVE       ZERO             TO      WRK-RENNUM
             PERFORM    UNTIL     FLG-WRKRECE65  =    1
                    INITIALIZE                        RECE651-REC
                    MOVE    WRK-RECE65-KEY       TO   RECE651-KEY
                    ADD     1                    TO   WRK-RENNUM
                    MOVE    WRK-RENNUM           TO   RECE651-RENNUM
                    MOVE    WRK-RECE65-KOHBUNRI  TO   RECE651-KOHBUNRI
                    MOVE    WRK-RECE65-PTNUM     TO   RECE651-PTNUM
                    MOVE    WRK-RECE65-SRYKA     TO   RECE651-SRYKA
                    MOVE    WRK-RECE65-SRYKBN    TO   RECE651-SRYKBN
                    MOVE    WRK-RECE65-SRYSYUKBN TO   RECE651-SRYSYUKBN
                    MOVE    WRK-RECE65-JIHIMONEY TO   RECE651-JIHIMONEY
                    PERFORM  VARYING   IDX   FROM   1   BY   1
                             UNTIL   (IDX       >    5)   OR
                                     (FLG-WRKRECE65   =   1)
                       ADD         1             TO    IDX-RECE65
                       IF  WK-RECE65-SRYCD(IDX-RECE65) = SPACE
                           MOVE    1             TO    FLG-WRKRECE65
                       ELSE
                           MOVE  WRK-SRYACTINF(IDX-RECE65)
                                            TO   RECE651-SRYACTINF(IDX)  
                           MOVE  WRK-NAMEINF(IDX-RECE65)
                                            TO   RECE651-NAMEINF(IDX)
                           MOVE  WRK-DATAKBNINF(IDX-RECE65)
                                            TO   RECE651-DATAKBNINF(IDX)
                       END-IF  
                    END-PERFORM
                    WRITE   RECE651-REC
                    ADD     1                    TO  CNT-RECE65
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
           PERFORM     2001-NYU-DAY-SEC
      *
           INITIALIZE                      RECE65-REC
           MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
           MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
           MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
           MOVE    RECE64-PTID         TO  RECE65-PTID
           MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
           MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
           MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
           MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
           MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
           MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
           MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
           MOVE    RECE64-ZAIREN       TO  RECE65-ZAIREN
           START   RECE65-FILE
                 KEY IS    >=   RECE65-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE65
                 NOT INVALID
                     PERFORM 990-RECE65-NEXT-SEC
                     MOVE    RECE65-REC  TO  WRK-RECE65-REC
           END-START
      *
      *    ＲＥＣＥ０５ファイルの内容をテーブルに退避
           MOVE    ZERO                 TO  IDX-RECE65
           MOVE    SPACE                TO  WRK-SRYACTINF-AREA
           INITIALIZE                       WRK-SRYACTINF-AREA
           MOVE    SPACE                TO  WRK-NAMEINF-AREA
           INITIALIZE                       WRK-NAMEINF-AREA
           MOVE    SPACE                TO  WRK-DATAKBNINF-AREA
           INITIALIZE                       WRK-DATAKBNINF-AREA
      *
           MOVE    RECE64-MEISAISU      TO  MAX-MEISAISU
      *
      *    算定日コメントの挿入
           PERFORM  VARYING      IDX    FROM  1   BY   1
                    UNTIL       (IDX    >     31)      OR
                                (TBL-NYU-DAY-ST(IDX)  =  ZERO)
      *        ADD     1                    TO  IDX-RECE65
               COMPUTE  MAX-MEISAISU        =   MAX-MEISAISU  +  1
               MOVE    SPACE                TO  COM-RECE65-REC
               INITIALIZE                       COM-RECE65-REC
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
               MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                     (MAX-MEISAISU)
               MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                     (MAX-MEISAISU)
           END-PERFORM
      *
           PERFORM
             UNTIL  ( FLG-RECE65           =   1                   )
             OR     ( RECE64-HOSPID    NOT =   RECE65-HOSPID       )
             OR     ( RECE64-SRYYM     NOT =   RECE65-SRYYM        )
             OR     ( RECE64-NYUGAIKBN NOT =   RECE65-NYUGAIKBN    )
             OR     ( RECE64-PTID      NOT =   RECE65-PTID         )
             OR     ( RECE64-RECEKA    NOT =   RECE65-RECEKA       )
             OR     ( RECE64-TEISYUTUSAKI
                                       NOT =   RECE65-TEISYUTUSAKI )
             OR     ( RECE64-RECESYUBETU
                                       NOT =   RECE65-RECESYUBETU  )
             OR     ( RECE64-HKNJANUM  NOT =   RECE65-HKNJANUM     )
             OR     ( RECE64-HOJOKBN   NOT =   RECE65-HOJOKBN      )
             OR     ( RECE64-TEKSTYMD  NOT =   RECE65-TEKSTYMD     )
             OR     ( RECE64-ZAINUM    NOT =   RECE65-ZAINUM       )
             OR     ( RECE64-ZAIREN    NOT =   RECE65-ZAIREN       )
      *
             PERFORM   VARYING   IDX   FROM    1   BY  1
                       UNTIL   ( IDX               >   5     )
                       OR      ( RECE65-SRYCD(IDX) =   SPACE )
                  ADD    1             TO      IDX-RECE65
                  MOVE   RECE65-SRYACTINF(IDX) TO
                                           WRK-SRYACTINF(IDX-RECE65)
                  MOVE   RECE65-NAMEINF(IDX)   TO
                                           WRK-NAMEINF(IDX-RECE65)     
                  MOVE   RECE65-DATAKBNINF(IDX) TO
                                           WRK-DATAKBNINF(IDX-RECE65)
             END-PERFORM 
      *
             PERFORM 990-RECE65-NEXT-SEC
      *
           END-PERFORM
      *
      *    算定日コメントを含んだ内容で中間ファイルの再作成
           MOVE       ZERO             TO      FLG-WRKRECE65
           MOVE       ZERO             TO      IDX
           MOVE       ZERO             TO      IDX-RECE65
           MOVE       ZERO             TO      WRK-RENNUM
           MOVE       ZERO             TO      WRK-CNT-MEISAI
           PERFORM    UNTIL     FLG-WRKRECE65  =    1
                  INITIALIZE                        RECE651-REC
                  MOVE    WRK-RECE65-KEY       TO   RECE651-KEY
                  ADD     1                    TO   WRK-RENNUM
                  MOVE    WRK-RENNUM           TO   RECE651-RENNUM
                  MOVE    WRK-RECE65-KOHBUNRI  TO   RECE651-KOHBUNRI
                  MOVE    WRK-RECE65-PTNUM     TO   RECE651-PTNUM
                  MOVE    WRK-RECE65-SRYKA     TO   RECE651-SRYKA
                  MOVE    WRK-RECE65-SRYKBN    TO   RECE651-SRYKBN
                  MOVE    WRK-RECE65-SRYSYUKBN TO   RECE651-SRYSYUKBN
                  MOVE    WRK-RECE65-JIHIMONEY TO   RECE651-JIHIMONEY
                  PERFORM  VARYING   IDX   FROM   1   BY   1
                           UNTIL   (IDX       >    5)   OR
                                   (FLG-WRKRECE65   =   1)
                     ADD         1             TO    IDX-RECE65
                     IF  WK-RECE65-SRYCD(IDX-RECE65) = SPACE
                         MOVE    1             TO    FLG-WRKRECE65
                     ELSE
                         MOVE  WRK-SRYACTINF(IDX-RECE65)
                                          TO   RECE651-SRYACTINF(IDX)  
                         MOVE  WRK-NAMEINF(IDX-RECE65)
                                          TO   RECE651-NAMEINF(IDX)
                         MOVE  WRK-DATAKBNINF(IDX-RECE65)
                                          TO   RECE651-DATAKBNINF(IDX)
                         ADD   1          TO   WRK-CNT-MEISAI
                     END-IF  
                  END-PERFORM
                  WRITE   RECE651-REC
                  ADD     1                    TO  CNT-RECE65
           END-PERFORM     
      *
           MOVE    RECE64-REC        TO      RECE641-REC
           MOVE    WRK-CNT-MEISAI    TO      RECE641-MEISAISU
           WRITE   RECE641-REC
           ADD     1                 TO      CNT-RECE64
      *
           .
       2001-NYU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    外泊日の確定
      *    精神科隔離病室管理加算日（入院料加算）の確定
      *****************************************************************
       2001-NYU-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-NYU-DAY
      *
           MOVE    ZERO          TO  DAY-IDX
           MOVE    ZERO          TO  FLG-NYU-RENZOKU
      *
           PERFORM    VARYING    IDX  FROM   1   BY   1
                      UNTIL     (IDX      >   31)  OR
                                (DAY-IDX  >   31)
                IF    RECE64-KAISU(1 IDX)   =  ZERO
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
       2001-NYU-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    精神科隔離病室管理加算（入院料加算）のコメントがあるか判定
      *    （診療行為入力）
      *****************************************************************
       2001-KAKURI-HANTEI-SEC          SECTION.
      *
           IF      RECE64-FLG-KAKURI-COMMENT    =    "1"
               PERFORM   2001-NYU-COMMENT-SEC
           ELSE
               MOVE       RECE64-REC    TO   RECE641-REC
               WRITE      RECE641-REC
               ADD     1          TO      CNT-RECE64
               PERFORM    2001-RECE65-TENSOU-SEC
           END-IF         
      *
           .
       2001-KAKURI-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０５転送処理
      *****************************************************************
       2001-RECE65-TENSOU-SEC     SECTION.
      *
           INITIALIZE                      RECE65-REC
           MOVE    RECE64-HOSPID       TO  RECE65-HOSPID
           MOVE    RECE64-SRYYM        TO  RECE65-SRYYM
           MOVE    RECE64-NYUGAIKBN    TO  RECE65-NYUGAIKBN
           MOVE    RECE64-PTID         TO  RECE65-PTID
           MOVE    RECE64-RECEKA       TO  RECE65-RECEKA
           MOVE    RECE64-TEISYUTUSAKI TO  RECE65-TEISYUTUSAKI
           MOVE    RECE64-RECESYUBETU  TO  RECE65-RECESYUBETU
           MOVE    RECE64-HKNJANUM     TO  RECE65-HKNJANUM
           MOVE    RECE64-HOJOKBN      TO  RECE65-HOJOKBN
           MOVE    RECE64-TEKSTYMD     TO  RECE65-TEKSTYMD
           MOVE    RECE64-ZAINUM       TO  RECE65-ZAINUM
           MOVE    RECE64-ZAIREN       TO  RECE65-ZAIREN
           START   RECE65-FILE
               KEY IS    >=   RECE65-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE65
               NOT INVALID
                   PERFORM 990-RECE65-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE65           =   1                   )
               OR     ( RECE64-HOSPID    NOT =   RECE65-HOSPID       )
               OR     ( RECE64-SRYYM     NOT =   RECE65-SRYYM        )
               OR     ( RECE64-NYUGAIKBN NOT =   RECE65-NYUGAIKBN    )
               OR     ( RECE64-PTID      NOT =   RECE65-PTID         )
               OR     ( RECE64-RECEKA    NOT =   RECE65-RECEKA       )
               OR     ( RECE64-TEISYUTUSAKI
                                         NOT =   RECE65-TEISYUTUSAKI )
               OR     ( RECE64-RECESYUBETU
                                         NOT =   RECE65-RECESYUBETU  )
               OR     ( RECE64-HKNJANUM  NOT =   RECE65-HKNJANUM     )
               OR     ( RECE64-HOJOKBN   NOT =   RECE65-HOJOKBN      )
               OR     ( RECE64-TEKSTYMD  NOT =   RECE65-TEKSTYMD     )
               OR     ( RECE64-ZAINUM    NOT =   RECE65-ZAINUM       )
               OR     ( RECE64-ZAIREN    NOT =   RECE65-ZAIREN       )
      *
      *
               MOVE          RECE65-REC       TO      RECE651-REC
               WRITE         RECE651-REC
               ADD     1                 TO  CNT-RECE65
      *
               PERFORM 990-RECE65-NEXT-SEC
      *
           END-PERFORM
      *
           .
       2001-RECE65-TENSOU-EXT.
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
           DISPLAY "RECE62  IN  " CNT-RECE62 
           DISPLAY "RECE64  CNT " CNT-RECE64 
           DISPLAY "RECE65  CNT " CNT-RECE65 
           DISPLAY "*** ORCR0660 END ***"
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
           CLOSE                       RECE62-FILE
      *
           CLOSE                       RECE64-FILE
      *
           CLOSE                       RECE65-FILE
      *
           CLOSE                       RECE641-FILE     
           CLOSE                       RECE651-FILE     
      *
           .
       310-FILE-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       990-RECE62-READ-SEC           SECTION.
      *
           READ    RECE62-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
                   MOVE    2           TO  SPA-STS
               NOT AT  END
                   ADD     1           TO  CNT-RECE62
                   ADD     1           TO  CNT-IN-COMMIT
                   MOVE    ZERO        TO  FLG-END
           END-READ
      *
           .
       990-RECE62-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０４データ読み
      ****************************************************************
       990-RECE64-NEXT-SEC           SECTION.
      *
           READ    RECE64-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE64
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE64
           END-READ
      *
           .
       990-RECE64-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０５データ読み
      ****************************************************************
       990-RECE65-NEXT-SEC           SECTION.
      *
           READ    RECE65-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE65
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE65
           END-READ
      *
           .
       990-RECE65-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為読込
      *****************************************************************
       SRYACT-READ-SEC           SECTION.
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
       SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソルクローズ処理
      *****************************************************************
       CSR-CLOSE-SEC            SECTION.
      *
           INITIALIZE                  MCPAREA
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       CSR-CLOSE-EXT.
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
       900-DBCLOSE-EXT.
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
