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
       PROGRAM-ID.             ORCR0420.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト（労災・自賠責）
      *  コンポーネント名  : 月次業務　労災自賠責明細書ファイル作成
      *                      （診療区分別点数集計）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/06/18    MCC−門脇　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-門脇    02.09.12  自賠責対応　　　　
      *  01.00.02    NACL-藤原    02.09.20  検査の編集のために回数を
      *                                     全て編集する
      *  01.00.03    NACL-門脇    02.10.02  摘要出力項目変更の為の編集
      *  01.00.04    NACL-門脇    02.11.06  約束処方時の点数欄表示修正
      *  01.00.05    NACL-門脇    02.11.21  自賠責（ポリネック等の対応）
      *  01.00.06    NACL-門脇    02.11.26  検診コードを編集できるよう修正
      *  01.00.07    NACL-藤原    02.12.02  酸素の時単価を表示するように追加
      *  01.00.08    NACL-藤原    03.01.22  データ区分の追加
      *  01.00.09    NACL-門脇    03.02.06  コメントカウントフラグの編集追加
      *  01.00.10    NACL-門脇    03.03.10  診療科１０から２０へ
      *  01.00.11    NACL-藤原    03.04.09  特定器材（画像診断のフィルム以外）
      *                                     の単価を表示するように修正
      *  01.00.12    NACL-門脇    03.04.14  自賠責の小数点以下金額計算
      *                                     四捨五入に変更
      *  01.00.13    NACL-門脇    03.05.08  名称有効桁のセット
      *  01.00.14    NACL-門脇    03.05.13  自賠責：腰部固定帯加算対応
      *  01.00.15    NACL-門脇    03.05.20  自賠責：療養担当手当て対応
      *  01.00.16    NACL-門脇    03.05.22  残量廃棄の数量セット
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
           SELECT  RECE41-FILE     ASSIGN  RECE41PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE41-KEY
                                   FILE    STATUS  IS  STS-RECE41.
           SELECT  RECE44-FILE     ASSIGN  RECE44PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE44-KEY
                                   FILE    STATUS  IS  STS-RECE44.
           SELECT  RECE444-FILE    ASSIGN  RECE44PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE444-KEY
                                   FILE    STATUS  IS  STS-RECE44.
           SELECT  RECE4A-FILE     ASSIGN  RECE4APARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE4A-KEY
                                   FILE    STATUS  IS  STS-RECE4A.
           SELECT  RECE4A4-FILE    ASSIGN  RECE4APARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE4A4-KEY
                                   FILE    STATUS  IS  STS-RECE4A.
           SELECT  RECE45-FILE     ASSIGN  RECE45PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE45-KEY
                                   FILE    STATUS  IS  STS-RECE45.
           SELECT  RECE455-FILE    ASSIGN  RECE45PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE455-KEY
                                   FILE    STATUS  IS  STS-RECE45.
           SELECT  RECE4B-FILE     ASSIGN  RECE4BPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE4B-KEY
                                   FILE    STATUS  IS  STS-RECE4B.
           SELECT  RECE4B5-FILE    ASSIGN  RECE4BPARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE4B5-KEY
                                   FILE    STATUS  IS  STS-RECE4B.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
       FD  RECE41-FILE.
       01  RECE41-REC. 
           COPY    "CPRCF041.INC".
      *
       FD  RECE44-FILE.
       01  RECE44-REC. 
           COPY    "CPRCF044.INC".
      *
       FD  RECE444-FILE.
       01  RECE444-REC. 
           COPY    "CPRCF044.INC"  REPLACING  //RECE44//
                                   BY         //RECE444//.
      *
       FD  RECE4A-FILE.
       01  RECE4A-REC. 
           COPY    "CPRCF044.INC"  REPLACING  //RECE44//
                                   BY         //RECE4A//.
      *
       FD  RECE4A4-FILE.
       01  RECE4A4-REC. 
           COPY    "CPRCF044.INC"  REPLACING  //RECE44//
                                   BY         //RECE4A4//.
      *
       FD  RECE45-FILE.
       01  RECE45-REC. 
           COPY    "CPRCF045.INC".
      *
       FD  RECE455-FILE.
       01  RECE455-REC. 
           COPY    "CPRCF045.INC"  REPLACING  //RECE45//
                                   BY         //RECE455//.
      *
       FD  RECE4B-FILE.
       01  RECE4B-REC. 
           COPY    "CPRCF045.INC"  REPLACING  //RECE45//
                                   BY         //RECE4B//.
      *
       FD  RECE4B5-FILE.
       01  RECE4B5-REC. 
           COPY    "CPRCF045.INC"  REPLACING  //RECE45//
                                   BY         //RECE4B5//.
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE41//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE44//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE4A//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE45//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE4B//.
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE41                              PIC X(02).
           03  STS-RECE44                              PIC X(02).
           03  STS-RECE45                              PIC X(02).
           03  STS-RECE4A                              PIC X(02).
           03  STS-RECE4B                              PIC X(02).
           03  STS-RECEERR                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-SRYACCT                             PIC 9(01).
           03  FLG-SRYACT                              PIC 9(01).
           03  FLG-TENSU                               PIC 9(01).
           03  FLG-ZAITAKU                             PIC 9(01).
           03  FLG-OSINKBN                             PIC 9(01).
           03  FLG-PTCOM                               PIC 9(01).
           03  FLG-SYSKANRI                            PIC 9(01).
           03  FLG-DAY                                 PIC 9(01).
           03  FLG-SP                                  PIC 9(01). 
           03  FLG-ZANHAIKI                            PIC 9(01).
           03  FLG-RECE45                              PIC 9(01).
           03  FLG-REWRITE                             PIC 9(01).
      *
      *    基本点数の非表示判定用フラグ
       01  FLG-KHNTEN-AREA.
           03  FLG-KHNTEN2                             PIC 9(01).
           03  FLG-KHNTEN3                             PIC 9(01).
           03  FLG-KHNTEN4                             PIC 9(01).
           03  FLG-KHNTEN5                             PIC 9(01).
           03  FLG-KHNTEN6                             PIC 9(01).
           03  FLG-KHNTEN15                            PIC 9(01).
           03  FLG-KHNTEN18                            PIC 9(01).
           03  FLG-KHNTEN19                            PIC 9(01).
      *
      *    基本点数の非表示判定用フラグ（自賠責用）
       01  FLG-KHNTEN-JI-AREA.                                          
           03  FLG-KHNTEN10-JI                         PIC 9(01).       
           03  FLG-KHNTEN13-JI                         PIC 9(01).       
           03  FLG-KHNTEN14-JI                         PIC 9(01).       
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                                  PIC 9(06).
           03  CNT-IN-COMMIT                           PIC 9(06).
           03  CNT-OUT1                                PIC 9(06).
           03  CNT-OUT2                                PIC 9(06).
           03  CNT-OUT3                                PIC 9(06).
           03  CNT-OUT4                                PIC 9(06).
           03  CNT-OUT5                                PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                                     PIC 9(03).
           03  IDX2                                    PIC 9(03).
           03  IDX3                                    PIC 9(03).
           03  IDX4                                    PIC 9(03).
           03  ID1                                     PIC 9(03). 
           03  IDY                                     PIC 9(03).
           03  IDW                                     PIC 9(03).
           03  NUM-IDX                                 PIC 9(01).
      *
      *    パス名領域
       01  WK-PATH                                     PIC X(20).
      *
      *    剤情報退避領域
       01  WK-ZAIKAISU                                 PIC S9(07).
       01  WK-ZAITEN                                   PIC S9(08).
       01  WK-SYUTEN                                   PIC S9(08).
       01  WK-KIZAITEN                                 PIC S9(08).
       01  WK-YKZTEN                                   PIC S9(08).
      *
      *    点数テーブル検索用対象日領域
       01  WK-TAIHI-AREA.
           03  WK-TAIHI-DAY                            PIC 9(02).
           03  WK-TAIHI-FLG                            PIC 9(01).
           03  WK-TAIHI-SRYYMD.
               05  WK-TAIHI-SRYYM                      PIC 9(06).
               05  WK-TAIHI-SRYD                       PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PATH                                PIC X(64).
           03  WRK-PARA.
               05  WRK-PARA-SRYYM                      PIC X(06).
               05  WRK-PARA-TERMID                     PIC X(16).
               05  WRK-PARA-SYSYMD                     PIC X(08).
               05  WRK-PARA-JOBID                      PIC 9(07).
               05  WRK-PARA-SHELLID                    PIC X(08).
      *
           03  WRK-RECEERR                             PIC X(200).
      *
           03  WRK-KEISAN                              PIC 9(09).
           03  WRK-TEN                                 PIC 9(09).
           03  WRK-TANKA                               PIC 9(02)V99.
           03  WRK-MEISAI-CNT                          PIC 9(04).
           03  WRK-SRYCDTOTAL                          PIC 9(14).
           03  WRK-SURYOUTOTAL                         PIC 9(07)V9(03).
           03  WRK-KSNRATE                             PIC 9V99.    
           03  WRK-SRYCD                               PIC 9(09).   
           03  WRK-YOUBUKASAN                          PIC 9(07).
           03  WRK-RYOYOTEATE                          PIC 9(07).
           03  WRK-RYOYOTEATE2                         PIC 9(07).
      *
           03  WRK-DAY                                 PIC 9(02).
      *
           03  WRK-ZAIKAISU-XXX                        PIC 9(03).
      *
           03  WRK-TANICD                              PIC 9(03).
           03  WRK-TANIMOJISU                          PIC 9(01).
           03  WRK-TANINAME                            PIC X(24).
           03  WRK-SRYSURYO                            PIC 9(05)V9(03).
           03  WRK-SRYSURYO2                           PIC 9(05).
           03  WRK-SRYSURYO3                           PIC 9(05).
           03  WRK-RENNUM                              PIC 9(02).
      *
      *    数字半角全角変換用     
           03  WRK-CHAR-IDX                    PIC 9(02).
           03  WRK-CHAR-HENKAN-AREA.
               05  WRK-CHAR-X                  PIC X(20).
               05  WRK-CHAR-N                  PIC X(40).
               05  WRK-CHAR-CNT                PIC 9(02).
               05  WRK-CHAR-N-CNT              PIC 9(02).
      *     
      *    単価編集用     
           03  WRK-TANKA-9                     PIC 9(09)V9(02).
           03  WRK-TANKA-R  REDEFINES  WRK-TANKA-9.
               05  WRK-TANKA-S1                PIC 9(09).
               05  WRK-TANKA-S2                PIC 9(02).
           03  WRK-TANKA-X.
               05  WRK-TANKA-Z1                PIC ZZZZZZZZ9.
               05  WRK-TANKA-Z2                PIC X(01).
               05  WRK-TANKA-Z3                PIC ZZ.
      *
      *---------------------------------------------------------------
      *  回数減算用退避領域
      *
      *    特定疾患処方管理加算（処方料）
           03  WRK-TOKUTEI-SKAN                        PIC 9(03).
      *    処方料（乳幼児）加算
           03  WRK-NYUYOUJI-SKAN                       PIC 9(03).
      *    特定疾患処方管理加算（処方せん料）
           03  WRK-TOKUTEI-SKAN2                       PIC 9(03).
      *    処方せん（乳幼児）加算
           03  WRK-NYUYOUJI-SHOKAN                     PIC 9(03).
      *    処方料（麻・向・毒・覚）
           03  WRK-MADOKU-SHOHO                        PIC 9(03).
      *---------------------------------------------------------------
      *
      *    固定値
       01  CONST-AREA.
      *    継続管理加算
           03  CONS-KEIZOKU1   PIC X(09)     VALUE "112007170".
           03  CONS-KEIZOKU2   PIC X(09)     VALUE "112702270".
      *    処方せん料
           03  CONS-SHOHOSEN1 PIC X(09)      VALUE "120002710".
           03  CONS-SHOHOSEN2 PIC X(09)      VALUE "120002810".
           03  CONS-SHOHOSEN3 PIC X(09)      VALUE "120002910".
           03  CONS-SHOHOSEN4 PIC X(09)      VALUE "120003010".
      *    処方せん（乳幼児）加算
           03  CONS-SHOHOKSN1  PIC X(09)     VALUE "120002470".
           03  CONS-SHOHOKSN2  PIC X(09)     VALUE "120002570".
      *    薬剤料逓減（９０／１００）（内服薬）
           03  CONS-YAKTEIGEN  PIC X(09)     VALUE "630010002".
      *    粉砕（コメント）
           03  CONS-FUNSAI-COMMENT PIC X(09) VALUE "099209901".
      *    採血（Ｂ−Ａ）
           03  CONS-SAIKETSU1      PIC X(09) VALUE "160101210".
      *    採血（Ｂ−Ｖ）
           03  CONS-SAIKETSU2      PIC X(09) VALUE "160095710".
      *    採血（Ｂ−Ｃ）
           03  CONS-SAIKETSU3      PIC X(09) VALUE "160095810".
      *    特記事項
           03  CONS-TOKKI1         PIC X(14) VALUE "00000099990101".
           03  CONS-TOKKI2         PIC X(14) VALUE "00000099990102".
           03  CONS-TOKKI3         PIC X(14) VALUE "00000099990103".
           03  CONS-TOKKI4         PIC X(14) VALUE "00000099990104".
           03  CONS-TOKKI5         PIC X(14) VALUE "00000099990105".
           03  CONS-TOKKI7         PIC X(14) VALUE "00000099990107".
           03  CONS-TOKKI8         PIC X(14) VALUE "00000099990108".
           03  CONS-TOKKI9         PIC X(14) VALUE "00000099990109".
           03  CONS-TOKKI10        PIC X(14) VALUE "00000099990110".
           03  CONS-TOKKI11        PIC X(14) VALUE "00000099990111".
           03  CONS-TOKKI12        PIC X(14) VALUE "00000099990112".
      *    乳幼児加算
           03  CONS-NYUKSN1        PIC X(09) VALUE "111000370".         
           03  CONS-NYUKSN2        PIC X(09) VALUE "111011470".
      *    再診（３月超）（５回超）など
      *    （４６５に関係あり）
           03  CONS-SAISHIN-A1     PIC X(09) VALUE "101120060".
      **   03  CONS-SAISHIN-A2     PIC X(09) VALUE "112001210".
      **   03  CONS-SAISHIN-A3     PIC X(09) VALUE "112701110".
      **   03  CONS-SAISHIN-A4     PIC X(09) VALUE "112000970".
      **   03  CONS-SAISHIN-A5     PIC X(09) VALUE "112001070".
      **   03  CONS-SAISHIN-A6     PIC X(09) VALUE "112006970".
      **   03  CONS-SAISHIN-A7     PIC X(09) VALUE "112007070".
      **   03  CONS-SAISHIN-A8     PIC X(09) VALUE "112001310".
      **   03  CONS-SAISHIN-A9     PIC X(09) VALUE "112701210".
      **   03  CONS-SAISHIN-A10    PIC X(09) VALUE "112001110".
      **   03  CONS-SAISHIN-A11    PIC X(09) VALUE "112701010".
      **   03  CONS-SAISHIN-A12    PIC X(09) VALUE "112001410".
      **   03  CONS-SAISHIN-A13    PIC X(09) VALUE "112701310".
      *    外来管理加算（３月超）（５回超）
      *    （４６０に関係あり）
           03  CONS-GAIRAI         PIC X(09) VALUE "101120090".
      *    労災自賠責関係
           03  CONS-ROUSAI1    PIC X(09)   VALUE   "101110010".
           03  CONS-ROUSAI2    PIC X(09)   VALUE   "101110020".
           03  CONS-ROUSAI3    PIC X(09)   VALUE   "101110030".
           03  CONS-ROUSAI4    PIC X(09)   VALUE   "101120030".
           03  CONS-ROUSAI5    PIC X(09)   VALUE   "101120040".
           03  CONS-ROUSAI6    PIC X(09)   VALUE   "101120050".
           03  CONS-ROUSAI7    PIC X(09)   VALUE   "101120060".
           03  CONS-ROUSAI8    PIC X(09)   VALUE   "101130010".
           03  CONS-ROUSAI9    PIC X(09)   VALUE   "101130020".
           03  CONS-ROUSAI10   PIC X(09)   VALUE   "101130030".
           03  CONS-ROUSAI11   PIC X(09)   VALUE   "101130040".
           03  CONS-ROUSAI12   PIC X(09)   VALUE   "101130050".
           03  CONS-ROUSAI13   PIC X(09)   VALUE   "101130060".
           03  CONS-ROUSAI14   PIC X(09)   VALUE   "101130070".
           03  CONS-ROUSAI15   PIC X(09)   VALUE   "101130080".
           03  CONS-ROUSAI16   PIC X(09)   VALUE   "101130090".
           03  CONS-ROUSAI17   PIC X(09)   VALUE   "101130100".
      *
           03  CONS-ROUCOM1    PIC X(09)   VALUE   "840800001".
           03  CONS-ROUCOM2    PIC X(09)   VALUE   "840800002". 
      *
      *    腰部固定帯加算
           03  CONS-YOUBUKASAN PIC X(09)   VALUE   "140037490".
      *    療養担当手当て
           03  CONS-RYOYOTEATE PIC X(09)   VALUE   "199000610".
      *
      *
      *    フィルム料（乳幼児）加算
           03  CONS-FILM-YOUJI-KASAN  
                               PIC X(09)   VALUE   "799990070".
      *    酸素補正率
           03  CONS-SANSO      PIC X(09)   VALUE   "770020070".
      *    高気圧酸素加算
           03  CONS-SANSO2     PIC X(09)   VALUE   "770030070".
      *    残量廃棄
           03  CONS-ZANHAIKI   PIC X(09)   VALUE   "099309901".
      *
      *****酸素 
      *****COPY    "CMSANSOTBL.INC".
      *
      *   日本語数字
       01  TBL-SUJI-AREA.
           03  FILLER          PIC X(20)   VALUE
              "１２３４５６７８９０".
       01  TBL-SUJI-R          REDEFINES   TBL-SUJI-AREA.
           03  TBL-SUJI        PIC X(02)   OCCURS   10.
      *
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
      *    点数
           COPY    "CPTENSU.INC".
      *
      *    患者コメント
       01  PTCOM-REC.
       COPY    "CPPTCOM.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    労災自賠医療機関情報
           COPY    "CPSK4001.INC".
      *
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *    数値変換サブ
           COPY    "CPORCSNUM.INC".
      *    チェックディジット（モジュラス１１用）算出サブ
           COPY    "CPORCCHKDGT11.INC".
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
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
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL   FLG-END =   1 
      *
           PERFORM 300-TERM-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SPA-AREA
                                       WRK-AREA
      *
           MOVE    ZERO                TO  FLG-END
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
           MOVE    "ORCR0420"      TO  JOB-PGID
           MOVE    "診療区分別点数集計（労災・自賠責）"                 
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECE410"           TO  RECE41PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE41PARA-TERMID
      *
           MOVE    "RECE440"           TO  RECE44PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE44PARA-TERMID
           MOVE    "RECE450"           TO  RECE45PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE45PARA-TERMID
      *
           MOVE    "RECE441"           TO  RECE4APARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE4APARA-TERMID
           MOVE    "RECE451"           TO  RECE4BPARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE4BPARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
      *    システム管理マスタ（４００１）から点数単価の取得
           INITIALIZE                         SYS-4001-REC
           MOVE    "4001"               TO    SYS-4001-KANRICD
           MOVE    "*"                  TO    SYS-4001-KBNCD
           MOVE    WRK-PARA-SRYYM       TO    ORC-DBYMD (1:6)
           MOVE    "01"                 TO    ORC-DBYMD (7:2)
           MOVE    SYS-4001-REC         TO    MCPDATA-REC
           MOVE    "SYSKANRI-KEY"       TO    WRK-PATH
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    SYSKANRI-REC     TO  SYS-4001-REC
               EVALUATE  SYS-4001-TENKBN
                   WHEN  "1"
                       MOVE     11.5    TO    WRK-TANKA
                   WHEN  "2"
                       MOVE     12.0    TO    WRK-TANKA
               END-EVALUATE
           ELSE
               MOVE    "労災自賠医療機関情報が取得できませんでした"     
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF
      *                             
      *    レセプト処理
           OPEN    OUTPUT              RECE444-FILE
           CLOSE                       RECE444-FILE
      *
           OPEN    OUTPUT              RECE455-FILE
           CLOSE                       RECE455-FILE
      *
           OPEN    OUTPUT              RECE4A4-FILE
           CLOSE                       RECE4A4-FILE
      *
           OPEN    OUTPUT              RECE4B5-FILE
           CLOSE                       RECE4B5-FILE
      *
           OPEN    OUTPUT              RECE44-FILE
      ***                              RECE45-FILE
           OPEN    I-O                 RECE45-FILE
      *
           OPEN    OUTPUT              RECE4A-FILE
                                       RECE4B-FILE
      
      *
           OPEN    I-O                 RECE41-FILE
      *
           PERFORM     RECE41-READ-SEC     
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
           PERFORM     210-HENSYU-SEC
      *      
           PERFORM     RECE41-READ-SEC 
      	   IF      CNT-IN-COMMIT   =   300
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
      *    編集処理
      *****************************************************************
       210-HENSYU-SEC                   SECTION.
      *
           IF      RECE41-HKNKBN   NOT  =   "3"
      *
              INITIALIZE                   FLG-KHNTEN-AREA
              INITIALIZE                   FLG-KHNTEN-JI-AREA           
      *
              PERFORM    VARYING    IDX    FROM   1   BY   1
                         UNTIL     (IDX      >   20)  OR
                                   (RECE41-SRYKA(IDX)   =   SPACE)
                  PERFORM    RECE44-HENSYU-SEC
              END-PERFORM
      *
              IF      RECE41-HKNKBN   NOT  =   "4"                      
                  PERFORM     KHNTEN-CLEAR-SEC
              ELSE                                                      
                  PERFORM     KHNTEN-JI-CLEAR-SEC                       
              END-IF                                                    
      *
           ELSE
      *
              PERFORM    VARYING    IDX    FROM   1   BY   1
                         UNTIL     (IDX      >   20)  OR
                                   (RECE41-SRYKA(IDX)   =   SPACE)
                  PERFORM    RECE44-HENSYU2-SEC
              END-PERFORM
      *
           END-IF
      *
           PERFORM     RECE41-REWRITE-SEC
           .
       210-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの作成
      *****************************************************************
       RECE44-HENSYU-SEC                SECTION.
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE41-HOSPID        TO      ACCT-HOSPID
           MOVE    RECE41-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE41-PTID          TO      ACCT-PTID
           MOVE    RECE41-SRYKA(IDX)    TO      ACCT-SRYKA
           MOVE    RECE41-SRYYM         TO      ACCT-SRYYM
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACCT-KEY2"       TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACCT-KEY2"   TO      ORC-DBPATH
               PERFORM  SRYACCT-READ-SEC
               PERFORM  UNTIL     FLG-SRYACCT   =   1 
                   IF      ACCT-HKNCOMBI   =   RECE41-HKNCOMBI
      *
                        IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                             (ACCT-ZAIKAISU  NOT =    ZERO)
                               MOVE    ZERO    TO      WRK-TEN
                                                       WRK-MEISAI-CNT
                                                       WRK-SRYCDTOTAL
                                                       WRK-SURYOUTOTAL
                                                       WRK-YOUBUKASAN
                                                       WRK-RYOYOTEATE
      *
                               MOVE    ZERO    TO      WRK-SRYSURYO
                                                       WRK-SRYSURYO2
                                                       WRK-SRYSURYO3
                                                       WRK-TANICD
                                                       WRK-TANIMOJISU
                               MOVE    SPACE   TO      WRK-TANINAME
      *
                               PERFORM   RECE44-TENSOU-SEC
                               PERFORM   RECE45-HENSYU-SEC
                               PERFORM   RECE44-WRITE-SEC
                        ELSE
                             IF   ACCT-ZAIKAISU  NOT =    ZERO
                               IF   ACCT-SRYKBN  =  "11"  OR  "12" 
                                                          OR  "99" 
                                 IF  ACCT-SRYCDTOTAL = CONS-TOKKI1  OR
                                                       CONS-TOKKI2  OR
                                                       CONS-TOKKI3  OR
                                                       CONS-TOKKI4  OR
                                                       CONS-TOKKI5  OR
                                                       CONS-TOKKI7  OR
                                                       CONS-TOKKI8  OR
                                                       CONS-TOKKI9  OR
                                                       CONS-TOKKI10 OR
                                                       CONS-TOKKI11 OR
                                                       CONS-TOKKI12
                                      CONTINUE
                                 ELSE
                                      MOVE  ZERO  TO  WRK-TEN
                                                      WRK-MEISAI-CNT
                                                      WRK-SRYCDTOTAL
                                                      WRK-SURYOUTOTAL
                                                      WRK-YOUBUKASAN
                                                      WRK-RYOYOTEATE
      *
                                      MOVE  ZERO  TO  WRK-SRYSURYO
                                                      WRK-SRYSURYO2
                                                      WRK-SRYSURYO3
                                                      WRK-TANICD
                                                      WRK-TANIMOJISU
                                      MOVE  SPACE TO  WRK-TANINAME
      *
                                      PERFORM   RECE44-TENSOU-SEC
                                      PERFORM   RECE45-HENSYU-SEC
                                      PERFORM   RECE44-WRITE-SEC
                                 END-IF
                               END-IF
                             END-IF
                        END-IF
      *
                   END-IF
                   MOVE     "SRYACCT-KEY2"   TO   ORC-DBPATH
                   PERFORM   SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE   "SRYACCT-KEY2"      TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
           .
       RECE44-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの作成
      *****************************************************************
       RECE44-HENSYU2-SEC                SECTION.
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE41-HOSPID        TO      ACCT-HOSPID
           MOVE    RECE41-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE41-PTID          TO      ACCT-PTID
           MOVE    RECE41-SRYKA(IDX)    TO      ACCT-SRYKA
           MOVE    RECE41-SRYYM         TO      ACCT-SRYYM
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACCT-KEY2"       TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACCT-KEY2"   TO      ORC-DBPATH
               PERFORM  SRYACCT-READ-SEC
               PERFORM  UNTIL     FLG-SRYACCT   =   1 
      *
                   MOVE   RECE41-TEKSTYMD(7:2)   TO   WRK-DAY
                   IF  ACCT-DAY(1 WRK-DAY)   NOT =    ZERO
                        MOVE    1       TO   FLG-DAY
                   ELSE
                        MOVE    ZERO    TO   FLG-DAY  
                   END-IF
      *
                   IF      ACCT-HKNCOMBI   =   RECE41-HKNCOMBI
                   AND     FLG-DAY         =   1
                           IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                                (ACCT-ZAIKAISU  NOT =    ZERO)
                               MOVE  ACCT-DAY(1 WRK-DAY)  
                                               TO    WRK-ZAIKAISU-XXX
                               MOVE    ZERO    TO    WRK-TEN
                                                     WRK-MEISAI-CNT
                                                     WRK-SRYCDTOTAL
                                                     WRK-SURYOUTOTAL
                                                     WRK-YOUBUKASAN
                                                     WRK-RYOYOTEATE
      *
                               MOVE    ZERO    TO    WRK-SRYSURYO
                                                     WRK-SRYSURYO2
                                                     WRK-SRYSURYO3
                                                     WRK-TANICD
                                                     WRK-TANIMOJISU
                               MOVE    SPACE   TO    WRK-TANINAME
      *
                               PERFORM   RECE44-TENSOU-SEC
                               PERFORM   RECE45-HENSYU-SEC
                               PERFORM   RECE44-WRITE-SEC
                           ELSE
                             IF   ACCT-ZAIKAISU  NOT =    ZERO
                               IF   ACCT-SRYKBN  =  "11"  OR  "12" 
                                                          OR  "99" 
                                 IF  ACCT-SRYCDTOTAL = CONS-TOKKI1  OR
                                                       CONS-TOKKI2  OR
                                                       CONS-TOKKI3  OR
                                                       CONS-TOKKI4  OR
                                                       CONS-TOKKI5  OR
                                                       CONS-TOKKI7  OR
                                                       CONS-TOKKI8  OR
                                                       CONS-TOKKI9  OR
                                                       CONS-TOKKI10 OR
                                                       CONS-TOKKI11 OR
                                                       CONS-TOKKI12
                                      CONTINUE
                                 ELSE
                                      MOVE  ACCT-DAY(1 WRK-DAY)  
                                                  TO  WRK-ZAIKAISU-XXX
                                      MOVE  ZERO  TO  WRK-TEN
                                                      WRK-MEISAI-CNT
                                                      WRK-SRYCDTOTAL
                                                      WRK-SURYOUTOTAL
                                                      WRK-YOUBUKASAN
                                                      WRK-RYOYOTEATE
      *
                                      MOVE  ZERO  TO  WRK-SRYSURYO
                                                      WRK-SRYSURYO2
                                                      WRK-SRYSURYO3
                                                      WRK-TANICD
                                                      WRK-TANIMOJISU
                                      MOVE  SPACE TO  WRK-TANINAME
      *
                                      PERFORM   RECE44-TENSOU-SEC
                                      PERFORM   RECE45-HENSYU-SEC
                                      PERFORM   RECE44-WRITE-SEC
                                 END-IF
                               END-IF
                             END-IF
                           END-IF
                   END-IF
                   MOVE     "SRYACCT-KEY2"   TO   ORC-DBPATH
                   PERFORM   SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE   "SRYACCT-KEY2"      TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
           .
       RECE44-HENSYU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送
      *****************************************************************
       RECE44-TENSOU-SEC                SECTION.
      *
           MOVE    SPACE                TO      RECE44-REC
           INITIALIZE                           RECE44-REC
           MOVE    RECE41-HOSPID        TO      RECE44-HOSPID
           MOVE    RECE41-SRYYM         TO      RECE44-SRYYM
           MOVE    RECE41-NYUGAIKBN     TO      RECE44-NYUGAIKBN
           MOVE    RECE41-PTID          TO      RECE44-PTID
           MOVE    RECE41-RECEKA        TO      RECE44-RECEKA
           MOVE    RECE41-HKNID         TO      RECE44-HKNID
           MOVE    RECE41-TEKSTYMD      TO      RECE44-TEKSTYMD
           MOVE    RECE41-PTNUM         TO      RECE44-PTNUM 
           MOVE    ACCT-ZAINUM          TO      RECE44-ZAINUM
           MOVE    ACCT-SRYKBN          TO      RECE44-SRYKBN
           MOVE    ACCT-SRYKA           TO      RECE44-SRYKA
           MOVE    ACCT-HKNCOMBI        TO      RECE44-HKNCOMBI
           MOVE    ACCT-JIHOKBN         TO      RECE44-JIHOKBN
           MOVE    ACCT-ZAITEN          TO      RECE44-ZAITEN
           MOVE    ACCT-SRYCDTOTAL      TO      RECE44-SRYCDTOTAL
           MOVE    ACCT-SURYOUTOTAL     TO      RECE44-SURYOUTOTAL
           MOVE    ACCT-MEISAISU        TO      RECE44-MEISAISU
           IF      RECE41-HKNKBN   NOT  =   "3"
              MOVE    ACCT-ZAIKAISU     TO      RECE44-ZAIKAISU
           ELSE
              MOVE    WRK-ZAIKAISU-XXX  TO      RECE44-ZAIKAISU
           END-IF
           MOVE    ACCT-SYUTEN1         TO      RECE44-SYUTEN1
           MOVE    ACCT-SYUTEN2         TO      RECE44-SYUTEN2
           MOVE    ACCT-YKZTEN          TO      RECE44-YKZTEN
           MOVE    ACCT-KIZAITEN        TO      RECE44-KIZAITEN
           IF   RECE41-HKNKBN     =  "4"
              IF  ACCT-SRYKBN     =  "70"
                  COMPUTE  RECE44-SYUTEN1   =  RECE44-SYUTEN1
                                            -  RECE44-SYUTEN2
                  COMPUTE  RECE44-KIZAITEN  =  RECE44-KIZAITEN
                                            +  RECE44-SYUTEN2
              END-IF
           END-IF
           MOVE    ACCT-DRCD            TO      RECE44-DRCD
           MOVE    ACCT-ZAIREQFLG       TO      RECE44-ZAIREQFLG
           MOVE    ACCT-TEIGENRATE      TO      RECE44-TEIGENRATE
      *
           IF      RECE41-HKNKBN   NOT  =   "3"
               MOVE        ZERO             TO      WK-TAIHI-DAY
               MOVE        ZERO             TO      WK-TAIHI-FLG
               PERFORM     VARYING   IDX3   FROM    1    BY   1
                           UNTIL     IDX3   >       4
                   PERFORM     VARYING   IDX2   FROM    1    BY   1
                               UNTIL     IDX2   >       31
                       MOVE    ACCT-DAY(IDX3 IDX2)  TO
                                            RECE44-KAISU (IDX3 IDX2)
                       IF     (WK-TAIHI-FLG            =   ZERO)   AND
                              (ACCT-DAY(1 IDX2)    NOT =   ZERO)
                           MOVE     IDX2    TO      WK-TAIHI-DAY
                           MOVE     1       TO      WK-TAIHI-FLG
                       END-IF    
                   END-PERFORM
               END-PERFORM
           ELSE
               PERFORM     VARYING   IDX3   FROM    1    BY   1
                           UNTIL     IDX3   >       4
                  MOVE    ACCT-DAY(IDX3 WRK-DAY)  
                                       TO    RECE44-KAISU(IDX3 WRK-DAY)
              END-PERFORM                         
              MOVE    WRK-DAY          TO    WK-TAIHI-DAY
           END-IF
           .
       RECE44-TENSOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの作成
      *****************************************************************
       RECE45-HENSYU-SEC               SECTION.
      *
           INITIALIZE                           SRYACT-REC
           MOVE    ACCT-HOSPID          TO      SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN       TO      SRY-NYUGAIKBN
           MOVE    ACCT-PTID            TO      SRY-PTID
           MOVE    ACCT-SRYKA           TO      SRY-SRYKA
           MOVE    ACCT-SRYYM           TO      SRY-SRYYM
           MOVE    ACCT-ZAINUM          TO      SRY-ZAINUM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACT-KEY2"        TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACT-KEY2"    TO      ORC-DBPATH
               PERFORM  SRYACT-READ-SEC
               PERFORM  UNTIL  FLG-SRYACT    =    1
                   MOVE   ZERO   TO  FLG-ZANHAIKI
                   MOVE   ZERO   TO  WRK-RENNUM
                   PERFORM   RECE45-TENSOU-SEC
                   PERFORM   RECE41-HENSYU-SEC
                   PERFORM   RECE45-WRITE-SEC
                   IF  FLG-ZANHAIKI  =  1
                      PERFORM  RECE45-REWRITE-SEC
                   END-IF
                   MOVE     "SRYACT-KEY2"    TO   ORC-DBPATH
                   PERFORM   SRYACT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE   "SRYACT-KEY2"      TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
           .
       RECE45-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送
      *****************************************************************
       RECE45-TENSOU-SEC                SECTION.
      *
           MOVE    SPACE                TO      RECE45-REC
           INITIALIZE                           RECE45-REC
           MOVE    RECE41-HOSPID        TO      RECE45-HOSPID
           MOVE    RECE41-SRYYM         TO      RECE45-SRYYM
           MOVE    RECE41-NYUGAIKBN     TO      RECE45-NYUGAIKBN
           MOVE    RECE41-PTID          TO      RECE45-PTID
           MOVE    RECE41-RECEKA        TO      RECE45-RECEKA
           MOVE    RECE41-HKNID         TO      RECE45-HKNID
           MOVE    RECE41-TEKSTYMD      TO      RECE45-TEKSTYMD
           MOVE    RECE41-PTNUM         TO      RECE45-PTNUM
           MOVE    SRY-ZAINUM           TO      RECE45-ZAINUM
           MOVE    SRY-RENNUM           TO      RECE45-RENNUM
           MOVE    SRY-SRYKA            TO      RECE45-SRYKA
           MOVE    SRY-SRYKBN           TO      RECE45-SRYKBN
           MOVE    SRY-SRYSYUKBN        TO      RECE45-SRYSYUKBN
           MOVE    SRY-JIHIMONEYTOTAL   TO      RECE45-JIHIMONEY
      * 
           MOVE    ZERO                 TO      FLG-OSINKBN
                                                IDX4
      *
           PERFORM     VARYING   IDX2   FROM    1    BY   1
                       UNTIL    (IDX2      >    5)    OR
                                (SRY-SRYCD(IDX2)  =   SPACE)
             IF      SRY-SRYCD(IDX2)(1:1)     =   "0" OR  "1" OR  
                                                  "6" OR  "7" OR
                                                  "8"
      *
               ADD     1                  TO    IDX4                                  *
               PERFORM  RECE45-TENSOU-COMCNT-HEN-SEC
      *
               MOVE    SRY-SRYCD(IDX2)    TO    RECE45-SRYCD(IDX4)
      *
               IF      SRY-SRYKBN         =     "12"
                   IF   SRY-SRYCD(IDX2)   =     CONS-KEIZOKU1    OR
                                                CONS-KEIZOKU2
                        MOVE   "1"      TO    RECE41-KEIZOKU-PRTKBN
                   END-IF
                   IF   SRY-SRYCD(IDX2)   =     CONS-SAISHIN-A1   
      **                                  OR    CONS-SAISHIN-A2   
      **                                  OR    CONS-SAISHIN-A3   
      **                                  OR    CONS-SAISHIN-A4   
      **                                  OR    CONS-SAISHIN-A5   
      **                                  OR    CONS-SAISHIN-A6   
      **                                  OR    CONS-SAISHIN-A7   
      **                                  OR    CONS-SAISHIN-A8   
      **                                  OR    CONS-SAISHIN-A9   
      **                                  OR    CONS-SAISHIN-A10  
      **                                  OR    CONS-SAISHIN-A11  
      **                                  OR    CONS-SAISHIN-A12  
      **                                  OR    CONS-SAISHIN-A13  
                        MOVE   "1"      TO    RECE41-SAISHIN-PRTKBN2
                   END-IF
                   IF   SRY-SRYCD(IDX2)   =     CONS-GAIRAI 
                        MOVE   "1"      TO    RECE41-GAIRAIKSN-PRTKBN
                   END-IF
               END-IF
               MOVE    SRY-SRYSURYO(IDX2) TO    RECE45-SRYSURYO(IDX4)
               MOVE    SRY-SRYKAISU(IDX2) TO    RECE45-SRYKAISU(IDX4)
               MOVE    SRY-MEISKYFLG(IDX2) TO   RECE45-MEISKYFLG(IDX4)
               MOVE    SRY-AUTOKBN(IDX2)  TO    RECE45-AUTOKBN(IDX4)
               MOVE    SRY-INPUTNUM(IDX2) TO    RECE45-INPUTNUM(IDX4)
               PERFORM    TENSU-TBL-SEC
               IF   RECE41-HKNKBN    NOT  =  "4"                        
                  IF      TNS-SRYKBN         =     "80"
                      IF  TNS-GAITENTTLKBN   =     130
                          MOVE   "13"        TO    RECE44-SRYKBN
                                                   RECE45-SRYKBN
                      END-IF
                  END-IF
               ELSE                                                     
                  IF      SRY-SRYCD(IDX2)    =     CONS-YOUBUKASAN
                    COMPUTE  WRK-YOUBUKASAN   =  WRK-YOUBUKASAN
                                              +  TNS-TEN
                    COMPUTE  RECE44-SYUTEN1   =  RECE44-SYUTEN1
                                              -  TNS-TEN
                    COMPUTE  RECE44-KIZAITEN  =  RECE44-KIZAITEN
                                              +  TNS-TEN
                  END-IF
      *           自賠責・療養担当手当用特例処理
      *           （自賠責の場合、７点を８４円に読み替える）
      *           （療養担当手当：１月１回の算定）
                  IF      SRY-SRYCD(IDX2)    =     CONS-RYOYOTEATE
                    MOVE     84     TO     WRK-RYOYOTEATE2
                    COMPUTE  WRK-RYOYOTEATE   =  WRK-RYOYOTEATE
                                              +  WRK-RYOYOTEATE2
                  END-IF
      *
                  IF ( ACCT-SRYKBN          =  "80"               ) AND
                     ( SRY-SRYCD(IDX2)(1:5) =  "09591" OR "09592" )
                                MOVE   "95"   TO    RECE44-SRYKBN       
                                                    RECE45-SRYKBN       
                  ELSE
                   IF ( ACCT-SRYKBN          =  "80"              ) AND 
                      ( SRY-SRYCD(IDX2)(1:5) =  "09593"           )     
                                MOVE   "40"   TO    RECE44-SRYKBN       
                                                    RECE45-SRYKBN       
                   ELSE                                                 
                     IF      TNS-SRYKBN         =   "80"                
                       IF   SRY-SRYCD(IDX2)   =     CONS-SHOHOSEN1 OR   
                                                    CONS-SHOHOSEN2 OR   
                                                    CONS-SHOHOSEN3 OR   
                                                    CONS-SHOHOSEN4 OR   
                                                    CONS-SHOHOKSN1 OR   
                                                    CONS-SHOHOKSN2      
                              CONTINUE                                  
                       ELSE                                             
                              IF    TNS-GAITENTTLKBN   =  130           
                                  MOVE   "13"   TO  RECE44-SRYKBN       
                                                    RECE45-SRYKBN       
                              ELSE                                      
                                  MOVE   "40"   TO  RECE44-SRYKBN       
                                                    RECE45-SRYKBN       
                              END-IF                                    
                       END-IF                                           
                     END-IF
                   END-IF                                               
                  END-IF                                                
               END-IF                                                   
               IF  SRY-SRYCD(IDX2)        =     CONS-ZANHAIKI           
                  COMPUTE WRK-SRYSURYO2   =     WRK-SRYSURYO            
                                          +     0.999                   
                  COMPUTE RECE45-SRYSURYO(IDX4)                         
                                          =     WRK-SRYSURYO2           
                                          -     WRK-SRYSURYO            
                  IF  RECE45-SRYSURYO(IDX4)  NOT = ZERO                 
                    MOVE  WRK-TANICD      TO    RECE45-TANICD(IDX4)     
                    MOVE  WRK-TANIMOJISU  TO    RECE45-TANIMOJISU(IDX4) 
                    MOVE  WRK-TANINAME    TO    RECE45-TANINAME(IDX4)   
                    IF    RECE45-RENNUM  >  1                           
                    AND   IDX4           =  1                           
                      MOVE    1           TO    FLG-ZANHAIKI            
                      COMPUTE  WRK-RENNUM  =  RECE45-RENNUM  -  1       
                      MOVE WRK-SRYSURYO2  TO  WRK-SRYSURYO3             
                    ELSE                                                
                      MOVE WRK-SRYSURYO2  TO  RECE45-SRYSURYO(IDX4 - 1) 
                    END-IF
                  END-IF                                                
               ELSE                                                     
                  MOVE    SRY-SRYSURYO(IDX2)                            
                                          TO    WRK-SRYSURYO            
                  MOVE    TNS-TANICD      TO    RECE45-TANICD(IDX4)
                                                WRK-TANICD              
                  MOVE    TNS-TANIMOJISU  TO    RECE45-TANIMOJISU(IDX4)
                                                WRK-TANIMOJISU          
                  MOVE    TNS-TANINAME    TO    RECE45-TANINAME(IDX4)
                                                WRK-TANINAME            
               END-IF                                                   
               IF ( ACCT-SRYKBN          =  "80"              ) AND     
                  ( SRY-SRYCD(IDX2)(1:5) =  "09593"           )         
                    MOVE  1               TO  RECE45-TENSIKIBETU(IDX4)  
                    MOVE  TNS-TEN         TO  RECE45-TEN(IDX4)          
               ELSE                                                     
                 IF   RECE41-HKNKBN     =  "4"
                 AND  SRY-SRYCD(IDX2)   =  CONS-RYOYOTEATE
                    MOVE  1               TO  RECE45-TENSIKIBETU(IDX4)  
                    MOVE  WRK-RYOYOTEATE2 TO  RECE45-TEN(IDX4)
                 ELSE
                  IF      TNS-TENSIKIBETU    =     1   OR   3
                    MOVE  TNS-TENSIKIBETU TO  RECE45-TENSIKIBETU(IDX4)
                    MOVE  TNS-TEN         TO  RECE45-TEN(IDX4)
                  END-IF
                 END-IF
               END-IF                                                   
               IF      RECE41-NYUGAIKBN   =     "1"
                   MOVE  TNS-NYUTENTTLKBN TO    RECE45-TENTTLKBN(IDX4)
               ELSE
                   MOVE  TNS-GAITENTTLKBN TO    RECE45-TENTTLKBN(IDX4)
               END-IF
               MOVE    TNS-YUKOKETA       TO    RECE45-YUKOKETA(IDX4)
               MOVE    TNS-DATAKBN        TO    RECE45-DATAKBN (IDX4)
               IF      SRY-SRYCD    (IDX2)(1:1)     =   "8"
               AND     SRY-INPUTNUM (IDX2)      NOT =   ZERO
                   MOVE    SRY-HOSPID           TO  PTCOM-HOSPID
                   MOVE    SRY-PTID             TO  PTCOM-PTID
                   MOVE    SRY-ZAINUM           TO  PTCOM-ZAINUM
                   MOVE    SRY-SRYCD (IDX2)     TO  PTCOM-SRYCD
                   MOVE    SRY-INPUTNUM(IDX2)   TO  PTCOM-RENNUM
                   PERFORM 950-PTCOM-READ-SEC
                   MOVE    PTCOM-INPUTCOMENT   TO    RECE45-NAME(IDX4)
      *
                   MOVE   "1"                  TO    RECE44-COMCDFLG
               ELSE
                   MOVE    TNS-NAME            TO    RECE45-NAME(IDX4)
      *
      *            IF   RECE41-HKNKBN   =  "4"  
      *            AND  RECE41-SRYYM   >=  "200302"
      *                 IF   SRY-SRYCD(IDX2)  =  "101120040"  OR
      *                                          "101120050"  OR
      *                                          "101120060"
      *                    MOVE   "６"   TO    RECE45-NAME(IDX4)(9:2)
      *                 END-IF
      *                 IF   SRY-SRYCD(IDX2)  =  "101120070"  OR
      *                                          "101120080"  OR
      *                                          "101120090"
      *                    MOVE   "６"   TO    RECE45-NAME(IDX4)(31:2)
      *                 END-IF
      *            END-IF
      *
               END-IF
      *
               IF  RECE45-YUKOKETA(IDX4)  =  ZERO
                   PERFORM   VARYING   IDW   FROM   200   BY  -1
                           UNTIL   IDW   <   1
                       IF   RECE45-NAME(IDX4)(IDW:1)  NOT =   SPACE
                           COMPUTE RECE45-YUKOKETA(IDX4)  =
                                   IDW     /   2
                           MOVE    1          TO  IDW
                       END-IF
                   END-PERFORM
               END-IF
      *
               IF (  SRY-SRYCD(IDX2) = CONS-ROUSAI1  OR
                                       CONS-ROUSAI2  OR
                                       CONS-ROUSAI3  OR
                                       CONS-ROUSAI4  OR
                                       CONS-ROUSAI5  OR
                                       CONS-ROUSAI6  OR
                                       CONS-ROUSAI7  OR
                                       CONS-ROUSAI8  OR
                                       CONS-ROUSAI9  OR
                                       CONS-ROUSAI10 OR
                                       CONS-ROUSAI11 OR
                                       CONS-ROUSAI12 OR
                                       CONS-ROUSAI13 OR
                                       CONS-ROUSAI14 OR
                                       CONS-ROUSAI15 OR
                                       CONS-ROUSAI16 OR
                                       CONS-ROUSAI17   )                
               OR (( ACCT-SRYKBN          =  "80"     )   AND           
                   ( SRY-SRYCD(IDX2)(1:5) =  "09593"  ))                
      *
      *           IF     TNS-TENSIKIBETU   =   1
                     ADD      1          TO  WRK-MEISAI-CNT
                     COMPUTE  WRK-TEN    =   WRK-TEN   +
                                           ( TNS-TEN   /  10 ) 
      *
                     ADD      1          TO  WRK-SURYOUTOTAL
                     MOVE  SRY-SRYCD(IDX2) 
                                         TO  WRK-SRYCD
                     ADD   WRK-SRYCD     TO  WRK-SRYCDTOTAL
      *           END-IF
      *
                  MOVE     "2"     TO    RECE45-SIKFLG(IDX4)
      *
               ELSE
      *
                  IF   RECE41-HKNKBN     =  "4"
                  AND  SRY-SRYCD(IDX2)   =  CONS-RYOYOTEATE
      *
                     ADD      1          TO  WRK-MEISAI-CNT
                     COMPUTE  WRK-TEN    =   WRK-TEN   +
                                             TNS-TEN
      *
                     ADD      1          TO  WRK-SURYOUTOTAL
                     MOVE  SRY-SRYCD(IDX2) 
                                         TO  WRK-SRYCD
                     ADD   WRK-SRYCD     TO  WRK-SRYCDTOTAL
      *
                     MOVE     "2"        TO  RECE45-SIKFLG(IDX4)
      *
                  ELSE
      *
                      IF  ( SRY-SRYCD(IDX2) = CONS-ROUCOM1  OR
                                              CONS-ROUCOM2      )
                      OR  ( SRY-SRYCD(1)    = CONS-ROUSAI2  OR
                                              CONS-ROUSAI3      )
                      OR (( SRY-SRYCD(1)    = CONS-ROUSAI1      ) AND
                          ( SRY-SRYCD(IDX2)(1:1)     =   "8"    ))
                      OR (( SRY-SRYCD(1)    = CONS-ROUSAI5  OR
                                              CONS-ROUSAI6  OR
                                              CONS-ROUSAI7      ) AND
                          ( SRY-SRYCD(IDX2)(1:1)     =   "8"    ))
      *
                         ADD    1      TO    WRK-MEISAI-CNT             
                         MOVE  "2"     TO    RECE45-SIKFLG(IDX4)
      *
                         ADD    1      TO    WRK-SURYOUTOTAL
                         MOVE  SRY-SRYCD(IDX2) 
                                       TO    WRK-SRYCD
                         ADD   WRK-SRYCD 
                                       TO    WRK-SRYCDTOTAL
                         IF    RECE44-COMCDFLG       =   "1" 
                         AND   SRY-SRYCD(IDX2)(1:1)  =   "8" 
                            MOVE  "2"  TO    RECE44-COMCDFLG
                         END-IF
                      ELSE
                         MOVE  "1"     TO    RECE45-SIKFLG(IDX4)
                      END-IF
      *
                  END-IF
      *
               END-IF
      *
      *        特定器材（画像診断のフィルム以外）のとき単価を編集
               IF      SRY-SRYCD (IDX2) (1:1)  =   "7"
                   IF   (( SRY-SRYKBN               =   "70" )  AND
                         ( TNS-DATAKBN              =   "3"  ))
                   OR   (  SRY-SRYCD (IDX2)         =
                                    CONS-FILM-YOUJI-KASAN  OR  
                                    CONS-SANSO             OR
                                    CONS-SANSO2               )
                       CONTINUE
                   ELSE
      **               SET     TBL-SANSO           TO  1
      **               SEARCH      TBL-SANSO-OCC   VARYING   TBL-SANSO
      **                   AT  END
      **                       MOVE    ZERO            TO  FLG-SANSO-OK
      **                   WHEN    SRY-SRYCD (IDX2)    =   TBL-SANSO-SRYCD
      **                                                        (TBL-SANSO)
      **                       MOVE    1               TO  FLG-SANSO-OK
      **               END-SEARCH
      **               IF      FLG-SANSO-OK        =   "1"
                     IF      TNS-TEN         =   ZERO
                       CONTINUE
                     ELSE
                       PERFORM RECE45-TENSOU-TANKA-HEN-SEC
                       COMPUTE IDW =   RECE45-YUKOKETA(IDX4)  *  2 
                                                   +   3                    
                       MOVE    WRK-CHAR-N (1:WRK-CHAR-N-CNT)
                                                   TO
                                               RECE45-NAME(IDX4)(IDW:)   
                       COMPUTE RECE45-YUKOKETA(IDX4)
                                               =   RECE45-YUKOKETA(IDX4)
                                                   +   1   
                                                   +
                                                  (WRK-CHAR-N-CNT  /  2)
                     END-IF
                   END-IF
               END-IF        
      *       
      *----------------------------------------------------------------
      *        在宅部分のレセプト編集用に往診（特別往診）・夜間・
      *        深夜・緊急の剤判定を追加
      *----------------------------------------------------------------
               IF    SRY-SRYKBN     =  "14"
                 EVALUATE    SRY-SRYCD(IDX2)
      *往診（特別往診）
                   WHEN    "114000110"
                   WHEN    "114001610"
                   WHEN    "114000970"
                   IF  FLG-OSINKBN        NOT = 2  AND 3
                       MOVE     1         TO    FLG-OSINKBN
                   END-IF
      *夜間
                   WHEN    "114000470"
                   WHEN    "114001970"
                       MOVE     2         TO    FLG-OSINKBN
      *深夜・緊急
                   WHEN    "114000370"
                   WHEN    "114000570"
                   WHEN    "114001870"
                   WHEN    "114002070"
                       MOVE     3         TO    FLG-OSINKBN
                 END-EVALUATE
               END-IF
             END-IF  
           END-PERFORM
      *
           .
       RECE45-TENSOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    酸素の単価編集処理
      *****************************************************************
       RECE45-TENSOU-TANKA-HEN-SEC     SECTION.
      *
      ***  IF      TNS-TEN         =   ZERO
      ***      GO  TO  RECE45-TENSOU-TANKA-HEN-EXT  
      ***  END-IF
      *
           MOVE    SPACE           TO  WRK-TANKA-X
      * 
      *    数字表示用編集（半角）
           MOVE    TNS-TEN         TO  WRK-TANKA-9
           MOVE    WRK-TANKA-S1    TO  WRK-TANKA-Z1
           MOVE    ZERO            TO  FLG-SP
           PERFORM   VARYING   IDY   FROM    2   BY  -1
                     UNTIL     IDY           =   ZERO
             IF  WRK-TANKA-S2(IDY:1) NOT =   ZERO
                 MOVE    1               TO  FLG-SP
             END-IF
             IF  FLG-SP                  =   1
                 MOVE    WRK-TANKA-S2(IDY:1)
                                         TO  WRK-TANKA-Z3(IDY:1)
             END-IF
           END-PERFORM
           IF  WRK-TANKA-Z3          NOT =   SPACE
               MOVE    "."               TO  WRK-TANKA-Z2
           END-IF
      *        
           INITIALIZE                      WRK-CHAR-HENKAN-AREA
           MOVE    WRK-TANKA-X         TO  WRK-CHAR-X
           MOVE    12                  TO  WRK-CHAR-CNT
           MOVE    1                   TO  WRK-CHAR-IDX
           MOVE    ZERO                TO  WRK-CHAR-N-CNT
      *     
           PERFORM VARYING     IDW     FROM    1   BY  1
                   UNTIL       IDW     >   WRK-CHAR-CNT
               IF      WRK-CHAR-X (IDW:1)  =   SPACE
                   CONTINUE
               ELSE        
                   IF    WRK-CHAR-X (IDW:1)  IS  NUMERIC
                       IF      WRK-CHAR-X (IDW:1)  =   "0"
                           MOVE    TBL-SUJI (10)
                                       TO  WRK-CHAR-N (WRK-CHAR-IDX:)
                       ELSE
                           MOVE    WRK-CHAR-X (IDW:1)  TO  NUM-IDX
                           MOVE    TBL-SUJI (NUM-IDX)
                                       TO  WRK-CHAR-N (WRK-CHAR-IDX:)
                       END-IF                    
                   ELSE
                       IF    WRK-CHAR-X (IDW:1)  =   "."
                           MOVE    "．"   TO  WRK-CHAR-N (WRK-CHAR-IDX:)
                       ELSE    
                           MOVE    "  "   TO  WRK-CHAR-N (WRK-CHAR-IDX:)
                       END-IF
                   END-IF    
                   ADD     2           TO  WRK-CHAR-IDX
                                           WRK-CHAR-N-CNT
               END-IF    
           END-PERFORM
      *
           IF      WRK-CHAR-N-CNT      >   ZERO
                   MOVE    "円"        TO  WRK-CHAR-N (WRK-CHAR-IDX:)
                   ADD     2           TO  WRK-CHAR-N-CNT
           END-IF                             
      *
           .
       RECE45-TENSOU-TANKA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプトコメントフラグ編集処理
      *****************************************************************
       RECE45-TENSOU-COMCNT-HEN-SEC               SECTION.
      *
           IF      SRY-SRYKBN         =     "11"
              IF   SRY-SRYCD(IDX2)    =     "830000020"
                        MOVE   "1"        TO    RECE41-COMCNTFLG
              END-IF
           END-IF
      *
           IF      SRY-SRYKBN         =     "12"
              IF   SRY-SRYCD(IDX2)    =     "830000021"   OR
                                            "112009610"   OR
                                            "112009510"   OR
                                            "112012750"   OR
                                            "112706610"   
                        MOVE   "1"        TO    RECE41-COMCNTFLG
              END-IF
           END-IF
      *
           IF      SRY-SRYKBN         =     "40"
              IF   SRY-SRYCD(IDX2)    =     "140036710"   OR
                                            "140007710"
                        MOVE   "1"        TO    RECE41-COMCNTFLG
              END-IF
           END-IF
      *
           IF      SRY-SRYKBN         =     "80"
              IF   SRY-SRYCD(IDX2)    =     "180706910"   OR
                                            "180022210"   OR
                                            "180706810"   OR
                                            "180022110"   OR
                                            "180707110"   OR
                                            "180022410"   OR
                                            "180707010"   OR
                                            "180022310"   OR
                                            "180707310"   OR
                                            "180022610"   OR
                                            "180707210"   OR
                                            "180022510"   OR
                                            "180707510"   OR
                                            "180022810"   OR
                                            "180707410"   OR
                                            "180022710"   OR
                                            "180708210"   OR
                                            "180023710"   OR
                                            "180708410"   OR
                                            "180023910"   OR
                                            "180708110"   OR
                                            "180023610"   OR
                                            "180708310"   OR
                                            "180023810"   OR
                                            "180024910"   OR
                                            "180024810"   OR
                                            "180025110"   OR
                                            "180025010"   
                        MOVE   "1"        TO    RECE41-COMCNTFLG
              END-IF
           END-IF
      *
           .
       RECE45-TENSOU-COMCNT-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送
      *****************************************************************
       RECE41-HENSYU-SEC               SECTION.
      *
      *    特定疾患処方管理加算の算定回数減算用領域の初期化
           MOVE   ZERO              TO   WRK-TOKUTEI-SKAN
           MOVE   ZERO              TO   WRK-TOKUTEI-SKAN2
      *    処方の乳幼児加算の算定回数減算用領域の初期化
           MOVE   ZERO              TO   WRK-NYUYOUJI-SKAN
      *    処方せん(乳幼児加算)の算定回数減算用領域の初期化
           MOVE   ZERO              TO   WRK-NYUYOUJI-SHOKAN
      *    処方料（麻・向・毒・覚）の算定回数減算用領域の初期化
           MOVE   ZERO              TO   WRK-MADOKU-SHOHO
      *
           PERFORM   VARYING  IDX3   FROM   1   BY   1
                     UNTIL    (IDX3         >     5)        OR
                              (SRY-SRYCD(IDX3)   =   SPACE)
               IF    SRY-RENNUM     =     1
                   IF  IDX3         =     1
                       IF      RECE41-HKNKBN   NOT  =   "3"
                          MOVE  ACCT-ZAIKAISU     TO   WK-ZAIKAISU
                       ELSE
                          MOVE  WRK-ZAIKAISU-XXX  TO   WK-ZAIKAISU
                       END-IF 
                       MOVE  ACCT-ZAITEN       TO   WK-ZAITEN
                       IF   RECE41-HKNKBN    NOT  =  "4"                
      *                  IF    SRY-SRYKBN     =  "40"  OR  "50"  OR
      *                                          "70"  OR  "80"  OR
      *                                          "54"
      *                      COMPUTE  WK-SYUTEN   =   ACCT-SYUTEN1  +
      *                                               ACCT-KIZAITEN
      *                      MOVE  ACCT-YKZTEN   TO   WK-YKZTEN
      *                  ELSE
      *                      IF   SRY-SRYKBN      =   "60"
      *                           MOVE   ACCT-SYUTEN1   TO   WK-SYUTEN
      *                           COMPUTE   WK-YKZTEN =
      *                                               ACCT-KIZAITEN  +
      *                                               ACCT-YKZTEN
      *                      END-IF
      *                  END-IF
                         IF    SRY-SRYKBN     =  "40"  OR  "50"  OR
                                                 "70"  OR  "80"  OR
                                                 "54"  OR  "60"
                                  MOVE   ACCT-SYUTEN1   TO   WK-SYUTEN
                                  COMPUTE   WK-YKZTEN =
                                                      ACCT-KIZAITEN  +
                                                      ACCT-YKZTEN
                         END-IF
                       ELSE                                             
                         IF ( ACCT-SRYKBN          =  "80"    )   AND
                            ( SRY-SRYCD(IDX3)(1:5) =  "09591" OR 
                                                      "09592" )
                               CONTINUE
                         ELSE
                           IF ( ACCT-SRYKBN          =  "80"    ) AND   
                              ( SRY-SRYCD(IDX3)(1:5) =  "09593" )       
                                  MOVE   ACCT-SYUTEN1   TO   WK-SYUTEN  
                                  COMPUTE   WK-YKZTEN =                 
                                                      ACCT-KIZAITEN  +  
                                                      ACCT-YKZTEN       
                           ELSE                                         
                             IF    SRY-SRYKBN   =  "30"  OR  "31"  OR     
                                                   "32"  OR  "33"  OR     
                                                   "40"  OR  "50"  OR     
                                                   "54"  OR  "60"  OR     
                                                   "70"  OR  "80"         
                                  MOVE   ACCT-SYUTEN1   TO   WK-SYUTEN  
                                  COMPUTE   WK-YKZTEN =                 
                                                      ACCT-KIZAITEN  +  
                                                      ACCT-YKZTEN       
                                  IF  SRY-SRYKBN  =  "70"
                                     COMPUTE  WK-SYUTEN  =  WK-SYUTEN
                                                         -  ACCT-SYUTEN2
                                     COMPUTE  WK-YKZTEN  =  WK-YKZTEN
                                                         +  ACCT-SYUTEN2
                                  END-IF
                                  IF  WRK-YOUBUKASAN  NOT =  ZERO
                                   COMPUTE  WK-SYUTEN  = WK-SYUTEN
                                                       - WRK-YOUBUKASAN
                                   COMPUTE  WK-YKZTEN  = WK-YKZTEN
                                                       + WRK-YOUBUKASAN
                                  END-IF
                             END-IF
                           END-IF                                       
                         END-IF
                       END-IF                                           
                       IF    SRY-SRYKBN     =  "14"
                           MOVE    ACCT-SYUTEN1   TO   WK-SYUTEN
                           MOVE    ACCT-KIZAITEN  TO   WK-KIZAITEN
                           MOVE    ACCT-YKZTEN    TO   WK-YKZTEN
                           IF   RECE41-HKNKBN   =  "4"
                             IF  WRK-YOUBUKASAN  NOT =  ZERO
                                COMPUTE  WK-SYUTEN   =  WK-SYUTEN
                                                     -  WRK-YOUBUKASAN
                                COMPUTE  WK-KIZAITEN =  WK-KIZAITEN
                                                     +  WRK-YOUBUKASAN
                             END-IF
                           END-IF
                       END-IF
                   ELSE
                       IF   SRY-SRYKBN  =  "21"  OR  "22"  OR  "23" OR
                                           "30"  OR  "31"  OR  "32" OR
                                           "33"  OR  "40"  OR  "50" OR
                                           "60"  OR  "70"  OR  "80" OR
                                           "14"  OR  "54"  OR  "13"
                           MOVE  ZERO          TO   WK-ZAIKAISU
                           MOVE  ZERO          TO   WK-ZAITEN
                           MOVE  ZERO          TO   WK-SYUTEN
                           MOVE  ZERO          TO   WK-KIZAITEN
                           MOVE  ZERO          TO   WK-YKZTEN
                           MOVE  ZERO          TO   FLG-OSINKBN
                       END-IF
                   END-IF
               ELSE
                     MOVE    ZERO     TO    WK-ZAIKAISU
                     MOVE    ZERO     TO    WK-ZAITEN
                     MOVE    ZERO     TO    WK-SYUTEN
                     MOVE    ZERO     TO    WK-KIZAITEN
                     MOVE    ZERO     TO    WK-YKZTEN
                     MOVE    ZERO     TO    FLG-OSINKBN
               END-IF
               IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                    (ACCT-ZAIKAISU  NOT =    ZERO)
                  IF      RECE41-HKNKBN   NOT  =   "3"
                     IF   RECE41-HKNKBN   NOT  =   "4"                     
                        PERFORM   RECE-LEFT-SET-SEC
                     ELSE                                                  
                        PERFORM   RECE-LEFT-SET3-SEC                       
                     END-IF                                                
                  ELSE
                        PERFORM   RECE-LEFT-SET2-SEC
                  END-IF
               END-IF
               IF    SRY-SRYKBN   =  "21"   OR   "22"   OR   "23"   OR
                                     "31"   OR   "32"   OR   "33"   OR
                                     "40"   OR   "50"   OR   "60"   OR
                                     "70"   OR   "54"
                     MOVE    6      TO    IDX3
               END-IF
           END-PERFORM
      *
           IF      RECE41-HKNKBN   NOT  =   "3"
      *
              IF   RECE41-HKNKBN   NOT  =   "4"                         
      *
      *         処方の算定回数から特定疾患処方管理加算の減算
                COMPUTE    RECE41-KAISU(19)   =    RECE41-KAISU(19)  -
                                                   WRK-TOKUTEI-SKAN
      *
      *         処方の算定回数から処方(乳幼児)加算の減算
                COMPUTE    RECE41-KAISU(19)   =    RECE41-KAISU(19)  -
                                                   WRK-NYUYOUJI-SKAN           
      *
      *         処方の算定回数から特定疾患処方管理加算(処方料)の減算
                COMPUTE    RECE41-KAISU(33)   =    RECE41-KAISU(33)  -
                                                   WRK-TOKUTEI-SKAN2           
      *
      *         処方せんの算定回数から処方せん(乳幼児)加算の減算
                COMPUTE    RECE41-KAISU(33)   =    RECE41-KAISU(33)  -
                                                   WRK-NYUYOUJI-SHOKAN      
      *
      *         麻毒の算定回数から処方料（麻・向・毒・覚）の減算
                COMPUTE    RECE41-KAISU(20)   =    RECE41-KAISU(20)  -
                                                   WRK-MADOKU-SHOHO  
      *
              ELSE                                                      
      *
      *         処方の算定回数から特定疾患処方管理加算の減算
                COMPUTE    RECE41-KAISU(14)   =    RECE41-KAISU(14)  -  
                                                   WRK-TOKUTEI-SKAN     
      *
      *         処方の算定回数から処方(乳幼児)加算の減算
                COMPUTE    RECE41-KAISU(14)   =    RECE41-KAISU(14)  -  
                                                   WRK-NYUYOUJI-SKAN     
      *
      *         処方の算定回数から特定疾患処方管理加算(処方料)の減算
                COMPUTE    RECE41-KAISU(33)   =    RECE41-KAISU(33)  -  
                                                   WRK-TOKUTEI-SKAN2    
      *
      *         処方せんの算定回数から処方せん(乳幼児)加算の減算
                COMPUTE    RECE41-KAISU(33)   =    RECE41-KAISU(33)  -  
                                                   WRK-NYUYOUJI-SHOKAN  
      *
      *         麻毒の算定回数から処方料（麻・向・毒・覚）の減算
                COMPUTE    RECE41-KAISU(15)   =    RECE41-KAISU(15)  -  
                                                   WRK-MADOKU-SHOHO     
      *
              END-IF                                                    
      *
           ELSE
      *
      *         処方の算定回数から特定疾患処方管理加算の減算
                COMPUTE    RECE41-KAISU(12)   =    RECE41-KAISU(12)  -
                                                   WRK-TOKUTEI-SKAN
      *
      *         処方の算定回数から処方(乳幼児)加算の減算
                COMPUTE    RECE41-KAISU(12)   =    RECE41-KAISU(12)  -
                                                   WRK-NYUYOUJI-SKAN           
      *
      *         処方の算定回数から特定疾患処方管理加算(処方料)の減算
                COMPUTE    RECE41-KAISU(30)   =    RECE41-KAISU(30)  -
                                                   WRK-TOKUTEI-SKAN2           
      *
      *         処方せんの算定回数から処方せん(乳幼児)加算の減算
                COMPUTE    RECE41-KAISU(30)   =    RECE41-KAISU(30)  -
                                                   WRK-NYUYOUJI-SHOKAN      
      *
      *         麻毒の算定回数から処方料（麻・向・毒・覚）の減算
                COMPUTE    RECE41-KAISU(13)   =    RECE41-KAISU(13)  -
                                                   WRK-MADOKU-SHOHO  
      *
           END-IF         
      *
           .                                           
      *
       RECE41-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送
      *****************************************************************
       RECE-LEFT-SET-SEC               SECTION.
      *
           PERFORM     TENSU-TBL-SEC2
      *
           EVALUATE    SRY-SRYKBN
      *    初診のレセ点数欄の編集
               WHEN    "11"
                   IF   TNS-DATAKBN  =   2
                     EVALUATE    TNS-TIMEKSNKBN
                         WHEN    1
                         WHEN    5
                             MOVE  "1"     TO   RECE41-SHOSHINTIME
                         WHEN    3
                             MOVE  "2"     TO   RECE41-SHOSHINTIME
                         WHEN    4
                             MOVE  "3"     TO   RECE41-SHOSHINTIME
                     END-EVALUATE
                     COMPUTE    RECE41-TENSU(1)  =
                                RECE41-TENSU(1)  +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
                   END-IF
                   IF   SRY-SRYCD(IDX3) = CONS-ROUSAI1    
                        COMPUTE    RECE41-KINGAKU2(1)  =
                                   RECE41-KINGAKU2(1)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                   END-IF  
                   IF   SRY-SRYCD(IDX3) = CONS-ROUSAI2 OR
                                          CONS-ROUSAI3    
                        COMPUTE    RECE41-KINGAKU2(4)  =
                                   RECE41-KINGAKU2(4)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                   END-IF  
      *    再診のレセ点数欄の編集（集計方法変更後）
               WHEN    "12"
                 EVALUATE  TNS-GAITENTTLKBN
      *      （基本手技）
                   WHEN  120
                     IF   SRY-SRYCD(IDX3) =  CONS-ROUSAI5  OR
                                             CONS-ROUSAI6  OR
                                             CONS-ROUSAI7  
                         ADD   WK-ZAIKAISU      TO   RECE41-KAISU2(2)
                         COMPUTE    RECE41-KINGAKU2(2)  =
                                    RECE41-KINGAKU2(2)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                     ELSE
                         IF    RECE41-KHNTEN(2)   =   ZERO
                            MOVE  TNS-TEN    TO   RECE41-KHNTEN(2)
                         ELSE
                            IF RECE41-KHNTEN(2) NOT = TNS-TEN
                               MOVE   ZERO    TO  RECE41-KHNTEN(2)
                               MOVE   1    TO  FLG-KHNTEN2
                            END-IF
                         END-IF
                         ADD    WK-ZAIKAISU   TO   RECE41-KAISU(2)
                         COMPUTE    RECE41-TENSU(2)  =
                                    RECE41-TENSU(2)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                     END-IF
      *
      *      （外来管理加算）
                   WHEN  122
                        IF    RECE41-KHNTEN(3)   =   ZERO
                           MOVE  TNS-TEN    TO   RECE41-KHNTEN(3)
                        ELSE
                           IF RECE41-KHNTEN(3) NOT = TNS-TEN
                              MOVE   ZERO    TO  RECE41-KHNTEN(3)
                              MOVE   1    TO  FLG-KHNTEN3
                           END-IF
                        END-IF
                        ADD    WK-ZAIKAISU   TO   RECE41-KAISU(3)
                        COMPUTE    RECE41-TENSU(3)  =
                                   RECE41-TENSU(3)  +
                                  (TNS-TEN   *   ACCT-ZAIKAISU)
      *      （時間外）
                   WHEN  123
                        IF    RECE41-KHNTEN(4)   =   ZERO
                           MOVE  TNS-TEN    TO
                                           RECE41-KHNTEN(4)
                        ELSE
                           IF RECE41-KHNTEN(4) NOT = TNS-TEN
                              MOVE   ZERO    TO
                                            RECE41-KHNTEN(4)
                              MOVE   1    TO  FLG-KHNTEN4
                           END-IF
                        END-IF
                        ADD   WK-ZAIKAISU  TO
                                            RECE41-KAISU(4)
                        COMPUTE RECE41-TENSU(4) =
                                RECE41-TENSU(4) +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
      *      （休日）
                   WHEN  124
                        IF    RECE41-KHNTEN(5)   =   ZERO
                           MOVE  TNS-TEN    TO
                                           RECE41-KHNTEN(5)
                        ELSE
                           IF RECE41-KHNTEN(5) NOT = TNS-TEN
                              MOVE   ZERO    TO
                                            RECE41-KHNTEN(5)
                              MOVE   1     TO   FLG-KHNTEN5
                           END-IF
                        END-IF
                        ADD   WK-ZAIKAISU   TO
                                              RECE41-KAISU(5)
                        COMPUTE  RECE41-TENSU(5) =
                                 RECE41-TENSU(5) +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
      *       （深夜）
                   WHEN  125
                        IF    RECE41-KHNTEN(6)   =   ZERO
                           MOVE  TNS-TEN    TO
                                           RECE41-KHNTEN(6)
                        ELSE
                           IF RECE41-KHNTEN(6) NOT = TNS-TEN
                              MOVE   ZERO    TO
                                            RECE41-KHNTEN(6)
                              MOVE   1       TO   FLG-KHNTEN6
                           END-IF
                        END-IF
                        ADD   WK-ZAIKAISU  TO
                                            RECE41-KAISU(6)
                        COMPUTE  RECE41-TENSU(6) =
                                 RECE41-TENSU(6) +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
      *       （その他）
                   WHEN  OTHER 
                        IF   SRY-SRYCD(IDX3) =  CONS-ROUSAI4  
                           ADD   WK-ZAIKAISU   TO   RECE41-KAISU2(3)
                           COMPUTE    RECE41-KINGAKU2(3)  =
                                      RECE41-KINGAKU2(3)  +
                                     (TNS-TEN   *   ACCT-ZAIKAISU)
                        END-IF
                 END-EVALUATE
      *    指導のレセ点数欄の編集
               WHEN    "13"
                   IF   SRY-SRYCD(IDX3) =   CONS-ROUSAI8  OR
                                            CONS-ROUSAI9  OR
                                            CONS-ROUSAI10 OR
                                            CONS-ROUSAI11 OR
                                            CONS-ROUSAI12 OR
                                            CONS-ROUSAI13 OR
                                            CONS-ROUSAI14 OR
                                            CONS-ROUSAI15 OR
                                            CONS-ROUSAI16 OR
                                            CONS-ROUSAI17 
                         COMPUTE    RECE41-KINGAKU2(4)  =
                                    RECE41-KINGAKU2(4)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                   ELSE
                         COMPUTE    RECE41-TENSU(7)  =
                                    RECE41-TENSU(7)  +
                                   (WK-ZAITEN   *   WK-ZAIKAISU)
                   END-IF                   
      *
      *    在宅のレセ点数欄の編集
               WHEN    "14"
                   MOVE      ZERO            TO   FLG-ZAITAKU
      *            往診・特別往診（時間加算）
                   IF    FLG-OSINKBN         =   1
                       MOVE         1        TO   FLG-ZAITAKU
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(8)
                       COMPUTE   RECE41-TENSU(8)  =
                                 RECE41-TENSU(8)  +
                                (WK-SYUTEN   *   WK-ZAIKAISU)
                   END-IF
      *            夜間
                   IF    FLG-OSINKBN         =    2
                       MOVE   1              TO   FLG-ZAITAKU
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(9)
                       COMPUTE   RECE41-TENSU(9)  =
                                 RECE41-TENSU(9)  +
                                (WK-SYUTEN   *   WK-ZAIKAISU)
                   END-IF
      *            深夜・緊急
                   IF    FLG-OSINKBN         =    3
                       MOVE   1              TO   FLG-ZAITAKU
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(10)
                       COMPUTE   RECE41-TENSU(10)  =
                                 RECE41-TENSU(10)  +
                                (WK-SYUTEN   *   WK-ZAIKAISU)
                   END-IF
      *            在宅患者訪問診療
                   IF   (TNS-OSINKBN         =   1)   AND
                       ((SRY-SRYCD(IDX3)   NOT =    "114000110")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114001610")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114000970")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114000470")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114001970")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114000370")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114001570")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114001870")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114002070"))
                       MOVE   1              TO   FLG-ZAITAKU
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(11)
                       COMPUTE   RECE41-TENSU(11)  =
                                 RECE41-TENSU(11)  +
                                (TNS-TEN    *  ACCT-ZAIKAISU)
                   END-IF
      *            その他
                   IF    FLG-ZAITAKU    =   ZERO
                       COMPUTE   RECE41-TENSU(12)  =
                                 RECE41-TENSU(12)  +
                                (WK-KIZAITEN   *   WK-ZAIKAISU)  +
                                (WK-SYUTEN     *   WK-ZAIKAISU)
                   END-IF
      *            薬剤
                   COMPUTE   RECE41-TENSU(13)  =
                             RECE41-TENSU(13)  +
                             (WK-YKZTEN   *   WK-ZAIKAISU)
      *    投薬のレセ点数欄の編集
               WHEN    "21"
                   IF     SRY-SRYCD(IDX3) (1:1)   =    "6"  OR  "S"
                     IF   SRY-SRYCD(IDX3)         =    CONS-YAKTEIGEN
                       COMPUTE   RECE41-TENSU(14)  =
                                 RECE41-TENSU(14)  -
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                     ELSE
                       ADD   WK-ZAIKAISU       TO   RECE41-KAISU(14)
                       COMPUTE   RECE41-TENSU(14)  =
                                 RECE41-TENSU(14)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                     END-IF
                   ELSE
                     IF      SRY-SRYCD(IDX3)     =   "820000047"
                       ADD    WK-ZAIKAISU       TO   RECE41-KAISU(14)
                       COMPUTE   RECE41-TENSU(14)  =
                                 RECE41-TENSU(14)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                     ELSE
      *----(2002/01/09)-----------------------------------------------------
                      IF   SRY-SRYCD(IDX3)   =    CONS-FUNSAI-COMMENT
                       ADD   WK-ZAIKAISU       TO   RECE41-KAISU(14)
                       COMPUTE   RECE41-TENSU(14)  =
                                 RECE41-TENSU(14)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                      ELSE   
      *---------------------------------------------------------------------
                       IF    RECE41-KHNTEN(15)   =   ZERO
                             MOVE  TNS-TEN    TO    RECE41-KHNTEN(15)
                       ELSE
                          IF   RECE41-KHNTEN(15) NOT = TNS-TEN
                               MOVE   ZERO    TO    RECE41-KHNTEN(15)
                               MOVE   1       TO    FLG-KHNTEN15
                          END-IF
                       END-IF
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(15)
                       COMPUTE   RECE41-TENSU(15)  =
                                 RECE41-TENSU(15)  +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
      *----(2002/01/09)-----------------------------------------------------
                      END-IF   
      *---------------------------------------------------------------------
                     END-IF
                   END-IF
               WHEN    "22"
                   ADD    WK-ZAIKAISU    TO   RECE41-KAISU(16)
                   COMPUTE   RECE41-TENSU(16)  =
                             RECE41-TENSU(16)  +
                            (WK-ZAITEN   *   WK-ZAIKAISU)
               WHEN    "23"
                   IF     SRY-SRYCD(IDX3) (1:1)   =  "6" OR "S" OR "8"
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(17)
                       COMPUTE   RECE41-TENSU(17)  =
                                 RECE41-TENSU(17)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                   ELSE
                       IF    RECE41-KHNTEN(18)   =   ZERO
                             MOVE  TNS-TEN    TO    RECE41-KHNTEN(18)
                       ELSE
                          IF   RECE41-KHNTEN(18) NOT = TNS-TEN
                               MOVE   ZERO    TO    RECE41-KHNTEN(18)
                               MOVE   1       TO    FLG-KHNTEN18
                          END-IF
                       END-IF
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(18)
                       COMPUTE   RECE41-TENSU(18)  =
                                 RECE41-TENSU(18)  +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
                   END-IF
      *    処方のレセ点数欄の編集
               WHEN    "25"
                   IF SRY-SRYCD(IDX3)   =    "120002270"
                      COMPUTE  WRK-TOKUTEI-SKAN  = WRK-TOKUTEI-SKAN +
                                                   WK-ZAIKAISU 
                   END-IF
                   IF SRY-SRYCD(IDX3)   =    "120002170"
                      COMPUTE  WRK-NYUYOUJI-SKAN = WRK-NYUYOUJI-SKAN +
                                                   WK-ZAIKAISU 
                   END-IF
                   IF    RECE41-KHNTEN(19)   =   ZERO
                         MOVE  TNS-TEN    TO    RECE41-KHNTEN(19)
                   ELSE
                      IF   RECE41-KHNTEN(19) NOT = TNS-TEN
                           MOVE   ZERO    TO    RECE41-KHNTEN(19)
                           MOVE   1       TO    FLG-KHNTEN19
                      END-IF
                   END-IF
                   ADD    WK-ZAIKAISU     TO    RECE41-KAISU(19)
                   COMPUTE   RECE41-TENSU(19)  =
                             RECE41-TENSU(19)  +
                            (TNS-TEN   *   ACCT-ZAIKAISU)
      *    麻毒のレセ点数欄の編集
               WHEN    "26"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(20)
                   IF SRY-SRYCD(IDX3)      =    "120001310"
                    COMPUTE WRK-MADOKU-SHOHO = WRK-MADOKU-SHOHO +
                                               WK-ZAIKAISU 
                   END-IF
                   COMPUTE   RECE41-TENSU(20)  =
                             RECE41-TENSU(20)  +
                            (TNS-TEN   *   ACCT-ZAIKAISU)
      *    調基のレセ点数欄の編集
               WHEN    "27"
                   COMPUTE   RECE41-TENSU(21)  =
                             RECE41-TENSU(21)  +
                            (TNS-TEN   *   ACCT-ZAIKAISU)
      *    皮下筋肉内注射のレセ点数欄の編集
               WHEN    "31"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(22)
                   COMPUTE   RECE41-TENSU(22)  =
                             RECE41-TENSU(22)  +
                            (WK-ZAITEN   *   WK-ZAIKAISU)
      *    静脈内注射のレセ点数欄の編集
               WHEN    "32"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(23)
                   COMPUTE   RECE41-TENSU(23)  =
                             RECE41-TENSU(23)  +
                            (WK-ZAITEN   *   WK-ZAIKAISU)
      *    その他注射のレセ点数欄の編集
               WHEN    "33"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(24)
                   COMPUTE   RECE41-TENSU(24)  =
                             RECE41-TENSU(24)  +
                            (WK-ZAITEN   *   WK-ZAIKAISU)
      *    処置のレセ点数欄の編集
               WHEN    "40"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(25)
                   END-IF
                   COMPUTE   RECE41-TENSU(25)  =
                             RECE41-TENSU(25)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU(26)  =
                             RECE41-TENSU(26)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    手術のレセ点数欄の編集
               WHEN    "50"
               WHEN    "54"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(27)
                   END-IF
                   COMPUTE   RECE41-TENSU(27)  =
                             RECE41-TENSU(27)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU(28)  =
                             RECE41-TENSU(28)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    検査のレセ点数欄の編集
               WHEN    "60"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(29)
                   END-IF
                   COMPUTE   RECE41-TENSU(29)  =
                             RECE41-TENSU(29)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   IF    TNS-KNSJISKBN    =   2
                         COMPUTE   RECE41-KAISU(29)  =
                                   RECE41-KAISU(29)  -  
                                   WK-ZAIKAISU
                   END-IF
                   IF    TNS-SRYCD        =   CONS-SAIKETSU1  OR
                                              CONS-SAIKETSU2  OR
                                              CONS-SAIKETSU3
                         IF   RECE41-KAISU(29)  NOT =  ZERO
                              COMPUTE   RECE41-KAISU(29)  =
                                        RECE41-KAISU(29)  -   
                                        WK-ZAIKAISU
                         END-IF
                   END-IF
                   COMPUTE   RECE41-TENSU(30)  =
                             RECE41-TENSU(30)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    画像診断のレセ点数欄の編集
               WHEN    "70"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(31)
                   END-IF
                   COMPUTE   RECE41-TENSU(31)  =
                             RECE41-TENSU(31)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU(32)  =
                             RECE41-TENSU(32)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    その他のレセ点数欄の編集
               WHEN    "80"
                   IF SRY-SRYCD(IDX3)      =    CONS-SHOHOKSN2
                     COMPUTE  WRK-TOKUTEI-SKAN2 =  WRK-TOKUTEI-SKAN2 +
                                                   WK-ZAIKAISU 
                   END-IF
                   IF SRY-SRYCD(IDX3)      =    CONS-SHOHOKSN1
                    COMPUTE WRK-NYUYOUJI-SHOKAN = WRK-NYUYOUJI-SHOKAN +
                                                  WK-ZAIKAISU 
                   END-IF
                   IF   SRY-SRYCD(IDX3)   =  CONS-SHOHOSEN1 OR
                                                 CONS-SHOHOSEN2 OR
                                                 CONS-SHOHOSEN3 OR
                                                 CONS-SHOHOSEN4 OR
                                                 CONS-SHOHOKSN1 OR
                                                 CONS-SHOHOKSN2
                         ADD    WK-ZAIKAISU  TO  RECE41-KAISU(33)
                         COMPUTE   RECE41-TENSU(33)  =
                                   RECE41-TENSU(33)  +
                                  (TNS-TEN   *   ACCT-ZAIKAISU)
                         COMPUTE   WK-SYUTEN  =  WK-SYUTEN  -  TNS-TEN
                   ELSE
                         IF    TNS-GAITENTTLKBN   =    130
                           COMPUTE   RECE41-TENSU(7)  =
                                     RECE41-TENSU(7)  +
                                    (TNS-TEN   *   ACCT-ZAIKAISU)
                         ELSE  
                           COMPUTE   RECE41-TENSU(34)  =
                                     RECE41-TENSU(34)  +
                                    (WK-SYUTEN   *   ACCT-ZAIKAISU)
                         END-IF
                   END-IF
                   COMPUTE   RECE41-TENSU(35)  =
                             RECE41-TENSU(35)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
           END-EVALUATE
      *
           .
      *
       RECE-LEFT-SET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送
      *****************************************************************
       RECE-LEFT-SET2-SEC               SECTION.
      *
           PERFORM     TENSU-TBL-SEC2
      *
           EVALUATE    SRY-SRYKBN
      *    初診のレセ点数欄の編集
               WHEN    "11"
                   IF   TNS-DATAKBN  =   2
                     EVALUATE    TNS-TIMEKSNKBN
                         WHEN    1
                         WHEN    5
                             MOVE  "1"     TO   RECE41-SHOSHINTIME
                         WHEN    3
                             MOVE  "2"     TO   RECE41-SHOSHINTIME
                         WHEN    4
                             MOVE  "3"     TO   RECE41-SHOSHINTIME
                     END-EVALUATE
                     ADD   WK-ZAIKAISU     TO   RECE41-KAISU(1)
                     COMPUTE    RECE41-TENSU(1)  =
                                RECE41-TENSU(1)  +
                                (TNS-TEN   *   WRK-ZAIKAISU-XXX)
                   END-IF
                   IF   SRY-SRYCD(IDX3) = CONS-ROUSAI1    
                        COMPUTE    RECE41-KINGAKU2(1)  =
                                   RECE41-KINGAKU2(1)  +
                                   (TNS-TEN   *   WRK-ZAIKAISU-XXX)
                        MOVE    RECE41-TEKSTYMD    
                                           TO   RECE41-SYOSAIYMD2(1)
                   END-IF  
      *    再診のレセ点数欄の編集（集計方法変更後）
               WHEN    "12"
                 EVALUATE  TNS-GAITENTTLKBN
      *      （基本手技）
                   WHEN  120
                     IF   SRY-SRYCD(IDX3) =  CONS-ROUSAI5  OR
                                             CONS-ROUSAI6  OR
                                             CONS-ROUSAI7  
                         COMPUTE    RECE41-KINGAKU2(2)  =
                                    RECE41-KINGAKU2(2)  +
                                   (TNS-TEN   *   WRK-ZAIKAISU-XXX)
                         MOVE    RECE41-TEKSTYMD    
                                           TO   RECE41-SYOSAIYMD2(2)
                     ELSE
                         ADD   WK-ZAIKAISU  TO
                                            RECE41-KAISU(2)
                         COMPUTE    RECE41-TENSU(2)  =
                                    RECE41-TENSU(2)  +
                                   (TNS-TEN   *   WRK-ZAIKAISU-XXX)
                     END-IF
      *      （時間外）
                   WHEN  123
                        MOVE  "1"     TO   RECE41-SAISHINTIME 
                        ADD   WK-ZAIKAISU  TO
                                            RECE41-KAISU(2)
                        COMPUTE RECE41-TENSU(2) =
                                RECE41-TENSU(2) +
                                (TNS-TEN   *   WRK-ZAIKAISU-XXX)
      *      （休日）
                   WHEN  124
                        MOVE  "2"     TO   RECE41-SAISHINTIME 
                        ADD   WK-ZAIKAISU  TO
                                            RECE41-KAISU(2)
                        COMPUTE RECE41-TENSU(2) =
                                RECE41-TENSU(2) +
                                (TNS-TEN   *   WRK-ZAIKAISU-XXX)
      *      （深夜）
                   WHEN  125
                        MOVE  "3"     TO   RECE41-SAISHINTIME 
                        ADD   WK-ZAIKAISU  TO
                                            RECE41-KAISU(2)
                        COMPUTE RECE41-TENSU(2) =
                                RECE41-TENSU(2) +
                                (TNS-TEN   *   WRK-ZAIKAISU-XXX)
                 END-EVALUATE
      *    指導のレセ点数欄の編集
               WHEN    "13"
                         COMPUTE    RECE41-TENSU(5)  =
                                    RECE41-TENSU(5)  +
                                   (WK-ZAITEN   *   WK-ZAIKAISU)
      *    投薬のレセ点数欄の編集
               WHEN    "21"
                   IF     SRY-SRYCD(IDX3) (1:1)   =    "6"  OR  "S"
                     IF   SRY-SRYCD(IDX3)         =    CONS-YAKTEIGEN
                       COMPUTE   RECE41-TENSU(7)  =
                                 RECE41-TENSU(7)  -
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                     ELSE
                       ADD   WK-ZAIKAISU       TO   RECE41-KAISU(7)
                       COMPUTE   RECE41-TENSU(7)  =
                                 RECE41-TENSU(7)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                     END-IF
                   ELSE
                     IF      SRY-SRYCD(IDX3)     =   "820000047"
                       ADD    WK-ZAIKAISU       TO   RECE41-KAISU(7)
                       COMPUTE   RECE41-TENSU(7)  =
                                 RECE41-TENSU(7)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                     ELSE
      *----(2002/01/09)-----------------------------------------------------
                      IF   SRY-SRYCD(IDX3)   =    CONS-FUNSAI-COMMENT
                       ADD   WK-ZAIKAISU       TO   RECE41-KAISU(7)
                       COMPUTE   RECE41-TENSU(7)  =
                                 RECE41-TENSU(7)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                      ELSE   
      *---------------------------------------------------------------------
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(8)
                       COMPUTE   RECE41-TENSU(8)  =
                                 RECE41-TENSU(8)  +
                                (TNS-TEN   *   WRK-ZAIKAISU-XXX)
      *----(2002/01/09)-----------------------------------------------------
                      END-IF   
      *---------------------------------------------------------------------
                     END-IF
                   END-IF
               WHEN    "22"
                   ADD    WK-ZAIKAISU    TO   RECE41-KAISU(9)
                   COMPUTE   RECE41-TENSU(9)  =
                             RECE41-TENSU(9)  +
                            (WK-ZAITEN   *   WK-ZAIKAISU)
               WHEN    "23"
                   IF     SRY-SRYCD(IDX3) (1:1)   =  "6" OR "S" OR "8"
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(10)
                       COMPUTE   RECE41-TENSU(10)  =
                                 RECE41-TENSU(10)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                   ELSE
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(11)
                       COMPUTE   RECE41-TENSU(11)  =
                                 RECE41-TENSU(11)  +
                                (TNS-TEN   *   WRK-ZAIKAISU-XXX)
                   END-IF
      *    処方のレセ点数欄の編集
               WHEN    "25"
                   IF SRY-SRYCD(IDX3)   =    "120002270"
                      COMPUTE  WRK-TOKUTEI-SKAN  = WRK-TOKUTEI-SKAN +
                                                   WK-ZAIKAISU 
                   END-IF
                   IF SRY-SRYCD(IDX3)   =    "120002170"
                      COMPUTE  WRK-NYUYOUJI-SKAN = WRK-NYUYOUJI-SKAN +
                                                   WK-ZAIKAISU 
                   END-IF
                   ADD    WK-ZAIKAISU     TO    RECE41-KAISU(12)
                   COMPUTE   RECE41-TENSU(12)  =
                             RECE41-TENSU(12)  +
                            (TNS-TEN   *   WRK-ZAIKAISU-XXX)
      *    麻毒のレセ点数欄の編集
               WHEN    "26"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(13)
                   IF SRY-SRYCD(IDX3)      =    "120001310"
                    COMPUTE WRK-MADOKU-SHOHO = WRK-MADOKU-SHOHO +
                                               WK-ZAIKAISU 
                   END-IF
                   COMPUTE   RECE41-TENSU(13)  =
                             RECE41-TENSU(13)  +
                            (TNS-TEN   *   WRK-ZAIKAISU-XXX)
      *    調基のレセ点数欄の編集
               WHEN    "27"
                   COMPUTE   RECE41-TENSU(14)  =
                             RECE41-TENSU(14)  +
                            (TNS-TEN   *   WRK-ZAIKAISU-XXX)
      *    皮下筋肉内注射のレセ点数欄の編集
               WHEN    "31"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(15)
                   COMPUTE   RECE41-TENSU(15)  =
                             RECE41-TENSU(15)  +
                            (WK-ZAITEN   *   WK-ZAIKAISU)
      *    静脈内注射のレセ点数欄の編集
               WHEN    "32"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(16)
                   COMPUTE   RECE41-TENSU(16)  =
                             RECE41-TENSU(16)  +
                            (WK-ZAITEN   *   WK-ZAIKAISU)
      *    その他注射のレセ点数欄の編集
               WHEN    "33"
                   COMPUTE   RECE41-TENSU(17)  =
                             RECE41-TENSU(17)  +
                            (WK-ZAITEN   *   WK-ZAIKAISU)
      *    処置のレセ点数欄の編集
               WHEN    "40"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(18)
                   END-IF
                   COMPUTE   RECE41-TENSU(18)  =
                             RECE41-TENSU(18)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU(20)  =
                             RECE41-TENSU(20)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    手術のレセ点数欄の編集
               WHEN    "50"
               WHEN    "54"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(21)
                   END-IF
                   COMPUTE   RECE41-TENSU(21)  =
                             RECE41-TENSU(21)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU(23)  =
                             RECE41-TENSU(23)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    検査のレセ点数欄の編集
               WHEN    "60"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(24)
                   END-IF
                   COMPUTE   RECE41-TENSU(24)  =
                             RECE41-TENSU(24)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   IF    TNS-KNSJISKBN    =   2
                         COMPUTE   RECE41-KAISU(24)  =
                                   RECE41-KAISU(24)  -  
                                   WK-ZAIKAISU
                   END-IF
                   IF    TNS-SRYCD        =   CONS-SAIKETSU1  OR
                                              CONS-SAIKETSU2  OR
                                              CONS-SAIKETSU3
                         IF   RECE41-KAISU(24)  NOT =  ZERO
                              COMPUTE   RECE41-KAISU(24)  =
                                        RECE41-KAISU(24)  -   
                                        WK-ZAIKAISU
                         END-IF
                   END-IF
                   COMPUTE   RECE41-TENSU(26)  =
                             RECE41-TENSU(26)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    画像診断のレセ点数欄の編集
               WHEN    "70"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(27)
                   END-IF
                   COMPUTE   RECE41-TENSU(27)  =
                             RECE41-TENSU(27)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU(29)  =
                             RECE41-TENSU(29)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    その他のレセ点数欄の編集
               WHEN    "80"
                   IF   SRY-SRYCD(IDX3)   =      CONS-SHOHOSEN1 OR
                                                 CONS-SHOHOSEN2 OR
                                                 CONS-SHOHOSEN3 OR
                                                 CONS-SHOHOSEN4 OR
                                                 CONS-SHOHOKSN1 OR
                                                 CONS-SHOHOKSN2
                         COMPUTE   RECE41-TENSU(30)  =
                                   RECE41-TENSU(30)  +
                                  (TNS-TEN   *   WRK-ZAIKAISU-XXX)
                         COMPUTE   WK-SYUTEN  =  WK-SYUTEN  -  TNS-TEN
                   ELSE
                         IF    TNS-GAITENTTLKBN   =    130
                           COMPUTE   RECE41-TENSU(5)  =
                                     RECE41-TENSU(5)  +
                                    (TNS-TEN   *   WRK-ZAIKAISU-XXX)
                         ELSE  
                           COMPUTE   RECE41-TENSU(31)  =
                                     RECE41-TENSU(31)  +
                                    (WK-SYUTEN   *   WRK-ZAIKAISU-XXX)
                         END-IF
                   END-IF
                   COMPUTE   RECE41-TENSU(32)  =
                             RECE41-TENSU(32)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
           END-EVALUATE
      *
           .
      *
       RECE-LEFT-SET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送
      *****************************************************************
       RECE-LEFT-SET3-SEC               SECTION.
      *
           PERFORM     TENSU-TBL-SEC2
      *
           EVALUATE    SRY-SRYKBN
      *    初診のレセ点数欄の編集
               WHEN    "11"
                   IF   TNS-DATAKBN  =   2
                     EVALUATE    TNS-TIMEKSNKBN
                         WHEN    1
                         WHEN    5
                             MOVE  "1"     TO   RECE41-SHOSHINTIME
                         WHEN    3
                             MOVE  "2"     TO   RECE41-SHOSHINTIME
                         WHEN    4
                             MOVE  "3"     TO   RECE41-SHOSHINTIME
                     END-EVALUATE
                     COMPUTE    RECE41-TENSU(1)  =
                                RECE41-TENSU(1)  +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
                     IF  SRY-SRYCD(IDX3)  =  CONS-NYUKSN1  OR
                                             CONS-NYUKSN2
                             MOVE  "1"     TO   RECE41-SHOSHIN-NYU
                     END-IF
                   END-IF
                   IF   SRY-SRYCD(IDX3) = CONS-ROUSAI1    
                        COMPUTE    RECE41-KINGAKU2(1)  =
                                   RECE41-KINGAKU2(1)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                   END-IF  
                   IF   SRY-SRYCD(IDX3) = CONS-ROUSAI2 OR
                                          CONS-ROUSAI3    
                        COMPUTE    RECE41-KINGAKU2(4)  =
                                   RECE41-KINGAKU2(4)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                   END-IF  
      *    再診のレセ点数欄の編集（集計方法変更後）
               WHEN    "12"
                 EVALUATE  TNS-GAITENTTLKBN
      *      （基本手技）
                   WHEN  120
                     IF   SRY-SRYCD(IDX3) =  CONS-ROUSAI5  OR
                                             CONS-ROUSAI6  OR
                                             CONS-ROUSAI7  
                         ADD   WK-ZAIKAISU      TO   RECE41-KAISU2(2)
                         COMPUTE    RECE41-KINGAKU2(2)  =
                                    RECE41-KINGAKU2(2)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                     ELSE
                         COMPUTE    RECE41-TENSU(7)  =
                                    RECE41-TENSU(7)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                     END-IF
      *
      *      （外来管理加算）
                   WHEN  122
                        ADD    WK-ZAIKAISU   TO   RECE41-KAISU(2)
                        COMPUTE    RECE41-TENSU(2)  =
                                   RECE41-TENSU(2)  +
                                  (TNS-TEN   *   ACCT-ZAIKAISU)
      *      （時間外）
                   WHEN  123
                        ADD    WK-ZAIKAISU   TO   RECE41-KAISU(3)
                        COMPUTE RECE41-TENSU(3) =
                                RECE41-TENSU(3) +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
      *      （休日）
                   WHEN  124
                        ADD    WK-ZAIKAISU   TO   RECE41-KAISU(4)
                        COMPUTE  RECE41-TENSU(4) =
                                 RECE41-TENSU(4) +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
      *       （深夜）
                   WHEN  125
                        ADD    WK-ZAIKAISU   TO   RECE41-KAISU(5)
                        COMPUTE  RECE41-TENSU(5) =
                                 RECE41-TENSU(5) +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
      *       （その他）
                   WHEN  OTHER 
                        IF   SRY-SRYCD(IDX3) =  CONS-ROUSAI4  
                           ADD   WK-ZAIKAISU TO   RECE41-KAISU2(3)
                           COMPUTE    RECE41-KINGAKU2(3)  =
                                      RECE41-KINGAKU2(3)  +
                                     (TNS-TEN   *   ACCT-ZAIKAISU)
                        END-IF
                 END-EVALUATE
      *    指導のレセ点数欄の編集
               WHEN    "13"
                   IF   SRY-SRYCD(IDX3) =   CONS-ROUSAI8  OR
                                            CONS-ROUSAI9  OR
                                            CONS-ROUSAI10 OR
                                            CONS-ROUSAI11 OR
                                            CONS-ROUSAI12 OR
                                            CONS-ROUSAI13 OR
                                            CONS-ROUSAI14 OR
                                            CONS-ROUSAI15 OR
                                            CONS-ROUSAI16 OR
                                            CONS-ROUSAI17 
                         COMPUTE    RECE41-KINGAKU2(6)  =
                                    RECE41-KINGAKU2(6)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                   ELSE
                         COMPUTE    RECE41-TENSU(6)  =
                                    RECE41-TENSU(6)  +
                                   (WK-ZAITEN   *   WK-ZAIKAISU)
                   END-IF                   
      *
      *    在宅のレセ点数欄の編集
               WHEN    "14"
                   MOVE      ZERO            TO   FLG-ZAITAKU
      *            往診・特別往診（時間加算）
                   IF    FLG-OSINKBN         =   1
                       MOVE         1        TO   FLG-ZAITAKU
                       COMPUTE   RECE41-TENSU(7)  =
                                 RECE41-TENSU(7)  +
                                (WK-SYUTEN   *   WK-ZAIKAISU)
                   END-IF
      *            夜間
                   IF    FLG-OSINKBN         =    2
                       MOVE   1              TO   FLG-ZAITAKU
                       COMPUTE   RECE41-TENSU(7)  =
                                 RECE41-TENSU(7)  +
                                (WK-SYUTEN   *   WK-ZAIKAISU)
                   END-IF
      *            深夜・緊急
                   IF    FLG-OSINKBN         =    3
                       MOVE   1              TO   FLG-ZAITAKU
                       COMPUTE   RECE41-TENSU(7)  =
                                 RECE41-TENSU(7)  +
                                (WK-SYUTEN   *   WK-ZAIKAISU)
                   END-IF
      *            在宅患者訪問診療
                   IF   (TNS-OSINKBN         =   1)   AND
                       ((SRY-SRYCD(IDX3)   NOT =    "114000110")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114001610")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114000970")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114000470")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114001970")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114000370")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114001570")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114001870")   AND
                        (SRY-SRYCD(IDX3)   NOT =    "114002070"))
                       MOVE   1              TO   FLG-ZAITAKU
                       COMPUTE   RECE41-TENSU(7)  =
                                 RECE41-TENSU(7)  +
                                (TNS-TEN    *  ACCT-ZAIKAISU)
                   END-IF
      *            その他
                   IF    FLG-ZAITAKU    =   ZERO
                       COMPUTE   RECE41-TENSU(7)  =
                                 RECE41-TENSU(7)  +
                                (WK-SYUTEN     *   WK-ZAIKAISU)
                   END-IF
      *            薬剤
                   COMPUTE   RECE41-TENSU-YAK(7)  =
                             RECE41-TENSU-YAK(7)  +
                             (WK-KIZAITEN *   WK-ZAIKAISU)  +
                             (WK-YKZTEN   *   WK-ZAIKAISU)
      *    投薬のレセ点数欄の編集
               WHEN    "21"
                   IF     SRY-SRYCD(IDX3) (1:1)   =    "6"  OR  "S"
                     IF   SRY-SRYCD(IDX3)         =    CONS-YAKTEIGEN
                       COMPUTE   RECE41-TENSU-YAK(9)  =
                                 RECE41-TENSU-YAK(9)  -
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                     ELSE
                       ADD   WK-ZAIKAISU       TO   RECE41-KAISU(9)
                       COMPUTE   RECE41-TENSU-YAK(9)  =
                                 RECE41-TENSU-YAK(9)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                     END-IF
                   ELSE
                     IF      SRY-SRYCD(IDX3)     =   "820000047"
                       ADD    WK-ZAIKAISU       TO   RECE41-KAISU(9)
                       COMPUTE   RECE41-TENSU-YAK(9)  =
                                 RECE41-TENSU-YAK(9)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                     ELSE
      *----(2002/01/09)-----------------------------------------------------
                      IF   SRY-SRYCD(IDX3)   =    CONS-FUNSAI-COMMENT
                       ADD   WK-ZAIKAISU       TO   RECE41-KAISU(9)
                       COMPUTE   RECE41-TENSU-YAK(9)  =
                                 RECE41-TENSU-YAK(9)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                      ELSE   
      *---------------------------------------------------------------------
                       IF    RECE41-KHNTEN(10)   =   ZERO
                             MOVE  TNS-TEN    TO    RECE41-KHNTEN(10)
                       ELSE
                          IF   RECE41-KHNTEN(10) NOT = TNS-TEN
                               MOVE   ZERO    TO    RECE41-KHNTEN(10)
                               MOVE   1       TO    FLG-KHNTEN10-JI
                          END-IF
                       END-IF
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(10)
                       COMPUTE   RECE41-TENSU(10)  =
                                 RECE41-TENSU(10)  +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
      *----(2002/01/09)-----------------------------------------------------
                      END-IF   
      *---------------------------------------------------------------------
                     END-IF
                   END-IF
               WHEN    "22"
                   ADD    WK-ZAIKAISU    TO   RECE41-KAISU(11)
                   COMPUTE   RECE41-TENSU-YAK(11)  =
                             RECE41-TENSU-YAK(11)  +
                            (WK-ZAITEN   *   WK-ZAIKAISU)
               WHEN    "23"
                   IF     SRY-SRYCD(IDX3) (1:1)   =  "6" OR "S" OR "8"
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(12)
                       COMPUTE   RECE41-TENSU-YAK(12)  =
                                 RECE41-TENSU-YAK(12)  +
                                (WK-ZAITEN   *   WK-ZAIKAISU)
                   ELSE
                       IF    RECE41-KHNTEN(13)   =   ZERO
                             MOVE  TNS-TEN    TO    RECE41-KHNTEN(13)
                       ELSE
                          IF   RECE41-KHNTEN(13) NOT = TNS-TEN
                               MOVE   ZERO    TO    RECE41-KHNTEN(13)
                               MOVE   1       TO    FLG-KHNTEN13-JI
                          END-IF
                       END-IF
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(13)
                       COMPUTE   RECE41-TENSU(13)  =
                                 RECE41-TENSU(13)  +
                                (TNS-TEN   *   ACCT-ZAIKAISU)
                   END-IF
      *    処方のレセ点数欄の編集
               WHEN    "25"
                   IF SRY-SRYCD(IDX3)   =    "120002270"
                      COMPUTE  WRK-TOKUTEI-SKAN  = WRK-TOKUTEI-SKAN +
                                                   WK-ZAIKAISU 
                   END-IF
                   IF SRY-SRYCD(IDX3)   =    "120002170"
                      COMPUTE  WRK-NYUYOUJI-SKAN = WRK-NYUYOUJI-SKAN +
                                                   WK-ZAIKAISU 
                   END-IF
                   IF    RECE41-KHNTEN(14)   =   ZERO
                         MOVE  TNS-TEN    TO    RECE41-KHNTEN(14)
                   ELSE
                      IF   RECE41-KHNTEN(14) NOT = TNS-TEN
                           MOVE   ZERO    TO    RECE41-KHNTEN(14)
                           MOVE   1       TO    FLG-KHNTEN14-JI
                      END-IF
                   END-IF
                   ADD    WK-ZAIKAISU     TO    RECE41-KAISU(14)
                   COMPUTE   RECE41-TENSU(14)  =
                             RECE41-TENSU(14)  +
                            (TNS-TEN   *   ACCT-ZAIKAISU)
      *    麻毒のレセ点数欄の編集
               WHEN    "26"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(15)
                   IF SRY-SRYCD(IDX3)      =    "120001310"
                    COMPUTE WRK-MADOKU-SHOHO = WRK-MADOKU-SHOHO +
                                               WK-ZAIKAISU 
                   END-IF
                   COMPUTE   RECE41-TENSU(15)  =
                             RECE41-TENSU(15)  +
                            (TNS-TEN   *   ACCT-ZAIKAISU)
      *    調基のレセ点数欄の編集
               WHEN    "27"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(16)
                   COMPUTE   RECE41-TENSU(16)  =
                             RECE41-TENSU(16)  +
                            (TNS-TEN   *   ACCT-ZAIKAISU)
      *    皮下筋肉内注射のレセ点数欄の編集
               WHEN    "31"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(19)
                   COMPUTE   RECE41-TENSU(19)  =
                             RECE41-TENSU(19)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU-YAK(22)  =
                             RECE41-TENSU-YAK(22)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    静脈内注射のレセ点数欄の編集
               WHEN    "32"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(20)
                   COMPUTE   RECE41-TENSU(20)  =
                             RECE41-TENSU(20)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU-YAK(22)  =
                             RECE41-TENSU-YAK(22)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    その他注射のレセ点数欄の編集
               WHEN    "33"
                   ADD    WK-ZAIKAISU     TO   RECE41-KAISU(21)
                   COMPUTE   RECE41-TENSU(21)  =
                             RECE41-TENSU(21)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU-YAK(22)  =
                             RECE41-TENSU-YAK(22)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    処置のレセ点数欄の編集
               WHEN    "40"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(25)
                   END-IF
                   COMPUTE   RECE41-TENSU(25)  =
                             RECE41-TENSU(25)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU-YAK(26)  =
                             RECE41-TENSU-YAK(26)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    手術のレセ点数欄の編集
               WHEN    "50"
               WHEN    "54"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(27)
                   END-IF
                   COMPUTE   RECE41-TENSU(27)  =
                             RECE41-TENSU(27)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU-YAK(28)  =
                             RECE41-TENSU-YAK(28)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    検査のレセ点数欄の編集
               WHEN    "60"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(29)
                   END-IF
                   COMPUTE   RECE41-TENSU(29)  =
                             RECE41-TENSU(29)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   IF    TNS-KNSJISKBN    =   2
                         COMPUTE   RECE41-KAISU(29)  =
                                   RECE41-KAISU(29)  -  
                                   WK-ZAIKAISU
                   END-IF
                   IF    TNS-SRYCD        =   CONS-SAIKETSU1  OR
                                              CONS-SAIKETSU2  OR
                                              CONS-SAIKETSU3
                         IF   RECE41-KAISU(29)  NOT =  ZERO
                              COMPUTE   RECE41-KAISU(29)  =
                                        RECE41-KAISU(29)  -   
                                        WK-ZAIKAISU
                         END-IF
                   END-IF
                   COMPUTE   RECE41-TENSU-YAK(30)  =
                             RECE41-TENSU-YAK(30)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    画像診断のレセ点数欄の編集
               WHEN    "70"
                   IF    WK-SYUTEN       NOT =   ZERO
                       ADD    WK-ZAIKAISU    TO   RECE41-KAISU(31)
                   END-IF
                   COMPUTE   RECE41-TENSU(31)  =
                             RECE41-TENSU(31)  +
                            (WK-SYUTEN   *   WK-ZAIKAISU)
                   COMPUTE   RECE41-TENSU-YAK(32)  =
                             RECE41-TENSU-YAK(32)  +
                            (WK-YKZTEN   *   WK-ZAIKAISU)
      *    その他のレセ点数欄の編集
               WHEN    "80"
                   IF ( ACCT-SRYKBN          =  "80"    )   AND
                      ( SRY-SRYCD(IDX3)(1:5) =  "09591" OR 
                                                "09592" )
                        CONTINUE
                   ELSE
                    IF ( ACCT-SRYKBN          =  "80"    )  AND         
                       ( SRY-SRYCD(IDX3)(1:5) =  "09593" )              
                       COMPUTE    RECE41-KINGAKU2(6)  =                 
                                  RECE41-KINGAKU2(6)  +                 
                                 (TNS-TEN   *   ACCT-ZAIKAISU)          
                    ELSE                                                
                     IF  SRY-SRYCD(IDX3)      =    CONS-RYOYOTEATE
                       COMPUTE    RECE41-KINGAKU2(6)  =                 
                                  RECE41-KINGAKU2(6)  +                 
                                 (WRK-RYOYOTEATE  *   ACCT-ZAIKAISU)    
                     ELSE
                      IF SRY-SRYCD(IDX3)      =    CONS-SHOHOKSN2
                       COMPUTE  WRK-TOKUTEI-SKAN2 =  WRK-TOKUTEI-SKAN2
                                                  +  WK-ZAIKAISU 
                      END-IF
                      IF SRY-SRYCD(IDX3)      =    CONS-SHOHOKSN1
                       COMPUTE  WRK-NYUYOUJI-SHOKAN = 
                                                    WRK-NYUYOUJI-SHOKAN
                                                  + WK-ZAIKAISU 
                      END-IF
                      IF   SRY-SRYCD(IDX3)    =    CONS-SHOHOSEN1 OR
                                                   CONS-SHOHOSEN2 OR
                                                   CONS-SHOHOSEN3 OR
                                                   CONS-SHOHOSEN4 OR
                                                   CONS-SHOHOKSN1 OR
                                                   CONS-SHOHOKSN2
                          ADD    WK-ZAIKAISU  TO  RECE41-KAISU(33)
                          COMPUTE   RECE41-TENSU(33)  =
                                    RECE41-TENSU(33)  +
                                   (TNS-TEN   *   ACCT-ZAIKAISU)
                          COMPUTE   WK-SYUTEN  =  WK-SYUTEN  -  TNS-TEN
                      ELSE
                          IF    TNS-GAITENTTLKBN   =    130
                            COMPUTE   RECE41-TENSU(6)  =
                                      RECE41-TENSU(6)  +
                                     (TNS-TEN   *   ACCT-ZAIKAISU)
                          ELSE  
                            IF    WK-SYUTEN       NOT =   ZERO
                                ADD  WK-ZAIKAISU  TO  RECE41-KAISU(25)
                            END-IF
                            COMPUTE   RECE41-TENSU(25)  =
                                      RECE41-TENSU(25)  +
                                     (WK-SYUTEN   *   ACCT-ZAIKAISU)
                          END-IF
                      END-IF
                      COMPUTE   RECE41-TENSU-YAK(26)  =
                                RECE41-TENSU-YAK(26)  +
                               (WK-YKZTEN   *   WK-ZAIKAISU)
                     END-IF
                    END-IF                                              
                   END-IF
           END-EVALUATE
      *
           .
      *
       RECE-LEFT-SET3-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数テーブルの検索
      *****************************************************************
       TENSU-TBL-SEC               SECTION.
      *
           INITIALIZE                           TNS-TENSU-REC
           MOVE    SRY-SRYCD(IDX2)      TO      TNS-SRYCD
           MOVE    TNS-TENSU-REC        TO      MCPDATA-REC
           MOVE    RECE45-SRYYM         TO      WK-TAIHI-SRYYM
           MOVE    WK-TAIHI-DAY         TO      WK-TAIHI-SRYD
           MOVE    WK-TAIHI-SRYYMD      TO      ORC-DBYMD
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "TENSU-KEY"          TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "TENSU-KEY"      TO      ORC-DBPATH
               PERFORM  TENSU-READ-SEC
           END-IF
      *
           MOVE   "TENSU-KEY"      TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
           .
       TENSU-TBL-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数テーブルの検索
      *****************************************************************
       TENSU-TBL-SEC2               SECTION.
      *
           INITIALIZE                           TNS-TENSU-REC
           MOVE    SRY-SRYCD(IDX3)      TO      TNS-SRYCD
           MOVE    TNS-TENSU-REC        TO      MCPDATA-REC
           MOVE    RECE45-SRYYM         TO      WK-TAIHI-SRYYM
           MOVE    WK-TAIHI-DAY         TO      WK-TAIHI-SRYD
           MOVE    WK-TAIHI-SRYYMD      TO      ORC-DBYMD
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "TENSU-KEY"          TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "TENSU-KEY"      TO      ORC-DBPATH
               PERFORM  TENSU-READ-SEC
           END-IF
      *
           MOVE   "TENSU-KEY"      TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
           .
       TENSU-TBL-EXT2.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの基本点数部分のクリア処理
      *****************************************************************
       KHNTEN-CLEAR-SEC               SECTION.
      *
           IF        FLG-KHNTEN2        =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(2)
           END-IF
           IF        FLG-KHNTEN3        =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(3)
           END-IF
           IF        FLG-KHNTEN4        =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(4)
           END-IF
           IF        FLG-KHNTEN5        =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(5)
           END-IF
           IF        FLG-KHNTEN6        =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(6)
           END-IF
           IF        FLG-KHNTEN15        =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(15)
           END-IF
           IF        FLG-KHNTEN18        =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(18)
           END-IF
           IF        FLG-KHNTEN19        =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(19)
           END-IF
           .
       KHNTEN-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの基本点数部分のクリア処理（自賠責）
      *****************************************************************
       KHNTEN-JI-CLEAR-SEC               SECTION.
      *
           IF        FLG-KHNTEN10-JI    =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(10)
           END-IF
           IF        FLG-KHNTEN13-JI    =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(13)
           END-IF
           IF        FLG-KHNTEN14-JI    =    1
               MOVE    ZERO             TO   RECE41-KHNTEN(14)
           END-IF
           .
       KHNTEN-JI-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ出力処理
      *****************************************************************
       RECE44-WRITE-SEC                SECTION.
      *
           MOVE    RECE44-REC          TO  RECE4A-REC
      *
           COMPUTE  RECE44-ZAITEN      =  RECE44-ZAITEN     -  
                                          WRK-TEN
           COMPUTE  RECE44-MEISAISU    =  RECE44-MEISAISU   -
                                          WRK-MEISAI-CNT
           COMPUTE  RECE44-SYUTEN1     =  RECE44-SYUTEN1    -
                                          WRK-TEN
           COMPUTE  RECE44-SRYCDTOTAL  =  RECE44-SRYCDTOTAL -
                                          WRK-SRYCDTOTAL
           COMPUTE  RECE44-SURYOUTOTAL =  RECE44-SURYOUTOTAL -
                                          WRK-SURYOUTOTAL     
      *
           MOVE     WRK-TEN         TO  RECE4A-ZAITEN
           MOVE     WRK-MEISAI-CNT  TO  RECE4A-MEISAISU
           MOVE     WRK-TEN         TO  RECE4A-SYUTEN1  
           MOVE     WRK-SRYCDTOTAL  TO  RECE4A-SRYCDTOTAL
           MOVE     WRK-SURYOUTOTAL TO  RECE4A-SURYOUTOTAL
      *
           WRITE   RECE44-REC
           ADD     1                TO  CNT-OUT1
      *
           WRITE   RECE4A-REC
           ADD     1                TO  CNT-OUT4
      *
           .
       RECE44-WRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ出力処理
      *****************************************************************
       RECE45-WRITE-SEC                SECTION.
      *
           MOVE    RECE45-REC          TO   RECE4B-REC      
      *
           WRITE   RECE45-REC
           ADD     1                   TO   CNT-OUT2
      *
           WRITE   RECE4B-REC
           ADD     1                   TO   CNT-OUT5
      *
           .
       RECE45-WRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ出力処理
      *****************************************************************
       RECE45-REWRITE-SEC              SECTION.                        
      *
           MOVE    ZERO                TO  FLG-REWRITE
      *
           INITIALIZE                      RECE45-REC
           MOVE    RECE44-HOSPID       TO  RECE45-HOSPID
           MOVE    RECE44-SRYYM        TO  RECE45-SRYYM
           MOVE    RECE44-NYUGAIKBN    TO  RECE45-NYUGAIKBN
           MOVE    RECE44-PTID         TO  RECE45-PTID
           MOVE    RECE44-RECEKA       TO  RECE45-RECEKA
           MOVE    RECE44-HKNID        TO  RECE45-HKNID
           MOVE    RECE44-TEKSTYMD     TO  RECE45-TEKSTYMD
           MOVE    RECE44-ZAINUM       TO  RECE45-ZAINUM
           START   RECE45-FILE
                 KEY IS    >=   RECE45-KEY
                 INVALID
                     MOVE    1         TO  FLG-RECE45
                 NOT INVALID
                     MOVE    ZERO      TO  FLG-RECE45
                     READ    RECE45-FILE   NEXT
                       AT  END
                         MOVE    1     TO  FLG-RECE45
                     END-READ
           END-START
           PERFORM   UNTIL
               (RECE44-HOSPID       NOT =  RECE45-HOSPID)      OR
               (RECE44-SRYYM        NOT =  RECE45-SRYYM)       OR
               (RECE44-NYUGAIKBN    NOT =  RECE45-NYUGAIKBN)   OR
               (RECE44-PTID         NOT =  RECE45-PTID)        OR
               (RECE44-RECEKA       NOT =  RECE45-RECEKA)      OR
               (RECE44-HKNID        NOT =  RECE45-HKNID)       OR
               (RECE44-TEKSTYMD     NOT =  RECE45-TEKSTYMD)    OR
               (RECE44-ZAINUM       NOT =  RECE45-ZAINUM)      OR
               (FLG-RECE45                =      1        )    OR
               (FLG-REWRITE               =      1        )
                IF    RECE45-RENNUM   =   WRK-RENNUM
                   MOVE    1              TO  FLG-REWRITE
                   MOVE    WRK-SRYSURYO3  TO  RECE45-SRYSURYO(5)
                   REWRITE   RECE45-REC
                END-IF
                READ    RECE45-FILE   NEXT
                  AT  END
                    MOVE    1     TO  FLG-RECE45
                END-READ
           END-PERFORM
      *
           .
       RECE45-REWRITE-EXT.
           EXIT.                                                       
      *
      *****************************************************************
      *    データ更新処理
      *****************************************************************
       RECE41-REWRITE-SEC                SECTION.
      *
           IF   RECE41-HKNKBN     =   "4"                               
      *
               COMPUTE   RECE41-TENSU(8)      =  RECE41-TENSU(1)        
                                              +  RECE41-TENSU(2)        
                                              +  RECE41-TENSU(3)        
                                              +  RECE41-TENSU(4)        
                                              +  RECE41-TENSU(5)        
                                              +  RECE41-TENSU(6)        
                                              +  RECE41-TENSU(7)        
      *
               COMPUTE   RECE41-TENSU-YAK(8)  =  RECE41-TENSU-YAK(7)    
      *
               COMPUTE   RECE41-TENSU(17)     =  RECE41-TENSU(10)       
                                              +  RECE41-TENSU(13)       
                                              +  RECE41-TENSU(14)       
                                              +  RECE41-TENSU(15)       
                                              +  RECE41-TENSU(16)       
      *
               COMPUTE   RECE41-TENSU-YAK(18) =  RECE41-TENSU-YAK(9)    
                                              +  RECE41-TENSU-YAK(11)   
                                              +  RECE41-TENSU-YAK(12)   
      *
               COMPUTE   RECE41-TENSU(23)     =  RECE41-TENSU(19)       
                                              +  RECE41-TENSU(20)       
                                              +  RECE41-TENSU(21)       
      *
               COMPUTE   RECE41-TENSU-YAK(24) =  RECE41-TENSU-YAK(22)   
      *
               COMPUTE   WRK-KSNRATE          =  RECE41-KSNRATE / 100   
      *
      ***      PERFORM    VARYING    ID1    FROM    1   BY   1          
      ***                 UNTIL      ID1    >     31                    
      *              
      ***         ADD   RECE41-SYUTEN-JI(ID1)  TO  RECE41-TOTALTEN
      ***         ADD   RECE41-YKZTEN-JI(ID1)  TO  RECE41-TOTALTEN-YAK
      *
      ***         COMPUTE   WRK-KEISAN        =  RECE41-SYUTEN-JI(ID1)  
      ***                                     *  WRK-TANKA              
      ***         COMPUTE   RECE41-TOTALKIN   =  RECE41-TOTALKIN  +
      ***                              ( WRK-KEISAN  *  WRK-KSNRATE )   
      *
      ***         COMPUTE   WRK-KEISAN        =  RECE41-YKZTEN-JI(ID1)  
      ***                                     *  WRK-TANKA              
      ***         COMPUTE   RECE41-TOTALKIN-YAK =  RECE41-TOTALKIN-YAK
      ***                                       +  WRK-KEISAN           
      *
      ***      END-PERFORM                                              
      *
               PERFORM    VARYING    ID1    FROM    1   BY   1          
                       UNTIL      ID1    >     31                    
      *              
                  ADD   RECE41-SYUTEN-JI(ID1)  TO  RECE41-TOTALTEN
                  ADD   RECE41-YKZTEN-JI(ID1)  TO  RECE41-TOTALTEN-YAK
      *
               END-PERFORM
      *
               COMPUTE   RECE41-TOTALKIN   =  
                  (RECE41-TOTALTEN  *  WRK-TANKA  *  WRK-KSNRATE) 
                                                  +  0.5
      *
               COMPUTE   RECE41-TOTALKIN-YAK =  
                  (RECE41-TOTALTEN-YAK  *  WRK-TANKA)  
                                                  +  0.5
      *
               COMPUTE   RECE41-KINGAKU2(5)   =  RECE41-KINGAKU2(1)     
                                              +  RECE41-KINGAKU2(2)     
                                              +  RECE41-KINGAKU2(3)     
                                              +  RECE41-KINGAKU2(4)     
      *
      ***      COMPUTE   RECE41-TOTALKIN2     =  RECE41-KINGAKU2(5)     
      ***                                     *  WRK-KSNRATE            
      *
               COMPUTE   RECE41-TOTALKIN2     =  
                  (RECE41-KINGAKU2(5)   *  WRK-KSNRATE)  +  0.5         
      *
               COMPUTE   RECE41-TOTALKIN2-ETC =  RECE41-KINGAKU2(6)     
                                              +  RECE41-SINDAN-KIN      
                                              +  RECE41-MEISAI-KIN      
      * 
           END-IF                                                       
      *
           REWRITE   RECE41-REC
      *
           ADD     1                   TO  CNT-OUT3
      *
           .
       RECE41-WRITE-EXT.
           EXIT.
