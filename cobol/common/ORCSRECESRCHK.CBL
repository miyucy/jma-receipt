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
       PROGRAM-ID.             ORCSRECESRCHK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : オンライン診療料等に関わる管理料・指導料の
      *                      算定履歴チェックサブ
      *  管理者            : 
      *  18/04/19    NACL−藤原    新規作成
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
       DATA                        DIVISION.
      *
       WORKING-STORAGE             SECTION.
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
      *
           03  FLG-CHK             PIC 9(01).
      *
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
           03  IDXX                PIC 9(04).
           03  IDYY                PIC 9(04).
      *
       01  WRK-AREA.
           03  WRK-ST-IDX          PIC 9(03).
           03  WRK-ED-IDX          PIC 9(03).
      *
           03  WRK-SANTEIYM        PIC X(06).
      *
       01  WRK-CONS-AREA.
           03  WRK-CONS-SRYCD-TABLE.
      *        特定疾患療養管理料（診療所）
               05 FILLER           PIC X(09)   VALUE   "113001810".
      *        特定疾患療養管理料（１００床未満）
               05 FILLER           PIC X(09)   VALUE   "113001910".
      *        特定疾患療養管理料（１００床以上２００床未満）
               05 FILLER           PIC X(09)   VALUE   "113002010".
               05 FILLER           PIC X(333)  VALUE   SPACE.
      *
      *        小児科療養指導料
               05 FILLER           PIC X(09)   VALUE   "113002210".
               05 FILLER           PIC X(351)  VALUE   SPACE.
      *        
      *        てんかん指導料
               05 FILLER           PIC X(09)   VALUE   "113002850".
               05 FILLER           PIC X(351)  VALUE   SPACE.
      *
      *        難病外来指導管理料
               05 FILLER           PIC X(09)   VALUE   "113002910".
               05 FILLER           PIC X(351)  VALUE   SPACE.
      *
      *        糖尿病透析予防指導管理料
               05 FILLER           PIC X(09)   VALUE   "113013610".
      *        糖尿病透析予防指導管理料（特定地域）
               05 FILLER           PIC X(09)   VALUE   "113015610".
               05 FILLER           PIC X(342)  VALUE   SPACE.
      *
      *        地域包括診療料２
               05 FILLER           PIC X(09)   VALUE   "113015810".
      *        地域包括診療料１
               05 FILLER           PIC X(09)   VALUE   "113024810".
               05 FILLER           PIC X(342)  VALUE   SPACE.
      *
      *        認知症地域包括診療料２
               05 FILLER           PIC X(09)   VALUE   "113018410".
      *        認知症地域包括診療料１
               05 FILLER           PIC X(09)   VALUE   "113025710".
               05 FILLER           PIC X(342)  VALUE   SPACE.
      *
      *        生活習慣病管理料（処方箋を交付）（高血圧症を主病）
               05 FILLER           PIC X(09)   VALUE   "113003910".
      *        生活習慣病管理料（処方箋を交付しない）（高血圧症を主病）
               05 FILLER           PIC X(09)   VALUE   "113004010".
      *        生活習慣病管理料（処方箋を交付）（脂質異常症を主病）
               05 FILLER           PIC X(09)   VALUE   "113005810".
      *        生活習慣病管理料（処方箋を交付）（糖尿病を主病）
               05 FILLER           PIC X(09)   VALUE   "113005910".
      *        生活習慣病管理料（処方箋を交付しない）（脂質異常症を主病）
               05 FILLER           PIC X(09)   VALUE   "113006010".
      *        生活習慣病管理料（処方箋を交付しない）（糖尿病を主病）
               05 FILLER           PIC X(09)   VALUE   "113006110".
               05 FILLER           PIC X(306)  VALUE   SPACE.
      *
      *        在医総管（機能強化在支診等・病床有・難病等月２回以上・１人）
               05 FILLER           PIC X(09)   VALUE   "114030710".
      *        在医総管（機能強化在支診等・病床有・難病等月２回以上・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114030810".
      *        在医総管（機能強化在支診等・病床有・難病等月２回以上・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114030910".
      *        在医総管（機能強化在支診等・病床有・月２回以上・１人）
               05 FILLER           PIC X(09)   VALUE   "114031010".
      *        在医総管（機能強化在支診等・病床有・月２回以上・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114031110".
      *        在医総管（機能強化在支診等・病床有・月２回以上・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114031210".
      *        在医総管（機能強化在支診等・病床有・月１回・１人）
               05 FILLER           PIC X(09)   VALUE   "114031310".
      *        在医総管（機能強化在支診等・病床有・月１回・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114031410".
      *        在医総管（機能強化在支診等・病床有・月１回・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114031510".
      *        在医総管（機能強化在支診等・病床無・難病等月２回以上・１人）
               05 FILLER           PIC X(09)   VALUE   "114031610".
      *        在医総管（機能強化在支診等・病床無・難病等月２回以上・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114031710".
      *        在医総管（機能強化在支診等・病床無・難病等月２回以上・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114031810".
      *        在医総管（機能強化在支診等・病床無・月２回以上・１人）
               05 FILLER           PIC X(09)   VALUE   "114031910".
      *        在医総管（機能強化在支診等・病床無・月２回以上・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114032010".
      *        在医総管（機能強化在支診等・病床無・月２回以上・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114032110".
      *        在医総管（機能強化在支診等・病床無・月１回・１人）
               05 FILLER           PIC X(09)   VALUE   "114032210".
      *        在医総管（機能強化在支診等・病床無・月１回・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114032310".
      *        在医総管（機能強化在支診等・病床無・月１回・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114032410".
      *        在医総管（在支診等・難病等月２回以上・１人）
               05 FILLER           PIC X(09)   VALUE   "114032510".
      *        在医総管（在支診等・難病等月２回以上・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114032610".
      *        在医総管（在支診等・難病等月２回以上・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114032710".
      *        在医総管（在支診等・月２回以上・１人）
               05 FILLER           PIC X(09)   VALUE   "114032810".
      *        在医総管（在支診等・月２回以上・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114032910".
      *        在医総管（在支診等・月２回以上・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114033010".
      *        在医総管（在支診等・月１回・１人）
               05 FILLER           PIC X(09)   VALUE   "114033110".
      *        在医総管（在支診等・月１回・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114033210".
      *        在医総管（在支診等・月１回・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114033310".
      *        在医総管（在支診等以外・難病等月２回以上・１人）
               05 FILLER           PIC X(09)   VALUE   "114033410".
      *        在医総管（在支診等以外・難病等月２回以上・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114033510".
      *        在医総管（在支診等以外・難病等月２回以上・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114033610".
      *        在医総管（在支診等以外・月２回以上・１人）
               05 FILLER           PIC X(09)   VALUE   "114033710".
      *        在医総管（在支診等以外・月２回以上・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114033810".
      *        在医総管（在支診等以外・月２回以上・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114033910".
      *        在医総管（在支診等以外・月１回・１人）
               05 FILLER           PIC X(09)   VALUE   "114034010".
      *        在医総管（在支診等以外・月１回・２〜９人）
               05 FILLER           PIC X(09)   VALUE   "114034110".
      *        在医総管（在支診等以外・月１回・１０人〜）
               05 FILLER           PIC X(09)   VALUE   "114034210".
               05 FILLER           PIC X(36)   VALUE   SPACE.
      *
      *        精神科在宅患者支援管理料１（集中的支援必要）（単一建物１人）
               05 FILLER           PIC X(09)   VALUE   "180057210".
      *        精神科在宅患者支援管理料１（集中的支援必要）（単一建物２人以上）
               05 FILLER           PIC X(09)   VALUE   "180057310".
      *        精神科在宅患者支援管理料１（重度精神障害者）（単一建物１人）
               05 FILLER           PIC X(09)   VALUE   "180057410".
      *        精神科在宅患者支援管理料１（重度精神障害者）（単一建物２人以上）
               05 FILLER           PIC X(09)   VALUE   "180057510".
      *        精神科在宅患者支援管理料１（イ及びロ以外）（単一建物１人）
               05 FILLER           PIC X(09)   VALUE   "180057610".
      *        精神科在宅患者支援管理料１（イ及びロ以外）（単一建物２人以上）
               05 FILLER           PIC X(09)   VALUE   "180057710".
      *        精神科在宅患者支援管理料２（集中的支援必要）（単一建物１人）
               05 FILLER           PIC X(09)   VALUE   "180057810".
      *        精神科在宅患者支援管理料２（集中的支援必要）（単一建物２人以上）
               05 FILLER           PIC X(09)   VALUE   "180057910".
      *        精神科在宅患者支援管理料２（重度精神障害者）（単一建物１人）
               05 FILLER           PIC X(09)   VALUE   "180058010".
      *        精神科在宅患者支援管理料２（重度精神障害者）（単一建物２人以上）
               05 FILLER           PIC X(09)   VALUE   "180058110".
               05 FILLER           PIC X(270)  VALUE   SPACE.
      *
           03  WRK-CONS-SRYCD-TABLE-R          REDEFINES
                                       WRK-CONS-SRYCD-TABLE.
               05  WRK-CONS-SRYCD-G            OCCURS  10.
                   07  WRK-CONS-SRYCD
                                   PIC X(09)   OCCURS  40.
      *
           03  WRK-CONS-COMMENT-SRYCD-TABLE.
      *        特定疾患療養管理料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100006".
      *        小児科療養指導料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100007".
      *        てんかん指導料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100008".
      *        難病外来指導管理料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100009".
      *        糖尿病透析予防指導管理料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100010".
      *        地域包括診療料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100011".
      *        認知症地域包括診療料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100012".
      *        生活習慣病管理料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100013".
      *        在宅時医学総合管理料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100014".
      *        精神科在宅患者支援管理料算定患者
               05 FILLER           PIC X(09)   VALUE   "820100015".
           03  WRK-CONS-COMMENT-SRYCD-TABLE-R  REDEFINES
                                      WRK-CONS-COMMENT-SRYCD-TABLE.
               05  WRK-CONS-COMMENT-SRYCD-G    OCCURS  10.
                   07  WRK-CONS-COMMENT-SRYCD
                                   PIC X(09).
      *
      *    チェックする算定の診療行為コードの最大数
           03  WRK-CONS-SRYCD-MAX  PIC 9(03)   VALUE   40.
      *    チェックする月数
           03  WRK-CONS-YM-MAX     PIC 9(03)   VALUE   4.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    患者
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    連絡領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "COMMON-SPA".
      *
           COPY    "CPORCSRECESRCHK.INC".
      *
      *****************************************************************
      *
       PROCEDURE                   DIVISION    USING
                                   SPA-AREA
                                   ORCSRECESRCHKAREA.
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
           PERFORM 300-END-SEC
           .
       000-PROC-EXT.
      *
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *??  DISPLAY "LNK-RECESRCHK PTID  =" LNK-RECESRCHK-PTID
      *??  DISPLAY "LNK-RECESRCHK SRYYM =" LNK-RECESRCHK-SRYYM
      *??  DISPLAY "LNK-RECESRCHK CHKKBN=" LNK-RECESRCHK-CHKKBN
      *??  DISPLAY "LNK-RECESRCHK CHKNO =" LNK-RECESRCHK-CHKNO
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    ZERO            TO  LNK-RECESRCHK-RC
           INITIALIZE                  LNK-RECESRCHK-HENKYAKU-AREA
      *
      *    入力値チェック
           IF    ( LNK-RECESRCHK-PTID      =   ZERO  )
           OR    ( LNK-RECESRCHK-SRYYM     =   SPACE )
           OR    ( LNK-RECESRCHK-CHKKBN    =   SPACE )
               MOVE    1                   TO  LNK-RECESRCHK-RC
           ELSE
      *        処理年月チェック
               INITIALIZE                      ORCSGDAYAREA
               MOVE    "1"                 TO  SGDAY-INTYPE
               MOVE    LNK-RECESRCHK-SRYYM TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   IF     LNK-RECESRCHK-SRYYM  <  "201804"
                       MOVE    2               TO  LNK-RECESRCHK-RC
                   END-IF
               ELSE
                   MOVE    2               TO  LNK-RECESRCHK-RC
               END-IF
      *
               IF      LNK-RECESRCHK-RC    =   ZERO
      *            患者ＩＤチェック
                   INITIALIZE                      PTINF-REC
                   MOVE    SPA-HOSPNUM         TO  PTINF-HOSPNUM
                   MOVE    LNK-RECESRCHK-PTID  TO  PTINF-PTID
                   PERFORM 900-PTINF-READ-SEC
                   IF      FLG-PTINF       NOT =   ZERO
                       MOVE    3                   TO  LNK-RECESRCHK-RC
                   END-IF
               END-IF
      *
               IF      LNK-RECESRCHK-RC    =   ZERO
      *            チェック区分チェック
                   EVALUATE    LNK-RECESRCHK-CHKKBN
                       WHEN    "1"
                       WHEN    "2"
                       WHEN    "3"
                       WHEN    "4"
                           CONTINUE
                       WHEN   OTHER
                           MOVE    4               TO  LNK-RECESRCHK-RC
                   END-EVALUATE
               END-IF
      *
               IF      LNK-RECESRCHK-RC    =   ZERO
      *            チェック番号チェック
                   IF      LNK-RECESRCHK-CHKNO >   10
                       MOVE    5               TO  LNK-RECESRCHK-RC
                   END-IF
               END-IF
           END-IF
      *
           IF      LNK-RECESRCHK-RC    =   ZERO
               CONTINUE
           ELSE
               MOVE    1                   TO  FLG-END
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT
           .
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    ZERO            TO  WRK-ST-IDX
                                       WRK-ED-IDX
                                       FLG-CHK
      *
           IF      LNK-RECESRCHK-CHKNO
                                   >   ZERO
               MOVE    LNK-RECESRCHK-CHKNO
                                       TO  WRK-ST-IDX
                                           WRK-ED-IDX
           ELSE
               EVALUATE    LNK-RECESRCHK-CHKKBN
                   WHEN    "1"
                       MOVE    1               TO  WRK-ST-IDX
                       MOVE    10              TO  WRK-ED-IDX
                   WHEN    "2"
                       MOVE    1               TO  WRK-ST-IDX
                       MOVE    8               TO  WRK-ED-IDX
                   WHEN    "3"
                       MOVE    9               TO  WRK-ST-IDX
                       MOVE    9               TO  WRK-ED-IDX
                   WHEN    "4"
                       MOVE    10              TO  WRK-ST-IDX
                       MOVE    10              TO  WRK-ED-IDX
               END-EVALUATE
           END-IF
      *
      *    処理年月の三ヶ月前までの算定履歴をチェック
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       WRK-CONS-YM-MAX
                   OR      FLG-CHK =       1
               INITIALIZE                  STS-AREA-DAY
               INITIALIZE                  LNK-DAY6-AREA
               MOVE    "61"            TO  LNK-DAY6-IRAI
               MOVE    LNK-RECESRCHK-SRYYM
                                       TO  LNK-DAY6-KIJUN (1:6)
               MOVE    "01"            TO  LNK-DAY6-KIJUN (7:2)
               MOVE    "2"             TO  LNK-DAY6-ZOGENPTN
               COMPUTE LNK-DAY6-ZOGEN  =   -1  *   ( IDX -   1 )
               CALL    "ORCSDAY"       USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
               MOVE    LNK-DAY6-KEISAN (1:6)
                                       TO  WRK-SANTEIYM
      *??      DISPLAY "SANTEIYM=" WRK-SANTEIYM
      *
               PERFORM VARYING IDXX    FROM    WRK-ST-IDX  BY  1
                       UNTIL   IDXX    >       WRK-ED-IDX
                       OR      FLG-CHK =       1
                   PERFORM VARYING IDYY    FROM    1   BY  1
                           UNTIL   IDYY    >       WRK-CONS-SRYCD-MAX
                           OR      WRK-CONS-SRYCD (IDXX IDYY)
                                           =       SPACE
                           OR      FLG-CHK =       1
      *??              DISPLAY "SRYCD=" IDXX " " IDYY " " 
      *??                       WRK-CONS-SRYCD (IDXX IDYY)
      *
                       INITIALIZE                  SANTEI-REC
                       MOVE    SPA-HOSPNUM     TO  SANTEI-HOSPNUM
                       MOVE    LNK-RECESRCHK-PTID
                                               TO  SANTEI-PTID
                       MOVE    WRK-SANTEIYM    TO  SANTEI-SRYYM
                       MOVE    WRK-CONS-SRYCD (IDXX IDYY)
                                               TO  SANTEI-SRYCD
                       MOVE    ZERO            TO  SANTEI-NYUGAIKBN
                       MOVE    ZERO            TO  SANTEI-SRYKA
                       MOVE    ZERO            TO  SANTEI-HKNCOMBINUM
                       MOVE    SANTEI-REC      TO  MCPDATA-REC
                       MOVE    "tbl_santei"    TO  MCP-TABLE
                       MOVE    "key"           TO  MCP-PATHNAME
                       PERFORM  900-SANTEI-READ-SEC
                       IF       FLG-SANTEI     =   ZERO
                           MOVE    SANTEI-SRYYM    TO
                                               LNK-RECESRCHK-SANTEIYM
                           MOVE    SANTEI-SRYCD    TO
                                               LNK-RECESRCHK-SRYCD
                           MOVE    SANTEI-FSANTEIYMD
                                                   TO
                                               LNK-RECESRCHK-FSANTEIYMD
                           MOVE    SANTEI-MSANTEID TO
                                               LNK-RECESRCHK-MSANTEID
                           MOVE    SANTEI-SRYCD    TO
                                               LNK-RECESRCHK-SRYCD
                           MOVE    WRK-CONS-COMMENT-SRYCD (IDXX)
                                                   TO
                                               LNK-RECESRCHK-COMCD
                           MOVE    1               TO  FLG-CHK
                       END-IF
                   END-PERFORM
               END-PERFORM
           END-PERFORM
      *    
           IF      FLG-CHK         =   ZERO
      *        算定履歴情報編集なし
               MOVE    9               TO  LNK-RECESRCHK-RC
           END-IF
      *
           MOVE    1               TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           DISPLAY "LNK-RECESRCHK RC        =" LNK-RECESRCHK-RC
           DISPLAY "LNK-RECESRCHK SANTEIYM  =" LNK-RECESRCHK-SANTEIYM
           DISPLAY "LNK-RECESRCHK SRYCD     =" LNK-RECESRCHK-SRYCD
           DISPLAY "LNK-RECESRCHK FSANTEIYMD=" LNK-RECESRCHK-FSANTEIYMD
           DISPLAY "LNK-RECESRCHK MSANTEID  =" LNK-RECESRCHK-MSANTEID
           DISPLAY "LNK-RECESRCHK COMCD     =" LNK-RECESRCHK-COMCD
      *
           .
       300-END-EXT.
           EXIT. 
      *
      *****************************************************************
      *    算定履歴読込
      *****************************************************************
       900-SANTEI-READ-SEC          SECTION.
      *
           MOVE    "tbl_santei"    TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-DBSELECT-SEC
           IF      MCP-RC          =   ZERO
               MOVE    "tbl_santei"    TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM 900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC     TO  SANTEI-REC
                   MOVE    ZERO            TO  FLG-SANTEI
               ELSE
                   MOVE    1               TO  FLG-SANTEI
                   INITIALIZE                   SANTEI-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-SANTEI
               INITIALIZE                  SANTEI-REC
           END-IF
      *
           MOVE    "tbl_santei"    TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-SANTEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者読込
      *****************************************************************
       900-PTINF-READ-SEC          SECTION.
      *
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM   900-DBSELECT-SEC
           IF      MCP-RC          =   ZERO
               MOVE    "tbl_ptinf"     TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               PERFORM   900-DBFETCH-SEC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC     TO  PTINF-REC
                   MOVE    ZERO            TO  FLG-PTINF
               ELSE
                   INITIALIZE                  PTINF-REC
                   MOVE    1               TO  FLG-PTINF
               END-IF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
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
           PERFORM 900-ORCDBMAIN-SEC
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
           PERFORM 900-ORCDBMAIN-SEC
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
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
