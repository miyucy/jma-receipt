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
       PROGRAM-ID.                 ORCGE03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＣＳＶ作成
      *  コンポーネント名  : ＣＳＶ作成（Ｅ０３）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/09/15    ひさなが 　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     ひさなが     02/08/09  外部ファイル名長さ誤り修正
      * 01.00.02     ひさなが     02/12/20  作業項目長さ修正
      * 01.00.03     ひさなが     03/04/08  診療年月の開始位置誤り修正
      * 01.00.04     ひさなが     03/05/12  入院関連テーブルの追加
      * 01.00.05     ひさなが     03/05/21  診療年月設定時の判定順変更
      * 01.00.06     ひさなが     03/06/05  患者ＩＤ置換メッセージの追加
      * 03.05.01     NACL-森脇    07/06/11  グループ診療対応
      * 04.08.01     NACL-森脇    14/08/25  一時ファイルディレクトリ設定
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    ＣＳＶ作成条件用ファイル 
           SELECT  EIE00-FILE      ASSIGN  EIE00PARA
                                   FILE    STATUS  IS  STS-EIE00.
      *    ＣＳＶ作成条件１〜９０ファイル 
           SELECT  EIE01-FILE      ASSIGN  EIE01PARA
                                   FILE    STATUS  IS  STS-EIE01.
      *    ＣＳＶ１〜９０ファイル
           SELECT  EIECS-FILE      ASSIGN  EIECSPARA
                                   FILE    STATUS  IS  STS-EIECS.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    ＣＳＶ作成条件用ファイル
       FD  EIE00-FILE.
       01  EIE00-REC               PIC X(50). 
      *    ＣＳＶ作成条件１〜９０ファイル 
       FD  EIE01-FILE.
       01  EIE01-REC               PIC X(250).
      *    ＣＳＶ１〜９０ファイル
       FD  EIECS-FILE.
       01  EIECS-REC               PIC X(1). 
      *
      *
       WORKING-STORAGE             SECTION.
      *
       COPY    "COMMON-SPA".
      *
      *----(04.08.01)--UPD-START---
      *    ＣＳＶ作成条件用ファイル 名称領域 
