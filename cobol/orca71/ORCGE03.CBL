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
      *
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGE03.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : £Ã£Ó£ÖºîÀ®
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : £Ã£Ó£ÖºîÀ®¡Ê£Å£°£³¡Ë
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  01/09/15    ¤Ò¤µ¤Ê¤¬ ¡¡   ¿·µ¬ºîÀ®
      *****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      * 01.00.01     ¤Ò¤µ¤Ê¤¬     02/08/09  ³°Éô¥Õ¥¡¥¤¥ëÌ¾Ä¹¤µ¸í¤ê½¤Àµ
      * 01.00.02     ¤Ò¤µ¤Ê¤¬     02/12/20  ºî¶È¹àÌÜÄ¹¤µ½¤Àµ
      *
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    £Ã£Ó£ÖºîÀ®¾ò·ïÍÑ¥Õ¥¡¥¤¥ë 
           SELECT  EIE00-FILE      ASSIGN  EIE00PARA
                                   FILE    STATUS  IS  STS-EIE00.
      *    £Ã£Ó£ÖºîÀ®¾ò·ï£±¡Á£¶£°¥Õ¥¡¥¤¥ë 
           SELECT  EIE01-FILE      ASSIGN  EIE01PARA
                                   FILE    STATUS  IS  STS-EIE01.
      *    £Ã£Ó£Ö£±¡Á£¶£°¥Õ¥¡¥¤¥ë
           SELECT  EIECS-FILE      ASSIGN  EIECSPARA
                                   FILE    STATUS  IS  STS-EIECS.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    £Ã£Ó£ÖºîÀ®¾ò·ïÍÑ¥Õ¥¡¥¤¥ë
       FD  EIE00-FILE.
       01  EIE00-REC               PIC X(200). 
      *    £Ã£Ó£ÖºîÀ®¾ò·ï£±¡Á£¶£°¥Õ¥¡¥¤¥ë 
       FD  EIE01-FILE.
       01  EIE01-REC               PIC X(250).
      *    £Ã£Ó£Ö£±¡Á£¶£°¥Õ¥¡¥¤¥ë
       FD  EIECS-FILE.
       01  EIECS-REC               PIC X(1). 
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    £Ã£Ó£ÖºîÀ®¾ò·ïÍÑ¥Õ¥¡¥¤¥ë Ì¾¾ÎÎÎ°è 
           COPY    "CPCOMMONDAT4.INC"
                                   REPLACING  //ORCGD//
                                   BY         //EIE00//.
      *
      *    £Ã£Ó£ÖºîÀ®¾ò·ï£±¡Á£¶£°¥Õ¥¡¥¤¥ë Ì¾¾ÎÎÎ°è 
           COPY    "CPCOMMONDAT4.INC"
                                   REPLACING  //ORCGD//
                                   BY         //EIE01//.
      *
      *    £Ã£Ó£Ö£±¡Á£¶£°¥Õ¥¡¥¤¥ë Ì¾¾ÎÎÎ°è 
       01  EIECSPARA.
      *½¤Àµ/*³«»Ï*02.08.09*********************************************
      *     03  EIECSPARA-FILE-ID   PIC X(25).
           03  EIECSPARA-FILE-ID   PIC X(128).
      *½¤Àµ/*½ªÎ»*02.08.09*********************************************
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
      *
      *    ¥¨¥ó¥É¥¹¥Æ¡¼¥¿¥¹ÎÎ°è
       01  STS-AREA.
           03  STS-EIE00           PIC X(02).
           03  STS-EIE01           PIC X(02).
           03  STS-EIECS           PIC X(02).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX1                PIC 9(03).
           03  IDX2                PIC 9(03).
           03  IDX3                PIC 9(03).
           03  IDX4                PIC 9(04).
           03  IDX5                PIC 9(04).
           03  IDX6                PIC 9(03).
           03  IDX7                PIC 9(03).
           03  IDX8                PIC 9(03).
      *
      *    ÊÔ½¸ºî¶È
       01  W-AREA.
           03  WK-EIECS-REC            PIC  X(6000).
           03  WRK-PARA.
               05  WRK-PARA-SRYYM      PIC  X(06).
      *½¤Àµ/*³«»Ï*02.12.20*********************************************
      *         05  WRK-PARA-TERMID     PIC  X(16).
               05  WRK-PARA-TERMID     PIC  X(64).
      *½¤Àµ/*½ªÎ»*02.12.20*********************************************
               05  WRK-PARA-SYSYMD     PIC  X(08).
               05  WRK-PARA-SYOKBN     PIC  X(01).
               05  WRK-PARA-RECEKBN    PIC  X(01).
           03  WK-SRYYM                PIC  X(06).
           03  WK-PATH                 PIC  X(64).
           03  WK-TYPE                 PIC  X(10).
           03  WK-SPACE                PIC  X(01).
           03  WK-STPNT                PIC  9(06).
           03  WK-KTPNT                PIC  9(05).
           03  WK-PTPNT                PIC  9(05).
      *
      *    ºî¶È¥Æ¡¼¥Ö¥ëÌ¾¾ÎÎÎ°è
       01  WK-TBL1.
           03  WK-TBLSET       OCCURS  60.
               05  WK-TBL-MSG      PIC X(20).
               05  WK-TBL-KBN1     PIC X(01).
               05  WK-TBL-KBN2     PIC X(01).
       01  WK-TBL2.
           03  WK-TBLRET       OCCURS  500.
               05  WK-TBL-RMSG     PIC X(200).
      *
      *    ¥·¥§¥ëÍÑÎÎ°è
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
      *
      *    Ï¢Íí
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *     ¥Æ¡¼¥Ö¥ë¥¢¥¯¥»¥¹
           COPY    "MCPAREA".
      *
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
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
      *    ¼ç    ½è    Íý
      *****************************************************************
      *
       000-PROC-SEC                SECTION.
      *    £Ä£Â¡¡ ¥ª¡¼¥×¥ó½èÍý
           PERFORM 000-DBOPEN-SEC.
      *    £Ã£Ó£ÖºîÀ®¾ò·ï ÆþÎÏ½èÍý
           PERFORM T-000-CHEKCHEK-SEC.
      *    £Ã£Ó£ÖºîÀ®½èÍý
           PERFORM T-000-CSVSAKUS-SEC.
      *    £Ä£Â¡¡ ¥¯¥í¡¼¥º½èÍý
           PERFORM 000-DBCLOSE-SEC.
       000-PROC-SEC-EXT.
           STOP    RUN.
      *
      *****************************************************************
      *    £Ä£Â¡¡ ¥ª¡¼¥×¥ó½èÍý
      *****************************************************************
       000-DBOPEN-SEC                  SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
       000-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ä£Â¡¡ ¥¯¥í¡¼¥º½èÍý
      *****************************************************************
       000-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
       000-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ã£Ó£ÖºîÀ®¾ò·ï ÆþÎÏ½èÍý
      *****************************************************************
       T-000-CHEKCHEK-SEC              SECTION.
      *
           MOVE    COMMAND-PARAM   TO  WRK-PARA.
           MOVE    "ORCE00.CNV"    TO  EIE00PARA-FILE.
      *
           MOVE    SPACE           TO  WK-TBL1.
      *
           OPEN    INPUT               EIE00-FILE.
      *
           IF  STS-EIE00   =   ZERO
               PERFORM VARYING IDX1  FROM  1  BY 1
                       UNTIL   IDX1  >    60
                   READ  EIE00-FILE
                         AT   END
                              MOVE    61
                                      TO  IDX1
                         NOT  AT  END
                              MOVE    EIE00-REC(1:20)
                                      TO  WK-TBL-MSG (IDX1)
                              MOVE    EIE00-REC(22:1)
                                      TO  WK-TBL-KBN1 (IDX1)
                              MOVE    EIE00-REC(24:1)
                                      TO  WK-TBL-KBN2 (IDX1)
                   END-READ
               END-PERFORM
           END-IF.
      *
           CLOSE                       EIE00-FILE.
      *
       T-000-CHEKCHEK-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ã£Ó£Ö ºîÀ®½èÍý
      *****************************************************************
       T-000-CSVSAKUS-SEC              SECTION.
      *
           PERFORM VARYING IDX2  FROM  1  BY 1
                   UNTIL   IDX2  >    60
               IF  (WK-TBL-KBN1 (IDX2)    =   "*")
               AND (WK-TBL-KBN2 (IDX2)    =   "*")
                       PERFORM T-001-CSVWRITE-SEC
               END-IF
           END-PERFORM.
      *
       T-000-CSVSAKUS-EXT.
           EXIT.
      *
      *****************************************************************
      *    £Ã£Ó£Ö ½ÐÎÏ½èÍý
      *****************************************************************
       T-001-CSVWRITE-SEC              SECTION.
      *
           MOVE    ALL SPACE           TO  EIE01PARA-FILE.
           STRING  WK-TBL-MSG (IDX2)   DELIMITED  BY    SPACE
                   ".SLT"              DELIMITED  BY    SIZE
                                       INTO       EIE01PARA-FILE.
           MOVE    SPACE               TO  EIECSPARA-FILE-ID.
           MOVE    SPACE               TO  WK-PATH.
           MOVE    SPACE               TO  WK-SRYYM.
           MOVE    SPACE               TO  WK-TBL2.
      *
           OPEN    INPUT               EIE01-FILE.
      *
           IF      STS-EIE01       =   ZERO
               READ    EIE01-FILE
                 NOT  AT  END
                      MOVE    EIE01-REC(1:6)    TO  WK-SRYYM
                      MOVE    EIE01-REC(8:128)  TO  EIECSPARA-FILE-ID
                      MOVE    EIE01-REC(137:64) TO  WK-PATH
                      PERFORM VARYING IDX1  FROM  1  BY 1
                              UNTIL   IDX1  >   500
                          READ    EIE01-FILE
                             AT   END
                                  MOVE    501
                                          TO  IDX1
                             NOT  AT  END
                                  MOVE    EIE01-REC
                                          TO  WK-TBL-RMSG (IDX1)
                          END-READ
                      END-PERFORM
               END-READ
      *
               CLOSE                       EIE01-FILE
               OPEN    OUTPUT              EIECS-FILE
      *
               MOVE    SPACE           TO  MCPDATA-REC
               MOVE    "DBSELECT"      TO  MCP-FUNC
               MOVE    WK-PATH         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
               IF      MCP-RC    =   ZERO
                   PERFORM T-001-TBLFETCH-01-SEC
                   PERFORM UNTIL      MCP-RC   NOT  =  ZERO
                       MOVE    SPACE               TO  WK-EIECS-REC
                       MOVE    1                   TO  IDX4
                       PERFORM T-001-TBLCNVAT-01-SEC
                               VARYING IDX1  FROM  1  BY 1
                               UNTIL   IDX1  >   500
                       PERFORM T-001-WRITWRIT-01-SEC
                       PERFORM T-001-TBLFETCH-01-SEC
                   END-PERFORM
               END-IF
      *
               INITIALIZE              MCPAREA
               MOVE    "DBCLOSE"       TO  MCP-FUNC
               MOVE    WK-PATH         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
               CLOSE                       EIECS-FILE
           END-IF.
      *
       T-001-CSVWRITE-EXT.
           EXIT.
      *
      **********************
      *
       T-001-TBLFETCH-01-SEC             SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC.
           MOVE    WK-PATH             TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.    
      *
       T-001-TBLFETCH-01-EXT.
           EXIT.
      *
      **********************
      *
       T-001-TBLCNVAT-01-SEC             SECTION.
      *
           IF      WK-TBL-RMSG (IDX1)   =   SPACE
               MOVE    501                         TO  IDX1
           ELSE
               MOVE    WK-TBL-RMSG (IDX1)(71:6)    TO  WK-STPNT
               MOVE    WK-TBL-RMSG (IDX1)(51:5)    TO  WK-KTPNT
               MOVE    WK-TBL-RMSG (IDX1)(61:5)    TO  WK-PTPNT
      *
               IF      WK-TBL-RMSG (IDX1)(31:4)  =   "char"
                   MOVE    MCPDATA-REC(WK-STPNT:WK-KTPNT)
                           TO  WK-EIECS-REC(IDX4:WK-KTPNT)
                   COMPUTE       IDX4 = IDX4 + WK-KTPNT
                   MOVE    ","
                           TO  WK-EIECS-REC(IDX4:1)
                   COMPUTE       IDX4 = IDX4 + 1
               END-IF
               IF       WK-TBL-RMSG (IDX1)(31:6)  =   "number"
                   IF      WK-PTPNT     =   ZERO
                       MOVE    MCPDATA-REC(WK-STPNT:WK-KTPNT)
                               TO  WK-EIECS-REC(IDX4:WK-KTPNT)
                       COMPUTE       IDX4 = IDX4 + WK-KTPNT
                       MOVE    ","
                               TO  WK-EIECS-REC(IDX4:1)
                       COMPUTE       IDX4 = IDX4 + 1
                   ELSE
                       COMPUTE       WK-KTPNT = WK-KTPNT - WK-PTPNT
                       MOVE    MCPDATA-REC(WK-STPNT:WK-KTPNT)
                               TO  WK-EIECS-REC(IDX4:WK-KTPNT)
                       COMPUTE       IDX4 = IDX4 + WK-KTPNT
                       MOVE    "."
                               TO  WK-EIECS-REC(IDX4:1)
                       COMPUTE       IDX4 = IDX4 + 1
                       COMPUTE       WK-STPNT = WK-STPNT + WK-KTPNT
                       MOVE    MCPDATA-REC(WK-STPNT:WK-PTPNT)
                               TO  WK-EIECS-REC(IDX4:WK-PTPNT)
                       COMPUTE       IDX4 = IDX4 + WK-PTPNT
                       MOVE    ","
                               TO  WK-EIECS-REC(IDX4:1)
                       COMPUTE       IDX4 = IDX4 + 1
                   END-IF
               END-IF
               IF       WK-TBL-RMSG (IDX1)(31:7)  =   "varchar"
                   MOVE    MCPDATA-REC(WK-STPNT:WK-KTPNT)
                           TO  WK-EIECS-REC(IDX4:WK-KTPNT)
                   MOVE    SPACE
                           TO  WK-SPACE
                   MOVE    IDX4
                           TO  IDX7
                   COMPUTE       IDX4 = IDX4 + WK-KTPNT
                   PERFORM UNTIL   WK-SPACE  =   "*"
                       IF      WK-EIECS-REC(IDX4:1)   =   SPACE
                           COMPUTE       IDX4 = IDX4 - 1
                       ELSE
                           COMPUTE       IDX8 = IDX4 - 1
                           IF      WK-EIECS-REC(IDX8:2)   =   "¡¡"
                               COMPUTE       IDX4 = IDX4 - 2
                           ELSE
                               MOVE    "*"   TO  WK-SPACE
                               COMPUTE       IDX4 = IDX4 + 1
                           END-IF
                       END-IF
                       IF      IDX4   <   IDX7
                           MOVE    IDX7   TO  IDX4
                           MOVE    "*"    TO  WK-SPACE
                       END-IF
                   END-PERFORM
                   MOVE    ","   TO  WK-EIECS-REC(IDX4:1)
                   COMPUTE       IDX4 = IDX4 + 1
               END-IF
           END-IF.    
      *
       T-001-TBLCNVAT-01-EXT.
           EXIT.
      *
      **********************
      *
       T-001-WRITWRIT-01-SEC             SECTION.
      *
           COMPUTE       IDX4 = IDX4 - 1.
           MOVE    X"0A"                TO  WK-EIECS-REC(IDX4:1).
      *
           IF      WK-SRYYM   =   SPACE
               PERFORM VARYING IDX5   FROM   1   BY   1
                       UNTIL   IDX5   >   IDX4
                   MOVE    WK-EIECS-REC(IDX5:1)    TO  EIECS-REC
                   WRITE   EIECS-REC
               END-PERFORM
           ELSE
               IF      ((WK-TBL-MSG (IDX2)(1:6) = "JYURRK")
                   AND  (MCPDATA-REC(37:6) = WK-SRYYM))
               OR      ((WK-TBL-MSG (IDX2)(1:8) = "PTBYOMEI")
                   AND  (MCPDATA-REC(37:6) = WK-SRYYM))
               OR      ((WK-TBL-MSG (IDX2)(1:7) = "SRYACCT")
                   AND  (MCPDATA-REC(38:6) = WK-SRYYM))
               OR      ((WK-TBL-MSG (IDX2)(1:6) = "SRYACT")
                   AND  (MCPDATA-REC(38:6) = WK-SRYYM))
               OR      ((WK-TBL-MSG (IDX2)(1:8) = "WKSRYACT")
                   AND  (MCPDATA-REC(38:6) = WK-SRYYM))
               OR      ((WK-TBL-MSG (IDX2)(1:6) = "SANTEI")
                   AND  (MCPDATA-REC(35:6) = WK-SRYYM))
               OR      ((WK-TBL-MSG (IDX2)(1:6) = "SEIKYU")
                   AND  (MCPDATA-REC(25:6) = WK-SRYYM))
               OR      ((WK-TBL-MSG (IDX2)(1:5) = "BD002")
                   AND  (MCPDATA-REC(47:6) = WK-SRYYM))
                   PERFORM VARYING IDX5   FROM   1   BY   1
                           UNTIL   IDX5   >   IDX4
                       MOVE    WK-EIECS-REC(IDX5:1)    TO  EIECS-REC
                       WRITE   EIECS-REC
                   END-PERFORM
               END-IF
           END-IF. 
      *
       T-001-WRITWRIT-01-EXT.
           EXIT.
      *
