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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBM031.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : ·î¼¡Ä¢É¼
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : ¹ñÊÝ¡¦Áí³çÉ½¡Ê°å²Ê¡¦»õ²Ê¡Ë
      *                      £È£Ã£Í£²£Ñ¡¢£È£Ã£Í£²£Ò
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  03/09/01    NACL-¿¹ÏÆ     ¿·µ¬ºîÀ®
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
      *    ¥¨¥é¡¼¥Õ¥¡¥¤¥ë
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    ¥¨¥é¡¼¥Õ¥¡¥¤¥ë
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    ¥¨¥é¡¼¥Õ¥¡¥¤¥ë Ì¾¾ÎÎÎ°è 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
           COPY    "HCM2Q.INC".
           COPY    "HCM2R.INC".
      *
      *    ¥¹¥ÑÎÎ°è
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-UPD             PIC 9(01).
      *
           03  FLG-RECE10          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-PRTKBN          PIC 9(01).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
      *
      *    ¥Ñ¥é¥á¥¿ÎÎ°è
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-HOSPID     PIC X(24).
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-NYUGAIKBN  PIC X(01).
           03  WRK-PARA-HKNJANUM   PIC X(08).
      *
      *    °ì»þÎÎ°è
       01  WRK-AREA.
           03  WRK-SEIYMDWH        PIC X(22).
           03  WRK-SRYYMWH         PIC X(16).
           03  WRK-SRYYMD          PIC X(08).
      *
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(22).
      *
           03  WRK-RECEERR         PIC X(200).
           03  WRK-PATH            PIC X(64).
      *
      *    ¿ô»ú¹àÌÜÊÔ½¸
           03  WRK-KENSUZ          PIC ZZZZ.
           03  WRK-TENSUZ          PIC ZZZZZZZZ.
           03  WRK-ITBFTNZ         PIC ZZZZZZZZ.
           03  WRK-PAGE            PIC ZZZ9.
      *
      *    ¥«¥¦¥ó¥ÈÎÎ°è
       01  CNT-AREA.
           03  CNT-PAGE            PIC 9(04).
           03  CNT-RECE10          PIC 9(06).
           03  CNT-LINE            PIC 9(02).
      *
      *    ½¸·×ÎÎ°è
       01  SUM-AREA.
      *    ¹ñÌ±·ò¹¯ÊÝ¸±(1¡Á9)Ï·¿ÍÊÝ·ò(10¡Á11)¸øÈñÉéÃ´(12)
           03  SUM-TBL             OCCURS  12.
               05  SUM-KENSU           PIC 9(06).
               05  SUM-TOTALTEN        PIC 9(10).
               05  SUM-FTNMONEY        PIC 9(10).
               05  SUM-YKZFTN          PIC 9(10).
               05  SUM-SHOKUJIKENSU    PIC 9(06).
               05  SUM-SHOKUJIRYOYOHI  PIC 9(10).
               05  SUM-SHOKUJIFTN      PIC 9(10).
      *    ¿©»ö½¸·×
           03  SUM-SHO-TBL         OCCURS  2.
               05  SUM-SHO-KENSU       PIC 9(06).
               05  SUM-SHO-RYOYOHI     PIC 9(10).
               05  SUM-SHO-FTN         PIC 9(10).
      *
      *    Áí·×ÎÎ°è
       01  GSUM-AREA.
      *    ¹ñÌ±·ò¹¯ÊÝ¸±(1¡Á9)Ï·¿ÍÊÝ·ò(10¡Á11)¸øÈñÉéÃ´(12)
           03  GSUM-G-TBL          OCCURS  12.
               05  GSUM-KENSU          PIC 9(06).
               05  GSUM-TOTALTEN       PIC 9(10).
               05  GSUM-FTNMONEY       PIC 9(10).
               05  GSUM-YKZFTN         PIC 9(10).
      *    ¿©»öÁí·×
           03  GSUM-SHO-TBL        OCCURS  2.
               05  GSUM-SHO-KENSU      PIC 9(06).
               05  GSUM-SHO-RYOYOHI    PIC 9(10).
               05  GSUM-SHO-FTN        PIC 9(10).
      *
      *    ¥­¡¼ÎÎ°è
       01  KEY-AREA            VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-HKNJANUM      PIC X(08).
           03  KEY-OLD.
               05  KEY-O-HKNJANUM      PIC X(08).
      *
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "ORCA-DBPATH".
      *
      *    ¸ÇÄê¹àÌÜ
       01  WRK-CONS-AREA.
      *    £²£°£°£²Ç¯£±£°·î²þÀµ
           03  WRK-CONS-SRYYM          PIC X(06)   VALUE   "200210".
      *    £²£°£°£³Ç¯£´·î²þÀµ
           03  WRK-CONS-SRYYM-200304   PIC X(06)   VALUE   "200304".
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    °åÎÅµ¡´Ø¾ðÊó¾ðÊó
           COPY    "CPSK1001.INC".
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ¡¢Ï¢ÍíÀè
           COPY    "CPSK1002.INC".
      *
      *    ÀÁµá´ÉÍý
           COPY    "CPRCF010.INC".
      *
      *    ´µ¼Ô
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    ¥¸¥ç¥Ö´ÉÍý¥Þ¥¹¥¿
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    °õºþ´ÉÍý
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    °õºþ
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      ******************************************************************
      *    ¥µ¥Ö¥×¥íÍÑ¡¡ÎÎ°è
      *****************************************************************
      *
      *    ¥¸¥ç¥Ö´ÉÍý£Ä£ÂÀ©¸æ¥µ¥Ö
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    °õºþ£Ä£Â¹¹¿·¥µ¥Ö
           COPY    "CPORCSPRT.INC".
      *
      *   ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ¶¦ÄÌ¥Ñ¥é¥á¥¿
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                     SECTION.
       01  COMMAND-PARAM.
           02  FILLER              PIC X(256).
      ****************************************************************
       PROCEDURE               DIVISION
               USING
           COMMAND-PARAM.
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL   FLG-END     =   1
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    ½é´ü¡¡½èÍý
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SUM-AREA
           INITIALIZE                  GSUM-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    LNK-PRTKANRI-RENNUM
                                               LNK-PRTKANRI-TBL-KEY
                                               LNK-PRTKANRI-TBL-GROUP
                                               LNK-PRTKANRI-SHORI-RENNUM
                                               LNK-PRTKANRI-SRYYM
                                               LNK-PRTKANRI-SKYYMD
                                               LNK-PRTKANRI-SHELLID
                                               LNK-PRTKANRI-PRIORITY
                                               LNK-PRTKANRI-TERMID
                                               LNK-PRTKANRI-OPID
                                               LNK-PRTKANRI-PRTNM
                                               WRK-PARA-HOSPID
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
                                               WRK-PARA-NYUGAIKBN
                                               WRK-PARA-HKNJANUM
      *
      *    ¥¹¥Æ¥Ã¥×´ÉÍý³«»Ï½èÍý
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBM031"      TO  JOB-PGID
           MOVE    "¿ÇÎÅÊó½·ÀÁµá½ñ¡Ê°å²Ê¡¦»õ²Ê¡Ë"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    "RECEERR"       TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  RECEERR-TERMID
      *
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  WRK-SRYYMD (1:6)
           MOVE    "01"            TO  WRK-SRYYMD (7:2)
      *
           MOVE    WRK-SRYYMD      TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)
                                   TO  WRK-SRYYMWH
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           IF          STS-DAY-RC1     =   ZERO
               MOVE    LNK-DAY2-EDTYMD3
                                       TO  WRK-SEIYMDWH
           END-IF
      *
      *    °åÎÅµ¡´Ø£É£ÄÊÔ½¸
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"          TO  SYS-1001-KANRICD
           MOVE    "*"             TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC    TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF          FLG-SYSKANRI    =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
               IF          SYS-1001-HOSPNAME   =   LOW-VALUE
                   MOVE    SPACE           TO  SYS-1001-HOSPNAME
               END-IF
               IF          SYS-1001-KAISETUNAME    =   LOW-VALUE
                   MOVE    SPACE           TO  SYS-1001-KAISETUNAME
               END-IF
           ELSE
               MOVE    "°åÎÅµ¡´Ø¾ðÊó¤¬¼èÆÀ¤Ç¤­¤Þ¤»¤ó¤Ç¤·¤¿"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    °åÎÅµ¡´Ø¾ðÊó¡Ý½êºßÃÏ
           INITIALIZE                  SYS-1002-REC
           MOVE    "1002"          TO  SYS-1002-KANRICD
           MOVE    "*"             TO  SYS-1002-KBNCD
           MOVE    SYS-1002-REC    TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF          FLG-SYSKANRI    =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1002-REC
               IF          SYS-1002-ADRS   =   LOW-VALUE
                   MOVE    SPACE           TO  SYS-1002-ADRS
               END-IF
           ELSE
               MOVE    "°åÎÅµ¡´Ø¾ðÊó¡Ê½êºßÃÏ¡Ë¤¬¼èÆÀ¤Ç¤­¤Þ¤»¤ó¤Ç¤·¤¿"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ç½èÍý
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    Æþ±¡³°¡Ê¤½¤ÎÂ¾¤Î¥ì¥»¡Ë¡¦Æþ±¡½¸·×
           MOVE    LOW-VALUE       TO  KEY-AREA
      *
           MOVE    "SEIKYU-KEY4"   TO  WRK-PATH
           PERFORM 900-SEIKYU-SELECT-SEC
      *
           PERFORM 200-HENSYU-SEC
                   UNTIL ( FLG-RECE10   =   1 )
                   OR    ( FLG-ERR      =   1 )
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    WRK-PATH        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    1               TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½¸·×½èÍý
      *****************************************************************
       200-HENSYU-SEC              SECTION.
      *
           INITIALIZE                  SUM-AREA
      *
           MOVE    KEY-NEW         TO  KEY-OLD
           PERFORM UNTIL ( FLG-END     =   1 )
                   OR    ( KEY-NEW NOT =   KEY-OLD )
               PERFORM 2001-SYUKEI-SEC
           END-PERFORM
      *
           IF        ( FLG-UPD     =   1 )
               AND   ( FLG-ERR     =   ZERO )
               PERFORM 2002-PRINT-HENSYU-SEC
           END-IF
      *
           .
       200-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÊÝ¸±¼ÔÊÌ½¸·×½èÍý
      *****************************************************************
       2001-SYUKEI-SEC             SECTION.
      *
           MOVE    ZERO            TO  IDX-AREA
                                       FLG-UPD
      *
      *    Ï·¿ÍÊÝ·ò
           IF      RECE10-RJNHKNNUM    NOT =   SPACE
               EVALUATE    RECE10-KYURATE
               WHEN    9
                   MOVE    10              TO  IDX
               WHEN    8
                   MOVE    11              TO  IDX
               END-EVALUATE
           ELSE
      *        ¹ñÌ±·ò¹¯ÊÝ¸±
               EVALUATE    RECE10-HKNNUM-S
               WHEN    "060"
                   IF          RECE10-AGE      >=  70
                       EVALUATE    RECE10-KYURATE
                       WHEN    9
                           MOVE    1           TO  IDX
                       WHEN    8
                           MOVE    2           TO  IDX
                       END-EVALUATE
                   ELSE
                       IF          RECE10-AGE      <   3
                           MOVE    4           TO  IDX
                       ELSE
                           MOVE    3           TO  IDX
                       END-IF
                   END-IF
               WHEN    "067"
                   IF          RECE10-AGE      >=  70
                       EVALUATE    RECE10-KYURATE
                       WHEN    9
                           MOVE    6           TO  IDX
                       WHEN    8
                           MOVE    7           TO  IDX
                       END-EVALUATE
                   ELSE
                       IF          RECE10-AGE      <   3
                           MOVE    9               TO  IDX
                       ELSE
                           IF          RECE10-HONKZKKBN    =   "1"
                               MOVE    5               TO  IDX
                           ELSE
                               MOVE    8               TO  IDX
                           END-IF
                       END-IF
                   END-IF
               END-EVALUATE
           END-IF
           PERFORM 20011-HKN-SYUKEI-SEC
      *
      *    ¸øÈñÉéÃ´Ê¬
           IF          RECE10-KOHNUM(1)   NOT =   SPACE
               PERFORM 20012-KOH-SYUKEI-SEC
           END-IF
      *
      *    ½¸·×¤ÎÂÐ¾Ý¤Ë¤Ê¤é¤Ê¤«¤Ã¤¿¤È¤­
           IF          FLG-UPD     =   1
               MOVE    WRK-PATH       TO  ORC-DBPATH
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    SPACE          TO  WRK-RECEERR
               STRING "½¸·×ÂÐ¾Ý³°¡¡´µ¼ÔÈÖ¹æ¡á"     DELIMITED  BY  SIZE
                       RECE10-PTNUM                DELIMITED  BY  SPACE
                       " ¿ÇÎÅÇ¯·î¡á"               DELIMITED  BY  SIZE
                       RECE10-SRYYM                DELIMITED  BY  SIZE
                       " ¥ì¥»¼ïÊÌ¡á"               DELIMITED  BY  SIZE
                       RECE10-RECESYUBETU          DELIMITED  BY  SIZE
                                           INTO    WRK-RECEERR
               END-STRING
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           .
       2001-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    °åÎÅÊÝ¸±¡¦Ï·¿ÍÊÝ·òÊ¬½¸·×½èÍý
      *****************************************************************
       20011-HKN-SYUKEI-SEC        SECTION.
      *
           IF        ( IDX         =   ZERO )
               OR    ( RECE10-NYUGAIKBN    =   ZERO )
               GO  TO  20011-HKN-SYUKEI-EXT
           END-IF
      *
      *    ·ï¿ô
           ADD     1               TO  SUM-KENSU(IDX)
      *
      *    ÎÅÍÜ¤ÎµëÉÕ 
           ADD     RECE10-TOTALTEN(1)
                                   TO  SUM-TOTALTEN(IDX)
           ADD     RECE10-FTNMONEY(1)
                                   TO  SUM-FTNMONEY(IDX)
           IF        ( RECE10-NYUGAIKBN    =   "2")
               AND   ( IDX                =   3   OR  5   OR  8 )
               ADD     RECE10-YKZFTN(1)
                                       TO  SUM-YKZFTN(IDX)
           END-IF
      *    ¿©»öÎÅÍÜ
           IF          RECE10-NYUGAIKBN    =   "1"
               IF          RECE10-SHOKUJINISSU(1)   >   ZERO
                   ADD     1       TO   SUM-SHOKUJIKENSU(IDX)
                   ADD     RECE10-SHOKUJIRYOYOHI(1)
                                   TO   SUM-SHOKUJIRYOYOHI(IDX)
                   ADD     RECE10-SHOKUJIFTN(1)
                                   TO   SUM-SHOKUJIFTN(IDX)
               END-IF
           END-IF
      *
           MOVE    1               TO  FLG-UPD
           .
       20011-HKN-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¸øÈñÉéÃ´Ê¬½¸·×½èÍý
      *****************************************************************
       20012-KOH-SYUKEI-SEC        SECTION.
      *
           PERFORM VARYING IDZ     FROM    1   BY  1
                   UNTIL ( IDZ     >       4 )
                   OR    ( RECE10-KOHNUM(IDZ)  =   SPACE )
               COMPUTE IDY     =   IDZ     +   1
      *
      *        ·ï¿ô
               ADD     1               TO  SUM-KENSU(12)
      *
      *        ÎÅÍÜ¤ÎµëÉÕ
               ADD     RECE10-TOTALTEN(IDY)
                                   TO  SUM-TOTALTEN(12)
               ADD     RECE10-FTNMONEY(IDY)
                                   TO  SUM-FTNMONEY(12)
      *
               EVALUATE    RECE10-NYUGAIKBN
               WHEN    "2"
                   ADD     RECE10-YKZFTN(IDY)
                                       TO  SUM-YKZFTN(12)
      *        ¿©»öÎÅÍÜ
               WHEN    "1"
                   IF      RECE10-SHOKUJINISSU(IDY)   >   ZERO
                       ADD     1   TO  SUM-SHOKUJIKENSU(12)
                       ADD     RECE10-SHOKUJIRYOYOHI(IDY)
                                   TO  SUM-SHOKUJIRYOYOHI(12)
                       ADD     RECE10-SHOKUJIFTN(IDY)
                                   TO  SUM-SHOKUJIFTN(12)
                   END-IF
               END-EVALUATE
      *
               MOVE    1               TO  FLG-UPD
           END-PERFORM
           .
       20012-KOH-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼¥Õ¥¡¥¤¥ë½ÐÎÏ½èÍý
      *****************************************************************
       2002-PRINT-HENSYU-SEC       SECTION.
      *
      *    Ä¢É¼ÊÔ½¸<¸«½Ð¤·>½èÍý
           IF          CNT-LINE    =   ZERO
               PERFORM 20021-HEAD-HEN-SEC
           END-IF
      *
      *    Ä¢É¼ÊÔ½¸<ÌÀºÙ>½èÍý
           PERFORM 20022-BODY-HEN-SEC
      *
      *    Ä¢É¼°õºþ½èÍý
           IF          CNT-LINE       =   23
               PERFORM 20024-PRINT-OUT-SEC
               MOVE    ZERO                TO  CNT-LINE
           END-IF
      *
           IF          FLG-RECE10     =   1
               IF          CNT-LINE   =   ZERO
                   PERFORM 20021-HEAD-HEN-SEC
               END-IF
               PERFORM 20023-GOKEI-HEN-SEC
               PERFORM 20024-PRINT-OUT-SEC
           END-IF
      *
           .
       2002-PRINT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼ÊÔ½¸<¥Ø¥Ã¥À¡¼Éô>½èÍý
      *****************************************************************
       20021-HEAD-HEN-SEC          SECTION.
      *
           INITIALIZE                  HCM2Q
           INITIALIZE                  HCM2R
      *
           MOVE    WRK-SEIYMDWH    TO  HCM2Q-SEIYMD
      *
           MOVE    WRK-SRYYMWH     TO  HCM2Q-PRTYM
      *
      *    °åÎÅµ¡´Ø½»½ê
           MOVE    SYS-1002-ADRS   TO  HCM2Q-ADRS
      *    °åÎÅµ¡´ØÌ¾
           MOVE    SYS-1001-HOSPNAME   TO  HCM2Q-HOSPNAME
      *
           MOVE    SYS-1001-KAISETUNAME
                                   TO  HCM2Q-KAISETUNAME
      *
           MOVE    SYS-1001-HOSPCDN    TO  HCM2Q-HOSPCD
           MOVE    SYS-1001-HOSPCDN    TO  HCM2R-HOSPCD
      *
           .
       20021-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼ÊÔ½¸<ÌÀºÙ¹Ô>½èÍý
      *****************************************************************
       20022-BODY-HEN-SEC          SECTION.
      *
           ADD     1               TO  CNT-LINE
      *
           MOVE    KEY-O-HKNJANUM  TO  HCM2Q-HKNJANUM(CNT-LINE)
           MOVE    KEY-O-HKNJANUM  TO  HCM2R-HKNJANUM(CNT-LINE)
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >   12
               EVALUATE    IDX
      *        ¹ñÌ±·ò¹¯ÊÝ¸±
               WHEN    1   THRU    4
                   MOVE    SUM-KENSU(IDX)  TO  WRK-KENSUZ
                   MOVE    WRK-KENSUZ  TO  HCM2Q-IPN-KENSU(CNT-LINE IDX)
                   MOVE    SUM-TOTALTEN(IDX)
                                       TO  WRK-TENSUZ
                   MOVE    WRK-TENSUZ  TO  HCM2Q-IPN-TENSU(CNT-LINE IDX)
                   EVALUATE    IDX
                   WHEN    1   THRU    2
                       MOVE    SUM-FTNMONEY(IDX)
                                       TO  WRK-ITBFTNZ
                       MOVE    WRK-ITBFTNZ
                               TO  HCM2Q-IPN-ITBFTN(CNT-LINE IDX)
                   WHEN    3
                       MOVE    SUM-YKZFTN(IDX)
                                       TO  WRK-ITBFTNZ
                       MOVE    WRK-ITBFTNZ
                               TO  HCM2Q-IPN-ITBFTN(CNT-LINE IDX)
                   END-EVALUATE
      *
                   ADD     SUM-SHOKUJIKENSU(IDX)
                                           TO  SUM-SHO-KENSU(1)
                   ADD     SUM-SHOKUJIRYOYOHI(IDX)
                                           TO  SUM-SHO-RYOYOHI(1)
                   ADD     SUM-SHOKUJIFTN(IDX)
                                           TO  SUM-SHO-FTN(1)
      *        ¹ñÌ±·ò¹¯ÊÝ¸±¡ÊÂà¿¦¼Ô¡Ë
               WHEN    5   THRU    9
                   COMPUTE IDZ             =   IDX     -   4
                   MOVE    SUM-KENSU(IDX)  TO  WRK-KENSUZ
                   MOVE    WRK-KENSUZ  TO  HCM2R-TAI-KENSU(CNT-LINE IDZ)
                   MOVE    SUM-TOTALTEN(IDX)
                                       TO  WRK-TENSUZ
                   MOVE    WRK-TENSUZ  TO  HCM2R-TAI-TENSU(CNT-LINE IDZ)
                   EVALUATE    IDX
                   WHEN    5
                   WHEN    8
                       MOVE    SUM-YKZFTN(IDX)
                                       TO  WRK-ITBFTNZ
                       MOVE    WRK-ITBFTNZ
                               TO  HCM2R-TAI-ITBFTN(CNT-LINE IDZ)
                   WHEN    6   THRU    7
                       MOVE    SUM-FTNMONEY(IDX)
                                       TO  WRK-ITBFTNZ
                       MOVE    WRK-ITBFTNZ
                               TO  HCM2R-TAI-ITBFTN(CNT-LINE IDZ)
                   END-EVALUATE
      *
                   ADD     SUM-SHOKUJIKENSU(IDX)
                                           TO  SUM-SHO-KENSU(2)
                   ADD     SUM-SHOKUJIRYOYOHI(IDX)
                                           TO  SUM-SHO-RYOYOHI(2)
                   ADD     SUM-SHOKUJIFTN(IDX)
                                           TO  SUM-SHO-FTN(2)
      *        Ï·¿ÍÊÝ·ò
               WHEN    10  THRU    11
                   COMPUTE IDZ             =   IDX     -   9
                   MOVE    SUM-KENSU(IDX)      TO  WRK-KENSUZ
                   MOVE    WRK-KENSUZ
                           TO  HCM2Q-ROU-KENSU(CNT-LINE IDZ)
                   MOVE    SUM-TOTALTEN(IDX)   TO  WRK-TENSUZ
                   MOVE    WRK-TENSUZ
                           TO  HCM2Q-ROU-TENSU(CNT-LINE IDZ)
                   MOVE    SUM-FTNMONEY(IDX)   TO  WRK-ITBFTNZ
                   MOVE    WRK-ITBFTNZ
                           TO  HCM2Q-ROU-ITBFTN(CNT-LINE IDZ)
      *
                   ADD     SUM-SHOKUJIKENSU(IDX)
                                           TO  SUM-SHO-KENSU(1)
                   ADD     SUM-SHOKUJIRYOYOHI(IDX)
                                           TO  SUM-SHO-RYOYOHI(1)
                   ADD     SUM-SHOKUJIFTN(IDX) TO  SUM-SHO-FTN(1)
      *        ¸øÈñ
               WHEN    12
                   MOVE    SUM-KENSU(IDX)  TO  WRK-KENSUZ
                   MOVE    WRK-KENSUZ      TO  HCM2R-KOU-KENSU(CNT-LINE)
                   MOVE    SUM-TOTALTEN(IDX)
                                           TO  WRK-TENSUZ
                   MOVE    WRK-TENSUZ      TO  HCM2R-KOU-TENSU(CNT-LINE)
                   MOVE    SUM-FTNMONEY(IDX)
                                           TO  WRK-ITBFTNZ
                   MOVE    WRK-ITBFTNZ TO  HCM2R-KOU-ITBFTN(CNT-LINE)
                   MOVE    SUM-YKZFTN(IDX) TO  WRK-ITBFTNZ
                   MOVE    WRK-ITBFTNZ TO  HCM2R-KOU-KNJFTN(CNT-LINE)
      *
                   ADD     SUM-SHOKUJIKENSU(IDX)
                                   TO  SUM-SHO-KENSU(2)
                   ADD     SUM-SHOKUJIRYOYOHI(IDX)
                                   TO  SUM-SHO-RYOYOHI(2)
                   ADD     SUM-SHOKUJIFTN(IDX)
                                   TO  SUM-SHO-FTN(2)
               END-EVALUATE
      *
               ADD     SUM-KENSU(IDX)      TO  GSUM-KENSU(IDX)
               ADD     SUM-TOTALTEN(IDX)   TO  GSUM-TOTALTEN(IDX)
               ADD     SUM-FTNMONEY(IDX)   TO  GSUM-FTNMONEY(IDX)
               ADD     SUM-YKZFTN(IDX)     TO  GSUM-YKZFTN(IDX)
      *
           END-PERFORM
      *
           MOVE    SUM-SHO-KENSU(1)    TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ          TO  HCM2Q-SYO-KENSU(CNT-LINE)
           MOVE    SUM-SHO-RYOYOHI(1)  TO  WRK-TENSUZ
           MOVE    WRK-TENSUZ          TO  HCM2Q-SYO-TENSU(CNT-LINE)
           MOVE    SUM-SHO-FTN(1)      TO  WRK-ITBFTNZ
           MOVE    WRK-ITBFTNZ         TO  HCM2Q-SYO-ITBFTN(CNT-LINE)
      *
           MOVE    SUM-SHO-KENSU(2)    TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ          TO  HCM2R-SYO-KENSU(CNT-LINE)
           MOVE    SUM-SHO-RYOYOHI(2)  TO  WRK-TENSUZ
           MOVE    WRK-TENSUZ          TO  HCM2R-SYO-TENSU(CNT-LINE)
           MOVE    SUM-SHO-FTN(2)      TO  WRK-ITBFTNZ
           MOVE    WRK-ITBFTNZ         TO  HCM2R-SYO-ITBFTN(CNT-LINE)
      *
           PERFORM VARYING IDX FROM 1 BY 1
                   UNTIL   IDX      >  2
               ADD     SUM-SHO-KENSU(IDX)  TO  GSUM-SHO-KENSU(IDX)
               ADD     SUM-SHO-RYOYOHI(IDX)    TO  GSUM-SHO-RYOYOHI(IDX)
               ADD     SUM-SHO-FTN(IDX)    TO  GSUM-SHO-FTN(IDX)
           END-PERFORM
      *
           INITIALIZE                  SUM-AREA
      *
           .
       20022-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼ÊÔ½¸<¹ç·×¹Ô>½èÍý
      *****************************************************************
       20023-GOKEI-HEN-SEC         SECTION.
      *
           MOVE    23              TO  CNT-LINE
      *
           MOVE    "¡¡¹ç¡¡·×"      TO  HCM2Q-HKNJANUM(CNT-LINE)
           MOVE    "¡¡¹ç¡¡·×"      TO  HCM2R-HKNJANUM(CNT-LINE)
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >   12
               EVALUATE    IDX
      *        ¹ñÌ±·ò¹¯ÊÝ¸±
               WHEN    1   THRU    4
                   MOVE    GSUM-KENSU(IDX) TO  WRK-KENSUZ
                   MOVE    WRK-KENSUZ  TO  HCM2Q-IPN-KENSU(CNT-LINE IDX)
                   MOVE    GSUM-TOTALTEN(IDX)
                                       TO  WRK-TENSUZ
                   MOVE    WRK-TENSUZ  TO  HCM2Q-IPN-TENSU(CNT-LINE IDX)
                   EVALUATE    IDX
                   WHEN    1   THRU    2
                       MOVE    GSUM-FTNMONEY(IDX)
                                       TO  WRK-ITBFTNZ
                       MOVE    WRK-ITBFTNZ
                               TO  HCM2Q-IPN-ITBFTN(CNT-LINE IDX)
                   WHEN    3
                       MOVE    GSUM-YKZFTN(IDX)
                                       TO  WRK-ITBFTNZ
                       MOVE    WRK-ITBFTNZ
                               TO  HCM2Q-IPN-ITBFTN(CNT-LINE IDX)
                   END-EVALUATE
      *        ¹ñÌ±·ò¹¯ÊÝ¸±¡ÊÂà¿¦¼Ô¡Ë
               WHEN    5   THRU    9
                   COMPUTE IDZ             =   IDX     -   4
                   MOVE    GSUM-KENSU(IDX) TO  WRK-KENSUZ
                   MOVE    WRK-KENSUZ  TO  HCM2R-TAI-KENSU(CNT-LINE IDZ)
                   MOVE    GSUM-TOTALTEN(IDX)
                                       TO  WRK-TENSUZ
                   MOVE    WRK-TENSUZ  TO  HCM2R-TAI-TENSU(CNT-LINE IDZ)
                   EVALUATE    IDX
                   WHEN    5
                   WHEN    8
                       MOVE    GSUM-YKZFTN(IDX)
                                       TO  WRK-ITBFTNZ
                       MOVE    WRK-ITBFTNZ
                               TO  HCM2R-TAI-ITBFTN(CNT-LINE IDZ)
                   WHEN    6   THRU    7
                       MOVE    GSUM-FTNMONEY(IDX)
                                       TO  WRK-ITBFTNZ
                       MOVE    WRK-ITBFTNZ
                               TO  HCM2R-TAI-ITBFTN(CNT-LINE IDZ)
                   END-EVALUATE
      *
      *        Ï·¿ÍÊÝ·ò
               WHEN    10  THRU    11
                   COMPUTE IDZ             =   IDX     -   9
                   MOVE    GSUM-KENSU(IDX)     TO  WRK-KENSUZ
                   MOVE    WRK-KENSUZ
                           TO  HCM2Q-ROU-KENSU(CNT-LINE IDZ)
                   MOVE    GSUM-TOTALTEN(IDX)  TO  WRK-TENSUZ
                   MOVE    WRK-TENSUZ
                           TO  HCM2Q-ROU-TENSU(CNT-LINE IDZ)
                   MOVE    GSUM-FTNMONEY(IDX)  TO  WRK-ITBFTNZ
                   MOVE    WRK-ITBFTNZ
                           TO  HCM2Q-ROU-ITBFTN(CNT-LINE IDZ)
      *        ¸øÈñ
               WHEN    12
                   MOVE    GSUM-KENSU(IDX) TO  WRK-KENSUZ
                   MOVE    WRK-KENSUZ      TO  HCM2R-KOU-KENSU(CNT-LINE)
                   MOVE    GSUM-TOTALTEN(IDX)
                                           TO  WRK-TENSUZ
                   MOVE    WRK-TENSUZ      TO  HCM2R-KOU-TENSU(CNT-LINE)
                   MOVE    GSUM-FTNMONEY(IDX)
                                           TO  WRK-ITBFTNZ
                   MOVE    WRK-ITBFTNZ TO  HCM2R-KOU-ITBFTN(CNT-LINE)
                   MOVE    GSUM-YKZFTN(IDX)
                                           TO  WRK-ITBFTNZ
                   MOVE    WRK-ITBFTNZ TO  HCM2R-KOU-KNJFTN(CNT-LINE)
               END-EVALUATE
      *
           END-PERFORM
      *
           MOVE    GSUM-SHO-KENSU(1)   TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ          TO  HCM2Q-SYO-KENSU(CNT-LINE)
           MOVE    GSUM-SHO-RYOYOHI(1) TO  WRK-TENSUZ
           MOVE    WRK-TENSUZ          TO  HCM2Q-SYO-TENSU(CNT-LINE)
           MOVE    GSUM-SHO-FTN(1)     TO  WRK-ITBFTNZ
           MOVE    WRK-ITBFTNZ         TO  HCM2Q-SYO-ITBFTN(CNT-LINE)
      *
           MOVE    GSUM-SHO-KENSU(2)   TO  WRK-KENSUZ
           MOVE    WRK-KENSUZ          TO  HCM2R-SYO-KENSU(CNT-LINE)
           MOVE    GSUM-SHO-RYOYOHI(2) TO  WRK-TENSUZ
           MOVE    WRK-TENSUZ          TO  HCM2R-SYO-TENSU(CNT-LINE)
           MOVE    GSUM-SHO-FTN(2)     TO  WRK-ITBFTNZ
           MOVE    WRK-ITBFTNZ         TO  HCM2R-SYO-ITBFTN(CNT-LINE)
      *
           .
       20023-GOKEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ä¢É¼°õºþ½èÍý
      *****************************************************************
       20024-PRINT-OUT-SEC         SECTION.
      *
           IF          CNT-LINE    =   ZERO
               GO  TO  20024-PRINT-OUT-EXT
           END-IF
      *
           PERFORM VARYING FLG-PRTKBN  FROM  1  BY  1
                   UNTIL   FLG-PRTKBN  >   2
               ADD     1               TO  CNT-PAGE
      *
               INITIALIZE                  ORCSPRTAREA
               MOVE    "INS"           TO  SPRT-MODE
               MOVE    LNK-PRTKANRI-RENNUM
                                       TO  SPRT-RENNUM
               MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
               MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
               MOVE    LNK-PRTKANRI-SRYYM
                                       TO  SPRT-SRYYM
               MOVE    LNK-PRTKANRI-SKYYMD
                                       TO  SPRT-SKYYMD
               MOVE    LNK-PRTKANRI-SHELLID
                                       TO  SPRT-SHELLID
               MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
               MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
               EVALUATE    FLG-PRTKBN
               WHEN    1
                   MOVE    "HCM2Q.red"     TO  SPRT-PRTID
                   MOVE    HCM2Q           TO  SPRT-PRTDATA
               WHEN    2
                   MOVE    "HCM2R.red"     TO  SPRT-PRTID
                   MOVE    HCM2R           TO  SPRT-PRTDATA
               END-EVALUATE
      *
               MOVE    "¿ÇÎÅÊó½·ÀÁµá½ñ"    TO  SPRT-TITLE
               MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
               MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
               MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
               MOVE    "1"                 TO  SPRT-SITEKBN
      *
               CALL    "ORCSPRT"           USING
                                           ORCSPRTAREA
               IF          SPRT-RETURN     =   ZERO
                   CONTINUE
               ELSE
                   MOVE    "°õºþ£Ä£Â¤Ë¹¹¿·¤Ç¤­¤Þ¤»¤ó¤Ç¤·¤¿"
                                       TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
               END-IF
           END-PERFORM
           .
       20024-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥¨¥é¡¼½ÐÎÏ½èÍý
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF          STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR     TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *
      *        ¥¸¥ç¥Ö´ÉÍý³«»Ï½èÍý
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
           MOVE    1               TO  FLG-END
                                       FLG-ERR
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½ªÎ»¡¡¡¡½èÍý
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           DISPLAY "*** ORCBM031 IN  "  CNT-RECE10
           DISPLAY "*** ORCBM031 END ***"
      *     
      *    ¥¹¥Æ¥Ã¥×´ÉÍý½ªÎ»½èÍý
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    À¾ÎñÆüËÜ¸ìÊÑ´¹½èÍý
      *****************************************************************
       31012-SEIWA-HEN-SEC         SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3
                                   TO  WRK-HENYMDG
           INSPECT WRK-HENYMDG     REPLACING  ALL "  "  BY  "¡¡"
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÀÁµá´ÉÍýÆÉ¹þ
      *****************************************************************
       900-SEIKYU-SELECT-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-RECE10
      *
      *    ÀÁµá´ÉÍý£Ä£Â¸¡º÷
           MOVE    SPACE           TO  RECE10-REC
           INITIALIZE                  RECE10-REC
           MOVE    WRK-PARA-HOSPID TO  RECE10-HOSPID
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  RECE10-SKYYM
           MOVE    WRK-CONS-SRYYM  TO  RECE10-SRYYM
           MOVE    WRK-CONS-SRYYM-200304
                                   TO  RECE10-XXSRYYM
           MOVE    RECE10-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    WRK-PATH        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC      =   ZERO
               MOVE    WRK-PATH        TO  ORC-DBPATH
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    1               TO  FLG-RECE10
               MOVE    HIGH-VALUE      TO  KEY-NEW
           END-IF
           .
       900-SEIKYU-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÀÁµá¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       900-SEIKYU-READ-SEC         SECTION.
      *
           MOVE    WRK-PATH        TO  ORC-DBPATH
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC      =   ZERO
               MOVE    ZERO            TO  FLG-RECE10
               MOVE    MCPDATA-REC     TO  RECE10-REC
      *
      *        ¥Æ¥¹¥È´µ¼Ô¤Î¤È¤­¤ÏÆÉ¤ßÈô¤Ð¤¹
               MOVE    SPACE           TO  PTINF-REC
               INITIALIZE                  PTINF-REC
               MOVE    RECE10-HOSPID   TO  PTINF-HOSPID
               MOVE    RECE10-PTID     TO  PTINF-PTID
               MOVE    PTINF-REC       TO  MCPDATA-REC
               PERFORM 800-PTINF-READ-SEC
               IF          FLG-PTINF       =   ZERO
                   AND PTINF-TSTPTNUMKBN   =   "1"
                   GO  TO  900-SEIKYU-READ-SEC
               END-IF
      *
               MOVE    RECE10-HKNJANUM-S
                                       TO  KEY-N-HKNJANUM
               ADD     1               TO  CNT-RECE10
           ELSE
               MOVE    HIGH-VALUE      TO  KEY-NEW
               MOVE    1               TO  FLG-RECE10
           END-IF
      *
           .
       900-SEIKYU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ´µ¼Ô¥Þ¥¹¥¿ÆÉ¹þ
      *****************************************************************
       800-PTINF-READ-SEC          SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "PTINF-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC      =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "PTINF-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF          MCP-RC      =   ZERO
                   MOVE    ZERO            TO  FLG-PTINF
                   MOVE    MCPDATA-REC     TO  PTINF-REC
               ELSE
                   MOVE    1               TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "PTINF-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       800-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿ÆÉ¹þ
      *****************************************************************
       910-SYSKANRI-INV-SEC        SECTION.
      *
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  ORC-DBYMD
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF          MCP-RC      =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF          MCP-RC      =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       910-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â¡¡¥ª¡¼¥×¥ó½èÍý
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â¡¡¥¯¥í¡¼¥º½èÍý
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
