      *******************************************************************
      * Project code name "ORCA"
      * Æü°åÉ¸½à¥ì¥»¥×¥È¥½¥Õ¥È¡ÊJMA standard receipt software¡Ë
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
       PROGRAM-ID.             ORCHCM43.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : ´µ¼ÔÅÐÏ¿
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ³°Íè·îÊÌÀÁµá½ñ·óÎÎ¼ý½ñ¡¡°õºþ¡Ê£È£Ã£Í£´£³¡Ë
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  05/01/14    NACL¡ÝÂÀÅÄ    ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    Ä¢É¼
           COPY    "HCM43.INC".
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-PTRSIINF        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PRINT           PIC 9(01).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX-JIHI            PIC 9(05).
           03  IDX-SYU             PIC 9(05).
           03  IDX1                PIC 9(05).
           03  IDX2                PIC 9(05).
      *
      *    °ì»þÎÎ°è
       01  WRK-AREA.
           03  WRK-SRYKA-MAX       PIC 9(05).
           03  WRK-SRYKA-PNT       PIC 9(05).
           03  WRK-SRYYMD          PIC X(08).
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(22).
      *
           03  WRK-HKNCOMBIMEI     PIC X(40).
      *
           03  WRK-MISYUMONEY      PIC S9(11).
           03  WRK-GOKTEN          PIC S9(11).
      *
           03  WRK-DENPNUM         PIC 9(07).
           03  WRK-SRYKA           PIC X(02).
           03  WRK-HKNCOMBI        PIC X(04).
      *
           03  WRK-WARI            PIC 9(02)V9.
           03  WRK-Z6              PIC ZZZ.
           03  WRK-Z62             PIC 9.9.
      *
           03  WRK-NO              PIC Z(7).
           03  WRK-Z72-G.
               05  WRK-FIL2        PIC X(18).
           03  WRK-Z72             PIC S9(07).
           03  WRK-Z72-H           PIC Z,ZZZ,ZZZ.
           03  WRK-Z72-HS          REDEFINES   WRK-Z72-H
                                   PIC -,---,---.
      *    ¼«Èñ½¸·×
           03  WRK-JIHI-REC.
               05  WRK-JIHI        PIC S9(07)   OCCURS  5.
           03  WRK-JIHI-TOTAL      PIC S9(08).
           03  WRK-JIHIMEI-REC.
               05  WRK-JIHIMEI     PIC X(20)   OCCURS  5.
      *
           03  WRK-SRYKA-MEI       PIC X(30).
      *
       01  WKSYUNOU-REC.
           COPY    "CPSYUNOU.INC"     REPLACING //SYU-//
                                      BY        //WKSYU-//.
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
           COPY    "CPSYSKANRI.INC".
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý´ðËÜ¾ðÊó 
           COPY    "CPSK1001.INC".
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè 
           COPY    "CPSK1002.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK1013.INC".
      *
      *    Ï«ºÒ°åÎÅµ¡´Ø¾ðÊó
           COPY    "CPSK4001.INC".
      *
      *    ´µ¼Ô¥Þ¥¹¥¿
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    ¼ýÇ¼
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    ÊÝ¸±ÁÈ¹ç¤»
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ´µ¼ÔÏ«ºÒÊÝ¸±¾ðÊó
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑ¡¡ÎÎ°è
      *****************************************************************
      *
      *   ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    Á´³Ñ¥Á¥§¥Ã¥¯¥Ñ¥é¥á¥¿
           COPY    "CPORCSKANACHK.INC".
      *
      *    ÀÁµá½ñ¼ýÇ¼¥Ñ¥é¥á¥¿
           COPY    "CPORCHCM43S01.INC".
      *
       01  LNKSYU-REC.
         02    LNKSYU-OCC             OCCURS  50.
           COPY    "CPSYUNOU.INC"     REPLACING //SYU-//
                                      BY        //LNKSYU-//.
      *
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
      *
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    ¥¹¥ÑÎÎ°è
           COPY    "COMMON-SPA".
      *
           COPY    "CPORCSPRT.INC".
      *
      *    ÀÁµá½ñ¥Ñ¥é¥á¥¿
           COPY    "CPORCHCM43.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCSPRTAREA
           ORCHCM43AREA
           .
      *
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
      *    ³Æ£Ä£ÂÆÉ¹þ
           PERFORM 100-SYORI-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    ½é´üÊÔ½¸½èÍý
      *****************************************************************
       100-SYORI-SEC                SECTION.
      *
           MOVE    ORCHCM43-STSRYYM    TO  WRK-SRYYMD
           MOVE    "01"                TO  WRK-SRYYMD (7:)
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           INITIALIZE                      SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    WRK-SRYYMD          TO  SYS-1001-STYUKYMD
                                           SYS-1001-EDYUKYMD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-1001-REC
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           INITIALIZE                      SYS-1002-REC
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    WRK-SRYYMD          TO  SYS-1002-STYUKYMD
                                           SYS-1002-EDYUKYMD
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-1002-REC
      *
      *    Ï«ºÒ°åÎÅµ¡´Ø¾ðÊóÊÔ½¸
           INITIALIZE                      SYS-4001-REC
           MOVE    "4001"              TO  SYS-4001-KANRICD
           MOVE    "*"                 TO  SYS-4001-KBNCD
           MOVE    WRK-SRYYMD          TO  SYS-4001-STYUKYMD
                                           SYS-4001-EDYUKYMD
           MOVE    SYS-4001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-4001-REC
      *
      *    ¼«ÈñÌ¾¾ÎÊÔ½¸
           PERFORM 1002-JIHIMSG-HEN-SEC
      *
      *    ´µ¼Ô¾ðÊó
           PERFORM 900-PTINF-KEY-SEC
      *
           .
       100-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    ¼«ÈñÌ¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       1002-JIHIMSG-HEN-SEC             SECTION.
      *
           INITIALIZE                      SYS-1013-REC
           MOVE    "1013"              TO  SYS-1013-KANRICD
           MOVE    WRK-SRYYMD          TO  SYS-1013-STYUKYMD
                                           SYS-1013-EDYUKYMD
           MOVE    SYS-1013-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
      *
           INITIALIZE                  WRK-JIHIMEI-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    =   1 )
      *
               MOVE    MCPDATA-REC         TO  SYS-1013-REC
      *
               IF    ( SPA-NYUGAIKBN       =   SYS-1013-KBNCD(1:1) )
                   EVALUATE    SYS-1013-KBNCD(2:1)
                   WHEN    "1"
                       MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI  (1)
                   WHEN    "2"
                       MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI  (2)
                   WHEN    "3"
                       MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI  (3)
                   WHEN    "4"
                       MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI  (4)
                   WHEN    "5"
                       MOVE    SYS-1013-JIHINAME   TO  WRK-JIHIMEI  (5)
                   END-EVALUATE
               END-IF
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
      *
           END-PERFORM
      *
           MOVE    PATH-TBL-SYSKANRI-KEY2
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
      *
           .
       1002-JIHIMSG-HEN-EXT.
           EXIT.
      *****************************************************************
      *   ¼ç½èÍý
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           INITIALIZE                  HCM43S01-AREA
      *
      *    ¼ýÇ¼¥Þ¥¹¥¿¤Þ¤È¤á·×»»
           CALL    "ORCHCM43S01"   USING
                                   SPA-AREA
                                   ORCHCM43AREA
                                   HCM43S01-AREA
                                   LNKSYU-REC
      *
           PERFORM VARYING IDX-SYU     FROM    1   BY  1
                   UNTIL ( IDX-SYU     >   HCM43S01-GRP-MAX )
      *
               MOVE    LNKSYU-OCC (IDX-SYU)
                                       TO  SYUNOU-REC
      *
               MOVE    ZERO            TO  FLG-PRINT
               IF    ( ORCHCM43-ZEROSKYFLG =   "1" )
                   IF    ( SYU-SKYMONEY    >   ZERO )
                       MOVE    1       TO  FLG-PRINT
                   END-IF
               ELSE
                       MOVE    1       TO  FLG-PRINT
               END-IF
      *
               IF    ( FLG-PRINT       =   1 )
      *            ¿ÇÎÅ²ÊÌ¾ÊÔ½¸
                   MOVE    1           TO  WRK-SRYKA-PNT
                   MOVE    SPACE       TO  WRK-SRYKA-MEI
                   PERFORM 2021-GRP-SRYKAMEI-HEN-SEC
      *
      *            ÊÝ¸±ÁÈ¹ç¤»
                   IF    ( HCM43S01-GRP-HKNCOMBI-MAX (IDX-SYU)
                                       >       1 )
                       MOVE    "Ê£¿ôÊÝ¸±»ÈÍÑ"  TO  WRK-HKNCOMBIMEI
                       MOVE    ZERO            TO  SYU-PTFTNRATE
                   ELSE
                       MOVE    HCM43S01-GRP-HKNCOMBI (IDX-SYU 1)
                                               TO  SYU-HKNCOMBINUM
                       MOVE    HCM43S01-GRP-PTFTNRATE (IDX-SYU 1)
                                               TO  SYU-PTFTNRATE
                       PERFORM 1001-HKNCOMBI-HEN-SEC
                   END-IF
      *
      *            Ä¢É¼ÊÔ½¸½èÍý
                   PERFORM 300-HCM43-HEN-SEC
      *
      *            Ä¢É¼°õºþ½èÍý
                   PERFORM 400-PRINT-SEC
               END-IF
      *
           END-PERFORM
      *
           .
       200-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»Ì¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       1001-HKNCOMBI-HEN-SEC             SECTION.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¡¼¸¡º÷
           INITIALIZE                      HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-PTID            TO  COMB-PTID
           MOVE    SYU-HKNCOMBINUM     TO  COMB-HKNCOMBINUM
           PERFORM 900-HKNCOMBI-KEY-SEL-SEC
           IF    ( FLG-HKNCOMBI        =   1 )
                DISPLAY "*** HKNCOMBI  ERR:"   COMB-KEY "."
           END-IF
      *
           PERFORM 10011-HKNCOMBIMEI-HEN-SEC
      *
           IF    ( COMB-HKNNUM         =   "971" OR "973" )
      *
      *        ´µ¼ÔÏ«ºÒÊÝ¸±¾ðÊó¸¡º÷
               INITIALIZE                      PTRSIINF-REC
               MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
               MOVE    SPA-PTID            TO  PTRSI-PTID
               MOVE    COMB-HKNID          TO  PTRSI-HKNID
               PERFORM 900-PTRSIINF-KEY-SEC
           ELSE
               INITIALIZE                      PTRSIINF-REC
           END-IF
      *
           .
       1001-HKNCOMBI-HEN-EXT.
           EXIT.
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»Ì¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       10011-HKNCOMBIMEI-HEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  WRK-HKNCOMBIMEI
      *
           STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                   "¡¡"                    DELIMITED  BY  SIZE
                   COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                   "¡¡"                    DELIMITED  BY  SIZE
                   COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                   "¡¡"                    DELIMITED  BY  SIZE
                   COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                   "¡¡"                    DELIMITED  BY  SIZE
                   COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBIMEI
           END-STRING
      *
           .
       10011-HKNCOMBIMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¿ÇÎÅ²ÊÌ¾ÊÔ½¸½èÍý
      *****************************************************************
       1000-SRYKAMEI-HEN-SEC                SECTION.
      *
      *    ¿ÇÎÅ²Ê
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    WRK-SRYKA           TO  SYS-1005-KBNCD
           MOVE    WRK-SRYYMD          TO  SYS-1005-STYUKYMD
                                           SYS-1005-EDYUKYMD
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
      *
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               IF    ( WRK-SRYKA-MEI   =   SPACE )
                   STRING  SYS-1005-SRYKANAME2
                                               DELIMITED  BY  SPACE
                   INTO            WRK-SRYKA-MEI
                   WITH    POINTER WRK-SRYKA-PNT
                   END-STRING
               ELSE
                   IF    ( WRK-SRYKA-MEI(19:2) NOT =   SPACE )
                       CONTINUE
                   ELSE
                       STRING  "¡¢"            DELIMITED  BY  SIZE
                               SYS-1005-SRYKANAME2
                                               DELIMITED  BY  SPACE
                       INTO            WRK-SRYKA-MEI
                       WITH    POINTER WRK-SRYKA-PNT
                       END-STRING
                   END-IF
               END-IF
           END-IF
      *
           .
       1000-SRYKAMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼ÊÔ½¸½èÍý
      *****************************************************************
       300-HCM43-HEN-SEC               SECTION.
      *
           INITIALIZE                  HCM43
      *
      *    ÅÁÉ¼ÈÖ¹æ
      *    MOVE    WRK-DENPNUM         TO  WRK-NO
      *    MOVE    WRK-NO              TO  HCM43-NO
      *
      *    ¿ÇÎÅ²Ê
           MOVE    WRK-SRYKA-MEI(1:20) TO  HCM43-MIDASI
      *
      *    ´µ¼ÔÈÖ¹æ
           MOVE    SPA-PTNUM           TO  HCM43-KNJNO
      *
      *    ´µ¼ÔÌ¾¾Î
           MOVE    PTINF-NAME          TO  HCM43-KNJNAMW
      *
      *    ÊÝ¸±¼ïÊÌ
           MOVE    WRK-HKNCOMBIMEI     TO  HCM43-HOKEN
      *
      *    ÉéÃ´³ä¹ç
           IF    ( SYU-PTFTNRATE   >   ZERO )
               COMPUTE WRK-WARI    =   SYU-PTFTNRATE   /   10
               IF    ( SYU-PTFTNRATE(3:1)  =   ZERO )
                   MOVE    WRK-WARI    TO  WRK-Z6
                   MOVE    WRK-Z6      TO  HCM43-FUTAN
               ELSE
                   MOVE    WRK-WARI    TO  WRK-Z62
                   MOVE    WRK-Z62     TO  HCM43-FUTAN
               END-IF
           END-IF
      *
           MOVE    "¿ÇÎÅÇ¯·î"          TO  HCM43-LBLKKN
      *
      *    ¿ÇÎÅÇ¯·î
           MOVE    WRK-SRYYMD          TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  HCM43-SRYYM
      *
      *    È¯¹ÔÆü
           MOVE    ORCHCM43-HAKYMD     TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  HCM43-HAKYMD
      *
      *    °åÎÅµ¡´Ø½»½ê
           MOVE    SYS-1002-ADRS       TO  HCM43-IRYOADRS
      *    °åÎÅµ¡´ØÌ¾
           MOVE    SYS-1001-HOSPNAME   TO  HCM43-IRYOMEI
      *    °åÎÅµ¡´Ø£Ô£Å£Ì
           MOVE    SYS-1002-TEL        TO  HCM43-IRYOTEL
      *
      *    ¼«ÈñÌ¾¾ÎÊÔ½¸
           PERFORM 3102-JIHIMSG-HEN-SEC
      *
           MOVE    SPACE               TO  WRK-Z72-G
      *
      *    ¿ÇÎÅ²Ê
           MOVE    SYU-HKNTEN (01)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO1
      *
      *    »ØÆ³²Ê
           MOVE    SYU-HKNTEN (02)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO2
      *
      *    ºßÂð²Ê
           MOVE    SYU-HKNTEN (03)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO3
      *
      *    ÅêÌô²Ê
           MOVE    SYU-HKNTEN (04)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO4
      *
      *    Ãí¼Í²Ê
           MOVE    SYU-HKNTEN (05)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO5
      *
      *    ½èÃÖ²Ê
           MOVE    SYU-HKNTEN (06)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO6
      *
      *    ¼ê½Ñ²Ê
           MOVE    SYU-HKNTEN (07)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO7
      *
      *    ¸¡ºº²Ê
           MOVE    SYU-HKNTEN (08)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO8
      *
      *    £ØÀþ²Ê
           MOVE    SYU-HKNTEN (09)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO9
      *
      *    ¤½¤ÎÂ¾ÎÁ
           MOVE    SYU-HKNTEN (10)     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HKNRYO10
      *
      *    ¹ç·×ÅÀ¿ô
           COMPUTE WRK-GOKTEN          =   SYU-HKNTEN (01)
                                       +   SYU-HKNTEN (02)
                                       +   SYU-HKNTEN (03)
                                       +   SYU-HKNTEN (04)
                                       +   SYU-HKNTEN (05)
                                       +   SYU-HKNTEN (06)
                                       +   SYU-HKNTEN (07)
                                       +   SYU-HKNTEN (08)
                                       +   SYU-HKNTEN (09)
                                       +   SYU-HKNTEN (10)
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-GOKTEN
      *
      *    Ï«ºÒ¡¦¼«Çå¤Î»þ¡¢ÅÀ¿ôÉ½¼¨¤Ê¤·
           IF    ( COMB-HKNNUM             =    "971"  OR  "973" )
               MOVE    SPACE               TO  HCM43-HKNRYO1
               MOVE    SPACE               TO  HCM43-HKNRYO2
               MOVE    SPACE               TO  HCM43-HKNRYO3
               MOVE    SPACE               TO  HCM43-HKNRYO4
               MOVE    SPACE               TO  HCM43-HKNRYO5
               MOVE    SPACE               TO  HCM43-HKNRYO6
               MOVE    SPACE               TO  HCM43-HKNRYO7
               MOVE    SPACE               TO  HCM43-HKNRYO8
               MOVE    SPACE               TO  HCM43-HKNRYO9
               MOVE    SPACE               TO  HCM43-HKNRYO10
               MOVE    ALL "*"             TO  HCM43-GOKTEN
           END-IF
      *
      *    ÊÝ¸±Å¬ÍÑÊ¬
           MOVE    SYU-HKNTEKMONEY     TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HOKENBUN
      *
      *    ÊÝ¸±Å¬ÍÑ³°ÊÔ½¸
           PERFORM VARYING IDX-JIHI    FROM    1   BY  1
                   UNTIL ( IDX-JIHI >  10 )
      *
               MOVE    ZERO      TO    WRK-Z72
               COMPUTE WRK-Z72   = SYU-TGMONEY(IDX-JIHI)  +
                                   SYU-TGMONEY-TAX(IDX-JIHI)
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-Z72-G   TO  HCM43-JIHIBUN(IDX-JIHI)
      *
           END-PERFORM
      *
      *    ÊÝ¸±Å¬ÍÑ³°¾ÃÈñÀÇ¡ÊºÆ·Ç¡Ë
           MOVE    SYU-TGMONEY-TAX-SAI TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HOKENZEI
      *
           IF    ( COMB-HKNNUM             =    "971"
                                           OR   "973" )
      *        Ï«ºÒ¡¦¼«Çå¤Î»þ¡¢ÅÀ¿ôÉ½¼¨¤Ê¤·
               EVALUATE    TRUE
               WHEN      ( COMB-HKNNUM             =    "971" )
                   AND   ( SYS-4001-RSIIRYOKBN NOT =   "1" )
      *
               WHEN      ( COMB-HKNNUM             =    "973" )
                   AND   ( PTRSI-HKNKBN        =    "4" ) 
                   AND   ( SYU-PTFTNRATE   NOT =   ZERO  )
      *
                   COMPUTE WRK-GOKTEN      =    SYU-HKNTEKMONEY
                                           +    SYU-RSISHOSHIN-MONEY
                                           +    SYU-RSISAISHIN-MONEY
                                           +    SYU-RSISDO-MONEY
                                           +    SYU-RSIETC-MONEY
                   MOVE    WRK-GOKTEN      TO  WRK-Z72
                   PERFORM 800-HENKAN-SEC
                   MOVE    WRK-Z72-G       TO  HCM43-HOKENBUN
               WHEN    OTHER
                   MOVE    SPACE           TO  HCM43-HOKENBUN
               END-EVALUATE
           END-IF
      *
      *    ÊÝ¸±Å¬ÍÑ³°Ê¬
           MOVE    ZERO                TO  WRK-GOKTEN
           COMPUTE WRK-GOKTEN          =   SYU-TGMONEY (12)
                                       +   SYU-TGMONEY-TAX  (12)
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-HOKENGAI
      *
      *    ¼«Èñ£±¤«¤é£µ
           MOVE    ZERO                TO  WRK-JIHI-REC
           PERFORM VARYING IDX2     FROM    1   BY  1
                   UNTIL ( IDX2     >  5 )
               COMPUTE WRK-JIHI (IDX2)     =   SYU-JIHI-TAXNASI (IDX2)
                                           +   SYU-JIHI-TAXARI  (IDX2)
               MOVE    WRK-JIHI (IDX2)  TO  WRK-Z72
               PERFORM 800-HENKAN-SEC
               MOVE    WRK-Z72-G       TO  HCM43-JIHI(IDX2)
           END-PERFORM
      *
      *    ¼«Èñ·×
           COMPUTE WRK-JIHI-TOTAL      =   SYU-JIHI-TOTAL
                                       +   SYU-JIHI-TOTAL-TAX
      *
      *    ¼«Èñ¾ÃÈñÀÇ
           MOVE    SYU-JIHI-TAX        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-JIHI(7)
      *
      *    ¼«Èñ¹ç·×
           COMPUTE WRK-GOKTEN          =   WRK-JIHI-TOTAL
                                       +   SYU-JIHI-TAX
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-JIHI(6)
      *
      *    ÌôºÞ°ìÉôÉéÃ´
           MOVE    SYU-YKZ-FTN         TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-YAKUZAI
      *
      *    Ï·¿Í°ìÉôÉéÃ´¶â
           MOVE    SYU-RJN-FTN         TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-ROUJIN
      *
      *    ¸øÈñ°ìÉôÉéÃ´¶â
           MOVE    SYU-KOH-FTN         TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-KOUHI
      *
      *    Ä´À°¶â
           MOVE    SYU-CHOSEI          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-CHOSEI
      *
      *    º£²óÀÁµá³Û
           MOVE    SYU-SKYMONEY        TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-KONSEIKYU
      *
      *    º£²óÀÁµá³Û¾ÃÈñÀÇ¡ÊºÆ·Ç¡Ë
           MOVE    SYU-SKYMONEY-TAX-SAI
                                       TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-SEIKYUZEI
      *
      *    º£²óÆþ¶â³Û
           MOVE    SYU-NYUKIN-TOTAL    TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-KONNYUKIN
      *
      *    Á°²óÌ¤¼ý³Û·×»»
           MOVE    ZERO                TO  WRK-MISYUMONEY
           IF    ( IDX-SYU =   1 )
               PERFORM 3001-MISYU-SEC
           END-IF
      *
           MOVE    WRK-MISYUMONEY      TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-ZENMISYU
      *
      *    ¹ç·×ÀÁµá³Û
           COMPUTE WRK-GOKTEN          =   SYU-SKYMONEY
                                       +   WRK-MISYUMONEY
           MOVE    WRK-GOKTEN          TO  WRK-Z72
           PERFORM 800-HENKAN-SEC
           MOVE    WRK-Z72-G           TO  HCM43-GOUKEIGAK
      *
           .
       300-HCM43-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Á°²óÌ¤¼ýÊÔ½¸½èÍý
      *****************************************************************
       3001-MISYU-SEC                  SECTION.
      *
           PERFORM 900-SYUNOU-KEY38-SEL-SEC
      *
           COMPUTE WRK-MISYUMONEY
               =   WKSYU-SKYMONEY  -   WKSYU-NYUKIN-TOTAL
      *
           .
       3001-MISYU-EXT.
           EXIT.
      *****************************************************************
      *    Ä¢É¼°õºþ½èÍý
      *****************************************************************
       400-PRINT-SEC                SECTION.
      *
           MOVE    SPA-PTID            TO  SPRT-PTID
           MOVE    "HCM43.red"         TO  SPRT-PRTID
           MOVE    HCM43               TO  SPRT-PRTDATA
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF    ( SPRT-RETURN         =   ZERO )
               CONTINUE
           ELSE
               DISPLAY "ORCSPRT ERR !!! PTID = " SPA-PTID
           END-IF
      *
           COMPUTE ORCHCM43-PAGE   =   ORCHCM43-PAGE   +   1
      *
           .
       400-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ê£¿ô¿ÇÎÅ²ÊÊÔ½¸½èÍý
      *****************************************************************
       2021-GRP-SRYKAMEI-HEN-SEC             SECTION.
      *
           MOVE    HCM43S01-GRP-SRYKA-MAX (IDX-SYU)
                                       TO  WRK-SRYKA-MAX
      *
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL     ( IDX1    >   WRK-SRYKA-MAX )
      *
               MOVE    HCM43S01-GRP-SRYKA (IDX-SYU IDX1)
                                       TO  WRK-SRYKA
               PERFORM 1000-SRYKAMEI-HEN-SEC
      *
           END-PERFORM
      *
           .
       2021-GRP-SRYKAMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    È¾³ÑÁ´³ÑÊÑ´¹½èÍý
      *****************************************************************
       800-HENKAN-SEC             SECTION.
     *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
      *****MOVE    WRK-Z72             TO  KANACHK-MAE-INPUT
           IF      WRK-Z72             <   ZERO
               MOVE    WRK-Z72             TO  WRK-Z72-HS
               MOVE    WRK-Z72-HS          TO  KANACHK-MAE-INPUT
           ELSE
               MOVE    WRK-Z72             TO  WRK-Z72-H
               MOVE    WRK-Z72-H           TO  KANACHK-MAE-INPUT
           END-IF
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
               MOVE    KANACHK-OUT-INPUT(1:18)    TO  WRK-Z72-G
           END-IF
           .
       800-HENKAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼«ÈñÌ¾¾ÎÊÔ½¸½èÍý
      *****************************************************************
       3102-JIHIMSG-HEN-SEC             SECTION.
      *
           MOVE    WRK-JIHIMEI(1)      TO  HCM43-JIHIMSG1
           MOVE    WRK-JIHIMEI(2)      TO  HCM43-JIHIMSG2
           MOVE    WRK-JIHIMEI(3)      TO  HCM43-JIHIMSG3
           MOVE    WRK-JIHIMEI(4)      TO  HCM43-JIHIMSG4
           MOVE    WRK-JIHIMEI(5)      TO  HCM43-JIHIMSG5
      *
           .
       3102-JIHIMSG-HEN-EXT.
           EXIT.
      *****************************************************************
      *    À¾ÎñÆüËÜ¸ìÊÑ´¹½èÍý
      *****************************************************************
       31012-SEIWA-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½ªÎ»¡¡¡¡½èÍý
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¸¡º÷½èÍý(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    PATH-TBL-SYSKANRI-KEY2
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¸¡º÷½èÍý(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-FET-SEC      SECTION.
      *
           MOVE    PATH-TBL-SYSKANRI-KEY2
                                       TO  MCP-PATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¸¡º÷½èÍý(KEY10)
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    PATH-TBL-SYSKANRI-KEY10
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           MOVE    PATH-TBL-SYSKANRI-KEY10
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-SYSKANRI-KEY10-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»¸¡º÷½èÍý(KEY)
      *****************************************************************
       900-HKNCOMBI-KEY-SEL-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNCOMBI
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-HKNCOMBI-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
            ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
            END-IF
      *
           MOVE    PATH-TBL-HKNCOMBI-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ´µ¼ÔÏ«ºÒÊÝ¸±¾ðÊóÆÉ¤ß¹þ¤ß
      *****************************************************************
       900-PTRSIINF-KEY-SEC            SECTION.
      *
           MOVE    ZERO                TO  FLG-PTRSIINF
      *
           MOVE    PTRSIINF-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-PTRSIINF-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTRSIINF-REC
           ELSE
               MOVE    1               TO  FLG-PTRSIINF
               INITIALIZE                  PTRSIINF-REC
           END-IF
     *
           MOVE    PATH-TBL-PTRSIINF-KEY
                                       TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-PTRSIINF-KEY-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼Ô¥Þ¥¹¥¿¡¼ÆÉ¤ß¹þ¤ß
      *****************************************************************
       900-PTINF-KEY-SEC               SECTION.
      *
           INITIALIZE                  PTINF-REC
           MOVE    SPA-HOSPID      TO  PTINF-HOSPID
           MOVE    SPA-PTID        TO  PTINF-PTID
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTINF-REC
           ELSE
               MOVE    1           TO  FLG-PTINF
               INITIALIZE              PTINF-REC
           END-IF
      *
           MOVE    PATH-TBL-PTINF-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-PTINF-KEY-EXT.
           EXIT.
      *****************************************************************
      *    ¼ýÇ¼¸¡º÷½èÍý(KEY38)
      *****************************************************************
       900-SYUNOU-KEY38-SEL-SEC        SECTION.
      *
           INITIALIZE                  WKSYUNOU-REC
           MOVE    SPA-HOSPID      TO  WKSYU-HOSPID
           MOVE    SPA-NYUGAIKBN   TO  WKSYU-NYUGAIKBN
           MOVE    SPA-PTID        TO  WKSYU-PTID
           STRING  ORCHCM43-STSRYYM    DELIMITED   BY  SPACE
                   "01"                DELIMITED   BY  SIZE
           INTO    WKSYU-SRYYMD
           END-STRING
      *
           MOVE    WKSYUNOU-REC    TO  MCPDATA-REC
           MOVE    PATH-TBL-SYUNOU-KEY38
                                   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  WKSYUNOU-REC
           ELSE
               INITIALIZE              WKSYUNOU-REC
           END-IF
      *
           .
      *
       900-SYUNOU-KEY38-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ¥Æ¡¼¥Ö¥ë¸¡º÷½èÍý
      *****************************************************************
       910-DBSELECT-SEC          SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF        ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ¥Æ¡¼¥Ö¥ëÆÉ¹þ½èÍý
      *****************************************************************
       910-DBFETCH-SEC            SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ¥Æ¡¼¥Ö¥ë¥¯¥í¡¼¥º½èÍý
      *****************************************************************
       910-DBCLOSE-SEC           SECTION.
      *
      *    MOVE    "DBCLOSE"       TO  MCP-FUNC
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
       910-DBCLOSE-EXT.
           EXIT.
