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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCHCM34.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : オンライン帳票
      *  コンポーネント名  : 会計カード
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/07/15    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
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
       01  PRT-REC                 PIC X(10000).
      *
       WORKING-STORAGE             SECTION.
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *
           COPY    "HCM341.INC".
           COPY    "HCM342.INC".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-PARA                            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                             PIC 9(01).
           03  FLG-DBRC                            PIC 9(01).
           03  FLG-JYURRK                          PIC 9(01).
           03  FLG-HEAD                            PIC 9(01).
           03  FLG-OVER                            PIC 9(01).
           03  FLG-HKNNUM                          PIC 9(01).
           03  FLG-PTHKNINF                        PIC 9(01).
           03  FLG-PTKOHINF                        PIC 9(01).
           03  FLG-PTBYOMEI                        PIC 9(01).
           03  FLG-ZENSP                           PIC 9(01).
           03  FLG-KYUSEI                          PIC 9(01).
           03  FLG-UTAGAI                          PIC 9(01).
           03  FLG-SRYACCT                         PIC 9(01).
           03  FLG-SRYACT                          PIC 9(01).
           03  FLG-TENSU                           PIC 9(01).
           03  FLG-SP                              PIC 9(01).
           03  FLG-LINE                            PIC 9(01).
           03  FLG-MINUS                           PIC 9(01).
           03  FLG-LOOPEND                         PIC 9(01).
           03  FLG-SYSKANRI                        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PAGE                            PIC 9(03).
           03  CNT-HKNCOMBI-LINE                   PIC 9(05).
           03  CNT-HKNKOH-LINE                     PIC 9(05).
           03  CNT-BYOMEI-LINE                     PIC 9(05).
           03  CNT-SRYACT-LINE                     PIC 9(05).
           03  CNT-SPACE                           PIC 9(05).
           03  CNT-STR                             PIC 9(05).
           03  CNT-BYOMEIMOJI                      PIC 9(05).
           03  CNT-HOUSRYACT                       PIC 9(05).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY                          PIC 9(02).
               05  SYS-MM                          PIC 9(02).
               05  SYS-DD                          PIC 9(02).
           03  SYS-TIME                            PIC 9(08).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                                PIC 9(05).
           03  IDX2                                PIC 9(05).
           03  IDX3                                PIC 9(05).
           03  IDX4                                PIC 9(05).
           03  IDX5                                PIC 9(05).
           03  IDX6                                PIC 9(05).
           03  IDX7                                PIC 9(05).
           03  IDX8                                PIC 9(05).
           03  IDX9                                PIC 9(05).
           03  IDX10                               PIC 9(05).
           03  IDX11                               PIC 9(05).
           03  IDX12                               PIC 9(05).
           03  IDX13                               PIC 9(05).
           03  IDXA                                PIC 9(05).
           03  IDXB                                PIC 9(05).
           03  IDXC                                PIC 9(05).
           03  IDXD                                PIC 9(05).
           03  IDXE                                PIC 9(05).
           03  IDXF                                PIC 9(05).
           03  IDX-S                               PIC 9(05).
           03  IDX-RRK                             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD                            PIC X(08).
           03  WRK-DBPATH                          PIC X(100).
           03  WRK-EDTYMD1                         PIC X(10).
           03  WRK-EDTYMD3                         PIC X(22).
           03  WRK-HCM34-AREA.
               05  WRK-HCM34-SRYYM                 PIC X(16).
               05  WRK-HCM34-SAKYMD                PIC X(22).
               05  WRK-HCM34-PTNUM                 PIC X(10).
               05  WRK-HCM34-PTNUM2                PIC X(20).
               05  WRK-HCM34-BIRTHDAY              PIC X(22).
               05  WRK-HCM34-SRYKA-MAX             PIC 9(05).
               05  WRK-HCM34-SRYKA-G.
                   07  WRK-HCM34-SRYKA             PIC X(16)
                                                   OCCURS 2.
               05  WRK-HCM34-NYUINYMD              PIC X(22).
               05  WRK-HCM34-TAIINYMD              PIC X(22).
               05  WRK-HCM34-LBLSRYKA              PIC X(06).
               05  WRK-HCM34-LBLNYUINYMD           PIC X(06).
               05  WRK-HCM34-LBLTAIINYMD           PIC X(06).
           03  WRK-STR                             PIC X(500).
           03  WRK-STR-LEFT                        PIC X(500).
           03  WRK-STR-LEFT-Z      REDEFINES       WRK-STR-LEFT.
               05  WRK-STR-LEFT-ZX99               PIC Z(9)9.
               05                                  PIC X(490).
           03  WRK-STR-LEFT-TMP                    PIC X(500).
           03  WRK-STRLEN                          PIC 9(05).
           03  WRK-STRLEN-MAX                      PIC 9(05).
      *        全角編集用項目
           03  WRK-N.
               05  WRK-HKNCOMBINUM-N               PIC X(08).
               05  WRK-TEKSTYMD-N                  PIC X(18).
               05  WRK-TEKEDYMD-N                  PIC X(18).
           03  WRK-MAE-INPUT                       PIC X(300).
           03  WRK-OUT-INPUT                       PIC X(300).
           03  WRK-OUT-MAX                         PIC 9(05).
           03  WRK-ZZ9                             PIC ZZ9.
           03  WRK-WIDTH                           PIC 9(05).
      *    診療行為欄に編集を行う項目を判断する区分
      *    1:保険組合せ／2:保険／3:公費／4:傷病名／5:診療行為
      *    空白:上記以外
           03  WRK-ITEM-KBN                        PIC X(01).
           03  WRK-SHO                             PIC 9(03).
           03  WRK-AMARI                           PIC 9(03).
           03  WRK-PTHKN-HKNNUM                    PIC X(03).
           03  WRK-PTHKN-HONKZKKBN                 PIC X(01).
           03  WRK-PTHKN-HONKZKKBNMEI              PIC X(10).
           03  WRK-PTHKN-HOJOKBN                   PIC X(01).
           03  WRK-PTHKN-HOJOKBNMEI                PIC X(10).
           03  WRK-PTHKN-CONTKBN                   PIC X(01).
           03  WRK-PTHKN-CONTKBNMEI                PIC X(10).
           03  WRK-PTKOH-FTNJANUM-N                PIC X(16).
           03  WRK-PTKOH-JKYSNUM-N                 PIC X(40).
           03  WRK-PTBYO-TENKIKBN                  PIC X(01).
           03  WRK-PTBYO-TENKIKBNMEI               PIC X(04).
           03  WRK-PTBYO-BYOMEI                    PIC X(200).
           03  WRK-PTBYO-BYOMEIMOJI                PIC 9(05).
           03  WRK-PTBYO-UTAGAIFLG                 PIC X(01).
           03  WRK-BASEYMD.
               05  WRK-BYY                         PIC 9(04).
               05  WRK-BMM                         PIC 9(02).
               05  WRK-BDD                         PIC 9(02).
           03  WRK-AGE70-YMD.
               05  WRK-AGE70-YY                    PIC 9(04).
               05  WRK-AGE70-MM                    PIC 9(02).
               05  WRK-AGE70-DD                    PIC 9(02).
           03  WRK-SRYYMD.
               05  WRK-SRYYY                       PIC 9(04).
               05  WRK-SRYMM                       PIC 9(02).
               05  WRK-SRYDD                       PIC 9(02).
           03  WRK-PNT                             PIC 9(05).
           03  WRK-ZOGENPTN                        PIC X(01).
           03  WRK-ZOGEN                           PIC S9(05).
      *    数量表示用
           03  WRK-SURYO                           PIC 9(05)V9(03).
           03  WRK-SURYO-R             REDEFINES   WRK-SURYO.
               05  WRK-SURYO-S1                    PIC 9(05).
               05  WRK-SURYO-S2                    PIC 9(03).
           03  WRK-SURYO-X.
               05  WRK-SURYO-Z1                    PIC ZZZZZ.
               05  WRK-SURYO-Z19       REDEFINES   WRK-SURYO-Z1
                                                   PIC ZZZZ9.
               05  WRK-SURYO-Z2                    PIC X(01).
               05  WRK-SURYO-Z3                    PIC ZZZ.
               05  WRK-SURYO-Z3-X      REDEFINES   WRK-SURYO-Z3
                                                   PIC X(03).
      *    分画数画面編集用
           03  WRK-BUNGSU                          PIC X(10).
           03  WRK-TENSUKAISU                      PIC X(20).
           03  WRK-KEY-HKNCOMBI                    PIC X(04).
           03  WRK-TNS-HOUKNSKBN                   PIC 9(02).
           03  WRK-KUGIRI                          PIC X(02).
           03  WRK-TTL-JIHI                        PIC 9(09).
           03  WRK-TTL-JIHI-TAX                    PIC 9(09).
           03  WRK-KINGAKKU-LBL                    PIC X(100).
           03  WRK-KINGAKKU                        PIC 9(09).
      *
       01  WRK-SRYKA-TBL.
           03  WRK-SRYKA-OCC                       OCCURS  20.
               05  WRK-SRYKA                       PIC X(02).
               05  WRK-SRYKA-SRYKAMEI1             PIC X(20).
               05  WRK-SRYKA-SRYKAMEI2             PIC X(12).
               05  WRK-SRYKA-SRYKAMEI3             PIC X(04).
      *
       01  WRK-SRYACT-AREA.
           03  WRK-SRYACT-STR                      PIC X(520).
           03  WRK-SRYACT-PNT                      PIC 9(05).
           03  WRK-SRYACT-MAX                      PIC 9(05).
           03  WRK-SRYACT-TBL.
               05  WRK-SRYACT-OCC                  OCCURS  500.
                   07  WRK-SRYACT                  PIC X(52).
           03  WRK-SRYACT-SRYKBN                   PIC X(02).
           03  WRK-SRYACT-HKNCOMBI                 PIC X(04).
           03  WRK-SRYACT-DAY-OCC                  OCCURS  31.
               05  WRK-SRYACT-DAY-X                PIC X(02).
               05  WRK-SRYACT-DAY-Z    REDEFINES   WRK-SRYACT-DAY-X
                                                   PIC Z(02).
      *
       01  SRH-AREA.
           03  SRH-IDX                             PIC 9(05).
           03  SRH-HKNNUM-DAT.
               05  SRH-HKNNUM                      PIC X(03).
               05  SRH-HKNNUMMEI                   PIC X(10).
               05  SRH-HKNNUM-MAX                  PIC 9(05).
               05  SRH-HKNNUM-OCC                  OCCURS  50.
                   07  SRH-HKNNUML                 PIC X(03).
                   07  SRH-HKNNUMMEIL              PIC X(10).
           03  SRH-KOHNUM-DAT.
               05  SRH-KOHNUM                      PIC X(03).
               05  SRH-KOHNUMMEI                   PIC X(10).
               05  SRH-PAYKBN                      PIC X(02).
               05  SRH-KOHNUM-MAX                  PIC 9(05).
               05  SRH-KOHNUM-OCC                  OCCURS  150.
                   07  SRH-KOHNUML                 PIC X(03).
                   07  SRH-PAYKBNL                 PIC X(02).
                   07  SRH-KOHNUMMEIL              PIC X(10).
           03  SRH-SRYKA-DAT.
               05  SRH-SRYKA                       PIC X(02).
               05  SRH-SRYKAMEI1                   PIC X(20).
               05  SRH-SRYKAMEI2                   PIC X(12).
               05  SRH-SRYKAMEI3                   PIC X(04).
               05  SRH-SRYKA-MAX                   PIC 9(05).
               05  SRH-SRYKA-OCC                   OCCURS 100.
                   07  SRH-SRYKAL                  PIC X(02).
                   07  SRH-SRYKAMEI1L              PIC X(20).
                   07  SRH-SRYKAMEI2L              PIC X(12).
                   07  SRH-SRYKAMEI3L              PIC X(04).
      *
       01  SRT-AREA.
           03  SRT-IDX1                            PIC 9(05).
           03  SRT-IDX2                            PIC 9(05).
           03  SRT-STIDX                           PIC 9(05).
           03  SRT-SRYACCT.
               05  SRT-SRYACCT-OCC                 OCCURS  1001.
                   07  SRT-SRYACCT-IDX             PIC 9(05).
                   07  SRT-SRYACCT-HOUKNSKBN       PIC 9(02).
                   07  SRT-SRYACCT-KEY.
                       09 SRT-SRYACCT-HKNCOMBI     PIC X(04).
                       09 SRT-SRYACCT-SRYKBN       PIC X(02).
                       09 SRT-SRYACCT-KNSJISKBN    PIC 9(01).
                       09 SRT-SRYACCT-CDKBN-SYO    PIC 9(01).
                       09 SRT-SRYACCT-CDKBN-BU     PIC 9(02).
                       09 SRT-SRYACCT-CDKBN-KBN    PIC X(01).
                       09 SRT-SRYACCT-CDKBN-KBNNUM PIC 9(03).
                       09 SRT-SRYACCT-CDKBN-KBNNUM-EDA
                                                   PIC 9(02).
                       09 SRT-SRYACCT-CDKBN-KOUBAN PIC 9(02).
                       09 SRT-SRYACCT-KOUHYOJYUNNUM
                                                   PIC 9(09).
      *
       01  CONST-AREA.
      *    会計カード診療行為最大行
           03  CONST-LINE-MAX          PIC 9(05)   VALUE 28.
      *    会計カード診療行為最大行（続紙）
           03  CONST-ZKSI-LINE-MAX     PIC 9(05)   VALUE 39.
      *    保険組合せ最大行
           03  CONST-HKNCOMBI-LINE-MAX PIC 9(05)   VALUE 6.
      *    03  CONST-HKNCOMBI-LINE-MAX PIC 9(05)   VALUE 0.
      *    保険／公費最大行
           03  CONST-HKNKOH-LINE-MAX   PIC 9(05)   VALUE 6.
      *    03  CONST-HKNKOH-LINE-MAX   PIC 9(05)   VALUE 0.
      *    傷病名最大行
           03  CONST-BYOMEI-LINE-MAX   PIC 9(05)   VALUE 10.
      *    03  CONST-BYOMEI-LINE-MAX   PIC 9(05)   VALUE 0.
      *    診療行為桁数
           03  CONST-SRYACT-LEN        PIC 9(05)   VALUE 52.
      *
           03  CONST-KENSACOMMENT-VAL.
                05  FILLER                 PIC X(50)   VALUE
                "血液化学検査".                        
                05  FILLER                 PIC X(50)   VALUE
                "内分泌学的検査".                        
                05  FILLER                 PIC X(50)   VALUE
                "肝炎ウイルス関連検査".
                05  FILLER                 PIC X(50)   VALUE
                "腫瘍マーカーのうちα−フェトプロテイン等".
                05  FILLER                 PIC X(50)   VALUE
                "腫瘍マーカー".                        
                05  FILLER                 PIC X(50)   VALUE
                "出血・凝固検査".                        
                05  FILLER                 PIC X(50)   VALUE
                "自己抗体検査".                        
                05  FILLER                 PIC X(50)   VALUE
                "内分泌負荷試験".
            03 CONST-KENSACOMMENT-R        REDEFINES
                                           CONST-KENSACOMMENT-VAL.
                05  CONST-KENSACOMMENT     PIC X(50)   OCCURS  8.
      *    薬剤料逓減
           03  CONST-TEIGEN                PIC X(09)   VALUE
               "630010002".
           03  CONST-SRYKAMEI-LEN          PIC 9(05)   VALUE   32.
      *
      *    スパ領域 ワーク
           COPY    "COMMON-SPA"
                   REPLACING   //SPA-//    BY //WRK-SPA-//.
      *
      *    保険組み合わせワーク
       01  WKHKNCOMBI-AREA.
           02  WKHKNCOMBI-MAX          PIC 9(05).
           02  WKHKNCOMBI-OCC          OCCURS 50.
               03  WKHKNCOMBI-HKNCOMBINUM
                                       PIC  X(04).
               03  WKHKNCOMBI-HKNCOMBIMEI
                                       PIC  X(50).
               03  WKHKNCOMBI-TEKSTYMDS
                                       PIC  X(08).
               03  WKHKNCOMBI-TEKEDYMDS
                                       PIC  X(08).
               03  WKHKNCOMBI-TEKSTYMDW
                                       PIC  X(09).
               03  WKHKNCOMBI-TEKEDYMDW
                                       PIC  X(09).
      *
      *    保険マスタワーク
       01  WKPTHKNINF-REC.
           02  WKPTHKNINF-MAX          PIC 9(05).
           02  WKPTHKNINF-OCC          OCCURS 50.
           COPY    "CPPTHKNINF.INC"
                   REPLACING   //PTHKN-//  BY  //WKPTHKN-//.
      *
      *    公費マスタワーク
       01  WKPTKOHINF-REC.
           02  WKPTKOHINF-MAX          PIC 9(05).
           02  WKPTKOHINF-OCC          OCCURS 50.
           COPY    "CPPTKOHINF.INC"
                   REPLACING   //PTKOH-//  BY  //WKPTKOH-//.
      *
      *    患者病名マスタ−ワーク
       01  WKPTBYOMEI-REC.
           02  WKPTBYOMEI-MAX          PIC 9(05).
           02  WKPTBYOMEI-OCC          OCCURS 300.
           COPY    "CPPTBYOMEI.INC"
                   REPLACING   //PTBYO-//  BY //WKPTBYO-//.
      *
      *    診療会計ワーク
       01  WKSRYACCT-REC.
           02  WKSRYACCT-MAX           PIC 9(05).
           02  WKSRYACCT-OCC           OCCURS 1000
                                       INDEXED WKSRYACCT-IDX.
           COPY    "CPSRYACCT.INC"
                   REPLACING   //ACCT-//  BY //WKACCT-//.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険マスタ
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    公費マスタ
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    患者病名マスタ
       01  PTBYOMEI-REC.
           COPY    "CPPTBYOMEI.INC".
      *
      *    患者コメント
       01  PTCOM-REC.
           COPY    "CPPTCOM.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    診療行為マスター
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報
           COPY    "CPSK1001.INC".
      *
      *    診療科目情報
           COPY    "CPSK1005.INC".
      *
      *    病棟情報
           COPY    "CPSK5001.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    印刷管理
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    保険組合せ編集サブ
           COPY    "CPORCSHKNSET.INC".
      *
      *    印刷用データ
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *    印刷パラメタ
           COPY    "CPORCSMKPRT.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    印刷ＤＢ制御サブ
           COPY    "CPORCSPRT.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       COPY    "COMMON-SPA".
       COPY    "CPORCHCM34.INC".
      *
      ******************************************************************
      *
       PROCEDURE               DIVISION    USING
                                           SPA-AREA
                                           ORCHCM34AREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
           IF    ( ORCHCM34-RC     NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
           PERFORM 200-MAIN-SEC
           IF    ( ORCHCM34-RC     NOT =   ZERO )
               GO  TO  000-PROC-EXT
           END-IF
      *
           PERFORM 300-END-SEC
           .
      *
      000-PROC-EXT.
           EXIT PROGRAM.
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SRH-AREA
           INITIALIZE                  ORCHCM34-OT
      *
      *    医療機関情報取得処理
           PERFORM 1001-SYS1001-GET-SEC
           IF    ( ORCHCM34-RC     NOT =   ZERO )
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    保険の種類・公費の種類編集処理
           PERFORM 1001-HKNKOH-HEN-SEC
      *    診療科編集処理
           PERFORM 1001-SRYKA-HEN-SEC
      *    基本情報編集
           PERFORM 1001-KHN-EDIT-SEC
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                      SYS-1031-REC
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "2"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SYSYMD          TO  ORCSPRTNM-SRYYMD
           MOVE    ORCHCM34-NYUGAIKBN  TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1031-REC
      *
           INITIALIZE                  HCM341
           MOVE    ZERO                TO  FLG-HEAD
           MOVE    ZERO                TO  CNT-PAGE
           MOVE    ZERO                TO  CNT-SRYACT-LINE
           MOVE    LOW-VALUE           TO  WRK-KEY-HKNCOMBI
           MOVE    ZERO                TO  WRK-TTL-JIHI
           MOVE    ZERO                TO  WRK-TTL-JIHI-TAX
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    医療機関情報取得処理
      *****************************************************************
       1001-SYS1001-GET-SEC                SECTION.
      *
      *    医療機関ＩＤ編集
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    ORCHCM34-SRYYM      TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
           ELSE
               MOVE    1               TO  ORCHCM34-RC
               GO  TO  1001-SYS1001-GET-EXT
           END-IF
      *
           .
       1001-SYS1001-GET-EXT.
           EXIT.
      *****************************************************************
      *    基本情報編集
      *****************************************************************
       1001-KHN-EDIT-SEC               SECTION.
      *
           INITIALIZE  WRK-HCM34-AREA
      *
      *    診療年月
           MOVE    ORCHCM34-SRYYM      TO  WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2)
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3 (1:16)  TO  WRK-HCM34-SRYYM
      *
      *    作成日
           MOVE    SPA-SYSYMD          TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-HCM34-SAKYMD
      *
      *    患者番号
           INITIALIZE                      ORCSPTIDAREA
           MOVE    SPA-HOSPID          TO  SPTID-HOSPID
           MOVE    SPA-PTID            TO  SPTID-PTID
           CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                           SPA-1009-TBL
           IF    ( SPTID-RC            =   ZERO )
               IF    ( SPTID-PTNUM ( 11 : 1)   =   SPACE )
                   MOVE    SPTID-PTNUM TO  WRK-HCM34-PTNUM
               ELSE
                   MOVE    SPTID-PTNUM TO  WRK-HCM34-PTNUM2
               END-IF
           END-IF
      *
      *    患者情報取得
           INITIALIZE  PTINF-REC
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-PTID            TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "PTINF-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               INITIALIZE                  PTINF-REC
           ELSE
               MOVE    MCPDATA-REC     TO  PTINF-REC
           END-IF
      *
           MOVE    "PTINF-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    生年月日
           MOVE    PTINF-BIRTHDAY      TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-HCM34-BIRTHDAY
      *
      *    保険年齢で７０歳を迎える日を求める
           MOVE    PTINF-BIRTHDAY      TO  WRK-BASEYMD
           IF    ( WRK-BDD         NOT =   01 )
               COMPUTE WRK-BMM         =   WRK-BMM     +   1
               IF    ( WRK-BMM         >   12 )
                   COMPUTE WRK-BYY     =   WRK-BYY     +   1
                   MOVE    01              TO  WRK-BMM
               END-IF
               MOVE    01                  TO  WRK-BDD
           END-IF
           MOVE    WRK-BASEYMD         TO  WRK-AGE70-YMD
           COMPUTE WRK-AGE70-YY        =   WRK-AGE70-YY    +   70
      *
           EVALUATE    ORCHCM34-NYUGAIKBN
           WHEN    "1"
               MOVE    "入院科"        TO  WRK-HCM34-LBLSRYKA
               MOVE    "入院日"        TO  WRK-HCM34-LBLNYUINYMD
               MOVE    "退院日"        TO  WRK-HCM34-LBLTAIINYMD
      *        入院履歴より、入院科・入院日・退院日を取得
               PERFORM 10011-PTNYUINRRK-HEN-SEC
           WHEN    "2"
               MOVE    "診療科"        TO  WRK-HCM34-LBLSRYKA
               MOVE    SPACE           TO  WRK-HCM34-LBLNYUINYMD
               MOVE    SPACE           TO  WRK-HCM34-LBLTAIINYMD
      *        受診履歴より、診療科を取得
               PERFORM 10011-SRYKA-HEN-SEC
               MOVE    SPACE           TO  WRK-HCM34-NYUINYMD
               MOVE    SPACE           TO  WRK-HCM34-TAIINYMD
           END-EVALUATE
      *
           .
       1001-KHN-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院履歴情報編集処理
      *****************************************************************
       10011-PTNYUINRRK-HEN-SEC        SECTION.
      *
           INITIALIZE                      PTNYUINRRK-REC
           MOVE    SPA-HOSPID          TO  PTNYUINRRK-HOSPID
           MOVE    SPA-PTID            TO  PTNYUINRRK-PTID
           MOVE    ORCHCM34-SRYYM      TO  WRK-SYMD
           PERFORM 800-GETUMATU-SEC
           MOVE    WRK-SYMD            TO  PTNYUINRRK-NYUINYMD
           MOVE    ORCHCM34-SRYYM      TO  PTNYUINRRK-TAIINYMD
           MOVE    "01"                TO  PTNYUINRRK-TAIINYMD (7:2)
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY11"  TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF   (  FLG-DBRC        NOT =   ZERO )
               GO  TO  10011-PTNYUINRRK-HEN-EXT
           END-IF
      *
           MOVE    MCPDATA-REC         TO  PTNYUINRRK-REC
           MOVE    PTNYUINRRK-NYUINKA  TO  SRH-SRYKA
           PERFORM 200111-SRYKA-HEN-SEC
           MOVE    SRH-SRYKAMEI1       TO  WRK-HCM34-SRYKA(2)
      *
           MOVE    PTNYUINRRK-NYUINYMD TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-HCM34-NYUINYMD
      *
           MOVE    PTNYUINRRK-TAIINYMD TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-HCM34-TAIINYMD
      *
           .
       10011-PTNYUINRRK-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療科編集処理
      *****************************************************************
       10011-SRYKA-HEN-SEC             SECTION.
      *
           INITIALIZE                      WRK-SRYKA-TBL
           MOVE    ZERO                TO  WRK-HCM34-SRYKA-MAX
           MOVE    SPACE               TO  WRK-HCM34-SRYKA-G
      *
           MOVE    ZERO                TO  FLG-SRYACCT
           INITIALIZE                      SRYACCT-REC
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    ORCHCM34-NYUGAIKBN  TO  ACCT-NYUGAIKBN
           MOVE    SPA-PTID            TO  ACCT-PTID
           MOVE    ORCHCM34-SRYYM      TO  ACCT-SRYYM
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "SRYACCT-KEY23"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1               TO  FLG-SRYACCT
           ELSE
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
           END-IF
      *
           MOVE    ZERO                TO  WKSRYACCT-MAX
           INITIALIZE                      WKSRYACCT-REC
           PERFORM UNTIL     ( FLG-SRYACCT =   1 )
      *
               PERFORM VARYING IDX13   FROM    1   BY  1
                       UNTIL ( IDX13       >   WKSRYACCT-MAX )
                        OR   ( IDX13       >   20 )
                        OR   ( ACCT-SRYKA  =   WRK-SRYKA (IDX13) )
                   CONTINUE
               END-PERFORM
      *
               IF    ( IDX13               >   WKSRYACCT-MAX )
                   COMPUTE WKSRYACCT-MAX   =   WKSRYACCT-MAX   +   1
                   IF    ( WKSRYACCT-MAX   >   20 )
                       MOVE    20          TO  WKSRYACCT-MAX
                   ELSE
                       MOVE    ACCT-SRYKA  TO  WRK-SRYKA (WKSRYACCT-MAX)
                       MOVE    ACCT-SRYKA  TO  SRH-SRYKA
                       PERFORM 200111-SRYKA-HEN-SEC
                       MOVE    SRH-SRYKAMEI1
                                           TO  WRK-SRYKA-SRYKAMEI1
                                                         (WKSRYACCT-MAX)
                       MOVE    SRH-SRYKAMEI2
                                           TO  WRK-SRYKA-SRYKAMEI2
                                                         (WKSRYACCT-MAX)
                       MOVE    SRH-SRYKAMEI3
                                           TO  WRK-SRYKA-SRYKAMEI3
                                                         (WKSRYACCT-MAX)
                   END-IF
               END-IF
      *
               MOVE    "SRYACCT-KEY23"     TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC        NOT =   ZERO )
                   MOVE    1               TO  FLG-SRYACCT
               ELSE
                   MOVE    MCPDATA-REC     TO  SRYACCT-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SRYACCT-KEY23"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           MOVE    1                   TO  WRK-PNT
           MOVE    ZERO                TO  FLG-LOOPEND
           MOVE    ALL "　"            TO  WRK-HCM34-SRYKA-G
           PERFORM VARYING IDX13   FROM    1   BY  1
                   UNTIL ( FLG-LOOPEND NOT =   ZERO )
                    OR   ( IDX13   >   WKSRYACCT-MAX )
               MOVE    WRK-SRYKA-SRYKAMEI2 (IDX13) TO  WRK-STR
               PERFORM 800-STRLEN-CHK-SEC
               IF    ( WRK-STRLEN  +   WRK-PNT - 1
                                   <   CONST-SRYKAMEI-LEN - 2 )
                OR   ( ( WRK-STRLEN  +   WRK-PNT - 1
                                   <=  CONST-SRYKAMEI-LEN - 2 )
                   AND ( IDX13     >=    WKSRYACCT-MAX ) )
                   MOVE    "／"        TO  WRK-KUGIRI
                   IF    ( IDX13       =   1 )
                       MOVE    SPACE   TO  WRK-KUGIRI
                   END-IF
                   STRING  WRK-KUGIRI      DELIMITED   BY  SPACE
                           WRK-SRYKA-SRYKAMEI2 (IDX13)
                                           DELIMITED   BY  SPACE
                   INTO    WRK-HCM34-SRYKA-G
                   WITH    POINTER     WRK-PNT
                   END-STRING
               ELSE
                   MOVE    1           TO  FLG-LOOPEND
               END-IF
           END-PERFORM
      *
           IF    ( FLG-LOOPEND     NOT =   ZERO )
               COMPUTE WRK-PNT     =    CONST-SRYKAMEI-LEN - 1
               MOVE    "他"            TO   WRK-HCM34-SRYKA-G
                                                   (WRK-PNT:2)
           ELSE
               IF    ( WRK-HCM34-SRYKA (2) =    SPACE )
                   MOVE    WRK-HCM34-SRYKA (1)
                                       TO  WRK-HCM34-SRYKA (2)
                   MOVE    SPACE       TO  WRK-HCM34-SRYKA (1)
               END-IF
           END-IF
      *
           .
       10011-SRYKA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険の種類・公費の種類編集処理
      *****************************************************************
       1001-HKNKOH-HEN-SEC         SECTION.
      *
      *
           INITIALIZE              SRH-HKNNUM-DAT
           INITIALIZE              SRH-KOHNUM-DAT
      *
      *    保険番号検索
           MOVE    ZERO                TO  FLG-HKNNUM
           INITIALIZE                  HKNNUM-REC
           MOVE    SPA-HOSPID          TO  HKN-HOSPID
           MOVE    SPA-SYSYMD          TO  HKN-TEKSTYMD
           MOVE    SPA-SYSYMD          TO  HKN-TEKEDYMD
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           MOVE    "HKNNUM-KEY3"       TO  WRK-DBPATH
      *
           PERFORM 900-TBL-SELECT-SEC
           IF ( FLG-DBRC           NOT =   ZERO )
               MOVE    1               TO  FLG-HKNNUM
           ELSE
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-HKNNUM      =   1 )
      *
               IF    ( HKN-HKNKOHSBTKBN    =   "1" OR  "4"
                                           OR  "8" OR  "9" )
                   MOVE    SRH-HKNNUM-MAX  TO  IDX5
      *            保険
                   IF    ( IDX5            >   ZERO )
                       IF    ( HKN-HKNNUM  NOT =   SRH-HKNNUML (IDX5))
      *                    保険情報編集
                           PERFORM 10011-HKN-HEN-SEC
                       END-IF
                   ELSE
      *                保険情報編集
                       PERFORM 10011-HKN-HEN-SEC
                   END-IF
      *
               ELSE
      *            公費
                   MOVE    SRH-KOHNUM-MAX  TO  IDX5
                   IF    ( IDX5            >   ZERO )
                       IF    ( HKN-HKNNUM  =   SRH-KOHNUML (IDX5))
                           IF    ( HKN-HKNNUM  =   "027"  ) 
                             AND ( HKN-PAYKBN  =   "01" OR "02"  )
                               IF ( HKN-PAYKBN
                                           NOT =   SRH-PAYKBNL (IDX5))
      *                            公費情報編集
                                   PERFORM 10011-KOH-HEN-SEC
                               END-IF
                           END-IF
                       ELSE
      *                    公費情報編集
                           PERFORM 10011-KOH-HEN-SEC
                       END-IF
                   ELSE
      *                公費情報編集
                       PERFORM 10011-KOH-HEN-SEC
                   END-IF
               END-IF
      *
      *        保険番号読み込み
               MOVE    "HKNNUM-KEY3"   TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF ( FLG-DBRC           NOT =   ZERO )
                   MOVE    1           TO  FLG-HKNNUM
               ELSE
                   MOVE    MCPDATA-REC TO  HKNNUM-REC
               END-IF
      *
           END-PERFORM
      *
      *    保険番号クローズ
           MOVE    "HKNNUM-KEY3"       TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       3101-HKNKOH-CMB-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    保険情報編集処理
      *****************************************************************
       10011-HKN-HEN-SEC          SECTION.
      *
           IF    ( SRH-HKNNUM-MAX      >=  50 )
               GO  TO  10011-HKN-HEN-EXT
           END-IF
      *
           COMPUTE SRH-HKNNUM-MAX  =   SRH-HKNNUM-MAX   +   1
      *
           MOVE    SRH-HKNNUM-MAX      TO  IDX5
      *
           MOVE    HKN-HKNNUM          TO  SRH-HKNNUML   (IDX5)
           MOVE    HKN-TANSEIDONAME    TO  SRH-HKNNUMMEIL(IDX5)
      *
           .
       10011-HKN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費情報編集処理
      *****************************************************************
       10011-KOH-HEN-SEC           SECTION.
      *
           IF    ( SRH-KOHNUM-MAX      >=  150 )
               GO  TO  10011-KOH-HEN-EXT
           END-IF
      *
           COMPUTE SRH-KOHNUM-MAX  =   SRH-KOHNUM-MAX  +   1
      *
           MOVE    SRH-KOHNUM-MAX      TO  IDX5
      *
           MOVE    HKN-HKNNUM          TO  SRH-KOHNUML (IDX5)
      *
           IF    ( HKN-HKNNUM          =   "027" )
            AND  ( HKN-PAYKBN      NOT =   "01" AND "02" )
               MOVE    "老人保健"      TO  SRH-KOHNUMMEIL (IDX5)
           ELSE
               MOVE    HKN-TANSEIDONAME
                                       TO  SRH-KOHNUMMEIL (IDX5)
           END-IF
      *
           IF    ( HKN-HKNNUM          =   "027" )
            AND  ( HKN-PAYKBN          =   "01" OR  "02" )
               MOVE    HKN-PAYKBN
                                       TO  SRH-PAYKBNL (IDX5)
           ELSE
               MOVE    SPACE           TO  SRH-PAYKBNL (IDX5)
           END-IF
      *
           .
       10011-KOH-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療科編集処理
      *****************************************************************
       1001-SRYKA-HEN-SEC              SECTION.
      *
           INITIALIZE              SRH-SRYKA-DAT
      *
      *    システム管理マスタ検索処理
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1005"              TO  SYS-KANRICD
           MOVE    ORCHCM34-SRYYM      TO  ORC-DBYMD
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
      *
           MOVE    "SYSKANRI-KEY2"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
      *
           PERFORM VARYING IDX5    FROM    1   BY  1
               UNTIL     ( IDX5            >   100 )
                   OR    ( FLG-DBRC    NOT =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
      *
               MOVE    IDX5            TO  SRH-SRYKA-MAX
               MOVE    SYS-1005-KBNCD (1 : 2)
                                       TO  SRH-SRYKAL (IDX5)
               MOVE    SYS-1005-SRYKANAME1
                                       TO  SRH-SRYKAMEI1L (IDX5)
               MOVE    SYS-1005-SRYKANAME2
                                       TO  SRH-SRYKAMEI2L (IDX5)
               MOVE    SYS-1005-SRYKANAME3
                                       TO  SRH-SRYKAMEI3L (IDX5)
      *
      *        システム管理マスタ読込処理
               MOVE    "SYSKANRI-KEY2" TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
      *
           END-PERFORM
      *
      *    システム管理マスタクローズ処理
           MOVE    "SYSKANRI-KEY2"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       1001-SRYKA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
      *    保険組合せ編集処理
           PERFORM 2001-HKNCOMBI-HEN-SEC
      *    保険編集処理
           PERFORM 2001-PTHKN-HEN-SEC
      *    公費編集処理
           PERFORM 2001-PTKOH-HEN-SEC
      *    傷病名編集処理
           PERFORM 2001-PTBYOMEI-HEN-SEC
      *    診療行為編集処理
           PERFORM 2001-SRYACT-HEN-SEC
      *
           IF    ( CNT-PAGE        =   ZERO )
            OR   (   ( CNT-PAGE        >   ZERO )
                AND  ( CNT-SRYACT-LINE >   ZERO ))
               PERFORM 290-PRINT-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ編集処理
      *****************************************************************
       2001-HKNCOMBI-HEN-SEC           SECTION.
      *
           INITIALIZE                  WKHKNCOMBI-AREA
      *
           INITIALIZE                  ORCSHKNSETAREA
           INITIALIZE                  WRK-SPA-AREA
      *
           MOVE    PTINF-HOSPID    TO  WRK-SPA-HOSPID
           MOVE    PTINF-PTID      TO  WRK-SPA-PTID
           MOVE    PTINF-BIRTHDAY  TO  WRK-SPA-BIRTHDAY
           MOVE    ORCHCM34-SRYYM  TO  WRK-SPA-SRYYMD (1:6)
           MOVE    "01"            TO  WRK-SPA-SRYYMD (7:2)
      *
           MOVE    ORCHCM34-NYUGAIKBN
                                   TO  WRK-SPA-NYUGAIKBN
           MOVE    "2"             TO  ORCSHKN-KBN
      *
           CALL    "ORCSHKNSET"    USING   WRK-SPA-AREA
                                           ORCSHKNSETAREA
           IF    ( ORCSHKN-ERRCD   NOT =   ZERO )
               INITIALIZE              ORCSHKNSETAREA
           END-IF
      *
           MOVE    ZERO            TO  CNT-HKNCOMBI-LINE
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   ORCSHKN-HKN-MAX )
      *
               IF    ( ORCHCM34-SRYYM
                                   >=  ORCSHKN-NAI-TEKSTYMD(IDX1)(1:6))
                AND  ( ORCHCM34-SRYYM
                                   <=  ORCSHKN-NAI-TEKEDYMD(IDX1)(1:6))
                   IF    ( CNT-HKNCOMBI-LINE
                                       <    CONST-HKNCOMBI-LINE-MAX )
      *
                       PERFORM 20011-HKNCOMBI-HEN-SEC
                   ELSE
      *
      *                保険組合せ欄に収まりきらない場合、
      *                ワークエリアに退避する
                       IF    ( WKHKNCOMBI-MAX  <   50 )
                           COMPUTE WKHKNCOMBI-MAX  =   WKHKNCOMBI-MAX
                                                   +   1
      *
                           MOVE    WKHKNCOMBI-MAX  TO  IDXA
      *
                           MOVE    ORCSHKN-GMN-HKNCOMBINUM(IDX1)
                                       TO  WKHKNCOMBI-HKNCOMBINUM(IDXA)
                           MOVE    ORCSHKN-GMN-HKNCOMBIMEI(IDX1)
                                       TO  WRK-MAE-INPUT
                           PERFORM 800-ZENKAKU-HEN-SEC
                           MOVE    WRK-OUT-INPUT
                                       TO  WKHKNCOMBI-HKNCOMBIMEI(IDXA)
                           MOVE    ORCSHKN-NAI-TEKSTYMD(IDX1)
                                       TO  WKHKNCOMBI-TEKSTYMDS (IDXA)
                           MOVE    ORCSHKN-NAI-TEKEDYMD(IDX1)
                                       TO  WKHKNCOMBI-TEKEDYMDS (IDXA)
                           MOVE    ORCSHKN-GMN-TEKSTYMD(IDX1)
                                       TO  WKHKNCOMBI-TEKSTYMDW (IDXA)
                           MOVE    ORCSHKN-GMN-TEKEDYMD(IDX1)
                                       TO  WKHKNCOMBI-TEKEDYMDW (IDXA)
      *
                       END-IF
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       2001-HKNCOMBI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ編集処理
      *****************************************************************
       20011-HKNCOMBI-HEN-SEC           SECTION.
      *
           COMPUTE CNT-HKNCOMBI-LINE   =   CNT-HKNCOMBI-LINE   +   1
      *
           MOVE    CNT-HKNCOMBI-LINE   TO  IDXA
      *
           MOVE    ORCSHKN-GMN-HKNCOMBINUM(IDX1)
                                       TO  HCM341-HKNCOMBINUM(IDXA)
           MOVE    ORCSHKN-GMN-HKNCOMBIMEI(IDX1)
                                       TO  HCM341-HKNCOMBIMEI(IDXA)
      *
      *    半角スペースが途中に含まれていた場合の対応
      *    （末尾の全角文字が尻切れにならないようにする）
           MOVE    ZERO                TO  CNT-SPACE
           INSPECT HCM341-HKNCOMBIMEI(IDXA)    TALLYING
                   CNT-SPACE   FOR ALL " "
      *
           DIVIDE  CNT-SPACE   BY  2 GIVING WRK-SHO
           REMAINDER WRK-AMARI
      *
           IF    ( WRK-AMARI   NOT =   ZERO )
               MOVE    1               TO  WRK-STRLEN-MAX
               MOVE    SPACE           TO  WRK-STR
               STRING  HCM341-HKNCOMBIMEI(IDXA)
               DELIMITED   BY  SIZE
               INTO    WRK-STR
               WITH    POINTER WRK-STRLEN-MAX
               END-STRING
               COMPUTE WRK-STRLEN-MAX  =   WRK-STRLEN-MAX
                                       -   1
               MOVE    WRK-STR (1:WRK-STRLEN-MAX - 1)
                                       TO  HCM341-HKNCOMBIMEI(IDXA)
           END-IF
      *
           MOVE    ORCSHKN-GMN-TEKSTYMD(IDX1)
                                       TO  HCM341-TEKSTYMD (IDXA)
           MOVE    ORCSHKN-GMN-TEKEDYMD(IDX1)
                                       TO  HCM341-TEKEDYMD (IDXA)
      *
           .
       20011-HKNCOMBI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険編集処理
      *****************************************************************
       2001-PTHKN-HEN-SEC              SECTION.
      *
           INITIALIZE  WKPTHKNINF-REC
      *
      *    患者保険マスタ検索
           MOVE    ZERO                TO  FLG-PTHKNINF
           INITIALIZE                  PTHKNINF-REC
           MOVE    PTINF-HOSPID        TO  PTHKN-HOSPID
           MOVE    PTINF-PTID          TO  PTHKN-PTID
      *
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           MOVE    "PTHKNINF-KEY2"     TO  WRK-DBPATH
      *
           PERFORM 900-TBL-SELECT-SEC
           IF ( FLG-DBRC           NOT =   ZERO )
               MOVE    1               TO  FLG-PTHKNINF
           ELSE
               MOVE    MCPDATA-REC     TO  PTHKNINF-REC
           END-IF
      *
           MOVE    ZERO            TO  CNT-HKNKOH-LINE
           PERFORM UNTIL ( FLG-PTHKNINF    NOT =   ZERO )
      *
               IF    ( PTHKN-SAKJOKBN   =  SPACE )
                AND  ( ORCHCM34-SRYYM  >=  PTHKN-TEKSTYMD (1:6))
                AND  ( ORCHCM34-SRYYM  <=  PTHKN-TEKEDYMD (1:6))
                   IF    ( CNT-HKNKOH-LINE
                                       <    CONST-HKNKOH-LINE-MAX )
                       PERFORM 20011-PTHKN-HEN-SEC
                   ELSE
                       IF    ( WKPTHKNINF-MAX  <   50 )
                           COMPUTE WKPTHKNINF-MAX  =   WKPTHKNINF-MAX
                                                   +   1
                           MOVE    WKPTHKNINF-MAX  TO  IDXA
                           MOVE    PTHKNINF-REC    TO  WKPTHKNINF-OCC
                                                                (IDXA)
                       END-IF
                   END-IF
               END-IF
      *
               MOVE    "PTHKNINF-KEY2"     TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF ( FLG-DBRC           NOT =   ZERO )
                   MOVE    1           TO  FLG-PTHKNINF
               ELSE
                   MOVE    MCPDATA-REC TO  PTHKNINF-REC
               END-IF
           END-PERFORM
      *
           MOVE    "PTHKNINF-KEY2"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
      *
       2001-PTHKN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険編集処理
      *****************************************************************
       20011-PTHKN-HEN-SEC             SECTION.
      *
           COMPUTE CNT-HKNKOH-LINE =   CNT-HKNKOH-LINE     +   1
      *
           MOVE    CNT-HKNKOH-LINE     TO  IDXA
      *
           MOVE    PTHKN-HKNNUM        TO  SRH-HKNNUM
           PERFORM 200111-PTHKN-HKNNUM-HEN-SEC
           MOVE    SRH-HKNNUMMEI       TO  HCM341-HKNNAME (IDXA)
      *
           MOVE    PTHKN-HKNJANUM      TO  HCM341-HKNJANUM (IDXA)
      *
           MOVE    PTHKN-HONKZKKBN     TO  WRK-PTHKN-HONKZKKBN
           PERFORM 200111-PTHKN-HONKZKKBN-HEN-SEC
           MOVE    WRK-PTHKN-HONKZKKBNMEI
                                       TO  HCM341-HONKZK (IDXA)
      *
           MOVE    PTHKN-HKNNUM        TO  WRK-PTHKN-HKNNUM
           MOVE    PTHKN-HOJOKBN       TO  WRK-PTHKN-HOJOKBN
           PERFORM 200111-PTHKN-HOJOKBN-HEN-SEC
           MOVE    WRK-PTHKN-HOJOKBNMEI
                                       TO  HCM341-FTNRATE (IDXA)
      *
           MOVE    PTHKN-HKNNUM        TO  WRK-PTHKN-HKNNUM
           MOVE    PTHKN-CONTKBN       TO  WRK-PTHKN-CONTKBN
           PERFORM 200111-PTHKN-CONTKBN-HEN-SEC
           MOVE    WRK-PTHKN-CONTKBNMEI
                                       TO  HCM341-CONTKBN (IDXA)
      *
           MOVE    PTHKN-KIGO          TO  HCM341-KIGO  (IDXA)
           MOVE    PTHKN-NUM           TO  HCM341-NUM   (IDXA)
      *
           .
      *
       20011-PTHKN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険の種類編集処理
      *****************************************************************
       200111-PTHKN-HKNNUM-HEN-SEC     SECTION.
      *
           MOVE    SPACE               TO  SRH-HKNNUMMEI
      *
           PERFORM VARYING SRH-IDX FROM    1   BY  1
                   UNTIL ( SRH-IDX >   SRH-HKNNUM-MAX )
               IF    ( SRH-HKNNUM  =   SRH-HKNNUML (SRH-IDX) )
                   MOVE    SRH-HKNNUMMEIL (SRH-IDX)
                                       TO  SRH-HKNNUMMEI
                   MOVE    SRH-HKNNUM-MAX
                                       TO  SRH-IDX
               END-IF
           END-PERFORM
      *
           .
       200111-PTHKN-HKNNUM-HEN-EXT.
           EXIT.
      *****************************************************************
      *    本人家族区分編集処理
      *****************************************************************
       200111-PTHKN-HONKZKKBN-HEN-SEC  SECTION.
      *
           MOVE    SPACE               TO  WRK-PTHKN-HONKZKKBNMEI
      *
           EVALUATE    WRK-PTHKN-HONKZKKBN
           WHEN    "1"
               MOVE    "本人"          TO  WRK-PTHKN-HONKZKKBNMEI
           WHEN    "2"
               MOVE    "家族"          TO  WRK-PTHKN-HONKZKKBNMEI
           END-EVALUATE
      *
           .
       200111-PTHKN-HONKZKKBN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    補助区分編集処理
      *****************************************************************
       200111-PTHKN-HOJOKBN-HEN-SEC    SECTION.
      *
           MOVE    SPACE               TO  WRK-PTHKN-HOJOKBNMEI
      *
      *    負担割合
           EVALUATE    WRK-PTHKN-HKNNUM
      *    船員
           WHEN    "002"
               IF    ( PTHKN-TEKSTYMD  >=  "20021001" )
                AND  ( WRK-AGE70-YMD   >   ZERO       )
                AND  ( PTHKN-TEKSTYMD  >=  WRK-AGE70-YMD )
                   EVALUATE    WRK-PTHKN-HOJOKBN
                   WHEN    "8"
                       MOVE    "２割"      TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "9"
                       MOVE    "１割"      TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "A" 
                       MOVE    "１割職務"  TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "B" 
                       MOVE    "１割下船"  TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "C" 
                       MOVE    "１割通勤"  TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "D" 
                       MOVE    "２割職務"  TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "E" 
                       MOVE    "２割下船"  TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "F" 
                       MOVE    "２割通勤"  TO  WRK-PTHKN-HOJOKBNMEI
                   END-EVALUATE
               ELSE
                   EVALUATE    WRK-PTHKN-HOJOKBN
                   WHEN    "1"
                       MOVE    "職務"      TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "2"
                       MOVE    "下船"      TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "3"
                       MOVE    "通勤"      TO  WRK-PTHKN-HOJOKBNMEI
                   END-EVALUATE
               END-IF
      *    国保
           WHEN    "060"
               EVALUATE    WRK-PTHKN-HOJOKBN
               WHEN    "0"
                   MOVE    "無し"          TO  WRK-PTHKN-HOJOKBNMEI
               WHEN    "1"
                   MOVE    "１割"          TO  WRK-PTHKN-HOJOKBNMEI
               WHEN    "2"
                   MOVE    "２割"          TO  WRK-PTHKN-HOJOKBNMEI
               WHEN    "3" 
                   MOVE    "３割"          TO  WRK-PTHKN-HOJOKBNMEI
               END-EVALUATE
      *    共済
           WHEN    "031"
           WHEN    "032"
           WHEN    "033"
           WHEN    "034"
               IF    ( PTHKN-TEKSTYMD  >=  "20021001" )
                AND  ( WRK-AGE70-YMD   >   ZERO       )
                AND  ( PTHKN-TEKSTYMD  >=  WRK-AGE70-YMD )
                   EVALUATE    WRK-PTHKN-HOJOKBN
                   WHEN    "8"
                       MOVE    "２割"      TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "9"
                       MOVE    "１割"      TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "B"
                       MOVE    "１割下船"  TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "E"
                       MOVE    "２割下船"  TO  WRK-PTHKN-HOJOKBNMEI
                   END-EVALUATE
               ELSE
                   EVALUATE    WRK-PTHKN-HOJOKBN
                   WHEN    "2"
                       MOVE    "下船３月"  TO  WRK-PTHKN-HOJOKBNMEI
                   END-EVALUATE
               END-IF
      *    その他
           WHEN    OTHER
      *        自費
               IF    ( PTHKN-HKNNUM (1:2) =   "98" )
                   EVALUATE    WRK-PTHKN-HOJOKBN
                   WHEN    "1"
                       MOVE    "課税"      TO  WRK-PTHKN-HOJOKBNMEI
                   WHEN    "2"
                       MOVE    "非課"      TO  WRK-PTHKN-HOJOKBNMEI
                   END-EVALUATE
               ELSE
      *            Ｈ１４．１０ 改正より
                   IF    ( PTHKN-TEKSTYMD        >=    "20021001" )
                    AND  ( WRK-AGE70-YMD         >     ZERO       )
                    AND  ( PTHKN-TEKSTYMD        >=    WRK-AGE70-YMD)
                    AND  ( PTHKN-HKNNUM (1:1) NOT =    "9")
                       EVALUATE    WRK-PTHKN-HOJOKBN
                       WHEN    "8"
                           MOVE    "２割"  TO  WRK-PTHKN-HOJOKBNMEI
                       WHEN    "9"
                           MOVE    "１割"  TO  WRK-PTHKN-HOJOKBNMEI
                       END-EVALUATE
                   END-IF
               END-IF
           END-EVALUATE
      *
           .
       200111-PTHKN-HOJOKBN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    継続区分編集処理
      *****************************************************************
       200111-PTHKN-CONTKBN-HEN-SEC    SECTION.
      *
           MOVE    SPACE                   TO  WRK-PTHKN-CONTKBNMEI
      *
           IF    ( WRK-PTHKN-HKNNUM    =   "003" )
               EVALUATE WRK-PTHKN-CONTKBN
               WHEN    "1"
                   MOVE    "継続"          TO  WRK-PTHKN-CONTKBNMEI
               WHEN    "2"
                   MOVE    "任継"          TO  WRK-PTHKN-CONTKBNMEI
               WHEN    "3"
                   MOVE    "特別"          TO  WRK-PTHKN-CONTKBNMEI
               END-EVALUATE
           ELSE
               EVALUATE WRK-PTHKN-CONTKBN
               WHEN    "1"
                   MOVE    "継続"          TO  WRK-PTHKN-CONTKBNMEI
               WHEN    "2"
                   MOVE    "任継"          TO  WRK-PTHKN-CONTKBNMEI
               END-EVALUATE
           END-IF
      *
           .
       200111-PTHKN-CONTKBN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    公費編集処理
      *****************************************************************
       2001-PTKOH-HEN-SEC              SECTION.
      *
           INITIALIZE  WKPTKOHINF-REC
      *
      *    患者公費マスタ検索
           MOVE    ZERO                TO  FLG-PTKOHINF
           INITIALIZE                  PTKOHINF-REC
           MOVE    PTINF-HOSPID        TO  PTKOH-HOSPID
           MOVE    PTINF-PTID          TO  PTKOH-PTID
      *
           MOVE    PTKOHINF-REC        TO  MCPDATA-REC
           MOVE    "PTKOHINF-KEY2"     TO  WRK-DBPATH
      *
           PERFORM 900-TBL-SELECT-SEC
           IF ( FLG-DBRC           NOT =   ZERO )
               MOVE    1               TO  FLG-PTKOHINF
           ELSE
               MOVE    MCPDATA-REC     TO  PTKOHINF-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-PTKOHINF    NOT =   ZERO )
      *
               IF    ( PTKOH-SAKJOKBN   =  SPACE )
                AND  ( ORCHCM34-SRYYM  >=  PTKOH-TEKSTYMD (1:6))
                AND  ( ORCHCM34-SRYYM  <=  PTKOH-TEKEDYMD (1:6))
                   IF    ( CNT-HKNKOH-LINE
                                       <    CONST-HKNKOH-LINE-MAX )
                       PERFORM 20011-PTKOH-HEN-SEC
                   ELSE
                       IF    ( WKPTKOHINF-MAX  <   50 )
                           COMPUTE WKPTKOHINF-MAX  =   WKPTKOHINF-MAX
                                                   +   1
                           MOVE    WKPTKOHINF-MAX  TO  IDXA
                           MOVE    PTKOHINF-REC    TO  WKPTKOHINF-OCC
                                                                (IDXA)
                       END-IF
                   END-IF
               END-IF
      *
               MOVE    "PTKOHINF-KEY2"     TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF ( FLG-DBRC           NOT =   ZERO )
                   MOVE    1           TO  FLG-PTKOHINF
               ELSE
                   MOVE    MCPDATA-REC TO  PTKOHINF-REC
               END-IF
           END-PERFORM
      *
           MOVE    "PTKOHINF-KEY2"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       2001-PTKOH-HEN-EXT.
           EXIT.
      *****************************************************************
      *    公費編集処理
      *****************************************************************
       20011-PTKOH-HEN-SEC             SECTION.
      *
           COMPUTE CNT-HKNKOH-LINE =   CNT-HKNKOH-LINE     +   1
      *
           MOVE    CNT-HKNKOH-LINE     TO  IDXA
      *
           MOVE    PTKOH-KOHNUM        TO  SRH-KOHNUM
           MOVE    PTKOH-PAYKBN        TO  SRH-PAYKBN
           PERFORM 200111-PTKOH-KOHNUM-HEN-SEC
           MOVE    SRH-KOHNUMMEI       TO  HCM341-HKNNAME (IDXA)
      *
      *
           MOVE    PTKOH-FTNJANUM          TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT           TO  HCM341-KIGO  (IDXA)
      *
           MOVE    PTKOH-JKYSNUM           TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT           TO  HCM341-NUM   (IDXA)
      *
           .
      *
       20011-PTKOH-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費の種類編集処理
      *****************************************************************
       200111-PTKOH-KOHNUM-HEN-SEC     SECTION.
      *
           MOVE    SPACE               TO  SRH-KOHNUMMEI
      *
           PERFORM VARYING SRH-IDX FROM    1   BY  1
                   UNTIL ( SRH-IDX >   SRH-KOHNUM-MAX )
               IF    ( SRH-KOHNUM  =   "027" )
                AND  ( SRH-PAYKBN  =   "01" OR "02" )
                   IF    ( SRH-KOHNUM  =   SRH-KOHNUML (SRH-IDX) )
                    AND  ( SRH-PAYKBN  =   SRH-PAYKBNL (SRH-IDX) )
                       MOVE    SRH-KOHNUMMEIL (SRH-IDX)
                                       TO  SRH-KOHNUMMEI
                       MOVE    SRH-KOHNUM-MAX
                                       TO  SRH-IDX
                   END-IF
               ELSE
                   IF    ( SRH-KOHNUM  =   SRH-KOHNUML (SRH-IDX) )
                    AND  ( SRH-PAYKBNL (SRH-IDX)   =   SPACE )
                       MOVE    SRH-KOHNUMMEIL (SRH-IDX)
                                       TO  SRH-KOHNUMMEI
                       MOVE    SRH-KOHNUM-MAX
                                       TO  SRH-IDX
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       200111-PTKOH-KOHNUM-HEN-EXT.
           EXIT.
      *****************************************************************
      *    傷病名編集処理
      *****************************************************************
       2001-PTBYOMEI-HEN-SEC           SECTION.
      *
           INITIALIZE  WKPTBYOMEI-REC
      *
      *    患者病名マスタ検索
           MOVE    ZERO                TO  FLG-PTBYOMEI
           INITIALIZE                  PTBYOMEI-REC
           MOVE    PTINF-HOSPID        TO  PTBYO-HOSPID
           MOVE    PTINF-PTID          TO  PTBYO-PTID
           MOVE    ORCHCM34-NYUGAIKBN  TO  PTBYO-NYUGAIKBN
      *
           MOVE    ORCHCM34-SRYYM      TO  PTBYO-TENKIYMD
           MOVE    "01"                TO  PTBYO-TENKIYMD (7:2)
      *
           MOVE    PTBYO-TENKIYMD      TO  WRK-SYMD
           MOVE    "2"                 TO  WRK-ZOGENPTN
           MOVE    1                   TO  WRK-ZOGEN
           PERFORM 800-CALENDAR-SEC
           MOVE    WRK-SYMD            TO  PTBYO-SRYYMD
           MOVE    SPACE               TO  PTBYO-TENKIKBN
      *
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "PTBYOMEI-KEY11"    TO  WRK-DBPATH
      *
           PERFORM 900-TBL-SELECT-SEC
           IF ( FLG-DBRC           NOT =   ZERO )
               MOVE    1               TO  FLG-PTBYOMEI
           ELSE
               MOVE    MCPDATA-REC     TO  PTBYOMEI-REC
           END-IF
      *
      *
           MOVE    ZERO            TO  CNT-BYOMEI-LINE
           PERFORM UNTIL ( FLG-PTBYOMEI    NOT =   ZERO )
      *
               IF    ( CNT-BYOMEI-LINE
                                       <    CONST-BYOMEI-LINE-MAX )
                   PERFORM 20011-PTBYOMEI-HEN-SEC
               ELSE
                   IF    ( WKPTBYOMEI-MAX  <   300 )
                       COMPUTE WKPTBYOMEI-MAX  =   WKPTBYOMEI-MAX
                                               +   1
                       MOVE    WKPTBYOMEI-MAX  TO  IDXA
                       MOVE    PTBYOMEI-REC    TO  WKPTBYOMEI-OCC
                                                            (IDXA)
                   END-IF
               END-IF
      *
               MOVE    "PTBYOMEI-KEY11"    TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF ( FLG-DBRC           NOT =   ZERO )
                   MOVE    1           TO  FLG-PTBYOMEI
               ELSE
                   MOVE    MCPDATA-REC TO  PTBYOMEI-REC
               END-IF
           END-PERFORM
      *
           MOVE    "PTBYOMEI-KEY11"    TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       2001-PTBYOMEI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    傷病名編集処理
      *****************************************************************
       20011-PTBYOMEI-HEN-SEC          SECTION.
      *
           COMPUTE CNT-BYOMEI-LINE =   CNT-BYOMEI-LINE     +   1
      *
           MOVE    CNT-BYOMEI-LINE         TO  IDXA
      *
           MOVE    PTBYO-BYOMEI            TO  WRK-PTBYO-BYOMEI
           MOVE    PTBYO-BYOMEIMOJI        TO  WRK-PTBYO-BYOMEIMOJI
           MOVE    PTBYO-UTAGAIFLG         TO  WRK-PTBYO-UTAGAIFLG
           PERFORM 20011-PTBYOMEI-BYOMEI-HEN-SEC
           MOVE    WRK-PTBYO-BYOMEI        TO  HCM341-BYOMEI (IDXA)
      *
           MOVE    PTBYO-SRYKA             TO  SRH-SRYKA
           PERFORM 200111-SRYKA-HEN-SEC
           MOVE    SRH-SRYKAMEI2(1:4)      TO  HCM341-BYOSRYKA (IDXA)
      *
           IF    ( PTBYO-SYUBYOFLG         =   "1" )
               MOVE    "主"                TO  HCM341-SYUBYO (IDXA)
           END-IF
      *
           MOVE    PTBYO-SRYYMD            TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD1             TO  HCM341-SRYYMD (IDXA)
      *
           MOVE    PTBYO-TENKIKBN          TO  WRK-PTBYO-TENKIKBN
           PERFORM 200111-PTBYO-TENKIKBN-HEN-SEC
           MOVE    WRK-PTBYO-TENKIKBNMEI   TO  HCM341-TENKI  (IDXA)
      *
           .
      *
       20011-PTBYOMEI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    病名編集処理
      *****************************************************************
       20011-PTBYOMEI-BYOMEI-HEN-SEC       SECTION.
      *
           MOVE       ZERO                 TO  FLG-UTAGAI
                                               FLG-KYUSEI
      *
           IF    ( WRK-PTBYO-UTAGAIFLG     =   "1" OR  "3" )
               COMPUTE CNT-BYOMEIMOJI  =   WRK-PTBYO-BYOMEIMOJI    *   2
               IF    ( CNT-BYOMEIMOJI  <=  8 )
                   MOVE    WRK-PTBYO-BYOMEI    TO  WRK-STR
               ELSE
                   MOVE    WRK-PTBYO-BYOMEI (CNT-BYOMEIMOJI - 7:)
                                           TO  WRK-STR
               END-IF
      *
               MOVE    ZERO                TO  CNT-STR
               INSPECT WRK-STR             TALLYING
                       CNT-STR FOR ALL "疑"
               IF    ( CNT-STR        <=   ZERO )
                   MOVE    1               TO  FLG-UTAGAI
               END-IF
           END-IF
      *
           IF    ( WRK-PTBYO-UTAGAIFLG     =   "2" OR  "3" )
               MOVE    ZERO                TO  CNT-STR
               INSPECT WRK-PTBYO-BYOMEI    TALLYING
                       CNT-STR FOR ALL "急性"
               IF    ( CNT-STR        <=   ZERO )
                   MOVE    1               TO  FLG-KYUSEI
               END-IF
           END-IF
      *
           IF    ( FLG-KYUSEI              =   1 )
               MOVE    SPACE               TO  WRK-STR
               STRING  "急性"              DELIMITED   BY  SIZE
                       WRK-PTBYO-BYOMEI    DELIMITED   BY  SPACE
               INTO    WRK-STR
               END-STRING
               MOVE    WRK-STR             TO  WRK-PTBYO-BYOMEI
           END-IF
      *
           IF    ( FLG-UTAGAI              =   1 )
               MOVE    SPACE               TO  WRK-STR
               STRING  WRK-PTBYO-BYOMEI    DELIMITED   BY  SPACE
                       "の疑い"            DELIMITED   BY  SIZE
               INTO    WRK-STR
               END-STRING
               MOVE    WRK-STR             TO  WRK-PTBYO-BYOMEI
           END-IF
      *
           .
       20011-PTBYOMEI-BYOMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科編集処理
      *****************************************************************
       200111-SRYKA-HEN-SEC     SECTION.
      *
           MOVE    SPACE                   TO  SRH-SRYKAMEI1
                                               SRH-SRYKAMEI2
                                               SRH-SRYKAMEI3
      *
           PERFORM VARYING SRH-IDX FROM    1   BY  1
                   UNTIL ( SRH-IDX >   SRH-SRYKA-MAX )
               IF    ( SRH-SRYKA   =   SRH-SRYKAL (SRH-IDX) )
                   MOVE    SRH-SRYKAMEI1L (SRH-IDX)
                                           TO  SRH-SRYKAMEI1
                   MOVE    SRH-SRYKAMEI2L (SRH-IDX)
                                           TO  SRH-SRYKAMEI2
                   MOVE    SRH-SRYKAMEI3L (SRH-IDX)
                                           TO  SRH-SRYKAMEI3
                   MOVE    SRH-SRYKA-MAX   TO  SRH-IDX
               END-IF
           END-PERFORM
      *
           .
       200111-SRYKA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    転帰事由編集処理
      *****************************************************************
       200111-PTBYO-TENKIKBN-HEN-SEC     SECTION.
      *
           MOVE    SPACE                   TO  WRK-PTBYO-TENKIKBNMEI
      *
           EVALUATE    WRK-PTBYO-TENKIKBN
           WHEN    "1"
               MOVE    "治ゆ"              TO  WRK-PTBYO-TENKIKBNMEI
           WHEN    "2"
               MOVE    "死亡"              TO  WRK-PTBYO-TENKIKBNMEI
           WHEN    "3"
               MOVE    "中止"              TO  WRK-PTBYO-TENKIKBNMEI
           WHEN    "8"
               MOVE    "移行"              TO  WRK-PTBYO-TENKIKBNMEI
           END-EVALUATE
      *
           .
       200111-PTBYO-TENKIKBN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為編集処理
      *****************************************************************
       2001-SRYACT-HEN-SEC             SECTION.
      *
      *    各欄からあふれた情報を診療行為欄に編集を行う
           PERFORM 20011-AFURE-HEN-SEC
      *
      *    診療会計マスターを編集
           MOVE    ZERO                TO  FLG-SRYACCT
           INITIALIZE                      SRYACCT-REC 
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    ORCHCM34-NYUGAIKBN  TO  ACCT-NYUGAIKBN
           MOVE    SPA-PTID            TO  ACCT-PTID
           MOVE    ORCHCM34-SRYYM      TO  ACCT-SRYYM
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "SRYACCT-KEY20"     TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1               TO  FLG-SRYACCT
           ELSE
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
           END-IF
      *
           MOVE    ZERO                TO  WKSRYACCT-MAX
           INITIALIZE                      WKSRYACCT-REC
           PERFORM UNTIL     ( FLG-SRYACCT =   1 )
      *
               PERFORM 20011-SRYACT-MATOME-SEC
      *
               MOVE    "SRYACCT-KEY20"     TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC        NOT =   ZERO )
                   MOVE    1               TO  FLG-SRYACCT
               ELSE
                   MOVE    MCPDATA-REC     TO  SRYACCT-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SRYACCT-KEY20"     TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    診療行為並び替え処理
           PERFORM 20011-SRYACT-SORT-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   WKSRYACCT-MAX )
      *
               PERFORM 20011-SRYACT-HEN-SEC
      *
           END-PERFORM
      *
           PERFORM 200111-JIHI-TOTAL-HEN-SEC
      *
           .
       2001-SRYACT-HEN-EXT.
           EXIT.
      *****************************************************************
      *    同一剤まとめ編集処理
      *****************************************************************
       20011-SRYACT-MATOME-SEC         SECTION.
      *
           SET     WKSRYACCT-IDX       TO  1
           SEARCH  WKSRYACCT-OCC   VARYING WKSRYACCT-IDX
           AT  END
               COMPUTE WKSRYACCT-MAX   =   WKSRYACCT-MAX   +   1
               MOVE    SRYACCT-REC     TO  WKSRYACCT-OCC (WKSRYACCT-MAX)
           WHEN    WKACCT-HOSPID (WKSRYACCT-IDX)
                                       =   SPACE
               COMPUTE WKSRYACCT-MAX   =   WKSRYACCT-MAX   +   1
               MOVE    SRYACCT-REC     TO  WKSRYACCT-OCC (WKSRYACCT-MAX)
           WHEN    ACCT-HOSPID         =   WKACCT-HOSPID
                                                       (WKSRYACCT-IDX)
            AND    ACCT-NYUGAIKBN      =   WKACCT-NYUGAIKBN
                                                       (WKSRYACCT-IDX)
            AND    ACCT-PTID           =   WKACCT-PTID
                                                       (WKSRYACCT-IDX)
            AND    ACCT-SRYYM          =   WKACCT-SRYYM
                                                       (WKSRYACCT-IDX)
            AND    ACCT-SRYKBN         =   WKACCT-SRYKBN
                                                       (WKSRYACCT-IDX)
            AND    ACCT-HKNCOMBI       =   WKACCT-HKNCOMBI
                                                       (WKSRYACCT-IDX)
            AND    ACCT-ZAITEN         =   WKACCT-ZAITEN 
                                                       (WKSRYACCT-IDX)
            AND    ACCT-SRYCDTOTAL     =   WKACCT-SRYCDTOTAL
                                                       (WKSRYACCT-IDX)
            AND    ACCT-SURYOUTOTAL    =   WKACCT-SURYOUTOTAL
                                                       (WKSRYACCT-IDX)
            AND    ACCT-MEISAISU       =   WKACCT-MEISAISU
                                                       (WKSRYACCT-IDX)
               COMPUTE WKACCT-ZAIKAISU  (WKSRYACCT-IDX)
                   =   WKACCT-ZAIKAISU  (WKSRYACCT-IDX)
                   +   ACCT-ZAIKAISU
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   31 )
                   COMPUTE WKACCT-DAY (WKSRYACCT-IDX 1 IDX1)
                        =  WKACCT-DAY (WKSRYACCT-IDX 1 IDX1)
                        +   ACCT-DAY (1 IDX1)
               END-PERFORM
           END-SEARCH
      *
           .
       20011-SRYACT-MATOME-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為並び替え処理
      *****************************************************************
       20011-SRYACT-SORT-SEC           SECTION.
      *
           INITIALIZE  SRT-SRYACCT
      *
      *    ソート用ワークにキー項目を退避する
           PERFORM VARYING SRT-IDX1    FROM    1   BY  1
                   UNTIL ( SRT-IDX1    >   WKSRYACCT-MAX )
      *
               MOVE    WKSRYACCT-OCC (SRT-IDX1)
                                       TO  SRYACCT-REC
      *
               MOVE    SRT-IDX1        TO  SRT-SRYACCT-IDX (SRT-IDX1)
               MOVE    ACCT-HKNCOMBI   TO  SRT-SRYACCT-HKNCOMBI
                                                           (SRT-IDX1)
               MOVE    ACCT-SRYKBN     TO  SRT-SRYACCT-SRYKBN
                                                           (SRT-IDX1)
               PERFORM 200111-SRYACT-SEL-SEC
               IF    ( FLG-SRYACT      =   ZERO )
                   PERFORM 200111-TENSU-SEL-SEC
                   IF    ( FLG-TENSU   =   ZERO )
                       IF    ( ACCT-SRYKBN =   "60" )
                           PERFORM 200111-KNSJISKBN-HEN-SEC
                       END-IF
      *
                       MOVE   TNS-HOUKNSKBN
                                       TO   SRT-SRYACCT-HOUKNSKBN
                                                          (SRT-IDX1)
      *
                       MOVE   TNS-CDKBN-SYO
                                       TO   SRT-SRYACCT-CDKBN-SYO
                                                          (SRT-IDX1)
                       MOVE   TNS-CDKBN-BU
                                       TO   SRT-SRYACCT-CDKBN-BU
                                                          (SRT-IDX1)
                       MOVE   TNS-CDKBN-KBN
                                       TO   SRT-SRYACCT-CDKBN-KBN
                                                          (SRT-IDX1)
                       MOVE   TNS-CDKBN-KBNNUM
                                       TO   SRT-SRYACCT-CDKBN-KBNNUM
                                                          (SRT-IDX1)
                       MOVE   TNS-CDKBN-KBNNUM-EDA
                                       TO  SRT-SRYACCT-CDKBN-KBNNUM-EDA
                                                          (SRT-IDX1)
                       MOVE   TNS-CDKBN-KOUBAN
                                       TO  SRT-SRYACCT-CDKBN-KOUBAN
                                                          (SRT-IDX1)
                       IF    (  ACCT-SRYKBN    =   "21" )
                        AND  (  TNS-SRYCD      =   CONST-TEIGEN )
                           MOVE   ALL "9"
                                       TO  SRT-SRYACCT-KOUHYOJYUNNUM
                                                          (SRT-IDX1)
                       ELSE
                           MOVE   TNS-KOUHYOJYUNNUM
                                       TO  SRT-SRYACCT-KOUHYOJYUNNUM
                                                          (SRT-IDX1)
                       END-IF
      *
                   END-IF
               END-IF
           END-PERFORM
      *
      *    ソート用ワークについて並び替えを行う
           PERFORM VARYING SRT-IDX1    FROM    2   BY  1
                   UNTIL ( SRT-IDX1    >   WKSRYACCT-MAX )
               COMPUTE SRT-STIDX   =   SRT-IDX1    -   1
               MOVE    SRT-SRYACCT-OCC (SRT-IDX1)
                                   TO  SRT-SRYACCT-OCC (1001)
               PERFORM VARYING SRT-IDX2    FROM    SRT-STIDX   BY  -1
                       UNTIL ( SRT-IDX2    <   1 )
                          OR ( SRT-SRYACCT-KEY (1001)
                                       >=  SRT-SRYACCT-KEY (SRT-IDX2) )
                       MOVE    SRT-SRYACCT-OCC (SRT-IDX2)
                                   TO  SRT-SRYACCT-OCC (SRT-IDX2 + 1)
               END-PERFORM
               MOVE    SRT-SRYACCT-OCC (1001)
                                   TO  SRT-SRYACCT-OCC (SRT-IDX2 + 1)
           END-PERFORM
      *
           .
       20011-SRYACT-SORT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスタ検索処理
      *****************************************************************
       200111-SRYACT-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-SRYACT
           INITIALIZE                      SRYACT-REC
           MOVE    ACCT-HOSPID         TO  SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN
           MOVE    ACCT-PTID           TO  SRY-PTID
           MOVE    ACCT-SRYKA          TO  SRY-SRYKA
           MOVE    ACCT-SRYYM          TO  SRY-SRYYM
           MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM
           MOVE    1                   TO  SRY-RENNUM
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "SRYACT-KEY"        TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC            NOT =   ZERO )
               MOVE    1               TO  FLG-SRYACT
           ELSE
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           END-IF
      *
           MOVE    "SRYACT-KEY"        TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       200111-SRYACT-SEL-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       200111-TENSU-SEL-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
           INITIALIZE                      TNS-TENSU-REC
           MOVE    SRY-SRYCD (1)       TO  TNS-SRYCD
           MOVE    ZERO                TO  TNS-YUKOSTYMD
           MOVE    ALL "9"             TO  TNS-YUKOEDYMD
           MOVE    ACCT-SRYYM          TO  WRK-SRYYMD(1:6)
      *    点数検索用日付編集
           MOVE    01                  TO  WRK-SRYDD
           PERFORM VARYING     IDX7    FROM    1   BY  1
                   UNTIL     ( IDX7    >   31 )
               IF    ( ACCT-DAY (1 IDX7)   NOT =   ZERO )
                   MOVE    IDX7        TO  WRK-SRYDD
                   MOVE    31          TO  IDX7
               END-IF
           END-PERFORM
           MOVE    WRK-SRYYMD          TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "TENSU-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC            NOT =   ZERO )
               MOVE    1               TO  FLG-TENSU
           ELSE
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
           END-IF
      *
           MOVE    "TENSU-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
           .
       200111-TENSU-SEL-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスタ検索処理
      *****************************************************************
       200111-KNSJISKBN-HEN-SEC        SECTION.
      *
           EVALUATE    TRUE
           WHEN  ( TNS-KNSJISKBN       =   2 )
               MOVE    "5"     TO  SRT-SRYACCT-KNSJISKBN (SRT-IDX1)
           WHEN  ( TNS-CDKBN-KBN       =   "9" )
               MOVE    "4"     TO  SRT-SRYACCT-KNSJISKBN (SRT-IDX1)
           WHEN    OTHER
               EVALUATE    TNS-CDKBN-KBNNUM
               WHEN  ZERO    THRU    199
                   MOVE    "1"     TO  SRT-SRYACCT-KNSJISKBN (SRT-IDX1)
               WHEN  400     THRU    499
                   MOVE    "2"     TO  SRT-SRYACCT-KNSJISKBN (SRT-IDX1)
               WHEN  200     THRU    399
                   MOVE     "3"    TO  SRT-SRYACCT-KNSJISKBN (SRT-IDX1)
               END-EVALUATE
           END-EVALUATE
      *
           .
       200111-KNSJISKBN-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為編集処理
      *****************************************************************
       20011-SRYACT-HEN-SEC            SECTION.
      *
           MOVE    SRT-SRYACCT-HOUKNSKBN (IDX1)
                                       TO  WRK-TNS-HOUKNSKBN
           MOVE    SRT-SRYACCT-IDX (IDX1)
                                       TO  IDX11
           MOVE    WKSRYACCT-OCC(IDX11)
                                       TO  SRYACCT-REC
      *
           IF    ( ACCT-ZAITEN     NOT =   ZERO )
            AND  ( ACCT-ZAIKAISU   NOT =   ZERO )
               CONTINUE
           ELSE
               GO  TO  20011-SRYACT-HEN-EXT
           END-IF
      *
           MOVE    ZERO                TO  CNT-HOUSRYACT
           MOVE    ZERO                TO  FLG-MINUS
      *
      *    診療行為マスター読み込み
           MOVE    ZERO                TO  FLG-SRYACT
           INITIALIZE                      SRYACT-REC
           MOVE    ACCT-HOSPID         TO  SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN
           MOVE    ACCT-PTID           TO  SRY-PTID
           MOVE    ACCT-SRYKA          TO  SRY-SRYKA
           MOVE    ACCT-SRYYM          TO  SRY-SRYYM
           MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM
      *    点数検索用日付編集
           MOVE    ACCT-SRYYM          TO  WRK-SRYYMD(1:6)
           MOVE    01                  TO  WRK-SRYDD
           PERFORM VARYING     IDX7    FROM    1   BY  1
                   UNTIL     ( IDX7    >   31 )
               IF    ( ACCT-DAY (1 IDX7)   NOT =   ZERO )
                   MOVE    IDX7        TO  WRK-SRYDD
                   MOVE    31          TO  IDX7
               END-IF
           END-PERFORM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "SRYACT-KEY2"       TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               MOVE    1               TO  FLG-SRYACT
           ELSE
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           END-IF
      *
           IF    ( FLG-SRYACT          NOT =   ZERO )
             OR  ( SRY-SRYSYUKBN       =   "213" OR "223" OR "233" )
               GO  TO  20011-SRYACT-HEN-EXT
           END-IF
      *
           IF    ( IDX1    >     1 )
               PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
               MOVE    SRT-SRYACCT-IDX (IDX1 - 1)
                                           TO  IDX12
               IF    ( WKACCT-HKNCOMBI (IDX11)
                                   NOT =  WKACCT-HKNCOMBI (IDX12))
                   PERFORM 200111-JIHI-TOTAL-HEN-SEC
                   MOVE    1               TO  FLG-LINE
               ELSE
                   MOVE    ZERO            TO  FLG-LINE
               END-IF
               MOVE    "5"                 TO  WRK-ITEM-KBN
               PERFORM 210-SRYACT-HEN-SEC
           END-IF
      *
           PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
      *
           PERFORM UNTIL ( FLG-SRYACT  NOT =   ZERO )
                    OR   ( WRK-SRYACT-MAX  >   500 )
      *
      *        剤内１行目
               IF   (  SRY-RENNUM      =   1 )
                   PERFORM 200111-GYO1-HEN-SEC
               END-IF
      *
      *        剤明細編集
               PERFORM VARYING IDX9    FROM    1   BY  1
                       UNTIL ( IDX9                >  5    )
                        OR   ( WRK-SRYACT-MAX      >   500 )
                        OR   ( SRY-SRYCD (IDX9)    =   SPACE )
      *
                   IF    ( SRY-SRYCD (IDX9)    =   CONST-TEIGEN )
                       MOVE    1           TO  FLG-MINUS
                   END-IF
      *
      *            自費の時、金額を表示
                   IF    ( SRY-SRYKBN  =   "95"  OR  "96" )
                       PERFORM 200111-JIHIMEI-HEN-SEC
                       CONTINUE
                   ELSE
                       PERFORM 200111-ZAIMEI-HEN-SEC
                   END-IF
               END-PERFORM
      *
               MOVE    "SRYACT-KEY2"       TO  WRK-DBPATH
               PERFORM 900-TBL-READ-SEC
               IF    ( FLG-DBRC        NOT =   ZERO )
                   MOVE    1               TO  FLG-SRYACT
               ELSE
                   MOVE    MCPDATA-REC     TO  SRYACT-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SRYACT-KEY2"           TO  WRK-DBPATH
           PERFORM 900-TBL-CLOSE-SEC
      *
      *    自費の時、計を表示しない
           IF    ( ACCT-SRYKBN     =   "95"  OR  "96" )
               CONTINUE
           ELSE
               IF    ( WRK-TNS-HOUKNSKBN   NOT =   ZERO )
                   PERFORM 210-WRK-SRYACT-TBL-HEN5-SEC
                   IF    ( CNT-HOUSRYACT   >   1   )
      *                検査数編集処理
                       PERFORM 200111-KENSASU-HEN-SEC
                   END-IF
               END-IF
      *        点数回数編集処理
               PERFORM 200111-TENSUKAISU-HEN-SEC
           END-IF
      *
           MOVE    "5"                     TO  WRK-ITEM-KBN
           MOVE    ZERO                    TO  FLG-LINE
           PERFORM 210-SRYACT-HEN-SEC
      *
           .
       20011-SRYACT-HEN-EXT.
           EXIT.
      *****************************************************************
      *   剤内１行目  編集処理
      *****************************************************************
       200111-GYO1-HEN-SEC             SECTION.
      *
      *    診療区分
           MOVE    SRY-SRYKBN          TO  WRK-SRYACT-SRYKBN
      *    保険組合せ
           MOVE    ACCT-HKNCOMBI       TO  WRK-SRYACT-HKNCOMBI
      *    回数
           PERFORM VARYING IDX8    FROM    1   BY  1
                   UNTIL ( IDX8    >   31 )
               MOVE    ACCT-DAY  (1 IDX8)
                                       TO  WRK-SRYACT-DAY-Z (IDX8)
           END-PERFORM
      *
           .
       200111-GYO1-HEN-EXT.
           EXIT.
      *****************************************************************
      *   剤内明細  編集処理
      *****************************************************************
       200111-ZAIMEI-HEN-SEC           SECTION.
      *
           MOVE    SPACE                   TO  WRK-SRYACT-STR
      *
      *    約束セットのコードは読み飛ばす
           IF    ( SRY-SRYCD (IDX9)(1:1)   =   "S" )
               GO  TO  200111-ZAIMEI-HEN-EXT
           END-IF
      *
      *    診療コードより診療行為名称を取得
           INITIALIZE  TNS-TENSU-REC
           MOVE    SRY-SRYCD (IDX9)        TO  TNS-SRYCD
           MOVE    ZERO                    TO  TNS-YUKOSTYMD
           MOVE    ALL "9"                 TO  TNS-YUKOEDYMD
           MOVE    WRK-SRYYMD              TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC           TO  MCPDATA-REC
           MOVE    "TENSU-KEY"             TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               INITIALIZE                  TNS-TENSU-REC
               MOVE    SRY-SRYCD (IDX9)    TO  WRK-MAE-INPUT
               PERFORM 800-ZENKAKU-HEN-SEC
               MOVE    WRK-OUT-INPUT       TO  TNS-NAME
           ELSE
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
           END-IF
      *
      *    行為名称
           MOVE    TNS-NAME                TO  WRK-SRYACT-STR
      *
      *    薬剤服用コメントの時、再編集
           IF    ( SRY-SRYCD (IDX9)(1:3)   =   "001" )
      *
               STRING "【"                 DELIMITED   BY  SIZE
                      TNS-NAME             DELIMITED   BY  SPACE
                      "】"                 DELIMITED   BY  SIZE
               INTO   WRK-SRYACT-STR
               END-STRING
           END-IF
      *
      *    コメントの時、内容設定
           IF    ( SRY-SRYCD  (IDX9)(1:1)  =   "8"  )
            AND  ( SRY-INPUTNUM(IDX9)  NOT =   ZERO )
               PERFORM 2001111-PTCOM-SET-SEC
           END-IF
      *
      *    数量（薬剤、器材のとき）
           IF    ( SRY-SRYCD  (IDX9)(1:1)  =   "6"  OR  "7" )
            AND  ( TNS-TANINAME        NOT =   SPACE )
               PERFORM 2001111-SURYO-HEN-SEC
           END-IF
      *
      *    分画数
      *    IF    ( SRY-SRYCD  (IDX9)(1:1)  =   "7"  )
      *     AND  ( TNS-DATAKBN             =   3    )
      *     AND  ( SRY-SRYKAISU (IDX9)     >   ZERO )
      *        PERFORM 2001111-BUNGASU-HEN-SEC
      *    END-IF
      *
           IF    ( WRK-TNS-HOUKNSKBN       =   ZERO )
               PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
           ELSE
               MOVE    SPACE               TO  WRK-STR
               STRING  WRK-SRYACT-STR      DELIMITED   BY  SPACE
                       "，"                DELIMITED   BY  SIZE
               INTO    WRK-STR
               END-STRING
               MOVE    WRK-STR             TO  WRK-SRYACT-STR
               PERFORM 210-WRK-SRYACT-TBL-HEN4-SEC
               COMPUTE CNT-HOUSRYACT   =   CNT-HOUSRYACT   +   1
           END-IF
      *
           .
       200111-ZAIMEI-HEN-EXT.
           EXIT.
      *****************************************************************
      *   剤内明細  編集処理
      *****************************************************************
       200111-JIHIMEI-HEN-SEC              SECTION.
      *
           MOVE    SPACE                   TO  WRK-SRYACT-STR
      *
      *    約束セットのコードは読み飛ばす
           IF    ( SRY-SRYCD (IDX9)(1:1)   =   "S" )
               GO  TO  200111-JIHIMEI-HEN-EXT
           END-IF
      *
      *    診療コードより診療行為名称を取得
           INITIALIZE  TNS-TENSU-REC
           MOVE    SRY-SRYCD (IDX9)        TO  TNS-SRYCD
           MOVE    ZERO                    TO  TNS-YUKOSTYMD
           MOVE    ALL "9"                 TO  TNS-YUKOEDYMD
           MOVE    WRK-SRYYMD              TO  ORC-DBYMD
           MOVE    TNS-TENSU-REC           TO  MCPDATA-REC
           MOVE    "TENSU-KEY"             TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               INITIALIZE                  TNS-TENSU-REC
               MOVE    SRY-SRYCD (IDX9)    TO  WRK-MAE-INPUT
               PERFORM 800-ZENKAKU-HEN-SEC
               MOVE    WRK-OUT-INPUT       TO  TNS-NAME
           ELSE
               MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
           END-IF
      *
      *    行為名称
           MOVE    TNS-NAME                TO  WRK-SRYACT-STR
      *
      *    コメントの時、内容設定
           IF    ( SRY-SRYCD  (IDX9)(1:1)  =   "8"  )
            AND  ( SRY-INPUTNUM(IDX9)  NOT =   ZERO )
               PERFORM 2001111-PTCOM-SET-SEC
           END-IF
      *
           PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
      *
      *    計
           MOVE    1               TO  WRK-PNT
           MOVE    SPACE           TO  WRK-TENSUKAISU
           MOVE    SRY-JIHIMONEY (IDX9)
                                   TO  WRK-STR-LEFT-ZX99
      *
           PERFORM 800-STR-HIDARIZUME-HEN-SEC
           STRING  WRK-STR-LEFT        DELIMITED   BY  SPACE
                   "円"                DELIMITED   BY  SIZE
           INTO    WRK-TENSUKAISU
           WITH    POINTER WRK-PNT
           END-STRING
      *
           MOVE    ACCT-ZAIKAISU   TO  WRK-ZZ9
           STRING  "×"                DELIMITED   BY  SIZE
                   WRK-ZZ9             DELIMITED   BY  SIZE
           INTO    WRK-TENSUKAISU
           WITH    POINTER WRK-PNT
           END-STRING
      *
           MOVE    WRK-TENSUKAISU  TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT   TO  WRK-SRYACT-STR
           PERFORM 210-WRK-SRYACT-TBL-HEN3-SEC
      *
           COMPUTE WRK-TTL-JIHI    =   WRK-TTL-JIHI
                                   + ( SRY-JIHIMONEY (IDX9)
                                   *   ACCT-ZAIKAISU )
      *
           IF    ( ACCT-SRYKBN         =   "96" )
               COMPUTE WRK-TTL-JIHI-TAX    =   WRK-TTL-JIHI-TAX
                                           + ( SRY-JIHIMONEY (IDX9)
                                           * ACCT-ZAIKAISU )
           END-IF
      *
           .
       200111-JIHIMEI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    自費計編集処理
      *****************************************************************
       200111-JIHI-TOTAL-HEN-SEC       SECTION.
      *
           IF    ( WRK-TTL-JIHI    >   ZERO )
      *
      *        空行を１行編集
               PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
      *
               MOVE    "　"                TO   WRK-SRYACT-STR
               PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
      *
               MOVE    "5"                 TO  WRK-ITEM-KBN
               MOVE    ZERO                TO  FLG-LINE
               PERFORM 210-SRYACT-HEN-SEC
      *
               MOVE    "　　　　　自費合計額"
                                           TO  WRK-KINGAKKU-LBL
               MOVE    WRK-TTL-JIHI        TO  WRK-KINGAKKU
               PERFORM 2001111-KINGAKU-HEN-SEC
      *
      *        消費税分がある場合は消費税額を編集
               IF    ( WRK-TTL-JIHI-TAX    >   ZERO )
                   MOVE    "　　　　　自費消費税額"
                                           TO  WRK-KINGAKKU-LBL
                   IF   ( SYS-1001-TAX-HASU-KBN =   "1" )
                       COMPUTE  WRK-KINGAKKU
                            = ( WRK-TTL-JIHI-TAX   *  0.05 )
                            +  0.5
                   ELSE
                       COMPUTE  WRK-KINGAKKU
                            = ( WRK-TTL-JIHI-TAX   *  0.05 )
                   END-IF
                   PERFORM 2001111-KINGAKU-HEN-SEC
               END-IF
           END-IF
      *
           MOVE    ZERO                TO  WRK-TTL-JIHI
           MOVE    ZERO                TO  WRK-TTL-JIHI-TAX
      *
           PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
      *
           .
      *
       200111-JIHI-TOTAL-HEN-EXT.
           EXIT.
      *****************************************************************
      *    金額編集処理
      *****************************************************************
       2001111-KINGAKU-HEN-SEC         SECTION.
      *
           PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
      *
           MOVE    WRK-KINGAKKU-LBL    TO   WRK-SRYACT-STR
           PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
      *
           MOVE    1               TO  WRK-PNT
           MOVE    SPACE           TO  WRK-TENSUKAISU
           MOVE    WRK-KINGAKKU    TO  WRK-STR-LEFT-ZX99
      *
           PERFORM 800-STR-HIDARIZUME-HEN-SEC
           STRING  WRK-STR-LEFT        DELIMITED   BY  SPACE
                   "円"                DELIMITED   BY  SIZE
           INTO    WRK-TENSUKAISU
           WITH    POINTER WRK-PNT
           END-STRING
      *
           MOVE    WRK-TENSUKAISU  TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT   TO  WRK-SRYACT-STR
           PERFORM 210-WRK-SRYACT-TBL-HEN3-SEC
      *
           MOVE    "5"                     TO  WRK-ITEM-KBN
           MOVE    ZERO                    TO  FLG-LINE
           PERFORM 210-SRYACT-HEN-SEC
           .
      *
       2001111-KINGAKU-HEN-EXT.
           EXIT.
      *****************************************************************
      *   検査数  編集処理
      *****************************************************************
       200111-KENSASU-HEN-SEC          SECTION.
      *
           IF    ( WRK-TNS-HOUKNSKBN   >=  1 )
            AND  ( WRK-TNS-HOUKNSKBN   <=  8 )
               MOVE    CNT-HOUSRYACT   TO  WRK-STR-LEFT-ZX99
               PERFORM 800-STR-HIDARIZUME-HEN-SEC
               MOVE    WRK-STR-LEFT    TO  WRK-MAE-INPUT
               PERFORM 800-ZENKAKU-HEN-SEC
               MOVE    SPACE           TO  WRK-SRYACT-STR
               STRING  CONST-KENSACOMMENT (WRK-TNS-HOUKNSKBN)
                                       DELIMITED  BY  SPACE
                       "（"            DELIMITED  BY  SIZE
                       WRK-OUT-INPUT   DELIMITED  BY  SPACE
                       "項目）"        DELIMITED  BY  SIZE
               INTO    WRK-SRYACT-STR
               END-STRING
               PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
           END-IF
      *
           .
       200111-KENSASU-HEN-EXT.
           EXIT.
      *****************************************************************
      *   点数回数  編集処理
      *****************************************************************
       200111-TENSUKAISU-HEN-SEC           SECTION.
      *
           IF    ( ACCT-ZAITEN     NOT =   ZERO )
            AND  ( ACCT-ZAIKAISU   NOT =   ZERO )
               CONTINUE
           ELSE
               GO  TO  200111-TENSUKAISU-HEN-EXT
           END-IF
      *
           MOVE    1               TO  WRK-PNT
           MOVE    SPACE           TO  WRK-TENSUKAISU
           MOVE    ACCT-ZAITEN     TO  WRK-STR-LEFT-ZX99
      *
           IF    ( FLG-MINUS       NOT =   ZERO )
               STRING  "▲"            DELIMITED   BY  SIZE
               INTO    WRK-TENSUKAISU
               WITH    POINTER WRK-PNT
               END-STRING
           END-IF
      *
           PERFORM 800-STR-HIDARIZUME-HEN-SEC
           STRING  WRK-STR-LEFT        DELIMITED   BY  SPACE
           INTO    WRK-TENSUKAISU
           WITH    POINTER WRK-PNT
           END-STRING
      *
           MOVE    ACCT-ZAIKAISU   TO  WRK-ZZ9
           STRING  "×"                DELIMITED   BY  SIZE
                   WRK-ZZ9             DELIMITED   BY  SIZE
           INTO    WRK-TENSUKAISU
           WITH    POINTER WRK-PNT
           END-STRING
      *
           MOVE    WRK-TENSUKAISU  TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT   TO  WRK-SRYACT-STR
           PERFORM 210-WRK-SRYACT-TBL-HEN3-SEC
      *
           .
       200111-TENSUKAISU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者コメントから編集する 
      *****************************************************************
       2001111-PTCOM-SET-SEC               SECTION.
      *
           INITIALIZE                      PTCOM-REC
           MOVE    SRY-HOSPID          TO  PTCOM-HOSPID
           MOVE    SRY-PTID            TO  PTCOM-PTID
           MOVE    SRY-ZAINUM          TO  PTCOM-ZAINUM
           MOVE    SRY-SRYCD   (IDX9)  TO  PTCOM-SRYCD
           MOVE    SRY-INPUTNUM(IDX9)  TO  PTCOM-RENNUM
           MOVE    PTCOM-REC           TO  MCPDATA-REC
           MOVE    "PTCOM-KEY"         TO  WRK-DBPATH
           PERFORM 900-TBL-SELECT-SEC
           IF    ( FLG-DBRC        NOT =   ZERO )
               CONTINUE
           ELSE
               MOVE    MCPDATA-REC     TO  PTCOM-REC
               IF    ( PTCOM-INPUTCOMENT   NOT =   SPACE )
                   MOVE    PTCOM-INPUTCOMENT
                                       TO  WRK-SRYACT-STR
               END-IF
           END-IF
      *
           .
       2001111-PTCOM-SET-EXT.
           EXIT.
      *****************************************************************
      *    数量表示用編集処理
      *****************************************************************
       2001111-SURYO-HEN-SEC           SECTION.
      *
           MOVE    SRY-SRYSURYO (IDX9) TO  WRK-SURYO
      *
           MOVE    SPACE               TO  WRK-SURYO-X
           MOVE    WRK-SURYO-S1        TO  WRK-SURYO-Z1
      *
           MOVE    ZERO                TO  FLG-SP
           MOVE    ZERO                TO  WRK-SURYO-Z3
           PERFORM VARYING   IDX10     FROM    3  BY  -1
                   UNTIL   ( IDX10     <   1 )
      *
               IF    ( WRK-SURYO-S2(IDX10:1)   NOT =   ZERO )
                   MOVE    1           TO  FLG-SP
               END-IF
      *
               IF    ( FLG-SP          =   1 )
                   MOVE    WRK-SURYO-S2(IDX10:1)
                                       TO  WRK-SURYO-Z3(IDX10:1)
               END-IF
           END-PERFORM
      *
           IF    ( WRK-SURYO-Z3-X      NOT =   SPACE )
               MOVE    WRK-SURYO-S1    TO  WRK-SURYO-Z19
               MOVE    "."             TO  WRK-SURYO-Z2
           END-IF
      *
           IF    ( WRK-SURYO-X NOT =   SPACE )
               IF    ( WRK-SURYO-X (1:1)   =   SPACE )
                   MOVE    SPACE       TO  WRK-STR
                   MOVE    1           TO  WRK-PNT
                   UNSTRING    WRK-SURYO-X
                   DELIMITED   BY  ALL SPACE
                   INTO        WRK-STR
                   WITH        POINTER WRK-PNT
                   END-UNSTRING
               ELSE
                   MOVE    1           TO  WRK-PNT
               END-IF
               MOVE    WRK-SURYO-X (WRK-PNT : )
                                       TO  WRK-MAE-INPUT
               PERFORM 800-ZENKAKU-HEN-SEC
               MOVE    SPACE           TO  WRK-STR
               STRING  WRK-SRYACT-STR      DELIMITED   BY  SPACE
                   "　"                    DELIMITED   BY  SIZE
                   WRK-OUT-INPUT           DELIMITED   BY  SPACE
                   TNS-TANINAME            DELIMITED   BY  SPACE
               INTO    WRK-STR
               END-STRING
               MOVE    WRK-STR         TO  WRK-SRYACT-STR
           END-IF
           .
       2001111-SURYO-HEN-EXT.
           EXIT.
      *****************************************************************
      *    分画数編集処理
      *****************************************************************
       2001111-BUNGASU-HEN-SEC           SECTION.
      *
           MOVE    SPACE               TO  WRK-BUNGSU
           MOVE    1                   TO  WRK-PNT
           MOVE    SRY-SRYSURYO (IDX9) TO  WRK-STR-LEFT-ZX99
           PERFORM 800-STR-HIDARIZUME-HEN-SEC
           STRING  WRK-STR-LEFT        DELIMITED   BY  SPACE
           INTO    WRK-BUNGSU
           WITH    POINTER WRK-PNT
           END-STRING
           MOVE    SRY-SRYKAISU (IDX9) TO  WRK-STR-LEFT-ZX99
           PERFORM 800-STR-HIDARIZUME-HEN-SEC
           STRING  "/"                 DELIMITED   BY  SIZE
                   WRK-STR-LEFT        DELIMITED   BY  SPACE
           INTO    WRK-BUNGSU
           WITH    POINTER WRK-PNT
           END-STRING
           MOVE    WRK-BUNGSU          TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           STRING  WRK-SRYACT-STR      DELIMITED   BY  SPACE
               "　"                    DELIMITED   BY  SIZE
               WRK-OUT-INPUT           DELIMITED   BY  SPACE
           INTO    WRK-STR
           END-STRING
           MOVE    WRK-STR         TO  WRK-SRYACT-STR
      *
           .
       2001111-BUNGASU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    あふれ情報編集処理
      *****************************************************************
       20011-AFURE-HEN-SEC             SECTION.
      *
      *    保険組合せ欄からあふれた分について診療行為欄に編集を行う
           MOVE    ZERO                    TO  FLG-OVER
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   WKHKNCOMBI-MAX )
               PERFORM 200111-HKNCOMBI-RANGAI-HEN-SEC
           END-PERFORM
      *
      *    保険公費欄からあふれた分について診療行為欄に編集を行う
      *    （保険）
           MOVE    ZERO                    TO  FLG-OVER
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   WKPTHKNINF-MAX )
               PERFORM 200111-PTHKN-RANGAI-HEN-SEC
           END-PERFORM
      *
      *    保険公費欄からあふれた分について診療行為欄に編集を行う
      *    （公費）
           MOVE    ZERO                    TO  FLG-OVER
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   WKPTKOHINF-MAX )
               PERFORM 200111-PTKOH-RANGAI-HEN-SEC
           END-PERFORM
      *
      *    傷病名欄からあふれた分について診療行為欄に編集を行う
           MOVE    ZERO                    TO  FLG-OVER
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   WKPTBYOMEI-MAX )
               PERFORM 200111-PTBYOMEI-RANGAI-HEN-SEC
           END-PERFORM
      *
           .
       20011-AFURE-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ欄外編集処理（診療行為欄に編集）
      *****************************************************************
       200111-HKNCOMBI-RANGAI-HEN-SEC   SECTION.
      *
           IF    ( FLG-OVER        =   ZERO )
      *
               PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
               MOVE    "以下保険組合せあふれ分"
                                           TO  WRK-SRYACT-STR
               PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
      *
               MOVE    1                   TO  FLG-OVER
               MOVE    SPACE               TO  WRK-ITEM-KBN
               PERFORM 210-SRYACT-HEN-SEC
           END-IF
      *
      *    保険組合せ番号全角変換
           MOVE    WKHKNCOMBI-HKNCOMBINUM (IDX1)
                                           TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT           TO  WRK-HKNCOMBINUM-N
      *
      *    適用開始日和暦変換／全角変換
           MOVE    WKHKNCOMBI-TEKSTYMDW(IDX1)
                                           TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT           TO  WRK-TEKSTYMD-N
      *
           MOVE    WKHKNCOMBI-TEKEDYMDW(IDX1)
                                           TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT           TO  WRK-TEKEDYMD-N
      *
           MOVE    WKHKNCOMBI-HKNCOMBIMEI (IDX1)
                                           TO  WRK-STR
           PERFORM 800-STRLEN-CHK-SEC
           IF    ( WRK-STRLEN      <   1 )
               MOVE    1                   TO  WRK-STRLEN
           END-IF
      *
           PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
      *
           MOVE        SPACE               TO  WRK-SRYACT-STR
           STRING  WRK-HKNCOMBINUM-N   DELIMITED   BY  SIZE
           "　"                DELIMITED   BY  SIZE
           WKHKNCOMBI-HKNCOMBIMEI (IDX1) (1 : WRK-STRLEN )
                                       DELIMITED   BY  SIZE
           INTO    WRK-SRYACT-STR
           END-STRING
           PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
      *
           MOVE        SPACE               TO  WRK-SRYACT-STR
           STRING  WRK-TEKSTYMD-N      DELIMITED   BY  SIZE
                   "〜"                DELIMITED   BY  SIZE
                   WRK-TEKEDYMD-N      DELIMITED   BY  SIZE
           INTO    WRK-SRYACT-STR
           END-STRING
           PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
      *
           MOVE    "1"                     TO  WRK-ITEM-KBN
           MOVE    IDX1                    TO  IDXD
           PERFORM 210-SRYACT-HEN-SEC
      *
           .
       200111-HKNCOMBI-RANGAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    保険欄外編集処理（診療行為欄に編集）
      *****************************************************************
       200111-PTHKN-RANGAI-HEN-SEC     SECTION.
      *
           MOVE    WKPTHKNINF-OCC (IDX1)   TO  PTHKNINF-REC
      *
           IF    ( FLG-OVER        =   ZERO )
               PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
               MOVE    "以下保険あふれ分"
                                           TO  WRK-SRYACT-STR
               PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
      *
               MOVE    1                   TO  FLG-OVER
               MOVE    SPACE               TO  WRK-ITEM-KBN
               PERFORM 210-SRYACT-HEN-SEC
           END-IF
      *
           PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
      *
           MOVE    PTHKN-HKNNUM            TO  SRH-HKNNUM
           PERFORM 200111-PTHKN-HKNNUM-HEN-SEC
           MOVE    SRH-HKNNUMMEI (1:10)    TO  WRK-SRYACT-STR
           PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
      *
           MOVE    PTHKN-HKNJANUM          TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT (1:16)    TO  WRK-SRYACT-STR
           PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
      *
           MOVE    PTHKN-HONKZKKBN         TO  WRK-PTHKN-HONKZKKBN
           PERFORM 200111-PTHKN-HONKZKKBN-HEN-SEC
           MOVE    WRK-PTHKN-HONKZKKBNMEI (1:4)
                                           TO  WRK-SRYACT-STR
           PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
      *
           MOVE    PTHKN-CONTKBN           TO  WRK-PTHKN-CONTKBN
           PERFORM 200111-PTHKN-CONTKBN-HEN-SEC
           MOVE    WRK-PTHKN-CONTKBNMEI   (1:4)
                                           TO  WRK-SRYACT-STR
           IF    ( WRK-SRYACT-STR  NOT =   SPACE )
               PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
           END-IF
      *
           IF    ( PTHKN-KIGO      NOT =   SPACE )
               MOVE    SPACE               TO  WRK-SRYACT-STR
               STRING    "記："                DELIMITED   BY  SIZE
                         PTHKN-KIGO            DELIMITED   BY  SPACE
               INTO      WRK-SRYACT-STR
               END-STRING
               PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
           END-IF
      *
           IF    ( PTHKN-NUM       NOT =   SPACE )
               MOVE    SPACE               TO  WRK-SRYACT-STR
               STRING    "番："                DELIMITED   BY  SIZE
                         PTHKN-NUM             DELIMITED   BY  SPACE
               INTO      WRK-SRYACT-STR
               END-STRING
               PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
           END-IF
      *
           MOVE    "2"                     TO  WRK-ITEM-KBN
           MOVE    IDX1                    TO  IDXD
           PERFORM 210-SRYACT-HEN-SEC
      *
           .
       200111-PTHKN-RANGAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    公費欄外編集処理（診療行為欄に編集）
      *****************************************************************
       200111-PTKOH-RANGAI-HEN-SEC     SECTION.
      *
           MOVE    WKPTKOHINF-OCC (IDX1)   TO  PTKOHINF-REC
      *
           IF    ( FLG-OVER        =   ZERO )
               PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
               MOVE    "以下公費あふれ分"
                                           TO  WRK-SRYACT-STR
               PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
      *
               MOVE    1                   TO  FLG-OVER
               MOVE    SPACE               TO  WRK-ITEM-KBN
               PERFORM 210-SRYACT-HEN-SEC
           END-IF
      *
           PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
      *
           MOVE    PTKOH-KOHNUM            TO  SRH-KOHNUM
           MOVE    PTKOH-PAYKBN            TO  SRH-PAYKBN
           PERFORM 200111-PTKOH-KOHNUM-HEN-SEC
           MOVE    SRH-KOHNUMMEI (1:10)
                                           TO  WRK-SRYACT-STR
           PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
      *
           MOVE    PTKOH-FTNJANUM          TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT           TO  WRK-PTKOH-FTNJANUM-N
      *
           MOVE    PTKOH-JKYSNUM           TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           MOVE    WRK-OUT-INPUT           TO  WRK-PTKOH-JKYSNUM-N
      *
           IF    ( WRK-PTKOH-FTNJANUM-N    NOT =   SPACE )
               MOVE    SPACE               TO  WRK-SRYACT-STR
               STRING    "負："                DELIMITED   BY  SIZE
                         WRK-PTKOH-FTNJANUM-N  DELIMITED   BY  SPACE
               INTO      WRK-SRYACT-STR
               END-STRING
               PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
           END-IF
      *
           IF    ( WRK-PTKOH-JKYSNUM-N     NOT =   SPACE )
               MOVE    SPACE               TO  WRK-SRYACT-STR
               STRING    "受："                DELIMITED   BY  SIZE
                         WRK-PTKOH-JKYSNUM-N   DELIMITED   BY  SPACE
               INTO      WRK-SRYACT-STR
               END-STRING
               PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
           END-IF
      *
           MOVE    "3"                     TO  WRK-ITEM-KBN
           MOVE    IDX1                    TO  IDXD
           PERFORM 210-SRYACT-HEN-SEC
      *
           .
       200111-PTKOH-RANGAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    傷病名欄外編集処理（診療行為欄に編集）
      *****************************************************************
       200111-PTBYOMEI-RANGAI-HEN-SEC  SECTION.
      *
           MOVE    WKPTBYOMEI-OCC (IDX1)   TO  PTBYOMEI-REC
      *
           IF    ( FLG-OVER        =   ZERO )
               PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
               MOVE    "以下傷病名あふれ分"
                                           TO  WRK-SRYACT-STR
               PERFORM 210-WRK-SRYACT-TBL-HEN-SEC
      *
               MOVE    1                   TO  FLG-OVER
               MOVE    SPACE               TO  WRK-ITEM-KBN
               PERFORM 210-SRYACT-HEN-SEC
           END-IF
      *
           PERFORM 210-WRK-SRYACT-TBL-SYOKI-SEC
      *
           MOVE    PTBYO-BYOMEI            TO  WRK-PTBYO-BYOMEI
           MOVE    PTBYO-BYOMEIMOJI        TO  WRK-PTBYO-BYOMEIMOJI
           MOVE    PTBYO-UTAGAIFLG         TO  WRK-PTBYO-UTAGAIFLG
           PERFORM 20011-PTBYOMEI-BYOMEI-HEN-SEC
           MOVE    WRK-PTBYO-BYOMEI        TO  WRK-SRYACT-STR
           PERFORM 210-WRK-SRYACT-TBL-HEN2-SEC
      *
           MOVE    SPACE                   TO  WRK-SRYACT-STR
           MOVE    1                       TO  WRK-PNT
      *
           MOVE    PTBYO-SRYKA             TO  SRH-SRYKA
           PERFORM 200111-SRYKA-HEN-SEC
           IF    ( SRH-SRYKAMEI2      NOT  =   SPACE )
               STRING  SRH-SRYKAMEI2(1:4)  DELIMITED   BY  SIZE
                       "　"                DELIMITED   BY  SIZE
               INTO    WRK-SRYACT-STR
               WITH    POINTER WRK-PNT
               END-STRING
           ELSE
               STRING  "　　　"            DELIMITED   BY  SIZE
               INTO    WRK-SRYACT-STR
               WITH    POINTER WRK-PNT
               END-STRING
           END-IF
      *
           IF    ( PTBYO-SYUBYOFLG         =   "1" )
               STRING  "主"                DELIMITED   BY  SIZE
                       "　"                DELIMITED   BY  SIZE
               INTO    WRK-SRYACT-STR
               WITH    POINTER WRK-PNT
               END-STRING
           ELSE
               STRING  "　　"              DELIMITED   BY  SIZE
               INTO    WRK-SRYACT-STR
               WITH    POINTER WRK-PNT
               END-STRING
           END-IF
      *
           MOVE    PTBYO-SRYYMD            TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD1             TO  WRK-MAE-INPUT
           PERFORM 800-ZENKAKU-HEN-SEC
           IF    ( WRK-OUT-INPUT       NOT =   SPACE )
               STRING  WRK-OUT-INPUT (1:18)
                                           DELIMITED   BY  SIZE
                       "　"                DELIMITED   BY  SIZE
               INTO    WRK-SRYACT-STR
               WITH    POINTER WRK-PNT
               END-STRING
           ELSE
               STRING  "　　　　　　　　　　　　　　　　　　　"
                                           DELIMITED   BY  SIZE
               INTO    WRK-SRYACT-STR
               WITH    POINTER WRK-PNT
               END-STRING
           END-IF
      *
           MOVE    PTBYO-TENKIKBN          TO  WRK-PTBYO-TENKIKBN
           PERFORM 200111-PTBYO-TENKIKBN-HEN-SEC
           IF    ( WRK-PTBYO-TENKIKBNMEI    NOT =   SPACE )
               STRING  WRK-PTBYO-TENKIKBNMEI (1:4)
                                           DELIMITED   BY  SIZE
               INTO    WRK-SRYACT-STR
               WITH    POINTER WRK-PNT
               END-STRING
           ELSE
               STRING  "　　"              DELIMITED   BY  SIZE
               INTO    WRK-SRYACT-STR
               WITH    POINTER WRK-PNT
               END-STRING
           END-IF
      *
           PERFORM 210-WRK-SRYACT-TBL-HEN3-SEC
      *
           MOVE    "4"                     TO  WRK-ITEM-KBN
           MOVE    IDX1                    TO  IDXD
           PERFORM 210-SRYACT-HEN-SEC
      *
           .
       200111-PTBYOMEI-RANGAI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為ワークテーブル初期処理
      *****************************************************************
       210-WRK-SRYACT-TBL-SYOKI-SEC    SECTION.
      *
           INITIALIZE  WRK-SRYACT-AREA
           MOVE    1                       TO  WRK-SRYACT-MAX
           MOVE    1                       TO  WRK-SRYACT-PNT
           MOVE    ZERO                    TO  FLG-ZENSP
      *
           .
       210-WRK-SRYACT-TBL-SYOKI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為ワークテーブル編集処理
      *****************************************************************
       210-WRK-SRYACT-TBL-HEN-SEC      SECTION.
      *
           IF    ( WRK-SRYACT-MAX      >=  500 )
               GO  TO  210-WRK-SRYACT-TBL-HEN-EXT
           END-IF
      *
           IF    ( WRK-SRYACT-PNT  <=  1 )
               COMPUTE WRK-SRYACT-MAX  =   WRK-SRYACT-MAX  -   1
           END-IF
      *
           MOVE    WRK-SRYACT-STR  TO  WRK-STR
           PERFORM 800-STRLEN-CHK-SEC
           IF    ( WRK-STRLEN  <=  ZERO )
               GO  TO  210-WRK-SRYACT-TBL-HEN-EXT
           END-IF
      *
           PERFORM VARYING IDX6    FROM    1   BY  CONST-SRYACT-LEN
                   UNTIL ( WRK-SRYACT-MAX  >=  500 )
                     OR  ( IDX6    >       WRK-STRLEN )
               COMPUTE WRK-SRYACT-MAX  =   WRK-SRYACT-MAX  +   1
               MOVE    WRK-SRYACT-STR (IDX6:CONST-SRYACT-LEN)
                                   TO  WRK-SRYACT (WRK-SRYACT-MAX)
           END-PERFORM
      *
           MOVE    WRK-SRYACT (WRK-SRYACT-MAX)
                                   TO  WRK-STR
           PERFORM 800-STRLEN-CHK-SEC
           COMPUTE WRK-SRYACT-PNT  =   WRK-STRLEN  +   1
      *
           .
       210-WRK-SRYACT-TBL-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療行為ワークテーブル編集処理２
      *    （既に編集している項目の後ろに編集）
      *****************************************************************
       210-WRK-SRYACT-TBL-HEN2-SEC     SECTION.
      *
           IF    ( WRK-SRYACT-MAX      >=  500 )
               GO  TO  210-WRK-SRYACT-TBL-HEN2-EXT
           END-IF
      *
           MOVE    WRK-SRYACT-STR      TO  WRK-STR
           PERFORM 800-STRLEN-CHK-SEC
           IF    ( WRK-STRLEN  <=  ZERO )
               GO  TO  210-WRK-SRYACT-TBL-HEN2-EXT
           END-IF
      *
           IF    ( FLG-ZENSP   =   ZERO )
               MOVE    1               TO  FLG-ZENSP
           ELSE
               MOVE    SPACE           TO  WRK-SRYACT-STR
               STRING  "　"                    DELIMITED   BY  SIZE
                       WRK-STR (1:WRK-STRLEN)  DELIMITED   BY  SIZE
               INTO    WRK-SRYACT-STR
               END-STRING
               COMPUTE WRK-STRLEN  =   WRK-STRLEN  +   2
           END-IF
      *
           COMPUTE WRK-PNT     = CONST-SRYACT-LEN
                               * (WRK-SRYACT-MAX   -   1)
                               + WRK-SRYACT-PNT
      *
           STRING  WRK-SRYACT-STR (1:WRK-STRLEN)
                                  DELIMITED   BY  SIZE
           INTO    WRK-SRYACT-TBL
           WITH    POINTER WRK-PNT
           END-STRING
      *
           DIVIDE  WRK-PNT     BY  CONST-SRYACT-LEN
                   GIVING          WRK-SRYACT-MAX
                   REMAINDER       WRK-SRYACT-PNT
      *
           COMPUTE WRK-SRYACT-MAX  =   WRK-SRYACT-MAX  +   1
      *
           .
       210-WRK-SRYACT-TBL-HEN2-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為ワークテーブル編集処理３
      *    （右余白を考慮して編集を行う）
      *****************************************************************
       210-WRK-SRYACT-TBL-HEN3-SEC     SECTION.
      *
           IF    ( WRK-SRYACT-MAX      >=  500 )
               GO  TO  210-WRK-SRYACT-TBL-HEN3-EXT
           END-IF
      *
           MOVE    WRK-SRYACT-STR      TO  WRK-STR
           PERFORM 800-STRLEN-CHK-SEC
           IF    ( WRK-STRLEN  <=  ZERO )
               GO  TO  210-WRK-SRYACT-TBL-HEN3-EXT
           END-IF
      *
           COMPUTE WRK-PNT =   CONST-SRYACT-LEN    -   WRK-STRLEN
           IF    ( CONST-SRYACT-LEN    -  ( WRK-SRYACT-PNT -   1 )
                                       >=  WRK-STRLEN + 2 )
               MOVE    ALL "　"        TO  WRK-STR (1:WRK-PNT)
               STRING  WRK-SRYACT (WRK-SRYACT-MAX)
                                           DELIMITED   BY  SPACE
               INTO    WRK-STR
               END-STRING
               MOVE    1               TO  WRK-SRYACT-PNT
               STRING  WRK-STR (1:WRK-PNT) DELIMITED   BY  SIZE
                       WRK-SRYACT-STR (1:WRK-STRLEN)
                                           DELIMITED   BY  SIZE
               INTO    WRK-SRYACT (WRK-SRYACT-MAX)
               WITH    POINTER WRK-SRYACT-PNT
               END-STRING
           ELSE
               COMPUTE WRK-SRYACT-MAX  =   WRK-SRYACT-MAX  +   1
               MOVE    1               TO  WRK-SRYACT-PNT
               MOVE    ALL "　"        TO  WRK-STR (1:WRK-PNT)
               STRING  WRK-STR (1:WRK-PNT) DELIMITED   BY  SIZE
                       WRK-SRYACT-STR (1:WRK-STRLEN)
                                           DELIMITED   BY  SIZE
               INTO    WRK-SRYACT (WRK-SRYACT-MAX)
               WITH    POINTER WRK-SRYACT-PNT
               END-STRING
           END-IF
      *
           .
       210-WRK-SRYACT-TBL-HEN3-EXT.
           EXIT.
      *****************************************************************
      *    診療行為ワークテーブル編集処理
      *    （検査のまとめ編集）
      *****************************************************************
       210-WRK-SRYACT-TBL-HEN4-SEC     SECTION.
      *
           IF    ( WRK-SRYACT-MAX      >=  500 )
               GO  TO  210-WRK-SRYACT-TBL-HEN4-EXT
           END-IF
      *
           IF    ( WRK-SRYACT-PNT  <=  1 )
            AND  ( WRK-SRYACT-MAX   >  1 )
               COMPUTE WRK-SRYACT-MAX  =   WRK-SRYACT-MAX  -   1
           END-IF
      *
           MOVE    WRK-SRYACT-STR  TO  WRK-STR
           PERFORM 800-STRLEN-CHK-SEC
           IF    ( WRK-STRLEN  <=  ZERO )
               GO  TO  210-WRK-SRYACT-TBL-HEN4-EXT
           END-IF
      *
           COMPUTE WRK-WIDTH   = ( WRK-SRYACT-PNT  -   1)
                               +   WRK-STRLEN
      *
           EVALUATE    TRUE
           WHEN  ( WRK-STRLEN  >   CONST-SRYACT-LEN)
               PERFORM VARYING IDX6    FROM    1   BY  CONST-SRYACT-LEN
                       UNTIL ( WRK-SRYACT-MAX  >=  500 )
                         OR  ( IDX6    >       WRK-STRLEN )
                   COMPUTE WRK-SRYACT-MAX  =   WRK-SRYACT-MAX  +   1
                   MOVE    WRK-SRYACT-STR (IDX6:CONST-SRYACT-LEN)
                                       TO  WRK-SRYACT (WRK-SRYACT-MAX)
               END-PERFORM
               MOVE    WRK-SRYACT (WRK-SRYACT-MAX)
                                       TO  WRK-STR
               PERFORM 800-STRLEN-CHK-SEC
               EVALUATE    TRUE
               WHEN  ( WRK-STRLEN  <=  ZERO )
                   MOVE    1           TO  WRK-SRYACT-PNT
               WHEN
                     ( WRK-STRLEN  >=  CONST-SRYACT-LEN )
                   COMPUTE WRK-SRYACT-MAX  =   WRK-SRYACT-MAX  +   1
                   MOVE    1           TO  WRK-SRYACT-PNT
               WHEN    OTHER
                   COMPUTE WRK-SRYACT-PNT  =   WRK-STRLEN      +   1
               END-EVALUATE
           WHEN  ( WRK-WIDTH   >   CONST-SRYACT-LEN )
               COMPUTE WRK-SRYACT-MAX   =   WRK-SRYACT-MAX  +   1
               MOVE    1               TO  WRK-SRYACT-PNT
               STRING  WRK-SRYACT-STR (1:WRK-STRLEN)
                                       DELIMITED   BY  SIZE
               INTO    WRK-SRYACT (WRK-SRYACT-MAX)
               WITH    POINTER WRK-SRYACT-PNT
               END-STRING
           WHEN    OTHER
               STRING  WRK-SRYACT-STR (1:WRK-STRLEN)
                                       DELIMITED   BY  SIZE
               INTO    WRK-SRYACT (WRK-SRYACT-MAX)
               WITH    POINTER WRK-SRYACT-PNT
               END-STRING
           END-EVALUATE
      *
           .
       210-WRK-SRYACT-TBL-HEN4-EXT.
           EXIT.
      *****************************************************************
      *    診療行為ワークテーブル編集処理
      *    （最後のカンマを削る）
      *****************************************************************
       210-WRK-SRYACT-TBL-HEN5-SEC     SECTION.
      *
           IF    ( WRK-SRYACT-PNT  <=  1 )
            AND  ( WRK-SRYACT-MAX   >  1 )
               COMPUTE WRK-SRYACT-MAX  =   WRK-SRYACT-MAX  -   1
           END-IF
      *
           MOVE    WRK-SRYACT (WRK-SRYACT-MAX)
                                       TO  WRK-STR
           PERFORM 800-STRLEN-CHK-SEC
           IF    ( WRK-STRLEN  <=  2 )
               MOVE    SPACE           TO  WRK-SRYACT (WRK-SRYACT-MAX)
               MOVE    1               TO  WRK-SRYACT-PNT
               GO  TO  210-WRK-SRYACT-TBL-HEN5-EXT
           END-IF
      *
           MOVE    WRK-SRYACT (WRK-SRYACT-MAX) (1 : WRK-STRLEN - 2)
                                       TO  WRK-STR
           MOVE    WRK-STR             TO  WRK-SRYACT (WRK-SRYACT-MAX)
           COMPUTE WRK-SRYACT-PNT      =   WRK-SRYACT-PNT  -   2
      *
           .
       210-WRK-SRYACT-TBL-HEN5-EXT.
           EXIT.
      *****************************************************************
      *    診療行為編集処理
      *****************************************************************
       210-SRYACT-HEN-SEC          SECTION.
      *
           IF    ( WRK-SRYACT-MAX      >   ZERO )
               IF    ( WRK-SRYACT-PNT  <=  1 )
                   COMPUTE WRK-SRYACT-MAX  =   WRK-SRYACT-MAX  -   1
               END-IF
           END-IF
      *
           PERFORM VARYING IDX4    FROM    1   BY  1
                   UNTIL ( IDX4    >   WRK-SRYACT-MAX )
      *
               COMPUTE CNT-SRYACT-LINE =   CNT-SRYACT-LINE +   1
               MOVE    CNT-SRYACT-LINE     TO  IDXC
               IF    ( FLG-HEAD    =   ZERO )
                   IF    ( WRK-ITEM-KBN    =   "5" )
                       IF    ( IDX4        =   1 )
                           MOVE    WRK-SRYACT-SRYKBN
                                           TO  HCM341-SRYKBN (IDXC)
                       END-IF
                       IF  (   IDXC        =   1 )
                        OR ( ( IDX4        =   1 )
                         AND ( WRK-SRYACT-HKNCOMBI
                                       NOT =   WRK-KEY-HKNCOMBI ) )
                           MOVE    WRK-SRYACT-HKNCOMBI
                                           TO  HCM341-HKNCOMBINUM2
                                                              (IDXC)
                           MOVE    WRK-SRYACT-HKNCOMBI
                                           TO   WRK-KEY-HKNCOMBI
                       END-IF
                       IF  ( IDX4            =   WRK-SRYACT-MAX )
                           PERFORM VARYING IDXF    FROM    1   BY  1
                                   UNTIL ( IDXF    >   31 )
                               MOVE    WRK-SRYACT-DAY-X (IDXF)
                                           TO  HCM341-DAY (IDXC IDXF)
                           END-PERFORM
                       END-IF
                   END-IF
                   MOVE    WRK-SRYACT (IDX4)
                                           TO  HCM341-TEKIYO (IDXC)
               ELSE
                   IF    ( WRK-ITEM-KBN    =   "5" )
                       IF    ( IDX4        =   1 )
                           MOVE    WRK-SRYACT-SRYKBN
                                           TO  HCM342-SRYKBN (IDXC)
                       END-IF
                       IF  (   IDXC        =   1 )
                        OR ( ( IDX4        =   1 )
                         AND ( WRK-SRYACT-HKNCOMBI
                                       NOT =   WRK-KEY-HKNCOMBI ) )
                           MOVE    WRK-SRYACT-HKNCOMBI
                                           TO  HCM342-HKNCOMBINUM2
                                                              (IDXC)
                           MOVE    WRK-SRYACT-HKNCOMBI
                                           TO   WRK-KEY-HKNCOMBI
                       END-IF
                       IF  ( IDX4            =   WRK-SRYACT-MAX )
                           PERFORM VARYING IDXF    FROM    1   BY  1
                                   UNTIL ( IDXF    >   31 )
                               MOVE    WRK-SRYACT-DAY-X (IDXF)
                                           TO  HCM342-DAY (IDXC IDXF)
                           END-PERFORM
                       END-IF
                   END-IF
                   MOVE    WRK-SRYACT (IDX4)
                                           TO  HCM342-TEKIYO (IDXC)
               END-IF
               PERFORM 210-KAIPEGE-CHK-SEC
           END-PERFORM
      *
           IF    ( CNT-SRYACT-LINE >   ZERO )
               EVALUATE WRK-ITEM-KBN
                                   ALSO    TRUE
               WHEN     "1"        ALSO  ( IDXD    >=  WKHKNCOMBI-MAX )
               WHEN     "2"        ALSO  ( IDXD    >=  WKPTHKNINF-MAX )
               WHEN     "3"        ALSO  ( IDXD    >=  WKPTKOHINF-MAX )
               WHEN     "4"        ALSO  ( IDXD    >=  WKPTBYOMEI-MAX )
               WHEN     "5"        ALSO  ( FLG-LINE =  1              )
                   COMPUTE CNT-SRYACT-LINE =   CNT-SRYACT-LINE +   1
                   MOVE    CNT-SRYACT-LINE TO  IDXC
                   IF    ( FLG-HEAD    =   ZERO )
                       MOVE    ALL "−"    TO  HCM341-TEKIYO (IDXC)
                   ELSE
                       MOVE    ALL "−"    TO  HCM342-TEKIYO (IDXC)
                   END-IF
                   PERFORM 210-KAIPEGE-CHK-SEC
               END-EVALUATE
      *
           END-IF
      *
           .
       210-SRYACT-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    改ページチェック処理
      *****************************************************************
       210-KAIPEGE-CHK-SEC             SECTION.
      *
           IF    ( CNT-SRYACT-LINE >=  CONST-LINE-MAX )
               PERFORM 290-PRINT-SEC
               MOVE    1           TO  FLG-HEAD
               INITIALIZE              HCM342
               MOVE    ZERO        TO  CNT-SRYACT-LINE
           END-IF
      *
           .
       210-KAIPEGE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       290-PRINT-SEC               SECTION.
      *
           IF    ( ORCHCM34-KBN   =   "1" )
               IF    ( FLG-HEAD   =   ZERO )
                   PERFORM 2901-HCM341-ONL-PRINT-SEC
               ELSE
                   PERFORM 2901-HCM342-ONL-PRINT-SEC
               END-IF
           ELSE
               IF    ( FLG-HEAD   =   ZERO )
                   PERFORM 2901-HCM341-BAT-PRINT-SEC
               ELSE
                   PERFORM 2901-HCM342-BAT-PRINT-SEC
               END-IF
           END-IF
      *
           .
       290-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    会計カードオンライン印刷処理（頭紙）
      *****************************************************************
       2901-HCM341-ONL-PRINT-SEC       SECTION.
      *
      *    ヘッダー情報編集処理
           PERFORM 29011-HCM341-HEADER-HEN-SEC
      *
           ACCEPT  SYS-TIME            FROM    TIME
      *
           MOVE    "HC01"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           MOVE    CNT-PAGE            TO  HC01PARA-CNT
           COMPUTE HC01PARA-CNT    =   HC01PARA-CNT    *   10
           IF    ( ORCHCM34-KBN        =   "1" )
               COMPUTE HC01PARA-CNT    =   HC01PARA-CNT    +   1
           ELSE
               COMPUTE HC01PARA-CNT    =   HC01PARA-CNT    +   2
           END-IF
           OPEN    OUTPUT              PRT-FILE
      *    印刷用データ出力
           MOVE    HCM341             TO  PRT-REC
           WRITE   PRT-REC
      *
           CLOSE                       PRT-FILE
      *
           INITIALIZE                 ORCSMKPRTAREA
           MOVE   "HC01.sh"           TO  MKPRT-ID
           MOVE   "HCM341.red"        TO  MKPRT-DIA
           MOVE   SPACE               TO  MKPRT-DEF
           MOVE   HC01PARA            TO  MKPRT-DAT
      *    ■暫定
           MOVE   SYS-1031-PRTNM(1)   TO  MKPRT-PRTNM
           CALL   "ORCSMKPRT"         USING
                                      ORCSMKPRTAREA
      *
           .
       2901-HCM341-ONL-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    会計カードオンライン印刷処理（続紙）
      *****************************************************************
       2901-HCM342-ONL-PRINT-SEC       SECTION.
      *
      *    ヘッダー情報編集処理
           PERFORM 29011-HCM342-HEADER-HEN-SEC
      *
           ACCEPT  SYS-TIME            FROM    TIME
      *
           MOVE    "HC01"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           MOVE    CNT-PAGE            TO  HC01PARA-CNT
           OPEN    OUTPUT              PRT-FILE
      *    印刷用データ出力
           MOVE    HCM342             TO  PRT-REC
           WRITE   PRT-REC
      *
           CLOSE                       PRT-FILE
      *
           INITIALIZE                 ORCSMKPRTAREA
           MOVE   "HC01.sh"           TO  MKPRT-ID
           MOVE   "HCM342.red"       TO  MKPRT-DIA
           MOVE   SPACE               TO  MKPRT-DEF
           MOVE   HC01PARA            TO  MKPRT-DAT
      *    ■暫定
           MOVE   SYS-1031-PRTNM(1)   TO  MKPRT-PRTNM
           CALL   "ORCSMKPRT"         USING
                                      ORCSMKPRTAREA
           .
       2901-HCM342-ONL-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    会計カード一括印刷処理（頭紙）
      *****************************************************************
       2901-HCM341-BAT-PRINT-SEC       SECTION.
      *
      *    ヘッダー情報編集処理
           PERFORM 29011-HCM341-HEADER-HEN-SEC
      *
           MOVE    ORCHCM34-PRTAREA    TO  ORCSPRTAREA
      *
           MOVE   "HCM341.red"         TO  SPRT-PRTID
           MOVE    HCM341              TO  SPRT-PRTDATA
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF    ( SPRT-RETURN         =   ZERO )
               CONTINUE
           ELSE
               MOVE    2               TO  ORCHCM34-RC
           END-IF
      *
           .
       2901-HCM341-BAT-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    会計カード一括印刷処理（頭紙）
      *****************************************************************
       2901-HCM342-BAT-PRINT-SEC       SECTION.
      *
      *    ヘッダー情報編集処理
           PERFORM 29011-HCM342-HEADER-HEN-SEC
      *
           MOVE    ORCHCM34-PRTAREA    TO  ORCSPRTAREA
      *
           MOVE   "HCM342.red"         TO  SPRT-PRTID
           MOVE    HCM342              TO  SPRT-PRTDATA
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF    ( SPRT-RETURN         =   ZERO )
               CONTINUE
           ELSE
               MOVE    3               TO  ORCHCM34-RC
           END-IF
      *
           .
       2901-HCM342-BAT-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    ヘッダー情報編集処理（頭紙）
      *****************************************************************
       29011-HCM341-HEADER-HEN-SEC SECTION.
      *
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   1
      *
           MOVE    WRK-HCM34-SRYYM         TO  HCM341-SRYYM
      *
           IF    ( ORCHCM34-NYUGAIKBN  =   "1" )
               MOVE    "入院"              TO  HCM341-NYUGAI
           ELSE
               MOVE    "外来"              TO  HCM341-NYUGAI
           END-IF
      *
           MOVE    WRK-HCM34-SAKYMD        TO  HCM341-SAKYMD
           MOVE    WRK-HCM34-PTNUM         TO  HCM341-PTNUM
           MOVE    WRK-HCM34-PTNUM2        TO  HCM341-PTNUM2
           MOVE    PTINF-NAME              TO  HCM341-NAME
           MOVE    PTINF-KANANAME          TO  HCM341-KANANAME
           MOVE    WRK-HCM34-BIRTHDAY      TO  HCM341-BIRTHDAY
           MOVE    WRK-HCM34-SRYKA(1)      TO  HCM341-SRYKA(1)
           MOVE    WRK-HCM34-SRYKA(2)      TO  HCM341-SRYKA(2)
           MOVE    WRK-HCM34-NYUINYMD      TO  HCM341-NYUINYMD
           MOVE    WRK-HCM34-TAIINYMD      TO  HCM341-TAIINYMD
           MOVE    WRK-HCM34-LBLSRYKA      TO  HCM341-LBLSRYKA
           MOVE    WRK-HCM34-LBLNYUINYMD   TO  HCM341-LBLNYUINYMD
           MOVE    WRK-HCM34-LBLTAIINYMD   TO  HCM341-LBLTAIINYMD
           MOVE    CNT-PAGE                TO  WRK-ZZ9
           MOVE    WRK-ZZ9                 TO  HCM341-PAGE
      *
           .
       29011-HCM341-HEADER-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ヘッダー情報編集処理（続紙）
      *****************************************************************
       29011-HCM342-HEADER-HEN-SEC SECTION.
      *
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   1
      *
           MOVE    WRK-HCM34-SRYYM         TO  HCM342-SRYYM
      *
           IF    ( ORCHCM34-NYUGAIKBN  =   "1" )
               MOVE    "入院"              TO  HCM342-NYUGAI
           ELSE
               MOVE    "外来"              TO  HCM342-NYUGAI
           END-IF
      *
           MOVE    WRK-HCM34-SAKYMD        TO  HCM342-SAKYMD
           MOVE    WRK-HCM34-PTNUM         TO  HCM342-PTNUM
           MOVE    WRK-HCM34-PTNUM2        TO  HCM342-PTNUM2
           MOVE    PTINF-NAME              TO  HCM342-NAME
           MOVE    PTINF-KANANAME          TO  HCM342-KANANAME
           MOVE    WRK-HCM34-BIRTHDAY      TO  HCM342-BIRTHDAY
           MOVE    WRK-HCM34-SRYKA(1)      TO  HCM342-SRYKA(1)
           MOVE    WRK-HCM34-SRYKA(2)      TO  HCM342-SRYKA(2)
           MOVE    WRK-HCM34-NYUINYMD      TO  HCM342-NYUINYMD
           MOVE    WRK-HCM34-TAIINYMD      TO  HCM342-TAIINYMD
           MOVE    WRK-HCM34-LBLSRYKA      TO  HCM342-LBLSRYKA
           MOVE    WRK-HCM34-LBLNYUINYMD   TO  HCM342-LBLNYUINYMD
           MOVE    WRK-HCM34-LBLTAIINYMD   TO  HCM342-LBLTAIINYMD
           MOVE    CNT-PAGE                TO  WRK-ZZ9
           MOVE    WRK-ZZ9                 TO  HCM342-PAGE
      *
           .
       29011-HCM342-HEADER-HEN-EXT.
           EXIT.
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           MOVE    CNT-PAGE                TO  ORCHCM34-PAGE
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    全角変換処理
      *****************************************************************
       800-ZENKAKU-HEN-SEC         SECTION.
      *
           MOVE    SPACE           TO  WRK-OUT-INPUT
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE  WRK-MAE-INPUT     TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF    ( KANACHK-RC      =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-OUT-INPUT
               MOVE    KANACHK-MAX TO  WRK-OUT-MAX
           END-IF
      *
           .
       800-ZENKAKU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC         SECTION.
      *
           MOVE    SPACE               TO  WRK-EDTYMD1
                                           WRK-EDTYMD3
      *
           IF    ( WRK-SYMD            =   SPACE )
               GO  TO  800-SEIWA-HEN-EXT
           END-IF
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"       USING   STS-AREA-DAY
                                           LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-EDTYMD1
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-EDTYMD3
           INSPECT WRK-EDTYMD3     REPLACING  ALL "  "  BY  "　"
      *
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    カレンダー処理
      *****************************************************************
       800-CALENDAR-SEC               SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY6-KIJUN
           MOVE    WRK-ZOGENPTN        TO  LNK-DAY6-ZOGENPTN
           MOVE    WRK-ZOGEN           TO  LNK-DAY6-ZOGEN
           CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN     TO  WRK-SYMD
      *
           .
       800-CALENDAR-EXT.
           EXIT.
      *****************************************************************
      *    月末日取得処理
      *****************************************************************
       800-GETUMATU-SEC      SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY1-AREA
           MOVE    "71"                TO   LNK-DAY7-IRAI
           MOVE    WRK-SYMD (1 : 6)    TO   LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                       LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-SYMD
      *
           .
       800-GETUMATU-EXT.
            EXIT.
      *****************************************************************
      *    文字列長チェック処理
      *****************************************************************
       800-STRLEN-CHK-SEC              SECTION.
      *
           MOVE    ZERO            TO  WRK-STRLEN
           PERFORM VARYING IDXB    FROM    500 BY  -1
                   UNTIL ( IDXB    <   1 )
               IF    ( WRK-STR (IDXB : 1)  NOT =   SPACE )
                   MOVE    IDXB    TO  WRK-STRLEN
                   MOVE    1       TO  IDXB
               END-IF
           END-PERFORM
      *
           .
       800-STRLEN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    文字列左詰処理
      *****************************************************************
       800-STR-HIDARIZUME-HEN-SEC      SECTION.
      *
           MOVE    WRK-STR-LEFT    TO  IDXE
           PERFORM VARYING IDXE    FROM    1   BY  1
                   UNTIL ( IDXE    >       500 )
      *
               IF    ( WRK-STR-LEFT (IDXE:1)
                                       NOT =   SPACE )
                   MOVE    WRK-STR-LEFT (IDXE:)
                                           TO  WRK-STR-LEFT-TMP
                   MOVE    WRK-STR-LEFT-TMP
                                           TO  WRK-STR-LEFT
                   MOVE    500             TO  IDXE
               END-IF
      *
           END-PERFORM
      *
           .
       800-STR-HIDARIZUME-HEN-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       900-TBL-SELECT-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               MOVE    WRK-DBPATH  TO  ORC-DBPATH
               MOVE    "DBFETCH"   TO  MCP-FUNC
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   CONTINUE
               ELSE
                   MOVE    1       TO  FLG-DBRC
               END-IF
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    テーブル読込処理
      *****************************************************************
       900-TBL-READ-SEC                SECTION.
      *
           MOVE    ZERO            TO  FLG-DBRC
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               CONTINUE
           ELSE
               MOVE    1           TO  FLG-DBRC
           END-IF
      *
           .
       900-TBL-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-TBL-CLOSE-SEC               SECTION.
      *
           MOVE    WRK-DBPATH      TO  ORC-DBPATH
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-TBL-CLOSE-EXT.
           EXIT.
