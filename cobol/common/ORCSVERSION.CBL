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
       PROGRAM-ID.             ORCSVERSION.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : システムバージョン取得
      *  管理者            : 
      *  作成日付    作業者        記述
      *  06/07/14    NACL−太田    新規作成
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
           SELECT  IN01-FILE       ASSIGN   IN01PARA
                                   ORGANIZATION    IS  LINE SEQUENTIAL.
       
      *
       DATA                        DIVISION.
       FILE                        SECTION.
       FD  IN01-FILE.
       01  IN01-REC                PIC X(1000).
      *
       WORKING-STORAGE             SECTION.
      *
       01  IN01PARA                PIC X(1000).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-IN01            PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX1                PIC 9(05).
           03  IDX-DATA            PIC 9(05).
      *
       01  CNT-AREA.
           03  CNT-VERSION         PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-VERSION         PIC X(64).
           03  WRK-DATA            PIC X(1000).
           03  WRK-FIL             PIC X(1000).
      *
       01  CONST-AREA.
           03  CONST-MAXLEN        PIC 9(05)   VALUE   1000.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSVERSION.INC".
      *
       PROCEDURE                   DIVISION    USING
           SVERSION-AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
           MOVE    WRK-VERSION     TO  SVERSION-VERSION
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE              ORCSMKPASSAREA
           MOVE    "doc/version"   TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  IN01PARA
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           OPEN    INPUT   IN01-FILE
           MOVE    SPACE       TO  WRK-VERSION
      *
           PERFORM 900-IN01-READ-SEC
      *
           PERFORM UNTIL ( FLG-IN01    NOT =   ZERO )
                    OR   ( WRK-VERSION NOT =   SPACE )
      *
               MOVE    ZERO    TO  CNT-VERSION
               INSPECT IN01-REC    TALLYING
                       CNT-VERSION FOR ALL "version"
               IF    ( CNT-VERSION     >   ZERO )
                   PERFORM 2001-GET-VERSION-SEC
               END-IF
      *
               PERFORM 900-IN01-READ-SEC
      *
           END-PERFORM
      *
           CLOSE   IN01-FILE
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    システムバージョン取得処理
      *****************************************************************
       2001-GET-VERSION-SEC            SECTION.
      *
           MOVE    SPACE           TO  WRK-DATA
           MOVE    ZERO            TO  IDX-DATA
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   CONST-MAXLEN )
                    OR   ( IN01-REC (IDX1 : )  =   SPACE )
      *
               IF    ( IN01-REC (IDX1 : 1) NOT =   SPACE )
                   COMPUTE IDX-DATA    =   IDX-DATA    +   1
      *
                   MOVE    IN01-REC (IDX1 : 1)
                                   TO  WRK-DATA (IDX-DATA : 1)
      *
               END-IF
      *
           END-PERFORM
      *
           UNSTRING    WRK-DATA    DELIMITED   BY  "(" OR ")"
                                   INTO    WRK-FIL
                                           WRK-VERSION
           END-UNSTRING
      *
           .
       2001-GET-VERSION-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       900-IN01-READ-SEC               SECTION.
      *
           MOVE    ZERO            TO  FLG-IN01
           READ    IN01-FILE
           AT  END
               MOVE    1           TO  FLG-IN01
           END-READ
      *
           .
       900-IN01-READ-EXT.
           EXIT.
