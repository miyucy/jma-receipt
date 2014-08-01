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
       PROGRAM-ID.             ORCHCN68.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 入院会計照会
      *  コンポーネント名  : 医療区分・ＡＤＬ評価票
      *  管理者            : 
      *  作成日付    作業者        記述
      *  13/09/17    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者        日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    印刷用データ
           SELECT  PRT-FILE        ASSIGN  ASGNPARA
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
       01  PRT-REC.
           03  PRT-PRTDATA         PIC X(20000).
      *
       WORKING-STORAGE             SECTION.
      *
      *    印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
           COPY    "CPASGNPARA.INC".
      *
      *    帳票領域
           COPY    "HCN68.INC".
           COPY    "HCN69.INC".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-RYOCOM          PIC 9(01).
      *
      *    インデックス領域
       01  IDX-AREA.
           03  IDXL                PIC 9(05).
           03  IDX-MED             PIC 9(05).
           03  IDX-ADL             PIC 9(05).
           03  IDX-RYO             PIC 9(05).
           03  IDX-DAY             PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD            PIC X(08).
           03  WRK-EDTYMD1         PIC X(10).
           03  WRK-EDTYMD3         PIC X(22).
           03  WRK-PRT-SRYYM       PIC X(16).
           03  WRK-PRT-SAKYMD      PIC X(22).
           03  WRK-ADLTEN-G.
               05  WRK-ADLTEN      PIC 9(02).
           03  WRK-PRT-ADLTEN      PIC X(02).
           03  WRK-KANACHK-STR     PIC X(500).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理
           COPY    "CPSYSKANRI.INC".
           COPY    "CPSK1001.INC".
           COPY    "CPSK1034.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    全角変換サブ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    印刷パラメタ
           COPY    "CPORCSMKPRT.INC".
      *
      *    一時ファイル名編集
           COPY    "CPORCSGETTEMP.INC".
      *
           COPY    "CPORCHCN68.INC".
           COPY    "CPORCHCN68S01.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       COPY    "COMMON-SPA".
       COPY    "CPONPRTDATA.INC".
      *
      ******************************************************************
       PROCEDURE               DIVISION
                                   USING
                                   SPA-AREA
                                   ONPRTDATA
                                   .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  STS-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    ONPRTDATA-DATA  TO  ORCHCN68AREA
      *
           PERFORM 800-MCNDATE-SEC
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                  SYSKANRI-REC
           INITIALIZE                  ORCSPRTNMAREA
           MOVE    "2"             TO  ORCSPRTNM-KBN
           MOVE    SPA-SYSYMD      TO  ORCSPRTNM-SRYYMD
           MOVE    "1"             TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                       ORCSPRTNMAREA
                                       SPA-AREA
                                       SYSKANRI-REC
           IF    ( ORCSPRTNM-RC    =   ZERO )
               MOVE    SYSKANRI-REC    TO  SYS-1034-REC
           ELSE
               INITIALIZE                  SYS-1034-REC
           END-IF
      *
           MOVE    ORCHCN68-SRYYM  TO  WRK-SYMD
           MOVE    "01"            TO  WRK-SYMD(7:)
           PERFORM 800-HIZUKE-EDIT-SEC
           MOVE    WRK-EDTYMD3     TO  WRK-PRT-SRYYM
      *
           MOVE    SPA-SYSYMD      TO  WRK-SYMD
           PERFORM 800-HIZUKE-EDIT-SEC
           MOVE    WRK-EDTYMD3     TO  WRK-PRT-SAKYMD
      *
           PERFORM 900-PTINF-KEY-SEL-SEC
      *
      *    出力先プリンタ名割り当て情報編集
           INITIALIZE                  SYSKANRI-REC
           MOVE    SPA-HOSPNUM     TO  SYS-HOSPNUM
           MOVE    "1001"          TO  SYS-KANRICD
           MOVE    "*"             TO  SYS-KBNCD
           MOVE    ORCHCN68-SRYYM  TO  SYS-STYUKYMD
           MOVE    "01"            TO  SYS-STYUKYMD (7:2)
           MOVE    SYS-STYUKYMD    TO  SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-1001-REC
      *
           INITIALIZE                  HCN68S01-AREA
           MOVE    "1"             TO  HCN68S01-RANGE
           MOVE    ORCHCN68-PTID   TO  HCN68S01-PTID
           MOVE    ORCHCN68-SRYYM  TO  HCN68S01-SRYYM
                                       HCN68S01-SRYYMD
           MOVE    "01"            TO  HCN68S01-SRYYMD (7:)
           CALL    "ORCHCN68S01"   USING
                                   SPA-AREA
                                   HCN68S01-AREA
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           IF    ( ORCHCN68-PRTKBN =   "0" )
            OR   ( HCN68S01-RYOYO-FLG  =   ZERO )
               PERFORM 2000-EDIT-SEC
           ELSE
               PERFORM 2001-EDIT-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票出力処理
      *****************************************************************
       2000-EDIT-SEC               SECTION.
      *
           INITIALIZE              HCN68
           PERFORM 20001-HCN68-HEADER-SEC
           PERFORM 230-PRINT-SEC
      *
           INITIALIZE              HCN69
           PERFORM 20001-HCN69-HEADER-SEC
           PERFORM 231-PRINT-SEC
      *
           .
       2000-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    医療区分評価票見出し部編集処理
      *****************************************************************
       20001-HCN68-HEADER-SEC          SECTION.
      *
           MOVE    WRK-PRT-SRYYM   TO  HCN68-SRYYM
           MOVE    ORCHCN68-PTNUM  TO  HCN68-PTNUM
           MOVE    PTINF-NAME      TO  HCN68-NAME
      *
           EVALUATE    PTINF-SEX
           WHEN    "1"
               MOVE    "男"        TO  HCN68-SEX
           WHEN    "2"
               MOVE    "女"        TO  HCN68-SEX
           END-EVALUATE
      *
           MOVE    PTINF-BIRTHDAY  TO  WRK-SYMD
           PERFORM 800-HIZUKE-EDIT-SEC
           MOVE    WRK-EDTYMD3     TO  HCN68-BIRTHDAY
      *
           MOVE    "発行日"        TO  HCN68-LBLSAKYMD
           MOVE    WRK-PRT-SAKYMD  TO  HCN68-SAKYMD
      *
           .
       20001-HCN68-HEADER-EXT.
           EXIT.
      *****************************************************************
      *    ＡＤＬ区分評価票見出し部編集処理
      *****************************************************************
       20001-HCN69-HEADER-SEC          SECTION.
      *
           MOVE    WRK-PRT-SRYYM   TO  HCN69-SRYYM
           MOVE    ORCHCN68-PTNUM  TO  HCN69-PTNUM
           MOVE    PTINF-NAME      TO  HCN69-NAME
      *
           EVALUATE    PTINF-SEX
           WHEN    "1"
               MOVE    "男"        TO  HCN69-SEX
           WHEN    "2"
               MOVE    "女"        TO  HCN69-SEX
           END-EVALUATE
      *
           MOVE    PTINF-BIRTHDAY  TO  WRK-SYMD
           PERFORM 800-HIZUKE-EDIT-SEC
           MOVE    WRK-EDTYMD3     TO  HCN69-BIRTHDAY
      *
           MOVE    "発行日"        TO  HCN69-LBLSAKYMD
           MOVE    WRK-PRT-SAKYMD  TO  HCN69-SAKYMD
      *
           IF    ( SYS-1001-HOSPSBT    =   "1" )
               STRING  "MonpeLayerIn"      DELIMITED  BY  SIZE
                       " -L CLINIC "       DELIMITED  BY  SIZE
                       "MonpeLayerOut"     DELIMITED  BY  SIZE
               INTO    HCN69-LOPTION
               END-STRING
           ELSE
               STRING  "MonpeLayerIn"      DELIMITED  BY  SIZE
                       " -L HOSP "         DELIMITED  BY  SIZE
                       "MonpeLayerOut"     DELIMITED  BY  SIZE
               INTO    HCN69-LOPTION
               END-STRING
           END-IF
      *
      *
           .
       20001-HCN69-HEADER-EXT.
           EXIT.
      *****************************************************************
      *    帳票出力処理
      *****************************************************************
       2001-EDIT-SEC               SECTION.
      *
           INITIALIZE              HCN68
           PERFORM 20001-HCN68-HEADER-SEC
           PERFORM 20011-EDIT-HCN68-SEC
           PERFORM 230-PRINT-SEC
      *
           INITIALIZE              HCN69
           PERFORM 20001-HCN69-HEADER-SEC
           PERFORM 20011-EDIT-HCN69-SEC
           PERFORM 231-PRINT-SEC
      *
           .
       2001-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    医療区分評価票編集処理
      *****************************************************************
       20011-EDIT-HCN68-SEC            SECTION.
      *
           PERFORM VARYING IDXL    FROM    1   BY  1
                   UNTIL ( IDXL    >   HCN68S01-RYOLIST-MAX )
      *
               MOVE    ZERO        TO  IDX-MED
      *
               EVALUATE    HCN68S01-TZAINUM (IDXL)
               WHEN    2004
                   MOVE    01      TO  IDX-MED
               WHEN    2020
                   MOVE    02      TO  IDX-MED
               WHEN    2021
                   MOVE    03      TO  IDX-MED
               WHEN    2022
                   MOVE    04      TO  IDX-MED
               WHEN    2023
                   MOVE    05      TO  IDX-MED
               WHEN    2024
                   MOVE    06      TO  IDX-MED
               WHEN    2027
                   MOVE    07      TO  IDX-MED
               WHEN    2031
                   MOVE    08      TO  IDX-MED
               WHEN    2034
                   MOVE    09      TO  IDX-MED
               WHEN    2001
                   MOVE    10      TO  IDX-MED
               WHEN    2010
                   MOVE    11      TO  IDX-MED
               WHEN    2002
                   MOVE    12      TO  IDX-MED
               WHEN    2003
                   MOVE    13      TO  IDX-MED
               WHEN    2005
                   MOVE    14      TO  IDX-MED
               WHEN    2006
                   MOVE    15      TO  IDX-MED
               WHEN    2007
                   MOVE    16      TO  IDX-MED
               WHEN    2008
                   MOVE    17      TO  IDX-MED
               WHEN    2009
                   MOVE    18      TO  IDX-MED
               WHEN    2011
                   MOVE    19      TO  IDX-MED
               WHEN    2012
                   MOVE    20      TO  IDX-MED
               WHEN    2013
                   MOVE    21      TO  IDX-MED
               WHEN    2014
                   MOVE    22      TO  IDX-MED
               WHEN    2015
                   MOVE    23      TO  IDX-MED
               WHEN    2016
                   MOVE    24      TO  IDX-MED
               WHEN    2017
                   MOVE    25      TO  IDX-MED
               WHEN    2030
                   MOVE    26      TO  IDX-MED
               WHEN    2036
                   MOVE    27      TO  IDX-MED
               WHEN    2037
                   MOVE    28      TO  IDX-MED
               WHEN    2018
                   MOVE    29      TO  IDX-MED
               WHEN    2019
                   MOVE    30      TO  IDX-MED
               WHEN    2025
                   MOVE    31      TO  IDX-MED
               WHEN    2026
                   MOVE    32      TO  IDX-MED
               WHEN    2028
                   MOVE    33      TO  IDX-MED
               WHEN    2029
                   MOVE    34      TO  IDX-MED
               WHEN    2032
                   MOVE    35      TO  IDX-MED
               WHEN    2033
                   MOVE    36      TO  IDX-MED
               WHEN    2035
                   MOVE    37      TO  IDX-MED
               WHEN    2092
                   MOVE    38      TO  IDX-MED
               END-EVALUATE
      *
               IF    ( IDX-MED         >   ZERO )
                   PERFORM 200111-EDIT-HCN68-SEC
               END-IF
      *
           END-PERFORM
      *
           IF    ( HCN68S01-MEDKBN-DAYALL (1)   =    1 )
               MOVE    "○"        TO  HCN68-TTL-MEDKBN-ALL (1)
           END-IF
           IF    ( HCN68S01-MEDKBN-DAYALL (2)   =    1    )
               MOVE    "○"        TO  HCN68-TTL-MEDKBN-ALL (2)
           END-IF
      *
           PERFORM VARYING IDX-DAY FROM    1   BY  1
                   UNTIL ( IDX-DAY >   31 )
      *
               IF    ( HCN68S01-MEDKBN-DAY (1 IDX-DAY) =  1 )
                   MOVE    "○"    TO  HCN68-TTL-MEDKBN-DAY (1 IDX-DAY)
               END-IF
      *
               IF    ( HCN68S01-MEDKBN-DAY (2 IDX-DAY)   =  1 )
                   MOVE    "○"    TO  HCN68-TTL-MEDKBN-DAY (2 IDX-DAY)
               END-IF
      *
               IF    ( HCN68S01-RYOYO-CD (IDX-DAY)
                                   NOT =   SPACE )
      *
                   IF    ( HCN68S01-MEDKBN-DAYALL (1)      = ZERO )
                    AND  ( HCN68S01-MEDKBN-DAY (1 IDX-DAY) = ZERO )
                    AND  ( HCN68S01-MEDKBN-DAYALL (2)      = ZERO )
                    AND  ( HCN68S01-MEDKBN-DAY (2 IDX-DAY) = ZERO )
                       MOVE    "○"
                                   TO  HCN68-TTL-MEDKBN-DAY (3 IDX-DAY)
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       20011-EDIT-HCN68-EXT.
           EXIT.
      *****************************************************************
      *    医療区分評価票編集処理
      *****************************************************************
       200111-EDIT-HCN68-SEC           SECTION.
      *
         IF ( HCN68S01-TALLKBN (IDXL)  =   1 )
      *
             IF  ( HCN68S01-TDAYALL (IDXL)
                                       >   ZERO )
                   MOVE    "○"    TO  HCN68-MEDKBN-ALL(IDX-MED)
             END-IF
         ELSE
             PERFORM VARYING IDX-DAY FROM    1   BY  1
                     UNTIL ( IDX-DAY >   31 )
                 IF  ( HCN68S01-TDAY (IDXL IDX-DAY)
                                           >   ZERO )
                       MOVE    "○"
                               TO  HCN68-MEDKBN-DAY (IDX-MED IDX-DAY)
                 END-IF
             END-PERFORM
         END-IF
      *
           .
       200111-EDIT-HCN68-EXT.
           EXIT.
      *****************************************************************
      *    医療区分評価票印刷処理
      *****************************************************************
       230-PRINT-SEC               SECTION.
      *
           COMPUTE ORCHCN68-CNT    =   ORCHCN68-CNT    +   1
      *
      *    印刷用ファイル作成
           MOVE    SPA-HOSPNUM     TO  HC01PARA-HOSPNUM
           MOVE    "HC68"          TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID      TO  HC01PARA-TERMID
           MOVE    SMCNDATE-HMS    TO  HC01PARA-SYOHMS
           MOVE    ORCHCN68-CNT    TO  HC01PARA-CNT
      *
           INITIALIZE                  SGETTEMP-AREA
           MOVE    HC01PARA        TO  SGETTEMP-BASENAME
           CALL    "ORCSGETTEMP"   USING   SGETTEMP-AREA
           MOVE    SGETTEMP-FULLNAME
                                   TO  ASGNPARA
      *
           OPEN    OUTPUT              PRT-FILE
           MOVE    SPACE           TO  PRT-REC
      *
      *    印刷用データ出力
           MOVE    HCN68           TO  PRT-PRTDATA
           WRITE                       PRT-REC
      *
           CLOSE                       PRT-FILE
      *
      *    帳票印刷処理
           INITIALIZE                  ORCSMKPRTAREA
           MOVE    "HC01.sh"       TO  MKPRT-ID
           MOVE    "HCN68.red"     TO  MKPRT-DIA
           MOVE    SPACE           TO  MKPRT-DEF
           MOVE    ASGNPARA        TO  MKPRT-DAT
           MOVE    SYS-1034-PRTNM(14)
                                   TO  MKPRT-PRTNM
           MOVE   "医療区分・ＡＤＬ評価票"
                                   TO  MKPRT-INFO
           CALL   "ORCSMKPRT1"         USING
                                       ORCSMKPRTAREA
                                       SPA-AREA
      *
           .
       230-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    医療区分評価票編集処理
      *****************************************************************
       20011-EDIT-HCN69-SEC            SECTION.
      *
           PERFORM VARYING IDXL    FROM    1   BY  1
                   UNTIL ( IDXL    >   HCN68S01-RYOLIST-MAX )
      *
               MOVE    ZERO        TO  IDX-ADL
      *
               EVALUATE    HCN68S01-TZAINUM (IDXL)
               WHEN    1001
                   MOVE    01      TO  IDX-ADL
               WHEN    1002
                   MOVE    02      TO  IDX-ADL
               WHEN    1003
                   MOVE    03      TO  IDX-ADL
               WHEN    1004
                   MOVE    04      TO  IDX-ADL
               END-EVALUATE
      *
               IF    ( IDX-ADL         >   ZERO )
                   PERFORM 200111-EDIT-HCN69-SEC
               END-IF
      *
           END-PERFORM
      *
           PERFORM VARYING IDX-DAY FROM    1   BY  1
                   UNTIL ( IDX-DAY >   31 )
               IF    ( HCN68S01-RYOYO-CD (IDX-DAY)
                                   NOT =   SPACE )
                   MOVE    HCN68S01-ADLTEN-DAY (IDX-DAY)
                                   TO  WRK-ADLTEN
                   PERFORM 2001111-EDIT-ADLTEN-SEC
                   MOVE    WRK-PRT-ADLTEN
                                   TO  HCN69-TTL-ADLTEN-DAY (IDX-DAY)
               END-IF
           END-PERFORM
      *
           IF    ( SYS-1001-HOSPSBT    =   "1" )
               PERFORM VARYING IDX-DAY FROM    1   BY  1
                       UNTIL ( IDX-DAY >   31 )
      *            IF    ( HCN68S01-RYOYO-KHN (IDX-DAY)
      *                                = 5 OR 6 OR 9 OR 10 )
      *                CONTINUE
      *            ELSE
                       MOVE    HCN68S01-PTSTS-DAY3(IDX-DAY)
                                           TO  IDX-RYO
                       IF    ( IDX-RYO  >=  1 )
                        AND  ( IDX-RYO  <=  9 )
                           MOVE    "○"
                               TO  HCN69-HPTSTS-DAY (IDX-RYO IDX-DAY)
                       END-IF
      *            END-IF
               END-PERFORM
           ELSE
               PERFORM VARYING IDX-DAY FROM    1   BY  1
                       UNTIL ( IDX-DAY >   31 )
      *            IF    ( HCN68S01-RYOYO-KHN (IDX-DAY)
      *                                = 5 OR 6 OR 9 OR 10 )
      *                CONTINUE
      *            ELSE
                       MOVE    HCN68S01-PTSTS-DAY3(IDX-DAY)
                                           TO  IDX-RYO
                       IF    ( IDX-RYO  >=  1 )
                        AND  ( IDX-RYO  <=  5 )
                           MOVE    "○"
                               TO  HCN69-CPTSTS-DAY (IDX-RYO IDX-DAY)
                       END-IF
      *            END-IF
               END-PERFORM
           END-IF
      *
           .
       20011-EDIT-HCN69-EXT.
           EXIT.
      *****************************************************************
      *    医療区分評価票編集処理
      *****************************************************************
       200111-EDIT-HCN69-SEC           SECTION.
      *
         PERFORM VARYING IDX-DAY FROM    1   BY  1
                 UNTIL ( IDX-DAY >   31 )
               IF    ( HCN68S01-RYOYO-CD (IDX-DAY)
                                   NOT =   SPACE )
                   MOVE    HCN68S01-TDAY (IDXL IDX-DAY)
                           TO  WRK-ADLTEN
                   PERFORM 2001111-EDIT-ADLTEN-SEC
                   MOVE    WRK-PRT-ADLTEN
                           TO  HCN69-ADLTEN-DAY (IDX-ADL IDX-DAY)
               END-IF
         END-PERFORM
      *
           .
       200111-EDIT-HCN69-EXT.
           EXIT.
      *****************************************************************
      *    ＡＤＬ点数編集処理
      *****************************************************************
       2001111-EDIT-ADLTEN-SEC         SECTION.
      *
           IF    ( WRK-ADLTEN-G (1:1)  =   "0" )
               MOVE  WRK-ADLTEN-G (2:1)
                                   TO  WRK-PRT-ADLTEN
           ELSE
               MOVE  WRK-ADLTEN-G  TO  WRK-PRT-ADLTEN
           END-IF
      *
           .
       2001111-EDIT-ADLTEN-EXT.
           EXIT.
      *****************************************************************
      *    ＡＤＬ区分評価票印刷処理
      *****************************************************************
       231-PRINT-SEC               SECTION.
      *
           COMPUTE ORCHCN68-CNT    =   ORCHCN68-CNT    +   1
      *
      *    印刷用ファイル作成
           MOVE    SPA-HOSPNUM     TO  HC01PARA-HOSPNUM
           MOVE    "HC68"          TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID      TO  HC01PARA-TERMID
           MOVE    SMCNDATE-HMS    TO  HC01PARA-SYOHMS
           MOVE    ORCHCN68-CNT    TO  HC01PARA-CNT
      *
           INITIALIZE                  SGETTEMP-AREA
           MOVE    HC01PARA        TO  SGETTEMP-BASENAME
           CALL    "ORCSGETTEMP"   USING   SGETTEMP-AREA
           MOVE    SGETTEMP-FULLNAME
                                   TO  ASGNPARA
      *
           OPEN    OUTPUT              PRT-FILE
           MOVE    SPACE           TO  PRT-REC
      *
      *    印刷用データ出力
           MOVE    HCN69           TO  PRT-PRTDATA
           WRITE                       PRT-REC
      *
           CLOSE                       PRT-FILE
      *
      *    帳票印刷処理
           INITIALIZE                  ORCSMKPRTAREA
           MOVE    "HC01.sh"       TO  MKPRT-ID
           MOVE    "HCN69.red"     TO  MKPRT-DIA
           MOVE    SPACE           TO  MKPRT-DEF
           MOVE    ASGNPARA        TO  MKPRT-DAT
           MOVE    SYS-1034-PRTNM(14)
                                   TO  MKPRT-PRTNM
           MOVE   "医療区分・ＡＤＬ評価票"
                                   TO  MKPRT-INFO
           CALL   "ORCSMKPRT1"         USING
                                       ORCSMKPRTAREA
                                       SPA-AREA
      *
           .
       231-PRINT-EXT.
           EXIT.
      *
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
      *    全角変換処理
      *****************************************************************
       800-ZENKAKU-SEC                 SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE   "2"              TO  KANACHK-SYORI
           MOVE  500               TO  KANACHK-MAX-CNT
           MOVE  WRK-KANACHK-STR   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-KANACHK-STR
      *
           .
       800-ZENKAKU-EXT.
           EXIT.
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
      *    西暦日本語変換処理
      *****************************************************************
       800-HIZUKE-EDIT-SEC             SECTION.
      *
           MOVE    SPACE           TO  WRK-EDTYMD1
                                       WRK-EDTYMD3
      *
           IF    ( WRK-SYMD            =   SPACE )
               CONTINUE
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"   USING
                                   STS-AREA-DAY
                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-EDTYMD1
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-EDTYMD3
               INSPECT WRK-EDTYMD3 REPLACING  ALL "  "  BY  "　"
           END-IF
      *
      *
           .
       800-HIZUKE-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       900-SYSKANRI-KEY10-SEL-EXT.
           EXIT.
      *****************************************************************
      *    患者情報取得処理
      *****************************************************************
       900-PTINF-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PTINF
      *
           INITIALIZE                      PTINF-REC
           MOVE    SPA-HOSPNUM         TO  PTINF-HOSPNUM
           MOVE    ORCHCN68-PTID       TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PTINF-REC
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       900-PTINF-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHを行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
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
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