grpsys*DD  COPY    "CPCOMMONDAT4.INC"
grpsys*DD                          REPLACING  //ORCGD//
grpsys     COPY    "CPCOMMONDAT2.INC"
grpsys                             REPLACING  //RECE01//
grpsys                             BY         //EIE00//.
grpsys*     03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    ＣＳＶ作成条件１〜９０ファイル 名称領域 
grpsys*DD  COPY    "CPCOMMONDAT4.INC"
grpsys*DD                          REPLACING  //ORCGD//
grpsys*DD                          BY         //EIE01//.
grpsys     COPY    "CPCOMMONDAT2.INC"
grpsys                             REPLACING  //RECE01//
grpsys                             BY         //EIE01//.
grpsys*     03  EIE01PARA-FILE      PIC X(23).
      *----(04.08.01)--UPD-END-----
      *
      *    ＣＳＶ１〜９０ファイル 名称領域 
       01  EIECSPARA.
           03  EIECSPARA-FILE-ID   PIC X(128).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-CHANGE          PIC 9(01).
      *
      *    エンドステータス領域
       01  STS-AREA.
           03  STS-EIE00           PIC X(02).
           03  STS-EIE01           PIC X(02).
           03  STS-EIECS           PIC X(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(03).
           03  IDX2                PIC 9(03).
           03  IDX3                PIC 9(05).
           03  IDX4                PIC 9(05).
           03  IDX5                PIC 9(05).
           03  IDX6                PIC 9(03).
           03  IDX7                PIC 9(03).
           03  IDX8                PIC 9(03).
           03  IDX9                PIC 9(05).
           03  IDXA                PIC 9(05).
           03  IDXB                PIC 9(05).
           03  IDXP                PIC 9(05).
      *
      *    編集作業
       01  W-AREA.
           03  WK-EIECS-REC            PIC  X(51000).
           03  WK-HEADER-REC           PIC  X(51000).
           03  WRK-PARA.
               05  WRK-PARA-SRYYM      PIC  X(06).
               05  WRK-PARA-TERMID     PIC  X(64).
               05  WRK-PARA-SYSYMD     PIC  X(08).
               05  WRK-PARA-SYOKBN     PIC  X(01).
               05  WRK-PARA-RECEKBN    PIC  X(01).
grpsys         05  WRK-PARA-HOSPNUM    PIC  9(02).
           03  WK-SRYYM                PIC  X(06).
           03  WK-PATHNAME             PIC  X(64).
           03  WK-TABLE                PIC  X(64).
           03  WK-TYPE                 PIC  X(10).
           03  WK-SPACE                PIC  X(01).
           03  WK-STPNT                PIC  9(06).
           03  WK-KTPNT                PIC  9(05).
           03  WK-PTPNT                PIC  9(05).
           03  WK-SRYYM-S              PIC  9(06).
           03  WK-SRYYM-L              PIC  9(06).
           03  WK-HOSPID-S             PIC  9(06).
           03  WK-HOSPID-L             PIC  9(06).
           03  WK-PTID-C               PIC  9(06).
           03  WK-PTID-S               PIC  9(06).
           03  WK-PTID-SL              PIC  9(06).
           03  WK-PTID-L               PIC  9(06).
           03  WK-PTID-K               PIC  X(01).
           03  WRK-SNUM-G.
               05  WRK-SNUM            PIC  S9(18).
           03  WRK-NUM-G.
               05  WRK-NUM             PIC  9(18).
           03  WRK-INT-G.
               05  WRK-INT             PIC  S9(09) BINARY.
           03  WRK-STR                 PIC  X(20).
           03  WRK-SIGN                PIC  X(1).
           03  WRK-SEISU               PIC  9(03).
      *
      *    作業テーブル名称領域
       01  WK-TBL1.
      *修正/*開始*03.06.05*********************************************
           03  WK-TBL-CHKBTN01         PIC X(01).
           03  WK-TBL-CHKMSG02         PIC X(06).
           03  WK-TBL-CHKPTMUM         PIC X(05).
           03  WK-TBL-SYSYMD           PIC X(08).
      *修正/*終了*03.06.05*********************************************
           03  WK-TBLSET       OCCURS  200.
               05  WK-TBL-MSG          PIC X(20).
               05  WK-TBL-KBN1         PIC X(01).
               05  WK-TBL-KBN2         PIC X(01).
               05  WK-TBL-NAME         PIC X(20).
       01  WK-TBL2.
           03  WK-TBLRET       OCCURS  900.
               05  WK-TBL-RMSG.
                   07  WK-TBL-RMSG-ID.
                       09  WK-TBL-RMSG-1   PIC X(01).
                       09  WK-TBL-RMSG-2   PIC X(29).
                   07  WK-TBL-RMSG-3   PIC X(07).
                   07  WK-TBL-RMSG-4   PIC X(13).
                   07  WK-TBL-RMSG-5   PIC X(05).
                   07  WK-TBL-RMSG-6   PIC X(05).
                   07  WK-TBL-RMSG-7   PIC X(05).
                   07  WK-TBL-RMSG-8   PIC X(05).
                   07  WK-TBL-RMSG-9   PIC X(06).
                   07  WK-TBL-RMSG-10  PIC X(52).
      *
      *    シェル用領域
           COPY    "CPSHELLTBL.INC".
      *
      *----(04.08.01)--ADD-START---
           COPY    "CPORCSGETTEMP.INC".
      *----(04.08.01)--ADD-END-----
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
      *修正/*開始*03.06.05*********************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1009.INC".
      *
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *修正/*終了*03.06.05*********************************************
      *    連絡
           COPY    "MCPDATA.INC".
      *
      *     テーブルアクセス
           COPY    "MCPAREA".
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
        LINKAGE                     SECTION.
      *
        01  COMMAND-PARAM.
            02  FILLSE              PIC X(256).
      *
      *
       PROCEDURE                   DIVISION    USING
                                               COMMAND-PARAM.
      *****************************************************************
      *    主    処    理
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *    ＤＢ　 オープン処理
           PERFORM 000-DBOPEN-SEC.
      *    ＣＳＶ作成条件 入力処理
           PERFORM T-000-CHEKCHEK-SEC.
      *    ＣＳＶ作成処理
           PERFORM T-000-CSVSAKUS-SEC.
      *    ＤＢ　 クローズ処理
           PERFORM 000-DBCLOSE-SEC.
       000-PROC-SEC-EXT.
           STOP    RUN.
      *
      *****************************************************************
      *    ＤＢ　 オープン処理
      *****************************************************************
       000-DBOPEN-SEC                  SECTION.
      *
           DISPLAY "e03START-------------------"
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA.
      *
       000-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　 クローズ処理
      *****************************************************************
       000-DBCLOSE-SEC                 SECTION.
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
      *
           MOVE    LOW-VALUE           TO  MCP-TABLE
                                           MCP-PATHNAME
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA.
      *
       000-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＳＶ作成条件 入力処理
      *****************************************************************
       T-000-CHEKCHEK-SEC              SECTION.
      *
grpsys     INITIALIZE                  SPA-AREA
           MOVE    COMMAND-PARAM   TO  WRK-PARA.
grpsys     MOVE    WRK-PARA-HOSPNUM    TO  SPA-HOSPNUM
grpsys*DD  MOVE    "ORCE00.CNV"    TO  EIE00PARA-FILE
grpsys     MOVE    "ORCGE00"         TO  EIE00PARA-FILE-ID.
grpsys     MOVE    SPA-HOSPNUM       TO  EIE00PARA-HOSPNUM.
grpsys     MOVE    WRK-PARA-TERMID   TO  EIE00PARA-TERMID.
      *----(04.08.01)--ADD-START---
           INITIALIZE                      SGETTEMP-AREA
           MOVE    EIE00PARA-BASENAME
                                       TO  SGETTEMP-BASENAME
           CALL    "ORCSGETTEMP"       USING
                                       SGETTEMP-AREA
           MOVE    ALL SPACE           TO  EIE00PARA-FULLNAME
           STRING  SGETTEMP-FULLNAME   DELIMITED  BY    SPACE
                   ".dat"              DELIMITED  BY    SIZE
                                       INTO       EIE00PARA-FULLNAME
           END-STRING.
      *----(04.08.01)--ADD-END-----
      *
           MOVE    SPACE           TO  WK-TBL1.
           MOVE    1               TO  IDX1.
      *
           OPEN    INPUT               EIE00-FILE.
      *
           IF  STS-EIE00   =   ZERO
      *修正/*開始*03.06.05*********************************************
               READ    EIE00-FILE
                 AT   END
                   MOVE    201              TO  IDX1
                 NOT  AT  END
                   IF  (EIE00-REC(3:6)   =   "する  ")  OR
                       (EIE00-REC(3:6)   =   "しない")
                       MOVE    EIE00-REC(1:1)  TO  WK-TBL-CHKBTN01
                       MOVE    EIE00-REC(3:6)  TO  WK-TBL-CHKMSG02
                       MOVE    EIE00-REC(10:5) TO  WK-TBL-CHKPTMUM
                       MOVE    EIE00-REC(16:8) TO  WK-TBL-SYSYMD
                   ELSE
                       MOVE    EIE00-REC(1:20)   TO  WK-TBL-MSG (IDX1)
                       MOVE    EIE00-REC(22:1)   TO  WK-TBL-KBN1 (IDX1)
                       MOVE    EIE00-REC(24:1)   TO  WK-TBL-KBN2 (IDX1)
                       MOVE    EIE00-REC(26:20)  TO  WK-TBL-NAME (IDX1)
                       COMPUTE  IDX1   =   IDX1   +   1
                   END-IF
               END-READ
      *修正/*終了*03.06.05*********************************************
               PERFORM UNTIL   IDX1  >    200
                   READ  EIE00-FILE
                     AT   END
                       MOVE    201       TO  IDX1
                     NOT  AT  END
                       MOVE    EIE00-REC(1:20)   TO  WK-TBL-MSG (IDX1)
                       MOVE    EIE00-REC(22:1)   TO  WK-TBL-KBN1 (IDX1)
                       MOVE    EIE00-REC(24:1)   TO  WK-TBL-KBN2 (IDX1)
                       MOVE    EIE00-REC(26:20)  TO  WK-TBL-NAME (IDX1)
                       COMPUTE  IDX1   =   IDX1   +   1
                   END-READ
               END-PERFORM
               CLOSE                       EIE00-FILE
           END-IF.
      *
      *修正/*開始*03.06.05*********************************************
           MOVE    SPACE               TO  SYS-1009-REC.
           MOVE    "1009"              TO  SYS-1009-KANRICD.
           MOVE    WK-TBL-SYSYMD       TO  SYS-1009-STYUKYMD
                                           SYS-1009-EDYUKYMD
      *    システム管理検索
           MOVE    SPA-HOSPNUM         TO  SYS-1009-HOSPNUM
           MOVE    SYS-1009-REC        TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               CALL    "ORCDBMAIN"         USING
                                               MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
               MOVE    MCPDATA-REC         TO  SYS-1009-REC
           ELSE
               INITIALIZE                  SYS-1009-REC
           END-IF.
      *
           INITIALIZE              MCPAREA.
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC.
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"     USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA.
      *修正/*終了*03.06.05*********************************************
      *
       T-000-CHEKCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＳＶ 作成処理
      *****************************************************************
       T-000-CSVSAKUS-SEC              SECTION.
      *
           PERFORM VARYING IDX2  FROM  1  BY 1
                   UNTIL   IDX2  >    201
               IF  (WK-TBL-KBN1 (IDX2)    =   "*")  AND
                   (WK-TBL-KBN2 (IDX2)    =   "*")
                       PERFORM T-001-CSVWRITE-SEC
               END-IF
           END-PERFORM.
      *
       T-000-CSVSAKUS-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＣＳＶ 出力処理
      *****************************************************************
       T-001-CSVWRITE-SEC              SECTION.
      *
grpsys     MOVE    "ORCGE01"         TO  EIE01PARA-FILE-ID.
grpsys     MOVE    SPA-HOSPNUM       TO  EIE01PARA-HOSPNUM.
grpsys     MOVE    WRK-PARA-TERMID   TO  EIE01PARA-TERMID.
      *----(04.08.01)--ADD-START---
           INITIALIZE                      SGETTEMP-AREA
           MOVE    EIE01PARA-BASENAME
                                       TO  SGETTEMP-BASENAME
           CALL    "ORCSGETTEMP"       USING
                                       SGETTEMP-AREA
           MOVE    ALL SPACE           TO  EIE01PARA-FULLNAME
           STRING  SGETTEMP-FULLNAME   DELIMITED  BY    SPACE
                   WK-TBL-MSG (IDX2)   DELIMITED  BY    SPACE
                   ".SLT"              DELIMITED  BY    SIZE
                                       INTO       EIE01PARA-FULLNAME
           END-STRING.
      *----(04.08.01)--ADD-END-----
      *----(04.08.01)--UPD-START---
      *     MOVE    ALL SPACE           TO  EIE01PARA-FILE.
      *     STRING  WK-TBL-MSG (IDX2)   DELIMITED  BY    SPACE
      *             ".SLT"              DELIMITED  BY    SIZE
      *                                 INTO       EIE01PARA-FILE.
      *----(04.08.01)--UPD-END-----
           MOVE    SPACE               TO  EIECSPARA-FILE-ID.
           MOVE    SPACE               TO  WK-TABLE.
           MOVE    SPACE               TO  WK-PATHNAME.
           MOVE    SPACE               TO  WK-SRYYM.
           MOVE    SPACE               TO  WK-TBL2.
           MOVE    ZERO                TO  FLG-END.
           MOVE    ZERO                TO  IDX1.
      *修正/*開始*03.06.05*********************************************
           MOVE    ZERO                TO  WK-HOSPID-S.
           MOVE    ZERO                TO  WK-HOSPID-L.
           MOVE    ZERO                TO  WK-PTID-C.
           MOVE    SPACE               TO  WK-PTID-K.
           INITIALIZE                  PTNUM-REC.
      *修正/*終了*03.06.05*********************************************
      *
           OPEN    INPUT               EIE01-FILE.
      *
           IF  STS-EIE01   =   ZERO
               READ    EIE01-FILE
                 NOT  AT  END
                   MOVE    EIE01-REC(1:6)    TO  WK-SRYYM
                   MOVE    EIE01-REC(8:128)  TO  EIECSPARA-FILE-ID
                   MOVE    WK-TBL-NAME(IDX2) TO  WK-TABLE
                   MOVE    "all"             TO  WK-PATHNAME
                   EVALUATE    WK-TABLE
                   WHEN    "tbl_jyurrk_prv"
                       MOVE    "all3"        TO  WK-PATHNAME
                   WHEN    "tbl_tsyrrk"
                       MOVE    "all2"        TO  WK-PATHNAME
                   END-EVALUATE
                   PERFORM UNTIL   FLG-END   NOT  =  ZERO
                       READ    EIE01-FILE
                         AT   END
                           MOVE    1      TO  FLG-END
                         NOT  AT  END
                           EVALUATE    EIE01-REC(1:8)
                               WHEN    "SRYYM***"
                                   MOVE    EIE01-REC(71:6)
                                                 TO  WK-SRYYM-S
                                   COMPUTE WK-SRYYM-L  =  WK-SRYYM-S
                                                                  +  6
      *修正/*開始*03.06.05*********************************************
grpsys*DD                      WHEN    "HOSPNUM*"
grpsys*DD                          MOVE    EIE01-REC(71:6)
grpsys*DD                                        TO  WK-HOSPID-S
grpsys*DD                          MOVE    EIE01-REC(51:5)
grpsys*DD                                        TO  WK-HOSPID-L(2:5)
      *修正/*終了*03.06.05*********************************************
                               WHEN    OTHER
                                   COMPUTE IDX1  =  IDX1  +  1
                                   MOVE    EIE01-REC
                                                 TO  WK-TBL-RMSG (IDX1)
                           END-EVALUATE
                       END-READ
                   END-PERFORM
               END-READ
      *
               CLOSE                       EIE01-FILE
               OPEN    OUTPUT              EIECS-FILE
      *
               MOVE    1             TO  FLG-CHANGE
               PERFORM VARYING IDXA      FROM  1   BY  1
                       UNTIL ( IDXA      >     900 )
                        OR   ( WK-TBL-RMSG (IDXA)   =   SPACE )
                        OR   ( FLG-CHANGE           =   ZERO )
      *
                   IF ( WK-TBL-RMSG-ID (IDXA)       =   "PTNUM" )
                       MOVE    ZERO  TO  FLG-CHANGE
                   END-IF
      *
               END-PERFORM
      *
               MOVE    1               TO  IDXB
               MOVE    SPACE           TO  WK-HEADER-REC
               PERFORM VARYING IDXA      FROM  1   BY  1
                       UNTIL ( IDXA      >     900 )
                        OR   ( WK-TBL-RMSG (IDXA)   =   SPACE )
      *
                   IF    ( IDXA        >   1 )
                       STRING  ","     DELIMITED BY  SIZE
                       INTO    WK-HEADER-REC
                       WITH    POINTER IDXB
                       END-STRING
                   END-IF
      *
                   IF  (WK-TBL-CHKBTN01            =   "T")   AND
                       (FLG-CHANGE                 =   1  )  AND
                       (WK-TBL-RMSG-ID (IDXA)      =   "PTID")
      *
                       STRING  "PTNUM"            DELIMITED BY  SPACE
                       INTO    WK-HEADER-REC
                       WITH    POINTER IDXB
                       END-STRING
                   ELSE
                       STRING  WK-TBL-RMSG-ID (IDXA) DELIMITED BY SPACE
                       INTO    WK-HEADER-REC
                       WITH    POINTER IDXB
                       END-STRING
                   END-IF
      *
               END-PERFORM
      *
               PERFORM VARYING IDX5   FROM   1   BY   1
                       UNTIL   IDX5   >=  IDXB
                   MOVE    WK-HEADER-REC(IDX5:1)  TO  EIECS-REC
                   WRITE   EIECS-REC
               END-PERFORM
      *
               MOVE    X"0A"          TO   EIECS-REC
               WRITE   EIECS-REC
      *
      *         MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
               MOVE    SPACE           TO  MCPDATA-REC
               MOVE    SPA-HOSPNUM     TO  MCPDATA-REC(1:2)
               IF  WK-SRYYM   NOT =   SPACE
                   PERFORM T-001-SRYYMSET-01-SEC
               END-IF
               MOVE    "DBSELECT"      TO  MCP-FUNC
               MOVE    WK-TABLE        TO  MCP-TABLE
               MOVE    WK-PATHNAME     TO  MCP-PATHNAME
               CALL    "ORCDBMAIN"     USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
      *
               IF  MCP-RC   =   ZERO
                   PERFORM T-001-TBLFETCH-01-SEC
                   PERFORM UNTIL      MCP-RC   NOT  =  ZERO
                       MOVE    SPACE               TO  WK-EIECS-REC
                       MOVE    1                   TO  IDX4
                       PERFORM T-001-TBLCNVAT-01-SEC
                               VARYING IDX1  FROM  1  BY 1
                               UNTIL   IDX1  >   900
                       PERFORM T-001-WRITWRIT-01-SEC
                       PERFORM T-001-TBLFETCH-01-SEC
                   END-PERFORM
               END-IF
      *
               INITIALIZE              MCPAREA
               MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
               MOVE    WK-TABLE        TO  MCP-TABLE
               MOVE    WK-PATHNAME     TO  MCP-PATHNAME
               CALL    "ORCDBMAIN"     USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
      *
               CLOSE                       EIECS-FILE
           END-IF.
      *
       T-001-CSVWRITE-EXT.
           EXIT.
      *
      **********************
      *
       T-001-SRYYMSET-01-SEC             SECTION.
      *
           EVALUATE    WK-TBL-MSG (IDX2)
               WHEN    "JYURRK    "
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
                   MOVE    "%"             TO  MCPDATA-REC(WK-SRYYM-L:1)
               WHEN    "PTBYOMEI  "
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
                   MOVE    "%"             TO  MCPDATA-REC(WK-SRYYM-L:1)
               WHEN    "SRYACCT_MAIN"
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
               WHEN    "SRYACT    "
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
               WHEN    "WKSRYACT  "
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
                   MOVE    "%"             TO  MCPDATA-REC(WK-SRYYM-L:1)
               WHEN    "SANTEI    "
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
               WHEN    "SEIKYU_MAIN"
               WHEN    "SEIKYU_ETC"
               WHEN    "SEIKYU_KOH"
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
               WHEN    "BD002     "
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
                   MOVE    "%"             TO  MCPDATA-REC(53:1)
      *修正/*開始*03.05.12*********************************************
               WHEN    "NYUINACCT "
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
               WHEN    "NYUINACT  "
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
               WHEN    "PTTEIKIRRK"
                   MOVE    "all2"          TO  WK-PATHNAME
grpsys*             MOVE    SPA-HOSPNUM     TO  WK-HOSPNUM
                   MOVE    WK-SRYYM        TO  MCPDATA-REC(WK-SRYYM-S:6)
      *修正/*終了*03.05.12*********************************************
           END-EVALUATE.
      *
       T-001-SRYYMSET-01-EXT.
           EXIT.
      *
      **********************
      *
       T-001-TBLFETCH-01-SEC             SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           MOVE    WK-TABLE            TO  MCP-TABLE
           MOVE    WK-PATHNAME         TO  MCP-PATHNAME
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
           .
      *
       T-001-TBLFETCH-01-EXT.
           EXIT.
      *
      **********************
      *
       T-001-TBLCNVAT-01-SEC             SECTION.
      *
           IF  WK-TBL-RMSG (IDX1)   =   SPACE
               MOVE    901                         TO  IDX1
           ELSE
               PERFORM T-001-TBLCNVAT-02-SEC
           END-IF.
      *
       T-001-TBLCNVAT-01-EXT.
           EXIT.
      *
      **********************
      *
       T-001-TBLCNVAT-02-SEC             SECTION.
      *
           MOVE    WK-TBL-RMSG-9 (IDX1)        TO  WK-STPNT.
           MOVE    WK-TBL-RMSG-5 (IDX1)        TO  WK-KTPNT.
           MOVE    WK-TBL-RMSG-7 (IDX1)        TO  WK-PTPNT.
      *修正/*開始*03.06.05*********************************************
           IF  (FLG-CHANGE               =   1      )  AND
               (WK-TBL-RMSG-ID (IDX1)    =   "PTID")
               MOVE    IDX4                        TO  WK-PTID-C
               MOVE    WK-TBL-RMSG-9 (IDX1)        TO  WK-PTID-S
               MOVE    WK-TBL-RMSG-5 (IDX1)        TO  WK-PTID-L
               MOVE    "*"                         TO  WK-PTID-K
           END-IF.
      *修正/*終了*03.05.12*********************************************
           IF  WK-TBL-RMSG-3 (IDX1)   =   "char   "
               MOVE    MCPDATA-REC(WK-STPNT:WK-KTPNT)
                             TO  WK-EIECS-REC(IDX4:WK-KTPNT)
               COMPUTE       IDX4 = IDX4 + WK-KTPNT
               MOVE    ","   TO  WK-EIECS-REC(IDX4:1)
               COMPUTE       IDX4 = IDX4 + 1
           ELSE
               IF  WK-TBL-RMSG-3 (IDX1)   =   "number " OR "integer"
                   MOVE    ZERO           TO  WRK-SNUM-G
                   IF    ( WK-TBL-RMSG-3 (IDX1)   =   "number " )
                       MOVE    MCPDATA-REC(WK-STPNT:WK-KTPNT)
                           TO  WRK-SNUM-G (19 - WK-KTPNT : WK-KTPNT )
                   ELSE
                       MOVE    MCPDATA-REC(WK-STPNT:WK-KTPNT)
                           TO  WRK-INT-G
                       MOVE    WRK-INT    TO  WRK-SNUM
                       MOVE    9          TO  WK-KTPNT
                   END-IF
                   MOVE    SPACE  TO  WRK-STR
                   MOVE    SPACE  TO  WRK-SIGN
                   MOVE    ZERO   TO  WRK-NUM-G
                   MOVE    1      TO  IDXP
                   IF    ( WRK-SNUM   >=   ZERO )
                       COMPUTE WRK-NUM =   WRK-SNUM
                   ELSE
                       COMPUTE WRK-NUM =   WRK-SNUM * -1
                       MOVE    "-"     TO  WRK-SIGN
                   END-IF
                   IF  WK-PTPNT   =   ZERO
                       STRING  WRK-SIGN     DELIMITED BY SPACE
                               WRK-NUM-G (19 - WK-KTPNT : WK-KTPNT)
                                            DELIMITED BY SIZE
                       INTO    WRK-STR
                       WITH    POINTER IDXP
                       END-STRING
                   ELSE
                       COMPUTE WRK-SEISU = WK-KTPNT - WK-PTPNT
                       STRING  WRK-SIGN     DELIMITED BY SPACE
                               WRK-NUM-G (19 - WK-KTPNT : WRK-SEISU )
                                            DELIMITED BY SIZE
                               "."          DELIMITED BY SIZE
                               WRK-NUM-G (19 - WK-PTPNT : WK-PTPNT )
                       INTO    WRK-STR
                       WITH    POINTER IDXP
                       END-STRING
                   END-IF
      *
                   COMPUTE IDXP    =   IDXP    -   1
                   MOVE    WRK-STR (1 : IDXP)
                                     TO  WK-EIECS-REC(IDX4:IDXP)
                   COMPUTE       IDX4 = IDX4 + IDXP
                   MOVE    ","   TO  WK-EIECS-REC(IDX4:1)
                   COMPUTE       IDX4 = IDX4 + 1
      *
               ELSE
                   IF  WK-TBL-RMSG-3 (IDX1)   =   "varchar"
                       MOVE    MCPDATA-REC(WK-STPNT:WK-KTPNT)
                                       TO  WK-EIECS-REC(IDX4:WK-KTPNT)
                       MOVE    SPACE   TO  WK-SPACE
                       MOVE    IDX4    TO  IDX7
                       COMPUTE       IDX4 = IDX4 + WK-KTPNT
                       PERFORM UNTIL   WK-SPACE  =   "*"
                           IF  WK-EIECS-REC(IDX4:1)   =   SPACE
                               COMPUTE       IDX4 = IDX4 - 1
                           ELSE
                               COMPUTE       IDX8 = IDX4 - 1
                               IF  WK-EIECS-REC(IDX8:2)   =   "　"
                                   COMPUTE       IDX4 = IDX4 - 2
                               ELSE
                                   MOVE    "*"   TO  WK-SPACE
                                   COMPUTE       IDX4 = IDX4 + 1
                               END-IF
                           END-IF
                           IF  IDX4   <   IDX7
                               MOVE    IDX7   TO  IDX4
                               MOVE    "*"    TO  WK-SPACE
                           END-IF
                       END-PERFORM
                       MOVE    ","   TO  WK-EIECS-REC(IDX4:1)
                       COMPUTE       IDX4 = IDX4 + 1
                   END-IF
               END-IF
           END-IF.
      *
       T-001-TBLCNVAT-02-EXT.
           EXIT.
      *
       T-001-WRITWRIT-01-SEC             SECTION.
      *
           COMPUTE       IDX4 = IDX4 - 1.
           MOVE    X"0A"                TO  WK-EIECS-REC(IDX4:1).
      *
      *修正/*開始*03.05.12*********************************************
grpsys*DD  IF  (WK-TBL-CHKBTN01               =   "T")   AND
grpsys*DD      (WK-PTID-K                     =   "*")   AND
grpsys*DD      (WK-HOSPID-S               NOT =   ZERO)  AND
grpsys*DD      (WK-HOSPID-L               NOT =   ZERO)
grpsys     IF  (WK-TBL-CHKBTN01               =   "T")   AND
grpsys         (WK-PTID-K                     =   "*")
               COMPUTE       IDX9  =  WK-PTID-C  -  1
               PERFORM VARYING IDX5   FROM   1   BY   1
                       UNTIL   IDX5   >   IDX9
                   MOVE    WK-EIECS-REC(IDX5:1)    TO  EIECS-REC
                   WRITE   EIECS-REC
               END-PERFORM
      *
               MOVE    WK-PTID-L               TO  WK-PTID-SL
               EVALUATE    SYS-1009-PTNUMKSIKBN
                   WHEN    "1"
                       COMPUTE       WK-PTID-SL  =  WK-PTID-L
                                            -  SYS-1009-JIYKSIKETA
                   WHEN    "2"
                       COMPUTE       WK-PTID-SL  =  WK-PTID-L
                                            -  SYS-1009-HJNKSIRENNUMKETA
                   WHEN    "3"
                       COMPUTE       WK-PTID-SL  =  WK-PTID-L
                                            -  SYS-1009-KKCKSIATOKETA
               END-EVALUATE
      *
               INITIALIZE                  PTNUM-REC
      *         IF  ((MCPDATA-REC(WK-HOSPID-S:WK-HOSPID-L)
      *                                        NOT =   PTNUM-HOSPID)  OR
      *              (MCPDATA-REC(WK-PTID-S:WK-PTID-L)
      *                                        NOT =   PTNUM-PTID))  AND
      *         IF   (MCPDATA-REC(WK-PTID-S:WK-PTID-L)
      *                                         NOT =   PTNUM-PTID)  AND
      *             (MCPDATA-REC(WK-PTID-S:WK-PTID-SL)    =   ZERO)
      *             MOVE    MCPDATA-REC(WK-HOSPID-S:WK-HOSPID-L)
      *                                         TO  PTNUM-HOSPID
                   MOVE    MCPDATA-REC(WK-PTID-S:WK-PTID-L)
                                               TO  PTNUM-PTID
      *
                   MOVE    SPA-HOSPNUM         TO  PTNUM-HOSPNUM
                   MOVE    PTNUM-REC           TO  MCPDATA-REC
                   MOVE    "DBSELECT"          TO  MCP-FUNC
                   MOVE    "tbl_ptnum"         TO  MCP-TABLE
                   MOVE    "key"               TO  MCP-PATHNAME
                   CALL    "ORCDBMAIN"         USING
                                                   MCPAREA
                                                   MCPDATA-REC
                                                   SPA-AREA
      *
                   IF  MCP-RC    =   ZERO
                       MOVE    "DBFETCH"           TO  MCP-FUNC
                       MOVE    "tbl_ptnum"         TO  MCP-TABLE
                       MOVE    "key"               TO  MCP-PATHNAME
                       CALL    "ORCDBMAIN"         USING
                                                       MCPAREA
                                                       MCPDATA-REC
                                                       SPA-AREA
                       IF  MCP-RC    =   ZERO
                           MOVE    MCPDATA-REC         TO  PTNUM-REC
                       END-IF
                   END-IF
      *
                   INITIALIZE                  MCPAREA
                   MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
                   MOVE    "tbl_ptnum"         TO  MCP-TABLE
                   MOVE    "key"               TO  MCP-PATHNAME
                   CALL    "ORCDBMAIN"         USING
                                                   MCPAREA
                                                   MCPDATA-REC
                                                   SPA-AREA
      *         END-IF
      *
               MOVE    WK-TBL-CHKPTMUM         TO  WK-KTPNT
               PERFORM VARYING IDX5   FROM   1   BY   1
                       UNTIL   IDX5   >   WK-KTPNT
                   MOVE    PTNUM-PTNUM(IDX5:1)     TO  EIECS-REC
                   WRITE   EIECS-REC
               END-PERFORM
      *
               COMPUTE       IDX9 = WK-PTID-C + WK-PTID-L
               PERFORM VARYING IDX5   FROM   IDX9   BY   1
                       UNTIL   IDX5   >   IDX4
                   MOVE    WK-EIECS-REC(IDX5:1)    TO  EIECS-REC
                   WRITE   EIECS-REC
               END-PERFORM
      *修正/*終了*03.05.12*********************************************
           ELSE
               PERFORM VARYING IDX5   FROM   1   BY   1
                       UNTIL   IDX5   >   IDX4
                   MOVE    WK-EIECS-REC(IDX5:1)    TO  EIECS-REC
                   WRITE   EIECS-REC
               END-PERFORM
           END-IF.
      *
       T-001-WRITWRIT-01-EXT.
           EXIT.
      *
