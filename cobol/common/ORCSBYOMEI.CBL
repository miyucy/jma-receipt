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
       PROGRAM-ID.             ORCSBYOMEI.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 病名コード検索処理
      *  管理者            : 
      *  03/12/01    NACL−藤原    新規作成
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-BYOMEI          PIC 9(01).
      *
           03  FLG-KENSAKU         PIC 9(01).
           03  FLG-HENSYU          PIC 9(01).
           03  FLG-TBLERR          PIC 9(01).
           03  FLG-HENKAN-ERR      PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDW                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
      *
       01  WRK-AREA.
      *
           03  WRK-BYOMEICD-KENSAKU-AREA.
      *        病名コード数（修飾語以外）
               05  WRK-BYOMEICDSU      PIC 9(02).
      *        検索病名コード数
               05  WRK-BYOMEI-MAX      PIC 9(01).
      *        検索病名情報
               05  WRK-BYOMEI-FLG-TBL.         
      *            （）フラグ
                   07  WRK-BYOMEI-FLG  PIC X(01)
                                               OCCURS  40.
      *        検索病名情報
               05  WRK-BYOMEI-BYOMEICD-TBL     OCCURS  40.
      *            病名
                   07  WRK-BYOMEI-BYOMEI
                                       PIC X(200).
      *
                   07  WRK-BYOMEI-BYOMEICD-G   OCCURS  2.
      *                病名コード
                       09  WRK-BYOMEI-BYOMEICD 
                                       PIC X(07).    
      *                移行先コード
                       09  WRK-BYOMEI-IKOSAKICD 
                                       PIC X(07).
      *                廃止年月日
                       09  WRK-BYOMEI-HAISIYMD 
                                       PIC X(08).
      *                単独使用禁止区分
                       09  WRK-BYOMEI-TANDOKUKBN 
                                       PIC 9(02).
      *                特定疾患コード
                       09  WRK-BYOMEI-TOKSKNCD
                                       PIC 9(02).
      *                疑いフラグ
                       09  WRK-BYOMEI-UTAGAIFLG
                                       PIC X(01).
           03  WRK-KENSAKU-AREA.
               05  WRK-KEN-BYOMEI  PIC X(80).
               05  WRK-KEN-LENGTH  PIC 9(04).
               05  WRK-KEN-ADDKBN  PIC X(01).
               05  FLG-BUBUN       PIC 9(03).
           03  WRK-MOJISU          PIC 9(03).
           03  WRK-BUI-MAX         PIC 9(01).
      *
           03  WRK-BYOMEI          PIC X(200).                             
           03  WRK-DBPATH          PIC X(64).
           03  WRK-TANDOKUKBN      PIC X(01).
           03  WRK-KENBYOMEI       PIC X(02).
           03  WRK-LENGTH          PIC 9(03).
           03  WRK-ST              PIC 9(03).
           03  WRK-RECECD-TBL.
               05  WRK-RECECD      PIC X(01)   OCCURS  3.
      *
      *    固定値
       01  WRK-CONS-AREA.
      * 
      *    病名コードＭＡＸ
           03  WRK-CONS-BYOMEI-MAX PIC 9(02)   VALUE   21.
      *    
      *    ワーク病名
       01  WRK-BYOMEI-REC.
           COPY    "CPBYOMEI.INC"  REPLACING  //BYO-//
                                 BY         //WRK-BYO-//.
      *
      *    病名システム予約コードテーブル
           COPY    "CMBYOMEICD.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    病名
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSBYOMEI.INC".
      *****************************************************************
     *
       PROCEDURE                    DIVISION    USING
                                    ORCSBYOMEIAREA.
     *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPACE           TO  LNK-BYO-RC    
      *    処理区分により検索処理
           EVALUATE    LNK-BYO-SYORI
               WHEN    "1"
                   PERFORM 200-BYOMEI-SYORI-SEC
               WHEN    "2"
                   PERFORM 200-BYOMEICD-SYORI-SEC
               WHEN    OTHER
                   MOVE    "1"         TO  LNK-BYO-RC
                   GO  TO  000-PROC-EXT
           END-EVALUATE
      *
      *    検索コードより組み立て
           PERFORM 200-TBL-HENSYU-SEC
      *
      *    最大病名コード数以上検索したとき
      *****IF      WRK-BYOMEI-MAX  >   WRK-CONS-BYOMEI-MAX
           IF      FLG-TBLERR      =   1
               MOVE    1               TO  LNK-BYO-BYOMEICD-MAX-ERR  
               MOVE    "0000999"           TO  LNK-BYO-TBYOMEICD (1)
                                               LNK-BYO-KHNBYOMEICD
               MOVE    LNK-BYO-BYOMEI      TO  LNK-BYO-TBYOMEI   (1)
               MOVE    "1"                 TO  LNK-BYO-BYOMEIHENFLG
               MOVE    1                   TO  LNK-BYO-BYOMEICDSU
                                               LNK-BYO-BYOMEI-MAX
           END-IF
      *
      *    コードが検索できなかったとき（コード存在エラー以外）
           IF    ( LNK-BYO-BYOMEI-MAX  =   ZERO )
           AND   ( LNK-BYO-BYOMEICD-ERR   
                                   NOT =   "3"  )
               MOVE    "0000999"           TO  LNK-BYO-TBYOMEICD (1)
                                               LNK-BYO-KHNBYOMEICD
               MOVE    LNK-BYO-BYOMEI      TO  LNK-BYO-TBYOMEI   (1)
               MOVE    "1"                 TO  LNK-BYO-BYOMEIHENFLG
               MOVE    1                   TO  LNK-BYO-BYOMEICDSU
                                               LNK-BYO-BYOMEI-MAX
           END-IF
      *
      *    全てコードに変換できなかったとき
           IF      FLG-HENKAN-ERR      =   1
               INITIALIZE                  LNK-BYOMEICD-KENSAKU-AREA
      *
               MOVE    "0000999"           TO  LNK-BYO-TBYOMEICD (1)
               MOVE    LNK-BYO-BYOMEI      TO  LNK-BYO-TBYOMEI   (1)
               MOVE    "1"                 TO  LNK-BYO-BYOMEIHENFLG
               MOVE    1                   TO  LNK-BYO-BYOMEICDSU
                                               LNK-BYO-BYOMEI-MAX
           END-IF
      *
           IF      LNK-BYO-TBYOMEICD (1)   =   "0000999"
               MOVE    "0000999"           TO  LNK-BYO-KHNBYOMEICD
               MOVE    SPACE               TO  LNK-BYO-KHNBUICD (1)
                                               LNK-BYO-KHNBUICD (2)
                                               LNK-BYO-KHNBUICD (3)
           END-IF
      *
           IF      LNK-BYO-BYOMEICD-ERR
                                       =   "1" OR  "2" OR  "9"
               MOVE    "1"                 TO  LNK-BYO-BYOMEIHENFLG
           END-IF
      *
      *    病名コードから検索のとき病名編集
           IF    ( LNK-BYO-SYORI       =   "2" )
           AND   ( LNK-BYO-BYOMEICD-ERR
                                   NOT =   "3" )    
               MOVE    ZERO                TO  LNK-BYO-BYOMEIMOJI
               MOVE    LNK-BYO-TBYOMEI (1) TO  WRK-BYOMEI
               PERFORM VARYING IDX FROM    2   BY  1
                       UNTIL   IDX >       LNK-BYO-BYOMEI-MAX
                   STRING  WRK-BYOMEI          DELIMITED   BY  SPACE
                           LNK-BYO-TBYOMEI(IDX)
                                               DELIMITED   BY  SPACE
                                               INTO    WRK-BYOMEI
                   END-STRING
               END-PERFORM
      *
      *        半角チェック
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    WRK-BYOMEI          TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "2"
                   MOVE    KANACHK-OUT-INPUT   TO  LNK-BYO-BYOMEI
      *            病名文字数
                   IF      KANACHK-MAX     >   80
                       MOVE    2               TO  LNK-BYO-KANACHK-ERR
                   END-IF
                   COMPUTE LNK-BYO-BYOMEIMOJI  =   KANACHK-MAX /   2
               ELSE
                   MOVE    1                   TO  LNK-BYO-KANACHK-ERR
               END-IF
           END-IF
      *
      *    レセ電エラーフラグ（編集病名のとき）
           IF      LNK-BYO-BYOMEIHENFLG    =   "1"
               EVALUATE    LNK-BYO-SYUBYOFLG
                   WHEN    "1"
                       IF      LNK-BYO-BYOMEIMOJI  >   17
                           MOVE    "1"         TO  LNK-BYO-RECEDENFLG
                       END-IF
                   WHEN    SPACE
                       IF      LNK-BYO-BYOMEIMOJI  >   20
                           MOVE    "1"         TO  LNK-BYO-RECEDENFLG
                       END-IF
                   WHEN    OTHER
                       MOVE    4           TO  LNK-BYO-RC
               END-EVALUATE
           END-IF    
      *???
           DISPLAY "LNK=" LNK-BYOMEI-KENSAKU-AREA "#"
           DISPLAY "ERR=" LNK-BYOMEI-KENSAKU-ERR-AREA "#"
           DISPLAY "MAX=" LNK-BYO-BYOMEI-MAX "#"     
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       LNK-BYO-BYOMEI-MAX
             DISPLAY IDZ "=" LNK-BYO-BYOMEICD-G (IDZ) "#"     
           END-PERFORM
      *???
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *     
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       200-BYOMEI-SYORI-SEC       SECTION.
      *
      *    病名が空白のとき処理はしない
           IF      LNK-BYO-BYOMEI      =   SPACE
               MOVE    "2"         TO  LNK-BYO-RC
               GO  TO  200-BYOMEI-SYORI-EXT
           END-IF
      *
      *    半角チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI 
           MOVE    LNK-BYO-BYOMEI      TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
           AND     KANACHK-SYUBETU     =   "2"
               MOVE    KANACHK-OUT-INPUT   TO  LNK-BYO-BYOMEI
           ELSE
               MOVE    1                   TO  LNK-BYO-KANACHK-ERR
               GO  TO  200-BYOMEI-SYORI-EXT
           END-IF
      *
      *    文字数チェック
           IF      KANACHK-MAX         >   80
               MOVE    2                   TO  LNK-BYO-KANACHK-ERR
               GO  TO  200-BYOMEI-SYORI-EXT
           END-IF
      *    病名文字数
           COMPUTE LNK-BYO-BYOMEIMOJI  =   KANACHK-MAX     /   2 
      *
           MOVE    KANACHK-MAX         TO  WRK-MOJISU        
      *
           MOVE    ZERO                TO  IDY
      *    入力病名で検索
           MOVE    "BYOMEI-KEY4"       TO  WRK-DBPATH
           INITIALIZE                  BYOMEI-REC
           MOVE    LNK-BYO-BYOMEI      TO  BYO-BYOMEI
           PERFORM 2001-BYOMEICD-KENSAKU-SEC
           IF      FLG-BYOMEI          =   ZERO
               MOVE    1                   TO  FLG-HENSYU
               PERFORM 2002-BYOMEICD-HENSYU-SEC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF      IDY                 >   ZERO
               GO  TO  200-BYOMEI-SYORI-EXT
           END-IF
      *
      *    入力された病名で検索（前から短縮して検索）
           INITIALIZE                  WRK-BYOMEICD-KENSAKU-AREA
                                       WRK-KENSAKU-AREA
      *****COMPUTE IDY =   WRK-CONS-BYOMEI-MAX +   1
           MOVE    41                  TO  IDY
           MOVE    LNK-BYO-BYOMEI      TO  WRK-KEN-BYOMEI
           MOVE    WRK-MOJISU  TO  WRK-KEN-LENGTH
           MOVE    2                   TO  FLG-HENSYU
      *
           PERFORM             UNTIL   WRK-KEN-LENGTH  =  ZERO
               MOVE    ZERO                TO  WRK-KEN-ADDKBN
               PERFORM VARYING IDZ FROM    1   BY  2
                       UNTIL   IDZ >       WRK-KEN-LENGTH
                       OR      WRK-KEN-ADDKBN  =   1
      *            病名の検索
                   MOVE    "BYOMEI-KEY6"       TO  WRK-DBPATH
                   INITIALIZE                  BYOMEI-REC
                   COMPUTE IDX1    =   WRK-KEN-LENGTH  -   IDZ +   1
                   MOVE    WRK-KEN-BYOMEI(IDZ:IDX1)  
                                               TO  BYO-BYOMEI
                   PERFORM 2001-BYOMEICD-KENSAKU-SEC
                   IF      FLG-BYOMEI          =   ZERO
                       PERFORM 2002-BYOMEICD-HENSYU-SEC
                       IF      FLG-TBLERR          =   1
                           GO  TO  200-BYOMEI-SYORI-EXT
                       END-IF 
                   END-IF      
      *
                   MOVE    "DBCLOSE"           TO  MCP-FUNC
                   MOVE    WRK-DBPATH          TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
      *
                   IF      WRK-KEN-ADDKBN          =   1
                       MOVE    WRK-KEN-LENGTH  TO  IDZ
                       COMPUTE WRK-KEN-LENGTH  =   WRK-KEN-LENGTH  -
                                                   IDX1
                   END-IF
               END-PERFORM
      *
      *        検索できなかったとき予約コードで検索
               IF      WRK-KEN-ADDKBN          =   ZERO
                   MOVE    2                   TO  IDX1
                   COMPUTE IDW =   WRK-KEN-LENGTH  -   1
                   MOVE    WRK-KEN-BYOMEI(IDW:IDX1)  
                                               TO  WRK-KENBYOMEI
                   PERFORM 2006-KAKKO-KENSAKU-SEC
                   IF      FLG-TBLERR          =   1
                       GO  TO  200-BYOMEI-SYORI-EXT
                   END-IF
      *
      *            検索できたとき
                   IF      WRK-KEN-ADDKBN          =   1
                       COMPUTE WRK-KEN-LENGTH  =   WRK-KEN-LENGTH  -
                                                   IDX1
                   END-IF
      *
      *            検索できなかったときは終了
                   IF      WRK-KEN-ADDKBN          =   ZERO
                       MOVE    ZERO                TO  WRK-KEN-LENGTH
                   END-IF
               END-IF
           END-PERFORM
      *
      *    入力された病名で検索（後ろから短縮して検索）
           IF      WRK-KEN-ADDKBN          =   ZERO
               INITIALIZE                  WRK-BYOMEICD-KENSAKU-AREA
                                           WRK-KENSAKU-AREA
               MOVE    ZERO                TO  IDY 
      *
               MOVE    LNK-BYO-BYOMEI          TO  WRK-KEN-BYOMEI
               MOVE    WRK-MOJISU      TO  WRK-KEN-LENGTH
               MOVE    1                   TO  IDZ
               MOVE    1                   TO  FLG-HENSYU
      *
               PERFORM             UNTIL   IDZ     >=  WRK-MOJISU
      *            病名の検索
                   MOVE    ZERO                TO  WRK-KEN-ADDKBN
                   PERFORM VARYING IDW FROM    WRK-KEN-LENGTH  BY  -2 
                           UNTIL   IDW <       2
                           OR      WRK-KEN-ADDKBN  =   1
                       MOVE    IDW             TO  IDX1
                       MOVE    "BYOMEI-KEY6"   TO  WRK-DBPATH
                       INITIALIZE                  BYOMEI-REC
                       MOVE    WRK-KEN-BYOMEI(IDZ:IDX1)  
                                               TO  BYO-BYOMEI
                       PERFORM 2001-BYOMEICD-KENSAKU-SEC
                       IF      FLG-BYOMEI      =   ZERO
      *                    未検索の病名があれば編集
                           IF      FLG-BUBUN           >   ZERO
                               PERFORM 2007-BUBUN-HENSYU-SEC
                               IF      FLG-TBLERR          =   1
                                   GO  TO  200-BYOMEI-SYORI-EXT
                               END-IF 
                           END-IF
      *
                           PERFORM 2002-BYOMEICD-HENSYU-SEC
                           IF      FLG-TBLERR  =   1
                               GO  TO  200-BYOMEI-SYORI-EXT
                           END-IF
                       END-IF      
      *
                       MOVE    "DBCLOSE"       TO  MCP-FUNC
                       MOVE    WRK-DBPATH      TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"     USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
      *
      *                検索できたとき
                       IF      WRK-KEN-ADDKBN      =   1
                           COMPUTE IDZ     =   IDZ     +   IDX1
                           COMPUTE WRK-KEN-LENGTH
                                           =   WRK-KEN-LENGTH  -
                                               IDX1
                       END-IF
                   END-PERFORM
      *
      *            検索できなかったとき予約コードで検索
                   IF      WRK-KEN-ADDKBN          =   ZERO
                       MOVE    2                   TO  IDX1
                       MOVE    WRK-KEN-BYOMEI(IDZ:IDX1)  
                                                   TO  WRK-KENBYOMEI
                       PERFORM 2006-KAKKO-KENSAKU-SEC
                       IF      FLG-TBLERR          =   1
                           GO  TO  200-BYOMEI-SYORI-EXT
                       END-IF
      *
      *                検索できなかったときの位置を取得
                       IF    ( WRK-KEN-ADDKBN          =   ZERO )
                       AND   ( FLG-BUBUN               =   ZERO )
                            MOVE    IDZ                TO  FLG-BUBUN
                       END-IF
      *
                       COMPUTE IDZ     =   IDZ   +   IDX1
                       COMPUTE WRK-KEN-LENGTH
                                       =   WRK-KEN-LENGTH  -
                                           IDX1
                   END-IF
               END-PERFORM
      *   
      *        未検索の病名があれば編集
               IF      FLG-BUBUN           >   ZERO
                   PERFORM 2007-BUBUN-HENSYU-SEC
                   IF      FLG-TBLERR          =   1
                       GO  TO  200-BYOMEI-SYORI-EXT
                   END-IF 
               END-IF
           END-IF
           .
       200-BYOMEI-SYORI-EXT.
           EXIT.
      *     
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       200-BYOMEICD-SYORI-SEC     SECTION.
      *
           MOVE    1                   TO  FLG-HENSYU
      *
      *    病名コードが設定されていないとき
           MOVE    ZERO                TO  IDY
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ  >      21
               IF       LNK-BYO-TBYOMEICD (IDZ)    NOT =   SPACE
                   MOVE    1               TO  IDY
                   MOVE    21              TO  IDX
               END-IF
           END-PERFORM
           IF      IDY                 =   ZERO
               MOVE    "3"                 TO  LNK-BYO-RC
               GO  TO  200-BYOMEICD-SYORI-EXT
           END-IF   
      *
      *    病名コードで検索
           MOVE    ZERO                TO  IDY
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ  >      21
               IF       LNK-BYO-TBYOMEICD (IDZ)    NOT =   SPACE 
                   MOVE    "BYOMEI-KEY"        TO  WRK-DBPATH
                   INITIALIZE                  BYOMEI-REC
                   MOVE    LNK-BYO-TBYOMEICD (IDZ)
                                               TO  BYO-BYOMEICD
                   PERFORM 2001-BYOMEICD-KENSAKU-SEC
                   IF      FLG-BYOMEI          =   ZERO
                       PERFORM 2002-BYOMEICD-HENSYU-SEC
                       IF      FLG-TBLERR          =   1
                           GO  TO  200-BYOMEICD-SYORI-EXT
                       END-IF 
                   ELSE
                       SET     TBL-BYOMEICD-IDX    TO  1
                       SEARCH  TBL-BYOMEICD-OCC
                                       VARYING TBL-BYOMEICD-IDX
                           AT  END
                               MOVE    ZERO        TO  FLG-BYOMEICD-OK
                           WHEN    LNK-BYO-TBYOMEICD (IDZ)
                                       =   TBL-YYK-BYOMEICD 
                                                   (TBL-BYOMEICD-IDX)
                               MOVE    1           TO  FLG-BYOMEICD-OK
                               ADD     1           TO  IDY
                               IF      IDY     >   WRK-CONS-BYOMEI-MAX
                                   MOVE    1           TO  FLG-TBLERR
                                   GO  TO  200-BYOMEICD-SYORI-EXT
                               END-IF
                               MOVE    "1"
                                       TO  WRK-BYOMEI-FLG      (IDY)
                               MOVE
                                   TBL-YYK-BYOMEICD (TBL-BYOMEICD-IDX)
                                       TO  WRK-BYOMEI-BYOMEICD (IDY 1) 
                               MOVE
                                   TBL-YYK-BYOMEI   (TBL-BYOMEICD-IDX)
                                       TO  WRK-BYOMEI-BYOMEI   (IDY)
                       END-SEARCH
                       IF      FLG-BYOMEICD-OK =   ZERO            
                           MOVE    3           TO  LNK-BYO-BYOMEICD-ERR
                           MOVE    ZERO        TO  WRK-BYOMEI-MAX
                           GO  TO  200-BYOMEICD-SYORI-EXT
                       END-IF
                   END-IF
      *
                   MOVE    "DBCLOSE"           TO  MCP-FUNC
                   MOVE    WRK-DBPATH          TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               END-IF
           END-PERFORM    
           .
       200-BYOMEICD-SYORI-EXT.
           EXIT.
      *     
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       200-TBL-HENSYU-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-TBLERR
      *
      *    予約以外の病名コードを検索できなかったとき
           IF      WRK-BYOMEI-MAX      =   ZERO
               GO  TO  200-TBL-HENSYU-EXT
           END-IF 
      *
      *    検索病名コード情報編集
           MOVE    ZERO                TO  IDY
                                           WRK-BUI-MAX
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       40
               IF      ( WRK-BYOMEI-BYOMEICD (IDX 1)
                                               =   SPACE AND
                        WRK-BYOMEI-BYOMEICD (IDX 2)
                                               =   SPACE AND
                        WRK-BYOMEI-FLG  (IDX)  =   SPACE     )
                   CONTINUE
               ELSE
      *****        IF      WRK-BYOMEI-FLG  (IDX)   =   "1"
      *****            CONTINUE
      *****        ELSE
                   IF      LNK-BYO-BYOMEI-MAX
                                   >=  WRK-CONS-BYOMEI-MAX
                       MOVE    1               TO  FLG-TBLERR
                       MOVE    40              TO  IDX
                   ELSE
                       ADD     1               TO  LNK-BYO-BYOMEI-MAX
      *???
           DISPLAY " LNK-BYO-BYOMEI-MAX="  LNK-BYO-BYOMEI-MAX "#"
           DISPLAY "WRK=" IDX "#" WRK-BYOMEI-BYOMEI (IDX) "#"
                          WRK-BYOMEI-FLG  (IDX) "#"
                          WRK-BYOMEI-BYOMEICD (IDX 1) "#"
                          WRK-BYOMEI-BYOMEICD (IDX 2) "#"
      *???
                       EVALUATE    TRUE
                           WHEN  ( WRK-BYOMEI-BYOMEICD (IDX 1)
                                                       =   SPACE ) AND
                                 ( WRK-BYOMEI-BYOMEICD (IDX 2)
                                                   NOT =   SPACE )
                               MOVE    2               TO  IDX2
                               PERFORM 2003-LNK-HENSYU-SEC
                           WHEN  ( WRK-BYOMEI-BYOMEICD (IDX 1)
                                                   NOT =   SPACE ) AND
                                 ( WRK-BYOMEI-BYOMEICD (IDX 2)
                                                       =   SPACE )
                               MOVE    1               TO  IDX2
                               PERFORM 2003-LNK-HENSYU-SEC
                           WHEN  ( WRK-BYOMEI-BYOMEICD (IDX 1)
                                                   NOT =   SPACE ) AND
                                 ( WRK-BYOMEI-BYOMEICD (IDX 2)
                                                   NOT =   SPACE )
                               IF      IDX             =   40
                                 MOVE    2               TO  IDX2
                                 PERFORM 2003-LNK-HENSYU-SEC
                               ELSE
                                 COMPUTE IDX1    =   IDX     +   1
                                 IF    ( WRK-BYOMEI-BYOMEICD (IDX 1)
                                                         =   SPACE AND
                                         WRK-BYOMEI-BYOMEICD (IDX 2)
                                                         =   SPACE     )
                                   MOVE    2               TO  IDX2
                                   PERFORM 2003-LNK-HENSYU-SEC
                                 ELSE
                                   IF      WRK-BYOMEI-BYOMEICD (IDX1 2)
                                                   NOT =   SPACE
                                       MOVE    1               TO  IDX2
                                       PERFORM 2003-LNK-HENSYU-SEC
                                   ELSE
                                       IF      WRK-BYOMEI-BYOMEICD
                                                           (IDX1 1)(4:1)
                                                       =   "8"
                                           MOVE    2           TO  IDX2
                                           PERFORM 2003-LNK-HENSYU-SEC
                                       ELSE
                                           MOVE    1           TO  IDX2
                                           PERFORM 2003-LNK-HENSYU-SEC
                                       END-IF
                                   END-IF
                                 END-IF 
                               END-IF
                       END-EVALUATE
                   END-IF     
               END-IF
           END-PERFORM
      *
           PERFORM 2004-LNK-BYOMEI-HENSYU-SEC     
           .
       200-TBL-HENSYU-EXT.
           EXIT.
      *     
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       2001-BYOMEICD-KENSAKU-SEC        SECTION.
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-DBPATH            TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-N-SEC
           ELSE
               INITIALIZE                  BYOMEI-REC
               MOVE    1               TO  FLG-BYOMEI
           END-IF
           .
       2001-BYOMEICD-KENSAKU-EXT.
           EXIT.
      *
      *     
      *****************************************************************
      *    検索病名コード編集処理
      *****************************************************************
       2002-BYOMEICD-HENSYU-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-TBLERR
      * 
           ADD     1               TO  WRK-BYOMEI-MAX
      *
           EVALUATE    FLG-HENSYU
               WHEN    1
                   ADD     1               TO  IDY
                   IF      IDY             >   WRK-CONS-BYOMEI-MAX
                       MOVE    1           TO  FLG-TBLERR
                       GO  TO  2002-BYOMEICD-HENSYU-EXT
                   END-IF
               WHEN    2
                   COMPUTE IDY     =   IDY     -   1
                   IF      IDY         =   ZERO
                       MOVE    1           TO  FLG-TBLERR
                       GO  TO  2002-BYOMEICD-HENSYU-EXT
                   END-IF
           END-EVALUATE
      *    
      *    未コード化傷病名コードのときはコードだけ編集
           IF      BYO-BYOMEICD    =   "0000999"
               MOVE    2               TO  IDX
               MOVE    BYO-BYOMEICD    TO
                                       WRK-BYOMEI-BYOMEICD  (IDY IDX)
               GO  TO  2002-BYOMEICD-HENSYU-EXT
           END-IF
      *
           MOVE    BYO-BYOMEI      TO  WRK-BYOMEI-BYOMEI    (IDY)
      *
           PERFORM             UNTIL   FLG-BYOMEI  =   1
               EVALUATE   BYO-BYOMEICD (1:1)
                   WHEN    "Z"
                       MOVE    1           TO  IDX 
                   WHEN    OTHER
                       MOVE    2           TO  IDX
               END-EVALUATE 
      *  
               MOVE    BYO-BYOMEICD    TO
                                       WRK-BYOMEI-BYOMEICD  (IDY IDX)
               MOVE    BYO-IKOSAKICD   TO
                                       WRK-BYOMEI-IKOSAKICD (IDY IDX)
               MOVE    BYO-HAISIYMD    TO
                                       WRK-BYOMEI-HAISIYMD  (IDY IDX)
               MOVE    BYO-TANDOKUKBN  TO
                                       WRK-BYOMEI-TANDOKUKBN(IDY IDX)
               MOVE    BYO-TOKSKNCD    TO
                                       WRK-BYOMEI-TOKSKNCD  (IDY IDX)
               MOVE    BYO-UTAGAIFLG   TO
                                       WRK-BYOMEI-UTAGAIFLG (IDY IDX)
      *
               MOVE    WRK-DBPATH          TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-N-SEC
           END-PERFORM
      *
           MOVE    1               TO  WRK-KEN-ADDKBN
           .
       2002-BYOMEICD-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       2003-LNK-HENSYU-SEC             SECTION.
      *
           MOVE    LNK-BYO-BYOMEI-MAX  TO  IDY
      *???
           DISPLAY "2003=" WRK-BYOMEI-BYOMEICD   (IDX  IDX2) "#" 
                           WRK-BYOMEI-BYOMEI     (IDX) "#" IDY "#"
      *??
      *
           MOVE    WRK-BYOMEI-BYOMEI     (IDX)
                                       TO  LNK-BYO-TBYOMEI     (IDY)
           MOVE    WRK-BYOMEI-BYOMEICD   (IDX  IDX2)
                                       TO  LNK-BYO-TBYOMEICD   (IDY)
           MOVE    WRK-BYOMEI-IKOSAKICD  (IDX  IDX2)
                                       TO  LNK-BYO-TIKOSAKICD  (IDY)
           MOVE    WRK-BYOMEI-HAISIYMD   (IDX  IDX2)
                                       TO  LNK-BYO-THAISIYMD   (IDY)
           MOVE    WRK-BYOMEI-TANDOKUKBN (IDX  IDX2)
                                       TO  LNK-BYO-TTANDOKUKBN (IDY)
           MOVE    WRK-BYOMEI-TOKSKNCD   (IDX  IDX2)
                                       TO  LNK-BYO-TTOKSKNCD   (IDY)
           MOVE    WRK-BYOMEI-UTAGAIFLG  (IDX  IDX2)
                                       TO  LNK-BYO-TUTAGAIFLG  (IDY)
      *
      *    基本病名数
           EVALUATE    LNK-BYO-TBYOMEICD (IDY) (1:3)
               WHEN    "ZZZ"
                   IF      LNK-BYO-TBYOMEICD (IDY) (4:1)   =   "1"
                       ADD     1           TO  WRK-BUI-MAX
                       IF      WRK-BUI-MAX <   4
                           MOVE    LNK-BYO-TBYOMEICD (IDY)
                                       TO  LNK-BYO-KHNBUICD(WRK-BUI-MAX)
                       END-IF
                   END-IF
               WHEN    "000"
                   MOVE    1           TO  FLG-HENKAN-ERR
               WHEN   OTHER
      *            基本病名コード
                   IF      LNK-BYO-KHNBYOMEICD    =   SPACE
                       MOVE    LNK-BYO-TBYOMEICD (IDY)
                                               TO  LNK-BYO-KHNBYOMEICD
                   END-IF
                   ADD     1           TO  WRK-BYOMEICDSU
           END-EVALUATE
           .
       2003-LNK-HENSYU-EXT.
           EXIT.
      *     
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       2004-LNK-BYOMEI-HENSYU-SEC      SECTION.
      *
      *    病名コード数
           MOVE    LNK-BYO-BYOMEI-MAX  TO  LNK-BYO-BYOMEICDSU
      *
      *    病名編集フラグ
           IF      WRK-BYOMEI-FLG-TBL  NOT =   SPACE
               MOVE    "1"             TO  LNK-BYO-BYOMEIHENFLG
               GO  TO  2004-LNK-BYOMEI-HENSYU-EXT
           END-IF
      *
           MOVE    SPACE               TO  WRK-TANDOKUKBN
                                           WRK-RECECD-TBL
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       LNK-BYO-BYOMEI-MAX
      *
      *        単独使用禁止チェック
               IF      LNK-BYO-TTANDOKUKBN (IDX)
                                       =   ZERO
                   MOVE    "1"             TO  WRK-TANDOKUKBN
               END-IF
      *        廃止病名のとき（最初に見つけたコード）
               IF      LNK-BYO-THAISIYMD (IDX)
                                       =   ZERO    OR  ALL "9"
                   CONTINUE
               ELSE
                   IF      LNK-BYO-HAISIYMD-ERR
                                           =   ZERO
                       MOVE    LNK-BYO-THAISIYMD (IDX)
                                           TO  LNK-BYO-HAISIYMD-ERR
                   END-IF
               END-IF
      *        移行先コードがあるとき（最初に見つけたコード）
               IF    ( LNK-BYO-TIKOSAKICD (IDX)
                                   NOT =   SPACE )
               AND   ( LNK-BYO-IKOSAKICD
                                       =   SPACE )
                   MOVE    LNK-BYO-TIKOSAKICD (IDX)
                                           TO  LNK-BYO-IKOSAKICD
                   MOVE    IDX             TO  LNK-BYO-IKOSAKICD-INDEX 
               END-IF
      *        接尾語・接頭語チェック
               EVALUATE    LNK-BYO-TBYOMEICD(IDX)(1:3)
                               ALSO    LNK-BYO-TBYOMEICD(IDX)(4:1)
                   WHEN    "ZZZ"       ALSO    "1"
                       MOVE    LNK-BYO-TBYOMEICD(IDX)(4:1)
                                           TO  WRK-RECECD (1)
                       IF      WRK-RECECD (2)  NOT =   SPACE   OR
                               WRK-RECECD (3)  NOT =   SPACE 
                           MOVE    2      TO  LNK-BYO-BYOMEICD-ERR
                       END-IF            
                       MOVE    "1"         TO  LNK-BYO-BYOMEISBT
                   WHEN    "ZZZ"       ALSO    "2" THRU    "7"
                       MOVE    LNK-BYO-TBYOMEICD(IDX)(4:1)
                                           TO  WRK-RECECD (1)
                       IF      WRK-RECECD (2)  NOT =   SPACE   OR
                               WRK-RECECD (3)  NOT =   SPACE 
                            MOVE    2      TO  LNK-BYO-BYOMEICD-ERR
                       END-IF            
                       MOVE    "7"         TO  LNK-BYO-BYOMEISBT
                    WHEN    "ZZZ"       ALSO    "8"  
                        MOVE    LNK-BYO-TBYOMEICD(IDX)(4:1)
                                           TO  WRK-RECECD (3)
                        IF      WRK-RECECD (2)    =   SPACE 
                            MOVE    2      TO  LNK-BYO-BYOMEICD-ERR
                       END-IF
                       MOVE    "8"         TO  LNK-BYO-BYOMEISBT
                   WHEN    "ZZZ"       ALSO    ANY
                       CONTINUE
                   WHEN    OTHER                 
                       MOVE    "1"         TO  WRK-RECECD (2)
                       IF      WRK-RECECD (3)    NOT =   SPACE 
                            MOVE    2      TO  LNK-BYO-BYOMEICD-ERR
                       END-IF    
               END-EVALUATE
      *           
      *        疑いフラグ
               IF      LNK-BYO-UTAGAIFLG   =   "3"
                   CONTINUE
               ELSE
                   EVALUATE    LNK-BYO-TUTAGAIFLG   (IDX)
                       WHEN    "1"
                           IF      LNK-BYO-UTAGAIFLG   =   "2"
                               MOVE    "3"     TO  LNK-BYO-UTAGAIFLG
                            ELSE
                               MOVE    "1"     TO  LNK-BYO-UTAGAIFLG
                            END-IF    
                       WHEN    "2"
                           IF      LNK-BYO-UTAGAIFLG  =   "1"
                               MOVE    "3"     TO  LNK-BYO-UTAGAIFLG
                            ELSE
                               MOVE    "2"     TO  LNK-BYO-UTAGAIFLG
                           END-IF
                       WHEN    "3"
                           MOVE    "3"     TO  LNK-BYO-UTAGAIFLG
                    END-EVALUATE
               END-IF
      *        慢性区分
               IF      LNK-BYO-TTOKSKNCD (IDX) 
                                       NOT =   ZERO
               AND     LNK-BYO-MANSEIKBN   =   ZERO
                   MOVE    LNK-BYO-TTOKSKNCD (IDX)
                                           TO  LNK-BYO-MANSEIKBN 
               END-IF   
           END-PERFORM
      *
      *    病名種別
           IF      WRK-RECECD (2)      NOT =   SPACE
               MOVE    ZERO                TO  LNK-BYO-BYOMEISBT
           END-IF
      *
      *    接尾語・接頭語チェック（接頭語のみのとき）
           IF    ( WRK-RECECD (1)    NOT =   SPACE )
           AND   ( WRK-RECECD (2)        =   SPACE )
           AND   ( WRK-RECECD (3)        =   SPACE )
               MOVE    1      TO  LNK-BYO-BYOMEICD-ERR
           END-IF
      *    接尾語・接頭語チェック（接尾語のみのとき）
           IF    ( WRK-RECECD (1)        =   SPACE )
           AND   ( WRK-RECECD (2)        =   SPACE )
           AND   ( WRK-RECECD (3)    NOT =   SPACE )
               MOVE    1      TO  LNK-BYO-BYOMEICD-ERR
           END-IF
      *
      *    単独禁止のみのとき
           IF      WRK-TANDOKUKBN          =   SPACE
               MOVE    "1"                 TO  LNK-BYO-TANDOKUKBN-ERR
           END-IF
      *
      *    移行先病名
           IF      LNK-BYO-IKOSAKICD   NOT =   SPACE
               MOVE    "BYOMEI-KEY"        TO  WRK-DBPATH
               MOVE    LNK-BYO-IKOSAKICD   TO  BYO-BYOMEICD
               PERFORM 900-BYOMEI-READ-SEC
               MOVE    BYO-BYOMEI          TO  LNK-BYO-IKOSAKICD-BYOMEI
           END-IF
      *    
      *    複数基本病名コードが存在するとき
           IF      WRK-BYOMEICDSU      >   1
               MOVE    9                   TO  LNK-BYO-BYOMEICD-ERR
               GO  TO  2004-LNK-BYOMEI-HENSYU-EXT
           END-IF
           .
       2004-LNK-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    予約コード検索処理
      *****************************************************************
       2006-KAKKO-KENSAKU-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-KENSAKU
                                       FLG-TBLERR
      *
      *???
           DISPLAY "2006  =" WRK-KENBYOMEI "#" FLG-HENSYU "#" IDY "#"
      *???
           SET     TBL-BYOMEICD-IDX    TO  1
           SEARCH  TBL-BYOMEICD-OCC    VARYING TBL-BYOMEICD-IDX
               AT  END
                   MOVE    ZERO            TO  FLG-BYOMEICD-OK
               WHEN    WRK-KENBYOMEI   =   TBL-YYK-BYOMEI 
                                               (TBL-BYOMEICD-IDX)
                   MOVE    1               TO  FLG-BYOMEICD-OK
                   MOVE    1               TO  FLG-KENSAKU
      *
      *            未検索の病名があれば編集
                   IF      FLG-BUBUN           >   ZERO
                       PERFORM 2007-BUBUN-HENSYU-SEC
                       IF      FLG-TBLERR          =   1
                           GO  TO  2006-KAKKO-KENSAKU-EXT
                       END-IF
                   END-IF
      *
                   EVALUATE    FLG-HENSYU
                       WHEN    "1"
                           ADD     1           TO  IDY
                           IF      IDY         >   WRK-CONS-BYOMEI-MAX
                               MOVE    1           TO  FLG-TBLERR
                               GO  TO  2006-KAKKO-KENSAKU-EXT
                           END-IF
                       WHEN    "2"  
                           COMPUTE IDY     =   IDY     -   1
                           IF      IDY         =   ZERO
                               MOVE    1           TO  FLG-TBLERR
                               GO  TO  2006-KAKKO-KENSAKU-EXT
                           END-IF
                   END-EVALUATE
      *
      *???
           DISPLAY "2006 UP=" WRK-KENBYOMEI "#" IDY "#"
      *???
                   MOVE    "1"         TO  WRK-BYOMEI-FLG      (IDY)
                   MOVE    TBL-YYK-BYOMEICD (TBL-BYOMEICD-IDX)
                                       TO  WRK-BYOMEI-BYOMEICD (IDY 1) 
                   MOVE    TBL-YYK-BYOMEI   (TBL-BYOMEICD-IDX)
                                       TO  WRK-BYOMEI-BYOMEI   (IDY)
                   MOVE    1           TO  WRK-KEN-ADDKBN
           END-SEARCH            
           .
       2006-KAKKO-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名部分検索処理
      *****************************************************************
       2007-BUBUN-HENSYU-SEC   SECTION.
      *
           MOVE    ZERO                TO  FLG-TBLERR
           EVALUATE    FLG-HENSYU
               WHEN    "1"
                   ADD     1           TO  IDY
                   IF      IDY         >   WRK-CONS-BYOMEI-MAX
                       MOVE    1           TO  FLG-TBLERR 
                       GO  TO  2007-BUBUN-HENSYU-EXT
                   END-IF
               WHEN    "2"  
                   COMPUTE IDY     =   IDY     -   1
                   IF      IDY         =   ZERO
                       MOVE    1           TO  FLG-TBLERR 
                       GO  TO  2007-BUBUN-HENSYU-EXT
                   END-IF
           END-EVALUATE
      *
           COMPUTE WRK-LENGTH  =   IDZ     -   FLG-BUBUN
           MOVE    FLG-BUBUN       TO  WRK-ST
      *???
           DISPLAY "2007 UP=" FLG-BUBUN "#" IDY "#"
                             WRK-KEN-BYOMEI (WRK-ST:WRK-LENGTH) "#"
      *???
      *     
           MOVE    WRK-KEN-BYOMEI (WRK-ST:WRK-LENGTH)
                                   TO  WRK-BYOMEI-BYOMEI    (IDY)
           MOVE    "0000999"       TO  WRK-BYOMEI-BYOMEICD  (IDY 1)
      *
           MOVE    1               TO  WRK-KEN-ADDKBN
           MOVE    ZERO            TO  FLG-BUBUN
      * 
           .
       2007-BUBUN-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-READ-SEC         SECTION.
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-DBPATH        TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-N-SEC
           ELSE
               MOVE    1                   TO  FLG-BYOMEI
               INITIALIZE                  BYOMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-DBPATH           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-BYOMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-READ-N-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-BYOMEI
               MOVE    MCPDATA-REC     TO  BYOMEI-REC
           ELSE
              MOVE    1               TO  FLG-BYOMEI
              INITIALIZE                  BYOMEI-REC
           END-IF
           .
       900-BYOMEI-READ-N-EXT.
           EXIT.
      *
