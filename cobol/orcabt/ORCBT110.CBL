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
       PROGRAM-ID.             ORCBT110.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : Æü¼¡Åý·×
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : Æü¼¡Åý·×¥Ç¡¼¥¿ÍÑ´ðËÜ¾ðÊóºîÀ®¡Ê³°Íè¡Ë
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  05/03/31    NACL¡ÝÂ¿¡¹Ç¼  ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    Æü¼¡Åý·×¥Ç¡¼¥¿
           SELECT  TOUKEI04-FILE   ASSIGN  TOUKEI04
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   FILE    STATUS  IS  STS-TOUKEI04.
      *
      *    ¥¨¥é¡¼¥Õ¥¡¥¤¥ë
           SELECT  TOUKEIERR-FILE  ASSIGN  WRK-PARA-ERRFILENM
                                   FILE    STATUS  IS  STS-TOUKEIERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    Æü¼¡Åý·×¥Ç¡¼¥¿
       FD  TOUKEI04-FILE.
       01  TOUKEI04-REC. 
           COPY    "CPTCF004.INC".
      *
      *    ¥¨¥é¡¼¥Õ¥¡¥¤¥ë
       FD  TOUKEIERR-FILE.
       01  TOUKEIERR-REC           PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01PARA//
                                   BY         //TOUKEI04//.
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  STS-AREA.
           03  STS-TOUKEI04                    PIC X(02).
           03  STS-TOUKEIERR                   PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                         PIC 9(01).
           03  FLG-SYSKANRI                    PIC 9(01).
           03  FLG-HKNCOMBI                    PIC 9(01). 
           03  FLG-HKNNUM                      PIC 9(01). 
           03  FLG-TOUKEI04                    PIC 9(01).
           03  FLG-PTHKNINF                    PIC 9(01).
           03  FLG-PTKOHINF                    PIC 9(01).
           03  FLG-PTINF                       PIC 9(01).
           03  FLG-KYUSEIRRK                   PIC 9(01).
           03  FLG-MONTHLYNUM                  PIC 9(01).
           03  FLG-SRYACT                      PIC 9(01).
           03  FLG-TENSU                       PIC 9(01).
           03  FLG-SYUNOU                      PIC 9(01).
           03  FLG-PTRSIINF                    PIC 9(01).
           03  FLG-ADRS                        PIC 9(01).
           03  FLG-JYURRK                      PIC 9(01).
      * 
           03  FLG-SYORI                       PIC 9(01).
           03  FLG-CHK-END                     PIC 9(01).
      *
      *    ¥«¥¦¥ó¥ÈÎÎ°è
       01  CNT-AREA.
           03  CNT-IN                          PIC 9(06).
           03  CNT-TOUKEI04                    PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX                             PIC 9(03). 
           03  IDX1                            PIC 9(03). 
           03  IDX2                            PIC 9(03). 
           03  IDX3                            PIC 9(03). 
           03  IDX4                            PIC 9(03). 
           03  IDX5                            PIC 9(03). 
           03  IDY                             PIC 9(03). 
           03  IDZ                             PIC 9(03).
           03  IDXX                            PIC 9(03).
      *
       01  KEY-AREA                            VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-PTID                  PIC 9(10).
               05  KEY-N-DENPNUM               PIC 9(07).
           03  KEY-OLD.
               05  KEY-O-PTID                  PIC 9(10).
               05  KEY-O-DENPNUM               PIC 9(07).
      *
      *    °ì»þÎÎ°è
      *
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-TERMID             PIC X(32).
               05  WRK-PARA-HOSPID             PIC X(24).
               05  WRK-PARA-PREFNUM            PIC X(02). 
               05  WRK-PARA-SRYYMD             PIC X(08).
               05  WRK-PARA-NYUGAIKBN          PIC X(01).
               05  WRK-PARA-DATAKBN            PIC X(01).
               05  WRK-PARA-HOUKATUKBN         PIC X(01).
               05  WRK-PARA-JOBID              PIC 9(07).
               05  WRK-PARA-SHELLID            PIC X(08).
               05  WRK-PARA-ERRFILENM          PIC X(100).
      *
           03  WRK-TOUKEIERR               PIC X(200). 
      *
           03  WRK-PATH                    PIC X(64).
      *
           03  WRK-ERR-AREA.
               05  WRK-UPDKBN              PIC X(01).
               05  WRK-TEISEIKBN           PIC X(01).
      * 
           03  WRK-YMD.
               05  WRK-YY              PIC 9(04).
               05  WRK-MM              PIC 9(02).
               05  WRK-DD              PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
      *    ´µ¼ÔËè
           03  WRK-HENSYU-AREA.
               05  WRK-KIHONKBN            PIC 9(01).
               05  WRK-JIKANKBN            PIC 9(01).
               05  WRK-SYOKAIKBN           PIC 9(01).
      *
           03  WRK-HKNNUM                  PIC X(03).
           03  WRK-PAYKBN                  PIC X(02).
      *
      *    ¥ì¥»¥×¥È¼ïÊÌÈ½ÄêÍÑÎÎ°è
       01  WK-RECESYUBETU-AREA.
           03  WK-KOKUHO                               PIC X(01).
           03  WK-IHO                                  PIC X(01).
           03  WK-RJN                                  PIC X(01).
           03  WK-KOHI-CNT                             PIC 9(02).
           03  WK-HONKZKKBN                            PIC X(01).
           03  WRK-AGE                     PIC 9(03).
      *
           03  WRK-HKNNUM-AREA.
               05  WRK-HKNNUM-TBL          OCCURS   4.
      *            Ë¡ÊÌÈÖ¹æ
                   07  WRK-HKN-HBTNUM                PIC  X(02).
      *            ¥ì¥»¥×¥ÈÀÁµá¶èÊ¬
                   07  WRK-HKN-RECESKYKBN            PIC  X(01).
      *
           03  WRK-1033-TABLE.
               05  WRK-1033-TBL    OCCURS  5.
                   07  WRK-1033-HKNJANUM-G.
                       09  WRK-1033-HKNJANUM
                                   PIC X(08) OCCURS  20.
                   07  WRK-1033-STYUKYMD
                                   PIC X(08).
                   07  WRK-1033-EDYUKYMD 
                                   PIC X(08).
      *
      *    ¿ÇÎÅ²Ê¥Æ¡¼¥Ö¥ë
       01  TBL-SYS-1005-AREA.
           03  TBL-SYS-1005-REC        OCCURS  99.
               05  TBL-SRYKA           PIC X(02).
               05  TBL-RECESRYKA       PIC X(02).
           03  IDX-SRYKA-MAX            PIC 9(04).
      *
           COPY    "MCPAREA".
      *
      *    Æü¼¡Åý·×¥Ç¡¼¥¿ÊÝÂ¸
       01  HZN-TOUKEI04-REC. 
           COPY    "CPTCF004.INC"  REPLACING  //TOUKEI04-//
                                   BY         //HZN-TOUKEI04-//.
      *
      *    ÅÀ¿ô¥Þ¥¹¥¿ÂàÈò¥ï¡¼¥¯
           COPY    "CPTTNS.INC".
      *
       01  WRK-CONS-AREA.
      *    
      *    À¸³èÊÝ¸îÊÝ¸±ÈÖ¹æ 
           03  WRK-CONS-SEIHO-HKNNUM   PIC X(03)   VALUE   "012". 
      *    ¼«ÈñÊÝ¸±ÈÖ¹æ 
           03  WRK-CONS-JIHI-HKNNUM    PIC X(03)   VALUE   "980". 
      *    Ï«ºÒÊÝ¸±ÈÖ¹æ 
           03  WRK-CONS-ROUSAI-HKNNUM  PIC X(03)   VALUE   "971". 
      *    ¼«ÇåÀÕÊÝ¸±ÈÖ¹æ 
           03  WRK-CONS-JIBAI-HKNNUM   PIC X(03)   VALUE   "973".       
      *    ¸¶ÇúÊÝ¸±ÈÖ¹æ 
           03  WRK-CONS-GENBAKU-HKNNUM PIC X(03)   VALUE   "019".       
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    ¥¸¥ç¥Ö´ÉÍý¥Þ¥¹¥¿
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿
           COPY    "CPSYSKANRI.INC".
      *
      *    °åÎÅµ¡´Ø¾ðÊó
           COPY  "CPSK1001.INC".
      *
      *    ´µ¼ÔÈÖ¹æ¹½À®´ÉÍý¾ðÊó
           COPY    "CPSK1009.INC".
      *     
      *    ¸©Æâ°·¤¤ÊÝ¸±¼Ô¾ðÊó
           COPY    "CPSK1033.INC".
      *
      *    ¿ÇÎÅ²Ê¾ðÊó
           COPY    "CPSK1005.INC".
      *     
           COPY    "CPSK2005.INC".
      *
      *    ´µ¼ÔÅÐÏ¿µ¡Ç½À©¸æ¾ðÊó
           COPY  "CPSK1017.INC".
      *
      *    ¼õ¿ÇÍúÎò
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    ¿ÇÎÅ²ñ·×
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    ¿ÇÎÅ¹Ô°Ù
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    ÊÝ¸±ÁÈ¤ß¹ç¤ï¤»
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ´µ¼ÔÊÝ¸±¾ðÊó
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    ´µ¼Ô¸øÈñ¾ðÊó
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    ÊÝ¸±¾ðÊó
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    ´µ¼Ô¾ðÊó
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    ¼ýÇ¼¾ðÊó
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    ÅÀ¿ô
           COPY    "CPTENSU.INC".
      *
      *    ´µ¼ÔÏ«ºÒÊÝ¸±¾ðÊó
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *    ½»½ê¥Þ¥¹¥¿
       01  ADRS-REC.
           COPY    "CPADRS.INC".
      *
      *    Æþ±¡²ñ·×
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑÎÎ°è
      *****************************************************************
      *
      *    Æþ±¡²ñ·×ÊÔ½¸¥µ¥Ö
           COPY    "CPORCHCM34S01.INC".
      *
      *    ¸øÈñÉÕ²Ã¾ðÊó¼èÆÀ¥µ¥Ö
           COPY    "CPORCSKOHPLUS.INC".
      *
      *   ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    ¿ô»úÊÑ´¹ÎÎ°è
           COPY    "CPORCSNUM.INC".
      *   ´µ¼ÔÈÖ¹æÊÑ´¹¥µ¥Ö
           COPY    "CPORCSPTID.INC".
      *   ¥¸¥ç¥Ö´ÉÍý£Ä£ÂÀ©¸æ¥µ¥Ö
           COPY    "CPORCSJOBKANRI.INC".
      *   ÊÝ¸±»»ÄêÍÑÇ¯Îð¡¦³ä¹ç·×»»¥µ¥Ö
           COPY    "CPORCSAGECHK.INC".
      *    ´µ¼Ô¼«¸ÊÉéÃ´¶â¥ì¥»¥×¥Èµ­ºÜÈ½Äê
           COPY    "CPORCSFTNJGNCHK.INC".
      *
      *    £Ä£Â¸¡º÷
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
           COPY    "ORCA-DBPATH".
      *
           COPY    "COMMON-SPA".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(1000).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    ¼ç½èÍý
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
      *    ½é´ü¡¡½èÍý
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  TTNS-AREA
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO    WRK-PARA-TERMID
                                               WRK-PARA-HOSPID
                                               WRK-PARA-PREFNUM 
                                               WRK-PARA-SRYYMD
                                               WRK-PARA-NYUGAIKBN
                                               WRK-PARA-DATAKBN
                                               WRK-PARA-HOUKATUKBN 
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
                                               WRK-PARA-ERRFILENM
           END-UNSTRING 
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ¥¹¥Æ¥Ã¥×´ÉÍý³«»Ï½èÍý
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBT110"      TO  JOB-PGID
           MOVE    "Æü¼¡Åý·×¥Ç¡¼¥¿ºîÀ®"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
      *    ¿ÇÎÅÇ¯·îÊÔ½¸
           MOVE    WRK-PARA-SRYYMD     TO  WRK-SYMD
      *
      *    °åÎÅµ¡´Ø£É£ÄÊÔ½¸
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    WRK-SYMD            TO  ORC-DBYMD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           ELSE
               MOVE    "°åÎÅµ¡´Ø¾ðÊó¤¬¼èÆÀ¤Ç¤­¤Þ¤»¤ó¤Ç¤·¤¿¡£"
                                           TO  WRK-TOUKEIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    ´µ¼ÔÈÖ¹æ¹½À®´ÉÍý¾ðÊóÊÔ½¸
           INITIALIZE                  SYS-1009-REC
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
           MOVE    WRK-SYMD            TO  ORC-DBYMD
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1009-REC
               MOVE    SYS-1009-PTNUMKSIKBN
                                       TO  SPA-1009-PTNUMKSIKBN
               MOVE    SYS-1009-HJNKSIKBN  
                                       TO  SPA-1009-HJNKSIKBN
               MOVE    SYS-1009-HJNKSINENKBN 
                                       TO  SPA-1009-HJNKSINENKBN
               MOVE    SYS-1009-HJNKSIRENNUMKBN
                                       TO  SPA-1009-HJNKSIRENNUMKBN
               MOVE    SYS-1009-HJNKSIRENNUMKETA
                                       TO  SPA-1009-HJNKSIRENNUMKETA
           ELSE
               MOVE    "´µ¼ÔÈÖ¹æ¹½À®´ÉÍý¾ðÊó¤¬¼èÆÀ¤Ç¤­¤Þ¤»¤ó¤Ç¤·¤¿"
                                           TO  WRK-TOUKEIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *     
      *    ¥ì¥»¥×¥ÈÊÔ½¸¶èÊ¬¾ðÊó
           INITIALIZE                  SYS-2005-REC
           MOVE    "2005"              TO  SYS-2005-KANRICD
           MOVE    "*"                 TO  SYS-2005-KBNCD
           MOVE    WRK-PARA-SRYYMD     TO  ORC-DBYMD
           MOVE    SYS-2005-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-2005-REC
           ELSE    
               MOVE    SPACE               TO  SYS-2005-REC
           END-IF
           IF      SYS-2005-RJNGNBKKBN =   SPACE
               MOVE    ZERO                TO  SYS-2005-RJNGNBKKBN
           END-IF
      *
      *    ´µ¼ÔÅÐÏ¿µ¡Ç½À©¸æ¾ðÊó
           INITIALIZE                      SYS-1017-REC
           MOVE    "1017"              TO  SYS-1017-KANRICD
           MOVE    "*"                 TO  SYS-1017-KBNCD
           MOVE    WRK-PARA-SRYYMD     TO  ORC-DBYMD
           MOVE    SYS-1017-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1017-REC
           ELSE    
               INITIALIZE                      SYS-1017-REC
           END-IF
           IF      SYS-1017-SEIHO-JKYSNUM
                                       =   SPACE
               MOVE    ZERO                TO  SYS-1017-SEIHO-JKYSNUM
           END-IF
      * 
      *    ¸©Æâ°·¤¤ÊÝ¸±¼Ô¾ðÊó
           MOVE    SPACE           TO  WRK-1033-TABLE
      *     
           MOVE    SPACE           TO  SYS-1033-REC
           INITIALIZE                  SYS-1033-REC
           MOVE    "1033"          TO  SYS-1033-KANRICD
           MOVE    "*"             TO  SYS-1033-KBNCD
           MOVE    SYS-1033-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY5" TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY5" TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   FLG-SYSKANRI   =   1
                               OR      IDX            >=  5
               MOVE    MCPDATA-REC         TO  SYS-1033-REC
               ADD     1                   TO  IDX
               MOVE    SYS-1033-STYUKYMD   TO  WRK-1033-STYUKYMD   (IDX)
               MOVE    SYS-1033-EDYUKYMD   TO  WRK-1033-EDYUKYMD   (IDX)
               MOVE    SYS-1033-TBL        TO  WRK-1033-HKNJANUM-G (IDX)
               MOVE    "SYSKANRI-KEY5" TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *
           MOVE    "SYSKANRI-KEY5"     TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *    ¿ÇÎÅ²Ê¥Æ¡¼¥Ö¥ë
           INITIALIZE                  TBL-SYS-1005-AREA
           MOVE    SPACE               TO  SYS-1005-REC
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    WRK-PARA-SRYYMD     TO  ORC-DBYMD
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY2" TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM             UNTIL   FLG-SYSKANRI   =   1
                               OR      IDX            >=  99
               MOVE    MCPDATA-REC         TO  SYS-1005-REC
               ADD     1                   TO  IDX
               MOVE    SYS-1005-KBNCD(1:2)
                                           TO  TBL-SRYKA  (IDX)
               MOVE    SYS-1005-RECESRYKA  TO  TBL-RECESRYKA  (IDX)
               MOVE    IDX                 TO  IDX-SRYKA-MAX
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
           MOVE    "TOKEI110"          TO  TOUKEI04-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TOUKEI04-TERMID
      *
           OPEN    OUTPUT              TOUKEI04-FILE
           CLOSE                       TOUKEI04-FILE
      *
           OPEN    OUTPUT              TOUKEI04-FILE
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    ¼ç½èÍý
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    ¼õ¿ÇÍúÎòÆÉ¤ß¹þ¤ß
           INITIALIZE                  JYURRK-REC
           MOVE    WRK-PARA-HOSPID     TO  JYURRK-HOSPID
           MOVE    WRK-PARA-SRYYMD     TO  JYURRK-SRYYMD
           MOVE    "2"                 TO  JYURRK-NYUGAIKBN
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    PATH-TBL-JYURRK-KEY29   TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    PATH-TBL-JYURRK-KEY29   TO  MCP-PATH
               PERFORM 900-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
           PERFORM UNTIL       FLG-JYURRK  =   1
      *
               PERFORM 2001-INIT-SYORI-SEC
               MOVE    ZERO                TO  FLG-SYORI
               PERFORM UNTIL    (FLG-JYURRK    =   1  )  OR
                                (KEY-N-PTID    NOT =   KEY-O-PTID)
                   PERFORM 2002-HENSYU-SYORI-SEC
               END-PERFORM
               IF      FLG-SYORI               =   1
                   PERFORM 2003-OUT-SYORI-SEC
               END-IF
           END-PERFORM
           MOVE    PATH-TBL-JYURRK-KEY29   TO  MCP-PATH
           PERFORM 990-DBCLOSE-SEC
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT. 
      *
      *****************************************************************
      *    ´µ¼ÔËè¤ÎÊÔ½¸½èÍý
      *****************************************************************
       2001-INIT-SYORI-SEC              SECTION.
      *
           INITIALIZE                  WRK-HENSYU-AREA
      *    ¥Æ¥¹¥È´µ¼Ô¤Î¤È¤­¤ÏÆÉ¤ßÈô¤Ð¤¹
           MOVE    JYURRK-HOSPID       TO  PTINF-HOSPID
           MOVE    JYURRK-PTID         TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
      *
           DISPLAY "JYURRK PTID=" KEY-N-PTID 
                   " TSTPTNUMKBN=" PTINF-TSTPTNUMKBN
      *
      *    ¥Æ¥¹¥È´µ¼Ô¤Î»þÆÉ¤ßÈô¤Ð¤·
           IF     (FLG-PTINF           =   ZERO )  AND
                  (PTINF-TSTPTNUMKBN   =   "1"  )
               MOVE    KEY-NEW             TO  KEY-OLD
               PERFORM UNTIL ( FLG-JYURRK      =   1  )
                       OR    ( KEY-N-PTID  NOT =   KEY-O-PTID)
                   MOVE    PATH-TBL-JYURRK-KEY29   TO  MCP-PATH
                   PERFORM 900-JYURRK-READ-SEC
               END-PERFORM
           ELSE
               MOVE    KEY-NEW             TO  KEY-OLD
           END-IF
      *
           .
       2001-INIT-SYORI-EXT.
           EXIT. 
      *
      *****************************************************************
      *    ÊÔ½¸½èÍý
      *****************************************************************
       2002-HENSYU-SYORI-SEC              SECTION.
      *
      *    ´µ¼Ô¾ðÊóÊÔ½¸
           PERFORM 20021-PTINF-HENSYU-SEC
      *
           MOVE    ZERO                TO  FLG-SYORI
           MOVE    KEY-NEW             TO  KEY-OLD
           PERFORM UNTIL ( FLG-JYURRK      =   1  )
                   OR    ( KEY-NEW     NOT =   KEY-OLD)
               IF      JYURRK-DENPNUM      =   ZERO
                   MOVE    PATH-TBL-JYURRK-KEY29   TO  MCP-PATH
                   PERFORM 900-JYURRK-READ-SEC
               ELSE
                   PERFORM 20022-SYORI-01-SEC
               END-IF
           END-PERFORM
      *
           .
       2002-HENSYU-SYORI-EXT.
           EXIT. 
      *
      *****************************************************************
      *    ´µ¼Ô¾ðÊóÊÔ½¸½èÍý
      *****************************************************************
       20021-PTINF-HENSYU-SEC              SECTION.
      *
           INITIALIZE                      HZN-TOUKEI04-REC
           MOVE    JYURRK-HOSPID       TO  HZN-TOUKEI04-HOSPID
      *    °åÎÅµ¡´Ø¥³¡¼¥É
           MOVE    SYS-1001-HOSPCD     TO  HZN-TOUKEI04-HOSPCD
      *    ¿ÇÎÅÇ¯·îÆü
           MOVE    WRK-PARA-SRYYMD     TO  HZN-TOUKEI04-SRYYMD
      *    Æþ³°¶èÊ¬
           MOVE    "2"                 TO  HZN-TOUKEI04-NYUGAIKBN
      *    ´µ¼ÔÈÖ¹æ
           INITIALIZE                  ORCSPTIDAREA
           MOVE    JYURRK-HOSPID   TO  SPTID-HOSPID
           MOVE    JYURRK-PTID     TO  SPTID-PTID
           CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                           SPA-1009-TBL
           MOVE    SPTID-PTNUM     TO  HZN-TOUKEI04-PTNUM
           MOVE    JYURRK-PTID     TO  HZN-TOUKEI04-PTID
      *
      *    ´µ¼Ô¾ðÊó
           MOVE    PTINF-KANANAME  TO  HZN-TOUKEI04-KANANAME
           MOVE    PTINF-NAME      TO  HZN-TOUKEI04-NAME
           MOVE    PTINF-SEX       TO  HZN-TOUKEI04-SEX
           MOVE    PTINF-BIRTHDAY  TO  HZN-TOUKEI04-BIRTHDAY
           MOVE    PTINF-HOME-POST TO  HZN-TOUKEI04-HOME-POST
           MOVE    PTINF-HOME-ADRS TO  HZN-TOUKEI04-HOME-ADRS
           MOVE    PTINF-HOME-TEL1 TO  HZN-TOUKEI04-HOME-TEL
           INITIALIZE                  ADRS-REC
           MOVE    PTINF-HOME-POST TO  ADRS-POST
           MOVE    ADRS-REC        TO  MCPDATA-REC
           PERFORM 900-ADRS-INV-SEC
           MOVE    ADRS-LPUBCD     TO  HZN-TOUKEI04-LPUBCD
      *
           .
       20021-PTINF-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥­¡¼ËèÊÔ½¸½èÍý
      *****************************************************************
       20022-SYORI-01-SEC              SECTION.
      *
           MOVE   HZN-TOUKEI04-REC     TO  TOUKEI04-REC
      *    ¥ì¥³¡¼¥É¼±ÊÌ
           IF      JYURRK-GRP-DENPNUM  =   ZERO
               MOVE    1                   TO  TOUKEI04-RECSKB
               MOVE    ZERO                TO  WRK-KIHONKBN
               MOVE    ZERO                TO  WRK-JIKANKBN
           ELSE
               IF      JYURRK-GRP-RENNUM   =   1
                   MOVE    1                   TO  TOUKEI04-RECSKB
                   MOVE    ZERO                TO  WRK-KIHONKBN
                   MOVE    ZERO                TO  WRK-JIKANKBN
               ELSE
                   MOVE    2                   TO  TOUKEI04-RECSKB
               END-IF
           END-IF
           MOVE    ZERO                TO  WRK-SYOKAIKBN
      *    ¿ÇÎÅ²Ê
           MOVE    JYURRK-SRYKA        TO  TOUKEI04-SRYKA
           PERFORM 20023-SRYKA-HENSYU-SEC
      *    ÊÝ¸±ÁÈ¹ç¤»
           MOVE    JYURRK-HKNCOMBINUM  TO  TOUKEI04-HKNCOMBINUM
           PERFORM 20024-HKNCOMBI-HENSYU-SEC
      *    ¥É¥¯¥¿¡¼
           MOVE    JYURRK-DRCD         TO  TOUKEI04-DRCD
      *    ÅÁÉ¼ÈÖ¹æ
           MOVE    JYURRK-DENPNUM      TO  TOUKEI04-DENPNUM
      *    ¼ýÇ¼¾ðÊó
           PERFORM 20026-SYUNOU-HENSYU-SEC
      *    ¼õ¿ÇÍúÎò¤ÎÆâÍÆÈ½Äê
           PERFORM UNTIL    (FLG-JYURRK    =   1  )  OR
                            (KEY-NEW   NOT =   KEY-OLD)
      *        ¿Ç»¡ÎÁ»»Äê¤¢¤ê
               IF      JYURRK-SRYKBN1      NOT =   SPACE
                   PERFORM 200227-SRYACCT-HEN-SEC
               END-IF
      *
               MOVE    PATH-TBL-JYURRK-KEY29   TO  MCP-PATH
               PERFORM 900-JYURRK-READ-SEC
           END-PERFORM
      *
      *    ½ÐÎÏ½èÍý
           PERFORM 2003-OUT-SYORI-SEC
           .
       20022-SYORI-01-EXT.
           EXIT. 
      *
      *****************************************************************
      *    ¿ÇÎÅ¹Ô°Ù¸¡º÷½èÍý
      *****************************************************************
       200227-SRYACCT-HEN-SEC              SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   15  )  OR
                              (JYURRK-ZAINUM(IDX)  =   ZERO )
      *
               MOVE    SPACE                   TO  SRYACT-REC
               INITIALIZE                      SRYACT-REC
               MOVE    JYURRK-HOSPID           TO  SRY-HOSPID
               MOVE    JYURRK-NYUGAIKBN        TO  SRY-NYUGAIKBN
               MOVE    JYURRK-PTID             TO  SRY-PTID
               MOVE    JYURRK-SRYKA            TO  SRY-SRYKA
               MOVE    JYURRK-SRYYMD(1:6)      TO  SRY-SRYYM
               MOVE    JYURRK-ZAINUM(IDX)      TO  SRY-ZAINUM
      *
               MOVE    SRYACT-REC          TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "SRYACT-KEY2"         TO  ORC-DBPATH
                   PERFORM 900-SRYACT-READ-SEC
               ELSE
                   INITIALIZE                  SRYACT-REC
                   MOVE    1               TO  FLG-SRYACT
               END-IF
               MOVE    ZERO                   TO  FLG-CHK-END
               PERFORM UNTIL  (FLG-SRYACT     =   1  )  OR
                              (FLG-CHK-END    =   1  )
                   EVALUATE    SRY-SRYKBN
                      WHEN     "11"
      *                   ½é¿Ç
                          PERFORM 2002271-SYOSIN-CHK11-SEC
                      WHEN     "12"
      *                   ºÆ¿Ç
                          PERFORM 2002272-SYOSIN-CHK12-SEC
                      WHEN     "13"
      *                   »ØÆ³
                          PERFORM 2002273-SYOSIN-CHK13-SEC
                      WHEN     "14"
      *                   ±ý¿Ç
                          PERFORM 2002273-SYOSIN-CHK14-SEC
                      WHEN     OTHER
                          MOVE     1              TO   FLG-CHK-END
                   END-EVALUATE
      *
                   MOVE    "SRYACT-KEY2"         TO  ORC-DBPATH
                   PERFORM 900-SRYACT-READ-SEC
               END-PERFORM
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 900-DBCLOSE-SEC
           END-PERFORM
           .
       200227-SRYACCT-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½é¿ÇÎÁÈ½Äê½èÍý
      *****************************************************************
       2002271-SYOSIN-CHK11-SEC              SECTION.
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL      (IDY     >    5  )  OR
                              (SRY-SRYCD (IDY) =   SPACE )
               IF       SRY-SRYCD(IDY)(1:1)    =   "1"
                   PERFORM 900-TENSU-READ-SEC
                   IF      TNS-DATAKBN         =   "1"
                       MOVE    1                   TO  WRK-KIHONKBN
                   ELSE
                       IF      TNS-TIMEKSNKBN  NOT =   ZERO
      *                    »þ´Ö³°²Ã»»È½Äê
                           PERFORM 2002271-TIME-CHK-SEC
                       ELSE
      *                    ¾Ò²ð²Ã»»È½Äê
                           PERFORM 2002272-SYOKAI-CHK-SEC
                       END-IF
                   END-IF
               ELSE
                   IF  (SRY-SRYCD(IDY)         =   "099110001") OR
                       (SRY-SRYCD(IDY)         =   "830000020")
                       MOVE    1                   TO  WRK-KIHONKBN
                   END-IF
               END-IF
           END-PERFORM
           .
       2002271-SYOSIN-CHK11-EXT.
           EXIT.
      *****************************************************************
      *    »þ´Ö³°¶èÊ¬È½Äê½èÍý
      *****************************************************************
       2002271-TIME-CHK-SEC              SECTION.
      *
           EVALUATE    TNS-TIMEKSNKBN
               WHEN    1
      *            »þ´Ö³°
                   MOVE    2               TO  WRK-JIKANKBN
               WHEN    2
               WHEN    3
      *            µÙÆü
                   MOVE    3               TO  WRK-JIKANKBN
               WHEN    4
      *            ¿¼Ìë
                   MOVE    4               TO  WRK-JIKANKBN
               WHEN    5
      *            »þ´Ö³°ÆÃÎã
                   MOVE    2               TO  WRK-JIKANKBN
           END-EVALUATE
           .
       2002271-TIME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¾Ò²ð²Ã»»È½Äê½èÍý
      *****************************************************************
       2002272-SYOKAI-CHK-SEC              SECTION.
      *
           EVALUATE    SRY-SRYCD(IDY)
      *        ½é¿Ç»þ¡Ê¿ÇÎÅ½ê¡Ë¾Ò²ð´µ¼Ô²Ã»»
               WHEN    "111003770"
      *        ¾Ò²ð´µ¼Ô²Ã»»£³
               WHEN    "111009970"
      *        ¾Ò²ð´µ¼Ô²Ã»»£´
               WHEN    "111010070"
      *        ¾Ò²ð´µ¼Ô²Ã»»£µ
               WHEN    "111010170"
      *        ¾Ò²ð´µ¼Ô²Ã»»£¶
               WHEN    "111010270"
      *        ¾Ò²ð´µ¼Ô²Ã»»£±
               WHEN    "111011270"
      *        ¾Ò²ð´µ¼Ô²Ã»»£²
               WHEN    "111011370"
                   MOVE    1               TO  WRK-SYOKAIKBN
      *        ¾®»ù²Ê³°Íè¿ÇÎÅÎÁ¡Ê½é¿Ç»þ¿ÇÎÅ½ê¤Î¾Ò²ð´µ¼Ô¡Ë²Ã»»
               WHEN    "111010370"
      *        ¾®»ù²Ê³°Íè¿ÇÎÅÎÁ¡Ê¾Ò²ð´µ¼Ô²Ã»»
               WHEN    "111010870"
               WHEN    "111010970"
               WHEN    "111011070"
               WHEN    "111011170"
               WHEN    "113005070"
               WHEN    "113005170"
                   MOVE    1               TO  WRK-SYOKAIKBN
      *        ¿ÇÎÅ¾ðÊóÄó¶¡ÎÁ¡Ê£Â¡ËµÕ¾Ò²ð²Ã»»         
               WHEN    "113006370"
      *        ¿ÇÎÅ¾ðÊóÄó¶¡ÎÁ¡Ê£Ã¡ËµÕ¾Ò²ð²Ã»»         
               WHEN    "113006470"
                   MOVE    1               TO  WRK-SYOKAIKBN
      *        ½é¿Ç¡Ê¿ÇÎÅ½ê¡Ë¾Ò²ð´µ¼Ô²Ã»»
               WHEN    "111700470"
               WHEN    "111702370"
               WHEN    "111702470"
               WHEN    "111702570"
               WHEN    "111702670"
               WHEN    "111702770"
               WHEN    "111702870"
                   MOVE    1               TO  WRK-SYOKAIKBN
           END-EVALUATE
           .
       2002272-SYOKAI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ºÆ¿ÇÎÁÈ½Äê½èÍý
      *****************************************************************
       2002272-SYOSIN-CHK12-SEC              SECTION.
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL      (IDY     >    5  )  OR
                              (SRY-SRYCD (IDY) =   SPACE )
               EVALUATE    SRY-SRYCD(IDY)
      *            ºÆ¿ÇÎÁ¡Ê°ìÈÌ ÉÂ±¡¡Ë
                   WHEN    "112007410"
      *            ÅÅÏÃºÆ¿ÇÎÁ¡Ê°ìÈÌ ÉÂ±¡¡Ë
                   WHEN    "112007950"
      *            ºÆ¿ÇÎÁ¡Ê°ìÈÌ ¿ÇÎÅ½ê¡Ë
                   WHEN    "112009210"
      *            ÅÅÏÃºÆ¿Ç¡Ê°ìÈÌ ¿ÇÎÅ½ê¡Ë
                   WHEN    "112009750"
                       MOVE    2                   TO  WRK-KIHONKBN
      *
      *            Æ±ÆüºÆ¿Ç¡Ê°ìÈÌ ÉÂ±¡¡Ë
                   WHEN    "112008350"
      *            ÅÅÏÃÆ±ÆüºÆ¿Ç¡Ê°ìÈÌ ÉÂ±¡¡Ë
                   WHEN    "112008850"
      *            Æ±ÆüºÆ¿Ç¡Ê°ìÈÌ ¿ÇÎÅ½ê¡Ë
                   WHEN    "112010150"
      *            ÅÅÏÃÆ±ÆüºÆ¿Ç¡Ê°ìÈÌ ¿ÇÎÅ½ê¡Ë
                   WHEN    "112010650"
                       MOVE    3                   TO  WRK-KIHONKBN
      *
      *            ºÆ¿ÇÎÁ¡ÊÏ·¿Í ÉÂ±¡¡Ë
                   WHEN    "112702310"
      *            ÅÅÏÃºÆ¿ÇÎÁ¡ÊÏ·¿Í ÉÂ±¡¡Ë
                   WHEN    "112702750"
      *            ºÆ¿ÇÎÁ¡ÊÏ·¿Í ¿ÇÎÅ½ê¡Ë
                   WHEN    "112703710"
      *            ÅÅÏÃºÆ¿Ç¡ÊÏ·¿Í ¿ÇÎÅ½ê¡Ë
                   WHEN    "112704150"
                       MOVE    2                   TO  WRK-KIHONKBN
      *
      *            Æ±ÆüºÆ¿Ç¡ÊÏ·¿Í ÉÂ±¡¡Ë
                   WHEN    "112703050"
      *            ÅÅÏÃÆ±ÆüºÆ¿Ç¡ÊÏ·¿Í ÉÂ±¡¡Ë
                   WHEN    "112703450"
      *            Æ±ÆüºÆ¿Ç¡ÊÏ·¿Í ¿ÇÎÅ½ê¡Ë
                   WHEN    "112704450"
      *            ÅÅÏÃÆ±ÆüºÆ¿Ç¡ÊÏ·¿Í ¿ÇÎÅ½ê¡Ë
                   WHEN    "112704850"
                       MOVE    3                   TO  WRK-KIHONKBN
      *
      *            ³°Íè¿ÇÎÅÎÁ
                   WHEN    "112011310"
      *            ³°Íè¿ÇÎÅÎÁ¡ÊÏ·¿Í¡Ë
                   WHEN    "112705510"
                       MOVE    2                   TO  WRK-KIHONKBN
      *
      *            Æ±Æü³°Íè¿ÇÎÅÎÁ
                   WHEN    "112011710"
      *            Æ±Æü³°Íè¿ÇÎÅÎÁ¡ÊÏ·¿Í¡Ë
                   WHEN    "112705850"
                       MOVE    2                   TO  WRK-KIHONKBN
      *
      *            Ï«ºÒºÆ¿ÇÎÁ
                   WHEN    "101120040"
                       MOVE    2                   TO  WRK-KIHONKBN
      *
      *            Â¾²Ê¼õ¿Ç
                   WHEN    "830000021"
                       IF      JYURRK-GRP-RENNUM   =   1  OR
                                                       ZERO
                           MOVE    2               TO  WRK-KIHONKBN
                       END-IF
      *
                   WHEN    OTHER
                       IF       SRY-SRYCD(IDY)(1:1)    =   "1"
                           PERFORM 900-TENSU-READ-SEC
                           IF     (TNS-DATAKBN         =   "2" ) AND
                                  (TNS-TIMEKSNKBN  NOT =   ZERO)
      *                        »þ´Ö³°È½Äê
                               PERFORM 2002271-TIME-CHK-SEC
                           END-IF
                       END-IF
               END-EVALUATE
           END-PERFORM
           .
       2002272-SYOSIN-CHK12-EXT.
           EXIT.
      *****************************************************************
      *    »ØÆ³ÎÁÈ½Äê½èÍý
      *****************************************************************
       2002273-SYOSIN-CHK13-SEC              SECTION.
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL      (IDY     >    5  )  OR
                              (SRY-SRYCD (IDY) =   SPACE )
               EVALUATE    SRY-SRYCD(IDY)
      *            ¾®»ù²Ê³°Íè¿Ç»¡ÎÁ(±¡³°½èÊý ½é¿Ç)
                   WHEN    "113003510"
      *            ¾®»ù²Ê³°Íè¿Ç»¡ÎÁ(±¡Æâ½èÊý ½é¿Ç)
                   WHEN    "113003710"
                       MOVE    1                   TO  WRK-KIHONKBN
      *
      *            ¾®»ù²Ê³°Íè¿Ç»¡ÎÁ(±¡³°½èÊý ºÆ¿Ç)
                   WHEN    "113003610"
      *            ¾®»ù²Ê³°Íè¿Ç»¡ÎÁ(±¡Æâ½èÊý ºÆ¿Ç½é¿Ç)
                   WHEN    "113003610"
                       MOVE    2                   TO  WRK-KIHONKBN
               END-EVALUATE
           END-PERFORM
           .
       2002273-SYOSIN-CHK13-EXT.
           EXIT.
      *****************************************************************
      *    ±ý¿ÇÈ½Äê½èÍý
      *****************************************************************
       2002273-SYOSIN-CHK14-SEC              SECTION.
      *
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL      (IDY     >    5  )  OR
                              (SRY-SRYCD (IDY) =   SPACE )
               EVALUATE    SRY-SRYCD(IDY)
      *            ±ý¿Ç
                   WHEN    "114000110"
      *            ÆÃÊÌ±ý¿Ç
                   WHEN    "114001610"
      *            ºßÂð´µ¼ÔË¬Ìä¿Ç»¡ÎÁ
                   WHEN    "114001110"
      *                ±ý¿Ç¶èÊ¬
                       MOVE    1                   TO  TOUKEI04-OSINKBN
               END-EVALUATE
           END-PERFORM
           .
       2002273-SYOSIN-CHK14-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½ÐÎÏ½èÍý
      *****************************************************************
       2003-OUT-SYORI-SEC              SECTION.
      *    ´ðËÜÎÁ¶èÊ¬
           MOVE    WRK-KIHONKBN        TO  TOUKEI04-KIHONKBN
      *    »þ´Ö³°¶èÊ¬
           MOVE    WRK-JIKANKBN        TO  TOUKEI04-TIMEKBN
      *    ¾Ò²ð¶èÊ¬
           MOVE    WRK-SYOKAIKBN       TO  TOUKEI04-SHOUKAIKBN
      *
           WRITE   TOUKEI04-REC
           ADD     1                   TO  CNT-TOUKEI04
           .
       2003-OUT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¿ÇÎÅ²ÊÊÔ½¸½èÍý
      *****************************************************************
       20023-SRYKA-HENSYU-SEC              SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL       IDX2    >   IDX-SRYKA-MAX
               IF      JYURRK-SRYKA    =   TBL-SRYKA(IDX2)
                   MOVE    TBL-RECESRYKA (IDX2)
                                           TO  TOUKEI04-RECEKA
                   MOVE    IDX-SRYKA-MAX   TO  IDX2
               END-IF
           END-PERFORM
           .
       20023-SRYKA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»ÊÔ½¸½èÍý
      *****************************************************************
       20024-HKNCOMBI-HENSYU-SEC              SECTION.
      *
           INITIALIZE                      HKNCOMBI-REC
           MOVE    JYURRK-HOSPID       TO  COMB-HOSPID
           MOVE    JYURRK-PTID         TO  COMB-PTID
           MOVE    JYURRK-HKNCOMBINUM  TO  COMB-HKNCOMBINUM
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           PERFORM 910-HKNCOMBI-INV-SEC
           IF      FLG-HKNCOMBI        =   1
               INITIALIZE                      HKNCOMBI-REC
           END-IF
      *    ¼çÊÝ¸±¾ðÊóÆÉ¤ß½Ð¤·
           INITIALIZE                      PTHKNINF-REC
           INITIALIZE                      PTRSIINF-REC
           IF      COMB-HKNID      NOT =   ZERO
               IF      COMB-HKNNUM         =   WRK-CONS-ROUSAI-HKNNUM
                                           OR  WRK-CONS-JIBAI-HKNNUM
      *            Ï«ºÒ¡¦¼«ÇåÀÕ
                   INITIALIZE                  PTRSIINF-REC
                   MOVE    COMB-HOSPID         TO  PTRSI-HOSPID
                   MOVE    COMB-HKNID          TO  PTRSI-HKNID
                   MOVE    COMB-PTID           TO  PTRSI-PTID
                   MOVE    PTRSIINF-REC        TO  MCPDATA-REC
                   PERFORM 900-PTRSIINF-INV-SEC
               ELSE
                   INITIALIZE                  PTHKNINF-REC
                   MOVE    COMB-HOSPID         TO  PTHKN-HOSPID
                   MOVE    COMB-PTID           TO  PTHKN-PTID
                   MOVE    COMB-HKNID          TO  PTHKN-HKNID
                   MOVE    PTHKNINF-REC        TO  MCPDATA-REC
                   MOVE    COMB-TEKSTYMD       TO  ORC-DBYMD
                   PERFORM 910-PTHKNINF-INV-SEC
               END-IF
           END-IF
      *    ÊÝ¸±¼ÔÌ¾
           MOVE    PTHKN-HKNJANUM      TO  TOUKEI04-HKNJANUM
      *    ¼çÊÝ¸±
           MOVE    COMB-HKNNUM         TO  TOUKEI04-HKNNUM
           MOVE    COMB-HKNID          TO  TOUKEI04-HKNID
           MOVE    COMB-HONKZKKBN      TO  TOUKEI04-HONKZKKBN
           MOVE    COMB-HOJOKBN        TO  TOUKEI04-HOJOKBN
           MOVE    COMB-CONTKBN        TO  TOUKEI04-CONTKBN
      *    ¸øÈñ£±
           MOVE    COMB-KOH1ID         TO  TOUKEI04-KOH1ID
           MOVE    COMB-KOH1HKNNUM     TO  TOUKEI04-KOH1HKNNUM
           MOVE    COMB-KOH1PAYKBN     TO  TOUKEI04-KOH1PAYKBN
      *    ¸øÈñ£²
           MOVE    COMB-KOH2ID         TO  TOUKEI04-KOH2ID
           MOVE    COMB-KOH2HKNNUM     TO  TOUKEI04-KOH2HKNNUM
           MOVE    COMB-KOH2PAYKBN     TO  TOUKEI04-KOH2PAYKBN
      *    ¸øÈñ£³
           MOVE    COMB-KOH3ID         TO  TOUKEI04-KOH3ID
           MOVE    COMB-KOH3HKNNUM     TO  TOUKEI04-KOH3HKNNUM
           MOVE    COMB-KOH3PAYKBN     TO  TOUKEI04-KOH3PAYKBN
      *    ¸øÈñ£´
           MOVE    COMB-KOH4ID         TO  TOUKEI04-KOH4ID
           MOVE    COMB-KOH4HKNNUM     TO  TOUKEI04-KOH4HKNNUM
           MOVE    COMB-KOH4PAYKBN     TO  TOUKEI04-KOH4PAYKBN
      *    Ï«ºÒ¡¦¼«ÇåÀÕ
           IF      COMB-HKNNUM         =   WRK-CONS-ROUSAI-HKNNUM
                                       OR  WRK-CONS-JIBAI-HKNNUM
      *        Ï«ºÒ¡ÝÏ«ºÒÊÝ¸±¶èÊ¬
               MOVE    PTRSI-HKNKBN        TO  TOUKEI04-RSIHKNKBN
      *        Ï«ºÒ¡Ý¼«ÇåÀÕÀÁµá¶èÊ¬
               MOVE   PTRSI-JIBAISEIKBN    TO  TOUKEI04-JIBAISEIKBN
           END-IF
      *    ¥ì¥»¥×¥È¼ïÊÌ
           IF      FLG-HKNCOMBI        =   ZERO
               PERFORM 20021-RECESYUBETU-SET-SEC
           END-IF
           .
       20024-HKNCOMBI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ýÇ¼¾ðÊóÊÔ½¸½èÍý
      *****************************************************************
       20026-SYUNOU-HENSYU-SEC              SECTION.
      *
      *    ¼ýÇ¼¥Þ¥¹¥¿¸¡º÷
           INITIALIZE                  SYUNOU-REC
           MOVE    JYURRK-HOSPID       TO  SYU-HOSPID
           MOVE    JYURRK-NYUGAIKBN    TO  SYU-NYUGAIKBN
           MOVE    JYURRK-PTID         TO  SYU-PTID
           MOVE    JYURRK-DENPNUM      TO  SYU-DENPNUM
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
      *    ÅÁÉ¼¾õÂÖ¶èÊ¬
           MOVE    SYU-DENPJTIKBN      TO  TOUKEI04-DENPJTIKBN
      *    ÅÁÉ¼ºîÀ®¶èÊ¬
           MOVE    SYU-CREATEKBN       TO  TOUKEI04-CREATEKBN
      *    ÊÝ¸±ÅÀ¿ô
           MOVE    SYU-TOTAL-HKNTEN    TO  TOUKEI04-HKNTEN
      *    ÊÝ¸±ÉéÃ´¶â³Û
           COMPUTE TOUKEI04-HKNMONEY   =   SYU-TOTAL-MONEY
                                       +   SYU-RJN-FTN
                                       +   SYU-KOH-FTN
      *    ÊÝ¸±Å¬ÍÑ³°¶â³Û
           COMPUTE TOUKEI04-TGMONEY    =   SYU-TOTAL-TGMONEY
                                       +   SYU-TOTAL-TGMONEY-TAX
                                       -   SYU-TGMONEY-TAX-SAI
      *    ÊÝ¸±Å¬ÍÑ³°¶â³Û¡Ê¾ÃÈñÀÇ¤¢¤ê¡Ë
           MOVE    SYU-TGMONEY-TAX-SAI
                                       TO  TOUKEI04-TGMONEY-TAX
      *    ¼«Èñ¶â³Û 
           COMPUTE TOUKEI04-JIHI       =   SYU-JIHI-TOTAL
                                       +   SYU-JIHI-TOTAL-TAX
      *    ¼«Èñ¶â³Û¾ÃÈñÀÇ
           MOVE    SYU-JIHI-TAX        TO  TOUKEI04-JIHI-TAX
      *    ÀÁµá¶â³Û
           MOVE    SYU-SKYMONEY        TO  TOUKEI04-SKYMONEY
           .
       20026-SYUNOU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥ì¥»¥×¥È¼ïÊÌ¥»¥Ã¥È½èÍý
      *****************************************************************
       20021-RECESYUBETU-SET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WK-RECESYUBETU-AREA
           INITIALIZE                      WK-RECESYUBETU-AREA
      *
      *    Ï«ºÒ¡¦¼«ÇåÀÕ¤Î¤È¤­
           IF      TOUKEI04-HKNNUM     =   WRK-CONS-ROUSAI-HKNNUM  OR
                                           WRK-CONS-JIBAI-HKNNUM
               EVALUATE    TOUKEI04-RSIHKNKBN
                                       ALSO    PTRSI-SAIGAIKBN
                                           ALSO    WRK-PARA-NYUGAIKBN
                   WHEN    "1"         ALSO    "1"     ALSO    "1"   
                       MOVE    7081        TO    TOUKEI04-RECESYUBETU
                   WHEN    "1"         ALSO    "2"     ALSO    "1"
                       MOVE    7082        TO    TOUKEI04-RECESYUBETU
                   WHEN    "2"         ALSO    "1"     ALSO    "1"
                       MOVE    7101        TO    TOUKEI04-RECESYUBETU
                   WHEN    "2"         ALSO    "2"     ALSO    "1"
                       MOVE    7102        TO    TOUKEI04-RECESYUBETU
                   WHEN    "1"         ALSO    "1"     ALSO    "2"   
                       MOVE    7071        TO    TOUKEI04-RECESYUBETU
                   WHEN    "1"         ALSO    "2"     ALSO    "2"
                       MOVE    7072        TO    TOUKEI04-RECESYUBETU
                   WHEN    "2"         ALSO    "1"     ALSO    "2"
                       MOVE    7091        TO    TOUKEI04-RECESYUBETU
                   WHEN    "2"         ALSO    "2"     ALSO    "2"
                       MOVE    7092        TO    TOUKEI04-RECESYUBETU
                   WHEN    "3"         ALSO    ANY     ALSO    ANY
                       MOVE    7021        TO    TOUKEI04-RECESYUBETU
                   WHEN    "4"         ALSO    ANY     ALSO    ANY
                       MOVE    7001        TO    TOUKEI04-RECESYUBETU
               END-EVALUATE
               GO  TO  20021-RECESYUBETU-SET-EXT
           END-IF
      *
      *    ¼«Èñ¤Î¤È¤­
           IF     TOUKEI04-HKNNUM(1:2) =   "98"
               MOVE    8888                TO  TOUKEI04-RECESYUBETU
               GO  TO  20021-RECESYUBETU-SET-EXT
           END-IF
      *    Ç¯Îð·×»»
           INITIALIZE                  ORCSAGECHKAREA
           MOVE    TOUKEI04-HOSPID     TO  AGECHK-HOSPID
           MOVE    TOUKEI04-PTID       TO  AGECHK-PTID
           MOVE    WRK-PARA-SRYYMD     TO  AGECHK-SRYYMD
           MOVE    PTINF-BIRTHDAY      TO  AGECHK-BIRTHDAY
           CALL    "ORCSAGECHK"        USING
                                       ORCSAGECHKAREA
           IF      AGECHK-RC           =   ZERO
               MOVE    AGECHK-NENREI       TO  WRK-AGE
           ELSE
               MOVE    ZERO                TO  WRK-AGE
           END-IF
      *
           IF      TOUKEI04-HKNNUM     NOT =   SPACE
               IF      TOUKEI04-HKNNUM     =   "060"   OR   "067"
                   IF      TOUKEI04-HKNNUM     =   "060"
                        MOVE   "1"             TO  WK-KOKUHO
                   ELSE
                        MOVE   "2"             TO  WK-KOKUHO
                   END-IF
               ELSE
                   MOVE    "1"             TO  WK-IHO
               END-IF
           END-IF
      *
           INITIALIZE                  WRK-HKNNUM-AREA
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL      (IDX     >   4  )  OR
                              (COMB-KOHID(IDX)   =   ZERO)
               MOVE    COMB-KOHHKNNUM(IDX)     TO  WRK-HKNNUM
               MOVE    COMB-KOHPAYKBN(IDX)     TO  WRK-PAYKBN
               PERFORM 200211-HKNNUM-SET-SEC
               MOVE    HKN-HBTNUM          TO  WRK-HKN-HBTNUM(IDX)
               MOVE    HKN-RECESKYKBN      TO  WRK-HKN-RECESKYKBN(IDX)
           END-PERFORM
      *
           IF      WRK-PARA-SRYYMD(1:6)    <      "200210" 
               IF      COMB-KOH1HKNNUM     =   "027"
                   MOVE        "1"             TO  WK-RJN
               END-IF
           END-IF
      *
           MOVE    TOUKEI04-HONKZKKBN  TO  WK-HONKZKKBN
      *
           MOVE    ZERO                TO  WK-KOHI-CNT
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       4
      *        ¸øÈñ¿ô
               IF      WRK-HKN-RECESKYKBN (IDX)   NOT =   SPACE
                   ADD     1               TO  WK-KOHI-CNT
               END-IF
           END-PERFORM
      *
      *    »³·ÁÃÏÊý¸øÈñÂÐ±þ
           IF      WRK-PARA-PREFNUM    =   "06"
               IF  WK-KOKUHO               =     "1"  OR  "2"
                   IF   (TOUKEI04-KOH-HKNNUM(1) (1:1)  =   "1")   OR
                        (TOUKEI04-KOH-HKNNUM(2) (1:1)  =   "1")   OR
                        (TOUKEI04-KOH-HKNNUM(3) (1:1)  =   "1")   OR
                        (TOUKEI04-KOH-HKNNUM(4) (1:1)  =   "1")   OR
                        (TOUKEI04-KOH-HKNNUM(1) (1:1)  =   "2")   OR
                        (TOUKEI04-KOH-HKNNUM(2) (1:1)  =   "2")   OR
                        (TOUKEI04-KOH-HKNNUM(3) (1:1)  =   "2")   OR
                        (TOUKEI04-KOH-HKNNUM(4) (1:1)  =   "2")
                       COMPUTE  WK-KOHI-CNT  =  WK-KOHI-CNT  -  1
                   END-IF
               END-IF
           END-IF
      *
      *    Ê¡²¬ÃÏÊý¸øÈñÂÐ±þ
           IF      WRK-PARA-PREFNUM    =   "40"
               IF  WK-KOKUHO               =   "1" OR  "2"
                   IF   (TOUKEI04-KOH-HKNNUM(1)(1:1)  =   "1" OR  "2")
                   AND  (WRK-HKN-HBTNUM     (1)   NOT =   "41"       )
                       COMPUTE  WK-KOHI-CNT  =  WK-KOHI-CNT  -  1
                   END-IF
                   IF   (TOUKEI04-KOH-HKNNUM(2)(1:1)  =   "1" OR  "2")
                   AND  (WRK-HKN-HBTNUM     (2)   NOT =   "41"       )
                       COMPUTE  WK-KOHI-CNT  =  WK-KOHI-CNT  -  1
                   END-IF
                   IF   (TOUKEI04-KOH-HKNNUM(3)(1:1)  =   "1" OR  "2")
                   AND  (WRK-HKN-HBTNUM (3)       NOT =   "41"       )
                       COMPUTE  WK-KOHI-CNT  =  WK-KOHI-CNT  -  1
                   END-IF
                   IF   (TOUKEI04-KOH-HKNNUM(4)(1:1)  =   "1" OR  "2")
                   AND  (WRK-HKN-HBTNUM (4)        NOT =   "41"       )
                       COMPUTE  WK-KOHI-CNT  =  WK-KOHI-CNT  -  1
                   END-IF
               END-IF
           END-IF
      *
           IF  TOUKEI04-HKNNUM     NOT =   SPACE
               IF      WRK-PARA-SRYYMD(1:6)    >=  "200210"
      *            £³ºÐÌ¤Ëþ¤Î¾ì¹ç¡¢£×£Ë¡Ý£È£Ï£Î£Ë£Ú£Ë£Ë£Â£Î¤Ë"£³"¤ò¥»¥Ã¥È
                   IF      WRK-AGE             <     3
                       MOVE    "3"             TO   WK-HONKZKKBN
                   END-IF
      *
      *            £±³ä¡¢£²³äÉéÃ´¤Î¹âÎð¼Ô¤Î¾ì¹ç£×£Ë¡Ý£È£Ï£Î£Ë£Ú£Ë£Ë£Â£Î¤Ë
      *            "£¹"¤Þ¤¿¤Ï"£¸"¤ò¥»¥Ã¥È
      *            Ï·¿ÍÊÝ¸±¤Î¾ì¹ç¤Ï£×£Ë¡Ý£Ò£Ê£Î¤Ë¥»¥Ã¥È¤¹¤ë	
                   EVALUATE    COMB-HKNNUM
                       WHEN    "002" 
                           EVALUATE   COMB-HOJOKBN
                               WHEN   "A"
                               WHEN   "B"
                               WHEN   "C"
                               WHEN   "9"
                                   MOVE   "9"   TO   WK-HONKZKKBN
                               WHEN   "D"
                               WHEN   "E"
                               WHEN   "F"
                               WHEN   "8"
                                   MOVE   "8"   TO   WK-HONKZKKBN
                           END-EVALUATE
                       WHEN    "031"  THRU    "034"  
                           EVALUATE   COMB-HOJOKBN
                               WHEN   "B"
                               WHEN   "9"   
                                   MOVE   "9"   TO   WK-HONKZKKBN
                               WHEN   "E"
                               WHEN   "8"
                                   MOVE   "8"   TO   WK-HONKZKKBN
                           END-EVALUATE
                       WHEN    "060" 
                           IF  (WRK-AGE        >=   70)  AND
                               (WRK-AGE        <=   74)
                               EVALUATE   COMB-HOJOKBN
                                   WHEN   "1"
                                   WHEN   "4"
                                       MOVE   "9"   TO   WK-HONKZKKBN
                                   WHEN   "2"
                                   WHEN   "5"
                                       MOVE   "8"   TO   WK-HONKZKKBN
                               END-EVALUATE
                           END-IF     
                       WHEN    OTHER 
                           EVALUATE   COMB-HOJOKBN
                               WHEN   "9"
                                   MOVE   "9"   TO   WK-HONKZKKBN
                               WHEN   "8"
                                   MOVE   "8"   TO   WK-HONKZKKBN
                           END-EVALUATE
                   END-EVALUATE
                   IF      COMB-KOH1HKNNUM      =    "027"
                       EVALUATE   COMB-KOH1PAYKBN
                           WHEN   "01"
                               MOVE   "9"   TO   WK-RJN
                           WHEN   "02"
                               MOVE   "8"   TO   WK-RJN
                       END-EVALUATE
                   END-IF
               END-IF
           END-IF
      *
           IF    ( WK-RJN          NOT =   SPACE )
           AND   ( TOUKEI04-HONKZKKBN  =   "1"   )
               IF      TOUKEI04-HKNNUM =   "063"   OR  "072"   OR
                                           "073"   OR  "074"   OR
                                           "075"
                   MOVE    "2"          TO  WK-IHO
               END-IF
           END-IF    
      *
      *      DISPLAY "HONKZKKBN : " WK-HONKZKKBN 
      *      DISPLAY "NYUGAIKBN : " TOUKEI04-NYUGAIKBN 
      *      DISPLAY "IHO       : " WK-IHO 
      *      DISPLAY "KOKUHO    : " WK-KOKUHO 
      *      DISPLAY "RJN       : " WK-RJN 
      *      DISPLAY "KOHI-CNT  : " WK-KOHI-CNT 
      *
      *    Ê¿À®£±£´Ç¯£¹·î¤Þ¤Ç
           IF      WRK-PARA-SRYYMD(1:6)    <=      "200209"
             EVALUATE  WK-HONKZKKBN ALSO TOUKEI04-NYUGAIKBN   ALSO
                    WK-IHO ALSO WK-KOKUHO ALSO WK-RJN ALSO WK-KOHI-CNT
               WHEN    "1"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1111            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1111            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1112            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1112            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1115            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1116            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   1
                   MOVE    1121            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO   1
                   MOVE    1121            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   1
                   MOVE    1122            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO   1
                   MOVE    1122            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   1
                   MOVE    1125            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   1
                   MOVE    1126            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   2
                   MOVE    1131            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO   2
                   MOVE    1131            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   2
               WHEN    "1"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   3
                   MOVE    1132            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO   2
                   MOVE    1132            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   2
                   MOVE    1135            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   2
                   MOVE    1136            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   1
                   MOVE    1211            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   1
                   MOVE    1212            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   2
                   MOVE    1221            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   2
                   MOVE    1222            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   3
                   MOVE    1231            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   3
                   MOVE    1232            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       ANY   ALSO   ANY    ALSO  "1"    ALSO   ZERO
                   MOVE    1311            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       ANY   ALSO   ANY    ALSO  "1"    ALSO   ZERO
                   MOVE    1312            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       ANY   ALSO   ANY    ALSO  "1"    ALSO   1
                   MOVE    1321            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       ANY   ALSO   ANY    ALSO  "1"    ALSO   1
                   MOVE    1322            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       ANY   ALSO   ANY    ALSO  "1"    ALSO   2
                   MOVE    1331            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       ANY   ALSO   ANY    ALSO  "1"    ALSO   2
                   MOVE    1332            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   ZERO
                   MOVE    1411            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   ZERO
                   MOVE    1412            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   ZERO
                   MOVE    1415            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   ZERO
                   MOVE    1416            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   1
                   MOVE    1421            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   1
                   MOVE    1422            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   1
                   MOVE    1425            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   1
                   MOVE    1426            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   2
                   MOVE    1431            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   2
                   MOVE    1432            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   2
                   MOVE    1435            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO   2
                   MOVE    1436            TO    TOUKEI04-RECESYUBETU
             END-EVALUATE
           END-IF
      *    Ê¿À®£±£´Ç¯£±£°·î²þÀµÂÐ±þ
           IF      WRK-PARA-SRYYMD(1:6)    >=      "200210"
             EVALUATE  WK-HONKZKKBN ALSO TOUKEI04-NYUGAIKBN   ALSO
                    WK-IHO ALSO WK-KOKUHO ALSO WK-RJN ALSO WK-KOHI-CNT
      *ÊÝ¸±Ã±ÆÈ
               WHEN    "1"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1111            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1111            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1112            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1112            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1113            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1113            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1114            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1114            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1115            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1115            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1116            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1116            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1117            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1117            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1118            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1118            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1119            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1119            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  ZERO
                   MOVE    1110            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1110            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO   1
                   MOVE    1121            TO    TOUKEI04-RECESYUBETU
      *ÊÝ¸±¤È¸øÈñ£±¼ï¤ÎÊ»ÍÑ
               WHEN    "1"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1121            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1121            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1122            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1122            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1123            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1123            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1124            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1124            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1125            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1125            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1126            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1126            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1127            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1127            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1128            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1128            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1129            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1129            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  1
                   MOVE    1120            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  1
                   MOVE    1120            TO    TOUKEI04-RECESYUBETU
      *ÊÝ¸±¤È¸øÈñ£²¼ï¤ÎÊ»ÍÑ
               WHEN    "1"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1131            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1131            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1132            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1132            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1133            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1133            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1134            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1134            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1135            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1135            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1136            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1136            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1137            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1137            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1138            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1138            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "1"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1139            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1139            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "2"    ALSO
                       "1"   ALSO   SPACE  ALSO  SPACE  ALSO  2
                   MOVE    1130            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  SPACE  ALSO  2
                   MOVE    1130            TO    TOUKEI04-RECESYUBETU
      *¸øÈñÃ±ÆÈ
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   1
                   MOVE    1211            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   1
                   MOVE    1212            TO    TOUKEI04-RECESYUBETU
      *£²¼ï¤Î¸øÈñÊ»ÍÑ
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   2
                   MOVE    1221            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   2
                   MOVE    1222            TO    TOUKEI04-RECESYUBETU
      *£³¼ï¤Î¸øÈñÊ»ÍÑ
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   3
                   MOVE    1231            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   SPACE  ALSO  SPACE  ALSO   3
                   MOVE    1232            TO    TOUKEI04-RECESYUBETU
      *Ï·¿ÍÃ±ÆÈ
               WHEN    ANY   ALSO   "1"    ALSO
                       "1"   ALSO   ANY    ALSO  "9"    ALSO   ZERO
                   MOVE    1317            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  "9"    ALSO   ZERO
                   MOVE    1317            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       "1"   ALSO   ANY    ALSO  "9"    ALSO   ZERO
                   MOVE    1318            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  "9"    ALSO   ZERO
                   MOVE    1318            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       "1"   ALSO   ANY    ALSO  "8"    ALSO   ZERO
                   MOVE    1319            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  "8"    ALSO   ZERO
                   MOVE    1319            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       "1"   ALSO   ANY    ALSO  "8"    ALSO   ZERO
                   MOVE    1310            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  "8"    ALSO   ZERO
                   MOVE    1310            TO    TOUKEI04-RECESYUBETU
      *Ï·¿Í¤È¸øÈñ£±¼ï¤ÎÊ»ÍÑ
               WHEN    ANY   ALSO   "1"    ALSO
                       "1"   ALSO   ANY    ALSO  "9"    ALSO   1
                   MOVE    1327            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  "9"    ALSO   1
                   MOVE    1327            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       "1"   ALSO   ANY    ALSO  "9"    ALSO   1
                   MOVE    1328            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  "9"    ALSO   1
                   MOVE    1328            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       "1"   ALSO   ANY    ALSO  "8"    ALSO   1
                   MOVE    1329            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  "8"    ALSO   1
                   MOVE    1329            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       "1"   ALSO   ANY    ALSO  "8"    ALSO   1
                   MOVE    1320            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  "8"    ALSO   1
                   MOVE    1320            TO    TOUKEI04-RECESYUBETU
      *Ï·¿Í¤È¸øÈñ£²¼ï¤ÎÊ»ÍÑ
               WHEN    ANY   ALSO   "1"    ALSO
                       "1"   ALSO   ANY    ALSO  "9"    ALSO   2
                   MOVE    1337            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  "9"    ALSO   2
                   MOVE    1337            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       "1"   ALSO   ANY    ALSO  "9"    ALSO   2
                   MOVE    1338            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  "9"    ALSO   2
                   MOVE    1338            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       "1"   ALSO   ANY    ALSO  "8"    ALSO   2
                   MOVE    1339            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "1"    ALSO
                       SPACE ALSO   "1"    ALSO  "8"    ALSO   2
                   MOVE    1339            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       "1"   ALSO   ANY    ALSO  "8"    ALSO   2
                   MOVE    1330            TO    TOUKEI04-RECESYUBETU
               WHEN    ANY   ALSO   "2"    ALSO
                       SPACE ALSO   "1"    ALSO  "8"    ALSO   2
                   MOVE    1330            TO    TOUKEI04-RECESYUBETU
      *Âà¿¦¼ÔÃ±ÆÈ
               WHEN    "1"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1411            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1412            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1413            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1414            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1415            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1416            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1417            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1418            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1409            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  ZERO
                   MOVE    1410            TO    TOUKEI04-RECESYUBETU
      *Âà¿¦¼Ô¤È¸øÈñ£±¼ï¤ÎÊ»ÍÑ
               WHEN    "1"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1421            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1422            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1423            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1424            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1425            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1426            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1427            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1428            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1429            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  1
                   MOVE    1420            TO    TOUKEI04-RECESYUBETU
      *Âà¿¦¼Ô¤È¸øÈñ£²¼ï¤ÎÊ»ÍÑ
               WHEN    "1"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1431            TO    TOUKEI04-RECESYUBETU
               WHEN    "1"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1432            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1433            TO    TOUKEI04-RECESYUBETU
               WHEN    "3"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1434            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1435            TO    TOUKEI04-RECESYUBETU
               WHEN    "2"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1436            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1437            TO    TOUKEI04-RECESYUBETU
               WHEN    "9"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1438            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "1"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1439            TO    TOUKEI04-RECESYUBETU
               WHEN    "8"   ALSO   "2"    ALSO
                       SPACE ALSO   "2"    ALSO  SPACE  ALSO  2
                   MOVE    1430            TO    TOUKEI04-RECESYUBETU
             END-EVALUATE
           END-IF
           .
       20021-RECESYUBETU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥¨¥é¡¼½ÐÎÏ½èÍý
      *****************************************************************
       200211-HKNNUM-SET-SEC                SECTION.
      *
           INITIALIZE                      HKNNUM-REC
           MOVE    COMB-HOSPID         TO  HKN-HOSPID
           MOVE    WRK-HKNNUM          TO  HKN-HKNNUM
           MOVE    WRK-PAYKBN          TO  HKN-PAYKBN   
           MOVE    WRK-SYMD            TO  HKN-TEKSTYMD
                                           HKN-TEKEDYMD
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNNUM
                   MOVE    MCPDATA-REC         TO  HKNNUM-REC
               ELSE
                   MOVE    1                   TO  FLG-HKNNUM
                   INITIALIZE                      HKNNUM-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNNUM
               INITIALIZE                      HKNNUM-REC
           END-IF
      *
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
           .
       200211-HKNNUM-SET-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥¨¥é¡¼½ÐÎÏ½èÍý
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   TOUKEIERR-FILE
           IF      STS-TOUKEIERR         =   ZERO
               CLOSE   TOUKEIERR-FILE
           ELSE
               OPEN    OUTPUT              TOUKEIERR-FILE
      *
               MOVE    WRK-TOUKEIERR         TO  TOUKEIERR-REC
               WRITE   TOUKEIERR-REC
               CLOSE   TOUKEIERR-FILE
      *         
      *        ¥¸¥ç¥Ö´ÉÍý³«»Ï½èÍý
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-TOUKEIERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½ªÎ»½èÍý
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   TOUKEI04-FILE
      *
           IF      CNT-TOUKEI04           =   ZERO  
               MOVE    "½èÍýÂÐ¾Ý¤Î¥Ç¡¼¥¿¤¬¤¢¤ê¤Þ¤»¤ó¤Ç¤·¤¿"
                                           TO  WRK-TOUKEIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    ¥¹¥Æ¥Ã¥×´ÉÍý½ªÎ»½èÍý
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
           DISPLAY "TOUKEI04  CNT-TOUKEI04:" CNT-TOUKEI04
           DISPLAY "*** ORCBT110 END ***"
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¡¡£Ò£Å£Á£Ä
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿ÆÉ¹þ
      *****************************************************************
       910-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
           .
       910-SYSKANRI-INV-EXT.
           EXIT.
      *****************************************************************
      *    ¥Æ¡¼¥Ö¥ë¸¡º÷½èÍý
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼õ¿ÇÍúÎò¥Þ¥¹¥¿£Ò£Å£Á£Ä
      *****************************************************************
       900-JYURRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-JYURRK
               MOVE    MCPDATA-REC         TO  JYURRK-REC
           ELSE
               MOVE    1                   TO  FLG-JYURRK
           END-IF
      *
           IF      FLG-JYURRK          =   ZERO
               MOVE    JYURRK-PTID         TO  KEY-N-PTID
               MOVE    JYURRK-DENPNUM      TO  KEY-N-DENPNUM
           END-IF
           .
       900-JYURRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿ÆÉ¹þ
      *****************************************************************
       910-HKNCOMBI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNCOMBI
                   MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
                   IF      COMB-DELKBN         =   "1"
                       MOVE    1                   TO  FLG-HKNCOMBI
                   END-IF
               ELSE
                   MOVE    1                   TO  FLG-HKNCOMBI
                   INITIALIZE                      HKNCOMBI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNCOMBI
               INITIALIZE                      HKNCOMBI-REC
           END-IF
      *
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
           .
       910-HKNCOMBI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    ´µ¼Ô¥Þ¥¹¥¿¡¼ÆÉ¹þ¡Ê¼ç¥­¡¼¡Ë
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    ZERO                TO  FLG-PTINF
               ELSE
                   MOVE    1                   TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÅÀ¿ôÆÉ¹þ
      *****************************************************************
       900-TENSU-READ-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-TENSU
      *
           MOVE    WRK-PARA-SRYYMD     TO  ORC-DBYMD
      *
           MOVE    TNS-SRYCD           TO  TTNS-CHK-SRYCD
           MOVE    ORC-DBYMD           TO  TTNS-CHK-YMD
      *
      *    ÅÀ¿ô¥Þ¥¹¥¿ÂàÈò¥ï¡¼¥¯¥Á¥§¥Ã¥¯
           PERFORM 9001-TTNS-CHK-SEC
      *
      *    ÂàÈò¥ï¡¼¥¯¤ËÂ¸ºß¤·¤Ê¤¤¾ì¹ç¤Ï£Ä£Â¤ò¸¡º÷
           IF    ( TTNS-FLG            =   ZERO )
               INITIALIZE                      TNS-TENSU-REC
               MOVE    TTNS-CHK-SRYCD      TO  TNS-SRYCD
               MOVE    TTNS-CHK-YMD        TO  ORC-DBYMD
               MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "DBFETCH"           TO  MCP-FUNC
                   MOVE    "TENSU-KEY"         TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF      MCP-RC              =   ZERO
                       MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
                       MOVE    ZERO            TO  FLG-TENSU
      *
      *                ÅÀ¿ô¥Þ¥¹¥¿ÂàÈò¥ï¡¼¥¯¤ËÊÔ½¸¤¹¤ë
                       PERFORM 9001-TTNS-HEN-SEC
                   ELSE
                       INITIALIZE                  TNS-TENSU-REC
                       MOVE    1                   TO  FLG-TENSU
                   END-IF
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1                   TO  FLG-TENSU
               END-IF
      *
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               PERFORM 900-DBCLOSE-SEC
           END-IF
      *
           .
      *
       900-TENSU-READ-EXT.
           EXIT.
      *****************************************************************
      *    ÅÀ¿ô¥Þ¥¹¥¿ÂàÈò¥ï¡¼¥¯¥Á¥§¥Ã¥¯½èÍý
      *****************************************************************
       9001-TTNS-CHK-SEC               SECTION.
      *
           MOVE    ZERO                TO  TTNS-FLG
           INITIALIZE                      TNS-TENSU-REC
      *
           PERFORM VARYING TTNS-IDX    FROM    1   BY  1
                   UNTIL ( TTNS-IDX    >   TTNS-MAX )
                    OR   ( TTNS-FLG    =   1 )
               IF    ( TTNS-KEY-SRYCD (TTNS-IDX)
                                       =   TTNS-CHK-SRYCD )
                 AND ( TTNS-KEY-YUKOSTYMD (TTNS-IDX)
                                      <=   TTNS-CHK-YMD )
                 AND ( TTNS-KEY-YUKOEDYMD (TTNS-IDX)
                                      >=   TTNS-CHK-YMD )
                   MOVE    1           TO  TTNS-FLG
                   MOVE    TTNS-DAT (TTNS-IDX)
                                       TO  TNS-TENSU-REC
               END-IF
           END-PERFORM
      *
           .
       9001-TTNS-CHK-EXT.
           EXIT.
      *****************************************************************
      *    ÅÀ¿ô¥Þ¥¹¥¿ÂàÈò¥ï¡¼¥¯ÊÔ½¸½èÍý
      *****************************************************************
       9001-TTNS-HEN-SEC               SECTION.
      *
           IF    ( TTNS-CONST-MAX  >   TTNS-MAX )
               COMPUTE TTNS-MAX    =   TTNS-MAX    +   1
               MOVE    TNS-SRYCD       TO  TTNS-KEY-SRYCD
                                                   (TTNS-MAX)
               MOVE    TNS-YUKOSTYMD   TO  TTNS-KEY-YUKOSTYMD
                                                   (TTNS-MAX)
               MOVE    TNS-YUKOEDYMD   TO  TTNS-KEY-YUKOEDYMD
                                                   (TTNS-MAX)
               MOVE    TNS-TENSU-REC   TO  TTNS-DAT
                                                   (TTNS-MAX)
           END-IF
      *
           .
       9001-TTNS-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ½»½ê¥Þ¥¹¥¿¸¡º÷
      *****************************************************************
       900-ADRS-INV-SEC            SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "ADRS-KEY2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "ADRS-KEY2"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  ADRS-REC
                   MOVE    ZERO                TO  FLG-ADRS
               ELSE
                   INITIALIZE                      ADRS-REC
                   MOVE    1                   TO  FLG-ADRS
               END-IF
           ELSE
               INITIALIZE                  ADRS-REC
               MOVE    1               TO  FLG-ADRS
           END-IF
      *
           MOVE    "ADRS-KEY2"         TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
           .
       900-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¿ÇÎÅ¹Ô°ÙÆÉ¹þ
      *****************************************************************
       900-SRYACT-READ-SEC           SECTION.
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
       900-SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¼ýÇ¼ÆÉ¹þ½èÍý
      *****************************************************************
       980-SYUNOU-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO  FLG-SYUNOU
           ELSE
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
      *
           .
       980-SYUNOU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ´µ¼ÔÏ«ºÒÊÝ¸±¾ðÊó¥Þ¥¹¥¿ÆÉ¹þ
      *****************************************************************
       900-PTRSIINF-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-PTRSIINF
                   MOVE    MCPDATA-REC         TO  PTRSIINF-REC
                   IF      PTRSI-SAKUJOKBN     =   "1"
                       MOVE    1                   TO  FLG-PTRSIINF
                   END-IF
               ELSE
                    INITIALIZE                 PTRSIINF-REC
                   MOVE    1                   TO  FLG-PTRSIINF
               END-IF
           ELSE
               INITIALIZE                  PTRSIINF-REC
               MOVE    1                   TO  FLG-PTRSIINF
           END-IF
      *
           MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
           .
       900-PTRSIINF-INV-EXT.
           EXIT.
      *****************************************************************
      *    ´µ¼ÔÊÝ¸±¾ðÊó¥Þ¥¹¥¿ÆÉ¹þ
      *****************************************************************
       910-PTHKNINF-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY3"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTHKNINF-KEY3"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-PTHKNINF
                   MOVE    MCPDATA-REC         TO  PTHKNINF-REC
                   IF      PTHKN-SAKJOKBN      =   "1"
                       MOVE    1                   TO  FLG-PTHKNINF
                   END-IF
               ELSE
                   MOVE    1                   TO  FLG-PTHKNINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTHKNINF
           END-IF
      *
           MOVE    "PTHKNINF-KEY3"     TO  ORC-DBPATH
           PERFORM 900-DBCLOSE-SEC
      *
           .
       910-PTHKNINF-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â£Ã£Ì£Ï£Ó£Å½èÍý
      *****************************************************************
       900-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â¥¯¥í¡¼¥¹½èÍý
      *****************************************************************
       990-DBCLOSE-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       990-DBCLOSE-EXT.
           EXIT.
      *      
      *****************************************************************
      *    £Ä£Â¡¡¥ª¡¼¥×¥ó½èÍý
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
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
      *    £Ä£Â¡¡¥¯¥í¡¼¥º½èÍý
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

