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
       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         ORCS02.
      ****************************************************************
      *    OS           LINUX                                         
      *                                                               
      *    PROGRAM      ORCS02  /  ÉéÃ´¶â³Û»»Äê¥µ¥Ö                   
      *                            ¡ÊÆþ±¡ÍÑ¡Ë                         
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  02/10/22    NACL¡ÝÌçÏÆ    ¿·µ¬ºîÀ®
      ****************************************************************
      *  ¥×¥í¥°¥é¥à½¤ÀµÍúÎò
      * Maj/Min/Rev  ½¤Àµ¼Ô       ÆüÉÕ      ÆâÍÆ
      *  01.00.01    NACL¡ÝÌçÏÆ   03/03/07  Ï·¿Í¸ÂÅÙ³Û¤Î½¸·×ÊÑ¹¹
      *****************************************************************
       ENVIRONMENT         DIVISION.
       CONFIGURATION       SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE SECTION.
      *
       01  WK-KSNRATE9                 PIC 9(03).
       01  WK-KSNRATE                  PIC 9V99.
      *01  WK-NISSU1                   PIC 9(05).
      *01  WK-NISSU2                   PIC 9(05).
       01  KEISAN-AREA.
           03  WK-KNJFTNKIN            PIC 9(10).
           03  WK-ZENGAKU              PIC 9(10).
           03  WK-ZENGAKU-SYU          PIC 9(10).
           03  WK-ZENGAKU-YAK          PIC 9(10).
           03  WK-FUTANWARI            PIC 9V99.
           03  WK-SEIKYUGK             PIC 9(10).
           03  WK-NYUKFTNRATE          PIC 9(03).
           03  WK-TOKUTEI-COMPFTN      PIC 9(08).
           03  WK-TOKUTEI-COMPFTN2     PIC 9(08).
           03  WK-TOKUTEI-COMPFTN3     PIC 9(08).
       01  WK-FLG.
           03  FLG-SYUNOU              PIC 9(01).
           03  FLG-TNKRRK              PIC 9(01).
           03  FLG-TSYRRK              PIC 9(01).
           03  FLG-HKNNUM              PIC 9(01).
           03  FLG-HKNCOMBI            PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-PTINF               PIC 9(01).
           03  FLG-NYUINACCT           PIC 9(01).
           03  FLG-SRYACCT             PIC 9(01).
           03  FLG-SANSHOU             PIC X(01).
           03  FLG-SANSHOU2            PIC X(01).
           03  FLG-SANSHOU3            PIC X(01).                       
           03  FLG-SANTEI1             PIC X(01).
           03  FLG-SANTEI2             PIC X(01).
           03  FLG-SANTEI3             PIC X(01).
           03  FLG-SANTEI4             PIC X(01).
      *
           03  WK-PAYKBN               PIC X(02).
      *
      *    Äã½êÆÀ£±¤ÎÄ¹´üÆþ±¡Ç§ÄêÇ¯·îÆü
           03  WRK-SKJGNSTYMD-S        PIC X(08).
           03  WRK-SKJGNSTYMD-E        PIC X(08).
           03  WRK-SKJGNSTYMD2.
               05  WRK-SKJGNSTYYMM2    PIC 9(06).
               05  WRK-SKJGNSTDD2      PIC 9(02).
      *
      *    ÊÝ¸±¶èÊ¬¡Ê¶õÇò¡§°åÊÝ¡¡£±¡§Ï«ºÒ¡¦¼«Çå¡Ë
           03  WK-HKNKBN               PIC X(01).
      *
      *    ´µ¼ÔÉéÃ´·×»»»þ¤Î»Í¼Î¸ÞÆþÍÑ¥ï¡¼¥¯
           03  WK-FTN                  PIC 9(10).
      *
      *    ÉÂ±¡³ä°ú³Û·×»»»þ¤Î³ä°úÎ¨ÍÑ¥ï¡¼¥¯
           03  WK-RATE                 PIC 9(1)V9(2).
      *
      *    ¸øÈñ¤Î´µ¼ÔÉéÃ´¾å¸Â¶â³Û¤ÎÂàÈòÍÑ¥¨¥ê¥¢
       01  HOKEN-MAX-AREA.
           03  MAX-KIN-KOHI1-M         PIC 9(08).
           03  MAX-KIN-KOHI2-M         PIC 9(08).
           03  MAX-KIN-KOHI3-M         PIC 9(08).
           03  MAX-KIN-KOHI4-M         PIC 9(08).
      *
      *    ¸øÈñ¤Î´µ¼ÔÉéÃ´ºÑ¤ß¶â³Û¤Î²Ã»»ÍÑ¥¨¥ê¥¢
       01  HOKEN-FUTAN-AREA.
           03  FTN-KOHI1-M             PIC 9(08).
           03  FTN-KOHI2-M             PIC 9(08).
           03  FTN-KOHI3-M             PIC 9(08).
           03  FTN-KOHI4-M             PIC 9(08).
      *
      *    ¸øÈñ¤Î´µ¼ÔÉéÃ´²ÄÇ½¤Ê»Ä³Û»»ÄêÍÑ¥¨¥ê¥¢
       01  HOKEN-ZAN-AREA.
           03  ZAN-KOHI1-M             PIC 9(08).
           03  ZAN-KOHI2-M             PIC 9(08).
           03  ZAN-KOHI3-M             PIC 9(08).
           03  ZAN-KOHI4-M             PIC 9(08).
           03  ZAN-KOHI-AREA.
             05  ZAN-KOHI1             PIC 9(08).
             05  ZAN-KOHI2             PIC 9(08).
             05  ZAN-KOHI3             PIC 9(08).
             05  ZAN-KOHI4             PIC 9(08).
           03  ZAN-KOHI-TBL  REDEFINES  ZAN-KOHI-AREA
                                        OCCURS  4.
             05  ZAN-KOHI-T            PIC 9(08).
      *
      *    ´µ¼ÔÇ¯Îð»»½ÐÍÑ¥¨¥ê¥¢
       01  WRK-NENREI-AREA.
           03  WRK-NENREI              PIC 9(03).
           03  WRK-YMDS1.
               05  WRK-YYS1            PIC 9(04).
               05  WRK-MMS1            PIC 9(02).
               05  WRK-DDS1            PIC 9(02).
           03  WRK-YMDS2.
               05  WRK-YYS2            PIC 9(04).
               05  WRK-MMS2            PIC 9(02).
               05  WRK-DDS2            PIC 9(02).
      *
      *    Åº¤¨»úÎÎ°è
       01  IDX-AREA.
           03  IDX                     PIC  9(02)  VALUE  ZERO.
           03  IDX-ST                  PIC  9(02)  VALUE  ZERO.
           03  IDX-ED                  PIC  9(02)  VALUE  ZERO.
           03  IDY                     PIC  9(02)  VALUE  ZERO.
           03  IDZ                     PIC  9(02)  VALUE  ZERO.
           03  HKNNYU-IDX              PIC  9(02)  VALUE  ZERO.
           03  KOH-IDX                 PIC  9(02)  VALUE  ZERO.
      *
      *    ¹âÎð¼Ô¤ÎÉéÃ´¾å¸Â»»Äê¥¨¥ê¥¢
       01  WK-SYUHKN-TAIHI-AREA.
           03  MAX-KIN-SYU-M           PIC 9(08).
           03  FTN-SYU-M               PIC 9(08).
           03  ZAN-SYU-M               PIC 9(08).
           03  FLG-SANTEI-SYU          PIC X(01).
           03  FLG-KOUREI              PIC 9(01).
           03  FLG-IRYOHI              PIC 9(01).
           03  FLG-KOUGAKUCYO          PIC 9(01).
           03  FLG-SKJ                 PIC 9(01).
           03  WK-SYU-SYUCOMPFTN       PIC 9(08).
           03  WK-KOUREI-IRYOHI        PIC 9(08).
           03  WK-KOUREI-IRYOHI2       PIC 9(08).
           03  FTN-KOH-XXX             PIC 9(08).                       
           03  FTN-KOH-YYY             PIC 9(08).                       
           03  FTN-KOH-ZZZ             PIC 9(08).                       
      *
      *    ¿©»öÉéÃ´»»Äê¥¨¥ê¥¢
       01  WK-SHOKUJI-TAIHI-AREA.
           03  WK-SHOKUJIRYOYO         PIC 9(01).
           03  WK-TOKUKANRIKASAN       PIC 9(01).
           03  WK-SHOKUJI-NISSU        PIC 9(02).
           03  WK-SHOKUJI-RYOYOHI      PIC 9(07).
           03  WK-SHOKUJI-RYOYOHI95    PIC 9(07).
           03  WK-SHOKUJI-RYOYOHI96    PIC 9(07).
           03  WK-SHOKUJI-JIHI         PIC 9(07).
           03  WK-SHOKUJI-FTN          PIC 9(07).
           03  WK-SHOKUJI-FTN95        PIC 9(07).
           03  WK-SHOKUJI-FTN96        PIC 9(07).
           03  WK-NYUSKJRYYKBN         PIC X(01).
           03  WK-NISSU-SKJ            PIC 9(02).
           03  WK-KNJFTNKIN-SKJ        PIC 9(07).
           03  WK-RYOYOHI-SKJ          PIC 9(07).
      *    03  WK-TSUSAN-NISSU         PIC 9(04).
      *    03  WK-SEIKYUKIKAN-NISSU    PIC 9(04).
      *    ¿©Æ²²Ã»»ÂàÈò¥Æ¡¼¥Ö¥ë
       01  WK-SHOKUDOKASAN-TABLE.
           03  WK-SHOKUDOKASAN-T       OCCURS   31.
               05  WK-SHOKUDOKASAN     PIC 9(04).
      *    Ï«ºÒÆþ±¡Ãæ¤ÎÆÃÊÌ¿©²Ã»»ÂàÈò¥Æ¡¼¥Ö¥ë
       01  WK-ROSAITOKU-TABLE.
           03  WK-ROSAITOKU-T          OCCURS   31.
               05  WK-ROSAITOKU95      PIC 9(04).
               05  WK-ROSAITOKU96      PIC 9(04).
               05  WK-ROSAITOKU97      PIC 9(04).
      *
      *****************************************************************
      *    ¥Õ¥¡¥¤¥ë¥ì¥¤¥¢¥¦¥È
      *****************************************************************
      *
      *    ¼ýÇ¼¥Þ¥¹¥¿¡¼
       01  SYU-SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    Äã½êÆÀ¼ÔÍúÎò
       01  TSYRRK-REC.
           COPY    "CPTSYRRK.INC".
      *
      *    Ç¯¶âÍúÎò
       01  TNKRRK-REC.
           COPY    "CPTNKRRK.INC".
      *
      *    ÊÝ¸±ÁÈ¤ß¹ç¤ï¤»
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ÊÝ¸±ÈÖ¹æ
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    Æþ±¡²ñ·×
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    ¿ÇÎÅ²ñ·×
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    ¥·¥¹¥Æ¥à´ÉÍý
           COPY    "CPSK1001.INC".
           COPY    "CPSK1026.INC".
           COPY    "CPSK1027.INC".
           COPY    "CPSK4001.INC".
           COPY    "CPSK5000.INC".
      *
      *    ´µ¼Ô¾ðÊó
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑ¡¡ÎÎ°è
      *****************************************************************
      *
      *    ÆüÉÕÊÑ´¹¥µ¥Ö
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *    ÊÝ¸±»»ÄêÍÑÇ¯Îð¡¦³ä¹ç·×»»¥µ¥Ö
           COPY    "CPORCSAGECHK.INC".
      *    £Ä£Â¸¡º÷
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      /
      ***
       LINKAGE             SECTION.
           COPY  "MCPAREA". 
       01  LNK-ORCS02-REC.
           COPY  "CPORCS02.INC".
       01  LNK-SYUNOU-REC.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
       01  LNK-WRK-SYUNOU-REC-T.
         02 LNK-WRK-SYUNOU-REC     OCCURS 10.
           COPY  "CPSYUNOU.INC"  
                               REPLACING  //SYU-// BY //LNK-WRK-SYU-//.
      /
       PROCEDURE           DIVISION  USING
                                     MCPAREA
                                     LNK-ORCS02-REC
                                     LNK-SYUNOU-REC
                                     LNK-WRK-SYUNOU-REC-T.
      ******************************************************************
      *        °ÍÍêÀ©¸æ½èÍý
      ******************************************************************
       MAIN-RTN            SECTION.
       MAIN-000.
      **   MOVE    ZERO            TO  LNK-S02-RC.
           MOVE    SPACE           TO  KEISAN-AREA.
           INITIALIZE                  KEISAN-AREA.
           MOVE    ZERO            TO  LNK-SYU-RJN-FTN
                                       LNK-SYU-KOH-FTN
                                       LNK-SYU-YKZ-FTN.
           MOVE    ZERO            TO  LNK-SYU-SYUHKNFTNMONEY
                                       LNK-SYU-SYUCOMPFTN
                                       LNK-SYU-SYUCOMPYKZFTN
                                       LNK-SYU-SYUCOMPTOTAL.
           MOVE    SPACE           TO  LNK-SYU-SYUYKZFTNKBN.
           PERFORM   VARYING   IDX   FROM   1    BY   1
             UNTIL   IDX   >   4
                  MOVE    ZERO     TO  LNK-SYU-KOH-HKNFTNMONEY(IDX)
                                       LNK-SYU-KOH-COMPFTN(IDX)
                                       LNK-SYU-KOH-COMPYKZFTN(IDX)
                                       LNK-SYU-KOH-COMPTOTAL(IDX)
                  MOVE    SPACE    TO  LNK-SYU-KOH-YKZFTNKBN(IDX)
           END-PERFORM.
           MOVE    ZERO            TO  LNK-SYU-RESE-YKZ-FTN.
      *
           PERFORM   VARYING   IDX   FROM   1    BY   1
             UNTIL   IDX   >   7
                  MOVE    ZERO     TO  LNK-SYU-SHOKUJI(IDX)
                                       LNK-SYU-SHOKUJI-NISSU(IDX)
           END-PERFORM.              
           MOVE           ZERO     TO  LNK-SYU-SYUSKJ-NISSU
                                       LNK-SYU-SYUSKJ-RYOYOHI
                                       LNK-SYU-SYUSKJ-FTN
                                       LNK-SYU-SYUSKJ-FTN-RECE.
           MOVE           SPACE    TO  LNK-SYU-SYUSKJ-FTNKBN.
           PERFORM   VARYING   IDX   FROM   1    BY   1
             UNTIL   IDX   >   4
                  MOVE    ZERO     TO  LNK-SYU-SKJ-NISSU(IDX)
                                       LNK-SYU-SKJ-RYOYOHI(IDX)
                                       LNK-SYU-SKJ-FTN(IDX)
                                       LNK-SYU-SKJ-FTN-RECE(IDX)
                  MOVE    SPACE    TO  LNK-SYU-SKJ-FTNKBN(IDX)
           END-PERFORM.
           MOVE           ZERO     TO  LNK-SYU-RYOYOHI-SKJ.
           MOVE           ZERO     TO  LNK-SYU-SKYMONEY-SKJ.
           MOVE           ZERO     TO  LNK-SYU-SKYMONEY-SKJ-TAX.
           MOVE           ZERO     TO  LNK-SYU-SKYMONEY-SKJ-KEI.
           MOVE           ZERO     TO  LNK-SYU-RYOYOHI-SKJ-JIHI.
           MOVE           ZERO     TO  LNK-SYU-SKYMONEY-SKJ-JIHI.
           MOVE           ZERO     TO  LNK-SYU-SKYMONEY-SKJ-JIHI-TAX.
           MOVE           ZERO     TO  LNK-SYU-SKYMONEY-SKJ-JIHI-KEI.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¤Î»²¾ÈÉôÊ¬³ÎÄê
           PERFORM   100-KAKUTEI-SEC.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¤Î¸¡º÷
           INITIALIZE                           HKNCOMBI-REC.
           MOVE    LNK-SYU-HOSPID       TO      COMB-HOSPID.
           MOVE    LNK-SYU-PTID         TO      COMB-PTID.
           MOVE    LNK-SYU-HKNCOMBINUM  TO      COMB-HKNCOMBINUM.
           MOVE    HKNCOMBI-REC         TO      MCPDATA-REC.
           MOVE    "DBSELECT"           TO      MCP-FUNC.
           MOVE    "HKNCOMBI-KEY"       TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC               =       ZERO
               MOVE    "HKNCOMBI-KEY"   TO      ORC-DBPATH 
               PERFORM   HKNCOMBI-READ-SEC
               IF      FLG-HKNCOMBI     =       1
                   MOVE    "DBCLOSE"        TO      MCP-FUNC
                   MOVE    "HKNCOMBI-KEY"   TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING   MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                   DISPLAY "HKNCOMBI DBFETCH ERR"
                   MOVE     10          TO      LNK-S02-RC
                   GO   TO              MAIN-EXT
               END-IF
           ELSE
               MOVE    "DBCLOSE"        TO      MCP-FUNC
               MOVE    "HKNCOMBI-KEY"   TO      ORC-DBPATH
               CALL    "ORCMCPSUB"       USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
               MOVE    1                TO      FLG-HKNCOMBI
               DISPLAY "HKNCOMBI DBSELECT ERR"
               MOVE     10              TO      LNK-S02-RC
               GO   TO                  MAIN-EXT
           END-IF.
           MOVE    "DBCLOSE"            TO      MCP-FUNC.
           MOVE    "HKNCOMBI-KEY"       TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¤«¤é¼çÊÝ¸±¤ÎÊÝ¸±¼ïÎà¤òÈ½Äê
      *    ¡Ê¶õÇò¡§°åÊÝ¡¢£±¡§Ï«ºÒ¡¦¼«Çå¡Ë
           MOVE     SPACE               TO       WK-HKNKBN.
           EVALUATE    COMB-SYU-HKNKOHSBTKBN
               WHEN    "4"
                       MOVE    "1"      TO       WK-HKNKBN
           END-EVALUATE.
      *
      *    ´µ¼ÔÉéÃ´³Û¤Î»»Äê
           PERFORM       200-HKNFTN-SANTEI-SEC.
      *
      *    »»½ÐÀÁµá³Û¤Î£±£°±ßÌ¤Ëþ»Í¼Î¸ÞÆþ¡ÊÌôºÞ°ìÉôÉéÃ´¶â¤â´Þ¤à¡Ë
      *    ¢¨Ï«ºÒÊÝ¸±¤Î¾ì¹ç¤Ï»Í¼Î¸ÞÆþ¤ò¹Ô¤ï¤Ê¤¤
      *    ¢¨Ï·¿Í£²³ä¤Ç¸ÂÅÙ¤¬£·£²£³£°£°±ß¡Ü¡÷±ß¤Î¾ì¹ç¤Ï»Í¼Î¸ÞÆþ¤ò¹Ô¤ï¤Ê¤¤
           IF     (LNK-SYU-SKYMONEY      NOT =   ZERO)   
               IF   WK-HKNKBN                =   "1"
               OR   FLG-KOUGAKUCYO           =    1 
                   CONTINUE
               ELSE
                   COMPUTE  LNK-SYU-SKYMONEY = LNK-SYU-SKYMONEY  +  5
                   COMPUTE  WK-SEIKYUGK      = LNK-SYU-SKYMONEY  /  10
                   COMPUTE  LNK-SYU-SKYMONEY = WK-SEIKYUGK       *  10
               END-IF 
           END-IF.
      *
      *    ¼çÊÝ¸±¡¦Ï·¿Í¡¦¸øÈñ¤ÎÈ½ÊÌ
      *      ¡Ê¼çÊÝ¸±¡Ë
           IF     (LNK-SYU-SYUHKNNUM     NOT =   SPACE)    AND
                  (LNK-SYU-KOH1HKNNUM    =       SPACE)    AND
                  (LNK-SYU-KOH2HKNNUM    =       SPACE)    AND
                  (LNK-SYU-KOH3HKNNUM    =       SPACE)    AND
                  (LNK-SYU-KOH4HKNNUM    =       SPACE)
                   MOVE   LNK-SYU-SKYMONEY   TO   LNK-SYU-HKNTEKMONEY
           END-IF.
      *       ¡ÊÏ·¿Í¡Ë 
      *
           IF     (LNK-SYU-KOH1HKNNUM    =   SPACE)    AND
                  (LNK-SYU-KOH2HKNNUM    =   SPACE)    AND
                  (LNK-SYU-KOH3HKNNUM    =   SPACE)    AND
                  (LNK-SYU-KOH4HKNNUM    =   SPACE)
                   CONTINUE
           ELSE
               IF      COMB-KOH1-HKNKOHSBTKBN    =       "3"
                  IF  (COMB-KOH2-HKNKOHSBTKBN    =     SPACE)  AND
                      (COMB-KOH3-HKNKOHSBTKBN    =     SPACE)  AND
                      (COMB-KOH4-HKNKOHSBTKBN    =     SPACE)
                       MOVE   LNK-SYU-SKYMONEY   TO   LNK-SYU-RJN-FTN
                  ELSE
      *            ¡Ê¸øÈñ¡Ë
                       MOVE   LNK-SYU-SKYMONEY   TO   LNK-SYU-KOH-FTN
                  END-IF
               ELSE
      *            ¡Ê¸øÈñ¡Ë
                       MOVE   LNK-SYU-SKYMONEY   TO   LNK-SYU-KOH-FTN
               END-IF
           END-IF.
      *
      *    ¼«Èñ¶â³Û¤Î¾ÃÈñÀÇ·×»»
           COMPUTE   LNK-SYU-JIHI-TOTAL =  (LNK-SYU-JIHI-TAXNASI(1)  +
                                            LNK-SYU-JIHI-TAXNASI(2)  +
                                            LNK-SYU-JIHI-TAXNASI(3)  +
                                            LNK-SYU-JIHI-TAXNASI(4)  +
                                            LNK-SYU-JIHI-TAXNASI(5)).
           COMPUTE   LNK-SYU-JIHI-TOTAL-TAX = (LNK-SYU-JIHI-TAXARI(1) +
                                               LNK-SYU-JIHI-TAXARI(2) +
                                               LNK-SYU-JIHI-TAXARI(3) +
                                               LNK-SYU-JIHI-TAXARI(4) +
                                               LNK-SYU-JIHI-TAXARI(5)).
           COMPUTE   LNK-SYU-JIHI-TAX = LNK-SYU-JIHI-TOTAL-TAX * 0.05.
      *
      *    ÊÝ¸±Å¬ÍÑ³°¶â³Û¤Î²Ã»»
           MOVE       ZERO              TO  LNK-SYU-TGMONEY(12).
           MOVE       ZERO              TO  LNK-SYU-TGMONEY-TAX(12).
           PERFORM    VARYING   HKNNYU-IDX   FROM   1   BY   1
                      UNTIL     HKNNYU-IDX   >     11
                      ADD       LNK-SYU-TGMONEY(HKNNYU-IDX)
                                            TO  LNK-SYU-TGMONEY(12)
                      ADD       LNK-SYU-TGMONEY-TAX(HKNNYU-IDX)
                                        TO  LNK-SYU-TGMONEY-TAX(12)
           END-PERFORM.
           COMPUTE  LNK-SYU-TGMONEY-TAX(12)  =  LNK-SYU-TGMONEY-TAX(12)
                                             *  1.05.
      *
      *    ÀÁµá¶â³Û¤Î·×»»¡ÊÄ´À°¶â´Þ¤Þ¤º¡Ë
           COMPUTE    LNK-SYU-SKYMONEY  =   
                                 LNK-SYU-SKYMONEY              +
                                 LNK-SYU-RMSAGAKU              +
                                 LNK-SYU-SKYMONEY-SKJ-KEI      +
                                 LNK-SYU-SKYMONEY-SKJ-JIHI-KEI +
                                 LNK-SYU-TGMONEY(12)           +
                                 LNK-SYU-TGMONEY-TAX(12)       +
                                 LNK-SYU-JIHI-TOTAL            +
                                 LNK-SYU-JIHI-TOTAL-TAX        +
                                 LNK-SYU-JIHI-TAX.
      *
      *    ¼«ÈñÊÝ¸±¤ÎÊä½õ¶èÊ¬¤¬²ÝÀÇ¤Î¾ì¹ç¡¢¾ÃÈñÀÇ·×»»¤ò¹Ô¤¦
           IF  ( COMB-SYU-HKNKOHSBTKBN  =  "8" ) AND
               ( COMB-HOJOKBN           =  "1" )
      *
              COMPUTE  LNK-SYU-SKYMONEY   =  LNK-SYU-SKYMONEY
                                          *  1.05
      *
           END-IF.     
      *
      *    ÉÂ±¡¸ºÌÈ¤Î·×»»
           IF     LNK-SYU-SKYMONEY      NOT =   ZERO
                   INITIALIZE                           PTINF-REC
                   MOVE    LNK-SYU-HOSPID       TO      PTINF-HOSPID
                   MOVE    LNK-SYU-PTID         TO      PTINF-PTID
                   MOVE    PTINF-REC            TO      MCPDATA-REC
                   MOVE    "DBSELECT"           TO      MCP-FUNC
                   MOVE    "PTINF-KEY"          TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"           USING   MCPAREA
                                                         ORCMCPAREA
                                                         MCPDATA-REC
                   IF      MCP-RC               =       ZERO
                       MOVE    "PTINF-KEY"      TO      ORC-DBPATH
                       PERFORM  PTINF-READ-SEC
                       IF       MCP-RC          =       ZERO
                           PERFORM   GENMEN-KEISAN-SEC
                       ELSE
                           DISPLAY  "PTINF FETCH ERR"
                       END-IF
                   ELSE
                       DISPLAY   "PTINF SELECT ERR"
                   END-IF
      *
                   MOVE    "DBCLOSE"            TO  MCP-FUNC
                   MOVE    "PTINF-KEY"          TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"           USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           END-IF.
      *
      *    ÀÁµá¶â³Û¤Î·×»»¡ÊÏ«ºÒÊÝ¸±Å¬ÍÑ»þ¤Î±ß·ú¤Æ¹àÌÜ²Ã»»¡Ë
           IF   (WK-HKNKBN               =    "1")   AND
                (LNK-SYU-SYUHKNNUM       =    "971")  
                 MOVE    ZERO      TO       LNK-SYU-SKYMONEY
           COMPUTE    LNK-SYU-SKYMONEY  =   LNK-SYU-SKYMONEY    +
                                            LNK-SYU-TGMONEY(12) +
                                            LNK-SYU-TGMONEY-TAX(12) +
                                            LNK-SYU-JIHI-TOTAL  +
                                            LNK-SYU-JIHI-TOTAL-TAX  +
                                            LNK-SYU-JIHI-TAX
      *      IF  COMB-NYU-FTNKBN   =       "1"
      *        COMPUTE  LNK-SYU-SKYMONEY =  LNK-SYU-SKYMONEY         +
      *                                     LNK-SYU-RSISHOSHIN-MONEY +
      *                                     LNK-SYU-RSISAISHIN-MONEY +
      *                                     LNK-SYU-RSISDO-MONEY     +
      *                                     LNK-SYU-RSIETC-MONEY
      *      END-IF
           END-IF.
      *
      *    ¼«ÇåÀÕÊÝ¸±¤Î¾ì¹ç¡¢Ï«ºÒ±ß·ú¤Æ¹àÌÜ¤Ø¤Î²Ã»»Î¨·×»»ÄÉ²Ã
           IF   (WK-HKNKBN               =    "1")   AND
                (LNK-SYU-SYUHKNNUM       =    "973")
                 COMPUTE  LNK-SYU-RSISHOSHIN-MONEY  =
                          LNK-SYU-RSISHOSHIN-MONEY  *  WK-KSNRATE      
                 COMPUTE  LNK-SYU-RSISAISHIN-MONEY  =
                          LNK-SYU-RSISAISHIN-MONEY  *  WK-KSNRATE
      *          COMPUTE  LNK-SYU-RSISDO-MONEY      =
      *                   LNK-SYU-RSISDO-MONEY      *  WK-KSNRATE
                 COMPUTE    LNK-SYU-SKYMONEY  =   LNK-SYU-SKYMONEY  +
      *                                     LNK-SYU-TGMONEY(12)     +
      *                                     LNK-SYU-TGMONEY-TAX(12) +
      *                                     LNK-SYU-JIHI-TOTAL      +
      *                                     LNK-SYU-JIHI-TOTAL-TAX  +
      *                                     LNK-SYU-JIHI-TAX        +
                                            LNK-SYU-RSISHOSHIN-MONEY +
                                            LNK-SYU-RSISAISHIN-MONEY +
                                            LNK-SYU-RSISDO-MONEY     +
                                            LNK-SYU-RSIETC-MONEY
           END-IF.
      *
      *    ÀÁµá¶â³Û¤Î·×»»¡ÊÄ´À°¶â¤Î²Ã¸º»»¡Ë
           COMPUTE    LNK-SYU-SKYMONEY  =   LNK-SYU-SKYMONEY    +
                                            LNK-SYU-CHOSEI.
      *
       MAIN-EXT.
           EXIT PROGRAM
           STOP RUN.
      *
      ******************************************************************
      *        ÉÂ±¡¸ºÌÈ·×»»½èÍý                                    *
      ******************************************************************
       GENMEN-KEISAN-SEC          SECTION.
      *
           IF   PTINF-DISCOUNT  NOT =   SPACE  AND  "00"
               INITIALIZE                         SYS-1026-REC
               MOVE    "1026"               TO    SYS-1026-KANRICD
               MOVE    PTINF-DISCOUNT-KBN   TO    SYS-1026-KBNCD
               MOVE    LNK-SYU-SKYSTYMD     TO    ORC-DBYMD
               MOVE    SYS-1026-REC         TO    MCPDATA-REC
               MOVE    "DBSELECT"           TO    MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO    ORC-DBPATH
               CALL    "ORCMCPSUB"    USING        MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
               IF      MCP-RC               =     ZERO
                   MOVE     "SYSKANRI-KEY"  TO    ORC-DBPATH
                   PERFORM   SYSKANRI-READ-SEC
                   IF    MCP-RC             =     ZERO
                       MOVE   SYS-1026-KBNCD  TO  LNK-SYU-DISCOUNT-KBN
                       MOVE   SYS-1026-DISCOUNT-BODY
                                              TO  LNK-SYU-DISCOUNT-BODY
                   END-IF
               END-IF
      *
               MOVE    "DBCLOSE"            TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
      *
               INITIALIZE                         SYS-1027-REC
               MOVE    "1027"               TO    SYS-1027-KANRICD
               MOVE    PTINF-DISCOUNT       TO    SYS-1027-KBNCD
               MOVE    LNK-SYU-SKYSTYMD     TO    ORC-DBYMD
               MOVE    SYS-1027-REC         TO    MCPDATA-REC
               MOVE    "DBSELECT"           TO    MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO    ORC-DBPATH
               CALL    "ORCMCPSUB"    USING       MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
               IF      MCP-RC               =     ZERO
                   MOVE     "SYSKANRI-KEY"  TO    ORC-DBPATH
                   PERFORM   SYSKANRI-READ-SEC
                   IF    MCP-RC             =     ZERO
                       EVALUATE  SYS-1027-TEIRITU
                           WHEN  "1"
                               MOVE    ZERO    TO   WK-RATE
                               COMPUTE  WK-RATE  =  
                                        (100 - SYS-1027-DISCOUNT-RATE)
                                        /  100
                               COMPUTE    LNK-SYU-SKYMONEY  =
                                          LNK-SYU-SKYMONEY  *
                                          WK-RATE
                               COMPUTE    LNK-SYU-SKYMONEY  =
                                          LNK-SYU-SKYMONEY  +  5
                               COMPUTE    LNK-SYU-SKYMONEY  =
                                          LNK-SYU-SKYMONEY  / 10
                               COMPUTE    LNK-SYU-SKYMONEY  =
                                          LNK-SYU-SKYMONEY  * 10
                           WHEN  "2"
                               IF   SYS-1027-DISCOUNT-RATE >= 
                                                     LNK-SYU-SKYMONEY
                                    MOVE    ZERO   TO   LNK-SYU-SKYMONEY
                               ELSE
                                    COMPUTE    LNK-SYU-SKYMONEY  =
                                               LNK-SYU-SKYMONEY  -
                                               SYS-1027-DISCOUNT-RATE
                               END-IF
                       END-EVALUATE
                       MOVE   SYS-1027-KBNCD   TO
                                               LNK-SYU-DISCOUNT-RATEKBN
                       MOVE   SYS-1027-TEIRITU TO
                                               LNK-SYU-DISCOUNT-TEIRITU
                       MOVE  SYS-1027-DISCOUNT-RATE  TO
                                               LNK-SYU-DISCOUNT-RATE
                   END-IF
               END-IF
      *
               MOVE    "DBCLOSE"            TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
           END-IF.
      *
       GENMEN-KEISAN-EXT.
           EXIT.
      ******************************************************************
      *        ÊÝ¸±»²¾ÈÉôÊ¬³ÎÄê½èÍý                                    *
      ******************************************************************
       100-KAKUTEI-SEC          SECTION.
      *
           MOVE    SPACE                TO      FLG-SANSHOU.
           MOVE    SPACE                TO      FLG-SANSHOU3.     
           MOVE    SPACE                TO      WRK-SKJGNSTYMD-S
           MOVE    SPACE                TO      WRK-SKJGNSTYMD-E
      *
           INITIALIZE                           TNKRRK-REC.
           MOVE    LNK-SYU-HOSPID       TO      TNKRRK-HOSPID.
           MOVE    LNK-SYU-PTID         TO      TNKRRK-PTID.
           MOVE    TNKRRK-REC           TO      MCPDATA-REC.
           MOVE    "DBSELECT"           TO      MCP-FUNC.
           MOVE    "TNKRRK-KEY2"        TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC               =       ZERO
               MOVE    "TNKRRK-KEY2"    TO      ORC-DBPATH
               PERFORM  TNKRRK-READ-SEC
               PERFORM  UNTIL
                          (FLG-TNKRRK     =    1)    OR
                         ((TNKRRK-STYMD     <=   LNK-SYU-SKYSTYMD)  AND
                          (LNK-SYU-SKYSTYMD <=   TNKRRK-EDYMD))
                   PERFORM   TNKRRK-READ-SEC
               END-PERFORM
           ELSE
               MOVE    1                TO      FLG-TNKRRK
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "TNKRRK-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
           INITIALIZE                           TSYRRK-REC.
           MOVE    LNK-SYU-HOSPID       TO      TSYRRK-HOSPID.
           MOVE    LNK-SYU-PTID         TO      TSYRRK-PTID.
           MOVE    TSYRRK-REC           TO      MCPDATA-REC.
           MOVE    "DBSELECT"           TO      MCP-FUNC.
           MOVE    "TSYRRK-KEY2"        TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC               =       ZERO
               MOVE    "TSYRRK-KEY2"    TO      ORC-DBPATH
               PERFORM  TSYRRK-READ-SEC
               PERFORM  UNTIL
                       (FLG-TSYRRK      =    1)    OR
                      ((TSYRRK-NINSTYMD   <=   LNK-SYU-SKYSTYMD)  AND
                       (LNK-SYU-SKYSTYMD  <=   TSYRRK-NINEDYMD))
                   PERFORM   TSYRRK-READ-SEC
               END-PERFORM
           ELSE
               MOVE    1                TO      FLG-TSYRRK
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "TSYRRK-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
           EVALUATE   FLG-TSYRRK        ALSO     FLG-TNKRRK
               WHEN    1                ALSO     1
                       MOVE     "1"     TO       FLG-SANSHOU
               WHEN    0                ALSO     1
                       MOVE     "2"     TO       FLG-SANSHOU
               WHEN    0                ALSO     0
               WHEN    1                ALSO     0
                       MOVE     "3"     TO       FLG-SANSHOU
           END-EVALUATE.
      *
      *    ¸øÈñÉéÃ´ÉôÊ¬¸¡º÷ÍÑ¤Î»²¾ÈÉôÊ¬¥»¥Ã¥È¡ÊËÜ¿Í¤Ç¸ÇÄê¡Ë
           MOVE       "1"               TO       FLG-SANSHOU2.
      *
           EVALUATE    FLG-TSYRRK       ALSO     FLG-TNKRRK        
               WHEN    1                ALSO     1                 
                       MOVE    SPACE    TO       FLG-SANSHOU3      
               WHEN    0                ALSO     1                 
                       MOVE     "2"     TO       FLG-SANSHOU3      
      *
                       MOVE     TSYRRK-SKJGNSTYMD
                                        TO       WRK-SKJGNSTYMD-S
                       MOVE     TSYRRK-NINEDYMD
                                        TO       WRK-SKJGNSTYMD-E
      *
               WHEN    0                ALSO     0                 
               WHEN    1                ALSO     0
                       MOVE     "1"     TO       FLG-SANSHOU3      
           END-EVALUATE.                                    
      *
       100-KAKUTEI-EXT.
           EXIT.
      ******************************************************************
      *        ÊÝ¸±ÉéÃ´³Û»»Äê½èÍý                                      *
      ******************************************************************
       200-HKNFTN-SANTEI-SEC          SECTION.
      *
           MOVE    SPACE                 TO    HOKEN-MAX-AREA
                                               HOKEN-FUTAN-AREA
                                               HOKEN-ZAN-AREA.
           INITIALIZE                          HOKEN-MAX-AREA
                                               HOKEN-FUTAN-AREA
                                               HOKEN-ZAN-AREA.
      *
      *    ´µ¼ÔÉéÃ´¶â»»½ÐÁ°¤Î£±£°£°¡óÉéÃ´³Û»»½Ð
           MOVE      ZERO         TO      WK-ZENGAKU.
           PERFORM   VARYING   IDX     FROM    1   BY  1
                     UNTIL     IDX         >   11
               COMPUTE WK-ZENGAKU  =   WK-ZENGAKU  +
                                      (LNK-SYU-HKNTEN (IDX) * 10)
           END-PERFORM.
      *
      *
           INITIALIZE    WK-SYUHKN-TAIHI-AREA.
           IF  LNK-S02-KOUREI-NYUIN-KBN     =   SPACE   
      *        ´µ¼ÔÇ¯Îð·×»»
               INITIALIZE                           PTINF-REC
               MOVE    LNK-SYU-HOSPID       TO      PTINF-HOSPID
               MOVE    LNK-SYU-PTID         TO      PTINF-PTID
               MOVE    PTINF-REC            TO      MCPDATA-REC
               MOVE    "DBSELECT"           TO      MCP-FUNC
               MOVE    "PTINF-KEY"          TO      ORC-DBPATH
               CALL    "ORCMCPSUB"          USING   MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
               IF      MCP-RC               =       ZERO
                   MOVE    "PTINF-KEY"      TO      ORC-DBPATH
                   PERFORM  PTINF-READ-SEC
               ELSE
                   DISPLAY   "PTINF SELECT ERR"
      *
                   INITIALIZE                   PTINF-REC
               END-IF
      *
               MOVE    "DBCLOSE"            TO  MCP-FUNC
               MOVE    "PTINF-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
               INITIALIZE                    ORCSAGECHKAREA
               MOVE    LNK-SYU-HOSPID    TO  AGECHK-HOSPID
               MOVE    LNK-SYU-PTID      TO  AGECHK-PTID
               MOVE    LNK-SYU-SKYSTYMD  TO  AGECHK-SRYYMD
               MOVE    PTINF-BIRTHDAY    TO  AGECHK-BIRTHDAY
               CALL    "ORCSAGECHK"        USING
                                           ORCSAGECHKAREA
               IF      AGECHK-RC       =   ZERO
                   IF  ( AGECHK-NENREI   >=  70 ) OR
                      (( AGECHK-NENREI   >=  65 AND                  
                         COMB-KOH1HKNNUM  = "027"))                  
                       MOVE  "1"     TO  LNK-S02-KOUREI-NYUIN-KBN
                   END-IF
               ELSE
                   DISPLAY  "PTINF AGE-CHK ERR " LNK-SYU-PTID
      *
                   MOVE  SPACE       TO  LNK-S02-KOUREI-NYUIN-KBN
               END-IF
           END-IF.       
           IF   LNK-S02-KOUREI-NYUIN-KBN   =  "1"
               IF  COMB-SYU-HKNKOHSBTKBN   =   "8"
                   MOVE  SPACE       TO  LNK-S02-KOUREI-NYUIN-KBN
               END-IF
               IF  COMB-HKNNUM  =  SPACE  
                   MOVE  SPACE       TO  LNK-S02-KOUREI-NYUIN-KBN
               END-IF
           END-IF.                                               
      *
      *    ÊÝ¸±ÈÖ¹æ¥Æ¡¼¥Ö¥ë¤«¤é¸øÈñ¤ÎÉéÃ´¾å¸Â¶â³Û¤Î¼èÆÀ
           PERFORM         210-HOKEN-KAISU-SEC.
      *
      *    ¿ÇÎÅ·îÆâ¤Î¼ýÇ¼¥Þ¥¹¥¿¤«¤é¸øÈñËè¤Î´µ¼ÔÉéÃ´¶â³Û¤Î
      *    Îß·×¤òÄ´ºº
           PERFORM         220-SYUNOU-SEC.
      *
      *    ÊÝ¸±¡¦¸øÈñ¤ÎÉéÃ´¶â·×»»
           PERFORM         230-FTNKIN-SEC.
      *
       200-HKNFTN-SANTEI-EXT.
           EXIT.
      *
      ******************************************************************
      *        ÊÝ¸±¡¦¸øÈñ¤ÎÀßÄê¾å¸Â¶â³Û¤Î¼èÆÀ¡¡¡¡¡¡¡¡¡¡                *
      ******************************************************************
       210-HOKEN-KAISU-SEC           SECTION.
      *
      *    *¸øÈñ£±¤Î¾å¸Â¶â³Û¼è¹þ¤ß
           IF (COMB-KOH1HKNNUM           NOT =  SPACE)    AND
              (COMB-KOH1-NYUJGNKBN       =     "1")
               INITIALIZE                      HKNNUM-REC
               MOVE   COMB-HOSPID        TO    HKN-HOSPID
               MOVE   COMB-KOH1HKNNUM    TO    HKN-HKNNUM
               IF     COMB-KOH1HKNNUM    =     "027"
                       MOVE     COMB-KOH1PAYKBN
                                         TO    WK-PAYKBN
               ELSE
                       MOVE     "00"     TO    WK-PAYKBN
               END-IF
               MOVE   HKNNUM-REC         TO    MCPDATA-REC
               MOVE   "DBSELECT"         TO    MCP-FUNC
               MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH
               CALL   "ORCMCPSUB"         USING MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC            =     ZERO
                 MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
                 PERFORM  HKNNUM-READ-SEC
                 PERFORM  UNTIL
                   (FLG-HKNNUM     =    1)                       OR
                  ((HKN-TEKSTYMD(1:6)     <=  LNK-SYU-SKYSTYMD(1:6)) AND
                   (LNK-SYU-SKYSTYMD(1:6) <=  HKN-TEKEDYMD(1:6))     AND
                   (WK-PAYKBN            =  HKN-PAYKBN))
                     PERFORM   HKNNUM-READ-SEC
                 END-PERFORM
                 IF     FLG-HKNNUM         =       0
                        PERFORM   2103-KOH1-KAISU-SEC
                 END-IF
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
      *    *¸øÈñ£²¤Î¾å¸Â¶â³Û¼è¹þ¤ß
           IF (COMB-KOH2HKNNUM           NOT = SPACE)    AND
              (COMB-KOH2-NYUJGNKBN       =     "1")
               INITIALIZE                      HKNNUM-REC
               MOVE   COMB-HOSPID        TO    HKN-HOSPID
               MOVE   COMB-KOH2HKNNUM    TO    HKN-HKNNUM
               MOVE     "00"             TO    WK-PAYKBN
               MOVE   HKNNUM-REC         TO    MCPDATA-REC
               MOVE   "DBSELECT"         TO    MCP-FUNC
               MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH
               CALL   "ORCMCPSUB"         USING MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC            =     ZERO
                 MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
                 PERFORM  HKNNUM-READ-SEC
                 PERFORM  UNTIL
                   (FLG-HKNNUM     =    1)                      OR
                  ((HKN-TEKSTYMD(1:6)     <= LNK-SYU-SKYSTYMD(1:6)) AND
                   (LNK-SYU-SKYSTYMD(1:6) <= HKN-TEKEDYMD(1:6))     AND
                   (WK-PAYKBN            = HKN-PAYKBN))
                     PERFORM   HKNNUM-READ-SEC
                 END-PERFORM
                 IF     FLG-HKNNUM         =       0
                        PERFORM   2104-KOH2-KAISU-SEC
                 END-IF
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
      *    *¸øÈñ£³¤Î¾å¸Â¶â³Û¼è¹þ¤ß
           IF (COMB-KOH3HKNNUM           NOT = SPACE)    AND
              (COMB-KOH3-NYUJGNKBN       =     "1")
               INITIALIZE                      HKNNUM-REC
               MOVE   COMB-HOSPID        TO    HKN-HOSPID
               MOVE   COMB-KOH3HKNNUM    TO    HKN-HKNNUM
               MOVE     "00"             TO    WK-PAYKBN
               MOVE   HKNNUM-REC         TO    MCPDATA-REC
               MOVE   "DBSELECT"         TO    MCP-FUNC
               MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH
               CALL   "ORCMCPSUB"         USING MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC            =     ZERO
                 MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
                 PERFORM  HKNNUM-READ-SEC
                 PERFORM  UNTIL
                   (FLG-HKNNUM     =    1)                      OR
                  ((HKN-TEKSTYMD(1:6)     <= LNK-SYU-SKYSTYMD(1:6)) AND
                   (LNK-SYU-SKYSTYMD(1:6) <= HKN-TEKEDYMD(1:6))     AND
                   (WK-PAYKBN            = HKN-PAYKBN))
                     PERFORM   HKNNUM-READ-SEC
                 END-PERFORM
                 IF     FLG-HKNNUM         =       0
                        PERFORM   2105-KOH3-KAISU-SEC
                 END-IF
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
      *    *¸øÈñ£´¤Î¾å¸Â¶â³Û¼è¹þ¤ß
           IF (COMB-KOH4HKNNUM           NOT = SPACE)    AND
              (COMB-KOH4-NYUJGNKBN       =     "1")
               INITIALIZE                      HKNNUM-REC
               MOVE   COMB-HOSPID        TO    HKN-HOSPID
               MOVE   COMB-KOH4HKNNUM    TO    HKN-HKNNUM
               MOVE     "00"             TO    WK-PAYKBN
               MOVE   HKNNUM-REC         TO    MCPDATA-REC
               MOVE   "DBSELECT"         TO    MCP-FUNC
               MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH
               CALL   "ORCMCPSUB"         USING MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               IF      MCP-RC            =     ZERO
                 MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
                 PERFORM  HKNNUM-READ-SEC
                 PERFORM  UNTIL
                   (FLG-HKNNUM     =    1)                       OR
                  ((HKN-TEKSTYMD(1:6)     <= LNK-SYU-SKYSTYMD(1:6)) AND
                   (LNK-SYU-SKYSTYMD(1:6) <= HKN-TEKEDYMD(1:6))     AND
                   (WK-PAYKBN            = HKN-PAYKBN))
                     PERFORM   HKNNUM-READ-SEC
                 END-PERFORM
                 IF     FLG-HKNNUM         =       0
                        PERFORM   2106-KOH4-KAISU-SEC
                 END-IF
               END-IF
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
      *
           IF  LNK-S02-KOUREI-NYUIN-KBN   =   "1"
               IF  COMB-KOH1-HKNKOHSBTKBN   =   "3"
                   EVALUATE   COMB-KOH1PAYKBN
                       WHEN   "01"
                           MOVE  "1"          TO   COMB-KOH1-NYUJGNKBN
                           IF  FLG-SANSHOU3     =   SPACE               
                               MOVE   40200   TO   MAX-KIN-KOHI1-M
                           ELSE
                             IF  FLG-SANSHOU3     =   "1"
                               MOVE   15000   TO   MAX-KIN-KOHI1-M
      *                        MOVE   1       TO   FLG-SKJ
                             ELSE
                               MOVE   24600   TO   MAX-KIN-KOHI1-M
      *                        MOVE   2       TO   FLG-SKJ
                             END-IF
                           END-IF
                       WHEN   "02"
                           MOVE  "1"          TO   COMB-KOH1-NYUJGNKBN
                           MOVE   72300       TO   MAX-KIN-KOHI1-M
                           IF  (COMB-KOH2HKNNUM    =  SPACE)              
                           AND (COMB-KOH3HKNNUM    =  SPACE)
                           AND (COMB-KOH4HKNNUM    =  SPACE)
                             MOVE   WK-ZENGAKU  TO   WK-KOUREI-IRYOHI
                             MOVE   1           TO   FLG-IRYOHI
                           END-IF
                   END-EVALUATE
               ELSE
                   EVALUATE   COMB-HOJOKBN
                       WHEN   "1"
                       WHEN   "9"
                           IF  FLG-SANSHOU3      =   SPACE              
                               MOVE   40200   TO   MAX-KIN-SYU-M
                           ELSE
                             IF  FLG-SANSHOU3     =   "1"
                               MOVE   15000   TO   MAX-KIN-SYU-M
      *                        MOVE   1       TO   FLG-SKJ
                             ELSE
                               MOVE   24600   TO   MAX-KIN-SYU-M
      *                        MOVE   2       TO   FLG-SKJ
                             END-IF
                           END-IF
                       WHEN   "2"
                       WHEN   "8"
                           MOVE   72300       TO   MAX-KIN-SYU-M
                           IF  (COMB-KOH1HKNNUM    =  SPACE)              
                           AND (COMB-KOH2HKNNUM    =  SPACE)
                           AND (COMB-KOH3HKNNUM    =  SPACE)
                           AND (COMB-KOH4HKNNUM    =  SPACE)
                             MOVE   WK-ZENGAKU  TO   WK-KOUREI-IRYOHI
                             MOVE   2           TO   FLG-IRYOHI
                           END-IF
                   END-EVALUATE
               END-IF
           END-IF.
      *
           IF  FLG-SANSHOU3      =   SPACE              
                 CONTINUE
           ELSE
                 IF  FLG-SANSHOU3     =   "1"
                      MOVE   1       TO   FLG-SKJ
                 ELSE
                      MOVE   2       TO   FLG-SKJ
                 END-IF
           END-IF.
      *
       210-HOKEN-KAISU-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñ£±¡Ê¶â³Û¡Ë¼è¹þ¤ß½èÍý                                *
      ******************************************************************
       2103-KOH1-KAISU-SEC           SECTION.
      *
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                        MOVE  HKN-HON-NYUMJGNGAK TO  MAX-KIN-KOHI1-M
               WHEN   "2"
                        MOVE  HKN-TSY-NYUMJGNGAK TO  MAX-KIN-KOHI1-M
               WHEN   "3"
                        MOVE  HKN-TNK-NYUMJGNGAK TO  MAX-KIN-KOHI1-M
           END-EVALUATE.
      *
       2103-KOH1-KAISU-EXT.
           EXIT.
      ******************************************************************
      *        ¸øÈñ£²¡Ê¶â³Û¡Ë¼è¹þ¤ß½èÍý                                *
      ******************************************************************
       2104-KOH2-KAISU-SEC           SECTION.
      *
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                        MOVE  HKN-HON-NYUMJGNGAK TO  MAX-KIN-KOHI2-M
               WHEN   "2"
                        MOVE  HKN-TSY-NYUMJGNGAK TO  MAX-KIN-KOHI2-M
               WHEN   "3"
                        MOVE  HKN-TNK-NYUMJGNGAK TO  MAX-KIN-KOHI2-M
           END-EVALUATE.
      *
       2104-KOH2-KAISU-EXT.
           EXIT.
      ******************************************************************
      *        ¸øÈñ£³¡Ê¶â³Û¡Ë¼è¹þ¤ß½èÍý                                *
      ******************************************************************
       2105-KOH3-KAISU-SEC           SECTION.
      *
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                        MOVE  HKN-HON-NYUMJGNGAK TO  MAX-KIN-KOHI3-M
               WHEN   "2"
                        MOVE  HKN-TSY-NYUMJGNGAK TO  MAX-KIN-KOHI3-M
               WHEN   "3"
                        MOVE  HKN-TNK-NYUMJGNGAK TO  MAX-KIN-KOHI3-M
           END-EVALUATE.
      *
       2105-KOH3-KAISU-EXT.
           EXIT.
      ******************************************************************
      *        ¸øÈñ£´¡Ê¶â³Û¡Ë¼è¹þ¤ß½èÍý                                *
      ******************************************************************
       2106-KOH4-KAISU-SEC           SECTION.
      *
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                        MOVE  HKN-HON-NYUMJGNGAK TO  MAX-KIN-KOHI4-M
               WHEN   "2"
                        MOVE  HKN-TSY-NYUMJGNGAK TO  MAX-KIN-KOHI4-M
               WHEN   "3"
                        MOVE  HKN-TNK-NYUMJGNGAK TO  MAX-KIN-KOHI4-M
           END-EVALUATE.
      *
       2106-KOH4-KAISU-EXT.
           EXIT.
      *
      ******************************************************************
      *    ¿ÇÎÅ·îÆâ¤Î¼ýÇ¼¥Þ¥¹¥¿¤«¤é¸øÈñËè¤Î´µ¼ÔÉéÃ´¶â³Û¤Î
      *    Îß·×¤òÄ´ºº
      ******************************************************************
       220-SYUNOU-SEC           SECTION.
      *
           IF  (COMB-KOH1-NYUJGNKBN       =       "1")      OR
               (COMB-KOH2-NYUJGNKBN       =       "1")      OR
               (COMB-KOH3-NYUJGNKBN       =       "1")      OR
               (COMB-KOH4-NYUJGNKBN       =       "1")      OR
               (LNK-S02-KOUREI-NYUIN-KBN  =       "1")
      *
               IF   LNK-S02-TEIKI-KBN     =   "X"
                 CONTINUE
               ELSE
                 INITIALIZE                         SYU-SYUNOU-REC
                 MOVE    LNK-SYU-HOSPID     TO      SYU-HOSPID
                 MOVE    LNK-SYU-NYUGAIKBN  TO      SYU-NYUGAIKBN
                 MOVE    LNK-SYU-PTID       TO      SYU-PTID
                 MOVE    SYU-SYUNOU-REC     TO      MCPDATA-REC
                 MOVE    "DBSELECT"         TO      MCP-FUNC
                 MOVE    "SYUNOU-KEY2"      TO      ORC-DBPATH
                 CALL    "ORCMCPSUB"         USING   MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                 IF      MCP-RC             =       ZERO
                   MOVE    "SYUNOU-KEY2"  TO      ORC-DBPATH
                   PERFORM  SYUNOU-READ-SEC
                   PERFORM  UNTIL  (FLG-SYUNOU   =    "1")
                     IF (LNK-SYU-SKYSTYMD(1:6) = SYU-SKYSTYMD(1:6)) AND
                        (SYU-DENPJTIKBN    NOT =  "3")
                             PERFORM        2201-SYUNOU-COUNT-SEC
                     END-IF
                     MOVE           "SYUNOU-KEY2"    TO   ORC-DBPATH
                     PERFORM        SYUNOU-READ-SEC
                   END-PERFORM
                 ELSE
                   MOVE    12              TO        LNK-S02-RC
                 END-IF
      *
                 MOVE    "DBCLOSE"               TO  MCP-FUNC
                 MOVE    "SYUNOU-KEY2"           TO  ORC-DBPATH
                 CALL    "ORCMCPSUB"              USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
               END-IF
      *
               PERFORM    VARYING   IDZ    FROM   1   BY   1
                           UNTIL  (IDZ    >    10)
                             OR   (LNK-WRK-SYU-SKYSTYMD(IDZ) =  SPACE)
      *
                  IF  LNK-SYU-SKYSTYMD(1:6) = 
                                   LNK-WRK-SYU-SKYSTYMD(IDZ)(1:6) 
                      MOVE    LNK-WRK-SYUNOU-REC(IDZ)  
                                             TO  SYU-SYUNOU-REC
                      PERFORM        2201-SYUNOU-COUNT-SEC
                  END-IF
      *
               END-PERFORM
      *
           END-IF.
      *
           IF     FLG-IRYOHI     =      1
             IF  WK-KOUREI-IRYOHI  >  361500
                COMPUTE WK-KOUREI-IRYOHI2 = 
                      (( WK-KOUREI-IRYOHI  -  361500 ) * 0.01 ) + 0.5
                COMPUTE  MAX-KIN-KOHI1-M  =   MAX-KIN-KOHI1-M 
                                          +   WK-KOUREI-IRYOHI2
                MOVE    1    TO    FLG-KOUGAKUCYO
             END-IF
           END-IF.
           IF     FLG-IRYOHI     =      2
             IF  WK-KOUREI-IRYOHI  >  361500
                COMPUTE WK-KOUREI-IRYOHI2 = 
                      (( WK-KOUREI-IRYOHI  -  361500 ) * 0.01 ) + 0.5
                COMPUTE  MAX-KIN-SYU-M    =   MAX-KIN-SYU-M 
                                          +   WK-KOUREI-IRYOHI2
                MOVE    1    TO    FLG-KOUGAKUCYO
             END-IF
           END-IF.
      *
       220-SYUNOU-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¿ÇÎÅ·î¤Î¼ýÇ¼¥Þ¥¹¥¿¤«¤é¸øÈñ¤Î¶â³Û¥«¥¦¥ó¥È
      ******************************************************************
       2201-SYUNOU-COUNT-SEC          SECTION.
      *
           MOVE     ZERO     TO     FLG-KOUREI.                         
      *
           IF  LNK-S02-KOUREI-NYUIN-KBN   =   "1"
      **       IF  LNK-SYU-SYUHKNNUM    =  SYU-SYUHKNNUM
               IF ( SYU-SYUHKNNUM       =  "971" OR "973" OR SPACE )
               OR ( SYU-SYUHKNNUM(1:2)  =  "98"                    )
      *
                 CONTINUE
      *
               ELSE
      *
                 IF COMB-KOH1HKNNUM      =    "027"                     
      *               COMPUTE  WK-SYU-SYUCOMPFTN  =                     
      *                                 SYU-KOH1COMPFTN    +   5        
      *               COMPUTE  WK-SYU-SYUCOMPFTN  =                     
      *                                 WK-SYU-SYUCOMPFTN  /  10        
      *               COMPUTE  WK-SYU-SYUCOMPFTN  =                     
      *                                 WK-SYU-SYUCOMPFTN  *  10        
                      IF  (SYU-KOH2HKNNUM     NOT = SPACE)              
                      OR  (SYU-KOH3HKNNUM     NOT = SPACE)
                      OR  (SYU-KOH4HKNNUM     NOT = SPACE)
                          MOVE     SYU-KOH-FTN  TO  WK-SYU-SYUCOMPFTN   
                          IF  FTN-KOH-XXX  <  40200                       
                            ADD  WK-SYU-SYUCOMPFTN  TO  FTN-KOH-XXX       
                            IF   FTN-KOH-XXX     >   40200                
                               MOVE   40200   TO   FTN-KOH-XXX            
                            END-IF                                        
                          END-IF                                          
                      ELSE
                          IF  (SYU-KOH2HKNNUM     =  SPACE)              
                          AND (SYU-KOH3HKNNUM     =  SPACE)
                          AND (SYU-KOH4HKNNUM     =  SPACE)
                             MOVE   SYU-KOH1COMPFTN
                                            TO   WK-SYU-SYUCOMPFTN
      *
                             COMPUTE   WK-KOUREI-IRYOHI  =   
                                       WK-KOUREI-IRYOHI  +  
                                      (SYU-HKNTEN (12) * 10)
                          END-IF
                      END-IF
                      ADD   WK-SYU-SYUCOMPFTN     TO   FTN-KOHI1-M      
                      MOVE  1                     TO   FLG-KOUREI       
                 ELSE                                                   
      *               COMPUTE  WK-SYU-SYUCOMPFTN  =                     
      *                                 SYU-SYUCOMPFTN     +   5        
      *               COMPUTE  WK-SYU-SYUCOMPFTN  =                     
      *                                 WK-SYU-SYUCOMPFTN  /  10        
      *               COMPUTE  WK-SYU-SYUCOMPFTN  =                     
      *                                 WK-SYU-SYUCOMPFTN  *  10        
                      IF  (SYU-KOH1HKNNUM     NOT = SPACE)              
                      OR  (SYU-KOH2HKNNUM     NOT = SPACE)
                      OR  (SYU-KOH3HKNNUM     NOT = SPACE)
                      OR  (SYU-KOH4HKNNUM     NOT = SPACE)
                          MOVE     SYU-KOH-FTN  TO  WK-SYU-SYUCOMPFTN 
                          IF  FTN-KOH-XXX    <  40200                     
                            ADD  WK-SYU-SYUCOMPFTN  TO  FTN-KOH-XXX       
                            IF   FTN-KOH-XXX     >   40200                
                               MOVE   40200   TO   FTN-KOH-XXX            
                            END-IF
                          END-IF                                         
                      ELSE
                          IF  (SYU-KOH1HKNNUM     =  SPACE)              
                          AND (SYU-KOH2HKNNUM     =  SPACE)
                          AND (SYU-KOH3HKNNUM     =  SPACE)
                          AND (SYU-KOH4HKNNUM     =  SPACE)
                             MOVE   SYU-SYUCOMPFTN
                                            TO   WK-SYU-SYUCOMPFTN
      *
                             COMPUTE   WK-KOUREI-IRYOHI  =   
                                       WK-KOUREI-IRYOHI  +  
                                      (SYU-HKNTEN (12) * 10)
                          END-IF
                      END-IF
                      ADD   WK-SYU-SYUCOMPFTN     TO   FTN-SYU-M        
                 END-IF                                                 
      *
               END-IF
           END-IF.
      *
      *    ¸øÈñ£±¥«¥¦¥ó¥È
           IF  (COMB-KOH1HKNNUM               NOT =   SPACE)  AND
               (COMB-KOH1-NYUJGNKBN           =       "1"  )  AND
               (FLG-KOUREI                    =       ZERO )            
               IF        (LNK-SYU-KOH1HKNNUM  =  SYU-KOH1HKNNUM)   OR
                         (LNK-SYU-KOH1HKNNUM  =  SYU-KOH2HKNNUM)   OR
                         (LNK-SYU-KOH1HKNNUM  =  SYU-KOH3HKNNUM)   OR
                         (LNK-SYU-KOH1HKNNUM  =  SYU-KOH4HKNNUM)
                   EVALUATE  TRUE
                       WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH1HKNNUM)
                             ADD   SYU-KOH1HKNFTNMONEY
                                                TO  FTN-KOHI1-M
                             IF    LNK-SYU-KOH1HKNNUM  =  "051"
                                ADD   SYU-KOH1SKJ-FTN
                                                TO  FTN-KOHI1-M
                             END-IF
                       WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH2HKNNUM)
                             ADD   SYU-KOH2HKNFTNMONEY
                                                TO  FTN-KOHI1-M
                             IF    LNK-SYU-KOH1HKNNUM  =  "051"
                                ADD   SYU-KOH2SKJ-FTN
                                                TO  FTN-KOHI1-M
                             END-IF
                       WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH3HKNNUM)
                             ADD   SYU-KOH3HKNFTNMONEY
                                                TO  FTN-KOHI1-M
                             IF    LNK-SYU-KOH1HKNNUM  =  "051"
                                ADD   SYU-KOH3SKJ-FTN
                                                TO  FTN-KOHI1-M
                             END-IF
                       WHEN  (LNK-SYU-KOH1HKNNUM = SYU-KOH4HKNNUM)
                             ADD   SYU-KOH4HKNFTNMONEY
                                                TO  FTN-KOHI1-M
                             IF    LNK-SYU-KOH1HKNNUM  =  "051"
                                ADD   SYU-KOH4SKJ-FTN
                                                TO  FTN-KOHI1-M
                             END-IF
                   END-EVALUATE
               END-IF
           END-IF.
      *    ¸øÈñ£²¥«¥¦¥ó¥È
           IF  (COMB-KOH2HKNNUM               NOT = SPACE)   AND
               (COMB-KOH2-NYUJGNKBN           =     "1")     
               IF        (LNK-SYU-KOH2HKNNUM  =  SYU-KOH1HKNNUM)   OR
                         (LNK-SYU-KOH2HKNNUM  =  SYU-KOH2HKNNUM)   OR
                         (LNK-SYU-KOH2HKNNUM  =  SYU-KOH3HKNNUM)   OR
                         (LNK-SYU-KOH2HKNNUM  =  SYU-KOH4HKNNUM)
                   EVALUATE  TRUE
                       WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH1HKNNUM)
                             ADD   SYU-KOH1HKNFTNMONEY
                                                TO  FTN-KOHI2-M
                             IF    LNK-SYU-KOH2HKNNUM  =  "051"
                                ADD   SYU-KOH1SKJ-FTN
                                                TO  FTN-KOHI2-M
                             END-IF
                       WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH2HKNNUM)
                             ADD   SYU-KOH2HKNFTNMONEY
                                                TO  FTN-KOHI2-M
                             IF    LNK-SYU-KOH2HKNNUM  =  "051"
                                ADD   SYU-KOH2SKJ-FTN
                                                TO  FTN-KOHI2-M
                             END-IF
                       WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH3HKNNUM)
                             ADD   SYU-KOH3HKNFTNMONEY
                                                TO  FTN-KOHI2-M
                             IF    LNK-SYU-KOH2HKNNUM  =  "051"
                                ADD   SYU-KOH3SKJ-FTN
                                                TO  FTN-KOHI2-M
                             END-IF
                       WHEN  (LNK-SYU-KOH2HKNNUM = SYU-KOH4HKNNUM)
                             ADD   SYU-KOH4HKNFTNMONEY
                                                TO  FTN-KOHI2-M
                             IF    LNK-SYU-KOH2HKNNUM  =  "051"
                                ADD   SYU-KOH4SKJ-FTN
                                                TO  FTN-KOHI2-M
                             END-IF
                   END-EVALUATE
               END-IF
           END-IF.
      *    ¸øÈñ£³¥«¥¦¥ó¥È
           IF  (COMB-KOH3HKNNUM               NOT = SPACE)   AND
               (COMB-KOH3-NYUJGNKBN           =     "1")     
               IF        (LNK-SYU-KOH3HKNNUM  =  SYU-KOH1HKNNUM)   OR
                         (LNK-SYU-KOH3HKNNUM  =  SYU-KOH2HKNNUM)   OR
                         (LNK-SYU-KOH3HKNNUM  =  SYU-KOH3HKNNUM)   OR
                         (LNK-SYU-KOH3HKNNUM  =  SYU-KOH4HKNNUM)
                   EVALUATE  TRUE
                       WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH1HKNNUM)
                             ADD   SYU-KOH1HKNFTNMONEY
                                                TO  FTN-KOHI3-M
                             IF    LNK-SYU-KOH3HKNNUM  =  "051"
                                ADD   SYU-KOH1SKJ-FTN
                                                TO  FTN-KOHI3-M
                             END-IF
                       WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH2HKNNUM)
                             ADD   SYU-KOH2HKNFTNMONEY
                                                TO  FTN-KOHI3-M
                             IF    LNK-SYU-KOH3HKNNUM  =  "051"
                                ADD   SYU-KOH2SKJ-FTN
                                                TO  FTN-KOHI3-M
                             END-IF
                       WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH3HKNNUM)
                             ADD   SYU-KOH3HKNFTNMONEY
                                                TO  FTN-KOHI3-M
                             IF    LNK-SYU-KOH3HKNNUM  =  "051"
                                ADD   SYU-KOH3SKJ-FTN
                                                TO  FTN-KOHI3-M
                             END-IF
                       WHEN  (LNK-SYU-KOH3HKNNUM = SYU-KOH4HKNNUM)
                             ADD   SYU-KOH4HKNFTNMONEY
                                                TO  FTN-KOHI3-M
                             IF    LNK-SYU-KOH3HKNNUM  =  "051"
                                ADD   SYU-KOH4SKJ-FTN
                                                TO  FTN-KOHI3-M
                             END-IF
                   END-EVALUATE
               END-IF
           END-IF.
      *    ¸øÈñ£´¥«¥¦¥ó¥È
           IF  (COMB-KOH4HKNNUM               NOT = SPACE)   AND
               (COMB-KOH4-NYUJGNKBN           =     "1")     
               IF        (LNK-SYU-KOH4HKNNUM  =  SYU-KOH1HKNNUM)   OR
                         (LNK-SYU-KOH4HKNNUM  =  SYU-KOH2HKNNUM)   OR
                         (LNK-SYU-KOH4HKNNUM  =  SYU-KOH3HKNNUM)   OR
                         (LNK-SYU-KOH4HKNNUM  =  SYU-KOH4HKNNUM)
                   EVALUATE  TRUE
                       WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH1HKNNUM)
                             ADD   SYU-KOH1HKNFTNMONEY
                                                TO  FTN-KOHI4-M
                             IF    LNK-SYU-KOH4HKNNUM  =  "051"
                                ADD   SYU-KOH1SKJ-FTN
                                                TO  FTN-KOHI4-M
                             END-IF
                       WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH2HKNNUM)
                             ADD   SYU-KOH2HKNFTNMONEY
                                                TO  FTN-KOHI4-M
                             IF    LNK-SYU-KOH4HKNNUM  =  "051"
                                ADD   SYU-KOH2SKJ-FTN
                                                TO  FTN-KOHI4-M
                             END-IF
                       WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH3HKNNUM)
                             ADD   SYU-KOH3HKNFTNMONEY
                                                TO  FTN-KOHI4-M
                             IF    LNK-SYU-KOH4HKNNUM  =  "051"
                                ADD   SYU-KOH3SKJ-FTN
                                                TO  FTN-KOHI4-M
                             END-IF
                       WHEN  (LNK-SYU-KOH4HKNNUM = SYU-KOH4HKNNUM)
                             ADD   SYU-KOH4HKNFTNMONEY
                                                TO  FTN-KOHI4-M
                             IF    LNK-SYU-KOH4HKNNUM  =  "051"
                                ADD   SYU-KOH4SKJ-FTN
                                                TO  FTN-KOHI4-M
                             END-IF
                   END-EVALUATE
               END-IF
           END-IF.
      *
       2201-SYUNOU-COUNT-EXT.
           EXIT.
      *
      ******************************************************************
      *    ÊÝ¸±¡¦¸øÈñ¤ÎÉéÃ´¶â·×»»
      ******************************************************************
       230-FTNKIN-SEC           SECTION.
      *
      *
      *    »»Äê²ÄÇ½¥Õ¥é¥°¤Î½é´ü²½
           MOVE     SPACE                  TO     FLG-SANTEI1
                                                  FLG-SANTEI2
                                                  FLG-SANTEI3
                                                  FLG-SANTEI4.
      *
      *    ²áµî¤Î´µ¼ÔÊÝ¸±ÉéÃ´Îß·×³Û¤È¾å¸Â¶â³Û¤ÎÈæ³Ó
      *
           IF   LNK-S02-KOUREI-NYUIN-KBN   =   "1"
               IF  MAX-KIN-SYU-M           NOT =  ZERO
                   IF  FTN-SYU-M           >=     MAX-KIN-SYU-M
                       MOVE  "1"           TO     FLG-SANTEI-SYU
                   END-IF
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI1-M        NOT =  ZERO
               IF   FTN-KOHI1-M            >=     MAX-KIN-KOHI1-M
                    MOVE     "1"           TO     FLG-SANTEI1
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI2-M        NOT =  ZERO
               IF   FTN-KOHI2-M            >=     MAX-KIN-KOHI2-M
                    MOVE     "1"           TO     FLG-SANTEI2
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI3-M        NOT =  ZERO
               IF   FTN-KOHI3-M            >=     MAX-KIN-KOHI3-M
                    MOVE     "1"           TO     FLG-SANTEI3
               END-IF
           END-IF.
           IF       MAX-KIN-KOHI4-M        NOT =  ZERO
               IF   FTN-KOHI4-M            >=     MAX-KIN-KOHI4-M
                    MOVE     "1"           TO     FLG-SANTEI4
               END-IF
           END-IF.
      *
      *    ÊÝ¸±¡Ê¸øÈñ¡Ë¥Æ¡¼¥Ö¥ë¤Î´µ¼ÔÉéÃ´¾å¸Â³Û¤ÈÅö·î¤Î´µ¼ÔÉéÃ´Îß·×³Û
      *    ¤«¤é»»Äê²ÄÇ½»Ä³Û¤ò»»½Ð¤¹¤ë
      *
           IF   LNK-S02-KOUREI-NYUIN-KBN   =   "1"
               IF  FLG-SANTEI-SYU            =   "1"                  
                       MOVE  ZERO        TO      ZAN-SYU-M            
               ELSE                                                   
                   IF  FTN-SYU-M         >=    MAX-KIN-SYU-M          
                       MOVE  ZERO        TO      ZAN-SYU-M
                   ELSE
                       COMPUTE  ZAN-SYU-M  =   MAX-KIN-SYU-M  -
                                               FTN-SYU-M
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI1               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI1-M
           ELSE
               IF (COMB-KOH1HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH1-NYUJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI1-M       NOT = ZERO
                       IF   FTN-KOHI1-M           >=  MAX-KIN-KOHI1-M
                            MOVE     ZERO         TO  ZAN-KOHI1-M
                       ELSE
                            COMPUTE  ZAN-KOHI1-M  =   MAX-KIN-KOHI1-M -
                                                      FTN-KOHI1-M
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI2               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI2-M
           ELSE
               IF (COMB-KOH2HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH2-NYUJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI2-M       NOT = ZERO
                       IF   FTN-KOHI2-M           >=  MAX-KIN-KOHI2-M
                            MOVE     ZERO         TO  ZAN-KOHI2-M
                       ELSE
                            COMPUTE  ZAN-KOHI2-M  =   MAX-KIN-KOHI2-M -
                                                      FTN-KOHI2-M
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI3               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI3-M
           ELSE
               IF (COMB-KOH3HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH3-NYUJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI3-M       NOT = ZERO
                       IF   FTN-KOHI3-M           >=  MAX-KIN-KOHI3-M
                            MOVE     ZERO         TO  ZAN-KOHI3-M
                       ELSE
                            COMPUTE  ZAN-KOHI3-M  =   MAX-KIN-KOHI3-M -
                                                      FTN-KOHI3-M
                       END-IF
                   END-IF
               END-IF
           END-IF.
           IF  FLG-SANTEI4               =     "1"
               MOVE     ZERO             TO    ZAN-KOHI4-M
           ELSE
               IF (COMB-KOH4HKNNUM           NOT = SPACE)    AND
                  (COMB-KOH4-NYUJGNKBN       =     "1")
                   IF       MAX-KIN-KOHI4-M       NOT = ZERO
                       IF   FTN-KOHI4-M           >=  MAX-KIN-KOHI4-M
                            MOVE     ZERO         TO  ZAN-KOHI4-M
                       ELSE
                            COMPUTE  ZAN-KOHI4-M  =   MAX-KIN-KOHI4-M -
                                                      FTN-KOHI4-M
                       END-IF
                   END-IF
               END-IF
           END-IF.
      *
      *    ·î¤Î´µ¼ÔÉéÃ´²ÄÇ½»Ä³Û¤ò¥»¥Ã¥È¤¹¤ë
           IF (COMB-KOH1HKNNUM              NOT = SPACE)    AND
              (COMB-KOH1-NYUJGNKBN          =     "1")
                   MOVE   ZAN-KOHI1-M     TO   ZAN-KOHI1
           END-IF.
      *
           IF (COMB-KOH2HKNNUM              NOT = SPACE)    AND
              (COMB-KOH2-NYUJGNKBN          =     "1")
                   MOVE   ZAN-KOHI2-M     TO   ZAN-KOHI2
           END-IF.
      *
           IF (COMB-KOH3HKNNUM              NOT = SPACE)    AND
              (COMB-KOH3-NYUJGNKBN          =     "1")
                   MOVE   ZAN-KOHI3-M     TO   ZAN-KOHI3
           END-IF.
      *
           IF (COMB-KOH4HKNNUM              NOT = SPACE)    AND
              (COMB-KOH4-NYUJGNKBN          =     "1")
                   MOVE   ZAN-KOHI4-M     TO   ZAN-KOHI4
           END-IF.
      *
      *    ¿©»öÎÅÍÜÈñÅù¤Î·×»»
           PERFORM       2300-SHOKUJI-KEISAN-SEC.
      *
      *    ÊÝ¸±¡¦¸øÈñËè¤Î´µ¼ÔÉéÃ´¶â³Û¤Î·×»»
           IF    ((COMB-KOH1-HKNKOHSBTKBN    =   "3")    AND
                  (COMB-KOH1HKNNUM           =   "027")) OR 
                 ((COMB-KOH2-HKNKOHSBTKBN    =   "3")    AND
                  (COMB-KOH2HKNNUM           =   "027")) OR 
                 ((COMB-KOH3-HKNKOHSBTKBN    =   "3")    AND
                  (COMB-KOH3HKNNUM           =   "027")) OR 
                 ((COMB-KOH4-HKNKOHSBTKBN    =   "3")    AND
                  (COMB-KOH4HKNNUM           =   "027")) 
                  CONTINUE
           ELSE
               IF    COMB-HKNNUM             NOT =       SPACE
                  PERFORM    2301-SYUHOKEN-KEISAN-SEC
               END-IF
           END-IF.
      *
           MOVE     ZERO     TO     WK-TOKUTEI-COMPFTN3.
      *
           PERFORM    VARYING   KOH-IDX    FROM   1   BY   1
                      UNTIL    (KOH-IDX    >      4)
               IF   COMB-KOHHKNNUM(KOH-IDX)  NOT =  SPACE
                    PERFORM    2302-KOH-HKNREAD-SEC
                    IF   COMB-KOH-NYUJGNKBN(KOH-IDX)  =  "1"
                         PERFORM   2303-KOH-KEISAN-SEC
                    ELSE
                         PERFORM   2304-KOH-KEISAN-SEC
                    END-IF
               END-IF 
           END-PERFORM.
      *
      *     ¸øÈñÃ±°Ì¤Ç·×»»¤·¤¿´µ¼ÔÉéÃ´¶â³Û¤«¤éºÇ¾®¤ÎÃÍ¤òÁªÂò¥»¥Ã¥È
            PERFORM   2314-FTNKIN-HIKAKU-SEC.
      *
       230-FTNKIN-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¥·¥¹´É¡¦Æþ±¡²ñ·×¤«¤é¿©»öÎÅÍÜÈñÅù¤Î·×»»¤ò¹Ô¤¦            *
      ******************************************************************
       2300-SHOKUJI-KEISAN-SEC         SECTION.
      *
           INITIALIZE    WK-SHOKUJI-TAIHI-AREA 
                         WK-SHOKUDOKASAN-TABLE 
                         WK-ROSAITOKU-TABLE.   
      *
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¡Ê£µ£°£°£°¡Ë¤«¤é¿©»ö¾ðÊó¼èÆÀ
           INITIALIZE                         SYS-5000-REC.
           MOVE    "5000"               TO    SYS-5000-KANRICD.
           MOVE    "*"                  TO    SYS-5000-KBNCD.
           MOVE    LNK-SYU-SKYSTYMD     TO    ORC-DBYMD.
           MOVE    SYS-5000-REC         TO    MCPDATA-REC.
           MOVE    "DBSELECT"           TO    MCP-FUNC.
           MOVE    "SYSKANRI-KEY"       TO    ORC-DBPATH.
           CALL    "ORCMCPSUB"    USING       MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC.
           IF      MCP-RC               =     ZERO
                   MOVE     "SYSKANRI-KEY"  TO    ORC-DBPATH
                   PERFORM   SYSKANRI-READ-SEC
                   IF    MCP-RC             =     ZERO
                     IF  SYS-5000-SHOKUJIRYOYOCD   =  "197000110"
                            MOVE     1       TO   WK-SHOKUJIRYOYO
                            IF  SYS-5000-SHOKUKBN(1) =  "1"
                               MOVE  ZERO    TO   WK-TOKUKANRIKASAN
                            ELSE
                               MOVE  1       TO   WK-TOKUKANRIKASAN
                            END-IF
                     ELSE
                            MOVE     2       TO   WK-SHOKUJIRYOYO
                     END-IF
                   END-IF 
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "SYSKANRI-KEY"       TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
      *
      *    MOVE     ZERO                TO  WK-NISSU1
      *                                     WK-NISSU2.
      *
      *    INITIALIZE                   STS-AREA-DAY.
      *    INITIALIZE                   LNK-DAY5-AREA.
      *    MOVE    "51"                 TO  LNK-DAY5-IRAI.
      *    MOVE    LNK-S02-SKYSTYMD     TO  LNK-DAY5-START.
      *    MOVE    LNK-SYU-SKYSTYMD     TO  LNK-DAY5-END.
      *    CALL    "ORCSDAY"            USING   STS-AREA-DAY
      *                                         LNK-DAY5-AREA.
      *    IF      ( STS-DAY-RC1    =   ZERO )
      *        MOVE    LNK-DAY5-NISSU1  TO  WK-NISSU1
      *        MOVE    LNK-DAY5-NISSU2  TO  WK-NISSU2
      *    END-IF.
      *
      *
           INITIALIZE                            NYUINACCT-REC.
           MOVE    LNK-SYU-HOSPID        TO      NACCT-HOSPID.
           MOVE    LNK-SYU-NYUGAIKBN     TO      NACCT-NYUGAIKBN.
           MOVE    LNK-SYU-PTID          TO      NACCT-PTID.
      ***  MOVE    "00"                  TO      NACCT-SRYKA.
           MOVE    LNK-SYU-SKYSTYMD(1:6) TO      NACCT-SRYYM.
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC.
           MOVE    "DBSELECT"            TO      MCP-FUNC.
           MOVE    "NYUINACCT-KEY7"      TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC             =       ZERO
      *
               MOVE    "NYUINACCT-KEY7"  TO      ORC-DBPATH
               PERFORM  NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-SRYCDTOTAL    =    197000570   
                             PERFORM        23001-SHOKUDOKASAN-TAIHI-SEC
                 END-IF
      * 
                 MOVE          "NYUINACCT-KEY7"  TO   ORC-DBPATH
                 PERFORM        NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF.
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC.
           MOVE    "NYUINACCT-KEY7"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC.
      *
      *
           INITIALIZE                            SRYACCT-REC.
           MOVE    LNK-SYU-HOSPID        TO      ACCT-HOSPID.
           MOVE    LNK-SYU-NYUGAIKBN     TO      ACCT-NYUGAIKBN.
           MOVE    LNK-SYU-PTID          TO      ACCT-PTID.
           MOVE    LNK-SYU-SKYSTYMD(1:6) TO      ACCT-SRYYM.
           MOVE    SRYACCT-REC           TO      MCPDATA-REC.
           MOVE    "DBSELECT"            TO      MCP-FUNC.
           MOVE    "SRYACCT-KEY7"        TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC             =       ZERO
      *
               MOVE    "SRYACCT-KEY7"    TO      ORC-DBPATH
               PERFORM  SRYACCT-READ-SEC
               PERFORM  UNTIL  (FLG-SRYACCT    =    "1")
      *
                 IF     ACCT-SRYCDTOTAL    =    197001210  OR
                                                197000470
                             PERFORM        23001-ROSAITOKU-TAIHI-SEC
                 END-IF
      *
                 MOVE     "SRYACCT-KEY7"   TO   ORC-DBPATH
                 PERFORM   SRYACCT-READ-SEC
               END-PERFORM
      *
           END-IF.
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC.
           MOVE    "SRYACCT-KEY7"          TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC.
      *
      *
           INITIALIZE                            NYUINACCT-REC.
           MOVE    LNK-SYU-HOSPID        TO      NACCT-HOSPID.
           MOVE    LNK-SYU-NYUGAIKBN     TO      NACCT-NYUGAIKBN.
           MOVE    LNK-SYU-PTID          TO      NACCT-PTID.
      ***  MOVE    "00"                  TO      NACCT-SRYKA.
           MOVE    LNK-SYU-SKYSTYMD(1:6) TO      NACCT-SRYYM.
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC.
           MOVE    "DBSELECT"            TO      MCP-FUNC.
           MOVE    "NYUINACCT-KEY7"      TO      ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
           IF      MCP-RC             =       ZERO
      *
               MOVE    "NYUINACCT-KEY7"  TO      ORC-DBPATH
               PERFORM  NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-SRYCDTOTAL    =    099999913   
                             PERFORM        23001-SHOKUJI-COUNT-SEC
                 END-IF
      * 
                 MOVE          "NYUINACCT-KEY7"  TO   ORC-DBPATH
                 PERFORM        NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF.
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC.
           MOVE    "NYUINACCT-KEY7"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC.
      *
           IF   LNK-SYU-SHOKUJI1-NISSU      =  ZERO
           AND  LNK-SYU-SHOKUJI2-NISSU  NOT =  ZERO
      *
             MOVE  LNK-SYU-SHOKUJI2-NISSU  TO  LNK-SYU-SHOKUJI1-NISSU
             MOVE  LNK-SYU-SHOKUJI2        TO  LNK-SYU-SHOKUJI1
      *
             MOVE  ZERO                    TO  LNK-SYU-SHOKUJI2-NISSU
             MOVE  ZERO                    TO  LNK-SYU-SHOKUJI2
      *
           END-IF.
      *
       2300-SHOKUJI-KEISAN-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¿©Æ²²Ã»»ÂàÈò                                            *
      ******************************************************************
       23001-SHOKUDOKASAN-TAIHI-SEC         SECTION.
      *
           PERFORM    VARYING   IDY   FROM   1   BY   1
                                    UNTIL    IDY    >    31
      *
             IF       NACCT-DAY(IDY)   NOT =  ZERO 
                    MOVE   NACCT-DAY(IDY)  TO   WK-SHOKUDOKASAN(IDY) 
             END-IF
      *
           END-PERFORM.
      *
       23001-SHOKUDOKASAN-TAIHI-EXT.
           EXIT.
      *
      ******************************************************************
      *        Ï«ºÒÆþ±¡Ãæ¤ÎÆÃÊÌ¿©²Ã»»ÂàÈò                              *
      ******************************************************************
       23001-ROSAITOKU-TAIHI-SEC         SECTION.
      *
           PERFORM    VARYING   IDY   FROM   1   BY   1
                                    UNTIL    IDY    >    31
      *
             IF   ACCT-SRYKBN   =   "95"  
                IF       ACCT-DAY(1 IDY)   NOT =  ZERO 
                    MOVE   ACCT-DAY(1 IDY)  TO   WK-ROSAITOKU95(IDY) 
                END-IF
             END-IF
      *
             IF   ACCT-SRYKBN   =   "96"  
                IF       ACCT-DAY(1 IDY)   NOT =  ZERO 
                    MOVE   ACCT-DAY(1 IDY)  TO   WK-ROSAITOKU96(IDY) 
                END-IF
             END-IF
      *
             IF   ACCT-SRYKBN   =   "97"
                IF       ACCT-DAY(1 IDY)   NOT =  ZERO 
                    MOVE   ACCT-DAY(1 IDY)  TO   WK-ROSAITOKU97(IDY) 
                END-IF
             END-IF
      *
           END-PERFORM.
      *
       23001-ROSAITOKU-TAIHI-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¿©»öÎÅÍÜÈñÅù¤Î·×»»                                       *
      ******************************************************************
       23001-SHOKUJI-COUNT-SEC         SECTION.
      *
      *    ADD        WK-NISSU1   TO    WK-SEIKYUKIKAN-NISSU. 
      *
           MOVE       LNK-SYU-SKYSTYMD(7:2)  TO   IDX-ST.
           MOVE       LNK-SYU-SKYEDYMD(7:2)  TO   IDX-ED.
      *
           PERFORM    VARYING   IDY   FROM   IDX-ST   BY   1
                                    UNTIL    IDY     >    IDX-ED
      *
      *      COMPUTE  WK-SEIKYUKIKAN-NISSU  =  WK-SEIKYUKIKAN-NISSU 
      *                                     +  1
      *
             MOVE     ZERO     TO      WK-SHOKUJI-JIHI
      *
             IF       ( NACCT-DAY(IDY)   NOT =  ZERO )
             AND      ( LNK-SYU-DAY(IDY)     =  "1"  )
      *
              IF  WK-SHOKUDOKASAN(IDY)  =  ZERO
      *
                EVALUATE   NACCT-DAY(IDY)
                  WHEN  1
                      EVALUATE   WK-SHOKUJIRYOYO
                        WHEN  1
                          ADD       1    TO   WK-SHOKUJI-NISSU
                                              LNK-SYU-SHOKUJI1-NISSU
                          ADD    1920    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE   1920    TO   LNK-SYU-SHOKUJI1
                          IF    WK-TOKUKANRIKASAN  =  1
                            ADD   200    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                            ADD   200    TO   LNK-SYU-SHOKUJI1
                          END-IF
                        WHEN  2
                          ADD       1    TO   WK-SHOKUJI-NISSU
                                              LNK-SYU-SHOKUJI1-NISSU
                          ADD    1520    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE   1520    TO   LNK-SYU-SHOKUJI1
                      END-EVALUATE
                  WHEN  2
                          ADD       1    TO   WK-SHOKUJI-NISSU
                                              LNK-SYU-SHOKUJI1-NISSU
                                              LNK-SYU-SHOKUJI3-NISSU
                          ADD    1920    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE   1920    TO   LNK-SYU-SHOKUJI1
                          IF    WK-TOKUKANRIKASAN  =  1
                            ADD   200    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                            ADD   200    TO   LNK-SYU-SHOKUJI1
                          END-IF
                          ADD     350    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE    350    TO   LNK-SYU-SHOKUJI3
                  WHEN  3
                          ADD       1    TO   WK-SHOKUJI-NISSU
                                              LNK-SYU-SHOKUJI1-NISSU
                                              LNK-SYU-SHOKUJI4-NISSU
                          ADD    1920    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE   1920    TO   LNK-SYU-SHOKUJI1
                          IF    WK-TOKUKANRIKASAN  =  1
                            ADD   200    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                            ADD   200    TO   LNK-SYU-SHOKUJI1
                          END-IF
                          ADD      50    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE     50    TO   LNK-SYU-SHOKUJI4
                END-EVALUATE
      *
              ELSE
      *
                EVALUATE   NACCT-DAY(IDY)
                  WHEN  1
                      EVALUATE   WK-SHOKUJIRYOYO
                        WHEN  1
                          ADD       1    TO   WK-SHOKUJI-NISSU
                                              LNK-SYU-SHOKUJI2-NISSU
                          ADD    1920    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE   1920    TO   LNK-SYU-SHOKUJI2
                          IF    WK-TOKUKANRIKASAN  =  1
                            ADD   200    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                            ADD   200    TO   LNK-SYU-SHOKUJI2
                          END-IF
                          ADD      50    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          ADD      50    TO   LNK-SYU-SHOKUJI2
                        WHEN  2
                          ADD       1    TO   WK-SHOKUJI-NISSU
                                              LNK-SYU-SHOKUJI1-NISSU
                          ADD    1520    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE   1520    TO   LNK-SYU-SHOKUJI1
                      END-EVALUATE
                  WHEN  2
                          ADD       1    TO   WK-SHOKUJI-NISSU
                                              LNK-SYU-SHOKUJI2-NISSU
                                              LNK-SYU-SHOKUJI3-NISSU
                          ADD    1920    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE   1920    TO   LNK-SYU-SHOKUJI2
                          IF    WK-TOKUKANRIKASAN  =  1
                            ADD   200    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                            ADD   200    TO   LNK-SYU-SHOKUJI2
                          END-IF
                          ADD      50    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          ADD      50    TO   LNK-SYU-SHOKUJI2
      *
                          ADD     350    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE    350    TO   LNK-SYU-SHOKUJI3
                  WHEN  3
                          ADD       1    TO   WK-SHOKUJI-NISSU
                                              LNK-SYU-SHOKUJI2-NISSU
                                              LNK-SYU-SHOKUJI4-NISSU
                          ADD    1920    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE   1920    TO   LNK-SYU-SHOKUJI2
                          IF    WK-TOKUKANRIKASAN  =  1
                            ADD   200    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                            ADD   200    TO   LNK-SYU-SHOKUJI2
                          END-IF
                          ADD      50    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          ADD      50    TO   LNK-SYU-SHOKUJI2
      *
                          ADD      50    TO   WK-SHOKUJI-RYOYOHI
                                              WK-SHOKUJI-JIHI
                          MOVE     50    TO   LNK-SYU-SHOKUJI4
                END-EVALUATE
      *
              END-IF
      *
              IF  COMB-SYU-HKNKOHSBTKBN   =   "8"
                ADD   WK-SHOKUJI-JIHI    TO   WK-SHOKUJI-FTN
              ELSE
                EVALUATE   FLG-SKJ
                  WHEN  0
                          ADD     780    TO   WK-SHOKUJI-FTN
                  WHEN  1
                          ADD     300    TO   WK-SHOKUJI-FTN
                  WHEN  2
      *             COMPUTE   WK-TSUSAN-NISSU  =  
      *                                 LNK-S02-NYUIN-TSUSAN-NISSU  +
      *                                 WK-SEIKYUKIKAN-NISSU
      *             IF        WK-TSUSAN-NISSU  <=  90
      *                   ADD     650    TO   WK-SHOKUJI-FTN
      *             ELSE
      *                   ADD     500    TO   WK-SHOKUJI-FTN
      *             END-IF
                    IF    WRK-SKJGNSTYMD-S   NOT  =   SPACE
                       MOVE   LNK-SYU-SKYSTYMD(1:6) 
                                         TO  WRK-SKJGNSTYYMM2
                       MOVE   IDY        TO  WRK-SKJGNSTDD2
                       IF   WRK-SKJGNSTYMD-S  <=  WRK-SKJGNSTYMD2
                       AND  WRK-SKJGNSTYMD-E  >=  WRK-SKJGNSTYMD2 
                          ADD     500    TO   WK-SHOKUJI-FTN
                       ELSE
                          ADD     650    TO   WK-SHOKUJI-FTN
                       END-IF
                    ELSE
                          ADD     650    TO   WK-SHOKUJI-FTN
                    END-IF    
                END-EVALUATE
              END-IF
      *
             END-IF
      *
             IF       ( WK-ROSAITOKU95(IDY)  NOT =  ZERO       )
             AND      ( LNK-SYU-DAY(IDY)         =  "1" OR "2" )
      *
                ADD     350    TO   WK-SHOKUJI-RYOYOHI95
                                    WK-SHOKUJI-FTN95
      *
             END-IF
      *
             IF       ( WK-ROSAITOKU96(IDY)  NOT =  ZERO       )
             AND      ( LNK-SYU-DAY(IDY)         =  "1" OR "2" )
      *
                ADD     350    TO   WK-SHOKUJI-RYOYOHI96
                                    WK-SHOKUJI-FTN96
      *
             END-IF
      *
             MOVE     ZERO     TO      WK-SHOKUJI-JIHI
      *
             IF       ( WK-ROSAITOKU97(IDY)  NOT =  ZERO       )
             AND      ( LNK-SYU-DAY(IDY)         =  "1" OR "2" )
      *
                ADD       1    TO   WK-SHOKUJI-NISSU
                                    LNK-SYU-SHOKUJI3-NISSU
                ADD     350    TO   WK-SHOKUJI-RYOYOHI
                                    WK-SHOKUJI-JIHI
                MOVE    350    TO   LNK-SYU-SHOKUJI3
      *
                IF  COMB-SYU-HKNKOHSBTKBN   =   "8"
                  ADD   WK-SHOKUJI-JIHI    TO   WK-SHOKUJI-FTN
                END-IF
      *
             END-IF
      *
           END-PERFORM.
      *
       23001-SHOKUJI-COUNT-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¼çÊÝ¸±¤Î´µ¼ÔÉéÃ´¶â³Û·×»»                                *
      ******************************************************************
       2301-SYUHOKEN-KEISAN-SEC           SECTION.
      *
      *    ³ºÅöÊÝ¸±ÈÖ¹æ¥Æ¡¼¥Ö¥ë¤Î¸¡º÷
           INITIALIZE                      HKNNUM-REC.
           MOVE   COMB-HOSPID        TO    HKN-HOSPID.
           MOVE   COMB-HKNNUM        TO    HKN-HKNNUM.
           MOVE   "00"               TO    WK-PAYKBN.
           MOVE   HKNNUM-REC         TO    MCPDATA-REC.
           MOVE   "DBSELECT"         TO    MCP-FUNC.
           MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH.
           CALL   "ORCMCPSUB"         USING MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC.
           IF      MCP-RC            =     ZERO
               MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
               PERFORM  HKNNUM-READ-SEC
               PERFORM  UNTIL
                 (FLG-HKNNUM     =    1)                       OR
                ((HKN-TEKSTYMD(1:6)     <=  LNK-SYU-SKYSTYMD(1:6)) AND
                 (LNK-SYU-SKYSTYMD(1:6) <=  HKN-TEKEDYMD(1:6))     AND
                 (WK-PAYKBN            =  HKN-PAYKBN))
                   PERFORM   HKNNUM-READ-SEC
               END-PERFORM
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Æ¡¼¥Ö¥ë¤ÎÊä½õ¶èÊ¬¤«¤é´µ¼Ô¤ÎÉéÃ´³ä¹ç¤òÊÝ¸±ÈÖ¹æ
      *    ¥Æ¡¼¥Ö¥ë¤ËºÆ¥»¥Ã¥È¡Ê¹ñÊÝ¤Î¤ß¡Ë
           IF    COMB-HKNNUM           =    "060"
               EVALUATE   COMB-HOJOKBN
                   WHEN   "0"
                          MOVE   ZERO      TO   HKN-HON-NYUKFTNRATE
                                                HKN-KZK-NYUKFTNRATE
                                                HKN-TSY-NYUKFTNRATE
                                                HKN-TNK-NYUKFTNRATE
                   WHEN   "1"
                          MOVE   10        TO   HKN-HON-NYUKFTNRATE
                                                HKN-KZK-NYUKFTNRATE
                                                HKN-TSY-NYUKFTNRATE
                                                HKN-TNK-NYUKFTNRATE
                   WHEN   "2"
                          MOVE   20        TO   HKN-HON-NYUKFTNRATE
                                                HKN-KZK-NYUKFTNRATE
                                                HKN-TSY-NYUKFTNRATE
                                                HKN-TNK-NYUKFTNRATE
                   WHEN   "3"
                          MOVE   30        TO   HKN-HON-NYUKFTNRATE
                                                HKN-KZK-NYUKFTNRATE
                                                HKN-TSY-NYUKFTNRATE
                                                HKN-TNK-NYUKFTNRATE
               END-EVALUATE
      *    ·òÊÝ¤Î¹âÎð¼Ô¤Ë¤Ä¤¤¤Æ¤âÊä½õ¶èÊ¬¤è¤êÉéÃ´³ä¹ç¥»¥Ã¥È
           ELSE
               EVALUATE   COMB-HOJOKBN
                   WHEN   "9"
                          MOVE   10        TO   HKN-HON-NYUKFTNRATE
                                                HKN-KZK-NYUKFTNRATE
                                                HKN-TSY-NYUKFTNRATE
                                                HKN-TNK-NYUKFTNRATE
                   WHEN   "8"
                          MOVE   20        TO   HKN-HON-NYUKFTNRATE
                                                HKN-KZK-NYUKFTNRATE
                                                HKN-TSY-NYUKFTNRATE
                                                HKN-TNK-NYUKFTNRATE
               END-EVALUATE
           END-IF.
      *
      *    Ç¯Îð£³ºÐÌ¤Ëþ
           INITIALIZE                           PTINF-REC
           MOVE    LNK-SYU-HOSPID       TO      PTINF-HOSPID
           MOVE    LNK-SYU-PTID         TO      PTINF-PTID
           MOVE    PTINF-REC            TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "PTINF-KEY"          TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING   MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "PTINF-KEY"      TO      ORC-DBPATH
               PERFORM  PTINF-READ-SEC
               IF       MCP-RC          =       ZERO
                    MOVE   PTINF-BIRTHDAY   TO  WRK-YMDS1
                    MOVE   LNK-SYU-SKYSTYMD TO  WRK-YMDS2
                    MOVE   ZERO             TO  WRK-NENREI
                    COMPUTE  WRK-NENREI     =   WRK-YYS2
                                            -   WRK-YYS1
                    IF   WRK-YMDS1(5:4)     >   WRK-YMDS2(5:4)
                         ADD   -1           TO  WRK-NENREI
                    END-IF
                    IF   WRK-NENREI         =   3
                    AND  WRK-YMDS1(5:4)    <=   WRK-YMDS2(5:4)
                        IF    WRK-YMDS1(5:2)  = WRK-YMDS2(5:2)
                             IF   WRK-YMDS1(7:2)  NOT = "01"
                                   ADD   -1     TO  WRK-NENREI
                              END-IF
                        END-IF
                    END-IF
               ELSE
                    DISPLAY  "PTINF FETCH ERR"
                    MOVE     ZERO   TO      WRK-NENREI
               END-IF
           ELSE
               DISPLAY   "PTINF SELECT ERR"
               MOVE     ZERO   TO      WRK-NENREI
           END-IF
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           MOVE    "PTINF-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      WRK-NENREI         <     3
               IF   COMB-HKNNUM       =     "060"
                   IF   COMB-HOJOKBN  =     "0"  OR  "1"
                       CONTINUE
                   ELSE
                       MOVE   20      TO   HKN-HON-NYUKFTNRATE
                                           HKN-KZK-NYUKFTNRATE
                                           HKN-TSY-NYUKFTNRATE
                                           HKN-TNK-NYUKFTNRATE
                   END-IF
               ELSE
                   IF    HKN-HKNKOHSBTKBN  =  "1" 
                       MOVE   20      TO   HKN-HON-NYUKFTNRATE
                                           HKN-KZK-NYUKFTNRATE
                                           HKN-TSY-NYUKFTNRATE
                                           HKN-TNK-NYUKFTNRATE
                   END-IF 
               END-IF
           END-IF.
      *
      *    ÊÝ¸±ÁÈ¹ç¤»¥Æ¡¼¥Ö¥ë¤ÎÊä½õ¶èÊ¬¤«¤é´µ¼Ô¤ÎÉéÃ´³ä¹ç¤òÊÝ¸±ÈÖ¹æ
      *    ¥Æ¡¼¥Ö¥ë¤ËºÆ¥»¥Ã¥È¡ÊÁ¥°÷ÊÝ¸±»þ¡Ë
           IF    COMB-HKNNUM           =    "002"
               EVALUATE   COMB-HOJOKBN
                   WHEN   "1"
                   WHEN   "2"
                   WHEN   "3"
                   WHEN   "A"
                   WHEN   "B"
                   WHEN   "C"
                   WHEN   "D"
                   WHEN   "E"
                   WHEN   "F"
                          MOVE   ZERO      TO   HKN-HON-NYUKFTNRATE
                                                HKN-KZK-NYUKFTNRATE
                                                HKN-TSY-NYUKFTNRATE
                                                HKN-TNK-NYUKFTNRATE
               END-EVALUATE
           END-IF.
      *    ÊÝ¸±ÁÈ¹ç¤»¥Æ¡¼¥Ö¥ë¤ÎÊä½õ¶èÊ¬¤«¤é´µ¼Ô¤ÎÉéÃ´³ä¹ç¤òÊÝ¸±ÈÖ¹æ
      *    ¥Æ¡¼¥Ö¥ë¤ËºÆ¥»¥Ã¥È¡Ê¶¦ºÑÁÈ¹çÊÝ¸±»þ¡Ë
           IF    COMB-HKNNUM    =    "031" OR "032" OR "033" OR "034"
               EVALUATE   COMB-HOJOKBN
                   WHEN   "2"
                   WHEN   "B"
                   WHEN   "E"
                          MOVE   ZERO      TO   HKN-HON-GAIKFTNRATE
                                                HKN-KZK-GAIKFTNRATE
                                                HKN-TSY-GAIKFTNRATE
                                                HKN-TNK-GAIKFTNRATE
               END-EVALUATE
           END-IF.
      *
      *    ¡Ê£×£Ë¡Ý£È£Ë£Î£Ë£Â£Î¡¡¶õÇò¡§°åÊÝ¡¡£±¡§Ï«ºÒ¡¦¼«Çå¡Ë
           EVALUATE   WK-HKNKBN
             WHEN   SPACE
      *    ÉéÃ´¶â³Û¤Î·×»»
               EVALUATE   FLG-SANSHOU
                 WHEN   "1"
                   IF   COMB-HONKZKKBN        =   "1"
                        IF    HKN-HON-NYUKFTNRATE     NOT =    ZERO
                              COMPUTE   WK-FUTANWARI  =
                                        HKN-HON-NYUKFTNRATE  /  100
                              COMPUTE   LNK-SYU-SYUCOMPFTN  =
                                        WK-ZENGAKU   *  WK-FUTANWARI
                              MOVE      LNK-SYU-SYUCOMPFTN
                                                 TO WK-TOKUTEI-COMPFTN2
                              COMPUTE   LNK-SYU-SYUCOMPFTN =
                                        LNK-SYU-SYUCOMPFTN  +  5
                              COMPUTE   WK-FTN      =
                                        LNK-SYU-SYUCOMPFTN  /  10
                              COMPUTE   LNK-SYU-SYUCOMPFTN =
                                        WK-FTN   *  10
                        END-IF
      *
                        IF   LNK-S02-KOUREI-NYUIN-KBN   =   "1"
                            IF  ZAN-SYU-M     <     WK-TOKUTEI-COMPFTN2 
                                MOVE ZAN-SYU-M   TO  LNK-SYU-SYUCOMPFTN
                                                     WK-TOKUTEI-COMPFTN 
                            ELSE                                        
                                MOVE WK-TOKUTEI-COMPFTN2                
                                                 TO  WK-TOKUTEI-COMPFTN 
                            END-IF
                        ELSE
                                MOVE WK-TOKUTEI-COMPFTN2                
                                                 TO  WK-TOKUTEI-COMPFTN 
                        END-IF
                        COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                                  LNK-SYU-SYUCOMPFTN     
                        MOVE  HKN-HON-NYUSKJRYYKBN
                                             TO   LNK-SYU-SYUSKJ-FTNKBN
                        MOVE  WK-SHOKUJI-NISSU
                                             TO   LNK-SYU-SYUSKJ-NISSU
                        MOVE  WK-SHOKUJI-RYOYOHI
                                             TO   LNK-SYU-SYUSKJ-RYOYOHI
                        IF    HKN-HON-NYUSKJRYYKBN  NOT =  "0"
                            IF    HKN-HON-NYUSKJRYYKBN  NOT =  "3"
                              MOVE  WK-SHOKUJI-FTN
                                             TO   LNK-SYU-SYUSKJ-FTN
                            END-IF
                            MOVE  WK-SHOKUJI-FTN
                                            TO   LNK-SYU-SYUSKJ-FTN-RECE
                        END-IF
                   ELSE
                        IF    HKN-KZK-NYUKFTNRATE     NOT =    ZERO
                              COMPUTE   WK-FUTANWARI  =
                                        HKN-KZK-NYUKFTNRATE  /  100
                              COMPUTE   LNK-SYU-SYUCOMPFTN  =
                                        WK-ZENGAKU   *  WK-FUTANWARI
                              MOVE      LNK-SYU-SYUCOMPFTN
                                                 TO WK-TOKUTEI-COMPFTN2
                              COMPUTE   LNK-SYU-SYUCOMPFTN =
                                        LNK-SYU-SYUCOMPFTN  +  5
                              COMPUTE   WK-FTN      =
                                        LNK-SYU-SYUCOMPFTN  /  10
                              COMPUTE   LNK-SYU-SYUCOMPFTN =
                                        WK-FTN   *  10
                        END-IF
      *
                        IF   LNK-S02-KOUREI-NYUIN-KBN   =   "1"
                            IF  ZAN-SYU-M     <     WK-TOKUTEI-COMPFTN2 
                                MOVE ZAN-SYU-M   TO  LNK-SYU-SYUCOMPFTN
                                                     WK-TOKUTEI-COMPFTN 
                            ELSE                                        
                                MOVE WK-TOKUTEI-COMPFTN2                
                                                 TO  WK-TOKUTEI-COMPFTN 
                            END-IF
                        ELSE
                                MOVE WK-TOKUTEI-COMPFTN2                
                                                 TO  WK-TOKUTEI-COMPFTN 
                        END-IF
                        COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                                  LNK-SYU-SYUCOMPFTN     
                        MOVE  HKN-KZK-NYUSKJRYYKBN
                                             TO   LNK-SYU-SYUSKJ-FTNKBN
                        MOVE  WK-SHOKUJI-NISSU
                                             TO   LNK-SYU-SYUSKJ-NISSU
                        MOVE  WK-SHOKUJI-RYOYOHI
                                             TO   LNK-SYU-SYUSKJ-RYOYOHI
                        IF    HKN-KZK-NYUSKJRYYKBN  NOT =  "0"
                            IF    HKN-KZK-NYUSKJRYYKBN  NOT =  "3"
                              MOVE  WK-SHOKUJI-FTN
                                             TO   LNK-SYU-SYUSKJ-FTN
                            END-IF
                            MOVE  WK-SHOKUJI-FTN
                                            TO   LNK-SYU-SYUSKJ-FTN-RECE
                        END-IF
                   END-IF
                 WHEN   "2"
                   IF    HKN-TSY-NYUKFTNRATE     NOT =    ZERO
                         COMPUTE   WK-FUTANWARI  =
                                   HKN-TSY-NYUKFTNRATE  /  100
                         COMPUTE   LNK-SYU-SYUCOMPFTN  =
                                   WK-ZENGAKU   *  WK-FUTANWARI
                         MOVE      LNK-SYU-SYUCOMPFTN
                                             TO WK-TOKUTEI-COMPFTN2
                         COMPUTE   LNK-SYU-SYUCOMPFTN =
                                   LNK-SYU-SYUCOMPFTN  +  5
                         COMPUTE   WK-FTN      =
                                   LNK-SYU-SYUCOMPFTN  /  10
                         COMPUTE   LNK-SYU-SYUCOMPFTN =
                                   WK-FTN   *  10
                   END-IF
      *
                   IF   LNK-S02-KOUREI-NYUIN-KBN   =   "1"
                       IF  ZAN-SYU-M     <     WK-TOKUTEI-COMPFTN2      
                           MOVE ZAN-SYU-M   TO  LNK-SYU-SYUCOMPFTN
                                                WK-TOKUTEI-COMPFTN      
                       ELSE                                             
                           MOVE WK-TOKUTEI-COMPFTN2                     
                                                 TO  WK-TOKUTEI-COMPFTN 
                       END-IF
                   ELSE
                           MOVE WK-TOKUTEI-COMPFTN2              
                                                 TO  WK-TOKUTEI-COMPFTN 
                   END-IF
                   COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                             LNK-SYU-SYUCOMPFTN     
                   MOVE  HKN-TSY-NYUSKJRYYKBN
                                             TO   LNK-SYU-SYUSKJ-FTNKBN
                   MOVE  WK-SHOKUJI-NISSU
                                             TO   LNK-SYU-SYUSKJ-NISSU
                   MOVE  WK-SHOKUJI-RYOYOHI
                                             TO   LNK-SYU-SYUSKJ-RYOYOHI
                   IF    HKN-TSY-NYUSKJRYYKBN  NOT =  "0"
                            IF    HKN-TSY-NYUSKJRYYKBN  NOT =  "3"
                              MOVE  WK-SHOKUJI-FTN
                                             TO   LNK-SYU-SYUSKJ-FTN
                            END-IF
                            MOVE  WK-SHOKUJI-FTN
                                            TO   LNK-SYU-SYUSKJ-FTN-RECE
                   END-IF
                 WHEN   "3"
                   IF    HKN-TNK-NYUKFTNRATE     NOT =    ZERO
                         COMPUTE   WK-FUTANWARI  =
                                   HKN-TNK-NYUKFTNRATE  /  100
                         COMPUTE   LNK-SYU-SYUCOMPFTN  =
                                   WK-ZENGAKU   *  WK-FUTANWARI
                         MOVE      LNK-SYU-SYUCOMPFTN
                                            TO WK-TOKUTEI-COMPFTN2
                         COMPUTE   LNK-SYU-SYUCOMPFTN =
                                   LNK-SYU-SYUCOMPFTN  +  5
                         COMPUTE   WK-FTN      =
                                   LNK-SYU-SYUCOMPFTN  /  10
                         COMPUTE   LNK-SYU-SYUCOMPFTN =
                                   WK-FTN   *  10
                   END-IF
      *
                   IF   LNK-S02-KOUREI-NYUIN-KBN   =   "1"
                       IF  ZAN-SYU-M     <     WK-TOKUTEI-COMPFTN2      
                           MOVE ZAN-SYU-M   TO  LNK-SYU-SYUCOMPFTN
                                                WK-TOKUTEI-COMPFTN      
                       ELSE                                             
                           MOVE WK-TOKUTEI-COMPFTN2                     
                                                 TO  WK-TOKUTEI-COMPFTN 
                       END-IF
                   ELSE
                           MOVE WK-TOKUTEI-COMPFTN2                
                                                 TO  WK-TOKUTEI-COMPFTN 
                   END-IF
                   COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                             LNK-SYU-SYUCOMPFTN     
                   MOVE  HKN-TNK-NYUSKJRYYKBN
                                             TO   LNK-SYU-SYUSKJ-FTNKBN
                   MOVE  WK-SHOKUJI-NISSU
                                             TO   LNK-SYU-SYUSKJ-NISSU
                   MOVE  WK-SHOKUJI-RYOYOHI
                                             TO   LNK-SYU-SYUSKJ-RYOYOHI
                   IF    HKN-TNK-NYUSKJRYYKBN  NOT =  "0"
                            IF    HKN-TNK-NYUSKJRYYKBN  NOT =  "3"
                              MOVE  WK-SHOKUJI-FTN
                                             TO   LNK-SYU-SYUSKJ-FTN
                            END-IF
                            MOVE  WK-SHOKUJI-FTN
                                            TO   LNK-SYU-SYUSKJ-FTN-RECE
                   END-IF
               END-EVALUATE
             WHEN   "1"
      *        ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¡Ê£´£°£°£±¡Ë¤«¤éÅÀ¿ôÃ±²Á¤Î¼èÆÀ
               INITIALIZE                         SYS-4001-REC
               MOVE    "4001"               TO    SYS-4001-KANRICD
               MOVE    "*"                  TO    SYS-4001-KBNCD
               MOVE    LNK-SYU-SKYSTYMD     TO    ORC-DBYMD
               MOVE    SYS-4001-REC         TO    MCPDATA-REC
               MOVE    "DBSELECT"           TO    MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO    ORC-DBPATH
               CALL    "ORCMCPSUB"    USING       MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
               IF      MCP-RC               =     ZERO
                   MOVE     "SYSKANRI-KEY"  TO    ORC-DBPATH
                   PERFORM   SYSKANRI-READ-SEC
                   IF    MCP-RC             =     ZERO
                     IF    SYS-4001-KSNRATE(1:2)   =    SPACE
                            MOVE     100        TO   WK-KSNRATE9
                            COMPUTE  WK-KSNRATE   =  WK-KSNRATE9  /  100
                     ELSE
                            COMPUTE  WK-KSNRATE9  =  SYS-4001-KSNRATE
                                                  +  100 
                            COMPUTE  WK-KSNRATE   =  WK-KSNRATE9  /  100
                     END-IF  
                     IF     LNK-SYU-SYUHKNNUM       =  "971"
                       EVALUATE  SYS-4001-TENKBN
                           WHEN  "1"
                               COMPUTE  WK-ZENGAKU  =  
                                        WK-ZENGAKU  / 10 * 11.5
                           WHEN  "2"
                               COMPUTE  WK-ZENGAKU  =  
                                        WK-ZENGAKU  / 10 * 12.0
                       END-EVALUATE
                     ELSE
                       EVALUATE  SYS-4001-TENKBN
                           WHEN  "1"
                              COMPUTE  WK-ZENGAKU  =  WK-ZENGAKU  /  10  
                              MOVE  LNK-S02-SYUTEN  TO  WK-ZENGAKU-SYU
                              COMPUTE  WK-ZENGAKU-YAK = WK-ZENGAKU 
                                                      - LNK-S02-SYUTEN
                              COMPUTE  WK-ZENGAKU-SYU = WK-ZENGAKU-SYU
                                                      * 11.5
                              COMPUTE  WK-ZENGAKU-SYU = WK-ZENGAKU-SYU
                                                      * WK-KSNRATE
                              COMPUTE  WK-ZENGAKU-YAK = WK-ZENGAKU-YAK
                                                      * 11.5
                              COMPUTE  WK-ZENGAKU     = WK-ZENGAKU-SYU
                                                      + WK-ZENGAKU-YAK
                           WHEN  "2"
                              COMPUTE  WK-ZENGAKU  =  WK-ZENGAKU  /  10  
                              MOVE  LNK-S02-SYUTEN  TO  WK-ZENGAKU-SYU
                              COMPUTE  WK-ZENGAKU-YAK = WK-ZENGAKU 
                                                      - LNK-S02-SYUTEN
                              COMPUTE  WK-ZENGAKU-SYU = WK-ZENGAKU-SYU
                                                      * 12.0
                              COMPUTE  WK-ZENGAKU-SYU = WK-ZENGAKU-SYU
                                                      * WK-KSNRATE
                              COMPUTE  WK-ZENGAKU-YAK = WK-ZENGAKU-YAK
                                                      * 12.0
                              COMPUTE  WK-ZENGAKU     = WK-ZENGAKU-SYU
                                                      + WK-ZENGAKU-YAK
                       END-EVALUATE
                     END-IF 
                   END-IF
               END-IF
      *
               MOVE    "DBCLOSE"            TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
      *
               COMPUTE   WK-FUTANWARI  =
                         HKN-HON-NYUKFTNRATE  /  100
               COMPUTE   LNK-SYU-SYUCOMPFTN  =
                         WK-ZENGAKU   *  WK-FUTANWARI
      *         COMPUTE   LNK-SYU-SYUCOMPFTN =
      *                   LNK-SYU-SYUCOMPFTN  +  5
      *         COMPUTE   WK-FTN      =
      *                   LNK-SYU-SYUCOMPFTN  /  10
      *         COMPUTE   LNK-SYU-SYUCOMPFTN =
      *                   WK-FTN   *  10
               COMPUTE   LNK-SYU-SYUCOMPTOTAL   =
                         LNK-SYU-SYUCOMPFTN     
               MOVE  HKN-HON-NYUSKJRYYKBN
                                        TO   LNK-SYU-SYUSKJ-FTNKBN
               MOVE  WK-SHOKUJI-NISSU
                                        TO   LNK-SYU-SYUSKJ-NISSU
               MOVE  WK-SHOKUJI-RYOYOHI
                                        TO   LNK-SYU-SYUSKJ-RYOYOHI
               IF    HKN-HON-NYUSKJRYYKBN  NOT =  "0"
                       IF    HKN-HON-NYUSKJRYYKBN  NOT =  "3"
                         MOVE  WK-SHOKUJI-FTN
                                        TO   LNK-SYU-SYUSKJ-FTN
                       END-IF
                       MOVE  WK-SHOKUJI-FTN
                                        TO   LNK-SYU-SYUSKJ-FTN-RECE
               END-IF
           END-EVALUATE.
      *
       2301-SYUHOKEN-KEISAN-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñ¤ÎÊÝ¸±ÈÖ¹æ¥Æ¡¼¥Ö¥ë¸¡º÷                              *
      ******************************************************************
       2302-KOH-HKNREAD-SEC           SECTION.
      *
      *    ³ºÅöÊÝ¸±ÈÖ¹æ¥Æ¡¼¥Ö¥ë¤Î¸¡º÷
           INITIALIZE                      HKNNUM-REC.
           MOVE   COMB-HOSPID        TO    HKN-HOSPID.
           MOVE   COMB-KOHHKNNUM(KOH-IDX)
                                     TO    HKN-HKNNUM.
           IF     COMB-KOHHKNNUM(KOH-IDX)  =     "027"
                  MOVE     COMB-KOH1PAYKBN
                                     TO    WK-PAYKBN
           ELSE
                  MOVE     "00"      TO    WK-PAYKBN
           END-IF.
           MOVE   HKNNUM-REC         TO    MCPDATA-REC.
           MOVE   "DBSELECT"         TO    MCP-FUNC.
           MOVE   "HKNNUM-KEY2"      TO    ORC-DBPATH.
           CALL   "ORCMCPSUB"         USING MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC.
           IF      MCP-RC            =     ZERO
               MOVE    "HKNNUM-KEY2" TO    ORC-DBPATH
               PERFORM  HKNNUM-READ-SEC
               PERFORM  UNTIL
                 (FLG-HKNNUM     =    1)                       OR
                ((HKN-TEKSTYMD(1:6)     <=  LNK-SYU-SKYSTYMD(1:6)) AND
                 (LNK-SYU-SKYSTYMD(1:6) <=  HKN-TEKEDYMD(1:6))     AND
                 (WK-PAYKBN            =  HKN-PAYKBN))
                   PERFORM   HKNNUM-READ-SEC
               END-PERFORM
           END-IF.
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC.
           MOVE    "HKNNUM-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"           USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC.
           MOVE       ZERO                TO   WK-NYUKFTNRATE.
           MOVE       ZERO                TO   WK-NYUSKJRYYKBN.
           EVALUATE   FLG-SANSHOU2
               WHEN   "1"
                   MOVE    HKN-HON-NYUKFTNRATE  TO   WK-NYUKFTNRATE
                   MOVE    HKN-HON-NYUSKJRYYKBN TO   WK-NYUSKJRYYKBN
               WHEN   "2"
                   MOVE    HKN-TSY-NYUKFTNRATE  TO   WK-NYUKFTNRATE
                   MOVE    HKN-TSY-NYUSKJRYYKBN TO   WK-NYUSKJRYYKBN
               WHEN   "3"
                   MOVE    HKN-TNK-NYUKFTNRATE  TO   WK-NYUKFTNRATE
                   MOVE    HKN-TNK-NYUSKJRYYKBN TO   WK-NYUSKJRYYKBN
           END-EVALUATE.
      *
       2302-KOH-HKNREAD-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñ¤Î´µ¼ÔÉéÃ´¶â³Û·×»»¡Ê¾å¸Â³Û¤¢¤ê¡Ë                    *
      ******************************************************************
       2303-KOH-KEISAN-SEC           SECTION.
      *
      *    ÉéÃ´¶â³Û¤Î·×»»
           IF  WK-NYUKFTNRATE     NOT =    ZERO
               COMPUTE   WK-FUTANWARI  =
                              WK-NYUKFTNRATE  /  100
               COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX)  =
                         WK-ZENGAKU   *  WK-FUTANWARI
               IF   LNK-SYU-KOH-HKNNUM(KOH-IDX)  =      "027"           
                    MOVE   LNK-SYU-KOH-COMPFTN(KOH-IDX)                 
                                            TO WK-TOKUTEI-COMPFTN3      
               END-IF                                      
               IF ((HKN-HKNKOHSBTKBN     =       "3")    AND
                   (LNK-SYU-KOH-HKNNUM(KOH-IDX)  NOT =  "027")) OR
                  ( LNK-SYU-KOH-HKNNUM(KOH-IDX)  =      "051" ) OR
                  ( HKN-RECEFTNDSPKBN            =      "2"   ) OR
                  ( FLG-KOUGAKUCYO               =       1    )
                   CONTINUE
               ELSE
                   COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX)  =
                             LNK-SYU-KOH-COMPFTN(KOH-IDX)  +  5
                   COMPUTE   WK-FTN      =
                             LNK-SYU-KOH-COMPFTN(KOH-IDX)  / 10
                   COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX)  =
                             WK-FTN   *  10
               END-IF
               IF   LNK-S02-KOUREI-NYUIN-KBN     =   "1"                
                IF    LNK-SYU-KOH-HKNNUM(KOH-IDX)  NOT =  "027"         
                  COMPUTE  FTN-KOH-YYY  =  40200  -  FTN-KOH-XXX        
                  IF  LNK-SYU-KOH-COMPFTN(KOH-IDX)  >  FTN-KOH-YYY      
                    MOVE  FTN-KOH-YYY TO  LNK-SYU-KOH-COMPFTN(KOH-IDX)  
                  END-IF                                                
                END-IF                                                  
               END-IF                                              
               PERFORM    KOHHI-HIKAKU-SEC
               IF    LNK-SYU-KOH-COMPFTN(KOH-IDX)   >
                                            ZAN-KOHI-T(KOH-IDX)
                     MOVE   ZAN-KOHI-T(KOH-IDX)   TO
                                          LNK-SYU-KOH-COMPFTN(KOH-IDX)
                     MOVE   ZERO        TO  ZAN-KOHI-T(KOH-IDX)
                     IF   LNK-SYU-KOH-HKNNUM(KOH-IDX)  =      "027"     
                          MOVE   LNK-SYU-KOH-COMPFTN(KOH-IDX)           
                                            TO WK-TOKUTEI-COMPFTN3      
                     END-IF         
               ELSE
                     COMPUTE  ZAN-KOHI-T(KOH-IDX)    =
                              ZAN-KOHI-T(KOH-IDX)    -
                              LNK-SYU-KOH-COMPFTN(KOH-IDX)
               END-IF
               COMPUTE   LNK-SYU-KOH-COMPTOTAL(KOH-IDX)   =
                         LNK-SYU-KOH-COMPFTN(KOH-IDX)     
               IF    ZAN-KOHI-T(KOH-IDX)   NOT =   ZERO
                   COMPUTE   ZAN-KOHI-T(KOH-IDX) =
                             ZAN-KOHI-T(KOH-IDX)  +  5
                   COMPUTE   WK-FTN      =
                             ZAN-KOHI-T(KOH-IDX)  /  10
                   COMPUTE   ZAN-KOHI-T(KOH-IDX) =
                             WK-FTN   *  10
               END-IF
               MOVE  WK-NYUSKJRYYKBN    TO LNK-SYU-SKJ-FTNKBN(KOH-IDX)
               MOVE  WK-SHOKUJI-NISSU   TO LNK-SYU-SKJ-NISSU(KOH-IDX)
               MOVE  WK-SHOKUJI-RYOYOHI TO LNK-SYU-SKJ-RYOYOHI(KOH-IDX)
               EVALUATE   WK-NYUSKJRYYKBN
                   WHEN   "1"
                   WHEN   "2"
                   WHEN   "4"
                       MOVE  WK-SHOKUJI-FTN
                                      TO   LNK-SYU-SKJ-FTN(KOH-IDX)
                                           LNK-SYU-SKJ-FTN-RECE(KOH-IDX)
                       IF   LNK-SYU-KOH-HKNNUM(KOH-IDX)  =  "051"
                         IF    LNK-SYU-SKJ-FTN(KOH-IDX)   >
                                              ZAN-KOHI-T(KOH-IDX)
                            MOVE   ZAN-KOHI-T(KOH-IDX)   TO
                                        LNK-SYU-SKJ-FTN(KOH-IDX)
      *                                 LNK-SYU-SKJ-FTN-RECE(KOH-IDX)
                            MOVE   ZERO      TO  ZAN-KOHI-T(KOH-IDX)
                         ELSE
                            COMPUTE  ZAN-KOHI-T(KOH-IDX)    =
                                     ZAN-KOHI-T(KOH-IDX)    -
                                     LNK-SYU-SKJ-FTN(KOH-IDX)
                         END-IF
                       END-IF
                   WHEN   "3"
                       MOVE  WK-SHOKUJI-FTN
                                      TO   LNK-SYU-SKJ-FTN-RECE(KOH-IDX)
               END-EVALUATE
           ELSE
               IF      ((HKN-HKNKOHSBTKBN     =       "3")    AND
                        (LNK-SYU-KOH-HKNNUM(KOH-IDX)  NOT =  "027")) OR
                       ( LNK-SYU-KOH-HKNNUM(KOH-IDX)  =      "051" ) OR
                       ( HKN-RECEFTNDSPKBN            =      "2"   )
                   IF    WK-TOKUTEI-COMPFTN   NOT =    ZERO
                       MOVE  WK-TOKUTEI-COMPFTN  TO  LNK-SYU-SYUCOMPFTN
                   END-IF
               END-IF
               IF     (((HKN-HKNKOHSBTKBN     =       "3")    AND       
                        (LNK-SYU-KOH-HKNNUM(KOH-IDX)  NOT =  "027")) OR 
                       ( LNK-SYU-KOH-HKNNUM(KOH-IDX)  =      "051" ) OR
                       ( HKN-RECEFTNDSPKBN            =      "2"   ))  
               AND    (  LNK-SYU-KOH-HKNNUM(1)        =   "027"     )   
                   IF    WK-TOKUTEI-COMPFTN3   NOT =    ZERO            
                       MOVE   WK-TOKUTEI-COMPFTN3                       
                                            TO  LNK-SYU-KOH-COMPFTN(1)  
                   END-IF                                               
               END-IF                    
               IF    LNK-SYU-SYUCOMPFTN   NOT =    ZERO
                   IF   LNK-S02-KOUREI-NYUIN-KBN     =   "1"
                   AND  LNK-SYU-KOH-HKNNUM(KOH-IDX)  NOT =  "027"       
                       COMPUTE  FTN-KOH-YYY  =  40200  -  FTN-KOH-XXX   
                       IF  LNK-SYU-SYUCOMPFTN  >  FTN-KOH-YYY           
                         MOVE  FTN-KOH-YYY         TO  FTN-KOH-ZZZ      
                       ELSE                                             
                         MOVE  LNK-SYU-SYUCOMPFTN  TO  FTN-KOH-ZZZ      
                       END-IF                                           
                       IF    FTN-KOH-ZZZ      >    ZAN-KOHI-T(KOH-IDX)  
                           MOVE  ZAN-KOHI-T(KOH-IDX)                    
                                            TO  LNK-SYU-KOH-COMPFTN     
                                                         (KOH-IDX)      
                           MOVE   ZERO      TO  ZAN-KOHI-T(KOH-IDX)     
                           PERFORM    KOHHI-HIKAKU-SEC                  
                       ELSE                                             
                           MOVE  FTN-KOH-ZZZ                            
                                            TO  LNK-SYU-KOH-COMPFTN     
                                                         (KOH-IDX)      
                           COMPUTE    ZAN-KOHI-T(KOH-IDX)  =            
                                      ZAN-KOHI-T(KOH-IDX)  -            
                                      LNK-SYU-KOH-COMPFTN(KOH-IDX)      
                           PERFORM    KOHHI-HIKAKU-SEC                  
                       END-IF                                           
                   ELSE                                   
                       IF   LNK-SYU-SYUCOMPFTN   >  ZAN-KOHI-T(KOH-IDX)
                           MOVE   ZAN-KOHI-T(KOH-IDX)
                                            TO  LNK-SYU-KOH-COMPFTN
                                                         (KOH-IDX)
                           MOVE   ZERO      TO  ZAN-KOHI-T(KOH-IDX)
                           PERFORM    KOHHI-HIKAKU-SEC
                       ELSE
                           MOVE  LNK-SYU-SYUCOMPFTN
                                            TO  LNK-SYU-KOH-COMPFTN
                                                         (KOH-IDX)
                           COMPUTE    ZAN-KOHI-T(KOH-IDX)  =
                                      ZAN-KOHI-T(KOH-IDX)  -
                                      LNK-SYU-KOH-COMPFTN(KOH-IDX)
                           PERFORM    KOHHI-HIKAKU-SEC
                       END-IF
                   END-IF
               ELSE
                 IF    LNK-SYU-KOH-COMPFTN(1)   NOT =    ZERO
                   IF   LNK-S02-KOUREI-NYUIN-KBN     =   "1"
                   AND  LNK-SYU-KOH-HKNNUM(KOH-IDX)  NOT =  "027"       
                       COMPUTE  FTN-KOH-YYY  =  40200  -  FTN-KOH-XXX   
                       IF  LNK-SYU-KOH-COMPFTN(1) >  FTN-KOH-YYY        
                         MOVE  FTN-KOH-YYY            TO  FTN-KOH-ZZZ   
                       ELSE                                             
                         MOVE  LNK-SYU-KOH-COMPFTN(1) TO  FTN-KOH-ZZZ   
                       END-IF                                           
                       IF FTN-KOH-ZZZ   >    ZAN-KOHI-T(KOH-IDX)        
                          MOVE   ZAN-KOHI-T(KOH-IDX)                    
                                       TO  LNK-SYU-KOH-COMPFTN(KOH-IDX) 
                          MOVE   ZERO  TO  ZAN-KOHI-T(KOH-IDX)          
                          PERFORM    KOHHI-HIKAKU-SEC                   
                       ELSE                                             
                          MOVE   FTN-KOH-ZZZ  TO  LNK-SYU-KOH-COMPFTN   
                                                            (KOH-IDX)   
                          PERFORM    KOHHI-HIKAKU-SEC                   
                          COMPUTE   ZAN-KOHI-T(KOH-IDX)  =              
                                    ZAN-KOHI-T(KOH-IDX)  -              
                                    LNK-SYU-KOH-COMPFTN(KOH-IDX)        
                       END-IF                                           
                   ELSE                                                 
                       IF    LNK-SYU-KOH-COMPFTN(1)
                                     >    ZAN-KOHI-T(KOH-IDX)
                          MOVE   ZAN-KOHI-T(KOH-IDX)
                                       TO  LNK-SYU-KOH-COMPFTN(KOH-IDX)
                          MOVE   ZERO  TO  ZAN-KOHI-T(KOH-IDX)
                          PERFORM    KOHHI-HIKAKU-SEC
                       ELSE
                          MOVE   LNK-SYU-KOH-COMPFTN(1)
                                              TO  LNK-SYU-KOH-COMPFTN
                                                            (KOH-IDX)
                          PERFORM    KOHHI-HIKAKU-SEC
                          COMPUTE   ZAN-KOHI-T(KOH-IDX)  =
                                    ZAN-KOHI-T(KOH-IDX)  -
                                    LNK-SYU-KOH-COMPFTN(KOH-IDX)
                       END-IF
                   END-IF
                 ELSE
                   MOVE   ZERO  TO  ZAN-KOHI-T(KOH-IDX)
                 END-IF
               END-IF
               COMPUTE   LNK-SYU-KOH-COMPTOTAL(KOH-IDX)   =
                         LNK-SYU-KOH-COMPFTN(KOH-IDX)     
               IF    ZAN-KOHI-T(KOH-IDX)   NOT =   ZERO
                   COMPUTE   ZAN-KOHI-T(KOH-IDX) =
                             ZAN-KOHI-T(KOH-IDX)  +  5
                   COMPUTE   WK-FTN      =
                             ZAN-KOHI-T(KOH-IDX)  /  10
                   COMPUTE   ZAN-KOHI-T(KOH-IDX) =
                             WK-FTN   *  10
               END-IF
               MOVE  WK-NYUSKJRYYKBN    TO LNK-SYU-SKJ-FTNKBN(KOH-IDX)
               MOVE  WK-SHOKUJI-NISSU   TO LNK-SYU-SKJ-NISSU(KOH-IDX)
               MOVE  WK-SHOKUJI-RYOYOHI TO LNK-SYU-SKJ-RYOYOHI(KOH-IDX)
               EVALUATE   WK-NYUSKJRYYKBN
                   WHEN   "1"
                   WHEN   "2"
                   WHEN   "4"
                       MOVE  WK-SHOKUJI-FTN
                                      TO   LNK-SYU-SKJ-FTN(KOH-IDX)
                                           LNK-SYU-SKJ-FTN-RECE(KOH-IDX)
                       IF   LNK-SYU-KOH-HKNNUM(KOH-IDX)  =  "051"
                         IF    LNK-SYU-SKJ-FTN(KOH-IDX)   >
                                              ZAN-KOHI-T(KOH-IDX)
                            MOVE   ZAN-KOHI-T(KOH-IDX)   TO
                                        LNK-SYU-SKJ-FTN(KOH-IDX)
      *                                 LNK-SYU-SKJ-FTN-RECE(KOH-IDX)
                            MOVE   ZERO      TO  ZAN-KOHI-T(KOH-IDX)
                         ELSE
                            COMPUTE  ZAN-KOHI-T(KOH-IDX)    =
                                     ZAN-KOHI-T(KOH-IDX)    -
                                     LNK-SYU-SKJ-FTN(KOH-IDX)
                         END-IF
                       END-IF
                   WHEN   "3"
                       MOVE  WK-SHOKUJI-FTN
                                      TO   LNK-SYU-SKJ-FTN-RECE(KOH-IDX)
               END-EVALUATE
           END-IF.
      *
       2303-KOH-KEISAN-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñ¤Î´µ¼ÔÉéÃ´¶â³Û·×»»¡Ê¾å¸Â³Û¤Ê¤·¡Ë                  *
      ******************************************************************
       2304-KOH-KEISAN-SEC           SECTION.
      *
      *    ÉéÃ´¶â³Û¤Î·×»»
           IF  WK-NYUKFTNRATE     NOT =    ZERO
               COMPUTE   WK-FUTANWARI  =
                              WK-NYUKFTNRATE  /  100
               COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX)  =
                         WK-ZENGAKU   *  WK-FUTANWARI
               IF   LNK-SYU-KOH-HKNNUM(KOH-IDX)  =      "027"           
                    MOVE   LNK-SYU-KOH-COMPFTN(KOH-IDX)                 
                                            TO WK-TOKUTEI-COMPFTN3      
               END-IF                
               IF ((HKN-HKNKOHSBTKBN     =       "3")    AND
                   (LNK-SYU-KOH-HKNNUM(KOH-IDX)  NOT =  "027")) OR
                  ( LNK-SYU-KOH-HKNNUM(KOH-IDX)  =      "051" ) OR
                  ( HKN-RECEFTNDSPKBN            =      "2"   )
                   CONTINUE
               ELSE
                   COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX) =
                             LNK-SYU-KOH-COMPFTN(KOH-IDX)  +  5
                   COMPUTE   WK-FTN      =
                             LNK-SYU-KOH-COMPFTN(KOH-IDX)  /  10
                   COMPUTE   LNK-SYU-KOH-COMPFTN(KOH-IDX) =  WK-FTN
                                                              *  10
               END-IF
               IF   LNK-S02-KOUREI-NYUIN-KBN     =   "1"                
                IF    LNK-SYU-KOH-HKNNUM(KOH-IDX)  NOT =  "027"         
                  COMPUTE  FTN-KOH-YYY  =  40200  -  FTN-KOH-XXX        
                  IF  LNK-SYU-KOH-COMPFTN(KOH-IDX)  >  FTN-KOH-YYY      
                    MOVE  FTN-KOH-YYY TO  LNK-SYU-KOH-COMPFTN(KOH-IDX)  
                  END-IF                                                
                END-IF                                                  
               END-IF                                              
           END-IF.
           PERFORM    KOHHI-HIKAKU-SEC.
           COMPUTE   LNK-SYU-KOH-COMPTOTAL(KOH-IDX)   =
                     LNK-SYU-KOH-COMPFTN(KOH-IDX).     
           MOVE  WK-NYUSKJRYYKBN    TO  LNK-SYU-SKJ-FTNKBN(KOH-IDX)
           MOVE  WK-SHOKUJI-NISSU   TO  LNK-SYU-SKJ-NISSU(KOH-IDX)
           MOVE  WK-SHOKUJI-RYOYOHI TO  LNK-SYU-SKJ-RYOYOHI(KOH-IDX)
           EVALUATE   WK-NYUSKJRYYKBN
                   WHEN   "1"
                   WHEN   "2"
                   WHEN   "4"
                       MOVE  WK-SHOKUJI-FTN
                                      TO   LNK-SYU-SKJ-FTN(KOH-IDX)
                                           LNK-SYU-SKJ-FTN-RECE(KOH-IDX)
                   WHEN   "3"
                       MOVE  WK-SHOKUJI-FTN
                                      TO   LNK-SYU-SKJ-FTN-RECE(KOH-IDX)
           END-EVALUATE.
      *     
       2304-KOH-KEISAN-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñÃ±°Ì¤Ç·×»»¤·¤¿´µ¼ÔÉéÃ´¶â¤òÈæ³Ó
      ******************************************************************
       KOHHI-HIKAKU-SEC           SECTION.
      *
           EVALUATE    KOH-IDX
               WHEN    2
                   IF  LNK-SYU-KOH-COMPFTN(1) < LNK-SYU-KOH-COMPFTN(2)
                       MOVE  LNK-SYU-KOH-COMPFTN(1)
                                            TO  LNK-SYU-KOH-COMPFTN(2)
                   END-IF
               WHEN    3
                   IF  LNK-SYU-KOH-COMPFTN(2) < LNK-SYU-KOH-COMPFTN(3)
                       MOVE  LNK-SYU-KOH-COMPFTN(2)
                                            TO  LNK-SYU-KOH-COMPFTN(3)
                   END-IF
               WHEN    4
                   IF  LNK-SYU-KOH-COMPFTN(3) < LNK-SYU-KOH-COMPFTN(4)
                       MOVE  LNK-SYU-KOH-COMPFTN(3)
                                            TO  LNK-SYU-KOH-COMPFTN(4)
                   END-IF
           END-EVALUATE.
      *
       KOHHI-HIKAKU-EXT.
           EXIT.
      *
      ******************************************************************
      *        ¸øÈñÃ±°Ì¤Ç·×»»¤·¤¿´µ¼ÔÉéÃ´¶â¤«¤éºÇ¾®¤ÎÃÍ¤òÁªÂò¥»¥Ã¥È
      ******************************************************************
       2314-FTNKIN-HIKAKU-SEC         SECTION.
      *
      *    ÀÁµá³ÛÈæ³Ó
           MOVE    ZERO               TO    WK-KNJFTNKIN.
      *    ¼çÊÝ¸±¤Î¤ß
           IF (COMB-KOH1HKNNUM              =    SPACE)    AND
              (COMB-KOH2HKNNUM              =    SPACE)    AND
              (COMB-KOH3HKNNUM              =    SPACE)    AND
              (COMB-KOH4HKNNUM              =    SPACE)
               MOVE   LNK-SYU-SYUCOMPFTN    TO   WK-KNJFTNKIN
           END-IF.
      *    ¸øÈñ£±¤Î¤ß
           IF (COMB-KOH1HKNNUM              NOT = SPACE)   AND
              (COMB-KOH2HKNNUM              =     SPACE)   AND
              (COMB-KOH3HKNNUM              =     SPACE)   AND
              (COMB-KOH4HKNNUM              =     SPACE)
               MOVE   LNK-SYU-KOH1COMPFTN   TO    WK-KNJFTNKIN
           END-IF.
      *    ¸øÈñ£±¤È¸øÈñ£²
           IF (COMB-KOH1HKNNUM              NOT = SPACE)   AND
              (COMB-KOH2HKNNUM              NOT = SPACE)   AND
              (COMB-KOH3HKNNUM              =     SPACE)   AND
              (COMB-KOH4HKNNUM              =     SPACE)
               MOVE    LNK-SYU-KOH1COMPFTN  TO    WK-KNJFTNKIN
               IF  LNK-SYU-KOH2COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH2COMPFTN TO  WK-KNJFTNKIN
               END-IF
           END-IF.
      *    ¸øÈñ£±¤È¸øÈñ£²¤È¸øÈñ£³
           IF (COMB-KOH1HKNNUM              NOT = SPACE)   AND
              (COMB-KOH2HKNNUM              NOT = SPACE)   AND
              (COMB-KOH3HKNNUM              NOT = SPACE)   AND
              (COMB-KOH4HKNNUM              =     SPACE)
               MOVE    LNK-SYU-KOH1COMPFTN  TO    WK-KNJFTNKIN
               IF  LNK-SYU-KOH2COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH2COMPFTN     TO  WK-KNJFTNKIN
               END-IF
               IF  LNK-SYU-KOH3COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH3COMPFTN TO  WK-KNJFTNKIN
               END-IF
           END-IF.
      *    ¸øÈñ£±¤È¸øÈñ£²¤È¸øÈñ£³¤È¸øÈñ£´
           IF (COMB-KOH1HKNNUM              NOT = SPACE)   AND
              (COMB-KOH2HKNNUM              NOT = SPACE)   AND
              (COMB-KOH3HKNNUM              NOT = SPACE)   AND
              (COMB-KOH4HKNNUM              NOT = SPACE)
               MOVE    LNK-SYU-KOH1COMPFTN  TO    WK-KNJFTNKIN
               IF  LNK-SYU-KOH2COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH2COMPFTN TO  WK-KNJFTNKIN
               END-IF
               IF  LNK-SYU-KOH3COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH3COMPFTN TO  WK-KNJFTNKIN
               END-IF
               IF  LNK-SYU-KOH4COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH4COMPFTN TO  WK-KNJFTNKIN
               END-IF
           END-IF.
      *
           IF   LNK-S02-KOUREI-NYUIN-KBN   =   "1"   
           AND  COMB-KOH1HKNNUM        NOT   =   "027" 
               MOVE    LNK-SYU-SYUCOMPFTN     TO  WK-KNJFTNKIN
               IF   LNK-SYU-KOH1HKNNUM   NOT =  SPACE
               AND  LNK-SYU-KOH1COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH1COMPFTN TO  WK-KNJFTNKIN
               END-IF
               IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
               AND  LNK-SYU-KOH2COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH2COMPFTN TO  WK-KNJFTNKIN
               END-IF
               IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
               AND  LNK-SYU-KOH3COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH3COMPFTN TO  WK-KNJFTNKIN
               END-IF
               IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
               AND  LNK-SYU-KOH4COMPFTN      <     WK-KNJFTNKIN
                   MOVE   LNK-SYU-KOH4COMPFTN TO  WK-KNJFTNKIN
               END-IF
               IF     LNK-SYU-SYUCOMPFTN   =  WK-KNJFTNKIN               
                  IF  LNK-SYU-KOH1HKNNUM   NOT =  SPACE
                    MOVE  LNK-SYU-SYUCOMPFTN   TO   LNK-SYU-KOH1COMPFTN  
                  END-IF
                  IF  LNK-SYU-KOH2HKNNUM   NOT =  SPACE
                    MOVE  LNK-SYU-SYUCOMPFTN   TO   LNK-SYU-KOH2COMPFTN  
                  END-IF
                  IF  LNK-SYU-KOH3HKNNUM   NOT =  SPACE
                    MOVE  LNK-SYU-SYUCOMPFTN   TO   LNK-SYU-KOH3COMPFTN  
                  END-IF
                  IF  LNK-SYU-KOH4HKNNUM   NOT =  SPACE
                    MOVE  LNK-SYU-SYUCOMPFTN   TO   LNK-SYU-KOH4COMPFTN  
                  END-IF
               END-IF                                                    
           END-IF.
      *
      *¿©»öÎÅÍÜÈñÈæ³Ó
           IF  ( COMB-KOH1HKNNUM          =   "027" )  OR
               ( COMB-HKNNUM              =   SPACE ) 
             MOVE        LNK-SYU-KOH1SKJ-RYOYOHI TO  WK-RYOYOHI-SKJ 
             IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH2SKJ-RYOYOHI <  WK-RYOYOHI-SKJ
                   MOVE  LNK-SYU-KOH2SKJ-RYOYOHI TO  WK-RYOYOHI-SKJ
               END-IF
             END-IF
             IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH3SKJ-RYOYOHI <  WK-RYOYOHI-SKJ
                   MOVE  LNK-SYU-KOH3SKJ-RYOYOHI TO  WK-RYOYOHI-SKJ          
               END-IF
             END-IF
             IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH4SKJ-RYOYOHI <  WK-RYOYOHI-SKJ
                   MOVE  LNK-SYU-KOH4SKJ-RYOYOHI TO  WK-RYOYOHI-SKJ          
               END-IF
             END-IF
             MOVE        WK-RYOYOHI-SKJ    TO  LNK-SYU-KOH1SKJ-RYOYOHI
             IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
               MOVE      WK-RYOYOHI-SKJ    TO  LNK-SYU-KOH2SKJ-RYOYOHI
             END-IF
             IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
               MOVE      WK-RYOYOHI-SKJ    TO  LNK-SYU-KOH3SKJ-RYOYOHI
             END-IF
             IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
               MOVE      WK-RYOYOHI-SKJ    TO  LNK-SYU-KOH4SKJ-RYOYOHI
             END-IF
           ELSE
             MOVE        LNK-SYU-SYUSKJ-RYOYOHI  TO  WK-RYOYOHI-SKJ 
             IF   LNK-SYU-KOH1HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH1SKJ-RYOYOHI <  WK-RYOYOHI-SKJ
                   MOVE  LNK-SYU-KOH1SKJ-RYOYOHI TO  WK-RYOYOHI-SKJ
               END-IF 
             END-IF
             IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH2SKJ-RYOYOHI <  WK-RYOYOHI-SKJ
                   MOVE  LNK-SYU-KOH2SKJ-RYOYOHI TO  WK-RYOYOHI-SKJ
               END-IF
             END-IF
             IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH3SKJ-RYOYOHI <  WK-RYOYOHI-SKJ
                   MOVE  LNK-SYU-KOH3SKJ-RYOYOHI TO  WK-RYOYOHI-SKJ
               END-IF
             END-IF 
             IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH4SKJ-RYOYOHI <  WK-RYOYOHI-SKJ
                   MOVE  LNK-SYU-KOH4SKJ-RYOYOHI TO  WK-RYOYOHI-SKJ
               END-IF
             END-IF
             MOVE        WK-RYOYOHI-SKJ    TO  LNK-SYU-SYUSKJ-RYOYOHI
             IF   LNK-SYU-KOH1HKNNUM   NOT =  SPACE
               MOVE      WK-RYOYOHI-SKJ    TO  LNK-SYU-KOH1SKJ-RYOYOHI
             END-IF
             IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
               MOVE      WK-RYOYOHI-SKJ    TO  LNK-SYU-KOH2SKJ-RYOYOHI
             END-IF
             IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
               MOVE      WK-RYOYOHI-SKJ    TO  LNK-SYU-KOH3SKJ-RYOYOHI
             END-IF
             IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
               MOVE      WK-RYOYOHI-SKJ    TO  LNK-SYU-KOH4SKJ-RYOYOHI
             END-IF
           END-IF.
      *
      *¿©»öÉéÃ´³ÛÈæ³Ó
           IF  ( COMB-KOH1HKNNUM          =   "027" )  OR
               ( COMB-HKNNUM              =   SPACE ) 
             MOVE        LNK-SYU-KOH1SKJ-FTN TO  WK-KNJFTNKIN-SKJ 
             IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH2SKJ-FTN <  WK-KNJFTNKIN-SKJ
                   MOVE  LNK-SYU-KOH2SKJ-FTN TO  WK-KNJFTNKIN-SKJ
               END-IF
             END-IF
             IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH3SKJ-FTN <  WK-KNJFTNKIN-SKJ
                   MOVE  LNK-SYU-KOH3SKJ-FTN TO  WK-KNJFTNKIN-SKJ          
               END-IF
             END-IF
             IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH4SKJ-FTN <  WK-KNJFTNKIN-SKJ
                   MOVE  LNK-SYU-KOH4SKJ-FTN TO  WK-KNJFTNKIN-SKJ          
               END-IF
             END-IF
             MOVE        WK-KNJFTNKIN-SKJ       TO  LNK-SYU-KOH1SKJ-FTN
             IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
               MOVE      WK-KNJFTNKIN-SKJ       TO  LNK-SYU-KOH2SKJ-FTN
             END-IF
             IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
               MOVE      WK-KNJFTNKIN-SKJ       TO  LNK-SYU-KOH3SKJ-FTN
             END-IF
             IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
               MOVE      WK-KNJFTNKIN-SKJ       TO  LNK-SYU-KOH4SKJ-FTN
             END-IF
           ELSE
             MOVE        LNK-SYU-SYUSKJ-FTN  TO  WK-KNJFTNKIN-SKJ 
             IF   LNK-SYU-KOH1HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH1SKJ-FTN <  WK-KNJFTNKIN-SKJ
                   MOVE  LNK-SYU-KOH1SKJ-FTN TO  WK-KNJFTNKIN-SKJ
               END-IF 
             END-IF
             IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH2SKJ-FTN <  WK-KNJFTNKIN-SKJ
                   MOVE  LNK-SYU-KOH2SKJ-FTN TO  WK-KNJFTNKIN-SKJ
               END-IF
             END-IF
             IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH3SKJ-FTN <  WK-KNJFTNKIN-SKJ
                   MOVE  LNK-SYU-KOH3SKJ-FTN TO  WK-KNJFTNKIN-SKJ
               END-IF
             END-IF 
             IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
               IF  LNK-SYU-KOH4SKJ-FTN <  WK-KNJFTNKIN-SKJ
                   MOVE  LNK-SYU-KOH4SKJ-FTN TO  WK-KNJFTNKIN-SKJ
               END-IF
             END-IF
             MOVE        WK-KNJFTNKIN-SKJ       TO  LNK-SYU-SYUSKJ-FTN
             IF   LNK-SYU-KOH1HKNNUM   NOT =  SPACE
               MOVE      WK-KNJFTNKIN-SKJ       TO  LNK-SYU-KOH1SKJ-FTN
             END-IF
             IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
               MOVE      WK-KNJFTNKIN-SKJ       TO  LNK-SYU-KOH2SKJ-FTN
             END-IF
             IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
               MOVE      WK-KNJFTNKIN-SKJ       TO  LNK-SYU-KOH3SKJ-FTN
             END-IF
             IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
               MOVE      WK-KNJFTNKIN-SKJ       TO  LNK-SYU-KOH4SKJ-FTN
             END-IF
           END-IF.
      *
      *¿©»öÆü¿ôÈæ³Ó
      *    IF  ( COMB-KOH1HKNNUM          =   "027" )  OR
      *        ( COMB-HKNNUM              =   SPACE ) 
      *      MOVE        LNK-SYU-KOH1SKJ-NISSU TO  WK-NISSU-SKJ 
      *      IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
      *        IF  LNK-SYU-KOH2SKJ-NISSU <  WK-NISSU-SKJ
      *            MOVE  LNK-SYU-KOH2SKJ-NISSU TO  WK-NISSU-SKJ
      *        END-IF
      *      END-IF
      *      IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
      *        IF  LNK-SYU-KOH3SKJ-NISSU <  WK-NISSU-SKJ
      *            MOVE  LNK-SYU-KOH3SKJ-NISSU TO  WK-NISSU-SKJ          
      *        END-IF
      *      END-IF
      *      IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
      *        IF  LNK-SYU-KOH4SKJ-NISSU <  WK-NISSU-SKJ
      *            MOVE  LNK-SYU-KOH4SKJ-NISSU TO  WK-NISSU-SKJ          
      *        END-IF
      *      END-IF
      *      MOVE        WK-NISSU-SKJ       TO  LNK-SYU-KOH1SKJ-NISSU
      *      IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
      *        MOVE      WK-NISSU-SKJ       TO  LNK-SYU-KOH2SKJ-NISSU
      *      END-IF
      *      IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
      *        MOVE      WK-NISSU-SKJ       TO  LNK-SYU-KOH3SKJ-NISSU
      *      END-IF
      *      IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
      *        MOVE      WK-NISSU-SKJ       TO  LNK-SYU-KOH4SKJ-NISSU
      *      END-IF
      *    ELSE
      *      MOVE        LNK-SYU-SYUSKJ-NISSU  TO  WK-NISSU-SKJ 
      *      IF   LNK-SYU-KOH1HKNNUM   NOT =  SPACE
      *        IF  LNK-SYU-KOH1SKJ-NISSU <  WK-NISSU-SKJ
      *            MOVE  LNK-SYU-KOH1SKJ-NISSU TO  WK-NISSU-SKJ
      *        END-IF 
      *      END-IF
      *      IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
      *        IF  LNK-SYU-KOH2SKJ-NISSU <  WK-NISSU-SKJ
      *            MOVE  LNK-SYU-KOH2SKJ-NISSU TO  WK-NISSU-SKJ
      *        END-IF
      *      END-IF
      *      IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
      *        IF  LNK-SYU-KOH3SKJ-NISSU <  WK-NISSU-SKJ
      *            MOVE  LNK-SYU-KOH3SKJ-NISSU TO  WK-NISSU-SKJ
      *        END-IF
      *      END-IF 
      *      IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
      *        IF  LNK-SYU-KOH4SKJ-NISSU <  WK-NISSU-SKJ
      *            MOVE  LNK-SYU-KOH4SKJ-NISSU TO  WK-NISSU-SKJ
      *        END-IF
      *      END-IF
      *      MOVE        WK-NISSU-SKJ       TO  LNK-SYU-SYUSKJ-NISSU
      *      IF   LNK-SYU-KOH1HKNNUM   NOT =  SPACE
      *        MOVE      WK-NISSU-SKJ       TO  LNK-SYU-KOH1SKJ-NISSU
      *      END-IF
      *      IF   LNK-SYU-KOH2HKNNUM   NOT =  SPACE
      *        MOVE      WK-NISSU-SKJ       TO  LNK-SYU-KOH2SKJ-NISSU
      *      END-IF
      *      IF   LNK-SYU-KOH3HKNNUM   NOT =  SPACE
      *        MOVE      WK-NISSU-SKJ       TO  LNK-SYU-KOH3SKJ-NISSU
      *      END-IF
      *      IF   LNK-SYU-KOH4HKNNUM   NOT =  SPACE
      *        MOVE      WK-NISSU-SKJ       TO  LNK-SYU-KOH4SKJ-NISSU
      *      END-IF
      *    END-IF.
      *
      *    ¼ýÇ¼¥Æ¡¼¥Ö¥ë¤ÎÀÁµá³Û¤ò¥»¥Ã¥È
           MOVE    WK-KNJFTNKIN             TO  LNK-SYU-SKYMONEY.
      *    ¿©»öÎÅÍÜÈñ¡¦¿©»öÉéÃ´³Û¤ò¥»¥Ã¥È
           MOVE    WK-RYOYOHI-SKJ           TO  LNK-SYU-RYOYOHI-SKJ.
           MOVE    WK-KNJFTNKIN-SKJ         TO  LNK-SYU-SKYMONEY-SKJ.
           IF   LNK-SYU-SYUSKJ-FTNKBN  =  "4"
             IF    COMB-SYU-HKNKOHSBTKBN  =  "8" 
               IF    COMB-HOJOKBN           =  "1" 
                 CONTINUE
               ELSE
                 COMPUTE LNK-SYU-SKYMONEY-SKJ-TAX 
                                              = LNK-SYU-SKYMONEY-SKJ
                                              * 0.05
               END-IF
             END-IF
           END-IF.
           COMPUTE  LNK-SYU-SKYMONEY-SKJ-KEI = LNK-SYU-SKYMONEY-SKJ
                                             + LNK-SYU-SKYMONEY-SKJ-TAX.
      *    ÆÃÄê¼À´µ¤¬¤¢¤ëÊý¤ÎÆÃÎã½èÍý
           IF  ( LNK-SYU-KOH1HKNNUM    =  "051" )
           OR  ( LNK-SYU-KOH2HKNNUM    =  "051" )
           OR  ( LNK-SYU-KOH3HKNNUM    =  "051" )
           OR  ( LNK-SYU-KOH4HKNNUM    =  "051" )
               COMPUTE   WK-FTN   =   LNK-SYU-SKYMONEY  
                                  +   LNK-SYU-SKYMONEY-SKJ-KEI
               IF        WK-FTN    >  13995
                 COMPUTE  LNK-SYU-SKYMONEY  =  LNK-SYU-SKYMONEY    
                                            +  LNK-SYU-SKYMONEY-SKJ-KEI
                 MOVE      ZERO            TO  LNK-SYU-SKYMONEY-SKJ
                                               LNK-SYU-SKYMONEY-SKJ-TAX
                                               LNK-SYU-SKYMONEY-SKJ-KEI
               END-IF
           END-IF.
      *
           COMPUTE  LNK-SYU-RYOYOHI-SKJ-JIHI  = WK-SHOKUJI-RYOYOHI95
                                              + WK-SHOKUJI-RYOYOHI96.
           COMPUTE  LNK-SYU-SKYMONEY-SKJ-JIHI = WK-SHOKUJI-FTN95
                                              + WK-SHOKUJI-FTN96.
           COMPUTE  LNK-SYU-SKYMONEY-SKJ-JIHI-TAX
                                              = WK-SHOKUJI-FTN96
                                              * 0.05.
           COMPUTE  LNK-SYU-SKYMONEY-SKJ-JIHI-KEI
                                      = LNK-SYU-SKYMONEY-SKJ-JIHI
                                      + LNK-SYU-SKYMONEY-SKJ-JIHI-TAX.
      *
      *    ¼ýÇ¼¥Æ¡¼¥Ö¥ë¤Î¸øÈñËè¤Î´µ¼ÔÉéÃ´¶â³Û¤ò¥»¥Ã¥È¤¹¤ë
           IF   (COMB-KOH1HKNNUM         NOT = SPACE)   AND
                (COMB-KOH1-NYUJGNKBN     =     "1")
               IF   COMB-KOH1-HKNKOHSBTKBN   NOT =    "3"
                    MOVE   WK-KNJFTNKIN  TO  LNK-SYU-KOH1HKNFTNMONEY
               ELSE
                    IF     COMB-KOH1HKNNUM     =    "027"
                        MOVE   LNK-SYU-KOH1COMPFTN
                                         TO  LNK-SYU-KOH1HKNFTNMONEY
                    ELSE
                        MOVE   WK-KNJFTNKIN  TO LNK-SYU-KOH1HKNFTNMONEY
                    END-IF
               END-IF
           END-IF.
           IF   (COMB-KOH2HKNNUM        NOT = SPACE)   AND
                (COMB-KOH2-NYUJGNKBN    =     "1")
               IF   COMB-KOH2-HKNKOHSBTKBN   NOT =    "3"
                    MOVE   WK-KNJFTNKIN  TO  LNK-SYU-KOH2HKNFTNMONEY
               ELSE
                    IF     COMB-KOH2HKNNUM     =    "027"
                        MOVE   LNK-SYU-KOH2COMPFTN
                                         TO  LNK-SYU-KOH2HKNFTNMONEY
                    ELSE
                        MOVE   WK-KNJFTNKIN  TO LNK-SYU-KOH2HKNFTNMONEY
                    END-IF
               END-IF
           END-IF.
           IF   (COMB-KOH3HKNNUM        NOT = SPACE)   AND
                (COMB-KOH3-NYUJGNKBN    =     "1")
               IF   COMB-KOH3-HKNKOHSBTKBN   NOT =    "3"
                    MOVE   WK-KNJFTNKIN  TO  LNK-SYU-KOH3HKNFTNMONEY
               ELSE
                    IF     COMB-KOH3HKNNUM     =    "027"
                        MOVE   LNK-SYU-KOH3COMPFTN
                                         TO  LNK-SYU-KOH3HKNFTNMONEY
                    ELSE
                        MOVE   WK-KNJFTNKIN  TO LNK-SYU-KOH3HKNFTNMONEY
                    END-IF
               END-IF
           END-IF.
           IF   (COMB-KOH4HKNNUM        NOT = SPACE)   AND
                (COMB-KOH4-NYUJGNKBN    =     "1")
               IF   COMB-KOH4-HKNKOHSBTKBN   NOT =    "3"
                    MOVE   WK-KNJFTNKIN  TO  LNK-SYU-KOH4HKNFTNMONEY
               ELSE
                    IF     COMB-KOH4HKNNUM     =    "027"
                        MOVE   LNK-SYU-KOH4COMPFTN
                                         TO  LNK-SYU-KOH4HKNFTNMONEY
                    ELSE
                        MOVE   WK-KNJFTNKIN  TO LNK-SYU-KOH4HKNFTNMONEY
                    END-IF
               END-IF
           END-IF.
      *
       2314-FTNKIN-HIKAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    Ç¯¶âÍúÎòÆÉ¹þ
      *****************************************************************
       TNKRRK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TNKRRK-REC
               MOVE    ZERO            TO  FLG-TNKRRK
           ELSE
               INITIALIZE                  TNKRRK-REC
               MOVE    1               TO  FLG-TNKRRK
           END-IF
      *
           .
       TNKRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    Äã½êÆÀ¼ÔÍúÎòÆÉ¹þ
      *****************************************************************
       TSYRRK-READ-SEC          SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TSYRRK-REC
               MOVE    ZERO            TO  FLG-TSYRRK
           ELSE
               INITIALIZE                  TSYRRK-REC
               MOVE    1               TO  FLG-TSYRRK
           END-IF
      *
           .
       TSYRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÊÝ¸±ÈÖ¹æ¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       HKNNUM-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           .
       HKNNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ÊÝ¸±ÁÈ¹ç¤»¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
               MOVE    ZERO            TO  FLG-HKNCOMBI
           ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
      *
           .
       HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¥·¥¹¥Æ¥à´ÉÍý¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
                                           SYS-1026-REC
                                           SYS-1027-REC
                                           SYS-4001-REC
                                           SYS-5000-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                  SYS-1001-REC
                                           SYS-1026-REC
                                           SYS-1027-REC
                                           SYS-4001-REC
                                           SYS-5000-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       SYSKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    ¼ýÇ¼¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       SYUNOU-READ-SEC          SECTION.
      *
       SYUNOU-READ-100.
      *
           IF  LNK-S02-KOUREI-NYUIN-KBN   =   "1"
               MOVE    "DBFETCH"           TO  MCP-FUNC
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYU-SYUNOU-REC
                   IF     (LNK-S02-SAIKEISAN-KBN    =   "1")    AND
                          (LNK-S02-SAIKEISAN-DENPYO =   SYU-DENPNUM)
                           GO    TO    SYUNOU-READ-100
                   ELSE
                           MOVE    ZERO    TO  FLG-SYUNOU
                   END-IF
               ELSE
                   INITIALIZE                  SYU-SYUNOU-REC
                   MOVE    1               TO  FLG-SYUNOU
               END-IF
           ELSE
               MOVE    "DBFETCH"           TO  MCP-FUNC
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYU-SYUNOU-REC
                   IF     (LNK-S02-SAIKEISAN-KBN    =   "1")    AND
                          (LNK-S02-SAIKEISAN-DENPYO <=   SYU-DENPNUM)
                           GO    TO    SYUNOU-READ-100
                   ELSE
                           MOVE    ZERO    TO  FLG-SYUNOU
                   END-IF
               ELSE
                   INITIALIZE                  SYU-SYUNOU-REC
                   MOVE    1               TO  FLG-SYUNOU
               END-IF
           END-IF.
      *
       SYUNOU-READ-EXT.
           EXIT.
      
      *****************************************************************
      *    ´µ¼Ô¾ðÊóÆÉ¹þ
      *****************************************************************
       PTINF-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTINF-REC
               MOVE    ZERO            TO  FLG-PTINF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    Æþ±¡²ñ·×¥Þ¥¹¥¿¡¼ÆÉ¹þ
      *****************************************************************
       NYUINACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                  NYUINACCT-REC
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           .
       NYUINACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ¿ÇÎÅ²ñ·×ÆÉ¹þ
      *****************************************************************
       SRYACCT-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
               MOVE    ZERO            TO  FLG-SRYACCT
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           .
       SRYACCT-READ-EXT.
           EXIT.
      *