057400*
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
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   RECE41-FILE
                   RECE44-FILE
                   RECE45-FILE
                   RECE4A-FILE
                   RECE4B-FILE
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
           DISPLAY "RECE41-IN  :" CNT-IN   
           DISPLAY "RECE41-MOD :" CNT-OUT3  
           DISPLAY "RECE44-OUT :" CNT-OUT1 
           DISPLAY "RECE45-OUT :" CNT-OUT2  
           DISPLAY "RECE4A-OUT :" CNT-OUT4 
           DISPLAY "RECE4B-OUT :" CNT-OUT5  
           
           DISPLAY "*** ORCR0420 END ***"
      * 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    WRK-PATH            TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYSKANRI-REC
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   INITIALIZE                  SYSKANRI-REC
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       800-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計読込
      *****************************************************************
       SRYACCT-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
               MOVE    ZERO            TO  FLG-SRYACCT
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           .
       SRYACCT-READ-EXT.
           EXIT.
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
      *****************************************************************
      *    点数読込
      *****************************************************************
       TENSU-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
               MOVE    ZERO            TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           .
       TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者コメントマスタ読み込み
      *****************************************************************
       950-PTCOM-READ-SEC           SECTION.
      *
           MOVE    PTCOM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTCOM-REC
                   MOVE    ZERO                TO  FLG-PTCOM
               ELSE
                   MOVE    1                   TO  FLG-PTCOM
                   INITIALIZE                  PTCOM-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTCOM
               INITIALIZE                  PTCOM-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       950-PTCOM-READ-EXT.
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
                                       MCPDATA-REC
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
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
      *
      *****************************************************************
      *    カーソルクローズ処理
      *****************************************************************
       CSR-CLOSE-SEC            SECTION.
      *
           INITIALIZE                  MCPAREA
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WK-PATH             TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       CSR-CLOSE-EXT.
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
      *
      *
      *****************************************************************
      *    中間ファイルＲＥＡＤ処理
      *****************************************************************
       RECE41-READ-SEC            SECTION.
      *
           READ    RECE41-FILE   NEXT
               AT  END
                   MOVE    1     TO    FLG-END
               NOT  AT  END
                   ADD     1     TO    CNT-IN
                   ADD     1     TO    CNT-IN-COMMIT
           END-READ
           .
       RECE41-READ-EXT.
           EXIT.
      *
